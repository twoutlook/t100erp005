#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr720.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-04-28 18:31:16), PR版次:0001(2016-04-29 16:15:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: acrr720
#+ Description: 會員屬性項目分析報表
#+ Creator....: 03247(2016-04-25 17:18:19)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr720.global" >}
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
       rtab001 LIKE type_t.chr10, 
   mmafunit LIKE type_t.chr10, 
   oocq002 LIKE type_t.chr10, 
   oocq002_desc LIKE type_t.chr80, 
   type1 LIKE type_t.chr1, 
   year1 LIKE type_t.num10, 
   mon11 LIKE type_t.num10, 
   mon12 LIKE type_t.num5, 
   year2 LIKE type_t.num5, 
   mon21 LIKE type_t.num5, 
   mon22 LIKE type_t.num5, 
   year3 LIKE type_t.num5, 
   mon31 LIKE type_t.num5, 
   mon32 LIKE type_t.num5, 
   year4 LIKE type_t.num5, 
   mon41 LIKE type_t.num5, 
   mon42 LIKE type_t.num5, 
   year5 LIKE type_t.num5, 
   mon51 LIKE type_t.num5, 
   mon52 LIKE type_t.num5,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtab_wc             STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrr720.main" >}
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
      CALL acrr720_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr720 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr720_init()
 
      #進入選單 Menu (="N")
      CALL acrr720_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr720
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL acrr720_temp_process('2')
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr720.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr720_init()
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
   CALL acrr720_temp_process('1')
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr720.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr720_ui_dialog()
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
         INPUT BY NAME g_master.oocq002,g_master.type1,g_master.year1,g_master.mon11,g_master.mon12, 
             g_master.year2,g_master.mon21,g_master.mon22,g_master.year3,g_master.mon31,g_master.mon32, 
             g_master.year4,g_master.mon41,g_master.mon42,g_master.year5,g_master.mon51,g_master.mon52  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="input.a.oocq002"
            IF NOT cl_null(g_master.oocq002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '2049'
               LET g_chkparam.arg2 = g_master.oocq002
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_1") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
 


            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_master.oocq002
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2049' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_master.oocq002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.oocq002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="input.b.oocq002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oocq002
            #add-point:ON CHANGE oocq002 name="input.g.oocq002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type1
            #add-point:BEFORE FIELD type1 name="input.b.type1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type1
            
            #add-point:AFTER FIELD type1 name="input.a.type1"
            CALL acrr720_set_comp_visible()
            CALL acrr720_set_comp_no_visible()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type1
            #add-point:ON CHANGE type1 name="input.g.type1"
            CALL acrr720_set_comp_visible()
            CALL acrr720_set_comp_no_visible()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year1
            #add-point:BEFORE FIELD year1 name="input.b.year1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year1
            
            #add-point:AFTER FIELD year1 name="input.a.year1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year1
            #add-point:ON CHANGE year1 name="input.g.year1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon11
            #add-point:BEFORE FIELD mon11 name="input.b.mon11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon11
            
            #add-point:AFTER FIELD mon11 name="input.a.mon11"
            IF NOT cl_null(g_master.mon11) AND NOT cl_null(g_master.mon12) THEN
               IF g_master.mon11 > g_master.mon12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon11
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon11
            #add-point:ON CHANGE mon11 name="input.g.mon11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon12
            #add-point:BEFORE FIELD mon12 name="input.b.mon12"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon12
            
            #add-point:AFTER FIELD mon12 name="input.a.mon12"
            IF NOT cl_null(g_master.mon11) AND NOT cl_null(g_master.mon12) THEN
               IF g_master.mon11 > g_master.mon12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon12
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon12
            #add-point:ON CHANGE mon12 name="input.g.mon12"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year2
            #add-point:BEFORE FIELD year2 name="input.b.year2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year2
            
            #add-point:AFTER FIELD year2 name="input.a.year2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year2
            #add-point:ON CHANGE year2 name="input.g.year2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon21
            #add-point:BEFORE FIELD mon21 name="input.b.mon21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon21
            
            #add-point:AFTER FIELD mon21 name="input.a.mon21"
            IF NOT cl_null(g_master.mon21) AND NOT cl_null(g_master.mon22) THEN
               IF g_master.mon21 > g_master.mon22 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon21
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon21
            #add-point:ON CHANGE mon21 name="input.g.mon21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon22
            #add-point:BEFORE FIELD mon22 name="input.b.mon22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon22
            
            #add-point:AFTER FIELD mon22 name="input.a.mon22"
            IF NOT cl_null(g_master.mon21) AND NOT cl_null(g_master.mon22) THEN
               IF g_master.mon21 > g_master.mon22 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon22
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon22
            #add-point:ON CHANGE mon22 name="input.g.mon22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year3
            #add-point:BEFORE FIELD year3 name="input.b.year3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year3
            
            #add-point:AFTER FIELD year3 name="input.a.year3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year3
            #add-point:ON CHANGE year3 name="input.g.year3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon31
            #add-point:BEFORE FIELD mon31 name="input.b.mon31"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon31
            
            #add-point:AFTER FIELD mon31 name="input.a.mon31"
            IF NOT cl_null(g_master.mon31) AND NOT cl_null(g_master.mon32) THEN
               IF g_master.mon31 > g_master.mon32 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon31
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon31
            #add-point:ON CHANGE mon31 name="input.g.mon31"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon32
            #add-point:BEFORE FIELD mon32 name="input.b.mon32"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon32
            
            #add-point:AFTER FIELD mon32 name="input.a.mon32"
            IF NOT cl_null(g_master.mon31) AND NOT cl_null(g_master.mon32) THEN
               IF g_master.mon31 > g_master.mon32 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon32
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon32
            #add-point:ON CHANGE mon32 name="input.g.mon32"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year4
            #add-point:BEFORE FIELD year4 name="input.b.year4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year4
            
            #add-point:AFTER FIELD year4 name="input.a.year4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year4
            #add-point:ON CHANGE year4 name="input.g.year4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon41
            #add-point:BEFORE FIELD mon41 name="input.b.mon41"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon41
            
            #add-point:AFTER FIELD mon41 name="input.a.mon41"
            IF NOT cl_null(g_master.mon41) AND NOT cl_null(g_master.mon42) THEN
               IF g_master.mon41 > g_master.mon42 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon41
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon41
            #add-point:ON CHANGE mon41 name="input.g.mon41"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon42
            #add-point:BEFORE FIELD mon42 name="input.b.mon42"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon42
            
            #add-point:AFTER FIELD mon42 name="input.a.mon42"
            IF NOT cl_null(g_master.mon41) AND NOT cl_null(g_master.mon42) THEN
               IF g_master.mon41 > g_master.mon42 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon42
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon42
            #add-point:ON CHANGE mon42 name="input.g.mon42"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year5
            #add-point:BEFORE FIELD year5 name="input.b.year5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year5
            
            #add-point:AFTER FIELD year5 name="input.a.year5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year5
            #add-point:ON CHANGE year5 name="input.g.year5"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon51
            #add-point:BEFORE FIELD mon51 name="input.b.mon51"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon51
            
            #add-point:AFTER FIELD mon51 name="input.a.mon51"
            IF NOT cl_null(g_master.mon51) AND NOT cl_null(g_master.mon52) THEN
               IF g_master.mon51 > g_master.mon52 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon51
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon51
            #add-point:ON CHANGE mon51 name="input.g.mon51"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon52
            #add-point:BEFORE FIELD mon52 name="input.b.mon52"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon52
            
            #add-point:AFTER FIELD mon52 name="input.a.mon52"
            IF NOT cl_null(g_master.mon51) AND NOT cl_null(g_master.mon52) THEN
               IF g_master.mon51 > g_master.mon52 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD mon52
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon52
            #add-point:ON CHANGE mon52 name="input.g.mon52"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="input.c.oocq002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.oocq002             #給予default值
            LET g_qryparam.default2 = g_master.oocq002_desc #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "2049" #s

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_master.oocq002 = g_qryparam.return1              
            LET g_master.oocq002_desc = g_qryparam.return2 
            DISPLAY g_master.oocq002 TO oocq002              #
            DISPLAY g_master.oocq002_desc TO oocq002_desc #應用分類碼
            NEXT FIELD oocq002                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.type1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type1
            #add-point:ON ACTION controlp INFIELD type1 name="input.c.type1"
            
            #END add-point
 
 
         #Ctrlp:input.c.year1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year1
            #add-point:ON ACTION controlp INFIELD year1 name="input.c.year1"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon11
            #add-point:ON ACTION controlp INFIELD mon11 name="input.c.mon11"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon12
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon12
            #add-point:ON ACTION controlp INFIELD mon12 name="input.c.mon12"
            
            #END add-point
 
 
         #Ctrlp:input.c.year2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year2
            #add-point:ON ACTION controlp INFIELD year2 name="input.c.year2"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon21
            #add-point:ON ACTION controlp INFIELD mon21 name="input.c.mon21"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon22
            #add-point:ON ACTION controlp INFIELD mon22 name="input.c.mon22"
            
            #END add-point
 
 
         #Ctrlp:input.c.year3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year3
            #add-point:ON ACTION controlp INFIELD year3 name="input.c.year3"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon31
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon31
            #add-point:ON ACTION controlp INFIELD mon31 name="input.c.mon31"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon32
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon32
            #add-point:ON ACTION controlp INFIELD mon32 name="input.c.mon32"
            
            #END add-point
 
 
         #Ctrlp:input.c.year4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year4
            #add-point:ON ACTION controlp INFIELD year4 name="input.c.year4"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon41
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon41
            #add-point:ON ACTION controlp INFIELD mon41 name="input.c.mon41"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon42
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon42
            #add-point:ON ACTION controlp INFIELD mon42 name="input.c.mon42"
            
            #END add-point
 
 
         #Ctrlp:input.c.year5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year5
            #add-point:ON ACTION controlp INFIELD year5 name="input.c.year5"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon51
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon51
            #add-point:ON ACTION controlp INFIELD mon51 name="input.c.mon51"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon52
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon52
            #add-point:ON ACTION controlp INFIELD mon52 name="input.c.mon52"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON mmafunit
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.mmafunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmafunit
            #add-point:ON ACTION controlp INFIELD mmafunit name="construct.c.mmafunit"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmafunit',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmafunit  #顯示到畫面上
            NEXT FIELD mmafunit                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmafunit
            #add-point:BEFORE FIELD mmafunit name="construct.b.mmafunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmafunit
            
            #add-point:AFTER FIELD mmafunit name="construct.a.mmafunit"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_rtab_wc ON rtab001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"

               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtab001
            #add-point:ON ACTION controlp INFIELD rtab001 name="construct.c.rtab001"
            #應用 a08 樣板自動產生(Version:3)
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
            
            
         END CONSTRUCT
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
            CALL acrr720_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr720_get_buffer(l_dialog)
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
         CALL acrr720_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      IF INT_FLAG = FALSE AND (cl_null(g_master.wc) OR g_master.wc = " 1=1") AND
         (cl_null(g_rtab_wc) OR g_rtab_wc = " 1=1") THEN
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
                 CALL acrr720_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr720_transfer_argv(ls_js)
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
 
{<section id="acrr720.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr720_transfer_argv(ls_js)
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
 
{<section id="acrr720.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr720_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"mmafunit")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr720_process_cs CURSOR FROM ls_sql
#  FOREACH acrr720_process_cs INTO
   #add-point:process段process name="process.process"
   CALL acrr720_sel_data()
   CALL acrr720_g01(g_master.wc,g_master.oocq002,g_master.type1)
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
 
{<section id="acrr720.get_buffer" >}
PRIVATE FUNCTION acrr720_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.oocq002 = p_dialog.getFieldBuffer('oocq002')
   LET g_master.type1 = p_dialog.getFieldBuffer('type1')
   LET g_master.year1 = p_dialog.getFieldBuffer('year1')
   LET g_master.mon11 = p_dialog.getFieldBuffer('mon11')
   LET g_master.mon12 = p_dialog.getFieldBuffer('mon12')
   LET g_master.year2 = p_dialog.getFieldBuffer('year2')
   LET g_master.mon21 = p_dialog.getFieldBuffer('mon21')
   LET g_master.mon22 = p_dialog.getFieldBuffer('mon22')
   LET g_master.year3 = p_dialog.getFieldBuffer('year3')
   LET g_master.mon31 = p_dialog.getFieldBuffer('mon31')
   LET g_master.mon32 = p_dialog.getFieldBuffer('mon32')
   LET g_master.year4 = p_dialog.getFieldBuffer('year4')
   LET g_master.mon41 = p_dialog.getFieldBuffer('mon41')
   LET g_master.mon42 = p_dialog.getFieldBuffer('mon42')
   LET g_master.year5 = p_dialog.getFieldBuffer('year5')
   LET g_master.mon51 = p_dialog.getFieldBuffer('mon51')
   LET g_master.mon52 = p_dialog.getFieldBuffer('mon52')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   IF cl_null(g_master.type1) THEN
      LET g_master.type1 = '1'
      CALL acrr720_set_comp_visible()
      CALL acrr720_set_comp_no_visible()
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr720.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 栏位显示
# Memo...........:
# Usage..........: CALL acrr720_set_comp_visible()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr720_set_comp_visible()

   CALL cl_set_comp_visible("year1,mon11,mon12",TRUE)
   CALL cl_set_comp_visible("year2,mon21,mon22",TRUE)
   CALL cl_set_comp_visible("year3,mon31,mon32",TRUE)
   CALL cl_set_comp_visible("year4,mon41,mon42",TRUE)
   CALL cl_set_comp_visible("year5,mon51,mon52",TRUE)

END FUNCTION

################################################################################
# Descriptions...: 栏位隐藏
# Memo...........:
# Usage..........: CALL acrr720_set_comp_no_visible()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr720_set_comp_no_visible()
DEFINE l_ooef008        LIKE ooef_t.ooef008
DEFINE l_ooef010        LIKE ooef_t.ooef010
DEFINE r_flag           LIKE type_t.chr1
DEFINE r_errno          LIKE type_t.chr100
DEFINE r_oogc015        LIKE oogc_t.oogc015
DEFINE r_oogc007        LIKE oogc_t.oogc007
DEFINE r_sdate_s        LIKE oogc_t.oogc003
DEFINE r_sdate_e        LIKE oogc_t.oogc003
DEFINE r_oogc006        LIKE oogc_t.oogc006
DEFINE r_pdate_s        LIKE oogc_t.oogc003
DEFINE r_pdate_e        LIKE oogc_t.oogc003
DEFINE r_oogc008        LIKE oogc_t.oogc008
DEFINE r_wdate_s        LIKE oogc_t.oogc003
DEFINE r_wdate_e        LIKE oogc_t.oogc003
DEFINE r_oogc015_1      LIKE oogc_t.oogc015
DEFINE r_oogc006_1      LIKE oogc_t.oogc006
DEFINE r_oogc015_2      LIKE oogc_t.oogc015
DEFINE r_oogc006_2      LIKE oogc_t.oogc006
DEFINE r_oogc015_3      LIKE oogc_t.oogc015
DEFINE r_oogc006_3      LIKE oogc_t.oogc006
DEFINE r_oogc015_4      LIKE oogc_t.oogc015
DEFINE r_oogc006_4      LIKE oogc_t.oogc006

   #取当前日期的年度/期别
   SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_get_oogcdate(l_ooef008,l_ooef010,g_today,'','')
      RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,
                r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
   LET r_oogc015_1 = r_oogc015
   LET r_oogc015_2 = r_oogc015
   LET r_oogc015_3 = r_oogc015
   LET r_oogc015_4 = r_oogc015
   LET r_oogc006_1 = r_oogc006 - 1
   LET r_oogc006_2 = r_oogc006 - 2
   LET r_oogc006_3 = r_oogc006 - 3
   LET r_oogc006_4 = r_oogc006 - 4
   IF r_oogc006 - 1 = 0 THEN
      #上一年度期别
      LET r_oogc015_1 = r_oogc015 - 1
      LET r_oogc006_1 = 12
      #上二年度期别
      LET r_oogc015_2 = r_oogc015_1
      LET r_oogc006_2 = r_oogc006_1 - 1
      #上三年度期别
      LET r_oogc015_3 = r_oogc015_1
      LET r_oogc006_3 = r_oogc006_1 - 2
      #上四年度期别
      LET r_oogc015_4 = r_oogc015_1
      LET r_oogc006_4 = r_oogc006_1 - 3
   END IF
   IF r_oogc006 - 2 = 0 THEN
      #上二年度期别
      LET r_oogc015_2 = r_oogc015 - 1
      LET r_oogc006_2 = 12
      #上三年度期别
      LET r_oogc015_3 = r_oogc015_2
      LET r_oogc006_3 = r_oogc006_2 - 1
      #上四年度期别
      LET r_oogc015_4 = r_oogc015_2
      LET r_oogc006_4 = r_oogc006_2 - 2
   END IF
   IF r_oogc006 - 3 = 0 THEN
      #上三年度期别
      LET r_oogc015_3 = r_oogc015 - 1
      LET r_oogc006_3 = 12
      #上四年度期别
      LET r_oogc015_4 = r_oogc015 - 1
      LET r_oogc006_4 = r_oogc006_3 - 1
   END IF
   IF r_oogc006 - 4 = 0 THEN
      #上四年度期别
      LET r_oogc015_4 = r_oogc015 - 1
      LET r_oogc006_4 = 12
   END IF

   IF g_master.type1 = '1' THEN
      CALL cl_set_comp_visible("year2,mon21,mon22",FALSE)
      CALL cl_set_comp_visible("year3,mon31,mon32",FALSE)
      CALL cl_set_comp_visible("year4,mon41,mon42",FALSE)
      CALL cl_set_comp_visible("year5,mon51,mon52",FALSE)
      
      LET g_master.year1 = r_oogc015
      LET g_master.mon11 = r_oogc006
      LET g_master.mon12 = r_oogc006
   END IF
   
   IF g_master.type1 = '2' THEN
      CALL cl_set_comp_visible("year3,mon31,mon32",FALSE)
      CALL cl_set_comp_visible("year4,mon41,mon42",FALSE)
      CALL cl_set_comp_visible("year5,mon51,mon52",FALSE)
      
      LET g_master.year2 = r_oogc015
      LET g_master.mon21 = r_oogc006
      LET g_master.mon22 = r_oogc006
      LET g_master.year1 = r_oogc015_1
      LET g_master.mon11 = r_oogc006_1
      LET g_master.mon12 = r_oogc006_1
   END IF
   
   IF g_master.type1 = '3' THEN
      CALL cl_set_comp_visible("year4,mon41,mon42",FALSE)
      CALL cl_set_comp_visible("year5,mon51,mon52",FALSE)
      
      LET g_master.year3 = r_oogc015
      LET g_master.mon31 = r_oogc006
      LET g_master.mon32 = r_oogc006
      LET g_master.year2 = r_oogc015_1
      LET g_master.mon21 = r_oogc006_1
      LET g_master.mon22 = r_oogc006_1
      LET g_master.year1 = r_oogc015_2
      LET g_master.mon11 = r_oogc006_2
      LET g_master.mon12 = r_oogc006_2
   END IF
   
   IF g_master.type1 = '4' THEN
      CALL cl_set_comp_visible("year5,mon51,mon52",FALSE)
      
      LET g_master.year4 = r_oogc015
      LET g_master.mon41 = r_oogc006
      LET g_master.mon42 = r_oogc006
      LET g_master.year3 = r_oogc015_1
      LET g_master.mon31 = r_oogc006_1
      LET g_master.mon32 = r_oogc006_1
      LET g_master.year2 = r_oogc015_2
      LET g_master.mon21 = r_oogc006_2
      LET g_master.mon22 = r_oogc006_2
      LET g_master.year1 = r_oogc015_3
      LET g_master.mon11 = r_oogc006_3
      LET g_master.mon12 = r_oogc006_3
   END IF
   
   IF g_master.type1 = '5' THEN
      LET g_master.year5 = r_oogc015
      LET g_master.mon51 = r_oogc006
      LET g_master.mon52 = r_oogc006
      LET g_master.year4 = r_oogc015_1
      LET g_master.mon41 = r_oogc006_1
      LET g_master.mon42 = r_oogc006_1
      LET g_master.year3 = r_oogc015_2
      LET g_master.mon31 = r_oogc006_2
      LET g_master.mon32 = r_oogc006_2
      LET g_master.year2 = r_oogc015_3
      LET g_master.mon21 = r_oogc006_3
      LET g_master.mon22 = r_oogc006_3
      LET g_master.year1 = r_oogc015_4
      LET g_master.mon11 = r_oogc006_4
      LET g_master.mon12 = r_oogc006_4
   END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL acrr720_sel_data()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/04/27 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr720_sel_data()
DEFINE l_oocq004        LIKE oocq_t.oocq004
DEFINE l_sql            STRING
DEFINE l_sql1           STRING
DEFINE l_sql2           STRING
DEFINE l_mmagent        LIKE mmag_t.mmagent
DEFINE l_mmag004        LIKE mmag_t.mmag004
DEFINE l_oocql004       LIKE oocql_t.oocql004
DEFINE l_year           LIKE type_t.chr4
DEFINE l_mon1           LIKE type_t.chr2
DEFINE l_mon2           LIKE type_t.chr2
DEFINE l_cnt1           LIKE type_t.num10
DEFINE l_cnt2           LIKE type_t.num10
DEFINE l_cnt3           LIKE type_t.num10
DEFINE l_cnt4           LIKE type_t.num10
DEFINE l_cnt5           LIKE type_t.num10
DEFINE l_where          STRING
   
   #确定哪一项会员属性
   LET l_oocq004 = ''
   SELECT oocq004 INTO l_oocq004
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = '2049'
      AND oocq002 = g_master.oocq002
      
   DELETE FROM acrr720_tmp;
   
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF
   IF cl_null(g_rtab_wc) THEN
      LET g_rtab_wc = " 1=1"
   END IF
   CALL s_aooi500_sql_where(g_prog,'mmafunit') RETURNING l_where
   LET g_master.wc = g_master.wc," AND ",l_where
   #抓取资料
   LET l_sql = " SELECT DISTINCT mmagent,mmag004,oocql004 ",
               "   FROM mmag_t,oocq_t LEFT JOIN oocql_t ON oocqlent = oocqent AND oocql001 = oocq001 ",
               "                            AND oocql002 = oocq002 AND oocql003 = '",g_dlang,"' ",
               "  WHERE mmagent = ",g_enterprise," ",
               "    AND mmagent = oocqent ",
               "    AND mmag002 = '",g_master.oocq002,"' ",
               "    AND mmag003 = oocq001 ",
               "    AND oocq001 = '",l_oocq004,"' ",
               "    AND oocq002 = mmag004 ",
               "  ORDER BY mmag004 "
   PREPARE sel_data_pre FROM l_sql
   DECLARE sel_data_cs  CURSOR FOR sel_data_pre
   FOREACH sel_data_cs  INTO l_mmagent,l_mmag004,l_oocql004
      LET l_cnt1 = 0
      LET l_cnt2 = 0
      LET l_cnt3 = 0
      LET l_cnt4 = 0
      LET l_cnt5 = 0
      LET l_sql1 = " SELECT COUNT(DISTINCT mmaf001) FROM mmaf_t,mmag_t,rtab_t,rtaa_t,rtak_t ",
                   "  WHERE mmafent = mmagent AND mmafent = ",g_enterprise," ",
                   "    AND mmaf001 = mmag001 ",
                   "    AND mmag002 = '",g_master.oocq002,"' ",
                   "    AND mmag003 = '",l_oocq004,"' ",
                   "    AND mmag004 = '",l_mmag004,"' ",
                   "    AND mmafent = rtabent AND rtabent = rtaaent ",
                   "    AND rtabent = rtakent AND rtab001 = rtak001 ",
                   "    AND rtaa001 = rtab001 ",
                   "    AND ",g_master.wc
      IF g_rtab_wc <> " 1=1" THEN
         LET l_sql1 = l_sql1," AND rtab002 = mmafunit AND rtak002 = '1' AND rtak003 = 'Y' AND ",g_rtab_wc
      END IF
      #第一期
      LET l_year = g_master.year1
      IF g_master.mon11 < 10 THEN
         LET l_mon1 = "0",g_master.mon11
      ELSE
         LET l_mon1 = g_master.mon11
      END IF
      IF g_master.mon12 < 10 THEN
         LET l_mon2 = "0",g_master.mon12
      ELSE
         LET l_mon2 = g_master.mon12
      END IF
      LET l_sql2 = l_sql1,"    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),1,4) = '",l_year,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) >= '",l_mon1,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) <= '",l_mon2,"' "
      PREPARE sel_cnt1_pre FROM l_sql2
      EXECUTE sel_cnt1_pre INTO l_cnt1
      
      #第二期
      LET l_year = g_master.year2
      IF g_master.mon21 < 10 THEN
         LET l_mon1 = "0",g_master.mon21
      ELSE
         LET l_mon1 = g_master.mon21
      END IF
      IF g_master.mon22 < 10 THEN
         LET l_mon2 = "0",g_master.mon22
      ELSE
         LET l_mon2 = g_master.mon22
      END IF
      LET l_sql2 = l_sql1,"    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),1,4) = '",l_year,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) >= '",l_mon1,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) <= '",l_mon2,"' "
      PREPARE sel_cnt2_pre FROM l_sql2
      EXECUTE sel_cnt2_pre INTO l_cnt2
      
      #第三期
      LET l_year = g_master.year3
      IF g_master.mon31 < 10 THEN
         LET l_mon1 = "0",g_master.mon31
      ELSE
         LET l_mon1 = g_master.mon31
      END IF
      IF g_master.mon32 < 10 THEN
         LET l_mon2 = "0",g_master.mon32
      ELSE
         LET l_mon2 = g_master.mon32
      END IF
      LET l_sql2 = l_sql1,"    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),1,4) = '",l_year,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) >= '",l_mon1,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) <= '",l_mon2,"' "
      PREPARE sel_cnt3_pre FROM l_sql2
      EXECUTE sel_cnt3_pre INTO l_cnt3
      
      #第四期
      LET l_year = g_master.year4
      IF g_master.mon41 < 10 THEN
         LET l_mon1 = "0",g_master.mon41
      ELSE
         LET l_mon1 = g_master.mon41
      END IF
      IF g_master.mon42 < 10 THEN
         LET l_mon2 = "0",g_master.mon42
      ELSE
         LET l_mon2 = g_master.mon42
      END IF
      LET l_sql2 = l_sql1,"    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),1,4) = '",l_year,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) >= '",l_mon1,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) <= '",l_mon2,"' "
      PREPARE sel_cnt4_pre FROM l_sql2
      EXECUTE sel_cnt4_pre INTO l_cnt4
      
      #第五期
      LET l_year = g_master.year5
      IF g_master.mon51 < 10 THEN
         LET l_mon1 = "0",g_master.mon51
      ELSE
         LET l_mon1 = g_master.mon51
      END IF
      IF g_master.mon52 < 10 THEN
         LET l_mon2 = "0",g_master.mon52
      ELSE
         LET l_mon2 = g_master.mon52
      END IF
      LET l_sql2 = l_sql1,"    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),1,4) = '",l_year,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) >= '",l_mon1,"' ",
                          "    AND substr(to_char(mmafcnfdt,'YYYYMMDD'),5,2) <= '",l_mon2,"' "
      PREPARE sel_cnt5_pre FROM l_sql2
      EXECUTE sel_cnt5_pre INTO l_cnt5
      
      #写入临时表
      INSERT INTO acrr720_tmp (mmagent,mmag004,oocql004,l_cnt1,l_cnt2,l_cnt3,l_cnt4,l_cnt5,year1,mon11,mon12,
                               year2,mon21,mon22,year3,mon31,mon32,year4,mon41,mon42,year5,mon51,mon52)
      VALUES (l_mmagent,l_mmag004,l_oocql004,l_cnt1,l_cnt2,l_cnt3,l_cnt4,l_cnt5,g_master.year1,g_master.mon11,g_master.mon12,
              g_master.year2,g_master.mon21,g_master.mon22,g_master.year3,g_master.mon31,g_master.mon32,
              g_master.year4,g_master.mon41,g_master.mon42,g_master.year5,g_master.mon51,g_master.mon52)
      
      LET l_mmagent = ''
      LET l_mmag004 = ''
      LET l_oocql004 = ''
   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 临时表处理
