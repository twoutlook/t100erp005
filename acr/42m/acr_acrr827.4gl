#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr827.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-19 16:44:28), PR版次:0001(2016-08-17 11:00:08)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000015
#+ Filename...: acrr827
#+ Description: 門店消費統計對比分析報表
#+ Creator....: 07959(2016-05-09 15:48:45)
#+ Modifier...: 07959 -SD/PR- 08172
 
{</section>}
 
{<section id="acrr827.global" >}
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
       buttonedit_1 LIKE type_t.chr10, 
   buttonedit_2 LIKE type_t.chr500, 
   combobox_1 LIKE type_t.chr500, 
   checkbox_1 LIKE type_t.chr500, 
   compare LIKE type_t.chr500, 
   year_1 LIKE type_t.chr500, 
   sdate_1 LIKE type_t.chr500, 
   edate_1 LIKE type_t.chr500, 
   year_2 LIKE type_t.chr500, 
   sdate_2 LIKE type_t.chr500, 
   edate_2 LIKE type_t.chr500, 
   year_3 LIKE type_t.chr500, 
   sdate_3 LIKE type_t.chr500, 
   edate_3 LIKE type_t.chr500, 
   year_4 LIKE type_t.chr500, 
   sdate_4 LIKE type_t.chr500, 
   edate_4 LIKE type_t.chr500, 
   year_5 LIKE type_t.chr500, 
   sdate_5 LIKE type_t.chr500, 
   edate_5 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#用于接收s_get_oogcdate的返回值
   DEFINE g_flag               LIKE type_t.chr1  
   DEFINE g_errno              LIKE type_t.chr100
   DEFINE g_oogc015            LIKE oogc_t.oogc015
   DEFINE g_oogc007            LIKE oogc_t.oogc007
   DEFINE g_sdate_s            LIKE oogc_t.oogc003
   DEFINE g_sdate_e            LIKE oogc_t.oogc003
   DEFINE g_oogc006            LIKE oogc_t.oogc006
   DEFINE g_pdate_s            LIKE oogc_t.oogc003
   DEFINE g_pdate_e            LIKE oogc_t.oogc003
   DEFINE g_oogc008            LIKE oogc_t.oogc008
   DEFINE g_wdate_s            LIKE oogc_t.oogc003
   DEFINE g_wdate_e            LIKE oogc_t.oogc003
   DEFINE g_oogc001            LIKE oogc_t.oogc001
   DEFINE g_oogc002            LIKE oogc_t.oogc002
   
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrr827.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5
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
      CALL acrr827_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr827 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr827_init()
 
      #進入選單 Menu (="N")
      CALL acrr827_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr827
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr827.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr827_init()
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5
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
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL cl_set_combo_scc("combobox_1","6895")      #分析类型SCC
   LET g_master.combobox_1 = 1
   LET g_master.checkbox_1 = 'Y'                #默认为会员
   LET g_master.compare = '1'      #期别数  
   CALL acrr827_set_entry()
   CALL acrr827_set_no_entry()
   SELECT ooef008,ooef010  INTO g_oogc001,g_oogc002
     FROM ooef_t
    WHERE ooefent=g_enterprise
      AND ooef001=g_site
   CALL s_get_oogcdate(g_oogc001,g_oogc002,g_today,"","") RETURNING g_flag,g_errno,g_oogc015,g_oogc007,g_sdate_s,g_sdate_e,g_oogc006,g_pdate_s,g_pdate_e,g_oogc008,g_wdate_s,g_wdate_e
   LET g_master.year_1 = g_oogc015
   LET g_master.sdate_1 = g_oogc006
   LET g_master.edate_1 = g_oogc006
   LET g_master.year_2  = ""
   LET g_master.sdate_2 = ""
   LET g_master.edate_2 = ""
   LET g_master.year_3  = ""
   LET g_master.sdate_3 = ""
   LET g_master.edate_3 = ""
   LET g_master.year_4  = ""
   LET g_master.sdate_4 = ""
   LET g_master.edate_4 = ""
   LET g_master.year_5  = ""
   LET g_master.sdate_5 = ""
   LET g_master.edate_5 = ""
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr827.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr827_ui_dialog()
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
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.combobox_1,g_master.checkbox_1,g_master.compare,g_master.year_1,g_master.sdate_1, 
             g_master.edate_1,g_master.year_2,g_master.sdate_2,g_master.edate_2,g_master.year_3,g_master.sdate_3, 
             g_master.edate_3,g_master.year_4,g_master.sdate_4,g_master.edate_4,g_master.year_5,g_master.sdate_5, 
             g_master.edate_5 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD combobox_1
            #add-point:BEFORE FIELD combobox_1 name="input.b.combobox_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD combobox_1
            
            #add-point:AFTER FIELD combobox_1 name="input.a.combobox_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE combobox_1
            #add-point:ON CHANGE combobox_1 name="input.g.combobox_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD checkbox_1
            #add-point:BEFORE FIELD checkbox_1 name="input.b.checkbox_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD checkbox_1
            
            #add-point:AFTER FIELD checkbox_1 name="input.a.checkbox_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE checkbox_1
            #add-point:ON CHANGE checkbox_1 name="input.g.checkbox_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD compare
            #add-point:BEFORE FIELD compare name="input.b.compare"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD compare
            
            #add-point:AFTER FIELD compare name="input.a.compare"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE compare
            #add-point:ON CHANGE compare name="input.g.compare"
            CALL acrr827_set_entry()
            CALL acrr827_set_no_entry()
            SELECT ooef008,ooef010  INTO g_oogc001,g_oogc002
              FROM ooef_t
             WHERE ooefent=g_enterprise
               AND ooef001=g_site
            CALL s_get_oogcdate(g_oogc001,g_oogc002,g_today,"","") RETURNING g_flag,g_errno,g_oogc015,g_oogc007,g_sdate_s,g_sdate_e,g_oogc006,g_pdate_s,g_pdate_e,g_oogc008,g_wdate_s,g_wdate_e
            CASE g_master.compare
               WHEN 1
                  LET g_master.year_1  = g_oogc015
                  LET g_master.sdate_1 = g_oogc006
                  LET g_master.edate_1 = g_oogc006
                  
                  LET g_master.year_2  = ""
                  LET g_master.sdate_2 = ""
                  LET g_master.edate_2 = ""
                  LET g_master.year_3  = ""
                  LET g_master.sdate_3 = ""
                  LET g_master.edate_3 = ""
                  LET g_master.year_4  = ""
                  LET g_master.sdate_4 = ""
                  LET g_master.edate_4 = ""
                  LET g_master.year_5  = ""
                  LET g_master.sdate_5 = ""
                  LET g_master.edate_5 = ""
               WHEN 2
                  LET g_master.year_2 = g_oogc015
                  LET g_master.sdate_2 = g_oogc006
                  LET g_master.edate_2 = g_oogc006
                  IF g_oogc006 = 1 THEN
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 12
                        LET g_master.edate_1 = 12
                  ELSE
                        LET g_master.year_1  = g_oogc015
                        LET g_master.sdate_1 = g_oogc006-1
                        LET g_master.edate_1 = g_oogc006-1
                  END IF
                  LET g_master.year_3  = ""
                  LET g_master.sdate_3 = ""
                  LET g_master.edate_3 = ""
                  LET g_master.year_4  = ""
                  LET g_master.sdate_4 = ""
                  LET g_master.edate_4 = ""
                  LET g_master.year_5  = ""
                  LET g_master.sdate_5 = ""
                  LET g_master.edate_5 = ""
               WHEN 3
                  LET g_master.year_3  = g_oogc015
                  LET g_master.sdate_3 = g_oogc006
                  LET g_master.edate_3 = g_oogc006
                  CASE g_oogc006 
                     WHEN 1
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 12
                        LET g_master.edate_2 = 12
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 11
                        LET g_master.edate_1 = 11
                     WHEN 2
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = 1
                        LET g_master.edate_2 = 1
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 12
                        LET g_master.edate_1 = 12
                     OTHERWISE
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = g_oogc006-1
                        LET g_master.edate_2 = g_oogc006-1
                        LET g_master.year_1  = g_oogc015
                        LET g_master.sdate_1 = g_oogc006-2
                        LET g_master.edate_1 = g_oogc006-2
                  END CASE
                  LET g_master.year_4  = ""
                  LET g_master.sdate_4 = ""
                  LET g_master.edate_4 = ""
                  LET g_master.year_5  = ""
                  LET g_master.sdate_5 = ""
                  LET g_master.edate_5 = ""
               WHEN 4
                  LET g_master.year_4  = g_oogc015
                  LET g_master.sdate_4 = g_oogc006
                  LET g_master.edate_4 = g_oogc006
                  CASE g_oogc006 
                  WHEN 1
                        LET g_master.year_3  = g_oogc015-1
                        LET g_master.sdate_3 = 12
                        LET g_master.edate_3 = 12
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 11
                        LET g_master.edate_2 = 11
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 10
                        LET g_master.edate_1 = 10
                  WHEN 2 
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = 1
                        LET g_master.edate_3 = 1
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 12
                        LET g_master.edate_2 = 12
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 11
                        LET g_master.edate_1 = 11
                  WHEN 3 
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = 2
                        LET g_master.edate_3 = 2
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = 1
                        LET g_master.edate_2 = 1
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 12
                        LET g_master.edate_1 = 12
                  OTHERWISE
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = g_oogc006-1
                        LET g_master.edate_3 = g_oogc006-1
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = g_oogc006-2
                        LET g_master.edate_2 = g_oogc006-2
                        LET g_master.year_1  = g_oogc015
                        LET g_master.sdate_1 = g_oogc006-3
                        LET g_master.edate_1 = g_oogc006-3
                  END CASE
                  LET g_master.year_5  = ""
                  LET g_master.sdate_5 = ""
                  LET g_master.edate_5 = ""
               WHEN 5
                  LET g_master.year_5  = g_oogc015
                  LET g_master.sdate_5 = g_oogc006
                  LET g_master.edate_5 = g_oogc006
                  CASE g_oogc006 
                  WHEN 1
                        LET g_master.year_4  = g_oogc015-1
                        LET g_master.sdate_4 = 12
                        LET g_master.edate_4 = 12
                        LET g_master.year_3  = g_oogc015-1
                        LET g_master.sdate_3 = 11
                        LET g_master.edate_3 = 11
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 10
                        LET g_master.edate_2 = 10
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 9
                        LET g_master.edate_1 = 9
                  
                  WHEN 2 
                        LET g_master.year_4  = g_oogc015
                        LET g_master.sdate_4 = 1
                        LET g_master.edate_4 = 1
                        LET g_master.year_3  = g_oogc015-1
                        LET g_master.sdate_3 = 12
                        LET g_master.edate_3 = 12
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 11
                        LET g_master.edate_2 = 11
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 10
                        LET g_master.edate_1 = 10
                  WHEN 3 
                        LET g_master.year_4  = g_oogc015
                        LET g_master.sdate_4 = 2
                        LET g_master.edate_4 = 2
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = 1
                        LET g_master.edate_3 = 1
                        LET g_master.year_2  = g_oogc015-1
                        LET g_master.sdate_2 = 12
                        LET g_master.edate_2 = 12
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 11
                        LET g_master.edate_1 = 11
                  WHEN 4
                        LET g_master.year_4  = g_oogc015
                        LET g_master.sdate_4 = 3
                        LET g_master.edate_4 = 3
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = 2
                        LET g_master.edate_3 = 2
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = 1
                        LET g_master.edate_2 = 1
                        LET g_master.year_1  = g_oogc015-1
                        LET g_master.sdate_1 = 12
                        LET g_master.edate_1 = 12
                  OTHERWISE
                        LET g_master.year_4  = g_oogc015
                        LET g_master.sdate_4 = g_oogc006-1
                        LET g_master.edate_4 = g_oogc006-1
                        LET g_master.year_3  = g_oogc015
                        LET g_master.sdate_3 = g_oogc006-2
                        LET g_master.edate_3 = g_oogc006-2
                        LET g_master.year_2  = g_oogc015
                        LET g_master.sdate_2 = g_oogc006-3
                        LET g_master.edate_2 = g_oogc006-3
                        LET g_master.year_1  = g_oogc015
                        LET g_master.sdate_1 = g_oogc006-4
                        LET g_master.edate_1 = g_oogc006-4
                  END CASE
            END CASE
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year_1
            #add-point:BEFORE FIELD year_1 name="input.b.year_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year_1
            
            #add-point:AFTER FIELD year_1 name="input.a.year_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year_1
            #add-point:ON CHANGE year_1 name="input.g.year_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdate_1
            #add-point:BEFORE FIELD sdate_1 name="input.b.sdate_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdate_1
            
            #add-point:AFTER FIELD sdate_1 name="input.a.sdate_1"
            
            IF NOT cl_null(g_master.sdate_1) THEN 
            END IF 
            
            IF NOT cl_null(g_master.edate_1) THEN 
               IF g_master.edate_1<g_master.sdate_1 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ""
                LET g_errparam.code   = 'agl-00227'
                LET g_errparam.popup  = FALSE
                CALL cl_err()       
                NEXT FIELD sdate_1
               END IF
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdate_1
            #add-point:ON CHANGE sdate_1 name="input.g.sdate_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate_1
            #add-point:BEFORE FIELD edate_1 name="input.b.edate_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate_1
            
            #add-point:AFTER FIELD edate_1 name="input.a.edate_1"
            IF NOT cl_null(g_master.edate_1) THEN 
            END IF 
            
            IF NOT cl_null(g_master.sdate_1) THEN 
               IF g_master.edate_1<g_master.sdate_1 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ""
                LET g_errparam.code   = 'agl-00228'
                LET g_errparam.popup  = FALSE
                CALL cl_err()       
                NEXT FIELD edate_1
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate_1
            #add-point:ON CHANGE edate_1 name="input.g.edate_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year_2
            #add-point:BEFORE FIELD year_2 name="input.b.year_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year_2
            
            #add-point:AFTER FIELD year_2 name="input.a.year_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year_2
            #add-point:ON CHANGE year_2 name="input.g.year_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdate_2
            #add-point:BEFORE FIELD sdate_2 name="input.b.sdate_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdate_2
            
            #add-point:AFTER FIELD sdate_2 name="input.a.sdate_2"
            IF NOT cl_null(g_master.sdate_2) THEN 
            END IF 
            
            IF NOT cl_null(g_master.edate_2) THEN 
               IF g_master.edate_2<g_master.sdate_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00227'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD sdate_2
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdate_2
            #add-point:ON CHANGE sdate_2 name="input.g.sdate_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate_2
            #add-point:BEFORE FIELD edate_2 name="input.b.edate_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate_2
            
            #add-point:AFTER FIELD edate_2 name="input.a.edate_2"
            IF NOT cl_null(g_master.edate_2) THEN 
            END IF 
            
            IF NOT cl_null(g_master.sdate_2) THEN 
               IF g_master.edate_2<g_master.sdate_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00228'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD edate_2
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate_2
            #add-point:ON CHANGE edate_2 name="input.g.edate_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year_3
            #add-point:BEFORE FIELD year_3 name="input.b.year_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year_3
            
            #add-point:AFTER FIELD year_3 name="input.a.year_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year_3
            #add-point:ON CHANGE year_3 name="input.g.year_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdate_3
            #add-point:BEFORE FIELD sdate_3 name="input.b.sdate_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdate_3
            
            #add-point:AFTER FIELD sdate_3 name="input.a.sdate_3"
            IF NOT cl_null(g_master.sdate_3) THEN 
            END IF 
            
            IF NOT cl_null(g_master.edate_3) THEN 
               IF g_master.edate_3<g_master.sdate_3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00227'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD sdate_3
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdate_3
            #add-point:ON CHANGE sdate_3 name="input.g.sdate_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate_3
            #add-point:BEFORE FIELD edate_3 name="input.b.edate_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate_3
            
            #add-point:AFTER FIELD edate_3 name="input.a.edate_3"
            IF NOT cl_null(g_master.edate_3) THEN 
            END IF 
            
            IF NOT cl_null(g_master.sdate_3) THEN 
               IF g_master.edate_3<g_master.sdate_3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00228'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD edate_3
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate_3
            #add-point:ON CHANGE edate_3 name="input.g.edate_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year_4
            #add-point:BEFORE FIELD year_4 name="input.b.year_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year_4
            
            #add-point:AFTER FIELD year_4 name="input.a.year_4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year_4
            #add-point:ON CHANGE year_4 name="input.g.year_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdate_4
            #add-point:BEFORE FIELD sdate_4 name="input.b.sdate_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdate_4
            
            #add-point:AFTER FIELD sdate_4 name="input.a.sdate_4"
            IF NOT cl_null(g_master.sdate_4) THEN 
            END IF 
            
            IF NOT cl_null(g_master.edate_4) THEN 
               IF g_master.edate_4<g_master.sdate_4 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00227'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD sdate_4
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdate_4
            #add-point:ON CHANGE sdate_4 name="input.g.sdate_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate_4
            #add-point:BEFORE FIELD edate_4 name="input.b.edate_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate_4
            
            #add-point:AFTER FIELD edate_4 name="input.a.edate_4"
            IF NOT cl_null(g_master.edate_4) THEN 
            END IF 
            
            IF NOT cl_null(g_master.sdate_4) THEN 
               IF g_master.edate_4<g_master.sdate_4 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00228'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD edate_4
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate_4
            #add-point:ON CHANGE edate_4 name="input.g.edate_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year_5
            #add-point:BEFORE FIELD year_5 name="input.b.year_5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year_5
            
            #add-point:AFTER FIELD year_5 name="input.a.year_5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year_5
            #add-point:ON CHANGE year_5 name="input.g.year_5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sdate_5
            #add-point:BEFORE FIELD sdate_5 name="input.b.sdate_5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sdate_5
            
            #add-point:AFTER FIELD sdate_5 name="input.a.sdate_5"
            IF NOT cl_null(g_master.sdate_5) THEN 
            END IF 
            
            IF NOT cl_null(g_master.edate_5) THEN 
               IF g_master.edate_5<g_master.sdate_5 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00227'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD sdate_5
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sdate_5
            #add-point:ON CHANGE sdate_5 name="input.g.sdate_5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate_5
            #add-point:BEFORE FIELD edate_5 name="input.b.edate_5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate_5
            
            #add-point:AFTER FIELD edate_5 name="input.a.edate_5"
            IF NOT cl_null(g_master.edate_5) THEN 
            END IF 
            
            IF NOT cl_null(g_master.sdate_5) THEN 
               IF g_master.edate_5<g_master.sdate_5 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = 'agl-00228'
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()       
                  NEXT FIELD edate_5
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate_5
            #add-point:ON CHANGE edate_5 name="input.g.edate_5"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.combobox_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD combobox_1
            #add-point:ON ACTION controlp INFIELD combobox_1 name="input.c.combobox_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.checkbox_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD checkbox_1
            #add-point:ON ACTION controlp INFIELD checkbox_1 name="input.c.checkbox_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.compare
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD compare
            #add-point:ON ACTION controlp INFIELD compare name="input.c.compare"
            
            #END add-point
 
 
         #Ctrlp:input.c.year_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year_1
            #add-point:ON ACTION controlp INFIELD year_1 name="input.c.year_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.sdate_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdate_1
            #add-point:ON ACTION controlp INFIELD sdate_1 name="input.c.sdate_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate_1
            #add-point:ON ACTION controlp INFIELD edate_1 name="input.c.edate_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.year_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year_2
            #add-point:ON ACTION controlp INFIELD year_2 name="input.c.year_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.sdate_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdate_2
            #add-point:ON ACTION controlp INFIELD sdate_2 name="input.c.sdate_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate_2
            #add-point:ON ACTION controlp INFIELD edate_2 name="input.c.edate_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.year_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year_3
            #add-point:ON ACTION controlp INFIELD year_3 name="input.c.year_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.sdate_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdate_3
            #add-point:ON ACTION controlp INFIELD sdate_3 name="input.c.sdate_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate_3
            #add-point:ON ACTION controlp INFIELD edate_3 name="input.c.edate_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.year_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year_4
            #add-point:ON ACTION controlp INFIELD year_4 name="input.c.year_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.sdate_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdate_4
            #add-point:ON ACTION controlp INFIELD sdate_4 name="input.c.sdate_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate_4
            #add-point:ON ACTION controlp INFIELD edate_4 name="input.c.edate_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.year_5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year_5
            #add-point:ON ACTION controlp INFIELD year_5 name="input.c.year_5"
            
            #END add-point
 
 
         #Ctrlp:input.c.sdate_5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sdate_5
            #add-point:ON ACTION controlp INFIELD sdate_5 name="input.c.sdate_5"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate_5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate_5
            #add-point:ON ACTION controlp INFIELD edate_5 name="input.c.edate_5"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON buttonedit_1,buttonedit_2
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.buttonedit_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD buttonedit_1
            #add-point:ON ACTION controlp INFIELD buttonedit_1 name="construct.c.buttonedit_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.arg1 = '1'
            LET g_qryparam.reqry = FALSE
            CALL q_rtaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO buttonedit_1  #顯示到畫面上
            NEXT FIELD buttonedit_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD buttonedit_1
            #add-point:BEFORE FIELD buttonedit_1 name="construct.b.buttonedit_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD buttonedit_1
            
            #add-point:AFTER FIELD buttonedit_1 name="construct.a.buttonedit_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.buttonedit_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD buttonedit_2
            #add-point:ON ACTION controlp INFIELD buttonedit_2 name="construct.c.buttonedit_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debosite',g_site,'c')
            CALL q_ooef001_24()                             #呼叫開窗
            DISPLAY g_qryparam.return1 TO buttonedit_2  #顯示到畫面上
            NEXT FIELD buttonedit_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD buttonedit_2
            #add-point:BEFORE FIELD buttonedit_2 name="construct.b.buttonedit_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD buttonedit_2
            
            #add-point:AFTER FIELD buttonedit_2 name="construct.a.buttonedit_2"
            
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
            CALL acrr827_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr827_get_buffer(l_dialog)
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
         CALL acrr827_init()
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
                 CALL acrr827_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr827_transfer_argv(ls_js)
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
#         LET g_master.compare = '1'      #期别数  
#         CALL acrr827_set_entry()
#         CALL acrr827_set_no_entry()
#         SELECT ooef008,ooef010  INTO g_oogc001,g_oogc002
#         FROM ooef_t
#         WHERE ooefent=g_enterprise
#               AND ooef001=g_site
#         CALL s_get_oogcdate(g_oogc001,g_oogc002,g_today,"","") RETURNING g_flag,g_errno,g_oogc015,g_oogc007,g_sdate_s,g_sdate_e,g_oogc006,g_pdate_s,g_pdate_e,g_oogc008,g_wdate_s,g_wdate_e
#         LET g_master.year_1 = g_oogc015
#         LET g_master.sdate_1 = g_oogc006
#         LET g_master.edate_1 = g_oogc006
#         LET g_master.year_2  = ""
#         LET g_master.sdate_2 = ""
#         LET g_master.edate_2 = ""
#         LET g_master.year_3  = ""
#         LET g_master.sdate_3 = ""
#         LET g_master.edate_3 = ""
#         LET g_master.year_4  = ""
#         LET g_master.sdate_4 = ""
#         LET g_master.edate_4 = ""
#         LET g_master.year_5  = ""
#         LET g_master.sdate_5 = ""
#         LET g_master.edate_5 = ""
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
 
