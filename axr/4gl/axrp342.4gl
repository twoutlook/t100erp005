#該程式未解開Section, 採用最新樣板產出!
{<section id="axrp342.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0018(2014-11-03 16:13:09), PR版次:0018(2017-02-08 15:22:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000338
#+ Filename...: axrp342
#+ Description: 應收傳票批次還原作業
#+ Creator....: 02114(2014-07-11 09:45:55)
#+ Modifier...: 02114 -SD/PR- 05016
 
{</section>}
 
{<section id="axrp342.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#150703-00021#39  2015/15/01 By Hans     aapp340增加預算控管/傳票抽回時 刪除相關的預算滾動檔
#160108-00004#1   2016/01/08 By 02097    增加背景排程功能
#161014-00053#6   2016/10/20 By 06814    修正帳套檢查,aapp342增加控制組邏輯
#161021-00050#3   2016/10/24 By 08729    處理組織開窗
#161115-00042#2   2016/11/18 By 08732    開窗範圍處理(1帳款對象控制組)+b_fill加控制組條件
#161125-00039#1   2016/12/02 By 01727    因为已审核或已过账不可勾选还原，所以请将已审核或已过账排除掉
#161121-00031#1   2016/12/13 By 02114    限定連續號參數者, 採作廢凭証處理。
#170103-00019#1   2017/01/04 By 02599    凭证删除或作废时，同步处理相关的细项立冲账资料
#161229-00047#68  2017/01/12 By Reanna   財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#161229-00047#77  2017/01/18 By Reanna   修正#161229-00047#68 BUG
#170124-00030#1   2017/02/02 By 06694    新增一下拉選項aapt450 供aapt450做傳票還原;b_fill() 請款修改#161115-00042#2錯誤條件
#170116-00074#4   2017/02/08 By Hans      aapp330拋轉不檢核
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
        site            LIKE type_t.chr20,
        site_desc       LIKE type_t.chr80,
        glaald          LIKE glaa_t.glaald,
        glaald_desc     LIKE type_t.chr80,
        glaacomp        LIKE glaa_t.glaacomp,
        glaacomp_desc   LIKE type_t.chr80,
        type            LIKE type_t.chr10,
   #end add-point
        wc               STRING
                     END RECORD
 
TYPE type_g_detail_d RECORD
#add-point:自定義模組變數(Module Variable)  #注意要在add-point內寫入END RECORD name="global.variable"
     sel           LIKE type_t.chr1,
     glapld        LIKE glap_t.glapld,
     glapdocno     LIKE glap_t.glapdocno,
     glapdocdt     LIKE glap_t.glapdocdt,
     glap010       LIKE glap_t.glap010,
     glap011       LIKE glap_t.glap011,
     glapstus      LIKE glap_t.glapstus,
     glap012       LIKE glap_t.glap012
     END RECORD
     
TYPE type_g_detail2_d RECORD
#add-point:自定義模組變數(Module Variable)
     b_type        LIKE type_t.chr100,
     xrcald        LIKE xrca_t.xrcald,
     xrcadocno     LIKE xrca_t.xrcadocno,
     xrcadocdt     LIKE xrca_t.xrcadocdt,
     xrca100       LIKE xrca_t.xrca100,
     xrca103       LIKE xrca_t.xrca103,
     xrca104       LIKE xrca_t.xrca104,
     xrca108       LIKE xrca_t.xrca108,
     xrca113       LIKE xrca_t.xrca113,
     xrca114       LIKE xrca_t.xrca114,
     xrca118       LIKE xrca_t.xrca118
     END RECORD     

DEFINE g_detail2_d   DYNAMIC ARRAY OF type_g_detail2_d
DEFINE g_input       type_parameter
DEFINE g_rec_b       LIKE type_t.num5 
DEFINE l_cnt         LIKE type_t.num5
DEFINE g_detail_idx  LIKE type_t.num5
DEFINE la_param      RECORD
          prog          STRING,
          param         DYNAMIC ARRAY OF STRING
                     END RECORD
DEFINE ls_js         STRING
DEFINE g_glaa121     LIKE glaa_t.glaa121
DEFINE g_site_t      LIKE type_t.chr10
DEFINE g_glaald_t    LIKE glaa_t.glaald
TYPE type_glap       RECORD
        glapdocno       LIKE glap_t.glapdocno,
        glapdocdt       LIKE glap_t.glapdocdt
                     END RECORD
DEFINE g_glap_d      DYNAMIC ARRAY OF type_glap
DEFINE l_sql         STRING                  #160108-00004#1
DEFINE l_glapdocno   LIKE glap_t.glapdocno   #160108-00004#1
DEFINE l_glapdocdt   LIKE glap_t.glapdocdt   #160108-00004#1
DEFINE g_sql_ctrl    STRING                  #161014-00053#6 20161021 add by beckxie
DEFINE g_comp_str    STRING                  #161229-00047#68
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"
 
#end add-point
 
{</section>}
 
{<section id="axrp342.main" >}
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
   
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #160108-00004#1--(S)
      #呼叫該隻背景的程式寫法應該如下:
      #LET la_param.prog = "aapp342"
      #LET la_param.background = "Y"
      #LET la_param1.glaald = g_apca_m.apcald
      #LET la_param1.type   = "aapt300"
      #LET la_param1.wc     = " glapdocno = '",g_apca_m.apca038,"'"
      #LET la_param.param[1] = util.JSON.stringify( la_param1 )
      #LET ls_js = util.JSON.stringify( la_param )
      #CALL cl_cmdrun(ls_js)
      LET ls_js = g_argv[02]  #接收傳入的ls_js
      CALL util.JSON.parse(ls_js,g_input)
      #170124-00030#1----(s)----
      SELECT glaacomp INTO g_input.glaacomp
        FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = g_input.glaald
      #170124-00030#1----(e)----
      DISPLAY 'g_input.glaacomp : ', g_input.glaacomp
      DISPLAY 'g_bgjob : ', g_bgjob
      CALL axrp342_create_tmp() RETURNING g_sub_success
      LET l_sql = " SELECT glapdocno,glapdocdt FROM glap_t ",
                  "  WHERE glapent = ",g_enterprise , " AND " ,g_input.wc,
                  "    AND glapld  ='",g_input.glaald,"'"
      DECLARE sel_glap_c CURSOR FROM l_sql
      FOREACH sel_glap_c INTO l_glapdocno,l_glapdocdt     
         INSERT INTO axrp342_tmp (sel,glapld,glapdocno,glapdocdt)
                          VALUES ('Y',g_input.glaald,l_glapdocno,l_glapdocdt)
      END FOREACH
      SELECT glaa121 INTO g_glaa121
        FROM glaa_t
       WHERE glaaent = g_enterprise AND glaald = g_input.glaald
      CALL axrp342_p()
      #160108-00004#1--(E)
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrp342 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrp342_init()   
 
      #進入選單 Menu (="N")
      CALL axrp342_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_axrp342
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   DROP TABLE axrp342_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="axrp342.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrp342_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   DEFINE l_sql      STRING
   DEFINE l_str      STRING
   DEFINE l_gzcb002  LIKE gzcb_t.gzcb002 
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('glapstus','13','N,Y,S')
   
   IF g_argv[1] = 'ar' THEN
      LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8036' AND gzcb003 = 'AR'"
   ELSE
      #161014-00053#6 20161021 add by beckxie---S
      LET g_sql_ctrl = NULL
      #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl   #161115-00042#2 mark
      #161115-00042#2   add---s
      #SELECT ooef017 INTO g_input.glaacomp 
      #  FROM ooef_t
      # WHERE ooefent = g_enterprise
      #   AND ooef001 = g_site
      #   AND ooefstus = 'Y'
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.glaacomp) RETURNING g_sub_success,g_sql_ctrl 
      #161115-00042#2 add---e
      #161014-00053#6 20161021 add by beckxie---E
      LET l_sql = "SELECT gzcb002 FROM gzcb_t WHERE gzcb001 = '8036' AND gzcb003 = 'AP'"
   END IF

   PREPARE axrp342_prep FROM l_sql
   DECLARE axrp342_curs CURSOR FOR axrp342_prep
   LET l_str = Null
   LET l_gzcb002 = Null
   FOREACH axrp342_curs INTO l_gzcb002
      IF cl_null(l_str) THEN 
         LET l_str = l_gzcb002 
         CONTINUE FOREACH 
      END IF
      LET l_str = l_str,",",l_gzcb002
   END FOREACH
   CALL cl_set_combo_scc_part('type','8036',l_str)
   CALL s_fin_create_account_center_tmp() 
   
   #161229-00047#68 add ------
   SELECT ooef017 INTO g_input.glaacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #161229-00047#77 mark ------
   #CALL s_fin_get_wc_str(g_input.glaacomp) RETURNING g_comp_str
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#77 mark end---
   CALL s_control_get_customer_sql_pmab('2',g_site,g_user,g_dept,'',g_input.glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#77 add
   #161229-00047#68 add end---
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp342.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrp342_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_success         LIKE type_t.num5
   DEFINE l_slip            LIKE xrca_t.xrcadocno
   DEFINE l_oobx004         LIKE oobx_t.oobx004  
   DEFINE l_n               LIKE type_t.num5
   DEFINE l_origin_str      STRING   #組織範圍
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   LET g_input.site = g_site
   CALL s_fin_orga_get_comp_ld(g_input.site) RETURNING l_success,g_errno,g_input.glaacomp,g_input.glaald
   CALL axrp342_glaald_desc()
   LET g_site_t = g_input.site
   LET g_glaald_t = g_input.glaald
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axrp342_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME g_input.site,g_input.site_desc,g_input.glaald,g_input.glaald_desc,g_input.glaacomp,
                       g_input.glaacomp_desc,g_input.type
               ATTRIBUTE(WITHOUT DEFAULTS)
           
            BEFORE INPUT
               

            AFTER FIELD site
               IF NOT cl_null(g_input.site) THEN 
                  CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'1')
                  IF g_input.site != g_site_t THEN 
                     CALL s_fin_orga_get_comp_ld(g_input.site) RETURNING l_success,g_errno,g_input.glaacomp,g_input.glaald
                  END IF
                  CALL s_fin_account_center_with_ld_chk(g_input.site,g_input.glaald,g_user,'3','N','',g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.site
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     LET g_input.site = g_site_t
                     LET g_input.glaald = g_glaald_t
                     CALL axrp342_glaald_desc()
                     NEXT FIELD CURRENT
                  END IF
                  #161229-00047#68 mark ------
                  ##161115-00042#2   add---s
                  #SELECT ooef017 INTO g_input.glaacomp
                  #  FROM ooef_t
                  # WHERE ooefent = g_enterprise
                  #   AND ooef001 = g_input.site
                  #   AND ooefstus = 'Y'
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_input.glaacomp) RETURNING g_sub_success,g_sql_ctrl
                  ##161115-00042#2 add---e
                  #161229-00047#68 mark end---
                  #161229-00047#77 mark ------
                  ##161229-00047#68 add ------
                  #CALL s_fin_get_wc_str(g_input.glaacomp) RETURNING g_comp_str
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
                  ##161229-00047#68 add end---
                  #161229-00047#77 mark end---
                  #161229-00047#77 add ------
                  SELECT ooef017 INTO g_input.glaacomp
                    FROM ooef_t
                   WHERE ooefent = g_enterprise
                     AND ooef001 = g_input.site
                     AND ooefstus = 'Y'
                  CALL s_control_get_customer_sql_pmab('2',g_site,g_user,g_dept,'',g_input.glaacomp) RETURNING g_sub_success,g_sql_ctrl
                  #161229-00047#77 add end---
               END IF
               CALL axrp342_glaald_desc()
               LET g_site_t = g_input.site
               LET g_glaald_t = g_input.glaald 
               
            AFTER FIELD glaald
               IF NOT cl_null(g_input.glaald) THEN
                  IF g_input.glaald != g_glaald_t THEN
                    CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'1')
                  END IF
                  #CALL s_fin_account_center_with_ld_chk(g_input.site,g_input.glaald,g_user,'3','N','',g_today) RETURNING l_success,g_errno   #161014-00053#6 20161020 mark by beckxie
                  CALL s_fin_account_center_with_ld_chk(g_input.site,g_input.glaald,g_user,'3','Y','',g_today) RETURNING l_success,g_errno   #161014-00053#6 20161020 add by beckxie
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.glaald
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
               
                     LET g_input.glaald = ''
                     CALL axrp342_glaald_desc()
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL axrp342_glaald_desc()
               LET g_glaald_t = g_input.glaald 
               
            ON ACTION controlp INFIELD site
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.site        #給予default值
               #CALL q_ooef001()                              #呼叫開窗    #161021-00050#3 mark
               LET g_qryparam.where = " ooefstus = 'Y' "                  #161021-00050#3 add
               CALL q_ooef001_46()                                        #161021-00050#3 add
               LET g_input.site = g_qryparam.return1         #將開窗取得的值回傳到變數
               CALL axrp342_glaald_desc()
               NEXT FIELD site                                            #返回原欄位
                        
               
            ON ACTION controlp INFIELD glaald
      			INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      			LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.glaald                    #給予default值
                 
               #取得帳務組織下所屬成員
               CALL s_fin_account_center_sons_query('3',g_input.site,g_today,'1')
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING l_origin_str
               #將取回的字串轉換為SQL條件
               CALL axrp342_change_to_sql(l_origin_str) RETURNING l_origin_str  
               
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN (",l_origin_str," )"
               
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               CALL q_authorised_ld()                                       #呼叫開窗
               LET g_input.glaald = g_qryparam.return1                     #將開窗取得的值回傳到變數
               CALL axrp342_glaald_desc()
               NEXT FIELD glaald                                            #返回原欄位
               
         END INPUT
         
         #查詢QBE
         CONSTRUCT BY NAME g_wc ON xrcadocno,xrcadocdt,xrca004,xrca038,glapcrtid

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            
            AFTER CONSTRUCT
               #呼叫P次作業
               
            ON ACTION controlp INFIELD xrcadocno
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         IF g_input.type = 'axrt300' THEN 
   	            LET g_qryparam.where = " xrcald = '",g_input.glaald,"'",
			                                "   AND xrcastus = 'Y'",
			                                "   AND xrca038 IS NOT NULL"
			                               ,"   AND xrca038 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_xrcadocno()     
   	         END IF
   	         
   	         IF g_input.type = 'axrt400' THEN    #收款核銷
   	            LET g_qryparam.where = " xrdald = '",g_input.glaald,"'",
			                                "   AND xrdastus = 'Y'",
			                                "   AND xrda014 IS NOT NULL"
			                               ,"   AND xrda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_xrdadocno()  
   	         END IF
   	         
   	         IF g_input.type = 'aapt300' THEN    #應付立帳
   	            LET g_qryparam.where = " apcald = '",g_input.glaald,"'",
			                                "   AND apcastus = 'Y'",
			                                "   AND apca038 IS NOT NULL"
			                               ,"   AND apca038 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apcadocno()  
   	         END IF
   	         
   	         IF g_input.type = 'aapt400' THEN    #請款
   	            LET g_qryparam.where = " apdald = '",g_input.glaald,"'",
			                                "   AND apdastus = 'Y'",
			                                "   AND apda014 IS NOT NULL",
			                                "   AND apda001 = '45'"
			                               ,"   AND apda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apdadocno()  
   	         END IF
   	         
   	         #170124-00030#1-----(s)------
   	         IF g_input.type = 'aapt450' THEN    #薪資費用
   	            LET g_qryparam.where = " apdald = '",g_input.glaald,"'",
			                                "   AND apdastus = 'Y'",
			                                "   AND apda014 IS NOT NULL",
			                                "   AND apda001 = '46'"
			                               ,"   AND apda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apdadocno()  
   	         END IF
   	         #170124-00030#1-----(e)------
   	         
   	         IF g_input.type = 'aapt430' THEN    #费用分摊
   	            LET g_qryparam.where = " apdald = '",g_input.glaald,"'",
			                                "   AND apdastus = 'Y'",
			                                "   AND apda014 IS NOT NULL",
			                                "   AND apda001 = '43'"
			                               ,"   AND apda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apdadocno()  
   	         END IF
   	         
               DISPLAY g_qryparam.return1 TO xrcadocno  #顯示到畫面上  
               NEXT FIELD xrcadocno                     #返回原欄位  
               
            ON ACTION controlp INFIELD xrca004
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
   	         IF g_input.type = 'axrt300' THEN 
                  #161115-00042#2   add---s
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = g_sql_ctrl
                  END IF
                  #161115-00042#2   add---e
                  CALL q_pmaa001_7()     
   	         END IF
   	         
   	         IF g_input.type = 'axrt400' THEN    #收款核銷
   	            #161115-00042#2   add---s
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN  
                     LET g_qryparam.where = g_sql_ctrl
                  END IF 
                  #161115-00042#2   add---e
   	            CALL q_pmaa001_7() 
   	         END IF
   	         
   	         IF g_input.type = 'aapt300' THEN    #應付立帳
   	            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') AND (pmaa004 = '1' OR pmaa004 = '3')"
   	            #161014-00053#6 20161021 add by beckxie---S
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
                  END IF
                  #161014-00053#6 20161021 add by beckxie---E
                  CALL q_pmaa001()              #呼叫開窗
                 
   	         END IF
   	         
   	         IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' THEN    #請款
   	            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') AND (pmaa004 = '1' OR pmaa004 = '3')"
   	            #161014-00053#6 20161021 add by beckxie---S
                  IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                     LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
                  END IF
                  #161014-00053#6 20161021 add by beckxie---E
                  CALL q_pmaa001()             #呼叫開窗
                 
   	         END IF                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO xrca004  #顯示到畫面上  
               NEXT FIELD xrca004                     #返回原欄位 
   
            ON ACTION controlp INFIELD xrca038
   	         INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
   	         LET g_qryparam.reqry = FALSE
               IF g_input.type = 'axrt300' THEN 
                  LET g_qryparam.where = " xrca038 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_xrca038()     
   	         END IF
   	         
   	         IF g_input.type = 'axrt400' THEN    #收款核銷
   	            LET g_qryparam.where = " xrda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_xrda014()  
   	         END IF
   	         
   	         IF g_input.type = 'aapt300' THEN    #應付立帳
   	            LET g_qryparam.where = " apca038 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apca038()  
   	         END IF
   	         
   	         #IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' THEN     #請款                                           #170124-00030#1 mark
   	         IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' OR g_input.type = 'aapt450' THEN      #請款；薪資費用      #170124-00030#1 add
   	            LET g_qryparam.where = " apda014 IN (SELECT glapdocno FROM glap_t WHERE glapent = ",g_enterprise," AND glapstus = 'N')"   #161125-00039#1 Add
                  CALL q_apda014()  
   	         END IF
               DISPLAY g_qryparam.return1 TO xrca038  #顯示到畫面上  
               NEXT FIELD xrca038                     #返回原欄位  
               
            ON ACTION controlp INFIELD glapcrtid
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO glapcrtid  #顯示到畫面上

               NEXT FIELD glapcrtid                     #返回原欄位
               
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
               CALL axrp342_fetch() 
               CALL axrp342_xrca_fill()               
               
            ON CHANGE sel
               IF g_detail_d[l_ac].glapstus = 'Y' OR g_detail_d[l_ac].glapstus = 'S' THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'axr-00153'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  
                  LET g_detail_d[l_ac].sel = 'N'
                  EXIT DIALOG
               END IF
               UPDATE axrp342_tmp 
                  SET sel = g_detail_d[l_ac].sel 
                WHERE glapdocno = g_detail_d[l_ac].glapdocno 
            
            ON ACTION modify_detail
               LET la_param.prog = 'aglt310'
               LET la_param.param[1] = g_input.glaald
               LET la_param.param[2] = g_detail_d[l_ac].glapdocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)           
         END INPUT
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_cnt = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_detail2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_cnt

            ON ACTION modify_detail
               CALL s_aooi200_fin_get_slip(g_detail2_d[l_cnt].xrcadocno)
               RETURNING l_success,l_slip
               SELECT oobx004 INTO l_oobx004 FROM oobx_t WHERE oobxent = g_enterprise AND oobx001 = l_slip
               IF l_oobx004 = 'MULTI' THEN 
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.arg1 = l_slip
                  CALL q_oobl002()                                
                  LET l_oobx004 = g_qryparam.return1           
               END IF
               
               LET la_param.prog = l_oobx004
               LET la_param.param[1] = g_detail2_d[l_cnt].xrcald
               LET la_param.param[2] = g_detail2_d[l_cnt].xrcadocno
               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun(ls_js)
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY
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
            #end add-point
 
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            #add-point:ui_dialog段on action selall name="ui_dialog.selall.befroe"
            
            #end add-point            
            FOR li_idx = 1 TO g_detail_d.getLength()
               LET g_detail_d[li_idx].sel = "Y"
               #add-point:ui_dialog段on action selall name="ui_dialog.for.onaction_selall"
               UPDATE axrp342_tmp 
                  SET sel = g_detail_d[li_idx].sel 
                WHERE glapdocno = g_detail_d[li_idx].glapdocno 
               #end add-point
            END FOR
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            FOR li_idx = 1 TO g_detail_d.getLength()
               IF g_detail_d[li_idx].glapstus = 'Y' OR g_detail_d[li_idx].glapstus = 'S' THEN 
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
               UPDATE axrp342_tmp 
                  SET sel = g_detail_d[li_idx].sel 
                WHERE glapdocno = g_detail_d[li_idx].glapdocno 
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
                  IF g_detail_d[li_idx].glapstus = 'Y' OR g_detail_d[li_idx].glapstus = 'S' THEN 
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'axr-00153'
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                     LET g_detail_d[li_idx].sel = 'N'
                     EXIT DIALOG
                  END IF
                  
                  LET g_detail_d[li_idx].sel = "Y"
                  UPDATE axrp342_tmp 
                    SET sel = g_detail_d[li_idx].sel 
                  WHERE glapdocno = g_detail_d[li_idx].glapdocno 
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
                  UPDATE axrp342_tmp 
                    SET sel = g_detail_d[li_idx].sel 
                  WHERE glapdocno = g_detail_d[li_idx].glapdocno
               END IF
            END FOR
            #end add-point
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axrp342_filter()
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
            CALL axrp342_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            CLEAR FORM
            INITIALIZE g_input.* TO NULL
            LET g_input.site = g_site
            CALL s_fin_orga_get_comp_ld(g_input.site) RETURNING l_success,g_errno,g_input.glaacomp,g_input.glaald
            #161229-00047#77 mark ------
            ##161229-00047#68 add ------
            #CALL s_fin_get_wc_str(g_input.glaacomp) RETURNING g_comp_str
            #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl
            ##161229-00047#68 add end---
            #161229-00047#77 mark end---
            CALL s_control_get_customer_sql_pmab('2',g_site,g_user,g_dept,'',g_input.glaacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#77 add
            CALL axrp342_glaald_desc()
            LET g_site_t = g_input.site
            LET g_glaald_t = g_input.glaald
            CALL g_detail_d.clear()
            CALL g_detail2_d.clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL axrp342_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute
            SELECT COUNT(*) INTO l_n
              FROM axrp342_tmp
             WHERE sel = 'Y'
            IF l_n = 0 THEN 
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = 'axr-00159' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               
               EXIT DIALOG
            END IF
            
            CALL axrp342_p()
            CALL axrp342_b_fill()
            CALL axrp342_xrca_fill()
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
 
{<section id="axrp342.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrp342_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define name="query.define"
   
   #end add-point 
    
   #add-point:cs段after_construct name="query.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL axrp342_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   #add-point:cs段after_query name="query.cs_after_query"
 
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axrp342.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrp342_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   IF cl_null(g_wc) THEN 
      LET g_wc = "1=1"
   END IF
   
   CALL axrp342_create_tmp() RETURNING l_success
   DELETE FROM axrp342_tmp
   IF g_input.type = 'axrt300' THEN    #應收立帳
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,xrca_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = xrcaent ",
                  "   AND glapld = xrcald ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND xrca038 = glapdocno ",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND xrcasite = '",g_input.site,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = xrcaent ",
                  "               AND pmaa001 = xrca004 ) ",
                  #161115-00042#2   add---e
                  "   AND ",g_wc
   END IF
   
   IF g_input.type = 'axrt400' THEN    #收款核銷
      LET g_wc = cl_replace_str(g_wc,"xrcadocno","xrdadocno")
      LET g_wc = cl_replace_str(g_wc,"xrcadocdt","xrdadocdt")
      LET g_wc = cl_replace_str(g_wc,"xrca004","xrda004")
      LET g_wc = cl_replace_str(g_wc,"xrca038","xrda014")
   
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,xrda_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = xrdaent ",
                  "   AND glapld = xrdald ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND xrda014 = glapdocno ",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND xrdasite = '",g_input.site,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                 "               AND pmaaent = xrdaent ",     
                 "               AND pmaa001 = xrda005 ) ",
                  #161115-00042#2   add---e
                  "   AND ",g_wc
   END IF
   
   IF g_input.type = 'aapt300' THEN    #應付立帳
      LET g_wc = cl_replace_str(g_wc,"xrcadocno","apcadocno")
      LET g_wc = cl_replace_str(g_wc,"xrcadocdt","apcadocdt")
      LET g_wc = cl_replace_str(g_wc,"xrca004","apca004")
      LET g_wc = cl_replace_str(g_wc,"xrca038","apca038")
   
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,apca_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = apcaent ",
                  "   AND glapld = apcald ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND apca038 = glapdocno ",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND apcasite = '",g_input.site,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = apcaent ",
                  "               AND pmaa001 = apca004 ) ",
                  #161115-00042#2   add---e
                  "   AND ",g_wc
   END IF
   
   IF g_input.type = 'aapt400' THEN    #請款
      LET g_wc = cl_replace_str(g_wc,"xrcadocno","apdadocno")
      LET g_wc = cl_replace_str(g_wc,"xrcadocdt","apdadocdt")
      LET g_wc = cl_replace_str(g_wc,"xrca004","apda004")
      LET g_wc = cl_replace_str(g_wc,"xrca038","apda014")
      
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,apda_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = apdaent ",
                  "   AND glapld = apdald ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND apda014 = glapdocno ",
                  "   AND apdasite = '",g_input.site,"'",
                  "   AND apda001 = '45'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
#                  "               AND pmaaent = xrdaent ",       #170124-00030#1  mark
#                  "               AND pmaa001 = xrda005 ) ",     #170124-00030#1  mark
                  "               AND pmaaent = apdaent ",        #170124-00030#1  add
                  "               AND pmaa001 = apda005 ) ",      #170124-00030#1  add            
                  #161115-00042#2   add---e
                  "   AND ",g_wc
   END IF
   
   #170124-00030#1----(s)----
   IF g_input.type = 'aapt450' THEN    #薪資費用
      LET g_wc = cl_replace_str(g_wc,"xrcadocno","apdadocno")
      LET g_wc = cl_replace_str(g_wc,"xrcadocdt","apdadocdt")
      LET g_wc = cl_replace_str(g_wc,"xrca004","apda004")
      LET g_wc = cl_replace_str(g_wc,"xrca038","apda014")
      
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,apda_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = apdaent ",
                  "   AND glapld = apdald ",
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND apda014 = glapdocno ",
                  "   AND apdasite = '",g_input.site,"'",
                  "   AND apda001 = '46'",
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = apdaent ",
                  "               AND pmaa001 = apda005 ) ",
                  "   AND ",g_wc
   END IF
   #170124-00030#1----(e)----
   
   IF g_input.type = 'aapt430' THEN    #费用分摊
      LET g_wc = cl_replace_str(g_wc,"xrcadocno","apdadocno")
      LET g_wc = cl_replace_str(g_wc,"xrcadocdt","apdadocdt")
      LET g_wc = cl_replace_str(g_wc,"xrca004","apda004")
      LET g_wc = cl_replace_str(g_wc,"xrca038","apda014")
      
      LET g_sql = "SELECT DISTINCT 'N',glapld,glapdocno,glapdocdt,glap010,glap011,glapstus,glap012 ",
                  "  FROM glap_t,apda_t ",
                  " WHERE glapent = ? ",
                  "   AND glapent = apdaent ",
                  "   AND glapld = apdald ",
                  "   AND glapstus = 'N'   ",   #161125-00039#1 Add
                  "   AND glapld = '",g_input.glaald,"'",
                  "   AND apda014 = glapdocno ",
                  "   AND apdasite = '",g_input.site,"'",
                  "   AND apda001 = '43'",
                  "   AND ",g_wc
   END IF
   LET g_sql = g_sql CLIPPED , " ORDER BY glapdocno ASC"
   #end add-point
 
   PREPARE axrp342_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrp342_sel
   
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
      INSERT INTO axrp342_tmp VALUES(g_detail_d[l_ac].*)
      #end add-point
      
      CALL axrp342_detail_show()      
 
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
   FREE axrp342_sel
   
   LET l_ac = 1
   CALL axrp342_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL axrp342_xrca_fill()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp342.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrp342_fetch()
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
 
{<section id="axrp342.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrp342_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrp342.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrp342_filter()
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
   
   CALL axrp342_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="axrp342.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrp342_filter_parser(ps_field)
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
 
{<section id="axrp342.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrp342_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrp342_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrp342.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"
# 帳套帶值
PRIVATE FUNCTION axrp342_glaald_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.site
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '"||g_enterprise||"' AND ooefl001 = ? AND ooefl002 = '"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.site_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.site_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaald_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaacomp,glaa121 FROM glaa_t WHERE glaaent='"||g_enterprise||"' AND glaald=? ","") RETURNING g_rtn_fields
   LET g_input.glaacomp = '', g_rtn_fields[1] , ''
   LET g_glaa121 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_input.glaacomp
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.glaacomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.glaacomp_desc
END FUNCTION
# 單身二資料填充
PRIVATE FUNCTION axrp342_xrca_fill()
   CALL g_detail2_d.clear()
   
   IF g_input.type = 'axrt300' THEN    #應收立帳
      LET g_sql = "SELECT '',xrcald,xrcadocno,xrcadocdt,xrca100,xrca103,xrca104,xrca108,xrca113,xrca114,xrca118 ",
                  "  FROM xrca_t ",
                  " WHERE xrcaent = '",g_enterprise,"'",
                  "   AND xrcald = '",g_detail_d[l_ac].glapld,"'",
                  "   AND xrca038 = '",g_detail_d[l_ac].glapdocno,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = xrcaent ",
                  "               AND pmaa001 = xrca004 ) "
                  #161115-00042#2   add---e
   END IF
   
   IF g_input.type = 'axrt400' THEN    #收款核銷
      #LET g_sql = "SELECT '',xrdald,xrdadocno,xrdadocdt,xrce100,SUM(xrce109),SUM(xrce104),SUM(xrda103),SUM(xrce119),SUM(xrce114),SUM(xrda113) ",
      #            "  FROM xrda_t,xrce_t ",
      #            " WHERE xrdaent = xrceent ",
      #            "   AND xrdald = xrceld ",
      #            "   AND xrdadocno = xrcedocno ",
      #            "   AND xrdaent = '",g_enterprise,"'",
      #            "   AND xrdald = '",g_detail_d[l_ac].glapld,"'",
      #            "   AND xrda014 = '",g_detail_d[l_ac].glapdocno,"'",
      #            #"   AND xrce002 IN (SELECT gzcb002 FROM gzcb_t WHERE ",
      #            #"                    gzcb001 = '8306' AND gzcb004 = '2')",
      #            " GROUP BY xrdald,xrdadocno,xrdadocdt,xrce100"
      
      LET g_sql = "SELECT '',xrdald,xrdadocno,xrdadocdt,'',0,0,SUM(xrda103),0,0,SUM(xrda113) ",
                  "  FROM xrda_t ",
                  " WHERE xrdaent = '",g_enterprise,"'",
                  "   AND xrdald = '",g_detail_d[l_ac].glapld,"'",
                  "   AND xrda014 = '",g_detail_d[l_ac].glapdocno,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = xrdaent ",
                  "               AND pmaa001 = xrda005 ) ",
                  #161115-00042#2   add---e
                  " GROUP BY xrdald,xrdadocno,xrdadocdt"
   END IF
   
   IF g_input.type = 'aapt300' THEN    #應付立帳
      LET g_sql = "SELECT '',apcald,apcadocno,apcadocdt,apca100,apca103,apca104,apca108,apca113,apca114,apca118 ",
                  "  FROM apca_t ",
                  " WHERE apcaent = '",g_enterprise,"'",
                  "   AND apcald = '",g_detail_d[l_ac].glapld,"'",
                  "   AND apca038 = '",g_detail_d[l_ac].glapdocno,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  "               AND pmaaent = apcaent ",
                  "               AND pmaa001 = apca004 ) "
                  #161115-00042#2   add---e
   END IF
   
   #IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' THEN    #請款   #170124-00030#1 mark
   IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' OR g_input.type = 'aapt450' THEN    #請款；薪資費用   #170124-00030#1 add
      #LET g_sql = "SELECT '',apdald,apdadocno,apdadocdt,'',SUM(apce109),SUM(apce104),SUM(apce109+apce104),SUM(apce119),SUM(apce114),SUM(apda113) ",
      #            "  FROM apda_t,apce_t ",
      #            " WHERE apdaent = apceent ",
      #            "   AND apdald = apceld ",
      #            "   AND apdadocno = apcedocno ",
      #            "   AND apdaent = '",g_enterprise,"'",
      #            "   AND apdald = '",g_detail_d[l_ac].glapld,"'",
      #            "   AND apda014 = '",g_detail_d[l_ac].glapdocno,"'",
      #            #"   AND apce002 IN (SELECT gzcb002 FROM gzcb_t WHERE ",
      #            #"                    gzcb001 = '8506' AND gzcb004 = '1')",
      #            " GROUP BY apdald,apdadocno,apdadocdt"
                  
      LET g_sql = "SELECT '',apdald,apdadocno,apdadocdt,'',0,0,SUM(apda104),0,0,SUM(apda114) ",
                  "  FROM apda_t ",
                  " WHERE apdaent = '",g_enterprise,"'",
                  "   AND apdald = '",g_detail_d[l_ac].glapld,"'",
                  "   AND apda014 = '",g_detail_d[l_ac].glapdocno,"'",
                  #161115-00042#2   add---s
                  "   AND EXISTS (SELECT 1 FROM pmaa_t ",
                  "               WHERE pmaaent = ",g_enterprise,
                  "               AND ",g_sql_ctrl,
                  #"               AND pmaaent = xrdaent ",          #170124-00030#1 mark
                  #"               AND pmaa001 = xrda005 ) ",        #170124-00030#1 mark
                  "               AND pmaaent = apdaent ",           #170124-00030#1 add
                  "               AND pmaa001 = apda005 ) ",         #170124-00030#1 add
                  #161115-00042#2   add---e
                  " GROUP BY apdald,apdadocno,apdadocdt" 
   END IF
   
   
   PREPARE xrca_pre FROM g_sql
   DECLARE xrca_cur CURSOR FOR xrca_pre
   LET l_cnt = 1
   FOREACH xrca_cur INTO g_detail2_d[l_cnt].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         
         EXIT FOREACH
      END IF
      
      IF cl_null(g_detail2_d[l_cnt].xrca108) THEN 
         LET g_detail2_d[l_cnt].xrca108 = 0
      END IF
      
      IF cl_null(g_detail2_d[l_cnt].xrca118) THEN 
         LET g_detail2_d[l_cnt].xrca118 = 0
      END IF
      
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "std-00002"
         LET g_errparam.extend = "Max_Row:"||g_max_rec USING "<<<<<"
         LET g_errparam.popup = FALSE
         CALL cl_err()
         
         EXIT FOREACH
      END IF
   END FOREACH 
   
   CALL g_detail2_d.deleteElement(l_cnt)
    
   FREE xrca_pre
END FUNCTION
# 創建臨時表
PRIVATE FUNCTION axrp342_create_tmp()
   DEFINE r_success       LIKE type_t.num5
   
   WHENEVER ERROR CONTINUE
   LET r_success = FALSE
   
   DROP TABLE axrp342_tmp;
   CREATE TEMP TABLE axrp342_tmp(
     sel           LIKE type_t.chr1,
     glapld        LIKE glap_t.glapld,
     glapdocno     LIKE glap_t.glapdocno,
     glapdocdt     LIKE glap_t.glapdocdt,
     glap010       LIKE glap_t.glap010,
     glap011       LIKE glap_t.glap011,
     glapstus      LIKE glap_t.glapstus,
     glap012       LIKE glap_t.glap012
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
#
PRIVATE FUNCTION axrp342_p()
   DEFINE l_glapdocno        LIKE glap_t.glapdocno
   DEFINE l_docno            LIKE xrca_t.xrcadocno
   DEFINE l_glapstus         LIKE glap_t.glapstus
   DEFINE l_success          LIKE type_t.num5
   DEFINE l_wc               STRING
   DEFINE l_sql              STRING
   DEFINE l_ac               LIKE type_t.num5
   DEFINE li_idx             LIKE type_t.num5
   DEFINE l_scom0002         LIKE type_t.chr10   #161121-00031#1 add lujh
   
   #错误信息汇总初始化
   CALL cl_err_collect_init()
   
   LET l_sql = "SELECT glapdocno,glapdocdt FROM axrp342_tmp WHERE sel = 'Y' ORDER BY glapdocno DESC"
   PREPARE axrp342_pre_1 FROM l_sql
   DECLARE axrp342_cs CURSOR FOR axrp342_pre_1
   
   CALL g_glap_d.clear()
   LET l_ac = 1
   
   FOREACH axrp342_cs INTO g_glap_d[l_ac].*
      LET l_ac = l_ac + 1
   END FOREACH 
   CALL g_glap_d.deleteElement(l_ac)
   LET l_ac = l_ac - 1
   
   CALL cl_get_para(g_enterprise,g_input.glaacomp,'S-COM-0002') RETURNING l_scom0002   #161121-00031#1 add lujh
   
   #锁资料
   LET l_sql = "SELECT glapent,glapld,glapdocno FROM glap_t WHERE glapent = ? AND glapld = ? AND glapdocno = ? FOR UPDATE"
   LET l_sql = cl_sql_forupd(l_sql)                #轉換不同資料庫語法
   LET l_sql = cl_sql_add_mask(l_sql)              #遮蔽特定資料
   DECLARE axrp342_cl CURSOR FROM l_sql            # LOCK CURSOR
   
   FOR li_idx = 1 TO g_glap_d.getLength()
      #开启事务
      CALL s_transaction_begin()
      OPEN axrp342_cl USING g_enterprise,g_input.glaald,g_glap_d[li_idx].glapdocno
      
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_glap_d[li_idx].glapdocno,"  OPEN axrp342_cl:"   
         LET g_errparam.code   =  STATUS 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()

         CLOSE axrp342_cl
         CALL s_transaction_end('N','0')
         CONTINUE FOR
      END IF
      
      SELECT glapstus INTO l_glapstus
        FROM glap_t
       WHERE glapent = g_enterprise
         AND glapld = g_input.glaald
         AND glapdocno = g_glap_d[li_idx].glapdocno
         
      IF l_glapstus = 'Y' OR l_glapstus = 'S' THEN 
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_glap_d[li_idx].glapdocno
         LET g_errparam.code   = 'axr-00076'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET g_success = 'N' 
      END IF
      
      #170103-00019#1--add--str--
      #更新相关的细项立冲账资料
      LET l_success = TRUE
      CALL s_pre_voucher_delete_glax(g_input.glaald,g_glap_d[li_idx].glapdocno,'',l_scom0002) RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = 'N' 
      END IF
      #170103-00019#1--add--end
      
      #161121-00031#1--add--str--lujh
      IF l_scom0002 = 'Y' THEN 
         CALL axrp342_update_gl(g_glap_d[li_idx].glapdocno)
      ELSE
      #161121-00031#1--add--end--lujh
         CALL axrp342_delete_gl(g_glap_d[li_idx].glapdocno)
         
         #先让g_prog='aglt310',可以删除最大编号
         LET g_prog = 'aglt310'
         
         CALL s_aooi200_fin_del_docno(g_input.glaald,g_glap_d[li_idx].glapdocno,g_glap_d[li_idx].glapdocdt)RETURNING l_success      #141226 Add
         IF NOT l_success THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00300'
            LET g_errparam.extend = ''
            LET g_errparam.popup = TRUE
            CALL cl_err()            
            CALL s_transaction_end('N',0)         
            CONTINUE FOR           
         END IF 
         LET g_prog = 'axrp342'
      END IF   #161121-00031#1 add lujh
      
      IF g_input.type = 'axrt300' THEN    #應收立帳
         UPDATE xrcb_t SET xrcb025 = NULL,
                           xrcb026 = NULL 
          WHERE xrcbent = g_enterprise
            AND xrcbld  = g_input.glaald   
            AND xrcbdocno IN (SELECT xrcadocno FROM xrca_t WHERE xrcaent = g_enterprise 
                                 AND xrcald = g_input.glaald AND xrca038 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update xrcb',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF    
         
         IF g_glaa121 = 'Y' THEN 
            LET l_wc =" glgadocno IN ((SELECT xrcadocno FROM xrca_t ",
                      "                WHERE xrcaent = '",g_enterprise,"'",
                      "                  AND xrcald = '",g_input.glaald,"'",
                      "                  AND xrca038 = '",g_glap_d[li_idx].glapdocno,"'))"
            CALL s_pre_voucher_upd('AR','R10',g_input.glaald,'','','',l_wc) RETURNING l_success
            
            IF l_success = FALSE THEN 
               LET g_success = 'N'
            END IF
         END IF
         
         UPDATE xrca_t SET xrca038 = NULL
          WHERE xrcaent = g_enterprise
            AND xrcald = g_input.glaald
            AND xrca038 = g_glap_d[li_idx].glapdocno 
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update xrca',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
      END IF
         
      IF g_input.type = 'axrt400' THEN    #應收立帳
         UPDATE xrce_t SET xrce029 = NULL,
                           xrce030 = NULL 
          WHERE xrceent = g_enterprise
            AND xrceld  = g_input.glaald   
            AND xrcedocno IN (SELECT xrdadocno FROM xrda_t WHERE xrdaent = g_enterprise 
                                 AND xrdald = g_input.glaald AND xrda014 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update xrce',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         UPDATE xrde_t SET xrde029 = NULL,
                           xrde030 = NULL 
          WHERE xrdeent = g_enterprise
            AND xrdeld  = g_input.glaald   
            AND xrdedocno IN (SELECT xrdadocno FROM xrda_t WHERE xrdaent = g_enterprise 
                                 AND xrdald = g_input.glaald AND xrda014 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update xrde',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         IF g_glaa121 = 'Y' THEN 
            LET l_wc =" glgadocno IN ((SELECT xrdadocno FROM xrda_t ",
                      "                WHERE xrdaent = '",g_enterprise,"'",
                      "                  AND xrdald = '",g_input.glaald,"'",
                      "                  AND xrda014 = '",g_glap_d[li_idx].glapdocno,"'))"
            CALL s_pre_voucher_upd('AR','R20',g_input.glaald,'','','',l_wc) RETURNING l_success
            
            IF l_success = FALSE THEN 
               LET g_success = 'N'
            END IF
         END IF
         
         UPDATE xrda_t SET xrda014 = NULL
          WHERE xrdaent = g_enterprise
            AND xrdald = g_input.glaald
            AND xrda014 = g_glap_d[li_idx].glapdocno 
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update xrda',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
  
      END IF
      
      IF g_input.type = 'aapt300' THEN    #應付立帳
         UPDATE apcb_t SET apcb025 = NULL,
                           apcb026 = NULL 
          WHERE apcbent = g_enterprise
            AND apcbld  = g_input.glaald   
            AND apcbdocno IN (SELECT apcadocno FROM apca_t WHERE apcaent = g_enterprise 
                                 AND apcald = g_input.glaald AND apca038 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apcb',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         UPDATE apce_t SET apce029 = NULL,
                           apce030 = NULL 
          WHERE apceent = g_enterprise
            AND apceld  = g_input.glaald   
            AND apcedocno IN (SELECT apcadocno FROM apca_t WHERE apcaent = g_enterprise 
                                 AND apcald = g_input.glaald AND apca038 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apce',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         UPDATE apde_t SET apde029 = NULL,
                           apde030 = NULL 
          WHERE apdeent = g_enterprise
            AND apdeld  = g_input.glaald   
            AND apdedocno IN (SELECT apcadocno FROM apca_t WHERE apcaent = g_enterprise 
                                 AND apcald = g_input.glaald AND apca038 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apde',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         IF g_glaa121 = 'Y' THEN 
            LET l_wc =" glgadocno IN ((SELECT apcadocno FROM apca_t ",
                      "                WHERE apcaent = '",g_enterprise,"'",
                      "                  AND apcald = '",g_input.glaald,"'",
                      "                  AND apca038 = '",g_glap_d[li_idx].glapdocno,"'))"
            CALL s_pre_voucher_upd('AP','P10',g_input.glaald,'','','',l_wc) RETURNING l_success
            
            IF l_success = FALSE THEN 
               LET g_success = 'N'
            END IF
         END IF
         
         UPDATE apca_t SET apca038 = NULL
          WHERE apcaent = g_enterprise
            AND apcald = g_input.glaald
            AND apca038 = g_glap_d[li_idx].glapdocno 
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apca',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
      END IF
      
      #IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' THEN    #請款                              #170124-00030#1 mark
      IF g_input.type = 'aapt400' OR g_input.type = 'aapt430' OR g_input.type = 'aapt450' THEN    #請款   #170124-00030#1 add
         UPDATE apce_t SET apce029 = NULL,
                           apce030 = NULL 
          WHERE apceent = g_enterprise
            AND apceld  = g_input.glaald   
            AND apcedocno IN (SELECT apdadocno FROM apda_t WHERE apdaent = g_enterprise 
                                 AND apdald = g_input.glaald AND apda014 = g_glap_d[li_idx].glapdocno)  
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apce',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF
         
         IF g_glaa121 = 'Y' THEN 
            LET l_wc =" glgadocno IN ((SELECT apdadocno FROM apda_t ",
                      "                WHERE apdaent = '",g_enterprise,"'",
                      "                  AND apdald = '",g_input.glaald,"'",
                      "                  AND apda014 = '",g_glap_d[li_idx].glapdocno,"'))"
            CALL s_pre_voucher_upd('AP','P20',g_input.glaald,'','','',l_wc) RETURNING l_success
            
            IF l_success = FALSE THEN 
               LET g_success = 'N'
            END IF
         END IF
         
         UPDATE apda_t SET apda014 = NULL
          WHERE apdaent = g_enterprise
            AND apdald = g_input.glaald
            AND apda014 = g_glap_d[li_idx].glapdocno 
         
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = 'update apda',g_glap_d[li_idx].glapdocno
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET g_success = 'N' 
         END IF 
      END IF
      
      IF g_success = 'N' THEN
         CALL s_transaction_end('N','1') 
      ELSE
         CALL s_transaction_end('Y','1')
      END IF
      
      CLOSE axrp342_cl       #20160216 add lujh
   END FOR
   
   
   CALL cl_err_collect_show()
END FUNCTION
# 刪除總賬資料
PRIVATE FUNCTION axrp342_delete_gl(p_glapdocno)
   DEFINE p_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_ap_slip        LIKE glap_t.glapdocno #150703-00021#39
   DEFINE l_dfin5002       LIKE type_t.chr1      #150703-00021#39
   DEFINE l_apcadocno      LIKE apca_t.apcadocno #150703-00021#39
   
   DELETE FROM glap_t 
       WHERE glapent = g_enterprise
         AND glapld = g_input.glaald
         AND glapdocno = p_glapdocno 
         
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'DELETE glap_t',p_glapdocno
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF
   
   DELETE FROM glaq_t 
    WHERE glaqent = g_enterprise
      AND glaqld = g_input.glaald
      AND glaqdocno = p_glapdocno 
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'DELETE glaq_t',p_glapdocno
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF
   
   DELETE FROM glbc_t
    WHERE glbcent = g_enterprise
      AND glbcld  = g_input.glaald
      AND glbcdocno = p_glapdocno
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'DELETE glbc_t',p_glapdocno
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF
   #170116-00074#4---s---  aapp330已經不會拋到aglt310 所以也不用刪除相關檔案
   ##150703-00021#39 ---s---  刪除相關的預算滾動檔
   #CALL s_aooi200_fin_get_slip(p_glapdocno) RETURNING g_sub_success,l_ap_slip
   #CALL s_fin_get_doc_para(g_input.glaald,g_input.glaacomp,l_ap_slip,'D-FIN-5002') RETURNING l_dfin5002
   #IF l_dfin5002 = 'Y' THEN 
   #   DELETE FROM bgbd_t 
   #    WHERE bgbdent = g_enterprise
   #      AND bgbd037 = p_glapdocno   
   #    
   #   LET g_sql = " SELECT apcadocno FROM apca_t WHERE apcaent = '",g_enterprise,"'      ",
   #               "    AND apcald = '",g_input.glaald,"' AND apca038 = '",p_glapdocno,"' "
   #   PREPARE apca_prep01 FROM g_sql
   #   DECLARE apca_curs01 CURSOR FOR apca_prep01
   #   FOREACH apca_curs01 INTO l_apcadocno
   #      #轉出回寫
   #      CALL s_aapt300_bgbd_upd(l_apcadocno,g_input.glaald,'','UD','3') RETURNING g_sub_success,g_errno
   #   END FOREACH
   #END IF
   #150703-00021#39  ---e---
   #170116-00074#4---e---
   
   
   
   
END FUNCTION
#  將取回的字串轉換為SQL條件
PRIVATE FUNCTION axrp342_change_to_sql(p_wc)
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
# 作废总账凭证
#161121-00031#1 add lujh
PRIVATE FUNCTION axrp342_update_gl(p_glapdocno)
   DEFINE p_glapdocno      LIKE glap_t.glapdocno
   DEFINE l_ap_slip        LIKE glap_t.glapdocno 
   DEFINE l_dfin5002       LIKE type_t.chr1      
   DEFINE l_apcadocno      LIKE apca_t.apcadocno 
   
   UPDATE glap_t SET glapstus = 'X'
    WHERE glapent = g_enterprise
      AND glapld = g_input.glaald
      AND glapdocno = p_glapdocno 
         
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'UPDATE glap_t',p_glapdocno
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF
   
   #170103-00019#1--add--str--
   #删除相关现金变动码资料
   DELETE FROM glbc_t
    WHERE glbcent = g_enterprise
      AND glbcld  = g_input.glaald
      AND glbcdocno = p_glapdocno
      
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = 'DELETE glbc_t',p_glapdocno
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_success = 'N' 
      RETURN
   END IF
   #170103-00019#1--add--end
   
   CALL s_aooi200_fin_get_slip(p_glapdocno) RETURNING g_sub_success,l_ap_slip
   CALL s_fin_get_doc_para(g_input.glaald,g_input.glaacomp,l_ap_slip,'D-FIN-5002') RETURNING l_dfin5002
   IF l_dfin5002 = 'Y' THEN 
      DELETE FROM bgbd_t 
       WHERE bgbdent = g_enterprise
         AND bgbd037 = p_glapdocno   
       
      LET g_sql = " SELECT apcadocno FROM apca_t WHERE apcaent = '",g_enterprise,"'      ",
                  "    AND apcald = '",g_input.glaald,"' AND apca038 = '",p_glapdocno,"' "
      PREPARE apca_prep02 FROM g_sql
      DECLARE apca_curs02 CURSOR FOR apca_prep02
      FOREACH apca_curs02 INTO l_apcadocno
         #轉出回寫
         CALL s_aapt300_bgbd_upd(l_apcadocno,g_input.glaald,'','UD','3') RETURNING g_sub_success,g_errno
      END FOREACH
   END IF

END FUNCTION

#end add-point
 
{</section>}
 
