#該程式未解開Section, 採用最新樣板產出!
{<section id="axcp160.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2014-09-10 20:52:23), PR版次:0012(2017-01-05 11:02:30)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000135
#+ Filename...: axcp160
#+ Description: 工單重工自動設定作業
#+ Creator....: 02291(2014-04-02 10:34:56)
#+ Modifier...: 02291 -SD/PR- 06948
 
{</section>}
 
{<section id="axcp160.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#46  2016/04/28   By 07959   將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160328-00022#4   2016/06/20   By 02097   增加進度條顯示
#161124-00048#16  2016/12/16   By 08734   星号整批调整
#161215-00036#1   2017/01/05   By 06948   增加背景執行功能
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目 name="global.import"
GLOBALS "../../../com/sub/4gl/s_axcp500.inc"
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
   #161215-00036#1 20161226 add (S)
   glaacomp         LIKE type_t.chr500,
   sfaadocno        LIKE type_t.chr500,
   sfaa019          LIKE type_t.chr500,
   sfaadocdt        LIKE type_t.chr500,
   year             LIKE type_t.chr500,
   month            LIKE type_t.chr500,
   sw_1             LIKE type_t.chr500,
   sw_2             LIKE type_t.chr500,
   #161215-00036#1 20161226 add (E)
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       glaacomp LIKE type_t.chr500, 
   glaacomp_desc LIKE type_t.chr80, 
   sfaadocno LIKE type_t.chr500, 
   sfaa019 LIKE type_t.chr500, 
   sfaadocdt LIKE type_t.chr500, 
   year LIKE type_t.chr500, 
   month LIKE type_t.chr500, 
   sw_1 LIKE type_t.chr500, 
   sw_2 LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#單頭 type 宣告
 TYPE type_g_glaa_m RECORD
   glaacomp LIKE glaa_t.glaacomp,
   glaacomp_desc LIKE type_t.chr80,
   year LIKE type_t.num5,
   month LIKE type_t.num5,
   sw_1 LIKE type_t.chr1,
   sw_2 LIKE type_t.chr1
END RECORD
DEFINE g_glaa_m     type_g_glaa_m
DEFINE g_glaa_m_t   type_g_glaa_m
DEFINE l_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE l_edate      LIKE glav_t.glav004
DEFINE g_success    LIKE type_t.chr1
DEFINE g_wc2        STRING
DEFINE g_glaa003    LIKE glaa_t.glaa003
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcp160.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axcp160_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcp160 WITH FORM cl_ap_formpath("axc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axcp160_init()
 
      #進入選單 Menu (="N")
      CALL axcp160_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axcp160
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axcp160.init" >}
#+ 初始化作業
PRIVATE FUNCTION axcp160_init()
 
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
   LET g_master.sw_1 = 'Y'
   LET g_master.sw_2 = 'Y'
   DISPLAY g_master.sw_1,g_master.sw_2 TO sw_1,sw_2
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axcp160.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcp160_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   CALL axcp160_construct()
   RETURN
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.glaacomp,g_master.sfaadocno,g_master.sfaa019,g_master.sfaadocdt,g_master.year, 
             g_master.month,g_master.sw_1,g_master.sw_2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="input.a.glaacomp"
            SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t
             WHERE ooeflent=g_enterprise AND ooefl001=g_glaa_m.glaacomp AND ooefl002=g_dlang


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="input.b.glaacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glaacomp
            #add-point:ON CHANGE glaacomp name="input.g.glaacomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocno
            #add-point:BEFORE FIELD sfaadocno name="input.b.sfaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocno
            
            #add-point:AFTER FIELD sfaadocno name="input.a.sfaadocno"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaadocno
            #add-point:ON CHANGE sfaadocno name="input.g.sfaadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa019
            #add-point:BEFORE FIELD sfaa019 name="input.b.sfaa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa019
            
            #add-point:AFTER FIELD sfaa019 name="input.a.sfaa019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaa019
            #add-point:ON CHANGE sfaa019 name="input.g.sfaa019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocdt
            #add-point:BEFORE FIELD sfaadocdt name="input.b.sfaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocdt
            
            #add-point:AFTER FIELD sfaadocdt name="input.a.sfaadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sfaadocdt
            #add-point:ON CHANGE sfaadocdt name="input.g.sfaadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year
            #add-point:ON CHANGE year name="input.g.year"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="input.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="input.a.month"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sw_1
            #add-point:BEFORE FIELD sw_1 name="input.b.sw_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sw_1
            
            #add-point:AFTER FIELD sw_1 name="input.a.sw_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sw_1
            #add-point:ON CHANGE sw_1 name="input.g.sw_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sw_2
            #add-point:BEFORE FIELD sw_2 name="input.b.sw_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sw_2
            
            #add-point:AFTER FIELD sw_2 name="input.a.sw_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sw_2
            #add-point:ON CHANGE sw_2 name="input.g.sw_2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.glaacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="input.c.glaacomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_glaa_m.glaacomp             #給予default值
            LET g_qryparam.default2 = "" #g__m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_glaa_m.glaacomp = g_qryparam.return1              
            #LET g__m.ooefl003 = g_qryparam.return2 
            DISPLAY g_glaa_m.glaacomp TO glaacomp              #
            #DISPLAY g__m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD glaacomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sfaadocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno name="input.c.sfaadocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.sfaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa019
            #add-point:ON ACTION controlp INFIELD sfaa019 name="input.c.sfaa019"
            
            #END add-point
 
 
         #Ctrlp:input.c.sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocdt
            #add-point:ON ACTION controlp INFIELD sfaadocdt name="input.c.sfaadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="input.c.year"
            
            #END add-point
 
 
         #Ctrlp:input.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="input.c.month"
            
            #END add-point
 
 
         #Ctrlp:input.c.sw_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sw_1
            #add-point:ON ACTION controlp INFIELD sw_1 name="input.c.sw_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.sw_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sw_2
            #add-point:ON ACTION controlp INFIELD sw_2 name="input.c.sw_2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON glaacomp,sfaadocno,sfaa019,sfaadocdt,year,month,sw_1,sw_2
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glaacomp
            #add-point:BEFORE FIELD glaacomp name="construct.b.glaacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glaacomp
            
            #add-point:AFTER FIELD glaacomp name="construct.a.glaacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.glaacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glaacomp
            #add-point:ON ACTION controlp INFIELD glaacomp name="construct.c.glaacomp"
            
            #END add-point
 
 
         #Ctrlp:construct.c.sfaadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocno
            #add-point:ON ACTION controlp INFIELD sfaadocno name="construct.c.sfaadocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
            NEXT FIELD sfaadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocno
            #add-point:BEFORE FIELD sfaadocno name="construct.b.sfaadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocno
            
            #add-point:AFTER FIELD sfaadocno name="construct.a.sfaadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaa019
            #add-point:BEFORE FIELD sfaa019 name="construct.b.sfaa019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaa019
            
            #add-point:AFTER FIELD sfaa019 name="construct.a.sfaa019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaa019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaa019
            #add-point:ON ACTION controlp INFIELD sfaa019 name="construct.c.sfaa019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sfaadocdt
            #add-point:BEFORE FIELD sfaadocdt name="construct.b.sfaadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sfaadocdt
            
            #add-point:AFTER FIELD sfaadocdt name="construct.a.sfaadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sfaadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sfaadocdt
            #add-point:ON ACTION controlp INFIELD sfaadocdt name="construct.c.sfaadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="construct.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="construct.a.year"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.year
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year
            #add-point:ON ACTION controlp INFIELD year name="construct.c.year"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month
            #add-point:BEFORE FIELD month name="construct.b.month"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month
            
            #add-point:AFTER FIELD month name="construct.a.month"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month
            #add-point:ON ACTION controlp INFIELD month name="construct.c.month"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sw_1
            #add-point:BEFORE FIELD sw_1 name="construct.b.sw_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sw_1
            
            #add-point:AFTER FIELD sw_1 name="construct.a.sw_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sw_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sw_1
            #add-point:ON ACTION controlp INFIELD sw_1 name="construct.c.sw_1"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sw_2
            #add-point:BEFORE FIELD sw_2 name="construct.b.sw_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sw_2
            
            #add-point:AFTER FIELD sw_2 name="construct.a.sw_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sw_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sw_2
            #add-point:ON ACTION controlp INFIELD sw_2 name="construct.c.sw_2"
            
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
            CALL axcp160_get_buffer(l_dialog)
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
         CALL axcp160_init()
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
                 CALL axcp160_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axcp160_transfer_argv(ls_js)
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
 
{<section id="axcp160.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axcp160_transfer_argv(ls_js)
 
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
 
{<section id="axcp160.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axcp160_process(ls_js)
 
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
   #CALL cl_progress_bar_no_window(4)  --- zhouhuaa 160613 维护进度条功能  #160328-00022#4 mark
   #161215-00036#1 add (S)
   LET g_wc2 = lc_param.wc
   LET g_glaa_m.glaacomp = lc_param.glaacomp
   LET g_glaa_m.year = lc_param.year
   LET g_glaa_m.month = lc_param.month
   LET g_glaa_m.sw_1 = lc_param.sw_1
   LET g_glaa_m.sw_2 = lc_param.sw_2
   SELECT glaa003 INTO g_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise AND glaa014 = 'Y'
      AND glaacomp = g_glaa_m.glaacomp    
   IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
      CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
          RETURNING l_bdate,l_edate               
   END IF               
   #161215-00036#1 add (E)
   CALL axcp160_upd_sfaa()
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
#      CALL axcp160_upd_sfaa()
 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axcp160_process_cs CURSOR FROM ls_sql
#  FOREACH axcp160_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
#      CALL axcp160_upd_sfaa()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
#      CALL axcp160_upd_sfaa()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axcp160_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axcp160.get_buffer" >}
PRIVATE FUNCTION axcp160_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.glaacomp = p_dialog.getFieldBuffer('glaacomp')
   LET g_master.sfaadocno = p_dialog.getFieldBuffer('sfaadocno')
   LET g_master.sfaa019 = p_dialog.getFieldBuffer('sfaa019')
   LET g_master.sfaadocdt = p_dialog.getFieldBuffer('sfaadocdt')
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.sw_1 = p_dialog.getFieldBuffer('sw_1')
   LET g_master.sw_2 = p_dialog.getFieldBuffer('sw_2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcp160.msgcentre_notify" >}
PRIVATE FUNCTION axcp160_msgcentre_notify()
 
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
 
{<section id="axcp160.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_construct()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num5
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   
   CLEAR FORM
   INITIALIZE g_glaa_m.* TO NULL
   LET g_glaa_m.sw_1 = 'N'
   LET g_glaa_m.sw_2 = 'N'
   INITIALIZE g_wc2 TO NULL
   
   WHILE TRUE
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_glaa_m.glaacomp
       
      
         BEFORE INPUT 
            LET g_glaa_m.sw_1 = 'Y'
            LET g_glaa_m.sw_2 = 'Y'
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
            END IF 
            DISPLAY BY NAME g_glaa_m.sw_1,g_glaa_m.sw_2
            CALL axcp160_head_default() #dorislai-20151023-add      
         
         AFTER FIELD glaacomp
        
            IF NOT cl_null(g_glaa_m.glaacomp) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_glaa_m.glaacomp
               #160318-00025#46  2016/04/28  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#46  2016/04/28  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF NOT cl_chk_exist('v_ooef001_15') THEN
                  #檢查失敗時後續處理
                  LET g_glaa_m.glaacomp = g_glaa_m_t.glaacomp
                  CALL axcp160_glaacomp_desc()
                  NEXT FIELD glaacomp
               END IF
               CALL axcp160_glaacomp_desc()        {#ADP版次:1#}
               #dorislai-20151023-modify----(S)  改用function抓年度/期別
#               SELECT glaa003,glaa010,glaa011 INTO g_glaa003,g_glaa_m.year,g_glaa_m.month FROM glaa_t
#                WHERE glaaent = g_enterprise AND glaa014 = 'Y'
#                  AND glaacomp = g_glaa_m.glaacomp 
               SELECT glaa003 INTO g_glaa003 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                  AND glaacomp = g_glaa_m.glaacomp    
               #dorislai-20151023-modify----(E)               
               IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
               END IF
              DISPLAY BY NAME g_glaa_m.year,g_glaa_m.month
                                                    
            END IF            
            
             
          ON ACTION controlp INFIELD glaacomp
	  	     #開窗i段
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                LET g_qryparam.reqry = FALSE
		        
                LET g_qryparam.default1 = g_glaa_m.glaacomp            #給予default值
                LET g_qryparam.where = " ooef003 = 'Y'"
		        
                #給予arg
                CALL q_ooef001()
		        
                LET g_glaa_m.glaacomp = g_qryparam.return1              #將開窗取得的值回傳到變數
		        
		        
                DISPLAY g_glaa_m.glaacomp TO glaacomp              #顯示到畫面上
                LET g_qryparam.where = NULL
                CALL axcp160_glaacomp_desc()
		        
                NEXT FIELD glaacomp                          #返回原欄位          
            
        AFTER INPUT
     END INPUT
     
     CONSTRUCT BY NAME g_wc2 ON sfaadocno,sfaa019,sfaadocdt
       BEFORE CONSTRUCT
          CALL cl_qbe_init() 
               
          
       ON ACTION controlp INFIELD sfaadocno     #單據單號開窗
          INITIALIZE g_qryparam.* TO NULL
          LET g_qryparam.state = 'c'
		  LET g_qryparam.reqry = FALSE
		  LET g_qryparam.where = " sfaastus <> 'M'  "
          CALL q_sfaadocno_1()                    #呼叫開窗
          DISPLAY g_qryparam.return1 TO sfaadocno  #顯示到畫面上
          NEXT FIELD sfaadocno
          
       
      END CONSTRUCT   
     
      INPUT BY NAME g_glaa_m.year,g_glaa_m.month,g_glaa_m.sw_1,g_glaa_m.sw_2
       
      
         BEFORE INPUT 
         
         AFTER FIELD year
        
            IF NOT cl_null(g_glaa_m.year) THEN
               IF NOT s_fin_date_chk_year(g_glaa_m.year) THEN
                  LET g_glaa_m.year = g_glaa_m_t.year
                  DISPLAY BY NAME g_glaa_m.year
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = g_glaa_m.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
                                                    
            END IF  
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
            END IF               
            
         BEFORE FIELD month
            IF cl_null(g_glaa_m.year) THEN
               NEXT FIELD year
            END IF

         AFTER FIELD month
            IF NOT cl_null(g_glaa_m.month) THEN                      
               IF NOT s_fin_date_chk_period(g_glaa003,g_glaa_m.year,g_glaa_m.month) THEN
                  LET g_glaa_m.month = g_glaa_m_t.month
                  DISPLAY BY NAME g_glaa_m.month
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'amm-00106'
                  LET g_errparam.extend = g_glaa_m.month
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF
            IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
               CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
                   RETURNING l_bdate,l_edate               
            END IF 
        AFTER INPUT
        
     END INPUT
          
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL axcp160_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog

            #end add-point
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axcp160_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET lc_param.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後

               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION batch_execute
            ACCEPT DIALOG
 
         ON ACTION qbeclear         
            CLEAR FORM
            INITIALIZE lc_param.* TO NULL
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
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #add-point:ui_dialog段exit dialog
      #161215-00036#1 add (S)
      LET lc_param.wc = g_wc2
      LET lc_param.glaacomp = g_glaa_m.glaacomp
      LET lc_param.year = g_glaa_m.year
      LET lc_param.month = g_glaa_m.month
      LET lc_param.sw_1 = g_glaa_m.sw_1
      LET lc_param.sw_2 = g_glaa_m.sw_2
      SELECT glaa003 INTO g_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaa014 = 'Y'
         AND glaacomp = g_glaa_m.glaacomp    
      IF NOT cl_null(g_glaa_m.year) AND NOT cl_null(g_glaa_m.month) THEN
         CALL s_fin_date_get_period_range(g_glaa003, g_glaa_m.year,g_glaa_m.month)
             RETURNING l_bdate,l_edate               
      END IF               
      #161215-00036#1 add (E)
      #end add-point
 
      LET ls_js = util.JSON.stringify(lc_param)
 
      IF INT_FLAG THEN
         LET INT_FLAG = FALSE
         EXIT WHILE
      ELSE
         #LET g_jobid = cl_schedule_get_jobid(g_prog)
         IF g_chk_jobid THEN 
            LET g_jobid = g_schedule.gzpa001
         ELSE 
            LET g_jobid = cl_schedule_get_jobid(g_prog)
         END IF 
         CASE 
            WHEN g_schedule.gzpa003 = "0"
                 CALL axcp160_process(ls_js)
            WHEN g_schedule.gzpa003 = "1"
            #    CALL cl_schedule_update_data(g_jobid,ls_js)
                 LET ls_js = axcp160_transfer_argv(ls_js)
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

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_glaacomp_desc()
   SELECT ooefl003 INTO g_glaa_m.glaacomp_desc FROM ooefl_t 
    WHERE ooeflent=g_enterprise AND ooefl001=g_glaa_m.glaacomp AND ooefl002=g_dlang

   DISPLAY BY NAME g_glaa_m.glaacomp_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_upd_sfaa()
DEFINE l_sql            STRING
#DEFINE l_sfaa           RECORD LIKE sfaa_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_sfaa RECORD  #工單單頭檔
       sfaaent LIKE sfaa_t.sfaaent, #企业编号
       sfaaownid LIKE sfaa_t.sfaaownid, #资料所有者
       sfaaowndp LIKE sfaa_t.sfaaowndp, #资料所有部门
       sfaacrtid LIKE sfaa_t.sfaacrtid, #资料录入者
       sfaacrtdp LIKE sfaa_t.sfaacrtdp, #资料录入部门
       sfaacrtdt LIKE sfaa_t.sfaacrtdt, #资料创建日
       sfaamodid LIKE sfaa_t.sfaamodid, #资料更改者
       sfaamoddt LIKE sfaa_t.sfaamoddt, #最近更改日
       sfaacnfid LIKE sfaa_t.sfaacnfid, #资料审核者
       sfaacnfdt LIKE sfaa_t.sfaacnfdt, #数据审核日
       sfaapstid LIKE sfaa_t.sfaapstid, #资料过账者
       sfaapstdt LIKE sfaa_t.sfaapstdt, #资料过账日
       sfaastus LIKE sfaa_t.sfaastus, #状态码
       sfaasite LIKE sfaa_t.sfaasite, #营运据点
       sfaadocno LIKE sfaa_t.sfaadocno, #单号
       sfaadocdt LIKE sfaa_t.sfaadocdt, #单据日期
       sfaa001 LIKE sfaa_t.sfaa001, #变更版本
       sfaa002 LIKE sfaa_t.sfaa002, #生管人员
       sfaa003 LIKE sfaa_t.sfaa003, #工单类型
       sfaa004 LIKE sfaa_t.sfaa004, #发料制度
       sfaa005 LIKE sfaa_t.sfaa005, #工单来源
       sfaa006 LIKE sfaa_t.sfaa006, #来源单号
       sfaa007 LIKE sfaa_t.sfaa007, #来源项次
       sfaa008 LIKE sfaa_t.sfaa008, #来源项序
       sfaa009 LIKE sfaa_t.sfaa009, #参考客户
       sfaa010 LIKE sfaa_t.sfaa010, #生产料号
       sfaa011 LIKE sfaa_t.sfaa011, #特性
       sfaa012 LIKE sfaa_t.sfaa012, #生产数量
       sfaa013 LIKE sfaa_t.sfaa013, #生产单位
       sfaa014 LIKE sfaa_t.sfaa014, #BOM版本
       sfaa015 LIKE sfaa_t.sfaa015, #BOM有效日期
       sfaa016 LIKE sfaa_t.sfaa016, #工艺编号
       sfaa017 LIKE sfaa_t.sfaa017, #部门供应商
       sfaa018 LIKE sfaa_t.sfaa018, #协作据点
       sfaa019 LIKE sfaa_t.sfaa019, #预计开工日
       sfaa020 LIKE sfaa_t.sfaa020, #预计完工日
       sfaa021 LIKE sfaa_t.sfaa021, #母工单单号
       sfaa022 LIKE sfaa_t.sfaa022, #参考原始单号
       sfaa023 LIKE sfaa_t.sfaa023, #参考原始项次
       sfaa024 LIKE sfaa_t.sfaa024, #参考原始项序
       sfaa025 LIKE sfaa_t.sfaa025, #前工单单号
       sfaa026 LIKE sfaa_t.sfaa026, #料表批号(PBI)
       sfaa027 LIKE sfaa_t.sfaa027, #No Use
       sfaa028 LIKE sfaa_t.sfaa028, #项目编号
       sfaa029 LIKE sfaa_t.sfaa029, #WBS
       sfaa030 LIKE sfaa_t.sfaa030, #活动
       sfaa031 LIKE sfaa_t.sfaa031, #理由码
       sfaa032 LIKE sfaa_t.sfaa032, #紧急比率
       sfaa033 LIKE sfaa_t.sfaa033, #优先级
       sfaa034 LIKE sfaa_t.sfaa034, #预计入库库位
       sfaa035 LIKE sfaa_t.sfaa035, #预计入库储位
       sfaa036 LIKE sfaa_t.sfaa036, #手册编号
       sfaa037 LIKE sfaa_t.sfaa037, #保税核准文号
       sfaa038 LIKE sfaa_t.sfaa038, #保税核销
       sfaa039 LIKE sfaa_t.sfaa039, #备料已生成
       sfaa040 LIKE sfaa_t.sfaa040, #生产工艺路线已审核
       sfaa041 LIKE sfaa_t.sfaa041, #冻结
       sfaa042 LIKE sfaa_t.sfaa042, #返工
       sfaa043 LIKE sfaa_t.sfaa043, #备置
       sfaa044 LIKE sfaa_t.sfaa044, #FQC
       sfaa045 LIKE sfaa_t.sfaa045, #实际开始发料日
       sfaa046 LIKE sfaa_t.sfaa046, #最后入库日
       sfaa047 LIKE sfaa_t.sfaa047, #生管结案日
       sfaa048 LIKE sfaa_t.sfaa048, #成本结案日
       sfaa049 LIKE sfaa_t.sfaa049, #已发料套数
       sfaa050 LIKE sfaa_t.sfaa050, #已入库合格量
       sfaa051 LIKE sfaa_t.sfaa051, #已入库不合格量
       sfaa052 LIKE sfaa_t.sfaa052, #Bouns
       sfaa053 LIKE sfaa_t.sfaa053, #工单转入数量
       sfaa054 LIKE sfaa_t.sfaa054, #工单转出数量
       sfaa055 LIKE sfaa_t.sfaa055, #下线数量
       sfaa056 LIKE sfaa_t.sfaa056, #报废数量
       sfaa057 LIKE sfaa_t.sfaa057, #委外类型
       sfaa058 LIKE sfaa_t.sfaa058, #参考数量
       sfaa059 LIKE sfaa_t.sfaa059, #预计入库批号
       sfaa060 LIKE sfaa_t.sfaa060, #参考单位
       sfaa061 LIKE sfaa_t.sfaa061, #工艺
       sfaa062 LIKE sfaa_t.sfaa062, #纳入APS计算
       sfaa063 LIKE sfaa_t.sfaa063, #来源分批序
       sfaa064 LIKE sfaa_t.sfaa064, #参考原始分批序
       sfaa065 LIKE sfaa_t.sfaa065, #生管结案状态
       sfaa066 LIKE sfaa_t.sfaa066, #多角流程编号
       sfaa067 LIKE sfaa_t.sfaa067, #多角流进程号
       sfaa068 LIKE sfaa_t.sfaa068, #成本中心
       sfaa069 LIKE sfaa_t.sfaa069, #可供给量
       sfaa070 LIKE sfaa_t.sfaa070, #原始预计完工日期
       sfaa071 LIKE sfaa_t.sfaa071, #齐料套数
       sfaa072 LIKE sfaa_t.sfaa072 #保税否
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE l_xcbb006        LIKE xcbb_t.xcbb006
DEFINE sfdd_xcbb006     LIKE xcbb_t.xcbb006
#wujie 160528 --begin   
DEFINE l_sql0           STRING
DEFINE l_sql1           STRING
DEFINE l_sql2           STRING
DEFINE l_sql3           STRING
DEFINE l_success        LIKE type_t.num5
#wujie 160528 --end
DEFINE l_string         LIKE type_t.chr500   #160328-00022#4
DEFINE l_i              LIKE type_t.num5     #160328-00022#4
DEFINE l_bar_cnt1       LIKE type_t.num5     #160328-00022#4
DEFINE l_bar_cnt2       LIKE type_t.num5     #160328-00022#4

   #wujie 160527 --begin  重写函数，改善效能
   #先将用到的大表抓出符合条件的放临时表，缩小范围
    LET g_success = 'Y'
   #CALL cl_progress_no_window_ing("Create Temp Table")   --zhouhuaa 160613 维护进度条功能    #160328-00022#4 mark
   #160328-00022#4--(S)
   LET l_bar_cnt1 = 3
   LET l_bar_cnt2 = l_bar_cnt1
   CALL cl_progress_bar_no_window(l_bar_cnt1)
   
   LET l_bar_cnt2 = l_bar_cnt2 - 1
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00774' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#4--(E)
   CALL axcp160_cre_tmp_table() RETURNING l_success  #从axcp160_cre_tmp_table()复制了sfaa，sfac，sfdc,sfdd，inaj的临时表创建，请保证2边抓数据的条件一致！ 
   IF NOT l_success THEN
      LET g_success = 'N'
      RETURN
   END IF
   #抓主件成本阶
   LET l_sql0= " SELECT DISTINCT sfacent,sfacdocno,MAX(xcbb006) xcbb006",
               "   FROM sfac_tmp,xcbb_tmp ",
               "  WHERE sfacent   = xcbbent ",
               "    AND sfac001   = xcbb003 ",
               "    AND (sfac006  = xcbb004 OR sfac006 IS NULL OR xcbb004 IS NULL) ",
               "  GROUP BY sfacent,sfacdocno "
                
   #元件成本阶
   LET l_sql1= " SELECT DISTINCT sfdcent,sfdc001,MIN(xcbb006) xcbb006_1",
               "   FROM xcbb_tmp,sfdc_tmp,sfdd_tmp ",
               "  WHERE xcbbent   = sfddent ",
               "    AND xcbb003   = sfdd001 ",
               "    AND (xcbb004  = sfdd013 OR sfdd013 IS NULL OR xcbb004 IS NULL)",
               "    AND sfddent   = sfdcent ",
               "    AND sfdddocno = sfdcdocno",
               "    AND sfddseq   = sfdcseq",
               "  GROUP BY sfdcent,sfdc001 "

   #如果是委外的工单，元件成本阶则取inaj中，这个工单号的，异动单据性质为asft310的所有料号的最小成本阶
   LET l_sql2= " SELECT DISTINCT inajent,inaj020,MIN(xcbb006) xcbb006_1",
               "   FROM xcbb_tmp,inaj_tmp ",
               "  WHERE xcbbent = inajent ",
               "    AND xcbb003 = inaj005 ",
               "    AND inaj015 = 'asft310'",  
               "    AND (xcbb004 = inaj006 OR inaj006 IS NULL OR xcbb004 IS NULL) ",
               "  GROUP BY inajent,inaj020 " 
                
   #拼成一句，抓元件成本阶小于等于主件成本阶,等待与sfaa_tmp去merge
   LET l_sql = " SELECT DISTINCT sfacent,sfacdocno ",
               "   FROM (",l_sql0,"),(",l_sql1,")",
               "  WHERE sfacent   = sfdcent ",
               "    AND sfacdocno = sfdc001 ",
               "    AND xcbb006_1 <= xcbb006 "
   #委外工单的另拼一句
   LET l_sql3= " SELECT DISTINCT sfacent,sfacdocno ",
               "   FROM (",l_sql0,"),(",l_sql2,")",
               "  WHERE sfacent   = inajent ",
               "    AND sfacdocno = inaj020 ",
               "    AND xcbb006_1 <= xcbb006 "
   #与sfaa_tmp去merge，元件成本阶小于等于主件成本阶的，为重工
   #CALL cl_progress_no_window_ing("update table")       #160328-00022#4 mark
   UPDATE sfaa_tmp SET sfaa042 = 'N'  #先无条件全改为N

   #160328-00022#4--(S)
   LET l_bar_cnt2 = l_bar_cnt2 - 1
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00775' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#4--(E)
   #非委外的   
   LET l_sql = " MERGE INTO sfaa_tmp T1 ",
               " USING (",l_sql,") T2",
               " ON (sfaaent = sfacent AND sfaadocno = sfacdocno) ",
               " WHEN MATCHED THEN UPDATE SET T1.sfaa042 = 'Y' "

   PREPARE axcp160_merge_execute_p1 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_merge_execute_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF
    
   EXECUTE axcp160_merge_execute_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_merge_execute_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF
   
   #委外的
   LET l_sql = " MERGE INTO sfaa_tmp T1 ",
               " USING (",l_sql3,") T2",
               " ON (sfaaent = sfacent AND sfaadocno = sfacdocno) ",
               " WHEN MATCHED THEN UPDATE SET T1.sfaa042 = 'Y' ",
               "                    WHERE (sfaa003 = '1' AND sfaa057 = '2') OR (sfaa003 = '2' AND sfaa057 = '2')"

   PREPARE axcp160_merge_execute_p2 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_merge_execute_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF
    
   EXECUTE axcp160_merge_execute_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_merge_execute_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF
    
   UPDATE sfaa_tmp SET sfaa042 = 'Y'
    WHERE sfaa003 = '2' OR sfaa003 = '3'

   
   #160328-00022#4--(S)
   LET l_bar_cnt2 = l_bar_cnt2 - 1
   SELECT gzze003 INTO l_string FROM gzze_t
    WHERE gzze001 = 'axc-00776' AND gzze002 = g_dlang
   CALL cl_progress_no_window_ing(l_string)
   #160328-00022#4--(E)
   #写入sfaa_t实体表
   #CALL cl_progress_no_window_ing("Insert Table")      --zhouhuaa 160613 维护进度条功能     #160328-00022#4 mark
   LET l_sql = " MERGE INTO sfaa_t T1 ",
               " USING sfaa_tmp T2",
               " ON (T1.sfaaent = T2.sfaaent AND T1.sfaadocno = T2.sfaadocno) ",
               " WHEN MATCHED THEN UPDATE SET T1.sfaa042 = T2.sfaa042 "
   PREPARE axcp160_merge_execute_p3 FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_merge_execute_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF
    
   EXECUTE axcp160_merge_execute_p3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_merge_execute_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_success = 'N'
      CALL axcp160_cnt_process_bar(l_bar_cnt1,l_bar_cnt2)      #160328-00022#4
      RETURN
   END IF    

#    LET l_sql = " SELECT * FROM sfaa_t ",
#                #"  WHERE sfaaent = '",g_enterprise,"' AND sfaastus <> 'M' ",
#                "  WHERE sfaaent = '",g_enterprise,"' AND sfaastus <> 'X' ",
#                "    AND sfaadocno NOT IN(SELECT sfaadocno FROM sfaa_t",
#                "    WHERE sfaaent = '",g_enterprise,"' AND sfaastus = 'M' AND sfaa048 < '",l_bdate,"')",
#                "    AND sfaa003 <> '4' AND sfaadocdt <= '",l_edate,"'",
#                "    AND sfaasite IN ( SELECT ooef001 FROM ooef_t",
#                "  WHERE ooefent = ",g_enterprise," AND ooef201 = 'Y' ",
#                "    AND ooef003 = 'Y' AND ooef017 = '",g_glaa_m.glaacomp,"')",
#                "    AND ",g_wc2 CLIPPED
#    PREPARE sfaa_upd_prep FROM l_sql
#    DECLARE sfaa_upd_curs CURSOR FOR sfaa_upd_prep
#    
#    LET g_success = 'Y'
#    #啟用事務
#    CALL s_transaction_begin()
#    CALL cl_showmsg_init()
#    
#    FOREACH sfaa_upd_curs INTO l_sfaa.*
#       IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('','','sfaa_upd_curs',SQLCA.sqlcode,1)   
#         LET g_success = 'N'                              
#         EXIT FOREACH
#       END IF
#       
#       IF g_glaa_m.sw_1 = 'N' AND l_sfaa.sfaa003 = '1' THEN CONTINUE FOREACH END IF
#       IF g_glaa_m.sw_2 = 'N' AND l_sfaa.sfaa057 = '2' THEN CONTINUE FOREACH END IF
#      
#       IF l_sfaa.sfaa003 = '3' OR l_sfaa.sfaa003 = '2' THEN
#          LET l_sfaa.sfaa042 = 'Y'
#       ELSE
#          #fengmy150805-----b           
#          SELECT MAX(xcbb006) INTO l_xcbb006 FROM xcbb_t
#           WHERE xcbbent = g_enterprise AND xcbbcomp = g_glaa_m.glaacomp
#             AND xcbb001 = g_glaa_m.year AND xcbb002 = g_glaa_m.month
#             AND  EXISTS (SELECT 1 FROM sfac_t 
#                           WHERE sfacent = xcbbent AND sfacdocno = l_sfaa.sfaadocno 
#                             AND sfac001 = xcbb003 
#                             AND (sfac006 = xcbb004 OR sfac006 IS NULL OR xcbb004 IS NULL) )
##          SELECT MAX(xcbb006) INTO l_xcbb006 FROM xcbb_t
##           WHERE xcbbent = g_enterprise AND xcbbcomp = g_glaa_m.glaacomp
##             AND xcbb001 = g_glaa_m.year AND xcbb002 = g_glaa_m.month
##             AND xcbb003 = l_sfaa.sfaa010           
#          #fengmy150805-----e
#
#
#          
##          SELECT MIN(xcbb006) INTO sfdd_xcbb006 FROM xcbb_t,sfdd_t,sfda_t,sfdc_t
##           WHERE xcbbent = sfddent AND sfddent = sfdaent AND sfdaent = sfdcent
##             AND sfdasite = sfddsite AND sfddsite = sfdcsite AND sfdadocno = sfdddocno
##             AND sfdddocno = sfdcdocno AND sfdc001 = l_sfaa.sfaadocno
##             AND xcbb003 = sfdd001 AND sfda002 IN ('11','12','13','14','15')
#          #fengmy150805-----b
#             SELECT MIN(xcbb006) INTO sfdd_xcbb006 FROM xcbb_t,sfba_t
#              WHERE xcbbent = sfbaent AND xcbbent = g_enterprise 
#                AND sfbadocno = l_sfaa.sfaadocno
#                AND xcbb003 = sfba006 
#                AND (xcbb004 = sfba021 OR sfba021 IS NULL OR xcbb004 IS NULL)
#                AND xcbbcomp = g_glaa_m.glaacomp
#                AND xcbb001  = g_glaa_m.year
#                AND xcbb002  = g_glaa_m.month
##          SELECT MIN(xcbb006) INTO sfdd_xcbb006 FROM xcbb_t,sfba_t
##           WHERE xcbbent = sfbaent AND xcbbent = g_enterprise 
##             AND sfbadocno = l_sfaa.sfaadocno
##             AND xcbb003 = sfba006 
##             AND xcbbcomp = g_glaa_m.glaacomp
##             AND xcbb001  = g_glaa_m.year
##             AND xcbb002  = g_glaa_m.month
#          #fengmy150805-----e             
#
#          
#          IF sfdd_xcbb006 <= l_xcbb006 THEN
#             LET l_sfaa.sfaa042 = 'Y'
#          ELSE
#             LET l_sfaa.sfaa042 = 'N'
#             IF (l_sfaa.sfaa003 = '1' AND l_sfaa.sfaa057 = '2') OR (l_sfaa.sfaa003 = '2' AND l_sfaa.sfaa057 = '2') THEN
#                #fengmy150805-----b
#                   SELECT MIN(xcbb006) INTO sfdd_xcbb006 FROM xcbb_t,inaj_t
#                    WHERE xcbbent = inajent AND inaj020 = l_sfaa.sfaadocno
#                      AND xcbbent = g_enterprise
#                      AND xcbb003 = inaj005 AND inaj015 = 'asft310'  
#                      AND (xcbb004 = inaj006 OR inaj006 IS NULL OR xcbb004 IS NULL)                     
##                SELECT MIN(xcbb006) INTO sfdd_xcbb006 FROM xcbb_t,inaj_t
##                 WHERE xcbbent = inajent AND inaj020 = l_sfaa.sfaadocno
##                   AND xcbbent = g_enterprise
##                   AND xcbb003 = inaj005 AND inaj015 = 'asft310'
#                #fengmy150805-----e
#                
#                IF sfdd_xcbb006 <= l_xcbb006 THEN
#                   LET l_sfaa.sfaa042 = 'Y' 
#                END IF
#             END IF
#          END IF
#       END IF
#       UPDATE sfaa_t SET sfaa042 = l_sfaa.sfaa042 
#        WHERE sfaaent = g_enterprise AND sfaadocno = l_sfaa.sfaadocno
#       IF STATUS OR SQLCA.sqlerrd[3]=0 THEN
#          CALL cl_errmsg('sfaadocno',l_sfaa.sfaadocno,'upddate error',SQLCA.sqlcode,1)                               
#         LET g_success = 'N'
#      END IF
#    END FOREACH
#    CALL cl_err_showmsg()
#    #結束事務
#    CALL s_transaction_end(g_success,1)
END FUNCTION

################################################################################
# Descriptions...: 新增/查詢時，預帶法人、年度、期別欄位
# Memo...........:
# Usage..........: CALL axcp160_head_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 20151023 By dorislai
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_head_default()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003


   CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
   IF cl_null(g_glaa_m.glaacomp) THEN
      LET g_glaa_m.glaacomp = l_comp
      DISPLAY BY NAME g_glaa_m.glaacomp
   END IF
   IF cl_null(g_glaa_m.year) THEN
      LET g_glaa_m.year = l_year
      DISPLAY BY NAME g_glaa_m.year
   END IF
   IF cl_null(g_glaa_m.month) THEN
      LET g_glaa_m.month = l_period
      DISPLAY BY NAME g_glaa_m.month
   END IF
END FUNCTION

################################################################################
# Descriptions...: 从s_axcp500_cre_tmp_table()复制了sfaa，sfac，sfba，inaj的临时表创建，请保证2边抓数据的条件一致！
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING r_success
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016/05/27 By wujie
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_cre_tmp_table()
  DEFINE r_success       LIKE type_t.num5
   DEFINE l_date          LIKE type_t.dat
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = FALSE
  #CALL cl_progress_no_window_ing("Drop Table")   --zhouhuaa 160613 维护进度条功能   #160328-00022#4 mark
   DROP TABLE sfaa_tmp;
   DROP TABLE sfac_tmp;  #add zhangllc 150730
   DROP TABLE inaj_tmp;
   DROP TABLE sfdc_tmp;
   DROP TABLE sfdd_tmp;
   DROP TABLE xcbb_tmp;
   
   LET l_date = l_edate
   LET l_date = l_date + 1

   #取参数
   LET g_sys_6001 = cl_get_para(g_enterprise,g_comp,'S-FIN-6001')   #系统参数[S-FIN-6001]:採用成本域否
   LET g_sys_6013 = cl_get_para(g_enterprise,g_comp,'S-FIN-6013')   #系统参数[S-FIN-6013]:按料件特性计算成本否
   LET g_sys_6018 = cl_get_para(g_enterprise,g_comp,'S-FIN-6018')   #系统参数[S-FIN-6018]:調撥是否納入計算  #add zhangllc 150825

#xcbb_tmp是axcp160独有的
   LET g_sql = " SELECT xcbb_t.* FROM xcbb_t ",  
               " WHERE xcbbent  = '",g_enterprise,"'",
               "   AND xcbbcomp = '",g_glaa_m.glaacomp,"'",
               "   AND xcbb001  = '",g_glaa_m.year,"'",
               "   AND xcbb002  = '",g_glaa_m.month,"'",
               "   INTO TEMP xcbb_tmp "

   PREPARE axcp160_cre_tmp_table_execute_p1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   EXECUTE axcp160_cre_tmp_table_execute_p1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   FREE axcp160_cre_tmp_table_execute_p1

   CREATE INDEX xcbb_tmp_i01 ON xcbb_tmp(xcbbent,xcbb003,xcbb004);
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX xcbb_tmp_i01"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   IF cl_db_generate_analyze("xcbb_tmp") THEN END IF
   
   #因为下面各表均是大容量的TABLE,所以尽量将 unique index的条件用上,以得快速建成此TEMP TABLE
   #2.建立临时表inaj_tmp  -- 把需要运算的inaj全部放至inaj_tmp中     
   LET g_sql = " SELECT inaj_t.* FROM inaj_t,imaa_t,inaa_t,ooef_t ",  
               " WHERE inajent = imaaent AND inajent = ",g_enterprise,
               "   AND inaj005 = imaa001 ",
               "   AND inaj022 BETWEEN '",l_bdate,"' AND '",l_edate,"'",
               "   AND inajsite = ooef001 ",
               "   AND ooefent  = inajent ",
               "   AND ooef017 = '",g_glaa_m.glaacomp,"'",
               "   AND (inaj004 = 1 OR inaj004 = -1) ",
               "   AND inaaent  = inajent ",
               "   AND inaasite = inajsite ",
               "   AND inaa001  = inaj008 ",
               "   AND inaa010  = 'Y' "  #成本库

   IF g_sys_6001 = 'N' AND g_sys_6018 = 'N' THEN  #mod zhangllc 150825 #系统参数[S-FIN-6018]:調撥是否納入計算
      LET g_sql = g_sql CLIPPED,"   AND inaj036 <> '401' "
   END IF
   #委外及采购每个单号+项次只插入一笔
   #LET g_sql = g_sql CLIPPED," AND inaj036 NOT IN ('102','108','103','104','105','106','107','109') "  #mark zhangllc 150810
   
   LET g_sql = g_sql CLIPPED,
               "   INTO TEMP inaj_tmp "

   PREPARE axcp160_cre_tmp_table_execute_p2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   EXECUTE axcp160_cre_tmp_table_execute_p2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p2"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   FREE axcp160_cre_tmp_table_execute_p2
   
#wujie 160325 --begin
   CREATE INDEX inaj_tmp_i01 ON inaj_tmp(inajent,inaj005,inaj006);
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE INDEX inaj_tmp_i01"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   IF cl_db_generate_analyze("inaj_tmp") THEN END IF
#wujie 160325 --end    

   #成本计算细度:料件+特征
   IF g_sys_6013 = 'N' THEN
      UPDATE inaj_tmp SET inaj006 = ' '
   END IF

   
   
   #3.建立临时表sfaa_tmp  -- 把需要运算的SFAA全部放至sfaa_tmp中           
   LET g_sql = " SELECT sfaa_t.* FROM sfaa_t,ooef_t,imaa_t ",  #mod zhangllc 160131 add 'N' isgywwrk工艺委外入库  
               " WHERE sfaaent = ",g_enterprise,
#              "   AND sfaa003 <> '4' ",                               #研发工单
               "   AND (sfaa048 IS NULL OR sfaa048 >= '",l_bdate,"')", #成会结案日期
#              "   AND sfaadocdt <= '",g_edate,"'",                    #开单日期
               "   AND sfaastus IN ('Y','F','C','E','M') ",            #单据状态
               "   AND ooefent = sfaaent ",
               "   AND ooef001 = sfaasite ",
               "   AND ooef017 = '",g_glaa_m.glaacomp,"'",
               "   AND imaaent = ",g_enterprise,
               "   AND sfaa010 = imaa001 ",
               "   AND ",g_wc2 CLIPPED
               
   IF g_glaa_m.sw_1 = 'N' THEN LET g_sql = g_sql," AND sfaa003 <>'1' " END IF
   IF g_glaa_m.sw_2 = 'N' THEN LET g_sql = g_sql," AND sfaa057 <>'2' " END IF 
   
   LET g_sql = g_sql,"   INTO TEMP sfaa_tmp "
                              
   PREPARE axcp160_cre_tmp_table_execute_p3 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   EXECUTE axcp160_cre_tmp_table_execute_p3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p3"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   FREE axcp160_cre_tmp_table_execute_p3

               
   #以后各期的工单也置入sfaa_tmp中了,要把开工日期大于本期,且本期没有异动的工作单砍掉
   DELETE FROM sfaa_tmp WHERE sfaadocdt >= l_date
                          AND sfaadocno NOT IN ( SELECT inaj020 FROM inaj_tmp)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "DELETE sfaa_tmp "
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
               
   CREATE UNIQUE INDEX sfaa_tmp_01 ON sfaa_tmp(sfaaent,sfaadocno );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE UNIQUE INDEX sfaa_tmp_01"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   #add zhangllc 160323
   IF cl_db_generate_analyze("sfaa_tmp") THEN END IF
   #add zhangllc 160323 end
  

   #add zhangllc 150730 --begin
   #建立临时表sfac_tmp  -- 把需要运算的sfac全部放至sfac_tmp中  产品特征使用  
   #LET g_sql = " SELECT sfac_t.*,0 clevel,'N' islevel FROM sfaa_tmp,sfac_t ",    #mod zhangllc 151109 add islevel
   #                           工单      料       产品特征
   LET g_sql = " SELECT DISTINCT sfacent,sfacdocno,sfac001,sfac006 FROM sfaa_tmp,sfac_t ",  #mod zhangllc 151110
               "  WHERE sfacent   = sfaaent ",
               "    AND sfacdocno = sfaadocno ",
               "    AND sfac001   = sfaa010  ",  #生产料件
               #add zhangllc 151110
               "    AND sfaaent   = ",g_enterprise,
               "    AND sfaa003  != '3' ", #非拆件
               " UNION ",
               " SELECT DISTINCT sfbaent,sfbadocno,sfba006,sfba021 FROM sfaa_tmp,sfba_t ",
               "  WHERE sfbaent   = sfaaent ",
               "    AND sfbadocno = sfaadocno ",
               "    AND sfba006   = sfaa010  ",  #生产料件
               "    AND sfaaent   = ",g_enterprise,
               "    AND sfaa003  = '3' ", #拆件
               #end add zhangllc 151110
               ##add zhangllc 160406  拆件式工单也再抓取下sfac档中的，入库的可能不是备料
               #" UNION ",
               #" SELECT unique sfacdocno,sfac001,sfac006,0 clevel,'N' islevel FROM sfaa_tmp,sfac_t ",
               #"  WHERE sfacent   = sfaaent ",
               #"    AND sfacdocno = sfaadocno ",
               #"    AND sfaaent   = ",g_enterprise,
               #"    AND sfaa003  = '3' ", #拆件
               ##end add zhangllc 160406
               "   INTO TEMP sfac_tmp "
   PREPARE axcp160_cre_tmp_table_execute_p3_1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p3_1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   EXECUTE axcp160_cre_tmp_table_execute_p3_1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p3_1"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   FREE axcp160_cre_tmp_table_execute_p3_1

   #CREATE UNIQUE INDEX sfac_tmp_01 ON sfac_tmp(sfacent,sfacdocno,sfacseq );
   CREATE INDEX sfac_tmp_01 ON sfac_tmp(sfacent,sfacdocno); 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE UNIQUE INDEX sfac_tmp_01"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
 
   IF cl_db_generate_analyze("sfac_tmp") THEN END IF

   #5.建立临时表sfdc_tmp  -- 把需要运算的sfdc全部放至sfdc_tmp中
   LET g_sql = " SELECT sfdc_t.* FROM sfaa_tmp,sfdc_t ",
               "  WHERE sfdcent   = sfaaent ",
               "    AND sfdc001   = sfaadocno ",
               "   INTO TEMP sfdc_tmp "

   PREPARE axcp160_cre_tmp_table_execute_p4 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   EXECUTE axcp160_cre_tmp_table_execute_p4
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p4"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   FREE axcp160_cre_tmp_table_execute_p4
   
   CREATE UNIQUE INDEX sfdc_tmp_pk ON sfdc_tmp(sfdcent,sfdcdocno,sfdcseq );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE UNIQUE INDEX sfdc_tmp_pk"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   
   IF cl_db_generate_analyze("sfdc_tmp") THEN END IF


   #5.建立临时表sfdd_tmp  -- 把需要运算的sfdd全部放至sfdd_tmp中
   LET g_sql = " SELECT sfdd_t.* FROM sfdd_t,sfdc_tmp ",
               "  WHERE sfdcent   = sfddent ",
               "    AND sfdcdocno = sfdddocno ",
               "    AND sfdcseq   = sfddseq ",
               "   INTO TEMP sfdd_tmp "

   PREPARE axcp160_cre_tmp_table_execute_p5 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "PREPARE axcp160_cre_tmp_table_execute_p5"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   EXECUTE axcp160_cre_tmp_table_execute_p5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "EXECUTE axcp160_cre_tmp_table_execute_p5"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF
   FREE axcp160_cre_tmp_table_execute_p5

   CREATE UNIQUE INDEX sfdd_tmp_pk ON sfdd_tmp(sfddent,sfdddocno,sfddseq,sfddseq1 );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.extend = "CREATE UNIQUE INDEX sfdd_tmp_pk"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN r_success
   END IF

   IF cl_db_generate_analyze("sfdd_tmp") THEN END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: process_bar
# Memo...........:
# Date & Author..: 16/06/22 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcp160_cnt_process_bar(p_sum,p_i)
DEFINE p_sum         LIKE type_t.num5
DEFINE p_i           LIKE type_t.num5

   IF p_i > 0 THEN
      FOR p_i = p_i TO p_sum 
         CALL cl_progress_no_window_ing(' ')
      END FOR   
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
