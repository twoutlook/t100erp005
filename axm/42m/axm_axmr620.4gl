#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0009(2017-01-25 10:35:07), PR版次:0009(2017-01-25 10:48:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000114
#+ Filename...: axmr620
#+ Description: Invoice列印
#+ Creator....: 05016(2014-05-21 15:10:34)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="axmr620.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161031-00021#2 2016/12/19 By 08992  axmr620增加選項"列印單價選項"，可選列印單價一、單價二，報表單價、金額資料依選項列印
#161031-00024#4 2017/01/25 By 06137  2.報表畫面增加"列印額外品名規格"選項
#                                    2-1.打勾時，依料件編號+單別參數"額外品名規格類型"，串到aimm221抓取資料
#                                    2-2.有抓到值時，原品名規格資料不印，改印額外品名規格資料，額外品名規格資料依行序+換行符號組成一個大字串放至品名中
#                                    2-3.沒抓到值，印原品名規格
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
       xmdodocno LIKE xmdo_t.xmdodocno, 
   xmdodocdt LIKE xmdo_t.xmdodocdt, 
   xmdo002 LIKE xmdo_t.xmdo002, 
   xmdo003 LIKE xmdo_t.xmdo003, 
   xmdo007 LIKE xmdo_t.xmdo007, 
   xmdo008 LIKE xmdo_t.xmdo008, 
   xmdo009 LIKE xmdo_t.xmdo009, 
   xmdoradio LIKE type_t.chr500, 
   c1 LIKE type_t.chr500, 
   l_radio2 LIKE type_t.chr500,
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
 
