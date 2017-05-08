#該程式未解開Section, 採用最新樣板產出!
{<section id="astp826.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-05-05 14:21:27), PR版次:0006(2016-10-26 17:26:10)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: astp826
#+ Description: 貨款轉入結算底稿批次作業
#+ Creator....: 02749(2016-05-03 18:59:21)
#+ Modifier...: 02749 -SD/PR- 02481
 
{</section>}
 
{<section id="astp826.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161024-00025#12  2016/10/26  By 02481  aooi500规范调整
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
   rtjasite        STRING,               #營運組織
   rtja101         STRING,               #鋪位
   rtja102         STRING,               #商戶
   stje001         STRING,               #合約   
   l_start_date    LIKE type_t.dat,      #開始日期
   l_end_date      LIKE type_t.dat,      #結束日期
   l_txn_type      LIKE type_t.chr10,    #轉入方式
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjasite LIKE type_t.chr10, 
   rtja101 LIKE type_t.chr10, 
   rtja102 LIKE type_t.chr10, 
   stje001 LIKE type_t.chr20, 
   l_start_date LIKE type_t.chr500, 
   l_end_date LIKE type_t.chr500, 
   l_txn_type LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_master_t type_master
DEFINE g_auto_conf       LIKE gzcb_t.gzcb002  #160604-00009#124 Add By ken 160705
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="astp826.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5  
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL s_settle_create_tmp() RETURNING l_success     #160604-00009#16 Add By Ken 160609
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp826_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp826 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp826_init()
 
      #進入選單 Menu (="N")
      CALL astp826_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp826
   END IF
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp826.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp826_init()
 
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
   CALL cl_set_combo_scc('l_txn_type','6929')    #轉入方式

   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp826.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp826_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_type        LIKE type_t.chr1   #160604-00009#16 Add By ken 160607
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_start_date,g_master.l_end_date,g_master.l_txn_type 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_start_date
            #add-point:BEFORE FIELD l_start_date name="input.b.l_start_date"
              
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_start_date
            
            #add-point:AFTER FIELD l_start_date name="input.a.l_start_date"
            IF NOT cl_null(g_master.l_start_date) THEN                
               IF g_master.l_start_date >= g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "ast-00742"      
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_master.l_start_date = g_master_t.l_start_date
                  DISPLAY BY NAME g_master_t.l_start_date
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_start_date
            #add-point:ON CHANGE l_start_date name="input.g.l_start_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_end_date
            #add-point:BEFORE FIELD l_end_date name="input.b.l_end_date"
            IF NOT cl_null(g_master.l_end_date) THEN                 
               IF g_master.l_end_date >= g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "ast-00742"    
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_master.l_end_date = g_master_t.l_end_date
                  DISPLAY BY NAME g_master_t.l_end_date
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_end_date
            
            #add-point:AFTER FIELD l_end_date name="input.a.l_end_date"
            IF NOT cl_null(g_master.l_end_date) THEN                 
               IF g_master.l_end_date >= g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "ast-00742"    
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                  LET g_master.l_end_date = g_master_t.l_end_date
                  DISPLAY BY NAME g_master_t.l_end_date
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_end_date
            #add-point:ON CHANGE l_end_date name="input.g.l_end_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_txn_type
            #add-point:BEFORE FIELD l_txn_type name="input.b.l_txn_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_txn_type
            
            #add-point:AFTER FIELD l_txn_type name="input.a.l_txn_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_txn_type
            #add-point:ON CHANGE l_txn_type name="input.g.l_txn_type"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_start_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_start_date
            #add-point:ON ACTION controlp INFIELD l_start_date name="input.c.l_start_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_end_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_end_date
            #add-point:ON ACTION controlp INFIELD l_end_date name="input.c.l_end_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_txn_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_txn_type
            #add-point:ON ACTION controlp INFIELD l_txn_type name="input.c.l_txn_type"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
 
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjasite,rtja101,rtja102,stje001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjasite
            #add-point:ON ACTION controlp INFIELD rtjasite name="construct.c.rtjasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
            
            CALL q_ooef001_24()      
            
            DISPLAY g_qryparam.return1 TO rtjasite 
            NEXT FIELD rtjasite   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjasite
            #add-point:BEFORE FIELD rtjasite name="construct.b.rtjasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjasite
            
            #add-point:AFTER FIELD rtjasite name="construct.a.rtjasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtja101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtja101
            #add-point:ON ACTION controlp INFIELD rtja101 name="construct.c.rtja101"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_mhbe001()                
            
            DISPLAY g_qryparam.return1 TO rtja101 
            NEXT FIELD rtja101      
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtja101
            #add-point:BEFORE FIELD rtja101 name="construct.b.rtja101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtja101
            
            #add-point:AFTER FIELD rtja101 name="construct.a.rtja101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtja102
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtja102
            #add-point:ON ACTION controlp INFIELD rtja102 name="construct.c.rtja102"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '5'
            
            CALL q_pmaa001_27()         
            
            DISPLAY g_qryparam.return1 TO rtja102 
            NEXT FIELD rtja102           
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtja102
            #add-point:BEFORE FIELD rtja102 name="construct.b.rtja102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtja102
            
            #add-point:AFTER FIELD rtja102 name="construct.a.rtja102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stje001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stje001
            #add-point:ON ACTION controlp INFIELD stje001 name="construct.c.stje001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            CALL q_stje001()             
            
            DISPLAY g_qryparam.return1 TO stje001  
            NEXT FIELD stje001  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stje001
            #add-point:BEFORE FIELD stje001 name="construct.b.stje001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stje001
            
            #add-point:AFTER FIELD stje001 name="construct.a.stje001"
            
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
            CALL astp826_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            INITIALIZE g_master_t.* TO NULL
            
            DISPLAY g_site TO rtjasite
            
            LET g_master.l_start_date = g_today -1  
            LET g_master.l_end_date = g_today -1
            #LET g_master.l_txn_type = 2
            #160604-00009#16 Add By ken 160607(S)
            CALL cl_get_para(g_enterprise,g_site,'S-CIR-2030') RETURNING l_type
            LET g_master.l_txn_type = l_type
            IF l_type = '3' THEN
               LET g_master.l_start_date = NULL
               CALL cl_set_comp_entry("l_start_date",FALSE)
            END IF
            #160604-00009#16 Add By ken 160607(E)            
            
            DISPLAY BY NAME g_master.l_start_date,g_master.l_end_date,g_master.l_txn_type 

            LET g_master_t.* = g_master.*
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
         AFTER DIALOG
         IF cl_null(GET_FLDBUF(rtjasite)) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "sub-00507"    
            LET g_errparam.popup = TRUE
            CALL cl_err()  
         
            NEXT FIELD rtjasite  
         END IF  
         
         #營運組織
         LET lc_param.rtjasite      = GET_FLDBUF(rtjasite) 
         LET lc_param.rtjasite      = cl_str_replace(lc_param.rtjasite,"|","','")
         LET lc_param.rtjasite      = " '",lc_param.rtjasite,"' "
         #鋪位         
         LET lc_param.rtja101       = GET_FLDBUF(rtja101)     
         LET lc_param.rtja101       = cl_str_replace(lc_param.rtja101,"|","','")
         LET lc_param.rtja101       = " '",lc_param.rtja101,"' "
         #商戶
         LET lc_param.rtja102       = GET_FLDBUF(rtja102)     
         LET lc_param.rtja102       = cl_str_replace(lc_param.rtja102,"|","','")
         LET lc_param.rtja102       = " '",lc_param.rtja102,"' "
         #合約 
         LET lc_param.stje001       = GET_FLDBUF(stje001)      
         LET lc_param.stje001       = cl_str_replace(lc_param.stje001,"|","','")
         LET lc_param.stje001       = " '",lc_param.stje001,"' "
         
         LET lc_param.l_start_date  = g_master.l_start_date   #開始日期
         LET lc_param.l_end_date    = g_master.l_end_date     #結束日期
         LET lc_param.l_txn_type    = g_master.l_txn_type     #轉入方式
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
         CALL astp826_init()
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
                 CALL astp826_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp826_transfer_argv(ls_js)
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
 
{<section id="astp826.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp826_transfer_argv(ls_js)
 
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
 
{<section id="astp826.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp826_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_succ_cnt    LIKE type_t.num5
   DEFINE l_err_cnt     LIKE type_t.num5 
   DEFINE l_msg         STRING   
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql         STRING                   #160604-00009#124 Add By ken 160705
   DEFINE l_where       STRING  #161024-00025#12--add
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
#  DECLARE astp826_process_cs CURSOR FROM ls_sql
#  FOREACH astp826_process_cs INTO
   #add-point:process段process name="process.process"
   IF NOT s_aooi500_tmp_chk() THEN
      RETURN
   END IF
   
   
   #160604-00009#124 Add By ken 160705(S)
   
   #161024-00025#12--add--begin------------
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where
   LET g_master.wc = g_master.wc," AND ",l_where
   #161024-00025#12--add--end------------
   CALL cl_get_para(g_enterprise,g_site,'S-CIR-2032') RETURNING g_auto_conf 
   IF g_auto_conf = 'Y' THEN
      LET l_sql = " UPDATE rtjf_t SET rtjf104 = 'Y',rtjf106 ='",g_user,"', rtjf107 = TO_DATE('",cl_get_current(),"','yyyy-mm-dd hh24:mi:ss') ",
                  "  WHERE rtjfent = ",g_enterprise,
                  "    AND EXISTS (SELECT 1 FROM rtjb_t WHERE rtjbent = rtjfent AND rtjbdocno = rtjfdocno AND rtjb035 = '2' ) ",
                  "    AND (rtjf104 = 'N' OR rtjf104 = '' OR rtjf104 IS NULL) ",
                  "    AND EXISTS (SELECT 1 FROM ",
                  "                         (SELECT * FROM rtja_t LEFT JOIN stje_t ON rtjaent = stjeent AND rtja105 = stje001) ",
                  "                  WHERE rtjfent = rtjaent AND rtjfdocno = rtjadocno AND rtja101 IS NOT NULL ",
                  #160604-00009#147 Modify By Ken 160715(S)
                  #"                   AND ",g_master.wc 
                  "                   AND ",g_master.wc ,") "
                  #160604-00009#147 Modify By Ken 160715(E)
      IF NOT cl_null(lc_param.l_start_date) THEN 
         LET l_sql = l_sql, " AND rtjf025 >= '",lc_param.l_start_date,"' "  #160604-00009#147 Modify By Ken 160715  rtjadocdt->rtjf025
      END IF                  
      IF NOT cl_null(lc_param.l_end_date) THEN 
         LET l_sql = l_sql, " AND rtjf025 <= '",lc_param.l_end_date,"' "    #160604-00009#147 Modify By Ken 160715  rtjadocdt->rtjf025
      END IF                        
      #LET l_sql = l_sql , " ) "   #160604-00009#147 Mark By Ken 160715
      PREPARE astp826_rtjf_upd_pre FROM l_sql
      EXECUTE astp826_rtjf_upd_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astp826_rtjf_upd_pre"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF        
   END IF
   #160604-00009#124 Add By ken 160705(E)   
   
   #160604-00009#16 Add By Ken 160609(S)
   CALL s_settle_stbc_batch_ins_tmp(lc_param.rtjasite,  lc_param.rtja101,      lc_param.rtja102,
                            lc_param.stje001,   lc_param.l_start_date, lc_param.l_end_date,
                            lc_param.l_txn_type,lc_param.wc)
      RETURNING l_success
   #160604-00009#16 Add By Ken 160609(E)
   
   LET l_succ_cnt = 0 
   LET l_err_cnt  = 0
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   

   
   CALL s_settle_stbc_batch(lc_param.rtjasite,  lc_param.rtja101,      lc_param.rtja102,
                            lc_param.stje001,   lc_param.l_start_date, lc_param.l_end_date,
                            lc_param.l_txn_type,lc_param.wc)
      RETURNING l_succ_cnt,l_err_cnt
   
   CALL cl_err_collect_show()   
   #IF l_succ_cnt > 0 THEN ##mark by zhangnan 
   
   IF l_err_cnt = 0 THEN 
      CALL s_transaction_end('Y',1)
   ELSE
      IF g_bgjob <> "Y" THEN
         CALL cl_progress_bar_no_window(1)
         
         LET l_msg = cl_getmsg('std-00012',g_lang)
         CALL cl_progress_no_window_ing(l_msg)
      END IF   
      
      #IF l_err_cnt = 0 THEN
       #  CALL s_transaction_end('Y',0)  ##mark by zhangnan 
      #ELSE   
         CALL s_transaction_end('N',1) 
      #END IF         
   END IF
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
   CALL astp826_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp826.get_buffer" >}
PRIVATE FUNCTION astp826_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_start_date = p_dialog.getFieldBuffer('l_start_date')
   LET g_master.l_end_date = p_dialog.getFieldBuffer('l_end_date')
   LET g_master.l_txn_type = p_dialog.getFieldBuffer('l_txn_type')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp826.msgcentre_notify" >}
PRIVATE FUNCTION astp826_msgcentre_notify()
 
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
 
{<section id="astp826.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