# Memo...........:
# Usage..........: CALL acrr720_temp_process(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/04/28 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr720_temp_process(p_type)
DEFINE p_type      LIKE type_t.chr1
 
   CASE p_type
      WHEN '1'
         #建立临时表
         DROP TABLE acrr720_tmp;
         CREATE TEMP TABLE acrr720_tmp(
         mmagent      LIKE mmag_t.mmagent,
         mmag004      LIKE mmag_t.mmag004,
         oocql004     LIKE oocql_t.oocql004,
         l_cnt1       LIKE type_t.num20,
         l_cnt2       LIKE type_t.num20,
         l_cnt3       LIKE type_t.num20,
         l_cnt4       LIKE type_t.num20,
         l_cnt5       LIKE type_t.num20,
         year1        LIKE type_t.num5,    #一期年度
         mon11        LIKE type_t.num5,    #一期期别
         mon12        LIKE type_t.num5,    #一期期别
         year2        LIKE type_t.num5,    #二期年度
         mon21        LIKE type_t.num5,    #二期期别
         mon22        LIKE type_t.num5,    #二期期别
         year3        LIKE type_t.num5,    #三期年度
         mon31        LIKE type_t.num5,    #三期期别
         mon32        LIKE type_t.num5,    #三期期别
         year4        LIKE type_t.num5,    #四期年度
         mon41        LIKE type_t.num5,    #四期期别
         mon42        LIKE type_t.num5,    #四期期别
         year5        LIKE type_t.num5,    #五期年度
         mon51        LIKE type_t.num5,    #五期期别
         mon52        LIKE type_t.num5     #五期期别
         );
         
      WHEN '2'
         #删除临时表
         DROP TABLE acrr720_tmp;
         
   END CASE

END FUNCTION

#end add-point
 
{</section>}
 
