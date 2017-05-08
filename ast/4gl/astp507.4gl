#該程式未解開Section, 採用最新樣板產出!
{<section id="astp507.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2015-08-15 01:11:48), PR版次:0004(2017-01-22 16:26:45)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: astp507
#+ Description: 專櫃促銷保底成本與促銷目標銷售成本批次產生作業
#+ Creator....: 02159(2015-07-27 14:07:08)
#+ Modifier...: 02159 -SD/PR- 06189
 
{</section>}
 
{<section id="astp507.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161024-00025#11   2016/10/28  by 08742         组织开窗调整
#170122-00004#2    2017/01/22 by geza       调整系统中无ENT的SQL条件增加ent
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
        pregsite          LIKE type_t.chr500,
        prei003           LIKE prei_t.prei003,
        prei004           LIKE prei_t.prei004,
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
       pregsite LIKE type_t.chr500, 
   prei003 LIKE prei_t.prei003, 
   prei004 LIKE prei_t.prei004, 
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
 
{<section id="astp507.main" >}
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
   #LET l_success = ''                                       #161024-00025#11   2016/10/28  by 08742  mark
   #CALL s_aooi500_create_temp() RETURNING l_success         #161024-00025#11   2016/10/28  by 08742  mark
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp507_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp507 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp507_init()
 
      #進入選單 Menu (="N")
      CALL astp507_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp507
   END IF
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success  
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp507.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp507_init()
 
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
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp507.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp507_ui_dialog()
 
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
         INPUT BY NAME g_master.pregsite,g_master.l_date,g_master.l_del 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pregsite
            #add-point:BEFORE FIELD pregsite name="input.b.pregsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pregsite
            
            #add-point:AFTER FIELD pregsite name="input.a.pregsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pregsite
            #add-point:ON CHANGE pregsite name="input.g.pregsite"
            
            #END add-point 
 
 
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
 
 
 
                     #Ctrlp:input.c.pregsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pregsite
            #add-point:ON ACTION controlp INFIELD pregsite name="input.c.pregsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pregsite',g_site,'c')
            CALL q_ooef001_24()
            LET g_master.pregsite = g_qryparam.return1
            DISPLAY BY NAME g_master.pregsite
            NEXT FIELD pregsite                     #返回原欄位  
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
         CONSTRUCT BY NAME g_master.wc ON prei003,prei004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.prei003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prei003
            #add-point:ON ACTION controlp INFIELD prei003 name="construct.c.prei003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " inaa135='2'" #促銷庫區
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prei003  #顯示到畫面上
            NEXT FIELD prei003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prei003
            #add-point:BEFORE FIELD prei003 name="construct.b.prei003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prei003
            
            #add-point:AFTER FIELD prei003 name="construct.a.prei003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.prei004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prei004
            #add-point:ON ACTION controlp INFIELD prei004 name="construct.c.prei004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " mhae003 = '4' " #4.聯營
            CALL q_mhae001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prei004  #顯示到畫面上
            NEXT FIELD prei004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prei004
            #add-point:BEFORE FIELD prei004 name="construct.b.prei004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prei004
            
            #add-point:AFTER FIELD prei004 name="construct.a.prei004"
            
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
            CALL astp507_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            #DISPLAY g_master.pregsite TO pregsite
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
         CALL astp507_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.pregsite = g_master.pregsite   #營運組織
      LET lc_param.l_date   = g_master.l_date
      LET lc_param.l_del    = g_master.l_del
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
                 CALL astp507_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp507_transfer_argv(ls_js)
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
 
{<section id="astp507.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp507_transfer_argv(ls_js)
 
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
 
{<section id="astp507.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp507_process(ls_js)
 
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
#  DECLARE astp507_process_cs CURSOR FROM ls_sql
#  FOREACH astp507_process_cs INTO
   #add-point:process段process name="process.process"
   LET l_success = ''
   CALL astp507_create_temp() RETURNING l_success
   
   #取得組織與會計期間
   LET l_success = ''
   CALL astp507_get_org_scope(ls_js) RETURNING l_success    
   IF NOT l_success THEN
      RETURN
   END IF
   #存取資料
   LET l_success = ''
   CALL astp507_get_data(ls_js) RETURNING l_success
   IF NOT l_success THEN
      RETURN
   END IF   
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   LET l_success = ''
   CALL astp507_process1(ls_js) RETURNING l_success
   
   CALL cl_err_collect_show()
   IF l_success THEN
      CALL s_transaction_end('Y','1') 
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   LET l_success = ''
   CALL astp507_drop_temp() RETURNING l_success
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
   CALL astp507_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp507.get_buffer" >}
PRIVATE FUNCTION astp507_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.pregsite = p_dialog.getFieldBuffer('pregsite')
   LET g_master.l_date = p_dialog.getFieldBuffer('l_date')
   LET g_master.l_del = p_dialog.getFieldBuffer('l_del')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp507.msgcentre_notify" >}
PRIVATE FUNCTION astp507_msgcentre_notify()
 
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
 
{<section id="astp507.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 建立暫存檔
# Memo...........:
# Usage..........: CALL astp507_create_temp()
#                  RETURNING r_success
# Return Code....: r_success   處理結果
# Date & Author..: 2015/07/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astp507_create_temp()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_err_cnt      LIKE type_t.num5
   DEFINE l_session      LIKE type_t.num10 #test

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   
   #查詢session編號
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "[astp507_create_temp_session_id] ",l_session
   
   #組織會計週期日起訖
   CREATE TEMP TABLE astp507_org(
      ooef001      LIKE ooef_t.ooef001,      #ooef001   營運組織
      ooef017      LIKE ooef_t.ooef017,      #ooef017   法人
      glaald       LIKE glaa_t.glaald,       #glaald    法人主帳套
      glaa003      LIKE glaa_t.glaa003,      #glaa003   主帳套的會計期參照表
      acc_year     LIKE glav_t.glav002,      #acc_year  會計年度
      acc_mon      LIKE glav_t.glav006,      #acc_mon   會計期別
      pdate_s      LIKE glav_t.glav004,      #pdate_s   會計期起始日
      pdate_e      LIKE glav_t.glav004,      #pdate_e   會計期結束日
      c_date       LIKE type_t.dat,          #cdate     關帳日期
      acc_flag     LIKE type_t.chr1)         #acc_flag  結算結束日是否小於關帳日期,Y=大於關帳日不可結算, N=小於關帳日可結算
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create astp507_org:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF

   #門店日結資料
   CREATE TEMP TABLE astp507_debc(
      debcsite       LIKE debc_t.debcsite,      #debcsite     門店編號
      debc010        LIKE debc_t.debc010,       #debc010      專櫃編號
      debc005        LIKE debc_t.debc005,       #debc005      庫區編號(促銷庫區) 
      debc006        LIKE debc_t.debc006,       #debc006      庫區類型   
      debc013        LIKE debc_t.debc013,       #debc013      銷售數量 
      debc018        LIKE debc_t.debc018,       #debc018      應收金額
      debc020        LIKE debc_t.debc020,       #debc020      實收金額
      debc002        LIKE debc_t.debc002,       #debc002      統計日期
      preg001        LIKE preg_t.preg001,       #preg001      促銷規則編號
      counter_acc    LIKE stga_t.stga015)       #counter_acc  庫區是否已結轉
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create astp507_debc:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF
   
   #取得促銷談判資料
   CREATE TEMP TABLE astp507_preg(
      pregsite      LIKE preg_t.pregsite,       #pregsite  營運組織
      preg001       LIKE preg_t.preg001 ,       #preg001   規則編號
      pregpstdt     LIKE preg_t.pregpstdt,      #pregpstdt 資料發布日期
      preiseq       LIKE prei_t.preiseq ,       #preiseq   項次 
      prei003       LIKE prei_t.prei003 ,       #prei003   庫區編號  
      prei004       LIKE prei_t.prei004 ,       #prei004   專櫃編號  
      prei057       LIKE prei_t.prei057 ,       #prei057   合同扣率
      prei058       LIKE prei_t.prei058 ,       #prei058   明細-執行扣率
      prei061       LIKE prei_t.prei061 ,       #prei061   分量扣點方式
      prejseq1      LIKE prej_t.prejseq1,       #prejseq1  條件項次
      prejseq       LIKE prej_t.prejseq ,       #prejseq   保底項次
      prej002       LIKE prej_t.prej002 ,       #prej002   促銷保底-庫區編號 
      prej003       LIKE prej_t.prej003 ,       #prej003   促銷保底-專櫃編號
      prej004       LIKE prej_t.prej004 ,       #prej004   類型1.保底2.目標銷售
      prej005       LIKE prej_t.prej005 ,       #prej005   截止金額
      prej006       LIKE prej_t.prej006 ,       #prej006   起始金額
      prej007       LIKE prej_t.prej007 ,       #prej007   促銷-執行扣率      
      preh003       LIKE preh_t.preh003 ,       #preh003   開始日期 
      preh004       LIKE preh_t.preh004         #preh004   結束日期
   )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'astp507_preg:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      LET l_err_cnt = l_err_cnt + 1
   END IF   
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除暫存檔
# Memo...........:
# Usage..........: CALL astp507_drop_temp()
#                  RETURNING r_success
# Return Code....: r_success   處理結果
# Date & Author..: 2015/07/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astp507_drop_temp()
   DEFINE r_success      LIKE type_t.num5
   DEFINE l_err_cnt      LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   LET l_err_cnt = 0

   DROP TABLE astp507_org
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Drop astp507_org:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF
   
   DROP TABLE astp507_debc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Drop astp507_debc:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF

   DROP TABLE astp507_preg
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Drop astp507_preg:'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET l_err_cnt = l_err_cnt + 1
   END IF
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得批次處理的營運組織範圍,組織的關帳日期,組織的會計週期資訊
# Memo...........:
# Usage..........: CALL astp507_get_org_scope(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/07/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astp507_get_org_scope(ls_js)
   DEFINE ls_js         STRING
   DEFINE r_success     LIKE type_t.num5
   DEFINE lc_param      type_parameter
   DEFINE l_err_cnt     LIKE type_t.num5
   DEFINE l_sql         STRING   
   DEFINE l_where       STRING
   DEFINE l_org_where   STRING
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE l_ooef017     LIKE ooef_t.ooef017
   DEFINE l_glaald      LIKE glaa_t.glaald
   DEFINE l_glaa003     LIKE glaa_t.glaa003
   DEFINE l_acc_year    LIKE glav_t.glav002
   DEFINE l_acc_mon     LIKE glav_t.glav006
   DEFINE l_pdate_s     LIKE glav_t.glav004
   DEFINE l_pdate_e     LIKE glav_t.glav004
   DEFINE l_cdate_1     LIKE type_t.dat
   DEFINE l_cdate_2     LIKE type_t.dat
   DEFINE l_acc_flag    LIKE type_t.chr1
   DEFINE l_cnt         LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   #取得本次要結算(有促銷談判)的組織範圍和組織的前一會計週期起訖日
   #組織範圍取得方式:
   #(1)取有效的組織
   #(2)依(1)取得的組織篩選,需符促銷談判組織
   #   取促銷談判時依輸入條件篩選:營運組織(lc_param.pregsite)/專櫃/庫區
   #(3)取促銷談判的組織時,須依aooi500設定取得組織範圍並進行篩選
   #帳套,會計期參照表取得方式:
   #(1)取得組織所屬的法人ooef017
   #(2)依法人取得主帳套glaald,會計期參照表glaa003
   #會計日期起迄取得方式:
   #(1)依統計日期(lc_param.l_date)取出所屬的會計期參照表t2.glav001,會計年度t2.acc_year, 期別t2.acc_mon
   #(2)依(1)取同會計期參照表中的前一會計週期的年度acc_year, 期別acc_mon
   #   IF    t2.acc_mon = 1, 則前一週期的 年度t1.acc_year = t2.acc_year-1, 期別t1.acc_mon = 12 
   #   ELSE                  則前一週期的 年度t1.acc_year = t2.acc_year,   期別t1.acc_mon = t2.acc_mon-1 
   
   LET l_where = s_aooi500_sql_where(g_prog,"pregsite")
   LET l_org_where = lc_param.pregsite
   
   #批次輸入條件,字串轉換
   IF NOT cl_null(l_org_where) THEN
      LET l_org_where = cl_replace_str(l_org_where,"|","','")   
      LET l_org_where = "stfasite IN ('",l_org_where,"') "
   ELSE
      LET l_org_where = "1=1"
   END IF
   
   LET l_sql = "SELECT UNIQUE ooef001,ooef017,glaald,glaa003, ",     #組織編號,法人編號,法人主帳套,會計期參照表
               "              acc_year,acc_mon,pdate_s,pdate_e ",    #會計年度,會計期別,會計期間起始日期,會計期間結束日期
               "  FROM ooef_t, ",
               "       glaa_t ",
               "          LEFT JOIN (SELECT t1.glavent,t1.glav001,t1.glav002 acc_year,t1.glav006 acc_mon, ",
               "                            MIN (t1.glav004) pdate_s,MAX (t1.glav004) pdate_e ",
               "                       FROM glav_t t1 ",
               "                      WHERE EXISTS (SELECT 1 ",
               "                                      FROM (SELECT glavent,glav001, ",
               "                                                  (CASE WHEN glav006 = 1 THEN glav002 - 1 ",
               "                                                        ELSE glav002 ",
               "                                                    END) acc_year, ",
               "                                                  (CASE WHEN glav006 = 1 THEN 12 ",
               "                                                        ELSE glav006 - 1 ",
               "                                                    END) acc_mon ",
               "                                              FROM glav_t ",
               "                                             WHERE glav004 = '",lc_param.l_date,"' ",
               "                                               AND glavent = ",g_enterprise," ", #add by geza 20170122 #170122-00004#2 
               "                                           ) t2 ",
               "                                     WHERE t1.glavent = t2.glavent  AND t1.glav001 = t2.glav001 ",
               "                                       AND t1.glav002 = t2.acc_year AND t1.glav006 = t2.acc_mon ",
               "                                   ) ",
               "                      GROUP BY t1.glavent,t1.glav001,t1.glav002,t1.glav006) ",
               "                 ON glavent = glaaent AND glav001 = glaa003 ",
               "     WHERE ooefent = glaaent ",
               "       AND ooef017 = glaacomp ",
               "       AND ooefent = ",g_enterprise,
               "       AND ooefstus = 'Y' ",
               "       AND glaa014 = 'Y' ",
               "       AND EXISTS(SELECT UNIQUE 1 FROM preg_t,prei_t,prej_t ",
			      "                   WHERE pregent = ooefent AND pregsite = ooef001 ",
			      "                     AND pregent = preient AND preg001 = prei001 ",
			      "                     AND pregent = prejent AND preiseq = prejseq1 ",
			      "                     AND prei001 = prej001 AND prei081 IN ('1','2') ",
			      "                     AND prejacti = 'Y'    AND pregstus IN ('Y','F') ",
               "                     AND ",lc_param.wc,   #篩選輸入的營運組織&專櫃&庫區
               "                     AND ",l_where,")"    #篩選aooi500設定的組織
   PREPARE astp507_get_org_pre FROM l_sql
   DECLARE astp507_get_org_cur CURSOR FOR astp507_get_org_pre
   DISPLAY "[astp507_get_org_cur] SQL:",l_sql
   
   #寫入暫存檔
   LET l_sql = "INSERT INTO astp507_org(ooef001,ooef017,glaald,glaa003,acc_year,acc_mon, ",
               "                        pdate_s,pdate_e,c_date,acc_flag) ",
               "     VALUES(?,?,?,?,?,   ?,?,?,?,?) "
   PREPARE astp507_ins_org_tmp FROM l_sql
   
   FOREACH astp507_get_org_cur INTO l_ooef001,l_ooef017,l_glaald,l_glaa003,
                                    l_acc_year,l_acc_mon,l_pdate_s,l_pdate_e

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'astp507_get_org_cur'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         LET l_err_cnt = l_err_cnt + 1
      END IF
      
      LET l_cdate_1 = ''
      LET l_cdate_2 = ''          

      
      LET l_cdate_1 = cl_get_para(g_enterprise,l_ooef001,"S-CIR-0001")   #門店日結關賬日期
      LET l_cdate_2 = cl_get_para(g_enterprise,l_ooef001,"S-MFG-0031")   #取得組織庫存關帳日
      
      IF cl_null(l_cdate_1) THEN
         LET l_cdate_1 = g_today
      END IF
      
      IF cl_null(l_cdate_2) THEN
         LET l_cdate_2 = g_today
      END IF      
      
      IF l_pdate_e < l_cdate_1 OR l_pdate_e > l_cdate_2 THEN
         LET l_acc_flag = 'Y'
      ELSE
         LET l_acc_flag = 'N'
      END IF      
      
      DISPLAY "Org: ",l_ooef001," ,Process Date: ",l_pdate_s," - ",l_pdate_e      
      
      #寫入暫存檔
      EXECUTE astp507_ins_org_tmp USING l_ooef001 ,l_ooef017,l_glaald ,l_glaa003,
                                        l_acc_year,l_acc_mon,l_pdate_s,l_pdate_e,
                                        l_cdate_2 ,l_acc_flag
      IF SQLCA.sqlcode THEN
         DISPLAY "[astp507_ins_org_tmp] ERROR: (",l_ooef001," , ",l_acc_year," , ",l_acc_mon,")",SQLCA.sqlerrd[2]
         LET l_err_cnt = l_err_cnt + 1
      END IF      
   END FOREACH
   
   #背景訊息提示##
   LET l_cnt = 0 
   SELECT COUNT(*) INTO l_cnt FROM astp507_org WHERE acc_flag = 'N'
   DISPLAY "[astp507_org] PROCESS ROWS: ",l_cnt   
   ##############
   
   IF l_err_cnt > 0 THEN
      LET r_success = FALSE
   END IF
   
   #test
   DISPLAY "[astp507_ins_org_tmp] SQL:",l_sql
   SELECT COUNT(*) INTO l_cnt FROM astp507_org
   DISPLAY 'test:',l_cnt
   #test
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 取得批次處理的相關資料
# Memo...........:
# Usage..........: CALL astp507_get_data(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/07/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astp507_get_data(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        LIKE type_t.num5
   DEFINE lc_param         type_parameter
   DEFINE l_err_cnt        LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_wc             STRING
   DEFINE l_wc1            STRING
   DEFINE l_prej002        LIKE prej_t.prej002   #庫區
   DEFINE l_prej003        LIKE prej_t.prej003   #專櫃
   DEFINE l_preg001        LIKE preg_t.preg001   #促銷規則編號
   DEFINE l_preh003        LIKE preh_t.preh003   #促銷-起始日期
   DEFINE l_preh004        LIKE preh_t.preh004   #促銷-結束日期
   
   LET r_success = TRUE
   LET l_err_cnt = 0
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   
   #2.取得促銷談判資料
   LET l_wc = ''
   LET l_wc  = cl_replace_str(lc_param.wc,'prei003','prej002')        #庫區   
   LET l_wc  = cl_replace_str(l_wc,'prei004','prej003')               #專櫃
   
   LET l_sql = "INSERT INTO astp507_preg(pregsite,preg001 ,pregpstdt ,preiseq   ,prei003 , ",
               "                         prei004 ,prei057 ,prei058   ,prei061   ,prejseq1, ",
               "                         prejseq ,prej002 ,prej003   ,prej004   ,prej005 , ",
               "                         prej006 ,prej007 ,preh003 ,preh004) ",
               "SELECT pregsite,preg001 ,pregpstdt ,preiseq  ,prei003 , ",
               "       prei004 ,prei057 ,prei058   ,prei061  ,prejseq1, ",
               "       prejseq ,prej002 ,prej003   ,prej004  ,prej005 , ",
               "       prej006 ,prej007 ,preh003 ,preh004 ",               
               "  FROM preg_t,prei_t,prej_t,preh_t ",
               " WHERE pregent = preient ",
               "   AND preg001 = prei001 ",
               "   AND prei081 = '1' ",           #促銷狀態1.已發佈
               "   AND pregent = prejent ",
               "   AND preiseq = prejseq1 ",
               "   AND prei001 = prej001 ",
               "   AND prejacti = 'Y' ",         #有效否
               "   AND prej004 IN ('1','2')",    #類型1.保底2.目標銷售
               "   AND pregent = prehent ",
               "   AND preg001 = preh001 ",
               "   AND pregstus IN ('Y','F') ",  #狀態碼Y.確認F.已發出
               "   AND pregent = ",g_enterprise,
               "   AND ",l_wc,
               "   AND EXISTS(SELECT 1 FROM astp507_org ",         #促銷日期介於結算的會計週期
               "               WHERE ooef001 = pregsite ",
               "                 AND preh004 BETWEEN pdate_s AND pdate_e) ",   #促銷結束日期要介於會計期間的促銷單
               "   ORDER BY pregpstdt DESC "
               
   PREPARE astp507_preg_ins FROM l_sql
   EXECUTE astp507_preg_ins
   DISPLAY "[astp507_preg_ins] SQL:",l_sql
   DISPLAY "[astp507_preg_ins] CNT:",SQLCA.SQLERRD[3]

   
   #3.取得門店日結資料
   #以促銷單最新一筆的起,迄日期抓取銷售資料
   DECLARE astp507_prej002 CURSOR WITH HOLD FOR 
    SELECT DISTINCT prej002,prej003 FROM astp507_preg
    
   FOREACH astp507_prej002 INTO l_prej002,l_prej003   #庫區,專櫃
      
      LET l_sql = " SELECT preg001,preh003,preh004 ",
                  "   FROM astp507_preg ",
                  "  WHERE prej002 = ? ", #庫區
                  "    AND prej003 = ? ", #專櫃
                  "  ORDER BY pregpstdt DESC "
                  
      PREPARE astp507_preg_max_prep FROM l_sql
      DECLARE astp507_preg_max_cs SCROLL CURSOR FOR astp507_preg_max_prep
      OPEN astp507_preg_max_cs USING l_prej002,l_prej003
      
      FETCH FIRST astp507_preg_max_cs INTO l_preg001,l_preh003,l_preh004
        
        LET l_sql = "INSERT INTO astp507_debc( debcsite, debc010, debc005, ",    
                    "                          debc006,  debc013, debc018, ",
                    "                          debc020,  debc002, preg001, ",
                    "                          counter_acc) ",
                    "     SELECT debcsite,debc010,debc005, ",                    #門店編號,專櫃編號,庫區編號
                    "            debc006,debc013,debc018, ",                     #庫區類型銷售數量,應收金額,
                    "            debc020,debc002,'",l_preg001,"',",              #實收金額,統計日期,庫區是否已結轉,促銷規則編號
                    "            'N' ",
                    "       FROM debc_t,inaa_t ",    
                    "      WHERE debcent = inaaent ",                                  
                    "        AND debcsite = inaasite ",                                  
                    "        AND debc005 = inaa001 ", 
                    "        AND inaa135 = '2' ",                                #2.促銷庫區			   
                    "        AND debcent = ",g_enterprise,
                    "        AND debc005 = '",l_prej002,"'",                     #庫區
                    "        AND debc010 = '",l_prej003,"'",                     #專櫃
                    "        AND debc002 BETWEEN '",l_preh003,"' AND '",l_preh004,"'",
                    "      ORDER BY debc002 "
                    
                    
        PREPARE astp507_debc_ins FROM l_sql
        EXECUTE astp507_debc_ins
        DISPLAY "[astp507_debc_ins] SQL:",l_sql
        DISPLAY "[astp507_debc_ins] CNT:",SQLCA.SQLERRD[3]
   END FOREACH
   
   #3.1.更新庫區目前的結算情況:是否有已結轉的庫區資料
   LET l_sql = "UPDATE astp507_debc ",
               "   SET counter_acc = 'Y' ",
               " WHERE debc005 IN (SELECT stga003 FROM stga_t ",
               "                    WHERE stgaent = ",g_enterprise,
               "                      AND stga013 IN ('9','10') ",    #成本類型9.促銷保底10.促銷目標
               "                      AND stga015 = 'Y' ",            #已結轉
               "                   ) "
   PREPARE astp507_debc_upd FROM l_sql
   EXECUTE astp507_debc_upd
   DISPLAY "[astp507_debc_upd] SAL:",l_sql
   DISPLAY "[astp507_debc_upd] CNT:",SQLCA.SQLERRD[3]
   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 促銷保底成本與促銷目標銷售成本批次處理
# Memo...........:
# Usage..........: CALL astp507_process1(ls_js)
#                  RETURNING r_success
# Input Parameter: ls_js
# Return code....: r_success      處理結果
# Date & Author..: 2015/07/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION astp507_process1(ls_js)
   DEFINE ls_js            STRING
   DEFINE r_success        LIKE type_t.num5
   DEFINE lc_param         type_parameter
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_sql            STRING         
   DEFINE l_sql2           STRING
   DEFINE l_msg            STRING
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_preh003        LIKE preh_t.preh003
   DEFINE l_preh004        LIKE preh_t.preh004
   DEFINE l_prej002        LIKE prej_t.prej002
   DEFINE l_preg       RECORD
            pregsite       LIKE preg_t.pregsite,
            preg001        LIKE preg_t.preg001,
            preiseq        LIKE prei_t.preiseq,
            prei003        LIKE prei_t.prei003,
            prei004        LIKE prei_t.prei004,
            prei057        LIKE prei_t.prei057,
            prei058        LIKE prei_t.prei058,
            prei061        LIKE prei_t.prei061,
            prejseq1       LIKE prej_t.prejseq1,
            prej002        LIKE prej_t.prej002,
            prej003        LIKE prej_t.prej003,
            prej004        LIKE prej_t.prej004,
            preh003        LIKE preh_t.preh003,
            preh004        LIKE preh_t.preh004
                       END RECORD
   DEFINE l_debc013        LIKE debc_t.debc013 #日結-銷售數量
   DEFINE l_debc020        LIKE debc_t.debc020 #日結-實收金額
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
            stgadocno      LIKE stga_t.stgadocno            
                       END RECORD
   DEFINE l_prej       DYNAMIC ARRAY OF RECORD
            prei061        LIKE prei_t.prei061,
            prejseq        LIKE prej_t.prejseq,
            prej004        LIKE prej_t.prej004,
            prej005        LIKE prej_t.prej005,
            prej006        LIKE prej_t.prej006,
            prej007        LIKE prej_t.prej007,
            amount         LIKE debc_t.debc020
                       END RECORD
   DEFINE l_ac             LIKE type_t.num5                       
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_amount         LIKE debc_t.debc018
   DEFINE l_prej007        LIKE prej_t.prej007 #促銷執行扣率   
   DEFINE l_ooef016        LIKE ooef_t.ooef016   #150914-00002#42 2015/10/29 s983961--add 

   LET r_success = TRUE
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處   

   #已存在日結資料刪除重新計算處理
   LET l_sql = "DELETE FROM stga_t ",
               " WHERE stgaent = ",g_enterprise,
               "   AND stga013 IN ('9','10') ",
               "   AND stga001 = ? ",   #銷售日期
               "   AND stga003 = ?"            
   PREPARE astp507_del_prep1 FROM l_sql
   
   DECLARE astp507_cs1 CURSOR WITH HOLD FOR
    SELECT UNIQUE preh003,preh004,prej002 FROM astp507_preg
    
   LET l_msg = cl_getmsg('ast-00329',g_lang)   #批次檢查資料
   CALL cl_progress_no_window_ing(l_msg)
   #要檢查stga_t的資料 需要分段檢查
   FOREACH astp507_cs1 INTO l_preh003,l_preh004,l_prej002
      
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt 
        FROM astp507_debc 
       WHERE counter_acc = 'Y' 
      
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
         IF lc_param.l_del = 'Y' THEN
            EXECUTE astp507_del_prep1 USING l_preh004,l_prej002           
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'Delete stga_t'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            DISPLAY "[Delete stga_t] SQL:",l_sql
            DISPLAY "[Delete stga_t] CNT:",SQLCA.SQLERRD[3]             
         END IF            
      END IF       
   END FOREACH
   
   #促銷目標銷售
   LET l_sql = " SELECT prei061,prejseq,prej004,prej005,prej006,prej007,0 ",
               "   FROM astp507_preg ",
               "  WHERE pregsite = ?", #營運據點
               "    AND preg001 = ? ", #規則編號
               "    AND prej002 = ? ", #庫區
               "    AND prej004 = ? ", #類型1.保底2.目標銷售
               "  ORDER BY prejseq "
   PREPARE astp507_cs2_prep FROM l_sql
   DECLARE astp507_cs2 CURSOR WITH HOLD FOR astp507_cs2_prep
   
   #取日結實收金額
   LET l_sql = " SELECT SUM(COALESCE(debc013,0)),SUM(COALESCE(debc020,0)) ",
               "  FROM astp507_debc ",
               " WHERE debcsite = ? ",
               "   AND debc002 BETWEEN ? AND ? ",
               "   AND debc005 = ? ",
               "   AND debc010 = ? "
   PREPARE astp507_sum_prep1 FROM l_sql   #使用時 依序傳入 組織,起始日,截止日,庫區編號,專櫃編號
   
   LET l_msg = cl_getmsg('ast-00330',g_lang)  #批次產生資料 
   CALL cl_progress_no_window_ing(l_msg)  
   #促銷談判存在(日結資料中)
   DECLARE astp507_cs3 CURSOR WITH HOLD FOR
    SELECT UNIQUE pregsite,preg001 ,preiseq ,prei003 ,prei004 ,
                  prei057 ,prei058 ,prei061 ,prejseq1,prej002 ,
                  prej003 ,prej004 ,preh003 ,preh004
      FROM astp507_preg
      WHERE EXISTS(SELECT 1 FROM astp507_debc
                   WHERE debcsite = pregsite
                     AND debc005 = prej002
                     AND debc010 = prej003
                     AND preg001 = preg001
                     AND debc002 BETWEEN preh003 AND preh004)
      ORDER BY prej004   #類型1.保底2.目標銷售
   
   INITIALIZE l_stga.* TO NULL
   
   FOREACH astp507_cs3 INTO l_preg.pregsite,l_preg.preg001 ,l_preg.preiseq ,l_preg.prei003 ,l_preg.prei004 ,
                            l_preg.prei057 ,l_preg.prei058 ,l_preg.prei061 ,l_preg.prejseq1,l_preg.prej002 ,
                            l_preg.prej003 ,l_preg.prej004 ,l_preg.preh003 ,l_preg.preh004
     
     #取日結銷售數量,實收金額
     LET l_debc013 = 0
     LET l_debc020 = 0
     EXECUTE astp507_sum_prep1 
       USING l_preg.pregsite,l_preg.preh003,l_preg.preh004,l_preg.prej002,l_preg.prej003
        INTO l_debc013,l_debc020
        
        IF cl_null(l_debc013) THEN LET l_debc013 = 0 END IF
        IF cl_null(l_debc020) THEN LET l_debc020 = 0 END IF
     
     CALL l_prej.clear()
     LET l_ac = 1
     
     FOREACH astp507_cs2 USING l_preg.pregsite,l_preg.preg001,l_preg.prej002,l_preg.prej004
                          INTO l_prej[l_ac].prei061,l_prej[l_ac].prejseq,l_prej[l_ac].prej004,
                               l_prej[l_ac].prej005,l_prej[l_ac].prej006,l_prej[l_ac].prej007,
                               l_prej[l_ac].amount

       IF l_preg.prej004 = '1' THEN   #1.保底
          LET l_stga.stga013 = '9'
          IF l_debc020 < l_prej[l_ac].prej005 THEN
             LET l_prej[l_ac].amount = (l_debc020 - l_prej[l_ac].prej005) * l_preg.prei058/100
          ELSE
             LET l_prej[l_ac].amount = 0
          END IF          
       ELSE   #2.目標銷售
          LET l_stga.stga013 = '10'
             CASE l_prej[l_ac].prei061
                WHEN '1'  #1.分量變異
                      IF l_debc020 > l_prej[l_ac].prej006 AND l_debc020 <= l_prej[l_ac].prej005 THEN
                         LET l_prej[l_ac].amount = (l_debc020 - l_prej[l_ac].prej006) * (l_preg.prei058 - l_prej[l_ac].prej007) / 100
                      ELSE
                        IF l_debc020 > l_prej[l_ac].prej005 THEN
                           LET l_prej[l_ac].amount = (l_prej[l_ac].prej005 - l_prej[l_ac].prej006) * (l_preg.prei058 - l_prej[l_ac].prej007) / 100
                        END IF
                      END IF
                WHEN '2'  #2.全程變異
                      IF l_debc020 > l_prej[l_ac].prej006 AND l_debc020 <= l_prej[l_ac].prej005 THEN
                         LET l_prej[l_ac].amount = l_debc020 * (l_preg.prei058 - l_prej[l_ac].prej007) / 100
                      END IF
             END CASE
       END IF
       LET l_ac = l_ac + 1
     END FOREACH
     
     CALL l_prej.deleteElement(l_ac)
     LET l_ac = l_ac - 1
     
     #計算成本金額
     LET l_amount = 0 
     FOR l_i = 1 TO l_ac
        LET l_amount = l_amount + l_prej[l_i].amount         
     END FOR     
     
     LET l_stga.stgaent  = g_enterprise     
     LET l_stga.stgasite = l_preg.pregsite
     LET l_stga.stgaunit = l_preg.pregsite 
     LET l_stga.stga001  = l_preg.preh004
     LET l_stga.stga002  = ' ' 
     LET l_stga.stga003  = l_preg.prej002 #庫區
     LET l_stga.stga004  = l_preg.prej003 #專櫃

     #抓取合同:供應商編號,費用代碼
     #與aprt310抓法一致
     SELECT stfa010,stfc009 INTO l_stga.stga005,l_stga.stga006
       FROM stfa_t,stfc_t
      WHERE stfcent = g_enterprise
        AND stfcent = stfaent
        AND stfa001 = stfc001           #合同編號
        AND stfastus = 'Y'
        #AND stfa019 <= l_preg.preh003   #生效日期
        #AND stfa020 >= l_preg.preh004   #失效日期
        AND stfc002 = l_preg.prej002    #庫區
        AND stfa005 = l_preg.prej003    #專櫃
        
     LET l_stga.stga007  = l_debc013
     LET l_stga.stga008  = 0 
     LET l_stga.stga009  = 0
     
     #取執行扣率
     IF l_preg.prej004 = '1' THEN
        #SA:庫區都只會有一筆保底設定
        LET l_stga.stga010 = l_prej[l_ac].prej007        
     ELSE
        #取成本金額落在哪一區段,則抓取此區段的執行扣率
        LET l_sql = " SELECT prej007 ",
                    "   FROM astp507_preg ",
                    "  WHERE pregsite = ? ",   #營運中心
                    "    AND preg001  = ? ",   #規則編號
                    "    AND prej002  = ? ",   #庫區
                    "    AND prejseq1 = ? ",   #條件項次                 
                    "    AND ? BETWEEN prej006 AND prej005 ",   #成本金額 
                    "  ORDER BY prejseq1"
        PREPARE astp507_preg_cs3_prep FROM l_sql
        DECLARE astp507_preg_cs3 SCROLL CURSOR FOR astp507_preg_cs3_prep
        OPEN astp507_preg_cs3 USING l_preg.pregsite,l_preg.preg001,l_preg.prej002,
                                    l_preg.prejseq1,l_amount                                    
        FETCH FIRST astp507_preg_cs3 INTO l_prej007        
          LET l_stga.stga010 = l_prej007  
     END IF
     
#     LET l_stga.stga011  = 0
     LET l_stga.stga012  = l_amount 
     LET l_stga.stga013  = l_stga.stga013
     
     #add by dengdd 15/11/5(S) 
      IF l_stga.stga013 != '19' THEN 
          LET l_stga.stga011  = l_stga.stga012*(-1) 
      ELSE
          LET l_stga.stga011  = 0
      END IF
      #add by dengdd 15/11/5(E)    
        
        
     #根据费用代码从【asti203费用编码维护作业】中带出价款类型，如果取出值是“3-两者”或为空，则赋值为“1-价内”
     SELECT stae006 INTO l_stga.stga014 FROM stae_t
      WHERE staeent = g_enterprise
        AND stae001 = l_stga.stga006 
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
      IF lc_param.l_del = 'N' AND l_cnt > 0 THEN
         CONTINUE FOREACH
      END IF
       
      IF l_stga.stga012 = 0 THEN
         CONTINUE FOREACH
      ELSE
         #150914-00002#42 2015/10/29 s983961--add(s)
         #按當前幣別截取aooi150裡的用戶設置小數位 處理金額欄位
         SELECT ooef016 
           INTO l_ooef016
           FROM ooef_t 
          WHERE ooefent = g_enterprise 
            AND ooef001 = l_stga.stgasite
            
         #LET l_stga.stga011  = l_stga.stga012*(-1)      #add by dengdd 15/11/3
         
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
         #150914-00002#42 2015/10/29 s983961--add(e)
      
         INSERT INTO stga_t( stgasite, stgaunit, stga001,  stga002, stga003,
                             stga004,  stga005,  stga006,  stga007, stga008,
                             stga009,  stga010,  stga011,  stga012, stga013,
                             stga014,  stga015,  stgadocno,stgaent)
                     VALUES( l_stga.stgasite, l_stga.stgaunit, l_stga.stga001,  l_stga.stga002, l_stga.stga003,
                             l_stga.stga004,  l_stga.stga005,  l_stga.stga006,  l_stga.stga007, l_stga.stga008,
                             l_stga.stga009,  l_stga.stga010,  l_stga.stga011,  l_stga.stga012, l_stga.stga013,
                             l_stga.stga014,  l_stga.stga015,  l_stga.stgadocno,l_stga.stgaent)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'INSERT stga_t'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            EXIT FOREACH
         END IF
      END IF
        
   END FOREACH
   LET l_msg = cl_getmsg('std-00012',g_lang) #批次作業已執行完成。
   CALL cl_progress_no_window_ing(l_msg)
   
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
