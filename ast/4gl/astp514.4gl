#該程式未解開Section, 採用最新樣板產出!
{<section id="astp514.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-09-14 10:31:03), PR版次:0008(2016-09-13 18:07:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: astp514
#+ Description: 合約銀行卡費用明細計算批次作業
#+ Creator....: 06370(2015-07-30 12:55:18)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="astp514.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#160913-00034#1    2016/09/13 by 08172   q_pmaa001開窗替换
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
   stgd002    LIKE stgd_t.stgd002,   #统计日期
   stgd013    LIKE stgd_t.stgd013,   #經營方式   #160613-00045#4 20160615 add by beckxie
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       rtjbsite LIKE type_t.chr10, 
   rtjb028 LIKE type_t.chr20, 
   rtjb004 LIKE type_t.chr500, 
   stgd014 LIKE type_t.chr20, 
   stgd013 LIKE type_t.chr10, 
   rtjadocdt LIKE type_t.dat, 
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
 
{<section id="astp514.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_success   LIKE type_t.num5   #160604-00009#164 20160725 add by beckxie
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ast","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   CALL s_aooi500_create_temp() RETURNING l_success   #160604-00009#164 20160725 add by beckxie
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL astp514_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astp514 WITH FORM cl_ap_formpath("ast",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL astp514_init()
 
      #進入選單 Menu (="N")
      CALL astp514_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_astp514
   END IF
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #160604-00009#164 20160725 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="astp514.init" >}
#+ 初始化作業
PRIVATE FUNCTION astp514_init()
 
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
   CALL cl_set_combo_scc_part('stgd013','6013','4,5')   #160613-00045#4 20160615 add by beckxie
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="astp514.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astp514_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_rtjbsite LIKE rtjb_t.rtjbsite
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.rtjadocdt = g_today
   DISPLAY BY NAME g_master.rtjadocdt 
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.stgd013,g_master.rtjadocdt 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stgd013
            #add-point:BEFORE FIELD stgd013 name="input.b.stgd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stgd013
            
            #add-point:AFTER FIELD stgd013 name="input.a.stgd013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE stgd013
            #add-point:ON CHANGE stgd013 name="input.g.stgd013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjadocdt
            #add-point:BEFORE FIELD rtjadocdt name="input.b.rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjadocdt
            
            #add-point:AFTER FIELD rtjadocdt name="input.a.rtjadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rtjadocdt
            #add-point:ON CHANGE rtjadocdt name="input.g.rtjadocdt"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.stgd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stgd013
            #add-point:ON ACTION controlp INFIELD stgd013 name="input.c.stgd013"
            
            #END add-point
 
 
         #Ctrlp:input.c.rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjadocdt
            #add-point:ON ACTION controlp INFIELD rtjadocdt name="input.c.rtjadocdt"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtjbsite,rtjb028,rtjb004,stgd014
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtjbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjbsite
            #add-point:ON ACTION controlp INFIELD rtjbsite name="construct.c.rtjbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            LET l_rtjbsite=g_qryparam.return1
            DISPLAY g_qryparam.return1 TO rtjbsite  #顯示到畫面上
            NEXT FIELD rtjbsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjbsite
            #add-point:BEFORE FIELD rtjbsite name="construct.b.rtjbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjbsite
            
            #add-point:AFTER FIELD rtjbsite name="construct.a.rtjbsite"
            LET l_rtjbsite=FGL_DIALOG_GETBUFFER()
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtjb028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjb028
            #add-point:ON ACTION controlp INFIELD rtjb028 name="construct.c.rtjb028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160613-00045#4 20160615 mark by beckxie---S
            #LET g_qryparam.arg1=l_rtjbsite
            #CALL q_mhae001()                           #呼叫開窗
            #160613-00045#4 20160615 mark by beckxie---E
            CALL q_stgd005()   #160613-00045#4 20160615 add by beckxie
            DISPLAY g_qryparam.return1 TO rtjb028  #顯示到畫面上
            NEXT FIELD rtjb028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjb028
            #add-point:BEFORE FIELD rtjb028 name="construct.b.rtjb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjb028
            
            #add-point:AFTER FIELD rtjb028 name="construct.a.rtjb028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtjb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtjb004
            #add-point:ON ACTION controlp INFIELD rtjb004 name="construct.c.rtjb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#1 -s by 08172
            LET g_qryparam.arg1 = "('3')"
            CALL q_pmaa001_1()
#            CALL q_pmaa001()                           #呼叫開窗
            #160913-00034#1 -e by 08172
            DISPLAY g_qryparam.return1 TO rtjb004  #顯示到畫面上
            NEXT FIELD rtjb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtjb004
            #add-point:BEFORE FIELD rtjb004 name="construct.b.rtjb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtjb004
            
            #add-point:AFTER FIELD rtjb004 name="construct.a.rtjb004"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stgd014
            #add-point:BEFORE FIELD stgd014 name="construct.b.stgd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stgd014
            
            #add-point:AFTER FIELD stgd014 name="construct.a.stgd014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stgd014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stgd014
            #add-point:ON ACTION controlp INFIELD stgd014 name="construct.c.stgd014"
            #160613-00045#4 20160615 add by beckxie---S
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stgd014_1()   
            DISPLAY g_qryparam.return1 TO stgd014  #顯示到畫面上
            NEXT FIELD stgd014                     #返回原欄位
            #160613-00045#4 20160615 add by beckxie---E
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
            CALL astp514_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_site TO rtjbsite
       
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
         CALL astp514_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.stgd002 = g_master.rtjadocdt
      LET lc_param.stgd013 = g_master.stgd013   #160613-00045#4 20160615 add by beckxie
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
                 CALL astp514_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = astp514_transfer_argv(ls_js)
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
 
{<section id="astp514.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION astp514_transfer_argv(ls_js)
 
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
 
{<section id="astp514.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION astp514_process(ls_js)
 
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
   DEFINE l_msg         LIKE type_t.chr100   #160225-00040#18 2016/04/13 s983961--add
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN 
      LET g_master.wc = " 1=1" 
   END IF
#mark by yangxf ----start---
#   IF cl_null(g_master.rtjadocdt) THEN 
#      LET g_master.rtjadocdt = g_today-1 
#   END IF
#   CALL astp514_update(g_master.wc,g_master.rtjadocdt) RETURNING l_success
#mark by yangxf ----end---
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      CALL cl_progress_bar_no_window(2)   #160225-00040#18 2016/04/13 s983961--add 
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE astp514_process_cs CURSOR FROM ls_sql
#  FOREACH astp514_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#18 2016/04/13 s983961--add(s)
   LET l_msg = cl_getmsg('ast-00330',g_lang)   
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#18 2016/04/13 s983961--add(e)
   
   IF cl_null(lc_param.stgd002) THEN 
      LET lc_param.stgd002 = g_today-1                                        #add by yangxf 
   END IF 
   #160613-00045#4 20160615 modify by beckxie---S
   #CALL astp514_update(lc_param.wc,lc_param.stgd002) RETURNING l_success   #add by yangxf 
   CASE 
      WHEN cl_null(lc_param.stgd013) 
         CALL astp514_update(lc_param.wc,lc_param.stgd002) RETURNING l_success   #add by yangxf 
         CALL astp514_update_1(lc_param.wc,lc_param.stgd002) RETURNING l_success  
      WHEN lc_param.stgd013 = '5'
         CALL astp514_update_1(lc_param.wc,lc_param.stgd002) RETURNING l_success
      OTHERWISE
         CALL astp514_update(lc_param.wc,lc_param.stgd002) RETURNING l_success   #add by yangxf 
   END CASE
   #160613-00045#4 20160615 modify by beckxie---E
   #160225-00040#18 2016/04/13 s983961--add(s)
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)  
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
   CALL astp514_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="astp514.get_buffer" >}
PRIVATE FUNCTION astp514_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.stgd013 = p_dialog.getFieldBuffer('stgd013')
   LET g_master.rtjadocdt = p_dialog.getFieldBuffer('rtjadocdt')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="astp514.msgcentre_notify" >}
PRIVATE FUNCTION astp514_msgcentre_notify()
 
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
 
{<section id="astp514.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........: 20160615改為 非5.租賃使用
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/30 By liaolong
# Modify.........: 非5.租賃使用 #160613-00045#4 20160615 add by beckxie
################################################################################
PRIVATE FUNCTION astp514_update(p_wc,p_day)
DEFINE p_wc           STRING
DEFINE p_day          DATE
DEFINE l_success      LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_sql0          STRING
DEFINE l_wc           STRING
DEFINE l_mm           LIKE type_t.num5
DEFINE l_yy           LIKE type_t.num5
DEFINE l_glav006      LIKE glav_t.glav006
DEFINE l_stgb011      LIKE stgb_t.stgb011
DEFINE l_date         LIKE type_t.chr10
DEFINE l_dd           LIKE type_t.dat
DEFINE tc_ll001        LIKE rtjb_t.rtjb004
DEFINE tc_ll002        LIKE rtjb_t.rtjb025
DEFINE tc_ll003        LIKE rtjb_t.rtjb028
DEFINE tc_ll004        LIKE rtjb_t.rtjbdocno
DEFINE tc_ll005        LIKE rtjb_t.rtjbseq
DEFINE tc_ll006        LIKE rtje_t.rtje001
DEFINE tc_ll007        LIKE rtje_t.rtje002
DEFINE tc_ll008        LIKE rtje_t.rtje006
DEFINE tc_ll009        LIKE rtdx_t.rtdx003
DEFINE tc_ll010        LIKE rtjb_t.rtjbsite
DEFINE tc_ll011        LIKE stfa_t.stfa010  
DEFINE tc_ll012        LIKE stfa_t.stfa001
DEFINE l_stav002       LIKE stav_t.stav002
DEFINE l_stae006       LIKE stae_t.stae006



   #aooi500設置的組織範圍
#   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_wc    #mark by yangxf 
   IF cl_null(p_wc) THEN 
      LET p_wc = ' 1=1'
   END IF 
   LET p_wc = p_wc, " AND stgd013 <> '5' "   #160613-00045#4 20160615 add by beckxie
      CALL s_aooi500_sql_where(g_prog,'stgdsite') RETURNING l_wc     #add by yangxf  

   #開啟事務
   CALL s_transaction_begin()
   
   LET l_success=TRUE
   
#   DROP TABLE crtp514_tmp
#
#   CREATE TEMP TABLE crtp514_tmp(  
#   tc_ll001        LIKE rtjb_t.rtjb004,
#   tc_ll002        LIKE rtjb_t.rtjb025,
#   tc_ll003        LIKE rtjb_t.rtjb028,
#   tc_ll004        LIKE rtjb_t.rtjbdocno,
#   tc_ll005        LIKE rtjb_t.rtjbseq,
#   tc_ll006        LIKE rtje_t.rtje001,
#   tc_ll007        LIKE rtje_t.rtje002,
#   tc_ll008        LIKE rtje_t.rtje006,
#   tc_ll009        LIKE rtdx_t.rtdx003,
#   tc_ll010        LIKE rtjb_t.rtjbsite,
#   tc_ll011        LIKE stfa_t.stfa010,
#   tc_ll012        LIKE stfa_t.stfa001   
#    ) 
#
#
#   SELECT rtjb004,rtjb025,rtjb028,rtjbdocno,rtjbseq,rtje001,rtje002,rtje006,rtdx003,rtjbsite,stfa010,stfa001
#     INTO tc_ll001,tc_ll002,tc_ll003,tc_ll004,tc_ll005,tc_ll006,tc_ll007,tc_ll008,tc_ll009,tc_ll010,tc_ll011,tc_ll012
#     FROM rtjb_t,rtje_t,stfa_t,rtdx_t
#    WHERE rtjbent = g_enterprise
#      AND rtjbent = rtjeent
#      AND rtjbdocno = rtjedocno
#      AND rtjbseq = rtjeseq
#      AND rtjb036 IN ('1','2','3')
#      AND rtjb028 = stfa005
#      AND rtjbsite =rtdxsite
#      AND rtjb004 = rtdx001
#      AND rtdx003 = '4'
#      
#   IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#   END IF 
#
#   SELECT tc_ll003,tc_ll006,tc_ll007,SUM(tc_ll008)   
#     FROM crtp514_tmp
#     
#   IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#   END IF 
#  
#   SELECT stfk002,stfk011,stfk018,stfk019 
#     FROM stfk_t,stfa_t
#    WHERE stfa005 = tc_ll003
#      AND stfkent = g_enterprise
#      AND stfkseq = tc_ll005
#      AND stfk001 = tc_ll012     
#      
#    IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#    END IF 
#   
#   SELECT stae006 
#     FROM stae_t
#    WHERE stae001 = stfk002
#      AND staeent = g_enterprise
#      
#    IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#    END IF 
#     
#   
#   UPDATE stgb_t 
#      SET stgbent  = g_enterprise,
#          stgbsite = tc_ll010,
#          stgb001  = p_day,
#          stgb002  = tc_ll003,
#          stgb003  = tc_ll011,
#          stgb004  = stfk002,
#          stgb005  = '0',
#          stgb006  = '0',
#          stgb007  = SUM(tc_ll008) ,
#          stgb008  = stfk011,
#          stgb009  = SUM(tc_ll008)*stfk011/100,
#          stgb010  = stae006,
#          stgb011  = 'N'
#

#mark by yangxf ---start----
#   LET l_sql0 = "DELETE FROM stgb_t ",
#                " WHERE stgbent = ",g_enterprise,
#                "   AND EXISTS (SELECT 1 ",
#                "                 FROM rtjb_t, rtje_t, rtdx_t, rtja_t ",              
#                "                WHERE rtjbent = rtjeent ",                           
#                "                  AND rtjbent = rtdxent ",                           
#                "                  AND rtjbent = rtjaent ",                           
#                "                  AND rtjbdocno = rtjedocno ",                       
#                "                  AND rtjbdocno = rtjadocno ",                       
#                "                  AND rtjbseq = rtjeseq ",                           
#                "                  AND rtjbsite = rtdxsite ",                         
#                "                  AND rtjb004 = rtdx001 ",                           
#                "                  AND rtjadocdt = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
#                "                  AND stgbsite = rtjbsite AND stgb001 = rtjadocdt AND stgb002 = rtjb028 ",
#                "                ) "
#mark by yangxf ---end----
#add by yangxf ---start---- 
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'rtjbsite', 'stgdsite')         #门店
   LET p_wc = cl_replace_str(p_wc, 'rtjb028', 'stgd005')           #专柜
   LET p_wc = cl_replace_str(p_wc, 'rtjb004', 'stgd006')           #供应商
   LET l_sql0 = "DELETE FROM stgb_t ",
                " WHERE stgbent = ",g_enterprise,
                "   AND EXISTS (SELECT 1 ",
                "                 FROM rtdx_t,stgd_t ",
                "                WHERE rtdxent = stgdent ",
                "                  AND rtdxsite = stgdsite ",
                "                  AND rtdx001 = stgd003 ",
                "                  AND stgbsite = stgdsite ",
                "                  AND stgbent = stgdent ",
                "                  AND stgb001 = stgd002 ",
                "                  AND stgb002 = stgd005 ",
                "                  AND stgd002 = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
                ")"
#add by yangxf ----end----

   EXECUTE  IMMEDIATE l_sql0
   IF SQLCA.SQLcode THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = SQLCA.sqlcode
     LET g_errparam.extend = " "
     LET g_errparam.popup = TRUE
     CALL cl_err()      
     LET l_success=FALSE        
   END IF     


#mark by yangxf ---start---
#   SELECT stav002 INTO l_stav002 
#     FROM stav_t 
#    WHERE stavent = g_enterprise 
#      AND stav001 = g_prog
#mark by yangxf ---end-----

   SELECT stae006 INTO l_stae006
     FROM stae_t
    WHERE staeent = g_enterprise
      AND stae001 = l_stav002

#mark by yangxf ----start----
#   IF cl_null(l_stae006) or l_stae006 = '3-两者' THEN 
#      LET l_stae006 = '1-价外'
#   END IF 
#mark by yangxf ----end-----
#add by yangxf ----start----
   IF cl_null(l_stae006) OR l_stae006 = '3' THEN 
      LET l_stae006 = '1'
   END IF 
#add by yangxf -----end-----   
#mark by yangxf ---start----
#   LET l_sql = "INSERT INTO stgb_t (stgbent, ",                                          #企业编号    
#               "                    stgbsite, ",                                         #营运组织    
#               "                    stgb001, ",                                          #销售日期    
#               "                    stgb002, ",                                          #专柜编号    
#               "                    stgb003, ",                                          #供应商编号  
#               "                    stgb004, ",                                          #费用代码    
#               "                    stgb005, ",                                          #直接实收金额
#               "                    stgb006, ",                                          #间接实收金额
#               "                    stgb007, ",                                          #实收金额    
#               "                    stgb008, ",                                          #费率        
#               "                    stgb009, ",                                          #费用金额    
#               "                    stgb010, ",                                          #价款类型    
#               "                    stgb011, ",                                          #已结转否    
#               "                    stgbunit ",                                          #应用组织    
#               "                    ) ",         
#               "SELECT ",g_enterprise,", ",                                              #stgbent    #企业编号    
#               "       rtjbsite , ",                                                     #stgbsite   #营运组织    
#               "       '",p_day,"', ",                                                   #stgb001    #销售日期    
#               "       rtjb028, ",                                                       #stgb002    #专柜编号    
#               "       stfa010, ",                                                       #stgb003    #供应商编号  
#               "       '",l_stav002,"', ",                                               #stgb004    #费用代码    
#               "       0, ",                                                             #stgb005    #直接实收金额
#               "       0, ",                                                             #stgb006    #间接实收金额
##              "       rtje006_1, ",                                                     #stgb007    #实收金额   #mark by yangxf 
#               "       rtje006_2, ",                                                     #stgb007    #实收金额   #add by yangxf  
#               "       0, ",                                                             #stgb008    #费率        
#               "       sum_1, ",                                                         #stgb009    #费用金额    
#               "       '",l_stae006,"', ",                                               #stgb010    #价款类型    
#               "       'N', ",                                                           #stgb011    #已结转否    
#               "       rtjbsite ",                                                       #SUM（各款别的汇总实收金额 * 费率 / 100）  
#               "  FROM (SELECT stfa010, ",                                               #供应商
#               "               rtjbsite, ",                                              #营运组织  
#               "               rtjb028, ",                                               #专柜编号
##              "               rtje006_1, ",                                             #实收金额   #mark by yangxf 
#               "               SUM(rtje006_1) rtje006_2,",                               #实收金额   #add by yangxf 
#               "                SUM(rtje006_1 * stfk011 / 100) sum_1 ",                                     
#               "           FROM (SELECT rtjbsite, ",                                     #专柜编号+款别类型+款别编号汇总的实收金额。  
#               "                        rtjb028, ",                                      #专柜编号
#               "                        rtje001, ",                                      #款别类型
#               "                        rtje002, ",                                      #款别编号
#               "                        SUM(rtje006) rtje006_1 ",                        #实收金额
#               "                   FROM rtjb_t, rtje_t, rtdx_t, rtja_t ",              
#               "                  WHERE rtjbent = rtjeent ",                           
#               "                    AND rtjbent = rtdxent ",                           
#               "                    AND rtjbent = rtjaent ",                           
#               "                    AND rtjbdocno = rtjedocno ",                       
#               "                    AND rtjbdocno = rtjadocno ",                       
#               "                    AND rtjbseq = rtjeseq ",                           
#               "                    AND rtjbsite = rtdxsite ",                         
#               "                    AND rtjb004 = rtdx001 ",      
#               "                    AND rtjbent = ",g_enterprise,                         #add by yangxf                
#               "                    AND rtjadocdt = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,    
#               "                  GROUP BY rtjbsite, rtjb028, rtje001, rtje002 ",      
#               "                 ), ",                                                 
#               "                stfa_t, ",                                             
#               "                stfk_t ",                                              
#               "          WHERE stfaent = stfkent ",                                   
#               "            AND stfa001 = stfk001 ",                                   
#               "            AND stfa005 = rtjb028 ",                                   
#               "            AND rtje002 = stfk019 ",                                   
#               "            AND rtje001 = stfk018 ",                                   
#               "            AND stfk011 > 0 ",                                         
#               "            AND stfaent = ",g_enterprise,                               #add by yangxf               
#               "          GROUP BY rtjbsite, ",                                         #营运组织
#               "                   rtjb028, ",                                          #专柜编号
##              "                   rtje006_1, ",                                        #实收金额   #mark by yangxf 
#               "                   stfa010 ",                                            #供应商 
#               "        ) "
#mark by yangxf -----end-----        
#add by yangxf ----start----
   LET l_sql = "INSERT INTO stgb_t (stgbent, ",                                          #企业编号    
               "                    stgbsite, ",                                         #营运组织    
               "                    stgb001, ",                                          #销售日期    
               "                    stgb002, ",                                          #专柜编号    
               "                    stgb003, ",                                          #供应商编号  
               "                    stgb004, ",                                          #费用代码    
               "                    stgb005, ",                                          #直接实收金额
               "                    stgb006, ",                                          #间接实收金额
               "                    stgb007, ",                                          #实收金额    
               "                    stgb008, ",                                          #费率        
               "                    stgb009, ",                                          #费用金额    
               "                    stgb010, ",                                          #价款类型    
               "                    stgb011, ",                                          #已结转否    
               "                    stgbunit, ",                                         #应用组织    
               "                    stgb012,stgb013, ",                                  #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "                    stgb014  ",                                          #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "                    ) ",         
               "SELECT ",g_enterprise,", ",                                              #stgbent    #企业编号    
               "       stgdsite , ",                                                     #stgbsite   #营运组织    
               "       '",p_day,"', ",                                                   #stgb001    #销售日期    
               "       stgd005, ",                                                       #stgb002    #专柜编号    
               "       stfa010, ",                                                       #stgb003    #供应商编号  
               "       stfk002, ",                                                       #stgb004    #费用代码    
               "       0, ",                                                             #stgb005    #直接实收金额
               "       0, ",                                                             #stgb006    #间接实收金额
               "       stgd012_1, ",                                                     #stgb007    #实收金额   
               #"       0, ",                                                             #stgb008    #费率     
               "       stfk011, ",                                                       #stgb008    #费率        lanjj add on 2016-08-16         
               "       sum_1, ",                                                         #stgb009    #费用金额    
               "       '",l_stae006,"', ",                                               #stgb010    #价款类型    
               "       'N', ",                                                           #stgb011    #已结转否    
               "       stgdsite, ",                                                      #SUM（各款别的汇总实收金额 * 费率 / 100）  
               "       stgd013,stgd014, ",                                               #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "       stgd017 ",                                                        #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "  FROM (SELECT stfa010, ",                                               #供应商
               "               stgdsite, ",                                              #营运组织  
               "               stgd005, ",                                               #专柜编号
               "               stfk002, ",                                               #费用编号
               "               SUM(stgd012) stgd012_1 ,",                                #实收金额
               "               SUM(stgd012 * stfk011 / 100) sum_1, ",                    
               "               stfk011/100 stfk011,",                                     #费率 lanjj add on 2016-08-16
               "               stgd013,stgd014, ",                                       #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie               
               "               SUM(stgd017) stgd017 ",                                   #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "           FROM stgd_t, ",                                            
               "                stfa_t, ",                                             
               "                stfk_t ",                                              
               "          WHERE stfaent = stfkent ",         
               "            AND stfa001 = stfk001 ",       
               "            AND stfasite = stgdsite ",                                  #门店                    
               "            AND stfa005 = stgd005 ",                                    #专柜
               "            AND stgd008 = stfk019 ",                                    #款别编号
               "            AND stgd009 = stfk018 ",                                    #款别类型   
               "            AND stfk011 > 0 ",                                         
               "            AND stfaent = ",g_enterprise,                                       
               "            AND stgd002 = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
               "          GROUP BY stgdsite, ",                                         #营运组织
               "                   stgd005, ",                                          #专柜编号
               "                   stfa010, ",                                          #供应商 
               "                   stfk002, ",                                          #费用编号
               "                   stgd013,stgd014, ",                                   #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "                   stfk011 ", #lanjj add on 2016-08-16               
               "        ) "
#add by yangxf ---end-------
   EXECUTE  IMMEDIATE l_sql
   IF SQLCA.SQLcode THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = SQLCA.sqlcode
     LET g_errparam.extend = " "
     LET g_errparam.popup = TRUE
     CALL cl_err()      
     LET l_success=FALSE        
   END IF 
   
   SELECT stgb011 INTO l_stgb011
     FROM stgb_t
    WHERE stgbent  = g_enterprise
      AND stgb001  = g_master.rtjadocdt

   IF  l_stgb011 = 'Y' THEN
      CALL cl_err()
   END IF
     
  

   #事務提交
   IF l_success THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF

   RETURN l_success

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........: 複製astp514_update出來,作為租賃使用
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........: 5.租賃使用 #160613-00045#4 20160615 add by beckxie
################################################################################
PRIVATE FUNCTION astp514_update_1(p_wc,p_day)
DEFINE p_wc           STRING
DEFINE p_day          DATE
DEFINE l_success      LIKE type_t.num5
DEFINE l_sql          STRING
DEFINE l_sql0          STRING
DEFINE l_wc           STRING
DEFINE l_mm           LIKE type_t.num5
DEFINE l_yy           LIKE type_t.num5
DEFINE l_glav006      LIKE glav_t.glav006
DEFINE l_stgb011      LIKE stgb_t.stgb011
DEFINE l_date         LIKE type_t.chr10
DEFINE l_dd           LIKE type_t.dat
DEFINE tc_ll001        LIKE rtjb_t.rtjb004
DEFINE tc_ll002        LIKE rtjb_t.rtjb025
DEFINE tc_ll003        LIKE rtjb_t.rtjb028
DEFINE tc_ll004        LIKE rtjb_t.rtjbdocno
DEFINE tc_ll005        LIKE rtjb_t.rtjbseq
DEFINE tc_ll006        LIKE rtje_t.rtje001
DEFINE tc_ll007        LIKE rtje_t.rtje002
DEFINE tc_ll008        LIKE rtje_t.rtje006
DEFINE tc_ll009        LIKE rtdx_t.rtdx003
DEFINE tc_ll010        LIKE rtjb_t.rtjbsite
DEFINE tc_ll011        LIKE stfa_t.stfa010  
DEFINE tc_ll012        LIKE stfa_t.stfa001
DEFINE l_stav002       LIKE stav_t.stav002
DEFINE l_stae006       LIKE stae_t.stae006



   #aooi500設置的組織範圍
#   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_wc    #mark by yangxf 
   IF cl_null(p_wc) THEN 
      LET p_wc = ' 1=1'
   END IF 
   LET p_wc = p_wc, " AND stgd013 = '5' "   #160613-00045#4 20160615 add by beckxie
   CALL s_aooi500_sql_where(g_prog,'stgdsite') RETURNING l_wc     #add by yangxf  

   #開啟事務
   CALL s_transaction_begin()
   
   LET l_success=TRUE
   
#   DROP TABLE crtp514_tmp
#
#   CREATE TEMP TABLE crtp514_tmp(  
#   tc_ll001        LIKE rtjb_t.rtjb004,
#   tc_ll002        LIKE rtjb_t.rtjb025,
#   tc_ll003        LIKE rtjb_t.rtjb028,
#   tc_ll004        LIKE rtjb_t.rtjbdocno,
#   tc_ll005        LIKE rtjb_t.rtjbseq,
#   tc_ll006        LIKE rtje_t.rtje001,
#   tc_ll007        LIKE rtje_t.rtje002,
#   tc_ll008        LIKE rtje_t.rtje006,
#   tc_ll009        LIKE rtdx_t.rtdx003,
#   tc_ll010        LIKE rtjb_t.rtjbsite,
#   tc_ll011        LIKE stfa_t.stfa010,
#   tc_ll012        LIKE stfa_t.stfa001   
#    ) 
#
#
#   SELECT rtjb004,rtjb025,rtjb028,rtjbdocno,rtjbseq,rtje001,rtje002,rtje006,rtdx003,rtjbsite,stfa010,stfa001
#     INTO tc_ll001,tc_ll002,tc_ll003,tc_ll004,tc_ll005,tc_ll006,tc_ll007,tc_ll008,tc_ll009,tc_ll010,tc_ll011,tc_ll012
#     FROM rtjb_t,rtje_t,stfa_t,rtdx_t
#    WHERE rtjbent = g_enterprise
#      AND rtjbent = rtjeent
#      AND rtjbdocno = rtjedocno
#      AND rtjbseq = rtjeseq
#      AND rtjb036 IN ('1','2','3')
#      AND rtjb028 = stfa005
#      AND rtjbsite =rtdxsite
#      AND rtjb004 = rtdx001
#      AND rtdx003 = '4'
#      
#   IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#   END IF 
#
#   SELECT tc_ll003,tc_ll006,tc_ll007,SUM(tc_ll008)   
#     FROM crtp514_tmp
#     
#   IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#   END IF 
#  
#   SELECT stfk002,stfk011,stfk018,stfk019 
#     FROM stfk_t,stfa_t
#    WHERE stfa005 = tc_ll003
#      AND stfkent = g_enterprise
#      AND stfkseq = tc_ll005
#      AND stfk001 = tc_ll012     
#      
#    IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#    END IF 
#   
#   SELECT stae006 
#     FROM stae_t
#    WHERE stae001 = stfk002
#      AND staeent = g_enterprise
#      
#    IF SQLCA.SQLcode THEN
#      INITIALIZE g_errparam TO NULL
#      LET g_errparam.code = SQLCA.sqlcode
#      LET g_errparam.extend = " "
#      LET g_errparam.popup = TRUE
#      CALL cl_err()      
#      LET l_success=FALSE        
#    END IF 
#     
#   
#   UPDATE stgb_t 
#      SET stgbent  = g_enterprise,
#          stgbsite = tc_ll010,
#          stgb001  = p_day,
#          stgb002  = tc_ll003,
#          stgb003  = tc_ll011,
#          stgb004  = stfk002,
#          stgb005  = '0',
#          stgb006  = '0',
#          stgb007  = SUM(tc_ll008) ,
#          stgb008  = stfk011,
#          stgb009  = SUM(tc_ll008)*stfk011/100,
#          stgb010  = stae006,
#          stgb011  = 'N'
#

#mark by yangxf ---start----
#   LET l_sql0 = "DELETE FROM stgb_t ",
#                " WHERE stgbent = ",g_enterprise,
#                "   AND EXISTS (SELECT 1 ",
#                "                 FROM rtjb_t, rtje_t, rtdx_t, rtja_t ",              
#                "                WHERE rtjbent = rtjeent ",                           
#                "                  AND rtjbent = rtdxent ",                           
#                "                  AND rtjbent = rtjaent ",                           
#                "                  AND rtjbdocno = rtjedocno ",                       
#                "                  AND rtjbdocno = rtjadocno ",                       
#                "                  AND rtjbseq = rtjeseq ",                           
#                "                  AND rtjbsite = rtdxsite ",                         
#                "                  AND rtjb004 = rtdx001 ",                           
#                "                  AND rtjadocdt = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
#                "                  AND stgbsite = rtjbsite AND stgb001 = rtjadocdt AND stgb002 = rtjb028 ",
#                "                ) "
#mark by yangxf ---end----
#add by yangxf ---start---- 
   IF cl_null(p_wc) THEN 
      LET p_wc = " 1=1"
   END IF 
   LET p_wc = cl_replace_str(p_wc, 'rtjbsite', 'stgdsite')         #门店
   LET p_wc = cl_replace_str(p_wc, 'rtjb028', 'stgd005')           #专柜
   LET p_wc = cl_replace_str(p_wc, 'rtjb004', 'stgd006')           #供应商
   LET l_sql0 = "DELETE FROM stgb_t ",
                " WHERE stgbent = ",g_enterprise,
                "   AND EXISTS (SELECT 1 ",
                "                 FROM rtdx_t,stgd_t ",
                "                WHERE rtdxent = stgdent ",
                "                  AND rtdxsite = stgdsite ",
                "                  AND rtdx001 = stgd003 ",
                "                  AND stgbsite = stgdsite ",
                "                  AND stgbent = stgdent ",
                "                  AND stgb001 = stgd002 ",
                "                  AND stgb002 = stgd005 ",
                "                  AND stgd002 = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
                ")"
#add by yangxf ----end----

   EXECUTE  IMMEDIATE l_sql0
   IF SQLCA.SQLcode THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = SQLCA.sqlcode
     LET g_errparam.extend = " "
     LET g_errparam.popup = TRUE
     CALL cl_err()      
     LET l_success=FALSE        
   END IF     


   #租賃抓費用,取默認 #160613-00045#4 20160616 add by beckxie
   SELECT stav002 INTO l_stav002 
     FROM stav_t 
    WHERE stavent = g_enterprise 
      AND stav001 = g_prog


   SELECT stae006 INTO l_stae006
     FROM stae_t
    WHERE staeent = g_enterprise
      AND stae001 = l_stav002

#mark by yangxf ----start----
#   IF cl_null(l_stae006) or l_stae006 = '3-两者' THEN 
#      LET l_stae006 = '1-价外'
#   END IF 
#mark by yangxf ----end-----
#add by yangxf ----start----
   IF cl_null(l_stae006) OR l_stae006 = '3' THEN 
      LET l_stae006 = '1'
   END IF 
#add by yangxf -----end-----   
#mark by yangxf ---start----
#   LET l_sql = "INSERT INTO stgb_t (stgbent, ",                                          #企业编号    
#               "                    stgbsite, ",                                         #营运组织    
#               "                    stgb001, ",                                          #销售日期    
#               "                    stgb002, ",                                          #专柜编号    
#               "                    stgb003, ",                                          #供应商编号  
#               "                    stgb004, ",                                          #费用代码    
#               "                    stgb005, ",                                          #直接实收金额
#               "                    stgb006, ",                                          #间接实收金额
#               "                    stgb007, ",                                          #实收金额    
#               "                    stgb008, ",                                          #费率        
#               "                    stgb009, ",                                          #费用金额    
#               "                    stgb010, ",                                          #价款类型    
#               "                    stgb011, ",                                          #已结转否    
#               "                    stgbunit ",                                          #应用组织    
#               "                    ) ",         
#               "SELECT ",g_enterprise,", ",                                              #stgbent    #企业编号    
#               "       rtjbsite , ",                                                     #stgbsite   #营运组织    
#               "       '",p_day,"', ",                                                   #stgb001    #销售日期    
#               "       rtjb028, ",                                                       #stgb002    #专柜编号    
#               "       stfa010, ",                                                       #stgb003    #供应商编号  
#               "       '",l_stav002,"', ",                                               #stgb004    #费用代码    
#               "       0, ",                                                             #stgb005    #直接实收金额
#               "       0, ",                                                             #stgb006    #间接实收金额
##              "       rtje006_1, ",                                                     #stgb007    #实收金额   #mark by yangxf 
#               "       rtje006_2, ",                                                     #stgb007    #实收金额   #add by yangxf  
#               "       0, ",                                                             #stgb008    #费率        
#               "       sum_1, ",                                                         #stgb009    #费用金额    
#               "       '",l_stae006,"', ",                                               #stgb010    #价款类型    
#               "       'N', ",                                                           #stgb011    #已结转否    
#               "       rtjbsite ",                                                       #SUM（各款别的汇总实收金额 * 费率 / 100）  
#               "  FROM (SELECT stfa010, ",                                               #供应商
#               "               rtjbsite, ",                                              #营运组织  
#               "               rtjb028, ",                                               #专柜编号
##              "               rtje006_1, ",                                             #实收金额   #mark by yangxf 
#               "               SUM(rtje006_1) rtje006_2,",                               #实收金额   #add by yangxf 
#               "                SUM(rtje006_1 * stfk011 / 100) sum_1 ",                                     
#               "           FROM (SELECT rtjbsite, ",                                     #专柜编号+款别类型+款别编号汇总的实收金额。  
#               "                        rtjb028, ",                                      #专柜编号
#               "                        rtje001, ",                                      #款别类型
#               "                        rtje002, ",                                      #款别编号
#               "                        SUM(rtje006) rtje006_1 ",                        #实收金额
#               "                   FROM rtjb_t, rtje_t, rtdx_t, rtja_t ",              
#               "                  WHERE rtjbent = rtjeent ",                           
#               "                    AND rtjbent = rtdxent ",                           
#               "                    AND rtjbent = rtjaent ",                           
#               "                    AND rtjbdocno = rtjedocno ",                       
#               "                    AND rtjbdocno = rtjadocno ",                       
#               "                    AND rtjbseq = rtjeseq ",                           
#               "                    AND rtjbsite = rtdxsite ",                         
#               "                    AND rtjb004 = rtdx001 ",      
#               "                    AND rtjbent = ",g_enterprise,                         #add by yangxf                
#               "                    AND rtjadocdt = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,    
#               "                  GROUP BY rtjbsite, rtjb028, rtje001, rtje002 ",      
#               "                 ), ",                                                 
#               "                stfa_t, ",                                             
#               "                stfk_t ",                                              
#               "          WHERE stfaent = stfkent ",                                   
#               "            AND stfa001 = stfk001 ",                                   
#               "            AND stfa005 = rtjb028 ",                                   
#               "            AND rtje002 = stfk019 ",                                   
#               "            AND rtje001 = stfk018 ",                                   
#               "            AND stfk011 > 0 ",                                         
#               "            AND stfaent = ",g_enterprise,                               #add by yangxf               
#               "          GROUP BY rtjbsite, ",                                         #营运组织
#               "                   rtjb028, ",                                          #专柜编号
##              "                   rtje006_1, ",                                        #实收金额   #mark by yangxf 
#               "                   stfa010 ",                                            #供应商 
#               "        ) "
#mark by yangxf -----end-----        
#add by yangxf ----start----
   LET l_sql = "INSERT INTO stgb_t (stgbent, ",                                          #企业编号    
               "                    stgbsite, ",                                         #营运组织    
               "                    stgb001, ",                                          #销售日期    
               "                    stgb002, ",                                          #专柜编号    
               "                    stgb003, ",                                          #供应商编号  
               "                    stgb004, ",                                          #费用代码    
               "                    stgb005, ",                                          #直接实收金额
               "                    stgb006, ",                                          #间接实收金额
               "                    stgb007, ",                                          #实收金额    
               "                    stgb008, ",                                          #费率        
               "                    stgb009, ",                                          #费用金额    
               "                    stgb010, ",                                          #价款类型    
               "                    stgb011, ",                                          #已结转否    
               "                    stgbunit, ",                                         #应用组织    
               "                    stgb012,stgb013, ",                                  #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "                    stgb014 ",                                           #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "                    ) ",         
               "   SELECT ",g_enterprise,", ",                                           #stgbent    #企业编号    
               "          stgdsite , ",                                                  #stgbsite   #营运组织    
               "          '",p_day,"', ",                                                #stgb001    #销售日期    
               "          stgd005, ",                                                    #stgb002    #鋪位編號    
               "          stgd006, ",                                                    #stgb003    #商戶編號  
               "          '",l_stav002,"', ",                                            #stgb004    #费用代码
               "          0, ",                                                          #stgb005    #直接实收金额
               "          0, ",                                                          #stgb006    #间接实收金额
               "          sum_stgd012, ",                                                #stgb007    #实收金额   
               "          0, ",                                                          #stgb008    #费率        
               "          sum_stgd016, ",                                                #stgb009    #费用金额    
               "          '",l_stae006,"', ",                                            #stgb010    #价款类型    
               "          'N', ",                                                        #stgb011    #已结转否    
               "          stgdsite, ",                                                    #SUM（各款别的汇总实收金额 * 费率 / 100）  
               "          stgd013,stgd014, ",                                            #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "          COALESCE(stgd017,0) ",                                         #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "     FROM (SELECT stgdsite, ",                                           #营运组织  
               "                  stgd005, ",                                            #鋪位編號
               "                  stgd006, ",                                            #商戶
               "                  SUM(stgd012) sum_stgd012, ",                           #实收金额
               "                  SUM(stgd016) sum_stgd016, ",                           #手續費金額 (租賃直接取stgd016)
               "                  stgd013,stgd014, ",                                    #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "                  SUM(stgd017) stgd017 ",                                #儲值折扣金額       #160615-00046#6 20160617 add by beckxie
               "             FROM stgd_t ",
               "            WHERE stgdent = ",g_enterprise, 
               "              AND stgd002 = '",p_day,"' AND ",p_wc CLIPPED," AND ",l_wc,
               "         GROUP BY stgdsite, ",                                         #营运组织
               "                  stgd005, ",                                          #专柜编号
               "                  stgd006, ",                                          #商戶 
               "                  stgd013,stgd014 ",                                   #經營方式,合約編號 #160613-00045#4 20160615 add by beckxie
               "          ) "
#add by yangxf ---end-------
   EXECUTE  IMMEDIATE l_sql
   IF SQLCA.SQLcode THEN
     INITIALIZE g_errparam TO NULL
     LET g_errparam.code = SQLCA.sqlcode
     LET g_errparam.extend = " "
     LET g_errparam.popup = TRUE
     CALL cl_err()      
     LET l_success=FALSE        
   END IF 
   
   SELECT stgb011 INTO l_stgb011
     FROM stgb_t
    WHERE stgbent  = g_enterprise
      AND stgb001  = g_master.rtjadocdt

   IF  l_stgb011 = 'Y' THEN
      CALL cl_err()
   END IF
     
  

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
 
