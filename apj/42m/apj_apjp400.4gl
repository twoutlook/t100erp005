#該程式未解開Section, 採用最新樣板產出!
{<section id="apjp400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-05 10:21:29), PR版次:0001(2017-01-18 10:03:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: apjp400
#+ Description: 項目費用分攤作業
#+ Creator....: 02294(2017-01-05 10:21:29)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="apjp400.global" >}
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
       pjeccomp LIKE type_t.chr10, 
   pjecld LIKE type_t.chr5, 
   pjec002 LIKE type_t.num5, 
   pjec003 LIKE type_t.num5, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
TYPE type_g_wc   RECORD
   pjeccomp    LIKE pjec_t.pjeccomp,
   pjecld      LIKE pjec_t.pjecld
                 END RECORD
DEFINE g_wc1        type_g_wc
DEFINE g_wc_comp     STRING
DEFINE g_wc_pjeccomp STRING
DEFINE g_wc_pjecld   STRING
DEFINE g_wc_pjebcomp STRING
DEFINE g_wc_pjebld   STRING
DEFINE g_bdate       LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE g_edate       LIKE glav_t.glav004
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="apjp400.main" >}
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
   CALL cl_ap_init("apj","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_axc_get_authcomp() RETURNING g_wc_comp 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL apjp400_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apjp400 WITH FORM cl_ap_formpath("apj",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apjp400_init()
 
      #進入選單 Menu (="N")
      CALL apjp400_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apjp400
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apjp400.init" >}
#+ 初始化作業
PRIVATE FUNCTION apjp400_init()
 
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
 
{<section id="apjp400.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apjp400_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_xcbk001 LIKE xcbk_t.xcbk001
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.pjec002,g_master.pjec003 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec002
            #add-point:BEFORE FIELD pjec002 name="input.b.pjec002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec002
            
            #add-point:AFTER FIELD pjec002 name="input.a.pjec002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec002
            #add-point:ON CHANGE pjec002 name="input.g.pjec002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjec003
            #add-point:BEFORE FIELD pjec003 name="input.b.pjec003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjec003
            
            #add-point:AFTER FIELD pjec003 name="input.a.pjec003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pjec003
            #add-point:ON CHANGE pjec003 name="input.g.pjec003"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.pjec002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec002
            #add-point:ON ACTION controlp INFIELD pjec002 name="input.c.pjec002"
            
            #END add-point
 
 
         #Ctrlp:input.c.pjec003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjec003
            #add-point:ON ACTION controlp INFIELD pjec003 name="input.c.pjec003"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pjeccomp,pjecld
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pjeccomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjeccomp
            #add-point:ON ACTION controlp INFIELD pjeccomp name="construct.c.pjeccomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #增加法人過濾條件
            IF NOT cl_null(g_wc_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_comp
            END IF
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjeccomp  #顯示到畫面上
            NEXT FIELD pjeccomp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjeccomp
            #add-point:BEFORE FIELD pjeccomp name="construct.b.pjeccomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjeccomp
            
            #add-point:AFTER FIELD pjeccomp name="construct.a.pjeccomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pjecld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pjecld
            #add-point:ON ACTION controlp INFIELD pjecld name="construct.c.pjecld"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept 
            CALL q_authorised_ld()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pjecld  #顯示到畫面上
            NEXT FIELD pjecld                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pjecld
            #add-point:BEFORE FIELD pjecld name="construct.b.pjecld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pjecld
            
            #add-point:AFTER FIELD pjecld name="construct.a.pjecld"
            
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
            CALL apjp400_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            CALL s_axc_set_site_default() RETURNING g_wc1.pjeccomp,g_wc1.pjecld,g_master.pjec002,g_master.pjec003,l_xcbk001 
            DISPLAY BY NAME g_wc1.pjeccomp,g_wc1.pjecld,g_master.pjec002,g_master.pjec003
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
         CALL apjp400_init()
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
                 CALL apjp400_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apjp400_transfer_argv(ls_js)
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
 
{<section id="apjp400.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apjp400_transfer_argv(ls_js)
 
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
 
{<section id="apjp400.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apjp400_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   
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
      CALL cl_progress_bar_no_window(2)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apjp400_process_cs CURSOR FROM ls_sql
#  FOREACH apjp400_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL apjp400_p(ls_js)
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','0')
         RETURN
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL apjp400_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="apjp400.get_buffer" >}
PRIVATE FUNCTION apjp400_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pjec002 = p_dialog.getFieldBuffer('pjec002')
   LET g_master.pjec003 = p_dialog.getFieldBuffer('pjec003')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apjp400.msgcentre_notify" >}
PRIVATE FUNCTION apjp400_msgcentre_notify()
 
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
 
{<section id="apjp400.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#批处理逻辑
#161109-00032#12
PRIVATE FUNCTION apjp400_p(ls_js)
DEFINE lc_param    type_parameter
DEFINE ls_js          STRING
DEFINE l_string       STRING 
DEFINE tok            base.stringtokenizer
DEFINE l_glaa003      LIKE glaa_t.glaa003
DEFINE l_pjeb200      LIKE pjeb_t.pjeb200
DEFINE l_pjeb300      LIKE pjeb_t.pjeb300
DEFINE l_pjeb310      LIKE pjeb_t.pjeb310
DEFINE l_pjeb320      LIKE pjeb_t.pjeb320
DEFINE l_success      LIKE type_t.num5
DEFINE l_curr         LIKE glaa_t.glaa001
DEFINE l_max_amt      LIKE xcck_t.xcck202
DEFINE l_cnt          LIKE type_t.num5
DEFINE l_flag         LIKE type_t.chr1
DEFINE l_sum_pjec100  LIKE pjec_t.pjec100
DEFINE l_sum_pjec110  LIKE pjec_t.pjec110
DEFINE l_sum_pjec120  LIKE pjec_t.pjec120

DEFINE l_pjec   RECORD  #項目費用分攤明細檔
       pjecent LIKE pjec_t.pjecent, #企业编号
       pjeccomp LIKE pjec_t.pjeccomp, #法人组织
       pjecld LIKE pjec_t.pjecld, #账套
       pjec002 LIKE pjec_t.pjec002, #年度
       pjec003 LIKE pjec_t.pjec003, #期别
       pjecseq LIKE pjec_t.pjecseq, #项次
       pjec004 LIKE pjec_t.pjec004, #项目编号
       pjec005 LIKE pjec_t.pjec005, #WBS编号
       pjec010 LIKE pjec_t.pjec010, #科目编号
       pjec011 LIKE pjec_t.pjec011, #营运组织
       pjec012 LIKE pjec_t.pjec012, #部门
       pjec013 LIKE pjec_t.pjec013, #交易对象
       pjec014 LIKE pjec_t.pjec014, #客群
       pjec015 LIKE pjec_t.pjec015, #区域
       pjec016 LIKE pjec_t.pjec016, #成本中心
       pjec017 LIKE pjec_t.pjec017, #经营类别
       pjec018 LIKE pjec_t.pjec018, #渠道
       pjec019 LIKE pjec_t.pjec019, #品类
       pjec020 LIKE pjec_t.pjec020, #品牌
       pjec021 LIKE pjec_t.pjec021, #项目编号（核算项）
       pjec022 LIKE pjec_t.pjec022, #WBS（核算项）
       pjec099 LIKE pjec_t.pjec099, #项目工时
       pjec100 LIKE pjec_t.pjec100, #分摊金额
       pjec110 LIKE pjec_t.pjec110, #分摊金额(本位币二)
       pjec120 LIKE pjec_t.pjec120, #分摊金额(本位币三)
       pjec200 LIKE pjec_t.pjec200, #分摊基数
       pjec300 LIKE pjec_t.pjec300, #分摊单价
       pjec310 LIKE pjec_t.pjec310, #分摊单价(本位币二)
       pjec320 LIKE pjec_t.pjec320, #分摊单价(本位币三)
       pjecownid LIKE pjec_t.pjecownid, #资料所有者
       pjecowndp LIKE pjec_t.pjecowndp, #资料所属部门
       pjeccrtid LIKE pjec_t.pjeccrtid, #资料建立者
       pjeccrtdp LIKE pjec_t.pjeccrtdp, #资料建立部门
       pjeccrtdt LIKE pjec_t.pjeccrtdt, #资料创建日
       pjecmodid LIKE pjec_t.pjecmodid, #资料修改者
       pjecmoddt LIKE pjec_t.pjecmoddt, #最近修改日
       pjecstus LIKE pjec_t.pjecstus #状态码
              END RECORD
DEFINE l_pjeb RECORD  #項目費用收集維護檔
       pjebent LIKE pjeb_t.pjebent, #企业编号
       pjebcomp LIKE pjeb_t.pjebcomp, #法人组织
       pjebld LIKE pjeb_t.pjebld, #账套
       pjeb002 LIKE pjeb_t.pjeb002, #年度
       pjeb003 LIKE pjeb_t.pjeb003, #期别
       pjebseq LIKE pjeb_t.pjebseq, #项次
       pjeb010 LIKE pjeb_t.pjeb010, #科目编号
       pjeb011 LIKE pjeb_t.pjeb011, #营运组织
       pjeb012 LIKE pjeb_t.pjeb012, #部门
       pjeb013 LIKE pjeb_t.pjeb013, #交易对象
       pjeb014 LIKE pjeb_t.pjeb014, #客群
       pjeb015 LIKE pjeb_t.pjeb015, #区域
       pjeb016 LIKE pjeb_t.pjeb016, #成本中心
       pjeb017 LIKE pjeb_t.pjeb017, #经营类别
       pjeb018 LIKE pjeb_t.pjeb018, #渠道
       pjeb019 LIKE pjeb_t.pjeb019, #品类
       pjeb020 LIKE pjeb_t.pjeb020, #品牌
       pjeb021 LIKE pjeb_t.pjeb021, #项目编号(核算项)
       pjeb022 LIKE pjeb_t.pjeb022, #WBS(核算项)
       pjeb100 LIKE pjeb_t.pjeb100, #分摊金额
       pjeb110 LIKE pjeb_t.pjeb110, #分摊金额(本位币二)
       pjeb120 LIKE pjeb_t.pjeb120, #分摊金额(本位币三)
       pjeb200 LIKE pjeb_t.pjeb200, #分摊基数
       pjeb300 LIKE pjeb_t.pjeb300, #分摊单价
       pjeb310 LIKE pjeb_t.pjeb310, #分摊单价(本位币二)
       pjeb320 LIKE pjeb_t.pjeb320, #分摊单价(本位币三)
       pjebownid LIKE pjeb_t.pjebownid, #资料所有者
       pjebowndp LIKE pjeb_t.pjebowndp, #资料所属部门
       pjebcrtid LIKE pjeb_t.pjebcrtid, #资料录入者
       pjebcrtdp LIKE pjeb_t.pjebcrtdp, #资料录入部门
       pjebcrtdt LIKE pjeb_t.pjebcrtdt, #资料创建日
       pjebmodid LIKE pjeb_t.pjebmodid, #资料更改者
       pjebmoddt LIKE pjeb_t.pjebmoddt, #最近更改日
       pjebstus LIKE pjeb_t.pjebstus, #状态码
       pjebud001 LIKE pjeb_t.pjebud001, #自定义字段(文本)001
       pjebud002 LIKE pjeb_t.pjebud002, #自定义字段(文本)002
       pjebud003 LIKE pjeb_t.pjebud003, #自定义字段(文本)003
       pjebud004 LIKE pjeb_t.pjebud004, #自定义字段(文本)004
       pjebud005 LIKE pjeb_t.pjebud005, #自定义字段(文本)005
       pjebud006 LIKE pjeb_t.pjebud006, #自定义字段(文本)006
       pjebud007 LIKE pjeb_t.pjebud007, #自定义字段(文本)007
       pjebud008 LIKE pjeb_t.pjebud008, #自定义字段(文本)008
       pjebud009 LIKE pjeb_t.pjebud009, #自定义字段(文本)009
       pjebud010 LIKE pjeb_t.pjebud010, #自定义字段(文本)010
       pjebud011 LIKE pjeb_t.pjebud011, #自定义字段(数字)011
       pjebud012 LIKE pjeb_t.pjebud012, #自定义字段(数字)012
       pjebud013 LIKE pjeb_t.pjebud013, #自定义字段(数字)013
       pjebud014 LIKE pjeb_t.pjebud014, #自定义字段(数字)014
       pjebud015 LIKE pjeb_t.pjebud015, #自定义字段(数字)015
       pjebud016 LIKE pjeb_t.pjebud016, #自定义字段(数字)016
       pjebud017 LIKE pjeb_t.pjebud017, #自定义字段(数字)017
       pjebud018 LIKE pjeb_t.pjebud018, #自定义字段(数字)018
       pjebud019 LIKE pjeb_t.pjebud019, #自定义字段(数字)019
       pjebud020 LIKE pjeb_t.pjebud020, #自定义字段(数字)020
       pjebud021 LIKE pjeb_t.pjebud021, #自定义字段(日期时间)021
       pjebud022 LIKE pjeb_t.pjebud022, #自定义字段(日期时间)022
       pjebud023 LIKE pjeb_t.pjebud023, #自定义字段(日期时间)023
       pjebud024 LIKE pjeb_t.pjebud024, #自定义字段(日期时间)024
       pjebud025 LIKE pjeb_t.pjebud025, #自定义字段(日期时间)025
       pjebud026 LIKE pjeb_t.pjebud026, #自定义字段(日期时间)026
       pjebud027 LIKE pjeb_t.pjebud027, #自定义字段(日期时间)027
       pjebud028 LIKE pjeb_t.pjebud028, #自定义字段(日期时间)028
       pjebud029 LIKE pjeb_t.pjebud029, #自定义字段(日期时间)029
       pjebud030 LIKE pjeb_t.pjebud030  #自定义字段(日期时间)030
          END RECORD

   CALL util.JSON.parse(ls_js,lc_param)

   CALL s_transaction_begin()
   LET g_success = 'Y'
   
   #從wc中分別截取pjeccomp,pjecld的查詢條件
   IF NOT cl_null(g_master.wc) OR g_master.wc != " 1=1" THEN 
      LET g_wc = g_master.wc
      LET g_wc = cl_replace_str(g_wc,"and","||")
      LET tok = base.StringTokenizer.create(g_wc,"||")
      WHILE tok.hasMoreTokens()
         LET l_string = tok.nextToken()
         LET l_string = l_string.trim()
         IF l_string MATCHES '*pjeccomp*' THEN
            LET g_wc_pjeccomp = l_string     
         END IF
         IF l_string MATCHES '*pjecld*' THEN
            LET g_wc_pjecld = l_string
         END IF
      END WHILE
   END IF   
   
   IF cl_null(g_wc_pjeccomp) THEN 
      LET g_wc_pjeccomp = "1=1"
   END IF
   
   IF cl_null(g_wc_pjecld) THEN 
      LET g_wc_pjecld = "1=1"
   END IF

   LET l_cnt = 0
   LET g_sql = "SELECT COUNT(1) FROM pjec_t ",
               " WHERE pjecent = ",g_enterprise,
               "   AND pjec002 = '",g_master.pjec002,"'",
               "   AND pjec003 = '",g_master.pjec003,"'",
               "   AND ",g_wc_pjecld,
               "   AND ",g_wc_pjeccomp
   
   PREPARE axcp202_sel_pjec_pre FROM g_sql 
   EXECUTE axcp202_sel_pjec_pre INTO l_cnt 
         
   IF l_cnt > 0 THEN
      IF NOT cl_ask_confirm('asr-00050') THEN   #是否更新 
         LET g_success = 'N'
         RETURN
      END IF
   END IF
   
   #1.根据"账套"、"法人"、"成本年度"、"成本期别"删除“项目费用分摊明细档(pjec_t)”的资料
   LET g_sql = "DELETE FROM pjec_t ",
               " WHERE pjecent = ",g_enterprise,
               "   AND pjec002 = '",g_master.pjec002,"'",
               "   AND pjec003 = '",g_master.pjec003,"'",
               "   AND ",g_wc_pjecld,
               "   AND ",g_wc_pjeccomp
   
   PREPARE apjp400_del_pjec_pre FROM g_sql 
   EXECUTE apjp400_del_pjec_pre 
   
   CALL cl_progress_no_window_ing("delete original file")
   
   LET g_wc_pjebld = cl_replace_str(g_wc_pjecld,"pjecld","pjebld")
   LET g_wc_pjebcomp = cl_replace_str(g_wc_pjeccomp,"pjeccomp","pjebcomp")
   
   LET g_sql = "UPDATE pjeb_t SET pjeb200 = 0 ,",
               "                  pjeb300 = 0 ,",
               "                  pjeb310 = 0 ,",
               "                  pjeb320 = 0  ",
               " WHERE pjebent = ",g_enterprise,
               "   AND pjeb002 = '",g_master.pjec002,"'",
               "   AND pjeb003 = '",g_master.pjec003,"'",
               "   AND ",g_wc_pjebld,
               "   AND ",g_wc_pjebcomp
   
   PREPARE apjp400_upd_pjeb_pre FROM g_sql 
   EXECUTE apjp400_upd_pjeb_pre 
   
   #依法人、账套、年度、期别更新pjeb_t中分摊基数、分摊单价、分摊单价（本位币二）、分摊单价（本位币三）
   LET g_sql = "SELECT pjebent,pjebcomp,pjebld,pjeb002,pjeb003,pjebseq,pjeb010,pjeb011,pjeb012,pjeb013,",
               "       pjeb014,pjeb015,pjeb016,pjeb017,pjeb018,pjeb019,pjeb020,pjeb021,pjeb022,pjeb100,",
               "       pjeb110,pjeb120,pjeb200,pjeb300,pjeb310,pjeb320,pjebownid,pjebowndp,pjebcrtid,  ",
               "       pjebcrtdp,pjebcrtdt,pjebmodid,pjebmoddt,pjebstus,pjebud001,pjebud002,pjebud003, ",
               "       pjebud004,pjebud005,pjebud006,pjebud007,pjebud008,pjebud009,pjebud010,pjebud011,",
               "       pjebud012,pjebud013,pjebud014,pjebud015,pjebud016,pjebud017,pjebud018,pjebud019,",
               "       pjebud020,pjebud021,pjebud022,pjebud023,pjebud024,pjebud025,pjebud026,pjebud027,",
               "       pjebud028,pjebud029,pjebud030 FROM pjeb_t ", 
               " WHERE pjebent = ",g_enterprise,
               "   AND pjeb002 = '",g_master.pjec002,"'",
               "   AND pjeb003 = '",g_master.pjec003,"'",
               "   AND ",g_wc_pjebld,
               "   AND ",g_wc_pjebcomp
   PREPARE apjp400_pjeb_pre FROM g_sql
   DECLARE apjp400_pjeb_cur CURSOR FOR apjp400_pjeb_pre
   
   LET g_sql = " SELECT pjby004,pjby005,SUM(pjby201) FROM pjby_t ",
               "    WHERE pjbyent = ? AND pjbycomp = ? AND pjby001 <= ? AND pjby001 >= ? ",
               "  GROUP BY pjby004,pjby005 "

   PREPARE apjp400_pjby_pre FROM g_sql
   DECLARE apjp400_pjby_cur CURSOR FOR apjp400_pjby_pre
   
   CALL cl_err_collect_init()
   LET l_flag = 'N'
   INITIALIZE l_pjec.* TO NULL
   
   FOREACH apjp400_pjeb_cur INTO l_pjeb.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF 
      CALL apjp400_date_chk(l_pjeb.pjebcomp,g_master.pjec002,g_master.pjec003)
      IF NOT cl_null(g_errno) THEN
         LET g_errparam.extend = g_master.pjec002
         LET g_errparam.code   = g_errno
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         CONTINUE FOREACH                      
      END IF

    
      SELECT glaa003 INTO l_glaa003 FROM glaa_t
        WHERE glaaent = g_enterprise AND glaa014 = 'Y'
          AND glaacomp = l_pjeb.pjebcomp 
      IF NOT cl_null(l_glaa003) AND NOT cl_null(g_master.pjec002) AND NOT cl_null(g_master.pjec003) THEN
         CALL s_fin_date_get_period_range(l_glaa003, g_master.pjec002,g_master.pjec003)
             RETURNING g_bdate,g_edate               
      END IF 
      
      #分摊基数=SUM(apjt300中日期pjby001在当前期别范围内所有项目的工时pjby201)   ——（目前是规划所有项目都采用同一套分摊科目，所以抓所有项目工时做为分摊基数，
      #分摊单价=分摊金额/分摊基数
      #分摊单价（本位币二）=分摊金额（本位币二）/分摊基数
      #分摊单价（本位币三）=分摊金额（本位币三）/分摊基数 
      SELECT SUM(pjby201) INTO l_pjeb200 FROM pjby_t
          WHERE pjbyent = g_enterprise AND pjbycomp = l_pjeb.pjebcomp AND pjby001 <= g_edate AND pjby001 >= g_bdate
      IF cl_null(l_pjeb200) THEN
         LET l_pjeb200 = 1
      END IF       
      
      IF cl_null(l_pjeb.pjeb100) THEN
         LET l_pjeb.pjeb100 = 0
      END IF
      IF cl_null(l_pjeb.pjeb110) THEN
         LET l_pjeb.pjeb110 = 0
      END IF
      IF cl_null(l_pjeb.pjeb120) THEN
         LET l_pjeb.pjeb120 = 0
      END IF
      
      LET l_pjeb300 = l_pjeb.pjeb100 / l_pjeb200
      LET l_pjeb310 = l_pjeb.pjeb110 / l_pjeb200
      LET l_pjeb320 = l_pjeb.pjeb120 / l_pjeb200
      
      CALL s_ld_sel_glaa(l_pjeb.pjebld,'glaa001') RETURNING l_success,l_curr
      
      IF NOT cl_null(l_curr) THEN
         LET l_pjeb300 = s_curr_round(l_pjeb.pjebcomp,l_curr,l_pjeb300,'1')
         LET l_pjeb310 = s_curr_round(l_pjeb.pjebcomp,l_curr,l_pjeb310,'1')
         LET l_pjeb320 = s_curr_round(l_pjeb.pjebcomp,l_curr,l_pjeb320,'1')
      END IF
      
      UPDATE pjeb_t SET pjeb200 = l_pjeb200,
                        pjeb300 = l_pjeb300,
                        pjeb310 = l_pjeb310,
                        pjeb320 = l_pjeb320 
          WHERE pjebent = g_enterprise
            AND pjeb002 = g_master.pjec002
            AND pjeb003 = g_master.pjec003
            AND pjebld = l_pjeb.pjebld
            AND pjebseq = l_pjeb.pjebseq
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "upd pjeb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
       
         LET g_success = 'N'                        
      END IF
      LET l_flag = 'Y'  

      #依法人、账套、年度、期别产生pjec_t  （关联pjby_t、pjeb_t抓取pjec_t对应栏位即可）
      #    项目编号（pjec004） =pjby004
      #    WBS编号（pjec005）=pjby005
      #    项目工时（pjec099） =依pjby004、pjby005 sum(pjby201) 
      #    分摊金额=（项目工时（pjec099）/分摊基数（pjeb200））*分摊单价（pjeb300）
      #    其他栏位均取对应pjeb_t中相应栏位
      
      LET l_pjec.pjecent = g_enterprise
      LET l_pjec.pjecld = l_pjeb.pjebld
      LET l_pjec.pjeccomp = l_pjeb.pjebcomp
      LET l_pjec.pjec002 = l_pjeb.pjeb002
      LET l_pjec.pjec003 = l_pjeb.pjeb003
      
      LET l_pjec.pjecownid = g_user
      LET l_pjec.pjecowndp = g_dept
      LET l_pjec.pjeccrtid = g_user
      LET l_pjec.pjeccrtdp = g_dept 
      LET l_pjec.pjeccrtdt = cl_get_current()
      LET l_pjec.pjecmodid = g_user
      LET l_pjec.pjecmoddt = g_dept
      LET l_pjec.pjecstus = 'Y'
      
      LET l_pjec.pjec010 = l_pjeb.pjeb010   #科目编号
      LET l_pjec.pjec011 = l_pjeb.pjeb011   #营运组织
      LET l_pjec.pjec012 = l_pjeb.pjeb012   #部门
      LET l_pjec.pjec013 = l_pjeb.pjeb013   #交易对象
      LET l_pjec.pjec014 = l_pjeb.pjeb014   #客群
      LET l_pjec.pjec015 = l_pjeb.pjeb015   #区域
      LET l_pjec.pjec016 = l_pjeb.pjeb016   #成本中心
      LET l_pjec.pjec017 = l_pjeb.pjeb017   #经营类别
      LET l_pjec.pjec018 = l_pjeb.pjeb018   #渠道
      LET l_pjec.pjec019 = l_pjeb.pjeb019   #品类
      LET l_pjec.pjec020 = l_pjeb.pjeb020   #品牌
      LET l_pjec.pjec021 = l_pjeb.pjeb021   #项目编号(核算项)
      LET l_pjec.pjec022 = l_pjeb.pjeb022   #WBS(核算项)
      
      LET l_pjec.pjec200 = l_pjeb200   #分摊基数
      LET l_pjec.pjec300 = l_pjeb300   #分摊单价
      LET l_pjec.pjec310 = l_pjeb310   #分摊单价(本位币二)
      LET l_pjec.pjec320 = l_pjeb320   #分摊单价(本位币三)
      IF cl_null(l_pjec.pjec200) THEN
         LET l_pjec.pjec200 = 0
      END IF
      IF cl_null(l_pjec.pjec300) THEN
         LET l_pjec.pjec300 = 0
      END IF
      IF cl_null(l_pjec.pjec310) THEN
         LET l_pjec.pjec310 = 0
      END IF
      IF cl_null(l_pjec.pjec320) THEN
         LET l_pjec.pjec320 = 0
      END IF      
      
      LET l_max_amt = 0
      
      FOREACH apjp400_pjby_cur USING g_enterprise,l_pjeb.pjebcomp,g_edate,g_bdate INTO l_pjec.pjec004,l_pjec.pjec005,l_pjec.pjec099
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         IF cl_null(l_pjec.pjec099) THEN
            LET l_pjec.pjec099 = 0
         END IF
         #分摊金额=项目工时（pjec099）*分摊单价（pjeb300）
         LET l_pjec.pjec100 = l_pjec.pjec099 * l_pjec.pjec300   #分摊金额
         LET l_pjec.pjec110 = l_pjec.pjec099 * l_pjec.pjec310   #分摊金额(本位币二)
         LET l_pjec.pjec120 = l_pjec.pjec099 * l_pjec.pjec320   #分摊金额(本位币三)
         
         IF NOT cl_null(l_curr) THEN
            LET l_pjec.pjec100 = s_curr_round(l_pjec.pjeccomp,l_curr,l_pjec.pjec100,'2')
            LET l_pjec.pjec110 = s_curr_round(l_pjec.pjeccomp,l_curr,l_pjec.pjec110,'2')
            LET l_pjec.pjec120 = s_curr_round(l_pjec.pjeccomp,l_curr,l_pjec.pjec120,'2')
         END IF
         
         SELECT MAX(pjecseq)+1 INTO l_pjec.pjecseq FROM pjec_t
             WHERE pjecent = g_enterprise AND pjecld = l_pjec.pjecld AND pjec002 = l_pjec.pjec002 AND pjec003 = l_pjec.pjec003
         IF cl_null(l_pjec.pjecseq) OR l_pjec.pjecseq = 0 THEN
            LET l_pjec.pjecseq = 1
         END IF
         
         INSERT INTO pjec_t(pjecent,pjeccomp,pjecld,pjec002,pjec003,pjecseq,pjec004,pjec005,pjec010,
                            pjec011,pjec012,pjec013,pjec014,pjec015,pjec016,pjec017,pjec018,pjec019,
                            pjec020,pjec021,pjec022,pjec099,pjec100,pjec110,pjec120,pjec200,pjec300,
                            pjec310,pjec320,pjecownid,pjecowndp,pjeccrtid,pjeccrtdp,pjeccrtdt,pjecmodid,pjecmoddt,pjecstus)
             VALUES (l_pjec.pjecent,l_pjec.pjeccomp,l_pjec.pjecld,l_pjec.pjec002,l_pjec.pjec003,l_pjec.pjecseq,l_pjec.pjec004,l_pjec.pjec005,l_pjec.pjec010,
                     l_pjec.pjec011,l_pjec.pjec012,l_pjec.pjec013,l_pjec.pjec014,l_pjec.pjec015,l_pjec.pjec016,l_pjec.pjec017,l_pjec.pjec018,l_pjec.pjec019,
                     l_pjec.pjec020,l_pjec.pjec021,l_pjec.pjec022,l_pjec.pjec099,l_pjec.pjec100,l_pjec.pjec110,l_pjec.pjec120,l_pjec.pjec200,l_pjec.pjec300,
                     l_pjec.pjec310,l_pjec.pjec320,l_pjec.pjecownid,l_pjec.pjecowndp,l_pjec.pjeccrtid,l_pjec.pjeccrtdp,l_pjec.pjeccrtdt,l_pjec.pjecmodid,
                     l_pjec.pjecmoddt,l_pjec.pjecstus)
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "ins pjec_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = 'N'                        
         END IF
         LET l_flag = 'Y'  
         IF l_pjec.pjec100 > l_max_amt THEN 
            LET l_max_amt = l_pjec.pjec100
         END IF         
      END FOREACH      
      
      #分摊完毕后处理尾差
      #    依科目+部门+营运组织+交易对象+客群+区域+成本中心+经营类别+渠道+品类+品牌+项目编号+WBS 的维度处理尾差
      SELECT SUM(pjec100),SUM(pjec110),SUM(pjec120) INTO l_sum_pjec100,l_sum_pjec110,l_sum_pjec120 FROM pjec_t 
         WHERE pjecent = g_enterprise AND pjecld = l_pjec.pjecld AND pjec002 = l_pjec.pjec002 AND pjec003 = l_pjec.pjec003
           AND pjec010 = l_pjeb.pjeb010   #科目编号
           AND pjec011 = l_pjeb.pjeb011   #营运组织
           AND pjec012 = l_pjeb.pjeb012   #部门
           AND pjec013 = l_pjeb.pjeb013   #交易对象
           AND pjec014 = l_pjeb.pjeb014   #客群
           AND pjec015 = l_pjeb.pjeb015   #区域
           AND pjec016 = l_pjeb.pjeb016   #成本中心
           AND pjec017 = l_pjeb.pjeb017   #经营类别
           AND pjec018 = l_pjeb.pjeb018   #渠道
           AND pjec019 = l_pjeb.pjeb019   #品类
           AND pjec020 = l_pjeb.pjeb020   #品牌
           AND pjec021 = l_pjeb.pjeb021   #项目编号(核算项)
           AND pjec022 = l_pjeb.pjeb022   #WBS(核算项)
      
      IF cl_null(l_sum_pjec100) THEN LET l_sum_pjec100 = 0 END IF  
      IF cl_null(l_sum_pjec110) THEN LET l_sum_pjec110 = 0 END IF   
      IF cl_null(l_sum_pjec120) THEN LET l_sum_pjec120 = 0 END IF  
      IF NOT cl_null(l_curr) THEN
         LET l_sum_pjec100 = s_curr_round(l_pjec.pjeccomp,l_curr,l_sum_pjec100,'2')
         LET l_sum_pjec110 = s_curr_round(l_pjec.pjeccomp,l_curr,l_sum_pjec110,'2')
         LET l_sum_pjec120 = s_curr_round(l_pjec.pjeccomp,l_curr,l_sum_pjec120,'2')
      END IF
      
      UPDATE pjec_t SET pjec100 = pjec100 + l_pjeb.pjeb100 - l_sum_pjec100,
                        pjec110 = pjec110 + l_pjeb.pjeb110 - l_sum_pjec110,
                        pjec120 = pjec120 + l_pjeb.pjeb120 - l_sum_pjec120
           WHERE pjecent = g_enterprise AND pjecld = l_pjec.pjecld AND pjec002 = l_pjec.pjec002 
             AND pjec003 = l_pjec.pjec003
             AND pjec100 = l_max_amt
             AND rownum  = 1
                   
      INITIALIZE l_pjec.* TO NULL
   END FOREACH
   
   IF l_flag = 'N' THEN       
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00167'  
      LET g_errparam.extend = "pjec_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = 'N'
   END IF
   CALL cl_progress_no_window_ing("ins pjec")
 
   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: 年度期别检查
# Date & Author..: 2017/01/05 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION apjp400_date_chk(p_comp,p_pjec002,p_pjec003)
   DEFINE p_comp         LIKE pjec_t.pjeccomp
   DEFINE p_pjec002      LIKE pjec_t.pjec002
   DEFINE p_pjec003      LIKE pjec_t.pjec003
   DEFINE l_flag         LIKE type_t.dat
   DEFINE l_yy           LIKE xref_t.xref001
   DEFINE l_pp           LIKE xref_t.xref002
   DEFINE l_ooef017      LIKE ooef_t.ooef017
   
   
   LET g_errno = ''
   IF cl_null(p_comp) THEN RETURN END IF

   IF cl_null(p_pjec002) THEN RETURN END IF

   IF cl_null(p_pjec003) THEN RETURN END IF
   
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = p_comp
   LET l_flag = cl_get_para(g_enterprise,l_ooef017,'S-FIN-6012')   #关账日期

   LET l_yy = YEAR(l_flag)
   LET l_pp = MONTH(l_flag)

   LET g_errno = ' '
   IF l_yy > p_pjec002 THEN
      LET g_errno = 'axc-00303'
   END IF
   
   IF l_yy = p_pjec002 AND l_pp > p_pjec003 THEN  
      LET g_errno = 'axc-00304'
   END IF
   
END FUNCTION

#end add-point
 
{</section>}
 
