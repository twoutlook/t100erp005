#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr305.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-09-12 10:51:25), PR版次:0007(2016-09-12 10:55:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: ainr305
#+ Description: 庫存雜項異動資料列印
#+ Creator....: 05423(2014-11-27 11:07:48)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="ainr305.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#150601-00042   zhujing mod where条件组出有误，添加置换inba002为inbidocdt
#160325-00007#1 2016-3-25 By zhujing 报废单的扣账日期inbi007
#160707-00006#1 2016/07/07  By Ann_Huang 補上日期與扣帳日期欄位的Table名稱與欄位名稱(規格)
#160912-00004#1 2016/09/12 By lixiang scc码18003属于客制模块，改为标准的，新建scc码3090
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
       l_ck1 LIKE type_t.chr500, 
   l_ck3 LIKE type_t.chr500, 
   l_ck2 LIKE type_t.chr500, 
   l_ck4 LIKE type_t.chr500, 
   xxxxdocno LIKE type_t.chr500, 
   inbadocdt LIKE type_t.dat, 
   xxxx004 LIKE type_t.chr500, 
   xxxx003 LIKE type_t.chr500, 
   inba002 LIKE type_t.dat, 
   inbastus LIKE inba_t.inbastus, 
   l_pr LIKE type_t.chr500,
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
 
{<section id="ainr305.main" >}
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
   CALL cl_ap_init("ain","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL ainr305_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainr305 WITH FORM cl_ap_formpath("ain",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL ainr305_init()
 
      #進入選單 Menu (="N")
      CALL ainr305_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_ainr305
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="ainr305.init" >}
#+ 初始化作業
PRIVATE FUNCTION ainr305_init()
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
   CALL cl_set_combo_scc_part("l_type","4043","1,2,3,4") 
   #CALL cl_set_combo_scc_part("inbastus","18003","1,2,3,4,5")  #160912-00004#1 
   CALL cl_set_combo_scc_part('inbastus','3090','1,2,3,4,5')    #160912-00004#1 
   LET g_master.l_pr = 'N'
   INITIALIZE g_master.inbadocdt TO NULL
   INITIALIZE g_master.inba002 TO NULL
#   LET g_master.l_type = '1'
   LET g_master.l_ck1 = 'Y'
   LET g_master.l_ck2 = 'N'
   LET g_master.l_ck3 = 'N'
   LET g_master.l_ck4 = 'N'
   LET g_master.inbastus = '1'
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="ainr305.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr305_ui_dialog()
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
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_ck1,g_master.l_ck3,g_master.l_ck2,g_master.l_ck4,g_master.inbastus, 
             g_master.l_pr 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ck1
            #add-point:BEFORE FIELD l_ck1 name="input.b.l_ck1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ck1
            
            #add-point:AFTER FIELD l_ck1 name="input.a.l_ck1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_ck1
            #add-point:ON CHANGE l_ck1 name="input.g.l_ck1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ck3
            #add-point:BEFORE FIELD l_ck3 name="input.b.l_ck3"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ck3
            
            #add-point:AFTER FIELD l_ck3 name="input.a.l_ck3"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_ck3
            #add-point:ON CHANGE l_ck3 name="input.g.l_ck3"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ck2
            #add-point:BEFORE FIELD l_ck2 name="input.b.l_ck2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ck2
            
            #add-point:AFTER FIELD l_ck2 name="input.a.l_ck2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_ck2
            #add-point:ON CHANGE l_ck2 name="input.g.l_ck2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_ck4
            #add-point:BEFORE FIELD l_ck4 name="input.b.l_ck4"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_ck4
            
            #add-point:AFTER FIELD l_ck4 name="input.a.l_ck4"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_ck4
            #add-point:ON CHANGE l_ck4 name="input.g.l_ck4"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbastus
            #add-point:BEFORE FIELD inbastus name="input.b.inbastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbastus
            
            #add-point:AFTER FIELD inbastus name="input.a.inbastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbastus
            #add-point:ON CHANGE inbastus name="input.g.inbastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_pr
            #add-point:BEFORE FIELD l_pr name="input.b.l_pr"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_pr
            
            #add-point:AFTER FIELD l_pr name="input.a.l_pr"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_pr
            #add-point:ON CHANGE l_pr name="input.g.l_pr"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_ck1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ck1
            #add-point:ON ACTION controlp INFIELD l_ck1 name="input.c.l_ck1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_ck3
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ck3
            #add-point:ON ACTION controlp INFIELD l_ck3 name="input.c.l_ck3"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_ck2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ck2
            #add-point:ON ACTION controlp INFIELD l_ck2 name="input.c.l_ck2"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_ck4
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_ck4
            #add-point:ON ACTION controlp INFIELD l_ck4 name="input.c.l_ck4"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbastus
            #add-point:ON ACTION controlp INFIELD inbastus name="input.c.inbastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_pr
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_pr
            #add-point:ON ACTION controlp INFIELD l_pr name="input.c.l_pr"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               IF g_master.l_ck1 = 'N' AND g_master.l_ck2 = 'N' AND g_master.l_ck3 = 'N' AND g_master.l_ck4 = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = 'ain-00538'
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()   
                  NEXT FIELD l_ck1
               END IF
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON xxxxdocno,inbadocdt,xxxx004,xxxx003,inba002
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xxxxdocno
            #add-point:BEFORE FIELD xxxxdocno name="construct.b.xxxxdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xxxxdocno
            
            #add-point:AFTER FIELD xxxxdocno name="construct.a.xxxxdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xxxxdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xxxxdocno
            #add-point:ON ACTION controlp INFIELD xxxxdocno name="construct.c.xxxxdocno"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'i'
