#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-03 15:31:29), PR版次:0003(2016-03-31 19:01:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: azzp810
#+ Description: 每日排名清單統計填值
#+ Creator....: 00845(2014-12-18 17:50:56)
#+ Modifier...: 00845 -SD/PR- 07025
 
{</section>}
 
{<section id="azzp810.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Modify.........: No.160330-00012#1 16/03/31 By catmoon 將CALL cl_progress_no_window_ing(參數)參數有中文的情形改由變數帶入
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
       loga006 LIKE type_t.dat, 
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
 
{<section id="azzp810.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      display '背景執行!'
      #end add-point
      CALL azzp810_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp810 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp810_init()
 
      #進入選單 Menu (="N")
      CALL azzp810_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_azzp810
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="azzp810.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp810_init()
 
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
 
{<section id="azzp810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp810_ui_dialog()
 
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
         INPUT BY NAME g_master.loga006 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.loga006 = cl_get_today()
               DISPLAY BY NAME g_master.loga006
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD loga006
            #add-point:BEFORE FIELD loga006 name="input.b.loga006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD loga006
            
            #add-point:AFTER FIELD loga006 name="input.a.loga006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE loga006
            #add-point:ON CHANGE loga006 name="input.g.loga006"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.loga006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD loga006
            #add-point:ON ACTION controlp INFIELD loga006 name="input.c.loga006"
            
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
            CALL azzp810_get_buffer(l_dialog)
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
         CALL azzp810_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.wc = ":YESTERDAY"
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
                 CALL azzp810_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp810_transfer_argv(ls_js)
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
 
{<section id="azzp810.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp810_transfer_argv(ls_js)
 
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
 
{<section id="azzp810.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION azzp810_process(ls_js)
 
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
      #確認loga, 確認gzzh, 寫入gzzh
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp810_process_cs CURSOR FROM ls_sql
#  FOREACH azzp810_process_cs INTO
   #add-point:process段process name="process.process"
 
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF NOT azzp810_write_gzzh(g_master.loga006) THEN
         RETURN
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      DISPLAY '進入背景執行模式, 準備寫入gzzh!'
      LET lc_param.wc = cl_replace_str(lc_param.wc,'-','/')
      DISPLAY '指定日期為:',lc_param.wc
      IF NOT azzp810_write_gzzh(lc_param.wc) THEN
         RETURN
      END IF
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp810_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="azzp810.get_buffer" >}
PRIVATE FUNCTION azzp810_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.loga006 = p_dialog.getFieldBuffer('loga006')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzp810.msgcentre_notify" >}
PRIVATE FUNCTION azzp810_msgcentre_notify()
 
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
 
{<section id="azzp810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzp810_write_gzzh(ps_date)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   log轉換日期(YY/MM/DD)
# Return code....: 回传参数变量1   轉換成功否
# Date & Author..: 2015/06/04 By ka0132
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp810_write_gzzh(ps_date)
   DEFINE ps_date        STRING #寫入日期
   DEFINE ls_gzzh_wc     STRING #組合出撈取的gzzh條件
   DEFINE ls_loga_wc     STRING #組合出撈取的loga條件
   DEFINE ls_sql         STRING
   DEFINE ls_info        STRING
   DEFINE li_cnt         INTEGER
   DEFINE lr_gzzh        RECORD 
          gzzh001        LIKE gzzh_t.gzzh001,
          gzzh002        LIKE gzzh_t.gzzh002,
          gzzh003        LIKE gzzh_t.gzzh003,
          gzzh004        LIKE gzzh_t.gzzh004,
          gzzh005        LIKE gzzh_t.gzzh005
          END RECORD
         
   CALL s_transaction_begin()
   
   #轉換為區間
   LET ls_gzzh_wc = " gzzhent = '",g_enterprise USING "<<<<<<","' AND ",
                    " gzzh005 BETWEEN ",
                    " TO_DATE('", ps_date, " 00:00:00','YY/MM/DD HH24:MI:SS') AND ",
                    " TO_DATE('", ps_date, " 23:59:59','YY/MM/DD HH24:MI:SS') "
   LET ls_loga_wc = " logaent = '",g_enterprise USING "<<<<<<","' AND ",
                    " loga006 BETWEEN ",
                    " TO_DATE('", ps_date, " 00:00:00','YY/MM/DD HH24:MI:SS') AND ",
                    " TO_DATE('", ps_date, " 23:59:59','YY/MM/DD HH24:MI:SS') "
   
   #檢查是否已有資料(gzzh_t)
   LET li_cnt = 0
   LET ls_sql = "SELECT COUNT(*) FROM gzzh_t WHERE ",ls_gzzh_wc
   PREPARE gzzh_cnt_pre FROM ls_sql
   EXECUTE gzzh_cnt_pre INTO li_cnt
   DISPLAY SQLCA.sqlcode
   IF li_cnt > 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = 'azz-00808'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF
   LET ls_info = cl_getmsg_parm("azz-01000", g_lang,'gzzh_t' ) #160330-00012#1 add
   IF g_bgjob = 'N' THEN
     #CALL cl_progress_no_window_ing("檢查是否已有資料(gzzh_t)")   #160330-00012#1 mark
      CALL cl_progress_no_window_ing(ls_info)                     #160330-00012#1 add
   ELSE
     #DISPLAY "檢查是否已有資料(gzzh_t)"   #160330-00012#1 mark
      DISPLAY ls_info                     #160330-00012#1 add
   END IF
   
   #檢查是否已有資料(loga_t)
   LET li_cnt = 0
   LET ls_sql = "SELECT COUNT(*) FROM loga_t WHERE ",ls_loga_wc
   PREPARE loga_cnt_pre FROM ls_sql
   EXECUTE loga_cnt_pre INTO li_cnt
   DISPLAY SQLCA.sqlcode
   IF li_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.code   = 'azz-00809'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      RETURN FALSE
   ELSE
     #DISPLAY '該日期共有',li_cnt USING "<<<<<<<",'筆log紀錄!' #160330-00012#1 mark
      LET ls_info = cl_getmsg_parm("azz-01001", g_lang,li_cnt USING "<<<<<<<" ) #160330-00012#1 add
      DISPLAY ls_info
   END IF
   LET ls_info = cl_getmsg_parm("azz-01000", g_lang,'loga_t' )  #160330-00012#1 add
   IF g_bgjob = 'N' THEN
     #CALL cl_progress_no_window_ing("檢查是否已有資料(loga_t)")       #160330-00012#1 mark
      CALL cl_progress_no_window_ing(ls_info)                        #160330-00012#1 add
   ELSE
     #DISPLAY "檢查是否已有資料(loga_t)"    #160330-00012#1 mark
      DISPLAY ls_info                     #160330-00012#1 add
   END IF
   
   #準備寫入資料到gzzh_t
   LET ls_sql = 
      " SELECT loga001,COUNT(*),loga002,SUM(TRUNC((CAST(loga007 as date)-CAST(loga006 as date))*24*60*60)),TO_DATE('", ps_date, " 00:00:00','YY/MM/DD HH24:MI:SS') ",
      "   FROM loga_t ",
      "  WHERE ", ls_loga_wc,
      "  GROUP BY loga001,loga002 "
   
   PREPARE loga_pre FROM ls_sql
   DECLARE loga_cur CURSOR FOR loga_pre

   LET ls_sql = " INSERT INTO gzzh_t (gzzhent,gzzh001,gzzh002,gzzh003,gzzh004,gzzh005) VALUES (?,?,?,?,?,?) "
   
   PREPARE gzzh_pre FROM ls_sql
   
   LET li_cnt = 0
   FOREACH loga_cur INTO lr_gzzh.gzzh001,lr_gzzh.gzzh002,lr_gzzh.gzzh003,lr_gzzh.gzzh004,lr_gzzh.gzzh005
      IF cl_null(lr_gzzh.gzzh004) THEN
         LET lr_gzzh.gzzh004 = 0
      END IF
      
      EXECUTE gzzh_pre USING g_enterprise,
                             lr_gzzh.gzzh001,
                             lr_gzzh.gzzh002,
                             lr_gzzh.gzzh003,
                             lr_gzzh.gzzh004,
                             lr_gzzh.gzzh005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CALL s_transaction_end('N','0')
         RETURN FALSE
      END IF
      LET li_cnt = li_cnt + 1
   END FOREACH
  #LET ls_info = "寫入資料到gzzh_t,共",li_cnt USING "<<<<<<<","筆!"  #160330-00012#1 mark
   LET ls_info = cl_getmsg_parm("azz-01002", g_lang,li_cnt USING "<<<<<<<" ) #160330-00012#1 add
   IF g_bgjob = 'N' THEN
      CALL cl_progress_no_window_ing(ls_info)
   ELSE
      DISPLAY ls_info
   END IF
    
   CALL s_transaction_end('Y','0')
   
   RETURN TRUE

END FUNCTION

#end add-point
 
{</section>}
 
