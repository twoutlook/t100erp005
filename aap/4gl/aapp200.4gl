#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2016-02-02 11:18:43), PR版次:0008(2017-01-06 16:26:22)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000069
#+ Filename...: aapp200
#+ Description: 結算應付帳款批次產生作業
#+ Creator....: 02114(2015-05-11 10:21:06)
#+ Modifier...: 02114 -SD/PR- 06821
 
{</section>}
 
{<section id="aapp200.global" >}
#應用 p01 樣板自動產生(Version:19)
#add-point:填寫註解說明 name="global.memo" name="global.memo"
#160321-00016#19   2016/03/31  By Jessy         將重複內容的錯誤訊息置換為公用錯誤訊息
#160318-00025#26   2016/04/28  BY 07900         校验代码重复错误讯息的修改
#160511-00018#1    2016/05/20  By 01531         SELECT语句调整
#161006-00005#7    2016/10/12  By 08732         組織類型與職能開窗調整
#161115-00046#1    2016/11/23  By 08729         開窗增加過濾據點
#161229-00047#9    2017/01/06  By 06821         財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
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
       apcasite LIKE apca_t.apcasite, 
   apcasite_desc LIKE type_t.chr80, 
   apcald LIKE apca_t.apcald, 
   apcald_desc LIKE type_t.chr80, 
   glav002 LIKE glav_t.glav002, 
   glav006 LIKE glav_t.glav006, 
   chk_21 LIKE type_t.chr500, 
   chk_23 LIKE type_t.chr500, 
   chk_24 LIKE type_t.chr500, 
   chk_22 LIKE type_t.chr500, 
   chk_29 LIKE type_t.chr500, 
   chk_25 LIKE type_t.chr500, 
   b_comb LIKE type_t.chr500, 
   rate1 LIKE type_t.chr500, 
   source LIKE type_t.chr500, 
   apcadocdt LIKE apca_t.apcadocdt, 
   apcadocno LIKE apca_t.apcadocno, 
   apcadocno_desc LIKE type_t.chr80, 
   apca007 LIKE apca_t.apca007, 
   apca007_desc LIKE type_t.chr80, 
   apca003 LIKE apca_t.apca003, 
   apca003_desc LIKE type_t.chr80, 
   apca008 LIKE apca_t.apca008, 
   apca008_desc LIKE type_t.chr80, 
   apca011 LIKE apca_t.apca011, 
   apca011_desc LIKE type_t.chr80, 
   stdgdocno LIKE type_t.chr20, 
   stbg006 LIKE type_t.chr10, 
   stagenow LIKE type_t.chr80,
       wc               STRING
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_master type_master
 
