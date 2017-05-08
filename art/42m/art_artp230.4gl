#該程式未解開Section, 採用最新樣板產出!
{<section id="artp230.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2015-08-07 11:23:43), PR版次:0009(2016-12-23 09:38:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000067
#+ Filename...: artp230
#+ Description: 門店資源協議費用單批次產生作業
#+ Creator....: 02003(2015-08-05 16:07:17)
#+ Modifier...: 02003 -SD/PR- 02481
 
{</section>}
 
{<section id="artp230.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161024-00025#8   2016/10/26  by 08742  组织开窗修改
#160516-00014#28  2016-11-04  BY 06540   lanjj 资源协议编号长度增加到20位
#161222-00039#1   2016/12/22  by 02481    标准程式定义采用宣告模式,弃用.*写法
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
        rtap021          LIKE rtap_t.rtap021,
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
 
{<section id="artp230.main" >}
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
      CALL artp230_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artp230 WITH FORM cl_ap_formpath("art",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL artp230_init()
 
      #進入選單 Menu (="N")
      CALL artp230_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_artp230
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="artp230.init" >}
#+ 初始化作業
PRIVATE FUNCTION artp230_init()
 
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
 
{<section id="artp230.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION artp230_ui_dialog()
 
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
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtaosite',g_site,'c')     #161024-00025#8   2016/10/26  by 08742  -S  add
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
            LET g_qryparam.arg1 = g_site                         #呼叫開窗
            CALL q_mhae001()
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
            CALL artp230_get_buffer(l_dialog)
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
         CALL artp230_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.rtap021 = g_master.exdate
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
                 CALL artp230_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = artp230_transfer_argv(ls_js)
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
 
{<section id="artp230.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION artp230_transfer_argv(ls_js)
 
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
 
{<section id="artp230.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION artp230_process(ls_js)
 
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
   DEFINE l_msg          LIKE type_t.chr100   #160225-00040#18 2016/04/13 s983961--add

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
      CALL cl_progress_bar_no_window(3)   #160225-00040# 20160303 s983961--add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE artp230_process_cs CURSOR FROM ls_sql
#  FOREACH artp230_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   
   
   IF cl_null(lc_param.rtap021) THEN       
      LET lc_param.rtap021 = g_today - 1
   END IF 
   #IF NOT artp230_process_1(lc_param.wc,lc_param.rtap021) THEN     #lanjj mark on 2016-11-09
   IF NOT s_artp230_ins_astt510(lc_param.wc,lc_param.rtap021) THEN  #lanjj add on 2016-11-09
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
   
   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
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
   CALL artp230_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="artp230.get_buffer" >}
PRIVATE FUNCTION artp230_get_buffer(p_dialog)
 
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
 
{<section id="artp230.msgcentre_notify" >}
PRIVATE FUNCTION artp230_msgcentre_notify()
 
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
 
{<section id="artp230.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 执行批量处理
# Memo...........:
# Usage..........: CALL artp230_process_1(p_wc,p_date)
# Input parameter: p_wc    查询条件
# Return code....: p_date  执行日期
# Date & Author..: 2015/08/06 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION artp230_process_1(p_wc,p_date)
DEFINE p_wc           STRING
DEFINE p_date         LIKE rtap_t.rtap021
DEFINE l_sql          STRING 
#161222-00039#1----add---begin---------------
#DEFINE l_rtao         RECORD LIKE rtao_t.*
#DEFINE l_rtap         RECORD LIKE rtap_t.*
#DEFINE l_stba         RECORD LIKE stba_t.*
#DEFINE l_stbb         RECORD LIKE stbb_t.*
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
       rtaocnfdt LIKE rtao_t.rtaocnfdt  #資料確認日
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
DEFINE l_stba RECORD  #費用單資料表
       stbaent LIKE stba_t.stbaent, #企業編號
       stbasite LIKE stba_t.stbasite, #營運據點
       stbaunit LIKE stba_t.stbaunit, #應用組織
       stbadocno LIKE stba_t.stbadocno, #單據編號
       stbadocdt LIKE stba_t.stbadocdt, #單據日期
       stba001 LIKE stba_t.stba001, #結算中心
       stba002 LIKE stba_t.stba002, #供應商編號
       stba003 LIKE stba_t.stba003, #經營方式
       stba004 LIKE stba_t.stba004, #結算方式
       stba005 LIKE stba_t.stba005, #結算類型
       stba006 LIKE stba_t.stba006, #來源類型
       stba007 LIKE stba_t.stba007, #來源單號
       stba008 LIKE stba_t.stba008, #人員
       stba009 LIKE stba_t.stba009, #部門
       stbastus LIKE stba_t.stbastus, #狀態碼
       stbaownid LIKE stba_t.stbaownid, #資料所屬者
       stbaowndp LIKE stba_t.stbaowndp, #資料所有部門
       stbacrtid LIKE stba_t.stbacrtid, #資料建立者
       stbacrtdp LIKE stba_t.stbacrtdp, #資料建立部門
       stbacrtdt LIKE stba_t.stbacrtdt, #資料創建日
       stbamodid LIKE stba_t.stbamodid, #資料修改者
       stbamoddt LIKE stba_t.stbamoddt, #最近修改日
       stbacnfid LIKE stba_t.stbacnfid, #資料確認者
       stbacnfdt LIKE stba_t.stbacnfdt, #資料確認日
       stbaud001 LIKE stba_t.stbaud001, #自定義欄位(文字)001
       stbaud002 LIKE stba_t.stbaud002, #自定義欄位(文字)002
       stbaud003 LIKE stba_t.stbaud003, #自定義欄位(文字)003
       stbaud004 LIKE stba_t.stbaud004, #自定義欄位(文字)004
       stbaud005 LIKE stba_t.stbaud005, #自定義欄位(文字)005
       stbaud006 LIKE stba_t.stbaud006, #自定義欄位(文字)006
       stbaud007 LIKE stba_t.stbaud007, #自定義欄位(文字)007
       stbaud008 LIKE stba_t.stbaud008, #自定義欄位(文字)008
       stbaud009 LIKE stba_t.stbaud009, #自定義欄位(文字)009
       stbaud010 LIKE stba_t.stbaud010, #自定義欄位(文字)010
       stbaud011 LIKE stba_t.stbaud011, #自定義欄位(數字)011
       stbaud012 LIKE stba_t.stbaud012, #自定義欄位(數字)012
       stbaud013 LIKE stba_t.stbaud013, #自定義欄位(數字)013
       stbaud014 LIKE stba_t.stbaud014, #自定義欄位(數字)014
       stbaud015 LIKE stba_t.stbaud015, #自定義欄位(數字)015
       stbaud016 LIKE stba_t.stbaud016, #自定義欄位(數字)016
       stbaud017 LIKE stba_t.stbaud017, #自定義欄位(數字)017
       stbaud018 LIKE stba_t.stbaud018, #自定義欄位(數字)018
       stbaud019 LIKE stba_t.stbaud019, #自定義欄位(數字)019
       stbaud020 LIKE stba_t.stbaud020, #自定義欄位(數字)020
       stbaud021 LIKE stba_t.stbaud021, #自定義欄位(日期時間)021
       stbaud022 LIKE stba_t.stbaud022, #自定義欄位(日期時間)022
       stbaud023 LIKE stba_t.stbaud023, #自定義欄位(日期時間)023
       stbaud024 LIKE stba_t.stbaud024, #自定義欄位(日期時間)024
       stbaud025 LIKE stba_t.stbaud025, #自定義欄位(日期時間)025
       stbaud026 LIKE stba_t.stbaud026, #自定義欄位(日期時間)026
       stbaud027 LIKE stba_t.stbaud027, #自定義欄位(日期時間)027
       stbaud028 LIKE stba_t.stbaud028, #自定義欄位(日期時間)028
       stbaud029 LIKE stba_t.stbaud029, #自定義欄位(日期時間)029
       stbaud030 LIKE stba_t.stbaud030, #自定義欄位(日期時間)030
       stba010 LIKE stba_t.stba010, #合約編號
       stba011 LIKE stba_t.stba011, #幣別
       stba012 LIKE stba_t.stba012, #稅別
       stba013 LIKE stba_t.stba013, #專櫃編號/鋪位編號
       stba014 LIKE stba_t.stba014, #費用類型
       stba015 LIKE stba_t.stba015, #交款狀態
       stba000 LIKE stba_t.stba000, #程式編號
       stba016 LIKE stba_t.stba016, #交款人
       stba017 LIKE stba_t.stba017, #結算帳期
       stba018 LIKE stba_t.stba018, #結算日期
       stba019 LIKE stba_t.stba019, #開始日期
       stba020 LIKE stba_t.stba020, #結束日期
       stba021 LIKE stba_t.stba021, #成本總額
       stba022 LIKE stba_t.stba022, #法人
       stba023 LIKE stba_t.stba023, #會員折扣金額
       stba024 LIKE stba_t.stba024, #no_use
       stba025 LIKE stba_t.stba025, #合約帳期
       stba026 LIKE stba_t.stba026, #計算日期
       stba027 LIKE stba_t.stba027  #来源单号項次
       END RECORD

DEFINE l_stbb RECORD  #費用單明細資料表
       stbbent LIKE stbb_t.stbbent, #企業編號
       stbbunit LIKE stbb_t.stbbunit, #應用組織
       stbbsite LIKE stbb_t.stbbsite, #營運據點
       stbbdocno LIKE stbb_t.stbbdocno, #單據編號
       stbbseq LIKE stbb_t.stbbseq, #項次
       stbb001 LIKE stbb_t.stbb001, #費用編號
       stbb002 LIKE stbb_t.stbb002, #幣別
       stbb003 LIKE stbb_t.stbb003, #稅別
       stbb004 LIKE stbb_t.stbb004, #價款類別
       stbb005 LIKE stbb_t.stbb005, #起始日期
       stbb006 LIKE stbb_t.stbb006, #截止日期
       stbb007 LIKE stbb_t.stbb007, #結算會計期
       stbb008 LIKE stbb_t.stbb008, #財務會計期
       stbb009 LIKE stbb_t.stbb009, #費用金額
       stbb010 LIKE stbb_t.stbb010, #承擔對象
       stbb011 LIKE stbb_t.stbb011, #所屬品類
       stbb012 LIKE stbb_t.stbb012, #所屬部門
       stbb013 LIKE stbb_t.stbb013, #結算對象
       stbbud001 LIKE stbb_t.stbbud001, #含發票否
       stbbud002 LIKE stbb_t.stbbud002, #自定義欄位(文字)002
       stbbud003 LIKE stbb_t.stbbud003, #自定義欄位(文字)003
       stbbud004 LIKE stbb_t.stbbud004, #自定義欄位(文字)004
       stbbud005 LIKE stbb_t.stbbud005, #自定義欄位(文字)005
       stbbud006 LIKE stbb_t.stbbud006, #自定義欄位(文字)006
       stbbud007 LIKE stbb_t.stbbud007, #自定義欄位(文字)007
       stbbud008 LIKE stbb_t.stbbud008, #自定義欄位(文字)008
       stbbud009 LIKE stbb_t.stbbud009, #自定義欄位(文字)009
       stbbud010 LIKE stbb_t.stbbud010, #自定義欄位(文字)010
       stbbud011 LIKE stbb_t.stbbud011, #自定義欄位(數字)011
       stbbud012 LIKE stbb_t.stbbud012, #自定義欄位(數字)012
       stbbud013 LIKE stbb_t.stbbud013, #自定義欄位(數字)013
       stbbud014 LIKE stbb_t.stbbud014, #自定義欄位(數字)014
       stbbud015 LIKE stbb_t.stbbud015, #自定義欄位(數字)015
       stbbud016 LIKE stbb_t.stbbud016, #自定義欄位(數字)016
       stbbud017 LIKE stbb_t.stbbud017, #自定義欄位(數字)017
       stbbud018 LIKE stbb_t.stbbud018, #自定義欄位(數字)018
       stbbud019 LIKE stbb_t.stbbud019, #自定義欄位(數字)019
       stbbud020 LIKE stbb_t.stbbud020, #自定義欄位(數字)020
       stbbud021 LIKE stbb_t.stbbud021, #自定義欄位(日期時間)021
       stbbud022 LIKE stbb_t.stbbud022, #自定義欄位(日期時間)022
       stbbud023 LIKE stbb_t.stbbud023, #自定義欄位(日期時間)023
       stbbud024 LIKE stbb_t.stbbud024, #自定義欄位(日期時間)024
       stbbud025 LIKE stbb_t.stbbud025, #自定義欄位(日期時間)025
       stbbud026 LIKE stbb_t.stbbud026, #自定義欄位(日期時間)026
       stbbud027 LIKE stbb_t.stbbud027, #自定義欄位(日期時間)027
       stbbud028 LIKE stbb_t.stbbud028, #自定義欄位(日期時間)028
       stbbud029 LIKE stbb_t.stbbud029, #自定義欄位(日期時間)029
       stbbud030 LIKE stbb_t.stbbud030, #自定義欄位(日期時間)030
       stbb014 LIKE stbb_t.stbb014, #財務會計期別
       stbb015 LIKE stbb_t.stbb015, #納入結算單否
       stbb016 LIKE stbb_t.stbb016, #票扣否
       stbb017 LIKE stbb_t.stbb017, #備註
       stbb018 LIKE stbb_t.stbb018, #結算帳期
       stbb019 LIKE stbb_t.stbb019, #結算日期
       stbb020 LIKE stbb_t.stbb020, #日結成本類型
       stbb021 LIKE stbb_t.stbb021, #調整日期
       stbb022 LIKE stbb_t.stbb022, #商品編號
       stbb023 LIKE stbb_t.stbb023, #庫區編號
       stbb024 LIKE stbb_t.stbb024, #专柜编号
       stbb025 LIKE stbb_t.stbb025, #應收金額
       stbb026 LIKE stbb_t.stbb026, #實收金額
       stbb027 LIKE stbb_t.stbb027, #費率
       stbb028 LIKE stbb_t.stbb028, #成本金額
       stbb029 LIKE stbb_t.stbb029, #促銷銷售額
       stbb030 LIKE stbb_t.stbb030, #費用歸屬類型
       stbb031 LIKE stbb_t.stbb031, #費用歸屬組織
       stbb032 LIKE stbb_t.stbb032, #銷售數量
       stbb033 LIKE stbb_t.stbb033  #銷售單位
       END RECORD

#161222-00039#1----add---end---------------
DEFINE l_rtap007      LIKE rtap_t.rtap007
DEFINE r_doctype      LIKE rtai_t.rtai004
DEFINE l_success      LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE l_stfa011      LIKE stfa_t.stfa011
DEFINE l_stfa044      LIKE stfa_t.stfa044
DEFINE l_nextd        LIKE type_t.dat
DEFINE l_begin        LIKE type_t.dat
DEFINE l_end          LIKE type_t.dat
DEFINE l_sum          LIKE stbb_t.stbb009
DEFINE l_acount_t     LIKE stbb_t.stbb009
DEFINE l_exit         LIKE type_t.chr1
DEFINE l_day          LIKE type_t.num5
DEFINE l_stae005      LIKE stae_t.stae005
DEFINE l_stbb009      LIKE stbb_t.stbb009
DEFINE r_nextd        LIKE type_t.dat
DEFINE r_begin        LIKE type_t.dat
DEFINE r_end          LIKE type_t.dat
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_stfa051      LIKE stfa_t.stfa051  #add by geza 20150831
DEFINE m_success      LIKE type_t.num5
DEFINE n_success      LIKE type_t.num5 #LANJJ ADD ON 2016-03-25
DEFINE l_count        LIKE type_t.num5 #lanjj add on 2016-04-05
DEFINE o_success      LIKE type_t.num5 #lanjj add on 2016-05-16
DEFINE l_msg          LIKE type_t.chr100   #160225-00040#18 2016/04/13 s983961--add
DEFINE l_where        STRING           #161024-00025#8   2016/10/26  by 08742       add

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   
   #161024-00025#8   2016/10/26  by 08742  -S
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'rtaosite') RETURNING l_where
   
   #161024-00025#8   2016/10/26  by 08742   -E
   
   LET p_wc = cl_replace_str(p_wc, 'mhae001', 'rtap007')   
   #161222-00039#1----add---begin---------------
   #LET l_sql = "SELECT DISTINCT rtao_t.*,rtap007  FROM rtao_t ",
   LET l_sql = "SELECT DISTINCT rtaoent,rtaounit,rtaosite,rtaostus,rtao001,rtao002,rtao003,rtao004,rtao005,",
               "rtao006,rtaoownid,rtaoowndp,rtaocrtid,rtaocrtdp,rtaocrtdt,rtaomodid,rtaomoddt,rtaocnfid,rtaocnfdt,",
               "rtap007  FROM rtao_t ",   
   #161222-00039#1----add---end---------------
               "  LEFT JOIN rtap_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               " WHERE rtaoent = ",g_enterprise,
               "   AND rtap020 = '2' ",
               "   AND rtap015 IN('1','2','3','4')",
               "   AND rtap021 <= '",p_date,"'",
               "   AND rtap024 = '2'", #lanjj add on 2016-04-06
               "   AND ",l_where,      #161024-00025#8   2016/10/26  by 08742 
               "   AND ",p_wc
   PREPARE sel_rtao FROM l_sql
   DECLARE sel_rtao_cs CURSOR FOR sel_rtao
   #161222-00039#1----add---begin---------------
   #LET l_sql = " SELECT DISTINCT rtap_t.* FROM rtap_t ",
   LET l_sql = " SELECT DISTINCT rtapent,rtapsite,rtapcomp,rtapseq,rtap001,rtap002,rtap003,rtap004,rtap005,",
               "rtap006,rtap007,rtap008,rtap009,rtap010,rtap011,rtap012,rtap013,rtap014,rtap015,rtap016,rtap017,",
               "rtap018,rtap019,rtap020,rtap021,rtap022,rtap023,rtap024,rtap025 FROM rtap_t ",
   #161222-00039#1----add---end---------------
               "   LEFT JOIN rtao_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               "  WHERE rtapent = ",g_enterprise,
               "    AND rtap001 = ? ",
               "    AND rtap007 = ? ",
               "    AND rtap020 = '2' ",
               "    AND rtap015 IN('1','2','3','4')",
               "    AND rtap021 <= '",p_date,"'",
               "    AND rtap024 = '2'",  #add by dengdd 151120---租用对象为“专柜”
               "    AND ",p_wc
   PREPARE sel_rtap FROM l_sql
   DECLARE sel_rtap_cs CURSOR FOR sel_rtap
   FOREACH sel_rtao_cs INTO l_rtao.*,l_rtap007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      
      #费用单单头栏位赋值
      INITIALIZE l_stba.* TO NULL
      LET l_stba.stbaownid = g_user
      LET l_stba.stbaowndp = g_dept
      LET l_stba.stbacrtid = g_user
      LET l_stba.stbacrtdp = g_dept 
      LET l_stba.stbacrtdt = cl_get_current()
      LET l_stba.stbamodid = g_user
      LET l_stba.stbamoddt = cl_get_current()
      LET l_stba.stbastus = 'N'
      LET l_stba.stbaent = g_enterprise
      LET l_stba.stbasite = l_rtao.rtaosite
      LET l_stba.stbaunit = l_rtao.rtaosite
      LET l_stba.stbadocdt = p_date
      ##預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(l_stba.stbaunit,'astt510','1')
           RETURNING r_success,r_doctype
      LET l_stba.stbadocno = r_doctype
      CALL s_aooi200_gen_docno(g_site,l_stba.stbadocno,l_stba.stbadocdt,'astt510') RETURNING r_success,l_stba.stbadocno
      IF NOT r_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_stba.stbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH              
      END IF 
      LET l_stba.stba006 = '14'              #來源類型
      LET l_stba.stba007 = l_rtao.rtao001    #來源單號
      LET l_stba.stba008 = l_rtao.rtao004    #人員
      LET l_stba.stba009 = l_rtao.rtao005    #部門    
      LET l_stba.stbastus = 'N'              #狀態碼
      LET l_stba.stba014 = '2'               #費用類型
      LET l_stba.stba015 = ''                #交款狀態
      LET l_stba.stba016 = ''                #交款人
      LET l_stba.stba000 = 'astt510'         #程式編號
      LET l_stba.stba013 = l_rtap007         #專櫃編號
      #根据专柜编号抓取合同资料
      #合同編號/供應商編號/签订法人（结算中心）/經營方式/結算方式/結算類型/幣別/稅別
      SELECT stfa001,stfa010,stfa003,stfa036,stfa037,stfa032,#stfa034,
      #      品类，部门
         #    stfa011,stfa044   #mark by geza 20150831
             stfa051,stfa044    #add by geza 20150831 抓管理品类
        INTO l_stba.stba010,l_stba.stba002,l_stba.stba003,l_stba.stba004,l_stba.stba005,l_stba.stba011,#l_stba.stba012,
             #l_stfa011,l_stfa044 #mark by geza 20150831
             l_stfa051,l_stfa044  #add by geza 20150831
        FROM stfa_t
       WHERE stfaent = g_enterprise
         AND stfa005 = l_rtap007
         AND stfasite = l_rtao.rtaosite
      CALL s_astt401_stey004_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba012    #lanjj add on 2016-07-28 税别  
      CALL s_astt401_stey006_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba001    #lanjj add on 2016-07-28 结算中心     
      CALL s_astt401_stey003_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stba.stba002    #add by yangxf #供應商編號 
      #161222-00039#1----add---begin---------------
      #INSERT INTO stba_t VALUES(l_stba.*)
      INSERT INTO stba_t (stbaent,stbasite,stbaunit,stbadocno,stbadocdt,stba001,stba002,stba003,stba004,stba005,
                          stba006,stba007,stba008,stba009,stbastus,stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt,
                          stbamodid,stbamoddt,stbacnfid,stbacnfdt,stbaud001,stbaud002,stbaud003,stbaud004,stbaud005,
                          stbaud006,stbaud007,stbaud008,stbaud009,stbaud010,stbaud011,stbaud012,stbaud013,stbaud014,
                          stbaud015,stbaud016,stbaud017,stbaud018,stbaud019,stbaud020,stbaud021,stbaud022,stbaud023,
                          stbaud024,stbaud025,stbaud026,stbaud027,stbaud028,stbaud029,stbaud030,stba010,stba011,
                          stba012,stba013,stba014,stba015,stba000,stba016,stba017,stba018,stba019,stba020,stba021,
                          stba022,stba023,stba024,stba025,stba026,stba027)
      VALUES(l_stba.stbaent,l_stba.stbasite,l_stba.stbaunit,l_stba.stbadocno,l_stba.stbadocdt,l_stba.stba001,l_stba.stba002,l_stba.stba003,l_stba.stba004,l_stba.stba005,
             l_stba.stba006,l_stba.stba007,l_stba.stba008,l_stba.stba009,l_stba.stbastus,l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid,l_stba.stbacrtdp,l_stba.stbacrtdt,
             l_stba.stbamodid,l_stba.stbamoddt,l_stba.stbacnfid,l_stba.stbacnfdt,l_stba.stbaud001,l_stba.stbaud002,l_stba.stbaud003,l_stba.stbaud004,l_stba.stbaud005,
             l_stba.stbaud006,l_stba.stbaud007,l_stba.stbaud008,l_stba.stbaud009,l_stba.stbaud010,l_stba.stbaud011,l_stba.stbaud012,l_stba.stbaud013,l_stba.stbaud014,
             l_stba.stbaud015,l_stba.stbaud016,l_stba.stbaud017,l_stba.stbaud018,l_stba.stbaud019,l_stba.stbaud020,l_stba.stbaud021,l_stba.stbaud022,l_stba.stbaud023,
             l_stba.stbaud024,l_stba.stbaud025,l_stba.stbaud026,l_stba.stbaud027,l_stba.stbaud028,l_stba.stbaud029,l_stba.stbaud030,l_stba.stba010,l_stba.stba011,
             l_stba.stba012,l_stba.stba013,l_stba.stba014,l_stba.stba015,l_stba.stba000,l_stba.stba016,l_stba.stba017,l_stba.stba018,l_stba.stba019,l_stba.stba020,l_stba.stba021,
             l_stba.stba022,l_stba.stba023,l_stba.stba024,l_stba.stba025,l_stba.stba026,l_stba.stba027)
      #161222-00039#1----add---end---------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = " INTO stba_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH   
      END IF
      INITIALIZE l_rtap.* TO NULL
      FOREACH sel_rtap_cs USING l_rtao.rtao001,l_rtap007 INTO l_rtap.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         IF l_rtap.rtap017 = 0 THEN #LANJJ ADD ON 2016-02-23 协议金额为零则不生成
            CONTINUE FOREACH
         END IF
         
         INITIALIZE l_stbb.* TO NULL
         LET l_stbb.stbbent = g_enterprise       #企业编号
         LET l_stbb.stbbunit = l_stba.stbaunit   #制定组织
         LET l_stbb.stbbsite = l_stba.stbasite   #营运组织
         LET l_stbb.stbbdocno = l_stba.stbadocno #单据编号
         LET l_stbb.stbb001 = l_rtap.rtap011     #费用编号
         LET l_stbb.stbb002 = l_stba.stba011     #幣別
         #LET l_stbb.stbb003 = l_stba.stba012    #稅別      #mark by geza 20151014
         
         LET l_stbb.stbb004 = l_rtap.rtap014    #價款類別
         #LET l_stbb.stbb010 = l_stba.stba002    #承擔對象    #mark by geza 20150904
         LET l_stbb.stbb010 = '1'                #承擔對象   #add by geza 20150904
         #LET l_stbb.stbb011 = l_stfa011         #所屬品類    #mark by geza 20150831
         LET l_stbb.stbb011 = l_stfa051         #所屬品類
         LET l_stbb.stbb012 = l_stfa044         #所屬部門
         #LET l_stbb.stbb013 = l_stba.stba002    #結算對象    mark by geza 20150904
         LET l_stbb.stbb013 = '1'                #結算對象   #add by geza 20150904
         LET l_stbb.stbb015 = l_rtap.rtap012    #納入結算單否
         LET l_stbb.stbb016 = l_rtap.rtap013    #票扣否
         
         #add by geza 20151014(S)
         #票扣否=Y，税带合同里面的，票扣否=N，税带费用编号asti203里面的
         IF l_stbb.stbb016 = 'Y' THEN
#            SELECT stfa033 INTO l_stbb.stbb003
#              FROM stfa_t
#             WHERE stfaent = g_enterprise
#               AND stfa005 = l_stba.stba013 #lanjj mark
            CALL s_astt401_stey004_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stbb.stbb003   #lanjj add on 2016-07-28
         ELSE
            SELECT stae010 INTO l_stbb.stbb003
              FROM stae_t
             WHERE staeent = g_enterprise
               AND stae001 = l_stbb.stbb001
         END IF
         #add by geza 20151014(E)
         
         LET l_stbb.stbb017 = l_rtap.rtap019                #備註
#         #add by geza 20151010(S) #含发票否
#         SELECT stfa050 INTO l_stbb.stbbud001
#           FROM stfa_t
#          WHERE stfaent = g_enterprise
#            AND stfa001 = l_stba.stba010
#         #add by geza 20151010(E) lanjj mark
         CALL s_astt401_stey005_get(l_stba.stba013,l_stba.stbadocdt) RETURNING l_stbb.stbbud001 #lanjj add on 2016-07-28
         
         #mark by geza 20150904(S)
#         SELECT stfjseq INTO l_stbb.stbb018     #结算帐期
#           FROM stfj_t
#          WHERE stfjent = g_enterprise
#            AND stfj001 = l_stba.stba010
#            AND p_date BETWEEN stfj002 AND stfj003
         #mark by geza 20150904(E)  
         #add by geza 20150904(S)  
         #根据开始日期结束日期抓取结算账期和结算日期
         CALL s_settle_date_get_stbb019(l_stba.stba010,l_rtap.rtap022,l_rtap.rtap023,'2') 
            RETURNING  l_stbb.stbb018,l_stbb.stbb019  
         #add by geza 20150904(E)         
         #当费用核算制度为2.权责发生制 写入费用单的开始日期和截止日期，按照自然月以及天数拆分处理
         SELECT stae005 INTO l_stae005
           FROM stae_t 
          WHERE staeent = g_enterprise
            AND stae001 = l_stbb.stbb001
         LET l_stbb009 = l_rtap.rtap017
         IF l_stae005 = '2' THEN    
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb009,'2') RETURNING l_stbb009
            LET l_acount_t = l_stbb009
            #根据费用开始和截止拆分
            LET l_begin = ''
            LET l_end = ''
            LET l_sum = 0
            WHILE TRUE
               #费用下次计算开始日-下次计算截止日
               #CALL s_astm301_cal_nextd('3','1',l_rtap.rtap022,l_rtap.rtap023,l_begin,l_end,'','2','N','') RETURNING l_nextd,l_begin,l_end
               CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap022,l_rtap.rtap023,l_begin,l_end,'','2','N','') RETURNING l_nextd,l_begin,l_end
               IF l_end> = l_rtap.rtap023 THEN
                  LET l_end = l_rtap.rtap023
                  LET l_exit = 'Y'   #退出循环标志 'Y' 退出
               ELSE
                  LET l_exit = 'N'
               END IF
               LET l_day = l_end - l_begin+1
               LET l_stbb.stbb005 = l_begin
               LET l_stbb.stbb006 = l_end
             
               CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt510") 
                     RETURNING l_success,l_stbb.stbb007, 
                               l_year,#会计期年度
                               l_month #会计期月份
               LET l_stbb.stbb008 = l_year                
               LET l_stbb.stbb014 = l_month
               IF NOT l_success THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF

               SELECT MAX(stbbseq)+1 INTO l_stbb.stbbseq FROM stbb_t
                WHERE stbbent = g_enterprise AND stbbdocno = l_stba.stbadocno
            
               IF cl_null(l_stbb.stbbseq) THEN
                  LET l_stbb.stbbseq = 1
               END IF
               IF l_exit = 'Y' THEN
                  LET l_stbb.stbb009 = l_acount_t -l_sum
               ELSE 
                  LET l_stbb.stbb009 = l_acount_t/(l_rtap.rtap023 - l_rtap.rtap022+1)*l_day
                  CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  
                  LET l_sum = l_sum+ l_stbb.stbb009
               END IF
               #161222-00039#1----add---begin---------------
               #INSERT INTO stbb_t VALUES(l_stbb.*)
               INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                   stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                   stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                   stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                   stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                   stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                   stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                   stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
                VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                       l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                       l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                       l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                       l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                       l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                       l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                       l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
               #161222-00039#1----add---end---------------
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = " INTO stbb_t "
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT WHILE
               END IF
               IF l_exit = 'Y' THEN     
                  EXIT WHILE
               END IF
                            
            END WHILE
            IF NOT l_success THEN 
               EXIT FOREACH 
            END IF 
         ELSE
            SELECT MAX(stbbseq) + 1 INTO l_stbb.stbbseq
              FROM stbb_t 
             WHERE stbbent = g_enterprise
               AND stbbdocno = l_stba.stbadocno
            IF cl_null(l_stbb.stbbseq) THEN 
               LET l_stbb.stbbseq = 1
            END IF 
            LET l_stbb.stbb005 = l_rtap.rtap022           #起始日期
            LET l_stbb.stbb006 = l_rtap.rtap023           #截止日期
            CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt510") 
                           RETURNING l_success,l_stbb.stbb007, 
                                     l_year,#会计期年度
                                     l_month #会计期月份
            LET l_stbb.stbb008 = l_year                
            LET l_stbb.stbb014 = l_month           #財務會計期別    
            IF NOT l_success THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_stbb.stbb009 = l_stbb009         #費用金額
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  

            #161222-00039#1----add---begin---------------
            #INSERT INTO stbb_t VALUES(l_stbb.*)
            INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
             VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                    l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                    l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                    l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                    l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                    l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                    l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                    l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
            #161222-00039#1----add---end---------------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = " INTO stbb_t "
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH   
            END IF
         END IF 
         #写入费用单----end-----
         #更新下次费用计算日、下次费用开始日、下次费用截止日
         CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap003,l_rtap.rtap004,l_rtap.rtap022,l_rtap.rtap023,'','2','N','')
              RETURNING r_nextd,r_begin,r_end
         IF l_rtap.rtap015 = '4' THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = ''
         END IF
         #下次计算日期大于失效日期清空下次费用计算日、下次费用开始日、下次费用截止日
         IF r_nextd > l_rtap.rtap004 THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = '' 
         END IF 
         UPDATE rtap_t SET rtap021 = r_nextd,
                           rtap022 = r_begin,
                           rtap023 = r_end
          WHERE rtapent = g_enterprise
            AND rtap001 = l_rtap.rtap001
            AND rtapseq = l_rtap.rtapseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = " UPD rtap_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH   
         END IF
      END FOREACH 
      
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单 start
      SELECT COUNT(*) INTO l_count
        FROM stbb_t
       WHERE stbbent = g_enterprise
         AND stbbdocno = l_stba.stbadocno
      IF l_count <= 0 THEN
         DELETE FROM stba_t WHERE stbaent = g_enterprise AND stbadocno = l_stba.stbadocno
      END IF 
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单  end
      
   END FOREACH 

   #160225-00040# 20160303 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040# 20160303 s983961--add(e)
   
   CALL artp230_astt320_ins(p_wc,p_date) RETURNING m_success  #add by dengdd 151120
   CALL artp230_astt810_ins(p_wc,p_date) RETURNING o_success  #lanjj add on 2016-05-16
   
   IF l_success AND m_success AND o_success THEN 
      CALL artp230_update_rtap015(p_wc,p_date) RETURNING n_success #lanjj add on 2016-03-25
      IF n_success THEN
         CALL cl_err_collect_show()
         CALL s_transaction_end('Y','0')
         RETURN TRUE
      ELSE 
         CALL cl_err_collect_show()
         CALL s_transaction_end('N','0')
         RETURN FALSE
      END IF
   ELSE
      CALL cl_err_collect_show()
      CALL s_transaction_end('N','0')
      RETURN FALSE
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 15/11/20 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION artp230_astt320_ins(p_wc,p_date)
DEFINE p_wc           STRING
DEFINE p_date         LIKE rtap_t.rtap021
DEFINE l_sql          STRING 
#161222-00039#1----add---begin---------------
#DEFINE l_rtao         RECORD LIKE rtao_t.*
#DEFINE l_rtap         RECORD LIKE rtap_t.*
#DEFINE l_stba         RECORD LIKE stba_t.*
#DEFINE l_stbb         RECORD LIKE stbb_t.*
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
       rtaocnfdt LIKE rtao_t.rtaocnfdt  #資料確認日
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
DEFINE l_stba RECORD  #費用單資料表
       stbaent LIKE stba_t.stbaent, #企業編號
       stbasite LIKE stba_t.stbasite, #營運據點
       stbaunit LIKE stba_t.stbaunit, #應用組織
       stbadocno LIKE stba_t.stbadocno, #單據編號
       stbadocdt LIKE stba_t.stbadocdt, #單據日期
       stba001 LIKE stba_t.stba001, #結算中心
       stba002 LIKE stba_t.stba002, #供應商編號
       stba003 LIKE stba_t.stba003, #經營方式
       stba004 LIKE stba_t.stba004, #結算方式
       stba005 LIKE stba_t.stba005, #結算類型
       stba006 LIKE stba_t.stba006, #來源類型
       stba007 LIKE stba_t.stba007, #來源單號
       stba008 LIKE stba_t.stba008, #人員
       stba009 LIKE stba_t.stba009, #部門
       stbastus LIKE stba_t.stbastus, #狀態碼
       stbaownid LIKE stba_t.stbaownid, #資料所屬者
       stbaowndp LIKE stba_t.stbaowndp, #資料所有部門
       stbacrtid LIKE stba_t.stbacrtid, #資料建立者
       stbacrtdp LIKE stba_t.stbacrtdp, #資料建立部門
       stbacrtdt LIKE stba_t.stbacrtdt, #資料創建日
       stbamodid LIKE stba_t.stbamodid, #資料修改者
       stbamoddt LIKE stba_t.stbamoddt, #最近修改日
       stbacnfid LIKE stba_t.stbacnfid, #資料確認者
       stbacnfdt LIKE stba_t.stbacnfdt, #資料確認日
       stbaud001 LIKE stba_t.stbaud001, #自定義欄位(文字)001
       stbaud002 LIKE stba_t.stbaud002, #自定義欄位(文字)002
       stbaud003 LIKE stba_t.stbaud003, #自定義欄位(文字)003
       stbaud004 LIKE stba_t.stbaud004, #自定義欄位(文字)004
       stbaud005 LIKE stba_t.stbaud005, #自定義欄位(文字)005
       stbaud006 LIKE stba_t.stbaud006, #自定義欄位(文字)006
       stbaud007 LIKE stba_t.stbaud007, #自定義欄位(文字)007
       stbaud008 LIKE stba_t.stbaud008, #自定義欄位(文字)008
       stbaud009 LIKE stba_t.stbaud009, #自定義欄位(文字)009
       stbaud010 LIKE stba_t.stbaud010, #自定義欄位(文字)010
       stbaud011 LIKE stba_t.stbaud011, #自定義欄位(數字)011
       stbaud012 LIKE stba_t.stbaud012, #自定義欄位(數字)012
       stbaud013 LIKE stba_t.stbaud013, #自定義欄位(數字)013
       stbaud014 LIKE stba_t.stbaud014, #自定義欄位(數字)014
       stbaud015 LIKE stba_t.stbaud015, #自定義欄位(數字)015
       stbaud016 LIKE stba_t.stbaud016, #自定義欄位(數字)016
       stbaud017 LIKE stba_t.stbaud017, #自定義欄位(數字)017
       stbaud018 LIKE stba_t.stbaud018, #自定義欄位(數字)018
       stbaud019 LIKE stba_t.stbaud019, #自定義欄位(數字)019
       stbaud020 LIKE stba_t.stbaud020, #自定義欄位(數字)020
       stbaud021 LIKE stba_t.stbaud021, #自定義欄位(日期時間)021
       stbaud022 LIKE stba_t.stbaud022, #自定義欄位(日期時間)022
       stbaud023 LIKE stba_t.stbaud023, #自定義欄位(日期時間)023
       stbaud024 LIKE stba_t.stbaud024, #自定義欄位(日期時間)024
       stbaud025 LIKE stba_t.stbaud025, #自定義欄位(日期時間)025
       stbaud026 LIKE stba_t.stbaud026, #自定義欄位(日期時間)026
       stbaud027 LIKE stba_t.stbaud027, #自定義欄位(日期時間)027
       stbaud028 LIKE stba_t.stbaud028, #自定義欄位(日期時間)028
       stbaud029 LIKE stba_t.stbaud029, #自定義欄位(日期時間)029
       stbaud030 LIKE stba_t.stbaud030, #自定義欄位(日期時間)030
       stba010 LIKE stba_t.stba010, #合約編號
       stba011 LIKE stba_t.stba011, #幣別
       stba012 LIKE stba_t.stba012, #稅別
       stba013 LIKE stba_t.stba013, #專櫃編號/鋪位編號
       stba014 LIKE stba_t.stba014, #費用類型
       stba015 LIKE stba_t.stba015, #交款狀態
       stba000 LIKE stba_t.stba000, #程式編號
       stba016 LIKE stba_t.stba016, #交款人
       stba017 LIKE stba_t.stba017, #結算帳期
       stba018 LIKE stba_t.stba018, #結算日期
       stba019 LIKE stba_t.stba019, #開始日期
       stba020 LIKE stba_t.stba020, #結束日期
       stba021 LIKE stba_t.stba021, #成本總額
       stba022 LIKE stba_t.stba022, #法人
       stba023 LIKE stba_t.stba023, #會員折扣金額
       stba024 LIKE stba_t.stba024, #no_use
       stba025 LIKE stba_t.stba025, #合約帳期
       stba026 LIKE stba_t.stba026, #計算日期
       stba027 LIKE stba_t.stba027  #来源单号項次
       END RECORD

DEFINE l_stbb RECORD  #費用單明細資料表
       stbbent LIKE stbb_t.stbbent, #企業編號
       stbbunit LIKE stbb_t.stbbunit, #應用組織
       stbbsite LIKE stbb_t.stbbsite, #營運據點
       stbbdocno LIKE stbb_t.stbbdocno, #單據編號
       stbbseq LIKE stbb_t.stbbseq, #項次
       stbb001 LIKE stbb_t.stbb001, #費用編號
       stbb002 LIKE stbb_t.stbb002, #幣別
       stbb003 LIKE stbb_t.stbb003, #稅別
       stbb004 LIKE stbb_t.stbb004, #價款類別
       stbb005 LIKE stbb_t.stbb005, #起始日期
       stbb006 LIKE stbb_t.stbb006, #截止日期
       stbb007 LIKE stbb_t.stbb007, #結算會計期
       stbb008 LIKE stbb_t.stbb008, #財務會計期
       stbb009 LIKE stbb_t.stbb009, #費用金額
       stbb010 LIKE stbb_t.stbb010, #承擔對象
       stbb011 LIKE stbb_t.stbb011, #所屬品類
       stbb012 LIKE stbb_t.stbb012, #所屬部門
       stbb013 LIKE stbb_t.stbb013, #結算對象
       stbbud001 LIKE stbb_t.stbbud001, #含發票否
       stbbud002 LIKE stbb_t.stbbud002, #自定義欄位(文字)002
       stbbud003 LIKE stbb_t.stbbud003, #自定義欄位(文字)003
       stbbud004 LIKE stbb_t.stbbud004, #自定義欄位(文字)004
       stbbud005 LIKE stbb_t.stbbud005, #自定義欄位(文字)005
       stbbud006 LIKE stbb_t.stbbud006, #自定義欄位(文字)006
       stbbud007 LIKE stbb_t.stbbud007, #自定義欄位(文字)007
       stbbud008 LIKE stbb_t.stbbud008, #自定義欄位(文字)008
       stbbud009 LIKE stbb_t.stbbud009, #自定義欄位(文字)009
       stbbud010 LIKE stbb_t.stbbud010, #自定義欄位(文字)010
       stbbud011 LIKE stbb_t.stbbud011, #自定義欄位(數字)011
       stbbud012 LIKE stbb_t.stbbud012, #自定義欄位(數字)012
       stbbud013 LIKE stbb_t.stbbud013, #自定義欄位(數字)013
       stbbud014 LIKE stbb_t.stbbud014, #自定義欄位(數字)014
       stbbud015 LIKE stbb_t.stbbud015, #自定義欄位(數字)015
       stbbud016 LIKE stbb_t.stbbud016, #自定義欄位(數字)016
       stbbud017 LIKE stbb_t.stbbud017, #自定義欄位(數字)017
       stbbud018 LIKE stbb_t.stbbud018, #自定義欄位(數字)018
       stbbud019 LIKE stbb_t.stbbud019, #自定義欄位(數字)019
       stbbud020 LIKE stbb_t.stbbud020, #自定義欄位(數字)020
       stbbud021 LIKE stbb_t.stbbud021, #自定義欄位(日期時間)021
       stbbud022 LIKE stbb_t.stbbud022, #自定義欄位(日期時間)022
       stbbud023 LIKE stbb_t.stbbud023, #自定義欄位(日期時間)023
       stbbud024 LIKE stbb_t.stbbud024, #自定義欄位(日期時間)024
       stbbud025 LIKE stbb_t.stbbud025, #自定義欄位(日期時間)025
       stbbud026 LIKE stbb_t.stbbud026, #自定義欄位(日期時間)026
       stbbud027 LIKE stbb_t.stbbud027, #自定義欄位(日期時間)027
       stbbud028 LIKE stbb_t.stbbud028, #自定義欄位(日期時間)028
       stbbud029 LIKE stbb_t.stbbud029, #自定義欄位(日期時間)029
       stbbud030 LIKE stbb_t.stbbud030, #自定義欄位(日期時間)030
       stbb014 LIKE stbb_t.stbb014, #財務會計期別
       stbb015 LIKE stbb_t.stbb015, #納入結算單否
       stbb016 LIKE stbb_t.stbb016, #票扣否
       stbb017 LIKE stbb_t.stbb017, #備註
       stbb018 LIKE stbb_t.stbb018, #結算帳期
       stbb019 LIKE stbb_t.stbb019, #結算日期
       stbb020 LIKE stbb_t.stbb020, #日結成本類型
       stbb021 LIKE stbb_t.stbb021, #調整日期
       stbb022 LIKE stbb_t.stbb022, #商品編號
       stbb023 LIKE stbb_t.stbb023, #庫區編號
       stbb024 LIKE stbb_t.stbb024, #专柜编号
       stbb025 LIKE stbb_t.stbb025, #應收金額
       stbb026 LIKE stbb_t.stbb026, #實收金額
       stbb027 LIKE stbb_t.stbb027, #費率
       stbb028 LIKE stbb_t.stbb028, #成本金額
       stbb029 LIKE stbb_t.stbb029, #促銷銷售額
       stbb030 LIKE stbb_t.stbb030, #費用歸屬類型
       stbb031 LIKE stbb_t.stbb031, #費用歸屬組織
       stbb032 LIKE stbb_t.stbb032, #銷售數量
       stbb033 LIKE stbb_t.stbb033  #銷售單位
       END RECORD

#161222-00039#1----add---end---------------
DEFINE l_rtap008      LIKE rtap_t.rtap008
DEFINE l_rtap025      LIKE rtap_t.rtap025
DEFINE r_doctype      LIKE rtai_t.rtai004
DEFINE l_success      LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE l_stfa011      LIKE stfa_t.stfa011
DEFINE l_stfa044      LIKE stfa_t.stfa044
DEFINE l_nextd        LIKE type_t.dat
DEFINE l_begin        LIKE type_t.dat
DEFINE l_end          LIKE type_t.dat
DEFINE l_sum          LIKE stbb_t.stbb009
DEFINE l_acount_t     LIKE stbb_t.stbb009
DEFINE l_exit         LIKE type_t.chr1
DEFINE l_day          LIKE type_t.num5
DEFINE l_stae005      LIKE stae_t.stae005
DEFINE l_stbb009      LIKE stbb_t.stbb009
DEFINE r_nextd        LIKE type_t.dat
DEFINE r_begin        LIKE type_t.dat
DEFINE r_end          LIKE type_t.dat
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_stfa051      LIKE stfa_t.stfa051  
DEFINE l_count        LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'mhae001', 'rtap007') 
   #161222-00039#1----add---begin---------------   
   #LET l_sql = "SELECT DISTINCT rtao_t.*,rtap008,rtap025  FROM rtao_t ",  #lanjj add rtap025 on 2016-04-05
    LET l_sql = "SELECT DISTINCT rtaoent,rtaounit,rtaosite,rtaostus,rtao001,rtao002,rtao003,rtao004,rtao005,",
               "rtao006,rtaoownid,rtaoowndp,rtaocrtid,rtaocrtdp,rtaocrtdt,rtaomodid,rtaomoddt,rtaocnfid,rtaocnfdt,",
               "rtap008,rtap025  FROM rtao_t ",   
   #161222-00039#1----add---end---------------
               "  LEFT JOIN rtap_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               " WHERE rtaoent = ",g_enterprise,
               "   AND rtap020 = '2' ",
               "   AND rtap015 IN('1','2','3','4')",
               "   AND rtap021 <= '",p_date,"'",
               "   AND rtap024 = '1'", #lanjj add on 2016-04-06
               "   AND ",p_wc
   PREPARE sel_rtao2 FROM l_sql
   DECLARE sel_rtao_cs2 CURSOR FOR sel_rtao2
   #161222-00039#1----add---begin---------------
   #LET l_sql = " SELECT DISTINCT rtap_t.* FROM rtap_t ",
   LET l_sql = " SELECT DISTINCT rtapent,rtapsite,rtapcomp,rtapseq,rtap001,rtap002,rtap003,rtap004,rtap005,",
               "rtap006,rtap007,rtap008,rtap009,rtap010,rtap011,rtap012,rtap013,rtap014,rtap015,rtap016,rtap017,",
               "rtap018,rtap019,rtap020,rtap021,rtap022,rtap023,rtap024,rtap025 FROM rtap_t ",
   #161222-00039#1----add---end---------------
               "   LEFT JOIN rtao_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               "  WHERE rtapent = ",g_enterprise,
               "    AND rtap001 = ? ",
               "    AND rtap008 = ? ",
               "    AND rtap020 = '2' ",
               "    AND rtap015 IN('1','2','3','4')",
               "    AND rtap021 <= '",p_date,"'",
               "    AND rtap024 = '1'",  #add by dengdd 151120---租用对象为“供应商”
               "    AND ",p_wc
   PREPARE sel_rtap2 FROM l_sql
   DECLARE sel_rtap_cs2 CURSOR FOR sel_rtap2
   FOREACH sel_rtao_cs2 INTO l_rtao.*,l_rtap008,l_rtap025 #lanjj add l_rtap025 on 2016-04-05 合同编号
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      
      #费用单单头栏位赋值
      INITIALIZE l_stba.* TO NULL
      LET l_stba.stbaownid = g_user
      LET l_stba.stbaowndp = g_dept
      LET l_stba.stbacrtid = g_user
      LET l_stba.stbacrtdp = g_dept 
      LET l_stba.stbacrtdt = cl_get_current()
      LET l_stba.stbamodid = g_user
      LET l_stba.stbamoddt = cl_get_current()
      LET l_stba.stbastus = 'N'
      LET l_stba.stbaent = g_enterprise
      LET l_stba.stbasite = l_rtao.rtaosite
      LET l_stba.stbaunit = l_rtao.rtaosite
      LET l_stba.stbadocdt = p_date
      ##預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(l_stba.stbaunit,'astt320','1')
           RETURNING r_success,r_doctype
      LET l_stba.stbadocno = r_doctype
      CALL s_aooi200_gen_docno(g_site,l_stba.stbadocno,l_stba.stbadocdt,'astt320') RETURNING r_success,l_stba.stbadocno
      IF NOT r_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_stba.stbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH              
      END IF 
      LET l_stba.stba006 = '14'              #來源類型
      LET l_stba.stba007 = l_rtao.rtao001    #來源單號
      LET l_stba.stba008 = l_rtao.rtao004    #人員
      LET l_stba.stba009 = l_rtao.rtao005    #部門    
      LET l_stba.stbastus = 'N'              #狀態碼
      LET l_stba.stba014 = '1'               #費用類型
      LET l_stba.stba015 = ''                #交款狀態
      LET l_stba.stba016 = ''                #交款人
      LET l_stba.stba000 = 'astt320'         #程式編號
      LET l_stba.stba013 = ''                #專櫃編號
      LET l_stba.stba002 = l_rtap008         #供应商编号
    #根据供应商编号抓取合同资料
