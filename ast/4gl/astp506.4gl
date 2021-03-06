#該程式未解開Section, 採用最新樣板產出!
{<section id="astp506.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2017-01-11 09:39:42), PR版次:0003(2017-01-11 11:31:40)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000049
#+ Filename...: astp506
#+ Description: 專櫃目標銷售成本批次產生作業
#+ Creator....: 01752(2015-05-28 15:14:22)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="astp506.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160516-00014#42   2017/01/11  By lori     1.專櫃合約新增欄位：stfa058 終止銷售計算，對應調目標銷售的結算邏輯
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
        l_date            LIKE type_t.dat,
        l_del             LIKE type_t.chr1,
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
   l_date LIKE type_t.chr500, 
   l_del LIKE type_t.chr500, 
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
 
{<section id="astp506.main" >}
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
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp506_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp506 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp506_init()
 
      #進入選單 Menu (="N")
      CALL astp506_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp506
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp506.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp506_init()
 
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
 
{<section id="astp506.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp506_ui_dialog()
 
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
         INPUT BY NAME g_master.l_date,g_master.l_del 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_date
            #add-point:BEFORE FIELD l_date name="input.b.l_date"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_date
            
            #add-point:AFTER FIELD l_date name="input.a.l_date"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_date
            #add-point:ON CHANGE l_date name="input.g.l_date"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_del
            #add-point:BEFORE FIELD l_del name="input.b.l_del"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_del
            
            #add-point:AFTER FIELD l_del name="input.a.l_del"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_del
            #add-point:ON CHANGE l_del name="input.g.l_del"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_date
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_date
            #add-point:ON ACTION controlp INFIELD l_date name="input.c.l_date"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_del
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_del
            #add-point:ON ACTION controlp INFIELD l_del name="input.c.l_del"
            
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
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfasite
            #add-point:BEFORE FIELD stfasite name="construct.b.stfasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfasite
            
            #add-point:AFTER FIELD stfasite name="construct.a.stfasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stfasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfasite
            #add-point:ON ACTION controlp INFIELD stfasite name="construct.c.stfasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO stfasite  #顯示到畫面上
            NEXT FIELD stfasite                     #返回原欄位    

            #END add-point
 
 
         #Ctrlp:construct.c.stfa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa005
            #add-point:ON ACTION controlp INFIELD stfa005 name="construct.c.stfa005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001_2()                       #呼叫開窗
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
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                       #呼叫開窗
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
            CALL astp506_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.l_date = g_today
            DISPLAY g_master.l_date TO l_date
            LET g_master.l_del  = 'Y' 
            DISPLAY g_master.l_del TO l_del
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
         CALL astp506_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_date = g_master.l_date
      LET lc_param.l_del  = g_master.l_del
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
                 CALL astp506_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp506_transfer_argv(ls_js)
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
 
{<section id="astp506.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp506_transfer_argv(ls_js)
 
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
 
{<section id="astp506.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp506_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success     LIKE type_t.num5
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
      CALL cl_progress_bar_no_window(3)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp506_process_cs CURSOR FROM ls_sql
#  FOREACH astp506_process_cs INTO
   #add-point:process段process name="process.process"
     
   CALL astp506_create_temp() RETURNING l_success 
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   CALL astp506_process1(lc_param.l_date,lc_param.l_del,lc_param.wc) RETURNING l_success
   CALL cl_err_collect_show()
   IF l_success THEN
      CALL s_transaction_end('Y','1') 
   ELSE
      CALL s_transaction_end('N','0')
   END IF
        
   CALL astp506_drop_temp() RETURNING l_success
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
   CALL astp506_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp506.get_buffer" >}
PRIVATE FUNCTION astp506_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
   LET g_master.l_del = p_dialog.getFieldBuffer('l_del')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp506.msgcentre_notify" >}
PRIVATE FUNCTION astp506_msgcentre_notify()
 
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
 
{<section id="astp506.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION astp506_process1(p_date,p_del,p_wc)
   DEFINE p_wc          STRING
   DEFINE p_date        LIKE type_t.dat
   DEFINE p_del         LIKE type_t.chr1
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_success     LIKE type_t.num5
   DEFINE l_sql         STRING         
   DEFINE l_sql2        STRING    
   DEFINE l_wc          STRING               #移去stfasite的p_wc條件 
   DEFINE l_msg         STRING   
   DEFINE l_ac          LIKE type_t.num5
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_stab010     LIKE stab_t.stab010  #150623-00013#5 Add By Ken 150804 (含折扣否)
   DEFINE l_stfe008     LIKE stfe_t.stfe008
   DEFINE l_stfe009     LIKE stfe_t.stfe009
   DEFINE l_stfa      RECORD
            ooef001     LIKE ooef_t.ooef001,
            stfa001     LIKE stfa_t.stfa001,
            stfa005     LIKE stfa_t.stfa005,
            stfa010     LIKE stfa_t.stfa010,
            stfcseq     LIKE stfc_t.stfcseq,
            stfc002     LIKE stfc_t.stfc002,
            stfc016     LIKE stfc_t.stfc016,
            stfc018     LIKE stfc_t.stfc018,
            stfe002     LIKE stfe_t.stfe002,
            stfeseq     LIKE stfe_t.stfeseq,
            stfe003     LIKE stfe_t.stfe003,
            stfe008     LIKE stfe_t.stfe008,
            stfe009     LIKE stfe_t.stfe009
                      END RECORD 
   DEFINE l_stga007        LIKE stga_t.stga007
   DEFINE l_stga008        LIKE stga_t.stga008
   DEFINE l_stga009        LIKE stga_t.stga009
   DEFINE l_money_sum      LIKE debc_t.debc018    
   DEFINE l_money_suma     LIKE debc_t.debc018    #常規庫區+促銷庫區的原價總金額
   DEFINE l_money_sumb     LIKE debc_t.debc020    #常規庫區+促銷庫區的實收總金額
   DEFINE l_qty            LIKE debc_t.debc013    #常規庫區+促銷庫區的總銷售數量
   DEFINE l_money_sum1a    LIKE debc_t.debc018    #常規庫區原價總金額
   DEFINE l_money_sum1b    LIKE debc_t.debc020    #常規庫區實收總金額
   DEFINE l_qty1           LIKE debc_t.debc013    #常規庫區總銷售數量
   DEFINE l_money_sum2a    LIKE debc_t.debc018    #促銷庫區原價總金額
   DEFINE l_money_sum2b    LIKE debc_t.debc020    #促銷庫區實收總金額
   DEFINE l_qty2           LIKE debc_t.debc013    #促銷庫區總銷售數量   
   DEFINE l_money_sum3a    LIKE debc_t.debc018    #促銷原價總金額
   DEFINE l_money_sum3b    LIKE debc_t.debc020    #促銷實收總金額
   DEFINE l_qty3           LIKE debc_t.debc013    #促銷總銷售數量      
   DEFINE l_amount         LIKE debc_t.debc018    
   DEFINE l_stfc002        LIKE stfc_t.stfc002    
   DEFINE l_totday         LIKE type_t.num5       #當月天數
   DEFINE l_totday1        LIKE type_t.num5       #保底天數
   DEFINE l_preh003        LIKE preh_t.preh003
   DEFINE l_preh004        LIKE preh_t.preh004
   DEFINE l_stff      DYNAMIC ARRAY OF RECORD
            stfe005        LIKE stfe_t.stfe005,
            stff006        LIKE stff_t.stff006,
            stff007        LIKE stff_t.stff007,
            stff008        LIKE stff_t.stff008,
            stff010        LIKE stff_t.stff010,
            stff011        LIKE stff_t.stff011,
            amount         LIKE debc_t.debc018
                       END RECORD
   DEFINE l_i              LIKE type_t.num5    
   DEFINE l_yy             LIKE type_t.num5
   DEFINE l_mm             LIKE type_t.num5
   DEFINE l_stab008        LIKE stab_t.stab008
   DEFINE l_stab012        LIKE stab_t.stab012
   DEFINE l_stga       RECORD 
            stgaent        LIKE stga_t.stgaent,
            stgasite       LIKE stga_t.stgasite,
            stgaunit       LIKE stga_t.stgaunit,
            stga001        LIKE stga_t.stga001,
            stga002        LIKE stga_t.stga002,
            stga003        LIKE stga_t.stga003,
            stga004        LIKE stga_t.stga004,
            stga005        LIKE stga_t.stga005,
            stga006        LIKE stga_t.stga006,
            stga007        LIKE stga_t.stga007,
            stga008        LIKE stga_t.stga008,
            stga009        LIKE stga_t.stga009,
            stga010        LIKE stga_t.stga010,
            stga011        LIKE stga_t.stga011,
            stga012        LIKE stga_t.stga012,
            stga013        LIKE stga_t.stga013,
            stga014        LIKE stga_t.stga014,
            stga015        LIKE stga_t.stga015,
            stgadocno      LIKE stga_t.stgadocno,
            stga017        LIKE stga_t.stga017            
                       END RECORD
   DEFINE l_money_promotions LIKE debc_t.debc018
   DEFINE l_para_rebates     LIKE type_t.chr1
   
   #Add By baogc 20151029 Begin ---
   DEFINE l_sql_date    STRING             #取天数Sql
   DEFINE l_sql_exclude STRING             #排除天数Sql
   DEFINE l_date_s      LIKE type_t.num10  #计算保底总销售天数
   DEFINE l_date_c      LIKE type_t.num10  #不参与保底天数
   DEFINE l_preg051     LIKE preg_t.preg051
   DEFINE l_prei059     LIKE prei_t.prei059
   #Add By baogc 20151029 End   ---
   
   LET r_success = TRUE
   
   CALL astp506_ins_temp1(p_wc,p_date) RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_sql2 = "  WHERE stgaent = ",g_enterprise,
                "    AND EXISTS (SELECT 1 FROM astp506_temp1 ",
                "                 WHERE ooef001 = stgasite ",
                "                   AND stfc002 = stga003 ",
                "                   AND stfe008 = ? AND stfe009 = ? )",
                "    AND stga001 = ? ",
                "    AND stga013 = '5'"                   
   LET l_sql = " SELECT COUNT(*) FROM stga_t ",
                  l_sql2,
               "    AND stga015 = 'Y'" 
   PREPARE astp506_sel_prep1 FROM l_sql
     
   LET l_sql = "DELETE FROM stga_t ",l_sql2 
   PREPARE astp506_del_prep1 FROM l_sql
   
   DECLARE astp506_cs3 CURSOR WITH HOLD FOR
    SELECT UNIQUE stfe008,stfe009 FROM astp506_temp1
    
   LET l_msg = cl_getmsg('ast-00329',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   
   #每紙合約的起始與截止日期可能會不盡相同
   #要檢查stga_t的資料 需要分段檢查
   FOREACH astp506_cs3 INTO l_stfe008,l_stfe009

      EXECUTE astp506_sel_prep1 USING l_stfe008,l_stfe009,l_stfe009 INTO l_cnt   
      
      IF l_cnt > 0 THEN
         #此次重新計算的範圍內存在已結轉的資料,無法進行此批次作業
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'ast-00306'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      ELSE
         IF p_del = 'Y' THEN
            EXECUTE astp506_del_prep1 USING l_stfe008,l_stfe009,l_stfe009
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'Delete stga_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF    
         END IF            
      END IF       
   END FOREACH

   DECLARE astp506_cs4 CURSOR WITH HOLD FOR
    SELECT UNIQUE ooef001,stfa001,stfa005,stfa010,stfcseq,
                  stfc002,stfc016,stfc018,stfe002,stfeseq,
                  stfe003,stfe008,stfe009      
      FROM astp506_temp1
     ORDER BY ooef001,stfa001,stfa005

   #取促銷庫區編號
   LET l_sql = " SELECT UNIQUE stfc002 FROM stfc_t ",
               "  WHERE stfcent = ",g_enterprise,
               "    AND stfcsite = ? ",
               "    AND stfc001 = ? ",
               "    AND stfc025 = ? "         
   PREPARE astp506_cs_prep5 FROM l_sql
   DECLARE astp506_cs5 CURSOR WITH HOLD FOR astp506_cs_prep5

  #Mark By baogc 20151030 Begin ---
  ##依庫區 取促銷談判中不參與保底計算的銷售區間
  #LET l_sql = " SELECT UNIQUE preh003,preh004 FROM preg_t,preh_t,prei_t ",
  #            "  WHERE pregent = prehent AND pregent = preient",
  #            "    AND preg001 = preh001 AND preg001 = prei001",
  #            "    AND preh002 = preiseq ",
  #            "    AND prei003 = ? ",    #庫區
  #            "    AND pregstus = 'Y'",
  #            "    AND prei059 = 'N'",   #不參與保底計算的期間  
  #            "    AND preh003 IS NOT NULL AND preh004 IS NOT NULL "               
  #PREPARE astp506_cs_prep6 FROM l_sql
  #DECLARE astp506_cs6 CURSOR WITH HOLD FOR astp506_cs_prep6
  #Mark By baogc 20151030 End   ---
   
   #保底的目標設定
   LET l_sql = " SELECT stfe005,stff006,stff007,stff008,stff010,stff011*-1,0 FROM stfe_t,stff_t",
               "  WHERE stfeent = stffent AND stfe001 = stff001 ",
               "    AND stfeseq = stff003 AND stfe002 = stff002 ",
               "    AND stfe001 = ? ",   #合同編號
               "    AND stff005 = ? ",   #庫區
               "    AND stfe002 = ? ",   #方案編號
               "    AND stfeseq = ? ",   #方案項次
               "  ORDER BY stff006 "
   PREPARE astp506_cs_prep7 FROM l_sql
   DECLARE astp506_cs7 CURSOR WITH HOLD FOR astp506_cs_prep7
   
   #取原價金額、實收金額、銷售數量(不分一般銷售和促銷)
   LET l_sql = " SELECT SUM(COALESCE(stga007,0)),SUM(COALESCE(stga008,0)),SUM(COALESCE(stga009,0)) ", #150805-00003#42 Modify by ken 150831 應收金額改原價金額
               "   FROM stga_t ",
               "  WHERE stgaent = ",g_enterprise,
               "    AND stgasite = ? ",
               "    AND stga001 BETWEEN ? AND ? ",
               "    AND stga003 = ? ",
               "    AND stga004 = ? ",
               "    AND stga013 IN ('1','7')"
   PREPARE astp506_sum_prep1 FROM l_sql   #使用時 依序傳入 組織,起始日,截止日,區庫編號,專櫃編號
   
   #取原價金額、實收金額、銷售數量(僅促銷)
   LET l_sql = " SELECT SUM(COALESCE(stga007,0)),SUM(COALESCE(stga008,0)),SUM(COALESCE(stga009,0)) ", #150805-00003#42 Modify by ken 150831 應收金額改原價金額
               "   FROM stga_t ",
               "  WHERE stgaent = ",g_enterprise,
               "    AND stgasite = ? ",
               "    AND stga001 BETWEEN ? AND ? ",
               "    AND stga003 = ? ",
               "    AND stga004 = ? ",
               "    AND stga013 = '7' "
   PREPARE astp506_sum_prep2 FROM l_sql   #使用時 依序傳入 組織,起始日,截止日,區庫編號,專櫃編號
   
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   FOREACH astp506_cs4 INTO l_stfa.*
      
      LET l_para_rebates = cl_get_para(g_enterprise,l_stfa.ooef001,"S-CIR-2016")

      #Add By baogc 20151029 Begin ---
      #取出当前库区需要计算销售的总天数
      LET l_sql_date =
                  " SELECT COUNT(*) ",
                  "   FROM ( ",
                  "         SELECT to_date('",l_stfa.stfe008,"','yyyy/mm/dd')+level-1 date_t ",
                  "           FROM dual ",
                  "        CONNECT BY level <= to_date('",l_stfa.stfe009,"','yyyy/mm/dd') - to_date('",l_stfa.stfe008,"','yyyy/mm/dd') + 1 ",
                  "         ) ",
                  "  WHERE 1=1 "
      PREPARE astp506_sel_date_sum_pre FROM l_sql_date
      EXECUTE astp506_sel_date_sum_pre INTO l_date_s
      
      #初始化排除Sql
      INITIALIZE l_sql_exclude TO NULL
      #Add By baogc 20151029 End   ---

      #常規庫區的銷售總額 --- S
      LET l_money_sum1a = 0   LET l_money_sum1b = 0  LET l_qty1 = 0
      #計算保底的範圍統計
      LET l_stga007 = 0  LET l_stga008 = 0  LET l_stga009 = 0  
      EXECUTE astp506_sum_prep1 
        USING l_stfa.ooef001,l_stfa.stfe008,l_stfa.stfe009,l_stfa.stfc002,l_stfa.stfa005
         INTO l_stga007,l_stga008,l_stga009 
      IF cl_null(l_stga007) THEN LET l_stga007 = 0 END IF  
      IF cl_null(l_stga008) THEN LET l_stga008 = 0 END IF
      IF cl_null(l_stga009) THEN LET l_stga009 = 0 END IF
      LET l_money_sum1a = l_stga008  
      LET l_money_sum1b = l_stga009 
      LET l_qty1 = l_stga007     
      #常規庫區的銷售總額 --- E
      
      #促銷庫區的銷售總額 --- S
      LET l_money_sum2a = 0   LET l_money_sum2b = 0  LET l_qty2 = 0
      LET l_money_sum3a = 0   LET l_money_sum3b = 0  LET l_qty3 = 0
      FOREACH astp506_cs5 USING l_stfa.ooef001,l_stfa.stfa001,l_stfa.stfc002 INTO l_stfc002        
         #計算保底的範圍統計
         LET l_stga007 = 0  LET l_stga008 = 0  LET l_stga009 = 0
         EXECUTE astp506_sum_prep1 
           USING l_stfa.ooef001,l_stfa.stfe008,l_stfa.stfe009,l_stfc002,l_stfa.stfa005
            INTO l_stga007,l_stga008,l_stga009 

         IF cl_null(l_stga007) THEN LET l_stga007 = 0 END IF  
         IF cl_null(l_stga008) THEN LET l_stga008 = 0 END IF
         IF cl_null(l_stga009) THEN LET l_stga009 = 0 END IF
         LET l_money_sum2a = l_money_sum2a + l_stga008  
         LET l_money_sum2b = l_money_sum2b + l_stga009 
         LET l_qty2 = l_qty2 + l_stga007
         
         #將促銷時的銷售數據存下來,供後續運算使用
         LET l_stga007 = 0  LET l_stga008 = 0  LET l_stga009 = 0
         EXECUTE astp506_sum_prep2 
           USING l_stfa.ooef001,l_stfa.stfe008,l_stfa.stfe009,l_stfc002,l_stfa.stfa005
            INTO l_stga007,l_stga008,l_stga009 

         IF cl_null(l_stga007) THEN LET l_stga007 = 0 END IF  
         IF cl_null(l_stga008) THEN LET l_stga008 = 0 END IF
         IF cl_null(l_stga009) THEN LET l_stga009 = 0 END IF
         LET l_money_sum3a = l_money_sum3a + l_stga008  
         LET l_money_sum3b = l_money_sum3b + l_stga009 
         LET l_qty3 = l_qty3 + l_stga007

        #Mark&Add By baogc 20151029 Begin ---
        ##不參與保底的範圍的排除
        #FOREACH astp506_cs6 USING l_stfc002 INTO l_preh003,l_preh004
        
         #不參與保底的範圍的排除
         #依庫區 取促銷談判中不參與保底計算的銷售區間
         LET l_sql = " SELECT UNIQUE preh003,preh004,preg051,prei059 ",
                     "   FROM preg_t,preh_t,prei_t ",
                     "  WHERE pregent = prehent AND pregent = preient ",
                     "    AND preg001 = preh001 AND preg001 = prei001 ",
                     "    AND preh002 = preiseq ",
                     "    AND prei003 = ? ",    #庫區
                     "    AND pregstus = 'Y' ",
                     "    AND preh003 IS NOT NULL AND preh004 IS NOT NULL "
         #不參與保底計算的逻辑说明
         #一、不参与计算的销售额
         #    当参数设置为1.全额返利时
         #                  a.临时促销的销售额不参与保底
         #                  b.主题促销并且参与保底否为N的销售额不参与保底
         #    当参数设置为2.差额返利时
         #                  参与保底否为N的销售额不参与保底
         #二、不参与计算的销售天数
         #    其中主题促销且参与保底否为N的销售天数不参与保底计算
         CASE l_para_rebates
            WHEN '1' #全额返利
               LET l_sql = l_sql CLIPPED," ",
                     "    AND (   (preg051 = '1' AND prei059 = 'N') ",
                     "         OR preg051 = '2') "   
            WHEN '2' #差额返利
               LET l_sql = l_sql CLIPPED," ",
                     "    AND prei059 = 'N' "
         END CASE
         PREPARE astp506_sel_exclude_pre FROM l_sql
         DECLARE astp506_sel_exclude_cs CURSOR WITH HOLD FOR astp506_sel_exclude_pre
         FOREACH astp506_sel_exclude_cs USING l_stfc002 INTO l_preh003,l_preh004,l_preg051,l_prei059
        #Mark&Add By baogc 20151029 Begin ---
        
            IF l_preh003 > l_preh004 THEN CONTINUE FOREACH END IF    
            LET l_stga007 = 0  LET l_stga008 = 0  LET l_stga009 = 0
            EXECUTE astp506_sum_prep2
              USING l_stfa.ooef001,l_preh003,l_preh004,l_stfc002,l_stfa.stfa005
               INTO l_stga007,l_stga008,l_stga009  
               
            IF cl_null(l_stga007) THEN LET l_stga007 = 0 END IF  
            IF cl_null(l_stga008) THEN LET l_stga008 = 0 END IF
            IF cl_null(l_stga009) THEN LET l_stga009 = 0 END IF            
            LET l_money_sum2a = l_money_sum2a - l_stga008
            LET l_money_sum2b = l_money_sum2b - l_stga009
            LET l_qty2 = l_qty2 - l_stga007    
            
            LET l_money_sum3a = l_money_sum3a - l_stga008
            LET l_money_sum3b = l_money_sum3b - l_stga009
            LET l_qty3 = l_qty3 - l_stga007   
            
            #Add By baogc 20151029 Begin ---
            #组出不参与保底的日期范围条件
            #其中主题促销且参与保底否为N的销售天数不参与保底计算
            IF l_preg051 = '1' AND l_prei059 = 'N' THEN
               IF cl_null(l_sql_exclude) THEN
                  LET l_sql_exclude = l_sql_exclude CLIPPED," ",
                     "    AND (   date_t BETWEEN '",l_preh003,"' AND '",l_preh004,"' "
               ELSE
                  LET l_sql_exclude = l_sql_exclude CLIPPED," ",
                     "         OR date_t BETWEEN '",l_preh003,"' AND '",l_preh004,"' "
               END IF
            END IF
            #Add By baogc 20151029 End   ---
            
         END FOREACH         
      END FOREACH 
      #促銷庫區的銷售總額 --- E   
      LET l_money_suma = l_money_sum1a + l_money_sum2a
      LET l_money_sumb = l_money_sum1b + l_money_sum2b
      LET l_qty = l_qty1 + l_qty2            

      #Add By baogc 20151029 Begin ---
      #若排除Sql不为空则补全Sql
      LET l_date_c = 0
      IF NOT cl_null(l_sql_exclude) THEN
         LET l_sql_exclude = l_sql_exclude CLIPPED," ",
               "         ) "
         #取出不参与保底的天数
         LET l_sql_date = l_sql_date CLIPPED," ",l_sql_exclude CLIPPED," "
         PREPARE astp506_sel_date_exc_pre FROM l_sql_date
         EXECUTE astp506_sel_date_exc_pre INTO l_date_c
      END IF
      #若排除天数为空则给值0
      IF cl_null(l_date_c) THEN LET l_date_c = 0 END IF
      #Add By baogc 20151029 End   ---

      #150623-00013#5 Modify By Ken 150804(S)
      ##判斷此常規庫區要用實收金額或應收金額計算      
      CALL astp506_get_stab010(l_stfa.stfc016) RETURNING l_stab010
      IF l_stab010 = 'Y' THEN   #含折扣(原價)
         LET l_money_sum = l_money_suma
         LET l_money_promotions = l_money_sum3a
      ELSE                      #不含折扣(實收)
         LET l_money_sum = l_money_sumb
         LET l_money_promotions = l_money_sum3b
      END IF
      #150623-00013#5 Modify By Ken 150804(E)
      
      LET l_ac = 1
      
      CALL l_stff.clear()

      #起始金額與截止金額的基準
      FOREACH astp506_cs7 USING l_stfa.stfa001,l_stfa.stfc002,l_stfa.stfe002,l_stfa.stfeseq
         INTO l_stff[l_ac].stfe005,l_stff[l_ac].stff006,l_stff[l_ac].stff007,l_stff[l_ac].stff008,
              l_stff[l_ac].stff010,l_stff[l_ac].stff011,l_stff[l_ac].amount

         #Add By baogc 20151029 Begin ---
         #金额范围维度需扣除不参与保底的天数
         LET l_stff[l_ac].stff006 = l_stff[l_ac].stff006/l_date_s*(l_date_s-l_date_c)
         LET l_stff[l_ac].stff007 = l_stff[l_ac].stff007/l_date_s*(l_date_s-l_date_c)
         #Add By baogc 20151029 End   ---

         LET l_ac = l_ac + 1
      END FOREACH
      
      LET l_ac = l_ac - 1
      
      CALL l_stff.deleteElement(l_ac+1)      
      
      IF l_ac > 0 THEN
         CASE l_stff[1].stfe005 #分量扣点方式
            WHEN '2'            #分段变异
              #Mark By baogc 20151027 Begin ---
              #FOR l_i = l_stff.getLength() TO 1 STEP -1
              #   IF l_money_sum >= l_stff[l_i].stff006 AND l_money_sum <= l_stff[l_i].stff007 THEN
              #      LET l_stff[l_i].amount = (l_money_sum - l_stff[l_i].stff006) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
              #      CASE l_stff[l_i].stff010 
              #         WHEN '2'
              #            LET l_stff[l_i].amount = l_stff[l_i].stff011
              #         WHEN '3'
              #            IF l_stff[l_i].amount > l_stff[l_i].stff011 THEN
              #               LET l_stff[l_i].amount = l_stff[l_i].stff011
              #            END IF
              #      END CASE
              #      IF l_i > 1 THEN
              #        LET l_money_sum = l_stff[l_i-1].stff007
              #      ELSE
              #        LET l_money_sum = 0
              #      END IF                  
              #   END IF                
              #END FOR  
              #Mark By baogc 20151027 End   ---
              #Add  By baogc 20151027 Begin ---
              #举例说明扣点返利计算方式
              #库区扣点：20%
              #返利扣点：20000  ~ 50000    18%
              #         50000  ~ 100000   16%
              #         100000 ~ 99999999 15%  #注：范围为已扣除不参与保底天数的范围
              #全额返利：
              #  分析一：
              #    总销售额（排除不参与）：110000
              #    满足第三档，因此：
              #       全程变异时：返利额 = 110000*(20-15)/100
              #       分段变异时：返利额 = (110000-100000)*(20-15)/100 + (100000-50000)*(20-16)/100 + (50000-20000)*(20-15)/100
              #  分析二：
              #    总销售额（排除不参与）：90000
              #    满足第二档，因此：
              #       全程变异时：返利额 = 90000*(20-16)/100
              #       分段变异时：返利额 = (90000-50000)*(20-16)/100 + (50000-20000)*(20-15)/100
              #  同理其他分析情况
              #
              #差额返利：
              #  分析三：
              #    总销售额（排除不参与）：110000 促销额（排除不参与）：105000
              #    满足第三档，且促销额105000>100000，因此：
              #        全程变异时：返利额 = (110000-105000)*(20-15)/100
              #        分段变异时：返利额 = (110000-105000)*(20-15)/100
              #  分析四：
              #    总销售额（排除不参与）：110000 促销额（排除不参与）：90000
              #    满足第三档，且促销额100000>90000>50000，因此：
              #        全程变异时：返利额 = (110000-100000)*(20-15)/100
              #        分段变异时：返利额 = (110000-100000)*(20-15)/100 + (100000-90000)*(20-16)/100
              #  分析五：
              #    总销售额（排除不参与）：90000 促销额（排除不参与）：70000
              #    满足第二档，且促销额100000>70000>50000，因此：
              #        全程变异时：返利额 = (90000-70000)*(20-16)/100
              #        分段变异时：返利额 = (90000-70000)*(20-16)/100
              #  同理其他分析情况
               CASE l_para_rebates #目标销售返利方式 
                  WHEN '1'         #1.全额返利 
                     FOR l_i = l_stff.getLength() TO 1 STEP -1
                        #判断总销售额位于哪一区间
                        IF l_money_sum > l_stff[l_i].stff006 AND l_money_sum <= l_stff[l_i].stff007 THEN
                           LET l_stff[l_i].amount = (l_money_sum - l_stff[l_i].stff006) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                           CASE l_stff[l_i].stff010  #执行方式
                              WHEN '2'               #执行金额
                                 LET l_stff[l_i].amount = l_stff[l_i].stff011
                              WHEN '3'               #两者取高
                                 IF l_stff[l_i].amount < l_stff[l_i].stff011 THEN
                                    LET l_stff[l_i].amount = l_stff[l_i].stff011
                                 END IF
                           END CASE
                           IF l_i > 1 THEN
                             LET l_money_sum = l_stff[l_i-1].stff007
                           ELSE
                             LET l_money_sum = 0
                           END IF                  
                        END IF                
                     END FOR
                  WHEN '2'        #2.差额返利 (促销费用不计算)
                     FOR l_i = l_stff.getLength() TO 1 STEP -1
                        #判断总销售额位于哪一区间
                        IF l_money_sum > l_stff[l_i].stff006 AND l_money_sum <= l_stff[l_i].stff007 THEN
                           #若促销销售额也在此区间,则按照总销售额与促销销售额的差额算返利
                           IF l_money_promotions > l_stff[l_i].stff006 THEN
                              LET l_stff[l_i].amount = (l_money_sum - l_money_promotions) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                              CASE l_stff[l_i].stff010  #执行方式
                                 WHEN '2'               #执行金额
                                    LET l_stff[l_i].amount = l_stff[l_i].stff011
                                 WHEN '3'               #两者取高
                                    IF l_stff[l_i].amount < l_stff[l_i].stff011 THEN
                                       LET l_stff[l_i].amount = l_stff[l_i].stff011
                                    END IF
                              END CASE
                              EXIT FOR #促销销售额不计算返利
                           ELSE
                              LET l_stff[l_i].amount = (l_money_sum - l_stff[l_i].stff006) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                              CASE l_stff[l_i].stff010  #执行方式
                                 WHEN '2'               #执行金额
                                    LET l_stff[l_i].amount = l_stff[l_i].stff011
                                 WHEN '3'               #两者取高
                                    IF l_stff[l_i].amount < l_stff[l_i].stff011 THEN
                                       LET l_stff[l_i].amount = l_stff[l_i].stff011
                                    END IF
                              END CASE
                              IF l_i > 1 THEN
                                 LET l_money_sum = l_stff[l_i-1].stff007
                              ELSE
                                 LET l_money_sum = 0
                              END IF   
                           END IF
                        END IF                
                     END FOR
               END CASE
              #Add  By baogc 20151027 End   ---
            WHEN '3'            #全程变异
               FOR l_i = l_stff.getLength() TO 1 STEP -1
                  IF l_money_sum >= l_stff[l_i].stff006 AND l_money_sum <= l_stff[l_i].stff007 THEN
                     CASE l_para_rebates
                        WHEN '1'
                           LET l_stff[l_i].amount = l_money_sum * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                        WHEN '2'
                           IF l_stff[l_i].stff006 >= l_money_promotions THEN
                              LET l_stff[l_i].amount = ( l_money_sum - l_stff[l_i].stff006 ) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                           ELSE
                              LET l_stff[l_i].amount = ( l_money_sum - l_money_promotions ) * (l_stfa.stfc018 - l_stff[l_i].stff008) / 100
                           END IF
                     END CASE
                     
                     CASE l_stff[l_i].stff010 
                        WHEN '2'
                           LET l_stff[l_i].amount = l_stff[l_i].stff011
                        WHEN '3'
                           IF l_stff[l_i].amount > l_stff[l_i].stff011 THEN
                              LET l_stff[l_i].amount = l_stff[l_i].stff011
                           END IF
                     END CASE                  
                  END IF
               END FOR                     
         END CASE
         
         LET l_amount = 0 
         FOR l_i = 1 TO l_stff.getLength()
            IF cl_null(l_stff[l_i].amount) THEN LET l_stff[l_i].amount = 0 END IF
            LET l_amount = l_amount + l_stff[l_i].amount         
         END FOR
      ELSE
         #設定的分量扣點 起始與截止金額 設定內容有誤!
         INITIALIZE g_errparam TO NULL
         LET g_errparam.columns[1] = 'lbl_stfa001'
         LET g_errparam.values[1] = l_stfa.stfa001 
         LET g_errparam.columns[2] = 'lbl_stfe002'
         LET g_errparam.values[2] = l_stfa.stfe002
         LET g_errparam.code = 'ast-00308'         
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF      
      
      INITIALIZE l_stga.* TO NULL
      LET l_stga.stgaent  = g_enterprise
      LET l_stga.stgasite = l_stfa.ooef001
      LET l_stga.stgaunit = l_stfa.ooef001 
      LET l_stga.stga001  = l_stfa.stfe009
      LET l_stga.stga002  = ' ' 
      LET l_stga.stga003  = l_stfa.stfc002
      LET l_stga.stga004  = l_stfa.stfa005
      LET l_stga.stga005  = l_stfa.stfa010
      LET l_stga.stga006  = l_stfa.stfe003 
      LET l_stga.stga007  = l_qty 
      LET l_stga.stga008  = 0 
      LET l_stga.stga009  = 0
      LET l_stga.stga010  = l_stfa.stfc018
      LET l_stga.stga011  = l_amount*(-1)
      LET l_stga.stga012  = l_amount 
      LET l_stga.stga013  = '5' 

      
      #根据费用代码从【asti203费用编码维护作业】中带出价款类型，如果取出值是“3-两者”或为空，则赋值为“1-价内”
      SELECT stae006 INTO l_stga.stga014 FROM stae_t
       WHERE staeent = g_enterprise
         AND stae001 = l_stfa.stfe003 
      IF cl_null(l_stga.stga014) OR l_stga.stga014 = '3' THEN
         LET l_stga.stga014 = '1'
      END IF

      LET l_stga.stga015  = 'N' 
      LET l_stga.stgadocno = ' '
      
      LET l_cnt = 0 
      SELECT COUNT(*) INTO l_cnt FROM stga_t
       WHERE stgaent = g_enterprise
         AND stgasite = l_stga.stgasite   AND stga001 = l_stga.stga001
         AND stga002 = l_stga.stga002     AND stga003 = l_stga.stga003
         AND stga013 = l_stga.stga013     AND stgadocno = l_stga.stgadocno
      IF p_del = 'N' AND l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF
      
      IF l_stga.stga012 = 0 THEN CONTINUE FOREACH END IF
      
      IF cl_null(l_stga.stga017) THEN
         LET l_stga.stga017  = ''     #項次不可讓系統自動預設為0 
      END IF
      
      INSERT INTO stga_t( stgasite, stgaunit, stga001,  stga002, stga003,
                          stga004,  stga005,  stga006,  stga007, stga008,
                          stga009,  stga010,  stga011,  stga012, stga013,
                          stga014,  stga015,  stgadocno,stgaent, stga017)
                  VALUES( l_stga.stgasite, l_stga.stgaunit, l_stga.stga001,  l_stga.stga002, l_stga.stga003,
                          l_stga.stga004,  l_stga.stga005,  l_stga.stga006,  l_stga.stga007, l_stga.stga008,
                          l_stga.stga009,  l_stga.stga010,  l_stga.stga011,  l_stga.stga012, l_stga.stga013,
                          l_stga.stga014,  l_stga.stga015,  l_stga.stgadocno,l_stga.stgaent, l_stga.stga017)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT stga_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF     
      
   END FOREACH
    
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   RETURN r_success
   
END FUNCTION

PRIVATE FUNCTION astp506_create_temp()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_session      LIKE type_t.num10   #For Background Inf.   #160516-00014#42 170111 by lori add
   
   LET r_success = TRUE
   LET l_session = ''                                     #160516-00014#42 170111 by lori add
   
   
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL   #160516-00014#42 170111 by lori add
   DISPLAY "astp504-SessionId: ",l_session                #160516-00014#42 170111 by lori add
    
   IF NOT astp506_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE astp506_temp1(
      ooef001     LIKE ooef_t.ooef001,
      stfa001     LIKE stfa_t.stfa001,
      stfa005     LIKE stfa_t.stfa005,
      stfa010     LIKE stfa_t.stfa010,
      stfcseq     LIKE stfc_t.stfcseq,
      stfc002     LIKE stfc_t.stfc002,
      stfc016     LIKE stfc_t.stfc016,
      stfc018     LIKE stfc_t.stfc018,
      stfe002     LIKE stfe_t.stfe002,
      stfeseq     LIKE stfe_t.stfeseq,
      stfe003     LIKE stfe_t.stfe003,
      stfe008     LIKE stfe_t.stfe008,
      stfe009     LIKE stfe_t.stfe009
      )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create astp506_temp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
      
   RETURN r_success   
   
END FUNCTION

PRIVATE FUNCTION astp506_drop_temp()
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = TRUE

   DROP TABLE astp506_temp1
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop astp506_temp1'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success
END FUNCTION
#將組織範圍內的內容寫到astp506_temp1
PRIVATE FUNCTION astp506_ins_temp1(p_wc,p_date)
   DEFINE p_wc             STRING
   DEFINE p_date           LIKE type_t.dat
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_wc             STRING            #解析出stfasite 條件的字串
   DEFINE l_wc1            STRING
   DEFINE l_str            STRING
   DEFINE l_num            LIKE type_t.num5
   DEFINE l_num2           LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_where          STRING
   DEFINE l_ooef001        LIKE ooef_t.ooef001
   DEFINE l_stfa001        LIKE stfa_t.stfa001
   DEFINE l_stfa005        LIKE stfa_t.stfa005
   DEFINE l_stfa010        LIKE stfa_t.stfa010
   DEFINE l_stfa058        LIKE stfa_t.stfa058   #160516-00014#42 170111 by lori add
   DEFINE l_stfcseq        LIKE stfc_t.stfcseq
   DEFINE l_stfc002        LIKE stfc_t.stfc002
   DEFINE l_stfc016        LIKE stfc_t.stfc016
   DEFINE l_stfc018        LIKE stfc_t.stfc018
   DEFINE l_stfe002        LIKE stfe_t.stfe002
   DEFINE l_stfeseq        LIKE stfe_t.stfeseq
   DEFINE l_stfe003        LIKE stfe_t.stfe003
   DEFINE l_stfe006        LIKE stfe_t.stfe006   #160516-00014#42 170111 by lori add
   DEFINE l_stfe008        LIKE stfe_t.stfe008
   DEFINE l_stfe009        LIKE stfe_t.stfe009
   DEFINE l_sdate          LIKE stfe_t.stfe008
   DEFINE l_edate          LIKE stfe_t.stfe009
   DEFINE l_sdate1         LIKE stfe_t.stfe008
   DEFINE l_edate1         LIKE stfe_t.stfe009
   DEFINE l_errno          LIKE type_t.chr20
   DEFINE l_ooef017        LIKE ooef_t.ooef017
   DEFINE l_ld             LIKE glaa_t.glaald
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_dat            LIKE type_t.dat
   DEFINE l_date           LIKE type_t.dat
   DEFINE l_mon_s          LIKE type_t.num5      #160516-00014#42 170111 by lori add
   DEFINE l_mon_e          LIKE type_t.num5      #160516-00014#42 170111 by lori add
   DEFINE l_stfe008_new    LIKE stfe_t.stfe008   #160516-00014#42 170111 by lori add
   DEFINE l_stfe009_new    LIKE stfe_t.stfe009   #160516-00014#42 170111 by lori add
   
   LET r_success = TRUE
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
            LET l_wc1 = ' 1=1'
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
   LET l_where = cl_replace_str(l_where,'stfasite','ooef001')
   
   LET l_sql = " SELECT UNIQUE ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise,
               "    AND ",l_wc,
               "    AND ",l_where      
               
   PREPARE astp506_cs_prep1 FROM l_sql
   DECLARE astp506_cs1 CURSOR WITH HOLD FOR astp506_cs_prep1
   
   LET l_sql = " SELECT UNIQUE stfa001, stfa005, stfa010, stfcseq, stfc002,",
               "               stfc016, stfc018, stfe002, stfeseq, stfe003,",
               "               stfe006, stfe008, stfe009, stfa058 ",            #160516-00014#42 170111 by lori add:stfe006,stfa058
               "   FROM stfa_t t1,stfc_t,stfe_t t2,stff_t",                     #160516-00014#42 170111 by lori add:stfa_t & stfe_t 增加欄位別名
               "  WHERE stfaent = stfcent AND stfaent = stfeent ",
               "    AND stfa001 = stfc001 AND stfa001 = stfe001 ",
               "    AND stfeent = stffent AND stfe001 = stff001 ",
               "    AND stfe002 = stff002 AND stfeseq = stff003 ",
               "    AND stfc002 = stff005 ",
               "    AND stfaent = ",g_enterprise,
               "    AND stfasite = ? ",
               "    AND ",l_wc1,
               "    AND stfa004 IN ('3','4','5','6') ",
               "    AND stfe005 != '1'",
               "    AND stfc024 = '1'",
               "    AND stfe008 IS NOT NULL AND stfe009 IS NOT NULL",
              #160516-00014#42 170111 by lori mod---(S) 
              #"    AND stfe009 BETWEEN ? AND ? "
               "    AND EXISTS(SELECT 1 FROM (SELECT t4.stfaent,t4.stfasite,t4.stfa005,MAX(t3.stfe009) stfe009 ",
               "                                FROM stfe_t t3,stfa_t t4 ",
               "                               WHERE t3.stfeent = t4.stfaent AND t3.stfe001 = t4.stfa001 ",
               "                                 AND t4.stfa004 IN ('3', '4', '5', '6') ",
               "                                 AND t3.stfe005 != '1' ",
               "                                 AND t3.stfe009 <= ? ",
               "                               GROUP BY t4.stfaent,t4.stfasite,t4.stfa005) s1 ",
               "                WHERE t1.stfaent = s1.stfaent AND t1.stfasite = s1.stfasite ",
               "                  AND t1.stfa005 = s1.stfa005 AND t2.stfe009 = s1.stfe009) "
              #160516-00014#42 170111 by lori mod---(E)   
               
   PREPARE astp506_cs_prep2 FROM l_sql
   DECLARE astp506_cs2 CURSOR WITH HOLD FOR astp506_cs_prep2

   #保留組織資料來源的彈性
   FOREACH astp506_cs1 INTO l_ooef001   
   
      LET l_ooef017 = ''      LET l_errno = ''      LET l_ld = ''      LET l_glaa003 = ''
      CALL s_fin_orga_get_comp_ld(l_ooef001) 
       RETURNING l_success,l_errno,l_ooef017,l_ld
      IF NOT l_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = l_errno
         LET g_errparam.extend = l_ooef001
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      
      IF cl_null(l_ld) THEN
         #此營運組織歸屬的法人尚未設定主帳套的資料,無法進行此批次作業
         INITIALIZE g_errparam TO NULL
         LET g_errparam.columns[1] = 'lbl_ooef001'
         LET g_errparam.values[1] = l_ooef001
         LET g_errparam.columns[2] = 'lbl_ooef017'
         LET g_errparam.values[2] = l_ooef017
         LET g_errparam.code = 'ast-00331'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = l_ld
      IF cl_null(l_glaa003) THEN
         #此營運組織歸屬的法人尚未設定會計週期參照表資料,無法進行此批次作業
         INITIALIZE g_errparam TO NULL
         LET g_errparam.columns[1] = 'lbl_ooef001'
         LET g_errparam.values[1] = l_ooef001
         LET g_errparam.columns[2] = 'lbl_ooef017'
         LET g_errparam.values[2] = l_ooef017
         LET g_errparam.columns[3] = 'lbl_glaald'
         LET g_errparam.values[3] = l_ld
         LET g_errparam.code = 'ast-00332'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF
      
      CALL astp506_get_accdate(l_glaa003,p_date) RETURNING l_success,l_sdate,l_edate
      IF NOT l_success THEN
         LET r_success = FALSE
         RETURN r_success
      END IF     
      
      #第一階段,今年符合的資料
     #FOREACH astp506_cs2 USING l_ooef001,l_sdate,l_edate                                 #160516-00014#42 170111 by lori mark
      FOREACH astp506_cs2 USING l_ooef001,l_edate                                         #160516-00014#42 170111 by lori add
                           INTO l_stfa001, l_stfa005, l_stfa010, l_stfcseq, l_stfc002, 
                                l_stfc016, l_stfc018, l_stfe002, l_stfeseq, l_stfe003, 
                                l_stfe006, l_stfe008, l_stfe009, l_stfa058                #160516-00014#42 170111 by lori add:stfe006,stfa058

         IF cl_null(l_stfc016) THEN
            #庫區設定中的計算基準為空,不列入此次產生範圍中
            INITIALIZE g_errparam TO NULL
            LET g_errparam.columns[1] = 'lbl_stfa001'
            LET g_errparam.values[1] = l_stfa001 
            LET g_errparam.columns[2] = 'lbl_stfc002'
            LET g_errparam.values[2] = l_stfc002 
            LET g_errparam.code = 'ast-00309'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF   
         
         IF cl_null(l_stfc018) THEN
            #庫區設定中的費用比率為空,不列入此次產生範圍中
            INITIALIZE g_errparam TO NULL
            LET g_errparam.columns[1] = 'lbl_stfa001'
            LET g_errparam.values[1] = l_stfa001 
            LET g_errparam.columns[2] = 'lbl_stfc002'
            LET g_errparam.values[2] = l_stfc002 
            LET g_errparam.code = 'ast-00310'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
         END IF   
         
         IF NOT r_success THEN
            CONTINUE FOREACH
         END IF
         
         #160516-00014#42 170111 by lori add---(S)
         IF l_stfa058 = 'Y' THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "ast-00866"       #專櫃已終止銷售計算，故不結算！
            LET g_errparam.replace[1] = l_stfa005
            LET g_errparam.replace[2] = l_stfa001
            LET g_errparam.popup = TRUE
            CALL cl_err() 

            CONTINUE FOREACH
         ELSE         
            #推算最新保底結算起始日期   
            LET l_mon_s = ''
            LET l_mon_s = (MONTH(l_sdate) - MONTH(l_stfe008)) + ((YEAR(l_sdate) - YEAR(l_stfe008)) *12)
            
            #推算最新保底結算結束日期 
            LET l_mon_e = ''
            LET l_mon_e = (MONTH(l_sdate) - MONTH(l_stfe009)) + ((YEAR(l_sdate) - YEAR(l_stfe009)) *12)
            
            LET l_stfe008_new = ''
            LET l_stfe009_new = ''
            
            CASE l_stfe006
               WHEN '1'   #月
                  SELECT ADD_MONTHS(l_stfe008,l_mon_s) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,l_mon_e) INTO l_stfe009_new FROM DUAL
               WHEN '2'   #季
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/4)*4) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/4)*4) INTO l_stfe009_new FROM DUAL
               WHEN '3'   #半年
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/6)*6) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/6)*6) INTO l_stfe009_new FROM DUAL               
               WHEN '4'   #年
                  SELECT ADD_MONTHS(l_stfe008,CEIL(l_mon_s/12)*12) INTO l_stfe008_new FROM DUAL
                  SELECT ADD_MONTHS(l_stfe009,CEIL(l_mon_e/12)*12) INTO l_stfe009_new FROM DUAL               
            END CASE
            
            IF l_stfe009_new > l_edate THEN   
               #最新保底結算範圍>結算截止日期,毋須結算
               CONTINUE FOREACH
            ELSE
               LET l_stfe008 = l_stfe008_new
               LET l_stfe009 = l_stfe009_new
            END IF
         END IF            
         #160516-00014#42 170111 by lori add---(E)
         
         INSERT INTO astp506_temp1(ooef001,stfa001,stfa005,stfa010,stfcseq,
                                   stfc002,stfc016,stfc018,stfe002,stfeseq,
                                   stfe003,stfe008,stfe009)
                VALUES(l_ooef001,l_stfa001,l_stfa005,l_stfa010, l_stfcseq,
                       l_stfc002,l_stfc016,l_stfc018,l_stfe002, l_stfeseq,
                       l_stfe003,l_stfe008,l_stfe009)
         IF SQLCA.sqlcode != 0 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'insert astp506_temp1'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF         
      
      END FOREACH
      
      #160516-00014#42 170111 by lori mark---(S)
      #SELECT add_months(l_sdate,-12) INTO l_sdate1 FROM dual
      #SELECT add_months(l_edate,-12) INTO l_edate1 FROM dual      
      #
      ##第二階段,去年同期符合的資料
      #FOREACH astp506_cs2 USING l_ooef001,l_sdate1,l_edate1
      #                     INTO l_stfa001, l_stfa005, l_stfa010, l_stfcseq, l_stfc002, 
      #                          l_stfc016, l_stfc018, l_stfe002, l_stfeseq, l_stfe003, 
      #                          l_stfe008, l_stfe009
      #   SELECT add_months(l_stfe008,12) INTO l_stfe008 FROM dual
      #   SELECT add_months(l_stfe009,12) INTO l_stfe009 FROM dual
      #   
      #   SELECT COUNT(*) INTO l_cnt FROM astp506_temp1
      #    WHERE ooef001 = l_ooef001
      #      AND stfa001 = l_stfa001
      #      AND stfc002 = l_stfc002
      #      AND ( stfe008 BETWEEN l_stfe008 AND l_stfe009 OR
      #            stfe009 BETWEEN l_stfe008 AND l_stfe009)
      #   IF l_cnt > 0 THEN
      #      CONTINUE FOREACH
      #   END IF
      #
      #   IF cl_null(l_stfc016) THEN
      #      #庫區設定中的計算基準為空,不列入此次產生範圍中
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.columns[1] = 'lbl_stfa001'
      #      LET g_errparam.values[1] = l_stfa001 
      #      LET g_errparam.columns[2] = 'lbl_stfc002'
      #      LET g_errparam.values[2] = l_stfc002 
      #      LET g_errparam.code = 'ast-00309'
      #      LET g_errparam.extend = ''
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #   END IF   
      #   
      #   IF cl_null(l_stfc018) THEN
      #      #庫區設定中的費用比率為空,不列入此次產生範圍中
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.columns[1] = 'lbl_stfa001'
      #      LET g_errparam.values[1] = l_stfa001 
      #      LET g_errparam.columns[2] = 'lbl_stfc002'
      #      LET g_errparam.values[2] = l_stfc002 
      #      LET g_errparam.code = 'ast-00310'
      #      LET g_errparam.extend = ''
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #   END IF   
      #   
      #   IF NOT r_success THEN
      #      CONTINUE FOREACH
      #   END IF
      #   
      #   INSERT INTO astp506_temp1(ooef001,stfa001,stfa005,stfa010,stfcseq,
      #                             stfc002,stfc016,stfc018,stfe002,stfeseq,
      #                             stfe003,stfe008,stfe009)
      #          VALUES(l_ooef001,l_stfa001,l_stfa005,l_stfa010, l_stfcseq,
      #                 l_stfc002,l_stfc016,l_stfc018,l_stfe002, l_stfeseq,
      #                 l_stfe003,l_stfe008,l_stfe009)
      #   IF SQLCA.sqlcode != 0 THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = 'insert astp506_temp1 p2'
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #      RETURN r_success
      #   END IF         
      #
      #END FOREACH
      #
      #SELECT add_months(l_sdate,-24) INTO l_sdate1 FROM dual
      #SELECT add_months(l_edate,-24) INTO l_edate1 FROM dual      
      #
      ##第三階段,前年同期符合的資料
      #FOREACH astp506_cs2 USING l_ooef001,l_sdate1,l_edate1
      #                     INTO l_stfa001, l_stfa005, l_stfa010, l_stfcseq, l_stfc002, 
      #                          l_stfc016, l_stfc018, l_stfe002, l_stfeseq, l_stfe003, 
      #                          l_stfe008, l_stfe009
      #   SELECT add_months(l_stfe008,24) INTO l_stfe008 FROM dual
      #   SELECT add_months(l_stfe009,24) INTO l_stfe009 FROM dual
      #   
      #   SELECT COUNT(*) INTO l_cnt FROM astp506_temp1
      #    WHERE ooef001 = l_ooef001
      #      AND stfa001 = l_stfa001
      #      AND stfc002 = l_stfc002
      #      AND ( sdate BETWEEN l_stfe008 AND l_stfe009 OR
      #            edate BETWEEN l_stfe009 AND l_stfe009)
      #   IF l_cnt > 0 THEN
      #      CONTINUE FOREACH
      #   END IF
      #
      #   IF cl_null(l_stfc016) THEN
      #      #庫區設定中的計算基準為空,不列入此次產生範圍中
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.columns[1] = 'lbl_stfa001'
      #      LET g_errparam.values[1] = l_stfa001 
      #      LET g_errparam.columns[2] = 'lbl_stfc002'
      #      LET g_errparam.values[2] = l_stfc002 
      #      LET g_errparam.code = 'ast-00309'
      #      LET g_errparam.extend = ''
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #   END IF   
      #   
      #   IF cl_null(l_stfc018) THEN
      #      #庫區設定中的費用比率為空,不列入此次產生範圍中
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.columns[1] = 'lbl_stfa001'
      #      LET g_errparam.values[1] = l_stfa001 
      #      LET g_errparam.columns[2] = 'lbl_stfc002'
      #      LET g_errparam.values[2] = l_stfc002 
      #      LET g_errparam.code = 'ast-00310'
      #      LET g_errparam.extend = ''
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #   END IF   
      #   
      #   IF NOT r_success THEN
      #      CONTINUE FOREACH
      #   END IF
      #   
      #   INSERT INTO astp506_temp1(ooef001,stfa001,stfa005,stfa010,stfcseq,
      #                             stfc002,stfc016,stfc018,stfe002,stfeseq,
      #                             stfe003,stfe008,stfe009)
      #          VALUES(l_ooef001,l_stfa001,l_stfa005,l_stfa010, l_stfcseq,
      #                 l_stfc002,l_stfc016,l_stfc018,l_stfe002, l_stfeseq,
      #                 l_stfe003,l_stfe008,l_stfe009)
      #   IF SQLCA.sqlcode != 0 THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code = SQLCA.sqlcode
      #      LET g_errparam.extend = 'insert astp506_temp1 p3'
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      LET r_success = FALSE
      #      RETURN r_success
      #   END IF         
      #
      #END FOREACH
      #
      ##找完兩年的資料後,就不找了
      #160516-00014#42 170111 by lori mark---(E)
   END FOREACH   
   
   RETURN r_success
