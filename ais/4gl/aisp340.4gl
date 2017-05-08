#該程式未解開Section, 採用最新樣板產出!
{<section id="aisp340.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-03-03 17:03:20), PR版次:0002(2016-10-21 10:34:01)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: aisp340
#+ Description: RMA覆出單批次發票開立作業
#+ Creator....: 06821(2016-03-03 16:16:53)
#+ Modifier...: 06821 -SD/PR- 04152
 
{</section>}
 
{<section id="aisp340.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#161006-00005#26  2016/10/21 By Reanna      帳務中心(xrcasite)開窗改用q_ooef001_46()
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
   l_xrcasite   LIKE type_t.chr10, 
   l_xrcald     LIKE type_t.chr5,  
   l_xrcacomp   LIKE type_t.chr10, 
   l_xmdk015    LIKE type_t.chr2, 
   l_curr_type  LIKE type_t.chr500, 
   l_slip1      LIKE type_t.chr500, 
   l_docdt      LIKE type_t.dat, 
   l_toaistype  LIKE type_t.chr10, 
   l_site       LIKE type_t.chr10, 
   l_book       LIKE type_t.chr500, 
   l_dat_memo   LIKE type_t.dat, 
   l_isaf010    LIKE type_t.chr20, 
   l_limit_memo LIKE type_t.num20_6, 
   l_isaf011    LIKE type_t.chr20, 
   l_slip2      LIKE type_t.chr500,  
   l_xrca063    LIKE type_t.chr20,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
DEFINE g_wc              STRING
 
PRIVATE TYPE type_master RECORD
       l_xrcasite LIKE type_t.chr10, 
   l_xrcasite_desc LIKE type_t.chr80, 
   l_xrcald LIKE type_t.chr5, 
   l_xrcald_desc LIKE type_t.chr80, 
   l_xrcacomp LIKE type_t.chr10, 
   l_xmdk015 LIKE type_t.chr2, 
   l_xmdk015_desc LIKE type_t.chr80, 
   l_curr_type LIKE type_t.chr500, 
   l_slip1 LIKE type_t.chr500, 
   l_slip1_desc LIKE type_t.chr80, 
   l_docdt LIKE type_t.dat, 
   l_toaistype LIKE type_t.chr10, 
   l_site LIKE type_t.chr10, 
   l_site_desc LIKE type_t.chr80, 
   l_book LIKE type_t.chr500, 
   l_dat_memo LIKE type_t.dat, 
   l_isaf010 LIKE type_t.chr20, 
   l_limit_memo LIKE type_t.num20_6, 
   l_isaf011 LIKE type_t.chr20, 
   l_slip2 LIKE type_t.chr500, 
   l_slip2_desc LIKE type_t.chr80, 
   l_xrca063 LIKE type_t.chr20, 
   rmdadocno LIKE type_t.chr20, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_glaald       LIKE glaa_t.glaald
DEFINE g_ooef019      LIKE ooef_t.ooef019
                      
DEFINE g_rmda         RECORD
        rmba000       LIKE rmba_t.rmba000,  #版本
        rmba009       LIKE rmba_t.rmba009,  #發票類型
        rmba011       LIKE rmba_t.rmba011,  #匯率
        rmdasite      LIKE rmda_t.rmdasite, #組織
        rmda001       LIKE rmda_t.rmda001,  #扣帳日期
        rmda007       LIKE rmda_t.rmda007   #收款客戶
                      END RECORD
DEFINE g_isai002      LIKE isai_t.isai002
DEFINE g_isai008      LIKE isai_t.isai008
DEFINE g_isao014      LIKE isao_t.isao014   #慣用發票單別
DEFINE g_master_o     type_master
DEFINE g_wc_xrcasite  STRING                #帳務組織條件
DEFINE g_wc_xrcald    STRING
DEFINE g_rmdadocno    LIKE rmda_t.rmdadocno #隨貨附發票時外部呼叫時的出貨單號
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"
           
#end add-point
 
{</section>}
 
{<section id="aisp340.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
 
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      CALL s_fin_create_account_center_tmp()                   #展組織下階成員所需之暫存檔
      CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success
      CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success      
      #end add-point
      CALL aisp340_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisp340 WITH FORM cl_ap_formpath("ais",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aisp340_init()
 
      #進入選單 Menu (="N")
      CALL aisp340_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aisp340
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aisp340.init" >}
#+ 初始化作業
PRIVATE FUNCTION aisp340_init()
 
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
   CALL cl_set_combo_scc('l_curr_type','9951')  #匯率
   CALL cl_set_combo_scc('l_toaistype','9749')  #發票明細
   CALL s_fin_create_account_center_tmp()       #展組織下階成員所需之暫存檔
   CALL s_voucher_cre_ar_tmp_table() RETURNING g_sub_success
   CALL s_aooi390_cre_tmp_table() RETURNING g_sub_success
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aisp340.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aisp340_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_glaa024     LIKE glaa_t.glaa024
   DEFINE l_comp        LIKE ooef_t.ooef001
   DEFINE l_isae007     LIKE isae_t.isae007
   DEFINE l_isae008     LIKE isae_t.isae008
   DEFINE l_isae012     LIKE isae_t.isae012
   DEFINE l_prog        LIKE type_t.chr20
   DEFINE l_oofg_return DYNAMIC ARRAY OF RECORD #呼叫aooi390
          oofg019       LIKE oofg_t.oofg019,    #field
          oofg020       LIKE oofg_t.oofg020     #value
                        END RECORD
   DEFINE l_count       LIKE type_t.num10
   DEFINE l_tran        RECORD
                        wc   STRING
                        END RECORD
   DEFINE l_ctl_where   STRING
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aisp340_qbeclear()
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.l_xrcasite,g_master.l_xrcald,g_master.l_xrcacomp,g_master.l_xmdk015, 
             g_master.l_curr_type,g_master.l_slip1,g_master.l_docdt,g_master.l_toaistype,g_master.l_site, 
             g_master.l_book,g_master.l_dat_memo,g_master.l_isaf010,g_master.l_limit_memo,g_master.l_isaf011, 
             g_master.l_slip2,g_master.l_xrca063 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcasite
            
            #add-point:AFTER FIELD l_xrcasite name="input.a.l_xrcasite"
            IF NOT cl_null(g_master.l_xrcasite)THEN
               IF (g_master.l_xrcasite <> g_master_o.l_xrcasite) OR (g_master_o.l_xrcasite IS NULL) THEN
                  CALL s_fin_account_center_sons_query('3',g_master.l_xrcasite,g_today,'1')          
                  CALL s_fin_account_center_with_ld_chk(g_master.l_xrcasite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.l_xrcasite = g_master_o.l_xrcasite
                     CALL s_desc_get_department_desc(g_master.l_xrcasite) RETURNING g_master.l_xrcasite_desc
                     DISPLAY BY NAME g_master.l_xrcasite,g_master.l_xrcasite_desc
                     NEXT FIELD l_xrcasite
                  END IF
                  
                  CALL s_fin_orga_get_comp_ld(g_master.l_xrcasite) RETURNING g_sub_success,g_errno,g_master.l_xrcacomp,g_master.l_xrcald
                  SELECT ooef019 INTO g_ooef019 FROM ooef_t
                   WHERE ooefent =g_enterprise
                     AND ooef001 = g_master.l_xrcacomp
                  
                  LET g_master.l_site = ''
                  LET g_master.l_book = ''
                  LET g_master.l_site_desc = ''
                  DISPLAY BY NAME g_master.l_site_desc
                  LET g_master.l_slip1 = ''
                  LET g_master.l_slip1_desc = ''
                  LET g_master.l_slip2 = ''
                  LET g_master.l_slip2_desc = ''
                  LET g_master.l_xmdk015 = ''
                  LET g_master.l_xmdk015_desc = ''
                  DISPLAY BY NAME g_master.l_slip1,g_master.l_slip1_desc,
                                  g_master.l_slip2,g_master.l_slip2_desc,
                                  g_master.l_xmdk015,g_master.l_xmdk015_desc
                  DISPLAY '' TO rmdadocno
                  
                  DISPLAY BY NAME g_master.l_site,g_master.l_book
                  LET g_master.l_xrcald_desc = s_desc_get_ld_desc(g_master.l_xrcald)
                  LET g_master.l_xrcasite_desc = s_desc_get_department_desc(g_master.l_xrcasite)
                  DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcasite_desc
                  
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
                  CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
                  CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
                  
                  LET g_isai002 = ''
                  LET g_isai008 = ''
                  SELECT isai002,isai008 INTO g_isai002,g_isai008 FROM isai_t
                   WHERE isaient = g_enterprise
                     AND isai001 = g_ooef019
               END IF
            END IF
            LET g_master_o.l_xrcasite = g_master.l_xrcasite
            CALL s_desc_get_department_desc(g_master.l_xrcasite) RETURNING g_master.l_xrcasite_desc
            DISPLAY BY NAME g_master.l_xrcasite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcasite
            #add-point:BEFORE FIELD l_xrcasite name="input.b.l_xrcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcasite
            #add-point:ON CHANGE l_xrcasite name="input.g.l_xrcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcald
            
            #add-point:AFTER FIELD l_xrcald name="input.a.l_xrcald"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcald
            #add-point:BEFORE FIELD l_xrcald name="input.b.l_xrcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcald
            #add-point:ON CHANGE l_xrcald name="input.g.l_xrcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrcacomp
            #add-point:BEFORE FIELD l_xrcacomp name="input.b.l_xrcacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrcacomp
            
            #add-point:AFTER FIELD l_xrcacomp name="input.a.l_xrcacomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrcacomp
            #add-point:ON CHANGE l_xrcacomp name="input.g.l_xrcacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xmdk015
            
            #add-point:AFTER FIELD l_xmdk015 name="input.a.l_xmdk015"
            LET g_master.l_xmdk015_desc = ''
            DISPLAY BY NAME g_master.l_xmdk015_desc
            IF NOT cl_null(g_master.l_xmdk015)THEN
               IF (g_master.l_xmdk015 <> g_master_o.l_xmdk015) OR (g_master_o.l_xmdk015 IS NULL) THEN
                  INITIALIZE g_chkparam.* TO NULL      
                  LET g_chkparam.arg1 = g_ooef019
                  LET g_chkparam.arg2 = g_master.l_xmdk015
                   
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_isac002_2") THEN
                     LET g_master.l_xmdk015 = g_rmda.rmba009
                     CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
                     DISPLAY BY NAME g_master.l_xmdk015_desc
                     CALL aisp340_visible()
                     NEXT FIELD l_xmdk015
                  END IF
               END IF
            END IF
            LET g_master_o.l_xmdk015 = g_master.l_xmdk015
          
            CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
            DISPLAY BY NAME g_master.l_xmdk015_desc
            CALL aisp340_visible()
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xmdk015
            #add-point:BEFORE FIELD l_xmdk015 name="input.b.l_xmdk015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xmdk015
            #add-point:ON CHANGE l_xmdk015 name="input.g.l_xmdk015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_curr_type
            #add-point:BEFORE FIELD l_curr_type name="input.b.l_curr_type"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_curr_type
            
            #add-point:AFTER FIELD l_curr_type name="input.a.l_curr_type"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_curr_type
            #add-point:ON CHANGE l_curr_type name="input.g.l_curr_type"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip1
            
            #add-point:AFTER FIELD l_slip1 name="input.a.l_slip1"
            IF NOT cl_null(g_master.l_slip1)THEN
               IF (g_master.l_slip1 <> g_master_o.l_slip1) OR (g_master_o.l_slip1 IS NULL) THEN
                  CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip1,'aist310') 
                     RETURNING g_sub_success
                  IF NOT g_sub_success THEN
                     NEXT FIELD l_slip1
                  END IF
               END IF
            END IF
            LET g_master_o.l_slip1 = g_master.l_slip1
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
            DISPLAY BY NAME g_master.l_slip1_desc
           
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip1
            #add-point:BEFORE FIELD l_slip1 name="input.b.l_slip1"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip1
            #add-point:ON CHANGE l_slip1 name="input.g.l_slip1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_docdt
            #add-point:BEFORE FIELD l_docdt name="input.b.l_docdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_docdt
            
            #add-point:AFTER FIELD l_docdt name="input.a.l_docdt"
            IF NOT cl_null(g_master.l_docdt)THEN
               IF (g_master.l_docdt <> g_master_o.l_docdt) OR (g_master_o.l_docdt IS NULL) THEN
                  CALL aisp340_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_docdt = NULL
                     DISPLAY BY NAME g_master.l_docdt
                     CALL cl_err()
                     NEXT FIELD l_docdt
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_docdt
            #add-point:ON CHANGE l_docdt name="input.g.l_docdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_toaistype
            #add-point:BEFORE FIELD l_toaistype name="input.b.l_toaistype"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_toaistype
            
            #add-point:AFTER FIELD l_toaistype name="input.a.l_toaistype"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_toaistype
            #add-point:ON CHANGE l_toaistype name="input.g.l_toaistype"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_site
            
            #add-point:AFTER FIELD l_site name="input.a.l_site"
            LET g_master.l_site_desc = NULL
            DISPLAY BY NAME g_master.l_site_desc
            IF NOT cl_null(g_master.l_site)THEN
               IF (g_master.l_site <> g_master_o.l_site) OR (g_master_o.l_site) THEN
                  CALL aisp340_ooef001_chk(g_master.l_site)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_site = NULL
                     DISPLAY BY NAME g_master.l_site
                     CALL cl_err()
                     NEXT FIELD l_site
                  END IF                             
                  
                  CALL aisp340_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam.* TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_master.l_site = NULL
                     DISPLAY BY NAME g_master.l_site
                     CALL cl_err()
                     NEXT FIELD l_site
                  END IF
               END IF
            END IF       

            LET g_master_o.l_site = g_master.l_site
            SELECT isae014,isae007,isae008,isae012,isae020
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012,g_master.l_limit_memo
               FROM isae_t           
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai002 = '1' THEN 
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai002 = '2' THEN 
                LET g_master.l_isaf010 = l_isae008
             END IF
             
             IF cl_null(g_master.l_limit_memo)THEN
                LET g_master.l_limit_memo = 0
             END IF
             
            LET g_master.l_isaf011 = l_isae012
            CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
            DISPLAY BY NAME g_master.l_site_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_site
            #add-point:BEFORE FIELD l_site name="input.b.l_site"
            CALL aisp340_book_exist(g_master.l_docdt,g_master.l_xmdk015)
              RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_xmdk015
            END IF
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_site
            #add-point:ON CHANGE l_site name="input.g.l_site"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_book
            #add-point:BEFORE FIELD l_book name="input.b.l_book"
            IF cl_null(g_master.l_site) THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = 'ais-00283'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_site
            END IF
            
            CALL aisp340_book_exist(g_master.l_docdt,g_master.l_xmdk015)
              RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam.* TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               NEXT FIELD l_xmdk015
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_book
            
            #add-point:AFTER FIELD l_book name="input.a.l_book"
            IF NOT cl_null(g_master.l_book)THEN
               CALL aisp340_site_with_book_chk(g_master.l_site,g_master.l_book,g_master.l_docdt,g_master.l_xmdk015)
                 RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_master.l_book = NULL
                  DISPLAY BY NAME g_master.l_book
                  CALL cl_err()
                  NEXT FIELD l_book
               END IF
            END IF
            SELECT isae014,isae007,isae008,isae012,isae020
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012,g_master.l_limit_memo
               FROM isae_t           
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai002 = '1' THEN 
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai002 = '2' THEN 
                LET g_master.l_isaf010 = l_isae008
             END IF
             
             IF cl_null(g_master.l_limit_memo)THEN
                LET g_master.l_limit_memo = 0
             END IF
             
            LET g_master.l_isaf011 = l_isae012
            DISPLAY BY NAME g_master.l_isaf011,g_master.l_isaf010,g_master.l_limit_memo,
                            g_master.l_dat_memo
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_book
            #add-point:ON CHANGE l_book name="input.g.l_book"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_dat_memo
            #add-point:BEFORE FIELD l_dat_memo name="input.b.l_dat_memo"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_dat_memo
            
            #add-point:AFTER FIELD l_dat_memo name="input.a.l_dat_memo"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_dat_memo
            #add-point:ON CHANGE l_dat_memo name="input.g.l_dat_memo"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaf010
            #add-point:BEFORE FIELD l_isaf010 name="input.b.l_isaf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaf010
            
            #add-point:AFTER FIELD l_isaf010 name="input.a.l_isaf010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaf010
            #add-point:ON CHANGE l_isaf010 name="input.g.l_isaf010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_limit_memo
            #add-point:BEFORE FIELD l_limit_memo name="input.b.l_limit_memo"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_limit_memo
            
            #add-point:AFTER FIELD l_limit_memo name="input.a.l_limit_memo"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_limit_memo
            #add-point:ON CHANGE l_limit_memo name="input.g.l_limit_memo"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_isaf011
            #add-point:BEFORE FIELD l_isaf011 name="input.b.l_isaf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_isaf011
            
            #add-point:AFTER FIELD l_isaf011 name="input.a.l_isaf011"
            IF NOT cl_null(g_master.l_isaf011)THEN
               LET l_count = NULL
               SELECT COUNT(*) INTO l_count FROM isae_t          
                WHERE isaeent = g_enterprise
                  AND isaesite = g_master.l_site
                  AND isae001  = g_master.l_book
                  AND isae002 <= g_master.l_docdt
                  AND isae003 >= g_master.l_docdt
                  AND isae009 <= g_master.l_isaf011
                  AND isae010 >= g_master.l_isaf011
               IF cl_null(l_count)THEN LET l_count = 0 END IF
               IF l_count = 0 THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'ais-00236'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.l_isaf011 = l_isae012
                  NEXT FIELD l_isaf011
               END IF
            
               IF g_master.l_isaf011 < l_isae012 THEN
                  LET g_master.l_isaf011 = l_isae012
                  NEXT FIELD l_isaf011
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_isaf011
            #add-point:ON CHANGE l_isaf011 name="input.g.l_isaf011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_slip2
            
            #add-point:AFTER FIELD l_slip2 name="input.a.l_slip2"
            IF NOT cl_null(g_master.l_slip2)THEN
               LET l_prog = 'axrt300'
               CALL s_aooi200_fin_chk_slip(g_master.l_xrcald,'',g_master.l_slip2,l_prog) 
                  RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  NEXT FIELD l_slip2
               END IF
            END IF
            
            CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc
            DISPLAY BY NAME g_master.l_slip2_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_slip2
            #add-point:BEFORE FIELD l_slip2 name="input.b.l_slip2"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_slip2
            #add-point:ON CHANGE l_slip2 name="input.g.l_slip2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_xrca063
            #add-point:BEFORE FIELD l_xrca063 name="input.b.l_xrca063"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_xrca063
            
            #add-point:AFTER FIELD l_xrca063 name="input.a.l_xrca063"
            IF NOT cl_null(g_master.l_xrca063)THEN
               IF NOT s_aooi390_chk('14',g_master.l_xrca063) THEN
                  LET g_master.l_xrca063 = g_master_o.l_xrca063
                  DISPLAY BY NAME g_master.l_xrca063
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_master_o.l_xrca063 = g_master.l_xrca063
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_xrca063
            #add-point:ON CHANGE l_xrca063 name="input.g.l_xrca063"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.l_xrcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcasite
            #add-point:ON ACTION controlp INFIELD l_xrcasite name="input.c.l_xrcasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrcasite
            #LET g_qryparam.where = " ooef204 = 'Y' " #161006-00005#26 mark
            #CALL q_ooef001()                         #161006-00005#26 mark
            CALL q_ooef001_46()                       #161006-00005#26
            LET g_master.l_xrcasite = g_qryparam.return1
            DISPLAY BY NAME g_master.l_xrcasite
            NEXT FIELD l_xrcasite
            #END add-point
 
 
         #Ctrlp:input.c.l_xrcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcald
            #add-point:ON ACTION controlp INFIELD l_xrcald name="input.c.l_xrcald"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xrcald
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            LET g_qryparam.where = " glaacomp = '",l_comp,"' "
            CALL q_authorised_ld()
            LET g_master.l_xrcald = g_qryparam.return1
            CALL s_desc_get_ld_desc(g_master.l_xrcald) RETURNING g_master.l_xrcald_desc
            DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcald
            NEXT FIELD l_xrcald
            #END add-point
 
 
         #Ctrlp:input.c.l_xrcacomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrcacomp
            #add-point:ON ACTION controlp INFIELD l_xrcacomp name="input.c.l_xrcacomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_xmdk015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xmdk015
            #add-point:ON ACTION controlp INFIELD l_xmdk015 name="input.c.l_xmdk015"
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_xmdk015             #給予default值
            LET g_qryparam.where = " isac001 = '",g_ooef019,"'",
                                   " AND isac003 = '2'"
            CALL q_isac002()                                #呼叫開窗
            LET  g_master.l_xmdk015  = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY BY NAME  g_master.l_xmdk015               #顯示到畫面上
            NEXT FIELD l_xmdk015                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_curr_type
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_curr_type
            #add-point:ON ACTION controlp INFIELD l_curr_type name="input.c.l_curr_type"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip1
            #add-point:ON ACTION controlp INFIELD l_slip1 name="input.c.l_slip1"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_slip1           #給予default值
            
            CALL s_fin_orga_get_comp_ld(g_site) RETURNING g_sub_success,g_errno,l_comp,g_glaald
            LET l_glaa024 = ''
            SELECT glaa024 INTO l_glaa024 FROM glaa_t 
             WHERE glaaent = g_enterprise 
               AND glaald = g_glaald

            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = "aist310"
            CALL q_ooba002_1()

            LET g_master.l_slip1 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY BY NAME g_master.l_slip1             #顯示到畫面上
            NEXT FIELD l_slip1                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.l_docdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_docdt
            #add-point:ON ACTION controlp INFIELD l_docdt name="input.c.l_docdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_toaistype
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_toaistype
            #add-point:ON ACTION controlp INFIELD l_toaistype name="input.c.l_toaistype"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_site
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_site
            #add-point:ON ACTION controlp INFIELD l_site name="input.c.l_site"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_site            #給予default值
            LET g_qryparam.default2 = g_master.l_book
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
               
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
              
            IF g_isai002 = '1' THEN
               LET l_prog = 'aisi055'
            ELSE
               LET l_prog = 'aisi050'
            END IF
            LET g_qryparam.where = " isaesite IN ",g_wc_xrcasite," ",   
                                   "   AND isae002 <= '",g_master.l_docdt,"'",
                                   "   AND isae003 >= '",g_master.l_docdt,"'",
                                   "   AND isac001 = '",g_ooef019,"'",
                                   "   AND isae019 = '",l_prog,"' ",
                                   "   AND isae004  = '",g_master.l_xmdk015,"'"                                   
            CALL q_isaesite_3()                                        #呼叫開窗
            LET g_master.l_site  = g_qryparam.return1                  #將開窗取得的值回傳到變數
            LET g_master.l_book  = g_qryparam.return2
            
            #預帶資料
            SELECT isae014,isae007,isae008,isae012,isae020
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012,g_master.l_limit_memo
               FROM isae_t           
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai002 = '1' THEN 
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai002 = '2' THEN 
                LET g_master.l_isaf010 = l_isae008
             END IF
             
             IF cl_null(g_master.l_limit_memo)THEN
                LET g_master.l_limit_memo = 0
             END IF
             
            LET g_master.l_isaf011 = l_isae012
            CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
            DISPLAY BY NAME g_master.l_site,g_master.l_book,g_master.l_site_desc,            #顯示到畫面上
                            g_master.l_dat_memo,g_master.l_isaf010,g_master.l_isaf011,
                            g_master.l_limit_memo
            NEXT FIELD l_site
            #END add-point
 
 
         #Ctrlp:input.c.l_book
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_book
            #add-point:ON ACTION controlp INFIELD l_book name="input.c.l_book"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.l_site            #給予default值
            LET g_qryparam.default2 = g_master.l_book
            SELECT ooef019 INTO g_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
               
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_master.l_site
            IF g_isai002 = '1' THEN
               LET l_prog = 'aisi055'
            ELSE
               LET l_prog = 'aisi050'
            END IF
            LET g_qryparam.where = " isaesite IN ",g_wc_xrcasite," ",   
                                   "   AND isae002 <= '",g_master.l_docdt,"'",
                                   "   AND isae003 >= '",g_master.l_docdt,"'",
                                   "   AND isac001 = '",g_ooef019,"'",
                                   "   AND isae019 = '",l_prog,"' ",
                                   "   AND isae004  = '",g_master.l_xmdk015,"'"
            CALL q_isaesite_3()                                    #呼叫開窗
            LET g_master.l_site  = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_master.l_book  = g_qryparam.return2
            
            #預帶資料
            SELECT isae014,isae007,isae008,isae012,isae020
               INTO g_master.l_dat_memo,l_isae007,l_isae008,l_isae012,g_master.l_limit_memo
               FROM isae_t           
              WHERE isaeent = g_enterprise
                AND isaesite = g_master.l_site
                AND isae001  = g_master.l_book
                AND isae002 <= g_master.l_docdt
                AND isae003 >= g_master.l_docdt
             
             IF g_isai002 = '1' THEN 
                LET g_master.l_isaf010 = l_isae007
             END IF
              
             IF g_isai002 = '2' THEN 
                LET g_master.l_isaf010 = l_isae008
             END IF
             
             IF cl_null(g_master.l_limit_memo)THEN
                LET g_master.l_limit_memo = 0
             END IF
             
            LET g_master.l_isaf011 = l_isae012
            CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
            DISPLAY BY NAME g_master.l_site,g_master.l_book,g_master.l_site_desc,            #顯示到畫面上
                            g_master.l_dat_memo,g_master.l_isaf010,g_master.l_isaf011,
                            g_master.l_limit_memo
            NEXT FIELD l_book
            #END add-point
 
 
         #Ctrlp:input.c.l_dat_memo
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_dat_memo
            #add-point:ON ACTION controlp INFIELD l_dat_memo name="input.c.l_dat_memo"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isaf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaf010
            #add-point:ON ACTION controlp INFIELD l_isaf010 name="input.c.l_isaf010"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_limit_memo
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_limit_memo
            #add-point:ON ACTION controlp INFIELD l_limit_memo name="input.c.l_limit_memo"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_isaf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_isaf011
            #add-point:ON ACTION controlp INFIELD l_isaf011 name="input.c.l_isaf011"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_slip2
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_slip2
            #add-point:ON ACTION controlp INFIELD l_slip2 name="input.c.l_slip2"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.l_slip2             #給予default值
            SELECT glaa024 INTO l_glaa024 FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_master.l_xrcald
            LET g_qryparam.arg1 = l_glaa024
            LET g_qryparam.arg2 = 'axrt300' 
            CALL q_ooba002_1()                                #呼叫開窗
            LET g_master.l_slip2 = g_qryparam.return1
            DISPLAY BY NAME g_master.l_slip2             
            NEXT FIELD l_slip2
            #END add-point
 
 
         #Ctrlp:input.c.l_xrca063
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_xrca063
            #add-point:ON ACTION controlp INFIELD l_xrca063 name="input.c.l_xrca063"
            CALL s_aooi390_gen('14') RETURNING g_sub_success,g_master.l_xrca063,l_oofg_return   
            DISPLAY BY NAME g_master.l_xrca063
            NEXT FIELD l_xrca063
            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON rmdadocno
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.rmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rmdadocno
            #add-point:ON ACTION controlp INFIELD rmdadocno name="construct.c.rmdadocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            CALL s_control_get_customer_sql('2',g_master.l_xrcacomp,g_user,g_dept,'') RETURNING g_sub_success,l_ctl_where
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " rmdasite IN ",g_wc_xrcasite," ",
                                   "   AND rmdasite IN(",
                                   "       SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
                                   "         AND ooef017 = '",g_master.l_xrcacomp,"') ",
                                   "   AND rmda001 <= '",g_master.l_docdt,"' ",
                                   "   AND (rmdb013-COALESCE((SELECT SUM(isag004) FROM isag_t ",
                                   "                          WHERE isagent = ",g_enterprise," ",
                                   "                            AND isagcomp = '",g_master.l_xrcacomp,"' ",
                                   "                            AND isagent = rmdaent ",
                                   "                            AND isag002 = rmdadocno ",
                                   "                            AND isag003 = rmdbseq ",
                                   "                            AND (EXISTS (SELECT 1 FROM isaf_t ",
                                   "                                  WHERE isafent = isagent ",
                                   "                                    AND isafcomp = isagcomp ",
                                   "                                    AND isafdocno = isagdocno ",
                                   "                                    AND isafstus <> 'X'))),0)) > 0 ",      
                                   "   AND rmdastus = 'S' ",                                   
                                   "   AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t ",
                                   "                WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                   "                  AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
                                   "                  AND pmabsite = '",g_master.l_xrcacomp,"'",
                                   "                  AND pmaaent = rmdaent",
                                   "                  AND pmaa001 = rmda005 )"
                                            
            CALL q_rmdadocno_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO rmdadocno  #顯示到畫面上
            NEXT FIELD rmdadocno                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rmdadocno
            #add-point:BEFORE FIELD rmdadocno name="construct.b.rmdadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rmdadocno
            
            #add-point:AFTER FIELD rmdadocno name="construct.a.rmdadocno"
            
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
            CALL aisp340_get_buffer(l_dialog)
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
            CALL aisp340_qbeclear()
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
         CALL aisp340_init()
         CONTINUE WHILE
      END IF
 
      #檢查批次設定是否有錯(或未設定完成)
      IF NOT cl_schedule_exec_check() THEN
         CONTINUE WHILE
      END IF
      
      LET lc_param.wc = g_master.wc    #把畫面上的wc傳遞到參數變數
      #請在下方的add-point內進行把畫面的輸入資料(g_master)轉換到傳遞參數變數(lc_param)的動作
      #add-point:ui_dialog段exit dialog name="process.exit_dialog"
      LET lc_param.l_xmdk015     = g_master.l_xmdk015
      LET lc_param.l_slip1       = g_master.l_slip1
      LET lc_param.l_docdt       = g_master.l_docdt
      LET lc_param.l_toaistype   = g_master.l_toaistype
      LET lc_param.l_site        = g_master.l_site
      LET lc_param.l_book        = g_master.l_book
      LET lc_param.l_dat_memo    = g_master.l_dat_memo
      LET lc_param.l_isaf010     = g_master.l_isaf010
      LET lc_param.l_limit_memo  = g_master.l_limit_memo
      LET lc_param.l_isaf011     = g_master.l_isaf011
      LET lc_param.l_xrcald      = g_master.l_xrcald
      LET lc_param.l_slip2       = g_master.l_slip2
      LET lc_param.l_xrca063     = g_master.l_xrca063
      LET lc_param.l_xrcasite    = g_master.l_xrcasite
      LET lc_param.l_xrcacomp    = g_master.l_xrcacomp
      LET lc_param.l_curr_type   = g_master.l_curr_type
      CALL util.JSON.parse(g_argv[1],l_tran)
      IF NOT cl_null(l_tran.wc)THEN
         
         LET lc_param.wc = lc_param.wc CLIPPED," AND ",l_tran.wc CLIPPED
         
      END IF
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
                 CALL aisp340_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aisp340_transfer_argv(ls_js)
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
 
{<section id="aisp340.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aisp340_transfer_argv(ls_js)
 
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
 
{<section id="aisp340.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aisp340_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   #對帳單頭
   DEFINE l_isaf        RECORD                   
          isafent	      LIKE isaf_t.isafent,	    #企業編碼
          isafsite	   LIKE isaf_t.isafsite,	 #帳務組織
          isafcomp	   LIKE isaf_t.isafcomp,	 #法人
          isafdocno	   LIKE isaf_t.isafdocno,	 #開票單號
          isafdocdt	   LIKE isaf_t.isafdocdt,	 #錄入日期
          isaf001	      LIKE isaf_t.isaf001,	    #發票來源
          isaf002	      LIKE isaf_t.isaf002,	    #發票客戶
          isaf003	      LIKE isaf_t.isaf003,	    #帳款客戶
          isaf004	      LIKE isaf_t.isaf004,	    #業務組織
          isaf005	      LIKE isaf_t.isaf005,	    #開票人員
          isaf006	      LIKE isaf_t.isaf006,	    #開票部門
          isaf008	      LIKE isaf_t.isaf008,	    #發票類型
          isaf009	      LIKE isaf_t.isaf009,	    #電子發票否
          isaf010	      LIKE isaf_t.isaf010,	    #發票代碼
          isaf011	      LIKE isaf_t.isaf011,	    #發票號碼
          isaf014	      LIKE isaf_t.isaf014,	    #發票日期
          isaf016	      LIKE isaf_t.isaf016,	    #稅別
          isaf017	      LIKE isaf_t.isaf017,	    #含稅否
          isaf018	      LIKE isaf_t.isaf018,	    #稅率
          isaf019	      LIKE isaf_t.isaf019,	    #申報格式
          isaf021	      LIKE isaf_t.isaf021,	    #購貨方名稱
          isaf022	      LIKE isaf_t.isaf022,	    #購貨方稅務編號
          isaf023	      LIKE isaf_t.isaf023,	    #購貨方地址
          isaf024	      LIKE isaf_t.isaf024,	    #購貨方電話
          isaf025	      LIKE isaf_t.isaf025,	    #購貨方開戶銀行
          isaf026	      LIKE isaf_t.isaf026,	    #購貨方帳戶編碼
          isaf027	      LIKE isaf_t.isaf027,	    #銷貨方名稱
          isaf028	      LIKE isaf_t.isaf028,	    #銷方稅務編號
          isaf029	      LIKE isaf_t.isaf029,	    #銷貨方地址
          isaf030	      LIKE isaf_t.isaf030,	    #銷貨方電話
          isaf031	      LIKE isaf_t.isaf031,	    #銷貨方開戶銀行
          isaf032	      LIKE isaf_t.isaf032,	    #銷貨方帳號
          isaf039	      LIKE isaf_t.isaf039,	    #異動日期
          isaf040	      LIKE isaf_t.isaf040,	    #異動時間
          isaf041	      LIKE isaf_t.isaf041,	    #異動人員
          isaf044	      LIKE isaf_t.isaf044,	    #列印次數
          isaf046	      LIKE isaf_t.isaf046,	    #支付工具卡號2
          isaf050	      LIKE isaf_t.isaf050,	    #產生方式
          isaf051	      LIKE isaf_t.isaf051,	    #發票簿號
          isaf052	      LIKE isaf_t.isaf052,	    #發票簿號對應的營運據點
          isaf053	      LIKE isaf_t.isaf053,	    #發票聯數
          isaf054	      LIKE isaf_t.isaf054,	    #課稅別
          isaf055	      LIKE isaf_t.isaf055,	    #收款客戶
          isaf056	      LIKE isaf_t.isaf056,	    #發票性質
          isaf057	      LIKE isaf_t.isaf057,	    #業務人員
          isaf058	      LIKE isaf_t.isaf058,	    #收款條件
          isaf100	      LIKE isaf_t.isaf100,	    #幣別
          isaf101	      LIKE isaf_t.isaf101,	    #匯率
          isaf103	      LIKE isaf_t.isaf103,	    #發票原幣未稅金額
          isaf104	      LIKE isaf_t.isaf104,	    #發票原幣稅額
          isaf105	      LIKE isaf_t.isaf105,	    #發票原幣含稅金額
          isaf106	      LIKE isaf_t.isaf106,	    #發票原幣留抵稅額
          isaf107	      LIKE isaf_t.isaf107,	    #發票原幣已折金額
          isaf108	      LIKE isaf_t.isaf108,	    #發票原幣已折稅額
          isaf113	      LIKE isaf_t.isaf113,	    #發票本幣未稅金額
          isaf114	      LIKE isaf_t.isaf114,	    #發票本幣稅額
          isaf115	      LIKE isaf_t.isaf115,	    #發票本幣含稅金額
          isaf116	      LIKE isaf_t.isaf116,	    #發票本幣留抵稅額
          isaf117	      LIKE isaf_t.isaf117,	    #發票本幣已折金額
          isaf118	      LIKE isaf_t.isaf118,	    #發票本幣已折稅額
          isaf119	      LIKE isaf_t.isaf119,	    #帳款應稅金額
          isaf120	      LIKE isaf_t.isaf120,	    #帳款零稅金額
          isaf121	      LIKE isaf_t.isaf121,	    #帳款免稅金額
          isaf122	      LIKE isaf_t.isaf122,	    #禮券已開發票金額
          isaf123	      LIKE isaf_t.isaf123,	    #禮券已開發票稅額
          isaf124	      LIKE isaf_t.isaf124,	    #已開發票留抵稅額
          isaf205	      LIKE isaf_t.isaf205,	    #電子發票匯出狀態
          isafstus      LIKE isaf_t.isafstus,    #狀態碼
          isaf066	      LIKE isaf_t.isaf066,	    #商業發票號碼(IV no.)
          isafownid     LIKE isaf_t.isafownid,
          isafowndp     LIKE isaf_t.isafowndp,
          isafcrtid     LIKE isaf_t.isafcrtid,
          isafcrtdp     LIKE isaf_t.isafcrtdp,
          isafcrtdt     LIKE isaf_t.isafcrtdt,
          isafmodid     LIKE isaf_t.isafmodid,
          isafmoddt     LIKE isaf_t.isafmoddt
                        END RECORD
   #RMA覆出單單頭檔
   DEFINE l_rmda        RECORD                   
          rmdasite	   LIKE rmda_t.rmdasite,    #營運據點
          rmdadocno	   LIKE rmda_t.rmdadocno,   #覆出單號
          rmda002	      LIKE rmda_t.rmda002,     #業務人員
          rmda003	      LIKE rmda_t.rmda003,     #業務部門
          rmda004	      LIKE rmda_t.rmda004,     #RMA單號
          rmda007	      LIKE rmda_t.rmda007,     #帳款客戶
          rmda008	      LIKE rmda_t.rmda008      #發票客戶
                        END RECORD
   #RMA報價單單頭檔
   DEFINE l_rmba        RECORD                   
          rmba004	      LIKE rmba_t.rmba004,     #收款條件
          rmba006       LIKE rmba_t.rmba006,     #稅別
          rmba007       LIKE rmba_t.rmba007,     #稅率
          rmba008       LIKE rmba_t.rmba008,     #單價含稅否
          rmba010       LIKE rmba_t.rmba010,     #幣別
          rmba011       LIKE rmba_t.rmba011,     #匯率
          rmba013       LIKE rmba_t.rmba013      #內外銷
                        END RECORD
                                              
   DEFINE l_wc          STRING
   DEFINE l_array       DYNAMIC ARRAY OF RECORD
           chr          LIKE type_t.chr1000,
           dat          LIKE type_t.dat
                        END RECORD
   DEFINE l_pmaa003     LIKE pmaa_t.pmaa003 
   
   DEFINE la_param      RECORD
           prog         STRING,
           actionid     STRING,
           background   LIKE type_t.chr1,
           param        DYNAMIC ARRAY OF STRING
                        END RECORD
   #拋axrp132                  
   DEFINE tran_master   RECORD               
       xrcasite         LIKE xrca_t.xrcasite, 
       xrcasite_desc    LIKE type_t.chr80, 
       xrcald           LIKE xrca_t.xrcald, 
       xrcald_desc      LIKE type_t.chr80, 
       b_style          LIKE type_t.chr500, 
       xrcadocno        LIKE xrca_t.xrcadocno, 
       xrca007          LIKE xrca_t.xrca007, 
       xrcadocdt        LIKE xrca_t.xrcadocdt, 
       b_check1         LIKE type_t.chr500, 
       b_check4         LIKE type_t.chr500, 
       b_check2         LIKE type_t.chr500, 
       b_check5         LIKE type_t.chr500, 
       b_check3         LIKE type_t.chr500, 
       b_check6         LIKE type_t.chr500, 
       b_comb1          LIKE type_t.chr500, 
       b_comb2          LIKE type_t.chr500, 
       isafdocno        LIKE isaf_t.isafdocno, 
       fflabel_desc     LIKE type_t.chr80, 
       isaf002          LIKE isaf_t.isaf002, 
       isaf010          LIKE isaf_t.isaf010, 
       isaf003          LIKE isaf_t.isaf003, 
       isaf011          LIKE isaf_t.isaf011, 
       isaf055          LIKE isaf_t.isaf055, 
       isaf014          LIKE isaf_t.isaf014, 
       isaf004          LIKE isaf_t.isaf004, 
       isaf016          LIKE isaf_t.isaf016, 
       isaf057          LIKE isaf_t.isaf057, 
       stagenow         LIKE type_t.chr80,
       wc               STRING,
       progflag         LIKE gzza_t.gzza001      #傳入程式代號
                        END RECORD
   DEFINE l_tran           STRING
   DEFINE ls_js2           STRING
   DEFINE l_comp           LIKE ooef_t.ooef001
      
   DEFINE l_sql            STRING
   DEFINE l_sql1           STRING
   DEFINE l_rmdadocno      LIKE rmda_t.rmdadocno #撈出符合條件單號
   DEFINE l_rmdbseq        LIKE rmdb_t.rmdbseq   #撈出符合條件項次
   DEFINE l_done_isafdocno LIKE type_t.num5      #已存在aist310的個數
   DEFINE l_done_xrcadocno LIKE type_t.num5      #已存在axrt300的個數
   
   DEFINE l_strno          LIKE type_t.chr80
   DEFINE l_endno          LIKE type_t.chr80
   DEFINE l_strno1         LIKE isaf_t.isafdocno
   DEFINE l_endno1         LIKE isaf_t.isafdocno
   DEFINE l_strno2         LIKE xrca_t.xrcadocno
   DEFINE l_endno2         LIKE xrca_t.xrcadocno
   
   DEFINE l_doais          LIKE type_t.num5
   DEFINE l_doaxr          LIKE type_t.num5
   
   DEFINE l_xrca063        LIKE xrca_t.xrca063   #整帳批序號
   DEFINE l_isae007        LIKE isae_t.isae007   #發票字軌
   DEFINE l_isaf011        LIKE isaf_t.isaf011   #發票號碼
   
   DEFINE l_isatsum        LIKE type_t.num20_6   #原幣含稅金額
   DEFINE l_isafsum        LIKE type_t.num20_6   #原幣含稅金額
   DEFINE l_count          LIKE type_t.num10
   
   DEFINE l_sfin2009       LIKE type_t.chr1 
   DEFINE lc_param_rate    RECORD
            type           LIKE type_t.chr1,     #類型
            apca004        LIKE apca_t.apca004,  #交易對象
            sfin2009       LIKE type_t.chr1      #匯率類型   
                           END RECORD
   DEFINE l_desc           LIKE type_t.chr10
   
   DEFINE l_ctl_where      STRING                #控制組條件
   DEFINE l_flag           LIKE type_t.chr1      #判斷單號+項次是否可往下寫 (Y:執行寫入 / N:跳過不做)
   DEFINE r_success        LIKE type_t.num5
   #end add-point
 
  #INITIALIZE lc_param TO NULL           #p類不可以清空
   CALL util.JSON.parse(ls_js,lc_param)  #r類作業被t類呼叫時使用, p類主要解開參數處
   LET li_p01_status = 1
 
  #IF lc_param.wc IS NOT NULL THEN
  #   LET g_bgjob = "T"       #特殊情況,此為t類作業鬆耦合串入報表主程式使用
  #END IF
 
   #add-point:process段前處理 name="process.pre_process"
 
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress name="process.count_progress"
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE aisp340_process_cs CURSOR FROM ls_sql
#  FOREACH aisp340_process_cs INTO
   #add-point:process段process name="process.process"
   #帳務中心預設的範圍等值
   CALL s_fin_orga_get_comp_ld(lc_param.l_xrcasite) RETURNING g_sub_success,g_errno,lc_param.l_xrcacomp,lc_param.l_xrcald
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = lc_param.l_xrcacomp 

   CALL s_fin_account_center_sons_query('3',lc_param.l_xrcasite,g_today,'1')        
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
   CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   CALL s_control_get_customer_sql('2',lc_param.l_xrcacomp,g_user,g_dept,'') RETURNING g_sub_success,l_ctl_where

   LET l_sql = "SELECT DISTINCT rmdadocno ",
               "  FROM rmda_t,rmdb_t ",
               " WHERE rmdaent = ",g_enterprise," ",
               "   AND rmda001 <= '",lc_param.l_docdt,"' ",
               "   AND ",lc_param.wc CLIPPED,
               "   AND rmdasite IN ",g_wc_xrcasite," ",
               "   AND rmdasite IN( SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," ",
               "                       AND ooef017 = '",lc_param.l_xrcacomp,"') ",
               "   AND rmdaent = rmdbent AND rmdadocno = rmdbdocno ",
               "   AND rmdastus = 'S' ",
               "   AND (rmdb013-COALESCE((SELECT SUM(isag004) FROM isag_t ",
               "                  WHERE isagent = ",g_enterprise," ",
               "                    AND isagcomp = '",lc_param.l_xrcacomp,"' ",
               "                    AND isagent = rmdaent ",
               "                    AND isag002 = rmdadocno ",
               "                    AND isag003 = rmdbseq ",
               "                    AND (EXISTS (SELECT 1 FROM isaf_t ",
               "                          WHERE isafent = isagent ",
               "                            AND isafcomp = isagcomp ",
               "                            AND isafdocno = isagdocno ",
               "                            AND isafstus <> 'X'))),0)) > 0 ",                                                  
               "   AND EXISTS (SELECT 1 FROM pmaa_t,pmab_t ",
               "                WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
               "                  AND pmaaent = ",g_enterprise," AND ",l_ctl_where,
               "                  AND pmabsite = '",lc_param.l_xrcacomp,"' ",
               "                  AND pmaaent = rmdaent ",
               "                  AND pmaa001 = rmda005 ) ",
               " ORDER BY rmdadocno "
               
   DISPLAY 'l_sql:',l_sql
   
   PREPARE aisp340_mainp1 FROM l_sql
   DECLARE aisp340_mainc1 CURSOR WITH HOLD FOR aisp340_mainp1
   
   LET l_strno1 = NULL   LET l_endno1 = NULL
   LET l_strno2 = NULL   LET l_endno2 = NULL
   LET l_doaxr = 0       LET l_doais = 0 
   
   #整帳批序號
   IF NOT cl_null(lc_param.l_xrca063)THEN
      CALL s_transaction_begin()
      CALL s_aooi390_get_auto_no('14',lc_param.l_xrca063) RETURNING g_sub_success,l_xrca063
      CALL s_aooi390_oofi_upd('14',l_xrca063) RETURNING g_sub_success
      CALL s_transaction_end('Y','0')
   END IF
   
   CALL cl_err_collect_init()
   FOREACH aisp340_mainc1 INTO l_rmdadocno
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = 'FOREACH:aisp340_mainc1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET r_success = TRUE 
      LET l_done_isafdocno = ''
      LET l_done_xrcadocno = ''
      LET l_sql1 = ''
      LET l_flag = 'Y'
      
      #如果同一覆出單號+項次(armt400)已經存在於aist310/axrt300單身,則批次不再產生並報錯已存在資料
      LET l_sql1 = " SELECT DISTINCT rmdbseq ",
                   "   FROM rmda_t,rmdb_t ",
                   "  WHERE rmdaent = ",g_enterprise," ",
                   "    AND rmdadocno = '",l_rmdadocno,"' ",
                   "    AND rmdaent = rmdbent AND rmdadocno = rmdbdocno",
                   "    AND rmdastus = 'S' ",
                   "  ORDER BY rmdbseq "
         
      PREPARE aisp340_p2 FROM l_sql1
      DECLARE aisp340_c2 CURSOR WITH HOLD FOR aisp340_p2
      
      FOREACH aisp340_c2 INTO l_rmdbseq
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = 'FOREACH:aisp340_c2'
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         LET l_flag = 'Y'
         
         #aist310-----
         LET l_done_isafdocno = 0
         SELECT COUNT(*) INTO l_done_isafdocno 
           FROM isaf_t,isag_t 
          WHERE isagent = isafent     
            AND isagcomp = isafcomp 
            AND isagdocno = isafdocno AND isagent = g_enterprise
            AND isagcomp = lc_param.l_xrcacomp 
            AND isag002 = l_rmdadocno 
            AND isag003 = l_rmdbseq
            AND isafstus <> 'X'
            
         #axrt300-----
         LET l_done_xrcadocno = 0
         SELECT COUNT(*) INTO l_done_xrcadocno 
           FROM xrca_t,xrcb_t 
          WHERE xrcaent = xrcbent 
            AND xrcald = xrcbld 
            AND xrcadocno = xrcbdocno 
            AND xrcaent = g_enterprise
            AND xrcald = lc_param.l_xrcald 
            AND xrcb002 = l_rmdadocno 
            AND xrcb003 = l_rmdbseq
            AND xrcastus <> 'X'
         
         IF (l_done_isafdocno + l_done_xrcadocno) > 0 THEN
            INITIALIZE g_errparam.* TO NULL
            LET g_errparam.code = 'ais-00208'
            LET g_errparam.extend = l_rmdadocno,"#",l_rmdbseq
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_flag = 'N' #不能往下執行
            CONTINUE FOREACH
         ELSE
            LET l_flag = 'Y' #往下執行
            EXIT FOREACH
         END IF
      END FOREACH
      
      IF l_flag ='N' THEN CONTINUE FOREACH END IF
      
      INITIALIZE l_rmda.* TO NULL
      #RMA覆出單單頭檔
      SELECT rmdasite,rmdadocno,rmda002,rmda003,rmda004,rmda007,rmda008
        INTO l_rmda.* 
        FROM rmda_t
       WHERE rmdaent = g_enterprise AND rmdadocno = l_rmdadocno AND rmdastus = 'S' 
      
      INITIALIZE l_rmba.* TO NULL
      #RMA報價單單頭檔
      SELECT rmba004,rmba006,rmba007,rmba008,rmba010,rmba011,rmba013
        INTO l_rmba.*
        FROM rmba_t
       WHERE rmbaent = g_enterprise
         AND rmbadocno = l_rmda.rmda004
         AND rmba000 IN (SELECT MAX(rmba000) FROM rmba_t 
                          WHERE rmbaent = g_enterprise 
                            AND rmbadocno = l_rmda.rmda004)
      
      CALL s_transaction_begin() 
      
      INITIALIZE l_isaf.* TO NULL
      LET l_isaf.isafent = g_enterprise
      LET l_isaf.isafsite = l_rmda.rmdasite
      CALL s_fin_orga_get_comp_ld(l_isaf.isafsite) RETURNING g_sub_success,g_errno,l_isaf.isafcomp,g_glaald
   
      LET g_ooef019 = NULL   
      SELECT ooef019 INTO g_ooef019
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
      LET l_isaf.isafdocno = lc_param.l_slip1
   
      LET l_isaf.isafdocdt = lc_param.l_docdt  

      CALL s_aooi200_fin_gen_docno(g_glaald,'','',l_isaf.isafdocno,l_isaf.isafdocdt,'aist310')
         RETURNING g_sub_success,l_isaf.isafdocno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
     
      LET l_isaf.isaf002   = l_rmda.rmda008
      LET l_isaf.isaf003   = l_rmda.rmda007
      LET l_isaf.isaf004   = l_rmda.rmda003
      LET l_isaf.isaf005   = g_user
      #isaf006(開票人員串ooag003)
      SELECT ooag003 INTO l_isaf.isaf006 FROM ooag_t
       WHERE ooagent = g_enterprise
         AND ooag001 = l_isaf.isaf005
         
      LET l_isaf.isaf008   = lc_param.l_xmdk015
      LET l_isaf.isaf014   = lc_param.l_docdt
      LET l_isaf.isaf016   = l_rmba.rmba006
      LET l_isaf.isaf017   = l_rmba.rmba008
      LET l_isaf.isaf018   = l_rmba.rmba007 
      
      #isaf022~isaf026
      SELECT isak008,isak009,
             isak010,isak011,isak012
        INTO l_isaf.isaf022,l_isaf.isaf023,
             l_isaf.isaf024,l_isaf.isaf025,l_isaf.isaf026
        FROM isak_t
       WHERE isakent = g_enterprise
         AND isak001 = l_isaf.isaf002
         AND isak002 = g_ooef019
         AND isakstus = 'Y'
      
      #稅務編號處理(isaf022)
      #國別為台灣的處理
      IF g_isai008 = 'TW' THEN
         #isaf022 用pmaa003
         LET l_pmaa003 = NULL
         SELECT pmaa003 INTO l_pmaa003
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_isaf.isaf002
            AND pmaastus = 'Y'
         LET l_isaf.isaf022 = l_pmaa003
      END IF

      #isaf027(開票部門對外全稱 ooefl005)
      SELECT ooefl004 INTO l_isaf.isaf027 FROM ooefl_t
       WHERE ooeflent = g_enterprise
         AND ooefl001 = l_isaf.isafcomp
         AND ooefl002 = g_dlang      

      #isaf028
      SELECT ooef002 INTO l_isaf.isaf028
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp    
       
      #isaf029~isaf032
      SELECT isao002,isao003,
             isao004,isao005
        INTO l_isaf.isaf029,l_isaf.isaf030,
             l_isaf.isaf031,l_isaf.isaf032
        FROM isao_t
       WHERE isaoent = g_enterprise
         AND isaosite = l_isaf.isafcomp
         AND isaostus = 'Y'
         
      LET l_isaf.isaf039 = g_today
      LET l_isaf.isaf040 = cl_get_time()
      LET l_isaf.isaf041 = g_user   
      
      LET l_isaf.isaf044   = 0 
      SELECT ooef002 INTO l_isaf.isaf046 FROM isaf_t
       WHERE ooefent = g_enterprise
         AND ooef001 = l_isaf.isafcomp
         
      LET l_isaf.isaf050   = 0
      LET l_isaf.isaf051   = lc_param.l_book
      LET l_isaf.isaf052   = lc_param.l_site
      
      #內銷銷退  外銷出貨銷退
      #不會啟用發票簿  所以site要抓原單site
      IF cl_null(l_isaf.isaf052)THEN
         LET l_isaf.isaf052 = l_rmda.rmdasite
      END IF
      
      LET l_isaf.isaf055   = l_rmda.rmda007

      LET l_isaf.isaf056 = '1'
      LET l_isaf.isaf001 = '1'
      
      LET l_isaf.isaf057   = l_rmda.rmda002
      LET l_isaf.isaf058   = l_rmba.rmba004
      
      #發票類型串出課稅別
      SELECT oodb008 INTO l_isaf.isaf054
        FROM oodb_t
       WHERE oodbent = g_enterprise
         AND oodb001 = g_ooef019
         AND oodb002 = l_isaf.isaf016
         
      #發票簿預設值
      LET l_isae007 = NULL
      SELECT isae005,isae008,isae012,isae007
        INTO l_isaf.isaf009,l_isaf.isaf010,l_isaf.isaf011,l_isae007
        FROM isae_t
       WHERE isaeent = g_enterprise
         AND isaecomp = l_isaf.isafcomp
         AND isaesite = l_isaf.isaf052
         AND isae001 = l_isaf.isaf051
         AND isae002 <= l_isaf.isaf014
         AND isae003 >= l_isaf.isaf014
         AND isae004 = l_isaf.isaf008
      
      #媒申格式 / 發票聯別
      SELECT isac004,isac008 INTO l_isaf.isaf019,l_isaf.isaf053
        FROM isac_t
       WHERE isacent = g_enterprise
         AND isac001 = g_ooef019
         AND isac002 = l_isaf.isaf008
         
      #發票客戶帶出交易對象全名   
      SELECT pmaal004 INTO l_isaf.isaf021
        FROM pmaal_t
       WHERE pmaalent = g_enterprise
         AND pmaal001 = l_isaf.isaf002
         AND pmaal002 = g_dlang
       
      LET l_isaf.isaf066 = ''
      LET l_isaf.isaf100 = l_rmba.rmba010
      LET l_isaf.isaf101 = l_rmba.rmba011
      
      IF lc_param.l_curr_type MATCHES '[23]' THEN
         LET l_isaf.isaf101 = ''
         LET lc_param_rate.type = '1'
         LET lc_param_rate.apca004 = l_rmda.rmda007
         LET lc_param_rate.sfin2009 = lc_param.l_curr_type
         LET ls_js = util.JSON.stringify(lc_param_rate)
         CALL s_fin_get_curr_rate(lc_param.l_xrcacomp,lc_param.l_xrcald,lc_param.l_docdt,l_rmba.rmba010,ls_js)
              RETURNING l_isaf.isaf101,l_desc,l_desc
      END IF
      
      LET l_isaf.isaf103   = 0
      LET l_isaf.isaf104   = 0
      LET l_isaf.isaf105   = 0
      LET l_isaf.isaf106   = 0 
      LET l_isaf.isaf107   = 0
      LET l_isaf.isaf108   = 0
      LET l_isaf.isaf113   = 0 
      LET l_isaf.isaf114   = 0
      LET l_isaf.isaf115   = 0
      LET l_isaf.isaf116   = 0
      LET l_isaf.isaf117   = 0
      LET l_isaf.isaf118   = 0
      LET l_isaf.isaf119   = 0
      LET l_isaf.isaf120   = 0  
      LET l_isaf.isaf121   = 0   
      LET l_isaf.isaf122   = 0                                          
      LET l_isaf.isaf123   = 0
      LET l_isaf.isaf124   = 0
     
      LET l_isaf.isafownid = g_user
      LET l_isaf.isafowndp = g_dept
      LET l_isaf.isafcrtid = g_user
      LET l_isaf.isafcrtdp = g_dept
      LET l_isaf.isafcrtdt = cl_get_current()
      LET l_isaf.isafmodid = g_user
      LET l_isaf.isafmoddt = cl_get_current()
      LET l_isaf.isafstus = 'N'
      LET l_isaf.isaf205 = 'N'
      
      INSERT INTO isaf_t(isafent,isafsite,isafcomp,isafdocno,isafdocdt,isaf001,isaf002,isaf003,	 
                         isaf004,isaf005,isaf006,isaf008,isaf009,isaf010,isaf011,isaf014,	 
                         isaf016,isaf017,isaf018,isaf019,isaf021,isaf022,isaf023,isaf024,	 
                         isaf025,isaf026,isaf027,isaf028,isaf029,isaf030,isaf031,isaf032,	 
                         isaf039,isaf040,isaf041,isaf044,isaf046,isaf050,isaf051,isaf052,
                         isaf053,isaf054,isaf055,isaf056,isaf057,isaf058,isaf100,isaf101,
                         isaf103,isaf104,isaf105,isaf106,isaf107,isaf108,isaf113,isaf114,	 
                         isaf115,isaf116,isaf117,isaf118,isaf119,isaf120,isaf121,isaf122,	 
                         isaf123,isaf124,isaf205,isafstus,isaf066,isafownid,isafowndp,isafcrtid,
                         isafcrtdp,isafcrtdt,isafmodid,isafmoddt
         ) VALUES(l_isaf.*)
         
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET r_success = FALSE
      END IF
   
      #產生來源明細單身
      LET l_wc = " rmdadocno ='",l_rmdadocno,"' "   
      CALL l_array.clear()
      LET l_array[1].chr = l_isaf.isafdocno
      LET l_array[2].chr = l_isaf.isafcomp
      CALL s_aisp320_ins_isag2(l_wc,l_array)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      
      #產生發票明細 AND 歷程
      LET l_wc = ' 1=1'
      CALL l_array.clear()
      LET l_array[1].chr = l_isaf.isafdocno
      LET l_array[2].chr = l_isaf.isafcomp
      LET l_array[3].chr = lc_param.l_toaistype
      LET l_array[4].chr = lc_param.l_limit_memo
      LET l_array[5].chr = lc_param.l_book
      LET l_array[6].chr = lc_param.l_site
      LET l_array[7].chr = lc_param.l_isaf010
      LET l_array[8].chr = lc_param.l_isaf011
      CALL s_aisp320_ins_isah(l_wc,l_array)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
      
      #確認
      CALL s_aisp320_conf_upd(l_isaf.isafcomp,l_isaf.isafdocno)RETURNING g_sub_success
      IF NOT g_sub_success THEN
         LET r_success = FALSE
      END IF
 
      IF r_success THEN
         #產生aist310成功
         CALL s_transaction_end('Y',0) 

         IF cl_null(l_strno1) THEN
            LET l_strno1 = l_isaf.isafdocno
         END IF
         LET l_endno1 = l_isaf.isafdocno
         LET l_doais = l_doais + 1

         #拋axrp132
         INITIALIZE tran_master.* TO NULL
         LET tran_master.xrcasite = lc_param.l_xrcasite
         LET tran_master.b_check1 = 'N'
         LET tran_master.b_check2 = 'N'
         LET tran_master.b_check3 = 'N'
         LET tran_master.b_check4 = 'N'
         LET tran_master.b_check5 = 'N'
         LET tran_master.b_check6 = 'N'
         LET tran_master.xrcald = lc_param.l_xrcald
         LET tran_master.b_style  = 'axrt300'
         LET tran_master.xrcadocno = lc_param.l_slip2
         LET tran_master.xrcadocdt = lc_param.l_docdt
         LET tran_master.b_comb2 = '1'
         LET tran_master.b_comb1 = lc_param.l_curr_type
         LET tran_master.wc  = " isafdocno = '",l_isaf.isafdocno,"' "
         LET tran_master.progflag = g_prog
         LET l_tran = util.JSON.stringify(tran_master) 
         INITIALIZE la_param.* TO NULL
         LET la_param.prog = 'axrp132'
         LET la_param.param[1] = l_tran 
         LET la_param.background = 'Y'
       
         LET ls_js2 = util.JSON.stringify(la_param)
         
         CALL cl_cmdrun_wait(ls_js2)
         
         #取成功號
         LET l_strno = NULL
         SELECT xrcadocno INTO l_strno FROM xrca_t
          WHERE xrcaent = g_enterprise
            AND xrcald  = lc_param.l_xrcald
            AND xrca018 = l_isaf.isafdocno
         
         IF NOT cl_null(l_strno)THEN
            IF cl_null(l_strno2)THEN 
               LET l_strno2 = l_strno
            END IF
            LET l_endno2 = l_strno
            
            #回寫整帳批序號
            IF NOT cl_null(l_xrca063)THEN
               UPDATE xrca_t SET xrca063 = l_xrca063
                WHERE xrcaent = g_enterprise
                  AND xrcadocno = l_strno
            END IF
            LET l_doaxr = l_doaxr + 1
         END IF
      ELSE
         CALL s_transaction_end('N',0)        
      END IF   
   END FOREACH
   
   IF (l_doaxr + l_doais = 0) THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = 'aap-00313'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()   
   ELSE
      IF l_doais > 0 THEN
         #顯示成功的對帳單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00379'
         LET g_errparam.replace[1] = l_strno1
         LET g_errparam.replace[2] = l_endno1
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      
      IF l_doaxr > 0 THEN
         #顯示成功的帳務單
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = 'aap-00380'
         LET g_errparam.replace[1] = l_strno2
         LET g_errparam.replace[2] = l_endno2
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()     
      END IF
   END IF
   CALL cl_err_collect_show()
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
   CALL aisp340_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aisp340.get_buffer" >}
PRIVATE FUNCTION aisp340_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.l_xrcasite = p_dialog.getFieldBuffer('l_xrcasite')
   LET g_master.l_xrcald = p_dialog.getFieldBuffer('l_xrcald')
   LET g_master.l_xrcacomp = p_dialog.getFieldBuffer('l_xrcacomp')
   LET g_master.l_xmdk015 = p_dialog.getFieldBuffer('l_xmdk015')
   LET g_master.l_curr_type = p_dialog.getFieldBuffer('l_curr_type')
   LET g_master.l_slip1 = p_dialog.getFieldBuffer('l_slip1')
   LET g_master.l_docdt = p_dialog.getFieldBuffer('l_docdt')
   LET g_master.l_toaistype = p_dialog.getFieldBuffer('l_toaistype')
   LET g_master.l_site = p_dialog.getFieldBuffer('l_site')
   LET g_master.l_book = p_dialog.getFieldBuffer('l_book')
   LET g_master.l_dat_memo = p_dialog.getFieldBuffer('l_dat_memo')
   LET g_master.l_isaf010 = p_dialog.getFieldBuffer('l_isaf010')
   LET g_master.l_limit_memo = p_dialog.getFieldBuffer('l_limit_memo')
   LET g_master.l_isaf011 = p_dialog.getFieldBuffer('l_isaf011')
   LET g_master.l_slip2 = p_dialog.getFieldBuffer('l_slip2')
   LET g_master.l_xrca063 = p_dialog.getFieldBuffer('l_xrca063')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aisp340.msgcentre_notify" >}
PRIVATE FUNCTION aisp340_msgcentre_notify()
 
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
 
{<section id="aisp340.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL aisp340_qbeclear()
# Date & Author..: 160303 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_qbeclear()
DEFINE l_comp      LIKE ooef_t.ooef001
DEFINE l_tran      RECORD
        wc         STRING
                   END RECORD
DEFINE l_sql       STRING
DEFINE ls_js       STRING
DEFINE l_rmdadocno LIKE rmda_t.rmdadocno
DEFINE l_count     LIKE type_t.num10
DEFINE l_sfin2009  LIKE type_t.chr1 
   
   INITIALIZE g_master.* TO NULL
   INITIALIZE g_rmda.* TO NULL
   LET g_master.l_docdt = g_today
   LET g_master.l_toaistype = '2'
   LET g_master.l_curr_type = '1'
   LET ls_js = g_argv[01]
   CALL util.JSON.parse(ls_js,l_tran)
   LET l_sql = "SELECT DISTINCT rmdadocno FROM rmda_t ",
               " WHERE ",l_tran.wc CLIPPED
   PREPARE sel_rmdap1 FROM l_sql
   
   LET l_sql = "SELECT COUNT(*) FROM (",l_sql,") "
   PREPARE sel_rmdap2 FROM l_sql
   
   LET l_count = NULL
   EXECUTE sel_rmdap2 INTO l_count
    CALL cl_set_comp_visible('group_qbe',TRUE)
    CALL cl_set_comp_entry('l_xrcasite',TRUE)
   IF l_count > 0 THEN
      LET l_rmdadocno = NULL
      EXECUTE sel_rmdap1 INTO l_rmdadocno
      
      LET g_rmdadocno = l_rmdadocno    
      CALL aisp340_rmdadocno_def(l_rmdadocno)
      CALL cl_set_comp_visible('group_qbe',FALSE)
      CALL cl_set_comp_entry('l_xrcasite',FALSE)
   ELSE
      LET g_master.l_xrcasite = g_site
   END IF

   CALL s_fin_orga_get_comp_ld(g_master.l_xrcasite) RETURNING g_sub_success,g_errno,g_master.l_xrcacomp,g_master.l_xrcald
   SELECT ooef019 INTO g_ooef019 FROM ooef_t
    WHERE ooefent =g_enterprise
      AND ooef001 = g_master.l_xrcacomp
   
   LET g_master.l_site = ''
   LET g_master.l_book = ''
   DISPLAY BY NAME g_master.l_site,g_master.l_book
   LET g_master.l_xrcald_desc = s_desc_get_ld_desc(g_master.l_xrcald)
   LET g_master.l_xrcasite_desc = s_desc_get_department_desc(g_master.l_xrcasite)
   DISPLAY BY NAME g_master.l_xrcald_desc,g_master.l_xrcasite_desc,g_master.l_xrcald
   
   CALL s_fin_account_center_sons_query('3',g_master.l_xrcasite,g_today,'1') 
   CALL s_fin_account_center_sons_str() RETURNING g_wc_xrcasite
   CALL s_fin_get_wc_str(g_wc_xrcasite) RETURNING g_wc_xrcasite
   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   
   LET g_isai002 = ''
   LET g_isai008 = ''
   SELECT isai002,isai008 INTO g_isai002,g_isai008 FROM isai_t
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019
   
   #依畫面上帳套所屬法人取S-FIN-2009預設匯率選項
   CALL cl_get_para(g_enterprise,g_master.l_xrcacomp,'S-FIN-2009') RETURNING l_sfin2009
   CASE l_sfin2009
        WHEN '1'  #依立帳日匯率(aooi160)
           LET g_master.l_curr_type = '2'
        WHEN '2'  #依立帳日月平均匯率(aooi170)
           LET g_master.l_curr_type = '3'
   END CASE
   
   DISPLAY BY NAME g_master.l_docdt,g_master.l_toaistype,
                   g_master.l_site,
                   g_master.l_xrcald,
                   g_master.l_curr_type
   
   LET g_master_o.* = g_master.*
END FUNCTION

################################################################################
# Descriptions...: RMA覆出單資訊
# Memo...........:
# Usage..........: CALL aisp340_rmdadocno_def(p_rmdadocno)
# Date & Author..: 160304 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_rmdadocno_def(p_rmdadocno)
DEFINE p_rmdadocno  LIKE rmda_t.rmdadocno
DEFINE l_prog       LIKE type_t.chr20
DEFINE l_slip3      LIKE type_t.chr20
DEFINE l_comp       LIKE ooef_t.ooef001
DEFINE l_ooef004    LIKE ooef_t.ooef004
DEFINE l_cnt        LIKE type_t.num10
DEFINE l_rmda004    LIKE rmda_t.rmda004
     
   INITIALIZE g_rmda.* TO NULL
   #RMA覆出單單頭檔
   SELECT DISTINCT rmdasite,rmda001,rmda007,rmda004
     INTO g_rmda.rmdasite,g_rmda.rmda001,g_rmda.rmda007,l_rmda004
     FROM rmda_t,rmdb_t
    WHERE rmdaent = g_enterprise AND rmdadocno = p_rmdadocno
      AND rmdaent = rmdbent AND rmdadocno = rmdbdocno  
      AND rmdastus = 'S' 

   #RMA報價單單頭檔
   SELECT rmba000,rmba009,rmba011
     INTO g_rmda.rmba000,g_rmda.rmba009,g_rmda.rmba011
     FROM rmba_t
    WHERE rmbaent = g_enterprise
      AND rmbadocno = l_rmda004
      AND rmba000 IN (SELECT MAX(rmba000) FROM rmba_t 
                       WHERE rmbaent = g_enterprise 
                         AND rmbadocno = l_rmda004)

   LET l_comp = NULL 
   SELECT glaald,ooef019,glaacomp 
     INTO g_master.l_xrcald,g_ooef019,l_comp   
     FROM glaa_t,ooef_t
    WHERE ooefent = glaaent 
      AND ooef017 = glaacomp
      AND glaaent = g_enterprise
      AND ooef001 = g_rmda.rmdasite
   
   #覆出單串rma單頭發票類型rmba009 
   LET g_master.l_xmdk015 = NULL
   SELECT rmba009 INTO g_master.l_xmdk015 
     FROM rmba_t
    WHERE rmbaent = g_enterprise
      AND rmbadocno = l_rmda004
      AND rmba000 IN (SELECT MAX(rmba000) FROM rmba_t 
                          WHERE rmbaent = g_enterprise 
                            AND rmbadocno = l_rmda004)

   LET g_master.l_xrcasite = g_rmda.rmdasite
   LET g_master.l_docdt   = g_rmda.rmda001
   
   LET g_isao014 = ''
   SELECT isao014 INTO g_isao014
     FROM isao_t
    WHERE isaoent = g_enterprise
      AND isaosite = g_rmda.rmdasite
      
   #出貨
   LET g_master.l_slip1 = g_isao014
   LET l_prog = 'axrt300'
      
   CALL s_desc_get_invoice_type_desc(g_master.l_xrcald,g_master.l_xmdk015)RETURNING g_master.l_xmdk015_desc
   
   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip1) RETURNING g_master.l_slip1_desc
   CALL s_desc_get_department_desc(g_master.l_site)RETURNING g_master.l_site_desc
   CALL s_desc_get_ld_desc(g_master.l_xrcald)RETURNING g_master.l_xrcald_desc
   
   #檢核預帶的單別
   CALL cl_err_collect_init()
   CALL s_aooi200_fin_chk_docno(g_master.l_xrcald,'','',g_master.l_slip1,g_master.l_docdt,'aist310')
      RETURNING g_sub_success
   CALL cl_err_collect_init()
   CALL cl_err_collect_show()
   
   IF NOT g_sub_success THEN
      LET g_master.l_slip1 = ''
   END IF

   DISPLAY BY NAME g_master.l_xmdk015,
                   g_master.l_docdt,
                   g_master.l_slip1,g_master.l_slip1_desc,g_master.l_xmdk015_desc,
                   g_master.l_xrcald_desc,g_master.l_xrcald,
                   g_master.l_site,g_master.l_site_desc
   CALL s_aooi200_get_slip(p_rmdadocno)RETURNING g_sub_success,l_slip3 

   CALL s_aooi100_sel_ooef004(g_rmda.rmdasite) RETURNING g_sub_success,l_ooef004
   CALL s_aooi210_set_chk(l_slip3,l_prog,l_ooef004,l_ooef004,'1')RETURNING l_cnt

   IF l_cnt > 0 THEN
      CALL s_aooi210_get_doc(g_rmda.rmdasite,'','2',l_slip3,l_prog,'Y')  
         RETURNING g_sub_success,g_master.l_slip2
   END IF

   CALL s_aooi200_fin_get_slip_desc(g_master.l_slip2) RETURNING g_master.l_slip2_desc
   DISPLAY BY NAME g_master.l_slip2_desc,g_master.l_slip2
   
   LET g_isai002 = ''
   LET g_isai008 = ''
   SELECT isai002,isai008 INTO g_isai002,g_isai008 FROM isai_t
    WHERE isaient = g_enterprise
      AND isai001 = g_ooef019

   CALL aisp340_visible()
      
   LET g_master_o.* = g_master.*
END FUNCTION
################################################################################
# Descriptions...: 組織可用之發票簿號檢查
# Memo...........:
# Usage..........: CALL aisp340_site_with_book_chk(p_site,p_book,p_dat,p_type)
# Date & Author..: 160303 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_site_with_book_chk(p_site,p_book,p_dat,p_type)
DEFINE p_site    LIKE ooef_t.ooef001
DEFINE p_book    LIKE isae_t.isae001
DEFINE p_dat     LIKE type_t.dat
DEFINE p_type    LIKE rmba_t.rmba009
DEFINE l_count   LIKE type_t.num10
DEFINE l_ooef017 LIKE ooef_t.ooef017
DEFINE l_isae012 LIKE isae_t.isae012
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
   
   
   LET r_success = TRUE
   LET r_errno  =''
   
   IF NOT cl_null(p_site) 
      AND NOT cl_null(p_book)
      AND NOT cl_null(p_dat)
      AND NOT cl_null(p_type)THEN
      LET l_ooef017 = NULL
      SELECT ooef017 INTO l_ooef017 FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_site
      
      LET l_count = NULL
      SELECT COUNT(*) INTO l_count FROM isae_t
       WHERE isaeent = g_enterprise
         AND isaesite IN (p_site,l_ooef017) 
         AND isae001  = p_book
         AND isae002 <= p_dat
         AND isae003 >= p_dat
         AND isae004 = p_type
      IF cl_null(l_count)THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_errno ='ais-00144'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      
     SELECT isae012
       INTO l_isae012
       FROM isae_t           
      WHERE isaeent = g_enterprise
        AND isaesite IN (p_site,l_ooef017) 
        AND isae001  = p_book
        AND isae002 <= p_dat
        AND isae003 >= p_dat
        AND isae004 = p_type
        
      IF cl_null(l_isae012)THEN
         LET r_errno = 'ais-00234'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
   END IF
   
   RETURN r_success,r_errno
END FUNCTION
################################################################################
# Descriptions...: 群組欄位隱顯
# Memo...........:
# Usage..........: CALL aisp340_visible()
# Date & Author..: 160303 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_visible()
   
   #發票代碼隱顯控制
   CALL cl_set_comp_visible('l_isaf010',TRUE)
   IF g_isai002 = '1' THEN
      CALL cl_set_comp_visible('l_isaf010',FALSE)
   END IF
   
END FUNCTION
################################################################################
# Descriptions...: 組織編號檢查
# Memo...........:
# Usage..........: CALL aisp340_ooef001_chk(p_ooef001)
# Date & Author..: 160303 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_ooef001_chk(p_ooef001)
DEFINE p_ooef001   LIKE ooef_t.ooef001
DEFINE r_success   LIKE type_t.num5
DEFINE l_stus      LIKE type_t.chr1
DEFINE r_errno     LIKE gzze_t.gzze001
   
   LET r_success = TRUE
   LET r_errno  = ''
   LET l_stus = NULL
   SELECT ooefstus FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = p_ooef001
      
   CASE
      WHEN SQLCA.SQLCODE = 100
         LET r_errno  = 'aoo-00094'
         LET r_success = FALSE
      WHEN l_stus <> 'Y'
         LET r_errno = 'axc-00105'
         LET r_success = FALSE
   END CASE
   
   
   RETURN r_success,r_errno
END FUNCTION
################################################################################
# Descriptions...: 發票簿檢查
# Memo...........:
# Usage..........: CALL aisp340_book_exist(p_dat,p_type)
# Date & Author..: 160303 By Jessy
# Modify.........:
################################################################################
PRIVATE FUNCTION aisp340_book_exist(p_dat,p_type)
DEFINE p_dat     LIKE type_t.dat
DEFINE p_type    LIKE rmba_t.rmba009
DEFINE r_success LIKE type_t.num5
DEFINE r_errno   LIKE gzze_t.gzze001
DEFINE l_count   LIKE type_t.num10
DEFINE l_ooef017 LIKE ooef_t.ooef017
DEFINE l_isae012 LIKE isae_t.isae012
   
   LET r_success = TRUE
   LET r_errno  =''
         
   LET l_count = NULL
   SELECT COUNT(*) INTO l_count FROM isae_t
    WHERE isaeent = g_enterprise
      AND isae002 <= p_dat
      AND isae003 >= p_dat
      AND isae004 = p_type
   IF cl_null(l_count)THEN LET l_count = 0 END IF
   IF l_count = 0 THEN
      LET r_errno ='ais-00284'
      LET r_success = FALSE
      RETURN r_success,r_errno
   END IF
   
   RETURN r_success,r_errno
END FUNCTION

#end add-point
 
{</section>}
 