{<section id="acrr827.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr827_transfer_argv(ls_js)
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
 
{<section id="acrr827.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr827_process(ls_js)
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
   DEFINE l_dat1        LIKE type_t.chr500                   #期别1
   DEFINE l_dat2        LIKE type_t.chr500                   #期别2
   DEFINE l_dat3        LIKE type_t.chr500                   #期别3
   DEFINE l_dat4        LIKE type_t.chr500                   #期别4
   DEFINE l_dat5        LIKE type_t.chr500                   #期别5
   
   DEFINE l_dat_name1   LIKE type_t.chr500
   DEFINE l_dat_name2   LIKE type_t.chr500
   DEFINE l_dat_name3   LIKE type_t.chr500
   DEFINE l_dat_name4   LIKE type_t.chr500
   DEFINE l_dat_name5   LIKE type_t.chr500
   DEFINE l_sdate_1     LIKE type_t.chr500 
   DEFINE l_sdate_2     LIKE type_t.chr500
   DEFINE l_sdate_3     LIKE type_t.chr500
   DEFINE l_sdate_4     LIKE type_t.chr500
   DEFINE l_sdate_5     LIKE type_t.chr500
   DEFINE l_edate_1     LIKE type_t.chr500
   DEFINE l_edate_2     LIKE type_t.chr500
   DEFINE l_edate_3     LIKE type_t.chr500
   DEFINE l_edate_4     LIKE type_t.chr500
   DEFINE l_edate_5     LIKE type_t.chr500
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"buttonedit_1,buttonedit_2")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN     #如果没有输入QBE查询条件
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
      LET ls_next = l_token.nextToken()
   IF l_cnt>1 THEN
            LET ls_next = ls_next.subString(ls_next.getIndexOf("'",1)+1,ls_next.getLength())
            LET ls_next = ls_next.subString(1,ls_next.getIndexOf("'",1)-1)
         END IF
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET g_master.wc = l_arg[01]
   ELSE  #如果有输入QBE查询条件
#      LET g_master.wc = g_master.wc CLIPPED, " AND xmdkent = ",g_enterprise, " AND xmdksite = '",g_site,"' "
      IF g_master.checkbox_1 = 'N' THEN   #没有勾选会员
         LET g_master.wc = cl_replace_str(g_master.wc, 'buttonedit_1','rtab001')
         LET g_master.wc = cl_replace_str(g_master.wc, 'buttonedit_2','debosite')
         
         LET g_master.wc = g_master.wc CLIPPED, "  AND deboent = '",g_enterprise ,"' AND rtabent = '",g_enterprise,"'"
      ELSE                                #勾选会员
         LET g_master.wc = cl_replace_str(g_master.wc, 'buttonedit_1','rtab001')
         LET g_master.wc = cl_replace_str(g_master.wc, 'buttonedit_2','debpsite')
         
         LET g_master.wc = g_master.wc CLIPPED, "  AND debpent = '",g_enterprise ,"' AND rtabent = '",g_enterprise,"'"
      END IF 
   END IF
   
   CASE g_master.compare   #选择的期别
      WHEN 1
         LET l_dat_name1 = g_master.year_1,".",g_master.sdate_1,"-",g_master.edate_1
      WHEN 2
         LET l_dat_name1 = g_master.year_1,".",g_master.sdate_1,"-",g_master.edate_1
         LET l_dat_name2 = g_master.year_2,".",g_master.sdate_2,"-",g_master.edate_2
      WHEN 3
         LET l_dat_name1 = g_master.year_1,".",g_master.sdate_1,"-",g_master.edate_1
         LET l_dat_name2 = g_master.year_2,".",g_master.sdate_2,"-",g_master.edate_2
         LET l_dat_name3 = g_master.year_3,".",g_master.sdate_3,"-",g_master.edate_3
      WHEN 4
         LET l_dat_name1 = g_master.year_1,".",g_master.sdate_1,"-",g_master.edate_1
         LET l_dat_name2 = g_master.year_2,".",g_master.sdate_2,"-",g_master.edate_2
         LET l_dat_name3 = g_master.year_3,".",g_master.sdate_3,"-",g_master.edate_3
         LET l_dat_name4 = g_master.year_4,".",g_master.sdate_4,"-",g_master.edate_4
      WHEN 5
         LET l_dat_name1 = g_master.year_1,".",g_master.sdate_1,"-",g_master.edate_1
         LET l_dat_name2 = g_master.year_2,".",g_master.sdate_2,"-",g_master.edate_2
         LET l_dat_name3 = g_master.year_3,".",g_master.sdate_3,"-",g_master.edate_3
         LET l_dat_name4 = g_master.year_4,".",g_master.sdate_4,"-",g_master.edate_4
         LET l_dat_name5 = g_master.year_5,".",g_master.sdate_5,"-",g_master.edate_5
   END CASE
   
   CASE g_master.compare
      WHEN 1   #选择期别1
         LET l_sdate_1 = MDY(g_master.sdate_1,1,g_master.year_1)
         LET l_edate_1 = MDY(g_master.edate_1,1,g_master.year_1)
         CALL s_date_get_last_date(l_edate_1) RETURNING l_edate_1
         LET l_dat1 = " BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd') "
      WHEN 2
         LET l_sdate_1 = MDY(g_master.sdate_1,1,g_master.year_1)
         LET l_edate_1 = MDY(g_master.edate_1,1,g_master.year_1)
         CALL s_date_get_last_date(l_edate_1) RETURNING l_edate_1
         LET l_dat1 = " BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd') "
         
         LET l_sdate_2 = MDY(g_master.sdate_2,1,g_master.year_2)
         LET l_edate_2 = MDY(g_master.edate_2,1,g_master.year_2)
         CALL s_date_get_last_date(l_edate_2) RETURNING l_edate_2
         LET l_dat2 = " BETWEEN to_date('",l_sdate_2,"','yy/mm/dd') AND to_date('",l_edate_2,"','yy/mm/dd') "
      WHEN 3
         LET l_sdate_1 = MDY(g_master.sdate_1,1,g_master.year_1)
         LET l_edate_1 = MDY(g_master.edate_1,1,g_master.year_1)
         CALL s_date_get_last_date(l_edate_1) RETURNING l_edate_1
         LET l_dat1 = " BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd') "
         
         LET l_sdate_2 = MDY(g_master.sdate_2,1,g_master.year_2)
         LET l_edate_2 = MDY(g_master.edate_2,1,g_master.year_2)
         CALL s_date_get_last_date(l_edate_2) RETURNING l_edate_2
         LET l_dat2 = " BETWEEN to_date('",l_sdate_2,"','yy/mm/dd') AND to_date('",l_edate_2,"','yy/mm/dd') "
         
         LET l_sdate_3 = MDY(g_master.sdate_3,1,g_master.year_3)
         LET l_edate_3 = MDY(g_master.edate_3,1,g_master.year_3)
         CALL s_date_get_last_date(l_edate_3) RETURNING l_edate_3
         LET l_dat3 = " BETWEEN to_date('",l_sdate_3,"','yy/mm/dd') AND to_date('",l_edate_3,"','yy/mm/dd') "
      WHEN 4
         LET l_sdate_1 = MDY(g_master.sdate_1,1,g_master.year_1)
         LET l_edate_1 = MDY(g_master.edate_1,1,g_master.year_1)
         CALL s_date_get_last_date(l_edate_1) RETURNING l_edate_1
         LET l_dat1 = " BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd') "
         
         LET l_sdate_2 = MDY(g_master.sdate_2,1,g_master.year_2)
         LET l_edate_2 = MDY(g_master.edate_2,1,g_master.year_2)
         CALL s_date_get_last_date(l_edate_2) RETURNING l_edate_2
         LET l_dat2 = " BETWEEN to_date('",l_sdate_2,"','yy/mm/dd') AND to_date('",l_edate_2,"','yy/mm/dd') "
         
         LET l_sdate_3 = MDY(g_master.sdate_3,1,g_master.year_3)
         LET l_edate_3 = MDY(g_master.edate_3,1,g_master.year_3)
         CALL s_date_get_last_date(l_edate_3) RETURNING l_edate_3
         LET l_dat3 = " BETWEEN to_date('",l_sdate_3,"','yy/mm/dd') AND to_date('",l_edate_3,"','yy/mm/dd') "
         
         LET l_sdate_4 = MDY(g_master.sdate_4,1,g_master.year_4)
         LET l_edate_4 = MDY(g_master.edate_4,1,g_master.year_4)
         CALL s_date_get_last_date(l_edate_4) RETURNING l_edate_4
         LET l_dat4 = " BETWEEN to_date('",l_sdate_4,"','yy/mm/dd') AND to_date('",l_edate_4,"','yy/mm/dd') "
      WHEN 5
         LET l_sdate_1 = MDY(g_master.sdate_1,1,g_master.year_1)
         LET l_edate_1 = MDY(g_master.edate_1,1,g_master.year_1)
         CALL s_date_get_last_date(l_edate_1) RETURNING l_edate_1
         LET l_dat1 = " BETWEEN to_date('",l_sdate_1,"','yy/mm/dd') AND to_date('",l_edate_1,"','yy/mm/dd') "
         
         LET l_sdate_2 = MDY(g_master.sdate_2,1,g_master.year_2)
         LET l_edate_2 = MDY(g_master.edate_2,1,g_master.year_2)
         CALL s_date_get_last_date(l_edate_2) RETURNING l_edate_2
         LET l_dat2 = " BETWEEN to_date('",l_sdate_2,"','yy/mm/dd') AND to_date('",l_edate_2,"','yy/mm/dd') "
         
         LET l_sdate_3 = MDY(g_master.sdate_3,1,g_master.year_3)
         LET l_edate_3 = MDY(g_master.edate_3,1,g_master.year_3)
         CALL s_date_get_last_date(l_edate_3) RETURNING l_edate_3
         LET l_dat3 = " BETWEEN to_date('",l_sdate_3,"','yy/mm/dd') AND to_date('",l_edate_3,"','yy/mm/dd') "
         
         LET l_sdate_4 = MDY(g_master.sdate_4,1,g_master.year_4)
         LET l_edate_4 = MDY(g_master.edate_4,1,g_master.year_4)
         CALL s_date_get_last_date(l_edate_4) RETURNING l_edate_4
         LET l_dat4 = " BETWEEN to_date('",l_sdate_4,"','yy/mm/dd') AND to_date('",l_edate_4,"','yy/mm/dd') "
         
         LET l_sdate_5 = MDY(g_master.sdate_5,1,g_master.year_5)
         LET l_edate_5 = MDY(g_master.edate_5,1,g_master.year_5)
         CALL s_date_get_last_date(l_edate_5) RETURNING l_edate_5
         LET l_dat5 = " BETWEEN to_date('",l_sdate_5,"','yy/mm/dd') AND to_date('",l_edate_5,"','yy/mm/dd') "
   END CASE
   CREATE TEMP TABLE acrr827_tmp(
       dat_start  VARCHAR(500),               #开始日期
       dat_end    VARCHAR(500),               #结束日期
       dat_name   VARCHAR(500)     #年期
       )
   CASE g_master.compare
      WHEN 1
         DELETE FROM acrr827_tmp
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_1,l_edate_1,l_dat_name1)
      WHEN 2                                                                     
         DELETE FROM acrr827_tmp                                                 
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_1,l_edate_1,l_dat_name1)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_2,l_edate_2,l_dat_name2)
      WHEN 3                                                                     
         DELETE FROM acrr827_tmp                                                 
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_1,l_edate_1,l_dat_name1)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_2,l_edate_2,l_dat_name2)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_3,l_edate_3,l_dat_name3)
      WHEN 4                                                                     
         DELETE FROM acrr827_tmp                                                 
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_1,l_edate_1,l_dat_name1)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_2,l_edate_2,l_dat_name2)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_3,l_edate_3,l_dat_name3)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_4,l_edate_4,l_dat_name4)
      WHEN 5                                                                     
         DELETE FROM acrr827_tmp                                                 
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_1,l_edate_1,l_dat_name1)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_2,l_edate_2,l_dat_name2)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_3,l_edate_3,l_dat_name3)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_4,l_edate_4,l_dat_name4)
         INSERT INTO acrr827_tmp(dat_start,dat_end,dat_name) VALUES (l_sdate_5,l_edate_5,l_dat_name5)
   END CASE
   
   CALL acrr827_x01(g_master.wc,g_master.combobox_1,g_master.checkbox_1,g_master.compare,l_dat1,l_dat2,l_dat3,l_dat4,l_dat5,
                     l_dat_name1,l_dat_name2,l_dat_name3,l_dat_name4,l_dat_name5)

   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr827_process_cs CURSOR FROM ls_sql