#add-point:自定義模組變數(Module Variable) name="global.variable"
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_master_o      type_master
DEFINE g_wc_apcasite   STRING
DEFINE g_wc_apcald     STRING
DEFINE g_wc2           STRING
DEFINE g_apcacomp      LIKE ooef_t.ooef017
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa024       LIKE glaa_t.glaa024
DEFINE g_ooef019       LIKE ooef_t.ooef019   #稅區參照表(依據所屬法人所帶的設定)
DEFINE g_pdate_s       LIKE glav_t.glav004   #立帳日期對應起始日(會計週期)
DEFINE g_pdate_e       LIKE glav_t.glav004   #立帳日期對應截止日(會計週期)
DEFINE g_no_use        STRING
DEFINE g_dfin3500      LIKE ooac_t.ooac004      #20150624 add lujh 
DEFINE g_apbbdocno_wc  LIKE apbb_t.apbbdocno    #20150723 add lujh
DEFINE g_sql_ctrl      STRING                   #161115-00046#1-add 
DEFINE g_wc_cs_comp    STRING  #161229-00047#9 add
DEFINE g_comp_str      STRING  #161229-00047#9 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp200.main" >}
MAIN
   #add-point:main段define (客製用) name="main.define_customerization"
   
   #end add-point 
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   #add-point:main段define name="main.define"
   DEFINE l_sql           STRING
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:初始化前定義 name="main.before_ap_init"
   
   #end add-point
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #20151010 Mark ---(S)--- By 01727
   #20150723--add--str--lujh
   #LET g_master.wc = "apbbdocno = '",g_argv[01],"'"
   #LET g_apbbdocno_wc = g_argv[01]
   #20150723--add--end--lujh
   #20151010 Mark ---(E)--- By 01727
   IF NOT cl_null(g_argv[01]) THEN
      LET g_bgjob = g_argv[01]
   END IF
   #end add-point
 
   #背景(Y) 或半背景(T) 時不做主畫面開窗
   IF g_bgjob = "Y" OR g_bgjob = "T" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
      LET ls_js = g_argv[01]
     #CALL util.JSON.parse(ls_js,g_master)   #p類主要使用l_param,此處不解析
      #add-point:Service Call name="main.servicecall"
      #20151010 Add  ---(S)--- By 01727
      CALL s_fin_create_account_center_tmp()    #帳務中心
      CALL s_aapp330_cre_tmp() RETURNING g_sub_success
      LET g_master.apcasite = g_argv[02]
      LET g_master.apcald   = g_argv[03]
      LET g_master.glav002  = g_argv[04]
      LET g_master.glav006  = g_argv[05]
      LET g_master.wc = "apbbdocno = '",g_argv[06],"'"
      LET g_master.rate1  = '2'
      LET g_master.apca003 = g_user
      LET g_master.apcadocdt = g_argv[07]
      LET g_master.chk_21 = 'Y'
      LET g_master.chk_22 = 'Y'
      LET g_master.chk_23 = 'Y'
      LET g_master.chk_24 = 'Y'
      LET g_master.chk_25 = 'Y'
      LET g_master.chk_29 = 'Y'
      LET g_master.source = g_argv[08]   #151201-00002#61 add lujh

      CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024')
         RETURNING  g_sub_success,g_glaa003,g_glaa024

      #151201-00002#61--mark--str--lujh
      #LET l_sql = "SELECT DISTINCT ooba002 ",
      #            "  FROM ooba_t ",
      #            "  LEFT OUTER JOIN ooac_t ",
      #            "    ON ooacent = oobaent ",
      #            "   AND ooac001 = ooba001 ",
      #            "   AND ooac002 = ooba002 ",
      #            " WHERE oobaent = ",g_enterprise,
      #            "   AND ooba002 IN (SELECT oobl001 ",
      #            "                     FROM oobl_t ",
      #            "                    WHERE ooblent = ",g_enterprise,
      #            "                      AND oobl002 = 'aapt210')",
      #            "   AND oobastus = 'Y' ",
      #            "   AND ooba001 = '",g_glaa024,"'",
      #            "   AND ooac003 = 'D-FIN-3500' ",
      #            "   AND ooac004 = 'Y' ",
      #            " ORDER BY ooba002 "
      #151201-00002#61--mark--end--lujh
      
      #151201-00002#61--add--str--lujh
      LET l_sql = "SELECT DISTINCT ooba002 ",
                  "  FROM ooba_t ",
                  " WHERE oobaent = ",g_enterprise,
                  "   AND ooba002 IN (SELECT oobl001 ",
                  "                     FROM oobl_t ",
                  "                    WHERE ooblent = ",g_enterprise,
                  "                      AND oobl002 = 'aapt210')",
                  "   AND oobastus = 'Y' ",
                  "   AND ooba001 = '",g_glaa024,"'",
                  " ORDER BY ooba002 "
      #151201-00002#61--add--end--lujh
      PREPARE ooba_pre1_b FROM l_sql
      DECLARE ooba_cur1_b SCROLL CURSOR WITH HOLD FOR ooba_pre1_b
      OPEN ooba_cur1_b
      FETCH FIRST ooba_cur1_b INTO g_master.apcadocno
      CLOSE ooba_cur1_b
   
      #151201-00002#61--mark--str--lujh
      #LET l_sql = "SELECT DISTINCT ooba002 ",
      #            "  FROM ooba_t ",
      #            "  LEFT OUTER JOIN ooac_t ",
      #            "    ON ooacent = oobaent ",
      #            "   AND ooac001 = ooba001 ",
      #            "   AND ooac002 = ooba002 ",
      #            " WHERE oobaent = ",g_enterprise,
      #            "   AND ooba002 IN (SELECT oobl001 ",
      #            "                     FROM oobl_t ",
      #            "                    WHERE ooblent = ",g_enterprise,
      #            "                      AND oobl002 = 'aapt210')",
      #            "   AND oobastus = 'Y' ",
      #            "   AND ooba001 = '",g_glaa024,"'",
      #            "   AND ooac003 = 'D-FIN-3500' ",
      #            "   AND ooac004 = 'N' ",
      #            " ORDER BY ooba002 "
      #PREPARE ooba_pre2_b FROM l_sql
      #DECLARE ooba_cur2_b SCROLL CURSOR WITH HOLD FOR ooba_pre2_b
      #OPEN ooba_cur2_b
      #FETCH FIRST ooba_cur2_b INTO g_master.b_apcadocno
      #CLOSE ooba_cur2_b
      #151201-00002#61--mark--end--lujh
      #20151010 Add  ---(E)--- By 01727
      #end add-point
      CALL aapp200_process(ls_js)
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp200 WITH FORM cl_ap_formpath("aap",g_code)
 
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
 
      #程式初始化
      CALL aapp200_init()
 
      #進入選單 Menu (="N")
      CALL aapp200_ui_dialog()
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp200
   END IF
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp200.init" >}
#+ 初始化作業
PRIVATE FUNCTION aapp200_init()
 
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
   CALL cl_set_combo_scc("rate1","9951")
   CALL s_fin_create_account_center_tmp()                #帳務中心
   CALL s_aap_create_multi_bill_perod_tmp()              #新增多帳期FUNCTION用的TEMP TABLE
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success
   CALL cl_set_combo_scc("source","8350")     #151201-00002#61 add lujh
   #161115-00046#1-add(s)
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#9 mark
   #161115-00046#1-add(e)
   #161229-00047#9 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#9 --e add    
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp200.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp200_ui_dialog()
 
   #add-point:ui_dialog段define (客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit  LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx   LIKE type_t.num10
   DEFINE ls_js    STRING
   DEFINE ls_wc    STRING
   DEFINE l_dialog ui.DIALOG
   DEFINE lc_param type_parameter
   #add-point:ui_dialog段define name="ui_dialog.define"
   DEFINE l_success              LIKE type_t.num5
   DEFINE l_origin_str           STRING  
   DEFINE l_glaacomp             LIKE glaa_t.glaacomp
   DEFINE apcadocno_dis          LIKE apca_t.apcadocno   
   #end add-point
   
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL aapp200_qbe_clear()
   LET g_errshow = 1
   #end add-point
 
   WHILE TRUE
      #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
      
      #end add-point
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #應用 a57 樣板自動產生(Version:3)
         INPUT BY NAME g_master.apcasite,g_master.apcald,g_master.glav002,g_master.glav006,g_master.chk_21, 
             g_master.chk_23,g_master.chk_24,g_master.chk_22,g_master.chk_29,g_master.chk_25,g_master.b_comb, 
             g_master.rate1,g_master.source,g_master.apcadocdt,g_master.apcadocno,g_master.apca007,g_master.apca003, 
             g_master.apca008,g_master.apca011 
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            #自訂ACTION(master_input)
            
         
            BEFORE INPUT
               #add-point:資料輸入前 name="input.m.before_input"
               
               #end add-point
         
                     #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcasite
            
            #add-point:AFTER FIELD apcasite name="input.a.apcasite"
            #帳務中心
