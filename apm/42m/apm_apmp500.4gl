#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-08-20 18:02:01), PR版次:0007(2016-05-31 18:07:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000188
#+ Filename...: apmp500
#+ Description: 採購單自動結案作業
#+ Creator....: 02040(2014-03-11 11:03:29)
#+ Modifier...: 02040 -SD/PR- 02040
 
{</section>}
 
{<section id="apmp500.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150908-00001#1  15/09/29  By Alberti  批次作業條件不可為空，取消訂單單號必須為必輸
#160523-00018#4  16/05/31  By Polly    增加多角控卡；結案/取消結案需一併調整多角單據
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
       pmdldocno LIKE type_t.chr20, 
   pmdldocdt LIKE type_t.dat, 
   pmdl004 LIKE type_t.chr10, 
   pmdl002 LIKE type_t.chr20, 
   pmdl003 LIKE type_t.chr10, 
   pmdn001 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_pmdl DYNAMIC ARRAY OF RECORD
       pmdldocno LIKE pmdl_t.pmdldocno
    END RECORD     
DEFINE g_success   LIKE type_t.num5

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp500.main" >}
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
      CALL apmp500_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp500 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp500_init()
 
      #進入選單 Menu (="N")
      CALL apmp500_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp500
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp500.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp500_init()
 
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
 
{<section id="apmp500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp500_ui_dialog()
 
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
        #CONSTRUCT BY NAME lc_param.wc ON pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003,pmdn001 #150908-00001#1 mark
         CONSTRUCT BY NAME g_master.wc ON pmdldocno,pmdldocdt,pmdl004,pmdl002,pmdl003,pmdn001 #150908-00001#1 add
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            ON ACTION controlp INFIELD pmdldocno            #請購單單號
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = " pmdlstus = 'Y' "
                CALL q_pmdldocno()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdldocno      #顯示到畫面上
                NEXT FIELD pmdldocno                         #返回原欄位

            ON ACTION controlp INFIELD pmdl004            #供應商
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_3()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmdl004      #顯示到畫面上
               NEXT FIELD pmdl004                         #返回原欄位 
 
            ON ACTION controlp INFIELD pmdl002            #採購人員
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooag001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdl002      #顯示到畫面上
                NEXT FIELD pmdl002                         #返回原欄位              

            ON ACTION controlp INFIELD pmdl003            #採購部門
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_ooeg001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdl003      #顯示到畫面上
                NEXT FIELD pmdl003                         #返回原欄位   
                
            ON ACTION controlp INFIELD pmdn001             #料件編號
               #開窗c段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_imaa001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO pmdn001      #顯示到畫面上
                NEXT FIELD pmdn001                         #返回原欄位 
                
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
            CALL apmp500_get_buffer(l_dialog)
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
         CALL apmp500_init()
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
                 CALL apmp500_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp500_transfer_argv(ls_js)
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
 
{<section id="apmp500.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp500_transfer_argv(ls_js)
 
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
 
{<section id="apmp500.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp500_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE i           LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_cnt		 LIKE type_t.num5       
   DEFINE l_no_cnt	 LIKE type_t.num5    
   DEFINE l_no_cnt2   LIKE type_t.num5      
   DEFINE l_msg       STRING
   DEFINE l_pmdndocno LIKE pmdn_t.pmdndocno
   DEFINE l_pmdnseq   LIKE pmdn_t.pmdnseq   
   DEFINE l_pmdl006   LIKE pmdl_t.pmdl006    #多角性質
   DEFINE l_pmdl031   LIKE pmdl_t.pmdl031    #多角來源單號
   DEFINE l_pmdl051   LIKE pmdl_t.pmdl051    #多角流程代碼
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_cnt = 1
   LET ls_sql = "SELECT DISTINCT pmdldocno FROM pmdn_t,pmdl_t ",
                " WHERE pmdndocno = pmdldocno ",
                "   AND pmdlent = '",g_enterprise,"'",
                "   AND pmdlsite = '",g_site,"'",
                "   AND pmdlstus = 'Y' ",
                "   AND pmdl006 <> '6' ",             #160523-00018#4 排除中間交易 
                "   AND ",lc_param.wc          
   PREPARE apmp500_sel_pr FROM ls_sql
   DECLARE apmp500_sel_cs CURSOR FOR apmp500_sel_pr  
   FOREACH apmp500_sel_cs INTO g_pmdl[l_cnt].*
     IF SQLCA.sqlcode THEN       
        EXIT FOREACH
     END IF
    #160523-00018#4-s-add 
     IF NOT s_apmp510_pmdldocno_chk(g_pmdl[l_cnt].pmdldocno) THEN
        CONTINUE FOREACH
     END IF
     IF NOT s_apmp510_aic_chk(g_pmdl[l_cnt].pmdldocno) THEN
        CONTINUE FOREACH
     END IF     
    #160523-00018#4-e-add     
     LET l_cnt = l_cnt + 1
   END FOREACH   
   CALL g_pmdl.deleteelement(l_cnt)
   LET l_cnt = l_cnt - 1      

   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET li_count = l_cnt * 4  
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp500_process_cs CURSOR FROM ls_sql
#  FOREACH apmp500_process_cs INTO
   #add-point:process段process name="process.process"

   LET g_success = TRUE 
   CALL cl_showmsg_init()
   LET l_no_cnt = 0 
   IF l_cnt > 0 THEN                    
      FOR i = 1 TO l_cnt
          IF g_bgjob <> "Y" THEN
             LET l_msg = cl_getmsg_parm("apm-00402", g_lang,g_pmdl[i].pmdldocno )   
             CALL cl_progress_no_window_ing(l_msg)
          END IF  
         #160523-00018#4-s-mark 
         ##160422-00027 by whitney add start
         #IF NOT s_apmp510_pmdldocno_chk(g_pmdl[i].pmdldocno) THEN
         #   CONTINUE FOR
         #END IF
         ##160422-00027 by hitney add end
         #160523-00018#4-s-mark 
          LET l_no_cnt2 = 0
         #160523-00018#4-s-mark  
         ##若為銷售多角，需做各據點多角結案
         #LET l_pmdl006 = ''
         #LET l_pmdl031 = ''
         #LET l_pmdl051 = ''
         #SELECT pmdl006,pmdl031,pmdl051
         #  INTO l_pmdl006,l_pmdl031,l_pmdl051
         #  FROM pmdl_t
         # WHERE pmdlent = g_enterprise
         #   AND pmdlsite = g_site
         #   AND pmdldocno = g_pmdl[i].pmdldocno          
         #160523-00018#4-e-mark 
          CALL s_transaction_begin()          
          
          #抓取單身資料                                                        
          LET l_sql = "SELECT DISTINCT pmdndocno,pmdnseq FROM pmdn_t,pmdl_t ",
                      " WHERE pmdndocno = pmdldocno ",
                      "   AND pmdlent = '",g_enterprise,"'",
                      "   AND pmdlsite = '",g_site,"'",
                      "   AND pmdlstus = 'Y' ",
                      "   AND pmdndocno = '",g_pmdl[i].pmdldocno,"'",
                      "   AND ",lc_param.wc          
          PREPARE apmp500_sel_pr2 FROM l_sql
          DECLARE apmp500_sel_cs2 CURSOR FOR apmp500_sel_pr2  
          FOREACH apmp500_sel_cs2 INTO l_pmdndocno,l_pmdnseq
            IF SQLCA.sqlcode THEN
               EXIT FOREACH
            END IF
            #單身狀態結案
            IF NOT s_apmp510_pmdn045_closed('1',l_pmdndocno,l_pmdnseq,'',g_site) THEN
               LET l_no_cnt2 = l_no_cnt2 + 1
           #160523-00018#4-s-mark 
           #ELSE
           #   #多角結案(單身狀態)
           #   IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN                     
           #      CALL apmp500_aic_closed(l_pmdnseq,l_pmdl031,l_pmdl051)
           #   END IF
           #160523-00018#4-e-mark 
            END IF
          END FOREACH  
          #物流結案            
          IF NOT s_apmp510_pmdl047_closed(g_pmdl[i].pmdldocno,g_site) THEN                
             LET l_no_cnt = l_no_cnt + 1   #151105 Sarah mod l_no_cnt2->l_no_cnt
          END IF
          IF l_no_cnt = 0 THEN   #151105 Sarah mod l_no_cnt2->l_no_cnt                                                                  
             CALL s_transaction_end("Y","0")                                                  
          ELSE                                                                                
             CALL s_transaction_end("N","0")
             LET l_no_cnt = l_no_cnt + 1
          END IF
          
          #帳流結案
          IF g_bgjob <> "Y" THEN
             LET l_msg = cl_getmsg_parm("apm-00403", g_lang,g_pmdl[i].pmdldocno )  
             CALL cl_progress_no_window_ing(l_msg)
          END IF          
          CALL s_transaction_begin()         
          IF NOT s_apmp510_pmdl048_closed(g_pmdl[i].pmdldocno,g_site) THEN    
             CALL s_transaction_end('N','0')
             LET l_no_cnt = l_no_cnt + 1
          ELSE
             CALL s_transaction_end('Y','0')
          END IF
          #金流結案
          IF g_bgjob <> "Y" THEN
             LET l_msg = cl_getmsg_parm("apm-00404", g_lang,g_pmdl[i].pmdldocno )  
             CALL cl_progress_no_window_ing(l_msg)
          END IF  
          CALL s_transaction_begin()          
          IF NOT s_apmp510_pmdl049_closed(g_pmdl[i].pmdldocno,g_site) THEN     
             CALL s_transaction_end('N','0')
             LET l_no_cnt = l_no_cnt + 1
          ELSE
             CALL s_transaction_end('Y','0')
          END IF      
          #狀態結案
          IF g_bgjob <> "Y" THEN
             LET l_msg = cl_getmsg_parm("apm-00405", g_lang,g_pmdl[i].pmdldocno )  
             CALL cl_progress_no_window_ing(l_msg)
          END IF  
          CALL s_transaction_begin()          
          IF NOT s_apmp510_pmdlstus_closed('2',g_pmdl[i].pmdldocno,g_site) THEN   #151105 Sarah mod '1'->'2'
             CALL s_transaction_end('N','0')
             LET l_no_cnt = l_no_cnt + 1
          ELSE
             CALL s_transaction_end('Y','0')
          END IF 
          #160523-00018#4-s-mark  
          ##多角結案(物流、帳流、金流、狀態)
          #IF l_pmdl006 = '2' AND NOT cl_null(l_pmdl031) THEN
          #   CALL apmp500_aic_closed(0,l_pmdl031,l_pmdl051)
          #END IF          
          #160523-00018#4-e-mark 
      END FOR
   END IF
   IF l_no_cnt > 0 THEN    
      CALL cl_showmsg()
   END IF 
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF l_cnt = 0 THEN
         CALL cl_ask_confirm3("afa-00067","")
         RETURN
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      IF cl_chk_process_exists(g_parentsession,g_account) THEN
         CALL cl_ask_confirm("std-00012") RETURNING li_stus
      END IF     
      DISPLAY "!!!!程序已完成!!!"
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apmp500_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp500.get_buffer" >}
PRIVATE FUNCTION apmp500_get_buffer(p_dialog)
 
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
 
{<section id="apmp500.msgcentre_notify" >}
PRIVATE FUNCTION apmp500_msgcentre_notify()
 
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
 
{<section id="apmp500.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 多角結案
# Memo...........:
# Usage..........: CALL apmp500_aic_closed(p_pmdnseq,p_pmdl031,p_pmdl051)

# Input parameter: p_pmdnseq      請購單項次
#                : p_pmdl031      多角來源單號
#                : p_pmdn050      多角流程式碼
# Return code....: 
# Date & Author..: 2014/08/20 By Polly
# Modify.........: 160523-00018#4 By Polly 移至s_apmp510處理
################################################################################
PRIVATE FUNCTION apmp500_aic_closed(p_pmdnseq,p_pmdl031,p_pmdl051)
   DEFINE p_pmdnseq   LIKE pmdn_t.pmdnseq       #請購單項次
   DEFINE p_pmdl031   LIKE pmdl_t.pmdl031       #多角來源單號
   DEFINE p_pmdl051   LIKE pmdl_t.pmdl051       #多角流程代碼
   DEFINE l_icab003   LIKE icab_t.icab003       #多角營運據點
   DEFINE l_pmdldocno LIKE pmdl_t.pmdldocno     #採購單單號
   DEFINE l_sfaadocno LIKE sfaa_t.sfaadocno     #工單單號
   DEFINE l_xmdadocno LIKE xmda_t.xmdadocno     #訂單單號
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.num5
   

   LET l_sql = "SELECT icab003 ",
               "  FROM icaa_t,icab_t ",
               " WHERE icaaent = '",g_enterprise,"' " ,
               "   AND icaa001 = '",p_pmdl051,"' " ,
               "   AND icaa001 = icab001 "

   PREPARE apmp500_sel_pr_aic FROM l_sql
   DECLARE apmp500_sel_cs_aic CURSOR FOR apmp500_sel_pr_aic

   #各站營運據點依多角流程序號取得各站 請購單/採購單/工單 單號做結案
   FOREACH apmp500_sel_cs_aic INTO l_icab003
     #訂單單號
     LET l_xmdadocno = ''
     SELECT xmdadocno INTO l_xmdadocno
       FROM xmda_t
      WHERE xmdaent = g_enterprise
        AND xmdasite = l_icab003
        AND xmda031 = p_pmdl031
     IF NOT cl_null(l_xmdadocno) THEN
        IF p_pmdnseq = 0 THEN   
           CALL s_axmp510_xmda045_closed(l_xmdadocno,l_icab003) RETURNING l_success
           CALL s_axmp510_xmda046_closed(l_xmdadocno,l_icab003) RETURNING l_success
           CALL s_axmp510_xmda047_closed(l_xmdadocno,l_icab003) RETURNING l_success
           CALL s_axmp510_xmdastus_closed('2',l_xmdadocno,l_icab003) RETURNING l_success   #151105 Sarah mod '1'->'2'
        ELSE                              
           CALL s_axmp510_xmdc045_closed('1',l_xmdadocno,p_pmdnseq,'',l_icab003) RETURNING l_success
        END IF                              
     END IF                       
     #採購單單號
     LET l_pmdldocno = ''
     SELECT pmdldocno INTO l_pmdldocno
       FROM pmdl_t
      WHERE pmdlent = g_enterprise
        AND pmdlsite = l_icab003
        AND pmdl031 = p_pmdl031
     IF NOT cl_null(l_pmdldocno) THEN
        IF p_pmdnseq = 0 THEN
           CALL s_apmp510_pmdl047_closed(l_pmdldocno,l_icab003) RETURNING l_success
           CALL s_apmp510_pmdl048_closed(l_pmdldocno,l_icab003) RETURNING l_success
           CALL s_apmp510_pmdl049_closed(l_pmdldocno,l_icab003) RETURNING l_success
           CALL s_apmp510_pmdlstus_closed('2',l_pmdldocno,l_icab003) RETURNING l_success   #151105 Sarah mod '1'->'2'
        ELSE
           CALL s_apmp510_pmdn045_closed('1',l_pmdldocno,p_pmdnseq,'',l_icab003) RETURNING l_success
        END IF  
     END IF
     ##工單單號
     #LET l_sfaadocno = ''
     #SELECT sfaadocno INTO l_sfaadocno
     #  FROM sfaa_t
     # WHERE sfaaent = g_enterprise
     #   AND sfaasite = l_icab003
     #   AND sfaa067 = p_pmdl031
     #IF NOT cl_null(l_sfaadocno) THEN
     #   #CALL s_asfp500_close_wo    工单结案
     #END IF                    
   END FOREACH   
END FUNCTION

#end add-point
 
{</section>}
 
