#該程式未解開Section, 採用最新樣板產出!
{<section id="aprp125.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2015-04-29 20:29:23), PR版次:0006(2016-05-09 17:16:15)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000171
#+ Filename...: aprp125
#+ Description: 價格調整批處理作業
#+ Creator....: 03247(2014-03-27 17:45:23)
#+ Modifier...: 03247 -SD/PR- 02159
 
{</section>}
 
{<section id="aprp125.global" >}
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
        prbk006          LIKE prbk_t.prbk006,
        #prbk003          LIKE prbk_t.prbk003,      #150427-00011#1--mark by dongsz
        prbk025          LIKE prbk_t.prbk025,       #150427-00011#1--add by dongsz
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       prbk006 LIKE prbk_t.prbk006, 
   prbk025 LIKE prbk_t.prbk025, 
   prbk001 LIKE prbk_t.prbk001, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_prbk   RECORD
   prbkstus     LIKE prbk_t.prbkstus,
   prbksite     LIKE prbk_t.prbksite,
   prbk001      LIKE prbk_t.prbk001,
   prbk002      LIKE prbk_t.prbk002,
   prbk003      LIKE prbk_t.prbk003,
   prbk006      LIKE prbk_t.prbk006,
   prbk007      LIKE prbk_t.prbk007,
   prbk008      LIKE prbk_t.prbk008,
   prbk009      LIKE prbk_t.prbk009,
   prbk010      LIKE prbk_t.prbk010,
   prbk011      LIKE prbk_t.prbk011,
   prbk013      LIKE prbk_t.prbk013,
   prbk017      LIKE prbk_t.prbk017,
   prbk018      LIKE prbk_t.prbk018,
   prbk019      LIKE prbk_t.prbk019,
   prbk020      LIKE prbk_t.prbk020,
   prbk021      LIKE prbk_t.prbk021,
   prbk022      LIKE prbk_t.prbk022,
   prbk023      LIKE prbk_t.prbk023
                END RECORD  
DEFINE g_num    LIKE type_t.num5                
DEFINE g_num1   LIKE type_t.num5
DEFINE g_num2   LIKE type_t.num5
DEFINE g_num3   LIKE type_t.num5
DEFINE g_num4   LIKE type_t.num5
DEFINE g_num5   LIKE type_t.num5   #150616-00035#54--add by dongsz
DEFINE g_num6   LIKE type_t.num5   #150616-00035#54--add by dongsz
DEFINE g_num7   LIKE type_t.num5   #20151027--add by dongsz
DEFINE g_num8   LIKE type_t.num5   #20151027--add by dongsz
DEFINE g_success   LIKE type_t.chr1
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aprp125.main" >}
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
      CALL aprp125_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprp125 WITH FORM cl_ap_formpath("apr",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aprp125_init()
 
      #進入選單 Menu (="N")
      CALL aprp125_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aprp125
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aprp125.init" >}
#+ 初始化作業
PRIVATE FUNCTION aprp125_init()
 
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
   #CALL cl_set_combo_scc("prbk003","6033")            #150427-00011#1--mark by dongsz
   CALL cl_set_combo_scc('prbk025','6779')             #150427-00011#1--add by dongsz
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aprp125.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aprp125_ui_dialog()
 
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
         INPUT BY NAME g_master.prbk006,g_master.prbk025 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbk006
            #add-point:BEFORE FIELD prbk006 name="input.b.prbk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbk006
            
            #add-point:AFTER FIELD prbk006 name="input.a.prbk006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbk006
            #add-point:ON CHANGE prbk006 name="input.g.prbk006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbk025
            #add-point:BEFORE FIELD prbk025 name="input.b.prbk025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbk025
            
            #add-point:AFTER FIELD prbk025 name="input.a.prbk025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE prbk025
            #add-point:ON CHANGE prbk025 name="input.g.prbk025"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.prbk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbk006
            #add-point:ON ACTION controlp INFIELD prbk006 name="input.c.prbk006"
            
            #END add-point
 
 
         #Ctrlp:input.c.prbk025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbk025
            #add-point:ON ACTION controlp INFIELD prbk025 name="input.c.prbk025"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON prbk001
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               CALL cl_qbe_init()
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.prbk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD prbk001
            #add-point:ON ACTION controlp INFIELD prbk001 name="construct.c.prbk001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #150427-00011#1--mark by dongsz--str---
#            IF cl_null(g_master.prbk003) THEN
#               LET g_qryparam.where = " prbk006 = '",g_master.prbk006,"' "
#            ELSE
#               LET g_qryparam.where = " prbk003 = '",g_master.prbk003,"' AND prbk006 = '",g_master.prbk006,"' "
#            END IF
            #150427-00011#1--mark by dongsz--end---
            #150427-00011#1--mark by dongsz--str---
            IF cl_null(g_master.prbk025) THEN
               LET g_qryparam.where = " prbk006 = '",g_master.prbk006,"' "
            ELSE
               LET g_qryparam.where = " prbk025 = '",g_master.prbk025,"' AND prbk006 = '",g_master.prbk006,"' "
            END IF
            #150427-00011#1--mark by dongsz--end---
            CALL q_prbk001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO prbk001  #顯示到畫面上
            LET g_qryparam.where = ""
            NEXT FIELD prbk001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD prbk001
            #add-point:BEFORE FIELD prbk001 name="construct.b.prbk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD prbk001
            
            #add-point:AFTER FIELD prbk001 name="construct.a.prbk001"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
#         CONSTRUCT BY NAME lc_param.wc ON prbk001
#            BEFORE CONSTRUCT
#               CALL cl_qbe_init()
#               #DISPLAY g_today TO prbk006
#               
#            ON ACTION controlp INFIELD prbk001
#               #開窗c段
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = "c"
#               LET g_qryparam.reqry = FALSE
#               IF cl_null(lc_param.prbk003) THEN
#                  LET g_qryparam.where = " prbk006 = '",lc_param.prbk006,"' "
#               ELSE
#                  LET g_qryparam.where = " prbk003 = '",lc_param.prbk003,"' AND prbk006 = '",lc_param.prbk006,"' "
#               END IF
#               CALL q_prbk001_1()                       #呼叫開窗
#               DISPLAY g_qryparam.return1 TO prbk001    #顯示到畫面上
#               LET g_qryparam.where = ""
#               NEXT FIELD prbk001                       #返回原欄位
#               
#         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
#         INPUT lc_param.prbk006,lc_param.prbk003 FROM prbk006,prbk003 ATTRIBUTE(WITHOUT DEFAULTS)
#            BEFORE INPUT
#               LET lc_param.prbk006 = g_today
#               
#         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         SUBDIALOG lib_cl_schedule.cl_schedule_setting
         SUBDIALOG lib_cl_schedule.cl_schedule_setting_exec_call
         SUBDIALOG lib_cl_schedule.cl_schedule_select_show_history
         SUBDIALOG lib_cl_schedule.cl_schedule_show_history
 
         BEFORE DIALOG
            LET l_dialog = ui.DIALOG.getCurrent()
            CALL aprp125_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            LET g_master.prbk006 = g_today
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
         CALL aprp125_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.prbk006 = g_master.prbk006
      LET lc_param.prbk025 = g_master.prbk025
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
                 CALL aprp125_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aprp125_transfer_argv(ls_js)
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
 
{<section id="aprp125.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aprp125_transfer_argv(ls_js)
 
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
 
{<section id="aprp125.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aprp125_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_sql       STRING
   DEFINE l_success   LIKE type_t.chr1
   DEFINE l_loop      LIKE type_t.num5   #160225-00040#14 160509 by sakura add 
   DEFINE l_msg       STRING             #160225-00040#14 160509 by sakura add   
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF NOT cl_ask_confirm("lib-012") THEN
      RETURN
   END IF
   #20150730--add by dongsz--s
   IF cl_null(lc_param.prbk006) THEN
      LET lc_param.prbk006 = g_today
   END IF
   IF cl_null(lc_param.wc) THEN
      LET lc_param.wc = " 1=1"
   END IF
   #20150730--add by dongsz--e
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      #160225-00040#14 160509 by sakura add(S)
      LET l_loop = 8
      CALL cl_progress_bar_no_window(l_loop)      
      #160225-00040#14 160509 by sakura add(E)      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aprp125_process_cs CURSOR FROM ls_sql
#  FOREACH aprp125_process_cs INTO
   #add-point:process段process name="process.process"
   #160225-00040#14 160509 by sakura add(S) #資料準備
   LET l_msg = cl_getmsg('ade-00114',g_lang)   
   CALL cl_progress_no_window_ing(l_msg) 
   #160225-00040#14 160509 by sakura add(E)
   
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   LET l_success = 'Y'
#   LET l_sql = " SELECT prbkstus,prbksite,prbk001,prbk002,prbk003,prbk006,prbk007,prbk008,prbk009,prbk010,",
#               "        prbk011,prbk013,prbk017,prbk018,prbk019,prbk020,prbk021,prbk022,prbk023 ",
#               "   FROM prbk_t ",
#               "  WHERE prbkent = '",g_enterprise,"' ",
#               "    AND prbk006 = '",lc_param.prbk006,"' ",
#               "    AND prbkstus = '1' ",
#               "    AND ",lc_param.wc
#   IF NOT cl_null(lc_param.prbk003) THEN
#      LET l_sql = l_sql," AND prbk003 = '",lc_param.prbk003,"' "
#   END IF
#   PREPARE sel_prbk_pre FROM l_sql
#   DECLARE sel_prbk_cs  CURSOR FOR sel_prbk_pre
#   LET g_num = 0
#   LET g_num1 = 0
#   LET g_num2 = 0
#   LET g_num3 = 0
#   FOREACH sel_prbk_cs  INTO g_prbk.prbkstus,g_prbk.prbksite,g_prbk.prbk001,g_prbk.prbk002,g_prbk.prbk003,g_prbk.prbk006,
#                             g_prbk.prbk007,g_prbk.prbk008,g_prbk.prbk009,g_prbk.prbk010,g_prbk.prbk011,
#                             g_prbk.prbk013,g_prbk.prbk017,g_prbk.prbk018,g_prbk.prbk019,g_prbk.prbk020,
#                             g_prbk.prbk021,g_prbk.prbk022,g_prbk.prbk023
#      UPDATE prbk_t SET prbkstus = '2'
#       WHERE prbkent = g_enterprise
#         AND prbksite = g_prbk.prbksite
#         AND prbk001 = g_prbk.prbk001
#         AND prbk002 = g_prbk.prbk002
#      IF SQLCA.sqlcode THEN
#         CALL cl_errmsg('prbk001',g_prbk.prbk001,'',SQLCA.sqlcode,1)
#         LET l_success = 'N'
#         CONTINUE FOREACH
#      END IF
#      IF g_prbk.prbk003 = '1' THEN
#         CALL aprp125_upd_price1()
#         IF g_success = 'N' THEN
#            LET l_success = 'N'
#            CONTINUE FOREACH
#         END IF
#      END IF
#      
#      IF g_prbk.prbk003 = '2' THEN
#         CALL aprp125_upd_price2()
#         IF g_success = 'N' THEN
#            LET l_success = 'N'
#            CONTINUE FOREACH
#         END IF
#      END IF
#   
#      IF g_prbk.prbk003 = '3' THEN
#         CALL aprp125_upd_price3()
#         IF g_success = 'N' THEN
#            LET l_success = 'N'
#            CONTINUE FOREACH
#         END IF
#      END IF
#      
#      IF g_prbk.prbk003 = '4' THEN
#         CALL aprp125_upd_price4()
#         IF g_success = 'N' THEN
#            LET l_success = 'N'
#            CONTINUE FOREACH
#         END IF
#      END IF
#   
#   END FOREACH


   LET g_num = 0
   LET g_num1 = 0
   LET g_num2 = 0
   LET g_num3 = 0
   LET g_num4 = 0
   
   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)
   #IF cl_null(g_master.prbk003) OR g_master.prbk003 = '1' THEN      #150427-00011#1--mark by dongsz
   #CALL s_aprp125_upd_price_1(g_master.prbk006,g_master.prbk003,g_master.wc) RETURNING g_success,g_num1 #150427-00011#1--mark by dongsz
   IF cl_null(lc_param.prbk025) OR lc_param.prbk025 = '1' THEN
      CALL s_aprp125_upd_price_1(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num1
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
   END IF
   #END IF              #150427-00011#1--mark by dongsz

   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)
   #IF cl_null(g_master.prbk003) OR g_master.prbk003 = '2' THEN      #150427-00011#1--mark by dongsz
   #CALL s_aprp125_upd_price_2(g_master.prbk006,g_master.prbk003,g_master.wc) RETURNING g_success,g_num2 #150427-00011#1--mark by dongsz
   IF cl_null(lc_param.prbk025) OR lc_param.prbk025 = '2' THEN
      CALL s_aprp125_upd_price_2(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num2
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
   END IF
   #END IF              #150427-00011#1--mark by dongsz
   
   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)   
   #IF cl_null(g_master.prbk003) OR g_master.prbk003 = '3' THEN      #150427-00011#1--mark by dongsz
   #CALL s_aprp125_upd_price_3(g_master.prbk006,g_master.prbk003,g_master.wc) RETURNING g_success,g_num3 #150427-00011#1--mark by dongsz
   CALL s_aprp125_upd_price_3(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num3
   IF g_success = 'N' THEN
      LET l_success = 'N'
   END IF
   #END IF              #150427-00011#1--mark by dongsz
   
   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)   
   #IF cl_null(g_master.prbk003) OR g_master.prbk003 = '4' THEN      #150427-00011#1--mark by dongsz
   #CALL s_aprp125_upd_price_4(g_master.prbk006,g_master.prbk003,g_master.wc) RETURNING g_success,g_num4 #150427-00011#1--mark by dongsz
   CALL s_aprp125_upd_price_4(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num4
   IF g_success = 'N' THEN
      LET l_success = 'N'
   END IF
   #END IF              #150427-00011#1--mark by dongsz
   
   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)   
   #150616-00035#54--add by dongsz--str---
   IF cl_null(lc_param.prbk025) OR lc_param.prbk025 = '2' THEN
      CALL s_aprp125_upd_price_5(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num5
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
      
      CALL s_aprp125_upd_price_6(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num6
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
      
      #20151027--dongsz add--str---
      CALL s_aprp125_upd_price_7(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num7
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
      
      CALL s_aprp125_upd_price_8(lc_param.prbk006,lc_param.prbk025,lc_param.wc) RETURNING g_success,g_num8
      IF g_success = 'N' THEN
         LET l_success = 'N'
      END IF
      #20151027--dongsz add--end---
   END IF
   #150616-00035#54--add by dongsz--end---
   
   #160225-00040#14 160509 by sakura add(S) #產生資料
   LET l_msg = cl_getmsg('ast-00330',g_lang)
   CALL cl_progress_no_window_ing(l_msg)   
   #160225-00040#14 160509 by sakura add(E)   
   LET l_sql = " UPDATE prbk_t SET prbkstus = '2' ",
               "  WHERE prbkent = '",g_enterprise,"' ",
               "    AND prbk006 = '",lc_param.prbk006,"' ",
               "    AND prbkstus = '1' ",
               "    AND ",lc_param.wc
   #150427-00011#1--mark by dongsz--str---
#   IF NOT cl_null(g_master.prbk003) THEN
#      LET l_sql = l_sql," AND prbk003 = '",g_master.prbk003,"' "
#   END IF
   #150427-00011#1--mark by dongsz--end---
   #150427-00011#1--add by dongsz--str---
   IF NOT cl_null(lc_param.prbk025) THEN
      LET l_sql = l_sql," AND prbk025 = '",lc_param.prbk025,"' "
   END IF
   #150427-00011#1--add by dongsz--str---
   PREPARE upd_prbk_pre1 FROM l_sql
   EXECUTE upd_prbk_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'upd prbk_t'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET l_success = 'N'
      CALL cl_err()
   END IF

   #160225-00040#14 160509 by sakura add(S) #批次作業已執行完成
   LET l_msg = cl_getmsg('std-00012',g_lang)
   CALL cl_progress_no_window_ing(l_msg)
   #160225-00040#14 160509 by sakura add(E)
   IF l_success = 'Y' THEN
      CALL s_transaction_end("Y","0")
      CALL cl_err_collect_show()
      LET g_num = g_num1 + g_num2 + g_num3 + g_num4 + g_num5 + g_num6 + g_num7 + g_num8   #150616-00035#54--add by dongsz
      DISPLAY '更新成功笔数：',g_num
      #LET g_num = g_num1 + g_num2 + g_num3 + g_num4    150616-00035#54--mark by dongsz
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apr-00209'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_num
      CALL cl_err()
   ELSE
      CALL cl_err_collect_show()
      CALL s_transaction_end("N","0")
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
   CALL aprp125_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aprp125.get_buffer" >}
PRIVATE FUNCTION aprp125_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.prbk006 = p_dialog.getFieldBuffer('prbk006')
   LET g_master.prbk025 = p_dialog.getFieldBuffer('prbk025')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   CALL cl_set_comp_required('prbk025',FALSE)
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aprp125.msgcentre_notify" >}
PRIVATE FUNCTION aprp125_msgcentre_notify()
 
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
 
{<section id="aprp125.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
