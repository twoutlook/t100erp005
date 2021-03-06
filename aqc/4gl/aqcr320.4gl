#該程式未解開Section, 採用最新樣板產出!
{<section id="aqcr320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-01-19 14:13:24), PR版次:0002(2016-09-19 11:24:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000085
#+ Filename...: aqcr320
#+ Description: 缺點原因分析表列印作業
#+ Creator....: 05423(2014-08-25 10:36:13)
#+ Modifier...: 05423 -SD/PR- 02294
 
{</section>}
 
{<section id="aqcr320.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#160913-00055#4    2016/09/18  By lixiang  交易对象栏位开窗调整为q_pmaa001_25
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
       qcba005 LIKE qcba_t.qcba005, 
   qcba010 LIKE qcba_t.qcba010, 
   qcbe001 LIKE qcbe_t.qcbe001, 
   pmaa080 LIKE pmaa_t.pmaa080, 
   imaa009 LIKE imaa_t.imaa009, 
   sfaa017 LIKE sfaa_t.sfaa017, 
   qcba000 LIKE qcba_t.qcba000, 
   bdate LIKE type_t.chr500, 
   edate LIKE type_t.chr500, 
   date_type LIKE type_t.chr500, 
   l_d_1 LIKE type_t.chr500, 
   l_d_2 LIKE type_t.chr500, 
   l_d_3 LIKE type_t.chr500, 
   l_d_4 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE l_wc STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aqcr320.main" >}
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
   CALL cl_ap_init("aqc","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aqcr320_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aqcr320 WITH FORM cl_ap_formpath("aqc",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aqcr320_init()
 
      #進入選單 Menu (="N")
      CALL aqcr320_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aqcr320
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aqcr320.init" >}
#+ 初始化作業
PRIVATE FUNCTION aqcr320_init()
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
   CALL cl_set_combo_scc_part("qcba000","5056","0,1,2,3,4,5")  
   CALL cl_set_combo_scc_part("date_type","5077","1,2")
   LET g_master.qcba000 = '0'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aqcr320.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aqcr320_ui_dialog()
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
   LET g_master.date_type = '1'
   LET g_master.l_d_1 = 'N'
   LET g_master.l_d_2 = 'N'
   LET g_master.l_d_3 = 'N'
   LET g_master.l_d_4 = 'N'
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.qcba000,g_master.bdate,g_master.edate,g_master.date_type,g_master.l_d_1, 
             g_master.l_d_2,g_master.l_d_3,g_master.l_d_4 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcba000
            #add-point:BEFORE FIELD qcba000 name="input.b.qcba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcba000
            
            #add-point:AFTER FIELD qcba000 name="input.a.qcba000"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qcba000
            #add-point:ON CHANGE qcba000 name="input.g.qcba000"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date_type
            #add-point:BEFORE FIELD date_type name="input.b.date_type"
            IF (g_master.qcba000 == '1') THEN
               CALL cl_set_comp_entry("date_type",FALSE) 
               LET g_master.date_type = '1'
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date_type
            
            #add-point:AFTER FIELD date_type name="input.a.date_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date_type
            #add-point:ON CHANGE date_type name="input.g.date_type"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_d_1
            #add-point:BEFORE FIELD l_d_1 name="input.b.l_d_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_d_1
            
            #add-point:AFTER FIELD l_d_1 name="input.a.l_d_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_d_1
            #add-point:ON CHANGE l_d_1 name="input.g.l_d_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_d_2
            #add-point:BEFORE FIELD l_d_2 name="input.b.l_d_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_d_2
            
            #add-point:AFTER FIELD l_d_2 name="input.a.l_d_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_d_2
            #add-point:ON CHANGE l_d_2 name="input.g.l_d_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_d_3
            #add-point:BEFORE FIELD l_d_3 name="input.b.l_d_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_d_3
            
            #add-point:AFTER FIELD l_d_3 name="input.a.l_d_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_d_3
            #add-point:ON CHANGE l_d_3 name="input.g.l_d_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_d_4
            #add-point:BEFORE FIELD l_d_4 name="input.b.l_d_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_d_4
            
            #add-point:AFTER FIELD l_d_4 name="input.a.l_d_4"
            IF g_master.l_d_4 == 'Y' THEN
               LET g_master.l_d_3 = 'Y'
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_d_4
            #add-point:ON CHANGE l_d_4 name="input.g.l_d_4"
            IF g_master.l_d_4 == 'Y' THEN
               LET g_master.l_d_3 = 'Y'
            END IF
            #END add-point 
 
 
 
                     #Ctrlp:input.c.qcba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcba000
            #add-point:ON ACTION controlp INFIELD qcba000 name="input.c.qcba000"
            
            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
               IF g_master.edate < g_master.bdate THEN
                  INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-1152" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  LET g_master.edate = NULL
                  DISPLAY g_master.edate TO edate
                  NEXT FIELD edate
               END IF
            #END add-point
 
 
         #Ctrlp:input.c.date_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date_type
            #add-point:ON ACTION controlp INFIELD date_type name="input.c.date_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_d_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_d_1
            #add-point:ON ACTION controlp INFIELD l_d_1 name="input.c.l_d_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_d_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_d_2
            #add-point:ON ACTION controlp INFIELD l_d_2 name="input.c.l_d_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_d_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_d_3
            #add-point:ON ACTION controlp INFIELD l_d_3 name="input.c.l_d_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_d_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_d_4
            #add-point:ON ACTION controlp INFIELD l_d_4 name="input.c.l_d_4"
 
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF g_master.edate < g_master.bdate THEN
                  INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-1152" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  LET g_master.edate = NULL
                  DISPLAY g_master.edate TO bdate
                  NEXT FIELD edate
               END IF
#
#               IF (g_master.l_d_1 <> 'Y') AND (g_master.l_d_2 <> 'Y') AND (g_master.l_d_3 <> 'Y') AND (g_master.l_d_4 <> 'Y') THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "" 
#                     LET g_errparam.code   = "-1124" 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  NEXT FIELD l_d_1
#               END IF
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON qcba005,qcba010,qcbe001,pmaa080,imaa009
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.qcba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcba005
            #add-point:ON ACTION controlp INFIELD qcba005 name="construct.c.qcba005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()                           #呼叫開窗  #160913-00055#4
            CALL q_pmaa001_25()        #160913-00055#4
            DISPLAY g_qryparam.return1 TO qcba005  #顯示到畫面上
            NEXT FIELD qcba005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcba005
            #add-point:BEFORE FIELD qcba005 name="construct.b.qcba005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcba005
            
            #add-point:AFTER FIELD qcba005 name="construct.a.qcba005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcba010
            #add-point:ON ACTION controlp INFIELD qcba010 name="construct.c.qcba010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcba010  #顯示到畫面上
            NEXT FIELD qcba010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcba010
            #add-point:BEFORE FIELD qcba010 name="construct.b.qcba010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcba010
            
            #add-point:AFTER FIELD qcba010 name="construct.a.qcba010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.qcbe001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qcbe001
            #add-point:ON ACTION controlp INFIELD qcbe001 name="construct.c.qcbe001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1053'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO qcbe001  #顯示到畫面上
            NEXT FIELD qcbe001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qcbe001
            #add-point:BEFORE FIELD qcbe001 name="construct.b.qcbe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qcbe001
            
            #add-point:AFTER FIELD qcbe001 name="construct.a.qcbe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmaa080
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmaa080
            #add-point:ON ACTION controlp INFIELD pmaa080 name="construct.c.pmaa080"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '251'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmaa080  #顯示到畫面上
            NEXT FIELD pmaa080                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmaa080
            #add-point:BEFORE FIELD pmaa080 name="construct.b.pmaa080"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmaa080
            
            #add-point:AFTER FIELD pmaa080 name="construct.a.pmaa080"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #此段落由子樣板a08產生
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
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME l_wc ON sfaa017
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD sfaa017
            #add-point:ON ACTION controlp INFIELD sfaa017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sfaa017  #顯示到畫面上
            NEXT FIELD sfaa017                     #返回原欄位
            
         BEFORE FIELD sfaa017
         
         AFTER FIELD sfaa017
         
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
            CALL aqcr320_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aqcr320_get_buffer(l_dialog)
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
         CALL aqcr320_init()
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
                 CALL aqcr320_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aqcr320_transfer_argv(ls_js)
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
 
{<section id="aqcr320.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aqcr320_transfer_argv(ls_js)
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
 
{<section id="aqcr320.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aqcr320_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"qcba005,qcba010,qcbe001,pmaa080,imaa009")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_null(g_master.qcba000) AND g_master.qcba000 != '0' THEN
      LET g_master.wc = g_master.wc CLIPPED , " AND qcba000 = '",g_master.qcba000,"' "
   END IF
   IF NOT cl_null(g_master.wc)  THEN
      LET g_master.wc = g_master.wc CLIPPED , " AND qcbaent = '",g_enterprise CLIPPED,"' AND qcbasite = '",g_site CLIPPED,"' "
   ELSE 
      LET g_master.wc = g_master.wc CLIPPED , " qcbaent = '",g_enterprise CLIPPED,"' AND qcbasite = '",g_site CLIPPED,"' "
   END IF
   IF g_master.qcba000 == '2' THEN
      LET g_master.wc = g_master.wc CLIPPED," AND ",l_wc CLIPPED
   END IF
   CASE g_master.date_type
   WHEN '1'
      IF NOT cl_null(g_master.bdate) THEN
         LET g_master.wc = g_master.wc CLIPPED ," AND qcbadocdt >= '",g_master.bdate,"' "
      END IF
      IF NOT cl_null(g_master.edate) THEN
         LET g_master.wc = g_master.wc CLIPPED ," AND qcbadocdt <= '",g_master.edate,"' "
      END IF
   WHEN '2'
      IF NOT cl_null(g_master.bdate) THEN
         LET g_master.wc = g_master.wc CLIPPED ," AND pmdsdocdt >= '",g_master.bdate,"' "
      END IF
      IF NOT cl_null(g_master.edate) THEN
         LET g_master.wc = g_master.wc CLIPPED ," AND pmdsdocdt <= '",g_master.edate,"' "
      END IF
   END CASE
   CALL aqcr320_x02(g_master.wc,g_master.bdate,g_master.edate,g_master.date_type,g_master.l_d_2,g_master.l_d_3,g_master.l_d_4)

   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aqcr320_process_cs CURSOR FROM ls_sql
#  FOREACH aqcr320_process_cs INTO
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
 
{<section id="aqcr320.get_buffer" >}
PRIVATE FUNCTION aqcr320_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.qcba000 = p_dialog.getFieldBuffer('qcba000')
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
   LET g_master.date_type = p_dialog.getFieldBuffer('date_type')
   LET g_master.l_d_1 = p_dialog.getFieldBuffer('l_d_1')
   LET g_master.l_d_2 = p_dialog.getFieldBuffer('l_d_2')
   LET g_master.l_d_3 = p_dialog.getFieldBuffer('l_d_3')
   LET g_master.l_d_4 = p_dialog.getFieldBuffer('l_d_4')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aqcr320.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
