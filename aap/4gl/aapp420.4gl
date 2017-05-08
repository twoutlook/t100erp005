#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0012(2015-02-24 17:30:20), PR版次:0012(2017-01-10 16:16:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000188
#+ Filename...: aapp420
#+ Description: 付款沖銷單批次產生傳票作業
#+ Creator....: 02097(2014-06-04 00:00:00)
#+ Modifier...: 02097 -SD/PR- 04152
 
{</section>}
 
{<section id="aapp420.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150126-00027#1             By Belle    增加傳票補號
#150127-00007#1  2015/02/24 By Reanna   筆數顯示異常處理
#150212-00011#4  2015/03/03 By Reanna   傳票日期必須與帳款期間相同會計週期&已關帳的單據不可拋(立帳日>關帳日)
#150210-00011#4  2015/03/25 By Reanna   依立帳日取會計期間，限定可立帳的範圍為會計期間起始日~輸入立帳日
#150610-00023#5  2015/06/12 By apo      gen_ac統一呼叫s_aapp330_gen_ac()處理
#160318-00025#39 2016/04/22 By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160727-00019#36 2016/08/15 By 08734    临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#160812-00027#3  2016/08/16 By 06821    全面盤點應付程式帳套權限控管
#160920-00019#1  2016/09/21 By 08732    交易對象開窗校驗調整
#161006-00005#2  2016/10/12 By 08732    組織類型與職能開窗調整
#161115-00042#2  2016/11/18 By 08732    開窗範圍處理(1帳款對象控制組)
#161220-00041#1  2016/12/21 By 06948    調整請款單號範圍開窗(q_apdadocno)，已拋轉傳票請款單不顯示
#161229-00047#16 2017/01/10 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc" 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10             #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num10             #目前所在頁數
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
 
TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable) name="global.parameter"
   
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
       sel           LIKE type_t.chr1,
       statepic      LIKE type_t.chr1,
       apdasite      LIKE apda_t.apdasite,
       apdadocno     LIKE apda_t.apdadocno, 
       apdadocdt     LIKE apda_t.apdadocdt, 
       apda004       LIKE apda_t.apda004, 
       apda005       LIKE apda_t.apda005,
       apda005_desc  LIKE type_t.chr100
                 END RECORD
TYPE type_g_glaq_d        RECORD
       docno         LIKE apda_t.apdadocno,  #單據編號
       docdt         LIKE apda_t.apdadocdt,  #單據日期
       glaq022       LIKE glaq_t.glaq022,    #帳款客戶
       glaqseq       LIKE glaq_t.glaqseq,    #項次
       glaq001       LIKE glaq_t.glaq001,    #摘要
       glaq002       LIKE glaq_t.glaq002,    #科目編號
       glaq002_desc  LIKE type_t.chr300,     #科目說明
       glaq003       LIKE glaq_t.glaq003,    #借方金額(本幣一)
       glaq004       LIKE glaq_t.glaq004,    #貸方金額(本幣一)
       glaq040       LIKE glaq_t.glaq040,    #借方金額(本幣二)
       glaq041       LIKE glaq_t.glaq041,    #貸方金額(本幣二)
       glaq043       LIKE glaq_t.glaq043,    #借方金額(本幣三)
       glaq044       LIKE glaq_t.glaq044,    #貸方金額(本幣三)
       img           LIKE type_t.chr80
       END RECORD
TYPE type_g_input    RECORD
       apcasite      LIKE apca_t.apcasite,
       apcasite_desc LIKE type_t.chr80,
       apcald        LIKE apca_t.apcald,
       apcald_desc   LIKE type_t.chr80,
       apcacomp      LIKE apca_t.apcacomp,
       apcacomp_desc LIKE type_t.chr80,
       type          LIKE type_t.chr1,
       glapdocno     LIKE glap_t.glapdocno,
       glapdocdt     LIKE glap_t.glapdocdt,
       glstr_no      LIKE apca_t.apcadocno,
       glend_no      LIKE apca_t.apcadocno
                 END RECORD
TYPE type_g_qbe      RECORD
       apda003       LIKE apda_t.apda003,
       apda001       LIKE apda_t.apda001,
       apda004       LIKE apda_t.apda004,
       apdadocdt     LIKE apda_t.apdadocdt,
       apdadocno     LIKE apda_t.apdadocno
                 END RECORD
DEFINE g_input       type_g_input    #INPUT條件
DEFINE g_input_t     type_g_input    #150126-00027#1-備份INPUT條件
DEFINE g_qbe         type_g_qbe      #QBE條件