#    #合同编号/经营方式/签订法人（结算中心）/结算方式/结算类型/币别/税别     
#     SELECT stan001,stan002,stan013,stan009,stan010,stan006,stan007
#       INTO l_stba.stba010,l_stba.stba003,l_stba.stba001,l_stba.stba004,
#            l_stba.stba005,l_stba.stba011,l_stba.stba012
#      FROM stan_t
#     WHERE stanent=g_enterprise
#       AND stan005=l_rtap008
#       AND stansite=l_rtao.rtaosite                                         #lanjj mark on 2016-04-05

    #lanjj add on 2016-04-05 start
    #经营方式/签订法人（结算中心）/结算方式/结算类型/币别/税别                    
     LET l_stba.stba010 = l_rtap025
     SELECT stan002,stan015,stan009,
            stan010,stan006,stan007
       INTO l_stba.stba003,l_stba.stba001,l_stba.stba004,
            l_stba.stba005,l_stba.stba011,l_stba.stba012
      FROM stan_t
     WHERE stanent = g_enterprise
       AND stan001 = l_rtap025
    
    #结算法人
      SELECT ooef017 INTO l_stba.stba022 FROM ooef_t 
       WHERE ooefent = g_enterprise AND ooef001=l_stba.stbasite
    
    
       #161222-00039#1----add---begin---------------
      #INSERT INTO stba_t VALUES(l_stba.*)
      INSERT INTO stba_t (stbaent,stbasite,stbaunit,stbadocno,stbadocdt,stba001,stba002,stba003,stba004,stba005,
                          stba006,stba007,stba008,stba009,stbastus,stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt,
                          stbamodid,stbamoddt,stbacnfid,stbacnfdt,stbaud001,stbaud002,stbaud003,stbaud004,stbaud005,
                          stbaud006,stbaud007,stbaud008,stbaud009,stbaud010,stbaud011,stbaud012,stbaud013,stbaud014,
                          stbaud015,stbaud016,stbaud017,stbaud018,stbaud019,stbaud020,stbaud021,stbaud022,stbaud023,
                          stbaud024,stbaud025,stbaud026,stbaud027,stbaud028,stbaud029,stbaud030,stba010,stba011,
                          stba012,stba013,stba014,stba015,stba000,stba016,stba017,stba018,stba019,stba020,stba021,
                          stba022,stba023,stba024,stba025,stba026,stba027)
      VALUES(l_stba.stbaent,l_stba.stbasite,l_stba.stbaunit,l_stba.stbadocno,l_stba.stbadocdt,l_stba.stba001,l_stba.stba002,l_stba.stba003,l_stba.stba004,l_stba.stba005,
             l_stba.stba006,l_stba.stba007,l_stba.stba008,l_stba.stba009,l_stba.stbastus,l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid,l_stba.stbacrtdp,l_stba.stbacrtdt,
             l_stba.stbamodid,l_stba.stbamoddt,l_stba.stbacnfid,l_stba.stbacnfdt,l_stba.stbaud001,l_stba.stbaud002,l_stba.stbaud003,l_stba.stbaud004,l_stba.stbaud005,
             l_stba.stbaud006,l_stba.stbaud007,l_stba.stbaud008,l_stba.stbaud009,l_stba.stbaud010,l_stba.stbaud011,l_stba.stbaud012,l_stba.stbaud013,l_stba.stbaud014,
             l_stba.stbaud015,l_stba.stbaud016,l_stba.stbaud017,l_stba.stbaud018,l_stba.stbaud019,l_stba.stbaud020,l_stba.stbaud021,l_stba.stbaud022,l_stba.stbaud023,
             l_stba.stbaud024,l_stba.stbaud025,l_stba.stbaud026,l_stba.stbaud027,l_stba.stbaud028,l_stba.stbaud029,l_stba.stbaud030,l_stba.stba010,l_stba.stba011,
             l_stba.stba012,l_stba.stba013,l_stba.stba014,l_stba.stba015,l_stba.stba000,l_stba.stba016,l_stba.stba017,l_stba.stba018,l_stba.stba019,l_stba.stba020,l_stba.stba021,
             l_stba.stba022,l_stba.stba023,l_stba.stba024,l_stba.stba025,l_stba.stba026,l_stba.stba027)
      #161222-00039#1----add---end---------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = " INTO stba_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH   
      END IF
      INITIALIZE l_rtap.* TO NULL
      FOREACH sel_rtap_cs2 USING l_rtao.rtao001,l_rtap008 INTO l_rtap.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         IF l_rtap.rtap017 = 0 THEN #LANJJ ADD ON 2016-02-23 协议金额为零则不生成
            CONTINUE FOREACH
         END IF
         
         #写入费用单---start----
         INITIALIZE l_stbb.* TO NULL
         LET l_stbb.stbbent = g_enterprise      #企业编号
         LET l_stbb.stbbunit = l_stba.stbaunit  #制定组织
         LET l_stbb.stbbsite = l_stba.stbasite  #营运组织
         LET l_stbb.stbbdocno = l_stba.stbadocno#单据编号
         LET l_stbb.stbb001 = l_rtap.rtap011    #费用编号
         LET l_stbb.stbb002 = l_stba.stba011    #幣別
         LET l_stbb.stbb003 = l_stba.stba012    #稅別      
         
         LET l_stbb.stbb004 = l_rtap.rtap014    #價款類別
         LET l_stbb.stbb010 = '1'               #承擔對象     
         LET l_stbb.stbb011 = l_rtap.rtap009    #所屬品類
         LET l_stbb.stbb012 = l_rtap.rtap010    #所屬部門
         LET l_stbb.stbb013 = '1'               #結算對象   
         LET l_stbb.stbb015 = l_rtap.rtap012    #納入結算單否
         LET l_stbb.stbb016 = l_rtap.rtap013    #票扣否        
         LET l_stbb.stbb017 = l_rtap.rtap019    #備註
         
         #含发票否
         SELECT stan037 INTO l_stbb.stbbud001
           FROM stan_t
          WHERE stanent = g_enterprise
            AND stan001 = l_stba.stba010

         #根据开始日期结束日期抓取结算账期和结算日期
         CALL s_settle_date_get_stbb019(l_stba.stba010,l_rtap.rtap022,l_rtap.rtap023,'1') 
            RETURNING  l_stbb.stbb018,l_stbb.stbb019  
       
         #当费用核算制度为2.权责发生制 写入费用单的开始日期和截止日期，按照自然月以及天数拆分处理
         SELECT stae005 INTO l_stae005
           FROM stae_t 
          WHERE staeent = g_enterprise
            AND stae001 = l_stbb.stbb001
         LET l_stbb009 = l_rtap.rtap017   #费用金额
         IF l_stae005 = '2' THEN    
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb009,'2') RETURNING l_stbb009
            LET l_acount_t = l_stbb009
            #根据费用开始和截止拆分
            LET l_begin = ''
            LET l_end = ''
            LET l_sum = 0
            WHILE TRUE
               #费用下次计算开始日-下次计算截止日
               CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap022,l_rtap.rtap023,l_begin,l_end,'','1','N','') RETURNING l_nextd,l_begin,l_end
               IF l_end> = l_rtap.rtap023 THEN
                  LET l_end = l_rtap.rtap023
                  LET l_exit = 'Y'   #退出循环标志 'Y' 退出
               ELSE
                  LET l_exit = 'N'
               END IF
               LET l_day = l_end - l_begin+1
               LET l_stbb.stbb005 = l_begin
               LET l_stbb.stbb006 = l_end
             
               CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt320") 
                     RETURNING l_success,l_stbb.stbb007, 
                               l_year,#会计期年度
                               l_month #会计期月份
               LET l_stbb.stbb008 = l_year                
               LET l_stbb.stbb014 = l_month
               IF NOT l_success THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF

               SELECT MAX(stbbseq)+1 INTO l_stbb.stbbseq FROM stbb_t
                WHERE stbbent = g_enterprise AND stbbdocno = l_stba.stbadocno
            
               IF cl_null(l_stbb.stbbseq) THEN
                  LET l_stbb.stbbseq = 1
               END IF
               IF l_exit = 'Y' THEN
                  LET l_stbb.stbb009 = l_acount_t -l_sum
               ELSE 
                  LET l_stbb.stbb009 = l_acount_t/(l_rtap.rtap023 - l_rtap.rtap022+1)*l_day
                  CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  
                  LET l_sum = l_sum+ l_stbb.stbb009
               END IF
               #161222-00039#1----add---begin---------------
               #INSERT INTO stbb_t VALUES(l_stbb.*)
               INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                   stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                   stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                   stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                   stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                   stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                   stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                   stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
                VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                       l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                       l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                       l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                       l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                       l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                       l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                       l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
               #161222-00039#1----add---end---------------
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = " INTO stbb_t "
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT WHILE
               END IF
               IF l_exit = 'Y' THEN     
                  EXIT WHILE
               END IF
                            
            END WHILE
            IF NOT l_success THEN 
               EXIT FOREACH 
            END IF 
         ELSE
            SELECT MAX(stbbseq) + 1 INTO l_stbb.stbbseq
              FROM stbb_t 
             WHERE stbbent = g_enterprise
               AND stbbdocno = l_stba.stbadocno
            IF cl_null(l_stbb.stbbseq) THEN 
               LET l_stbb.stbbseq = 1
            END IF 
            LET l_stbb.stbb005 = l_rtap.rtap022           #起始日期
            LET l_stbb.stbb006 = l_rtap.rtap023           #截止日期
            CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt320") 
                           RETURNING l_success,l_stbb.stbb007, 
                                     l_year,#会计期年度
                                     l_month #会计期月份
            LET l_stbb.stbb008 = l_year                
            LET l_stbb.stbb014 = l_month           #財務會計期別    
            IF NOT l_success THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_stbb.stbb009 = l_stbb009         #費用金額
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  

            #161222-00039#1----add---begin---------------
            #INSERT INTO stbb_t VALUES(l_stbb.*)
            INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
             VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                    l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                    l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                    l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                    l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                    l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                    l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                    l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
            #161222-00039#1----add---end---------------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = " INTO stbb_t "
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH   
            END IF
         END IF 
         #写入费用单----end-----
         #更新下次费用计算日、下次费用开始日、下次费用截止日
         CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap003,l_rtap.rtap004,l_rtap.rtap022,l_rtap.rtap023,'','1','N','')
              RETURNING r_nextd,r_begin,r_end
         IF l_rtap.rtap015 = '4' THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = ''
         END IF
         #下次计算日期大于失效日期清空下次费用计算日、下次费用开始日、下次费用截止日
         IF r_nextd > l_rtap.rtap004 THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = '' 
         END IF 
         UPDATE rtap_t SET rtap021 = r_nextd,
                           rtap022 = r_begin,
                           rtap023 = r_end
          WHERE rtapent = g_enterprise
            AND rtap001 = l_rtap.rtap001
            AND rtapseq = l_rtap.rtapseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = " UPD rtap_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH   
         END IF
      END FOREACH 
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单 start
      SELECT COUNT(*) INTO l_count
        FROM stbb_t
       WHERE stbbent = g_enterprise
         AND stbbdocno = l_stba.stbadocno
      IF l_count <= 0 THEN
         DELETE FROM stba_t WHERE stbaent = g_enterprise AND stbadocno = l_stba.stbadocno
      END IF 
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单  end
   END FOREACH 
  
