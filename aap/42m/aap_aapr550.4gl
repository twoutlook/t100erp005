#該程式未解開Section, 採用最新樣板產出!
{<section id="aapr550.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-16 17:50:32), PR版次:0002(2016-10-19 18:43:11)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: aapr550
#+ Description: 外購到貨單
#+ Creator....: 05016(2016-03-15 11:30:49)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aapr550.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161014-00053#2 2016/10/19 By 08171 增加法人權限、交易對象控制組
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
       apglcomp LIKE apgl_t.apglcomp, 
   apglcomp_desc LIKE type_t.chr80, 
   apgl005 LIKE apgl_t.apgl005, 
   apgldocno LIKE apgl_t.apgldocno, 
   apgldocdt LIKE apgl_t.apgldocdt, 
   apgl006 LIKE apgl_t.apgl006, 
   apgl001 LIKE apgl_t.apgl001, 
   apgl002 LIKE apgl_t.apgl002, 
   apgl003 LIKE apgl_t.apgl003, 
   apgl004 LIKE apgl_t.apgl004, 
   apglstus LIKE apgl_t.apglstus,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_cs_comp    STRING    #azzi800的權限可看的資料範圍 #161014-00053#2 add
DEFINE g_sql_ctrl      STRING    #交易對象控制組              #161014-00053#2 add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapr550.main" >}
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
      CALL aapr550_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapr550 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapr550_init()
 
      #進入選單 Menu (="N")
      CALL aapr550_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapr550
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapr550.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapr550_init()
   #add-point:init段define name="init.define"
   DEFINE l_count LIKE type_t.num5
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
   SELECT ooef017 INTO g_master.apglcomp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site

   #kris提示法人控卡若不存在azzi800設定則不可使用
   #此時不需展組織
   #orga才需展組織
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count
     FROM gzxc_t
    WHERE gzxcent  = g_enterprise AND gzxc001 = g_user
      AND gzxcstus = 'Y'
      AND gzxc004  = g_master.apglcomp
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET g_master.apglcomp = ''
   ELSE
      LET g_master.apglcomp_desc = s_desc_get_department_desc(g_master.apglcomp)
   END IF
   DISPLAY BY NAME g_master.apglcomp_desc
   LET g_master.apglstus = '1' 
   
   #161014-00053#2 --s add
   #法人
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   #控制組
   LET g_sql_ctrl = NULL
   CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl
   #161014-00053#2 --e add
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapr550.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapr550_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_count  LIKE type_t.num5
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
         INPUT BY NAME g_master.apglcomp,g_master.apglstus 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apglcomp
            
            #add-point:AFTER FIELD apglcomp name="input.a.apglcomp"
            IF NOT cl_null(g_master.apglcomp) THEN
               CALL aapr550_apglcomp_chk(g_master.apglcomp)RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apglcomp = ''
                  LET g_master.apglcomp_desc = ''
                  DISPLAY BY NAME g_master.apglcomp_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_master.apglcomp) RETURNING g_master.apglcomp_desc
            DISPLAY BY NAME g_master.apglcomp_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apglcomp
            #add-point:BEFORE FIELD apglcomp name="input.b.apglcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apglcomp
            #add-point:ON CHANGE apglcomp name="input.g.apglcomp"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apglstus
            #add-point:BEFORE FIELD apglstus name="input.b.apglstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apglstus
            
            #add-point:AFTER FIELD apglstus name="input.a.apglstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apglstus
            #add-point:ON CHANGE apglstus name="input.g.apglstus"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apglcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apglcomp
            #add-point:ON ACTION controlp INFIELD apglcomp name="input.c.apglcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apglcomp
            #161014-00053#2 --s mark
            #LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN (SELECT gzxc004 FROM gzxc_t ",
            #                       "                                WHERE gzxcent = '",g_enterprise,"' ",
            #                       "                                  AND gzxcstus = 'Y' AND gzxc001 = '",g_user,"' ) "   
            #161014-00053#2 --e mark
            #161014-00053#2 --s add
            LET g_qryparam.where = " ooef003 = 'Y' "
            IF NOT cl_null(g_wc_cs_comp)THEN
               LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",g_wc_cs_comp                   #160824-00049#1 add
            END IF
            #161014-00053#2 --e add
            CALL q_ooef001()
            LET g_master.apglcomp = g_qryparam.return1
            CALL s_desc_get_department_desc(g_master.apglcomp) RETURNING g_master.apglcomp_desc
            DISPLAY BY NAME g_master.apglcomp,g_master.apglcomp_desc
            NEXT FIELD apglcomp
            #END add-point
 
 
         #Ctrlp:input.c.apglstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apglstus
            #add-point:ON ACTION controlp INFIELD apglstus name="input.c.apglstus"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apgl005,apgldocno,apgldocdt,apgl006,apgl001,apgl002,apgl003, 
             apgl004
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl005
            #add-point:BEFORE FIELD apgl005 name="construct.b.apgl005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl005
            
            #add-point:AFTER FIELD apgl005 name="construct.a.apgl005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl005
            #add-point:ON ACTION controlp INFIELD apgl005 name="construct.c.apgl005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_8()
            DISPLAY g_qryparam.return1 TO apgl005
            NEXT FIELD apgl005
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgldocno
            #add-point:BEFORE FIELD apgldocno name="construct.b.apgldocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgldocno
            
            #add-point:AFTER FIELD apgldocno name="construct.a.apgldocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgldocno
            #add-point:ON ACTION controlp INFIELD apgldocno name="construct.c.apgldocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apglcomp = '",g_master.apglcomp,"' "
            CALL q_apgldocno()
            DISPLAY g_qryparam.return1 TO apgldocno      #顯示到畫面上
            NEXT FIELD apgldocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgldocdt
            #add-point:BEFORE FIELD apgldocdt name="construct.b.apgldocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgldocdt
            
            #add-point:AFTER FIELD apgldocdt name="construct.a.apgldocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgldocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgldocdt
            #add-point:ON ACTION controlp INFIELD apgldocdt name="construct.c.apgldocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl006
            #add-point:BEFORE FIELD apgl006 name="construct.b.apgl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl006
            
            #add-point:AFTER FIELD apgl006 name="construct.a.apgl006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl006
            #add-point:ON ACTION controlp INFIELD apgl006 name="construct.c.apgl006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "('1','3')"
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apgl006      #顯示到畫面上
            NEXT FIELD apgl006
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl001
            #add-point:BEFORE FIELD apgl001 name="construct.b.apgl001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl001
            
            #add-point:AFTER FIELD apgl001 name="construct.a.apgl001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl001
            #add-point:ON ACTION controlp INFIELD apgl001 name="construct.c.apgl001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl002
            #add-point:BEFORE FIELD apgl002 name="construct.b.apgl002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl002
            
            #add-point:AFTER FIELD apgl002 name="construct.a.apgl002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl002
            #add-point:ON ACTION controlp INFIELD apgl002 name="construct.c.apgl002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE            
            LET g_qryparam.arg1 = "('1','3')"
            #161014-00053#2 --s add
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            #161014-00053#2 --e add
            CALL q_pmaa001_1()
            DISPLAY g_qryparam.return1 TO apgl002      #顯示到畫面上
            NEXT FIELD apgl002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl003
            #add-point:BEFORE FIELD apgl003 name="construct.b.apgl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl003
            
            #add-point:AFTER FIELD apgl003 name="construct.a.apgl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl003
            #add-point:ON ACTION controlp INFIELD apgl003 name="construct.c.apgl003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apglcomp = '",g_master.apglcomp,"' "
            CALL q_apgl003()
            DISPLAY g_qryparam.return1 TO apgl003
            NEXT FIELD apgl003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl004
            #add-point:BEFORE FIELD apgl004 name="construct.b.apgl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl004
            
            #add-point:AFTER FIELD apgl004 name="construct.a.apgl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl004
            #add-point:ON ACTION controlp INFIELD apgl004 name="construct.c.apgl004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apglcomp = '",g_master.apglcomp,"' "
            CALL q_apgl003()
            DISPLAY g_qryparam.return2 TO apgl004
            NEXT FIELD apgl004
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
            CALL aapr550_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aapr550_get_buffer(l_dialog)
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
            SELECT ooef017 INTO g_master.apglcomp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            
            #kris提示法人控卡若不存在azzi800設定則不可使用
            #此時不需展組織
            #orga才需展組織
            LET l_count = NULL
            SELECT COUNT(*) INTO l_count
              FROM gzxc_t
             WHERE gzxcent  = g_enterprise AND gzxc001 = g_user
               AND gzxcstus = 'Y'
               AND gzxc004  = g_master.apglcomp
            IF cl_null(l_count)THEN LET l_count = 0 END IF
            IF l_count = 0 THEN
               LET g_master.apglcomp = ''
            ELSE
               LET g_master.apglcomp_desc = s_desc_get_department_desc(g_master.apglcomp)
            END IF
            DISPLAY BY NAME g_master.apglcomp_desc
            LET g_master.apglstus = '1' 
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
         CALL aapr550_init()
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
                 CALL aapr550_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapr550_transfer_argv(ls_js)
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
 
