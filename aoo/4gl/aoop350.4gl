#該程式未解開Section, 採用最新樣板產出!
{<section id="aoop350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-07-13 15:57:16), PR版次:0001(2016-01-12 13:55:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aoop350
#+ Description: 聯絡對象識別碼批次更新作業
#+ Creator....: 01588(2015-07-13 15:33:37)
#+ Modifier...: 01588 -SD/PR- 01588
 
{</section>}
 
{<section id="aoop350.global" >}
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
        oofa002          LIKE oofa_t.oofa002,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       oofa002 LIKE oofa_t.oofa002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_oofa002        LIKE oofa_t.oofa002
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aoop350.main" >}
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
   CALL cl_ap_init("aoo","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aoop350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aoop350 WITH FORM cl_ap_formpath("aoo",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aoop350_init()
 
      #進入選單 Menu (="N")
      CALL aoop350_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aoop350
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aoop350.init" >}
#+ 初始化作業
PRIVATE FUNCTION aoop350_init()
 
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
   CALL cl_set_combo_scc('oofa002','1')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aoop350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aoop350_ui_dialog()
 
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
         INPUT BY NAME g_master.oofa002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofa002
            #add-point:BEFORE FIELD oofa002 name="input.b.oofa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofa002
            
            #add-point:AFTER FIELD oofa002 name="input.a.oofa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofa002
            #add-point:ON CHANGE oofa002 name="input.g.oofa002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.oofa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofa002
            #add-point:ON ACTION controlp INFIELD oofa002 name="input.c.oofa002"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL aoop350_get_buffer(l_dialog)
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
         CALL aoop350_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.oofa002 = g_master.oofa002
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
                 CALL aoop350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aoop350_transfer_argv(ls_js)
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
 
{<section id="aoop350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aoop350_transfer_argv(ls_js)
 
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
 
{<section id="aoop350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aoop350_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_msg         STRING
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #檢查聯絡對象類型是否有處理
   IF NOT cl_null(lc_param.oofa002) THEN
      IF NOT (lc_param.oofa002 = '0' OR lc_param.oofa002 = '1' OR lc_param.oofa002 = '2' OR 
              lc_param.oofa002 = '3' OR lc_param.oofa002 = '4' OR lc_param.oofa002 = '7' OR 
              lc_param.oofa002 = '8' OR lc_param.oofa002 = '12') THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aoo-00645'
         LET g_errparam.extend = lc_param.oofa002
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         RETURN
      END IF
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CASE lc_param.oofa002
         WHEN '0'
              LET li_count = 1
         WHEN '1'
              LET li_count = 2
         WHEN '2'
              LET li_count = 1
         WHEN '3'
              LET li_count = 7
         WHEN '4'
              LET li_count = 1
         WHEN '7'
              LET li_count = 1
         WHEN '8'
              LET li_count = 1
         WHEN '12'
              LET li_count = 2
         OTHERWISE
              LET li_count = 16
      END CASE
      
      #聯絡地址識別碼、通訊方式識別碼 處理
      LET li_count = li_count + 2
      
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aoop350_process_cs CURSOR FROM ls_sql
#  FOREACH aoop350_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()
   LET l_success = TRUE
   CALL cl_err_collect_init()
   
   #0.鼎新顧問團隊
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '0' THEN
      LET g_oofa002 = '0'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：gzwg002
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'gzwg002'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('gzwg_t','gzwg002')
              RETURNING l_success
      END IF
   END IF
   
   #1.組織
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '1' THEN
      LET g_oofa002 = '1'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：ooef012
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'ooef012'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('ooef_t','ooef012')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：rtbc012
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'rtbc012'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('rtbc_t','rtbc012')
              RETURNING l_success
      END IF
   END IF
   
   #2.員工
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '2' THEN
      LET g_oofa002 = '2'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：ooag002
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'ooag002'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('ooag_t','ooag002')
              RETURNING l_success
      END IF
   END IF
   
   #3.客戶/廠商
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '3' THEN
      LET g_oofa002 = '3'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：craa013
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'craa013'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('craa_t','craa013')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：crab012
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'crab012'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('crab_t','crab012')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：oojm012
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'oojm012'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('oojm_t','oojm012')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：pmaa027
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'pmaa027'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('pmaa_t','pmaa027')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：pmba027
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'pmba027'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('pmba_t','pmba027')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：xmda028
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'xmda028'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('xmda_t','xmda028')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：pmak001
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'pmak001'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('pmak_t','pmak001')
              RETURNING l_success
      END IF
   END IF
   
   #4.交易對象聯絡人
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '4' THEN
      LET g_oofa002 = '4'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：pmaj002
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'pmaj002'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('pmaj_t','pmaj002')
              RETURNING l_success
      END IF
   END IF
   
   #7.銀行
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '7' THEN
      LET g_oofa002 = '7'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：nmaa008
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'nmaa008'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('nmaa_t','nmaa008')
              RETURNING l_success
      END IF
   END IF
   
   #8.庫位
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '8' THEN
      LET g_oofa002 = '8'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：inaa004
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'inaa004'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('inaa_t','inaa004')
              RETURNING l_success
      END IF
   END IF
   
   #12.站點
   IF cl_null(lc_param.oofa002) OR lc_param.oofa002 = '12' THEN
      LET g_oofa002 = '12'
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：dbae002
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'dbae002'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('dbae_t','dbae002')
              RETURNING l_success
      END IF
      IF l_success THEN
         IF g_bgjob <> "Y" THEN
            #更新聯絡對象識別碼：dbad003
            LET l_msg = cl_getmsg('aoo-00646',g_dlang),'dbad003'
            CALL cl_progress_no_window_ing(l_msg)
         END IF
         CALL aoop350_process1('dbad_t','dbad003')
              RETURNING l_success
      END IF
   END IF
   
   IF l_success THEN
      LET g_oofa002 = ''
      IF g_bgjob <> "Y" THEN
         #更新聯絡地址識別碼
         LET l_msg = cl_getmsg('aoo-00653',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL aoop350_process1('oofb_t','oofb001')
           RETURNING l_success
   END IF
   
   IF l_success THEN
      LET g_oofa002 = ''
      IF g_bgjob <> "Y" THEN
         #更新通訊方式識別碼
         LET l_msg = cl_getmsg('aoo-00654',g_dlang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF
      CALL aoop350_process1('oofc_t','oofc001')
           RETURNING l_success
   END IF
   
   CALL cl_err_collect_show()
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
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
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aoop350_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aoop350.get_buffer" >}
PRIVATE FUNCTION aoop350_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.oofa002 = p_dialog.getFieldBuffer('oofa002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aoop350.msgcentre_notify" >}
PRIVATE FUNCTION aoop350_msgcentre_notify()
 
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
 
{<section id="aoop350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 針對傳入的table和field處理
# Memo...........:
# Usage..........: CALL aoop350_process1(p_table,p_field)
#                  RETURNING r_success
# Input parameter: p_table        Table代號
#                : p_field        欄位代號
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/07/13 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop350_process1(p_table,p_field)
DEFINE p_table           LIKE dzea_t.dzea001
DEFINE p_field           LIKE dzeb_t.dzeb002
DEFINE r_success         LIKE type_t.num5
DEFINE ls_table          STRING
DEFINE lc_dzed002        LIKE dzed_t.dzed002
DEFINE lc_dzed004        LIKE dzed_t.dzed004
DEFINE ls_dzed004        STRING
DEFINE lc_pk             DYNAMIC ARRAY OF VARCHAR(80)   #table的pk欄位(排除ent)
DEFINE lc_pk_value       DYNAMIC ARRAY OF VARCHAR(80)   #table的pk值(排除ent)
DEFINE l_pk_num          LIKE type_t.num5               #table的pk數量(排除ent)
DEFINE ls_sql_field      STRING                         #欲抓取的key欄位
DEFINE ls_sql            STRING
DEFINE lc_ent_field      LIKE type_t.chr80              #ent欄位
DEFINE l_value           LIKE type_t.chr80
DEFINE l_success1        LIKE type_t.num5
DEFINE l_oofa001         LIKE oofa_t.oofa001
DEFINE l_wc              STRING
DEFINE l_gzwg003         LIKE gzwg_t.gzwg003
DEFINE l_gzwg004         LIKE gzwg_t.gzwg004
DEFINE l_pmak002         LIKE pmak_t.pmak002
DEFINE l_pmaa002         LIKE pmaa_t.pmaa002

   LET r_success = TRUE
   
   IF cl_null(g_oofa002) AND p_table <> 'oofb_t' AND p_table <> 'oofc_t' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00647'
      LET g_errparam.extend = 'call aoop350_process1:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_table) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00648'
      LET g_errparam.extend = 'call aoop350_process1:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_field) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00649'
      LET g_errparam.extend = 'call aoop350_process1:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET ls_table = p_table
   LET lc_dzed002 = ls_table.subString(1,ls_table.getIndexOf('_',1)-1)
   LET lc_dzed002 = lc_dzed002 CLIPPED,'_pk'
   
   #抓取該table的PK欄位
   LET ls_sql = "SELECT dzed004 FROM dzed_t ",
                " WHERE dzed001 = '",p_table,"'",
                "   AND dzed002 = '",lc_dzed002,"'"
   PREPARE aoop350_get_pk_pre FROM ls_sql
   EXECUTE aoop350_get_pk_pre INTO lc_dzed004
   
   IF cl_null(lc_dzed004) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00651'
      LET g_errparam.extend = p_table
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      FREE aoop350_get_pk_pre
      RETURN r_success
   END IF
   
   FREE aoop350_get_pk_pre
   
   #拆解dzed004
   LET ls_dzed004 = lc_dzed004
   LET l_pk_num = 0
   WHILE TRUE
      LET l_value = ls_dzed004.subString(1,ls_dzed004.getIndexOf(',',1)-1)
      LET ls_dzed004 = ls_dzed004.subString(ls_dzed004.getIndexOf(',',1)+1,ls_dzed004.getLength())
      
      #若有ent的欄位
      IF l_value[LENGTH(l_value)-2,LENGTH(l_value)] = 'ent' THEN
         LET lc_ent_field = l_value
      ELSE
         LET l_pk_num = l_pk_num + 1
         LET lc_pk[l_pk_num] = l_value
      END IF
      
      IF ls_dzed004.getIndexOf(',',1) <= 0 THEN
         LET l_value = ls_dzed004
         
         #若有ent的欄位
         IF l_value[LENGTH(l_value)-3,LENGTH(l_value)] = 'ent' THEN
            LET lc_ent_field = l_value
         ELSE
            LET l_pk_num = l_pk_num + 1
            LET lc_pk[l_pk_num] = l_value
         END IF
         
         EXIT WHILE 
      END IF
   END WHILE
   
   #組更新對應的聯絡對象識別碼的SQL
   LET ls_sql = "UPDATE ",p_table,
                "   SET ",p_field," = ? "
   
   #先只設定5個key，若後續加的table超過5個key，再做調整
   #ls_sql：更新對應的聯絡對象識別碼的SQL
   #ls_sql_field：欲抓取的欄位，用以抓取錯誤的聯絡對象識別碼的SQL
   CASE l_pk_num
      WHEN '1'
           LET ls_sql = ls_sql CLIPPED,
                        " WHERE ",lc_pk[1]," = ? "
           LET ls_sql_field = lc_pk[1],",'','','','' "
      WHEN '2'
           LET ls_sql = ls_sql CLIPPED,
                        " WHERE ",lc_pk[1]," = ? ",
                        "   AND ",lc_pk[2]," = ? "
           LET ls_sql_field = lc_pk[1],",",lc_pk[2],",'','','' "
      WHEN '3'
           LET ls_sql = ls_sql CLIPPED,
                        " WHERE ",lc_pk[1]," = ? ",
                        "   AND ",lc_pk[2]," = ? ",
                        "   AND ",lc_pk[3]," = ? "
           LET ls_sql_field = lc_pk[1],",",lc_pk[2],",",lc_pk[3],",'','' "
      WHEN '4'
           LET ls_sql = ls_sql CLIPPED,
                        " WHERE ",lc_pk[1]," = ? ",
                        "   AND ",lc_pk[2]," = ? ",
                        "   AND ",lc_pk[3]," = ? ",
                        "   AND ",lc_pk[4]," = ? "
           LET ls_sql_field = lc_pk[1],",",lc_pk[2],",",lc_pk[3],",",lc_pk[4],",'' "
      WHEN '5'
           LET ls_sql = ls_sql CLIPPED,
                        " WHERE ",lc_pk[1]," = ? ",
                        "   AND ",lc_pk[2]," = ? ",
                        "   AND ",lc_pk[3]," = ? ",
                        "   AND ",lc_pk[4]," = ? ",
                        "   AND ",lc_pk[5]," = ? "
           LET ls_sql_field = lc_pk[1],",",lc_pk[2],",",lc_pk[3],",",lc_pk[4],",",lc_pk[5]
   END CASE
   
   IF NOT cl_null(lc_ent_field) THEN
      LET ls_sql = ls_sql CLIPPED,
                   " AND ",lc_ent_field," = ",g_enterprise
   END IF
   PREPARE aoop350_process1_upd_pre FROM ls_sql
   
   #抓取錯誤的聯絡對象識別碼的資料，並將之更新成正確的聯絡對象識別碼
   LET ls_sql = "SELECT ",ls_sql_field,
                "  FROM ",p_table,
                " WHERE (",p_field," IS NULL ",   #聯絡對象識別碼為空
                "    OR LENGTH(TRIM(TRANSLATE(",p_field,",'0123456789',' '))) IS NOT NULL ",   #聯絡對象識別碼有非數字的字元
                "    OR LENGTH(",p_field,") <> 20 ) "   #聯絡對象識別碼長度不為20
   
   IF NOT cl_null(lc_ent_field) THEN
      LET ls_sql = ls_sql CLIPPED,
                   " AND ",lc_ent_field," = ",g_enterprise
   END IF
   LET ls_sql = ls_sql CLIPPED," ORDER BY ",ls_sql_field
   
   PREPARE aoop350_process1_pre FROM ls_sql
   DECLARE aoop350_process1_cs CURSOR FOR aoop350_process1_pre
   
   FOREACH aoop350_process1_cs INTO lc_pk_value[1],lc_pk_value[2],lc_pk_value[3],lc_pk_value[4],lc_pk_value[5]
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "foreach:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      CASE p_table
         WHEN 'oofb_t'
              LET l_wc = " oofbent = ",g_enterprise
              CALL s_aooi350_get_idno('oofb001','oofb_t',l_wc)
                   RETURNING l_success1,l_oofa001
              IF NOT l_success1 THEN
                 LET r_success = FALSE
                 EXIT FOREACH
              END IF
         WHEN 'oofc_t'
              LET l_wc = " oofcent = ",g_enterprise
              CALL s_aooi350_get_idno('oofc001','oofc_t',l_wc)
                   RETURNING l_success1,l_oofa001
              IF NOT l_success1 THEN
                 LET r_success = FALSE
                 EXIT FOREACH
              END IF
         OTHERWISE
              #呼叫"新增聯絡對象檔"
              CASE
                 WHEN p_field = 'gzwg002' 
                      SELECT gzwg003,gzwg004 INTO l_gzwg003,l_gzwg004
                        FROM gzwg_t
                       WHERE gzwgent = g_enterprise
                         AND gzwg001 = lc_pk_value[1]
                         AND gzwg002 = lc_pk_value[2]
                      CALL s_aooi350_ins_oofa(l_gzwg003,l_gzwg004,'')
                           RETURNING l_success1,l_oofa001
                 WHEN p_field = 'oojm012' OR p_field = 'inaa004' 
                      CALL s_aooi350_ins_oofa(g_oofa002,lc_pk_value[2],lc_pk_value[3])
                           RETURNING l_success1,l_oofa001
                 WHEN p_field = 'pmak001'
                      SELECT pmak002 INTO l_pmak002
                        FROM pmak_t
                       WHERE pmakent = g_enterprise
                         AND pmak001 = lc_pk_value[1]
                      SELECT pmaa002 INTO l_pmaa002
                        FROM pmaa_t
                       WHERE pmaaent = g_enterprise
                         AND pmaa001 = l_pmak002
                      CALL s_aooi350_ins_oofa(g_oofa002,l_pmak002,l_pmaa002)
                           RETURNING l_success1,l_oofa001
                 WHEN p_field = 'pmaj002'
                      CALL s_aooi350_ins_oofa(g_oofa002,lc_pk_value[1],'')
                           RETURNING l_success1,l_oofa001
                 OTHERWISE
                      CALL s_aooi350_ins_oofa(g_oofa002,lc_pk_value[1],lc_pk_value[2])
                           RETURNING l_success1,l_oofa001
              END CASE
              IF NOT l_success1 THEN
                 LET r_success = FALSE
                 EXIT FOREACH
              END IF
      END CASE
      
      #更新對應的聯絡對象識別碼
      CASE l_pk_num
         WHEN '1'
              EXECUTE aoop350_process1_upd_pre USING l_oofa001,lc_pk_value[1]
         WHEN '2'
              EXECUTE aoop350_process1_upd_pre USING l_oofa001,lc_pk_value[1],lc_pk_value[2]
         WHEN '3'
              EXECUTE aoop350_process1_upd_pre USING l_oofa001,lc_pk_value[1],lc_pk_value[2],lc_pk_value[3]
         WHEN '4'
              EXECUTE aoop350_process1_upd_pre USING l_oofa001,lc_pk_value[1],lc_pk_value[2],lc_pk_value[3],
                                                     lc_pk_value[4]
         WHEN '5'
              EXECUTE aoop350_process1_upd_pre USING l_oofa001,lc_pk_value[1],lc_pk_value[2],lc_pk_value[3],
                                                     lc_pk_value[4],lc_pk_value[5]
      END CASE
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd ",p_table
         LET g_errparam.popup = TRUE
         
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF
      
      #更新受影響的table
      #傳入參數：欄位、聯絡對象識別碼_新值、key值(動態array)
      CALL aoop350_process2(p_field,l_oofa001,lc_pk_value,l_pk_num)
           RETURNING l_success1
      IF NOT l_success1 THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 受影響的欄位，更新其聯絡對象識別碼
# Memo...........:
# Usage..........: CALL aoop350_process2(p_field,p_oofa001,pc_pk_value,p_pk_num)
#                  RETURNING r_success
# Input parameter: p_field        欄位代號
#                : p_oofa001      新的聯絡對象識別碼
#                : pc_pk_value    p_field的table的key值(動態array)
#                : p_pk_num       Key值數量
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/07/14 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop350_process2(p_field,p_oofa001,pc_pk_value,p_pk_num)
DEFINE p_field           LIKE dzeb_t.dzeb002
DEFINE p_oofa001         LIKE oofa_t.oofa001
DEFINE pc_pk_value       DYNAMIC ARRAY OF VARCHAR(80)
DEFINE p_pk_num          LIKE type_t.num5
DEFINE r_success         LIKE type_t.num5
DEFINE l_success1        LIKE type_t.num5
DEFINE lc_where_fields   DYNAMIC ARRAY OF VARCHAR(80)

   LET r_success = TRUE
   
   IF cl_null(p_field) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00649'
      LET g_errparam.extend = 'call aoop350_process2:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_oofa001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00650'
      LET g_errparam.extend = 'call aoop350_process2:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF pc_pk_value.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00652'
      LET g_errparam.extend = 'call aoop350_process2:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CASE p_field
      WHEN 'gzwg002'
           #gzwgl002
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'gzwgl001'
           LET lc_where_fields[2] = 'gzwgl002'
           CALL aoop350_process3('gzwgl_t','gzwgl002',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #gzwh002
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'gzwh001'
           LET lc_where_fields[2] = 'gzwh002'
           CALL aoop350_process3('gzwh_t','gzwh002',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #gzwi007
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'gzwi006'
           LET lc_where_fields[2] = 'gzwi007'
           CALL aoop350_process3('gzwi_t','gzwi007',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #gzwo007
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'gzwo006'
           LET lc_where_fields[2] = 'gzwo007'
           CALL aoop350_process3('gzwo_t','gzwo007',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'pmak001'
           #nmck006
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmck006'
           CALL aoop350_process3('nmck_t','nmck006',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #nmbb027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmbb027'
           CALL aoop350_process3('nmbb_t','nmbb027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #nmba005
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmba005'
           CALL aoop350_process3('nmba_t','nmba005',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #nmbu002
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmbu002'
           CALL aoop350_process3('nmbu_t','nmbu002',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmdl028
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmdl028'
           CALL aoop350_process3('pmdl_t','pmdl028',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #xrca057
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'xrca057'
           CALL aoop350_process3('xrca_t','xrca057',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmee027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmee027'
           CALL aoop350_process3('pmee_t','pmee027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmee028
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmee028'
           CALL aoop350_process3('pmee_t','pmee028',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #xmee028
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'xmee028'
           CALL aoop350_process3('xmee_t','xmee028',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmds028
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmds028'
           CALL aoop350_process3('pmds_t','pmds028',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'pmaj002'
           #bmia011
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'bmia007'
           LET lc_where_fields[2] = 'bmia011'
           CALL aoop350_process3('bmia_t','bmia011',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #xmda027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'xmda004'
           LET lc_where_fields[2] = 'xmda027'
           CALL aoop350_process3('xmda_t','xmda027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #xmee027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'xmee004'
           LET lc_where_fields[2] = 'xmee027'
           CALL aoop350_process3('xmee_t','xmee027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmdl027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmdl004'
           LET lc_where_fields[2] = 'pmdl027'
           CALL aoop350_process3('pmdl_t','pmdl027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #pmee027
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'pmee004'
           LET lc_where_fields[2] = 'pmee027'
           CALL aoop350_process3('pmee_t','pmee027',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
           
           #xmep004
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'xmep005'
           LET lc_where_fields[2] = 'xmep004'
           CALL aoop350_process3('xmep_t','xmep004',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'oofb001'
           #nmaa009
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmaa009'
           CALL aoop350_process3('nmaa_t','nmaa009',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
      WHEN 'oofc001'
           #nmaa010
           CALL lc_where_fields.clear()
           LET lc_where_fields[1] = 'nmaa010'
           CALL aoop350_process3('nmaa_t','nmaa010',lc_where_fields,pc_pk_value,p_oofa001)
                RETURNING l_success1
           IF NOT l_success1 THEN
              LET r_success = FALSE
              RETURN r_success
           END IF
   END CASE
   
   IF p_field <> 'oofb001' AND p_field <> 'oofc001' THEN
      #oofb002
      CALL lc_where_fields.clear()
      CASE p_pk_num
         WHEN '1'
            LET lc_where_fields[1] = 'oofb003'
         WHEN '2'
            LET lc_where_fields[1] = 'oofb003'
            LET lc_where_fields[2] = 'oofb004'
         WHEN '3'
            LET lc_where_fields[1] = 'oofb003'
            LET lc_where_fields[2] = 'oofb004'
            LET lc_where_fields[3] = 'oofb005'
         WHEN '4'
            LET lc_where_fields[1] = 'oofb003'
            LET lc_where_fields[2] = 'oofb004'
            LET lc_where_fields[3] = 'oofb005'
            LET lc_where_fields[4] = 'oofb006'
         WHEN '5'
            LET lc_where_fields[1] = 'oofb003'
            LET lc_where_fields[2] = 'oofb004'
            LET lc_where_fields[3] = 'oofb005'
            LET lc_where_fields[4] = 'oofb006'
            LET lc_where_fields[5] = 'oofb007'
      END CASE
      CALL aoop350_process3('oofb_t','oofb002',lc_where_fields,pc_pk_value,p_oofa001)
           RETURNING l_success1
      IF NOT l_success1 THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #oofc002
      CALL lc_where_fields.clear()
      CASE p_pk_num
         WHEN '1'
            LET lc_where_fields[1] = 'oofc003'
         WHEN '2'
            LET lc_where_fields[1] = 'oofc003'
            LET lc_where_fields[2] = 'oofc004'
         WHEN '3'
            LET lc_where_fields[1] = 'oofc003'
            LET lc_where_fields[2] = 'oofc004'
            LET lc_where_fields[3] = 'oofc005'
         WHEN '4'
            LET lc_where_fields[1] = 'oofc003'
            LET lc_where_fields[2] = 'oofc004'
            LET lc_where_fields[3] = 'oofc005'
            LET lc_where_fields[4] = 'oofc006'
         WHEN '5'
            LET lc_where_fields[1] = 'oofc003'
            LET lc_where_fields[2] = 'oofc004'
            LET lc_where_fields[3] = 'oofc005'
            LET lc_where_fields[4] = 'oofc006'
            LET lc_where_fields[5] = 'oofc007'
      END CASE
      CALL aoop350_process3('oofc_t','oofc002',lc_where_fields,pc_pk_value,p_oofa001)
           RETURNING l_success1
      IF NOT l_success1 THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 對受影響的欄位，更新其聯絡對象識別碼
# Memo...........:
# Usage..........: CALL aoop350_process3(p_table,p_field,p_where_fields,p_where_values,p_oofa001)
#                  RETURNING r_success
# Input parameter: p_table        欲更新的table代號
#                : p_field        欲更新的欄位
#                : p_where_fields where條件的欄位
#                : p_where_values where條件的值
#                : p_oofa001      新的聯絡對象識別碼
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2015/07/14 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION aoop350_process3(p_table,p_field,p_where_fields,p_where_values,p_oofa001)
DEFINE p_table           LIKE dzea_t.dzea001
DEFINE p_field           LIKE dzeb_t.dzeb002
DEFINE p_where_fields    DYNAMIC ARRAY OF VARCHAR(80)
DEFINE p_where_values    DYNAMIC ARRAY OF VARCHAR(80)
DEFINE p_oofa001         LIKE oofa_t.oofa001
DEFINE r_success         LIKE type_t.num5
DEFINE ls_sql            STRING
DEFINE l_num             LIKE type_t.num5
DEFINE l_ent_field       LIKE dzeb_t.dzeb002
DEFINE ls_table          STRING

   LET r_success = TRUE
   
   IF cl_null(p_table) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00648'
      LET g_errparam.extend = 'call aoop350_process1:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_field) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00649'
      LET g_errparam.extend = 'call aoop350_process1:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   IF cl_null(p_oofa001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00650'
      LET g_errparam.extend = 'call aoop350_process2:'
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #取ent欄位
   LET ls_table = p_table
   LET l_ent_field = ls_table.subString(1,ls_table.getIndexOf('_',1)-1)
   LET l_ent_field = l_ent_field CLIPPED,'ent'
   
   LET l_num = p_where_fields.getLength()
   
   LET ls_sql = "UPDATE ",p_table,
                "   SET ",p_field," = '",p_oofa001,"'",
                " WHERE ",l_ent_field," = ",g_enterprise
   
   CASE l_num
      WHEN '1'
           LET ls_sql = ls_sql CLIPPED,
                        " AND ",p_where_fields[1]," = '",p_where_values[1],"'"
      WHEN '2'
           LET ls_sql = ls_sql CLIPPED,
                        " AND ",p_where_fields[1]," = '",p_where_values[1],"'",
                        " AND ",p_where_fields[2]," = '",p_where_values[2],"'"
      WHEN '3'
           LET ls_sql = ls_sql CLIPPED,
                        " AND ",p_where_fields[1]," = '",p_where_values[1],"'",
                        " AND ",p_where_fields[2]," = '",p_where_values[2],"'",
                        " AND ",p_where_fields[3]," = '",p_where_values[3],"'"
      WHEN '4'
           LET ls_sql = ls_sql CLIPPED,
                        " AND ",p_where_fields[1]," = '",p_where_values[1],"'",
                        " AND ",p_where_fields[2]," = '",p_where_values[2],"'",
                        " AND ",p_where_fields[3]," = '",p_where_values[3],"'",
                        " AND ",p_where_fields[4]," = '",p_where_values[4],"'"
      WHEN '5'
           LET ls_sql = ls_sql CLIPPED,
                        " AND ",p_where_fields[1]," = '",p_where_values[1],"'",
                        " AND ",p_where_fields[2]," = '",p_where_values[2],"'",
                        " AND ",p_where_fields[3]," = '",p_where_values[3],"'",
                        " AND ",p_where_fields[4]," = '",p_where_values[4],"'",
                        " AND ",p_where_fields[5]," = '",p_where_values[5]
   END CASE
   
   #聯絡對象類型
   IF p_field = 'oofb002' THEN
      LET ls_sql = ls_sql CLIPPED,
                   " AND oofb023 = '",g_oofa002,"'"
   END IF
   
   #聯絡對象類型
   IF p_field = 'oofc002' THEN
      LET ls_sql = ls_sql CLIPPED,
                   " AND oofc016 = '",g_oofa002,"'"
   END IF
   
   PREPARE aoop350_process3_pre FROM ls_sql
   EXECUTE aoop350_process3_pre
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'upd ',p_field
      LET g_errparam.popup = TRUE
      
      CALL cl_err()
      LET r_success = FALSE
      FREE aoop350_process3_pre
      RETURN r_success
   END IF
   
   FREE aoop350_process3_pre
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
