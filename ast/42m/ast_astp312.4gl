#該程式未解開Section, 採用最新樣板產出!
{<section id="astp312.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-12-21 09:35:10), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000032
#+ Filename...: astp312
#+ Description: 補差單批量產生作業
#+ Creator....: 03247(2015-12-18 15:59:36)
#+ Modifier...: 03247 -SD/PR- 00000
 
{</section>}
 
{<section id="astp312.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
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
        prgadocdt        LIKE prga_t.prgadocdt,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       prbgsite LIKE type_t.chr10, 
   prgadocdt LIKE type_t.dat, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp312.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_aooi500_create_temp() RETURNING l_success
      #end add-point
      CALL astp312_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp312 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp312_init()
 
      #進入選單 Menu (="N")
      CALL astp312_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp312
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp312.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp312_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success     LIKE type_t.num5
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
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp312.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp312_ui_dialog()
 
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
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.prgadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prgadocdt
            #add-point:BEFORE FIELD prgadocdt name="input.b.prgadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prgadocdt
            
            #add-point:AFTER FIELD prgadocdt name="input.a.prgadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prgadocdt
            #add-point:ON CHANGE prgadocdt name="input.g.prgadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.prgadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prgadocdt
            #add-point:ON ACTION controlp INFIELD prgadocdt name="input.c.prgadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON prbgsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.prbgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbgsite
            #add-point:ON ACTION controlp INFIELD prbgsite name="construct.c.prbgsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbgsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbgsite  #顯示到畫面上
            NEXT FIELD prbgsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbgsite
            #add-point:BEFORE FIELD prbgsite name="construct.b.prbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbgsite
            
            #add-point:AFTER FIELD prbgsite name="construct.a.prbgsite"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
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
            CALL astp312_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.prgadocdt = g_today - 1
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
         CALL astp312_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.prgadocdt = g_master.prgadocdt
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
                 CALL astp312_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp312_transfer_argv(ls_js)
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
 
{<section id="astp312.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp312_transfer_argv(ls_js)
 
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
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="astp312.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp312_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_where       STRING
   DEFINE l_sql         STRING
   DEFINE l_sql1        STRING
   DEFINE l_wc          STRING
   DEFINE l_stbhdocno   LIKE stbh_t.stbhdocno
   DEFINE l_success     LIKE type_t.num5
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_prgadocno   LIKE prga_t.prgadocno
   DEFINE l_prgadocdt   LIKE prga_t.prgadocdt
   DEFINE l_prga001     LIKE prga_t.prga001
   DEFINE l_prgbseq     LIKE prgb_t.prgbseq
   DEFINE r_prgb014     LIKE prgb_t.prgb014
   DEFINE r_prgb018     LIKE prgb_t.prgb018
   DEFINE l_prgb014     LIKE prgb_t.prgb014
   DEFINE l_prgb018     LIKE prgb_t.prgb018
   DEFINE r_docno       LIKE type_t.chr80
   DEFINE l_wc1         STRING
   DEFINE l_total       LIKE prgb_t.prgb018
   DEFINE l_msg         STRING                #160225-00040#16 20160303 add by beckxie
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = " 1=1"
   END IF
   IF cl_null(lc_param.prgadocdt) THEN
      LET lc_param.prgadocdt = g_today - 1
   END IF
   LET l_where = s_aooi500_q_where(g_prog,'prgasite',g_site,'c')
   LET l_where = cl_replace_str(l_where,'ooef001','prgasite')
   DISPLAY "l_where:",l_where
   LET lc_param.wc = lc_param.wc," AND ",l_where
   LET l_wc1 = cl_replace_str(lc_param.wc,'prgasite','stbisite')
   LET l_wc1 = cl_replace_str(l_wc1,'prbgsite','stbisite')    #add by yangxf 20151229
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(4)   #160225-00040#16 20160303 add by beckxie
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp312_process_cs CURSOR FROM ls_sql
#  FOREACH astp312_process_cs INTO
   #add-point:process段process name="process.process"
   CALL cl_err_collect_init()
   #160225-00040#16 20160303 add by beckxie---S
   LET l_msg = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160303 add by beckxie---E
   #抓取促銷協議補差計算日期小於等於畫面日期且補差計算狀態爲1.未計算的資料
   LET l_sql = " SELECT DISTINCT stbhdocno FROM stbh_t,stbi_t ",
               "  WHERE stbhent = ",g_enterprise," ",
               "    AND stbhent = stbient AND stbhdocno = stbidocno ",
               "    AND stbhstus = 'Y' ",
               "    AND stbi028 <= '",lc_param.prgadocdt,"' ",
               "    AND stbi025 IN ('1','3') ",
               "    AND stbi029 = '1' ",
               "    AND ",l_wc1
   PREPARE sel_stbh_pre FROM l_sql
   DECLARE sel_stbh_cs  CURSOR WITH HOLD FOR sel_stbh_pre
   #160225-00040#16 20160303 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160303 add by beckxie---E
   FOREACH sel_stbh_cs  INTO l_stbhdocno
      CALL s_transaction_begin()
      #产生补差单
      CALL s_aprt601_ins('3',l_stbhdocno) RETURNING r_success
      IF NOT r_success THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      ELSE
         #更新促销协议补差计算状态为2.已计算
         UPDATE stbi_t SET stbi029 = '2'
          WHERE stbient = g_enterprise
            AND stbidocno = l_stbhdocno
            AND stbi028 <= g_today
            AND stbi025 IN ('1','3')
            AND stbi029 = '1'
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPD stbi_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH
         END IF
      END IF
      CALL s_transaction_end('Y','0')
      DISPLAY '促销协议:',l_stbhdocno
   END FOREACH
   LET l_wc1 = cl_replace_str(l_wc1,'stbisite','prgasite')    #add by yangxf 20151229
   #抓取已审核未计算补差的补差单
   LET l_sql = " SELECT DISTINCT prgadocno,prgadocdt,prga001 FROM prga_t ",
               "  WHERE prgaent = ",g_enterprise," ",
               "    AND prgastus = 'Y' ",
               "    AND prga016 = 'N' ",
               "    AND prga010 <= '",lc_param.prgadocdt,"' ",
               "    AND prga001 IN ('1','3') ",
               "    AND ",l_wc1
   PREPARE sel_prga_pre FROM l_sql
   DECLARE sel_prga_cs  CURSOR WITH HOLD FOR sel_prga_pre
   #160225-00040#16 20160303 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160303 add by beckxie---E
   FOREACH sel_prga_cs  INTO l_prgadocno,l_prgadocdt,l_prga001
      DISPLAY '补差单:',l_stbhdocno,'--',l_prga001
      CALL s_transaction_begin()
      LET r_success = TRUE
      LET l_sql1 = " SELECT DISTINCT prgbseq FROM prgb_t ",
                   "  WHERE prgbent = ",g_enterprise," ",
                   "    AND prgbdocno = '",l_prgadocno,"' "
      PREPARE sel_prgb_pre FROM l_sql1
      DECLARE sel_prgb_cs  CURSOR WITH HOLD FOR sel_prgb_pre
      FOREACH sel_prgb_cs  INTO l_prgbseq
         CALL s_astp312_get_prgb014('1',l_prgadocno,l_prgbseq,'','','','','') RETURNING r_prgb014,r_prgb018
         UPDATE prgb_t SET prgb014 = r_prgb014,
                           prgb018 = r_prgb018
          WHERE prgbent = g_enterprise
            AND prgbdocno = l_prgadocno
            AND prgbseq = l_prgbseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'UPD prgb_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END FOREACH
      IF NOT r_success THEN
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH      
      END IF
      #add by yangxf 20151230---start---
      SELECT SUM(prgb018) INTO l_total 
        FROM prgb_t
       WHERE prgbent = g_enterprise
         AND prgbdocno = l_prgadocno
      IF cl_null(l_total) THEN
         LET l_total = 0
      END IF 
      IF l_total > 0 THEN 
      #add by yangxf 20151230---end---
         #产生费用单
         IF l_prga001 = '1' THEN
            LET l_wc = " prga001 = '",l_prga001,"' "
            CALL s_expense('8',l_prgadocno,l_prgadocdt,l_wc) RETURNING r_success,r_docno
         END IF
         IF l_prga001 = '3' THEN
            LET l_wc = " prga001 = '",l_prga001,"' "
            CALL s_expense('12',l_prgadocno,l_prgadocdt,l_wc) RETURNING r_success,r_docno
         END IF
         IF NOT r_success THEN
            CALL s_transaction_end('N','0')
            CONTINUE FOREACH      
         END IF
         DISPLAY '费用单:',r_docno
      END IF  #add by yangxf 20151230
      #更新单头已计算补差为Y
      UPDATE prga_t SET prga016 = 'Y'
       WHERE prgaent = g_enterprise
         AND prgadocno = l_prgadocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPD prga_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
         CONTINUE FOREACH
      END IF
      CALL s_transaction_end('Y','0')
   END FOREACH
   CALL cl_err_collect_show()
   #160225-00040#16 20160303 add by beckxie---S
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#16 20160303 add by beckxie---E
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
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL astp312_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp312.get_buffer" >}
PRIVATE FUNCTION astp312_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.prgadocdt = p_dialog.getFieldBuffer('prgadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp312.msgcentre_notify" >}
PRIVATE FUNCTION astp312_msgcentre_notify()
 
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
 
{<section id="astp312.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
