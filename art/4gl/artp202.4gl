#該程式未解開Section, 採用最新樣板產出!
{<section id="artp202.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-28 17:40:47), PR版次:0002(2016-08-03 17:09:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: artp202
#+ Description: 品類層級重計批次作業
#+ Creator....: 06814(2016-03-28 17:12:45)
#+ Modifier...: 06814 -SD/PR- 08742
 
{</section>}
 
{<section id="artp202.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#16 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   artp202_rtax_tmp -->artp202_tmp01
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
 
{<section id="artp202.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL artp202_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp202 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artp202_init()
 
      #進入選單 Menu (="N")
      CALL artp202_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp202
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL artp202_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp202.init" >}
#+ 初始化作業
PRIVATE FUNCTION artp202_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
   CALL artp202_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="artp202.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp202_ui_dialog()
 
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
   CALL gfrm_curr2.ensureFieldVisible("stagecomplete")
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
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
            CALL artp202_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY 0 TO stagecomplete
            CALL gfrm_curr2.ensureFieldVisible("stagecomplete")
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
         CALL artp202_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL artp202_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = artp202_transfer_argv(ls_js)
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
 
{<section id="artp202.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION artp202_transfer_argv(ls_js)
 
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
 
{<section id="artp202.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION artp202_process(ls_js)
 
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
   DEFINE l_success_1   LIKE type_t.num5
   DEFINE l_msg         STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_cnt_b       LIKE type_t.num5
   DEFINE l_cnt_e       LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_rtax001     LIKE rtax_t.rtax001
   DEFINE l_rtax004     LIKE rtax_t.rtax004 #層級
   DEFINE l_rtax004_1   LIKE rtax_t.rtax004 #層級
   DEFINE l_rtaxmodid   LIKE rtax_t.rtaxmodid
   DEFINE l_rtaxmoddt   LIKE rtax_t.rtaxmoddt
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #進度軸的階段用最上層商品品類的個數量當階段
      SELECT COUNT (*) INTO li_count
        FROM rtax_t
       WHERE rtaxent = g_enterprise 
      LET li_count = (li_count / 100) + 4
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE artp202_process_cs CURSOR FROM ls_sql
#  FOREACH artp202_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_success   = TRUE
   LET l_success_1 = TRUE
   LET l_cnt_b = 0
   LET l_cnt_e = 0
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   #temp table
   CALL artp202_create_temp() RETURNING l_success 
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   LET l_rtaxmodid = g_user
   LET l_rtaxmoddt = cl_get_current()
   #當rtax001 = rtax006時，該品類的層級為1
   LET l_rtax004 = 1
   #LOCK:
   LET l_sql = " SELECT rtaxent,rtaxunit,rtax001,rtax002,rtax003, ",
               "        rtax004,rtax005,rtax006,rtax007,rtax008, ",
               "        rtaxstus,rtaxownid,rtaxowndp,rtaxcrtid,rtaxcrtdt,",
               "        rtaxcrtdp,rtaxmodid,rtaxmoddt,rtax009,rtax010,",
               "        rtax011 ",
               "   FROM rtax_t ",
               "  WHERE rtaxent = ?",
               "    FOR UPDATE NOWAIT"
   DECLARE artp202_lock_rtax_pre CURSOR FROM l_sql
   OPEN artp202_lock_rtax_pre USING g_enterprise
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN artp202_lock_rtax_pre:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL cl_err_collect_show()
      CLOSE artp202_lock_rtax_pre
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #步驟一：找出最上層的商品品類(rtax001=rtax006),並將層級設為1,INSERT 到temptable
   LET l_sql = " INSERT INTO artp202_tmp01 ",            #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "            (rtaxent     ,     rtax001     , rtax003 , rtax004 , rtax005, rtax006) ",
               " SELECT      rtaxent     ,     rtax001     , rtax003 , ",l_rtax004," , rtax005, rtax006",
               "   FROM rtax_t ",
               "  WHERE rtaxent = ",g_enterprise," ",
               "    AND rtax001 = rtax006 "
   PREPARE ins_rtax_tmp_pre FROM l_sql
   EXECUTE ins_rtax_tmp_pre
   IF SQLCA.sqlcode THEN
      LET l_success_1 = FALSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE ins_rtax_tmp_pre" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   #步驟二：給予適當的層級後 INSERT到temptable
   #由temp_table中，由最第一層展出
   LET l_sql = " SELECT DISTINCT rtax001 FROM artp202_tmp01 WHERE rtax004 = ? "   #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
   PREPARE artp202_sel_pre FROM l_sql
   DECLARE artp202_sel_cs SCROLL CURSOR FOR artp202_sel_pre
   LET l_sql = "INSERT INTO artp202_tmp01 ",            #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "            (rtaxent     ,     rtax001     , rtax003 , rtax004 , rtax005, rtax006)",
               " SELECT      rtaxent     ,     rtax001     , rtax003 , ?       , rtax005, rtax006 ",
               "   FROM rtax_t ",
               "  WHERE rtaxent = ? ",
               "    AND rtax001 <> rtax006 ",
               "    AND rtax003 = ? "   #上級品類
   PREPARE artp202_ins_temp_pre FROM l_sql
   LET l_sql = "UPDATE artp202_tmp01 t1 ",               #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "   SET t1.rtax006 = (SELECT DISTINCT t2.rtax006 ",
               "                       FROM artp202_tmp01 t2 ",       #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "                      WHERE t2.rtax001 = t1.rtax003 ) ",
               " WHERE t1.rtax004 = ? "   
   PREPARE artp202_upd_temp_pre FROM l_sql
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   WHILE TRUE
      FOREACH artp202_sel_cs USING l_rtax004 INTO l_rtax001
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH artp202_sel_cs" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET l_rtax004_1 = l_rtax004 + 1
         
         EXECUTE artp202_ins_temp_pre USING l_rtax004_1,g_enterprise,l_rtax001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "EXECUTE artp202_ins_temp_pre" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXECUTE artp202_upd_temp_pre USING l_rtax004_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "EXECUTE artp202_upd_temp_pre" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      END FOREACH
      LET l_rtax004 = l_rtax004 + 1
      
      #progress bar 進度條
      SELECT COUNT (*) INTO l_cnt_e
        FROM artp202_tmp01            #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
      
      LET l_cnt = l_cnt_e - l_cnt_b
      LET l_cnt_b = l_cnt_b + l_cnt
      LET l_cnt = l_cnt / 100
      FOR l_i = 1 TO l_cnt
         CALL cl_progress_no_window_ing(l_msg)
      END FOR
      
      #判斷是否將資料都ins至temp
      SELECT COUNT (*) INTO l_cnt 
        FROM rtax_t t1 
             LEFT JOIN artp202_tmp01 t2 ON t1.rtaxent = t2.rtaxent AND t1.rtax001 =t2.rtax001             #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
       WHERE t1.rtaxent = g_enterprise 
         AND t1.rtax003 IS NOT NULL 
         AND t1.rtax006 IS NOT NULL 
         AND t2.rtax001 IS NULL
         AND EXISTS (SELECT 1 FROM rtax_t t3 WHERE t3.rtaxent = t1.rtaxent AND t3.rtax001 = t1.rtax006 AND t3.rtax006 IS NOT NULL)
      #防呆避免跑入死迴圈
      IF l_cnt = 0 OR l_rtax004 = 100 THEN 
         EXIT WHILE
      END IF
   END WHILE
   #upd:rtax005
   LET l_sql = "UPDATE artp202_tmp01 t1 ",    #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "   SET t1.rtax005 = (SELECT COUNT(*) ",
               "                       FROM artp202_tmp01 t2 ",     #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "                      WHERE t1.rtaxent = t2.rtaxent ",
               "                        AND t2.rtax003 = t1.rtax001 ) "
   
   PREPARE artp202_temp_upd_pre FROM l_sql
   EXECUTE artp202_temp_upd_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE artp202_temp_upd_pre" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   #第一層的必須排除自己
   LET l_sql = "UPDATE artp202_tmp01 t1 ",        #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "   SET t1.rtax005 = (t1.rtax005-1)",
               " WHERE t1.rtax004 =1 AND t1.rtax005 >= 1"
   PREPARE artp202_temp_upd_pre1 FROM l_sql
   EXECUTE artp202_temp_upd_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE artp202_temp_upd_pre1" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   
   #步驟三：用temptable中的數據 整批更新到現行的rtax_t的rtax004的數據
   LET l_sql = "UPDATE rtax_t t1 ",
               "   SET t1.rtax004=(SELECT t2.rtax004 FROM artp202_tmp01 t2 WHERE t1.rtaxent = t2.rtaxent AND t1.rtax001 = t2.rtax001), ",      #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "       t1.rtax005=(SELECT t2.rtax005 FROM artp202_tmp01 t2 WHERE t1.rtaxent = t2.rtaxent AND t1.rtax001 = t2.rtax001), ",      #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               "       t1.rtax006=(SELECT t2.rtax006 FROM artp202_tmp01 t2 WHERE t1.rtaxent = t2.rtaxent AND t1.rtax001 = t2.rtax001) ",       #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
               " WHERE t1.rtaxent = ",g_enterprise
   PREPARE artp202_rtax_upd_pre FROM l_sql
   EXECUTE artp202_rtax_upd_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "EXECUTE artp202_rtax_upd_pre " 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   #步驟四：呼叫arti202_compute_rtaw() 更新rtaw_t的數據
   CALL s_arti202_compute_rtaw() RETURNING l_success
   IF NOT l_success THEN
      LET l_success_1 = FALSE
   END IF
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   IF g_bgjob = "Y" THEN
   ELSE
      DISPLAY l_msg ,100
           TO stagenow,stagecomplete

      CALL ui.Interface.refresh()
   END IF
   CLOSE artp202_lock_rtax_pre
   CALL cl_err_collect_show()
   IF NOT l_success_1 THEN
      CALL s_transaction_end("N","0")
   ELSE
      CALL s_transaction_end("Y","0")
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
   CALL artp202_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp202.get_buffer" >}
PRIVATE FUNCTION artp202_get_buffer(p_dialog)
 
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
 
{<section id="artp202.msgcentre_notify" >}
PRIVATE FUNCTION artp202_msgcentre_notify()
 
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
 
{<section id="artp202.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION artp202_create_temp()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   
   IF NOT artp202_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE artp202_tmp01(                  #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
      rtaxent   LIKE rtax_t.rtaxent,   #企業編號
      rtax001   LIKE rtax_t.rtax001,   #品類編號
      rtax003   LIKE rtax_t.rtax003,   #上級品類編號
      rtax004   LIKE rtax_t.rtax004,   #層級
      rtax005   LIKE rtax_t.rtax005,   #下級品類數
      rtax006   LIKE rtax_t.rtax006    #所屬一級品類
      )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create rtax_tmp'
      LET g_errparam.popup = TRUE
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

PRIVATE FUNCTION artp202_drop_temp()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   DROP TABLE artp202_tmp01                  #160727-00019#16 Mod   artp202_rtax_tmp -->artp202_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop rtax_tmp'
      LET g_errparam.popup = TRUE
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
