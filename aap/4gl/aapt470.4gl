#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt470.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-08-17 14:45:48), PR版次:0006(2017-01-09 14:14:26)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000010
#+ Filename...: aapt470
#+ Description: 付款資料變更申請作業
#+ Creator....: 08732(2016-08-17 14:45:48)
#+ Modifier...: 08732 -SD/PR- 06821
 
{</section>}
 
{<section id="aapt470.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160926-00013#1  2016/09/29 By 08732    付款單身受款人欄位開窗調整
#161006-00005#5  2016/10/12 By 08732    組織類型與職能開窗調整
#161114-00017#1  2016/11/15 By Reanna   開窗權限調整
#161104-00046#5  2016/12/30 By 08171    單別預設值;資料依照單別user dept權限過濾單號
#161229-00047#50 2017/01/09 By 06821    財務用供應商對象控制組,法人條件改為用 IN (site...)的方式,QBE時,傳入符合權限的法人；INPUT時傳入目前法人據點
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apdf_m        RECORD
       apdfsite LIKE apdf_t.apdfsite, 
   apdfsite_desc LIKE type_t.chr80, 
   apdf001 LIKE apdf_t.apdf001, 
   apdf001_desc LIKE type_t.chr80, 
   apdfld LIKE apdf_t.apdfld, 
   apdfld_desc LIKE type_t.chr80, 
   apdfcomp LIKE apdf_t.apdfcomp, 
   apdfdocno LIKE apdf_t.apdfdocno, 
   apdfdocno_desc LIKE type_t.chr80, 
   apdfdocdt LIKE apdf_t.apdfdocdt, 
   apdfstus LIKE apdf_t.apdfstus, 
   apdfownid LIKE apdf_t.apdfownid, 
   apdfownid_desc LIKE type_t.chr80, 
   apdfowndp LIKE apdf_t.apdfowndp, 
   apdfowndp_desc LIKE type_t.chr80, 
   apdfcrtid LIKE apdf_t.apdfcrtid, 
   apdfcrtid_desc LIKE type_t.chr80, 
   apdfcrtdp LIKE apdf_t.apdfcrtdp, 
   apdfcrtdp_desc LIKE type_t.chr80, 
   apdfcrtdt LIKE apdf_t.apdfcrtdt, 
   apdfmodid LIKE apdf_t.apdfmodid, 
   apdfmodid_desc LIKE type_t.chr80, 
   apdfmoddt LIKE apdf_t.apdfmoddt, 
   apdfcnfid LIKE apdf_t.apdfcnfid, 
   apdfcnfid_desc LIKE type_t.chr80, 
   apdfcnfdt LIKE apdf_t.apdfcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apdg_d        RECORD
       apdgseq LIKE apdg_t.apdgseq, 
   apdg001 LIKE apdg_t.apdg001, 
   apdg002 LIKE apdg_t.apdg002, 
   apdg003 LIKE apdg_t.apdg003, 
   apdg003_desc LIKE type_t.chr500, 
   apdg004 LIKE apdg_t.apdg004, 
   apdg005 LIKE apdg_t.apdg005, 
   apdg005_desc LIKE type_t.chr500, 
   apdg006 LIKE apdg_t.apdg006, 
   apdg007 LIKE apdg_t.apdg007, 
   l_apde002 LIKE type_t.chr500, 
   apdg014 LIKE apdg_t.apdg014, 
   apdg015 LIKE apdg_t.apdg015, 
   apdg015_desc LIKE type_t.chr500, 
   apdg016 LIKE apdg_t.apdg016, 
   apdg017 LIKE apdg_t.apdg017, 
   apdg010 LIKE apdg_t.apdg010
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apdfdocno LIKE apdf_t.apdfdocno,
      b_apdfld LIKE apdf_t.apdfld
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ld_wc               STRING
DEFINE g_site_wc             STRING
DEFINE g_glaa                RECORD
                             glaald    LIKE glaa_t.glaald,
                             glaacomp  LIKE glaa_t.glaacomp,
                             glaa001   LIKE glaa_t.glaa001,
                             glaa004   LIKE glaa_t.glaa004,
                             glaa005   LIKE glaa_t.glaa005,
                             glaa015   LIKE glaa_t.glaa015,
                             glaa016   LIKE glaa_t.glaa016,
                             glaa017   LIKE glaa_t.glaa017,
                             glaa019   LIKE glaa_t.glaa019,
                             glaa020   LIKE glaa_t.glaa020,
                             glaa021   LIKE glaa_t.glaa021,
                             glaa024   LIKE glaa_t.glaa024,
                             glaa025   LIKE glaa_t.glaa025,
                             glaa026   LIKE glaa_t.glaa026,
                             glaa121   LIKE glaa_t.glaa121
                             END RECORD
DEFINE g_sfin3007            LIKE apca_t.apcadocdt
DEFINE g_apda005             LIKE apda_t.apda005
#161114-00017#1 add ------
DEFINE g_sql_ctrl            STRING
DEFINE g_site_str            STRING
#161114-00017#1 add end---
#161104-00046#5 --s add
DEFINE g_ap_slip           LIKE ooba_t.ooba002           #應付帳款單單別
DEFINE g_user_dept_wc      STRING
DEFINE g_user_dept_wc_q    STRING
DEFINE g_user_slip_wc      STRING
#161104-00046#5 --e add
DEFINE g_wc_cs_comp        STRING  #161229-00047#50 add
DEFINE g_comp_str          STRING  #161229-00047#50 add 
#end add-point
       
#模組變數(Module Variables)
DEFINE g_apdf_m          type_g_apdf_m
DEFINE g_apdf_m_t        type_g_apdf_m
DEFINE g_apdf_m_o        type_g_apdf_m
DEFINE g_apdf_m_mask_o   type_g_apdf_m #轉換遮罩前資料
DEFINE g_apdf_m_mask_n   type_g_apdf_m #轉換遮罩後資料
 
   DEFINE g_apdfld_t LIKE apdf_t.apdfld
DEFINE g_apdfdocno_t LIKE apdf_t.apdfdocno
 
 
DEFINE g_apdg_d          DYNAMIC ARRAY OF type_g_apdg_d
DEFINE g_apdg_d_t        type_g_apdg_d
DEFINE g_apdg_d_o        type_g_apdg_d
DEFINE g_apdg_d_mask_o   DYNAMIC ARRAY OF type_g_apdg_d #轉換遮罩前資料
DEFINE g_apdg_d_mask_n   DYNAMIC ARRAY OF type_g_apdg_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
 
 
DEFINE g_wc2_extend          STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
 
DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10     
DEFINE g_jump                LIKE type_t.num10        
DEFINE g_no_ask              LIKE type_t.num5        
DEFINE g_rec_b               LIKE type_t.num10           
DEFINE l_ac                  LIKE type_t.num10    
DEFINE g_curr_diag           ui.Dialog                         #Current Dialog
                                                               
DEFINE g_pagestart           LIKE type_t.num10                 
DEFINE gwin_curr             ui.Window                         #Current Window
DEFINE gfrm_curr             ui.Form                           #Current Form
DEFINE g_page_action         STRING                            #page action
DEFINE g_header_hidden       LIKE type_t.num5                  #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5                  #隱藏工作Panel
DEFINE g_page                STRING                            #第幾頁
DEFINE g_state               STRING       
DEFINE g_header_cnt          LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10                  #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx_tmp      LIKE type_t.num10                  #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10                  #單身2目前所在筆數
DEFINE g_detail_idx_list     DYNAMIC ARRAY OF LIKE type_t.num10 #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10                  #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10                  #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10                  #Browser目前所在筆數(暫存用)
DEFINE g_order               STRING                             #查詢排序欄位
                                                        
DEFINE g_current_row         LIKE type_t.num10                  #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                            #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num10                  #目前所在頁數
DEFINE g_insert              LIKE type_t.chr5                   #是否導到其他page
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
DEFINE g_error_show          LIKE type_t.num5              #是否顯示筆數提示訊息
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入
 
DEFINE g_wc_frozen           STRING                        #凍結欄位使用
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_update              BOOLEAN                       #確定單頭/身是否異動過
DEFINE g_idx_group           om.SaxAttributes              #頁籤群組
DEFINE g_master_commit       LIKE type_t.chr1              #確認單頭是否修改過
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt470.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("aap","")
 
   #add-point:作業初始化 name="main.init"
   #161114-00017#1 add ------
   LET g_sql_ctrl = NULL
   SELECT ooef017 INTO g_apdf_m.apdfcomp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdf_m.apdfcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 mark
   #161114-00017#1 add end---
   #161104-00046#5 --s add
   #建立與單頭array相同的temptable
   CALL s_aooi200def_create('','g_apdf_m','','','','','','')RETURNING g_sub_success
   
   #單別控制組
   LET g_user_dept_wc = ''
   CALL s_fin_get_user_dept_control('','apdfld','apdfent','apdfdocno') RETURNING g_user_dept_wc
   #開窗使用
   LET g_user_dept_wc_q = g_user_dept_wc
   
   CALL s_control_get_docno_sql(g_user,g_dept) RETURNING g_sub_success,g_user_slip_wc  
   #161104-00046#5 --e add
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apdfsite,'',apdf001,'',apdfld,'',apdfcomp,apdfdocno,'',apdfdocdt,apdfstus, 
       apdfownid,'',apdfowndp,'',apdfcrtid,'',apdfcrtdp,'',apdfcrtdt,apdfmodid,'',apdfmoddt,apdfcnfid, 
       '',apdfcnfdt", 
                      " FROM apdf_t",
                      " WHERE apdfent= ? AND apdfdocno=? AND apdfld=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt470_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apdfsite,t0.apdf001,t0.apdfld,t0.apdfcomp,t0.apdfdocno,t0.apdfdocdt, 
       t0.apdfstus,t0.apdfownid,t0.apdfowndp,t0.apdfcrtid,t0.apdfcrtdp,t0.apdfcrtdt,t0.apdfmodid,t0.apdfmoddt, 
       t0.apdfcnfid,t0.apdfcnfdt,t1.ooefl003 ,t2.ooag011 ,t3.glaal002 ,t4.oobal004 ,t5.ooag011 ,t6.ooefl003 , 
       t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooag011",
               " FROM apdf_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.apdfsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.apdf001  ",
               " LEFT JOIN glaal_t t3 ON t3.glaalent="||g_enterprise||" AND t3.glaalld=t0.apdfld AND t3.glaal001='"||g_dlang||"' ",
               " LEFT JOIN oobal_t t4 ON t4.oobalent="||g_enterprise||" AND t4.oobal002=t0.apdfdocno AND t4.oobal003='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apdfownid  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.apdfowndp AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.apdfcrtid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.apdfcrtdp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.apdfmodid  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.apdfcnfid  ",
 
               " WHERE t0.apdfent = " ||g_enterprise|| " AND t0.apdfdocno = ? AND t0.apdfld = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt470_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt470 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt470_init()   
 
      #進入選單 Menu (="N")
      CALL aapt470_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt470
      
   END IF 
   
   CLOSE aapt470_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt470.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt470_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str    STRING
   #end add-point   
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill       = "Y"
   LET g_detail_idx  = 1 #第一層單身指標
   LET g_detail_idx2 = 1 #第二層單身指標
   
   #各個page指標
   LET g_detail_idx_list[1] = 1 
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apdfstus','13','N,Y,X')
 
   
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '2' AND gzcb002 <> '17' ") CLIPPED   
   CALL cl_set_combo_scc_part('l_apde002','8506',l_str)

   #展組織下階成員所需之暫存檔
   CALL s_fin_create_account_center_tmp()
   #161229-00047#50 --s add
   CALL s_fin_azzi800_sons_query(g_today)    
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp   
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp      
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl
   #161229-00047#50 --e add    
   #end add-point
   
   #初始化搜尋條件
   CALL aapt470_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt470.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt470_ui_dialog()
   #add-point:ui_dialog段define(客製用) name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_idx     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE lb_first   BOOLEAN
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING
   DEFINE la_output  DYNAMIC ARRAY OF STRING   #報表元件鬆耦合使用
   DEFINE  l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE  l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE  l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE  l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_wc       STRING
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aapt470_insert()
            #add-point:ON ACTION insert name="menu.default.insert"
            
            #END add-point
         END IF
 
      #add-point:action default自訂 name="ui_dialog.action_default"
      
      #end add-point
      OTHERWISE
   END CASE
 
 
 
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_apdf_m.* TO NULL
         CALL g_apdg_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt470_init()
      END IF
   
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
    
         DISPLAY ARRAY g_apdg_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt470_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
               #顯示單身筆數
               CALL aapt470_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt470_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            
            #確保g_current_idx位於正常區間內
            #小於,等於0則指到第1筆
            IF g_current_idx <= 0 THEN
               LET g_current_idx = 1
            END IF
            #超過最大筆數則指到最後1筆
            IF g_current_idx > g_browser.getLength() THEN
               LEt g_current_idx = g_browser.getLength()
            END IF 
            
            LET g_current_sw = TRUE
            LET g_current_row = g_current_idx #目前指標
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL aapt470_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt470_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt470_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt470_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt470_set_act_visible()   
            CALL aapt470_set_act_no_visible()
            IF NOT (g_apdf_m.apdfdocno IS NULL
              OR g_apdf_m.apdfld IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apdfent = " ||g_enterprise|| " AND",
                                  " apdfdocno = '", g_apdf_m.apdfdocno, "' "
                                  ," AND apdfld = '", g_apdf_m.apdfld, "' "
 
               #填到對應位置
               CALL aapt470_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apdg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt470_browser_fill("F")   #browser_fill()會將notice區塊清空
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apdf_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apdg_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt470_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt470_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
          
         
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt470_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt470_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt470_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt470_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt470_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt470_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt470_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt470_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt470_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt470_idx_chk()
          
         #excel匯出功能          
         ON ACTION exporttoexcel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
               #非browser
               ELSE
                  LET g_export_node[1] = base.typeInfo.create(g_apdg_d)
                  LET g_export_id[1]   = "s_detail1"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
        
         ON ACTION close
            LET INT_FLAG = FALSE
            LET g_action_choice = "exit"
            EXIT DIALOG
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
    
         #主頁摺疊
         ON ACTION mainhidden       
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
               CALL cl_notice()
            END IF
            
       
         #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
         ON ACTION controls     
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
    
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt470_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt470_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt470_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt470_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_rep_wc ="     apdfent = '",g_enterprise,"'",
                             " AND apdfdocno = '",g_apdf_m.apdfdocno,"' ",
                             " AND apdfld = '",g_apdf_m.apdfld,"' "            
               #END add-point
               &include "erp/aap/aapt470_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_rep_wc ="     apdfent = '",g_enterprise,"'",
                             " AND apdfdocno = '",g_apdf_m.apdfdocno,"' ",
                             " AND apdfld = '",g_apdf_m.apdfld,"' "            
               #END add-point
               &include "erp/aap/aapt470_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt470_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt470_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt470_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt470_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt470_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apdf_m.apdfdocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
 
      #(ver:79) ---add start---
      #add-point:ui_dialog段 after dialog name="ui_dialog.exit_dialog"
      
      #end add-point
      #(ver:79) --- add end ---
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aapt470.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt470_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   
   #end add-point
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
 
   #add-point:browser_fill,foreach前 name="browser_fill.before_foreach"
   
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT apdfdocno,apdfld ",
                      " FROM apdf_t ",
                      " ",
                      " LEFT JOIN apdg_t ON apdgent = apdfent AND apdfdocno = apdgdocno AND apdfld = apdgld ", "  ",
                      #add-point:browser_fill段sql(apdg_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE apdfent = " ||g_enterprise|| " AND apdgent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apdf_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apdfdocno,apdfld ",
                      " FROM apdf_t ", 
                      "  ",
                      "  ",
                      " WHERE apdfent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apdf_t")
   END IF
   
   #add-point:browser_fill,cnt wc name="browser_fill.cnt_sqlwc"
   
   #end add-point
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
    
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
      END IF
      LET g_browser_cnt = g_max_browse
   END IF
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #根據行為確定資料填充位置及WC
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_apdf_m.* TO NULL
      CALL g_apdg_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apdfdocno,t0.apdfld Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdfstus,t0.apdfdocno,t0.apdfld ",
                  " FROM apdf_t t0",
                  "  ",
                  "  LEFT JOIN apdg_t ON apdgent = apdfent AND apdfdocno = apdgdocno AND apdfld = apdgld ", "  ", 
                  #add-point:browser_fill段sql(apdg_t1) name="browser_fill.join.apdg_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                  
                  " WHERE t0.apdfent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apdf_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apdfstus,t0.apdfdocno,t0.apdfld ",
                  " FROM apdf_t t0",
                  "  ",
                  
                  " WHERE t0.apdfent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apdf_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
 
   #end add-point
   LET g_sql = g_sql, " ORDER BY apdfdocno,apdfld ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
 
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apdf_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apdfdocno,g_browser[g_cnt].b_apdfld 
 
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
         WHEN "X"
            LET g_browser[g_cnt].b_statepic = "stus/16/invalid.png"
         
      END CASE
 
 
 
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_browse THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      FREE browse_pre
   END IF
   
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_apdfdocno) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   
   #筆數顯示
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
      DISPLAY g_detail_idx  TO FORMONLY.idx     #單身當下筆數
      DISPLAY g_detail_cnt  TO FORMONLY.cnt     #單身總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
      DISPLAY '' TO FORMONLY.idx     #單身當下筆數
      DISPLAY '' TO FORMONLY.cnt     #單身總筆數
   END IF
 
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
 
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
                  
   
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt470_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apdf_m.apdfdocno = g_browser[g_current_idx].b_apdfdocno   
   LET g_apdf_m.apdfld = g_browser[g_current_idx].b_apdfld   
 
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
   CALL aapt470_apdf_t_mask()
   CALL aapt470_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt470.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt470_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt470_ui_browser_refresh()
   #add-point:ui_browser_refresh段define(客製用) name="ui_browser_refresh.define_customerization"
   
   #end add-point    
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_apdfdocno = g_apdf_m.apdfdocno 
         AND g_browser[l_i].b_apdfld = g_apdf_m.apdfld 
 
         THEN
         CALL g_browser.deleteElement(l_i)
         EXIT FOR
      END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:ui_browser_refresh段after name="ui_browser_refresh.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt470_construct()
   #add-point:cs段define(客製用) name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   DEFINE la_wc       DYNAMIC ARRAY OF RECORD
          tableid     STRING,
          wc          STRING
          END RECORD
   DEFINE li_idx      LIKE type_t.num10
   #add-point:cs段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   DEFINE l_ld_str    STRING  #161114-00017#1
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apdf_m.* TO NULL
   CALL g_apdg_d.clear()        
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apdfsite,apdf001,apdfld,apdfcomp,apdfdocno,apdfdocdt,apdfstus,apdfownid, 
          apdfowndp,apdfcrtid,apdfcrtdp,apdfcrtdt,apdfmodid,apdfmoddt,apdfcnfid,apdfcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apdfcrtdt>>----
         AFTER FIELD apdfcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apdfmoddt>>----
         AFTER FIELD apdfmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdfcnfdt>>----
         AFTER FIELD apdfcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apdfpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfsite
            #add-point:ON ACTION controlp INFIELD apdfsite name="construct.c.apdfsite"
            #帳務中心
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()     #161006-00005#5 mark
            CALL q_ooef001_46()   #161006-00005#5
            DISPLAY g_qryparam.return1 TO apdfsite
            NEXT FIELD apdfsite
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfsite
            #add-point:BEFORE FIELD apdfsite name="construct.b.apdfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfsite
            
            #add-point:AFTER FIELD apdfsite name="construct.a.apdfsite"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdf001
            #add-point:ON ACTION controlp INFIELD apdf001 name="construct.c.apdf001"
            #帳務人員
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apdf001
            LET g_apdf_m.apdf001_desc = s_desc_get_person_desc(g_apdf_m.apdf001)
            DISPLAY BY NAME g_apdf_m.apdf001_desc
            NEXT FIELD apdf001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdf001
            #add-point:BEFORE FIELD apdf001 name="construct.b.apdf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdf001
            
            #add-point:AFTER FIELD apdf001 name="construct.a.apdf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfld
            #add-point:ON ACTION controlp INFIELD apdfld name="construct.c.apdfld"
            #帳套
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_grup
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO apdfld
            LET g_apdf_m.apdfld_desc = s_desc_get_ld_desc(g_apdf_m.apdfld)
            DISPLAY BY NAME g_apdf_m.apdfld_desc
            NEXT FIELD apdfld
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfld
            #add-point:BEFORE FIELD apdfld name="construct.b.apdfld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfld
            
            #add-point:AFTER FIELD apdfld name="construct.a.apdfld"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcomp
            #add-point:BEFORE FIELD apdfcomp name="construct.b.apdfcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfcomp
            
            #add-point:AFTER FIELD apdfcomp name="construct.a.apdfcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfcomp
            #add-point:ON ACTION controlp INFIELD apdfcomp name="construct.c.apdfcomp"
            #此欄位隱藏
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfdocno
            #add-point:BEFORE FIELD apdfdocno name="construct.b.apdfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfdocno
            
            #add-point:AFTER FIELD apdfdocno name="construct.a.apdfdocno"
           
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfdocno
            #add-point:ON ACTION controlp INFIELD apdfdocno name="construct.c.apdfdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apdf_m.apdfdocno
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            #161114-00017#1 add ------
            #查詢依帳套權限管理
            CALL s_axrt300_get_site(g_user,g_site_str,'2') RETURNING l_ld_str
            LET l_ld_str = cl_replace_str(l_ld_str,"glaald","apdfld")
            LET g_qryparam.where = l_ld_str
            #161114-00017#1 add end---
            #161104-00046#5 --s add
            #單別權限控管
            IF NOT cl_null(g_user_dept_wc_q) AND NOT g_user_dept_wc_q = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_user_dept_wc_q CLIPPED
            END IF
            #161104-00046#5 --e add
            #CALL q_ooba002_1() #161114-00017#1 mark
            CALL q_apdfdocno()  #161114-00017#1
            DISPLAY g_qryparam.return1 TO apdfdocno
            NEXT FIELD apdfdocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfdocdt
            #add-point:BEFORE FIELD apdfdocdt name="construct.b.apdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfdocdt
            
            #add-point:AFTER FIELD apdfdocdt name="construct.a.apdfdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfdocdt
            #add-point:ON ACTION controlp INFIELD apdfdocdt name="construct.c.apdfdocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfstus
            #add-point:BEFORE FIELD apdfstus name="construct.b.apdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfstus
            
            #add-point:AFTER FIELD apdfstus name="construct.a.apdfstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfstus
            #add-point:ON ACTION controlp INFIELD apdfstus name="construct.c.apdfstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdfownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfownid
            #add-point:ON ACTION controlp INFIELD apdfownid name="construct.c.apdfownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfownid  #顯示到畫面上
            NEXT FIELD apdfownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfownid
            #add-point:BEFORE FIELD apdfownid name="construct.b.apdfownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfownid
            
            #add-point:AFTER FIELD apdfownid name="construct.a.apdfownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfowndp
            #add-point:ON ACTION controlp INFIELD apdfowndp name="construct.c.apdfowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfowndp  #顯示到畫面上
            NEXT FIELD apdfowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfowndp
            #add-point:BEFORE FIELD apdfowndp name="construct.b.apdfowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfowndp
            
            #add-point:AFTER FIELD apdfowndp name="construct.a.apdfowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfcrtid
            #add-point:ON ACTION controlp INFIELD apdfcrtid name="construct.c.apdfcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfcrtid  #顯示到畫面上
            NEXT FIELD apdfcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcrtid
            #add-point:BEFORE FIELD apdfcrtid name="construct.b.apdfcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfcrtid
            
            #add-point:AFTER FIELD apdfcrtid name="construct.a.apdfcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apdfcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfcrtdp
            #add-point:ON ACTION controlp INFIELD apdfcrtdp name="construct.c.apdfcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfcrtdp  #顯示到畫面上
            NEXT FIELD apdfcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcrtdp
            #add-point:BEFORE FIELD apdfcrtdp name="construct.b.apdfcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfcrtdp
            
            #add-point:AFTER FIELD apdfcrtdp name="construct.a.apdfcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcrtdt
            #add-point:BEFORE FIELD apdfcrtdt name="construct.b.apdfcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdfmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfmodid
            #add-point:ON ACTION controlp INFIELD apdfmodid name="construct.c.apdfmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfmodid  #顯示到畫面上
            NEXT FIELD apdfmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfmodid
            #add-point:BEFORE FIELD apdfmodid name="construct.b.apdfmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfmodid
            
            #add-point:AFTER FIELD apdfmodid name="construct.a.apdfmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfmoddt
            #add-point:BEFORE FIELD apdfmoddt name="construct.b.apdfmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apdfcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfcnfid
            #add-point:ON ACTION controlp INFIELD apdfcnfid name="construct.c.apdfcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdfcnfid  #顯示到畫面上
            NEXT FIELD apdfcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcnfid
            #add-point:BEFORE FIELD apdfcnfid name="construct.b.apdfcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfcnfid
            
            #add-point:AFTER FIELD apdfcnfid name="construct.a.apdfcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcnfdt
            #add-point:BEFORE FIELD apdfcnfdt name="construct.b.apdfcnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apdgseq,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006,apdg007,apdg014, 
          apdg015,apdg016,apdg017,apdg010
           FROM s_detail1[1].apdgseq,s_detail1[1].apdg001,s_detail1[1].apdg002,s_detail1[1].apdg003, 
               s_detail1[1].apdg004,s_detail1[1].apdg005,s_detail1[1].apdg006,s_detail1[1].apdg007,s_detail1[1].apdg014, 
               s_detail1[1].apdg015,s_detail1[1].apdg016,s_detail1[1].apdg017,s_detail1[1].apdg010
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdgseq
            #add-point:BEFORE FIELD apdgseq name="construct.b.page1.apdgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdgseq
            
            #add-point:AFTER FIELD apdgseq name="construct.a.page1.apdgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdgseq
            #add-point:ON ACTION controlp INFIELD apdgseq name="construct.c.page1.apdgseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg001
            #add-point:BEFORE FIELD apdg001 name="construct.b.page1.apdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg001
            
            #add-point:AFTER FIELD apdg001 name="construct.a.page1.apdg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg001
            #add-point:ON ACTION controlp INFIELD apdg001 name="construct.c.page1.apdg001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " apda001 = '45' "
            CALL q_apda001()
            DISPLAY g_qryparam.return1 TO apdg001
            NEXT FIELD apdg001
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg002
            #add-point:BEFORE FIELD apdg002 name="construct.b.page1.apdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg002
            
            #add-point:AFTER FIELD apdg002 name="construct.a.page1.apdg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg002
            #add-point:ON ACTION controlp INFIELD apdg002 name="construct.c.page1.apdg002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg003
            #add-point:BEFORE FIELD apdg003 name="construct.b.page1.apdg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg003
            
            #add-point:AFTER FIELD apdg003 name="construct.a.page1.apdg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg003
            #add-point:ON ACTION controlp INFIELD apdg003 name="construct.c.page1.apdg003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #161114-00017#1 add ------
            IF NOT cl_null(g_sql_ctrl) AND NOT g_sql_ctrl = ' 1=1'  THEN
               LET g_qryparam.where = " EXISTS (SELECT 1 FROM pmaa_t ",
                                      "          WHERE pmaaent = ",g_enterprise,
                                      "            AND ",g_sql_ctrl,
                                      "            AND pmaaent = apcaent ",
                                      "            AND pmaa001 = apca005 )"
            END IF
            #161114-00017#1 add end---
            CALL q_apca005()
            DISPLAY g_qryparam.return1 TO apdg003
            NEXT FIELD apdg003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg004
            #add-point:BEFORE FIELD apdg004 name="construct.b.page1.apdg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg004
            
            #add-point:AFTER FIELD apdg004 name="construct.a.page1.apdg004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg004
            #add-point:ON ACTION controlp INFIELD apdg004 name="construct.c.page1.apdg004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdg004  #顯示到畫面上
            NEXT FIELD apdg004 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg005
            #add-point:BEFORE FIELD apdg005 name="construct.b.page1.apdg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg005
            
            #add-point:AFTER FIELD apdg005 name="construct.a.page1.apdg005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg005
            #add-point:ON ACTION controlp INFIELD apdg005 name="construct.c.page1.apdg005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdg005  #顯示到畫面上
            NEXT FIELD apdg005 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg006
            #add-point:BEFORE FIELD apdg006 name="construct.b.page1.apdg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg006
            
            #add-point:AFTER FIELD apdg006 name="construct.a.page1.apdg006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg006
            #add-point:ON ACTION controlp INFIELD apdg006 name="construct.c.page1.apdg006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdg003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdg006  #顯示到畫面上
            NEXT FIELD apdg006 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg007
            #add-point:BEFORE FIELD apdg007 name="construct.b.page1.apdg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg007
            
            #add-point:AFTER FIELD apdg007 name="construct.a.page1.apdg007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg007
            #add-point:ON ACTION controlp INFIELD apdg007 name="construct.c.page1.apdg007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg014
            #add-point:BEFORE FIELD apdg014 name="construct.b.page1.apdg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg014
            
            #add-point:AFTER FIELD apdg014 name="construct.a.page1.apdg014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg014
            #add-point:ON ACTION controlp INFIELD apdg014 name="construct.c.page1.apdg014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #CALL q_ooag001_10()   #160926-00013#1 mark
            CALL q_apde041()       #160926-00013#1                  
            DISPLAY g_qryparam.return1 TO apdg014  #顯示到畫面上
            NEXT FIELD apdg014
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg015
            #add-point:BEFORE FIELD apdg015 name="construct.b.page1.apdg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg015
            
            #add-point:AFTER FIELD apdg015 name="construct.a.page1.apdg015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg015
            #add-point:ON ACTION controlp INFIELD apdg015 name="construct.c.page1.apdg015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdg015  #顯示到畫面上
            NEXT FIELD apdg015 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg016
            #add-point:BEFORE FIELD apdg016 name="construct.b.page1.apdg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg016
            
            #add-point:AFTER FIELD apdg016 name="construct.a.page1.apdg016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg016
            #add-point:ON ACTION controlp INFIELD apdg016 name="construct.c.page1.apdg016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apdg004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apdg016  #顯示到畫面上
            NEXT FIELD apdg016 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg017
            #add-point:BEFORE FIELD apdg017 name="construct.b.page1.apdg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg017
            
            #add-point:AFTER FIELD apdg017 name="construct.a.page1.apdg017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg017
            #add-point:ON ACTION controlp INFIELD apdg017 name="construct.c.page1.apdg017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg010
            #add-point:BEFORE FIELD apdg010 name="construct.b.page1.apdg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg010
            
            #add-point:AFTER FIELD apdg010 name="construct.a.page1.apdg010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg010
            #add-point:ON ACTION controlp INFIELD apdg010 name="construct.c.page1.apdg010"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_wc_cs_comp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#50 add
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apdf_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apdg_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
 
               END CASE
            END FOR
         END IF
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   END DIALOG
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   #161104-00046#5 --s add
   IF cl_null(g_user_dept_wc)THEN
      LET g_user_dept_wc = ' 1=1'
   END IF
   IF g_user_dept_wc <>  " 1=1" THEN
      LET g_wc = g_wc ," AND ", g_user_dept_wc CLIPPED
   END IF   
   #161104-00046#5 --e add
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt470_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apdg_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt470_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt470_browser_fill("")
      CALL aapt470_fetch("")
      RETURN
   END IF
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
   
   #搜尋後資料初始化 
   LET g_detail_cnt  = 0
   LET g_current_idx = 1
   LET g_current_row = 0
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_detail_idx_list[1] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
   CALL aapt470_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt470_fetch("F") 
      #顯示單身筆數
      CALL aapt470_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt470_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
 
   
   CALL cl_ap_performance_next_start()
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L'  
         LET g_current_idx = g_browser.getLength()              
      WHEN 'P'
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN 'N'
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN '/'
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE  
            END IF           
         END IF
         
         IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
             LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE  
   END CASE 
 
   
   LET g_current_row = g_current_idx
   LET g_detail_cnt = g_header_cnt                  
   
   #單身總筆數顯示
   IF g_detail_cnt > 0 THEN
      #若單身有資料時, idx至少為1
      IF g_detail_idx <= 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY '' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_pagestart = g_current_idx
   DISPLAY g_pagestart TO FORMONLY.b_index   #當下筆數
   DISPLAY g_pagestart TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_pagestart, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apdf_m.apdfdocno = g_browser[g_current_idx].b_apdfdocno
   LET g_apdf_m.apdfld = g_browser[g_current_idx].b_apdfld
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
   #遮罩相關處理
   LET g_apdf_m_mask_o.* =  g_apdf_m.*
   CALL aapt470_apdf_t_mask()
   LET g_apdf_m_mask_n.* =  g_apdf_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt470_set_act_visible()   
   CALL aapt470_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apdf_m_t.* = g_apdf_m.*
   LET g_apdf_m_o.* = g_apdf_m.*
   
   LET g_data_owner = g_apdf_m.apdfownid      
   LET g_data_dept  = g_apdf_m.apdfowndp
   
   #重新顯示   
   CALL aapt470_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt470_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apdg_d.clear()   
 
 
   INITIALIZE g_apdf_m.* TO NULL             #DEFAULT 設定
   
   LET g_apdfdocno_t = NULL
   LET g_apdfld_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apdf_m.apdfownid = g_user
      LET g_apdf_m.apdfowndp = g_dept
      LET g_apdf_m.apdfcrtid = g_user
      LET g_apdf_m.apdfcrtdp = g_dept 
      LET g_apdf_m.apdfcrtdt = cl_get_current()
      LET g_apdf_m.apdfmodid = g_user
      LET g_apdf_m.apdfmoddt = cl_get_current()
      LET g_apdf_m.apdfstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
      
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apdf_m.apdfdocdt = g_today
      LET g_apdf_m.apdf001   = g_user 
      
      #取得預設帳務中心、帳套、公司別
      CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_apdf_m.apdfsite,g_apdf_m.apdfld,g_apdf_m.apdfcomp
      
      #161114-00017#1 add ------
      #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdf_m.apdfcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 mark
      #161114-00017#1 add end---
      CALL s_fin_get_wc_str(g_apdf_m.apdfcomp) RETURNING g_comp_str  #161229-00047#50 add 
      CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 add 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apdf_m_t.* = g_apdf_m.*
      LET g_apdf_m_o.* = g_apdf_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apdf_m.apdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aapt470_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_apdf_m.* TO NULL
         INITIALIZE g_apdg_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt470_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apdg_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt470_set_act_visible()   
   CALL aapt470_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdfdocno_t = g_apdf_m.apdfdocno
   LET g_apdfld_t = g_apdf_m.apdfld
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdfent = " ||g_enterprise|| " AND",
                      " apdfdocno = '", g_apdf_m.apdfdocno, "' "
                      ," AND apdfld = '", g_apdf_m.apdfld, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt470_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt470_cl
   
   CALL aapt470_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_apdf_m_mask_o.* =  g_apdf_m.*
   CALL aapt470_apdf_t_mask()
   LET g_apdf_m_mask_n.* =  g_apdf_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001,g_apdf_m.apdf001_desc,g_apdf_m.apdfld, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfdocdt, 
       g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfcrtdt, 
       g_apdf_m.apdfmodid,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfid_desc, 
       g_apdf_m.apdfcnfdt
   
   #add-point:新增結束後 name="insert.after"
   CALL s_aooi200_fin_get_slip_desc(g_apdf_m.apdfdocno) RETURNING g_apdf_m.apdfdocno_desc
   DISPLAY BY NAME g_apdf_m.apdfdocno_desc
   #end add-point 
   
   LET g_data_owner = g_apdf_m.apdfownid      
   LET g_data_dept  = g_apdf_m.apdfowndp
   
   #功能已完成,通報訊息中心
   CALL aapt470_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt470_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apdf_m_t.* = g_apdf_m.*
   LET g_apdf_m_o.* = g_apdf_m.*
   
   IF g_apdf_m.apdfdocno IS NULL
   OR g_apdf_m.apdfld IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apdfdocno_t = g_apdf_m.apdfdocno
   LET g_apdfld_t = g_apdf_m.apdfld
 
   CALL s_transaction_begin()
   
   OPEN aapt470_cl USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt470_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aapt470_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apdf_m_mask_o.* =  g_apdf_m.*
   CALL aapt470_apdf_t_mask()
   LET g_apdf_m_mask_n.* =  g_apdf_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL aapt470_show()
   #add-point:modify段show之後 name="modify.after_show"
   IF g_apdf_m.apdfstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apdf_m.apdfstus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_apdfdocno_t = g_apdf_m.apdfdocno
      LET g_apdfld_t = g_apdf_m.apdfld
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apdf_m.apdfmodid = g_user 
LET g_apdf_m.apdfmoddt = cl_get_current()
LET g_apdf_m.apdfmodid_desc = cl_get_username(g_apdf_m.apdfmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt470_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apdf_t SET (apdfmodid,apdfmoddt) = (g_apdf_m.apdfmodid,g_apdf_m.apdfmoddt)
          WHERE apdfent = g_enterprise AND apdfdocno = g_apdfdocno_t
            AND apdfld = g_apdfld_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apdf_m.* = g_apdf_m_t.*
            CALL aapt470_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apdf_m.apdfdocno != g_apdf_m_t.apdfdocno
      OR g_apdf_m.apdfld != g_apdf_m_t.apdfld
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apdg_t SET apdgdocno = g_apdf_m.apdfdocno
                                       ,apdgld = g_apdf_m.apdfld
 
          WHERE apdgent = g_enterprise AND apdgdocno = g_apdf_m_t.apdfdocno
            AND apdgld = g_apdf_m_t.apdfld
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apdg_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
 
         
 
         
         #UPDATE 多語言table key值
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt470_set_act_visible()   
   CALL aapt470_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apdfent = " ||g_enterprise|| " AND",
                      " apdfdocno = '", g_apdf_m.apdfdocno, "' "
                      ," AND apdfld = '", g_apdf_m.apdfld, "' "
 
   #填到對應位置
   CALL aapt470_browser_fill("")
 
   CLOSE aapt470_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt470_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt470.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt470_input(p_cmd)
   #add-point:input段define(客製用) name="input.define_customerization"
   
   #end add-point  
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_n                   LIKE type_t.num10                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
   DEFINE  l_ac_t                LIKE type_t.num10
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num10
   DEFINE  li_reproduce_target   LIKE type_t.num10
   DEFINE  ls_keys               DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:input段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE l_flag                 LIKE type_t.num5      #161104-00046#5
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001,g_apdf_m.apdf001_desc,g_apdf_m.apdfld, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfdocdt, 
       g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfcrtdt, 
       g_apdf_m.apdfmodid,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfid_desc, 
       g_apdf_m.apdfcnfdt
   
   #切換畫面
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apdgseq,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006,apdg007,apdg014, 
       apdg015,apdg016,apdg017,apdg010 FROM apdg_t WHERE apdgent=? AND apdgdocno=? AND apdgld=? AND  
       apdgseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt470_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt470_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt470_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdf001,g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno, 
       g_apdf_m.apdfdocdt,g_apdf_m.apdfstus
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   IF NOT cl_null(g_apdf_m.apdfsite) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_apdf_m.apdfsite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_apdf_m.apdfsite_desc = '', g_rtn_fields[1] , ''
      CALL aapt470_get_ld_wc(g_apdf_m.apdfsite) RETURNING g_ld_wc,g_site_wc
   END IF
    
   IF NOT cl_null(g_apdf_m.apdf001) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_apdf_m.apdf001
      CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
      LET g_apdf_m.apdf001_desc = '', g_rtn_fields[1] , ''
   END IF
    
   IF NOT cl_null(g_apdf_m.apdfld) THEN
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_apdf_m.apdfld
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_apdf_m.apdfld_desc = '', g_rtn_fields[1] , ''
      CALL s_ld_sel_glaa(g_apdf_m.apdfld,'glaald|glaacomp|glaa001|glaa004|glaa005|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024|glaa025|glaa026|glaa121')
         RETURNING g_sub_success,g_glaa.*  
   END IF
   DISPLAY BY NAME g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc,g_apdf_m.apdfld_desc
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt470.input.head" >}
      #單頭段
      INPUT BY NAME g_apdf_m.apdfsite,g_apdf_m.apdf001,g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno, 
          g_apdf_m.apdfdocdt,g_apdf_m.apdfstus 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt470_cl USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt470_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt470_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt470_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            
            #end add-point
            CALL aapt470_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfsite
            
            #add-point:AFTER FIELD apdfsite name="input.a.apdfsite"
            LET g_apdf_m.apdfsite_desc = ''
            IF NOT cl_null(g_apdf_m.apdfsite) THEN 
               IF g_apdf_m.apdfsite != g_apdf_m_o.apdfsite OR cl_null(g_apdf_m_o.apdfsite) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apdf_m.apdfsite
                  LET g_errshow = TRUE #是否彈窗
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_apdf_m.apdfsite = g_apdf_m_o.apdfsite
                     LET g_apdf_m.apdfsite_desc = g_apdf_m_o.apdfsite_desc
                     DISPLAY BY NAME g_apdf_m.apdfsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  CALL s_fin_account_center_with_ld_chk(g_apdf_m.apdfsite,g_apdf_m.apdfld,g_user,'3','Y','',g_today) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apdf_m.apdfsite = g_apdf_m_o.apdfsite
                     LET g_apdf_m.apdfsite_desc = g_apdf_m_o.apdfsite_desc
                     DISPLAY BY NAME g_apdf_m.apdfsite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  #取得所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_apdf_m.apdfsite) RETURNING g_sub_success,g_errno,g_apdf_m.apdfcomp,g_apdf_m.apdfld
                  DISPLAY BY NAME g_apdf_m.apdfcomp,g_apdf_m.apdfld
                  #161114-00017#1 add ------
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdf_m.apdfcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 mark
                  #161114-00017#1 add end---
                  CALL s_fin_get_wc_str(g_apdf_m.apdfcomp) RETURNING g_comp_str  #161229-00047#50 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 add 
               END IF
               CALL aapt470_get_ld_wc(g_apdf_m.apdfsite) RETURNING g_ld_wc,g_site_wc
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_apdf_m.apdfsite
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET g_apdf_m.apdfsite_desc = '', g_rtn_fields[1] , ''
            END IF 
            DISPLAY BY NAME g_apdf_m.apdfsite_desc
            LET g_apdf_m_o.* = g_apdf_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfsite
            #add-point:BEFORE FIELD apdfsite name="input.b.apdfsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfsite
            #add-point:ON CHANGE apdfsite name="input.g.apdfsite"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdf001
            
            #add-point:AFTER FIELD apdf001 name="input.a.apdf001"
            LET g_apdf_m.apdf001_desc = ''
            IF NOT cl_null(g_apdf_m.apdf001) THEN
               IF g_apdf_m.apdf001 != g_apdf_m_o.apdf001 OR cl_null(g_apdf_m_o.apdf001) THEN
                  CALL s_voucher_glaq013_chk(g_apdf_m.apdf001)
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apdf_m.apdf001 = g_apdf_m_o.apdf001
                     LET g_apdf_m.apdf001_desc = g_apdf_m_o.apdf001_desc
                     DISPLAY BY NAME g_apdf_m.apdf001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_apdf_m.apdf001
               CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
               LET g_apdf_m.apdf001_desc = '', g_rtn_fields[1] , ''
            END IF
            DISPLAY BY NAME g_apdf_m.apdf001_desc
            LET g_apdf_m_o.* = g_apdf_m.*
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdf001
            #add-point:BEFORE FIELD apdf001 name="input.b.apdf001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdf001
            #add-point:ON CHANGE apdf001 name="input.g.apdf001"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfld
            
            #add-point:AFTER FIELD apdfld name="input.a.apdfld"
            LET g_apdf_m.apdfld_desc = ''
            IF NOT cl_null(g_apdf_m.apdfld) THEN
               IF g_apdf_m.apdfld != g_apdf_m_o.apdfld OR cl_null(g_apdf_m_o.apdfld) THEN
                  CALL s_fin_account_center_with_ld_chk(g_apdf_m.apdfsite,g_apdf_m.apdfld,g_user,'3','N','',g_apdf_m.apdfdocdt) 
                       RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apdf_m.apdfld = g_apdf_m_o.apdfld
                     LET g_apdf_m.apdfld_desc = g_apdf_m_o.apdfld_desc 
                     DISPLAY BY NAME g_apdf_m.apdfld_desc
                     NEXT FIELD CURRENT
                  END IF

                  #檢查輸入帳套是否存在帳務中心下帳套範圍內
                  IF s_chr_get_index_of(g_ld_wc,g_apdf_m.apdfld,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00033'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apdf_m.apdfld = g_apdf_m_o.apdfld
                     LET g_apdf_m.apdfld_desc = g_apdf_m_o.apdfld_desc 
                     DISPLAY BY NAME g_apdf_m.apdfld_desc
                     NEXT FIELD CURRENT
                  END IF

                  #抓所屬法人
                  SELECT glaacomp
                    INTO g_apdf_m.apdfcomp
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_apdf_m.apdfld
                     AND glaa014 = 'Y'  #161114-00017#1
                  DISPLAY BY NAME g_apdf_m.apdfcomp
                  #161114-00017#1 add ------
                  #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdf_m.apdfcomp) RETURNING g_sub_success,g_sql_ctrl  #161229-00047#50 mark
                  #161114-00017#1 add end---
                  CALL s_fin_get_wc_str(g_apdf_m.apdfcomp) RETURNING g_comp_str  #161229-00047#50 add 
                  CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl   #161229-00047#50 add 
               END IF
               
               CALL s_ld_sel_glaa(g_apdf_m.apdfld,'glaald|glaacomp|glaa001|glaa004|glaa005|glaa015|glaa016|glaa017|glaa019|glaa020|glaa021|glaa024|glaa025|glaa026|glaa121')
                    RETURNING g_sub_success,g_glaa.*
               #INITIALIZE g_ref_fields TO NULL
               #LET g_ref_fields[1] = g_apdf_m.apdfld
               #CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               #LET g_apdf_m.apdfld_desc = '', g_rtn_fields[1] , ''
            END IF
            LET g_apdf_m.apdfld_desc = s_desc_get_ld_desc(g_apdf_m.apdfld)
            DISPLAY BY NAME g_apdf_m.apdfld_desc
            LET g_apdf_m_o.apdfld = g_apdf_m.apdfld
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfld
            #add-point:BEFORE FIELD apdfld name="input.b.apdfld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfld
            #add-point:ON CHANGE apdfld name="input.g.apdfld"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfcomp
            #add-point:BEFORE FIELD apdfcomp name="input.b.apdfcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfcomp
            
            #add-point:AFTER FIELD apdfcomp name="input.a.apdfcomp"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfcomp
            #add-point:ON CHANGE apdfcomp name="input.g.apdfcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfdocno
            
            #add-point:AFTER FIELD apdfdocno name="input.a.apdfdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_apdf_m.apdfdocno) AND NOT cl_null(g_apdf_m.apdfld) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apdf_m.apdfdocno != g_apdfdocno_t  OR g_apdf_m.apdfld != g_apdfld_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apdf_t WHERE "||"apdfent = '" ||g_enterprise|| "' AND "||"apdfdocno = '"||g_apdf_m.apdfdocno ||"' AND "|| "apdfld = '"||g_apdf_m.apdfld ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            LET g_apdf_m.apdfdocno_desc = ''
            IF NOT cl_null(g_apdf_m.apdfdocno) THEN
               IF g_apdf_m.apdfdocno != g_apdf_m_o.apdfdocno OR cl_null(g_apdf_m_o.apdfdocno) THEN
                  IF NOT s_aooi200_fin_chk_docno(g_apdf_m.apdfld,'','',g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_prog) THEN
                     LET g_apdf_m.apdfdocno = g_apdf_m_o.apdfdocno
                     LET g_apdf_m.apdfdocno_desc = g_apdf_m_o.apdfdocno_desc
                     DISPLAY BY NAME g_apdf_m.apdfdocno_desc 
                     NEXT FIELD CURRENT
                  END IF  
               END IF
               #161104-00046#5 --s add
               CALL s_control_chk_doc('1',g_apdf_m.apdfdocno,'4',g_user,g_dept,'','') RETURNING g_sub_success,l_flag
               IF g_sub_success AND l_flag THEN             
               ELSE
                  LET g_apdf_m.apdfdocno = g_apdf_m_o.apdfdocno
                  LET g_apdf_m.apdfdocno_desc = g_apdf_m_o.apdfdocno_desc
                  DISPLAY BY NAME g_apdf_m.apdfdocno_desc 
                  NEXT FIELD CURRENT                  
               END IF
               CALL s_aooi200_fin_get_slip(g_apdf_m.apdfdocno) RETURNING g_sub_success,g_ap_slip
               #刪除單別預設temptable
               DELETE FROM s_aooi200def1
               #以目前畫面資訊新增temp資料   #請勿調整.*
               INSERT INTO s_aooi200def1 VALUES(g_apdf_m.*)
               #依單別預設取用資訊
               CALL s_aooi200def_get('','',g_apdf_m.apdfsite,'2',g_ap_slip,'','',g_apdf_m.apdfld)
               #依單別預設值TEMP內容 給予到畫面上   #請勿調整.*
               SELECT * INTO g_apdf_m.* FROM s_aooi200def1
               #161104-00046#5 --e add

               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = g_apdf_m.apdfdocno
               CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") 
                  RETURNING g_rtn_fields
               LET g_apdf_m.apdfdocno_desc = '', g_rtn_fields[1] , ''
            END IF 
            DISPLAY BY NAME g_apdf_m.apdfdocno_desc 
            LET g_apdf_m_o.* = g_apdf_m.*



            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfdocno
            #add-point:BEFORE FIELD apdfdocno name="input.b.apdfdocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfdocno
            #add-point:ON CHANGE apdfdocno name="input.g.apdfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfdocdt
            #add-point:BEFORE FIELD apdfdocdt name="input.b.apdfdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfdocdt
            
            #add-point:AFTER FIELD apdfdocdt name="input.a.apdfdocdt"
            IF NOT cl_null(g_apdf_m.apdfdocdt) THEN  
               CALL cl_get_para(g_enterprise,g_apdf_m.apdfcomp,'S-FIN-3007') RETURNING g_sfin3007            
               IF NOT cl_null(g_sfin3007) THEN
                  IF g_apdf_m.apdfdocdt <= g_sfin3007 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00110'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apdf_m.apdfdocdt= g_apdf_m_o.apdfdocdt
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_apdf_m_o.* = g_apdf_m.*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfdocdt
            #add-point:ON CHANGE apdfdocdt name="input.g.apdfdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdfstus
            #add-point:BEFORE FIELD apdfstus name="input.b.apdfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdfstus
            
            #add-point:AFTER FIELD apdfstus name="input.a.apdfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdfstus
            #add-point:ON CHANGE apdfstus name="input.g.apdfstus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apdfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfsite
            #add-point:ON ACTION controlp INFIELD apdfsite name="input.c.apdfsite"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apdf_m.apdfsite             #給予default值
            #CALL q_ooef001()     #161006-00005#5   mark
            CALL q_ooef001_46()   #161006-00005#5   add                                      #呼叫開窗
            LET g_apdf_m.apdfsite = g_qryparam.return1        #將開窗取得的值回傳到變數
            LET g_apdf_m.apdfsite_desc = s_desc_get_department_desc(g_apdf_m.apdfsite)
            DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc
            NEXT FIELD apdfsite                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apdf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdf001
            #add-point:ON ACTION controlp INFIELD apdf001 name="input.c.apdf001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apdf_m.apdf001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_apdf_m.apdf001 = g_qryparam.return1              

            DISPLAY g_apdf_m.apdf001 TO apdf001              #
            LET g_apdf_m.apdf001_desc = s_desc_get_person_desc(g_apdf_m.apdf001)
            DISPLAY BY NAME g_apdf_m.apdf001,g_apdf_m.apdf001_desc
            NEXT FIELD apdf001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.apdfld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfld
            #add-point:ON ACTION controlp INFIELD apdfld name="input.c.apdfld"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_apdf_m.apdfld             #給予default值
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND ", 
                                   "  glaald IN ",g_ld_wc
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            CALL q_authorised_ld()
            LET g_apdf_m.apdfld = g_qryparam.return1
            LET g_apdf_m.apdfld_desc = s_desc_get_ld_desc(g_apdf_m.apdfld)
            DISPLAY BY NAME g_apdf_m.apdfld,g_apdf_m.apdfld_desc
            NEXT FIELD apdfld                #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apdfcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfcomp
            #add-point:ON ACTION controlp INFIELD apdfcomp name="input.c.apdfcomp"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdfdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfdocno
            #add-point:ON ACTION controlp INFIELD apdfdocno name="input.c.apdfdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apdf_m.apdfdocno             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_glaa.glaa024
            LET g_qryparam.arg2 = g_prog
            #161104-00046#5 --s add
            IF NOT cl_null(g_user_slip_wc)THEN
               LET g_qryparam.where = g_user_slip_wc
            END IF
            #161104-00046#5 --e add
            CALL q_ooba002_1()                                           #呼叫開窗
            LET g_apdf_m.apdfdocno = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_apdf_m.apdfdocno TO apdfdocno                #顯示到畫面上
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_apdf_m.apdfdocno
            CALL ap_ref_array2(g_ref_fields,"SELECT oobxl003 FROM oobxl_t WHERE oobxlent='"||g_enterprise||"' AND oobxl001=? AND oobxl002='"||g_dlang||"'","") 
               RETURNING g_rtn_fields
            LET g_apdf_m.apdfdocno_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_apdf_m.apdfdocno_desc
            NEXT FIELD apdfdocno                                       #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.apdfdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfdocdt
            #add-point:ON ACTION controlp INFIELD apdfdocdt name="input.c.apdfdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apdfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdfstus
            #add-point:ON ACTION controlp INFIELD apdfstus name="input.c.apdfstus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apdf_m.apdfdocno,g_apdf_m.apdfld
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_fin_gen_docno(g_apdf_m.apdfld,'','',g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_prog)
                  RETURNING g_sub_success,g_apdf_m.apdfdocno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'  #自動生成單據編號有誤，請重新確認
                  LET g_errparam.extend = g_apdf_m.apdfdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD apdfdocno
               END IF
               DISPLAY BY NAME g_apdf_m.apdfdocno
               #end add-point
               
               INSERT INTO apdf_t (apdfent,apdfsite,apdf001,apdfld,apdfcomp,apdfdocno,apdfdocdt,apdfstus, 
                   apdfownid,apdfowndp,apdfcrtid,apdfcrtdp,apdfcrtdt,apdfmodid,apdfmoddt,apdfcnfid,apdfcnfdt) 
 
               VALUES (g_enterprise,g_apdf_m.apdfsite,g_apdf_m.apdf001,g_apdf_m.apdfld,g_apdf_m.apdfcomp, 
                   g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfowndp, 
                   g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid,g_apdf_m.apdfmoddt, 
                   g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apdf_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
               
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL aapt470_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt470_b_fill()
                  CALL aapt470_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL aapt470_apdf_t_mask_restore('restore_mask_o')
               
               UPDATE apdf_t SET (apdfsite,apdf001,apdfld,apdfcomp,apdfdocno,apdfdocdt,apdfstus,apdfownid, 
                   apdfowndp,apdfcrtid,apdfcrtdp,apdfcrtdt,apdfmodid,apdfmoddt,apdfcnfid,apdfcnfdt) = (g_apdf_m.apdfsite, 
                   g_apdf_m.apdf001,g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt, 
                   g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp, 
                   g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt) 
 
                WHERE apdfent = g_enterprise AND apdfdocno = g_apdfdocno_t
                  AND apdfld = g_apdfld_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apdf_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt470_apdf_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apdf_m_t)
               LET g_log2 = util.JSON.stringify(g_apdf_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apdfdocno_t = g_apdf_m.apdfdocno
            LET g_apdfld_t = g_apdf_m.apdfld
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt470.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apdg_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apdg_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt470_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apdg_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row2 name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_detail_idx_list[1] = l_ac
            LET g_current_page = 1
            
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt470_cl USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt470_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aapt470_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apdg_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apdg_d[l_ac].apdgseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apdg_d_t.* = g_apdg_d[l_ac].*  #BACKUP
               LET g_apdg_d_o.* = g_apdg_d[l_ac].*  #BACKUP
               CALL aapt470_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL aapt470_set_no_entry_b(l_cmd)
               IF NOT aapt470_lock_b("apdg_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt470_bcl INTO g_apdg_d[l_ac].apdgseq,g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002, 
                      g_apdg_d[l_ac].apdg003,g_apdg_d[l_ac].apdg004,g_apdg_d[l_ac].apdg005,g_apdg_d[l_ac].apdg006, 
                      g_apdg_d[l_ac].apdg007,g_apdg_d[l_ac].apdg014,g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg016, 
                      g_apdg_d[l_ac].apdg017,g_apdg_d[l_ac].apdg010
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apdg_d_t.apdgseq,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apdg_d_mask_o[l_ac].* =  g_apdg_d[l_ac].*
                  CALL aapt470_apdg_t_mask()
                  LET g_apdg_d_mask_n[l_ac].* =  g_apdg_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt470_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            #廠商名稱
            LET g_apdg_d[l_ac].apdg003_desc = s_desc_get_trading_partner_abbr_desc(g_apdg_d[l_ac].apdg003)
            
            #付款類型
            LET g_apdg_d[l_ac].l_apde002 = aapt470_get_apde002(g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002)    
            
            #原銀行名稱
            LET g_apdg_d[l_ac].apdg005_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg005)
            
            #變更後銀行名稱
            LET g_apdg_d[l_ac].apdg015_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg015)
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
        
         BEFORE INSERT  
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apdg_d[l_ac].* TO NULL 
            INITIALIZE g_apdg_d_t.* TO NULL 
            INITIALIZE g_apdg_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            IF cl_null(g_apdg_d[l_ac].apdgseq) THEN          
               SELECT MAX(apdgseq) + 1 
                 INTO g_apdg_d[l_ac].apdgseq 
                 FROM apdg_t
                WHERE apdgent   = g_enterprise
                  AND apdgld    = g_apdf_m.apdfld
                  AND apdgdocno = g_apdf_m.apdfdocno
               IF cl_null(g_apdg_d[l_ac].apdgseq) THEN
                  LET g_apdg_d[l_ac].apdgseq = 1 
               END IF    
            END IF 
            #end add-point
            LET g_apdg_d_t.* = g_apdg_d[l_ac].*     #新輸入資料
            LET g_apdg_d_o.* = g_apdg_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt470_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aapt470_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apdg_d[li_reproduce_target].* = g_apdg_d[li_reproduce].*
 
               LET g_apdg_d[li_reproduce_target].apdgseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            #NEXT FIELD apdgseq
            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apdg_t 
             WHERE apdgent = g_enterprise AND apdgdocno = g_apdf_m.apdfdocno
               AND apdgld = g_apdf_m.apdfld
 
               AND apdgseq = g_apdg_d[l_ac].apdgseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apdf_m.apdfdocno
               LET gs_keys[2] = g_apdf_m.apdfld
               LET gs_keys[3] = g_apdg_d[g_detail_idx].apdgseq
               CALL aapt470_insert_b('apdg_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_apdg_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt470_b_fill()
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert2"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身刪除後(=d) name="input.body.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code = -263 
                  LET g_errparam.popup = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apdf_m.apdfdocno
               LET gs_keys[gs_keys.getLength()+1] = g_apdf_m.apdfld
 
               LET gs_keys[gs_keys.getLength()+1] = g_apdg_d_t.apdgseq
 
            
               #刪除同層單身
               IF NOT aapt470_delete_b('apdg_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt470_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt470_key_delete_b(gs_keys,'apdg_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt470_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt470_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apdg_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apdg_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdgseq
            #add-point:BEFORE FIELD apdgseq name="input.b.page1.apdgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdgseq
            
            #add-point:AFTER FIELD apdgseq name="input.a.page1.apdgseq"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_apdf_m.apdfdocno IS NOT NULL AND g_apdf_m.apdfld IS NOT NULL AND g_apdg_d[l_ac].apdgseq IS NOT NULL THEN 
               IF g_apdf_m.apdfdocno != g_apdfdocno_t OR g_apdf_m.apdfld != g_apdfld_t OR g_apdg_d[l_ac].apdgseq != g_apdg_d_t.apdgseq THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apdg_t WHERE "||"apdgent = '" ||g_enterprise|| "' AND "||"apdgdocno = '"||g_apdf_m.apdfdocno ||"' AND "|| "apdgld = '"||g_apdf_m.apdfld ||"' AND "|| "apdgseq = '"||g_apdg_d[g_detail_idx].apdgseq ||"'",'std-00004',0) THEN 
                     LET g_apdg_d[l_ac].apdgseq = g_apdg_d_t.apdgseq
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdgseq
            #add-point:ON CHANGE apdgseq name="input.g.page1.apdgseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg001
            #add-point:BEFORE FIELD apdg001 name="input.b.page1.apdg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg001
            
            #add-point:AFTER FIELD apdg001 name="input.a.page1.apdg001"
            IF NOT cl_null(g_apdg_d[l_ac].apdg001) THEN
               IF g_apdg_d[l_ac].apdg001 <> g_apdg_d_o.apdg001 OR cl_null(g_apdg_d_o.apdg001) THEN
                  #檢查付款單號
                  CALL aapt470_apdg001_chk(l_cmd) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apdg_d[l_ac].apdg001 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_apdg_d[l_ac].apdg001 = g_apdg_d_o.apdg001
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_apdg_d[l_ac].apdg002) THEN
                     #檢查付款單號+項次
                     CALL aapt470_apdg002_chk(l_cmd) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = g_apdg_d[l_ac].apdg001,'+',g_apdg_d[l_ac].apdg002  
                        LET g_errparam.code   = g_errno 
                        LET g_errparam.popup  = FALSE
                        CALL cl_err()
                        LET g_apdg_d[l_ac].apdg001 = g_apdg_d_o.apdg001
                        DISPLAY BY NAME g_apdg_d[l_ac].apdg001
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  CALL aapt470_apdg002_carry(l_ac) 
                  #付款對象
                  LET g_apdg_d[l_ac].apdg003 = g_apda005
                  #廠商名稱
                  LET g_apdg_d[l_ac].apdg003_desc = s_desc_get_trading_partner_abbr_desc(g_apdg_d[l_ac].apdg003)
                  #付款類型
                  LET g_apdg_d[l_ac].l_apde002 = aapt470_get_apde002(g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002)    
                  #原銀行名稱
                  LET g_apdg_d[l_ac].apdg005_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg005)
                  #變更後銀行名稱
                  LET g_apdg_d[l_ac].apdg015_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg015)
               END IF
            END IF  
            DISPLAY BY NAME g_apdg_d[l_ac].apdg001
            LET g_apdg_d_o.* = g_apdg_d[l_ac].*    

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg001
            #add-point:ON CHANGE apdg001 name="input.g.page1.apdg001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg002
            #add-point:BEFORE FIELD apdg002 name="input.b.page1.apdg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg002
            
            #add-point:AFTER FIELD apdg002 name="input.a.page1.apdg002"
            IF NOT cl_null(g_apdg_d[l_ac].apdg002) THEN
               IF g_apdg_d[l_ac].apdg002 <> g_apdg_d_o.apdg002 OR cl_null(g_apdg_d_o.apdg002) THEN
                  #檢查付款單號+項次
                  CALL aapt470_apdg002_chk(l_cmd) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apdg_d[l_ac].apdg001,'+',g_apdg_d[l_ac].apdg002 
                     LET g_errparam.code   = g_errno 
                     LET g_errparam.popup  = FALSE
                     CALL cl_err()
                     LET g_apdg_d[l_ac].apdg002 = g_apdg_d_o.apdg002
                     DISPLAY BY NAME g_apdg_d[l_ac].apdg002
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               CALL aapt470_apdg002_carry(l_ac) 
               #付款對象
               LET g_apdg_d[l_ac].apdg003 = g_apda005
               #廠商名稱
               LET g_apdg_d[l_ac].apdg003_desc = s_desc_get_trading_partner_abbr_desc(g_apdg_d[l_ac].apdg003)
               #付款類型
               LET g_apdg_d[l_ac].l_apde002 = aapt470_get_apde002(g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002)    
               #原銀行名稱
               LET g_apdg_d[l_ac].apdg005_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg005)
               #變更後銀行名稱
               LET g_apdg_d[l_ac].apdg015_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg015)
            END IF    
            DISPLAY BY NAME g_apdg_d[l_ac].apdg002
            LET g_apdg_d_o.* = g_apdg_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg002
            #add-point:ON CHANGE apdg002 name="input.g.page1.apdg002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg014
            #add-point:BEFORE FIELD apdg014 name="input.b.page1.apdg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg014
            
            #add-point:AFTER FIELD apdg014 name="input.a.page1.apdg014"
            LET g_apdg_d_o.* = g_apdg_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg014
            #add-point:ON CHANGE apdg014 name="input.g.page1.apdg014"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg015
            
            #add-point:AFTER FIELD apdg015 name="input.a.page1.apdg015"
            #變更受款銀行
            IF NOT cl_null(g_apdg_d[l_ac].apdg015) THEN
               IF g_apdg_d[l_ac].apdg015 <> g_apdg_d_o.apdg015 OR cl_null(g_apdg_d_o.apdg015) THEN
               
                  IF g_apdg_d[l_ac].apdg014 <> g_apdg_d[l_ac].apdg004 OR cl_null(g_apdg_d[l_ac].apdg004) THEN
                     #當受款人全名變了，則代表是員工，則檢查銀行基本檔
                     INITIALIZE g_chkparam.* TO NULL
                     LET g_chkparam.arg1 = g_apdg_d[l_ac].apdg015
                     LET g_errshow = TRUE #是否彈窗
                     IF NOT cl_chk_exist("v_nmab001") THEN
                        LET g_apdg_d[l_ac].apdg015 = g_apdg_d_o.apdg015
                        DISPLAY BY NAME g_apdg_d[l_ac].apdg015
                        NEXT FIELD CURRENT
                     END IF
                  ELSE
                     #當受款人全名沒變更(代表是廠商)，則保持原邏輯
                     CALL s_aapt420_pmaf002_chk(g_apdg_d[l_ac].apdg003, g_apdg_d[l_ac].apdg015) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = g_errno 
                        LET g_errparam.popup  = FALSE
                        CALL cl_err()
                        LET g_apdg_d[l_ac].apdg015 = g_apdg_d_o.apdg015
                        LET g_apdg_d[l_ac].apdg015_desc = g_apdg_d_o.apdg015_desc
                        DISPLAY BY NAME g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg015_desc
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF    
            #變更後銀行名稱
            LET g_apdg_d[l_ac].apdg015_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg015)
            DISPLAY BY NAME g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg015_desc
            LET g_apdg_d_o.* = g_apdg_d[l_ac].* 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg015
            #add-point:BEFORE FIELD apdg015 name="input.b.page1.apdg015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg015
            #add-point:ON CHANGE apdg015 name="input.g.page1.apdg015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg016
            #add-point:BEFORE FIELD apdg016 name="input.b.page1.apdg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg016
            
            #add-point:AFTER FIELD apdg016 name="input.a.page1.apdg016"
            #變更受款帳號
            IF NOT cl_null(g_apdg_d[l_ac].apdg016) THEN
               IF g_apdg_d[l_ac].apdg016 <> g_apdg_d_o.apdg016 OR cl_null(g_apdg_d_o.apdg016) THEN
                  
                  IF g_apdg_d[l_ac].apdg014 <> g_apdg_d[l_ac].apdg004 OR cl_null(g_apdg_d[l_ac].apdg004) THEN
                     #當受款人全名變了，則代表是員工，則不檢查
                  ELSE
                     #當受款人全名沒變更(代表是廠商)，則保持原邏輯
                     CALL s_aapt420_pmaf003_chk(g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg016) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.extend = ''
                        LET g_errparam.code   = g_errno 
                        LET g_errparam.popup  = FALSE
                        CALL cl_err()
                        LET g_apdg_d[l_ac].apdg016 = g_apdg_d_o.apdg016 
                        DISPLAY BY NAME g_apdg_d[l_ac].apdg016
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            DISPLAY BY NAME g_apdg_d[l_ac].apdg016
            LET g_apdg_d_o.* = g_apdg_d[l_ac].*
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg016
            #add-point:ON CHANGE apdg016 name="input.g.page1.apdg016"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg017
            #add-point:BEFORE FIELD apdg017 name="input.b.page1.apdg017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg017
            
            #add-point:AFTER FIELD apdg017 name="input.a.page1.apdg017"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg017
            #add-point:ON CHANGE apdg017 name="input.g.page1.apdg017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apdg010
            #add-point:BEFORE FIELD apdg010 name="input.b.page1.apdg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apdg010
            
            #add-point:AFTER FIELD apdg010 name="input.a.page1.apdg010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apdg010
            #add-point:ON CHANGE apdg010 name="input.g.page1.apdg010"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apdgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdgseq
            #add-point:ON ACTION controlp INFIELD apdgseq name="input.c.page1.apdgseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg001
            #add-point:ON ACTION controlp INFIELD apdg001 name="input.c.page1.apdg001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apdg_d[l_ac].apdg001
            LET g_qryparam.where = "     apda001 = '45' ",
                                   " AND apdald = '",g_apdf_m.apdfld,"' ",
                                   " AND apdastus <> 'X' ",
                                   " AND EXISTS(SELECT 1 ",
                                   "              FROM apde_t ",
                                   "             WHERE apdeent   = apdaent ",
                                   "               AND apdeld    = apdald ",
                                   "               AND apdedocno = apdadocno ",
                                   "               AND apde002 = '10' ",
                                   "               AND apde009 = 'N') "
            CALL q_apda001()  
            LET g_apdg_d[l_ac].apdg001 = g_qryparam.return1     #將開窗取得的值回傳到變數
            DISPLAY g_apdg_d[l_ac].apdg001 TO apdg001
            NEXT FIELD apdg001
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg002
            #add-point:ON ACTION controlp INFIELD apdg002 name="input.c.page1.apdg002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg014
            #add-point:ON ACTION controlp INFIELD apdg014 name="input.c.page1.apdg014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE           
            IF g_apdg_d[l_ac].apdg003 = 'EMPL' THEN  #160926-00013#1 add
               LET g_qryparam.default1 = g_apdg_d[g_detail_idx].apdg014
               LET g_qryparam.default2 = g_apdg_d[g_detail_idx].apdg015
               LET g_qryparam.default3 = g_apdg_d[g_detail_idx].apdg016
               CALL q_ooag001_10()
               LET g_apdg_d[g_detail_idx].apdg014 = g_qryparam.return1     #將開窗取得的值回傳到變數
               LET g_apdg_d[g_detail_idx].apdg015 = g_qryparam.return2     #將開窗取得的值回傳到變數
               LET g_apdg_d[g_detail_idx].apdg016 = g_qryparam.return3     #將開窗取得的值回傳到變數
               DISPLAY g_apdg_d[g_detail_idx].apdg014 TO apdg014
               DISPLAY g_apdg_d[g_detail_idx].apdg015 TO apdg015
               DISPLAY g_apdg_d[g_detail_idx].apdg016 TO apdg016
            #160926-00013#1 add---s
            ELSE
               LET g_qryparam.default1 = g_apdg_d[g_detail_idx].apdg014
               CALL q_apde041() 
               LET g_apdg_d[g_detail_idx].apdg014 = g_qryparam.return1 
               DISPLAY g_apdg_d[g_detail_idx].apdg014 TO apdg014
            END IF 
            #160926-00013#1 add---e            
            NEXT FIELD apdg014
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg015
            #add-point:ON ACTION controlp INFIELD apdg015 name="input.c.page1.apdg015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF g_apdg_d[l_ac].apdg014 <> g_apdg_d[l_ac].apdg004 OR 
               cl_null(g_apdg_d[l_ac].apdg004) THEN
               LET g_qryparam.default1 = g_apdg_d[l_ac].apdg015
               CALL q_nmab001()
               LET g_apdg_d[l_ac].apdg015 = g_qryparam.return1     #將開窗取得的值回傳到變數
               DISPLAY g_apdg_d[l_ac].apdg015 TO apdg015
            ELSE
               LET g_qryparam.arg1     = g_apdg_d[l_ac].apdg003
               LET g_qryparam.default1 = g_apdg_d[l_ac].apdg015
               LET g_qryparam.default2 = g_apdg_d[l_ac].apdg016
               CALL q_pmaf002()
               LET g_apdg_d[l_ac].apdg015 = g_qryparam.return1     #將開窗取得的值回傳到變數
               LET g_apdg_d[l_ac].apdg016 = g_qryparam.return2     #將開窗取得的值回傳到變數
               DISPLAY g_apdg_d[l_ac].apdg015 TO apdg015
               DISPLAY g_apdg_d[l_ac].apdg016 TO apdg016
            END IF
            NEXT FIELD apdg015
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg016
            #add-point:ON ACTION controlp INFIELD apdg016 name="input.c.page1.apdg016"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            IF g_apdg_d[l_ac].apdg014 <> g_apdg_d[l_ac].apdg004 OR 
               cl_null(g_apdg_d[l_ac].apdg004)  THEN
               LET g_qryparam.default1 = g_apdg_d[l_ac].apdg016
               LET g_qryparam.where = "     ooag011 = '",g_apdg_d[l_ac].apdg014,"' ",
                                      " AND ooag006 = '",g_apdg_d[l_ac].apdg015,"' "
               CALL q_ooag002()
               LET g_apdg_d[l_ac].apdg016 = g_qryparam.return1     #將開窗取得的值回傳到變數
               DISPLAY g_apdg_d[l_ac].apdg016 TO apdg016
            ELSE
               LET g_qryparam.arg1     = g_apdg_d[l_ac].apdg003
               LET g_qryparam.default1 = g_apdg_d[l_ac].apdg015
               LET g_qryparam.default2 = g_apdg_d[l_ac].apdg016
               CALL q_pmaf002()
               LET g_apdg_d[l_ac].apdg015 = g_qryparam.return1     #將開窗取得的值回傳到變數
               LET g_apdg_d[l_ac].apdg016 = g_qryparam.return2     #將開窗取得的值回傳到變數
               DISPLAY g_apdg_d[l_ac].apdg015 TO apdg015
               DISPLAY g_apdg_d[l_ac].apdg016 TO apdg016
            END IF
            NEXT FIELD apdg016
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg017
            #add-point:ON ACTION controlp INFIELD apdg017 name="input.c.page1.apdg017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apdg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apdg010
            #add-point:ON ACTION controlp INFIELD apdg010 name="input.c.page1.apdg010"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apdg_d[l_ac].* = g_apdg_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aapt470_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apdg_d[l_ac].apdgseq 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_apdg_d[l_ac].* = g_apdg_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt470_apdg_t_mask_restore('restore_mask_o')
      
               UPDATE apdg_t SET (apdgdocno,apdgld,apdgseq,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006, 
                   apdg007,apdg014,apdg015,apdg016,apdg017,apdg010) = (g_apdf_m.apdfdocno,g_apdf_m.apdfld, 
                   g_apdg_d[l_ac].apdgseq,g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002,g_apdg_d[l_ac].apdg003, 
                   g_apdg_d[l_ac].apdg004,g_apdg_d[l_ac].apdg005,g_apdg_d[l_ac].apdg006,g_apdg_d[l_ac].apdg007, 
                   g_apdg_d[l_ac].apdg014,g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg016,g_apdg_d[l_ac].apdg017, 
                   g_apdg_d[l_ac].apdg010)
                WHERE apdgent = g_enterprise AND apdgdocno = g_apdf_m.apdfdocno 
                  AND apdgld = g_apdf_m.apdfld 
 
                  AND apdgseq = g_apdg_d_t.apdgseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apdg_d[l_ac].* = g_apdg_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apdg_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_apdg_d[l_ac].* = g_apdg_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apdf_m.apdfdocno
               LET gs_keys_bak[1] = g_apdfdocno_t
               LET gs_keys[2] = g_apdf_m.apdfld
               LET gs_keys_bak[2] = g_apdfld_t
               LET gs_keys[3] = g_apdg_d[g_detail_idx].apdgseq
               LET gs_keys_bak[3] = g_apdg_d_t.apdgseq
               CALL aapt470_update_b('apdg_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt470_apdg_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apdg_d[g_detail_idx].apdgseq = g_apdg_d_t.apdgseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apdf_m.apdfdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apdf_m.apdfld
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apdg_d_t.apdgseq
 
                  CALL aapt470_key_update_b(gs_keys,'apdg_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apdf_m),util.JSON.stringify(g_apdg_d_t)
               LET g_log2 = util.JSON.stringify(g_apdf_m),util.JSON.stringify(g_apdg_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt470_unlock_b("apdg_t","'1'")
            CALL s_transaction_end('Y','0')
            #其他table進行unlock
            #add-point:單身after_row2 name="input.body.after_row2"
            
            #end add-point
              
         AFTER INPUT
            #add-point:input段after input  name="input.body.after_input"
            
            #end add-point 
    
         ON ACTION controlo    
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apdg_d[li_reproduce_target].* = g_apdg_d[li_reproduce].*
 
               LET g_apdg_d[li_reproduce_target].apdgseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apdg_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apdg_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="aapt470.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            NEXT FIELD apdfsite
            #end add-point  
            NEXT FIELD apdfdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apdgseq
 
               #add-point:input段modify_detail  name="input.modify_detail.other"
               
               #end add-point  
            END CASE
         END IF
      
      AFTER DIALOG
         #add-point:input段after_dialog name="input.after_dialog"
         
         #end add-point    
         
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)
 
      ON ACTION controlr
         CALL cl_show_req_fields()
 
      ON ACTION controls
         IF g_header_hidden THEN
            CALL gfrm_curr.setElementHidden("vb_master",0)
            CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
            LET g_header_hidden = 0     #visible
         ELSE
            CALL gfrm_curr.setElementHidden("vb_master",1)
            CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
            LET g_header_hidden = 1     #hidden     
         END IF
 
      ON ACTION accept
         #add-point:input段accept  name="input.accept"
         
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         #add-point:input段close name="input.close"
         
         #end add-point  
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         #add-point:input段exit name="input.exit"
         
         #end add-point
         LET INT_FLAG = TRUE 
         LET g_detail_idx  = 1
         LET g_detail_idx2 = 1
         #各個page指標
         LET g_detail_idx_list[1] = 1 
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt470_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt470_b_fill() #單身填充
      CALL aapt470_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt470_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   #單別名稱
   CALL s_aooi200_fin_get_slip_desc(g_apdf_m.apdfdocno) RETURNING g_apdf_m.apdfdocno_desc
   #end add-point
   
   #遮罩相關處理
   LET g_apdf_m_mask_o.* =  g_apdf_m.*
   CALL aapt470_apdf_t_mask()
   LET g_apdf_m_mask_n.* =  g_apdf_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001,g_apdf_m.apdf001_desc,g_apdf_m.apdfld, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfdocdt, 
       g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfcrtdt, 
       g_apdf_m.apdfmodid,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfid_desc, 
       g_apdf_m.apdfcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apdf_m.apdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_apdg_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt470_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt470_detail_show()
   #add-point:detail_show段define(客製用) name="detail_show.define_customerization"
   
   #end add-point  
   #add-point:detail_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="detail_show.before"
   
   #end add-point
   
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt470_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apdf_t.apdfdocno 
   DEFINE l_oldno     LIKE apdf_t.apdfdocno 
   DEFINE l_newno02     LIKE apdf_t.apdfld 
   DEFINE l_oldno02     LIKE apdf_t.apdfld 
 
   DEFINE l_master    RECORD LIKE apdf_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE apdg_t.* #此變數樣板目前無使用
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   
   LET g_master_insert = FALSE
   
   IF g_apdf_m.apdfdocno IS NULL
   OR g_apdf_m.apdfld IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apdfdocno_t = g_apdf_m.apdfdocno
   LET g_apdfld_t = g_apdf_m.apdfld
 
    
   LET g_apdf_m.apdfdocno = ""
   LET g_apdf_m.apdfld = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apdf_m.apdfownid = g_user
      LET g_apdf_m.apdfowndp = g_dept
      LET g_apdf_m.apdfcrtid = g_user
      LET g_apdf_m.apdfcrtdp = g_dept 
      LET g_apdf_m.apdfcrtdt = cl_get_current()
      LET g_apdf_m.apdfmodid = g_user
      LET g_apdf_m.apdfmoddt = cl_get_current()
      LET g_apdf_m.apdfstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   #取得預設帳務中心、帳套、公司別
   CALL s_aap_get_default_apcasite('1','','') RETURNING g_sub_success,g_errno,g_apdf_m.apdfsite,g_apdf_m.apdfld,g_apdf_m.apdfcomp
   #161114-00017#1 add ------
   #CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_apdf_m.apdfcomp) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 mark
   #161114-00017#1 add end---
   CALL s_fin_get_wc_str(g_apdf_m.apdfcomp) RETURNING g_comp_str  #161229-00047#50 add 
   CALL s_control_get_supplier_sql_pmab('4',g_site,g_user,g_dept,'',g_comp_str) RETURNING g_sub_success,g_sql_ctrl #161229-00047#50 add
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apdf_m.apdfstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_apdf_m.apdfld_desc = ''
   DISPLAY BY NAME g_apdf_m.apdfld_desc
   LET g_apdf_m.apdfdocno_desc = ''
   DISPLAY BY NAME g_apdf_m.apdfdocno_desc
 
   
   CALL aapt470_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apdf_m.* TO NULL
      INITIALIZE g_apdg_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt470_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code = 9001 
      LET g_errparam.popup = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt470_set_act_visible()   
   CALL aapt470_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apdfdocno_t = g_apdf_m.apdfdocno
   LET g_apdfld_t = g_apdf_m.apdfld
 
   
   #組合新增資料的條件
   LET g_add_browse = " apdfent = " ||g_enterprise|| " AND",
                      " apdfdocno = '", g_apdf_m.apdfdocno, "' "
                      ," AND apdfld = '", g_apdf_m.apdfld, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt470_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt470_idx_chk()
   
   LET g_data_owner = g_apdf_m.apdfownid      
   LET g_data_dept  = g_apdf_m.apdfowndp
   
   #功能已完成,通報訊息中心
   CALL aapt470_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt470_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apdg_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt470_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apdg_t
    WHERE apdgent = g_enterprise AND apdgdocno = g_apdfdocno_t
     AND apdgld = g_apdfld_t
 
    INTO TEMP aapt470_detail
 
   #將key修正為調整後   
   UPDATE aapt470_detail 
      #更新key欄位
      SET apdgdocno = g_apdf_m.apdfdocno
          , apdgld = g_apdf_m.apdfld
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apdg_t SELECT * FROM aapt470_detail
   
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt470_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apdfdocno_t = g_apdf_m.apdfdocno
   LET g_apdfld_t = g_apdf_m.apdfld
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt470_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_apdf_m.apdfdocno IS NULL
   OR g_apdf_m.apdfld IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt470_cl USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt470_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aapt470_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apdf_m_mask_o.* =  g_apdf_m.*
   CALL aapt470_apdf_t_mask()
   LET g_apdf_m_mask_n.* =  g_apdf_m.*
   
   CALL aapt470_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   IF g_apdf_m.apdfstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00313'
      LET g_errparam.extend = g_apdf_m.apdfstus
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt470_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apdfdocno_t = g_apdf_m.apdfdocno
      LET g_apdfld_t = g_apdf_m.apdfld
 
 
      DELETE FROM apdf_t
       WHERE apdfent = g_enterprise AND apdfdocno = g_apdf_m.apdfdocno
         AND apdfld = g_apdf_m.apdfld
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apdf_m.apdfdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_fin_del_docno(g_apdf_m.apdfld,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt) THEN
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apdg_t
       WHERE apdgent = g_enterprise AND apdgdocno = g_apdf_m.apdfdocno
         AND apdgld = g_apdf_m.apdfld
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_apdf_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apdg_d.clear() 
 
     
      CALL aapt470_ui_browser_refresh()  
      #CALL aapt470_ui_headershow()  
      #CALL aapt470_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt470_browser_fill("")
         CALL aapt470_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt470_cl
 
   #功能已完成,通報訊息中心
   CALL aapt470_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt470.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt470_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apdg_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   #判斷是否填充
   IF aapt470_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT apdgseq,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006,apdg007, 
             apdg014,apdg015,apdg016,apdg017,apdg010  FROM apdg_t",   
                     " INNER JOIN apdf_t ON apdfent = " ||g_enterprise|| " AND apdfdocno = apdgdocno ",
                     " AND apdfld = apdgld ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE apdgent=? AND apdgdocno=? AND apdgld=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apdg_t.apdgseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt470_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt470_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdg_d[l_ac].apdgseq, 
          g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002,g_apdg_d[l_ac].apdg003,g_apdg_d[l_ac].apdg004, 
          g_apdg_d[l_ac].apdg005,g_apdg_d[l_ac].apdg006,g_apdg_d[l_ac].apdg007,g_apdg_d[l_ac].apdg014, 
          g_apdg_d[l_ac].apdg015,g_apdg_d[l_ac].apdg016,g_apdg_d[l_ac].apdg017,g_apdg_d[l_ac].apdg010  
            #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #廠商名稱
         LET g_apdg_d[l_ac].apdg003_desc = s_desc_get_trading_partner_abbr_desc(g_apdg_d[l_ac].apdg003)
         
         #付款類型
         LET g_apdg_d[l_ac].l_apde002 = aapt470_get_apde002(g_apdg_d[l_ac].apdg001,g_apdg_d[l_ac].apdg002)    
         
         #原銀行名稱
         LET g_apdg_d[l_ac].apdg005_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg005)
         
         #變更後銀行名稱
         LET g_apdg_d[l_ac].apdg015_desc = aapt470_get_nmabl003(g_apdg_d[l_ac].apdg015)
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code = 9035 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_apdg_d.deleteElement(g_apdg_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt470_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apdg_d.getLength()
      LET g_apdg_d_mask_o[l_ac].* =  g_apdg_d[l_ac].*
      CALL aapt470_apdg_t_mask()
      LET g_apdg_d_mask_n[l_ac].* =  g_apdg_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt470_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define(客製用) name="delete_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete"
      
      #end add-point    
      DELETE FROM apdg_t
       WHERE apdgent = g_enterprise AND
         apdgdocno = ps_keys_bak[1] AND apdgld = ps_keys_bak[2] AND apdgseq = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apdg_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt470_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define(客製用) name="insert_b.define_customerization"
   
   #end add-point     
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   DEFINE li_idx      LIKE type_t.num10
   #add-point:insert_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE  
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert"
      
      #end add-point 
      INSERT INTO apdg_t
                  (apdgent,
                   apdgdocno,apdgld,
                   apdgseq
                   ,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006,apdg007,apdg014,apdg015,apdg016,apdg017,apdg010) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_apdg_d[g_detail_idx].apdg001,g_apdg_d[g_detail_idx].apdg002,g_apdg_d[g_detail_idx].apdg003, 
                       g_apdg_d[g_detail_idx].apdg004,g_apdg_d[g_detail_idx].apdg005,g_apdg_d[g_detail_idx].apdg006, 
                       g_apdg_d[g_detail_idx].apdg007,g_apdg_d[g_detail_idx].apdg014,g_apdg_d[g_detail_idx].apdg015, 
                       g_apdg_d[g_detail_idx].apdg016,g_apdg_d[g_detail_idx].apdg017,g_apdg_d[g_detail_idx].apdg010) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apdg_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt470_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define(客製用) name="update_b.define_customerization"
   
   #end add-point   
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num10 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
   LET g_update = TRUE   
   
   #判斷key是否有改變
   LET lb_chk = TRUE
   FOR li_idx = 1 TO ps_keys.getLength()
      IF ps_keys[li_idx] <> ps_keys_bak[li_idx] THEN
         LET lb_chk = FALSE
         EXIT FOR
      END IF
   END FOR
   
   #不需要做處理
   IF lb_chk THEN
      RETURN
   END IF
   
   #判斷是否是同一群組的table
   LET ls_group = "'1',"
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apdg_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt470_apdg_t_mask_restore('restore_mask_o')
               
      UPDATE apdg_t 
         SET (apdgdocno,apdgld,
              apdgseq
              ,apdg001,apdg002,apdg003,apdg004,apdg005,apdg006,apdg007,apdg014,apdg015,apdg016,apdg017,apdg010) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_apdg_d[g_detail_idx].apdg001,g_apdg_d[g_detail_idx].apdg002,g_apdg_d[g_detail_idx].apdg003, 
                  g_apdg_d[g_detail_idx].apdg004,g_apdg_d[g_detail_idx].apdg005,g_apdg_d[g_detail_idx].apdg006, 
                  g_apdg_d[g_detail_idx].apdg007,g_apdg_d[g_detail_idx].apdg014,g_apdg_d[g_detail_idx].apdg015, 
                  g_apdg_d[g_detail_idx].apdg016,g_apdg_d[g_detail_idx].apdg017,g_apdg_d[g_detail_idx].apdg010)  
 
         WHERE apdgent = g_enterprise AND apdgdocno = ps_keys_bak[1] AND apdgld = ps_keys_bak[2] AND apdgseq = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apdg_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apdg_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt470_apdg_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt470_key_update_b(ps_keys_bak,ps_table)
   #add-point:update_b段define(客製用) name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_key       DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:update_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt470_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt470_lock_b(ps_table,ps_page)
   #add-point:lock_b段define(客製用) name="lock_b.define_customerization"
   
   #end add-point   
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
    
   #先刷新資料
   #CALL aapt470_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apdg_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt470_bcl USING g_enterprise,
                                       g_apdf_m.apdfdocno,g_apdf_m.apdfld,g_apdg_d[g_detail_idx].apdgseq  
                                               
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt470_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt470_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define(客製用) name="unlock_b.define_customerization"
   
   #end add-point  
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
    
   LET ls_group = "'1',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt470_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt470_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apdfdocno,apdfld",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apdfdocno,apdfld",TRUE)
      CALL cl_set_comp_entry("apdfdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      CALL cl_set_comp_entry("apdfsite,apdfdocdt",TRUE)
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
 
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt470_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apdfdocno,apdfld",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      CALL cl_set_comp_entry("apdfsite",FALSE)
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apdfdocno,apdfld",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apdfdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt470_set_entry_b(p_cmd)
   #add-point:set_entry_b段define(客製用) name="set_entry_b.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_entry_b.pre_function"
   
   #end add-point
    
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("",TRUE)
      #add-point:set_entry段欄位控制 name="set_entry_b.field_control"
 
      #end add-point  
   END IF
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
   
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt470_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define(客製用) name="set_no_entry_b.define_customerization"
   
   #end add-point    
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="set_no_entry_b.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("",FALSE)
      #add-point:set_no_entry_b段欄位控制 name="set_no_entry_b.field_control"
 
      #end add-point 
   END IF 
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b"
   
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt470_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt470_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:2)
   IF g_apdf_m.apdfstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF



   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt470_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt470_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt470_default_search()
   #add-point:default_search段define(客製用) name="default_search.define_customerization"
   
   #end add-point  
   DEFINE li_idx     LIKE type_t.num10
   DEFINE li_cnt     LIKE type_t.num10
   DEFINE ls_wc      STRING
   DEFINE la_wc      DYNAMIC ARRAY OF RECORD
          tableid    STRING,
          wc         STRING
          END RECORD
   DEFINE ls_where   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " apdfdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apdfld = '", g_argv[02], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      
      #預設查詢條件
      CALL cl_qbe_get_default_qryplan() RETURNING ls_where
      IF NOT cl_null(ls_where) THEN
         CALL util.JSON.parse(ls_where, la_wc)
         INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apdf_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apdg_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
 
            IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
            END IF
         
            IF g_wc2.subString(1,5) = " AND " THEN
               LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
            END IF
         END IF
      END IF
    
      IF cl_null(g_wc) AND cl_null(g_wc2) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt470_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apdf_m.apdfdocno IS NULL
      OR g_apdf_m.apdfld IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt470_cl USING g_enterprise,g_apdf_m.apdfdocno,g_apdf_m.apdfld
   IF STATUS THEN
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt470_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite,g_apdf_m.apdf001, 
       g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid, 
       g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid, 
       g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001_desc, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aapt470_action_chk() THEN
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001,g_apdf_m.apdf001_desc,g_apdf_m.apdfld, 
       g_apdf_m.apdfld_desc,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfdocdt, 
       g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp,g_apdf_m.apdfowndp_desc, 
       g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfcrtdt, 
       g_apdf_m.apdfmodid,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfid_desc, 
       g_apdf_m.apdfcnfdt
 
   CASE g_apdf_m.apdfstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   CALL s_aooi200_fin_get_slip_desc(g_apdf_m.apdfdocno) RETURNING g_apdf_m.apdfdocno_desc
   DISPLAY BY NAME g_apdf_m.apdfdocno_desc
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_apdf_m.apdfstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("invalid,confirmed",TRUE)
      CALL cl_set_act_visible("unconfirmed",FALSE)   #沒有取消確認的功能

      CASE g_apdf_m.apdfstus
         WHEN "N"
          
         WHEN "X"
            CLOSE aapt470_cl
            CALL s_transaction_end('N','0')
            RETURN

         WHEN "Y"
            CLOSE aapt470_cl
            CALL s_transaction_end('N','0')
            RETURN
      END CASE
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_apdf_m.apdfstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt470_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   #確認時回寫變更後資料至應付核銷單
   IF lc_state = 'Y' THEN
      IF NOT cl_ask_confirm('aim-00108') THEN
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT s_aapt470_conf_chk(g_apdf_m.apdfld,g_apdf_m.apdfdocno) THEN
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
      IF NOT s_aapt470_conf_upd(g_apdf_m.apdfld,g_apdf_m.apdfdocno) THEN
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   
   #作廢
   IF lc_state = 'X' THEN
      IF NOT cl_ask_confirm('aim-00109') THEN
         CLOSE aapt470_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
   END IF
   #end add-point
   
   LET g_apdf_m.apdfmodid = g_user
   LET g_apdf_m.apdfmoddt = cl_get_current()
   LET g_apdf_m.apdfstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apdf_t 
      SET (apdfstus,apdfmodid,apdfmoddt) 
        = (g_apdf_m.apdfstus,g_apdf_m.apdfmodid,g_apdf_m.apdfmoddt)     
    WHERE apdfent = g_enterprise AND apdfdocno = g_apdf_m.apdfdocno
      AND apdfld = g_apdf_m.apdfld
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aapt470_master_referesh USING g_apdf_m.apdfdocno,g_apdf_m.apdfld INTO g_apdf_m.apdfsite, 
          g_apdf_m.apdf001,g_apdf_m.apdfld,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocdt,g_apdf_m.apdfstus, 
          g_apdf_m.apdfownid,g_apdf_m.apdfowndp,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdt, 
          g_apdf_m.apdfmodid,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid,g_apdf_m.apdfcnfdt,g_apdf_m.apdfsite_desc, 
          g_apdf_m.apdf001_desc,g_apdf_m.apdfld_desc,g_apdf_m.apdfdocno_desc,g_apdf_m.apdfownid_desc, 
          g_apdf_m.apdfowndp_desc,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp_desc,g_apdf_m.apdfmodid_desc, 
          g_apdf_m.apdfcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apdf_m.apdfsite,g_apdf_m.apdfsite_desc,g_apdf_m.apdf001,g_apdf_m.apdf001_desc, 
          g_apdf_m.apdfld,g_apdf_m.apdfld_desc,g_apdf_m.apdfcomp,g_apdf_m.apdfdocno,g_apdf_m.apdfdocno_desc, 
          g_apdf_m.apdfdocdt,g_apdf_m.apdfstus,g_apdf_m.apdfownid,g_apdf_m.apdfownid_desc,g_apdf_m.apdfowndp, 
          g_apdf_m.apdfowndp_desc,g_apdf_m.apdfcrtid,g_apdf_m.apdfcrtid_desc,g_apdf_m.apdfcrtdp,g_apdf_m.apdfcrtdp_desc, 
          g_apdf_m.apdfcrtdt,g_apdf_m.apdfmodid,g_apdf_m.apdfmodid_desc,g_apdf_m.apdfmoddt,g_apdf_m.apdfcnfid, 
          g_apdf_m.apdfcnfid_desc,g_apdf_m.apdfcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt470_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt470_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt470.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt470_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apdg_d.getLength() THEN
         LET g_detail_idx = g_apdg_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apdg_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apdg_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt470_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aapt470_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt470_fill_chk(ps_idx)
   #add-point:fill_chk段define(客製用) name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   #add-point:fill_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="fill_chk.before_chk"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
 
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt470.status_show" >}
PRIVATE FUNCTION aapt470_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt470.mask_functions" >}
&include "erp/aap/aapt470_mask.4gl"
 