{<section id="aapr550.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapr550_transfer_argv(ls_js)
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
 
{<section id="aapr550.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapr550_process(ls_js)
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
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"apgl005,apgldocno,apgldocdt,apgl006,apgl001,apgl002,apgl003,apgl004")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
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
      LET g_master.wc = g_master.wc CLIPPED, " AND apglcomp = '",g_master.apglcomp,"' AND apglent  ='",g_enterprise,"' "
      #單據狀態   
      CASE g_master.apglstus
         WHEN 1  #已確認
            LET g_master.wc = g_master.wc CLIPPED, " AND apglstus = 'Y' "
         WHEN 2  #未確認
            LET g_master.wc = g_master.wc CLIPPED, " AND apglstus = 'N' "
      END CASE
   END IF
   CALL aapr550_g01(g_master.wc)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapr550_process_cs CURSOR FROM ls_sql
#  FOREACH aapr550_process_cs INTO
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
 
{<section id="aapr550.get_buffer" >}
PRIVATE FUNCTION aapr550_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.apglcomp = p_dialog.getFieldBuffer('apglcomp')
   LET g_master.apglstus = p_dialog.getFieldBuffer('apglstus')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapr550.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 法人檢核
# Memo...........:
# Usage..........: CALL aapr550_apglcomp_chk(p_apglcomp)
# Date & Author..: 2016/03/12 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapr550_apglcomp_chk(p_apglcomp)
DEFINE p_apglcomp   LIKE apgl_t.apglcomp
DEFINE r_success    LIKE type_t.num5
DEFINE r_errno      LIKE gzze_t.gzze001
DEFINE l_ooef       RECORD
                    ooef003   LIKE ooef_t.ooef003,
                    ooefstus  LIKE ooef_t.ooefstus
                    END RECORD
DEFINE l_count      LIKE type_t.num10
DEFINE l_sql        STRING #161014-00053#2 add


   LET r_success = TRUE
   LET r_errno   = ''

   INITIALIZE l_ooef.* TO NULL
   SELECT ooef003,ooefstus
     INTO l_ooef.*
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_apglcomp

   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooefstus <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'wss-00231'
      WHEN l_ooef.ooef003  <> 'Y'
         LET r_success = FALSE
         LET r_errno   = 'aap-00011'
   END CASE
   IF NOT r_success THEN RETURN r_success,r_errno END IF
   #161014-00053#2 --s mark
   #USER azzi800權限
   #kris提示法人控卡若不存在azzi800設定則不可使用
   #此時不需展組織
   #orga才需展組織
   #LET l_count = NULL
   #SELECT COUNT(*) INTO l_count
   #  FROM gzxc_t
   # WHERE gzxcent  = g_enterprise AND gzxc001 = g_user
   #   AND gzxcstus = 'Y'
   #   AND gzxc004  = p_apglcomp
   #IF cl_null(l_count)THEN LET l_count = 0 END IF
   #
   #IF l_count = 0 THEN
   #   LET r_success = FALSE
   #   LET r_errno   = 'ais-00228'
   #END IF
   #161014-00053#2 --e mark
   #161014-00053#2 --s add
   LET l_count = NULL
   LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = ",g_enterprise," ",
               "   AND ooef001 = '",p_apglcomp,"' ",
               "   AND ooef001 IN ",g_wc_cs_comp CLIPPED
   PREPARE sel_ooefp11 FROM l_sql
   EXECUTE sel_ooefp11 INTO l_count
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   IF l_count = 0 THEN
      LET r_success = FALSE
      LET r_errno   = 'ais-00228'
   END IF
   #161014-00053#2 --e add

   RETURN r_success,r_errno

   

END FUNCTION

#end add-point
 
{</section>}
 
