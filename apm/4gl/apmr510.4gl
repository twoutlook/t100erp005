#該程式未解開Section, 採用最新樣板產出!
{<section id="apmr510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-06-29 08:54:37), PR版次:0006(2016-08-17 17:36:44)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000111
#+ Filename...: apmr510
#+ Description: 採購變更憑證列印
#+ Creator....: 05229(2014-06-23 14:11:48)
#+ Modifier...: 06814 -SD/PR- 08734
 
{</section>}
 
{<section id="apmr510.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#160816-00001#8  2016/08/17  By 08734     抓取理由碼改CALL sub
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
       pmeedocno LIKE pmee_t.pmeedocno, 
   pmeedocdt LIKE pmee_t.pmeedocdt, 
   pmee002 LIKE pmee_t.pmee002, 
   pmee003 LIKE pmee_t.pmee003, 
   pmee004 LIKE pmee_t.pmee004, 
   pmee023 LIKE pmee_t.pmee023, 
   pmee001 LIKE pmee_t.pmee001, 
   pmee903 LIKE pmee_t.pmee903, 
   pmee902 LIKE pmee_t.pmee902, 
   pmeestus LIKE type_t.chr500, 
   pmeechk LIKE type_t.chr500,
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
 
{<section id="apmr510.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
      CALL apmr510_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmr510 WITH FORM cl_ap_formpath("apm",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL apmr510_init()
 
      #進入選單 Menu (="N")
      CALL apmr510_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_apmr510
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="apmr510.init" >}
#+ 初始化作業
PRIVATE FUNCTION apmr510_init()
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
   LET g_master.pmeestus = '0'
   LET g_master.pmeechk   = 'N'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="apmr510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmr510_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_gzcb008 LIKE gzcb_t.gzcb008
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
         INPUT BY NAME g_master.pmeestus,g_master.pmeechk 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeestus
            #add-point:BEFORE FIELD pmeestus name="input.b.pmeestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeestus
            
            #add-point:AFTER FIELD pmeestus name="input.a.pmeestus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeestus
            #add-point:ON CHANGE pmeestus name="input.g.pmeestus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeechk
            #add-point:BEFORE FIELD pmeechk name="input.b.pmeechk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeechk
            
            #add-point:AFTER FIELD pmeechk name="input.a.pmeechk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmeechk
            #add-point:ON CHANGE pmeechk name="input.g.pmeechk"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.pmeestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeestus
            #add-point:ON ACTION controlp INFIELD pmeestus name="input.c.pmeestus"
            
            #END add-point
 
 
         #Ctrlp:input.c.pmeechk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeechk
            #add-point:ON ACTION controlp INFIELD pmeechk name="input.c.pmeechk"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON pmeedocno,pmeedocdt,pmee002,pmee003,pmee004,pmee023,pmee001, 
             pmee903,pmee902
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.pmeedocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeedocno
            #add-point:ON ACTION controlp INFIELD pmeedocno name="construct.c.pmeedocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmeestus != 'X' "
            CALL q_pmeedocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmeedocno  #顯示到畫面上
            NEXT FIELD pmeedocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeedocno
            #add-point:BEFORE FIELD pmeedocno name="construct.b.pmeedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeedocno
            
            #add-point:AFTER FIELD pmeedocno name="construct.a.pmeedocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmeedocdt
            #add-point:BEFORE FIELD pmeedocdt name="construct.b.pmeedocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmeedocdt
            
            #add-point:AFTER FIELD pmeedocdt name="construct.a.pmeedocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmeedocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmeedocdt
            #add-point:ON ACTION controlp INFIELD pmeedocdt name="construct.c.pmeedocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmee002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee002
            #add-point:ON ACTION controlp INFIELD pmee002 name="construct.c.pmee002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmee002  #顯示到畫面上
            NEXT FIELD pmee002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee002
            #add-point:BEFORE FIELD pmee002 name="construct.b.pmee002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee002
            
            #add-point:AFTER FIELD pmee002 name="construct.a.pmee002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmee003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee003
            #add-point:ON ACTION controlp INFIELD pmee003 name="construct.c.pmee003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmee003  #顯示到畫面上
            NEXT FIELD pmee003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee003
            #add-point:BEFORE FIELD pmee003 name="construct.b.pmee003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee003
            
            #add-point:AFTER FIELD pmee003 name="construct.a.pmee003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmee004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee004
            #add-point:ON ACTION controlp INFIELD pmee004 name="construct.c.pmee004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmee004  #顯示到畫面上
            NEXT FIELD pmee004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee004
            #add-point:BEFORE FIELD pmee004 name="construct.b.pmee004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee004
            
            #add-point:AFTER FIELD pmee004 name="construct.a.pmee004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmee023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee023
            #add-point:ON ACTION controlp INFIELD pmee023 name="construct.c.pmee023"
                            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #160621-00003#3 20160627 modify by beckxie---S
			   #LET g_qryparam.arg1 = "275"
            #CALL q_oocq002()                           #呼叫開窗
            LET g_qryparam.arg1 = '2'
            CALL q_oojd001_1()
            #160621-00003#3 20160627 modify by beckxie---E
            DISPLAY g_qryparam.return1 TO pmee023  #顯示到畫面上
            NEXT FIELD pmee023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee023
            #add-point:BEFORE FIELD pmee023 name="construct.b.pmee023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee023
            
            #add-point:AFTER FIELD pmee023 name="construct.a.pmee023"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee001
            #add-point:BEFORE FIELD pmee001 name="construct.b.pmee001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee001
            
            #add-point:AFTER FIELD pmee001 name="construct.a.pmee001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmee001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee001
            #add-point:ON ACTION controlp INFIELD pmee001 name="construct.c.pmee001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.pmee903
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee903
            #add-point:ON ACTION controlp INFIELD pmee903 name="construct.c.pmee903"
           # SELECT gzcb008 INTO l_gzcb008   #160816-00001#8  2016/08/17  By 08734 Mark
           #     FROM gzcb_t
           #    WHERE gzcb001 = '24'
           #      AND gzcb002 = 'apmt500'
            LET l_gzcb008 = s_fin_get_scc_value('24','apmt500','6')  #160816-00001#8  2016/08/17  By 08734 add
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = l_gzcb008
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmee903  #顯示到畫面上
            NEXT FIELD pmee903                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee903
            #add-point:BEFORE FIELD pmee903 name="construct.b.pmee903"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee903
            
            #add-point:AFTER FIELD pmee903 name="construct.a.pmee903"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmee902
            #add-point:BEFORE FIELD pmee902 name="construct.b.pmee902"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmee902
            
            #add-point:AFTER FIELD pmee902 name="construct.a.pmee902"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.pmee902
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmee902
            #add-point:ON ACTION controlp INFIELD pmee902 name="construct.c.pmee902"
            
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
            CALL apmr510_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL apmr510_get_buffer(l_dialog)
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
            LET g_master.pmeestus = '0'
            LET g_master.pmeechk   = 'N'
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
         CALL apmr510_init()
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
                 CALL apmr510_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = apmr510_transfer_argv(ls_js)
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
 
{<section id="apmr510.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION apmr510_transfer_argv(ls_js)
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
 
{<section id="apmr510.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION apmr510_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"pmeedocno,pmeedocdt,pmee002,pmee003,pmee004,pmee023,pmee001,pmee903,pmee902")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #modify--2015/08/17 By shiun--(S)
   IF cl_null(g_master.wc) THEN
      CALL l_arg.clear()
      LET l_token = base.StringTokenizer.create(ls_js,",")
      LET l_cnt = 1
      WHILE l_token.hasMoreTokens()
         LET ls_next = l_token.nextToken()
         IF l_cnt>1 THEN
            LET ls_next = ls_next.subString(ls_next.getIndexOf("'",1)+1,ls_next.getLength())
            LET ls_next = ls_next.subString(1,ls_next.getIndexOf("'",1)-1)
         END IF
         LET l_arg[l_cnt] = ls_next
         LET l_cnt = l_cnt + 1
      END WHILE
      CALL l_arg.deleteElement(l_cnt)
      LET  g_master.wc = l_arg[01]
      LET  g_master.pmeechk = l_arg[02]
   ELSE
      CASE g_master.pmeestus
         WHEN '1'
            LET g_master.wc = g_master.wc CLIPPED," AND pmeestus = 'N' "
         WHEN '2'
            LET g_master.wc = g_master.wc CLIPPED," AND pmeestus = 'Y' "
      END CASE
   
#      LET g_master.wc = g_master.wc CLIPPED," AND pmeeent =",g_enterprise," AND pmeesite='",g_site,"' "  #160324-00003 by whitney mark 搬到 apmr510_g01
   END IF                     
   
   CALL apmr510_g01(g_master.wc,g_master.pmeechk)
   #modify--2015/08/17 By shiun--(E) 
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE apmr510_process_cs CURSOR FROM ls_sql
#  FOREACH apmr510_process_cs INTO
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
 
{<section id="apmr510.get_buffer" >}
PRIVATE FUNCTION apmr510_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.pmeestus = p_dialog.getFieldBuffer('pmeestus')
   LET g_master.pmeechk = p_dialog.getFieldBuffer('pmeechk')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="apmr510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
