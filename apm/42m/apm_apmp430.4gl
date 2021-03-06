#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-07-08 17:58:46), PR版次:0002(2016-08-09 15:25:27)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: apmp430
#+ Description: 採購折扣結算作業
#+ Creator....: 02295(2015-07-03 11:16:07)
#+ Modifier...: 02295 -SD/PR- 07024
 
{</section>}
 
{<section id="apmp430.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160809-00030#1   2016/08/09   By  dorislai  合約單號開窗，多過濾"已結案、未確認、已作廢"

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
   pmevdocno LIKE pmev_t.pmevdocno, 
   pmexseq LIKE pmex_t.pmexseq, 
   pmex010 DATETIME YEAR TO SECOND, 
   pmex011 LIKE pmex_t.pmex011, 
   pmex012 LIKE pmex_t.pmex012, 
   chk LIKE type_t.chr500, 
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmevdocno LIKE pmev_t.pmevdocno, 
   pmexseq LIKE type_t.chr500, 
   pmex010 LIKE pmex_t.pmex010, 
   pmex011 LIKE pmex_t.pmex011, 
   pmex012 LIKE pmex_t.pmex012, 
   chk LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_o        type_master
DEFINE g_ooef019         LIKE ooef_t.ooef019
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apmp430.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apmp430_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp430 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp430_init()
 
      #進入選單 Menu (="N")
      CALL apmp430_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp430
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp430.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp430_init()
 
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
   LET g_ooef019 = ''
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp430.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp430_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_pmex010   LIKE pmex_t.pmex010
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.pmexseq = ''
   LET g_master.pmex010 = g_today
   LET g_master.pmex011 = ''
   LET g_master.pmex012 = g_today
   LET g_master.chk = 'Y'
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.pmevdocno,g_master.pmexseq,g_master.pmex010,g_master.pmex011,g_master.pmex012, 
             g_master.chk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master_o.* = g_master.*
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmevdocno
            #add-point:BEFORE FIELD pmevdocno name="input.b.pmevdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmevdocno
            
            #add-point:AFTER FIELD pmevdocno name="input.a.pmevdocno"
            IF NOT cl_null(g_master.pmevdocno) THEN 
               IF g_master.pmevdocno <> g_master_o.pmevdocno OR cl_null(g_master_o.pmevdocno) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.pmevdocno
                  IF NOT cl_chk_exist("v_pmevdocno") THEN
                     LET g_master.pmevdocno = g_master_o.pmevdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_master.pmexseq) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.pmevdocno
                  LET g_chkparam.arg2 = g_master.pmexseq
                  IF NOT cl_chk_exist("v_pmexseq") THEN
                     LET g_master.pmevdocno = g_master_o.pmevdocno
                     NEXT FIELD CURRENT
                  END IF
               END IF               
            ELSE
               NEXT FIELD CURRENT            
            END IF
            LET g_master_o.pmevdocno = g_master.pmevdocno
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmevdocno
            #add-point:ON CHANGE pmevdocno name="input.g.pmevdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmexseq
            #add-point:BEFORE FIELD pmexseq name="input.b.pmexseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmexseq
            
            #add-point:AFTER FIELD pmexseq name="input.a.pmexseq"
            IF NOT cl_null(g_master.pmexseq) THEN
               IF g_master.pmexseq <> g_master_o.pmexseq OR cl_null(g_master_o.pmexseq) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.pmevdocno
                  LET g_chkparam.arg2 = g_master.pmexseq
                  IF NOT cl_chk_exist("v_pmexseq") THEN
                     LET g_master.pmexseq = g_master_o.pmexseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_master_o.pmexseq = g_master.pmexseq
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmexseq
            #add-point:ON CHANGE pmexseq name="input.g.pmexseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmex010
            #add-point:BEFORE FIELD pmex010 name="input.b.pmex010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmex010
            
            #add-point:AFTER FIELD pmex010 name="input.a.pmex010"
            IF NOT cl_null(g_master.pmex010) THEN
               IF g_master.pmex010 <> g_master_o.pmex010 OR cl_null(g_master_o.pmex010) THEN
                  LET l_pmex010 = ''
                  IF cl_null(g_master.pmexseq) THEN
                     SELECT MIN(pmex010) INTO l_pmex010
                       FROM pmex_t
                      WHERE pmexent = g_enterprise
                        AND pmexdocno = g_master.pmevdocno
                  ELSE
                     SELECT MIN(pmex010) INTO l_pmex010
                       FROM pmex_t
                      WHERE pmexent = g_enterprise
                        AND pmexdocno = g_master.pmevdocno
                        AND pmexseq = g_master.pmexseq
                  END IF
                  #不可以小於該合約上記錄的最近結算日期
                  IF g_master.pmex010 < l_pmex010 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_pmex010
                     LET g_errparam.code   = 'apm-00976'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     LET g_master.pmex010 = g_master_o.pmex010
                     DISPLAY BY NAME g_master.pmex010
                     NEXT FIELD CURRENT
                  END IF
                  LET g_master.pmex012 = g_master.pmex010
                  LET g_master_o.pmex012 = g_master.pmex012
               END IF
            END IF
            LET g_master_o.pmex010 = g_master.pmex010
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmex010
            #add-point:ON CHANGE pmex010 name="input.g.pmex010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmex011
            #add-point:BEFORE FIELD pmex011 name="input.b.pmex011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmex011
            
            #add-point:AFTER FIELD pmex011 name="input.a.pmex011"
            IF NOT cl_null(g_master.pmex011) THEN
               IF g_master.pmex011 <> g_master_o.pmex011 OR cl_null(g_master_o.pmex011) THEN
                  IF NOT cl_null(g_master.pmex012) THEN
                     #起始日期不可大於截止日期,請檢查！
                     IF g_master.pmex012 < g_master.pmex011  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.pmex011
                        LET g_errparam.code   = 'agl-00116'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.pmex011 = g_master_o.pmex011
                        DISPLAY BY NAME g_master.pmex011
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.pmex011 = g_master.pmex011
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmex011
            #add-point:ON CHANGE pmex011 name="input.g.pmex011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmex012
            #add-point:BEFORE FIELD pmex012 name="input.b.pmex012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmex012
            
            #add-point:AFTER FIELD pmex012 name="input.a.pmex012"
            IF NOT cl_null(g_master.pmex012) THEN
               IF g_master.pmex012 <> g_master_o.pmex012 OR cl_null(g_master_o.pmex012) THEN
                  IF NOT cl_null(g_master.pmex011) THEN
                     #截止日期不可小於起始日期,請檢查！
                     IF g_master.pmex012 < g_master.pmex011  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.pmex012
                        LET g_errparam.code   = 'agl-00117'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.pmex012 = g_master_o.pmex012
                        DISPLAY BY NAME g_master.pmex012
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.pmex012 = g_master.pmex012
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmex012
            #add-point:ON CHANGE pmex012 name="input.g.pmex012"
            
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
 
 
 
                     #Ctrlp:input.c.pmevdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmevdocno
            #add-point:ON ACTION controlp INFIELD pmevdocno name="input.c.pmevdocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.pmevdocno      #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.where = " pmevstus NOT IN ('C','N','X')"  #160809-00030#1-add

            CALL q_pmevdocno()                                #呼叫開窗

            LET g_master.pmevdocno = g_qryparam.return1              
            DISPLAY g_master.pmevdocno TO pmevdocno              
            NEXT FIELD pmevdocno                              #返回原欄位

            #END add-point
 
 
         #Ctrlp:input.c.pmexseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmexseq
            #add-point:ON ACTION controlp INFIELD pmexseq name="input.c.pmexseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmex010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmex010
            #add-point:ON ACTION controlp INFIELD pmex010 name="input.c.pmex010"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmex011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmex011
            #add-point:ON ACTION controlp INFIELD pmex011 name="input.c.pmex011"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmex012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmex012
            #add-point:ON ACTION controlp INFIELD pmex012 name="input.c.pmex012"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.chk"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
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
            CALL apmp430_get_buffer(l_dialog)
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
         CALL apmp430_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.pmevdocno = g_master.pmevdocno
      LET lc_param.pmexseq   = g_master.pmexseq
      LET lc_param.pmex010   = g_master.pmex010
      LET lc_param.pmex011    = g_master.pmex011
      LET lc_param.pmex012    = g_master.pmex012
      LET lc_param.chk       = g_master.chk
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
                 CALL apmp430_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp430_transfer_argv(ls_js)
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
 
