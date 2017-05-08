#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr430.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(2016-05-04 15:41:45), PR版次:0005(2016-10-24 11:10:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000084
#+ Filename...: aapr430
#+ Description: 費用分攤表列印作業
#+ Creator....: 04152(2015-02-05 11:18:20)
#+ Modifier...: 04152 -SD/PR- 06137
 
{</section>}
 
{<section id="aapr430.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#150610-00025#1   150622 By Jessy  單據作業中的”呼叫報表元件(call function)”改為”執行報表作業(cmd run)
#160812-00027#4   160818 By 06821  全面盤點應付程式帳套權限控管
#161014-00053#1   161020 By 08171  帳套權限控管調整
#161006-00005#21  161024 By 06137  組織類型與職能開窗清單需測試及調整開窗內容
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
       apdasite LIKE apda_t.apdasite, 
   l_apdasite_desc LIKE type_t.chr80, 
   apda001 LIKE apda_t.apda001, 
   apdald LIKE apda_t.apdald, 
   l_apdald_desc LIKE type_t.chr80, 
   apdadocno LIKE apda_t.apdadocno, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apda003 LIKE apda_t.apda003, 
   apda014 LIKE apda_t.apda014, 
   l_chk1 LIKE type_t.chr500, 
   l_chk2 LIKE type_t.chr500,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_apdald           STRING     #帳套
DEFINE g_wc_apdasite         STRING     #帳務中心條件
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapr430.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aapr430_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapr430 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapr430_init()
 
      #進入選單 Menu (="N")
      CALL aapr430_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapr430
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapr430.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapr430_init()
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
   CALL cl_set_combo_scc("apda001","8507")
   CALL s_fin_create_account_center_tmp()
   CALL aapr430_qbe_clear()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapr430.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr430_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp      LIKE apda_t.apdacomp
   DEFINE l_comp_wc  STRING #161014-00053#1
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
         INPUT BY NAME g_master.apdasite,g_master.apdald,g_master.l_chk1,g_master.l_chk2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            IF NOT cl_null(g_master.apdasite) THEN
               CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'')
               IF NOT cl_null(g_master.apdald) THEN
                  CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     #勾稽失敗:目前的帳套不在這個帳務中心下 因此預設值給帳務中心的主帳套
                     CALL s_fin_orga_get_comp_ld(g_master.apdasite) RETURNING g_sub_success,g_errno,l_comp,g_master.apdald
                     #判斷這個主帳套使用者是否有權限
                     CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  END IF
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apdasite = ''
                     LET g_master.l_apdasite_desc = ''
                     LET g_master.apdald = ''
                     LET g_master.l_apdald_desc = ''
                     DISPLAY BY NAME g_master.apdasite ,g_master.l_apdasite_desc,
                                     g_master.apdald,g_master.l_apdald_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            #重抓該帳務中心底下可用的帳套
            CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
            CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
            #重抓該帳務中心底下可用的組織
            CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
            CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
            
            CALL s_desc_get_department_desc(g_master.apdasite) RETURNING g_master.l_apdasite_desc
            CALL s_desc_get_ld_desc(g_master.apdald)  RETURNING g_master.l_apdald_desc
            DISPLAY BY NAME g_master.l_apdasite_desc,g_master.l_apdald_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdasite
            #add-point:BEFORE FIELD apdasite name="input.b.apdasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdasite
            #add-point:ON CHANGE apdasite name="input.g.apdasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdald
            
            #add-point:AFTER FIELD apdald name="input.a.apdald"
            IF NOT cl_null(g_master.apdald) THEN
               #CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N',g_wc_apdald,g_today) RETURNING g_sub_success,g_errno #160812-00027#4 mark
               CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','Y',g_wc_apdald,g_today) RETURNING g_sub_success,g_errno  #160812-00027#4 add
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apdald = ''
                  LET g_master.l_apdald_desc = ''
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_ld_desc(g_master.apdald) RETURNING g_master.l_apdald_desc
               DISPLAY BY NAME g_master.l_apdald_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdald
            #add-point:BEFORE FIELD apdald name="input.b.apdald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdald
            #add-point:ON CHANGE apdald name="input.g.apdald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk1
            #add-point:BEFORE FIELD l_chk1 name="input.b.l_chk1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk1
            
            #add-point:AFTER FIELD l_chk1 name="input.a.l_chk1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk1
            #add-point:ON CHANGE l_chk1 name="input.g.l_chk1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_chk2
            #add-point:BEFORE FIELD l_chk2 name="input.b.l_chk2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_chk2
            
            #add-point:AFTER FIELD l_chk2 name="input.a.l_chk2"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_chk2
            #add-point:ON CHANGE l_chk2 name="input.g.l_chk2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"
            #開窗i段-帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdasite
            #CALL q_ooef001()      #161006-00005#21 Mark By Ken 161024
            CALL q_ooef001_46()    #161006-00005#21 Add By Ken 161024 
            LET g_master.apdasite = g_qryparam.return1
            DISPLAY g_master.apdasite TO apdasite
            NEXT FIELD apdasite
            #END add-point
 
 
         #Ctrlp:input.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            #開窗i段-帳別
            #161014-00053#1 --s add
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapr430_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            #161014-00053#1 --e add
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdald
            LET g_qryparam.arg1 = g_user    #人員權限
            LET g_qryparam.arg2 = g_dept    #部門權限
            #LET g_qryparam.where = " glaald IN ",g_wc_apdald                                      #160812-00027#4 mark
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apdald  #160812-00027#4 add #161014-00053#1 mark
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,"" #161014-00053#1 add
            CALL q_authorised_ld()
            LET g_master.apdald = g_qryparam.return1
            DISPLAY g_master.apdald TO apdald
            NEXT FIELD apdald
            #END add-point
 
 
         #Ctrlp:input.c.l_chk1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk1
            #add-point:ON ACTION controlp INFIELD l_chk1 name="input.c.l_chk1"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_chk2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_chk2
            #add-point:ON ACTION controlp INFIELD l_chk2 name="input.c.l_chk2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apdadocno,apdadocdt,apda003,apda014
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="construct.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="construct.a.apdadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="construct.c.apdadocno"
            #開窗C段-單據編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apda001 = '43' AND apdastus IN ('Y','N','X') ",
                                   " AND apdasite IN ",g_wc_apdasite,
                                   " AND apdald = '",g_master.apdald,"'"
            CALL q_apdadocno_1()
            DISPLAY g_qryparam.return1 TO apdadocno
            NEXT FIELD apdadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="construct.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="construct.a.apdadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="construct.c.apdadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="construct.b.apda003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="construct.a.apda003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="construct.c.apda003"
            #開窗C段-帳務人員
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apda003
            NEXT FIELD apda003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda014
            #add-point:BEFORE FIELD apda014 name="construct.b.apda014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda014
            
            #add-point:AFTER FIELD apda014 name="construct.a.apda014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apda014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda014
            #add-point:ON ACTION controlp INFIELD apda014 name="construct.c.apda014"
            #開窗C段-傳票編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apda001 = '43' AND apdastus IN ('Y','N','X') ",
                                   " AND apdasite IN ",g_wc_apdasite,
                                   " AND apdald = '",g_master.apdald,"'"
            CALL q_apda014_2()
            DISPLAY g_qryparam.return1 TO apda014
            NEXT FIELD apda014
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
            CALL aapr430_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aapr430_get_buffer(l_dialog)
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
            INITIALIZE g_master.* TO NULL
            CALL aapr430_qbe_clear()
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
         CALL aapr430_init()
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
                 CALL aapr430_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapr430_transfer_argv(ls_js)
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
 
