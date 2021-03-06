#該程式未解開Section, 採用最新樣板產出!
{<section id="axct322.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0010(2014-09-16 16:16:29), PR版次:0010(2016-12-05 11:39:24)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000111
#+ Filename...: axct322
#+ Description: 雜收入庫成本次要素維護作業
#+ Creator....: 03297(2014-08-30 19:31:41)
#+ Modifier...: 03297 -SD/PR- 02749
 
{</section>}
 
{<section id="axct322.global" >}
#應用 i07 樣板自動產生(Version:49)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#47    2016/03/28  by pengxin  修正azzi920重复定义之错误讯息
#160318-00025#12    2016/04/26  By 07675    將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160802-00020#5     2016/10/12  By 02040    增加帳套權限管控、法人權限管控
#160824-00007#223   2016/12/02  By lori     修正舊值備份寫法
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
PRIVATE type type_g_xcdw_m        RECORD
       xcdwld LIKE xcdw_t.xcdwld, 
   xcdwld_desc LIKE type_t.chr80, 
   xcdwcomp LIKE xcdw_t.xcdwcomp, 
   xcdwcomp_desc LIKE type_t.chr80, 
   xcdw003 LIKE xcdw_t.xcdw003, 
   xcdw003_desc LIKE type_t.chr80, 
   xcdw006 LIKE xcdw_t.xcdw006, 
   xcdw013 LIKE xcdw_t.xcdw013, 
   xcdw014 LIKE xcdw_t.xcdw014, 
   xcdw004 LIKE xcdw_t.xcdw004, 
   xcdw005 LIKE xcdw_t.xcdw005, 
   xcat003 LIKE xcat_t.xcat003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xcdw_d        RECORD
       xcdw001 LIKE xcdw_t.xcdw001, 
   xcdw007 LIKE xcdw_t.xcdw007, 
   xcdw008 LIKE xcdw_t.xcdw008, 
   xcdw009 LIKE xcdw_t.xcdw009, 
   xcdw002 LIKE xcdw_t.xcdw002, 
   xcdw002_desc LIKE type_t.chr500, 
   xcdwsite LIKE xcdw_t.xcdwsite, 
   xcdw011 LIKE xcdw_t.xcdw011, 
   xcdw011_desc LIKE type_t.chr500, 
   xcdw011_desc_desc LIKE type_t.chr500, 
   xcdw012 LIKE xcdw_t.xcdw012, 
   xcdw010 LIKE xcdw_t.xcdw010, 
   xcdw010_desc LIKE type_t.chr500, 
   xcdw016 LIKE xcdw_t.xcdw016, 
   xcdw016_desc LIKE type_t.chr500, 
   xcdw017 LIKE xcdw_t.xcdw017, 
   xcdw017_desc LIKE type_t.chr500, 
   xcdw018 LIKE xcdw_t.xcdw018, 
   xcdw201 LIKE xcdw_t.xcdw201, 
   xcdw202 LIKE xcdw_t.xcdw202, 
   xcdw020 LIKE xcdw_t.xcdw020, 
   xcdw021 LIKE xcdw_t.xcdw021, 
   xcdw021_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_xcdw2_d RECORD
       xcdw001 LIKE xcdw_t.xcdw001, 
   xcdw007 LIKE xcdw_t.xcdw007, 
   xcdw008 LIKE xcdw_t.xcdw008, 
   xcdw009 LIKE xcdw_t.xcdw009, 
   xcdw002 LIKE xcdw_t.xcdw002, 
   xcdw002_2_desc LIKE type_t.chr500, 
   xcdwsite LIKE xcdw_t.xcdwsite, 
   xcdw010 LIKE xcdw_t.xcdw010, 
   xcdw010_2_desc LIKE type_t.chr500, 
   xcdw011 LIKE xcdw_t.xcdw011, 
   xcdw011_2_desc LIKE type_t.chr500, 
   xcdw011_2_desc_desc LIKE type_t.chr500, 
   xcdw012 LIKE xcdw_t.xcdw012, 
   xcdw032 LIKE xcdw_t.xcdw032, 
   xcdw033 LIKE xcdw_t.xcdw033, 
   xcdw022 LIKE xcdw_t.xcdw022, 
   xcdw023 LIKE xcdw_t.xcdw023, 
   xcdw024 LIKE xcdw_t.xcdw024, 
   xcdw025 LIKE xcdw_t.xcdw025, 
   xcdw026 LIKE xcdw_t.xcdw026, 
   xcdw027 LIKE xcdw_t.xcdw027, 
   xcdw028 LIKE xcdw_t.xcdw028, 
   xcdw029 LIKE xcdw_t.xcdw029, 
   xcdw030 LIKE xcdw_t.xcdw030, 
   xcdw031 LIKE xcdw_t.xcdw031, 
   xcdw034 LIKE xcdw_t.xcdw034, 
   xcdw201 LIKE xcdw_t.xcdw201, 
   xcdw202 LIKE xcdw_t.xcdw202, 
   xcdw021 LIKE xcdw_t.xcdw021, 
   xcdw021_2_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_xcdw3_d        RECORD
       xcdw001 LIKE xcdw_t.xcdw001, 
   xcdw007 LIKE xcdw_t.xcdw007, 
   xcdw008 LIKE xcdw_t.xcdw008, 
   xcdw009 LIKE xcdw_t.xcdw009, 
   xcdw002 LIKE xcdw_t.xcdw002, 
   xcdw002_desc LIKE type_t.chr500, 
   xcdwsite LIKE xcdw_t.xcdwsite,
   xcdw010 LIKE xcdw_t.xcdw010, 
   xcdw010_desc LIKE type_t.chr500,  
   xcdw011 LIKE xcdw_t.xcdw011, 
   xcdw011_desc LIKE type_t.chr500, 
   xcdw011_desc_desc LIKE type_t.chr500, 
   xcdw012 LIKE xcdw_t.xcdw012,  
   xcdw016 LIKE xcdw_t.xcdw016, 
   xcdw016_desc LIKE type_t.chr500, 
   xcdw017 LIKE xcdw_t.xcdw017, 
   xcdw017_desc LIKE type_t.chr500, 
   xcdw018 LIKE xcdw_t.xcdw018,   
   xcdw201 LIKE xcdw_t.xcdw201, 
   xcdw202 LIKE xcdw_t.xcdw202,
   xcdw020 LIKE xcdw_t.xcdw020, 
   xcdw021 LIKE xcdw_t.xcdw021, 
   xcdw021_desc LIKE type_t.chr500
       END RECORD
 TYPE type_g_xcdw4_d        RECORD
       xcdw001 LIKE xcdw_t.xcdw001, 
   xcdw007 LIKE xcdw_t.xcdw007, 
   xcdw008 LIKE xcdw_t.xcdw008, 
   xcdw009 LIKE xcdw_t.xcdw009, 
   xcdw002 LIKE xcdw_t.xcdw002, 
   xcdw002_desc LIKE type_t.chr500, 
   xcdwsite LIKE xcdw_t.xcdwsite,
   xcdw010 LIKE xcdw_t.xcdw010, 
   xcdw010_desc LIKE type_t.chr500,  
   xcdw011 LIKE xcdw_t.xcdw011, 
   xcdw011_desc LIKE type_t.chr500, 
   xcdw011_desc_desc LIKE type_t.chr500, 
   xcdw012 LIKE xcdw_t.xcdw012,  
   xcdw016 LIKE xcdw_t.xcdw016, 
   xcdw016_desc LIKE type_t.chr500, 
   xcdw017 LIKE xcdw_t.xcdw017, 
   xcdw017_desc LIKE type_t.chr500, 
   xcdw018 LIKE xcdw_t.xcdw018,  
   xcdw201 LIKE xcdw_t.xcdw201, 
   xcdw202 LIKE xcdw_t.xcdw202,
   xcdw020 LIKE xcdw_t.xcdw020, 
   xcdw021 LIKE xcdw_t.xcdw021, 
   xcdw021_desc LIKE type_t.chr500
       END RECORD
       
DEFINE g_xcdw3_d          DYNAMIC ARRAY OF type_g_xcdw3_d
DEFINE g_xcdw3_d_t        type_g_xcdw3_d
DEFINE g_xcdw3_d_o        type_g_xcdw3_d
DEFINE g_xcdw4_d          DYNAMIC ARRAY OF type_g_xcdw4_d
DEFINE g_xcdw4_d_t        type_g_xcdw4_d 
DEFINE g_xcdw4_d_o        type_g_xcdw4_d

DEFINE g_glaa015          LIKE glaa_t.glaa015
DEFINE g_glaa019          LIKE glaa_t.glaa019
DEFINE g_glaa001          LIKE glaa_t.glaa001
DEFINE g_glaa003          LIKE glaa_t.glaa003
DEFINE g_glaa016          LIKE glaa_t.glaa016
DEFINE g_glaa018          LIKE glaa_t.glaa018
DEFINE g_glaa020          LIKE glaa_t.glaa020
DEFINE g_glaa022          LIKE glaa_t.glaa022
DEFINE g_glaa025          LIKE glaa_t.glaa025
DEFINE g_bdate            LIKE glav_t.glav004
DEFINE g_edate            LIKE glav_t.glav004
DEFINE g_sql_sum          STRING
DEFINE g_xcdw013_p        LIKE xcdw_t.xcdw013 
DEFINE g_para_data        LIKE type_t.chr80     #采用成本域否
DEFINE g_today          DATETIME YEAR TO SECOND
#fengmy add 141219-----begin  table alter
DEFINE g_xcdw047          LIKE xcdw_t.xcdw047   #在制单号(工单号/重复性代号)
DEFINE g_xcdw048          LIKE xcdw_t.xcdw048   #重複性生產-計畫編號
DEFINE g_xcdw049          LIKE xcdw_t.xcdw049   #重複性生產-生產料號
DEFINE g_xcdw050          LIKE xcdw_t.xcdw050   #重複性生產-生產料號BOM特性
DEFINE g_xcdw051          LIKE xcdw_t.xcdw051   #重複性生產-生產料號產品特徵
#fengmy add 141219-----end    table alter
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
 
#模組變數(Module Variables)
DEFINE g_xcdw_m          type_g_xcdw_m
DEFINE g_xcdw_m_t        type_g_xcdw_m
DEFINE g_xcdw_m_o        type_g_xcdw_m
DEFINE g_xcdw_m_mask_o   type_g_xcdw_m #轉換遮罩前資料
DEFINE g_xcdw_m_mask_n   type_g_xcdw_m #轉換遮罩後資料
 
   DEFINE g_xcdwld_t LIKE xcdw_t.xcdwld
DEFINE g_xcdw003_t LIKE xcdw_t.xcdw003
DEFINE g_xcdw006_t LIKE xcdw_t.xcdw006
DEFINE g_xcdw004_t LIKE xcdw_t.xcdw004
DEFINE g_xcdw005_t LIKE xcdw_t.xcdw005
 
 
DEFINE g_xcdw_d          DYNAMIC ARRAY OF type_g_xcdw_d
DEFINE g_xcdw_d_t        type_g_xcdw_d
DEFINE g_xcdw_d_o        type_g_xcdw_d
DEFINE g_xcdw_d_mask_o   DYNAMIC ARRAY OF type_g_xcdw_d #轉換遮罩前資料
DEFINE g_xcdw_d_mask_n   DYNAMIC ARRAY OF type_g_xcdw_d #轉換遮罩後資料
DEFINE g_xcdw2_d   DYNAMIC ARRAY OF type_g_xcdw2_d
DEFINE g_xcdw2_d_t type_g_xcdw2_d
DEFINE g_xcdw2_d_o type_g_xcdw2_d
DEFINE g_xcdw2_d_mask_o   DYNAMIC ARRAY OF type_g_xcdw2_d #轉換遮罩前資料
DEFINE g_xcdw2_d_mask_n   DYNAMIC ARRAY OF type_g_xcdw2_d #轉換遮罩後資料
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xcdwld LIKE xcdw_t.xcdwld,
      b_xcdw003 LIKE xcdw_t.xcdw003,
      b_xcdw004 LIKE xcdw_t.xcdw004,
      b_xcdw005 LIKE xcdw_t.xcdw005,
      b_xcdw006 LIKE xcdw_t.xcdw006
       #,rank           LIKE type_t.num10
      END RECORD 
 
DEFINE g_wc                  STRING
DEFINE g_wc_t                STRING
DEFINE g_wc2                 STRING                          #單身CONSTRUCT結果
DEFINE g_wc2_table1          STRING 
 
 
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
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
 
DEFINE g_pagestart           LIKE type_t.num10           
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
 
DEFINE g_detail_cnt          LIKE type_t.num10             #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num10             #單身目前所在筆數
DEFINE g_detail_idx2         LIKE type_t.num10             #單身2目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num10             #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num10             #Browser目前所在筆數(暫存用)
DEFINE g_current_page        LIKE type_t.num10             #目前所在頁數
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_aw                  STRING                        #確定當下點擊的單身
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #log用
DEFINE g_log2                STRING                        #log用
DEFINE g_add_browse          STRING                        #新增填充用WC
DEFINE g_loc                 LIKE type_t.chr5              #判斷游標所在位置
DEFINE g_master_insert       BOOLEAN                       #確認單頭資料是否寫入(僅用於三階)
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axct322.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
#  LET g_ld = g_argv[01] 
#  DISPLAY g_ld
   LET g_xcdw013_p = g_argv[01]  
   DISPLAY "g_xcdw013_p = ",g_xcdw013_p 
   #160802-00020#5-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#5-e-add    
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   LET g_sql_sum = " SELECT xcdw001,xcdw002,xcdw007,xcdw008,xcdw009", 
                      " FROM xcdw_t",
                      " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND  
                          xcdw006=? "   
   LET g_sql_sum = g_sql_sum CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"   
   LET g_sql_sum = g_sql_sum CLIPPED,
                      "  ORDER BY xcdw001,xcdw007,xcdw008,xcdw002,xcdw009"
   
   DECLARE axct322_sum_cs CURSOR FROM g_sql_sum  
   
   LET g_sql = " SELECT xcdw010", 
                      " FROM xcdw_t",
                      " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND  
                          xcdw006=? AND xcdw001 = ? "   
   LET g_sql = g_sql CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"   
   LET g_sql = g_sql CLIPPED,
                      "  ORDER BY xcdw001,xcdw007,xcdw008,xcdw002,xcdw009"
   
   DECLARE axct322_xcdw010_cs CURSOR FROM g_sql 
   #end add-point
   LET g_forupd_sql = " SELECT xcdwld,'',xcdwcomp,'',xcdw003,'',xcdw006,xcdw013,xcdw014,xcdw004,xcdw005, 
       ''", 
                      " FROM xcdw_t",
                      " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND  
                          xcdw006=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct322_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.xcdwld,t0.xcdwcomp,t0.xcdw003,t0.xcdw006,t0.xcdw013,t0.xcdw014,t0.xcdw004, 
       t0.xcdw005,t1.glaal003 ,t2.ooefl003 ,t3.xcatl003",
               " FROM xcdw_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent="||g_enterprise||" AND t1.glaal001=t0.xcdwld AND t1.glaal002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.xcdwcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent="||g_enterprise||" AND t3.xcatl001=t0.xcdw003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xcdwent = " ||g_enterprise|| " AND t0.xcdwld = ? AND t0.xcdw003 = ? AND t0.xcdw004 = ? AND t0.xcdw005 = ? AND t0.xcdw006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   LET g_sql = g_sql CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"
   
   #end add-point
   PREPARE axct322_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct322 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct322_init()   
 
      #進入選單 Menu (="N")
      CALL axct322_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct322
      
   END IF 
   
   CLOSE axct322_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axct322.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct322_init()
   #add-point:init段define name="init.define_customerization"
   
   #end add-point   
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_str1     STRING
   DEFINE l_str2     STRING
   DEFINE l_str3     STRING
   DEFINE l_str4     STRING
   DEFINE l_str5     STRING
   DEFINE l_str6     STRING
   DEFINE l_str7     STRING
   DEFINE l_str8     STRING
   DEFINE l_msg1     STRING
   DEFINE l_msg2     STRING
   #end add-point
   
   #add-point:Function前置處理  name="init.pre_function"
   
   #end add-point
   
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcat003','8904') 
   CALL cl_set_combo_scc('xcdw001','8914') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('xcdw013','8917')
   
   LET l_str1 = cl_getmsg("axc-00235",g_lang)   #雜收明細
   LET l_str2 = cl_getmsg("axc-00236",g_lang)   #雜發明細
   LET l_str3 = cl_getmsg("axc-00237",g_lang)   #當站下線
   LET l_str4 = cl_getmsg("axc-00238",g_lang)   #同業借料明細
   LET l_str5 = cl_getmsg("axc-00239",g_lang)   #成本信息
   LET l_str6 = cl_getmsg("axc-00240",g_lang)   #財務信息
   LET l_str7 = cl_getmsg("axc-00278",g_lang)   #調撥明細
   LET l_str8 = cl_getmsg("axc-00279",g_lang)   #調撥成本
    
   IF g_xcdw013_p = '1' THEN 
      LET l_msg1 = l_str1 CLIPPED,l_str5 
      LET l_msg2 = l_str1 CLIPPED,l_str6
   END IF  
   IF g_xcdw013_p = '2' THEN 
      LET l_msg1 = l_str2 CLIPPED,l_str5 
      LET l_msg2 = l_str2 CLIPPED,l_str6
   END IF 
   IF g_xcdw013_p = '3' THEN 
      LET l_msg1 = l_str3 CLIPPED,l_str5 
      LET l_msg2 = l_str3 CLIPPED,l_str6
   END IF 
   IF g_xcdw013_p = '4' THEN 
      LET l_msg1 = l_str4 CLIPPED,l_str5 
      LET l_msg2 = l_str4 CLIPPED,l_str6
   END IF 
   IF g_xcdw013_p = '5' THEN 
      LET l_msg1 = l_str7 CLIPPED,l_str5 
      LET l_msg2 = l_str8 CLIPPED,l_str6
   END IF 
   CALL cl_set_comp_att_text('bpage_1',l_msg1)
   CALL cl_set_comp_att_text('page_3',l_msg2)  
   CASE g_xcdw013_p
      WHEN '1'
         CALL cl_set_act_visible_toolbaritem("axct312",TRUE)
         CALL cl_set_act_visible_toolbaritem("axct313",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct314",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct316",FALSE)
      WHEN '2'
         CALL cl_set_act_visible_toolbaritem("axct312",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct313",TRUE)
         CALL cl_set_act_visible_toolbaritem("axct314",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct316",FALSE)
      WHEN '3' 
         CALL cl_set_act_visible_toolbaritem("axct312",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct313",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct314",TRUE)
         CALL cl_set_act_visible_toolbaritem("axct316",FALSE)
      WHEN '5'
         CALL cl_set_act_visible_toolbaritem("axct312",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct313",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct314",FALSE)
         CALL cl_set_act_visible_toolbaritem("axct316",TRUE)
   END CASE 
   LET g_today=cl_get_today()
   CALL cl_set_comp_visible('xcdw002,xcdw002_desc,xcdw002_2,xcdw002_2_desc,xcdw002_3,xcdw002_3_desc,xcdw002_4,xcdw002_4_desc',FALSE)
   #end add-point
   
   CALL axct322_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct322.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct322_ui_dialog()
   #add-point:ui_dialog段define name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE la_param  RECORD
          prog                  STRING,
          actionid              STRING,
          background            LIKE type_t.chr1,
          param                 DYNAMIC ARRAY OF STRING
                                END RECORD
   DEFINE ls_js                 STRING
   DEFINE li_idx                LIKE type_t.num10
   DEFINE ls_wc                 STRING
   DEFINE lb_first              BOOLEAN
   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
   #add-point:ui_dialog段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_str     STRING
   #end add-point  
   
   #add-point:Function前置處理  name="ui_dialog.pre_function"
   
   #end add-point
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE
      
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_xcdw_m.* TO NULL
         CALL g_xcdw_d.clear()
         CALL g_xcdw2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL axct322_init()
      END IF
 
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xcdw_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               #顯示單身筆數
               CALL axct322_idx_chk()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axct322_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_current_page = 1
    
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xcdw2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               LET g_curr_diag = ui.DIALOG.getCurrent()
               CALL axct322_idx_chk()
               CALL axct322_ui_detailshow()
               
               #add-point:page1自定義行為 name="ui_dialog.body2.before_row"
               
               #end add-point
            
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               IF g_loc = 'm' THEN
                  CALL FGL_SET_ARR_CURR(g_detail_idx)
               END IF
               LET g_loc = 'm'     
               LET g_current_page = 2
            
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_xcdw3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct322_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_xcdw4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct322_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
            #先填充browser資料
            CALL axct322_browser_fill("")
            CALL cl_notice()
            CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL g_curr_diag.setSelectionMode("s_detail1",1)         
            LET g_page = "first"
            LET g_current_sw = FALSE
            #回歸舊筆數位置 (回到當時異動的筆數)
            IF g_current_row > 1 AND g_current_idx = 1 AND g_current_sw = FALSE THEN
               LET g_current_idx = g_current_row
            END IF
            LET g_current_row = g_current_idx #目前指標
            LET g_current_sw = TRUE
            
            IF g_current_idx > g_browser.getLength() THEN
               LET g_current_idx = g_browser.getLength()
            END IF 
            
            IF g_current_idx = 0 AND g_browser.getLength() > 0 THEN
               LET g_current_idx = 1 
            END IF
            
            #有資料才進行fetch
            IF g_current_idx <> 0 THEN
               CALL axct322_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct322_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2 name="ui_dialog.before_dialog2"
            
            #end add-point
 
         
    
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL axct322_fetch('F')
            LET g_current_row = g_current_idx         
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL axct322_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            LET g_action_choice = ""
          
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL axct322_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            LET g_action_choice = ""
        
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL axct322_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            LET g_action_choice = ""
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL axct322_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            LET g_action_choice = ""
            
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
                  LET g_export_node[1] = base.typeInfo.create(g_xcdw_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xcdw2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  
                  #END add-point
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            END IF
          
         ON ACTION close
            LET INT_FLAG=FALSE        
            LET g_action_choice = "exit"
            EXIT DIALOG     
          
         ON ACTION exit
            LET g_action_choice = "exit"
            EXIT DIALOG
          
            
         ON ACTION worksheethidden   #瀏覽頁折疊
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
               NEXT FIELD xcdw001
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Alt-s"開啟/關閉單頭
            IF g_header_hidden THEN
               CALL gfrm_curr.setElementHidden("vb_master",0)
               CALL gfrm_curr.setElementImage("controls","small/arr-u.png")
               LET g_header_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("vb_master",1)
               CALL gfrm_curr.setElementImage("controls","small/arr-d.png")
               LET g_header_hidden = 1     #hidden     
            END IF
            
         ON ACTION queryplansel
            CALL cl_dlg_qryplan_select() RETURNING ls_wc
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL axct322_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct322_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CLEAR FORM
               ELSE
                  CALL axct322_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct316
            LET g_action_choice="axct316"
            IF cl_auth_chk_act("axct316") THEN
               
               #add-point:ON ACTION axct316 name="menu.axct316"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "axct316"               
               LET la_param.param[1] = g_xcdw_m.xcdwld                     
               LET la_param.param[2] = g_xcdw_m.xcdw003
               LET la_param.param[3] = g_xcdw_m.xcdw004
               LET la_param.param[4] = g_xcdw_m.xcdw005
               LET la_param.param[5] = g_xcdw_m.xcdw006                            
               LET ls_js = util.JSON.stringify(la_param)
               DISPLAY ls_js
               CALL cl_cmdrun(ls_js) 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct322_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct322_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct314
            LET g_action_choice="axct314"
            IF cl_auth_chk_act("axct314") THEN
               
               #add-point:ON ACTION axct314 name="menu.axct314"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "axct314"               
               LET la_param.param[1] = g_xcdw_m.xcdwld                     
               LET la_param.param[2] = g_xcdw_m.xcdw003
               LET la_param.param[3] = g_xcdw_m.xcdw004
               LET la_param.param[4] = g_xcdw_m.xcdw005
               LET la_param.param[5] = g_xcdw_m.xcdw006                            
               LET ls_js = util.JSON.stringify(la_param)
               DISPLAY ls_js
               CALL cl_cmdrun(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct313
            LET g_action_choice="axct313"
            IF cl_auth_chk_act("axct313") THEN
               
               #add-point:ON ACTION axct313 name="menu.axct313"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "axct313"               
               LET la_param.param[1] = g_xcdw_m.xcdwld                     
               LET la_param.param[2] = g_xcdw_m.xcdw003
               LET la_param.param[3] = g_xcdw_m.xcdw004
               LET la_param.param[4] = g_xcdw_m.xcdw005
               LET la_param.param[5] = g_xcdw_m.xcdw006                            
               LET ls_js = util.JSON.stringify(la_param)
               DISPLAY ls_js
               CALL cl_cmdrun(ls_js)
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/axc/axct322_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               &include "erp/axc/axct322_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct322_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION axct312
            LET g_action_choice="axct312"
            IF cl_auth_chk_act("axct312") THEN
               
               #add-point:ON ACTION axct312 name="menu.axct312"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "axct312"               
               LET la_param.param[1] = g_xcdw_m.xcdwld                     
               LET la_param.param[2] = g_xcdw_m.xcdw003
               LET la_param.param[3] = g_xcdw_m.xcdw004
               LET la_param.param[4] = g_xcdw_m.xcdw005
               LET la_param.param[5] = g_xcdw_m.xcdw006                            
               LET ls_js = util.JSON.stringify(la_param)
               DISPLAY ls_js
               CALL cl_cmdrun(ls_js)
                  
               #END add-point
               
            END IF
 
 
 
 
         
         
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL axct322_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct322_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct322_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
         
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl" 
         CONTINUE DIALOG
            
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
   
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct322_browser_search(p_type)
   #add-point:browser_search段define name="browser_search.define_customerization"
   
   #end add-point   
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_search.define"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct322_browser_fill(ps_page_action)
   #add-point:browser_fill段define name="browser_fill.define_customerization"
   
   #end add-point   
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="browser_fill.before_browser_fill"
   
   IF cl_null(g_wc) THEN 
      IF g_xcdw013_p = '1' THEN 
         LET g_wc = " AND xcdw013 = '1' "
      END IF
      IF g_xcdw013_p = '2' THEN 
         LET g_wc = " AND xcdw013 = '2' "
      END IF
      IF g_xcdw013_p = '3' THEN 
         LET g_wc = " AND xcdw013 = '3' "
      END IF
      IF g_xcdw013_p = '4' THEN 
         LET g_wc = " AND xcdw013 = '4' "
      END IF
      IF g_xcdw013_p = '5' THEN 
         LET g_wc = " AND xcdw013 = '5' "
      END IF
   ELSE   
      IF g_xcdw013_p = '1' THEN 
         LET g_wc = g_wc CLIPPED," AND xcdw013 = '1' "
      END IF
      IF g_xcdw013_p = '2' THEN 
         LET g_wc = g_wc CLIPPED," AND xcdw013 = '2' "
      END IF
      IF g_xcdw013_p = '3' THEN 
         LET g_wc = g_wc CLIPPED," AND xcdw013 = '3' "
      END IF
      IF g_xcdw013_p = '4' THEN 
         LET g_wc = g_wc CLIPPED," AND xcdw013 = '4' "
      END IF
      IF g_xcdw013_p = '5' THEN 
         LET g_wc = g_wc CLIPPED," AND xcdw013 = '5' "
      END IF
   END IF
   #end add-point    
 
   LET l_searchcol = "xcdwld,xcdw003,xcdw004,xcdw005,xcdw006"
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT xcdwld ",
                      ", xcdw003 ",
                      ", xcdw004 ",
                      ", xcdw005 ",
                      ", xcdw006 ",
 
                      " FROM xcdw_t ",
                      " ",
                      " ", 
 
 
 
                      " WHERE xcdwent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xcdw_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT xcdwld ",
                      ", xcdw003 ",
                      ", xcdw004 ",
                      ", xcdw005 ",
                      ", xcdw006 ",
 
                      " FROM xcdw_t ",
                      " ",
                      " ", 
 
 
                      " WHERE xcdwent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("xcdw_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前 name="browser_fill.before_count"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xcdwld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xcdwcomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(1) FROM (",l_sub_sql,")"
   #160802-00020#5-e-add   
   #end add-point
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE header_cnt_pre FROM g_sql
      EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
      FREE header_cnt_pre
   END IF
   
   #若超過最大顯示筆數
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
   LET g_error_show = 0
 
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM                
      INITIALIZE g_xcdw_m.* TO NULL
      CALL g_xcdw_d.clear()        
      CALL g_xcdw2_d.clear() 
 
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.xcdwld,t0.xcdw003,t0.xcdw004,t0.xcdw005,t0.xcdw006 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xcdwld,t0.xcdw003,t0.xcdw004,t0.xcdw005,t0.xcdw006",
                " FROM xcdw_t t0",
                #" ",
                " ",
 
 
 
                
                " WHERE t0.xcdwent = " ||g_enterprise|| " AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xcdw_t")
 
   #add-point:browser_fill,sql_rank前 name="browser_fill.before_sql_rank"
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xcdwld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xcdwcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add  
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前 name="browser_fill.before_pre"
   IF g_browser_cnt = 0 THEN 
      INITIALIZE g_xcdw_m.* TO NULL
      RETURN
   END IF
   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xcdw_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_xcdwld,g_browser[g_cnt].b_xcdw003,g_browser[g_cnt].b_xcdw004, 
          g_browser[g_cnt].b_xcdw005,g_browser[g_cnt].b_xcdw006 
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
   
   IF cl_null(g_browser[g_cnt].b_xcdwld) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xcdw_m.* TO NULL
      CALL g_xcdw_d.clear()
      CALL g_xcdw2_d.clear()
 
      #add-point:browser_fill段after_clear name="browser_fill.after_clear"
      CALL g_xcdw3_d.clear()
      CALL g_xcdw4_d.clear() 
      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   LET g_browser_cnt = g_browser.getLength()
   CALL axct322_fetch('')
   
   #筆數顯示
   LET g_browser_idx = g_current_idx 
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
    
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
 
   #add-point:browser_fill段結束前 name="browser_fill.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct322_ui_headershow()
   #add-point:ui_headershow段define name="ui_headershow.define_customerization"
   
   #end add-point    
   #add-point:ui_headershow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_xcdw_m.xcdwld = g_browser[g_current_idx].b_xcdwld   
   LET g_xcdw_m.xcdw003 = g_browser[g_current_idx].b_xcdw003   
   LET g_xcdw_m.xcdw004 = g_browser[g_current_idx].b_xcdw004   
   LET g_xcdw_m.xcdw005 = g_browser[g_current_idx].b_xcdw005   
   LET g_xcdw_m.xcdw006 = g_browser[g_current_idx].b_xcdw006   
 
   EXECUTE axct322_master_referesh USING g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcdw006 INTO g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp_desc, 
       g_xcdw_m.xcdw003_desc
   CALL axct322_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct322_ui_detailshow()
   #add-point:ui_detailshow段define name="ui_detailshow.define_customerization"
   
   #end add-point
   #add-point:ui_detailshow段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_detailshow.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="ui_detailshow.before"
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
      #add-point:ui_detailshow段more name="ui_detailshow.more"
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx) 
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx) 
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after name="ui_detailshow.after"
   CALL axct322_show()
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct322_ui_browser_refresh()
   #add-point:ui_browser_refresh段define name="ui_browser_refresh.define_customerization"
   
   #end add-point   
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_browser_refresh.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="ui_browser_refresh.pre_function"
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xcdwld = g_xcdw_m.xcdwld 
         AND g_browser[l_i].b_xcdw003 = g_xcdw_m.xcdw003 
         AND g_browser[l_i].b_xcdw004 = g_xcdw_m.xcdw004 
         AND g_browser[l_i].b_xcdw005 = g_xcdw_m.xcdw005 
         AND g_browser[l_i].b_xcdw006 = g_xcdw_m.xcdw006 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
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
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct322_construct()
   #add-point:cs段define name="cs.define_customerization"
   
   #end add-point    
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="cs.pre_function"
   
   #end add-point
   
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xcdw_m.* TO NULL
   CALL g_xcdw_d.clear()
   CALL g_xcdw2_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外 name="cs.head.before"
   
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw013,xcdw014,xcdw004,xcdw005
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
                 #Ctrlp:construct.c.xcdwld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwld
            #add-point:ON ACTION controlp INFIELD xcdwld name="construct.c.xcdwld"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #160802-00020#5-s-add
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #160802-00020#5-e-add             
            CALL q_authorised_ld()                           #呼叫開窗            
            DISPLAY g_qryparam.return1 TO xcdwld  #顯示到畫面上
            NEXT FIELD xcdwld                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwld
            #add-point:BEFORE FIELD xcdwld name="construct.b.xcdwld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwld
            
            #add-point:AFTER FIELD xcdwld name="construct.a.xcdwld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdwcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwcomp
            #add-point:ON ACTION controlp INFIELD xcdwcomp name="construct.c.xcdwcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
           #160802-00020#5-s-add 
            #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
           #160802-00020#5-e-add             
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdwcomp  #顯示到畫面上
            NEXT FIELD xcdwcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwcomp
            #add-point:BEFORE FIELD xcdwcomp name="construct.b.xcdwcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwcomp
            
            #add-point:AFTER FIELD xcdwcomp name="construct.a.xcdwcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw003
            #add-point:ON ACTION controlp INFIELD xcdw003 name="construct.c.xcdw003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw003  #顯示到畫面上
            NEXT FIELD xcdw003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw003
            #add-point:BEFORE FIELD xcdw003 name="construct.b.xcdw003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw003
            
            #add-point:AFTER FIELD xcdw003 name="construct.a.xcdw003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw006
            #add-point:ON ACTION controlp INFIELD xcdw006 name="construct.c.xcdw006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inbadocno_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw006  #顯示到畫面上
            NEXT FIELD xcdw006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw006
            #add-point:BEFORE FIELD xcdw006 name="construct.b.xcdw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw006
            
            #add-point:AFTER FIELD xcdw006 name="construct.a.xcdw006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw013
            #add-point:BEFORE FIELD xcdw013 name="construct.b.xcdw013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw013
            
            #add-point:AFTER FIELD xcdw013 name="construct.a.xcdw013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw013
            #add-point:ON ACTION controlp INFIELD xcdw013 name="construct.c.xcdw013"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw014
            #add-point:BEFORE FIELD xcdw014 name="construct.b.xcdw014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw014
            
            #add-point:AFTER FIELD xcdw014 name="construct.a.xcdw014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw014
            #add-point:ON ACTION controlp INFIELD xcdw014 name="construct.c.xcdw014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw004
            #add-point:BEFORE FIELD xcdw004 name="construct.b.xcdw004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw004
            
            #add-point:AFTER FIELD xcdw004 name="construct.a.xcdw004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw004
            #add-point:ON ACTION controlp INFIELD xcdw004 name="construct.c.xcdw004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw005
            #add-point:BEFORE FIELD xcdw005 name="construct.b.xcdw005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw005
            
            #add-point:AFTER FIELD xcdw005 name="construct.a.xcdw005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.xcdw005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw005
            #add-point:ON ACTION controlp INFIELD xcdw005 name="construct.c.xcdw005"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xcdw001,xcdw007,xcdw008,xcdw009,xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010, 
          xcdw016,xcdw017,xcdw018,xcdw201,xcdw202,xcdw020,xcdw021,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024, 
          xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,xcdw030,xcdw031,xcdw034
           FROM s_detail1[1].xcdw001,s_detail1[1].xcdw007,s_detail1[1].xcdw008,s_detail1[1].xcdw009, 
               s_detail1[1].xcdw002,s_detail1[1].xcdwsite,s_detail1[1].xcdw011,s_detail1[1].xcdw012, 
               s_detail1[1].xcdw010,s_detail1[1].xcdw016,s_detail1[1].xcdw017,s_detail1[1].xcdw018,s_detail1[1].xcdw201, 
               s_detail1[1].xcdw202,s_detail1[1].xcdw020,s_detail1[1].xcdw021,s_detail2[1].xcdw032,s_detail2[1].xcdw033, 
               s_detail2[1].xcdw022,s_detail2[1].xcdw023,s_detail2[1].xcdw024,s_detail2[1].xcdw025,s_detail2[1].xcdw026, 
               s_detail2[1].xcdw027,s_detail2[1].xcdw028,s_detail2[1].xcdw029,s_detail2[1].xcdw030,s_detail2[1].xcdw031, 
               s_detail2[1].xcdw034
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body.before_construct"
            
            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw001
            #add-point:BEFORE FIELD xcdw001 name="construct.b.page1.xcdw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw001
            
            #add-point:AFTER FIELD xcdw001 name="construct.a.page1.xcdw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw001
            #add-point:ON ACTION controlp INFIELD xcdw001 name="construct.c.page1.xcdw001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw007
            #add-point:BEFORE FIELD xcdw007 name="construct.b.page1.xcdw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw007
            
            #add-point:AFTER FIELD xcdw007 name="construct.a.page1.xcdw007"
          
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw007
            #add-point:ON ACTION controlp INFIELD xcdw007 name="construct.c.page1.xcdw007"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw008
            #add-point:BEFORE FIELD xcdw008 name="construct.b.page1.xcdw008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw008
            
            #add-point:AFTER FIELD xcdw008 name="construct.a.page1.xcdw008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw008
            #add-point:ON ACTION controlp INFIELD xcdw008 name="construct.c.page1.xcdw008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw009
            #add-point:BEFORE FIELD xcdw009 name="construct.b.page1.xcdw009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw009
            
            #add-point:AFTER FIELD xcdw009 name="construct.a.page1.xcdw009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw009
            #add-point:ON ACTION controlp INFIELD xcdw009 name="construct.c.page1.xcdw009"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw002
            #add-point:ON ACTION controlp INFIELD xcdw002 name="construct.c.page1.xcdw002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcbf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw002  #顯示到畫面上
            NEXT FIELD xcdw002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw002
            #add-point:BEFORE FIELD xcdw002 name="construct.b.page1.xcdw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw002
            
            #add-point:AFTER FIELD xcdw002 name="construct.a.page1.xcdw002"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwsite
            #add-point:BEFORE FIELD xcdwsite name="construct.b.page1.xcdwsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwsite
            
            #add-point:AFTER FIELD xcdwsite name="construct.a.page1.xcdwsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdwsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwsite
            #add-point:ON ACTION controlp INFIELD xcdwsite name="construct.c.page1.xcdwsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw011
            #add-point:BEFORE FIELD xcdw011 name="construct.b.page1.xcdw011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw011
            
            #add-point:AFTER FIELD xcdw011 name="construct.a.page1.xcdw011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw011
            #add-point:ON ACTION controlp INFIELD xcdw011 name="construct.c.page1.xcdw011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw012
            #add-point:BEFORE FIELD xcdw012 name="construct.b.page1.xcdw012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw012
            
            #add-point:AFTER FIELD xcdw012 name="construct.a.page1.xcdw012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw012
            #add-point:ON ACTION controlp INFIELD xcdw012 name="construct.c.page1.xcdw012"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdw010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw010
            #add-point:ON ACTION controlp INFIELD xcdw010 name="construct.c.page1.xcdw010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcau001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw010  #顯示到畫面上
            NEXT FIELD xcdw010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw010
            #add-point:BEFORE FIELD xcdw010 name="construct.b.page1.xcdw010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw010
            
            #add-point:AFTER FIELD xcdw010 name="construct.a.page1.xcdw010"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw016
            #add-point:BEFORE FIELD xcdw016 name="construct.b.page1.xcdw016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw016
            
            #add-point:AFTER FIELD xcdw016 name="construct.a.page1.xcdw016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw016
            #add-point:ON ACTION controlp INFIELD xcdw016 name="construct.c.page1.xcdw016"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdw017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw017
            #add-point:ON ACTION controlp INFIELD xcdw017 name="construct.c.page1.xcdw017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw017  #顯示到畫面上
            NEXT FIELD xcdw017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw017
            #add-point:BEFORE FIELD xcdw017 name="construct.b.page1.xcdw017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw017
            
            #add-point:AFTER FIELD xcdw017 name="construct.a.page1.xcdw017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw018
            #add-point:ON ACTION controlp INFIELD xcdw018 name="construct.c.page1.xcdw018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaj010()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw018  #顯示到畫面上
            NEXT FIELD xcdw018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw018
            #add-point:BEFORE FIELD xcdw018 name="construct.b.page1.xcdw018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw018
            
            #add-point:AFTER FIELD xcdw018 name="construct.a.page1.xcdw018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw201
            #add-point:BEFORE FIELD xcdw201 name="construct.b.page1.xcdw201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw201
            
            #add-point:AFTER FIELD xcdw201 name="construct.a.page1.xcdw201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw201
            #add-point:ON ACTION controlp INFIELD xcdw201 name="construct.c.page1.xcdw201"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw202
            #add-point:BEFORE FIELD xcdw202 name="construct.b.page1.xcdw202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw202
            
            #add-point:AFTER FIELD xcdw202 name="construct.a.page1.xcdw202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw202
            #add-point:ON ACTION controlp INFIELD xcdw202 name="construct.c.page1.xcdw202"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw020
            #add-point:BEFORE FIELD xcdw020 name="construct.b.page1.xcdw020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw020
            
            #add-point:AFTER FIELD xcdw020 name="construct.a.page1.xcdw020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.xcdw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw020
            #add-point:ON ACTION controlp INFIELD xcdw020 name="construct.c.page1.xcdw020"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.xcdw021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw021
            #add-point:ON ACTION controlp INFIELD xcdw021 name="construct.c.page1.xcdw021"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw021  #顯示到畫面上
            NEXT FIELD xcdw021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw021
            #add-point:BEFORE FIELD xcdw021 name="construct.b.page1.xcdw021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw021
            
            #add-point:AFTER FIELD xcdw021 name="construct.a.page1.xcdw021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw032
            #add-point:ON ACTION controlp INFIELD xcdw032 name="construct.c.page2.xcdw032"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw032  #顯示到畫面上
            NEXT FIELD xcdw032                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw032
            #add-point:BEFORE FIELD xcdw032 name="construct.b.page2.xcdw032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw032
            
            #add-point:AFTER FIELD xcdw032 name="construct.a.page2.xcdw032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw033
            #add-point:ON ACTION controlp INFIELD xcdw033 name="construct.c.page2.xcdw033"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw033  #顯示到畫面上
            NEXT FIELD xcdw033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw033
            #add-point:BEFORE FIELD xcdw033 name="construct.b.page2.xcdw033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw033
            
            #add-point:AFTER FIELD xcdw033 name="construct.a.page2.xcdw033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw022
            #add-point:ON ACTION controlp INFIELD xcdw022 name="construct.c.page2.xcdw022"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw022  #顯示到畫面上
            NEXT FIELD xcdw022                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw022
            #add-point:BEFORE FIELD xcdw022 name="construct.b.page2.xcdw022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw022
            
            #add-point:AFTER FIELD xcdw022 name="construct.a.page2.xcdw022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw023
            #add-point:ON ACTION controlp INFIELD xcdw023 name="construct.c.page2.xcdw023"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw023  #顯示到畫面上
            NEXT FIELD xcdw023                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw023
            #add-point:BEFORE FIELD xcdw023 name="construct.b.page2.xcdw023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw023
            
            #add-point:AFTER FIELD xcdw023 name="construct.a.page2.xcdw023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw024
            #add-point:ON ACTION controlp INFIELD xcdw024 name="construct.c.page2.xcdw024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw024  #顯示到畫面上
            NEXT FIELD xcdw024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw024
            #add-point:BEFORE FIELD xcdw024 name="construct.b.page2.xcdw024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw024
            
            #add-point:AFTER FIELD xcdw024 name="construct.a.page2.xcdw024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw025
            #add-point:ON ACTION controlp INFIELD xcdw025 name="construct.c.page2.xcdw025"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw025  #顯示到畫面上
            NEXT FIELD xcdw025                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw025
            #add-point:BEFORE FIELD xcdw025 name="construct.b.page2.xcdw025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw025
            
            #add-point:AFTER FIELD xcdw025 name="construct.a.page2.xcdw025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw026
            #add-point:ON ACTION controlp INFIELD xcdw026 name="construct.c.page2.xcdw026"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw026  #顯示到畫面上
            NEXT FIELD xcdw026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw026
            #add-point:BEFORE FIELD xcdw026 name="construct.b.page2.xcdw026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw026
            
            #add-point:AFTER FIELD xcdw026 name="construct.a.page2.xcdw026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw027
            #add-point:ON ACTION controlp INFIELD xcdw027 name="construct.c.page2.xcdw027"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw027  #顯示到畫面上
            NEXT FIELD xcdw027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw027
            #add-point:BEFORE FIELD xcdw027 name="construct.b.page2.xcdw027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw027
            
            #add-point:AFTER FIELD xcdw027 name="construct.a.page2.xcdw027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw028
            #add-point:ON ACTION controlp INFIELD xcdw028 name="construct.c.page2.xcdw028"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw028  #顯示到畫面上
            NEXT FIELD xcdw028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw028
            #add-point:BEFORE FIELD xcdw028 name="construct.b.page2.xcdw028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw028
            
            #add-point:AFTER FIELD xcdw028 name="construct.a.page2.xcdw028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw029
            #add-point:ON ACTION controlp INFIELD xcdw029 name="construct.c.page2.xcdw029"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw029  #顯示到畫面上
            NEXT FIELD xcdw029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw029
            #add-point:BEFORE FIELD xcdw029 name="construct.b.page2.xcdw029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw029
            
            #add-point:AFTER FIELD xcdw029 name="construct.a.page2.xcdw029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw030
            #add-point:ON ACTION controlp INFIELD xcdw030 name="construct.c.page2.xcdw030"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw030  #顯示到畫面上
            NEXT FIELD xcdw030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw030
            #add-point:BEFORE FIELD xcdw030 name="construct.b.page2.xcdw030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw030
            
            #add-point:AFTER FIELD xcdw030 name="construct.a.page2.xcdw030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw031
            #add-point:ON ACTION controlp INFIELD xcdw031 name="construct.c.page2.xcdw031"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcdw031  #顯示到畫面上
            NEXT FIELD xcdw031                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw031
            #add-point:BEFORE FIELD xcdw031 name="construct.b.page2.xcdw031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw031
            
            #add-point:AFTER FIELD xcdw031 name="construct.a.page2.xcdw031"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw034
            #add-point:BEFORE FIELD xcdw034 name="construct.b.page2.xcdw034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw034
            
            #add-point:AFTER FIELD xcdw034 name="construct.a.page2.xcdw034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.xcdw034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw034
            #add-point:ON ACTION controlp INFIELD xcdw034 name="construct.c.page2.xcdw034"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct name="cs.more_construct"
      
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog name="cs.before_dialog"
         LET g_xcdw_d[1].xcdw007 = ""
         DISPLAY ARRAY g_xcdw_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #dorislai-21051026-add----(S)
         CALL s_axc_set_site_default() RETURNING g_xcdw_m.xcdwcomp,g_xcdw_m.xcdwld,g_xcdw_m.xcdw004,
                                                 g_xcdw_m.xcdw005,g_xcdw_m.xcdw003
         DISPLAY BY NAME g_xcdw_m.xcdwcomp,g_xcdw_m.xcdwld,g_xcdw_m.xcdw004,
                         g_xcdw_m.xcdw005,g_xcdw_m.xcdw003 
         #dorislai-21051026-add----(E)                
         #end add-point
      
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
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
   
   #add-point:cs段after_construct name="cs.after_construct"
   LET g_wc = g_wc CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"
   
   #end add-point
   
   #組合g_wc2
   LET g_wc2 = g_wc2_table1
 
 
 
   
   LET g_current_row = 1
 
   IF INT_FLAG THEN
      RETURN
   END IF
   
   LET g_wc_filter = ""
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct322_query()
   #add-point:query段define name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="query.befroe_query"
   
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
   CALL g_xcdw_d.clear()
   CALL g_xcdw2_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct322_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL axct322_browser_fill(g_wc)
      CALL axct322_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct322_browser_fill("F")
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL axct322_fetch("F") 
   END IF
   
   CALL axct322_idx_chk()
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct322_fetch(p_flag)
   #add-point:fetch段define name="fetch.define_customerization"
   
   #end add-point   
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fetch.before_fetch"
   
   #end add-point    
 
   CASE p_flag
      WHEN 'F' 
         LET g_current_idx = 1
      WHEN 'L' 
         LET g_current_idx = g_header_cnt
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
 
            PROMPT ls_msg CLIPPED,': ' FOR g_jump
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
   
   #若無資料則離開
   IF g_current_idx = 0 THEN
      RETURN
   END IF
   
   #CALL axct322_browser_fill(p_flag)
   
   LET g_detail_cnt = g_header_cnt                  
   
   #單身筆數顯示
   DISPLAY g_detail_cnt TO FORMONLY.cnt                      #設定page 總筆數 
   #LET g_detail_idx = 1
   IF g_detail_cnt > 0 THEN
      #LET g_detail_idx = 1
      DISPLAY g_detail_idx TO FORMONLY.idx  
   ELSE
      LET g_detail_idx = 0
      DISPLAY ' ' TO FORMONLY.idx    
   END IF
   
   #瀏覽頁筆數顯示
   LET g_browser_idx = g_pagestart + g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting(g_current_idx,g_detail_cnt)
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xcdw_m.xcdwld = g_browser[g_current_idx].b_xcdwld
   LET g_xcdw_m.xcdw003 = g_browser[g_current_idx].b_xcdw003
   LET g_xcdw_m.xcdw004 = g_browser[g_current_idx].b_xcdw004
   LET g_xcdw_m.xcdw005 = g_browser[g_current_idx].b_xcdw005
   LET g_xcdw_m.xcdw006 = g_browser[g_current_idx].b_xcdw006
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct322_master_referesh USING g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcdw006 INTO g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp_desc, 
       g_xcdw_m.xcdw003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      INITIALIZE g_xcdw_m.* TO NULL
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_xcdw_m_mask_o.* =  g_xcdw_m.*
   CALL axct322_xcdw_t_mask()
   LET g_xcdw_m_mask_n.* =  g_xcdw_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct322_set_act_visible()
   CALL axct322_set_act_no_visible()
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   #保存單頭舊值
   LET g_xcdw_m_t.* = g_xcdw_m.*
   LET g_xcdw_m_o.* = g_xcdw_m.*
   
   #重新顯示   
   CALL axct322_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct322_insert()
   #add-point:insert段define name="insert.define_customerization"
   
   #end add-point   
   #add-point:insert段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
DEFINE l_success LIKE  type_t.chr1  
   #end add-point
   
   #add-point:Function前置處理  name="insert.before"
   
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xcdw_d.clear()
   CALL g_xcdw2_d.clear()
 
 
   INITIALIZE g_xcdw_m.* TO NULL             #DEFAULT 設定
   LET g_xcdwld_t = NULL
   LET g_xcdw003_t = NULL
   LET g_xcdw004_t = NULL
   LET g_xcdw005_t = NULL
   LET g_xcdw006_t = NULL
 
   LET g_master_insert = FALSE
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
 
      CALL axct322_input("a")
      
      #add-point:單頭輸入後 name="insert.after_insert"
      
      #end add-point
      
      IF INT_FLAG AND NOT g_master_insert THEN
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
         INITIALIZE g_xcdw_m.* TO NULL
         INITIALIZE g_xcdw_d TO NULL
         INITIALIZE g_xcdw2_d TO NULL
 
         CALL axct322_show()
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcdw_m.* = g_xcdw_m_t.*
         CALL axct322_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
    
      #CALL g_xcdw_d.clear()
      #CALL g_xcdw2_d.clear()
 
      
      #add-point:單頭輸入後2 name="insert.after_insert2"
      
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct322_set_act_visible()
   CALL axct322_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdwld_t = g_xcdw_m.xcdwld
   LET g_xcdw003_t = g_xcdw_m.xcdw003
   LET g_xcdw004_t = g_xcdw_m.xcdw004
   LET g_xcdw005_t = g_xcdw_m.xcdw005
   LET g_xcdw006_t = g_xcdw_m.xcdw006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdwent = " ||g_enterprise|| " AND",
                      " xcdwld = '", g_xcdw_m.xcdwld, "' "
                      ," AND xcdw003 = '", g_xcdw_m.xcdw003, "' "
                      ," AND xcdw004 = '", g_xcdw_m.xcdw004, "' "
                      ," AND xcdw005 = '", g_xcdw_m.xcdw005, "' "
                      ," AND xcdw006 = '", g_xcdw_m.xcdw006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct322_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CALL axct322_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE axct322_master_referesh USING g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcdw006 INTO g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp_desc, 
       g_xcdw_m.xcdw003_desc
   
   #遮罩相關處理
   LET g_xcdw_m_mask_o.* =  g_xcdw_m.*
   CALL axct322_xcdw_t_mask()
   LET g_xcdw_m_mask_n.* =  g_xcdw_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_xcdw_m.xcdwld,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdwcomp_desc,g_xcdw_m.xcdw003, 
       g_xcdw_m.xcdw003_desc,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013,g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcat003
   
   #功能已完成,通報訊息中心
   CALL axct322_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct322_modify()
   #add-point:modify段define name="modify.define_customerization"
   
   #end add-point    
   #add-point:modify段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
DEFINE l_success      LIKE type_t.chr1
DEFINE l_xcdw001 LIKE xcdw_t.xcdw001
DEFINE l_xcdw002 LIKE xcdw_t.xcdw002
DEFINE l_xcdw007 LIKE xcdw_t.xcdw007
DEFINE l_xcdw008 LIKE xcdw_t.xcdw008
DEFINE l_xcdw009 LIKE xcdw_t.xcdw009
DEFINE l_xcdw001_t LIKE xcdw_t.xcdw001
DEFINE l_xcdw002_t LIKE xcdw_t.xcdw002
DEFINE l_xcdw007_t LIKE xcdw_t.xcdw007
DEFINE l_xcdw008_t LIKE xcdw_t.xcdw008
DEFINE l_xcdw009_t LIKE xcdw_t.xcdw009
   #end add-point  
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   IF g_xcdw_m.xcdwld IS NULL
   OR g_xcdw_m.xcdw003 IS NULL
   OR g_xcdw_m.xcdw004 IS NULL
   OR g_xcdw_m.xcdw005 IS NULL
   OR g_xcdw_m.xcdw006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL  
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
   LET g_xcdwld_t = g_xcdw_m.xcdwld
   LET g_xcdw003_t = g_xcdw_m.xcdw003
   LET g_xcdw004_t = g_xcdw_m.xcdw004
   LET g_xcdw005_t = g_xcdw_m.xcdw005
   LET g_xcdw006_t = g_xcdw_m.xcdw006
 
   CALL s_transaction_begin()
   
   OPEN axct322_cl USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct322_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct322_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct322_master_referesh USING g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcdw006 INTO g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp_desc, 
       g_xcdw_m.xcdw003_desc
   
   #遮罩相關處理
   LET g_xcdw_m_mask_o.* =  g_xcdw_m.*
   CALL axct322_xcdw_t_mask()
   LET g_xcdw_m_mask_n.* =  g_xcdw_m.*
   
   CALL s_transaction_end('Y','0')
 
   CALL axct322_show()
   WHILE TRUE
      LET g_xcdwld_t = g_xcdw_m.xcdwld
      LET g_xcdw003_t = g_xcdw_m.xcdw003
      LET g_xcdw004_t = g_xcdw_m.xcdw004
      LET g_xcdw005_t = g_xcdw_m.xcdw005
      LET g_xcdw006_t = g_xcdw_m.xcdw006
 
 
      #add-point:modify段修改前 name="modify.before_input"
      #已确认资料不可修改
#      IF g_xcdw_m.xcdwstus <> 'N' THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = ''         
#         LET g_errparam.code   = "apm-00035" 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
#         EXIT WHILE
#      END IF

      #end add-point
      
      CALL axct322_input("u")     #欄位更改
      
      #add-point:modify段修改後 name="modify.after_input"

      CALL axct322_sum_chk() RETURNING l_success
      IF l_success = 'N' THEN         
         CONTINUE WHILE     
      END IF
      CALL axct322_xcdw010_chk() RETURNING l_success
      IF l_success = 'N' THEN         
         CONTINUE WHILE     
      END IF 
      
      #end add-point
      
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         LET g_xcdw_m.* = g_xcdw_m_t.*
         CALL axct322_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更(更新單身table的key欄位值)
      IF g_xcdw_m.xcdwld != g_xcdwld_t 
      OR g_xcdw_m.xcdw003 != g_xcdw003_t 
      OR g_xcdw_m.xcdw004 != g_xcdw004_t 
      OR g_xcdw_m.xcdw005 != g_xcdw005_t 
      OR g_xcdw_m.xcdw006 != g_xcdw006_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前 name="modify.b_key_update"
         
         #end add-point
         
         #add-point:單頭(偽)修改中 name="modify.m_key_update"
         
         #end add-point
         
 
         
         #add-point:單頭(偽)修改後 name="modify.a_key_update"
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct322_set_act_visible()
   CALL axct322_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " xcdwent = " ||g_enterprise|| " AND",
                      " xcdwld = '", g_xcdw_m.xcdwld, "' "
                      ," AND xcdw003 = '", g_xcdw_m.xcdw003, "' "
                      ," AND xcdw004 = '", g_xcdw_m.xcdw004, "' "
                      ," AND xcdw005 = '", g_xcdw_m.xcdw005, "' "
                      ," AND xcdw006 = '", g_xcdw_m.xcdw006, "' "
 
   #填到對應位置
   CALL axct322_browser_fill("")
 
   CALL axct322_idx_chk()
 
   CLOSE axct322_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL axct322_msgcentre_notify('modify')
   
END FUNCTION   
 
{</section>}
 
{<section id="axct322.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct322_input(p_cmd)
   #add-point:input段define name="input.define_customerization"
   
   #end add-point   
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num10               #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num10               #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num10               #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num10
   DEFINE  l_i                   LIKE type_t.num10
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
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE  l_amount              LIKE xcdw_t.xcdw202  #用于换算币种金额
   DEFINE  l_count1              LIKE type_t.num5
   DEFINE  l_sumxcdw             LIKE xcdw_t.xcdw202
   DEFINE  l_sumxccw             LIKE xcdw_t.xcdw202  
   DEFINE  l_success             LIKE type_t.chr1    
   DEFINE  l_rate                LIKE xccw_t.xccw042 
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
   DISPLAY BY NAME g_xcdw_m.xcdwld,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdwcomp_desc,g_xcdw_m.xcdw003, 
       g_xcdw_m.xcdw003_desc,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013,g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcat003
   
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
   LET g_forupd_sql = "SELECT xcdw001,xcdw007,xcdw008,xcdw009,xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010, 
       xcdw016,xcdw017,xcdw018,xcdw201,xcdw202,xcdw020,xcdw021,xcdw001,xcdw007,xcdw008,xcdw009,xcdw002, 
       xcdwsite,xcdw010,xcdw011,xcdw012,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027, 
       xcdw028,xcdw029,xcdw030,xcdw031,xcdw034,xcdw201,xcdw202,xcdw021 FROM xcdw_t WHERE xcdwent=? AND  
       xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND xcdw006=? AND xcdw001=? AND xcdw002=?  
       AND xcdw007=? AND xcdw008=? AND xcdw009=? AND xcdw010=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct322_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct322_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL axct322_set_no_entry(p_cmd)
   #add-point:set_no_entry後 name="input.after_set_no_entry"
   
   #end add-point
 
   DISPLAY BY NAME g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcat003
   
   LET lb_reproduce = FALSE
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:進入修改段前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct322.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
          g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcat003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前 name="input.head.b_input"
            
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwld
            
            #add-point:AFTER FIELD xcdwld name="input.a.xcdwld"
            IF NOT cl_null(g_xcdw_m.xcdwld) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdw_m.xcdwld
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdw_m.xcdwld
            CALL ap_ref_array2(g_ref_fields,"SELECT glaal003 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaal001=? AND glaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdw_m.xcdwld_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdw_m.xcdwld_desc
#            CALL cl_get_para(g_enterprise,g_xcdw_m.xcdwcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否            
#            IF g_para_data = 'Y' THEN
#               CALL cl_set_comp_visible('xcdw002,xcdw002_desc,xcdw002_2,xcdw002_2_desc,xcdw002_3,xcdw002_3_desc,xcdw002_4,xcdw002_4_desc',TRUE)                    
#            ELSE
#               CALL cl_set_comp_visible('xcdw002,xcdw002_desc,xcdw002_2,xcdw002_2_desc,xcdw002_3,xcdw002_3_desc,xcdw002_4,xcdw002_4_desc',FALSE)                
#            END IF
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdw_m.xcdwld) AND NOT cl_null(g_xcdw_m.xcdw003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) AND NOT cl_null(g_xcdw_m.xcdw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t  OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t  OR g_xcdw_m.xcdw005 != g_xcdw005_t  OR g_xcdw_m.xcdw006 != g_xcdw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwld
            #add-point:BEFORE FIELD xcdwld name="input.b.xcdwld"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdwld
            #add-point:ON CHANGE xcdwld name="input.g.xcdwld"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwcomp
            
            #add-point:AFTER FIELD xcdwcomp name="input.a.xcdwcomp"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdw_m.xcdwcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdw_m.xcdwcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdw_m.xcdwcomp_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwcomp
            #add-point:BEFORE FIELD xcdwcomp name="input.b.xcdwcomp"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdwcomp
            #add-point:ON CHANGE xcdwcomp name="input.g.xcdwcomp"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw003
            
            #add-point:AFTER FIELD xcdw003 name="input.a.xcdw003"
            IF NOT cl_null(g_xcdw_m.xcdw003) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdw_m.xcdw003
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcat001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xcdw_m.xcdw003
            CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xcdw_m.xcdw003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xcdw_m.xcdw003_desc

            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdw_m.xcdwld) AND NOT cl_null(g_xcdw_m.xcdw003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) AND NOT cl_null(g_xcdw_m.xcdw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t  OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t  OR g_xcdw_m.xcdw005 != g_xcdw005_t  OR g_xcdw_m.xcdw006 != g_xcdw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw003
            #add-point:BEFORE FIELD xcdw003 name="input.b.xcdw003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw003
            #add-point:ON CHANGE xcdw003 name="input.g.xcdw003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw006
            #add-point:BEFORE FIELD xcdw006 name="input.b.xcdw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw006
            
            #add-point:AFTER FIELD xcdw006 name="input.a.xcdw006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdw_m.xcdwld) AND NOT cl_null(g_xcdw_m.xcdw003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) AND NOT cl_null(g_xcdw_m.xcdw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t  OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t  OR g_xcdw_m.xcdw005 != g_xcdw005_t  OR g_xcdw_m.xcdw006 != g_xcdw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw006
            #add-point:ON CHANGE xcdw006 name="input.g.xcdw006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw013
            #add-point:BEFORE FIELD xcdw013 name="input.b.xcdw013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw013
            
            #add-point:AFTER FIELD xcdw013 name="input.a.xcdw013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw013
            #add-point:ON CHANGE xcdw013 name="input.g.xcdw013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw014
            #add-point:BEFORE FIELD xcdw014 name="input.b.xcdw014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw014
            
            #add-point:AFTER FIELD xcdw014 name="input.a.xcdw014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw014
            #add-point:ON CHANGE xcdw014 name="input.g.xcdw014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw004
            #add-point:BEFORE FIELD xcdw004 name="input.b.xcdw004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw004
            
            #add-point:AFTER FIELD xcdw004 name="input.a.xcdw004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdw_m.xcdwld) AND NOT cl_null(g_xcdw_m.xcdw003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) AND NOT cl_null(g_xcdw_m.xcdw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t  OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t  OR g_xcdw_m.xcdw005 != g_xcdw005_t  OR g_xcdw_m.xcdw006 != g_xcdw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw004
            #add-point:ON CHANGE xcdw004 name="input.g.xcdw004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw005
            #add-point:BEFORE FIELD xcdw005 name="input.b.xcdw005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw005
            
            #add-point:AFTER FIELD xcdw005 name="input.a.xcdw005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xcdw_m.xcdwld) AND NOT cl_null(g_xcdw_m.xcdw003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) AND NOT cl_null(g_xcdw_m.xcdw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t  OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t  OR g_xcdw_m.xcdw005 != g_xcdw005_t  OR g_xcdw_m.xcdw006 != g_xcdw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw005
            #add-point:ON CHANGE xcdw005 name="input.g.xcdw005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcat003
            #add-point:BEFORE FIELD xcat003 name="input.b.xcat003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcat003
            
            #add-point:AFTER FIELD xcat003 name="input.a.xcat003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcat003
            #add-point:ON CHANGE xcat003 name="input.g.xcat003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcdwld
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwld
            #add-point:ON ACTION controlp INFIELD xcdwld name="input.c.xcdwld"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_m.xcdwld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗

            LET g_xcdw_m.xcdwld = g_qryparam.return1              

            DISPLAY g_xcdw_m.xcdwld TO xcdwld              #

            NEXT FIELD xcdwld                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdwcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwcomp
            #add-point:ON ACTION controlp INFIELD xcdwcomp name="input.c.xcdwcomp"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_m.xcdwcomp             #給予default值
            LET g_qryparam.default2 = "" #g_xcdw_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001_2()                                #呼叫開窗

            LET g_xcdw_m.xcdwcomp = g_qryparam.return1              
            #LET g_xcdw_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_xcdw_m.xcdwcomp TO xcdwcomp              #
            #DISPLAY g_xcdw_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD xcdwcomp                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdw003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw003
            #add-point:ON ACTION controlp INFIELD xcdw003 name="input.c.xcdw003"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_m.xcdw003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xcdw_m.xcdw003 = g_qryparam.return1              

            DISPLAY g_xcdw_m.xcdw003 TO xcdw003              #

            NEXT FIELD xcdw003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdw006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw006
            #add-point:ON ACTION controlp INFIELD xcdw006 name="input.c.xcdw006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_m.xcdw006             #給予default值
            LET g_qryparam.default2 = "" #g_xcdw_m.inba002 #扣帐日期
            #給予arg
            LET g_qryparam.arg1 = "" #
            LET g_qryparam.arg2 = "" #
            
            CALL q_inbadocno_4()                                #呼叫開窗

            LET g_xcdw_m.xcdw006 = g_qryparam.return1              
            #LET g_xcdw_m.inba002 = g_qryparam.return2 
            DISPLAY g_xcdw_m.xcdw006 TO xcdw006              #
            #DISPLAY g_xcdw_m.inba002 TO inba002 #扣帐日期
            NEXT FIELD xcdw006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.xcdw013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw013
            #add-point:ON ACTION controlp INFIELD xcdw013 name="input.c.xcdw013"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw014
            #add-point:ON ACTION controlp INFIELD xcdw014 name="input.c.xcdw014"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdw004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw004
            #add-point:ON ACTION controlp INFIELD xcdw004 name="input.c.xcdw004"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcdw005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw005
            #add-point:ON ACTION controlp INFIELD xcdw005 name="input.c.xcdw005"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcat003
            #add-point:ON ACTION controlp INFIELD xcat003 name="input.c.xcat003"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xcdw_m.xcdwld             
                            ,g_xcdw_m.xcdw003   
                            ,g_xcdw_m.xcdw004   
                            ,g_xcdw_m.xcdw005   
                            ,g_xcdw_m.xcdw006   
 
 
            #add-point:單頭修改前 name="input.head.b_after_input"
            
            #end add-point
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前 name="input.head.b_update"
               
               #end add-point
            
               #將遮罩欄位還原
               CALL axct322_xcdw_t_mask_restore('restore_mask_o')
            
               UPDATE xcdw_t SET (xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw013,xcdw014,xcdw004,xcdw005) = (g_xcdw_m.xcdwld, 
                   g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013,g_xcdw_m.xcdw014, 
                   g_xcdw_m.xcdw004,g_xcdw_m.xcdw005)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdwld_t
                  AND xcdw003 = g_xcdw003_t
                  AND xcdw004 = g_xcdw004_t
                  AND xcdw005 = g_xcdw005_t
                  AND xcdw006 = g_xcdw006_t
 
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdw_m.xcdwld
               LET gs_keys_bak[1] = g_xcdwld_t
               LET gs_keys[2] = g_xcdw_m.xcdw003
               LET gs_keys_bak[2] = g_xcdw003_t
               LET gs_keys[3] = g_xcdw_m.xcdw004
               LET gs_keys_bak[3] = g_xcdw004_t
               LET gs_keys[4] = g_xcdw_m.xcdw005
               LET gs_keys_bak[4] = g_xcdw005_t
               LET gs_keys[5] = g_xcdw_m.xcdw006
               LET gs_keys_bak[5] = g_xcdw006_t
               LET gs_keys[6] = g_xcdw_d[g_detail_idx].xcdw001
               LET gs_keys_bak[6] = g_xcdw_d_t.xcdw001
               LET gs_keys[7] = g_xcdw_d[g_detail_idx].xcdw002
               LET gs_keys_bak[7] = g_xcdw_d_t.xcdw002
               LET gs_keys[8] = g_xcdw_d[g_detail_idx].xcdw007
               LET gs_keys_bak[8] = g_xcdw_d_t.xcdw007
               LET gs_keys[9] = g_xcdw_d[g_detail_idx].xcdw008
               LET gs_keys_bak[9] = g_xcdw_d_t.xcdw008
               LET gs_keys[10] = g_xcdw_d[g_detail_idx].xcdw009
               LET gs_keys_bak[10] = g_xcdw_d_t.xcdw009
               LET gs_keys[11] = g_xcdw_d[g_detail_idx].xcdw010
               LET gs_keys_bak[11] = g_xcdw_d_t.xcdw010
               CALL axct322_update_b('xcdw_t',gs_keys,gs_keys_bak,"'1'")
                     
 
                     #add-point:單頭修改後 name="input.head.a_update"
                     
                     #end add-point
    
                     #頭先不紀錄
                     #LET g_log1 = util.JSON.stringify(g_xcdw_m_t)
                     #LET g_log2 = util.JSON.stringify(g_xcdw_m)
                     #IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     #   CALL s_transaction_end('N','0')
                     #ELSE
                        CALL s_transaction_end('Y','0')
                     #END IF
               END CASE
            
               #將遮罩欄位進行遮蔽
               CALL axct322_xcdw_t_mask_restore('restore_mask_n')
            
            ELSE    
               #add-point:單頭新增 name="input.head.a_insert"
               
               #end add-point
               
               #多語言處理
               
                         
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct322_detail_reproduce()
               END IF
               
               LET p_cmd = 'u'
            END IF
 
           LET g_xcdwld_t = g_xcdw_m.xcdwld
           LET g_xcdw003_t = g_xcdw_m.xcdw003
           LET g_xcdw004_t = g_xcdw_m.xcdw004
           LET g_xcdw005_t = g_xcdw_m.xcdw005
           LET g_xcdw006_t = g_xcdw_m.xcdw006
 
           
           IF g_xcdw_d.getLength() = 0 THEN
              NEXT FIELD xcdw001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct322.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xcdw_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdw_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct322_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 1
            #add-point:資料輸入前 name="input.body.before_input"
            
            #end add-point
         
         BEFORE ROW
            #add-point:modify段before row name="input.body.before_row2"
            
            #end add-point  
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct322_cl USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006                          
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  CLOSE axct322_cl
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_cl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            IF g_rec_b >= l_ac 
               AND g_xcdw_d[l_ac].xcdw001 IS NOT NULL
               AND g_xcdw_d[l_ac].xcdw002 IS NOT NULL
               AND g_xcdw_d[l_ac].xcdw007 IS NOT NULL
               AND g_xcdw_d[l_ac].xcdw008 IS NOT NULL
               AND g_xcdw_d[l_ac].xcdw009 IS NOT NULL
               AND g_xcdw_d[l_ac].xcdw010 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcdw_d_t.* = g_xcdw_d[l_ac].*  #BACKUP
               LET g_xcdw_d_o.* = g_xcdw_d[l_ac].*  #BACKUP
               CALL axct322_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body.before_row.set_entry_b"
               
               #end add-point
               CALL axct322_set_no_entry_b(l_cmd)
               OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                g_xcdw_d_t.xcdw001
                                                ,g_xcdw_d_t.xcdw002
                                                ,g_xcdw_d_t.xcdw007
                                                ,g_xcdw_d_t.xcdw008
                                                ,g_xcdw_d_t.xcdw009
                                                ,g_xcdw_d_t.xcdw010
 
               IF SQLCA.SQLCODE THEN   #(ver:49)
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_bcl:" 
                  LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct322_bcl INTO g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                      g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011, 
                      g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017, 
                      g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020, 
                      g_xcdw_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw001,g_xcdw2_d[l_ac].xcdw007,g_xcdw2_d[l_ac].xcdw008, 
                      g_xcdw2_d[l_ac].xcdw009,g_xcdw2_d[l_ac].xcdw002,g_xcdw2_d[l_ac].xcdwsite,g_xcdw2_d[l_ac].xcdw010, 
                      g_xcdw2_d[l_ac].xcdw011,g_xcdw2_d[l_ac].xcdw012,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033, 
                      g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025, 
                      g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029, 
                      g_xcdw2_d[l_ac].xcdw030,g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034,g_xcdw2_d[l_ac].xcdw201, 
                      g_xcdw2_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw021
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xcdw_d_t.xcdw001,":",SQLERRMESSAGE 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_xcdw_d_mask_o[l_ac].* =  g_xcdw_d[l_ac].*
                  CALL axct322_xcdw_t_mask()
                  LET g_xcdw_d_mask_n[l_ac].* =  g_xcdw_d[l_ac].*
                  
                  CALL axct322_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            IF l_cmd='u' THEN
               IF g_glaa015 = 'Y' THEN
               
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '2'
                                                ,g_xcdw_d_t.xcdw002
                                                ,g_xcdw_d_t.xcdw007
                                                ,g_xcdw_d_t.xcdw008
                                                ,g_xcdw_d_t.xcdw009
                                                ,g_xcdw_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
               IF g_glaa019 = 'Y' THEN                                 
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '3'
                                                ,g_xcdw_d_t.xcdw002
                                                ,g_xcdw_d_t.xcdw007
                                                ,g_xcdw_d_t.xcdw008
                                                ,g_xcdw_d_t.xcdw009
                                                ,g_xcdw_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
#               NEXT FIELD xcdw010  #140913
            END IF
            
            #end add-point  
            
 
 
        
         BEFORE INSERT
            
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcdw_d_t.* TO NULL
            INITIALIZE g_xcdw_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcdw_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
                  LET g_xcdw_d[l_ac].xcdw201 = "0"
      LET g_xcdw_d[l_ac].xcdw202 = "0"
 
            
            #add-point:modify段before備份 name="input.body.before_insert.before_bak"
             LET g_xcdw_d[l_ac].xcdw001 = "1"
            #end add-point
            LET g_xcdw_d_t.* = g_xcdw_d[l_ac].*     #新輸入資料
            LET g_xcdw_d_o.* = g_xcdw_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct322_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body.before_insert.set_entry_b"
            
            #end add-point
            CALL axct322_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcdw_d[li_reproduce_target].* = g_xcdw_d[li_reproduce].*
               LET g_xcdw2_d[li_reproduce_target].* = g_xcdw2_d[li_reproduce].*
 
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw001 = NULL
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw002 = NULL
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw007 = NULL
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw008 = NULL
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw009 = NULL
               LET g_xcdw_d[g_xcdw_d.getLength()].xcdw010 = NULL
 
            END IF
            
 
 
            #add-point:modify段before insert name="input.body.before_insert"
            
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
            SELECT COUNT(1) INTO l_count FROM xcdw_t 
             WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
               AND xcdw003 = g_xcdw_m.xcdw003
               AND xcdw004 = g_xcdw_m.xcdw004
               AND xcdw005 = g_xcdw_m.xcdw005
               AND xcdw006 = g_xcdw_m.xcdw006
 
               AND xcdw001 = g_xcdw_d[l_ac].xcdw001
               AND xcdw002 = g_xcdw_d[l_ac].xcdw002
               AND xcdw007 = g_xcdw_d[l_ac].xcdw007
               AND xcdw008 = g_xcdw_d[l_ac].xcdw008
               AND xcdw009 = g_xcdw_d[l_ac].xcdw009
               AND xcdw010 = g_xcdw_d[l_ac].xcdw010
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前 name="input.body.b_insert"
               #140820
               IF cl_null(g_xcdw_d[l_ac].xcdw002) THEN
                  LET g_xcdw_d[l_ac].xcdw002 = ' '
               END IF               
               LET l_count1 = 0 
               SELECT COUNT(*) INTO l_count1 FROM xccw_t 
                WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
                  AND xccw003 = g_xcdw_m.xcdw003
                  AND xccw004 = g_xcdw_m.xcdw004
                  AND xccw005 = g_xcdw_m.xcdw005
                  AND xccw006 = g_xcdw_m.xcdw006
                        
                  AND xccw001 = '1'
                  AND xccw002 = g_xcdw_d[l_ac].xcdw002                  
                  AND xccw007 = g_xcdw_d[l_ac].xcdw007
                  AND xccw008 = g_xcdw_d[l_ac].xcdw008                  
                  AND xccw009 = g_xcdw_d[l_ac].xcdw009

                IF l_count1 = 0 THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = 'xccw_t'                  
                   LET g_errparam.columns[1] = "lbl_xcdw002"
                   LET g_errparam.columns[2] = "lbl_xcdw007"
                   LET g_errparam.columns[3] = "lbl_xcdw008"
                   LET g_errparam.columns[4] = "lbl_xcdw009"                 
                   LET g_errparam.values[1] = g_xcdw_d[l_ac].xcdw002
                   LET g_errparam.values[2] = g_xcdw_d[l_ac].xcdw007
                   LET g_errparam.values[3] = g_xcdw_d[l_ac].xcdw008
                   LET g_errparam.values[4] = g_xcdw_d[l_ac].xcdw009
                   CASE g_xcdw013_p 
                        WHEN '1'
                           LET g_errparam.code   = "axc-00537" 
                        WHEN '2'
                           LET g_errparam.code   = "axc-00539"
                        WHEN '3'
                           LET g_errparam.code   = "axc-00541"
                        WHEN '5'
                           LET g_errparam.code   = "axc-00545"
                   END CASE
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   INITIALIZE g_xcdw_d[l_ac].* TO NULL
                   CANCEL INSERT
                END IF
               #fengmy add 141219-----begin  table alter
               LET g_xcdw047 = ' '
               LET g_xcdw048 = ' '
               LET g_xcdw049 = ' '
               LET g_xcdw050 = ' '
               LET g_xcdw051 = ' '
               SELECT xccw047,xccw048,xccw049,xccw050,xccw051
                 INTO g_xcdw047,g_xcdw048,g_xcdw049,g_xcdw050,g_xcdw051
                 FROM xccw_t 
                WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
                  AND xccw003 = g_xcdw_m.xcdw003
                  AND xccw004 = g_xcdw_m.xcdw004
                  AND xccw005 = g_xcdw_m.xcdw005
                  AND xccw006 = g_xcdw_m.xcdw006
                        
                  AND xccw001 = '1'
                  AND xccw002 = g_xcdw_d[l_ac].xcdw002                  
                  AND xccw007 = g_xcdw_d[l_ac].xcdw007
                  AND xccw008 = g_xcdw_d[l_ac].xcdw008                  
                  AND xccw009 = g_xcdw_d[l_ac].xcdw009
               #fengmy add 141219-----end    table alter
               IF 1=2 THEN
               #end add-point
               INSERT INTO xcdw_t
                           (xcdwent,
                            xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw013,xcdw014,xcdw004,xcdw005,
                            xcdw001,xcdw002,xcdw007,xcdw008,xcdw009,xcdw010
                            ,xcdwsite,xcdw011,xcdw012,xcdw016,xcdw017,xcdw018,xcdw201,xcdw202,xcdw020,xcdw021,xcdwsite,xcdw011,xcdw012,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,xcdw030,xcdw031,xcdw034,xcdw201,xcdw202,xcdw021) 
                     VALUES(g_enterprise,
                            g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013,g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,
                            g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                                g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010
                            ,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016, 
                                g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201, 
                                g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021, 
                                g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012, 
                                g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                                g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025, 
                                g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028, 
                                g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030,g_xcdw2_d[l_ac].xcdw031, 
                                g_xcdw2_d[l_ac].xcdw034,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202, 
                                g_xcdw_d[l_ac].xcdw021)
               #add-point:單身新增中 name="input.body.m_insert"
               ELSE
                  IF cl_null(g_xcdw_d[l_ac].xcdw202) THEN LET g_xcdw_d[l_ac].xcdw202 = 0 END IF
                  CALL s_curr_round('',g_glaa001,g_xcdw_d[l_ac].xcdw202,2) RETURNING  g_xcdw_d[l_ac].xcdw202
#                  INSERT INTO xcdw_t
#                           (xcdwent,
                  INSERT INTO xcdw_t
                           (xcdwent,xcdw047,xcdw048,xcdw049,xcdw050,xcdw051,   #add 047~051 141219 fengmy tab alt
                            xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw004,xcdw013,xcdw005,xcdwstus,xcdw014,
                            xcdw001,xcdw002,xcdw007,xcdw008,xcdw009,xcdw010
                            ,xcdwsite,xcdw011,xcdw012,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,xcdw201,xcdw202,
                            xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,xcdw030,xcdw031,xcdw034) 
                     VALUES(g_enterprise,g_xcdw047,g_xcdw048,g_xcdw049,g_xcdw050,g_xcdw051, #add 047~051 141219 fengmy tab alt
                            g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw004,g_xcdw_m.xcdw013,g_xcdw_m.xcdw005,'Y',g_xcdw_m.xcdw014,
                            g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                                g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010
                            ,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016, 
                                g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw020, 
                                g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202, 
                                g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033, 
                                g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024, 
                                g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027, 
                                g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                                g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                  LET l_amount = 0 
                  LET l_rate = 1               
                  IF g_glaa015 = 'Y' THEN
                     IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN              
                        CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
                         RETURNING l_rate
                        LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                     END IF 
                     CALL s_curr_round('',g_glaa016,l_amount,2) RETURNING  l_amount
                     INSERT INTO xcdw_t
                              (xcdwent,xcdw047,xcdw048,xcdw049,xcdw050,xcdw051,   #add 047~051 141219 fengmy tab alt
                               xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw004,xcdw013,xcdw005,xcdwstus,xcdw014,
                               xcdw001,xcdw002,xcdw007,xcdw008,xcdw009,xcdw010
                               ,xcdwsite,xcdw011,xcdw012,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,xcdw201,xcdw202,
                               xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,xcdw030,xcdw031,xcdw034) 
                        VALUES(g_enterprise,g_xcdw047,g_xcdw048,g_xcdw049,g_xcdw050,g_xcdw051, #add 047~051 141219 fengmy tab alt
                               g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw004,g_xcdw_m.xcdw013,g_xcdw_m.xcdw005,'Y',g_xcdw_m.xcdw014,
                               '2',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                                   g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010
                               ,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016, 
                                   g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw020, 
                                   g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,l_amount, 
                                   g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033, 
                                   g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024, 
                                   g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027, 
                                   g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                  END IF
                  LET l_amount = 0
                  LET l_rate = 1
                  IF g_glaa019 = 'Y' THEN
                     IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN                  
                        CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
                          RETURNING l_rate
                        LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                     END IF
                     CALL s_curr_round('',g_glaa020,l_amount,2) RETURNING  l_amount                  
                     INSERT INTO xcdw_t
                              (xcdwent,xcdw047,xcdw048,xcdw049,xcdw050,xcdw051,   #add 047~051 141219 fengmy tab alt
                               xcdwld,xcdwcomp,xcdw003,xcdw006,xcdw004,xcdw013,xcdw005,xcdwstus,xcdw014,
                               xcdw001,xcdw002,xcdw007,xcdw008,xcdw009,xcdw010
                               ,xcdwsite,xcdw011,xcdw012,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,xcdw201,xcdw202,
                               xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,xcdw030,xcdw031,xcdw034) 
                        VALUES(g_enterprise,g_xcdw047,g_xcdw048,g_xcdw049,g_xcdw050,g_xcdw051, #add 047~051 141219 fengmy tab alt
                               g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw004,g_xcdw_m.xcdw013,g_xcdw_m.xcdw005,'Y',g_xcdw_m.xcdw014,
                               '3',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                                   g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010
                               ,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016, 
                                   g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw020, 
                                   g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,l_amount, 
                                   g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033, 
                                   g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024, 
                                   g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027, 
                                   g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                  END IF
               END IF 
               #end add-point
               LET p_cmd = 'u'
               LET g_master_insert = TRUE
            ELSE    
               INITIALIZE g_xcdw_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert name="input.body.a_insert"
               
               #end add-point
               CALL s_transaction_end('Y','0')
               #ERROR 'INSERT O.K'
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後 name="input.body.after_insert"
            
            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前 name="input.body.b_delete"
 
               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axct322_before_delete() THEN 
                  
 
 
 
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcdw_m.xcdwld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw006
 
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw010
 
 
                  #刪除下層單身
                  IF NOT axct322_key_delete_b(gs_keys,'xcdw_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct322_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct322_bcl
               LET l_count = g_xcdw_d.getLength()
            END IF 
            
            #add-point:單身刪除後 name="input.body.a_delete"
 
            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body.after_delete"
               IF g_rec_b = 0 THEN
                  RETURN
               END IF  
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdw_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw001
            #add-point:BEFORE FIELD xcdw001 name="input.b.page1.xcdw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw001
            
            #add-point:AFTER FIELD xcdw001 name="input.a.page1.xcdw001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw001
            #add-point:ON CHANGE xcdw001 name="input.g.page1.xcdw001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw007
            #add-point:BEFORE FIELD xcdw007 name="input.b.page1.xcdw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw007
            
            #add-point:AFTER FIELD xcdw007 name="input.a.page1.xcdw007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct322_insert_default('1',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010)
#            RETURNING g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,
#                      g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201
            CALL axct322_insert_default()
            CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            
            LET g_xcdw_d_o.xcdw007 = g_xcdw_d[g_detail_idx].xcdw007   #160824-00007#223 161202 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw007
            #add-point:ON CHANGE xcdw007 name="input.g.page1.xcdw007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw008
            #add-point:BEFORE FIELD xcdw008 name="input.b.page1.xcdw008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw008
            
            #add-point:AFTER FIELD xcdw008 name="input.a.page1.xcdw008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct322_insert_default('1',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010)
#            RETURNING g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,
#                      g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201
           CALL axct322_insert_default()
            CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            
            LET g_xcdw_d_o.xcdw008 = g_xcdw_d[g_detail_idx].xcdw008   #160824-00007#223 161202 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw008
            #add-point:ON CHANGE xcdw008 name="input.g.page1.xcdw008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw009
            #add-point:BEFORE FIELD xcdw009 name="input.b.page1.xcdw009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw009
            
            #add-point:AFTER FIELD xcdw009 name="input.a.page1.xcdw009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)               
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

#            CALL axct322_insert_default('1',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010)
#            RETURNING g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,
#                      g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201
            CALL axct322_insert_default()
             CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            
            LET g_xcdw_d_o.xcdw009 = g_xcdw_d[g_detail_idx].xcdw009   #160824-00007#223 161202 by lori add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw009
            #add-point:ON CHANGE xcdw009 name="input.g.page1.xcdw009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw002
            
            #add-point:AFTER FIELD xcdw002 name="input.a.page1.xcdw002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)               
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
#            CALL axct322_insert_default('1',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010)
#            RETURNING g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,
#                      g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201
#            CALL axct322_detail_ref('1',g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw010)
#            RETURNING g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,
#                      g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,
#                      g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc
            CALL axct322_insert_default() 
             CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            
            LET g_xcdw_d_o.xcdw002 = g_xcdw_d[g_detail_idx].xcdw002   #160824-00007#223 161202 by lori add-
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw002
            #add-point:BEFORE FIELD xcdw002 name="input.b.page1.xcdw002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw002
            #add-point:ON CHANGE xcdw002 name="input.g.page1.xcdw002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdwsite
            #add-point:BEFORE FIELD xcdwsite name="input.b.page1.xcdwsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdwsite
            
            #add-point:AFTER FIELD xcdwsite name="input.a.page1.xcdwsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdwsite
            #add-point:ON CHANGE xcdwsite name="input.g.page1.xcdwsite"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw011
            
            #add-point:AFTER FIELD xcdw011 name="input.a.page1.xcdw011"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw011
            #add-point:BEFORE FIELD xcdw011 name="input.b.page1.xcdw011"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw011
            #add-point:ON CHANGE xcdw011 name="input.g.page1.xcdw011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw012
            #add-point:BEFORE FIELD xcdw012 name="input.b.page1.xcdw012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw012
            
            #add-point:AFTER FIELD xcdw012 name="input.a.page1.xcdw012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw012
            #add-point:ON CHANGE xcdw012 name="input.g.page1.xcdw012"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw010
            
            #add-point:AFTER FIELD xcdw010 name="input.a.page1.xcdw010"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
              #IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_t.xcdw002 OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_t.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_t.xcdw008 OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_t.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_t.xcdw010)) THEN   #160824-00007#223 161202 by lori mark
               #160824-00007#223 161202 by lori add---(S)               
               #xcdw002,xcdw007,xcdw008,xcdw009,xcdw010舊值使用_o
               IF  g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t  OR g_xcdw_m.xcdw004 != g_xcdw004_t 
                OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t 
                OR g_xcdw_d[g_detail_idx].xcdw001 != g_xcdw_d_t.xcdw001 OR g_xcdw_d[g_detail_idx].xcdw002 != g_xcdw_d_o.xcdw002 
                OR g_xcdw_d[g_detail_idx].xcdw007 != g_xcdw_d_o.xcdw007 OR g_xcdw_d[g_detail_idx].xcdw008 != g_xcdw_d_o.xcdw008 
                OR g_xcdw_d[g_detail_idx].xcdw009 != g_xcdw_d_o.xcdw009 OR g_xcdw_d[g_detail_idx].xcdw010 != g_xcdw_d_o.xcdw010 THEN  
               #160824-00007#223 161202 by lori add---(E)               
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_xcdw_d[l_ac].xcdw010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdw_d[l_ac].xcdw010
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
                 #NEXT FIELD xcdw202  #140913
               ELSE
                  #檢查失敗時後續處理
                  LET g_xcdw_d[g_detail_idx].xcdw010 = g_xcdw_d_o.xcdw010   #160824-00007#223 161202 by lori add
                  NEXT FIELD CURRENT
               END IF
            
            ELSE
               NEXT FIELD CURRENT
            END IF 
           

            CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
     
            CALL axct322_insert_default()

            LET g_xcdw_d_o.xcdw010 = g_xcdw_d[g_detail_idx].xcdw010  #160824-00007#223 161202 by lori add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw010
            #add-point:BEFORE FIELD xcdw010 name="input.b.page1.xcdw010"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw010
            #add-point:ON CHANGE xcdw010 name="input.g.page1.xcdw010"
         
           
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw016
            
            #add-point:AFTER FIELD xcdw016 name="input.a.page1.xcdw016"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw016
            #add-point:BEFORE FIELD xcdw016 name="input.b.page1.xcdw016"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw016
            #add-point:ON CHANGE xcdw016 name="input.g.page1.xcdw016"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw017
            
            #add-point:AFTER FIELD xcdw017 name="input.a.page1.xcdw017"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw017
            #add-point:BEFORE FIELD xcdw017 name="input.b.page1.xcdw017"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw017
            #add-point:ON CHANGE xcdw017 name="input.g.page1.xcdw017"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw018
            #add-point:BEFORE FIELD xcdw018 name="input.b.page1.xcdw018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw018
            
            #add-point:AFTER FIELD xcdw018 name="input.a.page1.xcdw018"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw018
            #add-point:ON CHANGE xcdw018 name="input.g.page1.xcdw018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw201
            #add-point:BEFORE FIELD xcdw201 name="input.b.page1.xcdw201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw201
            
            #add-point:AFTER FIELD xcdw201 name="input.a.page1.xcdw201"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw201
            #add-point:ON CHANGE xcdw201 name="input.g.page1.xcdw201"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw202
            #add-point:BEFORE FIELD xcdw202 name="input.b.page1.xcdw202"
#            IF cl_null(g_xcdw_d[l_ac].xcdw010) THEN
#               NEXT FIELD xcdw010
#            END IF
#            LET l_xcdw202_t = g_xcdw_d[l_ac].xcdw202 
#            LET l_xcdw202_3_t = g_xcdw3_d[l_ac].xcdw202
#            LET l_xcdw202_4_t = g_xcdw4_d[l_ac].xcdw202
#            IF cl_null(l_xcdw202_t) THEN LET l_xcdw202_t = 0 END IF
#            IF cl_null(l_xcdw202_3_t) THEN LET l_xcdw202_3_t = 0 END IF
#            IF cl_null(l_xcdw202_4_t) THEN LET l_xcdw202_4_t = 0 END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw202
            
            #add-point:AFTER FIELD xcdw202 name="input.a.page1.xcdw202"
            #币一
#            SELECT sum(xcdw202) INTO l_xcdw202 FROM xcdw_t
#             WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
#               AND xcdw001 = g_xcdw_d[l_ac].xcdw001 AND xcdw002 = g_xcdw_d[l_ac].xcdw002
#               AND xcdw003 = g_xcdw_m.xcdw003 AND xcdw004 = g_xcdw_m.xcdw004
#               AND xcdw005 = g_xcdw_m.xcdw005 AND xcdw006 = g_xcdw_m.xcdw006 
#               AND xcdw007 = g_xcdw_d[l_ac].xcdw007 AND xcdw008 = g_xcdw_d[l_ac].xcdw008
#               AND xcdw009 = g_xcdw_d[l_ac].xcdw009
#            SELECT sum(xccw202) INTO l_xccw202 FROM xccw_t
#             WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
#               AND xccw001 = g_xcdw_d[l_ac].xcdw001 AND xccw002 = g_xcdw_d[l_ac].xcdw002
#               AND xccw003 = g_xcdw_m.xcdw003 AND xccw004 = g_xcdw_m.xcdw004
#               AND xccw005 = g_xcdw_m.xcdw005 AND xccw006 = g_xcdw_m.xcdw006 
#               AND xccw007 = g_xcdw_d[l_ac].xcdw007 AND xccw008 = g_xcdw_d[l_ac].xcdw008
#               AND xccw009 = g_xcdw_d[l_ac].xcdw009
#            LET l_sum = l_xcdw202 - l_xcdw202_t + g_xcdw_d[l_ac].xcdw202
#            IF l_sum > l_xccw202  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'xccw_t' 
#               LET g_errparam.columns[1] = "lbl_xcdw001"                   
#               LET g_errparam.columns[2] = "lbl_xcdw002"
#               LET g_errparam.columns[3] = "lbl_xcdw007"
#               LET g_errparam.columns[4] = "lbl_xcdw008"
#               LET g_errparam.columns[5] = "lbl_xcdw009"  
#               LET g_errparam.values[1] = '1'                   
#               LET g_errparam.values[2] = g_xcdw_d[l_ac].xcdw002
#               LET g_errparam.values[3] = g_xcdw_d[l_ac].xcdw007
#               LET g_errparam.values[4] = g_xcdw_d[l_ac].xcdw008
#               LET g_errparam.values[5] = g_xcdw_d[l_ac].xcdw009
#               CASE g_xcdw013_p 
#                    WHEN '1'
#                       LET g_errparam.code   = "axc-00538" 
#                    WHEN '2'
#                       LET g_errparam.code   = "axc-00540"
#                    WHEN '3'
#                       LET g_errparam.code   = "axc-00542"
#                    WHEN '5'
#                       LET g_errparam.code   = "axc-00546"
#               END CASE
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD CURRENT         
#            END IF
#            #币二
#            LET l_sum = 0 
#            LET l_xcdw202 = 0
#            LET l_xccw202 = 0
#            SELECT sum(xcdw202) INTO l_xcdw202 FROM xcdw_t
#             WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
#               AND xcdw001 = '2' AND xcdw002 = g_xcdw_d[l_ac].xcdw002
#               AND xcdw003 = g_xcdw_m.xcdw003 AND xcdw004 = g_xcdw_m.xcdw004
#               AND xcdw005 = g_xcdw_m.xcdw005 AND xcdw006 = g_xcdw_m.xcdw006 
#               AND xcdw007 = g_xcdw_d[l_ac].xcdw007 AND xcdw008 = g_xcdw_d[l_ac].xcdw008
#               AND xcdw009 = g_xcdw_d[l_ac].xcdw009
#            SELECT sum(xccw202) INTO l_xccw202 FROM xccw_t
#             WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
#               AND xccw001 = '2' AND xccw002 = g_xcdw_d[l_ac].xcdw002
#               AND xccw003 = g_xcdw_m.xcdw003 AND xccw004 = g_xcdw_m.xcdw004
#               AND xccw005 = g_xcdw_m.xcdw005 AND xccw006 = g_xcdw_m.xcdw006 
#               AND xccw007 = g_xcdw_d[l_ac].xcdw007 AND xccw008 = g_xcdw_d[l_ac].xcdw008
#               AND xccw009 = g_xcdw_d[l_ac].xcdw009
#            LET l_sum = l_xcdw202 - l_xcdw202_3_t + g_xcdw3_d[l_ac].xcdw202
#            IF l_sum > l_xccw202  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'xccw_t' 
#               LET g_errparam.columns[1] = "lbl_xcdw001"                   
#               LET g_errparam.columns[2] = "lbl_xcdw002"
#               LET g_errparam.columns[3] = "lbl_xcdw007"
#               LET g_errparam.columns[4] = "lbl_xcdw008"
#               LET g_errparam.columns[5] = "lbl_xcdw009"  
#               LET g_errparam.values[1] = '2'                   
#               LET g_errparam.values[2] = g_xcdw_d[l_ac].xcdw002
#               LET g_errparam.values[3] = g_xcdw_d[l_ac].xcdw007
#               LET g_errparam.values[4] = g_xcdw_d[l_ac].xcdw008
#               LET g_errparam.values[5] = g_xcdw_d[l_ac].xcdw009
#               CASE g_xcdw013_p 
#                    WHEN '1'
#                       LET g_errparam.code   = "axc-00538" 
#                    WHEN '2'
#                       LET g_errparam.code   = "axc-00540"
#                    WHEN '3'
#                       LET g_errparam.code   = "axc-00542"
#                    WHEN '5'
#                       LET g_errparam.code   = "axc-00546"
#               END CASE
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD CURRENT         
#            END IF
#            #币三
#            LET l_sum = 0 
#            LET l_xcdw202 = 0
#            LET l_xccw202 = 0
#            SELECT sum(xcdw202) INTO l_xcdw202 FROM xcdw_t
#             WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
#               AND xcdw001 = '3' AND xcdw002 = g_xcdw_d[l_ac].xcdw002
#               AND xcdw003 = g_xcdw_m.xcdw003 AND xcdw004 = g_xcdw_m.xcdw004
#               AND xcdw005 = g_xcdw_m.xcdw005 AND xcdw006 = g_xcdw_m.xcdw006 
#               AND xcdw007 = g_xcdw_d[l_ac].xcdw007 AND xcdw008 = g_xcdw_d[l_ac].xcdw008
#               AND xcdw009 = g_xcdw_d[l_ac].xcdw009
#            SELECT sum(xccw202) INTO l_xccw202 FROM xccw_t
#             WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
#               AND xccw001 = '3' AND xccw002 = g_xcdw_d[l_ac].xcdw002
#               AND xccw003 = g_xcdw_m.xcdw003 AND xccw004 = g_xcdw_m.xcdw004
#               AND xccw005 = g_xcdw_m.xcdw005 AND xccw006 = g_xcdw_m.xcdw006 
#               AND xccw007 = g_xcdw_d[l_ac].xcdw007 AND xccw008 = g_xcdw_d[l_ac].xcdw008
#               AND xccw009 = g_xcdw_d[l_ac].xcdw009
#            LET l_sum = l_xcdw202 - l_xcdw202_4_t + g_xcdw4_d[l_ac].xcdw202
#            IF l_sum > l_xccw202  THEN
#               INITIALIZE g_errparam TO NULL 
#               LET g_errparam.extend = 'xccw_t' 
#               LET g_errparam.columns[1] = "lbl_xcdw001"                   
#               LET g_errparam.columns[2] = "lbl_xcdw002"
#               LET g_errparam.columns[3] = "lbl_xcdw007"
#               LET g_errparam.columns[4] = "lbl_xcdw008"
#               LET g_errparam.columns[5] = "lbl_xcdw009"  
#               LET g_errparam.values[1] = '3'                   
#               LET g_errparam.values[2] = g_xcdw_d[l_ac].xcdw002
#               LET g_errparam.values[3] = g_xcdw_d[l_ac].xcdw007
#               LET g_errparam.values[4] = g_xcdw_d[l_ac].xcdw008
#               LET g_errparam.values[5] = g_xcdw_d[l_ac].xcdw009
#               CASE g_xcdw013_p 
#                    WHEN '1'
#                       LET g_errparam.code   = "axc-00538" 
#                    WHEN '2'
#                       LET g_errparam.code   = "axc-00540"
#                    WHEN '3'
#                       LET g_errparam.code   = "axc-00542"
#                    WHEN '5'
#                       LET g_errparam.code   = "axc-00546"
#               END CASE
#               LET g_errparam.popup  = TRUE 
#               CALL cl_err()
#               NEXT FIELD CURRENT         
#            END IF

            IF cl_null(g_xcdw_d[l_ac].xcdw202) THEN LET g_xcdw_d[l_ac].xcdw202 = 0 END IF
            CALL s_curr_round('',g_glaa001,g_xcdw_d[l_ac].xcdw202,2) RETURNING  g_xcdw_d[l_ac].xcdw202
               CALL s_transaction_begin()  #140909
               #end add-point
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw201,xcdw202, 
                   xcdw020,xcdw021,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                   g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011, 
                   g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017, 
                   g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020, 
                   g_xcdw_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw_d_t.xcdw002  
                 AND xcdw007 = g_xcdw_d_t.xcdw007  
                 AND xcdw008 = g_xcdw_d_t.xcdw008  
                 AND xcdw009 = g_xcdw_d_t.xcdw009  
                 AND xcdw010 = g_xcdw_d_t.xcdw010  
 
                 
               #add-point:單身修改中
               LET l_amount = 0
               LET l_rate = 1
               IF g_glaa015 = 'Y' THEN

                  IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN                  
                     CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
                         RETURNING l_rate
                     LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                  END IF
                  CALL s_curr_round('',g_glaa016,l_amount,2) RETURNING  l_amount
                  UPDATE xcdw_t SET (xcdw010,xcdw202) = 
                   (g_xcdw_d[l_ac].xcdw010,l_amount)                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006 
                     
                     AND xcdw001 = '2' #項次   
                     AND xcdw002 = g_xcdw_d_t.xcdw002  
                     AND xcdw007 = g_xcdw_d_t.xcdw007  
                     AND xcdw008 = g_xcdw_d_t.xcdw008  
                     AND xcdw009 = g_xcdw_d_t.xcdw009  
                     AND xcdw010 = g_xcdw_d_t.xcdw010  
               END IF
               LET l_amount = 0
               LET l_rate = 1
               IF g_glaa019 = 'Y' THEN

                  IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN
                     CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
                          RETURNING l_rate
                     LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                  END IF

                  CALL s_curr_round('',g_glaa020,l_amount,2) RETURNING  l_amount
                  UPDATE xcdw_t SET (xcdw010,xcdw202) = 
                   (g_xcdw_d[l_ac].xcdw010,l_amount)                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006 
                     
                     AND xcdw001 = '3' #項次   
                     AND xcdw002 = g_xcdw_d_t.xcdw002  
                     AND xcdw007 = g_xcdw_d_t.xcdw007  
                     AND xcdw008 = g_xcdw_d_t.xcdw008  
                     AND xcdw009 = g_xcdw_d_t.xcdw009  
                     AND xcdw010 = g_xcdw_d_t.xcdw010 
                END IF
               #end add-point
               
               
               CALL s_transaction_end('Y','0') #140909
               DISPLAY BY NAME g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,
                                g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,
                                g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,
                                g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
                    RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc                                
                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw202
            #add-point:ON CHANGE xcdw202 name="input.g.page1.xcdw202"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw020
            #add-point:BEFORE FIELD xcdw020 name="input.b.page1.xcdw020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw020
            
            #add-point:AFTER FIELD xcdw020 name="input.a.page1.xcdw020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw020
            #add-point:ON CHANGE xcdw020 name="input.g.page1.xcdw020"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw021
            
            #add-point:AFTER FIELD xcdw021 name="input.a.page1.xcdw021"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw021
            #add-point:BEFORE FIELD xcdw021 name="input.b.page1.xcdw021"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw021
            #add-point:ON CHANGE xcdw021 name="input.g.page1.xcdw021"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xcdw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw001
            #add-point:ON ACTION controlp INFIELD xcdw001 name="input.c.page1.xcdw001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw007
            #add-point:ON ACTION controlp INFIELD xcdw007 name="input.c.page1.xcdw007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw008
            #add-point:ON ACTION controlp INFIELD xcdw008 name="input.c.page1.xcdw008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw009
            #add-point:ON ACTION controlp INFIELD xcdw009 name="input.c.page1.xcdw009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw002
            #add-point:ON ACTION controlp INFIELD xcdw002 name="input.c.page1.xcdw002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdwsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdwsite
            #add-point:ON ACTION controlp INFIELD xcdwsite name="input.c.page1.xcdwsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw011
            #add-point:ON ACTION controlp INFIELD xcdw011 name="input.c.page1.xcdw011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw012
            #add-point:ON ACTION controlp INFIELD xcdw012 name="input.c.page1.xcdw012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw010
            #add-point:ON ACTION controlp INFIELD xcdw010 name="input.c.page1.xcdw010"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_d[l_ac].xcdw010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcau001()                                #呼叫開窗

            LET g_xcdw_d[l_ac].xcdw010 = g_qryparam.return1              

            DISPLAY g_xcdw_d[l_ac].xcdw010 TO xcdw010              #

            NEXT FIELD xcdw010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw016
            #add-point:ON ACTION controlp INFIELD xcdw016 name="input.c.page1.xcdw016"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw017
            #add-point:ON ACTION controlp INFIELD xcdw017 name="input.c.page1.xcdw017"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw018
            #add-point:ON ACTION controlp INFIELD xcdw018 name="input.c.page1.xcdw018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw_d[l_ac].xcdw018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xcdw_d[l_ac].xcdw018 = g_qryparam.return1              

            DISPLAY g_xcdw_d[l_ac].xcdw018 TO xcdw018              #

            NEXT FIELD xcdw018                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw201
            #add-point:ON ACTION controlp INFIELD xcdw201 name="input.c.page1.xcdw201"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw202
            #add-point:ON ACTION controlp INFIELD xcdw202 name="input.c.page1.xcdw202"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw020
            #add-point:ON ACTION controlp INFIELD xcdw020 name="input.c.page1.xcdw020"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xcdw021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw021
            #add-point:ON ACTION controlp INFIELD xcdw021 name="input.c.page1.xcdw021"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcdw_d[l_ac].* = g_xcdw_d_t.*
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdw_d[l_ac].xcdw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdw_d[l_ac].* = g_xcdw_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前 name="input.body.b_update"

               IF cl_null(g_xcdw_d[l_ac].xcdw202) THEN LET g_xcdw_d[l_ac].xcdw202 = 0 END IF
               CALL s_curr_round('',g_glaa001,g_xcdw_d[l_ac].xcdw202,2) RETURNING  g_xcdw_d[l_ac].xcdw202
               CALL s_transaction_begin()  #140909
               #end add-point
         
               #將遮罩欄位還原
               CALL axct322_xcdw_t_mask_restore('restore_mask_o')
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw201,xcdw202, 
                   xcdw020,xcdw021,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                   g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011, 
                   g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017, 
                   g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020, 
                   g_xcdw_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw_d_t.xcdw002  
                 AND xcdw007 = g_xcdw_d_t.xcdw007  
                 AND xcdw008 = g_xcdw_d_t.xcdw008  
                 AND xcdw009 = g_xcdw_d_t.xcdw009  
                 AND xcdw010 = g_xcdw_d_t.xcdw010  
 
                 
               #add-point:單身修改中 name="input.body.m_update"
               LET l_amount = 0
               LET l_rate = 1
               IF g_glaa015 = 'Y' THEN
                  IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN                  
                     CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa016,0,g_glaa018)
                         RETURNING l_rate
                     LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                  END IF
                  CALL s_curr_round('',g_glaa016,l_amount,2) RETURNING  l_amount
                  UPDATE xcdw_t SET (xcdw010,xcdw202) = 
                   (g_xcdw_d[l_ac].xcdw010,l_amount)                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006 
                     
                     AND xcdw001 = '2' #項次   
                     AND xcdw002 = g_xcdw_d_t.xcdw002  
                     AND xcdw007 = g_xcdw_d_t.xcdw007  
                     AND xcdw008 = g_xcdw_d_t.xcdw008  
                     AND xcdw009 = g_xcdw_d_t.xcdw009  
                     AND xcdw010 = g_xcdw_d_t.xcdw010  
               END IF
               LET l_amount = 0
               LET l_rate = 1
               IF g_glaa019 = 'Y' THEN
                  IF g_xcdw_d[l_ac].xcdw202 <> 0 THEN
                     CALL s_aooi160_get_exrate('2',g_xcdw_m.xcdwld,g_today,g_glaa001,g_glaa020,0,g_glaa022)
                          RETURNING l_rate
                     LET l_amount = l_rate * g_xcdw_d[l_ac].xcdw202
                  END IF
                  CALL s_curr_round('',g_glaa020,l_amount,2) RETURNING  l_amount
                  UPDATE xcdw_t SET (xcdw010,xcdw202) = 
                   (g_xcdw_d[l_ac].xcdw010,l_amount)                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006 
                     
                     AND xcdw001 = '3' #項次   
                     AND xcdw002 = g_xcdw_d_t.xcdw002  
                     AND xcdw007 = g_xcdw_d_t.xcdw007  
                     AND xcdw008 = g_xcdw_d_t.xcdw008  
                     AND xcdw009 = g_xcdw_d_t.xcdw009  
                     AND xcdw010 = g_xcdw_d_t.xcdw010 
                END IF
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdw_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdw_m.xcdwld
               LET gs_keys_bak[1] = g_xcdwld_t
               LET gs_keys[2] = g_xcdw_m.xcdw003
               LET gs_keys_bak[2] = g_xcdw003_t
               LET gs_keys[3] = g_xcdw_m.xcdw004
               LET gs_keys_bak[3] = g_xcdw004_t
               LET gs_keys[4] = g_xcdw_m.xcdw005
               LET gs_keys_bak[4] = g_xcdw005_t
               LET gs_keys[5] = g_xcdw_m.xcdw006
               LET gs_keys_bak[5] = g_xcdw006_t
               LET gs_keys[6] = g_xcdw_d[g_detail_idx].xcdw001
               LET gs_keys_bak[6] = g_xcdw_d_t.xcdw001
               LET gs_keys[7] = g_xcdw_d[g_detail_idx].xcdw002
               LET gs_keys_bak[7] = g_xcdw_d_t.xcdw002
               LET gs_keys[8] = g_xcdw_d[g_detail_idx].xcdw007
               LET gs_keys_bak[8] = g_xcdw_d_t.xcdw007
               LET gs_keys[9] = g_xcdw_d[g_detail_idx].xcdw008
               LET gs_keys_bak[9] = g_xcdw_d_t.xcdw008
               LET gs_keys[10] = g_xcdw_d[g_detail_idx].xcdw009
               LET gs_keys_bak[10] = g_xcdw_d_t.xcdw009
               LET gs_keys[11] = g_xcdw_d[g_detail_idx].xcdw010
               LET gs_keys_bak[11] = g_xcdw_d_t.xcdw010
               CALL axct322_update_b('xcdw_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
                     
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct322_xcdw_t_mask_restore('restore_mask_n')
               
               #若Key欄位有變動
               LET ls_keys[01] = g_xcdw_m.xcdwld
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_m.xcdw003
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_m.xcdw004
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_m.xcdw005
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_m.xcdw006
 
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw001
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw002
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw007
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw008
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw009
               LET ls_keys[ls_keys.getLength()+1] = g_xcdw_d_t.xcdw010
 
               CALL axct322_key_update_b(ls_keys)
               
               #add-point:單身修改後 name="input.body.a_update"
               CALL s_transaction_end('Y','0') #140909
               DISPLAY BY NAME g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008,g_xcdw_d[l_ac].xcdw009,
                                g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,
                                g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,
                                g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
                    RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc                                
               #end add-point
            END IF
 
         AFTER ROW
            #add-point:input段after row name="input.body.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcdw_d[l_ac].* = g_xcdw_d_t.*
               END IF
               EXIT DIALOG 
            END IF
 
            CLOSE axct322_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdw_d.getLength() = 0 THEN
               NEXT FIELD xcdw001
            END IF
            #add-point:input段after input  name="input.body.after_input"

 
            #end add-point    
            
         ON ACTION controlo   
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcdw_d[li_reproduce_target].* = g_xcdw_d[li_reproduce].*
               LET g_xcdw2_d[li_reproduce_target].* = g_xcdw2_d[li_reproduce].*
 
               LET g_xcdw_d[li_reproduce_target].xcdw001 = NULL
               LET g_xcdw_d[li_reproduce_target].xcdw002 = NULL
               LET g_xcdw_d[li_reproduce_target].xcdw007 = NULL
               LET g_xcdw_d[li_reproduce_target].xcdw008 = NULL
               LET g_xcdw_d[li_reproduce_target].xcdw009 = NULL
               LET g_xcdw_d[li_reproduce_target].xcdw010 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcdw_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcdw_d.getLength()+1
            END IF
            
      END INPUT
 
      INPUT ARRAY g_xcdw2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct322_b_fill(g_wc2) #test 
            #如果一直都在單頭則控制筆數位置
            IF g_loc = 'm' THEN
               CALL FGL_SET_ARR_CURR(g_detail_idx)
            END IF
            LET g_loc = 'm' 
            LET g_current_page = 2
            #add-point:資料輸入前 name="input.body2.before_input"
            
            #end add-point
 
         BEFORE ROW 
            #add-point:before row name="input.body2.before_row2"
            
            #end add-point
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()               #returns the current row
            IF l_ac > g_rec_b THEN              #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL axct322_idx_chk()
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct322_set_entry_b(l_cmd)
               #add-point:set_entry_b後 name="input.body2.before_row.set_entry_b"
               
               #end add-point
               CALL axct322_set_no_entry_b(l_cmd)
               LET g_xcdw2_d_t.* = g_xcdw2_d[l_ac].*   #BACKUP  #page1
               LET g_xcdw2_d_o.* = g_xcdw2_d[l_ac].*   #BACKUP  #page1
            END IF 
            
 
 
    
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xcdw001
 
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            INITIALIZE g_xcdw2_d_t.* TO NULL
            INITIALIZE g_xcdw2_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xcdw2_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份 name="input.body2.before_insert.before_bak"
            
            #end add-point
            LET g_xcdw2_d_t.* = g_xcdw2_d[l_ac].*     #新輸入資料
            LET g_xcdw2_d_o.* = g_xcdw2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct322_set_entry_b(l_cmd)
            #add-point:set_entry_b後 name="input.body2.before_insert.set_entry_b"
            
            #end add-point
            CALL axct322_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xcdw_d[li_reproduce_target].* = g_xcdw_d[li_reproduce].*
               LET g_xcdw2_d[li_reproduce_target].* = g_xcdw2_d[li_reproduce].*
 
               LET g_xcdw2_d[li_reproduce_target].xcdw001 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw002 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw007 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw008 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw009 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw010 = NULL
            END IF
            
 
 
            #add-point:modify段before insert name="input.body2.before_insert"
            
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  CANCEL DELETE
               END IF
               IF axct322_before_delete() THEN 
                  
 
 
  
                  #取得該筆資料key值
                  INITIALIZE gs_keys TO NULL
                  LET gs_keys[01] = g_xcdw_m.xcdwld
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw003
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw004
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw005
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_m.xcdw006
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw001
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw002
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw007
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw008
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw009
                  LET gs_keys[gs_keys.getLength()+1] = g_xcdw_d_t.xcdw010
 
                  #刪除下層單身
                  IF NOT axct322_key_delete_b(gs_keys,'xcdw_t') THEN
                     CALL s_transaction_end('N','0')
                     CLOSE axct322_bcl
                     CANCEL DELETE
                  END IF
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct322_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xcdw2_d.getLength()
            END IF
            
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE  name="input.body2.after_delete"
#               CALL axct322_xcdw010_chk() RETURNING l_success
#                IF l_success = 'N' THEN         
#                   NEXT FIELD CURRENT    
#                END IF 
#                CALL axct322_sum_chk() RETURNING l_success
#                IF l_success = 'N' THEN         
#                   NEXT FIELD CURRENT    
#                END IF
               #end add-point
                              CALL axct322_delete_b('xcdw_t',gs_keys,"'2'")
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdw2_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_xcdw2_d[l_ac].* = g_xcdw2_d_t.*
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdw_d[l_ac].xcdw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xcdw2_d[l_ac].* = g_xcdw2_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前 name="modify.body2.b_update"
               
               #end add-point
               
               #將遮罩欄位還原
               CALL axct322_xcdw_t_mask_restore('restore_mask_o')
                     
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw201,xcdw202, 
                   xcdw020,xcdw021,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
                   g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011, 
                   g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017, 
                   g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020, 
                   g_xcdw_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034) #自訂欄位頁簽
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
                 AND xcdw003 = g_xcdw_m.xcdw003
                 AND xcdw004 = g_xcdw_m.xcdw004
                 AND xcdw005 = g_xcdw_m.xcdw005
                 AND xcdw006 = g_xcdw_m.xcdw006
                 AND xcdw001 = g_xcdw2_d_t.xcdw001 #項次 
                 AND xcdw002 = g_xcdw2_d_t.xcdw002
                 AND xcdw007 = g_xcdw2_d_t.xcdw007
                 AND xcdw008 = g_xcdw2_d_t.xcdw008
                 AND xcdw009 = g_xcdw2_d_t.xcdw009
                 AND xcdw010 = g_xcdw2_d_t.xcdw010
               #add-point:單身修改中 name="modify.body2.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     CALL s_transaction_end('N','0')
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdw_m.xcdwld
               LET gs_keys_bak[1] = g_xcdwld_t
               LET gs_keys[2] = g_xcdw_m.xcdw003
               LET gs_keys_bak[2] = g_xcdw003_t
               LET gs_keys[3] = g_xcdw_m.xcdw004
               LET gs_keys_bak[3] = g_xcdw004_t
               LET gs_keys[4] = g_xcdw_m.xcdw005
               LET gs_keys_bak[4] = g_xcdw005_t
               LET gs_keys[5] = g_xcdw_m.xcdw006
               LET gs_keys_bak[5] = g_xcdw006_t
               LET gs_keys[6] = g_xcdw2_d[g_detail_idx].xcdw001
               LET gs_keys_bak[6] = g_xcdw2_d_t.xcdw001
               LET gs_keys[7] = g_xcdw2_d[g_detail_idx].xcdw002
               LET gs_keys_bak[7] = g_xcdw2_d_t.xcdw002
               LET gs_keys[8] = g_xcdw2_d[g_detail_idx].xcdw007
               LET gs_keys_bak[8] = g_xcdw2_d_t.xcdw007
               LET gs_keys[9] = g_xcdw2_d[g_detail_idx].xcdw008
               LET gs_keys_bak[9] = g_xcdw2_d_t.xcdw008
               LET gs_keys[10] = g_xcdw2_d[g_detail_idx].xcdw009
               LET gs_keys_bak[10] = g_xcdw2_d_t.xcdw009
               LET gs_keys[11] = g_xcdw2_d[g_detail_idx].xcdw010
               LET gs_keys_bak[11] = g_xcdw2_d_t.xcdw010
               CALL axct322_update_b('xcdw_t',gs_keys,gs_keys_bak,"'2'")
                     #修改歷程記錄(單身修改)
                     LET g_log1 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw2_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw2_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL axct322_xcdw_t_mask_restore('restore_mask_n')
               
               #add-point:單身修改後 name="modify.body2.a_update"
               
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw032
            #add-point:BEFORE FIELD xcdw032 name="input.b.page2.xcdw032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw032
            
            #add-point:AFTER FIELD xcdw032 name="input.a.page2.xcdw032"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw032
            #add-point:ON CHANGE xcdw032 name="input.g.page2.xcdw032"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw033
            #add-point:BEFORE FIELD xcdw033 name="input.b.page2.xcdw033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw033
            
            #add-point:AFTER FIELD xcdw033 name="input.a.page2.xcdw033"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw033
            #add-point:ON CHANGE xcdw033 name="input.g.page2.xcdw033"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw022
            #add-point:BEFORE FIELD xcdw022 name="input.b.page2.xcdw022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw022
            
            #add-point:AFTER FIELD xcdw022 name="input.a.page2.xcdw022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw022
            #add-point:ON CHANGE xcdw022 name="input.g.page2.xcdw022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw023
            #add-point:BEFORE FIELD xcdw023 name="input.b.page2.xcdw023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw023
            
            #add-point:AFTER FIELD xcdw023 name="input.a.page2.xcdw023"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw023
            #add-point:ON CHANGE xcdw023 name="input.g.page2.xcdw023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw024
            #add-point:BEFORE FIELD xcdw024 name="input.b.page2.xcdw024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw024
            
            #add-point:AFTER FIELD xcdw024 name="input.a.page2.xcdw024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw024
            #add-point:ON CHANGE xcdw024 name="input.g.page2.xcdw024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw025
            #add-point:BEFORE FIELD xcdw025 name="input.b.page2.xcdw025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw025
            
            #add-point:AFTER FIELD xcdw025 name="input.a.page2.xcdw025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw025
            #add-point:ON CHANGE xcdw025 name="input.g.page2.xcdw025"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw026
            #add-point:BEFORE FIELD xcdw026 name="input.b.page2.xcdw026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw026
            
            #add-point:AFTER FIELD xcdw026 name="input.a.page2.xcdw026"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw026
            #add-point:ON CHANGE xcdw026 name="input.g.page2.xcdw026"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw027
            #add-point:BEFORE FIELD xcdw027 name="input.b.page2.xcdw027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw027
            
            #add-point:AFTER FIELD xcdw027 name="input.a.page2.xcdw027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw027
            #add-point:ON CHANGE xcdw027 name="input.g.page2.xcdw027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw028
            #add-point:BEFORE FIELD xcdw028 name="input.b.page2.xcdw028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw028
            
            #add-point:AFTER FIELD xcdw028 name="input.a.page2.xcdw028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw028
            #add-point:ON CHANGE xcdw028 name="input.g.page2.xcdw028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw029
            #add-point:BEFORE FIELD xcdw029 name="input.b.page2.xcdw029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw029
            
            #add-point:AFTER FIELD xcdw029 name="input.a.page2.xcdw029"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw029
            #add-point:ON CHANGE xcdw029 name="input.g.page2.xcdw029"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw030
            #add-point:BEFORE FIELD xcdw030 name="input.b.page2.xcdw030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw030
            
            #add-point:AFTER FIELD xcdw030 name="input.a.page2.xcdw030"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw030
            #add-point:ON CHANGE xcdw030 name="input.g.page2.xcdw030"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw031
            #add-point:BEFORE FIELD xcdw031 name="input.b.page2.xcdw031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw031
            
            #add-point:AFTER FIELD xcdw031 name="input.a.page2.xcdw031"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw031
            #add-point:ON CHANGE xcdw031 name="input.g.page2.xcdw031"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcdw034
            #add-point:BEFORE FIELD xcdw034 name="input.b.page2.xcdw034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcdw034
            
            #add-point:AFTER FIELD xcdw034 name="input.a.page2.xcdw034"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcdw034
            #add-point:ON CHANGE xcdw034 name="input.g.page2.xcdw034"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.xcdw032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw032
            #add-point:ON ACTION controlp INFIELD xcdw032 name="input.c.page2.xcdw032"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw033
            #add-point:ON ACTION controlp INFIELD xcdw033 name="input.c.page2.xcdw033"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw022
            #add-point:ON ACTION controlp INFIELD xcdw022 name="input.c.page2.xcdw022"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw023
            #add-point:ON ACTION controlp INFIELD xcdw023 name="input.c.page2.xcdw023"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw024
            #add-point:ON ACTION controlp INFIELD xcdw024 name="input.c.page2.xcdw024"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw025
            #add-point:ON ACTION controlp INFIELD xcdw025 name="input.c.page2.xcdw025"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw026
            #add-point:ON ACTION controlp INFIELD xcdw026 name="input.c.page2.xcdw026"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw027
            #add-point:ON ACTION controlp INFIELD xcdw027 name="input.c.page2.xcdw027"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw028
            #add-point:ON ACTION controlp INFIELD xcdw028 name="input.c.page2.xcdw028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw029
            #add-point:ON ACTION controlp INFIELD xcdw029 name="input.c.page2.xcdw029"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw030
            #add-point:ON ACTION controlp INFIELD xcdw030 name="input.c.page2.xcdw030"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw031
            #add-point:ON ACTION controlp INFIELD xcdw031 name="input.c.page2.xcdw031"
            
            #END add-point
 
 
         #Ctrlp:input.c.page2.xcdw034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcdw034
            #add-point:ON ACTION controlp INFIELD xcdw034 name="input.c.page2.xcdw034"
            
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:input段after row name="input.body2.after_row"
            
            #end add-point  
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xcdw2_d[l_ac].* = g_xcdw2_d_t.*
               END IF
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               EXIT DIALOG 
            END IF
 
            CLOSE axct322_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input  name="input.body2.after_input"
            
            #end add-point    
 
         ON ACTION controlo
            IF l_insert THEN
               LET li_reproduce = l_ac_t
               LET li_reproduce_target = l_ac
               LET g_xcdw_d[li_reproduce_target].* = g_xcdw_d[li_reproduce].*
               LET g_xcdw2_d[li_reproduce_target].* = g_xcdw2_d[li_reproduce].*
 
               LET g_xcdw2_d[li_reproduce_target].xcdw001 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw002 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw007 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw008 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw009 = NULL
               LET g_xcdw2_d[li_reproduce_target].xcdw010 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_xcdw2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_xcdw2_d.getLength()+1
            END IF
      END INPUT
 
      
 
      
 
      
 
    
      #add-point:input段more_input name="input.more_inputarray"
      INPUT ARRAY g_xcdw3_d FROM s_detail3.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = 1,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdw3_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct322_b_fill_3() 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct322_cl USING g_enterprise,
                                               g_xcdw_m.xcdwld
                                               ,g_xcdw_m.xcdw003
                                               ,g_xcdw_m.xcdw004
                                               ,g_xcdw_m.xcdw005
                                               ,g_xcdw_m.xcdw006
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct322_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdw3_d[l_ac].xcdw001 IS NOT NULL
               AND g_xcdw3_d[l_ac].xcdw002 IS NOT NULL
               AND g_xcdw3_d[l_ac].xcdw007 IS NOT NULL
               AND g_xcdw3_d[l_ac].xcdw008 IS NOT NULL
               AND g_xcdw3_d[l_ac].xcdw009 IS NOT NULL
               AND g_xcdw3_d[l_ac].xcdw010 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcdw3_d_t.* = g_xcdw3_d[l_ac].*  #BACKUP
               LET g_xcdw3_d_o.* = g_xcdw3_d[l_ac].*  #BACKUP
               CALL axct322_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct322_set_no_entry_b(l_cmd)
               OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                g_xcdw3_d_t.xcdw001
                                                ,g_xcdw3_d_t.xcdw002
                                                ,g_xcdw3_d_t.xcdw007
                                                ,g_xcdw3_d_t.xcdw008
                                                ,g_xcdw3_d_t.xcdw009
                                                ,g_xcdw3_d_t.xcdw010
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'               
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               
               
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '1'
                                                ,g_xcdw3_d_t.xcdw002
                                                ,g_xcdw3_d_t.xcdw007
                                                ,g_xcdw3_d_t.xcdw008
                                                ,g_xcdw3_d_t.xcdw009
                                                ,g_xcdw3_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa019 = 'Y' THEN                                 
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '3'
                                                ,g_xcdw3_d_t.xcdw002
                                                ,g_xcdw3_d_t.xcdw007
                                                ,g_xcdw3_d_t.xcdw008
                                                ,g_xcdw3_d_t.xcdw009
                                                ,g_xcdw3_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            #end add-point  
            
        
        
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前

               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               IF axct322_before_delete_3() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct322_bcl
               LET l_count = g_xcdw3_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               IF g_rec_b = 0 THEN
                  RETURN
               END IF  
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdw3_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xcdw001
            #add-point:BEFORE FIELD xcdw001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw001
            
            #add-point:AFTER FIELD xcdw001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw001
            #add-point:ON CHANGE xcdw001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw007
            #add-point:BEFORE FIELD xcdw007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw007
            
            #add-point:AFTER FIELD xcdw007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw007
            #add-point:ON CHANGE xcdw007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw008
            #add-point:BEFORE FIELD xcdw008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw008
            
            #add-point:AFTER FIELD xcdw008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw008
            #add-point:ON CHANGE xcdw008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw009
            #add-point:BEFORE FIELD xcdw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw009
            
            #add-point:AFTER FIELD xcdw009
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw009
            #add-point:ON CHANGE xcdw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw002
            
            #add-point:AFTER FIELD xcdw002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw002
            #add-point:BEFORE FIELD xcdw002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw002
            #add-point:ON CHANGE xcdw002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdwsite
            #add-point:BEFORE FIELD xcdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdwsite
            
            #add-point:AFTER FIELD xcdwsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdwsite
            #add-point:ON CHANGE xcdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw011
            
            #add-point:AFTER FIELD xcdw011


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw011
            #add-point:BEFORE FIELD xcdw011

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw011
            #add-point:ON CHANGE xcdw011

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw012
            #add-point:BEFORE FIELD xcdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw012
            
            #add-point:AFTER FIELD xcdw012

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw012
            #add-point:ON CHANGE xcdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw010_3
            
            #add-point:AFTER FIELD xcdw010
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw3_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw3_d[g_detail_idx].xcdw001 != g_xcdw3_d_t.xcdw001 OR g_xcdw3_d[g_detail_idx].xcdw002 != g_xcdw3_d_t.xcdw002 OR g_xcdw3_d[g_detail_idx].xcdw007 != g_xcdw3_d_t.xcdw007 OR g_xcdw3_d[g_detail_idx].xcdw008 != g_xcdw3_d_t.xcdw008 OR g_xcdw3_d[g_detail_idx].xcdw009 != g_xcdw3_d_t.xcdw009 OR g_xcdw3_d[g_detail_idx].xcdw010 != g_xcdw3_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw3_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw3_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw3_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw3_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw3_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw3_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_xcdw3_d[l_ac].xcdw010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdw3_d[l_ac].xcdw010
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
#                  NEXT FIELD xcdw202_3
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            
            ELSE 
               NEXT FIELD CURRENT
            END IF 

            CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
            RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
                            
            
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw010_3
            #add-point:BEFORE FIELD xcdw010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw010
            #add-point:ON CHANGE xcdw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw016
            
            #add-point:AFTER FIELD xcdw016


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw016
            #add-point:BEFORE FIELD xcdw016

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw016
            #add-point:ON CHANGE xcdw016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw017
            
            #add-point:AFTER FIELD xcdw017


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw017
            #add-point:BEFORE FIELD xcdw017

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw017
            #add-point:ON CHANGE xcdw017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw018
            #add-point:BEFORE FIELD xcdw018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw018
            
            #add-point:AFTER FIELD xcdw018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw018
            #add-point:ON CHANGE xcdw018

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw020
            #add-point:BEFORE FIELD xcdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw020
            
            #add-point:AFTER FIELD xcdw020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw020
            #add-point:ON CHANGE xcdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw021
            
            #add-point:AFTER FIELD xcdw021


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw021
            #add-point:BEFORE FIELD xcdw021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw021
            #add-point:ON CHANGE xcdw021

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw201
            #add-point:BEFORE FIELD xcdw201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw201
            
            #add-point:AFTER FIELD xcdw201

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw201
            #add-point:ON CHANGE xcdw201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw202_3
            #add-point:BEFORE FIELD xcdw202
            IF cl_null(g_xcdw3_d[l_ac].xcdw010) THEN
               NEXT FIELD xcdw010_3
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw202_3
            
            #add-point:AFTER FIELD xcdw202
            CALL s_transaction_begin()  #140909
            CALL s_curr_round('',g_glaa016,g_xcdw3_d[l_ac].xcdw202,2) RETURNING  g_xcdw3_d[l_ac].xcdw202
               #end add-point
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021, 
                   xcdw201,xcdw202,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw3_d[l_ac].xcdw001,g_xcdw3_d[l_ac].xcdw007,g_xcdw3_d[l_ac].xcdw008, 
                   g_xcdw3_d[l_ac].xcdw009,g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdwsite,g_xcdw3_d[l_ac].xcdw011, 
                   g_xcdw3_d[l_ac].xcdw012,g_xcdw3_d[l_ac].xcdw010,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017, 
                   g_xcdw3_d[l_ac].xcdw018,g_xcdw3_d[l_ac].xcdw020,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw201, 
                   g_xcdw3_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw3_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw3_d_t.xcdw002  
                 AND xcdw007 = g_xcdw3_d_t.xcdw007  
                 AND xcdw008 = g_xcdw3_d_t.xcdw008  
                 AND xcdw009 = g_xcdw3_d_t.xcdw009  
                 AND xcdw010 = g_xcdw3_d_t.xcdw010  
 
                 
               #add-point:單身修改中
               
                  UPDATE xcdw_t SET xcdw010 = 
                   g_xcdw3_d[l_ac].xcdw010                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006                   
                     
                     AND xcdw002 = g_xcdw3_d_t.xcdw002  
                     AND xcdw007 = g_xcdw3_d_t.xcdw007  
                     AND xcdw008 = g_xcdw3_d_t.xcdw008  
                     AND xcdw009 = g_xcdw3_d_t.xcdw009  
                     AND xcdw010 = g_xcdw3_d_t.xcdw010  
                     
                     
                     
                     
                     CALL s_transaction_end('Y','0') #140909 
                DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw001,g_xcdw3_d[l_ac].xcdw007,g_xcdw3_d[l_ac].xcdw008,g_xcdw3_d[l_ac].xcdw009,
                                g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdwsite,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw012,
                                g_xcdw3_d[l_ac].xcdw010,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw018,
                                g_xcdw3_d[l_ac].xcdw201,g_xcdw3_d[l_ac].xcdw202,g_xcdw3_d[l_ac].xcdw020,g_xcdw3_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
                     RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
               DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
                            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw202
            #add-point:ON CHANGE xcdw202

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xcdw001
         ON ACTION controlp INFIELD xcdw001
            #add-point:ON ACTION controlp INFIELD xcdw001

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw007
         ON ACTION controlp INFIELD xcdw007
            #add-point:ON ACTION controlp INFIELD xcdw007

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw008
         ON ACTION controlp INFIELD xcdw008
            #add-point:ON ACTION controlp INFIELD xcdw008

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw009
         ON ACTION controlp INFIELD xcdw009
            #add-point:ON ACTION controlp INFIELD xcdw009

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw002
         ON ACTION controlp INFIELD xcdw002
            #add-point:ON ACTION controlp INFIELD xcdw002

            #END add-point
 
         #Ctrlp:input.c.page1.xcdwsite
         ON ACTION controlp INFIELD xcdwsite
            #add-point:ON ACTION controlp INFIELD xcdwsite

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw011
         ON ACTION controlp INFIELD xcdw011
            #add-point:ON ACTION controlp INFIELD xcdw011

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw012
         ON ACTION controlp INFIELD xcdw012
            #add-point:ON ACTION controlp INFIELD xcdw012

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw010
         ON ACTION controlp INFIELD xcdw010_3
            #add-point:ON ACTION controlp INFIELD xcdw010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw3_d[l_ac].xcdw010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcau001()                                #呼叫開窗

            LET g_xcdw3_d[l_ac].xcdw010 = g_qryparam.return1              

            DISPLAY g_xcdw3_d[l_ac].xcdw010 TO xcdw010_3              #
            CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
            RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
            NEXT FIELD xcdw010_3                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcdw016
         ON ACTION controlp INFIELD xcdw016
            #add-point:ON ACTION controlp INFIELD xcdw016

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw017
         ON ACTION controlp INFIELD xcdw017
            #add-point:ON ACTION controlp INFIELD xcdw017

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw018
         ON ACTION controlp INFIELD xcdw018
            #add-point:ON ACTION controlp INFIELD xcdw018
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw3_d[l_ac].xcdw018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xcdw3_d[l_ac].xcdw018 = g_qryparam.return1              

            DISPLAY g_xcdw3_d[l_ac].xcdw018 TO xcdw018              #

            NEXT FIELD xcdw018                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcdw020
         ON ACTION controlp INFIELD xcdw020
            #add-point:ON ACTION controlp INFIELD xcdw020

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw021
         ON ACTION controlp INFIELD xcdw021
            #add-point:ON ACTION controlp INFIELD xcdw021

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw201
         ON ACTION controlp INFIELD xcdw201
            #add-point:ON ACTION controlp INFIELD xcdw201

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw202
         ON ACTION controlp INFIELD xcdw202
            #add-point:ON ACTION controlp INFIELD xcdw202

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdw3_d[l_ac].* = g_xcdw3_d_t.*
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdw3_d[l_ac].xcdw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xcdw3_d[l_ac].* = g_xcdw3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               CALL s_transaction_begin()  #140909
               IF cl_null(g_xcdw3_d[l_ac].xcdw202) THEN LET g_xcdw3_d[l_ac].xcdw202 = 0 END IF
               CALL s_curr_round('',g_glaa016,g_xcdw3_d[l_ac].xcdw202,2) RETURNING  g_xcdw3_d[l_ac].xcdw202
               #end add-point
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021, 
                   xcdw201,xcdw202,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw3_d[l_ac].xcdw001,g_xcdw3_d[l_ac].xcdw007,g_xcdw3_d[l_ac].xcdw008, 
                   g_xcdw3_d[l_ac].xcdw009,g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdwsite,g_xcdw3_d[l_ac].xcdw011, 
                   g_xcdw3_d[l_ac].xcdw012,g_xcdw3_d[l_ac].xcdw010,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017, 
                   g_xcdw3_d[l_ac].xcdw018,g_xcdw3_d[l_ac].xcdw020,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw201, 
                   g_xcdw3_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw3_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw3_d_t.xcdw002  
                 AND xcdw007 = g_xcdw3_d_t.xcdw007  
                 AND xcdw008 = g_xcdw3_d_t.xcdw008  
                 AND xcdw009 = g_xcdw3_d_t.xcdw009  
                 AND xcdw010 = g_xcdw3_d_t.xcdw010  
 
                 
               #add-point:單身修改中
               
                  UPDATE xcdw_t SET xcdw010 = 
                   g_xcdw3_d[l_ac].xcdw010                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006                   
                     
                     AND xcdw002 = g_xcdw3_d_t.xcdw002  
                     AND xcdw007 = g_xcdw3_d_t.xcdw007  
                     AND xcdw008 = g_xcdw3_d_t.xcdw008  
                     AND xcdw009 = g_xcdw3_d_t.xcdw009  
                     AND xcdw010 = g_xcdw3_d_t.xcdw010  
               
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdw_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdw_m.xcdwld
               LET gs_keys_bak[1] = g_xcdwld_t
               LET gs_keys[2] = g_xcdw_m.xcdw003
               LET gs_keys_bak[2] = g_xcdw003_t
               LET gs_keys[3] = g_xcdw_m.xcdw004
               LET gs_keys_bak[3] = g_xcdw004_t
               LET gs_keys[4] = g_xcdw_m.xcdw005
               LET gs_keys_bak[4] = g_xcdw005_t
               LET gs_keys[5] = g_xcdw_m.xcdw006
               LET gs_keys_bak[5] = g_xcdw006_t
               LET gs_keys[6] = g_xcdw3_d[g_detail_idx].xcdw001
               LET gs_keys_bak[6] = g_xcdw3_d_t.xcdw001
               LET gs_keys[7] = g_xcdw3_d[g_detail_idx].xcdw002
               LET gs_keys_bak[7] = g_xcdw3_d_t.xcdw002
               LET gs_keys[8] = g_xcdw3_d[g_detail_idx].xcdw007
               LET gs_keys_bak[8] = g_xcdw3_d_t.xcdw007
               LET gs_keys[9] = g_xcdw3_d[g_detail_idx].xcdw008
               LET gs_keys_bak[9] = g_xcdw3_d_t.xcdw008
               LET gs_keys[10] = g_xcdw3_d[g_detail_idx].xcdw009
               LET gs_keys_bak[10] = g_xcdw3_d_t.xcdw009
               LET gs_keys[11] = g_xcdw3_d[g_detail_idx].xcdw010
               LET gs_keys_bak[11] = g_xcdw3_d_t.xcdw010
               CALL axct322_update_b('xcdw_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw3_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw3_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
                CALL s_transaction_end('Y','0') #140909 
                DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw001,g_xcdw3_d[l_ac].xcdw007,g_xcdw3_d[l_ac].xcdw008,g_xcdw3_d[l_ac].xcdw009,
                                g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdwsite,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw012,
                                g_xcdw3_d[l_ac].xcdw010,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw018,
                                g_xcdw3_d[l_ac].xcdw201,g_xcdw3_d[l_ac].xcdw202,g_xcdw3_d[l_ac].xcdw020,g_xcdw3_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
                     RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
               DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdw3_d.getLength() = 0 THEN
               NEXT FIELD xcdw001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdw3_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdw3_d.getLength()+1
            
      END INPUT
      INPUT ARRAY g_xcdw4_d FROM s_detail4.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = 0,
                  DELETE ROW = 1,
                  APPEND ROW = 0)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xcdw4_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct322_b_fill_4() 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct322_cl USING g_enterprise,
                                               g_xcdw_m.xcdwld
                                               ,g_xcdw_m.xcdw003
                                               ,g_xcdw_m.xcdw004
                                               ,g_xcdw_m.xcdw005
                                               ,g_xcdw_m.xcdw006
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct322_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xcdw4_d[l_ac].xcdw001 IS NOT NULL
               AND g_xcdw4_d[l_ac].xcdw002 IS NOT NULL
               AND g_xcdw4_d[l_ac].xcdw007 IS NOT NULL
               AND g_xcdw4_d[l_ac].xcdw008 IS NOT NULL
               AND g_xcdw4_d[l_ac].xcdw009 IS NOT NULL
               AND g_xcdw4_d[l_ac].xcdw010 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xcdw4_d_t.* = g_xcdw4_d[l_ac].*  #BACKUP
               LET g_xcdw4_d_o.* = g_xcdw4_d[l_ac].*  #BACKUP
               CALL axct322_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct322_set_no_entry_b(l_cmd)
               OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                g_xcdw4_d_t.xcdw001
                                                ,g_xcdw4_d_t.xcdw002
                                                ,g_xcdw4_d_t.xcdw007
                                                ,g_xcdw4_d_t.xcdw008
                                                ,g_xcdw4_d_t.xcdw009
                                                ,g_xcdw4_d_t.xcdw010
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct322_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'               
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            IF l_cmd='u' THEN
               
               
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '1'
                                                ,g_xcdw4_d_t.xcdw002
                                                ,g_xcdw4_d_t.xcdw007
                                                ,g_xcdw4_d_t.xcdw008
                                                ,g_xcdw4_d_t.xcdw009
                                                ,g_xcdw4_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa019 = 'Y' THEN                                 
                  OPEN axct322_bcl USING g_enterprise,g_xcdw_m.xcdwld,
                                                g_xcdw_m.xcdw003,
                                                g_xcdw_m.xcdw004,
                                                g_xcdw_m.xcdw005,
                                                g_xcdw_m.xcdw006,
 
                                                '3'
                                                ,g_xcdw4_d_t.xcdw002
                                                ,g_xcdw4_d_t.xcdw007
                                                ,g_xcdw4_d_t.xcdw008
                                                ,g_xcdw4_d_t.xcdw009
                                                ,g_xcdw4_d_t.xcdw010
 
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct322_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            #end add-point  
            
        
        
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前

               #end add-point
               
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   =  -263 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CANCEL DELETE
               END IF
               IF axct322_before_delete_4() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct322_bcl
               LET l_count = g_xcdw4_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 
               IF g_rec_b = 0 THEN
                  RETURN
               END IF   
               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xcdw4_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xcdw001
            #add-point:BEFORE FIELD xcdw001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw001
            
            #add-point:AFTER FIELD xcdw001
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw001
            #add-point:ON CHANGE xcdw001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw007
            #add-point:BEFORE FIELD xcdw007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw007
            
            #add-point:AFTER FIELD xcdw007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw007
            #add-point:ON CHANGE xcdw007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw008
            #add-point:BEFORE FIELD xcdw008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw008
            
            #add-point:AFTER FIELD xcdw008
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw008
            #add-point:ON CHANGE xcdw008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw009
            #add-point:BEFORE FIELD xcdw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw009
            
            #add-point:AFTER FIELD xcdw009
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw009
            #add-point:ON CHANGE xcdw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw002
            
            #add-point:AFTER FIELD xcdw002
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw002
            #add-point:BEFORE FIELD xcdw002

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw002
            #add-point:ON CHANGE xcdw002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdwsite
            #add-point:BEFORE FIELD xcdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdwsite
            
            #add-point:AFTER FIELD xcdwsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdwsite
            #add-point:ON CHANGE xcdwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw011
            
            #add-point:AFTER FIELD xcdw011


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw011
            #add-point:BEFORE FIELD xcdw011

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw011
            #add-point:ON CHANGE xcdw011

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw012
            #add-point:BEFORE FIELD xcdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw012
            
            #add-point:AFTER FIELD xcdw012

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw012
            #add-point:ON CHANGE xcdw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw010_4
            
            #add-point:AFTER FIELD xcdw010
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xcdw_m.xcdwld IS NOT NULL AND g_xcdw_m.xcdw003 IS NOT NULL AND g_xcdw_m.xcdw004 IS NOT NULL AND g_xcdw_m.xcdw005 IS NOT NULL AND g_xcdw_m.xcdw006 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw001 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw002 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw007 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw008 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw009 IS NOT NULL AND g_xcdw4_d[g_detail_idx].xcdw010 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xcdw_m.xcdwld != g_xcdwld_t OR g_xcdw_m.xcdw003 != g_xcdw003_t OR g_xcdw_m.xcdw004 != g_xcdw004_t OR g_xcdw_m.xcdw005 != g_xcdw005_t OR g_xcdw_m.xcdw006 != g_xcdw006_t OR g_xcdw4_d[g_detail_idx].xcdw001 != g_xcdw4_d_t.xcdw001 OR g_xcdw4_d[g_detail_idx].xcdw002 != g_xcdw4_d_t.xcdw002 OR g_xcdw4_d[g_detail_idx].xcdw007 != g_xcdw4_d_t.xcdw007 OR g_xcdw4_d[g_detail_idx].xcdw008 != g_xcdw4_d_t.xcdw008 OR g_xcdw4_d[g_detail_idx].xcdw009 != g_xcdw4_d_t.xcdw009 OR g_xcdw4_d[g_detail_idx].xcdw010 != g_xcdw4_d_t.xcdw010)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcdw_t WHERE "||"xcdwent = '" ||g_enterprise|| "' AND "||"xcdwld = '"||g_xcdw_m.xcdwld ||"' AND "|| "xcdw003 = '"||g_xcdw_m.xcdw003 ||"' AND "|| "xcdw004 = '"||g_xcdw_m.xcdw004 ||"' AND "|| "xcdw005 = '"||g_xcdw_m.xcdw005 ||"' AND "|| "xcdw006 = '"||g_xcdw_m.xcdw006 ||"' AND "|| "xcdw001 = '"||g_xcdw4_d[g_detail_idx].xcdw001 ||"' AND "|| "xcdw002 = '"||g_xcdw4_d[g_detail_idx].xcdw002 ||"' AND "|| "xcdw007 = '"||g_xcdw4_d[g_detail_idx].xcdw007 ||"' AND "|| "xcdw008 = '"||g_xcdw4_d[g_detail_idx].xcdw008 ||"' AND "|| "xcdw009 = '"||g_xcdw4_d[g_detail_idx].xcdw009 ||"' AND "|| "xcdw010 = '"||g_xcdw4_d[g_detail_idx].xcdw010 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_xcdw4_d[l_ac].xcdw010) THEN 
#此段落由子樣板a19產生
               #校驗代值
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xcdw4_d[l_ac].xcdw010
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00056:sub-01302|axci111|",cl_get_progname("axci111",g_lang,"2"),"|:EXEPROGaxci111"
               #160318-00025#12--add--end
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_xcau001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
#                  NEXT FIELD xcdw202_4
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            
            ELSE 
               NEXT FIELD CURRENT
            END IF 
      CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010)
            RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
       DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
       
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw010_4
            #add-point:BEFORE FIELD xcdw010

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw010
            #add-point:ON CHANGE xcdw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw016
            
            #add-point:AFTER FIELD xcdw016


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw016
            #add-point:BEFORE FIELD xcdw016

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw016
            #add-point:ON CHANGE xcdw016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw017
            
            #add-point:AFTER FIELD xcdw017


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw017
            #add-point:BEFORE FIELD xcdw017

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw017
            #add-point:ON CHANGE xcdw017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw018
            #add-point:BEFORE FIELD xcdw018

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw018
            
            #add-point:AFTER FIELD xcdw018

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw018
            #add-point:ON CHANGE xcdw018

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw020
            #add-point:BEFORE FIELD xcdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw020
            
            #add-point:AFTER FIELD xcdw020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw020
            #add-point:ON CHANGE xcdw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw021
            
            #add-point:AFTER FIELD xcdw021


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw021
            #add-point:BEFORE FIELD xcdw021

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw021
            #add-point:ON CHANGE xcdw021

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw201
            #add-point:BEFORE FIELD xcdw201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw201_4
            
            #add-point:AFTER FIELD xcdw201
            SELECT xccw201 INTO g_xcdw3_d[l_ac].xcdw201 FROM xccw_t 
         WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
           AND xccw001 = '3' AND xccw002 = g_xcdw4_d[l_ac].xcdw002
           AND xccw003 = g_xcdw_m.xcdw003 AND xccw004 = g_xcdw_m.xcdw004
           AND xccw005 = g_xcdw_m.xcdw005 AND xccw006 = g_xcdw_m.xcdw006
           AND xccw007 = g_xcdw4_d[l_ac].xcdw007 AND xccw008 = g_xcdw4_d[l_ac].xcdw008
           AND xccw009 = g_xcdw4_d[l_ac].xcdw009
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw201
            #add-point:ON CHANGE xcdw201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcdw202_4
            #add-point:BEFORE FIELD xcdw202
            IF cl_null(g_xcdw4_d[l_ac].xcdw010) THEN
               NEXT FIELD xcdw010_4
            END IF
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcdw202_4
            
            #add-point:AFTER FIELD xcdw202
            CALL s_transaction_begin()  #140909
            CALL s_curr_round('',g_glaa020,g_xcdw4_d[l_ac].xcdw202,2) RETURNING  g_xcdw4_d[l_ac].xcdw202
               #end add-point
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021, 
                   xcdw201,xcdw202,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw4_d[l_ac].xcdw001,g_xcdw4_d[l_ac].xcdw007,g_xcdw4_d[l_ac].xcdw008, 
                   g_xcdw4_d[l_ac].xcdw009,g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdwsite,g_xcdw4_d[l_ac].xcdw011, 
                   g_xcdw4_d[l_ac].xcdw012,g_xcdw4_d[l_ac].xcdw010,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017, 
                   g_xcdw4_d[l_ac].xcdw018,g_xcdw4_d[l_ac].xcdw020,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw201, 
                   g_xcdw4_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw4_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw4_d_t.xcdw002  
                 AND xcdw007 = g_xcdw4_d_t.xcdw007  
                 AND xcdw008 = g_xcdw4_d_t.xcdw008  
                 AND xcdw009 = g_xcdw4_d_t.xcdw009  
                 AND xcdw010 = g_xcdw4_d_t.xcdw010  
 
                 
               #add-point:單身修改中
               
                  UPDATE xcdw_t SET xcdw010 = 
                   g_xcdw4_d[l_ac].xcdw010                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006                   
                     
                     AND xcdw002 = g_xcdw4_d_t.xcdw002  
                     AND xcdw007 = g_xcdw4_d_t.xcdw007  
                     AND xcdw008 = g_xcdw4_d_t.xcdw008  
                     AND xcdw009 = g_xcdw4_d_t.xcdw009  
                     AND xcdw010 = g_xcdw4_d_t.xcdw010  
               
                CALL s_transaction_end('Y','0') #140909 
               DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw001,g_xcdw4_d[l_ac].xcdw007,g_xcdw4_d[l_ac].xcdw008,g_xcdw4_d[l_ac].xcdw009,
                                g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdwsite,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw012,
                                g_xcdw4_d[l_ac].xcdw010,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw018,
                                g_xcdw4_d[l_ac].xcdw201,g_xcdw4_d[l_ac].xcdw202,g_xcdw4_d[l_ac].xcdw020,g_xcdw4_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010)
                     RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
               DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,
                            g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcdw202_4
            #add-point:ON CHANGE xcdw202

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xcdw001
         ON ACTION controlp INFIELD xcdw001
            #add-point:ON ACTION controlp INFIELD xcdw001

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw007
         ON ACTION controlp INFIELD xcdw007
            #add-point:ON ACTION controlp INFIELD xcdw007

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw008
         ON ACTION controlp INFIELD xcdw008
            #add-point:ON ACTION controlp INFIELD xcdw008

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw009
         ON ACTION controlp INFIELD xcdw009
            #add-point:ON ACTION controlp INFIELD xcdw009

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw002
         ON ACTION controlp INFIELD xcdw002
            #add-point:ON ACTION controlp INFIELD xcdw002

            #END add-point
 
         #Ctrlp:input.c.page1.xcdwsite
         ON ACTION controlp INFIELD xcdwsite
            #add-point:ON ACTION controlp INFIELD xcdwsite

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw011
         ON ACTION controlp INFIELD xcdw011
            #add-point:ON ACTION controlp INFIELD xcdw011

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw012
         ON ACTION controlp INFIELD xcdw012
            #add-point:ON ACTION controlp INFIELD xcdw012

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw010
         ON ACTION controlp INFIELD xcdw010_4
            #add-point:ON ACTION controlp INFIELD xcdw010
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw4_d[l_ac].xcdw010             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_xcau001()                                #呼叫開窗

            LET g_xcdw4_d[l_ac].xcdw010 = g_qryparam.return1              

            DISPLAY g_xcdw4_d[l_ac].xcdw010 TO xcdw010_4              #
            CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010)
            RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
            NEXT FIELD xcdw010_4                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcdw016
         ON ACTION controlp INFIELD xcdw016
            #add-point:ON ACTION controlp INFIELD xcdw016

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw017
         ON ACTION controlp INFIELD xcdw017
            #add-point:ON ACTION controlp INFIELD xcdw017

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw018
         ON ACTION controlp INFIELD xcdw018
            #add-point:ON ACTION controlp INFIELD xcdw018
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcdw4_d[l_ac].xcdw018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_inaj010()                                #呼叫開窗

            LET g_xcdw4_d[l_ac].xcdw018 = g_qryparam.return1              

            DISPLAY g_xcdw4_d[l_ac].xcdw018 TO xcdw018              #

            NEXT FIELD xcdw018                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.page1.xcdw020
         ON ACTION controlp INFIELD xcdw020
            #add-point:ON ACTION controlp INFIELD xcdw020

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw021
         ON ACTION controlp INFIELD xcdw021
            #add-point:ON ACTION controlp INFIELD xcdw021

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw201
         ON ACTION controlp INFIELD xcdw201
            #add-point:ON ACTION controlp INFIELD xcdw201

            #END add-point
 
         #Ctrlp:input.c.page1.xcdw202
         ON ACTION controlp INFIELD xcdw202
            #add-point:ON ACTION controlp INFIELD xcdw202

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xcdw4_d[l_ac].* = g_xcdw4_d_t.*
               CLOSE axct322_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xcdw4_d[l_ac].xcdw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xcdw4_d[l_ac].* = g_xcdw4_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               CALL s_transaction_begin()  #140909
               IF cl_null(g_xcdw4_d[l_ac].xcdw202) THEN LET g_xcdw4_d[l_ac].xcdw202 = 0 END IF
               CALL s_curr_round('',g_glaa020,g_xcdw4_d[l_ac].xcdw202,2) RETURNING  g_xcdw4_d[l_ac].xcdw202
               #end add-point
         
               UPDATE xcdw_t SET (xcdwld,xcdw003,xcdw004,xcdw005,xcdw006,xcdw001,xcdw007,xcdw008,xcdw009, 
                   xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021, 
                   xcdw201,xcdw202,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028, 
                   xcdw029,xcdw030,xcdw031,xcdw034) = (g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004, 
                   g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,g_xcdw4_d[l_ac].xcdw001,g_xcdw4_d[l_ac].xcdw007,g_xcdw4_d[l_ac].xcdw008, 
                   g_xcdw4_d[l_ac].xcdw009,g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdwsite,g_xcdw4_d[l_ac].xcdw011, 
                   g_xcdw4_d[l_ac].xcdw012,g_xcdw4_d[l_ac].xcdw010,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017, 
                   g_xcdw4_d[l_ac].xcdw018,g_xcdw4_d[l_ac].xcdw020,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw201, 
                   g_xcdw4_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw022, 
                   g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026, 
                   g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030, 
                   g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034)
                WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                 AND xcdw003 = g_xcdw_m.xcdw003 
                 AND xcdw004 = g_xcdw_m.xcdw004 
                 AND xcdw005 = g_xcdw_m.xcdw005 
                 AND xcdw006 = g_xcdw_m.xcdw006 
 
                 AND xcdw001 = g_xcdw4_d_t.xcdw001 #項次   
                 AND xcdw002 = g_xcdw4_d_t.xcdw002  
                 AND xcdw007 = g_xcdw4_d_t.xcdw007  
                 AND xcdw008 = g_xcdw4_d_t.xcdw008  
                 AND xcdw009 = g_xcdw4_d_t.xcdw009  
                 AND xcdw010 = g_xcdw4_d_t.xcdw010  
 
                 
               #add-point:單身修改中
               
                  UPDATE xcdw_t SET xcdw010 = 
                   g_xcdw4_d[l_ac].xcdw010                                    
                   WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld 
                     AND xcdw003 = g_xcdw_m.xcdw003 
                     AND xcdw004 = g_xcdw_m.xcdw004 
                     AND xcdw005 = g_xcdw_m.xcdw005 
                     AND xcdw006 = g_xcdw_m.xcdw006                   
                     
                     AND xcdw002 = g_xcdw4_d_t.xcdw002  
                     AND xcdw007 = g_xcdw4_d_t.xcdw007  
                     AND xcdw008 = g_xcdw4_d_t.xcdw008  
                     AND xcdw009 = g_xcdw4_d_t.xcdw009  
                     AND xcdw010 = g_xcdw4_d_t.xcdw010  
               
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xcdw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xcdw_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xcdw_m.xcdwld
               LET gs_keys_bak[1] = g_xcdwld_t
               LET gs_keys[2] = g_xcdw_m.xcdw003
               LET gs_keys_bak[2] = g_xcdw003_t
               LET gs_keys[3] = g_xcdw_m.xcdw004
               LET gs_keys_bak[3] = g_xcdw004_t
               LET gs_keys[4] = g_xcdw_m.xcdw005
               LET gs_keys_bak[4] = g_xcdw005_t
               LET gs_keys[5] = g_xcdw_m.xcdw006
               LET gs_keys_bak[5] = g_xcdw006_t
               LET gs_keys[6] = g_xcdw4_d[g_detail_idx].xcdw001
               LET gs_keys_bak[6] = g_xcdw4_d_t.xcdw001
               LET gs_keys[7] = g_xcdw4_d[g_detail_idx].xcdw002
               LET gs_keys_bak[7] = g_xcdw4_d_t.xcdw002
               LET gs_keys[8] = g_xcdw4_d[g_detail_idx].xcdw007
               LET gs_keys_bak[8] = g_xcdw4_d_t.xcdw007
               LET gs_keys[9] = g_xcdw4_d[g_detail_idx].xcdw008
               LET gs_keys_bak[9] = g_xcdw4_d_t.xcdw008
               LET gs_keys[10] = g_xcdw4_d[g_detail_idx].xcdw009
               LET gs_keys_bak[10] = g_xcdw4_d_t.xcdw009
               LET gs_keys[11] = g_xcdw4_d[g_detail_idx].xcdw010
               LET gs_keys_bak[11] = g_xcdw4_d_t.xcdw010
               CALL axct322_update_b('xcdw_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw4_d_t)
                     LET g_log2 = util.JSON.stringify(g_xcdw_m),util.JSON.stringify(g_xcdw4_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
                
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909 
               DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw001,g_xcdw4_d[l_ac].xcdw007,g_xcdw4_d[l_ac].xcdw008,g_xcdw4_d[l_ac].xcdw009,
                                g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdwsite,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw012,
                                g_xcdw4_d[l_ac].xcdw010,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw018,
                                g_xcdw4_d[l_ac].xcdw201,g_xcdw4_d[l_ac].xcdw202,g_xcdw4_d[l_ac].xcdw020,g_xcdw4_d[l_ac].xcdw021
               CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010)
                     RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
               DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,
                            g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc  
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xcdw4_d.getLength() = 0 THEN
               NEXT FIELD xcdw001
            END IF
            #add-point:input段after input 

            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xcdw4_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xcdw4_d.getLength()+1
            
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog name="input.before_dialog"
         IF p_cmd = 'a' THEN
            NEXT FIELD xcdwld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcdw001
               WHEN "s_detail2"
                  NEXT FIELD xcdw001_2
               WHEN "s_detail3"
                  NEXT FIELD xcdw001_3
               WHEN "s_detail4"
                  NEXT FIELD xcdw001_4
 
            END CASE
         END IF
         #end add-point 
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)      
         CALL DIALOG.setCurrentRow("s_detail2",g_detail_idx)
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xcdwld
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xcdw001
               WHEN "s_detail2"
                  NEXT FIELD xcdw001_2
 
            END CASE
         END IF
   
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
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit        #toolbar 離開
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
   
   #將畫面指標同步到當下指定的位置上
   CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
 
 
   
   #add-point:input段after_input name="input.after_input"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct322_show()
   #add-point:show段define name="show.define_customerization"
   
   #end add-point
   #add-point:show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="show.before"
   CALL axct322_page_visible()
   CALL axct322_get_date()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct322_b_fill(g_wc2) #第一階單身填充
      CALL axct322_b_fill2('0')  #第二階單身填充
   END IF
   
   
 
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL axct322_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   DISPLAY BY NAME g_xcdw_m.xcdwld,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdwcomp_desc,g_xcdw_m.xcdw003, 
       g_xcdw_m.xcdw003_desc,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013,g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcat003
 
   CALL axct322_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後 name="show.after"
   
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct322_ref_show()
   #add-point:ref_show段define name="ref_show.define_customerization"
   
   #end add-point 
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ref_show.define"
   DEFINE l_xcdw016_desc LIKE type_t.chr1000
   DEFINE l_xcdw017_desc LIKE type_t.chr1000
   #end add-point
   
   #add-point:Function前置處理  name="ref_show.pre_function"
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference name="ref_show.head.reference"
   CALL axct322_ref()
   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xcdw_d.getLength()
      #add-point:ref_show段d_reference name="ref_show.body.reference"
      CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xcdw2_d.getLength()
      #add-point:ref_show段d2_reference name="ref_show.body2.reference"
      CALL axct322_detail_ref(g_xcdw2_d[l_ac].xcdw002,g_xcdw2_d[l_ac].xcdw011,'','',g_xcdw2_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw010)
            RETURNING g_xcdw2_d[l_ac].xcdw002_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc_desc,l_xcdw016_desc,l_xcdw017_desc,g_xcdw2_d[l_ac].xcdw021_2_desc,g_xcdw2_d[l_ac].xcdw010_2_desc
            DISPLAY BY NAME g_xcdw2_d[l_ac].xcdw002_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc_desc,g_xcdw2_d[l_ac].xcdw021_2_desc,g_xcdw2_d[l_ac].xcdw010_2_desc 
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂 name="ref_show.other_reference"
   FOR l_ac = 1 TO g_xcdw3_d.getLength()
      #add-point:ref_show段d_reference
      CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
            RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xcdw4_d.getLength()
      #add-point:ref_show段d_reference
       CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010) 
            RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
       DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
      #end add-point
   END FOR
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct322_reproduce()
   #add-point:reproduce段define name="reproduce.define_customerization"
   
   #end add-point
   DEFINE l_newno     LIKE xcdw_t.xcdwld 
   DEFINE l_oldno     LIKE xcdw_t.xcdwld 
   DEFINE l_newno02     LIKE xcdw_t.xcdw003 
   DEFINE l_oldno02     LIKE xcdw_t.xcdw003 
   DEFINE l_newno03     LIKE xcdw_t.xcdw004 
   DEFINE l_oldno03     LIKE xcdw_t.xcdw004 
   DEFINE l_newno04     LIKE xcdw_t.xcdw005 
   DEFINE l_oldno04     LIKE xcdw_t.xcdw005 
   DEFINE l_newno05     LIKE xcdw_t.xcdw006 
   DEFINE l_oldno05     LIKE xcdw_t.xcdw006 
 
   DEFINE l_master    RECORD LIKE xcdw_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE xcdw_t.* #此變數樣板目前無使用
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="reproduce.pre_function"
   
   #end add-point
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xcdw_m.xcdwld IS NULL
      OR g_xcdw_m.xcdw003 IS NULL
      OR g_xcdw_m.xcdw004 IS NULL
      OR g_xcdw_m.xcdw005 IS NULL
      OR g_xcdw_m.xcdw006 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   LET g_xcdwld_t = g_xcdw_m.xcdwld
   LET g_xcdw003_t = g_xcdw_m.xcdw003
   LET g_xcdw004_t = g_xcdw_m.xcdw004
   LET g_xcdw005_t = g_xcdw_m.xcdw005
   LET g_xcdw006_t = g_xcdw_m.xcdw006
 
   
   LET g_xcdw_m.xcdwld = ""
   LET g_xcdw_m.xcdw003 = ""
   LET g_xcdw_m.xcdw004 = ""
   LET g_xcdw_m.xcdw005 = ""
   LET g_xcdw_m.xcdw006 = ""
 
   LET g_master_insert = FALSE
   CALL axct322_set_entry('a')
   CALL axct322_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #清空key欄位的desc
      LET g_xcdw_m.xcdwld_desc = ''
   DISPLAY BY NAME g_xcdw_m.xcdwld_desc
   LET g_xcdw_m.xcdw003_desc = ''
   DISPLAY BY NAME g_xcdw_m.xcdw003_desc
 
   
   CALL axct322_input("r")
    
   IF INT_FLAG AND NOT g_master_insert THEN
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xcdw_m.* TO NULL
      INITIALIZE g_xcdw_d TO NULL
      INITIALIZE g_xcdw2_d TO NULL
 
      CALL axct322_show()
      LET INT_FLAG = 0
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN 
   END IF
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("modify,modify_detail,delete,reproduce", TRUE)
   CALL axct322_set_act_visible()
   CALL axct322_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_xcdwld_t = g_xcdw_m.xcdwld
   LET g_xcdw003_t = g_xcdw_m.xcdw003
   LET g_xcdw004_t = g_xcdw_m.xcdw004
   LET g_xcdw005_t = g_xcdw_m.xcdw005
   LET g_xcdw006_t = g_xcdw_m.xcdw006
 
   
   #組合新增資料的條件
   LET g_add_browse = " xcdwent = " ||g_enterprise|| " AND",
                      " xcdwld = '", g_xcdw_m.xcdwld, "' "
                      ," AND xcdw003 = '", g_xcdw_m.xcdw003, "' "
                      ," AND xcdw004 = '", g_xcdw_m.xcdw004, "' "
                      ," AND xcdw005 = '", g_xcdw_m.xcdw005, "' "
                      ," AND xcdw006 = '", g_xcdw_m.xcdw006, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL axct322_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   LET g_curr_diag = ui.DIALOG.getCurrent()
   CALL axct322_idx_chk()
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   #功能已完成,通報訊息中心
   CALL axct322_msgcentre_notify('reproduce')
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct322_detail_reproduce()
   #add-point:delete段define name="detail_reproduce.define_customerization"
   
   #end add-point 
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xcdw_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct322_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM xcdw_t
    WHERE xcdwent = g_enterprise AND xcdwld = g_xcdwld_t
    AND xcdw003 = g_xcdw003_t
    AND xcdw004 = g_xcdw004_t
    AND xcdw005 = g_xcdw005_t
    AND xcdw006 = g_xcdw006_t
 
       INTO TEMP axct322_detail
   
   #將key修正為調整後   
   UPDATE axct322_detail 
      #更新key欄位
      SET xcdwld = g_xcdw_m.xcdwld
          , xcdw003 = g_xcdw_m.xcdw003
          , xcdw004 = g_xcdw_m.xcdw004
          , xcdw005 = g_xcdw_m.xcdw005
          , xcdw006 = g_xcdw_m.xcdw006
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xcdw_t SELECT * FROM axct322_detail
   
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
   DROP TABLE axct322_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xcdwld_t = g_xcdw_m.xcdwld
   LET g_xcdw003_t = g_xcdw_m.xcdw003
   LET g_xcdw004_t = g_xcdw_m.xcdw004
   LET g_xcdw005_t = g_xcdw_m.xcdw005
   LET g_xcdw006_t = g_xcdw_m.xcdw006
 
   
   DROP TABLE axct322_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct322_delete()
   #add-point:delete段define name="delete.define_customerization"
   
   #end add-point
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_xcdw_m.xcdwld IS NULL
   OR g_xcdw_m.xcdw003 IS NULL
   OR g_xcdw_m.xcdw004 IS NULL
   OR g_xcdw_m.xcdw005 IS NULL
   OR g_xcdw_m.xcdw006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   
 
   OPEN axct322_cl USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006
   IF SQLCA.SQLCODE THEN   #(ver:49)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct322_cl:" 
      LET g_errparam.code   = SQLCA.SQLCODE   #(ver:49)
      LET g_errparam.popup  = TRUE 
      CLOSE axct322_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE axct322_master_referesh USING g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
       g_xcdw_m.xcdw006 INTO g_xcdw_m.xcdwld,g_xcdw_m.xcdwcomp,g_xcdw_m.xcdw003,g_xcdw_m.xcdw006,g_xcdw_m.xcdw013, 
       g_xcdw_m.xcdw014,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdwld_desc,g_xcdw_m.xcdwcomp_desc, 
       g_xcdw_m.xcdw003_desc
   
   #遮罩相關處理
   LET g_xcdw_m_mask_o.* =  g_xcdw_m.*
   CALL axct322_xcdw_t_mask()
   LET g_xcdw_m_mask_n.* =  g_xcdw_m.*
   
   CALL axct322_show()
 
   #單頭多語言資料備份
   
   
   IF cl_ask_del_master() THEN              #確認一下
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL axct322_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
 
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM xcdw_t WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
                                                               AND xcdw003 = g_xcdw_m.xcdw003
                                                               AND xcdw004 = g_xcdw_m.xcdw004
                                                               AND xcdw005 = g_xcdw_m.xcdw005
                                                               AND xcdw006 = g_xcdw_m.xcdw006
 
                                                               
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
      END IF
 
      
  
      #add-point:單身刪除後  name="delete.body.a_delete"
      
      #end add-point
      
 
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      #頭先不紀錄
      #IF NOT cl_log_modified_record('','') THEN 
      #   CLOSE axct322_cl
      #   CALL s_transaction_end('N','0')
      #   RETURN 
      #END IF
      
      CLEAR FORM
      CALL g_xcdw_d.clear() 
      CALL g_xcdw2_d.clear()       
 
     
      CALL axct322_ui_browser_refresh()  
      #CALL axct322_ui_headershow()  
      #CALL axct322_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct322_fetch('P')
      ELSE
         #LET g_wc = " 1=1"
         #LET g_wc2 = " 1=1"
         #CALL axct322_browser_fill("F")
         CLEAR FORM
      END IF
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')   
   END IF
 
   CLOSE axct322_cl
 
   #功能已完成,通報訊息中心
   CALL axct322_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="axct322.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct322_b_fill(p_wc2)
   #add-point:b_fill段define name="b_fill.define_customerization"
   
   #end add-point
   DEFINE p_wc2      STRING
   #add-point:b_fill段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_xcdw016_desc LIKE type_t.chr1000
   DEFINE l_xcdw017_desc LIKE type_t.chr1000
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #先清空單身變數內容
   CALL g_xcdw_d.clear()
   CALL g_xcdw2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
   
   LET g_sql = "SELECT  DISTINCT xcdw001,xcdw007,xcdw008,xcdw009,xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010, 
       xcdw016,xcdw017,xcdw018,xcdw201,xcdw202,xcdw020,xcdw021,xcdw001,xcdw007,xcdw008,xcdw009,xcdw002, 
       xcdwsite,xcdw010,xcdw011,xcdw012,xcdw032,xcdw033,xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027, 
       xcdw028,xcdw029,xcdw030,xcdw031,xcdw034,xcdw201,xcdw202,xcdw021 FROM xcdw_t",   
               "",
               
               
               " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND xcdw006=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdw_t")
   END IF
   
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql=g_sql CLIPPED," AND xcdw001 = '1' "   
   LET g_sql = g_sql CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"
   
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct322_fill_chk(1) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = g_sql, " ORDER BY xcdw_t.xcdw001,xcdw_t.xcdw002,xcdw_t.xcdw007,xcdw_t.xcdw008,xcdw_t.xcdw009,xcdw_t.xcdw010"
         #add-point:b_fill段fill_before name="b_fill.fill_before"
         
         #end add-point
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE axct322_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR axct322_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006   #(ver:49)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005, 
          g_xcdw_m.xcdw006 INTO g_xcdw_d[l_ac].xcdw001,g_xcdw_d[l_ac].xcdw007,g_xcdw_d[l_ac].xcdw008, 
          g_xcdw_d[l_ac].xcdw009,g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011, 
          g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw010,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017, 
          g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw201,g_xcdw_d[l_ac].xcdw202,g_xcdw_d[l_ac].xcdw020, 
          g_xcdw_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw001,g_xcdw2_d[l_ac].xcdw007,g_xcdw2_d[l_ac].xcdw008, 
          g_xcdw2_d[l_ac].xcdw009,g_xcdw2_d[l_ac].xcdw002,g_xcdw2_d[l_ac].xcdwsite,g_xcdw2_d[l_ac].xcdw010, 
          g_xcdw2_d[l_ac].xcdw011,g_xcdw2_d[l_ac].xcdw012,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033, 
          g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025, 
          g_xcdw2_d[l_ac].xcdw026,g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029, 
          g_xcdw2_d[l_ac].xcdw030,g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw034,g_xcdw2_d[l_ac].xcdw201, 
          g_xcdw2_d[l_ac].xcdw202,g_xcdw2_d[l_ac].xcdw021   #(ver:49)
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充 name="b_fill.fill"
         CALL axct322_detail_ref(g_xcdw_d[l_ac].xcdw002,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw010)
            RETURNING g_xcdw_d[l_ac].xcdw002_desc,g_xcdw_d[l_ac].xcdw011_desc,g_xcdw_d[l_ac].xcdw011_desc_desc,g_xcdw_d[l_ac].xcdw016_desc,g_xcdw_d[l_ac].xcdw017_desc,g_xcdw_d[l_ac].xcdw021_desc,g_xcdw_d[l_ac].xcdw010_desc
         CALL axct322_detail_ref(g_xcdw2_d[l_ac].xcdw002,g_xcdw2_d[l_ac].xcdw011,'','',g_xcdw2_d[l_ac].xcdw021,g_xcdw2_d[l_ac].xcdw010)
            RETURNING g_xcdw2_d[l_ac].xcdw002_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc,g_xcdw2_d[l_ac].xcdw011_2_desc_desc,l_xcdw016_desc,l_xcdw017_desc,g_xcdw2_d[l_ac].xcdw021_2_desc,g_xcdw2_d[l_ac].xcdw010_2_desc
            
         
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
 
        
         #add-point:單身資料抓取 name="bfill.foreach"
         
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
 
            CALL g_xcdw_d.deleteElement(g_xcdw_d.getLength())
      CALL g_xcdw2_d.deleteElement(g_xcdw2_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more name="b_fill.more"
   
   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   #遮罩相關處理
   FOR l_ac = 1 TO g_xcdw_d.getLength()
      LET g_xcdw_d_mask_o[l_ac].* =  g_xcdw_d[l_ac].*
      CALL axct322_xcdw_t_mask()
      LET g_xcdw_d_mask_n[l_ac].* =  g_xcdw_d[l_ac].*
   END FOR
   
   LET g_xcdw2_d_mask_o.* =  g_xcdw2_d.*
   FOR l_ac = 1 TO g_xcdw2_d.getLength()
      LET g_xcdw2_d_mask_o[l_ac].* =  g_xcdw2_d[l_ac].*
      CALL axct322_xcdw_t_mask()
      LET g_xcdw2_d_mask_n[l_ac].* =  g_xcdw2_d[l_ac].*
   END FOR
 
 
   FREE axct322_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION axct322_idx_chk()
   #add-point:idx_chk段define name="idx_chk.define_customerization"
   
   #end add-point
   #add-point:idx_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   #判定目前選擇的頁面
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      #確保當下指標的位置未超過上限
      IF g_detail_idx > g_xcdw_d.getLength() THEN
         LET g_detail_idx = g_xcdw_d.getLength()
      END IF
      #確保資料位置不小於1
      IF g_detail_idx = 0 AND g_xcdw_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      #將筆數資料顯示到畫面上
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcdw_d.getLength() TO FORMONLY.cnt
      #將位置顯示到正確筆數上
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)
   END IF
    
   #同第一個page的做法進行其他頁面的處理
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_xcdw2_d.getLength() THEN
         LET g_detail_idx = g_xcdw2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_xcdw2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_xcdw2_d.getLength() TO FORMONLY.cnt
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct322_b_fill2(pi_idx)
   #add-point:b_fill2段define name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx          LIKE type_t.num10
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
 
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_xcdw_d.getLength() <= 0 THEN
      RETURN
   END IF
   
 
      
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
   CALL axct322_b_fill_3()
   CALL axct322_b_fill_4()
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct322_before_delete()
   #add-point:before_delete段define name="before_delete.define_customerization"
   
   #end add-point 
   #add-point:before_delete段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="before_delete.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="delete.body.b_single_delete"
   
   #end add-point
   
   DELETE FROM xcdw_t
    WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                              xcdw003 = g_xcdw_m.xcdw003 AND
                              xcdw004 = g_xcdw_m.xcdw004 AND
                              xcdw005 = g_xcdw_m.xcdw005 AND
                              xcdw006 = g_xcdw_m.xcdw006 AND
 
          xcdw001 = g_xcdw_d_t.xcdw001
      AND xcdw002 = g_xcdw_d_t.xcdw002
      AND xcdw007 = g_xcdw_d_t.xcdw007
      AND xcdw008 = g_xcdw_d_t.xcdw008
      AND xcdw009 = g_xcdw_d_t.xcdw009
      AND xcdw010 = g_xcdw_d_t.xcdw010
 
      
   #add-point:單筆刪除中 name="delete.body.m_single_delete"
   IF g_glaa015 = 'Y' OR g_glaa019 = 'Y' THEN
      DELETE FROM xcdw_t
       WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                                 xcdw003 = g_xcdw_m.xcdw003 AND
                                 xcdw004 = g_xcdw_m.xcdw004 AND
                                 xcdw005 = g_xcdw_m.xcdw005 AND
                                 xcdw006 = g_xcdw_m.xcdw006 AND
       
       
             xcdw002 = g_xcdw_d_t.xcdw002
         AND xcdw007 = g_xcdw_d_t.xcdw007
         AND xcdw008 = g_xcdw_d_t.xcdw008
         AND xcdw009 = g_xcdw_d_t.xcdw009
         AND xcdw010 = g_xcdw_d_t.xcdw010
   END IF
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdw_t:",SQLERRMESSAGE 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後 name="delete.body.a_single_delete"
   
   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
    
END FUNCTION
 
{</section>}
 
{<section id="axct322.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct322_delete_b(ps_table,ps_keys_bak,ps_page)
   #add-point:delete_b段define name="delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="delete_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct322_insert_b(ps_table,ps_keys,ps_page)
   #add-point:insert_b段define name="insert_b.define_customerization"
   
   #end add-point
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="insert_b.pre_function"
   
   #end add-point
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct322_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   #add-point:update_b段define name="update_b.define_customerization"
   
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
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="update_b.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="update_b.pre_function"
   
   #end add-point
   
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
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正其他單身key欄位
PRIVATE FUNCTION axct322_key_update_b(ps_keys_bak)
   #add-point:update_b段define name="key_update_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   #add-point:update_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_update_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_update_b.pre_function"
   
   #end add-point
   
   #判斷key是否有改變, 若無改變則返回
   IF g_xcdw_d[l_ac].xcdw001 = g_xcdw_d_t.xcdw001 
      AND g_xcdw_d[l_ac].xcdw002 = g_xcdw_d_t.xcdw002 
      AND g_xcdw_d[l_ac].xcdw007 = g_xcdw_d_t.xcdw007 
      AND g_xcdw_d[l_ac].xcdw008 = g_xcdw_d_t.xcdw008 
      AND g_xcdw_d[l_ac].xcdw009 = g_xcdw_d_t.xcdw009 
      AND g_xcdw_d[l_ac].xcdw010 = g_xcdw_d_t.xcdw010 
 
      THEN
      RETURN
   END IF
    
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION axct322_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table    STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct322_lock_b(ps_table,ps_page)
   #add-point:lock_b段define name="lock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="lock_b.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="lock_b.pre_function"
   
   #end add-point
   
   #先刷新資料
   #CALL axct322_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct322_unlock_b(ps_table,ps_page)
   #add-point:unlock_b段define name="unlock_b.define_customerization"
   
   #end add-point
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="unlock_b.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="unlock_b.pre_function"
   
   #end add-point
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct322_set_entry(p_cmd)
   #add-point:set_entry段define name="set_entry.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xcdwld,xcdw003,xcdw004,xcdw005,xcdw006",TRUE)
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
 
{<section id="axct322.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct322_set_no_entry(p_cmd)
   #add-point:set_no_entry段define name="set_no_entry.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcdwld,xcdw003,xcdw004,xcdw005,xcdw006",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct322_set_entry_b(p_cmd)
   #add-point:set_entry_b段define name="set_entry_b.define_customerization"
   
   #end add-point 
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry_b.define"
   
   #end add-point     
   
   #add-point:set_entry_b段 name="set_entry_b.set_entry_b"
IF p_cmd = 'a' THEN 
   CALL cl_set_comp_entry("xcdw001,xcdw002,xcdw007,xcdw008,xcdw009,xcdw010,xcdw202",TRUE)
#   CALL cl_set_comp_entry("xcdwsite,xcdw011,xcdw012,xcdw016,xcdw017,xcdw018",TRUE)
#   CALL cl_set_comp_entry("xcdw020,xcdw021,xcdw201",TRUE) 
END IF
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct322_set_no_entry_b(p_cmd)
   #add-point:set_no_entry_b段define name="set_no_entry_b.define_customerization"
   
   #end add-point
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry_b.define"
   
   #end add-point    
   
   #add-point:set_no_entry_b段 name="set_no_entry_b.set_no_entry_b段"
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xcdw001,xcdw002,xcdw007,xcdw008,xcdw009",FALSE)
   END IF
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION axct322_set_act_visible()
   #add-point:set_act_visible段define name="set_act_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point
   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION axct322_set_act_no_visible()
   #add-point:set_act_no_visible段define name="set_act_no_visible.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point
   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION axct322_set_act_visible_b()
   #add-point:set_act_visible_b段define name="set_act_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct322.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION axct322_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define name="set_act_no_visible_b.define_customerization"
   
   #end add-point
   #add-point:set_act_no_visible_b段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point
   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axct322.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct322_default_search()
   #add-point:default_search段define name="default_search.define_customerization"
   
   #end add-point    
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="default_search.pre_function"
   
   #end add-point
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point  
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcdwld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdw003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdw004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdw005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcdw006 = '", g_argv[05], "' AND "
   END IF
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前 name="default_search.after"
   LET ls_wc =' '
   LET g_wc = ' '
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xcdw013 = '", g_argv[01], "' AND "
   END IF
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xcdwld = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xcdw003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xcdw004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xcdw005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xcdw006 = '", g_argv[06], "' AND "
   END IF
 
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=1"
      END IF
   END IF
   
   DISPLAY g_wc
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct322_fill_chk(ps_idx)
   #add-point:fill_chk段define name="fill_chk.define_customerization"
   
   #end add-point
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fill_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="fill_chk.pre_function"
   
   #end add-point
   
   #此funtion功能暫時停用(2015/1/12)
   #無論傳入值為何皆回傳true(代表要填充該單身)
   
   #add-point:fill_chk段other name="fill_chk.other"
   
   #end add-point
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct322.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct322_modify_detail_chk(ps_record)
   #add-point:modify_detail_chk段define name="modify_detail_chk.define_customerization"
   
   #end add-point
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify_detail_chk.define"
   
   #end add-point
   
   #add-point:Function前置處理  name="modify_detail_chk.before"
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xcdw001"
      WHEN "s_detail2"
         LET ls_return = "xcdw001_2"
 
      #add-point:modify_detail_chk段自訂page控制 name="modify_detail_chk.page_control"
      WHEN "s_detail3" 
         LET ls_return = "xcdw001_3"
      WHEN "s_detail4"
         LET ls_return = "xcdw001_4"
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前 name="modify_detail_chk.after"
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct322.mask_functions" >}
&include "erp/axc/axct322_mask.4gl"
 
{</section>}
 
{<section id="axct322.state_change" >}
    
 
{</section>}
 
{<section id="axct322.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION axct322_set_pk_array()
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
   LET g_pk_array[1].values = g_xcdw_m.xcdwld
   LET g_pk_array[1].column = 'xcdwld'
   LET g_pk_array[2].values = g_xcdw_m.xcdw003
   LET g_pk_array[2].column = 'xcdw003'
   LET g_pk_array[3].values = g_xcdw_m.xcdw004
   LET g_pk_array[3].column = 'xcdw004'
   LET g_pk_array[4].values = g_xcdw_m.xcdw005
   LET g_pk_array[4].column = 'xcdw005'
   LET g_pk_array[5].values = g_xcdw_m.xcdw006
   LET g_pk_array[5].column = 'xcdw006'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct322.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION axct322_msgcentre_notify(lc_state)
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
   CALL axct322_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_xcdw_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="axct322.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_b_fill_3()

   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   
   CALL g_xcdw3_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xcdw001,xcdw007,xcdw008,xcdw009,xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010, 
       xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,xcdw201,xcdw202 FROM xcdw_t",   
               "",
               
               
               " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND xcdw006=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdw_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql=g_sql CLIPPED," AND xcdw001 = '2' "
   LET g_sql = g_sql CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct322_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcdw_t.xcdw001,xcdw_t.xcdw002,xcdw_t.xcdw007,xcdw_t.xcdw008,xcdw_t.xcdw009,xcdw_t.xcdw010"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct322_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axct322_pb3
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006
                                               
      FOREACH b_fill_cs3 INTO g_xcdw3_d[l_ac].xcdw001,g_xcdw3_d[l_ac].xcdw007,g_xcdw3_d[l_ac].xcdw008,g_xcdw3_d[l_ac].xcdw009, 
          g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdwsite,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw012, 
          g_xcdw3_d[l_ac].xcdw010,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw018, 
          g_xcdw3_d[l_ac].xcdw020,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw201,g_xcdw3_d[l_ac].xcdw202 
          
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axct322_detail_ref(g_xcdw3_d[l_ac].xcdw002,g_xcdw3_d[l_ac].xcdw011,g_xcdw3_d[l_ac].xcdw016,g_xcdw3_d[l_ac].xcdw017,g_xcdw3_d[l_ac].xcdw021,g_xcdw3_d[l_ac].xcdw010)
            RETURNING g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
            DISPLAY BY NAME g_xcdw3_d[l_ac].xcdw002_desc,g_xcdw3_d[l_ac].xcdw011_desc,g_xcdw3_d[l_ac].xcdw011_desc_desc,g_xcdw3_d[l_ac].xcdw016_desc,g_xcdw3_d[l_ac].xcdw017_desc,
                            g_xcdw3_d[l_ac].xcdw021_desc,g_xcdw3_d[l_ac].xcdw010_desc
         
        
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
 
        
         #add-point:單身資料抓取

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
 
            CALL g_xcdw3_d.deleteElement(g_xcdw3_d.getLength())
      
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct322_pb3   
   

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_b_fill_4()

   #add-point:b_fill段define

   #end add-point     
 
   #先清空單身變數內容
   
   CALL g_xcdw4_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xcdw001,xcdw007,xcdw008,xcdw009,xcdw002,xcdwsite,xcdw011,xcdw012,xcdw010, 
       xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,xcdw201,xcdw202 FROM xcdw_t",   
               "",
               
               
               " WHERE xcdwent= ? AND xcdwld=? AND xcdw003=? AND xcdw004=? AND xcdw005=? AND xcdw006=?"  
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xcdw_t")
   END IF
   
   #add-point:b_fill段sql_after
   LET g_sql=g_sql CLIPPED," AND xcdw001 = '3' "
   LET g_sql = g_sql CLIPPED," AND xcdw013 = '",g_xcdw013_p,"'"
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct322_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xcdw_t.xcdw001,xcdw_t.xcdw002,xcdw_t.xcdw007,xcdw_t.xcdw008,xcdw_t.xcdw009,xcdw_t.xcdw010"
      
      #add-point:b_fill段fill_before
      
      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct322_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR axct322_pb4
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006
                                               
      FOREACH b_fill_cs4 INTO g_xcdw4_d[l_ac].xcdw001,g_xcdw4_d[l_ac].xcdw007,g_xcdw4_d[l_ac].xcdw008,g_xcdw4_d[l_ac].xcdw009, 
          g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdwsite,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw012, 
          g_xcdw4_d[l_ac].xcdw010,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw018, 
          g_xcdw4_d[l_ac].xcdw020,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw201,g_xcdw4_d[l_ac].xcdw202 
          
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
       CALL axct322_detail_ref(g_xcdw4_d[l_ac].xcdw002,g_xcdw4_d[l_ac].xcdw011,g_xcdw4_d[l_ac].xcdw016,g_xcdw4_d[l_ac].xcdw017,g_xcdw4_d[l_ac].xcdw021,g_xcdw4_d[l_ac].xcdw010)
            RETURNING g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
       DISPLAY BY NAME g_xcdw4_d[l_ac].xcdw002_desc,g_xcdw4_d[l_ac].xcdw011_desc,g_xcdw4_d[l_ac].xcdw011_desc_desc,g_xcdw4_d[l_ac].xcdw016_desc,g_xcdw4_d[l_ac].xcdw017_desc,g_xcdw4_d[l_ac].xcdw021_desc,g_xcdw4_d[l_ac].xcdw010_desc
     
         #end add-point
      
         #帶出公用欄位reference值
         
         
         
 
        
         #add-point:單身資料抓取
          
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
 
            CALL g_xcdw4_d.deleteElement(g_xcdw4_d.getLength())
      
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct322_pb4   
   

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_ref()
  INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdw_m.xcdwcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdw_m.xcdwcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdw_m.xcdwcomp_desc   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xcdw_m.xcdwld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdw_m.xcdwld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xcdw_m.xcdwld_desc   
   
   
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                      
   LET g_ref_fields[1] = g_xcdw_m.xcdw003                                                                                                                                
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xcdw_m.xcdw003_desc = '', g_rtn_fields[1] , ''                                                                                                                     
   DISPLAY BY NAME g_xcdw_m.xcdw003_desc  
   
   SELECT xcat003 INTO g_xcdw_m.xcat003
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xcdw_m.xcdw003
   DISPLAY BY NAME g_xcdw_m.xcat003 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_detail_ref(p_xcdw002,p_xcdw011,p_xcdw016,p_xcdw017,p_xcdw021,p_xcdw010)
DEFINE p_xcdw002 LIKE xcdw_t.xcdw002
DEFINE p_xcdw010 LIKE xcdw_t.xcdw010
DEFINE p_xcdw011 LIKE xcdw_t.xcdw011
DEFINE p_xcdw016 LIKE xcdw_t.xcdw016 
DEFINE p_xcdw017 LIKE xcdw_t.xcdw017
DEFINE p_xcdw021 LIKE xcdw_t.xcdw021
DEFINE l_xcdw002_desc LIKE type_t.chr1000
DEFINE l_xcdw010_desc LIKE type_t.chr1000
DEFINE l_xcdw011_desc LIKE type_t.chr1000
DEFINE l_xcdw011_desc_desc LIKE type_t.chr1000
DEFINE l_xcdw016_desc LIKE type_t.chr1000
DEFINE l_xcdw017_desc LIKE type_t.chr1000
DEFINE l_xcdw021_desc LIKE type_t.chr1000


#成本域
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
   LET g_ref_fields[1] = g_xcdw_m.xcdwcomp                                                                                                                                                 
   LET g_ref_fields[2] = p_xcdw002                                                                                                                                            
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xcdw002_desc = '', g_rtn_fields[1] , ''
#品名規格
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
   LET g_ref_fields[1] = p_xcdw011                                                                                                                            
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xcdw011_desc = '', g_rtn_fields[1] , '' 
   LET l_xcdw011_desc_desc = '', g_rtn_fields[2] , '' 
#倉庫
   CALL s_desc_get_stock_desc(g_site,p_xcdw016) RETURNING l_xcdw016_desc
#儲位
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xcdw017
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001 = '"||p_xcdw016||"' AND inab002 = ? ","") RETURNING g_rtn_fields
   LET l_xcdw017_desc = '', g_rtn_fields[1] , ''
#原因碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xcdw021
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='216' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xcdw021_desc = '', g_rtn_fields[1] , ''
#成本次要素
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
   LET g_ref_fields[1] = p_xcdw010                                                                                                                         
   CALL ap_ref_array2(g_ref_fields,"SELECT xcaul003 FROM xcaul_t WHERE xcaulent='"||g_enterprise||"' AND xcaul001=? AND xcaul002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xcdw010_desc = '', g_rtn_fields[1] , '' 
   
   RETURN l_xcdw002_desc,l_xcdw011_desc,l_xcdw011_desc_desc,l_xcdw016_desc,l_xcdw017_desc,l_xcdw021_desc,l_xcdw010_desc 

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_before_delete_3()
  
   
   DELETE FROM xcdw_t
    WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                              xcdw003 = g_xcdw_m.xcdw003 AND
                              xcdw004 = g_xcdw_m.xcdw004 AND
                              xcdw005 = g_xcdw_m.xcdw005 AND
                              xcdw006 = g_xcdw_m.xcdw006 AND
 
          xcdw001 = g_xcdw3_d_t.xcdw001
      AND xcdw002 = g_xcdw3_d_t.xcdw002
      AND xcdw007 = g_xcdw3_d_t.xcdw007
      AND xcdw008 = g_xcdw3_d_t.xcdw008
      AND xcdw009 = g_xcdw3_d_t.xcdw009
      AND xcdw010 = g_xcdw3_d_t.xcdw010
 
      
   #add-point:單筆刪除中
   
      DELETE FROM xcdw_t
       WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                                 xcdw003 = g_xcdw_m.xcdw003 AND
                                 xcdw004 = g_xcdw_m.xcdw004 AND
                                 xcdw005 = g_xcdw_m.xcdw005 AND
                                 xcdw006 = g_xcdw_m.xcdw006 AND
       
       
             xcdw002 = g_xcdw3_d_t.xcdw002
         AND xcdw007 = g_xcdw3_d_t.xcdw007
         AND xcdw008 = g_xcdw3_d_t.xcdw008
         AND xcdw009 = g_xcdw3_d_t.xcdw009
         AND xcdw010 = g_xcdw3_d_t.xcdw010
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdw_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後

   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_before_delete_4()

   
   DELETE FROM xcdw_t
    WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                              xcdw003 = g_xcdw_m.xcdw003 AND
                              xcdw004 = g_xcdw_m.xcdw004 AND
                              xcdw005 = g_xcdw_m.xcdw005 AND
                              xcdw006 = g_xcdw_m.xcdw006 AND
 
          xcdw001 = g_xcdw4_d_t.xcdw001
      AND xcdw002 = g_xcdw4_d_t.xcdw002
      AND xcdw007 = g_xcdw4_d_t.xcdw007
      AND xcdw008 = g_xcdw4_d_t.xcdw008
      AND xcdw009 = g_xcdw4_d_t.xcdw009
      AND xcdw010 = g_xcdw4_d_t.xcdw010
 
      
   #add-point:單筆刪除中
   
      DELETE FROM xcdw_t
       WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld AND
                                 xcdw003 = g_xcdw_m.xcdw003 AND
                                 xcdw004 = g_xcdw_m.xcdw004 AND
                                 xcdw005 = g_xcdw_m.xcdw005 AND
                                 xcdw006 = g_xcdw_m.xcdw006 AND
       
       
             xcdw002 = g_xcdw4_d_t.xcdw002
         AND xcdw007 = g_xcdw4_d_t.xcdw007
         AND xcdw008 = g_xcdw4_d_t.xcdw008
         AND xcdw009 = g_xcdw4_d_t.xcdw009
         AND xcdw010 = g_xcdw4_d_t.xcdw010
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcdw_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF
   
   #add-point:單筆刪除後

   #end add-point
 
   LET g_rec_b = g_rec_b-1
   DISPLAY g_rec_b TO FORMONLY.cnt
 
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_page_visible()
IF cl_null(g_xcdw_m.xcdwcomp) THEN
   CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否   
ELSE
   CALL cl_get_para(g_enterprise,g_xcdw_m.xcdwcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否   
END IF
         
IF g_para_data = 'Y' THEN
   CALL cl_set_comp_visible('xcdw002,xcdw002_desc,xcdw002_2,xcdw002_2_desc,xcdw002_3,xcdw002_3_desc,xcdw002_4,xcdw002_4_desc',TRUE)                    
ELSE
   CALL cl_set_comp_visible('xcdw002,xcdw002_desc,xcdw002_2,xcdw002_2_desc,xcdw002_3,xcdw002_3_desc,xcdw002_4,xcdw002_4_desc',FALSE)                
END IF
SELECT glaa001,glaa003,glaa015,glaa016,glaa018,glaa019,glaa020,glaa022,glaa025 
     INTO g_glaa001,g_glaa003,g_glaa015,g_glaa016,g_glaa018,g_glaa019,g_glaa020,g_glaa022,g_glaa025 
     FROM glaa_t
    WHERE glaaent = g_enterprise 
      AND glaald = g_xcdw_m.xcdwld
      
   IF g_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible("page_4",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_4",FALSE) 
   END IF
   IF g_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible("page_5",TRUE)
   ELSE
      CALL cl_set_comp_visible("page_5",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_get_date()
IF NOT cl_null(g_glaa003) AND NOT cl_null(g_xcdw_m.xcdw004) AND NOT cl_null(g_xcdw_m.xcdw005) THEN
  CALL s_fin_date_get_period_range(g_glaa003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005)
   RETURNING g_bdate,g_edate 
END IF 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_sum_chk()
DEFINE l_xcdw001 LIKE xcdw_t.xcdw001
DEFINE l_xcdw002 LIKE xcdw_t.xcdw002
DEFINE l_xcdw007 LIKE xcdw_t.xcdw007
DEFINE l_xcdw008 LIKE xcdw_t.xcdw008
DEFINE l_xcdw009 LIKE xcdw_t.xcdw009
DEFINE l_xcdw001_t LIKE xcdw_t.xcdw001
DEFINE l_xcdw002_t LIKE xcdw_t.xcdw002
DEFINE l_xcdw007_t LIKE xcdw_t.xcdw007
DEFINE l_xcdw008_t LIKE xcdw_t.xcdw008
DEFINE l_xcdw009_t LIKE xcdw_t.xcdw009
DEFINE l_str     STRING
DEFINE l_success LIKE type_t.chr1
DEFINE l_sumxcdw LIKE xcdw_t.xcdw202
DEFINE l_sumxccw LIKE xcdw_t.xcdw202
   LET l_success = 'Y'    

  CALL cl_err_collect_init()


#  CASE g_dlang
#      WHEN 'zh_TW'
           LET g_coll_title[1] = cl_getmsg("axc-00547",g_lang)# "賬套本位幣順序"
           LET g_coll_title[2] = cl_getmsg("axc-00548",g_lang)# "成本域"       
#           LET g_coll_title[3] = cl_getmsg("axc-00549",g_lang)# "項次"        #160318-00005#47  mark
           LET g_coll_title[3] = cl_getmsg("anm-00225",g_lang)# "項次"         #160318-00005#47  add 
           LET g_coll_title[4] = cl_getmsg("axc-00550",g_lang)# "項序"         
           LET g_coll_title[5] = cl_getmsg("axc-00551",g_lang)# "出入庫碼"     
#      WHEN 'zh_CN'
#           LET g_coll_title[1] = "账套本位币顺序"
#           LET g_coll_title[2] = "成本域"
#           LET g_coll_title[3] = "项次"
#           LET g_coll_title[4] = "项序"
#           LET g_coll_title[5] = "出入库码" 
#   END CASE
   

   FOREACH axct322_sum_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006
          INTO l_xcdw001,l_xcdw002,l_xcdw007,l_xcdw008,l_xcdw009  
      IF  (l_xcdw001_t = l_xcdw001) AND (l_xcdw002_t = l_xcdw002) AND (l_xcdw007_t = l_xcdw007) AND (l_xcdw008_t = l_xcdw008) AND (l_xcdw009_t = l_xcdw009) THEN
          CONTINUE FOREACH
      END IF             

      IF cl_null(l_xcdw002) THEN
         LET l_xcdw002 = ' '
      END IF
      
      LET l_sumxcdw= 0
      LET l_sumxccw= 0
      SELECT SUM(xcdw202) INTO l_sumxcdw FROM xcdw_t 
       WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
         AND xcdw003 = g_xcdw_m.xcdw003
         AND xcdw004 = g_xcdw_m.xcdw004
         AND xcdw005 = g_xcdw_m.xcdw005
         AND xcdw006 = g_xcdw_m.xcdw006
             
         AND xcdw001 = l_xcdw001
         AND xcdw002 = l_xcdw002               
         AND xcdw007 = l_xcdw007
         AND xcdw008 = l_xcdw008
         AND xcdw009 = l_xcdw009
          
         
      SELECT xccw202 INTO l_sumxccw FROM xccw_t 
      WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
        AND xccw003 = g_xcdw_m.xcdw003
        AND xccw004 = g_xcdw_m.xcdw004
        AND xccw005 = g_xcdw_m.xcdw005
        AND xccw006 = g_xcdw_m.xcdw006 
          
        AND xccw001 = l_xcdw001
        AND xccw002 = l_xcdw002               
        AND xccw007 = l_xcdw007
        AND xccw008 = l_xcdw008
        AND xccw009 = l_xcdw009
      
      IF cl_null(l_sumxcdw) THEN
         LET l_sumxcdw = 0
      END IF
      IF cl_null(l_sumxccw) THEN
         LET l_sumxccw = 0
      END IF
      IF l_sumxcdw <> l_sumxccw THEN             

        INITIALIZE g_errparam TO NULL
        CASE g_xcdw013_p 
             WHEN '1'
                LET g_errparam.code   = 'axc-00538' 
             WHEN '2'
                LET g_errparam.code   = "axc-00540"
             WHEN '3'
                LET g_errparam.code   = "axc-00542"
             WHEN '5'
                LET g_errparam.code   = "axc-00546"
        END CASE
        
        LET g_errparam.extend = ''
        LET g_errparam.popup = TRUE
        LET g_errparam.coll_vals[1] = l_xcdw001
        LET g_errparam.coll_vals[2] = l_xcdw002
        LET g_errparam.coll_vals[3] = l_xcdw007
        LET g_errparam.coll_vals[4] = l_xcdw008
        LET g_errparam.coll_vals[5] = l_xcdw009      
            
        LET g_errparam.sqlerr = 0
        CALL cl_err()

         LET l_success = 'N'
      END IF  
      LET l_xcdw001_t = l_xcdw001
      LET l_xcdw002_t = l_xcdw002
      LET l_xcdw007_t = l_xcdw007
      LET l_xcdw008_t = l_xcdw008
      LET l_xcdw009_t = l_xcdw009            
   END FOREACH
   CALL cl_err_collect_show()
   
   RETURN l_success
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_statechange()
#DEFINE lc_state LIKE type_t.chr5
#   #add-point:statechange段define
#DEFINE l_success LIKE  type_t.chr1  
#DEFINE l_current DATETIME YEAR TO SECOND 
#   #end add-point  
#   
#   #add-point:statechange段開始前
#
#   #end add-point  
#   
#   ERROR ""     #清空畫面右下側ERROR區塊
# 
#   
# 
#   MENU "" ATTRIBUTES (STYLE="popup")
#      BEFORE MENU
#         HIDE OPTION "approved"
#         HIDE OPTION "rejection"
#         CASE g_xcdw_m.xcdwstus
#            WHEN "N"
#               HIDE OPTION "unconfirmed"
#            WHEN "X"
#               HIDE OPTION "invalid"
#            WHEN "Y"
#               HIDE OPTION "confirmed"
#            
#         END CASE
#     
#      #add-point:menu前
##将一些不能切换的状态给隐藏掉，比如post时只能切confimed，不可切unconfirmed和invalid 
#         IF g_xcdw_m.xcdwstus = 'X' THEN
#            RETURN
#         END IF
#         
#         HIDE OPTION "signing"
#         HIDE OPTION "withdraw"
#         HIDE OPTION "closed"
#         HIDE OPTION "hold"
#         
#         CASE g_xcdw_m.xcdwstus
#            WHEN "N"
#               HIDE OPTION "unconfirmed"
#               HIDE OPTION "posted"
#               HIDE OPTION "unposted"
#            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
##               IF cl_bpm_chk() THEN
##                  SHOW OPTION "signing"
##                  HIDE OPTION "confirmed"
##               END IF
#            WHEN "X"
#               HIDE OPTION "invalid"
#               HIDE OPTION "confirmed"
#               HIDE OPTION "posted"
#               HIDE OPTION "unposted"               
#               HIDE OPTION "hold"
#            WHEN "Y"
#               HIDE OPTION "confirmed"
#               HIDE OPTION "invalid"
#               HIDE OPTION "hold"
#               HIDE OPTION "unposted"
#             
#         END CASE                   
#      #end add-point
#      
#      ON ACTION unconfirmed
#         IF cl_auth_chk_act("unconfirmed") THEN
#            LET lc_state = "N"
#            #add-point:action控制
#            IF NOT cl_ask_confirm('aim-00110') THEN
#               RETURN
#            END IF
#            
#            #end add-point
#         END IF
#         EXIT MENU
#      ON ACTION invalid
#         IF cl_auth_chk_act("invalid") THEN
#            LET lc_state = "X"
#            #add-point:action控制
#            IF NOT cl_ask_confirm('aim-00109') THEN
#               RETURN
#            END IF                           
#            #end add-point
#         END IF
#         EXIT MENU
#      ON ACTION confirmed
#         IF cl_auth_chk_act("confirmed") THEN
#            LET lc_state = "Y"
#            #add-point:action控制
#            IF NOT cl_ask_confirm('aim-00108') THEN
#               
#               RETURN
#            END IF     
#           
#            CALL axct322_xcdw010_chk() RETURNING l_success
#            IF l_success = 'N' THEN         
#               RETURN    
#            END IF 
#            CALL axct322_sum_chk() RETURNING l_success
#            IF l_success = 'N' THEN               
#               RETURN
#            END IF  
#            #end add-point
#         END IF
#         EXIT MENU
#      
#   END MENU
#   
#   IF (lc_state <> "N" 
#      AND lc_state <> "X"
#      AND lc_state <> "Y"      
#      ) OR 
#      cl_null(lc_state) THEN
#      RETURN
#   END IF
#   
#   #add-point:stus修改前
#   LET l_current = cl_get_current()
#   IF lc_state = 'Y' THEN
#      UPDATE xcdw_t SET (xcdwcnfid,xcdwcnfdt) = (g_user,l_current)
#       WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
#        AND xcdw003 = g_xcdw_m.xcdw003
#        AND xcdw004 = g_xcdw_m.xcdw004
#        AND xcdw005 = g_xcdw_m.xcdw005
#        AND xcdw006 = g_xcdw_m.xcdw006    
#   END IF   
#   #end add-point
#      
#   UPDATE xcdw_t SET xcdwstus = lc_state 
#    WHERE xcdwent = g_enterprise AND xcdwld = g_xcdw_m.xcdwld
#         AND xcdw003 = g_xcdw_m.xcdw003
#         AND xcdw004 = g_xcdw_m.xcdw004
#         AND xcdw005 = g_xcdw_m.xcdw005
#         AND xcdw006 = g_xcdw_m.xcdw006   
#         
#   IF SQLCA.sqlcode THEN
#      INITIALIZE g_errparam TO NULL 
#      LET g_errparam.extend = "" 
#      LET g_errparam.code   = SQLCA.sqlcode 
#      LET g_errparam.popup  = FALSE 
#      CALL cl_err()
# 
#   ELSE
#      CASE lc_state
#         WHEN "N"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
#         WHEN "X"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
#         WHEN "Y"
#            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
#         
#         
#      END CASE
#      LET g_xcdw_m.xcdwstus = lc_state
#      DISPLAY BY NAME g_xcdw_m.xcdwstus
#   END IF
# 
#   #add-point:stus修改後
#         
#   #end add-point
# 
#   #add-point:statechange段結束前
#         
#   #end add-point  
# 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL axct322_insert_default()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_insert_default()
 
   IF cl_null(g_xcdw_d[l_ac].xcdw002) THEN LET g_xcdw_d[l_ac].xcdw002 = ' ' END IF
   SELECT xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw020,xccw021,xccw201,
          xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,xccw029,xccw030,
          xccw031,xccw032,xccw033,xccw034
     INTO g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,g_xcdw_d[l_ac].xcdw016,
          g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,
          g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026,
          g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw030,
          g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw034
     FROM xccw_t
    WHERE xccwent = g_enterprise AND xccwld = g_xcdw_m.xcdwld
      AND xccw003 = g_xcdw_m.xcdw003 AND xccw004 = g_xcdw_m.xcdw004
      AND xccw005 = g_xcdw_m.xcdw005 AND xccw006 = g_xcdw_m.xcdw006
      AND xccw001 = '1' AND xccw002 = g_xcdw_d[l_ac].xcdw002
      AND xccw007 = g_xcdw_d[l_ac].xcdw007 AND xccw008 = g_xcdw_d[l_ac].xcdw008 
      AND xccw009 = g_xcdw_d[l_ac].xcdw009
   #DISPLAY BY NAME g_xcdw_d[l_ac].xcdwsite,g_xcdw_d[l_ac].xcdw011,g_xcdw_d[l_ac].xcdw012,
   #       g_xcdw_d[l_ac].xcdw016,g_xcdw_d[l_ac].xcdw017,g_xcdw_d[l_ac].xcdw018,g_xcdw_d[l_ac].xcdw020,g_xcdw_d[l_ac].xcdw021,g_xcdw_d[l_ac].xcdw201,
   #       g_xcdw2_d[l_ac].xcdw022,g_xcdw2_d[l_ac].xcdw023,g_xcdw2_d[l_ac].xcdw024,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw026,
   #       g_xcdw2_d[l_ac].xcdw027,g_xcdw2_d[l_ac].xcdw028,g_xcdw2_d[l_ac].xcdw029,g_xcdw2_d[l_ac].xcdw025,g_xcdw2_d[l_ac].xcdw030,
   #       g_xcdw2_d[l_ac].xcdw031,g_xcdw2_d[l_ac].xcdw032,g_xcdw2_d[l_ac].xcdw033,g_xcdw2_d[l_ac].xcdw034
   
   #RETURN l_xcdwsite,l_xcdw011,l_xcdw012,l_xcdw016,l_xcdw017,l_xcdw020,l_xcdw021,l_xcdw201  

   #160824-00007#223 161202 by lori add---(S)
   LET g_xcdw_d[l_ac].xcdwsite = g_xcdw_d[l_ac].xcdwsite
   LET g_xcdw_d[l_ac].xcdw011 = g_xcdw_d[l_ac].xcdw011
   LET g_xcdw_d[l_ac].xcdw012 = g_xcdw_d[l_ac].xcdw012
   LET g_xcdw_d[l_ac].xcdw016 = g_xcdw_d[l_ac].xcdw016
   LET g_xcdw_d[l_ac].xcdw017 = g_xcdw_d[l_ac].xcdw017
   LET g_xcdw_d[l_ac].xcdw018 = g_xcdw_d[l_ac].xcdw018
   LET g_xcdw_d[l_ac].xcdw020 = g_xcdw_d[l_ac].xcdw020
   LET g_xcdw_d[l_ac].xcdw021 = g_xcdw_d[l_ac].xcdw021
   LET g_xcdw_d[l_ac].xcdw201 = g_xcdw_d[l_ac].xcdw201
   LET g_xcdw2_d[l_ac].xcdw022 = g_xcdw2_d[l_ac].xcdw022
   LET g_xcdw2_d[l_ac].xcdw023 = g_xcdw2_d[l_ac].xcdw023
   LET g_xcdw2_d[l_ac].xcdw024 = g_xcdw2_d[l_ac].xcdw024
   LET g_xcdw2_d[l_ac].xcdw025 = g_xcdw2_d[l_ac].xcdw025
   LET g_xcdw2_d[l_ac].xcdw026 = g_xcdw2_d[l_ac].xcdw026
   LET g_xcdw2_d[l_ac].xcdw027 = g_xcdw2_d[l_ac].xcdw027
   LET g_xcdw2_d[l_ac].xcdw028 = g_xcdw2_d[l_ac].xcdw028
   LET g_xcdw2_d[l_ac].xcdw029 = g_xcdw2_d[l_ac].xcdw029
   LET g_xcdw2_d[l_ac].xcdw030 = g_xcdw2_d[l_ac].xcdw030
   LET g_xcdw2_d[l_ac].xcdw031 = g_xcdw2_d[l_ac].xcdw031
   LET g_xcdw2_d[l_ac].xcdw032 = g_xcdw2_d[l_ac].xcdw032
   LET g_xcdw2_d[l_ac].xcdw033 = g_xcdw2_d[l_ac].xcdw033
   LET g_xcdw2_d[l_ac].xcdw034 = g_xcdw2_d[l_ac].xcdw034
   #160824-00007#223 161202 by lori add---(E)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION axct322_xcdw010_chk()
DEFINE l_success LIKE type_t.chr1
DEFINE l_xcdw010 LIKE xcdw_t.xcdw010

   LET l_success = 'Y'    
FOREACH axct322_xcdw010_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,'1'
          INTO l_xcdw010
    IF cl_null(l_xcdw010) THEN
       LET l_success = 'N'
       INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "" 
       LET g_errparam.code   = "axc-00556" 
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
       EXIT FOREACH
    END IF
END FOREACH
IF g_glaa015  = 'Y' THEN
   FOREACH axct322_xcdw010_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,'2'
             INTO l_xcdw010
       IF cl_null(l_xcdw010) THEN
          LET l_success = 'N'
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "" 
          LET g_errparam.code   = "axc-00556" 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
   END FOREACH
END IF
IF g_glaa019  = 'Y' THEN
   FOREACH axct322_xcdw010_cs USING g_enterprise,g_xcdw_m.xcdwld,g_xcdw_m.xcdw003,g_xcdw_m.xcdw004,g_xcdw_m.xcdw005,g_xcdw_m.xcdw006,'3'
             INTO l_xcdw010
       IF cl_null(l_xcdw010) THEN
          LET l_success = 'N'
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "" 
          LET g_errparam.code   = "axc-00556" 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
          EXIT FOREACH
       END IF
   END FOREACH
END IF
RETURN l_success
END FUNCTION

 
{</section>}
 
