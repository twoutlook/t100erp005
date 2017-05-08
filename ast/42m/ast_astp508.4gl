#該程式未解開Section, 採用最新樣板產出!
{<section id="astp508.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-09-14 10:01:56), PR版次:0006(2016-09-13 18:04:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: astp508
#+ Description: 專櫃日常VIP折扣分攤成本批次產生作業
#+ Creator....: 06137(2015-06-11 13:52:31)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="astp508.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
#160905-00007#16   2016/09/05 By 02599   SQL条件增加ent
#160913-00034#1    2016/09/13 by 08172   q_pmaa001開窗替换
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
        type          LIKE type_t.chr10,
        #debc002       LIKE debc_t.debc002, #lanjj mark
        debc002_1     LIKE debc_t.debc002, #lanjj add
        debc002_2     LIKE debc_t.debc002, #lanjj add
        recalculated  LIKE type_t.chr1,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stfasite LIKE stfa_t.stfasite, 
   stfa005 LIKE stfa_t.stfa005, 
   stfa010 LIKE stfa_t.stfa010, 
   debc002_1 LIKE type_t.dat, 
   debc002_2 LIKE type_t.dat, 
   l_recalculated LIKE type_t.chr500, 
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
 
{<section id="astp508.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由02開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[02]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp508_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp508 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp508_init()
 
      #進入選單 Menu (="N")
      CALL astp508_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp508
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp508.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp508_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success      LIKE type_t.num5
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
 
{<section id="astp508.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp508_ui_dialog()
 
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
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.debc002_1,g_master.debc002_2,g_master.l_recalculated 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debc002_1
            #add-point:BEFORE FIELD debc002_1 name="input.b.debc002_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debc002_1
            
            #add-point:AFTER FIELD debc002_1 name="input.a.debc002_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE debc002_1
            #add-point:ON CHANGE debc002_1 name="input.g.debc002_1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD debc002_2
            #add-point:BEFORE FIELD debc002_2 name="input.b.debc002_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD debc002_2
            
            #add-point:AFTER FIELD debc002_2 name="input.a.debc002_2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE debc002_2
            #add-point:ON CHANGE debc002_2 name="input.g.debc002_2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_recalculated
            #add-point:BEFORE FIELD l_recalculated name="input.b.l_recalculated"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_recalculated
            
            #add-point:AFTER FIELD l_recalculated name="input.a.l_recalculated"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_recalculated
            #add-point:ON CHANGE l_recalculated name="input.g.l_recalculated"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.debc002_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debc002_1
            #add-point:ON ACTION controlp INFIELD debc002_1 name="input.c.debc002_1"
            
            #END add-point
 
 
         #Ctrlp:input.c.debc002_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD debc002_2
            #add-point:ON ACTION controlp INFIELD debc002_2 name="input.c.debc002_2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_recalculated
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_recalculated
            #add-point:ON ACTION controlp INFIELD l_recalculated name="input.c.l_recalculated"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stfasite,stfa005,stfa010
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfasite
            #add-point:ON ACTION controlp INFIELD stfasite name="construct.c.stfasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')             
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfasite  #顯示到畫面上
            NEXT FIELD stfasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfasite
            #add-point:BEFORE FIELD stfasite name="construct.b.stfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfasite
            
            #add-point:AFTER FIELD stfasite name="construct.a.stfasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa005
            #add-point:ON ACTION controlp INFIELD stfa005 name="construct.c.stfa005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa005  #顯示到畫面上
            NEXT FIELD stfa005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfa005
            #add-point:BEFORE FIELD stfa005 name="construct.b.stfa005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfa005
            
            #add-point:AFTER FIELD stfa005 name="construct.a.stfa005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stfa010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa010
            #add-point:ON ACTION controlp INFIELD stfa010 name="construct.c.stfa010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#1 -s by 08172
            LET g_qryparam.arg1 = "('3')"
            CALL q_pmaa001_1()
#            CALL q_pmaa001()                           #呼叫開窗
            #160913-00034#1 -e by 08172
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfa010
            #add-point:BEFORE FIELD stfa010 name="construct.b.stfa010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfa010
            
            #add-point:AFTER FIELD stfa010 name="construct.a.stfa010"
            
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
            CALL astp508_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            
            #lanjj modify on 2016-08-25 start
            #LET g_master.debc002 = g_today-1
            LET g_master.debc002_1 = g_today-1
            LET g_master.debc002_2 = g_today-1
            #lanjj modify on 2016-08-25 end
            
            LET g_master.l_recalculated = 'Y'
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
         CALL astp508_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.type         = g_argv[1]
      #LET lc_param.debc002      = g_master.debc002 #lanjj mark
      LET lc_param.debc002_1     = g_master.debc002_1 #lanjj add
      LET lc_param.debc002_2     = g_master.debc002_2 #lanjj add
      LET lc_param.recalculated = g_master.l_recalculated
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
                 CALL astp508_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp508_transfer_argv(ls_js)
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
 
{<section id="astp508.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp508_transfer_argv(ls_js)
 
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
 
{<section id="astp508.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp508_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#18 Add By Ken 160314
   DEFINE l_msg         STRING             #160225-00040#18 Add By Ken 160314
   DEFINE l_data        LIKE type_t.num5   #lanjj add on 2016-09-05
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   LET l_data = 0
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      LET l_loop = 3
      CALL cl_progress_bar_no_window(l_loop)      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp508_process_cs CURSOR FROM ls_sql
#  FOREACH astp508_process_cs INTO
   #add-point:process段process name="process.process"
   
   #160225-00040#18 Add By Ken 160314(S)  資料準備 
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#18 Add By Ken 160314(E)
   
   #建立tmp table
   CALL astp508_create_tmp() 
   CALL astp508_create_preg_tmp()   

   CALL cl_err_collect_init()
   
   #lanjj modify on 2016-08-25 start
   WHILE TRUE
   
      #把促銷談判中要使用的庫區先存到preg_tmp
      DISPLAY "g_wc:",lc_param.wc   
      DELETE FROM astp508_tmp01    #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01   
      CALL astp508_extand_preg(lc_param.debc002_1)  
      
      #把要計算的組織資料先存到org_tmp
      DELETE FROM astp508_org_tmp     
      CALL astp508_extand_org(lc_param.wc)
   
      CALL s_transaction_begin()   
      
      #IF NOT astp508_data_process(lc_param.type,lc_param.wc,lc_param.debc002,lc_param.recalculated) THEN #lanjj mark
      IF NOT astp508_data_process(lc_param.type,lc_param.wc,lc_param.debc002_1,lc_param.recalculated) THEN #lanjj add
         CALL s_transaction_end('N',0)
      ELSE   
         CALL s_transaction_end('Y',0) 
         LET l_data = l_data + 1 #lanjj add on 2016-09-05
      END IF
      
      IF lc_param.debc002_1 >= lc_param.debc002_2 THEN 
         EXIT WHILE
      ELSE
         LET lc_param.debc002_1 = lc_param.debc002_1 + 1
      END IF 
   END WHILE
   #lanjj modify on 2016-08-25 end
   
   #160225-00040#18 Add By Ken 160314(S)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
   #160225-00040#18 Add By Ken 160314(E)    
   
   #lanjj add on 2016-09-05 start
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = "已生成：",l_data," 条数据"
   LET g_errparam.code   = "adz-00482"
   LET g_errparam.popup  = TRUE 
   CALL cl_err() 
   #lanjj add on 2016-09-05 end
   
   CALL cl_err_collect_show()   
   DISPLAY "g_wc:",lc_param.wc
   
   CALL astp508_drop_tmp()
   CALL astp508_drop_preg_tmp()   
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
   CALL astp508_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp508.get_buffer" >}
PRIVATE FUNCTION astp508_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.debc002_1 = p_dialog.getFieldBuffer('debc002_1')
   LET g_master.debc002_2 = p_dialog.getFieldBuffer('debc002_2')
   LET g_master.l_recalculated = p_dialog.getFieldBuffer('l_recalculated')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp508.msgcentre_notify" >}
PRIVATE FUNCTION astp508_msgcentre_notify()
 
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
 
{<section id="astp508.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建立暫存表
# Memo...........:
# Usage..........: CALL astp508_create_tmp()
# Input parameter: 
# Return code....:
# Date & Author..: 2015/06/12 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_create_tmp()
   WHENEVER ERROR CONTINUE
   
   CALL astp508_drop_tmp()
   
   #建立結算組織暫存檔
   CREATE TEMP TABLE astp508_org_tmp(
      ooef001    VARCHAR(10),
      sour_flag  VARCHAR(1),
      ooab002    VARCHAR(80),       #據點級庫存關帳日
      ooab_flag  VARCHAR(1))          #可否進行計算
      
   
END FUNCTION

################################################################################
# Descriptions...: 列出要進行結算的組織
# Memo...........: 執行注意...
#                  CALL astp508_create_org_tmp
#                  CALL s_transaction_begin
#                  CALL astp508_extand_org(p_wc)
#                  CALL s_transaction_end
#                  CALL astp508_drop_org_tmp
# Usage..........: CALL astp508_extand_org()
# Input parameter: p_wc        查詢字串
# Date & Author..: 2015/07/20 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_extand_org(p_wc)
   DEFINE p_wc            STRING
   DEFINE l_sql           STRING   
   DEFINE l_where         STRING   
   DEFINE l_ooed004       LIKE ooed_t.ooed004   
   DEFINE l_ooed001       LIKE ooed_t.ooed001  
   DEFINE l_wc            STRING            #解析出stfasite 條件的字串
   DEFINE l_wc1           STRING
   DEFINE l_str           STRING
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_num2          LIKE type_t.num5
   DEFINE l_ooef001       LIKE ooef_t.ooef001   
   
   WHENEVER ERROR CONTINUE
   
   LET l_wc = ''
   LET l_wc1 = ''
   
   #解析stfasite的construct出來到l_wc
   LET l_str = p_wc
   LET l_num = l_str.getIndexOf("stfasite",1)
   IF l_num > 0 THEN      
      LET l_num2 = l_str.getIndexOf("and",l_num)
      IF l_num2 > 0 THEN
         LET l_wc = l_str.subString(l_num,l_num2-2)
      ELSE
         LET l_wc = l_str.subString(l_num,l_str.getLength())
      END IF
      IF l_wc = "stfasite like '%'" THEN
         LET l_wc = " 1=1"
      END IF
      
      IF l_num = 1 THEN
         IF l_num2 = 0 THEN
            LET l_wc1 = ''
         ELSE
            LET l_wc1 = l_str.subString(l_num2+4,l_str.getLength())
         END IF
      ELSE
         IF l_num2 = 0 THEN
            LET l_wc1 = l_str.subString(1,l_num-5)
         ELSE
            LET l_wc1 = l_str.subString(1,l_num-5)
            LET l_wc1 = l_wc1 CLIPPED," ",l_str.subString(l_num2,l_str.getLength())
         END IF
      END IF
   ELSE
      LET l_wc = " 1=1"
      LET l_wc1 = p_wc
   END IF   
   
   LET l_where = s_aooi500_sql_where(g_prog,"stfasite") 
   LET l_where = cl_replace_str(l_where,'stfasite','ooef001')
   IF cl_null(l_where) THEN LET l_where = " 1=1" END IF
   
   LET l_wc    = cl_replace_str(l_wc,'stfasite','ooef001')   

   LET l_sql = " SELECT UNIQUE ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise,
               "    AND ",l_wc,               
               "    AND ",l_where    

   PREPARE astp508_org FROM l_sql 
   DECLARE astp508_cs1 CURSOR WITH HOLD FOR astp508_org                  
   FOREACH astp508_cs1 INTO l_ooef001     
      INSERT INTO astp508_org_tmp(ooef001)
         VALUES(l_ooef001)     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins astp508_org_tmp"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF         
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 專櫃VIP分攤成本批次處理
# Memo...........:
# Usage..........: astp508_data_process(p_type,p_wc,p_debc002,p_recalculated)
#                  RETURNING r_success
# Input parameter: p_type         (1:專櫃日常VIP折扣分攤成本；2:專櫃促銷VIP折扣分攤成本)
#                  p_wc           QBE條件
#                  p_debc002      統計日期
#                  p_recalculated 是否刪除已結算過的資料
# Return code....: r_success
# Date & Author..: 2015/07/16 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_data_process(p_type,p_wc,p_debc002,p_recalculated)
   DEFINE p_type             LIKE type_t.chr10
   DEFINE p_wc               STRING
   DEFINE p_debc002          LIKE debc_t.debc002
   DEFINE p_recalculated     LIKE type_t.chr1
   DEFINE l_wc_del           STRING
   DEFINE l_sql              STRING
   DEFINE l_ooef001          LIKE ooef_t.ooef001
   DEFINE l_sour_flag        LIKE type_t.chr1
   DEFINE l_ooab002          LIKE ooab_t.ooab002  #據點級庫存關帳日
   DEFINE l_ooab_flag        LIKE type_t.chr1     #可否進行計算
   DEFINE l_count            LIKE type_t.num5
   DEFINE l_stga007          LIKE stga_t.stga007  #銷售數量
   DEFINE l_stga012          LIKE stga_t.stga012  #成本金額(庫區)
   DEFINE l_stga012_1        LIKE stga_t.stga012  #成本金額(會員)   
   DEFINE l_stga013          LIKE stga_t.stga013  #日結成本類別 
   DEFINE l_stfasite         LIKE stfa_t.stfasite 
   DEFINE l_stfa005          LIKE stfa_t.stfa005  #專櫃編號
   DEFINE l_stfa010          LIKE stfa_t.stfa010  #供應商編號
   DEFINE l_stfc002          LIKE stfc_t.stfc002  #庫區編號
   DEFINE l_prog             LIKE type_t.chr10    #作業編號
   DEFINE l_stav002          LIKE stav_t.stav002  #費用編號
   DEFINE l_stae006          LIKE stae_t.stae006  #價款類別
   DEFINE l_stfd007          LIKE stfd_t.stfd007  #會員等級分攤比率
   DEFINE l_stfc018          LIKE stfc_t.stfc018  #費用比率
   DEFINE l_cost             LIKE stga_t.stga012  #會員等級折扣金額
   DEFINE l_tcost            LIKE stga_t.stga012  #會員等級折扣金額加總
   DEFINE l_oocq009          LIKE oocq_t.oocq009  #庫區日結會員等級
   DEFINE l_prei093          LIKE prei_t.prei093
   DEFINE l_prei094          LIKE prei_t.prei094
   DEFINE l_prei095          LIKE prei_t.prei095
   DEFINE l_prei096          LIKE prei_t.prei096
   DEFINE l_prei097          LIKE prei_t.prei097
   DEFINE l_preg_sql         STRING               #促銷談判存在的庫區
   DEFINE l_preg1_sql        STRING               #促銷談判存在的庫區
   DEFINE l_del_sql          STRING     
   DEFINE l_stga        RECORD
           stgaent      LIKE stga_t.stgaent,    
           stgasite     LIKE stga_t.stgasite,
           stgaunit     LIKE stga_t.stgaunit,   
           stga001      LIKE stga_t.stga001,    #銷售日期
           stga002      LIKE stga_t.stga002,    #商品編號
           stga003      LIKE stga_t.stga003,    #庫區編號
           stga004      LIKE stga_t.stga004,    #專櫃編號
           stga005      LIKE stga_t.stga005,    #供應商編號
           stga006      LIKE stga_t.stga006,    #費用編號
           stga007      LIKE stga_t.stga007,    #銷售數量
           stga008      LIKE stga_t.stga008,    #應收金額
           stga009      LIKE stga_t.stga009,    #實收金額
           stga010      LIKE stga_t.stga010,    #費率
           stga011      LIKE stga_t.stga011,    #費用金額
           stga012      LIKE stga_t.stga012,    #成本金額
           stga013      LIKE stga_t.stga013,    #日結成本類別
           stga014      LIKE stga_t.stga014,    #價款類型
           stga015      LIKE stga_t.stga015,    #已結轉否
           stgadocno    LIKE stga_t.stgadocno   #來源單號
           END RECORD
   #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(s)
   #DEFINE l_stga011          LIKE stga_t.stga011   #費用金額(庫區) #150914-00002#46 Add By Ken 151104
   #DEFINE l_stga011_1        LIKE stga_t.stga011   #費用金額(會員) #150914-00002#46 Add By Ken 151104
   #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(e)
   DEFINE r_success          LIKE type_t.num5
   DEFINE l_ooef016          LIKE ooef_t.ooef016   #150914-00002#42 2015/10/28 s983961--add
   DEFINE l_msg              STRING             #160225-00040#18 Add By Ken 160314
   
   LET r_success = TRUE
   

   
   #取出所有要統計的組織   
   LET l_sql = "SELECT ooef001 FROM astp508_org_tmp"
   PREPARE astp508_org_tmp_table_pre FROM l_sql
   DECLARE astp508_org_tmp_table_cur CURSOR FOR astp508_org_tmp_table_pre
   FOREACH astp508_org_tmp_table_cur INTO l_ooef001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp508_org_tmp_table_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success         
   END IF 
      #找出各組織是否有來源資料
      SELECT COUNT(*) INTO l_count 
        FROM debd_t
       WHERE debdent = g_enterprise
         AND debdsite = l_ooef001 #營運組織
         AND debd002 = p_debc002 #統計日期           
      
      IF l_count > 0 THEN
         LET l_sour_flag = 'Y'
      ELSE
         LET l_sour_flag = 'N'
      END IF
      
      LET l_sql = "UPDATE astp508_org_tmp SET sour_flag = ? where ooef001 = ? "
      PREPARE astp508_org_tmp_update FROM l_sql
      EXECUTE astp508_org_tmp_update USING l_sour_flag,l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astp508_org_tmp_update"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF 
 
      #先找出各據點級的結算日大於  日結關帳日時才可以跑
      LET l_ooab002 = cl_get_para(g_enterprise,l_ooef001,"S-CIR-0001")         
      IF p_debc002 > l_ooab002 THEN
         LET l_ooab_flag = 'Y'
      ELSE
         LET l_ooab_flag = 'N'
      END IF
      
      LET l_sql = "UPDATE astp508_org_tmp SET ooab002 = ?,ooab_flag = ? where ooef001 = ? "
      PREPARE astp508_org_tmp_update1 FROM l_sql
      EXECUTE astp508_org_tmp_update1 USING l_ooab002,l_ooab_flag,l_ooef001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "astp508_org_tmp_update1"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF                     
   END FOREACH  

   #依傳入參數不同，計算不同資料
   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
   IF p_type = 1 THEN  #astp508 專櫃日常VIP折扣分攤成本
     LET l_stga013  = '6'
     LET l_prog = 'astp508'
     LET l_preg_sql = ' NOT EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = stfasite AND prei003 = stfc002 ) AND stfd007 > 0 '
     LET l_preg1_sql = ' NOT EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = debdsite AND prei003 = debd005 ) '
     LET l_del_sql = ' NOT EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = stgasite AND prei003 = stga003 )'     
   ELSE                #astp509 專櫃VIP促銷分攤成本
     LET l_stga013  = '11'
     LET l_prog = 'astp509'
     LET l_preg_sql = ' EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = stfasite AND prei003 = stfc002 )'
     LET l_preg1_sql = ' EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = debdsite AND prei003 = debd005 ) '
     LET l_del_sql = ' EXISTS(SELECT 1 FROM astp508_tmp01 WHERE pregsite = stgasite AND prei003 = stga003 )'     
   END IF
   
   #160225-00040#18 Add By Ken 160314(S)   產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#18 Add By Ken 160314(e)    
   
   LET l_wc_del = cl_replace_str(p_wc,'stfasite','debdsite')   #營運組織
   LET l_wc_del = cl_replace_str(l_wc_del,'stfa005','debd010')  #專櫃編號
   LET l_wc_del = cl_replace_str(l_wc_del,'stfa010','debd009')  #供應商編號   
   LET l_count = 0
   LET l_sql = "SELECT COUNT(*) ",
               "  FROM debd_t  ",
               " WHERE debdent = ",g_enterprise,   
               "   AND debd002 = '",p_debc002,"'",      
               "   AND EXISTS(SELECT 1 FROM astp508_org_tmp  WHERE ooef001 = debdsite AND ooab_flag = 'Y') ",
               "   AND ",l_preg1_sql,
               "   AND ",l_wc_del
   DISPLAY "SQL1: ",l_sql
   PREPARE astp508_cnt_sour FROM l_sql           
   EXECUTE astp508_cnt_sour INTO l_count
   IF l_count = 0 THEN
#      INITIALIZE g_errparam TO NULL #lanjj mark on 2016-09-05 若无数据生成 则直接跳过 不提示
#      LET g_errparam.code = 'ade-00075'
#      LET g_errparam.extend = ''
#      LET g_errparam.popup = TRUE
#      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success       
   END IF      

   #已存在日結資料刪除重新計算
   IF p_recalculated = 'Y' THEN         
      #已存在日結資料刪除(條件：已結轉否為:N)
      LET l_wc_del = cl_replace_str(p_wc,'stfasite','stgasite')   #營運組織
      #LET l_wc_del = cl_replace_str(l_wc_del,'deba005','stga003') #庫區
      LET l_wc_del = cl_replace_str(l_wc_del,'stfa005','stga004')  #專櫃編號
      LET l_wc_del = cl_replace_str(l_wc_del,'stfa010','stga005')  #供應商編號
      LET l_sql = "DELETE FROM stga_t ",
                  " WHERE stgaent = ",g_enterprise,
                  "   AND stga001 = '",p_debc002,"'",                
                  "   AND EXISTS(SELECT 1 FROM astp508_org_tmp WHERE ooef001 = stgasite AND ooab_flag = 'Y') ",
                  "   AND ",l_del_sql,                  
                  "   AND stga013 = ",l_stga013,
                  "   AND stga015 = 'N' ",
                  "   AND ",l_wc_del
      DISPLAY "SQL2: ",l_sql           
      PREPARE astp508_del_stga FROM l_sql       
      EXECUTE astp508_del_stga
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Del astp508_stga"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF        
   END IF   
   
   #依不同的作業編號到asti207取的費用代碼
   SELECT stav002 INTO l_stav002 
     FROM stav_t 
    WHERE stavent = g_enterprise 
      AND stav001 = l_prog
      
   #以費用代碼到asti203取出價款類型
   SELECT stae006 INTO l_stae006 
     FROM stae_t 
    WHERE staeent = g_enterprise 
      AND stae001 = l_stav002
      AND staestus = 'Y'
   IF cl_null(l_stae006) OR l_stae006 = '3' THEN
      LET l_stae006 = '1'
   END IF
  
   
   #檢查astq501是否已經有資料(有的話跳過，無的話進行計算)
   LET l_sql = "SELECT COUNT(*) ",
               "  FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stga001 = '",p_debc002,"'",
               "   AND stgasite = ? ",
               "   AND stga004 = ? ",
               "   AND stga005 = ? ",
               "   AND stga003 = ? ",
               "   AND stga013 = ? "
   PREPARE astp508_stga_pre FROM l_sql    

   #取出銷售數量SQL(依庫區)
   LET l_sql = "SELECT SUM(debd014) ",
               "  FROM debd_t ",
               " WHERE debdent = ",g_enterprise, 
               "   AND debd002 = '",p_debc002,"'",
               "   AND debdsite = ? ",
               "   AND debd010 = ? ",
               "   AND debd005 = ? "              
   PREPARE astp508_debc013_pre FROM l_sql 
    
   #檢查要計算的庫區是否有日結資料
   LET l_sql = " SELECT COUNT(*) ",
               "   FROM debd_t ",
               "  WHERE debdent = ",g_enterprise, 
               "    AND debd002 = '",p_debc002,"'",
               "    AND debdsite = ? ",
               "    AND debd010 = ? ",
               "    AND debd005 = ? "    
   PREPARE astp508_debc_pre FROM l_sql               

   #計算成本金額SQL(依庫區不同會員等級依不同執行扣率、折扣分攤比例計算後加總) astp508使用
   #LET l_sql = "SELECT COALESCE(A.debd025,0)*(1-COALESCE(B.stfd007,0)/100)*(COALESCE(B.stfc018,0)/100)*-1 stga012, ", #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
   LET l_sql = "SELECT COALESCE(A.debd025,0)*(1-COALESCE(B.stfd007,0)/100)*(1-COALESCE(B.stfc018,0)/100) stga012, ", #150914-00002#10 Add By ken 150918 劉鑫改計算公式
               "       COALESCE(A.debd025,0) cost,COALESCE(B.stfd007,0) stfd007 ",
               #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(s)
               ##150914-00002#46 Add By Ken 151104 astp508/astp509时，将VIP抽成折扣分摊后，抽成那部分，体现在费用金额字段。
               #"       COALESCE(A.debd025,0)*(1-COALESCE(B.stfd007,0)/100)*(COALESCE(B.stfc018,0)/100) stga011 ",           
               ##150914-00002#46 Add By Ken 151104
               #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(e)
               "  FROM ",
               "       (SELECT debdent,debdsite,debd002,debd010,debd005,debd013,debd025 ",
               #160905-00007#16--mod--str--
#               "          FROM debd_t ) A, ", 
               "          FROM debd_t ",
               "         WHERE debdent=",g_enterprise,
               "       ) A, ",
               #160905-00007#16--mod--end
               "       (SELECT stfaent,stfasite,stfa005,stfc002,stfc018,stfd004,stfd007 ",
               "          FROM stfa_t,stfc_t,stfd_t ",
               "         WHERE stfaent = stfcent ",
               "           AND stfa001 = stfc001 ",
               "           AND stfcent = stfdent ",
               "           AND stfc001 = stfd001 ",
               "           AND stfaent = ",g_enterprise, #160905-00007#16 add
               "           AND stfcseq = stfdseq) B ",
               " WHERE A.debdent = B.stfaent ",
               "   AND A.debdsite = B.stfasite ",
               "   AND A.debd010 = B.stfa005 ",
               "   AND A.debd005 = B.stfc002 ", 
               "   AND A.debd013 = B.stfd004 ",
               "   AND A.debdent = ",g_enterprise, 
               "   AND A.debd002 = '",p_debc002,"'",
               "   AND A.debdsite = ? ",
               "   AND A.debd010 = ? ",
               "   AND A.debd005 = ? "   
   PREPARE astp508_debc1_pre FROM l_sql
   DECLARE astp508_debc1_cur CURSOR FOR astp508_debc1_pre   
   
   #計算促銷成本金額SQL(依庫區不同會員等級的折扣分攤比例計算後加總) astp509使用
   LET l_sql = "SELECT oocq009,COALESCE(debd025,0) cost ",
               "  FROM debd_t ",
               "  LEFT JOIN oocq_t ON debdent = oocqent AND debd013 = oocq002 AND oocqstus = 'Y' AND oocq001 = '2024' ",
               " WHERE debdent = ",g_enterprise, 
               "   AND debd002 = '",p_debc002,"'",
               "   AND debdsite = ? ",
               "   AND debd010 = ? ",
               "   AND debd005 = ? "    
   PREPARE astp508_debc2_pre FROM l_sql 
   DECLARE astp508_debc2_cur CURSOR FOR astp508_debc2_pre  

   #取得符合的促銷庫區的資料
   LET l_sql = " SELECT CASE prei058 WHEN 0 THEN prei057 ELSE prei058 END prei058, ",
               "        COALESCE(prei093,0),COALESCE(prei094,0),COALESCE(prei095,0),COALESCE(prei096,0),COALESCE(prei097,0) ", 
               "   FROM preg_t,preh_t,prei_t ",
               "  WHERE pregent = prehent ", 
               "    AND preg001 = preh001 ", 
               "    AND pregent = preient ", 
               "    AND preg001 = prei001 ", 
               "    AND pregent = ",g_enterprise, 
               "    AND pregsite = ? ",
               "    AND prei004 = ? ",
               "    AND prei003  = ? ",
               "    AND prei081 IN('1','2') ",
               "    AND prei080 = 'Y' ",
               "    AND '",p_debc002,"' BETWEEN preh003 AND preh004 ",
               "    AND ('",p_debc002,"' <= to_char(prei098,'YYYY/MM/DD') OR prei098 IS NULL) ",
               "   ORDER BY prei098 "  
   PREPARE astp508_debc3_pre FROM l_sql 
   DECLARE astp508_debc3_cur SCROLL CURSOR FOR astp508_debc3_pre

   IF p_type = '1' THEN
      #先找出符合要計算的專櫃合同資料(庫區)  astp508
      LET l_sql = "SELECT stfasite,stfa005,stfa010,stfc002 ",
                  "  FROM stfa_t,stfc_t,stfd_t ",
                  " WHERE stfaent = stfcent ",
                  "   AND stfa001 = stfc001 ",
                  "   AND stfcent = stfdent ",
                  "   AND stfc001 = stfd001 ",
                  "   AND stfcseq = stfdseq ",
                  "   AND stfaent = ",g_enterprise, 
                  "   AND stfa004 IN('3','4','5','6') ",
                  "   AND stfd007 > 0 ",
                  "   AND EXISTS(SELECT 1 FROM astp508_org_tmp WHERE ooef001 = stfasite AND ooab_flag = 'Y') ", 
                  "   AND ",l_preg_sql,              
                  "   AND ",p_wc, 
                  "   AND stfc024 IN ('1','3') ",  #150826 add by ken 劉鑫新提出需求
                  " GROUP BY stfasite,stfa005,stfa010,stfc002 ",
                  " ORDER BY stfasite,stfa005,stfa010,stfc002 "
   ELSE
      #先找出符合要計算的專櫃合同資料(庫區)  astp509
      LET l_sql = "SELECT stfasite,stfa005,stfa010,stfc002 ",
                  "  FROM stfa_t,stfc_t ",
                  " WHERE stfaent = stfcent ",
                  "   AND stfa001 = stfc001 ",
                  "   AND stfaent = ",g_enterprise, 
                  #"   AND stfa004 IN('3','4','5','6') ",
                  "   AND EXISTS(SELECT 1 FROM astp508_org_tmp WHERE ooef001 = stfasite AND ooab_flag = 'Y') ", 
                  "   AND ",l_preg_sql,              
                  "   AND ",p_wc, 
                  " GROUP BY stfasite,stfa005,stfa010,stfc002 ",
                  " ORDER BY stfasite,stfa005,stfa010,stfc002 "   
   END IF
   PREPARE astp508_stfa_pre FROM l_sql
   DECLARE astp508_stfa_cur CURSOR FOR astp508_stfa_pre
   FOREACH astp508_stfa_cur INTO l_stfasite,l_stfa005,l_stfa010,l_stfc002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Sel astp508_stfa"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
      #檢查要計算的庫區是否有日結資料來源
      EXECUTE astp508_debc_pre USING l_stfasite,l_stfa005,l_stfc002 INTO l_count
      IF l_count = 0 THEN   #沒日結資料來源時不寫入
         CONTINUE FOREACH
      END IF
      
      #檢查astq501是否已有資料
      EXECUTE astp508_stga_pre USING l_stfasite,l_stfa005,l_stfa010,l_stfc002,l_stga013 INTO l_count
      IF l_count > 0 THEN
         CONTINUE FOREACH
      END IF
      
      #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(s)
      #LET l_stga011 = 0 #150914-00002#46 Add By Ken 151104
      #LET l_stga011_1 = 0 #150914-00002#46 Add By Ken 151104
      #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(e)
      LET l_stga012 = 0 
      LET l_stga012_1 = 0
      LET l_tcost = 0
      LET l_prei093 = 0
      LET l_prei094 = 0
      LET l_prei095 = 0
      LET l_prei096 = 0
      LET l_prei097 = 0
      #成本金額
      IF p_type = 1 THEN   #astp508
         FOREACH astp508_debc1_cur USING l_stfasite,l_stfa005,l_stfc002 INTO l_stga012_1,l_cost,l_stfd007#,l_stga011_1  #150914-00002#46 Add By Ken 151104 加l_stga011  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
            LET l_stga012 = l_stga012 + l_stga012_1                       #供應商分攤金額加總
            #LET l_stga011 = l_stga011 + l_stga011_1   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
            #LET l_tcost = l_tcost + ( l_cost * l_stfd007/100 * -1)        #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式(待補型管單號)
         END FOREACH
      ELSE                 #astp509
         #先取的符合的庫區資料
         OPEN astp508_debc3_cur USING l_stfasite,l_stfa005,l_stfc002 
         FETCH FIRST astp508_debc3_cur INTO l_stfc018,l_prei093,l_prei094,l_prei095,l_prei096,l_prei097                                                    
         IF cl_null(l_stfc018) THEN
            LET l_stfc018 = 0
         END IF
         #取符合的庫區日結資料出來計算(一庫區有多筆會員等級)
         FOREACH astp508_debc2_cur USING l_stfasite,l_stfa005,l_stfc002 INTO l_oocq009,l_cost
            CASE l_oocq009
              WHEN '1'
                 LET l_stga012_1 = l_cost * (1-l_stfc018/100) * (1-l_prei093/100)                 
                 #LET l_stga011_1 = l_cost * (l_stfc018/100) * (1-l_prei093/100)   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_stga012_1 = l_cost * (l_stfc018/100) * (1-l_prei093/100) * -1   #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
                 #LET l_tcost = l_tcost + (l_cost * l_prei093/100 * -1)           #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
              WHEN '2'
                 LET l_stga012_1 = l_cost * (1-l_stfc018/100) * (1-l_prei094/100)                   
                 #LET l_stga011_1 = l_cost * (l_stfc018/100) * (1-l_prei094/100)   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_stga012_1 = l_cost * (l_stfc018/100) * (1-l_prei094/100) * -1   #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
                 #LET l_tcost = l_tcost + (l_cost * l_prei094/100 * -1)           #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
              WHEN '3'
                 LET l_stga012_1 = l_cost * (1-l_stfc018/100) * (1-l_prei095/100)   
                 #LET l_stga011_1 = l_cost * (l_stfc018/100) * (1-l_prei095/100)   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_stga012_1 = l_cost * (l_stfc018/100) * (1-l_prei095/100) * -1   #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
                 #LET l_tcost = l_tcost + (l_cost * l_prei095/100 * -1)           #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
              WHEN '4'
                 LET l_stga012_1 = l_cost * (1-l_stfc018/100) * (1-l_prei096/100)    
                 #LET l_stga011_1 = l_cost * (l_stfc018/100) * (1-l_prei096/100)   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_stga012_1 = l_cost * (l_stfc018/100) * (1-l_prei096/100) * -1   #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
                 #LET l_tcost = l_tcost + (l_cost * l_prei096/100 * -1)           #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
              WHEN '5'
                 LET l_stga012_1 = l_cost * (1-l_stfc018/100) * (1-l_prei097/100)  
                 #LET l_stga011_1 = l_cost * (l_stfc018/100) * (1-l_prei097/100)   #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_stga012_1 = l_cost * (l_stfc018/100) * (1-l_prei097/100) * -1   #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
                 #LET l_tcost = l_tcost + (l_cost * l_prei097/100 * -1)           #百貨分攤中 供應商要部分分攤 #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
              OTHERWISE
                 LET l_stga012_1 = l_stga012_1 + 0
                 #LET l_stga011_1 = l_stga012_1 + 0  #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總    #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
                 #LET l_tcost = l_tcost + 0  #Mark By ken 150918 劉鑫改計算公式(待補型管單號)
            END CASE                       
            LET l_stga012 = l_stga012 + l_stga012_1 #供應商分攤金額加總   
            #LET l_stga011 = l_stga011 + l_stga011_1 #150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總    #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
         END FOREACH
      END IF
      
      #LET l_stga012 = l_stga012 + l_tcost #150914-00002#10 Mark By ken 150918 劉鑫改計算公式
      IF cl_null(l_stga012) THEN
         LET l_stga012 = 0
      END IF
      #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(s)
      ##150914-00002#46 Add By Ken 151104 加l_stga011 供應商分攤費用加總 
      #IF cl_null(l_stga011) THEN
      #   LET l_stga011 = 0
      #END IF
      ##150914-00002#46 Add By Ken 151104
      #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改(e)
      
      #成本金額=0時 不產生到astq501
      IF l_stga012 != 0 THEN
         EXECUTE astp508_debc013_pre USING l_stfasite,l_stfa005,l_stfc002 INTO l_stga007 #銷售數量     
         LET l_stga.stgaent = g_enterprise
         LET l_stga.stgasite = l_stfasite
         LET l_stga.stgaunit = l_stfasite
         LET l_stga.stga001 = p_debc002    #銷售日期
         LET l_stga.stga002 = ' '          #商品編號
         LET l_stga.stga003 = l_stfc002    #庫區編號
         LET l_stga.stga004 = l_stfa005    #專櫃編號
         LET l_stga.stga005 = l_stfa010    #供應商編號
         LET l_stga.stga006 = l_stav002    #費用編號
         LET l_stga.stga007 = l_stga007    #銷售數量
         LET l_stga.stga008 = 0            #應收金額
         LET l_stga.stga009 = 0            #實收金額
         LET l_stga.stga010 = 0            #費率
         LET l_stga.stga011 = 0            #費用金額 
         #LET l_stga.stga011 = l_stga011    #費用金額  #150914-00002#46 Add By Ken 151104 加l_stga011  #151104 依劉鑫需求改完後又說還原，此部分先mark，避免下次又要改
         LET l_stga.stga012 = l_stga012    #成本金額
         LET l_stga.stga013 = l_stga013    #日結成本類別
         LET l_stga.stga014 = l_stae006    #價款類型
         LET l_stga.stga015 = 'N'          #已結轉否
         LET l_stga.stgadocno = ' '        #來源單號     
         
         #150914-00002#42 2015/10/28 s983961--add(s)
         #按當前幣別截取aooi150裡的用戶設置小數位 處理金額欄位
         SELECT ooef016 
           INTO l_ooef016
           FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = l_stga.stgasite
            
         IF NOT cl_null(l_ooef016) THEN  
           IF NOT cl_null(l_stga.stga008) AND l_stga.stga008<>0 THEN                  
             CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga008,'2') RETURNING l_stga.stga008
           END IF  
           
           IF NOT cl_null(l_stga.stga009) AND l_stga.stga009<>0 THEN           
             CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga009,'2') RETURNING l_stga.stga009
           END IF  
           
           IF NOT cl_null(l_stga.stga011) AND l_stga.stga011<>0 THEN           
             CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga011,'2') RETURNING l_stga.stga011
           END IF  
           
           IF NOT cl_null(l_stga.stga012) AND l_stga.stga012<>0 THEN           
             CALL s_curr_round(l_stga.stgasite,l_ooef016,l_stga.stga012,'2') RETURNING l_stga.stga012
           END IF 
         END IF    
         #150914-00002#42 2015/10/28 s983961--add(e)
         
         
         INSERT INTO stga_t(stgaent,   stgasite,   stgaunit,    stga001,
                            stga002,   stga003,    stga004,     stga005,
                            stga006,   stga007,    stga008,     stga009,
                            stga010,   stga011,    stga012,     stga013,
                            stga014,   stga015,    stgadocno)
            VALUES(l_stga.stgaent, l_stga.stgasite, l_stga.stgaunit,  l_stga.stga001,
                   l_stga.stga002, l_stga.stga003,  l_stga.stga004,   l_stga.stga005,
                   l_stga.stga006, l_stga.stga007,  l_stga.stga008,   l_stga.stga009,
                   l_stga.stga010, l_stga.stga011,  l_stga.stga012,   l_stga.stga013,
                   l_stga.stga014, l_stga.stga015,  l_stga.stgadocno)     
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Ins stga_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF   
      END IF
   END FOREACH
   
   #把adeq110中無資料的組織匯總到錯誤訊息
   LET l_sql = "SELECT ooef001 FROM astp508_org_tmp WHERE sour_flag = 'N' "
   PREPARE astp508_tmp_table_n_pre FROM l_sql
   DECLARE astp508_tmp_table_n_cur CURSOR FOR astp508_tmp_table_n_pre
   FOREACH astp508_tmp_table_n_cur INTO l_ooef001
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp508_tmp_table_n_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success         
   END IF 
   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "ade-00152"
      LET g_errparam.extend = ''    
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = l_ooef001
      CALL cl_err()
   END FOREACH
   
   #把adeq110中關帳日期比統計日期大的組織匯總到錯誤訊息
   LET l_sql = "SELECT ooef001,ooab002 FROM astp508_org_tmp WHERE ooab_flag = 'N' "
   PREPARE astp508_tmp_table_n1_pre FROM l_sql
   DECLARE astp508_tmp_table_n1_cur CURSOR FOR astp508_tmp_table_n1_pre
   FOREACH astp508_tmp_table_n1_cur INTO l_ooef001,l_ooab002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp508_tmp_table_n1_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success         
   END IF 
   
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "ast-00302"
      LET g_errparam.extend = ''    
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_debc002
      LET g_errparam.replace[2] = l_ooef001
      LET g_errparam.replace[3] = l_ooab002
      CALL cl_err()
   END FOREACH      
   
   RETURN r_success    
   
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL astp508_drop_org_tmp()
# Date & Author..: 2015/07/09 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_drop_tmp()
   WHENEVER ERROR CONTINUE   

   DROP TABLE astp508_org_tmp
END FUNCTION

################################################################################
# Descriptions...: 新增促銷談判暫存表
# Memo...........:
# Usage..........: CALL astp508_create_preg_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/24 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_create_preg_tmp()
   WHENEVER ERROR CONTINUE
   
   CALL astp508_drop_preg_tmp()
   CREATE TEMP TABLE astp508_tmp01(  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
      pregsite   VARCHAR(10),
      prei003    VARCHAR(10))
END FUNCTION

################################################################################
# Descriptions...: 刪除促銷談判暫存表
# Memo...........:
# Usage..........: CALL astp508_drop_preg_tmp()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/07/24 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_drop_preg_tmp()
   WHENEVER ERROR CONTINUE   

   DROP TABLE astp508_tmp01  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
END FUNCTION

################################################################################
# Descriptions...: 符合統計日期的促銷庫區編號
# Memo...........: 執行注意...
#                  CALL astp508_create_preg_tmp
#                  CALL s_transaction_begin
#                  CALL astp508_extand_preg(p_debc002)
#                  CALL s_transaction_end
#                  CALL astp508_drop_preg_tmp
# Usage..........: CALL astp508_extand_preg(p_debc002)
# Input parameter: p_debc002     統計日期
# Date & Author..: 2015/07/24 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp508_extand_preg(p_debc002)
   DEFINE p_debc002         LIKE debc_t.debc002
   DEFINE l_sql             STRING   
   DEFINE l_prei003         LIKE prei_t.prei003
   DEFINE str_tmp           STRING
   
   WHENEVER ERROR CONTINUE
      
   #符合統計日期的促銷庫區編號
   LET l_sql = "INSERT INTO astp508_tmp01(pregsite,prei003) ",  #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
               "SELECT DISTINCT pregsite,prei003 ",
               "  FROM preg_t,preh_t,prei_t ", 
               " WHERE pregent = prehent ",
               "   AND preg001 = preh001 ",
               "   AND pregent = preient ",
               "   AND preg001 = prei001 ",
               "   AND pregent = ",g_enterprise,
               "   AND prei081 IN('1','2') ",
               "   AND prei080 = 'Y' ",
               "   AND '",p_debc002,"' BETWEEN preh003 AND preh004 ",
               "   AND ('",p_debc002,"' <= to_char(prei098,'YYYY/MM/DD') OR prei098 IS NULL) "               
   PREPARE astp508_tmp01 FROM l_sql   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
   EXECUTE astp508_tmp01    #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
   
   LET str_tmp =''
   
   LET l_sql = "SELECT prei003 FROM astp508_tmp01"   #160727-00019#19   16/08/04 By 08734 临时表长度超过15码的减少到15码以下 astp508_preg_tmp ——> astp508_tmp01
   PREPARE astp508_preg_tmp1 FROM l_sql
   DECLARE astp508_preg_tmp1_cur CURSOR FOR astp508_preg_tmp1
   FOREACH astp508_preg_tmp1_cur INTO l_prei003
      LET str_tmp = str_tmp,"|",l_prei003
   END FOREACH
   DISPLAY "prei003:",str_tmp
END FUNCTION

#end add-point
 
{</section>}
 