#  FOREACH acrr827_process_cs INTO
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
 
{<section id="acrr827.get_buffer" >}
PRIVATE FUNCTION acrr827_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.combobox_1 = p_dialog.getFieldBuffer('combobox_1')
   LET g_master.checkbox_1 = p_dialog.getFieldBuffer('checkbox_1')
   LET g_master.compare = p_dialog.getFieldBuffer('compare')
   LET g_master.year_1 = p_dialog.getFieldBuffer('year_1')
   LET g_master.sdate_1 = p_dialog.getFieldBuffer('sdate_1')
   LET g_master.edate_1 = p_dialog.getFieldBuffer('edate_1')
   LET g_master.year_2 = p_dialog.getFieldBuffer('year_2')
   LET g_master.sdate_2 = p_dialog.getFieldBuffer('sdate_2')
   LET g_master.edate_2 = p_dialog.getFieldBuffer('edate_2')
   LET g_master.year_3 = p_dialog.getFieldBuffer('year_3')
   LET g_master.sdate_3 = p_dialog.getFieldBuffer('sdate_3')
   LET g_master.edate_3 = p_dialog.getFieldBuffer('edate_3')
   LET g_master.year_4 = p_dialog.getFieldBuffer('year_4')
   LET g_master.sdate_4 = p_dialog.getFieldBuffer('sdate_4')
   LET g_master.edate_4 = p_dialog.getFieldBuffer('edate_4')
   LET g_master.year_5 = p_dialog.getFieldBuffer('year_5')
   LET g_master.sdate_5 = p_dialog.getFieldBuffer('sdate_5')
   LET g_master.edate_5 = p_dialog.getFieldBuffer('edate_5')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr827.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 动态开启栏位
