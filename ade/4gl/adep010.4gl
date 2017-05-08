#該程式未解開Section, 採用最新樣板產出!
{<section id="adep010.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-01-29 11:11:50), PR版次:0004(2016-10-12 13:41:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: adep010
#+ Description: 日結統計資料重計作業
#+ Creator....: 06137(2015-11-04 15:38:23)
#+ Modifier...: 06137 -SD/PR- 02749
 
{</section>}
 
{<section id="adep010.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
# Modify..........: #160819-00054#22   2016/10/05 By lori      1.增加批次apcp500至第1件工作項目
#                                                              2.astp508/astp509參數調整
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
       debasite LIKE deba_t.debasite, 
   l_deba002 LIKE type_t.dat, 
   l_week LIKE type_t.chr500, 
   l_month LIKE type_t.chr500, 
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
 
{<section id="adep010.main" >}
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
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep010_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep010 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep010_init()
 
      #進入選單 Menu (="N")
      CALL adep010_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep010
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep010.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep010_init()
 
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
 
{<section id="adep010.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep010_ui_dialog()
 
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
         INPUT BY NAME g_master.l_deba002,g_master.l_week,g_master.l_month 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_deba002
            #add-point:BEFORE FIELD l_deba002 name="input.b.l_deba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_deba002
            
            #add-point:AFTER FIELD l_deba002 name="input.a.l_deba002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_deba002
            #add-point:ON CHANGE l_deba002 name="input.g.l_deba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_week
            #add-point:BEFORE FIELD l_week name="input.b.l_week"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_week
            
            #add-point:AFTER FIELD l_week name="input.a.l_week"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_week
            #add-point:ON CHANGE l_week name="input.g.l_week"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_month
            #add-point:BEFORE FIELD l_month name="input.b.l_month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_month
            
            #add-point:AFTER FIELD l_month name="input.a.l_month"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_month
            #add-point:ON CHANGE l_month name="input.g.l_month"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_deba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_deba002
            #add-point:ON ACTION controlp INFIELD l_deba002 name="input.c.l_deba002"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_week
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_week
            #add-point:ON ACTION controlp INFIELD l_week name="input.c.l_week"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_month
            #add-point:ON ACTION controlp INFIELD l_month name="input.c.l_month"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON debasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.debasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debasite
            #add-point:ON ACTION controlp INFIELD debasite name="construct.c.debasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'i') 
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debasite  #顯示到畫面上
            NEXT FIELD debasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debasite
            #add-point:BEFORE FIELD debasite name="construct.b.debasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debasite
            
            #add-point:AFTER FIELD debasite name="construct.a.debasite"
            DISPLAY g_master.wc
            IF g_master.wc = ' 1=1 ' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'axc-00120'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD CURRENT
            END IF
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
            CALL adep010_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_site TO debasite            
            LET g_master.l_deba002 = g_today
            LET g_master.l_week = 'N'
            LET g_master.l_month = 'N'
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
         CALL adep010_init()
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
                 CALL adep010_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep010_transfer_argv(ls_js)
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
 
{<section id="adep010.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep010_transfer_argv(ls_js)
 
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
 
{<section id="adep010.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep010_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_loop        LIKE type_t.num5
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
      LET l_loop = 17
      IF (g_master.l_week = 'Y') THEN
         LET l_loop = l_loop + 6
      END IF
      IF (g_master.l_month = 'Y') THEN
         LET l_loop = l_loop + 6
      END IF      
      CALL cl_progress_bar_no_window(l_loop)   
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep010_process_cs CURSOR FROM ls_sql
#  FOREACH adep010_process_cs INTO
   #add-point:process段process name="process.process"
   CALL adep010_redo_apcp500()   #160819-00054#22 161005 by lori add
   
   CALL adep010_redo_adep200()   #151103-00003#2 Add By Ken 151208   
                                 
   CALL adep010_redo_astp510()   #151230-00004#1 Modify By Ken 151230 調整順序
   
   CALL adep010_redo_adep990()
     
   CALL adep010_redo_astp503()
   
   CALL adep010_redo_astp508()
   
   CALL adep010_redo_astp509()
   
   CALL adep010_redo_astp507()
   
   CALL adep010_redo_astp511()  

   CALL adep010_redo_astp515()
   
   CALL adep010_redo_astp512()   
      
   CALL adep010_redo_astp514()   #151103-00003#2 Add By Ken 151208
                                 
   CALL adep010_redo_astp517()   
                                 
   CALL adep010_redo_astp513()   
                                 
   CALL adep010_redo_artp230()   #151103-00003#2 Add By Ken 151208
                                 
   CALL adep010_redo_artp231()   #151103-00003#2 Add By Ken 151208
                                 
   CALL adep010_redo_aprp300()   #151103-00003#2 Add By Ken 151208   

   IF g_master.l_week = 'Y' THEN
      CALL adep010_redo_week()
   END IF
   IF g_master.l_month = 'Y' THEN
      CALL adep010_redo_month()
   END IF
   CALL cl_progress_no_window_ing('重新結算完成！')
   LET g_prog = 'adep010'
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
   CALL adep010_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep010.get_buffer" >}
PRIVATE FUNCTION adep010_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_deba002 = p_dialog.getFieldBuffer('l_deba002')
   LET g_master.l_week = p_dialog.getFieldBuffer('l_week')
   LET g_master.l_month = p_dialog.getFieldBuffer('l_month')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep010.msgcentre_notify" >}
PRIVATE FUNCTION adep010_msgcentre_notify()
 
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
 
{<section id="adep010.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: apcp500重新處理
# Memo...........:
# Usage..........: CALL adep010_redo_apcp500()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/05 By Lori   #160819-00054#22
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_apcp500()
   DEFINE ls_js         STRING
   DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
   DEFINE l_apcp500     RECORD
          pcam004          LIKE pcam_t.pcam004,
          wc              STRING
                        END RECORD
                 
   CALL adep010_get_gzzal003('apcp500') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)            
   DISPLAY "START:apcp500"   
   LET g_prog = 'apcp500'
   LET l_apcp500.pcam004      = g_master.l_deba002
   LET l_apcp500.wc           = cl_replace_str(g_master.wc,'debasite','pcamsite')
   LET ls_js = util.JSON.stringify(l_apcp500)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:apcp500" 
END FUNCTION

################################################################################
# Descriptions...: adep990重新計算
# Memo...........:
# Usage..........: CALL adep010_redo_adep990()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_adep990()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_adep990       RECORD
       l_type          LIKE type_t.chr10,
       rtjadocdt       LIKE rtja_t.rtjadocdt,
       l_del           LIKE type_t.chr1,
       wc            STRING
                 END RECORD
                 
   CALL adep010_get_gzzal003('adep990') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)            
   DISPLAY "START:adep990"   
   LET g_prog = 'adep990'
   LET l_adep990.l_type       = '1'
   LET l_adep990.rtjadocdt    = g_master.l_deba002
   LET l_adep990.l_del        = 'X'
   LET l_adep990.wc           = cl_replace_str(g_master.wc,'debasite','rtjasite')
   LET ls_js = util.JSON.stringify(l_adep990)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep990"  
END FUNCTION

################################################################################
# Descriptions...: adep103重新計算
# Memo...........: ls_js = "{\"l_type\":\"10\",\"rtjadocdt\":\"2015-11-05\",\"l_del\":\"Y\",\"wc\":\"rtjasite='5566'\"}"
# Usage..........: CALL adep010_redo_adep103()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_adep103()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_adep103       RECORD
       l_type          LIKE type_t.chr10,
       rtjadocdt       LIKE rtja_t.rtjadocdt,
       l_del           LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('adep103') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408                 
   CALL cl_progress_no_window_ing(l_gzzal003)  
   DISPLAY "START:adep103"   
   LET g_prog = 'adep103'
   LET l_adep103.l_type       = '10'
   LET l_adep103.rtjadocdt    = g_master.l_deba002
   LET l_adep103.l_del        = 'Y'
   LET l_adep103.wc           = cl_replace_str(g_master.wc,'debasite','rtjasite')
   LET ls_js = util.JSON.stringify(l_adep103)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep103" 
END FUNCTION

################################################################################
# Descriptions...: astp503重新計算
# Memo...........: ls_js = "{\"dat\":\"2015-11-04\",\"wc\":\"stgasite='5566'\"}"
# Usage..........: CALL adep010_redo_astp503()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp503()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp503       RECORD
       dat             LIKE type_t.dat,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp503') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp503"   
   LET g_prog = 'astp503'
   LET l_astp503.dat          = g_master.l_deba002
   LET l_astp503.wc           = cl_replace_str(g_master.wc,'debasite','stgasite')
   LET ls_js = util.JSON.stringify(l_astp503)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp503"
END FUNCTION

################################################################################
# Descriptions...: astp508重新計算
# Memo...........:
# Usage..........: CALL adep010_redo_astp508()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6  By Ken
# Modify.........: 2016/10/12 By Lori  調整astp508傳入參數
################################################################################
PRIVATE FUNCTION adep010_redo_astp508()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp508     RECORD
       type          LIKE type_t.chr10,
      #debc002       LIKE debc_t.debc002,   #160819-00054#22 161012 by lori mark
       debc002_1     LIKE debc_t.debc002,   #160819-00054#22 161012 by lori add
       debc002_2     LIKE debc_t.debc002,   #160819-00054#22 161012 by lori add 
       recalculated  LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp508') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                     
   DISPLAY "START:astp508"   
   LET g_prog = 'astp508'
   LET l_astp508.type         = '1'
  #LET l_astp508.debc002      = g_master.l_deba002   #160819-00054#22 161012 by lori mark
   LET l_astp508.debc002_1    = g_master.l_deba002   #160819-00054#22 161012 by lori add
   LET l_astp508.debc002_2    = g_master.l_deba002   #160819-00054#22 161012 by lori add 
   LET l_astp508.recalculated = 'Y'
   LET l_astp508.wc           = cl_replace_str(g_master.wc,'debasite','stfasite')
   LET ls_js = util.JSON.stringify(l_astp508)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp508"  
      
END FUNCTION

################################################################################
# Descriptions...: astp509重新計算
# Memo...........:
# Usage..........: CALL adep010_redo_astp509()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........: 2016/10/12 By Lori  調整astp509傳入參數
################################################################################
PRIVATE FUNCTION adep010_redo_astp509()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp509       RECORD
       type          LIKE type_t.chr10,
      #debc002       LIKE debc_t.debc002,   #160819-00054#22 161012 by lori mark
       debc002_1     LIKE debc_t.debc002,   #160819-00054#22 161012 by lori add
       debc002_2     LIKE debc_t.debc002,   #160819-00054#22 161012 by lori add 
       recalculated  LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp509') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp509"   
   LET g_prog = 'astp509'
   LET l_astp509.type         = '2'
  #LET l_astp509.debc002      = g_master.l_deba002   #160819-00054#22 161012 by lori mark
   LET l_astp509.debc002_1    = g_master.l_deba002   #160819-00054#22 161012 by lori add
   LET l_astp509.debc002_2    = g_master.l_deba002   #160819-00054#22 161012 by lori add    
   LET l_astp509.recalculated = 'Y'
   LET l_astp509.wc           = cl_replace_str(g_master.wc,'debasite','stfasite')
   LET ls_js = util.JSON.stringify(l_astp509)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp509" 
END FUNCTION

################################################################################
# Descriptions...: astp507重新計算
# Memo...........: ls_js = "{\"pregsite\":\"5566\",\"l_date\":\"2015-11-06\",\"l_del\":\"Y\",\"wc\":\" 1=1\"}"
# Usage..........: CALL adep010_redo_astp507()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp507()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp507       RECORD
       pregsite      LIKE preg_t.pregsite,
       l_date        LIKE type_t.dat,
       l_del         LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp507') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp507"   
   LET g_prog = 'astp507'
   LET l_astp507.pregsite     = cl_replace_str(g_master.wc,'debasite=',' ')
   LET l_astp507.l_date       = g_master.l_deba002
   LET l_astp507.l_del        = 'Y'
   LET l_astp507.wc           = '1 = 1'
   LET ls_js = util.JSON.stringify(l_astp507)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp507" 
END FUNCTION

################################################################################
# Descriptions...: astp510重新計算
# Memo...........: {"dat":":YESTERDAY","wc":" 1=1"}
# Usage..........: CALL adep010_redo_astp510()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp510()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp510       RECORD
       dat           LIKE type_t.dat,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp510') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp510"   
   LET g_prog = 'astp510'
   LET l_astp510.dat          = g_master.l_deba002
   LET l_astp510.wc           = cl_replace_str(g_master.wc,'debasite','stgdsite')
   LET ls_js = util.JSON.stringify(l_astp510)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp510"
END FUNCTION

################################################################################
# Descriptions...: astp511重新計算
# Memo...........: ls_js = "{\"stgf001\":\"2015-11-05\",\"wc\":\"stgfsite='5566'\"}"
# Usage..........: CALL adep010_redo_astp511()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp511()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp511       RECORD
       stgf001       LIKE stgf_t.stgf001,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp511') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp511"   
   LET g_prog = 'astp511'
   LET l_astp511.stgf001      = g_master.l_deba002
   LET l_astp511.wc           = cl_replace_str(g_master.wc,'debasite','stgfsite')
   LET ls_js = util.JSON.stringify(l_astp511)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp511" 
END FUNCTION

################################################################################
# Descriptions...: astp512重新計算
# Memo...........: ls_js = "{\"stgg001\":\"2015-11-05\",\"wc\":\"stggsite='5566'\"}"
# Usage..........: CALL adep010_redo_astp512()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp512()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp512       RECORD
       stgg001       LIKE stgg_t.stgg001,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp512') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp512"   
   LET g_prog = 'astp512'
   LET l_astp512.stgg001      = g_master.l_deba002
   LET l_astp512.wc           = cl_replace_str(g_master.wc,'debasite','stggsite')
   LET ls_js = util.JSON.stringify(l_astp512)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp512" 
END FUNCTION

################################################################################
# Descriptions...: astp513重新計算
# Memo...........: ls_js = "{\"stga001\":\"2015-11-06\",\"wc\":\"stgesite='5566'\"}"
# Usage..........: CALL adep010_redo_astp513()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp513()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp513       RECORD
       stga001       LIKE stga_t.stga001,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp513') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp513"   
   LET g_prog = 'astp513'
   LET l_astp513.stga001      = g_master.l_deba002
   LET l_astp513.wc           = cl_replace_str(g_master.wc,'debasite','stgesite')
   LET ls_js = util.JSON.stringify(l_astp513)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp513" 
END FUNCTION

################################################################################
# Descriptions...: astp515重新計算
# Memo...........: ls_js = "{\"stfb021\":\"2015-11-06\",\"wc\":\"stfasite='5566'\"}"
# Usage..........: CALL adep010_redo_astp515()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp515()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp515       RECORD
       stfb021       LIKE stfb_t.stfb021,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp515') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp515"   
   LET g_prog = 'astp515'
   LET l_astp515.stfb021      = g_master.l_deba002
   LET l_astp515.wc           = cl_replace_str(g_master.wc,'debasite','stfasite')
   LET ls_js = util.JSON.stringify(l_astp515)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp515" 
END FUNCTION

################################################################################
# Descriptions...: astp517重新計算
# Memo...........: ls_js = "{\"l_date\":\"1899-12-31\",\"wc\":\"stfasite='5566'\"}"
# Usage..........: CALL adep010_redo_astp517()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp517()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp517       RECORD
       l_date        LIKE type_t.dat,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp517') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp517"   
   LET g_prog = 'astp517'
   LET l_astp517.l_date       = g_master.l_deba002
   LET l_astp517.wc           = cl_replace_str(g_master.wc,'debasite','stfasite')
   LET ls_js = util.JSON.stringify(l_astp517)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp517" 
END FUNCTION

################################################################################
# Descriptions...: 周結重新計算(adep150~adep157)
# Memo...........: ls_js = "{\"type\":\"0\",\"rtjadocdt\":\"2015-11-06\",\"l_del\":\"Y\",\"wc\":\"rtjasite='5566'\"}"
# Usage..........: CALL adep010_redo_week()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_week()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_adep150       RECORD
       type          LIKE type_t.chr1,
       rtjadocdt     LIKE rtja_t.rtjadocdt,
       l_del         LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('adep150') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                 
   #CALL cl_progress_no_window_ing('周結資料：adep150~adep157重新計算！')
   DISPLAY "START:adep150"   
   LET g_prog = 'adep150'
   LET l_adep150.type         = '0'
   LET l_adep150.rtjadocdt    = g_master.l_deba002
   LET l_adep150.l_del        = 'Y'
   LET l_adep150.wc           = cl_replace_str(g_master.wc,'debasite','rtjasite')
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep150" 
   

   CALL adep010_get_gzzal003('adep151') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)  
   DISPLAY "START:adep151"   
   LET g_prog = 'adep151'
   LET l_adep150.type         = '1'
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep151" 
   
   
   CALL adep010_get_gzzal003('adep154') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)     
   DISPLAY "START:adep154"   
   LET g_prog = 'adep154'
   LET l_adep150.type         = '4'
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep154" 
   

   CALL adep010_get_gzzal003('adep155') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)  
   DISPLAY "START:adep155"   
   LET g_prog = 'adep155'
   LET l_adep150.type         = '5'
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep155" 
   
   
   CALL adep010_get_gzzal003('adep156') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)     
   DISPLAY "START:adep156"   
   LET g_prog = 'adep156'
   LET l_adep150.type         = '6'
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep156"


   CALL adep010_get_gzzal003('adep157') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)  
   DISPLAY "START:adep157"   
   LET g_prog = 'adep157'
   LET l_adep150.type         = '7'
   LET ls_js = util.JSON.stringify(l_adep150)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep157" 
