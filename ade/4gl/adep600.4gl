#該程式未解開Section, 採用最新樣板產出!
{<section id="adep600.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-05-10 11:37:55), PR版次:0006(2016-11-05 15:40:50)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000110
#+ Filename...: adep600
#+ Description: 經銷商銷售日結批次處理作業
#+ Creator....: 04226(2014-07-04 16:30:56)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adep600.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160727-00019#9   16/08/0   By   08734  临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01,adep600_demb_tmp ——> adep600_tmp02,adep600_demb_sum ——> adep600_tmp03,adep600_dema_sum ——> adep600_tmp044
#161104-00002#3   16/11/04  By   06137  調整系統*寫法
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
   dema002               LIKE dema_t.dema002,
   type1                 LIKE type_t.chr1,
   type2                 LIKE type_t.chr2,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       demasite LIKE dema_t.demasite, 
   dema002 LIKE dema_t.dema002, 
   type1 LIKE type_t.chr500, 
   type2 LIKE type_t.chr500, 
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
 
{<section id="adep600.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET lc_param.dema002 = g_argv[1]             #日結日期(必傳值)
   LET lc_param.type1 = g_argv[2]             #銷售組織往下展開(必傳值)
   LET lc_param.type2 = g_argv[3]             #已存在日結資料刪除重新結算(必傳值)
   LET lc_param.wc = g_argv[4]                #條件(必傳值)
   LET ls_js = util.JSON.stringify(lc_param)

   IF NOT cl_null(lc_param.wc) AND NOT cl_null(lc_param.type1) AND
      NOT cl_null(lc_param.type2) THEN
      LET g_bgjob = "Y"
   ELSE
      LET g_bgjob = "N"
   END IF
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL adep600_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adep600 WITH FORM cl_ap_formpath("ade",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL adep600_init()
 
      #進入選單 Menu (="N")
      CALL adep600_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_adep600
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="adep600.init" >}
#+ 初始化作業
PRIVATE FUNCTION adep600_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   LET g_errshow = 1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="adep600.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adep600_ui_dialog()
 
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
         INPUT BY NAME g_master.dema002,g_master.type1,g_master.type2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD dema002
            #add-point:BEFORE FIELD dema002 name="input.b.dema002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD dema002
            
            #add-point:AFTER FIELD dema002 name="input.a.dema002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE dema002
            #add-point:ON CHANGE dema002 name="input.g.dema002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type1
            #add-point:BEFORE FIELD type1 name="input.b.type1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type1
            
            #add-point:AFTER FIELD type1 name="input.a.type1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type1
            #add-point:ON CHANGE type1 name="input.g.type1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD type2
            #add-point:BEFORE FIELD type2 name="input.b.type2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD type2
            
            #add-point:AFTER FIELD type2 name="input.a.type2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE type2
            #add-point:ON CHANGE type2 name="input.g.type2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.dema002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD dema002
            #add-point:ON ACTION controlp INFIELD dema002 name="input.c.dema002"
            
            #END add-point
 
 
         #Ctrlp:input.c.type1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type1
            #add-point:ON ACTION controlp INFIELD type1 name="input.c.type1"
            
            #END add-point
 
 
         #Ctrlp:input.c.type2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD type2
            #add-point:ON ACTION controlp INFIELD type2 name="input.c.type2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON demasite
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD demasite
            #add-point:BEFORE FIELD demasite name="construct.b.demasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD demasite
            
            #add-point:AFTER FIELD demasite name="construct.a.demasite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.demasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD demasite
            #add-point:ON ACTION controlp INFIELD demasite name="construct.c.demasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'demasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO demasite  #顯示到畫面上
            NEXT FIELD demasite                     #返回原欄位
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
            CALL adep600_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.dema002 = g_today
            IF cl_null(g_master.type1) THEN
               LET g_master.type1 = 'N'
            END IF
            IF cl_null(g_master.type2) THEN
               LET g_master.type2 = 'N'
            END IF
            DISPLAY BY NAME g_master.dema002,g_master.type1,g_master.type2
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
            IF g_master.wc = " 1=1" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'apm-00379'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD demasite
            END IF
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
         CALL adep600_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.dema002 = g_master.dema002
      LET lc_param.type1 = g_master.type1
      LET lc_param.type2 = g_master.type2
      LET lc_param.wc = g_master.wc
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
                 CALL adep600_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = adep600_transfer_argv(ls_js)
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
 
{<section id="adep600.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION adep600_transfer_argv(ls_js)
 
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
   LET la_cmdrun.param[1] = la_param.dema002
   LET la_cmdrun.param[2] = la_param.type1
   LET la_cmdrun.param[3] = la_param.type2
   LET la_cmdrun.param[4] = la_param.wc
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="adep600.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION adep600_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#5 Add By Ken 160314
   DEFINE l_msg         STRING             #160225-00040#5 Add By Ken 160314    
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
      #160225-00040#5 Add By Ken 160314(S)
      LET l_loop = 3
      CALL cl_progress_bar_no_window(l_loop)  
      #160225-00040#5 Add By Ken 160314(E)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE adep600_process_cs CURSOR FROM ls_sql
#  FOREACH adep600_process_cs INTO
   #add-point:process段process name="process.process"
   CALL adep600_data(ls_js)
   
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
   CALL adep600_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="adep600.get_buffer" >}
PRIVATE FUNCTION adep600_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.dema002 = p_dialog.getFieldBuffer('dema002')
   LET g_master.type1 = p_dialog.getFieldBuffer('type1')
   LET g_master.type2 = p_dialog.getFieldBuffer('type2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="adep600.msgcentre_notify" >}
PRIVATE FUNCTION adep600_msgcentre_notify()
 
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
 
{<section id="adep600.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 資料處理(撈資料、資料是否有問題、新增資料)
# Memo...........:
# Usage..........: CALL adep600_data(ls_js)
# Input parameter: ls_js
# Return code....: 無
# Date & Author..: 2014/07/11 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_data(ls_js)
DEFINE ls_js         STRING
DEFINE lc_param      type_parameter
DEFINE l_success     LIKE type_t.num5
DEFINE l_loop        LIKE type_t.num5   #160225-00040#5 Add By Ken 160314
DEFINE l_msg         STRING             #160225-00040#5 Add By Ken 160314 

   
   CALL util.JSON.parse(ls_js,lc_param)
   CALL cl_err_collect_init()
   #160225-00040#5 Add By Ken 160314(S)  資料準備 
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   CALL cl_err_collect_init()    
   #160225-00040#5 Add By Ken 160314(E) 

   #建立需要的temp table
   CALL adep600_create_temp()
   
   #找出符合的資料放到temp table
   LET l_success = ''
   CALL adep600_ins_temp(ls_js) RETURNING l_success
   
   #當資料為重大錯誤(如：SQL錯誤)
   #會造成無法結算的才會讓回傳值為False
   #當如果只有資料有錯誤 或 單筆找不到資料
   #只記錄在 adep600_err temp table裡面
   #在最後要show錯誤訊息的時候
   #再並告知使用者那些資料是結算失敗的
   #讓訊息較為完整
   #160225-00040#5 Add By Ken 160314(S)   產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#5 Add By Ken 160314(e)    
   IF l_success THEN
      LET l_success = ''
      CALL s_transaction_begin()
      CALL adep600_ins_data(ls_js) RETURNING l_success
      IF l_success THEN
         CALL s_transaction_end('Y','0')
      ELSE
         CALL s_transaction_end('N','0')
      END IF
      
   END IF
   
   #160225-00040#5 Add By Ken 160314(S)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg) 
   #160225-00040#5 Add By Ken 160314(E)    
   CALL cl_err_collect_show()
END FUNCTION

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL adep600_create_temp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2014/07/04 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_create_temp()
   #條件輸入的組織
   DROP TABLE adep600_ooed004
   CREATE TEMP TABLE adep600_ooed004(
      ooed004   LIKE ooed_t.ooed004)
   CREATE INDEX adep600_ooed004_01 on adep600_ooed004(ooed004)
   
   #組織往下展的(包含當不往下展的)
   DROP TABLE adep600_tmp01    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01
   CREATE TEMP TABLE adep600_tmp01(    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01
      ooed004   LIKE ooed_t.ooed004)
   CREATE INDEX adep600_tmp01_01 on adep600_tmp01(ooed004)  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01
   
   DROP TABLE adep600_tmp02   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   CREATE TEMP TABLE adep600_tmp02(  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      seq      LIKE type_t.num10,     #項次
      dembent  LIKE demb_t.dembent,   #企業編號
      dembsite LIKE demb_t.dembsite,  #營運據點
      demb001  LIKE demb_t.demb001,   #客戶經營類
      demb002  LIKE demb_t.demb002,   #銷售日期
      demb003  LIKE demb_t.demb003,   #會計週	
      demb004  LIKE demb_t.demb004,   #會計期	
      demb005  LIKE demb_t.demb005,   #經銷商編號
      demb006  LIKE demb_t.demb006,   #合約編號
      demb007  LIKE demb_t.demb007,   #經營方式
      demb008  LIKE demb_t.demb008,   #結算類型
      demb009  LIKE demb_t.demb009,   #結算方式
      demb010  LIKE demb_t.demb010,   #商品編號
      demb011  LIKE demb_t.demb011,   #商品條碼
      demb012  LIKE demb_t.demb012,   #特徵碼
      demb013  LIKE demb_t.demb013,   #品牌	
      demb014  LIKE demb_t.demb014,   #稅別編號
      demb015  LIKE demb_t.demb015,   #本幣幣別
      demb016  LIKE demb_t.demb016,   #銷售單位
      demb017  LIKE demb_t.demb017,   #銷售數量
      demb018  LIKE demb_t.demb018,   #成本單位
      demb019	LIKE demb_t.demb019,   #成本單價
      demb020	LIKE demb_t.demb020,   #進價成本金額
      demb021	LIKE demb_t.demb021,   #銷貨標準售價金額(未稅)
      demb022	LIKE demb_t.demb022,   #銷貨標準售價金額(含稅)
      demb023	LIKE demb_t.demb023,   #銷貨折扣金額
      demb024	LIKE demb_t.demb024,   #銷貨實收金額(未稅)
      demb025	LIKE demb_t.demb025,   #銷貨實收金額(含稅)
      demb026	LIKE demb_t.demb026,   #毛利額
      demb027	LIKE demb_t.demb027,   #毛利率
      demb028	LIKE demb_t.demb028,   #促銷銷售數量
      demb029	LIKE demb_t.demb029,   #促銷應收金額(未稅)
      demb030	LIKE demb_t.demb030,   #促銷應收金額(含稅)
      demb031	LIKE demb_t.demb031,   #退貨數量
      demb032	LIKE demb_t.demb032,   #退貨標準售價金額(未稅)
      demb033	LIKE demb_t.demb033,   #退貨標準售價金額(含稅)
      demb034	LIKE demb_t.demb034,   #退貨折扣金額
      demb035	LIKE demb_t.demb035,   #退貨實退金額(未稅)
      demb036	LIKE demb_t.demb036,   #退貨實退金額(含稅)
      demb037	LIKE demb_t.demb037,   #銷售標準售價淨額(未稅)
      demb038	LIKE demb_t.demb038,   #銷售標準售價淨額(含稅)
      demb039	LIKE demb_t.demb039,   #銷售折扣淨額
      demb040	LIKE demb_t.demb040,   #銷售實收淨額(未稅)
      demb041	LIKE demb_t.demb041,   #銷售實收淨額(含稅)
      demb042	LIKE demb_t.demb042,   #訂貨數量
      demb043	LIKE demb_t.demb043,   #訂貨標準售價金額(未稅)
      demb044	LIKE demb_t.demb044,   #訂貨標準售價金額(含稅)
      demb045	LIKE demb_t.demb045,   #訂貨折扣金額
      demb046	LIKE demb_t.demb046,   #訂貨實收金額(未稅)
      demb047  LIKE demb_t.demb047,   #訂貨實收金額(含稅)
      demb048  LIKE demb_t.demb048,   #網點編號
      curr     LIKE xmdk_t.xmdk016,   #單據幣別
      type     LIKE type_t.chr1)      #類型
   
   DROP TABLE adep600_tmp03  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
   CREATE TEMP TABLE adep600_tmp03(    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      dembent  LIKE demb_t.dembent,   #企業編號
      dembsite LIKE demb_t.dembsite,  #營運據點
      demb001  LIKE demb_t.demb001,   #客戶經營類
      demb002  LIKE demb_t.demb002,   #銷售日期
      demb003  LIKE demb_t.demb003,   #會計週	
      demb004  LIKE demb_t.demb004,   #會計期	
      demb005  LIKE demb_t.demb005,   #經銷商編號
      demb006  LIKE demb_t.demb006,   #合約編號
      demb007  LIKE demb_t.demb007,   #經營方式
      demb008  LIKE demb_t.demb008,   #結算類型
      demb009  LIKE demb_t.demb009,   #結算方式
      demb010  LIKE demb_t.demb010,   #商品編號
      demb011  LIKE demb_t.demb011,   #商品條碼
      demb012  LIKE demb_t.demb012,   #特徵碼
      demb013  LIKE demb_t.demb013,   #品牌	
      demb014  LIKE demb_t.demb014,   #稅別編號
      demb015  LIKE demb_t.demb015,   #本幣幣別
      demb016  LIKE demb_t.demb016,   #銷售單位
      demb017  LIKE demb_t.demb017,   #銷售數量
      demb018  LIKE demb_t.demb018,   #成本單位
      demb019	LIKE demb_t.demb019,   #成本單價
      demb020	LIKE demb_t.demb020,   #進價成本金額
      demb021	LIKE demb_t.demb021,   #銷貨標準售價金額(未稅)
      demb022	LIKE demb_t.demb022,   #銷貨標準售價金額(含稅)
      demb023	LIKE demb_t.demb023,   #銷貨折扣金額
      demb024	LIKE demb_t.demb024,   #銷貨實收金額(未稅)
      demb025	LIKE demb_t.demb025,   #銷貨實收金額(含稅)
      demb026	LIKE demb_t.demb026,   #毛利額
      demb027	LIKE demb_t.demb027,   #毛利率
      demb028	LIKE demb_t.demb028,   #促銷銷售數量
      demb029	LIKE demb_t.demb029,   #促銷應收金額(未稅)
      demb030	LIKE demb_t.demb030,   #促銷應收金額(含稅)
      demb031	LIKE demb_t.demb031,   #退貨數量
      demb032	LIKE demb_t.demb032,   #退貨標準售價金額(未稅)
      demb033	LIKE demb_t.demb033,   #退貨標準售價金額(含稅)
      demb034	LIKE demb_t.demb034,   #退貨折扣金額
      demb035	LIKE demb_t.demb035,   #退貨實退金額(未稅)
      demb036	LIKE demb_t.demb036,   #退貨實退金額(含稅)
      demb037	LIKE demb_t.demb037,   #銷售標準售價淨額(未稅)
      demb038	LIKE demb_t.demb038,   #銷售標準售價淨額(含稅)
      demb039	LIKE demb_t.demb039,   #銷售折扣淨額
      demb040	LIKE demb_t.demb040,   #銷售實收淨額(未稅)
      demb041	LIKE demb_t.demb041,   #銷售實收淨額(含稅)
      demb042	LIKE demb_t.demb042,   #訂貨數量
      demb043	LIKE demb_t.demb043,   #訂貨標準售價金額(未稅)
      demb044	LIKE demb_t.demb044,   #訂貨標準售價金額(含稅)
      demb045	LIKE demb_t.demb045,   #訂貨折扣金額
      demb046	LIKE demb_t.demb046,   #訂貨實收金額(未稅)
      demb047  LIKE demb_t.demb047,   #訂貨實收金額(含稅)
      demb048  LIKE demb_t.demb048)   #網點編號
      
   DROP TABLE adep600_tmp04      #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
   CREATE TEMP TABLE adep600_tmp04(     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
      demaent  LIKE dema_t.demaent,   #企業編號
      demasite LIKE dema_t.demasite,  #營運據點
      dema001  LIKE dema_t.dema001,   #客戶經營類型
      dema002  LIKE dema_t.dema002,   #統計日期
      dema003  LIKE dema_t.dema003,   #會計週
      dema004  LIKE dema_t.dema004,   #會計期
      dema005  LIKE dema_t.dema005,   #經銷商編號
      dema006  LIKE dema_t.dema006,   #合同編號
      dema007  LIKE dema_t.dema007,   #經營方式
      dema008  LIKE dema_t.dema008,   #結算類型
      dema009  LIKE dema_t.dema009,   #結算方式
      dema010  LIKE dema_t.dema010,   #品牌
      dema011  LIKE dema_t.dema011,   #稅別編號
      dema012  LIKE dema_t.dema012,   #本幣幣別
      dema013  LIKE dema_t.dema013,   #進價成本金額
      dema014  LIKE dema_t.dema014,   #銷貨標準售價金額(未稅)
      dema015  LIKE dema_t.dema015,   #銷貨標準售價金額(含稅)
      dema016  LIKE dema_t.dema016,   #銷貨折扣金額
      dema017  LIKE dema_t.dema017,   #銷貨實收金額(未稅)
      dema018  LIKE dema_t.dema018,   #銷貨實收金額(含稅)
      dema019  LIKE dema_t.dema019,   #毛利額
      dema020  LIKE dema_t.dema020,   #毛利率
      dema021  LIKE dema_t.dema021,   #促銷應收金額(未稅)
      dema022  LIKE dema_t.dema022,   #促銷應收金額(含稅)
      dema023  LIKE dema_t.dema023,   #退貨標準售價金額(未稅)
      dema024  LIKE dema_t.dema024,   #退貨標準售價金額(含稅)
      dema025  LIKE dema_t.dema025,   #退貨折扣金額
      dema026  LIKE dema_t.dema026,   #退貨實退金額(未稅)
      dema027  LIKE dema_t.dema027,   #退貨實退金額(含稅)
      dema028  LIKE dema_t.dema028,   #銷售標準售價淨額(未稅)
      dema029  LIKE dema_t.dema029,   #銷售標準售價淨額(含稅)
      dema030  LIKE dema_t.dema030,   #銷售折扣淨額
      dema031  LIKE dema_t.dema031,   #銷售實收淨額(未稅)
      dema032  LIKE dema_t.dema032,   #銷售實收淨額(含稅)
      dema033  LIKE dema_t.dema033,   #訂貨標準售價金額(未稅)
      dema034  LIKE dema_t.dema034,   #訂貨標準售價金額(含稅)
      dema035  LIKE dema_t.dema035,   #訂貨折扣金額
      dema036  LIKE dema_t.dema036,   #訂貨實收金額(未稅)
      dema037  LIKE dema_t.dema037)   #訂貨實收金額(含稅)
      
   #存放有錯誤的
   DROP TABLE adep600_err
   CREATE TEMP TABLE adep600_err(
      dembent  LIKE demb_t.dembent,   #企業編號
      dembsite LIKE demb_t.dembsite,  #營運據點
      demb002  LIKE demb_t.demb002)   #銷售日期
      
   LET g_sql = "INSERT INTO adep600_err(dembent,dembsite,demb002)",
               "   VALUES(?,?,?)"
   PREPARE adep600_ins_err FROM g_sql
END FUNCTION

################################################################################
# Descriptions...: 把找出來的資料 放到temp table後 方便之後處理
# Memo...........:
# Usage..........: CALL adep600_ins_temp(ls_js)
#                :    RETURNING r_success
# Input parameter: ls_js
# Return code....: r_success     True/False
# Date & Author..: 2014/07/04 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_ins_temp(ls_js)
DEFINE ls_js       STRING
DEFINE r_success   LIKE type_t.num5
DEFINE lc_param    type_parameter
DEFINE l_cnt       LIKE type_t.num5
DEFINE l_str       STRING
DEFINE l_wc        STRING
DEFINE l_wc1       STRING
DEFINE l_wca       STRING
DEFINE l_wcb       STRING
DEFINE l_ooed004   LIKE ooed_t.ooed004
DEFINE l_success   LIKE type_t.num5
DEFINE l_str1      STRING
DEFINE l_ooef001   LIKE ooef_t.ooef001
DEFINE l_sql       STRING 

   LET r_success = TRUE
   CALL util.JSON.parse(ls_js,lc_param)
   ##############################
   IF NOT cl_null(lc_param.wc) THEN
      LET l_str1 = cl_replace_str(lc_param.wc,"demasite","ooefsite")
   END IF
   LET l_sql  = "SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"' AND ",l_str1
   PREPARE sel_ooef FROM l_sql
   DECLARE cur_ooef CURSOR FOR sel_ooef
   LET l_str1 = ''
   CALL cl_err_collect_init()
   FOREACH cur_ooef INTO l_ooef001
      IF NOT s_settledate_chk(l_ooef001,lc_param.dema002) THEN
         CONTINUE FOREACH
      END IF
      IF cl_null(l_str1) THEN
         LET l_str1 = "'",l_ooef001,"'"
      ELSE
         LET l_str1 = l_str1,",'",l_ooef001,"'"
      END IF     
   END FOREACH
   CALL cl_err_collect_show()  
   IF NOT cl_null(l_str1) THEN
      LET lc_param.wc = " demasite IN (",l_str1,")" 
   END IF    
   ##############################
   
   #拆出門店
   IF lc_param.type1 = 'Y' THEN
      LET l_str = lc_param.wc
      LET l_cnt = l_str.getIndexOf("demasite",1)
      IF l_cnt > 0 THEN
         IF l_cnt > 1 THEN
            LET l_wc = l_str.subString(1,l_cnt -1)
            LET l_wc1 = l_str.subString(l_cnt,l_str.getLength())
         ELSE
            LET l_wc = " 1=1"
            LET l_wc1 = lc_param.wc
         END IF
         IF l_wc1 = "demasite like '%'" THEN
            LET l_wc1 = NULL
         END IF
      ELSE
         LET l_wc = lc_param.wc
      END IF
   ELSE
      LET l_wc = lc_param.wc
   END IF
   
   LET l_wca = cl_replace_str(l_wc,"demasite","xmdl212")
   LET l_wcb = cl_replace_str(l_wc,"demasite","xmddsite")
   
   
   #塞入組織
   IF lc_param.type1 = 'Y' AND NOT cl_null(l_wc1) THEN
      #以選擇門店展以下門店
      LET g_sql = "INSERT INTO adep600_ooed004 ",
                  "SELECT DISTINCT ooed004 ",
                  "  FROM ooed_t ",
                  " WHERE ooedent = ",g_enterprise,
                  "   AND ooed001 = '9' ",
                  "   AND ooed006 <= '",lc_param.dema002,"'",
                  "   AND (ooed007 >= '",lc_param.dema002,"' OR ooed007 IS NULL) ",
                  "   AND ooed004 IN (SELECT ooed004 FROM ooed_t  ",
                  "                    START WITH ooed005 = ? ",
                  "                      AND ooed001 = '9' ",
                  "                      AND ooed006 <= '",lc_param.dema002,"'",
                  "                      AND (ooed007 >= '",lc_param.dema002,"' OR ooed007 IS NULL) ",
                  "                  CONNECT BY NOCYCLE PRIOR ooed004 = ooed005 ",
                  "                                       AND ooed001 = '9' ",
                  "                                       AND ooed006 <= '",lc_param.dema002,"'",
                  "                                       AND (ooed007 >= '",lc_param.dema002,"' OR ooed007 IS NULL) ",
                  "                    UNION ",
                  "                   SELECT ooed004 FROM ooed_t ",
                  "                    WHERE ooed004 = ? ) "
      PREPARE adep600_pre FROM g_sql
      LET g_sql = cl_replace_str(g_sql,"adep600_ooed004","adep600_tmp01")  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01
      PREPARE adep600_pre2 FROM g_sql
      EXECUTE adep600_pre2 USING g_site,g_site

      LET l_wc1 = cl_replace_str(l_wc1,"demasite","ooed004")
      LET g_sql = " SELECT ooed004 ",
                  "   FROM adep600_tmp01 ",  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_ooed004_02 ——> adep600_tmp01
                  "  WHERE ",l_wc1
      PREPARE adep600_pre3 FROM g_sql
      DECLARE adep600_curs3 CURSOR FOR adep600_pre3
      FOREACH adep600_curs3 INTO l_ooed004
         EXECUTE adep600_pre USING l_ooed004,l_ooed004
      END FOREACH
   ELSE
      LET g_sql = "INSERT INTO adep600_ooed004 ",
                  "SELECT DISTINCT ooed004 ",
                  "  FROM ooed_t ",
                  " WHERE ooedent = ",g_enterprise,
                  "   AND ooed001 = '9' ",
                  "   AND ooed006 <= '",lc_param.dema002,"'",
                  "   AND (ooed007 >= '",lc_param.dema002,"' OR ooed007 IS NULL) ",
                  "   AND ooed004 IN (SELECT ooed004 FROM ooed_t ",
                  "                    WHERE ooed004 = ? ) "
      PREPARE adep600_pre1 FROM g_sql
      EXECUTE adep600_pre1 USING g_site
   END IF
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins site"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #出貨資料
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   LET g_sql = "INSERT INTO adep600_tmp02(",
               "       seq,    ",
               "       dembent, dembsite, demb001, demb002,",
               "       demb003, demb004,  demb005, demb006,",
               "       demb007, demb008,  demb009, demb010,",
               "       demb011, demb012,  demb013, demb014,",
               "       demb015, demb016,  demb017, demb018,",
               
               "       demb019, demb020, demb021, demb022,",
               
               "       demb023, demb024, demb025, demb026,",
               "       demb027, demb028, demb029, demb030,",
               "       demb031, demb032, demb033, demb034,",
               "       demb035, demb036, demb037, demb038,",
               
               "       demb039, demb040, demb041, demb042,",
               "       demb043, demb044, demb045, demb046,",
               "       demb047, demb048, curr,    type) ",
               
               "SELECT ROW_NUMBER() OVER (ORDER BY xmdkent),",
               "       xmdkent, xmdl212, NULL,    xmdk001,",
               "       NULL,    NULL,    xmdk007, COALESCE(xmdl215,' '),",
               "       COALESCE(xmdl216,' '),COALESCE(xmdl217,' '), COALESCE(xmdl218,' '), xmdl008,",
               #ken---modify---S 150108-00008#1 
               #"       NULL,    xmdl009, NULL,    xmdl025,",
               "       NULL,    COALESCE(xmdl009,' '), NULL,    xmdl025,", 
               #ken---modify---E               
               "       ooef016, xmdl017, COALESCE(xmdl018,0), NULL,   ",
               
               "       0,       0,COALESCE(xmdl028,0)*COALESCE(xmdl018,0),",
               "       COALESCE(xmdl028,0)*COALESCE(xmdl018,0),",
               
               "       xmdl211, COALESCE(xmdl027,0), COALESCE(xmdl028,0), 0,",
               "       0,       0,      0,      0,",
               "       0,       0,      0,      0,",
               "       0,       0,      0,      0,",
               
               "       0,       0,      0,      0,",
               "       0,       0,      0,      0,",
               "       0,       xmdk009,xmdk016,'1'",
               "  FROM xmdk_t,xmdl_t",
               "  LEFT OUTER JOIN ooef_t ON ooefent = xmdlent AND ooef001 = xmdl212",
               " WHERE xmdkent = xmdlent",
               "   AND xmdkdocno = xmdldocno",
               "   AND xmdkent = ",g_enterprise,
               #非簽退/銷退單
               "   AND ( (xmdk000 BETWEEN '1' AND '3')",
               #非簽收的出貨單 且 非寄銷 銷售組織有值
               "   AND (((xmdl216 <> '13' OR xmdl216 IS NULL)",
               #"   AND (xmdk002 <> '3')",
               "   AND (xmdl212 IS NOT NULL)",
               "   AND (xmdkstus = 'S'))",
               #正式寄銷出貨單
               "    OR (xmdk002 = '7')",
               "   AND (xmdkstus = 'Y' OR xmdkstus = 'S'))",
               #出貨簽收單
               "   OR (xmdk000 = '4' AND xmdl212 IS NOT NULL AND xmdkstus = 'Y') )",
               "   AND EXISTS (SELECT ooed004 ",
               "                 FROM adep600_ooed004 ",
               "                WHERE ooed004 = xmdl212) ",
               "   AND ",l_wca,
               "   AND xmdk001 = '",lc_param.dema002,"'"
   PREPARE adep600_pre4 FROM g_sql
   DISPLAY 'g_sql = ',g_sql
   EXECUTE adep600_pre4
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins adep600_tmp02"  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #訂單資料
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   LET g_sql = "INSERT INTO adep600_tmp02(",
               "       seq,    ",
               "       dembent, dembsite, demb001, demb002,",
               "       demb003, demb004,  demb005, demb006,",
               "       demb007, demb008,  demb009, demb010,",
               "       demb011, demb012,  demb013, demb014,",
               "       demb015, demb016,  demb017, demb018,",
               
               "       demb019, demb020, demb021, demb022,",
               "       demb023, demb024, demb025, demb026,",
               "       demb027, demb028, demb029, demb030,",
               "       demb031, demb032, demb033, demb034,",
               "       demb035, demb036, demb037, demb038,",
               
               "       demb039, demb040, demb041, demb042,",
               
               "       demb043, demb044, demb045, demb046,",
               
               "       demb047, demb048, curr   , type) ",
               
               "SELECT ROW_NUMBER() OVER (ORDER BY xmdaent),",
               "       xmdaent, xmddsite, NULL,    xmdadocdt,",
               "       NULL,    NULL,     xmda004, COALESCE(xmdd225,' '),",
               "       COALESCE(xmdd226,' '),COALESCE(xmdd227,' '),COALESCE(xmdd228,' '), xmdd001,",
               #ken---modify---S 150108-00008#1                
               #"       NULL,    xmdd002,  NULL,    xmdd019,",
               "       NULL,    COALESCE(xmdd002,' '),  NULL,    xmdd019,",
               #ken---modify---E
               "       ooef016, xmdd004,  0,       NULL, ",  
               
               "       0,       0,        0,       0,",      
               "       0,       0,        0,       0,",      
               "       0,       0,        0,       0,",      
               "       0,       0,        0,       0,",      
               "       0,       0,        0,       0,",      
               
               "       0,       0,        0,       ",
               "       (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0)),",   
               
               "       COALESCE(xmdd203,0)*COALESCE(xmdd006,0),COALESCE(xmdd203,0)*COALESCE(xmdd006,0),",
               "       COALESCE(xmdd206,0),COALESCE(xmdd028,0),",
               
               "       COALESCE(xmdd029,0), xmja025, xmda015,  '2'",
               "  FROM xmda_t,xmja_t,xmdd_t",
               "  LEFT OUTER JOIN ooef_t ON ooefent = xmddent AND ooef001 = xmddsite",
               " WHERE xmdaent = xmddent",
               "   AND xmdadocno = xmdddocno",
               "   AND xmdaent = ",g_enterprise,
               "   AND xmdastus = 'Y'",
               
               "   AND xmdaent = xmjaent",
               "   AND xmdadocno = xmjadocno",
               "   AND xmjaent = xmddent",
               "   AND xmjadocno = xmdddocno",
               "   AND xmjaseq = xmddseq",
               
               "   AND 0 < (COALESCE(xmdd006,0)-COALESCE(xmdd014,0)+COALESCE(xmdd016,0)+COALESCE(xmdd034,0))",
               "   AND EXISTS (SELECT ooed004 ",
               "                 FROM adep600_ooed004 ",
               "                WHERE ooed004 = xmddsite) ",
               "   AND ",l_wcb,
               "   AND xmdadocdt = '",lc_param.dema002,"'"
   PREPARE adep600_pre5 FROM g_sql
   EXECUTE adep600_pre5
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins adep600_tmp02"  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #銷退資料
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   LET g_sql = "INSERT INTO adep600_tmp02(",
               "       seq,    ",
               "       dembent, dembsite, demb001, demb002,",
               "       demb003, demb004,  demb005, demb006,",
               "       demb007, demb008,  demb009, demb010,",
               "       demb011, demb012,  demb013, demb014,",
               "       demb015, demb016,  demb017, demb018,",
               
               "       demb019, demb020, demb021, demb022,",
               "       demb023, demb024, demb025, demb026,",
               "       demb027, demb028, demb029, demb030,",
               
               "       demb031, demb032, demb033, demb034,",
               
               "       demb035, demb036, demb037, demb038,",
               "       demb039, demb040, demb041, demb042,",
               "       demb043, demb044, demb045, demb046,",
               "       demb047, demb048, curr   , type ) ",
               
               "SELECT ROW_NUMBER() OVER (ORDER BY xmdkent),",
               "       xmdkent,xmdl212,NULL,   xmdk001,",
               "       NULL,   NULL,   xmdk007,COALESCE(xmdl215,' '),",
               "       COALESCE(xmdl216,' '),COALESCE(xmdl217,' '),COALESCE(xmdl218,' '),xmdl008,",
               #ken---modify---S 150108-00008#1                 
               #"       NULL,   xmdl009,NULL,   xmdl025,",
               "       NULL,   COALESCE(xmdl009,' '),NULL,   xmdl025,",
               #ken---modify---E
               "       ooef016,xmdl017,0,      NULL,   ",
               
               "       0,      0,      0,      0,      ",
               "       0,      0,      0,      0,      ",
               "       0,      0,      0,      0,      ",
               
               "       COALESCE(xmdl018,0), COALESCE(xmdl208,0)*COALESCE(xmdl018,0), ",
               "       COALESCE(xmdl208,0)*COALESCE(xmdl018,0), COALESCE(xmdl211,0),",
               
               "       COALESCE(xmdl027,0),COALESCE(xmdl028,0),0,      0,      ",
               "       0,      0,      0,      0,",
               "       0,      0,      0,      0,",
               "       0,      xmdk009,xmdk016,'3'",
               "  FROM xmdk_t,xmdl_t",
               "  LEFT OUTER JOIN ooef_t ON ooefent = xmdlent AND ooef001 = xmdl212",
               " WHERE xmdkent = xmdlent",
               "   AND xmdkdocno = xmdldocno",
               "   AND xmdkent = ",g_enterprise,
               "   AND (xmdk000 = '5' OR xmdk000 = '6')",
               "   AND xmdkstus = 'Y'",
               "   AND EXISTS (SELECT ooed004 ",
               "                 FROM adep600_ooed004 ",
               "                WHERE ooed004 = xmdl212) ",
               "   AND ",l_wca,
               "   AND xmdk001 = '",lc_param.dema002,"'"
   PREPARE adep600_pre6 FROM g_sql
   EXECUTE adep600_pre6
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins adep600_tmp02"  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #建index
   CREATE INDEX adep600_tmp02_01 on adep600_tmp02   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      (dembent,dembsite,demb002,demb005,demb006,
       demb007,demb008, demb009,demb010,demb012,
       demb014,demb018, demb019,demb048,curr,
       type)
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Index adep600_tmp02"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #客戶經營類型 demb001 (demb007-> pmaa092)
   #會計週 demb003 會計期demb004 (dembsite,demb002->oogc008,oogc006)
   #商品條碼 demb011 (demb010->imay003 WHERE imay006 = 'Y')
   #品牌 demb13 (demb010->imaa126)
   #成本單位 demb018 (dembsite,demb010->imag014)
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   LET g_sql = "UPDATE adep600_tmp02 ",
               "   SET demb001 = (SELECT pmaa092 FROM pmaa_t",
               "                   WHERE pmaaent = dembent",
               "                     AND pmaa001 = demb005), ",
               "       (demb003,demb004) = (SELECT oogc008,oogc006",
               "                              FROM oogc_t,ooef_t",
               "                             WHERE oogcent = ooefent",
               "                               AND oogc001 = ooef008",    #行事曆參照表號
               "                               AND oogcent = dembent",
               "                               AND oogc002 = '4'",        #行事曆類別
               "                               AND ooef001 = dembsite",   #營運據點
               "                               AND oogc003 = demb002),",  #日期
               "       demb011 = (SELECT imay003 FROM imay_t",
               "                   WHERE imayent = dembent",
               "                     AND imay001 = demb010",
               "                     AND imay006 = 'Y'), ",
               "       demb013 = (SELECT COALESCE(imaa126,' ') FROM imaa_t",
               "                   WHERE imaaent = dembent",
               "                     AND imaa001 = demb010),",
               "       demb018 = (SELECT imag014",
               "                    FROM imag_t",
               "                   WHERE imagent = dembent",
               "                     AND imagsite = 'ALL'",
               "                     AND imag001 = demb010)"   #商品編號

   PREPARE adep600_pre7 FROM g_sql
   EXECUTE adep600_pre7
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Upd adep600_tmp02"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #資料逐筆的處理
   LET l_success = ''
   CALL adep600_data_process() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #彙總資料 並且把需要計算的欄位一同計算完畢
   #分別放到正確的temp table
   LET l_success = ''
   CALL adep600_data_collect() RETURNING l_success
   IF l_success = FALSE THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 資料處理
# Memo...........:
# Usage..........: CALL adep600_data_process()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success     True/False
# Date & Author..: 2014/07/09 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_data_process()
DEFINE r_success   LIKE type_t.num5
DEFINE l_msg       STRING
DEFINE l_gzsz008   LIKE gzsz_t.gzsz008
DEFINE l_rate      LIKE ooan_t.ooan005
DEFINE l_success   LIKE type_t.num5
#DEFINE l_unit_rate LIKE inaj_t.inaj014 #sakura mark
DEFINE l_unit      LIKE inaj_t.inaj014  #sakura add
DEFINE l_xrcd103   LIKE xrcd_t.xrcd103    #原幣未稅金額
DEFINE l_xrcd104   LIKE xrcd_t.xrcd104    #原幣稅額
DEFINE l_xrcd105   LIKE xrcd_t.xrcd105    #原幣含稅金額
DEFINE l_xrcd113   LIKE xrcd_t.xrcd113    #本幣未稅金額
DEFINE l_xrcd114   LIKE xrcd_t.xrcd114    #本幣稅額
DEFINE l_xrcd115   LIKE xrcd_t.xrcd115    #本幣含稅金額
DEFINE l_dembsite  LIKE demb_t.dembsite
DEFINE l_demb      RECORD
       type        LIKE type_t.chr1,      #類型
       seq         LIKE type_t.num10,     #項次
       dembent     LIKE demb_t.dembent,   #企業編號
       dembsite    LIKE demb_t.dembsite,  #營運據點
       demb002     LIKE demb_t.demb002,   #日結日期
       demb010     LIKE demb_t.demb010,   #商品編號
       demb014     LIKE demb_t.demb014,   #稅別編號
       demb015     LIKE demb_t.demb015,   #本幣幣別
       demb016     LIKE demb_t.demb016,   #銷售單位
       demb017     LIKE demb_t.demb017,   #銷售數量
       demb018     LIKE demb_t.demb018,   #成本單位
       demb019     LIKE demb_t.demb019,   #成本單價
       demb020     LIKE demb_t.demb020,   #進價成本金額
       demb021     LIKE demb_t.demb021,   #銷貨標準售價金額(未稅)
       demb022     LIKE demb_t.demb022,   #銷貨標準售價金額(含稅)
       demb023     LIKE demb_t.demb023,   #銷貨折價金額
       demb024     LIKE demb_t.demb024,   #銷售實收金額(未稅)
       demb025     LIKE demb_t.demb025,   #銷售實收金額(含稅)
       demb028     LIKE demb_t.demb028,   #促銷銷售數量
       demb029     LIKE demb_t.demb029,   #促銷應收金額(未稅)
       demb030     LIKE demb_t.demb030,   #促銷應收金額(含稅)
       demb031     LIKE demb_t.demb031,   #退貨數量
       demb032     LIKE demb_t.demb032,   #退貨標準售價金額(未稅)
       demb033     LIKE demb_t.demb033,   #退貨標準售價金額(含稅)
       demb034     LIKE demb_t.demb034,   #退貨折扣金額
       demb035     LIKE demb_t.demb035,   #退貨實退金額(未稅)
       demb036     LIKE demb_t.demb036,   #退貨實退金額(含稅)
       demb042     LIKE demb_t.demb042,   #訂貨數量
       demb043     LIKE demb_t.demb043,   #訂貨標準售價金額(未稅)
       demb044     LIKE demb_t.demb044,   #訂貨標準售價金額(含稅)
       demb045     LIKE demb_t.demb045,   #訂貨折扣金額
       demb046     LIKE demb_t.demb046,   #訂貨標準售價金額(未稅)
       demb047     LIKE demb_t.demb047,   #訂貨標準售價金額(含稅)
       demb048     LIKE demb_t.demb048,   #網點編號
       curr        LIKE xmdk_t.xmdk016    #原幣幣別
                   END RECORD
                   
   LET r_success = TRUE
   
   #撈出需要處理的資料
   LET g_sql = "SELECT type,   seq,    dembent, dembsite,",
               "       demb002,demb010,demb014, demb015,",
               "       demb016,demb017,demb018, demb019,",
               "       demb021,demb022,demb023, demb024,",
               "       demb025,demb031,demb032, demb033,",
               "       demb034,demb035,demb036, demb042,",
               "       demb043,demb044,demb045, demb046,",
               "       demb047,demb048,curr   ",
               "  FROM adep600_tmp02"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
   PREPARE adep600_pre8 FROM g_sql
   DECLARE adep600_curs8 CURSOR FOR adep600_pre8
   
   LET l_dembsite = 'a'
   INITIALIZE l_demb.* TO NULL
   FOREACH adep600_curs8 INTO l_demb.type,   l_demb.seq,    l_demb.dembent,l_demb.dembsite,
                              l_demb.demb002,l_demb.demb010,l_demb.demb014,l_demb.demb015,
                              l_demb.demb016,l_demb.demb017,l_demb.demb018,l_demb.demb019,
                              l_demb.demb021,l_demb.demb022,l_demb.demb023,l_demb.demb024,
                              l_demb.demb025,l_demb.demb031,l_demb.demb032,l_demb.demb033,
                              l_demb.demb034,l_demb.demb035,l_demb.demb036,l_demb.demb042,
                              l_demb.demb043,l_demb.demb044,l_demb.demb045,l_demb.demb046,
                              l_demb.demb047,l_demb.demb048,l_demb.curr
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach adep600_curs11"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #當本幣幣別為空
      IF cl_null(l_demb.demb015) THEN
         EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
         #此組織基本資料裡的主幣別欄位為空！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00057"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_demb.dembsite
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      
      #當成本單位為空時，表示料件據點財務檔 找不到資料
      IF cl_null(l_demb.demb018) THEN
         EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
         #此營運據點的所屬法人+商品編號  料件據點財務檔(imag_t)的成本單位為空！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00051"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_demb.dembsite
         LET g_errparam.columns[2] = "lbl_demb002"
         LET g_errparam.values[2] = l_demb.demb002
         LET g_errparam.columns[3] = "demb010"
         LET g_errparam.values[3] = l_demb.demb010
         CALL cl_err()
         CONTINUE FOREACH
      END IF
      
      #取匯率類型
      #當前一筆營運據點 與 現在這一筆資料的營運據點不相同的時
      #才需要從新撈取據點及參數資料
      IF l_dembsite = l_demb.dembsite THEN
      ELSE
         LET l_gzsz008 = cl_get_para(g_enterprise,l_demb.dembsite,'S-BAS-0010')
      END IF

      LET l_rate = ''
      LET g_sub_success = ''
      CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,1,l_gzsz008)
         RETURNING l_rate
      IF g_sub_success = FALSE THEN
         EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
         CONTINUE FOREACH
      END IF
      
      #依類型判斷 需要處理的欄位不相同
      CASE l_demb.type
         WHEN '1'   #出貨資料
            #原幣->本幣
            #當本幣幣別 與 原幣幣別不相同時 call s_aooi160_get_exrate 算出轉換率
            IF l_demb.demb015 = l_demb.curr THEN
               LET g_sub_success = ''
               #銷貨折價金額
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb023,l_gzsz008)
                  RETURNING l_demb.demb023
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #銷售實收金額(未稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb024,l_gzsz008)
                  RETURNING l_demb.demb024
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #銷售實收金額(含稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb025,l_gzsz008)
                  RETURNING l_demb.demb025
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
            END IF
            
            #當銷售折扣金額 <> 0
            #促銷銷售數量 　　 (demb028) = 銷售數量(demb017)
            #促銷應收金額(未稅)(demb029) = 銷售實收金額(未稅)(demb024)
            #促銷應收金額(含稅)(demb030) = 銷售實收金額(含稅)(demb025)
            IF l_demb.demb023 = 0 THEN
            ELSE
               LET l_demb.demb028 = l_demb.demb017
               LET l_demb.demb029 = l_demb.demb024
               LET l_demb.demb030 = l_demb.demb025
            END IF
            
            #取的銷售單位.成本單位轉換率
            #進價成本金額(demb020) = 成本單價(demb019)*銷售數量(demb017)*轉換率
            LET l_success = ''
           #141224-00013#15---sakura---mod---str            
           #LET l_unit_rate = '' 
            LET l_unit = '' 
           #CALL s_aimi190_get_convert(l_demb.demb010,l_demb.demb016,l_demb.demb018)
           #   RETURNING l_success,l_unit_rate
            CALL s_aooi250_convert_qty(l_demb.demb010,l_demb.demb016,l_demb.demb018,l_demb.demb017)
               RETURNING l_success,l_unit               
            IF l_success = FALSE THEN
               EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
               CONTINUE FOREACH
            END IF
           #LET l_demb.demb020 = l_demb.demb018 * l_demb.demb017 * l_unit_rate
            LET l_demb.demb020 = l_demb.demb018 * l_unit
           #141224-00013#15---sakura---mod---end 
            
            LET g_sub_success = ''
            #銷貨標準售價金額(未稅) 銷貨標準售價金額(含稅)
            CALL s_tax_count(l_demb.dembsite,l_demb.demb014,l_demb.demb021,
                             l_demb.demb017,l_demb.curr,l_rate)
               RETURNING l_xrcd103,l_xrcd104,l_xrcd105,    #原幣
                         l_xrcd113,l_xrcd114,l_xrcd115     #本幣
            LET l_demb.demb021 = l_xrcd113   #未稅
            LET l_demb.demb022 = l_xrcd115   #含稅
            IF g_sub_success = FALSE THEN
               EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
               CONTINUE FOREACH
            END IF
            
         WHEN '2'   #訂單資料
            #原幣->本幣
            #當本幣幣別 與 原幣幣別不相同時 call s_aooi160_get_exrate 算出轉換率
            IF l_demb.demb015 = l_demb.curr THEN
               LET g_sub_success = ''
               #訂貨折扣金額
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb045,l_gzsz008)
                  RETURNING l_demb.demb045
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #訂貨標準售價金額(未稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb046,l_gzsz008)
                  RETURNING l_demb.demb046
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #訂貨標準售價金額(含稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb047,l_gzsz008)
                  RETURNING l_demb.demb047
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
            END IF
            
            LET g_sub_success = ''
            #訂貨標準售價金額(未稅) 訂貨標準售價金額(含稅)
            CALL s_tax_count(l_demb.dembsite,l_demb.demb014,l_demb.demb043,
                             l_demb.demb042,l_demb.curr,l_rate)
               RETURNING l_xrcd103,l_xrcd104,l_xrcd105,    #原幣
                         l_xrcd113,l_xrcd114,l_xrcd115     #本幣
            LET l_demb.demb043 = l_xrcd113   #未稅
            LET l_demb.demb044 = l_xrcd115   #含稅
            IF g_sub_success = FALSE THEN
               EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
               CONTINUE FOREACH
            END IF
            
         WHEN '3'   #銷退資料
            #原幣->本幣
            #當本幣幣別 與 原幣幣別不相同時 call s_aooi160_get_exrate 算出轉換率
            IF l_demb.demb015 = l_demb.curr THEN
               LET g_sub_success = ''
               #退貨折扣金額
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb034,l_gzsz008)
                  RETURNING l_demb.demb034
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #退貨實退金額(未稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb035,l_gzsz008)
                  RETURNING l_demb.demb035
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
               
               LET g_sub_success = ''
               #退貨實退金額(含稅)
               CALL s_aooi160_get_exrate('1',l_demb.dembsite,l_demb.demb002,l_demb.curr,
                                         l_demb.demb015,l_demb.demb036,l_gzsz008)
                  RETURNING l_demb.demb036
               IF g_sub_success = FALSE THEN
                  EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
                  CONTINUE FOREACH
               END IF
            END IF
            
            LET g_sub_success = ''
            #訂貨標準售價金額(未稅) 訂貨標準售價金額(含稅)
            CALL s_tax_count(l_demb.dembsite,l_demb.demb014,l_demb.demb032,
                             l_demb.demb031,l_demb.curr,l_rate)
               RETURNING l_xrcd103,l_xrcd104,l_xrcd105,    #原幣
                         l_xrcd113,l_xrcd114,l_xrcd115     #本幣
            LET l_demb.demb032 = l_xrcd113   #未稅
            LET l_demb.demb033 = l_xrcd115   #含稅
            IF g_sub_success = FALSE THEN
               EXECUTE adep600_ins_err USING l_demb.dembent,l_demb.dembsite,l_demb.demb002
               CONTINUE FOREACH
            END IF
      END CASE
      
      LET l_dembsite = l_demb.dembsite
      INITIALIZE l_demb.* TO NULL
      
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 資料彙總 並且把需要計算的欄位一同計算完畢
# Memo...........:
# Usage..........: CALL adep600_data_collect()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2014/07/11 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_data_collect()
DEFINE r_success        LIKE type_t.num5

   LET r_success = TRUE
   
   #把所有資料sum
   #銷售組織、　客戶經營類型、日結日期、會計週、　會計期
   #經銷商編號、合同編號、　　經營方式、結算類型、結算方式
   #商品編號、　商品條碼、　　特徵碼、　品牌、　　稅別編號
   #本幣幣別、　銷售單位、　　成本單位、成本單價
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
   LET g_sql = "INSERT INTO adep600_tmp03 (",
               "       dembent,dembsite,demb001,demb002,demb003,",
               "       demb004,demb005, demb006,demb007,demb008,",
               "       demb009,demb010, demb011,demb012,demb013,",
               "       demb014,demb015, demb016,demb018,demb019,",
               
               "       demb017, demb020,demb021,demb022,demb023,",
               "       demb024, demb025,demb026,demb027,demb028,",
               "       demb029, demb030,demb031,demb032,demb033,",
               "       demb034, demb035,demb036,demb037,demb038,",
               "       demb039, demb040,demb041,demb042,demb043,",
               "       demb044, demb045,demb046,demb047,demb048) ",
                                
               "SELECT dembent,dembsite,demb001,demb002,demb003,",
               "       demb004,demb005, demb006,demb007,demb008,",
               "       demb009,demb010, demb011,demb012,demb013,",
               "       demb014,demb015, demb016,demb018,demb019,",
               
               "       SUM(demb017),SUM(demb020),SUM(demb021),SUM(demb022),SUM(demb023),",
               "       SUM(demb024),SUM(demb025),SUM(demb026),SUM(demb027),SUM(demb028),",
               "       SUM(demb029),SUM(demb030),SUM(demb031),SUM(demb032),SUM(demb033),",
               "       SUM(demb034),SUM(demb035),SUM(demb036),SUM(demb037),SUM(demb038),",
               "       SUM(demb039),SUM(demb040),SUM(demb041),SUM(demb042),SUM(demb043),",
               "       SUM(demb044),SUM(demb045),SUM(demb046),SUM(demb047),demb048",
               "  FROM adep600_tmp02",  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
               " GROUP BY dembent,dembsite,demb001,demb002,demb003,",
               "          demb004,demb005, demb006,demb007,demb008,",
               "          demb009,demb010, demb011,demb012,demb013,",
               "          demb014,demb015, demb016,demb018,demb019,",
               "          demb048"
   PREPARE adep600_pre9 FROM g_sql
   EXECUTE adep600_pre9
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins adep600_tmp03"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #建index
   CREATE INDEX adep600_tmp03_01 on adep600_tmp03    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      (dembent,dembsite,demb002,demb005,demb006,
       demb007,demb008, demb009,demb010,demb012,
       demb014,demb018, demb019,demb048)
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Index adep600_tmp03"     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #計算
   #毛利額(demb026) = 銷售實收金額(含稅)(demb025) - 進價成本金額(demb020)
   #毛利率(demb027) = (毛利額/進價成本金額(demb020)) * 100
   #銷售標準售價淨額(未稅)(demb037) = 銷貨標準售價金額(未稅)(demb021) - 退貨標準售價金額(未稅)(demb032)
   #銷售標準售價淨額(含稅)(demb038) = 銷貨標準售價金額(含稅)(demb022) - 退貨標準售價金額(含稅)(demb033)
   #銷售折扣淨額(demb039) = 銷貨折扣金額(demb023) - 銷退折扣金額(demb034)
   #銷售實收淨額(未稅)(demb040) = 銷貨實收金額(未稅)(demb024) - 退貨實退金額(未稅)(demb035)
   #銷售實收淨額(含稅)(demb041) = 銷貨實收金額(含稅)(demb025) - 退貨實退金額(含稅)(demb036)
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
   LET g_sql = "UPDATE adep600_tmp03",
               "   SET demb026 = (demb025 - demb020),",
               "       demb027 = (( (demb025 - demb020) / ",
               "                    (CASE demb020 WHEN 0 THEN 1 ELSE demb020 END)) * 100),",
               "       demb037 = (demb021 - demb032),",
               "       demb038 = (demb022 - demb033),",
               "       demb039 = (demb023 - demb034),",
               "       demb040 = (demb024 - demb035),",
               "       demb041 = (demb025 - demb036)"
   PREPARE adep600_pre10 FROM g_sql
   EXECUTE adep600_pre10
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Upd adep600_tmp03"  #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #把所有資料sum
   #銷售組織、　客戶經營類型、日結日期、會計週、　會計期
   #經銷商編號、合同編號、　　經營方式、結算類型、結算方式
   #品牌、　　  稅別編號、    本幣幣別
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
   LET g_sql = "INSERT INTO adep600_tmp04 (",
               "       demaent,demasite,dema001,dema002,dema003,",
               "       dema004,dema005, dema006,dema007,dema008,",
               "       dema009,dema010, dema011,dema012,",
               
               "       dema013,dema014, dema015,dema016,dema017,",
               "       dema018,dema019, dema020,dema021,dema022,",
               "       dema023,dema024, dema025,dema026,dema027,",
               "       dema028,dema029, dema030,dema031,dema032,",
               "       dema033,dema034, dema035,dema036,dema037)",
               
               "SELECT dembent,dembsite,demb001,demb002,demb003,",
               "       demb004,demb005, demb006,demb007,demb008,",
               "       demb009,demb013, demb014,demb015,",
               
               "       SUM(demb020),SUM(demb021),SUM(demb022),SUM(demb023),SUM(demb024),",
               "       SUM(demb025),SUM(demb026),SUM(demb027),SUM(demb029),SUM(demb030),",
               "       SUM(demb032),SUM(demb033),SUM(demb034),SUM(demb035),SUM(demb036),",
               "       SUM(demb037),SUM(demb038),SUM(demb039),SUM(demb040),SUM(demb041),",
               "       SUM(demb043),SUM(demb044),SUM(demb045),SUM(demb046),SUM(demb047) ",
               "  FROM adep600_tmp02",   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_tmp ——> adep600_tmp02
               " GROUP BY dembent,dembsite,demb001,demb002,demb003,",
               "          demb004,demb005, demb006,demb007,demb008,",
               "          demb009,demb013, demb014,demb015"
   PREPARE adep600_pre11 FROM g_sql
   EXECUTE adep600_pre11
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins adep600_tmp04"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #建index
   CREATE INDEX adep600_tmp04_01 on adep600_tmp04       #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
      (demaent,demasite,dema001,dema002,dema003,
       dema004,dema005, dema006,dema007,dema008,
       dema009,dema010, dema011,dema012)
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Index adep600_tmp04"    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #計算
   #毛利額(dema019) = 銷售實收金額(含稅)(dema018) - 進價成本金額(dema013)
   #毛利率(dema020) = (毛利額/進價成本金額(dema013)) * 100
   #銷售標準售價淨額(未稅)(dema028) = 銷貨標準售價金額(未稅)(dema014) - 退貨標準售價金額(未稅)(dema023)
   #銷售標準售價淨額(含稅)(dema029) = 銷貨標準售價金額(含稅)(dema015) - 退貨標準售價金額(含稅)(dema024)
   #銷售折扣淨額(dema030) = 銷貨折扣金額(dema016) - 銷退折扣金額(dema025)
   #銷售實收淨額(未稅)(dema031) = 銷貨實收金額(未稅)(dema017) - 退貨實退金額(未稅)(dema026)
   #銷售實收淨額(含稅)(dema032) = 銷貨實收金額(含稅)(dema018) - 退貨實退金額(含稅)(dema027)
   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
   LET g_sql = "UPDATE adep600_tmp04",
               "   SET dema019 = (dema018 - dema013),",
               "       dema020 = (( (dema018 - dema013)/",
               "                    (CASE dema013 WHEN 0 THEN 1 ELSE dema013 END)) * 100),",
               "       dema028 = (dema014 - dema023),",
               "       dema029 = (dema015 - dema024),",
               "       dema030 = (dema016 - dema025),",
               "       dema031 = (dema017 - dema026),",
               "       dema032 = (dema018 - dema027)"
   PREPARE adep600_pre12 FROM g_sql
   EXECUTE adep600_pre12
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Upd adep600_tmp03"   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL adep600_ins_data(ls_js)
#                  RETURNING r_success
# Input parameter: ls_js
# Return code....: r_success      True/False
# Date & Author..: 2014/07/11 By pomelo
# Modify.........:
################################################################################
PUBLIC FUNCTION adep600_ins_data(ls_js)
DEFINE ls_js       STRING
DEFINE r_success   LIKE type_t.num5
DEFINE lc_param    type_parameter
DEFINE l_msg       STRING
DEFINE l_dembsite  LIKE demb_t.dembsite
DEFINE l_demb002   LIKE demb_t.demb002
DEFINE l_demc005   DATETIME YEAR TO SECOND
#DEFINE l_dema      RECORD LIKE dema_t.*   #161104-00002#3 Mark By Ken 161105
#161104-00002#3 Add By Ken 161105(S)
DEFINE l_dema RECORD  #經銷商日銷售統計檔
       demaent LIKE dema_t.demaent, #企業編號
       demasite LIKE dema_t.demasite, #營運據點
       dema001 LIKE dema_t.dema001, #客戶經營類型
       dema002 LIKE dema_t.dema002, #統計日期
       dema003 LIKE dema_t.dema003, #會計週
       dema004 LIKE dema_t.dema004, #會計期
       dema005 LIKE dema_t.dema005, #經銷商編號
       dema006 LIKE dema_t.dema006, #合約編號
       dema007 LIKE dema_t.dema007, #經營方式
       dema008 LIKE dema_t.dema008, #結算類型
       dema009 LIKE dema_t.dema009, #結算方式
       dema010 LIKE dema_t.dema010, #品牌
       dema011 LIKE dema_t.dema011, #稅別編號
       dema012 LIKE dema_t.dema012, #本幣幣別
       dema013 LIKE dema_t.dema013, #進價成本金額
       dema014 LIKE dema_t.dema014, #銷貨標準售價金額(未稅)
       dema015 LIKE dema_t.dema015, #銷貨標準售價金額(含稅)
       dema016 LIKE dema_t.dema016, #銷貨折扣金額
       dema017 LIKE dema_t.dema017, #銷貨實收金額(未稅)
       dema018 LIKE dema_t.dema018, #銷貨實收金額(含稅)
       dema019 LIKE dema_t.dema019, #毛利額
       dema020 LIKE dema_t.dema020, #毛利率
       dema021 LIKE dema_t.dema021, #促銷應收金額(未稅)
       dema022 LIKE dema_t.dema022, #促銷應收金額(含稅)
       dema023 LIKE dema_t.dema023, #退貨標準售價金額(未稅)
       dema024 LIKE dema_t.dema024, #退貨標準售價金額(含稅)
       dema025 LIKE dema_t.dema025, #退貨折扣金額
       dema026 LIKE dema_t.dema026, #退貨實退金額(未稅)
       dema027 LIKE dema_t.dema027, #退貨實退金額(含稅)
       dema028 LIKE dema_t.dema028, #銷售標準售價淨額(未稅)
       dema029 LIKE dema_t.dema029, #銷售標準售價淨額(含稅)
       dema030 LIKE dema_t.dema030, #銷售折扣淨額
       dema031 LIKE dema_t.dema031, #銷售實收淨額(未稅)
       dema032 LIKE dema_t.dema032, #銷售實收淨額(含稅)
       dema033 LIKE dema_t.dema033, #訂貨標準售價金額(未稅)
       dema034 LIKE dema_t.dema034, #訂貨標準售價金額(含稅)
       dema035 LIKE dema_t.dema035, #訂貨折扣金額
       dema036 LIKE dema_t.dema036, #訂貨實收金額(未稅)
       dema037 LIKE dema_t.dema037  #訂貨實收金額(含稅)