{<section id="axmr620.main" >}
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
   CALL cl_ap_init("axm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
    
      #end add-point
      CALL axmr620_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axmr620 WITH FORM cl_ap_formpath("axm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL axmr620_init()
 
      #進入選單 Menu (="N")
      CALL axmr620_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axmr620
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axmr620.init" >}
#+ 初始化作業
PRIVATE FUNCTION axmr620_init()
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
   LET g_master.xmdoradio = '0'
   #161031-00021#2-s
   LET g_master.l_radio2 = '1'
   #161031-00021#2-e
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axmr620.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr620_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   
   #end add-point
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_master.c1 = 'N'              #161031-00024#4 Add By Ken 170125
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.xmdoradio,g_master.c1,g_master.l_radio2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdoradio
            #add-point:BEFORE FIELD xmdoradio name="input.b.xmdoradio"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdoradio
            
            #add-point:AFTER FIELD xmdoradio name="input.a.xmdoradio"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdoradio
            #add-point:ON CHANGE xmdoradio name="input.g.xmdoradio"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD c1
            #add-point:BEFORE FIELD c1 name="input.b.c1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD c1
            
            #add-point:AFTER FIELD c1 name="input.a.c1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE c1
            #add-point:ON CHANGE c1 name="input.g.c1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_radio2
            #add-point:BEFORE FIELD l_radio2 name="input.b.l_radio2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_radio2
            
            #add-point:AFTER FIELD l_radio2 name="input.a.l_radio2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_radio2
            #add-point:ON CHANGE l_radio2 name="input.g.l_radio2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.xmdoradio
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdoradio
            #add-point:ON ACTION controlp INFIELD xmdoradio name="input.c.xmdoradio"
            
            #END add-point
 
 
         #Ctrlp:input.c.c1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD c1
            #add-point:ON ACTION controlp INFIELD c1 name="input.c.c1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_radio2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_radio2
            #add-point:ON ACTION controlp INFIELD l_radio2 name="input.c.l_radio2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xmdodocno,xmdodocdt,xmdo002,xmdo003,xmdo007,xmdo008,xmdo009 
 
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.xmdodocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdodocno
            #add-point:ON ACTION controlp INFIELD xmdodocno name="construct.c.xmdodocno"
            #此段落由子樣板a08產生
            #Invoice 單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.WHERE = " xmdosite = '",g_site,"' "
            CALL q_xmdodocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdodocno  #顯示到畫面上
            NEXT FIELD xmdodocno                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdodocno
            #add-point:BEFORE FIELD xmdodocno name="construct.b.xmdodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdodocno
            
            #add-point:AFTER FIELD xmdodocno name="construct.a.xmdodocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdodocdt
            #add-point:BEFORE FIELD xmdodocdt name="construct.b.xmdodocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdodocdt
            
            #add-point:AFTER FIELD xmdodocdt name="construct.a.xmdodocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdodocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdodocdt
            #add-point:ON ACTION controlp INFIELD xmdodocdt name="construct.c.xmdodocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xmdo002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdo002
            #add-point:ON ACTION controlp INFIELD xmdo002 name="construct.c.xmdo002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdo002  #顯示到畫面上
            NEXT FIELD xmdo002                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdo002
            #add-point:BEFORE FIELD xmdo002 name="construct.b.xmdo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdo002
            
            #add-point:AFTER FIELD xmdo002 name="construct.a.xmdo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdo003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdo003
            #add-point:ON ACTION controlp INFIELD xmdo003 name="construct.c.xmdo003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdo003  #顯示到畫面上
            NEXT FIELD xmdo003                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdo003
            #add-point:BEFORE FIELD xmdo003 name="construct.b.xmdo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdo003
            
            #add-point:AFTER FIELD xmdo003 name="construct.a.xmdo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdo007
            #add-point:ON ACTION controlp INFIELD xmdo007 name="construct.c.xmdo007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdo007  #顯示到畫面上
            NEXT FIELD xmdo007                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdo007
            #add-point:BEFORE FIELD xmdo007 name="construct.b.xmdo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdo007
            
            #add-point:AFTER FIELD xmdo007 name="construct.a.xmdo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdo008
            #add-point:ON ACTION controlp INFIELD xmdo008 name="construct.c.xmdo008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdo008  #顯示到畫面上
            NEXT FIELD xmdo008                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdo008
            #add-point:BEFORE FIELD xmdo008 name="construct.b.xmdo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdo008
            
            #add-point:AFTER FIELD xmdo008 name="construct.a.xmdo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xmdo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdo009
            #add-point:ON ACTION controlp INFIELD xmdo009 name="construct.c.xmdo009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg2 = g_site
            CALL q_pmac002_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xmdo009  #顯示到畫面上
            NEXT FIELD xmdo009                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdo009
            #add-point:BEFORE FIELD xmdo009 name="construct.b.xmdo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdo009
            
            #add-point:AFTER FIELD xmdo009 name="construct.a.xmdo009"
            
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
            CALL axmr620_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL axmr620_get_buffer(l_dialog)
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
         CALL axmr620_init()
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
                 CALL axmr620_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = axmr620_transfer_argv(ls_js)
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
 
{<section id="axmr620.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION axmr620_transfer_argv(ls_js)
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
 
{<section id="axmr620.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION axmr620_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xmdodocno,xmdodocdt,xmdo002,xmdo003,xmdo007,xmdo008,xmdo009")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         #add--2015/08/17 By shiun--(S)
         IF l_cnt>1 THEN
            LET ls_next = ls_next.subString(ls_next.getIndexOf("'",1)+1,ls_next.getLength())
            LET ls_next = ls_next.subString(1,ls_next.getIndexOf("'",1)-1)
         END IF
         #add--2015/08/17 By shiun--(E)
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET  g_master.wc = l_arg[01]
      #161031-00021#2-s
      LET  g_master.l_radio2 = l_arg[02]
      #161031-00021#2-e
      LET  g_master.c1 = l_arg[03]       #161031-00024#4 Add By Ken 170125            
   ELSE
      CASE g_master.xmdoradio
         WHEN '1'
            LET g_master.wc = g_master.wc CLIPPED," AND xmdostus = 'N' "
         WHEN '2'
            LET g_master.wc = g_master.wc CLIPPED," AND xmdostus = 'Y' "
      END CASE     
      LET g_master.wc = g_master.wc CLIPPED," AND xmdoent =",g_enterprise," AND xmdosite ='",g_site,"' " 
   END IF      
   #CALL axmr620_g01(g_master.wc)  #161031-00021#2 MARK
   #161031-00021#2-s
   #CALL axmr620_g01(g_master.wc,g_master.l_radio2)              #161031-00024#4 Mark By Ken 170125   
   CALL axmr620_g01(g_master.wc,g_master.l_radio2,g_master.c1)   #161031-00024#4 Add By Ken 170125   
   #161031-00021#2-e
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE axmr620_process_cs CURSOR FROM ls_sql
#  FOREACH axmr620_process_cs INTO
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
 
{<section id="axmr620.get_buffer" >}
PRIVATE FUNCTION axmr620_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.xmdoradio = p_dialog.getFieldBuffer('xmdoradio')
   LET g_master.c1 = p_dialog.getFieldBuffer('c1')
   LET g_master.l_radio2 = p_dialog.getFieldBuffer('l_radio2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axmr620.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
