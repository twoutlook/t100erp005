#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr828.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-06 17:44:44), PR版次:0002(2016-10-25 15:54:09)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000016
#+ Filename...: acrr828
#+ Description: 門店品類消費統計對比分析報表
#+ Creator....: 08172(2016-07-05 16:16:22)
#+ Modifier...: 08172 -SD/PR- 08742
 
{</section>}
 
{<section id="acrr828.global" >}
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
       rtaa001 LIKE type_t.chr10, 
   debssite LIKE type_t.chr10, 
   rtax004 LIKE type_t.num5, 
   rtax001 LIKE type_t.chr10, 
   oocq002 LIKE type_t.chr10, 
   sel LIKE type_t.chr500, 
   vip LIKE type_t.chr500, 
   stage LIKE type_t.chr500, 
   stage_y1 LIKE type_t.chr500, 
   stage_y2 LIKE type_t.chr500, 
   stage_y3 LIKE type_t.chr500, 
   stage_y1_1 LIKE type_t.chr500, 
   stage_y2_1 LIKE type_t.chr500, 
   stage_y3_1 LIKE type_t.chr500, 
   stage_y1_2 LIKE type_t.chr500, 
   stage_y2_2 LIKE type_t.chr500, 
   stage_y3_2 LIKE type_t.chr500, 
   stage_y1_3 LIKE type_t.chr500, 
   stage_y2_3 LIKE type_t.chr500, 
   stage_y3_3 LIKE type_t.chr500, 
   stage_y1_4 LIKE type_t.chr500, 
   stage_y2_4 LIKE type_t.chr500, 
   stage_y3_4 LIKE type_t.chr500,
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
 
