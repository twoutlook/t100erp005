#該程式未解開Section, 採用最新樣板產出!
{<section id="apmp810.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-03-28 13:51:22), PR版次:0006(2016-11-10 15:07:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000200
#+ Filename...: apmp810
#+ Description: 供應商績效評核項目批次產生作業
#+ Creator....: 02748(2014-03-28 10:49:00)
#+ Modifier...: 02159 -SD/PR- 00700
 
{</section>}
 
{<section id="apmp810.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160322-00021#1 2016/03/28 by sakura 修正1.限定品類欄位顯示為非空值2.評核開始日期 評核結束日期為何給值1899/12/31 
#                                    3.不勾選限定品類，為何評核品類欄位也卡住要輸入值
#                                    4.輸入評核品類後，執行，報錯-391 ins pmcc_t 無法將空值插入欄的'欄-名稱'.
#161104-00002#11   2016/11/10  By Rainy  將程式中 *寫法改掉
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
        pmcc001          LIKE pmcc_t.pmcc001,
        pmcc003          LIKE pmcc_t.pmcc003,
        pmcc004          LIKE pmcc_t.pmcc004,
        limit            LIKE type_t.chr1,
        pmcc002          STRING,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       pmcc001 LIKE type_t.chr10, 
   pmcc003 LIKE type_t.dat, 
   pmcc004 LIKE type_t.dat, 
   limit LIKE type_t.chr500, 
   pmcc002 LIKE pmcc_t.pmcc002, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_pmcd_cnt        LIKE type_t.num5
DEFINE g_pmce_cnt        LIKE type_t.num5
DEFINE g_cnt_s           LIKE type_t.num5
DEFINE g_cnt_f           LIKE type_t.num5
DEFINE g_cnt_all         LIKE type_t.num5
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
   #argv[1] pmcc_t.pmcc001 #評核期別
   #argv[2] pmcc_t.pmcc003 #評核開始日期
   #argv[3] pmcc_t.pmcc004 #評核結束日期
   #argv[4] type_t.chr1 #限定品類
   #argv[5] STRING #評核品類
   #argv[6] STRING #wc
#end add-point
 
{</section>}
 
{<section id="apmp810.main" >}
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
#150710-00014#1 20150714 mark by beckxie---S
#   LET lc_param.pmcc001 = g_argv[1]
#   LET lc_param.pmcc003 = g_argv[2]
#   LET lc_param.pmcc004 = DOWNSHIFT(g_argv[3])
#   LET lc_param.limit = g_argv[4]
#   LET lc_param.pmcc002 = g_argv[5]
#   LET lc_param.wc = g_argv[6]
#   LET ls_js = util.JSON.stringify(lc_param)
#   
#   IF NOT cl_null(lc_param.pmcc001) THEN
#      LET g_bgjob = "Y"
#   ELSE
#      LET g_bgjob = "N"
#   END IF
#150710-00014#1 20150714 mark by beckxie---E
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apmp810_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmp810 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmp810_init()
 
      #進入選單 Menu (="N")
      CALL apmp810_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmp810
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmp810.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmp810_init()
 
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
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmp810.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmp810_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_rtax004         LIKE rtax_t.rtax004
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.pmcc001,g_master.pmcc003,g_master.pmcc004,g_master.limit,g_master.pmcc002  
 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               #160322-00021#1 add(S)
               LET g_master.pmcc003 = s_date_get_first_date(g_today)
               LET g_master.pmcc004 = s_date_get_last_date(g_today)
               LET g_master.limit = 'N'
               LET g_master.pmcc002 = "ALL" 
               CALL apmp810_set_entry(g_master.limit)
               CALL apmp810_set_no_entry(g_master.limit)               
               #160322-00021#1 add(E)               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc001
            #add-point:BEFORE FIELD pmcc001 name="input.b.pmcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc001
            
            #add-point:AFTER FIELD pmcc001 name="input.a.pmcc001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc001
            #add-point:ON CHANGE pmcc001 name="input.g.pmcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc003
            #add-point:BEFORE FIELD pmcc003 name="input.b.pmcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc003
            
            #add-point:AFTER FIELD pmcc003 name="input.a.pmcc003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc003
            #add-point:ON CHANGE pmcc003 name="input.g.pmcc003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc004
            #add-point:BEFORE FIELD pmcc004 name="input.b.pmcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc004
            
            #add-point:AFTER FIELD pmcc004 name="input.a.pmcc004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc004
            #add-point:ON CHANGE pmcc004 name="input.g.pmcc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD limit
            #add-point:BEFORE FIELD limit name="input.b.limit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD limit
            
            #add-point:AFTER FIELD limit name="input.a.limit"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE limit
            #add-point:ON CHANGE limit name="input.g.limit"
            #160322-00021#1 add(S)
            IF g_master.limit = 'N' THEN
               LET g_master.pmcc002 = "ALL"
            ELSE
               LET g_master.pmcc002 = NULL
            END IF
            CALL apmp810_set_entry(g_master.limit)
            CALL apmp810_set_no_entry(g_master.limit)             
            #160322-00021#1 add(E)
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc002
            #add-point:BEFORE FIELD pmcc002 name="input.b.pmcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc002
            
            #add-point:AFTER FIELD pmcc002 name="input.a.pmcc002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmcc002
            #add-point:ON CHANGE pmcc002 name="input.g.pmcc002"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.pmcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc001
            #add-point:ON ACTION controlp INFIELD pmcc001 name="input.c.pmcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc003
            #add-point:ON ACTION controlp INFIELD pmcc003 name="input.c.pmcc003"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc004
            #add-point:ON ACTION controlp INFIELD pmcc004 name="input.c.pmcc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.limit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD limit
            #add-point:ON ACTION controlp INFIELD limit name="input.c.limit"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmcc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc002
            #add-point:ON ACTION controlp INFIELD pmcc002 name="input.c.pmcc002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.pmcc002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_rtax001()                                #呼叫開窗

            LET g_master.pmcc002 = g_qryparam.return1              

            DISPLAY g_master.pmcc002 TO pmcc002              #

            NEXT FIELD pmcc002                          #返回原欄位


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmcc001,pmcc003,pmcc004,limit,pmcc002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc001
            #add-point:BEFORE FIELD pmcc001 name="construct.b.pmcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc001
            
            #add-point:AFTER FIELD pmcc001 name="construct.a.pmcc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc001
            #add-point:ON ACTION controlp INFIELD pmcc001 name="construct.c.pmcc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc003
            #add-point:BEFORE FIELD pmcc003 name="construct.b.pmcc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc003
            
            #add-point:AFTER FIELD pmcc003 name="construct.a.pmcc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc003
            #add-point:ON ACTION controlp INFIELD pmcc003 name="construct.c.pmcc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc004
            #add-point:BEFORE FIELD pmcc004 name="construct.b.pmcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc004
            
            #add-point:AFTER FIELD pmcc004 name="construct.a.pmcc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc004
            #add-point:ON ACTION controlp INFIELD pmcc004 name="construct.c.pmcc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD limit
            #add-point:BEFORE FIELD limit name="construct.b.limit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD limit
            
            #add-point:AFTER FIELD limit name="construct.a.limit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.limit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD limit
            #add-point:ON ACTION controlp INFIELD limit name="construct.c.limit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmcc002
            #add-point:BEFORE FIELD pmcc002 name="construct.b.pmcc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmcc002
            
            #add-point:AFTER FIELD pmcc002 name="construct.a.pmcc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmcc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmcc002
            #add-point:ON ACTION controlp INFIELD pmcc002 name="construct.c.pmcc002"
            
            #END add-point
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME lc_param.pmcc001,lc_param.pmcc003,lc_param.pmcc004,lc_param.limit,lc_param.pmcc002
            BEFORE INPUT
               IF cl_null(lc_param.limit) THEN
                  LET lc_param.limit = 'N'
                  LET lc_param.pmcc002 = "ALL" 
               END IF
               IF cl_null(lc_param.pmcc003) THEN
                  CALL s_date_get_first_date(g_today) RETURNING lc_param.pmcc003
               END IF
               IF cl_null(lc_param.pmcc004) THEN
                  CALL s_date_get_last_date(g_today) RETURNING lc_param.pmcc004
               END IF
               CALL apmp810_set_entry(lc_param.limit)
               CALL apmp810_set_no_entry(lc_param.limit)
               
               
            AFTER FIELD pmcc003
               IF lc_param.pmcc003 > lc_param.pmcc004 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00093"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmcc003
               END IF
               
            AFTER FIELD pmcc004
               IF lc_param.pmcc004 < lc_param.pmcc003 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00094"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD pmcc004
               END IF
               
            AFTER FIELD limit
               IF lc_param.limit = 'N' THEN
                  LET lc_param.pmcc002 = "ALL"
               ELSE
                  LET lc_param.pmcc002 = NULL
               END IF
               
            ON CHANGE limit
               IF lc_param.limit = 'N' THEN
                  LET lc_param.pmcc002 = "ALL"
               ELSE
                  LET lc_param.pmcc002 = NULL
               END IF            
               CALL apmp810_set_entry(lc_param.limit)
               CALL apmp810_set_no_entry(lc_param.limit)
               
            BEFORE FIELD pmcc002
               CALL apmp810_set_entry(lc_param.limit)
               CALL apmp810_set_no_entry(lc_param.limit)
               
            AFTER FIELD pmcc002   
               IF NOT apmp810_chk_pmcc002(lc_param.pmcc002) THEN
                  NEXT FIELD pmcc002
               END IF
               
            ON ACTION controlp INFIELD pmcc002
               LET l_rtax004 = cl_get_para(g_enterprise,g_site,"E-CIR-0001")
               
			   INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE 
			   LET g_qryparam.arg1 = l_rtax004
               CALL q_rtax001_3()                           #呼叫開窗
               LET lc_param.pmcc002 = g_qryparam.return1
               DISPLAY lc_param.pmcc002 TO pmcc002        #顯示到畫面上
               NEXT FIELD pmcc002                         #返回原欄位
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL apmp810_get_buffer(l_dialog)
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
         CALL apmp810_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      #150710-00014#1 20150717 add by beckxie---S
      LET lc_param.pmcc001 = g_master.pmcc001
      LET lc_param.pmcc003 = g_master.pmcc003
      LET lc_param.pmcc004 = g_master.pmcc004
      LET lc_param.limit = g_master.limit
      LET lc_param.pmcc002 = g_master.pmcc002
      #150710-00014#1 20150717 add by beckxie---E
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
                 CALL apmp810_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmp810_transfer_argv(ls_js)
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
 
{<section id="apmp810.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmp810_transfer_argv(ls_js)
 
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
#150710-00014#1 20150717 mark by beckxie---S
#   LET la_cmdrun.param[1] = la_param.pmcc001
#   LET la_cmdrun.param[2] = la_param.pmcc003     
#   LET la_cmdrun.param[3] = la_param.pmcc004
#   LET la_cmdrun.param[4] = la_param.limit
#   LET la_cmdrun.param[5] = la_param.pmcc002
#   LET la_cmdrun.param[6] = la_param.wc
#150710-00014#1 20150717 mark by beckxie---E
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="apmp810.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmp810_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_msg       STRING
   DEFINE l_str       STRING
   DEFINE l_msg1      STRING           #160225-00040#12 20160328 add by beckxie
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   #160225-00040#12 20160328 add by beckxie---S
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_bar_no_window(4)   #160225-00040#12 20160328 add by beckxie
   END IF
   LET l_msg1 = cl_getmsg('ade-00114',g_lang)
   CALL cl_progress_no_window_ing(l_msg1)
   #160225-00040#12 20160328 add by beckxie---E
   LET g_sql = "SELECT gzcb002",
               "  FROM gzcb_t ",
               " WHERE gzcb001 = 6001 "
   DECLARE apmp810_pmcd_cl CURSOR FROM g_sql
   
   SELECT COUNT(*) INTO g_pmcd_cnt
     FROM gzcb_t
    WHERE gzcb001 = 6001
    
   LET g_sql = "SELECT oocq002,oocq004",
               "  FROM oocq_t ",
               " WHERE oocqent = '",g_enterprise,"'",
               "   AND oocq001 = 2052 ",
               "   AND oocqstus = 'Y' "               
   DECLARE apmp810_pmce_cl CURSOR FROM g_sql
    
   SELECT COUNT(*) INTO g_pmce_cnt
     FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = 2052
      AND oocqstus = 'Y'
      
   LET g_sql = "SELECT oocq002",
               "  FROM oocq_t ",
               " WHERE oocqent = '",g_enterprise,"'",
               "   AND oocq001 = 2053 ",
               "   AND oocqstus = 'Y' "                
   DECLARE apmp810_pmcf_cl CURSOR FROM g_sql
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmp810_process_cs CURSOR FROM ls_sql
#  FOREACH apmp810_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#12 20160328 add by beckxie---S
   LET l_msg1 = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg1)
   #160225-00040#12 20160328 add by beckxie---E
   CALL apmp810_gen_data(ls_js)
   #160225-00040#12 20160328 add by beckxie---S
   LET l_msg1 = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg1)
   #160225-00040#12 20160328 add by beckxie---E
   #160225-00040#12 20160328 add by beckxie---S
   LET l_msg1 = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg1)
   #160225-00040#12 20160328 add by beckxie---E
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      LET l_msg = cl_getmsg('apm-00455',g_dlang)
      LET l_msg = l_msg,g_cnt_s
      LET l_str = cl_getmsg('apm-00456',g_dlang)
      LET l_str = l_str,g_cnt_f
      LET l_msg = l_msg,",",l_str
      CALL cl_ask_confirm2("",l_msg) RETURNING li_stus
      RETURN
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apmp810_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apmp810.get_buffer" >}
PRIVATE FUNCTION apmp810_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pmcc001 = p_dialog.getFieldBuffer('pmcc001')
   LET g_master.pmcc003 = p_dialog.getFieldBuffer('pmcc003')
   LET g_master.pmcc004 = p_dialog.getFieldBuffer('pmcc004')
   LET g_master.limit = p_dialog.getFieldBuffer('limit')
   LET g_master.pmcc002 = p_dialog.getFieldBuffer('pmcc002')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmp810.msgcentre_notify" >}
