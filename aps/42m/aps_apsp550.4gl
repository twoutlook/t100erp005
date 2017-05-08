#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp550.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-06-23 00:00:00), PR版次:0004(2016-04-26 18:11:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000093
#+ Filename...: apsp550
#+ Description: APS手調器
#+ Creator....: 03079(2014-06-23 00:00:00)
#+ Modifier...: 03079 -SD/PR- 07673
 
{</section>}
 
{<section id="apsp550.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151207-00012#4   2015/12/18 By shiun   更改執行日期抓取方式及執行引擎
#160303-00003#1   2016/03/03 By dorislai 多增加「目前執行階段」的檢查
#160318-00025#50  2016/04/26 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
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
   psea001               LIKE psea_t.psea001,       #APS版本
   psea002               LIKE psea_t.psea002,       #最近執行時間  #151207-00012#4 add
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
DEFINE g_psea001         LIKE psea_t.psea001           #APS版本 
DEFINE g_ref_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars        DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields      DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp550.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      LET lc_param.psea001 = g_argv[1]
      LET lc_param.psea002 = g_argv[2]
      LET ls_js = util.JSON.stringify(lc_param)
      #end add-point
      CALL apsp550_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp550 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp550_init()
 
      #進入選單 Menu (="N")
      CALL apsp550_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp550
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp550.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp550_init()
 
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
 
{<section id="apsp550.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp550_ui_dialog()
 
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
   INITIALIZE lc_param.* TO NULL 
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT lc_param.psea001 FROM psea001 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT

            AFTER FIELD psea001
               CALL apsp550_psca001_ref(lc_param.psea001)
               IF NOT cl_null(lc_param.psea001) THEN
                  IF NOT apsp550_psca001_chk(lc_param.psea001) THEN
                     NEXT FIELD CURRENT
                  END IF

                  IF NOT apsp550_psea001_chk(lc_param.psea001) THEN
                     NEXT FIELD CURRENT
                  END IF
                  
                  #160303-00003#1-add-(S)
                  IF NOT apsp550_psea003_chk(lc_param.psea001,lc_param.psea002) THEN
                     NEXT FIELD CURRENT
                  END IF
                  #160303-00003#1-add-(E)
                  
               END IF 
               
            ON ACTION controlp INFIELD psea001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = lc_param.psea001
               LET g_qryparam.WHERE = " pscasite = '",g_site,"'"
               CALL q_psca001()
               LET lc_param.psea001 = g_qryparam.return1
               DISPLAY lc_param.psea001 TO psea001

               CALL apsp550_psca001_ref(lc_param.psea001)

               NEXT FIELD psea001

         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apsp550_get_buffer(l_dialog)
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
         CALL apsp550_init()
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
                 CALL apsp550_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp550_transfer_argv(ls_js)
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
 
{<section id="apsp550.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp550_transfer_argv(ls_js)
 
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
 
{<section id="apsp550.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp550_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_psea002   LIKE psea_t.psea002     #執行日期時間 
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET g_psea001 = lc_param.psea001
   LET l_psea002 = lc_param.psea002   #151207-00012#4 add
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsp550_process_cs CURSOR FROM ls_sql
#  FOREACH apsp550_process_cs INTO
   #add-point:process段process name="process.process"
  #原本抓取該APS版本的最大執行日期時間，調整成判斷傳入參數「執行日期時間」無值時才抓
  #LET l_psea002 = ''           #151207-00012#4 mark
   IF cl_null(l_psea002) THEN   #151207-00012#4 add
      SELECT MAX(psea002) INTO l_psea002
        FROM psea_t
       WHERE pseaent = g_enterprise
         AND pseasite = g_site
         AND psea001 = g_psea001
         AND (psea003 = 'aps-00026' OR              #規畫完成  
              psea003 = 'aps-00152' )   #160303-00003#1-add
              
   END IF                       #151207-00012#4 add
   #160303-00003#1-add-(S)
   IF NOT apsp550_psea003_chk(g_psea001,l_psea002) THEN
      RETURN
   END IF
   #160303-00003#1-add-(E)
   CALL apsp550_open_browser(g_enterprise,g_site,g_psea001,l_psea002,'1')
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
   CALL apsp550_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp550.get_buffer" >}
PRIVATE FUNCTION apsp550_get_buffer(p_dialog)
 
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
 
{<section id="apsp550.msgcentre_notify" >}
PRIVATE FUNCTION apsp550_msgcentre_notify()
 
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
 
{<section id="apsp550.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apsp550_psca001_ref(p_psca001)
   DEFINE p_psca001     LIKE psca_t.psca001
   DEFINE l_psea001_desc    LIKE pscal_t.pscal003

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_psca001
   CALL ap_ref_array2(g_ref_fields,
                      "SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_lang||"'",
                      "")  
       RETURNING g_rtn_fields
   LET l_psea001_desc = '', g_rtn_fields[1] , ''
   DISPLAY l_psea001_desc TO psea001_desc
END FUNCTION

################################################################################
# Descriptions...: 檢查aps版本是否存在apsi002
# Memo...........:
# Usage..........: CALL apsp550_psca001_chk(p_psca001)
#                  RETURNING r_success
# Input parameter: p_psca001：aps版本
# Return code....: r_success：true/false
# Date & Author..: 2014/06/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_psca001_chk(p_psca001)
   DEFINE p_psca001         LIKE psca_t.psca001
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = TRUE
   
   IF cl_null(p_psca001) THEN
      RETURN r_success
   END IF
   
   INITIALIZE g_chkparam.* TO NULL
   LET g_chkparam.arg1 = p_psca001
   LET g_errshow = TRUE   #160318-00025#50
   LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#50
   IF NOT cl_chk_exist("v_psca001") THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 檢查aps版本是否存在psea_t之中
# Memo...........:
# Usage..........: CALL apsp550_psea001_chk(p_psea001)
#                  RETURNING r_success
# Input parameter: p_psea001：aps版本
# Return code....: r_success：true/false
# Date & Author..: 2014/06/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_psea001_chk(p_psea001)
   DEFINE p_psea001     LIKE psea_t.psea001
   DEFINE r_success     LIKE type_t.num5
   #151207-00012#4 20160119 add by ming -----(S) 
   DEFINE l_psca039     LIKE psca_t.psca039    #APS引擎 
   #151207-00012#4 20160119 add by ming -----(E) 

   LET r_success = TRUE
   IF cl_null(p_psea001) THEN
      RETURN r_success
   END IF
   
   #151207-00012#4 20160119 add by ming -----(S) 
   LET l_psca039 = '' 
   SELECT psca039 INTO l_psca039 
     FROM psca_t 
    WHERE pscaent  = g_enterprise 
      AND pscasite = g_site 
      AND psca001  = p_psea001 
   #151207-00012#4 20160119 add by ming -----(E) 


   #151207-00012#4 20160119 modify by ming -----(S)
   #INITIALIZE g_chkparam.* TO NULL
   #LET g_chkparam.arg1 = p_psea001
   #
   #IF NOT cl_chk_exist("v_psea001") THEN
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   
   IF l_psca039 = '2' THEN 
      INITIALIZE g_chkparam.* TO NULL 
      LET g_chkparam.arg1 = p_psea001 
      
      IF NOT cl_chk_exist("v_psea001_1") THEN 
         LET r_success = FALSE 
         RETURN r_success 
      END IF 
   ELSE 
      INITIALIZE g_chkparam.* TO NULL
      LET g_chkparam.arg1 = p_psea001
      
      IF NOT cl_chk_exist("v_psea001") THEN
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   #151207-00012#4 20160119 modify by ming -----(E)

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 執行aps手調器
# Memo...........:
# Usage..........: CALL apsp550_open_browser(p_pseaent,p_pseasite,p_psea001,p_psea002,p_type)
# Input parameter: p_pseaent：企業編號
#                : p_pseasite：營運據點 
#                : p_psea001：aps版本 
#                : p_psea002：執行日期(儲存版本) 
#                : p_type： 
# Date & Author..: 2014/06/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_open_browser(p_pseaent,p_pseasite,p_psea001,p_psea002,p_type)
   DEFINE p_pseaent    LIKE psea_t.pseaent
   DEFINE p_pseasite   LIKE psea_t.pseasite
   DEFINE p_psea001    LIKE psea_t.psea001
   DEFINE p_psea002    LIKE psea_t.psea002
   DEFINE p_type       LIKE type_t.chr1

   DEFINE l_url        STRING,
          l_aps_path   STRING,
          res          STRING
   DEFINE l_lang_type  LIKE type_t.chr10
   #151207-00012#4 20160113 modify by ming -----(S) 
   DEFINE l_psca039    LIKE psca_t.psca039     #APS引擎 
   DEFINE l_sID        STRING 
   #151207-00012#4 20160113 modify by ming -----(E) 
   DEFINE l_psea003    LIKE psea_t.psea003     #目前執行階段 #160303-00003#1-add
   #151207-00012#4 20160113 modify by ming -----(S) 
   #依aps版本決定是走原本的手調器，或者是進階aps 
   #CALL ui.Interface.frontCall( "standard", "getenv","DCIMCP_Client", [l_aps_path] )
   
   LET l_psca039 = '' 
   SELECT psca039 INTO l_psca039 
     FROM psca_t 
    WHERE pscaent  = p_pseaent 
      AND pscasite = p_pseasite 
      AND psca001  = g_psea001 
   
   IF l_psca039 = '2' THEN 
      #進階APS 
      CALL ui.Interface.frontCall( "standard", "getenv","DCIMCP_Client2", [l_aps_path] )
   ELSE 
      #APS手調器 
      CALL ui.Interface.frontCall( "standard", "getenv","DCIMCP_Client", [l_aps_path] )
   END IF 
   #151207-00012#4 20160113 modify by ming -----(E) 
   IF cl_null(l_aps_path) THEN
       CALL apsp550_get_reg_path() RETURNING l_aps_path
       DISPLAY "USE Old APSBrowser==> patch:",l_aps_path
   ELSE
       DISPLAY "USE New APSBrowser==> patch:",l_aps_path
   END IF 
   
   #ming 20140925 mark --------------------------------------(S) 
   #直接改使用g_dlang 
   #CASE g_lang
   #    WHEN '0'
   #         LET l_lang_type = 'CHT'  #繁體
   #    WHEN '1'
   #         LET l_lang_type = 'ENG'  #英文
   #    WHEN '2'
   #         LET l_lang_type = 'CHS'  #簡體
   #    WHEN '4'
   #         LET l_lang_type = 'VIET' #越南
   #    WHEN '5'
   #         LET l_lang_type = 'THAI' #泰文
   #    OTHERWISE
   #         LET l_lang_type = 'CHT'  #繁體
   #END CASE 
   #ming 20140925 mark --------------------------------------(E) 
   
   IF NOT cl_null(l_aps_path) THEN
     #啟動APS CP手調器
     #ming 20140925 modify ----------------------------------------(S) 
     #LET l_url = l_aps_path ,"/APSBrowser "," -C ",p_pseaent," -F ",p_pseasite," -A ",p_psea001," -V ",p_psea002," -U ",g_user," -P ",p_type, " -L ",l_lang_type," -S 1 " 
     #151207-00012#4 20160119 modify -----(S) 
     #LET l_url = l_aps_path ,"/APSBrowser "," -C ",p_pseaent," -F ",p_pseasite," -A ",p_psea001," -V ",p_psea002," -U ",g_user," -P ",p_type, " -L ",g_dlang," -S 1 " 
     IF l_psca039 = '2' THEN     
        #取得sID 
        LET l_sID = FGL_GETENV("ZONE")     #取得t10dev
        #160303-00003#1-mod-(S)
#        IF cl_null(p_psea002) THEN 
#           LET p_psea002 = '0' 
#        END IF
        SELECT psea003 INTO l_psea003
          FROM psea_t
         WHERE pseaent= g_enterprise
           AND pseasite = g_site
            AND psea001 = p_psea001
            AND psea002 = p_psea002
            AND (psea003 = 'aps-00026' OR              #規畫完成  
                 psea003 = 'aps-00152' )                  
        IF cl_null(p_psea002) OR l_psea003 = 'aps-00026' THEN 
           LET p_psea002 = '0' 
        END IF         
        #160303-00003#1-mod-(E)
                
        LET l_url = l_aps_path ,"/APSBrowser "," -C ",p_pseasite,"_",l_sID," -F ",p_psea001," -V ",p_psea002," -U ",g_user," -P ",p_type, " -L ",g_dlang," -S 1 " 
     ELSE 
        LET l_url = l_aps_path ,"/APSBrowser "," -C ",p_pseaent," -F ",p_pseasite," -A ",p_psea001," -V ",p_psea002," -U ",g_user," -P ",p_type, " -L ",g_dlang," -S 1 " 
     END IF 
     #151207-00012#4 20160119 modify -----(E) 
     #ming 20140925 modify ----------------------------------------(E) 
     #-S TIPTOP不需要登入APS, 所以登入選項一律設定 1
     #-L 語系為根據TIPTOP當下的語系別來傳入,預設 CHT                       
     DISPLAY l_url
     CALL ui.Interface.frontCall("standard","shellexec", [l_url], [res])
   END IF
END FUNCTION

################################################################################
# Descriptions...: 取得aps手調器運行路徑
# Memo...........:
# Usage..........: CALL apsp550_get_reg_path()
#                  RETURNING l_result
# Return code....: l_result：路徑
# Date & Author..: 2014/06/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_get_reg_path()
   DEFINE l_source  STRING
   DEFINE l_ch       base.Channel
   DEFINE l_buf      STRING
   DEFINE l_i        INT
   DEFINE l_file     STRING
   DEFINE l_str      STRING
   DEFINE l_cmd      STRING
   DEFINE l_url      STRING,
          l_result   STRING,
          res        LIKE type_t.num10


   LET l_source= "c:\\aps.reg"
   LET l_url = "Cmd.exe /c \"reg query \"HKEY_LOCAL_MACHINE\\SOFTWARE\\DCI\\APS\" > ",l_source,"\" "
   DISPLAY l_url
   CALL ui.Interface.frontCall("standard","shellexec", [l_url], [res])

   IF res THEN 
      SLEEP 1
   ELSE

   END IF 
   
   LET l_file = fgl_getenv("TEMPDIR"), "/", fgl_getpid() USING '<<<<<<<<<<', ".LOG"
   CALL FGL_GETFILE(l_source, l_file)
   IF STATUS THEN
        DISPLAY "Cannot upload file "
      RETURN FALSE
   ELSE
      IF os.Path.chrwx(l_file CLIPPED,438) THEN END IF   
   END IF

   LET l_ch = base.Channel.CREATE()
   CALL l_ch.openFile(l_file, "r")
   CALL l_ch.setDelimiter(NULL)
   LET l_i = 1
   WHILE l_ch.READ(l_buf)

        LET l_str = l_buf CLIPPED
        IF ( l_str.getIndexOf("Client",1)>0 ) THEN
           CALL apsp550_parseToken(l_str) RETURNING l_result
        END IF

   END WHILE 
   
   CALL l_ch.CLOSE()
   RUN "rm -f " || l_file
   RETURN l_result
END FUNCTION

################################################################################
# Descriptions...: 字串切割
# Memo...........:
# Usage..........: CALL apsp550_parseToken(p_str)
#                  RETURNING l_result
# Input parameter: p_str：要處理的字串
# Return code....: l_result：處理完的路徑字串
# Date & Author..: 2014/06/23 By ming
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_parseToken(p_str)
   DEFINE p_str      STRING
   DEFINE l_result   STRING
   DEFINE l_i        INT

   LET l_i = p_str.getIndexOf("REG_SZ",1)
   LET l_result= p_str.substring(l_i+7 ,p_str.getLength())

   RETURN l_result.trim()
END FUNCTION

################################################################################
# Descriptions...: 檢查aps目前執行階段是否符合aps-00026、aps-00152
# Memo...........:
# Usage..........: CALL apsp550_psea003_chk(p_psea001,p_psea002)
#                  RETURNING TRUE/FALSE
# Input parameter: p_psea001 APS版本
#                  p_psea002 執行日期時間
# Return code....: r_success TRUE/FALSE
# Date & Author..: 2016/03/03 By dorislai (#160303-00003#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp550_psea003_chk(p_psea001,p_psea002)
   DEFINE p_psea001 LIKE psea_t.psea001
   DEFINE p_psea002 LIKE psea_t.psea002
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   #因有放在AFTER FIELD psea001，所以要多加判斷p_sea002及多抓資料
   IF cl_null(p_psea002) THEN   
      SELECT MAX(psea002) INTO p_psea002
        FROM psea_t
       WHERE pseaent = g_enterprise
         AND pseasite = g_site
         AND psea001 = p_psea001
         AND (psea003 = 'aps-00026' OR              #規畫完成  
              psea003 = 'aps-00152' )   
   END IF                       
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM psea_t
    WHERE pseaent= g_enterprise
      AND pseasite = g_site
       AND psea001 = p_psea001
       AND psea002 = p_psea002
       AND (psea003 = 'aps-00026' OR              #規畫完成  
            psea003 = 'aps-00152' )   
    IF l_cnt = 0 THEN
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = '' 
       LET g_errparam.code   = 'aps-00169'    #其目前階段非aps-00026、aps-00152，不可執行！
       LET g_errparam.popup  = TRUE 
       CALL cl_err() 
       LET r_success = FALSE
   END IF
   RETURN r_success    
END FUNCTION

#end add-point
 
{</section>}
 