{<section id="aapr430.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapr430_transfer_argv(ls_js)
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
 
{<section id="aapr430.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapr430_process(ls_js)
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
   DEFINE l_sql       STRING
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"apdadocno,apdadocdt,apda003,apda014")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   #150610-00025#1-----s
   IF cl_null(g_master.wc) THEN  ## 若是t類進來 會是傳字串參數的方式
       CALL l_arg.clear()
       LET l_token = base.StringTokenizer.create(ls_js,",")
       LET l_cnt = 1
       WHILE l_token.hasMoreTokens()
             LET ls_next = l_token.nextToken()
             LET l_arg[l_cnt] = ls_next
             LET l_cnt = l_cnt + 1
       END WHILE
       CALL l_arg.deleteElement(l_cnt)
       LET g_master.wc = l_arg[01]
   ELSE
   
#   IF cl_null(g_master.wc) THEN
#      LET g_master.wc =" 1=1"
#   END IF

   #150610-00025#1-----e

   #帳務中心,帳套,帳款單性質
   LET g_master.wc = g_master.wc CLIPPED, " AND apdaent  = ",g_enterprise," AND apdasite IN ",g_wc_apdasite,
                                          " AND apdald = '",g_master.apdald,"' AND apda001 = '",g_master.apda001,"' "
   #已列印者重新列印
   CASE g_master.l_chk1
      WHEN 1 #未列印
         LET g_master.wc = g_master.wc CLIPPED, " AND (apda016 = 0 OR apda016 IS NULL) "
      WHEN 2 #已列印
         LET g_master.wc = g_master.wc CLIPPED, " AND apda016 <> 0 "
   END CASE
   
   #列印未確認單據
   CASE g_master.l_chk2
      WHEN 1  #已確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apdastus = 'Y' "
      WHEN 2  #未確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apdastus = 'N'"
   END CASE
   
   END IF #150610-00025#1
   #列印報表aapr430
   CALL aapr430_g01(g_master.wc)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      ##列印成功更新列印次數
      #LET l_sql = "UPDATE apda_t SET apda016 = COALESCE(apda016,0) + 1",
      #            " WHERE " ,g_master.wc CLIPPED 
      #PREPARE aapr430_pr FROM l_sql
      #EXECUTE aapr430_pr
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapr430_process_cs CURSOR FROM ls_sql
#  FOREACH aapr430_process_cs INTO
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
 
{<section id="aapr430.get_buffer" >}
PRIVATE FUNCTION aapr430_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.apdasite = p_dialog.getFieldBuffer('apdasite')
   LET g_master.apdald = p_dialog.getFieldBuffer('apdald')
   LET g_master.l_chk1 = p_dialog.getFieldBuffer('l_chk1')
   LET g_master.l_chk2 = p_dialog.getFieldBuffer('l_chk2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr430.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aapr430_qbe_clear()

# Date & Author..: 2015/02/09 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr430_qbe_clear()
DEFINE l_comp      LIKE apda_t.apdacomp
   
   LET g_master.apda001 = '43'
   LET g_master.l_chk1 = '1' #預設未列印
   LET g_master.l_chk2 = '1' #預設已確認
   
   #預設帳務中心
   CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_master.apdasite,g_master.apdald,l_comp
   CALL s_desc_get_department_desc(g_master.apdasite) RETURNING g_master.l_apdasite_desc
   CALL s_desc_get_ld_desc(g_master.apdald)  RETURNING g_master.l_apdald_desc

   CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
   CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apdasite
   CALL s_fin_get_wc_str(g_wc_apdasite) RETURNING g_wc_apdasite
   
   DISPLAY BY NAME g_master.apda001,g_master.l_apdasite_desc,g_master.l_apdald_desc
   
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: #161014-00053#1
# Usage..........: CALL aapr430_get_ooef001_wc(p_wc)
#                  RETURNING 回传参数
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 161018 By 08171
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr430_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

#end add-point
 
{</section>}
 
