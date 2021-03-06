#該程式未解開Section, 採用最新樣板產出!
{<section id="axmp430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-06-15 18:22:09), PR版次:0003(2016-06-21 15:37:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: axmp430
#+ Description: 銷售折扣結算作業
#+ Creator....: 04441(2015-06-09 16:02:19)
#+ Modifier...: 04441 -SD/PR- 02097
 
{</section>}
 
{<section id="axmp430.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#150708-00007#1    160621 By 02097  修改背景處理程式段
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
        xmfjdocno        LIKE xmfj_t.xmfjdocno,
        xmflseq          LIKE xmfl_t.xmflseq,
        xmfl010          LIKE xmfl_t.xmfl010,
        date_s           LIKE type_t.chr500,
        date_e           LIKE type_t.chr500,
        chk              LIKE type_t.chr500,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       xmfjdocno LIKE xmfj_t.xmfjdocno, 
   xmflseq LIKE type_t.chr500, 
   xmfl010 LIKE xmfl_t.xmfl010, 
   date_s LIKE type_t.dat, 
   date_e LIKE type_t.dat, 
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
 
{<section id="axmp430.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL axmp430_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmp430 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmp430_init()
 
      #進入選單 Menu (="N")
      CALL axmp430_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmp430
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmp430.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmp430_init()
 
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
 
{<section id="axmp430.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmp430_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
DEFINE l_xmfl010   LIKE xmfl_t.xmfl010
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.xmflseq = ''
   LET g_master.xmfl010 = g_today
   LET g_master.date_s = ''
   LET g_master.date_e = g_master.xmfl010
   LET g_master.chk = 'Y'

   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xmfjdocno,g_master.xmflseq,g_master.xmfl010,g_master.date_s,g_master.date_e, 
             g_master.chk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master_o.* = g_master.*
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfjdocno
            
            #add-point:AFTER FIELD xmfjdocno name="input.a.xmfjdocno"
            IF NOT cl_null(g_master.xmfjdocno) THEN
               IF g_master.xmfjdocno <> g_master_o.xmfjdocno OR cl_null(g_master_o.xmfjdocno) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xmfjdocno
                  IF NOT cl_chk_exist("v_xmfjdocno") THEN
                     LET g_master.xmfjdocno = g_master_o.xmfjdocno
                     DISPLAY BY NAME g_master.xmfjdocno
                     NEXT FIELD CURRENT
                  END IF
                  LET g_master.xmfl010 = g_today
                  LET g_master_o.xmfl010 = g_master.xmfl010
                  LET g_master.date_e = g_master.xmfl010
                  LET g_master_o.date_e = g_master.date_e
               END IF
            END IF
            LET g_master_o.xmfjdocno = g_master.xmfjdocno
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfjdocno
            #add-point:BEFORE FIELD xmfjdocno name="input.b.xmfjdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfjdocno
            #add-point:ON CHANGE xmfjdocno name="input.g.xmfjdocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmflseq
            
            #add-point:AFTER FIELD xmflseq name="input.a.xmflseq"
            IF NOT cl_null(g_master.xmflseq) THEN
               IF g_master.xmflseq <> g_master_o.xmflseq OR cl_null(g_master_o.xmflseq) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xmfjdocno
                  LET g_chkparam.arg2 = g_master.xmflseq
                  IF NOT cl_chk_exist("v_xmflseq") THEN
                     LET g_master.xmflseq = g_master_o.xmflseq
                     DISPLAY BY NAME g_master.xmflseq
                     NEXT FIELD CURRENT
                  END IF
                  LET g_master.xmfl010 = g_today
                  LET g_master_o.xmfl010 = g_master.xmfl010
                  LET g_master.date_e = g_master.xmfl010
                  LET g_master_o.date_e = g_master.date_e
               END IF
            END IF
            LET g_master_o.xmflseq = g_master.xmflseq
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmflseq
            #add-point:BEFORE FIELD xmflseq name="input.b.xmflseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmflseq
            #add-point:ON CHANGE xmflseq name="input.g.xmflseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmfl010
            #add-point:BEFORE FIELD xmfl010 name="input.b.xmfl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmfl010
            
            #add-point:AFTER FIELD xmfl010 name="input.a.xmfl010"
            IF NOT cl_null(g_master.xmfl010) THEN
               IF g_master.xmfl010 <> g_master_o.xmfl010 OR cl_null(g_master_o.xmfl010) THEN
                  LET l_xmfl010 = ''
                  IF cl_null(g_master.xmflseq) THEN
                     SELECT MIN(xmfl010) INTO l_xmfl010
                       FROM xmfl_t
                      WHERE xmflent = g_enterprise
                        AND xmfldocno = g_master.xmfjdocno
                  ELSE
                     SELECT MIN(xmfl010) INTO l_xmfl010
                       FROM xmfl_t
                      WHERE xmflent = g_enterprise
                        AND xmfldocno = g_master.xmfjdocno
                        AND xmflseq = g_master.xmflseq
                  END IF
                  #不可以小於該合約上記錄的最近結算日期
                  IF g_master.xmfl010 <= l_xmfl010 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = l_xmfl010
                     LET g_errparam.code   = 'axm-00665'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET g_master.xmfl010 = g_master_o.xmfl010
                     DISPLAY BY NAME g_master.xmfl010
                     NEXT FIELD CURRENT
                  END IF
                  LET g_master.date_e = g_master.xmfl010
                  LET g_master_o.date_e = g_master.date_e
               END IF
            END IF
            LET g_master_o.xmfl010 = g_master.xmfl010
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmfl010
            #add-point:ON CHANGE xmfl010 name="input.g.xmfl010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date_s
            #add-point:BEFORE FIELD date_s name="input.b.date_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date_s
            
            #add-point:AFTER FIELD date_s name="input.a.date_s"
            IF NOT cl_null(g_master.date_s) THEN
               IF g_master.date_s <> g_master_o.date_s OR cl_null(g_master_o.date_s) THEN
                  IF NOT cl_null(g_master.date_e) THEN
                     #起始日期不可大於截止日期,請檢查！
                     IF g_master.date_e < g_master.date_s  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.date_e
                        LET g_errparam.code   = 'agl-00116'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.date_s = g_master_o.date_s
                        DISPLAY BY NAME g_master.date_s
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.date_s = g_master.date_s
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date_s
            #add-point:ON CHANGE date_s name="input.g.date_s"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD date_e
            #add-point:BEFORE FIELD date_e name="input.b.date_e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD date_e
            
            #add-point:AFTER FIELD date_e name="input.a.date_e"
            IF NOT cl_null(g_master.date_e) THEN
               IF g_master.date_e <> g_master_o.date_e OR cl_null(g_master_o.date_e) THEN
                  IF NOT cl_null(g_master.date_s) THEN
                     #截止日期不可小於起始日期,請檢查！
                     IF g_master.date_e < g_master.date_s  THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = g_master.date_s
                        LET g_errparam.code   = 'agl-00117'
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        LET g_master.date_e = g_master_o.date_e
                        DISPLAY BY NAME g_master.date_e
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            LET g_master_o.date_e = g_master.date_e
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE date_e
            #add-point:ON CHANGE date_e name="input.g.date_e"
            
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
 
 
 
                     #Ctrlp:input.c.xmfjdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfjdocno
            #add-point:ON ACTION controlp INFIELD xmfjdocno name="input.c.xmfjdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmfjdocno
            LET g_qryparam.arg1 = g_ooef019
            CALL q_xmfjdocno_1()
            LET g_master.xmfjdocno = g_qryparam.return1              
            DISPLAY g_master.xmfjdocno TO xmfjdocno
            NEXT FIELD xmfjdocno

            #END add-point
 
 
         #Ctrlp:input.c.xmflseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmflseq
            #add-point:ON ACTION controlp INFIELD xmflseq name="input.c.xmflseq"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.xmflseq
            LET g_qryparam.arg1 = g_master.xmfjdocno
            CALL q_xmflseq()
            LET g_master.xmflseq = g_qryparam.return1              
            DISPLAY g_master.xmflseq TO xmflseq
            NEXT FIELD xmflseq
            #END add-point
 
 
         #Ctrlp:input.c.xmfl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmfl010
            #add-point:ON ACTION controlp INFIELD xmfl010 name="input.c.xmfl010"
            
            #END add-point
 
 
         #Ctrlp:input.c.date_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date_s
            #add-point:ON ACTION controlp INFIELD date_s name="input.c.date_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.date_e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD date_e
            #add-point:ON ACTION controlp INFIELD date_e name="input.c.date_e"
            
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
            CALL axmp430_get_buffer(l_dialog)
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
         CALL axmp430_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.xmfjdocno = g_master.xmfjdocno
      LET lc_param.xmflseq   = g_master.xmflseq
      LET lc_param.xmfl010   = g_master.xmfl010
      LET lc_param.date_s    = g_master.date_s
      LET lc_param.date_e    = g_master.date_e
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
                 CALL axmp430_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmp430_transfer_argv(ls_js)
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
 
{<section id="axmp430.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmp430_transfer_argv(ls_js)
 
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
 
{<section id="axmp430.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmp430_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
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
#   DEFINE l_xmda021     LIKE xmda_t.xmda021  #帳款客戶
   DEFINE l_xmda034     LIKE xmda_t.xmda034  #最終客戶
   DEFINE l_xmfm001     LIKE xmfm_t.xmfm001  #起始數量/金額
   DEFINE l_sum         LIKE xmfm_t.xmfm001
   DEFINE l_xrcd113     LIKE xrcd_t.xrcd113
   DEFINE l_xrcd114     LIKE xrcd_t.xrcd114
   DEFINE l_xrcd115     LIKE xrcd_t.xrcd115
   DEFINE l_xm    RECORD
       xmfj003    LIKE xmfj_t.xmfj003,
       xmfj007    LIKE xmfj_t.xmfj007,
       xmfj019    LIKE xmfj_t.xmfj019,
       xmdksite   LIKE xmdk_t.xmdksite,
       xmdkdocno  LIKE xmdk_t.xmdkdocno,
       xmdk000    LIKE xmdk_t.xmdk000,   #2015/08/04 by stellar add
       xmdk006    LIKE xmdk_t.xmdk006,
       xmdk007    LIKE xmdk_t.xmdk007,
       xmdk016    LIKE xmdk_t.xmdk016,
       xmdk017    LIKE xmdk_t.xmdk017,
       xmdlseq    LIKE xmdl_t.xmdlseq,
       xmdl004    LIKE xmdl_t.xmdl004,
       xmdl008    LIKE xmdl_t.xmdl008,
       xmdl009    LIKE xmdl_t.xmdl009,
       xmdl021    LIKE xmdl_t.xmdl021,
       xmdl022    LIKE xmdl_t.xmdl022,
       xmdl024    LIKE xmdl_t.xmdl024,
       xmdl025    LIKE xmdl_t.xmdl025,
       xmdl027    LIKE xmdl_t.xmdl027,
       xmdl028    LIKE xmdl_t.xmdl028,
       xmdl029    LIKE xmdl_t.xmdl029
              END RECORD
   DEFINE l_xmfl  RECORD                  #銷售折扣合約單明細檔
       xmflseq    LIKE xmfl_t.xmflseq,    #項次
       xmfl001    LIKE xmfl_t.xmfl001,    #類型
       xmfl002    LIKE xmfl_t.xmfl002,    #資料編號
       xmfl003    LIKE xmfl_t.xmfl003,    #產品特徵
       xmfl005    LIKE xmfl_t.xmfl005,    #折扣方式
       xmfl007    LIKE xmfl_t.xmfl007,    #單價
       xmfl008    LIKE xmfl_t.xmfl008     #折扣率
              END RECORD
   DEFINE l_xmde  RECORD                  #銷售合約/核價結算來源單據明細檔
       xmdeent    LIKE xmde_t.xmdeent,    #企業編號
       xmdesite   LIKE xmde_t.xmdesite,   #營運據點
       xmde000    LIKE xmde_t.xmde000,    #資料類型
       xmde001    LIKE xmde_t.xmde001,    #合約/核價單號	
       xmde002    LIKE xmde_t.xmde002,    #項次
       xmde003    LIKE xmde_t.xmde003,    #關聯單號
       xmde004    LIKE xmde_t.xmde004,    #關聯項次
       xmde005    LIKE xmde_t.xmde005,    #結算日期
       xmde006    LIKE xmde_t.xmde006,    #料件編號
       xmde007    LIKE xmde_t.xmde007,    #產品特徵
       xmde008    LIKE xmde_t.xmde008,    #交易數量
       xmde009    LIKE xmde_t.xmde009,    #交易單位
       xmde010    LIKE xmde_t.xmde010,    #原始單價
       xmde011    LIKE xmde_t.xmde011,    #原始未稅金額
       xmde012    LIKE xmde_t.xmde012,    #原始含稅金額
       xmde013    LIKE xmde_t.xmde013,    #原始稅額
       xmde014    LIKE xmde_t.xmde014,    #建議調整後未稅金額
       xmde015    LIKE xmde_t.xmde015,    #建議調整後含稅金額
       xmde016    LIKE xmde_t.xmde016,    #建議調整後稅額
       xmde017    LIKE xmde_t.xmde017,    #差異未稅金額
       xmde018    LIKE xmde_t.xmde018,    #差異含稅金額
       xmde019    LIKE xmde_t.xmde019,    #差異稅額
       xmde020    LIKE xmde_t.xmde020,    #差異數量
       xmde021    LIKE xmde_t.xmde021,    #差異數量的單價
       xmde022    LIKE xmde_t.xmde022,    #來源單號
       xmde023    LIKE xmde_t.xmde023,    #來源項次
       xmde024    LIKE xmde_t.xmde024,    #來源據點
       xmde025    LIKE xmde_t.xmde025,    #差異處理否
       xmde026    LIKE xmde_t.xmde026,    #差異處理方式
       xmde029    LIKE xmde_t.xmde029     #建議調整後單價
              END RECORD
   DEFINE l_xmfj007    LIKE xmfj_t.xmfj007   #2015/08/04 by stellar add
   DEFINE l_price      LIKE xmde_t.xmde011   #2015/08/04 by stellar add
   DEFINE l_sum1       LIKE xmfm_t.xmfm001   #2015/08/04 by stellar add
   DEFINE l_continue   LIKE type_t.num5      #2015/08/05 by stellar add
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
   
   #依據UI畫面條件查詢出符合條件的銷售折扣合約單
   #依查詢出的合約單找出對應的一般出貨單、簽收單、銷退單資料
   LET l_sql = "   FROM xmfj_t,xmdk_t,xmdl_t ",
               "  WHERE xmfjent = '",g_enterprise,"' ",
               "    AND xmfjsite = '",g_site,"' ",
               "    AND xmfjstus = 'Y' ",
               "    AND xmfjdocno = '",lc_param.xmfjdocno,"' ",
               "    AND (xmfj013 = 'N' OR (xmfj013 = 'Y' AND xmfj004 = xmdk016)) ",  #限定幣別
               "    AND (xmfj014 = 'N' OR (xmfj014 = 'Y' AND xmfj005 = xmdl025)) ",  #限定稅別
               "    AND (xmfj015 = 'N' OR (xmfj015 = 'Y' AND xmfj008 = xmdk010)) ",  #限定收款條件否
               "    AND (xmfj016 = 'N' OR (xmfj016 = 'Y' AND xmfj009 = xmdk011)) ",  #限定交易條件否
               "    AND (xmfj017 = 'N' OR (xmfj017 = 'Y' AND xmfj010 = xmdk030)) ",  #限定銷售通路
               "    AND ((xmfj018 = 'N' AND xmdk000 <> '6') ",                       #銷退是否納入計算
               "     OR  (xmfj018 = 'Y' AND xmdk000 = '6' AND xmdkstus = 'S') ",             #銷退
               #2015/08/04 by stellar modify ----- (S)
               "     OR  (xmdk000 IN ('1','2','3') AND xmdk002 = '1' AND xmdkstus = 'S' AND xmdk002 <> '4') ",  #出貨
               "     OR  (xmdk000 = '4' AND xmdk002 = '3' AND xmdkstus = 'Y' AND xmdk002 <> '4')) ",            #簽收
#               "     OR  (xmdk000 IN ('1','2','3') AND xmdk002 = '1' AND xmdkstus = 'S') ",  #出貨
#               "     OR  (xmdk000 = '4' AND xmdk002 = '3' AND xmdkstus = 'Y')) ",            #簽收
#               "    AND xmdk002 <> '4' ",                                                    #調撥
               #2015/08/04 by stellar modify ----- (E)
               "    AND xmdk001 BETWEEN '",lc_param.date_s,"' AND '",lc_param.date_e,"' ",
               "    AND xmdkent = xmfjent ",
               "    AND xmdksite = xmfjsite ",
               "    AND xmdlent = xmdkent ",
               "    AND xmdldocno = xmdkdocno ",
               "    AND xmdldocno||xmdlseq NOT IN (SELECT xmde003||xmde004 ",
               "                                     FROM xmde_t ",
               "                                    WHERE xmde000 = '3' ",
               "                                      AND xmdeent = xmdlent ",
               "                                      AND xmdesite = xmdlsite)",
               #2015/08/05 by stellar add ----- (S)
               #折扣合約的生失效日期
               "    AND xmfj011 <= xmdk001 ",
               "    AND (xmfj012 IS NULL OR xmfj012 > xmdk001) ",
               #2015/08/05 by stellar add ----- (E)
               "    ORDER BY xmdk001 "
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET ls_sql = " SELECT COUNT(DISTINCT xmdlseq) ",l_sql
      PREPARE axmp430_process_count FROM ls_sql
      LET li_count = 0
      EXECUTE axmp430_process_count INTO li_count
      CALL cl_progress_bar_no_window(li_count)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axmp430_process_cs CURSOR FROM ls_sql
#  FOREACH axmp430_process_cs INTO
   #add-point:process段process name="process.process"

   LET ls_sql = " SELECT xmfj003,xmfj007,xmfj019,xmdksite,xmdkdocno, ",
                "        xmdk000, ",   #2015/08/04 by stellar add
                "        xmdk006,xmdk007,xmdk016,xmdk017,xmdlseq, ",
                "        xmdl004,xmdl008,xmdl009,xmdl021,xmdl022, ",
                "        xmdl024,xmdl025,xmdl027,xmdl028,xmdl029 ",l_sql
   PREPARE axmp430_process_bp FROM ls_sql
   DECLARE axmp430_process_cs CURSOR FOR axmp430_process_bp
   
   LET l_sql = " SELECT xmflseq,xmfl001,xmfl002,xmfl003,xmfl005,xmfl007,xmfl008 ",
               "   FROM xmfl_t ",
               "  WHERE xmflent = '",g_enterprise,"' ",
               "    AND xmfldocno = '",lc_param.xmfjdocno,"' "
   #項次不輸入時代表是整張合約同時結算
   IF NOT cl_null(lc_param.xmflseq) THEN
      LET l_sql = l_sql," AND xmflseq = '",lc_param.xmflseq,"' "
   END IF
   LET l_sql = l_sql," ORDER BY xmfl001 "
   PREPARE axmp430_process_xmfl_1_bp FROM l_sql
   DECLARE axmp430_process_xmfl_1_cs CURSOR FOR axmp430_process_xmfl_1_bp
   
   #將每一筆結算單據(一般出貨單、簽收單、銷退單)資料產生到xmde_t(合約結算明細檔)中
   LET l_sql = " INSERT INTO xmde_t ",
               " (xmdeent,xmdesite,xmde000, ",
               "  xmde001,xmde002,xmde003,xmde004,xmde005, ",
               "  xmde006,xmde007,xmde008,xmde009,xmde010, ",
               "  xmde011,xmde012,xmde013,xmde014,xmde015, ",
               "  xmde016,xmde017,xmde018,xmde019,xmde020, ",
               "  xmde021,xmde022,xmde023,xmde024,xmde025, ",
               "  xmde026,xmde029) ",
               " values(?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?, ",
               "        ?,?,?,?,?, ?,?,?,?,?, ?,?,?,?,?) "
   PREPARE axmp430_process_insert_xmde_pre FROM l_sql
   
   LET l_cnt1 = 0
   INITIALIZE l_xm.* TO NULL
   FOREACH axmp430_process_cs INTO l_xm.xmfj003,l_xm.xmfj007,l_xm.xmfj019,l_xm.xmdksite,l_xm.xmdkdocno,
                                   l_xm.xmdk000,   #2015/08/04 by stellar add
                                   l_xm.xmdk006,l_xm.xmdk007,l_xm.xmdk016,l_xm.xmdk017,l_xm.xmdlseq,
                                   l_xm.xmdl004,l_xm.xmdl008,l_xm.xmdl009,l_xm.xmdl021,l_xm.xmdl022,
                                   l_xm.xmdl024,l_xm.xmdl025,l_xm.xmdl027,l_xm.xmdl028,l_xm.xmdl029
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      #指定帳款客戶
      LET l_continue = FALSE   #2015/08/05 by stellar add
      IF NOT cl_null(l_xm.xmfj003) AND l_xm.xmfj003 <> l_xm.xmdk007 THEN
         #2015/08/05 by stellar modify ----- (S)
#         CONTINUE FOREACH
         LET l_continue = TRUE
         #2015/08/05 by stellar modify ----- (E)
      END IF
      #限制結算對象範圍
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM xmfk_t
       WHERE xmfkent = g_enterprise
         AND xmfkdocno = lc_param.xmfjdocno
      IF l_cnt > 0 THEN
         LET l_xmda034 = ''
         SELECT xmda034 INTO l_xmda034
           FROM xmda_t
          WHERE xmdaent = g_enterprise
            AND xmdadocno = l_xm.xmdk006
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt
           FROM xmfk_t
          WHERE xmfkent = g_enterprise
            AND xmfkdocno = lc_param.xmfjdocno
            AND ((xmfk001 = l_xm.xmdk007 AND xmfk002 = l_xmda034)
             OR  (xmfk001 = l_xm.xmdk007 AND xmfk002 IS NULL)
             OR  (xmfk002 = l_xmda034 AND xmfk001 IS NULL))
         IF l_cnt = 0 THEN
            CONTINUE FOREACH
         #2015/08/05 by stellar add ----- (S)
         ELSE
            LET l_continue = FALSE
         #2015/08/05 by stellar add ----- (E)
         END IF
      END IF
      
      #2015/08/05 by stellar add ----- (S)
      IF l_continue THEN
         CONTINUE FOREACH
      END IF
      #2015/08/05 by stellar add ----- (E)
      
      LET l_cnt2 = 0
      INITIALIZE l_xmfl.* TO NULL
      FOREACH axmp430_process_xmfl_1_cs INTO l_xmfl.xmflseq,l_xmfl.xmfl001,l_xmfl.xmfl002,l_xmfl.xmfl003,
                                             l_xmfl.xmfl005,l_xmfl.xmfl007,l_xmfl.xmfl008
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
　　     #抓取出貨單/銷退單的料件需要需要符合折扣合約上的指定的資料範圍
         CASE l_xmfl.xmfl001  #資料類型
            WHEN '1'  #料號
               IF cl_null(l_xmfl.xmfl003) THEN
                  IF l_xm.xmdl008 <> l_xmfl.xmfl002 THEN
                     CONTINUE FOREACH
                  END IF
               ELSE
                  IF l_xm.xmdl008 <> l_xmfl.xmfl002 OR (l_xm.xmdl009 <> l_xmfl.xmfl003) THEN
                     CONTINUE FOREACH
                  END IF
               END IF
            WHEN '2'  #產品分類
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = l_xm.xmdl008
                  AND imaa009 = l_xmfl.xmfl002
               IF l_cnt = 0 THEN
                  CONTINUE FOREACH
               END IF
            WHEN '3'  #系列號
               LET l_cnt = 0
               SELECT COUNT(*) INTO l_cnt
                 FROM imaa_t
                WHERE imaaent = g_enterprise
                  AND imaa001 = l_xm.xmdl008
                  AND imaa127 = l_xmfl.xmfl002
               IF l_cnt = 0 THEN
                  CONTINUE FOREACH
               END IF
            OTHERWISE EXIT CASE
         END CASE
         
         INITIALIZE l_xmde.* TO NULL
         LET l_xmde.xmdeent  = g_enterprise
         LET l_xmde.xmdesite = g_site
         LET l_xmde.xmde000  = '3'
         LET l_xmde.xmde001  = lc_param.xmfjdocno
         LET l_xmde.xmde002  = l_xmfl.xmflseq
         LET l_xmde.xmde003  = l_xm.xmdkdocno
         LET l_xmde.xmde004  = l_xm.xmdlseq
         LET l_xmde.xmde005  = lc_param.xmfl010
         LET l_xmde.xmde006  = l_xm.xmdl008
         LET l_xmde.xmde007  = l_xm.xmdl009
         LET l_xmde.xmde008  = l_xm.xmdl022
         LET l_xmde.xmde009  = l_xm.xmdl021
         LET l_xmde.xmde010  = l_xm.xmdl024
         LET l_xmde.xmde011  = l_xm.xmdl027
         LET l_xmde.xmde012  = l_xm.xmdl028
         LET l_xmde.xmde013  = l_xm.xmdl029
         LET l_xmde.xmde022  = l_xm.xmdk006
         LET l_xmde.xmde023  = l_xm.xmdl004
         LET l_xmde.xmde024  = l_xm.xmdksite
         LET l_xmde.xmde025  = '1'     #未處理
         LET l_xmde.xmde026  = l_xm.xmfj019
         #差異數量
         IF l_xmfl.xmfl005 = '2' THEN  #金額百分比折扣
            LET l_xmde.xmde020 = 1
         ELSE                          #單價
            LET l_xmde.xmde020 = l_xm.xmdl022
         END IF
         #2015/08/04 by stellar add ----- (S)
         #銷退單的數量為負
         IF l_xm.xmdk000 = '6' THEN
            LET l_xmde.xmde020 = l_xmde.xmde020 * (-1)
         END IF
         #2015/08/04 by stellar add ----- (E)
         #建議調整後單價
         CASE l_xmfl.xmfl005  #折扣方式
            WHEN '1'  #單價折扣
               LET l_xmde.xmde029  = l_xmfl.xmfl007
            WHEN '2'  #金額百分比折扣
               IF l_xm.xmfj007 = 'N' THEN  #未稅
                  LET l_xmde.xmde029  = l_xm.xmdl027 * l_xmfl.xmfl008 / 100
               ELSE                        #含稅
                  LET l_xmde.xmde029  = l_xm.xmdl028 * l_xmfl.xmfl008 / 100
               END IF
            WHEN '3'  #單價百分比折扣
               #2015/08/04 by stellar modify ----- (S)
#               LET l_xmde.xmde029  = l_xmfl.xmfl007 * l_xmfl.xmfl008 / 100
               LET l_xmde.xmde029  = l_xmde.xmde010 * l_xmfl.xmfl008 / 100
               #2015/08/04 by stellar modify ----- (E)
            OTHERWISE EXIT CASE
         END CASE
         CALL s_tax_count(l_xm.xmdksite,l_xm.xmdl025,(l_xmde.xmde020*l_xmde.xmde029),l_xmde.xmde020,l_xm.xmdk016,l_xm.xmdk017)
              RETURNING l_xmde.xmde014,l_xmde.xmde016,l_xmde.xmde015,l_xrcd113,l_xrcd114,l_xrcd115
         LET l_xmde.xmde017 = l_xmde.xmde014
         LET l_xmde.xmde018 = l_xmde.xmde015
         LET l_xmde.xmde019 = l_xmde.xmde016
         LET l_xmde.xmde021 = l_xmde.xmde029
         
         EXECUTE axmp430_process_insert_xmde_pre USING
                 l_xmde.xmdeent,l_xmde.xmdesite,l_xmde.xmde000,
                 l_xmde.xmde001,l_xmde.xmde002,l_xmde.xmde003,l_xmde.xmde004,l_xmde.xmde005,
                 l_xmde.xmde006,l_xmde.xmde007,l_xmde.xmde008,l_xmde.xmde009,l_xmde.xmde010,
                 l_xmde.xmde011,l_xmde.xmde012,l_xmde.xmde013,l_xmde.xmde014,l_xmde.xmde015,
                 l_xmde.xmde016,l_xmde.xmde017,l_xmde.xmde018,l_xmde.xmde019,l_xmde.xmde020,
                 l_xmde.xmde021,l_xmde.xmde022,l_xmde.xmde023,l_xmde.xmde024,l_xmde.xmde025,
                 l_xmde.xmde026,l_xmde.xmde029
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'ins xmde'
            LET g_errparam.popup = TRUE
            LET l_success = FALSE
            CALL cl_err()
            EXIT FOREACH
         ELSE
            LET l_cnt2 = l_cnt2 + 1
            EXIT FOREACH   #美張單據只處理一次 #2015/08/04 by stellar add
         END IF
         
      END FOREACH
      
      IF l_cnt2 <> 0 THEN
         #將結算日期、起始日期、截止日期回寫回對應的合約單項次檔
         UPDATE xmfl_t
            SET xmfl010 = lc_param.xmfl010,
                xmfl011 = lc_param.date_s,
                xmfl012 = lc_param.date_e
          WHERE xmflent = g_enterprise
            AND xmfldocno = lc_param.xmfjdocno
            AND xmflseq = l_xmfl.xmflseq
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'upd xmfl'
            LET g_errparam.popup = TRUE
            LET l_success = FALSE
            CALL cl_err()
            EXIT FOREACH
         ELSE
            LET l_cnt1 = l_cnt1 + 1
         END IF
      END IF
      
      LET l_cnt2 = 0
   END FOREACH
   
   
   IF l_cnt1 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'agl-00167'
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   ELSE
      #分段折扣
      LET l_sql = " SELECT xmflseq,xmfl005 ",
                  "   FROM xmfl_t ",
                  "  WHERE xmflent = '",g_enterprise,"' ",
                  "    AND xmfldocno = '",lc_param.xmfjdocno,"' ",
                  "    AND xmfl010 = '",lc_param.xmfl010,"' ",
                  "    AND xmfl009 = 'Y' "
      IF NOT cl_null(lc_param.xmflseq) THEN
         LET l_sql = l_sql," AND xmflseq = '",lc_param.xmflseq,"' "
      END IF
      PREPARE axmp430_process_xmfl_2_bp FROM l_sql
      DECLARE axmp430_process_xmfl_2_cs CURSOR FOR axmp430_process_xmfl_2_bp
      
      INITIALIZE l_xmfl.* TO NULL
      FOREACH axmp430_process_xmfl_2_cs INTO l_xmfl.xmflseq,l_xmfl.xmfl005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         LET l_xmfm001 = 0
         SELECT MIN(xmfm001) INTO l_xmfm001
           FROM xmfm_t
          WHERE xmfment = g_enterprise
            AND xmfmdocno = lc_param.xmfjdocno
            AND xmfmseq = l_xmfl.xmflseq
         IF cl_null(l_xmfm001) THEN
            CONTINUE FOREACH
         END IF
         
         IF l_xmfl.xmfl005 = '2' THEN  #金額百分比折扣
            #2015/08/04 by stellar modify ----- (S)
#            LET l_sum = 0
#            SELECT SUM(xmde029) INTO l_sum
#              FROM xmde_t
#             WHERE xmdeent = g_enterprise
#               AND xmde000 = '3'
#               AND xmde001 = lc_param.xmfjdocno
#               AND xmde002 = l_xmfl.xmflseq
#               AND xmde005 = lc_param.xmfl010
#            IF l_sum < l_xmfm001 THEN
#               CONTINUE FOREACH
#            END IF
            
            #判斷該合約含未稅
            LET l_sum = 0
            LET l_sum1= 0
            SELECT xmfj007 INTO l_xmfj007 
              FROM xmfj_t
             WHERE xmfjent = g_enterprise
               AND xmfjdocno = lc_param.xmfjdocno
            IF l_xmfj007 = 'N' THEN   #未稅
               #出貨、簽收
               SELECT SUM(xmde011) INTO l_sum
                 FROM xmde_t
                WHERE xmdeent = g_enterprise
                  AND xmde000 = '3'
                  AND xmde001 = lc_param.xmfjdocno
                  AND xmde002 = l_xmfl.xmflseq
                  AND xmde005 = lc_param.xmfl010
                  AND xmde020 > 0
                  
               #銷退
               SELECT SUM(xmde011) INTO l_sum1
                 FROM xmde_t
                WHERE xmdeent = g_enterprise
                  AND xmde000 = '3'
                  AND xmde001 = lc_param.xmfjdocno
                  AND xmde002 = l_xmfl.xmflseq
                  AND xmde005 = lc_param.xmfl010
                  AND xmde020 < 0
            ELSE                      #含稅
               #出貨、簽收
               SELECT SUM(xmde012) INTO l_sum
                 FROM xmde_t
                WHERE xmdeent = g_enterprise
                  AND xmde000 = '3'
                  AND xmde001 = lc_param.xmfjdocno
                  AND xmde002 = l_xmfl.xmflseq
                  AND xmde005 = lc_param.xmfl010
                  AND xmde020 > 0
               
               #銷退
               SELECT SUM(xmde012) INTO l_sum1
                 FROM xmde_t
                WHERE xmdeent = g_enterprise
                  AND xmde000 = '3'
                  AND xmde001 = lc_param.xmfjdocno
                  AND xmde002 = l_xmfl.xmflseq
                  AND xmde005 = lc_param.xmfl010
                  AND xmde020 < 0
            END IF
            
            #160608-00006 by whitney add start
            IF cl_null(l_sum) THEN LET l_sum = 0 END IF
            IF cl_null(l_sum1) THEN LET l_sum1 = 0 END IF
            #160608-00006 by whitney add end
            
            LET l_sum = l_sum - l_sum1
            
            IF l_sum < l_xmfm001 THEN
               CONTINUE FOREACH
            END IF
            #2015/08/04 by stellar modify ----- (E)
         ELSE
            #總出貨數量
            LET l_sum = 0
            SELECT SUM(xmde020) INTO l_sum
              FROM xmde_t
             WHERE xmdeent = g_enterprise
               AND xmde000 = '3'
               AND xmde001 = lc_param.xmfjdocno
               AND xmde002 = l_xmfl.xmflseq
               AND xmde005 = lc_param.xmfl010
            IF cl_null(l_sum) THEN LET l_sum = 0 END IF  #160608-00006 by whitney add
#            IF l_sum >= l_xmfm001 THEN   #2015/08/04 by stellar mark
            IF l_sum < l_xmfm001 THEN     #2015/08/04 by stellar add
               CONTINUE FOREACH
            END IF
         END IF
         
         INITIALIZE l_xmde.* TO NULL
         DECLARE axmp430_process_xmde_cs CURSOR FOR
            SELECT xmde003,xmde004,xmde011,xmde012,xmde013,xmde020,xmde029,xmde010   #2015/08/04 by stellar add xmde010
              FROM xmde_t
             WHERE xmdeent = g_enterprise
               AND xmde000 = '3'
               AND xmde001 = lc_param.xmfjdocno
               AND xmde002 = l_xmfl.xmflseq
               AND xmde005 = lc_param.xmfl010
         FOREACH axmp430_process_xmde_cs INTO l_xmde.xmde003,l_xmde.xmde004,l_xmde.xmde011,l_xmde.xmde012,
                                              l_xmde.xmde013,l_xmde.xmde020,l_xmde.xmde029
                                             ,l_xmde.xmde010   #2015/08/04 by stellar add
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "FOREACH:"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
            IF l_xmfl.xmfl005 = '1' THEN  #單價折扣
               SELECT xmfm003 INTO l_xmde.xmde029
                 FROM xmfm_t
                WHERE xmfment = g_enterprise
                  AND xmfmdocno = lc_param.xmfjdocno
                  AND xmfmseq = l_xmfl.xmflseq
                  AND xmfm001 <= l_sum
                  AND xmfm002 >= l_sum
            ELSE                          #百分比折扣
               #2015/08/04 by stellar modify ----- (S)
#               SELECT (xmfm004*l_xmde.xmde029/100) INTO l_xmde.xmde029
               IF l_xmfl.xmfl005 = '2' THEN   #金額百分比
                  IF l_xmfj007 = 'N' THEN
                     LET l_price = l_xmde.xmde011
                  ELSE
                     LET l_price = l_xmde.xmde012
                  END IF
               ELSE                           #單價百分比
                  LET l_price = l_xmde.xmde010
               END IF
               SELECT (xmfm004*l_price/100) INTO l_xmde.xmde029
               #2015/08/04 by stellar modify ----- (E)
                 FROM xmfm_t
                WHERE xmfment = g_enterprise
                  AND xmfmdocno = lc_param.xmfjdocno
                  AND xmfmseq = l_xmfl.xmflseq
                  AND xmfm001 <= l_sum
                  AND xmfm002 >= l_sum
            END IF
            CALL s_tax_count(l_xm.xmdksite,l_xm.xmdl025,(l_xmde.xmde020*l_xmde.xmde029),l_xmde.xmde020,l_xm.xmdk016,l_xm.xmdk017)
                 RETURNING l_xmde.xmde014,l_xmde.xmde016,l_xmde.xmde015,l_xrcd113,l_xrcd114,l_xrcd115
            LET l_xmde.xmde017 = l_xmde.xmde014
            LET l_xmde.xmde018 = l_xmde.xmde015
            LET l_xmde.xmde019 = l_xmde.xmde016
            LET l_xmde.xmde021 = l_xmde.xmde029
            
            UPDATE xmde_t
               SET xmde014 = l_xmde.xmde014,
                   xmde015 = l_xmde.xmde015,
                   xmde016 = l_xmde.xmde016,
                   xmde017 = l_xmde.xmde017,
                   xmde018 = l_xmde.xmde018,
                   xmde019 = l_xmde.xmde019,
                   xmde021 = l_xmde.xmde021,
                   xmde029 = l_xmde.xmde029
             WHERE xmdeent = g_enterprise
               AND xmde000 = '3'
               AND xmde001 = lc_param.xmfjdocno
               AND xmde002 = l_xmfl.xmflseq
               AND xmde003 = l_xmde.xmde003
               AND xmde004 = l_xmde.xmde004
               AND xmde005 = lc_param.xmfl010
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "upd xmde"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            
         END FOREACH
      END FOREACH
   END IF
   
   FREE axmp430_process_bp
   FREE axmp430_process_xmfl_1_bp
   FREE axmp430_process_xmfl_2_bp
   FREE axmp430_process_insert_xmde_pre
   
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
   CALL cl_err_collect_show()
   
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      IF lc_param.chk = 'Y' THEN
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'axmp431'
         LET la_param.param[1] = lc_param.xmfjdocno
         LET la_param.param[2] = lc_param.xmflseq
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun_wait(ls_js)
#         CALL cl_cmdrun("axmp431 '"||lc_param.xmfjdocno||"' '"||lc_param.xmflseq||"'")
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      #150708-00007#1--(S)
      IF NOT l_success THEN
         LET li_p01_status = FALSE
      END IF
      IF g_schedule.gzpa003 = 1 THEN 
         IF cl_chk_process_exists(g_parentsession,g_account) THEN
            CALL cl_ask_confirm("std-00012") RETURNING li_stus
         END IF
      END IF 
      DISPLAY cl_getmsg_parm("azz-01007",g_lang,'')
      #150708-00007#1--(E)
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL axmp430_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="axmp430.get_buffer" >}
PRIVATE FUNCTION axmp430_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.xmfjdocno = p_dialog.getFieldBuffer('xmfjdocno')
   LET g_master.xmflseq = p_dialog.getFieldBuffer('xmflseq')
   LET g_master.xmfl010 = p_dialog.getFieldBuffer('xmfl010')
   LET g_master.date_s = p_dialog.getFieldBuffer('date_s')
   LET g_master.date_e = p_dialog.getFieldBuffer('date_e')
   LET g_master.chk = p_dialog.getFieldBuffer('chk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmp430.msgcentre_notify" >}
PRIVATE FUNCTION axmp430_msgcentre_notify()
 
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
 
{<section id="axmp430.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