#變數
DEFINE g_rec_b       LIKE type_t.num5 
DEFINE g_rec_b2      LIKE type_t.num5 
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE g_detail_idxb LIKE type_t.num5        #紀錄最後指向位置
DEFINE g_glaa003     LIKE glaa_t.glaa003
DEFINE g_glaa013     LIKE glaa_t.glaa013     #最後關帳日期
DEFINE g_glaa102     LIKE glaa_t.glaa102     #借貸不平衡處理方式
DEFINE g_glaa015     LIKE glaa_t.glaa015
DEFINE g_glaa016     LIKE glaa_t.glaa016
DEFINE g_glaa019     LIKE glaa_t.glaa019
DEFINE g_glaa020     LIKE glaa_t.glaa020
DEFINE g_glaa024     LIKE glaa_t.glaa024
DEFINE g_glaa121     LIKE glaa_t.glaa121
DEFINE g_glaa100     LIKE glaa_t.glaa100     #150126-00027#1

DEFINE g_docno       LIKE apda_t.apdadocno   #單號
DEFINE g_docdt       LIKE apda_t.apdadocdt   #帳款日期
DEFINE g_apda004     LIKE apda_t.apda004     #帳款客戶
DEFINE g_flag        LIKE type_t.chr1
DEFINE g_flag2       LIKE type_t.chr1        #是否外部呼叫
DEFINE g_wc_apcald   STRING
DEFINE g_sql_ctrl    STRING                  #160920-00019#1---add
DEFINE g_comp_str    STRING                  #161229-00047#16
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp420.main" >}
#+ 作業開始 
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   DEFINE ls_js  STRING
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
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp420 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp420_init()   
 
      #進入選單 Menu (="N")
      CALL aapp420_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp420
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_voucher_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp420.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp420_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('apda001','8507','45')
   CALL s_aapp330_cre_tmp() RETURNING g_sub_success            #不走分錄時使用
   CALL s_pre_voucher_cre_tmp_table() RETURNING g_sub_success  #走分錄時使用
   CALL s_fin_continue_no_tmp()               #150126-00027#1
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔
   #160920-00019#1---s
   LET g_sql_ctrl = NULL
   #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 mark
   #160920-00019#1---e
   
   #161229-00047#16 mark ------
   ##161115-00042#2   add---s
   #LET g_input.apcacomp = ''
   #SELECT ooef017 INTO g_input.apcacomp
   #  FROM ooef_t
   # WHERE ooefent = g_enterprise
   #   AND ooef001 = g_site
   #   AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl
   ##161115-00042#2 add---e
   #161229-00047#16 mark ------
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp420.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp420_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_slip          LIKE ooba_t.ooba002
   DEFINE l_date          LIKE glap_t.glapdocdt
   DEFINE l_start_no      LIKE glap_t.glapdocno
   DEFINE l_end_no        LIKE glap_t.glapdocno
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.num5       #150212-00011#3
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CLEAR FORM
   CALL g_detail_d.clear()
   INITIALIZE g_input.* TO NULL
   INITIALIZE g_qbe.*   TO NULL
   INITIALIZE g_wc      TO NULL
   #預設值
   LET g_detail_idx = 1 
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      LET g_input.type = 1
      LET g_input.apcald  = g_argv[1]
      LET g_qbe.apdadocno = g_argv[2]
      LET g_input.apcasite= g_argv[5]
      LET g_input.glapdocno=g_argv[3]
      LET g_input.glapdocdt=g_argv[4]
      LET g_flag2 = 'Y' 
      LET g_wc = "apdadocno='",g_qbe.apdadocno,"'"
      
      #161115-00042#2   add---s
      LET g_input.apcacomp = ''
      SELECT ooef017 INTO g_input.apcacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_input.apcasite
         AND ooefstus = 'Y'
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#16 mark
      #161115-00042#2   add---e
   
   ELSE
      #帳務組織/帳套/法人預設
      CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                         g_input.apcald,g_input.apcacomp
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#16 mark
      LET g_input.type = 3
      CALL cl_set_comp_entry("glapdocdt",TRUE)
      LET g_flag2 = 'N'
   END IF
   
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc 
   CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING  g_input.apcacomp_desc
   CALL s_desc_get_department_desc(g_input.apcasite)RETURNING g_input.apcasite_desc  
   
   CALL aapp420_set_ld_info(g_input.apcald)
   
   DISPLAY BY NAME  g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,g_input.type,
                    g_input.apcasite,g_input.apcasite_desc
   DISPLAY g_qbe.apdadocno TO apdadocno
   
   CALL cl_set_comp_required("glapdocdt",FALSE)
   #如果依帳款客戶產生則產生日期為必填
   IF g_input.type = 3 THEN
      CALL cl_set_comp_required("glapdocdt" ,TRUE)
   END IF

   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp420_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         #INPUT區段

         INPUT g_input.apcasite,g_input.apcald,g_input.apcacomp,g_input.type,g_input.glapdocno,g_input.glapdocdt
         FROM apcasite,apcald,apcacomp,type,glapdocno,glapdocdt
               ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
               IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
                  CALL aapp420_query()
               END IF
               
            AFTER FIELD apcasite
               LET g_input.apcasite_desc = ''
               IF NOT cl_null(g_input.apcasite) THEN
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.apcasite = ''
                        CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                        DISPLAY BY NAME g_input.apcasite_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#16 mark
                  #161229-00047#16 add ------
                  SELECT ooef017 INTO g_input.apcacomp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_input.apcasite
                     AND ooefstus = 'Y'
                  CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
                  #161229-00047#16 add end---
                  CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
                  CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
                  CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
                  DISPLAY BY NAME g_input.apcasite_desc
                  
            AFTER FIELD apcald
               LET g_input.apcald_desc   = ''
               LET g_input.apcacomp_desc = ''
               IF NOT cl_null(g_input.apcald) THEN
                  #CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #160812-00027#3 mark
                  CALL s_fin_account_center_with_ld_chk(g_input.apcasite,g_input.apcald,g_user,'3','Y','',g_today) RETURNING g_success,g_errno      #160812-00027#3 add
                  IF NOT g_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_fin_ld_carry(g_input.apcald,'') RETURNING g_success,g_input.apcald,g_input.apcacomp,g_errno
                  IF NOT g_success THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = g_errno
                      LET g_errparam.extend = g_input.apcald
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      NEXT FIELD CURRENT
                  END IF
                  IF NOT g_success THEN LET g_input.apcald = '' END IF        
                  CALL aapp420_set_ld_info(g_input.apcald)
                  #150126-00027#1--(S)
                  IF g_input.apcald <> g_input_t.apcald THEN
                     DELETE FROM s_fin_tmp_conti_no
                  END IF
                  LET g_input_t.apcald = g_input.apcald
                  #150126-00027#1--(E)
               END IF
               #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#16 mark
               #161229-00047#16 add ------
               CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
               CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
               #161229-00047#16 add end---
               LET g_input.apcald_desc   = s_desc_get_ld_desc(g_input.apcald)
               LET g_input.apcacomp_desc = s_desc_get_department_desc(g_input.apcacomp)       
               DISPLAY g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc
                    TO apcald,apcald_desc,apcacomp,apcacomp_desc
                    
            AFTER FIELD type
               IF NOT g_input.type MATCHES '[12345]' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "apm-00379"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               
            ON CHANGE type
               CALL cl_set_comp_required("glapdocdt" ,FALSE) 
               #如果依帳款客戶產生則產生日期為必填 
               IF g_input.type MATCHES '[35]' THEN
                  CALL cl_set_comp_required("glapdocdt" ,TRUE)
               END IF
            
            AFTER FIELD glapdocno
               IF NOT cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_glaa024
                  LET g_chkparam.arg2 = g_input.glapdocno
                  #160318-00025#39  2016/04/22  by pengxin  add(S)
                  LET g_errshow = TRUE #是否開窗 
                  LET g_chkparam.err_str[1] = "agl-00189:sub-01302|aooi200|",cl_get_progname("aooi200",g_lang,"2"),"|:EXEPROGaooi200"
                  #160318-00025#39  2016/04/22  by pengxin  add(E)
                  IF cl_chk_exist("v_ooba002_07") THEN
                     #150126-00027#1--(S)
                     IF g_input_t.glapdocno <> g_input.glapdocno THEN
                        DELETE FROM s_fin_tmp_conti_no
                     END IF
                     LET g_input_t.glapdocno = g_input.glapdocno
                     #150126-00027#1--(E)
                  ELSE
                     LET g_input.glapdocno = ''
                     #150126-00027#1--(S)
                     DELETE FROM s_fin_tmp_conti_no
                     LET g_input_t.glapdocno = g_input.glapdocno
                     #150126-00027#1--(E)
                     NEXT FIELD CURRENT
                  END IF
                END IF
            
            #150126-00027#1--(S)
            AFTER FIELD glapdocdt
               IF g_input_t.glapdocdt <> g_input.glapdocdt THEN
                  DELETE FROM s_fin_tmp_conti_no
               END IF
               LET g_input_t.glapdocdt = g_input.glapdocdt
               
               SELECT glaa013 INTO g_glaa013 
                 FROM glaa_t
                WHERE glaaent = g_enterprise AND glaald = g_input.apcald

               IF NOT cl_null(g_input.glapdocdt) AND g_input.glapdocdt <= g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.glapdocdt = ''
                  LET g_input_t.glapdocdt = g_input.glapdocdt
                  CONTINUE DIALOG
               END IF
            
            ON ACTION cont_no
               IF cl_null(g_input.apcald)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','apcald')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','glapdocno')
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               IF cl_null(g_input.glapdocdt) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00331'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
               
               CALL s_transaction_begin()
               CALL s_fin_continue_no_input(g_input.apcald,'',g_input.glapdocno,g_input.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
               
            #150126-00027#1--(E)      
            
           ON ACTION controlp INFIELD apcald
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_input.apcald                     #給予default值
             LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND ",  #glaa008(平行記帳)/glaa014(主帳套)
                                    "  glaald IN ",g_wc_apcald
             LET g_qryparam.arg1 = g_user                                 #人員權限
             LET g_qryparam.arg2 = g_dept                                 #部門權限
             CALL q_authorised_ld()                                       #呼叫開窗
             LET g_input.apcald = g_qryparam.return1                      #將開窗取得的值回傳到變數
             NEXT FIELD apcald                                            #返回原欄位  
            
            ON ACTION controlp INFIELD apcasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.apcasite
               #CALL q_ooef001()     #161006-00005#2  mark
               CALL q_ooef001_46()   #161006-00005#2  add
               LET g_input.apcasite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.apcasite) RETURNING g_input.apcasite_desc
               DISPLAY BY NAME g_input.apcasite,g_input.apcasite_desc
               NEXT FIELD apcasite
               
            ON ACTION controlp INFIELD glapdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapdocno  #給予default值
               LET g_qryparam.arg1 = g_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_input.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_input.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno                          #返回原欄位   
               
               
         
       
        END INPUT
        #查詢QBE
        CONSTRUCT BY NAME g_wc ON apda003,apda001,apda004,apdadocdt,
                               apdadocno,apda005
           BEFORE CONSTRUCT
              CALL cl_qbe_init()
       
           AFTER CONSTRUCT
             #呼叫P次作業
                              
           ON ACTION controlp INFIELD apda003
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
              LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
              DISPLAY g_qryparam.return1 TO apda003  #顯示到畫面上  
              NEXT FIELD apda003                     #返回原欄位 
         
            ON ACTION controlp INFIELD apdadocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " apdastus = 'Y' AND apdald = '",g_input.apcald,"' "
                                     ," AND ( apda014 = '' OR apda014 IS NULL ) "       #161220-00041#1 add
               CALL q_apdadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apdadocno  #顯示到畫面上  
               NEXT FIELD apdadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD apda004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160920-00019#1---s
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #160920-00019#1---e
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apda004  #顯示到畫面上
               NEXT FIELD apda004                     #返回原欄位  
               
            ON ACTION controlp INFIELD apda005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160920-00019#1---s
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #160920-00019#1---e
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO apda005  #顯示到畫面上
               NEXT FIELD apda005   
               
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #單身1
         INPUT ARRAY g_detail_d FROM s_detail1.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                      INSERT ROW = FALSE,
                      DELETE ROW = FALSE,
                      APPEND ROW = FALSE)

            #150127-00007#1 add---
            BEFORE ROW
               LET l_ac = ARR_CURR()
               DISPLAY l_ac TO FORMONLY.h_index
            #150127-00007#1 add end---
            
            #150212-00011#4 add---
            ON CHANGE sel
               CALL aapp420_chk_date(g_detail_d[l_ac].apdadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_detail_d[l_ac].sel = 'N'
               END IF
            #150212-00011#4 add end---
            
         END INPUT

         #end add-point
 
         BEFORE DIALOG
            IF g_detail_d.getLength() > 0 THEN
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
            ELSE
               CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
               CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            END IF
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            IF g_flag2 = 'Y' THEN
               DISPLAY g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,g_input.type
                    TO apcald,apcald_desc,apcacomp,apcacomp_desc,type
               DISPLAY g_qbe.apdadocno TO apdadocno
            END IF
            
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            #CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
            CALL cl_set_comp_visible('statepic',FALSE)
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
   
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            #150212-00011#4 add---
            CALL s_azzi902_get_gzzd('aapp330',"lbl_apcadocno_error") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               CALL aapp420_chk_date(g_detail_d[li_idx].apdadocdt) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apdadocno
                  CALL cl_err()
                  LET g_detail_d[li_idx].sel = 'N'
               END IF
            END FOR
            CALL cl_err_collect_show()
            #150212-00011#4 add end---
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "Y"
               END IF
            END FOR
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            #150212-00011#4 add---
            CALL aapp420_chk_date(g_detail_d[l_ac].apdadocdt) RETURNING g_sub_success,g_errno
            IF NOT g_sub_success THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = g_errno
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_detail_d[l_ac].sel = 'N'
            END IF
            #150212-00011#4 add end---
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aapp420_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
      
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
      
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION accept
            #add-point:ui_dialog段accept之前 name="menu.filter"
            
            #end add-point
            CALL aapp420_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            CALL g_detail_d.clear()
            INITIALIZE g_input.* TO NULL
            INITIALIZE g_input_t.*  TO NULL  #150126-00027#1
            INITIALIZE g_qbe.*   TO NULL
            INITIALIZE g_wc      TO NULL                                 
            CALL s_aap_get_default_apcasite('','','') RETURNING g_sub_success,g_errno,g_input.apcasite,
                                                                g_input.apcald,g_input.apcacomp
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161229-00047#16 mark
            LET g_input.type = 3
            CALL cl_set_comp_entry("glapdocdt",TRUE)
            LET g_flag2 = 'N'
            #取得帳務組織下所屬成員
            CALL s_fin_account_center_sons_query('3',g_input.apcasite,g_today,'')
            CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
            CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
            
            CALL s_desc_get_ld_desc(g_input.apcald) RETURNING g_input.apcald_desc 
            CALL s_desc_get_department_desc(g_input.apcacomp) RETURNING  g_input.apcacomp_desc
            CALL s_desc_get_department_desc(g_input.apcasite)RETURNING g_input.apcasite_desc  
            CALL aapp420_set_ld_info(g_input.apcald)
            DISPLAY BY NAME  g_input.apcald,g_input.apcald_desc,g_input.apcacomp,g_input.apcacomp_desc,g_input.type,
                             g_input.apcasite,g_input.apcasite_desc
            
            DISPLAY g_qbe.apdadocno TO apdadocno
               
            CALL cl_set_comp_required("glapdocdt" ,FALSE) 
            #如果依帳款客戶產生則產生日期為必填 
            IF g_input.type = 3 THEN
               CALL cl_set_comp_required("glapdocdt" ,TRUE)
            END IF
            NEXT FIELD apcasite
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp420_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         #批次執行
         ON ACTION batch_execute
            #以來源客戶產生,傳票日期需有值,且不可小於關帳日
            IF g_input.type = '3' THEN
               IF cl_null('l_date') THEN
                  CONTINUE DIALOG
               END IF
               IF NOT cl_null(g_input.glapdocdt) AND g_input.glapdocdt <= g_glaa013 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00077'
                  LET g_errparam.extend =  ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CONTINUE DIALOG
               END IF
            END IF
            
            CALL s_transaction_begin()
            DELETE  FROM s_voucher_tmp
            
            #150212-00011#3 add---
            LET l_flag = 1 #1:可執行0:錯誤了
            CALL s_azzi902_get_gzzd('aapp330',"lbl_apcadocno_error") RETURNING g_coll_title[1],g_coll_title[1]  #單據編號
            CALL cl_err_collect_init()
            #150212-00011#3 add end---
            FOR li_idx = 1 TO g_detail_cnt
               IF g_detail_d[li_idx].sel = 'N' THEN
                  CONTINUE FOR
               ELSE
                  #-150713apo--(s)
                  LET l_count = 0
                  SELECT COUNT(*) INTO l_count
                    FROM apda_t
                   WHERE apdaent = g_enterprise
                     AND apdald = g_input.apcald
                     AND apdadocno = g_detail_d[li_idx].apdadocno
                     AND apda014 IS NOT NULL
                  IF l_count > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00052'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apdadocno
                     CALL cl_err()
                     CONTINUE FOR
                  END IF
                  #-150713apo--(e)                     
                  #150212-00011#4 add---
                  CALL aapp420_chk_date(g_detail_d[li_idx].apdadocdt) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     LET g_errparam.coll_vals[1]  = g_detail_d[li_idx].apdadocno
                     CALL cl_err()
                     LET l_flag = 0
                  END IF
                  #150212-00011#4 add end---

                  #將勾選的單號塞進temp_table    
                  INSERT INTO s_voucher_tmp (docno,type)
                     VALUES ( g_detail_d[li_idx].apdadocno , '0' )

               END IF
            END FOR
            #150212-00011#3 add---
            CALL cl_err_collect_show()
            IF l_flag = 0 THEN
               CONTINUE DIALOG
            END IF
            #150212-00011#3 add end---
            
            SELECT count(*) INTO l_count FROM s_voucher_tmp
            IF l_count > 0 THEN
               
               IF NOT g_glaa121 = 'Y' THEN     
                  CALL s_aapp330_gen_ac('1','P20',g_input.apcald,'','',g_input.type,'!#@','Y') RETURNING g_sub_success,l_start_no,l_end_no
               END IF
               IF g_sub_success THEN
                  CALL s_transaction_end('Y','Y')
               ELSE
                  CALL s_transaction_end('N','Y')
                  DISPLAY '' ,0 TO stagenow,stagecomplete
               END IF
               
               CALL s_transaction_begin()
               CALL cl_err_collect_init()
               CALL s_aapp330_generate_voucher('P20',g_input.glapdocno,g_input.glapdocdt,g_input.apcald,g_input.type,'Y',g_glaa102,'AP')
                    RETURNING g_sub_success,g_input.glstr_no,g_input.glend_no
               CALL cl_err_collect_show()   
               IF g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00217'
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()               
                  CALL s_transaction_end('Y','Y')
               ELSE
                  CALL s_transaction_end('N','Y')
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'adz-00218'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               DISPLAY BY NAME g_input.glstr_no,g_input.glend_no
            END IF
         #end add-point
 
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:22) ---start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:22) --- end ---
 
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #(ver:22) ---start---
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         #(ver:22) --- end ---
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp420.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp420_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   #end add-point
        
   LET g_error_show = 1
   CALL aapp420_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   #150212-00011#4 add---
   IF l_ac = 0 THEN
      LET l_ac = 1
   END IF
   #150212-00011#4 add end---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp420_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_dfin0030       LIKE type_t.chr1
   DEFINE l_ap_slip        LIKE apca_t.apcadocno
   DEFINE l_apcacomp       LIKE apca_t.apcacomp
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
   DEFINE l_wdate         LIKE glav_t.glav004
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_glav007       LIKE glav_t.glav007
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #必要欄位必要輸入
   IF cl_null(g_input.glapdocno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'acr-00015'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL g_detail_d.clear()
      CALL cl_err()
      RETURN
   END IF
   
   IF g_input.type = '3' THEN
      IF cl_null(g_input.glapdocdt) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'acr-00015'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL g_detail_d.clear() 
         CALL cl_err()
         RETURN
      END IF
   END IF
  
   #已確認(apdastus)/未拋轉傳票(apda014)
   LET g_sql = "SELECT 'Y','',apdasite,apdadocno,apdadocdt,",
               "       apda004,apda005 ",
               "  FROM apda_t",
               " WHERE apdastus = 'Y' AND apdaent = ?      ",
               "   AND apdasite = '",g_input.apcasite,"'                  ",
               "   AND apda014 IS NULL ", 
               #161115-00042#2   add---s
               "   AND EXISTS (SELECT 1 FROM pmaa_t ",
               "               WHERE pmaaent = ",g_enterprise,
               "               AND ",g_sql_ctrl,
               "               AND pmaaent = apdaent ",
               "               AND pmaa001 = apda005 ) ",
               #161115-00042#2   add---e
               "   AND apdald   = '",g_input.apcald,"' AND ",g_wc
   IF NOT cl_null(g_input.glapdocdt) THEN
      LET l_year = YEAR(g_input.glapdocdt)
      LET l_month = MONTH(g_input.glapdocdt)
      CALL s_get_accdate(g_glaa003,'',l_year,l_month) #取得會計當期起始日
            RETURNING g_sub_success,g_errno,l_glav002,l_glav005,l_wdate,l_wdate,
                      l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate,l_wdate
      #LET g_sql = g_sql, " AND apdadocdt BETWEEN '",l_pdate_s,"' AND '",l_pdate_e,"'"        #150210-00011#4 mark
      LET g_sql = g_sql, " AND apdadocdt BETWEEN '",l_pdate_s,"' AND '",g_input.glapdocdt,"'" #150210-00011#4
   END IF
   #end add-point
 
   PREPARE aapp420_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp420_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   CALL cl_err_collect_init()
   CALL aapp420_voucher_preview()   #傳票資料準備
   #end add-point
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
 
   FOREACH b_fill_curs USING g_enterprise INTO 
   #add-point:b_fill段foreach_into name="b_fill.foreach_into"
   g_detail_d[l_ac].*
   #end add-point
   
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #add-point:b_fill段資料填充 name="b_fill.foreach_iside"
      CALL s_aooi200_fin_get_slip(g_detail_d[l_ac].apdadocno) RETURNING g_sub_success,l_ap_slip
      CALL s_fin_get_doc_para(g_input.apcald,l_apcacomp,l_ap_slip,'D-FIN-0030') RETURNING l_dfin0030
      IF NOT l_dfin0030 = 'Y' THEN
         CONTINUE FOREACH
      END IF
      LET g_detail_d[l_ac].sel = 'Y'
      IF g_detail_d[l_ac].apdadocdt <= g_glaa013 THEN 
         LET g_detail_d[l_ac].sel = 'N'
      END IF
      #150212-00011#4 add---
      CALL aapp420_chk_date(g_detail_d[l_ac].apdadocdt) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET g_detail_d[l_ac].sel = 'N'
      END IF
      #150212-00011#4 add end---
      CALL s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].apda005)RETURNING g_detail_d[l_ac].apda005_desc
      #end add-point
      
      CALL aapp420_detail_show()      
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   LET g_error_show = 0
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.other_table"
   ERROR "" 
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #產生方式是 1.來源單據產生 及 2.帳款單日期 表示 傳票拋轉時的日期為apdadocdt
   #因此 需檢查拋轉到傳票的日期是否小於總帳關帳日
  # IF (g_input.type = '1' OR g_input.type = '2') AND g_flag = 'N' THEN
      CALL cl_err_collect_show() 
  # END IF
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aapp420_sel
   
   LET l_ac = 1
   CALL aapp420_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   DISPLAY l_ac TO FORMONLY.h_index #150127-00007#1
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp420.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp420_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   IF cl_null(g_detail_idx) THEN LET g_detail_idx = g_detail_idxb END IF
   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN
      LET g_detail_idx = 1 
   END IF
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aapp420.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp420_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp420.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp420_filter()
   #add-point:filter段define(客製用) name="filter.define_customerization"
   
   #end add-point    
   #add-point:filter段define name="filter.define"
   
   #end add-point
   
   DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
      ON UPDATE
 
   END DISPLAY
 
   LET l_ac = 1
   LET g_detail_cnt = 1
   #add-point:filter段define name="filter.detail_cnt"
   
   #end add-point    
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   
   CALL aapp420_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp420.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp420_filter_parser(ps_field)
   #add-point:filter段define(客製用) name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define name="filter_parser.define"
   
   #end add-point    
   
   #一般條件解析
   LET ls_tmp = ps_field, "='"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
   END IF
 
   #模糊條件解析
   LET ls_tmp = ps_field, " like '"
   LET li_tmp = g_wc_filter.getIndexOf(ls_tmp,1)
   IF li_tmp > 0 THEN
      LET li_tmp = ls_tmp.getLength() + li_tmp
      LET li_tmp2 = g_wc_filter.getIndexOf("'",li_tmp + 1) - 1
      LET ls_var = g_wc_filter.subString(li_tmp,li_tmp2)
      LET ls_var = cl_replace_str(ls_var,'%','*')
   END IF
 
   RETURN ls_var
 
