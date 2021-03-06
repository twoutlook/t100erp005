#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp610.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-11-28 09:50:25), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp610
#+ Description: 產生費用預算作業
#+ Creator....: 02114(2016-11-28 09:50:25)
#+ Modifier...: 02114 -SD/PR- 00000
 
{</section>}
 
{<section id="abgp610.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161215-00051#3   2016/12/16  By 02114    预算细项存在有期别没资料的情况,要把资料补上,金额给0
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
       bgfb002 LIKE bgfb_t.bgfb002, 
   bgfb002_desc LIKE type_t.chr80, 
   bgaa002 LIKE type_t.chr10, 
   bgfb003 LIKE bgfb_t.bgfb003, 
   bgaa003 LIKE type_t.chr10, 
   bgfb007 LIKE bgfb_t.bgfb007, 
   bgfb007_desc LIKE type_t.chr80, 
   bgaa008 LIKE type_t.chr5, 
   a LIKE type_t.chr500, 
   a1 LIKE type_t.chr500, 
   b LIKE type_t.chr500, 
   b1 LIKE type_t.chr500, 
   bgae008 LIKE type_t.chr10, 
   bgae001 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp610.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abgp610_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp610 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp610_init()
 
      #進入選單 Menu (="N")
      CALL abgp610_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp610
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE abgp610_tmp01;
   DROP TABLE abgp610_tmp02;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp610.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp610_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success           LIKE type_t.num5
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
   CALL s_fin_create_account_center_tmp()
   CALL abgp610_create_tmp() RETURNING l_success
   CALL cl_set_combo_scc('bgae008','9418')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp610.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp610_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_site_str      STRING
   DEFINE l_bgac004_max   LIKE bgac_t.bgac004
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.a  = '1'
   LET g_master.a1 = 0
   LET g_master.b  = ''
   LET g_master.b1 = ''
   CALL cl_set_comp_entry("a1",TRUE)
   CALL cl_set_comp_entry("b1",FALSE)
   DISPLAY g_master.b,g_master.b1 TO b,b1
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgfb002,g_master.bgaa002,g_master.bgfb003,g_master.bgaa003,g_master.bgfb007, 
             g_master.bgaa008,g_master.a,g_master.a1,g_master.b,g_master.b1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb002
            
            #add-point:AFTER FIELD bgfb002 name="input.a.bgfb002"
            IF NOT cl_null(g_master.bgfb002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgfb002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理
                  SELECT bgaa002,bgaa003,bgaa008 INTO g_master.bgaa002,g_master.bgaa003,g_master.bgaa008
                    FROM bgaa_t
                   WHERE bgaaent = g_enterprise
                     AND bgaa001 = g_master.bgfb002
                  
                  DISPLAY g_master.bgaa002,g_master.bgaa003,g_master.bgaa008 TO bgaa002,bgaa003,bgaa008
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.bgfb002 = ''
                  CALL abgp610_bgfb002_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgp610_bgfb002_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb002
            #add-point:BEFORE FIELD bgfb002 name="input.b.bgfb002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb002
            #add-point:ON CHANGE bgfb002 name="input.g.bgfb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa002
            #add-point:BEFORE FIELD bgaa002 name="input.b.bgaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa002
            
            #add-point:AFTER FIELD bgaa002 name="input.a.bgaa002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa002
            #add-point:ON CHANGE bgaa002 name="input.g.bgaa002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb003
            #add-point:BEFORE FIELD bgfb003 name="input.b.bgfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb003
            
            #add-point:AFTER FIELD bgfb003 name="input.a.bgfb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb003
            #add-point:ON CHANGE bgfb003 name="input.g.bgfb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa003
            #add-point:BEFORE FIELD bgaa003 name="input.b.bgaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa003
            
            #add-point:AFTER FIELD bgaa003 name="input.a.bgaa003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa003
            #add-point:ON CHANGE bgaa003 name="input.g.bgaa003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgfb007
            
            #add-point:AFTER FIELD bgfb007 name="input.a.bgfb007"
            IF NOT cl_null(g_master.bgfb007) THEN 
#應用 a19 樣板自動產生(Version:2)
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgfb007
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_24") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                  CALL s_abg2_get_budget_site(g_master.bgfb002,'',g_user,'02') RETURNING l_site_str
                  IF cl_null(l_site_str) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00248'
                     LET g_errparam.extend = g_master.bgfb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgfb007 = ''
                     CALL s_desc_get_department_desc(g_master.bgfb007) RETURNING g_master.bgfb007_desc
                     DISPLAY BY NAME g_master.bgfb007_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #檢查預算組織是否在abgi090中可操作的組織中
                  IF s_chr_get_index_of(l_site_str,g_master.bgfb007,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'abg-00247'
                     LET g_errparam.extend = g_master.bgfb007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgfb007 = ''
                     CALL s_desc_get_department_desc(g_master.bgfb007) RETURNING g_master.bgfb007_desc
                     DISPLAY BY NAME g_master.bgfb007_desc
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.bgfb007 = ''
                  CALL s_desc_get_department_desc(g_master.bgfb007) RETURNING g_master.bgfb007_desc
                  DISPLAY BY NAME g_master.bgfb007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL s_desc_get_department_desc(g_master.bgfb007) RETURNING g_master.bgfb007_desc
            DISPLAY BY NAME g_master.bgfb007_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgfb007
            #add-point:BEFORE FIELD bgfb007 name="input.b.bgfb007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgfb007
            #add-point:ON CHANGE bgfb007 name="input.g.bgfb007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaa008
            #add-point:BEFORE FIELD bgaa008 name="input.b.bgaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaa008
            
            #add-point:AFTER FIELD bgaa008 name="input.a.bgaa008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaa008
            #add-point:ON CHANGE bgaa008 name="input.g.bgaa008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="input.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="input.a.a"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a
            #add-point:ON CHANGE a name="input.g.a"
            IF g_master.a = '1' THEN 
               LET g_master.a1 = 0
               LET g_master.b = ''
               LET g_master.b1 = ''
               CALL cl_set_comp_entry("a1",TRUE)
               CALL cl_set_comp_entry("b1",FALSE)
               DISPLAY g_master.b,g_master.b1 TO b,b1
            ELSE
               LET g_master.a = ''
               LET g_master.a1 = ''
               LET g_master.a1 = ''
               LET g_master.b = '1'
               CALL cl_set_comp_entry("a1",FALSE)
               CALL cl_set_comp_entry("b1",TRUE)
               DISPLAY g_master.a,g_master.a1,g_master.b TO a,a1,b
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a1
            #add-point:BEFORE FIELD a1 name="input.b.a1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a1
            
            #add-point:AFTER FIELD a1 name="input.a.a1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE a1
            #add-point:ON CHANGE a1 name="input.g.a1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="input.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="input.a.b"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b
            #add-point:ON CHANGE b name="input.g.b"
            IF g_master.b = '1' THEN 
               LET g_master.a = ''
               LET g_master.a1 = ''
               LET g_master.a1 = ''
               CALL cl_set_comp_entry("a1",FALSE)
               CALL cl_set_comp_entry("b1",TRUE)
               DISPLAY g_master.a,g_master.a1 TO a,a1
            ELSE
               LET g_master.b = ''
               LET g_master.b1 = ''
               LET g_master.a = '1'
               LET g_master.a1 = 0
               CALL cl_set_comp_entry("a1",TRUE)
               CALL cl_set_comp_entry("b1",FALSE)
               DISPLAY g_master.a,g_master.b,g_master.b1 TO a,b,b1
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b1
            #add-point:BEFORE FIELD b1 name="input.b.b1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b1
            
            #add-point:AFTER FIELD b1 name="input.a.b1"
            IF NOT cl_null(g_master.b1) THEN 
               #抓取最大期别
               SELECT MAX(bgac004) INTO l_bgac004_max
                 FROM bgac_t
                WHERE bgacent = g_enterprise
                  AND bgac001 = g_master.bgaa002
                  
               IF NOT cl_null(l_bgac004_max) THEN 
                  IF g_master.b1 > l_bgac004_max THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'abg-00267' 
                     LET g_errparam.replace[1] = l_bgac004_max
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
               IF g_master.b1 < 1 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'abg-00266' 
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b1
            #add-point:ON CHANGE b1 name="input.g.b1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb002
            #add-point:ON ACTION controlp INFIELD bgfb002 name="input.c.bgfb002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgfb002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_master.bgfb002 = g_qryparam.return1              
            CALL abgp610_bgfb002_desc()
            DISPLAY g_master.bgfb002 TO bgfb002              #

            NEXT FIELD bgfb002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bgaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa002
            #add-point:ON ACTION controlp INFIELD bgaa002 name="input.c.bgaa002"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb003
            #add-point:ON ACTION controlp INFIELD bgfb003 name="input.c.bgfb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgaa003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa003
            #add-point:ON ACTION controlp INFIELD bgaa003 name="input.c.bgaa003"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgfb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgfb007
            #add-point:ON ACTION controlp INFIELD bgfb007 name="input.c.bgfb007"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgfb007             #給予default值
            
            #檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_master.bgfb002,'',g_user,'02') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            IF NOT cl_null(g_qryparam.where) THEN
               LET g_qryparam.where = g_qryparam.where,
                                      " AND ooef001 IN ",l_site_str
            ELSE
               LET g_qryparam.where = " ooef001 IN ",l_site_str
            END IF
            
            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooef001_77()                                #呼叫開窗
 
            LET g_master.bgfb007 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_master.bgfb007) RETURNING g_master.bgfb007_desc
            DISPLAY g_master.bgfb007_desc TO bgfb007_desc
            DISPLAY g_master.bgfb007 TO bgfb007              #

            NEXT FIELD bgfb007                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.bgaa008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaa008
            #add-point:ON ACTION controlp INFIELD bgaa008 name="input.c.bgaa008"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.a1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a1
            #add-point:ON ACTION controlp INFIELD a1 name="input.c.a1"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.b1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b1
            #add-point:ON ACTION controlp INFIELD b1 name="input.c.b1"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgae008,bgae001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD a
            #add-point:BEFORE FIELD a name="construct.b.a"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD a
            
            #add-point:AFTER FIELD a name="construct.a.a"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="construct.c.a"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b
            #add-point:BEFORE FIELD b name="construct.b.b"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b
            
            #add-point:AFTER FIELD b name="construct.a.b"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="construct.c.b"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae008
            #add-point:BEFORE FIELD bgae008 name="construct.b.bgae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae008
            
            #add-point:AFTER FIELD bgae008 name="construct.a.bgae008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bgae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae008
            #add-point:ON ACTION controlp INFIELD bgae008 name="construct.c.bgae008"
            
            #END add-point
 
 
         #Ctrlp:construct.c.bgae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgae001
            #add-point:ON ACTION controlp INFIELD bgae001 name="construct.c.bgae001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgae006 = '",g_master.bgaa008,"'"
            CALL q_bgae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgae001  #顯示到畫面上
            NEXT FIELD bgae001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgae001
            #add-point:BEFORE FIELD bgae001 name="construct.b.bgae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgae001
            
            #add-point:AFTER FIELD bgae001 name="construct.a.bgae001"
            
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
            CALL abgp610_get_buffer(l_dialog)
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
         CALL abgp610_init()
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
                 CALL abgp610_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp610_transfer_argv(ls_js)
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
 
{<section id="abgp610.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp610_transfer_argv(ls_js)
 
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
 
{<section id="abgp610.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp610_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_flag        LIKE type_t.chr1
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp610_process_cs CURSOR FROM ls_sql
#  FOREACH abgp610_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      CALL abgp610_p() RETURNING l_success,l_flag
      
      IF l_success = TRUE THEN 
         IF l_flag = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.code   = 'axc-00530' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')  
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_transaction_begin()
      CALL cl_err_collect_init()
      
      CALL abgp610_p() RETURNING l_success,l_flag
      
      IF l_success = TRUE THEN 
         IF l_flag = 'N' THEN 
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ""
            LET g_errparam.code   = 'axc-00530' 
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')  
         ELSE
            CALL s_transaction_end('Y','1')
         END IF
      ELSE
         CALL s_transaction_end('N','1')
      END IF
      
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL abgp610_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp610.get_buffer" >}
PRIVATE FUNCTION abgp610_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgfb002 = p_dialog.getFieldBuffer('bgfb002')
   LET g_master.bgaa002 = p_dialog.getFieldBuffer('bgaa002')
   LET g_master.bgfb003 = p_dialog.getFieldBuffer('bgfb003')
   LET g_master.bgaa003 = p_dialog.getFieldBuffer('bgaa003')
   LET g_master.bgfb007 = p_dialog.getFieldBuffer('bgfb007')
   LET g_master.bgaa008 = p_dialog.getFieldBuffer('bgaa008')
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.a1 = p_dialog.getFieldBuffer('a1')
   LET g_master.b = p_dialog.getFieldBuffer('b')
   LET g_master.b1 = p_dialog.getFieldBuffer('b1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp610.msgcentre_notify" >}
PRIVATE FUNCTION abgp610_msgcentre_notify()
 
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
 
{<section id="abgp610.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 預算編號說明
PRIVATE FUNCTION abgp610_bgfb002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.bgfb002
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.bgfb002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.bgfb002_desc
END FUNCTION
# 批处理逻辑
PRIVATE FUNCTION abgp610_p()
   DEFINE l_sql              STRING
   DEFINE l_comp             LIKE ooef_t.ooef017
   DEFINE l_glaald           LIKE glaa_t.glaald
   DEFINE l_glaa003          LIKE glaa_t.glaa003
   DEFINE l_glaa004          LIKE glaa_t.glaa004
   DEFINE l_bgam004          LIKE bgam_t.bgam004
   DEFINE l_year             LIKE bgam_t.bgam004
   DEFINE l_month            LIKE bgam_t.bgam006
   DEFINE l_bgfb007          LIKE bgfb_t.bgfb007
   DEFINE l_glav006_max      LIKE glav_t.glav006
   DEFINE l_bgae001          LIKE bgae_t.bgae001
   DEFINE l_bgae002          LIKE bgae_t.bgae002
   DEFINE l_ld               LIKE glaa_t.glaald
   DEFINE l_glaa001          LIKE glaa_t.glaa001
   DEFINE l_amt1             LIKE glaq_t.glaq003
   DEFINE l_amt2             LIKE glaq_t.glaq003
   DEFINE l_glaq003_ce       LIKE glaq_t.glaq003
   DEFINE l_glaq004_ce       LIKE glaq_t.glaq004
   DEFINE l_bgai002          LIKE bgai_t.bgai002
   DEFINE l_bgai008          LIKE bgai_t.bgai008
   DEFINE l_bgae008          LIKE bgae_t.bgae008
   DEFINE l_bgaa010          LIKE bgaa_t.bgaa010
   DEFINE l_bgaa011          LIKE bgaa_t.bgaa011
   DEFINE l_bgaa003          LIKE bgaa_t.bgaa003
   DEFINE l_ooed005          LIKE ooed_t.ooed005
   DEFINE l_ooef019          LIKE ooef_t.ooef019
   DEFINE l_oodb002          LIKE oodb_t.oodb002
   DEFINE l_oodb005          LIKE oodb_t.oodb005
   DEFINE l_i                LIKE type_t.num5     #161215-00051#3 add lujh
   DEFINE l_n                LIKE type_t.num5
   DEFINE l_bgfbstus         LIKE bgfb_t.bgfbstus
   DEFINE l_message          STRING
   DEFINE l_str              STRING
   DEFINE l_site_str         STRING
   DEFINE l_field            DYNAMIC ARRAY OF RECORD
                              f1       LIKE type_t.chr1000
                             END RECORD 
   DEFINE l_tmp              RECORD
                             glarld               LIKE glar_t.glarld,
                             glar002              LIKE glar_t.glar002,
                             glar003              LIKE glar_t.glar003,
                             glar005              LIKE glar_t.glar005,
                             glar006              LIKE glar_t.glar006,
                             glar013              LIKE glar_t.glar013,
                             glar014              LIKE glar_t.glar014,
                             glar015              LIKE glar_t.glar015,
                             glar016              LIKE glar_t.glar016,
                             glar017              LIKE glar_t.glar017,
                             glar018              LIKE glar_t.glar018,
                             glar019              LIKE glar_t.glar019,
                             glar020              LIKE glar_t.glar020,
                             glar022              LIKE glar_t.glar022,
                             glar023              LIKE glar_t.glar023,
                             glar051              LIKE glar_t.glar051,
                             glar052              LIKE glar_t.glar052,
                             glar053              LIKE glar_t.glar053,
                             amt                  LIKE glar_t.glar005,
                             bgae001              LIKE bgae_t.bgae001
                             END RECORD
   DEFINE l_tmp1             RECORD
                             bgae001              LIKE bgae_t.bgae001,
                             glar003              LIKE glar_t.glar003,
                             glar013              LIKE glar_t.glar013,
                             glar014              LIKE glar_t.glar014,
                             glar015              LIKE glar_t.glar015,
                             glar016              LIKE glar_t.glar016,
                             glar017              LIKE glar_t.glar017,
                             glar018              LIKE glar_t.glar018,
                             glar019              LIKE glar_t.glar019,
                             glar020              LIKE glar_t.glar020,
                             glar022              LIKE glar_t.glar022,
                             glar023              LIKE glar_t.glar023,
                             glar051              LIKE glar_t.glar051,
                             glar052              LIKE glar_t.glar052,
                             glar053              LIKE glar_t.glar053,
                             amt                  LIKE glar_t.glar005
                             END RECORD
   DEFINE l_bgfb             RECORD  #費用預算主檔
                             bgfbent              LIKE bgfb_t.bgfbent, #企業編號
                             bgfb001              LIKE bgfb_t.bgfb001, #來源作業
                             bgfb002              LIKE bgfb_t.bgfb002, #預算編號
                             bgfb003              LIKE bgfb_t.bgfb003, #版本
                             bgfb004              LIKE bgfb_t.bgfb004, #管理組織
                             bgfb005              LIKE bgfb_t.bgfb005, #費用來源
                             bgfb006              LIKE bgfb_t.bgfb006, #資料類型
                             bgfb007              LIKE bgfb_t.bgfb007, #預算組織
                             bgfb008              LIKE bgfb_t.bgfb008, #預算期別
                             bgfb009              LIKE bgfb_t.bgfb009, #預算細項
                             bgfb010              LIKE bgfb_t.bgfb010, #組合KEY
                             bgfbseq              LIKE bgfb_t.bgfbseq, #項次
                             bgfb011              LIKE bgfb_t.bgfb011, #預算樣表
                             bgfb012              LIKE bgfb_t.bgfb012, #人員
                             bgfb013              LIKE bgfb_t.bgfb013, #部門
                             bgfb014              LIKE bgfb_t.bgfb014, #成本利潤中心
                             bgfb015              LIKE bgfb_t.bgfb015, #區域
                             bgfb016              LIKE bgfb_t.bgfb016, #收付款客商
                             bgfb017              LIKE bgfb_t.bgfb017, #帳款客商
                             bgfb018              LIKE bgfb_t.bgfb018, #客群
                             bgfb019              LIKE bgfb_t.bgfb019, #產品類別
                             bgfb020              LIKE bgfb_t.bgfb020, #專案編號
                             bgfb021              LIKE bgfb_t.bgfb021, #WBS
                             bgfb022              LIKE bgfb_t.bgfb022, #經營方式
                             bgfb023              LIKE bgfb_t.bgfb023, #通路
                             bgfb024              LIKE bgfb_t.bgfb024, #品牌
                             bgfb025              LIKE bgfb_t.bgfb025, #自由核算項一
                             bgfb026              LIKE bgfb_t.bgfb026, #自由核算項二
                             bgfb027              LIKE bgfb_t.bgfb027, #自由核算項三
                             bgfb028              LIKE bgfb_t.bgfb028, #自由核算項四
                             bgfb029              LIKE bgfb_t.bgfb029, #自由核算項五
                             bgfb030              LIKE bgfb_t.bgfb030, #自由核算項六
                             bgfb031              LIKE bgfb_t.bgfb031, #自由核算項七
                             bgfb032              LIKE bgfb_t.bgfb032, #自由核算項八
                             bgfb033              LIKE bgfb_t.bgfb033, #自由核算項九
                             bgfb034              LIKE bgfb_t.bgfb034, #自由核算項十
                             bgfb035              LIKE bgfb_t.bgfb035, #稅別
                             bgfb036              LIKE bgfb_t.bgfb036, #含稅否
                             bgfb037              LIKE bgfb_t.bgfb037, #原幣費用金額
                             bgfb038              LIKE bgfb_t.bgfb038, #本層調整金額
                             bgfb039              LIKE bgfb_t.bgfb039, #上層調整金額
                             bgfb047              LIKE bgfb_t.bgfb047, #上層組織
                             bgfb048              LIKE bgfb_t.bgfb048, #憑證單號
                             bgfb100              LIKE bgfb_t.bgfb100, #交易幣別
                             bgfb101              LIKE bgfb_t.bgfb101, #匯率
                             bgfb102              LIKE bgfb_t.bgfb102, #核准原幣費用金額
                             bgfb103              LIKE bgfb_t.bgfb103, #核准原幣未稅金額
                             bgfb104              LIKE bgfb_t.bgfb104, #核准原幣稅額
                             bgfb105              LIKE bgfb_t.bgfb105, #核准原幣含稅金額
                             bgfbstus             LIKE bgfb_t.bgfbstus, #狀態碼
                             bgfbownid            LIKE bgfb_t.bgfbownid, #資料所有者
                             bgfbowndp            LIKE bgfb_t.bgfbowndp, #資料所屬部門
                             bgfbcrtid            LIKE bgfb_t.bgfbcrtid, #資料建立者
                             bgfbcrtdp            LIKE bgfb_t.bgfbcrtdp, #資料建立部門
                             bgfbcrtdt            LIKE bgfb_t.bgfbcrtdt, #資料創建日
                             bgfbmodid            LIKE bgfb_t.bgfbmodid, #資料修改者
                             bgfbmoddt            LIKE bgfb_t.bgfbmoddt, #最近修改日
                             bgfbcnfid            LIKE bgfb_t.bgfbcnfid, #資料確認者
                             bgfbcnfdt            LIKE bgfb_t.bgfbcnfdt, #資料確認日
                             bgfbud001            LIKE bgfb_t.bgfbud001, #自定義欄位(文字)001
                             bgfbud002            LIKE bgfb_t.bgfbud002, #自定義欄位(文字)002
                             bgfbud003            LIKE bgfb_t.bgfbud003, #自定義欄位(文字)003
                             bgfbud004            LIKE bgfb_t.bgfbud004, #自定義欄位(文字)004
                             bgfbud005            LIKE bgfb_t.bgfbud005, #自定義欄位(文字)005
                             bgfbud006            LIKE bgfb_t.bgfbud006, #自定義欄位(文字)006
                             bgfbud007            LIKE bgfb_t.bgfbud007, #自定義欄位(文字)007
                             bgfbud008            LIKE bgfb_t.bgfbud008, #自定義欄位(文字)008
                             bgfbud009            LIKE bgfb_t.bgfbud009, #自定義欄位(文字)009
                             bgfbud010            LIKE bgfb_t.bgfbud010, #自定義欄位(文字)010
                             bgfbud011            LIKE bgfb_t.bgfbud011, #自定義欄位(數字)011
                             bgfbud012            LIKE bgfb_t.bgfbud012, #自定義欄位(數字)012
                             bgfbud013            LIKE bgfb_t.bgfbud013, #自定義欄位(數字)013
                             bgfbud014            LIKE bgfb_t.bgfbud014, #自定義欄位(數字)014
                             bgfbud015            LIKE bgfb_t.bgfbud015, #自定義欄位(數字)015
                             bgfbud016            LIKE bgfb_t.bgfbud016, #自定義欄位(數字)016
                             bgfbud017            LIKE bgfb_t.bgfbud017, #自定義欄位(數字)017
                             bgfbud018            LIKE bgfb_t.bgfbud018, #自定義欄位(數字)018
                             bgfbud019            LIKE bgfb_t.bgfbud019, #自定義欄位(數字)019
                             bgfbud020            LIKE bgfb_t.bgfbud020, #自定義欄位(數字)020
                             bgfbud021            LIKE bgfb_t.bgfbud021, #自定義欄位(日期時間)021
                             bgfbud022            LIKE bgfb_t.bgfbud022, #自定義欄位(日期時間)022
                             bgfbud023            LIKE bgfb_t.bgfbud023, #自定義欄位(日期時間)023
                             bgfbud024            LIKE bgfb_t.bgfbud024, #自定義欄位(日期時間)024
                             bgfbud025            LIKE bgfb_t.bgfbud025, #自定義欄位(日期時間)025
                             bgfbud026            LIKE bgfb_t.bgfbud026, #自定義欄位(日期時間)026
                             bgfbud027            LIKE bgfb_t.bgfbud027, #自定義欄位(日期時間)027
                             bgfbud028            LIKE bgfb_t.bgfbud028, #自定義欄位(日期時間)028
                             bgfbud029            LIKE bgfb_t.bgfbud029, #自定義欄位(日期時間)029
                             bgfbud030            LIKE bgfb_t.bgfbud030  #自定義欄位(日期時間)030
                             END RECORD
   #161215-00051#3--add--str--lujh
   DEFINE l_bgfb1            RECORD  #費用預算主檔
                             bgfb001              LIKE bgfb_t.bgfb001, #來源作業
                             bgfb002              LIKE bgfb_t.bgfb002, #預算編號
                             bgfb003              LIKE bgfb_t.bgfb003, #版本
                             bgfb004              LIKE bgfb_t.bgfb004, #管理組織
                             bgfb005              LIKE bgfb_t.bgfb005, #費用來源
                             bgfb006              LIKE bgfb_t.bgfb006, #資料類型
                             bgfb007              LIKE bgfb_t.bgfb007, #預算組織
                             bgfb009              LIKE bgfb_t.bgfb009, #預算細項
                             bgfb010              LIKE bgfb_t.bgfb010, #組合KEY
                             bgfbseq              LIKE bgfb_t.bgfbseq  #項次
                             END RECORD
   #161215-00051#3--add--end--lujh
   DEFINE l_success          LIKE type_t.num5
   DEFINE r_flag             LIKE type_t.chr1
   DEFINE r_success          LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_flag = 'N'
   LET l_success = TRUE
   
   DELETE FROM abgp610_tmp03;    #161215-00051#3 add lujh
   
   IF cl_null(g_master.wc) THEN 
      LET g_master.wc = " 1=1 "
   END IF
   
   #预算组织对应法人
   SELECT ooef017 INTO l_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.bgfb007
   
   #预算组织对应法人的主账套/会计周期参照表/会计科目参照表   
   SELECT glaald,glaa003,glaa004 INTO l_glaald,l_glaa003,l_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaacomp = l_comp
      AND glaa014 = 'Y'
   
   #abgi120抓取会计年度
   SELECT bgam004 INTO l_bgam004
     FROM bgam_t
    WHERE bgament = g_enterprise
      AND bgam001 = g_master.bgaa002
      AND bgam002 = l_glaa003
      
   IF cl_null(l_bgam004) OR l_bgam004 = 0 THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_master.bgaa002
      LET g_errparam.code   = 'abg-00263'
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      
      RETURN r_success,r_flag
   END IF
   
   LET l_year = l_bgam004 - 1
   
   #抓取最大期别
   SELECT max(glav006) INTO l_glav006_max
     FROM glav_t
    WHERE glavent = g_enterprise
      AND glav001 = l_glaa003
      AND glav002 = l_year
      
   #abgi010预算组织版本/最上层组织/预算币别
   LET l_bgaa010 = ''     LET l_bgaa011 = ''
   LET l_bgaa003 = ''
   SELECT bgaa010,bgaa011,bgaa003 INTO l_bgaa010,l_bgaa011,l_bgaa003
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgfb002
      
   #展组织树
   CALL s_abg2_get_site(g_master.bgfb002,g_master.bgfb007,'04') RETURNING l_site_str
   
   #抓取組織
   LET l_sql = "SELECT ooef001 FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND (ooef001 = '",g_master.bgfb007,"'",
               "    OR ooef001 IN ",l_site_str,")"
   PREPARE abgp610_p_pre FROM l_sql
   DECLARE abgp610_p_cs CURSOR FOR abgp610_p_pre  
   
   #abgi040抓取预算细项/借贷方向
   LET l_sql = "SELECT DISTINCT bgae001,bgae002 FROM bgae_t ",
               " WHERE bgaeent = ",g_enterprise,
               "   AND bgae003 = '6' ",
               "   AND bgae006 = '",g_master.bgaa008,"'",
               "   AND ",g_master.wc
   PREPARE abgp610_p_pre1 FROM l_sql
   DECLARE abgp610_p_cs1 CURSOR FOR abgp610_p_pre1 
   
   #abgi140抓取科目   
   LET l_sql = "SELECT SUM(glaq003),SUM(glaq004)",
               "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
               " WHERE glaqent = ",g_enterprise,
               "   AND glaqld  = ? ",
               "   AND glap002 = ? ",
               "   AND glap004 = ? ",
               "   AND glaq002 IN (SELECT DISTINCT bgao003 FROM bgao_t ",
               "                    WHERE bgaoent = ",g_enterprise,
               "                      AND bgao001 = '",g_master.bgaa008,"'",
               "                      AND bgao002 = '",l_glaa004,"'",
               "                      AND bgao004 = ? )",
               "   AND glap007 = 'CE' "
   PREPARE abgp610_p_pre2 FROM l_sql
   
   #抓取glar资料
   LET l_sql = "SELECT glarld,glar002,glar003,SUM(glar005),SUM(glar006),",
               "       ?,?,?,?,?,?,?,?,?,?,?,?,?,'','' ",
               "  FROM glar_t ",
               " WHERE glarent = ",g_enterprise,
               "   AND glarld = ? ",
               "   AND glar001 IN (SELECT DISTINCT bgao003 FROM bgao_t ",
               "                    WHERE bgaoent = ",g_enterprise,
               "                      AND bgao001 = '",g_master.bgaa008,"'",
               "                      AND bgao002 = '",l_glaa004,"'",
               "                      AND bgao004 = ? )",
               "   AND glar002 = ? ",
               "   AND glar003 = ? ",
               " GROUP BY glarld,glar002,glar003,?,?,?,?,?,?,?,?,?,?,?,?,?"
   PREPARE abgp610_p_pre3 FROM l_sql
   DECLARE abgp610_p_cs3 CURSOR FOR abgp610_p_pre3 
   
   #移动平均法重新推算
   LET l_sql = "SELECT bgae001,glar003,glar013,glar014,glar015,",
               "       glar016,glar017,glar018,glar019,glar020,glar022,",
               "       glar023,glar051,glar052,glar053,amt",
               "  FROM abgp610_tmp01 ",
               " ORDER BY bgae001,glar003 "
   PREPARE abgp610_p_pre4 FROM l_sql
   DECLARE abgp610_p_cs4 CURSOR FOR abgp610_p_pre4
   
   #往abgt620塞资料
   LET l_sql = "SELECT bgae001,glar003,glar013,glar014,glar015,",
               "       glar016,glar017,glar018,glar019,glar020,glar022,",
               "       glar023,glar051,glar052,glar053,amt",
               "  FROM abgp610_tmp02 ",
               " ORDER BY bgae001,glar003 "
   PREPARE abgp610_p_pre5 FROM l_sql
   DECLARE abgp610_p_cs5 CURSOR FOR abgp610_p_pre5
   
   #组织   
   FOREACH abgp610_p_cs INTO l_bgfb007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp610_p_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
      
      #预算组织对应法人
      LET l_comp = ''
      SELECT ooef017 INTO l_comp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_bgfb007
      
      #预算组织对应法人的主账套
      LET l_ld = ''      LET l_glaa001 = ''
      SELECT glaald,glaa001 INTO l_ld,l_glaa001
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_comp
         AND glaa014 = 'Y'
         
      DELETE FROM abgp610_tmp01;
      DELETE FROM abgp610_tmp02;
      
      #预算细项/借贷方向
      FOREACH abgp610_p_cs1 INTO l_bgae001,l_bgae002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp610_p_cs1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         
         #abgli110抓取维度
         CALL l_field.clear()
         CALL abgp610_field(g_master.bgfb002,l_bgfb007,l_bgae001) 
         RETURNING l_field[1].f1,l_field[2].f1,l_field[3].f1,l_field[4].f1,l_field[5].f1,
                   l_field[6].f1,l_field[7].f1,l_field[8].f1,l_field[9].f1,l_field[10].f1,
                   l_field[11].f1,l_field[12].f1,l_field[13].f1
         
            
         FOR l_month = 1 TO l_glav006_max   
            INITIALIZE l_tmp TO NULL         
            FOREACH abgp610_p_cs3 USING l_field[1].f1,l_field[2].f1,l_field[3].f1,l_field[4].f1,l_field[5].f1,
                                        l_field[6].f1,l_field[7].f1,l_field[8].f1,l_field[9].f1,l_field[10].f1,
                                        l_field[11].f1,l_field[12].f1,l_field[13].f1,                                   
                                        l_ld,l_bgae001,l_year,l_month,
                                        l_field[1].f1,l_field[2].f1,l_field[3].f1,l_field[4].f1,l_field[5].f1,
                                        l_field[6].f1,l_field[7].f1,l_field[8].f1,l_field[9].f1,l_field[10].f1,
                                        l_field[11].f1,l_field[12].f1,l_field[13].f1 
                                   INTO l_tmp.*
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'abgp610_p_cs3'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                
                  LET r_success = FALSE
               END IF       
          
               IF cl_null(l_tmp.glar005) THEN LET l_tmp.glar005 = 0 END IF
               IF cl_null(l_tmp.glar006) THEN LET l_tmp.glar006 = 0 END IF
               
               #CE凭证
               LET l_glaq003_ce = 0    LET l_glaq004_ce = 0
               EXECUTE abgp610_p_pre2 USING l_ld,l_year,l_month,l_bgae001 INTO l_glaq003_ce,l_glaq004_ce
               
               IF cl_null(l_glaq003_ce) THEN LET l_glaq003_ce = 0 END IF
               IF cl_null(l_glaq004_ce) THEN LET l_glaq004_ce = 0 END IF
                  
               LET l_tmp.glar005 = l_tmp.glar005 - l_glaq003_ce
               LET l_tmp.glar006 = l_tmp.glar006 - l_glaq004_ce
               
               #根据预算细项的借贷方向来判断是借-贷还是贷-借
               IF l_bgae002 = '1' THEN #借方
                  LET l_tmp.amt = l_tmp.glar005 - l_tmp.glar006
               ELSE
                  LET l_tmp.amt = l_tmp.glar006 - l_tmp.glar005 
               END IF
               
               #百分比法
               IF g_master.a = '1' THEN  
                  LET l_tmp.amt = l_tmp.amt * (1 + g_master.a1/100)
               END IF
               
               LET l_tmp.bgae001 = l_bgae001
               
               IF cl_null(l_tmp.glar013) THEN LET l_tmp.glar013 = ' ' END IF
               IF cl_null(l_tmp.glar014) THEN LET l_tmp.glar014 = ' ' END IF
               IF cl_null(l_tmp.glar015) THEN LET l_tmp.glar015 = ' ' END IF
               IF cl_null(l_tmp.glar016) THEN LET l_tmp.glar016 = ' ' END IF
               IF cl_null(l_tmp.glar017) THEN LET l_tmp.glar017 = ' ' END IF
               IF cl_null(l_tmp.glar018) THEN LET l_tmp.glar018 = ' ' END IF
               IF cl_null(l_tmp.glar019) THEN LET l_tmp.glar019 = ' ' END IF
               IF cl_null(l_tmp.glar020) THEN LET l_tmp.glar020 = ' ' END IF
               IF cl_null(l_tmp.glar022) THEN LET l_tmp.glar022 = ' ' END IF
               IF cl_null(l_tmp.glar023) THEN LET l_tmp.glar023 = ' ' END IF
               IF cl_null(l_tmp.glar051) THEN LET l_tmp.glar051 = ' ' END IF
               IF cl_null(l_tmp.glar052) THEN LET l_tmp.glar052 = ' ' END IF
               IF cl_null(l_tmp.glar053) THEN LET l_tmp.glar053 = ' ' END IF
               
               INSERT INTO abgp610_tmp01 VALUES(l_tmp.*)
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp610_tmp01'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF
               
               INITIALIZE l_tmp TO NULL
            END FOREACH 
         END FOR
      END FOREACH
      
      #若采用移动平均法,则重新推算金额
      INITIALIZE l_tmp1 TO NULL
      FOREACH abgp610_p_cs4 INTO l_tmp1.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp610_p_cs4'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         
         IF g_master.b = '1' THEN 
            #ex:上期會計週期有12期 
            # 移動平均期別 5 ,由最後期往前推算
            # 第 1期 = sum(glar 12 ~ 8期 )/5 
            # 第 2期 = sum(預算第一期+ glar 12 ~ 9期 )/5
            # 第 3期 = sum(預算第1+ 2期+ glar 12 ~ 10期 )/5
            
            #计算当前期别之前所有期别的金额
            SELECT SUM(amt) INTO l_amt1
              FROM abgp610_tmp01
             WHERE bgae001 = l_tmp1.bgae001
               AND bgar003 BETWEEN 1 AND l_tmp1.glar003 - 1
               
            IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
            
            #由最後期往前推算的金额
            SELECT SUM(amt) INTO l_amt2
              FROM abgp610_tmp01
             WHERE bgae001 = l_tmp1.bgae001
               AND bgar003 BETWEEN l_glav006_max - g_master.b1 + 1 + (l_tmp1.glar003 - 1) AND l_glav006_max
               
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF 
            
            LET l_tmp.amt = (l_amt1 + l_amt2)/g_master.b1
            
            INSERT INTO abgp610_tmp02 VALUES(l_tmp1.*)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins abgp610_tmp02'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         ELSE
            INSERT INTO abgp610_tmp02 VALUES(l_tmp1.*)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins abgp610_tmp02'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
         
         INITIALIZE l_tmp1 TO NULL
      END FOREACH
      
      #往abgt620里面塞资料
      INITIALIZE l_tmp1 TO NULL
      
      #abgi090预算管理组织/样表编号
      LET l_bgai002 = ' '     LET l_bgai008 = ''
      SELECT DISTINCT bgai002,bgai008 INTO l_bgai002,l_bgai008
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = g_master.bgfb002
         AND bgai003 = g_user
         AND bgai004 = l_bgfb007
         AND bgai005 IN ('04','ALL')
         AND ROWNUM = 1
      
      FOREACH abgp610_p_cs5 INTO l_tmp1.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp610_p_cs5'
            LET g_errparam.popup = TRUE
            CALL cl_err()
          
            LET r_success = FALSE
         END IF
         
         #abgi040费用分类
         LET l_bgae008 = ''
         SELECT bgae008 INTO l_bgae008
           FROM bgae_t
          WHERE bgaeent = g_enterprise
            AND bgae001 = l_tmp1.bgae001
            AND bgae006 = g_master.bgaa008
            
         #抓取组织的上层组织
         SELECT ooed005 INTO l_ooed005
           FROM ooed_t
          WHERE ooedent = g_enterprise
            AND ooed001 = '4'
            AND ooed002 = l_bgaa011
            AND ooed003 = l_bgaa010
            AND ooed004 = l_bgfb007
            
         IF cl_null(l_ooed005) THEN 
            LET l_ooed005 = g_master.bgfb007
         END IF
         
         #抓取税区
         LET l_ooef019 = ''
         SELECT ooef019 INTO l_ooef019
           FROM ooef_t
          WHERE ooefent = g_enterprise
            AND ooef001 = l_bgfb007
         
         #含税否
         LET l_oodb005 = ''
         SELECT oodb002,oodb005 INTO l_oodb002,l_oodb005
           FROM oodb_t
          WHERE oodbent = g_enterprise
            AND oodb001 = l_ooef019
            AND oodb008 = '2'
            AND ROWNUM = 1
         
         LET l_bgfb.bgfbent = g_enterprise
         LET l_bgfb.bgfb001 = '20'
         LET l_bgfb.bgfb002 = g_master.bgfb002
         LET l_bgfb.bgfb003 = g_master.bgfb003
         LET l_bgfb.bgfb004 = l_bgai002
         LET l_bgfb.bgfb005 = l_bgae008
         LET l_bgfb.bgfb006 = '1'
         LET l_bgfb.bgfb007 = l_bgfb007
         LET l_bgfb.bgfb008 = l_tmp1.glar003
         LET l_bgfb.bgfb009 = l_tmp1.bgae001 
         LET l_bgfb.bgfb011 = l_bgai008
         LET l_bgfb.bgfb012 = l_tmp1.glar020
         LET l_bgfb.bgfb013 = l_tmp1.glar013
         LET l_bgfb.bgfb014 = l_tmp1.glar014
         LET l_bgfb.bgfb015 = l_tmp1.glar015
         LET l_bgfb.bgfb016 = l_tmp1.glar016
         LET l_bgfb.bgfb017 = l_tmp1.glar017
         LET l_bgfb.bgfb018 = l_tmp1.glar018
         LET l_bgfb.bgfb019 = l_tmp1.glar019
         LET l_bgfb.bgfb020 = l_tmp1.glar022
         LET l_bgfb.bgfb021 = l_tmp1.glar023
         LET l_bgfb.bgfb022 = l_tmp1.glar051
         LET l_bgfb.bgfb023 = l_tmp1.glar052
         LET l_bgfb.bgfb024 = l_tmp1.glar053
         
         #组合key bgeg010
         LET l_bgfb.bgfb010 = "bgfb013=",l_bgfb.bgfb013,"/",
                              "bgfb014=",l_bgfb.bgfb014,"/",
                              "bgfb015=",l_bgfb.bgfb015,"/",
                              "bgfb016=",l_bgfb.bgfb016,"/",
                              "bgfb017=",l_bgfb.bgfb017,"/",
                              "bgfb018=",l_bgfb.bgfb018,"/",
                              "bgfb019=",l_bgfb.bgfb019,"/",
                              "bgfb022=",l_bgfb.bgfb022,"/",
                              "bgfb023=",l_bgfb.bgfb023,"/",
                              "bgfb024=",l_bgfb.bgfb024,"/",
                              "bgfb012=",l_bgfb.bgfb012,"/",
                              "bgfb020=",l_bgfb.bgfb020,"/",
                              "bgfb021=",l_bgfb.bgfb021,""
                              
         SELECT COUNT(1) INTO l_n
           FROM bgfb_t
          WHERE bgfbent = g_enterprise
            AND bgfb001 = l_bgfb.bgfb001
            AND bgfb002 = l_bgfb.bgfb002
            AND bgfb003 = l_bgfb.bgfb003
            AND bgfb004 = l_bgfb.bgfb004
            AND bgfb005 = l_bgfb.bgfb005
            AND bgfb006 = l_bgfb.bgfb006
            AND bgfb007 = l_bgfb.bgfb007
            AND bgfb008 = l_bgfb.bgfb008
            AND bgfb009 = l_bgfb.bgfb009
            AND bgfb010 = l_bgfb.bgfb010
            
         IF l_n > 0 THEN 
            LET l_bgfbstus = ''
            SELECT bgfbstus INTO l_bgfbstus
              FROM bgfb_t
             WHERE bgfbent = g_enterprise
               AND bgfb001 = l_bgfb.bgfb001
               AND bgfb002 = l_bgfb.bgfb002
               AND bgfb003 = l_bgfb.bgfb003
               AND bgfb004 = l_bgfb.bgfb004
               AND bgfb005 = l_bgfb.bgfb005
               AND bgfb006 = l_bgfb.bgfb006
               AND bgfb007 = l_bgfb.bgfb007
               AND bgfb008 = l_bgfb.bgfb008
               AND bgfb009 = l_bgfb.bgfb009
               AND bgfb010 = l_bgfb.bgfb010
               
            IF l_bgfbstus = 'Y' THEN 
               LET l_message = l_bgfb.bgfb001,"/",l_bgfb.bgfb002,"/",l_bgfb.bgfb003,"/",l_bgfb.bgfb004,"/",
                               l_bgfb.bgfb005,"/",l_bgfb.bgfb006,"/",l_bgfb.bgfb007,"/",l_bgfb.bgfb008,"/",
                               l_bgfb.bgfb009,"/",l_bgfb.bgfb010
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'abg-00294'
               LET g_errparam.extend = l_message
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CONTINUE FOREACH
            ELSE
               DELETE FROM bgfb_t
                WHERE bgfbent = g_enterprise
                  AND bgfb001 = l_bgfb.bgfb001
                  AND bgfb002 = l_bgfb.bgfb002
                  AND bgfb003 = l_bgfb.bgfb003
                  AND bgfb004 = l_bgfb.bgfb004
                  AND bgfb005 = l_bgfb.bgfb005
                  AND bgfb006 = l_bgfb.bgfb006
                  AND bgfb007 = l_bgfb.bgfb007
                  AND bgfb008 = l_bgfb.bgfb008
                  AND bgfb009 = l_bgfb.bgfb009
                  AND bgfb010 = l_bgfb.bgfb010
            END IF 
         END IF
         
         LET l_n = 0 
         SELECT COUNT(*) INTO l_n
           FROM bgfb_t
          WHERE bgfbent = g_enterprise
            AND bgfb001 = l_bgfb.bgfb001
            AND bgfb002 = l_bgfb.bgfb002
            AND bgfb003 = l_bgfb.bgfb003
            AND bgfb004 = l_bgfb.bgfb004
            AND bgfb005 = l_bgfb.bgfb005
            AND bgfb006 = l_bgfb.bgfb006
            AND bgfb009 = l_bgfb.bgfb009
            AND bgfb010 = l_bgfb.bgfb010
         
         IF l_n > 0 THEN
            SELECT DISTINCT bgfbseq INTO l_bgfb.bgfbseq
              FROM bgfb_t
             WHERE bgfbent = g_enterprise
               AND bgfb001 = l_bgfb.bgfb001
               AND bgfb002 = l_bgfb.bgfb002
               AND bgfb003 = l_bgfb.bgfb003
               AND bgfb004 = l_bgfb.bgfb004
               AND bgfb005 = l_bgfb.bgfb005
               AND bgfb006 = l_bgfb.bgfb006
               AND bgfb009 = l_bgfb.bgfb009
               AND bgfb010 = l_bgfb.bgfb010
         ELSE
            SELECT MAX(bgfbseq) + 1 INTO l_bgfb.bgfbseq
              FROM bgfb_t
             WHERE bgfbent = g_enterprise
               AND bgfb001 = l_bgfb.bgfb001
               AND bgfb002 = l_bgfb.bgfb002
               AND bgfb003 = l_bgfb.bgfb003
               AND bgfb004 = l_bgfb.bgfb004
               AND bgfb005 = l_bgfb.bgfb005
               AND bgfb006 = l_bgfb.bgfb006
               AND bgfb009 = l_bgfb.bgfb009
               AND bgfb010 = l_bgfb.bgfb010
               
            IF cl_null(l_bgfb.bgfbseq) THEN 
               LET l_bgfb.bgfbseq = 1
            END IF
         END IF
  
         LET l_bgfb.bgfb025 = ' '
         LET l_bgfb.bgfb026 = ' '
         LET l_bgfb.bgfb027 = ' '
         LET l_bgfb.bgfb028 = ' '
         LET l_bgfb.bgfb029 = ' '
         LET l_bgfb.bgfb030 = ' '
         LET l_bgfb.bgfb031 = ' '
         LET l_bgfb.bgfb032 = ' '
         LET l_bgfb.bgfb033 = ' '
         LET l_bgfb.bgfb034 = ' '
         LET l_bgfb.bgfb035 = l_oodb002
         LET l_bgfb.bgfb036 = l_oodb005
         LET l_bgfb.bgfb037 = l_tmp1.amt
         LET l_bgfb.bgfb038 = 0
         LET l_bgfb.bgfb039 = 0
         LET l_bgfb.bgfb047 = l_ooed005
         LET l_bgfb.bgfb048 = ''
         LET l_bgfb.bgfb100 = l_glaa001
         
         IF NOT cl_null(l_bgfb.bgfb100) AND NOT cl_null(l_bgaa003) THEN 
            CALL s_abg_get_bg_rate(g_master.bgfb002,g_today,l_bgaa003,l_bgfb.bgfb100)
            RETURNING l_bgfb.bgfb101
         ELSE
            LET l_bgfb.bgfb101 = 1
         END IF
         LET l_bgfb.bgfb102 = l_tmp1.amt
         LET l_bgfb.bgfb103 = l_tmp1.amt
         LET l_bgfb.bgfb104 = 0
         LET l_bgfb.bgfb105 = l_tmp1.amt
         
         LET l_bgfb.bgfbstus = 'N'  
         LET l_bgfb.bgfbownid = g_user
         LET l_bgfb.bgfbowndp = g_dept
         LET l_bgfb.bgfbcrtid = g_user
         LET l_bgfb.bgfbcrtdp = g_dept 
         LET l_bgfb.bgfbcrtdt = cl_get_current()
         LET l_bgfb.bgfbmodid = g_user
         LET l_bgfb.bgfbmoddt = cl_get_current() 
         
         INSERT INTO bgfb_t(bgfbent,bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb008,
                            bgfb009,bgfb010,bgfbseq,bgfb011,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,
                            bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb025,
                            bgfb026,bgfb027,bgfb028,bgfb029,bgfb030,bgfb031,bgfb032,bgfb033,bgfb034,
                            bgfb035,bgfb036,bgfb037,bgfb038,bgfb039,bgfb047,bgfb048,bgfb100,bgfb101,
                            bgfb102,bgfb103,bgfb104,bgfb105,bgfbstus,bgfbownid,bgfbowndp,bgfbcrtid,
                            bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) 
         VALUES(l_bgfb.bgfbent,l_bgfb.bgfb001,l_bgfb.bgfb002,l_bgfb.bgfb003,
                l_bgfb.bgfb004,l_bgfb.bgfb005,l_bgfb.bgfb006,l_bgfb.bgfb007,
                l_bgfb.bgfb008,l_bgfb.bgfb009,l_bgfb.bgfb010,l_bgfb.bgfbseq,
                l_bgfb.bgfb011,l_bgfb.bgfb012,l_bgfb.bgfb013,l_bgfb.bgfb014,
                l_bgfb.bgfb015,l_bgfb.bgfb016,l_bgfb.bgfb017,l_bgfb.bgfb018,
                l_bgfb.bgfb019,l_bgfb.bgfb020,l_bgfb.bgfb021,l_bgfb.bgfb022,
                l_bgfb.bgfb023,l_bgfb.bgfb024,l_bgfb.bgfb025,l_bgfb.bgfb026,
                l_bgfb.bgfb027,l_bgfb.bgfb028,l_bgfb.bgfb029,l_bgfb.bgfb030,
                l_bgfb.bgfb031,l_bgfb.bgfb032,l_bgfb.bgfb033,l_bgfb.bgfb034,
                l_bgfb.bgfb035,l_bgfb.bgfb036,l_bgfb.bgfb037,l_bgfb.bgfb038,
                l_bgfb.bgfb039,l_bgfb.bgfb047,l_bgfb.bgfb048,l_bgfb.bgfb100,
                l_bgfb.bgfb101,l_bgfb.bgfb102,l_bgfb.bgfb103,l_bgfb.bgfb104,
                l_bgfb.bgfb105,l_bgfb.bgfbstus,l_bgfb.bgfbownid,l_bgfb.bgfbowndp,
                l_bgfb.bgfbcrtid,l_bgfb.bgfbcrtdp,l_bgfb.bgfbcrtdt,l_bgfb.bgfbmodid,
                l_bgfb.bgfbmoddt,l_bgfb.bgfbcnfid,l_bgfb.bgfbcnfdt) 
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins bgfb_t'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
         LET r_flag = 'Y'
         
         #161215-00051#3--add--str--lujh
         #将本次插入的资料放临时表里存起来,全部执行完之后看看1-12(13)期是否都有资料,没资料要塞一笔金额是0的资料
         INSERT INTO abgp610_tmp03 VALUES(l_bgfb.bgfb001,l_bgfb.bgfb002,l_bgfb.bgfb003,
                                          l_bgfb.bgfb004,l_bgfb.bgfb005,l_bgfb.bgfb006,
                                          l_bgfb.bgfb007,l_bgfb.bgfb009,l_bgfb.bgfb010,
                                          l_bgfb.bgfbseq)
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins bgfb_t'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         #161215-00051#3--add--end--lujh
      END FOREACH
   END FOREACH
   
   #161215-00051#3--add--str--lujh
   LET l_sql = "SELECT DISTINCT bgfb001,bgfb002,bgfb003,",
               "                bgfb004,bgfb005,bgfb006,",
               "                bgfb007,bgfb009,bgfb010,",
               "                bgfbseq ",
               "  FROM abgp610_tmp03 "
   PREPARE abgp610_p_pre6 FROM l_sql
   DECLARE abgp610_p_cs6 CURSOR FOR abgp610_p_pre6
   
   FOREACH abgp610_p_cs6 INTO l_bgfb1.bgfb001,l_bgfb1.bgfb002,l_bgfb1.bgfb003,
                              l_bgfb1.bgfb004,l_bgfb1.bgfb005,l_bgfb1.bgfb006,
                              l_bgfb1.bgfb007,l_bgfb1.bgfb009,l_bgfb1.bgfb010,
                              l_bgfb1.bgfbseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp610_p_cs5'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
   
      FOR l_i = 1 TO l_glav006_max
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM bgfb_t
          WHERE bgfbent = g_enterprise
            AND bgfb001 = l_bgfb1.bgfb001
            AND bgfb002 = l_bgfb1.bgfb002
            AND bgfb003 = l_bgfb1.bgfb003
            AND bgfb004 = l_bgfb1.bgfb004
            AND bgfb005 = l_bgfb1.bgfb005
            AND bgfb006 = l_bgfb1.bgfb006
            AND bgfb007 = l_bgfb1.bgfb007
            AND bgfb008 = l_i
            AND bgfb009 = l_bgfb1.bgfb009
            AND bgfb010 = l_bgfb1.bgfb010 
            AND bgfbseq = l_bgfb1.bgfbseq
            
         IF l_n = 0 THEN 
            INITIALIZE l_bgfb.* TO NULL
            
            SELECT DISTINCT bgfbent,bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb008,
                            bgfb009,bgfb010,bgfbseq,bgfb011,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,
                            bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb025,
                            bgfb026,bgfb027,bgfb028,bgfb029,bgfb030,bgfb031,bgfb032,bgfb033,bgfb034,
                            bgfb035,bgfb036,bgfb037,bgfb038,bgfb039,bgfb047,bgfb048,bgfb100,bgfb101,
                            bgfb102,bgfb103,bgfb104,bgfb105,bgfbstus,bgfbownid,bgfbowndp,bgfbcrtid,
                            bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt
              INTO l_bgfb.bgfbent,l_bgfb.bgfb001,l_bgfb.bgfb002,l_bgfb.bgfb003,
                   l_bgfb.bgfb004,l_bgfb.bgfb005,l_bgfb.bgfb006,l_bgfb.bgfb007,
                   l_bgfb.bgfb008,l_bgfb.bgfb009,l_bgfb.bgfb010,l_bgfb.bgfbseq,
                   l_bgfb.bgfb011,l_bgfb.bgfb012,l_bgfb.bgfb013,l_bgfb.bgfb014,
                   l_bgfb.bgfb015,l_bgfb.bgfb016,l_bgfb.bgfb017,l_bgfb.bgfb018,
                   l_bgfb.bgfb019,l_bgfb.bgfb020,l_bgfb.bgfb021,l_bgfb.bgfb022,
                   l_bgfb.bgfb023,l_bgfb.bgfb024,l_bgfb.bgfb025,l_bgfb.bgfb026,
                   l_bgfb.bgfb027,l_bgfb.bgfb028,l_bgfb.bgfb029,l_bgfb.bgfb030,
                   l_bgfb.bgfb031,l_bgfb.bgfb032,l_bgfb.bgfb033,l_bgfb.bgfb034,
                   l_bgfb.bgfb035,l_bgfb.bgfb036,l_bgfb.bgfb037,l_bgfb.bgfb038,
                   l_bgfb.bgfb039,l_bgfb.bgfb047,l_bgfb.bgfb048,l_bgfb.bgfb100,
                   l_bgfb.bgfb101,l_bgfb.bgfb102,l_bgfb.bgfb103,l_bgfb.bgfb104,
                   l_bgfb.bgfb105,l_bgfb.bgfbstus,l_bgfb.bgfbownid,l_bgfb.bgfbowndp,
                   l_bgfb.bgfbcrtid,l_bgfb.bgfbcrtdp,l_bgfb.bgfbcrtdt,l_bgfb.bgfbmodid,
                   l_bgfb.bgfbmoddt,l_bgfb.bgfbcnfid,l_bgfb.bgfbcnfdt
              FROM bgfb_t
             WHERE bgfbent = g_enterprise
               AND bgfb001 = l_bgfb1.bgfb001
               AND bgfb002 = l_bgfb1.bgfb002
               AND bgfb003 = l_bgfb1.bgfb003
               AND bgfb004 = l_bgfb1.bgfb004
               AND bgfb005 = l_bgfb1.bgfb005
               AND bgfb006 = l_bgfb1.bgfb006
               AND bgfb007 = l_bgfb1.bgfb007
               AND bgfb009 = l_bgfb1.bgfb009
               AND bgfb010 = l_bgfb1.bgfb010 
               AND bgfbseq = l_bgfb1.bgfbseq 
              
            LET l_bgfb.bgfb008 = l_i  
            LET l_bgfb.bgfb037 = 0
            LET l_bgfb.bgfb038 = 0
            LET l_bgfb.bgfb039 = 0     
            LET l_bgfb.bgfb102 = 0 
            LET l_bgfb.bgfb103 = 0     
            LET l_bgfb.bgfb104 = 0     
            LET l_bgfb.bgfb105 = 0    

            INSERT INTO bgfb_t(bgfbent,bgfb001,bgfb002,bgfb003,bgfb004,bgfb005,bgfb006,bgfb007,bgfb008,
                               bgfb009,bgfb010,bgfbseq,bgfb011,bgfb012,bgfb013,bgfb014,bgfb015,bgfb016,
                               bgfb017,bgfb018,bgfb019,bgfb020,bgfb021,bgfb022,bgfb023,bgfb024,bgfb025,
                               bgfb026,bgfb027,bgfb028,bgfb029,bgfb030,bgfb031,bgfb032,bgfb033,bgfb034,
                               bgfb035,bgfb036,bgfb037,bgfb038,bgfb039,bgfb047,bgfb048,bgfb100,bgfb101,
                               bgfb102,bgfb103,bgfb104,bgfb105,bgfbstus,bgfbownid,bgfbowndp,bgfbcrtid,
                               bgfbcrtdp,bgfbcrtdt,bgfbmodid,bgfbmoddt,bgfbcnfid,bgfbcnfdt) 
            VALUES(l_bgfb.bgfbent,l_bgfb.bgfb001,l_bgfb.bgfb002,l_bgfb.bgfb003,
                   l_bgfb.bgfb004,l_bgfb.bgfb005,l_bgfb.bgfb006,l_bgfb.bgfb007,
                   l_bgfb.bgfb008,l_bgfb.bgfb009,l_bgfb.bgfb010,l_bgfb.bgfbseq,
                   l_bgfb.bgfb011,l_bgfb.bgfb012,l_bgfb.bgfb013,l_bgfb.bgfb014,
                   l_bgfb.bgfb015,l_bgfb.bgfb016,l_bgfb.bgfb017,l_bgfb.bgfb018,
                   l_bgfb.bgfb019,l_bgfb.bgfb020,l_bgfb.bgfb021,l_bgfb.bgfb022,
                   l_bgfb.bgfb023,l_bgfb.bgfb024,l_bgfb.bgfb025,l_bgfb.bgfb026,
                   l_bgfb.bgfb027,l_bgfb.bgfb028,l_bgfb.bgfb029,l_bgfb.bgfb030,
                   l_bgfb.bgfb031,l_bgfb.bgfb032,l_bgfb.bgfb033,l_bgfb.bgfb034,
                   l_bgfb.bgfb035,l_bgfb.bgfb036,l_bgfb.bgfb037,l_bgfb.bgfb038,
                   l_bgfb.bgfb039,l_bgfb.bgfb047,l_bgfb.bgfb048,l_bgfb.bgfb100,
                   l_bgfb.bgfb101,l_bgfb.bgfb102,l_bgfb.bgfb103,l_bgfb.bgfb104,
                   l_bgfb.bgfb105,l_bgfb.bgfbstus,l_bgfb.bgfbownid,l_bgfb.bgfbowndp,
                   l_bgfb.bgfbcrtid,l_bgfb.bgfbcrtdp,l_bgfb.bgfbcrtdt,l_bgfb.bgfbmodid,
                   l_bgfb.bgfbmoddt,l_bgfb.bgfbcnfid,l_bgfb.bgfbcnfdt) 
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins bgfb_t'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
      END FOR
   END FOREACH
   #161215-00051#3--add--end--lujh
   
   RETURN r_success,r_flag
END FUNCTION
# 抓取abgi110设置
PRIVATE FUNCTION abgp610_get_bgal(p_bgal001,p_bgal002,p_bgal003)
   DEFINE p_bgal001           LIKE bgal_t.bgal001
   DEFINE p_bgal002           LIKE bgal_t.bgal002
   DEFINE p_bgal003           LIKE bgal_t.bgal003
   DEFINE l_bgal              RECORD
                              bgal005              LIKE bgal_t.bgal005,
                              bgal006              LIKE bgal_t.bgal006,
                              bgal007              LIKE bgal_t.bgal007,
                              bgal008              LIKE bgal_t.bgal008,
                              bgal009              LIKE bgal_t.bgal009,
                              bgal010              LIKE bgal_t.bgal010,
                              bgal011              LIKE bgal_t.bgal011,
                              bgal012              LIKE bgal_t.bgal012,
                              bgal013              LIKE bgal_t.bgal013,
                              bgal014              LIKE bgal_t.bgal014,
                              bgal025              LIKE bgal_t.bgal025,
                              bgal026              LIKE bgal_t.bgal026,
                              bgal027              LIKE bgal_t.bgal027
                              END RECORD
   
   INITIALIZE l_bgal.* TO NULL
   
   SELECT bgal005,bgal006,bgal007,bgal008,bgal009,bgal010,
          bgal011,bgal012,bgal013,bgal014,bgal025,bgal026,bgal027
     INTO l_bgal.bgal005,l_bgal.bgal006,l_bgal.bgal007,l_bgal.bgal008,
          l_bgal.bgal009,l_bgal.bgal010,l_bgal.bgal011,l_bgal.bgal012,
          l_bgal.bgal013,l_bgal.bgal014,l_bgal.bgal025,l_bgal.bgal026,
          l_bgal.bgal027
     FROM bgal_t
    WHERE bgalent = g_enterprise
      AND bgal001 = p_bgal001
      AND bgal002 = p_bgal002
      AND bgal003 = p_bgal003
      
   RETURN l_bgal.*
END FUNCTION
# 根据agli110的设置抓取group条件
PRIVATE FUNCTION abgp610_field(p_bgal001,p_bgal002,p_bgal003)
   DEFINE p_bgal001           LIKE bgal_t.bgal001
   DEFINE p_bgal002           LIKE bgal_t.bgal002
   DEFINE p_bgal003           LIKE bgal_t.bgal003
   DEFINE r_field             DYNAMIC ARRAY OF RECORD
                               f1       LIKE type_t.chr1000
                              END RECORD   
   DEFINE l_bgal              RECORD
                              bgal005              LIKE bgal_t.bgal005,
                              bgal006              LIKE bgal_t.bgal006,
                              bgal007              LIKE bgal_t.bgal007,
                              bgal008              LIKE bgal_t.bgal008,
                              bgal009              LIKE bgal_t.bgal009,
                              bgal010              LIKE bgal_t.bgal010,
                              bgal011              LIKE bgal_t.bgal011,
                              bgal012              LIKE bgal_t.bgal012,
                              bgal013              LIKE bgal_t.bgal013,
                              bgal014              LIKE bgal_t.bgal014,
                              bgal025              LIKE bgal_t.bgal025,
                              bgal026              LIKE bgal_t.bgal026,
                              bgal027              LIKE bgal_t.bgal027
                              END RECORD
                              
   CALL abgp610_get_bgal(p_bgal001,p_bgal002,p_bgal003) RETURNING l_bgal.*
   CALL r_field.clear()
   
   #查询栏位
   #部门
   IF l_bgal.bgal005 = 'Y' THEN 
      LET r_field[1].f1 = "glar013"
   ELSE
      LET r_field[1].f1 = ''
   END IF
   
   #成本利润中心
   IF l_bgal.bgal006 = 'Y' THEN 
      LET r_field[2].f1 = "glar014"
   ELSE
      LET r_field[2].f1 = ''
   END IF
   
   #区域
   IF l_bgal.bgal007 = 'Y' THEN 
      LET r_field[3].f1 = "glar015"
   ELSE
      LET r_field[3].f1 = ''
   END IF
   
   #收付款客商
   IF l_bgal.bgal008 = 'Y' THEN 
      LET r_field[4].f1 = "glar016"
   ELSE
      LET r_field[4].f1 = ''
   END IF
   
   #账款客商
   IF l_bgal.bgal009 = 'Y' THEN 
      LET r_field[5].f1 = "glar017"
   ELSE
      LET r_field[5].f1 = ''
   END IF
   
   #客群
   IF l_bgal.bgal010 = 'Y' THEN 
      LET r_field[6].f1 = "glar018"
   ELSE
      LET r_field[6].f1 = ''
   END IF
   
   #产品类别
   IF l_bgal.bgal011 = 'Y' THEN 
      LET r_field[7].f1 = "glar019"
   ELSE
      LET r_field[7].f1 = ''
   END IF
   
   #人员
   IF l_bgal.bgal012 = 'Y' THEN 
      LET r_field[8].f1 = "glar020"
   ELSE
      LET r_field[8].f1 = ''
   END IF
   
   #专案编号
   IF l_bgal.bgal013 = 'Y' THEN 
      LET r_field[9].f1 = "glar022"
   ELSE
      LET r_field[9].f1 = ''
   END IF
   
   #WBS
   IF l_bgal.bgal014 = 'Y' THEN 
      LET r_field[10].f1 = "glar023"
   ELSE
      LET r_field[10].f1 = ''
   END IF
   
   #经营方式
   IF l_bgal.bgal025 = 'Y' THEN 
      LET r_field[11].f1 = "glar051"
   ELSE
      LET r_field[11].f1 = ''
   END IF
   
   #通路
   IF l_bgal.bgal026 = 'Y' THEN 
      LET r_field[12].f1 = "glar052"
   ELSE
      LET r_field[12].f1 = ''
   END IF
   
   #品牌
   IF l_bgal.bgal027 = 'Y' THEN 
      LET r_field[13].f1 = "glar053"
   ELSE
      LET r_field[13].f1 = ''
   END IF
   
   RETURN r_field[1].f1,r_field[2].f1,r_field[3].f1,r_field[4].f1,r_field[5].f1,
          r_field[6].f1,r_field[7].f1,r_field[8].f1,r_field[9].f1,r_field[10].f1,
          r_field[11].f1,r_field[12].f1,r_field[13].f1
END FUNCTION
# 创建临时表
PRIVATE FUNCTION abgp610_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE abgp610_tmp01;
   CREATE TEMP TABLE abgp610_tmp01(
   glarld                VARCHAR(5),
   glar002               SMALLINT,
   glar003               SMALLINT,
   glar005               DECIMAL(20,6),
   glar006               DECIMAL(20,6),
   glar013               VARCHAR(10),
   glar014               VARCHAR(10),
   glar015               VARCHAR(10),
   glar016               VARCHAR(10),
   glar017               VARCHAR(10),
   glar018               VARCHAR(10),
   glar019               VARCHAR(10),
   glar020               VARCHAR(20),
   glar022               VARCHAR(20),
   glar023               VARCHAR(30),
   glar051               VARCHAR(10),
   glar052               VARCHAR(10),
   glar053               VARCHAR(10),
   amt                   DECIMAL(20,6),
   bgae001               VARCHAR(24)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp610_tmp02;
   CREATE TEMP TABLE abgp610_tmp02(
   bgae001               VARCHAR(24),
   glar003               SMALLINT,
   glar013               VARCHAR(10),
   glar014               VARCHAR(10),
   glar015               VARCHAR(10),
   glar016               VARCHAR(10),
   glar017               VARCHAR(10),
   glar018               VARCHAR(10),
   glar019               VARCHAR(10),
   glar020               VARCHAR(20),
   glar022               VARCHAR(20),
   glar023               VARCHAR(30),
   glar051               VARCHAR(10),
   glar052               VARCHAR(10),
   glar053               VARCHAR(10),
   amt                   DECIMAL(20,6)
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #161215-00051#3--add--str--lujh
   DROP TABLE abgp610_tmp03;
   CREATE TEMP TABLE abgp610_tmp03(
   bgfb001               VARCHAR(10),      #來源作業
   bgfb002               VARCHAR(10),      #預算編號
   bgfb003               VARCHAR(10),      #版本
   bgfb004               VARCHAR(10),      #管理組織
   bgfb005               VARCHAR(10),      #費用來源
   bgfb006               VARCHAR(10),      #資料類型
   bgfb007               VARCHAR(10),      #預算組織
   bgfb009               VARCHAR(40),      #預算細項
   bgfb010               VARCHAR(1000),      #組合KEY
   bgfbseq               INTEGER     #項次
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   #161215-00051#3--add--end--lujh
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