END FUNCTION

################################################################################
# Descriptions...: 月結重新計算(adep170~adep177)
# Memo...........: ls_js = "{\"type\":\"10\",\"rtjadocdt\":\"2015-11-06\",\"l_del\":\"Y\",\"wc\":\"rtjasite='5566'\"}"
# Usage..........: CALL adep010_redo_month()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/11/6 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_month()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_adep170       RECORD
       type          LIKE type_t.chr1,
       rtjadocdt     LIKE rtja_t.rtjadocdt,
       l_del         LIKE type_t.chr1,
       wc            STRING
                 END RECORD
   #CALL cl_progress_no_window_ing('月結資料：adep170~adep177重新計算！')
   CALL adep010_get_gzzal003('adep170') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)     
   DISPLAY "START:adep170"   
   LET g_prog = 'adep170'
   LET l_adep170.type         = '10'
   LET l_adep170.rtjadocdt    = g_master.l_deba002
   LET l_adep170.l_del        = 'Y'
   LET l_adep170.wc           = cl_replace_str(g_master.wc,'debasite','rtjasite')
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep170" 
   
   CALL adep010_get_gzzal003('adep171') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)    
   DISPLAY "START:adep171"   
   LET g_prog = 'adep171'
   LET l_adep170.type         = '11'
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep171" 
   
   
   CALL adep010_get_gzzal003('adep174') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)    
   DISPLAY "START:adep174"   
   LET g_prog = 'adep174'
   LET l_adep170.type         = '14'
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep174" 
   

   CALL adep010_get_gzzal003('adep175') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003) 
   DISPLAY "START:adep175"   
   LET g_prog = 'adep175'
   LET l_adep170.type         = '15'
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep175" 
   
   
   CALL adep010_get_gzzal003('adep176') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)    
   DISPLAY "START:adep176"   
   LET g_prog = 'adep176'
   LET l_adep170.type         = '16'
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep176"


   CALL adep010_get_gzzal003('adep177') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003) 
   DISPLAY "START:adep177"   
   LET g_prog = 'adep177'
   LET l_adep170.type         = '17'
   LET ls_js = util.JSON.stringify(l_adep170)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep177" 
