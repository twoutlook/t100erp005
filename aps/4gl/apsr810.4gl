#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-02-26 17:25:40), PR版次:0003(2016-10-18 11:12:34)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: apsr810
#+ Description: 集團MRP請購建議表
#+ Creator....: 05384(2015-02-25 11:07:12)
#+ Modifier...: 05384 -SD/PR- 05384
 
{</section>}
 
{<section id="apsr810.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#51 2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#161013-00051#1  2016/10/18 By shiun   整批調整據點組織開窗
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
       psgbsite LIKE psgb_t.psgbsite, 
   psgb002 LIKE psgb_t.psgb002, 
   imae012 LIKE imae_t.imae012, 
   imaf142 LIKE imaf_t.imaf142, 
   psgb004 LIKE psgb_t.psgb004, 
   imaa009 LIKE imaa_t.imaa009, 
   imaf141 LIKE imaf_t.imaf141, 
   psfa001 LIKE type_t.chr10, 
   psfa001_desc LIKE type_t.chr80, 
   datestart LIKE type_t.chr500, 
   dateend LIKE type_t.chr500, 
   psgb027 LIKE type_t.chr500,
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
 
{<section id="apsr810.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apsr810_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsr810 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsr810_init()
 
      #進入選單 Menu (="N")
      CALL apsr810_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsr810
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsr810.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsr810_init()
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
   CALL cl_set_combo_scc_part('psgb027','4028','0,1,2')
   LET g_master.psgb027 = 0
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsr810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr810_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success  LIKE type_t.num5
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.psfa001,g_master.datestart,g_master.dateend,g_master.psgb027 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psfa001
            
            #add-point:AFTER FIELD psfa001 name="input.a.psfa001"
            IF NOT cl_null(g_master.psfa001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.psfa001
               LET g_errshow = TRUE   #160318-00025#51
               LET g_chkparam.err_str[1] = "aps-00092:sub-01302|apsi800|",cl_get_progname("apsi800",g_lang,"2"),"|:EXEPROGapsi800"    #160318-00025#51
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_psfa001") THEN
                  #檢查成功時後續處理
                  CALL apsr810_desc(g_master.psfa001) RETURNING g_master.psfa001_desc
                  DISPLAY BY NAME g_master.psfa001_desc
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.psfa001_desc =''
                  DISPLAY BY NAME g_master.psfa001_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psfa001
            #add-point:BEFORE FIELD psfa001 name="input.b.psfa001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psfa001
            #add-point:ON CHANGE psfa001 name="input.g.psfa001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD datestart
            #add-point:BEFORE FIELD datestart name="input.b.datestart"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD datestart
            
            #add-point:AFTER FIELD datestart name="input.a.datestart"
            CALL apsr810_date_check() RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = "sub-00095"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD datestart
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE datestart
            #add-point:ON CHANGE datestart name="input.g.datestart"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dateend
            #add-point:BEFORE FIELD dateend name="input.b.dateend"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dateend
            
            #add-point:AFTER FIELD dateend name="input.a.dateend"
            CALL apsr810_date_check() RETURNING l_success
            IF NOT l_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ''
               LET g_errparam.code   = "sub-00095"
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD dateend
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dateend
            #add-point:ON CHANGE dateend name="input.g.dateend"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psgb027
            #add-point:BEFORE FIELD psgb027 name="input.b.psgb027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psgb027
            
            #add-point:AFTER FIELD psgb027 name="input.a.psgb027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psgb027
            #add-point:ON CHANGE psgb027 name="input.g.psgb027"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.psfa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psfa001
            #add-point:ON ACTION controlp INFIELD psfa001 name="input.c.psfa001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            CALL q_psfa001()
            LET g_master.psfa001 = g_qryparam.return1
            CALL apsr810_desc(g_master.psfa001) RETURNING g_master.psfa001_desc
            DISPLAY BY NAME g_master.psfa001_desc
            DISPLAY g_master.psfa001  TO psfa001
            NEXT FIELD psfa001
            #END add-point
 
 
         #Ctrlp:input.c.datestart
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD datestart
            #add-point:ON ACTION controlp INFIELD datestart name="input.c.datestart"
            
            #END add-point
 
 
         #Ctrlp:input.c.dateend
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dateend
            #add-point:ON ACTION controlp INFIELD dateend name="input.c.dateend"
            
            #END add-point
 
 
         #Ctrlp:input.c.psgb027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psgb027
            #add-point:ON ACTION controlp INFIELD psgb027 name="input.c.psgb027"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON psgbsite,psgb002,imae012,imaf142,psgb004,imaa009,imaf141
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.psgbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psgbsite
            #add-point:ON ACTION controlp INFIELD psgbsite name="construct.c.psgbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001_12()                           #呼叫開窗
            CALL q_ooef001_1()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO psgbsite  #顯示到畫面上
            NEXT FIELD psgbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psgbsite
            #add-point:BEFORE FIELD psgbsite name="construct.b.psgbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psgbsite
            
            #add-point:AFTER FIELD psgbsite name="construct.a.psgbsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psgb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psgb002
            #add-point:ON ACTION controlp INFIELD psgb002 name="construct.c.psgb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psgb002  #顯示到畫面上
            NEXT FIELD psgb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psgb002
            #add-point:BEFORE FIELD psgb002 name="construct.b.psgb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psgb002
            
            #add-point:AFTER FIELD psgb002 name="construct.a.psgb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="construct.c.imae012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imae012  #顯示到畫面上
            NEXT FIELD imae012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imae012
            #add-point:BEFORE FIELD imae012 name="construct.b.imae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imae012
            
            #add-point:AFTER FIELD imae012 name="construct.a.imae012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf142
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf142
            #add-point:ON ACTION controlp INFIELD imaf142 name="construct.c.imaf142"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf142  #顯示到畫面上
            NEXT FIELD imaf142                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf142
            #add-point:BEFORE FIELD imaf142 name="construct.b.imaf142"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf142
            
            #add-point:AFTER FIELD imaf142 name="construct.a.imaf142"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psgb004
            #add-point:BEFORE FIELD psgb004 name="construct.b.psgb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psgb004
            
            #add-point:AFTER FIELD psgb004 name="construct.a.psgb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psgb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psgb004
            #add-point:ON ACTION controlp INFIELD psgb004 name="construct.c.psgb004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf141
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf141
            #add-point:ON ACTION controlp INFIELD imaf141 name="construct.c.imaf141"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaf141  #顯示到畫面上
            NEXT FIELD imaf141                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf141
            #add-point:BEFORE FIELD imaf141 name="construct.b.imaf141"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf141
            
            #add-point:AFTER FIELD imaf141 name="construct.a.imaf141"
            
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
            CALL apsr810_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL apsr810_get_buffer(l_dialog)
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
         CALL apsr810_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
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
                 CALL apsr810_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsr810_transfer_argv(ls_js)
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
 
{<section id="apsr810.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsr810_transfer_argv(ls_js)
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
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apsr810.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsr810_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"psgbsite,psgb002,imae012,imaf142,psgb004,imaa009,imaf141")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1 "
   END IF
   LET g_master.wc = g_master.wc CLIPPED ,"  AND psgbent = ",g_enterprise
   IF NOT cl_null(g_master.psfa001) THEN
      LET g_master.wc = g_master.wc CLIPPED ," AND psgb001 = '",g_master.psfa001,"'   "
   END IF
   CASE g_master.psgb027
      WHEN '0'
         LET g_master.wc = g_master.wc CLIPPED," AND psgb027 = 'N' "
      WHEN '1'
         LET g_master.wc = g_master.wc CLIPPED," AND psgb027 = 'Y' "
      WHEN '2'
   END CASE
   CALL apsr810_x01(g_master.wc,g_master.datestart,g_master.dateend)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsr810_process_cs CURSOR FROM ls_sql
#  FOREACH apsr810_process_cs INTO
   #add-point:process段process name="process.process"
   
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
 
{<section id="apsr810.get_buffer" >}
PRIVATE FUNCTION apsr810_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.psfa001 = p_dialog.getFieldBuffer('psfa001')
   LET g_master.datestart = p_dialog.getFieldBuffer('datestart')
   LET g_master.dateend = p_dialog.getFieldBuffer('dateend')
   LET g_master.psgb027 = p_dialog.getFieldBuffer('psgb027')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsr810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apsr810_desc(p_mrp)
   DEFINE p_mrp  LIKE psfa_t.psfa001
   DEFINE r_desc LIKE type_t.chr80
   
   SELECT psfal003 INTO r_desc
     FROM psfal_t
    WHERE psfalent = g_enterprise
      AND psfal001 = p_mrp
      AND psfal002 = g_dlang
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 行動日起迄判斷
# Memo...........:
# Usage..........: CALL apsr810_date_check()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   成功否
# Date & Author..: 2015/02/26 By Shiun
# Modify.........:
################################################################################
PRIVATE FUNCTION apsr810_date_check()
   DEFINE r_success   LIKE type_t.num5
   LET r_success = TRUE
   IF NOT cl_null(g_master.datestart) AND NOT cl_null(g_master.dateend) THEN
      IF g_master.datestart > g_master.dateend THEN
         LET r_success = FALSE
      END IF
   END IF
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
