#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt410.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-10-15 10:53:38), PR版次:0002(2014-11-18 14:27:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: aapt410
#+ Description: 付款申請單維護作業
#+ Creator....: 03538(2014-09-21 18:26:03)
#+ Modifier...: 03538 -SD/PR- 03538
 
{</section>}
 
{<section id="aapt410.global" >}
#應用 t01 樣板自動產生(Version:74) 
#add-point:填寫註解說明 name="global.memo"
 
#end add-point
        
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point 
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_finance.inc"
#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apea_m        RECORD
       apeasite LIKE apea_t.apeasite, 
   apeasite_desc LIKE type_t.chr80, 
   apea003 LIKE apea_t.apea003, 
   apea003_desc LIKE type_t.chr80, 
   apeacomp LIKE apea_t.apeacomp, 
   apeacomp_desc LIKE type_t.chr80, 
   apeadocno LIKE apea_t.apeadocno, 
   apeadocno_desc LIKE type_t.chr80, 
   apea001 LIKE apea_t.apea001, 
   apeadocdt LIKE apea_t.apeadocdt, 
   apea005 LIKE apea_t.apea005, 
   apea005_desc LIKE type_t.chr80, 
   apea022 LIKE apea_t.apea022, 
   apeastus LIKE apea_t.apeastus, 
   apeald LIKE apea_t.apeald, 
   apea008 LIKE apea_t.apea008, 
   apea010 LIKE apea_t.apea010, 
   apea018 LIKE apea_t.apea018, 
   apea018_desc LIKE type_t.chr80, 
   apea007 LIKE apea_t.apea007, 
   apea009 LIKE apea_t.apea009, 
   apea015 LIKE apea_t.apea015, 
   apea015_desc LIKE type_t.chr80, 
   apea016 LIKE apea_t.apea016, 
   apeaownid LIKE apea_t.apeaownid, 
   apeaownid_desc LIKE type_t.chr80, 
   apeaowndp LIKE apea_t.apeaowndp, 
   apeaowndp_desc LIKE type_t.chr80, 
   apeacrtid LIKE apea_t.apeacrtid, 
   apeacrtid_desc LIKE type_t.chr80, 
   apeacrtdp LIKE apea_t.apeacrtdp, 
   apeacrtdp_desc LIKE type_t.chr80, 
   apeacrtdt LIKE apea_t.apeacrtdt, 
   apeamodid LIKE apea_t.apeamodid, 
   apeamodid_desc LIKE type_t.chr80, 
   apeamoddt LIKE apea_t.apeamoddt, 
   apeacnfid LIKE apea_t.apeacnfid, 
   apeacnfid_desc LIKE type_t.chr80, 
   apeacnfdt LIKE apea_t.apeacnfdt, 
   dummy3 LIKE type_t.chr80, 
   glaa001 LIKE type_t.chr10, 
   sum_apee1091 LIKE type_t.num20_6, 
   sum_apee1191 LIKE type_t.num20_6, 
   sum_apee1092 LIKE type_t.num20_6, 
   sum_apee1192 LIKE type_t.num20_6, 
   sum_apee1093 LIKE type_t.num20_6, 
   sum_apee1193 LIKE type_t.num20_6, 
   sum_apee1094 LIKE type_t.num20_6, 
   sum_apee1194 LIKE type_t.num20_6
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_apeb_d        RECORD
       apebseq LIKE apeb_t.apebseq, 
   apeb002 LIKE apeb_t.apeb002, 
   apeborga LIKE apeb_t.apeborga, 
   apeborga_desc LIKE type_t.chr80, 
   apeb003 LIKE apeb_t.apeb003, 
   apeb004 LIKE apeb_t.apeb004, 
   apeb005 LIKE apeb_t.apeb005, 
   apeb013 LIKE apeb_t.apeb013, 
   apeb013_desc LIKE type_t.chr80, 
   apeb008 LIKE apeb_t.apeb008, 
   apeb024 LIKE apeb_t.apeb024, 
   apeb015 LIKE apeb_t.apeb015, 
   apeb100 LIKE apeb_t.apeb100, 
   apeb109 LIKE apeb_t.apeb109, 
   apeb101 LIKE apeb_t.apeb101, 
   apeb119 LIKE apeb_t.apeb119, 
   apeb031 LIKE apeb_t.apeb031, 
   apebld LIKE apeb_t.apebld, 
   apebcomp LIKE apeb_t.apebcomp, 
   apebsite LIKE apeb_t.apebsite, 
   apeb001 LIKE apeb_t.apeb001
       END RECORD
PRIVATE TYPE type_g_apeb2_d RECORD
       apeeseq LIKE apee_t.apeeseq, 
   apeeorga LIKE apee_t.apeeorga, 
   apeeorga_desc LIKE type_t.chr80, 
   apee002 LIKE apee_t.apee002, 
   apee006 LIKE apee_t.apee006, 
   apee008 LIKE apee_t.apee008, 
   apee021 LIKE apee_t.apee021, 
   apee024 LIKE apee_t.apee024, 
   apee015 LIKE apee_t.apee015, 
   apee100 LIKE apee_t.apee100, 
   apee109 LIKE apee_t.apee109, 
   apee101 LIKE apee_t.apee101, 
   apee119 LIKE apee_t.apee119, 
   apee032 LIKE apee_t.apee032, 
   apee013 LIKE apee_t.apee013, 
   apee013_desc LIKE type_t.chr80, 
   apee014 LIKE apee_t.apee014, 
   apee010 LIKE apee_t.apee010, 
   apee009 LIKE apee_t.apee009, 
   apee039 LIKE apee_t.apee039, 
   apee040 LIKE apee_t.apee040, 
   apee011 LIKE apee_t.apee011, 
   apee012 LIKE apee_t.apee012, 
   apeecomp LIKE apee_t.apeecomp, 
   apeesite LIKE apee_t.apeesite, 
   apee005 LIKE apee_t.apee005, 
   apee001 LIKE apee_t.apee001, 
   apee038 LIKE apee_t.apee038
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_apeadocno LIKE apea_t.apeadocno
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ap_slip             LIKE ooba_t.ooba002           #應付帳款單單別
DEFINE g_fin_arg1            LIKE gzsz_t.gzsz002           #財務應用參數(定義於azzi991)D-FIN-3006--應付沖銷單性質
DEFINE g_para_data1          LIKE type_t.chr80             #S-FIN-3008-付款單直接產生銀存支付帳
DEFINE g_glaa001             LIKE glaa_t.glaa001           #本幣幣別
DEFINE g_glaa002             LIKE glaa_t.glaa002           #匯率參照表
DEFINE g_glaa005             LIKE glaa_t.glaa005           #現金變動參照表
DEFINE g_glaa024             LIKE glaa_t.glaa024           #單據別參照表
DEFINE g_glaa025             LIKE glaa_t.glaa025           #本幣採用匯率
DEFINE g_glaa026             LIKE glaa_t.glaa026           #幣別參照表

#end add-point
       
#模組變數(Module Variables)
DEFINE g_apea_m          type_g_apea_m
DEFINE g_apea_m_t        type_g_apea_m
DEFINE g_apea_m_o        type_g_apea_m
DEFINE g_apea_m_mask_o   type_g_apea_m #轉換遮罩前資料
DEFINE g_apea_m_mask_n   type_g_apea_m #轉換遮罩後資料
 
   DEFINE g_apeadocno_t LIKE apea_t.apeadocno
 
 
DEFINE g_apeb_d          DYNAMIC ARRAY OF type_g_apeb_d
DEFINE g_apeb_d_t        type_g_apeb_d
DEFINE g_apeb_d_o        type_g_apeb_d
DEFINE g_apeb_d_mask_o   DYNAMIC ARRAY OF type_g_apeb_d #轉換遮罩前資料
DEFINE g_apeb_d_mask_n   DYNAMIC ARRAY OF type_g_apeb_d #轉換遮罩後資料
DEFINE g_apeb2_d          DYNAMIC ARRAY OF type_g_apeb2_d
DEFINE g_apeb2_d_t        type_g_apeb2_d
DEFINE g_apeb2_d_o        type_g_apeb2_d
DEFINE g_apeb2_d_mask_o   DYNAMIC ARRAY OF type_g_apeb2_d #轉換遮罩前資料
DEFINE g_apeb2_d_mask_n   DYNAMIC ARRAY OF type_g_apeb2_d #轉換遮罩後資料
 
 
DEFINE g_browser         DYNAMIC ARRAY OF type_browser
DEFINE g_browser_f       DYNAMIC ARRAY OF type_browser
 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING
DEFINE g_wc2_table2   STRING
 
 
 
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
 
{<section id="aapt410.main" >}
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
   LET g_fin_arg1 = 'D-FIN-3006'
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT apeasite,'',apea003,'',apeacomp,'',apeadocno,'',apea001,apeadocdt,apea005, 
       '',apea022,apeastus,apeald,apea008,apea010,apea018,'',apea007,apea009,apea015,'',apea016,apeaownid, 
       '',apeaowndp,'',apeacrtid,'',apeacrtdp,'',apeacrtdt,apeamodid,'',apeamoddt,apeacnfid,'',apeacnfdt, 
       '','','','','','','','','',''", 
                      " FROM apea_t",
                      " WHERE apeaent= ? AND apeadocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt410_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.apeasite,t0.apea003,t0.apeacomp,t0.apeadocno,t0.apea001,t0.apeadocdt, 
       t0.apea005,t0.apea022,t0.apeastus,t0.apeald,t0.apea008,t0.apea010,t0.apea018,t0.apea007,t0.apea009, 
       t0.apea015,t0.apea016,t0.apeaownid,t0.apeaowndp,t0.apeacrtid,t0.apeacrtdp,t0.apeacrtdt,t0.apeamodid, 
       t0.apeamoddt,t0.apeacnfid,t0.apeacnfdt,t1.ooag011 ,t2.ooefl003 ,t3.ooag011 ,t4.ooefl003 ,t5.ooag011 , 
       t6.ooag011",
               " FROM apea_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.apeaownid  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.apeaowndp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.apeacrtid  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.apeacrtdp AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t5 ON t5.ooagent="||g_enterprise||" AND t5.ooag001=t0.apeamodid  ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.apeacnfid  ",
 
               " WHERE t0.apeaent = " ||g_enterprise|| " AND t0.apeadocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aapt410_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aapt410 WITH FORM cl_ap_formpath("aap",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aapt410_init()   
 
      #進入選單 Menu (="N")
      CALL aapt410_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aapt410
      
   END IF 
   
   CLOSE aapt410_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aapt410.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aapt410_init()
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('apeastus','13','N,Y,X')
 
      CALL cl_set_combo_scc('apea001','8507') 
   CALL cl_set_combo_scc('apeb002','8506') 
   CALL cl_set_combo_scc('apee002','8506') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #單頭
   CALL cl_set_combo_scc_part('apea001','8507','40')
   CALL cl_set_combo_scc('apea007','8324')
   #帳款明細單身   
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '1'") CLIPPED 
   CALL cl_set_combo_scc_part('apeb002','8506',l_str)
   #預設付款明細單身
   LET l_str = s_aap_get_acc_str('8506',"gzcb004 = '2'") CLIPPED
   CALL cl_set_combo_scc_part('apee002','8506',l_str)
   
   CALL cl_set_combo_scc('apee006','8310')

   #end add-point
   
   #初始化搜尋條件
   CALL aapt410_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aapt410.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aapt410_ui_dialog()
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
   
   #end add-point
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   #因應查詢方案進行處理
   IF g_default THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   ELSE
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF
   
   #action default動作
   #應用 a42 樣板自動產生(Version:3)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL aapt410_insert()
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
         INITIALIZE g_apea_m.* TO NULL
         CALL g_apeb_d.clear()
         CALL g_apeb2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aapt410_init()
      END IF
   
      CALL lib_cl_dlg.cl_dlg_before_display()
            
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
         #左側瀏覽頁簽
         DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTES(COUNT=g_header_cnt)
            BEFORE ROW
               #回歸舊筆數位置 (回到當時異動的筆數)
               LET g_current_idx = DIALOG.getCurrentRow("s_browse")
               IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
                  CALL DIALOG.setCurrentRow("s_browse",g_current_row)
                  LET g_current_idx = g_current_row
               END IF
               LET g_current_row = g_current_idx #目前指標
               LET g_current_sw = TRUE
         
               IF g_current_idx > g_browser.getLength() THEN
                  LET g_current_idx = g_browser.getLength()
               END IF 
               
               CALL aapt410_fetch('') # reload data
               LET l_ac = 1
               CALL aapt410_ui_detailshow() #Setting the current row 
         
               CALL aapt410_idx_chk()
               #NEXT FIELD apebseq
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_apeb_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt410_idx_chk()
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
               CALL aapt410_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_apeb2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aapt410_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[2] = l_ac
               CALL g_idx_group.addAttribute("'2',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"
               
               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在單身1則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_current_page = 2
               #顯示單身筆數
               CALL aapt410_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aapt410_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            LET g_current_idx = DIALOG.getCurrentRow("s_browse")
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               CALL DIALOG.setCurrentRow("s_browse",g_current_row)
               LET g_current_idx = g_current_row
            END IF
            
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
               CALL aapt410_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aapt410_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aapt410_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aapt410_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aapt410_set_act_visible()   
            CALL aapt410_set_act_no_visible()
            IF NOT (g_apea_m.apeadocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " apeaent = " ||g_enterprise|| " AND",
                                  " apeadocno = '", g_apea_m.apeadocno, "' "
 
               #填到對應位置
               CALL aapt410_browser_fill("")
            END IF
         
          
         #查詢方案選擇 
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apee_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  #組合g_wc2
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
 
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
               END IF
               CALL aapt410_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         #查詢方案選擇
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               CALL util.JSON.parse(ls_wc, la_wc)
               INITIALIZE g_wc, g_wc2,g_wc2_table1,g_wc2_extend TO NULL
               INITIALIZE g_wc2_table2 TO NULL
 
 
               FOR li_idx = 1 TO la_wc.getLength()
                  CASE
                     WHEN la_wc[li_idx].tableid = "apea_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apeb_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "apee_t" 
                        LET g_wc2_table2 = la_wc[li_idx].wc
 
 
                     WHEN la_wc[li_idx].tableid = "EXTENDWC"
                        LET g_wc2_extend = la_wc[li_idx].wc
                  END CASE
               END FOR
               IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1)
                  OR NOT cl_null(g_wc2_table2)
 
 
                  OR NOT cl_null(g_wc2_extend)
                  THEN
                  IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
                     LET g_wc2 = g_wc2_table1
                  END IF
                  IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
                  END IF
 
 
                  IF g_wc2_extend <> " 1=1" AND NOT cl_null(g_wc2_extend) THEN
                     LET g_wc2 = g_wc2 ," AND ", g_wc2_extend
                  END IF
                  IF g_wc2.subString(1,5) = " AND " THEN
                     LET g_wc2 = g_wc2.subString(6,g_wc2.getLength())
                  END IF
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL aapt410_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aapt410_fetch("F")
                  END IF
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
          
         #應用 a49 樣板自動產生(Version:4)
            #過濾瀏覽頁資料
            ON ACTION filter
               LET g_action_choice = "fetch"
               #add-point:filter action name="ui_dialog.action.filter"
               
               #end add-point
               CALL aapt410_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aapt410_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt410_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aapt410_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt410_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aapt410_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt410_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aapt410_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt410_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aapt410_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aapt410_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_apeb_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_apeb2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
            
         #瀏覽頁折疊
         ON ACTION worksheethidden   
            IF g_main_hidden THEN
               CALL gfrm_curr.setElementHidden("mainlayout",0)
               CALL gfrm_curr.setElementHidden("worksheet",1)
               LET g_main_hidden = 0
            ELSE
               CALL gfrm_curr.setElementHidden("mainlayout",1)
               CALL gfrm_curr.setElementHidden("worksheet",0)
               LET g_main_hidden = 1
            END IF
            IF lb_first THEN
               LET lb_first = FALSE
               NEXT FIELD apebseq
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
         ON ACTION aapi060
            LET g_action_choice="aapi060"
            IF cl_auth_chk_act("aapi060") THEN
               
               #add-point:ON ACTION aapi060 name="menu.aapi060"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL aapt410_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aapt410_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL aapt410_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aapt410_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt410_09
            LET g_action_choice="open_aapt410_09"
            IF cl_auth_chk_act("open_aapt410_09") THEN
               
               #add-point:ON ACTION open_aapt410_09 name="menu.open_aapt410_09"
               #未確認才有用
               LET g_apea_m.apeastus = NULL
               SELECT apeastus INTO g_apea_m.apeastus FROM apea_t
                WHERE apeaent = g_enterprise
                  AND apeald  = g_apea_m.apeald
                  AND apeadocno = g_apea_m.apeadocno
               IF NOT cl_null(g_apea_m.apeastus) AND (g_apea_m.apeastus <> 'Y' OR g_apea_m.apeastus <> 'X') THEN                  
                  CALL aapt410_open_aapt410_09()RETURNING g_sub_success
                  CALL aapt410_show()
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/aap/aapt410_rep.4gl"
               #add-point:ON ACTION output.after
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL aapt410_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt400_05
            LET g_action_choice="open_aapt400_05"
            IF cl_auth_chk_act("open_aapt400_05") THEN
               
               #add-point:ON ACTION open_aapt400_05 name="menu.open_aapt400_05"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aapt410_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aapt410_01
            LET g_action_choice="open_aapt410_01"
            IF cl_auth_chk_act("open_aapt410_01") THEN
               
               #add-point:ON ACTION open_aapt410_01 name="menu.open_aapt410_01"
               
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aapt410_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aapt410_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aapt410_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_apea_m.apeadocdt)
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
    
         #交談指令共用ACTION
         &include "common_action.4gl" 
            CONTINUE DIALOG
      END DIALOG
    
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         #add-point:ui_dialog段離開dialog前 name="ui_dialog.b_exit"
         
         #end add-point
         EXIT WHILE
      END IF
    
   END WHILE    
      
   CALL cl_set_act_visible("accept,cancel", TRUE)
    
END FUNCTION
 
{</section>}
 
{<section id="aapt410.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aapt410_browser_fill(ps_page_action)
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
      LET l_sub_sql = " SELECT DISTINCT apeadocno ",
                      " FROM apea_t ",
                      " ",
                      " LEFT JOIN apeb_t ON apebent = apeaent AND apeadocno = apebdocno ", "  ",
                      #add-point:browser_fill段sql(apeb_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN apee_t ON apeeent = apeaent AND apeadocno = apeedocno", "  ",
                      #add-point:browser_fill段sql(apee_t1) name="browser_fill.cnt.join.apee_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE apeaent = " ||g_enterprise|| " AND apebent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("apea_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT apeadocno ",
                      " FROM apea_t ", 
                      "  ",
                      "  ",
                      " WHERE apeaent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("apea_t")
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
         LET g_errparam.code   = 9035 
         LET g_errparam.popup  = TRUE 
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
      INITIALIZE g_apea_m.* TO NULL
      CALL g_apeb_d.clear()        
      CALL g_apeb2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.apeadocno Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apeastus,t0.apeadocno ",
                  " FROM apea_t t0",
                  "  ",
                  "  LEFT JOIN apeb_t ON apebent = apeaent AND apeadocno = apebdocno ", "  ", 
                  #add-point:browser_fill段sql(apeb_t1) name="browser_fill.join.apeb_t1"
                  
                  #end add-point
                  "  LEFT JOIN apee_t ON apeeent = apeaent AND apeadocno = apeedocno", "  ", 
                  #add-point:browser_fill段sql(apee_t1) name="browser_fill.join.apee_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                  
                  " WHERE t0.apeaent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("apea_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.apeastus,t0.apeadocno ",
                  " FROM apea_t t0",
                  "  ",
                  
                  " WHERE t0.apeaent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("apea_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY apeadocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"apea_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_apeadocno
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         
         #end add-point
      
         #遮罩相關處理
         CALL aapt410_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_apeadocno) THEN
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
 