END RECORD
#161104-00002#3 Mark By Ken 161105(E)




   LET r_success = TRUE
   CALL util.JSON.parse(ls_js,lc_param)


   
   IF lc_param.type2 = "Y" THEN
      ##經銷商單品日銷售統計檔(demb_t)
      #已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "SELECT DISTINCT a.dembsite,a.demb002",
                  "  FROM adep600_tmp03 a",     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM demb_t b",
                  "                WHERE b.dembent  = a.dembent",
                  "                  AND b.dembsite = a.dembsite",
                  "                  AND b.demb002  = a.demb002)",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent  = a.dembent",
                  "                      AND c.dembsite = a.dembsite",
                  "                      AND c.demb002  = a.demb002)"
      PREPARE adep600_pre13 FROM g_sql
      DECLARE adep600_curs13 CURSOR FOR adep600_pre13

      FOREACH adep600_curs13 INTO l_dembsite,l_demb002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Foreach adep600_curs13"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_msg = l_dembsite,'/',l_demb002
         #重新結轉 經銷商單品日銷售統計檔(demb_t)！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00052"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_dembsite
         LET g_errparam.columns[2] = "lbl_demb002"
         LET g_errparam.values[2] = l_demb002
         CALL cl_err()
      END FOREACH
      
      #刪除已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "DELETE FROM demb_t a ",
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM adep600_tmp03 b ",   #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
                  "                WHERE b.dembent = a.dembent ",
                  "                  AND b.dembsite = a.dembsite ",
                  "                  AND b.demb002 = a.demb002) ",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent = a.dembent ",
                  "                      AND c.dembsite = a.dembsite",
                  "                      AND c.demb002  = a.demb002)"
      PREPARE adep600_pre14 FROM g_sql
      EXECUTE adep600_pre14
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Del demb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #塞資料
      INSERT INTO demb_t(dembent, dembsite, demb001, demb002, demb003,
                         demb004, demb005,  demb006, demb007, demb008,
                         demb009, demb010,  demb011, demb012, demb013, 
                         demb014, demb015,  demb016, demb017, demb018,
                         demb019, demb020,  demb021, demb022, demb023,
                         demb024, demb025,  demb026, demb027, demb028,
                         demb029, demb030,  demb031, demb032, demb033,
                         demb034, demb035,  demb036, demb037, demb038,
                         demb039, demb040,  demb041, demb042, demb043,
                         demb044, demb045,  demb046, demb047, demb048)
      SELECT a.dembent, a.dembsite, a.demb001, a.demb002, a.demb003,
             a.demb004, a.demb005,  a.demb006, a.demb007, a.demb008,
             a.demb009, a.demb010,  a.demb011, a.demb012, a.demb013, 
             a.demb014, a.demb015,  a.demb016, a.demb017, a.demb018,
             a.demb019, a.demb020,  a.demb021, a.demb022, a.demb023,
             a.demb024, a.demb025,  a.demb026, a.demb027, a.demb028,
             a.demb029, a.demb030,  a.demb031, a.demb032, a.demb033,
             a.demb034, a.demb035,  a.demb036, a.demb037, a.demb038,
             a.demb039, a.demb040,  a.demb041, a.demb042, a.demb043,
             a.demb044, a.demb045,  a.demb046, a.demb047, a.demb048
        FROM adep600_tmp03 a    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
       WHERE NOT EXISTS (SELECT 1
                           FROM adep600_err b
                          WHERE b.dembent = a.dembent
                            AND b.dembsite = a.dembsite
                            AND b.demb002  = a.demb002)
       
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins demb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      
      ##經銷商日銷售統計檔(dema_t)
      #已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "SELECT DISTINCT a.demasite,a.dema002",
                  "  FROM adep600_tmp04 a",    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM dema_t b",
                  "                WHERE b.demaent  = a.demaent",
                  "                  AND b.demasite = a.demasite",
                  "                  AND b.dema002  = a.dema002)",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent  = a.demaent",
                  "                      AND c.dembsite = a.demasite",
                  "                      AND c.demb002  = a.dema002)"
      PREPARE adep600_pre15 FROM g_sql
      DECLARE adep600_curs15 CURSOR FOR adep600_pre15

      FOREACH adep600_curs15 INTO l_dembsite,l_demb002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Foreach adep600_curs15"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_msg = l_dembsite,'/',l_demb002
         #重新結轉 經銷商日銷售統計檔(dema_t)！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00053"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_dembsite
         LET g_errparam.columns[2] = "lbl_demb002"
         LET g_errparam.values[2] = l_demb002
         CALL cl_err()
      END FOREACH
      
      #刪除已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "DELETE FROM dema_t a ",
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM adep600_tmp04 b ",    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
                  "                WHERE b.demaent  = a.demaent ",
                  "                  AND b.demasite = a.demasite ",
                  "                  AND b.dema002  = a.dema002) ",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent  = a.demaent ",
                  "                      AND c.dembsite = a.demasite",
                  "                      AND c.demb002  = a.dema002)"
      PREPARE adep600_pre16 FROM g_sql
      EXECUTE adep600_pre16
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Del dema_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #塞資料
      INSERT INTO dema_t(demaent, demasite,dema001, dema002, dema003,
                         dema004, dema005, dema006, dema007, dema008,
                         dema009, dema010, dema011, dema012, dema013,
                         dema014, dema015, dema016, dema017, dema018,
                         dema019, dema020, dema021, dema022, dema023,
                         dema024, dema025, dema026, dema027, dema028,
                         dema029, dema030, dema031, dema032, dema033,
                         dema034, dema035, dema036, dema037)
      SELECT a.demaent, a.demasite,a.dema001, a.dema002, a.dema003,
             a.dema004, a.dema005, a.dema006, a.dema007, a.dema008,
             a.dema009, a.dema010, a.dema011, a.dema012, a.dema013,
             a.dema014, a.dema015, a.dema016, a.dema017, a.dema018,
             a.dema019, a.dema020, a.dema021, a.dema022, a.dema023,
             a.dema024, a.dema025, a.dema026, a.dema027, a.dema028,
             a.dema029, a.dema030, a.dema031, a.dema032, a.dema033,
             a.dema034, a.dema035, a.dema036, a.dema037
        FROM adep600_tmp04 a     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
       WHERE NOT EXISTS (SELECT 1
                           FROM adep600_err b
                          WHERE b.dembent  = a.demaent
                            AND b.dembsite = a.demasite
                            AND b.demb002  = a.dema002)
       
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins demb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE
      ##經銷商單品日銷售統計檔(demb_t)
      #已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "SELECT DISTINCT a.dembsite,a.demb002",
                  "  FROM adep600_tmp03 a",    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM demb_t b",
                  "                WHERE b.dembent  = a.dembent",
                  "                  AND b.dembsite = a.dembsite",
                  "                  AND b.demb002  = a.demb002)",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent  = a.dembent",
                  "                      AND c.dembsite = a.dembsite",
                  "                      AND c.demb002  = a.demb002)"
      PREPARE adep600_pre17 FROM g_sql
      DECLARE adep600_curs17 CURSOR FOR adep600_pre17

      FOREACH adep600_curs17 INTO l_dembsite,l_demb002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Foreach adep600_curs17"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_msg = l_dembsite,'/',l_demb002
         #資料已存在 經銷商單品日銷售統計檔(demb_t)，未重新結轉！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00054"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_dembsite
         LET g_errparam.columns[2] = "lbl_demb002"
         LET g_errparam.values[2] = l_demb002
         CALL cl_err()
      END FOREACH
      
      #塞資料 排除過程中有錯誤的資料 排除已結轉資料
      INSERT INTO demb_t(dembent, dembsite, demb001, demb002, demb003,
                         demb004, demb005,  demb006, demb007, demb008,
                         demb009, demb010,  demb011, demb012, demb013, 
                         demb014, demb015,  demb016, demb017, demb018,
                         demb019, demb020,  demb021, demb022, demb023,
                         demb024, demb025,  demb026, demb027, demb028,
                         demb029, demb030,  demb031, demb032, demb033,
                         demb034, demb035,  demb036, demb037, demb038,
                         demb039, demb040,  demb041, demb042, demb043,
                         demb044, demb045,  demb046, demb047, demb048)
      SELECT a.dembent, a.dembsite, a.demb001, a.demb002, a.demb003,
             a.demb004, a.demb005,  a.demb006, a.demb007, a.demb008,
             a.demb009, a.demb010,  a.demb011, a.demb012, a.demb013, 
             a.demb014, a.demb015,  a.demb016, a.demb017, a.demb018,
             a.demb019, a.demb020,  a.demb021, a.demb022, a.demb023,
             a.demb024, a.demb025,  a.demb026, a.demb027, a.demb028,
             a.demb029, a.demb030,  a.demb031, a.demb032, a.demb033,
             a.demb034, a.demb035,  a.demb036, a.demb037, a.demb038,
             a.demb039, a.demb040,  a.demb041, a.demb042, a.demb043,
             a.demb044, a.demb045,  a.demb046, a.demb047, a.demb048
        FROM adep600_tmp03 a    #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
       WHERE NOT EXISTS (SELECT 1
                           FROM adep600_err b
                          WHERE b.dembent  = a.dembent
                            AND b.dembsite = a.dembsite
                            AND b.demb002  = a.demb002)
         AND NOT EXISTS (SELECT 1
                           FROM demb_t c
                          WHERE c.dembent  = a.dembent
                            AND c.dembsite = a.dembsite
                            AND c.demb002  = a.demb002)
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins demb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      
      ##經銷商日銷售統計檔(dema_t)
      #已結轉資料 排除過程中有錯誤的資料
      LET g_sql = "SELECT DISTINCT a.demasite,a.dema002",
                  "  FROM adep600_tmp04 a",     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
                  " WHERE EXISTS (SELECT 1",
                  "                 FROM dema_t b",
                  "                WHERE b.demaent  = a.demaent",
                  "                  AND b.demasite = a.demasite",
                  "                  AND b.dema002  = a.dema002)",
                  "   AND NOT EXISTS (SELECT 1",
                  "                     FROM adep600_err c",
                  "                    WHERE c.dembent  = a.demaent",
                  "                      AND c.dembsite = a.demasite",
                  "                      AND c.demb002  = a.dema002)"
      PREPARE adep600_pre18 FROM g_sql
      DECLARE adep600_curs18 CURSOR FOR adep600_pre18

      FOREACH adep600_curs18 INTO l_dembsite,l_demb002
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "Foreach adep600_curs18"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         LET l_msg = l_dembsite,'/',l_demb002
         #資料已存在 經銷商日銷售統計檔(dema_t)，未重新結轉！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "ade-00055"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.columns[1] = "lbl_dembsite"
         LET g_errparam.values[1] = l_dembsite
         LET g_errparam.columns[2] = "lbl_demb002"
         LET g_errparam.values[2] = l_demb002
         CALL cl_err()
      END FOREACH
      
      #161104-00002#3 Mark By Ken 161105(S)
      #DECLARE curs1 CURSOR FOR
      #   SELECT *
      #     FROM adep600_tmp04 a        #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
      #161104-00002#3 Mark By Ken 161105(E)
      #161104-00002#3 Add By Ken 161105(S)
      DECLARE curs1 CURSOR FOR
         SELECT demaent  ,      demasite ,      dema001  ,      dema002  ,      dema003  ,
                dema004  ,      dema005  ,      dema006  ,      dema007  ,      dema008  ,
                dema009  ,      dema010  ,      dema011  ,      dema012  ,      dema013  ,
                dema014  ,      dema015  ,      dema016  ,      dema017  ,      dema018  ,
                dema019  ,      dema020  ,      dema021  ,      dema022  ,      dema023  ,
                dema024  ,      dema025  ,      dema026  ,      dema027  ,      dema028  ,
                dema029  ,      dema030  ,      dema031  ,      dema032  ,      dema033  ,
                dema034  ,      dema035  ,      dema036  ,      dema037  
           FROM adep600_tmp04 a        #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04           
      #161104-00002#3 Add By Ken 161105(E)
       WHERE NOT EXISTS (SELECT 1
                           FROM adep600_err b
                          WHERE b.dembent  = a.demaent
                            AND b.dembsite = a.demasite
                            AND b.demb002  = a.dema002)
         AND NOT EXISTS (SELECT 1
                           FROM dema_t c
                          WHERE c.demaent  = a.demaent
                            AND c.demasite = a.demasite
                            AND c.dema002  = a.dema002) 
      #FOREACH curs1 INTO l_dema.*   #161104-00002#3 Mark By Ken 161105
      #161104-00002#3 Add By Ken 161105(S)
      FOREACH curs1 INTO l_dema.demaent   ,   l_dema.demasite  ,   l_dema.dema001   ,   l_dema.dema002   ,   l_dema.dema003   ,
                         l_dema.dema004   ,   l_dema.dema005   ,   l_dema.dema006   ,   l_dema.dema007   ,   l_dema.dema008   ,
                         l_dema.dema009   ,   l_dema.dema010   ,   l_dema.dema011   ,   l_dema.dema012   ,   l_dema.dema013   ,
                         l_dema.dema014   ,   l_dema.dema015   ,   l_dema.dema016   ,   l_dema.dema017   ,   l_dema.dema018   ,
                         l_dema.dema019   ,   l_dema.dema020   ,   l_dema.dema021   ,   l_dema.dema022   ,   l_dema.dema023   ,
                         l_dema.dema024   ,   l_dema.dema025   ,   l_dema.dema026   ,   l_dema.dema027   ,   l_dema.dema028   ,
                         l_dema.dema029   ,   l_dema.dema030   ,   l_dema.dema031   ,   l_dema.dema032   ,   l_dema.dema033   ,
                         l_dema.dema034   ,   l_dema.dema035   ,   l_dema.dema036   ,   l_dema.dema037   
      #161104-00002#3 Add By Ken 161105(E)
         LET l_msg = ''
      END FOREACH
      
      
      #塞資料 排除過程中有錯誤的資料 排除已結轉資料
      INSERT INTO dema_t(demaent, demasite,dema001, dema002, dema003,
                         dema004, dema005, dema006, dema007, dema008,
                         dema009, dema010, dema011, dema012, dema013,
                         dema014, dema015, dema016, dema017, dema018,
                         dema019, dema020, dema021, dema022, dema023,
                         dema024, dema025, dema026, dema027, dema028,
                         dema029, dema030, dema031, dema032, dema033,
                         dema034, dema035, dema036, dema037)
      SELECT a.demaent, a.demasite,a.dema001, a.dema002, a.dema003,
             a.dema004, a.dema005, a.dema006, a.dema007, a.dema008,
             a.dema009, a.dema010, a.dema011, a.dema012, a.dema013,
             a.dema014, a.dema015, a.dema016, a.dema017, a.dema018,
             a.dema019, a.dema020, a.dema021, a.dema022, a.dema023,
             a.dema024, a.dema025, a.dema026, a.dema027, a.dema028,
             a.dema029, a.dema030, a.dema031, a.dema032, a.dema033,
             a.dema034, a.dema035, a.dema036, a.dema037
        FROM adep600_tmp04 a      #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_dema_sum ——> adep600_tmp04
       WHERE NOT EXISTS (SELECT 1
                           FROM adep600_err b
                          WHERE b.dembent  = a.demaent
                            AND b.dembsite = a.demasite
                            AND b.demb002  = a.dema002)
         AND NOT EXISTS (SELECT 1
                           FROM dema_t c
                          WHERE c.demaent  = a.demaent
                            AND c.demasite = a.demasite
                            AND c.dema002  = a.dema002) 
      IF SQLCA.SQLcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins demb_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #寫入經銷商日結記錄檔(demc_t)
   LET l_demc005 = cl_get_current()
   #新增不存在log檔的資料
   LET g_sql = "INSERT INTO demc_t(demcent,demcsite,demc001,demc002,",
               "                   demc003,demc004,demc005)",
               "SELECT DISTINCT a.dembent,a.dembsite,a.demb002,'",g_prog,"',",
               "                '0',     '",g_user,"',''",
               "  FROM adep600_tmp03 a",     #160727-00019#9   16/08/2 By 08734 临时表长度超过15码的减少到15码以下 adep600_demb_sum ——> adep600_tmp03
               " WHERE NOT EXISTS (SELECT 1",
               "                     FROM adep600_err b",
               "                    WHERE b.dembent  = a.dembent",
               "                      AND b.dembsite = a.dembsite",
               "                      AND b.demb002  = a.demb002)",
               "   AND NOT EXISTS (SELECT 1",
               "                     FROM demc_t",
               "                    WHERE demcent  = a.dembent",
               "                      AND demcsite = a.dembsite",
               "                      AND demc001  = a.demb002)"
   PREPARE adep600_pre19 FROM g_sql
   EXECUTE adep600_pre19
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins demc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #更新存在log檔的資料
   UPDATE demc_t SET demc003 = demc003 + 1,
                     demc004 = g_user,
                     demc005 = l_demc005
    WHERE NOT EXISTS (SELECT 1
                        FROM adep600_err b
                       WHERE b.dembent  = demcent
                         AND b.dembsite = demcsite
                         AND b.demb002  = demc001)
      AND EXISTS (SELECT 1
                    FROM demc_t a
                   WHERE a.demcent  = demcent
                     AND a.demcsite = demcsite
                     AND a.demc001  = demc001)
      AND demc002 = g_prog
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Upd demc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF

   #告知使用者哪些資料是結轉失敗的
   LET g_sql = "SELECT DISTINCT dembsite,demb002",
               "  FROM adep600_err"
   PREPARE adep600_pre20 FROM g_sql
   DECLARE adep600_curs20 CURSOR FOR adep600_pre20
   
   FOREACH adep600_curs20 INTO l_dembsite,l_demb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Foreach adep600_curs20"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_msg = l_dembsite,'/',l_demb002
      #此銷售組織+日結日期 結轉失敗！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "ade-00056"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.columns[1] = "lbl_dembsite"
      LET g_errparam.values[1] = l_dembsite
      LET g_errparam.columns[2] = "lbl_demb002"
      LET g_errparam.values[2] = l_demb002
      CALL cl_err()
   END FOREACH
   
   RETURN r_success
   
END FUNCTION

#end add-point
 
{</section>}
 
