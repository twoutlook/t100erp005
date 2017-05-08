#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2017-01-17 09:32:03), PR版次:0001(2017-02-07 15:11:33)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aapp510
#+ Description: 外購費用分攤批次產生
#+ Creator....: 05016(2017-01-17 09:32:03)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="aapp510.global" >}
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
       apdasite   LIKE apda_t.apdasite, 
       apdald     LIKE apda_t.apdald,
       apdadocno  LIKE apda_t.apdadocno,
       apdadocdt  LIKE apda_t.apdadocdt,
       apda003    LIKE apda_t.apda003,
       apda018    LIKE apda_t.apda018,
       apda019    LIKE apda_t.apda019,
       apda021    LIKE apda_t.apda021,   
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
   apdasite_desc LIKE type_t.chr80, 
   apdald LIKE apda_t.apdald, 
   apdald_desc LIKE type_t.chr80, 
   apdadocno LIKE apda_t.apdadocno, 
   apdadocdt LIKE apda_t.apdadocdt, 
   apda019 LIKE apda_t.apda019, 
   apda020 LIKE apda_t.apda020, 
   apda003 LIKE apda_t.apda003, 
   apda003_desc LIKE type_t.chr80, 
   apda018 LIKE apda_t.apda018, 
   apda018_desc LIKE type_t.chr80, 
   apda021 LIKE apda_t.apda021, 
   apgl004 LIKE apgl_t.apgl004, 
   apgl003 LIKE apgl_t.apgl003, 
   apgl029 LIKE apgl_t.apgl029, 
   apgldocdt LIKE apgl_t.apgldocdt, 
   l_sdocno LIKE type_t.chr500, 
   l_edocno LIKE type_t.chr500, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_apdacomp  LIKE apda_t.apdacomp
DEFINE g_sql_ctrl  STRING
DEFINE g_wc_apdald STRING
DEFINE g_comp_str  STRING
DEFINE g_user_slip_wc STRING
DEFINE g_glaa004       LIKE glaa_t.glaa004  
DEFINE g_glaa005       LIKE glaa_t.glaa005
DEFINE g_glaa014       LIKE glaa_t.glaa014
DEFINE g_glaa024       LIKE glaa_t.glaa024
DEFINE g_glaa121       LIKE glaa_t.glaa121
DEFINE g_sfin3007      LIKE apda_t.apdadocdt  #關帳日期
DEFINE g_scc8502       STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp510.main" >}
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
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
      CALL aapp510_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp510 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp510_init()
 
      #進入選單 Menu (="N")
      CALL aapp510_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp510
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp510.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp510_init()
 
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
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_continue_no_tmp()      
   CALL cl_set_combo_scc('apda019','8513')
   CALL cl_set_combo_scc('apda020','8514')
   CALL cl_set_combo_scc('apda021','8901')   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #寫入暫存檔
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #啟用分錄底稿用
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp510.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp510_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_comp_wc STRING
   DEFINE l_glaa024 LIKE glaa_t.glaa024
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apdasite,g_master.apdald,g_master.apdadocno,g_master.apdadocdt,g_master.apda019, 
             g_master.apda020,g_master.apda003,g_master.apda018,g_master.apda021 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               LET g_master.apda003 = g_user        #帳務人員
               LET g_master.apdadocdt = g_today     #帳款日期
               LET g_master.apda019 = '1'
               LET g_master.apda020 = '1'
               LET g_master.apda021 = '1'
               CALL s_desc_get_person_desc(g_master.apda003) RETURNING g_master.apda003_desc
               #新版取帳務中心
               CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_master.apdasite,g_master.apdald,g_apdacomp
               CALL s_desc_get_department_desc(g_master.apdasite) RETURNING g_master.apdasite_desc
               CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str  
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               IF NOT cl_null(g_master.apdald) THEN
                  CALL s_desc_get_ld_desc(g_master.apdald)  RETURNING g_master.apdald_desc
               END IF
               
               DISPLAY BY NAME g_master.apdasite_desc,g_master.apdald_desc,g_master.apda003_desc,
                               g_master.apdasite,g_master.apdald
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdasite
            
            #add-point:AFTER FIELD apdasite name="input.a.apdasite"
            LET g_master.apdasite_desc = ' '
            DISPLAY BY NAME g_master.apdasite_desc
            IF NOT cl_null(g_master.apdasite) THEN  
               CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_master.apdadocdt,'1')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
               CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','N',g_wc_apdald,g_master.apdadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apdasite = '' 
                  LET g_master.apdald   = ''
                  CALL s_desc_get_department_desc(g_master.apdasite) RETURNING g_master.apdasite_desc
                  DISPLAY BY NAME g_master.apdasite_desc
                  NEXT FIELD CURRENT
               END IF
               CALL s_desc_get_ld_desc(g_master.apdald) RETURNING g_master.apdald_desc
               DISPLAY BY NAME g_master.apdald_desc              
            END IF
            CALL s_fin_orga_get_comp_ld(g_master.apdasite) RETURNING g_sub_success,g_errno,g_apdacomp,g_master.apdald
            CALL s_ld_sel_glaa(g_master.apdald,'glaa004|glaa005|glaa024|glaa121') RETURNING g_sub_success,g_glaa004,g_glaa005,g_glaa024,g_glaa121            
            LET g_master.apdald_desc = s_desc_get_ld_desc(g_master.apdald)
            LET g_master.apdasite_desc = s_desc_get_department_desc(g_master.apdasite)
            DISPLAY BY NAME g_master.apdasite_desc,g_master.apdald_desc
            CALL s_fin_account_center_sons_query('3',g_master.apdasite,g_today,'1')  #依據正確的資料再重展一次結構
            #取得帳務中心底下的帳套範圍 
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apdald
            CALL s_fin_get_wc_str(g_wc_apdald) RETURNING g_wc_apdald

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
            LET g_master.apdald_desc = ' '
            DISPLAY BY NAME g_master.apdald_desc
            IF NOT cl_null(g_master.apdald) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.apdasite,g_master.apdald,g_user,'3','Y',g_wc_apdald,g_master.apdadocdt)
                   RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apdald = ''     
                     LET g_master.apdald_desc = s_desc_get_ld_desc(g_master.apdald)
                     DISPLAY BY NAME g_master.apdald,g_master.apdald_desc
                     NEXT FIELD CURRENT
                  END IF                                    
                  SELECT glaacomp INTO g_apdacomp FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaald = g_master.apdald
                  CALL aapp510_apdadocdt_chk(g_apdacomp,g_master.apdadocdt)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.apdald = ''
                     LET g_master.apdald_desc = s_desc_get_ld_desc(g_master.apdald)
                     DISPLAY BY NAME g_master.apdald,g_master.apdald_desc
                  END IF
            ELSE
               LET g_master.apdald_desc = ''
            END IF
            LET g_master.apdald_desc = s_desc_get_ld_desc(g_master.apdald)
            DISPLAY BY NAME g_master.apdald,g_master.apdald_desc
            CALL s_ld_sel_glaa(g_master.apdald,'glaa004|glaa005|glaa024|glaa121') RETURNING g_sub_success,g_glaa004,g_glaa005,g_glaa024,g_glaa121
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
         BEFORE FIELD apdadocno
            #add-point:BEFORE FIELD apdadocno name="input.b.apdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocno
            
            #add-point:AFTER FIELD apdadocno name="input.a.apdadocno"
            #檢查是否有重複的單據編號(企業代碼/帳別/單號)
            IF NOT cl_null(g_master.apdadocno) THEN 
               #檢查單別是否存在單別檔/單別是有效
               LET g_errno = NULL
               IF NOT s_aooi200_fin_chk_docno(g_master.apdald,'','',g_master.apdadocno,g_master.apdadocdt,'aapt430') THEN
                  LET g_master.apdadocno = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocno
            #add-point:ON CHANGE apdadocno name="input.g.apdadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdadocdt
            #add-point:BEFORE FIELD apdadocdt name="input.b.apdadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdadocdt
            
            #add-point:AFTER FIELD apdadocdt name="input.a.apdadocdt"
            IF NOT cl_null(g_master.apdadocdt) THEN 
               CALL aapp510_apdadocdt_chk(g_apdacomp,g_master.apdadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  #小於應付關帳日
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ""
                  LET g_errparam.code   = g_errno
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
                  LET g_master.apdadocdt = g_today
                  NEXT FIELD CURRENT
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdadocdt
            #add-point:ON CHANGE apdadocdt name="input.g.apdadocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda019
            #add-point:BEFORE FIELD apda019 name="input.b.apda019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda019
            
            #add-point:AFTER FIELD apda019 name="input.a.apda019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda019
            #add-point:ON CHANGE apda019 name="input.g.apda019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda020
            #add-point:BEFORE FIELD apda020 name="input.b.apda020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda020
            
            #add-point:AFTER FIELD apda020 name="input.a.apda020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda020
            #add-point:ON CHANGE apda020 name="input.g.apda020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda003
            
            #add-point:AFTER FIELD apda003 name="input.a.apda003"
            LET g_master.apda003_desc = ' '
            IF NOT cl_null(g_master.apda003) THEN
               LET g_errno = ''
               CALL s_employee_chk(g_master.apda003) RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_master.apda003 = ''
                  CALL s_desc_get_person_desc(g_master.apda003) RETURNING g_master.apda003_desc
                  DISPLAY BY NAME g_master.apda003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_master.apda003) RETURNING g_master.apda003_desc
            DISPLAY BY NAME g_master.apda003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda003
            #add-point:BEFORE FIELD apda003 name="input.b.apda003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda003
            #add-point:ON CHANGE apda003 name="input.g.apda003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda018
            
            #add-point:AFTER FIELD apda018 name="input.a.apda018"
            LET g_master.apda018_desc = ' '
            DISPLAY BY NAME g_master.apda018_desc
            IF NOT cl_null(g_master.apda018) THEN
               CALL s_azzi650_chk_exist('3113',g_master.apda018)RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  LET g_master.apda018 = ''
                  LET g_master.apda018_desc = s_desc_get_acc_desc('3113',g_master.apda018)
                  DISPLAY BY NAME g_master.apda018_desc,g_master.apda018
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master.apda018_desc = s_desc_get_acc_desc('3113',g_master.apda018)
            DISPLAY BY NAME g_master.apda018_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda018
            #add-point:BEFORE FIELD apda018 name="input.b.apda018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda018
            #add-point:ON CHANGE apda018 name="input.g.apda018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apda021
            #add-point:BEFORE FIELD apda021 name="input.b.apda021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apda021
            
            #add-point:AFTER FIELD apda021 name="input.a.apda021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apda021
            #add-point:ON CHANGE apda021 name="input.g.apda021"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdasite
            #add-point:ON ACTION controlp INFIELD apdasite name="input.c.apdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdasite
            CALL q_ooef001_46()   
            LET g_master.apdasite = g_qryparam.return1
            LET g_master.apdasite_desc = s_desc_get_department_desc(g_master.apdasite)
            DISPLAY BY NAME g_master.apdasite_desc
            NEXT FIELD apdasite



            #END add-point
 
 
         #Ctrlp:input.c.apdald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdald
            #add-point:ON ACTION controlp INFIELD apdald name="input.c.apdald"
            #取得帳務組織下所屬成員之帳別   
            CALL s_fin_account_center_comp_str() RETURNING l_comp_wc
            #將取回的字串轉換為SQL條件
            CALL aapp510_get_ooef001_wc(l_comp_wc) RETURNING l_comp_wc
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  
            CALL q_authorised_ld()
            LET g_master.apdald = g_qryparam.return1
            DISPLAY BY NAME g_master.apdald
            NEXT FIELD apdald
            #END add-point
 
 
         #Ctrlp:input.c.apdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocno
            #add-point:ON ACTION controlp INFIELD apdadocno name="input.c.apdadocno"
            LET l_glaa024 = NULL
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald  = g_master.apdald
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apdadocno
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'aapt430'
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            CALL q_ooba002_1()
            LET g_master.apdadocno = g_qryparam.return1
             DISPLAY BY NAME g_master.apdadocno
            NEXT FIELD apdadocno
            #END add-point
 
 
         #Ctrlp:input.c.apdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdadocdt
            #add-point:ON ACTION controlp INFIELD apdadocdt name="input.c.apdadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda019
            #add-point:ON ACTION controlp INFIELD apda019 name="input.c.apda019"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda020
            #add-point:ON ACTION controlp INFIELD apda020 name="input.c.apda020"
            
            #END add-point
 
 
         #Ctrlp:input.c.apda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda003
            #add-point:ON ACTION controlp INFIELD apda003 name="input.c.apda003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apda003
            CALL q_ooag001()
            LET g_master.apda003 = g_qryparam.return1
            DISPLAY g_master.apda003 TO apda003
            LET g_master.apda003_desc = s_desc_get_person_desc(g_master.apda003)
            DISPLAY BY NAME g_master.apda003_desc
            NEXT FIELD apda003
            #END add-point
 
 
         #Ctrlp:input.c.apda018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda018
            #add-point:ON ACTION controlp INFIELD apda018 name="input.c.apda018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apda018
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()
            LET g_master.apda018 = g_qryparam.return1
            LET g_master.apda018_desc = s_desc_get_acc_desc('3113',g_master.apda018)
            DISPLAY g_master.apda018 TO apda018
            DISPLAY BY NAME g_master.apda018_desc
            NEXT FIELD apda018



            #END add-point
 
 
         #Ctrlp:input.c.apda021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apda021
            #add-point:ON ACTION controlp INFIELD apda021 name="input.c.apda021"
            
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON apgl004,apgl003,apgl029,apgldocdt
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
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
            LET g_qryparam.where = " apglcomp = '",g_apdacomp,"' "
            CALL q_apgl003()
            DISPLAY g_qryparam.return2 TO apgl004
            NEXT FIELD apgl004
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
            LET g_qryparam.where = " apglstus = 'Y' "
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = " apglcomp = '",g_apdacomp,"' "
            LET g_qryparam.reqry = FALSE
            CALL q_apgl003()
            DISPLAY g_qryparam.return1 TO apgl003
            NEXT FIELD apgl003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apgl029
            #add-point:BEFORE FIELD apgl029 name="construct.b.apgl029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apgl029
            
            #add-point:AFTER FIELD apgl029 name="construct.a.apgl029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apgl029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apgl029
            #add-point:ON ACTION controlp INFIELD apgl029 name="construct.c.apgl029"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apglcomp = '",g_apdacomp,"' "
            CALL q_apgl029()
            DISPLAY g_qryparam.return1 TO apgl029      #顯示到畫面上
            NEXT FIELD apgl029
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
            CALL aapp510_get_buffer(l_dialog)
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
         CALL aapp510_init()
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
                 CALL aapp510_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp510_transfer_argv(ls_js)
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
 
