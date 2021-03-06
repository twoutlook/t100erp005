#該程式未解開Section, 採用最新樣板產出!
{<section id="ammp422.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2014-07-17 17:56:44), PR版次:0005(2016-04-13 17:49:51)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000145
#+ Filename...: ammp422
#+ Description: 會員卡點數自動清零批次處理作業
#+ Creator....: 01533(2014-03-10 15:23:21)
#+ Modifier...: 01533 -SD/PR- 06815
 
{</section>}
 
{<section id="ammp422.global" >}
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
      mmbhsite      LIKE mmbh_t.mmbhsite,
      mmbi003       LIKE mmbi_t.mmbi003,
      basedate      LIKE type_t.dat,
      mmbh001       LIKE mmbh_t.mmbh001,
      mmbh002       LIKE mmbh_t.mmbh002,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       mmbhsite LIKE mmbh_t.mmbhsite, 
   mmbhsite_desc LIKE type_t.chr80, 
   mmbi003 LIKE mmbi_t.mmbi003, 
   mmbi003_desc LIKE type_t.chr80, 
   basedate LIKE type_t.chr500, 
   mmbh001 LIKE mmbh_t.mmbh001, 
   mmbh001_desc LIKE type_t.chr80, 
   mmbh002 LIKE mmbh_t.mmbh002, 
   mmbh002_desc LIKE type_t.chr80, 
   mman031 LIKE mman_t.mman031, 
   mman032 LIKE mman_t.mman032, 
   mman033 LIKE mman_t.mman033, 
   mman034 LIKE mman_t.mman034, 
   mman035 LIKE mman_t.mman035,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE  g_mmbhsite    LIKE mmbh_t.mmbhsite
DEFINE  g_mmbhsite_desc LIKE type_t.chr500
DEFINE  g_mmbi003     LIKE mmbi_t.mmbi003
DEFINE  g_mmbi003_desc LIKE type_t.chr500
DEFINE  g_basedate    LIKE type_t.dat
DEFINE  g_mmbh001     LIKE mmbh_t.mmbh001
DEFINE  g_mmbh001_desc LIKE type_t.chr500
DEFINE  g_mmbh002     LIKE mmbh_t.mmbh002
DEFINE  g_mmbh002_desc LIKE type_t.chr500
DEFINE  g_mman031     LIKE mman_t.mman031
DEFINE  g_mman032     LIKE mman_t.mman032
DEFINE  g_mman033     LIKE mman_t.mman033
DEFINE  g_mman034     LIKE mman_t.mman034
DEFINE  g_mman035     LIKE mman_t.mman035
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ammp422.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("amm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   display "g_argv[1]",g_argv[1]
   display "g_argv[2]",g_argv[2]
   display "g_argv[3]",g_argv[3]
   display "g_argv[4]",g_argv[4]
   display "g_argv[5]",g_argv[5]
   LET lc_param.mmbhsite = g_argv[1]
   LET lc_param.mmbi003 = g_argv[2]
   LET lc_param.basedate = g_argv[3]
   LET lc_param.mmbh001 = g_argv[4]
   LET lc_param.mmbh002 = g_argv[5]
   LET ls_js = util.JSON.stringify( lc_param )
   IF lc_param.mmbhsite IS NOT NULL THEN
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
      CALL ammp422_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammp422 WITH FORM cl_ap_formpath("amm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ammp422_init()
 
      #進入選單 Menu (="N")
      CALL ammp422_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ammp422
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#4  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ammp422.init" >}
#+ 初始化作業
PRIVATE FUNCTION ammp422_init()
 
   #add-point:init段define (客製用) name="init.define_customerization"
   
   #end add-point
   #add-point:ui_dialog段define name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#4  By benson 150309
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
   CALL cl_set_combo_scc("mman031","6504")
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#4  By benson 150309
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ammp422.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ammp422_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE  l_errno               LIKE type_t.chr10
   DEFINE  l_success             LIKE type_t.num5
   LET g_mmbhsite = g_site
   LET g_basedate = g_today
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
         
         
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT g_mmbhsite,g_mmbi003, g_basedate, g_mmbh001,g_mmbh002 FROM mmbhsite,mmbi003,basedate,mmbh001,mmbh002
           ATTRIBUTE(WITHOUT DEFAULTS)
          
             BEFORE INPUT
                DISPLAY g_mmbhsite TO mmbhsite
                CALL ammp422_mmbhsite_ref()
                DISPLAY g_basedate TO basedate
           
  
             AFTER FIELD mmbhsite
                DISPLAY '' to mmbhsite_desc
                IF NOT cl_null(g_mmbhsite) THEN
#                   INITIALIZE g_chkparam.* TO NULL
#                   LET g_errshow = '1'
#                   LET g_chkparam.arg1 = g_mmbhsite
#                   LET g_chkparam.arg2 = '8'
#                   LET g_chkparam.arg3 = g_site
#                   IF NOT cl_chk_exist("v_ooed004") THEN
#                      NEXT FIELD CURRENT
#                   END IF
               CALL s_aooi500_chk(g_prog,'mmbhsite',g_mmbhsite,g_mmbhsite)
                  RETURNING l_success,l_errno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = l_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
            
#                  LET g_stca_m.stcasite = g_stca_m_t.stcasite
#                  CALL s_desc_get_department_desc(g_mmbhsite)
#                     RETURNING g_mmbhsite_desc
#                  DISPLAY BY NAME g_mmbhsite,g_mmbhsite_desc
                  NEXT FIELD CURRENT
                  
                END IF
                END IF
                CALL ammp422_mmbhsite_ref()
             
             AFTER FIELD mmbi003
                DISPLAY '' TO mmbi003_desc
                IF NOT cl_null(g_mmbi003) THEN
                   #設定g_chkparam.*的參數
                   LET g_chkparam.arg1 = g_mmbi003
                   LET g_errshow = 1
                    #呼叫檢查存在並帶值的library
                   IF NOT cl_chk_exist("v_mman001_4") THEN
                    #檢查失敗時後續處理
                      NEXT FIELD CURRENT
                   ELSE
                      CALL ammp422_mmbi003_other()
                   END IF
                                      
                END IF
                CALL ammp422_mmbi003_ref()
                
             AFTER FIELD basedate
                IF NOT cl_null(g_basedate) THEN
                   IF g_basedate > g_today THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'amm-00207'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      NEXT FIELD CURRENT
                   END IF
                END IF
             
             AFTER FIELD mmbh001
                DISPLAY '' TO mmbh001_desc
                IF NOT cl_null(g_mmbh001) THEN
                   IF NOT s_azzi650_chk_exist('2055',g_mmbh001) THEN
                      NEXT FIELD CURRENT            
                   END IF   
                END IF
                CALL ammp422_mmbh001_ref()
             
             AFTER FIELD mmbh002
                DISPLAY '' TO mmbh002_desc
                IF NOT cl_null(g_mmbh002) THEN
                   IF NOT s_azzi650_chk_exist('2056',g_mmbh002) THEN
                      NEXT FIELD CURRENT            
                   END IF  
                END IF
                CALL ammp422_mmbh002_ref()
                
             ON ACTION controlp INFIELD mmbhsite
                 #開窗i段
		           INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
		           LET g_qryparam.reqry = FALSE
		         
                 LET g_qryparam.default1 = g_mmbhsite             #給予default值
#		         LET g_qryparam.arg1 = g_site#
#                 LET g_qryparam.arg2 = "8" #
#                 CALL q_ooed004()                                #呼叫開窗
		           LET g_qryparam.where = s_aooi500_q_where(g_prog,'mmbhsite',g_site,'i')   #150308-00001#4  By benson add 'i'
                 CALL q_ooef001_24()
                 LET g_mmbhsite = g_qryparam.return1              #將開窗取得的值回傳到變數
		         
                 DISPLAY g_mmbhsite TO mmbhsite              #顯示到畫面上
		         CALL ammp422_mmbhsite_ref() 
                 NEXT FIELD mmbhsite      
             
              ON ACTION controlp INFIELD mmbi003
                 #開窗i段
		         INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
		         
                 LET g_qryparam.default1 = g_mmbi003           #給予default值
		         
                 CALL q_mman001_6()                                #呼叫開窗
		         
                 LET g_mmbi003 = g_qryparam.return1              #將開窗取得的值回傳到變數
		         
                 DISPLAY g_mmbi003 TO mmbi003              #顯示到畫面上
		         CALL ammp422_mmbi003_ref() 
                 NEXT FIELD mmbi003   

              ON ACTION controlp INFIELD mmbh001
                 #開窗i段
		         INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
		         
                 LET g_qryparam.default1 = g_mmbh001            #給予default值
		         LET g_qryparam.arg1 = '2055'
                 CALL q_oocq002()                                #呼叫開窗
		         
                 LET g_mmbh001 = g_qryparam.return1              #將開窗取得的值回傳到變數
		         
                 DISPLAY g_mmbh001 TO mmbh001              #顯示到畫面上
		         CALL ammp422_mmbh001_ref()
                 NEXT FIELD mmbh001      
                 
              ON ACTION controlp INFIELD mmbh002
                 #開窗i段
		         INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'i'
		         LET g_qryparam.reqry = FALSE
		         
                 LET g_qryparam.default1 = g_mmbh002            #給予default值
		         LET g_qryparam.arg1 = '2056'
                 CALL q_oocq002()                                #呼叫開窗
		         
                 LET g_mmbh002 = g_qryparam.return1              #將開窗取得的值回傳到變數
		         
                 DISPLAY g_mmbh002 TO mmbh002              #顯示到畫面上
		         CALL ammp422_mmbh002_ref()
                 NEXT FIELD mmbh002  
             
         END INPUT

         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL ammp422_get_buffer(l_dialog)
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
         CALL ammp422_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
     
    # IF NOT INT_FLAG THEN
    #    CASE
    #       WHEN g_schedule.cycle = 0
    #          CALL ammp422_process(ls_js)
    #       WHEN g_schedule.cycle = 1
    #          LET ls_js = ammp422_transfer_argv(ls_js)
    #          CALL cl_cmdrun(ls_js)
    #       WHEN g_schedule.cycle = 2
    #          DISPLAY "INFO:寫入排程"
    #    END CASE
    # END IF
    #  LET ls_js = util.JSON.stringify(lc_param)
    #  IF NOT INT_FLAG THEN
    #      CALL ammp422_process(ls_js)
    #  END IF
    
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
                 CALL ammp422_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ammp422_transfer_argv(ls_js)
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
 
{<section id="ammp422.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ammp422_transfer_argv(ls_js)
 
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
 
{<section id="ammp422.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ammp422_process(ls_js)
 
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
   DEFINE l_msg         STRING   #160225-00040#18 2016/04/13 s983961--add
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
      CALL cl_progress_bar_no_window(2)  #160225-00040#18 2016/04/13 s983961--add
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ammp422_process_cs CURSOR FROM ls_sql
#  FOREACH ammp422_process_cs INTO
   #add-point:process段process name="process.process"
   CALL s_transaction_begin()   
   CALL cl_showmsg_init()
   CALL cl_err_collect_init()   #160225-00040#18 2016/04/13 s983961--add
   
   LET l_success = TRUE
   #160225-00040# 20160302 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
   #160225-00040# 20160302 s983961--add(e)
   CALL s_ammp422_pointclean_upd(g_mmbhsite,g_mmbi003,g_basedate,g_mmbh001,g_mmbh002) RETURNING l_success
   IF l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      CALL s_transaction_end("Y","0")
   ELSE
      CALL cl_showmsg()
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end("N","0")
   END IF
   
   #160225-00040#18 2016/04/13 s983961--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   CALL cl_err_collect_show() 
   #160225-00040#18 2016/04/13 s983961--add(e)   
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
   CALL ammp422_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="ammp422.get_buffer" >}
PRIVATE FUNCTION ammp422_get_buffer(p_dialog)
 
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
 
{<section id="ammp422.msgcentre_notify" >}
PRIVATE FUNCTION ammp422_msgcentre_notify()
 
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
 
{<section id="ammp422.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammp422_mmbhsite_ref()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbhsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmbhsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_mmbhsite_desc TO mmbhsite_desc
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammp422_mmbi003_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmbi003
   CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_lang||"'", "") RETURNING g_rtn_fields
   LET g_mmbi003_desc = '', g_rtn_fields[1] , ''
   DISPLAY  g_mmbi003_desc TO mmbi003_desc 
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammp422_mmbh001_ref()
   INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_mmbh001
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2055' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_mmbh001_desc = '', g_rtn_fields[1] , ''
    DISPLAY  g_mmbh001_desc TO mmbh001_desc
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammp422_mmbh002_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_mmbh002
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2056' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_mmbh002_desc = '', g_rtn_fields[1] , ''
    DISPLAY  g_mmbh002_desc TO mmbh002_desc
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
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION ammp422_mmbi003_other()
   
   SELECT mman031,mman032,mman033,mman034,mman035 INTO g_mman031,g_mman032,g_mman033,g_mman034,g_mman035 FROM mman_t
    WHERE mmanent = g_enterprise AND mman001 = g_mmbi003
    
   DISPLAY  g_mman031 TO mman031
   DISPLAY  g_mman032 TO mman032
   DISPLAY  g_mman033 TO mman033
   DISPLAY  g_mman034 TO mman034
   DISPLAY  g_mman035 TO mman035
END FUNCTION

#end add-point
 
{</section>}
 