END FUNCTION
#用會計週期參照表取出上一個會計期間
PRIVATE FUNCTION astp506_get_accdate(p_glaa003,p_date)
   DEFINE p_glaa003            LIKE glaa_t.glaa003
   DEFINE p_date               LIKE type_t.dat
   DEFINE r_success            LIKE type_t.num5
   DEFINE r_pdate_s            LIKE glav_t.glav004
   DEFINE r_pdate_e            LIKE glav_t.glav004
   DEFINE l_flag               LIKE type_t.chr1
   DEFINE l_errno              LIKE type_t.chr100
   DEFINE l_glav002            LIKE glav_t.glav002
   DEFINE l_glav005            LIKE glav_t.glav005
   DEFINE l_sdate_s            LIKE glav_t.glav004
   DEFINE l_sdate_e            LIKE glav_t.glav004
   DEFINE l_glav006            LIKE glav_t.glav006
   DEFINE l_pdate_s            LIKE glav_t.glav004
   DEFINE l_pdate_e            LIKE glav_t.glav004
   DEFINE l_glav007            LIKE glav_t.glav007
   DEFINE l_wdate_s            LIKE glav_t.glav004
   DEFINE l_wdate_e            LIKE glav_t.glav004
   
   LET r_success = TRUE
   LET r_pdate_s = ''
   LET r_pdate_e = ''
   #先取得統計日期的會計期間 起始日
   CALL s_get_accdate(p_glaa003,p_date,'','')
    RETURNING l_flag,l_errno,  l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,
              l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = p_glaa003
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_pdate_s,r_pdate_e
   END IF
   
   #統計日期會計期間 起始日 - 1 再取一次該天的會計期間 即為上一個會計期間
   CALL s_get_accdate(p_glaa003,l_pdate_s-1,'','')
    RETURNING l_flag,l_errno,  l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,
              l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = p_glaa003
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_pdate_s,r_pdate_e
   END IF  

   LET r_pdate_s = l_pdate_s
   LET r_pdate_e = l_pdate_e

   RETURN r_success,r_pdate_s,r_pdate_e