{<section id="apmp430.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp430_transfer_argv(ls_js)
 
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
 
{<section id="apmp430.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp430_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_value       STRING
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE l_sql         STRING
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_cnt1        LIKE type_t.num5
   DEFINE l_cnt2        LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sum         LIKE pmey_t.pmey001
   DEFINE l_xrcd113     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115     LIKE xrcd_t.xrcd115
   DEFINE l_pm    RECORD
       pmev003    LIKE pmev_t.pmev003,
       pmev007    LIKE pmev_t.pmev007,
       pmev019    LIKE pmev_t.pmev019,
       pmdssite   LIKE pmds_t.pmdssite,
       pmdsdocno  LIKE pmds_t.pmdsdocno,
       pmds000    LIKE pmds_t.pmds000,
       pmds007    LIKE pmds_t.pmds007,      #採購供應商
       pmds037    LIKE pmds_t.pmds037,      #幣別
       pmds038    LIKE pmds_t.pmds038,      #匯率
       pmdtseq    LIKE pmdt_t.pmdtseq,      #項次
       pmdt001    LIKE pmdt_t.pmdt001,      #採購單號
       pmdt002    LIKE pmdt_t.pmdt002,      #採購項次
       pmdt006    LIKE pmdt_t.pmdt006,      #料件編號
       pmdt007    LIKE pmdt_t.pmdt007,      #產品特徵
       pmdt023    LIKE pmdt_t.pmdt023,      #計價單位
       pmdt024    LIKE pmdt_t.pmdt024,      #計價數量
       pmdt036    LIKE pmdt_t.pmdt036,      #單價
       pmdt046    LIKE pmdt_t.pmdt046,      #稅別
       pmdt038    LIKE pmdt_t.pmdt038,      #未稅金額
       pmdt039    LIKE pmdt_t.pmdt039,      #含稅金額
       pmdt047    LIKE pmdt_t.pmdt047       #稅額
              END RECORD
   DEFINE l_pmex  RECORD                  #採購折扣合約單明細檔
       pmexseq    LIKE pmex_t.pmexseq,    #項次
       pmex001    LIKE pmex_t.pmex001,    #類型
       pmex002    LIKE pmex_t.pmex002,    #資料編號
       pmex003    LIKE pmex_t.pmex003,    #產品特徵
       pmex005    LIKE pmex_t.pmex005,    #折扣方式
       pmex006    LIKE pmex_t.pmex006,    #計價單位
       pmex007    LIKE pmex_t.pmex007,    #單價
       pmex008    LIKE pmex_t.pmex008,    #折扣率
       pmex009    LIKE pmex_t.pmex009     #分段折扣否
              END RECORD
   DEFINE l_pmeo  RECORD                  #採購合約/核價結算來源單據明細檔
       pmeoent    LIKE pmeo_t.pmeoent,    #企業編號
       pmeosite   LIKE pmeo_t.pmeosite,   #營運據點
       pmeo000    LIKE pmeo_t.pmeo000,    #資料類型
       pmeo001    LIKE pmeo_t.pmeo001,    #合約/核價單號	
       pmeo002    LIKE pmeo_t.pmeo002,    #項次
       pmeo003    LIKE pmeo_t.pmeo003,    #關聯單號
       pmeo004    LIKE pmeo_t.pmeo004,    #關聯項次
       pmeo005    LIKE pmeo_t.pmeo005,    #結算日期
       pmeo006    LIKE pmeo_t.pmeo006,    #料件編號
       pmeo007    LIKE pmeo_t.pmeo007,    #產品特徵
       pmeo008    LIKE pmeo_t.pmeo008,    #交易數量
       pmeo009    LIKE pmeo_t.pmeo009,    #交易單位
       pmeo010    LIKE pmeo_t.pmeo010,    #原始單價
       pmeo011    LIKE pmeo_t.pmeo011,    #原始未稅金額
       pmeo012    LIKE pmeo_t.pmeo012,    #原始含稅金額
       pmeo013    LIKE pmeo_t.pmeo013,    #原始稅額
       pmeo014    LIKE pmeo_t.pmeo014,    #建議調整後未稅金額
       pmeo015    LIKE pmeo_t.pmeo015,    #建議調整後含稅金額
       pmeo016    LIKE pmeo_t.pmeo016,    #建議調整後稅額
       pmeo017    LIKE pmeo_t.pmeo017,    #差異未稅金額
       pmeo018    LIKE pmeo_t.pmeo018,    #差異含稅金額
       pmeo019    LIKE pmeo_t.pmeo019,    #差異稅額
       pmeo020    LIKE pmeo_t.pmeo020,    #差異數量
       pmeo021    LIKE pmeo_t.pmeo021,    #差異數量的單價
       pmeo022    LIKE pmeo_t.pmeo022,    #來源單號
       pmeo023    LIKE pmeo_t.pmeo023,    #來源項次
       pmeo024    LIKE pmeo_t.pmeo024,    #來源據點
       pmeo025    LIKE pmeo_t.pmeo025,    #差異處理否
       pmeo026    LIKE pmeo_t.pmeo026,    #差異處理方式
       pmeo029    LIKE pmeo_t.pmeo029     #建議調整後單價
              END RECORD
   DEFINE l_pmev007  LIKE pmev_t.pmev007
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"

   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = TRUE
   
   #依據UI畫面條件查詢出符合條件的採購折扣合約單
   #依查詢出的合約單找出對應的入庫單/倉退單資料
   LET l_sql = "   FROM pmev_t,pmds_t,pmdt_t ",
               "  WHERE pmevent = '",g_enterprise,"' ",
               "    AND pmevsite = '",g_site,"' ",
               "    AND pmevstus = 'Y' ",
               "    AND pmevdocno = '",lc_param.pmevdocno,"' ",
               "    AND (pmev013 = 'N' OR (pmev013 = 'Y' AND pmev004 = pmds037)) ",  #限定幣別
               "    AND (pmev014 = 'N' OR (pmev014 = 'Y' AND pmev005 = pmdt046)) ",  #限定稅別
               "    AND (pmev015 = 'N' OR (pmev015 = 'Y' AND pmev008 = pmds031)) ",  #限定付款條件否
               "    AND (pmev016 = 'N' OR (pmev016 = 'Y' AND pmev009 = pmds032)) ",  #限定交易條件否
               "    AND (pmev017 = 'N' OR (pmev017 = 'Y' AND pmev010 = pmds012)) ",  #限定採購通路
               "    AND ((pmev018 = 'Y' AND pmds000 = '7' AND pmdsstus = 'S' AND pmds054 = '1') ",   #倉退單
               "          OR  (pmds000 IN ('3','4','6') AND pmdsstus = 'S') )",                       #入庫單
               #"    AND pmds001 BETWEEN '",lc_param.pmex011,"' AND '",lc_param.pmex012,"' ",
               "    AND pmdsent = pmevent ",
               "    AND pmdssite = pmevsite ",
               "    AND pmdtent = pmdsent ",
               "    AND pmdtdocno = pmdsdocno ",
               "    AND pmdtdocno||pmdtseq NOT IN (SELECT pmeo003||pmeo004 ",
               "                                     FROM pmeo_t ",
               "                                    WHERE pmeo000 = '3' ",
               "                                      AND pmeoent = pmdtent ",
               "                                      AND pmeosite = pmdtsite)"
   IF NOT cl_null(lc_param.pmex011) THEN 
      LET l_sql = l_sql," AND pmds001 >= '",lc_param.pmex011,"'"
   END IF
   IF NOT cl_null(lc_param.pmex012) THEN 
      LET l_sql = l_sql," AND pmds001 <= '",lc_param.pmex012,"'"
   END IF   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET ls_sql = " SELECT COUNT(DISTINCT pmdtseq) ",l_sql
      PREPARE apmp430_process_count FROM ls_sql
      LET li_count = 0
      EXECUTE apmp430_process_count INTO li_count
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp430_process_cs CURSOR FROM ls_sql
#  FOREACH apmp430_process_cs INTO
   #add-point:process段process name="process.process"

   LET ls_sql = " SELECT pmev003,pmev007,pmev019,pmdssite,pmdsdocno,pmds000, ",
                #        採購供應商,幣別,  匯率,   項次,   採購單號,
                "        pmds007,pmds037,pmds038,pmdtseq,pmdt001, ",
                #        採購項次,料件編號,產品特徵,計價單位,計價數量
                "        pmdt002,pmdt006,pmdt007,pmdt023,pmdt024, ",
                #        單價,    稅別  , 未稅金額,含稅金額,稅額
                "        pmdt036,pmdt046,pmdt038,pmdt039,pmdt047 ",l_sql
   PREPARE apmp430_process_bp FROM ls_sql
   DECLARE apmp430_process_cs CURSOR FOR apmp430_process_bp
   
   LET l_sql = " SELECT pmexseq,pmex001,pmex002,pmex003,pmex005,pmex006,pmex007,pmex008,pmex009 ",
               "   FROM pmex_t ",
               "  WHERE pmexent = '",g_enterprise,"' ",
               "    AND pmexdocno = '",lc_param.pmevdocno,"' "
   #項次不輸入時代表是整張合約同時結算
   IF NOT cl_null(lc_param.pmexseq) THEN
      LET l_sql = l_sql," AND pmexseq = '",lc_param.pmexseq,"' "
   END IF
   LET l_sql = l_sql," ORDER BY pmex001,pmex002 "
   PREPARE apmp430_process_pmex_1_bp FROM l_sql
   DECLARE apmp430_process_pmex_1_cs CURSOR FOR apmp430_process_pmex_1_bp
   
   #將每一筆結算單據(入庫單/倉退單)資料產生到pmeo_t(合約結算明細檔)中
   LET l_sql = " INSERT INTO pmeo_t ",
               " (pmeoent,pmeosite,pmeo000, ",
               "  pmeo001,pmeo002,pmeo003,pmeo004,pmeo005, ",
               "  pmeo006,pmeo007,pmeo008,pmeo009,pmeo010, ",
               "  pmeo011,pmeo012,pmeo013,pmeo014,pmeo015, ",
               "  pmeo016,pmeo017,pmeo018,pmeo019,pmeo020, ",
               "  pmeo021,pmeo022,pmeo023,pmeo024,pmeo025, ",
               "  pmeo026,pmeo029) ",
               " values(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ",
               "        ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) "
   PREPARE apmp430_process_insert_pmeo_pre FROM l_sql
   
   LET l_cnt1 = 0
   INITIALIZE l_pm.* TO NULL
   FOREACH apmp430_process_cs INTO l_pm.pmev003,l_pm.pmev007,l_pm.pmev019,l_pm.pmdssite,l_pm.pmdsdocno,l_pm.pmds000,
                                   l_pm.pmds007,l_pm.pmds037,l_pm.pmds038,l_pm.pmdtseq,l_pm.pmdt001,
                                   l_pm.pmdt002,l_pm.pmdt006,l_pm.pmdt007,l_pm.pmdt023,l_pm.pmdt024,
                                   l_pm.pmdt036,l_pm.pmdt046,l_pm.pmdt038,l_pm.pmdt039,l_pm.pmdt047
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      IF g_bgjob <> "Y" THEN
         #更新本期合約單號：%1／項次：%2的銷售合約結算歷程檔。
         LET ls_value = cl_getmsg_parm('apm-00975',g_lang,l_pm.pmdsdocno ||'|'|| l_pm.pmdtseq)
         CALL cl_progress_no_window_ing(ls_value)
         #end add-point
      END IF      

      #限制結算對象範圍
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmew_t
       WHERE pmewent = g_enterprise
         AND pmewdocno = lc_param.pmevdocno
      IF l_cnt > 0 THEN
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM pmew_t
          WHERE pmewent = g_enterprise
            AND pmewdocno = lc_param.pmevdocno
            AND pmew001 = l_pm.pmds007 
         IF l_cnt = 0 AND (NOT cl_null(l_pm.pmev003) AND l_pm.pmev003 <> l_pm.pmds007) THEN
            CONTINUE FOREACH
         END IF
      ELSE   
         #指定帳款客戶
         IF NOT cl_null(l_pm.pmev003) AND l_pm.pmev003 <> l_pm.pmds007 THEN
            CONTINUE FOREACH
         END IF         
      END IF
      
      LET l_cnt2 = 0
      INITIALIZE l_pmex.* TO NULL
      FOREACH apmp430_process_pmex_1_cs INTO l_pmex.pmexseq,l_pmex.pmex001,l_pmex.pmex002,l_pmex.pmex003,
                                             l_pmex.pmex005,l_pmex.pmex006,l_pmex.pmex007,l_pmex.pmex008,
                                             l_pmex.pmex009
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
　　     #抓取入庫單/倉退單的料件需要需要符合折扣合約上的指定的資料範圍
         CASE l_pmex.pmex001  #資料類型
            WHEN '1'  #料號
               IF cl_null(l_pmex.pmex003) THEN
                  IF l_pm.pmdt006 <> l_pmex.pmex002 THEN
                     CONTINUE FOREACH
                  END IF
               ELSE
                  IF l_pm.pmdt006 <> l_pmex.pmex002 OR (l_pm.pmdt007 <> l_pmex.pmex003) THEN
                     CONTINUE FOREACH
                  END IF
               END IF
            WHEN '2'  #產品分類
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = l_pm.pmdt006
                  AND imaa009 = l_pmex.pmex002
               IF l_cnt = 0 THEN
                  CONTINUE FOREACH
               END IF
            WHEN '3'  #系列號
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = l_pm.pmdt006
                  AND imaa127 = l_pmex.pmex002
               IF l_cnt = 0 THEN
                  CONTINUE FOREACH
               END IF
            OTHERWISE EXIT CASE
         END CASE
       
         INITIALIZE l_pmeo.* TO NULL
         LET l_pmeo.pmeoent  = g_enterprise
         LET l_pmeo.pmeosite = g_site
         LET l_pmeo.pmeo000  = '3'
         LET l_pmeo.pmeo001  = lc_param.pmevdocno     #合約/核價單號
         LET l_pmeo.pmeo002  = l_pmex.pmexseq         #項次
         LET l_pmeo.pmeo003  = l_pm.pmdsdocno         #關聯單號
         LET l_pmeo.pmeo004  = l_pm.pmdtseq           #關聯項次
         LET l_pmeo.pmeo005  = lc_param.pmex010       #結算日期
         LET l_pmeo.pmeo006  = l_pm.pmdt006           #料件編號
         LET l_pmeo.pmeo007  = l_pm.pmdt007           #產品特徵
         LET l_pmeo.pmeo008  = l_pm.pmdt024           #交易數量
         LET l_pmeo.pmeo009  = l_pm.pmdt023           #交易單位
         LET l_pmeo.pmeo010  = l_pm.pmdt036           #原始單價
         LET l_pmeo.pmeo011  = l_pm.pmdt038           #原始未稅金額
         LET l_pmeo.pmeo012  = l_pm.pmdt039           #原始含稅金額
         LET l_pmeo.pmeo013  = l_pm.pmdt047           #原始稅額
         LET l_pmeo.pmeo022  = l_pm.pmdt001           #來源單號
         LET l_pmeo.pmeo023  = l_pm.pmdt002           #來源項次
         LET l_pmeo.pmeo024  = l_pm.pmdssite
         LET l_pmeo.pmeo025  = '1'                    #差異處理否(0.不需要差異處理 1.未處理 2.已處理)
         LET l_pmeo.pmeo026  = l_pm.pmev019           #差異處理方式
         #差異數量
         IF l_pmex.pmex005 = '2' THEN  #金額百分比折扣
            LET l_pmeo.pmeo021 = 1
         ELSE       
            CALL s_aooi250_convert_qty(l_pmeo.pmeo006,l_pmeo.pmeo009,l_pmex.pmex006,l_pmeo.pmeo008) RETURNING g_success,l_pmeo.pmeo021         
            #LET l_pmeo.pmeo021 = l_pm.pmdt024
         END IF
         #建議調整後單價
         IF l_pmex.pmex009 = 'Y' THEN
            CASE l_pmex.pmex005  #折扣方式
               WHEN '1'  #單價折扣
                  LET l_pmeo.pmeo029  = l_pm.pmdt036
               WHEN '2'  #金額百分比折扣
                  IF l_pm.pmev007 = 'N' THEN  #未稅
                     LET l_pmeo.pmeo029  = l_pm.pmdt038
                  ELSE                        #含稅
                     LET l_pmeo.pmeo029  = l_pm.pmdt039
                  END IF
               WHEN '3'  #單價百分比折扣
                  LET l_pmeo.pmeo029  = l_pm.pmdt036
               OTHERWISE EXIT CASE
            END CASE
         ELSE
            CASE l_pmex.pmex005  #折扣方式
               WHEN '1'  #單價折扣
                  LET l_pmeo.pmeo029  = l_pmex.pmex007
               WHEN '2'  #金額百分比折扣
                  IF l_pm.pmev007 = 'N' THEN  #未稅
                     LET l_pmeo.pmeo029  = l_pm.pmdt038 * l_pmex.pmex008/100
                  ELSE                        #含稅
                     LET l_pmeo.pmeo029  = l_pm.pmdt039 * l_pmex.pmex008/100
                  END IF
               WHEN '3'  #單價百分比折扣
                  LET l_pmeo.pmeo029  = l_pm.pmdt036 * l_pmex.pmex008/100
               OTHERWISE EXIT CASE
            END CASE         
         END IF
         CALL s_tax_count(l_pm.pmdssite,l_pm.pmdt046,(l_pmeo.pmeo021*l_pmeo.pmeo029),l_pmeo.pmeo021,l_pm.pmds037,l_pm.pmds038)
              RETURNING l_pmeo.pmeo014,l_pmeo.pmeo016,l_pmeo.pmeo015,l_xrcd113,l_xrcd114,l_xrcd115
         LET l_pmeo.pmeo017 = l_pmeo.pmeo014          #差異未稅金額
         LET l_pmeo.pmeo018 = l_pmeo.pmeo015          #差異含稅金額
         LET l_pmeo.pmeo019 = l_pmeo.pmeo016          #差異稅額
         LET l_pmeo.pmeo020 = l_pmeo.pmeo029          #差異數量單價
         IF l_pm.pmds000 = '7' THEN 
            LET l_pmeo.pmeo008 = -1 * l_pmeo.pmeo008
            LET l_pmeo.pmeo011 = -1 * l_pmeo.pmeo011
            LET l_pmeo.pmeo012 = -1 * l_pmeo.pmeo012
            LET l_pmeo.pmeo013 = -1 * l_pmeo.pmeo013
            LET l_pmeo.pmeo014 = -1 * l_pmeo.pmeo014
            LET l_pmeo.pmeo015 = -1 * l_pmeo.pmeo015
            LET l_pmeo.pmeo016 = -1 * l_pmeo.pmeo016
            LET l_pmeo.pmeo017 = -1 * l_pmeo.pmeo017
            LET l_pmeo.pmeo018 = -1 * l_pmeo.pmeo018
            LET l_pmeo.pmeo019 = -1 * l_pmeo.pmeo019
            LET l_pmeo.pmeo021 = -1 * l_pmeo.pmeo021
         END IF
         EXECUTE apmp430_process_insert_pmeo_pre USING
                 l_pmeo.pmeoent,l_pmeo.pmeosite,l_pmeo.pmeo000,
                 l_pmeo.pmeo001,l_pmeo.pmeo002,l_pmeo.pmeo003,l_pmeo.pmeo004,l_pmeo.pmeo005,
                 l_pmeo.pmeo006,l_pmeo.pmeo007,l_pmeo.pmeo008,l_pmeo.pmeo009,l_pmeo.pmeo010,
                 l_pmeo.pmeo011,l_pmeo.pmeo012,l_pmeo.pmeo013,l_pmeo.pmeo014,l_pmeo.pmeo015,
                 l_pmeo.pmeo016,l_pmeo.pmeo017,l_pmeo.pmeo018,l_pmeo.pmeo019,l_pmeo.pmeo020,
                 l_pmeo.pmeo021,l_pmeo.pmeo022,l_pmeo.pmeo023,l_pmeo.pmeo024,l_pmeo.pmeo025,
                 l_pmeo.pmeo026,l_pmeo.pmeo029
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'ins pmeo_t'
            LET g_errparam.popup = TRUE
            LET l_success = FALSE
            CALL cl_err()
            EXIT FOREACH
         ELSE
            #將結算日期、起始日期、截止日期回寫回對應的合約單項次檔
            UPDATE pmex_t
               SET pmex010 = g_master.pmex010,
                   pmex011 = lc_param.pmex011,
                   pmex012 = lc_param.pmex012
             WHERE pmexent = g_enterprise
               AND pmexdocno = lc_param.pmevdocno
               AND pmexseq = l_pmex.pmexseq
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = 'upd pmex'
               LET g_errparam.popup = TRUE
               LET l_success = FALSE
               CALL cl_err()
               EXIT FOREACH
            ELSE
               LET l_cnt1 = l_cnt1 + 1
            END IF          
         END IF
      END FOREACH

   END FOREACH
   
   
   IF l_cnt1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE
      #分段折扣
      LET l_sql = " SELECT DISTINCT pmexseq,pmex005,pmev007 ",
                  "   FROM pmex_t,pmev_t ",
                  "  WHERE pmevent = pmexent AND pmevdocno=pmexdocno ",
                  "    AND pmexent = '",g_enterprise,"' ",
                  "    AND pmexdocno = '",lc_param.pmevdocno,"' ",
                  "    AND pmex010 = to_date('",lc_param.pmex010,"','YYYY-MM-DD hh24:mi:ss') ",
                  "    AND pmex009 = 'Y' "
      IF NOT cl_null(lc_param.pmexseq) THEN
         LET l_sql = l_sql," AND pmexseq = ",lc_param.pmexseq," "
      END IF
      PREPARE apmp430_process_pmex_2_bp FROM l_sql
      DECLARE apmp430_process_pmex_2_cs CURSOR FOR apmp430_process_pmex_2_bp
      
      INITIALIZE l_pmex.* TO NULL
      FOREACH apmp430_process_pmex_2_cs INTO l_pmex.pmexseq,l_pmex.pmex005,l_pmev007
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
                 
         IF l_pmex.pmex005 MATCHES '[23]' THEN  #金額百分比折扣,单价百分比折扣
            LET l_sum = 0
            IF l_pmev007 = 'Y' THEN
               SELECT SUM(pmeo012) INTO l_sum   #總出貨金額
                 FROM pmeo_t
                WHERE pmeoent = g_enterprise
                  AND pmeo000 = '3'
                  AND pmeo001 = lc_param.pmevdocno
                  AND pmeo002 = l_pmex.pmexseq
                  AND pmeo005 = lc_param.pmex010
            ELSE      
               SELECT SUM(pmeo011) INTO l_sum   #總出貨金額
                 FROM pmeo_t
                WHERE pmeoent = g_enterprise
                  AND pmeo000 = '3'
                  AND pmeo001 = lc_param.pmevdocno
                  AND pmeo002 = l_pmex.pmexseq
                  AND pmeo005 = lc_param.pmex010                  
            END IF   
         ELSE
            #總出貨數量
            LET l_sum = 0
            SELECT SUM(pmeo021) INTO l_sum
              FROM pmeo_t
             WHERE pmeoent = g_enterprise
               AND pmeo000 = '3'
               AND pmeo001 = lc_param.pmevdocno
               AND pmeo002 = l_pmex.pmexseq
               AND pmeo005 = lc_param.pmex010
         END IF
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM pmey_t
          WHERE pmeyent = g_enterprise
            AND pmeydocno = lc_param.pmevdocno
            AND pmeyseq = l_pmex.pmexseq
            AND pmey001 <= l_sum
            AND pmey002 >= l_sum         
         IF l_cnt = 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "apm-00980"
            LET g_errparam.extend = ''
            LET g_errparam.replace[1] = l_sum
            LET g_errparam.replace[2] = lc_param.pmevdocno
            LET g_errparam.replace[3] = l_pmex.pmexseq
            LET g_errparam.popup = TRUE
            LET l_success = FALSE
            CALL cl_err()   
            EXIT FOREACH             
         END IF
         
         INITIALIZE l_pmeo.* TO NULL
         DECLARE apmp430_process_pmeo_cs CURSOR FOR
            SELECT pmeo003,pmeo004,pmeo011,pmeo012,pmeo013,pmeo021,pmeo029,pmeo010
              FROM pmeo_t
             WHERE pmeoent = g_enterprise
               AND pmeo000 = '3'
               AND pmeo001 = lc_param.pmevdocno
               AND pmeo002 = l_pmex.pmexseq
               AND pmeo005 = lc_param.pmex010
         FOREACH apmp430_process_pmeo_cs INTO l_pmeo.pmeo003,l_pmeo.pmeo004,l_pmeo.pmeo011,l_pmeo.pmeo012,
                                              l_pmeo.pmeo013,l_pmeo.pmeo021,l_pmeo.pmeo029,l_pmeo.pmeo010
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            CASE l_pmex.pmex005 
               WHEN '1'  #單價折扣
                  SELECT pmey003 INTO l_pmeo.pmeo029
                    FROM pmey_t
                   WHERE pmeyent = g_enterprise
                     AND pmeydocno = lc_param.pmevdocno
                     AND pmeyseq = l_pmex.pmexseq
                     AND pmey001 <= l_sum
                     AND pmey002 >= l_sum
               WHEN '2'  #金額百分比折扣
                  IF l_pmev007 = 'N' THEN
                     SELECT (pmey004*l_pmeo.pmeo011/100) INTO l_pmeo.pmeo029
                       FROM pmey_t
                      WHERE pmeyent = g_enterprise
                        AND pmeydocno = lc_param.pmevdocno
                        AND pmeyseq = l_pmex.pmexseq
                        AND pmey001 <= l_sum
                        AND pmey002 >= l_sum
                  ELSE   
                     SELECT (pmey004*l_pmeo.pmeo012/100) INTO l_pmeo.pmeo029
                       FROM pmey_t
                      WHERE pmeyent = g_enterprise
                        AND pmeydocno = lc_param.pmevdocno
                        AND pmeyseq = l_pmex.pmexseq
                        AND pmey001 <= l_sum
                        AND pmey002 >= l_sum
                  END IF   
                  IF l_pmeo.pmeo029 < 0 THEN 
                     LET l_pmeo.pmeo029 = -1* l_pmeo.pmeo029
                  END IF
               WHEN '3'  #單價百分比折扣                  
                  SELECT (pmey004*l_pmeo.pmeo010/100) INTO l_pmeo.pmeo029
                    FROM pmey_t
                   WHERE pmeyent = g_enterprise
                     AND pmeydocno = lc_param.pmevdocno
                     AND pmeyseq = l_pmex.pmexseq
                     AND pmey001 <= l_sum
                     AND pmey002 >= l_sum

            END CASE
            CALL s_tax_count(l_pm.pmdssite,l_pm.pmdt046,(l_pmeo.pmeo021*l_pmeo.pmeo029),l_pmeo.pmeo021,l_pm.pmds037,l_pm.pmds038)
                 RETURNING l_pmeo.pmeo014,l_pmeo.pmeo016,l_pmeo.pmeo015,l_xrcd113,l_xrcd114,l_xrcd115
            LET l_pmeo.pmeo017 = l_pmeo.pmeo014
            LET l_pmeo.pmeo018 = l_pmeo.pmeo015
            LET l_pmeo.pmeo019 = l_pmeo.pmeo016
            LET l_pmeo.pmeo020 = l_pmeo.pmeo029
            
            UPDATE pmeo_t
               SET pmeo014 = l_pmeo.pmeo014,
                   pmeo015 = l_pmeo.pmeo015,
                   pmeo016 = l_pmeo.pmeo016,
                   pmeo017 = l_pmeo.pmeo017,
                   pmeo018 = l_pmeo.pmeo018,
                   pmeo019 = l_pmeo.pmeo019,
                   pmeo020 = l_pmeo.pmeo020,
                   pmeo029 = l_pmeo.pmeo029
             WHERE pmeoent = g_enterprise
               AND pmeo000 = '3'
               AND pmeo001 = lc_param.pmevdocno
               AND pmeo002 = l_pmex.pmexseq
               AND pmeo003 = l_pmeo.pmeo003
               AND pmeo004 = l_pmeo.pmeo004
               AND pmeo005 = lc_param.pmex010
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd pmeo"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
         END FOREACH
      END FOREACH
   END IF
   
   FREE apmp430_process_bp
   FREE apmp430_process_pmex_1_bp
   FREE apmp430_process_pmex_2_bp
   FREE apmp430_process_insert_pmeo_pre
   CALL cl_err_collect_show()   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
      CALL cl_ask_confirm3("adz-00218","")
      RETURN      
   END IF
   
   
   
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF lc_param.chk = 'Y' THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'apmp431'
         LET la_param.param[1] = lc_param.pmevdocno
         LET la_param.param[2] = lc_param.pmexseq
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apmp430_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp430.get_buffer" >}
PRIVATE FUNCTION apmp430_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pmevdocno = p_dialog.getFieldBuffer('pmevdocno')
   LET g_master.pmexseq = p_dialog.getFieldBuffer('pmexseq')
   LET g_master.pmex010 = p_dialog.getFieldBuffer('pmex010')
   LET g_master.pmex011 = p_dialog.getFieldBuffer('pmex011')
   LET g_master.pmex012 = p_dialog.getFieldBuffer('pmex012')
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmp430.msgcentre_notify" >}
PRIVATE FUNCTION apmp430_msgcentre_notify()
 
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
 
{<section id="apmp430.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
