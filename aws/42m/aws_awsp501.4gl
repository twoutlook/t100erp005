#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-11-12 11:28:28), PR版次:0001(2015-11-19 12:01:48)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: awsp501
#+ Description: 足包ERP批次呼叫作業
#+ Creator....: 05775(2015-11-12 11:17:58)
#+ Modifier...: 05775 -SD/PR- 05775
 
{</section>}
 
{<section id="awsp501.global" >}
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
   l_seqkey              LIKE type_t.chr20,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_seqkey LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_plm_db     STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="awsp501.main" >}
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
   CALL cl_ap_init("aws","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_plm_db = ''
   CALL cl_eai_get_middb(g_dbs) RETURNING g_plm_db
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL awsp501_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp501 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp501_init()
 
      #進入選單 Menu (="N")
      CALL awsp501_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp501
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp501.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp501_init()
 
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
   LET g_master.l_seqkey = NULL
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="awsp501.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp501_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_cnt    LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      LET g_master.l_seqkey = NULL
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_seqkey 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_seqkey
            #add-point:BEFORE FIELD l_seqkey name="input.b.l_seqkey"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_seqkey
            
            #add-point:AFTER FIELD l_seqkey name="input.a.l_seqkey"
            IF NOT cl_null(g_master.l_seqkey) THEN
               LET l_cnt = 0
               LET g_sql = " SELECT COUNT(*) ",
                           "   FROM ",g_plm_db CLIPPED,".plm_logm_t ",
                           "  WHERE seqkey = '",g_master.l_seqkey CLIPPED,"' "
               PREPARE awsp501_sel_logm_p FROM g_sql
               DECLARE awsp501_sel_logm_c CURSOR FOR awsp501_sel_logm_p
               OPEN awsp501_sel_logm_c
               FETCH awsp501_sel_logm_c INTO l_cnt
               CLOSE awsp501_sel_logm_c
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aws-00032' #無此對列ID存在，請重新輸入！
                  LET g_errparam.popup = TRUE   #開窗否
                  CALL cl_err()
                  NEXT FIELD l_seqkey
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_seqkey
            #add-point:ON CHANGE l_seqkey name="input.g.l_seqkey"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_seqkey
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_seqkey
            #add-point:ON ACTION controlp INFIELD l_seqkey name="input.c.l_seqkey"
            
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
            CALL awsp501_get_buffer(l_dialog)
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
         CALL awsp501_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.wc = NULL
      LET lc_param.l_seqkey = g_master.l_seqkey
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
                 CALL awsp501_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp501_transfer_argv(ls_js)
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
 
{<section id="awsp501.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp501_transfer_argv(ls_js)
 
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
 
{<section id="awsp501.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp501_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
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
      LET li_count = 0
      DISPLAY li_count TO FORMONLY.stagecomplete
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE awsp501_process_cs CURSOR FROM ls_sql
#  FOREACH awsp501_process_cs INTO
   #add-point:process段process name="process.process"
   
   CALL awsp501_wscallerp_plm(lc_param.l_seqkey)
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      LET li_count = 100
      DISPLAY li_count TO FORMONLY.stagecomplete
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
 
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL awsp501_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp501.get_buffer" >}
PRIVATE FUNCTION awsp501_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_seqkey = p_dialog.getFieldBuffer('l_seqkey')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsp501.msgcentre_notify" >}
PRIVATE FUNCTION awsp501_msgcentre_notify()
 
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
 
{<section id="awsp501.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 根據對列ID去檢查同一列隊是否足包及同一XML是否足包，
#                  若足夠則執行批次產生PLM資料
# Memo...........:
# Usage..........: CALL awsp501_wscallerp_plm(p_seqkey)
# Input parameter: p_seqkey :隊列ID
# Return code....: none
# Date & Author..: 15/11/12 By TSD.Tim
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp501_wscallerp_plm(p_seqkey)
   DEFINE p_seqkey           LIKE type_t.chr20
   DEFINE l_seqkey_totcnt    LIKE type_t.num10
   DEFINE l_seq_current_cnt  LIKE type_t.num10
   DEFINE l_datakey          LIKE type_t.chr20
   DEFINE l_datakey_totcnt   LIKE type_t.num10
   DEFINE l_data_current_cnt LIKE type_t.num10
   DEFINE l_cnt              LIKE type_t.num10
   DEFINE l_sql              STRING
   DEFINE l_callerp_flag     LIKE type_t.num5
   DEFINE l_enough           LIKE type_t.chr1   #是否有找到此對列 
   
   WHILE TRUE
      LET l_callerp_flag = TRUE
   
      #撈出此隊列ID Request接收時間最早的隊列傳輸總筆數
      #ps.經過調整後，相同seqkey僅會存在一筆logm資料
      LET l_sql = " SELECT seqkey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_logm_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "  ORDER BY reqxml_time "
      PREPARE s_wscallerp_plm_sel_logm_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_logm_c CURSOR FOR s_wscallerp_plm_sel_logm_p
     
      LET l_seqkey_totcnt = NULL
      OPEN s_wscallerp_plm_sel_logm_c
      FETCH s_wscallerp_plm_sel_logm_c INTO l_seqkey_totcnt
      CLOSE s_wscallerp_plm_sel_logm_c
       
      #抓不到對列總數，不呼叫批次
      IF cl_null(l_seqkey_totcnt) THEN
         LET l_callerp_flag = FALSE
         EXIT WHILE
      END IF
      
      #檢查同一對列，是否足包                
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                 
      PREPARE s_wscallerp_plm_sel_all_p1 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c1 CURSOR FOR s_wscallerp_plm_sel_all_p1
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaal_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                   
      PREPARE s_wscallerp_plm_sel_all_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c2 CURSOR FOR s_wscallerp_plm_sel_all_p2
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                  
      PREPARE s_wscallerp_plm_sel_all_p3 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c3 CURSOR FOR s_wscallerp_plm_sel_all_p3
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmba_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                  
      PREPARE s_wscallerp_plm_sel_all_p4 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c4 CURSOR FOR s_wscallerp_plm_sel_all_p4
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmbc_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                  
      PREPARE s_wscallerp_plm_sel_all_p5 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c5 CURSOR FOR s_wscallerp_plm_sel_all_p5
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmea_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                  
      PREPARE s_wscallerp_plm_sel_all_p6 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c6 CURSOR FOR s_wscallerp_plm_sel_all_p6
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmif_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",   
                  "    AND seqkey_subcnt = ? "                 
      PREPARE s_wscallerp_plm_sel_all_p7 FROM l_sql
      DECLARE s_wscallerp_plm_sel_all_c7 CURSOR FOR s_wscallerp_plm_sel_all_p7
      
      LET l_enough = 'Y'
      FOR l_seq_current_cnt = 1 TO l_seqkey_totcnt
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c1 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c1 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c1   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c2 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c2 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c2   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c3 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c3 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c3   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c4 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c4 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c4   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c5 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c5 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c5   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c6 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c6 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c6   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_cnt = NULL
         OPEN  s_wscallerp_plm_sel_all_c7 USING l_seq_current_cnt
         FETCH s_wscallerp_plm_sel_all_c7 INTO l_cnt
         CLOSE s_wscallerp_plm_sel_all_c7   
         IF l_cnt > 0 THEN
            CONTINUE FOR
         END IF
         
         LET l_enough = 'N'
         EXIT FOR         
      END FOR
      IF l_enough = 'N' THEN
         LET l_callerp_flag = FALSE
         EXIT WHILE
      END IF
      
      #---檢查各個中間檔的DataKey是否足包---
      #plm_imaa_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_imaa_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_imaa_c CURSOR FOR s_wscallerp_plm_sel_imaa_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_imaa_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_imaa_c2 CURSOR FOR s_wscallerp_plm_sel_imaa_p2
      
      FOREACH s_wscallerp_plm_sel_imaa_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_imaa_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_imaa_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_imaa_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH
      
      #plm_imaal_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaal_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_imaal_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_imaal_c CURSOR FOR s_wscallerp_plm_sel_imaal_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_imaal_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_imaal_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_imaal_c2 CURSOR FOR s_wscallerp_plm_sel_imaal_p2
      
      FOREACH s_wscallerp_plm_sel_imaal_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_imaal_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_imaal_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_imaal_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH

      #plm_bmaa_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_bmaa_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmaa_c CURSOR FOR s_wscallerp_plm_sel_bmaa_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmaa_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_bmaa_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmaa_c2 CURSOR FOR s_wscallerp_plm_sel_bmaa_p2
      
      FOREACH s_wscallerp_plm_sel_bmaa_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_bmaa_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_bmaa_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_bmaa_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH
      
      #plm_bmba_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmba_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_bmba_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmba_c CURSOR FOR s_wscallerp_plm_sel_bmba_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmba_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_bmba_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmba_c2 CURSOR FOR s_wscallerp_plm_sel_bmba_p2
      
      FOREACH s_wscallerp_plm_sel_bmba_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_bmba_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_bmba_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_bmba_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH
      
      #bmbc為非必要資料，不用加入足包判斷
      #plm_bmbc_t
      #LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
      #            "   FROM ",g_plm_db CLIPPED,".plm_bmbc_t ",
      #            "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      #PREPARE s_wscallerp_plm_sel_bmbc_p FROM l_sql
      #DECLARE s_wscallerp_plm_sel_bmbc_c CURSOR FOR s_wscallerp_plm_sel_bmbc_p
      #
      #LET l_sql = " SELECT COUNT(*) ",
      #            "   FROM ",g_plm_db CLIPPED,".plm_bmbc_t ",
      #            "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
      #            "    AND datakey = ? ",
      #            "    AND datakey_subcnt = ? "
      #PREPARE s_wscallerp_plm_sel_bmbc_p2 FROM l_sql
      #DECLARE s_wscallerp_plm_sel_bmbc_c2 CURSOR FOR s_wscallerp_plm_sel_bmbc_p2
      #
      #FOREACH s_wscallerp_plm_sel_bmbc_c INTO l_datakey,l_datakey_totcnt
      #   IF SQLCA.sqlcode THEN
      #      LET l_callerp_flag = FALSE
      #      EXIT WHILE
      #   END IF
      #   
      #   FOR l_data_current_cnt = 1 TO l_datakey_totcnt
      #      LET l_cnt = NULL
      #      OPEN  s_wscallerp_plm_sel_bmbc_c2 USING l_datakey,l_data_current_cnt
      #      FETCH s_wscallerp_plm_sel_bmbc_c2 INTO l_cnt
      #      CLOSE s_wscallerp_plm_sel_bmbc_c2
      #      
      #      IF l_cnt = 0 THEN
      #         LET l_callerp_flag = FALSE
      #         EXIT WHILE
      #      END IF
      #   END FOR
      #END FOREACH
      
      #plm_bmea_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmea_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_bmea_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmea_c CURSOR FOR s_wscallerp_plm_sel_bmea_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmea_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_bmea_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmea_c2 CURSOR FOR s_wscallerp_plm_sel_bmea_p2
      
      FOREACH s_wscallerp_plm_sel_bmea_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_bmea_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_bmea_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_bmea_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH
      
      #plm_bmif_t
      LET l_sql = " SELECT DISTINCT datakey,datakey_totcnt ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmif_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' "
      PREPARE s_wscallerp_plm_sel_bmif_p FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmif_c CURSOR FOR s_wscallerp_plm_sel_bmif_p
      
      LET l_sql = " SELECT COUNT(*) ",
                  "   FROM ",g_plm_db CLIPPED,".plm_bmif_t ",
                  "  WHERE seqkey = '",p_seqkey CLIPPED,"' ",
                  "    AND datakey = ? ",
                  "    AND datakey_subcnt = ? "
      PREPARE s_wscallerp_plm_sel_bmif_p2 FROM l_sql
      DECLARE s_wscallerp_plm_sel_bmif_c2 CURSOR FOR s_wscallerp_plm_sel_bmif_p2
      
      FOREACH s_wscallerp_plm_sel_bmif_c INTO l_datakey,l_datakey_totcnt
         IF SQLCA.sqlcode THEN
            LET l_callerp_flag = FALSE
            EXIT WHILE
         END IF
         
         FOR l_data_current_cnt = 1 TO l_datakey_totcnt
            LET l_cnt = NULL
            OPEN  s_wscallerp_plm_sel_bmif_c2 USING l_datakey,l_data_current_cnt
            FETCH s_wscallerp_plm_sel_bmif_c2 INTO l_cnt
            CLOSE s_wscallerp_plm_sel_bmif_c2
            
            IF l_cnt = 0 THEN
               LET l_callerp_flag = FALSE
               EXIT WHILE
            END IF
         END FOR
      END FOREACH
      
      EXIT WHILE
   END WHILE
   
   #檢查足包且無誤則呼叫批次
   IF l_callerp_flag THEN
      CALL awsp501_wscallerp_plm_log('1',p_seqkey)   #紀錄開始 log
      CALL s_aws_plm_data_ins(p_seqkey)
      CALL awsp501_wscallerp_plm_log('2',p_seqkey)   #紀錄結束 log
   END IF    
END FUNCTION

################################################################################
# Descriptions...: 批次紀錄呼叫PLM批次 LOG
# Memo...........:
# Usage..........: CALL awsp501_wscallerp_plm_log(p_type,p_seqkey)
# Input parameter: p_type     :1.開始 2.結束
#                  p_seqkey   :對列ID
# Return code....: none
# Date & Author..: 15/11/18 By TSD.Tim
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp501_wscallerp_plm_log(p_type,p_seqkey)
   DEFINE p_type      LIKE type_t.chr1
   DEFINE p_seqkey    LIKE type_t.chr20
   DEFINE l_channel   base.Channel
   DEFINE l_logfile   STRING
   DEFINE l_str       STRING
   DEFINE l_curr      STRING
   DEFINE l_sb        base.StringBuffer
   
   LET l_curr = cl_time_trans_by_tz("current_time")
   
   #LOG檔路徑: $LOGDIR/awsp501-YYYYMMDD.log
   LET l_logfile = FGL_GETENV("TEMPDIR"), "/", "awsp501-",g_today USING 'YYYYMMDD',".log"
   
   LET l_channel = base.Channel.create()
   CALL l_channel.setDelimiter(NULL)
   CALL l_channel.openFile(l_logfile, "a")
   IF STATUS = 0 THEN
      IF p_type = '1' THEN   #Request 
         LET l_sb = base.StringBuffer.create()
         CALL l_sb.replace(":", "", 0)
         CALL l_sb.replace(".", "", 0)      
         
         LET l_str = "#--------------------------- (", l_curr , ") ----------------------------#\n",
                     "[Begin at ",cl_get_time(),"]\n",
                     "Seqkey：",p_seqkey CLIPPED
      ELSE 
         LET l_str = "[End at ",cl_get_time(),"]\n",
                     "Seqkey：",p_seqkey CLIPPED,"\n",
                     "#------------------------------------------------------------------------------------#\n\n"
      END IF  
      CALL l_channel.write(l_str)
   END IF

   CALL l_channel.close()
END FUNCTION

#end add-point
 
{</section>}
 
