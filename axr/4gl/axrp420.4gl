#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0011(2015-02-04 22:12:13), PR版次:0011(2016-11-25 13:39:25)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000182
#+ Filename...: axrp420
#+ Description: 收款核銷單批次產生傳票作業
#+ Creator....: 02114(2014-11-17 14:51:13)
#+ Modifier...: 02114 -SD/PR- 01727
 
{</section>}
 
{<section id="axrp420.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150129-01727#1   zhangweib    增加傳票補號
#160727-00019#35  2016/08/11  By 08734   临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
#160727-00019#34  2016/08/15  By 08734   临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
#160727-00019#36  2016/08/15  By 08734   临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
#160509-00004#118 2016/08/17  By 02114   axrp420不能选到axrt801的单据，因为801无帐务分录
#160811-00009#4   2016/08/19  By 01531   账务中心/法人/账套权限控管
#160905-00002#7   2016/09/05  By 08171   SQL補上ent
#161111-00049#7   2016/11/24  By 01727   控制组权限修改

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
        xrdasite            LIKE xrda_t.xrdasite,
        xrdasite_desc       LIKE type_t.chr80,
        xrdald              LIKE xrda_t.xrdald,
        xrdald_desc         LIKE type_t.chr80,
        glaacomp            LIKE glaa_t.glaacomp,
        glaacomp_desc       LIKE type_t.chr80,
        type                LIKE type_t.chr10, 
        glapdocno           LIKE glap_t.glapdocno,
        glapdocdt           LIKE glap_t.glapdocdt,
        start_no            LIKE glap_t.glapdocno,
        end_no              LIKE glap_t.glapdocno,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
           sel              LIKE type_t.chr1,
           b_xrdald         LIKE xrda_t.xrdald,
           b_xrdadocno      LIKE xrda_t.xrdadocno,
           b_xrdadocdt      LIKE xrda_t.xrdadocdt,
           b_xrda004        LIKE xrda_t.xrda004,
           b_xrda005        LIKE xrca_t.xrca005
           END RECORD
           
DEFINE g_input        type_parameter
DEFINE g_input_t      type_parameter   #150129-01727#1-備份INPUT條件
DEFINE g_rec_b        LIKE type_t.num5 
DEFINE g_ooef004      LIKE ooef_t.ooef004
DEFINE g_xrdadocno    LIKE xrda_t.xrdadocno
DEFINE g_glaa121      LIKE glaa_t.glaa121
DEFINE g_glaa003      LIKE glaa_t.glaa003
DEFINE g_glaa013      LIKE glaa_t.glaa013
DEFINE g_xrdasite_t   LIKE xrda_t.xrdasite
DEFINE g_xrdald_t     LIKE xrda_t.xrdald
TYPE type_xrda RECORD
  xrdadocno   LIKE xrda_t.xrdadocno,
  xrdadocdt   LIKE xrda_t.xrdadocdt
END RECORD
DEFINE g_xrda_d DYNAMIC ARRAY OF type_xrda 
DEFINE g_date_close     LIKE ooab_t.ooab002
DEFINE g_sql_ctrl       STRING   #161111-00049#7 Add
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="axrp420.main" >}
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
   CALL cl_ap_init("axr","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js name="main.background"
   #151125-00006#1--s
   LET g_bgjob = g_argv[6]
   IF cl_null(g_bgjob) THEN LET g_bgjob = 'N' END IF
   #151125-00006#1--e
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #151125-00006#1--s
      DISPLAY 'OK!'
      CALL axrp420_init()
      LET g_input.type = 1
      LET g_input.xrdald  = g_argv[1]
      LET g_xrdadocno     = g_argv[2]
      LET g_input.xrdasite= g_argv[3]
      LET g_input.glapdocno=g_argv[4]
      LET g_input.glapdocdt=g_argv[5]
      LET g_wc = "xrdadocno = '",g_xrdadocno,"'"
      CALL axrp420_ref_show()
      CALL axrp420_b_fill()
      LET g_bgjob = 'N'
      CALL axrp420_p()
      #151125-00006#1--s
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp420 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp420_init()   
 
      #進入選單 Menu (="N")
      CALL axrp420_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp420
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE s_vr_tmp04;  #160727-00019#35  2016/08/11 By 08734   临时表长度超过15码的减少到15码以下 s_voucher_ar_tmp ——> s_vr_tmp04
   DROP TABLE s_vr_tmp05;  #160727-00019#36   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_voucher_ar_group ——> s_vr_tmp05
   DROP TABLE s_voucher_glbc;
   DROP TABLE s_pre_vr_tmp01;  #160727-00019#34   16/08/15 By 08734      临时表长度超过15码的减少到15码以下 s_pre_voucher_tmp ——> s_pre_vr_tmp01
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp420.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp420_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_success        LIKE type_t.num5
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('xrda001','8307','41')
   CALL s_voucher_cre_ar_tmp_table() RETURNING l_success
   CALL s_pre_voucher_cre_tmp_table() RETURNING l_success
   CALL s_fin_create_account_center_tmp()  
   CALL s_fin_continue_no_tmp()               #150129-01727#1
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp420.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp420_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_origin_str     STRING   #組織範圍
   DEFINE l_n              LIKE type_t.num5
   DEFINE l_glaa024        LIKE glaa_t.glaa024
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   CALL axrp420_default()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp420_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.xrdasite,g_input.xrdasite_desc,
                       g_input.xrdald,g_input.xrdald_desc,
                       g_input.glaacomp,g_input.glaacomp_desc,
                       g_input.type,g_input.glapdocno,
                       g_input.glapdocdt,g_input.start_no,
                       g_input.end_no
               ATTRIBUTE(WITHOUT DEFAULTS)
               
            BEFORE INPUT
               CALL cl_set_comp_required('glapdocdt',FALSE)
               IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
                  SELECT COUNT(*) INTO l_n FROM xrda_t 
                   WHERE xrdaent  = g_enterprise
                     AND xrdasite = g_input.xrdasite
                     AND xrdald   = g_input.xrdald
                     AND xrda014 IS NULL 
                     AND xrdastus = 'Y' 
                     AND xrdadocno = g_xrdadocno
                   ORDER BY xrdald,xrdadocdt 
                  
                  IF l_n > 0 THEN 
                     CALL axrp420_query()
                  END IF
               END IF
               
               CALL axrp420_ref_show()
               
            AFTER FIELD xrdasite
               IF NOT cl_null(g_input.xrdasite) THEN
                  CALL s_fin_account_center_sons_query('3',g_input.xrdasite,g_today,'1')
                  IF g_input.xrdasite != g_xrdasite_t THEN
                    CALL s_fin_orga_get_comp_ld(g_input.xrdasite) RETURNING l_success,g_errno,g_input.glaacomp,g_input.xrdald
                  END IF
#160811-00009#4 mod s--- 
#161021-00050#3 remark(s)
                  CALL s_fin_account_center_with_ld_chk(g_input.xrdasite,g_input.xrdald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.xrdasite
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     LET g_input.xrdasite = g_xrdasite_t
                     LET g_input.xrdald = g_xrdald_t
                     CALL axrp420_ref_show()
                     NEXT FIELD CURRENT
                  END IF
#161021-00050#3 remark(e)                  
                  CALL s_axrt300_site_geared_ld(g_input.xrdasite,g_input.xrdald,g_user,g_today,'site')
                     RETURNING l_success,g_input.xrdasite,g_input.xrdasite_desc,g_input.xrdald,g_input.xrdald_desc
                  DISPLAY BY NAME g_input.xrdasite,g_input.xrdasite_desc
                  DISPLAY BY NAME g_input.xrdald,g_input.xrdald_desc
                  IF NOT l_success THEN
                     LET g_input.xrdald = ''
                     CALL axrp420_ref_show()
                     NEXT FIELD CURRENT
                  END IF
#160811-00009#4 mod e---                    
                  SELECT ooef017 INTO g_input.glaacomp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_input.xrdasite
                  #161111-00049#7 Add  ---(S)---
                  CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_input.glaacomp)
                     RETURNING g_sub_success,g_sql_ctrl
                  #161111-00049#7 Add  ---(E)---
               END IF
               CALL axrp420_ref_show()
               CALL s_fin_account_center_sons_query('3',g_input.xrdasite,g_today,'1')
               LET g_xrdasite_t = g_input.xrdasite 
               LET g_xrdald_t = g_input.xrdald
               
            AFTER FIELD xrdald
               IF NOT cl_null(g_input.xrdald) THEN
#160811-00009#4 mod s---               
#                  CALL s_fin_account_center_with_ld_chk(g_input.xrdasite,g_input.xrdald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
#                  IF NOT cl_null(g_errno) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = g_input.xrdald
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#               
#                     LET g_input.xrdald = ''
#                     CALL axrp420_ref_show()
#                     NEXT FIELD CURRENT
#                  END IF
                  CALL s_axrt300_site_geared_ld(g_input.xrdasite,g_input.xrdald,g_user,g_today,'ld')
                     RETURNING l_success,g_input.xrdasite,g_input.xrdasite_desc,g_input.xrdald,g_input.xrdald_desc
                  DISPLAY BY NAME g_input.xrdasite,g_input.xrdasite_desc
                  DISPLAY BY NAME g_input.xrdald,g_input.xrdald_desc
                  IF NOT l_success THEN
                     LET g_input.xrdald = ''
                     CALL axrp420_ref_show()
                     NEXT FIELD CURRENT
                  END IF
#160811-00009#4 mod e---
                  #150129-01727#1--(S)
                  CALL axrp420_set_ld_info(g_input.xrdald)
                  IF g_input.xrdald <> g_input_t.xrdald THEN
                     DELETE FROM s_fin_tmp_conti_no
                  END IF
                  LET g_input_t.xrdald = g_input.xrdald
                  #150129-01727#1--(E)
               END IF
               CALL axrp420_ref_show() 
               #161111-00049#7 Add  ---(S)---
               CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_input.glaacomp)
                  RETURNING g_sub_success,g_sql_ctrl
               #161111-00049#7 Add  ---(E)---
               LET g_xrdald_t = g_input.xrdald
               
            AFTER FIELD glapdocno
               IF NOT cl_null(g_input.glapdocno) THEN 
                  CALL s_aooi200_fin_chk_slip(g_input.xrdald,'',g_input.glapdocno,'aglt310') RETURNING l_success
                  IF l_success = FALSE THEN 
                     LET g_input.glapdocno = ''
                     #150129-01727#1--(S)
                     IF g_input_t.glapdocno <> g_input.glapdocno THEN
                        DELETE FROM s_fin_tmp_conti_no
                     END IF
                     LET g_input_t.glapdocno = g_input.glapdocno
                     #150129-01727#1--(E)
                     NEXT FIELD glapdocno
                  END IF
                  #150129-01727#1--(S)
                  IF g_input_t.glapdocno <> g_input.glapdocno THEN
                     DELETE FROM s_fin_tmp_conti_no
                  END IF
                  LET g_input_t.glapdocno = g_input.glapdocno
                  #150129-01727#1--(E)
               END IF
               
            ON CHANGE type
               IF g_input.type = '3' OR g_input.type = '5' THEN 
                  CALL cl_set_comp_required('glapdocdt',TRUE)
               ELSE
                  CALL cl_set_comp_required('glapdocdt',FALSE)
               END IF   
               
            #150129-01727#1--(S)
            AFTER FIELD glapdocdt
               IF g_input.glapdocdt <= g_glaa013 THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'anm-00324' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_input.glapdocdt = ''
                  NEXT FIELD glapdocdt
               END IF
            
               IF g_input_t.glapdocdt <> g_input.glapdocdt THEN
                  DELETE FROM s_fin_tmp_conti_no
               END IF
               LET g_input_t.glapdocdt = g_input.glapdocdt

            ON ACTION cont_no
               IF cl_null(g_input.xrdald)  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00332'
                  LET g_errparam.extend = s_fin_get_colname('','xrcald')
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
               CALL s_fin_continue_no_input(g_input.xrdald,'',g_input.glapdocno,g_input.glapdocdt,'3')
               CALL s_transaction_end('Y','Y')
               
            #150129-01727#1--(E)  

            ON ACTION controlp INFIELD xrdasite
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xrdasite     #給予default
               #CALL q_ooef001()                               #呼叫開窗   #161021-00050#3 mark
               LET g_qryparam.where = " ooefstus = 'Y' "                  #161021-00050#3 add
               CALL q_ooef001_46()                                        #161021-00050#3 add
               LET g_input.xrdasite = g_qryparam.return1     #將開窗取得的值回傳到變數
               DISPLAY g_input.xrdasite                       #顯示到畫面上
               CALL axrp420_ref_show()
               NEXT FIELD xrdasite                            #返回原欄位    

            ON ACTION controlp INFIELD xrdald
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_input.xrdald             #給予default值
                
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_input.xrdasite,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING l_origin_str
               #將取回的字串轉換為SQL條件
               CALL axrp420_change_to_sql(l_origin_str) RETURNING l_origin_str  
               
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
               
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               
               CALL q_authorised_ld()                                #呼叫開窗
               
               LET g_input.xrdald = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY g_input.xrdald TO xrdald              #顯示到畫面上
               CALL axrp420_ref_show() 
               NEXT FIELD xrdald                          #返回原欄位
               
            ON ACTION controlp INFIELD glapdocno
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glapdocno  #給予default值
               LET l_glaa024 = ''
               SELECT glaa024 INTO l_glaa024 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.xrdald
               LET g_qryparam.arg1 = l_glaa024
               LET g_qryparam.arg2 = 'aglt310'
               CALL q_ooba002_1()                            #呼叫開窗
               LET g_input.glapdocno = g_qryparam.return1   #將開窗取得的值回傳到變數
               DISPLAY g_input.glapdocno TO glapdocno       #顯示到畫面上
               NEXT FIELD glapdocno                          #返回原欄位
               
               
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON xrda001,xrdadocdt,xrdadocno,xrda004,xrda005,xrda003

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
            ON ACTION controlp INFIELD xrdadocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         LET g_qryparam.where = "xrda014 IS NULL AND xrdasite = '",g_input.xrdasite,"' AND xrdald = '",g_input.xrdald,"'",
   	                                "                AND xrda001 <> '82' "    #160509-00004#118 add lujh
   	                                #161111-00049#7 Add  ---(S)---
                                     ," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                      "              WHERE pmaaent = ",g_enterprise,
                                      "                AND ",g_sql_ctrl,
                                      "                AND pmaaent = xrdaent ",
                                      "                AND pmaa001 = xrda004 )"
   	                                #161111-00049#7 Add  ---(E)---
               CALL q_xrdadocno()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrdadocno  #顯示到畫面上  
               NEXT FIELD xrdadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD xrda004
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         #161111-00049#7 Add  ---(S)---
               LET g_qryparam.arg1="('2','3')"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               CALL q_pmaa001_1()
   	         #161111-00049#7 Add  ---(S)---
              #CALL q_pmaa001_13()                     #呼叫開窗   #161111-00049#7 Mark
               DISPLAY g_qryparam.return1 TO xrda004  #顯示到畫面上  
               NEXT FIELD xrda004                     #返回原欄位

            ON ACTION controlp INFIELD xrda005
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         #161111-00049#7 Add  ---(S)---
               LET g_qryparam.arg1="('2','3')"
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               CALL q_pmaa001_1()
   	         #161111-00049#7 Add  ---(S)---
              #CALL q_pmaa001_13()                     #呼叫開窗   #161111-00049#7 Mark
               DISPLAY g_qryparam.return1 TO xrda005  #顯示到畫面上  
               NEXT FIELD xrda005                     #返回原欄位
   
            ON ACTION controlp INFIELD xrda003
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xrda003  #顯示到畫面上  
               NEXT FIELD xrda003                     #返回原欄位  
               
               
         END CONSTRUCT
         
         INPUT ARRAY g_detail_d FROM s_detail1.* 
              ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                        INSERT ROW = FALSE,
                        DELETE ROW = FALSE,
                        APPEND ROW = FALSE)
            BEFORE INPUT
               IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
                 CALL FGL_SET_ARR_CURR(g_detail_d.getLength()+1) 
                 LET g_insert = 'N' 
               END IF 
             
            BEFORE ROW
               LET l_ac = ARR_CURR()
               LET g_master_idx = l_ac
               DISPLAY l_ac TO FORMONLY.h_index
               CALL axrp420_fetch()              
               
            ON CHANGE sel
               IF cl_null(g_input.glapdocdt) AND g_detail_d[l_ac].b_xrdadocdt < = g_date_close THEN  
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'axc-00226'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
            
               UPDATE axrp420_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE xrdadocno = g_detail_d[l_ac].b_xrdadocno 
         
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
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
            CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
            
            IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
               DISPLAY g_input.xrdald,g_input.xrdald_desc,g_input.glaacomp,g_input.glaacomp_desc,g_input.type,
                       g_input.glapdocno,g_input.glapdocdt
                    TO xrdald,xrdald_desc,glaacomp,glaacomp_desc,type,glapdocno,glapdocdt
               DISPLAY g_xrdadocno TO xrdadocno            
            END IF
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               UPDATE axrp420_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE xrdadocno = g_detail_d[li_idx].b_xrdadocno 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF cl_null(g_input.glapdocdt) AND g_detail_d[li_idx].b_xrdadocdt < = g_date_close THEN  
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "N"
               #add-point:ui_dialog段on action selnone name="ui_dialog.for.onaction_selnone"
               UPDATE axrp420_tmp 
                  SET sel = g_detail_d[li_idx].sel
                WHERE xrdadocno = g_detail_d[li_idx].b_xrdadocno 
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
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  IF cl_null(g_input.glapdocdt) AND g_detail_d[li_idx].b_xrdadocdt < = g_date_close THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axc-00226'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  LET g_detail_d[li_idx].sel = "Y"
                  UPDATE axrp420_tmp 
                    SET sel = g_detail_d[li_idx].sel
                  WHERE xrdadocno = g_detail_d[li_idx].b_xrdadocno 
               END IF
            END FOR
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
               END IF
            END FOR
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail_d[li_idx].sel = "N"
                  UPDATE axrp420_tmp 
                    SET sel = g_detail_d[li_idx].sel
                  WHERE xrdadocno = g_detail_d[li_idx].b_xrdadocno 
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp420_filter()
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
            CALL axrp420_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_input.* TO NULL
            INITIALIZE g_input_t.*  TO NULL     #150129-01727#1
            CALL axrp420_set_ld_info(g_input.xrdald)
            CALL axrp420_default()
            CALL g_detail_d.clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp420_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            IF cl_null(g_input.glapdocno) THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00254' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            IF g_input.type = '3' OR g_input.type = '5' THEN 
               IF cl_null(g_input.glapdocdt) THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'axr-00296' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  EXIT DIALOG
               END IF
            END IF
            
            SELECT COUNT(*) INTO l_n
              FROM axrp420_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL cl_err_collect_init()
            CALL axrp420_chk() RETURNING l_success
            
            IF l_success = FALSE THEN
               CALL cl_err_collect_show()  
               EXIT DIALOG
            END IF
            
            CALL axrp420_p()
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
 