END FUNCTION

################################################################################
# Descriptions...: astp514重新計算
# Memo...........: ls_js = "{\"stgd002\":\"2015-12-08\",\"wc\":\"rtjbsite='DSCNJ'\"}"
# Usage..........: CALL adep010_redo_astp514()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/8 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_astp514()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_astp514       RECORD
       stgd002       LIKE stgd_t.stgd002,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('astp514') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:astp514"   
   LET g_prog = 'astp514'
   LET l_astp514.stgd002      = g_master.l_deba002
   LET l_astp514.wc           = cl_replace_str(g_master.wc,'debasite','rtjbsite')
   LET ls_js = util.JSON.stringify(l_astp514)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:astp514" 
END FUNCTION

################################################################################
# Descriptions...: artp230重新計算
# Memo...........: ls_js = "{\"rtap021\":\"2015-12-08\",\"wc\":\"rtaosite='DSCNJ'\"}"
# Usage..........: CALL adep010_redo_artp230()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/8 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_artp230()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_artp230       RECORD
       rtap021       LIKE rtap_t.rtap021,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('artp230') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                  
   DISPLAY "START:artp230"   
   LET g_prog = 'artp230'
   LET l_artp230.rtap021      = g_master.l_deba002
   LET l_artp230.wc           = cl_replace_str(g_master.wc,'debasite','rtaosite')
   LET ls_js = util.JSON.stringify(l_artp230)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:artp230" 