# Memo...........:
# Usage..........: CALL acrr827_set_entry()
#                  RETURNING 回传参数
# Date & Author..: 2016/05/10 By pengxin
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr827_set_entry()
   CALL cl_set_comp_entry("year_2",TRUE)
   CALL cl_set_comp_entry("year_3",TRUE)
   CALL cl_set_comp_entry("year_4",TRUE)
   CALL cl_set_comp_entry("year_5",TRUE)
   
   CALL cl_set_comp_entry("sdate_2",TRUE)
   CALL cl_set_comp_entry("sdate_3",TRUE)
   CALL cl_set_comp_entry("sdate_4",TRUE)
   CALL cl_set_comp_entry("sdate_5",TRUE)
   
   CALL cl_set_comp_entry("edate_2",TRUE)
   CALL cl_set_comp_entry("edate_3",TRUE)
   CALL cl_set_comp_entry("edate_4",TRUE)
   CALL cl_set_comp_entry("edate_5",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 动态关闭栏位
# Memo...........:
# Usage..........: CALL acrr827_set_no_entry()
#                  RETURNING 回传参数
# Date & Author..: 2016/05/10 By pengxin
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr827_set_no_entry()
   CASE g_master.compare
      WHEN 1   #如果期别数为“一期” 则隐藏“二期年度、期别” 、“三期年度、期别”、“四期年度、期别”、“五期年度、期别”栏位
         CALL cl_set_comp_entry("year_2",FALSE)
         CALL cl_set_comp_entry("year_3",FALSE)
         CALL cl_set_comp_entry("year_4",FALSE)
         CALL cl_set_comp_entry("year_5",FALSE)
         
         CALL cl_set_comp_entry("sdate_2",FALSE)
         CALL cl_set_comp_entry("sdate_3",FALSE)
         CALL cl_set_comp_entry("sdate_4",FALSE)
         CALL cl_set_comp_entry("sdate_5",FALSE)
         
         CALL cl_set_comp_entry("edate_2",FALSE)
         CALL cl_set_comp_entry("edate_3",FALSE)
         CALL cl_set_comp_entry("edate_4",FALSE)
         CALL cl_set_comp_entry("edate_5",FALSE)
      WHEN 2   #如果期别数为“二期” 则隐藏“三期年度、期别”、“四期年度、期别”、“五期年度、期别”栏位 
         CALL cl_set_comp_entry("year_3",FALSE)
         CALL cl_set_comp_entry("year_4",FALSE)
         CALL cl_set_comp_entry("year_5",FALSE)
         
         CALL cl_set_comp_entry("sdate_3",FALSE)
         CALL cl_set_comp_entry("sdate_4",FALSE)
         CALL cl_set_comp_entry("sdate_5",FALSE)
         
         CALL cl_set_comp_entry("edate_3",FALSE)
         CALL cl_set_comp_entry("edate_4",FALSE)
         CALL cl_set_comp_entry("edate_5",FALSE)
      WHEN 3   #如果期别数为“三期” 则隐藏“四期年度、期别”、“五期年度、期别”栏位
         CALL cl_set_comp_entry("year_4",FALSE)
         CALL cl_set_comp_entry("year_5",FALSE)
         
         CALL cl_set_comp_entry("sdate_4",FALSE)
         CALL cl_set_comp_entry("sdate_5",FALSE)
         
         CALL cl_set_comp_entry("edate_4",FALSE)
         CALL cl_set_comp_entry("edate_5",FALSE)
      WHEN 4   #如果期别数为“四期” 则隐藏“五期年度、期别”栏位     
         CALL cl_set_comp_entry("year_5",FALSE)
         
         CALL cl_set_comp_entry("sdate_5",FALSE)
         
         CALL cl_set_comp_entry("edate_5",FALSE)
   END CASE
END FUNCTION

#end add-point
 
{</section>}
 
