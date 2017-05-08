#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp801.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-08-03 10:13:08), PR版次:0001(2016-09-01 15:58:17)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000011
#+ Filename...: anmp801
#+ Description: 內部資金進出明細自動產生作業
#+ Creator....: 01531(2016-08-02 13:43:45)
#+ Modifier...: 01531 -SD/PR- 01531
 
{</section>}
 
{<section id="anmp801.global" >}
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
       nmas002 LIKE nmas_t.nmas002, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_nmas002_str     STRING            #160326-00001#27
DEFINE g_nmas002_str1    STRING            #160326-00001#27
DEFINE g_sql_bank        STRING            #160326-00001#27
DEFINE g_para_date       LIKE type_t.dat   #160326-00001#27
DEFINE g_success         LIKE type_t.num5  #160326-00001#27
DEFINE g_site_str        STRING            #160326-00001#27
DEFINE g_glaald          LIKE glaa_t.glaald
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmp801.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL anmp801_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp801 WITH FORM cl_ap_formpath("anm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL anmp801_init()
 
      #進入選單 Menu (="N")
      CALL anmp801_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_anmp801
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="anmp801.init" >}
#+ 初始化作業
PRIVATE FUNCTION anmp801_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_glaa003 LIKE glaa_t.glaa003
   DEFINE l_yy      LIKE type_t.num5
   DEFINE l_mm      LIKE type_t.num5   
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
   #160326-00001#27 add s---
   LET g_sql_bank=NULL
   CALL s_anmi120_get_bank_account_sql(g_user,g_dept) RETURNING g_sub_success,g_sql_bank
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-4007') RETURNING g_para_date
   
   SELECT glaald INTO g_glaald FROM glaa_t WHERE glaaent = g_enterprise AND glaa014 = 'Y' AND glaacomp = 
   (SELECT ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site)
   CALL s_fin_date_get_period_value('',g_glaald,g_today)RETURNING g_sub_success,l_yy,l_mm
      
   SELECT glaa003 INTO l_glaa003 FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_glaald
      
   CALL s_fin_date_get_period_range(l_glaa003,l_yy,l_mm) RETURNING g_master.bdate,g_master.edate
   #160326-00001#27 add e---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="anmp801.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp801_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   DEFINE l_cnt       LIKE type_t.num5    #160326-00001#27
   DEFINE l_yy_b      LIKE type_t.num5
   DEFINE l_yy_e      LIKE type_t.num5
   DEFINE l_mm_b      LIKE type_t.num5
   DEFINE l_mm_e      LIKE type_t.num5
   DEFINE l_glaa003   LIKE glaa_t.glaa003
   DEFINE l_yy        LIKE type_t.num5
   DEFINE l_mm        LIKE type_t.num5  
   DEFINE l_bdate     LIKE type_t.dat   
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
            #160326-00001#27 add s---
            IF NOT cl_null(g_master.bdate) THEN 
               IF g_master.bdate < g_para_date THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03011'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bdate = g_today
                  DISPLAY BY NAME g_master.bdate
                  NEXT FIELD bdate               
               END IF

               CALL s_fin_date_get_period_value('',g_glaald,g_master.bdate)RETURNING g_sub_success,l_yy,l_mm
                  
               SELECT glaa003 INTO l_glaa003 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald = g_glaald
                  
               CALL s_fin_date_get_period_range(l_glaa003,l_yy,l_mm) RETURNING l_bdate,g_master.edate
               DISPLAY g_master.edate TO edate               
               IF NOT cl_null(g_master.edate) THEN
                  IF g_master.edate < g_master.bdate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00063'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bdate = g_today
                     DISPLAY BY NAME g_master.bdate
                     NEXT FIELD bdate               
                  END IF
                  LET l_yy_b = YEAR(g_master.bdate) 
                  LET l_yy_e = YEAR(g_master.edate)  
                  LET l_mm_b = MONTH(g_master.bdate) 
                  LET l_mm_e = MONTH(g_master.edate)
                  IF l_yy_b <> l_yy_e OR l_mm_b <> l_mm_e THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-03015'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bdate = g_today
                     DISPLAY BY NAME g_master.bdate
                     NEXT FIELD bdate                    
                  END IF                  
               END IF
               LET g_master.edate = s_date_get_last_date(g_master.bdate)  
               DISPLAY g_master.edate TO edate
            END IF
            #160326-00001#27 add e---
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
            IF NOT cl_null(g_master.edate) OR cl_null(g_master.bdate) THEN     
               IF g_master.edate < g_master.bdate THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00063'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD edate               
               END IF 
               
               LET l_yy_b = YEAR(g_master.bdate) 
               LET l_yy_e = YEAR(g_master.edate)  
               LET l_mm_b = MONTH(g_master.bdate) 
               LET l_mm_e = MONTH(g_master.edate)
               IF l_yy_b <> l_yy_e OR l_mm_b <> l_mm_e THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-03015'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD edate                    
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            #160326-00001#27 add s---
            IF g_master.edate < g_master.bdate THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "aap-00336"
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL s_date_get_first_date(g_master.edate) RETURNING g_master.edate
            END IF
            DISPLAY BY NAME g_master.bdate,g_master.edate
            #160326-00001#27 add e---
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
         CONSTRUCT BY NAME g_master.wc ON nmas002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmas002
            #add-point:BEFORE FIELD nmas002 name="construct.b.nmas002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmas002
            
            #add-point:AFTER FIELD nmas002 name="construct.a.nmas002"
            #160326-00001#27 add s---
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_nmas002_str
            LET g_nmas002_str1 = g_nmas002_str
            LET g_nmas002_str = cl_replace_str(g_nmas002_str,"|","','")           
            CALL s_axrt300_get_site(g_user,'','1') RETURNING g_site_str 
            LET g_site_str = cl_replace_str(g_site_str,"ooef001","nmaa002")  
            IF g_nmas002_str = "*" THEN
               LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
                           "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
                           "    AND nmas002 IN (",g_sql_bank,") ",  
                           "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"
            ELSE
               LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
                           "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str," AND nmas002 IN ('",g_nmas002_str,"') ",  
                           "    AND nmas002 IN (",g_sql_bank,") ",  
                           "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"            
            END IF
            PREPARE anmp801_count_pre FROM g_sql
            EXECUTE anmp801_count_pre INTO l_cnt 
            IF l_cnt = 0 THEN 
               DISPLAY '' TO nmas002
               NEXT FIELD nmas002               
            END IF  
            #160326-00001#27 add e---            
            #END add-point
            
 
 
         #Ctrlp:construct.c.nmas002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmas002
            #add-point:ON ACTION controlp INFIELD nmas002 name="construct.c.nmas002"
            CALL s_axrt300_get_site(g_user,'','1') RETURNING g_site_str        #160326-00001#27
            LET g_site_str = cl_replace_str(g_site_str,"ooef001","nmaa002")    #160326-00001#27 
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = g_site_str CLIPPED," AND nmas002 IN (",g_sql_bank,") ",    #160326-00001#27
                                   " AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')"  #160326-00001#27
                                   
            CALL q_nmas001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO nmas002  #顯示到畫面上
            NEXT FIELD nmas002                     #返回原欄位
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
            CALL anmp801_get_buffer(l_dialog)
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
         CALL anmp801_init()
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
                 CALL anmp801_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = anmp801_transfer_argv(ls_js)
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
 
