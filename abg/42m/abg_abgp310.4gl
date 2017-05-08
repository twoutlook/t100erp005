#該程式未解開Section, 採用最新樣板產出!
{<section id="abgp310.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-11-30 15:20:48), PR版次:0002(2017-01-20 17:14:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgp310
#+ Description: 預算參考資料轉入作業
#+ Creator....: 02114(2016-11-30 15:20:48)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="abgp310.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161215-00051#4   2017/01/17  By 02114    预算料件存在有期别没资料的情况,要把资料补上,金额给0
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
       bgcj002 LIKE bgcj_t.bgcj002, 
   bgcj002_desc LIKE type_t.chr80, 
   bgcj003 LIKE bgcj_t.bgcj003, 
   f LIKE type_t.chr500, 
   source LIKE type_t.chr1, 
   a LIKE type_t.chr1, 
   bgcj007 LIKE type_t.chr10, 
   b LIKE type_t.chr500, 
   date LIKE type_t.chr500, 
   c LIKE type_t.chr500, 
   d LIKE type_t.chr500, 
   e LIKE type_t.chr500, 
   bgcj016_1 LIKE type_t.chr10, 
   bgcj003_1 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_str_bgar002         STRING
DEFINE g_year                LIKE type_t.num5
DEFINE g_year_min            LIKE bgac_t.bgac002
DEFINE g_year_max            LIKE bgac_t.bgac002
DEFINE g_month_min           LIKE bgac_t.bgac004
DEFINE g_month_max           LIKE bgac_t.bgac004
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgp310.main" >}
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
      CALL abgp310_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgp310 WITH FORM cl_ap_formpath("abg",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abgp310_init()
 
      #進入選單 Menu (="N")
      CALL abgp310_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abgp310
   END IF
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE abgp310_tmp01;
   DROP TABLE abgp310_tmp02;
   DROP TABLE abgp310_tmp03;
   DROP TABLE abgp310_tmp04;
   DROP TABLE abgp310_tmp05;
   DROP TABLE abgp310_tmp06;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abgp310.init" >}
#+ 初始化作業
PRIVATE FUNCTION abgp310_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success          LIKE type_t.num5
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
   CALL cl_set_combo_scc("source","8962")
   CALL cl_set_combo_scc("b","8966")
   CALL cl_set_combo_scc("f","8957")
   CALL abgp310_create_tmp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abgp310.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgp310_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_ooef001_str   STRING
   DEFINE l_y      LIKE type_t.num5
   DEFINE l_m      LIKE type_t.num5
   DEFINE l_month  LIKE type_t.num5
   DEFINE l_yy     STRING
   DEFINE l_mm     STRING
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.source = '2'
   LET g_master.a = 'Y'
   LET l_y = YEAR(g_today)
   LET l_month = MONTH(g_today)
   IF l_month = 1 THEN 
      LET l_y = l_y - 1
      LET l_m = 12
   ELSE
      LET l_m = MONTH(g_today) - 1
   END IF
   LET l_yy = l_y
   LET l_mm = l_m
   LET g_master.date = l_yy CLIPPED,l_mm
   LET g_master.b = '1'
   LET g_master.c = '1'
   LET g_master.d = '1'
   LET g_master.f = '2'
   LET g_master.e = 'Y'
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bgcj002,g_master.bgcj003,g_master.f,g_master.source,g_master.a,g_master.b, 
             g_master.date,g_master.c,g_master.d,g_master.e,g_master.bgcj016_1,g_master.bgcj003_1 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj002
            
            #add-point:AFTER FIELD bgcj002 name="input.a.bgcj002"
            IF NOT cl_null(g_master.bgcj002) THEN 
#應用 a17 樣板自動產生(Version:3)
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
 
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgcj002

                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_bgaa001") THEN
                  #檢查成功時後續處理

               ELSE
                  #檢查失敗時後續處理
                  LET g_master.bgcj002 = ''
                  CALL abgp310_bgcj002_desc()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL abgp310_bgcj002_desc()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj002
            #add-point:BEFORE FIELD bgcj002 name="input.b.bgcj002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj002
            #add-point:ON CHANGE bgcj002 name="input.g.bgcj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003
            #add-point:BEFORE FIELD bgcj003 name="input.b.bgcj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003
            
            #add-point:AFTER FIELD bgcj003 name="input.a.bgcj003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003
            #add-point:ON CHANGE bgcj003 name="input.g.bgcj003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD f
            #add-point:BEFORE FIELD f name="input.b.f"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD f
            
            #add-point:AFTER FIELD f name="input.a.f"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE f
            #add-point:ON CHANGE f name="input.g.f"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD source
            #add-point:BEFORE FIELD source name="input.b.source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD source
            
            #add-point:AFTER FIELD source name="input.a.source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE source
            #add-point:ON CHANGE source name="input.g.source"
            
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
            IF g_master.b = '3' THEN 
               LET g_master.date = ''
               CALL cl_set_comp_entry("date",FALSE)
            ELSE
               LET l_y = YEAR(g_today)
               LET l_m = MONTH(g_today) - 1
               LET l_yy = l_y 
               LET l_mm = l_m
               LET g_master.date = l_yy CLIPPED,l_mm
               CALL cl_set_comp_entry("date",TRUE)
            END IF
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date
            #add-point:BEFORE FIELD date name="input.b.date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date
            
            #add-point:AFTER FIELD date name="input.a.date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date
            #add-point:ON CHANGE date name="input.g.date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="input.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="input.a.c"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c
            #add-point:ON CHANGE c name="input.g.c"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD d
            #add-point:BEFORE FIELD d name="input.b.d"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD d
            
            #add-point:AFTER FIELD d name="input.a.d"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE d
            #add-point:ON CHANGE d name="input.g.d"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD e
            #add-point:BEFORE FIELD e name="input.b.e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD e
            
            #add-point:AFTER FIELD e name="input.a.e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE e
            #add-point:ON CHANGE e name="input.g.e"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj016_1
            #add-point:BEFORE FIELD bgcj016_1 name="input.b.bgcj016_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj016_1
            
            #add-point:AFTER FIELD bgcj016_1 name="input.a.bgcj016_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj016_1
            #add-point:ON CHANGE bgcj016_1 name="input.g.bgcj016_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj003_1
            #add-point:BEFORE FIELD bgcj003_1 name="input.b.bgcj003_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj003_1
            
            #add-point:AFTER FIELD bgcj003_1 name="input.a.bgcj003_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgcj003_1
            #add-point:ON CHANGE bgcj003_1 name="input.g.bgcj003_1"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bgcj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj002
            #add-point:ON ACTION controlp INFIELD bgcj002 name="input.c.bgcj002"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgcj002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgaa001()                                #呼叫開窗
 
            LET g_master.bgcj002 = g_qryparam.return1              
            CALL abgp310_bgcj002_desc()
            DISPLAY g_master.bgcj002 TO bgcj002              #

            NEXT FIELD bgcj002                          #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.bgcj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003
            #add-point:ON ACTION controlp INFIELD bgcj003 name="input.c.bgcj003"
            
            #END add-point
 
 
         #Ctrlp:input.c.f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD f
            #add-point:ON ACTION controlp INFIELD f name="input.c.f"
            
            #END add-point
 
 
         #Ctrlp:input.c.source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD source
            #add-point:ON ACTION controlp INFIELD source name="input.c.source"
            
            #END add-point
 
 
         #Ctrlp:input.c.a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD a
            #add-point:ON ACTION controlp INFIELD a name="input.c.a"
            
            #END add-point
 
 
         #Ctrlp:input.c.b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b
            #add-point:ON ACTION controlp INFIELD b name="input.c.b"
            
            #END add-point
 
 
         #Ctrlp:input.c.date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date
            #add-point:ON ACTION controlp INFIELD date name="input.c.date"
            
            #END add-point
 
 
         #Ctrlp:input.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="input.c.c"
            
            #END add-point
 
 
         #Ctrlp:input.c.d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD d
            #add-point:ON ACTION controlp INFIELD d name="input.c.d"
            
            #END add-point
 
 
         #Ctrlp:input.c.e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD e
            #add-point:ON ACTION controlp INFIELD e name="input.c.e"
            
            #END add-point
 
 
         #Ctrlp:input.c.bgcj016_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj016_1
            #add-point:ON ACTION controlp INFIELD bgcj016_1 name="input.c.bgcj016_1"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_master.bgcj016_1             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_bgap001()                                #呼叫開窗
 
            LET g_master.bgcj016_1 = g_qryparam.return1              

            DISPLAY g_master.bgcj016_1 TO bgcj016_1              #

            NEXT FIELD bgcj016_1                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.bgcj003_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj003_1
            #add-point:ON ACTION controlp INFIELD bgcj003_1 name="input.c.bgcj003_1"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bgcj007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bgcj007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgcj007
            #add-point:ON ACTION controlp INFIELD bgcj007 name="construct.c.bgcj007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #2.檢查預算組織是否在abgi090中可操作的組織中
            CALL s_abg2_get_budget_site(g_master.bgcj002,'',g_user,'01') RETURNING l_ooef001_str
            CALL s_fin_get_wc_str(l_ooef001_str) RETURNING l_ooef001_str
            LET g_qryparam.where = " ooef001 IN ",l_ooef001_str
            CALL q_ooef001_77()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj007  #顯示到畫面上
            NEXT FIELD bgcj007                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgcj007
            #add-point:BEFORE FIELD bgcj007 name="construct.b.bgcj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgcj007
            
            #add-point:AFTER FIELD bgcj007 name="construct.a.bgcj007"
            
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
         BEFORE FIELD c
            #add-point:BEFORE FIELD c name="construct.b.c"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c
            
            #add-point:AFTER FIELD c name="construct.a.c"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c
            #add-point:ON ACTION controlp INFIELD c name="construct.c.c"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_wc ON bgcj016
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD bgcj016
            #add-point:ON ACTION controlp INFIELD bgcj016 name="construct.c.bgcj016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " bgap002 IN ('2','3') AND bgapstus='Y'"
            CALL q_bgap001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bgcj016  #顯示到畫面上
            NEXT FIELD bgcj016                     #返回原欄位
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
            CALL abgp310_get_buffer(l_dialog)
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
         CALL abgp310_init()
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
                 CALL abgp310_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abgp310_transfer_argv(ls_js)
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
 
{<section id="abgp310.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abgp310_transfer_argv(ls_js)
 
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
 
{<section id="abgp310.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abgp310_process(ls_js)
 
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
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abgp310_process_cs CURSOR FROM ls_sql
#  FOREACH abgp310_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL abgp310_p()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL abgp310_p()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL abgp310_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abgp310.get_buffer" >}
PRIVATE FUNCTION abgp310_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bgcj002 = p_dialog.getFieldBuffer('bgcj002')
   LET g_master.bgcj003 = p_dialog.getFieldBuffer('bgcj003')
   LET g_master.f = p_dialog.getFieldBuffer('f')
   LET g_master.source = p_dialog.getFieldBuffer('source')
   LET g_master.a = p_dialog.getFieldBuffer('a')
   LET g_master.b = p_dialog.getFieldBuffer('b')
   LET g_master.date = p_dialog.getFieldBuffer('date')
   LET g_master.c = p_dialog.getFieldBuffer('c')
   LET g_master.d = p_dialog.getFieldBuffer('d')
   LET g_master.e = p_dialog.getFieldBuffer('e')
   LET g_master.bgcj016_1 = p_dialog.getFieldBuffer('bgcj016_1')
   LET g_master.bgcj003_1 = p_dialog.getFieldBuffer('bgcj003_1')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgp310.msgcentre_notify" >}
PRIVATE FUNCTION abgp310_msgcentre_notify()
 
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
 
{<section id="abgp310.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 预算编号说明
PRIVATE FUNCTION abgp310_bgcj002_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.bgcj002
   CALL ap_ref_array2(g_ref_fields,"SELECT bgaal003 FROM bgaal_t WHERE bgaalent="||g_enterprise||" AND bgaal001=? AND bgaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.bgcj002_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_master.bgcj002_desc
END FUNCTION
# 创建临时表
PRIVATE FUNCTION abgp310_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE abgp310_tmp01;
   CREATE TEMP TABLE abgp310_tmp01(
   xmdkdocno               VARCHAR(20),       #单号   
   xmdksite                VARCHAR(10),        #营运据点
   xmdk001                 DATE,         #扣账日期
   xmdk007                 VARCHAR(10),         #交易客户
   xmdk030                 VARCHAR(10),         #销售通路
   xmdlseq                 INTEGER,         #项次
   xmdl008                 VARCHAR(40),         #料件编号
   xmdl021                 VARCHAR(10),         #计价单位
   xmdl022                 DECIMAL(20,6),         #计价数量
   xmdl025                 VARCHAR(10),         #税别
   xmdl030                 VARCHAR(20),         #专案编号
   xmdl031                 VARCHAR(30),         #WBS
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别 
   qq                      SMALLINT     #季别
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp310_tmp02;
   CREATE TEMP TABLE abgp310_tmp02(
   xmdksite                VARCHAR(10),        #营运据点
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别
   xmdk007                 VARCHAR(10),         #交易客户
   xmdk030                 VARCHAR(10),         #销售通路
   xmdl008                 VARCHAR(40),         #料件编号
   xmdl021                 VARCHAR(10),         #计价单位
   xmdl025                 VARCHAR(10),         #税别
   xmdl030                 VARCHAR(20),         #专案编号
   xmdl031                 VARCHAR(30),         #WBS
   xmdl022                 DECIMAL(20,6),         #计价数量 
   qty                     DECIMAL(20,6)     #根据期别资料分配方式重新计算的数量
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp310_tmp03;
   CREATE TEMP TABLE abgp310_tmp03(
   xmdksite                VARCHAR(10),        #营运据点
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别 
   xmdk007                 VARCHAR(10),         #交易客户
   xmdk030                 VARCHAR(10),         #销售通路
   xmdl008                 VARCHAR(40),         #料件编号
   xmdl021                 VARCHAR(10),         #计价单位
   xmdl025                 VARCHAR(10),         #税别
   xmdl030                 VARCHAR(20),         #专案编号
   xmdl031                 VARCHAR(30),         #WBS
   qty                     DECIMAL(20,6)     #根据期别资料分配方式重新计算的数量
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp310_tmp04;
   CREATE TEMP TABLE abgp310_tmp04(
   xmdadocno               VARCHAR(20),       #单号   
   xmdasite                VARCHAR(10),        #营运据点
   xmdadocdt               DATE,       #日期
   xmda004                 VARCHAR(10),         #交易客户
   xmda023                 VARCHAR(10),         #销售通路
   xmdcseq                 INTEGER,         #项次
   xmdc001                 VARCHAR(40),         #料件编号
   xmdc010                 VARCHAR(10),         #计价单位
   xmdc011                 DECIMAL(20,6),         #计价数量
   xmdc016                 VARCHAR(10),         #税别
   xmdc036                 VARCHAR(20),         #专案编号
   xmdc037                 VARCHAR(30),         #WBS
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别 
   qq                      SMALLINT     #季别
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF

   DROP TABLE abgp310_tmp05;
   CREATE TEMP TABLE abgp310_tmp05(
   xmdasite                VARCHAR(10),        #营运据点
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别
   xmda004                 VARCHAR(10),         #交易客户
   xmda023                 VARCHAR(10),         #销售通路
   xmdc001                 VARCHAR(40),         #料件编号
   xmdc010                 VARCHAR(10),         #计价单位
   xmdc016                 VARCHAR(10),         #税别
   xmdc036                 VARCHAR(20),         #专案编号
   xmdc037                 VARCHAR(30),         #WBS
   xmdc011                 DECIMAL(20,6),         #计价数量 
   qty                     DECIMAL(20,6)     #根据期别资料分配方式重新计算的数量
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   DROP TABLE abgp310_tmp06;
   CREATE TEMP TABLE abgp310_tmp06(
   xmdasite                VARCHAR(10),        #营运据点
   yy                      SMALLINT,            #年度
   mm                      SMALLINT,            #期别 
   xmda004                 VARCHAR(10),         #交易客户
   xmda023                 VARCHAR(10),         #销售通路
   xmdc001                 VARCHAR(40),         #料件编号
   xmdc010                 VARCHAR(10),         #计价单位
   xmdc016                 VARCHAR(10),         #税别
   xmdc036                 VARCHAR(20),         #专案编号
   xmdc037                 VARCHAR(30),         #WBS
   qty                     DECIMAL(20,6)     #根据期别资料分配方式重新计算的数量
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   
   #161215-00051#4--add--str--lujh
   DROP TABLE abgp310_tmp07;
   CREATE TEMP TABLE abgp310_tmp07(
   bgcj001               VARCHAR(10),      #來源作業
   bgcj002               VARCHAR(10),      #預算編號
   bgcj003               VARCHAR(10),      #版本
   bgcj004               VARCHAR(10),      #管理組織
   bgcj005               VARCHAR(10),      #銷售來源
   bgcj006               VARCHAR(10),      #資料類型
   bgcj007               VARCHAR(10),      #預算組織
   bgcj009               VARCHAR(40),      #預算料件
   bgcj010               VARCHAR(1000),      #組合KEY
   bgcjseq               INTEGER     #項次
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   #161215-00051#4--add--end--lujh
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 批处理逻辑
PRIVATE FUNCTION abgp310_p()
   DEFINE l_sql                 STRING
   DEFINE l_bgar002             LIKE bgar_t.bgar002
   DEFINE l_bgaa002             LIKE bgaa_t.bgaa002
   DEFINE l_bgac002             LIKE bgac_t.bgac002
   DEFINE l_wc                  STRING 
   DEFINE l_flag                LIKE type_t.chr1
   DEFINE l_success             LIKE type_t.num5
   
   #abgi010抓取预算周期编号
   LET l_bgaa002 = ''
   SELECT bgaa002 INTO l_bgaa002
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgcj002
      
   #抓取年度/期别/起始截止日期
   LET l_bgac002 = ''    LET g_year = ''
   SELECT bgac002 INTO l_bgac002
     FROM bgac_t
    WHERE bgacent = g_enterprise
      AND bgac001 = l_bgaa002
      AND rownum = 1
      
   LET g_year = YEAR(l_bgac002) - 1
   
   LET g_month_min = ''    LET g_month_max = ''
   SELECT MIN(bgac002),MAX(bgac002),
          MIN(bgac004),MAX(bgac004)
     INTO g_year_min,g_year_max,
          g_month_min,g_month_max
     FROM bgac_t
    WHERE bgacent = g_enterprise
      AND bgac001 = l_bgaa002
   
   #抓取前一年度的日期
   LET l_sql = "SELECT ADD_MONTHS(to_date('",g_year_min,"','YY/MM/DD'), - 12) FROM dual"    
   PREPARE abgp310_p_date_pre1 FROM l_sql
   EXECUTE abgp310_p_date_pre1 INTO g_year_min
   
   LET l_sql = "SELECT ADD_MONTHS(to_date('",g_year_max,"','YY/MM/DD'), - 12) FROM dual"    
   PREPARE abgp310_p_date_pre2 FROM l_sql
   EXECUTE abgp310_p_date_pre2 INTO g_year_max
   
   #先根据预算交易对象把实体交易对象抓出来
   LET l_wc = ''
   LET l_wc = cl_replace_str(g_wc,"bgcj016","bgar001")
   LET l_sql = "SELECT bgar002 FROM bgar_t ",
               " WHERE bgarent = ",g_enterprise,
               "   AND ",l_wc
   PREPARE abgp310_p_pre FROM l_sql
   DECLARE abgp310_p_cs CURSOR FOR abgp310_p_pre
   
   LET g_str_bgar002 = ''
   FOREACH abgp310_p_cs INTO l_bgar002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp310_p_cs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      
      IF cl_null(g_str_bgar002) THEN 
         LET g_str_bgar002 = "'",l_bgar002,"'"
      ELSE
         LET g_str_bgar002 = g_str_bgar002,",","'",l_bgar002,"'"
      END IF
   END FOREACH
   
   LET g_str_bgar002 = "(",g_str_bgar002,")"
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()

   #参考资料来源于出货单
   IF g_master.source = '1' THEN 
      CALL abgp310_p1() RETURNING l_success,l_flag
   END IF
   
   #参考资料来源于订单
   IF g_master.source = '2' THEN 
      CALL abgp310_p2() RETURNING l_success,l_flag
   END IF
   
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
END FUNCTION
# 参考资料来源于出货单
PRIVATE FUNCTION abgp310_p1()
   DEFINE l_sql                 STRING
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_wc1                 STRING
   DEFINE l_wc2                 STRING
   DEFINE l_xmdl022_tot         LIKE xmdl_t.xmdl022
   DEFINE l_bgci005             LIKE bgci_t.bgci005
   DEFINE l_bgci006             LIKE bgci_t.bgci006
   DEFINE l_qq                  LIKE type_t.num5
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_yy                  LIKE type_t.chr10
   DEFINE l_mm                  LIKE type_t.chr10
   DEFINE l_qty                 LIKE xmdl_t.xmdl022
   DEFINE l_year                LIKE type_t.num5 
   DEFINE l_n                   LIKE type_t.num5
   DEFINE l_bgaa010             LIKE bgaa_t.bgaa010
   DEFINE l_bgaa011             LIKE bgaa_t.bgaa011
   DEFINE l_bgaa003             LIKE bgaa_t.bgaa003
   DEFINE l_bgai002             LIKE bgai_t.bgai002
   DEFINE l_bgai006             LIKE bgai_t.bgai006
   DEFINE l_bgai008             LIKE bgai_t.bgai008
   DEFINE l_bgeb003             LIKE bgeb_t.bgeb003
   DEFINE l_pmab081             LIKE pmab_t.pmab081
   DEFINE l_pmab109             LIKE pmab_t.pmab109
   DEFINE l_ooeg004             LIKE ooeg_t.ooeg004
   DEFINE l_pmaa241             LIKE pmaa_t.pmaa241  
   DEFINE l_pmaa090             LIKE pmaa_t.pmaa090
   DEFINE l_pmaa092             LIKE pmaa_t.pmaa091
   DEFINE l_bgar001             LIKE bgar_t.bgar001
   DEFINE l_bgas009             LIKE bgas_t.bgas009
   DEFINE l_bgas010             LIKE bgas_t.bgas010
   DEFINE l_ooef019             LIKE ooef_t.ooef019
   DEFINE l_oodb005             LIKE oodb_t.oodb005
   DEFINE l_bgcb006             LIKE bgcb_t.bgcb006 
   DEFINE l_bgcb007             LIKE bgcb_t.bgcb007
   DEFINE l_bgca003             LIKE bgca_t.bgca003
   DEFINE l_xmdk001_max         LIKE xmdk_t.xmdk001
   DEFINE l_xmdl024_max         LIKE xmdl_t.xmdl024
   DEFINE l_xmdk016             LIKE xmdk_t.xmdk016
   DEFINE l_bgea013             LIKE bgea_t.bgea013
   DEFINE l_bgea014             LIKE bgea_t.bgea014
   DEFINE l_bgea004             LIKE bgea_t.bgea004
   DEFINE l_price               LIKE bgea_t.bgea020
   DEFINE r_xrcd113             LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114             LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115             LIKE xrcd_t.xrcd115
   DEFINE l_bgcjstus            LIKE bgcj_t.bgcjstus
   DEFINE l_site_str            STRING
   DEFINE l_message             STRING
   DEFINE l_comp                LIKE glaa_t.glaacomp
   DEFINE l_glaa003             LIKE glaa_t.glaa003
   DEFINE l_flag1               LIKE type_t.chr1
   DEFINE l_errno               LIKE type_t.chr100
   DEFINE l_glav002             LIKE glav_t.glav002
   DEFINE l_glav005             LIKE glav_t.glav005
   DEFINE l_sdate_s             LIKE glav_t.glav004
   DEFINE l_sdate_e             LIKE glav_t.glav004
   DEFINE l_glav006             LIKE glav_t.glav006
   DEFINE l_glav007             LIKE glav_t.glav007
   DEFINE l_pdate_s             LIKE glav_t.glav004
   DEFINE l_pdate_e             LIKE glav_t.glav004
   DEFINE l_wdate_s             LIKE glav_t.glav004
   DEFINE l_wdate_e             LIKE glav_t.glav004
   DEFINE l_tmp                 RECORD
                                xmdksite               LIKE xmdk_t.xmdksite,   #营运据点
                                yy                     LIKE type_t.num5,       #年度
                                mm                     LIKE type_t.num5,       #期别  
                                xmdk007                LIKE xmdk_t.xmdk007,    #交易客户
                                xmdk030                LIKE xmdk_t.xmdk030,    #销售通路
                                xmdl008                LIKE xmdl_t.xmdl008,    #料件编号
                                xmdl021                LIKE xmdl_t.xmdl021,    #计价单位
                                xmdl025                LIKE xmdl_t.xmdl025,    #税别
                                xmdl030                LIKE xmdl_t.xmdl030,    #专案编号
                                xmdl031                LIKE xmdl_t.xmdl031,    #WBS
                                xmdl022                LIKE xmdl_t.xmdl022,    #计价数量 
                                qty                    LIKE xmdl_t.xmdl022     #根据期别资料分配方式重新计算的数量                                
                                END RECORD 
   DEFINE l_tmp1                RECORD
                                xmdksite               LIKE xmdk_t.xmdksite,   #营运据点
                                yy                     LIKE type_t.num5,       #年度
                                mm                     LIKE type_t.num5,       #期别  
                                xmdk007                LIKE xmdk_t.xmdk007,    #交易客户
                                xmdk030                LIKE xmdk_t.xmdk030,    #销售通路
                                xmdl008                LIKE xmdl_t.xmdl008,    #料件编号
                                xmdl021                LIKE xmdl_t.xmdl021,    #计价单位
                                xmdl025                LIKE xmdl_t.xmdl025,    #税别
                                xmdl030                LIKE xmdl_t.xmdl030,    #专案编号
                                xmdl031                LIKE xmdl_t.xmdl031,    #WBS
                                qty                    LIKE xmdl_t.xmdl022     #根据期别资料分配方式重新计算的数量                                
                                END RECORD   
   DEFINE l_bgcj                RECORD  #銷售預算主檔
                                bgcjent                LIKE bgcj_t.bgcjent, #企業編號
                                bgcj001                LIKE bgcj_t.bgcj001, #來源作業
                                bgcj002                LIKE bgcj_t.bgcj002, #預算編號
                                bgcj003                LIKE bgcj_t.bgcj003, #版本
                                bgcj004                LIKE bgcj_t.bgcj004, #管理組織
                                bgcj005                LIKE bgcj_t.bgcj005, #銷售來源
                                bgcj006                LIKE bgcj_t.bgcj006, #資料類型
                                bgcj007                LIKE bgcj_t.bgcj007, #預算組織
                                bgcj008                LIKE bgcj_t.bgcj008, #預算期別
                                bgcj009                LIKE bgcj_t.bgcj009, #預算料件
                                bgcj010                LIKE bgcj_t.bgcj010, #組合KEY
                                bgcjseq                LIKE bgcj_t.bgcjseq, #項次
                                bgcj011                LIKE bgcj_t.bgcj011, #預算樣表
                                bgcj012                LIKE bgcj_t.bgcj012, #人員
                                bgcj013                LIKE bgcj_t.bgcj013, #部門
                                bgcj014                LIKE bgcj_t.bgcj014, #成本利潤中心
                                bgcj015                LIKE bgcj_t.bgcj015, #區域
                                bgcj016                LIKE bgcj_t.bgcj016, #收付款客商
                                bgcj017                LIKE bgcj_t.bgcj017, #帳款客商
                                bgcj018                LIKE bgcj_t.bgcj018, #客群
                                bgcj019                LIKE bgcj_t.bgcj019, #產品類別
                                bgcj020                LIKE bgcj_t.bgcj020, #專案編號
                                bgcj021                LIKE bgcj_t.bgcj021, #WBS
                                bgcj022                LIKE bgcj_t.bgcj022, #經營方式
                                bgcj023                LIKE bgcj_t.bgcj023, #通路
                                bgcj024                LIKE bgcj_t.bgcj024, #品牌
                                bgcj025                LIKE bgcj_t.bgcj025, #自由核算項一
                                bgcj026                LIKE bgcj_t.bgcj026, #自由核算項二
                                bgcj027                LIKE bgcj_t.bgcj027, #自由核算項三
                                bgcj028                LIKE bgcj_t.bgcj028, #自由核算項四
                                bgcj029                LIKE bgcj_t.bgcj029, #自由核算項五
                                bgcj030                LIKE bgcj_t.bgcj030, #自由核算項六
                                bgcj031                LIKE bgcj_t.bgcj031, #自由核算項七
                                bgcj032                LIKE bgcj_t.bgcj032, #自由核算項八
                                bgcj033                LIKE bgcj_t.bgcj033, #自由核算項九
                                bgcj034                LIKE bgcj_t.bgcj034, #自由核算項十
                                bgcj035                LIKE bgcj_t.bgcj035, #稅別
                                bgcj036                LIKE bgcj_t.bgcj036, #含稅否
                                bgcj037                LIKE bgcj_t.bgcj037, #銷售單位
                                bgcj038                LIKE bgcj_t.bgcj038, #交易數量
                                bgcj039                LIKE bgcj_t.bgcj039, #單價
                                bgcj040                LIKE bgcj_t.bgcj040, #原幣銷售金額
                                bgcj041                LIKE bgcj_t.bgcj041, #本層調整數量
                                bgcj042                LIKE bgcj_t.bgcj042, #本層調整單價
                                bgcj043                LIKE bgcj_t.bgcj043, #上層調整數量
                                bgcj044                LIKE bgcj_t.bgcj044, #上層調整單價
                                bgcj045                LIKE bgcj_t.bgcj045, #核准數量
                                bgcj046                LIKE bgcj_t.bgcj046, #核准單價
                                bgcj047                LIKE bgcj_t.bgcj047, #上層組織
                                bgcj048                LIKE bgcj_t.bgcj048, #憑證單號
                                bgcj049                LIKE bgcj_t.bgcj049, #預算細項
                                bgcj050                LIKE bgcj_t.bgcj050, #編製起點
                                bgcj051                LIKE bgcj_t.bgcj051, #生產預算拋轉否
                                bgcj052                LIKE bgcj_t.bgcj052, #內部採購組織
                                bgcj053                LIKE bgcj_t.bgcj053, #內部採購預算細項
                                bgcj100                LIKE bgcj_t.bgcj100, #交易幣別
                                bgcj101                LIKE bgcj_t.bgcj101, #匯率
                                bgcj102                LIKE bgcj_t.bgcj102, #核准原幣銷售金額
                                bgcj103                LIKE bgcj_t.bgcj103, #核准原幣未稅金額
                                bgcj104                LIKE bgcj_t.bgcj104, #核准原幣稅額
                                bgcj105                LIKE bgcj_t.bgcj105, #核准原幣含稅金額
                                bgcjownid              LIKE bgcj_t.bgcjownid, #資料所有者
                                bgcjowndp              LIKE bgcj_t.bgcjowndp, #資料所屬部門
                                bgcjcrtid              LIKE bgcj_t.bgcjcrtid, #資料建立者
                                bgcjcrtdp              LIKE bgcj_t.bgcjcrtdp, #資料建立部門
                                bgcjcrtdt              LIKE bgcj_t.bgcjcrtdt, #資料創建日
                                bgcjmodid              LIKE bgcj_t.bgcjmodid, #資料修改者
                                bgcjmoddt              LIKE bgcj_t.bgcjmoddt, #最近修改日
                                bgcjcnfid              LIKE bgcj_t.bgcjcnfid, #資料確認者
                                bgcjcnfdt              LIKE bgcj_t.bgcjcnfdt, #資料確認日
                                bgcjstus               LIKE bgcj_t.bgcjstus, #狀態碼
                                bgcjud001              LIKE bgcj_t.bgcjud001, #自定義欄位(文字)001
                                bgcjud002              LIKE bgcj_t.bgcjud002, #自定義欄位(文字)002
                                bgcjud003              LIKE bgcj_t.bgcjud003, #自定義欄位(文字)003
                                bgcjud004              LIKE bgcj_t.bgcjud004, #自定義欄位(文字)004
                                bgcjud005              LIKE bgcj_t.bgcjud005, #自定義欄位(文字)005
                                bgcjud006              LIKE bgcj_t.bgcjud006, #自定義欄位(文字)006
                                bgcjud007              LIKE bgcj_t.bgcjud007, #自定義欄位(文字)007
                                bgcjud008              LIKE bgcj_t.bgcjud008, #自定義欄位(文字)008
                                bgcjud009              LIKE bgcj_t.bgcjud009, #自定義欄位(文字)009
                                bgcjud010              LIKE bgcj_t.bgcjud010, #自定義欄位(文字)010
                                bgcjud011              LIKE bgcj_t.bgcjud011, #自定義欄位(數字)011
                                bgcjud012              LIKE bgcj_t.bgcjud012, #自定義欄位(數字)012
                                bgcjud013              LIKE bgcj_t.bgcjud013, #自定義欄位(數字)013
                                bgcjud014              LIKE bgcj_t.bgcjud014, #自定義欄位(數字)014
                                bgcjud015              LIKE bgcj_t.bgcjud015, #自定義欄位(數字)015
                                bgcjud016              LIKE bgcj_t.bgcjud016, #自定義欄位(數字)016
                                bgcjud017              LIKE bgcj_t.bgcjud017, #自定義欄位(數字)017
                                bgcjud018              LIKE bgcj_t.bgcjud018, #自定義欄位(數字)018
                                bgcjud019              LIKE bgcj_t.bgcjud019, #自定義欄位(數字)019
                                bgcjud020              LIKE bgcj_t.bgcjud020, #自定義欄位(數字)020
                                bgcjud021              LIKE bgcj_t.bgcjud021, #自定義欄位(日期時間)021
                                bgcjud022              LIKE bgcj_t.bgcjud022, #自定義欄位(日期時間)022
                                bgcjud023              LIKE bgcj_t.bgcjud023, #自定義欄位(日期時間)023
                                bgcjud024              LIKE bgcj_t.bgcjud024, #自定義欄位(日期時間)024
                                bgcjud025              LIKE bgcj_t.bgcjud025, #自定義欄位(日期時間)025
                                bgcjud026              LIKE bgcj_t.bgcjud026, #自定義欄位(日期時間)026
                                bgcjud027              LIKE bgcj_t.bgcjud027, #自定義欄位(日期時間)027
                                bgcjud028              LIKE bgcj_t.bgcjud028, #自定義欄位(日期時間)028
                                bgcjud029              LIKE bgcj_t.bgcjud029, #自定義欄位(日期時間)029
                                bgcjud030              LIKE bgcj_t.bgcjud030  #自定義欄位(日期時間)030
                                END RECORD 
   #161215-00051#4--add--str--lujh
   DEFINE l_bgcj1               RECORD  #銷售預算主檔
                                bgcj001                LIKE bgcj_t.bgcj001, #來源作業
                                bgcj002                LIKE bgcj_t.bgcj002, #預算編號
                                bgcj003                LIKE bgcj_t.bgcj003, #版本
                                bgcj004                LIKE bgcj_t.bgcj004, #管理組織
                                bgcj005                LIKE bgcj_t.bgcj005, #銷售來源
                                bgcj006                LIKE bgcj_t.bgcj006, #資料類型
                                bgcj007                LIKE bgcj_t.bgcj007, #預算組織
                                bgcj009                LIKE bgcj_t.bgcj009, #預算料件
                                bgcj010                LIKE bgcj_t.bgcj010, #組合KEY
                                bgcjseq                LIKE bgcj_t.bgcjseq  #項次
                                END RECORD
   #161215-00051#4--add--end--lujh                                
   DEFINE l_bgal                RECORD
                                bgal005     LIKE bgal_t.bgal005,
                                bgal006     LIKE bgal_t.bgal006,
                                bgal007     LIKE bgal_t.bgal007,
                                bgal008     LIKE bgal_t.bgal008,
                                bgal009     LIKE bgal_t.bgal009,
                                bgal010     LIKE bgal_t.bgal010,
                                bgal011     LIKE bgal_t.bgal011,
                                bgal012     LIKE bgal_t.bgal012,
                                bgal013     LIKE bgal_t.bgal013,
                                bgal014     LIKE bgal_t.bgal014,
                                bgal025     LIKE bgal_t.bgal025,
                                bgal026     LIKE bgal_t.bgal026,
                                bgal027     LIKE bgal_t.bgal027
                                END RECORD                                
   DEFINE r_flag                LIKE type_t.chr1
   DEFINE r_success             LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_flag = 'N'
   LET l_success = TRUE
   
   INITIALIZE l_tmp.* TO NULL
   DELETE FROM abgp310_tmp01;
   DELETE FROM abgp310_tmp02;
   DELETE FROM abgp310_tmp03;
   DELETE FROM abgp310_tmp07;    #161215-00051#4 add lujh
   
   #abgi010预算组织版本/最上层组织/预算币别
   LET l_bgaa010 = ''     LET l_bgaa011 = ''
   LET l_bgaa003 = ''
   SELECT bgaa010,bgaa011,bgaa003 INTO l_bgaa010,l_bgaa011,l_bgaa003
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgcj002
   
   LET l_wc1 = ''    LET l_wc2 = ''
   LET l_wc1 = cl_replace_str(g_master.wc,"bgcj007","xmdksite")
   LET l_wc2 = cl_replace_str(g_wc,"bgcj016","xmdk007")
   
   CALL s_abg2_get_site(g_master.bgcj002,l_bgaa011,'01') RETURNING l_site_str
   LET l_wc1 = l_wc1," AND ooef001 IN ",l_site_str
   LET l_wc1 = cl_replace_str(l_wc1,"ooef001","xmdksite")
   
   #抓取出货单/出货签收单
   LET l_sql = "INSERT INTO abgp310_tmp01 ",
               "SELECT xmdkdocno,xmdksite,xmdk001,xmdk007,xmdk030,",
               "       xmdlseq,xmdl008,xmdl021,xmdl022,xmdl025,",
               "       xmdl030,xmdl031,TO_CHAR(xmdk001,'YYYY'),TO_CHAR(xmdk001,'MM'), ",
               "       TO_CHAR(xmdk001,'q') ",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               "   AND xmdk001 BETWEEN '",g_year_min,"' AND '",g_year_max,"'",
               #出货单
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1')",
               #出货签收单
               "    OR ( xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               " ORDER BY xmdk001,xmdkdocno,xmdlseq"
   PREPARE abgp310_p1_pre FROM l_sql
   EXECUTE abgp310_p1_pre

   #将资料按期别汇总
   LET l_sql = "INSERT INTO abgp310_tmp02 ",
               "SELECT DISTINCT xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
               "                xmdl021,xmdl025,xmdl030,xmdl031,SUM(xmdl022),''",
               "  FROM abgp310_tmp01 ",
               " GROUP BY xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
               "          xmdl021,xmdl025,xmdl030,xmdl031 ",
               " ORDER BY xmdksite,xmdl008,yy,mm"
   PREPARE abgp310_p1_pre1 FROM l_sql
   EXECUTE abgp310_p1_pre1 
   
   #根据期别分配方式重新计算数量
   LET l_sql = "SELECT DISTINCT xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
               "                xmdl021,xmdl025,xmdl030,xmdl031,xmdl022,'' ",
               "  FROM abgp310_tmp02 ",
               " ORDER BY xmdksite,xmdl008,yy,mm"
   PREPARE abgp310_p1_pre2 FROM l_sql
   DECLARE abgp310_p1_cs2 CURSOR FOR abgp310_p1_pre2
   
   #根据期别分配方式重新计算数量
   IF g_master.c = '1' THEN 
      UPDATE abgp310_tmp02 SET qty = xmdl022
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd abgp310_tmp02'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   ELSE
      FOREACH abgp310_p1_cs2 INTO l_tmp.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp310_p1_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
             
            LET r_success = FALSE
         END IF
         
         #抓取此料件全年的总量
         LET l_xmdl022_tot = 0
         SELECT SUM(xmdl022) INTO l_xmdl022_tot
           FROM abgp310_tmp02
          WHERE xmdksite = l_tmp.xmdksite
            AND xmdk007  = l_tmp.xmdk007
            AND xmdk030  = l_tmp.xmdk030
            AND xmdl008  = l_tmp.xmdl008
            AND xmdl021  = l_tmp.xmdl021
            AND xmdl025  = l_tmp.xmdl025
            AND xmdl030  = l_tmp.xmdl030
            AND xmdl031  = l_tmp.xmdl031
            AND yy       = l_tmp.yy
            
         IF cl_null(l_xmdl022_tot) THEN LET l_xmdl022_tot = 0 END IF
         
         #抓取abgi370的设置
         LET l_bgci006 = ''
         SELECT DISTINCT bgci006 INTO l_bgci006
           FROM bgci_t
          WHERE bgcient = g_enterprise
            AND bgci001 = g_master.bgcj002
            AND bgci002 = g_master.bgcj003
            AND bgci003 = l_tmp.xmdksite
            
         #依期别         
         IF l_bgci006 = '1' THEN 
            LET l_bgci005 = 0
            SELECT bgci005 INTO l_bgci005
              FROM bgci_t
             WHERE bgcient = g_enterprise
               AND bgci001 = g_master.bgcj002
               AND bgci002 = g_master.bgcj003
               AND bgci003 = l_tmp.xmdksite
               AND bgci004 = l_tmp.mm
         
            LET l_tmp.qty = l_xmdl022_tot * l_bgci005 / 100
         ELSE
            #依季别
            #先看下当前月份是第几季
            SELECT DISTINCT qq INTO l_qq
              FROM abgp310_tmp01
             WHERE mm = l_tmp.mm
             
            LET l_bgci005 = 0
            SELECT bgci005 INTO l_bgci005
              FROM bgci_t
             WHERE bgcient = g_enterprise
               AND bgci001 = g_master.bgcj002
               AND bgci002 = g_master.bgcj003
               AND bgci003 = l_tmp.xmdksite
               AND bgci004 = l_qq
            
            #计算每个季度的数量再平均分配            
            LET l_tmp.qty = l_xmdl022_tot * l_bgci005 / 100 / 3
         END IF    

         UPDATE abgp310_tmp02 SET qty = l_tmp.qty
          WHERE xmdksite = l_tmp.xmdksite
            AND xmdk007  = l_tmp.xmdk007
            AND xmdk030  = l_tmp.xmdk030
            AND xmdl008  = l_tmp.xmdl008
            AND xmdl021  = l_tmp.xmdl021
            AND xmdl025  = l_tmp.xmdl025
            AND xmdl030  = l_tmp.xmdl030
            AND xmdl031  = l_tmp.xmdl031 
            AND yy       = l_tmp.yy
            AND mm       = l_tmp.mm
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'upd abgp310_tmp02'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
         INITIALIZE l_tmp.* TO NULL
      END FOREACH
   END IF
   
   #根据未来期选项重新计算最后一期年月之后月份的数量
   #ex:最后一期年月输入201610,那2016 11 12月份的重新计算
   INITIALIZE l_tmp1.* TO NULL
   LET l_sql = "SELECT DISTINCT xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
               "                xmdl021,xmdl025,xmdl030,xmdl031,qty ",
               "  FROM abgp310_tmp02 ",
               " WHERE mm = ? "
   PREPARE abgp310_p1_pre3 FROM l_sql
   DECLARE abgp310_p1_cs3 CURSOR FOR abgp310_p1_pre3
   
   #抓取前一年度当前期别的数量
   LET l_sql = "SELECT SUM(xmdl022)",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               #出货单
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1')",
               #出货签收单
               "    OR ( xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND to_char('xmdk001','YYYY') = ? ",
               "   AND to_char('xmdk001','MM') = ? ",
               "   AND xmdksite = ? ",
               "   AND xmdk007  = ? ",
               "   AND (xmdk030  = ? OR xmdk030 IS NULL)",
               "   AND xmdl008  = ? ",
               "   AND xmdl021  = ? ",
               "   AND xmdl025  = ? ",
               "   AND (xmdl030  = ? OR xmdl030 IS NULL)",
               "   AND (xmdl031  = ? OR xmdl031 IS NULL)"
   PREPARE abgp310_p1_pre4 FROM l_sql

   #依实际最后一期/依前年度同期别实际数,不管2016 11 12月份是否有值,重新抓
   IF g_master.b MATCHES '[12]' THEN 
      LET l_yy = g_master.date[1,4]
      LET l_mm = g_master.date[5,6]
      
      FOR l_i = l_mm + 1 TO g_month_max   
         FOREACH abgp310_p1_cs3 USING l_i INTO l_tmp1.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p1_cs3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
                
               LET r_success = FALSE
            END IF
            
            #将之后月份的资料删掉重新抓取
            DELETE FROM abgp310_tmp02 
             WHERE xmdksite = l_tmp1.xmdksite
               AND xmdk007  = l_tmp1.xmdk007
               AND xmdk030  = l_tmp1.xmdk030
               AND xmdl008  = l_tmp1.xmdl008
               AND xmdl021  = l_tmp1.xmdl021
               AND xmdl025  = l_tmp1.xmdl025
               AND xmdl030  = l_tmp1.xmdl030
               AND xmdl031  = l_tmp1.xmdl031 
               AND yy       = l_tmp1.yy
               AND mm       = l_tmp1.mm 
               
            #依实际最后一期时,抓最后一期年月的资料
            IF g_master.b = '1' THEN 
               SELECT qty INTO l_qty
                 FROM abgp310_tmp02 
                WHERE xmdksite = l_tmp1.xmdksite
                  AND xmdk007  = l_tmp1.xmdk007
                  AND xmdk030  = l_tmp1.xmdk030
                  AND xmdl008  = l_tmp1.xmdl008
                  AND xmdl021  = l_tmp1.xmdl021
                  AND xmdl025  = l_tmp1.xmdl025
                  AND xmdl030  = l_tmp1.xmdl030
                  AND xmdl031  = l_tmp1.xmdl031 
                  AND yy       = l_tmp1.yy
                  AND mm       = l_mm 
               
               IF cl_null(l_qty) THEN 
                  LET l_qty = 0
               END IF
                
               LET l_tmp1.qty = l_qty
               
               INSERT INTO abgp310_tmp03 VALUES(l_tmp1.*)
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp310_tmp03'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF               
            END IF
            
            #依前年度同期别实际数,抓前一年当前期的资料
            IF g_master.b = '2' THEN
               LET l_year =  l_tmp1.yy -1           
               EXECUTE abgp310_p1_pre4 USING l_year,l_i,l_tmp1.xmdksite,l_tmp1.xmdk007,
                                             l_tmp1.xmdk030,l_tmp1.xmdl008,l_tmp1.xmdl021,
                                             l_tmp1.xmdl025,l_tmp1.xmdl030,l_tmp1.xmdl031 
                                        INTO l_qty
               IF cl_null(l_qty) THEN 
                  LET l_qty = 0
               END IF               
               
               LET l_tmp1.qty = l_qty
               
               INSERT INTO abgp310_tmp03 VALUES(l_tmp1.*)
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp310_tmp03'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF                                        
            END IF
            
            INITIALIZE l_tmp1.* TO NULL
         END FOREACH
      END FOR
      
      #将最后一期年月之前月份的资料也插进临时表
      LET l_sql = "INSERT INTO abgp310_tmp03 ",
                  "SELECT xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
                  "       xmdl021,xmdl025,xmdl030,xmdl031,qty ",
                  "  FROM abgp310_tmp02 ",
                  " WHERE mm BETWEEN 1 AND ",l_mm
      PREPARE abgp310_p1_pre5 FROM l_sql
      EXECUTE abgp310_p1_pre5
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins abgp310_tmp03'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   ELSE
      #无未来期,不重新计算数量
      LET l_sql = "INSERT INTO abgp310_tmp03 ",
                  "SELECT xmdksite,yy,mm,xmdk007,xmdk030,xmdl008,",
                  "       xmdl021,xmdl025,xmdl030,xmdl031,qty ",
                  "  FROM abgp310_tmp02 "
      PREPARE abgp310_p1_pre6 FROM l_sql
      EXECUTE abgp310_p1_pre6 
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins abgp310_tmp03'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   END IF
   
   #开始往abgt340塞资料
   INITIALIZE l_tmp1.* TO NULL
   LET l_sql = "SELECT * FROM abgp310_tmp03 "
   PREPARE abgp310_p1_pre7 FROM l_sql
   DECLARE abgp310_p1_cs7 CURSOR FOR abgp310_p1_pre7
   
   #abgi320抓取数量影响因子,影响百分比/影响数量/影响方式
   LET l_sql = "SELECT DISTINCT bgcb006,bgcb007,bgca003 ",
               "  FROM bgcb_t,bgca_t ",
               " WHERE bgcbent = ",g_enterprise,
               "   AND bgcbent = bgcaent ",
               "   AND bgcb004 = bgca001 ",
               "   AND bgca002 = '1' ",
               "   AND bgcb001 = '",g_master.bgcj002,"'",
               "   AND bgcb002 = ? ",
               "   AND bgcb008 = ? ",
               "   AND bgcb005 = ? ",
               "   AND bgcb010 = '1' "
   PREPARE abgp310_p1_pre8 FROM l_sql
   DECLARE abgp310_p1_cs8 CURSOR FOR abgp310_p1_pre8 
   
   #abgi320抓取单价影响因子,影响百分比/影响数量/影响方式
   LET l_sql = "SELECT DISTINCT bgcb006,bgcb007,bgca003 ",
               "  FROM bgcb_t,bgca_t ",
               " WHERE bgcbent = ",g_enterprise,
               "   AND bgcbent = bgcaent ",
               "   AND bgcb004 = bgca001 ",
               "   AND bgca002 = '2' ",
               "   AND bgcb001 = '",g_master.bgcj002,"'",
               "   AND bgcb002 = ? ",
               "   AND bgcb008 = ? ",
               "   AND bgcb005 = ? ",
               "   AND bgcb010 = '1' "
   PREPARE abgp310_p1_pre9 FROM l_sql
   DECLARE abgp310_p1_cs9 CURSOR FOR abgp310_p1_pre9
   
   #抓取最大日期
   LET l_sql = "SELECT MAX(xmdk001)",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               #出货单
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1')",
               #出货签收单
               "    OR ( xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdksite = ? ",
               "   AND xmdk007  = ? ",
               "   AND (xmdk030  = ? OR xmdk030 IS NULL)",
               "   AND xmdl008  = ? ",
               "   AND xmdl021  = ? ",
               "   AND xmdl025  = ? ",
               "   AND (xmdl030  = ? OR xmdl030 IS NULL)",
               "   AND (xmdl031  = ? OR xmdl031 IS NULL)"
   PREPARE abgp310_p1_pre10 FROM l_sql
   
   #抓取最大单价
   LET l_sql = "SELECT MAX(xmdl024)",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               #出货单
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1')",
               #出货签收单
               "    OR ( xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdk001  = ? ",
               "   AND xmdksite = ? ",
               "   AND xmdk007  = ? ",
               "   AND (xmdk030  = ? OR xmdk030 IS NULL)",
               "   AND xmdl008  = ? ",
               "   AND xmdl021  = ? ",
               "   AND xmdl025  = ? ",
               "   AND (xmdl030  = ? OR xmdl030 IS NULL)",
               "   AND (xmdl031  = ? OR xmdl031 IS NULL)"
   PREPARE abgp310_p1_pre11 FROM l_sql
   
   #抓取币别
   LET l_sql = "SELECT xmdk016",
               "  FROM xmdk_t,xmdl_t ",
               " WHERE xmdkent = ",g_enterprise,
               "   AND xmdkent = xmdlent ",
               "   AND xmdkdocno = xmdldocno ",
               #出货单
               "   AND ((xmdk000 IN ('1', '2', '3') AND xmdkstus = 'S' AND xmdk002 = '1')",
               #出货签收单
               "    OR ( xmdk000 = '4' AND xmdkstus = 'Y' AND xmdk002 = '3')) ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdk001  = ? ",
               "   AND xmdksite = ? ",
               "   AND xmdk007  = ? ",
               "   AND (xmdk030  = ? OR xmdk030 IS NULL)",
               "   AND xmdl008  = ? ",
               "   AND xmdl021  = ? ",
               "   AND xmdl024  = ? ",
               "   AND xmdl025  = ? ",
               "   AND (xmdl030  = ? OR xmdl030 IS NULL)",
               "   AND (xmdl031  = ? OR xmdl031 IS NULL)"
   PREPARE abgp310_p1_pre12 FROM l_sql

   IF g_master.a = 'Y' THEN  
      LET l_sql = "DELETE FROM bgcj_t ",
                  " WHERE bgcjent = ",g_enterprise,
                  "   AND bgcj002 = '",g_master.bgcj002,"'",
                  "   AND bgcj003 = '",g_master.bgcj003,"'",
                  "   AND bgcj005 = '1' ",
                  "   AND bgcj006 = '1' ",
                  "   AND bgcj007 IN (SELECT DISTINCT xmdksite FROM abgp310_tmp03) ",
                  "   AND bgcjstus = 'N' "                  
      PREPARE abgp310_p1_del_pre FROM l_sql
      EXECUTE abgp310_p1_del_pre      
   END IF

   FOREACH abgp310_p1_cs7 INTO l_tmp1.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp310_p1_cs7'
         LET g_errparam.popup = TRUE
         CALL cl_err()
          
         LET r_success = FALSE
      END IF
      
      #abgi090预算管理组织/样表编号/可编制预算细项
      LET l_bgai002 = ' '     LET l_bgai008 = ''
      LET l_bgai006 = ''
      SELECT DISTINCT bgai002,bgai008,bgai006 INTO l_bgai002,l_bgai008,l_bgai006
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = g_master.bgcj002
         AND bgai003 = g_user
         AND bgai004 = l_tmp1.xmdksite
         AND bgai005 IN ('01','ALL')
         AND ROWNUM = 1
         
      IF cl_null(l_bgai002) THEN LET l_bgai002 = ' ' END IF
         
      #抓取預算料件
      LET l_bgeb003 = ''
      SELECT bgeb003 INTO l_bgeb003
        FROM bgeb_t
       WHERE bgebent = g_enterprise
         AND bgeb001 = g_master.bgcj002
         AND bgeb002 = l_tmp1.xmdksite
         AND bgeb004 = l_tmp1.xmdl008 
         
      IF cl_null(l_bgeb003) THEN 
         LET l_bgeb003 = ' '
      END IF
      
      #人员/部门   
      LET l_pmab081 = ''    LET l_pmab109 = ''    
      SELECT pmab081,pmab109 INTO l_pmab081,l_pmab109
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = l_tmp1.xmdksite
         AND pmab001 = l_tmp1.xmdk007 
         
      #成本利润中心
      LET l_ooeg004 = ''               
      SELECT ooeg004 INTO l_ooeg004
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_pmab109
         
      #区域/客群/经营方式
      LET l_pmaa241 = ''    LET l_pmaa090 = ''
      LET l_pmaa092 = ''
      SELECT pmaa241,pmaa090,pmaa092 INTO l_pmaa241,l_pmaa090,l_pmaa092
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = l_tmp1.xmdk007
         
      #abgi150预算交易对象
      LET l_bgar001 = ''
      SELECT bgar001 INTO l_bgar001
        FROM bgar_t
       WHERE bgarent = g_enterprise
         AND bgar002 = l_tmp1.xmdk007
         
      #abgi165产品分类/厂牌
      LET l_bgas009 = ''    LET l_bgas010 = ''   
      SELECT bgas009,bgas010 INTO l_bgas009,l_bgas010
        FROM bgas_t
       WHERE bgasent = g_enterprise
         AND bgas001 = l_bgeb003
         
      #抓取税区
      LET l_ooef019 = ''
      SELECT ooef019 INTO l_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_tmp1.xmdksite

      #含税否
      LET l_oodb005 = ''
      SELECT oodb005 INTO l_oodb005
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = l_ooef019
         AND oodb002 = l_tmp1.xmdl025
       
      #abgi170       
      LET l_bgea013 = ''    LET l_bgea014 = ''
      SELECT bgea013,bgea014,bgea004
        INTO l_bgea013,l_bgea014,l_bgea004
        FROM bgea_t
       WHERE bgeaent = g_enterprise
         AND bgea001 = g_master.bgcj002
         AND bgea002 = l_tmp1.xmdksite
         AND bgea003 = l_bgeb003
         
      #若期别资料分配方式 = 依参考资料期别,则数量要考虑变动因子abgi320
      IF g_master.c = '1' THEN 
         FOREACH abgp310_p1_cs8 USING l_tmp1.xmdksite,l_bgeb003,l_tmp1.mm 
                                 INTO l_bgcb006,l_bgcb007,l_bgca003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p1_cs8'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
                  
            LET l_qty = ''                  
            #变动率
            IF l_bgca003 = '1' THEN 
               IF cl_null(l_qty) THEN 
                  LET l_qty = l_tmp1.qty * l_bgcb006/100
               ELSE
                  LET l_qty = l_qty + l_tmp1.qty * l_bgcb006/100
               END IF
            END IF
            #变动量
            IF l_bgca003 = '2' THEN 
               IF cl_null(l_qty) THEN 
                  LET l_qty = l_bgcb007
               ELSE
                  LET l_qty = l_qty + l_bgcb007
               END IF
            END IF       
         END FOREACH
      END IF
      
      IF cl_null(l_qty) THEN LET l_qty = 0 END IF
      
      #取价方式
      #最后一期资料,同一料件第1期到录入的最后一期年月,抓取存在资料的最大日期,然后抓最大日期的最大单价
      IF g_master.d = '1' THEN 
         IF cl_null(g_master.date) THEN 
            LET l_yy = l_tmp1.yy
            LET l_mm = g_month_max
         END IF
         #抓取最大日期
         EXECUTE abgp310_p1_pre10 USING l_tmp1.xmdksite,l_tmp1.xmdk007,
                                        l_tmp1.xmdk030,l_tmp1.xmdl008,l_tmp1.xmdl021,
                                        l_tmp1.xmdl025,l_tmp1.xmdl030,l_tmp1.xmdl031
                                   INTO l_xmdk001_max
         #抓取最大单价                       
         EXECUTE abgp310_p1_pre11 USING l_xmdk001_max,l_tmp1.xmdksite,l_tmp1.xmdk007,
                                        l_tmp1.xmdk030,l_tmp1.xmdl008,l_tmp1.xmdl021,
                                        l_tmp1.xmdl025,l_tmp1.xmdl030,l_tmp1.xmdl031
                                   INTO l_xmdl024_max 
                                 
         #抓取币别                  
         EXECUTE abgp310_p1_pre12 USING l_xmdk001_max,l_tmp1.xmdksite,l_tmp1.xmdk007,
                                        l_tmp1.xmdk030,l_tmp1.xmdl008,l_tmp1.xmdl021,
                                        l_xmdl024_max,l_tmp1.xmdl025,l_tmp1.xmdl030,
                                        l_tmp1.xmdl031
                                   INTO l_xmdk016
         LET l_bgcj.bgcj039 = l_xmdl024_max
         LET l_bgcj.bgcj100 = l_xmdk016
      ELSE
         #标准售价abgi170
         LET l_bgcj.bgcj039 = l_bgea014
         LET l_bgcj.bgcj100 = l_bgea013
      END IF
      
      SELECT ooef017 INTO l_comp 
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_tmp1.xmdksite
         
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_comp
         AND glaa014 = 'Y'      

      LET l_year = l_tmp1.yy + 1
      CALL s_get_accdate(l_glaa003,'',l_year,l_tmp1.mm) 
      RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      
      IF NOT cl_null(l_bgcj.bgcj100) AND NOT cl_null(l_bgaa003) THEN 
         CALL s_abg_get_bg_rate(g_master.bgcj002,l_pdate_e,l_bgcj.bgcj100,l_bgaa003)
         RETURNING l_bgcj.bgcj101
      ELSE
         LET l_bgcj.bgcj101 = 1
      END IF
      
      #单价考虑变动因子
      #若期别资料分配方式 = 依参考资料期别,则数量要考虑变动因子abgi320
      IF g_master.e = 'Y' THEN 
         FOREACH abgp310_p1_cs9 USING l_tmp1.xmdksite,l_bgeb003,l_tmp1.mm 
                                 INTO l_bgcb006,l_bgcb007,l_bgca003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p1_cs9'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
                  
            LET l_price = ''                  
            #变动率
            IF l_bgca003 = '1' THEN 
               IF cl_null(l_price) THEN 
                  LET l_price = l_bgcj.bgcj039 * l_bgcb006/100
               ELSE
                  LET l_price = l_price + l_bgcj.bgcj039 * l_bgcb006/100
               END IF
            END IF
            #变动量
            IF l_bgca003 = '2' THEN 
               IF cl_null(l_price) THEN 
                  LET l_price = l_bgcb007
               ELSE
                  LET l_price = l_price + l_bgcb007
               END IF
            END IF       
         END FOREACH
         IF NOT cl_null(l_price) THEN 
            LET l_bgcj.bgcj039 = l_bgcj.bgcj039 + l_price
         END IF
      END IF

      LET l_bgcj.bgcjent = g_enterprise
      IF g_master.f = '1' THEN 
         LET l_bgcj.bgcj001 = '10'
      ELSE
         LET l_bgcj.bgcj001 = '20'
      END IF
      LET l_bgcj.bgcj002 = g_master.bgcj002
      LET l_bgcj.bgcj003 = g_master.bgcj003
      LET l_bgcj.bgcj004 = l_bgai002
      LET l_bgcj.bgcj005 = '1'
      LET l_bgcj.bgcj006 = '1'
      LET l_bgcj.bgcj007 = l_tmp1.xmdksite
      LET l_bgcj.bgcj008 = l_tmp1.mm
      LET l_bgcj.bgcj009 = l_bgeb003
      LET l_bgcj.bgcj011 = l_bgai008
      LET l_bgcj.bgcj012 = l_pmab081
      LET l_bgcj.bgcj013 = l_pmab109
      LET l_bgcj.bgcj014 = l_ooeg004
      LET l_bgcj.bgcj015 = l_pmaa241
      LET l_bgcj.bgcj016 = l_bgar001
      LET l_bgcj.bgcj017 = l_bgar001
      LET l_bgcj.bgcj018 = l_pmaa090
      LET l_bgcj.bgcj019 = l_bgas009
      LET l_bgcj.bgcj020 = l_tmp1.xmdl030
      LET l_bgcj.bgcj021 = l_tmp1.xmdl031
      LET l_bgcj.bgcj022 = l_pmaa092
      LET l_bgcj.bgcj023 = l_tmp1.xmdk030
      LET l_bgcj.bgcj024 = l_bgas010
      
      #abgi110设置
      INITIALIZE l_bgal.* TO NULL
      CALL abgp310_get_bgal(g_master.bgcj002,l_tmp1.xmdksite,l_bgai006) RETURNING l_bgal.*
      
      #人员
      IF l_bgal.bgal012 = 'N' THEN 
         LET l_bgcj.bgcj012 = ' '
      END IF
      
      #部门
      IF l_bgal.bgal005 = 'N' THEN 
         LET l_bgcj.bgcj013 = ' '
      END IF
      
      #成本利润中心
      IF l_bgal.bgal006 = 'N' THEN 
         LET l_bgcj.bgcj014 = ' '
      END IF
      
      #区域
      IF l_bgal.bgal007 = 'N' THEN 
         LET l_bgcj.bgcj015 = ' '
      END IF
      
      #收付款客商
      IF l_bgal.bgal008 = 'N' THEN 
         LET l_bgcj.bgcj016 = ' '
      END IF
      
      #账款客商
      IF l_bgal.bgal009 = 'N' THEN 
         LET l_bgcj.bgcj017 = ' '
      END IF
      
      #客群
      IF l_bgal.bgal010 = 'N' THEN 
         LET l_bgcj.bgcj018 = ' '
      END IF
      
      #产品类别
      IF l_bgal.bgal011 = 'N' THEN 
         LET l_bgcj.bgcj019 = ' '
      END IF
      
      #经营方式
      IF l_bgal.bgal025 = 'N' THEN 
         LET l_bgcj.bgcj022 = ' '
      END IF
      
      #通路
      IF l_bgal.bgal026 = 'N' THEN 
         LET l_bgcj.bgcj023 = ' '
      END IF
      
      #品牌
      IF l_bgal.bgal027 = 'N' THEN 
         LET l_bgcj.bgcj024 = ' '
      END IF
      
      IF cl_null(l_bgcj.bgcj012) THEN LET l_bgcj.bgcj012 = ' ' END IF
      IF cl_null(l_bgcj.bgcj013) THEN LET l_bgcj.bgcj013 = ' ' END IF
      IF cl_null(l_bgcj.bgcj014) THEN LET l_bgcj.bgcj014 = ' ' END IF
      IF cl_null(l_bgcj.bgcj015) THEN LET l_bgcj.bgcj015 = ' ' END IF
      IF cl_null(l_bgcj.bgcj016) THEN LET l_bgcj.bgcj016 = ' ' END IF
      IF cl_null(l_bgcj.bgcj017) THEN LET l_bgcj.bgcj017 = ' ' END IF
      IF cl_null(l_bgcj.bgcj018) THEN LET l_bgcj.bgcj018 = ' ' END IF
      IF cl_null(l_bgcj.bgcj019) THEN LET l_bgcj.bgcj019 = ' ' END IF
      IF cl_null(l_bgcj.bgcj020) THEN LET l_bgcj.bgcj020 = ' ' END IF
      IF cl_null(l_bgcj.bgcj021) THEN LET l_bgcj.bgcj021 = ' ' END IF
      IF cl_null(l_bgcj.bgcj022) THEN LET l_bgcj.bgcj022 = ' ' END IF
      IF cl_null(l_bgcj.bgcj023) THEN LET l_bgcj.bgcj023 = ' ' END IF
      IF cl_null(l_bgcj.bgcj024) THEN LET l_bgcj.bgcj024 = ' ' END IF
      
      #组合key bgeg010
      LET l_bgcj.bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                           "bgcj014=",l_bgcj.bgcj014,"/",
                           "bgcj015=",l_bgcj.bgcj015,"/",
                           "bgcj016=",l_bgcj.bgcj016,"/",
                           "bgcj017=",l_bgcj.bgcj017,"/",
                           "bgcj018=",l_bgcj.bgcj018,"/",
                           "bgcj019=",l_bgcj.bgcj019,"/",
                           "bgcj022=",l_bgcj.bgcj022,"/",
                           "bgcj023=",l_bgcj.bgcj023,"/",
                           "bgcj024=",l_bgcj.bgcj024,"/",
                           "bgcj012=",l_bgcj.bgcj012,"/",
                           "bgcj020=",l_bgcj.bgcj020,"/",
                           "bgcj021=",l_bgcj.bgcj021,""
                           
      SELECT COUNT(1) INTO l_n
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj008 = l_bgcj.bgcj008
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010       
         
      IF l_n > 0 THEN 
         CONTINUE FOREACH
      END IF
      
      LET l_bgcjstus = ''
      SELECT bgcjstus INTO l_bgcjstus
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj008 = l_bgcj.bgcj008
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010
         
     IF l_bgcjstus = 'Y' THEN 
        CONTINUE FOREACH
     END IF
      
                               
      LET l_bgcj.bgcj025 = ' '
      LET l_bgcj.bgcj026 = ' '
      LET l_bgcj.bgcj027 = ' '
      LET l_bgcj.bgcj028 = ' '
      LET l_bgcj.bgcj029 = ' '
      LET l_bgcj.bgcj030 = ' '
      LET l_bgcj.bgcj031 = ' '
      LET l_bgcj.bgcj032 = ' '
      LET l_bgcj.bgcj033 = ' '
      LET l_bgcj.bgcj034 = ' '
      LET l_bgcj.bgcj035 = l_tmp1.xmdl025
      LET l_bgcj.bgcj036 = l_oodb005
      LET l_bgcj.bgcj037 = l_tmp1.xmdl021
      LET l_bgcj.bgcj038 = l_tmp1.qty + l_qty
      LET l_bgcj.bgcj040 = l_bgcj.bgcj038 * l_bgcj.bgcj039
      LET l_bgcj.bgcj041 = 0
      LET l_bgcj.bgcj042 = 0
      LET l_bgcj.bgcj043 = 0
      LET l_bgcj.bgcj044 = 0
      LET l_bgcj.bgcj045 = l_bgcj.bgcj038
      LET l_bgcj.bgcj046 = l_bgcj.bgcj039
      LET l_bgcj.bgcj047 = ''
      LET l_bgcj.bgcj048 = 'N'
      LET l_bgcj.bgcj049 = ''
      LET l_bgcj.bgcj050 = '2'
      LET l_bgcj.bgcj102 = l_bgcj.bgcj038 * l_bgcj.bgcj039
      
      CALL s_tax_count(l_tmp1.xmdksite,l_bgcj.bgcj035,l_bgcj.bgcj102,
                               0,l_bgcj.bgcj100,l_bgcj.bgcj101)
      RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,
                r_xrcd113,r_xrcd114,r_xrcd115

      LET l_bgcj.bgcjownid = g_user
      LET l_bgcj.bgcjowndp = g_dept
      LET l_bgcj.bgcjcrtid = g_user
      LET l_bgcj.bgcjcrtdp = g_dept 
      LET l_bgcj.bgcjcrtdt = cl_get_current()
      LET l_bgcj.bgcjmodid = g_user
      LET l_bgcj.bgcjmoddt = cl_get_current()
      LET l_bgcj.bgcjstus = 'N'
      
      SELECT MAX(bgcjseq) + 1 INTO l_bgcj.bgcjseq
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010
         
      IF cl_null(l_bgcj.bgcjseq) THEN LET l_bgcj.bgcjseq = 1 END IF

      INSERT INTO bgcj_t(bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                         bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                         bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                         bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                         bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                         bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                         bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                         bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                         bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                         bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                         bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                         bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                         bgcj105,
                         bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                         bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus)
     VALUES(l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
            l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
            l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
            l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
            l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
            l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
            l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
            l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
            l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
            l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
            l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
            l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
            l_bgcj.bgcj105,
            l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
            l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus)
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins bgeg_t'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
      
      LET r_flag = 'Y'
      
      #161215-00051#4--add--str--lujh
      #将本次插入的资料放临时表里存起来,全部执行完之后看看1-12(13)期是否都有资料,没资料要塞一笔金额是0的资料
      INSERT INTO abgp310_tmp07 VALUES(l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,
                                       l_bgcj.bgcj004,l_bgcj.bgcj005,l_bgcj.bgcj006,
                                       l_bgcj.bgcj007,l_bgcj.bgcj009,l_bgcj.bgcj010,
                                       l_bgcj.bgcjseq)
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins bgfb_t'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #161215-00051#4--add--end--lujh
   END FOREACH
   
   #161215-00051#4--add--str--lujh
   LET l_sql = "SELECT DISTINCT bgcj001,bgcj002,bgcj003,",
               "                bgcj004,bgcj005,bgcj006,",
               "                bgcj007,bgcj009,bgcj010,",
               "                bgcjseq ",
               "  FROM abgp310_tmp07 "
   PREPARE abgp310_p1_pre13 FROM l_sql
   DECLARE abgp310_p1_cs13 CURSOR FOR abgp310_p1_pre13
   
   FOREACH abgp310_p1_cs13 INTO l_bgcj1.bgcj001,l_bgcj1.bgcj002,l_bgcj1.bgcj003,
                                l_bgcj1.bgcj004,l_bgcj1.bgcj005,l_bgcj1.bgcj006,
                                l_bgcj1.bgcj007,l_bgcj1.bgcj009,l_bgcj1.bgcj010,
                                l_bgcj1.bgcjseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp310_p1_cs13'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
   
      FOR l_i = 1 TO g_month_max
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM bgcj_t
          WHERE bgcjent = g_enterprise
            AND bgcj001 = l_bgcj1.bgcj001
            AND bgcj002 = l_bgcj1.bgcj002
            AND bgcj003 = l_bgcj1.bgcj003
            AND bgcj004 = l_bgcj1.bgcj004
            AND bgcj005 = l_bgcj1.bgcj005
            AND bgcj006 = l_bgcj1.bgcj006
            AND bgcj007 = l_bgcj1.bgcj007
            AND bgcj008 = l_i
            AND bgcj009 = l_bgcj1.bgcj009
            AND bgcj010 = l_bgcj1.bgcj010 
            AND bgcjseq = l_bgcj1.bgcjseq
            
         IF l_n = 0 THEN 
            INITIALIZE l_bgcj.* TO NULL
            
            SELECT DISTINCT bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                            bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                            bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                            bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                            bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                            bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                            bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                            bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                            bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                            bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                            bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                            bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                            bgcj105,
                            bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                            bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus
              INTO l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
                   l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
                   l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
                   l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
                   l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
                   l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
                   l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
                   l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
                   l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
                   l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
                   l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
                   l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
                   l_bgcj.bgcj105,
                   l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
                   l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus
              FROM bgcj_t
             WHERE bgcjent = g_enterprise
               AND bgcj001 = l_bgcj1.bgcj001
               AND bgcj002 = l_bgcj1.bgcj002
               AND bgcj003 = l_bgcj1.bgcj003
               AND bgcj004 = l_bgcj1.bgcj004
               AND bgcj005 = l_bgcj1.bgcj005
               AND bgcj006 = l_bgcj1.bgcj006
               AND bgcj007 = l_bgcj1.bgcj007
               AND bgcj009 = l_bgcj1.bgcj009
               AND bgcj010 = l_bgcj1.bgcj010 
               AND bgcjseq = l_bgcj1.bgcjseq 
              
            LET l_bgcj.bgcj008 = l_i  
            LET l_bgcj.bgcj038 = 0
            LET l_bgcj.bgcj039 = 0
            LET l_bgcj.bgcj040 = 0
            LET l_bgcj.bgcj041 = 0  
            LET l_bgcj.bgcj042 = 0  
            LET l_bgcj.bgcj043 = 0  
            LET l_bgcj.bgcj044 = 0  
            LET l_bgcj.bgcj045 = 0  
            LET l_bgcj.bgcj046 = 0  
            LET l_bgcj.bgcj102 = 0 
            LET l_bgcj.bgcj103 = 0     
            LET l_bgcj.bgcj104 = 0     
            LET l_bgcj.bgcj105 = 0    

            INSERT INTO bgcj_t(bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                               bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                               bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                               bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                               bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                               bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                               bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                               bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                               bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                               bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                               bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                               bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                               bgcj105,
                               bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                               bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus)
            VALUES(l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
                   l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
                   l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
                   l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
                   l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
                   l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
                   l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
                   l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
                   l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
                   l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
                   l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
                   l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
                   l_bgcj.bgcj105,
                   l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
                   l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus)
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins bgcj_t'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
      END FOR
   END FOREACH
   #161215-00051#4--add--end--lujh
   
   RETURN r_success,r_flag
END FUNCTION
# 参考资料来源于订单
PRIVATE FUNCTION abgp310_p2()
   DEFINE l_sql                 STRING
   DEFINE l_success             LIKE type_t.num5
   DEFINE l_wc1                 STRING
   DEFINE l_wc2                 STRING
   DEFINE l_xmdc011_tot         LIKE xmdc_t.xmdc011
   DEFINE l_bgci005             LIKE bgci_t.bgci005
   DEFINE l_bgci006             LIKE bgci_t.bgci006
   DEFINE l_qq                  LIKE type_t.num5
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_yy                  LIKE type_t.chr10
   DEFINE l_mm                  LIKE type_t.chr10
   DEFINE l_qty                 LIKE xmdl_t.xmdl022
   DEFINE l_year                LIKE type_t.num5 
   DEFINE l_n                   LIKE type_t.num5
   DEFINE l_bgaa010             LIKE bgaa_t.bgaa010
   DEFINE l_bgaa011             LIKE bgaa_t.bgaa011
   DEFINE l_bgaa003             LIKE bgaa_t.bgaa003
   DEFINE l_bgai002             LIKE bgai_t.bgai002
   DEFINE l_bgai006             LIKE bgai_t.bgai006
   DEFINE l_bgai008             LIKE bgai_t.bgai008
   DEFINE l_bgeb003             LIKE bgeb_t.bgeb003
   DEFINE l_pmab081             LIKE pmab_t.pmab081
   DEFINE l_pmab109             LIKE pmab_t.pmab109
   DEFINE l_ooeg004             LIKE ooeg_t.ooeg004
   DEFINE l_pmaa241             LIKE pmaa_t.pmaa241  
   DEFINE l_pmaa090             LIKE pmaa_t.pmaa090
   DEFINE l_pmaa092             LIKE pmaa_t.pmaa091
   DEFINE l_bgar001             LIKE bgar_t.bgar001
   DEFINE l_bgas009             LIKE bgas_t.bgas009
   DEFINE l_bgas010             LIKE bgas_t.bgas010
   DEFINE l_ooef019             LIKE ooef_t.ooef019
   DEFINE l_oodb005             LIKE oodb_t.oodb005
   DEFINE l_bgcb006             LIKE bgcb_t.bgcb006 
   DEFINE l_bgcb007             LIKE bgcb_t.bgcb007
   DEFINE l_bgca003             LIKE bgca_t.bgca003
   DEFINE l_xmdadocdt_max       LIKE xmda_t.xmdadocdt
   DEFINE l_xmdc015_max         LIKE xmdc_t.xmdc015
   DEFINE l_xmda015             LIKE xmda_t.xmda015
   DEFINE l_bgea013             LIKE bgea_t.bgea013
   DEFINE l_bgea014             LIKE bgea_t.bgea014
   DEFINE l_bgea004             LIKE bgea_t.bgea004
   DEFINE l_price               LIKE bgea_t.bgea020
   DEFINE r_xrcd113             LIKE xrcd_t.xrcd113
   DEFINE r_xrcd114             LIKE xrcd_t.xrcd114
   DEFINE r_xrcd115             LIKE xrcd_t.xrcd115
   DEFINE l_bgcjstus            LIKE bgcj_t.bgcjstus
   DEFINE l_site_str            STRING
   DEFINE l_message             STRING
   DEFINE l_comp                LIKE glaa_t.glaacomp
   DEFINE l_glaa003             LIKE glaa_t.glaa003
   DEFINE l_flag1               LIKE type_t.chr1
   DEFINE l_errno               LIKE type_t.chr100
   DEFINE l_glav002             LIKE glav_t.glav002
   DEFINE l_glav005             LIKE glav_t.glav005
   DEFINE l_sdate_s             LIKE glav_t.glav004
   DEFINE l_sdate_e             LIKE glav_t.glav004
   DEFINE l_glav006             LIKE glav_t.glav006
   DEFINE l_glav007             LIKE glav_t.glav007
   DEFINE l_pdate_s             LIKE glav_t.glav004
   DEFINE l_pdate_e             LIKE glav_t.glav004
   DEFINE l_wdate_s             LIKE glav_t.glav004
   DEFINE l_wdate_e             LIKE glav_t.glav004
   DEFINE l_tmp                 RECORD
                                xmdasite               LIKE xmda_t.xmdasite,   #营运据点
                                yy                     LIKE type_t.num5,       #年度
                                mm                     LIKE type_t.num5,       #期别  
                                xmda004                LIKE xmda_t.xmda004,    #交易客户
                                xmda023                LIKE xmda_t.xmda023,    #销售通路
                                xmdc001                LIKE xmdc_t.xmdc001,    #料件编号
                                xmdc010                LIKE xmdc_t.xmdc010,    #计价单位
                                xmdc016                LIKE xmdc_t.xmdc016,    #税别
                                xmdc036                LIKE xmdc_t.xmdc036,    #专案编号
                                xmdc037                LIKE xmdc_t.xmdc037,    #WBS
                                xmdc011                LIKE xmdc_t.xmdc011,    #计价数量 
                                qty                    LIKE xmdc_t.xmdc011     #根据期别资料分配方式重新计算的数量                                
                                END RECORD 
   DEFINE l_tmp1                RECORD
                                xmdasite               LIKE xmda_t.xmdasite,   #营运据点
                                yy                     LIKE type_t.num5,       #年度
                                mm                     LIKE type_t.num5,       #期别  
                                xmda004                LIKE xmda_t.xmda004,    #交易客户
                                xmda023                LIKE xmda_t.xmda023,    #销售通路
                                xmdc001                LIKE xmdc_t.xmdc001,    #料件编号
                                xmdc010                LIKE xmdc_t.xmdc010,    #计价单位
                                xmdc016                LIKE xmdc_t.xmdc016,    #税别
                                xmdc036                LIKE xmdc_t.xmdc036,    #专案编号
                                xmdc037                LIKE xmdc_t.xmdc037,    #WBS
                                qty                    LIKE xmdc_t.xmdc011     #根据期别资料分配方式重新计算的数量                                
                                END RECORD   
   DEFINE l_bgcj                RECORD  #銷售預算主檔
                                bgcjent                LIKE bgcj_t.bgcjent, #企業編號
                                bgcj001                LIKE bgcj_t.bgcj001, #來源作業
                                bgcj002                LIKE bgcj_t.bgcj002, #預算編號
                                bgcj003                LIKE bgcj_t.bgcj003, #版本
                                bgcj004                LIKE bgcj_t.bgcj004, #管理組織
                                bgcj005                LIKE bgcj_t.bgcj005, #銷售來源
                                bgcj006                LIKE bgcj_t.bgcj006, #資料類型
                                bgcj007                LIKE bgcj_t.bgcj007, #預算組織
                                bgcj008                LIKE bgcj_t.bgcj008, #預算期別
                                bgcj009                LIKE bgcj_t.bgcj009, #預算料件
                                bgcj010                LIKE bgcj_t.bgcj010, #組合KEY
                                bgcjseq                LIKE bgcj_t.bgcjseq, #項次
                                bgcj011                LIKE bgcj_t.bgcj011, #預算樣表
                                bgcj012                LIKE bgcj_t.bgcj012, #人員
                                bgcj013                LIKE bgcj_t.bgcj013, #部門
                                bgcj014                LIKE bgcj_t.bgcj014, #成本利潤中心
                                bgcj015                LIKE bgcj_t.bgcj015, #區域
                                bgcj016                LIKE bgcj_t.bgcj016, #收付款客商
                                bgcj017                LIKE bgcj_t.bgcj017, #帳款客商
                                bgcj018                LIKE bgcj_t.bgcj018, #客群
                                bgcj019                LIKE bgcj_t.bgcj019, #產品類別
                                bgcj020                LIKE bgcj_t.bgcj020, #專案編號
                                bgcj021                LIKE bgcj_t.bgcj021, #WBS
                                bgcj022                LIKE bgcj_t.bgcj022, #經營方式
                                bgcj023                LIKE bgcj_t.bgcj023, #通路
                                bgcj024                LIKE bgcj_t.bgcj024, #品牌
                                bgcj025                LIKE bgcj_t.bgcj025, #自由核算項一
                                bgcj026                LIKE bgcj_t.bgcj026, #自由核算項二
                                bgcj027                LIKE bgcj_t.bgcj027, #自由核算項三
                                bgcj028                LIKE bgcj_t.bgcj028, #自由核算項四
                                bgcj029                LIKE bgcj_t.bgcj029, #自由核算項五
                                bgcj030                LIKE bgcj_t.bgcj030, #自由核算項六
                                bgcj031                LIKE bgcj_t.bgcj031, #自由核算項七
                                bgcj032                LIKE bgcj_t.bgcj032, #自由核算項八
                                bgcj033                LIKE bgcj_t.bgcj033, #自由核算項九
                                bgcj034                LIKE bgcj_t.bgcj034, #自由核算項十
                                bgcj035                LIKE bgcj_t.bgcj035, #稅別
                                bgcj036                LIKE bgcj_t.bgcj036, #含稅否
                                bgcj037                LIKE bgcj_t.bgcj037, #銷售單位
                                bgcj038                LIKE bgcj_t.bgcj038, #交易數量
                                bgcj039                LIKE bgcj_t.bgcj039, #單價
                                bgcj040                LIKE bgcj_t.bgcj040, #原幣銷售金額
                                bgcj041                LIKE bgcj_t.bgcj041, #本層調整數量
                                bgcj042                LIKE bgcj_t.bgcj042, #本層調整單價
                                bgcj043                LIKE bgcj_t.bgcj043, #上層調整數量
                                bgcj044                LIKE bgcj_t.bgcj044, #上層調整單價
                                bgcj045                LIKE bgcj_t.bgcj045, #核准數量
                                bgcj046                LIKE bgcj_t.bgcj046, #核准單價
                                bgcj047                LIKE bgcj_t.bgcj047, #上層組織
                                bgcj048                LIKE bgcj_t.bgcj048, #憑證單號
                                bgcj049                LIKE bgcj_t.bgcj049, #預算細項
                                bgcj050                LIKE bgcj_t.bgcj050, #編製起點
                                bgcj051                LIKE bgcj_t.bgcj051, #生產預算拋轉否
                                bgcj052                LIKE bgcj_t.bgcj052, #內部採購組織
                                bgcj053                LIKE bgcj_t.bgcj053, #內部採購預算細項
                                bgcj100                LIKE bgcj_t.bgcj100, #交易幣別
                                bgcj101                LIKE bgcj_t.bgcj101, #匯率
                                bgcj102                LIKE bgcj_t.bgcj102, #核准原幣銷售金額
                                bgcj103                LIKE bgcj_t.bgcj103, #核准原幣未稅金額
                                bgcj104                LIKE bgcj_t.bgcj104, #核准原幣稅額
                                bgcj105                LIKE bgcj_t.bgcj105, #核准原幣含稅金額
                                bgcjownid              LIKE bgcj_t.bgcjownid, #資料所有者
                                bgcjowndp              LIKE bgcj_t.bgcjowndp, #資料所屬部門
                                bgcjcrtid              LIKE bgcj_t.bgcjcrtid, #資料建立者
                                bgcjcrtdp              LIKE bgcj_t.bgcjcrtdp, #資料建立部門
                                bgcjcrtdt              LIKE bgcj_t.bgcjcrtdt, #資料創建日
                                bgcjmodid              LIKE bgcj_t.bgcjmodid, #資料修改者
                                bgcjmoddt              LIKE bgcj_t.bgcjmoddt, #最近修改日
                                bgcjcnfid              LIKE bgcj_t.bgcjcnfid, #資料確認者
                                bgcjcnfdt              LIKE bgcj_t.bgcjcnfdt, #資料確認日
                                bgcjstus               LIKE bgcj_t.bgcjstus, #狀態碼
                                bgcjud001              LIKE bgcj_t.bgcjud001, #自定義欄位(文字)001
                                bgcjud002              LIKE bgcj_t.bgcjud002, #自定義欄位(文字)002
                                bgcjud003              LIKE bgcj_t.bgcjud003, #自定義欄位(文字)003
                                bgcjud004              LIKE bgcj_t.bgcjud004, #自定義欄位(文字)004
                                bgcjud005              LIKE bgcj_t.bgcjud005, #自定義欄位(文字)005
                                bgcjud006              LIKE bgcj_t.bgcjud006, #自定義欄位(文字)006
                                bgcjud007              LIKE bgcj_t.bgcjud007, #自定義欄位(文字)007
                                bgcjud008              LIKE bgcj_t.bgcjud008, #自定義欄位(文字)008
                                bgcjud009              LIKE bgcj_t.bgcjud009, #自定義欄位(文字)009
                                bgcjud010              LIKE bgcj_t.bgcjud010, #自定義欄位(文字)010
                                bgcjud011              LIKE bgcj_t.bgcjud011, #自定義欄位(數字)011
                                bgcjud012              LIKE bgcj_t.bgcjud012, #自定義欄位(數字)012
                                bgcjud013              LIKE bgcj_t.bgcjud013, #自定義欄位(數字)013
                                bgcjud014              LIKE bgcj_t.bgcjud014, #自定義欄位(數字)014
                                bgcjud015              LIKE bgcj_t.bgcjud015, #自定義欄位(數字)015
                                bgcjud016              LIKE bgcj_t.bgcjud016, #自定義欄位(數字)016
                                bgcjud017              LIKE bgcj_t.bgcjud017, #自定義欄位(數字)017
                                bgcjud018              LIKE bgcj_t.bgcjud018, #自定義欄位(數字)018
                                bgcjud019              LIKE bgcj_t.bgcjud019, #自定義欄位(數字)019
                                bgcjud020              LIKE bgcj_t.bgcjud020, #自定義欄位(數字)020
                                bgcjud021              LIKE bgcj_t.bgcjud021, #自定義欄位(日期時間)021
                                bgcjud022              LIKE bgcj_t.bgcjud022, #自定義欄位(日期時間)022
                                bgcjud023              LIKE bgcj_t.bgcjud023, #自定義欄位(日期時間)023
                                bgcjud024              LIKE bgcj_t.bgcjud024, #自定義欄位(日期時間)024
                                bgcjud025              LIKE bgcj_t.bgcjud025, #自定義欄位(日期時間)025
                                bgcjud026              LIKE bgcj_t.bgcjud026, #自定義欄位(日期時間)026
                                bgcjud027              LIKE bgcj_t.bgcjud027, #自定義欄位(日期時間)027
                                bgcjud028              LIKE bgcj_t.bgcjud028, #自定義欄位(日期時間)028
                                bgcjud029              LIKE bgcj_t.bgcjud029, #自定義欄位(日期時間)029
                                bgcjud030              LIKE bgcj_t.bgcjud030  #自定義欄位(日期時間)030
                                END RECORD  
   #161215-00051#4--add--str--lujh
   DEFINE l_bgcj1               RECORD  #銷售預算主檔
                                bgcj001                LIKE bgcj_t.bgcj001, #來源作業
                                bgcj002                LIKE bgcj_t.bgcj002, #預算編號
                                bgcj003                LIKE bgcj_t.bgcj003, #版本
                                bgcj004                LIKE bgcj_t.bgcj004, #管理組織
                                bgcj005                LIKE bgcj_t.bgcj005, #銷售來源
                                bgcj006                LIKE bgcj_t.bgcj006, #資料類型
                                bgcj007                LIKE bgcj_t.bgcj007, #預算組織
                                bgcj009                LIKE bgcj_t.bgcj009, #預算料件
                                bgcj010                LIKE bgcj_t.bgcj010, #組合KEY
                                bgcjseq                LIKE bgcj_t.bgcjseq  #項次
                                END RECORD
   #161215-00051#4--add--end--lujh                                 
   DEFINE l_bgal                RECORD
                                bgal005     LIKE bgal_t.bgal005,
                                bgal006     LIKE bgal_t.bgal006,
                                bgal007     LIKE bgal_t.bgal007,
                                bgal008     LIKE bgal_t.bgal008,
                                bgal009     LIKE bgal_t.bgal009,
                                bgal010     LIKE bgal_t.bgal010,
                                bgal011     LIKE bgal_t.bgal011,
                                bgal012     LIKE bgal_t.bgal012,
                                bgal013     LIKE bgal_t.bgal013,
                                bgal014     LIKE bgal_t.bgal014,
                                bgal025     LIKE bgal_t.bgal025,
                                bgal026     LIKE bgal_t.bgal026,
                                bgal027     LIKE bgal_t.bgal027
                                END RECORD                                    
   DEFINE r_flag                LIKE type_t.chr1
   DEFINE r_success             LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   LET r_flag = 'N'
   LET l_success = TRUE
   
   INITIALIZE l_tmp.* TO NULL
   DELETE FROM abgp310_tmp04;
   DELETE FROM abgp310_tmp05;
   DELETE FROM abgp310_tmp06;
   DELETE FROM abgp310_tmp07;    #161215-00051#4 add lujh
   
   #abgi010预算组织版本/最上层组织/预算币别
   LET l_bgaa010 = ''     LET l_bgaa011 = ''
   LET l_bgaa003 = ''
   SELECT bgaa010,bgaa011,bgaa003 INTO l_bgaa010,l_bgaa011,l_bgaa003
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgcj002
   
   LET l_wc1 = ''    LET l_wc2 = ''
   LET l_wc1 = cl_replace_str(g_master.wc,"bgcj007","xmdasite")
   LET l_wc2 = cl_replace_str(g_wc,"bgcj016","xmda004")
   
   CALL s_abg2_get_site(g_master.bgcj002,l_bgaa011,'01') RETURNING l_site_str
   LET l_wc1 = l_wc1," AND ooef001 IN ",l_site_str
   LET l_wc1 = cl_replace_str(l_wc1,"ooef001","xmdasite")
   
   #抓取一般订单签收订单
   LET l_sql = "INSERT INTO abgp310_tmp04 ",
               "SELECT xmdadocno,xmdasite,xmdadocdt,xmda004,xmda023,",
               "       xmdcseq,xmdc001,xmdc010,xmdc011,xmdc016,",
               "       xmdc036,xmdc037,TO_CHAR(xmdadocdt,'YYYY'),TO_CHAR(xmdadocdt,'MM'), ",
               "       TO_CHAR(xmdadocdt,'q') ",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmdadocdt BETWEEN '",g_year_min,"' AND '",g_year_max,"'",
               "   AND xmda005 IN ('1','3') ",
               "   AND xmdastus = 'Y' ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               " ORDER BY xmdadocdt,xmdadocno,xmdcseq"
   PREPARE abgp310_p2_pre FROM l_sql
   EXECUTE abgp310_p2_pre

   #将资料按期别汇总
   LET l_sql = "INSERT INTO abgp310_tmp05 ",
               "SELECT DISTINCT xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
               "                xmdc010,xmdc016,xmdc036,xmdc037,SUM(xmdc011),''",
               "  FROM abgp310_tmp04 ",
               " GROUP BY xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
               "          xmdc010,xmdc016,xmdc036,xmdc037 ",
               " ORDER BY xmdasite,xmdc001,yy,mm"
   PREPARE abgp310_p2_pre1 FROM l_sql
   EXECUTE abgp310_p2_pre1 
   
   #根据期别分配方式重新计算数量
   LET l_sql = "SELECT DISTINCT xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
               "                xmdc010,xmdc016,xmdc036,xmdc037,xmdc011,'' ",
               "  FROM abgp310_tmp05 ",
               " ORDER BY xmdasite,xmdc001,yy,mm"
   PREPARE abgp310_p2_pre2 FROM l_sql
   DECLARE abgp310_p2_cs2 CURSOR FOR abgp310_p2_pre2
   
   #根据期别分配方式重新计算数量
   IF g_master.c = '1' THEN 
      UPDATE abgp310_tmp05 SET qty = xmdc011
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'upd abgp310_tmp04'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
   ELSE
      FOREACH abgp310_p2_cs2 INTO l_tmp.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'abgp310_p2_cs2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
             
            LET r_success = FALSE
         END IF
         
         #抓取此料件全年的总量
         LET l_xmdc011_tot = 0
         SELECT SUM(xmdc011) INTO l_xmdc011_tot
           FROM abgp310_tmp05
          WHERE xmdasite = l_tmp.xmdasite
            AND xmda004  = l_tmp.xmda004
            AND xmda023  = l_tmp.xmda023
            AND xmdc001  = l_tmp.xmdc001
            AND xmdc010  = l_tmp.xmdc010
            AND xmdc016  = l_tmp.xmdc016
            AND xmdc036  = l_tmp.xmdc036
            AND xmdc037  = l_tmp.xmdc037
            AND yy       = l_tmp.yy
            
         IF cl_null(l_xmdc011_tot) THEN LET l_xmdc011_tot = 0 END IF
         
         #抓取abgi370的设置
         LET l_bgci006 = ''
         SELECT DISTINCT bgci006 INTO l_bgci006
           FROM bgci_t
          WHERE bgcient = g_enterprise
            AND bgci001 = g_master.bgcj002
            AND bgci002 = g_master.bgcj003
            AND bgci003 = l_tmp.xmdasite
            
         #依期别         
         IF l_bgci006 = '1' THEN 
            LET l_bgci005 = 0
            SELECT bgci005 INTO l_bgci005
              FROM bgci_t
             WHERE bgcient = g_enterprise
               AND bgci001 = g_master.bgcj002
               AND bgci002 = g_master.bgcj003
               AND bgci003 = l_tmp.xmdasite
               AND bgci004 = l_tmp.mm
         
            LET l_tmp.qty = l_xmdc011_tot * l_bgci005 / 100
         ELSE
            #依季别
            #先看下当前月份是第几季
            SELECT DISTINCT qq INTO l_qq
              FROM abgp310_tmp04
             WHERE mm = l_tmp.mm
             
            LET l_bgci005 = 0
            SELECT bgci005 INTO l_bgci005
              FROM bgci_t
             WHERE bgcient = g_enterprise
               AND bgci001 = g_master.bgcj002
               AND bgci002 = g_master.bgcj003
               AND bgci003 = l_tmp.xmdasite
               AND bgci004 = l_qq
            
            #计算每个季度的数量再平均分配            
            LET l_tmp.qty = l_xmdc011_tot * l_bgci005 / 100 / 3
         END IF    

         UPDATE abgp310_tmp05 SET qty = l_tmp.qty
          WHERE xmdasite = l_tmp.xmdasite
            AND xmda004  = l_tmp.xmda004
            AND xmda023  = l_tmp.xmda023
            AND xmdc001  = l_tmp.xmdc001
            AND xmdc010  = l_tmp.xmdc010
            AND xmdc016  = l_tmp.xmdc016
            AND xmdc036  = l_tmp.xmdc036
            AND xmdc037  = l_tmp.xmdc037
            AND yy       = l_tmp.yy
            AND mm       = l_tmp.mm
            
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'upd abgp310_tmp05'
            LET g_errparam.code   = sqlca.sqlcode
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF
         
         INITIALIZE l_tmp.* TO NULL
      END FOREACH
   END IF
   
   #根据未来期选项重新计算最后一期年月之后月份的数量
   #ex:最后一期年月输入201610,那2016 11 12月份的重新计算
   INITIALIZE l_tmp1.* TO NULL
   LET l_sql = "SELECT DISTINCT xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
               "                xmdc010,xmdc016,xmdc036,xmdc037,qty ",
               "  FROM abgp310_tmp05 ",
               " WHERE mm = ? "
   PREPARE abgp310_p2_pre3 FROM l_sql
   DECLARE abgp310_p2_cs3 CURSOR FOR abgp310_p2_pre3
   
   #抓取前一年度当前期别的数量
   LET l_sql = "SELECT SUM(xmdc011)",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmda005 IN ('1','3') ",
               "   AND xmdastus = 'Y' ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND to_char('xmdadocdt','YYYY') = ? ",
               "   AND to_char('xmdadocdt','MM') = ? ",
               "   AND xmdasite = ? ",
               "   AND xmda004  = ? ",
               "   AND (xmda023  = ? OR xmda023 IS NULL)",
               "   AND xmdc001  = ? ",
               "   AND xmdc010  = ? ",
               "   AND xmdc016  = ? ",
               "   AND (xmdc036  = ? OR xmdc036 IS NULL)",
               "   AND (xmdc037  = ? OR xmdc037 IS NULL)"
   PREPARE abgp310_p2_pre4 FROM l_sql

   #依实际最后一期/依前年度同期别实际数,不管2016 11 12月份是否有值,重新抓
   IF g_master.b MATCHES '[12]' THEN 
      LET l_yy = g_master.date[1,4]
      LET l_mm = g_master.date[5,6]
      
      FOR l_i = l_mm + 1 TO g_month_max   
         FOREACH abgp310_p2_cs3 USING l_i INTO l_tmp1.*
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p2_cs3'
               LET g_errparam.popup = TRUE
               CALL cl_err()
                
               LET r_success = FALSE
            END IF
            
            #将之后月份的资料删掉重新抓取
            DELETE FROM abgp310_tmp05 
             WHERE xmdasite = l_tmp1.xmdasite
               AND xmda004  = l_tmp1.xmda004
               AND xmda023  = l_tmp1.xmda023
               AND xmdc001  = l_tmp1.xmdc001
               AND xmdc010  = l_tmp1.xmdc010
               AND xmdc016  = l_tmp1.xmdc016
               AND xmdc036  = l_tmp1.xmdc036
               AND xmdc037  = l_tmp1.xmdc037 
               AND yy       = l_tmp1.yy
               AND mm       = l_tmp1.mm 
               
            #依实际最后一期时,抓最后一期年月的资料
            IF g_master.b = '1' THEN 
               SELECT qty INTO l_qty
                 FROM abgp310_tmp05 
                WHERE xmdasite = l_tmp1.xmdasite
                  AND xmda004  = l_tmp1.xmda004
                  AND xmda023  = l_tmp1.xmda023
                  AND xmdc001  = l_tmp1.xmdc001
                  AND xmdc010  = l_tmp1.xmdc010
                  AND xmdc016  = l_tmp1.xmdc016
                  AND xmdc036  = l_tmp1.xmdc036
                  AND xmdc037  = l_tmp1.xmdc037 
                  AND yy       = l_tmp1.yy
                  AND mm       = l_mm 
               
               IF cl_null(l_qty) THEN 
                  LET l_qty = 0
               END IF
                
               LET l_tmp1.qty = l_qty
               
               INSERT INTO abgp310_tmp06 VALUES(l_tmp1.*)
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp310_tmp06'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF               
            END IF
            
            #依前年度同期别实际数,抓前一年当前期的资料
            IF g_master.b = '2' THEN
               LET l_year =  l_tmp1.yy -1           
               EXECUTE abgp310_p2_pre4 USING l_year,l_i,l_tmp1.xmdasite,l_tmp1.xmda004,
                                             l_tmp1.xmda023,l_tmp1.xmdc001,l_tmp1.xmdc010,
                                             l_tmp1.xmdc016,l_tmp1.xmdc036,l_tmp1.xmdc037 
                                        INTO l_qty
               IF cl_null(l_qty) THEN 
                  LET l_qty = 0
               END IF               
               
               LET l_tmp1.qty = l_qty
               
               INSERT INTO abgp310_tmp03 VALUES(l_tmp1.*)
               
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = 'ins abgp310_tmp03'
                  LET g_errparam.code   = sqlca.sqlcode
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET r_success = FALSE
               END IF                                        
            END IF
            
            INITIALIZE l_tmp1.* TO NULL
         END FOREACH
      END FOR
      
      #将最后一期年月之前月份的资料也插进临时表
      LET l_sql = "INSERT INTO abgp310_tmp06 ",
                  "SELECT xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
                  "       xmdc010,xmdc016,xmdc036,xmdc037,qty ",
                  "  FROM abgp310_tmp05 ",
                  " WHERE mm BETWEEN 1 AND ",l_mm
      PREPARE abgp310_p2_pre5 FROM l_sql
      EXECUTE abgp310_p2_pre5
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins abgp310_tmp06'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   ELSE
      #无未来期,不重新计算数量
      LET l_sql = "INSERT INTO abgp310_tmp06 ",
                  "SELECT xmdasite,yy,mm,xmda004,xmda023,xmdc001,",
                  "       xmdc010,xmdc016,xmdc036,xmdc037,qty ",
                  "  FROM abgp310_tmp05 "
      PREPARE abgp310_p2_pre6 FROM l_sql
      EXECUTE abgp310_p2_pre6 
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins abgp310_tmp06'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
   END IF
   
   #开始往abgt340塞资料
   INITIALIZE l_tmp1.* TO NULL
   LET l_sql = "SELECT * FROM abgp310_tmp06 "
   PREPARE abgp310_p2_pre7 FROM l_sql
   DECLARE abgp310_p2_cs7 CURSOR FOR abgp310_p2_pre7
   
   #abgi320抓取数量影响因子,影响百分比/影响数量/影响方式
   LET l_sql = "SELECT DISTINCT bgcb006,bgcb007,bgca003 ",
               "  FROM bgcb_t,bgca_t ",
               " WHERE bgcbent = ",g_enterprise,
               "   AND bgcbent = bgcaent ",
               "   AND bgcb004 = bgca001 ",
               "   AND bgca002 = '1' ",
               "   AND bgcb001 = '",g_master.bgcj002,"'",
               "   AND bgcb002 = ? ",
               "   AND bgcb008 = ? ",
               "   AND bgcb005 = ? ",
               "   AND bgcb010 = '1' "
   PREPARE abgp310_p2_pre8 FROM l_sql
   DECLARE abgp310_p2_cs8 CURSOR FOR abgp310_p2_pre8 
   
   #abgi320抓取单价影响因子,影响百分比/影响数量/影响方式
   LET l_sql = "SELECT DISTINCT bgcb006,bgcb007,bgca003 ",
               "  FROM bgcb_t,bgca_t ",
               " WHERE bgcbent = ",g_enterprise,
               "   AND bgcbent = bgcaent ",
               "   AND bgcb004 = bgca001 ",
               "   AND bgca002 = '2' ",
               "   AND bgcb001 = '",g_master.bgcj002,"'",
               "   AND bgcb002 = ? ",
               "   AND bgcb008 = ? ",
               "   AND bgcb005 = ? ",
               "   AND bgcb010 = '1' "
   PREPARE abgp310_p2_pre9 FROM l_sql
   DECLARE abgp310_p2_cs9 CURSOR FOR abgp310_p2_pre9
   
   #抓取最大日期
   LET l_sql = "SELECT MAX(xmdadocdt)",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmda005 IN ('1','3') ",
               "   AND xmdastus = 'Y' ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdasite = ? ",
               "   AND xmda004  = ? ",
               "   AND (xmda023  = ? OR xmda023 IS NULL)",
               "   AND xmdc001  = ? ",
               "   AND xmdc010  = ? ",
               "   AND xmdc016  = ? ",
               "   AND (xmdc036  = ? OR xmdc036 IS NULL)",
               "   AND (xmdc037  = ? OR xmdc037 IS NULL)"
   PREPARE abgp310_p2_pre10 FROM l_sql
   
   #抓取最大单价
   LET l_sql = "SELECT MAX(xmdc015)",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmda005 IN ('1','3') ",
               "   AND xmdastus = 'Y' ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdadocdt  = ? ",
               "   AND xmdasite = ? ",
               "   AND xmda004  = ? ",
               "   AND (xmda023  = ? OR xmda023 IS NULL)",
               "   AND xmdc001  = ? ",
               "   AND xmdc010  = ? ",
               "   AND xmdc016  = ? ",
               "   AND (xmdc036  = ? OR xmdc036 IS NULL)",
               "   AND (xmdc037  = ? OR xmdc037 IS NULL)"
   PREPARE abgp310_p2_pre11 FROM l_sql
   
   #抓取币别
   LET l_sql = "SELECT xmda015",
               "  FROM xmda_t,xmdc_t ",
               " WHERE xmdaent = ",g_enterprise,
               "   AND xmdaent = xmdcent ",
               "   AND xmdadocno = xmdcdocno ",
               "   AND xmda005 IN ('1','3') ",
               "   AND xmdastus = 'Y' ",
               "   AND ",l_wc1,
               "   AND ",l_wc2,
               "   AND xmdadocdt  = ? ",
               "   AND xmdasite = ? ",
               "   AND xmda004  = ? ",
               "   AND (xmda023  = ? OR xmda023 IS NULL)",
               "   AND xmdc001  = ? ",
               "   AND xmdc010  = ? ",
               "   AND xmdc015  = ? ",
               "   AND xmdc016  = ? ",
               "   AND (xmdc036  = ? OR xmdc036 IS NULL)",
               "   AND (xmdc037  = ? OR xmdc037 IS NULL)"
   PREPARE abgp310_p2_pre12 FROM l_sql

   IF g_master.a = 'Y' THEN  
      LET l_sql = "DELETE FROM bgcj_t ",
                  " WHERE bgcjent = ",g_enterprise,
                  "   AND bgcj002 = '",g_master.bgcj002,"'",
                  "   AND bgcj003 = '",g_master.bgcj003,"'",
                  "   AND bgcj005 = '1' ",
                  "   AND bgcj006 = '1' ",
                  "   AND bgcj007 IN (SELECT DISTINCT xmdasite FROM abgp310_tmp06) ",
                  "   AND bgcjstus = 'N' "                  
      PREPARE abgp310_p2_del_pre FROM l_sql
      EXECUTE abgp310_p2_del_pre      
   END IF

   FOREACH abgp310_p2_cs7 INTO l_tmp1.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp310_p2_cs7'
         LET g_errparam.popup = TRUE
         CALL cl_err()
          
         LET r_success = FALSE
      END IF
      
      #abgi090预算管理组织/样表编号/可编制预算细项
      LET l_bgai002 = ' '     LET l_bgai008 = ''
      LET l_bgai006 = ''
      SELECT DISTINCT bgai002,bgai008,bgai006 INTO l_bgai002,l_bgai008,l_bgai006
        FROM bgai_t
       WHERE bgaient = g_enterprise
         AND bgai001 = g_master.bgcj002
         AND bgai003 = g_user
         AND bgai004 = l_tmp1.xmdasite
         AND bgai005 IN ('01','ALL')
         AND ROWNUM = 1
         
      IF cl_null(l_bgai002) THEN LET l_bgai002 = ' ' END IF
         
      #抓取預算料件
      LET l_bgeb003 = ''
      SELECT bgeb003 INTO l_bgeb003
        FROM bgeb_t
       WHERE bgebent = g_enterprise
         AND bgeb001 = g_master.bgcj002
         AND bgeb002 = l_tmp1.xmdasite
         AND bgeb004 = l_tmp1.xmdc001 
         
      IF cl_null(l_bgeb003) THEN 
         LET l_bgeb003 = ' '
      END IF
      
      #人员/部门   
      LET l_pmab081 = ''    LET l_pmab109 = ''    
      SELECT pmab081,pmab109 INTO l_pmab081,l_pmab109
        FROM pmab_t
       WHERE pmabent = g_enterprise
         AND pmabsite = l_tmp1.xmdasite
         AND pmab001 = l_tmp1.xmda004 
         
      #成本利润中心
      LET l_ooeg004 = ''               
      SELECT ooeg004 INTO l_ooeg004
        FROM ooeg_t
       WHERE ooegent = g_enterprise
         AND ooeg001 = l_pmab109
         
      #区域/客群/经营方式
      LET l_pmaa241 = ''    LET l_pmaa090 = ''
      LET l_pmaa092 = ''
      SELECT pmaa241,pmaa090,pmaa092 INTO l_pmaa241,l_pmaa090,l_pmaa092
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = l_tmp1.xmda004
         
      #abgi150预算交易对象
      LET l_bgar001 = ''
      SELECT bgar001 INTO l_bgar001
        FROM bgar_t
       WHERE bgarent = g_enterprise
         AND bgar002 = l_tmp1.xmda004
         
      #abgi165产品分类/厂牌
      LET l_bgas009 = ''    LET l_bgas010 = ''   
      SELECT bgas009,bgas010 INTO l_bgas009,l_bgas010
        FROM bgas_t
       WHERE bgasent = g_enterprise
         AND bgas001 = l_bgeb003
         
      #抓取税区
      LET l_ooef019 = ''
      SELECT ooef019 INTO l_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_tmp1.xmdasite

      #含税否
      LET l_oodb005 = ''
      SELECT oodb005 INTO l_oodb005
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = l_ooef019
         AND oodb002 = l_tmp1.xmdc016
       
      #abgi170       
      LET l_bgea013 = ''    LET l_bgea014 = ''
      SELECT bgea013,bgea014,bgea004
        INTO l_bgea013,l_bgea014,l_bgea004
        FROM bgea_t
       WHERE bgeaent = g_enterprise
         AND bgea001 = g_master.bgcj002
         AND bgea002 = l_tmp1.xmdasite
         AND bgea003 = l_bgeb003
         
      #若期别资料分配方式 = 依参考资料期别,则数量要考虑变动因子abgi320
      IF g_master.c = '1' THEN 
         FOREACH abgp310_p2_cs8 USING l_tmp1.xmdasite,l_bgeb003,l_tmp1.mm 
                                 INTO l_bgcb006,l_bgcb007,l_bgca003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p2_cs8'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
                  
            LET l_qty = ''                  
            #变动率
            IF l_bgca003 = '1' THEN 
               IF cl_null(l_qty) THEN 
                  LET l_qty = l_tmp1.qty * l_bgcb006/100
               ELSE
                  LET l_qty = l_qty + l_tmp1.qty * l_bgcb006/100
               END IF
            END IF
            #变动量
            IF l_bgca003 = '2' THEN 
               IF cl_null(l_qty) THEN 
                  LET l_qty = l_bgcb007
               ELSE
                  LET l_qty = l_qty + l_bgcb007
               END IF
            END IF       
         END FOREACH
      END IF
      
      IF cl_null(l_qty) THEN LET l_qty = 0 END IF
      
      #取价方式
      #最后一期资料,同一料件第1期到录入的最后一期年月,抓取存在资料的最大日期,然后抓最大日期的最大单价
      IF g_master.d = '1' THEN 
         IF cl_null(g_master.date) THEN 
            LET l_yy = l_tmp1.yy
            LET l_mm = g_month_max
         END IF
         #抓取最大日期
         EXECUTE abgp310_p2_pre10 USING l_tmp1.xmdasite,l_tmp1.xmda004,
                                        l_tmp1.xmda023,l_tmp1.xmdc001,l_tmp1.xmdc010,
                                        l_tmp1.xmdc016,l_tmp1.xmdc036,l_tmp1.xmdc037
                                   INTO l_xmdadocdt_max
         #抓取最大单价                       
         EXECUTE abgp310_p2_pre11 USING l_xmdadocdt_max,l_tmp1.xmdasite,l_tmp1.xmda004,
                                        l_tmp1.xmda023,l_tmp1.xmdc001,l_tmp1.xmdc010,
                                        l_tmp1.xmdc016,l_tmp1.xmdc036,l_tmp1.xmdc037
                                   INTO l_xmdc015_max 
                                 
         #抓取币别                  
         EXECUTE abgp310_p2_pre12 USING l_xmdadocdt_max,l_tmp1.xmdasite,l_tmp1.xmda004,
                                        l_tmp1.xmda023,l_tmp1.xmdc001,l_tmp1.xmdc010,
                                        l_xmdc015_max,l_tmp1.xmdc016,l_tmp1.xmdc036,
                                        l_tmp1.xmdc037
                                 INTO l_xmda015
         LET l_bgcj.bgcj039 = l_xmdc015_max
         LET l_bgcj.bgcj100 = l_xmda015
      ELSE
         #标准售价abgi170
         LET l_bgcj.bgcj039 = l_bgea014
         LET l_bgcj.bgcj100 = l_bgea013
      END IF
      
      SELECT ooef017 INTO l_comp 
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_tmp1.xmdasite
         
      SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaacomp = l_comp
         AND glaa014 = 'Y'      

      LET l_year = l_tmp1.yy + 1
      CALL s_get_accdate(l_glaa003,'',l_year,l_tmp1.mm) 
      RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      
      IF NOT cl_null(l_bgcj.bgcj100) AND NOT cl_null(l_bgaa003) THEN 
         CALL s_abg_get_bg_rate(g_master.bgcj002,l_pdate_e,l_bgcj.bgcj100,l_bgaa003)
         RETURNING l_bgcj.bgcj101
      ELSE
         LET l_bgcj.bgcj101 = 1
      END IF
      
      #单价考虑变动因子
      #若期别资料分配方式 = 依参考资料期别,则数量要考虑变动因子abgi320
      IF g_master.e = 'Y' THEN 
         FOREACH abgp310_p2_cs9 USING l_tmp1.xmdasite,l_bgeb003,l_tmp1.mm 
                                 INTO l_bgcb006,l_bgcb007,l_bgca003
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'abgp310_p2_cs9'
               LET g_errparam.popup = TRUE
               CALL cl_err()
             
               LET r_success = FALSE
            END IF
                  
            LET l_price = ''                  
            #变动率
            IF l_bgca003 = '1' THEN 
               IF cl_null(l_price) THEN 
                  LET l_price = l_bgcj.bgcj039 * l_bgcb006/100
               ELSE
                  LET l_price = l_price + l_bgcj.bgcj039 * l_bgcb006/100
               END IF
            END IF
            #变动量
            IF l_bgca003 = '2' THEN 
               IF cl_null(l_price) THEN 
                  LET l_price = l_bgcb007
               ELSE
                  LET l_price = l_price + l_bgcb007
               END IF
            END IF       
         END FOREACH
         IF NOT cl_null(l_price) THEN 
            LET l_bgcj.bgcj039 = l_bgcj.bgcj039 + l_price
         END IF
      END IF

      LET l_bgcj.bgcjent = g_enterprise
      IF g_master.f = '1' THEN 
         LET l_bgcj.bgcj001 = '10'
      ELSE
         LET l_bgcj.bgcj001 = '20'
      END IF
      LET l_bgcj.bgcj002 = g_master.bgcj002
      LET l_bgcj.bgcj003 = g_master.bgcj003
      LET l_bgcj.bgcj004 = l_bgai002
      LET l_bgcj.bgcj005 = '1'
      LET l_bgcj.bgcj006 = '1'
      LET l_bgcj.bgcj007 = l_tmp1.xmdasite
      LET l_bgcj.bgcj008 = l_tmp1.mm
      LET l_bgcj.bgcj009 = l_bgeb003
      LET l_bgcj.bgcj011 = l_bgai008
      LET l_bgcj.bgcj012 = l_pmab081
      LET l_bgcj.bgcj013 = l_pmab109
      LET l_bgcj.bgcj014 = l_ooeg004
      LET l_bgcj.bgcj015 = l_pmaa241
      LET l_bgcj.bgcj016 = l_bgar001
      LET l_bgcj.bgcj017 = l_bgar001
      LET l_bgcj.bgcj018 = l_pmaa090
      LET l_bgcj.bgcj019 = l_bgas009
      LET l_bgcj.bgcj020 = l_tmp1.xmdc036
      LET l_bgcj.bgcj021 = l_tmp1.xmdc037
      LET l_bgcj.bgcj022 = l_pmaa092
      LET l_bgcj.bgcj023 = l_tmp1.xmda023
      LET l_bgcj.bgcj024 = l_bgas010
      
      #abgi110设置
      INITIALIZE l_bgal.* TO NULL
      CALL abgp310_get_bgal(g_master.bgcj002,l_tmp1.xmdasite,l_bgai006) RETURNING l_bgal.*
      
      #人员
      IF l_bgal.bgal012 = 'N' THEN 
         LET l_bgcj.bgcj012 = ' '
      END IF
      
      #部门
      IF l_bgal.bgal005 = 'N' THEN 
         LET l_bgcj.bgcj013 = ' '
      END IF
      
      #成本利润中心
      IF l_bgal.bgal006 = 'N' THEN 
         LET l_bgcj.bgcj014 = ' '
      END IF
      
      #区域
      IF l_bgal.bgal007 = 'N' THEN 
         LET l_bgcj.bgcj015 = ' '
      END IF
      
      #收付款客商
      IF l_bgal.bgal008 = 'N' THEN 
         LET l_bgcj.bgcj016 = ' '
      END IF
      
      #账款客商
      IF l_bgal.bgal009 = 'N' THEN 
         LET l_bgcj.bgcj017 = ' '
      END IF
      
      #客群
      IF l_bgal.bgal010 = 'N' THEN 
         LET l_bgcj.bgcj018 = ' '
      END IF
      
      #产品类别
      IF l_bgal.bgal011 = 'N' THEN 
         LET l_bgcj.bgcj019 = ' '
      END IF
      
      #经营方式
      IF l_bgal.bgal025 = 'N' THEN 
         LET l_bgcj.bgcj022 = ' '
      END IF
      
      #通路
      IF l_bgal.bgal026 = 'N' THEN 
         LET l_bgcj.bgcj023 = ' '
      END IF
      
      #品牌
      IF l_bgal.bgal027 = 'N' THEN 
         LET l_bgcj.bgcj024 = ' '
      END IF
      
      IF cl_null(l_bgcj.bgcj012) THEN LET l_bgcj.bgcj012 = ' ' END IF
      IF cl_null(l_bgcj.bgcj013) THEN LET l_bgcj.bgcj013 = ' ' END IF
      IF cl_null(l_bgcj.bgcj014) THEN LET l_bgcj.bgcj014 = ' ' END IF
      IF cl_null(l_bgcj.bgcj015) THEN LET l_bgcj.bgcj015 = ' ' END IF
      IF cl_null(l_bgcj.bgcj016) THEN LET l_bgcj.bgcj016 = ' ' END IF
      IF cl_null(l_bgcj.bgcj017) THEN LET l_bgcj.bgcj017 = ' ' END IF
      IF cl_null(l_bgcj.bgcj018) THEN LET l_bgcj.bgcj018 = ' ' END IF
      IF cl_null(l_bgcj.bgcj019) THEN LET l_bgcj.bgcj019 = ' ' END IF
      IF cl_null(l_bgcj.bgcj020) THEN LET l_bgcj.bgcj020 = ' ' END IF
      IF cl_null(l_bgcj.bgcj021) THEN LET l_bgcj.bgcj021 = ' ' END IF
      IF cl_null(l_bgcj.bgcj022) THEN LET l_bgcj.bgcj022 = ' ' END IF
      IF cl_null(l_bgcj.bgcj023) THEN LET l_bgcj.bgcj023 = ' ' END IF
      IF cl_null(l_bgcj.bgcj024) THEN LET l_bgcj.bgcj024 = ' ' END IF
      
      #组合key bgeg010
      LET l_bgcj.bgcj010 = "bgcj013=",l_bgcj.bgcj013,"/",
                           "bgcj014=",l_bgcj.bgcj014,"/",
                           "bgcj015=",l_bgcj.bgcj015,"/",
                           "bgcj016=",l_bgcj.bgcj016,"/",
                           "bgcj017=",l_bgcj.bgcj017,"/",
                           "bgcj018=",l_bgcj.bgcj018,"/",
                           "bgcj019=",l_bgcj.bgcj019,"/",
                           "bgcj022=",l_bgcj.bgcj022,"/",
                           "bgcj023=",l_bgcj.bgcj023,"/",
                           "bgcj024=",l_bgcj.bgcj024,"/",
                           "bgcj012=",l_bgcj.bgcj012,"/",
                           "bgcj020=",l_bgcj.bgcj020,"/",
                           "bgcj021=",l_bgcj.bgcj021,""

      SELECT COUNT(1) INTO l_n
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj008 = l_bgcj.bgcj008
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010       
         
      IF l_n > 0 THEN 
         CONTINUE FOREACH
      END IF
      
      LET l_bgcjstus = ''
      SELECT bgcjstus INTO l_bgcjstus
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj008 = l_bgcj.bgcj008
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010
         
     IF l_bgcjstus = 'Y' THEN 
        CONTINUE FOREACH
     END IF

      LET l_bgcj.bgcj025 = ' '
      LET l_bgcj.bgcj026 = ' '
      LET l_bgcj.bgcj027 = ' '
      LET l_bgcj.bgcj028 = ' '
      LET l_bgcj.bgcj029 = ' '
      LET l_bgcj.bgcj030 = ' '
      LET l_bgcj.bgcj031 = ' '
      LET l_bgcj.bgcj032 = ' '
      LET l_bgcj.bgcj033 = ' '
      LET l_bgcj.bgcj034 = ' '
      LET l_bgcj.bgcj035 = l_tmp1.xmdc016
      LET l_bgcj.bgcj036 = l_oodb005
      LET l_bgcj.bgcj037 = l_tmp1.xmdc010
      LET l_bgcj.bgcj038 = l_tmp1.qty + l_qty
      LET l_bgcj.bgcj040 = l_bgcj.bgcj038 * l_bgcj.bgcj039
      LET l_bgcj.bgcj041 = 0
      LET l_bgcj.bgcj042 = 0
      LET l_bgcj.bgcj043 = 0
      LET l_bgcj.bgcj044 = 0
      LET l_bgcj.bgcj045 = l_bgcj.bgcj038
      LET l_bgcj.bgcj046 = l_bgcj.bgcj039
      LET l_bgcj.bgcj047 = ''
      LET l_bgcj.bgcj048 = 'N'
      LET l_bgcj.bgcj049 = ''
      LET l_bgcj.bgcj050 = '2'
      LET l_bgcj.bgcj102 = l_bgcj.bgcj038 * l_bgcj.bgcj039
      
      CALL s_tax_count(l_tmp1.xmdasite,l_bgcj.bgcj035,l_bgcj.bgcj102,
                               0,l_bgcj.bgcj100,l_bgcj.bgcj101)
      RETURNING l_bgcj.bgcj103,l_bgcj.bgcj104,l_bgcj.bgcj105,
                r_xrcd113,r_xrcd114,r_xrcd115

      LET l_bgcj.bgcjownid = g_user
      LET l_bgcj.bgcjowndp = g_dept
      LET l_bgcj.bgcjcrtid = g_user
      LET l_bgcj.bgcjcrtdp = g_dept 
      LET l_bgcj.bgcjcrtdt = cl_get_current()
      LET l_bgcj.bgcjmodid = g_user
      LET l_bgcj.bgcjmoddt = cl_get_current()
      LET l_bgcj.bgcjstus = 'N'
      
      SELECT MAX(bgcjseq) + 1 INTO l_bgcj.bgcjseq
        FROM bgcj_t
       WHERE bgcjent = g_enterprise
         AND bgcj001 = l_bgcj.bgcj001
         AND bgcj002 = l_bgcj.bgcj002
         AND bgcj003 = l_bgcj.bgcj003
         AND bgcj004 = l_bgcj.bgcj004
         AND bgcj005 = l_bgcj.bgcj005
         AND bgcj006 = l_bgcj.bgcj006
         AND bgcj007 = l_bgcj.bgcj007
         AND bgcj009 = l_bgcj.bgcj009
         AND bgcj010 = l_bgcj.bgcj010
         
      IF cl_null(l_bgcj.bgcjseq) THEN LET l_bgcj.bgcjseq = 1 END IF
      
      INSERT INTO bgcj_t(bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                         bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                         bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                         bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                         bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                         bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                         bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                         bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                         bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                         bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                         bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                         bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                         bgcj105,
                         bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                         bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus)
     VALUES(l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
            l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
            l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
            l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
            l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
            l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
            l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
            l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
            l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
            l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
            l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
            l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
            l_bgcj.bgcj105,
            l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
            l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus)
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins bgeg_t'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF 
      
      LET r_flag = 'Y'
      
      #161215-00051#4--add--str--lujh
      #将本次插入的资料放临时表里存起来,全部执行完之后看看1-12(13)期是否都有资料,没资料要塞一笔金额是0的资料
      INSERT INTO abgp310_tmp07 VALUES(l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,
                                       l_bgcj.bgcj004,l_bgcj.bgcj005,l_bgcj.bgcj006,
                                       l_bgcj.bgcj007,l_bgcj.bgcj009,l_bgcj.bgcj010,
                                       l_bgcj.bgcjseq)
      
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = 'ins bgfb_t'
         LET g_errparam.code   = sqlca.sqlcode
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
      END IF
      #161215-00051#4--add--end--lujh
   END FOREACH
   
   #161215-00051#4--add--str--lujh
   LET l_sql = "SELECT DISTINCT bgcj001,bgcj002,bgcj003,",
               "                bgcj004,bgcj005,bgcj006,",
               "                bgcj007,bgcj009,bgcj010,",
               "                bgcjseq ",
               "  FROM abgp310_tmp07 "
   PREPARE abgp310_p2_pre13 FROM l_sql
   DECLARE abgp310_p2_cs13 CURSOR FOR abgp310_p2_pre13
   
   FOREACH abgp310_p2_cs13 INTO l_bgcj1.bgcj001,l_bgcj1.bgcj002,l_bgcj1.bgcj003,
                                l_bgcj1.bgcj004,l_bgcj1.bgcj005,l_bgcj1.bgcj006,
                                l_bgcj1.bgcj007,l_bgcj1.bgcj009,l_bgcj1.bgcj010,
                                l_bgcj1.bgcjseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'abgp310_p1_cs13'
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET r_success = FALSE
      END IF
   
      FOR l_i = 1 TO g_month_max
         LET l_n = 0
         SELECT COUNT(*) INTO l_n
           FROM bgcj_t
          WHERE bgcjent = g_enterprise
            AND bgcj001 = l_bgcj1.bgcj001
            AND bgcj002 = l_bgcj1.bgcj002
            AND bgcj003 = l_bgcj1.bgcj003
            AND bgcj004 = l_bgcj1.bgcj004
            AND bgcj005 = l_bgcj1.bgcj005
            AND bgcj006 = l_bgcj1.bgcj006
            AND bgcj007 = l_bgcj1.bgcj007
            AND bgcj008 = l_i
            AND bgcj009 = l_bgcj1.bgcj009
            AND bgcj010 = l_bgcj1.bgcj010 
            AND bgcjseq = l_bgcj1.bgcjseq
            
         IF l_n = 0 THEN 
            INITIALIZE l_bgcj.* TO NULL
            
            SELECT DISTINCT bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                            bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                            bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                            bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                            bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                            bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                            bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                            bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                            bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                            bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                            bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                            bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                            bgcj105,
                            bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                            bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus
              INTO l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
                   l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
                   l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
                   l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
                   l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
                   l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
                   l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
                   l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
                   l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
                   l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
                   l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
                   l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
                   l_bgcj.bgcj105,
                   l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
                   l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus
              FROM bgcj_t
             WHERE bgcjent = g_enterprise
               AND bgcj001 = l_bgcj1.bgcj001
               AND bgcj002 = l_bgcj1.bgcj002
               AND bgcj003 = l_bgcj1.bgcj003
               AND bgcj004 = l_bgcj1.bgcj004
               AND bgcj005 = l_bgcj1.bgcj005
               AND bgcj006 = l_bgcj1.bgcj006
               AND bgcj007 = l_bgcj1.bgcj007
               AND bgcj009 = l_bgcj1.bgcj009
               AND bgcj010 = l_bgcj1.bgcj010 
               AND bgcjseq = l_bgcj1.bgcjseq 
              
            LET l_bgcj.bgcj008 = l_i  
            LET l_bgcj.bgcj038 = 0
            LET l_bgcj.bgcj039 = 0
            LET l_bgcj.bgcj040 = 0
            LET l_bgcj.bgcj041 = 0  
            LET l_bgcj.bgcj042 = 0  
            LET l_bgcj.bgcj043 = 0  
            LET l_bgcj.bgcj044 = 0  
            LET l_bgcj.bgcj045 = 0  
            LET l_bgcj.bgcj046 = 0  
            LET l_bgcj.bgcj102 = 0 
            LET l_bgcj.bgcj103 = 0     
            LET l_bgcj.bgcj104 = 0     
            LET l_bgcj.bgcj105 = 0    

            INSERT INTO bgcj_t(bgcjent,bgcj001,bgcj002,bgcj003,bgcj004,
                               bgcj005,bgcj006,bgcj007,bgcj008,bgcj009,
                               bgcj010,bgcjseq,bgcj011,bgcj012,bgcj013,
                               bgcj014,bgcj015,bgcj016,bgcj017,bgcj018,
                               bgcj019,bgcj020,bgcj021,bgcj022,bgcj023,
                               bgcj024,bgcj025,bgcj026,bgcj027,bgcj028,
                               bgcj029,bgcj030,bgcj031,bgcj032,bgcj033,
                               bgcj034,bgcj035,bgcj036,bgcj037,bgcj038,
                               bgcj039,bgcj040,bgcj041,bgcj042,bgcj043,
                               bgcj044,bgcj045,bgcj046,bgcj047,bgcj048,
                               bgcj049,bgcj050,bgcj051,bgcj052,bgcj053,
                               bgcj100,bgcj101,bgcj102,bgcj103,bgcj104,
                               bgcj105,
                               bgcjownid,bgcjowndp,bgcjcrtid,bgcjcrtdp,bgcjcrtdt,
                               bgcjmodid,bgcjmoddt,bgcjcnfid,bgcjcnfdt,bgcjstus)
            VALUES(l_bgcj.bgcjent,l_bgcj.bgcj001,l_bgcj.bgcj002,l_bgcj.bgcj003,l_bgcj.bgcj004,
                   l_bgcj.bgcj005,l_bgcj.bgcj006,l_bgcj.bgcj007,l_bgcj.bgcj008,l_bgcj.bgcj009,
                   l_bgcj.bgcj010,l_bgcj.bgcjseq,l_bgcj.bgcj011,l_bgcj.bgcj012,l_bgcj.bgcj013,
                   l_bgcj.bgcj014,l_bgcj.bgcj015,l_bgcj.bgcj016,l_bgcj.bgcj017,l_bgcj.bgcj018,
                   l_bgcj.bgcj019,l_bgcj.bgcj020,l_bgcj.bgcj021,l_bgcj.bgcj022,l_bgcj.bgcj023,
                   l_bgcj.bgcj024,l_bgcj.bgcj025,l_bgcj.bgcj026,l_bgcj.bgcj027,l_bgcj.bgcj028,
                   l_bgcj.bgcj029,l_bgcj.bgcj030,l_bgcj.bgcj031,l_bgcj.bgcj032,l_bgcj.bgcj033,
                   l_bgcj.bgcj034,l_bgcj.bgcj035,l_bgcj.bgcj036,l_bgcj.bgcj037,l_bgcj.bgcj038,
                   l_bgcj.bgcj039,l_bgcj.bgcj040,l_bgcj.bgcj041,l_bgcj.bgcj042,l_bgcj.bgcj043,
                   l_bgcj.bgcj044,l_bgcj.bgcj045,l_bgcj.bgcj046,l_bgcj.bgcj047,l_bgcj.bgcj048,
                   l_bgcj.bgcj049,l_bgcj.bgcj050,l_bgcj.bgcj051,l_bgcj.bgcj052,l_bgcj.bgcj053,
                   l_bgcj.bgcj100,l_bgcj.bgcj101,l_bgcj.bgcj102,l_bgcj.bgcj103,l_bgcj.bgcj104,
                   l_bgcj.bgcj105,
                   l_bgcj.bgcjownid,l_bgcj.bgcjowndp,l_bgcj.bgcjcrtid,l_bgcj.bgcjcrtdp,l_bgcj.bgcjcrtdt,
                   l_bgcj.bgcjmodid,l_bgcj.bgcjmoddt,l_bgcj.bgcjcnfid,l_bgcj.bgcjcnfdt,l_bgcj.bgcjstus)
            
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins bgcj_t'
               LET g_errparam.code   = sqlca.sqlcode
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET r_success = FALSE
            END IF
         END IF
      END FOR
   END FOREACH
   #161215-00051#4--add--end--lujh
   
   RETURN r_success,r_flag
END FUNCTION
# 抓取abgi110设置
PRIVATE FUNCTION abgp310_get_bgal(p_bgal001,p_bgal002,p_bgal003)
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

#end add-point
 
{</section>}
 