PRIVATE FUNCTION apmp810_msgcentre_notify()
 
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
 
{<section id="apmp810.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PUBLIC FUNCTION apmp810_gen_data(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE l_indx      LIKE type_t.num5
   DEFINE l_str       STRING
   DEFINE l_pmcc002   LIKE pmcc_t.pmcc002
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_success   LIKE type_t.num5
   
   CALL util.JSON.parse(ls_js,lc_param)
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   
   LET g_cnt_s = 0
   LET g_cnt_f = 0
   LET l_str = lc_param.pmcc002
   LET l_success = TRUE
   LET l_indx = 1
DISPLAY "lc_param.pmcc002==",lc_param.pmcc002 #06814
   WHILE l_indx > 0 
      LET l_indx = l_str.getIndexOf("|",1)
      IF l_indx > 0 THEN
         LET l_pmcc002 = l_str.subString(1,l_indx-1)
         LET l_str = l_str.subString(l_indx+1,l_str.getLength())
      ELSE
         LET l_pmcc002 = l_str
      END IF
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM pmcc_t
       WHERE pmccent = g_enterprise
         AND pmcc001 = lc_param.pmcc001
         AND pmcc002 = l_pmcc002
       IF l_cnt > 0 THEN
          LET g_cnt_f = g_cnt_f + 1
          CALL cl_errmsg(lc_param.pmcc001,'pmcc_t',l_pmcc002,"apm-00429",1)
       ELSE
          IF l_pmcc002 = "ALL" THEN
             SELECT COUNT(*) INTO l_cnt
               FROM pmcc_t
              WHERE pmccent = g_enterprise
                AND pmcc001 = lc_param.pmcc001
             IF l_cnt > 0 THEN
                LET g_cnt_f = g_cnt_f + 1
                CALL cl_errmsg(lc_param.pmcc001,'pmcc_t',l_pmcc002,"apm-00461",1)
                CONTINUE WHILE
             END IF
          ELSE 
             SELECT COUNT(*) INTO l_cnt
               FROM pmcc_t
              WHERE pmccent = g_enterprise
                AND pmcc001 = lc_param.pmcc001
                AND pmcc002 = "ALL"
             IF l_cnt > 0 THEN
                LET g_cnt_f = g_cnt_f + 1
                CALL cl_errmsg(lc_param.pmcc001,'pmcc_t',l_pmcc002,"apm-00461",1)
                CONTINUE WHILE
             END IF   
          END IF
          CALL apmp810_ins_pmcc(ls_js,l_pmcc002) RETURNING l_success
          IF l_success THEN
             CALL apmp810_ins_pmcd(lc_param.pmcc001,l_pmcc002) RETURNING l_success
          END IF
          IF l_success THEN
             CALL apmp810_ins_pmce(lc_param.pmcc001,l_pmcc002) RETURNING l_success
          END IF
          IF l_success THEN
             CALL apmp810_ins_pmcf(lc_param.pmcc001,l_pmcc002) RETURNING l_success
          END IF
          LET g_cnt_s = g_cnt_s + 1
       END IF
       
   END WHILE
   
   IF l_success THEN
      CALL s_transaction_end('Y','0') 
      CALL cl_err_showmsg()
   ELSE
      LET g_cnt_s = 0
      LET g_cnt_f = g_cnt_all
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

PUBLIC FUNCTION apmp810_ins_pmcc(ls_js,p_pmcc002)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE p_pmcc002   LIKE pmcc_t.pmcc002
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pmcc_d    RECORD 
      pmccent LIKE pmcc_t.pmccent,
      pmcc001 LIKE pmcc_t.pmcc001,
      pmcc002 LIKE pmcc_t.pmcc002,
      pmcc003 LIKE pmcc_t.pmcc003,
      pmcc004 LIKE pmcc_t.pmcc004,
      pmcc005 LIKE pmcc_t.pmcc005,
      pmcc006 LIKE pmcc_t.pmcc006,
      pmccstus LIKE pmcc_t.pmccstus,
      pmccownid LIKE pmcc_t.pmccownid,
      pmccowndp LIKE pmcc_t.pmccowndp,
      pmcccrtid LIKE pmcc_t.pmcccrtid,
      pmcccrtdp LIKE pmcc_t.pmcccrtdp,
      pmcccrtdt DATETIME YEAR TO SECOND,
      pmccmodid LIKE pmcc_t.pmccmodid,
      pmccmoddt LIKE pmcc_t.pmccmoddt
   END RECORD     
   
   CALL util.JSON.parse(ls_js,lc_param)
   LET l_success = TRUE
   
   LET l_pmcc_d.pmccent = g_enterprise
   LET l_pmcc_d.pmcc001 = lc_param.pmcc001
   LET l_pmcc_d.pmcc002 = p_pmcc002
   LET l_pmcc_d.pmcc003 = lc_param.pmcc003
   LET l_pmcc_d.pmcc004 = lc_param.pmcc004
   LET l_pmcc_d.pmcc005 = 50
   LET l_pmcc_d.pmcc006 = 50
   LET l_pmcc_d.pmccstus = "Y"
   LET l_pmcc_d.pmccownid = g_user
   LET l_pmcc_d.pmccowndp = g_dept
   LET l_pmcc_d.pmcccrtid = g_user
   LET l_pmcc_d.pmcccrtdp = g_dept
   LET l_pmcc_d.pmcccrtdt = cl_get_current()
   LET l_pmcc_d.pmccmoddt = NULL
   
   INSERT INTO pmcc_t(pmccent, pmcc001, pmcc002, pmcc003, pmcc004, pmcc005, pmcc006, pmccstus, pmccownid, pmccowndp, pmcccrtid, pmcccrtdp, pmcccrtdt, pmccmodid, pmccmoddt) 
        VALUES ( l_pmcc_d.pmccent, l_pmcc_d.pmcc001, l_pmcc_d.pmcc002, l_pmcc_d.pmcc003, l_pmcc_d.pmcc004, l_pmcc_d.pmcc005, l_pmcc_d.pmcc006, l_pmcc_d.pmccstus, l_pmcc_d.pmccownid, l_pmcc_d.pmccowndp, l_pmcc_d.pmcccrtid, l_pmcc_d.pmcccrtdp, l_pmcc_d.pmcccrtdt, l_pmcc_d.pmccmodid, l_pmcc_d.pmccmoddt)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins pmcc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
  
      LET l_success = FALSE
   END IF
   
   RETURN l_success
END FUNCTION

PUBLIC FUNCTION apmp810_chk_pmcc002(p_str)
   DEFINE p_str      STRING
   DEFINE l_index    LIKE type_t.num5
   DEFINE l_num      LIKE type_t.num5
   DEFINE l_pmcc002  LIKE pmcc_t.pmcc002
   DEFINE l_str      STRING
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_rtax004  LIKE rtax_t.rtax004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_pmcc_d   DYNAMIC ARRAY OF LIKE pmcc_t.pmcc002
   DEFINE l_i        LIKE type_t.num5
   
   CALL l_pmcc_d.clear()
   LET l_rtax004 = cl_get_para(g_enterprise,g_site,"E-CIR-0001")
   LET l_index = 1
   LET l_str = p_str
   LET l_success = TRUE
   LET g_cnt_all = 1
   LET l_cnt = 0
   WHILE l_index > 0
      LET l_index = l_str.getIndexOf("|",1)
      IF l_index > 0 THEN
         LET l_pmcc002 = l_str.subString(1,l_index-1)
         LET l_str = l_str.subString(l_index+1,l_str.getLength())
      ELSE
         LET l_pmcc002 = l_str
      END IF 

      IF l_pmcc002 <> "ALL" THEN
         #校驗
         SELECT COUNT(*)
           INTO l_num
           FROM rtax_t 
          WHERE rtaxent = g_enterprise 
            AND rtax004 = l_rtax004 
            AND rtaxstus = 'Y'
            AND rtax001 = l_pmcc002
         IF l_num = 0 THEN
            LET l_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "-6372"
            LET g_errparam.extend = l_pmcc002
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN l_success
         END IF
      END IF 
      LET l_cnt = l_cnt + 1
      LET l_pmcc_d[l_cnt] = l_pmcc002
   END WHILE
   
   FOR l_cnt = 1 TO l_pmcc_d.getLength()
      #ALL和其他品類不能並存
      IF l_pmcc_d.getLength() > 1 THEN
         IF l_pmcc_d[l_cnt] = "ALL" THEN
            LET l_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "apm-00461"
            LET g_errparam.extend = ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

            RETURN l_success
         END IF
      END IF
      #重複
      FOR l_i = 1 TO l_pmcc_d.getLength()
         IF l_i <> l_cnt THEN
            IF l_pmcc_d[l_i] = l_pmcc_d[l_cnt] THEN
               LET l_success = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "apm-00430"
               LET g_errparam.extend = ""
               LET g_errparam.popup = TRUE
               CALL cl_err()

               RETURN l_success
            END IF
         END IF
      END FOR
   END FOR
   LET g_cnt_all = l_pmcc_d.getLength()

   RETURN l_success
END FUNCTION

PUBLIC FUNCTION apmp810_ins_pmcd(p_pmcc001,p_pmcc002)
   DEFINE p_pmcc001   LIKE pmcc_t.pmcc001
   DEFINE p_pmcc002   LIKE pmcc_t.pmcc002
   DEFINE l_success   LIKE type_t.num5
 #161104-00002#11 161110 By rainy mod---(S) 
 #調整*寫法     
   #DEFINE l_pmcd_d    RECORD LIKE pmcd_t.*
   DEFINE l_pmcd_d RECORD  #供應商評核定量項目設定檔
       pmcdent LIKE pmcd_t.pmcdent, #企業編號
       pmcd001 LIKE pmcd_t.pmcd001, #評核期別
       pmcd002 LIKE pmcd_t.pmcd002, #評核品類
       pmcd003 LIKE pmcd_t.pmcd003, #評核項目
       pmcd004 LIKE pmcd_t.pmcd004, #權重
       pmcdud001 LIKE pmcd_t.pmcdud001, #自定義欄位(文字)001
       pmcdud002 LIKE pmcd_t.pmcdud002, #自定義欄位(文字)002
       pmcdud003 LIKE pmcd_t.pmcdud003, #自定義欄位(文字)003
       pmcdud004 LIKE pmcd_t.pmcdud004, #自定義欄位(文字)004
       pmcdud005 LIKE pmcd_t.pmcdud005, #自定義欄位(文字)005
       pmcdud006 LIKE pmcd_t.pmcdud006, #自定義欄位(文字)006
       pmcdud007 LIKE pmcd_t.pmcdud007, #自定義欄位(文字)007
       pmcdud008 LIKE pmcd_t.pmcdud008, #自定義欄位(文字)008
       pmcdud009 LIKE pmcd_t.pmcdud009, #自定義欄位(文字)009
       pmcdud010 LIKE pmcd_t.pmcdud010, #自定義欄位(文字)010
       pmcdud011 LIKE pmcd_t.pmcdud011, #自定義欄位(數字)011
       pmcdud012 LIKE pmcd_t.pmcdud012, #自定義欄位(數字)012
       pmcdud013 LIKE pmcd_t.pmcdud013, #自定義欄位(數字)013
       pmcdud014 LIKE pmcd_t.pmcdud014, #自定義欄位(數字)014
       pmcdud015 LIKE pmcd_t.pmcdud015, #自定義欄位(數字)015
       pmcdud016 LIKE pmcd_t.pmcdud016, #自定義欄位(數字)016
       pmcdud017 LIKE pmcd_t.pmcdud017, #自定義欄位(數字)017
       pmcdud018 LIKE pmcd_t.pmcdud018, #自定義欄位(數字)018
       pmcdud019 LIKE pmcd_t.pmcdud019, #自定義欄位(數字)019
       pmcdud020 LIKE pmcd_t.pmcdud020, #自定義欄位(數字)020
       pmcdud021 LIKE pmcd_t.pmcdud021, #自定義欄位(日期時間)021
       pmcdud022 LIKE pmcd_t.pmcdud022, #自定義欄位(日期時間)022
       pmcdud023 LIKE pmcd_t.pmcdud023, #自定義欄位(日期時間)023
       pmcdud024 LIKE pmcd_t.pmcdud024, #自定義欄位(日期時間)024
       pmcdud025 LIKE pmcd_t.pmcdud025, #自定義欄位(日期時間)025
       pmcdud026 LIKE pmcd_t.pmcdud026, #自定義欄位(日期時間)026
       pmcdud027 LIKE pmcd_t.pmcdud027, #自定義欄位(日期時間)027
       pmcdud028 LIKE pmcd_t.pmcdud028, #自定義欄位(日期時間)028
       pmcdud029 LIKE pmcd_t.pmcdud029, #自定義欄位(日期時間)029
       pmcdud030 LIKE pmcd_t.pmcdud030  #自定義欄位(日期時間)030
  END RECORD   
 #161104-00002#11 161110 By rainy mod---(S)   
   DEFINE l_pmcd003   LIKE pmcd_t.pmcd003
   DEFINE l_pmcd004   LIKE pmcd_t.pmcd004
   DEFINE l_cnt       LIKE type_t.num5
   
   LET l_success = TRUE
   LET l_cnt = 1
   LET l_pmcd004 = 100/g_pmcd_cnt
   LET l_pmcd004 = s_num_round('3',l_pmcd004,0)
   
   FOREACH apmp810_pmcd_cl INTO l_pmcd003
      IF l_cnt = g_pmcd_cnt THEN
         LET l_pmcd004 = 100-(l_pmcd004*(g_pmcd_cnt-1))
      END IF
      LET l_pmcd_d.pmcdent = g_enterprise
      LET l_pmcd_d.pmcd001 = p_pmcc001
      LET l_pmcd_d.pmcd002 = p_pmcc002
      LET l_pmcd_d.pmcd003 = l_pmcd003
      LET l_pmcd_d.pmcd004 = l_pmcd004
     #161104-00002#11 161110 By rainy mod---(S) 
      #調整*寫法    
      #INSERT INTO pmcd_t VALUES l_pmcd_d.*
      INSERT INTO pmcd_t ( pmcdent,  pmcd001,  pmcd002,  pmcd003,  pmcd004,
                           pmcdud001,pmcdud002,pmcdud003,pmcdud004,pmcdud005,
                           pmcdud006,pmcdud007,pmcdud008,pmcdud009,pmcdud010,
                           pmcdud011,pmcdud012,pmcdud013,pmcdud014,pmcdud015,
                           pmcdud016,pmcdud017,pmcdud018,pmcdud019,pmcdud020,
                           pmcdud021,pmcdud022,pmcdud023,pmcdud024,pmcdud025,
                           pmcdud026,pmcdud027,pmcdud028,pmcdud029,pmcdud030
                         )
      VALUES ( l_pmcd_d.pmcdent,  l_pmcd_d.pmcd001,  l_pmcd_d.pmcd002,  l_pmcd_d.pmcd003,  l_pmcd_d.pmcd004,                            
               l_pmcd_d.pmcdud001,l_pmcd_d.pmcdud002,l_pmcd_d.pmcdud003,l_pmcd_d.pmcdud004,l_pmcd_d.pmcdud005,
               l_pmcd_d.pmcdud006,l_pmcd_d.pmcdud007,l_pmcd_d.pmcdud008,l_pmcd_d.pmcdud009,l_pmcd_d.pmcdud010,
               l_pmcd_d.pmcdud011,l_pmcd_d.pmcdud012,l_pmcd_d.pmcdud013,l_pmcd_d.pmcdud014,l_pmcd_d.pmcdud015,
               l_pmcd_d.pmcdud016,l_pmcd_d.pmcdud017,l_pmcd_d.pmcdud018,l_pmcd_d.pmcdud019,l_pmcd_d.pmcdud020,
               l_pmcd_d.pmcdud021,l_pmcd_d.pmcdud022,l_pmcd_d.pmcdud023,l_pmcd_d.pmcdud024,l_pmcd_d.pmcdud025,
               l_pmcd_d.pmcdud026,l_pmcd_d.pmcdud027,l_pmcd_d.pmcdud028,l_pmcd_d.pmcdud029,l_pmcd_d.pmcdud030 
              )
     #161104-00002#11 161110 By rainy mod---(E)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins pmcd_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt +1
   END FOREACH
   RETURN l_success
END FUNCTION

PUBLIC FUNCTION apmp810_set_entry(p_limit)
   DEFINE p_limit    LIKE type_t.chr1
   
   IF p_limit = 'N' THEN
      CALL cl_set_comp_entry("pmcc002",FALSE)
   END IF
END FUNCTION

PUBLIC FUNCTION apmp810_set_no_entry(p_limit)
   DEFINE p_limit    LIKE type_t.chr1
   
   IF p_limit = 'Y' THEN
      CALL cl_set_comp_entry("pmcc002",TRUE)
   END IF
END FUNCTION

PUBLIC FUNCTION apmp810_ins_pmce(p_pmcc001,p_pmcc002)
   DEFINE p_pmcc001   LIKE pmcc_t.pmcc001
   DEFINE p_pmcc002   LIKE pmcc_t.pmcc002
   DEFINE l_success   LIKE type_t.num5
 #161104-00002#11 161110 By rainy mod---(S) 
  #調整*寫法    
   #DEFINE l_pmce_d    RECORD LIKE pmce_t.*
   DEFINE l_pmce_d RECORD  #供應商評核定性項目設定檔
       pmceent LIKE pmce_t.pmceent, #企業編號
       pmce001 LIKE pmce_t.pmce001, #評核期別
       pmce002 LIKE pmce_t.pmce002, #評核品類
       pmce003 LIKE pmce_t.pmce003, #評核項目
       pmce004 LIKE pmce_t.pmce004, #評分部門
       pmce005 LIKE pmce_t.pmce005, #權重
       pmceud001 LIKE pmce_t.pmceud001, #自定義欄位(文字)001
       pmceud002 LIKE pmce_t.pmceud002, #自定義欄位(文字)002
       pmceud003 LIKE pmce_t.pmceud003, #自定義欄位(文字)003
       pmceud004 LIKE pmce_t.pmceud004, #自定義欄位(文字)004
       pmceud005 LIKE pmce_t.pmceud005, #自定義欄位(文字)005
       pmceud006 LIKE pmce_t.pmceud006, #自定義欄位(文字)006
       pmceud007 LIKE pmce_t.pmceud007, #自定義欄位(文字)007
       pmceud008 LIKE pmce_t.pmceud008, #自定義欄位(文字)008
       pmceud009 LIKE pmce_t.pmceud009, #自定義欄位(文字)009
       pmceud010 LIKE pmce_t.pmceud010, #自定義欄位(文字)010
       pmceud011 LIKE pmce_t.pmceud011, #自定義欄位(數字)011
       pmceud012 LIKE pmce_t.pmceud012, #自定義欄位(數字)012
       pmceud013 LIKE pmce_t.pmceud013, #自定義欄位(數字)013
       pmceud014 LIKE pmce_t.pmceud014, #自定義欄位(數字)014
       pmceud015 LIKE pmce_t.pmceud015, #自定義欄位(數字)015
       pmceud016 LIKE pmce_t.pmceud016, #自定義欄位(數字)016
       pmceud017 LIKE pmce_t.pmceud017, #自定義欄位(數字)017
       pmceud018 LIKE pmce_t.pmceud018, #自定義欄位(數字)018
       pmceud019 LIKE pmce_t.pmceud019, #自定義欄位(數字)019
       pmceud020 LIKE pmce_t.pmceud020, #自定義欄位(數字)020
       pmceud021 LIKE pmce_t.pmceud021, #自定義欄位(日期時間)021
       pmceud022 LIKE pmce_t.pmceud022, #自定義欄位(日期時間)022
       pmceud023 LIKE pmce_t.pmceud023, #自定義欄位(日期時間)023
       pmceud024 LIKE pmce_t.pmceud024, #自定義欄位(日期時間)024
       pmceud025 LIKE pmce_t.pmceud025, #自定義欄位(日期時間)025
       pmceud026 LIKE pmce_t.pmceud026, #自定義欄位(日期時間)026
       pmceud027 LIKE pmce_t.pmceud027, #自定義欄位(日期時間)027
       pmceud028 LIKE pmce_t.pmceud028, #自定義欄位(日期時間)028
       pmceud029 LIKE pmce_t.pmceud029, #自定義欄位(日期時間)029
       pmceud030 LIKE pmce_t.pmceud030  #自定義欄位(日期時間)030
  END RECORD
 #161104-00002#11 161110 By rainy mod---(S) 
   DEFINE l_pmce003   LIKE pmce_t.pmce003
   DEFINE l_pmce004   LIKE pmce_t.pmce004
   DEFINE l_pmce005   LIKE pmce_t.pmce005
   DEFINE l_cnt       LIKE type_t.num5
   
   LET l_success = TRUE
   LET l_cnt = 1
   LET l_pmce005 = 100/g_pmce_cnt
   LET l_pmce005 = s_num_round('3',l_pmce005,0)
   
   FOREACH apmp810_pmce_cl INTO l_pmce003,l_pmce004
      IF l_cnt = g_pmce_cnt THEN
         LET l_pmce005 = 100-(l_pmce005*(g_pmce_cnt-1))
      END IF
      LET l_pmce_d.pmceent = g_enterprise
      LET l_pmce_d.pmce001 = p_pmcc001
      LET l_pmce_d.pmce002 = p_pmcc002
      LET l_pmce_d.pmce003 = l_pmce003
      LET l_pmce_d.pmce004 = l_pmce004
      LET l_pmce_d.pmce005 = l_pmce005
     #161104-00002#11 161110 By rainy mod---(S) 
      #調整*寫法      
      #INSERT INTO pmce_t VALUES l_pmce_d.*
      INSERT INTO pmce_t ( pmceent,  pmce001,  pmce002,  pmce003,  pmce004,
                           pmce005,  pmceud001,pmceud002,pmceud003,pmceud004,
                           pmceud005,pmceud006,pmceud007,pmceud008,pmceud009,
                           pmceud010,pmceud011,pmceud012,pmceud013,pmceud014,
                           pmceud015,pmceud016,pmceud017,pmceud018,pmceud019,
                           pmceud020,pmceud021,pmceud022,pmceud023,pmceud024,
                           pmceud025,pmceud026,pmceud027,pmceud028,pmceud029,
                           pmceud030
                         )
      VALUES (l_pmce_d.pmceent,  l_pmce_d.pmce001,  l_pmce_d.pmce002,  l_pmce_d.pmce003,  l_pmce_d.pmce004,
              l_pmce_d.pmce005,  l_pmce_d.pmceud001,l_pmce_d.pmceud002,l_pmce_d.pmceud003,l_pmce_d.pmceud004,
              l_pmce_d.pmceud005,l_pmce_d.pmceud006,l_pmce_d.pmceud007,l_pmce_d.pmceud008,l_pmce_d.pmceud009,
              l_pmce_d.pmceud010,l_pmce_d.pmceud011,l_pmce_d.pmceud012,l_pmce_d.pmceud013,l_pmce_d.pmceud014,
              l_pmce_d.pmceud015,l_pmce_d.pmceud016,l_pmce_d.pmceud017,l_pmce_d.pmceud018,l_pmce_d.pmceud019,
              l_pmce_d.pmceud020,l_pmce_d.pmceud021,l_pmce_d.pmceud022,l_pmce_d.pmceud023,l_pmce_d.pmceud024,
              l_pmce_d.pmceud025,l_pmce_d.pmceud026,l_pmce_d.pmceud027,l_pmce_d.pmceud028,l_pmce_d.pmceud029,
              l_pmce_d.pmceud030
             )
     #161104-00002#11 161110 By rainy mod---(S)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins pmce_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      LET l_cnt = l_cnt +1
   END FOREACH
   RETURN l_success
END FUNCTION

PUBLIC FUNCTION apmp810_ins_pmcf(p_pmcc001,p_pmcc002)
   DEFINE p_pmcc001   LIKE pmcc_t.pmcc001
   DEFINE p_pmcc002   LIKE pmcc_t.pmcc002
   DEFINE l_success   LIKE type_t.num5
  #161104-00002#11 161110 By rainy mod---(S) 
  #調整*寫法      
   #DEFINE l_pmcf_d    RECORD LIKE pmcf_t.*
   DEFINE l_pmcf_d RECORD  #供應商評核績效分級標準設定檔
       pmcfent LIKE pmcf_t.pmcfent, #企業編號
       pmcf001 LIKE pmcf_t.pmcf001, #評核期別
       pmcf002 LIKE pmcf_t.pmcf002, #評核品類
       pmcf003 LIKE pmcf_t.pmcf003, #供應商分級
       pmcf004 LIKE pmcf_t.pmcf004, #分數起
       pmcf005 LIKE pmcf_t.pmcf005, #分數迄
       pmcf006 LIKE pmcf_t.pmcf006, #處理建議
       pmcfud001 LIKE pmcf_t.pmcfud001, #自定義欄位(文字)001
       pmcfud002 LIKE pmcf_t.pmcfud002, #自定義欄位(文字)002
       pmcfud003 LIKE pmcf_t.pmcfud003, #自定義欄位(文字)003
       pmcfud004 LIKE pmcf_t.pmcfud004, #自定義欄位(文字)004
       pmcfud005 LIKE pmcf_t.pmcfud005, #自定義欄位(文字)005
       pmcfud006 LIKE pmcf_t.pmcfud006, #自定義欄位(文字)006
       pmcfud007 LIKE pmcf_t.pmcfud007, #自定義欄位(文字)007
       pmcfud008 LIKE pmcf_t.pmcfud008, #自定義欄位(文字)008
       pmcfud009 LIKE pmcf_t.pmcfud009, #自定義欄位(文字)009
       pmcfud010 LIKE pmcf_t.pmcfud010, #自定義欄位(文字)010
       pmcfud011 LIKE pmcf_t.pmcfud011, #自定義欄位(數字)011
       pmcfud012 LIKE pmcf_t.pmcfud012, #自定義欄位(數字)012
       pmcfud013 LIKE pmcf_t.pmcfud013, #自定義欄位(數字)013
       pmcfud014 LIKE pmcf_t.pmcfud014, #自定義欄位(數字)014
       pmcfud015 LIKE pmcf_t.pmcfud015, #自定義欄位(數字)015
       pmcfud016 LIKE pmcf_t.pmcfud016, #自定義欄位(數字)016
       pmcfud017 LIKE pmcf_t.pmcfud017, #自定義欄位(數字)017
       pmcfud018 LIKE pmcf_t.pmcfud018, #自定義欄位(數字)018
       pmcfud019 LIKE pmcf_t.pmcfud019, #自定義欄位(數字)019
       pmcfud020 LIKE pmcf_t.pmcfud020, #自定義欄位(數字)020
       pmcfud021 LIKE pmcf_t.pmcfud021, #自定義欄位(日期時間)021
       pmcfud022 LIKE pmcf_t.pmcfud022, #自定義欄位(日期時間)022
       pmcfud023 LIKE pmcf_t.pmcfud023, #自定義欄位(日期時間)023
       pmcfud024 LIKE pmcf_t.pmcfud024, #自定義欄位(日期時間)024
       pmcfud025 LIKE pmcf_t.pmcfud025, #自定義欄位(日期時間)025
       pmcfud026 LIKE pmcf_t.pmcfud026, #自定義欄位(日期時間)026
       pmcfud027 LIKE pmcf_t.pmcfud027, #自定義欄位(日期時間)027
       pmcfud028 LIKE pmcf_t.pmcfud028, #自定義欄位(日期時間)028
       pmcfud029 LIKE pmcf_t.pmcfud029, #自定義欄位(日期時間)029
       pmcfud030 LIKE pmcf_t.pmcfud030  #自定義欄位(日期時間)030
   END RECORD
  #161104-00002#11 161110 By rainy mod---(E)  
   DEFINE l_pmcf003   LIKE pmcf_t.pmcf003
   
   LET l_success = TRUE
   
   FOREACH apmp810_pmcf_cl INTO l_pmcf003

      LET l_pmcf_d.pmcfent = g_enterprise
      LET l_pmcf_d.pmcf001 = p_pmcc001
      LET l_pmcf_d.pmcf002 = p_pmcc002
      LET l_pmcf_d.pmcf003 = l_pmcf003
 
     #161104-00002#11 161110 By rainy mod---(S) 
      #調整*寫法   
      #INSERT INTO pmcf_t VALUES l_pmcf_d.*
      INSERT INTO pmcf_t ( pmcfent,  pmcf001,  pmcf002,  pmcf003,  pmcf004,
                           pmcf005,  pmcf006,  pmcfud001,pmcfud002,pmcfud003,
                           pmcfud004,pmcfud005,pmcfud006,pmcfud007,pmcfud008,
                           pmcfud009,pmcfud010,pmcfud011,pmcfud012,pmcfud013,
                           pmcfud014,pmcfud015,pmcfud016,pmcfud017,pmcfud018,
                           pmcfud019,pmcfud020,pmcfud021,pmcfud022,pmcfud023,
                           pmcfud024,pmcfud025,pmcfud026,pmcfud027,pmcfud028,
                           pmcfud029,pmcfud030
                         )
      VALUES ( l_pmcf_d.pmcfent,  l_pmcf_d.pmcf001,  l_pmcf_d.pmcf002,  l_pmcf_d.pmcf003,  l_pmcf_d.pmcf004,
               l_pmcf_d.pmcf005,  l_pmcf_d.pmcf006,  l_pmcf_d.pmcfud001,l_pmcf_d.pmcfud002,l_pmcf_d.pmcfud003,
               l_pmcf_d.pmcfud004,l_pmcf_d.pmcfud005,l_pmcf_d.pmcfud006,l_pmcf_d.pmcfud007,l_pmcf_d.pmcfud008,
               l_pmcf_d.pmcfud009,l_pmcf_d.pmcfud010,l_pmcf_d.pmcfud011,l_pmcf_d.pmcfud012,l_pmcf_d.pmcfud013,
               l_pmcf_d.pmcfud014,l_pmcf_d.pmcfud015,l_pmcf_d.pmcfud016,l_pmcf_d.pmcfud017,l_pmcf_d.pmcfud018,
               l_pmcf_d.pmcfud019,l_pmcf_d.pmcfud020,l_pmcf_d.pmcfud021,l_pmcf_d.pmcfud022,l_pmcf_d.pmcfud023,
               l_pmcf_d.pmcfud024,l_pmcf_d.pmcfud025,l_pmcf_d.pmcfud026,l_pmcf_d.pmcfud027,l_pmcf_d.pmcfud028,
               l_pmcf_d.pmcfud029,l_pmcf_d.pmcfud030  
             )
     #161104-00002#11 161110 By rainy mod---(S)  
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins pmcf_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
  
         LET l_success = FALSE
         EXIT FOREACH
      END IF
   END FOREACH
   RETURN l_success
END FUNCTION

#end add-point
 
{</section>}
 