#            LET g_master.apcald_desc = ''
#            IF NOT cl_null(g_master.apcasite) THEN    
#               IF g_master.apcasite != g_master_o.apcasite THEN
#                  CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING g_sub_success,g_errno,g_apcacomp,g_master.apcald
#               END IF            
#               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
#               IF NOT g_sub_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
#               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
#               #取得帳務中心底下之組織範圍
#               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
#               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
#               #取得帳務中心底下的帳套範圍               
#               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
#               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
#               CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024   #150210apo               
#               #取得該法人的稅區
#               SELECT ooef019 INTO g_ooef019
#                 FROM ooef_t
#                WHERE ooefent = g_enterprise AND ooef001 = l_apcacomp                 
#               LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
#               LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
#               DISPLAY BY NAME g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
#            END IF 
            
            LET g_master.apcald_desc = ''
            IF NOT cl_null(g_master.apcasite) THEN
               CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
               IF g_master.apcasite != g_master_o.apcasite THEN
                 CALL s_fin_orga_get_comp_ld(g_master.apcasite) RETURNING l_success,g_errno,g_apcacomp,g_master.apcald
                 CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str #161229-00047#9 add 
                 CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#9 add 
                 #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#1-add #161229-00047#9 mark
               END IF
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.apcasite
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  LET g_master.apcasite = g_master_o.apcasite
                  LET g_master.apcald = g_master_o.apcald
                  NEXT FIELD CURRENT
               END IF
               #取得帳務中心底下之組織範圍
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               #取得帳務中心底下的帳套範圍               
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
               #取得該法人的稅區
               SELECT ooef019 INTO g_ooef019
                 FROM ooef_t
                WHERE ooefent = g_enterprise AND ooef001 = l_apcacomp                 
               LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
               LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
               DISPLAY BY NAME g_master.apcasite_desc,g_master.apcald,g_master.apcald_desc
            END IF
            CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
            LET g_master_o.apcasite = g_master.apcasite 
            LET g_master_o.apcald = g_master.apcald
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcasite
            #add-point:BEFORE FIELD apcasite name="input.b.apcasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcasite
            #add-point:ON CHANGE apcasite name="input.g.apcasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcald
            
            #add-point:AFTER FIELD apcald name="input.a.apcald"
            #帳套
