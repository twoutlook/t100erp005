#該程式未解開Section, 採用最新樣板產出!
{<section id="apsr350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-10-01 19:04:48), PR版次:0006(2016-09-30 11:37:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: apsr350
#+ Description: 採購預測列印
#+ Creator....: 05231(2014-07-31 14:53:44)
#+ Modifier...: 05384 -SD/PR- 07024
 
{</section>}
 
{<section id="apsr350.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160819-00015#2   2016/08/28  By  dorislai  1.多一參數，判斷多作業  2.apsr532時，呼叫apsr350_x02
#160819-00015#5   2016/09/30  By  dorislai  mark apsr350_g01，因憑證報表不易瀏覽
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
       psia003 LIKE psia_t.psia003, 
   psia004 LIKE psia_t.psia004, 
   psib006 LIKE psib_t.psib006, 
   psia001 LIKE type_t.chr500, 
   psia002 LIKE psia_t.psia002, 
   psia005 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_con STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apsr350.main" >}
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
      
      #end add-point
      CALL apsr350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsr350 WITH FORM cl_ap_formpath("aps",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apsr350_init()
 
      #進入選單 Menu (="N")
      CALL apsr350_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apsr350
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apsr350.init" >}
#+ 初始化作業
PRIVATE FUNCTION apsr350_init()
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
   LET g_master.psia002 = ''
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apsr350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apsr350_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_psia003 STRING
   DEFINE l_psia004 STRING
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
         INPUT BY NAME g_master.psia001,g_master.psia002,g_master.psia005 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psia001
            #add-point:BEFORE FIELD psia001 name="input.b.psia001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psia001
            
            #add-point:AFTER FIELD psia001 name="input.a.psia001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psia001
            #add-point:ON CHANGE psia001 name="input.g.psia001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psia002
            #add-point:BEFORE FIELD psia002 name="input.b.psia002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psia002
            
            #add-point:AFTER FIELD psia002 name="input.a.psia002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psia002
            #add-point:ON CHANGE psia002 name="input.g.psia002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psia005
            #add-point:BEFORE FIELD psia005 name="input.b.psia005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psia005
            
            #add-point:AFTER FIELD psia005 name="input.a.psia005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE psia005
            #add-point:ON CHANGE psia005 name="input.g.psia005"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.psia001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psia001
            #add-point:ON ACTION controlp INFIELD psia001 name="input.c.psia001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            CALL q_psja001()
            LET g_master.psia001 = g_qryparam.return1
            DISPLAY g_master.psia001  TO psia001
            NEXT FIELD psia001
            #END add-point
 
 
         #Ctrlp:input.c.psia002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psia002
            #add-point:ON ACTION controlp INFIELD psia002 name="input.c.psia002"
            
            #END add-point
 
 
         #Ctrlp:input.c.psia005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psia005
            #add-point:ON ACTION controlp INFIELD psia005 name="input.c.psia005"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON psia003,psia004,psib006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.psia003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psia003
            #add-point:ON ACTION controlp INFIELD psia003 name="construct.c.psia003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            LET g_master.psia003 = g_qryparam.return1
            DISPLAY g_master.psia003  TO psia003
            NEXT FIELD psia003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psia003
            #add-point:BEFORE FIELD psia003 name="construct.b.psia003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psia003
            
            #add-point:AFTER FIELD psia003 name="construct.a.psia003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psia004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psia004
            #add-point:ON ACTION controlp INFIELD psia004 name="construct.c.psia004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            LET g_master.psia004 = g_qryparam.return1
            DISPLAY g_master.psia004  TO psia004
            NEXT FIELD psia004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psia004
            #add-point:BEFORE FIELD psia004 name="construct.b.psia004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psia004
            
            #add-point:AFTER FIELD psia004 name="construct.a.psia004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.psib006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD psib006
            #add-point:ON ACTION controlp INFIELD psib006 name="construct.c.psib006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO psib006  #顯示到畫面上
            NEXT FIELD psib006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD psib006
            #add-point:BEFORE FIELD psib006 name="construct.b.psib006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD psib006
            
            #add-point:AFTER FIELD psib006 name="construct.a.psib006"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            AFTER CONSTRUCT
               LET l_psia003 = GET_FLDBUF(psia003)
               LET l_psia004 = GET_FLDBUF(psia004)

            
            CONSTRUCT g_con ON psia003,psia004
                 FROM psia003,psia004

               BEFORE CONSTRUCT
                  CALL cl_qbe_init()
                  DISPLAY l_psia003   TO psia003
                  DISPLAY l_psia004   TO psia004
                  EXIT CONSTRUCT
            END CONSTRUCT

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
            CALL apsr350_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL apsr350_get_buffer(l_dialog)
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
         CALL apsr350_init()
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
                 CALL apsr350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apsr350_transfer_argv(ls_js)
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
 
{<section id="apsr350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apsr350_transfer_argv(ls_js)
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
 
{<section id="apsr350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apsr350_process(ls_js)
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
   DEFINE l_sql       STRING
   DEFINE l_psia005   LIKE psia_t.psia005  
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"psia003,psia004,psib006")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #dorislai-20151106-modify----(S)
#   IF cl_null(g_master.wc) THEN
#      LET g_master.wc=" 1=1 "
#   END IF
#   IF cl_null(g_con) THEN
#      LET g_con = " 1=1 "
#   END IF
#   LET g_master.wc = g_master.wc CLIPPED ," AND psiaent = ",g_enterprise," AND psiasite = '",g_site,"' ",
#                   " AND psia001 = '",g_master.psia001,"' AND psia002 = '",g_master.psia002,"'"
#   IF cl_null(g_master.psia005) THEN
#       LET l_sql = "SELECT MAX(psia005) ",
#                   "  FROM psia_t",
#                   " WHERE ",g_con,
#                   "   AND psia001 = '",g_master.psia001,"'",
#                   "   AND psia002 = '",g_master.psia002,"'"
#       PREPARE repro_tbl FROM l_sql
#       EXECUTE repro_tbl INTO l_psia005
#       IF SQLCA.sqlcode THEN
#          LET l_psia005 = ''
#       END IF
#   ELSE
#      LET g_master.wc = g_master.wc CLIPPED ," AND psia005 = '",g_master.psia005,"'"
#   END IF
#   IF NOT cl_null(l_psia005) THEN
#      LET g_master.wc = g_master.wc CLIPPED ," AND psia005='",l_psia005,"' "
#   END IF
#   CALL apsr350_x01(g_master.wc)
   
   #160819-00015#2-s-add  #抓取最大版本
   IF cl_null(g_master.psia005) THEN
      LET l_sql = "SELECT TO_CHAR(MAX(TO_NUMBER(psia005))) ",
                  "  FROM psia_t",
                  " WHERE ",g_con,
                  "   AND psia001 = '",g_master.psia001,"'",
                  "   AND psia002 = '",g_master.psia002,"'"
      PREPARE repro_tbl FROM l_sql
      EXECUTE repro_tbl INTO l_psia005
      IF SQLCA.sqlcode THEN
         LET l_psia005 = ''
      ELSE
         LET l_psia005 = l_psia005
      END IF
  ELSE
     LET l_psia005 = g_master.psia005
  END IF
  #160819-00015#2-e-add
   
   
   #160819-00015#2-s-add  argv[02],2:apsr532,0:apsr531
   IF g_argv[02] = '2' THEN
      LET g_master.wc = g_master.wc CLIPPED ," AND psiaent = ",g_enterprise," AND psiasite = '",g_site,"' ",
                        " AND psia001 = '",g_master.psia001,"' AND psia002 = '",g_master.psia002,"'"
     IF NOT cl_null(l_psia005) THEN
        LET g_master.wc = g_master.wc CLIPPED ," AND psia005='",l_psia005,"' "
     END IF                
      CALL apsr350_x02(g_master.wc,g_master.psia001)
   ELSE
   #160819-00015#2-e-add
      IF cl_null(g_master.wc) THEN
         CALL l_arg.clear()
         LET l_token = base.StringTokenizer.create(ls_js,",")
         LET l_cnt = 1
         WHILE l_token.hasMoreTokens()
            LET ls_next = l_token.nextToken()
            IF l_cnt>1 THEN
               LET ls_next = ls_next.subString(ls_next.getIndexOf("'",1)+1,ls_next.getLength())
               LET ls_next = ls_next.subString(1,ls_next.getIndexOf("'",1)-1)
            END IF
            LET l_arg[l_cnt] = ls_next
            LET l_cnt = l_cnt + 1
         END WHILE
         CALL l_arg.deleteElement(l_cnt)
         LET  g_master.wc = l_arg[01]
      ELSE
         IF cl_null(g_con) THEN
            LET g_con = " 1=1 "
         END IF
         LET g_master.wc = g_master.wc CLIPPED ," AND psiaent = ",g_enterprise," AND psiasite = '",g_site,"' ",
                         " AND psia001 = '",g_master.psia001,"' AND psia002 = '",g_master.psia002,"'"
         #160819-00015#2-s-mark  移至最前面
         #IF cl_null(g_master.psia005) THEN
         #    LET l_sql = "SELECT MAX(psia005) ",
         #                "  FROM psia_t",
         #                " WHERE ",g_con,
         #                "   AND psia001 = '",g_master.psia001,"'",
         #                "   AND psia002 = '",g_master.psia002,"'"
         #    PREPARE repro_tbl FROM l_sql
         #    EXECUTE repro_tbl INTO l_psia005
         #    IF SQLCA.sqlcode THEN
         #       LET l_psia005 = ''
         #    END IF
         #ELSE
         #   LET g_master.wc = g_master.wc CLIPPED ," AND psia005 = '",g_master.psia005,"'"
         #END IF
         #160819-00015#2-e-mark
         IF NOT cl_null(l_psia005) THEN
            LET g_master.wc = g_master.wc CLIPPED ," AND psia005='",l_psia005,"' "
         END IF
      END IF
#      CALL apsr350_g01(g_master.wc)   #160819-00015#5-mark 因用不到，暫時拿掉
      #dorislai-20151106-modify----(E)
   END IF #160819-00015#2-add
   #CALL apsr350_g01(g_master.wc)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apsr350_process_cs CURSOR FROM ls_sql
#  FOREACH apsr350_process_cs INTO
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
 
{<section id="apsr350.get_buffer" >}
PRIVATE FUNCTION apsr350_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.psia001 = p_dialog.getFieldBuffer('psia001')
   LET g_master.psia002 = p_dialog.getFieldBuffer('psia002')
   LET g_master.psia005 = p_dialog.getFieldBuffer('psia005')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apsr350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
