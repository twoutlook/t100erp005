#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr506.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-11-22 14:40:03), PR版次:0001(2016-11-24 15:20:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr506
#+ Description: 進銷存同期比彙總表
#+ Creator....: 08172(2016-11-09 13:40:23)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="aslr506.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
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
   DEFINE gi_hiden_rep_temp    LIKE type_t.num5             
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
       imaa154 LIKE imaa_t.imaa154, 
   l_month LIKE type_t.chr500, 
   rtax001_1 LIKE type_t.chr10, 
   rtax001_2 LIKE type_t.chr10, 
   imaa009 LIKE type_t.chr10, 
   imaa126 LIKE type_t.chr10, 
   imaa127 LIKE type_t.chr10, 
   imaa156 LIKE type_t.chr10, 
   imaa130 LIKE type_t.chr500, 
   imaa132 LIKE type_t.chr10,
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
 
{<section id="aslr506.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("asl","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aslr506_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aslr506 WITH FORM cl_ap_formpath("asl",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aslr506_init()
 
      #進入選單 Menu (="N")
      CALL aslr506_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aslr506
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aslr506.init" >}
#+ 初始化作業
PRIVATE FUNCTION aslr506_init()
   #add-point:init段define name="init.define"
   
   #end add-point
   #add-point:init段define (客製用) name="init.define_customerization"
   
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
#   CALL cl_set_combo_scc_part("imaa155","6940","1,2")
   CALL cl_set_combo_scc("imaa156","6941")
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aslr506.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr506_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_str    STRING
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.imaa154,g_master.l_month 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa154
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.imaa154,"0","0","","","azz-00079",1) THEN
               NEXT FIELD imaa154
            END IF 
 
 
 
            #add-point:AFTER FIELD imaa154 name="input.a.imaa154"
            IF NOT cl_null(g_master.imaa154) THEN
               LET l_str = g_master.imaa154
               IF l_str.getLength() != 4 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00035'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imaa154
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa154
            #add-point:BEFORE FIELD imaa154 name="input.b.imaa154"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE imaa154
            #add-point:ON CHANGE imaa154 name="input.g.imaa154"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_month
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.l_month,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_month
            END IF 
 
 
 
            #add-point:AFTER FIELD l_month name="input.a.l_month"
            IF NOT cl_null(g_master.l_month) THEN
               IF g_master.l_month > 12 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00034'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imaa154
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_month
            #add-point:BEFORE FIELD l_month name="input.b.l_month"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_month
            #add-point:ON CHANGE l_month name="input.g.l_month"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.imaa154
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa154
            #add-point:ON ACTION controlp INFIELD imaa154 name="input.c.imaa154"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_month
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_month
            #add-point:ON ACTION controlp INFIELD l_month name="input.c.l_month"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF cl_null(g_master.imaa154) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00030'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD imaa154
               END IF
               IF cl_null(g_master.l_month) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asl-00033'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD l_month
               END IF
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rtax001_1,rtax001_2,imaa009,imaa126,imaa127,imaa156,imaa130, 
             imaa132
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rtax001_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtax001_1
            #add-point:ON ACTION controlp INFIELD rtax001_1 name="construct.c.rtax001_1"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 = '1'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtax001_1  #顯示到畫面上
            NEXT FIELD rtax001_1                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtax001_1
            #add-point:BEFORE FIELD rtax001_1 name="construct.b.rtax001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtax001_1
            
            #add-point:AFTER FIELD rtax001_1 name="construct.a.rtax001_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.rtax001_2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rtax001_2
            #add-point:ON ACTION controlp INFIELD rtax001_2 name="construct.c.rtax001_2"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax004 = '2'"
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtax001_2  #顯示到畫面上
            NEXT FIELD rtax001_2                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rtax001_2
            #add-point:BEFORE FIELD rtax001_2 name="construct.b.rtax001_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rtax001_2
            
            #add-point:AFTER FIELD rtax001_2 name="construct.a.rtax001_2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa009
            #add-point:ON ACTION controlp INFIELD imaa009 name="construct.c.imaa009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rtax005 = 0"
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上
            NEXT FIELD imaa009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009 name="construct.b.imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa009
            
            #add-point:AFTER FIELD imaa009 name="construct.a.imaa009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa126
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa126
            #add-point:ON ACTION controlp INFIELD imaa126 name="construct.c.imaa126"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa126  #顯示到畫面上
            NEXT FIELD imaa126                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa126
            #add-point:BEFORE FIELD imaa126 name="construct.b.imaa126"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa126
            
            #add-point:AFTER FIELD imaa126 name="construct.a.imaa126"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa127
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa127
            #add-point:ON ACTION controlp INFIELD imaa127 name="construct.c.imaa127"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2003'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa127  #顯示到畫面上
            NEXT FIELD imaa127                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa127
            #add-point:BEFORE FIELD imaa127 name="construct.b.imaa127"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa127
            
            #add-point:AFTER FIELD imaa127 name="construct.a.imaa127"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa156
            #add-point:BEFORE FIELD imaa156 name="construct.b.imaa156"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa156
            
            #add-point:AFTER FIELD imaa156 name="construct.a.imaa156"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa156
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa156
            #add-point:ON ACTION controlp INFIELD imaa156 name="construct.c.imaa156"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa130
            #add-point:BEFORE FIELD imaa130 name="construct.b.imaa130"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa130
            
            #add-point:AFTER FIELD imaa130 name="construct.a.imaa130"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.imaa130
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa130
            #add-point:ON ACTION controlp INFIELD imaa130 name="construct.c.imaa130"
            
            #END add-point
 
 
         #Ctrlp:construct.c.imaa132
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD imaa132
            #add-point:ON ACTION controlp INFIELD imaa132 name="construct.c.imaa132"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2006'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa132  #顯示到畫面上
            NEXT FIELD imaa132                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD imaa132
            #add-point:BEFORE FIELD imaa132 name="construct.b.imaa132"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD imaa132
            
            #add-point:AFTER FIELD imaa132 name="construct.a.imaa132"
            
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
            CALL cl_qbe_display_condition(FGL_GETENV("QUERYPLANID"), g_user)
            CALL aslr506_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aslr506_get_buffer(l_dialog)
            IF NOT cl_null(ls_wc) THEN
               LET g_master.wc = ls_wc
               #取得條件後需要執行項目,應新增於下方adp
               #add-point:ui_dialog段qbe_select後 name="ui_dialog.qbe_select"
               
               #end add-point
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION output
            LET g_action_choice = "output"
            ACCEPT DIALOG
 
         ON ACTION quickprint
            LET g_action_choice = "quickprint"
            ACCEPT DIALOG
 
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
 
         ON ACTION rpt_replang
            CALL cl_gr_set_dlang()
 
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
         CALL aslr506_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
 
     #LET lc_param.wc = g_master.wc    #r類主程式不在意lc_param,不使用轉換
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      
      #end add-point
 
      LET ls_js = util.JSON.stringify(g_master)  #r類使用g_master/p類使用lc_param
 
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
                 CALL aslr506_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aslr506_transfer_argv(ls_js)
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
         LET gi_hiden_rep_temp = FALSE   #報表樣板設定
         CALL cl_schedule_hidden()
      END IF
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aslr506.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aslr506_transfer_argv(ls_js)
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
   #add-point:transfer_agrv段define (客製用) name="transfer_agrv.define_customerization"
   
   #end add-point
 
   LET la_cmdrun.prog = g_prog
   LET la_cmdrun.background = "Y"
   LET la_cmdrun.param[1] = ls_js
 
   #add-point:transfer.argv段程式內容 name="transfer.argv.define"
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="aslr506.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aslr506_process(ls_js)
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_r01_status LIKE type_t.num5
   DEFINE l_token       base.StringTokenizer      #cmdrun使用
   DEFINE ls_next       STRING                    #cmdrun使用
   DEFINE l_cnt         LIKE type_t.num5          #cmdrun使用   
   DEFINE l_arg         DYNAMIC ARRAY OF STRING   ##cmdrun使用的陣列 
   #add-point:process段define name="process.define"
   
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"rtax001_1,rtax001_2,imaa009,imaa126,imaa127,imaa156,imaa130,imaa132")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = "1=1"
   END IF
   LET g_master.wc = cl_replace_str(g_master.wc," 1=1"," (1=1")
   LET g_master.wc = cl_replace_str(g_master.wc,"rtax001_1"," (rtaw003 = '1' AND rtaw001")
   LET g_master.wc = cl_replace_str(g_master.wc," and rtax001_2"," ) OR (rtaw003 = '2' AND rtaw001")
   LET g_master.wc = cl_replace_str(g_master.wc,"rtax001_2"," (rtaw003 = '2' AND rtaw001")   
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa009"," ) OR imaa009")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa009"," (imaa009")
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa126"," ) and imaa126")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa126"," (imaa126")
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa127"," ) and imaa127")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa127"," (imaa127")
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa156"," ) and imaa156")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa156"," (imaa156")
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa130"," ) and imaa130")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa130"," (imaa130")
   LET g_master.wc = cl_replace_str(g_master.wc," and imaa132"," ) and imaa132")
   LET g_master.wc = cl_replace_str(g_master.wc,"imaa132"," (imaa132")
   LET g_master.wc = g_master.wc,")" CLIPPED
   CALL aslr506_x01(g_master.wc,g_master.imaa154,g_master.l_month)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aslr506_process_cs CURSOR FROM ls_sql
#  FOREACH aslr506_process_cs INTO
   #add-point:process段process name="process.process"
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" OR g_bgjob = "T" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      
      #end add-point
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      
      #end add-point
      CALL cl_schedule_exec_call(li_r01_status)
   END IF
END FUNCTION
 
{</section>}
 
{<section id="aslr506.get_buffer" >}
PRIVATE FUNCTION aslr506_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.imaa154 = p_dialog.getFieldBuffer('imaa154')
   LET g_master.l_month = p_dialog.getFieldBuffer('l_month')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aslr506.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 