END FUNCTION

################################################################################
# Descriptions...: 取asti202專櫃合約計算基準的包含折扣否欄位
# Memo...........:
# Usage..........: CALL astp506_get_stab010(p_stfc016)
#                  RETURNING r_stab010
# Input parameter: p_stfc016      計算基準
# Return code....: r_stab010      包含拆扣(是:應收Y ;否:實收N)
# Date & Author..: 2015/08/04 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION astp506_get_stab010(p_stfc016)
DEFINE p_stfc016           LIKE stfc_t.stfc016
DEFINE l_stab010           LIKE stab_t.stab010
DEFINE r_stab010           LIKE stab_t.stab010

  LET l_stab010 = ''
  LET r_stab010 = ''

  SELECT stab010 INTO l_stab010
    FROM stab_t 
   WHERE stabent = g_enterprise
     AND stab001 = p_stfc016
     AND EXISTS (SELECT 1 FROM stat_t 
                  WHERE stabent = statent 
                    AND stab001 = stat003 
                    AND stat001 = '4')            
     AND stab008 = 'Y' 
     AND stab009 = 'Y' 
     AND stabstus = 'Y'
     
  IF cl_null(l_stab010) OR l_stab010 = 'N' THEN
     LET r_stab010 = 'N'
  ELSE
     LET r_stab010 = 'Y'
  END IF

  RETURN r_stab010

END FUNCTION

#end add-point
 
{</section>}
 
