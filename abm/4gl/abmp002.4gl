#該程式未解開Section, 採用最新樣板產出!
{<section id="abmp002.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-09-12 16:49:11), PR版次:0004(2016-12-05 15:36:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000115
#+ Filename...: abmp002
#+ Description: 研發中心BOM項次重排作業
#+ Creator....: 01996(2014-06-04 14:49:28)
#+ Modifier...: 01996 -SD/PR- 08734
 
{</section>}
 
{<section id="abmp002.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#Memos
#161124-00048#1   2016/12/05  By 08734 星号整批调整
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
       bmaa001 LIKE type_t.chr500, 
   bmaa002 LIKE type_t.chr30, 
   order1 LIKE type_t.chr500, 
   order2 LIKE type_t.chr500, 
   order3 LIKE type_t.chr500, 
   order4 LIKE type_t.chr500, 
   reseq LIKE type_t.chr500, 
   renum LIKE type_t.chr500, 
   site_bom LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

DEFINE g_argv1 LIKE type_t.chr10
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abmp002.main" >}
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
   CALL cl_ap_init("abm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   LET g_argv1 = g_argv[1]
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL abmp002_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abmp002 WITH FORM cl_ap_formpath("abm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL abmp002_init()
 
      #進入選單 Menu (="N")
      CALL abmp002_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_abmp002
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="abmp002.init" >}
#+ 初始化作業
PRIVATE FUNCTION abmp002_init()
 
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
    CALL cl_set_combo_scc('order1','5439')
    CALL cl_set_combo_scc('order2','5439')
    CALL cl_set_combo_scc('order3','5439')
    CALL cl_set_combo_scc('order4','5439')
    IF g_argv1 = '2' THEN
       CALL cl_set_comp_visible("site_bom",FALSE)
    END IF
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="abmp002.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abmp002_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_para   LIKE type_t.num5
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   INITIALIZE g_master.* TO NULL
   CLEAR FORM
   LET g_master.order1 = '1'
   LET g_master.order2 = '2'
   LET g_master.order3 = '3'
   LET g_master.order4 = '4'
   LET l_para = cl_get_para(g_enterprise,g_site,'E-BAS-0008')
   LET g_master.renum = l_para
   IF g_argv1 = '1' THEN
      LET g_master.site_bom = 'Y'
      DISPLAY BY NAME g_master.site_bom
   END IF
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.order1,g_master.order2,g_master.order3,g_master.order4,g_master.reseq, 
             g_master.renum,g_master.site_bom 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order1
            #add-point:BEFORE FIELD order1 name="input.b.order1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order1
            
            #add-point:AFTER FIELD order1 name="input.a.order1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order1
            #add-point:ON CHANGE order1 name="input.g.order1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order2
            #add-point:BEFORE FIELD order2 name="input.b.order2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order2
            
            #add-point:AFTER FIELD order2 name="input.a.order2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order2
            #add-point:ON CHANGE order2 name="input.g.order2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order3
            #add-point:BEFORE FIELD order3 name="input.b.order3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order3
            
            #add-point:AFTER FIELD order3 name="input.a.order3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order3
            #add-point:ON CHANGE order3 name="input.g.order3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD order4
            #add-point:BEFORE FIELD order4 name="input.b.order4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD order4
            
            #add-point:AFTER FIELD order4 name="input.a.order4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE order4
            #add-point:ON CHANGE order4 name="input.g.order4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD reseq
            #add-point:BEFORE FIELD reseq name="input.b.reseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD reseq
            
            #add-point:AFTER FIELD reseq name="input.a.reseq"
            IF NOT cl_ap_chk_Range(g_master.reseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inbj009
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE reseq
            #add-point:ON CHANGE reseq name="input.g.reseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD renum
            #add-point:BEFORE FIELD renum name="input.b.renum"
    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD renum
            
            #add-point:AFTER FIELD renum name="input.a.renum"
            
            IF NOT cl_ap_chk_Range(g_master.renum,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD inbj009
            END IF 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE renum
            #add-point:ON CHANGE renum name="input.g.renum"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD site_bom
            #add-point:BEFORE FIELD site_bom name="input.b.site_bom"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD site_bom
            
            #add-point:AFTER FIELD site_bom name="input.a.site_bom"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE site_bom
            #add-point:ON CHANGE site_bom name="input.g.site_bom"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.order1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order1
            #add-point:ON ACTION controlp INFIELD order1 name="input.c.order1"
            
            #END add-point
 
 
         #Ctrlp:input.c.order2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order2
            #add-point:ON ACTION controlp INFIELD order2 name="input.c.order2"
            
            #END add-point
 
 
         #Ctrlp:input.c.order3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order3
            #add-point:ON ACTION controlp INFIELD order3 name="input.c.order3"
            
            #END add-point
 
 
         #Ctrlp:input.c.order4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD order4
            #add-point:ON ACTION controlp INFIELD order4 name="input.c.order4"
            
            #END add-point
 
 
         #Ctrlp:input.c.reseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD reseq
            #add-point:ON ACTION controlp INFIELD reseq name="input.c.reseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.renum
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD renum
            #add-point:ON ACTION controlp INFIELD renum name="input.c.renum"
            
            #END add-point
 
 
         #Ctrlp:input.c.site_bom
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD site_bom
            #add-point:ON ACTION controlp INFIELD site_bom name="input.c.site_bom"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON bmaa001,bmaa002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.bmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa001
            #add-point:ON ACTION controlp INFIELD bmaa001 name="construct.c.bmaa001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF g_argv1 = '1' THEN
               LET g_qryparam.where = " bmaasite = 'ALL'"
            ELSE
               LET g_qryparam.where = " bmaasite = '",g_site,"'"
            END IF
            CALL q_bmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO bmaa001  #顯示到畫面上
            NEXT FIELD bmaa001                   #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa001
            #add-point:BEFORE FIELD bmaa001 name="construct.b.bmaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa001
            
            #add-point:AFTER FIELD bmaa001 name="construct.a.bmaa001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bmaa002
            #add-point:BEFORE FIELD bmaa002 name="construct.b.bmaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bmaa002
            
            #add-point:AFTER FIELD bmaa002 name="construct.a.bmaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.bmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bmaa002
            #add-point:ON ACTION controlp INFIELD bmaa002 name="construct.c.bmaa002"
            
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
            CALL abmp002_get_buffer(l_dialog)
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
         CALL abmp002_init()
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
                 CALL abmp002_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = abmp002_transfer_argv(ls_js)
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
 
{<section id="abmp002.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION abmp002_transfer_argv(ls_js)
 
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
 
{<section id="abmp002.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION abmp002_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
  
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   CALL s_transaction_begin()
   IF NOT abmp002_upd_seq() THEN
      CALL s_transaction_end('N','0')
      RETURN
   ELSE
      DISPLAY 100 TO stagecomplete
      CALL s_transaction_end('Y','0')
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE abmp002_process_cs CURSOR FROM ls_sql
#  FOREACH abmp002_process_cs INTO
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
      
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL abmp002_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="abmp002.get_buffer" >}
PRIVATE FUNCTION abmp002_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.order1 = p_dialog.getFieldBuffer('order1')
   LET g_master.order2 = p_dialog.getFieldBuffer('order2')
   LET g_master.order3 = p_dialog.getFieldBuffer('order3')
   LET g_master.order4 = p_dialog.getFieldBuffer('order4')
   LET g_master.reseq = p_dialog.getFieldBuffer('reseq')
   LET g_master.renum = p_dialog.getFieldBuffer('renum')
   LET g_master.site_bom = p_dialog.getFieldBuffer('site_bom')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abmp002.msgcentre_notify" >}
PRIVATE FUNCTION abmp002_msgcentre_notify()
 
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
 
{<section id="abmp002.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION abmp002_upd_seq()
DEFINE l_sql   STRING
DEFINE l_bmba  RECORD 
           bmbaent  LIKE bmba_t.bmbaent,
           bmbasite LIKE bmba_t.bmbasite,
           bmba001  LIKE bmba_t.bmba001,
           bmba002  LIKE bmba_t.bmba002,
           bmba003  LIKE bmba_t.bmba003,
           bmba004  LIKE bmba_t.bmba004,
           bmba005  DATETIME YEAR TO SECOND,
           bmba007  LIKE bmba_t.bmba007,
           bmba008  LIKE bmba_t.bmba008
           END RECORD
#DEFINE l_bmaa  RECORD LIKE bmaa_t.*  #161124-00048#1   2016/12/05  By 08734 mark
   #161124-00048#1   2016/12/05  By 08734 add(S)
   DEFINE l_bmaa RECORD  #產品結構單頭檔
       bmaaent LIKE bmaa_t.bmaaent, #企业编号
       bmaasite LIKE bmaa_t.bmaasite, #营运据点
       bmaastus LIKE bmaa_t.bmaastus, #状态码
       bmaa001 LIKE bmaa_t.bmaa001, #主件料号
       bmaa002 LIKE bmaa_t.bmaa002, #特性
       bmaa003 LIKE bmaa_t.bmaa003, #批次数量
       bmaa004 LIKE bmaa_t.bmaa004, #生产单位
       bmaaownid LIKE bmaa_t.bmaaownid, #资料所有者
       bmaaowndp LIKE bmaa_t.bmaaowndp, #资料所有部门
       bmaacrtid LIKE bmaa_t.bmaacrtid, #资料录入者
       bmaacrtdp LIKE bmaa_t.bmaacrtdp, #资料录入部门
       bmaacrtdt LIKE bmaa_t.bmaacrtdt, #资料创建日
       bmaamodid LIKE bmaa_t.bmaamodid, #资料更改者
       bmaamoddt LIKE bmaa_t.bmaamoddt, #最近更改日
       bmaacnfid LIKE bmaa_t.bmaacnfid, #资料审核者
       bmaacnfdt LIKE bmaa_t.bmaacnfdt #数据审核日
END RECORD
#161124-00048#1   2016/12/05  By 08734 add(E)
DEFINE l_order_num LIKE type_t.num5
DEFINE l_num   LIKE type_t.num5 
DEFINE l_cnt   LIKE type_t.num5
  # LET l_sql = "SELECT * FROM bmaa_t WHERE bmaaent = ",g_enterprise," AND ",g_master.wc  #161124-00048#1   2016/12/05  By 08734 mark
   LET l_sql = "SELECT bmaaent,bmaasite,bmaastus,bmaa001,bmaa002,bmaa003,bmaa004,bmaaownid,bmaaowndp,bmaacrtid,bmaacrtdp,bmaacrtdt,bmaamodid,bmaamoddt,bmaacnfid,bmaacnfdt FROM bmaa_t WHERE bmaaent = ",g_enterprise," AND ",g_master.wc  #161124-00048#1   2016/12/05  By 08734 add  
   IF g_argv1 = '1' AND g_master.site_bom = 'N' THEN
      LET l_sql = l_sql," AND bmaasite = 'ALL'"
   END IF
   IF g_argv1 = '2' THEN
      LET l_sql = l_sql," AND bmaasite = '",g_site,"'"
   END IF
   PREPARE sel_bmaa_prep1 FROM l_sql
   DECLARE sel_bmaa_curs1 CURSOR FOR sel_bmaa_prep1
   
   LET l_cnt = 0
   FOREACH sel_bmaa_curs1 INTO l_bmaa.*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
      LET l_sql = "SELECT bmbaent,bmbasite,bmba001,bmba002,bmba003,bmba004,bmba005,bmba007,bmba008 FROM bmba_t WHERE bmbaent = ",l_bmaa.bmaaent,
                  " AND bmbasite = '",l_bmaa.bmaasite,"' AND bmba001 = '",l_bmaa.bmaa001,
                  "' AND bmba002 = '",l_bmaa.bmaa002,"'"
      IF NOT cl_null(g_master.reseq) THEN
         LET l_sql = l_sql," AND bmba009 >= ",g_master.reseq
      END IF
      LET l_sql = l_sql," ORDER BY " 
      CASE g_master.order1 
         WHEN '1'
            LET l_sql = l_sql,"bmba009,"
         WHEN '2'
            LET l_sql = l_sql,"bmba004,"
         WHEN '3'
            LET l_sql = l_sql,"bmba007,"
         WHEN '4'
            LET l_sql = l_sql,"bmba003,"
      END CASE
      CASE g_master.order2 
         WHEN '1'
            LET l_sql = l_sql,"bmba009,"
         WHEN '2'
            LET l_sql = l_sql,"bmba004,"
         WHEN '3'
            LET l_sql = l_sql,"bmba007,"
         WHEN '4'
            LET l_sql = l_sql,"bmba003,"
      END CASE
      CASE g_master.order3 
         WHEN '1'
            LET l_sql = l_sql,"bmba009,"
         WHEN '2'
            LET l_sql = l_sql,"bmba004,"
         WHEN '3'
            LET l_sql = l_sql,"bmba007,"
         WHEN '4'
            LET l_sql = l_sql,"bmba003,"
      END CASE
      CASE g_master.order4 
         WHEN '1'
            LET l_sql = l_sql,"bmba009"
         WHEN '2'
            LET l_sql = l_sql,"bmba004"
         WHEN '3'
            LET l_sql = l_sql,"bmba007"
         WHEN '4'
            LET l_sql = l_sql,"bmba003"
      END CASE
      
      PREPARE sel_bmba_prep2 FROM l_sql
      DECLARE sel_bmba_curs2 CURSOR FOR sel_bmba_prep2
      IF NOT cl_null(g_master.reseq) THEN
         LET l_order_num = g_master.reseq
      ELSE
         LET l_order_num = g_master.renum
      END IF
      FOREACH sel_bmba_curs2 INTO l_bmba.*
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN FALSE
         END IF
         UPDATE bmba_t SET bmba009 = l_order_num
          WHERE bmbaent = l_bmba.bmbaent AND bmbasite = l_bmba.bmbasite
            AND bmba001 = l_bmba.bmba001 AND bmba002 = l_bmba.bmba002
            AND bmba003 = l_bmba.bmba003 AND bmba004 = l_bmba.bmba004
            AND bmba005 = l_bmba.bmba005 AND bmba007 = l_bmba.bmba007 AND bmba008 = l_bmba.bmba008
         IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
            INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()

            RETURN FALSE
         END IF
         LET l_order_num = l_order_num + g_master.renum
      END FOREACH
      LET l_cnt = l_cnt + 1
   END FOREACH
   IF l_cnt > 0 THEN
      RETURN TRUE 
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'afa-00067'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
