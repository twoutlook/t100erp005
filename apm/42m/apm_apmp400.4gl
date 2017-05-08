#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-12-19 11:46:54), PR版次:0004(2016-09-05 18:54:38)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000182
#+ Filename...: apmp400
#+ Description: 請購單自動結案作業
#+ Creator....: 02040(2014-03-05 11:10:07)
#+ Modifier...: 02040 -SD/PR- 01727
 
{</section>}
 
{<section id="apmp400.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00005#35 2016/03/28  By 07900   重复错误信息修改
#160330-00012#1  2016/04/01  By catmoon 將CALL cl_progress_no_window_ing(參數)參數有中文的情形改由變數帶入
#160905-00007#11 2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
   DEFINE g_chk_jobid          LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
         
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmdadocno LIKE pmda_t.pmdadocno, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda003 LIKE pmda_t.pmda003, 
   pmdb004 LIKE pmdb_t.pmdb004,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_pmdb DYNAMIC ARRAY OF RECORD
       pmdbdocno LIKE pmdb_t.pmdbdocno,
       pmdbseq LIKE pmdb_t.pmdbseq
    END RECORD 

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp400.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
         
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   display "g_argv[1]",g_argv[1]
   LET lc_param.wc = DOWNSHIFT(g_argv[1])
   LET ls_js = util.JSON.stringify(lc_param)  
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
                  
      #end add-point
      CALL apmp400_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp400 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp400_init()
 
      #進入選單 Menu (="N")
      CALL apmp400_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
                  
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp400
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp400.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp400_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
         
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化 name="init.init"
         
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp400_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
         
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
        #CONSTRUCT BY NAME lc_param.wc ON pmdadocno,pmdadocdt,pmda002,pmda003,pmdb004     #160321-00033 mark
         CONSTRUCT BY NAME g_master.wc ON pmdadocno,pmdadocdt,pmda002,pmda003,pmdb004     #160321-00033 add
            BEFORE CONSTRUCT
               CALL cl_qbe_init()

               
            ON ACTION controlp INFIELD pmdadocno
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " pmdastus = 'Y' "  
                CALL q_pmdadocno()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdadocno      #顯示到畫面上
                NEXT FIELD pmdadocno                         #返回原欄位

            ON ACTION controlp INFIELD pmda002
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmda002      #顯示到畫面上
               NEXT FIELD pmda002                         #返回原欄位 
 
            ON ACTION controlp INFIELD pmda003
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmda003      #顯示到畫面上
                NEXT FIELD pmda003                         #返回原欄位              

            ON ACTION controlp INFIELD pmdb004
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_imaa001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdb004      #顯示到畫面上
                NEXT FIELD pmdb004                         #返回原欄位 
                
         END CONSTRUCT             
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
                           
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                           
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apmp400_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         
         #end add-point
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear name="ui_dialog.qbeclear"
            
            #end add-point
 
         ON ACTION history_fill
            CALL cl_schedule_history_fill()
 
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
         
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM   
         INITIALIZE g_master.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL apmp400_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
     
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      END IF      
      IF lc_param.wc = ' 1=1' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00379'
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CONTINUE WHILE
      ELSE
         LET g_bgjob = "N"      
      END IF
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)  #r類使用g_master/p類使用lc_param
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
 
         #依照指定模式執行報表列印
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL apmp400_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp400_transfer_argv(ls_js)
                 CALL cl_cmdrun(ls_js)
 
            WHEN g_schedule.gzpa003 = "2"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
 
            WHEN g_schedule.gzpa003 = "3"
                 CALL cl_schedule_update_data(g_jobid,ls_js)
         END CASE  
 
         IF g_schedule.gzpa003 = "2" OR g_schedule.gzpa003 = "3" THEN 
            CALL cl_ask_confirm3("std-00014","") #設定完成
         END IF    
         LET g_schedule.gzpa003 = "0" #預設一開始 立即於前景執行
 
         #add-point:ui_dialog段after schedule name="process.after_schedule"
         
         #end add-point
 
         #欄位初始資訊 
         CALL cl_schedule_init_info("all",g_schedule.gzpa003) 
         LET gi_hiden_asign = FALSE 
         LET gi_hiden_exec = FALSE 
         LET gi_hiden_spec = FALSE 
         LET gi_hiden_exec_end = FALSE 
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="apmp400.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp400_transfer_argv(ls_js)
 
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define name="transfer_agrv.define"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
      LET la_cmdrun.param[1] = la_param.wc   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apmp400.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp400_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql       STRING
   DEFINE l_cnt		  LIKE type_t.num5
   DEFINE l_cnt2	  LIKE type_t.num5   
   DEFINE l_sum		  LIKE type_t.num5   
   DEFINE l_pmdb006   LIKE pmdb_t.pmdb006     #需求量
   DEFINE l_pmdb032   LIKE pmdb_t.pmdb032     #行狀態
   DEFINE l_pmdb049   LIKE pmdb_t.pmdb049     #已轉採購量 
   DEFINE i           LIKE type_t.num5
   DEFINE ls_info     STRING              #160330-00012#1 add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_cnt2 = 1   
   LET ls_sql = "SELECT pmdbdocno,pmdbseq FROM pmdb_t,pmda_t ",
                 " WHERE pmdbdocno = pmdadocno ",
                 "   AND pmdbent = '",g_enterprise,"'",
                 "   AND pmdastus = 'Y' ",
                 "   AND pmdb032 = '1' ",
                 "   AND pmdb006 <= pmdb049 ",               
                 "   AND ",lc_param.wc   
   PREPARE apmp400_process_pr FROM ls_sql
   DECLARE apmp400_process_cs CURSOR FOR apmp400_process_pr  
   
   FOREACH apmp400_process_cs INTO g_pmdb[l_cnt2].*
     IF SQLCA.sqlcode THEN
        EXIT FOREACH
     ELSE
        LET l_cnt2 = l_cnt2 + 1
     END IF
   END FOREACH   
   CALL g_pmdb.deleteelement(l_cnt2)
   LET l_cnt2 = l_cnt2 - 1         
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = l_cnt2   
      CALL cl_progress_bar_no_window(li_count)      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp400_process_cs CURSOR FROM ls_sql