{<section id="anmp801.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION anmp801_transfer_argv(ls_js)
 
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
 
{<section id="anmp801.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION anmp801_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
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
#  DECLARE anmp801_process_cs CURSOR FROM ls_sql
#  FOREACH anmp801_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL anmp801_p()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL anmp801_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="anmp801.get_buffer" >}
PRIVATE FUNCTION anmp801_get_buffer(p_dialog)
 
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
 
{<section id="anmp801.msgcentre_notify" >}
PRIVATE FUNCTION anmp801_msgcentre_notify()
 
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
 
{<section id="anmp801.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmp801_p()
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_p()
   #錯誤訊息匯總初始化
   CALL cl_err_collect_init()
   
   LET g_coll_title[1] = cl_getmsg('anm-03016',g_dlang)
   LET g_coll_title[2] = cl_getmsg('afa-00211',g_dlang)
   LET g_coll_title[3] = cl_getmsg('aap-00154',g_dlang)     
   
   LET g_success = TRUE
   
   CALL s_transaction_begin()

   #检查内部银行资料权限，汇总报错显示 
   CALL anmp801_pr()  RETURNING g_success 
   
   IF g_success = TRUE THEN 
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()
 
END FUNCTION

################################################################################
# Descriptions...: 内部利息检查
# Memo...........:
# Usage..........: CALL anmp801_chk_anmt310(p_nmas002)
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_chk_anmt310(p_nmas002)
#日期范围（当月,不跨月）+内部账户检查内部利息是否已计提
#若已计提过则汇总报错,未计提的继续执行
DEFINE r_success LIKE type_t.num5
DEFINE l_nmbb003 LIKE nmbb_t.nmbb003
DEFINE l_nmbbdocno LIKE nmbb_t.nmbbdocno
DEFINE l_nmbadocdt LIKE nmba_t.nmbadocdt
DEFINE p_nmas002   LIKE nmas_t.nmas002

   LET r_success = TRUE
   LET g_sql = " SELECT nmbb003,nmbadocdt,nmbbdocno FROM nmba_t,nmbb_t ", 
               "  WHERE nmbaent = nmbbent AND nmbacomp = nmbbcomp AND nmbadocno = nmbbdocno ",
               "    AND nmbadocdt >= '",g_master.bdate,"' AND nmbadocdt <= '",g_master.edate,"' AND nmba003 ='anmp802' ", 
               "    AND nmbb003 = '",p_nmas002,"'"  
   PREPARE anmp801_nmbb_pre FROM g_sql 
   DECLARE anmp801_nmbb_cur CURSOR FOR anmp801_nmbb_pre

   FOREACH anmp801_nmbb_cur INTO l_nmbb003,l_nmbadocdt,l_nmbbdocno
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbb:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF  
      IF NOT cl_null(l_nmbb003) THEN 
         LET g_errparam.code = 'anm-03012'
         LET g_errparam.popup = TRUE
         #LET g_errparam.replace[1] = ""
         LET g_errparam.coll_vals[1] = l_nmbb003
         LET g_errparam.coll_vals[2] = l_nmbadocdt
         LET g_errparam.coll_vals[3] = l_nmbbdocno
         LET g_errparam.sqlerr = SQLCA.SQLCODE 
         LET r_success = FALSE
         CALL cl_err()      
      END IF
   END FOREACH
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 检查未计提利息的交易账户是否存在nmbc资料
# Memo...........:
# Usage..........: CALL anmp801_chk_nmbc(p_nmas002)
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_chk_nmbc(p_nmas002)
DEFINE r_success LIKE type_t.num5  
DEFINE l_nmbcdocno    LIKE nmbc_t.nmbcdocno
DEFINE l_nmbc002      LIKE nmbc_t.nmbc002
DEFINE l_nmbcseq      LIKE nmbc_t.nmbcseq
DEFINE l_nmbccomp     LIKE nmbc_t.nmbccomp
DEFINE l_nmbcorga     LIKE nmbc_t.nmbcorga
DEFINE p_nmas002      LIKE nmas_t.nmas002


   #检查据点内部银行   
   LET g_sql = " SELECT nmbcdocno,nmbccomp,nmbcseq,nmbc002 FROM nmbc_t ", 
               "  WHERE nmbcent = '",g_enterprise,"' ",
               "    AND nmbc005 BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "    AND nmbc002 ='",p_nmas002,"'", 
               "    AND nmbc001 = 'anmp801' "               
   PREPARE anmp801_nmbc_pre1 FROM g_sql 
   DECLARE anmp801_nmbc_cur1 CURSOR FOR anmp801_nmbc_pre1

   FOREACH anmp801_nmbc_cur1 INTO l_nmbcdocno,l_nmbccomp,l_nmbcseq,l_nmbc002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbc1:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF     
   
      DELETE FROM nmbc_t WHERE nmbcent = g_enterprise AND nmbcdocno = l_nmbcdocno AND nmbccomp = l_nmbccomp
                           AND nmbcseq = l_nmbcseq AND nmbc002 = l_nmbc002
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "del nmbc1" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = FALSE 
           CALL cl_err()
           LET r_success = FALSE
        END IF          
   END FOREACH    
   
   #检查法人内部银行
   LET g_sql = " SELECT nmbcdocno,nmbcorga,nmbcseq,nmbc002 FROM nmbc_t ", 
               "  WHERE nmbcent = '",g_enterprise,"' ",
               "    AND nmbc005 BETWEEN '",g_master.bdate,"' AND '",g_master.edate,"'",
               "    AND nmbcorga IN (",   #nmbcorga = anmi120交易账户的开户组织（不是nmbccomp）
               "        SELECT nmaa002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001  AND nmas002 = '",p_nmas002,"'",
               "                   )",
               "    AND nmbc001 = 'anmp801' "               
   PREPARE anmp801_nmbc_pre2 FROM g_sql 
   DECLARE anmp801_nmbc_cur2 CURSOR FOR anmp801_nmbc_pre2

   FOREACH anmp801_nmbc_cur2 INTO l_nmbcdocno,l_nmbcorga,l_nmbcseq,l_nmbc002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbc2:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF     
   
      DELETE FROM nmbc_t WHERE nmbcent = g_enterprise AND nmbcdocno = l_nmbcdocno AND nmbcorga = l_nmbcorga
         AND nmbcseq = l_nmbcseq AND nmbc002 = l_nmbc002
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "del nmbc2" 
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = FALSE 
           CALL cl_err()
           LET r_success = FALSE
        END IF          
         
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp801_get_nmbc(p_nmbc002)
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_get_nmbc(p_nmbc002)

DEFINE l_nmbc RECORD  #銀存收支異動檔
       nmbcent LIKE nmbc_t.nmbcent, #企业编号
       nmbcownid LIKE nmbc_t.nmbcownid, #资料所有者
       nmbcowndp LIKE nmbc_t.nmbcowndp, #资料所有部门
       nmbccrtid LIKE nmbc_t.nmbccrtid, #资料录入者
       nmbccrtdp LIKE nmbc_t.nmbccrtdp, #资料录入部门
       nmbccrtdt LIKE nmbc_t.nmbccrtdt, #资料创建日
       nmbcmodid LIKE nmbc_t.nmbcmodid, #资料更改者
       nmbcmoddt LIKE nmbc_t.nmbcmoddt, #最近更改日
       nmbccnfid LIKE nmbc_t.nmbccnfid, #资料审核者
       nmbccnfdt LIKE nmbc_t.nmbccnfdt, #数据审核日
       nmbcpstid LIKE nmbc_t.nmbcpstid, #资料过账者
       nmbcpstdt LIKE nmbc_t.nmbcpstdt, #资料过账日
       nmbcstus LIKE nmbc_t.nmbcstus, #状态码
       nmbccomp LIKE nmbc_t.nmbccomp, #法人
       nmbcsite LIKE nmbc_t.nmbcsite, #资金中心
       nmbcdocno LIKE nmbc_t.nmbcdocno, #来源单号
       nmbcseq LIKE nmbc_t.nmbcseq, #项次
       nmbc001 LIKE nmbc_t.nmbc001, #单据来源
       nmbc002 LIKE nmbc_t.nmbc002, #交易账户编码
       nmbc003 LIKE nmbc_t.nmbc003, #交易对象
       nmbc004 LIKE nmbc_t.nmbc004, #交易对象识别码
       nmbc005 LIKE nmbc_t.nmbc005, #银行日期
       nmbc006 LIKE nmbc_t.nmbc006, #异动别
       nmbc007 LIKE nmbc_t.nmbc007, #存提码
       nmbc008 LIKE nmbc_t.nmbc008, #调节码
       nmbc009 LIKE nmbc_t.nmbc009, #对账码
       nmbc010 LIKE nmbc_t.nmbc010, #网银媒体档转出日期
       nmbc011 LIKE nmbc_t.nmbc011, #网银媒体档转出批号
       nmbc100 LIKE nmbc_t.nmbc100, #交易帐户币种
       nmbc101 LIKE nmbc_t.nmbc101, #主账套汇率
       nmbc103 LIKE nmbc_t.nmbc103, #主账套原币金额
       nmbc113 LIKE nmbc_t.nmbc113, #主账套本币金额
       nmbc121 LIKE nmbc_t.nmbc121, #主账套本位币二汇率
       nmbc123 LIKE nmbc_t.nmbc123, #主账套本位币二金额
       nmbc131 LIKE nmbc_t.nmbc131, #主账套本位币三汇率
       nmbc133 LIKE nmbc_t.nmbc133, #主账套本位币三金额
       nmbc012 LIKE nmbc_t.nmbc012, #票据号码
       nmbc013 LIKE nmbc_t.nmbc013, #款别
       nmbc014 LIKE nmbc_t.nmbc014, #到期日
       nmbc015 LIKE nmbc_t.nmbc015, #导入银行编号
       nmbc016 LIKE nmbc_t.nmbc016, #导入帐号
       nmbc017 LIKE nmbc_t.nmbc017, #受款人全名
       nmbcorga LIKE nmbc_t.nmbcorga #来源组织
END RECORD
DEFINE p_nmbc002  LIKE nmbc_t.nmbc002
DEFINE r_success  LIKE type_t.num5
DEFINE l_nmas002  LIKE nmas_t.nmas002

   LET r_success = TRUE
   LET g_sql = " SELECT nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                         nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                         nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                         nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                         nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                         nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                         nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                         nmbc133,nmbc012,nmbc013,nmbc014,nmbc015,
                         nmbc016,nmbc017,nmbcorga FROM nmbc_t ", 
               "  WHERE nmbcent = '",g_enterprise,"' ",
               "    AND nmbc005 >= '",g_master.bdate,"' AND nmbc005 <= '",g_master.edate,"'",
               "    AND nmbcorga IN ( SELECT nmaa002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND nmas002 = '",p_nmbc002,"')", #来源组织等于anmi120交易账户的开户组织
               "    AND nmbcorga != nmbccomp ", 
               "    AND nmbc100 = (SELECT nmas003 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND nmas002 = '",p_nmbc002,"')",               
               "    AND nmbc002 IN (SELECT nmas002 FROM nmaa_t,nmas_t WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",  #交易账户是外部银行
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '1'))"                
   PREPARE anmp801_nmbc_pre3 FROM g_sql 
   DECLARE anmp801_nmbc_cur3 CURSOR FOR anmp801_nmbc_pre3

   #获取anmi120开户人组织的内部银行（nmbccomp取值,相同币别，默认第一笔资料）
   LET g_sql = " SELECT nmas002 FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ",
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0') ",      
               "    AND nmaa002 = ? AND nmas003 = ?",
               "    ORDER BY nmas003 "
   PREPARE anmp801_nmbc_pre4 FROM g_sql 
   DECLARE anmp801_nmbc_cur4 CURSOR FOR anmp801_nmbc_pre4   
   
   FOREACH anmp801_nmbc_cur3 INTO l_nmbc.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmbc3:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF     
   
      LET l_nmbc.nmbc002 = p_nmbc002
      LET l_nmbc.nmbc001 = 'anmp801'
      INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                         nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                         nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                         nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                         nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                         nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                         nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                         nmbc133,nmbc012,nmbc013,nmbc014,nmbc015,
                         nmbc016,nmbc017,nmbcorga )     
                  VALUES(l_nmbc.nmbcent,  l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
                         l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,
                         l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus, l_nmbc.nmbccomp, l_nmbc.nmbcsite,
                         l_nmbc.nmbcdocno,l_nmbc.nmbcseq,  l_nmbc.nmbc001,  l_nmbc.nmbc002,  l_nmbc.nmbc003,
                         l_nmbc.nmbc004,  l_nmbc.nmbc005,  l_nmbc.nmbc006,  l_nmbc.nmbc007,  l_nmbc.nmbc008,
                         l_nmbc.nmbc009,  l_nmbc.nmbc010,  l_nmbc.nmbc011,  l_nmbc.nmbc100,  l_nmbc.nmbc101,
                         l_nmbc.nmbc103,  l_nmbc.nmbc113,  l_nmbc.nmbc121,  l_nmbc.nmbc123,  l_nmbc.nmbc131,
                         l_nmbc.nmbc133,  l_nmbc.nmbc012,  l_nmbc.nmbc013,  l_nmbc.nmbc014,  l_nmbc.nmbc015,
                         l_nmbc.nmbc016,  l_nmbc.nmbc017,  l_nmbc.nmbcorga)      
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbc1"
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF   

      LET l_nmas002 = NULL
      FOREACH anmp801_nmbc_cur4 USING l_nmbc.nmbccomp,l_nmbc.nmbc100 INTO l_nmas002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH nmbc4:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF    
         IF NOT cl_null(l_nmas002) THEN EXIT FOREACH END IF  #只取第一笔       
      END FOREACH
 
      IF NOT cl_null(l_nmas002) THEN 
         LET l_nmbc.nmbc002 = l_nmas002  
         LET l_nmbc.nmbc103 = l_nmbc.nmbc103 * (-1)  
         LET l_nmbc.nmbc113 = l_nmbc.nmbc113 * (-1)   
         LET l_nmbc.nmbc123 = l_nmbc.nmbc123 * (-1)   
         LET l_nmbc.nmbc133 = l_nmbc.nmbc133 * (-1)   
      INSERT INTO nmbc_t(nmbcent,nmbcownid,nmbcowndp,nmbccrtid,nmbccrtdp,
                         nmbccrtdt,nmbcmodid,nmbcmoddt,nmbccnfid,nmbccnfdt,
                         nmbcpstid,nmbcpstdt,nmbcstus,nmbccomp,nmbcsite,
                         nmbcdocno,nmbcseq,nmbc001,nmbc002,nmbc003,
                         nmbc004,nmbc005,nmbc006,nmbc007,nmbc008,
                         nmbc009,nmbc010,nmbc011,nmbc100,nmbc101,
                         nmbc103,nmbc113,nmbc121,nmbc123,nmbc131,
                         nmbc133,nmbc012,nmbc013,nmbc014,nmbc015,
                         nmbc016,nmbc017,nmbcorga )     
                  VALUES(l_nmbc.nmbcent,  l_nmbc.nmbcownid,l_nmbc.nmbcowndp,l_nmbc.nmbccrtid,l_nmbc.nmbccrtdp,
                         l_nmbc.nmbccrtdt,l_nmbc.nmbcmodid,l_nmbc.nmbcmoddt,l_nmbc.nmbccnfid,l_nmbc.nmbccnfdt,
                         l_nmbc.nmbcpstid,l_nmbc.nmbcpstdt,l_nmbc.nmbcstus, l_nmbc.nmbccomp, l_nmbc.nmbcsite,
                         l_nmbc.nmbcdocno,l_nmbc.nmbcseq,  l_nmbc.nmbc001,  l_nmbc.nmbc002,  l_nmbc.nmbc003,
                         l_nmbc.nmbc004,  l_nmbc.nmbc005,  l_nmbc.nmbc006,  l_nmbc.nmbc007,  l_nmbc.nmbc008,
                         l_nmbc.nmbc009,  l_nmbc.nmbc010,  l_nmbc.nmbc011,  l_nmbc.nmbc100,  l_nmbc.nmbc101,
                         l_nmbc.nmbc103,  l_nmbc.nmbc113,  l_nmbc.nmbc121,  l_nmbc.nmbc123,  l_nmbc.nmbc131,
                         l_nmbc.nmbc133,  l_nmbc.nmbc012,  l_nmbc.nmbc013,  l_nmbc.nmbc014,  l_nmbc.nmbc015,
                         l_nmbc.nmbc016,  l_nmbc.nmbc017,  l_nmbc.nmbcorga)   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins nmbc2"
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
         END IF   
      END IF   
   END FOREACH  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp801_pr()
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_pr()
#   DEFINE li_nmas002       DYNAMIC ARRAY OF LIKE nmas_t.nmas002
DEFINE tok3  base.StringTokenizer
DEFINE l_i         LIKE type_t.num5
DEFINE l_str       STRING
DEFINE r_success   LIKE type_t.num5
DEFINE l_success   LIKE type_t.num5  
DEFINE l_nmas002   LIKE nmas_t.nmas002

   LET r_success = TRUE
   LET l_success = TRUE

   IF cl_null(g_master.wc) THEN
      LET g_master.wc = " 1=1"
   END IF
   
   IF g_nmas002_str = "*"  THEN 
      LET g_sql = " SELECT nmas002 FROM nmas_t,nmaa_t ",
                  "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",
                  "    AND ",g_site_str, #azzi800使用据点权限
                  "    AND nmas002 IN (",g_sql_bank,") ",  #anmi120用户&部门权限
                  "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0')",#开户银行为有效的内部银行
                  "    AND ",g_master.wc CLIPPED 
   ELSE               
      LET g_sql = " SELECT nmas002 FROM nmas_t,nmaa_t ",
                  "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 ",
                  "    AND ",g_master.wc CLIPPED 
   END IF             
   PREPARE anmp801_nmas002_pre FROM g_sql 
   DECLARE anmp801_nmas002_cur CURSOR FOR anmp801_nmas002_pre
   FOREACH anmp801_nmas002_cur INTO l_nmas002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH nmas002:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         EXIT FOREACH
      END IF 

      IF g_nmas002_str <> "*" THEN
         #基础检查
         CALL anmp801_chk(l_nmas002) RETURNING l_success
      END IF
      IF l_success THEN 
         #检查是否已计提内部利息，汇总报错显示 
         CALL anmp801_chk_anmt310(l_nmas002) RETURNING l_success
         
         IF l_success THEN 
            #检查未计提利息的交易账户是否存在nmbc资料
            CALL anmp801_chk_nmbc(l_nmas002)  
         
            CALL anmp801_get_nmbc(l_nmas002) RETURNING r_success
         END IF   
      END IF
  
   END FOREACH 
   RETURN r_success   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmp801_chk(p_nmas002)
