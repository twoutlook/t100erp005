#該程式未解開Section, 採用最新樣板產出!
{<section id="aapp135.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0013(2016-08-05 19:16:15), PR版次:0013(2017-01-06 15:56:13)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000179
#+ Filename...: aapp135
#+ Description: 應付立帳單批次還原作業
#+ Creator....: 03080(2014-06-16 09:25:28)
#+ Modifier...: 03538 -SD/PR- 06821
 
{</section>}
 
{<section id="aapp135.global" >}
#應用 p02 樣板自動產生(Version:22)
#add-point:填寫註解說明 name="global.memo"
#161229-00047#6   170106      By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
#141204-00017#1 15/01/08 By apo     還原單據有沖暫估者,必須還原暫估單據之已沖金額
#141204-00017#1 15/01/26 By apo     增加條件 1.只處理未確認資料 2.只處理由前端資料產生之單據性質  3.還原數量後入庫單數量不可小於0
#150126-00012#1 15/01/27 By apo     lock cursor鎖定本次將異動的立帳單/入庫單資訊
#150127-00007#1 15/02/24 By Reanna  掃把清空&給預設值
#151231-00010#6 16/01/25 By sakura  增加控制組
#160812-00027#3 16/08/19 By 06821   全面盤點應付程式帳套權限控管
#161006-00005#2 16/10/12 By 08732   組織類型與職能開窗調整
#161115-00042#1 16/11/18 By 08171   開窗範圍處理
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
    sel              LIKE type_t.chr1,
    b_apca004        LIKE apca_t.apca004,     #交易對象
    b_apca004_desc   LIKE type_t.chr1000,    
    b_apca001        LIKE apca_t.apca001,     #帳款單性質
    b_apcadocno      LIKE apca_t.apcadocno,   #帳款單號
    b_apcadocdt      LIKE apca_t.apcadocdt,   #立帳日期
    b_apcastus       LIKE apca_t.apcastus,    #帳款單狀態
    b_apca100        LIKE apca_t.apca100,     #原幣幣別
    b_apca104        LIKE apca_t.apca104,     
    b_apca103        LIKE apca_t.apca103,
    b_apca103104     LIKE type_t.num15_3,     #交易含稅金額
    b_apca106        LIKE apca_t.apca106,     #帳款單直接沖銷
    b_sum_apcc109    LIKE type_t.num20_6,     #請款沖帳金額
    b_apca038        LIKE apca_t.apca038,     #傳票編號
    b_apcasite       LIKE apca_t.apcasite,    #帳務中心
    b_apcasite_desc  LIKE type_t.chr1000,     
    b_apca003        LIKE apca_t.apca003,     #帳務人員
    b_apca003_desc   LIKE type_t.chr1000,
    b_apca014        LIKE apca_t.apca014,
    b_apca014_desc   LIKE type_t.chr1000,
    b_apcacrtid      LIKE apca_t.apcacrtid,
    b_apcacrtid_desc LIKE type_t.chr1000,
    b_apcacrtdt      LIKE apca_t.apcacrtdt,
    b_apcacnfid      LIKE apca_t.apcacnfid,
    b_apcacnfid_desc LIKE type_t.chr1000,
    b_apcacnfdt      LIKE apca_t.apcacnfdt
                     END RECORD

TYPE type_g_detail2_d RECORD
     b2_isam009       LIKE isam_t.isam009,
     b2_isam010       LIKE isam_t.isam010,
     b2_isamstus      LIKE isam_t.isamstus,
     b2_isam011       LIKE isam_t.isam011,
     b2_isam014       LIKE isam_t.isam014,
     b2_isam023       LIKE isam_t.isam023,
     b2_isam024       LIKE isam_t.isam024,
     b2_isam025       LIKE isam_t.isam025,
     b2_isam008       LIKE type_t.chr500, 
     b2_isam200       LIKE isam_t.isam200,
     b2_isam012       LIKE type_t.chr500,
     b2_isam006       LIKE type_t.chr500,
     b2_isamdocno     LIKE isam_t.isamdocno
                      END RECORD 
DEFINE g_rec_b              LIKE type_t.num10
DEFINE g_rec_b2             LIKE type_t.num10
DEFINE g_detail2_d DYNAMIC ARRAY OF type_g_detail2_d

DEFINE tm             RECORD 
                      apca_wc       STRING,
                      apcb_wc       STRING,
                      apcasite      LIKE apca_t.apcasite,
                      apcasite_desc LIKE type_t.chr100,
                      apcald        LIKE apca_t.apcald,
                      apcald_desc   LIKE type_t.chr100,
                      apcacomp      LIKE apca_t.apcacomp,
                      apcacomp_desc LIKE type_t.chr100
                      END RECORD
DEFINE l_ac2          LIKE type_t.num10
DEFINE g_success1     LIKE type_t.num5
DEFINE g_aapp135msg   STRING

DEFINE g_wc_apcasite STRING
DEFINE g_wc_apcald   STRING
DEFINE g_sql_ctrl    STRING   #151231-00010#6
DEFINE g_apcacomp    LIKE apca_t.apcacomp  #161115-00042#1
DEFINE g_wc_cs_comp  STRING  #161229-00047#6 add
DEFINE g_comp_str    STRING  #161229-00047#6 add 
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
DEFINE g_detail_cnt         LIKE type_t.num10              #單身 總筆數(所有資料)
DEFINE g_detail_d  DYNAMIC ARRAY OF type_g_detail_d
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapp135.main" >}
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
   CALL s_fin_create_account_center_tmp()    #20150424 add lujh
   #end add-point
 
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      #20150424--add--str--lujh
      CALL aapp135_qbe_clear()
      CALL aapp135_b_fill()
      CALL aapp135_process()
      #20150424--add--end--lujh
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapp135 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapp135_init()   
 
      #進入選單 Menu (="N")
      CALL aapp135_ui_dialog() 
 
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
      #畫面關閉
      CLOSE WINDOW w_aapp135
   END IF 
   
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="aapp135.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aapp135_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define name="init.define"
   
   #end add-point   
   
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL s_fin_create_account_center_tmp()   #20150424 mark lujh
   CALL cl_set_combo_scc('b2_isamstus','50')
   CALL cl_set_combo_scc('b_apca001','8502')
   CALL cl_set_combo_scc('b_apcastus','13')
   
   #150127-00007#1 mark---
   #為了掃把清空時給預設所以移至 aapp135_qbe_clear()裡面
   ##帳務組織/帳套/法人預設
   #CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,tm.apcasite,
   #                                                   tm.apcald,tm.apcacomp
   #LET tm.apcasite_desc = s_desc_get_department_desc (tm.apcasite)
   #LET tm.apcald_desc = s_desc_get_ld_desc(tm.apcald)
   #LET tm.apcacomp_desc = s_desc_get_department_desc(tm.apcacomp)
   #IF cl_null(tm.apcacomp_desc)THEN
   #   LET tm.apcacomp_desc = tm.apcacomp
   #ELSE
   #   LET tm.apcacomp_desc = tm.apcacomp,' (',tm.apcacomp_desc,') '
   #END IF
   #CALL s_fin_account_center_sons_query('3',tm.apcasite,g_today,'1')
   ##取得帳務中心底下之組織範圍
   #CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   #CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   ##取得帳務中心底下的帳套範圍
   #CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   #CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   #DISPLAY BY NAME tm.apcald,tm.apcacomp,tm.apcald_desc,tm.apcacomp_desc,tm.apcasite,tm.apcasite_desc
   #150127-00007#1 mark end---
   
   #151231-00010#1(S)
   LET g_sql_ctrl = NULL
  #CALL s_control_get_supplier_sql('4',g_site,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 mark
   #161115-00042#1 --s add
   SELECT ooef017 INTO g_apcacomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apcacomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#6 mark
   #161115-00042#1 --e add
   #151231-00010#1(E)   
   #161229-00047#6 --s add
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#6 --e add      
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapp135.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapp135_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE li_idx   LIKE type_t.num10
   #add-point:ui_dialog段define name="init.init"
   DEFINE l_comp_wc    STRING #161115-00042#1 add
   #end add-point 
   
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "  
   CALL cl_set_act_visible("accept,cancel", FALSE)
         
   LET g_detail_cnt = g_detail_d.getLength()
   #add-point:ui_dialog段before dialog name="ui_dialog.before_dialog"
   #150127-00007#1
   CALL aapp135_qbe_clear()
   #end add-point
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_detail_d.clear()
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapp135_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:ui_dialog段construct name="ui_dialog.more_construct"
         CONSTRUCT tm.apca_wc ON apca004,apcadocno,apcadocdt,
                                 apca003,apcacrtid 
                            FROM apca004,apcadocno,apcadocdt,
                                 apca003,apcacrtid   
         
            ON ACTION controlp INFIELD apca004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #151231-00010#1(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_sql_ctrl
               END IF
               #151231-00010#1(E)               
               CALL q_pmaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca004      #顯示到畫面上
               NEXT FIELD apca004
            
            ON ACTION controlp INFIELD apcasite #帳務中心
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #CALL q_ooef001()     #161006-00005#2  mark
               CALL q_ooef001_46()   #161006-00005#2  add
               DISPLAY g_qryparam.return1 TO apcasite
               NEXT FIELD apcasite
            
            ON ACTION controlp INFIELD apca003 #帳務人員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apca003      #顯示到畫面上
               NEXT FIELD apca003
               
            ON ACTION controlp INFIELD apcadocno #帳款單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "     apcald = '",tm.apcald,"' ",
                                      " AND apca001 IN ('01','02','11','13','17','22') "   #141204-00017#1
               #151231-00010#1(S)
               IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
                  LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                          "              WHERE pmaaent = ",g_enterprise,
                                                          "                AND ",g_sql_ctrl,
                                                          "                AND pmaa001 = apca004 )"
               END IF
               #151231-00010#1(E)                                      
               CALL q_apcadocno_7()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO apcadocno      #顯示到畫面上
               NEXT FIELD apcadocno   
                
            ON ACTION controlp INFIELD apcacrtid #帳務人員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO apcacrtid
               NEXT FIELD apcacrtid

            AFTER CONSTRUCT

         END CONSTRUCT

         CONSTRUCT tm.apcb_wc ON apcb002 FROM apcb002
            
            ON ACTION controlp INFIELD apcb002 #來源單號碼
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "apcbld = '",tm.apcald,"' AND apcb001 IS NOT NULL AND apcb002 IS NOT NULL    ",
                                                          "  AND apcc109 = 0 AND apcastus = 'N' AND apcb023='N'"   #141204-00017#1 狀態限定N   
            #151231-00010#6(S)
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND EXISTS (SELECT 1 FROM pmaa_t ",
                                                       "              WHERE pmaaent = ",g_enterprise,
                                                       "                AND ",g_sql_ctrl,
                                                       "                AND pmaa001 = apca004 )"
            END IF
            #151231-00010#6(E)            
            CALL q_apcb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apcb002      #顯示到畫面上
            NEXT FIELD apcb002 
            
            AFTER CONSTRUCT
         END CONSTRUCT
         #end add-point
         #add-point:ui_dialog段input name="ui_dialog.more_input"
         INPUT BY NAME tm.apcald ,tm.apcasite ATTRIBUTE(WITHOUT DEFAULTS) 
                    
            AFTER FIELD apcasite
               LET tm.apcasite_desc = ''
               IF NOT cl_null(tm.apcasite) THEN
                  CALL s_fin_account_center_with_ld_chk(tm.apcasite,tm.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET tm.apcasite = ''
                     LET tm.apcasite_desc = ''
                     LET tm.apcald = ''
                     LET tm.apcald_desc = ''
                     LET tm.apcacomp_desc = ''
                     LET g_wc_apcasite = ''
                     LET g_wc_apcald   = ''
                     DISPLAY BY NAME tm.apcasite,tm.apcasite_desc,tm.apcald,tm.apcald_desc,tm.apcacomp_desc
                     CALL s_desc_get_department_desc(tm.apcasite) RETURNING tm.apcasite_desc
                     DISPLAY BY NAME tm.apcasite_desc
                     NEXT FIELD CURRENT
                  END IF                              
                  #帳務中心預設主帳套及主帳套所屬法人及其他預設值         
                  CALL s_fin_orga_get_comp_ld(tm.apcasite) RETURNING g_sub_success,g_errno,tm.apcacomp,tm.apcald
                  #法人說明
                  IF NOT cl_null(s_desc_get_department_desc(tm.apcacomp))THEN 
                     CALL s_desc_get_department_desc(tm.apcacomp)RETURNING tm.apcacomp_desc              
                     LET tm.apcacomp_desc = tm.apcacomp,' (',tm.apcacomp_desc,') '
                  ELSE 
                     LET tm.apcacomp_desc  = tm.apcacomp
                  END IF
                  CALL s_desc_get_department_desc(tm.apcasite) RETURNING tm.apcasite_desc
                  CALL s_desc_get_ld_desc(tm.apcald)RETURNING tm.apcald_desc                  
                  #取得帳務中心底下之組織範圍
                  CALL s_fin_account_center_sons_query('3',tm.apcasite,g_today,'')               
                  CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite  
                  CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
                  CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
                  CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald 
                  CALL s_fin_get_wc_str(tm.apcacomp) RETURNING g_comp_str #161229-00047#6 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl   #161229-00047#6 add
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',tm.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#6 mark                  
               END IF 
               DISPLAY BY NAME tm.apcasite_desc,tm.apcacomp_desc,tm.apcald_desc
               #161115-00042#1 --s add
               CALL s_fin_account_center_sons_query('3',tm.apcasite,g_today,'1')  #依據正確的資料再重展一次結構
               #取得帳務中心底下的帳套範圍 
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
               #161115-00042#1 --e add
               
            AFTER FIELD apcald
               LET tm.apcald_desc  = ''
               LET tm.apcacomp_desc = ''
               IF NOT cl_null(tm.apcald) THEN
                  #CALL s_fin_account_center_with_ld_chk(tm.apcasite,tm.apcald,g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno #帳別檢查 #160812-00027#3 mark
                  #CALL s_fin_account_center_with_ld_chk(tm.apcasite,tm.apcald,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno #帳別檢查  #160812-00027#3 add #161115-00042#1 mark
                  CALL s_fin_account_center_with_ld_chk(tm.apcasite,tm.apcald,g_user,'3','Y',g_wc_apcald,g_today) RETURNING g_sub_success,g_errno #161115-00042#1 add
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     CALL s_fin_ld_carry('',g_user)RETURNING g_sub_success,tm.apcald,tm.apcacomp,g_errno #取回預設值
                     CALL s_desc_get_ld_desc(tm.apcald) RETURNING tm.apcald_desc
                     CALL s_desc_get_department_desc(tm.apcacomp) RETURNING tm.apcacomp_desc
                     DISPLAY BY NAME tm.apcald_desc,tm.apcacomp_desc,tm.apcacomp
                     NEXT FIELD apcald
                  END IF
                  
                  #取得帳套所屬法人
                  CALL s_fin_ld_carry(tm.apcald,g_user)RETURNING g_sub_success,tm.apcald,tm.apcacomp,g_errno
                  CALL s_fin_get_wc_str(tm.apcacomp) RETURNING g_comp_str #161229-00047#6 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl   #161229-00047#6 add 
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',tm.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#6 mark
                  CALL s_desc_get_ld_desc(tm.apcald)RETURNING tm.apcald_desc
                  #法人說明
                  IF NOT cl_null(s_desc_get_department_desc(tm.apcacomp))THEN 
                     CALL s_desc_get_department_desc(tm.apcacomp)RETURNING tm.apcacomp_desc              
                     LET tm.apcacomp_desc = tm.apcacomp,' (',tm.apcacomp_desc,') '
                  ELSE 
                     LET tm.apcacomp_desc  = tm.apcacomp
                  END IF                                   
               END IF            
               DISPLAY BY NAME tm.apcald_desc,tm.apcacomp,tm.apcacomp_desc  
         
            ON ACTION controlp INFIELD apcald
               CALL s_fin_account_center_comp_str() RETURNING l_comp_wc   #161115-00042#1  add
               CALL s_fin_get_wc_str(l_comp_wc) RETURNING l_comp_wc       #161115-00042#1  add
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.apcald         #給予default值
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               #LET g_qryparam.where = " glaald IN ", g_wc_apcald                                      #160812-00027#3 mark
               #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ", g_wc_apcald  #160812-00027#3 add #161115-00042#1 mark 
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",l_comp_wc,""  #161115-00042#1 add
               CALL q_authorised_ld()                                       #呼叫開窗
               LET tm.apcald = g_qryparam.return1    #將開窗取得的值回傳到變數               
               CALL s_fin_ld_carry(tm.apcald,'') RETURNING g_sub_success,tm.apcald,tm.apcacomp,g_errno
               LET tm.apcald_desc = s_desc_get_ld_desc(tm.apcald)
               IF NOT cl_null(s_desc_get_department_desc(tm.apcacomp))THEN 
                  CALL s_desc_get_department_desc(tm.apcacomp)RETURNING tm.apcacomp_desc              
                  LET tm.apcacomp_desc = tm.apcacomp,' (',tm.apcacomp_desc,') '
               ELSE 
                  LET tm.apcacomp_desc  = tm.apcacomp
               END IF
               DISPLAY BY NAME tm.apcald,tm.apcacomp,tm.apcald_desc,tm.apcacomp_desc
               NEXT FIELD apcald 
               
            ON ACTION controlp INFIELD apcasite    
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.apcasite
               #CALL q_ooef001()     #161006-00005#2  mark
               CALL q_ooef001_46()   #161006-00005#2  add
               LET tm.apcasite = g_qryparam.return1
               CALL s_desc_get_department_desc(tm.apcasite) RETURNING tm.apcasite_desc
               CALL s_fin_account_center_sons_query('3',tm.apcasite,g_today,'')               
               CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite  
               CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
               CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
               CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald               
               DISPLAY BY NAME tm.apcasite,tm.apcasite_desc
               NEXT FIELD apcasite
           
         END INPUT
         
     
         
         
         
         
         
         
         
         
         #end add-point
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
        #DISPLAY ARRAY g_detail_d TO s_detail1.* ATTRIBUTES(COUNT=g_detail_cnt)   #160805-00026#1 mark
         #160805-00026#1--s
         INPUT ARRAY g_detail_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)         
         #160805-00026#1--e

           #BEFORE DISPLAY   #160805-00026#1 mark
            BEFORE INPUT     #160805-00026#1 

               LET g_current_page = 1

            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               CALL aapp135_b_fill2(l_ac) #RETURNING g_success1
              #LET l_ac = g_detail_idx
              #DISPLAY g_detail_idx TO FORMONLY.h_index
              #DISPLAY g_detail_d.getLength() TO FORMONLY.h_count
              #LET g_master_idx = l_ac
               CALL aapp135_fetch()


            #160805-00026#1--s
            ON CHANGE sel
               CALL cl_err_collect_init()
               IF g_detail_d[l_ac].sel = 'Y' THEN
                  CALL aapp135_click_chk(tm.apcald,g_detail_d[l_ac].b_apcadocno) RETURNING g_sub_success     
                  IF NOT g_sub_success THEN
                     LET g_detail_d[l_ac].sel = "N"
                  END IF      
               END IF 
               CALL cl_err_collect_show()
            #160805-00026#1--e
            #點選的勾選起來
            ON ACTION choice_one
               CALL cl_err_collect_init()
               FOR li_idx = 1 TO g_detail_d.getLength()
                  IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                     IF g_detail_d[li_idx].sel = 'N' THEN
                        #CALL s_aapt300_unconf_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success  #0224apo mark
                        CALL aapp135_click_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success      #0224apo
                        IF NOT g_sub_success THEN
                           CONTINUE FOR
                        END IF 
                        LET g_detail_d[li_idx].sel = "Y"
                     ELSE
                        LET g_detail_d[li_idx].sel = "N"
                     END IF
                  END IF
               END FOR
               CALL cl_err_collect_show()
        #END DISPLAY   #160805-00026#1 mark
         END INPUT   #160805-00026#1 
          
         DISPLAY ARRAY g_detail2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b2)

            BEFORE ROW
               LET l_ac2= DIALOG.getCurrentRow("s_detail2")

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
            #NEXT FIELD apcadocno
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
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()
               #CALL s_aapt300_unconf_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success  #0224apo mark
               CALL aapp135_click_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success      #0224apo
               IF NOT g_sub_success THEN
                  LET g_detail_d[li_idx].sel = 'N'
                  CONTINUE FOR
               END IF
               LET g_detail_d[li_idx].sel = "Y"
            END FOR
            CALL cl_err_collect_show()
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
            CALL cl_err_collect_init()
            FOR li_idx = 1 TO g_detail_d.getLength()    
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN   #160805-00026#1            
                  #CALL s_aapt300_unconf_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success  #0224apo mark
                  CALL aapp135_click_chk(tm.apcald,g_detail_d[li_idx].b_apcadocno) RETURNING g_sub_success      #0224apo
                  IF NOT g_sub_success THEN
                     LET g_detail_d[li_idx].sel = 'N'
                     CONTINUE FOR
                  END IF
                  LET g_detail_d[li_idx].sel = "Y"
               END IF   #160805-00026#1            
            END FOR
            CALL cl_err_collect_show()
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
            CALL aapp135_filter()
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
            CALL aapp135_query()
             
         # 條件清除
         ON ACTION qbeclear
            #add-point:ui_dialog段 name="ui_dialog.qbeclear"
            #150127-00007#1
            CALL aapp135_qbe_clear()
            #end add-point
 
         # 重新整理
         ON ACTION datarefresh
            LET g_error_show = 1
            #add-point:ui_dialog段datarefresh name="ui_dialog.datarefresh"
            
            #end add-point
            CALL aapp135_b_fill()
 
         #add-point:ui_dialog段action name="ui_dialog.more_action"
         ON ACTION batch_execute        
            CALL cl_err_collect_init()         
            CALL aapp135_process()    
            CALL cl_err_collect_show()            

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
 
{<section id="aapp135.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapp135_query()
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
   CALL aapp135_b_fill()
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
 
{<section id="aapp135.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapp135_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   #add-point:b_fill段define name="b_fill.define"
   DEFINE l_glaacomp      LIKE glaa_t.glaacomp   #150210apo
   
   CALL s_ld_sel_glaa(tm.apcald,'glaacomp') RETURNING  g_sub_success,l_glaacomp  #150210apo   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:21) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET ls_wc = tm.apca_wc CLIPPED
   IF cl_null(ls_wc)THEN LET ls_wc = ' 1=1' END IF
   LET ls_wc = ls_wc CLIPPED, " AND apcasite IN ",g_wc_apcasite
   LET g_sql = "SELECT DISTINCT 'N',apca004,'',apca001,apcadocno,apcadocdt,apcastus,apca100,apca104,apca103,0, ",
               "       apca106,0,apca038,apcasite,'',apca003,'',apca014,'',apcacrtid,'',",
               "       apcacrtdt,apcacnfid,'',apcacnfdt "
   IF NOT cl_null(tm.apcb_wc) AND tm.apcb_wc <> ' 1=1' THEN
      LET g_sql = g_sql CLIPPED," FROM apca_t,apcb_t "
   ELSE
      LET g_sql = g_sql CLIPPED," FROM apca_t "
   END IF

   LET g_sql = g_sql CLIPPED,
               " WHERE apcaent = ? ",
               "   AND apca017 = '0' ",
               "   AND apca001 IN ('01','02','11','13','17','22') ",   #141204-00017#1
               "   AND apcald = '",tm.apcald,"' ",
               "   AND apcastus = 'N' ",  #141204-00017#1 狀態限定N
               "   AND ", ls_wc CLIPPED
   IF NOT cl_null(tm.apcb_wc) AND tm.apcb_wc <> ' 1=1' THEN
      LET g_sql = g_sql CLIPPED,
               "   AND apcbent = apcaent ",
               "   AND apcbld  = apcald ",
               "   AND apcbdocno = apcadocno ",
               "   AND ",tm.apcb_wc,"        "   
   END IF
   #151231-00010#6(S)
   IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
      LET g_sql = g_sql," AND EXISTS (SELECT 1 FROM pmaa_t ",
                        "              WHERE pmaaent = ",g_enterprise,
                        "                AND ",g_sql_ctrl,
                        "                AND pmaaent = apcaent ",
                        "                AND pmaa001 = apca004 )"
   END IF
   #151231-00010#6(E)   
   LET g_sql = g_sql CLIPPED , " ORDER BY apcadocno "
   #150210apo--(s)
   #單據要求連號,則要從最大號開始還原
   IF cl_get_para(g_enterprise,l_glaacomp,'S-COM-0002') = 'Y' THEN   
      LET g_sql = g_sql CLIPPED , " DESC "
   END IF
   #150210apo--(e)
   #end add-point
 
   PREPARE aapp135_sel FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aapp135_sel
   
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
      #20150424--add--str--lujh
      IF NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) THEN 
         LET g_detail_d[l_ac].sel = 'Y'
      END IF
      #20150424--add--end--lujh
      
      IF NOT cl_null(g_detail_d[l_ac].b_apca004)THEN
         LET g_detail_d[l_ac].b_apca004_desc = g_detail_d[l_ac].b_apca004 CLIPPED,"(",
                                               s_desc_get_trading_partner_abbr_desc(g_detail_d[l_ac].b_apca004) CLIPPED,")"
      END IF
      IF NOT cl_null(g_detail_d[l_ac].b_apcasite)THEN
         LET g_detail_d[l_ac].b_apcasite_desc = g_detail_d[l_ac].b_apcasite CLIPPED,"(",
                                                s_desc_get_department_desc(g_detail_d[l_ac].b_apcasite) CLIPPED,")"
      END IF
      IF NOT cl_null(g_detail_d[l_ac].b_apca003)THEN
         LET g_detail_d[l_ac].b_apca003_desc  = g_detail_d[l_ac].b_apca003 CLIPPED,"(",
                                              s_desc_get_person_desc(g_detail_d[l_ac].b_apca003),")"
      END IF
      IF NOT cl_null(g_detail_d[l_ac].b_apca014)THEN
         LET g_detail_d[l_ac].b_apca014_desc  = g_detail_d[l_ac].b_apca014 CLIPPED,"(",
                                              s_desc_get_person_desc(g_detail_d[l_ac].b_apca014),")" 
      END IF
      IF NOT cl_null(g_detail_d[l_ac].b_apcacrtid)THEN
         LET g_detail_d[l_ac].b_apcacrtid_desc = g_detail_d[l_ac].b_apcacrtid CLIPPED,"(",
                                                 s_desc_get_person_desc(g_detail_d[l_ac].b_apcacrtid),")"
      END IF
      IF NOT cl_null(g_detail_d[l_ac].b_apcacnfid)THEN
         LET g_detail_d[l_ac].b_apcacnfid_desc = g_detail_d[l_ac].b_apcacnfid CLIPPED,"(",
                                                 s_desc_get_person_desc(g_detail_d[l_ac].b_apcacnfid),")"
      END IF

      #apca103+apca104
      IF cl_null(g_detail_d[l_ac].b_apca103)THEN LET g_detail_d[l_ac].b_apca103 = 0 END IF
      IF cl_null(g_detail_d[l_ac].b_apca104)THEN LET g_detail_d[l_ac].b_apca104 = 0 END IF
      IF cl_null(g_detail_d[l_ac].b_apca106)THEN LET g_detail_d[l_ac].b_apca106 = 0 END IF
      LET g_detail_d[l_ac].b_apca103104 = g_detail_d[l_ac].b_apca103 + g_detail_d[l_ac].b_apca104
      LET g_detail_d[l_ac].b_sum_apcc109 = NULL
      SELECT COALESCE(SUM(apcc109),0) INTO g_detail_d[l_ac].b_sum_apcc109 FROM apcc_t
       WHERE apccent = g_enterprise
         AND apccld  = tm.apcald
         AND apccdocno = g_detail_d[l_ac].b_apcadocno
      IF cl_null(g_detail_d[l_ac].b_sum_apcc109)THEN LET g_detail_d[l_ac].b_sum_apcc109 = 0 END IF
      #end add-point
      
      CALL aapp135_detail_show()      
 
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
   FREE aapp135_sel
   
   LET l_ac = 1
   CALL aapp135_fetch()
   #add-point:b_fill段資料填充(其他單身) name="b_fill.after_b_fill"
   CALL aapp135_b_fill2(1)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp135.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapp135_fetch()
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
 
{<section id="aapp135.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aapp135_detail_show()
   #add-point:show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point
   #add-point:show段define name="detail_show.define"
   
   #end add-point
   
   #add-point:detail_show段 name="detail_show.detail_show"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aapp135.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aapp135_filter()
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
   
   CALL aapp135_b_fill()
   
END FUNCTION
 
{</section>}
 
{<section id="aapp135.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aapp135_filter_parser(ps_field)
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
 
{<section id="aapp135.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aapp135_filter_show(ps_field,ps_object)
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
   LET ls_condition = aapp135_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapp135.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 第二單身填充
# Date & Author..: 14/06/27 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp135_b_fill2(p_ac)
   DEFINE p_ac       LIKE type_t.num10
   DEFINE l_index    LIKE type_t.num10
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   
   IF cl_null(p_ac) OR p_ac <=  0 THEN RETURN END IF

   LET g_sql = " SELECT isam009,isam010,isamstus,isam011,isam014,isam023,",
               "        isam024,isam025,isam008,isam200,isam012,isam006,",
               "        isam050 ",
               "   FROM isam_t ",
               "  WHERE isament = ",g_enterprise," ",
               "    AND isam050 = '",g_detail_d[p_ac].b_apcadocno,"' "

   PREPARE sel_aapp135_b_fillp2 FROM g_sql
   DECLARE sel_aapp135_b_fillc2 CURSOR FOR sel_aapp135_b_fillp2

   LET l_ooef019 = NULL
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = tm.apcacomp

   CALL g_detail2_d.clear()
   LET l_index = 1
   FOREACH sel_aapp135_b_fillc2 INTO g_detail2_d[l_index].*
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.SQLCODE 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF

      #isam008
      IF NOT cl_null(g_detail2_d[l_index].b2_isam008) THEN 
         LET g_detail2_d[l_index].b2_isam008 = g_detail2_d[l_index].b2_isam008 CLIPPED,
                                        "(",s_desc_get_invoice_type_desc(tm.apcald,g_detail2_d[l_index].b2_isam008),")"
      END IF 
      #isam012
      IF NOT cl_null(g_detail2_d[l_index].b2_isam012) THEN
         LET g_detail2_d[l_index].b2_isam012 = g_detail2_d[l_index].b2_isam012 CLIPPED,
                                              "(",s_desc_get_tax_desc(l_ooef019,g_detail2_d[l_index].b2_isam012) CLIPPED,")"
      END IF
      #isam006
      IF NOT cl_null(g_detail2_d[l_index].b2_isam006) THEN
      LET g_detail2_d[l_index].b2_isam006 = g_detail2_d[l_index].b2_isam006 CLIPPED,
                                         "(",s_desc_get_department_desc(g_detail2_d[l_index].b2_isam006),")"
      END IF
      LET l_index = l_index + 1
   END FOREACH

   CALL g_detail2_d.deleteElement(g_detail2_d.getLength())
END FUNCTION

################################################################################
# Descriptions...: 批次執行
# Date & Author..: 140627 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapp135_process()
DEFINE l_i          LIKE type_t.num5
DEFINE l_cnt        LIKE type_t.num5
DEFINE l_count      LIKE type_t.num5
DEFINE l_flag       LIKE type_t.chr1    #條件範圍是否有資料
DEFINE l_success    LIKE type_t.chr1
DEFINE l_apcasite   LIKE apca_t.apcasite
DEFINE l_slip       LIKE type_t.chr100
DEFINE l_str        STRING
DEFINE l_apca019    LIKE apca_t.apca019
DEFINE l_apcastus   LIKE apca_t.apcastus
DEFINE l_apcadocdt  LIKE apca_t.apcadocdt
DEFINE l_apcacomp   LIKE apca_t.apcacomp
DEFINE l_sfin2002   LIKE type_t.chr100
DEFINE l_sql        STRING
DEFINE l_apcfdocno  LIKE apcf_t.apcfdocno
DEFINE l_apcfseq    LIKE apcf_t.apcfseq
DEFINE l_apcc109    LIKE apcc_t.apcc109
DEFINE l_apcc119    LIKE apcc_t.apcc119
#150126-00012#1-str--
DEFINE l_tmp        RECORD
                    apcb002   LIKE apcb_t.apcb002,
                    apcb003   LIKE apcb_t.apcb003
                    END RECORD
#150126-00012#1-end--
   LET l_success = TRUE
   LET l_flag = 'N'
   #是否有勾選
   FOR l_i = 1 TO g_detail_cnt
      IF g_detail_d[l_i].sel = 'N' THEN
         CONTINUE FOR     
      ELSE
         LET l_flag = 'Y'
      END IF      
   END FOR
      
   #未勾選任何一筆資料
   IF l_flag = 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00159'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   #150126-00012#1--str--
   #本次處理立帳單lock cursor
   LET l_sql = " SELECT apcadocno ",
               "   FROM apca_t",
               "  WHERE apcaent= ? AND apcadocno=? AND apcald=? FOR UPDATE "
   LET l_sql = cl_sql_forupd(l_sql)   #150302-00006#11             
   DECLARE aapp135_apca_cl CURSOR FROM l_sql 
   #本次立帳之入庫單lock cursor
   LET l_sql = " SELECT pmdtdocno,pmdtseq ",
               "   FROM pmdt_t",
               "  WHERE pmdtent= ? AND pmdtdocno=? AND pmdtseq=? FOR UPDATE "
   LET l_sql = cl_sql_forupd(l_sql)   #150302-00006#11
   DECLARE aapp135_pmdt_cl CURSOR FROM l_sql                    
   #撈取立帳單身之入庫單號+項次
   LET l_sql = " SELECT DISTINCT apcb002,apcb003 ",
               "   FROM apcb_t",
               "  WHERE apcbent= ? AND apcbdocno=? AND apcbld=? "
   DECLARE aapp135_sel_apcb CURSOR FROM l_sql      
  #計算迴圈筆數
   DISPLAY '' ,0 TO stagenow,stagecomplete
   LET l_cnt = 0
   FOR l_i = 1 TO g_detail_cnt 
      IF g_detail_d[l_i].sel = 'Y' THEN
         LET l_cnt = l_cnt +1
      END IF
   END FOR
   CALL cl_progress_bar_no_window(l_cnt)
   LET l_str = s_fin_get_colname('aapp135','apcadocno') CLIPPED,':' CLIPPED   
   #150126-00012#1--end--   
   #刪除前
   #回寫入庫單請款數量
   FOR l_i = 1 TO g_detail_cnt 
      CALL s_transaction_begin()
      IF g_detail_d[l_i].sel = 'Y' THEN
         #150126-00012#1-str--
         #本張立帳單資訊必須先lock住,若lock失敗,則本筆不處理         
         OPEN aapp135_apca_cl USING g_enterprise,g_detail_d[l_i].b_apcadocno,tm.apcald   
         IF STATUS THEN
            #150302-00006#11--(s)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = STATUS
            LET g_errparam.extend = s_fin_get_colname('aapt300','apcadocno'),"/",g_detail_d[l_i].b_apcadocno               
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            CONTINUE FOR 
            #150302-00006#11--(e)
            #CALL s_transaction_end('N',0)   #150302-00006#11 mark
            #CONTINUE FOR                    #150302-00006#11 mark
         END IF         
         #本張立帳單單身所有來源入庫單資訊整批先lock住,若lock失敗,則本筆不處理         
         FOREACH aapp135_sel_apcb USING g_enterprise,g_detail_d[l_i].b_apcadocno,tm.apcald INTO l_tmp.*
            OPEN aapp135_pmdt_cl USING g_enterprise,l_tmp.apcb002,l_tmp.apcb003   
            IF STATUS THEN
               #150302-00006#11--(s)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = STATUS
               LET g_errparam.extend = s_fin_get_colname('aapt300','apcb002'),"/",l_tmp.apcb002               
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               CALL s_transaction_end('N','0')
               CONTINUE FOR 
               #150302-00006#11--(e)            
               #CALL s_transaction_end('N',0)   #150302-00006#11 mark
               #CONTINUE FOR                    #150302-00006#11 mark
            END IF             
         END FOREACH
         #150126-00012#1-end--
         #刪除產生的待底單據
         LET l_apcacomp  = ''
         LET l_apca019   = ''
         LET l_apcadocdt = ''
         LET l_apcastus =  ''
         LET l_success = TRUE
         SELECT apcacomp,apca019,apcadocdt,apcastus 
           INTO l_apcacomp,l_apca019,l_apcadocdt,l_apcastus
           FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcadocno = g_detail_d[l_i].b_apcadocno
            AND apcald    = tm.apcald
         #--141204-00017#1--str--
         #僅N:未確認之資料可以還原
         IF l_apcastus <> 'N' THEN
            CALL s_transaction_end('N',0)
            CONTINUE FOR
         END IF
         #--141204-00017#1--end--
         #--150126-00012#1--str--
         #檢核是否立帳單是否已被處理(不存在/已作廢,為已被處理過)
         LET l_cnt = 0
         SELECT COUNT(*) INTO l_cnt FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcald = tm.apcald
            AND apcadocno = g_detail_d[l_i].b_apcadocno
            AND apcastus <> 'X'
         IF l_cnt = 0 THEN
            CALL s_transaction_end('N',0)         
            CONTINUE FOR             
         END IF
         CALL cl_progress_no_window_ing(l_str || g_detail_d[l_i].b_apcadocno)
         #--150126-00012#1--end--         
         #取得沖銷參數
         CALL cl_get_para(g_enterprise,l_apcacomp,'S-FIN-2002') RETURNING l_sfin2002
         #取消確認檢查
         CALL s_aapt300_unconf_chk(tm.apcald,g_detail_d[l_i].b_apcadocno) RETURNING l_success
         IF NOT l_success THEN 
            CALL s_transaction_end('N',0)         
            CONTINUE FOR 
         END IF
         #141204-00017#1-mark--
         ##取得單據別所代表的程式代碼
         #CALL s_aooi200_fin_get_slip(g_detail_d[l_i].b_apcadocno)RETURNING l_success,l_slip
         #SELECT oobx004 INTO g_prog
         #  FROM oobx_t
         # WHERE oobxent = g_enterprise
         #   AND oobx001 = l_slip
         #141204-00017#1-mark--
         #141204-00017#1-str--
         #依帳款單性質,取得對應程式代號
         LET g_prog = s_fin_get_scc_value('8502',g_detail_d[l_i].b_apca001,'3')
         #141204-00017#1-end--
            
         #營運據點連號是否可刪除(只可從最大號開始刪除)         
        #CALL s_aooi200_del_docno(g_detail_d[l_i].b_apcadocno,g_detail_d[l_i].b_apcadocdt)RETURNING l_success                    #141226 Mark
#         CALL s_aooi200_fin_del_docno(tm.apcald,g_detail_d[l_i].b_apcadocno,g_detail_d[l_i].b_apcadocdt)RETURNING l_success      #141226 Add
#         IF NOT l_success THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.code = 'aap-00300'
#            LET g_errparam.extend = ''
#            LET g_errparam.popup = TRUE
#            CALL cl_err()            
#            CALL s_transaction_end('N',0)         
#            LET g_prog = 'aapp135'   #150209apo
#            CONTINUE FOR           
#         END IF     
         LET g_prog = 'aapp135'   #141204-00017#1
         #更新收貨物/入庫單
         CALL s_aapt300_pmdt_upd(tm.apcald,g_detail_d[l_i].b_apcadocno,0,'-') RETURNING l_success,g_errno 
         #141204-00017#1-str--         
         #檢核還原後入庫單數量合理性
         IF NOT aapp135_pmdt_qty_chk(tm.apcald,g_detail_d[l_i].b_apcadocno,g_detail_d[l_i].b_apca001) THEN
            CALL s_transaction_end('N',0)         
            CONTINUE FOR              
         END IF
         #141204-00017#1-end--         
         #141204-00017#1--mark--改為只能還原為確認單據,故此段不須動作
         #IF l_apcastus = 'Y' THEN #單據為確認狀態才可以去更新
         #   CALL s_aapt310_apcb_upd_source(tm.apcald,g_detail_d[l_i].b_apcadocno,'-') RETURNING l_success,g_errno
         #   #141204-00017#1--str--
         #   #有沖暫估者,需還原對應暫估單之已沖金額
         #   LET l_count = 0
         #   SELECT COUNT(*) INTO l_count
         #     FROM apcf_t
         #    WHERE apcfent = g_enterprise 
         #      AND apcfld  = tm.apcald AND apcfdocno = g_detail_d[l_i].b_apcadocno
         #   IF l_count > 0 THEN
         #      LET l_sql = "SELECT apcf008,apcf009,SUM(apcf105),SUM(apcf115)",
         #                  " FROM apcf_t",
         #                  " WHERE apcfent  = ",g_enterprise,
         #                  "   AND apcfld   = '",tm.apcald,"' AND apcfdocno= '",g_detail_d[l_i].b_apcadocno,"'",
         #                  "   AND apcf008 <> 'DIFF'",
         #                  "  GROUP BY apcf008,apcf009"
         #      PREPARE aapp135_prep FROM l_sql
         #      DECLARE aapp135_curs CURSOR FOR aapp135_prep
         #      FOREACH aapp135_curs INTO l_apcfdocno,l_apcfseq,l_apcc109,l_apcc119
         #          IF l_sfin2002 MATCHES '[12]' THEN    #暫估不會有發票
         #              UPDATE apcc_t SET apcc109 = apcc109 - l_apcc109,
         #                                apcc119 = apcc119 - l_apcc119
         #               WHERE apccent = g_enterprise AND apccld = tm.apcald AND apccdocno = l_apcfdocno
         #                 AND apccseq = 1    AND apcc001 = 0
         #           ELSE
         #              UPDATE apcc_t SET apcc109 = apcc109 - l_apcc109,
         #                                apcc119 = apcc119 - l_apcc119
         #               WHERE apccent = g_enterprise AND apccld = tm.apcald AND apccdocno = l_apcfdocno
         #                 AND apccseq = l_apcfseq    AND apcc001 = 0
         #           END IF
         #           IF SQLCA.sqlerrd[3] = 0 THEN
         #              INITIALIZE g_errparam TO NULL
         #              LET g_errparam.code   = 'aap-00317'
         #              LET g_errparam.extend = l_apcfdocno
         #              CALL cl_err()
         #           END IF                    
         #      END FOREACH
         #   END IF         
         #   #141204-00017#1--end--            
         #END IF
         #141204-00017#1--mark--
         
         #161012-00026#1-----s
         CALL s_aapt310_apcb_upd_source(tm.apcald,g_detail_d[l_i].b_apcadocno,'-') RETURNING g_sub_success,g_errno
         #161012-00026#1-----e
         
         #處理發票
         SELECT count(*) INTO l_count
           FROM isam_t
          WHERE isament = g_enterprise 
            AND isam050 = g_detail_d[l_i].b_apcadocno      
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count > 0 THEN
            UPDATE isam_t SET isam050 = ''
             WHERE isament = g_enterprise 
               AND isam050 = g_detail_d[l_i].b_apcadocno
         END IF

         #刪除相關table   
         LET l_str=''
         CALL s_aapt300_del_sub_table(tm.apcald,g_detail_d[l_i].b_apcadocno) RETURNING l_success,g_errno,l_str
         IF NOT l_success THEN
            LET l_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_str
            LET g_errparam.code   = g_errno
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            CALL s_transaction_end('N',0)
            CONTINUE FOR            
         END IF        
         IF NOT cl_null(l_apca019) AND NOT cl_null(l_apcadocdt) THEN
            CALL s_aapt300_modi_apca_doc('aapt340',tm.apcald,l_apca019,l_apcadocdt)  RETURNING l_success,g_errno
         END IF

         #刪除apca/apcb
         DELETE FROM apca_t
          WHERE apcaent = g_enterprise
            AND apcald = tm.apcald
            AND apcadocno = g_detail_d[l_i].b_apcadocno

         #150209apo--(s)
         #依帳款單性質,取得對應程式代號
         LET g_prog = s_fin_get_scc_value('8502',g_detail_d[l_i].b_apca001,'3')         
         #刪除單頭後呼叫元件,更新最大號資訊
         IF NOT s_aooi200_fin_del_docno(tm.apcald,g_detail_d[l_i].b_apcadocno,g_detail_d[l_i].b_apcadocdt) THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'aap-00300'
            LET g_errparam.extend = g_detail_d[l_i].b_apcadocno
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N',0)
            LET g_prog = 'aapp135'   
            CONTINUE FOR
         END IF
         LET g_prog = 'aapp135'   
         #150209apo--(e)

         DELETE FROM apcb_t
          WHERE apcbent = g_enterprise
            AND apcbld  = tm.apcald
            AND apcbdocno = g_detail_d[l_i].b_apcadocno 
         IF NOT l_success THEN   
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'adz-00217'
            LET g_errparam.extend = g_detail_d[l_i].b_apcadocno 
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL s_transaction_end('N',0)  #150209apo
            CONTINUE FOR                   #150209apo
         END IF            
     #END IF   #150302-00006#11 mark
         #150302-00006#11--(s)
         #還原成功
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'aap-00349'
         LET g_errparam.replace[1] = tm.apcald
         LET g_errparam.replace[2] = g_detail_d[l_i].b_apcadocno
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()      
         #150302-00006#11--(e)
         CALL s_transaction_end('Y',0)
         #LET g_prog  = 'aapp135'  #141204-00017#1 mark
      END IF   #150302-00006#11   
   END FOR
   CLOSE aapp135_apca_cl   #150126-00012#1
   CLOSE aapp135_pmdt_cl   #150126-00012#1
    

END FUNCTION

################################################################################
# Descriptions...: 檢核更新後入庫單數量不可為負數
# Memo...........:
# Usage..........: CALL aapp135_pmdt_qty_chk(p_apcald,p_apcadocno,p_apca001)
#                  RETURNING r_success
# Input parameter: p_apcald       帳套
#                : p_apcadocno    帳款單號
#                : p_apca001      帳款性質
# Return code....: r_success      Y:正常 N:異常(數量<0)
# Date & Author..: 15/01/25 By apo(#141204-00017#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp135_pmdt_qty_chk(p_apcald,p_apcadocno,p_apca001)
DEFINE p_apcald         LIKE apca_t.apcald
DEFINE p_apcadocno      LIKE apca_t.apcadocno
DEFINE p_apca001        LIKE apca_t.apca001
DEFINE r_success        LIKE type_t.num5
DEFINE l_field          DYNAMIC ARRAY OF RECORD
                  f1    LIKE type_t.chr100,  #帳套請款數量
                  f2    LIKE type_t.chr100   #暫估數量
                        END RECORD
DEFINE l_ld_type        LIKE type_t.chr1                    
DEFINE l_sql            STRING
DEFINE l_errno          LIKE gzze_t.gzze001
DEFINE l_tmp            RECORD
                        apcb002   LIKE apcb_t.apcb002,
                        apcb003   LIKE apcb_t.apcb003
                        END RECORD
DEFINE l_qty            LIKE pmdt_t.pmdt024

   LET r_success = TRUE
   LET l_field[1].f1 = "pmdt056"   LET l_field[2].f1 = "pmdt057"  LET l_field[3].f1 = "pmdt058"   #已請款數量
   LET l_field[1].f2 = "pmdt066"   LET l_field[2].f2 = "pmdt067"  LET l_field[3].f2 = "pmdt068"   #暫估數量

   CALL s_fin_get_ld_type(p_apcald) RETURNING l_ld_type  #取帳別類型
   IF l_ld_type = 0 THEN RETURN r_success END IF   
   
   IF p_apca001[1,1]= '0' THEN   #暫估
      LET l_sql =  " SELECT COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f2,",0) "
   ELSE
      LET l_sql =  " SELECT COALESCE(pmdt024,0) - COALESCE(",l_field[l_ld_type].f1,",0) "
   END IF  
   LET l_sql = l_sql,"   FROM pmdt_t ",
                     "  WHERE pmdtent= ? AND pmdtdocno=? AND pmdtseq=? "
   PREPARE aapp135_pmdt_sel_p FROM l_sql
   DECLARE aapp135_pmdt_sel_c CURSOR FOR aapp135_pmdt_sel_p 
   
   #本張立帳單單身所有來源入庫單資訊
   FOREACH aapp135_sel_apcb USING g_enterprise,p_apcadocno,p_apcald INTO l_tmp.*
      EXECUTE aapp135_pmdt_sel_c USING g_enterprise,l_tmp.apcb002,l_tmp.apcb003 INTO l_qty
      IF l_qty < 0 THEN
         LET r_success = FALSE
         EXIT FOREACH
      END IF             
   END FOREACH   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 勾選時檢核
# Memo...........:
# Usage..........: CALL aapp135_click_chk(p_ld,p_docno)
#                  RETURNING r_success
# Input parameter: p_ld           帳別
#                : p_docno        單號
# Return code....: r_success 
# Date & Author..: 15/02/24 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp135_click_chk(p_ld,p_docno)
   DEFINE p_ld          LIKE apca_t.apcald   
   DEFINE p_docno       LIKE apca_t.apcadocno
   DEFINE r_success     LIKE type_t.num5
   DEFINE l_apcadocdt   LIKE apca_t.apcadocdt
   DEFINE l_apcasite    LIKE apca_t.apcasite
   DEFINE l_flag        LIKE type_t.dat

   LET r_success = TRUE
   #關帳日檢核
   SELECT apcasite INTO l_apcasite FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcadocno = p_docno
      AND apcald = p_ld
   LET l_flag = cl_get_para(g_enterprise,l_apcasite,'S-FIN-3007')

   SELECT apcadocdt INTO l_apcadocdt FROM apca_t
    WHERE apcaent = g_enterprise
      AND apcadocno = p_docno
      AND apcald = p_ld
      
   IF l_apcadocdt  < l_flag THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axr-00132'
      LET g_errparam.extend = p_docno
      LET g_errparam.popup = TRUE
      CALL cl_err()      
      LET r_success = FALSE      
   END IF
   #已改為未確認狀態才可以還原,故此段不做
   #CALL s_aapt300_unconf_chk(p_ld,p_docno) RETURNING g_sub_success
   #IF NOT g_sub_success THEN
   #   LET r_success = FALSE
   #END IF   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 清空&給預設 #150127-00007#1
# Memo...........:
# Usage..........: CALL aapp135_qbe_clear()
# Date & Author..: 2015/02/24 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION aapp135_qbe_clear()
   
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   CALL g_detail_d.clear()
   CALL g_detail2_d.clear()
   
   #20150424--add--str--lujh
   IF NOT cl_null(g_argv[2]) AND NOT cl_null(g_argv[3]) THEN 
      LET g_bgjob      = g_argv[1]    #背景执行
      LET tm.apcasite  = g_argv[2]    #账务中心
      LET tm.apcald    = g_argv[3]    #账套
      LET tm.apca_wc = " apcadocno IN '",g_argv[4],"'"  #单据编号字串
      
      SELECT ooef017 INTO tm.apcacomp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = tm.apcasite
   ELSE 
   #20150424--add--end--lujh
      #帳務組織/帳套/法人預設
      CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,tm.apcasite,tm.apcald,tm.apcacomp
   END IF   #20150424 add lujh
   CALL s_fin_get_wc_str(tm.apcacomp) RETURNING g_comp_str #161229-00047#6 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl   #161229-00047#6 add 
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',tm.apcacomp) RETURNING g_sub_success,g_sql_ctrl #161115-00042#1 add #161229-00047#6 mark
   LET tm.apcasite_desc = s_desc_get_department_desc (tm.apcasite)
   LET tm.apcald_desc = s_desc_get_ld_desc(tm.apcald)
   LET tm.apcacomp_desc = s_desc_get_department_desc(tm.apcacomp)
   IF cl_null(tm.apcacomp_desc)THEN
      LET tm.apcacomp_desc = tm.apcacomp
   ELSE
      LET tm.apcacomp_desc = tm.apcacomp,' (',tm.apcacomp_desc,') '
   END IF
   CALL s_fin_account_center_sons_query('3',tm.apcasite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apcasite
   CALL s_fin_get_wc_str(g_wc_apcasite) RETURNING g_wc_apcasite
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_apcald
   CALL s_fin_get_wc_str(g_wc_apcald) RETURNING g_wc_apcald
   
   DISPLAY BY NAME tm.apcald,tm.apcacomp,tm.apcald_desc,tm.apcacomp_desc,tm.apcasite,tm.apcasite_desc
   
END FUNCTION

#end add-point
 
{</section>}
 
