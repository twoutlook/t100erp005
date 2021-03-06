#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr705.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2016-11-15 13:35:57), PR版次:0004(2017-01-23 11:08:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: ainr705
#+ Description: 配送揀貨單列印
#+ Creator....: 06932(2016-10-28 15:43:12)
#+ Modifier...: 06814 -SD/PR- 06137
 
{</section>}
 
{<section id="ainr705.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161017-00051#11 20161206 by 06137 1.特征超过10列，分页打印,2.ainr705配送分货单打印，目前是会按特征群组拆行列title，不可以按此拆title分行
#170119-00027#2  20170123 by 06137 打印优化：点打印按钮调r作业界面，点打印或者快速打印，进去预览画面，关闭预览画面时，须同步关闭报表元件选择界面和R作业的前端界面
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
       indidocno LIKE indi_t.indidocno, 
   indidocdt LIKE indi_t.indidocdt, 
   inditype LIKE type_t.chr500, 
   indj020 LIKE indj_t.indj020, 
   indireptype LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_indidocno     STRING #20161116
DEFINE g_indj020       STRING #20161116
DEFINE g_print_f       LIKE type_t.chr1   #Add By Ken 161116  程式一開啟才需接收參數變數
DEFINE g_prog_in       LIKE type_t.chr10  #170119-00027#2 Add By Ken 170123   判斷是否從aint705,ainp705開啟
DEFINE g_close         LIKE type_t.chr1   #170119-00027#2 Add By Ken 170123   判斷是否直接關閉R類作業
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainr705.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainr705_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainr705 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainr705_init()
 
      #進入選單 Menu (="N")
      CALL ainr705_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainr705
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainr705.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainr705_init()
   #add-point:init段define name="init.define"
   DEFINE l_session_id    LIKE type_t.num20   #161109-00078#4 20161115 add by beckxie
   
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
   #161109-00078#4 20161115 add by beckxie---S
   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "------------------------------"
   DISPLAY "SessionId: ",l_session_id
   DISPLAY "------------------------------"
   #161109-00078#4 20161115 add by beckxie---E
   
   #str--add by yany 2016/11/01
   #20161116 ---S
   IF NOT cl_null(g_argv[01]) THEN
      LET g_indidocno = g_argv[01]
   END IF
   #20161116 ---E
   LET g_master.indidocno = g_argv[01]
   LET g_master.indidocdt = g_argv[02]
   IF NOT cl_null(g_argv[03]) THEN
      IF g_argv[03] = '1' OR g_argv[03] = '2' THEN
         LET g_master.inditype = '1' 
      ELSE
         LET g_master.inditype = '2' 
      END IF
      CALL cl_set_comp_entry("inditype",FALSE)
   ELSE
      LET g_master.inditype = '1' 
      CALL cl_set_comp_entry("inditype",TRUE)
   END IF
   LET g_master.indj020 = g_argv[04]   #161109-00078#4 20161114 add by beckxie
   
   #20161116 ---S
   IF NOT cl_null(g_argv[04]) THEN
      LET g_indj020 = g_argv[04]
   END IF
   
   IF NOT cl_null(g_argv[05]) THEN
      LET g_master.indireptype = g_argv[05]
   ELSE
   #20161116 ---E
#   LET g_master.inditype = '1'    #初始化对象类型 add by yany 2016/10/28
      LET g_master.indireptype = '1' #初始化报表类型 add by yany 2016/10/29
   END IF   #20161116 
   CALL cl_set_comp_entry("indireptype",TRUE)
   #end--add by yany 2016/11/01
   LET g_print_f = 'Y'     #Add By Ken 161116
   LET g_prog_in = g_argv[06]   #170119-00027#2 Add By Ken 170123   判斷是否從aint705,ainp705開啟
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainr705.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr705_ui_dialog()
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
         INPUT BY NAME g_master.inditype,g_master.indireptype 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inditype
            #add-point:BEFORE FIELD inditype name="input.b.inditype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inditype
            
            #add-point:AFTER FIELD inditype name="input.a.inditype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inditype
            #add-point:ON CHANGE inditype name="input.g.inditype"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indireptype
            #add-point:BEFORE FIELD indireptype name="input.b.indireptype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indireptype
            
            #add-point:AFTER FIELD indireptype name="input.a.indireptype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE indireptype
            #add-point:ON CHANGE indireptype name="input.g.indireptype"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.inditype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inditype
            #add-point:ON ACTION controlp INFIELD inditype name="input.c.inditype"
            
            #END add-point
 
 
         #Ctrlp:input.c.indireptype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indireptype
            #add-point:ON ACTION controlp INFIELD indireptype name="input.c.indireptype"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON indidocno,indidocdt,indj020
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               IF g_print_f = 'Y' THEN     #Add By Ken 161116
                  #str--add by yany 2016/11/02
                  IF NOT cl_null(g_argv[01]) THEN
                     #DISPLAY g_master.indidocno TO indidocno    #20161116
                     DISPLAY g_indidocno TO indidocno
                  END IF
                  IF NOT cl_null(g_argv[02]) THEN
                     DISPLAY g_master.indidocdt TO indidocdt
                  END IF
                  IF NOT cl_null(g_argv[03]) THEN
                     DISPLAY g_master.inditype TO inditype
                     CALL cl_set_comp_entry("inditype",FALSE)
                  END IF
                  #end--add by yany 2016/11/02
                  #161109-00078#4 20161114 add by beckxie---S
                  IF NOT cl_null(g_argv[04]) THEN
                     #DISPLAY g_master.indj020 TO indj020   #20161116
                     DISPLAY g_indj020 TO indj020   #20161116
                  END IF
                  #161109-00078#4 20161114 add by beckxie---E
                  LET g_print_f = 'N'      #Add By Ken 161116
               END IF                      #Add By Ken 161116
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.indidocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indidocno
            #add-point:ON ACTION controlp INFIELD indidocno name="construct.c.indidocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
          # CALL q_indidocno()                           #呼叫開窗
            CALL q_indidocno_1()   #mod by yany 2016/10/28
            DISPLAY g_qryparam.return1 TO indidocno  #顯示到畫面上
            NEXT FIELD indidocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indidocno
            #add-point:BEFORE FIELD indidocno name="construct.b.indidocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indidocno
            
            #add-point:AFTER FIELD indidocno name="construct.a.indidocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indidocdt
            #add-point:BEFORE FIELD indidocdt name="construct.b.indidocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indidocdt
            
            #add-point:AFTER FIELD indidocdt name="construct.a.indidocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indidocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indidocdt
            #add-point:ON ACTION controlp INFIELD indidocdt name="construct.c.indidocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD indj020
            #add-point:BEFORE FIELD indj020 name="construct.b.indj020"
            #161109-00078#4 20161114 add by beckxie---S
            IF g_master.indireptype != '2' THEN
               #現貨才允許查indj020
               LET g_master.indj020 = ''
               DISPLAY g_master.indj020 TO indj020
               NEXT FIELD indidocno
            END IF
            #161109-00078#4 20161114 add by beckxie---E
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD indj020
            
            #add-point:AFTER FIELD indj020 name="construct.a.indj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.indj020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD indj020
            #add-point:ON ACTION controlp INFIELD indj020 name="construct.c.indj020"
            #161109-00078#4 20161114 add by beckxie---S
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indj020()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj020      #顯示到畫面上
            NEXT FIELD indj020                         #返回原欄位
            #161109-00078#4 20161114 add by beckxie---E
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
            CALL ainr705_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL ainr705_get_buffer(l_dialog)
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
            LET g_master.inditype = '1'
            LET g_master.indireptype = '1'
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
         CALL ainr705_init()
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
                 CALL ainr705_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainr705_transfer_argv(ls_js)
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
 
{<section id="ainr705.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainr705_transfer_argv(ls_js)
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
 
{<section id="ainr705.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainr705_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"indidocno,indidocdt,indj020")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #170119-00027#3 Add By Ken 170123(S)   如參數6是aint705或ainp705時 將列印變數改成快速列印
   IF g_prog_in = 'aint705' OR g_prog_in = 'ainp705' THEN
      LET g_action_choice = "quickprint"
   END IF
   DISPLAY "g_action_choice:",g_action_choice
   #170119-00027#3 Add By Ken 170123(E)
   #str--add by yany 2016/10/28
   IF cl_null(g_master.wc) THEN      
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET  g_master.wc = l_arg[01]  
   ELSE       
   
      CASE g_master.inditype
         #门店
         WHEN '1'
             LET g_master.wc = g_master.wc CLIPPED," AND indi007 in ('1','2') "
         #客户
         WHEN '2'
             LET g_master.wc = g_master.wc CLIPPED," AND indi007 = '3' "
      END CASE
   END IF  
    
   LET g_master.wc = g_master.wc CLIPPED," AND indient =",g_enterprise,
                                         " AND indisite='",g_site,"'",
                                         " AND indistus = 'Y' "

   IF g_master.indireptype = '1' THEN
      #CALL ainr705_g01(g_master.wc,g_master.inditype)  #161017-00051#11 Mark By Ken 161206
      CALL ainr705_g03(g_master.wc,g_master.inditype)   #161017-00051#11 Add By Ken 161206 
   ELSE
      #CALL ainr705_g02(g_master.wc,g_master.inditype)  #161017-00051#11 Mark By Ken 161206
      CALL ainr705_g04(g_master.wc,g_master.inditype)   #161017-00051#11 Add By Ken 161206 
   END IF
   #end--add by yany 2016/10/28
   #170119-00027#3 Add By Ken 170123(S)    判斷報表元件中的是否有資料要列印，如有資料要印才會印出預覽並關閉ainr705作業
   DISPLAY "g_prog_in:",g_prog_in
   LET g_close = 'N'
   IF (g_prog_in = 'aint705' OR g_prog_in = 'ainp705') THEN
      LET l_cnt = 0 
      SELECT COUNT(1) INTO l_cnt
        FROM ainr705_print_tmp
      DISPLAY "l_cnt:",l_cnt
      IF l_cnt != 0 THEN
         LET g_close = 'Y'
      END IF
   END IF
   #170119-00027#3 Add By Ken 170123(E)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ainr705_process_cs CURSOR FROM ls_sql
#  FOREACH ainr705_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF (g_prog_in = 'aint705' OR g_prog_in = 'ainp705') AND g_close = 'Y' THEN
         CLOSE WINDOW w_ainr705
      END IF
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="ainr705.get_buffer" >}
PRIVATE FUNCTION ainr705_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.inditype = p_dialog.getFieldBuffer('inditype')
   LET g_master.indireptype = p_dialog.getFieldBuffer('indireptype')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr705.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