END FUNCTION

################################################################################
# Descriptions...: artp231重新計算
# Memo...........: ls_js = "{\"rtap004\":\"2015-12-08\",\"wc\":\"rtaosite='1101'\"}"
# Usage..........: CALL adep010_redo_artp231()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/8 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_artp231()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_artp231       RECORD
       rtap004       LIKE rtap_t.rtap004,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('artp231') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                   
   DISPLAY "START:artp231"   
   LET g_prog = 'artp231'
   LET l_artp231.rtap004      = g_master.l_deba002
   LET l_artp231.wc           = cl_replace_str(g_master.wc,'debasite','rtaosite')
   LET ls_js = util.JSON.stringify(l_artp231)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:artp231" 
END FUNCTION

################################################################################
# Descriptions...: aprp300重新計算
# Memo...........: ls_js = "{\"prcf010\":\"2015-12-08\",\"wc\":\"pregsite='DSCNJ'\"}"
# Usage..........: CALL adep010_redo_aprp300()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/8 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_aprp300()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_aprp300       RECORD
       prcf010       LIKE prcf_t.prcf010,
       wc            STRING
                 END RECORD
   CALL adep010_get_gzzal003('aprp300') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                   
   DISPLAY "START:aprp300"   
   LET g_prog = 'aprp300'
   LET l_aprp300.prcf010      = g_master.l_deba002
   LET l_aprp300.wc           = cl_replace_str(g_master.wc,'debasite','pregsite')
   LET ls_js = util.JSON.stringify(l_aprp300)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:aprp300" 