#  FOREACH apmp400_process_cs INTO
   #add-point:process段process name="process.process"
   IF l_cnt2 > 0 THEN
      FOR i = 1 TO l_cnt2
          IF g_bgjob <> "Y" THEN
            #CALL cl_progress_no_window_ing("讀取"||g_pmdb[i].pmdbdocno||"基本資料")  #160330-00012#1 mark
             LET ls_info = cl_getmsg_parm("azz-01004",g_lang,g_pmdb[i].pmdbdocno)    #160330-00012#1 add
             CALL cl_progress_no_window_ing(ls_info)                                 #160330-00012#1 add
          END IF      
          CALL s_transaction_begin()
          LET l_sum = 0
          SELECT pmdb006,pmdb049,pmdb032 
            INTO l_pmdb006,l_pmdb049,l_pmdb032
            FROM pmdb_t 
           WHERE pmdbdocno = g_pmdb[i].pmdbdocno 
             AND pmdbent = g_enterprise   #160905-00007#11 Add
             AND pmdbseq = g_pmdb[i].pmdbseq
          LET l_sum = l_pmdb006 - l_pmdb049
          IF l_sum > 0 THEN
          ELSE
             IF l_sum = 0 THEN                     #需求量 = 已轉採購量
                UPDATE pmdb_t
                   SET pmdb032 = '2'               #正常結案
                 WHERE pmdbdocno = g_pmdb[i].pmdbdocno
                   AND pmdbseq = g_pmdb[i].pmdbseq      
                   AND pmdbent = g_enterprise   #160905-00007#11 Add                   
             ELSE
                IF l_sum < 0 THEN
              　　  UPDATE pmdb_t
                  　　 SET pmdb032 = '3'               #長結
                　　 WHERE pmdbdocno = g_pmdb[i].pmdbdocno
                   　　AND pmdbseq = g_pmdb[i].pmdbseq    
                       AND pmdbent = g_enterprise   #160905-00007#11 Add
                END IF
             END IF
             
             IF SQLCA.sqlcode THEN                          
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = SQLCA.sqlcode
                LET g_errparam.extend = "update pmdb032"
                LET g_errparam.popup = TRUE
                CALL cl_err()

                CALL s_transaction_end('N','0')
                CONTINUE FOR
             ELSE
                CALL s_transaction_end('Y','0')
             END IF   
             LET l_cnt = 0
             SELECT COUNT(*) INTO l_cnt FROM pmdb_t     
              WHERE pmdbdocno = g_pmdb[i].pmdbdocno
                AND pmdb032 = '1' 
                AND pmdbent = g_enterprise   #160905-00007#11 Add
             IF l_cnt = 0 THEN                       #請購單之所有單身皆已結案，則更新[T.請購單單頭].[C.狀態]='C'
                UPDATE pmda_t
                   SET pmdastus = 'C'
                 WHERE pmdadocno = g_pmdb[i].pmdbdocno
                   AND pmdaent = g_enterprise   #160905-00007#11 Add
                IF SQLCA.sqlcode THEN                          
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = SQLCA.sqlcode
                   LET g_errparam.extend = "update pmdastus"
                   LET g_errparam.popup = TRUE
                   CALL cl_err()

                   CALL s_transaction_end('N','0')
                ELSE
                   CALL s_transaction_end('Y','0')
                END IF
             END IF                                               
             
          END IF
          
      END FOR
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-01321'  #apm-00294  #160318-00005#35   By 07900--mod
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
          #無合呼條件
      CALL s_transaction_end("N","0")
   END IF
   CLEAR FORM                
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
                  
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      IF cl_chk_process_exists(g_parentsession,g_account) THEN
            CALL cl_ask_confirm("std-00012") RETURNING li_stus
      END IF
     #DISPLAY "!!!!程序已完成!!!"                    #160330-00012#1 mark
      DISPLAY cl_getmsg_parm("azz-01007",g_lang,'') #160330-00012#1 add  
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apmp400_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp400.get_buffer" >}
PRIVATE FUNCTION apmp400_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmp400.msgcentre_notify" >}
PRIVATE FUNCTION apmp400_msgcentre_notify()
 
   #add-point:process段define (客製用) name="msgcentre_notify.define_customerization"
   
   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define name="msgcentre_notify.define"
   
   #end add-point
 
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = "process"
 
   #add-point:msgcentre其他通知 name="msg_centre.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