{<section id="acrr828.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success   LIKE type_t.num5
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
      CALL acrr828_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr828 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr828_init()
 
      #進入選單 Menu (="N")
      CALL acrr828_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr828
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr828.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr828_init()
   #add-point:init段define name="init.define"
   DEFINE l_success   LIKE type_t.num5
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
   IF g_prog = "acrr828" THEN
      CALL cl_set_comp_visible("oocq002",FALSE)
   END IF
   IF g_prog = "acrr829" THEN
      CALL cl_set_comp_visible("rtax004,rtax001",FALSE)
   END IF
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL cl_set_combo_scc("rtax004","6902")
   CALL cl_set_combo_scc("sel","6895")
   LET g_master.rtax004 = '0'
   LET g_master.vip = 'N'
   LET g_master.sel = '1'
   LET g_master.stage = '1'
   SELECT ooef008,ooef010  INTO g_oogc001,g_oogc002
     FROM ooef_t
    WHERE ooefent=g_enterprise
      AND ooef001=g_site
   CALL s_get_oogcdate(g_oogc001,g_oogc002,g_today,"","") RETURNING g_flag,g_errno,g_oogc015,g_oogc007,g_sdate_s,g_sdate_e,g_oogc006,g_pdate_s,g_pdate_e,g_oogc008,g_wdate_s,g_wdate_e
   LET g_master.stage_y1 = g_oogc015
   LET g_master.stage_y2 = g_oogc006
   LET g_master.stage_y3 = g_oogc006
   LET g_master.stage_y1_1 = ''
   LET g_master.stage_y2_1 = ''
   LET g_master.stage_y3_1 = ''
   LET g_master.stage_y1_2 = ''
   LET g_master.stage_y2_2 = ''
   LET g_master.stage_y3_2 = ''
   LET g_master.stage_y1_3 = ''
   LET g_master.stage_y2_3 = ''
   LET g_master.stage_y3_3 = ''
   LET g_master.stage_y1_4 = ''
   LET g_master.stage_y2_4 = ''
   LET g_master.stage_y3_4 = ''
   CALL acrr828_set_visible()
   CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
   CALL cl_set_comp_visible("stage_y1_1,stage_y2_1,stage_y3_1",FALSE)
   CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",FALSE)
   CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
   CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr828.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr828_ui_dialog()
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
         INPUT BY NAME g_master.rtax004,g_master.sel,g_master.vip,g_master.stage,g_master.stage_y1,g_master.stage_y2, 
             g_master.stage_y3,g_master.stage_y1_1,g_master.stage_y2_1,g_master.stage_y3_1,g_master.stage_y1_2, 
             g_master.stage_y2_2,g_master.stage_y3_2,g_master.stage_y1_3,g_master.stage_y2_3,g_master.stage_y3_3, 
             g_master.stage_y1_4,g_master.stage_y2_4,g_master.stage_y3_4 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtax004
            #add-point:BEFORE FIELD rtax004 name="input.b.rtax004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtax004
            
            #add-point:AFTER FIELD rtax004 name="input.a.rtax004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtax004
            #add-point:ON CHANGE rtax004 name="input.g.rtax004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sel
            #add-point:BEFORE FIELD sel name="input.b.sel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sel
            
            #add-point:AFTER FIELD sel name="input.a.sel"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sel
            #add-point:ON CHANGE sel name="input.g.sel"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD vip
            #add-point:BEFORE FIELD vip name="input.b.vip"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD vip
            
            #add-point:AFTER FIELD vip name="input.a.vip"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE vip
            #add-point:ON CHANGE vip name="input.g.vip"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage
            #add-point:BEFORE FIELD stage name="input.b.stage"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage
            
            #add-point:AFTER FIELD stage name="input.a.stage"
            IF g_master.stage = '1' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_visible("stage_y1_1,stage_y2_1,stage_y3_1",FALSE)
               CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",FALSE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '2' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",FALSE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '3' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '4' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_required("stage_y1_3,stage_y2_3,stage_y3_3",TRUE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '5' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_required("stage_y1_3,stage_y2_3,stage_y3_3",TRUE)
               CALL cl_set_comp_required("stage_y1_4,stage_y2_4,stage_y3_4",TRUE)
            END IF
            CALL acrr828_stage_default()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage
            #add-point:ON CHANGE stage name="input.g.stage"
            IF g_master.stage = '1' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_visible("stage_y1_1,stage_y2_1,stage_y3_1",FALSE)
               CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",FALSE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '2' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",FALSE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '3' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",FALSE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '4' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_required("stage_y1_3,stage_y2_3,stage_y3_3",TRUE)
               CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",FALSE)
            END IF
            IF g_master.stage = '5' THEN
               CALL acrr828_set_visible()
               CALL cl_set_comp_required("stage_y1,stage_y2,stage_y3",TRUE)
               CALL cl_set_comp_required("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
               CALL cl_set_comp_required("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
               CALL cl_set_comp_required("stage_y1_3,stage_y2_3,stage_y3_3",TRUE)
               CALL cl_set_comp_required("stage_y1_4,stage_y2_4,stage_y3_4",TRUE)
            END IF
            CALL acrr828_stage_default()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y1
            #add-point:BEFORE FIELD stage_y1 name="input.b.stage_y1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y1
            
            #add-point:AFTER FIELD stage_y1 name="input.a.stage_y1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y1
            #add-point:ON CHANGE stage_y1 name="input.g.stage_y1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y2
            #add-point:BEFORE FIELD stage_y2 name="input.b.stage_y2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y2
            
            #add-point:AFTER FIELD stage_y2 name="input.a.stage_y2"
            IF NOT cl_null(g_master.stage_y2) THEN
               IF g_master.stage_y2 > g_master.stage_y3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = g_master.stage_y2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y2
            #add-point:ON CHANGE stage_y2 name="input.g.stage_y2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y3
            #add-point:BEFORE FIELD stage_y3 name="input.b.stage_y3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y3
            
            #add-point:AFTER FIELD stage_y3 name="input.a.stage_y3"
            IF NOT cl_null(g_master.stage_y3) THEN
               IF g_master.stage_y2 > g_master.stage_y3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = g_master.stage_y3
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y3
            #add-point:ON CHANGE stage_y3 name="input.g.stage_y3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y1_1
            #add-point:BEFORE FIELD stage_y1_1 name="input.b.stage_y1_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y1_1
            
            #add-point:AFTER FIELD stage_y1_1 name="input.a.stage_y1_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y1_1
            #add-point:ON CHANGE stage_y1_1 name="input.g.stage_y1_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y2_1
            #add-point:BEFORE FIELD stage_y2_1 name="input.b.stage_y2_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y2_1
            
            #add-point:AFTER FIELD stage_y2_1 name="input.a.stage_y2_1"
            IF NOT cl_null(g_master.stage_y2_1) THEN
               IF g_master.stage_y2_1 > g_master.stage_y3_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = g_master.stage_y2_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y2_1
            #add-point:ON CHANGE stage_y2_1 name="input.g.stage_y2_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y3_1
            #add-point:BEFORE FIELD stage_y3_1 name="input.b.stage_y3_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y3_1
            
            #add-point:AFTER FIELD stage_y3_1 name="input.a.stage_y3_1"
            IF NOT cl_null(g_master.stage_y3_1) THEN
               IF g_master.stage_y2_1 > g_master.stage_y3_1 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = g_master.stage_y3_1
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y3_1
            #add-point:ON CHANGE stage_y3_1 name="input.g.stage_y3_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y1_2
            #add-point:BEFORE FIELD stage_y1_2 name="input.b.stage_y1_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y1_2
            
            #add-point:AFTER FIELD stage_y1_2 name="input.a.stage_y1_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y1_2
            #add-point:ON CHANGE stage_y1_2 name="input.g.stage_y1_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y2_2
            #add-point:BEFORE FIELD stage_y2_2 name="input.b.stage_y2_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y2_2
            
            #add-point:AFTER FIELD stage_y2_2 name="input.a.stage_y2_2"
            IF NOT cl_null(g_master.stage_y2_2) THEN
               IF g_master.stage_y2_2 > g_master.stage_y3_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = g_master.stage_y2_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y2_2
            #add-point:ON CHANGE stage_y2_2 name="input.g.stage_y2_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y3_2
            #add-point:BEFORE FIELD stage_y3_2 name="input.b.stage_y3_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y3_2
            
            #add-point:AFTER FIELD stage_y3_2 name="input.a.stage_y3_2"
            IF NOT cl_null(g_master.stage_y3_2) THEN
               IF g_master.stage_y2_2 > g_master.stage_y3_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = g_master.stage_y3_2
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y3_2
            #add-point:ON CHANGE stage_y3_2 name="input.g.stage_y3_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y1_3
            #add-point:BEFORE FIELD stage_y1_3 name="input.b.stage_y1_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y1_3
            
            #add-point:AFTER FIELD stage_y1_3 name="input.a.stage_y1_3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y1_3
            #add-point:ON CHANGE stage_y1_3 name="input.g.stage_y1_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y2_3
            #add-point:BEFORE FIELD stage_y2_3 name="input.b.stage_y2_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y2_3
            
            #add-point:AFTER FIELD stage_y2_3 name="input.a.stage_y2_3"
            IF NOT cl_null(g_master.stage_y2_3) THEN
               IF g_master.stage_y2_3 > g_master.stage_y3_3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = g_master.stage_y2_3
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y2_3
            #add-point:ON CHANGE stage_y2_3 name="input.g.stage_y2_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y3_3
            #add-point:BEFORE FIELD stage_y3_3 name="input.b.stage_y3_3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y3_3
            
            #add-point:AFTER FIELD stage_y3_3 name="input.a.stage_y3_3"
            IF NOT cl_null(g_master.stage_y3_3) THEN
               IF g_master.stage_y2_3 > g_master.stage_y3_3 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = g_master.stage_y3_3
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y3_3
            #add-point:ON CHANGE stage_y3_3 name="input.g.stage_y3_3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y1_4
            #add-point:BEFORE FIELD stage_y1_4 name="input.b.stage_y1_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y1_4
            
            #add-point:AFTER FIELD stage_y1_4 name="input.a.stage_y1_4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y1_4
            #add-point:ON CHANGE stage_y1_4 name="input.g.stage_y1_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y2_4
            #add-point:BEFORE FIELD stage_y2_4 name="input.b.stage_y2_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y2_4
            
            #add-point:AFTER FIELD stage_y2_4 name="input.a.stage_y2_4"
            IF NOT cl_null(g_master.stage_y2_4) THEN
               IF g_master.stage_y2_4 > g_master.stage_y3_4 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00227"
                  LET g_errparam.extend = g_master.stage_y2_4
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y2_4
            #add-point:ON CHANGE stage_y2_4 name="input.g.stage_y2_4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stage_y3_4
            #add-point:BEFORE FIELD stage_y3_4 name="input.b.stage_y3_4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stage_y3_4
            
            #add-point:AFTER FIELD stage_y3_4 name="input.a.stage_y3_4"
            IF NOT cl_null(g_master.stage_y3_4) THEN
               IF g_master.stage_y2_4 > g_master.stage_y3_4 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "agl-00228"
                  LET g_errparam.extend = g_master.stage_y3_4
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stage_y3_4
            #add-point:ON CHANGE stage_y3_4 name="input.g.stage_y3_4"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.rtax004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtax004
            #add-point:ON ACTION controlp INFIELD rtax004 name="input.c.rtax004"
            
            #END add-point
 
 
         #Ctrlp:input.c.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.vip
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD vip
            #add-point:ON ACTION controlp INFIELD vip name="input.c.vip"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage
            #add-point:ON ACTION controlp INFIELD stage name="input.c.stage"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y1
            #add-point:ON ACTION controlp INFIELD stage_y1 name="input.c.stage_y1"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y2
            #add-point:ON ACTION controlp INFIELD stage_y2 name="input.c.stage_y2"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y3
            #add-point:ON ACTION controlp INFIELD stage_y3 name="input.c.stage_y3"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y1_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y1_1
            #add-point:ON ACTION controlp INFIELD stage_y1_1 name="input.c.stage_y1_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y2_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y2_1
            #add-point:ON ACTION controlp INFIELD stage_y2_1 name="input.c.stage_y2_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y3_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y3_1
            #add-point:ON ACTION controlp INFIELD stage_y3_1 name="input.c.stage_y3_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y1_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y1_2
            #add-point:ON ACTION controlp INFIELD stage_y1_2 name="input.c.stage_y1_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y2_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y2_2
            #add-point:ON ACTION controlp INFIELD stage_y2_2 name="input.c.stage_y2_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y3_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y3_2
            #add-point:ON ACTION controlp INFIELD stage_y3_2 name="input.c.stage_y3_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y1_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y1_3
            #add-point:ON ACTION controlp INFIELD stage_y1_3 name="input.c.stage_y1_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y2_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y2_3
            #add-point:ON ACTION controlp INFIELD stage_y2_3 name="input.c.stage_y2_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y3_3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y3_3
            #add-point:ON ACTION controlp INFIELD stage_y3_3 name="input.c.stage_y3_3"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y1_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y1_4
            #add-point:ON ACTION controlp INFIELD stage_y1_4 name="input.c.stage_y1_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y2_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y2_4
            #add-point:ON ACTION controlp INFIELD stage_y2_4 name="input.c.stage_y2_4"
            
            #END add-point
 
 
         #Ctrlp:input.c.stage_y3_4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stage_y3_4
            #add-point:ON ACTION controlp INFIELD stage_y3_4 name="input.c.stage_y3_4"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtaa001,debssite,rtax001,oocq002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaa001
            #add-point:ON ACTION controlp INFIELD rtaa001 name="construct.c.rtaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '1'
            CALL q_rtaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaa001  #顯示到畫面上
            NEXT FIELD rtaa001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaa001
            #add-point:BEFORE FIELD rtaa001 name="construct.b.rtaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaa001
            
            #add-point:AFTER FIELD rtaa001 name="construct.a.rtaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.debssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debssite
            #add-point:ON ACTION controlp INFIELD debssite name="construct.c.debssite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debssite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO debssite  #顯示到畫面上
            NEXT FIELD debssite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debssite
            #add-point:BEFORE FIELD debssite name="construct.b.debssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debssite
            
            #add-point:AFTER FIELD debssite name="construct.a.debssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtax001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtax001
            #add-point:ON ACTION controlp INFIELD rtax001 name="construct.c.rtax001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF g_master.rtax004='0' THEN
               LET g_qryparam.where = " rtax005=0"
            END IF
            IF g_master.rtax004='1' THEN
               LET g_qryparam.where = " rtax004='1'"
            END IF
            IF g_master.rtax004='2' THEN
               LET g_qryparam.where = " rtax004='2'"
            END IF
            IF g_master.rtax004='3' THEN
               LET g_qryparam.where = " rtax004='3'"
            END IF
            IF g_master.rtax004='4' THEN
               LET g_qryparam.where = " rtax004='4'"
            END IF
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtax001  #顯示到畫面上
            NEXT FIELD rtax001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtax001
            #add-point:BEFORE FIELD rtax001 name="construct.b.rtax001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtax001
            
            #add-point:AFTER FIELD rtax001 name="construct.a.rtax001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="construct.c.oocq002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002  #顯示到畫面上
            NEXT FIELD oocq002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="construct.b.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="construct.a.oocq002"
            
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
            CALL acrr828_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr828_get_buffer(l_dialog)
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
         CALL acrr828_init()
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
                 CALL acrr828_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr828_transfer_argv(ls_js)
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
 
{<section id="acrr828.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr828_transfer_argv(ls_js)
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
 
{<section id="acrr828.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr828_process(ls_js)
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
   DEFINE l_dat1        STRING                    #期别1
   DEFINE l_dat2        STRING                    #期别2
   DEFINE l_dat3        STRING                    #期别3
   DEFINE l_dat4        STRING                    #期别4
   DEFINE l_dat5        STRING                    #期别5
   
   DEFINE l_dat_name1   LIKE type_t.chr500
   DEFINE l_dat_name2   LIKE type_t.chr500
   DEFINE l_dat_name3   LIKE type_t.chr500
   DEFINE l_dat_name4   LIKE type_t.chr500
   DEFINE l_dat_name5   LIKE type_t.chr500
   DEFINE l_stage_y1 LIKE type_t.chr500 
   DEFINE l_stage_y2 LIKE type_t.chr500 
   DEFINE l_stage_y3 LIKE type_t.chr500 
   DEFINE l_stage_y1_1 LIKE type_t.chr500
   DEFINE l_stage_y2_1 LIKE type_t.chr500
   DEFINE l_stage_y3_1 LIKE type_t.chr500
   DEFINE l_stage_y1_2 LIKE type_t.chr500
   DEFINE l_stage_y2_2 LIKE type_t.chr500
   DEFINE l_stage_y3_2 LIKE type_t.chr500
   DEFINE l_stage_y1_3 LIKE type_t.chr500
   DEFINE l_stage_y2_3 LIKE type_t.chr500
   DEFINE l_stage_y3_3 LIKE type_t.chr500
   DEFINE l_stage_y1_4 LIKE type_t.chr500
   DEFINE l_stage_y2_4 LIKE type_t.chr500
   DEFINE l_stage_y3_4 LIKE type_t.chr500

   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"rtaa001,debssite,rtax001,oocq002")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = "1=1"
   END IF
   IF g_master.vip = 'N' THEN
      LET g_master.wc = cl_replace_str(g_master.wc,"rtaa001","rtab001")
      LET g_master.wc = cl_replace_str(g_master.wc,"oocq002","debs006")
      IF g_prog = 'acrr828' THEN
         LET g_master.wc = cl_replace_str(g_master.wc,"debssite","debwsite")
         LET g_master.wc = cl_replace_str(g_master.wc,"rtax001","debw005")
         LET g_master.wc = g_master.wc CLIPPED," AND debwent = '",g_enterprise,"'"
      ELSE
         LET g_master.wc = cl_replace_str(g_master.wc,"rtax001","debs005")
         LET g_master.wc = g_master.wc CLIPPED," AND debsent = '",g_enterprise,"'"
      END IF
   ELSE
      LET g_master.wc = cl_replace_str(g_master.wc,"rtaa001","rtab001")
      LET g_master.wc = cl_replace_str(g_master.wc,"oocq002","debt006")
      IF g_prog = 'acrr828' THEN
         LET g_master.wc = cl_replace_str(g_master.wc,"debssite","debxsite")
         LET g_master.wc = cl_replace_str(g_master.wc,"rtax001","debx005")
         LET g_master.wc = g_master.wc CLIPPED," AND debxent = '",g_enterprise,"'"
      ELSE
         LET g_master.wc = cl_replace_str(g_master.wc,"debssite","debtsite")
         LET g_master.wc = cl_replace_str(g_master.wc,"rtax001","debt005")
         LET g_master.wc = g_master.wc CLIPPED," AND debtent = '",g_enterprise,"'"
      END IF
   END IF
   CASE g_master.stage   #选择的期别
      WHEN 1
         LET l_dat_name1 = g_master.stage_y1,".",g_master.stage_y2,"-",g_master.stage_y3
      WHEN 2
         LET l_dat_name1 = g_master.stage_y1,".",g_master.stage_y2,"-",g_master.stage_y3
         LET l_dat_name2 = g_master.stage_y1_1,".",g_master.stage_y2_1,"-",g_master.stage_y3_1
      WHEN 3
         LET l_dat_name1 = g_master.stage_y1,".",g_master.stage_y2,"-",g_master.stage_y3
         LET l_dat_name2 = g_master.stage_y1_1,".",g_master.stage_y2_1,"-",g_master.stage_y3_1
         LET l_dat_name3 = g_master.stage_y1_2,".",g_master.stage_y2_2,"-",g_master.stage_y3_2
      WHEN 4
         LET l_dat_name1 = g_master.stage_y1,".",g_master.stage_y2,"-",g_master.stage_y3
         LET l_dat_name2 = g_master.stage_y1_1,".",g_master.stage_y2_1,"-",g_master.stage_y3_1
         LET l_dat_name3 = g_master.stage_y1_2,".",g_master.stage_y2_2,"-",g_master.stage_y3_2
         LET l_dat_name4 = g_master.stage_y1_3,".",g_master.stage_y2_3,"-",g_master.stage_y3_3
      WHEN 5
         LET l_dat_name1 = g_master.stage_y1,".",g_master.stage_y2,"-",g_master.stage_y3
         LET l_dat_name2 = g_master.stage_y1_1,".",g_master.stage_y2_1,"-",g_master.stage_y3_1
         LET l_dat_name3 = g_master.stage_y1_2,".",g_master.stage_y2_2,"-",g_master.stage_y3_2
         LET l_dat_name4 = g_master.stage_y1_3,".",g_master.stage_y2_3,"-",g_master.stage_y3_3
         LET l_dat_name5 = g_master.stage_y1_4,".",g_master.stage_y2_4,"-",g_master.stage_y3_4
   END CASE
   
   CASE g_master.stage
      WHEN 1   #选择期别1
         LET l_stage_y2 = MDY(g_master.stage_y2,1,g_master.stage_y1)
         LET l_stage_y3 = MDY(g_master.stage_y3,1,g_master.stage_y1)
         CALL s_date_get_last_date(l_stage_y3) RETURNING l_stage_y3
         LET l_dat1 = " BETWEEN to_date('",l_stage_y2,"','yy/mm/dd') AND to_date('",l_stage_y3,"','yy/mm/dd') "
      WHEN 2
         LET l_stage_y2 = MDY(g_master.stage_y2,1,g_master.stage_y1)
         LET l_stage_y3 = MDY(g_master.stage_y3,1,g_master.stage_y1)
         CALL s_date_get_last_date(l_stage_y3) RETURNING l_stage_y3
         LET l_dat1 = " BETWEEN to_date('",l_stage_y2,"','yy/mm/dd') AND to_date('",l_stage_y3,"','yy/mm/dd') "
         
         LET l_stage_y2_1 = MDY(g_master.stage_y2_1,1,g_master.stage_y1_1)
         LET l_stage_y3_1 = MDY(g_master.stage_y3_1,1,g_master.stage_y1_1)
         CALL s_date_get_last_date(l_stage_y3_1) RETURNING l_stage_y3_1
         LET l_dat2 = " BETWEEN to_date('",l_stage_y2_1,"','yy/mm/dd') AND to_date('",l_stage_y3_1,"','yy/mm/dd') "
      WHEN 3
         LET l_stage_y2 = MDY(g_master.stage_y2,1,g_master.stage_y1)
         LET l_stage_y3 = MDY(g_master.stage_y3,1,g_master.stage_y1)
         CALL s_date_get_last_date(l_stage_y3) RETURNING l_stage_y3
         LET l_dat1 = " BETWEEN to_date('",l_stage_y2,"','yy/mm/dd') AND to_date('",l_stage_y3,"','yy/mm/dd') "
         
         LET l_stage_y2_1 = MDY(g_master.stage_y2_1,1,g_master.stage_y1_1)
         LET l_stage_y3_1 = MDY(g_master.stage_y3_1,1,g_master.stage_y1_1)
         CALL s_date_get_last_date(l_stage_y3_1) RETURNING l_stage_y3_1
         LET l_dat2 = " BETWEEN to_date('",l_stage_y2_1,"','yy/mm/dd') AND to_date('",l_stage_y3_1,"','yy/mm/dd') "
         
         LET l_stage_y2_2 = MDY(g_master.stage_y2_2,1,g_master.stage_y1_2)
         LET l_stage_y3_2 = MDY(g_master.stage_y3_2,1,g_master.stage_y1_2)
         CALL s_date_get_last_date(l_stage_y3_2) RETURNING l_stage_y3_2
         LET l_dat3 = " BETWEEN to_date('",l_stage_y2_2,"','yy/mm/dd') AND to_date('",l_stage_y3_2,"','yy/mm/dd') "
      WHEN 4
         LET l_stage_y2 = MDY(g_master.stage_y2,1,g_master.stage_y1)
         LET l_stage_y3 = MDY(g_master.stage_y3,1,g_master.stage_y1)
         CALL s_date_get_last_date(l_stage_y3) RETURNING l_stage_y3
         LET l_dat1 = " BETWEEN to_date('",l_stage_y2,"','yy/mm/dd') AND to_date('",l_stage_y3,"','yy/mm/dd') "
         
         LET l_stage_y2_1 = MDY(g_master.stage_y2_1,1,g_master.stage_y1_1)
         LET l_stage_y3_1 = MDY(g_master.stage_y3_1,1,g_master.stage_y1_1)
         CALL s_date_get_last_date(l_stage_y3_1) RETURNING l_stage_y3_1
         LET l_dat2 = " BETWEEN to_date('",l_stage_y2_1,"','yy/mm/dd') AND to_date('",l_stage_y3_1,"','yy/mm/dd') "
         
         LET l_stage_y2_2 = MDY(g_master.stage_y2_2,1,g_master.stage_y1_2)
         LET l_stage_y3_2 = MDY(g_master.stage_y3_2,1,g_master.stage_y1_2)
         CALL s_date_get_last_date(l_stage_y3_2) RETURNING l_stage_y3_2
         LET l_dat3 = " BETWEEN to_date('",l_stage_y2_2,"','yy/mm/dd') AND to_date('",l_stage_y3_2,"','yy/mm/dd') "
         
         LET l_stage_y2_3 = MDY(g_master.stage_y2_3,1,g_master.stage_y1_3)
         LET l_stage_y3_3 = MDY(g_master.stage_y3_3,1,g_master.stage_y1_3)
         CALL s_date_get_last_date(l_stage_y3_3) RETURNING l_stage_y3_3
         LET l_dat4 = " BETWEEN to_date('",l_stage_y2_3,"','yy/mm/dd') AND to_date('",l_stage_y3_3,"','yy/mm/dd') "
      WHEN 5
         LET l_stage_y2 = MDY(g_master.stage_y2,1,g_master.stage_y1)
         LET l_stage_y3 = MDY(g_master.stage_y3,1,g_master.stage_y1)
         CALL s_date_get_last_date(l_stage_y3) RETURNING l_stage_y3
         LET l_dat1 = " BETWEEN to_date('",l_stage_y2,"','yy/mm/dd') AND to_date('",l_stage_y3,"','yy/mm/dd') "
         
         LET l_stage_y2_1 = MDY(g_master.stage_y2_1,1,g_master.stage_y1_1)
         LET l_stage_y3_1 = MDY(g_master.stage_y3_1,1,g_master.stage_y1_1)
         CALL s_date_get_last_date(l_stage_y3_1) RETURNING l_stage_y3_1
         LET l_dat2 = " BETWEEN to_date('",l_stage_y2_1,"','yy/mm/dd') AND to_date('",l_stage_y3_1,"','yy/mm/dd') "
         
         LET l_stage_y2_2 = MDY(g_master.stage_y2_2,1,g_master.stage_y1_2)
         LET l_stage_y3_2 = MDY(g_master.stage_y3_2,1,g_master.stage_y1_2)
         CALL s_date_get_last_date(l_stage_y3_2) RETURNING l_stage_y3_2
         LET l_dat3 = " BETWEEN to_date('",l_stage_y2_2,"','yy/mm/dd') AND to_date('",l_stage_y3_2,"','yy/mm/dd') "
         
         LET l_stage_y2_3 = MDY(g_master.stage_y2_3,1,g_master.stage_y1_3)
         LET l_stage_y3_3 = MDY(g_master.stage_y3_3,1,g_master.stage_y1_3)
         CALL s_date_get_last_date(l_stage_y3_3) RETURNING l_stage_y3_3
         LET l_dat4 = " BETWEEN to_date('",l_stage_y2_3,"','yy/mm/dd') AND to_date('",l_stage_y3_3,"','yy/mm/dd') "
         
         LET l_stage_y2_4 = MDY(g_master.stage_y2_4,1,g_master.stage_y1_4)
         LET l_stage_y3_4 = MDY(g_master.stage_y3_4,1,g_master.stage_y1_4)
         CALL s_date_get_last_date(l_stage_y3_4) RETURNING l_stage_y3_4
         LET l_dat5 = " BETWEEN to_date('",l_stage_y2_4,"','yy/mm/dd') AND to_date('",l_stage_y3_4,"','yy/mm/dd') "
   END CASE
   CREATE TEMP TABLE acrr828_tmp(
       date_start  VARCHAR(500),               #开始日期
       date_end    VARCHAR(500),               #结束日期
       date_name   VARCHAR(500)     #年期
       )
   CASE g_master.stage
      WHEN 1
         DELETE FROM acrr828_tmp
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2,l_stage_y3,l_dat_name1)
      WHEN 2
         DELETE FROM acrr828_tmp
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2,l_stage_y3,l_dat_name1)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_1,l_stage_y3_1,l_dat_name2)
      WHEN 3
         DELETE FROM acrr828_tmp
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2,l_stage_y3,l_dat_name1)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_1,l_stage_y3_1,l_dat_name2)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_2,l_stage_y3_2,l_dat_name3)
      WHEN 4
         DELETE FROM acrr828_tmp
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2,l_stage_y3,l_dat_name1)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_1,l_stage_y3_1,l_dat_name2)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_2,l_stage_y3_2,l_dat_name3)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_3,l_stage_y3_3,l_dat_name4)
      WHEN 5
         DELETE FROM acrr828_tmp
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2,l_stage_y3,l_dat_name1)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_1,l_stage_y3_1,l_dat_name2)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_2,l_stage_y3_2,l_dat_name3)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_3,l_stage_y3_3,l_dat_name4)
         INSERT INTO acrr828_tmp(date_start,date_end,date_name) VALUES (l_stage_y2_4,l_stage_y3_4,l_dat_name5)
   END CASE
   IF g_prog="acrr828" THEN
      CALL acrr828_x01(g_master.wc,g_master.rtax004,g_master.sel,g_master.vip,g_master.stage,l_dat1,l_dat2,l_dat3,l_dat4,l_dat5,
                     l_dat_name1,l_dat_name2,l_dat_name3,l_dat_name4,l_dat_name5)
   END IF
   IF g_prog="acrr829" THEN
      CALL acrr828_x02(g_master.wc,g_master.sel,g_master.vip,g_master.stage,l_dat1,l_dat2,l_dat3,l_dat4,l_dat5,
                     l_dat_name1,l_dat_name2,l_dat_name3,l_dat_name4,l_dat_name5)
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr828_process_cs CURSOR FROM ls_sql
#  FOREACH acrr828_process_cs INTO
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
 
