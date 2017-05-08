#該程式未解開Section, 採用最新樣板產出!
{<section id="ainp160.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-07-06 09:54:23), PR版次:0001(2016-07-07 17:50:14)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000019
#+ Filename...: ainp160
#+ Description: 再訂購點及期間採購量計算作業
#+ Creator....: 02295(2016-07-06 09:54:23)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="ainp160.global" >}
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
       imaa001 LIKE type_t.chr500, 
   imaa003 LIKE type_t.chr10, 
   imaa009 LIKE type_t.chr10, 
   imaf012 LIKE type_t.chr10, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
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
 
{<section id="ainp160.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainp160_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainp160 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainp160_init()
 
      #進入選單 Menu (="N")
      CALL ainp160_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainp160
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainp160.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainp160_init()
 
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
   CALL cl_set_combo_scc_part('imaf012','2021','3,4')
   LET g_master.bdate = ''
   LET g_master.edate = ''
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainp160.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainp160_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.bdate,g_master.edate 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN
               IF g_master.bdate > g_master.edate THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00116'
                  LET g_errparam.extend = g_master.bdate
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  LET g_master.bdate = '' 
                  NEXT FIELD CURRENT                  
               END IF
            END IF
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
            IF NOT cl_null(g_master.bdate) AND NOT cl_null(g_master.edate) THEN
               IF g_master.bdate > g_master.edate THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00116'
                  LET g_errparam.extend = g_master.edate
                  LET g_errparam.popup = TRUE
                  CALL cl_err() 
                  LET g_master.edate = '' 
                  NEXT FIELD CURRENT                  
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON imaa001,imaa003,imaa009,imaf012
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.imaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa001
            #add-point:ON ACTION controlp INFIELD imaa001 name="construct.c.imaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa001  #顯示到畫面上
            NEXT FIELD imaa001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa001
            #add-point:BEFORE FIELD imaa001 name="construct.b.imaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa001
            
            #add-point:AFTER FIELD imaa001 name="construct.a.imaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa003
            #add-point:ON ACTION controlp INFIELD imaa003 name="construct.c.imaa003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa003  #顯示到畫面上
            NEXT FIELD imaa003                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa003
            #add-point:BEFORE FIELD imaa003 name="construct.b.imaa003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa003
            
            #add-point:AFTER FIELD imaa003 name="construct.a.imaa003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:3)
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
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaf012
            #add-point:BEFORE FIELD imaf012 name="construct.b.imaf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaf012
            
            #add-point:AFTER FIELD imaf012 name="construct.a.imaf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaf012
            #add-point:ON ACTION controlp INFIELD imaf012 name="construct.c.imaf012"
            
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
            CALL ainp160_get_buffer(l_dialog)
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
         CALL ainp160_init()
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
                 CALL ainp160_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainp160_transfer_argv(ls_js)
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
 
{<section id="ainp160.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainp160_transfer_argv(ls_js)
 
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
 
{<section id="ainp160.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainp160_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_imaf RECORD    
          imaf001 LIKE imaf_t.imaf001,
          imaa006 LIKE imaa_t.imaa006,
          imaf171 LIKE imaf_t.imaf171,
          imaf172 LIKE imaf_t.imaf172,
          imaf173 LIKE imaf_t.imaf173,
          imaf174 LIKE imaf_t.imaf174,
          imaf021 LIKE imaf_t.imaf021,
          imaf022 LIKE imaf_t.imaf022,
          imaf026 LIKE imaf_t.imaf026,
          imaf013 LIKE imaf_t.imaf013,
          imaf012 LIKE imaf_t.imaf012
          END RECORD  
   DEFINE l_imae016 LIKE imae_t.imae016
   DEFINE l_imae017 LIKE imae_t.imae017
   DEFINE l_imae071 LIKE imae_t.imae071
   DEFINE l_imae072 LIKE imae_t.imae072
   DEFINE l_imae073 LIKE imae_t.imae073
   DEFINE l_imae074 LIKE imae_t.imae074      
   DEFINE l_days    LIKE type_t.num5
   DEFINE l_success LIKE type_t.num5
   DEFINE l_imaf023 LIKE imaf_t.imaf023
   DEFINE l_imaf024 LIKE imaf_t.imaf024
   DEFINE l_sum_inaj011 LIKE inaj_t.inaj011
   DEFINE l_cost LIKE type_t.num20_6
   DEFINE l_before_time LIKE type_t.num20_6
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
      LET g_sql = " SELECT COUNT(*) FROM imaf_t ",
                  "  INNER JOIN imaa_t ON imaaent = imafent AND imaa001 = imaf001 ",
                  "  WHERE imafent = '",g_enterprise,"'",
                  "    AND imafsite = '",g_site,"'",
                  "    AND ",g_master.wc,
                  "    AND imafstus = 'Y'",
                  "    AND imaf012 IN ('3','4')"
      PREPARE ainp160_process_count FROM g_sql
      EXECUTE ainp160_process_count INTO li_count
      CALL cl_progress_bar_no_window(li_count)      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ainp160_process_cs CURSOR FROM ls_sql
#  FOREACH ainp160_process_cs INTO
   #add-point:process段process name="process.process"
   #料件單位時間消耗量 = 期間領出/期間天數
   #期間領出
   LET g_sql = " SELECT SUM(inaj011*inaj048/inaj049) ",
               "   FROM inaj_t ",
               "  WHERE inajent = '",g_enterprise,"'",
               "    AND inajsite = '",g_site,"'",
               "    AND inaj005 = ? ",
               "    AND inaj004 = '-1' ",
               "    AND inaj022 BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "    AND inaj036 NOT IN('401','501','999')"
   PREPARE ainp160_get_inaj011 FROM g_sql  
   #期間天數
   LET l_days = g_master.edate - g_master.bdate + 1 

   #前置時間
   LET g_sql = "SELECT imae016,imae017,imae071,imae072,imae073,imae074 ",
               "  FROM imae_t ",
               " WHERE imaeent = '",g_enterprise,"'",
               "   AND imaesite = '",g_site,"'",
               "   AND imae001 = ? "
   PREPARE ainp160_get_time FROM g_sql
   
   LET g_sql = " SELECT imaf001,imaa006,imaf171,imaf172,imaf173,",
               "        imaf174,imaf021,imaf022,imaf026,imaf013, ",
               "        imaf012",
               "   FROM imaf_t ",
               "  INNER JOIN imaa_t ON imaaent = imafent AND imaa001 = imaf001 ",
               "  WHERE imafent = '",g_enterprise,"'",
               "    AND imafsite = '",g_site,"'",
               "    AND ",g_master.wc,
               "    AND imafstus = 'Y'",
               "    AND imaf012 IN ('3','4')"               
   PREPARE ainp160_process_pr FROM g_sql
   DECLARE ainp160_process_cs CURSOR FOR ainp160_process_pr
   FOREACH ainp160_process_cs INTO l_imaf.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
      
      CALL cl_progress_no_window_ing(l_imaf.imaf001)
      
      #料件單位時間消耗量 = 期間領出/期間天數
      EXECUTE ainp160_get_inaj011 USING l_imaf.imaf001 INTO l_sum_inaj011
      IF cl_null(l_sum_inaj011) THEN LET l_sum_inaj011 = 0 END IF
      LET l_cost = l_sum_inaj011/l_days
      
      #計算 前置時間
      CASE 
         WHEN l_imaf.imaf013 MATCHES '[14]'  
            LET l_before_time = l_imaf.imaf171 + l_imaf.imaf172 + l_imaf.imaf173 + l_imaf.imaf174            
         WHEN l_imaf.imaf013 MATCHES '[23]'
            EXECUTE ainp160_get_time USING l_imaf.imaf001 INTO l_imae016,l_imae017,l_imae071,l_imae072,l_imae073,l_imae074
            CALL s_aooi250_convert_qty(l_imaf.imaf001,l_imae016,l_imaf.imaa006,l_imae017) RETURNING l_success,l_imae017
            LET l_before_time = l_imae071+l_imae017*l_imae072/l_imae073+l_imae074
      END CASE 
      
      CASE l_imaf.imaf012
         WHEN '3' #計算更新期間採購量
            LET l_imaf023 = l_cost*(l_before_time+(l_imaf.imaf021*30+l_imaf.imaf022))+l_imaf.imaf026
            IF cl_null(l_imaf023) THEN LET l_imaf023 = 0 END IF
            UPDATE imaf_t
               SET imaf023 = l_imaf023
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = l_imaf.imaf001
         WHEN '4' #計算更新再訂購點
            LET l_imaf024 = l_cost*l_before_time+l_imaf.imaf026
            IF cl_null(l_imaf024) THEN LET l_imaf024 = 0 END IF
            UPDATE imaf_t
               SET imaf024 = l_imaf024
             WHERE imafent = g_enterprise
               AND imafsite = g_site
               AND imaf001 = l_imaf.imaf001            
      END CASE
   END FOREACH
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
   CALL ainp160_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ainp160.get_buffer" >}
PRIVATE FUNCTION ainp160_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.bdate = p_dialog.getFieldBuffer('bdate')
   LET g_master.edate = p_dialog.getFieldBuffer('edate')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainp160.msgcentre_notify" >}
PRIVATE FUNCTION ainp160_msgcentre_notify()
 
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
 
{<section id="ainp160.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
