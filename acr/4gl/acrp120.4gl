#該程式未解開Section, 採用最新樣板產出!
{<section id="acrp120.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-07-30 17:20:40), PR版次:0001(2016-05-05 19:38:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: acrp120
#+ Description: 會員ABC分類評估作業
#+ Creator....: 01251(2014-07-28 10:18:35)
#+ Modifier...: 01251 -SD/PR- 06815
 
{</section>}
 
{<section id="acrp120.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
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
       crde001 LIKE crde_t.crde001, 
   check1 LIKE type_t.chr1, 
   period LIKE type_t.num5, 
   year LIKE type_t.num5, 
   month LIKE type_t.num5, 
   check2 LIKE type_t.chr1, 
   percent1 LIKE type_t.num5, 
   percent2 LIKE type_t.num5, 
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
 
{<section id="acrp120.main" >}
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
   CALL cl_ap_init("acr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrp120_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrp120 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrp120_init()
 
      #進入選單 Menu (="N")
      CALL acrp120_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrp120
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrp120.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrp120_init()
 
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
   CALL cl_set_combo_scc('check1','6065')
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="acrp120.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrp120_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_year    LIKE type_t.num5
   DEFINE l_month   LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL    #140212-00001#29 add by yangxf 20160324
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.check1,g_master.period,g_master.year,g_master.month,g_master.check2, 
             g_master.percent1,g_master.percent2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check1
            #add-point:BEFORE FIELD check1 name="input.b.check1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check1
            
            #add-point:AFTER FIELD check1 name="input.a.check1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check1
            #add-point:ON CHANGE check1 name="input.g.check1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD period
            #add-point:BEFORE FIELD period name="input.b.period"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD period
            
            #add-point:AFTER FIELD period name="input.a.period"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE period
            #add-point:ON CHANGE period name="input.g.period"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year
            #add-point:BEFORE FIELD year name="input.b.year"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year
            
            #add-point:AFTER FIELD year name="input.a.year"
            IF NOT cl_null(g_master.year) THEN
               IF g_master.year>YEAR(TODAY) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00046'
                  LET g_errparam.extend = g_master.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD year
               END IF
            END IF     
            IF NOT cl_null(g_master.year) AND NOT cl_null(g_master.month) THEN
               IF g_master.year=YEAR(TODAY)  AND g_master.month>MONTH(TODAY) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00046'
                  LET g_errparam.extend = g_master.year
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD month
               END IF
            END IF 
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
              IF NOT cl_null(g_master.year) AND NOT cl_null(g_master.month) THEN
                 IF g_master.year=YEAR(TODAY)  AND g_master.month>MONTH(TODAY) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00046'
                    LET g_errparam.extend = g_master.year
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD month
                 END IF
              END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month
            #add-point:ON CHANGE month name="input.g.month"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check2
            #add-point:BEFORE FIELD check2 name="input.b.check2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check2
            
            #add-point:AFTER FIELD check2 name="input.a.check2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check2
            #add-point:ON CHANGE check2 name="input.g.check2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD percent1
            #add-point:BEFORE FIELD percent1 name="input.b.percent1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD percent1
            
            #add-point:AFTER FIELD percent1 name="input.a.percent1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE percent1
            #add-point:ON CHANGE percent1 name="input.g.percent1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD percent2
            #add-point:BEFORE FIELD percent2 name="input.b.percent2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD percent2
            
            #add-point:AFTER FIELD percent2 name="input.a.percent2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE percent2
            #add-point:ON CHANGE percent2 name="input.g.percent2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.check1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check1
            #add-point:ON ACTION controlp INFIELD check1 name="input.c.check1"
            
            #END add-point
 
 
         #Ctrlp:input.c.period
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD period
            #add-point:ON ACTION controlp INFIELD period name="input.c.period"
            
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
 
 
         #Ctrlp:input.c.check2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check2
            #add-point:ON ACTION controlp INFIELD check2 name="input.c.check2"
            
            #END add-point
 
 
         #Ctrlp:input.c.percent1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD percent1
            #add-point:ON ACTION controlp INFIELD percent1 name="input.c.percent1"
            
            #END add-point
 
 
         #Ctrlp:input.c.percent2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD percent2
            #add-point:ON ACTION controlp INFIELD percent2 name="input.c.percent2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON crde001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.crde001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD crde001
            #add-point:ON ACTION controlp INFIELD crde001 name="construct.c.crde001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO crde001  #顯示到畫面上
            NEXT FIELD crde001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD crde001
            #add-point:BEFORE FIELD crde001 name="construct.b.crde001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD crde001
            
            #add-point:AFTER FIELD crde001 name="construct.a.crde001"
            
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
            CALL acrp120_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            IF cl_null(g_master.check1) THEN
               SELECT ooaa002 INTO g_master.check1 FROM ooaa_t
                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0007'
            END IF
            IF cl_null(g_master.period) THEN
               SELECT ooaa002 INTO g_master.period FROM ooaa_t
                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0006'   
            END IF
            IF cl_null(g_master.percent1) THEN
               SELECT ooaa002 INTO g_master.percent1 FROM ooaa_t
                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0008'
            END IF
            IF cl_null(g_master.percent2) THEN
               SELECT ooaa002 INTO g_master.percent2 FROM ooaa_t
                WHERE ooaaent = g_enterprise AND ooaa001 = 'E-CIR-0009'   
            END IF            
            IF cl_null(g_master.year) OR g_master.year=0 THEN
               LET l_year=YEAR(TODAY)
               LET g_master.year=l_year
            END IF    
            IF cl_null(g_master.month) OR g_master.month=0 THEN
               LET l_month=MONTH(TODAY)-1
               LET g_master.month=l_month
            END IF    
            IF g_master.month<=0 THEN
               LET g_master.year=l_year-1
               LET g_master.month=l_month+12
            END IF    
            IF cl_null(g_master.check2) THEN     
               LET g_master.check2='Y'
            END IF               
            DISPLAY g_master.year     TO year
            DISPLAY g_master.month    TO month
            DISPLAY g_master.check1   TO check1 
            DISPLAY g_master.check2   TO check2             
            DISPLAY g_master.period   TO period  
            DISPLAY g_master.percent1 TO percent1
            DISPLAY g_master.percent2 TO percent2            
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
         CALL acrp120_init()
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
                 CALL acrp120_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrp120_transfer_argv(ls_js)
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
 
{<section id="acrp120.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrp120_transfer_argv(ls_js)
 
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
   LET la_cmdrun.param[1] = g_master.wc
   LET la_cmdrun.param[2] = g_master.check1
   LET la_cmdrun.param[3] = g_master.period
   LET la_cmdrun.param[4] = g_master.year
   LET la_cmdrun.param[5] = g_master.month
   LET la_cmdrun.param[6] = g_master.check2
   LET la_cmdrun.param[7] = g_master.percent1
   LET la_cmdrun.param[8] = g_master.percent2
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="acrp120.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrp120_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
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
      CALL cl_progress_bar_no_window(4)   #160225-00040#1 Add By s983961 160505
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrp120_process_cs CURSOR FROM ls_sql
#  FOREACH acrp120_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_acrp120_insert(g_master.wc,g_master.check1,g_master.period,g_master.year,g_master.month,g_master.check2,g_master.percent1,g_master.percent2) RETURNING l_success
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
   CALL acrp120_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="acrp120.get_buffer" >}
PRIVATE FUNCTION acrp120_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.check1 = p_dialog.getFieldBuffer('check1')
   LET g_master.period = p_dialog.getFieldBuffer('period')
   LET g_master.year = p_dialog.getFieldBuffer('year')
   LET g_master.month = p_dialog.getFieldBuffer('month')
   LET g_master.check2 = p_dialog.getFieldBuffer('check2')
   LET g_master.percent1 = p_dialog.getFieldBuffer('percent1')
   LET g_master.percent2 = p_dialog.getFieldBuffer('percent2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrp120.msgcentre_notify" >}
PRIVATE FUNCTION acrp120_msgcentre_notify()
 
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
 
{<section id="acrp120.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 批次產生資料的進度條顯示次數
# Memo...........:
# Usage..........: CALL acrp120_msg_show(p_cnt)
# Input parameter: p_cnt
# Date & Author..: 20160505 By s983961
# Modify.........:
################################################################################
PUBLIC FUNCTION acrp120_msg_show(p_cnt)
DEFINE p_cnt            LIKE type_t.num5
DEFINE l_min_cnt        LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_msg            STRING           

   LET l_min_cnt = 1
   IF p_cnt >1 THEN
     FOR l_i = l_min_cnt TO p_cnt
        LET l_msg = cl_getmsg('ast-00330',g_lang)
        CALL cl_progress_no_window_ing(l_msg)     
     END FOR
   END IF
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)    
END FUNCTION

#end add-point
 
{</section>}
 
