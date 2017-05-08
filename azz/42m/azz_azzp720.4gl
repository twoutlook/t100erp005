#該程式未解開Section, 採用最新樣板產出!
{<section id="azzp720.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(1900-01-01 00:00:00), PR版次:0001(2016-03-25 18:11:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: azzp720
#+ Description: send傳送機制
#+ Creator....: 00845(2016-03-25 17:57:00)
#+ Modifier...: 00000 -SD/PR- 00845
 
{</section>}
 
{<section id="azzp720.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
IMPORT FGL lib_cl_schedule
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
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

 TYPE type_parameter RECORD
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
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzp720.main" >}
#+ 作業開始
MAIN
   #add-point:main段define name="main.define"
   DEFINE li_return LIKE type_t.num5
   #end add-point    
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point
 
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   LET g_bgjob = "Y"
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
 
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)    #轉換不同資料庫語法
   DECLARE azzp720_cl CURSOR FROM g_forupd_sql 
   
   IF g_bgjob = "Y" THEN
 
      #add-point:Service Call name="main.servicecall"
      LET li_return = s_barcode_datause_msgcenrer(g_argv[1])
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzp720 WITH FORM cl_ap_formpath("azz",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL azzp720_init()
 
      #進入選單 Menu (='N')
      CALL azzp720_ui_dialog()
   
      #畫面關閉
      CLOSE WINDOW w_azzp720
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
 
END MAIN
 
{</section>}
 
{<section id="azzp720.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION azzp720_get_buffer(p_dialog)

   #add-point:process段define (客製用)

   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define

   #end add-point



   CALL cl_schedule_get_buffer(p_dialog)

   #add-point:get_buffer段其他欄位處理

   #end add-point
END FUNCTION

PRIVATE FUNCTION azzp720_init()

   #add-point:init段define (客製用)

   #end add-point
   #add-point:ui_dialog段define

   #end add-point

   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF
   #add-point:畫面資料初始化

   #end add-point

END FUNCTION

PRIVATE FUNCTION azzp720_msgcentre_notify()

   #add-point:process段define (客製用)

   #end add-point
   DEFINE lc_state LIKE type_t.chr5
   #add-point:process段define

   #end add-point

   INITIALIZE g_msgparam TO NULL

   #action-id與狀態填寫
   LET g_msgparam.state = "process"

   #add-point:msgcentre其他通知

   #end add-point

   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()

END FUNCTION

PRIVATE FUNCTION azzp720_process(ls_js)

   #add-point:process段define (客製用)

   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define

   #end add-point

  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處

  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF

   #add-point:process段前處理

   #end add-point

   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress

      #end add-point
   END IF

   #主SQL及相關FOREACH前置處理
#  DECLARE azzp720_process_cs CURSOR FROM ls_sql
#  FOREACH azzp720_process_cs INTO
   #add-point:process段process

   #end add-point
#  END FOREACH

   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理

      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理

      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF

   #呼叫訊息中心傳遞本關完成訊息
   CALL azzp720_msgcentre_notify()

END FUNCTION

PRIVATE FUNCTION azzp720_transfer_argv(ls_js)

   #add-point:transfer_agrv段define (客製用)

   #end add-point
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog       STRING,
             actionid   STRING,
             background LIKE type_t.chr1,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
   #add-point:transfer_agrv段define

   #end add-point

   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js

   #add-point:transfer.argv段程式內容

   #end add-point

   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION

PRIVATE FUNCTION azzp720_ui_dialog()

   #add-point:ui_dialog段define (客製用)

   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define

   #end add-point

   #add-point:ui_dialog段before dialog

   #end add-point

   WHILE TRUE
      #add-point:ui_dialog段before dialog2

      #end add-point

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)




         #add-point:ui_dialog段construct

         #end add-point
         #add-point:ui_dialog段input

         #end add-point
         #add-point:ui_dialog段自定義display array

         #end add-point

         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history

         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL azzp720_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog

            #end add-point

         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG

         #add-point:ui_dialog段before_qbeclear

         #end add-point

         ON ACTION qbeclear
            CLEAR FORM
            INITIALIZE g_master.* TO NULL   #畫面變數清空
            INITIALIZE lc_param.* TO NULL   #傳遞參數變數清空
            #add-point:ui_dialog段qbeclear

            #end add-point

         ON ACTION history_fill
            CALL cl_schedule_history_fill()

         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

         #add-point:ui_dialog段action

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
         CALL azzp720_init()
         CONTINUE WHILE
      END IF

      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF

      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog

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
                 CALL azzp720_process(ls_js)

            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = azzp720_transfer_argv(ls_js)
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

         #add-point:ui_dialog段after schedule

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

#end add-point
 
{</section>}
 
