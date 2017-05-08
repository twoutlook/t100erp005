#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp608.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-03 17:25:13), PR版次:0001(2016-04-28 16:42:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: awsp608
#+ Description: 庫位基本資料檔批次作業
#+ Creator....: 07556(2016-03-22 16:20:18)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsp608.global" >}
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
       inaaent LIKE type_t.num5, 
   inaasite LIKE type_t.chr10, 
   inaa001 LIKE type_t.chr10, 
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
 
{<section id="awsp608.main" >}
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
      CALL awsp608_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp608 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp608_init()
 
      #進入選單 Menu (="N")
      CALL awsp608_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp608
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp608.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp608_init()
 
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
 
{<section id="awsp608.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp608_ui_dialog()
 
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
         CONSTRUCT BY NAME g_master.wc ON inaaent,inaasite,inaa001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaaent
            #add-point:BEFORE FIELD inaaent name="construct.b.inaaent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaaent
            
            #add-point:AFTER FIELD inaaent name="construct.a.inaaent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaaent
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaaent
            #add-point:ON ACTION controlp INFIELD inaaent name="construct.c.inaaent"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_wseg001()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO inaaent  #顯示到畫面上
            #NEXT FIELD inaaent                     #返回原欄位
    



            #END add-point
 
 
         #Ctrlp:construct.c.inaasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaasite
            #add-point:ON ACTION controlp INFIELD inaasite name="construct.c.inaasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaasite  #顯示到畫面上
            NEXT FIELD inaasite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaasite
            #add-point:BEFORE FIELD inaasite name="construct.b.inaasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaasite
            
            #add-point:AFTER FIELD inaasite name="construct.a.inaasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inaa001
            #add-point:ON ACTION controlp INFIELD inaa001 name="construct.c.inaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上
            NEXT FIELD inaa001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inaa001
            #add-point:BEFORE FIELD inaa001 name="construct.b.inaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inaa001
            
            #add-point:AFTER FIELD inaa001 name="construct.a.inaa001"
            
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
            CALL awsp608_get_buffer(l_dialog)
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
         CALL awsp608_init()
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
                 CALL awsp608_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp608_transfer_argv(ls_js)
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
 
{<section id="awsp608.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp608_transfer_argv(ls_js)
 
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
 
{<section id="awsp608.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp608_process(ls_js)
 
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
   DEFINE ls_s_time     LIKE type_t.chr20
   DEFINE ls_e_time     LIKE type_t.chr20
   DEFINE ls_temp_sql   STRING
   DEFINE ls_data_sql   STRING
   DEFINE ls_err_sql    STRING
   DEFINE ls_key        STRING
   DEFINE l_count       LIKE type_t.num10
   DEFINE ls_inaaent    LIKE inaa_t.inaaent  
   DEFINE ls_inaasite   LIKE inaa_t.inaasite 
   DEFINE ls_inaaunit   LIKE inaa_t.inaaunit 
   DEFINE ls_inaa001    LIKE inaa_t.inaa001  
   DEFINE ls_inaa002    LIKE inaa_t.inaa002  
   DEFINE ls_inaa003    LIKE inaa_t.inaa003  
   DEFINE ls_inaa004    LIKE inaa_t.inaa004  
   DEFINE ls_inaa005    LIKE inaa_t.inaa005  
   DEFINE ls_inaa006    LIKE inaa_t.inaa006  
   DEFINE ls_inaa007    LIKE inaa_t.inaa007  
   DEFINE ls_inaa008    LIKE inaa_t.inaa008  
   DEFINE ls_inaa009    LIKE inaa_t.inaa009  
   DEFINE ls_inaa010    LIKE inaa_t.inaa010  
   DEFINE ls_inaa011    LIKE inaa_t.inaa011  
   DEFINE ls_inaa012    LIKE inaa_t.inaa012  
   DEFINE ls_inaa013    LIKE inaa_t.inaa013  
   DEFINE ls_inaa014    LIKE inaa_t.inaa014  
   DEFINE ls_inaa015    LIKE inaa_t.inaa015  
   DEFINE ls_inaa016    LIKE inaa_t.inaa016  
   DEFINE ls_inaa017    LIKE inaa_t.inaa017  
   DEFINE ls_inaa018    LIKE inaa_t.inaa018  
   DEFINE ls_inaa101    LIKE inaa_t.inaa101  
   DEFINE ls_inaa102    LIKE inaa_t.inaa102  
   DEFINE ls_inaa103    LIKE inaa_t.inaa103  
   DEFINE ls_inaa104    LIKE inaa_t.inaa104  
   DEFINE ls_inaa105    LIKE inaa_t.inaa105  
   DEFINE ls_inaa106    LIKE inaa_t.inaa106  
   DEFINE ls_inaa110    LIKE inaa_t.inaa110  
   DEFINE ls_inaa111    LIKE inaa_t.inaa111  
   DEFINE ls_inaa120    LIKE inaa_t.inaa120  
   DEFINE ls_inaa121    LIKE inaa_t.inaa121  
   DEFINE ls_inaa122    LIKE inaa_t.inaa122  
   DEFINE ls_inaa123    LIKE inaa_t.inaa123  
   DEFINE ls_inaa124    LIKE inaa_t.inaa124  
   DEFINE ls_inaa130    LIKE inaa_t.inaa130  
   DEFINE ls_inaastus   LIKE inaa_t.inaastus 
   DEFINE ls_inaaownid  LIKE inaa_t.inaaownid
   DEFINE ls_inaaowndp  LIKE inaa_t.inaaowndp
   DEFINE ls_inaacrtid  LIKE inaa_t.inaacrtid
   DEFINE ls_inaacrtdp  LIKE inaa_t.inaacrtdp
   DEFINE ls_inaacrtdt  LIKE inaa_t.inaacrtdt
   DEFINE ls_inaamodid  LIKE inaa_t.inaamodid
   DEFINE ls_inaamoddt  LIKE inaa_t.inaamoddt
   DEFINE ls_inaa131    LIKE inaa_t.inaa131  
   DEFINE ls_inaa132    LIKE inaa_t.inaa132  
   DEFINE ls_inaa133    LIKE inaa_t.inaa133  
   DEFINE ls_inaa134    LIKE inaa_t.inaa134  
   DEFINE ls_inaa135    LIKE inaa_t.inaa135  
   DEFINE ls_inaa136    LIKE inaa_t.inaa136  
   DEFINE ls_inaa137    LIKE inaa_t.inaa137  
   DEFINE ls_inaa138    LIKE inaa_t.inaa138  
   DEFINE ls_inaa139    LIKE inaa_t.inaa139  
   DEFINE ls_inaa140    LIKE inaa_t.inaa140  
   DEFINE ls_inaastamp  LIKE inaa_t.inaastamp
   DEFINE ls_inaaud001  LIKE inaa_t.inaaud001
   DEFINE ls_inaaud002  LIKE inaa_t.inaaud002
   DEFINE ls_inaaud003  LIKE inaa_t.inaaud003
   DEFINE ls_inaaud004  LIKE inaa_t.inaaud004
   DEFINE ls_inaaud005  LIKE inaa_t.inaaud005
   DEFINE ls_inaaud006  LIKE inaa_t.inaaud006
   DEFINE ls_inaaud007  LIKE inaa_t.inaaud007
   DEFINE ls_inaaud008  LIKE inaa_t.inaaud008
   DEFINE ls_inaaud009  LIKE inaa_t.inaaud009
   DEFINE ls_inaaud010  LIKE inaa_t.inaaud010
   DEFINE ls_inaaud011  LIKE inaa_t.inaaud011
   DEFINE ls_inaaud012  LIKE inaa_t.inaaud012
   DEFINE ls_inaaud013  LIKE inaa_t.inaaud013
   DEFINE ls_inaaud014  LIKE inaa_t.inaaud014
   DEFINE ls_inaaud015  LIKE inaa_t.inaaud015
   DEFINE ls_inaaud016  LIKE inaa_t.inaaud016
   DEFINE ls_inaaud017  LIKE inaa_t.inaaud017
   DEFINE ls_inaaud018  LIKE inaa_t.inaaud018
   DEFINE ls_inaaud019  LIKE inaa_t.inaaud019
   DEFINE ls_inaaud020  LIKE inaa_t.inaaud020
   DEFINE ls_inaaud021  LIKE inaa_t.inaaud021
   DEFINE ls_inaaud022  LIKE inaa_t.inaaud022
   DEFINE ls_inaaud023  LIKE inaa_t.inaaud023
   DEFINE ls_inaaud024  LIKE inaa_t.inaaud024
   DEFINE ls_inaaud025  LIKE inaa_t.inaaud025
   DEFINE ls_inaaud026  LIKE inaa_t.inaaud026
   DEFINE ls_inaaud027  LIKE inaa_t.inaaud027
   DEFINE ls_inaaud028  LIKE inaa_t.inaaud028
   DEFINE ls_inaaud029  LIKE inaa_t.inaaud029
   DEFINE ls_inaaud030  LIKE inaa_t.inaaud030
   DEFINE ls_inaa141    LIKE inaa_t.inaa141  
   DEFINE ls_inaa142    LIKE inaa_t.inaa142  
   DEFINE ls_inayl003   LIKE inayl_t.inayl003  
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
#  DECLARE awsp608_process_cs CURSOR FROM ls_sql
#  FOREACH awsp608_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_middb = cl_eai_get_middb(g_dbs)
   SELECT TO_CHAR(SYSDATE-1,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_s_time FROM dual
   SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_e_time FROM dual
   #DISPLAY 'g_master.wc:',lc_param.wc
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   
   #建立TEMP TABLE
   DROP TABLE inaa_temp
   LET ls_temp_sql = "CREATE GLOBAL TEMPORARY TABLE inaa_temp ",
                     "AS SELECT * FROM ",ls_middb CLIPPED,".tra_inaa_t WHERE 1 = 0"
   EXECUTE IMMEDIATE ls_temp_sql
   
   #把這次要轉的資料依KEY值取唯一先抓到TEMP TABLE
   LET ls_sql = "INSERT INTO inaa_temp ",  
               "SELECT tra.inaaent,tra.inaasite,tra.inaa001,tra.inaamodid,tra.status,tra.erpold_stus,tra.tran_status,tra.tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_inaa_t tra, ", 
               "(SELECT inaaent,inaasite,inaa001,max(tran_time) tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_inaa_t a ",
               "WHERE NOT EXISTS (",
               	 "SELECT 'x' ",
               	 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
               	 "WHERE wseh001 = 'tra_inaa_t'", 
               	 "   AND wseh002 = a.tran_time", 
               	 "   AND wseh004 = 'awsp608'",
               	 "   AND wseh003 = trim(a.inaaent)||'|'||trim(a.inaasite)||'|'||trim(a.inaa001))",
               " AND a.tran_time < '",ls_e_time CLIPPED,"'",
               " AND a.tran_time > '",ls_s_time CLIPPED,"'",
               " AND ",lc_param.wc,     
               " GROUP BY inaaent,inaasite,inaa001 ) d_tra",
               " WHERE tra.inaaent = d_tra.inaaent",
               " AND tra.inaasite = d_tra.inaasite",
               " AND tra.inaa001 = d_tra.inaa001",
               " AND tra.tran_time = d_tra.tran_time"
             #DISPLAY 'ls_sql:',ls_sql  
   EXECUTE IMMEDIATE ls_sql            
   
   #select count(*) into l_count1 from inaa_temp
   #DISPLAY 'l_count1:',l_count1
   
   #組出判斷all_inaa_t是否有同樣待轉資料的語法
   LET ls_sql = "SELECT count(1) ",  
               "FROM ",ls_middb CLIPPED,".all_inaa_t a ",
               "WHERE NOT EXISTS ( ",
                      "SELECT 'x'", 
                      "  FROM ",ls_middb CLIPPED,".m_wsee_t", 
                      " WHERE wsee002 = a.tran_time", 
                      "   AND wsee003 = trim(a.inaaent)||'|'||trim(a.inaasite)||'|'||trim(a.inaa001))",
               "  AND a.inaaent = ?",
               "  AND a.inaasite = ?",
               "  AND a.inaa001 = ?"
      #DISPLAY 'ls_count_sql:',ls_sql          
   PREPARE sql_chk_count FROM ls_sql

   #把資料先抓出來
   LET ls_data_sql ="SELECT inaa_t.inaaunit,",
   "inaa_t.inaa002,inaa_t.inaa003,inaa_t.inaa004,inaa_t.inaa005,",
   "inaa_t.inaa006,inaa_t.inaa007,inaa_t.inaa008,inaa_t.inaa009,inaa_t.inaa010,",
   "inaa_t.inaa011,inaa_t.inaa012,inaa_t.inaa013,inaa_t.inaa014,inaa_t.inaa015,",
   "inaa_t.inaa016,inaa_t.inaa017,inaa_t.inaa018,",
   "inaa_t.inaa101,inaa_t.inaa102,inaa_t.inaa103,inaa_t.inaa104,inaa_t.inaa105,inaa_t.inaa106,",
   "inaa_t.inaa110,inaa_t.inaa111,inaa_t.inaa120,inaa_t.inaa121,inaa_t.inaa122,inaa_t.inaa123,",
   "inaa_t.inaa124,inaa_t.inaa130,",
   "inaa_t.inaastus,inaa_t.inaaownid,inaa_t.inaaowndp,inaa_t.inaacrtid,inaa_t.inaacrtdp,",
   "inaa_t.inaacrtdt,inaa_t.inaamodid,inaa_t.inaamoddt,",
   "inaa_t.inaa131,inaa_t.inaa132,inaa_t.inaa133,inaa_t.inaa134,inaa_t.inaa135,",
   "inaa_t.inaa136,inaa_t.inaa137,inaa_t.inaa138,inaa_t.inaa139,inaa_t.inaa140,",
   "inaa_t.inaastamp,",
   "inaa_t.inaaud001,inaa_t.inaaud002,inaa_t.inaaud003,inaa_t.inaaud004,inaa_t.inaaud005,",
   "inaa_t.inaaud006,inaa_t.inaaud007,inaa_t.inaaud008,inaa_t.inaaud009,inaa_t.inaaud010,",
   "inaa_t.inaaud011,inaa_t.inaaud012,inaa_t.inaaud013,inaa_t.inaaud014,inaa_t.inaaud015,",
   "inaa_t.inaaud016,inaa_t.inaaud017,inaa_t.inaaud018,inaa_t.inaaud019,inaa_t.inaaud020,",
   "inaa_t.inaaud021,inaa_t.inaaud022,inaa_t.inaaud023,inaa_t.inaaud024,inaa_t.inaaud025,",
   "inaa_t.inaaud026,inaa_t.inaaud027,inaa_t.inaaud028,inaa_t.inaaud029,inaa_t.inaaud030,",
   "inaa_t.inaa141,inaa_t.inaa142,",   
   "tra.status,tra.erpold_stus,tra.tran_status",     
   " FROM inaa_temp tra LEFT OUTER JOIN inaa_t ON ",
   " inaa_t.inaaent = tra.inaaent",
   " AND inaa_t.inaasite = tra.inaasite",
   " AND inaa_t.inaa001 = tra.inaa001",
   " WHERE tra.inaaent = ?",
   " AND tra.inaasite = ?",
   " AND tra.inaa001 = ?",
   " AND tra.tran_time = ?"
   #DISPLAY 'ls_data_sql:',ls_data_sql
   PREPARE sql_select_data FROM ls_data_sql
   
   #組出最後INSERT all_inaa_t資料的語法 
   LET ls_ins_sql = "INSERT INTO ",ls_middb CLIPPED,".all_inaa_t(inaaent,inaasite,inaa001,",
   "inaaunit,inaa002,inaa003,inaa004,inaa005,",
   "inaa006,inaa007,inaa008,inaa009,inaa010,",
   "inaa011,inaa012,inaa013,inaa014,inaa015,",
   "inaa016,inaa017,inaa018,",
   "inaa101,inaa102,inaa103,inaa104,inaa105,inaa106,",
   "inaa110,inaa111,inaa120,inaa121,inaa122,inaa123,inaa124,inaa130,",
   "inaastus,inaaownid,inaaowndp,inaacrtid,inaacrtdp,",
   "inaacrtdt,inaamodid,inaamoddt,",
   "inaa131,inaa132,inaa133,inaa134,inaa135,",
   "inaa136,inaa137,inaa138,inaa139,inaa140,",
   "inaastamp,",
   "inaaud001,inaaud002,inaaud003,inaaud004,inaaud005,",
   "inaaud006,inaaud007,inaaud008,inaaud009,inaaud010,",
   "inaaud011,inaaud012,inaaud013,inaaud014,inaaud015,",
   "inaaud016,inaaud017,inaaud018,inaaud019,inaaud020,",
   "inaaud021,inaaud022,inaaud023,inaaud024,inaaud025,",
   "inaaud026,inaaud027,inaaud028,inaaud029,inaaud030,",
   "inaa141,inaa142,inayl003,", 
   "status,erpold_stus,tran_status,tran_time) ",
   "VALUES(?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,",
   "?,?,?,?,?,?,",
   "?,?,?,?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,",
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
   
   #組出最後UPDATE all_inaa_t資料的語法                       
   LET ls_upd_sql = "UPDATE ",ls_middb CLIPPED,".all_inaa_t",
                    " SET inaaunit = ?,",
                    "     inaa002 = ?,inaa003 = ?,inaa004 = ?,inaa005 = ?,",
                    "     inaa006 = ?,inaa007 = ?,inaa008 = ?,inaa009 = ?,inaa010 = ?,",
                    "     inaa011 = ?,inaa012 = ?,inaa013 = ?,inaa014 = ?,inaa015 = ?,",
                    "     inaa016 = ?,inaa017 = ?,inaa018 = ?,",
                    "     inaa101 = ?,inaa102 = ?,inaa103 = ?,inaa104 = ?,inaa105 = ?,inaa106 = ?,",
                    "     inaa110 = ?,inaa111 = ?,inaa120 = ?,inaa121 = ?,inaa122 = ?,inaa123 = ?,inaa124 = ?,inaa130 = ?,",
                    "     inaastus = ?,inaamodid = ?,inaamoddt = ?,",
                    "     inaa131 = ?,inaa132 = ?,inaa133 = ?,inaa134 = ?,inaa135 = ?,",
                    "     inaa136 = ?,inaa137 = ?,inaa138 = ?,inaa139 = ?,inaa140 = ?,",
                    "     inaastamp = ?,",
                    "     inaaud001 = ?,inaaud002 = ?,inaaud003 = ?,inaaud004 = ?,inaaud005 = ?,",
                    "     inaaud006 = ?,inaaud007 = ?,inaaud008 = ?,inaaud009 = ?,inaaud010 = ?,",
                    "     inaaud011 = ?,inaaud012 = ?,inaaud013 = ?,inaaud014 = ?,inaaud015 = ?,",
                    "     inaaud016 = ?,inaaud017 = ?,inaaud018 = ?,inaaud019 = ?,inaaud020 = ?,",
                    "     inaaud021 = ?,inaaud022 = ?,inaaud023 = ?,inaaud024 = ?,inaaud025 = ?,",
                    "     inaaud026 = ?,inaaud027 = ?,inaaud028 = ?,inaaud029 = ?,inaaud030 = ?,",
                    "     inaa141 = ?,inaa142 = ?,inayl003 = ?,",   
                    "      status = ?,",
                    " erpold_stus = ?,",
                    " tran_status = ? ",
                    " WHERE inaaent = ?",
                    " AND inaasite = ?",
                    " AND inaa001 = ?",
                    " AND tran_time > ?",
                    " AND tran_time < ?"                    
  
   #DISPLAY 'ls_upd_sql:',ls_upd_sql
   PREPARE sql_update_data FROM ls_upd_sql   

   #把TEMP TABLE資料抓出來   
   LET ls_sql = "SELECT inaaent,inaasite,inaa001,tran_time FROM inaa_temp"
   PREPARE sql_select_temptb FROM ls_sql   
   DECLARE sql_fetch_data CURSOR WITH HOLD FOR sql_select_temptb  
   OPEN sql_fetch_data
   FOREACH sql_fetch_data INTO ls_inaaent,ls_inaasite,ls_inaa001,ls_trantime
   
           #DISPLAY 'chk_count:',ls_inaaent,"|",ls_inaasite,"|",ls_inaa001,"|",ls_trantime               
           #判斷all_inaa_t是否有同樣待轉資料
           EXECUTE sql_chk_count USING ls_inaaent,ls_inaasite,ls_inaa001 INTO l_count
           
           #先把資料抓出來
           EXECUTE sql_select_data USING ls_inaaent,ls_inaasite,ls_inaa001,ls_trantime
              INTO ls_inaaunit,ls_inaa002,ls_inaa003,ls_inaa004,ls_inaa005,
                   ls_inaa006,ls_inaa007,ls_inaa008,ls_inaa009,ls_inaa010,
                   ls_inaa011,ls_inaa012,ls_inaa013,ls_inaa014,ls_inaa015,
                   ls_inaa016,ls_inaa017,ls_inaa018,
                   ls_inaa101,ls_inaa102,ls_inaa103,ls_inaa104,ls_inaa105,ls_inaa106,
                   ls_inaa110,ls_inaa111,ls_inaa120,ls_inaa121,ls_inaa122,ls_inaa123,ls_inaa124,ls_inaa130,
                   ls_inaastus,ls_inaaownid,ls_inaaowndp,ls_inaacrtid,ls_inaacrtdp,
                   ls_inaacrtdt,ls_inaamodid,ls_inaamoddt,
                   ls_inaa131,ls_inaa132,ls_inaa133,ls_inaa134,ls_inaa135,
                   ls_inaa136,ls_inaa137,ls_inaa138,ls_inaa139,ls_inaa140,
                   ls_inaastamp,
                   ls_inaaud001,ls_inaaud002,ls_inaaud003,ls_inaaud004,ls_inaaud005,
                   ls_inaaud006,ls_inaaud007,ls_inaaud008,ls_inaaud009,ls_inaaud010,
                   ls_inaaud011,ls_inaaud012,ls_inaaud013,ls_inaaud014,ls_inaaud015,
                   ls_inaaud016,ls_inaaud017,ls_inaaud018,ls_inaaud019,ls_inaaud020,
                   ls_inaaud021,ls_inaaud022,ls_inaaud023,ls_inaaud024,ls_inaaud025,
                   ls_inaaud026,ls_inaaud027,ls_inaaud028,ls_inaaud029,ls_inaaud030,
                   ls_inaa141,ls_inaa142,    
                   ls_status,ls_erpold_stus,ls_tran_status 
                   
           SELECT inayl003 INTO ls_inayl003 FROM　inayl_t WHERE inayl001 = ls_inaa001 AND inayl002 = g_lang
           
           #沒同樣資料就INSERT
           IF l_count = 0 THEN

              #執行INSERT動作
              EXECUTE sql_insert_data USING ls_inaaent,ls_inaasite,ls_inaa001,
                      ls_inaaunit,ls_inaa002,ls_inaa003,ls_inaa004,ls_inaa005,
                      ls_inaa006,ls_inaa007,ls_inaa008,ls_inaa009,ls_inaa010,
                      ls_inaa011,ls_inaa012,ls_inaa013,ls_inaa014,ls_inaa015,
                      ls_inaa016,ls_inaa017,ls_inaa018,
                      ls_inaa101,ls_inaa102,ls_inaa103,ls_inaa104,ls_inaa105,ls_inaa106,
                      ls_inaa110,ls_inaa111,ls_inaa120,ls_inaa121,ls_inaa122,ls_inaa123,ls_inaa124,ls_inaa130,
                      ls_inaastus,ls_inaaownid,ls_inaaowndp,ls_inaacrtid,ls_inaacrtdp,
                      ls_inaacrtdt,ls_inaamodid,ls_inaamoddt,
                      ls_inaa131,ls_inaa132,ls_inaa133,ls_inaa134,ls_inaa135,
                      ls_inaa136,ls_inaa137,ls_inaa138,ls_inaa139,ls_inaa140,
                      ls_inaastamp,
                      ls_inaaud001,ls_inaaud002,ls_inaaud003,ls_inaaud004,ls_inaaud005,
                      ls_inaaud006,ls_inaaud007,ls_inaaud008,ls_inaaud009,ls_inaaud010,
                      ls_inaaud011,ls_inaaud012,ls_inaaud013,ls_inaaud014,ls_inaaud015,
                      ls_inaaud016,ls_inaaud017,ls_inaaud018,ls_inaaud019,ls_inaaud020,
                      ls_inaaud021,ls_inaaud022,ls_inaaud023,ls_inaaud024,ls_inaaud025,
                      ls_inaaud026,ls_inaaud027,ls_inaaud028,ls_inaaud029,ls_inaaud030,
                      ls_inaa141,ls_inaa142,ls_inayl003, 
                      ls_status,ls_erpold_stus,ls_tran_status,ls_trantime

              DISPLAY 'insert:',ls_inaaent,"|",ls_inaasite,"|",ls_inaa001,"|",ls_status,"|",ls_trantime              
           ELSE
              #有待轉資料就UPDATE
                                  
              #執行UPDATE動作
              EXECUTE sql_update_data USING ls_inaaunit,ls_inaa002,ls_inaa003,ls_inaa004,ls_inaa005,
                      ls_inaa006,ls_inaa007,ls_inaa008,ls_inaa009,ls_inaa010,
                      ls_inaa011,ls_inaa012,ls_inaa013,ls_inaa014,ls_inaa015,
                      ls_inaa016,ls_inaa017,ls_inaa018,
                      ls_inaa101,ls_inaa102,ls_inaa103,ls_inaa104,ls_inaa105,ls_inaa106,
                      ls_inaa110,ls_inaa111,ls_inaa120,ls_inaa121,ls_inaa122,ls_inaa123,ls_inaa124,ls_inaa130,
                      ls_inaastus,ls_inaamodid,ls_inaamoddt,
                      ls_inaa131,ls_inaa132,ls_inaa133,ls_inaa134,ls_inaa135,
                      ls_inaa136,ls_inaa137,ls_inaa138,ls_inaa139,ls_inaa140,
                      ls_inaastamp,
                      ls_inaaud001,ls_inaaud002,ls_inaaud003,ls_inaaud004,ls_inaaud005,
                      ls_inaaud006,ls_inaaud007,ls_inaaud008,ls_inaaud009,ls_inaaud010,
                      ls_inaaud011,ls_inaaud012,ls_inaaud013,ls_inaaud014,ls_inaaud015,
                      ls_inaaud016,ls_inaaud017,ls_inaaud018,ls_inaaud019,ls_inaaud020,
                      ls_inaaud021,ls_inaaud022,ls_inaaud023,ls_inaaud024,ls_inaaud025,
                      ls_inaaud026,ls_inaaud027,ls_inaaud028,ls_inaaud029,ls_inaaud030,
                      ls_inaa141,ls_inaa142,ls_inayl003,                          
                      ls_status,ls_erpold_stus,ls_tran_status,
                      ls_inaaent,ls_inaasite,ls_inaa001,ls_s_time,ls_e_time
              DISPLAY 'update:',ls_inaaent,"|",ls_inaasite,"|",ls_inaa001,"|",ls_status,"|",ls_trantime                      
           END IF
           
           IF SQLCA.SQLCODE THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE 
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              
              #先把key值欄位組出來
              LET ls_key = ls_inaaent CLIPPED,'|',ls_inaasite CLIPPED,'|',ls_inaa001              
              #把錯誤寫入m_wsei_t
              LET ls_err_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wsei_t ",
                               "(wsei001,wsei002,wsei003,wsei004,wsei005,wsei006,wsei007) ",
                               "VALUES('tra_inaa_t','",ls_trantime CLIPPED,"','",ls_key CLIPPED,"',",
                               "'awsp608','",ls_e_time,"','",SQLCA.SQLCODE,"','",SQLERRMESSAGE,"')"
              EXECUTE IMMEDIATE ls_err_sql                 
              #DISPLAY 'ls_err_sql:',ls_err_sql                
              CALL cl_err()
               
           ELSE
              #寫入all_inaa_t後依KEY值條件把所有待轉的記錄寫入m_wseh_t                                      
               LET ls_wseh_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wseh_t ",
                                 "SELECT 'tra_inaa_t',a.tran_time,trim(a.inaaent)||'|'||trim(a.inaasite)||'|'||trim(a.inaa001),'awsp608' ",
                                 "FROM ",ls_middb CLIPPED,".tra_inaa_t a ",
                                 "WHERE NOT EXISTS (",
                                 "SELECT 'x' ",
                                 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
                                 "WHERE wseh001 = 'tra_inaa_t'", 
                                 "   AND wseh002 = a.tran_time", 
                                 "   AND wseh004 = 'awsp608'",
                                 "   AND wseh003 = trim(a.inaaent)||'|'||trim(a.inaasite)||'|'||trim(a.inaa001))", 
                                 " AND a.inaaent = ",ls_inaaent CLIPPED,
                                 " AND a.inaasite = '",ls_inaasite CLIPPED,"'",
                                 " AND a.inaa001 = '",ls_inaa001 CLIPPED,"'",
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
   DROP TABLE inaa_temp 
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
   CALL awsp608_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp608.get_buffer" >}
PRIVATE FUNCTION awsp608_get_buffer(p_dialog)
 
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
 
{<section id="awsp608.msgcentre_notify" >}
PRIVATE FUNCTION awsp608_msgcentre_notify()
 
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
 
{<section id="awsp608.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
