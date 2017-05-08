#該程式未解開Section, 採用最新樣板產出!
{<section id="acrp110.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2015-04-07 17:12:08), PR版次:0003(2016-05-05 19:53:05)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000096
#+ Filename...: acrp110
#+ Description: 會員生命週期評估作業
#+ Creator....: 01251(2014-06-16 14:28:13)
#+ Modifier...: 01251 -SD/PR- 06815
 
{</section>}
 
{<section id="acrp110.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
# 160420-00006#1 2016/04/20 进度条修改
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
       mmaf001 LIKE mmaf_t.mmaf001, 
   year11 LIKE type_t.num5, 
   month11 LIKE type_t.num5, 
   check11 LIKE type_t.chr1, 
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
 
{<section id="acrp110.main" >}
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
   CALL cl_ap_init("acr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL acrp110_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrp110 WITH FORM cl_ap_formpath("acr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL acrp110_init()
 
      #進入選單 Menu (="N")
      CALL acrp110_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_acrp110
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="acrp110.init" >}
#+ 初始化作業
PRIVATE FUNCTION acrp110_init()
 
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
 
{<section id="acrp110.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrp110_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_year    LIKE type_t.num5
   DEFINE l_month   LIKE type_t.num5  
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.year11,g_master.month11,g_master.check11 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD year11
            #add-point:BEFORE FIELD year11 name="input.b.year11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD year11
            
            #add-point:AFTER FIELD year11 name="input.a.year11"
            IF NOT cl_null(g_master.year11) THEN
               IF g_master.year11>YEAR(TODAY) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00046'
                  LET g_errparam.extend = g_master.year11
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD year11
               END IF
            END IF     
            IF NOT cl_null(g_master.year11) AND NOT cl_null(g_master.month11) THEN
               IF g_master.year11=YEAR(TODAY)  AND g_master.month11>MONTH(TODAY) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00046'
                  LET g_errparam.extend = g_master.year11
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD month11
               END IF
            END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE year11
            #add-point:ON CHANGE year11 name="input.g.year11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD month11
            #add-point:BEFORE FIELD month11 name="input.b.month11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD month11
            
            #add-point:AFTER FIELD month11 name="input.a.month11"
              IF NOT cl_null(g_master.year11) AND NOT cl_null(g_master.month11) THEN
                 IF g_master.year11=YEAR(TODAY)  AND g_master.month11>MONTH(TODAY) THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00046'
                    LET g_errparam.extend = g_master.year11
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD month11
                 END IF
              END IF  
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE month11
            #add-point:ON CHANGE month11 name="input.g.month11"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD check11
            #add-point:BEFORE FIELD check11 name="input.b.check11"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD check11
            
            #add-point:AFTER FIELD check11 name="input.a.check11"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE check11
            #add-point:ON CHANGE check11 name="input.g.check11"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.year11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD year11
            #add-point:ON ACTION controlp INFIELD year11 name="input.c.year11"
            
            #END add-point
 
 
         #Ctrlp:input.c.month11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD month11
            #add-point:ON ACTION controlp INFIELD month11 name="input.c.month11"
            
            #END add-point
 
 
         #Ctrlp:input.c.check11
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD check11
            #add-point:ON ACTION controlp INFIELD check11 name="input.c.check11"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON mmaf001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.mmaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mmaf001
            #add-point:ON ACTION controlp INFIELD mmaf001 name="construct.c.mmaf001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaf001  #顯示到畫面上
            NEXT FIELD mmaf001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mmaf001
            #add-point:BEFORE FIELD mmaf001 name="construct.b.mmaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mmaf001
            
            #add-point:AFTER FIELD mmaf001 name="construct.a.mmaf001"
            
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
            CALL acrp110_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            IF cl_null(g_master.year11) OR g_master.year11=0 THEN
               LET l_year=YEAR(TODAY)
               LET g_master.year11=l_year
            END IF    
            IF cl_null(g_master.month11) OR g_master.month11=0 THEN
               LET l_month=MONTH(TODAY)-1
               LET g_master.month11=l_month
            END IF    
            IF g_master.month11<=0 THEN
               LET g_master.year11=l_year-1
               LET g_master.month11=l_month+12
            END IF
            IF cl_null(g_master.check11) THEN
               LET g_master.check11='Y'
            END IF    
            
            DISPLAY g_master.year11   TO year11
            DISPLAY g_master.month11  TO month11
            DISPLAY g_master.check11  TO check11
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
         CALL acrp110_init()
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
                 CALL acrp110_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = acrp110_transfer_argv(ls_js)
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
 
{<section id="acrp110.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION acrp110_transfer_argv(ls_js)
 
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
   LET la_cmdrun.param[1] = g_master.wc
   LET la_cmdrun.param[2] = g_master.year11
   LET la_cmdrun.param[3] = g_master.month11
   LET la_cmdrun.param[4] = g_master.check11 
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="acrp110.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION acrp110_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_msg       LIKE type_t.chr100   #160225-00040#1 s983961 160505--add
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
      #160225-00040#1 20160505 s983961--mod(s)
      #add by 08172
      #LET li_count = 1
      #CALL cl_progress_bar_no_window(li_count)
      CALL cl_progress_bar_no_window(4)
      #160225-00040#1 20160505 s983961--mod(e)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE acrp110_process_cs CURSOR FROM ls_sql
#  FOREACH acrp110_process_cs INTO
   #add-point:process段process name="process.process"
  
   CALL s_acrp110_insert(g_master.wc,g_master.year11,g_master.month11,g_master.check11) RETURNING l_success
   #CALL cl_progress_no_window_ing(l_success)  ##160225-00040#1 20160505 s983961--mark
   
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
   CALL acrp110_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="acrp110.get_buffer" >}
PRIVATE FUNCTION acrp110_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.year11 = p_dialog.getFieldBuffer('year11')
   LET g_master.month11 = p_dialog.getFieldBuffer('month11')
   LET g_master.check11 = p_dialog.getFieldBuffer('check11')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="acrp110.msgcentre_notify" >}
PRIVATE FUNCTION acrp110_msgcentre_notify()
 
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
 
{<section id="acrp110.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 批次產生資料的進度條顯示次數
# Memo...........:
# Usage..........: CALL acrp110_msg_show(p_cnt)
# Input parameter: p_cnt
# Date & Author..: 20160505 By s983961
# Modify.........:
################################################################################
PUBLIC FUNCTION acrp110_msg_show(p_cnt)
DEFINE p_cnt            LIKE type_t.num5
DEFINE l_min_cnt        LIKE type_t.num5
DEFINE l_i              LIKE type_t.num5
DEFINE l_msg            STRING           

   LET l_min_cnt = 1
   IF p_cnt >1 THEN
     FOR l_i = l_min_cnt TO p_cnt
        LET l_msg = cl_getmsg('ast-00330',g_lang)
        CALL cl_progress_no_window_ing(l_msg)     
     END FOR
   END IF
   
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)    
END FUNCTION

#end add-point
 
{</section>}
 
