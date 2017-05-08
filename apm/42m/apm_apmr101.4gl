#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2015-07-10 17:56:31), PR版次:0001(2015-09-10 15:35:39)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: apmr101
#+ Description: 交易對象申請憑證列印
#+ Creator....: 01996(2015-07-10 16:38:50)
#+ Modifier...: 01996 -SD/PR- 01996
 
{</section>}
 
{<section id="apmr101.global" >}
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
   
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmbadocno LIKE pmba_t.pmbadocno, 
   pmbadocdt LIKE pmba_t.pmbadocdt, 
   pmba900 LIKE pmba_t.pmba900, 
   pmba901 LIKE pmba_t.pmba901, 
   pmba001 LIKE pmba_t.pmba001, 
   pmba004 LIKE pmba_t.pmba004, 
   pmba000 LIKE pmba_t.pmba000, 
   pmbastus LIKE pmba_t.pmbastus, 
   other1 LIKE type_t.chr500, 
   other2 LIKE type_t.chr500, 
   other3 LIKE type_t.chr500, 
   other4 LIKE type_t.chr500, 
   other5 LIKE type_t.chr500,
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
 
{<section id="apmr101.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由02開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[02]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apmr101_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmr101 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmr101_init()
 
      #進入選單 Menu (="N")
      CALL apmr101_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmr101
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmr101.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmr101_init()
   #add-point:init段define name="init.define"
DEFINE l_gzze003 LIKE gzze_t.gzze003
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
   CALL cl_set_combo_scc('pmba004','2015') 
   CALL cl_set_combo_scc('pmba000','32')
   CALL cl_set_combo_scc_part('pmbastus','13','N,Y,A,D,R,W,X')
   LET g_master.other1 = 'N'
   LET g_master.other2 = 'N'
   LET g_master.other3 = 'N'
   LET g_master.other4 = 'N'
   LET g_master.other5 = 'N'
   IF g_argv[1] = '1' THEN
      LET l_gzze003 = ' '
      SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00050' AND gzze002 = g_dlang
      CALL cl_set_comp_att_text('pmba001',l_gzze003)
   END IF
   IF g_argv[1] = '2' THEN
      LET l_gzze003 = ' '
      SELECT gzze003 INTO l_gzze003 FROM gzze_t WHERE gzze001 = 'apm-00052' AND gzze002 = g_dlang
      CALL cl_set_comp_att_text('pmba001',l_gzze003)
   END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmr101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr101_ui_dialog()
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
         INPUT BY NAME g_master.other1,g_master.other2,g_master.other3,g_master.other4,g_master.other5  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD other1
            #add-point:BEFORE FIELD other1 name="input.b.other1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD other1
            
            #add-point:AFTER FIELD other1 name="input.a.other1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE other1
            #add-point:ON CHANGE other1 name="input.g.other1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD other2
            #add-point:BEFORE FIELD other2 name="input.b.other2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD other2
            
            #add-point:AFTER FIELD other2 name="input.a.other2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE other2
            #add-point:ON CHANGE other2 name="input.g.other2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD other3
            #add-point:BEFORE FIELD other3 name="input.b.other3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD other3
            
            #add-point:AFTER FIELD other3 name="input.a.other3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE other3
            #add-point:ON CHANGE other3 name="input.g.other3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD other4
            #add-point:BEFORE FIELD other4 name="input.b.other4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD other4
            
            #add-point:AFTER FIELD other4 name="input.a.other4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE other4
            #add-point:ON CHANGE other4 name="input.g.other4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD other5
            #add-point:BEFORE FIELD other5 name="input.b.other5"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD other5
            
            #add-point:AFTER FIELD other5 name="input.a.other5"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE other5
            #add-point:ON CHANGE other5 name="input.g.other5"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.other1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD other1
            #add-point:ON ACTION controlp INFIELD other1 name="input.c.other1"
            
            #END add-point
 
 
         #Ctrlp:input.c.other2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD other2
            #add-point:ON ACTION controlp INFIELD other2 name="input.c.other2"
            
            #END add-point
 
 
         #Ctrlp:input.c.other3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD other3
            #add-point:ON ACTION controlp INFIELD other3 name="input.c.other3"
            
            #END add-point
 
 
         #Ctrlp:input.c.other4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD other4
            #add-point:ON ACTION controlp INFIELD other4 name="input.c.other4"
            
            #END add-point
 
 
         #Ctrlp:input.c.other5
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD other5
            #add-point:ON ACTION controlp INFIELD other5 name="input.c.other5"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmbadocno,pmbadocdt,pmba900,pmba901,pmba001,pmba004,pmba000, 
             pmbastus
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmbadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbadocno
            #add-point:ON ACTION controlp INFIELD pmbadocno name="construct.c.pmbadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_argv[1]) THEN
               CASE g_argv[1]
                  WHEN '1' LET g_qryparam.where = " (pmba002 = '1' OR pmba002 = '3') "
                  WHEN '2' LET g_qryparam.where = " (pmba002 = '2' OR pmba002 = '3') "
               END CASE
            END IF
            CALL q_pmbadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbadocno  #顯示到畫面上
            NEXT FIELD pmbadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbadocno
            #add-point:BEFORE FIELD pmbadocno name="construct.b.pmbadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbadocno
            
            #add-point:AFTER FIELD pmbadocno name="construct.a.pmbadocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbadocdt
            #add-point:BEFORE FIELD pmbadocdt name="construct.b.pmbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbadocdt
            
            #add-point:AFTER FIELD pmbadocdt name="construct.a.pmbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbadocdt
            #add-point:ON ACTION controlp INFIELD pmbadocdt name="construct.c.pmbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmba900
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmba900
            #add-point:ON ACTION controlp INFIELD pmba900 name="construct.c.pmba900"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba900  #顯示到畫面上
            NEXT FIELD pmba900                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmba900
            #add-point:BEFORE FIELD pmba900 name="construct.b.pmba900"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmba900
            
            #add-point:AFTER FIELD pmba900 name="construct.a.pmba900"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmba901
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmba901
            #add-point:ON ACTION controlp INFIELD pmba901 name="construct.c.pmba901"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba901  #顯示到畫面上
            NEXT FIELD pmba901                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmba901
            #add-point:BEFORE FIELD pmba901 name="construct.b.pmba901"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmba901
            
            #add-point:AFTER FIELD pmba901 name="construct.a.pmba901"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmba001
            #add-point:ON ACTION controlp INFIELD pmba001 name="construct.c.pmba001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_argv[1]) THEN
               CASE g_argv[1]
                  WHEN '1' LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 = '3') "
                  WHEN '2' LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 = '3') "
               END CASE
            END IF

            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmba001  #顯示到畫面上
            NEXT FIELD pmba001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmba001
            #add-point:BEFORE FIELD pmba001 name="construct.b.pmba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmba001
            
            #add-point:AFTER FIELD pmba001 name="construct.a.pmba001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmba004
            #add-point:BEFORE FIELD pmba004 name="construct.b.pmba004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmba004
            
            #add-point:AFTER FIELD pmba004 name="construct.a.pmba004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmba004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmba004
            #add-point:ON ACTION controlp INFIELD pmba004 name="construct.c.pmba004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmba000
            #add-point:BEFORE FIELD pmba000 name="construct.b.pmba000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmba000
            
            #add-point:AFTER FIELD pmba000 name="construct.a.pmba000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmba000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmba000
            #add-point:ON ACTION controlp INFIELD pmba000 name="construct.c.pmba000"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbastus
            #add-point:BEFORE FIELD pmbastus name="construct.b.pmbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbastus
            
            #add-point:AFTER FIELD pmbastus name="construct.a.pmbastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbastus
            #add-point:ON ACTION controlp INFIELD pmbastus name="construct.c.pmbastus"
            
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
            CALL apmr101_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL apmr101_get_buffer(l_dialog)
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
         CALL apmr101_init()
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
                 CALL apmr101_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmr101_transfer_argv(ls_js)
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
 