#            LET g_master.apcald_desc = ''
#            IF NOT cl_null(g_master.apcald) THEN         
#               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) 
#                  RETURNING g_sub_success,g_errno
#               IF NOT g_sub_success THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = g_errno
#                  LET g_errparam.extend = ''
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#                  NEXT FIELD CURRENT
#               END IF
#            END IF
#            CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,g_apcacomp,g_errno
#            CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024   #150210apo            
#            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
#            DISPLAY BY NAME g_master.apcald_desc
            
            LET g_master.apcald_desc = ''
            IF NOT cl_null(g_master.apcald) THEN
               CALL s_fin_account_center_with_ld_chk(g_master.apcasite,g_master.apcald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_master.apcald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  LET g_master.apcald = ''
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_fin_ld_carry(g_master.apcald,'') RETURNING g_sub_success,g_master.apcald,g_apcacomp,g_errno
            CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024   #150210apo            
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald_desc
            LET g_master_o.apcald = g_master.apcald
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcald
            #add-point:BEFORE FIELD apcald name="input.b.apcald"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcald
            #add-point:ON CHANGE apcald name="input.g.apcald"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav002
            #add-point:BEFORE FIELD glav002 name="input.b.glav002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav002
            
            #add-point:AFTER FIELD glav002 name="input.a.glav002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav002
            #add-point:ON CHANGE glav002 name="input.g.glav002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav006
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_master.glav006,">=1.000","0","<=13.000","0","azz-00087",1) THEN
               NEXT FIELD glav006
            END IF 
 
 
 
            #add-point:AFTER FIELD glav006 name="input.a.glav006"
            IF NOT cl_null(g_master.glav006) THEN 
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav006
            #add-point:BEFORE FIELD glav006 name="input.b.glav006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav006
            #add-point:ON CHANGE glav006 name="input.g.glav006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_21
            #add-point:BEFORE FIELD chk_21 name="input.b.chk_21"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_21
            
            #add-point:AFTER FIELD chk_21 name="input.a.chk_21"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_21
            #add-point:ON CHANGE chk_21 name="input.g.chk_21"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_23
            #add-point:BEFORE FIELD chk_23 name="input.b.chk_23"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_23
            
            #add-point:AFTER FIELD chk_23 name="input.a.chk_23"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_23
            #add-point:ON CHANGE chk_23 name="input.g.chk_23"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_24
            #add-point:BEFORE FIELD chk_24 name="input.b.chk_24"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_24
            
            #add-point:AFTER FIELD chk_24 name="input.a.chk_24"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_24
            #add-point:ON CHANGE chk_24 name="input.g.chk_24"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_22
            #add-point:BEFORE FIELD chk_22 name="input.b.chk_22"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_22
            
            #add-point:AFTER FIELD chk_22 name="input.a.chk_22"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_22
            #add-point:ON CHANGE chk_22 name="input.g.chk_22"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_29
            #add-point:BEFORE FIELD chk_29 name="input.b.chk_29"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_29
            
            #add-point:AFTER FIELD chk_29 name="input.a.chk_29"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_29
            #add-point:ON CHANGE chk_29 name="input.g.chk_29"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk_25
            #add-point:BEFORE FIELD chk_25 name="input.b.chk_25"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk_25
            
            #add-point:AFTER FIELD chk_25 name="input.a.chk_25"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk_25
            #add-point:ON CHANGE chk_25 name="input.g.chk_25"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_comb
            #add-point:BEFORE FIELD b_comb name="input.b.b_comb"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_comb
            
            #add-point:AFTER FIELD b_comb name="input.a.b_comb"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE b_comb
            #add-point:ON CHANGE b_comb name="input.g.b_comb"
            #C151028-004#2 Add  ---(S)---
            IF NOT cl_null(g_master.b_comb) THEN
               IF g_master.b_comb = '1' THEN
                  CALL cl_set_comp_entry('apcadocno',TRUE)
                  CALL cl_set_comp_visible('grid_4',TRUE)
                  CALL cl_set_comp_visible('grid_5',FALSE)
               ELSE
                  CALL cl_set_comp_entry('apcadocno',FALSE)
                  CALL cl_set_comp_visible('grid_4',FALSE)
                  CALL cl_set_comp_visible('grid_5',TRUE)
                  LET g_master.apcadocno = ''
                  LET g_master.apcadocno_desc = ''
               END IF
               DISPLAY BY NAME g_master.apcadocno,g_master.apcadocno_desc
            END IF
           #C151028-004#2 Add  ---(E)---
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD rate1
            #add-point:BEFORE FIELD rate1 name="input.b.rate1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD rate1
            
            #add-point:AFTER FIELD rate1 name="input.a.rate1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE rate1
            #add-point:ON CHANGE rate1 name="input.g.rate1"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD source
            #add-point:BEFORE FIELD source name="input.b.source"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD source
            
            #add-point:AFTER FIELD source name="input.a.source"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE source
            #add-point:ON CHANGE source name="input.g.source"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocdt
            #add-point:BEFORE FIELD apcadocdt name="input.b.apcadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocdt
            
            #add-point:AFTER FIELD apcadocdt name="input.a.apcadocdt"
            IF NOT cl_null(g_master.apcadocdt) THEN
               CALL s_fin_date_close_chk('',g_master.apcasite,'AAP',g_master.apcadocdt) RETURNING l_success
               IF NOT l_success THEN
                  NEXT FIELD CURRENT
               END IF  
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocdt
            #add-point:ON CHANGE apcadocdt name="input.g.apcadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcadocno
            
            #add-point:AFTER FIELD apcadocno name="input.a.apcadocno"
            #帳款單別
            LET g_master.apcadocno_desc = ''
            DISPLAY BY NAME g_master.apcadocno_desc
            IF NOT cl_null(g_master.apcadocno) THEN 
               CALL s_aooi200_fin_chk_slip(g_master.apcald,g_glaa024,g_master.apcadocno,'aapt210') RETURNING l_success
               IF l_success = FALSE THEN 
                  LET g_master.apcadocno = ''
                  NEXT FIELD apcadocno
               END IF
               
               #151201-00002#61--mark--str--lujh
               ##20150624--add--str--lujh
               #CALL s_fin_get_doc_para(g_master.apcald,'',g_master.apcadocno,'D-FIN-3500') RETURNING g_dfin3500
               #
               #IF g_dfin3500 <> 'Y' THEN 
               #   INITIALIZE g_errparam TO NULL
               #   LET g_errparam.extend = g_master.apcadocno
               #   LET g_errparam.code   = "aap-00412"
               #   LET g_errparam.popup  = TRUE
               #   CALL cl_err()
               #
               #   LET g_master.apcadocno = ''
               #   NEXT FIELD apcadocno
               #END IF
               ##20150624--add--end--lujh
               #151201-00002#61--mark--end--lujh
            END IF
            CALL s_aooi200_fin_get_slip_desc(g_master.apcadocno)RETURNING g_master.apcadocno_desc
            DISPLAY BY NAME g_master.apcadocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcadocno
            #add-point:BEFORE FIELD apcadocno name="input.b.apcadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcadocno
            #add-point:ON CHANGE apcadocno name="input.g.apcadocno"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca007
            
            #add-point:AFTER FIELD apca007 name="input.a.apca007"
            #帳款類別
            LET g_master.apca007_desc = ' '
            IF NOT cl_null(g_master.apca007) THEN
               IF NOT s_azzi650_chk_exist('3211',g_master.apca007) THEN
                  LET g_master.apca007 = ''
                  LET g_master.apca007_desc = ' '
                  DISPLAY BY NAME g_master.apca007_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.apca007_desc
            DISPLAY BY NAME g_master.apca007_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca007
            #add-point:BEFORE FIELD apca007 name="input.b.apca007"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca007
            #add-point:ON CHANGE apca007 name="input.g.apca007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca003
            
            #add-point:AFTER FIELD apca003 name="input.a.apca003"
            LET g_master.apca003_desc = ''
            IF NOT cl_null(g_master.apca003) THEN  
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL      
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.apca003
               #160318-00025#26  by 07900 --add-str
               LET g_errshow = TRUE #是否開窗                   
               LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
               #160318-00025#26  by 07900 --add-end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooag001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET g_master.apca003 = ''
                  LET g_master.apca003_desc = ''
                  DISPLAY BY NAME g_master.apca003_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_person_desc(g_master.apca003) RETURNING g_master.apca003_desc
            DISPLAY BY NAME g_master.apca003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca003
            #add-point:BEFORE FIELD apca003 name="input.b.apca003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca003
            #add-point:ON CHANGE apca003 name="input.g.apca003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca008
            
            #add-point:AFTER FIELD apca008 name="input.a.apca008"
            LET g_master.apca008_desc = ''
            IF NOT cl_null(g_master.apca008) THEN               
               CALL s_aap_ooib002_chk(g_master.apca008,'1')RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  #160321-00016#19 --s add
                  LET g_errparam.replace[1] = 'aooi716'
                  LET g_errparam.replace[2] = cl_get_progname('aooi716',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi716'
                  #160321-00016#19 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.apca008 = ''
                  CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.apca008_desc
                  DISPLAY BY NAME g_master.apca008_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.apca008_desc
            DISPLAY BY NAME g_master.apca008_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca008
            #add-point:BEFORE FIELD apca008 name="input.b.apca008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca008
            #add-point:ON CHANGE apca008 name="input.g.apca008"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca011
            
            #add-point:AFTER FIELD apca011 name="input.a.apca011"
            LET g_master.apca011_desc = ''
            IF NOT cl_null(g_master.apca011) THEN
               CALL s_tax_chk(g_apcacomp,g_master.apca011) RETURNING g_sub_success,g_no_use,g_no_use,g_no_use,g_no_use
               IF NOT g_sub_success THEN
                  LET g_master.apca011 = ''
                  LET g_master.apca011_desc = ''
                  DISPLAY BY NAME g_master.apca011_desc                   
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_tax_desc(g_ooef019,g_master.apca011) RETURNING g_master.apca011_desc
            DISPLAY BY NAME g_master.apca011_desc   

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca011
            #add-point:BEFORE FIELD apca011 name="input.b.apca011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca011
            #add-point:ON CHANGE apca011 name="input.g.apca011"
            
            #END add-point 
 
 
 
                     #Ctrlp:input.c.apcasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcasite
            #add-point:ON ACTION controlp INFIELD apcasite name="input.c.apcasite"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcasite       
            #CALL q_ooef001()      #161006-00005#7   mark
            CALL q_ooef001_46()    #161006-00005#7   add                              
            LET g_master.apcasite = g_qryparam.return1        
            CALL s_desc_get_department_desc(g_master.apcasite) RETURNING g_master.apcasite_desc
            DISPLAY BY NAME g_master.apcasite,g_master.apcasite_desc 
            NEXT FIELD apcasite


            #END add-point
 
 
         #Ctrlp:input.c.apcald
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcald
            #add-point:ON ACTION controlp INFIELD apcald name="input.c.apcald"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apcald                    
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_apcald
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()                                       
            LET g_master.apcald = g_qryparam.return1                     
            LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
            DISPLAY BY NAME g_master.apcald,g_master.apcald_desc
            NEXT FIELD apcald


            #END add-point
 
 
         #Ctrlp:input.c.glav002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav002
            #add-point:ON ACTION controlp INFIELD glav002 name="input.c.glav002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav006
            #add-point:ON ACTION controlp INFIELD glav006 name="input.c.glav006"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_21
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_21
            #add-point:ON ACTION controlp INFIELD chk_21 name="input.c.chk_21"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_23
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_23
            #add-point:ON ACTION controlp INFIELD chk_23 name="input.c.chk_23"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_24
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_24
            #add-point:ON ACTION controlp INFIELD chk_24 name="input.c.chk_24"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_22
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_22
            #add-point:ON ACTION controlp INFIELD chk_22 name="input.c.chk_22"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_29
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_29
            #add-point:ON ACTION controlp INFIELD chk_29 name="input.c.chk_29"
            
            #END add-point
 
 
         #Ctrlp:input.c.chk_25
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk_25
            #add-point:ON ACTION controlp INFIELD chk_25 name="input.c.chk_25"
            
            #END add-point
 
 
         #Ctrlp:input.c.b_comb
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_comb
            #add-point:ON ACTION controlp INFIELD b_comb name="input.c.b_comb"
            
            #END add-point
 
 
         #Ctrlp:input.c.rate1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD rate1
            #add-point:ON ACTION controlp INFIELD rate1 name="input.c.rate1"
            
            #END add-point
 
 
         #Ctrlp:input.c.source
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD source
            #add-point:ON ACTION controlp INFIELD source name="input.c.source"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocdt
            #add-point:ON ACTION controlp INFIELD apcadocdt name="input.c.apcadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcadocno
            #add-point:ON ACTION controlp INFIELD apcadocno name="input.c.apcadocno"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.apcadocno             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = 'aapt210'
            #151201-00002#61--mark--str--lujh
            #20150624--add--str--lujh
            #LET g_qryparam.arg3 = 'D-FIN-3500'
            #LET g_qryparam.arg4 = "'Y'"
            #20150624--add--end--lujh
            #151201-00002#61--mark--end--lujh

            #CALL q_ooba002_1()                #呼叫開窗   #20150624 mark lujh
            #CALL q_ooba002_11()                           #20150624 add lujh    #151201-00002#61 mark lujh
            CALL q_ooba002_1()                            #151201-00002#61 add lujh

            LET g_master.apcadocno = g_qryparam.return1              
            CALL s_aooi200_fin_get_slip_desc(g_master.apcadocno)RETURNING g_master.apcadocno_desc
            DISPLAY BY NAME g_master.apcadocno,g_master.apcadocno_desc
            DISPLAY g_master.apcadocno TO apcadocno              #
            
            NEXT FIELD apcadocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apca007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca007
            #add-point:ON ACTION controlp INFIELD apca007 name="input.c.apca007"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.apca007             #給予default值
            LET g_qryparam.default2 = "" #g_master.oocql004 #說明
            #給予arg
            LET g_qryparam.arg1 = "3211"


            CALL q_oocq002()                                #呼叫開窗

            LET g_master.apca007 = g_qryparam.return1              
            CALL s_desc_get_acc_desc('3211',g_master.apca007) RETURNING g_master.apca007_desc
            DISPLAY BY NAME g_master.apca007_desc
            DISPLAY g_master.apca007 TO apca007              #
            NEXT FIELD apca007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apca003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca003
            #add-point:ON ACTION controlp INFIELD apca003 name="input.c.apca003"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_master.apca003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_ooag001()                                #呼叫開窗

            LET g_master.apca003 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_master.apca003) RETURNING g_master.apca003_desc
            DISPLAY BY NAME g_master.apca003_desc
            DISPLAY g_master.apca003 TO apca003              #

            NEXT FIELD apca003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apca008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca008
            #add-point:ON ACTION controlp INFIELD apca008 name="input.c.apca008"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca008
            CALL q_ooib001_2()
            LET g_master.apca008 = g_qryparam.return1
            CALL s_desc_get_ooib002_desc(g_master.apca008) RETURNING g_master.apca008_desc
            DISPLAY BY NAME g_master.apca008,g_master.apca008_desc
            NEXT FIELD apca008


            #END add-point
 
 
         #Ctrlp:input.c.apca011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca011
            #add-point:ON ACTION controlp INFIELD apca011 name="input.c.apca011"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.apca011
            LET g_qryparam.arg1 = g_ooef019                   #稅區
            CALL q_oodb002_5()
            LET g_master.apca011 = g_qryparam.return1
            CALL s_desc_get_tax_desc(g_ooef019,g_master.apca011) RETURNING g_master.apca011_desc
            DISPLAY BY NAME g_master.apca011_desc                
            NEXT FIELD apca011


            #END add-point
 
 
 
               
            AFTER INPUT
               #add-point:資料輸入後 name="input.m.after_input"
               
               #end add-point
               
            #add-point:其他管控(on row change, etc...) name="input.other"
            
            #end add-point
         END INPUT
 
 
 
         
         #應用 a58 樣板自動產生(Version:3)
         CONSTRUCT BY NAME g_master.wc ON stdgdocno,stbg006
            BEFORE CONSTRUCT
               #add-point:cs段before_construct name="cs.head.before_construct"
               #應用 a08 樣板自動產生(Version:2)
               
               #end add-point 
         
            #公用欄位開窗相關處理
            
               
            #一般欄位開窗相關處理    
                     #Ctrlp:construct.c.stdgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stdgdocno
            #add-point:ON ACTION controlp INFIELD stdgdocno name="construct.c.stdgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            SELECT glaacomp INTO l_glaacomp FROM glaa_t WHERE glaaent = g_enterprise
               AND glaald = g_master.apcald
            LET g_qryparam.where = "stdh026 = '",l_glaacomp,"' AND stdh027 = '1'"
            CALL q_stdgdocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdgdocno  #顯示到畫面上
            NEXT FIELD stdgdocno                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stdgdocno
            #add-point:BEFORE FIELD stdgdocno name="construct.b.stdgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stdgdocno
            
            #add-point:AFTER FIELD stdgdocno name="construct.a.stdgdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.stbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD stbg006
            #add-point:ON ACTION controlp INFIELD stbg006 name="construct.c.stbg006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stdg006  #顯示到畫面上
            NEXT FIELD stdg006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD stbg006
            #add-point:BEFORE FIELD stbg006 name="construct.b.stbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD stbg006
            
            #add-point:AFTER FIELD stbg006 name="construct.a.stbg006"
            
            #END add-point
            
 
 
 
            
            #add-point:其他管控 name="cs.other"
            
            #end add-point
            
         END CONSTRUCT
 
 
 
      
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT BY NAME g_master.wc ON apbb010,apbbdocno,apbb002
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD apbb010
               #add-point:ON ACTION controlp INFIELD stbd001
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "     isamcomp = '",g_apcacomp,"'",
                                      #20150729--add--str--lujh
                                      " AND isamdocno NOT IN (SELECT apbbdocno FROM apbb_t ",
                                      "                        WHERE apbbent = '",g_enterprise,"'",
                                      "                          AND apbbud001 IS NOT NULL",
                                      "                      )"
                                      #20150729--add--end--lujh
               CALL q_isam010()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbb010      #顯示到畫面上
               NEXT FIELD apbb010                         #返回原欄位
               
            ON ACTION controlp INFIELD apbbdocno
               #add-point:ON ACTION controlp INFIELD stbd001
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "     apbbcomp = '",g_apcacomp,"'",
                                      " AND apbb056 = 'Y' AND apbbstus = 'Y' " 
               #161115-00046#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaaent = apbbent ",
                                                          "                AND pmaa001 = apbb002 )"
               END IF
               #161115-00046#1-add(e)               
               CALL q_apbbdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbbdocno      #顯示到畫面上
               NEXT FIELD apbbdocno                         #返回原欄位
               
            ON ACTION controlp INFIELD apbb002
               #add-point:ON ACTION controlp INFIELD stbd001
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #161115-00046#1-add(s)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #161115-00046#1-add(e)
               CALL q_pmaa001_10()                          #呼叫開窗
               DISPLAY g_qryparam.return1 TO apbb002        #顯示到畫面上
               NEXT FIELD apbb002                           #返回原欄位
            
         END CONSTRUCT
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
            CALL aapp200_get_buffer(l_dialog)
            #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog3"
            DISPLAY g_apbbdocno_wc TO apbbdocno    #20150723 add lujh
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
            CALL aapp200_qbe_clear()
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
         CALL aapp200_init()
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
                 CALL aapp200_process(ls_js)
 
            WHEN g_schedule.gzpa003 = "1"
                 LET ls_js = aapp200_transfer_argv(ls_js)
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
 