{<section id="aapp510.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp510_transfer_argv(ls_js)
 
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
 
{<section id="aapp510.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp510_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_docno       LIKE type_t.num5
   DEFINE l_sql         STRING
   DEFINE l_success     LIKE type_t.num5

   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      LET g_master.wc         = lc_param.wc
      LET g_master.apdasite   = lc_param.apdasite
      LET g_master.apdald     = lc_param.apdald
      LET g_master.apdadocno  = lc_param.apdadocno
      LET g_master.apdadocdt  = lc_param.apdadocdt 
      LET g_master.apda003    = lc_param.apda003
      LET g_master.apda018    = lc_param.apda018
      LET g_master.apda019    = lc_param.apda019
      LET g_master.apda021    = lc_param.apda021                      
      CALL s_ld_sel_glaa(g_master.apdald,'glaa004|glaa005|glaa024|glaa121') RETURNING g_sub_success,g_glaa004,g_glaa005,g_glaa024,g_glaa121
      CALL s_fin_orga_get_comp_ld(g_master.apdasite) RETURNING g_sub_success,g_errno,g_apdacomp,g_master.apdald   
      CALL s_fin_get_wc_str(g_apdacomp) RETURNING g_comp_str
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
      CALL cl_get_para(g_enterprise,g_apdacomp,'S-FIN-3007') RETURNING g_sfin3007           #關帳日期
      IF NOT cl_null(g_sfin3007) THEN
         IF g_master.apdadocdt <= g_sfin3007 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00110'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
        END IF
      END IF         
   END IF   
 
   IF cl_null(g_master.apdasite) OR cl_null(g_master.apdald) OR
      cl_null(g_master.apdadocno) OR cl_null(g_master.apdadocdt) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00332'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aapp510_process_cs CURSOR FROM ls_sql
#  FOREACH aapp510_process_cs INTO
   #add-point:process段process name="process.process"
   LET g_sub_success = TRUE  
   CALl cl_err_collect_init()
   CALL s_transaction_begin()
   CALL aapp510_ins_apda()RETURNING g_sub_success,g_master.l_sdocno,g_master.l_edocno
   IF g_sub_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00251'
      LET g_errparam.replace[1] = g_master.l_sdocno
      LET g_errparam.replace[2] = g_master.l_edocno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('Y','0')
      DISPLAY BY NAME g_master.l_sdocno,g_master.l_edocno
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aap-00187'   #單據產生失敗
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF
   CALl cl_err_collect_show()
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
   CALL aapp510_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp510.get_buffer" >}
PRIVATE FUNCTION aapp510_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apdasite = p_dialog.getFieldBuffer('apdasite')
   LET g_master.apdald = p_dialog.getFieldBuffer('apdald')
   LET g_master.apdadocno = p_dialog.getFieldBuffer('apdadocno')
   LET g_master.apdadocdt = p_dialog.getFieldBuffer('apdadocdt')
   LET g_master.apda019 = p_dialog.getFieldBuffer('apda019')
   LET g_master.apda020 = p_dialog.getFieldBuffer('apda020')
   LET g_master.apda003 = p_dialog.getFieldBuffer('apda003')
   LET g_master.apda018 = p_dialog.getFieldBuffer('apda018')
   LET g_master.apda021 = p_dialog.getFieldBuffer('apda021')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp510.msgcentre_notify" >}
PRIVATE FUNCTION aapp510_msgcentre_notify()
 
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
 
{<section id="aapp510.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 分攤日期檢核
# Memo...........: 寫成function是因為
#                : 除了日期本身檢查以外,帳套
#                : 變更時,日期也要跟著檢核並決定是否清空
# Date & Author..: 2017/01/18  By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_apdadocdt_chk(p_comp,p_dat)
   DEFINE p_comp            LIKE glaa_t.glaald
   DEFINE p_dat             LIKE type_t.dat
   DEFINE r_success         LIKE type_t.num5
   DEFINE r_errno           LIKE gzze_t.gzze001
   DEFINE l_date_s_fin_3007 LIKE type_t.dat
   DEFINE l_date_s_fin_6012 LIKE type_t.dat
   
   LET r_success = TRUE
   LET r_errno = ''
   
   #日期檢查
   #檢查應付關帳日
   LET l_date_s_fin_3007 = NULL
   CALL cl_get_para(g_enterprise,g_apdacomp,'S-FIN-3007') RETURNING l_date_s_fin_3007
   
   #檢察成本關帳日
   LET l_date_s_fin_6012 = NULL
   CALL cl_get_para(g_enterprise,g_apdacomp,'S-FIN-6012') RETURNING l_date_s_fin_6012

   CASE
      WHEN NOT cl_null(l_date_s_fin_3007)
         AND g_master.apdadocdt <= l_date_s_fin_3007
         LET r_success = FALSE
         LET r_errno = 'aap-00110'
      WHEN NOT cl_null(l_date_s_fin_6012)
         AND g_master.apdadocdt <= l_date_s_fin_6012
         LET r_success = FALSE
         LET r_errno = 'aap-00111'
   END CASE
   
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 轉成SQL
# Memo...........: 
# Usage..........: aapp510_get_ooef001_wc(p_wc)
# Input parameter: p_wc 帳套
# Return code....: r_wc ('帳套')
# Date & Author..: 20170118 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_get_ooef001_wc(p_wc)
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

################################################################################
# Descriptions...: insert apda_t
# Memo...........:
# Usage..........: CALL aapp510_ins_apda()
# Date & Author..: 2017/07/20 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_ins_apda()
DEFINE l_apda RECORD  #付款核銷單單頭檔
       apdaent    LIKE apda_t.apdaent,     #企業編號
       apdacomp   LIKE apda_t.apdacomp,    #法人
       apdald     LIKE apda_t.apdald,      #帳套
       apdadocno  LIKE apda_t.apdadocno,   #單號
       apdadocdt  LIKE apda_t.apdadocdt,   #單據日期
       apdasite   LIKE apda_t.apdasite,    #帳務組織
       apda001    LIKE apda_t.apda001,     #帳款單性質
       apda002    LIKE apda_t.apda002,     #NO USE
       apda003    LIKE apda_t.apda003,     #帳務人員
       apda004    LIKE apda_t.apda004,     #帳款核銷對象
       apda005    LIKE apda_t.apda005,     #付款對象
       apda006    LIKE apda_t.apda006,     #一次性交易識別碼
       apda007    LIKE apda_t.apda007,     #產生方式
       apda008    LIKE apda_t.apda008,     #來源參考單號
       apda009    LIKE apda_t.apda009,     #沖帳批序號
       apda010    LIKE apda_t.apda010,     #集團代付付單號
       apda011    LIKE apda_t.apda011,     #差異處理
       apda012    LIKE apda_t.apda012,     #退款類型
       apda013    LIKE apda_t.apda013,     #分錄底稿是否可重新產生
       apda014    LIKE apda_t.apda014,     #拋轉傳票號碼
       apda015    LIKE apda_t.apda015,     #作廢理由碼
       apda016    LIKE apda_t.apda016,     #列印次數
       apda017    LIKE apda_t.apda017,     #MEMO備註
       apda018    LIKE apda_t.apda018,     #付款(攤銷)理由碼
       apda019    LIKE apda_t.apda019,     #攤銷目的方式
       apda020    LIKE apda_t.apda020,     #分攤金額方式
       apda021    LIKE apda_t.apda021,     #目的成本要素
       apda113    LIKE apda_t.apda113,     #應核銷本幣金額
       apda123    LIKE apda_t.apda123,     #應核銷本幣二金額
       apda133    LIKE apda_t.apda133,     #應核銷本幣三金額
       apdaownid  LIKE apda_t.apdaownid,   #資料所有者
       apdaowndp  LIKE apda_t.apdaowndp,   #資料所屬部門
       apdacrtid  LIKE apda_t.apdacrtid,   #資料建立者
       apdacrtdp  LIKE apda_t.apdacrtdp,   #資料建立部門
       apdacrtdt  LIKE apda_t.apdacrtdt,   #資料創建日
       apdamodid  LIKE apda_t.apdamodid,   #資料修改者
       apdamoddt  LIKE apda_t.apdamoddt,   #最近修改日
       apdacnfid  LIKE apda_t.apdacnfid,   #資料確認者
       apdacnfdt  LIKE apda_t.apdacnfdt,   #資料確認日
       apdapstid  LIKE apda_t.apdapstid,   #資料過帳者
       apdapstdt  LIKE apda_t.apdapstdt,   #資料過帳日
       apdastus   LIKE apda_t.apdastus,    #狀態碼
       apda104    LIKE apda_t.apda104,     #原幣借方金額合計
       apda105    LIKE apda_t.apda105,     #原幣貸方金額合計
       apda114    LIKE apda_t.apda114,     #本幣借方金額合計
       apda115    LIKE apda_t.apda115,     #本幣貸方金額合計
       apda124    LIKE apda_t.apda124,     #本位幣二借方金額合計
       apda125    LIKE apda_t.apda125,     #本位幣二貸方金額合計
       apda134    LIKE apda_t.apda134,     #本位幣三借方金額合計
       apda135    LIKE apda_t.apda135,     #本位幣三貸方金額合計
       apda022    LIKE apda_t.apda022      #經營方式
END RECORD


DEFINE l_sql STRING 
DEFINE l_apda113     LIKE apda_t.apda113
DEFINE l_apda123     LIKE apda_t.apda123
DEFINE l_apda133     LIKE apda_t.apda123
DEFINE r_success     LIKE type_t.num5
DEFINE r_strno       LIKE apda_t.apdadocno
DEFINE r_endno       LIKE apda_t.apdadocno
DEFINE l_chr         LIKE type_t.chr1
DEFINE l_apgl003     LIKE apgl_t.apgl003
DEFINE l_apce119     LIKE apce_t.apce119
DEFINE l_apce129     LIKE apce_t.apce129
DEFINE l_apce139     LIKE apce_t.apce139
DEFINE l_do          LIKE type_t.num5

   LET r_success = TRUE    LET l_do = 0 LET r_strno = '' LET r_endno =''
   IF cl_null(g_master.wc) THEN LET g_master.wc = " 1=1" END IF    
   
   CALL aapp510_apdadocdt_chk(g_apdacomp,g_master.apdadocdt) RETURNING g_sub_success,g_errno
   IF NOT g_sub_success THEN
      #小於應付關帳日
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = g_errno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_strno,r_endno 
   END IF

   #取得信用狀號碼
   LET l_sql = " SELECT DISTINCT apgl003 FROM apgl_t WHERE apglent = '",g_enterprise,"' AND ",g_master.wc
   PREPARE aapp510_p FROM l_sql
   DECLARE aapp510_c CURSOR FOR aapp510_p   
   FOREACH aapp510_c INTO l_apgl003
      
      CALL s_aooi200_fin_gen_docno(g_master.apdald,'','',g_master.apdadocno,g_master.apdadocdt,'aapt430')
              RETURNING g_sub_success,l_apda.apdadocno
      IF cl_null(r_strno)THEN LET r_strno = l_apda.apdadocno  END IF 
      LET r_endno = l_apda.apdadocno
      IF NOT g_sub_success THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'apm-00003'
         LET g_errparam.extend = l_apda.apdadocno 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CONTINUE FOREACH
      END IF               
      LET l_apda.apdaent    = g_enterprise        #企業編號      
      LET l_apda.apdacomp   = g_apdacomp          #法人
      LET l_apda.apdald     = g_master.apdald     #帳套
      LET l_apda.apdadocdt  = g_master.apdadocdt  #單據日期
      LET l_apda.apdasite   = g_master.apdasite   #帳務組織
      LET l_apda.apda001    = '43'                #帳款單性質
      LET l_apda.apda003    = g_master.apda003    #帳務人員
      LET l_apda.apda016    = 0                   #列印次數
      LET l_apda.apda018    = g_master.apda018    #付款(攤銷)理由碼
      LET l_apda.apda019    = g_master.apda019    #攤銷目的方式
      LET l_apda.apda020    = g_master.apda020    #分攤金額方式
      LET l_apda.apda021    = g_master.apda021    #目的成本要素
      LET l_apda.apda113    = 0                   #應核銷本幣金額
      LET l_apda.apda123    = 0
      LET l_apda.apda133    = 0
      LET l_apda.apdaownid  = g_user             #資料所有者
      LET l_apda.apdaowndp  = g_dept             #資料所屬部門
      LET l_apda.apdacrtid  = g_user             #資料建立者
      LET l_apda.apdacrtdp  = g_dept             #資料建立部門
      LET l_apda.apdacrtdt  = cl_get_current()   #資料創建日
      LET l_apda.apdastus   = 'N'                #狀態碼                    
             
      INSERT INTO apda_t (apdaent,apdasite,apdald,apdadocno,apdadocdt,apda001,apda123, 
           apda133,apdacomp,apdastus,apda019,apda020,apda021,apda003,apda018,apda113,apdaownid, 
           apdaowndp,apdacrtid,apdacrtdp,apdacrtdt,apdamodid,apdamoddt,apdacnfid,apdacnfdt,apdapstid, 
           apdapstdt)
      VALUES (g_enterprise,g_master.apdasite,g_master.apdald,l_apda.apdadocno,g_master.apdadocdt, 
          l_apda.apda001,l_apda.apda123,l_apda.apda133,l_apda.apdacomp, 
          l_apda.apdastus,l_apda.apda019,l_apda.apda020,l_apda.apda021,l_apda.apda003, 
          l_apda.apda018,l_apda.apda113,l_apda.apdaownid,l_apda.apdaowndp,l_apda.apdacrtid, 
          l_apda.apdacrtdp,l_apda.apdacrtdt,l_apda.apdamodid,l_apda.apdamoddt,l_apda.apdacnfid, 
          l_apda.apdacnfdt,l_apda.apdapstid,l_apda.apdapstdt) 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "apda_t " 
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         CONTINUE FOREACH
      END IF        
      LET l_do = l_do + 1
      #產生明細單身 
      CALL aapp510_ins_apce(l_apgl003,l_apda.apdald,l_apda.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         CONTINUE FOREACH      
      END IF
      #產生目的 信用狀號碼底下所有的入庫單 
      CALL aapp510_ins_apdc(l_apgl003,l_apda.apdald,l_apda.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         CONTINUE FOREACH      
      END IF
      
      SELECT SUM(apce119),SUM(apce129),SUM(apce139)
        INTO l_apce119,l_apce129,l_apce139
        FROM apce_t WHERE apceent = g_enterprise AND apcedocno = l_apda.apdadocno
      UPDATE apda_t SET apda113 = l_apce119,apda123 = l_apce129,apda133 = l_apce139 
       WHERE apdaent = g_enterprise AND apdadocno = l_apda.apdadocno
      
      #重分攤計算
      CALL aapp510_apce_apdc_balance(l_apda.apdadocno) RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         CONTINUE FOREACH      
      END IF
          
      # D-FIN-0030 產生交易帳務分錄否
      CALL s_fin_get_doc_para(g_master.apdald,g_apdacomp,g_master.apdadocno,'D-FIN-0030') RETURNING l_chr    
     
      #是否啟用分錄底稿
      IF g_glaa121 = 'Y' AND l_chr = 'Y' THEN             
         #產生分錄底稿
         CALL s_pre_voucher_ins('AP','P30',g_master.apdald,l_apda.apdadocno,g_master.apdadocdt,'2')
                      RETURNING r_success                
      END IF       
     
   END FOREACH   
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00058' #無來源資料或資料未確認!
      LET g_errparam.extend = "apda_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success,r_strno,r_endno 
   END IF
  
   RETURN r_success,r_strno,r_endno

END FUNCTION

################################################################################
# Descriptions...: insert_apce_t
# Memo...........:
# Usage..........: CALL aapp510_ins_apce(p_apca073,p_apdald,p_apdadocno)
# Date & Author..: 2017/01/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_ins_apce(p_apca073,p_apdald,p_apdadocno)
DEFINE p_apca073   LIKE apca_t.apca073
DEFINE p_apdald    LIKE apda_t.apdald
DEFINE p_apdadocno LIKE apda_t.apdadocno
DEFINE r_success   LIKE type_t.num5
DEFINE l_apce RECORD  #應付沖帳明細
       apceent    LIKE apce_t.apceent,    #企業編號
       apcecomp   LIKE apce_t.apcecomp,   #法人
       apcelegl   LIKE apce_t.apcelegl,   #核算組織
       apcesite   LIKE apce_t.apcesite,   #帳務組織
       apceld     LIKE apce_t.apceld,     #帳套
       apceorga   LIKE apce_t.apceorga,   #帳務歸屬組織
       apcedocno  LIKE apce_t.apcedocno,  #沖銷單單號
       apceseq    LIKE apce_t.apceseq,    #項次
       apce001    LIKE apce_t.apce001,    #來源作業
       apce002    LIKE apce_t.apce002,    #沖銷類型
       apce003    LIKE apce_t.apce003,    #沖銷帳款單單號
       apce004    LIKE apce_t.apce004,    #沖銷帳款單項次
       apce005    LIKE apce_t.apce005,    #分期帳款序
       apce008    LIKE apce_t.apce008,    #票據號碼/ 現金銀存帳戶
       apce010    LIKE apce_t.apce010,    #摘要說明
       apce011    LIKE apce_t.apce011,    #理由碼
       apce012    LIKE apce_t.apce012,    #銀存存提碼
       apce013    LIKE apce_t.apce013,    #現金異動碼
       apce015    LIKE apce_t.apce015,    #沖銷加減項
       apce016    LIKE apce_t.apce016,    #沖銷科目
       apce017    LIKE apce_t.apce017,    #業務人員
       apce018    LIKE apce_t.apce018,    #業務部門
       apce019    LIKE apce_t.apce019,    #責任中心
       apce020    LIKE apce_t.apce020,    #產品類別
       apce021    LIKE apce_t.apce021,    #no use
       apce022    LIKE apce_t.apce022,    #專案編號
       apce023    LIKE apce_t.apce023,    #WBS編號
       apce024    LIKE apce_t.apce024,    #第二參考單號
       apce025    LIKE apce_t.apce025,    #第二參考單號項次
       apce026    LIKE apce_t.apce026,    #no use
       apce027    LIKE apce_t.apce027,    #應稅折抵否
       apce028    LIKE apce_t.apce028,    #產生方式
       apce029    LIKE apce_t.apce029,    #傳票號碼
       apce030    LIKE apce_t.apce030,    #傳票項次
       apce031    LIKE apce_t.apce031,    #付款(票)到期日
       apce032    LIKE apce_t.apce032,    #應付款日
       apce035    LIKE apce_t.apce035,    #區域
       apce036    LIKE apce_t.apce036,    #客戶分類
       apce038    LIKE apce_t.apce038,    #帳款對象
       apce044    LIKE apce_t.apce044,    #經營方式
       apce045    LIKE apce_t.apce045,    #渠道
       apce046    LIKE apce_t.apce046,    #品牌
       apce047    LIKE apce_t.apce047,    #發票編號
       apce048    LIKE apce_t.apce048,    #發票號碼
       apce049    LIKE apce_t.apce049,    #付款申請單號碼
       apce050    LIKE apce_t.apce050,    #付款申請單項次
       apce051    LIKE apce_t.apce051,    #自由核算項一
       apce052    LIKE apce_t.apce052,    #自由核算項二
       apce053    LIKE apce_t.apce053,    #自由核算項三
       apce054    LIKE apce_t.apce054,    #自由核算項四
       apce055    LIKE apce_t.apce055,    #自由核算項五
       apce056    LIKE apce_t.apce056,    #自由核算項六
       apce057    LIKE apce_t.apce057,    #自由核算項七
       apce058    LIKE apce_t.apce058,    #自由核算項八
       apce059    LIKE apce_t.apce059,    #自由核算項九
       apce060    LIKE apce_t.apce060,    #自由核算項十
       apce100    LIKE apce_t.apce100,    #幣別
       apce101    LIKE apce_t.apce101,    #匯率
       apce104    LIKE apce_t.apce104,    #原幣應稅折抵稅額
       apce109    LIKE apce_t.apce109,    #原幣沖帳金額
       apce114    LIKE apce_t.apce114,    #本幣應稅折抵稅額
       apce119    LIKE apce_t.apce119,    #本幣沖帳金額
       apce120    LIKE apce_t.apce120,    #本位幣二幣別
       apce124    LIKE apce_t.apce124,    #本位幣二應稅折抵稅額
       apce121    LIKE apce_t.apce121,    #本位幣二匯率
       apce129    LIKE apce_t.apce129,    #本位幣二沖帳金額
       apce130    LIKE apce_t.apce130,    #本位幣三幣別
       apce131    LIKE apce_t.apce131,    #本位幣三匯率
       apce134    LIKE apce_t.apce134,    #本位幣三應稅折抵稅額
       apce139    LIKE apce_t.apce139     #本位幣三沖帳金額
END RECORD


DEFINE l_apcb RECORD  #應付憑單單身
       apcadocdt LIKE apca_t.apcadocdt,
       apca001   LIKE apca_t.apca001,
       apca004   LIKE apca_t.apca004,
       apca100   LIKE apca_t.apca100,
       apca101   LIKE apca_t.apca101, 
       apca036   LIKE apca_t.apca036,
       apca065   LIKE apca_t.apca065,
       apca066   LIKE apca_t.apca066,
       apca120   LIKE apca_t.apca120,
       apca121   LIKE apca_t.apca121,                             
       apca130   LIKE apca_t.apca130,
       apca131   LIKE apca_t.apca131,
       apcbent   LIKE apcb_t.apcbent,   #企業編號
       apcbld    LIKE apcb_t.apcbld,    #帳套
       apcborga  LIKE apcb_t.apcborga,  #帳務歸屬組織(來源組織)
       apcbsite  LIKE apcb_t.apcbsite,  #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq LIKE apcb_t.apcbseq, #項次
       apcb001 LIKE apcb_t.apcb001, #來源類型
       apcb002 LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003 LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004 LIKE apcb_t.apcb004, #產品編號
       apcb005 LIKE apcb_t.apcb005, #品名規格
       apcb006 LIKE apcb_t.apcb006, #單位
       apcb007 LIKE apcb_t.apcb007, #計價數量
       apcb008 LIKE apcb_t.apcb008, #參考單據號碼
       apcb009 LIKE apcb_t.apcb009, #參考單據項次
       apcb010 LIKE apcb_t.apcb010, #業務部門
       apcb011 LIKE apcb_t.apcb011, #責任中心
       apcb012 LIKE apcb_t.apcb012, #產品類別
       apcb013 LIKE apcb_t.apcb013, #搭贈
       apcb014 LIKE apcb_t.apcb014, #理由碼
       apcb015 LIKE apcb_t.apcb015, #專案編號
       apcb016 LIKE apcb_t.apcb016, #WBS編號
       apcb017 LIKE apcb_t.apcb017, #預算細項
       apcb018 LIKE apcb_t.apcb018, #专柜编号
       apcb019 LIKE apcb_t.apcb019, #開票性質
       apcb020 LIKE apcb_t.apcb020, #稅別
       apcb021 LIKE apcb_t.apcb021, #費用會計科目
       apcb022 LIKE apcb_t.apcb022, #正負值
       apcb023 LIKE apcb_t.apcb023, #沖暫估單否
       apcb024 LIKE apcb_t.apcb024, #區域
       apcb025 LIKE apcb_t.apcb025, #傳票號碼
       apcb026 LIKE apcb_t.apcb026, #傳票項次
       apcb027 LIKE apcb_t.apcb027, #發票編號
       apcb028 LIKE apcb_t.apcb028, #發票號碼
       apcb029 LIKE apcb_t.apcb029, #應付帳款科目
       apcb030 LIKE apcb_t.apcb030, #付款條件
       apcb032 LIKE apcb_t.apcb032, #訂金序次
       apcb033 LIKE apcb_t.apcb033, #經營方式
       apcb034 LIKE apcb_t.apcb034, #通路
       apcb035 LIKE apcb_t.apcb035, #品牌
       apcb036 LIKE apcb_t.apcb036, #客群
       apcb037 LIKE apcb_t.apcb037, #自由核算項一
       apcb038 LIKE apcb_t.apcb038, #自由核算項二
       apcb039 LIKE apcb_t.apcb039, #自由核算項三
       apcb040 LIKE apcb_t.apcb040, #自由核算項四
       apcb041 LIKE apcb_t.apcb041, #自由核算項五
       apcb042 LIKE apcb_t.apcb042, #自由核算項六
       apcb043 LIKE apcb_t.apcb043, #自由核算項七
       apcb044 LIKE apcb_t.apcb044, #自由核算項八
       apcb045 LIKE apcb_t.apcb045, #自由核算項九
       apcb046 LIKE apcb_t.apcb046, #自由核算項十
       apcb047 LIKE apcb_t.apcb047, #摘要
       apcb049 LIKE apcb_t.apcb049, #開票單號
       apcb050 LIKE apcb_t.apcb050, #開票項次
       apcb051 LIKE apcb_t.apcb051, #業務人員
       apcb100 LIKE apcb_t.apcb100, #交易原幣
       apcb101 LIKE apcb_t.apcb101, #交易原幣單價
       apcb102 LIKE apcb_t.apcb102, #原幣匯率
       apcb103 LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb113 LIKE apcb_t.apcb113, #本幣未稅金額
       apcb123 LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb133 LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb052 LIKE apcb_t.apcb052, #稅額
       apcb053 LIKE apcb_t.apcb053, #含稅金額
       apcb054 LIKE apcb_t.apcb054, #帳款對象
       apcb055 LIKE apcb_t.apcb055  #付款對象
END RECORD

DEFINE l_sql     STRING 
DEFINE l_cnt     LIKE type_t.num5
DEFINE l_seq     LIKE apce_t.apceseq
DEFINE l_glac007 LIKE glac_t.glac007
DEFINE l_apdanum     LIKE type_t.num5
DEFINE l_apdamon     LIKE xrea_t.xrea002 #年度
DEFINE l_apdayear    LIKE xrea_t.xrea001 #月份
DEFINE l_apcanum     LIKE type_t.num5 
DEFINE l_apcamon     LIKE xrea_t.xrea002 #年度
DEFINE l_apcayear    LIKE xrea_t.xrea001 #月份
DEFINE l_oocq014     LIKE oocq_t.oocq014
DEFINE l_do          LIKE type_t.num5


   LET r_success = TRUE  LET l_seq = 0 LET l_do = 0
   
   
   LET l_sql = " SELECT apcborga,apcbseq,apca001,apca004,apca100,apca101,apcadocdt,    ",     #來源組織/沖銷帳款單項次/帳款單性質/帳款對象/幣別/匯率
               "        apca036,apca065,apca066,apca120,apca121,apca130,apca131,       ",     #費用(借方)科目編號/發票編號/發票號碼  
               "        apcb113,apcb123,apcb133,                                       ",     #本幣未稅金額
               "        apcbdocno,apcb047,apcb021,apcb054,apcb102,                     ",     #單號/摘要/待沖銷應付會科/帳款對象/原幣匯率
               "        apcb051,apcb010,apcb011,apcb012,apcb015,apcb014,  ",   #業務人員/業務部門/責任中心/產品類別/專案編號/費用編碼
               "        apcb016,apcb024,apcb036,apcb033,apcb034,apcb035,  ",   #WBS/區域/客群/經營方式/渠道/品牌
               "        apcb037,apcb038,apcb039,apcb040,apcb041,          ",   #自由核算項1 - 5 
               "        apcb042,apcb043,apcb044,apcb045,apcb046,apcb103   ",   #自由核算項6 - 10  /交易原幣未稅金額            
               "   FROM apca_t,apcb_t                                     ",        
               "  WHERE apcaent = apcbent  AND apcadocno = apcbdocno      ",
               "    AND apcaent = '",g_enterprise,"'  AND apcastus ='Y'  AND apcb001 ='54'    ",
               "    AND apcacomp = '",g_apdacomp,"'                                           ",
               "    AND apca073 ='",p_apca073,"'                                              "
                                 
   PREPARE aapp510_ins_apce_prep FROM l_sql
   DECLARE aapp510_ins_apce_curs CURSOR FOR aapp510_ins_apce_prep
   FOREACH aapp510_ins_apce_curs  INTO l_apcb.apcborga ,l_apcb.apcbseq,l_apcb.apca001,l_apcb.apca004,l_apcb.apca100,l_apcb.apca101,l_apcb.apcadocdt,
                                       l_apcb.apca036  ,l_apcb.apca065,l_apcb.apca066,l_apcb.apca120,l_apcb.apca121,l_apcb.apca130,l_apcb.apca131,
                                       l_apcb.apcb113  ,l_apcb.apcb123,l_apcb.apcb133,
                                       l_apcb.apcbdocno,l_apcb.apcb047,l_apcb.apcb021,l_apcb.apcb054,l_apcb.apcb102,
                                       l_apcb.apcb051  ,l_apcb.apcb010,l_apcb.apcb011,l_apcb.apcb012,l_apcb.apcb015,l_apcb.apcb014,
                                       l_apcb.apcb016  ,l_apcb.apcb024,l_apcb.apcb036,l_apcb.apcb033,l_apcb.apcb034,l_apcb.apcb035,
                                       l_apcb.apcb037  ,l_apcb.apcb038,l_apcb.apcb039,l_apcb.apcb040,l_apcb.apcb041, 
                                       l_apcb.apcb042  ,l_apcb.apcb043,l_apcb.apcb044,l_apcb.apcb045,l_apcb.apcb046,l_apcb.apcb103 
      LET l_oocq014 = '' #分攤至成本為Y 才需要分攤(aapi510)   
      SELECT oocq014 INTO l_oocq014 FROM oocq_t 
       WHERE oocqent = g_enterprise AND oocq001 = '3117' AND oocq002 = l_apcb.apcb014 AND oocqstus='Y'
      IF l_oocq014 <> 'Y' OR cl_null(l_oocq014) THEN CONTINUE FOREACH END IF

      LET l_glac007 = ''  #IF l_glac007 = 1(資產類)可跨月ELSE不可跨
      SELECT glac007 INTO l_glac007 FROM glac_t WHERE glacent = g_enterprise AND glac001 = g_glaa004 AND glac002 = l_apcb.apcb021      
      IF l_glac007 = 1 THEN          
      ELSE
         LET l_apdayear = YEAR(g_master.apdadocdt) 
         LET l_apdamon = MONTH(g_master.apdadocdt)
         LET l_apdanum  = (l_apdayear * 12) + l_apdamon
         LET l_apcayear = YEAR(l_apcb.apcadocdt)    
         LET l_apcamon = MONTH(l_apcb.apcadocdt)
         LET l_apcanum  = (l_apcayear * 12) + l_apcamon            
         IF l_apdanum <> l_apcanum THEN CONTINUE FOREACH END IF #不可跨月
      END IF
      LET l_cnt = 0 #已經產生 不可再重複產生
      SELECT COUNT(1) INTO l_cnt FROM apce_t
       WHERE apceent = g_enterprise AND apce003 = l_apcb.apcbdocno AND apce004 = l_apcb.apcbseq 
       
      IF l_cnt > 0 THEN CONTINUE FOREACH END IF      
      
      LET l_seq = l_seq + 1
      INITIALIZE l_apce.* TO NULL                     
      LET l_apce.apceent   = g_enterprise          #企業編號
      LET l_apce.apcecomp  = g_apdacomp            #法人
      LET l_apce.apcesite  = g_master.apdasite     #帳務組織
      LET l_apce.apceld    = p_apdald              #帳套
      LET l_apce.apceorga  = g_master.apdasite     #帳務歸屬組織
      LET l_apce.apcedocno = p_apdadocno           #沖銷單單號
      LET l_apce.apceseq =  l_seq                  #項次
      LET l_apce.apce001 = 'aapt430'               #來源作業
      LET l_apce.apce002 = '05'                    #沖銷類型
      LET l_apce.apce003 = l_apcb.apcbdocno        #沖銷帳款單單號
      LET l_apce.apce004 = l_apcb.apcbseq          #沖銷帳款單項次
      LET l_apce.apce005 = 0                       #分期帳款序
      LET l_apce.apce010 = l_apcb.apcb047          #摘要
      LET l_apce.apce015 = 'C' 
      LET l_apce.apce016 = l_apcb.apcb021      #沖銷科目
      LET l_apce.apce017 = l_apcb.apcb051      #業務人員
      LET l_apce.apce018 = l_apcb.apcb010      #業務部門
      LET l_apce.apce019 = l_apcb.apcb011      #責任中心
      LET l_apce.apce020 = l_apcb.apcb012      #產品類別
      LET l_apce.apce022 = l_apcb.apcb015      #專案編號
      LET l_apce.apce023 = l_apcb.apcb016      #WBS編號
      LET l_apce.apce027 = 'N'                 #應稅折抵否
      LET l_apce.apce028 = '0'                 #產生方式        
      LET l_apce.apce035 = l_apcb.apcb024      #區域
      LET l_apce.apce038 = l_apcb.apcb054      #帳款對象
      LET l_apce.apce044 = l_apcb.apcb033      #經營方式
      LET l_apce.apce045 = l_apcb.apcb034      #渠道
      LET l_apce.apce046 = l_apcb.apcb035      #品牌
      LET l_apce.apce047 = l_apcb.apca065      #發票編號
      LET l_apce.apce048 = l_apcb.apca066      #發票號碼
      LET l_apce.apce051 = l_apcb.apcb037      #自由核算項一
      LET l_apce.apce052 = l_apcb.apcb038      #自由核算項二
      LET l_apce.apce053 = l_apcb.apcb039      #自由核算項三
      LET l_apce.apce054 = l_apcb.apcb040      #自由核算項四
      LET l_apce.apce055 = l_apcb.apcb041      #自由核算項五
      LET l_apce.apce056 = l_apcb.apcb042      #自由核算項六
      LET l_apce.apce057 = l_apcb.apcb043      #自由核算項七
      LET l_apce.apce058 = l_apcb.apcb044      #自由核算項八
      LET l_apce.apce059 = l_apcb.apcb045      #自由核算項九           
      LET l_apce.apce060 = l_apcb.apcb046      #自由核算項十        
                
      LET l_apce.apce101 = l_apcb.apcb102      #匯率      
      LET l_apce.apce104 = 0                   #原幣應稅折抵稅額
      IF l_apcb.apcb102  = 1 THEN #匯率等於1 讓本幣等於原幣
         LET l_apce.apce109 = l_apcb.apcb113
         SELECT glaa001 INTO l_apce.apce100 FROM glaa_t
          WHERE glaaent = g_enterprise AND glaacomp = l_apce.apcecomp
      ELSE
         LET l_apce.apce100 = l_apcb.apca100      #幣別 
         LET l_apce.apce109 = l_apcb.apcb103      #原幣沖帳金額
      END IF
      LET l_apce.apce114 = 0                      #本幣應稅折抵稅額
      LET l_apce.apce119 = l_apcb.apcb113 #本幣沖帳金額
      LET l_apce.apce120 = l_apcb.apca120 #本位幣二幣別
      LET l_apce.apce121 = l_apcb.apca121 #本位幣二匯率
      LET l_apce.apce124 = 0              #本位幣二應稅折抵稅額 
      LET l_apce.apce129 = l_apcb.apcb123 
      LET l_apce.apce134 = 0              #本位幣三應稅折抵稅額
      LET l_apce.apce130 = l_apcb.apca130
      LET l_apce.apce131 = l_apcb.apca131
      LET l_apce.apce134 = 0
      LET l_apce.apce139 = l_apcb.apcb133
      INSERT INTO apce_t
                  (apceent,apceld,apcedocno,apceseq,
                   apce001,apce002,apceorga,apce003,apce004,apce005,
                   apce038,apce047,apce048,apce119,apce129,apce139,
                   apce010,apce015,apce016,apce017,apce018,apce019,
                   apce020,apce022,apce023,apce035,apce036,apce044,
                   apce045,apce046,apce051,apce052,apce053,apce054,
                   apce055,apce056,apce057,apce058,apce059,apce060,
                   apcecomp,apcelegl,apcesite,apce027,apce028,apce031,
                   apce032,apce100,apce101,apce109,apce120,apce121,apce130,
                   apce131,apce104,apce114,apce124,apce134) 
            VALUES(g_enterprise,p_apdald,p_apdadocno,l_apce.apceseq,
                   l_apce.apce001,l_apce.apce002,l_apce.apceorga,l_apce.apce003,l_apce.apce004,l_apce.apce005, 
                   l_apce.apce038,l_apce.apce047,l_apce.apce048,l_apce.apce119,l_apce.apce129,l_apce.apce139, 
                   l_apce.apce010,l_apce.apce015,l_apce.apce016,l_apce.apce017,l_apce.apce018,l_apce.apce019,                
                   l_apce.apce020,l_apce.apce022,l_apce.apce023,l_apce.apce035,l_apce.apce036,l_apce.apce044, 
                   l_apce.apce045,l_apce.apce046,l_apce.apce051,l_apce.apce052,l_apce.apce053,l_apce.apce054, 
                   l_apce.apce055,l_apce.apce056,l_apce.apce057,l_apce.apce058,l_apce.apce059,l_apce.apce060, 
                   l_apce.apcecomp,l_apce.apcelegl,l_apce.apcesite,l_apce.apce027,l_apce.apce028,l_apce.apce031, 
                   l_apce.apce032,l_apce.apce100,l_apce.apce101,l_apce.apce109,l_apce.apce120,l_apce.apce121, 
                   l_apce.apce130,l_apce.apce131,l_apce.apce104,l_apce.apce114,l_apce.apce124,l_apce.apce134)             
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = "apce_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF         
      LET l_do = l_do + 1
   END FOREACH
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00058' #無來源資料或資料未確認!
      LET g_errparam.extend = "apce_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF
                  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 產生目的帳款單據
# Memo...........:
# Usage..........: CALL aaapp510_ins_apdc(p_apgl003,p_apcald,p_apdadocno)
# Date & Author..: 2017/01/20 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_ins_apdc(p_apgl003,p_apdald,p_apdadocno)
DEFINE l_apdc  RECORD  #費用分攤目的明細檔
       apdcent    LIKE apdc_t.apdcent, #企業編號
       apdccomp   LIKE apdc_t.apdccomp, #法人
       apdcsite   LIKE apdc_t.apdcsite, #帳務組織
       apdcld     LIKE apdc_t.apdcld, #帳套
       apdcdocno  LIKE apdc_t.apdcdocno, #攤銷單號
       apdcseq    LIKE apdc_t.apdcseq, #攤銷單項次
       apdcorga   LIKE apdc_t.apdcorga, #來源歸屬組織
       apdc001    LIKE apdc_t.apdc001, #攤銷至目的方式
       apdc002    LIKE apdc_t.apdc002, #交易單號(入庫單)
       apdc003    LIKE apdc_t.apdc003, #交易單項次
       apdc004    LIKE apdc_t.apdc004, #產品編號
       apdc005    LIKE apdc_t.apdc005, #目的帳款單號
       apdc006    LIKE apdc_t.apdc006, #目的帳款單項次
       apdc007    LIKE apdc_t.apdc007, #目的會計科目
       apdc008    LIKE apdc_t.apdc008, #數量
       apdc009    LIKE apdc_t.apdc009, #分攤金額方式
       apdc111    LIKE apdc_t.apdc111, #本幣分攤前單價
       apdc113    LIKE apdc_t.apdc113, #本幣分攤前金額
       apdc211    LIKE apdc_t.apdc211, #本幣分攤後單價
       apdc213    LIKE apdc_t.apdc213, #本幣分攤後金額
       apdc123    LIKE apdc_t.apdc123, #本位幣二分攤前金額
       apdc223    LIKE apdc_t.apdc223, #本位幣二分攤後金額
       apdc133    LIKE apdc_t.apdc133, #本位幣三分攤前金額
       apdc233    LIKE apdc_t.apdc233, #本位幣三分攤後金額
       apdc015    LIKE apdc_t.apdc015, #沖銷加減項
       apdc017    LIKE apdc_t.apdc017, #業務人員
       apdc018    LIKE apdc_t.apdc018, #業務部門
       apdc019    LIKE apdc_t.apdc019, #責任中心
       apdc020    LIKE apdc_t.apdc020, #產品類別
       apdc022    LIKE apdc_t.apdc022, #專案編號
       apdc023    LIKE apdc_t.apdc023, #WBS編號
       apdc024    LIKE apdc_t.apdc024, #區域
       apdc025    LIKE apdc_t.apdc025, #客戶分類
       apdc026    LIKE apdc_t.apdc026, #帳款對象
       apdc027    LIKE apdc_t.apdc027, #經營方式
       apdc028    LIKE apdc_t.apdc028, #渠道
       apdc029    LIKE apdc_t.apdc029, #品牌
       apdc031    LIKE apdc_t.apdc031, #自由核算項一
       apdc032    LIKE apdc_t.apdc032, #自由核算項二
       apdc033    LIKE apdc_t.apdc033, #自由核算項三
       apdc034    LIKE apdc_t.apdc034, #自由核算項四
       apdc035    LIKE apdc_t.apdc035, #自由核算項五
       apdc036    LIKE apdc_t.apdc036, #自由核算項六
       apdc037    LIKE apdc_t.apdc037, #自由核算項七
       apdc038    LIKE apdc_t.apdc038, #自由核算項八
       apdc039    LIKE apdc_t.apdc039, #自由核算項九
       apdc040    LIKE apdc_t.apdc040, #自由核算項十
       apdc041    LIKE apdc_t.apdc041  #摘要說明
           END RECORD

DEFINE l_apcb RECORD  #應付憑單單身
       apcbent   LIKE apcb_t.apcbent, #企業編號
       apcbld    LIKE apcb_t.apcbld, #帳套
       apcblegl  LIKE apcb_t.apcblegl, #核算組織
       apcborga  LIKE apcb_t.apcborga, #帳務歸屬組織(來源組織)
       apcbsite  LIKE apcb_t.apcbsite, #應付帳務組織
       apcbdocno LIKE apcb_t.apcbdocno, #單號
       apcbseq   LIKE apcb_t.apcbseq, #項次
       apcb001   LIKE apcb_t.apcb001, #來源類型
       apcb002   LIKE apcb_t.apcb002, #來源業務單據號碼
       apcb003   LIKE apcb_t.apcb003, #來源業務單據項次
       apcb004   LIKE apcb_t.apcb004, #產品編號
       apcb005   LIKE apcb_t.apcb005, #品名規格
       apcb006   LIKE apcb_t.apcb006, #單位
       apcb007   LIKE apcb_t.apcb007, #計價數量
       apcb008   LIKE apcb_t.apcb008, #參考單據號碼
       apcb009   LIKE apcb_t.apcb009, #參考單據項次
       apcb010   LIKE apcb_t.apcb010, #業務部門
       apcb011   LIKE apcb_t.apcb011, #責任中心
       apcb012   LIKE apcb_t.apcb012, #產品類別
       apcb013   LIKE apcb_t.apcb013, #搭贈
       apcb014   LIKE apcb_t.apcb014, #理由碼
       apcb015   LIKE apcb_t.apcb015, #專案編號
       apcb016   LIKE apcb_t.apcb016, #WBS編號
       apcb017   LIKE apcb_t.apcb017, #預算細項
       apcb018   LIKE apcb_t.apcb018, #专柜编号
       apcb019   LIKE apcb_t.apcb019, #開票性質
       apcb020   LIKE apcb_t.apcb020, #稅別
       apcb021   LIKE apcb_t.apcb021, #費用會計科目
       apcb022   LIKE apcb_t.apcb022, #正負值
       apcb023   LIKE apcb_t.apcb023, #沖暫估單否
       apcb024   LIKE apcb_t.apcb024, #區域
       apcb025   LIKE apcb_t.apcb025, #傳票號碼
       apcb026   LIKE apcb_t.apcb026, #傳票項次
       apcb027   LIKE apcb_t.apcb027, #發票代碼
       apcb028   LIKE apcb_t.apcb028, #發票號碼
       apcb029   LIKE apcb_t.apcb029, #應付帳款科目
       apcb030   LIKE apcb_t.apcb030, #付款條件
       apcb032   LIKE apcb_t.apcb032, #訂金序次
       apcb033   LIKE apcb_t.apcb033, #經營方式
       apcb034   LIKE apcb_t.apcb034, #通路
       apcb035   LIKE apcb_t.apcb035, #品牌
       apcb036   LIKE apcb_t.apcb036, #客群
       apcb037   LIKE apcb_t.apcb037, #自由核算項一
       apcb038   LIKE apcb_t.apcb038, #自由核算項二
       apcb039   LIKE apcb_t.apcb039, #自由核算項三
       apcb040   LIKE apcb_t.apcb040, #自由核算項四
       apcb041   LIKE apcb_t.apcb041, #自由核算項五
       apcb042   LIKE apcb_t.apcb042, #自由核算項六
       apcb043   LIKE apcb_t.apcb043, #自由核算項七
       apcb044   LIKE apcb_t.apcb044, #自由核算項八
       apcb045   LIKE apcb_t.apcb045, #自由核算項九
       apcb046   LIKE apcb_t.apcb046, #自由核算項十
       apcb047   LIKE apcb_t.apcb047, #摘要
       apcb048   LIKE apcb_t.apcb048, #來源訂購單號
       apcb049   LIKE apcb_t.apcb049, #開票單號
       apcb050   LIKE apcb_t.apcb050, #開票項次
       apcb051   LIKE apcb_t.apcb051, #業務人員
       apcb100   LIKE apcb_t.apcb100, #交易原幣
       apcb101   LIKE apcb_t.apcb101, #交易原幣單價
       apcb102   LIKE apcb_t.apcb102, #原幣匯率
       apcb103   LIKE apcb_t.apcb103, #交易原幣未稅金額
       apcb104   LIKE apcb_t.apcb104, #交易原幣稅額
       apcb105   LIKE apcb_t.apcb105, #交易原幣含稅金額
       apcb106   LIKE apcb_t.apcb106, #交易幣標準成本金額
       apcb107   LIKE apcb_t.apcb107, #NO USE
       apcb108   LIKE apcb_t.apcb108, #交易原幣成本認列金額
       apcb111   LIKE apcb_t.apcb111, #本幣單價
       apcb113   LIKE apcb_t.apcb113, #本幣未稅金額
       apcb114   LIKE apcb_t.apcb114, #本幣稅額
       apcb115   LIKE apcb_t.apcb115, #本幣含稅金額
       apcb116   LIKE apcb_t.apcb116, #本幣標準成本金額
       apcb117   LIKE apcb_t.apcb117, #NO USE
       apcb118   LIKE apcb_t.apcb118, #本幣成本認列金額
       apcb119   LIKE apcb_t.apcb119, #應開發票含稅金額
       apcb121   LIKE apcb_t.apcb121, #本位幣二匯率
       apcb123   LIKE apcb_t.apcb123, #本位幣二未稅金額
       apcb124   LIKE apcb_t.apcb124, #本位幣二稅額
       apcb125   LIKE apcb_t.apcb125, #本位幣二含稅金額
       apcb126   LIKE apcb_t.apcb126, #本幣二標準成本金額
       apcb127   LIKE apcb_t.apcb127, #NO USE
       apcb128   LIKE apcb_t.apcb128, #本位幣二成本認列金額
       apcb131   LIKE apcb_t.apcb131, #本位幣三匯率
       apcb133   LIKE apcb_t.apcb133, #本位幣三未稅金額
       apcb134   LIKE apcb_t.apcb134, #本位幣三稅額
       apcb135   LIKE apcb_t.apcb135, #本位幣三含稅金額
       apcb136   LIKE apcb_t.apcb136, #本幣三標準成本金額
       apcb137   LIKE apcb_t.apcb137, #NO USE
       apcb138   LIKE apcb_t.apcb138, #本位幣三成本認列金額
       apcbud001 LIKE apcb_t.apcbud001, #自定義欄位(文字)001
       apcbud002 LIKE apcb_t.apcbud002, #自定義欄位(文字)002
       apcbud003 LIKE apcb_t.apcbud003, #自定義欄位(文字)003
       apcbud004 LIKE apcb_t.apcbud004, #自定義欄位(文字)004
       apcbud005 LIKE apcb_t.apcbud005, #自定義欄位(文字)005
       apcbud006 LIKE apcb_t.apcbud006, #自定義欄位(文字)006
       apcbud007 LIKE apcb_t.apcbud007, #自定義欄位(文字)007
       apcbud008 LIKE apcb_t.apcbud008, #自定義欄位(文字)008
       apcbud009 LIKE apcb_t.apcbud009, #自定義欄位(文字)009
       apcbud010 LIKE apcb_t.apcbud010, #自定義欄位(文字)010
       apcbud011 LIKE apcb_t.apcbud011, #自定義欄位(數字)011
       apcbud012 LIKE apcb_t.apcbud012, #自定義欄位(數字)012
       apcbud013 LIKE apcb_t.apcbud013, #自定義欄位(數字)013
       apcbud014 LIKE apcb_t.apcbud014, #自定義欄位(數字)014
       apcbud015 LIKE apcb_t.apcbud015, #自定義欄位(數字)015
       apcbud016 LIKE apcb_t.apcbud016, #自定義欄位(數字)016
       apcbud017 LIKE apcb_t.apcbud017, #自定義欄位(數字)017
       apcbud018 LIKE apcb_t.apcbud018, #自定義欄位(數字)018
       apcbud019 LIKE apcb_t.apcbud019, #自定義欄位(數字)019
       apcbud020 LIKE apcb_t.apcbud020, #自定義欄位(數字)020
       apcbud021 LIKE apcb_t.apcbud021, #自定義欄位(日期時間)021
       apcbud022 LIKE apcb_t.apcbud022, #自定義欄位(日期時間)022
       apcbud023 LIKE apcb_t.apcbud023, #自定義欄位(日期時間)023
       apcbud024 LIKE apcb_t.apcbud024, #自定義欄位(日期時間)024
       apcbud025 LIKE apcb_t.apcbud025, #自定義欄位(日期時間)025
       apcbud026 LIKE apcb_t.apcbud026, #自定義欄位(日期時間)026
       apcbud027 LIKE apcb_t.apcbud027, #自定義欄位(日期時間)027
       apcbud028 LIKE apcb_t.apcbud028, #自定義欄位(日期時間)028
       apcbud029 LIKE apcb_t.apcbud029, #自定義欄位(日期時間)029
       apcbud030 LIKE apcb_t.apcbud030, #自定義欄位(日期時間)030
       apcb052   LIKE apcb_t.apcb052, #稅額
       apcb053   LIKE apcb_t.apcb053, #含稅金額
       apcb054   LIKE apcb_t.apcb054, #帳款對象
       apcb055   LIKE apcb_t.apcb055  #付款對象
          END RECORD

DEFINE l_count       LIKE type_t.num10   
DEFINE l_slip        LIKE type_t.chr10   
DEFINE l_prog        LIKE oobx_t.oobx004
DEFINE p_apgl003     LIKE apgl_t.apgl003
DEFINE p_apdald      LIKE apda_t.apdald
DEFINE p_apdadocno   LIKE apda_t.apdadocno
DEFINE r_success     LIKE type_t.num5
DEFINE l_sql         STRING
DEFINE l_seq         LIKE type_t.num5
DEFINE l_apgl029     LIKE apgl_t.apgl029
DEFINE l_apgl029_2   LIKE apgl_t.apgl029
DEFINE l_pmdsdocno   LIKE pmds_t.pmdsdocno
DEFINE l_do          LIKE type_t.num5

   LET r_success = TRUE   LET l_seq = 0 LET l_do = 0
   #取得LC所屬的收穫\入庫單。
   LET l_sql = " SELECT DISTINCT apgl029 FROM apgl_t  ",
               "  WHERE apglent = '",g_enterprise,"' AND apgl003 = '",p_apgl003,"' ",
               "    AND apglstus = 'Y' "
   PREPARE aapp510_apgl_prep FROM l_sql
   DECLARE aapt510_apgl_curs CURSOR FOR aapp510_apgl_prep
   
   #收貨單所屬的入庫單
   LET l_sql = " SELECT pmdsdocno FROM pmds_t WHERE pmdsent = '",g_enterprise,"' AND pmds006 = ?  "      
   PREPARE aapp510_pmdsdocno_p FROM l_sql
   DECLARE aapp510_pmdsdocno_c CURSOR FOR aapp510_pmdsdocno_p   
   
   LET l_sql = " SELECT  apcbent,apcbld,apcblegl,apcborga,apcbsite,          ",
               "         apcbdocno,apcbseq,apcb001,apcb002,apcb003,          ",
               "         apcb004,apcb005,apcb006,apcb007,apcb008,            ",
               "         apcb009,apcb010,apcb011,apcb012,apcb013,            ",
               "         apcb014,apcb015,apcb016,apcb017,apcb018,            ",
               "         apcb019,apcb020,apcb021,apcb022,apcb023,            ",
               "         apcb024,apcb025,apcb026,apcb027,apcb028,            ",
               "         apcb029,apcb030,apcb032,apcb033,apcb034,            ",
               "         apcb035,apcb036,apcb037,apcb038,apcb039,            ",
               "         apcb040,apcb041,apcb042,apcb043,apcb044,            ",
               "         apcb045,apcb046,apcb047,apcb048,apcb049,            ",
               "         apcb050,apcb051,apcb100,apcb101,apcb102,            ",
               "         apcb103,apcb104,apcb105,apcb106,apcb107,            ",
               "         apcb108,apcb111,apcb113,apcb114,apcb115,            ",
               "         apcb116,apcb117,apcb118,apcb119,apcb121,            ",
               "         apcb123,apcb124,apcb125,apcb126,apcb127,            ",
               "         apcb128,apcb131,apcb133,apcb134,apcb135,            ",
               "         apcb136,apcb137,apcb138,apcbud001,apcbud002,        ",
               "         apcbud003,apcbud004,apcbud005,apcbud006,apcbud007,  ",
               "         apcbud008,apcbud009,apcbud010,apcbud011,apcbud012,  ",
               "         apcbud013,apcbud014,apcbud015,apcbud016,apcbud017,  ",
               "         apcbud018,apcbud019,apcbud020,apcbud021,apcbud022,  ",
               "         apcbud023,apcbud024,apcbud025,apcbud026,apcbud027,  ",
               "         apcbud028,apcbud029,apcbud030,apcb052,apcb053,      ",
               "         apcb054,apcb055                                     ",
               "    FROM apcb_t,apca_t                                       ",
               "   WHERE apcaent = apcbent AND apcbent = '",g_enterprise,"'  ",
               "     AND apcadocno = apcbdocno AND apcb002 = ?               ",
               "     AND apcacomp = '",g_apdacomp,"'                         ",
               "     AND apcastus = 'Y' AND apcb001 IN('11','21')            " 
   PREPARE aapp510_ins_apdc_prep_p  FROM l_sql     
   DECLARE aapp510_ins_apdc_prep_c  CURSOR FOR aapp510_ins_apdc_prep_p   
   FOREACH aapt510_apgl_curs INTO l_apgl029 #收貨/入庫單號
      IF cl_null(l_apgl029) THEN CONTINUE FOREACH END IF
   　 LET l_slip ='' LET l_prog = ''
      CALL s_aooi200_get_slip(l_apgl029) RETURNING g_sub_success,l_slip #取得單號所屬單別
      #判斷單別是收貨單還是入庫單
      SELECT oobx004 INTO l_prog FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
      IF l_prog MATCHES 'apmt52*' THEN #收貨
         #抓取入庫單  /可能有多張入庫單       
         LET l_apgl029_2 = ''
         FOREACH aapp510_pmdsdocno_c USING l_apgl029 INTO l_apgl029_2            
            FOREACH aapp510_ins_apdc_prep_c USING l_apgl029_2 INTO l_apcb.apcbent,l_apcb.apcbld,l_apcb.apcblegl,l_apcb.apcborga,l_apcb.apcbsite, 
                                                         l_apcb.apcbdocno,l_apcb.apcbseq,l_apcb.apcb001,l_apcb.apcb002,l_apcb.apcb003,
                                                         l_apcb.apcb004,l_apcb.apcb005,l_apcb.apcb006,l_apcb.apcb007,l_apcb.apcb008,
                                                         l_apcb.apcb009,l_apcb.apcb010,l_apcb.apcb011,l_apcb.apcb012,l_apcb.apcb013,
                                                         l_apcb.apcb014,l_apcb.apcb015,l_apcb.apcb016,l_apcb.apcb017,l_apcb.apcb018,
                                                         l_apcb.apcb019,l_apcb.apcb020,l_apcb.apcb021,l_apcb.apcb022,l_apcb.apcb023,
                                                         l_apcb.apcb024,l_apcb.apcb025,l_apcb.apcb026,l_apcb.apcb027,l_apcb.apcb028,
                                                         l_apcb.apcb029,l_apcb.apcb030,l_apcb.apcb032,l_apcb.apcb033,l_apcb.apcb034,
                                                         l_apcb.apcb035,l_apcb.apcb036,l_apcb.apcb037,l_apcb.apcb038,l_apcb.apcb039,
                                                         l_apcb.apcb040,l_apcb.apcb041,l_apcb.apcb042,l_apcb.apcb043,l_apcb.apcb044,
                                                         l_apcb.apcb045,l_apcb.apcb046,l_apcb.apcb047,l_apcb.apcb048,l_apcb.apcb049,
                                                         l_apcb.apcb050,l_apcb.apcb051,l_apcb.apcb100,l_apcb.apcb101,l_apcb.apcb102,
                                                         l_apcb.apcb103,l_apcb.apcb104,l_apcb.apcb105,l_apcb.apcb106,l_apcb.apcb107,
                                                         l_apcb.apcb108,l_apcb.apcb111,l_apcb.apcb113,l_apcb.apcb114,l_apcb.apcb115,
                                                         l_apcb.apcb116,l_apcb.apcb117,l_apcb.apcb118,l_apcb.apcb119,l_apcb.apcb121,
                                                         l_apcb.apcb123,l_apcb.apcb124,l_apcb.apcb125,l_apcb.apcb126,l_apcb.apcb127,
                                                         l_apcb.apcb128,l_apcb.apcb131,l_apcb.apcb133,l_apcb.apcb134,l_apcb.apcb135,
                                                         l_apcb.apcb136,l_apcb.apcb137,l_apcb.apcb138,l_apcb.apcbud001,l_apcb.apcbud002,
                                                         l_apcb.apcbud003,l_apcb.apcbud004,l_apcb.apcbud005,l_apcb.apcbud006,l_apcb.apcbud007,
                                                         l_apcb.apcbud008,l_apcb.apcbud009,l_apcb.apcbud010,l_apcb.apcbud011,l_apcb.apcbud012,
                                                         l_apcb.apcbud013,l_apcb.apcbud014,l_apcb.apcbud015,l_apcb.apcbud016,l_apcb.apcbud017,
                                                         l_apcb.apcbud018,l_apcb.apcbud019,l_apcb.apcbud020,l_apcb.apcbud021,l_apcb.apcbud022,
                                                         l_apcb.apcbud023,l_apcb.apcbud024,l_apcb.apcbud025,l_apcb.apcbud026,l_apcb.apcbud027,
                                                         l_apcb.apcbud028,l_apcb.apcbud029,l_apcb.apcbud030,l_apcb.apcb052,l_apcb.apcb053,
                                                         l_apcb.apcb054,l_apcb.apcb055            
            LET l_seq = l_seq + 1
            IF cl_null(l_apcb.apcbdocno) THEN CONTINUE FOREACH END IF 
	         #交易單據+項次所對應的pmdu_t(多庫儲批收貨明細檔),其中的庫位,必須至少有一個為成本倉,才可以做分攤(看aini001)       
            INITIALIZE l_apdc.* TO NULL          
            LET l_apdc.apdcent   = g_enterprise      #企業編號
            LET l_apdc.apdccomp  = g_apdacomp        #法人
            LET l_apdc.apdcsite  = g_master.apdasite #帳務組織
            LET l_apdc.apdcld    = p_apdald          #帳套
            LET l_apdc.apdcdocno = p_apdadocno       #攤銷單號
            LET l_apdc.apdcseq   = l_seq             #攤銷單項次
            LET l_apdc.apdcorga  = l_apcb.apcborga   #來源歸屬組織
            LET l_apdc.apdc002 =  l_apcb.apcb002     #交易單號(入庫單)
            LET l_apdc.apdc003 =  l_apcb.apcb003     #交易單項次
            LET l_apdc.apdc004 =  l_apcb.apcb004     #產品編號
            LET l_apdc.apdc005 =  l_apcb.apcbdocno   #目的帳款單號
            LET l_apdc.apdc006 =  l_apcb.apcbseq     #目的帳款單項次
            LET l_apdc.apdc007 =  l_apcb.apcb021     #目的會計科目
            LET l_apdc.apdc008 =  l_apcb.apcb007     #數量
            LET l_apdc.apdc111 =  l_apcb.apcb111     #本幣分攤前單價
            LET l_apdc.apdc113 =  l_apcb.apcb113     #本幣分攤前金額
            LET l_apdc.apdc211 =  0                  #本幣分攤後單價
            LET l_apdc.apdc213 =  0                  #本幣分攤後金額
            LET l_apdc.apdc123 =  l_apcb.apcb123     #本位幣二分攤前金額
            LET l_apdc.apdc223 =  0                  #本位幣二分攤後金額
            LET l_apdc.apdc133 =  l_apcb.apcb133     #本位幣三分攤前金額
            LET l_apdc.apdc233 =  0                  #本位幣三分攤後金額
            LET l_apdc.apdc017 =  l_apcb.apcb051     #業務人員
            LET l_apdc.apdc018 =  l_apcb.apcb010    #業務部門
            LET l_apdc.apdc019 =  l_apcb.apcb011    #責任中心
            LET l_apdc.apdc020 =  l_apcb.apcb012    #產品類別
            LET l_apdc.apdc022 =  l_apcb.apcb015    #專案編號
            LET l_apdc.apdc023 =  l_apcb.apcb016    #WBS編號
            LET l_apdc.apdc024 =  l_apcb.apcb024    #區域
            LET l_apdc.apdc027 = l_apcb.apcb033     #經營方式
            LET l_apdc.apdc028 = l_apcb.apcb034     #渠道
            LET l_apdc.apdc029 = l_apcb.apcb035     #品牌
            LET l_apdc.apdc031 = l_apcb.apcb037     #自由核算項一
            LET l_apdc.apdc032 = l_apcb.apcb038     #自由核算項二
            LET l_apdc.apdc033 = l_apcb.apcb039     #自由核算項三
            LET l_apdc.apdc034 = l_apcb.apcb040     #自由核算項四
            LET l_apdc.apdc035 = l_apcb.apcb041     #自由核算項五
            LET l_apdc.apdc036 = l_apcb.apcb042     #自由核算項六
            LET l_apdc.apdc037 = l_apcb.apcb043     #自由核算項七
            LET l_apdc.apdc038 = l_apcb.apcb044     #自由核算項八
            LET l_apdc.apdc039 = l_apcb.apcb045     #自由核算項九   
            LET l_apdc.apdc040 = l_apcb.apcb046     #自由核算項十
            LET l_apdc.apdc041 = l_apcb.apcb047     #摘要說明
            
            INSERT INTO apdc_t
                       (apdcent,apdcld,apdcdocno,apdcseq,
                        apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,
                        apdc009,apdc111,apdc113,apdc211,apdc213,apdc123,
                        apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,
                        apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,
                        apdc022,apdc023,apdc024,apdc025,apdc027,apdc028,
                        apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,
                        apdc036,apdc037,apdc038,apdc039,apdc040,apdccomp,apdcsite) 
                 VALUES(g_enterprise,p_apdald,p_apdadocno,l_apdc.apdcseq,
                        l_apdc.apdc001,l_apdc.apdcorga,l_apdc.apdc002,l_apdc.apdc003,l_apdc.apdc004,l_apdc.apdc008, 
                        l_apdc.apdc009,l_apdc.apdc111,l_apdc.apdc113,l_apdc.apdc211,l_apdc.apdc213,l_apdc.apdc123, 
                        l_apdc.apdc223,l_apdc.apdc133,l_apdc.apdc233,l_apdc.apdc005,l_apdc.apdc006,l_apdc.apdc041, 
                        l_apdc.apdc015,l_apdc.apdc007,l_apdc.apdc017,l_apdc.apdc018,l_apdc.apdc019,l_apdc.apdc020, 
                        l_apdc.apdc022,l_apdc.apdc023,l_apdc.apdc024,l_apdc.apdc025,l_apdc.apdc027,l_apdc.apdc028, 
                        l_apdc.apdc029,l_apdc.apdc031,l_apdc.apdc032,l_apdc.apdc033,l_apdc.apdc034,l_apdc.apdc035, 
                        l_apdc.apdc036,l_apdc.apdc037,l_apdc.apdc038,l_apdc.apdc039,l_apdc.apdc040,l_apdc.apdccomp,l_apdc.apdcsite)
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.SQLCODE
                  LET g_errparam.extend = "apdc_t "
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET r_success = FALSE
                  RETURN r_success
               END IF               
            END FOREACH
            LET l_do = l_do+1
         END FOREACH      
      ELSE
         LET l_pmdsdocno = l_apgl029      #入庫單
         FOREACH aapp510_ins_apdc_prep_c USING l_apgl029 INTO l_apcb.apcbent,l_apcb.apcbld,l_apcb.apcblegl,l_apcb.apcborga,l_apcb.apcbsite, 
                                                         l_apcb.apcbdocno,l_apcb.apcbseq,l_apcb.apcb001,l_apcb.apcb002,l_apcb.apcb003,
                                                         l_apcb.apcb004,l_apcb.apcb005,l_apcb.apcb006,l_apcb.apcb007,l_apcb.apcb008,
                                                         l_apcb.apcb009,l_apcb.apcb010,l_apcb.apcb011,l_apcb.apcb012,l_apcb.apcb013,
                                                         l_apcb.apcb014,l_apcb.apcb015,l_apcb.apcb016,l_apcb.apcb017,l_apcb.apcb018,
                                                         l_apcb.apcb019,l_apcb.apcb020,l_apcb.apcb021,l_apcb.apcb022,l_apcb.apcb023,
                                                         l_apcb.apcb024,l_apcb.apcb025,l_apcb.apcb026,l_apcb.apcb027,l_apcb.apcb028,
                                                         l_apcb.apcb029,l_apcb.apcb030,l_apcb.apcb032,l_apcb.apcb033,l_apcb.apcb034,
                                                         l_apcb.apcb035,l_apcb.apcb036,l_apcb.apcb037,l_apcb.apcb038,l_apcb.apcb039,
                                                         l_apcb.apcb040,l_apcb.apcb041,l_apcb.apcb042,l_apcb.apcb043,l_apcb.apcb044,
                                                         l_apcb.apcb045,l_apcb.apcb046,l_apcb.apcb047,l_apcb.apcb048,l_apcb.apcb049,
                                                         l_apcb.apcb050,l_apcb.apcb051,l_apcb.apcb100,l_apcb.apcb101,l_apcb.apcb102,
                                                         l_apcb.apcb103,l_apcb.apcb104,l_apcb.apcb105,l_apcb.apcb106,l_apcb.apcb107,
                                                         l_apcb.apcb108,l_apcb.apcb111,l_apcb.apcb113,l_apcb.apcb114,l_apcb.apcb115,
                                                         l_apcb.apcb116,l_apcb.apcb117,l_apcb.apcb118,l_apcb.apcb119,l_apcb.apcb121,
                                                         l_apcb.apcb123,l_apcb.apcb124,l_apcb.apcb125,l_apcb.apcb126,l_apcb.apcb127,
                                                         l_apcb.apcb128,l_apcb.apcb131,l_apcb.apcb133,l_apcb.apcb134,l_apcb.apcb135,
                                                         l_apcb.apcb136,l_apcb.apcb137,l_apcb.apcb138,l_apcb.apcbud001,l_apcb.apcbud002,
                                                         l_apcb.apcbud003,l_apcb.apcbud004,l_apcb.apcbud005,l_apcb.apcbud006,l_apcb.apcbud007,
                                                         l_apcb.apcbud008,l_apcb.apcbud009,l_apcb.apcbud010,l_apcb.apcbud011,l_apcb.apcbud012,
                                                         l_apcb.apcbud013,l_apcb.apcbud014,l_apcb.apcbud015,l_apcb.apcbud016,l_apcb.apcbud017,
                                                         l_apcb.apcbud018,l_apcb.apcbud019,l_apcb.apcbud020,l_apcb.apcbud021,l_apcb.apcbud022,
                                                         l_apcb.apcbud023,l_apcb.apcbud024,l_apcb.apcbud025,l_apcb.apcbud026,l_apcb.apcbud027,
                                                         l_apcb.apcbud028,l_apcb.apcbud029,l_apcb.apcbud030,l_apcb.apcb052,l_apcb.apcb053,
                                                         l_apcb.apcb054,l_apcb.apcb055
         
            LET l_seq = l_seq + 1
            IF cl_null(l_apcb.apcbdocno) THEN CONTINUE FOREACH END IF 
	         #交易單據+項次所對應的pmdu_t(多庫儲批收貨明細檔),其中的庫位,必須至少有一個為成本倉,才可以做分攤(看aini001)       
            INITIALIZE l_apdc.* TO NULL          
            LET l_apdc.apdcent   = g_enterprise      #企業編號
            LET l_apdc.apdccomp  = g_apdacomp        #法人
            LET l_apdc.apdcsite  = g_master.apdasite #帳務組織
            LET l_apdc.apdcld    = p_apdald          #帳套
            LET l_apdc.apdcdocno = p_apdadocno       #攤銷單號
            LET l_apdc.apdcseq   = l_seq             #攤銷單項次
            LET l_apdc.apdcorga  = l_apcb.apcborga   #來源歸屬組織
            LET l_apdc.apdc002 =  l_apcb.apcb002     #交易單號(入庫單)
            LET l_apdc.apdc003 =  l_apcb.apcb003     #交易單項次
            LET l_apdc.apdc004 =  l_apcb.apcb004     #產品編號
            LET l_apdc.apdc005 =  l_apcb.apcbdocno   #目的帳款單號
            LET l_apdc.apdc006 =  l_apcb.apcbseq     #目的帳款單項次
            LET l_apdc.apdc007 =  l_apcb.apcb021     #目的會計科目
            LET l_apdc.apdc008 =  l_apcb.apcb007     #數量
            LET l_apdc.apdc111 =  l_apcb.apcb111     #本幣分攤前單價
            LET l_apdc.apdc113 =  l_apcb.apcb113     #本幣分攤前金額
            LET l_apdc.apdc211 =  0                  #本幣分攤後單價
            LET l_apdc.apdc213 =  0                  #本幣分攤後金額
            LET l_apdc.apdc123 =  l_apcb.apcb123     #本位幣二分攤前金額
            LET l_apdc.apdc223 =  0                  #本位幣二分攤後金額
            LET l_apdc.apdc133 =  l_apcb.apcb133     #本位幣三分攤前金額
            LET l_apdc.apdc233 =  0                  #本位幣三分攤後金額
            LET l_apdc.apdc017 =  l_apcb.apcb051     #業務人員
            LET l_apdc.apdc018 =  l_apcb.apcb010    #業務部門
            LET l_apdc.apdc019 =  l_apcb.apcb011    #責任中心
            LET l_apdc.apdc020 =  l_apcb.apcb012    #產品類別
            LET l_apdc.apdc022 =  l_apcb.apcb015    #專案編號
            LET l_apdc.apdc023 =  l_apcb.apcb016    #WBS編號
            LET l_apdc.apdc024 =  l_apcb.apcb024    #區域
            LET l_apdc.apdc027 = l_apcb.apcb033     #經營方式
            LET l_apdc.apdc028 = l_apcb.apcb034     #渠道
            LET l_apdc.apdc029 = l_apcb.apcb035     #品牌
            LET l_apdc.apdc031 = l_apcb.apcb037     #自由核算項一
            LET l_apdc.apdc032 = l_apcb.apcb038     #自由核算項二
            LET l_apdc.apdc033 = l_apcb.apcb039     #自由核算項三
            LET l_apdc.apdc034 = l_apcb.apcb040     #自由核算項四
            LET l_apdc.apdc035 = l_apcb.apcb041     #自由核算項五
            LET l_apdc.apdc036 = l_apcb.apcb042     #自由核算項六
            LET l_apdc.apdc037 = l_apcb.apcb043     #自由核算項七
            LET l_apdc.apdc038 = l_apcb.apcb044     #自由核算項八
            LET l_apdc.apdc039 = l_apcb.apcb045     #自由核算項九   
            LET l_apdc.apdc040 = l_apcb.apcb046     #自由核算項十
            LET l_apdc.apdc041 = l_apcb.apcb047     #摘要說明
            
            INSERT INTO apdc_t
                       (apdcent,apdcld,apdcdocno,apdcseq,
                        apdc001,apdcorga,apdc002,apdc003,apdc004,apdc008,
                        apdc009,apdc111,apdc113,apdc211,apdc213,apdc123,
                        apdc223,apdc133,apdc233,apdc005,apdc006,apdc041,
                        apdc015,apdc007,apdc017,apdc018,apdc019,apdc020,
                        apdc022,apdc023,apdc024,apdc025,apdc027,apdc028,
                        apdc029,apdc031,apdc032,apdc033,apdc034,apdc035,
                        apdc036,apdc037,apdc038,apdc039,apdc040,apdccomp,apdcsite) 
                 VALUES(g_enterprise,p_apdald,p_apdadocno,l_apdc.apdcseq,
                        l_apdc.apdc001,l_apdc.apdcorga,l_apdc.apdc002,l_apdc.apdc003,l_apdc.apdc004,l_apdc.apdc008, 
                        l_apdc.apdc009,l_apdc.apdc111,l_apdc.apdc113,l_apdc.apdc211,l_apdc.apdc213,l_apdc.apdc123, 
                        l_apdc.apdc223,l_apdc.apdc133,l_apdc.apdc233,l_apdc.apdc005,l_apdc.apdc006,l_apdc.apdc041, 
                        l_apdc.apdc015,l_apdc.apdc007,l_apdc.apdc017,l_apdc.apdc018,l_apdc.apdc019,l_apdc.apdc020, 
                        l_apdc.apdc022,l_apdc.apdc023,l_apdc.apdc024,l_apdc.apdc025,l_apdc.apdc027,l_apdc.apdc028, 
                        l_apdc.apdc029,l_apdc.apdc031,l_apdc.apdc032,l_apdc.apdc033,l_apdc.apdc034,l_apdc.apdc035, 
                        l_apdc.apdc036,l_apdc.apdc037,l_apdc.apdc038,l_apdc.apdc039,l_apdc.apdc040,l_apdc.apdccomp,l_apdc.apdcsite)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.extend = "apdc_t "
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF               
            LET l_do = l_do+1
         END FOREACH
      END IF      
   END FOREACH
   
   IF l_do = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adb-00058' #無來源資料或資料未確認!
      LET g_errparam.extend = "apdc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success 
   END IF

   RETURN r_success                



END FUNCTION

################################################################################
# Descriptions...: 重新計算
# Memo...........:
# Usage..........: CALL aapp510_apce_apdc_balance(p_apdadocno)
# Date & Author..: 2017/01/23 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp510_apce_apdc_balance(p_apdadocno)
DEFINE p_apdadocno   LIKE apda_t.apdadocno
DEFINE l_apdc        RECORD
         apdcseq     LIKE apdc_t.apdcseq,
         apdc002     LIKE apdc_t.apdc002,
         apdc008     LIKE apdc_t.apdc008,
         apdc015     LIKE apdc_t.apdc015, #借/貸
         apdc113     LIKE apdc_t.apdc113,
         apdc123     LIKE apdc_t.apdc123,
         apdc133     LIKE apdc_t.apdc133
                     END RECORD
DEFINE l_sql         STRING
DEFINE l_i           LIKE type_t.num10
DEFINE l_count       LIKE type_t.num10
DEFINE l_apdc008_sum LIKE apdc_t.apdc008
DEFINE l_apdc113_sum LIKE apdc_t.apdc113
DEFINE l_apdc123_sum LIKE apdc_t.apdc123
DEFINE l_apdc133_sum LIKE apdc_t.apdc133
DEFINE l_apdc113_max LIKE apdc_t.apdc113
DEFINE l_apdc123_max LIKE apdc_t.apdc123
DEFINE l_apdc133_max LIKE apdc_t.apdc133
DEFINE l_apdcseq_max LIKE apdc_t.apdcseq
DEFINE l_apda113_sum LIKE apda_t.apda113
DEFINE l_apda123_sum LIKE apda_t.apda123
DEFINE l_apda133_sum LIKE apda_t.apda133
DEFINE l_apdc211     LIKE apdc_t.apdc211
DEFINE l_apdc213     LIKE apdc_t.apdc213
DEFINE l_apdc223     LIKE apdc_t.apdc223
DEFINE l_apdc233     LIKE apdc_t.apdc233
DEFINE l_apdc213_sum LIKE apdc_t.apdc213
DEFINE l_apdc223_sum LIKE apdc_t.apdc223
DEFINE l_apdc233_sum LIKE apdc_t.apdc233
DEFINE l_pmds037     LIKE pmds_t.pmds037 #來源單據的幣別
DEFINE l_diff        LIKE type_t.num20_6
DEFINE r_success     LIKE type_t.num5
DEFINE l_do_diff     LIKE type_t.chr1

   LET r_success = TRUE
   
   #項次/數量/本幣分攤前金額/本位幣二分攤前金額/本位幣三分攤前金額
   LET l_sql = " SELECT apdcseq,apdc002,apdc008,apdc015",
               "       ,apdc113,apdc123,apdc133",
               "   FROM apdc_t ",
               "  WHERE apdcent = ",g_enterprise,
               "    AND apdcld = '",g_master.apdald,"'",
               "    AND apdcdocno = '",p_apdadocno,"' "
   PREPARE sel_aapp430_apdcp2 FROM l_sql
   DECLARE sel_aapp430_apdcc2 CURSOR FOR sel_aapp430_apdcp2
   LET l_apdc008_sum = 0
   LET l_apdc113_sum = 0
   LET l_apdc123_sum = 0
   LET l_apdc133_sum = 0
   FOREACH sel_aapp430_apdcc2 INTO l_apdc.apdcseq,l_apdc.apdc002,l_apdc.apdc008,l_apdc.apdc015,l_apdc.apdc113,
                                   l_apdc.apdc123,l_apdc.apdc133

      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      IF cl_null(l_apdc.apdc113)THEN LET l_apdc.apdc113 = 0 END IF
      IF cl_null(l_apdc.apdc123)THEN LET l_apdc.apdc123 = 0 END IF
      IF cl_null(l_apdc.apdc133)THEN LET l_apdc.apdc133 = 0 END IF
      #統計分攤前總金額
      LET l_apdc113_sum = l_apdc113_sum + l_apdc.apdc113
      LET l_apdc123_sum = l_apdc123_sum + l_apdc.apdc123
      LET l_apdc133_sum = l_apdc133_sum + l_apdc.apdc133
      #統計分攤前總數量
      LET l_apdc008_sum = l_apdc008_sum + l_apdc.apdc008
   END FOREACH
   
   #統計本幣分攤金額(改取單頭的錢)
   SELECT apda113,apda123,apda133 INTO l_apda113_sum,l_apda123_sum,l_apda133_sum
     FROM apda_t
    WHERE apdaent = g_enterprise AND apdadocno = p_apdadocno AND apdald = g_master.apdald
   IF cl_null(l_apda113_sum)THEN LET l_apda113_sum = 0 END IF
   IF cl_null(l_apda123_sum)THEN LET l_apda123_sum = 0 END IF
   IF cl_null(l_apda133_sum)THEN LET l_apda133_sum = 0 END IF
   IF l_apda113_sum = 0 AND l_apda123_sum= 0 AND l_apda133_sum = 0 THEN
      RETURN r_success
   END IF

   #統計有幾筆要作分攤
   SELECT COUNT(*) INTO l_count
     FROM apdc_t
    WHERE apdcent = g_enterprise
      AND apdcld = g_master.apdald
      AND apdcdocno = p_apdadocno
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   
   LET l_apdc113_max = 0
   LET l_apdc123_max = 0
   LET l_apdc133_max = 0
   
   LET l_sql = " SELECT apdcseq,apdc002,apdc008,apdc015",
               "       ,apdc113,apdc123,apdc133",
               "   FROM apdc_t ",
               "  WHERE apdcent = ",g_enterprise,
               "    AND apdcld  = '",g_master.apdald,"' ",
               "    AND apdcdocno = '",p_apdadocno,"' ",
               "  ORDER BY apdc113 DESC"
   PREPARE sel_aapp430_apdcp3 FROM l_sql
   DECLARE sel_aapp430_apdcc3 CURSOR FOR sel_aapp430_apdcp3
   LET l_i = 1
   #FOREACH sel_aapp430_apdcc3 INTO l_apdc.* #161208-00026#2 mark
   #161208-00026#2-add(s)
   FOREACH sel_aapp430_apdcc3 INTO l_apdc.apdcseq,l_apdc.apdc002,l_apdc.apdc008,l_apdc.apdc015,l_apdc.apdc113,
                                   l_apdc.apdc123,l_apdc.apdc133
      #取得來源單據的幣別
      SELECT pmds037 INTO l_pmds037
        FROM pmds_t
       WHERE pmdsent = g_enterprise
         AND pmdsdocno = l_apdc.apdc002
   
      CASE g_master.apda020
         WHEN "1" #1:依金額比例分攤
            LET l_apdc213 = l_apdc.apdc113 + l_apda113_sum * (l_apdc.apdc113 / l_apdc113_sum)
            LET l_apdc223 = l_apdc.apdc123 + l_apda123_sum * (l_apdc.apdc123 / l_apdc123_sum)
            LET l_apdc233 = l_apdc.apdc133 + l_apda133_sum * (l_apdc.apdc133 / l_apdc133_sum)

         WHEN "2" #2:依數量比例分攤
            LET l_apdc213 = l_apdc.apdc113 + l_apda113_sum * (l_apdc.apdc008 / l_apdc008_sum)
            LET l_apdc223 = l_apdc.apdc123 + l_apda123_sum * (l_apdc.apdc008 / l_apdc008_sum)
            LET l_apdc233 = l_apdc.apdc133 + l_apda133_sum * (l_apdc.apdc008 / l_apdc008_sum)
            
         WHEN "0" #0:平均分攤
            LET l_apdc213 = l_apdc.apdc113 + (l_apda113_sum / l_count)
            LET l_apdc223 = l_apdc.apdc123 + (l_apda123_sum / l_count)
            LET l_apdc233 = l_apdc.apdc133 + (l_apda133_sum / l_count)
      END CASE
      #取位
      CALL s_curr_round_ld('1',g_master.apdald,l_pmds037,l_apdc213,2) RETURNING g_sub_success,g_errno,l_apdc213
      CALL s_curr_round_ld('1',g_master.apdald,l_pmds037,l_apdc223,2) RETURNING g_sub_success,g_errno,l_apdc223
      CALL s_curr_round_ld('1',g_master.apdald,l_pmds037,l_apdc233,2) RETURNING g_sub_success,g_errno,l_apdc233
      
      #重新計算分攤後單價
      LET l_apdc211 = l_apdc213 / l_apdc.apdc008

      CALL s_curr_round_ld('1',g_master.apdald,l_pmds037,l_apdc211,1) RETURNING g_sub_success,g_errno,l_apdc211
      
      IF cl_null(l_apdc213) THEN LET l_apdc213 = 0 END IF
      IF cl_null(l_apdc223) THEN LET l_apdc223 = 0 END IF
      IF cl_null(l_apdc233) THEN LET l_apdc233 = 0 END IF
      IF cl_null(l_apdc211) THEN LET l_apdc211 = 0 END IF
      
      #若金額小於零，要做借貸相反處理
      IF (l_apdc213-l_apdc.apdc113) < 0 THEN
         LET l_apdc.apdc015 = 'C'
      ELSE
         LET l_apdc.apdc015 = 'D'
      END IF
      
      UPDATE apdc_t SET apdc213 = l_apdc213
                       ,apdc223 = l_apdc223
                       ,apdc233 = l_apdc233
                       ,apdc211 = l_apdc211
                       ,apdc015 = l_apdc.apdc015
       WHERE apdcent = g_enterprise
         AND apdcld = g_master.apdald
         AND apdcdocno = p_apdadocno
         AND apdcseq = l_apdc.apdcseq
      
      #紀錄金額最大的那一筆(尾差處理用)
      IF l_i = 1 THEN
         LET l_apdc113_max = l_apdc213
         LET l_apdc123_max = l_apdc223
         LET l_apdc133_max = l_apdc233
         LET l_apdcseq_max = l_apdc.apdcseq
      END IF
      LET l_i = l_i + 1
   END FOREACH

   #尾差處理
   #取得攤完之後的總額
   SELECT SUM(apdc213),SUM(apdc223),SUM(apdc233)
     INTO l_apdc213_sum,l_apdc223_sum,l_apdc233_sum
     FROM apdc_t
    WHERE apdcent = g_enterprise
      AND apdcld = g_master.apdald
      AND apdcdocno = p_apdadocno
   IF cl_null(l_apdc213_sum)THEN LET l_apdc213_sum = 0 END IF
   IF cl_null(l_apdc223_sum)THEN LET l_apdc223_sum = 0 END IF
   IF cl_null(l_apdc233_sum)THEN LET l_apdc233_sum = 0 END IF
   #計算有無尾差
   LET l_diff = 0
   LET l_do_diff = "N"
   
   IF (l_apdc113_sum + l_apda113_sum) <> l_apdc213_sum THEN
      LET l_diff = (l_apdc113_sum + l_apda113_sum) - l_apdc213_sum
      LET l_apdc213 = l_apdc113_max + l_diff
      LET l_do_diff = "Y"
   END IF
   IF (l_apdc123_sum + l_apda123_sum) <> l_apdc223_sum THEN
      LET l_diff = (l_apdc123_sum + l_apda123_sum) - l_apdc223_sum
      LET l_apdc223 = l_apdc123_max + l_diff
      LET l_do_diff = "Y"
   END IF
   IF (l_apdc133_sum + l_apda133_sum) <> l_apdc233_sum THEN
      LET l_diff = (l_apdc133_sum + l_apda133_sum) - l_apdc233_sum
      LET l_apdc233 = l_apdc133_max + l_diff
      LET l_do_diff = "Y"
   END IF

   IF l_do_diff = "Y" THEN
      UPDATE apdc_t SET apdc213 = l_apdc213
                       ,apdc223 = l_apdc223
                       ,apdc233 = l_apdc233
       WHERE apdcent = g_enterprise
         AND apdcld = g_master.apdald
         AND apdcdocno = p_apdadocno
         AND apdcseq = l_apdcseq_max
   END IF
   RETURN r_success
END FUNCTION

#end add-point
 
{</section>}
 
