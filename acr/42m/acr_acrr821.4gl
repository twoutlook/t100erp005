#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr821.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-07-12 17:27:28), PR版次:0002(2016-10-27 17:40:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000017
#+ Filename...: acrr821
#+ Description: 會員ABC品類消費統計報表
#+ Creator....: 03247(2016-05-06 15:05:53)
#+ Modifier...: 08172 -SD/PR- 02481
 
{</section>}
 
{<section id="acrr821.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#6     2016/10/25  By 02481  组织开窗aooi500规范调整
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
   decasite LIKE type_t.chr10, 
   rtax004 LIKE type_t.num5, 
   rtax001 LIKE type_t.chr10, 
   oocq002_1 LIKE type_t.chr10, 
   oocq002_2 LIKE type_t.chr10, 
   deca002 LIKE type_t.dat, 
   deca002_1 LIKE type_t.dat, 
   sel LIKE type_t.chr1, 
   year LIKE type_t.num5, 
   month LIKE type_t.num5,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
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
DEFINE g_type           LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrr821.main" >}
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
   LET g_type = g_argv[1]
   IF g_type = '1' THEN
      LET g_prog = "acrr821"
   END IF
   IF g_type = '2' THEN
      LET g_prog = "acrr822"
   END IF
   IF g_type = '3' THEN
      LET g_prog = "acrr823"
   END IF
   LET l_success = ''                                     #161024-00025#6--ADD
   CALL s_aooi500_create_temp() RETURNING l_success       #161024-00025#6--ADD
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrr821_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr821 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr821_init()
 
      #進入選單 Menu (="N")
      CALL acrr821_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr821
   END IF
 
   #add-point:作業離開前 name="main.exit"
  LET l_success = ''
  CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr821.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr821_init()
   #add-point:init段define name="init.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_flag               LIKE type_t.chr1  
   DEFINE l_errno              LIKE type_t.chr100
   DEFINE l_oogc015            LIKE oogc_t.oogc015
   DEFINE l_oogc007            LIKE oogc_t.oogc007
   DEFINE l_sdate_s            LIKE oogc_t.oogc003
   DEFINE l_sdate_e            LIKE oogc_t.oogc003
   DEFINE l_oogc006            LIKE oogc_t.oogc006
   DEFINE l_pdate_s            LIKE oogc_t.oogc003
   DEFINE l_pdate_e            LIKE oogc_t.oogc003
   DEFINE l_oogc008            LIKE oogc_t.oogc008
   DEFINE l_wdate_s            LIKE oogc_t.oogc003
   DEFINE l_wdate_e            LIKE oogc_t.oogc003
   DEFINE l_oogc001            LIKE oogc_t.oogc001
   DEFINE l_oogc002            LIKE oogc_t.oogc002
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
   IF g_type = '1' THEN
      CALL cl_set_comp_visible("oocq002_1,oocq002_2",FALSE)
   END IF
   IF g_type = '2' THEN
      CALL cl_set_comp_visible("rtax001,rtax004,oocq002_2",FALSE)
   END IF
   IF g_type = '3' THEN
      CALL cl_set_comp_visible("rtax001,,rtax004,oocq002_1",FALSE)
   END IF
   CALL cl_set_combo_scc("rtax004","6902")
   CALL cl_set_combo_scc("sel","6895")
  #CALL s_aooi500_create_temp() RETURNING l_success  ##161024-00025#6--MARK
   
   LET g_master.rtax004 = '0'
   LET g_master.sel = '1'
   #预设年度/期别
   #取当前日期的上一年度/期别
   LET l_oogc001 = ''
   LET l_oogc002 = ''
   LET l_oogc006 = ''
   LET l_oogc015 = ''
   SELECT ooef008,ooef010 INTO l_oogc001,l_oogc002
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_get_oogcdate(l_oogc001,l_oogc002,g_today,'','')
      RETURNING l_flag,l_errno,l_oogc015,l_oogc007,l_sdate_s,l_sdate_e,
                l_oogc006,l_pdate_s,l_pdate_e,l_oogc008,l_wdate_s,l_wdate_e
   IF l_oogc006 = 1 THEN
      LET g_master.year = l_oogc015-1
      LET g_master.month = 12
   ELSE
      LET g_master.year = l_oogc015
      LET g_master.month = l_oogc006-1
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr821.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr821_ui_dialog()
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
         INPUT BY NAME g_master.rtax004,g_master.sel,g_master.year,g_master.month 
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
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtab001,decasite,rtax001,oocq002_1,oocq002_2,deca002,deca002_1 
 
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
            
 
 
         #Ctrlp:construct.c.decasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD decasite
            #add-point:ON ACTION controlp INFIELD decasite name="construct.c.decasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO decasite  #顯示到畫面上
            NEXT FIELD decasite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD decasite
            #add-point:BEFORE FIELD decasite name="construct.b.decasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD decasite
            
            #add-point:AFTER FIELD decasite name="construct.a.decasite"
            
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
            
 
 
         #Ctrlp:construct.c.oocq002_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002_1
            #add-point:ON ACTION controlp INFIELD oocq002_1 name="construct.c.oocq002_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002_1  #顯示到畫面上
            NEXT FIELD oocq002_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002_1
            #add-point:BEFORE FIELD oocq002_1 name="construct.b.oocq002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002_1
            
            #add-point:AFTER FIELD oocq002_1 name="construct.a.oocq002_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq002_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002_2
            #add-point:ON ACTION controlp INFIELD oocq002_2 name="construct.c.oocq002_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2001'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002_2  #顯示到畫面上
            NEXT FIELD oocq002_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002_2
            #add-point:BEFORE FIELD oocq002_2 name="construct.b.oocq002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002_2
            
            #add-point:AFTER FIELD oocq002_2 name="construct.a.oocq002_2"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deca002
            #add-point:BEFORE FIELD deca002 name="construct.b.deca002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deca002
            
            #add-point:AFTER FIELD deca002 name="construct.a.deca002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deca002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deca002
            #add-point:ON ACTION controlp INFIELD deca002 name="construct.c.deca002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD deca002_1
            #add-point:BEFORE FIELD deca002_1 name="construct.b.deca002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD deca002_1
            
            #add-point:AFTER FIELD deca002_1 name="construct.a.deca002_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.deca002_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD deca002_1
            #add-point:ON ACTION controlp INFIELD deca002_1 name="construct.c.deca002_1"
            
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
            CALL acrr821_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr821_get_buffer(l_dialog)
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
         CALL acrr821_init()
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
                 CALL acrr821_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr821_transfer_argv(ls_js)
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
 
{<section id="acrr821.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr821_transfer_argv(ls_js)
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
 
{<section id="acrr821.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr821_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"rtab001,decasite,rtax001,oocq002_1,oocq002_2,deca002,deca002_1")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = "1=1"
   END IF
   LET g_master.wc = cl_replace_str(g_master.wc,"rtax001","deca016")
   LET g_master.wc = cl_replace_str(g_master.wc,"oocq002_1","deca013")
   LET g_master.wc = cl_replace_str(g_master.wc,"oocq002_2","oocq002")
   LET g_master.wc = cl_replace_str(g_master.wc,"deca002","deca002 >")
   IF cl_null(g_master.deca002_1) THEN
      LET g_master.wc = cl_replace_str(g_master.wc,"deca002_1","deca002 <")
   ELSE
      LET g_master.wc = cl_replace_str(g_master.wc,"deca002 >_1","deca002 <")
   END IF 
   LET g_master.wc = g_master.wc," AND decaent='",g_enterprise,"'"   
   IF g_type = '1' THEN
      CALL acrr821_x01(g_master.wc,g_master.rtax004,g_master.sel,g_master.year,g_master.month)
   END IF
   IF g_type = '2' THEN
      CALL acrr821_x02(g_master.wc,g_master.rtax004,g_master.sel,g_master.year,g_master.month)
   END IF
   IF g_type = '3' THEN
      CALL acrr821_x03(g_master.wc,g_master.rtax004,g_master.sel,g_master.year,g_master.month)
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr821_process_cs CURSOR FROM ls_sql
#  FOREACH acrr821_process_cs INTO
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
 
{<section id="acrr821.get_buffer" >}
PRIVATE FUNCTION acrr821_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.rtax004 = p_dialog.getFieldBuffer('rtax004')
   LET g_master.sel = p_dialog.getFieldBuffer('sel')
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   DISPLAY g_today TO deca002
   DISPLAY g_today TO deca002_1
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr821.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