END FUNCTION

################################################################################
# Descriptions...: adep200重新計算
# Memo...........: ls_js = "{\"rtjadocdt\":\"2015-12-08\",\"l_a\":\"Y\",\"wc\":\"rtjasite='DSCTC'\"}"
# Usage..........: CALL adep010_redo_adep200()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/12/8 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_redo_adep200()
DEFINE ls_js         STRING
DEFINE l_gzzal003    STRING     #160225-00040#22 Add By ken 160408
DEFINE l_adep200     RECORD
       rtjadocdt       LIKE rtja_t.rtjadocdt,
       l_a             LIKE type_t.chr1,
       wc              STRING
                 END RECORD
   CALL adep010_get_gzzal003('adep200') RETURNING l_gzzal003   #160225-00040#22 Add By ken 160408
   CALL cl_progress_no_window_ing(l_gzzal003)                                
   DISPLAY "START:adep200"   
   LET g_prog = 'adep200'
   LET l_adep200.rtjadocdt    = g_master.l_deba002
   LET l_adep200.l_a        = 'Y'
   LET l_adep200.wc           = cl_replace_str(g_master.wc,'debasite','rtjasite')
   LET ls_js = util.JSON.stringify(l_adep200)
   LET ls_js = adep010_transfer_argv(ls_js)
   DISPLAY "ls_js:",ls_js
   CALL cl_cmdrun_wait(ls_js)
   DISPLAY "END:adep200" 
END FUNCTION

################################################################################
# Descriptions...: 取得作業編號+作業名稱
# Memo...........:
# Usage..........: CALL adep010_get_gzzal003(p_prog)
#                  RETURNING r_gzzal003
# Input parameter: p_prog         作業編號
# Return code....: r_gzzal003     作業編號+作業名稱
# Date & Author..: 2016/04/06 By Ken   #160225-00040#22
# Modify.........:
################################################################################
PRIVATE FUNCTION adep010_get_gzzal003(p_prog)
DEFINE p_prog           LIKE type_t.chr10
DEFINE l_gzzal003       LIKE type_t.chr100
DEFINE r_gzzal003       LIKE type_t.chr100

  SELECT gzzal003 INTO l_gzzal003
    FROM gzzal_t
   WHERE gzzal001 = p_prog 
     AND gzzal002 = g_lang
     
  LET r_gzzal003 = p_prog,l_gzzal003
  
  RETURN r_gzzal003
END FUNCTION

#end add-point
 
{</section>}
 