{<section id="axrp420.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp420_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   CALL cl_err_collect_init()
   #end add-point
        
   LET g_error_show = 1
   CALL axrp420_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
   CALL cl_err_collect_show()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp420_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success        LIKE type_t.num5
   DEFINE l_slip           LIKE xrda_t.xrdadocno
   DEFINE l_glaa024        LIKE glaa_t.glaa024
   DEFINE l_ooac004        LIKE ooac_t.ooac004
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc = g_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(g_wc) THEN  #p_wc 查詢條件
      LET g_wc = " 1=1 "
   END IF
   
   CALL axrp420_create_tmp() RETURNING l_success
   DELETE FROM axrp420_tmp
   
   LET g_sql= " SELECT 'Y',xrdald,xrdadocno,xrdadocdt,xrda004,xrda005 FROM xrda_t ",
              "  WHERE xrdaent  = ? ",
              "    AND xrdasite = '",g_input.xrdasite,"' ",
              "    AND xrdald   = '",g_input.xrdald,"' ",
              "    AND xrda014 IS NULL ",
              "    AND xrda001 <> '82' ",    #160509-00004#118 add lujh
              "    AND xrdastus = 'Y' AND ",g_wc
              
   IF NOT cl_null(g_input.glapdocdt) THEN 
      CALL s_get_accdate(g_glaa003,g_input.glapdocdt,'','') 
      RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      
      LET g_sql = g_sql," AND xrdadocdt BETWEEN '",l_pdate_s,"' AND '",l_pdate_e,"'"
   END IF

   #161111-00049#7 Add  ---(S)---
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = xrdaent ",
                        "                AND pmaa001 = xrda004 )"
   END IF
   #161111-00049#7 Add  ---(E)---

   LET g_sql = g_sql,"  ORDER BY xrdald,xrdadocdt "         
              
   CALL cl_get_para(g_enterprise,g_input.glaacomp,'S-FIN-2007') RETURNING g_date_close
   #end add-point
 
   PREPARE axrp420_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp420_sel
   
   CALL g_detail_d.clear()
   #add-point:b_fill段其他頁簽清空 name="b_fill.clear"
   
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
      CALL s_aooi200_fin_get_slip(g_detail_d[l_ac].b_xrdadocno)
      RETURNING l_success,l_slip
      
      SELECT glaa024 INTO l_glaa024
        FROM glaa_t
       WHERE glaaent = g_enterprise
         AND glaald = g_input.xrdald
      
      #是否抛傳票    
      SELECT ooac004 INTO l_ooac004
        FROM ooac_t
       WHERE ooacent = g_enterprise
         AND ooac001 = l_glaa024
         AND ooac002 = l_slip
         AND ooac003 = 'D-FIN-0030'
         
      IF l_ooac004 = 'N' THEN 
         #INITIALIZE g_errparam TO NULL 
         #LET g_errparam.extend = g_detail_d[l_ac].b_xrdadocno,"/",l_slip
         #LET g_errparam.code   = 'axr-00225'
         #LET g_errparam.popup  = TRUE 
         #CALL cl_err()
      
         CONTINUE FOREACH
      END IF
      
      IF cl_null(g_input.glapdocdt) AND g_detail_d[l_ac].b_xrdadocdt < = g_date_close THEN  
         LET g_detail_d[l_ac].sel = "N"
      END IF
      
      INSERT INTO axrp420_tmp 
       VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL axrp420_detail_show()      
 
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
   CALL g_detail_d.deleteElement(g_detail_d.getLength())
   #end add-point
    
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrp420_sel
   
   LET l_ac = 1
   CALL axrp420_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp420.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp420_fetch()
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define name="fetch.define"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axrp420.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp420_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp420.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp420_filter()
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
   
   CALL axrp420_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp420.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp420_filter_parser(ps_field)
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
 
{<section id="axrp420.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp420_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp420.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 参考栏位带值
PRIVATE FUNCTION axrp420_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xrdasite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.xrdasite_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_input.xrdasite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xrdald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.xrdald_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_input.xrdald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xrdald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa121,glaa003 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_input.glaacomp = g_rtn_fields[1]
   LET g_glaa121 = g_rtn_fields[2]
   LET g_glaa003 = g_rtn_fields[3]
   DISPLAY BY NAME g_input.glaacomp
   
   SELECT glaa013 INTO g_glaa013
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_input.xrdald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_input.glaacomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooef004 FROM ooef_t WHERE ooefent='"||g_enterprise||"' AND ooef001=? ","") RETURNING g_rtn_fields
   LET g_ooef004 = g_rtn_fields[1]
END FUNCTION
#
PRIVATE FUNCTION axrp420_change_to_sql(p_wc)
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
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION
# 创建临时表
PRIVATE FUNCTION axrp420_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE axrp420_tmp;
   CREATE TEMP TABLE axrp420_tmp(
     sel            LIKE type_t.chr1,
     xrdald         LIKE xrda_t.xrdald,
     xrdadocno      LIKE xrda_t.xrdadocno,
     xrdadocdt      LIKE xrda_t.xrdadocdt,
     xrda004        LIKE xrda_t.xrda004,
     xrca005        LIKE xrca_t.xrca005
   );
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "create" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN r_success
   END IF
   
   LET r_success = TRUE
   RETURN r_success
END FUNCTION
# 产生凭证
PRIVATE FUNCTION axrp420_p()
   DEFINE r_success     LIKE type_t.num5
   DEFINE r_start_no    LIKE glap_t.glapdocno
   DEFINE r_end_no      LIKE glap_t.glapdocno
   DEFINE l_wc          STRING
   DEFINE l_sql         STRING      
   DEFINE l_ac          LIKE type_t.num5   
   DEFINE li_idx        LIKE type_t.num5
   DEFINE l_xrda014     LIKE xrda_t.xrda014
   
   #开启事务
   CALL s_transaction_begin()
   CALL cl_err_collect_init()
   
   #LET l_sql = "SELECT xrdadocno,xrdadocdt FROM axrp420_tmp WHERE sel = 'Y'"
   #PREPARE axrp420_pre FROM l_sql
   #DECLARE axrp420_cs CURSOR FOR axrp420_pre
   #
   #CALL g_xrda_d.clear()
   #LET l_ac = 1
   #
   #FOREACH axrp420_cs INTO g_xrda_d[l_ac].*
   #   LET l_ac = l_ac + 1
   #END FOREACH 
   #CALL g_xrda_d.deleteElement(l_ac)
   #LET l_ac = l_ac - 1

   IF g_glaa121 = 'Y' THEN 
      LET l_wc =" glgbdocno IN (SELECT xrdadocno FROM axrp420_tmp WHERE sel = 'Y')"
      CALL s_pre_voucher_ins_glap('AR','R20',g_input.xrdald,g_input.glapdocdt,g_input.glapdocno,g_input.type,l_wc) RETURNING r_success,r_start_no,r_end_no
   ELSE
      LET l_wc =" xrdadocno IN (SELECT xrdadocno FROM axrp420_tmp WHERE sel = 'Y')"   
      CALL s_voucher_gen_ar('2',g_input.xrdald,g_input.glapdocdt,g_input.glapdocno,g_input.type,l_wc,'N') RETURNING r_success,r_start_no,r_end_no
   END IF
   
   LET g_input.start_no = r_start_no
   LET g_input.end_no = r_end_no
   DISPLAY BY NAME g_input.start_no,g_input.end_no
   
   IF r_success THEN
      CALL s_transaction_end('Y','1')
   ELSE
      IF cl_null(r_start_no) THEN 
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axc-00530' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'axr-00120' 
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      CALL s_transaction_end('N','0')   
   END IF
   CALL cl_err_collect_show() 

END FUNCTION
#执行抛转检查
PRIVATE FUNCTION axrp420_chk()
   DEFINE l_sql         STRING
   DEFINE l_xrdald      LIKE xrda_t.xrdald
   DEFINE l_xrdadocno   LIKE xrda_t.xrdadocno
   DEFINE l_xrda014     LIKE xrda_t.xrda014
   DEFINE r_success     LIKE type_t.num5
   
   LET r_success = TRUE
   LET l_sql = "SELECT xrdald,xrdadocno FROM axrp420_tmp ",
               " WHERE sel = 'Y' "
               
   PREPARE axrp420_chk_p FROM l_sql
   DECLARE axrp420_chk_c CURSOR FOR axrp420_chk_p
   
   FOREACH axrp420_chk_c INTO l_xrdald,l_xrdadocno
      SELECT xrda014 INTO l_xrda014
        FROM xrda_t
       WHERE xrdaent = g_enterprise
         AND xrdald = l_xrdald
         AND xrdadocno = l_xrdadocno
         
      IF NOT cl_null(l_xrda014) THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = l_xrdadocno
         LET g_errparam.code   = 'axr-00267'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         LET r_success = FALSE
      END IF 
   END FOREACH 
   
   RETURN r_success
END FUNCTION
# 赋默认值
PRIVATE FUNCTION axrp420_default()
   IF NOT cl_null(g_argv[1]) AND NOT cl_null(g_argv[2]) THEN
      LET g_input.type = 1
      LET g_input.xrdald  = g_argv[1]
      LET g_xrdadocno     = g_argv[2]
      LET g_input.xrdasite= g_argv[3]
      LET g_input.glapdocno=g_argv[4]
      LET g_input.glapdocdt=g_argv[5]
      LET g_wc = "xrdadocno = '",g_xrdadocno,"'"
   ELSE
      #取得預設的帳務中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.xrdasite,g_errno
      
      SELECT ooef017 INTO g_input.glaacomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_input.xrdasite
         
      SELECT glaald INTO g_input.xrdald
           FROM glaa_t
          #WHERE glaacomp = g_input.glaacomp #160905-00002#7 mark
          WHERE glaaent  = g_enterprise      #160905-00002#7 
            AND glaacomp = g_input.glaacomp  #160905-00002#7 
            AND glaa014 = 'Y'
            
      LET g_input.type = '1' 
      LET g_input.glapdocdt = g_today
   END IF
   CALL axrp420_ref_show()
   LET g_xrdasite_t = g_input.xrdasite
   LET g_xrdald_t = g_input.xrdald
   CALL axrp420_set_ld_info(g_input.xrdald)
   #161111-00049#7 Add  ---(S)---
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_input.glaacomp)
      RETURNING g_sub_success,g_sql_ctrl
   #161111-00049#7 Add  ---(E)---

END FUNCTION
#150126-00027#1   Belle    增加傳票補號
PRIVATE FUNCTION axrp420_set_ld_info(p_ld)
DEFINE p_ld          LIKE glaa_t.glaald
DEFINE l_glaa100     LIKE glaa_t.glaa100

   SELECT glaa100 INTO l_glaa100 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = p_ld

    IF l_glaa100 = 'Y' THEN
      CALL cl_set_comp_visible('cont_no',FALSE)
    ELSE
      CALL cl_set_comp_visible('cont_no',TRUE)
    END IF

END FUNCTION

#end add-point
 
{</section>}
 