#   #lanjj add on 2016-04-05 防止出现有单头无单身的专柜成本审批单 start
#   SELECT COUNT(*) INTO l_count
#     FROM stbb_t
#    WHERE stbbent = g_enterprise
#      AND stbbdocno = l_stba.stbadocno
#   IF l_count < 1 THEN
#      RETURN FALSE
#   END IF 
#   #lanjj add on 2016-04-05 防止出现有单头无单身的专柜成本审批单 end
  
   IF l_success THEN 
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 当计算类型为“5-先付费”，则不生成费用单，直接更新rtap
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: p_wc           条件
#                : p_date         日期
# Return code....: l_success      true or false
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-03-25 by lanjj  顾问 刘鑫
# Modify.........:
################################################################################
PRIVATE FUNCTION artp230_update_rtap015(p_wc,p_date)
DEFINE l_rtap001      LIKE rtap_t.rtap001
DEFINE l_rtapseq      LIKE rtap_t.rtapseq
DEFINE l_success      LIKE type_t.num5
DEFINE p_wc           STRING
DEFINE p_date         DATE
DEFINE l_sql          STRING

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'mhae001', 'rtap007')   
   LET p_wc = cl_replace_str(p_wc, 'rtao001', 'rtap001')   
   LET l_sql = " SELECT DISTINCT rtap001,rtapseq FROM rtap_t ",
               "  WHERE rtapent = ",g_enterprise,
               "    AND rtap020 = '2' ",
               "    AND rtap015 = '5'",
               "    AND rtap021 <= '",p_date,"'",
               "    AND ",p_wc
   PREPARE sel_rtap015 FROM l_sql
   DECLARE sel_rtap015_cs CURSOR FOR sel_rtap015
   FOREACH sel_rtap015_cs INTO l_rtap001,l_rtapseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      UPDATE rtap_t SET rtap021 = '',
                        rtap022 = '',
                        rtap023 = ''
       WHERE rtapent = g_enterprise
         AND rtap001 = l_rtap001
         AND rtapseq = l_rtapseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = " UPD rtap_t, rtap015 "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH   
         END IF
   END FOREACH 
   
   IF l_success THEN 
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 生成租赁费用单
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2016-05-16 by lanjj
# Modify.........:
################################################################################
PRIVATE FUNCTION artp230_astt810_ins(p_wc,p_date)
DEFINE p_wc           STRING
DEFINE p_date         LIKE rtap_t.rtap021
DEFINE l_sql          STRING 
#161222-00039#1----add---begin---------------
#DEFINE l_rtao         RECORD LIKE rtao_t.*
#DEFINE l_rtap         RECORD LIKE rtap_t.*
#DEFINE l_stba         RECORD LIKE stba_t.*
#DEFINE l_stbb         RECORD LIKE stbb_t.*
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
       rtaocnfdt LIKE rtao_t.rtaocnfdt  #資料確認日
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
DEFINE l_stba RECORD  #費用單資料表
       stbaent LIKE stba_t.stbaent, #企業編號
       stbasite LIKE stba_t.stbasite, #營運據點
       stbaunit LIKE stba_t.stbaunit, #應用組織
       stbadocno LIKE stba_t.stbadocno, #單據編號
       stbadocdt LIKE stba_t.stbadocdt, #單據日期
       stba001 LIKE stba_t.stba001, #結算中心
       stba002 LIKE stba_t.stba002, #供應商編號
       stba003 LIKE stba_t.stba003, #經營方式
       stba004 LIKE stba_t.stba004, #結算方式
       stba005 LIKE stba_t.stba005, #結算類型
       stba006 LIKE stba_t.stba006, #來源類型
       stba007 LIKE stba_t.stba007, #來源單號
       stba008 LIKE stba_t.stba008, #人員
       stba009 LIKE stba_t.stba009, #部門
       stbastus LIKE stba_t.stbastus, #狀態碼
       stbaownid LIKE stba_t.stbaownid, #資料所屬者
       stbaowndp LIKE stba_t.stbaowndp, #資料所有部門
       stbacrtid LIKE stba_t.stbacrtid, #資料建立者
       stbacrtdp LIKE stba_t.stbacrtdp, #資料建立部門
       stbacrtdt LIKE stba_t.stbacrtdt, #資料創建日
       stbamodid LIKE stba_t.stbamodid, #資料修改者
       stbamoddt LIKE stba_t.stbamoddt, #最近修改日
       stbacnfid LIKE stba_t.stbacnfid, #資料確認者
       stbacnfdt LIKE stba_t.stbacnfdt, #資料確認日
       stbaud001 LIKE stba_t.stbaud001, #自定義欄位(文字)001
       stbaud002 LIKE stba_t.stbaud002, #自定義欄位(文字)002
       stbaud003 LIKE stba_t.stbaud003, #自定義欄位(文字)003
       stbaud004 LIKE stba_t.stbaud004, #自定義欄位(文字)004
       stbaud005 LIKE stba_t.stbaud005, #自定義欄位(文字)005
       stbaud006 LIKE stba_t.stbaud006, #自定義欄位(文字)006
       stbaud007 LIKE stba_t.stbaud007, #自定義欄位(文字)007
       stbaud008 LIKE stba_t.stbaud008, #自定義欄位(文字)008
       stbaud009 LIKE stba_t.stbaud009, #自定義欄位(文字)009
       stbaud010 LIKE stba_t.stbaud010, #自定義欄位(文字)010
       stbaud011 LIKE stba_t.stbaud011, #自定義欄位(數字)011
       stbaud012 LIKE stba_t.stbaud012, #自定義欄位(數字)012
       stbaud013 LIKE stba_t.stbaud013, #自定義欄位(數字)013
       stbaud014 LIKE stba_t.stbaud014, #自定義欄位(數字)014
       stbaud015 LIKE stba_t.stbaud015, #自定義欄位(數字)015
       stbaud016 LIKE stba_t.stbaud016, #自定義欄位(數字)016
       stbaud017 LIKE stba_t.stbaud017, #自定義欄位(數字)017
       stbaud018 LIKE stba_t.stbaud018, #自定義欄位(數字)018
       stbaud019 LIKE stba_t.stbaud019, #自定義欄位(數字)019
       stbaud020 LIKE stba_t.stbaud020, #自定義欄位(數字)020
       stbaud021 LIKE stba_t.stbaud021, #自定義欄位(日期時間)021
       stbaud022 LIKE stba_t.stbaud022, #自定義欄位(日期時間)022
       stbaud023 LIKE stba_t.stbaud023, #自定義欄位(日期時間)023
       stbaud024 LIKE stba_t.stbaud024, #自定義欄位(日期時間)024
       stbaud025 LIKE stba_t.stbaud025, #自定義欄位(日期時間)025
       stbaud026 LIKE stba_t.stbaud026, #自定義欄位(日期時間)026
       stbaud027 LIKE stba_t.stbaud027, #自定義欄位(日期時間)027
       stbaud028 LIKE stba_t.stbaud028, #自定義欄位(日期時間)028
       stbaud029 LIKE stba_t.stbaud029, #自定義欄位(日期時間)029
       stbaud030 LIKE stba_t.stbaud030, #自定義欄位(日期時間)030
       stba010 LIKE stba_t.stba010, #合約編號
       stba011 LIKE stba_t.stba011, #幣別
       stba012 LIKE stba_t.stba012, #稅別
       stba013 LIKE stba_t.stba013, #專櫃編號/鋪位編號
       stba014 LIKE stba_t.stba014, #費用類型
       stba015 LIKE stba_t.stba015, #交款狀態
       stba000 LIKE stba_t.stba000, #程式編號
       stba016 LIKE stba_t.stba016, #交款人
       stba017 LIKE stba_t.stba017, #結算帳期
       stba018 LIKE stba_t.stba018, #結算日期
       stba019 LIKE stba_t.stba019, #開始日期
       stba020 LIKE stba_t.stba020, #結束日期
       stba021 LIKE stba_t.stba021, #成本總額
       stba022 LIKE stba_t.stba022, #法人
       stba023 LIKE stba_t.stba023, #會員折扣金額
       stba024 LIKE stba_t.stba024, #no_use
       stba025 LIKE stba_t.stba025, #合約帳期
       stba026 LIKE stba_t.stba026, #計算日期
       stba027 LIKE stba_t.stba027  #来源单号項次
       END RECORD

