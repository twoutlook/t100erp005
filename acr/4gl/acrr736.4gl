#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr736.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-11-26 17:58:53), PR版次:0002(2016-02-22 18:37:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: acrr736
#+ Description: 會員消費日報表
#+ Creator....: 03247(2014-09-11 17:02:40)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr736.global" >}
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
       decb005 LIKE type_t.chr500, 
   rtab001 LIKE type_t.chr500, 
   decbsite LIKE type_t.chr500, 
   year1 LIKE type_t.num5, 
   year2 LIKE type_t.num5, 
   season1 LIKE type_t.num5, 
   season2 LIKE type_t.num5, 
   week1 LIKE type_t.num5, 
   week2 LIKE type_t.num5, 
   month1 LIKE type_t.num5, 
   month2 LIKE type_t.num5, 
   day1 LIKE type_t.dat, 
   day2 LIKE type_t.dat,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_type      LIKE type_t.chr1
DEFINE g_year      LIKE oogc_t.oogc015
DEFINE g_season    LIKE oogc_t.oogc007
DEFINE g_week      LIKE oogc_t.oogc008
DEFINE g_month     LIKE oogc_t.oogc006
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrr736.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   LET g_type = g_argv[1]
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrr736_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr736 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr736_init()
 
      #進入選單 Menu (="N")
      CALL acrr736_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr736
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr736.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr736_init()
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc("order1","6735")
   CALL cl_set_combo_scc("order2","6735")
   CALL cl_set_combo_scc("order3","6735")
   CALL acrr736_comp_visible()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr736.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr736_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_ooef008            LIKE ooef_t.ooef008
   DEFINE l_ooef010            LIKE ooef_t.ooef010
   DEFINE r_flag               LIKE type_t.chr1
   DEFINE r_errno              LIKE type_t.chr100
   DEFINE r_oogc015            LIKE oogc_t.oogc015
   DEFINE r_oogc007            LIKE oogc_t.oogc007
   DEFINE r_sdate_s            LIKE oogc_t.oogc003
   DEFINE r_sdate_e            LIKE oogc_t.oogc003
   DEFINE r_oogc006            LIKE oogc_t.oogc006
   DEFINE r_pdate_s            LIKE oogc_t.oogc003
   DEFINE r_pdate_e            LIKE oogc_t.oogc003
   DEFINE r_oogc008            LIKE oogc_t.oogc008
   DEFINE r_wdate_s            LIKE oogc_t.oogc003
   DEFINE r_wdate_e            LIKE oogc_t.oogc003
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET l_ooef008 = ''
   LET l_ooef010 = ''
   LET g_year = ''
   LET g_season = ''
   LET g_week = ''
   LET g_month = ''
   SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_get_oogcdate(l_ooef008,l_ooef010,g_today,'','')
       RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
   LET g_year = r_oogc015
   LET g_season = r_oogc007
   LET g_week = r_oogc008
   LET g_month = r_oogc006
   LET g_master.year1 = g_year
   LET g_master.year2 = g_year
   LET g_master.season1 = g_season
   LET g_master.season2 = g_season
   LET g_master.week1 = g_week
   LET g_master.week2 = g_week
   LET g_master.month1 = g_month
   LET g_master.month2 = g_month
   LET g_master.day1 = g_today
   LET g_master.day2 = g_today
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.year1,g_master.year2,g_master.season1,g_master.season2,g_master.week1, 
             g_master.week2,g_master.month1,g_master.month2,g_master.day1,g_master.day2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year1
            #add-point:BEFORE FIELD year1 name="input.b.year1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year1
            
            #add-point:AFTER FIELD year1 name="input.a.year1"
            IF NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 > g_master.year2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD year1
               END IF
               
               IF NOT cl_null(g_master.week1) AND NOT cl_null(g_master.week2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.week1 > g_master.week2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00066'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year1
                  END IF
               END IF
               
               IF NOT cl_null(g_master.month1) AND NOT cl_null(g_master.month2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.month1 > g_master.month2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year1
                  END IF
               END IF
               
               IF NOT cl_null(g_master.season1) AND NOT cl_null(g_master.season2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.season1 > g_master.season2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00065'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year1
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year1
            #add-point:ON CHANGE year1 name="input.g.year1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year2
            #add-point:BEFORE FIELD year2 name="input.b.year2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year2
            
            #add-point:AFTER FIELD year2 name="input.a.year2"
            IF NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 > g_master.year2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00064'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD year2
               END IF
               
               IF NOT cl_null(g_master.week1) AND NOT cl_null(g_master.week2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.week1 > g_master.week2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00066'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year2
                  END IF
               END IF
               
               IF NOT cl_null(g_master.month1) AND NOT cl_null(g_master.month2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.month1 > g_master.month2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00067'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year2
                  END IF
               END IF
               
               IF NOT cl_null(g_master.season1) AND NOT cl_null(g_master.season2) THEN
                  IF g_master.year1 = g_master.year2 AND g_master.season1 > g_master.season2 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'acr-00065'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD year2
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year2
            #add-point:ON CHANGE year2 name="input.g.year2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD season1
            #add-point:BEFORE FIELD season1 name="input.b.season1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD season1
            
            #add-point:AFTER FIELD season1 name="input.a.season1"
            IF NOT cl_null(g_master.season1) AND NOT cl_null(g_master.season2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.season1 > g_master.season2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00065'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD season1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE season1
            #add-point:ON CHANGE season1 name="input.g.season1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD season2
            #add-point:BEFORE FIELD season2 name="input.b.season2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD season2
            
            #add-point:AFTER FIELD season2 name="input.a.season2"
            IF NOT cl_null(g_master.season1) AND NOT cl_null(g_master.season2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.season1 > g_master.season2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00065'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD season2
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE season2
            #add-point:ON CHANGE season2 name="input.g.season2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD week1
            #add-point:BEFORE FIELD week1 name="input.b.week1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD week1
            
            #add-point:AFTER FIELD week1 name="input.a.week1"
            IF NOT cl_null(g_master.week1) AND NOT cl_null(g_master.week2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.week1 > g_master.week2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00066'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD week1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE week1
            #add-point:ON CHANGE week1 name="input.g.week1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD week2
            #add-point:BEFORE FIELD week2 name="input.b.week2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD week2
            
            #add-point:AFTER FIELD week2 name="input.a.week2"
            IF NOT cl_null(g_master.week1) AND NOT cl_null(g_master.week2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.week1 > g_master.week2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00066'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD week2
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE week2
            #add-point:ON CHANGE week2 name="input.g.week2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month1
            #add-point:BEFORE FIELD month1 name="input.b.month1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month1
            
            #add-point:AFTER FIELD month1 name="input.a.month1"
            IF NOT cl_null(g_master.month1) AND NOT cl_null(g_master.month2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.month1 > g_master.month2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD month1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month1
            #add-point:ON CHANGE month1 name="input.g.month1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month2
            #add-point:BEFORE FIELD month2 name="input.b.month2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month2
            
            #add-point:AFTER FIELD month2 name="input.a.month2"
            IF NOT cl_null(g_master.month1) AND NOT cl_null(g_master.month2) AND
               NOT cl_null(g_master.year1) AND NOT cl_null(g_master.year2) THEN
               IF g_master.year1 = g_master.year2 AND g_master.month1 > g_master.month2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00067'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD month2
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month2
            #add-point:ON CHANGE month2 name="input.g.month2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD day1
            #add-point:BEFORE FIELD day1 name="input.b.day1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD day1
            
            #add-point:AFTER FIELD day1 name="input.a.day1"
            IF NOT cl_null(g_master.day1) AND NOT cl_null(g_master.day2) THEN
               IF g_master.day1 > g_master.day2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00068'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD day1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE day1
            #add-point:ON CHANGE day1 name="input.g.day1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD day2
            #add-point:BEFORE FIELD day2 name="input.b.day2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD day2
            
            #add-point:AFTER FIELD day2 name="input.a.day2"
            IF NOT cl_null(g_master.day1) AND NOT cl_null(g_master.day2) THEN
               IF g_master.day1 > g_master.day2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00068'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD day2
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE day2
            #add-point:ON CHANGE day2 name="input.g.day2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.year1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year1
            #add-point:ON ACTION controlp INFIELD year1 name="input.c.year1"
            
            #END add-point
 
 
         #Ctrlp:input.c.year2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year2
            #add-point:ON ACTION controlp INFIELD year2 name="input.c.year2"
            
            #END add-point
 
 
         #Ctrlp:input.c.season1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD season1
            #add-point:ON ACTION controlp INFIELD season1 name="input.c.season1"
            
            #END add-point
 
 
         #Ctrlp:input.c.season2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD season2
            #add-point:ON ACTION controlp INFIELD season2 name="input.c.season2"
            
            #END add-point
 
 
         #Ctrlp:input.c.week1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD week1
            #add-point:ON ACTION controlp INFIELD week1 name="input.c.week1"
            
            #END add-point
 
 
         #Ctrlp:input.c.week2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD week2
            #add-point:ON ACTION controlp INFIELD week2 name="input.c.week2"
            
            #END add-point
 
 
         #Ctrlp:input.c.month1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month1
            #add-point:ON ACTION controlp INFIELD month1 name="input.c.month1"
            
            #END add-point
 
 
         #Ctrlp:input.c.month2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month2
            #add-point:ON ACTION controlp INFIELD month2 name="input.c.month2"
            
            #END add-point
 
 
         #Ctrlp:input.c.day1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD day1
            #add-point:ON ACTION controlp INFIELD day1 name="input.c.day1"
            
            #END add-point
 
 
         #Ctrlp:input.c.day2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD day2
            #add-point:ON ACTION controlp INFIELD day2 name="input.c.day2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON decb005,rtab001,decbsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.decb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD decb005
            #add-point:ON ACTION controlp INFIELD decb005 name="construct.c.decb005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO decb005  #顯示到畫面上
            NEXT FIELD decb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD decb005
            #add-point:BEFORE FIELD decb005 name="construct.b.decb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD decb005
            
            #add-point:AFTER FIELD decb005 name="construct.a.decb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtab001
            #add-point:ON ACTION controlp INFIELD rtab001 name="construct.c.rtab001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_rtaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtab001  #顯示到畫面上
            NEXT FIELD rtab001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtab001
            #add-point:BEFORE FIELD rtab001 name="construct.b.rtab001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtab001
            
            #add-point:AFTER FIELD rtab001 name="construct.a.rtab001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.decbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD decbsite
            #add-point:ON ACTION controlp INFIELD decbsite name="construct.c.decbsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            CALL q_ooef001_18()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decbsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO decbsite  #顯示到畫面上
            NEXT FIELD decbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD decbsite
            #add-point:BEFORE FIELD decbsite name="construct.b.decbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD decbsite
            
            #add-point:AFTER FIELD decbsite name="construct.a.decbsite"
            
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
            CALL acrr736_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr736_get_buffer(l_dialog)
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
         CALL acrr736_init()
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
                 CALL acrr736_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr736_transfer_argv(ls_js)
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
 
{<section id="acrr736.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr736_transfer_argv(ls_js)
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
 
{<section id="acrr736.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr736_process(ls_js)
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
   DEFINE l_where     STRING
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"decb005,rtab001,decbsite")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr736_process_cs CURSOR FROM ls_sql
#  FOREACH acrr736_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_aooi500_sql_where(g_prog,'decbsite') RETURNING l_where
   LET g_master.wc = g_master.wc," AND ",l_where
   IF g_type = 'D' THEN
      CALL acrr736_x01(g_master.wc,g_master.day1,g_master.day2)
   END IF
   IF g_type = 'W' THEN
      CALL acrr736_x02(g_master.wc,g_master.year1,g_master.year2,g_master.week1,g_master.week2)
   END IF
   IF g_type = 'M' THEN
      CALL acrr736_x03(g_master.wc,g_master.year1,g_master.year2,g_master.month1,g_master.month2)
   END IF
   IF g_type = 'S' THEN
      CALL acrr736_x04(g_master.wc,g_master.year1,g_master.year2,g_master.season1,g_master.season2)
   END IF
   IF g_type = 'Y' THEN
      CALL acrr736_x05(g_master.wc,g_master.year1,g_master.year2)
   END IF
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
 
{<section id="acrr736.get_buffer" >}
PRIVATE FUNCTION acrr736_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.year1 = p_dialog.getFieldBuffer('year1')
   LET g_master.year2 = p_dialog.getFieldBuffer('year2')
   LET g_master.season1 = p_dialog.getFieldBuffer('season1')
   LET g_master.season2 = p_dialog.getFieldBuffer('season2')
   LET g_master.week1 = p_dialog.getFieldBuffer('week1')
   LET g_master.week2 = p_dialog.getFieldBuffer('week2')
   LET g_master.month1 = p_dialog.getFieldBuffer('month1')
   LET g_master.month2 = p_dialog.getFieldBuffer('month2')
   LET g_master.day1 = p_dialog.getFieldBuffer('day1')
   LET g_master.day2 = p_dialog.getFieldBuffer('day2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr736.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 根據傳參類型顯示對於欄位
# Memo...........:
# Usage..........: CALL acrr736_comp_visible()
# Date & Author..: 20140918 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr736_comp_visible()

   IF g_type = 'D' THEN
      CALL cl_set_comp_visible("year1,year2,season1,season2,week1,week2,month1,month2",FALSE)
   END IF
   IF g_type = 'W' THEN
      CALL cl_set_comp_visible("season1,season2,month1,month2,day1,day2",FALSE)
   END IF
   IF g_type = 'M' THEN
      CALL cl_set_comp_visible("season1,season2,week1,week2,day1,day2",FALSE)
   END IF
   IF g_type = 'S' THEN
      CALL cl_set_comp_visible("week1,week2,month1,month2,day1,day2",FALSE)
   END IF
   IF g_type = 'Y' THEN
      CALL cl_set_comp_visible("season1,season2,week1,week2,month1,month2,day1,day2",FALSE)
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
