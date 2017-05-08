#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2016-05-20 15:40:09), PR版次:0009(2016-11-15 14:15:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000184
#+ Filename...: apsp510
#+ Description: 交期回覆模擬作業
#+ Creator....: 01588(2014-06-03 17:26:06)
#+ Modifier...: 03079 -SD/PR- 08993
 
{</section>}
 
{<section id="apsp510.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#151224-00025#3   2015/12/24  By fionchen 產品特徵欄位若無開窗輸入反而自行手動輸入時,則無法新增至inam_t
#160512-00016#3   2016/05/20  By ming     增加欄位 保稅否，預設值由imaf034帶出  
#160620-00007#1   2016/06/20  By ming     修正sql未加「,」的bug
#161109-00085#16  2016/11/15  By 08993    整批調整系統星號寫法
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
       psha001 LIKE psha_t.psha001, 
   psha002 LIKE psha_t.psha002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_g_master_m      RECORD
            psha001       LIKE psha_t.psha001,
            psha002       LIKE psha_t.psha002
                          END RECORD

TYPE type_g_detail_d      RECORD
            pshbseq       LIKE pshb_t.pshbseq,
            pshbseq1      LIKE pshb_t.pshbseq1,
            pshbseq2      LIKE pshb_t.pshbseq2,
            pshb002       LIKE pshb_t.pshb002,
            pshb002_desc  LIKE imaal_t.imaal003,
            pshb002_desc_desc LIKE imaal_t.imaal004,
            pshb003       LIKE pshb_t.pshb003,
            #160512-00016#3 20160520 add by ming -----(S) 
            pshb007       LIKE pshb_t.pshb007,     #保稅否 
            #160512-00016#3 20160520 add by ming -----(E) 
            pshb005       LIKE pshb_t.pshb005,
            pshb004       LIKE pshb_t.pshb004,
            pshb004_desc  LIKE oocal_t.oocal003,
            pshb006       LIKE pshb_t.pshb006,
            psoq024       LIKE psoq_t.psoq024
                          END RECORD

TYPE type_g_detail2_d     RECORD
            pson004       LIKE pson_t.pson004,
            pson005       LIKE pson_t.pson005
                          END RECORD
                          
TYPE type_g_detail3_d     RECORD
            psoz004       LIKE psoz_t.psoz004,
            psoz018       LIKE psoz_t.psoz018,
            qty1          LIKE psoz_t.psoz018,
            qty2          LIKE psoz_t.psoz018,
            psoz037       LIKE psoz_t.psoz037
                          END RECORD
                          
TYPE type_g_detail4_d     RECORD
            pspa011       LIKE pspa_t.pspa011,
            pspa020       LIKE pspa_t.pspa020,
            pspa006       LIKE pspa_t.pspa006,
            pspa009       LIKE pspa_t.pspa009,
            qty           LIKE pspa_t.pspa009
                          END RECORD

DEFINE g_detail_idx       LIKE type_t.num5
DEFINE g_detail2_idx      LIKE type_t.num5
DEFINE g_detail3_idx      LIKE type_t.num5
DEFINE g_detail4_idx      LIKE type_t.num5
DEFINE g_detail_cnt       LIKE type_t.num5
DEFINE g_detail2_cnt      LIKE type_t.num5
DEFINE g_detail3_cnt      LIKE type_t.num5
DEFINE g_detail4_cnt      LIKE type_t.num5
DEFINE g_master_m         type_g_master_m
DEFINE g_master_m_t       type_g_master_m
DEFINE g_detail_d         DYNAMIC ARRAY OF type_g_detail_d
DEFINE g_detail2_d        DYNAMIC ARRAY OF type_g_detail2_d 
DEFINE g_detail3_d        DYNAMIC ARRAY OF type_g_detail3_d
DEFINE g_detail4_d        DYNAMIC ARRAY OF type_g_detail4_d
#160512-00016#3 20160520 add by ming -----(S) 
DEFINE g_detail_d_o       type_g_detail_d
#160512-00016#3 20160520 add by ming -----(E) 
DEFINE g_detail_d_t       type_g_detail_d
DEFINE g_psha001          LIKE psha_t.psha001
DEFINE l_ac               LIKE type_t.num5
DEFINE g_rec_b            LIKE type_t.num5
DEFINE g_first            LIKE type_t.num5
DEFINE g_ref_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields       DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_inam             DYNAMIC ARRAY OF RECORD   #記錄產品特徵
         inam001          LIKE inam_t.inam001,
         inam002          LIKE inam_t.inam002,
         inam004          LIKE inam_t.inam004
                          END RECORD
DEFINE g_aps_code         LIKE psca_t.psca001
DEFINE g_datetime         LIKE psoq_t.psoq002
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsp510.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success  LIKE type_t.num5
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
      
      #end add-point
      CALL apsp510_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp510 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp510_init()
 
      #進入選單 Menu (="N")
      CALL apsp510_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp510
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL apsp510_psha_del(g_psha001) RETURNING l_success
   CALL apsp510_pshb_del(g_psha001) RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp510.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp510_init()
 
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
   CALL cl_set_combo_scc("pspa020","5440")
   LET g_first = TRUE
   IF cl_null(g_bgjob) THEN
      LET g_bgjob = 'N'
   END IF
   LET g_errshow = 1
   
   #判斷之前是否有因異常關閉程式，造成的遺留資料
   #若有，則將該資料刪除
   CALL apsp510_residues_data()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp510_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   IF NOT cl_null(g_argv[1]) THEN
      LET g_master_m.psha002 = g_argv[1]
      CALL apsp510_psha_ins() RETURNING l_success
      CALL apsp510_pshb_ins_data() RETURNING l_success
      CALL apsp510_process(ls_js)
      LET g_first = FALSE
   END IF
   
   IF g_first THEN
      CALL apsp510_insert()
      LET g_first = FALSE
   END IF
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
         DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               CALL apsp510_b_fill2()
               CALL apsp510_b_fill3()
               CALL apsp510_b_fill4()

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               DISPLAY BY NAME g_master_m.psha001,g_master_m.psha002
         END DISPLAY
         
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail2_cnt)
            BEFORE ROW
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail2_idx)
               LET g_detail2_idx = DIALOG.getCurrentRow("s_detail2")
         END DISPLAY

         DISPLAY ARRAY g_detail3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail3_cnt)
            BEFORE ROW
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail3_idx)
               LET g_detail3_idx = DIALOG.getCurrentRow("s_detail3")
         END DISPLAY
         
         DISPLAY ARRAY g_detail4_d TO s_detail4.* ATTRIBUTES(COUNT=g_detail4_cnt)
            BEFORE ROW
               LET g_detail4_idx = DIALOG.getCurrentRow("s_detail4")

            BEFORE DISPLAY
               CALL FGL_SET_ARR_CURR(g_detail4_idx)
               LET g_detail4_idx = DIALOG.getCurrentRow("s_detail4")
         END DISPLAY
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apsp510_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            NEXT FIELD pshbseq
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
         ON ACTION insert
            LET g_action_choice = "insert"
            CALL apsp510_insert()
            CONTINUE DIALOG   
         
         ON ACTION modify
            LET g_action_choice = "modify"
            CALL apsp510_modify()
            CONTINUE DIALOG
            
         ON ACTION delete
            LET g_action_choice = "delete"
            CALL apsp510_delete()
            CONTINUE DIALOG
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
         CALL apsp510_init()
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
                 CALL apsp510_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp510_transfer_argv(ls_js)
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
 
