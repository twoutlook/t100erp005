#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp612.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-03-24 09:34:03), PR版次:0001(2016-04-28 16:48:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: awsp612
#+ Description: 資源主檔批次作業
#+ Creator....: 07556(2016-03-22 16:21:47)
#+ Modifier...: 07556 -SD/PR- 07556
 
{</section>}
 
{<section id="awsp612.global" >}
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
       mrbaent LIKE type_t.num5, 
   mrbasite LIKE type_t.chr10, 
   mrba001 LIKE type_t.chr20, 
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
 
{<section id="awsp612.main" >}
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
      CALL awsp612_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsp612 WITH FORM cl_ap_formpath("aws",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL awsp612_init()
 
      #進入選單 Menu (="N")
      CALL awsp612_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_awsp612
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp612.init" >}
#+ 初始化作業
PRIVATE FUNCTION awsp612_init()
 
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
 
{<section id="awsp612.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsp612_ui_dialog()
 
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
         CONSTRUCT BY NAME g_master.wc ON mrbaent,mrbasite,mrba001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbaent
            #add-point:BEFORE FIELD mrbaent name="construct.b.mrbaent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbaent
            
            #add-point:AFTER FIELD mrbaent name="construct.a.mrbaent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrbaent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbaent
            #add-point:ON ACTION controlp INFIELD mrbaent name="construct.c.mrbaent"
            
            #END add-point
 
 
         #Ctrlp:construct.c.mrbasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrbasite
            #add-point:ON ACTION controlp INFIELD mrbasite name="construct.c.mrbasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'c' 
            #LET g_qryparam.reqry = FALSE
            #CALL q_ooed004()                           #呼叫開窗
            #DISPLAY g_qryparam.return1 TO mrbasite  #顯示到畫面上
            #NEXT FIELD mrbasite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrbasite
            #add-point:BEFORE FIELD mrbasite name="construct.b.mrbasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrbasite
            
            #add-point:AFTER FIELD mrbasite name="construct.a.mrbasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mrba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mrba001
            #add-point:ON ACTION controlp INFIELD mrba001 name="construct.c.mrba001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mrba001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mrba001  #顯示到畫面上
            NEXT FIELD mrba001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mrba001
            #add-point:BEFORE FIELD mrba001 name="construct.b.mrba001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mrba001
            
            #add-point:AFTER FIELD mrba001 name="construct.a.mrba001"
            
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
            CALL awsp612_get_buffer(l_dialog)
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
         CALL awsp612_init()
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
                 CALL awsp612_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = awsp612_transfer_argv(ls_js)
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
 
{<section id="awsp612.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION awsp612_transfer_argv(ls_js)
 
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
 
{<section id="awsp612.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION awsp612_process(ls_js)
 
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
   DEFINE ls_mrbaent    LIKE mrba_t.mrbaent   
   DEFINE ls_mrbasite   LIKE mrba_t.mrbasite    
   DEFINE ls_mrbaunit   LIKE mrba_t.mrbaunit    
   DEFINE ls_mrba000    LIKE mrba_t.mrba000   
   DEFINE ls_mrba001    LIKE mrba_t.mrba001   
   DEFINE ls_mrba002    LIKE mrba_t.mrba002   
   DEFINE ls_mrba003    LIKE mrba_t.mrba003   
   DEFINE ls_mrba004    LIKE mrba_t.mrba004   
   DEFINE ls_mrba005    LIKE mrba_t.mrba005   
   DEFINE ls_mrba006    LIKE mrba_t.mrba006   
   DEFINE ls_mrba007    LIKE mrba_t.mrba007   
   DEFINE ls_mrba008    LIKE mrba_t.mrba008   
   DEFINE ls_mrba009    LIKE mrba_t.mrba009   
   DEFINE ls_mrba010    LIKE mrba_t.mrba010   
   DEFINE ls_mrba011    LIKE mrba_t.mrba011   
   DEFINE ls_mrba012    LIKE mrba_t.mrba012   
   DEFINE ls_mrba013    LIKE mrba_t.mrba013   
   DEFINE ls_mrba014    LIKE mrba_t.mrba014   
   DEFINE ls_mrba015    LIKE mrba_t.mrba015   
   DEFINE ls_mrba016    LIKE mrba_t.mrba016   
   DEFINE ls_mrba017    LIKE mrba_t.mrba017   
   DEFINE ls_mrba018    LIKE mrba_t.mrba018   
   DEFINE ls_mrba019    LIKE mrba_t.mrba019   
   DEFINE ls_mrba020    LIKE mrba_t.mrba020   
   DEFINE ls_mrba021    LIKE mrba_t.mrba021   
   DEFINE ls_mrba022    LIKE mrba_t.mrba022   
   DEFINE ls_mrba023    LIKE mrba_t.mrba023   
   DEFINE ls_mrba024    LIKE mrba_t.mrba024   
   DEFINE ls_mrba025    LIKE mrba_t.mrba025   
   DEFINE ls_mrba026    LIKE mrba_t.mrba026   
   DEFINE ls_mrba027    LIKE mrba_t.mrba027   
   DEFINE ls_mrba028    LIKE mrba_t.mrba028   
   DEFINE ls_mrba029    LIKE mrba_t.mrba029   
   DEFINE ls_mrba031    LIKE mrba_t.mrba031   
   DEFINE ls_mrba032    LIKE mrba_t.mrba032   
   DEFINE ls_mrba033    LIKE mrba_t.mrba033   
   DEFINE ls_mrba034    LIKE mrba_t.mrba034   
   DEFINE ls_mrba035    LIKE mrba_t.mrba035   
   DEFINE ls_mrba036    LIKE mrba_t.mrba036   
   DEFINE ls_mrba037    LIKE mrba_t.mrba037   
   DEFINE ls_mrba038    LIKE mrba_t.mrba038   
   DEFINE ls_mrba039    LIKE mrba_t.mrba039   
   DEFINE ls_mrba040    LIKE mrba_t.mrba040   
   DEFINE ls_mrba041    LIKE mrba_t.mrba041   
   DEFINE ls_mrba042    LIKE mrba_t.mrba042   
   DEFINE ls_mrba050    LIKE mrba_t.mrba050   
   DEFINE ls_mrba051    LIKE mrba_t.mrba051   
   DEFINE ls_mrba052    LIKE mrba_t.mrba052   
   DEFINE ls_mrba053    LIKE mrba_t.mrba053   
   DEFINE ls_mrba054    LIKE mrba_t.mrba054   
   DEFINE ls_mrba055    LIKE mrba_t.mrba055   
   DEFINE ls_mrba056    LIKE mrba_t.mrba056   
   DEFINE ls_mrba057    LIKE mrba_t.mrba057   
   DEFINE ls_mrba058    LIKE mrba_t.mrba058   
   DEFINE ls_mrba059    LIKE mrba_t.mrba059   
   DEFINE ls_mrba060    LIKE mrba_t.mrba060   
   DEFINE ls_mrba061    LIKE mrba_t.mrba061   
   DEFINE ls_mrba062    LIKE mrba_t.mrba062   
   DEFINE ls_mrba063    LIKE mrba_t.mrba063   
   DEFINE ls_mrba064    LIKE mrba_t.mrba064   
   DEFINE ls_mrba065    LIKE mrba_t.mrba065   
   DEFINE ls_mrba100    LIKE mrba_t.mrba100   
   DEFINE ls_mrba101    LIKE mrba_t.mrba101   
   DEFINE ls_mrba102    LIKE mrba_t.mrba102   
   DEFINE ls_mrba103    LIKE mrba_t.mrba103   
   DEFINE ls_mrba104    LIKE mrba_t.mrba104   
   DEFINE ls_mrbaownid  LIKE mrba_t.mrbaownid     
   DEFINE ls_mrbaowndp  LIKE mrba_t.mrbaowndp     
   DEFINE ls_mrbacrtid  LIKE mrba_t.mrbacrtid     
   DEFINE ls_mrbacrtdp  LIKE mrba_t.mrbacrtdp     
   DEFINE ls_mrbacrtdt  LIKE mrba_t.mrbacrtdt     
   DEFINE ls_mrbamodid  LIKE mrba_t.mrbamodid     
   DEFINE ls_mrbamoddt  LIKE mrba_t.mrbamoddt     
   DEFINE ls_mrbacnfid  LIKE mrba_t.mrbacnfid     
   DEFINE ls_mrbacnfdt  LIKE mrba_t.mrbacnfdt     
   DEFINE ls_mrbastus   LIKE mrba_t.mrbastus    
   DEFINE ls_mrbaud001  LIKE mrba_t.mrbaud001     
   DEFINE ls_mrbaud002  LIKE mrba_t.mrbaud002     
   DEFINE ls_mrbaud003  LIKE mrba_t.mrbaud003     
   DEFINE ls_mrbaud004  LIKE mrba_t.mrbaud004     
   DEFINE ls_mrbaud005  LIKE mrba_t.mrbaud005     
   DEFINE ls_mrbaud006  LIKE mrba_t.mrbaud006     
   DEFINE ls_mrbaud007  LIKE mrba_t.mrbaud007     
   DEFINE ls_mrbaud008  LIKE mrba_t.mrbaud008     
   DEFINE ls_mrbaud009  LIKE mrba_t.mrbaud009     
   DEFINE ls_mrbaud010  LIKE mrba_t.mrbaud010     
   DEFINE ls_mrbaud011  LIKE mrba_t.mrbaud011     
   DEFINE ls_mrbaud012  LIKE mrba_t.mrbaud012     
   DEFINE ls_mrbaud013  LIKE mrba_t.mrbaud013     
   DEFINE ls_mrbaud014  LIKE mrba_t.mrbaud014     
   DEFINE ls_mrbaud015  LIKE mrba_t.mrbaud015     
   DEFINE ls_mrbaud016  LIKE mrba_t.mrbaud016     
   DEFINE ls_mrbaud017  LIKE mrba_t.mrbaud017     
   DEFINE ls_mrbaud018  LIKE mrba_t.mrbaud018     
   DEFINE ls_mrbaud019  LIKE mrba_t.mrbaud019     
   DEFINE ls_mrbaud020  LIKE mrba_t.mrbaud020     
   DEFINE ls_mrbaud021  LIKE mrba_t.mrbaud021     
   DEFINE ls_mrbaud022  LIKE mrba_t.mrbaud022     
   DEFINE ls_mrbaud023  LIKE mrba_t.mrbaud023     
   DEFINE ls_mrbaud024  LIKE mrba_t.mrbaud024     
   DEFINE ls_mrbaud025  LIKE mrba_t.mrbaud025     
   DEFINE ls_mrbaud026  LIKE mrba_t.mrbaud026     
   DEFINE ls_mrbaud027  LIKE mrba_t.mrbaud027     
   DEFINE ls_mrbaud028  LIKE mrba_t.mrbaud028     
   DEFINE ls_mrbaud029  LIKE mrba_t.mrbaud029     
   DEFINE ls_mrbaud030  LIKE mrba_t.mrbaud030     
   DEFINE ls_mrba066    LIKE mrba_t.mrba066 
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
#  DECLARE awsp612_process_cs CURSOR FROM ls_sql
#  FOREACH awsp612_process_cs INTO
   #add-point:process段process name="process.process"
   LET ls_middb = cl_eai_get_middb(g_dbs)
   SELECT TO_CHAR(SYSDATE-1,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_s_time FROM dual
   SELECT TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')||SUBSTR(TO_CHAR(sysdate,'SSSSS'),1,3) INTO ls_e_time FROM dual
   #DISPLAY 'g_master.wc:',lc_param.wc
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   
   #建立TEMP TABLE
   DROP TABLE mrba_temp
   LET ls_temp_sql = "CREATE GLOBAL TEMPORARY TABLE mrba_temp ",
                     "AS SELECT * FROM ",ls_middb CLIPPED,".tra_mrba_t WHERE 1 = 0"
   EXECUTE IMMEDIATE ls_temp_sql
   
   #把這次要轉的資料依KEY值取唯一先抓到TEMP TABLE
   LET ls_sql = "INSERT INTO mrba_temp ",  
               "SELECT tra.mrbaent,tra.mrbasite,tra.mrba001,tra.mrbamodid,tra.status,tra.erpold_stus,tra.tran_status,tra.tran_time,tra.mrba000 ",
               "FROM ",ls_middb CLIPPED,".tra_mrba_t tra, ", 
               "(SELECT mrbaent,mrbasite,mrba001,max(tran_time) tran_time ",
               "FROM ",ls_middb CLIPPED,".tra_mrba_t a ",
               "WHERE NOT EXISTS (",
               	 "SELECT 'x' ",
               	 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
               	 "WHERE wseh001 = 'tra_mrba_t'", 
               	 "   AND wseh002 = a.tran_time", 
               	 "   AND wseh004 = 'awsp612'",
               	 "   AND wseh003 = trim(a.mrbaent)||'|'||trim(a.mrbasite)||'|'||trim(a.mrba001))",
               " AND a.tran_time < '",ls_e_time CLIPPED,"'",
               " AND a.tran_time > '",ls_s_time CLIPPED,"'",
               " AND ",lc_param.wc,     
               " GROUP BY mrbaent,mrbasite,mrba001 ) d_tra",
               " WHERE tra.mrbaent = d_tra.mrbaent",
               " AND tra.mrbasite = d_tra.mrbasite",
               " AND tra.mrba001 = d_tra.mrba001",
               " AND tra.tran_time = d_tra.tran_time"
             #DISPLAY 'ls_sql:',ls_sql  
   EXECUTE IMMEDIATE ls_sql            
   
   #select count(*) into l_count1 from mrba_temp
   #DISPLAY 'l_count1:',l_count1
   
   #組出判斷all_mrba_t是否有同樣待轉資料的語法
   LET ls_sql = "SELECT count(1) ",  
               "FROM ",ls_middb CLIPPED,".all_mrba_t a ",
               "WHERE NOT EXISTS ( ",
                      "SELECT 'x'", 
                      "  FROM ",ls_middb CLIPPED,".m_wsee_t", 
                      " WHERE wsee002 = a.tran_time", 
                      "   AND wsee003 = trim(a.mrbaent)||'|'||trim(a.mrbasite)||'|'||trim(a.mrba001))",
               "  AND a.mrbaent = ?",
               "  AND a.mrbasite = ?",
               "  AND a.mrba001 = ?"   
      #DISPLAY 'ls_count_sql:',ls_sql          
   PREPARE sql_chk_count FROM ls_sql

   #把資料先抓出來
   LET ls_data_sql ="SELECT mrba_t.mrbaunit,",
   "tra.mrba000,mrba_t.mrba002,mrba_t.mrba003,mrba_t.mrba004,mrba_t.mrba005,",  #tra.mrba000；0.機器,1.設備,2.儀器,3.模具,4.夾治具,5.載具,6.車輛
   "mrba_t.mrba006,mrba_t.mrba007,mrba_t.mrba008,mrba_t.mrba009,mrba_t.mrba010,",
   "mrba_t.mrba011,mrba_t.mrba012,mrba_t.mrba013,mrba_t.mrba014,mrba_t.mrba015,",
   "mrba_t.mrba016,mrba_t.mrba017,mrba_t.mrba018,mrba_t.mrba019,mrba_t.mrba020,",
   "mrba_t.mrba021,mrba_t.mrba022,mrba_t.mrba023,mrba_t.mrba024,mrba_t.mrba025,",
   "mrba_t.mrba026,mrba_t.mrba027,mrba_t.mrba028,mrba_t.mrba029,mrba_t.mrba031,",
   "mrba_t.mrba032,mrba_t.mrba033,mrba_t.mrba034,mrba_t.mrba035,mrba_t.mrba036,",
   "mrba_t.mrba037,mrba_t.mrba038,mrba_t.mrba039,mrba_t.mrba040,mrba_t.mrba041,",
   "mrba_t.mrba042,mrba_t.mrba050,mrba_t.mrba051,mrba_t.mrba052,mrba_t.mrba053,",
   "mrba_t.mrba054,mrba_t.mrba055,mrba_t.mrba056,mrba_t.mrba057,mrba_t.mrba058,",
   "mrba_t.mrba059,mrba_t.mrba060,mrba_t.mrba061,mrba_t.mrba062,mrba_t.mrba063,",
   "mrba_t.mrba064,mrba_t.mrba065,mrba_t.mrba100,mrba_t.mrba101,mrba_t.mrba102,",
   "mrba_t.mrba103,mrba_t.mrba104,",
   "mrba_t.mrbaownid,mrba_t.mrbaowndp,mrba_t.mrbacrtid,mrba_t.mrbacrtdp,mrba_t.mrbacrtdt,",
   "mrba_t.mrbamodid,mrba_t.mrbamoddt,mrba_t.mrbacnfid,mrba_t.mrbacnfdt,mrba_t.mrbastus,",
   "mrba_t.mrbaud001,mrba_t.mrbaud002,mrba_t.mrbaud003,mrba_t.mrbaud004,mrba_t.mrbaud005,",
   "mrba_t.mrbaud006,mrba_t.mrbaud007,mrba_t.mrbaud008,mrba_t.mrbaud009,mrba_t.mrbaud010,",
   "mrba_t.mrbaud011,mrba_t.mrbaud012,mrba_t.mrbaud013,mrba_t.mrbaud014,mrba_t.mrbaud015,",
   "mrba_t.mrbaud016,mrba_t.mrbaud017,mrba_t.mrbaud018,mrba_t.mrbaud019,mrba_t.mrbaud020,",
   "mrba_t.mrbaud021,mrba_t.mrbaud022,mrba_t.mrbaud023,mrba_t.mrbaud024,mrba_t.mrbaud025,",
   "mrba_t.mrbaud026,mrba_t.mrbaud027,mrba_t.mrbaud028,mrba_t.mrbaud029,mrba_t.mrbaud030,",
   "mrba_t.mrba066,",   
   "tra.status,tra.erpold_stus,tra.tran_status ",           
   "FROM mrba_temp tra LEFT OUTER JOIN mrba_t ON ",
   " mrba_t.mrbaent = tra.mrbaent",
   " AND mrba_t.mrbasite = tra.mrbasite",
   " AND mrba_t.mrba001 = tra.mrba001",
   " WHERE tra.mrbaent = ?",
   " AND tra.mrbasite = ?",
   " AND tra.mrba001 = ?",
   " AND tra.tran_time = ?"
   #DISPLAY 'ls_data_sql:',ls_data_sql
   PREPARE sql_select_data FROM ls_data_sql
   
   #組出最後INSERT all_mrba_t資料的語法 
   LET ls_ins_sql = "INSERT INTO ",ls_middb CLIPPED,".all_mrba_t(mrbaent,mrbasite,mrba001,",
   "mrbaunit,",
   "mrba000,mrba002,mrba003,mrba004,mrba005,",
   "mrba006,mrba007,mrba008,mrba009,mrba010,",
   "mrba011,mrba012,mrba013,mrba014,mrba015,",
   "mrba016,mrba017,mrba018,mrba019,mrba020,",
   "mrba021,mrba022,mrba023,mrba024,mrba025,",
   "mrba026,mrba027,mrba028,mrba029,mrba031,",
   "mrba032,mrba033,mrba034,mrba035,mrba036,",
   "mrba037,mrba038,mrba039,mrba040,mrba041,",
   "mrba042,mrba050,mrba051,mrba052,mrba053,",
   "mrba054,mrba055,mrba056,mrba057,mrba058,",
   "mrba059,mrba060,mrba061,mrba062,mrba063,",
   "mrba064,mrba065,mrba100,mrba101,mrba102,",
   "mrba103,mrba104,",
   "mrbaownid,mrbaowndp,mrbacrtid,mrbacrtdp,mrbacrtdt,",
   "mrbamodid,mrbamoddt,mrbacnfid,mrbacnfdt,mrbastus,",
   "mrbaud001,mrbaud002,mrbaud003,mrbaud004,mrbaud005,",
   "mrbaud006,mrbaud007,mrbaud008,mrbaud009,mrbaud010,",
   "mrbaud011,mrbaud012,mrbaud013,mrbaud014,mrbaud015,",
   "mrbaud016,mrbaud017,mrbaud018,mrbaud019,mrbaud020,",
   "mrbaud021,mrbaud022,mrbaud023,mrbaud024,mrbaud025,",
   "mrbaud026,mrbaud027,mrbaud028,mrbaud029,mrbaud030,",
   "mrba066,",
   "status,erpold_stus,tran_status,tran_time) ",
   "VALUES(?,?,?,",
   "?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,?,?,?,?,",
   "?,",
   "?,?,?,?)"
   #DISPLAY 'ls_ins_sql:',ls_ins_sql
   PREPARE sql_insert_data FROM ls_ins_sql
   
   #組出最後UPDATE all_mrba_t資料的語法                       
   LET ls_upd_sql = "UPDATE ",ls_middb CLIPPED,".all_mrba_t",
                    " SET mrbaunit = ?,",
                    "     mrba000= ?,mrba002= ?,mrba003= ?,mrba004= ?,mrba005= ?,",
                    "     mrba006= ?,mrba007= ?,mrba008= ?,mrba009= ?,mrba010= ?,",
                    "     mrba011= ?,mrba012= ?,mrba013= ?,mrba014= ?,mrba015= ?,",
                    "     mrba016= ?,mrba017= ?,mrba018= ?,mrba019= ?,mrba020= ?,",
                    "     mrba021= ?,mrba022= ?,mrba023= ?,mrba024= ?,mrba025= ?,",
                    "     mrba026= ?,mrba027= ?,mrba028= ?,mrba029= ?,mrba031= ?,",
                    "     mrba032= ?,mrba033= ?,mrba034= ?,mrba035= ?,mrba036= ?,",
                    "     mrba037= ?,mrba038= ?,mrba039= ?,mrba040= ?,mrba041= ?,",
                    "     mrba042= ?,mrba050= ?,mrba051= ?,mrba052= ?,mrba053= ?,",
                    "     mrba054= ?,mrba055= ?,mrba056= ?,mrba057= ?,mrba058= ?,",
                    "     mrba059= ?,mrba060= ?,mrba061= ?,mrba062= ?,mrba063= ?,",
                    "     mrba064= ?,mrba065= ?,mrba100= ?,mrba101= ?,mrba102= ?,",
                    "     mrba103= ?,mrba104= ?,",
                    "     mrbamodid= ?,mrbamoddt= ?,mrbacnfid= ?,mrbacnfdt= ?,mrbastus= ?,",
                    "     mrbaud001= ?,mrbaud002= ?,mrbaud003= ?,mrbaud004= ?,mrbaud005= ?,",
                    "     mrbaud006= ?,mrbaud007= ?,mrbaud008= ?,mrbaud009= ?,mrbaud010= ?,",
                    "     mrbaud011= ?,mrbaud012= ?,mrbaud013= ?,mrbaud014= ?,mrbaud015= ?,",
                    "     mrbaud016= ?,mrbaud017= ?,mrbaud018= ?,mrbaud019= ?,mrbaud020= ?,",
                    "     mrbaud021= ?,mrbaud022= ?,mrbaud023= ?,mrbaud024= ?,mrbaud025= ?,",
                    "     mrbaud026= ?,mrbaud027= ?,mrbaud028= ?,mrbaud029= ?,mrbaud030= ?,",
                    "     mrba066= ?,",
                    "      status = ?,",
                    " erpold_stus = ?,",
                    " tran_status = ? ",
                    " WHERE mrbaent = ?",
                    " AND mrbasite = ?",
                    " AND mrba001 = ?",
                    " AND tran_time > ?",
                    " AND tran_time < ?"                  
  
   #DISPLAY 'ls_upd_sql:',ls_upd_sql
   PREPARE sql_update_data FROM ls_upd_sql   

   #把TEMP TABLE資料抓出來   
   LET ls_sql = "SELECT mrbaent,mrbasite,mrba001,tran_time FROM mrba_temp"
   PREPARE sql_select_temptb FROM ls_sql   
   DECLARE sql_fetch_data CURSOR WITH HOLD FOR sql_select_temptb  
   OPEN sql_fetch_data
   FOREACH sql_fetch_data INTO ls_mrbaent,ls_mrbasite,ls_mrba001,ls_trantime
   
           #DISPLAY 'chk_count:',ls_mrbaent,"|",ls_mrbasite,"|",ls_mrba001,"|",ls_trantime               
           #判斷all_mrba_t是否有同樣待轉資料
           EXECUTE sql_chk_count USING ls_mrbaent,ls_mrbasite,ls_mrba001 INTO l_count
           
           #先把資料抓出來
           EXECUTE sql_select_data USING ls_mrbaent,ls_mrbasite,ls_mrba001,ls_trantime
              INTO ls_mrbaunit,
                   ls_mrba000,ls_mrba002,ls_mrba003,ls_mrba004,ls_mrba005,
                   ls_mrba006,ls_mrba007,ls_mrba008,ls_mrba009,ls_mrba010,
                   ls_mrba011,ls_mrba012,ls_mrba013,ls_mrba014,ls_mrba015,
                   ls_mrba016,ls_mrba017,ls_mrba018,ls_mrba019,ls_mrba020,
                   ls_mrba021,ls_mrba022,ls_mrba023,ls_mrba024,ls_mrba025,
                   ls_mrba026,ls_mrba027,ls_mrba028,ls_mrba029,ls_mrba031,
                   ls_mrba032,ls_mrba033,ls_mrba034,ls_mrba035,ls_mrba036,
                   ls_mrba037,ls_mrba038,ls_mrba039,ls_mrba040,ls_mrba041,
                   ls_mrba042,ls_mrba050,ls_mrba051,ls_mrba052,ls_mrba053,
                   ls_mrba054,ls_mrba055,ls_mrba056,ls_mrba057,ls_mrba058,
                   ls_mrba059,ls_mrba060,ls_mrba061,ls_mrba062,ls_mrba063,
                   ls_mrba064,ls_mrba065,ls_mrba100,ls_mrba101,ls_mrba102,
                   ls_mrba103,ls_mrba104,
                   ls_mrbaownid,ls_mrbaowndp,ls_mrbacrtid,ls_mrbacrtdp,ls_mrbacrtdt,
                   ls_mrbamodid,ls_mrbamoddt,ls_mrbacnfid,ls_mrbacnfdt,ls_mrbastus,
                   ls_mrbaud001,ls_mrbaud002,ls_mrbaud003,ls_mrbaud004,ls_mrbaud005,
                   ls_mrbaud006,ls_mrbaud007,ls_mrbaud008,ls_mrbaud009,ls_mrbaud010,
                   ls_mrbaud011,ls_mrbaud012,ls_mrbaud013,ls_mrbaud014,ls_mrbaud015,
                   ls_mrbaud016,ls_mrbaud017,ls_mrbaud018,ls_mrbaud019,ls_mrbaud020,
                   ls_mrbaud021,ls_mrbaud022,ls_mrbaud023,ls_mrbaud024,ls_mrbaud025,
                   ls_mrbaud026,ls_mrbaud027,ls_mrbaud028,ls_mrbaud029,ls_mrbaud030,
                   ls_mrba066,
                   ls_status,ls_erpold_stus,ls_tran_status      
           
           #沒同樣資料就INSERT
           IF l_count = 0 THEN

              #執行INSERT動作
              EXECUTE sql_insert_data USING ls_mrbaent,ls_mrbasite,ls_mrba001,
                      ls_mrbaunit,
                      ls_mrba000,ls_mrba002,ls_mrba003,ls_mrba004,ls_mrba005,
                      ls_mrba006,ls_mrba007,ls_mrba008,ls_mrba009,ls_mrba010,
                      ls_mrba011,ls_mrba012,ls_mrba013,ls_mrba014,ls_mrba015,
                      ls_mrba016,ls_mrba017,ls_mrba018,ls_mrba019,ls_mrba020,
                      ls_mrba021,ls_mrba022,ls_mrba023,ls_mrba024,ls_mrba025,
                      ls_mrba026,ls_mrba027,ls_mrba028,ls_mrba029,ls_mrba031,
                      ls_mrba032,ls_mrba033,ls_mrba034,ls_mrba035,ls_mrba036,
                      ls_mrba037,ls_mrba038,ls_mrba039,ls_mrba040,ls_mrba041,
                      ls_mrba042,ls_mrba050,ls_mrba051,ls_mrba052,ls_mrba053,
                      ls_mrba054,ls_mrba055,ls_mrba056,ls_mrba057,ls_mrba058,
                      ls_mrba059,ls_mrba060,ls_mrba061,ls_mrba062,ls_mrba063,
                      ls_mrba064,ls_mrba065,ls_mrba100,ls_mrba101,ls_mrba102,
                      ls_mrba103,ls_mrba104,
                      ls_mrbaownid,ls_mrbaowndp,ls_mrbacrtid,ls_mrbacrtdp,ls_mrbacrtdt,
                      ls_mrbamodid,ls_mrbamoddt,ls_mrbacnfid,ls_mrbacnfdt,ls_mrbastus,
                      ls_mrbaud001,ls_mrbaud002,ls_mrbaud003,ls_mrbaud004,ls_mrbaud005,
                      ls_mrbaud006,ls_mrbaud007,ls_mrbaud008,ls_mrbaud009,ls_mrbaud010,
                      ls_mrbaud011,ls_mrbaud012,ls_mrbaud013,ls_mrbaud014,ls_mrbaud015,
                      ls_mrbaud016,ls_mrbaud017,ls_mrbaud018,ls_mrbaud019,ls_mrbaud020,
                      ls_mrbaud021,ls_mrbaud022,ls_mrbaud023,ls_mrbaud024,ls_mrbaud025,
                      ls_mrbaud026,ls_mrbaud027,ls_mrbaud028,ls_mrbaud029,ls_mrbaud030,
                      ls_mrba066,
                      ls_status,ls_erpold_stus,ls_tran_status,ls_trantime

              DISPLAY 'insert:',ls_mrbaent,"|",ls_mrbasite,"|",ls_mrba001,"|",ls_status,"|",ls_trantime              
           ELSE
              #有待轉資料就UPDATE
                                  
              #執行UPDATE動作
              EXECUTE sql_update_data USING 
                      ls_mrbaunit,
                      ls_mrba000,ls_mrba002,ls_mrba003,ls_mrba004,ls_mrba005,
                      ls_mrba006,ls_mrba007,ls_mrba008,ls_mrba009,ls_mrba010,
                      ls_mrba011,ls_mrba012,ls_mrba013,ls_mrba014,ls_mrba015,
                      ls_mrba016,ls_mrba017,ls_mrba018,ls_mrba019,ls_mrba020,
                      ls_mrba021,ls_mrba022,ls_mrba023,ls_mrba024,ls_mrba025,
                      ls_mrba026,ls_mrba027,ls_mrba028,ls_mrba029,ls_mrba031,
                      ls_mrba032,ls_mrba033,ls_mrba034,ls_mrba035,ls_mrba036,
                      ls_mrba037,ls_mrba038,ls_mrba039,ls_mrba040,ls_mrba041,
                      ls_mrba042,ls_mrba050,ls_mrba051,ls_mrba052,ls_mrba053,
                      ls_mrba054,ls_mrba055,ls_mrba056,ls_mrba057,ls_mrba058,
                      ls_mrba059,ls_mrba060,ls_mrba061,ls_mrba062,ls_mrba063,
                      ls_mrba064,ls_mrba065,ls_mrba100,ls_mrba101,ls_mrba102,
                      ls_mrba103,ls_mrba104,
                      ls_mrbamodid,ls_mrbamoddt,ls_mrbacnfid,ls_mrbacnfdt,ls_mrbastus,
                      ls_mrbaud001,ls_mrbaud002,ls_mrbaud003,ls_mrbaud004,ls_mrbaud005,
                      ls_mrbaud006,ls_mrbaud007,ls_mrbaud008,ls_mrbaud009,ls_mrbaud010,
                      ls_mrbaud011,ls_mrbaud012,ls_mrbaud013,ls_mrbaud014,ls_mrbaud015,
                      ls_mrbaud016,ls_mrbaud017,ls_mrbaud018,ls_mrbaud019,ls_mrbaud020,
                      ls_mrbaud021,ls_mrbaud022,ls_mrbaud023,ls_mrbaud024,ls_mrbaud025,
                      ls_mrbaud026,ls_mrbaud027,ls_mrbaud028,ls_mrbaud029,ls_mrbaud030,
                      ls_mrba066,
                      ls_status,ls_erpold_stus,ls_tran_status,
                      ls_mrbaent,ls_mrbasite,ls_mrba001,ls_s_time,ls_e_time
              DISPLAY 'update:',ls_mrbaent,"|",ls_mrbasite,"|",ls_mrba001,"|",ls_status,"|",ls_trantime                      
           END IF
           
           IF SQLCA.SQLCODE THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.SQLCODE 
              LET g_errparam.extend = ''
              LET g_errparam.popup = TRUE
              
              #先把key值欄位組出來
              LET ls_key = ls_mrbaent CLIPPED,'|',ls_mrbasite CLIPPED,'|',ls_mrba001 CLIPPED,'|'              
              #把錯誤寫入m_wsei_t
              LET ls_err_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wsei_t ",
                               "(wsei001,wsei002,wsei003,wsei004,wsei005,wsei006,wsei007) ",
                               "VALUES('tra_mrba_t','",ls_trantime CLIPPED,"','",ls_key CLIPPED,"',",
                               "'awsp612','",ls_e_time,"','",SQLCA.SQLCODE,"','",SQLERRMESSAGE,"')"
              EXECUTE IMMEDIATE ls_err_sql                 
              #DISPLAY 'ls_err_sql:',ls_err_sql                
              CALL cl_err()
               
           ELSE
              #寫入all_mrba_t後依KEY值條件把所有待轉的記錄寫入m_wseh_t      
               LET ls_wseh_sql = "INSERT INTO ",ls_middb CLIPPED,".m_wseh_t ",
                                 "SELECT 'tra_mrba_t',a.tran_time,trim(a.mrbaent)||'|'||trim(a.mrbasite)||'|'||trim(a.mrba001),'awsp612' ",
                                 "FROM ",ls_middb CLIPPED,".tra_mrba_t a ",
                                 "WHERE NOT EXISTS (",
                                 "SELECT 'x' ",
                                 " FROM ",ls_middb CLIPPED,".m_wseh_t ", 
                                 "WHERE wseh001 = 'tra_mrba_t'", 
                                 "   AND wseh002 = a.tran_time", 
                                 "   AND wseh004 = 'awsp612'",
                                 "   AND wseh003 = trim(a.mrbaent)||'|'||trim(a.mrbasite)||'|'||trim(a.mrba001))", 
                                 " AND a.mrbaent = ",ls_mrbaent CLIPPED,
                                 " AND a.mrbasite = '",ls_mrbasite CLIPPED,"'",
                                 " AND a.mrba001 = '",ls_mrba001 CLIPPED,"'",
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
   DROP TABLE mrba_temp 
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
   CALL awsp612_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="awsp612.get_buffer" >}
PRIVATE FUNCTION awsp612_get_buffer(p_dialog)
 
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
 
{<section id="awsp612.msgcentre_notify" >}
PRIVATE FUNCTION awsp612_msgcentre_notify()
 
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
 
{<section id="awsp612.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