{<section id="aapt410.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aapt410_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_apea_m.apeadocno = g_browser[g_current_idx].b_apeadocno   
 
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
   CALL aapt410_apea_t_mask()
   CALL aapt410_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aapt410.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aapt410_ui_detailshow()
   #add-point:ui_detailshow段define(客製用) name="ui_detailshow.define_customerization"
   
   #end add-point    
   #add-point:ui_detailshow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
 
   #add-point:Function前置處理 name="ui_detailshow.before"
   
   #end add-point    
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aapt410_ui_browser_refresh()
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
      IF g_browser[l_i].b_apeadocno = g_apea_m.apeadocno 
 
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
 
{<section id="aapt410.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aapt410_construct()
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
   DEFINE l_apeb002   LIKE apeb_t.apeb002
   #end add-point    
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
    
   #清除畫面
   CLEAR FORM                
   INITIALIZE g_apea_m.* TO NULL
   CALL g_apeb_d.clear()        
   CALL g_apeb2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
   INITIALIZE g_wc2_table2 TO NULL
 
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
 
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON apeasite,apea003,apeacomp,apeadocno,apea001,apeadocdt,apea005,apeastus, 
          apea008,apea010,apea018,apea007,apea009,apea015,apea016,apeaownid,apeaowndp,apeacrtid,apeacrtdp, 
          apeacrtdt,apeamodid,apeamoddt,apeacnfid,apeacnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<apeacrtdt>>----
         AFTER FIELD apeacrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<apeamoddt>>----
         AFTER FIELD apeamoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apeacnfdt>>----
         AFTER FIELD apeacnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<apeapstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.apeasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeasite
            #add-point:ON ACTION controlp INFIELD apeasite name="construct.c.apeasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeasite  #顯示到畫面上
            NEXT FIELD apeasite                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeasite
            #add-point:BEFORE FIELD apeasite name="construct.b.apeasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeasite
            
            #add-point:AFTER FIELD apeasite name="construct.a.apeasite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea003
            #add-point:BEFORE FIELD apea003 name="construct.b.apea003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea003
            
            #add-point:AFTER FIELD apea003 name="construct.a.apea003"
 
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea003
            #add-point:ON ACTION controlp INFIELD apea003 name="construct.c.apea003"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO apea003      #顯示到畫面上
            NEXT FIELD apea003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacomp
            #add-point:BEFORE FIELD apeacomp name="construct.b.apeacomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeacomp
            
            #add-point:AFTER FIELD apeacomp name="construct.a.apeacomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeacomp
            #add-point:ON ACTION controlp INFIELD apeacomp name="construct.c.apeacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeacomp  #顯示到畫面上
            NEXT FIELD apeacomp
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeadocno
            #add-point:BEFORE FIELD apeadocno name="construct.b.apeadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeadocno
            
            #add-point:AFTER FIELD apeadocno name="construct.a.apeadocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeadocno
            #add-point:ON ACTION controlp INFIELD apeadocno name="construct.c.apeadocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apeadocno()
            DISPLAY g_qryparam.return1 TO apeadocno
            NEXT FIELD apeadocno
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea001
            #add-point:BEFORE FIELD apea001 name="construct.b.apea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea001
            
            #add-point:AFTER FIELD apea001 name="construct.a.apea001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea001
            #add-point:ON ACTION controlp INFIELD apea001 name="construct.c.apea001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeadocdt
            #add-point:BEFORE FIELD apeadocdt name="construct.b.apeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeadocdt
            
            #add-point:AFTER FIELD apeadocdt name="construct.a.apeadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeadocdt
            #add-point:ON ACTION controlp INFIELD apeadocdt name="construct.c.apeadocdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea005
            #add-point:BEFORE FIELD apea005 name="construct.b.apea005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea005
            
            #add-point:AFTER FIELD apea005 name="construct.a.apea005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea005
            #add-point:ON ACTION controlp INFIELD apea005 name="construct.c.apea005"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apca005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apea005  #顯示到畫面上
            NEXT FIELD apea005 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeastus
            #add-point:BEFORE FIELD apeastus name="construct.b.apeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeastus
            
            #add-point:AFTER FIELD apeastus name="construct.a.apeastus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeastus
            #add-point:ON ACTION controlp INFIELD apeastus name="construct.c.apeastus"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea008
            #add-point:BEFORE FIELD apea008 name="construct.b.apea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea008
            
            #add-point:AFTER FIELD apea008 name="construct.a.apea008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea008
            #add-point:ON ACTION controlp INFIELD apea008 name="construct.c.apea008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea010
            #add-point:BEFORE FIELD apea010 name="construct.b.apea010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea010
            
            #add-point:AFTER FIELD apea010 name="construct.a.apea010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea010
            #add-point:ON ACTION controlp INFIELD apea010 name="construct.c.apea010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea018
            #add-point:BEFORE FIELD apea018 name="construct.b.apea018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea018
            
            #add-point:AFTER FIELD apea018 name="construct.a.apea018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea018
            #add-point:ON ACTION controlp INFIELD apea018 name="construct.c.apea018"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apea018  #顯示到畫面上
            NEXT FIELD apea018                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea007
            #add-point:BEFORE FIELD apea007 name="construct.b.apea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea007
            
            #add-point:AFTER FIELD apea007 name="construct.a.apea007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea007
            #add-point:ON ACTION controlp INFIELD apea007 name="construct.c.apea007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea009
            #add-point:BEFORE FIELD apea009 name="construct.b.apea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea009
            
            #add-point:AFTER FIELD apea009 name="construct.a.apea009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea009
            #add-point:ON ACTION controlp INFIELD apea009 name="construct.c.apea009"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apea009()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apea009      #顯示到畫面上
            NEXT FIELD apea009 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea015
            #add-point:BEFORE FIELD apea015 name="construct.b.apea015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea015
            
            #add-point:AFTER FIELD apea015 name="construct.a.apea015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea015
            #add-point:ON ACTION controlp INFIELD apea015 name="construct.c.apea015"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3115"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apea015  #顯示到畫面上
            NEXT FIELD apea015                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea016
            #add-point:BEFORE FIELD apea016 name="construct.b.apea016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea016
            
            #add-point:AFTER FIELD apea016 name="construct.a.apea016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apea016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea016
            #add-point:ON ACTION controlp INFIELD apea016 name="construct.c.apea016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apeaownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeaownid
            #add-point:ON ACTION controlp INFIELD apeaownid name="construct.c.apeaownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeaownid  #顯示到畫面上
            NEXT FIELD apeaownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeaownid
            #add-point:BEFORE FIELD apeaownid name="construct.b.apeaownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeaownid
            
            #add-point:AFTER FIELD apeaownid name="construct.a.apeaownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeaowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeaowndp
            #add-point:ON ACTION controlp INFIELD apeaowndp name="construct.c.apeaowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeaowndp  #顯示到畫面上
            NEXT FIELD apeaowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeaowndp
            #add-point:BEFORE FIELD apeaowndp name="construct.b.apeaowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeaowndp
            
            #add-point:AFTER FIELD apeaowndp name="construct.a.apeaowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeacrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeacrtid
            #add-point:ON ACTION controlp INFIELD apeacrtid name="construct.c.apeacrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeacrtid  #顯示到畫面上
            NEXT FIELD apeacrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacrtid
            #add-point:BEFORE FIELD apeacrtid name="construct.b.apeacrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeacrtid
            
            #add-point:AFTER FIELD apeacrtid name="construct.a.apeacrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.apeacrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeacrtdp
            #add-point:ON ACTION controlp INFIELD apeacrtdp name="construct.c.apeacrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeacrtdp  #顯示到畫面上
            NEXT FIELD apeacrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacrtdp
            #add-point:BEFORE FIELD apeacrtdp name="construct.b.apeacrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeacrtdp
            
            #add-point:AFTER FIELD apeacrtdp name="construct.a.apeacrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacrtdt
            #add-point:BEFORE FIELD apeacrtdt name="construct.b.apeacrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apeamodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeamodid
            #add-point:ON ACTION controlp INFIELD apeamodid name="construct.c.apeamodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeamodid  #顯示到畫面上
            NEXT FIELD apeamodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeamodid
            #add-point:BEFORE FIELD apeamodid name="construct.b.apeamodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeamodid
            
            #add-point:AFTER FIELD apeamodid name="construct.a.apeamodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeamoddt
            #add-point:BEFORE FIELD apeamoddt name="construct.b.apeamoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.apeacnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeacnfid
            #add-point:ON ACTION controlp INFIELD apeacnfid name="construct.c.apeacnfid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeacnfid  #顯示到畫面上
            NEXT FIELD apeacnfid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacnfid
            #add-point:BEFORE FIELD apeacnfid name="construct.b.apeacnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeacnfid
            
            #add-point:AFTER FIELD apeacnfid name="construct.a.apeacnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacnfdt
            #add-point:BEFORE FIELD apeacnfdt name="construct.b.apeacnfdt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON apebseq,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013,apeb008,apeb024, 
          apeb015,apeb100,apeb109,apeb101,apeb119,apeb031
           FROM s_detail1[1].apebseq,s_detail1[1].apeb002,s_detail1[1].apeborga,s_detail1[1].apeb003, 
               s_detail1[1].apeb004,s_detail1[1].apeb005,s_detail1[1].apeb013,s_detail1[1].apeb008,s_detail1[1].apeb024, 
               s_detail1[1].apeb015,s_detail1[1].apeb100,s_detail1[1].apeb109,s_detail1[1].apeb101,s_detail1[1].apeb119, 
               s_detail1[1].apeb031
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apebseq
            #add-point:BEFORE FIELD apebseq name="construct.b.page1.apebseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apebseq
            
            #add-point:AFTER FIELD apebseq name="construct.a.page1.apebseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apebseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apebseq
            #add-point:ON ACTION controlp INFIELD apebseq name="construct.c.page1.apebseq"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb002
            #add-point:BEFORE FIELD apeb002 name="construct.b.page1.apeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb002
            
            #add-point:AFTER FIELD apeb002 name="construct.a.page1.apeb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb002
            #add-point:ON ACTION controlp INFIELD apeb002 name="construct.c.page1.apeb002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apeborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeborga
            #add-point:ON ACTION controlp INFIELD apeborga name="construct.c.page1.apeborga"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeborga  #顯示到畫面上
            NEXT FIELD apeborga                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeborga
            #add-point:BEFORE FIELD apeborga name="construct.b.page1.apeborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeborga
            
            #add-point:AFTER FIELD apeborga name="construct.a.page1.apeborga"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb003
            #add-point:BEFORE FIELD apeb003 name="construct.b.page1.apeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb003
            
            #add-point:AFTER FIELD apeb003 name="construct.a.page1.apeb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb003
            #add-point:ON ACTION controlp INFIELD apeb003 name="construct.c.page1.apeb003"
            LET l_apeb002 = GET_FLDBUF(apeb002)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apeb_d[l_ac].apeb003
            CASE l_apeb002[1,1]
               WHEN '4'                     
                  CALL q_apcadocno_3()                                 
               WHEN '3'                     
                  CALL q_xrcadocno_8()      
               OTHERWISE
                  CALL q_apcadocno_3()
            END CASE                  
            LET g_apeb_d[l_ac].apeb003 = g_qryparam.return1       #將開窗取得的值回傳到變數
            NEXT FIELD apeb003
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb004
            #add-point:BEFORE FIELD apeb004 name="construct.b.page1.apeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb004
            
            #add-point:AFTER FIELD apeb004 name="construct.a.page1.apeb004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb004
            #add-point:ON ACTION controlp INFIELD apeb004 name="construct.c.page1.apeb004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb005
            #add-point:BEFORE FIELD apeb005 name="construct.b.page1.apeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb005
            
            #add-point:AFTER FIELD apeb005 name="construct.a.page1.apeb005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb005
            #add-point:ON ACTION controlp INFIELD apeb005 name="construct.c.page1.apeb005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb013
            #add-point:BEFORE FIELD apeb013 name="construct.b.page1.apeb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb013
            
            #add-point:AFTER FIELD apeb013 name="construct.a.page1.apeb013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb013
            #add-point:ON ACTION controlp INFIELD apeb013 name="construct.c.page1.apeb013"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_apca005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeb013  #顯示到畫面上
            NEXT FIELD apeb013
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apeb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb008
            #add-point:ON ACTION controlp INFIELD apeb008 name="construct.c.page1.apeb008"
  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb008
            #add-point:BEFORE FIELD apeb008 name="construct.b.page1.apeb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb008
            
            #add-point:AFTER FIELD apeb008 name="construct.a.page1.apeb008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb024
            #add-point:BEFORE FIELD apeb024 name="construct.b.page1.apeb024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb024
            
            #add-point:AFTER FIELD apeb024 name="construct.a.page1.apeb024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb024
            #add-point:ON ACTION controlp INFIELD apeb024 name="construct.c.page1.apeb024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb015
            #add-point:BEFORE FIELD apeb015 name="construct.b.page1.apeb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb015
            
            #add-point:AFTER FIELD apeb015 name="construct.a.page1.apeb015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb015
            #add-point:ON ACTION controlp INFIELD apeb015 name="construct.c.page1.apeb015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.apeb100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb100
            #add-point:ON ACTION controlp INFIELD apeb100 name="construct.c.page1.apeb100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeb100  #顯示到畫面上
            NEXT FIELD apeb100                     #返回原欄位
   
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb100
            #add-point:BEFORE FIELD apeb100 name="construct.b.page1.apeb100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb100
            
            #add-point:AFTER FIELD apeb100 name="construct.a.page1.apeb100"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb109
            #add-point:BEFORE FIELD apeb109 name="construct.b.page1.apeb109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb109
            
            #add-point:AFTER FIELD apeb109 name="construct.a.page1.apeb109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb109
            #add-point:ON ACTION controlp INFIELD apeb109 name="construct.c.page1.apeb109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb101
            #add-point:BEFORE FIELD apeb101 name="construct.b.page1.apeb101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb101
            
            #add-point:AFTER FIELD apeb101 name="construct.a.page1.apeb101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb101
            #add-point:ON ACTION controlp INFIELD apeb101 name="construct.c.page1.apeb101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb119
            #add-point:BEFORE FIELD apeb119 name="construct.b.page1.apeb119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb119
            
            #add-point:AFTER FIELD apeb119 name="construct.a.page1.apeb119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb119
            #add-point:ON ACTION controlp INFIELD apeb119 name="construct.c.page1.apeb119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb031
            #add-point:BEFORE FIELD apeb031 name="construct.b.page1.apeb031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb031
            
            #add-point:AFTER FIELD apeb031 name="construct.a.page1.apeb031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.apeb031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb031
            #add-point:ON ACTION controlp INFIELD apeb031 name="construct.c.page1.apeb031"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON apeeseq,apeeorga,apee002,apee006,apee008,apee021,apee024,apee015,apee100, 
          apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039,apee040,apee011,apee012 
 
           FROM s_detail2[1].apeeseq,s_detail2[1].apeeorga,s_detail2[1].apee002,s_detail2[1].apee006, 
               s_detail2[1].apee008,s_detail2[1].apee021,s_detail2[1].apee024,s_detail2[1].apee015,s_detail2[1].apee100, 
               s_detail2[1].apee109,s_detail2[1].apee101,s_detail2[1].apee119,s_detail2[1].apee032,s_detail2[1].apee013, 
               s_detail2[1].apee014,s_detail2[1].apee010,s_detail2[1].apee009,s_detail2[1].apee039,s_detail2[1].apee040, 
               s_detail2[1].apee011,s_detail2[1].apee012
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeeseq
            #add-point:BEFORE FIELD apeeseq name="construct.b.page2.apeeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeeseq
            
            #add-point:AFTER FIELD apeeseq name="construct.a.page2.apeeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apeeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeeseq
            #add-point:ON ACTION controlp INFIELD apeeseq name="construct.c.page2.apeeseq"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apeeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeeorga
            #add-point:ON ACTION controlp INFIELD apeeorga name="construct.c.page2.apeeorga"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apeeorga  #顯示到畫面上
            NEXT FIELD apeeorga                     #返回原欄位
    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeeorga
            #add-point:BEFORE FIELD apeeorga name="construct.b.page2.apeeorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeeorga
            
            #add-point:AFTER FIELD apeeorga name="construct.a.page2.apeeorga"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee002
            #add-point:BEFORE FIELD apee002 name="construct.b.page2.apee002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee002
            
            #add-point:AFTER FIELD apee002 name="construct.a.page2.apee002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee002
            #add-point:ON ACTION controlp INFIELD apee002 name="construct.c.page2.apee002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee006
            #add-point:BEFORE FIELD apee006 name="construct.b.page2.apee006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee006
            
            #add-point:AFTER FIELD apee006 name="construct.a.page2.apee006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee006
            #add-point:ON ACTION controlp INFIELD apee006 name="construct.c.page2.apee006"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apee008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee008
            #add-point:ON ACTION controlp INFIELD apee008 name="construct.c.page2.apee008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apee008  #顯示到畫面上
            NEXT FIELD apee008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee008
            #add-point:BEFORE FIELD apee008 name="construct.b.page2.apee008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee008
            
            #add-point:AFTER FIELD apee008 name="construct.a.page2.apee008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee021
            #add-point:BEFORE FIELD apee021 name="construct.b.page2.apee021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee021
            
            #add-point:AFTER FIELD apee021 name="construct.a.page2.apee021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee021
            #add-point:ON ACTION controlp INFIELD apee021 name="construct.c.page2.apee021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee024
            #add-point:BEFORE FIELD apee024 name="construct.b.page2.apee024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee024
            
            #add-point:AFTER FIELD apee024 name="construct.a.page2.apee024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee024
            #add-point:ON ACTION controlp INFIELD apee024 name="construct.c.page2.apee024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee015
            #add-point:BEFORE FIELD apee015 name="construct.b.page2.apee015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee015
            
            #add-point:AFTER FIELD apee015 name="construct.a.page2.apee015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee015
            #add-point:ON ACTION controlp INFIELD apee015 name="construct.c.page2.apee015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apee100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee100
            #add-point:ON ACTION controlp INFIELD apee100 name="construct.c.page2.apee100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apee100  #顯示到畫面上
            NEXT FIELD apee100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee100
            #add-point:BEFORE FIELD apee100 name="construct.b.page2.apee100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee100
            
            #add-point:AFTER FIELD apee100 name="construct.a.page2.apee100"
 
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee109
            #add-point:BEFORE FIELD apee109 name="construct.b.page2.apee109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee109
            
            #add-point:AFTER FIELD apee109 name="construct.a.page2.apee109"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee109
            #add-point:ON ACTION controlp INFIELD apee109 name="construct.c.page2.apee109"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee101
            #add-point:BEFORE FIELD apee101 name="construct.b.page2.apee101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee101
            
            #add-point:AFTER FIELD apee101 name="construct.a.page2.apee101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee101
            #add-point:ON ACTION controlp INFIELD apee101 name="construct.c.page2.apee101"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee119
            #add-point:BEFORE FIELD apee119 name="construct.b.page2.apee119"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee119
            
            #add-point:AFTER FIELD apee119 name="construct.a.page2.apee119"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee119
            #add-point:ON ACTION controlp INFIELD apee119 name="construct.c.page2.apee119"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee032
            #add-point:BEFORE FIELD apee032 name="construct.b.page2.apee032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee032
            
            #add-point:AFTER FIELD apee032 name="construct.a.page2.apee032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee032
            #add-point:ON ACTION controlp INFIELD apee032 name="construct.c.page2.apee032"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee013
            #add-point:BEFORE FIELD apee013 name="construct.b.page2.apee013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee013
            
            #add-point:AFTER FIELD apee013 name="construct.a.page2.apee013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee013
            #add-point:ON ACTION controlp INFIELD apee013 name="construct.c.page2.apee013"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_2()
            DISPLAY g_qryparam.return1 TO apee013  #顯示到畫面上
            NEXT FIELD apee013
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee014
            #add-point:BEFORE FIELD apee014 name="construct.b.page2.apee014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee014
            
            #add-point:AFTER FIELD apee014 name="construct.a.page2.apee014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee014
            #add-point:ON ACTION controlp INFIELD apee014 name="construct.c.page2.apee014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee010
            #add-point:BEFORE FIELD apee010 name="construct.b.page2.apee010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee010
            
            #add-point:AFTER FIELD apee010 name="construct.a.page2.apee010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee010
            #add-point:ON ACTION controlp INFIELD apee010 name="construct.c.page2.apee010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "3005"
            CALL q_oocq002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO apee010  #顯示到畫面上
            NEXT FIELD apee010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee009
            #add-point:BEFORE FIELD apee009 name="construct.b.page2.apee009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee009
            
            #add-point:AFTER FIELD apee009 name="construct.a.page2.apee009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee009
            #add-point:ON ACTION controlp INFIELD apee009 name="construct.c.page2.apee009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee039
            #add-point:BEFORE FIELD apee039 name="construct.b.page2.apee039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee039
            
            #add-point:AFTER FIELD apee039 name="construct.a.page2.apee039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee039
            #add-point:ON ACTION controlp INFIELD apee039 name="construct.c.page2.apee039"
 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee040
            #add-point:BEFORE FIELD apee040 name="construct.b.page2.apee040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee040
            
            #add-point:AFTER FIELD apee040 name="construct.a.page2.apee040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee040
            #add-point:ON ACTION controlp INFIELD apee040 name="construct.c.page2.apee040"
 
            #END add-point
 
 
         #Ctrlp:construct.c.page2.apee011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee011
            #add-point:ON ACTION controlp INFIELD apee011 name="construct.c.page2.apee011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaj001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apee011  #顯示到畫面上
            NEXT FIELD apee011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee011
            #add-point:BEFORE FIELD apee011 name="construct.b.page2.apee011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee011
            
            #add-point:AFTER FIELD apee011 name="construct.a.page2.apee011"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee012
            #add-point:BEFORE FIELD apee012 name="construct.b.page2.apee012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee012
            
            #add-point:AFTER FIELD apee012 name="construct.a.page2.apee012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.apee012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee012
            #add-point:ON ACTION controlp INFIELD apee012 name="construct.c.page2.apee012"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmai002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO apee012  #顯示到畫面上
            NEXT FIELD apee012                     #返回原欄位
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
      
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         
         #end add-point  
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
         IF NOT cl_null(ls_wc) THEN
            CALL util.JSON.parse(ls_wc, la_wc)
            INITIALIZE g_wc, g_wc2, g_wc2_table1, g_wc2_extend TO NULL
            INITIALIZE g_wc2_table2 TO NULL
 
 
            FOR li_idx = 1 TO la_wc.getLength()
               CASE
                  WHEN la_wc[li_idx].tableid = "apea_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apeb_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "apee_t" 
                     LET g_wc2_table2 = la_wc[li_idx].wc
 
 
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
   IF g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
   END IF
 
 
 
 
   
   #add-point:cs段結束前 name="cs.after_construct"
   LET g_wc = g_wc," AND apea022 = '",g_argv[01],"'",
                   " AND apea001 = '40' "
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aapt410_filter()
   #add-point:filter段define name="filter.define_customerization"
   
   #end add-point   
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="filter.pre_function"
   
   #end add-point
   
   #切換畫面
   IF NOT g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",1)
      CALL gfrm_curr.setElementHidden("worksheet",0)
      LET g_main_hidden = 1
   END IF   
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter.trim()
   LET g_wc_t = g_wc
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter_t, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON apeadocno
                          FROM s_browse[1].b_apeadocno
 
         BEFORE CONSTRUCT
               DISPLAY aapt410_filter_parser('apeadocno') TO s_browse[1].b_apeadocno
      
         #add-point:filter段cs_ctrl name="filter.cs_ctrl"
         
         #end add-point
      
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG 
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG
   
   END DIALOG
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = "   AND   ", g_wc_filter, "   "
      LET g_wc = g_wc , g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_wc = g_wc_t
   END IF
 
      CALL aapt410_filter_show('apeadocno')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aapt410_filter_parser(ps_field)
   #add-point:filter段define name="filter_parser.define_customerization"
   
   #end add-point    
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num10
   DEFINE li_tmp2    LIKE type_t.num10
   DEFINE ls_var     STRING
   #add-point:filter段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
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
 
{<section id="aapt410.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aapt410_filter_show(ps_field)
   DEFINE ps_field         STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
 
   LET ls_name = "formonly.b_", ps_field
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aapt410_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aapt410_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF   
   
   LET ls_wc = g_wc
   
   LET INT_FLAG = 0
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   ERROR ""
   
   #清除畫面及相關資料
   CLEAR FORM
   CALL g_browser.clear()       
   CALL g_apeb_d.clear()
   CALL g_apeb2_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aapt410_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aapt410_browser_fill("")
      CALL aapt410_fetch("")
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
   LET g_detail_idx_list[2] = 1
 
   LET g_error_show  = 1
   LET g_wc_filter   = ""
   LET l_ac = 1
   CALL FGL_SET_ARR_CURR(1)
      CALL aapt410_filter_show('apeadocno')
   CALL aapt410_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL aapt410_fetch("F") 
      #顯示單身筆數
      CALL aapt410_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aapt410_fetch(p_flag)
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
 
   CALL g_curr_diag.setCurrentRow("s_browse", g_current_idx) #設定browse 索引
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   
   CALL cl_navigator_setting( g_current_idx, g_browser_cnt )
 
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_browser_idx = g_browser.getLength()
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_apea_m.apeadocno = g_browser[g_current_idx].b_apeadocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
   #遮罩相關處理
   LET g_apea_m_mask_o.* =  g_apea_m.*
   CALL aapt410_apea_t_mask()
   LET g_apea_m_mask_n.* =  g_apea_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt410_set_act_visible()   
   CALL aapt410_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   CALL cl_set_act_visible("modify,delete,modify_detail", TRUE)
   IF g_apea_m.apeastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apea_m_t.* = g_apea_m.*
   LET g_apea_m_o.* = g_apea_m.*
   
   LET g_data_owner = g_apea_m.apeaownid      
   LET g_data_dept  = g_apea_m.apeaowndp
   
   #重新顯示   
   CALL aapt410_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.insert" >}
#+ 資料新增
PRIVATE FUNCTION aapt410_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   DEFINE l_count   LIKE type_t.num5
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_apeb_d.clear()   
   CALL g_apeb2_d.clear()  
 
 
   INITIALIZE g_apea_m.* LIKE apea_t.*             #DEFAULT 設定
   
   LET g_apeadocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apea_m.apeaownid = g_user
      LET g_apea_m.apeaowndp = g_dept
      LET g_apea_m.apeacrtid = g_user
      LET g_apea_m.apeacrtdp = g_dept 
      LET g_apea_m.apeacrtdt = cl_get_current()
      LET g_apea_m.apeamodid = g_user
      LET g_apea_m.apeamoddt = cl_get_current()
      LET g_apea_m.apeastus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_apea_m.apea016 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_apea_m.apeastus = 'N'
      LET g_apea_m.apeadocdt = g_today
      LET g_apea_m.apea001   = '40'
      LET g_apea_m.apea003   = g_user
      LET g_apea_m.apea007 = '0'   #人員輸入
      LET g_apea_m.apea022 = g_argv[01]      

      #資金中心
      #取得預設的資金中心,因新增階段的時候,並不會知道site,所以以登入人員做為依據
      CALL s_fin_get_account_center('',g_user,'6',g_apea_m.apeadocdt) RETURNING g_sub_success,g_apea_m.apeasite,g_errno
      CALL s_desc_get_department_desc(g_apea_m.apeasite) RETURNING g_apea_m.apeasite_desc
      #有g_ld,先做帳務中心及g_ld的勾稽,登入人員帳務人員時,基本上會有該g_ld的帳務中心權限
      IF NOT cl_null(g_glaald) THEN
         #帳務中心與帳別勾稽
         CALL s_fin_account_center_with_ld_chk(g_apea_m.apeasite,g_glaald,g_user,'6','N','',g_apea_m.apeadocdt) RETURNING g_sub_success,g_errno
      END IF
     #該帳務中心與帳別無法勾稽到,以登入人員g_user取得預設帳別/法人
      IF NOT g_sub_success OR cl_null(g_glaald) THEN
         CALL s_fin_ld_carry('',g_user) RETURNING g_sub_success,g_apea_m.apeald,g_apea_m.apeacomp,g_errno
         CALL s_fin_account_center_with_ld_chk(g_apea_m.apeasite,g_apea_m.apeald,g_user,'6','N','',g_apea_m.apeadocdt) RETURNING g_sub_success,g_errno
         LET l_count = NULL
         SELECT COUNT(*) INTO l_count FROM glaa_t
          WHERE glaaent = g_enterprise
            AND glaald = g_apea_m.apeald
            AND glaacomp = g_apea_m.apeacomp
            AND glaa014 = 'Y'
         IF cl_null(l_count)THEN LET l_count = 0 END IF
         IF l_count = 0 THEN
            LET g_apea_m.apeacomp = ''
            LET g_apea_m.apeald = ''
         END IF
      END IF

      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_apea_m_t.* = g_apea_m.*
      LET g_apea_m_o.* = g_apea_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apea_m.apeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aapt410_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
      
      IF NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_apea_m.* TO NULL
         INITIALIZE g_apeb_d TO NULL
         INITIALIZE g_apeb2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aapt410_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_apeb_d.clear()
      #CALL g_apeb2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt410_set_act_visible()   
   CALL aapt410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apeadocno_t = g_apea_m.apeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apeaent = " ||g_enterprise|| " AND",
                      " apeadocno = '", g_apea_m.apeadocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aapt410_cl
   
   CALL aapt410_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
   
   #遮罩相關處理
   LET g_apea_m_mask_o.* =  g_apea_m.*
   CALL aapt410_apea_t_mask()
   LET g_apea_m_mask_n.* =  g_apea_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc,g_apea_m.apea003,g_apea_m.apea003_desc,g_apea_m.apeacomp, 
       g_apea_m.apeacomp_desc,g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001,g_apea_m.apeadocdt, 
       g_apea_m.apea005,g_apea_m.apea005_desc,g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008, 
       g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea018_desc,g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015, 
       g_apea_m.apea015_desc,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp, 
       g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamodid_desc,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfid_desc,g_apea_m.apeacnfdt,g_apea_m.dummy3,g_apea_m.glaa001,g_apea_m.sum_apee1091, 
       g_apea_m.sum_apee1191,g_apea_m.sum_apee1092,g_apea_m.sum_apee1192,g_apea_m.sum_apee1093,g_apea_m.sum_apee1193, 
       g_apea_m.sum_apee1094,g_apea_m.sum_apee1194
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_apea_m.apeaownid      
   LET g_data_dept  = g_apea_m.apeaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt410_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.modify" >}
#+ 資料修改
PRIVATE FUNCTION aapt410_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_apea_m_t.* = g_apea_m.*
   LET g_apea_m_o.* = g_apea_m.*
   
   IF g_apea_m.apeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_apeadocno_t = g_apea_m.apeadocno
 
   CALL s_transaction_begin()
   
   OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
   #檢查是否允許此動作
   IF NOT aapt410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apea_m_mask_o.* =  g_apea_m.*
   CALL aapt410_apea_t_mask()
   LET g_apea_m_mask_n.* =  g_apea_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL aapt410_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_apeadocno_t = g_apea_m.apeadocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_apea_m.apeamodid = g_user 
LET g_apea_m.apeamoddt = cl_get_current()
LET g_apea_m.apeamodid_desc = cl_get_username(g_apea_m.apeamodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aapt410_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #「D抽單 / R已拒絕」狀況碼更改資料後，需還原為「N未確認」
      IF g_apea_m.apeastus MATCHES "[DR]" THEN 
         LET g_apea_m.apeastus = "N"
      END IF
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE apea_t SET (apeamodid,apeamoddt) = (g_apea_m.apeamodid,g_apea_m.apeamoddt)
          WHERE apeaent = g_enterprise AND apeadocno = g_apeadocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_apea_m.* = g_apea_m_t.*
            CALL aapt410_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_apea_m.apeadocno != g_apea_m_t.apeadocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE apeb_t SET apebdocno = g_apea_m.apeadocno
 
          WHERE apebent = g_enterprise AND apebdocno = g_apea_m_t.apeadocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apeb_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         
         #add-point:單身fk修改後 name="modify.body.a_fk_update"
         
         #end add-point
         
         #更新單身key值
         #add-point:單身fk修改前 name="modify.body.b_fk_update2"
         
         #end add-point
         
         UPDATE apee_t
            SET apeedocno = g_apea_m.apeadocno
 
          WHERE apeeent = g_enterprise AND
                apeedocno = g_apeadocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "apee_t" 
            #   LET g_errparam.code   = "std-00009" 
            #   LET g_errparam.popup  = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
         END CASE
         #add-point:單身fk修改後 name="modify.body.a_fk_update2"
         
         #end add-point
 
 
         
 
         
         #UPDATE 多語言table key值
         
         
 
         CALL s_transaction_end('Y','0')
      END IF
    
      EXIT WHILE
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt410_set_act_visible()   
   CALL aapt410_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " apeaent = " ||g_enterprise|| " AND",
                      " apeadocno = '", g_apea_m.apeadocno, "' "
 
   #填到對應位置
   CALL aapt410_browser_fill("")
 
   CLOSE aapt410_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt410_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aapt410.input" >}
#+ 資料輸入
PRIVATE FUNCTION aapt410_input(p_cmd)
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
   DEFINE  l_apeborga_comp       LIKE glaa_t.glaacomp
   DEFINE  l_apeborga_ld         LIKE glaa_t.glaald
   DEFINE  l_glaa001             LIKE glaa_t.glaa001
   DEFINE  l_apcc_used           RECORD
                                 apcc10x    LIKE type_t.num20_6,
                                 apcc11x    LIKE type_t.num20_6
                                 END RECORD   
   DEFINE  l_nmag002             LIKE nmag_t.nmag002
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
   DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc,g_apea_m.apea003,g_apea_m.apea003_desc,g_apea_m.apeacomp, 
       g_apea_m.apeacomp_desc,g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001,g_apea_m.apeadocdt, 
       g_apea_m.apea005,g_apea_m.apea005_desc,g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008, 
       g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea018_desc,g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015, 
       g_apea_m.apea015_desc,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp, 
       g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamodid_desc,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfid_desc,g_apea_m.apeacnfdt,g_apea_m.dummy3,g_apea_m.glaa001,g_apea_m.sum_apee1091, 
       g_apea_m.sum_apee1191,g_apea_m.sum_apee1092,g_apea_m.sum_apee1192,g_apea_m.sum_apee1093,g_apea_m.sum_apee1193, 
       g_apea_m.sum_apee1094,g_apea_m.sum_apee1194
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql name="input.define_sql"
   
   #end add-point 
   LET g_forupd_sql = "SELECT apebseq,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013,apeb008,apeb024, 
       apeb015,apeb100,apeb109,apeb101,apeb119,apeb031,apebld,apebcomp,apebsite,apeb001 FROM apeb_t  
       WHERE apebent=? AND apebdocno=? AND apebseq=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt410_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point    
   LET g_forupd_sql = "SELECT apeeseq,apeeorga,apee002,apee006,apee008,apee021,apee024,apee015,apee100, 
       apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039,apee040,apee011,apee012, 
       apeecomp,apeesite,apee005,apee001,apee038 FROM apee_t WHERE apeeent=? AND apeedocno=? AND apeeseq=?  
       FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aapt410_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aapt410_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aapt410_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apea003,g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001, 
       g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apeastus,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018, 
       g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aapt410.input.head" >}
      #單頭段
      INPUT BY NAME g_apea_m.apeasite,g_apea_m.apea003,g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001, 
          g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apeastus,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018, 
          g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt410_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE aapt410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aapt410_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
 
            #end add-point
            CALL aapt410_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeasite
            
            #add-point:AFTER FIELD apeasite name="input.a.apeasite"
            LET g_apea_m.apeasite_desc = ' '
            DISPLAY BY NAME g_apea_m.apeasite_desc
            IF NOT cl_null(g_apea_m.apeasite) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apeasite != g_apea_m_t.apeasite OR g_apea_m_t.apeasite IS NULL )) THEN
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apea_m.apeasite
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     #檢查失敗時後續處理
                     LET g_apea_m.apeasite = g_apea_m_t.apeasite
                     LET g_apea_m.apeasite_desc = s_desc_get_department_desc(g_apea_m.apeasite)
                     DISPLAY BY NAME g_apea_m.apeasite_desc
                     NEXT FIELD CURRENT
                  END IF

#                  CALL s_fin_account_center_with_ld_chk(g_apea_m.apeasite,g_glaald,g_user,'6','Y','',g_today)
#                    RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = g_errno
#                     LET g_errparam.extend = ''
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_apea_m.apeasite = g_apea_m_t.apeasite
#                     LET g_apea_m.apeasite_desc = s_desc_get_department_desc(g_apea_m.apeasite)
#                     DISPLAY BY NAME g_apea_m.apeasite_desc
#                     NEXT FIELD CURRENT
#                  END IF
                  #取得S-FIN-3008參數
                  CALL cl_get_para(g_enterprise,g_apea_m.apeasite,'S-FIN-3008') RETURNING g_para_data1
                  #取得所屬法人+帳別
                  CALL s_fin_orga_get_comp_ld(g_apea_m.apeasite) RETURNING g_sub_success,g_errno,g_apea_m.apeacomp,g_apea_m.apeald
                  CALL s_ld_sel_glaa(g_apea_m.apeald,'glaa001|glaa002|glaa005|glaa024|glaa025|glaa026')
                       RETURNING  g_sub_success,g_glaa001,g_glaa002,g_glaa005,g_glaa024,g_glaa025,g_glaa026 
                  LET g_apea_m.glaa001 = g_glaa001     
                  #法人名稱                  
                  LET g_apea_m.apeacomp_desc = s_desc_get_department_desc(g_apea_m.apeacomp)
                  DISPLAY BY NAME g_apea_m.apeacomp_desc,g_apea_m.glaa001                                    
               END IF
            END IF           
            LET g_apea_m.apeasite_desc = s_desc_get_department_desc(g_apea_m.apeasite)
            DISPLAY BY NAME g_apea_m.apeasite_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeasite
            #add-point:BEFORE FIELD apeasite name="input.b.apeasite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeasite
            #add-point:ON CHANGE apeasite name="input.g.apeasite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea003
            
            #add-point:AFTER FIELD apea003 name="input.a.apea003"
            LET g_apea_m.apea003_desc = ' '
            DISPLAY BY NAME g_apea_m.apea003_desc
            IF NOT cl_null(g_apea_m.apea003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apea003 != g_apea_m_t.apea003 OR g_apea_m_t.apea003 IS NULL )) THEN
                  CALL s_aap_ooag001_chk(g_apea_m.apea003) RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apea_m.apea003 = g_apea_m_t.apea003
                     LET g_apea_m.apea003_desc = s_desc_get_person_desc(g_apea_m.apea003)
                     DISPLAY BY NAME g_apea_m.apea003_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            LET g_apea_m.apea003_desc = s_desc_get_person_desc(g_apea_m.apea003)
            DISPLAY BY NAME g_apea_m.apea003_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea003
            #add-point:BEFORE FIELD apea003 name="input.b.apea003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea003
            #add-point:ON CHANGE apea003 name="input.g.apea003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeacomp
            
            #add-point:AFTER FIELD apeacomp name="input.a.apeacomp"
            LET g_apea_m.apeacomp_desc = ' '
            DISPLAY BY NAME g_apea_m.apeacomp_desc
            IF NOT cl_null(g_apea_m.apeacomp) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apeacomp != g_apea_m_t.apeacomp OR g_apea_m_t.apeacomp IS NULL )) THEN
                  CALL s_fin_comp_chk(g_apea_m.apeacomp) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apea_m.apeacomp = g_apea_m_t.apeacomp
                     LET g_apea_m.apeacomp_desc = s_desc_get_department_desc(g_apea_m.apeacomp)
                     DISPLAY BY NAME g_apea_m.apeacomp_desc
                     NEXT FIELD CURRENT
                  END IF               
                  CALL s_fin_get_major_ld(g_apea_m.apeacomp) RETURNING g_apea_m.apeald               
                  CALL s_ld_sel_glaa(g_apea_m.apeald,'glaa001|glaa002|glaa005|glaa024|glaa025|glaa026')
                       RETURNING  g_sub_success,g_glaa001,g_glaa002,g_glaa005,g_glaa024,g_glaa025,g_glaa026   
                  LET g_apea_m.glaa001 = g_glaa001
                  DISPLAY BY NAME g_apea_m.glaa001                  
               END IF
            END IF           
            LET g_apea_m.apeacomp_desc = s_desc_get_department_desc(g_apea_m.apeacomp)
            DISPLAY BY NAME g_apea_m.apeacomp_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeacomp
            #add-point:BEFORE FIELD apeacomp name="input.b.apeacomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeacomp
            #add-point:ON CHANGE apeacomp name="input.g.apeacomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeadocno
            
            #add-point:AFTER FIELD apeadocno name="input.a.apeadocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_apea_m.apeadocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apea_m.apeadocno != g_apeadocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apea_t WHERE "||"apeaent = '" ||g_enterprise|| "' AND "||"apeadocno = '"||g_apea_m.apeadocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF            
            IF NOT cl_null(g_apea_m.apeadocno) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apeadocno != g_apea_m_t.apeadocno OR g_apea_m_t.apeadocno IS NULL )) THEN
                  LET g_errno = NULL
                  CALL s_fin_slip_chk(g_apea_m.apeadocno,g_prog,g_apea_m.apeald,'D-FIN-3006') RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apea_m.apeadocno = g_apea_m_t.apeadocno
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_aooi200_get_slip_desc(g_apea_m.apeadocno) RETURNING g_apea_m.apeadocno_desc
            DISPLAY BY NAME g_apea_m.apeadocno_desc            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeadocno
            #add-point:BEFORE FIELD apeadocno name="input.b.apeadocno"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeadocno
            #add-point:ON CHANGE apeadocno name="input.g.apeadocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea001
            #add-point:BEFORE FIELD apea001 name="input.b.apea001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea001
            
            #add-point:AFTER FIELD apea001 name="input.a.apea001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea001
            #add-point:ON CHANGE apea001 name="input.g.apea001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeadocdt
            #add-point:BEFORE FIELD apeadocdt name="input.b.apeadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeadocdt
            
            #add-point:AFTER FIELD apeadocdt name="input.a.apeadocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeadocdt
            #add-point:ON CHANGE apeadocdt name="input.g.apeadocdt"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea005
            
            #add-point:AFTER FIELD apea005 name="input.a.apea005"
            LET g_apea_m.apea005_desc = ' '
            DISPLAY BY NAME g_apea_m.apea005_desc
            IF NOT cl_null(g_apea_m.apea005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apea005 != g_apea_m_t.apea005 OR g_apea_m_t.apea005 IS NULL )) THEN
                  CALL s_aap_pmaa001_chk(g_apea_m.apea005) RETURNING g_sub_success,g_errno
                  IF NOT cl_null(g_errno)THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apea_m.apea005 = g_apea_m_t.apea005
                     LET g_apea_m.apea005_desc = s_desc_get_trading_partner_abbr_desc(g_apea_m.apea005)
                     DISPLAY BY NAME g_apea_m.apea005_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            LET g_apea_m.apea005_desc = s_desc_get_trading_partner_abbr_desc(g_apea_m.apea005)
            DISPLAY BY NAME g_apea_m.apea005_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea005
            #add-point:BEFORE FIELD apea005 name="input.b.apea005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea005
            #add-point:ON CHANGE apea005 name="input.g.apea005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeastus
            #add-point:BEFORE FIELD apeastus name="input.b.apeastus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeastus
            
            #add-point:AFTER FIELD apeastus name="input.a.apeastus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeastus
            #add-point:ON CHANGE apeastus name="input.g.apeastus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea008
            #add-point:BEFORE FIELD apea008 name="input.b.apea008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea008
            
            #add-point:AFTER FIELD apea008 name="input.a.apea008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea008
            #add-point:ON CHANGE apea008 name="input.g.apea008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea010
            #add-point:BEFORE FIELD apea010 name="input.b.apea010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea010
            
            #add-point:AFTER FIELD apea010 name="input.a.apea010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea010
            #add-point:ON CHANGE apea010 name="input.g.apea010"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea018
            
            #add-point:AFTER FIELD apea018 name="input.a.apea018"
            LET g_apea_m.apea018_desc = ' '
            DISPLAY BY NAME g_apea_m.apea018_desc
            IF NOT cl_null(g_apea_m.apea018) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apea_m.apea018 != g_apea_m_t.apea018 OR g_apea_m_t.apea018 IS NULL )) THEN
                  IF NOT NOT s_azzi650_chk_exist('3113',g_apea_m.apea018) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apea_m.apea018 = g_apea_m_t.apea018
                     LET g_apea_m.apea018_desc = s_desc_get_acc_desc('3113',g_apea_m.apea018)
                     DISPLAY BY NAME g_apea_m.apea018_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF           
            LET g_apea_m.apea018_desc = s_desc_get_acc_desc('3113',g_apea_m.apea018)
            DISPLAY BY NAME g_apea_m.apea018_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea018
            #add-point:BEFORE FIELD apea018 name="input.b.apea018"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea018
            #add-point:ON CHANGE apea018 name="input.g.apea018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea007
            #add-point:BEFORE FIELD apea007 name="input.b.apea007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea007
            
            #add-point:AFTER FIELD apea007 name="input.a.apea007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea007
            #add-point:ON CHANGE apea007 name="input.g.apea007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea009
            #add-point:BEFORE FIELD apea009 name="input.b.apea009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea009
            
            #add-point:AFTER FIELD apea009 name="input.a.apea009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea009
            #add-point:ON CHANGE apea009 name="input.g.apea009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apea015
            
            #add-point:AFTER FIELD apea015 name="input.a.apea015"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apea015
            #add-point:BEFORE FIELD apea015 name="input.b.apea015"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apea015
            #add-point:ON CHANGE apea015 name="input.g.apea015"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apeasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeasite
            #add-point:ON ACTION controlp INFIELD apeasite name="input.c.apeasite"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apea_m.apeasite       #給予default值
            CALL q_ooef001()                                #呼叫開窗
            LET g_apea_m.apeasite = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apea_m.apeasite) RETURNING g_apea_m.apeasite_desc
            DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc
            NEXT FIELD apeasite 

            #END add-point
 
 
         #Ctrlp:input.c.apea003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea003
            #add-point:ON ACTION controlp INFIELD apea003 name="input.c.apea003"
		     	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apea_m.apea003      #給予default值
            CALL q_ooag001()                                #呼叫開窗
            LET g_apea_m.apea003 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_person_desc(g_apea_m.apea003) RETURNING g_apea_m.apea003_desc
            DISPLAY BY NAME g_apea_m.apea003,g_apea_m.apea003_desc
            NEXT FIELD apea003  
            #END add-point
 
 
         #Ctrlp:input.c.apeacomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeacomp
            #add-point:ON ACTION controlp INFIELD apeacomp name="input.c.apeacomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apea_m.apeacomp       #給予default值
            CALL q_ooef001()                                #呼叫開窗
            LET g_apea_m.apeacomp = g_qryparam.return1        #將開窗取得的值回傳到變數
            CALL s_desc_get_department_desc(g_apea_m.apeacomp) RETURNING g_apea_m.apeacomp_desc
            DISPLAY BY NAME g_apea_m.apeacomp,g_apea_m.apeacomp_desc
            NEXT FIELD apeacomp 
            #END add-point
 
 
         #Ctrlp:input.c.apeadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeadocno
            #add-point:ON ACTION controlp INFIELD apeadocno name="input.c.apeadocno"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apea_m.apeadocno
            #給予arg
            LET g_qryparam.arg1 = g_glaa024
            LET g_qryparam.arg2 = g_prog

            CALL q_ooba002_1()                                #呼叫開窗
            LET g_apea_m.apeadocno = g_qryparam.return1
            CALL s_aooi200_get_slip_desc(g_apea_m.apeadocno) RETURNING g_apea_m.apeadocno_desc
            CALL s_aooi200_get_slip(g_apea_m.apeadocno) RETURNING g_sub_success,g_ap_slip
            CALL cl_get_doc_para(g_enterprise,g_apea_m.apeacomp,g_ap_slip,g_fin_arg1) RETURNING g_apea_m.apea001
            DISPLAY BY NAME g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001
            NEXT FIELD apeadocno            
            #END add-point
 
 
         #Ctrlp:input.c.apea001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea001
            #add-point:ON ACTION controlp INFIELD apea001 name="input.c.apea001"
            
            #END add-point
 
 
         #Ctrlp:input.c.apeadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeadocdt
            #add-point:ON ACTION controlp INFIELD apeadocdt name="input.c.apeadocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.apea005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea005
            #add-point:ON ACTION controlp INFIELD apea005 name="input.c.apea005"
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apea_m.apea005      #給予default值
            LET g_qryparam.where = " (pmaa002 ='1' OR pmaa002 ='3') AND (pmaa004 = '1' OR pmaa004 = '3')"
            CALL q_pmaa001()                                #呼叫開窗
            LET g_apea_m.apea005 = g_qryparam.return1       #將開窗取得的值回傳到變數
            CALL s_desc_get_trading_partner_abbr_desc(g_apea_m.apea005) RETURNING g_apea_m.apea005_desc
            DISPLAY BY NAME g_apea_m.apea005,g_apea_m.apea005_desc
            NEXT FIELD apea005     
            #END add-point
 
 
         #Ctrlp:input.c.apeastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeastus
            #add-point:ON ACTION controlp INFIELD apeastus name="input.c.apeastus"
            
            #END add-point
 
 
         #Ctrlp:input.c.apea008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea008
            #add-point:ON ACTION controlp INFIELD apea008 name="input.c.apea008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apea010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea010
            #add-point:ON ACTION controlp INFIELD apea010 name="input.c.apea010"
            
            #END add-point
 
 
         #Ctrlp:input.c.apea018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea018
            #add-point:ON ACTION controlp INFIELD apea018 name="input.c.apea018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apea_m.apea018             #給予default值
            LET g_qryparam.arg1 = "3113"
            CALL q_oocq002()                                #呼叫開窗

            LET g_apea_m.apea018 = g_qryparam.return1              
            DISPLAY g_apea_m.apea018 TO apea018              #
            NEXT FIELD apea018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.apea007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea007
            #add-point:ON ACTION controlp INFIELD apea007 name="input.c.apea007"
            
            #END add-point
 
 
         #Ctrlp:input.c.apea009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea009
            #add-point:ON ACTION controlp INFIELD apea009 name="input.c.apea009"
            CALL s_aooi390('15') RETURNING g_sub_success,g_apea_m.apea009
            DISPLAY BY NAME g_apea_m.apea009
            NEXT FIELD apea009
            #END add-point
 
 
         #Ctrlp:input.c.apea015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apea015
            #add-point:ON ACTION controlp INFIELD apea015 name="input.c.apea015"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apea_m.apea015             #給予default值
            LET g_qryparam.arg1 = "3115"
            CALL q_oocq002()                                #呼叫開窗

            LET g_apea_m.apea015 = g_qryparam.return1              
            DISPLAY g_apea_m.apea015 TO apea015              #
            NEXT FIELD apea015                          #返回原欄位
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_apea_m.apeadocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apeadocdt,g_prog)
                    RETURNING g_sub_success,g_apea_m.apeadocno
               IF g_sub_success  = 0  THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_apea_m.apeadocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD apeadocno
               END IF
               DISPLAY BY NAME g_apea_m.apeadocno          
               #end add-point
               
               INSERT INTO apea_t (apeaent,apeasite,apea003,apeacomp,apeadocno,apea001,apeadocdt,apea005, 
                   apea022,apeastus,apeald,apea008,apea010,apea018,apea007,apea009,apea015,apea016,apeaownid, 
                   apeaowndp,apeacrtid,apeacrtdp,apeacrtdt,apeamodid,apeamoddt,apeacnfid,apeacnfdt)
               VALUES (g_enterprise,g_apea_m.apeasite,g_apea_m.apea003,g_apea_m.apeacomp,g_apea_m.apeadocno, 
                   g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022,g_apea_m.apeastus, 
                   g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
                   g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp, 
                   g_apea_m.apeacrtid,g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt, 
                   g_apea_m.apeacnfid,g_apea_m.apeacnfdt) 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_apea_m:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
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
                  CALL aapt410_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aapt410_b_fill()
                  CALL aapt410_b_fill2('0')
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
               CALL aapt410_apea_t_mask_restore('restore_mask_o')
               
               UPDATE apea_t SET (apeasite,apea003,apeacomp,apeadocno,apea001,apeadocdt,apea005,apea022, 
                   apeastus,apeald,apea008,apea010,apea018,apea007,apea009,apea015,apea016,apeaownid, 
                   apeaowndp,apeacrtid,apeacrtdp,apeacrtdt,apeamodid,apeamoddt,apeacnfid,apeacnfdt) = (g_apea_m.apeasite, 
                   g_apea_m.apea003,g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt, 
                   g_apea_m.apea005,g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008, 
                   g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015, 
                   g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid,g_apea_m.apeacrtdp, 
                   g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid,g_apea_m.apeacnfdt) 
 
                WHERE apeaent = g_enterprise AND apeadocno = g_apeadocno_t
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "apea_t:",SQLERRMESSAGE 
                  LET g_errparam.code   = SQLCA.sqlcode 
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aapt410_apea_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_apea_m_t)
               LET g_log2 = util.JSON.stringify(g_apea_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_apeadocno_t = g_apea_m.apeadocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aapt410.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_apeb_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apeb_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt410_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_apeb_d.getLength()
            #add-point:資料輸入前 name="input.d.before_input"
            CALL aapt410_show()
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
            OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt410_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE aapt410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apeb_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apeb_d[l_ac].apebseq IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_apeb_d_t.* = g_apeb_d[l_ac].*  #BACKUP
               LET g_apeb_d_o.* = g_apeb_d[l_ac].*  #BACKUP
               CALL aapt410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               CALL aapt410_set_no_required()
               CALL aapt410_set_required()
               #end add-point  
               CALL aapt410_set_no_entry_b(l_cmd)
               IF NOT aapt410_lock_b("apeb_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt410_bcl INTO g_apeb_d[l_ac].apebseq,g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeborga, 
                      g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb013, 
                      g_apeb_d[l_ac].apeb008,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb015,g_apeb_d[l_ac].apeb100, 
                      g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031, 
                      g_apeb_d[l_ac].apebld,g_apeb_d[l_ac].apebcomp,g_apeb_d[l_ac].apebsite,g_apeb_d[l_ac].apeb001 
 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_apeb_d_t.apebseq,":",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apeb_d_mask_o[l_ac].* =  g_apeb_d[l_ac].*
                  CALL aapt410_apeb_t_mask()
                  LET g_apeb_d_mask_n[l_ac].* =  g_apeb_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt410_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd = 'u' THEN
               #取得來源組織所屬法人
               CALL s_fin_orga_get_comp_ld(g_apeb_d[l_ac].apeborga) RETURNING g_sub_success,g_errno,l_apeborga_comp,l_apeborga_ld
               CALL s_ld_sel_glaa(l_apeborga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001
            ELSE
               LET l_apeborga_comp= ''
               LET l_apeborga_ld= ''
               LET l_glaa001 = ''
            END IF
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
            INITIALIZE g_apeb_d[l_ac].* TO NULL 
            INITIALIZE g_apeb_d_t.* TO NULL 
            INITIALIZE g_apeb_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_apeb_d[l_ac].apeb002 = "40"
      LET g_apeb_d[l_ac].apeb001 = "aapt410"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            #帶出借貸別(正負值)
            LET g_apeb_d[l_ac].apeb015 = aapt410_get_dc(g_apeb_d[l_ac].apeb002)*-1
            LET g_apeb_d[l_ac].apebld = g_apea_m.apeald
            LET g_apeb_d[l_ac].apebcomp = g_apea_m.apeacomp
            LET g_apeb_d[l_ac].apebsite = g_apea_m.apeasite            
            #end add-point
            LET g_apeb_d_t.* = g_apeb_d[l_ac].*     #新輸入資料
            LET g_apeb_d_o.* = g_apeb_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            CALL aapt410_set_no_required()
            CALL aapt410_set_required()
            #end add-point
            CALL aapt410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apeb_d[li_reproduce_target].* = g_apeb_d[li_reproduce].*
 
               LET g_apeb_d[li_reproduce_target].apebseq = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_apeb_d[l_ac].apebseq = NULL
            SELECT MAX(apebseq) INTO g_apeb_d[l_ac].apebseq FROM apeb_t
             WHERE apebent = g_enterprise
               AND apebld  = g_apea_m.apeald
               AND apebdocno = g_apea_m.apeadocno
            IF cl_null(g_apeb_d[l_ac].apebseq) THEN
               LET g_apeb_d[l_ac].apebseq = 0 
            END IF            
            LET g_apeb_d[l_ac].apebseq = g_apeb_d[l_ac].apebseq + 1 
            

            #end add-point  
  
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身新增 name="input.body.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apeb_t 
             WHERE apebent = g_enterprise AND apebdocno = g_apea_m.apeadocno
 
               AND apebseq = g_apeb_d[l_ac].apebseq
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apea_m.apeadocno
               LET gs_keys[2] = g_apeb_d[g_detail_idx].apebseq
               CALL aapt410_insert_b('apeb_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               INITIALIZE g_apeb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt410_b_fill()
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
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身刪除前 name="input.body.b_delete"
               
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apea_m.apeadocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_apeb_d_t.apebseq
 
            
               #刪除同層單身
               IF NOT aapt410_delete_b('apeb_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt410_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt410_key_delete_b(gs_keys,'apeb_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt410_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_apeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apeb_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb002
            #add-point:BEFORE FIELD apeb002 name="input.b.page1.apeb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb002
            
            #add-point:AFTER FIELD apeb002 name="input.a.page1.apeb002"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb002
            #add-point:ON CHANGE apeb002 name="input.g.page1.apeb002"
            LET g_apeb_d[l_ac].apeb015 = aapt410_get_dc(g_apeb_d[l_ac].apeb002)*-1
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeborga
            
            #add-point:AFTER FIELD apeborga name="input.a.page1.apeborga"
            LET g_apeb_d[l_ac].apeborga_desc = ' '
            DISPLAY BY NAME g_apeb_d[l_ac].apeborga_desc
            IF NOT cl_null(g_apeb_d[l_ac].apeborga) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeborga != g_apeb_d_t.apeborga OR g_apeb_d_t.apeborga IS NULL )) THEN
                  CALL s_fin_comp_chk(g_apeb_d[l_ac].apeborga) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apeb_d[l_ac].apeborga = g_apeb_d_t.apeborga
                     LET g_apeb_d[l_ac].apeborga_desc = s_desc_get_department_desc(g_apeb_d[l_ac].apeborga)
                     DISPLAY BY NAME g_apeb_d[l_ac].apeborga_desc
                     NEXT FIELD CURRENT
                  END IF          
                  #取得來源組織所屬法人
                  CALL s_fin_orga_get_comp_ld(g_apeb_d[l_ac].apeborga) RETURNING g_sub_success,g_errno,l_apeborga_comp,l_apeborga_ld            
                  CALL s_ld_sel_glaa(l_apeborga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001                     
                
               END IF
            END IF           
            LET g_apeb_d[l_ac].apeborga_desc = s_desc_get_department_desc(g_apeb_d[l_ac].apeborga)
            DISPLAY BY NAME g_apeb_d[l_ac].apeborga_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeborga
            #add-point:BEFORE FIELD apeborga name="input.b.page1.apeborga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeborga
            #add-point:ON CHANGE apeborga name="input.g.page1.apeborga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb003
            #add-point:BEFORE FIELD apeb003 name="input.b.page1.apeb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb003
            
            #add-point:AFTER FIELD apeb003 name="input.a.page1.apeb003"
            IF NOT cl_null(g_apeb_d[l_ac].apeb003) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeb003 != g_apeb_d_t.apeb003 OR g_apeb_d_t.apeb003 IS NULL )) THEN
                  IF NOT cl_null(g_apeb_d[l_ac].apeb004)
                     AND NOT cl_null(g_apeb_d[l_ac].apeb005) THEN    
                     IF NOT cl_null(g_apeb_d[l_ac].apeb003) AND NOT cl_null(g_apeb_d[l_ac].apeb004) AND 
                        NOT cl_null(g_apeb_d[l_ac].apeb005) THEN
                        CALL s_aapt410_exist_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005)                        
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb003 = g_apeb_d_t.apeb003
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb003
                           NEXT FIELD CURRENT
                        END IF                                
                        CALL s_aapt410_apcc_used_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                                                     g_apeb_d[l_ac].apeb109,g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1','0')
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb003 = g_apeb_d_t.apeb003
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb003
                           NEXT FIELD CURRENT
                        END IF                     
                        CALL s_aapt410_source_doc_carry(g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,l_apeborga_ld,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb008)
                         RETURNING g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                   g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031                  
                        LET g_apeb_d[l_ac].apeb013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb_d[l_ac].apeb013)
                        #來源組織本幣與代付法人本幣不同            
                        IF l_glaa001 <> g_glaa001 THEN            
                           CALL aapt410_trans_to_local_curr(g_apeb_d[l_ac].apeb100,g_glaa001,g_apeb_d[l_ac].apeb109)
                            RETURNING g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119
                        END IF
                       
                     END IF
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                     g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031,g_apeb_d[l_ac].apeb013_desc                
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb003
            #add-point:ON CHANGE apeb003 name="input.g.page1.apeb003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb004
            #add-point:BEFORE FIELD apeb004 name="input.b.page1.apeb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb004
            
            #add-point:AFTER FIELD apeb004 name="input.a.page1.apeb004"
            IF NOT cl_null(g_apeb_d[l_ac].apeb004) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeb004 != g_apeb_d_t.apeb004 OR g_apeb_d_t.apeb004 IS NULL )) THEN
                  IF NOT cl_null(g_apeb_d[l_ac].apeb004)
                     AND NOT cl_null(g_apeb_d[l_ac].apeb005) THEN            
                     IF NOT cl_null(g_apeb_d[l_ac].apeb003) AND NOT cl_null(g_apeb_d[l_ac].apeb004) AND 
                        NOT cl_null(g_apeb_d[l_ac].apeb005) THEN
                        CALL s_aapt410_exist_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005)                        
                           RETURNING g_sub_success,g_errno                        
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb004 = g_apeb_d_t.apeb004
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb004
                           NEXT FIELD CURRENT
                        END IF                              
                        CALL s_aapt410_apcc_used_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                                                     g_apeb_d[l_ac].apeb109,g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1','0')
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb004 = g_apeb_d_t.apeb004
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb004
                           NEXT FIELD CURRENT
                        END IF                      
                        CALL s_aapt410_source_doc_carry(g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,l_apeborga_ld,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb008)
                         RETURNING g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                   g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031                  
                        LET g_apeb_d[l_ac].apeb013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb_d[l_ac].apeb013)
                        #來源組織本幣與代付法人本幣不同            
                        IF l_glaa001 <> g_glaa001 THEN            
                           CALL aapt410_trans_to_local_curr(g_apeb_d[l_ac].apeb100,g_glaa001,g_apeb_d[l_ac].apeb109)
                            RETURNING g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119
                        END IF
                       
                     END IF                     
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                     g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031,g_apeb_d[l_ac].apeb013_desc   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb004
            #add-point:ON CHANGE apeb004 name="input.g.page1.apeb004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb005
            #add-point:BEFORE FIELD apeb005 name="input.b.page1.apeb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb005
            
            #add-point:AFTER FIELD apeb005 name="input.a.page1.apeb005"
            IF NOT cl_null(g_apeb_d[l_ac].apeb005) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeb005 != g_apeb_d_t.apeb005 OR g_apeb_d_t.apeb005 IS NULL )) THEN
                  IF NOT cl_null(g_apeb_d[l_ac].apeb004)
                     AND NOT cl_null(g_apeb_d[l_ac].apeb005) THEN   
                     IF NOT cl_null(g_apeb_d[l_ac].apeb003) AND NOT cl_null(g_apeb_d[l_ac].apeb004) AND 
                        NOT cl_null(g_apeb_d[l_ac].apeb005) THEN
                        CALL s_aapt410_exist_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005)                        
                           RETURNING g_sub_success,g_errno                           
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb005 = g_apeb_d_t.apeb005
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb005
                           NEXT FIELD CURRENT
                        END IF                            
                        CALL s_aapt410_apcc_used_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                                                     g_apeb_d[l_ac].apeb109,g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1','0')
                           RETURNING g_sub_success,g_errno
                        IF NOT g_sub_success THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = ''
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_apeb_d[l_ac].apeb005 = g_apeb_d_t.apeb005
                           DISPLAY BY NAME g_apeb_d[l_ac].apeb005
                           NEXT FIELD CURRENT
                        END IF                      
                        CALL s_aapt410_source_doc_carry(g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,l_apeborga_ld,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb008)
                         RETURNING g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                   g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031                  
                        LET g_apeb_d[l_ac].apeb013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb_d[l_ac].apeb013)
                        #來源組織本幣與代付法人本幣不同            
                        IF l_glaa001 <> g_glaa001 THEN            
                           CALL aapt410_trans_to_local_curr(g_apeb_d[l_ac].apeb100,g_glaa001,g_apeb_d[l_ac].apeb109)
                            RETURNING g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119
                        END IF
                      
                     END IF
                  END IF
               END IF
            END IF                     
            DISPLAY BY NAME g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,
                                     g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031,g_apeb_d[l_ac].apeb013_desc   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb005
            #add-point:ON CHANGE apeb005 name="input.g.page1.apeb005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apeb_d[l_ac].apeb109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apeb109
            END IF 
 
 
 
            #add-point:AFTER FIELD apeb109 name="input.a.page1.apeb109"
            IF NOT cl_null(g_apeb_d[l_ac].apeb109) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeb109 != g_apeb_d_o.apeb109 OR g_apeb_d_o.apeb109 IS NULL )) THEN
                 
                  CALL s_aapt410_apcc_used_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                                               g_apeb_d[l_ac].apeb109,g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1','0')
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apeb_d[l_ac].apeb109 = g_apeb_d_t.apeb109
                     DISPLAY BY NAME g_apeb_d[l_ac].apeb109
                     NEXT FIELD CURRENT
                  END IF
                  
                  IF NOT cl_null(g_apeb_d[l_ac].apeb101)THEN
                     #計算可用金額(原幣)
                     #如果=剩下全額就直接讓apeb119 = 剩下全額
                     INITIALIZE l_apcc_used.* TO NULL
                     CALL s_aapt410_apcc_used_num(g_apeb_d[l_ac].apeb002,g_apea_m.apeald,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                     g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1')
                         RETURNING g_sub_success,g_errno,l_apcc_used.apcc10x,l_apcc_used.apcc11x
                         
                     IF l_apcc_used.apcc10x = g_apeb_d[l_ac].apeb109 THEN
                        LET g_apeb_d[l_ac].apeb119 = l_apcc_used.apcc11x

                     ELSE                     
                        #部分又不是全額的話就
                        LET g_apeb_d[l_ac].apeb119 = g_apeb_d[l_ac].apeb109 * g_apeb_d[l_ac].apeb101
                     END IF
                     #幣別取位
                     
                     DISPLAY BY NAME g_apeb_d[l_ac].apeb119
                  END IF
               END IF
            END IF
            LET g_apeb_d_o.apeb109 = g_apeb_d[l_ac].apeb109
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb109
            #add-point:BEFORE FIELD apeb109 name="input.b.page1.apeb109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb109
            #add-point:ON CHANGE apeb109 name="input.g.page1.apeb109"
            LET g_apeb_d[l_ac].apeb119 = g_apeb_d[l_ac].apeb109 * g_apeb_d[l_ac].apeb101
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeb119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apeb_d[l_ac].apeb119,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apeb119
            END IF 
 
 
 
            #add-point:AFTER FIELD apeb119 name="input.a.page1.apeb119"
            IF NOT cl_null(g_apeb_d[l_ac].apeb119) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb_d[l_ac].apeb119 != g_apeb_d_o.apeb119 OR g_apeb_d_o.apeb119 IS NULL )) THEN
                 
                  CALL s_aapt410_apcc_used_chk(g_apeb_d[l_ac].apeb002,l_apeborga_ld,g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,
                                               g_apeb_d[l_ac].apeb119,g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,'1','1')
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apeb_d[l_ac].apeb119 = g_apeb_d_t.apeb119
                     DISPLAY BY NAME g_apeb_d[l_ac].apeb119
                     NEXT FIELD CURRENT
                  END IF   
                  IF cl_null(g_apeb_d[l_ac].apeb119) THEN LET g_apeb_d[l_ac].apeb119 = 0 END IF
                  CALL s_curr_round_ld('1',g_apea_m.apeald,g_glaa001,g_apeb_d[l_ac].apeb119,2) 
                   RETURNING g_sub_success,g_errno,g_apeb_d[l_ac].apeb119
                  DISPLAY BY NAME g_apeb_d[l_ac].apeb119                  
                  END IF
            END IF
            LET g_apeb_d_o.apeb119 = g_apeb_d[l_ac].apeb119            


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeb119
            #add-point:BEFORE FIELD apeb119 name="input.b.page1.apeb119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeb119
            #add-point:ON CHANGE apeb119 name="input.g.page1.apeb119"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.apeb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb002
            #add-point:ON ACTION controlp INFIELD apeb002 name="input.c.page1.apeb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeborga
            #add-point:ON ACTION controlp INFIELD apeborga name="input.c.page1.apeborga"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apeb_d[l_ac].apeborga
            CALL q_ooef001()
            LET g_apeb_d[l_ac].apeborga = g_qryparam.return1
            CALL s_fin_orga_get_comp_ld(g_apeb_d[l_ac].apeborga) RETURNING g_sub_success,g_errno,l_apeborga_comp,l_apeborga_ld            
            CALL s_ld_sel_glaa(l_apeborga_ld,'glaa001') RETURNING  g_sub_success,l_glaa001                
            CALL s_desc_get_department_desc(g_apeb_d[l_ac].apeborga) RETURNING g_apeb_d[l_ac].apeborga_desc
            DISPLAY BY NAME g_apeb_d[l_ac].apeborga,g_apeb_d[l_ac].apeborga_desc
            NEXT FIELD apeborga
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb003
            #add-point:ON ACTION controlp INFIELD apeb003 name="input.c.page1.apeb003"
            #依帳款類型開窗
            CALL s_aapt410_source_doc_query(g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeb003,l_apeborga_comp,g_apea_m.apea005,g_apea_m.apeadocdt)
             RETURNING g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb008
            DISPLAY BY NAME g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb008
            NEXT FIELD apeb003
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeb004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb004
            #add-point:ON ACTION controlp INFIELD apeb004 name="input.c.page1.apeb004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeb005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb005
            #add-point:ON ACTION controlp INFIELD apeb005 name="input.c.page1.apeb005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeb109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb109
            #add-point:ON ACTION controlp INFIELD apeb109 name="input.c.page1.apeb109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apeb119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeb119
            #add-point:ON ACTION controlp INFIELD apeb119 name="input.c.page1.apeb119"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apeb_d[l_ac].* = g_apeb_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE aapt410_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_apeb_d[l_ac].apebseq 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apeb_d[l_ac].* = g_apeb_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aapt410_apeb_t_mask_restore('restore_mask_o')
      
               UPDATE apeb_t SET (apebdocno,apebseq,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013, 
                   apeb008,apeb024,apeb015,apeb100,apeb109,apeb101,apeb119,apeb031,apebld,apebcomp,apebsite, 
                   apeb001) = (g_apea_m.apeadocno,g_apeb_d[l_ac].apebseq,g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeborga, 
                   g_apeb_d[l_ac].apeb003,g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb013, 
                   g_apeb_d[l_ac].apeb008,g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb015,g_apeb_d[l_ac].apeb100, 
                   g_apeb_d[l_ac].apeb109,g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031, 
                   g_apeb_d[l_ac].apebld,g_apeb_d[l_ac].apebcomp,g_apeb_d[l_ac].apebsite,g_apeb_d[l_ac].apeb001) 
 
                WHERE apebent = g_enterprise AND apebdocno = g_apea_m.apeadocno 
 
                  AND apebseq = g_apeb_d_t.apebseq #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apeb_d[l_ac].* = g_apeb_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apeb_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_apeb_d[l_ac].* = g_apeb_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apea_m.apeadocno
               LET gs_keys_bak[1] = g_apeadocno_t
               LET gs_keys[2] = g_apeb_d[g_detail_idx].apebseq
               LET gs_keys_bak[2] = g_apeb_d_t.apebseq
               CALL aapt410_update_b('apeb_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aapt410_apeb_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_apeb_d[g_detail_idx].apebseq = g_apeb_d_t.apebseq 
 
                  ) THEN
                  LET gs_keys[01] = g_apea_m.apeadocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_apeb_d_t.apebseq
 
                  CALL aapt410_key_update_b(gs_keys,'apeb_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apea_m),util.JSON.stringify(g_apeb_d_t)
               LET g_log2 = util.JSON.stringify(g_apea_m),util.JSON.stringify(g_apeb_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL aapt410_unlock_b("apeb_t","'1'")
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
               LET g_apeb_d[li_reproduce_target].* = g_apeb_d[li_reproduce].*
 
               LET g_apeb_d[li_reproduce_target].apebseq = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_apeb_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apeb_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_apeb2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = l_allow_insert, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = l_allow_delete,
                 APPEND ROW = l_allow_insert)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_apeb2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aapt410_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_apeb2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
            CALL aapt410_show()
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_apeb2_d[l_ac].* TO NULL 
            INITIALIZE g_apeb2_d_t.* TO NULL 
            INITIALIZE g_apeb2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
                  LET g_apeb2_d[l_ac].apee002 = "10"
      LET g_apeb2_d[l_ac].apee006 = "20"
      LET g_apeb2_d[l_ac].apee009 = "N"
      LET g_apeb2_d[l_ac].apee001 = "aapt410"
 
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            LET l_nmag002 = '1'   #款別為20:現金,帳戶運用類型指定為不限制
        
            LET g_apeb2_d[l_ac].apee015 = aapt410_get_dc(g_apeb2_d[l_ac].apee002)
            LET g_apeb2_d[l_ac].apeecomp = g_apea_m.apeacomp
            LET g_apeb2_d[l_ac].apeesite = g_apea_m.apeasite            
            LET g_apeb2_d[l_ac].apee032 = g_apea_m.apeadocdt
            LET g_apeb2_d[l_ac].apee038 = g_apea_m.apea005
            #end add-point
            LET g_apeb2_d_t.* = g_apeb2_d[l_ac].*     #新輸入資料
            LET g_apeb2_d_o.* = g_apeb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aapt410_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
            CALL aapt410_set_no_required()
            CALL aapt410_set_required()
            #end add-point
            CALL aapt410_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_apeb2_d[li_reproduce_target].* = g_apeb2_d[li_reproduce].*
 
               LET g_apeb2_d[li_reproduce_target].apeeseq = NULL
            END IF
            
 
            #add-point:modify段before insert name="input.body2.before_insert"
            LET g_apeb2_d[l_ac].apeeseq = NULL
            SELECT MAX(apeeseq) INTO g_apeb2_d[l_ac].apeeseq FROM apee_t
             WHERE apeeent = g_enterprise
               AND apeedocno = g_apea_m.apeadocno
            IF cl_null(g_apeb2_d[l_ac].apeeseq) THEN
               LET g_apeb2_d[l_ac].apeeseq = 0 
            END IF            
            LET g_apeb2_d[l_ac].apeeseq = g_apeb2_d[l_ac].apeeseq + 1 
            #end add-point  
 
         BEFORE ROW     
            #add-point:modify段before row2 name="input.body2.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET l_cmd = ''
            LET l_ac_t = l_ac 
            LET g_detail_idx_list[2] = l_ac
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET g_current_page = 2
              
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aapt410_cl:" 
               LET g_errparam.code   = STATUS 
               LET g_errparam.popup  = TRUE 
               CLOSE aapt410_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_apeb2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_apeb2_d[l_ac].apeeseq IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_apeb2_d_t.* = g_apeb2_d[l_ac].*  #BACKUP
               LET g_apeb2_d_o.* = g_apeb2_d[l_ac].*  #BACKUP
               CALL aapt410_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
               CALL aapt410_set_no_required()
               CALL aapt410_set_required()
               #end add-point  
               CALL aapt410_set_no_entry_b(l_cmd)
               IF NOT aapt410_lock_b("apee_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aapt410_bcl2 INTO g_apeb2_d[l_ac].apeeseq,g_apeb2_d[l_ac].apeeorga,g_apeb2_d[l_ac].apee002, 
                      g_apeb2_d[l_ac].apee006,g_apeb2_d[l_ac].apee008,g_apeb2_d[l_ac].apee021,g_apeb2_d[l_ac].apee024, 
                      g_apeb2_d[l_ac].apee015,g_apeb2_d[l_ac].apee100,g_apeb2_d[l_ac].apee109,g_apeb2_d[l_ac].apee101, 
                      g_apeb2_d[l_ac].apee119,g_apeb2_d[l_ac].apee032,g_apeb2_d[l_ac].apee013,g_apeb2_d[l_ac].apee014, 
                      g_apeb2_d[l_ac].apee010,g_apeb2_d[l_ac].apee009,g_apeb2_d[l_ac].apee039,g_apeb2_d[l_ac].apee040, 
                      g_apeb2_d[l_ac].apee011,g_apeb2_d[l_ac].apee012,g_apeb2_d[l_ac].apeecomp,g_apeb2_d[l_ac].apeesite, 
                      g_apeb2_d[l_ac].apee005,g_apeb2_d[l_ac].apee001,g_apeb2_d[l_ac].apee038
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_apeb2_d_mask_o[l_ac].* =  g_apeb2_d[l_ac].*
                  CALL aapt410_apee_t_mask()
                  LET g_apeb2_d_mask_n[l_ac].* =  g_apeb2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aapt410_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body2.before_row"
            IF l_cmd = 'u' THEN
               CASE
                  WHEN g_apeb2_d[l_ac].apee006 = '10'  #現金
                     LET l_nmag002 = '5'   #零用金
                  WHEN g_apeb2_d[l_ac].apee006 = '20'  #銀行電匯款
                     LET l_nmag002 = '1'   #不限制
                  WHEN g_apeb2_d[l_ac].apee006 = '30'  #票據
                     LET l_nmag002 = '4'   #票據往來
               END CASE
            ELSE
               LET l_nmag002 =''
            END IF   
            #end add-point  
            #其他table資料備份(確定是否更改用)
            
 
            #其他table進行lock
            
 
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
               #add-point:單身AFTER DELETE (=d) name="input.body2.after_delete_d"
               
               #end add-point
            ELSE
               #add-point:單身刪除前 name="input.body2.b_delete_ask"
               
               #end add-point 
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               
               #add-point:單身2刪除前 name="input.body2.b_delete"
               
               #end add-point    
                  
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_apea_m.apeadocno
               LET gs_keys[gs_keys.getLength()+1] = g_apeb2_d_t.apeeseq
            
               #刪除同層單身
               IF NOT aapt410_delete_b('apee_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt410_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aapt410_key_delete_b(gs_keys,'apee_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aapt410_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
               
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE aapt410_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
               
               #end add-point
               LET l_count = g_apeb_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
               
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_apeb2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         AFTER INSERT    
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            #add-point:單身2新增前 name="input.body2.b_a_insert"
            
            #end add-point
               
            LET l_count = 1  
            SELECT COUNT(1) INTO l_count FROM apee_t 
             WHERE apeeent = g_enterprise AND apeedocno = g_apea_m.apeadocno
               AND apeeseq = g_apeb2_d[l_ac].apeeseq
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
               
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apea_m.apeadocno
               LET gs_keys[2] = g_apeb2_d[g_detail_idx].apeeseq
               CALL aapt410_insert_b('apee_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_apeb_d[l_ac].* TO NULL
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aapt410_b_fill()
               #資料多語言用-增/改
               
               #add-point:單身新增後 name="input.body2.after_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_apeb2_d[l_ac].* = g_apeb2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE aapt410_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_apeb2_d[l_ac].* = g_apeb2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL aapt410_apee_t_mask_restore('restore_mask_o')
                              
               UPDATE apee_t SET (apeedocno,apeeseq,apeeorga,apee002,apee006,apee008,apee021,apee024, 
                   apee015,apee100,apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039, 
                   apee040,apee011,apee012,apeecomp,apeesite,apee005,apee001,apee038) = (g_apea_m.apeadocno, 
                   g_apeb2_d[l_ac].apeeseq,g_apeb2_d[l_ac].apeeorga,g_apeb2_d[l_ac].apee002,g_apeb2_d[l_ac].apee006, 
                   g_apeb2_d[l_ac].apee008,g_apeb2_d[l_ac].apee021,g_apeb2_d[l_ac].apee024,g_apeb2_d[l_ac].apee015, 
                   g_apeb2_d[l_ac].apee100,g_apeb2_d[l_ac].apee109,g_apeb2_d[l_ac].apee101,g_apeb2_d[l_ac].apee119, 
                   g_apeb2_d[l_ac].apee032,g_apeb2_d[l_ac].apee013,g_apeb2_d[l_ac].apee014,g_apeb2_d[l_ac].apee010, 
                   g_apeb2_d[l_ac].apee009,g_apeb2_d[l_ac].apee039,g_apeb2_d[l_ac].apee040,g_apeb2_d[l_ac].apee011, 
                   g_apeb2_d[l_ac].apee012,g_apeb2_d[l_ac].apeecomp,g_apeb2_d[l_ac].apeesite,g_apeb2_d[l_ac].apee005, 
                   g_apeb2_d[l_ac].apee001,g_apeb2_d[l_ac].apee038) #自訂欄位頁簽
                WHERE apeeent = g_enterprise AND apeedocno = g_apea_m.apeadocno
                  AND apeeseq = g_apeb2_d_t.apeeseq #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
               
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_apeb2_d[l_ac].* = g_apeb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apee_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     LET g_apeb2_d[l_ac].* = g_apeb2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_apea_m.apeadocno
               LET gs_keys_bak[1] = g_apeadocno_t
               LET gs_keys[2] = g_apeb2_d[g_detail_idx].apeeseq
               LET gs_keys_bak[2] = g_apeb2_d_t.apeeseq
               CALL aapt410_update_b('apee_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL aapt410_apee_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_apeb2_d[g_detail_idx].apeeseq = g_apeb2_d_t.apeeseq 
                  ) THEN
                  LET gs_keys[01] = g_apea_m.apeadocno
                  LET gs_keys[gs_keys.getLength()+1] = g_apeb2_d_t.apeeseq
                  CALL aapt410_key_update_b(gs_keys,'apee_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_apea_m),util.JSON.stringify(g_apeb2_d_t)
               LET g_log2 = util.JSON.stringify(g_apea_m),util.JSON.stringify(g_apeb2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apeeorga
            
            #add-point:AFTER FIELD apeeorga name="input.a.page2.apeeorga"
            LET g_apeb2_d[l_ac].apeeorga_desc = ' '
            DISPLAY BY NAME g_apeb2_d[l_ac].apeeorga_desc
            IF NOT cl_null(g_apeb2_d[l_ac].apeeorga) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb2_d[l_ac].apeeorga != g_apeb2_d_t.apeeorga OR g_apeb2_d_t.apeeorga IS NULL )) THEN
                  CALL s_fin_comp_chk(g_apeb2_d[l_ac].apeeorga) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apeb2_d[l_ac].apeeorga = g_apeb2_d_t.apeeorga
                     LET g_apeb2_d[l_ac].apeeorga_desc = s_desc_get_department_desc(g_apeb2_d[l_ac].apeeorga)
                     DISPLAY BY NAME g_apeb2_d[l_ac].apeeorga_desc
                     NEXT FIELD CURRENT
                  END IF                             
                  CALL s_fin_account_center_with_ld_chk(g_apeb2_d[l_ac].apeeorga,g_glaald,g_user,'6','Y','',g_today)
                    RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_apeb2_d[l_ac].apeeorga = g_apeb2_d_t.apeeorga
                     LET g_apeb2_d[l_ac].apeeorga_desc = s_desc_get_department_desc(g_apeb2_d[l_ac].apeeorga)
                     DISPLAY BY NAME g_apeb2_d[l_ac].apeeorga_desc
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
              LET g_apeb2_d[l_ac].apeeorga_desc = s_desc_get_department_desc(g_apeb2_d[l_ac].apeeorga)
              DISPLAY BY NAME g_apeb2_d[l_ac].apeeorga_desc
              #帶出集團代收付基本資料
              CALL aapt410_sel_apaf('2',g_apeb2_d[l_ac].apeeorga)
               RETURNING g_apeb2_d[l_ac].apee005,g_apeb2_d[l_ac].apee014,g_apeb2_d[l_ac].apee011,g_apeb2_d[l_ac].apee012
              DISPLAY BY NAME g_apeb2_d[l_ac].apee005,g_apeb2_d[l_ac].apee014,g_apeb2_d[l_ac].apee011,g_apeb2_d[l_ac].apee012            
            END IF           

            LET g_apeb_d[l_ac].apeborga_desc = s_desc_get_department_desc(g_apeb_d[l_ac].apeborga)
            DISPLAY BY NAME g_apeb_d[l_ac].apeborga_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apeeorga
            #add-point:BEFORE FIELD apeeorga name="input.b.page2.apeeorga"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apeeorga
            #add-point:ON CHANGE apeeorga name="input.g.page2.apeeorga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee002
            #add-point:BEFORE FIELD apee002 name="input.b.page2.apee002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee002
            
            #add-point:AFTER FIELD apee002 name="input.a.page2.apee002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee002
            #add-point:ON CHANGE apee002 name="input.g.page2.apee002"
            LET g_apeb2_d[l_ac].apee015 = aapt410_get_dc(g_apeb2_d[l_ac].apee002)
            CALL aapt410_set_entry_b(l_cmd)
            CALL aapt410_set_no_entry_b(l_cmd)   
            CALL aapt410_set_no_required()
            CALL aapt410_set_required()            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee006
            #add-point:BEFORE FIELD apee006 name="input.b.page2.apee006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee006
            
            #add-point:AFTER FIELD apee006 name="input.a.page2.apee006"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee006
            #add-point:ON CHANGE apee006 name="input.g.page2.apee006"
            CASE
               WHEN g_apeb2_d[l_ac].apee006 = '10'  #現金
                  LET l_nmag002 = '5'   #零用金
               WHEN g_apeb2_d[l_ac].apee006 = '20'  #銀行電匯款
                  LET l_nmag002 = '1'   #不限制
               WHEN g_apeb2_d[l_ac].apee006 = '30'  #票據
                  LET l_nmag002 = '4'   #票據往來
            END CASE
            CALL aapt410_set_entry_b(l_cmd)
            CALL aapt410_set_no_entry_b(l_cmd)
            CALL aapt410_set_no_required()
            CALL aapt410_set_required()            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee008
            #add-point:BEFORE FIELD apee008 name="input.b.page2.apee008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee008
            
            #add-point:AFTER FIELD apee008 name="input.a.page2.apee008"
            IF NOT cl_null(g_apeb2_d[l_ac].apee008) THEN
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL

               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_apeb2_d[l_ac].apee008
               LET g_chkparam.arg2 = g_apea_m.apeacomp
               LET g_chkparam.arg3 = l_nmag002

               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_nmas002_4") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
               
               #預帶帳戶幣別
               LET g_apeb2_d[l_ac].apee100 = s_anm_get_nmas003(g_apeb2_d[l_ac].apee008)
               DISPLAY BY NAME g_apeb2_d[l_ac].apee100                  
  
            END IF            

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee008
            #add-point:ON CHANGE apee008 name="input.g.page2.apee008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee021
            #add-point:BEFORE FIELD apee021 name="input.b.page2.apee021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee021
            
            #add-point:AFTER FIELD apee021 name="input.a.page2.apee021"
            IF NOT cl_null(g_apeb2_d[l_ac].apee021) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_apeb2_d[l_ac].apee021
               LET g_chkparam.arg2 = g_apeb2_d[l_ac].apee006
               LET g_chkparam.err_str[2] ="amm-00245:anm-00217"
               IF NOT cl_chk_exist("v_ooia001_1") THEN
                  NEXT FIELD CURRENT
               END IF
               CALL aapt410_set_entry_b(l_cmd)
               CALL aapt410_set_no_entry_b(l_cmd)
               CALL aapt410_set_no_required()
               CALL aapt410_set_required()                   
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee021
            #add-point:ON CHANGE apee021 name="input.g.page2.apee021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee024
            #add-point:BEFORE FIELD apee024 name="input.b.page2.apee024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee024
            
            #add-point:AFTER FIELD apee024 name="input.a.page2.apee024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee024
            #add-point:ON CHANGE apee024 name="input.g.page2.apee024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee100
            #add-point:BEFORE FIELD apee100 name="input.b.page2.apee100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee100
            
            #add-point:AFTER FIELD apee100 name="input.a.page2.apee100"
            IF NOT cl_null(g_apeb2_d[l_ac].apee100) THEN  
               CALL s_aap_ooaj001_chk(g_apea_m.apeald,g_apeb2_d[l_ac].apee100) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_apeb2_d[l_ac].apee100 = g_apeb2_d_t.apee100
                  NEXT FIELD CURRENT
               END IF            
               CALL aapt410_trans_to_local_curr(g_apeb2_d[l_ac].apee100,g_glaa001,g_apeb2_d[l_ac].apee109)            
                RETURNING g_apeb2_d[l_ac].apee101,g_apeb2_d[l_ac].apee119 
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee100
            #add-point:ON CHANGE apee100 name="input.g.page2.apee100"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee109
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apeb2_d[l_ac].apee109,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apee109
            END IF 
 
 
 
            #add-point:AFTER FIELD apee109 name="input.a.page2.apee109"
            IF NOT cl_null(g_apeb2_d[l_ac].apee109) THEN 
               CALL aapt410_trans_to_local_curr(g_apeb2_d[l_ac].apee100,g_glaa001,g_apeb2_d[l_ac].apee109)            
                RETURNING g_apeb2_d[l_ac].apee101,g_apeb2_d[l_ac].apee119             
            END IF 

            

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee109
            #add-point:BEFORE FIELD apee109 name="input.b.page2.apee109"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee109
            #add-point:ON CHANGE apee109 name="input.g.page2.apee109"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee101
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apeb2_d[l_ac].apee101,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apee101
            END IF 
 
 
 
            #add-point:AFTER FIELD apee101 name="input.a.page2.apee101"
            IF NOT cl_null(g_apeb2_d[l_ac].apee101) THEN 
               IF cl_null(g_apeb2_d_t.apee101) OR (g_apeb2_d_t.apee101 <> g_apeb2_d[l_ac].apee101)THEN
                  LET g_apeb2_d[l_ac].apee119 = g_apeb2_d[l_ac].apee109 * g_apeb2_d[l_ac].apee101
               END IF            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee101
            #add-point:BEFORE FIELD apee101 name="input.b.page2.apee101"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee101
            #add-point:ON CHANGE apee101 name="input.g.page2.apee101"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee119
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apeb2_d[l_ac].apee119,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apee119
            END IF 
 
 
 
            #add-point:AFTER FIELD apee119 name="input.a.page2.apee119"
            IF NOT cl_null(g_apeb2_d[l_ac].apee119) THEN 
               IF cl_null(g_apeb2_d[l_ac].apee119) THEN LET g_apeb2_d[l_ac].apee119 = 0 END IF
               CALL s_curr_round_ld('1',g_apea_m.apeald,g_glaa001,g_apeb2_d[l_ac].apee119,2) 
                RETURNING g_sub_success,g_errno,g_apeb2_d[l_ac].apee119
               DISPLAY BY NAME g_apeb2_d[l_ac].apee119            
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee119
            #add-point:BEFORE FIELD apee119 name="input.b.page2.apee119"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee119
            #add-point:ON CHANGE apee119 name="input.g.page2.apee119"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee032
            #add-point:BEFORE FIELD apee032 name="input.b.page2.apee032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee032
            
            #add-point:AFTER FIELD apee032 name="input.a.page2.apee032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee032
            #add-point:ON CHANGE apee032 name="input.g.page2.apee032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee013
            
            #add-point:AFTER FIELD apee013 name="input.a.page2.apee013"
            LET g_apeb2_d[l_ac].apee013_desc = ' '
            DISPLAY BY NAME g_apeb2_d[l_ac].apee013_desc            
            IF NOT cl_null(g_apeb2_d[l_ac].apee013) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_apeb2_d[l_ac].apee013 != g_apeb2_d_t.apee013 OR g_apeb2_d_t.apee013 IS NULL )) THEN
                  CALL s_aap_apca005_chk(g_apeb2_d[l_ac].apee013)RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_apeb2_d[l_ac].apee013 = g_apeb2_d_t.apee013
                     CALL s_desc_get_trading_partner_abbr_desc(g_apeb2_d[l_ac].apee013) RETURNING g_apeb2_d[l_ac].apee013_desc
                     DISPLAY BY NAME g_apeb2_d[l_ac].apee013_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
          
            LET g_apeb2_d[l_ac].apee013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb2_d[l_ac].apee013)
            DISPLAY BY NAME g_apeb2_d[l_ac].apee013_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee013
            #add-point:BEFORE FIELD apee013 name="input.b.page2.apee013"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee013
            #add-point:ON CHANGE apee013 name="input.g.page2.apee013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee014
            #add-point:BEFORE FIELD apee014 name="input.b.page2.apee014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee014
            
            #add-point:AFTER FIELD apee014 name="input.a.page2.apee014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee014
            #add-point:ON CHANGE apee014 name="input.g.page2.apee014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee010
            #add-point:BEFORE FIELD apee010 name="input.b.page2.apee010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee010
            
            #add-point:AFTER FIELD apee010 name="input.a.page2.apee010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee010
            #add-point:ON CHANGE apee010 name="input.g.page2.apee010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee039
            #add-point:BEFORE FIELD apee039 name="input.b.page2.apee039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee039
            
            #add-point:AFTER FIELD apee039 name="input.a.page2.apee039"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee039
            #add-point:ON CHANGE apee039 name="input.g.page2.apee039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee040
            #add-point:BEFORE FIELD apee040 name="input.b.page2.apee040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee040
            
            #add-point:AFTER FIELD apee040 name="input.a.page2.apee040"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee040
            #add-point:ON CHANGE apee040 name="input.g.page2.apee040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee011
            #add-point:BEFORE FIELD apee011 name="input.b.page2.apee011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee011
            
            #add-point:AFTER FIELD apee011 name="input.a.page2.apee011"

            LET g_apeb2_d[l_ac].apee012 = ' '
            DISPLAY BY NAME g_apeb2_d[l_ac].apee012
            IF NOT cl_null(g_apeb2_d[l_ac].apee011) THEN

               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apeb2_d[l_ac].apee011 != g_apeb2_d_t.apee011 OR g_apeb2_d_t.apee011 IS NULL )) THEN
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apeb2_d[l_ac].apee011
                  LET g_chkparam.arg2 = 2
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmaj001_1") THEN
                     #檢查失敗時後續處理
                     LET g_apeb2_d[l_ac].apee011 = g_apeb2_d_t.apee011
                     LET g_apeb2_d[l_ac].apee012 = s_anm_get_nmad003(g_glaa005,g_apeb2_d[l_ac].apee011)
                     DISPLAY BY NAME g_apeb2_d[l_ac].apee012
                     NEXT FIELD CURRENT
                  END IF
                  LET g_apeb2_d[l_ac].apee012 = s_anm_get_nmad003(g_glaa005,g_apeb2_d[l_ac].apee011)
                  DISPLAY BY NAME g_apeb2_d[l_ac].apee012
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee011
            #add-point:ON CHANGE apee011 name="input.g.page2.apee011"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apee012
            
            #add-point:AFTER FIELD apee012 name="input.a.page2.apee012"
            
            IF NOT cl_null(g_apeb2_d[l_ac].apee012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_apeb2_d[l_ac].apee012 != g_apeb2_d_t.apee012 OR g_apeb2_d_t.apee012 IS NULL )) THEN

                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL

                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_apeb2_d[l_ac].apee012
                  LET g_chkparam.arg2 = g_glaa005
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_nmai002") THEN
                     #檢查失敗時後續處理
                     LET g_apeb2_d[l_ac].apee012 = g_apeb2_d_t.apee012
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apee012
            #add-point:BEFORE FIELD apee012 name="input.b.page2.apee012"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apee012
            #add-point:ON CHANGE apee012 name="input.g.page2.apee012"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.apeeorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apeeorga
            #add-point:ON ACTION controlp INFIELD apeeorga name="input.c.page2.apeeorga"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apeeorga             #給予default值
            LET g_qryparam.where = " ooef206 = 'Y' "
            CALL q_ooef001()                                #呼叫開窗

            LET g_apeb2_d[l_ac].apeeorga = g_qryparam.return1              
            DISPLAY g_apeb2_d[l_ac].apeeorga TO apeeorga             
            CALL s_desc_get_department_desc(g_apeb2_d[l_ac].apeeorga) RETURNING g_apeb2_d[l_ac].apeeorga_desc
            DISPLAY BY NAME g_apeb2_d[l_ac].apeeorga,g_apeb2_d[l_ac].apeeorga_desc
            NEXT FIELD apeeorga                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apee002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee002
            #add-point:ON ACTION controlp INFIELD apee002 name="input.c.page2.apee002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee006
            #add-point:ON ACTION controlp INFIELD apee006 name="input.c.page2.apee006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee008
            #add-point:ON ACTION controlp INFIELD apee008 name="input.c.page2.apee008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL               
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE                 
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee008             #給予default值            
            CASE g_apeb2_d[l_ac].apee002
               WHEN '10'
                  #開窗i段
                  #給予arg
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'i'
                  LET g_qryparam.reqry = FALSE
                  
                  LET g_qryparam.default1 = g_apeb2_d[l_ac].apee008             #給予default值
                  LET g_qryparam.where = " nmaa002 IN (SELECT ooef001 FROM ooef_t WHERE ooefent = '",g_enterprise,"'",
                                         "              AND ooef017 = '",g_apea_m.apeacomp,"')",
                                         " AND EXISTS(SELECT 1 FROM nmag_t WHERE nmag001 = nmaa003 AND nmag002='",l_nmag002,"')"
                  CALL q_nmas_01()                                #呼叫開窗
                  
  
               WHEN '16'         
                  #給予arg
                  LET g_qryparam.arg1 = g_apea_m.apeasite         #帳務中心(接收,暫不處理)
                  LET g_qryparam.arg2 = ''                        #核銷客戶
                  LET g_qryparam.arg3 = g_apea_m.apea005          #收款客戶
                  LET g_qryparam.arg4 = g_apea_m.apeacomp         #來源組織(接收,暫不處理)
                  LET g_qryparam.arg5 = g_apea_m.apeald           #帳套                  
                  CALL axrt400_08()  