{<section id="apsp510.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp510_transfer_argv(ls_js)
 
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
 
{<section id="apsp510.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp510_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_datetime1 DATETIME YEAR TO SECOND
   DEFINE l_psca002   LIKE psca_t.psca002
   DEFINE l_success   LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #取得ATP使用的APS版本
   CALL cl_get_para(g_enterprise,g_site,'S-MFG-0050')
        RETURNING g_aps_code
   IF cl_null(g_aps_code) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00310'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #抓取APS計算模式
   SELECT psca002 INTO l_psca002
     FROM psca_t
    WHERE pscaent = g_enterprise
      AND pscasite= g_site
      AND psca001 = g_aps_code
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aps-00073'
      LET g_errparam.extend = g_aps_code
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      IF l_psca002 = '1' THEN
         LET li_count = 9
      ELSE
         LET li_count = 22
      END IF
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsp510_process_cs CURSOR FROM ls_sql
#  FOREACH apsp510_process_cs INTO
   #add-point:process段process name="process.process"
   #目前的日期時間
   LET l_datetime1 = cl_get_current()
   LET g_datetime = cl_replace_str(l_datetime1,':','')
   LET g_datetime = cl_replace_str(g_datetime,' ','')
   LET g_datetime = cl_replace_str(g_datetime,'-','')
   
   #呼叫aps
   CALL s_apsp500_aps('5',g_master_m.psha001,g_datetime,'','','')
        RETURNING l_success
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF l_success THEN
         #單身資料的填充
         CALL apsp510_b_fill()
         IF NOT cl_null(g_argv[1]) THEN
            RETURN
         END IF
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apsp510_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp510.get_buffer" >}
PRIVATE FUNCTION apsp510_get_buffer(p_dialog)
 
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
 
{<section id="apsp510.msgcentre_notify" >}
PRIVATE FUNCTION apsp510_msgcentre_notify()
 
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
 
{<section id="apsp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 刪除psha_t
# Memo...........:
# Usage..........: CALL apsp510_psha_del(p_psha001)
#                  RETURNING r_success
# Input parameter: p_psha001      ATP編號
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/06/05 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_psha_del(p_psha001)
DEFINE p_psha001         LIKE psha_t.psha001
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM psha_t
    WHERE pshaent = g_enterprise
      AND pshasite= g_site
      AND psha001 = p_psha001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del psha_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
 
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增psha_t
# Memo...........:
# Usage..........: CALL apsp510_psha_ins()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/06/05 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_psha_ins()
DEFINE r_success         LIKE type_t.num5
DEFINE l_cnt             LIKE type_t.num5

   LET r_success = TRUE
   
   #再檢查一次是否有Key重複
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM psha_t
    WHERE pshaent = g_enterprise
      AND pshasite= g_site
      AND psha001 = g_master_m.psha001
   IF (NOT cl_null(l_cnt) AND l_cnt > 0) OR cl_null(g_master_m.psha001) THEN 
      SELECT MAX(psha001)+1 INTO g_master_m.psha001
        FROM psha_t
       WHERE pshaent = g_enterprise
         AND pshasite= g_site
      IF cl_null(g_master_m.psha001) THEN 
         LET g_master_m.psha001 = 1
      END IF
      LET g_master_m.psha001 = g_master_m.psha001 USING '&&&&&'
      DISPLAY BY NAME g_master_m.psha001
   END IF
   
   INSERT INTO psha_t (pshaent,pshasite,psha001,psha002,psha003)
      VALUES (g_enterprise,g_site,g_master_m.psha001,g_master_m.psha002,g_sessionkey)
   IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins psha_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   LET g_psha001 = g_master_m.psha001
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除pshb_t
# Memo...........:
# Usage..........: CALL apsp510_pshb_del(p_psha001)
#                  RETURNING r_success
# Input parameter: p_psha001      ATP編號
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/06/05 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_pshb_del(p_psha001)
DEFINE p_psha001         LIKE psha_t.psha001
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DELETE FROM pshb_t
    WHERE pshbent = g_enterprise
      AND pshbsite= g_site
      AND pshb001 = p_psha001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del pshb_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   
   DELETE FROM inam_t
    WHERE inament = g_enterprise
      AND inam005 = g_site
      AND inam006 = p_psha001
      AND inam007 = g_today
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將訂單交期明細的資料新增到pshb_t
# Memo...........:
# Usage..........: CALL apsp510_pshb_ins_data()
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success      TRUE/FALSE
#                : 
# Date & Author..: 2014/06/05 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_pshb_ins_data()
DEFINE r_success         LIKE type_t.num5
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_pshb            RECORD LIKE pshb_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_pshb            RECORD  #交期回覆模擬單身檔
       pshbent LIKE pshb_t.pshbent, #企業編號
       pshbsite LIKE pshb_t.pshbsite, #營運據點
       pshb001 LIKE pshb_t.pshb001, #ATP編號
       pshbseq LIKE pshb_t.pshbseq, #項次
       pshbseq1 LIKE pshb_t.pshbseq1, #項序
       pshbseq2 LIKE pshb_t.pshbseq2, #分批序
       pshb002 LIKE pshb_t.pshb002, #料件編號
       pshb003 LIKE pshb_t.pshb003, #產品特徵
       pshb004 LIKE pshb_t.pshb004, #單位
       pshb005 LIKE pshb_t.pshb005, #數量
       pshb006 LIKE pshb_t.pshb006, #預計交期
       pshb007 LIKE pshb_t.pshb007  #保稅否
          END RECORD
#mod--161109-00085#16 By 08993--(e)

   LET r_success = TRUE
   
   #160512-00016#3 20160520 modify by ming -----(S) 
   #DECLARE xmdd_cs CURSOR FOR
   # SELECT xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,xmdd004,xmdd006,xmdd011
   #   FROM xmdd_t
   #  WHERE xmddent = g_enterprise
   #    AND xmdddocno = g_master_m.psha002
   DECLARE xmdd_cs CURSOR FOR
    SELECT xmddseq,xmddseq1,xmddseq2,xmdd001,xmdd002,(SELECT COALESCE(imaf034,'N') FROM imaf_t
                                                       WHERE imafent  = g_enterprise
                                                         AND imafsite = g_site
                                                         AND imaf001  = xmdd001 ),    #160620-00007#1 add[,] 
           xmdd004,xmdd006,xmdd011
      FROM xmdd_t
     WHERE xmddent = g_enterprise
       AND xmdddocno = g_master_m.psha002
   #160512-00016#3 20160520 modify by ming -----(E) 
       
   FOREACH xmdd_cs INTO l_pshb.pshbseq,l_pshb.pshbseq1,l_pshb.pshbseq2,l_pshb.pshb002,l_pshb.pshb003,
                        #160512-00016#3 20160520 add by ming -----(S) 
                        l_pshb.pshb007,
                        #160512-00016#3 20160520 add by ming -----(E) 
                        l_pshb.pshb004,l_pshb.pshb005,l_pshb.pshb006
                        
      LET l_pshb.pshb001 = g_master_m.psha001
      LET l_pshb.pshbent = g_enterprise
      LET l_pshb.pshbsite= g_site
      
      #160512-00016#3 20160520 modify by ming -----(S) 
      #INSERT INTO pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2,
      #                    pshb002,pshb003,pshb004,pshb005,pshb006)
      #   VALUES (l_pshb.pshbent,l_pshb.pshbsite,l_pshb.pshb001,l_pshb.pshbseq,l_pshb.pshbseq1,
      #           l_pshb.pshbseq2,
      #           l_pshb.pshb002,l_pshb.pshb003,l_pshb.pshb004,l_pshb.pshb005,l_pshb.pshb006)  
      INSERT INTO pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2,
                          pshb002,pshb003,pshb004,pshb005,pshb006,pshb007)
         VALUES (l_pshb.pshbent,l_pshb.pshbsite,l_pshb.pshb001,l_pshb.pshbseq,l_pshb.pshbseq1,
                 l_pshb.pshbseq2,
                 l_pshb.pshb002,l_pshb.pshb003,l_pshb.pshb004,l_pshb.pshb005,l_pshb.pshb006,
                 l_pshb.pshb007)
      #160512-00016#3 20160520 modify by ming -----(E) 
      IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins pshb_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET r_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 輸入資料
# Memo...........:
# Usage..........: CALL apsp510_input(p_cmd)
#                  
# Input parameter: p_cmd        a:新增/u:修改
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_input(p_cmd)
DEFINE p_cmd             LIKE type_t.chr1
DEFINE l_cmd_t           LIKE type_t.chr1
DEFINE l_cmd             LIKE type_t.chr1
DEFINE l_n               LIKE type_t.num5                #檢查重複用  
DEFINE l_cnt             LIKE type_t.num5                #檢查重複用  
DEFINE l_lock_sw         LIKE type_t.chr1                #單身鎖住否  
DEFINE l_allow_insert    LIKE type_t.num5                #可新增否 
DEFINE l_allow_delete    LIKE type_t.num5                #可刪除否  
DEFINE l_count           LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_insert          BOOLEAN
DEFINE l_success         LIKE type_t.num5

   LET g_forupd_sql = "SELECT pshbseq,pshbseq1,pshbseq2,pshb002,pshb003,pshb005,pshb004,pshb006 ",
                      "  FROM pshb_t ",
                      " WHERE pshbent = ? ",
                      "   AND pshbsite= ? ",
                      "   AND pshb001 = ? ",
                      "   AND pshbseq = ? ",
                      "   AND pshbseq1= ? ",
                      "   AND pshbseq2= ? ",
                      "   FOR UPDATE "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE apsp510_bcl CURSOR FROM g_forupd_sql

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
  
      INPUT BY NAME g_master_m.psha002
         ATTRIBUTE(WITHOUT DEFAULTS)
        
         AFTER FIELD psha002 
            IF NOT cl_null(g_master_m.psha002) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master_m.psha002
               IF NOT cl_chk_exist("v_xmdadocno_5") THEN
                  LET g_master_m.psha002 = g_master_m_t.psha002
                  DISPLAY BY NAME g_master_m.psha002
                  NEXT FIELD CURRENT
               END IF
            END IF
                
         ON ACTION controlp INFIELD psha002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdastus <> 'C' AND xmdastus <> 'X' "
            CALL q_xmdadocno()
            LET g_master_m.psha002 = g_qryparam.return1
            DISPLAY BY NAME g_master_m.psha002
            NEXT FIELD psha002
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
               
            IF p_cmd = 'a' THEN
               IF NOT apsp510_psha_ins() THEN
                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               ELSE
                  IF NOT cl_null(g_master_m.psha002) THEN
                     IF apsp510_pshb_ins_data() THEN
                        CALL s_transaction_end('Y','0')
                        CALL apsp510_b_fill()
                        EXIT DIALOG
                     ELSE
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                  END IF
                  CALL s_transaction_end('Y','0')
                  LET g_master_m_t.* = g_master_m.*
                  LET p_cmd = 'u'
               END IF
            ELSE
               UPDATE psha_t SET psha002 = g_master_m.psha002
                WHERE pshaent = g_enterprise
                  AND pshasite= g_site
                  AND psha001 = g_master_m.psha001
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'upd psha_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(g_master_m.psha002) THEN
                  IF cl_null(g_master_m_t.psha002) OR g_master_m.psha002 <> g_master_m_t.psha002 THEN
                     IF NOT apsp510_pshb_del(g_psha001) THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     END IF
                     IF NOT apsp510_pshb_ins_data() THEN
                        CALL s_transaction_end('N','0')
                        CONTINUE DIALOG
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
                     CALL apsp510_b_fill()
                  END IF
                  EXIT DIALOG
               END IF
               CALL s_transaction_end('Y','0')
               LET g_master_m_t.* = g_master_m.*
            END IF
            
      END INPUT

      INPUT ARRAY g_detail_d FROM s_detail1.*
         ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                   INSERT ROW = TRUE,
                   DELETE ROW = TRUE,
                   APPEND ROW = TRUE)
         BEFORE INPUT
            CALL apsp510_b_fill()
            CALL FGL_SET_ARR_CURR(g_detail_idx)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            LET g_rec_b = g_detail_d.getLength()
   
         BEFORE ROW
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            
            LET g_rec_b = g_detail_d.getLength()
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            
            LET g_rec_b = g_detail_d.getLength()
            
            IF g_rec_b >= l_ac AND g_detail_d[l_ac].pshbseq IS NOT NULL THEN
               LET l_cmd='u'
               #160512-00016#3 20160520 add by ming -----(S) 
               LET g_detail_d_o.* = g_detail_d[l_ac].*
               #160512-00016#3 20160520 add by ming -----(E) 
               LET g_detail_d_t.* = g_detail_d[l_ac].*
               
               OPEN apsp510_bcl USING g_enterprise,g_site,g_master_m.psha001,
                                      g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,
                                      g_detail_d[l_ac].pshbseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apsp510_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw = 'Y'
               ELSE
                  FETCH apsp510_bcl INTO g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,
                                         g_detail_d[l_ac].pshbseq2,g_detail_d[l_ac].pshb002,
                                         g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb005,
                                         g_detail_d[l_ac].pshb004,g_detail_d[l_ac].pshb006
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_detail_d[l_ac].pshbseq
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
                  CALL apsp510_set_entry_b()
                  CALL apsp510_set_no_entry_b()
                  CALL apsp510_pshb002_ref()
                  CALL apsp510_pshb004_ref()
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_detail_d[l_ac].* TO NULL 
            
            LET g_detail_d_t.* = g_detail_d[l_ac].*
            CALL cl_show_fld_cont()
            
            SELECT MAX(pshbseq) + 1 INTO g_detail_d[l_ac].pshbseq
              FROM pshb_t
             WHERE pshbent = g_enterprise
               AND pshbsite= g_site
               AND pshb001 = g_master_m.psha001
            IF cl_null(g_detail_d[l_ac].pshbseq) THEN
               LET g_detail_d[l_ac].pshbseq = 1
            END IF
            
            LET g_detail_d[l_ac].pshbseq1 = 0
            LET g_detail_d[l_ac].pshbseq2 = 0
            LET g_detail_d[l_ac].pshb006 = g_today 
            
            #160512-00016#3 20160520 add by ming -----(S) 
            LET g_detail_d[l_ac].pshb007 = 'N'

            LET g_detail_d_o.* = g_detail_d[l_ac].*
            #160512-00016#3 20160520 add by ming -----(E) 
            
            LET g_detail_d_t.* = g_detail_d[l_ac].*
            
            CALL apsp510_set_entry_b()
            CALL apsp510_set_no_entry_b()
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count
              FROM pshb_t
             WHERE pshbent = g_enterprise
               AND pshbsite= g_site
               AND pshb001 = g_master_m.psha001
               AND pshbseq = g_detail_d[l_ac].pshbseq
               AND pshbseq1= g_detail_d[l_ac].pshbseq1
               AND pshbseq2= g_detail_d[l_ac].pshbseq2
               
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN  
               #160512-00016#3 20160520 modify by ming -----(S) 
               #INSERT INTO pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2,
               #                    pshb002,pshb003,pshb004,pshb005,pshb006)
               #   VALUES (g_enterprise,g_site,g_master_m.psha001,
               #           g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,g_detail_d[l_ac].pshbseq2,
               #           g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb004,
               #           g_detail_d[l_ac].pshb005,g_detail_d[l_ac].pshb006) 
               INSERT INTO pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2,
                                   pshb002,pshb003,pshb004,pshb005,pshb006,pshb007)
                  VALUES (g_enterprise,g_site,g_master_m.psha001,
                          g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,g_detail_d[l_ac].pshbseq2,
                          g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb004,
                          g_detail_d[l_ac].pshb005,g_detail_d[l_ac].pshb006,g_detail_d[l_ac].pshb007)
               #160512-00016#3 20160520 modify by ming -----(E) 
               IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins pshb_t'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')    
                  CANCEL INSERT
               END IF
               
               CALL apsp510_feature()
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_detail_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pshb_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_detail_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_detail_d.deleteElement(l_ac)
               NEXT FIELD pshbseq
            END IF
         
            IF g_detail_d[l_ac].pshbseq IS NOT NULL THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               DELETE FROM pshb_t
                WHERE pshbent = g_enterprise
                  AND pshbsite= g_site
                  AND pshb001 = g_master_m.psha001
                  AND pshbseq = g_detail_d_t.pshbseq
                  AND pshbseq1= g_detail_d_t.pshbseq1
                  AND pshbseq2= g_detail_d_t.pshbseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "del pshb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apsp510_bcl
               LET l_count = g_detail_d.getLength()
            END IF 
            
         AFTER FIELD pshbseq
            IF NOT cl_null(g_detail_d[l_ac].pshbseq) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_detail_d[l_ac].pshbseq != g_detail_d_t.pshbseq)) THEN  
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pshb_t WHERE "||"pshbent = '" ||g_enterprise|| "' AND "||"pshbsite = '"||g_site|| "' AND "||"pshb001 = '"||g_master_m.psha001 ||"' AND "|| "pshbseq = '"||g_detail_d[g_detail_idx].pshbseq||"' AND "|| "pshbseq1 = '"||g_detail_d[g_detail_idx].pshbseq1||"' AND "|| "pshbseq2 = '"||g_detail_d[g_detail_idx].pshbseq2 ||"'",'std-00004',0) THEN 
                     LET g_detail_d[l_ac].pshbseq = g_detail_d_t.pshbseq  
                     DISPLAY BY NAME g_detail_d[l_ac].pshbseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         AFTER FIELD pshb002
            LET g_detail_d[l_ac].pshb002_desc = ' '
            LET g_detail_d[l_ac].pshb002_desc_desc = ' '
            DISPLAY BY NAME g_detail_d[l_ac].pshb002_desc,g_detail_d[l_ac].pshb002_desc_desc
            IF NOT cl_null(g_detail_d[l_ac].pshb002) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_detail_d[l_ac].pshb002
               IF NOT cl_chk_exist("v_imaf001_1") THEN
                  LET g_detail_d[l_ac].pshb002 = g_detail_d_t.pshb002
                  DISPLAY BY NAME g_detail_d[l_ac].pshb002
                  CALL apsp510_pshb002_ref()
                  NEXT FIELD CURRENT
               ELSE
                  #預帶銷售單位
                  IF cl_null(g_detail_d[l_ac].pshb004) THEN
                     SELECT imaf112 INTO g_detail_d[l_ac].pshb004 
                       FROM imaf_t
                      WHERE imafent = g_enterprise
                        AND imafsite= g_site
                        AND imaf001 = g_detail_d[l_ac].pshb002
                        
                     DISPLAY BY NAME g_detail_d[l_ac].pshb004
                     CALL apsp510_pshb004_ref()
                  END IF 
                  
                  #160512-00016#3 20160520 add by ming -----(S) 
                  #預帶保稅否 
                  IF g_detail_d[l_ac].pshb002 <> g_detail_d_o.pshb002 OR 
                     cl_null(g_detail_d_o.pshb002) THEN
                     SELECT COALESCE(imaf034,'N') INTO g_detail_d[l_ac].pshb007
                       FROM imaf_t
                      WHERE imafent  = g_enterprise
                        AND imafsite = g_site
                        AND imaf001  = g_detail_d[l_ac].pshb002
                     DISPLAY BY NAME g_detail_d[l_ac].pshb007
                  END IF
                  #160512-00016#3 20160520 add by ming -----(E) 
               END IF
            END IF
            CALL apsp510_pshb002_ref()
            CALL apsp510_set_entry_b()
            CALL apsp510_set_no_entry_b()
            
            #160512-00016#3 20160520 add by ming -----(S) 
            LET g_detail_d_o.pshb002 = g_detail_d[l_ac].pshb002 
            #160512-00016#3 20160520 add by ming -----(E) 
            
         BEFORE FIELD pshb003
            IF l_cmd = 'a' AND NOT cl_null(g_detail_d[l_ac].pshb002) THEN
               CALL s_feature('a',g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb005,
                              g_site,g_master_m.psha001)
                    RETURNING l_success,g_inam
               LET g_detail_d[l_ac].pshb003 = g_inam[1].inam002
               LET g_detail_d[l_ac].pshb005 = g_inam[1].inam004
               DISPLAY BY NAME g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb005
            END IF
         
         #151224-00025#3 add start ------------------------
         AFTER FIELD pshb003
               IF cl_null(g_detail_d[l_ac].pshb003) THEN
                  LET g_detail_d[l_ac].pshb003 = ' '
               ELSE
                  IF g_detail_d[l_ac].pshb003 != g_detail_d_t.pshb003 OR g_detail_d_t.pshb003 IS NULL THEN
                     IF NOT s_feature_check(g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003) THEN
                        LET g_detail_d[l_ac].pshb003 = g_detail_d_t.pshb003
                        NEXT FIELD CURRENT
                     END IF
                     IF NOT s_feature_direct_input(g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d_t.pshb003,g_master_m.psha001,g_site) THEN
                        NEXT FIELD CURRENT
                     END IF 
                  END IF
               END IF
               LET g_detail_d_t.pshb003 = g_detail_d[l_ac].pshb003      
         #151224-00025#3 add end   ------------------------
         
         AFTER FIELD pshb005
            IF NOT cl_ap_chk_Range(g_detail_d[l_ac].pshb005,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD pshb005
            END IF
            
         AFTER FIELD pshb004
            LET g_detail_d[l_ac].pshb004_desc = ' '
            DISPLAY BY NAME g_detail_d[l_ac].pshb004_desc
            IF NOT cl_null(g_detail_d[l_ac].pshb004) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_detail_d[l_ac].pshb002
               LET g_chkparam.arg2 = g_detail_d[l_ac].pshb004
               IF NOT cl_chk_exist("v_imao002") THEN
                  LET g_detail_d[l_ac].pshb004 = g_detail_d_t.pshb004
                  DISPLAY BY NAME g_detail_d[l_ac].pshb004
                  CALL apsp510_pshb004_ref()
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL apsp510_pshb004_ref()
            
         ON ACTION controlp INFIELD pshb002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_detail_d[l_ac].pshb002
            CALL q_imaf001()
            LET g_detail_d[l_ac].pshb002 = g_qryparam.return1
            DISPLAY BY NAME g_detail_d[l_ac].pshb002
            CALL apsp510_pshb002_ref()
            NEXT FIELD pshb002
            
         ON ACTION controlp INFIELD pshb003
            IF l_cmd = 'u' THEN
               CALL s_feature_single(g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,
                                     g_site,g_master_m.psha001)
                    RETURNING l_success,g_detail_d[l_ac].pshb003
               IF NOT l_success THEN
                  LET g_detail_d[l_ac].pshb003 = g_detail_d_t.pshb003
                  DISPLAY BY NAME g_detail_d[l_ac].pshb003
               END IF
            END IF
            NEXT FIELD pshb003
            
         ON ACTION controlp INFIELD pshb004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_detail_d[l_ac].pshb004
            LET g_qryparam.arg1 = g_detail_d[l_ac].pshb002
            CALL q_imao002()
            LET g_detail_d[l_ac].pshb004 = g_qryparam.return1
            CALL apsp510_pshb004_ref()
            NEXT FIELD pshb004
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_detail_d[l_ac].* = g_detail_d_t.*
               CLOSE apsp510_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_detail_d[l_ac].pshbseq
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_detail_d[l_ac].* = g_detail_d_t.*
            ELSE 
               #160512-00016#3 20160520 modify by ming -----(S) 
               #UPDATE pshb_t SET (pshbseq,pshbseq1,pshbseq2,pshb002,pshb003,pshb004,pshb005,pshb006)
               #   = (g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,g_detail_d[l_ac].pshbseq2,
               #      g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb004,
               #      g_detail_d[l_ac].pshb005,g_detail_d[l_ac].pshb006)
               # WHERE pshbent = g_enterprise
               #   AND pshbsite= g_site
               #   AND pshb001 = g_master_m.psha001
               #   AND pshbseq = g_detail_d_t.pshbseq
               #   AND pshbseq1= g_detail_d_t.pshbseq1
               #   AND pshbseq2= g_detail_d_t.pshbseq2 
               UPDATE pshb_t SET (pshbseq,pshbseq1,pshbseq2,pshb002,pshb003,pshb004,pshb005,pshb006,pshb007)
                  = (g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,g_detail_d[l_ac].pshbseq2,
                     g_detail_d[l_ac].pshb002,g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb004,
                     g_detail_d[l_ac].pshb005,g_detail_d[l_ac].pshb006,g_detail_d[l_ac].pshb007)
                WHERE pshbent = g_enterprise
                  AND pshbsite= g_site
                  AND pshb001 = g_master_m.psha001
                  AND pshbseq = g_detail_d_t.pshbseq
                  AND pshbseq1= g_detail_d_t.pshbseq1
                  AND pshbseq2= g_detail_d_t.pshbseq2
               #160512-00016#3 20160520 modify by ming -----(E) 
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "upd pshb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_detail_d[l_ac].* = g_detail_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "upd pshb_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_detail_d[l_ac].* = g_detail_d_t.*                  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
               END CASE
            END IF
            
         AFTER ROW
            CLOSE apsp510_bcl
            CALL s_transaction_end('Y','0')
      END INPUT
      
      BEFORE DIALOG
         NEXT FIELD psha002
         
      ON ACTION accept  
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
         
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 新增資料
# Memo...........:
# Usage..........: CALL apsp510_insert()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_insert()

   #刪除舊資料
   IF NOT apsp510_psha_del(g_psha001) THEN
      RETURN
   END IF
   IF NOT apsp510_pshb_del(g_psha001) THEN
      RETURN
   END IF
   
   LET g_datetime = NULL
   
   #清畫面欄位內容
   CLEAR FORM
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   CALL g_detail3_d.clear()

   INITIALIZE g_master_m.* TO NULL
   LET g_master_m_t.* = g_master_m.*

   LET g_psha001 = NULL

   CALL s_transaction_begin()
   WHILE TRUE
      SELECT MAX(psha001)+1 INTO g_master_m.psha001
        FROM psha_t
       WHERE pshaent = g_enterprise
         AND pshasite= g_site
      IF cl_null(g_master_m.psha001) THEN 
         LET g_master_m.psha001 = 1
      END IF
      LET g_master_m.psha001 = g_master_m.psha001 USING '&&&&&'
      DISPLAY BY NAME g_master_m.psha001
      
      CALL apsp510_input("a")

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_master_m.* = g_master_m_t.*
         DISPLAY BY NAME g_master_m.psha002
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF

      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
   END WHILE

   CALL apsp510_b_fill()
   
   LET g_psha001 = g_master_m.psha001
END FUNCTION

################################################################################
# Descriptions...: 修改資料
# Memo...........:
# Usage..........: CALL apsp510_modify()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_modify()
   
   IF g_master_m.psha001 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   
   ERROR ""
  
   LET g_psha001 = g_master_m.psha001
 
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      LET g_master_m_t.* = g_master_m.*
      
      CALL apsp510_input("u")     #欄位更改
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_master_m.* = g_master_m_t.*
         DISPLAY BY NAME g_master_m.psha002
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9001
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()

         CALL s_transaction_end('N','0')
         EXIT WHILE
      END IF
     
      EXIT WHILE
   END WHILE
 
   CALL s_transaction_end('Y','0')
   
   CALL apsp510_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 資料刪除
# Memo...........:
# Usage..........: CALL apsp510_delete()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_delete()

   CALL s_transaction_begin()
   
   IF cl_ask_del_master() THEN
      LET g_psha001 = g_master_m.psha001
      IF NOT apsp510_psha_del(g_psha001) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      IF NOT apsp510_pshb_del(g_psha001) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      
      CLEAR FORM
      CALL g_detail_d.clear()
      CALL g_detail2_d.clear()
      CALL g_detail3_d.clear()
   END IF
   
   CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: 資料填充
# Memo...........:
# Usage..........: CALL apsp510_b_fill()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_b_fill()
DEFINE l_sql             STRING
DEFINE l_order           LIKE psoq_t.psoq004

   LET l_sql = "SELECT pshbseq,pshbseq1,pshbseq2,pshb002,imaal003,imaal004, ",
               #160512-00016#3 20160520 modify by ming -----(S) 
               #"       pshb003,pshb005,pshb004,oocal003,pshb006,'' ", 
               "       pshb003,pshb007,pshb005,pshb004,oocal003,pshb006,'' ",
               #160512-00016#3 20160520 modify by ming -----(E) 
               "  FROM pshb_t ",
               "       LEFT OUTER JOIN imaal_t ON imaalent = pshbent AND imaal001 = pshb002 AND imaal002 = '",g_dlang,"'",
               "       LEFT OUTER JOIN oocal_t ON oocalent = pshbent AND oocal001 = pshb004 AND oocal002 = '",g_dlang,"'",
               " WHERE pshbent = ",g_enterprise,
               "   AND pshbsite='",g_site,"'",
               "   AND pshb001 ='",g_master_m.psha001,"'",
               " ORDER BY pshbseq,pshbseq1,pshbseq2 "
   PREPARE apsp510_b_fill_pre FROM l_sql
   DECLARE apsp510_b_fill_cs CURSOR FOR apsp510_b_fill_pre
   
   LET l_ac = 1
   CALL g_detail_d.clear()
   FOREACH apsp510_b_fill_cs INTO g_detail_d[l_ac].pshbseq,g_detail_d[l_ac].pshbseq1,
                                  g_detail_d[l_ac].pshbseq2,g_detail_d[l_ac].pshb002,
                                  g_detail_d[l_ac].pshb002_desc,g_detail_d[l_ac].pshb002_desc_desc, 
                                  #160512-00016#3 20160520 modify by ming -----(S) 
                                  #g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb005, 
                                  g_detail_d[l_ac].pshb003,g_detail_d[l_ac].pshb007,
                                  g_detail_d[l_ac].pshb005,
                                  #160512-00016#3 20160520 modify by ming -----(E) 
                                  g_detail_d[l_ac].pshb004,g_detail_d[l_ac].pshb004_desc,
                                  g_detail_d[l_ac].pshb006,g_detail_d[l_ac].psoq024
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF NOT cl_null(g_datetime) THEN
         LET l_order = g_master_m.psha001 CLIPPED,"-",g_detail_d[l_ac].pshbseq USING '<<<<<',"-",
                       g_detail_d[l_ac].pshbseq1 USING '<<<<&',"-",
                       g_detail_d[l_ac].pshbseq2 USING '<<<<&'
         SELECT psoq024 INTO g_detail_d[l_ac].psoq024
           FROM psoq_t
          WHERE psoqent = g_enterprise
            AND psoqsite= g_site
            AND psoq001 = g_master_m.psha001
            AND psoq002 = g_datetime
            AND psoq004 = l_order
      END IF 
      
      #160512-00016#3 20160520 add by ming -----(S) 
      IF cl_null(g_detail_d[l_ac].pshb007) THEN
         SELECT imaf034 INTO g_detail_d[l_ac].pshb007
           FROM imaf_t
          WHERE imafent  = g_enterprise
            AND imafsite = g_site
            AND imaf001  = g_detail_d[l_ac].pshb002
      END IF
      #160512-00016#3 20160520 add by ming -----(E) 
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_ac = l_ac - 1
   LET g_detail_cnt = l_ac
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   
   FREE apsp510_b_fill_pre
END FUNCTION

################################################################################
# Descriptions...: 料號的品名、規格
# Memo...........:
# Usage..........: CALL apsp510_pshb002_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_pshb002_ref()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].pshb002
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","")
        RETURNING g_rtn_fields
   LET g_detail_d[l_ac].pshb002_desc = '', g_rtn_fields[1] , ''
   LET g_detail_d[l_ac].pshb002_desc_desc = '', g_rtn_fields[2] , ''
   
   DISPLAY BY NAME g_detail_d[l_ac].pshb002_desc,g_detail_d[l_ac].pshb002_desc_desc
END FUNCTION

################################################################################
# Descriptions...: 單位的說明
# Memo...........:
# Usage..........: CALL apsp510_pshb004_ref()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_pshb004_ref()

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_detail_d[l_ac].pshb004
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","")
        RETURNING g_rtn_fields
   LET g_detail_d[l_ac].pshb004_desc = '', g_rtn_fields[1] , ''
   
   DISPLAY BY NAME g_detail_d[l_ac].pshb004_desc
END FUNCTION

################################################################################
# Descriptions...: 欄位開啟
# Memo...........:
# Usage..........: CALL apsp510_set_entry_b()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_set_entry_b()

   CALL cl_set_comp_entry("pshb003",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉
# Memo...........:
# Usage..........: CALL apsp510_set_no_entry_b()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_set_no_entry_b()
DEFINE l_imaa005         LIKE imaa_t.imaa005

   SELECT imaa005 INTO l_imaa005 
     FROM imaa_t
    WHERE imaaent = g_enterprise
      AND imaa001 = g_detail_d[g_detail_idx].pshb002
   IF cl_null(l_imaa005) THEN
      CALL cl_set_comp_entry("pshb003",FALSE)
      LET g_detail_d[g_detail_idx].pshb003 = ' '
      DISPLAY BY NAME g_detail_d[g_detail_idx].pshb003
   END IF
END FUNCTION

################################################################################
# Descriptions...: 產品特徵
# Memo...........:
# Usage..........: CALL apsp510_feature()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/06 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_feature()
DEFINE l_pshbseq         LIKE pshb_t.pshbseq
DEFINE l_i               LIKE type_t.num5

   IF g_inam.getLength() <= 1 THEN
      RETURN
   END IF
   
   LET l_pshbseq = 0
   SELECT MAX(pshbseq) INTO l_pshbseq
     FROM pshb_t
    WHERE pshbent = g_enterprise
      AND pshbsite= g_site
      AND pshb001 = g_master_m.psha001
   IF cl_null(l_pshbseq) THEN
      LET l_pshbseq = 0
   END IF
   
   FOR l_i = 2 TO g_inam.getLength()
      IF cl_null(g_inam[l_i].inam002) THEN
         CONTINUE FOR
      END IF
      
      LET l_pshbseq = l_pshbseq + 1
      
      INSERT INTO pshb_t (pshbent,pshbsite,pshb001,pshbseq,pshbseq1,pshbseq2,
                          pshb002,pshb003,pshb004,pshb005,pshb006)
         VALUES (g_enterprise,g_site,g_master_m.psha001,l_pshbseq,0,0,
                 g_detail_d[l_ac].pshb002,g_inam[l_i].inam002,g_detail_d[l_ac].pshb004,
                 g_inam[l_i].inam004,g_detail_d[l_ac].pshb006)
   END FOR
   CALL g_inam.clear()
   
   CALL apsp510_b_fill()
END FUNCTION

################################################################################
# Descriptions...: 交期明細單身資料填充
# Memo...........:
# Usage..........: CALL apsp510_b_fill2()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/10 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_b_fill2()
DEFINE l_order           STRING
DEFINE l_sql             STRING

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      RETURN
   END IF
   
   IF cl_null(g_datetime) THEN
      RETURN
   END IF
   
   LET l_order = g_master_m.psha001 CLIPPED,"-",g_detail_d[g_detail_idx].pshbseq USING '<<<<<',"-",
                 g_detail_d[g_detail_idx].pshbseq1 USING '<<<<&',"-",
                 g_detail_d[g_detail_idx].pshbseq2 USING '<<<<&'
   
   LET l_sql = "SELECT pson004,pson005 ",
               "  FROM pson_t ",
               " WHERE psonent = ",g_enterprise,
               "   AND psonsite='",g_site,"'",
               "   AND pson001 ='",g_master_m.psha001,"'",
               "   AND pson002 ='",g_datetime,"'",
               "   AND pson003 ='",l_order,"'",
               " ORDER BY pson004 "
   PREPARE apsp510_b_fill2_pre FROM l_sql
   DECLARE apsp510_b_fill2_cs CURSOR FOR apsp510_b_fill2_pre
   
   LET l_ac = 1
   CALL g_detail2_d.clear()
   FOREACH apsp510_b_fill2_cs INTO g_detail2_d[l_ac].pson004,g_detail2_d[l_ac].pson005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_ac = l_ac - 1
   LET g_detail2_cnt = l_ac
   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
   
   FREE apsp510_b_fill2_pre
   
END FUNCTION

################################################################################
# Descriptions...: 供需匯總狀況單身填充
# Memo...........:
# Usage..........: CALL apsp510_b_fill3()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/10 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_b_fill3()
DEFINE l_sql             STRING
#mod--161109-00085#16 By 08993--(s)
#DEFINE l_psoz            RECORD LIKE psoz_t.*   #mark--161109-00085#16 By 08993--(s)
DEFINE l_psoz            RECORD  #MRP結果檔
       psozent LIKE psoz_t.psozent, #企業編號
       psozsite LIKE psoz_t.psozsite, #營運據點
       psoz001 LIKE psoz_t.psoz001, #APS版本
       psoz002 LIKE psoz_t.psoz002, #執行日期時間
       psoz003 LIKE psoz_t.psoz003, #流水編號
       psoz004 LIKE psoz_t.psoz004, #供需日期
       psoz005 LIKE psoz_t.psoz005, #訂單未交量
       psoz006 LIKE psoz_t.psoz006, #計畫出貨量
       psoz007 LIKE psoz_t.psoz007, #安全庫存量
       psoz008 LIKE psoz_t.psoz008, #ATP需求量
       psoz009 LIKE psoz_t.psoz009, #訂單未交替他需求量
       psoz010 LIKE psoz_t.psoz010, #預測替他需求量
       psoz011 LIKE psoz_t.psoz011, #ATP替他需求量
       psoz012 LIKE psoz_t.psoz012, #計劃備料量
       psoz013 LIKE psoz_t.psoz013, #計劃備料替他需求量
       psoz014 LIKE psoz_t.psoz014, #工單備料量
       psoz015 LIKE psoz_t.psoz015, #工單備料替他需求量
       psoz016 LIKE psoz_t.psoz016, #備料重排減少量
       psoz017 LIKE psoz_t.psoz017, #備料重排增加量
       psoz018 LIKE psoz_t.psoz018, #庫存單位數量
       psoz019 LIKE psoz_t.psoz019, #採購待入庫數量
       psoz020 LIKE psoz_t.psoz020, #替代庫存量
       psoz021 LIKE psoz_t.psoz021, #請購量
       psoz022 LIKE psoz_t.psoz022, #待進貨量
       psoz023 LIKE psoz_t.psoz023, #待撥入量
       psoz024 LIKE psoz_t.psoz024, #未發放在製量
       psoz025 LIKE psoz_t.psoz025, #已發放在製量
       psoz026 LIKE psoz_t.psoz026, #替代請購量
       psoz027 LIKE psoz_t.psoz027, #替代採購進貨數量
       psoz028 LIKE psoz_t.psoz028, #替代在製量
       psoz029 LIKE psoz_t.psoz029, #重排減少量
       psoz030 LIKE psoz_t.psoz030, #重排增加量
       psoz031 LIKE psoz_t.psoz031, #預估結存
       psoz032 LIKE psoz_t.psoz032, #規劃採購量
       psoz033 LIKE psoz_t.psoz033, #替代規劃採購量
       psoz034 LIKE psoz_t.psoz034, #規劃製造量
       psoz035 LIKE psoz_t.psoz035, #替代規劃製造量
       psoz036 LIKE psoz_t.psoz036, #預計結存
       psoz037 LIKE psoz_t.psoz037, #規劃結存
       psoz038 LIKE psoz_t.psoz038, #品號
       psoz039 LIKE psoz_t.psoz039, #品號特徵碼
       psoz040 LIKE psoz_t.psoz040, #時距編號(GUID)
       psoz041 LIKE psoz_t.psoz041, #採購在驗數量
       psoz042 LIKE psoz_t.psoz042, #行政保留量
       psoz043 LIKE psoz_t.psoz043, #保稅否
       psoz044 LIKE psoz_t.psoz044  #替代採購在驗數量
          END RECORD
#mod--161109-00085#16 By 08993--(e)

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      RETURN
   END IF
   
   IF cl_null(g_datetime) THEN
      RETURN
   END IF
                
   LET l_sql = "SELECT psoz004,psoz018,psoz037, ",
               "       psoz005,psoz006,psoz007,psoz009,psoz010,psoz011,psoz012,psoz013,psoz014,psoz015, ",
               "       psoz016,psoz017, ",
               "       psoz020,psoz021,psoz022,psoz023,psoz024,psoz025,psoz026,psoz027,psoz028,psoz029, ",
               "       psoz030,psoz032,psoz033,psoz034,psoz035 ",
               "  FROM psoz_t ",
               " WHERE psozent = ",g_enterprise,
               "   AND psozsite='",g_site,"'",
               "   AND psoz001 ='",g_master_m.psha001,"'",
               "   AND psoz002 ='",g_datetime,"'",
               "   AND psoz038 ='",g_detail_d[g_detail_idx].pshb002,"'",
               "   AND NVL(psoz039,' ') = NVL('",g_detail_d[g_detail_idx].pshb003,"',' ')",
               " ORDER BY psoz004 "
   PREPARE apsp510_b_fill3_pre FROM l_sql
   DECLARE apsp510_b_fill3_cs CURSOR FOR apsp510_b_fill3_pre
   
   LET l_ac = 1
   CALL g_detail3_d.clear()
   FOREACH apsp510_b_fill3_cs INTO g_detail3_d[l_ac].psoz004,g_detail3_d[l_ac].psoz018,
                                   g_detail3_d[l_ac].psoz037,
                                   l_psoz.psoz005,l_psoz.psoz006,l_psoz.psoz007,l_psoz.psoz009,l_psoz.psoz010,
                                   l_psoz.psoz011,l_psoz.psoz012,l_psoz.psoz013,l_psoz.psoz014,l_psoz.psoz015,
                                   l_psoz.psoz016,l_psoz.psoz017,
                                   l_psoz.psoz020,l_psoz.psoz021,l_psoz.psoz022,l_psoz.psoz023,l_psoz.psoz024,
                                   l_psoz.psoz025,l_psoz.psoz026,l_psoz.psoz027,l_psoz.psoz028,l_psoz.psoz029,
                                   l_psoz.psoz030,l_psoz.psoz032,l_psoz.psoz033,l_psoz.psoz034,l_psoz.psoz035
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      IF cl_null(l_psoz.psoz005) THEN LET l_psoz.psoz005 = 0 END IF
      IF cl_null(l_psoz.psoz006) THEN LET l_psoz.psoz006 = 0 END IF
      IF cl_null(l_psoz.psoz007) THEN LET l_psoz.psoz007 = 0 END IF
      IF cl_null(l_psoz.psoz009) THEN LET l_psoz.psoz009 = 0 END IF
      IF cl_null(l_psoz.psoz010) THEN LET l_psoz.psoz010 = 0 END IF
      IF cl_null(l_psoz.psoz011) THEN LET l_psoz.psoz011 = 0 END IF
      IF cl_null(l_psoz.psoz012) THEN LET l_psoz.psoz012 = 0 END IF
      IF cl_null(l_psoz.psoz013) THEN LET l_psoz.psoz013 = 0 END IF
      IF cl_null(l_psoz.psoz014) THEN LET l_psoz.psoz014 = 0 END IF
      IF cl_null(l_psoz.psoz015) THEN LET l_psoz.psoz015 = 0 END IF
      IF cl_null(l_psoz.psoz016) THEN LET l_psoz.psoz016 = 0 END IF
      IF cl_null(l_psoz.psoz017) THEN LET l_psoz.psoz017 = 0 END IF
      
      IF cl_null(l_psoz.psoz020) THEN LET l_psoz.psoz020 = 0 END IF
      IF cl_null(l_psoz.psoz021) THEN LET l_psoz.psoz021 = 0 END IF
      IF cl_null(l_psoz.psoz022) THEN LET l_psoz.psoz022 = 0 END IF
      IF cl_null(l_psoz.psoz023) THEN LET l_psoz.psoz023 = 0 END IF
      IF cl_null(l_psoz.psoz024) THEN LET l_psoz.psoz024 = 0 END IF
      IF cl_null(l_psoz.psoz025) THEN LET l_psoz.psoz025 = 0 END IF
      IF cl_null(l_psoz.psoz026) THEN LET l_psoz.psoz026 = 0 END IF
      IF cl_null(l_psoz.psoz027) THEN LET l_psoz.psoz027 = 0 END IF
      IF cl_null(l_psoz.psoz028) THEN LET l_psoz.psoz028 = 0 END IF
      IF cl_null(l_psoz.psoz029) THEN LET l_psoz.psoz029 = 0 END IF
      IF cl_null(l_psoz.psoz030) THEN LET l_psoz.psoz030 = 0 END IF
      IF cl_null(l_psoz.psoz032) THEN LET l_psoz.psoz032 = 0 END IF
      IF cl_null(l_psoz.psoz033) THEN LET l_psoz.psoz033 = 0 END IF
      IF cl_null(l_psoz.psoz034) THEN LET l_psoz.psoz034 = 0 END IF
      IF cl_null(l_psoz.psoz035) THEN LET l_psoz.psoz035 = 0 END IF
      
      #供給量
      LET g_detail3_d[l_ac].qty1 = l_psoz.psoz020 + l_psoz.psoz021 + l_psoz.psoz022 
                                 + l_psoz.psoz023 + l_psoz.psoz024 + l_psoz.psoz025
                                 + l_psoz.psoz026 + l_psoz.psoz027 + l_psoz.psoz028
                                 - l_psoz.psoz029 + l_psoz.psoz030 + l_psoz.psoz032
                                 + l_psoz.psoz033 + l_psoz.psoz034 + l_psoz.psoz035
                                 
      #需求量
      LET g_detail3_d[l_ac].qty2 = l_psoz.psoz005 + l_psoz.psoz006 + l_psoz.psoz007
                                 + l_psoz.psoz009 + l_psoz.psoz010 + l_psoz.psoz011
                                 + l_psoz.psoz012 + l_psoz.psoz013 + l_psoz.psoz014
                                 + l_psoz.psoz015 - l_psoz.psoz016 + l_psoz.psoz017
                                 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_ac = l_ac - 1
   LET g_detail3_cnt = l_ac
   CALL g_detail3_d.deleteElement(g_detail3_d.getLength())
   
   FREE apsp510_b_fill3_pre
END FUNCTION

################################################################################
# Descriptions...: 供需明細資料單身填充
# Memo...........:
# Usage..........: CALL apsp510_b_fill4()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 2014/06/10 By stellar0130
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_b_fill4()
DEFINE l_sql             STRING
DEFINE l_gzcb003         LIKE gzcb_t.gzcb003

   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      RETURN
   END IF
   
   IF cl_null(g_datetime) THEN
      RETURN
   END IF
   
   LET l_sql = "SELECT pspa011,pspa020,pspa006,pspa009 ",
               "  FROM pspa_t ",
               " WHERE pspaent = ",g_enterprise,
               "   AND pspasite='",g_site,"'",
               "   AND pspa001 ='",g_master_m.psha001,"'",
               "   AND pspa002 ='",g_datetime,"'",
               "   AND pspa012 ='",g_detail_d[g_detail_idx].pshb002,"'",
               "   AND NVL(pspa013,' ') = NVL('",g_detail_d[g_detail_idx].pshb003,"',' ')",
               " ORDER BY pspa011 "
   PREPARE apsp510_b_fill4_pre FROM l_sql
   DECLARE apsp510_b_fill4_cs CURSOR FOR apsp510_b_fill4_pre
   
   LET l_ac = 1
   CALL g_detail4_d.clear()
   FOREACH apsp510_b_fill4_cs INTO g_detail4_d[l_ac].pspa011,g_detail4_d[l_ac].pspa020,
                                   g_detail4_d[l_ac].pspa006,g_detail4_d[l_ac].pspa009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #避免計算時有空值
      IF g_detail4_d[l_ac].pspa009 IS NULL THEN
         LET g_detail4_d[l_ac].pspa009 = 0
      END IF
      
      #抓取系統應用欄位一來決定正負
      LET l_gzcb003 = 0
      SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb001 = '5440'
         AND gzcb002 = g_detail4_d[l_ac].pspa020
      IF cl_null(l_gzcb003) THEN LET l_gzcb003 = 0 END IF
      
      IF l_ac = 1 THEN
         LET g_detail4_d[l_ac].qty = g_detail4_d[l_ac].pspa009 * l_gzcb003
      ELSE
         LET g_detail4_d[l_ac].qty = (g_detail4_d[l_ac].pspa009 * l_gzcb003) + g_detail4_d[l_ac-1].qty
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
   END FOREACH

   LET l_ac = l_ac - 1
   LET g_detail4_cnt = l_ac
   CALL g_detail4_d.deleteElement(g_detail4_d.getLength())
   
   FREE apsp510_b_fill4_pre
END FUNCTION

################################################################################
# Descriptions...: 刪除程式異常關閉後殘留的資料
# Memo...........:
# Usage..........: CALL apsp510_residues_data()
#                  
# Input parameter: 
# Return code....: 
# Date & Author..: 2014/09/24 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsp510_residues_data()
DEFINE l_psha001         LIKE psha_t.psha001
DEFINE l_psha003         LIKE psha_t.psha003
DEFINE ls_cmd            STRING
DEFINE l_ch              base.Channel
DEFINE ls_buf            STRING
DEFINE l_success         LIKE type_t.num5

   LET l_success = TRUE

   DECLARE sel_psha003_cs CURSOR FOR
    SELECT psha001,psha003 
      FROM psha_t
     WHERE pshaent = g_enterprise
       AND pshasite= g_site
   
   FOREACH sel_psha003_cs INTO l_psha001,l_psha003
      
      IF NOT cl_null(l_psha003) THEN
         #判斷是否為異常關閉
         LET l_ch = base.Channel.create()
         CALL l_ch.setDelimiter("")
         LET ls_cmd = "ps -ef|grep ",l_psha003," | grep -v 'grep'"
         CALL l_ch.openPipe(ls_cmd,"r")
         
         WHILE TRUE
            CALL l_ch.readLine() RETURNING ls_buf
            IF ls_buf IS NULL THEN
               #若沒值，表示程式曾經異常關閉 (有值表示程式還開著)
               CALL apsp510_psha_del(l_psha001) RETURNING l_success
               CALL apsp510_pshb_del(l_psha001) RETURNING l_success
            END IF
            
            EXIT WHILE
         END WHILE
         
         CALL l_ch.close()
         LET ls_buf = ''
      ELSE
         CALL apsp510_psha_del(l_psha001) RETURNING l_success
         CALL apsp510_pshb_del(l_psha001) RETURNING l_success
      END IF
      
      IF NOT l_success THEN
         EXIT FOREACH
      END IF
   END FOREACH
   
END FUNCTION

#end add-point
 
{</section>}
 
