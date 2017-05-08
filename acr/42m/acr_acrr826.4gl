#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr826.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-05 18:04:54), PR版次:0001(2016-05-05 17:34:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: acrr826
#+ Description: 會員ABC一週消費習慣統計報表
#+ Creator....: 02003(2016-02-16 17:44:03)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="acrr826.global" >}
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
        sel       LIKE type_t.chr1, 
        crde002   LIKE crde_t.crde002,
        crde003   LIKE crde_t.crde003,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtab001 LIKE rtab_t.rtab001, 
   decbsite LIKE decb_t.decbsite, 
   crde002 LIKE crde_t.crde002, 
   decb003 LIKE decb_t.decb003, 
   sel LIKE type_t.chr500, 
   crde002_2 LIKE type_t.num5, 
   crde003_2 LIKE type_t.num5,
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
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrr826.main" >}
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
   LET g_argv[1] = cl_replace_str(g_argv[1], '\"', '') 
   LET g_argv[2] = cl_replace_str(g_argv[2], '\"', '') 
   LET g_argv[3] = cl_replace_str(g_argv[3], '\"', '') 
   LET g_argv[4] = cl_replace_str(g_argv[4], '\"', '') 
   LET lc_param.wc = g_argv[1]
   LET lc_param.sel = g_argv[2]
   LET lc_param.crde002 = g_argv[3]
   LET lc_param.crde003 = g_argv[4]
   LET ls_js = util.JSON.stringify(lc_param)
   IF NOT cl_null(lc_param.wc) THEN
      LET g_bgjob = "Y"
   ELSE
      LET g_bgjob = "N"
   END IF
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrr826_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrr826 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrr826_init()
 
      #進入選單 Menu (="N")
      CALL acrr826_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      CALL s_aooi500_drop_temp() RETURNING l_success
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrr826
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrr826.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrr826_init()
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
   CALL cl_set_combo_scc('sel','6895')
   LET g_master.sel = 1
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrr826.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr826_ui_dialog()
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
         INPUT BY NAME g_master.crde002,g_master.decb003,g_master.sel,g_master.crde002_2,g_master.crde003_2  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crde002
            #add-point:BEFORE FIELD crde002 name="input.b.crde002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crde002
            
            #add-point:AFTER FIELD crde002 name="input.a.crde002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crde002
            #add-point:ON CHANGE crde002 name="input.g.crde002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD decb003
            #add-point:BEFORE FIELD decb003 name="input.b.decb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD decb003
            
            #add-point:AFTER FIELD decb003 name="input.a.decb003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE decb003
            #add-point:ON CHANGE decb003 name="input.g.decb003"
            
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
         BEFORE FIELD crde002_2
            #add-point:BEFORE FIELD crde002_2 name="input.b.crde002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crde002_2
            
            #add-point:AFTER FIELD crde002_2 name="input.a.crde002_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crde002_2
            #add-point:ON CHANGE crde002_2 name="input.g.crde002_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crde003_2
            #add-point:BEFORE FIELD crde003_2 name="input.b.crde003_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crde003_2
            
            #add-point:AFTER FIELD crde003_2 name="input.a.crde003_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE crde003_2
            #add-point:ON CHANGE crde003_2 name="input.g.crde003_2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.crde002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crde002
            #add-point:ON ACTION controlp INFIELD crde002 name="input.c.crde002"
            
            #END add-point
 
 
         #Ctrlp:input.c.decb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD decb003
            #add-point:ON ACTION controlp INFIELD decb003 name="input.c.decb003"
            
            #END add-point
 
 
         #Ctrlp:input.c.sel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sel
            #add-point:ON ACTION controlp INFIELD sel name="input.c.sel"
            
            #END add-point
 
 
         #Ctrlp:input.c.crde002_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crde002_2
            #add-point:ON ACTION controlp INFIELD crde002_2 name="input.c.crde002_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.crde003_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crde003_2
            #add-point:ON ACTION controlp INFIELD crde003_2 name="input.c.crde003_2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtab001,decbsite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtab001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtab001
            #add-point:ON ACTION controlp INFIELD rtab001 name="construct.c.rtab001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtaastus = 'Y' AND EXISTS(SELECT 1 FROM rtak_t WHERE rtakent = rtaaent AND rtak001 = rtaa001 ",
                                   "                              AND rtak002 = '1' AND rtak003 = 'Y')"
            CALL q_rtaa001()                           #呼叫開窗
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
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decbsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            
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
            CALL acrr826_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL acrr826_get_buffer(l_dialog)
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
         CALL acrr826_init()
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
      
      LET lc_param.wc = g_master.wc
      LET lc_param.sel = g_master.sel
      LET lc_param.crde002 = g_master.crde002_2
      LET lc_param.crde003 = g_master.crde003_2
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
                 CALL acrr826_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrr826_transfer_argv(ls_js)
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
 