#               WHEN '17'                                          
#                  LET g_qryparam.arg1 = g_apea_m.apeasite         #帳務中心(接收,暫不處理)
#                  LET g_qryparam.arg2 = ''                        #核銷客戶
#                  LET g_qryparam.arg3 = g_apea_m.apea005          #收款客戶
#                  LET g_qryparam.arg4 = g_apea_m.apeacomp         #來源組織(接收,暫不處理)
#                  LET g_qryparam.arg5 = g_apea_m.apeald           #帳套                  
#                  LET g_qryparam.where = " nmbb029 = '",g_apeb2_d[l_ac].apee006,"'" #款別
#                  CALL axrt400_07()                              
            END CASE
            LET g_apeb2_d[l_ac].apee008 = g_qryparam.return1
            LET g_apeb2_d[l_ac].apee100 = s_anm_get_nmas003(g_apeb2_d[l_ac].apee008)
            DISPLAY BY NAME g_apeb2_d[l_ac].apee100            
            DISPLAY g_apeb2_d[l_ac].apee008 TO apee008 
            NEXT FIELD apee008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apee021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee021
            #add-point:ON ACTION controlp INFIELD apee021 name="input.c.page2.apee021"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_apeb2_d[l_ac].apee021     #給予default值
               LET g_qryparam.where = " ooia002 = '",g_apeb2_d[l_ac].apee006,"'",
                                      " AND ooiaent = '",g_enterprise,"'"
               CALL q_ooia001()                                      #呼叫開窗
               
               LET g_apeb2_d[l_ac].apee021 = g_qryparam.return1      #將開窗取得的值回傳到變數
               DISPLAY BY NAME g_apeb2_d[l_ac].apee021               #顯示到畫面上
               NEXT FIELD apee021                                    #返回原欄位
               
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee024
            #add-point:ON ACTION controlp INFIELD apee024 name="input.c.page2.apee024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee100
            #add-point:ON ACTION controlp INFIELD apee100 name="input.c.page2.apee100"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooaj001='",g_glaa026,"' "
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee100             #給予default值
            
            CALL q_ooaj002()                                #呼叫開窗

            LET g_apeb2_d[l_ac].apee100 = g_qryparam.return1              

            DISPLAY g_apeb2_d[l_ac].apee100 TO apee100              #

            NEXT FIELD apee100                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page2.apee109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee109
            #add-point:ON ACTION controlp INFIELD apee109 name="input.c.page2.apee109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee101
            #add-point:ON ACTION controlp INFIELD apee101 name="input.c.page2.apee101"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee119
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee119
            #add-point:ON ACTION controlp INFIELD apee119 name="input.c.page2.apee119"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee032
            #add-point:ON ACTION controlp INFIELD apee032 name="input.c.page2.apee032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee013
            #add-point:ON ACTION controlp INFIELD apee013 name="input.c.page2.apee013"
            #付款對象
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee013
            LET g_qryparam.arg1 = "1"                         #交易類型
            CALL q_pmac002_8()
            LET g_apeb2_d[l_ac].apee013 = g_qryparam.return1
            LET g_apeb2_d[l_ac].apee013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb2_d[l_ac].apee013)
            DISPLAY BY NAME g_apeb2_d[l_ac].apee013,g_apeb2_d[l_ac].apee013_desc
            NEXT FIELD apee013
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee014
            #add-point:ON ACTION controlp INFIELD apee014 name="input.c.page2.apee014"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #開窗i段
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee014  
            CASE 
               WHEN g_apeb2_d[l_ac].apee002 = '10' AND g_apeb2_d[l_ac].apee006= '30'   #10.付款+30.票據類型(anmt440)    
                  LET g_qryparam.arg1 = g_glaa024       
                  LET g_qryparam.arg2 = "anmt440"       
                  CALL q_ooba002_1()                                            
               WHEN g_apeb2_d[l_ac].apee002= '20'                                      #20.轉應付待抵款(aapt340)                  
                  LET g_qryparam.arg1 = g_glaa024
                  LET g_qryparam.arg2 = "aapt340"
                  CALL q_ooba002_1()     
               WHEN g_apeb2_d[l_ac].apee002= '22'                                      #22.代扣轉付(aapt301)
                  LET g_qryparam.arg1 = g_glaa024
                  LET g_qryparam.arg2 = "aapt301"
                  LET g_qryparam.where =  "     EXISTS ( SELECT 1 FROM ooac_t ",
                                          "      WHERE ooacent = oobaent AND ooac001 = ooba001 AND  ooac002 = ooba002 ",
                                          "        AND ooac003 = 'D-FIN-0030' AND ooac004 = 'N') "  #只能選不產生傳票的單別                  
                  CALL q_ooba002_1()                    

               WHEN g_apeb2_d[l_ac].apee002= '21'                                      #21.轉應收款(axrt330)                   
                  LET g_qryparam.arg1 = g_glaa024
                  LET g_qryparam.arg2 = "axrt330"
                  CALL q_ooba002_1()                                 
            END CASE
            LET g_apeb2_d[l_ac].apee014 = g_qryparam.return1   
            DISPLAY BY NAME g_apeb2_d[l_ac].apee014    
            NEXT FIELD apee014 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee010
            #add-point:ON ACTION controlp INFIELD apee010 name="input.c.page2.apee010"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee010     #給予default值
            LET g_qryparam.arg1 = "3005"
            CALL q_oocq002()                                #呼叫開窗

            LET g_apeb2_d[l_ac].apee010 = g_qryparam.return1              
            DISPLAY BY NAME g_apeb2_d[l_ac].apee010              
            NEXT FIELD apee010                             #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee039
            #add-point:ON ACTION controlp INFIELD apee039 name="input.c.page2.apee039"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee040
            #add-point:ON ACTION controlp INFIELD apee040 name="input.c.page2.apee040"
 
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee011
            #add-point:ON ACTION controlp INFIELD apee011 name="input.c.page2.apee011"
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmaj002 = '2' "   #提出
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee011            #給予default值
            CALL q_nmaj001()                                             #呼叫開窗
            LET g_apeb2_d[l_ac].apee011 = g_qryparam.return1
            LET g_apeb2_d[l_ac].apee012 = s_anm_get_nmad003(g_glaa005,g_apeb2_d[l_ac].apee011)
            DISPLAY BY NAME g_apeb2_d[l_ac].apee011,g_apeb2_d[l_ac].apee012
            NEXT FIELD apee011                                           #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page2.apee012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apee012
            #add-point:ON ACTION controlp INFIELD apee012 name="input.c.page2.apee012"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"' "
            LET g_qryparam.default1 = g_apeb2_d[l_ac].apee012 #給予default值
            CALL q_nmai002()                                  #呼叫開窗
            LET g_apeb2_d[l_ac].apee012 = g_qryparam.return1
            DISPLAY g_apeb2_d[l_ac].apee012 TO apee012              
            NEXT FIELD apee012                                #返回原欄位
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
            
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_apeb2_d[l_ac].* = g_apeb2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CLOSE aapt410_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL aapt410_unlock_b("apee_t","'2'")
            CALL s_transaction_end('Y','0')
            #add-point:單身page2 after_row2 name="input.body2.after_row2"
            
            #end add-point
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
 
            #end add-point   
    
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_apeb2_d[li_reproduce_target].* = g_apeb2_d[li_reproduce].*
 
               LET g_apeb2_d[li_reproduce_target].apeeseq = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_apeb2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_apeb2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="aapt410.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         IF p_cmd = 'u' THEN
            CALL cl_get_para(g_enterprise,g_apea_m.apeasite,'S-FIN-3008') RETURNING g_para_data1         
            CALL s_ld_sel_glaa(g_apea_m.apeald,'glaa001|glaa002|glaa005|glaa024|glaa025|glaa026')
                 RETURNING  g_sub_success,g_glaa001,g_glaa002,g_glaa005,g_glaa024,g_glaa025,g_glaa026 
            LET g_apea_m.glaa001 = g_glaa001     
         ELSE
            LET g_para_data1 = ''
            LET g_glaa001 ='' LET g_glaa002 ='' LET g_glaa005 =''
            LET g_glaa024 ='' LET g_glaa025 ='' LET g_glaa026 =''
         END IF                       
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD apeadocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD apebseq
               WHEN "s_detail2"
                  NEXT FIELD apeeseq
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
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
         LET g_detail_idx_list[2] = 1
 
         CALL g_curr_diag.setCurrentRow("s_detail1",1)    
         CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
    
   #add-point:input段after input  name="input.after_input"
   CALL aapt410_open_aapt410_09()RETURNING g_sub_success
   CALL aapt410_show()   
   CALL aapt410_sum_page_show()
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aapt410_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
   
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aapt410_b_fill() #單身填充
      CALL aapt410_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aapt410_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeaownid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apea_m.apeaownid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeaownid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeaowndp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_apea_m.apeaowndp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeaowndp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeacrtid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apea_m.apeacrtid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeacrtid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeacrtdp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_apea_m.apeacrtdp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeacrtdp_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeamodid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apea_m.apeamodid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeamodid_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_apea_m.apeacnfid
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_apea_m.apeacnfid_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_apea_m.apeacnfid_desc
   
   LET g_apea_m.apeasite_desc = s_desc_get_department_desc(g_apea_m.apeasite)
   LET g_apea_m.apeacomp_desc = s_desc_get_department_desc(g_apea_m.apeacomp)
   LET g_apea_m.apea003_desc = s_desc_get_person_desc(g_apea_m.apea003)
   LET g_apea_m.apea005_desc = s_desc_get_trading_partner_abbr_desc(g_apea_m.apea005)
   LET g_apea_m.apea015_desc = s_desc_get_acc_desc('3115',g_apea_m.apea015)
   LET g_apea_m.apea018_desc = s_desc_get_acc_desc('3113',g_apea_m.apea018)
   CALL s_aooi200_get_slip_desc(g_apea_m.apeadocno) RETURNING g_apea_m.apeadocno_desc
   CALL s_ld_sel_glaa(g_apea_m.apeald,'glaa001') RETURNING g_sub_success,g_apea_m.glaa001
   CALL aapt410_sum_page_show()
   #end add-point
   
   #遮罩相關處理
   LET g_apea_m_mask_o.* =  g_apea_m.*
   CALL aapt410_apea_t_mask()
   LET g_apea_m_mask_n.* =  g_apea_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc,g_apea_m.apea003,g_apea_m.apea003_desc,g_apea_m.apeacomp, 
       g_apea_m.apeacomp_desc,g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001,g_apea_m.apeadocdt, 
       g_apea_m.apea005,g_apea_m.apea005_desc,g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008, 
       g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea018_desc,g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015, 
       g_apea_m.apea015_desc,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp, 
       g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamodid_desc,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfid_desc,g_apea_m.apeacnfdt,g_apea_m.dummy3,g_apea_m.glaa001,g_apea_m.sum_apee1091, 
       g_apea_m.sum_apee1191,g_apea_m.sum_apee1092,g_apea_m.sum_apee1192,g_apea_m.sum_apee1093,g_apea_m.sum_apee1193, 
       g_apea_m.sum_apee1094,g_apea_m.sum_apee1194
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apea_m.apeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_apeb_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      LET g_apeb_d[l_ac].apeborga_desc = s_desc_get_department_desc(g_apeb_d[l_ac].apeborga)
      LET g_apeb_d[l_ac].apeb013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb_d[l_ac].apeb013)
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_apeb2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"

      LET g_apeb2_d[l_ac].apeeorga_desc = s_desc_get_department_desc(g_apeb2_d[l_ac].apeeorga)
      LET g_apeb2_d[l_ac].apee013_desc = s_desc_get_trading_partner_abbr_desc(g_apeb2_d[l_ac].apee013)      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aapt410_detail_show()
 
   #add-point:show段之後 name="show.after"
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aapt410_detail_show()
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
 
