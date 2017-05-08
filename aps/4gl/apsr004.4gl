#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr004.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-08-21 17:05:55), PR版次:0003(2016-04-27 10:00:56)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000072
#+ Filename...: apsr004
#+ Description: APS延遲訂單表
#+ Creator....: 05231(2014-07-18 11:45:54)
#+ Modifier...: 05384 -SD/PR- 07673
 
{</section>}
 
{<section id="apsr004.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#160414-00017#1  2016/04/20  By dorislai  背景執行段的程式段多加QBE條件、APS版本、延期天數
#160318-00025#51 2016/04/27  By 07673     將重複內容的錯誤訊息置換為公用錯誤訊息
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
       psoq004 LIKE psoq_t.psoq004, 
   psoq009 LIKE psoq_t.psoq009, 
   xmda002 LIKE xmda_t.xmda002, 
   psoq043 LIKE psoq_t.psoq043, 
   psoq007 LIKE psoq_t.psoq007, 
   psca001 LIKE type_t.chr500, 
   psca001_desc LIKE type_t.chr80, 
   date01 LIKE type_t.chr500, 
   date02 LIKE type_t.chr500,
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
 
{<section id="apsr004.main" >}
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
   CALL cl_ap_init("aps","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      #160414-00017#1-add-(S)
      LET g_master.wc = g_argv[02]
      LET g_master.psca001 = g_argv[03]
      LET g_master.date01 = g_argv[04]
      LET g_master.date02 = g_argv[05]
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
      #160414-00017#1-add-(E)
      #end add-point
      CALL apsr004_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsr004 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsr004_init()
 
      #進入選單 Menu (="N")
      CALL apsr004_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsr004
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsr004.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsr004_init()
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
   LET g_master.date01 = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsr004.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr004_ui_dialog()
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
         INPUT BY NAME g_master.psca001,g_master.date01,g_master.date02 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psca001
            
            #add-point:AFTER FIELD psca001 name="input.a.psca001"
            IF NOT cl_null(g_master.psca001) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.psca001
               LET g_errshow = TRUE   #160318-00025#51
               LET g_chkparam.err_str[1] = "aps-00074:sub-01302|apsi002|",cl_get_progname("apsi002",g_lang,"2"),"|:EXEPROGapsi002"    #160318-00025#51
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_psca001") THEN
                  CALL apsr004_desc(g_master.psca001) RETURNING g_master.psca001_desc
                  DISPLAY BY NAME g_master.psca001_desc
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.psca001_desc = ''
                  DISPLAY BY NAME g_master.psca001_desc
                  NEXT FIELD CURRENT
               END IF
            

            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psca001
            #add-point:BEFORE FIELD psca001 name="input.b.psca001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psca001
            #add-point:ON CHANGE psca001 name="input.g.psca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date01
            #add-point:BEFORE FIELD date01 name="input.b.date01"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date01
            
            #add-point:AFTER FIELD date01 name="input.a.date01"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date01
            #add-point:ON CHANGE date01 name="input.g.date01"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date02
            #add-point:BEFORE FIELD date02 name="input.b.date02"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date02
            
            #add-point:AFTER FIELD date02 name="input.a.date02"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date02
            #add-point:ON CHANGE date02 name="input.g.date02"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.psca001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psca001
            #add-point:ON ACTION controlp INFIELD psca001 name="input.c.psca001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            CALL q_psca001()
            LET g_master.psca001 = g_qryparam.return1
            CALL apsr004_desc(g_master.psca001) RETURNING g_master.psca001_desc
            DISPLAY BY NAME g_master.psca001_desc
            DISPLAY g_master.psca001  TO psca001
            NEXT FIELD psca001
            #END add-point
 
 
         #Ctrlp:input.c.date01
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date01
            #add-point:ON ACTION controlp INFIELD date01 name="input.c.date01"
            
            #END add-point
 
 
         #Ctrlp:input.c.date02
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date02
            #add-point:ON ACTION controlp INFIELD date02 name="input.c.date02"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON psoq004,psoq009,xmda002,psoq043,psoq007
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.psoq004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psoq004
            #add-point:ON ACTION controlp INFIELD psoq004 name="construct.c.psoq004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psoq004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psoq004  #顯示到畫面上
            NEXT FIELD psoq004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psoq004
            #add-point:BEFORE FIELD psoq004 name="construct.b.psoq004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psoq004
            
            #add-point:AFTER FIELD psoq004 name="construct.a.psoq004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psoq009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psoq009
            #add-point:ON ACTION controlp INFIELD psoq009 name="construct.c.psoq009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psoq009()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO psoq009  #顯示到畫面上
            NEXT FIELD psoq009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psoq009
            #add-point:BEFORE FIELD psoq009 name="construct.b.psoq009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psoq009
            
            #add-point:AFTER FIELD psoq009 name="construct.a.psoq009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmda002
            #add-point:ON ACTION controlp INFIELD xmda002 name="construct.c.xmda002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmda002  #顯示到畫面上
            NEXT FIELD xmda002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmda002
            #add-point:BEFORE FIELD xmda002 name="construct.b.xmda002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmda002
            
            #add-point:AFTER FIELD xmda002 name="construct.a.xmda002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psoq043
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psoq043
            #add-point:ON ACTION controlp INFIELD psoq043 name="construct.c.psoq043"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psoq043  #顯示到畫面上
            NEXT FIELD psoq043                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psoq043
            #add-point:BEFORE FIELD psoq043 name="construct.b.psoq043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psoq043
            
            #add-point:AFTER FIELD psoq043 name="construct.a.psoq043"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psoq007
            #add-point:BEFORE FIELD psoq007 name="construct.b.psoq007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psoq007
            
            #add-point:AFTER FIELD psoq007 name="construct.a.psoq007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psoq007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psoq007
            #add-point:ON ACTION controlp INFIELD psoq007 name="construct.c.psoq007"
            
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
            CALL apsr004_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL apsr004_get_buffer(l_dialog)
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
         CALL apsr004_init()
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
                 CALL apsr004_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsr004_transfer_argv(ls_js)
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
 
{<section id="apsr004.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsr004_transfer_argv(ls_js)
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
 
{<section id="apsr004.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsr004_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"psoq004,psoq009,xmda002,psoq043,psoq007")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1 "
   END IF
   LET g_master.wc = g_master.wc CLIPPED ,"  AND pscaent = ",g_enterprise," AND pscasite = '",g_site,"' "
   IF NOT cl_null(g_master.psca001) THEN
      LET g_master.wc = g_master.wc CLIPPED ," AND psca001='",g_master.psca001,"'   "
   END IF
   IF NOT cl_null(g_master.date01)  THEN
      IF NOT cl_null(g_master.date02)  THEN
         IF g_master.date01 <=g_master.date02 THEN
            LET g_master.wc = g_master.wc CLIPPED ," AND FLOOR(c.psoq024-c.psoq007) BETWEEN ",g_master.date01," AND ",g_master.date02,"  "
         ELSE
            LET g_master.wc = g_master.wc CLIPPED ," AND FLOOR(c.psoq024-c.psoq007) BETWEEN ",g_master.date02," AND ",g_master.date01,"  "
         END IF
      ELSE
         LET g_master.wc = g_master.wc CLIPPED ," AND FLOOR(c.psoq024-c.psoq007) >= ",g_master.date01," "
      END IF
   ELSE
      IF NOT cl_null(g_master.date02)  THEN
         LET g_master.wc = g_master.wc CLIPPED ," AND FLOOR(c.psoq024-c.psoq007) <= ",g_master.date02," "
      END IF
   END IF   
   CALL apsr004_x01(g_master.wc)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsr004_process_cs CURSOR FROM ls_sql
#  FOREACH apsr004_process_cs INTO
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
 
{<section id="apsr004.get_buffer" >}
PRIVATE FUNCTION apsr004_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.psca001 = p_dialog.getFieldBuffer('psca001')
   LET g_master.date01 = p_dialog.getFieldBuffer('date01')
   LET g_master.date02 = p_dialog.getFieldBuffer('date02')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsr004.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION apsr004_desc(p_aps)
   DEFINE p_aps  LIKE psca_t.psca001
   DEFINE r_desc LIKE type_t.chr80
   
   SELECT pscal003 INTO r_desc
     FROM pscal_t
    WHERE pscalent = g_enterprise
      AND pscalsite = g_site
      AND pscal001 = p_aps
      AND pscal002 = g_dlang
   RETURN r_desc
END FUNCTION

#end add-point
 
{</section>}
 