#            LET g_qryparam.reqry = FALSE
#            CALL q_inbadocno_inbidocn()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xxxxdocno  #顯示到畫面上
#            LET g_master.xxxxdocno = g_qryparam.return1
#            NEXT FIELD xxxxdocno                     #返回原欄位
    
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '0'
            LET g_qryparam.arg2 = '0'
            LET g_qryparam.arg3 = '0'
            LET g_qryparam.arg4 = '0'
            IF g_master.l_ck1 = 'Y' THEN
               LET g_qryparam.arg3 = '1'    
            END IF
            IF g_master.l_ck2 = 'Y' THEN
               LET g_qryparam.arg4 = '2'    
            END IF
            IF g_master.l_ck3 = 'Y' THEN
               LET g_qryparam.arg1 = '1'      
            END IF
            IF g_master.l_ck4 = 'Y' THEN
               LET g_qryparam.arg2 = '2'
            END IF
            CALL q_inbadocno_inbidocn() 

            DISPLAY g_qryparam.return1 TO xxxxdocno  #顯示到畫面上
            LET g_master.xxxxdocno = g_qryparam.return1
            NEXT FIELD xxxxdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbadocdt
            #add-point:BEFORE FIELD inbadocdt name="construct.b.inbadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbadocdt
            
            #add-point:AFTER FIELD inbadocdt name="construct.a.inbadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbadocdt
            #add-point:ON ACTION controlp INFIELD inbadocdt name="construct.c.inbadocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.xxxx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xxxx004
            #add-point:ON ACTION controlp INFIELD xxxx004 name="construct.c.xxxx004"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xxxx004  #顯示到畫面上
            LET g_master.xxxx004 = g_qryparam.return1
            NEXT FIELD xxxx004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xxxx004
            #add-point:BEFORE FIELD xxxx004 name="construct.b.xxxx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xxxx004
            
            #add-point:AFTER FIELD xxxx004 name="construct.a.xxxx004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xxxx003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xxxx003
            #add-point:ON ACTION controlp INFIELD xxxx003 name="construct.c.xxxx003"
            #應用 a08 樣板自動產生(Version:1)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xxxx003  #顯示到畫面上
            LET g_master.xxxx003 = g_qryparam.return1
            NEXT FIELD xxxx003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xxxx003
            #add-point:BEFORE FIELD xxxx003 name="construct.b.xxxx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xxxx003
            
            #add-point:AFTER FIELD xxxx003 name="construct.a.xxxx003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inba002
            #add-point:BEFORE FIELD inba002 name="construct.b.inba002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inba002
            
            #add-point:AFTER FIELD inba002 name="construct.a.inba002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inba002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inba002
            #add-point:ON ACTION controlp INFIELD inba002 name="construct.c.inba002"
            
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
            CALL ainr305_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL ainr305_get_buffer(l_dialog)
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
         CALL ainr305_init()
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
                 CALL ainr305_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = ainr305_transfer_argv(ls_js)
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
 