END FUNCTION
 
{</section>}
 
{<section id="aapp420.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp420_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapp420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp420.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

PRIVATE FUNCTION aapp420_idx_chk()
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_detail_d.getLength() THEN
         LET g_detail_idx = g_detail_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_detail_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_detail_d.getLength() TO FORMONLY.cnt
   END IF
END FUNCTION

################################################################################
# Descriptions...: 
# Usage..........: CALL aapp420_voucher_def_cursor()
# Date & Author..: 14/05/20 By Belle
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp420_voucher_def_cursor()
DEFINE l_sql      STRING 
DEFINE l_sql2     STRING
DEFINE l_row_cnt  LIKE type_t.num5

   IF g_detail_idx = 0 OR cl_null(g_detail_idx) THEN LET g_detail_idx = 1 END IF

   LET l_sql  = " SELECT DISTINCT docno        FROM s_vr_tmp05 WHERE docno = ? "  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
   LET l_sql2 = " SELECT COUNT(DISTINCT docno) FROM s_vr_tmp05 WHERE docno = ? "  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
   
   CASE g_input.type #彙總方式
        WHEN '1'
             LET l_sql  = l_sql , " ORDER BY docno "
             LET l_sql2 = l_sql2, " ORDER BY docno "
        WHEN '2'
             LET l_sql  = l_sql , " ORDER BY docdt "
             LET l_sql2 = l_sql2, " ORDER BY docdt "
        WHEN '3'
             LET l_sql  = l_sql , " ORDER BY glaq022 "
             LET l_sql2 = l_sql2, " ORDER BY glaq022 "
   END CASE

   PREPARE aapp420_pre  FROM l_sql
   DECLARE aapp420_cs   SCROLL CURSOR WITH HOLD FOR aapp420_pre 
   OPEN aapp420_cs      USING g_detail_d[g_detail_idx].apdadocno
   
   PREPARE aapp420_pre2 FROM l_sql2
   DECLARE aapp420_cnt  CURSOR FOR aapp420_pre2
   OPEN aapp420_cnt     USING g_detail_d[g_detail_idx].apdadocno
   FETCH aapp420_cnt INTO l_row_cnt 
   DISPLAY l_row_cnt TO FORMONLY.cnt
   FREE aapp420_cnt
     
END FUNCTION

################################################################################
# Descriptions...: 傳票預覽
# Memo...........:
# Usage..........: CALL aapp420_voucher_preview()
# Date & Author..: 14/05/19 By Belle
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp420_voucher_preview()
DEFINE l_success       LIKE type_t.num5
DEFINE l_start_no      LIKE glap_t.glapdocno
DEFINE l_end_no        LIKE glap_t.glapdocno

   CALL s_transaction_begin()

   #傳入參數:往來帳類型/來源類型/帳別/立帳日期/憑證單別/彙總方式/QBE/是否預覽,預覽時 不需立帳日及傳票單別
  #CALL s_voucher_gen_ac('1','aapt400',g_input.apcald,'','',g_input.type,g_wc,'Y') RETURNING l_success,l_start_no,l_end_no   #150610-00023#5 mark
   CALL s_aapp330_gen_ac('1','P20',g_input.apcald,'','',g_input.type,'!#@','Y') RETURNING g_sub_success,l_start_no,l_end_no  #150610-00023#5
   
   IF l_success THEN
      CALL s_transaction_end('Y','Y')
      CALL aapp420_voucher_def_cursor() 
   ELSE
      CALL s_transaction_end('N','Y')    
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 帳套預設資訊
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp420_set_ld_info(p_ld)
DEFINE p_ld          LIKE glaa_t.glaald

   CALL s_ld_sel_glaa(p_ld,'glaa015|glaa016|glaa019|glaa020|glaa102|glaacomp|glaa121|glaa024|glaa100|glaa003')
   RETURNING g_sub_success,g_glaa015,g_glaa016,g_glaa019,
             g_glaa020,g_glaa102,g_input.apcacomp,g_glaa121,g_glaa024,
             g_glaa100,g_glaa003
   
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#2 add #161115-00042#2 add #161229-00047#16 mark
   #161229-00047#16 add ------
   CALL s_fin_get_wc_str(g_input.apcacomp) RETURNING g_comp_str
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#16 add end---
   
   SELECT glaa013 INTO g_glaa013
     FROM glaa_t
    WHERE glaaent = g_enterprise AND glaald = p_ld
   
   IF g_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
   ELSE
     CALL cl_set_comp_visible('cont_no',TRUE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: 檢核單據日期是否符合 #150212-00011#4
# Memo...........:
# Usage..........: CALL aapp420_chk_date(p_apdadocdt)
#                  RETURNING r_success,r_errno
# Date & Author..: 2015/03/03 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp420_chk_date(p_apdadocdt)
DEFINE p_apdadocdt     LIKE apda_t.apdadocdt
DEFINE l_year          LIKE type_t.num5
DEFINE l_month         LIKE type_t.num5
DEFINE l_flag          LIKE type_t.chr1
DEFINE l_errno         LIKE type_t.chr100
DEFINE l_pdate_s       LIKE glav_t.glav004   #當期起始日
DEFINE l_pdate_e       LIKE glav_t.glav004   #當期截止日
DEFINE l_wdate         LIKE glav_t.glav004
DEFINE l_glav002       LIKE glav_t.glav002
DEFINE l_glav005       LIKE glav_t.glav005
DEFINE l_glav006       LIKE glav_t.glav006
DEFINE l_glav007       LIKE glav_t.glav007
DEFINE r_success       LIKE type_t.num5
DEFINE r_errno         LIKE type_t.chr100
   
   LET r_success = TRUE
   
   #判斷傳票日期有值否，有值用此來推算出當期會計週期起始日，單據的立帳日必須在這區間內
   IF NOT cl_null(g_input.glapdocdt) THEN
      #取得會計週期參照表
      LET l_year = YEAR(g_input.glapdocdt)
      LET l_month = MONTH(g_input.glapdocdt)
      #取得會計當期起始日
      CALL s_get_accdate(g_glaa003,'',l_year,l_month)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_wdate,l_wdate,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate,l_wdate
      IF NOT cl_null(l_pdate_s) AND NOT cl_null(l_pdate_e) THEN
         IF p_apdadocdt < l_pdate_s OR p_apdadocdt > l_pdate_e THEN
            LET r_errno = 'aap-00340'
            LET r_success = FALSE
         END IF
      END IF
   END IF
   
   #判斷立帳日期>關帳日
   IF NOT cl_null(g_glaa013) THEN
      IF p_apdadocdt <= g_glaa013 THEN
         LET r_errno = 'aap-00341'
         LET r_success = FALSE
      END IF
   END IF
   
   RETURN r_success,r_errno
   
END FUNCTION

#end add-point
 
{</section>}
 
