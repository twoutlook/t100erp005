#該程式未解開Section, 採用最新樣板產出!
{<section id="astp402.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2015-07-22 11:42:32), PR版次:0005(2016-11-21 15:32:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: astp402
#+ Description: 專櫃合約失效批次更新作業
#+ Creator....: 06254(2015-07-21 15:40:48)
#+ Modifier...: 06254 -SD/PR- 06540
 
{</section>}
 
{<section id="astp402.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#+ Modifier...: NO.#160408-00010#3 by 02003 2016/04/11 sql语句BUG调整
#  #161101-00022#1   2016/11/01    By 02481       aooi500规范调整
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
      gtoday             DATE,  #add by dengdd 151207
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       stfasite LIKE type_t.chr10, 
   stfa005 LIKE type_t.chr20, 
   stfa010 LIKE type_t.chr10, 
   stfa001 LIKE type_t.chr20, 
   gtoday LIKE type_t.chr500, 
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
 
{<section id="astp402.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success     LIKE type_t.num5  #161101-00022#1--add

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET l_success = ''                                  #161101-00022#1-add
   CALL s_aooi500_create_temp() RETURNING l_success    #161101-00022#1-add
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp402_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp402 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp402_init()
 
      #進入選單 Menu (="N")
      CALL astp402_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp402
   END IF
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''                               #161101-00022#1--add
   CALL s_aooi500_drop_temp() RETURNING l_success   #161101-00022#1--add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp402.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp402_init()
 
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
 
{<section id="astp402.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp402_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_stfasite LIKE stfa_t.stfasite
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.gtoday =g_today
    
   DISPLAY g_master.gtoday TO gtoday
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.gtoday 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gtoday
            #add-point:BEFORE FIELD gtoday name="input.b.gtoday"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gtoday
            
            #add-point:AFTER FIELD gtoday name="input.a.gtoday"
             IF g_master.gtoday>g_today THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00380'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()                                
                  NEXT FIELD gtoday
             END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gtoday
            #add-point:ON CHANGE gtoday name="input.g.gtoday"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.gtoday
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gtoday
            #add-point:ON ACTION controlp INFIELD gtoday name="input.c.gtoday"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stfasite,stfa005,stfa010,stfa001
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
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')  #161101-00022#1--add
            CALL q_ooef001_24()                           #呼叫開窗
            LET l_stfasite=g_qryparam.return1
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
            LET l_stfasite=FGL_DIALOG_GETBUFFER()
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
            LET g_qryparam.arg1=l_stfasite
            CALL q_mhae001()                           #呼叫開窗
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
            CALL q_pmaa001_1()                           #呼叫開窗
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
            
 
 
         #Ctrlp:construct.c.stfa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stfa001
            #add-point:ON ACTION controlp INFIELD stfa001 name="construct.c.stfa001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa001  #顯示到畫面上
            NEXT FIELD stfa001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stfa001
            #add-point:BEFORE FIELD stfa001 name="construct.b.stfa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stfa001
            
            #add-point:AFTER FIELD stfa001 name="construct.a.stfa001"
            
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
            CALL astp402_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_site TO stfasite
            #end add-point
 
         ON ACTION batch_execute
            LET g_action_choice = "batch_execute"
            ACCEPT DIALOG
 
         #add-point:ui_dialog段before_qbeclear name="ui_dialog.before_qbeclear"
         AFTER DIALOG
               LET lc_param.gtoday = g_master.gtoday 
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
         CALL astp402_init()
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
                 CALL astp402_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp402_transfer_argv(ls_js)
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
 
{<section id="astp402.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp402_transfer_argv(ls_js)
 
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
 
{<section id="astp402.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp402_process(ls_js)
 
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
   DEFINE l_day         LIKE type_t.num5
   DEFINE l_msg         STRING           #160225-00040#16 20160328 add by beckxie
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
#   CALL astp402_update(g_master.wc,g_master.gtoday) RETURNING l_success #mark by dengdd 151207
#add by dengdd 151207(S)-------------
   #160225-00040#17 20160328 add by beckxie---S
   IF g_bgjob <> "Y" THEN
      CALL cl_progress_bar_no_window(2)   
   END IF
   #160225-00040#17 20160328 add by beckxie---E
   
   DISPLAY "传入：lc_param.gtoday:",lc_param.gtoday #lanjj add on 2016-10-24
   
   IF cl_null(lc_param.gtoday) THEN
      LET lc_param.gtoday = g_today
   END IF
   
   DISPLAY "为空则赋值当日处理：lc_param.gtoday:",lc_param.gtoday #lanjj add on 2016-10-24
   LET l_day=cl_get_para(g_enterprise,"","E-CIR-0057")
   LET lc_param.gtoday=lc_param.gtoday-l_day
   
   DISPLAY "参数天数 l_day:",l_day #lanjj add on 2016-10-24
   DISPLAY "传参调用 lc_param.gtoday:",lc_param.gtoday #lanjj add on 2016-10-24
   DISPLAY "传参调用 lc_param.wc:",lc_param.wc #lanjj add on 2016-10-24
   
   #160225-00040#17 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#17 20160328 add by beckxie---E
   CALL astp402_update(lc_param.wc,lc_param.gtoday) RETURNING l_success
   #160225-00040#17 20160328 add by beckxie---S
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#17 20160328 add by beckxie---E
#add by dengdd 151207(S)-------------
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp402_process_cs CURSOR FROM ls_sql
#  FOREACH astp402_process_cs INTO
   #add-point:process段process name="process.process"
   
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
       #CALL astp402_update("1=1 ",g_today-1) RETURNING l_success lanjj mark on 2016-09-05
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL astp402_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp402.get_buffer" >}
PRIVATE FUNCTION astp402_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.gtoday = p_dialog.getFieldBuffer('gtoday')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp402.msgcentre_notify" >}
PRIVATE FUNCTION astp402_msgcentre_notify()
 
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
 
{<section id="astp402.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astp402_update (p_wc,p_day)
#                  RETURNING l_success
# Input parameter: p_wc   查询条件
#                : p_day  执行日期
# Return code....: l_success   执行成功
#                : 
# Date & Author..: 2015/7/21 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astp402_update(p_wc,p_day)
DEFINE p_wc        STRING
DEFINE p_day       DATE
DEFINE l_success   LIKE type_t.num5
DEFINE l_sql       STRING
DEFINE l_wc        STRING
DEFINE l_mm        LIKE type_t.num5
DEFINE l_yy        LIKE type_t.num5
DEFINE l_glav005   LIKE glav_t.glav005
DEFINE l_glav006   LIKE glav_t.glav006
DEFINE l_glav007   LIKE glav_t.glav007
DEFINE l_glav002   LIKE glav_t.glav002
DEFINE l_glav002_1 LIKE glav_t.glav002
DEFINE l_glav006_1 LIKE glav_t.glav006
DEFINE l_glaa003   LIKE glaa_t.glaa003
DEFINE l_ooef017   LIKE ooef_t.ooef017
DEFINE l_errno     LIKE type_t.chr10
DEFINE l_flag      LIKE type_t.chr1
DEFINE l_sdate_s   LIKE glav_t.glav004
DEFINE l_sdate_e   LIKE glav_t.glav004
DEFINE l_pdate_s   LIKE glav_t.glav004
DEFINE l_pdate_e   LIKE glav_t.glav004
DEFINE l_wdate_s   LIKE glav_t.glav004
DEFINE l_wdate_e   LIKE glav_t.glav004




   #aooi500設置的組織範圍
#   CALL s_aooi500_sql_where(g_prog,'stfasite') RETURNING l_wc 

   #開啟事務
   CALL s_transaction_begin()
   
   LET l_success=TRUE
   
   #查询資料  ---会计期别
#   LET l_sql="SELECT glav006 FROM glav_t WHERE glav004 = to_date(?,'yyyy/mm/dd') AND glavstus='Y'",
#             "   AND glav001 = ( SELECT glaa003 FROM glaa_t ",
#             "                    WHERE glaaent = '",g_enterprise,"'",
#             "                      AND glaa014 = 'Y'",
#             "                      AND glaacomp= (SELECT ooef017 FROM ooef_t WHERE ooefent='",g_enterprise,"'",
#             "                                                                  AND ooef001='",g_site,"'))"
#   PREPARE astp402_sel_pre FROM l_sql  
#   EXECUTE astp402_sel_pre USING p_day INTO l_glav006
#   IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#   END IF 
#   
#   IF l_glav006 <> 1 THEN
#      LET l_mm=l_glav006-1
#      LET l_yy=YEAR(p_day)
#   ELSE
#      LET l_mm=12
#      LET l_yy=YEAR(p_day)-1
#   END IF
#   
#   LET l_dd=MDY(l_mm,1,l_yy)
#   
#   SELECT to_char(last_day(to_date(l_dd,'yyyy/mm/dd')), 'yyyy-mm-dd') INTO l_date from dual
  
#mark by dengdd 151207(S)  
#           #抓取法人對應會計週期參照表
#            LET l_ooef017 = NULL
#            LET l_glaa003 = NULL
#            
#            SELECT ooef017 INTO l_ooef017
#              FROM ooef_t
#             WHERE ooefent = g_enterprise
#               AND ooef001 = g_site
#               
#            SELECT glaa003 INTO l_glaa003
#              FROM glaa_t
#             WHERE glaaent = g_enterprise
#               AND glaacomp = l_ooef017
#               AND glaa014 = 'Y'
#               
#            #取得會計週期資料
#            CALL s_get_accdate(l_glaa003,p_day,'','')
#               RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
#                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
#                         
#            IF l_flag = 'Y' THEN
#               LET l_glav002_1 = l_glav002
#               LET l_glav006_1 = l_glav006 - 1
#               IF l_glav006_1 = 0 THEN
#                  LET l_glav002_1 = l_glav002 - 1
#                  SELECT DISTINCT MAX(glav006) INTO l_glav006_1
#                    FROM glav_t
#                   WHERE glavent = g_enterprise
#                     AND glav001 = l_glaa003
#                     AND glav002 = l_glav002_1
#               END IF
#               
#               #抓取当前日期上一会计期的起讫日期
#               CALL s_get_accdate(l_glaa003,'',l_glav002_1,l_glav006_1)
#                  RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
#                            l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
#            END IF
#mark by dengdd 151207(E)
   DISPLAY "传入参数 p_wc:",p_wc #lanjj add on 2016-10-24
   DISPLAY "传入参数 p_day:",p_day #lanjj add on 2016-10-24
   
   #更新资料  ---专柜合同状态
   LET l_sql="UPDATE stfa_t SET stfa004='7' WHERE stfa004='6' AND stfa024 <= to_date(?,'yyyy/mm/dd')",
             "                                AND stfaent= '",g_enterprise,"'",
            #"                                AND ",l_wc CLIPPED                 #160408-00010#3 mark 
             "                                AND ",p_wc CLIPPED                 #160408-00010#3 add
   PREPARE astp402_upd_pre FROM l_sql
   
   #EXECUTE astp402_upd_pre USING l_pdate_e         #160408-00010#3 mark 
   EXECUTE astp402_upd_pre USING p_day              #160408-00010#3 add
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "upd stfa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      LET l_success=FALSE
      RETURN l_success
   ELSE
      IF SQLCA.sqlerrd[3]<=0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "asf-00230"
        #LET g_errparam.extend = "upd stfa_t"   #160408-00010#3 mark 
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         LET l_success=FALSE
         RETURN l_success
      END IF      
   END IF
   
   #lanjj add on 2016-11-16 更新场地基本资料中的使用状态 0-未使用 start
   UPDATE mhad_t SET mhad008 = '0'
    WHERE mhadent = g_enterprise
      AND mhad008 != '0'
      AND EXISTS ( SELECT 1 FROM stfa_t,stfg_t 
                    WHERE atfaent = stfgent
                      AND stfa001 = stfg001 
                      AND stfgent = mhadent
                      AND stfa004 = '7'
                      AND stfg003 = mhad003
                      AND stfg002 = mhad004 )
   IF SQLCA.sqlcode THEN 
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "UPDATE mhad_t SET mhad008 = 0" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')
      LET l_success=FALSE
      RETURN l_success
   END IF 
   #lanjj add on 2016-11-16 更新场地基本资料中的使用状态 0-未使用，1-已使用  end 
         
   #事務提交
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF

   RETURN l_success

END FUNCTION

#end add-point
 
{</section>}
 
