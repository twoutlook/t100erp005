#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-04-20 16:51:17), PR版次:0001(2016-04-20 17:02:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: acrr701
#+ Description: 潛在客戶名條列印
#+ Creator....: 01251(2014-09-09 15:52:22)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr701.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       craa001 LIKE craa_t.craa001, 
   craa032 LIKE craa_t.craa032, 
   craa015 LIKE craa_t.craa015, 
   craa016 LIKE craa_t.craa016, 
   craa017 LIKE craa_t.craa017, 
   craa018 LIKE craa_t.craa018, 
   craa019 LIKE craa_t.craa019, 
   craa020 LIKE craa_t.craa020, 
   column LIKE type_t.chr500, 
   column2 LIKE type_t.chr500, 
   column3 LIKE type_t.chr500,
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
 
{<section id="acrr701.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrr701_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr701 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr701_init()
 
      #進入選單 Menu (="N")
      CALL acrr701_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr701
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr701.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr701_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
   CALL cl_set_combo_scc('craa032','6052')
   CALL cl_set_combo_scc('column','6733')
   CALL cl_set_combo_scc('column2','6734')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr701.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr701_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      IF cl_null(g_master.column) THEN
         LET g_master.column='1'
      END IF
      IF cl_null(g_master.column2) THEN
         LET g_master.column2='1'
      END IF      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.column,g_master.column2,g_master.column3 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD column
            #add-point:BEFORE FIELD column name="input.b.column"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD column
            
            #add-point:AFTER FIELD column name="input.a.column"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE column
            #add-point:ON CHANGE column name="input.g.column"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD column2
            #add-point:BEFORE FIELD column2 name="input.b.column2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD column2
            
            #add-point:AFTER FIELD column2 name="input.a.column2"
            IF g_master.column2='4' THEN
               CALL cl_set_comp_required('column3',TRUE)
            ELSE
               CALL cl_set_comp_required('column3',FALSE)
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE column2
            #add-point:ON CHANGE column2 name="input.g.column2"
            IF g_master.column2='4' THEN
               CALL cl_set_comp_required('column3',TRUE)
            ELSE
               CALL cl_set_comp_required('column3',FALSE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD column3
            #add-point:BEFORE FIELD column3 name="input.b.column3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD column3
            
            #add-point:AFTER FIELD column3 name="input.a.column3"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE column3
            #add-point:ON CHANGE column3 name="input.g.column3"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.column
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD column
            #add-point:ON ACTION controlp INFIELD column name="input.c.column"
            
            #END add-point
 
 
         #Ctrlp:input.c.column2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD column2
            #add-point:ON ACTION controlp INFIELD column2 name="input.c.column2"
            
            #END add-point
 
 
         #Ctrlp:input.c.column3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD column3
            #add-point:ON ACTION controlp INFIELD column3 name="input.c.column3"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON craa001,craa032,craa015,craa016,craa017,craa018,craa019,craa020 
 
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.craa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa001
            #add-point:ON ACTION controlp INFIELD craa001 name="construct.c.craa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_craa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa001  #顯示到畫面上
            NEXT FIELD craa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa001
            #add-point:BEFORE FIELD craa001 name="construct.b.craa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa001
            
            #add-point:AFTER FIELD craa001 name="construct.a.craa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa032
            #add-point:BEFORE FIELD craa032 name="construct.b.craa032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa032
            
            #add-point:AFTER FIELD craa032 name="construct.a.craa032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa032
            #add-point:ON ACTION controlp INFIELD craa032 name="construct.c.craa032"
            
            #END add-point
 
 
         #Ctrlp:construct.c.craa015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa015
            #add-point:ON ACTION controlp INFIELD craa015 name="construct.c.craa015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa015  #顯示到畫面上
            NEXT FIELD craa015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa015
            #add-point:BEFORE FIELD craa015 name="construct.b.craa015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa015
            
            #add-point:AFTER FIELD craa015 name="construct.a.craa015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa016
            #add-point:ON ACTION controlp INFIELD craa016 name="construct.c.craa016"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='294'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa016  #顯示到畫面上
            NEXT FIELD craa016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa016
            #add-point:BEFORE FIELD craa016 name="construct.b.craa016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa016
            
            #add-point:AFTER FIELD craa016 name="construct.a.craa016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa017
            #add-point:ON ACTION controlp INFIELD craa017 name="construct.c.craa017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='1'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa017  #顯示到畫面上
            NEXT FIELD craa017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa017
            #add-point:BEFORE FIELD craa017 name="construct.b.craa017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa017
            
            #add-point:AFTER FIELD craa017 name="construct.a.craa017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa018
            #add-point:ON ACTION controlp INFIELD craa018 name="construct.c.craa018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='2'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa018  #顯示到畫面上
            NEXT FIELD craa018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa018
            #add-point:BEFORE FIELD craa018 name="construct.b.craa018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa018
            
            #add-point:AFTER FIELD craa018 name="construct.a.craa018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa019
            #add-point:ON ACTION controlp INFIELD craa019 name="construct.c.craa019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='3'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa019  #顯示到畫面上
            NEXT FIELD craa019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa019
            #add-point:BEFORE FIELD craa019 name="construct.b.craa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa019
            
            #add-point:AFTER FIELD craa019 name="construct.a.craa019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.craa020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD craa020
            #add-point:ON ACTION controlp INFIELD craa020 name="construct.c.craa020"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1='4'
            CALL q_dbaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO craa020  #顯示到畫面上
            NEXT FIELD craa020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD craa020
            #add-point:BEFORE FIELD craa020 name="construct.b.craa020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD craa020
            
            #add-point:AFTER FIELD craa020 name="construct.a.craa020"
            
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL acrr701_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr701_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
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
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL acrr701_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      IF INT_FLAG = FALSE AND (cl_null(g_master.wc) OR g_master.wc = " 1=1") THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "apm-00379"
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE WHILE
      END IF
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL acrr701_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr701_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="acrr701.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr701_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   LET la_cmdrun.param[1] = g_master.wc
   LET la_cmdrun.param[2] = g_master.column
   LET la_cmdrun.param[3] = g_master.column2
   LET la_cmdrun.param[3] = g_master.column3
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="acrr701.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr701_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"craa001,craa032,craa015,craa016,craa017,craa018,craa019,craa020")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr701_process_cs CURSOR FROM ls_sql
#  FOREACH acrr701_process_cs INTO
   #add-point:process段process name="process.process"
   CALL acrr701_g01(g_master.wc,g_master.column,g_master.column2,g_master.column3)
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="acrr701.get_buffer" >}
PRIVATE FUNCTION acrr701_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.column = p_dialog.getFieldBuffer('column')
   LET g_master.column2 = p_dialog.getFieldBuffer('column2')
   LET g_master.column3 = p_dialog.getFieldBuffer('column3')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr701.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