DEFINE l_stbb RECORD  #費用單明細資料表
       stbbent LIKE stbb_t.stbbent, #企業編號
       stbbunit LIKE stbb_t.stbbunit, #應用組織
       stbbsite LIKE stbb_t.stbbsite, #營運據點
       stbbdocno LIKE stbb_t.stbbdocno, #單據編號
       stbbseq LIKE stbb_t.stbbseq, #項次
       stbb001 LIKE stbb_t.stbb001, #費用編號
       stbb002 LIKE stbb_t.stbb002, #幣別
       stbb003 LIKE stbb_t.stbb003, #稅別
       stbb004 LIKE stbb_t.stbb004, #價款類別
       stbb005 LIKE stbb_t.stbb005, #起始日期
       stbb006 LIKE stbb_t.stbb006, #截止日期
       stbb007 LIKE stbb_t.stbb007, #結算會計期
       stbb008 LIKE stbb_t.stbb008, #財務會計期
       stbb009 LIKE stbb_t.stbb009, #費用金額
       stbb010 LIKE stbb_t.stbb010, #承擔對象
       stbb011 LIKE stbb_t.stbb011, #所屬品類
       stbb012 LIKE stbb_t.stbb012, #所屬部門
       stbb013 LIKE stbb_t.stbb013, #結算對象
       stbbud001 LIKE stbb_t.stbbud001, #含發票否
       stbbud002 LIKE stbb_t.stbbud002, #自定義欄位(文字)002
       stbbud003 LIKE stbb_t.stbbud003, #自定義欄位(文字)003
       stbbud004 LIKE stbb_t.stbbud004, #自定義欄位(文字)004
       stbbud005 LIKE stbb_t.stbbud005, #自定義欄位(文字)005
       stbbud006 LIKE stbb_t.stbbud006, #自定義欄位(文字)006
       stbbud007 LIKE stbb_t.stbbud007, #自定義欄位(文字)007
       stbbud008 LIKE stbb_t.stbbud008, #自定義欄位(文字)008
       stbbud009 LIKE stbb_t.stbbud009, #自定義欄位(文字)009
       stbbud010 LIKE stbb_t.stbbud010, #自定義欄位(文字)010
       stbbud011 LIKE stbb_t.stbbud011, #自定義欄位(數字)011
       stbbud012 LIKE stbb_t.stbbud012, #自定義欄位(數字)012
       stbbud013 LIKE stbb_t.stbbud013, #自定義欄位(數字)013
       stbbud014 LIKE stbb_t.stbbud014, #自定義欄位(數字)014
       stbbud015 LIKE stbb_t.stbbud015, #自定義欄位(數字)015
       stbbud016 LIKE stbb_t.stbbud016, #自定義欄位(數字)016
       stbbud017 LIKE stbb_t.stbbud017, #自定義欄位(數字)017
       stbbud018 LIKE stbb_t.stbbud018, #自定義欄位(數字)018
       stbbud019 LIKE stbb_t.stbbud019, #自定義欄位(數字)019
       stbbud020 LIKE stbb_t.stbbud020, #自定義欄位(數字)020
       stbbud021 LIKE stbb_t.stbbud021, #自定義欄位(日期時間)021
       stbbud022 LIKE stbb_t.stbbud022, #自定義欄位(日期時間)022
       stbbud023 LIKE stbb_t.stbbud023, #自定義欄位(日期時間)023
       stbbud024 LIKE stbb_t.stbbud024, #自定義欄位(日期時間)024
       stbbud025 LIKE stbb_t.stbbud025, #自定義欄位(日期時間)025
       stbbud026 LIKE stbb_t.stbbud026, #自定義欄位(日期時間)026
       stbbud027 LIKE stbb_t.stbbud027, #自定義欄位(日期時間)027
       stbbud028 LIKE stbb_t.stbbud028, #自定義欄位(日期時間)028
       stbbud029 LIKE stbb_t.stbbud029, #自定義欄位(日期時間)029
       stbbud030 LIKE stbb_t.stbbud030, #自定義欄位(日期時間)030
       stbb014 LIKE stbb_t.stbb014, #財務會計期別
       stbb015 LIKE stbb_t.stbb015, #納入結算單否
       stbb016 LIKE stbb_t.stbb016, #票扣否
       stbb017 LIKE stbb_t.stbb017, #備註
       stbb018 LIKE stbb_t.stbb018, #結算帳期
       stbb019 LIKE stbb_t.stbb019, #結算日期
       stbb020 LIKE stbb_t.stbb020, #日結成本類型
       stbb021 LIKE stbb_t.stbb021, #調整日期
       stbb022 LIKE stbb_t.stbb022, #商品編號
       stbb023 LIKE stbb_t.stbb023, #庫區編號
       stbb024 LIKE stbb_t.stbb024, #专柜编号
       stbb025 LIKE stbb_t.stbb025, #應收金額
       stbb026 LIKE stbb_t.stbb026, #實收金額
       stbb027 LIKE stbb_t.stbb027, #費率
       stbb028 LIKE stbb_t.stbb028, #成本金額
       stbb029 LIKE stbb_t.stbb029, #促銷銷售額
       stbb030 LIKE stbb_t.stbb030, #費用歸屬類型
       stbb031 LIKE stbb_t.stbb031, #費用歸屬組織
       stbb032 LIKE stbb_t.stbb032, #銷售數量
       stbb033 LIKE stbb_t.stbb033  #銷售單位
       END RECORD