{<section id="ainr305.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION ainr305_transfer_argv(ls_js)
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
 
{<section id="ainr305.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION ainr305_process(ls_js)
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
   DEFINE l_tmp       STRING
   DEFINE l_where1 STRING 
   DEFINE l_where2 STRING 
   DEFINE l_where3 STRING 
   DEFINE l_where4 STRING 
   DEFINE l_type      LIKE type_t.num5
   DEFINE l_type2     LIKE type_t.num5
   DEFINE l_count   LIKE type_t.num5
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"xxxxdocno,inbadocdt,xxxx004,xxxx003,inba002")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   LET l_tmp = g_master.wc
   LET g_master.wc = " 1=1 "
   
   LET l_count = 0
   INITIALIZE l_where1 TO NULL
   IF g_master.l_ck1 = 'Y' THEN
      LET l_count = l_count+1
      CALL cl_replace_str(l_tmp,"xxxx","inba") RETURNING l_where1
      LET l_where1 = l_where1 ," AND inba001 = '1' AND inbasite = '",g_site CLIPPED,"' AND inbaent = '",g_enterprise CLIPPED,"' "
      CASE g_master.inbastus
         WHEN '1'
         WHEN '2'
            LET l_where1 = l_where1 CLIPPED," AND inbastus = 'N' "
         WHEN '3'
            LET l_where1 = l_where1 CLIPPED," AND inbastus = 'Y' "
         WHEN '4'
            LET l_where1 = l_where1 CLIPPED," AND inbastus = 'S' "
         WHEN '5'
            LET l_where1 = l_where1 CLIPPED," AND inbastus = 'X' "
      END CASE
      IF NOT cl_null(l_where1) THEN
         LET g_master.wc = g_master.wc CLIPPED, " AND ((",l_where1 CLIPPED," )"
      END IF
   END IF
      
   INITIALIZE l_where2 TO NULL
   IF g_master.l_ck2 = 'Y' THEN
      LET l_count = l_count+1
      CALL cl_replace_str(l_tmp,"xxxx","inba") RETURNING l_where2
      LET l_where2 = l_where2 ," AND inba001 = '2' AND inbasite = '",g_site CLIPPED,"' AND inbaent = '",g_enterprise CLIPPED,"' "
      CASE g_master.inbastus
         WHEN '1'
         WHEN '2'
            LET l_where2 = l_where2 CLIPPED," AND inbastus = 'N' "
         WHEN '3'
            LET l_where2 = l_where2 CLIPPED," AND inbastus = 'Y' "
         WHEN '4'
            LET l_where2 = l_where2 CLIPPED," AND inbastus = 'S' "
         WHEN '5'
            LET l_where2 = l_where2 CLIPPED," AND inbastus = 'X' "
      END CASE
      IF cl_null(l_where1) AND NOT cl_null(l_where2) THEN
         LET g_master.wc = g_master.wc CLIPPED, " AND ((",l_where2 CLIPPED," )"
      ELSE
         LET g_master.wc = g_master.wc CLIPPED, " OR (",l_where2 CLIPPED," )"
      END IF
   END IF
   IF (g_master.l_ck1='N' OR cl_null(g_master.l_ck1)) AND (g_master.l_ck2='N' OR cl_null(g_master.l_ck2)) THEN
      LET l_where1 = "1=2"
      LET l_where2 = "1=2"
   END IF
   
   INITIALIZE l_where3 TO NULL
   IF g_master.l_ck3 = 'Y' THEN
      LET l_count = l_count + 1
      CALL cl_replace_str(l_tmp,"xxxx003","inbi001") RETURNING l_where3
      CALL cl_replace_str(l_where3,"xxxx004","inbi002") RETURNING l_where3
      CALL cl_replace_str(l_where3,"xxxx","inbi") RETURNING l_where3
#      CALL cl_replace_str(l_where3,"inba002","inbidocdt") RETURNING l_where3     #150601-00042 zhujing add 2016-2-4
      CALL cl_replace_str(l_where3,"inba002","inbi007") RETURNING l_where3       #160325-00007#1 2016-3-25 By zhujing mod
      
      CALL cl_replace_str(l_where3,"inba","inbi") RETURNING l_where3
      LET l_where3 = l_where3 CLIPPED," AND inbi000 = '1' AND inbisite = '",g_site CLIPPED,"' AND inbient = '",g_enterprise CLIPPED,"' "
      CASE g_master.inbastus
         WHEN '1'
         WHEN '2'
            LET l_where3 = l_where3 CLIPPED," AND inbistus = 'N' "
         WHEN '3'
            LET l_where3 = l_where3 CLIPPED," AND inbistus = 'O' "
         WHEN '4'
            LET l_where3 = l_where3 CLIPPED," AND inbistus = 'S' "
         WHEN '5'
            LET l_where3 = l_where3 CLIPPED," AND inbistus = 'X' "
      END CASE 
      IF cl_null(l_where1) AND cl_null(l_where2) AND NOT cl_null(l_where3) THEN
         LET g_master.wc = g_master.wc CLIPPED, " AND ((",l_where3 CLIPPED," )"
      ELSE
         LET g_master.wc = g_master.wc CLIPPED, " OR (",l_where3 CLIPPED," )"
      END IF
   END IF      
   INITIALIZE l_where4 TO NULL
   IF g_master.l_ck4 = 'Y' THEN
      LET l_count = l_count + 1 
      CALL cl_replace_str(l_tmp,"xxxx003","inbi001") RETURNING l_where4
      CALL cl_replace_str(l_where4,"xxxx004","inbi002") RETURNING l_where4
      CALL cl_replace_str(l_where4,"xxxx","inbi") RETURNING l_where4
#      CALL cl_replace_str(l_where4,"inba002","inbidocdt") RETURNING l_where3     #150601-00042 zhujing add 2016-2-4
      CALL cl_replace_str(l_where4,"inba002","inbi007") RETURNING l_where3       #160325-00007#1 2016-3-25 By zhujing mod
      CALL cl_replace_str(l_where4,"inba","inbi") RETURNING l_where4
      LET l_where4 = l_where4 CLIPPED," AND inbi000 = '2' AND inbisite = '",g_site CLIPPED,"' AND inbient = '",g_enterprise CLIPPED,"' "
      CASE g_master.inbastus
         WHEN '1'
         WHEN '2'
            LET l_where4 = l_where4 CLIPPED," AND inbistus = 'N' "
         WHEN '3'
            LET l_where4 = l_where4 CLIPPED," AND inbistus = 'O' "
         WHEN '4'
            LET l_where4 = l_where4 CLIPPED," AND inbistus = 'S' "
         WHEN '5'
            LET l_where4 = l_where4 CLIPPED," AND inbistus = 'X' "
      END CASE 
      IF cl_null(l_where1) AND cl_null(l_where2) AND cl_null(l_where3) AND NOT cl_null(l_where4) THEN
         LET g_master.wc = g_master.wc CLIPPED, " AND ((",l_where4 CLIPPED," )"
      ELSE
         LET g_master.wc = g_master.wc CLIPPED, " OR (",l_where4 CLIPPED," )"
      END IF
   END IF 
   IF (g_master.l_ck3='N' OR cl_null(g_master.l_ck3)) AND (g_master.l_ck4='N' OR cl_null(g_master.l_ck4)) THEN
      LET l_where3 = "1=2"
      LET l_where4 = "1=2"
   END IF
   LET g_master.wc = g_master.wc CLIPPED, " )"   
   
   CALL ainr305_x01(g_master.wc,l_where1,l_where2,l_where3,l_where4,g_master.inbastus,g_master.l_pr) #4 args

   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE ainr305_process_cs CURSOR FROM ls_sql
#  FOREACH ainr305_process_cs INTO
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
 
{<section id="ainr305.get_buffer" >}
PRIVATE FUNCTION ainr305_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.l_ck1 = p_dialog.getFieldBuffer('l_ck1')
   LET g_master.l_ck3 = p_dialog.getFieldBuffer('l_ck3')
   LET g_master.l_ck2 = p_dialog.getFieldBuffer('l_ck2')
   LET g_master.l_ck4 = p_dialog.getFieldBuffer('l_ck4')
   LET g_master.inbastus = p_dialog.getFieldBuffer('inbastus')
   LET g_master.l_pr = p_dialog.getFieldBuffer('l_pr')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr305.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

#end add-point
 
{</section>}
 