{<section id="acrr826.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrr826_transfer_argv(ls_js)
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
 
{<section id="acrr826.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrr826_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"rtab001,decbsite")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   CALL acrr826_g01(g_master.wc,g_master.sel,g_master.crde002_2,g_master.crde003_2,g_master.crde002,g_master.decb003)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrr826_process_cs CURSOR FROM ls_sql
#  FOREACH acrr826_process_cs INTO
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
 
{<section id="acrr826.get_buffer" >}
PRIVATE FUNCTION acrr826_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.crde002 = p_dialog.getFieldBuffer('crde002')
   LET g_master.decb003 = p_dialog.getFieldBuffer('decb003')
   LET g_master.sel = p_dialog.getFieldBuffer('sel')
   LET g_master.crde002_2 = p_dialog.getFieldBuffer('crde002_2')
   LET g_master.crde003_2 = p_dialog.getFieldBuffer('crde003_2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   #预设年度/周别
   IF cl_null(g_master.crde002) OR cl_null(g_master.decb003) THEN
      SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL s_get_oogcdate(l_ooef008,l_ooef010,g_today,'','')
         RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,
                   r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
      #取当前日期的上一年度/周别
      LET r_oogc008 = r_oogc008 - 1
      IF r_oogc008 = 0 THEN
         LET r_oogc015 = r_oogc015 - 1
         #抓取上一年度最大日期的周别
         SELECT oogc008 INTO r_oogc008
           FROM oogc_t
          WHERE oogcent = g_enterprise
            AND oogc001 = l_ooef008
            AND oogc002 = l_ooef010
            AND oogc015 = r_oogc015
            AND oogc003 = (SELECT MAX(oogc003) FROM oogc_t WHERE oogcent = g_enterprise
                              AND oogc001 = l_ooef008 AND oogc002 = l_ooef010 AND oogc015 = r_oogc015)
      END IF
      LET g_master.crde002 = r_oogc015
      LET g_master.decb003 = r_oogc008
   END IF
   #预设年度/期别
   IF cl_null(g_master.crde002_2) OR cl_null(g_master.crde003_2) THEN
      #取当前日期的上一年度/期别
      SELECT ooef008,ooef010 INTO l_ooef008,l_ooef010
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL s_get_oogcdate(l_ooef008,l_ooef010,g_today,'','')
         RETURNING r_flag,r_errno,r_oogc015,r_oogc007,r_sdate_s,r_sdate_e,
                   r_oogc006,r_pdate_s,r_pdate_e,r_oogc008,r_wdate_s,r_wdate_e
      LET r_oogc006 = r_oogc006 - 1
      IF r_oogc006 = 0 THEN
         LET r_oogc015 = r_oogc015 - 1
         LET r_oogc006 = 12   
      END IF
      LET g_master.crde002_2 = r_oogc015
      LET g_master.crde003_2 = r_oogc006
   END IF
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrr826.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 