#161222-00039#1----add---end---------------
DEFINE l_rtap008      LIKE rtap_t.rtap008
DEFINE l_rtap007      LIKE rtap_t.rtap007
DEFINE l_rtap025      LIKE rtap_t.rtap025
DEFINE r_doctype      LIKE rtai_t.rtai004
DEFINE l_success      LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE l_stfa011      LIKE stfa_t.stfa011
DEFINE l_stfa044      LIKE stfa_t.stfa044
DEFINE l_nextd        LIKE type_t.dat
DEFINE l_begin        LIKE type_t.dat
DEFINE l_end          LIKE type_t.dat
DEFINE l_sum          LIKE stbb_t.stbb009
DEFINE l_acount_t     LIKE stbb_t.stbb009
DEFINE l_exit         LIKE type_t.chr1
DEFINE l_day          LIKE type_t.num5
DEFINE l_stae005      LIKE stae_t.stae005
DEFINE l_stbb009      LIKE stbb_t.stbb009
DEFINE r_nextd        LIKE type_t.dat
DEFINE r_begin        LIKE type_t.dat
DEFINE r_end          LIKE type_t.dat
DEFINE l_year         LIKE type_t.num5
DEFINE l_month        LIKE type_t.num5
DEFINE l_stfa051      LIKE stfa_t.stfa051  
DEFINE l_count        LIKE type_t.num5
DEFINE l_stae010      LIKE stae_t.stae010

   WHENEVER ERROR CONTINUE
   LET l_success = TRUE
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'mhae001', 'rtap007')   
   #161222-00039#1----add---begin---------------   
   #LET l_sql = "SELECT DISTINCT rtao_t.*,rtap007,rtap008,rtap025  FROM rtao_t ",  
    LET l_sql = "SELECT DISTINCT rtaoent,rtaounit,rtaosite,rtaostus,rtao001,rtao002,rtao003,rtao004,rtao005,",
               "rtao006,rtaoownid,rtaoowndp,rtaocrtid,rtaocrtdp,rtaocrtdt,rtaomodid,rtaomoddt,rtaocnfid,rtaocnfdt,",
               "rtap007,rtap008,rtap025  FROM rtao_t ",   
   #161222-00039#1----add---end---------------
               "  LEFT JOIN rtap_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               " WHERE rtaoent = ",g_enterprise,
               "   AND rtap020 = '2' ",
               "   AND rtap015 IN ('1','2','3','4')",
               "   AND rtap021 <= '",p_date,"'",
               "   AND rtap024 = '4'", #租用对象为“5-客商租用”  ##mark  by zhangnan 
               #"   AND rtap024 in ('3','4') ", # add by zhangnan   3--非合同
               "   AND ",p_wc
   PREPARE sel_rtao3 FROM l_sql
   DECLARE sel_rtao_cs3 CURSOR FOR sel_rtao3
   #161222-00039#1----add---begin---------------
   #LET l_sql = " SELECT DISTINCT rtap_t.* FROM rtap_t ",
   LET l_sql = " SELECT DISTINCT rtapent,rtapsite,rtapcomp,rtapseq,rtap001,rtap002,rtap003,rtap004,rtap005,",
               "rtap006,rtap007,rtap008,rtap009,rtap010,rtap011,rtap012,rtap013,rtap014,rtap015,rtap016,rtap017,",
               "rtap018,rtap019,rtap020,rtap021,rtap022,rtap023,rtap024,rtap025 FROM rtap_t ",
   #161222-00039#1----add---end---------------
               "   LEFT JOIN rtao_t ON rtaoent = rtapent AND rtao001 = rtap001 ",
               "  WHERE rtapent = ",g_enterprise,
               "    AND rtap001 = ? ",
               "    AND rtap008 = ? ",
               "    AND rtap020 = '2' ",
               "    AND rtap015 IN ('1','2','3','4')",
               "    AND rtap021 <= '",p_date,"'",
               "    AND rtap024 = '4'",  #租用对象为“5-客商租用”  ##mark by zhangnan 
               #"    AND rtap024 in ('3','4') ",  ##add by zhangnan 3---非合同
               "    AND ",p_wc
   PREPARE sel_rtap3 FROM l_sql
   DECLARE sel_rtap_cs3 CURSOR FOR sel_rtap3
   FOREACH sel_rtao_cs3 INTO l_rtao.*,l_rtap007,l_rtap008,l_rtap025 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH
      END IF
      
      
      #费用单单头栏位赋值
      INITIALIZE l_stba.* TO NULL
      LET l_stba.stbaownid = g_user
      LET l_stba.stbaowndp = g_dept
      LET l_stba.stbacrtid = g_user
      LET l_stba.stbacrtdp = g_dept 
      LET l_stba.stbacrtdt = cl_get_current()
      LET l_stba.stbamodid = g_user
      LET l_stba.stbamoddt = cl_get_current()
      LET l_stba.stbastus = 'N'
      LET l_stba.stbaent = g_enterprise
      LET l_stba.stbasite = l_rtao.rtaosite
      LET l_stba.stbaunit = l_rtao.rtaosite
      LET l_stba.stbadocdt = p_date
      ##預設單據的單別
      LET r_success = ''
      LET r_doctype = ''
      CALL s_arti200_get_def_doc_type(l_stba.stbaunit,'astt810','1')
           RETURNING r_success,r_doctype
      LET l_stba.stbadocno = r_doctype
      CALL s_aooi200_gen_docno(g_site,l_stba.stbadocno,l_stba.stbadocdt,'astt810') RETURNING r_success,l_stba.stbadocno
      IF NOT r_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_stba.stbadocno
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH              
      END IF 
      LET l_stba.stba006 = '14'              #來源類型 astt810“门店资源协议”
      LET l_stba.stba007 = l_rtao.rtao001    #來源單號
      LET l_stba.stba008 = l_rtao.rtao004    #人員
      LET l_stba.stba009 = l_rtao.rtao005    #部門    
      LET l_stba.stbastus = 'N'              #狀態碼
      LET l_stba.stba014 = '9'                #費用類型   # 未确定 日后修改 2016-05-16 #add by zn
      LET l_stba.stba015 = ''                #交款狀態
      LET l_stba.stba016 = ''                #交款人
      LET l_stba.stba000 = 'astt810'         #程式編號
      LET l_stba.stba013 = l_rtap007         #專櫃編號
      LET l_stba.stba002 = l_rtap008         #供应商编号
      
    #根据合同抓取astm801合同资料
    #经营方式/签订法人（结算中心）/结算方式/结算类型/币别/税别                    
     LET l_stba.stba010 = l_rtap025
     SELECT stje004,stje030,stje031,
            stje032,stje036,stje038
       INTO l_stba.stba003,l_stba.stba001,l_stba.stba004,
            l_stba.stba005,l_stba.stba011,l_stba.stba012
       FROM stje_t
      WHERE stjeent = g_enterprise
        AND stje001 = l_rtap025
       ##add by zhangnan --str
      LET l_sql = "SELECT MIN(stjoseq) ",
                  "  FROM stjo_t ",
                  " WHERE stjoent = ",g_enterprise,
                  "   AND stjo001 = '",l_stba.stba010,"' ",
                  "   AND stjo005 = 'N' "
      PREPARE astt230_get_stjo002_pre31 FROM l_sql
      EXECUTE astt230_get_stjo002_pre31 INTO l_stba.stba025
      ##add by zhangnan  --end    
      #161222-00039#1----add---begin---------------
      #INSERT INTO stba_t VALUES(l_stba.*)
      INSERT INTO stba_t (stbaent,stbasite,stbaunit,stbadocno,stbadocdt,stba001,stba002,stba003,stba004,stba005,
                          stba006,stba007,stba008,stba009,stbastus,stbaownid,stbaowndp,stbacrtid,stbacrtdp,stbacrtdt,
                          stbamodid,stbamoddt,stbacnfid,stbacnfdt,stbaud001,stbaud002,stbaud003,stbaud004,stbaud005,
                          stbaud006,stbaud007,stbaud008,stbaud009,stbaud010,stbaud011,stbaud012,stbaud013,stbaud014,
                          stbaud015,stbaud016,stbaud017,stbaud018,stbaud019,stbaud020,stbaud021,stbaud022,stbaud023,
                          stbaud024,stbaud025,stbaud026,stbaud027,stbaud028,stbaud029,stbaud030,stba010,stba011,
                          stba012,stba013,stba014,stba015,stba000,stba016,stba017,stba018,stba019,stba020,stba021,
                          stba022,stba023,stba024,stba025,stba026,stba027)
      VALUES(l_stba.stbaent,l_stba.stbasite,l_stba.stbaunit,l_stba.stbadocno,l_stba.stbadocdt,l_stba.stba001,l_stba.stba002,l_stba.stba003,l_stba.stba004,l_stba.stba005,
             l_stba.stba006,l_stba.stba007,l_stba.stba008,l_stba.stba009,l_stba.stbastus,l_stba.stbaownid,l_stba.stbaowndp,l_stba.stbacrtid,l_stba.stbacrtdp,l_stba.stbacrtdt,
             l_stba.stbamodid,l_stba.stbamoddt,l_stba.stbacnfid,l_stba.stbacnfdt,l_stba.stbaud001,l_stba.stbaud002,l_stba.stbaud003,l_stba.stbaud004,l_stba.stbaud005,
             l_stba.stbaud006,l_stba.stbaud007,l_stba.stbaud008,l_stba.stbaud009,l_stba.stbaud010,l_stba.stbaud011,l_stba.stbaud012,l_stba.stbaud013,l_stba.stbaud014,
             l_stba.stbaud015,l_stba.stbaud016,l_stba.stbaud017,l_stba.stbaud018,l_stba.stbaud019,l_stba.stbaud020,l_stba.stbaud021,l_stba.stbaud022,l_stba.stbaud023,
             l_stba.stbaud024,l_stba.stbaud025,l_stba.stbaud026,l_stba.stbaud027,l_stba.stbaud028,l_stba.stbaud029,l_stba.stbaud030,l_stba.stba010,l_stba.stba011,
             l_stba.stba012,l_stba.stba013,l_stba.stba014,l_stba.stba015,l_stba.stba000,l_stba.stba016,l_stba.stba017,l_stba.stba018,l_stba.stba019,l_stba.stba020,l_stba.stba021,
             l_stba.stba022,l_stba.stba023,l_stba.stba024,l_stba.stba025,l_stba.stba026,l_stba.stba027)
      #161222-00039#1----add---end---------------
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = " INTO stba_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_success = FALSE
         EXIT FOREACH   
      END IF
      INITIALIZE l_rtap.* TO NULL
      FOREACH sel_rtap_cs3 USING l_rtao.rtao001,l_rtap008 INTO l_rtap.*
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'foreach:' 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH
         END IF
         
         IF l_rtap.rtap017 = 0 THEN #协议金额为零则不生成
            CONTINUE FOREACH
         END IF
         
         INITIALIZE l_stbb.* TO NULL
         LET l_stbb.stbbent = g_enterprise      #企业编号
         LET l_stbb.stbbunit = l_stba.stbaunit  #制定组织
         LET l_stbb.stbbsite = l_stba.stbasite  #营运组织
         LET l_stbb.stbbdocno = l_stba.stbadocno#单据编号
         LET l_stbb.stbb001 = l_rtap.rtap011    #费用编号
         LET l_stbb.stbb002 = l_stba.stba011    #幣別
         LET l_stbb.stbb003 = l_stba.stba012    #稅別      
         
         LET l_stbb.stbb004 = l_rtap.rtap014    #價款類別
         LET l_stbb.stbb010 = '1'               #承擔對象 1-交易对象 2-企业内部
         LET l_stbb.stbb011 = l_rtap.rtap009    #所屬品類
         LET l_stbb.stbb012 = l_rtap.rtap010    #所屬部門
         LET l_stbb.stbb013 = '1'               #結算對象 1-交易对象 2-企业内部
         LET l_stbb.stbb015 = l_rtap.rtap012    #納入結算單否
         LET l_stbb.stbb016 = l_rtap.rtap013    #票扣否        
         LET l_stbb.stbb017 = l_rtap.rtap019    #備註
         
         #含发票否
         SELECT stje040 INTO l_stbb.stbbud001
           FROM stje_t
          WHERE stjeent = g_enterprise
            AND stje001 = l_stba.stba010

         #根据开始日期结束日期抓取结算账期和结算日期
         CALL s_settle_date_get_stbb019(l_stba.stba010,l_rtap.rtap022,l_rtap.rtap023,'3') 
            RETURNING  l_stbb.stbb018,l_stbb.stbb019 
       
         #当费用核算制度为2.权责发生制 写入费用单的开始日期和截止日期，按照自然月以及天数拆分处理
         SELECT stae005,stae013,stae014,stae010 INTO l_stae005,l_stbb.stbb030,l_stbb.stbb031,l_stae010
           FROM stae_t 
          WHERE staeent = g_enterprise
            AND stae001 = l_stbb.stbb001
         IF  l_stbb.stbb030 ='1' THEN 
              LET l_stbb.stbb031=l_stba.stbaunit
         END IF
         IF l_stbb.stbb016='N' THEN    ##add by zhangnan 
            LET l_stbb.stbb003=l_stae010
         END IF 
         LET l_stbb009 = l_rtap.rtap017   #费用金额
         IF l_stae005 = '2' THEN    
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb009,'2') RETURNING l_stbb009
            LET l_acount_t = l_stbb009
            #根据费用开始和截止拆分
            LET l_begin = ''
            LET l_end = ''
            LET l_sum = 0
            WHILE TRUE
               #费用下次计算开始日-下次计算截止日
               CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap022,l_rtap.rtap023,l_begin,l_end,'','4','N','') RETURNING l_nextd,l_begin,l_end
               IF l_end> = l_rtap.rtap023 THEN
                  LET l_end = l_rtap.rtap023
                  LET l_exit = 'Y'   #退出循环标志 'Y' 退出
               ELSE
                  LET l_exit = 'N'
               END IF
               LET l_day = l_end - l_begin+1
               LET l_stbb.stbb005 = l_begin
               LET l_stbb.stbb006 = l_end
             
               CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt810") 
                     RETURNING l_success,l_stbb.stbb007, 
                               l_year,#会计期年度
                               l_month #会计期月份
               LET l_stbb.stbb008 = l_year                
               LET l_stbb.stbb014 = l_month
               IF NOT l_success THEN
                  LET l_success = FALSE
                  EXIT FOREACH
               END IF

               SELECT MAX(stbbseq)+1 INTO l_stbb.stbbseq FROM stbb_t
                WHERE stbbent = g_enterprise AND stbbdocno = l_stba.stbadocno
            
               IF cl_null(l_stbb.stbbseq) THEN
                  LET l_stbb.stbbseq = 1
               END IF
               IF l_exit = 'Y' THEN
                  LET l_stbb.stbb009 = l_acount_t -l_sum
               ELSE 
                  LET l_stbb.stbb009 = l_acount_t/(l_rtap.rtap023 - l_rtap.rtap022+1)*l_day
                  CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  
                  LET l_sum = l_sum+ l_stbb.stbb009
               END IF
               #161222-00039#1----add---begin---------------
               #INSERT INTO stbb_t VALUES(l_stbb.*)
               INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                   stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                   stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                   stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                   stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                   stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                   stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                   stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
                VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                       l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                       l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                       l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                       l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                       l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                       l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                       l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
               #161222-00039#1----add---end---------------
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = " INTO stbb_t "
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_success = FALSE
                  EXIT WHILE
               END IF
               IF l_exit = 'Y' THEN     
                  EXIT WHILE
               END IF
                            
            END WHILE
            IF NOT l_success THEN 
               EXIT FOREACH 
            END IF 
         ELSE
            SELECT MAX(stbbseq) + 1 INTO l_stbb.stbbseq
              FROM stbb_t 
             WHERE stbbent = g_enterprise
               AND stbbdocno = l_stba.stbadocno
            IF cl_null(l_stbb.stbbseq) THEN 
               LET l_stbb.stbbseq = 1
            END IF 
            LET l_stbb.stbb005 = l_rtap.rtap022           #起始日期
            LET l_stbb.stbb006 = l_rtap.rtap023           #截止日期
            CALL s_asti206_get_period(l_stbb.stbb005,l_stbb.stbb006,l_stba.stba001,"astt810") 
                           RETURNING l_success,l_stbb.stbb007, 
                                     l_year,#会计期年度
                                     l_month #会计期月份
            LET l_stbb.stbb008 = l_year                
            LET l_stbb.stbb014 = l_month           #財務會計期別    
            IF NOT l_success THEN
               LET l_success = FALSE
               EXIT FOREACH
            END IF
            LET l_stbb.stbb009 = l_stbb009         #費用金額
            CALL s_curr_round(l_stba.stbasite,l_stbb.stbb002,l_stbb.stbb009,'2') RETURNING l_stbb.stbb009  

            #161222-00039#1----add---begin---------------
            #INSERT INTO stbb_t VALUES(l_stbb.*)
            INSERT INTO stbb_t (stbbent,stbbunit,stbbsite,stbbdocno,stbbseq,stbb001,stbb002,stbb003,stbb004,
                                stbb005,stbb006,stbb007,stbb008,stbb009,stbb010,stbb011,stbb012,stbb013,
                                stbbud001,stbbud002,stbbud003,stbbud004,stbbud005,stbbud006,stbbud007,stbbud008,
                                stbbud009,stbbud010,stbbud011,stbbud012,stbbud013,stbbud014,stbbud015,stbbud016,
                                stbbud017,stbbud018,stbbud019,stbbud020,stbbud021,stbbud022,stbbud023,stbbud024,
                                stbbud025,stbbud026,stbbud027,stbbud028,stbbud029,stbbud030,stbb014,stbb015,
                                stbb016,stbb017,stbb018,stbb019,stbb020,stbb021,stbb022,stbb023,stbb024,stbb025,
                                stbb026,stbb027,stbb028,stbb029,stbb030,stbb031,stbb032,stbb033)
             VALUES(l_stbb.stbbent,l_stbb.stbbunit,l_stbb.stbbsite,l_stbb.stbbdocno,l_stbb.stbbseq,l_stbb.stbb001,l_stbb.stbb002,l_stbb.stbb003,l_stbb.stbb004,
                    l_stbb.stbb005,l_stbb.stbb006,l_stbb.stbb007,l_stbb.stbb008,l_stbb.stbb009,l_stbb.stbb010,l_stbb.stbb011,l_stbb.stbb012,l_stbb.stbb013,
                    l_stbb.stbbud001,l_stbb.stbbud002,l_stbb.stbbud003,l_stbb.stbbud004,l_stbb.stbbud005,l_stbb.stbbud006,l_stbb.stbbud007,l_stbb.stbbud008,
                    l_stbb.stbbud009,l_stbb.stbbud010,l_stbb.stbbud011,l_stbb.stbbud012,l_stbb.stbbud013,l_stbb.stbbud014,l_stbb.stbbud015,l_stbb.stbbud016,
                    l_stbb.stbbud017,l_stbb.stbbud018,l_stbb.stbbud019,l_stbb.stbbud020,l_stbb.stbbud021,l_stbb.stbbud022,l_stbb.stbbud023,l_stbb.stbbud024,
                    l_stbb.stbbud025,l_stbb.stbbud026,l_stbb.stbbud027,l_stbb.stbbud028,l_stbb.stbbud029,l_stbb.stbbud030,l_stbb.stbb014,l_stbb.stbb015,
                    l_stbb.stbb016,l_stbb.stbb017,l_stbb.stbb018,l_stbb.stbb019,l_stbb.stbb020,l_stbb.stbb021,l_stbb.stbb022,l_stbb.stbb023,l_stbb.stbb024,l_stbb.stbb025,
                    l_stbb.stbb026,l_stbb.stbb027,l_stbb.stbb028,l_stbb.stbb029,l_stbb.stbb030,l_stbb.stbb031,l_stbb.stbb032,l_stbb.stbb033)
            #161222-00039#1----add---end---------------
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = " INTO stbb_t "
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET l_success = FALSE
               EXIT FOREACH   
            END IF
         END IF 
         #写入费用单----end-----
         #更新下次费用计算日、下次费用开始日、下次费用截止日
         CALL s_astm301_cal_nextd(l_rtap.rtap015,'1',l_rtap.rtap003,l_rtap.rtap004,l_rtap.rtap022,l_rtap.rtap023,'','4','N','')
              RETURNING r_nextd,r_begin,r_end
         IF l_rtap.rtap015 = '4' THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = ''
         END IF
         #下次计算日期大于失效日期清空下次费用计算日、下次费用开始日、下次费用截止日
         IF r_nextd > l_rtap.rtap004 THEN 
            LET r_nextd = ''
            LET r_begin = ''
            LET r_end = '' 
         END IF 
         UPDATE rtap_t SET rtap021 = r_nextd,
                           rtap022 = r_begin,
                           rtap023 = r_end
          WHERE rtapent = g_enterprise
            AND rtap001 = l_rtap.rtap001
            AND rtapseq = l_rtap.rtapseq
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = " UPD rtap_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_success = FALSE
            EXIT FOREACH   
         END IF
      END FOREACH
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单 start
      SELECT COUNT(*) INTO l_count
        FROM stbb_t
       WHERE stbbent = g_enterprise
         AND stbbdocno = l_stba.stbadocno
      IF l_count <= 0 THEN
         DELETE FROM stba_t WHERE stbaent = g_enterprise AND stbadocno = l_stba.stbadocno
      END IF 
      #lanjj add on 2016-07-18 防止出现有单头无单身的费用单  end      
   END FOREACH 
  
   IF l_success THEN 
      RETURN TRUE
   ELSE
      RETURN FALSE
   END IF 
END FUNCTION

#end add-point
 
{</section>}
 
