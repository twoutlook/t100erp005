#該程式未解開Section, 採用最新樣板產出!
{<section id="artp231.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-08-06 18:25:43), PR版次:0006(2016-11-14 16:09:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: artp231
#+ Description: 門店資源狀態更新批次作業
#+ Creator....: 02003(2015-08-06 17:44:38)
#+ Modifier...: 02003 -SD/PR- 02481
 
{</section>}
 
{<section id="artp231.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161024-00025#9   2016/10/26  by 08742    组织开窗调整 
#161111-00028#3   2016/11/14  BY 02481    标准程式定义采用宣告模式,弃用.*写法
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
        rtap004          LIKE rtap_t.rtap004,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtaosite LIKE rtao_t.rtaosite, 
   mhae001 LIKE mhae_t.mhae001, 
   rtao001 LIKE rtao_t.rtao001, 
   exdate LIKE type_t.dat, 
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
 
{<section id="artp231.main" >}
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
   CALL cl_ap_init("art","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL artp231_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp231 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artp231_init()
 
      #進入選單 Menu (="N")
      CALL artp231_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp231
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp231.init" >}
#+ 初始化作業
PRIVATE FUNCTION artp231_init()
 
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
 
{<section id="artp231.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp231_ui_dialog()
 
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
   LET g_master.exdate = g_today
   DISPLAY BY NAME g_master.exdate 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.exdate 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD exdate
            #add-point:BEFORE FIELD exdate name="input.b.exdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD exdate
            
            #add-point:AFTER FIELD exdate name="input.a.exdate"
            IF NOT cl_null(g_master.exdate) THEN 
               IF g_master.exdate > g_today THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00380'
                  LET g_errparam.extend = g_master.exdate
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.exdate = g_today
                  NEXT FIELD CURRENT 
               END IF 
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE exdate
            #add-point:ON CHANGE exdate name="input.g.exdate"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.exdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD exdate
            #add-point:ON ACTION controlp INFIELD exdate name="input.c.exdate"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtaosite,mhae001,rtao001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtaosite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtaosite
            #add-point:ON ACTION controlp INFIELD rtaosite name="construct.c.rtaosite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c') 
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtaosite  #顯示到畫面上
            NEXT FIELD rtaosite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtaosite
            #add-point:BEFORE FIELD rtaosite name="construct.b.rtaosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtaosite
            
            #add-point:AFTER FIELD rtaosite name="construct.a.rtaosite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.mhae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mhae001
            #add-point:ON ACTION controlp INFIELD mhae001 name="construct.c.mhae001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.WHERE = " mhaestus = 'Y' "
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mhae001  #顯示到畫面上
            NEXT FIELD mhae001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mhae001
            #add-point:BEFORE FIELD mhae001 name="construct.b.mhae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mhae001
            
            #add-point:AFTER FIELD mhae001 name="construct.a.mhae001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtao001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtao001
            #add-point:ON ACTION controlp INFIELD rtao001 name="construct.c.rtao001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtao001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtao001  #顯示到畫面上
            NEXT FIELD rtao001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtao001
            #add-point:BEFORE FIELD rtao001 name="construct.b.rtao001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtao001
            
            #add-point:AFTER FIELD rtao001 name="construct.a.rtao001"
            
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
            CALL artp231_get_buffer(l_dialog)
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
         CALL artp231_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.rtap004 = g_master.exdate
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
                 CALL artp231_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = artp231_transfer_argv(ls_js)
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
 
{<section id="artp231.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION artp231_transfer_argv(ls_js)
 
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
 
{<section id="artp231.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION artp231_process(ls_js)
 
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
   DEFINE l_msg         STRING  #160225-00040# 20160303 s983961--add
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
      CALL cl_progress_bar_no_window(4)   #160225-00040# 20160303 s983961--add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE artp231_process_cs CURSOR FROM ls_sql
#  FOREACH artp231_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   IF cl_null(lc_param.rtap004) THEN 
      LET lc_param.rtap004 = g_today -1
   END IF 
   IF NOT artp231_process_1(lc_param.wc,lc_param.rtap004) THEN 
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
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
   CALL artp231_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp231.get_buffer" >}
PRIVATE FUNCTION artp231_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
 
   #end add-point
 
   
   LET g_master.exdate = p_dialog.getFieldBuffer('exdate')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="artp231.msgcentre_notify" >}
PRIVATE FUNCTION artp231_msgcentre_notify()
 
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
 
{<section id="artp231.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 执行批量处理
# Memo...........:
# Usage..........: CALL artp231_process_1()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2015/08/06 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artp231_process_1(p_wc,p_date)
DEFINE p_wc           STRING 
DEFINE p_date         LIKE rtap_t.rtap004
DEFINE l_sql          STRING 
#161111-00028#3---modify---begin---------
#DEFINE l_rtao         RECORD LIKE rtao_t.*
#DEFINE l_rtap         RECORD LIKE rtap_t.*
DEFINE l_rtao RECORD  #門店資源協議維護明細檔
       rtaoent LIKE rtao_t.rtaoent, #企業編號
       rtaounit LIKE rtao_t.rtaounit, #應用組織
       rtaosite LIKE rtao_t.rtaosite, #所屬組織
       rtaostus LIKE rtao_t.rtaostus, #狀態碼
       rtao001 LIKE rtao_t.rtao001, #資源協議編號
       rtao002 LIKE rtao_t.rtao002, #版本
       rtao003 LIKE rtao_t.rtao003, #促銷活動方案
       rtao004 LIKE rtao_t.rtao004, #談判人員
       rtao005 LIKE rtao_t.rtao005, #談判組織
       rtao006 LIKE rtao_t.rtao006, #備註
       rtaoownid LIKE rtao_t.rtaoownid, #資料所有者
       rtaoowndp LIKE rtao_t.rtaoowndp, #資料所屬部門
       rtaocrtid LIKE rtao_t.rtaocrtid, #資料建立者
       rtaocrtdp LIKE rtao_t.rtaocrtdp, #資料建立部門
       rtaocrtdt LIKE rtao_t.rtaocrtdt, #資料創建日
       rtaomodid LIKE rtao_t.rtaomodid, #資料修改者
       rtaomoddt LIKE rtao_t.rtaomoddt, #最近修改日
       rtaocnfid LIKE rtao_t.rtaocnfid, #資料確認者
       rtaocnfdt LIKE rtao_t.rtaocnfdt #資料確認日
       END RECORD
DEFINE l_rtap RECORD  #門店資源協議維護明細檔
       rtapent LIKE rtap_t.rtapent, #企業編號
       rtapsite LIKE rtap_t.rtapsite, #所屬組織
       rtapcomp LIKE rtap_t.rtapcomp, #所屬法人
       rtapseq LIKE rtap_t.rtapseq, #單據項次
       rtap001 LIKE rtap_t.rtap001, #資源協議編號
       rtap002 LIKE rtap_t.rtap002, #資源編號
       rtap003 LIKE rtap_t.rtap003, #生效日期
       rtap004 LIKE rtap_t.rtap004, #失效日期
       rtap005 LIKE rtap_t.rtap005, #本次租用資源數量
       rtap006 LIKE rtap_t.rtap006, #資源面積
       rtap007 LIKE rtap_t.rtap007, #专柜编号
       rtap008 LIKE rtap_t.rtap008, #供應商編號
       rtap009 LIKE rtap_t.rtap009, #經營類別
       rtap010 LIKE rtap_t.rtap010, #所屬部門
       rtap011 LIKE rtap_t.rtap011, #費用編號
       rtap012 LIKE rtap_t.rtap012, #納入結算單否
       rtap013 LIKE rtap_t.rtap013, #票扣否
       rtap014 LIKE rtap_t.rtap014, #價款類型
       rtap015 LIKE rtap_t.rtap015, #計算類型
       rtap016 LIKE rtap_t.rtap016, #收費標準金額
       rtap017 LIKE rtap_t.rtap017, #協議金額
       rtap018 LIKE rtap_t.rtap018, #倉庫押金
       rtap019 LIKE rtap_t.rtap019, #備註
       rtap020 LIKE rtap_t.rtap020, #協議狀態
       rtap021 LIKE rtap_t.rtap021, #下次結算日
       rtap022 LIKE rtap_t.rtap022, #下次費用開始日
       rtap023 LIKE rtap_t.rtap023, #下次費用截止日
       rtap024 LIKE rtap_t.rtap024, #租用對象
       rtap025 LIKE rtap_t.rtap025  #合約編號
       END RECORD
#161111-00028#3---modify---end---------
DEFINE l_success      LIKE type_t.num5
DEFINE l_msg          STRING  #160225-00040# 20160303 s983961--add
DEFINE l_where        STRING   #161024-00025#9   2016/10/27  by 08742  add

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'mhae001', 'rtap007')   
   
   #161024-00025#9   2016/10/27  by 08742  -S
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'rtapsite') RETURNING l_where
   LET p_wc = p_wc," AND ",l_where
   #161024-00025#9   2016/10/27  by 08742   -E
   
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   #更新资源可用数量
   LET l_sql = " MERGE INTO rtal_t ",
               " USING(            ",
               " SELECT rtapent,rtap002,rtap005 FROM rtap_t,rtao_t ",
               "  WHERE rtapent = rtaoent AND rtap001 = rtao001 ",
               "    AND rtaoent = ",g_enterprise,
               "    AND rtap020 = '2' ",
#               "    AND rtap004 <= '",p_date,"'",
               "    AND rtap004 <= '",p_date-1,"'",
               "    AND ",p_wc,
               "    ) ",
               " ON (rtalent = rtapent AND rtal001 = rtap002 ) ",
               " WHEN MATCHED THEN ",
               "   UPDATE SET rtal008 = rtal008 + rtap005, ",
#               "              rtal012 = CASE rtal006 WHEN 'Y' THEN '1' ELSE rtal012 END "   #mark by dengdd 150908
               "              rtal012 = CASE rtal006 WHEN 'Y' THEN '1' WHEN 'N' THEN CASE (rtal007-rtal008) WHEN 0 THEN '1' ELSE rtal012 END ELSE rtal012 END "
               #mod by dengdd 150908               
   PREPARE upd_rtal FROM l_sql
   EXECUTE upd_rtal
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'update rtal_t'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET l_success = FALSE
   END IF
   
   IF l_success THEN 
      #160225-00040# 20160303 s983961--add(s)
      LET l_msg = cl_getmsg('ast-00330',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
      #160225-00040# 20160303 s983961--add(e)   
      #更新资源协议已失效
      LET l_sql = " UPDATE rtap_t SET rtap020 = '3' ",
                  "  WHERE rtapent = ",g_enterprise,
                  "    AND rtap020 = '2' ",
                  "    AND rtap004 <= '",p_date-1,"'",
                  "    AND EXISTS (SELECT 1 FROM rtao_t WHERE rtaoent = rtapent ",
                  "                                       AND rtao001 = rtap001 ",
                  "                                       AND rtaoent = ",g_enterprise,
                  "                                       AND ",p_wc,")"
      PREPARE upd_rtap FROM l_sql
      EXECUTE upd_rtap 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'UPDATE rtap_t  '
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
   END IF 
   IF l_success THEN 
      #160225-00040# 20160303 s983961--add(s)
      LET l_msg = cl_getmsg('std-00012',g_lang)
      CALL cl_progress_no_window_ing(l_msg)
      #160225-00040# 20160303 s983961--add(e)
      CALL cl_err_collect_show()
      CALL s_transaction_end('Y','0')
      RETURN TRUE
   ELSE
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
END FUNCTION

#end add-point
 
{</section>}
 
