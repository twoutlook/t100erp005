#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp606.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-03 17:26:23), PR版次:0001(2016-04-29 17:04:54)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: awsp606
#+ Description: 應用分類碼檔(ACC)批次作業
#+ Creator....: 07556(2016-03-21 14:41:27)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsp606.global" >}
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
       oocqent LIKE type_t.num5, 
   oocq001 LIKE type_t.num5, 
   oocq002 LIKE type_t.chr10, 
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
 
{<section id="awsp606.main" >}
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
   CALL cl_ap_init("aws","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL awsp606_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp606 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp606_init()
 
      #進入選單 Menu (="N")
      CALL awsp606_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp606
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp606.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp606_init()
 
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
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="awsp606.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp606_ui_dialog()
 
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
         
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON oocqent,oocq001,oocq002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocqent
            #add-point:BEFORE FIELD oocqent name="construct.b.oocqent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocqent
            
            #add-point:AFTER FIELD oocqent name="construct.a.oocqent"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocqent
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocqent
            #add-point:ON ACTION controlp INFIELD oocqent name="construct.c.oocqent"
            #開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_wseg001()                       #呼叫開窗
            #DISPLAY g_qryparam.return1 TO oocqent  #顯示到畫面上
            #NEXT FIELD oocqent
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq001
            #add-point:BEFORE FIELD oocq001 name="construct.b.oocq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq001
            
            #add-point:AFTER FIELD oocq001 name="construct.a.oocq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.oocq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq001
            #add-point:ON ACTION controlp INFIELD oocq001 name="construct.c.oocq001"
 
            #END add-point
 
 
         #Ctrlp:construct.c.oocq002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oocq002
            #add-point:ON ACTION controlp INFIELD oocq002 name="construct.c.oocq002"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO oocq002  #顯示到畫面上
            NEXT FIELD oocq002  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oocq002
            #add-point:BEFORE FIELD oocq002 name="construct.b.oocq002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oocq002
            
            #add-point:AFTER FIELD oocq002 name="construct.a.oocq002"
            
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
            CALL awsp606_get_buffer(l_dialog)
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
         CALL awsp606_init()
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
                 CALL awsp606_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp606_transfer_argv(ls_js)
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
 
{<section id="awsp606.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp606_transfer_argv(ls_js)
 
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
 
{<section id="awsp606.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp606_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_wseh_sql    STRING
   DEFINE ls_ins_sql     STRING
   DEFINE ls_upd_sql     STRING
   DEFINE ls_middb       STRING
   DEFINE ls_s_time      LIKE type_t.chr20
   DEFINE ls_e_time      LIKE type_t.chr20
   DEFINE ls_temp_sql    STRING
   DEFINE ls_data_sql    STRING
   DEFINE ls_err_sql     STRING
   DEFINE ls_key         STRING
   DEFINE l_count        LIKE type_t.num10
   DEFINE ls_oocqent     LIKE oocq_t.oocqent   
   DEFINE ls_oocqstus    LIKE oocq_t.oocqstus    
   DEFINE ls_oocq001     LIKE oocq_t.oocq001   
   DEFINE ls_oocq002     LIKE oocq_t.oocq002   
   DEFINE ls_oocq003     LIKE oocq_t.oocq003   
   DEFINE ls_oocq004     LIKE oocq_t.oocq004   
   DEFINE ls_oocq005     LIKE oocq_t.oocq005   
   DEFINE ls_oocq006     LIKE oocq_t.oocq006   
   DEFINE ls_oocq007     LIKE oocq_t.oocq007   
   DEFINE ls_oocq008     LIKE oocq_t.oocq008   
   DEFINE ls_oocq009     LIKE oocq_t.oocq009   
   DEFINE ls_oocq010     LIKE oocq_t.oocq010   
   DEFINE ls_oocq011     LIKE oocq_t.oocq011   
   DEFINE ls_oocq012     LIKE oocq_t.oocq012   
   DEFINE ls_oocq013     LIKE oocq_t.oocq013   
   DEFINE ls_oocq014     LIKE oocq_t.oocq014   
   DEFINE ls_oocq015     LIKE oocq_t.oocq015   
   DEFINE ls_oocq016     LIKE oocq_t.oocq016   
   DEFINE ls_oocq017     LIKE oocq_t.oocq017   
   DEFINE ls_oocq018     LIKE oocq_t.oocq018   
   DEFINE ls_oocq019     LIKE oocq_t.oocq019   
   DEFINE ls_oocq020     LIKE oocq_t.oocq020   
   DEFINE ls_oocq021     LIKE oocq_t.oocq021   
   DEFINE ls_oocq022     LIKE oocq_t.oocq022   
   DEFINE ls_oocq023     LIKE oocq_t.oocq023   
   DEFINE ls_oocqownid   LIKE oocq_t.oocqownid     
   DEFINE ls_oocqowndp   LIKE oocq_t.oocqowndp     
   DEFINE ls_oocqcrtid   LIKE oocq_t.oocqcrtid     
   DEFINE ls_oocqcrtdp   LIKE oocq_t.oocqcrtdp     
   DEFINE ls_oocqcrtdt   LIKE oocq_t.oocqcrtdt     
   DEFINE ls_oocqmodid   LIKE oocq_t.oocqmodid     
   DEFINE ls_oocqmoddt   LIKE oocq_t.oocqmoddt     
   DEFINE ls_oocq024     LIKE oocq_t.oocq024   
   DEFINE ls_oocq025     LIKE oocq_t.oocq025   
   DEFINE ls_oocq026     LIKE oocq_t.oocq026   
   DEFINE ls_oocq027     LIKE oocq_t.oocq027   
   DEFINE ls_oocq028     LIKE oocq_t.oocq028   
   DEFINE ls_oocq029     LIKE oocq_t.oocq029   
   DEFINE ls_oocq030     LIKE oocq_t.oocq030   
   DEFINE ls_oocq031     LIKE oocq_t.oocq031   
   DEFINE ls_oocq032     LIKE oocq_t.oocq032   
   DEFINE ls_oocq033     LIKE oocq_t.oocq033   
   DEFINE ls_oocq034     LIKE oocq_t.oocq034   
   DEFINE ls_oocq035     LIKE oocq_t.oocq035   
   DEFINE ls_oocq036     LIKE oocq_t.oocq036   
   DEFINE ls_oocq037     LIKE oocq_t.oocq037   
   DEFINE ls_oocq038     LIKE oocq_t.oocq038   
   DEFINE ls_oocq039     LIKE oocq_t.oocq039   
   DEFINE ls_oocq040     LIKE oocq_t.oocq040   
   DEFINE ls_oocq041     LIKE oocq_t.oocq041   
   DEFINE ls_oocq042     LIKE oocq_t.oocq042   
   DEFINE ls_oocq043     LIKE oocq_t.oocq043   
   DEFINE ls_oocqud001   LIKE oocq_t.oocqud001     
   DEFINE ls_oocqud002   LIKE oocq_t.oocqud002     
   DEFINE ls_oocqud003   LIKE oocq_t.oocqud003     
   DEFINE ls_oocqud004   LIKE oocq_t.oocqud004     
   DEFINE ls_oocqud005   LIKE oocq_t.oocqud005     
   DEFINE ls_oocqud006   LIKE oocq_t.oocqud006     
   DEFINE ls_oocqud007   LIKE oocq_t.oocqud007     
   DEFINE ls_oocqud008   LIKE oocq_t.oocqud008     
   DEFINE ls_oocqud009   LIKE oocq_t.oocqud009     
   DEFINE ls_oocqud010   LIKE oocq_t.oocqud010     
   DEFINE ls_oocqud011   LIKE oocq_t.oocqud011     
   DEFINE ls_oocqud012   LIKE oocq_t.oocqud012     
   DEFINE ls_oocqud013   LIKE oocq_t.oocqud013     
   DEFINE ls_oocqud014   LIKE oocq_t.oocqud014     
   DEFINE ls_oocqud015   LIKE oocq_t.oocqud015     
   DEFINE ls_oocqud016   LIKE oocq_t.oocqud016     
   DEFINE ls_oocqud017   LIKE oocq_t.oocqud017     
   DEFINE ls_oocqud018   LIKE oocq_t.oocqud018     
   DEFINE ls_oocqud019   LIKE oocq_t.oocqud019     
   DEFINE ls_oocqud020   LIKE oocq_t.oocqud020     
   DEFINE ls_oocqud021   LIKE oocq_t.oocqud021     
   DEFINE ls_oocqud022   LIKE oocq_t.oocqud022     
   DEFINE ls_oocqud023   LIKE oocq_t.oocqud023     
   DEFINE ls_oocqud024   LIKE oocq_t.oocqud024     
   DEFINE ls_oocqud025   LIKE oocq_t.oocqud025     
   DEFINE ls_oocqud026   LIKE oocq_t.oocqud026     
   DEFINE ls_oocqud027   LIKE oocq_t.oocqud027     
   DEFINE ls_oocqud028   LIKE oocq_t.oocqud028     
   DEFINE ls_oocqud029   LIKE oocq_t.oocqud029     
   DEFINE ls_oocqud030   LIKE oocq_t.oocqud030  
   DEFINE ls_oocql004    LIKE oocql_t.oocql004
   DEFINE ls_trantime    LIKE type_t.chr20
   DEFINE ls_status      LIKE type_t.chr10
   DEFINE ls_erpold_stus LIKE type_t.chr10
   DEFINE ls_tran_status LIKE type_t.chr2
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
#  DECLARE awsp606_process_cs CURSOR FROM ls_sql
#  FOREACH awsp606_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_middb = cl_eai_get_middb(g_dbs)
   SELECT TO_CHAR(SYSDATE-1,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_s_time FROM dual
   SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_e_time FROM dual
   #DISPLAY 'g_master.wc:',lc_param.wc
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   
   #建立TEMP TABLE
   DROP TABLE oocq_temp
   LET ls_temp_sql = "CREATE GLOBAL TEMPORARY TABLE oocq_temp ",
                     "AS SELECT * FROM ",ls_middb CLIPPED,".tra_oocq_t WHERE 1 = 0"
   EXECUTE IMMEDIATE ls_temp_sql
   
   #把這次要轉的資料依KEY值取唯一先抓到TEMP TABLE
   LET ls_sql = "INSERT INTO oocq_temp ",  
               "SELECT tra.oocqent,tra.oocq001,tra.oocq002,tra.oocqmodid,tra.status,tra.erpold_stus,tra.tran_status,tra.tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_oocq_t tra, ", 
               "(SELECT oocqent,oocq001,oocq002,max(tran_time) tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_oocq_t a ",
               "WHERE NOT EXISTS (",
               	 "SELECT 'x' ",
               	 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
               	 "WHERE wseh001 = 'tra_oocq_t'", 
               	 "   AND wseh002 = a.tran_time", 
               	 "   AND wseh004 = 'awsp606'",
               	 "   AND wseh003 = trim(a.oocqent)||'|'||trim(a.oocq001)||'|'||trim(a.oocq002))",
               " AND a.tran_time < '",ls_e_time CLIPPED,"'",
               " AND a.tran_time > '",ls_s_time CLIPPED,"'",
               " AND ",lc_param.wc,     
               " GROUP BY oocqent,oocq001,oocq002 ) d_tra",
               " WHERE tra.oocqent = d_tra.oocqent",
               " AND tra.oocq001 = d_tra.oocq001",
               " AND tra.oocq002 = d_tra.oocq002",
               " AND tra.tran_time = d_tra.tran_time"
             #DISPLAY 'ls_sql:',ls_sql  
   EXECUTE IMMEDIATE ls_sql            
   
   #select count(*) into l_count1 from oocq_temp
   #DISPLAY 'l_count1:',l_count1
   
   #組出判斷all_oocq_t是否有同樣待轉資料的語法
   LET ls_sql = "SELECT count(1) ",  
               "FROM ",ls_middb CLIPPED,".all_oocq_t a ",
               "WHERE NOT EXISTS ( ",
                      "SELECT 'x'", 
                      "  FROM ",ls_middb CLIPPED,".m_wsee_t", 
                      " WHERE wsee002 = a.tran_time", 
               	    "   AND wsee003 = trim(a.oocqent)||'|'||trim(a.oocq001)||'|'||trim(a.oocq002))",
               "  AND a.oocqent = ?",
               "  AND a.oocq001 = ?",
               "  AND a.oocq002 = ?"    
      #DISPLAY 'ls_count_sql:',ls_sql          
   PREPARE sql_chk_count FROM ls_sql

   #把資料先抓出來
   LET ls_data_sql ="SELECT oocq_t.oocqstus,oocq_t.oocq003,oocq_t.oocq004,oocq_t.oocq005,",
   "oocq_t.oocq006,oocq_t.oocq007,oocq_t.oocq008,oocq_t.oocq009,oocq_t.oocq010,",
   "oocq_t.oocq011,oocq_t.oocq012,oocq_t.oocq013,oocq_t.oocq014,oocq_t.oocq015,",
   "oocq_t.oocq016,oocq_t.oocq017,oocq_t.oocq018,oocq_t.oocq019,oocq_t.oocq020,",
   "oocq_t.oocq021,oocq_t.oocq022,oocq_t.oocq023,oocq_t.oocq024,oocq_t.oocq025,",
   "oocq_t.oocq026,oocq_t.oocq027,oocq_t.oocq028,oocq_t.oocq029,oocq_t.oocq030,",
   "oocq_t.oocq031,oocq_t.oocq032,oocq_t.oocq033,oocq_t.oocq034,oocq_t.oocq035,",
   "oocq_t.oocq036,oocq_t.oocq037,oocq_t.oocq038,oocq_t.oocq039,oocq_t.oocq040,",
   "oocq_t.oocq041,oocq_t.oocq042,oocq_t.oocq043,",
   "oocq_t.oocqud001,oocq_t.oocqud002,oocq_t.oocqud003,oocq_t.oocqud004,oocq_t.oocqud005,",
   "oocq_t.oocqud006,oocq_t.oocqud007,oocq_t.oocqud008,oocq_t.oocqud009,oocq_t.oocqud010,",
   "oocq_t.oocqud011,oocq_t.oocqud012,oocq_t.oocqud013,oocq_t.oocqud014,oocq_t.oocqud015,",
   "oocq_t.oocqud016,oocq_t.oocqud017,oocq_t.oocqud018,oocq_t.oocqud019,oocq_t.oocqud020,",
   "oocq_t.oocqud021,oocq_t.oocqud022,oocq_t.oocqud023,oocq_t.oocqud024,oocq_t.oocqud025,",
   "oocq_t.oocqud026,oocq_t.oocqud027,oocq_t.oocqud028,oocq_t.oocqud029,oocq_t.oocqud030,",
   "oocq_t.oocqownid,oocq_t.oocqowndp,oocq_t.oocqcrtid,oocq_t.oocqcrtdp,oocq_t.oocqcrtdt,",
   "oocq_t.oocqmodid,oocq_t.oocqmoddt,",
   "tra.status,tra.erpold_stus,tra.tran_status ",
   "FROM oocq_temp tra LEFT OUTER JOIN oocq_t ON ",
   " oocq_t.oocqent = tra.oocqent",
   " AND oocq_t.oocq001 = tra.oocq001",
   " AND oocq_t.oocq002 = tra.oocq002",
   " WHERE tra.oocqent = ?",
   " AND tra.oocq001 = ?",
   " AND tra.oocq002 = ?",
   " AND tra.tran_time = ?"
   #DISPLAY 'ls_data_sql:',ls_data_sql
   PREPARE sql_select_data FROM ls_data_sql
   
   #組出最後INSERT all_oocq_t資料的語法 
   LET ls_ins_sql = "INSERT INTO ",ls_middb CLIPPED,".all_oocq_t(oocqent,oocqstus,",
   "oocq001,oocq002,oocq003,oocq004,oocq005,",
   "oocq006,oocq007,oocq008,oocq009,oocq010,",
   "oocq011,oocq012,oocq013,oocq014,oocq015,",
   "oocq016,oocq017,oocq018,oocq019,oocq020,",
   "oocq021,oocq022,oocq023,oocq024,oocq025,",
   "oocq026,oocq027,oocq028,oocq029,oocq030,",
   "oocq031,oocq032,oocq033,oocq034,oocq035,",
   "oocq036,oocq037,oocq038,oocq039,oocq040,",
   "oocq041,oocq042,oocq043,",
   "oocqud001,oocqud002,oocqud003,oocqud004,oocqud005,",
   "oocqud006,oocqud007,oocqud008,oocqud009,oocqud010,",
   "oocqud011,oocqud012,oocqud013,oocqud014,oocqud015,",
   "oocqud016,oocqud017,oocqud018,oocqud019,oocqud020,",
   "oocqud021,oocqud022,oocqud023,oocqud024,oocqud025,",
   "oocqud026,oocqud027,oocqud028,oocqud029,oocqud030,",
   "oocqownid,oocqowndp,oocqcrtid,oocqcrtdp,oocqcrtdt,",
   "oocqmodid,oocqmoddt,oocql004,",
   "status,erpold_stus,tran_status,tran_time) ",
   "VALUES(?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,",   
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",   
   "?,?,?,",
   "?,?,?,?)"
   #DISPLAY 'ls_ins_sql:',ls_ins_sql
   PREPARE sql_insert_data FROM ls_ins_sql
   
   #組出最後UPDATE all_oocq_t資料的語法                       
   LET ls_upd_sql = "UPDATE ",ls_middb CLIPPED,".all_oocq_t",
                    " SET oocqent = ?,oocqstus = ?,",
                    "     oocq001 = ?,  oocq002 = ?,  oocq003 = ?,  oocq004 = ?,  oocq005 = ?,",
                    "     oocq006 = ?,  oocq007 = ?,  oocq008 = ?,  oocq009 = ?,  oocq010 = ?,",
                    "     oocq011 = ?,  oocq012 = ?,  oocq013 = ?,  oocq014 = ?,  oocq015 = ?,",
                    "     oocq016 = ?,  oocq017 = ?,  oocq018 = ?,  oocq019 = ?,  oocq020 = ?,",
                    "     oocq021 = ?,  oocq022 = ?,  oocq023 = ?,  oocq024 = ?,  oocq025 = ?,",
                    "     oocq026 = ?,  oocq027 = ?,  oocq028 = ?,  oocq029 = ?,  oocq030 = ?,",
                    "     oocq031 = ?,  oocq032 = ?,  oocq033 = ?,  oocq034 = ?,  oocq035 = ?,",
                    "     oocq036 = ?,  oocq037 = ?,  oocq038 = ?,  oocq039 = ?,  oocq040 = ?,",
                    "     oocq041 = ?,  oocq042 = ?,  oocq043 = ?,",
                    "   oocqud001 = ?,oocqud002 = ?,oocqud003 = ?,oocqud004 = ?,oocqud005 = ?,",
                    "   oocqud006 = ?,oocqud007 = ?,oocqud008 = ?,oocqud009 = ?,oocqud010 = ?,",
                    "   oocqud011 = ?,oocqud012 = ?,oocqud013 = ?,oocqud014 = ?,oocqud015 = ?,",
                    "   oocqud016 = ?,oocqud017 = ?,oocqud018 = ?,oocqud019 = ?,oocqud020 = ?,",
                    "   oocqud021 = ?,oocqud022 = ?,oocqud023 = ?,oocqud024 = ?,oocqud025 = ?,",
                    "   oocqud026 = ?,oocqud027 = ?,oocqud028 = ?,oocqud029 = ?,oocqud030 = ?,",
                    "   oocqmodid = ?,oocqmoddt = ?, oocql004 = ?,",
                    "       status = ?,",
                    "  erpold_stus = ?,",
                    "  tran_status = ? ",
                    " WHERE oocqent = ?",
                    " AND oocq001 = ?",
                    " AND oocq002 = ?",
                    " AND tran_time > ?",
                    " AND tran_time < ?"                    
  
   #DISPLAY 'ls_upd_sql:',ls_upd_sql
   PREPARE sql_update_data FROM ls_upd_sql   

   #把TEMP TABLE資料抓出來   
   LET ls_sql = "SELECT oocqent,oocq001,oocq002,tran_time FROM oocq_temp"
   PREPARE sql_select_temptb FROM ls_sql   
   DECLARE sql_fetch_data CURSOR WITH HOLD FOR sql_select_temptb  
   OPEN sql_fetch_data
   FOREACH sql_fetch_data INTO ls_oocqent,ls_oocq001,ls_oocq002,ls_trantime
   
           #DISPLAY 'chk_count:',ls_oocqent,"|",ls_oocq001,"|",ls_oocq002,"|",ls_trantime               
           #判斷all_oocq_t是否有同樣待轉資料
           EXECUTE sql_chk_count USING ls_oocqent,ls_oocq001,ls_oocq002 INTO l_count
           
           #先把資料抓出來
           EXECUTE sql_select_data USING ls_oocqent,ls_oocq001,ls_oocq002,ls_trantime 
              INTO ls_oocqstus,ls_oocq003,ls_oocq004,ls_oocq005,
                   ls_oocq006,ls_oocq007,ls_oocq008,ls_oocq009,ls_oocq010,
                   ls_oocq011,ls_oocq012,ls_oocq013,ls_oocq014,ls_oocq015,
                   ls_oocq016,ls_oocq017,ls_oocq018,ls_oocq019,ls_oocq020,
                   ls_oocq021,ls_oocq022,ls_oocq023,ls_oocq024,ls_oocq025,
                   ls_oocq026,ls_oocq027,ls_oocq028,ls_oocq029,ls_oocq030,
                   ls_oocq031,ls_oocq032,ls_oocq033,ls_oocq034,ls_oocq035,
                   ls_oocq036,ls_oocq037,ls_oocq038,ls_oocq039,ls_oocq040,
                   ls_oocq041,ls_oocq042,ls_oocq043,
                   ls_oocqud001,ls_oocqud002,ls_oocqud003,ls_oocqud004,ls_oocqud005,
                   ls_oocqud006,ls_oocqud007,ls_oocqud008,ls_oocqud009,ls_oocqud010,
                   ls_oocqud011,ls_oocqud012,ls_oocqud013,ls_oocqud014,ls_oocqud015,
                   ls_oocqud016,ls_oocqud017,ls_oocqud018,ls_oocqud019,ls_oocqud020,
                   ls_oocqud021,ls_oocqud022,ls_oocqud023,ls_oocqud024,ls_oocqud025,
                   ls_oocqud026,ls_oocqud027,ls_oocqud028,ls_oocqud029,ls_oocqud030,
                   ls_oocqownid,ls_oocqowndp,ls_oocqcrtid,ls_oocqcrtdp,ls_oocqcrtdt,
                   ls_oocqmodid,ls_oocqmoddt,
                   ls_status,ls_erpold_stus,ls_tran_status  
              
           SELECT oocql004 INTO ls_oocql004 FROM　oocql_t WHERE oocqlent = ls_oocqent AND oocql001 = ls_oocq001 AND oocql002 = ls_oocq002 AND oocql003 = g_lang
           
           #沒同樣資料就INSERT
           IF l_count = 0 THEN

              #執行INSERT動作
              EXECUTE sql_insert_data USING ls_oocqent,ls_oocqstus,
                      ls_oocq001,ls_oocq002,ls_oocq003,ls_oocq004,ls_oocq005,
                      ls_oocq006,ls_oocq007,ls_oocq008,ls_oocq009,ls_oocq010,
                      ls_oocq011,ls_oocq012,ls_oocq013,ls_oocq014,ls_oocq015,
                      ls_oocq016,ls_oocq017,ls_oocq018,ls_oocq019,ls_oocq020,
                      ls_oocq021,ls_oocq022,ls_oocq023,ls_oocq024,ls_oocq025,
                      ls_oocq026,ls_oocq027,ls_oocq028,ls_oocq029,ls_oocq030,
                      ls_oocq031,ls_oocq032,ls_oocq033,ls_oocq034,ls_oocq035,
                      ls_oocq036,ls_oocq037,ls_oocq038,ls_oocq039,ls_oocq040,
                      ls_oocq041,ls_oocq042,ls_oocq043,
                      ls_oocqud001,ls_oocqud002,ls_oocqud003,ls_oocqud004,ls_oocqud005,
                      ls_oocqud006,ls_oocqud007,ls_oocqud008,ls_oocqud009,ls_oocqud010,
                      ls_oocqud011,ls_oocqud012,ls_oocqud013,ls_oocqud014,ls_oocqud015,
                      ls_oocqud016,ls_oocqud017,ls_oocqud018,ls_oocqud019,ls_oocqud020,
                      ls_oocqud021,ls_oocqud022,ls_oocqud023,ls_oocqud024,ls_oocqud025,
                      ls_oocqud026,ls_oocqud027,ls_oocqud028,ls_oocqud029,ls_oocqud030,
                      ls_oocqownid,ls_oocqowndp,ls_oocqcrtid,ls_oocqcrtdp,ls_oocqcrtdt,
                      ls_oocqmodid,ls_oocqmoddt,ls_oocql004,
                      ls_status,ls_erpold_stus,ls_tran_status,ls_trantime

              DISPLAY 'insert:',ls_oocqent,"|",ls_oocq001,"|",ls_oocq002,"|",ls_status,"|",ls_trantime              
           ELSE
              #有待轉資料就UPDATE
                                  
              #執行UPDATE動作
              EXECUTE sql_update_data USING 
                      ls_oocqent,ls_oocqstus,
                      ls_oocq001,ls_oocq002,ls_oocq003,ls_oocq004,ls_oocq005,
                      ls_oocq006,ls_oocq007,ls_oocq008,ls_oocq009,ls_oocq010,
                      ls_oocq011,ls_oocq012,ls_oocq013,ls_oocq014,ls_oocq015,
                      ls_oocq016,ls_oocq017,ls_oocq018,ls_oocq019,ls_oocq020,
                      ls_oocq021,ls_oocq022,ls_oocq023,ls_oocq024,ls_oocq025,
                      ls_oocq026,ls_oocq027,ls_oocq028,ls_oocq029,ls_oocq030,
                      ls_oocq031,ls_oocq032,ls_oocq033,ls_oocq034,ls_oocq035,
                      ls_oocq036,ls_oocq037,ls_oocq038,ls_oocq039,ls_oocq040,
                      ls_oocq041,ls_oocq042,ls_oocq043,
                      ls_oocqud001,ls_oocqud002,ls_oocqud003,ls_oocqud004,ls_oocqud005,
                      ls_oocqud006,ls_oocqud007,ls_oocqud008,ls_oocqud009,ls_oocqud010,
                      ls_oocqud011,ls_oocqud012,ls_oocqud013,ls_oocqud014,ls_oocqud015,
                      ls_oocqud016,ls_oocqud017,ls_oocqud018,ls_oocqud019,ls_oocqud020,
                      ls_oocqud021,ls_oocqud022,ls_oocqud023,ls_oocqud024,ls_oocqud025,
                      ls_oocqud026,ls_oocqud027,ls_oocqud028,ls_oocqud029,ls_oocqud030,
                      ls_oocqmodid,ls_oocqmoddt,ls_oocql004,                      
                      ls_status,ls_erpold_stus,ls_tran_status,
                      ls_oocqent,ls_oocq001,ls_oocq002,ls_s_time,ls_e_time
              DISPLAY 'update:',ls_oocqent,"|",ls_oocq001,"|",ls_oocq002,"|",ls_status,"|",ls_trantime                      
           END IF
           
           IF SQLCA.SQLCODE THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE 
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              
              #先把key值欄位組出來
              LET ls_key = ls_oocqent CLIPPED,'|',ls_oocq001 CLIPPED,'|',ls_oocq002              
              #把錯誤寫入m_wsei_t
              LET ls_err_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wsei_t ",
                               "(wsei001,wsei002,wsei003,wsei004,wsei005,wsei006,wsei007) ",
                               "VALUES('tra_oocq_t','",ls_trantime CLIPPED,"','",ls_key CLIPPED,"',",
                               "'awsp606','",ls_e_time,"','",SQLCA.SQLCODE,"','",SQLERRMESSAGE,"')"
              EXECUTE IMMEDIATE ls_err_sql                 
              #DISPLAY 'ls_err_sql:',ls_err_sql                
              CALL cl_err()
               
           ELSE
              #寫入all_oocq_t後依KEY值條件把所有待轉的記錄寫入m_wseh_t      
               LET ls_wseh_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wseh_t ",
                                 "SELECT 'tra_oocq_t',a.tran_time,trim(a.oocqent)||'|'||trim(a.oocq001)||'|'||trim(a.oocq002),'awsp606' ",
                                 "FROM ",ls_middb CLIPPED,".tra_oocq_t a ",
                                 "WHERE NOT EXISTS (",
                                 "SELECT 'x' ",
                                 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
                                 "WHERE wseh001 = 'tra_oocq_t'", 
                                 "   AND wseh002 = a.tran_time", 
                                 "   AND wseh004 = 'awsp606'",
                                 "   AND wseh003 = trim(a.oocqent)||'|'||trim(a.oocq001)||'|'||trim(a.oocq002))", 
                                 " AND a.oocqent = ",ls_oocqent CLIPPED,
                                 " AND a.oocq001 = '",ls_oocq001 CLIPPED,"'",
                                 " AND a.oocq002 = '",ls_oocq002 CLIPPED,"'",
                                 " AND a.tran_time < '",ls_e_time CLIPPED,"'",
                                 " AND a.tran_time > '",ls_s_time CLIPPED,"'"
               #DISPLAY 'ls_wseh_sql:',ls_wseh_sql                  
               EXECUTE IMMEDIATE ls_wseh_sql
                  
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()         
         
               END IF 

           END IF
   
   END FOREACH
  
   FREE sql_chk_count
   FREE sql_select_data
   FREE sql_select_temptb
   FREE sql_fetch_data
   FREE sql_insert_data
   FREE sql_update_data
   DROP TABLE oocq_temp 
   CALL s_transaction_end('Y','0')
   CALL cl_err_collect_show()
   
      
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
   CALL awsp606_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp606.get_buffer" >}
PRIVATE FUNCTION awsp606_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="awsp606.msgcentre_notify" >}
PRIVATE FUNCTION awsp606_msgcentre_notify()
 
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
 
{<section id="awsp606.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