{<section id="apmr101.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmr101_transfer_argv(ls_js)
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
 
{<section id="apmr101.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmr101_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"pmbadocno,pmbadocdt,pmba900,pmba901,pmba001,pmba004,pmba000,pmbastus")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
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
       LET g_master.wc = l_arg[01]
       LET g_master.other1 = l_arg[02]
       LET g_master.other2 = l_arg[03]
       LET g_master.other3 = l_arg[04]
       LET g_master.other4 = l_arg[05]
       LET g_master.other5 = l_arg[06]
       LET g_argv[1] = l_arg[07]
   ELSE
      IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1 " END IF
      LET g_master.wc = g_master.wc," AND pmbaent = ",g_enterprise
   END IF
   
   
   
   
   
   CALL apmr101_g01(g_master.wc,g_master.other1,g_master.other2,g_master.other3,g_master.other4,g_master.other5,g_argv[1])
   
   DISPLAY 100 TO stagecomplete
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmr101_process_cs CURSOR FROM ls_sql
#  FOREACH apmr101_process_cs INTO
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
 
{<section id="apmr101.get_buffer" >}
PRIVATE FUNCTION apmr101_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.other1 = p_dialog.getFieldBuffer('other1')
   LET g_master.other2 = p_dialog.getFieldBuffer('other2')
   LET g_master.other3 = p_dialog.getFieldBuffer('other3')
   LET g_master.other4 = p_dialog.getFieldBuffer('other4')
   LET g_master.other5 = p_dialog.getFieldBuffer('other5')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr101.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