{<section id="acrr828.get_buffer" >}
PRIVATE FUNCTION acrr828_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.rtax004 = p_dialog.getFieldBuffer('rtax004')
   LET g_master.sel = p_dialog.getFieldBuffer('sel')
   LET g_master.vip = p_dialog.getFieldBuffer('vip')
   LET g_master.stage = p_dialog.getFieldBuffer('stage')
   LET g_master.stage_y1 = p_dialog.getFieldBuffer('stage_y1')
   LET g_master.stage_y2 = p_dialog.getFieldBuffer('stage_y2')
   LET g_master.stage_y3 = p_dialog.getFieldBuffer('stage_y3')
   LET g_master.stage_y1_1 = p_dialog.getFieldBuffer('stage_y1_1')
   LET g_master.stage_y2_1 = p_dialog.getFieldBuffer('stage_y2_1')
   LET g_master.stage_y3_1 = p_dialog.getFieldBuffer('stage_y3_1')
   LET g_master.stage_y1_2 = p_dialog.getFieldBuffer('stage_y1_2')
   LET g_master.stage_y2_2 = p_dialog.getFieldBuffer('stage_y2_2')
   LET g_master.stage_y3_2 = p_dialog.getFieldBuffer('stage_y3_2')
   LET g_master.stage_y1_3 = p_dialog.getFieldBuffer('stage_y1_3')
   LET g_master.stage_y2_3 = p_dialog.getFieldBuffer('stage_y2_3')
   LET g_master.stage_y3_3 = p_dialog.getFieldBuffer('stage_y3_3')
   LET g_master.stage_y1_4 = p_dialog.getFieldBuffer('stage_y1_4')
   LET g_master.stage_y2_4 = p_dialog.getFieldBuffer('stage_y2_4')
   LET g_master.stage_y3_4 = p_dialog.getFieldBuffer('stage_y3_4')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr828.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 期别带值