{<section id="aapp200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION aapp200_transfer_argv(ls_js)
 
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
 
{<section id="aapp200.process" >}
#+ 資料處理   (r類使用g_master為主處理/p類使用l_param為主)
PRIVATE FUNCTION aapp200_process(ls_js)
 
   #add-point:process段define (客製用) name="process.define_customerization"
   
   #end add-point
   DEFINE ls_js         STRING
   DEFINE lc_param      type_parameter
   DEFINE li_stus       LIKE type_t.num5
   DEFINE li_count      LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql        STRING             #主SQL
   DEFINE li_p01_status LIKE type_t.num5
   #add-point:process段define name="process.define"
   DEFINE l_origin_str           STRING   
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
#  DECLARE aapp200_process_cs CURSOR FROM ls_sql
#  FOREACH aapp200_process_cs INTO
   #add-point:process段process name="process.process"
   IF cl_null(g_master.b_comb) THEN
      LET g_master.b_comb = '1'
   END IF
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理 name="process.foreground_finish"
      CALL s_fin_account_center_sons_query('12',g_master.apcasite,g_today,'1')
      CALL s_fin_account_center_comp_str()RETURNING l_origin_str
      CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
      
      CALL cl_err_collect_init()
      IF g_master.b_comb = '1' THEN
         CALL s_aapp200_p(g_master.*,l_origin_str)
      ELSE
         CALL s_aapp200_p1(g_master.*,l_origin_str)
      END IF
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_ask_confirm3("std-00012","")
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理 name="process.background_finish"
      CALL s_fin_account_center_sons_query('12',g_master.apcasite,g_today,'1')
      CALL s_fin_account_center_comp_str()RETURNING l_origin_str
      CALL s_fin_get_wc_str(l_origin_str)RETURNING l_origin_str
      
      CALL cl_err_collect_init()
      IF g_master.b_comb = '1' THEN
         CALL s_aapp200_p(g_master.*,l_origin_str)
      ELSE
         CALL s_aapp200_p1(g_master.*,l_origin_str)
      END IF
      CALL cl_err_collect_show()
      #end add-point
      CALL cl_schedule_exec_call(li_p01_status)
   END IF
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL aapp200_msgcentre_notify()
 
END FUNCTION
 
{</section>}
 
{<section id="aapp200.get_buffer" >}
PRIVATE FUNCTION aapp200_get_buffer(p_dialog)
 
   #add-point:process段define (客製用) name="get_buffer.define_customerization"
   
   #end add-point
   DEFINE p_dialog   ui.DIALOG
   #add-point:process段define name="get_buffer.define"
   
   #end add-point
 
   
   LET g_master.apcasite = p_dialog.getFieldBuffer('apcasite')
   LET g_master.apcald = p_dialog.getFieldBuffer('apcald')
   LET g_master.glav002 = p_dialog.getFieldBuffer('glav002')
   LET g_master.glav006 = p_dialog.getFieldBuffer('glav006')
   LET g_master.chk_21 = p_dialog.getFieldBuffer('chk_21')
   LET g_master.chk_23 = p_dialog.getFieldBuffer('chk_23')
   LET g_master.chk_24 = p_dialog.getFieldBuffer('chk_24')
   LET g_master.chk_22 = p_dialog.getFieldBuffer('chk_22')
   LET g_master.chk_29 = p_dialog.getFieldBuffer('chk_29')
   LET g_master.chk_25 = p_dialog.getFieldBuffer('chk_25')
   LET g_master.b_comb = p_dialog.getFieldBuffer('b_comb')
   LET g_master.rate1 = p_dialog.getFieldBuffer('rate1')
   LET g_master.source = p_dialog.getFieldBuffer('source')
   LET g_master.apcadocdt = p_dialog.getFieldBuffer('apcadocdt')
   LET g_master.apcadocno = p_dialog.getFieldBuffer('apcadocno')
   LET g_master.apca007 = p_dialog.getFieldBuffer('apca007')
   LET g_master.apca003 = p_dialog.getFieldBuffer('apca003')
   LET g_master.apca008 = p_dialog.getFieldBuffer('apca008')
   LET g_master.apca011 = p_dialog.getFieldBuffer('apca011')
 
   CALL cl_schedule_get_buffer(p_dialog)
 
   #add-point:get_buffer段其他欄位處理 name="get_buffer.others"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapp200.msgcentre_notify" >}
PRIVATE FUNCTION aapp200_msgcentre_notify()
 
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
 
{<section id="aapp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 清空&給預設 
# Memo...........:
# Usage..........: CALL aapp200_qbe_clear()
# Date & Author..: 2015/05/11 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp200_qbe_clear()
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004
   DEFINE l_sql           STRING
   
   INITIALIZE g_master.* TO NULL
   
   #CALL cl_set_comp_required("apcadocdt",TRUE)
   LET g_master.rate1  = '2'
   LET g_master.apcadocdt= ''
   LET g_master.chk_21 = 'Y'
   LET g_master.chk_22 = 'Y'
   LET g_master.chk_23 = 'Y'
   LET g_master.chk_24 = 'Y'
   LET g_master.chk_25 = 'Y'
   LET g_master.chk_29 = 'Y'
   LET g_master.source = '1'     #151201-00002#61 add lujh

   #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_master.apcasite,g_errno
   
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_master.apcasite
      
   SELECT glaald INTO g_master.apcald
     FROM glaa_t
    WHERE glaacomp = g_apcacomp
      AND glaa014 = 'Y'
      AND glaaent = g_enterprise #160511-00018#1
   
   CALL s_fin_account_center_sons_query('3',g_master.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   CALL s_ld_sel_glaa(g_master.apcald,'glaa003|glaa024') RETURNING  g_sub_success,g_glaa003,g_glaa024
   CALL s_fin_get_wc_str(g_apcacomp) RETURNING g_comp_str #161229-00047#9 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#9 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00046#1-add #161229-00047#9 mark
   #取得該法人的稅區
   SELECT ooef019 INTO g_ooef019
     FROM ooef_t
    WHERE ooefent = g_enterprise AND ooef001 = g_apcacomp
   LET g_master.apcald_desc  = s_desc_get_ld_desc(g_master.apcald)
   LET g_master.apcasite_desc= s_desc_get_department_desc(g_master.apcasite)
   LET g_master_o.apcasite = g_master.apcasite
   LET g_master_o.apcald = g_master.apcald
   LET g_master.apca003 = g_user
   LET g_master.apcadocdt = g_today
   #依年度+期別取得會計週期起迄日
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,g_pdate_s,g_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   
   LET g_master.glav002 = l_glav002
   LET g_master.glav006 = l_glav006
   DISPLAY BY NAME g_master.apcald  ,g_master.apcald_desc,
                   g_master.apcasite,g_master.apcasite_desc,
                   g_master.apcadocdt,g_master.glav002,
                   g_master.glav006,g_master.source    #151201-00002#61 add g_master.source lujh

  #C151028-004#2 Add  ---(S)---
   LET g_master.b_comb = '1'
   CALL cl_set_comp_entry('apcadocno',TRUE)
   CALL cl_set_comp_visible('grid_4',TRUE)
   CALL cl_set_comp_visible('grid_5',FALSE)
  #C151028-004#2 Add  ---(e)---


   #20150828--add--str--lujh
   #151201-00002#61--mark--str--lujh
   #LET l_sql = "SELECT DISTINCT ooba002 ",
   #            "  FROM ooba_t ",
   #            "  LEFT OUTER JOIN ooac_t ",
   #            "    ON ooacent = oobaent ",
   #            "   AND ooac001 = ooba001 ",
   #            "   AND ooac002 = ooba002 ",
   #            " WHERE oobaent = ",g_enterprise,
   #            "   AND ooba002 IN (SELECT oobl001 ",
   #            "                     FROM oobl_t ",
   #            "                    WHERE ooblent = ",g_enterprise,
   #            "                      AND oobl002 = 'aapt210')",
   #            "   AND oobastus = 'Y' ",
   #            "   AND ooba001 = '",g_glaa024,"'",
   #            "   AND ooac003 = 'D-FIN-3500' ",
   #            "   AND ooac004 = 'Y' ",
   #            " ORDER BY ooba002 "
   #151201-00002#61--mark--end--lujh
   
   #151201-00002#61--add--str--lujh
   LET l_sql = "SELECT DISTINCT ooba002 ",
               "  FROM ooba_t ",
               " WHERE oobaent = ",g_enterprise,
               "   AND ooba002 IN (SELECT oobl001 ",
               "                     FROM oobl_t ",
               "                    WHERE ooblent = ",g_enterprise,
               "                      AND oobl002 = 'aapt210')",
               "   AND oobastus = 'Y' ",
               "   AND ooba001 = '",g_glaa024,"'",
               " ORDER BY ooba002 "
   #151201-00002#61--add--end--lujh
   
   PREPARE ooba_pre1 FROM l_sql
   DECLARE ooba_cur1 SCROLL CURSOR WITH HOLD FOR ooba_pre1
   OPEN ooba_cur1
   FETCH FIRST ooba_cur1 INTO g_master.apcadocno
   CLOSE ooba_cur1
   CALL s_aooi200_fin_get_slip_desc(g_master.apcadocno)RETURNING g_master.apcadocno_desc
   DISPLAY BY NAME g_master.apcadocno_desc
   
   #151201-00002#61--mark--str--lujh
   #LET l_sql = "SELECT DISTINCT ooba002 ",
   #            "  FROM ooba_t ",
   #            "  LEFT OUTER JOIN ooac_t ",
   #            "    ON ooacent = oobaent ",
   #            "   AND ooac001 = ooba001 ",
   #            "   AND ooac002 = ooba002 ",
   #            " WHERE oobaent = ",g_enterprise,
   #            "   AND ooba002 IN (SELECT oobl001 ",
   #            "                     FROM oobl_t ",
   #            "                    WHERE ooblent = ",g_enterprise,
   #            "                      AND oobl002 = 'aapt210')",
   #            "   AND oobastus = 'Y' ",
   #            "   AND ooba001 = '",g_glaa024,"'",
   #            "   AND ooac003 = 'D-FIN-3500' ",
   #            "   AND ooac004 = 'N' ",
   #            " ORDER BY ooba002 "
   #PREPARE ooba_pre2 FROM l_sql
   #DECLARE ooba_cur2 SCROLL CURSOR WITH HOLD FOR ooba_pre2
   #OPEN ooba_cur2
   #FETCH FIRST ooba_cur2 INTO g_master.b_apcadocno
   #CLOSE ooba_cur2
   #CALL s_aooi200_fin_get_slip_desc(g_master.b_apcadocno)RETURNING g_master.b_apcadocno_desc
   #DISPLAY BY NAME g_master.b_apcadocno_desc
   #151201-00002#61--mark--end--lujh
   #20150828--add--end--lujh
END FUNCTION

#end add-point
 
{</section>}
 
