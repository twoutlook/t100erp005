#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp614.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-03 17:20:34), PR版次:0001(2016-04-28 16:48:59)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: awsp614
#+ Description: 工作站基本資料批次作業
#+ Creator....: 07556(2016-03-22 16:22:51)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsp614.global" >}
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
       ecaaent LIKE type_t.num5, 
   ecaasite LIKE type_t.chr10, 
   ecaa001 LIKE type_t.chr10, 
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
 
{<section id="awsp614.main" >}
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
      CALL awsp614_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp614 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp614_init()
 
      #進入選單 Menu (="N")
      CALL awsp614_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp614
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp614.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp614_init()
 
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
 
{<section id="awsp614.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp614_ui_dialog()
 
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
         CONSTRUCT BY NAME g_master.wc ON ecaaent,ecaasite,ecaa001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecaaent
            #add-point:BEFORE FIELD ecaaent name="construct.b.ecaaent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecaaent
            
            #add-point:AFTER FIELD ecaaent name="construct.a.ecaaent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ecaaent
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecaaent
            #add-point:ON ACTION controlp INFIELD ecaaent name="construct.c.ecaaent"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_wseg001()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO ecaaent  #顯示到畫面上
            #NEXT FIELD ecaaent                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecaasite
            #add-point:BEFORE FIELD ecaasite name="construct.b.ecaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecaasite
            
            #add-point:AFTER FIELD ecaasite name="construct.a.ecaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.ecaasite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecaasite
            #add-point:ON ACTION controlp INFIELD ecaasite name="construct.c.ecaasite"
            
            #END add-point
 
 
         #Ctrlp:construct.c.ecaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ecaa001
            #add-point:ON ACTION controlp INFIELD ecaa001 name="construct.c.ecaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ecaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO ecaa001  #顯示到畫面上
            NEXT FIELD ecaa001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ecaa001
            #add-point:BEFORE FIELD ecaa001 name="construct.b.ecaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ecaa001
            
            #add-point:AFTER FIELD ecaa001 name="construct.a.ecaa001"
            
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
            CALL awsp614_get_buffer(l_dialog)
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
         CALL awsp614_init()
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
                 CALL awsp614_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp614_transfer_argv(ls_js)
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
 
{<section id="awsp614.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp614_transfer_argv(ls_js)
 
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
 
{<section id="awsp614.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp614_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE ls_wseh_sql   STRING
   DEFINE ls_ins_sql    STRING
   DEFINE ls_upd_sql    STRING
   DEFINE ls_middb      STRING
   DEFINE ls_s_time       LIKE type_t.chr20
   DEFINE ls_e_time       LIKE type_t.chr20
   DEFINE ls_temp_sql   STRING
   DEFINE ls_data_sql   STRING
   DEFINE ls_err_sql    STRING
   DEFINE ls_key        STRING
   DEFINE l_count       LIKE type_t.num10
   DEFINE ls_ecaaent    LIKE ecaa_t.ecaaent   
   DEFINE ls_ecaasite   LIKE ecaa_t.ecaasite    
   DEFINE ls_ecaaownid  LIKE ecaa_t.ecaaownid     
   DEFINE ls_ecaaowndp  LIKE ecaa_t.ecaaowndp     
   DEFINE ls_ecaacrtid  LIKE ecaa_t.ecaacrtid     
   DEFINE ls_ecaacrtdp  LIKE ecaa_t.ecaacrtdp     
   DEFINE ls_ecaacrtdt  LIKE ecaa_t.ecaacrtdt     
   DEFINE ls_ecaamodid  LIKE ecaa_t.ecaamodid     
   DEFINE ls_ecaamoddt  LIKE ecaa_t.ecaamoddt     
   DEFINE ls_ecaastus   LIKE ecaa_t.ecaastus    
   DEFINE ls_ecaa001    LIKE ecaa_t.ecaa001   
   DEFINE ls_ecaa002    LIKE ecaa_t.ecaa002   
   DEFINE ls_ecaa003    LIKE ecaa_t.ecaa003   
   DEFINE ls_ecaa004    LIKE ecaa_t.ecaa004   
   DEFINE ls_ecaa005    LIKE ecaa_t.ecaa005   
   DEFINE ls_ecaa006    LIKE ecaa_t.ecaa006   
   DEFINE ls_ecaa007    LIKE ecaa_t.ecaa007   
   DEFINE ls_ecaa008    LIKE ecaa_t.ecaa008   
   DEFINE ls_ecaa009    LIKE ecaa_t.ecaa009   
   DEFINE ls_ecaa010    LIKE ecaa_t.ecaa010   
   DEFINE ls_ecaa011    LIKE ecaa_t.ecaa011   
   DEFINE ls_ecaaud001  LIKE ecaa_t.ecaaud001     
   DEFINE ls_ecaaud002  LIKE ecaa_t.ecaaud002     
   DEFINE ls_ecaaud003  LIKE ecaa_t.ecaaud003     
   DEFINE ls_ecaaud004  LIKE ecaa_t.ecaaud004     
   DEFINE ls_ecaaud005  LIKE ecaa_t.ecaaud005     
   DEFINE ls_ecaaud006  LIKE ecaa_t.ecaaud006     
   DEFINE ls_ecaaud007  LIKE ecaa_t.ecaaud007     
   DEFINE ls_ecaaud008  LIKE ecaa_t.ecaaud008     
   DEFINE ls_ecaaud009  LIKE ecaa_t.ecaaud009     
   DEFINE ls_ecaaud010  LIKE ecaa_t.ecaaud010     
   DEFINE ls_ecaaud011  LIKE ecaa_t.ecaaud011     
   DEFINE ls_ecaaud012  LIKE ecaa_t.ecaaud012     
   DEFINE ls_ecaaud013  LIKE ecaa_t.ecaaud013     
   DEFINE ls_ecaaud014  LIKE ecaa_t.ecaaud014     
   DEFINE ls_ecaaud015  LIKE ecaa_t.ecaaud015     
   DEFINE ls_ecaaud016  LIKE ecaa_t.ecaaud016     
   DEFINE ls_ecaaud017  LIKE ecaa_t.ecaaud017     
   DEFINE ls_ecaaud018  LIKE ecaa_t.ecaaud018     
   DEFINE ls_ecaaud019  LIKE ecaa_t.ecaaud019     
   DEFINE ls_ecaaud020  LIKE ecaa_t.ecaaud020     
   DEFINE ls_ecaaud021  LIKE ecaa_t.ecaaud021     
   DEFINE ls_ecaaud022  LIKE ecaa_t.ecaaud022     
   DEFINE ls_ecaaud023  LIKE ecaa_t.ecaaud023     
   DEFINE ls_ecaaud024  LIKE ecaa_t.ecaaud024     
   DEFINE ls_ecaaud025  LIKE ecaa_t.ecaaud025     
   DEFINE ls_ecaaud026  LIKE ecaa_t.ecaaud026     
   DEFINE ls_ecaaud027  LIKE ecaa_t.ecaaud027     
   DEFINE ls_ecaaud028  LIKE ecaa_t.ecaaud028     
   DEFINE ls_ecaaud029  LIKE ecaa_t.ecaaud029     
   DEFINE ls_ecaaud030  LIKE ecaa_t.ecaaud030   
   DEFINE ls_trantime   LIKE type_t.chr20
   DEFINE ls_status     LIKE type_t.chr10
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
#  DECLARE awsp614_process_cs CURSOR FROM ls_sql
#  FOREACH awsp614_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_middb = cl_eai_get_middb(g_dbs)
   SELECT TO_CHAR(SYSDATE-1,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_s_time FROM dual
   SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_e_time FROM dual
   #DISPLAY 'g_master.wc:',lc_param.wc
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   
   #建立TEMP TABLE
   DROP TABLE ecaa_temp
   LET ls_temp_sql = "CREATE GLOBAL TEMPORARY TABLE ecaa_temp ",
                     "AS SELECT * FROM ",ls_middb CLIPPED,".tra_ecaa_t WHERE 1 = 0"
   EXECUTE IMMEDIATE ls_temp_sql
   
   #把這次要轉的資料依KEY值取唯一先抓到TEMP TABLE
   LET ls_sql = "INSERT INTO ecaa_temp ",  
               "SELECT tra.ecaaent,tra.ecaasite,tra.ecaa001,tra.ecaamodid,tra.status,tra.erpold_stus,tra.tran_status,tra.tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_ecaa_t tra, ", 
               "(SELECT ecaaent,ecaasite,ecaa001,max(tran_time) tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_ecaa_t a ",
               "WHERE NOT EXISTS (",
               	 "SELECT 'x' ",
               	 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
               	 "WHERE wseh001 = 'tra_ecaa_t'", 
               	 "   AND wseh002 = a.tran_time", 
               	 "   AND wseh004 = 'awsp614'",
               	 "   AND wseh003 = trim(a.ecaaent)||'|'||trim(a.ecaasite)||'|'||trim(a.ecaa001))",
               " AND a.tran_time < '",ls_e_time CLIPPED,"'",
               " AND a.tran_time > '",ls_s_time CLIPPED,"'",
               " AND ",lc_param.wc,     
               " GROUP BY ecaaent,ecaasite,ecaa001 ) d_tra",
               " WHERE tra.ecaaent = d_tra.ecaaent",
               " AND tra.ecaasite = d_tra.ecaasite",
               " AND tra.ecaa001 = d_tra.ecaa001",
               " AND tra.tran_time = d_tra.tran_time"
             #DISPLAY 'ls_sql:',ls_sql  
   EXECUTE IMMEDIATE ls_sql            
   
   #select count(*) into l_count1 from ecaa_temp
   #DISPLAY 'l_count1:',l_count1
   
   #組出判斷all_ecaa_t是否有同樣待轉資料的語法
   LET ls_sql = "SELECT count(1) ",  
               "FROM ",ls_middb CLIPPED,".all_ecaa_t a ",
               "WHERE NOT EXISTS ( ",
                      "SELECT 'x'", 
                      "  FROM ",ls_middb CLIPPED,".m_wsee_t", 
                      " WHERE wsee002 = a.tran_time", 
                      "   AND wsee003 = trim(a.ecaaent)||'|'||trim(a.ecaasite)||'|'||trim(a.ecaa001))",
               "  AND a.ecaaent = ?",
               "  AND a.ecaasite = ?",
               "  AND a.ecaa001 = ?"   
      #DISPLAY 'ls_count_sql:',ls_sql          
   PREPARE sql_chk_count FROM ls_sql

   #把資料先抓出來
   LET ls_data_sql ="SELECT ",
   "ecaa_t.ecaaownid,ecaa_t.ecaaowndp,ecaa_t.ecaacrtid,ecaa_t.ecaacrtdp,ecaa_t.ecaacrtdt,",
   "ecaa_t.ecaamodid,ecaa_t.ecaamoddt,ecaa_t.ecaastus,",
   "ecaa_t.ecaa002,ecaa_t.ecaa003,ecaa_t.ecaa004,ecaa_t.ecaa005,ecaa_t.ecaa006,",
   "ecaa_t.ecaa007,ecaa_t.ecaa008,ecaa_t.ecaa009,ecaa_t.ecaa010,ecaa_t.ecaa011,",
   "ecaa_t.ecaaud001,ecaa_t.ecaaud002,ecaa_t.ecaaud003,ecaa_t.ecaaud004,ecaa_t.ecaaud005,",
   "ecaa_t.ecaaud006,ecaa_t.ecaaud007,ecaa_t.ecaaud008,ecaa_t.ecaaud009,ecaa_t.ecaaud010,",
   "ecaa_t.ecaaud011,ecaa_t.ecaaud012,ecaa_t.ecaaud013,ecaa_t.ecaaud014,ecaa_t.ecaaud015,",
   "ecaa_t.ecaaud016,ecaa_t.ecaaud017,ecaa_t.ecaaud018,ecaa_t.ecaaud019,ecaa_t.ecaaud020,",
   "ecaa_t.ecaaud021,ecaa_t.ecaaud022,ecaa_t.ecaaud023,ecaa_t.ecaaud024,ecaa_t.ecaaud025,",
   "ecaa_t.ecaaud026,ecaa_t.ecaaud027,ecaa_t.ecaaud028,ecaa_t.ecaaud029,ecaa_t.ecaaud030,",
   "tra.status,tra.erpold_stus,tra.tran_status ",
   "FROM ecaa_temp tra LEFT OUTER JOIN ecaa_t ON ",
   " ecaa_t.ecaaent = tra.ecaaent",
   " AND ecaa_t.ecaasite = tra.ecaasite",
   " AND ecaa_t.ecaa001 = tra.ecaa001",
   " WHERE tra.ecaaent = ?",
   " AND tra.ecaasite = ?",
   " AND tra.ecaa001 = ?",
   " AND tra.tran_time = ?"
   #DISPLAY 'ls_data_sql:',ls_data_sql
   PREPARE sql_select_data FROM ls_data_sql
   
   #組出最後INSERT all_ecaa_t資料的語法 
   LET ls_ins_sql = "INSERT INTO ",ls_middb CLIPPED,".all_ecaa_t(ecaaent,ecaasite,ecaa001,",
   "ecaamodid,ecaamoddt,ecaastus,",
   "ecaaownid,ecaaowndp,ecaacrtid,ecaacrtdp,ecaacrtdt,", 
   "ecaa002,ecaa003,ecaa004,ecaa005,ecaa006,",
   "ecaa007,ecaa008,ecaa009,ecaa010,ecaa011,",                     
   "ecaaud001,ecaaud002,ecaaud003,ecaaud004,ecaaud005,",
   "ecaaud006,ecaaud007,ecaaud008,ecaaud009,ecaaud010,",
   "ecaaud011,ecaaud012,ecaaud013,ecaaud014,ecaaud015,",
   "ecaaud016,ecaaud017,ecaaud018,ecaaud019,ecaaud020,",
   "ecaaud021,ecaaud022,ecaaud023,ecaaud024,ecaaud025,",
   "ecaaud026,ecaaud027,ecaaud028,ecaaud029,ecaaud030,",
   "status,erpold_stus,tran_status,tran_time) ",
   "VALUES(?,?,?,",
   "?,?,?,",   
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?)"
   #DISPLAY 'ls_ins_sql:',ls_ins_sql
   PREPARE sql_insert_data FROM ls_ins_sql
   
   #組出最後UPDATE all_ecaa_t資料的語法                       
   LET ls_upd_sql = "UPDATE ",ls_middb CLIPPED,".all_ecaa_t SET ",
                    "      ecaamodid = ?,ecaamoddt = ?,ecaastus = ?,",
                    "      ecaa002 = ?,ecaa003 = ?,ecaa004 = ?,ecaa005 = ?,ecaa006 = ?,", 
                    "      ecaa007 = ?,ecaa008 = ?,ecaa009 = ?,ecaa010 = ?,ecaa011 = ?,", 
                    "      ecaaud001 = ?,ecaaud002 = ?,ecaaud003 = ?,ecaaud004 = ?,ecaaud005 = ?,",
                    "      ecaaud006 = ?,ecaaud007 = ?,ecaaud008 = ?,ecaaud009 = ?,ecaaud010 = ?,",
                    "      ecaaud011 = ?,ecaaud012 = ?,ecaaud013 = ?,ecaaud014 = ?,ecaaud015 = ?,",
                    "      ecaaud016 = ?,ecaaud017 = ?,ecaaud018 = ?,ecaaud019 = ?,ecaaud020 = ?,",
                    "      ecaaud021 = ?,ecaaud022 = ?,ecaaud023 = ?,ecaaud024 = ?,ecaaud025 = ?,",
                    "      ecaaud026 = ?,ecaaud027 = ?,ecaaud028 = ?,ecaaud029 = ?,ecaaud030 = ?,",
                    "      status = ?,",
                    " erpold_stus = ?,",
                    " tran_status = ? ",
                    " WHERE ecaaent = ?",
                    " AND ecaasite = ?",
                    " AND ecaa001 = ?",
                    " AND tran_time > ?",
                    " AND tran_time < ?"                      
  
   #DISPLAY 'ls_upd_sql:',ls_upd_sql
   PREPARE sql_update_data FROM ls_upd_sql   

   #把TEMP TABLE資料抓出來   
   LET ls_sql = "SELECT ecaaent,ecaasite,ecaa001,tran_time FROM ecaa_temp"
   PREPARE sql_select_temptb FROM ls_sql   
   DECLARE sql_fetch_data CURSOR WITH HOLD FOR sql_select_temptb  
   OPEN sql_fetch_data
   FOREACH sql_fetch_data INTO ls_ecaaent,ls_ecaasite,ls_ecaa001,ls_trantime
   
           #DISPLAY 'chk_count:',ls_ecaaent,"|",ls_ecaasite,"|",ls_ecaa001,"|",ls_trantime               
           #判斷all_ecaa_t是否有同樣待轉資料
           EXECUTE sql_chk_count USING ls_ecaaent,ls_ecaasite,ls_ecaa001 INTO l_count
           
           #先把資料抓出來
           EXECUTE sql_select_data USING ls_ecaaent,ls_ecaasite,ls_ecaa001,ls_trantime
              INTO ls_ecaaownid,ls_ecaaowndp,ls_ecaacrtid,ls_ecaacrtdp,ls_ecaacrtdt,
                   ls_ecaamodid,ls_ecaamoddt,ls_ecaastus,
                   ls_ecaa002,ls_ecaa003,ls_ecaa004,ls_ecaa005,ls_ecaa006,
                   ls_ecaa007,ls_ecaa008,ls_ecaa009,ls_ecaa010,ls_ecaa011,
                   ls_ecaaud001,ls_ecaaud002,ls_ecaaud003,ls_ecaaud004,ls_ecaaud005,
                   ls_ecaaud006,ls_ecaaud007,ls_ecaaud008,ls_ecaaud009,ls_ecaaud010,
                   ls_ecaaud011,ls_ecaaud012,ls_ecaaud013,ls_ecaaud014,ls_ecaaud015,
                   ls_ecaaud016,ls_ecaaud017,ls_ecaaud018,ls_ecaaud019,ls_ecaaud020,
                   ls_ecaaud021,ls_ecaaud022,ls_ecaaud023,ls_ecaaud024,ls_ecaaud025,
                   ls_ecaaud026,ls_ecaaud027,ls_ecaaud028,ls_ecaaud029,ls_ecaaud030,              
                   ls_status,ls_erpold_stus,ls_tran_status           
           
           #沒同樣資料就INSERT
           IF l_count = 0 THEN

              #執行INSERT動作
              EXECUTE sql_insert_data USING ls_ecaaent,ls_ecaasite,ls_ecaa001,
                      ls_ecaamodid,ls_ecaamoddt,ls_ecaastus,
                      ls_ecaaownid,ls_ecaaowndp,ls_ecaacrtid,ls_ecaacrtdp,ls_ecaacrtdt,
                      ls_ecaa002,ls_ecaa003,ls_ecaa004,ls_ecaa005,ls_ecaa006,
                      ls_ecaa007,ls_ecaa008,ls_ecaa009,ls_ecaa010,ls_ecaa011,
                      ls_ecaaud001,ls_ecaaud002,ls_ecaaud003,ls_ecaaud004,ls_ecaaud005,
                      ls_ecaaud006,ls_ecaaud007,ls_ecaaud008,ls_ecaaud009,ls_ecaaud010,
                      ls_ecaaud011,ls_ecaaud012,ls_ecaaud013,ls_ecaaud014,ls_ecaaud015,
                      ls_ecaaud016,ls_ecaaud017,ls_ecaaud018,ls_ecaaud019,ls_ecaaud020,
                      ls_ecaaud021,ls_ecaaud022,ls_ecaaud023,ls_ecaaud024,ls_ecaaud025,
                      ls_ecaaud026,ls_ecaaud027,ls_ecaaud028,ls_ecaaud029,ls_ecaaud030,     
                      ls_status,ls_erpold_stus,ls_tran_status,ls_trantime

              DISPLAY 'insert:',ls_ecaaent,"|",ls_ecaasite,"|",ls_ecaa001,"|",ls_status,"|",ls_trantime              
           ELSE
              #有待轉資料就UPDATE
                                  
              #執行UPDATE動作
              EXECUTE sql_update_data USING 
                      ls_ecaamodid,ls_ecaamoddt,ls_ecaastus,
                      ls_ecaa002,ls_ecaa003,ls_ecaa004,ls_ecaa005,ls_ecaa006,
                      ls_ecaa007,ls_ecaa008,ls_ecaa009,ls_ecaa010,ls_ecaa011,
                      ls_ecaaud001,ls_ecaaud002,ls_ecaaud003,ls_ecaaud004,ls_ecaaud005,
                      ls_ecaaud006,ls_ecaaud007,ls_ecaaud008,ls_ecaaud009,ls_ecaaud010,
                      ls_ecaaud011,ls_ecaaud012,ls_ecaaud013,ls_ecaaud014,ls_ecaaud015,
                      ls_ecaaud016,ls_ecaaud017,ls_ecaaud018,ls_ecaaud019,ls_ecaaud020,
                      ls_ecaaud021,ls_ecaaud022,ls_ecaaud023,ls_ecaaud024,ls_ecaaud025,
                      ls_ecaaud026,ls_ecaaud027,ls_ecaaud028,ls_ecaaud029,ls_ecaaud030,              
                      ls_status,ls_erpold_stus,ls_tran_status,  
                      ls_ecaaent,ls_ecaasite,ls_ecaa001,ls_s_time,ls_e_time
              DISPLAY 'update:',ls_ecaaent,"|",ls_ecaasite,"|",ls_ecaa001,"|",ls_status,"|",ls_trantime                      
           END IF
           
           IF SQLCA.SQLCODE THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE 
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              
              #先把key值欄位組出來
              LET ls_key = ls_ecaaent CLIPPED,'|',ls_ecaasite CLIPPED,'|',ls_ecaa001           
              #把錯誤寫入m_wsei_t
              LET ls_err_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wsei_t ",
                               "(wsei001,wsei002,wsei003,wsei004,wsei005,wsei006,wsei007) ",
                               "VALUES('tra_ecaa_t','",ls_trantime CLIPPED,"','",ls_key CLIPPED,"',",
                               "'awsp614','",ls_e_time,"','",SQLCA.SQLCODE,"','",SQLERRMESSAGE,"')"
              EXECUTE IMMEDIATE ls_err_sql                 
              #DISPLAY 'ls_err_sql:',ls_err_sql                
              CALL cl_err()
               
           ELSE
              #寫入all_ecaa_t後依KEY值條件把所有待轉的記錄寫入m_wseh_t      
               LET ls_wseh_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wseh_t ",
                                 "SELECT 'tra_ecaa_t',a.tran_time,trim(a.ecaaent)||'|'||trim(a.ecaasite)||'|'||trim(a.ecaa001),'awsp614' ",
                                 "FROM ",ls_middb CLIPPED,".tra_ecaa_t a ",
                                 "WHERE NOT EXISTS (",
                                 "SELECT 'x' ",
                                 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
                                 "WHERE wseh001 = 'tra_ecaa_t'", 
                                 "   AND wseh002 = a.tran_time", 
                                 "   AND wseh004 = 'awsp614'",
                                 "   AND wseh003 = trim(a.ecaaent)||'|'||trim(a.ecaasite)||'|'||trim(a.ecaa001))", 
                                 " AND a.ecaaent = ",ls_ecaaent CLIPPED,
                                 " AND a.ecaasite = '",ls_ecaasite CLIPPED,"'",
                                 " AND a.ecaa001 = '",ls_ecaa001 CLIPPED,"'",
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
   DROP TABLE ecaa_temp 
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
   CALL awsp614_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp614.get_buffer" >}
PRIVATE FUNCTION awsp614_get_buffer(p_dialog)
 
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
 
{<section id="awsp614.msgcentre_notify" >}
PRIVATE FUNCTION awsp614_msgcentre_notify()
 
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
 
{<section id="awsp614.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