# Input parameter:  
# Date & Author..: 2016/08/03 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp801_chk(p_nmas002)
DEFINE p_nmas002   LIKE nmas_t.nmas002
DEFINE l_cnt       LIKE type_t.num5
DEFINE r_success   LIKE type_t.num5
   LET r_success = TRUE   
   #交易账户是否存在
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ", 
               "  AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"'"
   PREPARE anmp801_chk_pre1 FROM g_sql
   EXECUTE anmp801_chk_pre1 INTO l_cnt    
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'ade-00009'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      LET r_success = FALSE
      RETURN r_success    
   END IF
   
   #交易账户是否有效
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ", 
               "  AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"' AND nmaastus = 'Y'"
   PREPARE anmp801_chk_pre2 FROM g_sql
   EXECUTE anmp801_chk_pre2 INTO l_cnt    
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-03013'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      LET r_success = FALSE      
      RETURN r_success           
   END IF   
   
   #交易账户对应的开户银行是否是内部银行
   LET l_cnt = 0
   LET g_sql = " SELECT COUNT(*) FROM nmaa_t,nmas_t WHERE nmaaent = nmasent AND nmaa001 = nmas001 ",
               "    AND nmasent = '",g_enterprise,"' AND nmas002 = '",p_nmas002,"' AND nmaastus = 'Y'",
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp801_chk_pre3 FROM g_sql
   EXECUTE anmp801_chk_pre3 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-00250'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE      
      RETURN r_success        
   END IF 
   
   #g_user是否有azzi800权限
   LET l_cnt = 0 
   LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
               "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
               "    AND nmas002 = '",p_nmas002,"'",  
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp801_chk_pre4 FROM g_sql
   EXECUTE anmp801_chk_pre4 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-03014'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err()  
      LET r_success = FALSE 
      RETURN r_success          
   END IF                
   
   #g_user是否有交易账户权限
   LET l_cnt = 0 
   LET g_sql = " SELECT COUNT(*) FROM nmas_t,nmaa_t ",
               "  WHERE nmasent = nmaaent AND nmas001 = nmaa001 AND ",g_site_str,
               "    AND nmas002 = '",p_nmas002,"'",  
               "    AND nmas002 IN (",g_sql_bank,") ", 
               "    AND nmaa004 IN (SELECT nmab001 FROM nmab_t WHERE nmabent = '",g_enterprise,"' AND nmabstus = 'Y' AND nmab002 = '0' AND nmab001 = nmaa004)"
   PREPARE anmp801_chk_pre5 FROM g_sql
   EXECUTE anmp801_chk_pre5 INTO l_cnt 
   IF l_cnt = 0 THEN 
      LET g_errparam.code = 'anm-00574'
      LET g_errparam.extend = p_nmas002
      LET g_errparam.popup = TRUE
      CALL cl_err() 
      LET r_success = FALSE 
      RETURN r_success          
   END IF     
   RETURN r_success    
END FUNCTION

#end add-point
 
{</section>}
 
