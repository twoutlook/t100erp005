#該程式未解開Section, 採用最新樣板產出!
{<section id="aprp300.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-08-25 18:00:29), PR版次:0002(2016-05-09 18:05:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: aprp300
#+ Description: 專櫃促銷成本自動補差批次作業
#+ Creator....: 01251(2015-08-25 09:38:48)
#+ Modifier...: 01251 -SD/PR- 02159
 
{</section>}
 
{<section id="aprp300.global" >}
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
   prcf010 LIKE prcf_t.prcf010,
   wc1     STRING,
   wc2     STRING,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       prcf010 LIKE prcf_t.prcf010, 
   pregsite LIKE preg_t.pregsite, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
#DEFINE g_cwc              STRING
#DEFINE g_cwc2             STRING   #MARKED BY LANJJ 2015-09-24
DEFINE g_wc0              STRING    #ADDED BY LANJJ 2015-09-24
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aprp300.main" >}
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
   CALL cl_ap_init("apr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aprp300_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprp300 WITH FORM cl_ap_formpath("apr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aprp300_init()
 
      #進入選單 Menu (="N")
      CALL aprp300_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aprp300
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aprp300.init" >}
#+ 初始化作業
PRIVATE FUNCTION aprp300_init()
 
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
 
{<section id="aprp300.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aprp300_ui_dialog()
 
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
      LET g_master.prcf010 =g_today
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.prcf010 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prcf010
            #add-point:BEFORE FIELD prcf010 name="input.b.prcf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prcf010
            
            #add-point:AFTER FIELD prcf010 name="input.a.prcf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prcf010
            #add-point:ON CHANGE prcf010 name="input.g.prcf010"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.prcf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prcf010
            #add-point:ON ACTION controlp INFIELD prcf010 name="input.c.prcf010"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
     CONSTRUCT  g_wc0 ON pregsite,prcf001,inaa001 
                            FROM preg_t.pregsite,prcf_t.prcf001,inaa_t.inaa001
                ON ACTION controlp INFIELD pregsite
                   #add-point:ON ACTION controlp INFIELD pregsite
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c' 
                   LET g_qryparam.reqry = FALSE
                   CALL q_ooef001()                           #呼叫開窗
                   DISPLAY g_qryparam.return1 TO pregsite  #顯示到畫面上
                   NEXT FIELD pregsite
             
                ON ACTION controlp INFIELD prcf001
                
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c' 
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.arg1 = '3'
                   CALL q_prcf001()                       #呼叫開窗
                   DISPLAY g_qryparam.return1 TO prcf001  #顯示到畫面上
                   NEXT FIELD prcf001                     #返回原欄位              
               
                ON ACTION controlp INFIELD inaa001
               
                   INITIALIZE g_qryparam.* TO NULL
                   LET g_qryparam.state = 'c' 
                   LET g_qryparam.reqry = FALSE
                   LET g_qryparam.where = " inaa135='2'"   #促销库区
                   CALL q_inaa001()                        #呼叫開窗
                   DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上
                   NEXT FIELD inaa001                     #返回原欄位
             END CONSTRUCT       
 # MARKED BY LANJJ 2015-09-24 （需求：把三个参数合成一个）           
#         CONSTRUCT g_cwc ON prcf001 FROM prcf001
#            BEFORE CONSTRUCT
#
#
#            ON ACTION controlp INFIELD prcf001
#            
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.arg1 = '3'
#               CALL q_prcf001()                       #呼叫開窗
#               DISPLAY g_qryparam.return1 TO prcf001  #顯示到畫面上
#               NEXT FIELD prcf001                     #返回原欄位                        
#                       
#            BEFORE FIELD prcf001
#            
#            AFTER FIELD prcf001
#           
#                       
#         END CONSTRUCT
#
#
#         CONSTRUCT g_cwc2 ON inaa001 FROM inaa001
#            BEFORE CONSTRUCT
#
#            
#            ON ACTION controlp INFIELD inaa001
#           
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'c' 
#               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where = " inaa135='2'"   #促销库区
#               CALL q_inaa001()                        #呼叫開窗
#               DISPLAY g_qryparam.return1 TO inaa001  #顯示到畫面上
#               NEXT FIELD inaa001                     #返回原欄位
#                                
#           
#            BEFORE FIELD inaa001
#           
#            AFTER FIELD inaa001
#            
#            
#         END CONSTRUCT

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
            CALL aprp300_get_buffer(l_dialog)
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
# MARKED BY LANJJ 2015-09-24 （需求：把三个参数合成一个）      
#            LET g_cwc=''
#            LET g_cwc2=''
            LET g_wc0 = '' #ADDED by LanJJ 2015-09-24 
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
         CALL aprp300_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.prcf010   = g_master.prcf010
# MARKED BY LANJJ 2015-09-24 （需求：把三个参数合成一个）      
#      LET lc_param.wc1       = g_cwc
#      LET lc_param.wc2       = g_cwc2
      LET lc_param.wc = g_wc0  #ADDED BY LANJJ 2015-09-24 （重新赋值）
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
                 CALL aprp300_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aprp300_transfer_argv(ls_js)
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
 
{<section id="aprp300.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aprp300_transfer_argv(ls_js)
 
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
 
{<section id="aprp300.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aprp300_process(ls_js)
 
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
   DEFINE l_loop        LIKE type_t.num5   #160225-00040#14 160509 by sakura add
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
      LET l_loop = 3
      CALL cl_progress_bar_no_window(l_loop)
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aprp300_process_cs CURSOR FROM ls_sql
#  FOREACH aprp300_process_cs INTO
   #add-point:process段process name="process.process"
   
   CALL s_transaction_begin()
    
#  CALL s_aprp300_insert(lc_param.wc,lc_param.prcf010,lc_param.wc1,lc_param.wc2) RETURNING l_success #marked by lanjj
   CALL s_aprp300_ins(lc_param.wc,lc_param.prcf010) RETURNING l_success #ADDED BY LanJJ 2015-09-24
    
   IF NOT l_success THEN
      CALL s_transaction_end('N','0')
   ELSE
      CALL s_transaction_end('Y','0')
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
   CALL aprp300_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aprp300.get_buffer" >}
PRIVATE FUNCTION aprp300_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.prcf010 = p_dialog.getFieldBuffer('prcf010')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprp300.msgcentre_notify" >}
PRIVATE FUNCTION aprp300_msgcentre_notify()
 
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
 
{<section id="aprp300.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