# Modify.........:
################################################################################
PRIVATE FUNCTION acrr828_stage_default()
   SELECT ooef008,ooef010  INTO g_oogc001,g_oogc002
   FROM ooef_t
  WHERE ooefent=g_enterprise
    AND ooef001=g_site
 CALL s_get_oogcdate(g_oogc001,g_oogc002,g_today,"","") RETURNING g_flag,g_errno,g_oogc015,g_oogc007,g_sdate_s,g_sdate_e,g_oogc006,g_pdate_s,g_pdate_e,g_oogc008,g_wdate_s,g_wdate_e
 CASE g_master.stage
    WHEN 1
       LET g_master.stage_y1 = g_oogc015
       LET g_master.stage_y2 = g_oogc006
       LET g_master.stage_y3 = g_oogc006
       
       LET g_master.stage_y1_1 = ""
       LET g_master.stage_y2_1 = ""
       LET g_master.stage_y3_1 = ""
       LET g_master.stage_y1_2 = ""
       LET g_master.stage_y2_2 = ""
       LET g_master.stage_y3_2 = ""
       LET g_master.stage_y1_3 = ""
       LET g_master.stage_y2_3 = ""
       LET g_master.stage_y3_3 = ""
       LET g_master.stage_y1_4 = ""
       LET g_master.stage_y2_4 = ""
       LET g_master.stage_y3_4 = ""
    WHEN 2
       LET g_master.stage_y1_1 = g_oogc015
       LET g_master.stage_y2_1 = g_oogc006
       LET g_master.stage_y3_1 = g_oogc006
       IF g_oogc006 = 1 THEN
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 12
             LET g_master.stage_y3 = 12
       ELSE
             LET g_master.stage_y1 = g_oogc015
             LET g_master.stage_y2 = g_oogc006-1
             LET g_master.stage_y3 = g_oogc006-1
       END IF
       LET g_master.stage_y1_2 = ""
       LET g_master.stage_y2_2 = ""
       LET g_master.stage_y3_2 = ""
       LET g_master.stage_y1_3 = ""
       LET g_master.stage_y2_3 = ""
       LET g_master.stage_y3_3 = ""
       LET g_master.stage_y1_4 = ""
       LET g_master.stage_y2_4 = ""
       LET g_master.stage_y3_4 = ""
    WHEN 3
       LET g_master.stage_y1_2 = g_oogc015
       LET g_master.stage_y2_2 = g_oogc006
       LET g_master.stage_y3_2 = g_oogc006
       CASE g_oogc006 
          WHEN 1
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 12
             LET g_master.stage_y3_1 = 12
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 11
             LET g_master.stage_y3 = 11
          WHEN 2
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = 1
             LET g_master.stage_y3_1 = 1
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 12
             LET g_master.stage_y3 = 12
          OTHERWISE
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = g_oogc006-1
             LET g_master.stage_y3_1 = g_oogc006-1
             LET g_master.stage_y1 = g_oogc015
             LET g_master.stage_y2 = g_oogc006-2
             LET g_master.stage_y3 = g_oogc006-2
       END CASE
       LET g_master.stage_y1_3 = ""
       LET g_master.stage_y2_3 = ""
       LET g_master.stage_y3_3 = ""
       LET g_master.stage_y1_4 = ""
       LET g_master.stage_y2_4 = ""
       LET g_master.stage_y3_4 = ""
    WHEN 4
       LET g_master.stage_y1_3 = g_oogc015
       LET g_master.stage_y2_3 = g_oogc006
       LET g_master.stage_y3_3 = g_oogc006
       CASE g_oogc006 
       WHEN 1
             LET g_master.stage_y1_2 = g_oogc015-1
             LET g_master.stage_y2_2 = 12
             LET g_master.stage_y3_2 = 12
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 11
             LET g_master.stage_y3_1 = 11
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 10
             LET g_master.stage_y3 = 10
       WHEN 2 
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = 1
             LET g_master.stage_y3_2 = 1
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 12
             LET g_master.stage_y3_1 = 12
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 11
             LET g_master.stage_y3 = 11
       WHEN 3 
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = 2
             LET g_master.stage_y3_2 = 2
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = 1
             LET g_master.stage_y3_1 = 1
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 12
             LET g_master.stage_y3 = 12
       OTHERWISE
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = g_oogc006-1
             LET g_master.stage_y3_2 = g_oogc006-1
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = g_oogc006-2
             LET g_master.stage_y3_1 = g_oogc006-2
             LET g_master.stage_y1 = g_oogc015
             LET g_master.stage_y2 = g_oogc006-3
             LET g_master.stage_y3 = g_oogc006-3
       END CASE
       LET g_master.stage_y1_4 = ""
       LET g_master.stage_y2_4 = ""
       LET g_master.stage_y3_4 = ""
    WHEN 5
       LET g_master.stage_y1_4 = g_oogc015
       LET g_master.stage_y2_4 = g_oogc006
       LET g_master.stage_y3_4 = g_oogc006
       CASE g_oogc006 
       WHEN 1
             LET g_master.stage_y1_3 = g_oogc015-1
             LET g_master.stage_y2_3 = 12
             LET g_master.stage_y3_3 = 12
             LET g_master.stage_y1_2 = g_oogc015-1
             LET g_master.stage_y2_2 = 11
             LET g_master.stage_y3_2 = 11
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 10
             LET g_master.stage_y3_1 = 10
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 9
             LET g_master.stage_y3 = 9
       
       WHEN 2 
             LET g_master.stage_y1_3 = g_oogc015
             LET g_master.stage_y2_3 = 1
             LET g_master.stage_y3_3 = 1
             LET g_master.stage_y1_2 = g_oogc015-1
             LET g_master.stage_y2_2 = 12
             LET g_master.stage_y3_2 = 12
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 11
             LET g_master.stage_y3_1 = 11
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 10
             LET g_master.stage_y3 = 10
       WHEN 3 
             LET g_master.stage_y1_3 = g_oogc015
             LET g_master.stage_y2_3 = 2
             LET g_master.stage_y3_3 = 2
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = 1
             LET g_master.stage_y3_2 = 1
             LET g_master.stage_y1_1 = g_oogc015-1
             LET g_master.stage_y2_1 = 12
             LET g_master.stage_y3_1 = 12
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 11
             LET g_master.stage_y3 = 11
       WHEN 4
             LET g_master.stage_y1_3 = g_oogc015
             LET g_master.stage_y2_3 = 3
             LET g_master.stage_y3_3 = 3
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = 2
             LET g_master.stage_y3_2 = 2
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = 1
             LET g_master.stage_y3_1 = 1
             LET g_master.stage_y1 = g_oogc015-1
             LET g_master.stage_y2 = 12
             LET g_master.stage_y3 = 12
       OTHERWISE
             LET g_master.stage_y1_3 = g_oogc015
             LET g_master.stage_y2_3 = g_oogc006-1
             LET g_master.stage_y3_3 = g_oogc006-1
             LET g_master.stage_y1_2 = g_oogc015
             LET g_master.stage_y2_2 = g_oogc006-2
             LET g_master.stage_y3_2 = g_oogc006-2
             LET g_master.stage_y1_1 = g_oogc015
             LET g_master.stage_y2_1 = g_oogc006-3
             LET g_master.stage_y3_1 = g_oogc006-3
             LET g_master.stage_y1 = g_oogc015
             LET g_master.stage_y2 = g_oogc006-4
             LET g_master.stage_y3 = g_oogc006-4
       END CASE
 END CASE
END FUNCTION

################################################################################
# Descriptions...:
################################################################################
PRIVATE FUNCTION acrr828_set_visible()
   CALL cl_set_comp_visible("stage_y1,stage_y2,stage_y3",TRUE)
   CALL cl_set_comp_visible("stage_y1_1,stage_y2_1,stage_y3_1",TRUE)
   CALL cl_set_comp_visible("stage_y1_2,stage_y2_2,stage_y3_2",TRUE)
   CALL cl_set_comp_visible("stage_y1_3,stage_y2_3,stage_y3_3",TRUE)
   CALL cl_set_comp_visible("stage_y1_4,stage_y2_4,stage_y3_4",TRUE)
END FUNCTION

#end add-point
 
{</section>}
 
