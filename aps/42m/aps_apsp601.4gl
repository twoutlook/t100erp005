#該程式未解開Section, 採用最新樣板產出!
{<section id="apsp601.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-10-06 14:44:58), PR版次:0006(2016-10-06 14:57:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: apsp601
#+ Description: APS產生請購單作業[背景執行]
#+ Creator....: 04441(2015-12-14 15:06:21)
#+ Modifier...: 07024 -SD/PR- 07024
 
{</section>}
 
{<section id="apsp601.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160318-00025#50 2016/04/26 By 07673    將重複內容的錯誤訊息置換為公用錯誤訊息 
#160512-00016#6  2016/05/23 By ming     apsp600增加欄位pspc062保稅否，故背景執行的也要撰寫相關的處理
#160601-00032#2  2016/06/06 By ming     把來源訂單(pspc018)放到庫存管理特徵pmdb054 
#160825-00037#2  2016/10/06 By dorislai 多加上選項：將需求來源訂單放到庫存管理特徵，Y的時候，才把來源訂單(pspc018)放到庫存管理特徵(pmdb054)
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
        pspc001          LIKE pspc_t.pspc001,
        ooba002          LIKE ooba_t.ooba002,
        chk              LIKE type_t.chr1,
        #151223-00003 by whitney add start
        chk5             LIKE type_t.chr1,
        days             LIKE type_t.num5,
        #151223-00003 by whitney add end
        chk1             LIKE type_t.chr1,
        chk2             LIKE type_t.chr1,
        chk3             LIKE type_t.chr1,
        chk4             LIKE type_t.chr1,
        chk6             LIKE type_t.chr1,  #160825-00037#1-add
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       imae012 LIKE imae_t.imae012, 
   imaf142 LIKE imaf_t.imaf142, 
   pspc010 LIKE pspc_t.pspc010, 
   pspc045 LIKE pspc_t.pspc045, 
   imaa009 LIKE imaa_t.imaa009, 
   imaf141 LIKE imaf_t.imaf141, 
   pspc050 LIKE pspc_t.pspc050, 
   pspc001 LIKE pspc_t.pspc001, 
   pspc001_desc LIKE type_t.chr80, 
   ooba002 LIKE ooba_t.ooba002, 
   ooba002_desc LIKE type_t.chr80, 
   chk LIKE type_t.chr500, 
   chk6 LIKE type_t.chr1, 
   chk5 LIKE type_t.chr500, 
   days LIKE type_t.num5, 
   chk1 LIKE type_t.chr500, 
   chk2 LIKE type_t.chr500, 
   chk3 LIKE type_t.chr500, 
   chk4 LIKE type_t.chr500, 
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
 
{<section id="apsp601.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apsp601_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsp601 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsp601_init()
 
      #進入選單 Menu (="N")
      CALL apsp601_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsp601
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_apsp600_tmp_drop()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsp601.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsp601_init()
 
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
 
{<section id="apsp601.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsp601_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_pspc001_o  LIKE pspc_t.pspc001
   DEFINE l_ooba002_o  LIKE ooba_t.ooba002
   DEFINE l_ooef004    LIKE ooef_t.ooef004
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.chk  = 'N'
   LET g_master.chk1 = 'N'
   LET g_master.chk2 = 'N'
   LET g_master.chk3 = 'N'
   LET g_master.chk4 = 'N'
   LET g_master.chk6 = 'N'  #160825-00037#1-add
   #151223-00003 by whitney add start
   LET g_master.chk5 = 'N'
   LET g_master.days = 0
   CALL cl_set_comp_entry("days",FALSE)
   #151223-00003 by whitney add end
   
   LET l_ooef004 = ''
   SELECT ooef004 INTO l_ooef004
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.pspc001,g_master.ooba002,g_master.chk,g_master.chk6,g_master.chk5,g_master.days, 
             g_master.chk1,g_master.chk2,g_master.chk3,g_master.chk4 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET l_pspc001_o = g_master.pspc001
               LET l_ooba002_o = g_master.ooba002
               #151223-00003 by whitney add start
               IF g_master.chk5 = 'N' THEN
                  CALL cl_set_comp_entry("days",FALSE)
               ELSE
                  CALL cl_set_comp_entry("days",TRUE)
               END IF
               #151223-00003 by whitney add end
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pspc001
            
            #add-point:AFTER FIELD pspc001 name="input.a.pspc001"
            LET g_master.pspc001_desc = ''
            IF NOT cl_null(g_master.pspc001) THEN
               IF (g_master.pspc001 <> l_pspc001_o) OR cl_null(l_pspc001_o) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.pspc001
                  LET g_errshow = TRUE   #160318-00025#50
                  LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#50
                  IF NOT cl_chk_exist("v_psca001") THEN
                     LET g_master.pspc001 = l_pspc001_o
                     CALL s_apsp600_pspc001_ref(g_master.pspc001) RETURNING g_master.pspc001_desc
                     DISPLAY BY NAME g_master.pspc001,g_master.pspc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_apsp600_pspc001_ref(g_master.pspc001) RETURNING g_master.pspc001_desc
                  DISPLAY BY NAME g_master.pspc001_desc
                  LET l_pspc001_o = g_master.pspc001
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pspc001
            #add-point:BEFORE FIELD pspc001 name="input.b.pspc001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pspc001
            #add-point:ON CHANGE pspc001 name="input.g.pspc001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooba002
            
            #add-point:AFTER FIELD ooba002 name="input.a.ooba002"
            LET g_master.ooba002_desc = ''
            IF NOT cl_null(g_master.ooba002) THEN
               IF (g_master.ooba002 <> l_ooba002_o) OR cl_null(l_ooba002_o) THEN
                  IF NOT s_apsp600_pmdadocno_chk(g_master.ooba002) THEN
                     LET g_master.ooba002 = l_ooba002_o
                     CALL s_aooi200_get_slip_desc(g_master.ooba002) RETURNING g_master.ooba002_desc
                     DISPLAY BY NAME g_master.ooba002,g_master.ooba002_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_aooi200_get_slip_desc(g_master.ooba002) RETURNING g_master.ooba002_desc
                  DISPLAY BY NAME g_master.ooba002_desc
                  LET l_ooba002_o = g_master.ooba002
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooba002
            #add-point:BEFORE FIELD ooba002 name="input.b.ooba002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooba002
            #add-point:ON CHANGE ooba002 name="input.g.ooba002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.chk"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk6
            #add-point:BEFORE FIELD chk6 name="input.b.chk6"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk6
            
            #add-point:AFTER FIELD chk6 name="input.a.chk6"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk6
            #add-point:ON CHANGE chk6 name="input.g.chk6"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk5
            #add-point:BEFORE FIELD chk5 name="input.b.chk5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk5
            
            #add-point:AFTER FIELD chk5 name="input.a.chk5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk5
            #add-point:ON CHANGE chk5 name="input.g.chk5"
            #151223-00003 by whitney add start
            IF g_master.chk5 = 'N' THEN
               LET g_master.days = 0
               DISPLAY BY NAME g_master.days
               CALL cl_set_comp_entry("days",FALSE)
            ELSE
               CALL cl_set_comp_entry("days",TRUE)
            END IF
            #151223-00003 by whitney add end

            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD days
            #add-point:BEFORE FIELD days name="input.b.days"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD days
            
            #add-point:AFTER FIELD days name="input.a.days"
            IF NOT cl_null(g_master.days) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE days
            #add-point:ON CHANGE days name="input.g.days"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk1
            #add-point:BEFORE FIELD chk1 name="input.b.chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk1
            
            #add-point:AFTER FIELD chk1 name="input.a.chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk1
            #add-point:ON CHANGE chk1 name="input.g.chk1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk2
            #add-point:BEFORE FIELD chk2 name="input.b.chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk2
            
            #add-point:AFTER FIELD chk2 name="input.a.chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk2
            #add-point:ON CHANGE chk2 name="input.g.chk2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk3
            #add-point:BEFORE FIELD chk3 name="input.b.chk3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk3
            
            #add-point:AFTER FIELD chk3 name="input.a.chk3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk3
            #add-point:ON CHANGE chk3 name="input.g.chk3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk4
            #add-point:BEFORE FIELD chk4 name="input.b.chk4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk4
            
            #add-point:AFTER FIELD chk4 name="input.a.chk4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk4
            #add-point:ON CHANGE chk4 name="input.g.chk4"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.pspc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pspc001
            #add-point:ON ACTION controlp INFIELD pspc001 name="input.c.pspc001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.pspc001
            LET g_qryparam.where = " pscasite = '",g_site,"' "
            CALL q_psca001()
            LET g_master.pspc001 = g_qryparam.return1
            CALL s_apsp600_pspc001_ref(g_master.pspc001) RETURNING g_master.pspc001_desc
            DISPLAY BY NAME g_master.pspc001,g_master.pspc001_desc
            NEXT FIELD pspc001
            #END add-point
 
 
         #Ctrlp:input.c.ooba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooba002
            #add-point:ON ACTION controlp INFIELD ooba002 name="input.c.ooba002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.ooba002
            LET g_qryparam.arg1 = l_ooef004
            LET g_qryparam.arg2 = 'apmt400'
            CALL q_ooba002_1()
            LET g_master.ooba002 = g_qryparam.return1
            CALL s_aooi200_get_slip_desc(g_master.ooba002) RETURNING g_master.ooba002_desc
            DISPLAY BY NAME g_master.ooba002,g_master.ooba002_desc
            NEXT FIELD ooba002
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk6
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk6
            #add-point:ON ACTION controlp INFIELD chk6 name="input.c.chk6"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk5
            #add-point:ON ACTION controlp INFIELD chk5 name="input.c.chk5"
            
            #END add-point
 
 
         #Ctrlp:input.c.days
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD days
            #add-point:ON ACTION controlp INFIELD days name="input.c.days"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk1
            #add-point:ON ACTION controlp INFIELD chk1 name="input.c.chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk2
            #add-point:ON ACTION controlp INFIELD chk2 name="input.c.chk2"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk3
            #add-point:ON ACTION controlp INFIELD chk3 name="input.c.chk3"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk4
            #add-point:ON ACTION controlp INFIELD chk4 name="input.c.chk4"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imae012,imaf142,pspc010,pspc045,imaa009,imaf141,pspc050
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imae012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imae012
            #add-point:ON ACTION controlp INFIELD imae012 name="construct.c.imae012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
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
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       #呼叫開窗
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
         BEFORE FIELD pspc010
            #add-point:BEFORE FIELD pspc010 name="construct.b.pspc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pspc010
            
            #add-point:AFTER FIELD pspc010 name="construct.a.pspc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pspc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pspc010
            #add-point:ON ACTION controlp INFIELD pspc010 name="construct.c.pspc010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pspc045
            #add-point:BEFORE FIELD pspc045 name="construct.b.pspc045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pspc045
            
            #add-point:AFTER FIELD pspc045 name="construct.a.pspc045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pspc045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pspc045
            #add-point:ON ACTION controlp INFIELD pspc045 name="construct.c.pspc045"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                       #呼叫開窗
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
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imce141()                       #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.pspc050
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pspc050
            #add-point:ON ACTION controlp INFIELD pspc050 name="construct.c.pspc050"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO pspc050  #顯示到畫面上
            NEXT FIELD pspc050                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pspc050
            #add-point:BEFORE FIELD pspc050 name="construct.b.pspc050"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pspc050
            
            #add-point:AFTER FIELD pspc050 name="construct.a.pspc050"
            
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
            CALL apsp601_get_buffer(l_dialog)
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
         CALL apsp601_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.pspc001 = g_master.pspc001
      LET lc_param.ooba002 = g_master.ooba002
      LET lc_param.chk     = g_master.chk
      #151223-00003 by whitney add start
      LET lc_param.chk5    = g_master.chk5
      LET lc_param.days    = g_master.days
      #151223-00003 by whitney add end
      LET lc_param.chk1    = g_master.chk1
      LET lc_param.chk2    = g_master.chk2
      LET lc_param.chk3    = g_master.chk3
      LET lc_param.chk4    = g_master.chk4
      LET lc_param.chk6    = g_master.chk6  #160825-00037#1-add
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
                 CALL apsp601_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsp601_transfer_argv(ls_js)
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
 
{<section id="apsp601.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsp601_transfer_argv(ls_js)
 
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
 
{<section id="apsp601.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsp601_process(ls_js)
 
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
   DEFINE l_str         STRING

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
#  DECLARE apsp601_process_cs CURSOR FROM ls_sql
#  FOREACH apsp601_process_cs INTO
   #add-point:process段process name="process.process"

   CALL s_apsp600_tmp_create()
   DELETE FROM s_apsp600_tmp
   
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = "1=1"
   END IF
   
   #160601-00032#2 20160606 modify by ming -----(S) 
   #LET g_sql = " SELECT pspc001,pspc002,pspc004,pspc014,(NVL(pspc034,0)-NVL(pspc061,0)), ", 
   LET g_sql = " SELECT pspc001,pspc002,pspc004,pspc014,pspc018,(NVL(pspc034,0)-NVL(pspc061,0)), ", 
   #160601-00032#2 20160606 modify by ming -----(E) 
               #160512-00016#6 20160523 modify by ming -----(S) 
               #"        pspc045,pspc050,pspc051,imaa009,imaf141,imaf142,imae012 ", 
               "        pspc045,pspc050,pspc051,pspc062,imaa009,imaf141,imaf142,imae012 ", 
               #160512-00016#6 20160523 modify by ming -----(E) 
               "   FROM pspc_t ",
               "        LEFT OUTER JOIN imae_t ON imaeent = pspcent AND imaesite = pspcsite AND imae001 = pspc050 ",
               "        LEFT OUTER JOIN imaf_t ON imafent = pspcent AND imafsite = pspcsite AND imaf001 = pspc050 ",
               "        LEFT OUTER JOIN imaa_t ON imaaent = pspcent AND imaa001 = pspc050 ",
               #151223-00003 by whitney add start
               "        LEFT OUTER JOIN psoq_t ON psoqent = pspcent AND psoqsite = pspcsite AND psoq001 = pspc001 AND psoq002 = pspc002 AND psoq004 = pspc018 ",
               #151223-00003 by whitney add end
               "  WHERE pspcent = ",g_enterprise,
               "    AND pspcsite = '",g_site,"' ",
               "    AND pspc001 = '",lc_param.pspc001,"' ",
               "    AND pspc002 = (SELECT MAX(pspc002) FROM pspc_t WHERE pspcent = ",g_enterprise," AND pspcsite = '",g_site,"' AND pspc001 = '",lc_param.pspc001,"') ",
               "    AND pspc007 = '1' ",
               "    AND NVL(pspc034,0) > NVL(pspc061,0) ",
               "    AND ",lc_param.wc CLIPPED
   #151223-00003 by whitney add start
   IF lc_param.chk5 = 'Y' AND lc_param.days > 0 THEN
      LET g_sql = g_sql," AND psoq024 < (psoq007+",lc_param.days,") "
   END IF
   #151223-00003 by whitney add end
   LET g_sql = " INSERT INTO s_apsp600_tmp ",g_sql
   PREPARE tmp_ins_pre FROM g_sql
   EXECUTE tmp_ins_pre
   
   LET li_count = 0
   SELECT COUNT(*) INTO li_count FROM s_apsp600_tmp
   IF cl_null(li_count) THEN LET li_count = 0 END IF
   IF li_count <> 0 THEN
      LET l_success = TRUE
      LET l_str = ''
      CALL s_transaction_begin()
      #160825-00037#1-s-mod
      #IF g_bgjob = "N" THEN
      #   CALL s_apsp600_batch_execute_not_bgjob(lc_param.ooba002,lc_param.chk,lc_param.chk1,lc_param.chk2,lc_param.chk3,lc_param.chk4)
      #        RETURNING l_success,l_str
      #ELSE
      #   CALL s_apsp600_batch_execute(lc_param.ooba002,lc_param.chk,lc_param.chk1,lc_param.chk2,lc_param.chk3,lc_param.chk4)
      #        RETURNING l_success,l_str
      #END IF
      IF g_bgjob = "N" THEN
         CALL s_apsp600_batch_execute_not_bgjob(lc_param.ooba002,lc_param.chk,lc_param.chk1,lc_param.chk2,lc_param.chk3,lc_param.chk4,lc_param.chk6)
              RETURNING l_success,l_str
      ELSE
         CALL s_apsp600_batch_execute(lc_param.ooba002,lc_param.chk,lc_param.chk1,lc_param.chk2,lc_param.chk3,lc_param.chk4,lc_param.chk6)
              RETURNING l_success,l_str
      END IF
      #160825-00037#1-e-mod
      IF l_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
   END IF


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
   CALL apsp601_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apsp601.get_buffer" >}
PRIVATE FUNCTION apsp601_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pspc001 = p_dialog.getFieldBuffer('pspc001')
   LET g_master.ooba002 = p_dialog.getFieldBuffer('ooba002')
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
   LET g_master.chk6 = p_dialog.getFieldBuffer('chk6')
   LET g_master.chk5 = p_dialog.getFieldBuffer('chk5')
   LET g_master.days = p_dialog.getFieldBuffer('days')
   LET g_master.chk1 = p_dialog.getFieldBuffer('chk1')
   LET g_master.chk2 = p_dialog.getFieldBuffer('chk2')
   LET g_master.chk3 = p_dialog.getFieldBuffer('chk3')
   LET g_master.chk4 = p_dialog.getFieldBuffer('chk4')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsp601.msgcentre_notify" >}
PRIVATE FUNCTION apsp601_msgcentre_notify()
 
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
 
{<section id="apsp601.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