{</section>}
 
{<section id="aapt470.signature" >}
   
 
{</section>}
 
{<section id="aapt470.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt470_set_pk_array()
   #add-point:set_pk_array段define name="set_pk_array.define_customerization"
   
   #end add-point
   #add-point:set_pk_array段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_pk_array.define"
   
   #end add-point
   
   #add-point:Function前置處理 name="set_pk_array.before"
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_apdf_m.apdfdocno
   LET g_pk_array[1].column = 'apdfdocno'
   LET g_pk_array[2].values = g_apdf_m.apdfld
   LET g_pk_array[2].column = 'apdfld'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt470.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt470.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt470_msgcentre_notify(lc_state)
   #add-point:msgcentre_notify段define name="msgcentre_notify.define_customerization"
   
   #end add-point   
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="msgcentre_notify.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="msgcentre_notify.pre_function"
   
   #end add-point
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL aapt470_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apdf_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt470.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt470_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt470.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得帳務中心下帳套範圍
# Memo...........:
# Usage..........: CALL aapt470_get_ld_wc(p_site)
#                  RETURNING r_wc
# Input parameter: p_site         營運據點
# Return code....: r_ld_wc        範圍帳套字串
#                : r_site_wc      範圍組織字串
# Date & Author..: 2016/08/18  By Zoey
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_get_ld_wc(p_site)
   DEFINE p_site     LIKE apda_t.apdasite
   DEFINE r_ld_wc    STRING
   DEFINE r_site_wc  STRING

   #取得帳務組織下所屬成員範圍
   CALL s_fin_account_center_sons_query('3',p_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別
   CALL s_fin_account_center_ld_str() RETURNING r_ld_wc
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_str() RETURNING r_site_wc
   #將取回的字串轉換為SQL條件
   CALL s_fin_get_wc_str(r_ld_wc) RETURNING r_ld_wc   
   CALL s_fin_get_wc_str(r_site_wc) RETURNING r_site_wc   

   RETURN r_ld_wc,r_site_wc
END FUNCTION

################################################################################
# Descriptions...: 檢查付款單號
# Memo...........:
# Usage..........: CALL aapt470_apdg001_chk(p_cmd)
# Input parameter: p_cmd   a/u/r
# Return code....: none
# Date & Author..: 2016/08/18  By Zoey
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_apdg001_chk(p_cmd)
   DEFINE p_cmd       LIKE type_t.chr1
   DEFINE l_apdastus  LIKE apda_t.apdastus
   DEFINE  r_success   LIKE type_t.num5
   DEFINE  r_errno     LIKE gzze_t.gzze001
   DEFINE l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_errno = ''
   
   LET g_apda005 = NULL
   LET l_apdastus = NULL
   
   SELECT apda005,apdastus
     INTO g_apda005,l_apdastus
     FROM apda_t
    WHERE apdaent   = g_enterprise
      AND apdald    = g_apdf_m.apdfld
      AND apdadocno = g_apdg_d[l_ac].apdg001
      AND apda001   = '45'
   
   CASE  
      WHEN SQLCA.sqlcode = 100
         LET r_success = FALSE
         LET r_errno = 'aap-00577'  #輸入的單號不存在於應付核銷維護作業中或帳別不同，請重新輸入！
      WHEN l_apdastus = 'X' 
         LET r_success = FALSE
         LET r_errno = 'apr-00207'  #單據已作廢！
      OTHERWISE
         LET r_success = TRUE
         LET r_errno = SQLCA.sqlcode USING '---------'
   END CASE
   
   IF NOT r_success THEN 
      RETURN r_success,r_errno 
   END IF
      
   LET l_cnt = NULL
   
   SELECT COUNT(1)
     INTO l_cnt
     FROM apde_t
    WHERE apdeent   = g_enterprise
      AND apdeld    = g_apdf_m.apdfld
      AND apdedocno = g_apdg_d[l_ac].apdg001
      AND apde009   = 'N' 
      AND apde002   = '10' 
      
   IF cl_null(l_cnt)THEN 
      LET l_cnt = 0 
   END IF   
   
   IF l_cnt = 0 THEN
      LET r_success = FALSE
      LET r_errno = 'aap-00575'  #此單號無符合之項次(未轉出納&付款類型=10.付款)，請重新輸入！
   END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 檢查付款單號+項次
# Memo...........:
# Usage..........: CALL aapt470_apdg002_chk(p_cmd)
# Input parameter: p_cmd   a/u/r
# Return code....: none
# Date & Author..: 2016/08/18  By Zoey
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_apdg002_chk(p_cmd)
   DEFINE p_cmd       LIKE type_t.chr1
   DEFINE l_apde      RECORD
                      l_apde002   LIKE apde_t.apde002,
                      l_apde009   LIKE apde_t.apde009,
                      l_apde032   LIKE apde_t.apde032,
                      l_apde039   LIKE apde_t.apde039,
                      l_apde040   LIKE apde_t.apde040,
                      l_apde041   LIKE apde_t.apde041
                      END RECORD
   DEFINE  r_success   LIKE type_t.num5
   DEFINE  r_errno     LIKE gzze_t.gzze001
   DEFINE  l_cnt       LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_errno = ''
   
   INITIALIZE l_apde.* TO NULL
   SELECT apde002,apde009,apde032,apde039,apde040,apde041
    INTO l_apde.*
    FROM apde_t
   WHERE apdeent   = g_enterprise
     AND apdeld    = g_apdf_m.apdfld
     AND apdedocno = g_apdg_d[l_ac].apdg001
     AND apdeseq   = g_apdg_d[l_ac].apdg002
      
      CASE  
         WHEN SQLCA.sqlcode = 100
            LET r_success = FALSE
            LET r_errno = 'aap-00576'  #輸入的單號+項次不存在於應付核銷維護作業單身中，請重新輸入！
         WHEN l_apde.l_apde002 <> '10'
            LET r_success = FALSE
            LET r_errno = 'aap-00579'  #此項次付款類型不為10.付款，請重新輸入！
         WHEN l_apde.l_apde009 = 'Y'
            LET r_success = FALSE
            LET r_errno = 'aap-00578'  #此項次已轉出納資料，請重新輸入！
         OTHERWISE
            LET r_success = TRUE
            LET r_errno = SQLCA.sqlcode USING '---------'
      END CASE
      
      IF NOT r_success THEN 
         RETURN r_success,r_errno 
      END IF
      
      LET l_cnt = NULL 
      IF p_cmd = 'u' THEN
         SELECT COUNT(1)
           INTO l_cnt
           FROM apdf_t,apdg_t
          WHERE apdfent   = apdgent
            AND apdfld    = apdgld
            AND apdfdocno = apdgdocno
            AND apdgent   = g_enterprise
            AND apdgld    = g_apdf_m.apdfld
            AND apdgseq  <> g_apdg_d[l_ac].apdgseq
            AND apdg001   = g_apdg_d[l_ac].apdg001
            AND apdg002   = g_apdg_d[l_ac].apdg002
            AND apdfstus  = 'N'
      ELSE
         SELECT COUNT(1)
           INTO l_cnt
           FROM apdf_t,apdg_t
          WHERE apdfent   = apdgent
            AND apdfld    = apdgld
            AND apdfdocno = apdgdocno
            AND apdgent   = g_enterprise
            AND apdgld    = g_apdf_m.apdfld
            AND apdg001   = g_apdg_d[l_ac].apdg001
            AND apdg002   = g_apdg_d[l_ac].apdg002
            AND apdfstus  = 'N'  
      END IF
      
      IF cl_null(l_cnt)THEN 
         LET l_cnt = 0 
      END IF 
      
      IF l_cnt != 0 THEN
         LET r_success = FALSE
         LET r_errno = 'aap-00581'  #此付款單號+項次已存在未確認的付款資料變更申請單中，請重新輸入！
      END IF

   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 根據銀行代碼取得銀行名稱
# Memo...........:
# Usage..........: CALL aapt470_get_nmabl003(p_nmabl001)
#                  RETURNING l_nmabl003
# Input parameter: p_nmabl001   銀行代碼
# Return code....: l_nmabl003   銀行名稱
# Date & Author..: 2016/08/18  By Zoey
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_get_nmabl003(p_nmabl001)
   DEFINE p_nmabl001    LIKE nmabl_t.nmabl001
   DEFINE l_nmabl003    LIKE nmabl_t.nmabl003
   
   LET l_nmabl003 = NULL
   SELECT nmabl003 
     INTO l_nmabl003 
     FROM nmabl_t 
    WHERE nmablent = g_enterprise
      AND nmabl001 = p_nmabl001
      AND nmabl002 = g_dlang
   
   RETURN l_nmabl003
END FUNCTION

################################################################################
# Descriptions...: 根據付款單號+付款項次取得付款類型
# Memo...........:
# Usage..........: CALL aapt470_get_apde002(p_apdedocno,p_apdeseq)
#                  RETURNING l_apde002
# Input parameter: p_apdedocno  付款單號
#                : p_apdeseq    付款項次
# Return code....: l_apde002    付款類型
# Date & Author..: 2016/08/18  By Zoey
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_get_apde002(p_apdedocno,p_apdeseq)
   DEFINE p_apdedocno  LIKE apde_t.apdedocno
   DEFINE p_apdeseq   LIKE apde_t.apdeseq
   DEFINE l_apde002   LIKE apde_t.apde002

   LET l_apde002 = NULL
   SELECT apde002
     INTO l_apde002
     FROM apde_t
    WHERE apdeent   = g_enterprise
      AND apdeld    = g_apdf_m.apdfld
      AND apdedocno = p_apdedocno
      AND apdeseq   = p_apdeseq

   RETURN l_apde002
END FUNCTION

################################################################################
# Descriptions...: 付款單號+項次資訊帶出
# Memo...........:
# Usage..........: aapt470_apdg002_carry(p_cmd)
# Input parameter: p_ac 項次
# Date & Author..: 2016/09/20 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt470_apdg002_carry(p_ac)
   DEFINE p_ac        LIKE type_t.num10
   DEFINE l_apde      RECORD
                      l_apde002   LIKE apde_t.apde002,
                      l_apde009   LIKE apde_t.apde009,
                      l_apde032   LIKE apde_t.apde032,
                      l_apde039   LIKE apde_t.apde039,
                      l_apde040   LIKE apde_t.apde040,
                      l_apde041   LIKE apde_t.apde041
                      END RECORD
   
   INITIALIZE l_apde.* TO NULL
   SELECT apde002,apde009,apde032,apde039,apde040,apde041
    INTO l_apde.*
    FROM apde_t
   WHERE apdeent   = g_enterprise
     AND apdeld    = g_apdf_m.apdfld
     AND apdedocno = g_apdg_d[p_ac].apdg001
     AND apdeseq   = g_apdg_d[p_ac].apdg002
   
   LET g_apdg_d[p_ac].apdg004 = l_apde.l_apde041
   LET g_apdg_d[p_ac].apdg005 = l_apde.l_apde039
   LET g_apdg_d[p_ac].apdg006 = l_apde.l_apde040
   LET g_apdg_d[p_ac].apdg007 = l_apde.l_apde032
   LET g_apdg_d[p_ac].apdg014 = l_apde.l_apde041
   LET g_apdg_d[p_ac].apdg015 = l_apde.l_apde039
   LET g_apdg_d[p_ac].apdg016 = l_apde.l_apde040
   LET g_apdg_d[p_ac].apdg017 = l_apde.l_apde032
   
END FUNCTION

 
{</section>}
 
