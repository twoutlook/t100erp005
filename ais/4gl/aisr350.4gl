#該程式未解開Section, 採用最新樣板產出!
{<section id="aisr350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2015-03-13 11:46:06), PR版次:0007(2016-12-16 11:34:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000127
#+ Filename...: aisr350
#+ Description: 業務往來對帳單列印
#+ Creator....: 04152(2015-01-15 16:39:42)
#+ Modifier...: 04152 -SD/PR- 04152
 
{</section>}
 
{<section id="aisr350.global" >}
#應用 r01 樣板自動產生(Version:21)
#add-point:填寫註解說明 name="global.memo"
#150311-00016#1  2015/03/13 By Reanna    QBE條件增加狀態碼
#151231-00010#3  2016/01/21 By albireo   增加控制組判斷
#160920-00019#5  2016/09/20 By 08732     交易對象開窗調整為q_pmaa001_13
#161006-00005#28 2016/10/26 By Reanna    帳務中心(isafsite)開窗改用q_ooef001_46()
#161216-00009#1  2016/12/16 By Reanna    aisr350的QBE單號開窗增加INPUT帳務中心條件
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
       isafsite LIKE isaf_t.isafsite, 
   l_isafsite_desc LIKE type_t.chr80, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isafdocdt_2 LIKE type_t.dat, 
   isafcomp LIKE isaf_t.isafcomp, 
   isaf003 LIKE isaf_t.isaf003, 
   isaf001 LIKE isaf_t.isaf001, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafstus LIKE isaf_t.isafstus,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_wc_isafcomp         STRING                        #帳務中心條件
#151231-00010#3-----s
DEFINE g_ctl_where          STRING    #交易對象控制組WHERE CON
#151231-00010#3-----e
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisr350.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_comp   LIKE ooef_t.ooef001   #151231-00010#3
   #end add-point 
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
 
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where   
   #151231-00010#3-----e 
   #end add-point   
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
      CALL util.JSON.parse(ls_js,g_master)      #r類背景參數解析入口
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aisr350_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisr350 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisr350_init()
 
      #進入選單 Menu (="N")
      CALL aisr350_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisr350
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisr350.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisr350_init()
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
   CALL cl_set_combo_scc('isaf001','9715')              #異動狀態
   CALL cl_set_combo_scc_part('isafstus','13','N,Y,S')  #150311-00016#1
   CALL s_fin_create_account_center_tmp()
   CALL aisr350_qbe_clear()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisr350.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisr350_ui_dialog()
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp   LIKE ooef_t.ooef001
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
         INPUT BY NAME g_master.isafsite,g_master.isafdocdt,g_master.isafdocdt_2 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
 
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafsite
            
            #add-point:AFTER FIELD isafsite name="input.a.isafsite"
            IF NOT cl_null(g_master.isafsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.isafsite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #抓取法人有哪些
               CALL s_fin_account_center_sons_query('3',g_master.isafsite,g_today,'')
               CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
               CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
               CALL s_desc_get_department_desc(g_master.isafsite) RETURNING g_master.l_isafsite_desc
               DISPLAY BY NAME g_master.l_isafsite_desc
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafsite
            #add-point:BEFORE FIELD isafsite name="input.b.isafsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafsite
            #add-point:ON CHANGE isafsite name="input.g.isafsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocdt
            #add-point:BEFORE FIELD isafdocdt name="input.b.isafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocdt
            
            #add-point:AFTER FIELD isafdocdt name="input.a.isafdocdt"
            IF NOT cl_null(g_master.isafdocdt) AND NOT cl_null(g_master.isafdocdt_2) THEN
               IF g_master.isafdocdt > g_master.isafdocdt_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafdocdt
            #add-point:ON CHANGE isafdocdt name="input.g.isafdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocdt_2
            #add-point:BEFORE FIELD isafdocdt_2 name="input.b.isafdocdt_2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocdt_2
            
            #add-point:AFTER FIELD isafdocdt_2 name="input.a.isafdocdt_2"
            IF NOT cl_null(g_master.isafdocdt) AND NOT cl_null(g_master.isafdocdt_2) THEN
               IF g_master.isafdocdt > g_master.isafdocdt_2 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00081"
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isafdocdt_2
            #add-point:ON CHANGE isafdocdt_2 name="input.g.isafdocdt_2"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.isafsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafsite
            #add-point:ON ACTION controlp INFIELD isafsite name="input.c.isafsite"
            #帳務中心
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.isafsite
            #CALL q_ooef001()      #161006-00005#28 mark
            CALL q_ooef001_46()    #161006-00005#28
            LET g_master.isafsite = g_qryparam.return1
            DISPLAY g_master.isafsite TO isafsite
            NEXT FIELD isafsite
            #END add-point
 
 
         #Ctrlp:input.c.isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocdt
            #add-point:ON ACTION controlp INFIELD isafdocdt name="input.c.isafdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.isafdocdt_2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocdt_2
            #add-point:ON ACTION controlp INFIELD isafdocdt_2 name="input.c.isafdocdt_2"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON isafcomp,isaf003,isaf001,isafdocno,isafstus
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.isafcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafcomp
            #add-point:ON ACTION controlp INFIELD isafcomp name="construct.c.isafcomp"
            #開窗c段
            #法人
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "ooef003 = 'Y' AND ooef001 IN ",g_wc_isafcomp CLIPPED
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO isafcomp
            NEXT FIELD isafcomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafcomp
            #add-point:BEFORE FIELD isafcomp name="construct.b.isafcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafcomp
            
            #add-point:AFTER FIELD isafcomp name="construct.a.isafcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf003
            #add-point:ON ACTION controlp INFIELD isaf003 name="construct.c.isaf003"
            #開窗c段
            #客戶編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#3-----s
            LET l_comp = NULL
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            LET g_qryparam.where = g_ctl_where," AND EXISTS (SELECT 1 FROM pmab_t ",
                                                     " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                     "   AND pmabsite = '",l_comp,"' )"
            #151231-00010#3-----e                         
            #CALL q_pmaa001()  #呼叫開窗   #160920-00019#5--mark   
            CALL q_pmaa001_13()           #160920-00019#5--add
            DISPLAY g_qryparam.return1 TO isaf003
            NEXT FIELD isaf003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf003
            #add-point:BEFORE FIELD isaf003 name="construct.b.isaf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf003
            
            #add-point:AFTER FIELD isaf003 name="construct.a.isaf003"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaf001
            #add-point:BEFORE FIELD isaf001 name="construct.b.isaf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaf001
            
            #add-point:AFTER FIELD isaf001 name="construct.a.isaf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isaf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaf001
            #add-point:ON ACTION controlp INFIELD isaf001 name="construct.c.isaf001"
            
            #END add-point
 
 
         #Ctrlp:construct.c.isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafdocno
            #add-point:ON ACTION controlp INFIELD isafdocno name="construct.c.isafdocno"
            #開窗c段
            #對帳單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #150306 add isafsite
            #LET g_qryparam.where = " isafsite IN ",g_wc_isafcomp,"AND isafdocdt BETWEEN '",g_master.isafdocdt,"' AND '",g_master.isafdocdt_2,"' AND isafstus='Y'"      #161216-00009#1 mark
            LET g_qryparam.where = " isafsite = '",g_master.isafsite,"' AND isafdocdt BETWEEN '",g_master.isafdocdt,"' AND '",g_master.isafdocdt_2,"' AND isafstus='Y'" #161216-00009#1 add
            CALL q_isafdocno()
            DISPLAY g_qryparam.return1 TO isafdocno
            NEXT FIELD isafdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafdocno
            #add-point:BEFORE FIELD isafdocno name="construct.b.isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafdocno
            
            #add-point:AFTER FIELD isafdocno name="construct.a.isafdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isafstus
            #add-point:BEFORE FIELD isafstus name="construct.b.isafstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isafstus
            
            #add-point:AFTER FIELD isafstus name="construct.a.isafstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.isafstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isafstus
            #add-point:ON ACTION controlp INFIELD isafstus name="construct.c.isafstus"
            
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
            CALL aisr350_get_buffer(l_dialog)
 
         ON ACTION qbe_select
            LET ls_wc = ""
            #需要用ITM類程式查詢方案在CONSTRUCT的功能，將值set到畫面上
            CALL cl_qbe_list("c") RETURNING ls_wc
            CALL aisr350_get_buffer(l_dialog)
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
            CALL aisr350_qbe_clear()
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
         CALL aisr350_init()
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
                 CALL aisr350_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisr350_transfer_argv(ls_js)
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
 
{<section id="aisr350.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisr350_transfer_argv(ls_js)
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
 
{<section id="aisr350.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisr350_process(ls_js)
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
   DEFINE l_comp        LIKE ooef_t.ooef001
   #end add-point
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
 
   INITIALIZE lc_param TO NULL
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_r01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   LET g_rep_wcchp = cl_wcchp(g_master.wc,"isafcomp,isaf003,isaf001,isafdocno,isafstus")  #取得列印條件
  
   #add-point:process段前處理 name="process.pre_process"
   IF cl_null(g_master.wc) THEN
      LET g_master.wc = "1=1"
   END IF
   
   #150311-00016#1 add ------
   #列印未確認單據
   CASE g_master.isafstus
      WHEN 'Y'  #已確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apdastus = 'Y' "
      WHEN 'N'  #未確認
         LET g_master.wc = g_master.wc CLIPPED, " AND apdastus = 'N' "
      WHEN 'S'  #已過帳
         LET g_master.wc = g_master.wc CLIPPED, " AND apdastus = 'S' "
   END CASE
   #150311-00016#1 add end---

   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
                                            
   LET g_master.wc = g_master.wc CLIPPED," AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t ",
                                            " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                            "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                            "   AND pmabsite = '",l_comp,"' ",
                                            "   AND pmaaent = isafent AND pmaa001 = isaf003)"                                            
   #151231-00010#3-----e
   
   #列印報表aisr350(tm.wc,帳務中心底下的所有法人,帳款日期起,帳款日期迄)
   CALL aisr350_g01(g_master.wc,g_wc_isafcomp,g_master.isafdocdt,g_master.isafdocdt_2)
   #end add-point
 
   #預先計算progressbar迴圈次數   #r類不用計算進度條
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisr350_process_cs CURSOR FROM ls_sql
#  FOREACH aisr350_process_cs INTO
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
 
{<section id="aisr350.get_buffer" >}
PRIVATE FUNCTION aisr350_get_buffer(p_dialog)
   DEFINE p_dialog   ui.DIALOG
   
   LET g_master.isafsite = p_dialog.getFieldBuffer('isafsite')
   LET g_master.isafdocdt = p_dialog.getFieldBuffer('isafdocdt')
   LET g_master.isafdocdt_2 = p_dialog.getFieldBuffer('isafdocdt_2')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisr350.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL aisr350_qbe_clear()

# Date & Author..: 2015/02/09 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aisr350_qbe_clear()
   
   #預設帳務中心
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_master.isafsite,g_errno
   CALL s_desc_get_department_desc(g_master.isafsite) RETURNING g_master.l_isafsite_desc
   CALL s_fin_account_center_sons_query('3',g_master.isafsite,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_isafcomp
   CALL s_fin_get_wc_str(g_wc_isafcomp) RETURNING g_wc_isafcomp
   
   #預設日期取月份的第一天
   LET g_master.isafdocdt = s_date_get_first_date(g_today)
   LET g_master.isafdocdt_2 = s_date_get_last_date(g_today)
   
   DISPLAY BY NAME g_master.l_isafsite_desc,g_master.isafdocdt,g_master.isafdocdt_2
   
END FUNCTION

#end add-point
 
{</section>}
 