{<section id="aapt410.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aapt410_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE apea_t.apeadocno 
   DEFINE l_oldno     LIKE apea_t.apeadocno 
 
   DEFINE l_master    RECORD LIKE apea_t.*
   DEFINE l_detail    RECORD LIKE apeb_t.*
   DEFINE l_detail2    RECORD LIKE apee_t.*
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF
   
   LET g_master_insert = FALSE
   
   IF g_apea_m.apeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_apeadocno_t = g_apea_m.apeadocno
 
    
   LET g_apea_m.apeadocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_apea_m.apeaownid = g_user
      LET g_apea_m.apeaowndp = g_dept
      LET g_apea_m.apeacrtid = g_user
      LET g_apea_m.apeacrtdp = g_dept 
      LET g_apea_m.apeacrtdt = cl_get_current()
      LET g_apea_m.apeamodid = g_user
      LET g_apea_m.apeamoddt = cl_get_current()
      LET g_apea_m.apeastus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_apea_m.apeastus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
      LET g_apea_m.apeadocno_desc = ''
   DISPLAY BY NAME g_apea_m.apeadocno_desc
 
   
   CALL aapt410_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_apea_m.* TO NULL
      INITIALIZE g_apeb_d TO NULL
      INITIALIZE g_apeb2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aapt410_show()
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aapt410_set_act_visible()   
   CALL aapt410_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_apeadocno_t = g_apea_m.apeadocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " apeaent = " ||g_enterprise|| " AND",
                      " apeadocno = '", g_apea_m.apeadocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aapt410_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aapt410_idx_chk()
   
   LET g_data_owner = g_apea_m.apeaownid      
   LET g_data_dept  = g_apea_m.apeaowndp
   
   #功能已完成,通報訊息中心
   CALL aapt410_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aapt410_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE apeb_t.*
   DEFINE l_detail2    RECORD LIKE apee_t.*
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aapt410_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apeb_t
    WHERE apebent = g_enterprise AND apebdocno = g_apeadocno_t
 
    INTO TEMP aapt410_detail
 
   #將key修正為調整後   
   UPDATE aapt410_detail 
      #更新key欄位
      SET apebdocno = g_apea_m.apeadocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO apeb_t SELECT * FROM aapt410_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單身複製中1 name="detail_reproduce.body.table1.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt410_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM apee_t 
    WHERE apeeent = g_enterprise AND apeedocno = g_apeadocno_t
 
    INTO TEMP aapt410_detail
 
   #將key修正為調整後   
   UPDATE aapt410_detail SET apeedocno = g_apea_m.apeadocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO apee_t SELECT * FROM aapt410_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aapt410_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_apeadocno_t = g_apea_m.apeadocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aapt410_delete()
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
   
   IF g_apea_m.apeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT aapt410_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_apea_m_mask_o.* =  g_apea_m.*
   CALL aapt410_apea_t_mask()
   LET g_apea_m_mask_n.* =  g_apea_m.*
   
   CALL aapt410_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aapt410_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_apeadocno_t = g_apea_m.apeadocno
 
 
      DELETE FROM apea_t
       WHERE apeaent = g_enterprise AND apeadocno = g_apea_m.apeadocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_apea_m.apeadocno,":",SQLERRMESSAGE  
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM apeb_t
       WHERE apebent = g_enterprise AND apebdocno = g_apea_m.apeadocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
      #add-point:單身刪除前 name="delete.body.b_delete2"
      
      #end add-point
      DELETE FROM apee_t
       WHERE apeeent = g_enterprise AND
             apeedocno = g_apea_m.apeadocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE aapt410_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_apeb_d.clear() 
      CALL g_apeb2_d.clear()       
 
     
      CALL aapt410_ui_browser_refresh()  
      #CALL aapt410_ui_headershow()  
      #CALL aapt410_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aapt410_browser_fill("")
         CALL aapt410_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aapt410_cl
 
   #功能已完成,通報訊息中心
   CALL aapt410_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aapt410.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aapt410_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_apeb_d.clear()
   CALL g_apeb2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
 
   #end add-point
   
   #判斷是否填充
   IF aapt410_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT apebseq,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013,apeb008, 
             apeb024,apeb015,apeb100,apeb109,apeb101,apeb119,apeb031,apebld,apebcomp,apebsite,apeb001  FROM apeb_t", 
                
                     " INNER JOIN apea_t ON apeaent = " ||g_enterprise|| " AND apeadocno = apebdocno ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                     
                     " WHERE apebent=? AND apebdocno=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apeb_t.apebseq"
         
         #add-point:單身填充控制 name="b_fill.sql"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt410_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aapt410_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_apea_m.apeadocno
                                               
      FOREACH b_fill_cs INTO g_apeb_d[l_ac].apebseq,g_apeb_d[l_ac].apeb002,g_apeb_d[l_ac].apeborga,g_apeb_d[l_ac].apeb003, 
          g_apeb_d[l_ac].apeb004,g_apeb_d[l_ac].apeb005,g_apeb_d[l_ac].apeb013,g_apeb_d[l_ac].apeb008, 
          g_apeb_d[l_ac].apeb024,g_apeb_d[l_ac].apeb015,g_apeb_d[l_ac].apeb100,g_apeb_d[l_ac].apeb109, 
          g_apeb_d[l_ac].apeb101,g_apeb_d[l_ac].apeb119,g_apeb_d[l_ac].apeb031,g_apeb_d[l_ac].apebld, 
          g_apeb_d[l_ac].apebcomp,g_apeb_d[l_ac].apebsite,g_apeb_d[l_ac].apeb001
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
    
   #判斷是否填充
   IF aapt410_fill_chk(2) THEN
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         LET g_sql = "SELECT  DISTINCT apeeseq,apeeorga,apee002,apee006,apee008,apee021,apee024,apee015, 
             apee100,apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039,apee040, 
             apee011,apee012,apeecomp,apeesite,apee005,apee001,apee038  FROM apee_t",   
                     " INNER JOIN  apea_t ON apeaent = " ||g_enterprise|| " AND apeadocno = apeedocno ",
 
                     "",
                     
                     
                     " WHERE apeeent=? AND apeedocno=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body2.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY apee_t.apeeseq"
         
         #add-point:單身填充控制 name="b_fill.sql2"
         
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aapt410_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR aapt410_pb2
      END IF
    
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_apea_m.apeadocno
                                               
      FOREACH b_fill_cs2 INTO g_apeb2_d[l_ac].apeeseq,g_apeb2_d[l_ac].apeeorga,g_apeb2_d[l_ac].apee002, 
          g_apeb2_d[l_ac].apee006,g_apeb2_d[l_ac].apee008,g_apeb2_d[l_ac].apee021,g_apeb2_d[l_ac].apee024, 
          g_apeb2_d[l_ac].apee015,g_apeb2_d[l_ac].apee100,g_apeb2_d[l_ac].apee109,g_apeb2_d[l_ac].apee101, 
          g_apeb2_d[l_ac].apee119,g_apeb2_d[l_ac].apee032,g_apeb2_d[l_ac].apee013,g_apeb2_d[l_ac].apee014, 
          g_apeb2_d[l_ac].apee010,g_apeb2_d[l_ac].apee009,g_apeb2_d[l_ac].apee039,g_apeb2_d[l_ac].apee040, 
          g_apeb2_d[l_ac].apee011,g_apeb2_d[l_ac].apee012,g_apeb2_d[l_ac].apeecomp,g_apeb2_d[l_ac].apeesite, 
          g_apeb2_d[l_ac].apee005,g_apeb2_d[l_ac].apee001,g_apeb2_d[l_ac].apee038
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
         
         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = l_ac
            LET g_errparam.code   = 9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
      END FOREACH
   END IF
 
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   
   #end add-point
   
   CALL g_apeb_d.deleteElement(g_apeb_d.getLength())
   CALL g_apeb2_d.deleteElement(g_apeb2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aapt410_pb
   FREE aapt410_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_apeb_d.getLength()
      LET g_apeb_d_mask_o[l_ac].* =  g_apeb_d[l_ac].*
      CALL aapt410_apeb_t_mask()
      LET g_apeb_d_mask_n[l_ac].* =  g_apeb_d[l_ac].*
   END FOR
   
   LET g_apeb2_d_mask_o.* =  g_apeb2_d.*
   FOR l_ac = 1 TO g_apeb2_d.getLength()
      LET g_apeb2_d_mask_o[l_ac].* =  g_apeb2_d[l_ac].*
      CALL aapt410_apee_t_mask()
      LET g_apeb2_d_mask_n[l_ac].* =  g_apeb2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aapt410_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM apeb_t
       WHERE apebent = g_enterprise AND
         apebdocno = ps_keys_bak[1] AND apebseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ":",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apeb_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
      
      #end add-point    
      DELETE FROM apee_t
       WHERE apeeent = g_enterprise AND
             apeedocno = ps_keys_bak[1] AND apeeseq = ps_keys_bak[2]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      
      #end add-point    
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apeb2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aapt410_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO apeb_t
                  (apebent,
                   apebdocno,
                   apebseq
                   ,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013,apeb008,apeb024,apeb015,apeb100,apeb109,apeb101,apeb119,apeb031,apebld,apebcomp,apebsite,apeb001) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apeb_d[g_detail_idx].apeb002,g_apeb_d[g_detail_idx].apeborga,g_apeb_d[g_detail_idx].apeb003, 
                       g_apeb_d[g_detail_idx].apeb004,g_apeb_d[g_detail_idx].apeb005,g_apeb_d[g_detail_idx].apeb013, 
                       g_apeb_d[g_detail_idx].apeb008,g_apeb_d[g_detail_idx].apeb024,g_apeb_d[g_detail_idx].apeb015, 
                       g_apeb_d[g_detail_idx].apeb100,g_apeb_d[g_detail_idx].apeb109,g_apeb_d[g_detail_idx].apeb101, 
                       g_apeb_d[g_detail_idx].apeb119,g_apeb_d[g_detail_idx].apeb031,g_apeb_d[g_detail_idx].apebld, 
                       g_apeb_d[g_detail_idx].apebcomp,g_apeb_d[g_detail_idx].apebsite,g_apeb_d[g_detail_idx].apeb001) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_apeb_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO apee_t
                  (apeeent,
                   apeedocno,
                   apeeseq
                   ,apeeorga,apee002,apee006,apee008,apee021,apee024,apee015,apee100,apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039,apee040,apee011,apee012,apeecomp,apeesite,apee005,apee001,apee038) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_apeb2_d[g_detail_idx].apeeorga,g_apeb2_d[g_detail_idx].apee002,g_apeb2_d[g_detail_idx].apee006, 
                       g_apeb2_d[g_detail_idx].apee008,g_apeb2_d[g_detail_idx].apee021,g_apeb2_d[g_detail_idx].apee024, 
                       g_apeb2_d[g_detail_idx].apee015,g_apeb2_d[g_detail_idx].apee100,g_apeb2_d[g_detail_idx].apee109, 
                       g_apeb2_d[g_detail_idx].apee101,g_apeb2_d[g_detail_idx].apee119,g_apeb2_d[g_detail_idx].apee032, 
                       g_apeb2_d[g_detail_idx].apee013,g_apeb2_d[g_detail_idx].apee014,g_apeb2_d[g_detail_idx].apee010, 
                       g_apeb2_d[g_detail_idx].apee009,g_apeb2_d[g_detail_idx].apee039,g_apeb2_d[g_detail_idx].apee040, 
                       g_apeb2_d[g_detail_idx].apee011,g_apeb2_d[g_detail_idx].apee012,g_apeb2_d[g_detail_idx].apeecomp, 
                       g_apeb2_d[g_detail_idx].apeesite,g_apeb2_d[g_detail_idx].apee005,g_apeb2_d[g_detail_idx].apee001, 
                       g_apeb2_d[g_detail_idx].apee038)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_apeb2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aapt410_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apeb_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aapt410_apeb_t_mask_restore('restore_mask_o')
               
      UPDATE apeb_t 
         SET (apebdocno,
              apebseq
              ,apeb002,apeborga,apeb003,apeb004,apeb005,apeb013,apeb008,apeb024,apeb015,apeb100,apeb109,apeb101,apeb119,apeb031,apebld,apebcomp,apebsite,apeb001) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apeb_d[g_detail_idx].apeb002,g_apeb_d[g_detail_idx].apeborga,g_apeb_d[g_detail_idx].apeb003, 
                  g_apeb_d[g_detail_idx].apeb004,g_apeb_d[g_detail_idx].apeb005,g_apeb_d[g_detail_idx].apeb013, 
                  g_apeb_d[g_detail_idx].apeb008,g_apeb_d[g_detail_idx].apeb024,g_apeb_d[g_detail_idx].apeb015, 
                  g_apeb_d[g_detail_idx].apeb100,g_apeb_d[g_detail_idx].apeb109,g_apeb_d[g_detail_idx].apeb101, 
                  g_apeb_d[g_detail_idx].apeb119,g_apeb_d[g_detail_idx].apeb031,g_apeb_d[g_detail_idx].apebld, 
                  g_apeb_d[g_detail_idx].apebcomp,g_apeb_d[g_detail_idx].apebsite,g_apeb_d[g_detail_idx].apeb001)  
 
         WHERE apebent = g_enterprise AND apebdocno = ps_keys_bak[1] AND apebseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apeb_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apeb_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt410_apeb_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "apee_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point  
      
      #將遮罩欄位還原
      CALL aapt410_apee_t_mask_restore('restore_mask_o')
               
      UPDATE apee_t 
         SET (apeedocno,
              apeeseq
              ,apeeorga,apee002,apee006,apee008,apee021,apee024,apee015,apee100,apee109,apee101,apee119,apee032,apee013,apee014,apee010,apee009,apee039,apee040,apee011,apee012,apeecomp,apeesite,apee005,apee001,apee038) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_apeb2_d[g_detail_idx].apeeorga,g_apeb2_d[g_detail_idx].apee002,g_apeb2_d[g_detail_idx].apee006, 
                  g_apeb2_d[g_detail_idx].apee008,g_apeb2_d[g_detail_idx].apee021,g_apeb2_d[g_detail_idx].apee024, 
                  g_apeb2_d[g_detail_idx].apee015,g_apeb2_d[g_detail_idx].apee100,g_apeb2_d[g_detail_idx].apee109, 
                  g_apeb2_d[g_detail_idx].apee101,g_apeb2_d[g_detail_idx].apee119,g_apeb2_d[g_detail_idx].apee032, 
                  g_apeb2_d[g_detail_idx].apee013,g_apeb2_d[g_detail_idx].apee014,g_apeb2_d[g_detail_idx].apee010, 
                  g_apeb2_d[g_detail_idx].apee009,g_apeb2_d[g_detail_idx].apee039,g_apeb2_d[g_detail_idx].apee040, 
                  g_apeb2_d[g_detail_idx].apee011,g_apeb2_d[g_detail_idx].apee012,g_apeb2_d[g_detail_idx].apeecomp, 
                  g_apeb2_d[g_detail_idx].apeesite,g_apeb2_d[g_detail_idx].apee005,g_apeb2_d[g_detail_idx].apee001, 
                  g_apeb2_d[g_detail_idx].apee038) 
         WHERE apeeent = g_enterprise AND apeedocno = ps_keys_bak[1] AND apeeseq = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apee_t" 
            LET g_errparam.code   = "std-00009" 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "apee_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aapt410_apee_t_mask_restore('restore_mask_n')
 
      #add-point:update_b段修改後 name="update_b.after_update2"
      
      #end add-point  
   END IF
 
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
 
 
   
 
   
   #add-point:update_b段other name="update_b.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aapt410_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt410.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aapt410_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="aapt410.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aapt410_lock_b(ps_table,ps_page)
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
   #CALL aapt410_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "apeb_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aapt410_bcl USING g_enterprise,
                                       g_apea_m.apeadocno,g_apeb_d[g_detail_idx].apebseq     
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt410_bcl:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "apee_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aapt410_bcl2 USING g_enterprise,
                                             g_apea_m.apeadocno,g_apeb2_d[g_detail_idx].apeeseq
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aapt410_bcl2:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
 
 
   
 
   
   #add-point:lock_b段other name="lock_b.other"
   
   #end add-point  
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aapt410_unlock_b(ps_table,ps_page)
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
      CLOSE aapt410_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aapt410_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aapt410_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("apeadocno,apeald",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("apeadocno",TRUE)
      CALL cl_set_comp_entry("apeadocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aapt410_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("apeadocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("apeadocno,apeald",FALSE)
   END IF 
 
   IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("apeadocdt",FALSE)
      END IF
   END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aapt410_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("apee006,apee008,apee013,apee014,apee021,apee024,apee032,apee039,apee040",TRUE)

   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aapt410_set_no_entry_b(p_cmd)
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
   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apeb2_d[l_ac].apee002
		   WHEN '10'
            IF NOT(g_apeb2_d[l_ac].apee006 = '10' OR g_apeb2_d[l_ac].apee006 = '20' OR g_apeb2_d[l_ac].apee006 = '30') THEN
               CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
               LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040=''			   
            END IF
            IF NOT (g_apeb2_d[l_ac].apee006 = '30' OR g_apeb2_d[l_ac].apee006 = '40' OR g_apeb2_d[l_ac].apee006 = '50' OR
                    g_apeb2_d[l_ac].apee006 = '60' OR g_apeb2_d[l_ac].apee006 = '70' OR g_apeb2_d[l_ac].apee006 = '90') THEN
               CALL cl_set_comp_entry("apee021",FALSE)
               LET g_apeb2_d[l_ac].apee021=''
            END IF             
            IF NOT (g_apeb2_d[l_ac].apee006 = '30' OR g_apeb2_d[l_ac].apee006 = '40' OR g_apeb2_d[l_ac].apee006 = '50' OR
                    g_apeb2_d[l_ac].apee006 = '60' OR g_apeb2_d[l_ac].apee006 = '90') THEN
               CALL cl_set_comp_entry("apee024",FALSE)
               LET g_apeb2_d[l_ac].apee024=''
            END IF    
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013=''    
            IF NOT(g_apeb2_d[l_ac].apee006 = '30') THEN
               CALL cl_set_comp_entry("apee014",FALSE)
               LET g_apeb2_d[l_ac].apee014=''
            END IF                                           
		   
		   WHEN '11'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''			 
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040='' 
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''            
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''         
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt    
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013=''     
            CALL cl_set_comp_entry("apee014",FALSE)
            LET g_apeb2_d[l_ac].apee014=''                                                         
		   WHEN '12'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''				
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040='' 
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''         
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''                                 	   
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt  
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013=''      
            CALL cl_set_comp_entry("apee014",FALSE)
            LET g_apeb2_d[l_ac].apee014=''                                       
		   WHEN '13'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''	
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040=''  
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''        
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''                
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt   
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013=''      
            CALL cl_set_comp_entry("apee014",FALSE)
            LET g_apeb2_d[l_ac].apee014=''                                                     				   
		   WHEN '14'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''		
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040='' 
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''         
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''  
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt  
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013=''        
            CALL cl_set_comp_entry("apee014",FALSE)
            LET g_apeb2_d[l_ac].apee014=''                                                                    			   
		   WHEN '15'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''			
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040='' 
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''      
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''      
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt  
            CALL cl_set_comp_entry("apee013",FALSE)
            LET g_apeb2_d[l_ac].apee013='' 
            CALL cl_set_comp_entry("apee014",FALSE)
            LET g_apeb2_d[l_ac].apee014=''                                                                         		   
		   WHEN '20'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''				
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040=''
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''                 
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''           
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt                                 	   
		   WHEN '21'
            CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''				
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040=''  
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''               
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''           
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt                                 	   
		   WHEN '22'
		      CALL cl_set_comp_entry("apee006",FALSE)
            LET g_apeb2_d[l_ac].apee006=''
            CALL cl_set_comp_entry("apee008,apee039,apee040",FALSE)
            LET g_apeb2_d[l_ac].apee008='' LET g_apeb2_d[l_ac].apee039='' LET g_apeb2_d[l_ac].apee040=''        
            CALL cl_set_comp_entry("apee021",FALSE)
            LET g_apeb2_d[l_ac].apee021=''      
            CALL cl_set_comp_entry("apee024",FALSE)
            LET g_apeb2_d[l_ac].apee024=''           
            CALL cl_set_comp_entry("apee032",FALSE)
            LET g_apeb2_d[l_ac].apee032= g_apea_m.apeadocdt 
      END CASE            
         
   END IF
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aapt410_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aapt410_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_apea_m.apeastus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF


   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aapt410_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aapt410_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aapt410_default_search()
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
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " apeadocno = '", g_argv[02], "' AND "
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
         INITIALIZE g_wc2_table2 TO NULL
 
 
         FOR li_idx = 1 TO la_wc.getLength()
            CASE
               WHEN la_wc[li_idx].tableid = "apea_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apeb_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "apee_t" 
                  LET g_wc2_table2 = la_wc[li_idx].wc
 
 
               WHEN la_wc[li_idx].tableid = "EXTENDWC"
                  LET g_wc2_extend = la_wc[li_idx].wc
            END CASE
         END FOR
         IF NOT cl_null(g_wc) OR NOT cl_null(g_wc2_table1) 
            OR NOT cl_null(g_wc2_table2)
 
 
            OR NOT cl_null(g_wc2_extend)
            THEN
            #組合g_wc2
            IF g_wc2_table1 <> " 1=1" AND NOT cl_null(g_wc2_table1) THEN
               LET g_wc2 = g_wc2_table1
            END IF
            IF g_wc2_table2 <> " 1=1" AND NOT cl_null(g_wc2_table2) THEN
               LET g_wc2 = g_wc2 ," AND ", g_wc2_table2
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
 
{<section id="aapt410.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aapt410_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_apea_m.apeadocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
   IF STATUS THEN
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aapt410_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
       g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea022, 
       g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea007, 
       g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp,g_apea_m.apeacrtid, 
       g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT aapt410_action_chk() THEN
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc,g_apea_m.apea003,g_apea_m.apea003_desc,g_apea_m.apeacomp, 
       g_apea_m.apeacomp_desc,g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001,g_apea_m.apeadocdt, 
       g_apea_m.apea005,g_apea_m.apea005_desc,g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008, 
       g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea018_desc,g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015, 
       g_apea_m.apea015_desc,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp, 
       g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid,g_apea_m.apeacrtid_desc,g_apea_m.apeacrtdp,g_apea_m.apeacrtdp_desc, 
       g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamodid_desc,g_apea_m.apeamoddt,g_apea_m.apeacnfid, 
       g_apea_m.apeacnfid_desc,g_apea_m.apeacnfdt,g_apea_m.dummy3,g_apea_m.glaa001,g_apea_m.sum_apee1091, 
       g_apea_m.sum_apee1191,g_apea_m.sum_apee1092,g_apea_m.sum_apee1192,g_apea_m.sum_apee1093,g_apea_m.sum_apee1193, 
       g_apea_m.sum_apee1094,g_apea_m.sum_apee1194
 
   CASE g_apea_m.apeastus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_apea_m.apeastus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      CALL cl_set_act_visible("signing,withdraw",FALSE)
      CALL cl_set_act_visible("unconfirmed,invalid,confirmed",TRUE)
      CALL cl_set_act_visible("closed",FALSE)

      CASE g_apea_m.apeastus
         WHEN "N"  
            CALL cl_set_act_visible("unconfirmed",FALSE)
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
            IF cl_bpm_chk() THEN
                CALL cl_set_act_visible("signing",TRUE)
                CALL cl_set_act_visible("confirmed",FALSE)
            END IF
 
         WHEN "R"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE)

         WHEN "D"   #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
            CALL cl_set_act_visible("confirmed,unconfirmed",FALSE) 
          
         WHEN "X"
            RETURN

         WHEN "Y"
            CALL cl_set_act_visible("invalid,confirmed",FALSE)
         
         WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
             CALL cl_set_act_visible("withdraw",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid,confirmed",FALSE)
         
         WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
             CALL cl_set_act_visible("confirmed ",TRUE)  
             CALL cl_set_act_visible("unconfirmed,invalid",FALSE)

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
      g_apea_m.apeastus = lc_state OR cl_null(lc_state) THEN
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   CALL cl_get_para(g_enterprise,g_apea_m.apeasite,'S-FIN-3008') RETURNING g_para_data1
   #確認
   IF lc_state = 'Y' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt410_conf_chk(g_apea_m.apeadocno) THEN
         CALL cl_err_collect_show()
         #差異處理
         CALL aapt410_open_aapt410_09()RETURNING g_sub_success
         CALL aapt410_show()            
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00108') THEN   #是否執行確認？
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt410_conf_upd(g_apea_m.apeadocno,g_para_data1) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF
   #取消確認
   IF lc_state = 'N' THEN
      CALL cl_err_collect_init()
      IF NOT s_aapt410_unconf_chk(g_apea_m.apeadocno,g_para_data1) THEN
         CALL cl_err_collect_show()
         RETURN
      ELSE
         IF NOT cl_ask_confirm('aim-00110') THEN   #是否執行取消確認？
            CALL cl_err_collect_show()
            RETURN
         ELSE
            CALL s_transaction_begin()
            IF NOT s_aapt410_unconf_upd(g_apea_m.apeadocno) THEN
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()
            END IF
         END IF
      END IF
   END IF   
   #作廢
   IF lc_state = 'X' THEN
      CALL cl_set_comp_entry("apea015",TRUE)
      CALL cl_err_collect_init()
      IF NOT s_aapt410_void_chk(g_apea_m.apeadocno)  THEN
      	 CALL cl_err_collect_show()
         RETURN    
      ELSE
         IF NOT cl_ask_confirm('aim-00109') THEN
            CALL cl_err_collect_show()
            RETURN
         ELSE
         		CALL s_transaction_begin()
            IF NOT s_aapt410_void_upd(g_apea_m.apeadocno) THEN
               CALL s_transaction_end('N','0')  
               CALL cl_err_collect_show() 
               RETURN
            ELSE
               CALL s_transaction_end('Y','0')
               CALL cl_err_collect_show()               
            END IF
         END IF
      END IF
   END IF
   #end add-point
   
   LET g_apea_m.apeamodid = g_user
   LET g_apea_m.apeamoddt = cl_get_current()
   LET g_apea_m.apeastus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE apea_t 
      SET (apeastus,apeamodid,apeamoddt) 
        = (g_apea_m.apeastus,g_apea_m.apeamodid,g_apea_m.apeamoddt)     
    WHERE apeaent = g_enterprise AND apeadocno = g_apea_m.apeadocno
 
    
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
      EXECUTE aapt410_master_referesh USING g_apea_m.apeadocno INTO g_apea_m.apeasite,g_apea_m.apea003, 
          g_apea_m.apeacomp,g_apea_m.apeadocno,g_apea_m.apea001,g_apea_m.apeadocdt,g_apea_m.apea005, 
          g_apea_m.apea022,g_apea_m.apeastus,g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018, 
          g_apea_m.apea007,g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea016,g_apea_m.apeaownid,g_apea_m.apeaowndp, 
          g_apea_m.apeacrtid,g_apea_m.apeacrtdp,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamoddt, 
          g_apea_m.apeacnfid,g_apea_m.apeacnfdt,g_apea_m.apeaownid_desc,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid_desc, 
          g_apea_m.apeacrtdp_desc,g_apea_m.apeamodid_desc,g_apea_m.apeacnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_apea_m.apeasite,g_apea_m.apeasite_desc,g_apea_m.apea003,g_apea_m.apea003_desc, 
          g_apea_m.apeacomp,g_apea_m.apeacomp_desc,g_apea_m.apeadocno,g_apea_m.apeadocno_desc,g_apea_m.apea001, 
          g_apea_m.apeadocdt,g_apea_m.apea005,g_apea_m.apea005_desc,g_apea_m.apea022,g_apea_m.apeastus, 
          g_apea_m.apeald,g_apea_m.apea008,g_apea_m.apea010,g_apea_m.apea018,g_apea_m.apea018_desc,g_apea_m.apea007, 
          g_apea_m.apea009,g_apea_m.apea015,g_apea_m.apea015_desc,g_apea_m.apea016,g_apea_m.apeaownid, 
          g_apea_m.apeaownid_desc,g_apea_m.apeaowndp,g_apea_m.apeaowndp_desc,g_apea_m.apeacrtid,g_apea_m.apeacrtid_desc, 
          g_apea_m.apeacrtdp,g_apea_m.apeacrtdp_desc,g_apea_m.apeacrtdt,g_apea_m.apeamodid,g_apea_m.apeamodid_desc, 
          g_apea_m.apeamoddt,g_apea_m.apeacnfid,g_apea_m.apeacnfid_desc,g_apea_m.apeacnfdt,g_apea_m.dummy3, 
          g_apea_m.glaa001,g_apea_m.sum_apee1091,g_apea_m.sum_apee1191,g_apea_m.sum_apee1092,g_apea_m.sum_apee1192, 
          g_apea_m.sum_apee1093,g_apea_m.sum_apee1193,g_apea_m.sum_apee1094,g_apea_m.sum_apee1194
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   CALL aapt410_show()
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aapt410_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aapt410_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt410.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aapt410_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_apeb_d.getLength() THEN
         LET g_detail_idx = g_apeb_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apeb_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apeb_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_apeb2_d.getLength() THEN
         LET g_detail_idx = g_apeb2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_apeb2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_apeb2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aapt410_b_fill2(pi_idx)
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
   
   CALL aapt410_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aapt410_fill_chk(ps_idx)
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
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1')  AND 
      (cl_null(g_wc2_table2) OR g_wc2_table2.trim() = '1=1') THEN
      #add-point:fill_chk段other_chk name="fill_chk.other_chk"
      
      #end add-point
      RETURN TRUE
   END IF
   
   #add-point:fill_chk段after_chk name="fill_chk.after_chk"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="aapt410.status_show" >}
PRIVATE FUNCTION aapt410_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapt410.mask_functions" >}
&include "erp/aap/aapt410_mask.4gl"
 
{</section>}
 
{<section id="aapt410.signature" >}
   
 
{</section>}
 
{<section id="aapt410.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aapt410_set_pk_array()
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
   LET g_pk_array[1].values = g_apea_m.apeadocno
   LET g_pk_array[1].column = 'apeadocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt410.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aapt410.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aapt410_msgcentre_notify(lc_state)
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
   CALL aapt410_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_apea_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aapt410.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aapt410_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aapt410.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 判斷借貸(正負值)
# Memo...........:
# Usage..........: CALL aapt410_get_dc (p_gzcb002)
#                  RETURNING r_flag
# Input parameter: p_gzcb002      帳款類型
#
# Return code....: r_flag         借貸別(正負值1/-1)
#
# Date & Author..: 14/10/08 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt410_get_dc(p_gzcb002)
   DEFINE p_gzcb002     LIKE gzcb_t.gzcb002
   DEFINE l_dc          LIKE type_t.chr1
   DEFINE r_flag        LIKE type_t.num5
   
   SELECT gzcb003 INTO l_dc
     FROM gzcb_t
    WHERE gzcb001 = '8506'
      AND gzcb002 = p_gzcb002
   CASE
      WHEN l_dc = "D"
         LET r_flag = -1  #借
      WHEN l_dc = "C"
         LET r_flag = 1   #貸
      WHEN l_dc = "X"
         LET r_flag = 0
   END CASE      
   RETURN r_flag
END FUNCTION

################################################################################
# Descriptions...: 抓取集團代收付基本資料
# Memo...........:
# Usage..........: CALL aapt410_sel_apaf(p_apaf001,p_apaf011)
#                  RETURNING r_apaf012,r_apaf013,r_apaf015,r_apaf016
# Input parameter: p_apaf001    代收付類型
#                : p_apaf011    帳務歸屬組織
# Return code....: r_apaf012    內部帳戶
#                : r_apaf013    沖銷單別
#                : r_apaf015    存提碼
#                : r_apaf016    現金變動碼
# Date & Author..: 14/10/08 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt410_sel_apaf(p_apaf001,p_apaf011)
   DEFINE p_apaf001    LIKE apaf_t.apaf001   #代收付類型
   DEFINE p_apaf011    LIKE apaf_t.apaf011   #帳務歸屬組織
   DEFINE r_apaf012    LIKE apaf_t.apaf012   #內部帳戶
   DEFINE r_apaf013    LIKE apaf_t.apaf013   #沖銷單別
   DEFINE r_apaf015    LIKE apaf_t.apaf015   #存提碼
   DEFINE r_apaf016    LIKE apaf_t.apaf016   #現金變動碼
   
   SELECT apaf012,apaf013,apaf015,apaf016
     INTO r_apaf012,r_apaf013,r_apaf015,r_apaf016 FROM apaf_t
    WHERE apafent = g_enterprise
      AND apaf001 = p_apaf001
      AND apaf011 = p_apaf011
      
   RETURN r_apaf012,r_apaf013,r_apaf015,r_apaf016
END FUNCTION

################################################################################
# Descriptions...: 重新計算本幣金額
# Memo...........: 
# Usage..........: aapt410_trans_to_local_curr(p_trans,p_curr,p_amt)
#                   RETURNING r_rate,r_amt
# Input parameter: p_trans      原幣
#                : p_curr       本幣
#                : p_amt        原幣金額
# Return code....: r_rate       匯率
#                : r_amt        本幣金額
# Date & Author..: 14/10/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt410_trans_to_local_curr(p_trans,p_curr,p_amt)
   DEFINE p_trans      LIKE glaa_t.glaa001   #交易原幣
   DEFINE p_curr       LIKE glaa_t.glaa002   #本幣
   DEFINE p_amt        LIKE apeb_t.apeb109   #原幣金額
   DEFINE r_rate       LIKE apeb_t.apeb101   #本幣匯率
   DEFINE r_amt        LIKE apeb_t.apeb109   #本幣金額
   
   #取本幣匯率
   CALL s_aooi160_get_exrate('1',g_apea_m.apeacomp,g_apea_m.apeadocdt,p_trans,p_curr,0,g_glaa025)
        RETURNING r_rate
   #本幣金額 = 原幣金額 * 本幣匯率
   LET r_amt = p_amt * r_rate
   
   IF cl_null(r_amt) THEN LET r_amt = 0 END IF
   
   CALL s_curr_round_ld('1',g_apea_m.apeald,g_glaa001,r_amt,2) 
    RETURNING g_sub_success,g_errno,r_amt 
    
   RETURN r_rate,r_amt
   
END FUNCTION
################################################################################
# Descriptions...: 合計頁簽計算及顯示
# Memo...........:
# Usage..........: CALL aapt410_sum_page_show()
# Date & Author..: 14/10/10 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt410_sum_page_show()
   DEFINE l_apee_plus  RECORD    #沖帳金額正的部分
              apee109  LIKE apee_t.apee109,
              apee119  LIKE apee_t.apee119
                       END RECORD 
   DEFINE l_apee_minus RECORD   #沖帳金額負的部分
              apee109  LIKE apee_t.apee109,
              apee119  LIKE apee_t.apee119
                       END RECORD

   LET g_apea_m.sum_apee1091 = NULL
   LET g_apea_m.sum_apee1092 = NULL
   LET g_apea_m.sum_apee1093 = NULL
   LET g_apea_m.sum_apee1094 = NULL

   LET g_apea_m.sum_apee1191 = NULL
   LET g_apea_m.sum_apee1192 = NULL
   LET g_apea_m.sum_apee1193 = NULL
   LET g_apea_m.sum_apee1194 = NULL
   
      
   ###收付款金額###
   #正
   INITIALIZE l_apee_plus.* TO NULL
   SELECT SUM(apee109),SUM(apee119) 
     INTO l_apee_plus.* 
     FROM apee_t
    WHERE apeeent = g_enterprise
      AND apeedocno = g_apea_m.apeadocno
      AND apee002 IN ('10','16')
      AND apee015 = 1 
   IF cl_null(l_apee_plus.apee109)THEN LET l_apee_plus.apee109 = 0 END IF
   IF cl_null(l_apee_plus.apee119)THEN LET l_apee_plus.apee119 = 0 END IF

   #負
   INITIALIZE l_apee_minus.* TO NULL
   SELECT SUM(apee109),SUM(apee119)
     INTO l_apee_minus.* 
     FROM apee_t
    WHERE apeeent = g_enterprise
      AND apeedocno = g_apea_m.apeadocno
      AND apee002 IN ('10','16')
      AND apee015 = -1 
   IF cl_null(l_apee_minus.apee109)THEN LET l_apee_minus.apee109 = 0 END IF
   IF cl_null(l_apee_minus.apee119)THEN LET l_apee_minus.apee119 = 0 END IF
   
   LET g_apea_m.sum_apee1091 = l_apee_plus.apee109 - l_apee_minus.apee109
   LET g_apea_m.sum_apee1191 = l_apee_plus.apee119 - l_apee_minus.apee119


   ####核銷請款金額###
   #正
   INITIALIZE l_apee_plus.* TO NULL
   SELECT SUM(apeb109),SUM(apeb119) 
     INTO l_apee_plus.* 
     FROM apeb_t
    WHERE apebent = g_enterprise
      AND apebdocno = g_apea_m.apeadocno
      AND apeb002 IN ('30','31','32','40','41','42')
      AND apeb015 = 1 
   IF cl_null(l_apee_plus.apee109)THEN LET l_apee_plus.apee109 = 0 END IF
   IF cl_null(l_apee_plus.apee119)THEN LET l_apee_plus.apee119 = 0 END IF

   #負
   INITIALIZE l_apee_minus.* TO NULL
   SELECT SUM(apeb109),SUM(apeb119)
     INTO l_apee_minus.* 
     FROM apeb_t
    WHERE apebent = g_enterprise
      AND apebdocno = g_apea_m.apeadocno
      AND apeb002 IN ('30','31','32','40','41','42')
      AND apeb015 = -1 
   IF cl_null(l_apee_minus.apee109)THEN LET l_apee_minus.apee109 = 0 END IF
   IF cl_null(l_apee_minus.apee119)THEN LET l_apee_minus.apee119 = 0 END IF

   LET g_apea_m.sum_apee1092 = l_apee_plus.apee109 - l_apee_minus.apee109
   LET g_apea_m.sum_apee1192 = l_apee_plus.apee119 - l_apee_minus.apee119
  
   ###匯差及調整金額###
   #正
   INITIALIZE l_apee_plus.* TO NULL
   SELECT SUM(apee109),SUM(apee119) 
     INTO l_apee_plus.* 
     FROM apee_t
    WHERE apeeent = g_enterprise
      AND apeedocno = g_apea_m.apeadocno
      AND apee002 NOT IN ('10','16')
      AND apee015 = 1 
   IF cl_null(l_apee_plus.apee109)THEN LET l_apee_plus.apee109 = 0 END IF
   IF cl_null(l_apee_plus.apee119)THEN LET l_apee_plus.apee119 = 0 END IF

   #負
   INITIALIZE l_apee_minus.* TO NULL
   SELECT SUM(apee109),SUM(apee119)
     INTO l_apee_minus.* 
     FROM apee_t
    WHERE apeeent = g_enterprise
      AND apeedocno = g_apea_m.apeadocno
      AND apee002 NOT IN ('10','16')
      AND apee015 = -1 
   IF cl_null(l_apee_minus.apee109)THEN LET l_apee_minus.apee109 = 0 END IF
   IF cl_null(l_apee_minus.apee119)THEN LET l_apee_minus.apee119 = 0 END IF

   LET g_apea_m.sum_apee1093 = l_apee_plus.apee109 - l_apee_minus.apee109
   LET g_apea_m.sum_apee1193 = l_apee_plus.apee119 - l_apee_minus.apee119
 
   ###合計金額###
   LET g_apea_m.sum_apee1094 = g_apea_m.sum_apee1091 - g_apea_m.sum_apee1092 + g_apea_m.sum_apee1093 
   LET g_apea_m.sum_apee1194 = g_apea_m.sum_apee1191 - g_apea_m.sum_apee1192 + g_apea_m.sum_apee1193

   DISPLAY BY NAME g_apea_m.sum_apee1094,g_apea_m.sum_apee1091,g_apea_m.sum_apee1092,g_apea_m.sum_apee1093,
                   g_apea_m.sum_apee1194,g_apea_m.sum_apee1191,g_apea_m.sum_apee1192,g_apea_m.sum_apee1193
                   
END FUNCTION
################################################################################
# Descriptions...: 做差異處理
# Memo...........:
# Usage..........: CALL aapt410_open_aapt410_09()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/10/13 By apo
# Modify.........:
################################################################################
PRIVATE FUNCTION aapt410_open_aapt410_09()
   DEFINE r_redo_body   LIKE type_t.num5
   LET r_redo_body = FALSE
   CALL s_transaction_begin()
   OPEN aapt410_cl USING g_enterprise,g_apea_m.apeadocno
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN aapt410_cl:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE aapt410_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF 
   
   CALL aapt410_09(g_apea_m.apeald,g_apea_m.apeadocno) RETURNING r_redo_body
   CALL s_transaction_end('Y','0')
   RETURN r_redo_body
END FUNCTION

PRIVATE FUNCTION aapt410_set_no_required()
   CALL cl_set_comp_required("apee008,apee011,apee012,apee013,apee014,apee021,apee024,apee032,apee039,apee040",FALSE)
END FUNCTION

PRIVATE FUNCTION aapt410_set_required()
DEFINE l_ooia011     LIKE ooia_t.ooia011
   IF l_ac > 0 THEN
      #此處考量未來欄位控制可能因付款類型不同而有差異,因此以CASE拆分來寫,方便維護
		CASE g_apeb2_d[l_ac].apee002
		   WHEN '10'
		      CALL cl_set_comp_required("apee032",TRUE)	 
		      IF g_para_data1 = 'Y' THEN
               IF (g_apeb2_d[l_ac].apee006 = '10' OR g_apeb2_d[l_ac].apee006 = '20' OR g_apeb2_d[l_ac].apee006 = '30') THEN
                  CALL cl_set_comp_required("apee008,apee11,apee012",TRUE)			   
               END IF
               IF g_apeb2_d[l_ac].apee006 = '30' THEN
                  SELECT ooia011 INTO l_ooia011
                   FROM ooia_t WHERE ooia001 = g_apeb2_d[l_ac].apee021
                  #即期票據                
                  IF l_ooia011 = 'Y' THEN
                     CALL cl_set_comp_required("apee024,apee039,apee040,apee014",TRUE)	
                  END IF                  
               END IF
               IF g_apeb2_d[l_ac].apee006 = '20' THEN
                  CALL cl_set_comp_required("apee039,apee040",TRUE)	          
               END IF                    
            END IF
            
            IF g_apeb2_d[l_ac].apee006 = '30' THEN
               CALL cl_set_comp_required("apee021",TRUE)	          
            END IF   
         WHEN '20'            
            CALL cl_set_comp_required("apee013,apee014",TRUE)	  
         WHEN '21'
            CALL cl_set_comp_required("apee013,apee014",TRUE)	  
         WHEN '22'
            CALL cl_set_comp_required("apee013,apee014",TRUE)	  
      END CASE
   END IF      
END FUNCTION

 
{</section>}
 
