#該程式已解開Section, 不再透過樣板產出!
{<section id="axct312.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000321
#+ 
#+ Filename...: axct312
#+ Description: 雜收入庫成本維護作業
#+ Creator....: (1899/12/31)
#+ Modifier...: 03297(2014/09/02) -SD/PR- 02749
#+ Buildtype..: 應用 i07 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="axct312.global" >}
#160318-00025#12    2016/04/26 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160510-00037#1     2016/05/11 By xianghui    金额栏位和数量栏位不能小于零
#160802-00020#5     2016/10/12 By 02040       增加帳套權限管控、法人權限管控
#161108-00013#1     2016/11/08 By 07024       與筆數相關的全域變數，型態改為num10，如：g_browser_cnt...
#161109-00085#24    2016/11/16 By 08993       整批調整系統星號寫法
#160824-00007#223   2016/12/02 By lori        修正舊值備份寫法
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds 
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_xccw_m        RECORD
       xccwld LIKE xccw_t.xccwld, 
   xccwld_desc LIKE type_t.chr80, 
   xccwcomp LIKE xccw_t.xccwcomp, 
   xccwcomp_desc LIKE type_t.chr80, 
   xccw003 LIKE xccw_t.xccw003, 
   xccw003_desc LIKE type_t.chr80, 
   xccw012 LIKE xccw_t.xccw012, 
   xccw006 LIKE xccw_t.xccw006, 
   xccw013 LIKE xccw_t.xccw013, 
   xccw004 LIKE xccw_t.xccw004, 
   xccw005 LIKE xccw_t.xccw005, 
   xcat003 LIKE xcat_t.xcat003
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_xccw_d        RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002,
   xccw002_desc LIKE xcbfl_t.xcbfl003,   
   xccwsite LIKE xccw_t.xccwsite, 
   xccw010 LIKE xccw_t.xccw010,
   xccw010_desc LIKE imaal_t.imaal003,
   xccw010_desc_desc LIKE imaal_t.imaal004,   
   xccw011 LIKE xccw_t.xccw011, 
   xccw015 LIKE xccw_t.xccw015, 
   xccw015_desc LIKE type_t.chr1000, 
   xccw016 LIKE xccw_t.xccw016,
   xccw016_desc LIKE type_t.chr1000,   
   xccw017 LIKE xccw_t.xccw017, 
   xccw009 LIKE xccw_t.xccw009,     
   xccw043 LIKE xccw_t.xccw043, 
   xccw046 LIKE xccw_t.xccw046, 
   xccw044 LIKE xccw_t.xccw044, 
   xccw045 LIKE xccw_t.xccw045, 
   xccw201 LIKE xccw_t.xccw201, 
   xccw282a LIKE xccw_t.xccw282a, 
   xccw282b LIKE xccw_t.xccw282b, 
   xccw282c LIKE xccw_t.xccw282c, 
   xccw282d LIKE xccw_t.xccw282d, 
   xccw282e LIKE xccw_t.xccw282e, 
   xccw282f LIKE xccw_t.xccw282f, 
   xccw282g LIKE xccw_t.xccw282g, 
   xccw282h LIKE xccw_t.xccw282h, 
   xccw282 LIKE xccw_t.xccw282, 
   xccw202 LIKE xccw_t.xccw202, 
   xccw202a LIKE xccw_t.xccw202a, 
   xccw202b LIKE xccw_t.xccw202b, 
   xccw202c LIKE xccw_t.xccw202c, 
   xccw202d LIKE xccw_t.xccw202d, 
   xccw202e LIKE xccw_t.xccw202e, 
   xccw202f LIKE xccw_t.xccw202f, 
   xccw202g LIKE xccw_t.xccw202g, 
   xccw202h LIKE xccw_t.xccw202h,
   xccw020 LIKE xccw_t.xccw020, 
   xccw021 LIKE xccw_t.xccw021,
   xccw021_desc LIKE type_t.chr1000,
   inba004_desc LIKE type_t.chr1000,  #dorislai-20151005-add----(S)
   inbb020 LIKE inbb_t.inbb020,
   inbb021 LIKE inbb_t.inbb021        #dorislai-20151005-add----(E)
       END RECORD
PRIVATE TYPE type_g_xccw2_d RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002,   
   xccw010 LIKE xccw_t.xccw010, 
   xccw011 LIKE xccw_t.xccw011, 
   xcckownid LIKE xcck_t.xcckownid, 
   xcckownid_desc LIKE type_t.chr500, 
   xcckowndp LIKE xcck_t.xcckowndp, 
   xcckowndp_desc LIKE type_t.chr500, 
   xcckcrtid LIKE xcck_t.xcckcrtid, 
   xcckcrtid_desc LIKE type_t.chr500, 
   xcckcrtdp LIKE xcck_t.xcckcrtdp, 
   xcckcrtdp_desc LIKE type_t.chr500, 
   xcckcrtdt DATETIME YEAR TO SECOND, 
   xcckmodid LIKE xcck_t.xcckmodid, 
   xcckmodid_desc LIKE type_t.chr500, 
   xcckmoddt DATETIME YEAR TO SECOND
       END RECORD
PRIVATE TYPE type_g_xccw3_d RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002, 
   xccw002_desc LIKE xcbfl_t.xcbfl003, 
   xccwsite LIKE xccw_t.xccwsite, 
   xccw010 LIKE xccw_t.xccw010, 
   xccw010_desc LIKE imaal_t.imaal003,
   xccw010_desc_desc LIKE imaal_t.imaal004, 
   xccw011 LIKE xccw_t.xccw011,       
   xccw032 LIKE xccw_t.xccw032,
   xccw032_desc LIKE type_t.chr500,
   xccw033 LIKE xccw_t.xccw033, 
   xccw033_desc LIKE type_t.chr500,   
   xccw022 LIKE xccw_t.xccw022,
   xccw022_desc LIKE type_t.chr500,   
   xccw023 LIKE xccw_t.xccw023, 
   xccw023_desc LIKE type_t.chr500,   
   xccw024 LIKE xccw_t.xccw024,
   xccw024_desc LIKE type_t.chr500,      
   xccw025 LIKE xccw_t.xccw025, 
   xccw025_desc LIKE type_t.chr500,   
   xccw026 LIKE xccw_t.xccw026,
   xccw026_desc LIKE type_t.chr500,      
   xccw027 LIKE xccw_t.xccw027,
   xccw027_desc LIKE type_t.chr500,      
   xccw028 LIKE xccw_t.xccw028, 
   xccw028_desc LIKE type_t.chr500,   
   xccw029 LIKE xccw_t.xccw029,
   xccw029_desc LIKE type_t.chr500,      
   xccw030 LIKE xccw_t.xccw030,
   xccw030_desc LIKE type_t.chr500,      
   xccw031 LIKE xccw_t.xccw031,
   xccw031_desc LIKE type_t.chr500,      
   xccw201 LIKE xccw_t.xccw201, 
   xccw282 LIKE xccw_t.xccw282, 
   xccw202 LIKE xccw_t.xccw202, 
   xccw009 LIKE xccw_t.xccw009,
   xccw021 LIKE xccw_t.xccw021,
   xccw021_desc LIKE type_t.chr1000,
   inba004_desc LIKE type_t.chr1000,  #dorislai-20151006-add----(S)
   inbb020 LIKE inbb_t.inbb020,
   inbb021 LIKE inbb_t.inbb021        #dorislai-20151006-add----(E)
       END RECORD
 
 
DEFINE g_detail_multi_table_t    RECORD
      xcckownid LIKE xcck_t.xcckownid,
      xcckowndp LIKE xcck_t.xcckowndp,
      xcckcrtid LIKE xcck_t.xcckcrtid,
      xcckcrtdp LIKE xcck_t.xcckcrtdp,
      xcckcrtdt LIKE xcck_t.xcckcrtdt,
      xcckmodid LIKE xcck_t.xcckmodid,
      xcckmoddt LIKE xcck_t.xcckmoddt
      
      END RECORD
 
#模組變數(Module Variables)
DEFINE g_xccw_m          type_g_xccw_m
DEFINE g_xccw_m_t        type_g_xccw_m
DEFINE g_xccw_m_o        type_g_xccw_m
 
   DEFINE g_xccwld_t LIKE xccw_t.xccwld
DEFINE g_xccw003_t LIKE xccw_t.xccw003
DEFINE g_xccw006_t LIKE xccw_t.xccw006
DEFINE g_xccw004_t LIKE xccw_t.xccw004
DEFINE g_xccw005_t LIKE xccw_t.xccw005
 
 
DEFINE g_xccw_d          DYNAMIC ARRAY OF type_g_xccw_d
DEFINE g_xccw_d_t        type_g_xccw_d
DEFINE g_xccw_d_o        type_g_xccw_d
DEFINE g_xccw2_d   DYNAMIC ARRAY OF type_g_xccw2_d
DEFINE g_xccw2_d_t type_g_xccw2_d
DEFINE g_xccw2_d_o type_g_xccw2_d
DEFINE g_xccw3_d   DYNAMIC ARRAY OF type_g_xccw3_d
DEFINE g_xccw3_d_t type_g_xccw3_d
DEFINE g_xccw3_d_o type_g_xccw3_d
 
 
DEFINE g_browser      DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位  
       b_statepic     LIKE type_t.chr50,
          b_xccwld LIKE xccw_t.xccwld,
      b_xccw003 LIKE xccw_t.xccw003,
      b_xccw004 LIKE xccw_t.xccw004,
      b_xccw005 LIKE xccw_t.xccw005,
      b_xccw006 LIKE xccw_t.xccw006
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
#161108-00013#1-s-mod
#DEFINE g_rec_b               LIKE type_t.num5           
#DEFINE l_ac                  LIKE type_t.num5    
#DEFINE g_curr_diag           ui.Dialog                     #Current Dialog
# 
#DEFINE g_pagestart           LIKE type_t.num5           
#DEFINE gwin_curr             ui.Window                     #Current Window
#DEFINE gfrm_curr             ui.Form                       #Current Form
#DEFINE g_page_action         STRING                        #page action
#DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
#DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
#DEFINE g_page                STRING                        #第幾頁
#DEFINE g_bfill               LIKE type_t.chr5              #是否刷新單身
# 
#DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
#DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
#DEFINE g_detail_idx2         LIKE type_t.num5              #單身2目前所在筆數
#DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數  
#DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
#DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)
# 
#DEFINE g_searchcol           STRING                        #查詢欄位代碼
#DEFINE g_searchstr           STRING                        #查詢欄位字串
#DEFINE g_order               STRING                        #查詢排序欄位
#DEFINE g_state               STRING                        
#DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
#DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
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
 
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位
DEFINE g_state               STRING                        
DEFINE g_insert              LIKE type_t.chr5              #是否導到其他page                    
DEFINE g_current_row         LIKE type_t.num10             #Browser所在筆數
#161108-00013#1-e-mod
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
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa015             LIKE glaa_t.glaa015
DEFINE g_glaa016             LIKE glaa_t.glaa016
DEFINE g_glaa017             LIKE glaa_t.glaa017
DEFINE g_glaa018             LIKE glaa_t.glaa018
DEFINE g_glaa019             LIKE glaa_t.glaa019
DEFINE g_glaa020             LIKE glaa_t.glaa020
DEFINE g_glaa021             LIKE glaa_t.glaa021
DEFINE g_glaa022             LIKE glaa_t.glaa022
DEFINE g_glaa025             LIKE glaa_t.glaa025 
DEFINE g_glaa026             LIKE glaa_t.glaa026
TYPE type_g_xccw4_d RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002, 
   xccwsite LIKE xccw_t.xccwsite, 
   xccw010 LIKE xccw_t.xccw010, 
   xccw011 LIKE xccw_t.xccw011, 
   xccw041 LIKE xccw_t.xccw041, 
   xccw042 LIKE xccw_t.xccw042, 
   xccw044 LIKE xccw_t.xccw044,  
   xccw201 LIKE xccw_t.xccw201,  
   xccw282a LIKE xccw_t.xccw282a, 
   xccw282b LIKE xccw_t.xccw282b, 
   xccw282c LIKE xccw_t.xccw282c, 
   xccw282d LIKE xccw_t.xccw282d, 
   xccw282e LIKE xccw_t.xccw282e, 
   xccw282f LIKE xccw_t.xccw282f, 
   xccw282g LIKE xccw_t.xccw282g, 
   xccw282h LIKE xccw_t.xccw282h, 
   xccw282 LIKE xccw_t.xccw282, 
   xccw202 LIKE xccw_t.xccw202, 
   xccw202a LIKE xccw_t.xccw202a, 
   xccw202b LIKE xccw_t.xccw202b, 
   xccw202c LIKE xccw_t.xccw202c, 
   xccw202d LIKE xccw_t.xccw202d, 
   xccw202e LIKE xccw_t.xccw202e, 
   xccw202f LIKE xccw_t.xccw202f, 
   xccw202g LIKE xccw_t.xccw202g, 
   xccw202h LIKE xccw_t.xccw202h,
   xccw009 LIKE xccw_t.xccw009
       END RECORD
DEFINE g_xccw4_d   DYNAMIC ARRAY OF type_g_xccw4_d
DEFINE g_xccw4_d_t type_g_xccw4_d
TYPE type_g_xccw6_d RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002, 
   xccw002_desc LIKE xcbfl_t.xcbfl003, 
   xccwsite LIKE xccw_t.xccwsite, 
   xccw010 LIKE xccw_t.xccw010, 
   xccw010_desc LIKE imaal_t.imaal003,
   xccw010_desc_desc LIKE imaal_t.imaal004, 
   xccw011 LIKE xccw_t.xccw011, 
   xccw041 LIKE xccw_t.xccw041, 
   xccw042 LIKE xccw_t.xccw042, 
   xccw044 LIKE xccw_t.xccw044,  
   xccw201 LIKE xccw_t.xccw201, 
   xccw282a LIKE xccw_t.xccw282a, 
   xccw282b LIKE xccw_t.xccw282b, 
   xccw282c LIKE xccw_t.xccw282c, 
   xccw282d LIKE xccw_t.xccw282d, 
   xccw282e LIKE xccw_t.xccw282e, 
   xccw282f LIKE xccw_t.xccw282f, 
   xccw282g LIKE xccw_t.xccw282g, 
   xccw282h LIKE xccw_t.xccw282h, 
   xccw282 LIKE xccw_t.xccw282, 
   xccw202 LIKE xccw_t.xccw202, 
   xccw202a LIKE xccw_t.xccw202a, 
   xccw202b LIKE xccw_t.xccw202b, 
   xccw202c LIKE xccw_t.xccw202c, 
   xccw202d LIKE xccw_t.xccw202d, 
   xccw202e LIKE xccw_t.xccw202e, 
   xccw202f LIKE xccw_t.xccw202f, 
   xccw202g LIKE xccw_t.xccw202g, 
   xccw202h LIKE xccw_t.xccw202h,
   xccw009 LIKE xccw_t.xccw009
       END RECORD
DEFINE g_xccw6_d   DYNAMIC ARRAY OF type_g_xccw6_d
DEFINE g_xccw6_d_t type_g_xccw6_d
 TYPE type_g_xccw5_d RECORD
       xccw001 LIKE xccw_t.xccw001, 
   xccw007 LIKE xccw_t.xccw007, 
   xccw008 LIKE xccw_t.xccw008, 
   xccw002 LIKE xccw_t.xccw002, 
   xccw002_desc LIKE xcbfl_t.xcbfl003, 
   xccwsite LIKE xccw_t.xccwsite, 
   xccw010 LIKE xccw_t.xccw010, 
   xccw010_desc LIKE imaal_t.imaal003,
   xccw010_desc_desc LIKE imaal_t.imaal004, 
   xccw011 LIKE xccw_t.xccw011, 
   xccw041 LIKE xccw_t.xccw041, 
   xccw042 LIKE xccw_t.xccw042, 
   xccw044 LIKE xccw_t.xccw044,  
   xccw201 LIKE xccw_t.xccw201, 
   xccw282a LIKE xccw_t.xccw282a, 
   xccw282b LIKE xccw_t.xccw282b, 
   xccw282c LIKE xccw_t.xccw282c, 
   xccw282d LIKE xccw_t.xccw282d, 
   xccw282e LIKE xccw_t.xccw282e, 
   xccw282f LIKE xccw_t.xccw282f, 
   xccw282g LIKE xccw_t.xccw282g, 
   xccw282h LIKE xccw_t.xccw282h, 
   xccw282 LIKE xccw_t.xccw282, 
   xccw202 LIKE xccw_t.xccw202, 
   xccw202a LIKE xccw_t.xccw202a, 
   xccw202b LIKE xccw_t.xccw202b, 
   xccw202c LIKE xccw_t.xccw202c, 
   xccw202d LIKE xccw_t.xccw202d, 
   xccw202e LIKE xccw_t.xccw202e, 
   xccw202f LIKE xccw_t.xccw202f, 
   xccw202g LIKE xccw_t.xccw202g, 
   xccw202h LIKE xccw_t.xccw202h,
   xccw009 LIKE xccw_t.xccw009
       END RECORD
DEFINE g_xccw5_d   DYNAMIC ARRAY OF type_g_xccw5_d
DEFINE g_xccw5_d_t type_g_xccw5_d

DEFINE g_xccw012_p    LIKE xccw_t.xccw012
DEFINE g_glaa003      LIKE glaa_t.glaa003
DEFINE g_para_data    LIKE type_t.chr80     #采用成本域否
DEFINE g_para_data1   LIKE type_t.chr80     #成本域类型
DEFINE g_ooaj003      LIKE ooaj_t.ooaj003   #单位精度 
DEFINE g_ooaj004      LIKE ooaj_t.ooaj004   #金额精度 

DEFINE g_glaa004      LIKE glaa_t.glaa004
#160802-00020#5-s-add
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#160802-00020#5-e-add
#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="axct312.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始 
MAIN
   #add-point:main段define
   
   #end add-point   
 
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化
   LET g_xccw012_p = g_argv[1]
   #160802-00020#5-s-add
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#5-e-add    
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = " SELECT xccwld,'',xccwcomp,'',xccw003,'',xccw012,xccw006,xccw013,xccw004,xccw005, 
       ''", 
                      " FROM xccw_t",
                      " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND  
                          xccw006=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct312_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT UNIQUE t0.xccwld,t0.xccwcomp,t0.xccw003,t0.xccw012,t0.xccw006,t0.xccw013,t0.xccw004, 
       t0.xccw005,t1.glaal002 ,t2.ooefl003 ,t3.xcatl003",
               " FROM xccw_t t0",
                              " LEFT JOIN glaal_t t1 ON t1.glaalent='"||g_enterprise||"' AND t1.glaalld=t0.xccwld AND t1.glaal001='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent='"||g_enterprise||"' AND t2.ooefl001=t0.xccwcomp AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN xcatl_t t3 ON t3.xcatlent='"||g_enterprise||"' AND t3.xcatl001=t0.xccw003 AND t3.xcatl002='"||g_dlang||"' ",
 
               " WHERE t0.xccwent = '" ||g_enterprise|| "' AND t0.xccwld = ? AND t0.xccw003 = ? AND t0.xccw004 = ? AND t0.xccw005 = ? AND t0.xccw006 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define
   
   #end add-point
   PREPARE axct312_master_referesh FROM g_sql
 
 
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axct312 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axct312_init()   
 
      #進入選單 Menu (="N")
      CALL axct312_ui_dialog() 
      
      #add-point:畫面關閉前
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axct312
      
   END IF 
   
   CLOSE axct312_cl
   
   
 
   #add-point:作業離開前
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN
 
 
 
{</section>}
 
{<section id="axct312.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axct312_init()
   #add-point:init段define
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
  
   LET g_bfill = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('xcat003','8904') 
 
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #add-point:畫面資料初始化
   CALL cl_set_combo_scc('xccw012','8917') 
   CALL cl_set_combo_scc('xccw001','8914') 
   CALL cl_set_combo_scc('xccw001_2','8914') 
   CALL cl_set_combo_scc('xccw001_3','8914') 
   CALL cl_set_combo_scc('xccw001_4','8914') 
   CALL cl_set_combo_scc('xccw001_5','8914') 
   
   LET l_str1 = cl_getmsg("axc-00235",g_lang)   #雜收明細
   LET l_str2 = cl_getmsg("axc-00236",g_lang)   #雜發明細
   LET l_str3 = cl_getmsg("axc-00237",g_lang)   #當站下線
   LET l_str4 = cl_getmsg("axc-00238",g_lang)   #同業借料明細
   LET l_str5 = cl_getmsg("axc-00239",g_lang)   #成本信息
   LET l_str6 = cl_getmsg("axc-00240",g_lang)   #財務信息
   LET l_str7 = cl_getmsg("axc-00278",g_lang)   #調撥明細
   LET l_str8 = cl_getmsg("axc-00279",g_lang)   #調撥成本
   
   IF g_xccw012_p = '1' THEN 
      LET l_msg1 = l_str1 CLIPPED,l_str5 
      LET l_msg2 = l_str1 CLIPPED,l_str6
   END IF  
   IF g_xccw012_p = '2' THEN 
      LET l_msg1 = l_str2 CLIPPED,l_str5 
      LET l_msg2 = l_str2 CLIPPED,l_str6
   END IF 
   IF g_xccw012_p = '3' THEN 
      LET l_msg1 = l_str3 CLIPPED,l_str5 
      LET l_msg2 = l_str3 CLIPPED,l_str6
   END IF 
   IF g_xccw012_p = '4' THEN 
      LET l_msg1 = l_str4 CLIPPED,l_str5 
      LET l_msg2 = l_str4 CLIPPED,l_str6
   END IF 
   IF g_xccw012_p = '5' THEN 
      LET l_msg1 = l_str7 CLIPPED,l_str5 
      LET l_msg2 = l_str8 CLIPPED,l_str6
   END IF 
   CALL cl_set_comp_att_text('bpage_1',l_msg1)
   CALL cl_set_comp_att_text('page_3',l_msg2)  
   LET g_today=cl_get_today() 
   CALL cl_set_comp_visible('xccw002,xccw002_desc,xccw002_3,xccw002_3_desc,xccw002_6,xccw002_6_desc,xccw002_5,xccw002_5_desc',FALSE)
   #dorislai-20151005-add----(S)
   #申請部門:aint302、aint301、asdft337、aint330(調撥)
   #單據備註:aint302、aint301、        、aint330(調撥)
   #存貨備註:aint302、       、asft337
   CASE g_xccw012_p
      WHEN '2' #axct313
         CALL cl_set_comp_visible("inbb021,inbb021_3",FALSE)
      WHEN '3' #axct314
         CALL cl_set_comp_visible("inbb020,inbb020_3",FALSE)
      WHEN '5' #axct315
         CALL cl_set_comp_visible("inbb021,inbb021_3",FALSE)
   END CASE
   #dorislai-20151005-add----(E)   
   #end add-point
   
   CALL axct312_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="axct312.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION axct312_ui_dialog()
   DEFINE la_param  RECORD
             prog   STRING,
             param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_wc     STRING
   DEFINE lb_first  BOOLEAN
   #add-point:ui_dialog段define

   #end add-point  
   
   LET lb_first = TRUE
   
   CALL cl_set_act_visible("accept,cancel", FALSE)
   
   
   #add-point:ui_dialog段before dialog 

   #end add-point
   
   WHILE TRUE
   
      CALL axct312_browser_fill("")
 
      
      ##判斷前一個動作是否為新增, 若是的話切換到新增的筆數
      #IF g_state = "Y" THEN
      #   FOR li_idx = 1 TO g_browser.getLength()
      #      IF g_browser[li_idx].b_xccwld = g_xccwld_t
      #         AND g_browser[li_idx].b_xccw003 = g_xccw003_t
      #         AND g_browser[li_idx].b_xccw004 = g_xccw004_t
      #         AND g_browser[li_idx].b_xccw005 = g_xccw005_t
      #         AND g_browser[li_idx].b_xccw006 = g_xccw006_t
 
      #         THEN
      #         LET g_current_row = li_idx
      #         EXIT FOR
      #      END IF
      #   END FOR
      #   LET g_state = ""
      #END IF
      
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
        
         DISPLAY ARRAY g_xccw_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               
               #控制stus哪個按鈕可以按
               
               
            
 
            #add-point:page1自定義行為

            #end add-point
               
         END DISPLAY
        
         DISPLAY ARRAY g_xccw2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail2")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page2自定義行為

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_xccw3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page3自定義行為

            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array
         DISPLAY ARRAY g_xccw4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
         END DISPLAY
         DISPLAY ARRAY g_xccw6_d TO s_detail6.* ATTRIBUTES(COUNT=g_rec_b) #page1  
         
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)
               LET l_ac = DIALOG.getCurrentRow("s_detail6")
         END DISPLAY
         DISPLAY ARRAY g_xccw5_d TO s_detail5.* ATTRIBUTES(COUNT=g_rec_b)  
         
            BEFORE ROW
               LET l_ac = DIALOG.getCurrentRow("s_detail5")
               LET g_detail_idx = l_ac
               DISPLAY g_detail_idx TO FORMONLY.idx
               CALL axct312_ui_detailshow()
               
               #add-point:page1自定義行為

               #end add-point
            
            BEFORE DISPLAY 
               CALL FGL_SET_ARR_CURR(g_detail_idx)      
            
            
         
            #add-point:page5自定義行為
 
            #end add-point
         
         END DISPLAY
         #end add-point
         
         
         BEFORE DIALOG
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
               CALL axct312_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL axct312_ui_detailshow() #Setting the current row 
            
            #add-point:ui_dialog段before dialog2
            #fengmy 150213 --begin
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  LET g_export_node[1] = base.typeInfo.create(g_xccw_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_xccw3_d)
                  LET g_export_id[2]   = "s_detail3"
                  LET g_export_node[3] = base.typeInfo.create(g_xccw4_d)
                  LET g_export_id[3]   = "s_detail4"
                  LET g_export_node[4] = base.typeInfo.create(g_xccw6_d)
                  LET g_export_id[4]   = "s_detail6"
                  LET g_export_node[5] = base.typeInfo.create(g_xccw5_d)
                  LET g_export_id[5]   = "s_detail5"
                  CALL cl_export_to_excel_getpage()
                  CALL cl_export_to_excel()
               END IF
            #fengmy 150213 --end

            #end add-point
 
         
         
         ON ACTION first
            CALL axct312_fetch('F')
            LET g_current_row = g_current_idx         
          
         ON ACTION previous
            CALL axct312_fetch('P')
            LET g_current_row = g_current_idx
          
         ON ACTION jump
            CALL axct312_fetch('/')
            LET g_current_row = g_current_idx
        
         ON ACTION next
            CALL axct312_fetch('N')
            LET g_current_row = g_current_idx
         
         ON ACTION last
            CALL axct312_fetch('L')
            LET g_current_row = g_current_idx
          
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
               NEXT FIELD xccw001
            END IF
       
         ON ACTION controls      #單頭摺疊，可利用hot key "Ctrl-s"開啟/關閉單頭
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
               CALL axct312_browser_fill("F")   #browser_fill()會將notice區塊清空
               CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            END IF
         
         ON ACTION qbe_select
            CALL cl_qbe_list("m") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               #取得條件後需要重查、跳到結果第一筆資料的功能程式段
               CALL axct312_browser_fill("F")
               IF g_browser_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLEAR FORM
               ELSE
                  CALL axct312_fetch("F")
               END IF
            END IF
            #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
            CALL cl_notice()
               
         
         #+ 此段落由子樣板a43產生
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL axct312_modify()
               #add-point:ON ACTION modify

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL axct312_modify()
               #add-point:ON ACTION modify_detail

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL axct312_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL axct312_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION open_axct312_01
            LET g_action_choice="open_axct312_01"
            IF cl_auth_chk_act("open_axct312_01") THEN
               
               #add-point:ON ACTION open_axct312_01
               CALL axct312_03(g_xccw012_p)

               #END add-point
               EXIT DIALOG
            END IF
 
         ON ACTION axct322
            LET g_action_choice="axct322"
            IF cl_auth_chk_act("axct322") THEN
 
               #add-point:ON ACTION axct320
               CALL axct312_generate_xcdw()
               #END add-point
               EXIT DIALOG
            END IF
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL axct312_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
         #+ 此段落由子樣板a43產生
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axct312_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
         
         
         
         #+ 此段落由子樣板a46產生
         #新增相關文件
         ON ACTION related_document
            CALL axct312_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL axct312_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL axct312_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
         
         #主選單用ACTION
         &include "main_menu.4gl"
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
 
{<section id="axct312.browser_search" >}
#+ 瀏覽頁簽資料搜尋
PRIVATE FUNCTION axct312_browser_search(p_type)
   DEFINE p_type LIKE type_t.chr10
   #add-point:browser_search段define
   
   #end add-point    
   
   #若無輸入關鍵字則查找出所有資料
   IF NOT cl_null(g_searchstr) AND g_searchcol='0' THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "searchcol" 
      LET g_errparam.code   = "std-00005" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN FALSE 
   END IF 
   
   IF NOT cl_null(g_searchstr) THEN
      LET g_wc = " lower(", g_searchcol, ") LIKE '%", g_searchstr, "%'"
      LET g_wc = g_wc.toLowerCase()
   ELSE
      LET g_wc = " 1=1"
   END IF         
   
   #若為排序搜尋則添加以下條件
   IF cl_null(g_searchcol) OR g_searchcol = "0" THEN
      LET g_wc = g_wc, " ORDER BY xccwld"
   ELSE
      LET g_wc = g_wc, " ORDER BY ", g_searchcol
   END IF 
 
   CALL axct312_browser_fill("F")
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION axct312_browser_fill(ps_page_action)
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING
   #add-point:browser_fill段define
 
   #end add-point    
   
   #add-point:browser_fill段動作開始前
   IF cl_null(g_wc) THEN 
      IF g_xccw012_p = '1' THEN 
         LET g_wc = " AND xccw012 = '1' "
      END IF
      IF g_xccw012_p = '2' THEN 
         LET g_wc = " AND xccw012 = '2' "
      END IF
      IF g_xccw012_p = '3' THEN 
         LET g_wc = " AND xccw012 = '3' "
      END IF
      IF g_xccw012_p = '4' THEN 
         LET g_wc = " AND xccw012 = '4' "
      END IF
      IF g_xccw012_p = '5' THEN 
         LET g_wc = " AND xccw012 = '5' "
      END IF
   ELSE   
      IF g_xccw012_p = '1' THEN 
         LET g_wc = g_wc CLIPPED," AND xccw012 = '1' "
      END IF
      IF g_xccw012_p = '2' THEN 
         LET g_wc = g_wc CLIPPED," AND xccw012 = '2' "
      END IF
      IF g_xccw012_p = '3' THEN 
         LET g_wc = g_wc CLIPPED," AND xccw012 = '3' "
      END IF
      IF g_xccw012_p = '4' THEN 
         LET g_wc = g_wc CLIPPED," AND xccw012 = '4' "
      END IF
      IF g_xccw012_p = '5' THEN 
         LET g_wc = g_wc CLIPPED," AND xccw012 = '5' "
      END IF
   END IF
   #end add-point    
   
   CALL g_browser.clear()
 
   #搜尋用
   IF cl_null(g_searchcol) OR g_searchcol = '0' THEN
      LET l_searchcol = "xccwld"
   ELSE
      LET l_searchcol = g_searchcol
   END IF
   
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   IF cl_null(l_wc) THEN  #p_wc 查詢條件
      LET l_wc = " 1=1"
   END IF
   IF cl_null(l_wc2) THEN  #p_wc 查詢條件
      LET l_wc2 = " 1=1"
   END IF
   
   IF l_wc2 <> " 1=1" OR NOT cl_null(l_wc2) THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT UNIQUE xccwld ",
                      ", xccw003 ",
                      ", xccw004 ",
                      ", xccw005 ",
                      ", xccw006 ",
 
                      " FROM xccw_t ",
                      " ",
                    # " LEFT JOIN xcck_t ON xcckent = '"||g_enterprise||"' AND ",
 
                      " WHERE xccwent = '" ||g_enterprise|| "' AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("xccw_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT UNIQUE xccwld ",
                      ", xccw003 ",
                      ", xccw004 ",
                      ", xccw005 ",
                      ", xccw006 ",
 
                      " FROM xccw_t ",
                      " ",
                    #" LEFT JOIN xcck_t ON xcckent = '"||g_enterprise||"' AND ",
                      " WHERE xccwent = '" ||g_enterprise|| "' AND ",l_wc CLIPPED, cl_sql_add_filter("xccw_t")
   END IF 
   
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"
 
   #add-point:browser_fill,count前
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sub_sql = l_sub_sql , " AND xccwld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sub_sql = l_sub_sql," AND xccwcomp IN ",g_wc_cs_comp
   END IF  
   LET g_sql = " SELECT COUNT(*) FROM (",l_sub_sql,")"   
   #160802-00020#5-e-add
   #end add-point
   
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt   #總筆數
   FREE header_cnt_pre
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse AND g_error_show = 1 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_browser_cnt 
      LET g_errparam.code   = 9035
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET g_browser_cnt = g_max_browse
   END IF
   LET g_error_show = 0
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
 
   #依照t0.xccwld,t0.xccw003,t0.xccw004,t0.xccw005,t0.xccw006 Browser欄位定義(取代原本bs_sql功能)
   LET g_sql  = "SELECT DISTINCT t0.xccwld,t0.xccw003,t0.xccw004,t0.xccw005,t0.xccw006",
                " FROM xccw_t t0",
 
                
                " WHERE t0.xccwent = '" ||g_enterprise|| "' AND ", l_wc," AND ",l_wc2, cl_sql_add_filter("xccw_t")
 
   #add-point:browser_fill,sql_rank前
   #160802-00020#5-s-add
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND t0.xccwld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND t0.xccwcomp IN ",g_wc_cs_comp
   END IF  
   #160802-00020#5-e-add
   #end add-point
    
   #定義browser_fill sql
   LET g_sql= g_sql, " ORDER BY ",l_searchcol, " ", g_order
                
   #add-point:browser_fill,pre前

   #end add-point
   
   #LET g_sql = cl_sql_add_tabid(g_sql,"xccw_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   CALL g_browser.clear()
   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_xccwld,g_browser[g_cnt].b_xccw003,g_browser[g_cnt].b_xccw004, 
       g_browser[g_cnt].b_xccw005,g_browser[g_cnt].b_xccw006 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference

      #end add-point    
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   CALL g_browser.deleteElement(g_cnt)
   IF g_browser.getLength() = 0 AND l_wc THEN
      INITIALIZE g_xccw_m.* TO NULL
      CALL g_xccw_d.clear()
      CALL g_xccw2_d.clear()
      CALL g_xccw3_d.clear()
 
      #add-point:browser_fill段after_clear

      #end add-point 
      CLEAR FORM
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_rec_b = g_cnt - 1
   LET g_detail_cnt = g_rec_b
   LET g_cnt = 0
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", FALSE)
   ELSE
      CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   END IF
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION axct312_ui_headershow()
   #add-point:ui_headershow段define
   
   #end add-point    
   
   LET g_xccw_m.xccwld = g_browser[g_current_idx].b_xccwld   
   LET g_xccw_m.xccw003 = g_browser[g_current_idx].b_xccw003   
   LET g_xccw_m.xccw004 = g_browser[g_current_idx].b_xccw004   
   LET g_xccw_m.xccw005 = g_browser[g_current_idx].b_xccw005   
   LET g_xccw_m.xccw006 = g_browser[g_current_idx].b_xccw006   
 
   EXECUTE axct312_master_referesh USING g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
       g_xccw_m.xccw006 INTO g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
       g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003_desc
   CALL axct312_show()
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION axct312_ui_detailshow()
   #add-point:ui_detailshow段define
   
   #end add-point    
   
   #add-point:ui_detailshow段before
   
   #end add-point  
   
   IF g_curr_diag IS NOT NULL THEN
      CALL g_curr_diag.setCurrentRow("s_detail1",g_detail_idx)      
      CALL g_curr_diag.setCurrentRow("s_detail2",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail3",g_detail_idx)
 
      #add-point:ui_detailshow段more
      CALL g_curr_diag.setCurrentRow("s_detail4",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail5",g_detail_idx)
      CALL g_curr_diag.setCurrentRow("s_detail6",g_detail_idx)
      #end add-point 
   END IF
   
   #add-point:ui_detailshow段after
   
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION axct312_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_xccwld = g_xccw_m.xccwld 
         AND g_browser[l_i].b_xccw003 = g_xccw_m.xccw003 
         AND g_browser[l_i].b_xccw004 = g_xccw_m.xccw004 
         AND g_browser[l_i].b_xccw005 = g_xccw_m.xccw005 
         AND g_browser[l_i].b_xccw006 = g_xccw_m.xccw006 
 
         THEN  
         CALL g_browser.deleteElement(l_i)
         LET g_header_cnt = g_header_cnt - 1
      END IF
   END FOR
 
   LET g_browser_cnt = g_browser_cnt - 1
   IF g_current_row > g_browser_cnt THEN        #確定browse 筆數指在同一筆
      LET g_current_row = g_browser_cnt
   END IF
 
   DISPLAY g_browser_cnt TO FORMONLY.b_count    #總筆數的顯示
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數的顯示
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION axct312_construct()
   DEFINE ls_return   STRING
   DEFINE ls_result   STRING 
   DEFINE ls_wc       STRING 
   #add-point:cs段define

   #end add-point    
 
   #清除畫面上相關資料
   CLEAR FORM                 
   INITIALIZE g_xccw_m.* TO NULL
   CALL g_xccw_d.clear()
   CALL g_xccw2_d.clear()
   CALL g_xccw3_d.clear()
 
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   LET g_action_choice = ""
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段construct外

   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON xccwld,xccwcomp,xccw003,xccw012,xccw006,xccw013,xccw004,xccw005
 
         BEFORE CONSTRUCT
            #add-point:cs段more_construct
            #dorislai-20151026-add----(S)
            #預設當前site的法人,主帳套,年度期別,成本計算類型
            CALL s_axc_set_site_default() RETURNING g_xccw_m.xccwcomp,g_xccw_m.xccwld,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw003
            DISPLAY BY NAME g_xccw_m.xccwcomp,g_xccw_m.xccwld,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw003
            #dorislai-20151026-add----(E)
            #end add-point 
            
                 #Ctrlp:construct.c.xccwld
         ON ACTION controlp INFIELD xccwld
            #add-point:ON ACTION controlp INFIELD xccwld
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
            DISPLAY g_qryparam.return1 TO xccwld  #顯示到畫面上
            NEXT FIELD xccwld                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwld
            #add-point:BEFORE FIELD xccwld

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccwld
            
            #add-point:AFTER FIELD xccwld

            #END add-point
            
 
         #Ctrlp:construct.c.xccwcomp
         ON ACTION controlp INFIELD xccwcomp
            #add-point:ON ACTION controlp INFIELD xccwcomp
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
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccwcomp  #顯示到畫面上
            NEXT FIELD xccwcomp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwcomp
            #add-point:BEFORE FIELD xccwcomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccwcomp
            
            #add-point:AFTER FIELD xccwcomp

            #END add-point
            
 
         #Ctrlp:construct.c.xccw003
         ON ACTION controlp INFIELD xccw003
            #add-point:ON ACTION controlp INFIELD xccw003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw003  #顯示到畫面上
            NEXT FIELD xccw003                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw003
            #add-point:BEFORE FIELD xccw003

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw003
            
            #add-point:AFTER FIELD xccw003

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw012
            #add-point:BEFORE FIELD xccw012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw012
            
            #add-point:AFTER FIELD xccw012

            #END add-point
            
 
         #Ctrlp:construct.c.xccw012
         ON ACTION controlp INFIELD xccw012
            #add-point:ON ACTION controlp INFIELD xccw012

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw006
            #add-point:BEFORE FIELD xccw006

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw006
            
            #add-point:AFTER FIELD xccw006

            #END add-point
            
 
         #Ctrlp:construct.c.xccw006
         ON ACTION controlp INFIELD xccw006
            #add-point:ON ACTION controlp INFIELD xccw006
            #此段落由子樣板a08產生
            #開窗c段
#            INITIALIZE g_qryparam.* TO NULL
#            LET g_qryparam.state = 'c'
#            LET g_qryparam.reqry = FALSE 
#            LET g_qryparam.arg1 = '2'
#            CALL q_inbadocno_4()                           #呼叫開窗
#            DISPLAY g_qryparam.return1 TO xccw007  #顯示到畫面上
#            NEXT FIELD xccw007                     #返回原欄位
#140902
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE            
             #給予arg
               IF g_xccw012_p = '1' THEN 
                  LET g_qryparam.arg1 = '101'  #140902                  
               END IF
               IF g_xccw012_p = '2' THEN 
                  LET g_qryparam.arg1 = '301'                  
               END IF
               IF g_xccw012_p = '3' THEN 
                  LET g_qryparam.arg1 = '115'                  
               END IF
               IF g_xccw012_p = '5' THEN 
                  LET g_qryparam.arg1 = '401'                  
               END IF
               LET g_qryparam.arg2 = g_xccw_m.xccwcomp               
             
                     
            CALL q_inaj001_1()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw006  #顯示到畫面上
            NEXT FIELD xccw006                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw013
            #add-point:BEFORE FIELD xccw013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw013
            
            #add-point:AFTER FIELD xccw013

            #END add-point
            
 
         #Ctrlp:construct.c.xccw013
         ON ACTION controlp INFIELD xccw013
            #add-point:ON ACTION controlp INFIELD xccw013

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw004
            #add-point:BEFORE FIELD xccw004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw004
            
            #add-point:AFTER FIELD xccw004

            #END add-point
            
 
         #Ctrlp:construct.c.xccw004
         ON ACTION controlp INFIELD xccw004
            #add-point:ON ACTION controlp INFIELD xccw004

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw005
            #add-point:BEFORE FIELD xccw005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw005
            
            #add-point:AFTER FIELD xccw005

            #END add-point
            
 
         #Ctrlp:construct.c.xccw005
         ON ACTION controlp INFIELD xccw005
            #add-point:ON ACTION controlp INFIELD xccw005

            #END add-point
 
 
         
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table1 ON xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw015,xccw016, 
          xccw017,xccw009,xccw020,xccw021,inba004_desc,inbb020,inbb021,xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b, 
          xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw202,xccw202a,xccw202b,xccw202c,xccw202d, 
          xccw202e,xccw202f,xccw202g,xccw202h,xccw032,xccw033,xccw022,xccw023,xccw024, 
          xccw025,xccw026,xccw027,xccw028,xccw029,xccw030,xccw031
           FROM s_detail1[1].xccw001,s_detail1[1].xccw007,s_detail1[1].xccw008,s_detail1[1].xccw002, 
               s_detail1[1].xccwsite,s_detail1[1].xccw010,s_detail1[1].xccw011,s_detail1[1].xccw015, 
               s_detail1[1].xccw016,s_detail1[1].xccw017,s_detail1[1].xccw009,s_detail1[1].xccw020,s_detail1[1].xccw021,
               s_detail1[1].inba004_desc,s_detail1[1].inbb020,s_detail1[1].inbb021, #dorislai-20151005-add
               s_detail1[1].xccw043,s_detail1[1].xccw046,s_detail1[1].xccw044,s_detail1[1].xccw045,s_detail1[1].xccw201, 
               s_detail1[1].xccw282a,s_detail1[1].xccw282b,s_detail1[1].xccw282c,s_detail1[1].xccw282d, 
               s_detail1[1].xccw282e,s_detail1[1].xccw282f,s_detail1[1].xccw282g,s_detail1[1].xccw282h, 
               s_detail1[1].xccw202,s_detail1[1].xccw202a,s_detail1[1].xccw202b,s_detail1[1].xccw202c, 
               s_detail1[1].xccw202d,s_detail1[1].xccw202e,s_detail1[1].xccw202f,s_detail1[1].xccw202g, 
               s_detail1[1].xccw202h,s_detail3[1].xccw032, 
               s_detail3[1].xccw033,s_detail3[1].xccw022,s_detail3[1].xccw023,s_detail3[1].xccw024,s_detail3[1].xccw025, 
               s_detail3[1].xccw026,s_detail3[1].xccw027,s_detail3[1].xccw028,s_detail3[1].xccw029,s_detail3[1].xccw030, 
               s_detail3[1].xccw031
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #此段落由子樣板a01產生
         BEFORE FIELD xccw001
            #add-point:BEFORE FIELD xccw001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw001
            
            #add-point:AFTER FIELD xccw001

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw001
         ON ACTION controlp INFIELD xccw001
            #add-point:ON ACTION controlp INFIELD xccw001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw007
            #add-point:BEFORE FIELD xccw007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw007
            
            #add-point:AFTER FIELD xccw007

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw007
         ON ACTION controlp INFIELD xccw007
            #add-point:ON ACTION controlp INFIELD xccw007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw008
            #add-point:BEFORE FIELD xccw008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw008
            
            #add-point:AFTER FIELD xccw008

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw008
         ON ACTION controlp INFIELD xccw008
            #add-point:ON ACTION controlp INFIELD xccw008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw002
            #add-point:BEFORE FIELD xccw002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw002
            
            #add-point:AFTER FIELD xccw002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw002
         ON ACTION controlp INFIELD xccw002
            #add-point:ON ACTION controlp INFIELD xccw002

            #END add-point
 
         #Ctrlp:construct.c.page1.xccwsite
         ON ACTION controlp INFIELD xccwsite
            #add-point:ON ACTION controlp INFIELD xccwsite
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccwsite  #顯示到畫面上
            NEXT FIELD xccwsite                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwsite
            #add-point:BEFORE FIELD xccwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccwsite
            
            #add-point:AFTER FIELD xccwsite

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw010
            #add-point:BEFORE FIELD xccw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw010
            
            #add-point:AFTER FIELD xccw010

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw010
         ON ACTION controlp INFIELD xccw010
            #add-point:ON ACTION controlp INFIELD xccw010
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw010  #顯示到畫面上
            NEXT FIELD xccw010                     #返回原欄位
            #END add-point
 
         #Ctrlp:construct.c.page1.xccw011
         ON ACTION controlp INFIELD xccw011
            #add-point:ON ACTION controlp INFIELD xccw011
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcck011()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw011  #顯示到畫面上
            NEXT FIELD xccw011                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw011
            #add-point:BEFORE FIELD xccw011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw011
            
            #add-point:AFTER FIELD xccw011

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw015
            #add-point:BEFORE FIELD xccw015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw015
            
            #add-point:AFTER FIELD xccw015

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw015
         ON ACTION controlp INFIELD xccw015
            #add-point:ON ACTION controlp INFIELD xccw015
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw015  #顯示到畫面上
            NEXT FIELD xccw015                     #返回原欄位
    


            #END add-point
 
         #Ctrlp:construct.c.page1.xccw016
         ON ACTION controlp INFIELD xccw016
            #add-point:ON ACTION controlp INFIELD xccw016
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw016  #顯示到畫面上
            NEXT FIELD xccw016                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw016
            #add-point:BEFORE FIELD xccw016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw016
            
            #add-point:AFTER FIELD xccw016

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw017
            #add-point:BEFORE FIELD xccw017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw017
            
            #add-point:AFTER FIELD xccw017

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw017
         ON ACTION controlp INFIELD xccw017
            #add-point:ON ACTION controlp INFIELD xccw017
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw017  #顯示到畫面上
            NEXT FIELD xccw017                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw009
            #add-point:BEFORE FIELD xccw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw009
            
            #add-point:AFTER FIELD xccw009

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw009
         ON ACTION controlp INFIELD xccw009
            #add-point:ON ACTION controlp INFIELD xccw009

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw020
            #add-point:BEFORE FIELD xccw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw020
            
            #add-point:AFTER FIELD xccw020

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw020
         ON ACTION controlp INFIELD xccw020
            #add-point:ON ACTION controlp INFIELD xccw020
 
            #END add-point
 
         #Ctrlp:construct.c.page1.xccw021
         ON ACTION controlp INFIELD xccw021
            #add-point:ON ACTION controlp INFIELD xccw021
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '216'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw021  #顯示到畫面上
            NEXT FIELD xccw021                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw021
            #add-point:BEFORE FIELD xccw021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw021
            
            #add-point:AFTER FIELD xccw021

            #END add-point
            
         #Ctrlp:construct.c.page1.inba004_desc
         ON ACTION controlp INFIELD inba004_desc
            #add-point:ON ACTION controlp INFIELD inba004_desc
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inba004_desc #顯示到畫面上
            NEXT FIELD inba004_desc                    #返回原欄位
    
            #END add-point
   
         #此段落由子樣板a01產生
         BEFORE FIELD xccw043
            #add-point:BEFORE FIELD xccw043

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw043
            
            #add-point:AFTER FIELD xccw043

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw043
         ON ACTION controlp INFIELD xccw043
            #add-point:ON ACTION controlp INFIELD xccw043
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw043  #顯示到畫面上
            NEXT FIELD xccw043                     #返回原欄位
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw046
            #add-point:BEFORE FIELD xccw046

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw046
            
            #add-point:AFTER FIELD xccw046

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw046
         ON ACTION controlp INFIELD xccw046
            #add-point:ON ACTION controlp INFIELD xccw046

            #END add-point
 
         #Ctrlp:construct.c.page1.xccw044
         ON ACTION controlp INFIELD xccw044
            #add-point:ON ACTION controlp INFIELD xccw044
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw044  #顯示到畫面上
            NEXT FIELD xccw044                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw044
            #add-point:BEFORE FIELD xccw044

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw044
            
            #add-point:AFTER FIELD xccw044

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw045
            #add-point:BEFORE FIELD xccw045

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw045
            
            #add-point:AFTER FIELD xccw045

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw045
         ON ACTION controlp INFIELD xccw045
            #add-point:ON ACTION controlp INFIELD xccw045

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw201
            #add-point:BEFORE FIELD xccw201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw201
            
            #add-point:AFTER FIELD xccw201

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw201
         ON ACTION controlp INFIELD xccw201
            #add-point:ON ACTION controlp INFIELD xccw201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282a
            #add-point:BEFORE FIELD xccw282a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282a
            
            #add-point:AFTER FIELD xccw282a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282a
         ON ACTION controlp INFIELD xccw282a
            #add-point:ON ACTION controlp INFIELD xccw282a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282b
            #add-point:BEFORE FIELD xccw282b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282b
            
            #add-point:AFTER FIELD xccw282b

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282b
         ON ACTION controlp INFIELD xccw282b
            #add-point:ON ACTION controlp INFIELD xccw282b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282c
            #add-point:BEFORE FIELD xccw282c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282c
            
            #add-point:AFTER FIELD xccw282c

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282c
         ON ACTION controlp INFIELD xccw282c
            #add-point:ON ACTION controlp INFIELD xccw282c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282d
            #add-point:BEFORE FIELD xccw282d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282d
            
            #add-point:AFTER FIELD xccw282d

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282d
         ON ACTION controlp INFIELD xccw282d
            #add-point:ON ACTION controlp INFIELD xccw282d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282e
            #add-point:BEFORE FIELD xccw282e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282e
            
            #add-point:AFTER FIELD xccw282e

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282e
         ON ACTION controlp INFIELD xccw282e
            #add-point:ON ACTION controlp INFIELD xccw282e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282f
            #add-point:BEFORE FIELD xccw282f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282f
            
            #add-point:AFTER FIELD xccw282f

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282f
         ON ACTION controlp INFIELD xccw282f
            #add-point:ON ACTION controlp INFIELD xccw282f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282g
            #add-point:BEFORE FIELD xccw282g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282g
            
            #add-point:AFTER FIELD xccw282g

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282g
         ON ACTION controlp INFIELD xccw282g
            #add-point:ON ACTION controlp INFIELD xccw282g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282h
            #add-point:BEFORE FIELD xccw282h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282h
            
            #add-point:AFTER FIELD xccw282h

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282h
         ON ACTION controlp INFIELD xccw282h
            #add-point:ON ACTION controlp INFIELD xccw282h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282
            #add-point:BEFORE FIELD xccw282

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282
            
            #add-point:AFTER FIELD xccw282

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw282
         ON ACTION controlp INFIELD xccw282
            #add-point:ON ACTION controlp INFIELD xccw282

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202
            #add-point:BEFORE FIELD xccw202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202
            
            #add-point:AFTER FIELD xccw202

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202
         ON ACTION controlp INFIELD xccw202
            #add-point:ON ACTION controlp INFIELD xccw202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202a
            #add-point:BEFORE FIELD xccw202a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202a
            
            #add-point:AFTER FIELD xccw202a

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202a
         ON ACTION controlp INFIELD xccw202a
            #add-point:ON ACTION controlp INFIELD xccw202a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202b
            #add-point:BEFORE FIELD xccw202b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202b
            
            #add-point:AFTER FIELD xccw202b

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202b
         ON ACTION controlp INFIELD xccw202b
            #add-point:ON ACTION controlp INFIELD xccw202b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202c
            #add-point:BEFORE FIELD xccw202c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202c
            
            #add-point:AFTER FIELD xccw202c

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202c
         ON ACTION controlp INFIELD xccw202c
            #add-point:ON ACTION controlp INFIELD xccw202c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202d
            #add-point:BEFORE FIELD xccw202d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202d
            
            #add-point:AFTER FIELD xccw202d

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202d
         ON ACTION controlp INFIELD xccw202d
            #add-point:ON ACTION controlp INFIELD xccw202d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202e
            #add-point:BEFORE FIELD xccw202e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202e
            
            #add-point:AFTER FIELD xccw202e

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202e
         ON ACTION controlp INFIELD xccw202e
            #add-point:ON ACTION controlp INFIELD xccw202e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202f
            #add-point:BEFORE FIELD xccw202f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202f
            
            #add-point:AFTER FIELD xccw202f

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202f
         ON ACTION controlp INFIELD xccw202f
            #add-point:ON ACTION controlp INFIELD xccw202f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202g
            #add-point:BEFORE FIELD xccw202g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202g
            
            #add-point:AFTER FIELD xccw202g

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202g
         ON ACTION controlp INFIELD xccw202g
            #add-point:ON ACTION controlp INFIELD xccw202g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202h
            #add-point:BEFORE FIELD xccw202h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202h
            
            #add-point:AFTER FIELD xccw202h

            #END add-point
            
 
         #Ctrlp:construct.c.page1.xccw202h
         ON ACTION controlp INFIELD xccw202h
            #add-point:ON ACTION controlp INFIELD xccw202h

            #END add-point
 
         #Ctrlp:construct.c.page2.xcckowndp
         ON ACTION controlp INFIELD xcckowndp
            #add-point:ON ACTION controlp INFIELD xcckowndp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckowndp  #顯示到畫面上
            NEXT FIELD xcckowndp                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcckowndp
            #add-point:BEFORE FIELD xcckowndp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcckowndp
            
            #add-point:AFTER FIELD xcckowndp

            #END add-point
            
 
         #Ctrlp:construct.c.page2.xcckcrtid
         ON ACTION controlp INFIELD xcckcrtid
            #add-point:ON ACTION controlp INFIELD xcckcrtid
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcckcrtid  #顯示到畫面上
            NEXT FIELD xcckcrtid                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcckcrtid
            #add-point:BEFORE FIELD xcckcrtid

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcckcrtid
            
            #add-point:AFTER FIELD xcckcrtid

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw032
         ON ACTION controlp INFIELD xccw032
            #add-point:ON ACTION controlp INFIELD xccw032
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw032  #顯示到畫面上
            NEXT FIELD xccw032                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw032
            #add-point:BEFORE FIELD xccw032

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw032
            
            #add-point:AFTER FIELD xccw032

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw033
         ON ACTION controlp INFIELD xccw033
            #add-point:ON ACTION controlp INFIELD xccw033
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' "  #glac003(科目類型)
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw033  #顯示到畫面上
            NEXT FIELD xccw033                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw033
            #add-point:BEFORE FIELD xccw033

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw033
            
            #add-point:AFTER FIELD xccw033

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw022
         ON ACTION controlp INFIELD xccw022
            #add-point:ON ACTION controlp INFIELD xccw022
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw022  #顯示到畫面上
            NEXT FIELD xccw022                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw022
            #add-point:BEFORE FIELD xccw022

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw022
            
            #add-point:AFTER FIELD xccw022

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw023
         ON ACTION controlp INFIELD xccw023
            #add-point:ON ACTION controlp INFIELD xccw023
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '281'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw023  #顯示到畫面上
            NEXT FIELD xccw023                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw023
            #add-point:BEFORE FIELD xccw023

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw023
            
            #add-point:AFTER FIELD xccw023

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw024
         ON ACTION controlp INFIELD xccw024
            #add-point:ON ACTION controlp INFIELD xccw024
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '287'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw024  #顯示到畫面上
            NEXT FIELD xccw024                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw024
            #add-point:BEFORE FIELD xccw024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw024
            
            #add-point:AFTER FIELD xccw024

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw025
         ON ACTION controlp INFIELD xccw025
            #add-point:ON ACTION controlp INFIELD xccw025
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_8()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw025  #顯示到畫面上
            NEXT FIELD xccw025                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw025
            #add-point:BEFORE FIELD xccw025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw025
            
            #add-point:AFTER FIELD xccw025

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw026
         ON ACTION controlp INFIELD xccw026
            #add-point:ON ACTION controlp INFIELD xccw026
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '6013'
            CALL q_gzcb001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw026  #顯示到畫面上
            NEXT FIELD xccw026                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw026
            #add-point:BEFORE FIELD xccw026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw026
            
            #add-point:AFTER FIELD xccw026

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw027
         ON ACTION controlp INFIELD xccw027
            #add-point:ON ACTION controlp INFIELD xccw027
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2035'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw027  #顯示到畫面上
            NEXT FIELD xccw027                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw027
            #add-point:BEFORE FIELD xccw027

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw027
            
            #add-point:AFTER FIELD xccw027

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw028
         ON ACTION controlp INFIELD xccw028
            #add-point:ON ACTION controlp INFIELD xccw028
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw028  #顯示到畫面上
            NEXT FIELD xccw028                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw028
            #add-point:BEFORE FIELD xccw028

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw028
            
            #add-point:AFTER FIELD xccw028

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw029
         ON ACTION controlp INFIELD xccw029
            #add-point:ON ACTION controlp INFIELD xccw029
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw029  #顯示到畫面上
            NEXT FIELD xccw029                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw029
            #add-point:BEFORE FIELD xccw029

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw029
            
            #add-point:AFTER FIELD xccw029

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw030
         ON ACTION controlp INFIELD xccw030
            #add-point:ON ACTION controlp INFIELD xccw030
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw030  #顯示到畫面上
            NEXT FIELD xccw030                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw030
            #add-point:BEFORE FIELD xccw030

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw030
            
            #add-point:AFTER FIELD xccw030

            #END add-point
            
 
         #Ctrlp:construct.c.page3.xccw031
         ON ACTION controlp INFIELD xccw031
            #add-point:ON ACTION controlp INFIELD xccw031
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pjbb002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xccw031  #顯示到畫面上
            NEXT FIELD xccw031                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw031
            #add-point:BEFORE FIELD xccw031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw031
            
            #add-point:AFTER FIELD xccw031

            #END add-point
            
 
   
       
      END CONSTRUCT
  
 
  
      #add-point:cs段more_construct

      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:ui_dialog段b_dialog
         LET g_xccw_d[1].xccw007 = ""
         DISPLAY ARRAY g_xccw_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
   
   #add-point:cs段after_construct

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
 
{<section id="axct312.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION axct312_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point   
 
   #add-point:query開始前
   
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
   CALL g_xccw_d.clear()
   CALL g_xccw2_d.clear()
   CALL g_xccw3_d.clear()
 
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.b_index
   DISPLAY ' ' TO FORMONLY.b_count
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count
   
   CALL axct312_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL axct312_browser_fill(g_wc)
      CALL axct312_fetch("")
      RETURN
   END IF
   
   LET l_ac = 1
   LET g_detail_cnt = 0
   LET g_current_idx = 0
   LET g_current_row = 0
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   LET g_error_show = 1
   CALL axct312_browser_fill("F")
   
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
      CALL axct312_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION axct312_fetch(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point    
   
   #add-point:fetch段動作開始前
   
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
   
   CALL axct312_browser_fill(p_flag)
   
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
   LET g_browser_idx = g_pagestart+g_current_idx-1
   DISPLAY g_browser_idx TO FORMONLY.b_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數
   DISPLAY g_browser_idx TO FORMONLY.h_index   #當下筆數
   DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數
   
   CALL cl_navigator_setting( g_current_idx, g_detail_cnt )
   
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   LET g_xccw_m.xccwld = g_browser[g_current_idx].b_xccwld
   LET g_xccw_m.xccw003 = g_browser[g_current_idx].b_xccw003
   LET g_xccw_m.xccw004 = g_browser[g_current_idx].b_xccw004
   LET g_xccw_m.xccw005 = g_browser[g_current_idx].b_xccw005
   LET g_xccw_m.xccw006 = g_browser[g_current_idx].b_xccw006
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axct312_master_referesh USING g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
       g_xccw_m.xccw006 INTO g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
       g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003_desc
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccw_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      INITIALIZE g_xccw_m.* TO NULL
      RETURN
   END IF
   
   #LET g_data_owner =       
   #LET g_data_dept =   
   
   #保存單頭舊值
   LET g_xccw_m_t.* = g_xccw_m.*
   LET g_xccw_m_o.* = g_xccw_m.*
   
   #重新顯示   
   CALL axct312_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.insert" >}
#+ 資料新增
PRIVATE FUNCTION axct312_insert()
   #add-point:insert段define

   #end add-point    
   
   #add-point:insert段before
   CALL g_xccw4_d.clear()
   CALL g_xccw5_d.clear()
   CALL g_xccw6_d.clear()
   #end add-point    
   
   #清除相關資料
   CLEAR FORM                    
   CALL g_xccw_d.clear()
   CALL g_xccw2_d.clear()
   CALL g_xccw3_d.clear()
 
 
   INITIALIZE g_xccw_m.* LIKE xccw_t.*             #DEFAULT 設定
   LET g_xccwld_t = NULL
   LET g_xccw003_t = NULL
   LET g_xccw004_t = NULL
   LET g_xccw005_t = NULL
   LET g_xccw006_t = NULL
 
   CALL s_transaction_begin()
   WHILE TRUE
     
      #單頭預設值
      
     
      #add-point:單頭預設值
      DISPLAY g_xccw012_p
      IF g_xccw012_p = '1' THEN 
         LET g_xccw_m.xccw012 = '1'
      END IF
      IF g_xccw012_p = '2' THEN 
         LET g_xccw_m.xccw012 = '2'
      END IF
      IF g_xccw012_p = '3' THEN 
         LET g_xccw_m.xccw012 = '3'
      END IF
      IF g_xccw012_p = '4' THEN 
         LET g_xccw_m.xccw012 = '4'
      END IF
      IF g_xccw012_p = '5' THEN 
         LET g_xccw_m.xccw012 = '5'
      END IF
      LET g_xccw_m_t.* = g_xccw_m.*
      #预设当前site的法人，主账套，年度期别，成本计算类型
      CALL s_axc_set_site_default() RETURNING g_xccw_m.xccwcomp,g_xccw_m.xccwld,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw003
      DISPLAY BY NAME g_xccw_m.xccwcomp,g_xccw_m.xccwld,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw003
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xccw_m.xccwld
      CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xccw_m.xccwld_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xccw_m.xccwld_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xccw_m.xccwcomp
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xccw_m.xccwcomp_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xccw_m.xccwcomp_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_xccw_m.xccw003
      CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_xccw_m.xccw003_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_xccw_m.xccw003_desc
      #end add-point 
 
      CALL axct312_input("a")
      
      #add-point:單頭輸入後
 
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccw_m.* = g_xccw_m_t.*
         CALL axct312_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
#         INITIALIZE g_xccw_m.* TO NULL
         INITIALIZE g_xccw_d TO NULL
         INITIALIZE g_xccw2_d TO NULL
         INITIALIZE g_xccw3_d TO NULL
 
         CALL axct312_show()
         RETURN
      END IF
    
      #CALL g_xccw_d.clear()
      #CALL g_xccw2_d.clear()
      #CALL g_xccw3_d.clear()
 
      
      #add-point:單頭輸入後2
 
      #end add-point
 
      LET g_rec_b = 0
      EXIT WHILE
      
   END WHILE
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_xccwld_t = g_xccw_m.xccwld
   LET g_xccw003_t = g_xccw_m.xccw003
   LET g_xccw004_t = g_xccw_m.xccw004
   LET g_xccw005_t = g_xccw_m.xccw005
   LET g_xccw006_t = g_xccw_m.xccw006
 
   
   LET g_current_idx = g_browser.getLength() + 1
   LET g_browser[g_current_idx].b_xccwld = g_xccw_m.xccwld
   LET g_browser[g_current_idx].b_xccw003 = g_xccw_m.xccw003
   LET g_browser[g_current_idx].b_xccw004 = g_xccw_m.xccw004
   LET g_browser[g_current_idx].b_xccw005 = g_xccw_m.xccw005
   LET g_browser[g_current_idx].b_xccw006 = g_xccw_m.xccw006
 
   
   LET g_detail_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
   
   #LET g_wc = "(",g_wc,  
   #           " OR ( xccwent = '" ||g_enterprise|| "' AND ",
   #           " xccwld = '", g_xccw_m.xccwld CLIPPED, "' "
   #           ," AND xccw003 = '", g_xccw_m.xccw003 CLIPPED, "' "
   #           ," AND xccw004 = '", g_xccw_m.xccw004 CLIPPED, "' "
   #           ," AND xccw005 = '", g_xccw_m.xccw005 CLIPPED, "' "
   #           ," AND xccw006 = '", g_xccw_m.xccw006 CLIPPED, "' "
 
   #           , ")) "
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.modify" >}
#+ 資料修改
PRIVATE FUNCTION axct312_modify()
   #add-point:modify段define
   
   #end add-point    
   
   IF g_xccw_m.xccwld IS NULL
   OR g_xccw_m.xccw003 IS NULL
   OR g_xccw_m.xccw004 IS NULL
   OR g_xccw_m.xccw005 IS NULL
   OR g_xccw_m.xccw006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   EXECUTE axct312_master_referesh USING g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
       g_xccw_m.xccw006 INTO g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
       g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003_desc
 
   ERROR ""
  
   LET g_xccwld_t = g_xccw_m.xccwld
   LET g_xccw003_t = g_xccw_m.xccw003
   LET g_xccw004_t = g_xccw_m.xccw004
   LET g_xccw005_t = g_xccw_m.xccw005
   LET g_xccw006_t = g_xccw_m.xccw006
 
   CALL s_transaction_begin()
   
   OPEN axct312_cl USING g_enterprise,g_xccw_m.xccwld
                                                       ,g_xccw_m.xccw003
                                                       ,g_xccw_m.xccw004
                                                       ,g_xccw_m.xccw005
                                                       ,g_xccw_m.xccw006
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct312_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axct312_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axct312_cl INTO g_xccw_m.xccwld,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003,g_xccw_m.xccw003_desc,g_xccw_m.xccw012,g_xccw_m.xccw006,g_xccw_m.xccw013,g_xccw_m.xccw004, 
       g_xccw_m.xccw005,g_xccw_m.xcat003
 
   #資料被他人LOCK, 或是sql執行時出現錯誤
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccw_m.xccwld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CLOSE axct312_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   CALL s_transaction_end('Y','0')
 
   CALL axct312_show()
   WHILE TRUE
      LET g_xccwld_t = g_xccw_m.xccwld
      LET g_xccw003_t = g_xccw_m.xccw003
      LET g_xccw004_t = g_xccw_m.xccw004
      LET g_xccw005_t = g_xccw_m.xccw005
      LET g_xccw006_t = g_xccw_m.xccw006
 
 
      #add-point:modify段修改前
      
      #end add-point
      
      CALL axct312_input("u")     #欄位更改
      
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_xccw_m.* = g_xccw_m_t.*
         CALL axct312_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         EXIT WHILE
      END IF
      
      #若單頭key欄位有變更
      IF g_xccw_m.xccwld != g_xccwld_t 
      OR g_xccw_m.xccw003 != g_xccw003_t 
      OR g_xccw_m.xccw004 != g_xccw004_t 
      OR g_xccw_m.xccw005 != g_xccw005_t 
      OR g_xccw_m.xccw006 != g_xccw006_t 
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單頭(偽)修改前
         
         #end add-point
         
         #更新單頭key值
         UPDATE xccw_t SET xccwld = g_xccw_m.xccwld
                                       , xccw003 = g_xccw_m.xccw003
                                       , xccw004 = g_xccw_m.xccw004
                                       , xccw005 = g_xccw_m.xccw005
                                       , xccw006 = g_xccw_m.xccw006
 
          WHERE xccwent = g_enterprise AND xccwld = g_xccwld_t
            AND xccw003 = g_xccw003_t
            AND xccw004 = g_xccw004_t
            AND xccw005 = g_xccw005_t
            AND xccw006 = g_xccw006_t
 
         #add-point:單頭(偽)修改中
         
         #end add-point
         
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccw_t" 
               LET g_errparam.code   = "std-00009" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
            WHEN SQLCA.sqlcode #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccw_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')
               CONTINUE WHILE
         END CASE
 
 
         
         #add-point:單頭(偽)修改後
         
         #end add-point
         
      END IF
      
      EXIT WHILE
      
   END WHILE
 
   #修改歷程記錄
   #IF NOT cl_log_modified_record(g_xccw_m.xccwld,g_site) THEN 
   #   CALL s_transaction_end('N','0')
   #END IF
 
   CLOSE axct312_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-U
   CALL cl_flow_notify(g_xccw_m.xccwld,'U')
 
   CALL axct312_b_fill("1=1")
   
END FUNCTION   
 
{</section>}
 
{<section id="axct312.input" >}
#+ 資料輸入
PRIVATE FUNCTION axct312_input(p_cmd)
   DEFINE  p_cmd                 LIKE type_t.chr1
   DEFINE  l_cmd_t               LIKE type_t.chr1
   DEFINE  l_cmd                 LIKE type_t.chr1
   DEFINE  l_ac_t                LIKE type_t.num5                #未取消的ARRAY CNT 
   DEFINE  l_n                   LIKE type_t.num5                #檢查重複用  
   DEFINE  l_cnt                 LIKE type_t.num5                #檢查重複用  
   DEFINE  l_lock_sw             LIKE type_t.chr1                #單身鎖住否  
   DEFINE  l_allow_insert        LIKE type_t.num5                #可新增否 
   DEFINE  l_allow_delete        LIKE type_t.num5                #可刪除否  
   DEFINE  l_count               LIKE type_t.num5
   DEFINE  l_i                   LIKE type_t.num5
   DEFINE  l_insert              BOOLEAN
   DEFINE  ls_return             STRING
   DEFINE  l_var_keys            DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys          DYNAMIC ARRAY OF STRING
   DEFINE  l_vars                DYNAMIC ARRAY OF STRING
   DEFINE  l_fields              DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak        DYNAMIC ARRAY OF STRING
   DEFINE  lb_reproduce          BOOLEAN
   DEFINE  li_reproduce          LIKE type_t.num5
   DEFINE  li_reproduce_target   LIKE type_t.num5
   #add-point:input段define
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_flag                LIKE type_t.chr1       #檢核狀態
   DEFINE  l_errno               LIKE type_t.chr100     #錯誤訊息
   DEFINE  l_glav002             LIKE glav_t.glav002    #會計年度
   DEFINE  l_glav005             LIKE glav_t.glav005    #歸屬季別
   DEFINE  l_sdate_s             LIKE glav_t.glav004    #當季起始日
   DEFINE  l_sdate_e             LIKE glav_t.glav004    #當季截止日
   DEFINE  l_glav006             LIKE glav_t.glav006    #歸屬期別
   DEFINE  l_pdate_s             LIKE glav_t.glav004    #當期起始日
   DEFINE  l_pdate_e             LIKE glav_t.glav004    #當期截止日
   DEFINE  l_glav007             LIKE glav_t.glav007    #歸屬週別
   DEFINE  l_wdate_s             LIKE glav_t.glav004    #當週起始日
   DEFINE  l_wdate_e             LIKE glav_t.glav004    #當週截止日

   #end add-point    
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF  
 
   CALL cl_set_head_visible("","YES")  
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   #add-point:input段define_sql
   
   #end add-point 
   LET g_forupd_sql = "SELECT xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw015,xccw016, 
       xccw017,xccw009,xccw020,xccw021,xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c, 
       xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,xccw202d, 
       xccw202e,xccw202f,xccw202g,xccw202h,xccw001,xccw007,xccw008,xccw002,xccw010,xccw011,xccw001,xccw007, 
       xccw008,xccw002,xccwsite,xccw010,xccw011,xccw021,xccw032,xccw033,xccw022,xccw023,xccw024,xccw025, 
       xccw026,xccw027,xccw028,xccw029,xccw030,xccw031,xccw201,xccw282,xccw202,xccw009 FROM xccw_t WHERE  
       xccwent=? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001=?  
       AND xccw002=? AND xccw007=? AND xccw008=? AND xccw009=? FOR UPDATE"
   #add-point:input段define_sql
 
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axct312_bcl CURSOR FROM g_forupd_sql      # LOCK CURSOR
 
 
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL axct312_set_entry(p_cmd)
   #add-point:set_entry後

   #end add-point
   CALL axct312_set_no_entry(p_cmd)
   #add-point:set_no_entry後

   #end add-point
 
   DISPLAY BY NAME g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
       g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xcat003
   
   LET lb_reproduce = FALSE
   
   #add-point:進入修改段前
   LET g_errshow = 1
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="axct312.input.head" >}
   
      #單頭段
      INPUT BY NAME g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
          g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xcat003 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂單頭ACTION
         
         
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #add-point:單頭input前
            
            #end add-point
          
                  #此段落由子樣板a02產生
         AFTER FIELD xccwld
            
            #add-point:AFTER FIELD xccwld
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xccw_m.xccwld) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccw_m_t.xccwld IS NULL OR g_xccw_m.xccwld != g_xccw_m_t.xccwld)) THEN   #160824-00007#223 161202 by lori mark
               IF cl_null(g_xccw_m_o.xccwld) OR g_xccw_m.xccwld != g_xccw_m_o.xccwld THEN   #160824-00007#223 161202 by lori add
                  IF NOT axct312_chk_ld_comp() THEN
                    #160824-00007#223 161202 by lori mod---(S)
                    #LET g_xccw_m.xccwld = g_xccw_m_t.xccwld   
                     LET g_xccw_m.xccwld = g_xccw_m_o.xccwld   
                    #160824-00007#223 161202 by lori mod---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL axct312_show_ref()               
               CALL cl_get_para(g_enterprise,g_xccw_m.xccwcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否
               CALL cl_get_para(g_enterprise,g_xccw_m.xccwcomp,'S-FIN-6002') RETURNING g_para_data1  #成本域类型
               CALL axct312_visible()
            END IF
            IF  NOT cl_null(g_xccw_m.xccwld) AND NOT cl_null(g_xccw_m.xccw003) AND NOT cl_null(g_xccw_m.xccw004) AND NOT cl_null(g_xccw_m.xccw005) AND NOT cl_null(g_xccw_m.xccw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t  OR g_xccw_m.xccw004 != g_xccw004_t  OR g_xccw_m.xccw005 != g_xccw005_t  OR g_xccw_m.xccw006 != g_xccw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
            CALL axct312_show_ref()
            
            LET g_xccw_m_o.xccwld = g_xccw_m.xccwld   #160824-00007#223 161202 by lori add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwld
            #add-point:BEFORE FIELD xccwld
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccwld
            #add-point:ON CHANGE xccwld
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccwcomp
            
            #add-point:AFTER FIELD xccwcomp
             IF NOT cl_null(g_xccw_m.xccwcomp) THEN
              #IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_xccw_m_t.xccwcomp IS NULL OR g_xccw_m.xccwcomp != g_xccw_m_t.xccwcomp)) THEN   #160824-00007#223 161202 by lori mark
               IF cl_null(g_xccw_m_o.xccwcomp) OR g_xccw_m.xccwcomp != g_xccw_m_o.xccwcomp THEN #160824-00007#223 161202 by lori add
                  IF NOT axct312_chk_ld_comp() THEN
                    #160824-00007#223 161202 by lori mod---(S)
                    #LET g_xccw_m.xccwcomp = g_xccw_m_t.xccwcomp 
                     LET g_xccw_m.xccwcomp = g_xccw_m_o.xccwcomp  
                    #160824-00007#223 161202 by lori mod---(E)
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccw_m.xccwcomp
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw_m.xccwcomp_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccw_m.xccwcomp_desc

            LET g_xccw_m_o.xccwcomp = g_xccw_m.xccwcomp   #160824-00007#223 161202 by lori add
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwcomp
            #add-point:BEFORE FIELD xccwcomp
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccwcomp
            #add-point:ON CHANGE xccwcomp
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw003
            
            #add-point:AFTER FIELD xccw003
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_xccw_m.xccwld) AND NOT cl_null(g_xccw_m.xccw003) AND NOT cl_null(g_xccw_m.xccw004) AND NOT cl_null(g_xccw_m.xccw005) AND NOT cl_null(g_xccw_m.xccw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t  OR g_xccw_m.xccw004 != g_xccw004_t  OR g_xccw_m.xccw005 != g_xccw005_t  OR g_xccw_m.xccw006 != g_xccw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

      
            CALL axct312_show_ref()
            IF NOT cl_null(g_xccw_m.xccw003) THEN 
#此段落由子樣板a19產生
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
              
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_xccw_m.xccw003
              #160318-00025#12--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
              #160318-00025#12--add--end 
                 
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_xcat001") THEN
                 #檢查成功時後續處理
                 #LET  = g_chkparam.return1
                 #DISPLAY BY NAME 
                 IF g_xccw_m.xcat003 = '2' THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'axc-00229'
                    LET g_errparam.extend = g_xccw_m.xccw003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

#                    EXIT DIALOG
                    NEXT FIELD CURRENT
                 END IF
              ELSE
                 #檢查失敗時後續處理
                 LET g_xccw_m.xccw003 = g_xccw_m_t.xccw003
                 CALL axct312_show_ref()
                 NEXT FIELD CURRENT
              END IF
        
           END IF 
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw003
            #add-point:BEFORE FIELD xccw003
            
            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE xccw003
            #add-point:ON CHANGE xccw003
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw012
            #add-point:BEFORE FIELD xccw012
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw012
            
            #add-point:AFTER FIELD xccw012
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw012
            #add-point:ON CHANGE xccw012
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw006
            #add-point:BEFORE FIELD xccw006
            #在录入单号前，检查是否为实时成本   fengmy150427--b
            CALL axct312_show_ref()
            IF NOT cl_null(g_xccw_m.xccw003) THEN 
#此段落由子樣板a19產生
              #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
              INITIALIZE g_chkparam.* TO NULL
              
              #設定g_chkparam.*的參數
              LET g_chkparam.arg1 = g_xccw_m.xccw003
              #160318-00025#12--add--str
              LET g_errshow = TRUE 
              LET g_chkparam.err_str[1] = "agl-00195:sub-01302|axci100|",cl_get_progname("axci100",g_lang,"2"),"|:EXEPROGaxci100"
              #160318-00025#12--add--end
                 
              #呼叫檢查存在並帶值的library
              IF cl_chk_exist("v_xcat001") THEN
                 #檢查成功時後續處理
                 #LET  = g_chkparam.return1
                 #DISPLAY BY NAME 
                 IF g_xccw_m.xcat003 = '2' THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'axc-00229'
                    LET g_errparam.extend = g_xccw_m.xccw003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    #EXIT DIALOG
                    NEXT FIELD xccw003
                 END IF
              ELSE
                 #檢查失敗時後續處理
                 LET g_xccw_m.xccw003 = g_xccw_m_t.xccw003
                 CALL axct312_show_ref()
                 NEXT FIELD xccw003
              END IF
        
           END IF             
           #fengmy150427---e 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw006
            
            #add-point:AFTER FIELD xccw006
            IF cl_null(g_xccw_m.xccwcomp) THEN
               NEXT FIELD xccwld
            END IF
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_xccw_m.xccwld) AND NOT cl_null(g_xccw_m.xccw003) AND NOT cl_null(g_xccw_m.xccw004) AND NOT cl_null(g_xccw_m.xccw005) AND NOT cl_null(g_xccw_m.xccw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t  OR g_xccw_m.xccw004 != g_xccw004_t  OR g_xccw_m.xccw005 != g_xccw005_t  OR g_xccw_m.xccw006 != g_xccw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #140912
            
               IF NOT cl_null(g_xccw_m.xccw006) THEN 
#此段落由子樣板a19產生
                 #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                 INITIALIZE g_chkparam.* TO NULL
                 
                 #設定g_chkparam.*的參數
                 LET g_chkparam.arg1 = g_xccw_m.xccwcomp
                 LET g_chkparam.arg2 = g_xccw_m.xccw006
                 IF g_xccw012_p = '1' THEN    #雜收單據
                    LET g_chkparam.arg3 = '101'
                 END IF
                 IF g_xccw012_p = '2' THEN    #雜发單據
                    LET g_chkparam.arg3 = '301'
                 END IF
                 IF g_xccw012_p = '3' THEN    #雜收單據
                    LET g_chkparam.arg3 = '115'
                 END IF
                 IF g_xccw012_p = '5' THEN    #雜收單據
                    LET g_chkparam.arg3 = '401'
                 END IF
                    
                 #呼叫檢查存在並帶值的library
                 IF cl_chk_exist("v_inaj001") THEN
                    #檢查成功時後續處理                   
                    IF g_xccw012_p = '1' THEN    #雜收單據
                       SELECT inaj022 INTO g_xccw_m.xccw013 FROM inaj_t WHERE inajent = g_enterprise AND inaj001 = g_xccw_m.xccw006 AND inaj036='101'
                    END IF
                    IF g_xccw012_p = '2' THEN    #雜收單據
                       SELECT inaj022 INTO g_xccw_m.xccw013 FROM inaj_t WHERE inajent = g_enterprise AND inaj001 = g_xccw_m.xccw006 AND inaj036='301'
                    END IF
                    IF g_xccw012_p = '3' THEN    #雜收單據
                       SELECT inaj022 INTO g_xccw_m.xccw013 FROM inaj_t WHERE inajent = g_enterprise AND inaj001 = g_xccw_m.xccw006 AND inaj036='115'
                    END IF
                    IF g_xccw012_p = '5' THEN    #雜收單據
                       SELECT inaj022 INTO g_xccw_m.xccw013 FROM inaj_t WHERE inajent = g_enterprise AND inaj001 = g_xccw_m.xccw006 AND inaj036='401'
                    END IF
                    CALL s_fin_date_get_period_value('',g_xccw_m.xccwld,g_xccw_m.xccw013) RETURNING l_flag,g_xccw_m.xccw004,g_xccw_m.xccw005                    
                    DISPLAY g_xccw_m.xccw004 TO xccw004
                    DISPLAY g_xccw_m.xccw005 TO xccw005
                    
                    IF cl_null(g_xccw_m.xccw004) OR cl_null(g_xccw_m.xccw005) THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = 'axc-00230'
                       LET g_errparam.extend = g_xccw_m.xccw006
                       LET g_errparam.popup = TRUE
                       CALL cl_err()

                       LET g_xccw_m.xccw006 = g_xccw_m_t.xccw006
                       NEXT FIELD xccw006                
                    END IF
                 ELSE
                    #檢查失敗時後續處理
                    LET g_xccw_m.xccw006 = g_xccw_m_t.xccw006
                    LET g_xccw_m.xccw013 = g_xccw_m_t.xccw013
                    LET g_xccw_m.xccw004 = g_xccw_m_t.xccw004
                    LET g_xccw_m.xccw005 = g_xccw_m_t.xccw005
                    NEXT FIELD CURRENT
                 END IF
        
               END IF 
            

            IF p_cmd = 'a' AND l_cmd_t = 'a' AND NOT cl_null(g_xccw_m.xccw006) THEN
               IF cl_null(g_xccw_m.xccwcomp) THEN
                  NEXT FIELD xccwcomp
               END IF
               CALL axct312_xccw_ins_b()
               IF g_success = 'N' THEN
                  LET g_xccw_m.xccw006 = g_xccw_m_t.xccw006
                  NEXT FIELD xccw006   
               END IF
               CALL axct312_b_fill(g_wc2)
               NEXT FIELD xccw282a
            END IF

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw006
            #add-point:ON CHANGE xccw006
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw013
            #add-point:BEFORE FIELD xccw013
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw013
            
            #add-point:AFTER FIELD xccw013
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw013
            #add-point:ON CHANGE xccw013
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw004
            #add-point:BEFORE FIELD xccw004
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw004
            
            #add-point:AFTER FIELD xccw004
            #此段落由子樣板a05產生
             IF NOT cl_null(g_xccw_m.xccw004) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccw_m_t.xccw004 IS NULL OR g_xccw_m.xccw004 != g_xccw_m_t.xccw004)) THEN
                  IF NOT axct312_chk_year_period() THEN
                     LET g_xccw_m.xccw004 = g_xccw_m_t.xccw004
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            IF  NOT cl_null(g_xccw_m.xccwld) AND NOT cl_null(g_xccw_m.xccw003) AND NOT cl_null(g_xccw_m.xccw004) AND NOT cl_null(g_xccw_m.xccw005) AND NOT cl_null(g_xccw_m.xccw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t  OR g_xccw_m.xccw004 != g_xccw004_t  OR g_xccw_m.xccw005 != g_xccw005_t  OR g_xccw_m.xccw006 != g_xccw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw004
            #add-point:ON CHANGE xccw004
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw005
            #add-point:BEFORE FIELD xccw005
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw005
            
            #add-point:AFTER FIELD xccw005
            #此段落由子樣板a05產生
            IF NOT cl_null(g_xccw_m.xccw005) THEN
               IF p_cmd ='a' OR (p_cmd ='u' AND (g_xccw_m_t.xccw005 IS NULL OR g_xccw_m.xccw005 != g_xccw_m_t.xccw005)) THEN
                  IF NOT axct312_chk_year_period() THEN
                     LET g_xccw_m.xccw005 = g_xccw_m_t.xccw005
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            IF  NOT cl_null(g_xccw_m.xccwld) AND NOT cl_null(g_xccw_m.xccw003) AND NOT cl_null(g_xccw_m.xccw004) AND NOT cl_null(g_xccw_m.xccw005) AND NOT cl_null(g_xccw_m.xccw006) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t  OR g_xccw_m.xccw004 != g_xccw004_t  OR g_xccw_m.xccw005 != g_xccw005_t  OR g_xccw_m.xccw006 != g_xccw006_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw005
            #add-point:ON CHANGE xccw005
            
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xcat003
            #add-point:BEFORE FIELD xcat003
            
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xcat003
            
            #add-point:AFTER FIELD xcat003
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xcat003
            #add-point:ON CHANGE xcat003
            
            #END add-point
 
 #欄位檢查
                  #Ctrlp:input.c.xccwld
         ON ACTION controlp INFIELD xccwld
            #add-point:ON ACTION controlp INFIELD xccwld
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw_m.xccwld             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                 #呼叫開窗

            LET g_xccw_m.xccwld = g_qryparam.return1              
            CALL axct312_show_ref()
            DISPLAY g_xccw_m.xccwld TO xccwld              #

            NEXT FIELD xccwld                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xccwcomp
         ON ACTION controlp INFIELD xccwcomp
            #add-point:ON ACTION controlp INFIELD xccwcomp
            
            #END add-point
 
         #Ctrlp:input.c.xccw003
         ON ACTION controlp INFIELD xccw003
            #add-point:ON ACTION controlp INFIELD xccw003
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw_m.xccw003             #給予default值

            #給予arg

            
            CALL q_xcat001()                                #呼叫開窗

            LET g_xccw_m.xccw003 = g_qryparam.return1              
            CALL axct312_show_ref()
            DISPLAY g_xccw_m.xccw003 TO xccw003              #

            NEXT FIELD xccw003                          #返回原欄位


            #END add-point
 
         #Ctrlp:input.c.xccw012
         ON ACTION controlp INFIELD xccw012
            #add-point:ON ACTION controlp INFIELD xccw012
            
            #END add-point
 
         #Ctrlp:input.c.xccw006
         ON ACTION controlp INFIELD xccw006
            #add-point:ON ACTION controlp INFIELD xccw006
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw_m.xccw006             #給予default值
             
               #給予arg
               IF g_xccw012_p = '1' THEN 
                  LET g_qryparam.arg1 = '101'  #140902                  
               END IF
               IF g_xccw012_p = '2' THEN 
                  LET g_qryparam.arg1 = '301'                  
               END IF
               IF g_xccw012_p = '3' THEN 
                  LET g_qryparam.arg1 = '115'                  
               END IF
               IF g_xccw012_p = '5' THEN 
                  LET g_qryparam.arg1 = '401'                  
               END IF
               LET g_qryparam.arg2 = g_xccw_m.xccwcomp               
               LET g_qryparam.where = " NOT EXISTS (SELECT 1 FROM xccw_t WHERE xccw006 = inaj001) " 
               CALL q_inaj001_1()         


            LET g_xccw_m.xccw006 = g_qryparam.return1 
            LET g_xccw_m.xccw013 = g_qryparam.return2               

            DISPLAY g_xccw_m.xccw006 TO xccw006              #
            DISPLAY g_xccw_m.xccw013 TO xccw013
            NEXT FIELD xccw006                          #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.xccw013
         ON ACTION controlp INFIELD xccw013
            #add-point:ON ACTION controlp INFIELD xccw013
            
            #END add-point
 
         #Ctrlp:input.c.xccw004
         ON ACTION controlp INFIELD xccw004
            #add-point:ON ACTION controlp INFIELD xccw004
            
            #END add-point
 
         #Ctrlp:input.c.xccw005
         ON ACTION controlp INFIELD xccw005
            #add-point:ON ACTION controlp INFIELD xccw005
            
            #END add-point
 
         #Ctrlp:input.c.xcat003
         ON ACTION controlp INFIELD xcat003
            #add-point:ON ACTION controlp INFIELD xcat003
            
            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            IF s_transaction_chk("N",0) THEN
                CALL s_transaction_begin()
            END IF
 
            #多語言處理
            
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
            DISPLAY BY NAME g_xccw_m.xccwld             
                            ,g_xccw_m.xccw003   
                            ,g_xccw_m.xccw004   
                            ,g_xccw_m.xccw005   
                            ,g_xccw_m.xccw006   
 
 
            IF p_cmd = 'u' THEN
               #add-point:單頭修改前
               
               #end add-point
            
               UPDATE xccw_t SET (xccwld,xccwcomp,xccw003,xccw012,xccw006,xccw013,xccw004,xccw005) = (g_xccw_m.xccwld, 
                   g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006,g_xccw_m.xccw013, 
                   g_xccw_m.xccw004,g_xccw_m.xccw005)
                WHERE xccwent = g_enterprise AND xccwld = g_xccwld_t
                  AND xccw003 = g_xccw003_t
                  AND xccw004 = g_xccw004_t
                  AND xccw005 = g_xccw005_t
                  AND xccw006 = g_xccw006_t
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccw_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                     #資料多語言用-增/改
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccw_m.xccwld
               LET gs_keys_bak[1] = g_xccwld_t
               LET gs_keys[2] = g_xccw_m.xccw003
               LET gs_keys_bak[2] = g_xccw003_t
               LET gs_keys[3] = g_xccw_m.xccw004
               LET gs_keys_bak[3] = g_xccw004_t
               LET gs_keys[4] = g_xccw_m.xccw005
               LET gs_keys_bak[4] = g_xccw005_t
               LET gs_keys[5] = g_xccw_m.xccw006
               LET gs_keys_bak[5] = g_xccw006_t
               LET gs_keys[6] = g_xccw_d[g_detail_idx].xccw001
               LET gs_keys_bak[6] = g_xccw_d_t.xccw001
               LET gs_keys[7] = g_xccw_d[g_detail_idx].xccw002
               LET gs_keys_bak[7] = g_xccw_d_t.xccw002
               LET gs_keys[8] = g_xccw_d[g_detail_idx].xccw007
               LET gs_keys_bak[8] = g_xccw_d_t.xccw007
               LET gs_keys[9] = g_xccw_d[g_detail_idx].xccw008
               LET gs_keys_bak[9] = g_xccw_d_t.xccw008
               LET gs_keys[10] = g_xccw_d[g_detail_idx].xccw009
               LET gs_keys_bak[10] = g_xccw_d_t.xccw009
               CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'1'")
                     
                     LET g_xccwld_t = g_xccw_m.xccwld
                     LET g_xccw003_t = g_xccw_m.xccw003
                     LET g_xccw004_t = g_xccw_m.xccw004
                     LET g_xccw005_t = g_xccw_m.xccw005
                     LET g_xccw006_t = g_xccw_m.xccw006
 
                     #add-point:單頭修改後
                     
                     #end add-point
                     
                     LET g_log1 = util.JSON.stringify(g_xccw_m_t)
                     LET g_log2 = util.JSON.stringify(g_xccw_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     ELSE
                        CALL s_transaction_end('Y','0')
                     END IF
               END CASE
            
            ELSE    
               #add-point:單頭新增
               
               #end add-point
                                 
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL axct312_detail_reproduce()
               END IF
            END IF
           #controlp
                     
           LET g_xccwld_t = g_xccw_m.xccwld
           LET g_xccw003_t = g_xccw_m.xccw003
           LET g_xccw004_t = g_xccw_m.xccw004
           LET g_xccw005_t = g_xccw_m.xccw005
           LET g_xccw006_t = g_xccw_m.xccw006
 
           
           #若單身還沒有輸入資料, 強制切換至單身
           #IF cl_null(g_xccw_d[1].xccw001) THEN
           #   CALL g_xccw_d.deleteElement(1)
           #   NEXT FIELD xccw001
           #END IF
           
           IF g_xccw_d.getLength() = 0 THEN
              NEXT FIELD xccw001
           END IF
 
      END INPUT
 
{</section>}
 
{<section id="axct312.input.body" >}
      #Page1 預設值產生於此處
      INPUT ARRAY g_xccw_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE,
                  DELETE ROW = FALSE,
                  APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
 
         BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_xccw_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL axct312_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
         
         BEFORE ROW
            LET l_insert = FALSE
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
            
         
            CALL s_transaction_begin()
            
            #判定新增或修改
            IF l_cmd = 'u' THEN
               OPEN axct312_cl USING g_enterprise,
                                               g_xccw_m.xccwld
                                               ,g_xccw_m.xccw003
                                               ,g_xccw_m.xccw004
                                               ,g_xccw_m.xccw005
                                               ,g_xccw_m.xccw006
 
                                               
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct312_cl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  CLOSE axct312_cl
                  CALL s_transaction_end('N','0')
                  RETURN
               END IF
            END IF
            
            LET l_cmd = ''
            
            IF g_rec_b >= l_ac 
               AND g_xccw_d[l_ac].xccw001 IS NOT NULL
               AND g_xccw_d[l_ac].xccw002 IS NOT NULL
               AND g_xccw_d[l_ac].xccw007 IS NOT NULL
               AND g_xccw_d[l_ac].xccw008 IS NOT NULL
               AND g_xccw_d[l_ac].xccw009 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_xccw_d_t.* = g_xccw_d[l_ac].*  #BACKUP
               LET g_xccw_d_o.* = g_xccw_d[l_ac].*  #BACKUP
               CALL axct312_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct312_set_no_entry_b(l_cmd)
               OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                g_xccw_m.xccw003,
                                                g_xccw_m.xccw004,
                                                g_xccw_m.xccw005,
                                                g_xccw_m.xccw006,
 
                                                g_xccw_d_t.xccw001
                                                ,g_xccw_d_t.xccw002
                                                ,g_xccw_d_t.xccw007
                                                ,g_xccw_d_t.xccw008
                                                ,g_xccw_d_t.xccw009
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct312_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axct312_bcl INTO g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008, 
                      g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011, 
                      g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009, 
                      g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
                      g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
                      g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
                      g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282, 
                      g_xccw_d[l_ac].xccw202,g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c, 
                      g_xccw_d[l_ac].xccw202d,g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g, 
                      g_xccw_d[l_ac].xccw202h,g_xccw2_d[l_ac].xccw001,g_xccw2_d[l_ac].xccw007,g_xccw2_d[l_ac].xccw008, 
                      g_xccw2_d[l_ac].xccw002,g_xccw2_d[l_ac].xccw010,g_xccw2_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw001, 
                      g_xccw3_d[l_ac].xccw007,g_xccw3_d[l_ac].xccw008,g_xccw3_d[l_ac].xccw002,g_xccw3_d[l_ac].xccwsite, 
                      g_xccw3_d[l_ac].xccw010,g_xccw3_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw021,g_xccw3_d[l_ac].xccw032, 
                      g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024, 
                      g_xccw3_d[l_ac].xccw025,g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028, 
                      g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031,g_xccw3_d[l_ac].xccw201, 
                      g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202,g_xccw3_d[l_ac].xccw009
                  IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL 
                      LET g_errparam.extend = g_xccw_d_t.xccw001 
                      LET g_errparam.code   = SQLCA.sqlcode 
                      LET g_errparam.popup  = TRUE 
                      CALL cl_err()
 
                      LET l_lock_sw = "Y"
                  END IF
                  
                  CALL axct312_ref_show()
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row
            CALL axct312_b_fill_1(g_wc2)
            LET l_ac = ARR_CURR()
            #多个币种资料一起锁
            IF l_cmd='u' THEN
               IF g_glaa015 = 'Y' THEN
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '2'
                                                     ,g_xccw_d_t.xccw002
                                                     ,g_xccw_d_t.xccw007
                                                     ,g_xccw_d_t.xccw008
                                                     ,g_xccw_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
               IF g_glaa019 = 'Y' THEN
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '3'
                                                     ,g_xccw_d_t.xccw002
                                                     ,g_xccw_d_t.xccw007
                                                     ,g_xccw_d_t.xccw008
                                                     ,g_xccw_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            #end add-point  
            
        
         BEFORE INSERT
            
            INITIALIZE g_xccw_d_t.* TO NULL
            INITIALIZE g_xccw_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccw_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccw_d_t.* = g_xccw_d[l_ac].*     #新輸入資料
            LET g_xccw_d_o.* = g_xccw_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct312_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct312_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccw_d[li_reproduce_target].* = g_xccw_d[li_reproduce].*
               LET g_xccw2_d[li_reproduce_target].* = g_xccw2_d[li_reproduce].*
               LET g_xccw3_d[li_reproduce_target].* = g_xccw3_d[li_reproduce].*
 
               LET g_xccw_d[g_xccw_d.getLength()].xccw001 = NULL
               LET g_xccw_d[g_xccw_d.getLength()].xccw002 = NULL
               LET g_xccw_d[g_xccw_d.getLength()].xccw007 = NULL
               LET g_xccw_d[g_xccw_d.getLength()].xccw008 = NULL
               LET g_xccw_d[g_xccw_d.getLength()].xccw009 = NULL
 
            END IF
            
            #add-point:modify段before insert

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
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM xccw_t 
             WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
               AND xccw003 = g_xccw_m.xccw003
               AND xccw004 = g_xccw_m.xccw004
               AND xccw005 = g_xccw_m.xccw005
               AND xccw006 = g_xccw_m.xccw006
 
               AND xccw001 = g_xccw_d[l_ac].xccw001
               AND xccw002 = g_xccw_d[l_ac].xccw002
               AND xccw007 = g_xccw_d[l_ac].xccw007
               AND xccw008 = g_xccw_d[l_ac].xccw008
               AND xccw009 = g_xccw_d[l_ac].xccw009
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               CALL s_transaction_begin()
               #add-point:單身新增前

               #end add-point
               INSERT INTO xccw_t
                           (xccwent,
                            xccwld,xccwcomp,xccw003,xccw012,xccw006,xccw013,xccw004,xccw005,
                            xccw001,xccw002,xccw007,xccw008,xccw009
                            ,xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw020,xccw021,
                            xccw043,xccw046,xccw044,xccw045,xccw201,
                            xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,
                            xccw282,xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,
                            xccw202g,xccw202h,xccw010,xccw011,xccwsite,xccw010,xccw011,xccw021,xccw032,
                            xccw033,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,xccw029,
                            xccw030,xccw031,xccw201,xccw282,xccw202) 
                     VALUES(g_enterprise,
                            g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006,g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,
                            g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008, 
                                g_xccw_d[l_ac].xccw009
                            ,g_xccw_d[l_ac].xccwsite,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw015, 
                                g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw020, 
                                g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
                                g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201, 
                                g_xccw_d[l_ac].xccw282a,g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c, 
                                g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e,g_xccw_d[l_ac].xccw282f, 
                                g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282, 
                                g_xccw_d[l_ac].xccw202,g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b, 
                                g_xccw_d[l_ac].xccw202c,g_xccw_d[l_ac].xccw202d,g_xccw_d[l_ac].xccw202e, 
                                g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g,g_xccw_d[l_ac].xccw202h, 
                                g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccwsite, 
                                g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw021, 
                                g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022, 
                                g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024,g_xccw3_d[l_ac].xccw025, 
                                g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028, 
                                g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031, 
                                g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282,g_xccw_d[l_ac].xccw202) 
 
               #add-point:單身新增中

               #end add-point
               LET p_cmd = 'u'
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code   = "std-00006" 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               INITIALIZE g_xccw_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "xccw_t" 
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               #資料多語言用-增/改
               
               #add-point:input段-after_insert

               #end add-point
               CALL s_transaction_end('Y','0')
               ERROR "INSERT O.K"
               LET g_rec_b=g_rec_b+1
               DISPLAY g_rec_b TO FORMONLY.cnt
            END IF
            
            #add-point:單身新增後

            #end add-point
              
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' THEN
               LET l_cmd='d'
            ELSE
               #add-point:單身刪除前
               CALL s_transaction_begin()  #140909
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
               IF axct312_before_delete() THEN 
                  
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct312_bcl
               LET l_count = g_xccw_d.getLength()
            END IF 
            
            #add-point:單身刪除後

            #end add-point
              
         AFTER DELETE 
            IF l_cmd <> 'd' THEN
               #add-point:單身AFTER DELETE 

               #end add-point
            END IF
            #如果是最後一筆
            IF l_ac = (g_xccw_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
            
                  #此段落由子樣板a01產生
         BEFORE FIELD xccw001
            #add-point:BEFORE FIELD xccw001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw001
            
            #add-point:AFTER FIELD xccw001
            #此段落由子樣板a05產生
            IF  g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccw003 IS NOT NULL AND g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL AND g_xccw_m.xccw006 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw001 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw010 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw007 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw008 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t OR g_xccw_m.xccw003 != g_xccw003_t OR g_xccw_m.xccw004 != g_xccw004_t OR g_xccw_m.xccw005 != g_xccw005_t OR g_xccw_m.xccw006 != g_xccw006_t OR g_xccw_d[g_detail_idx].xccw001 != g_xccw_d_t.xccw001 OR g_xccw_d[g_detail_idx].xccw010 != g_xccw_d_t.xccw010 OR g_xccw_d[g_detail_idx].xccw007 != g_xccw_d_t.xccw007 OR g_xccw_d[g_detail_idx].xccw008 != g_xccw_d_t.xccw008 OR g_xccw_d[g_detail_idx].xccw002 != g_xccw_d_t.xccw002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"' AND "|| "xccw001 = '"||g_xccw_d[g_detail_idx].xccw001 ||"' AND "|| "xccw010 = '"||g_xccw_d[g_detail_idx].xccw010 ||"' AND "|| "xccw007 = '"||g_xccw_d[g_detail_idx].xccw007 ||"' AND "|| "xccw008 = '"||g_xccw_d[g_detail_idx].xccw009 ||"' AND "|| "xccw002 = '"||g_xccw_d[g_detail_idx].xccw002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw001
            #add-point:ON CHANGE xccw001

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw007
            #add-point:BEFORE FIELD xccw007

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw007
            
            #add-point:AFTER FIELD xccw007
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccw003 IS NOT NULL AND g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL AND g_xccw_m.xccw006 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw001 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw002 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw007 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw008 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw009 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t OR g_xccw_m.xccw003 != g_xccw003_t OR g_xccw_m.xccw004 != g_xccw004_t OR g_xccw_m.xccw005 != g_xccw005_t OR g_xccw_m.xccw006 != g_xccw006_t OR g_xccw_d[g_detail_idx].xccw001 != g_xccw_d_t.xccw001 OR g_xccw_d[g_detail_idx].xccw002 != g_xccw_d_t.xccw002 OR g_xccw_d[g_detail_idx].xccw007 != g_xccw_d_t.xccw007 OR g_xccw_d[g_detail_idx].xccw008 != g_xccw_d_t.xccw008 OR g_xccw_d[g_detail_idx].xccw009 != g_xccw_d_t.xccw009)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"' AND "|| "xccw001 = '"||g_xccw_d[g_detail_idx].xccw001 ||"' AND "|| "xccw002 = '"||g_xccw_d[g_detail_idx].xccw002 ||"' AND "|| "xccw007 = '"||g_xccw_d[g_detail_idx].xccw007 ||"' AND "|| "xccw008 = '"||g_xccw_d[g_detail_idx].xccw008 ||"' AND "|| "xccw009 = '"||g_xccw_d[g_detail_idx].xccw009 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw007
            #add-point:ON CHANGE xccw007

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw008
            #add-point:BEFORE FIELD xccw008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw008
            
            #add-point:AFTER FIELD xccw008
            #此段落由子樣板a05產生
            IF  g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccw003 IS NOT NULL AND g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL AND g_xccw_m.xccw006 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw001 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw010 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw007 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw008 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t OR g_xccw_m.xccw004 != g_xccw004_t OR g_xccw_m.xccw005 != g_xccw005_t OR g_xccw_m.xccw006 != g_xccw006_t OR g_xccw_d[g_detail_idx].xccw001 != g_xccw_d_t.xccw001 OR g_xccw_d[g_detail_idx].xccw010 != g_xccw_d_t.xccw010 OR g_xccw_d[g_detail_idx].xccw007 != g_xccw_d_t.xccw007 OR g_xccw_d[g_detail_idx].xccw008 != g_xccw_d_t.xccw008 OR g_xccw_d[g_detail_idx].xccw002 != g_xccw_d_t.xccw002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"' AND "|| "xccw001 = '"||g_xccw_d[g_detail_idx].xccw001 ||"' AND "|| "xccw010 = '"||g_xccw_d[g_detail_idx].xccw010 ||"' AND "|| "xccw007 = '"||g_xccw_d[g_detail_idx].xccw007 ||"' AND "|| "xccw008 = '"||g_xccw_d[g_detail_idx].xccw008 ||"' AND "|| "xccw002 = '"||g_xccw_d[g_detail_idx].xccw002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw008
            #add-point:ON CHANGE xccw008

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw002
            #add-point:BEFORE FIELD xccw002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw002
            
            #add-point:AFTER FIELD xccw002
            #此段落由子樣板a05產生
            IF  g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccw003 IS NOT NULL AND g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL AND g_xccw_m.xccw006 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw001 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw010 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw007 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw008 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t OR g_xccw_m.xccw004 != g_xccw004_t OR g_xccw_m.xccw005 != g_xccw005_t OR g_xccw_m.xccw006 != g_xccw006_t OR g_xccw_d[g_detail_idx].xccw001 != g_xccw_d_t.xccw001 OR g_xccw_d[g_detail_idx].xccw010 != g_xccw_d_t.xccw010 OR g_xccw_d[g_detail_idx].xccw007 != g_xccw_d_t.xccw007 OR g_xccw_d[g_detail_idx].xccw008 != g_xccw_d_t.xccw008 OR g_xccw_d[g_detail_idx].xccw002 != g_xccw_d_t.xccw002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"' AND "|| "xccw001 = '"||g_xccw_d[g_detail_idx].xccw001 ||"' AND "|| "xccw010 = '"||g_xccw_d[g_detail_idx].xccw010 ||"' AND "|| "xccw007 = '"||g_xccw_d[g_detail_idx].xccw007 ||"' AND "|| "xccw008 = '"||g_xccw_d[g_detail_idx].xccw008 ||"' AND "|| "xccw002 = '"||g_xccw_d[g_detail_idx].xccw002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw002
            #add-point:ON CHANGE xccw002

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccwsite
            #add-point:BEFORE FIELD xccwsite

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccwsite
            
            #add-point:AFTER FIELD xccwsite

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccwsite
            #add-point:ON CHANGE xccwsite

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw010
            #add-point:BEFORE FIELD xccw010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw010
            
            #add-point:AFTER FIELD xccw010
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw010
            #add-point:ON CHANGE xccw010

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw011
            #add-point:BEFORE FIELD xccw011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw011
            
            #add-point:AFTER FIELD xccw011

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw011
            #add-point:ON CHANGE xccw011

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw015
            #add-point:BEFORE FIELD xccw015

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw015
            
            #add-point:AFTER FIELD xccw015
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw015
            #add-point:ON CHANGE xccw015

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw016
            #add-point:BEFORE FIELD xccw016

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw016
            
            #add-point:AFTER FIELD xccw016
             
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw016
            #add-point:ON CHANGE xccw016

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw017
            #add-point:BEFORE FIELD xccw017

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw017
            
            #add-point:AFTER FIELD xccw017

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw017
            #add-point:ON CHANGE xccw017

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw009
            #add-point:BEFORE FIELD xccw009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw009
            
            #add-point:AFTER FIELD xccw009
            #此段落由子樣板a05產生
            IF  g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccw003 IS NOT NULL AND g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL AND g_xccw_m.xccw006 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw001 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw010 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw007 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw008 IS NOT NULL AND g_xccw_d[g_detail_idx].xccw002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xccw_m.xccwld != g_xccwld_t  OR g_xccw_m.xccw003 != g_xccw003_t OR g_xccw_m.xccw004 != g_xccw004_t OR g_xccw_m.xccw005 != g_xccw005_t OR g_xccw_m.xccw006 != g_xccw006_t OR g_xccw_d[g_detail_idx].xccw001 != g_xccw_d_t.xccw001 OR g_xccw_d[g_detail_idx].xccw010 != g_xccw_d_t.xccw010 OR g_xccw_d[g_detail_idx].xccw007 != g_xccw_d_t.xccw007 OR g_xccw_d[g_detail_idx].xccw008 != g_xccw_d_t.xccw008 OR g_xccw_d[g_detail_idx].xccw002 != g_xccw_d_t.xccw002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xccw_t WHERE "||"xccwent = '" ||g_enterprise|| "' AND "||"xccwld = '"||g_xccw_m.xccwld ||"' AND "|| "xccw003 = '"||g_xccw_m.xccw003 ||"' AND "|| "xccw004 = '"||g_xccw_m.xccw004 ||"' AND "|| "xccw005 = '"||g_xccw_m.xccw005 ||"' AND "|| "xccw006 = '"||g_xccw_m.xccw006 ||"' AND "|| "xccw001 = '"||g_xccw_d[g_detail_idx].xccw001 ||"' AND "|| "xccw010 = '"||g_xccw_d[g_detail_idx].xccw010 ||"' AND "|| "xccw007 = '"||g_xccw_d[g_detail_idx].xccw007 ||"' AND "|| "xccw008 = '"||g_xccw_d[g_detail_idx].xccw008 ||"' AND "|| "xccw002 = '"||g_xccw_d[g_detail_idx].xccw002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw009
            #add-point:ON CHANGE xccw009

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw020
            #add-point:BEFORE FIELD xccw020

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw020
            
            #add-point:AFTER FIELD xccw020

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw020
            #add-point:ON CHANGE xccw020

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw021
            #add-point:BEFORE FIELD xccw021

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw021
            
            #add-point:AFTER FIELD xccw021
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw021
            #add-point:ON CHANGE xccw021

            #END add-point
                  
         #此段落由子樣板a01產生
         BEFORE FIELD xccw043
            #add-point:BEFORE FIELD xccw043

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw043
            
            #add-point:AFTER FIELD xccw043

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw043
            #add-point:ON CHANGE xccw043

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw046
            #add-point:BEFORE FIELD xccw046

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw046
            
            #add-point:AFTER FIELD xccw046

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw046
            #add-point:ON CHANGE xccw046

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw044
            #add-point:BEFORE FIELD xccw044

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw044
            
            #add-point:AFTER FIELD xccw044

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw044
            #add-point:ON CHANGE xccw044

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw045
            #add-point:BEFORE FIELD xccw045

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw045
            
            #add-point:AFTER FIELD xccw045

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw045
            #add-point:ON CHANGE xccw045

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw201
            #add-point:BEFORE FIELD xccw201

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw201
            
            #add-point:AFTER FIELD xccw201

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw201
            #add-point:ON CHANGE xccw201

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282a
            #add-point:BEFORE FIELD xccw282a
 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282a
            
            #add-point:AFTER FIELD xccw282a
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282a,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282a
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282a) THEN 
               LET g_xccw_d[l_ac].xccw202a = g_xccw_d[l_ac].xccw282a * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
                #避免尾差，成本总量用加总的方式
                LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282a <> g_xccw_d_t.xccw282a THEN 
               LET g_xccw4_d[l_ac].xccw282a = g_xccw_d[l_ac].xccw282a * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202a = g_xccw_d[l_ac].xccw202a * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042  
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                             g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                             g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                             g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h
                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                              g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                              g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                              g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                 LET g_xccw6_d[l_ac].xccw282a = g_xccw_d[l_ac].xccw282a * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202a = g_xccw_d[l_ac].xccw202a * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042  
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                             g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                             g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                             g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h
                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                              g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                              g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                              g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h                                              
            END IF
            IF g_xccw_d[l_ac].xccw282a <> g_xccw_d_t.xccw282a THEN 
               LET g_xccw5_d[l_ac].xccw282a = g_xccw_d[l_ac].xccw282a * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202a = g_xccw_d[l_ac].xccw202a * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042 
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                             g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                             g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                             g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h
                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                              g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                              g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                              g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h               
            END IF
            #截位          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
            IF g_glaa019 = 'Y' THEN                               
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
            END IF
            IF g_glaa015 = 'Y' THEN                      
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202a            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            #282 202
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282a
            #add-point:ON CHANGE xccw282a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282b
            #add-point:BEFORE FIELD xccw282b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282b
            
            #add-point:AFTER FIELD xccw282b
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282b,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282b
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282b) THEN 
               LET g_xccw_d[l_ac].xccw202b = g_xccw_d[l_ac].xccw282b * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
                LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282b <> g_xccw_d_t.xccw282b THEN 
               LET g_xccw4_d[l_ac].xccw282b = g_xccw_d[l_ac].xccw282b * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202b = g_xccw_d[l_ac].xccw202b * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                             g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                             g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                             g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h
               LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
               LET g_xccw6_d[l_ac].xccw282b = g_xccw_d[l_ac].xccw282b * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202b = g_xccw_d[l_ac].xccw202b * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                             g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                             g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                             g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h
               LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282b <> g_xccw_d_t.xccw282b THEN 
               LET g_xccw5_d[l_ac].xccw282b = g_xccw_d[l_ac].xccw282b * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202b = g_xccw_d[l_ac].xccw202b * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                             g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                             g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                             g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h
               LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                     #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
             
            IF g_glaa019 = 'Y' THEN           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202b            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202   
            END IF
            
     
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
           #CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282b
            #add-point:ON CHANGE xccw282b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282c
            #add-point:BEFORE FIELD xccw282c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282c
            
            #add-point:AFTER FIELD xccw282c
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282c,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282c
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282c) THEN 
               LET g_xccw_d[l_ac].xccw202c = g_xccw_d[l_ac].xccw282c * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
                LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h

            END IF
            IF g_xccw_d[l_ac].xccw282c <> g_xccw_d_t.xccw282c THEN 
               LET g_xccw4_d[l_ac].xccw282c = g_xccw_d[l_ac].xccw282c * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202c = g_xccw_d[l_ac].xccw202c * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                LET g_xccw6_d[l_ac].xccw282c = g_xccw_d[l_ac].xccw282c * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202c = g_xccw_d[l_ac].xccw202c * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282c <> g_xccw_d_t.xccw282c THEN 
               LET g_xccw5_d[l_ac].xccw282c = g_xccw_d[l_ac].xccw282c * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202c = g_xccw_d[l_ac].xccw202c * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                           g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                           g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                           g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

               LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
            #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282c           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202c           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
            
            IF g_glaa019 = 'Y' THEN            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282c           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202c           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282c            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202c            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282c
            #add-point:ON CHANGE xccw282c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282d
            #add-point:BEFORE FIELD xccw282d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282d
            
            #add-point:AFTER FIELD xccw282d
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282d,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282d
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282d) THEN 
               LET g_xccw_d[l_ac].xccw202d = g_xccw_d[l_ac].xccw282d * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
                LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h

            END IF
            IF g_xccw_d[l_ac].xccw282d <> g_xccw_d_t.xccw282d THEN 
               LET g_xccw4_d[l_ac].xccw282d = g_xccw_d[l_ac].xccw282d * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202d = g_xccw_d[l_ac].xccw202d * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
                LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                LET g_xccw6_d[l_ac].xccw282d = g_xccw_d[l_ac].xccw282d * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202d = g_xccw_d[l_ac].xccw202d * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
                LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282d <> g_xccw_d_t.xccw282d THEN 
               LET g_xccw5_d[l_ac].xccw282d = g_xccw_d[l_ac].xccw282d * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202d = g_xccw_d[l_ac].xccw202d * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
                LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                      #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
             
            IF g_glaa019 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282d           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202d            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN                    
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282d            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202d            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282d
            #add-point:ON CHANGE xccw282d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282e
            #add-point:BEFORE FIELD xccw282e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282e
            
            #add-point:AFTER FIELD xccw282e
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282e,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282e
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282e) THEN 
               LET g_xccw_d[l_ac].xccw202e = g_xccw_d[l_ac].xccw282e * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h

            END IF
            IF g_xccw_d[l_ac].xccw282e <> g_xccw_d_t.xccw282e THEN 
               LET g_xccw4_d[l_ac].xccw282e = g_xccw_d[l_ac].xccw282e * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202e = g_xccw_d[l_ac].xccw202e * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                LET g_xccw6_d[l_ac].xccw282e = g_xccw_d[l_ac].xccw282e * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202e = g_xccw_d[l_ac].xccw202e * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282e <> g_xccw_d_t.xccw282e THEN 
               LET g_xccw5_d[l_ac].xccw282e = g_xccw_d[l_ac].xccw282e * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202e = g_xccw_d[l_ac].xccw202e * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                        #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
            
            IF g_glaa019 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202e            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282e
            #add-point:ON CHANGE xccw282e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282f
            #add-point:BEFORE FIELD xccw282f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282f
            
            #add-point:AFTER FIELD xccw282f
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282f,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282f
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282f) THEN 
               LET g_xccw_d[l_ac].xccw202f = g_xccw_d[l_ac].xccw282f * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282f <> g_xccw_d_t.xccw282f THEN 
               LET g_xccw4_d[l_ac].xccw282f = g_xccw_d[l_ac].xccw282f * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202f = g_xccw_d[l_ac].xccw202f * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                 LET g_xccw6_d[l_ac].xccw282f = g_xccw_d[l_ac].xccw282f * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202f = g_xccw_d[l_ac].xccw202f * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282f <> g_xccw_d_t.xccw282f THEN 
               LET g_xccw5_d[l_ac].xccw282f = g_xccw_d[l_ac].xccw282f * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202f = g_xccw_d[l_ac].xccw202f * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                        #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282f            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202f            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
           
            IF g_glaa019 = 'Y' THEN                      
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282f            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202f           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
            END IF
            IF g_glaa015 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282f            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202f                       
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282f
            #add-point:ON CHANGE xccw282f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282g
            #add-point:BEFORE FIELD xccw282g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282g
            
            #add-point:AFTER FIELD xccw282g
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282g,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282g
            END IF
            #160510-00037#1
            IF NOT cl_null(g_xccw_d[l_ac].xccw282g) THEN 
               LET g_xccw_d[l_ac].xccw202g = g_xccw_d[l_ac].xccw282g * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282g <> g_xccw_d_t.xccw282g THEN 
               LET g_xccw4_d[l_ac].xccw282g = g_xccw_d[l_ac].xccw282g * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202g = g_xccw_d[l_ac].xccw202g * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                                             
               LET g_xccw6_d[l_ac].xccw282g = g_xccw_d[l_ac].xccw282g * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202g = g_xccw_d[l_ac].xccw202g * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282g <> g_xccw_d_t.xccw282g THEN 
               LET g_xccw5_d[l_ac].xccw282g = g_xccw_d[l_ac].xccw282g * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202g = g_xccw_d[l_ac].xccw202g * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                        #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282g            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282                                                     
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202g                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
            
            IF g_glaa019 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282g            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282                                                    
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202g                               
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
            END IF
            IF g_glaa015 = 'Y' THEN                      
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282g           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282                                                     
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202g                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282g
            #add-point:ON CHANGE xccw282g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282h
            #add-point:BEFORE FIELD xccw282h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282h
            
            #add-point:AFTER FIELD xccw282h
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw_d[l_ac].xccw282h,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282h
            END IF
            #160510-00037#1            
            IF NOT cl_null(g_xccw_d[l_ac].xccw282h) THEN 
               LET g_xccw_d[l_ac].xccw202h = g_xccw_d[l_ac].xccw282h * g_xccw_d[l_ac].xccw201
               LET g_xccw_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282a + g_xccw_d[l_ac].xccw282b +
                                            g_xccw_d[l_ac].xccw282c + g_xccw_d[l_ac].xccw282d +
                                            g_xccw_d[l_ac].xccw282e + g_xccw_d[l_ac].xccw282f +
                                            g_xccw_d[l_ac].xccw282g + g_xccw_d[l_ac].xccw282h
#               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
                LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202a + g_xccw_d[l_ac].xccw202b +
                                             g_xccw_d[l_ac].xccw202c + g_xccw_d[l_ac].xccw202d +
                                             g_xccw_d[l_ac].xccw202e + g_xccw_d[l_ac].xccw202f +
                                             g_xccw_d[l_ac].xccw202g + g_xccw_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282h <> g_xccw_d_t.xccw282h THEN 
               LET g_xccw4_d[l_ac].xccw282h = g_xccw_d[l_ac].xccw282h * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw202h = g_xccw_d[l_ac].xccw202h * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
                                            g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
                                            g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
                                            g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h

                LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
                               LET g_xccw6_d[l_ac].xccw282h = g_xccw_d[l_ac].xccw282h * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw202h = g_xccw_d[l_ac].xccw202h * g_xccw6_d[l_ac].xccw042
#               LET g_xccw6_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw042    
#               LET g_xccw6_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw6_d[l_ac].xccw042
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282h <> g_xccw_d_t.xccw282h THEN 
               LET g_xccw5_d[l_ac].xccw282h = g_xccw_d[l_ac].xccw282h * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202h = g_xccw_d[l_ac].xccw202h * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                        #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282                                                     
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
             
            IF g_glaa019 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282                                                      
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282                                                    
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282h
            #add-point:ON CHANGE xccw282h

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw282
            #add-point:BEFORE FIELD xccw282

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw282
            
            #add-point:AFTER FIELD xccw282
            IF NOT cl_null(g_xccw_d[l_ac].xccw282) THEN 
               LET g_xccw_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw282 * g_xccw_d[l_ac].xccw201
            END IF
            IF g_xccw_d[l_ac].xccw282 <> g_xccw_d_t.xccw282 THEN 
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw042    
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw4_d[l_ac].xccw042

               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                            g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                            g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                            g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h

                LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
            END IF
            IF g_xccw_d[l_ac].xccw282 <> g_xccw_d_t.xccw282 THEN 
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
                               LET g_xccw5_d[l_ac].xccw282h = g_xccw_d[l_ac].xccw282h * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw202h = g_xccw_d[l_ac].xccw202h * g_xccw5_d[l_ac].xccw042
#               LET g_xccw5_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw042    
#               LET g_xccw5_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202 * g_xccw5_d[l_ac].xccw042
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                            g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                            g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                            g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h

                LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
            END IF
                        #截位          
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
           
            IF g_glaa019 = 'Y' THEN                     
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN                    
            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282            
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202
            END IF
            LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282
            LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
#            CALL axct312_update()
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw282
            #add-point:ON CHANGE xccw282

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202
            #add-point:BEFORE FIELD xccw202

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202
            
            #add-point:AFTER FIELD xccw202

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202
            #add-point:ON CHANGE xccw202

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202a
            #add-point:BEFORE FIELD xccw202a

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202a
            
            #add-point:AFTER FIELD xccw202a

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202a
            #add-point:ON CHANGE xccw202a

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202b
            #add-point:BEFORE FIELD xccw202b

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202b
            
            #add-point:AFTER FIELD xccw202b

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202b
            #add-point:ON CHANGE xccw202b

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202c
            #add-point:BEFORE FIELD xccw202c

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202c
            
            #add-point:AFTER FIELD xccw202c

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202c
            #add-point:ON CHANGE xccw202c

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202d
            #add-point:BEFORE FIELD xccw202d

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202d
            
            #add-point:AFTER FIELD xccw202d

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202d
            #add-point:ON CHANGE xccw202d

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202e
            #add-point:BEFORE FIELD xccw202e

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202e
            
            #add-point:AFTER FIELD xccw202e

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202e
            #add-point:ON CHANGE xccw202e

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202f
            #add-point:BEFORE FIELD xccw202f

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202f
            
            #add-point:AFTER FIELD xccw202f

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202f
            #add-point:ON CHANGE xccw202f

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202g
            #add-point:BEFORE FIELD xccw202g

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202g
            
            #add-point:AFTER FIELD xccw202g

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202g
            #add-point:ON CHANGE xccw202g

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD xccw202h
            #add-point:BEFORE FIELD xccw202h

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw202h
            
            #add-point:AFTER FIELD xccw202h

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw202h
            #add-point:ON CHANGE xccw202h

            #END add-point
 
 
                  #Ctrlp:input.c.page1.xccw001
         ON ACTION controlp INFIELD xccw001
            #add-point:ON ACTION controlp INFIELD xccw001

            #END add-point
 
         #Ctrlp:input.c.page1.xccw007
         ON ACTION controlp INFIELD xccw007
            #add-point:ON ACTION controlp INFIELD xccw007

            #END add-point
 
         #Ctrlp:input.c.page1.xccw008
         ON ACTION controlp INFIELD xccw008
            #add-point:ON ACTION controlp INFIELD xccw008

            #END add-point
 
         #Ctrlp:input.c.page1.xccw002
         ON ACTION controlp INFIELD xccw002
            #add-point:ON ACTION controlp INFIELD xccw002

            #END add-point
 
         #Ctrlp:input.c.page1.xccwsite
         ON ACTION controlp INFIELD xccwsite
            #add-point:ON ACTION controlp INFIELD xccwsite

            #END add-point
 
         #Ctrlp:input.c.page1.xccw010
         ON ACTION controlp INFIELD xccw010
            #add-point:ON ACTION controlp INFIELD xccw010

            #END add-point
 
         #Ctrlp:input.c.page1.xccw011
         ON ACTION controlp INFIELD xccw011
            #add-point:ON ACTION controlp INFIELD xccw011

            #END add-point
 
         #Ctrlp:input.c.page1.xccw015
         ON ACTION controlp INFIELD xccw015
            #add-point:ON ACTION controlp INFIELD xccw015

            #END add-point
 
         #Ctrlp:input.c.page1.xccw016
         ON ACTION controlp INFIELD xccw016
            #add-point:ON ACTION controlp INFIELD xccw016

            #END add-point
 
         #Ctrlp:input.c.page1.xccw017
         ON ACTION controlp INFIELD xccw017
            #add-point:ON ACTION controlp INFIELD xccw017

            #END add-point
 
         #Ctrlp:input.c.page1.xccw009
         ON ACTION controlp INFIELD xccw009
            #add-point:ON ACTION controlp INFIELD xccw009

            #END add-point
 
         #Ctrlp:input.c.page1.xccw020
         ON ACTION controlp INFIELD xccw020
            #add-point:ON ACTION controlp INFIELD xccw020

            #END add-point
 
         #Ctrlp:input.c.page1.xccw021
         ON ACTION controlp INFIELD xccw021
            #add-point:ON ACTION controlp INFIELD xccw021

            #END add-point
         
         #Ctrlp:input.c.page1.xccw021
         ON ACTION controlp INFIELD inba004_desc
            #add-point:ON ACTION controlp INFIELD inba004_desc
 
            #END add-point
         
         #Ctrlp:input.c.page1.xccw043
         ON ACTION controlp INFIELD xccw043
            #add-point:ON ACTION controlp INFIELD xccw043

            #END add-point
 
         #Ctrlp:input.c.page1.xccw046
         ON ACTION controlp INFIELD xccw046
            #add-point:ON ACTION controlp INFIELD xccw046

            #END add-point
 
         #Ctrlp:input.c.page1.xccw044
         ON ACTION controlp INFIELD xccw044
            #add-point:ON ACTION controlp INFIELD xccw044

            #END add-point
 
         #Ctrlp:input.c.page1.xccw045
         ON ACTION controlp INFIELD xccw045
            #add-point:ON ACTION controlp INFIELD xccw045

            #END add-point
 
         #Ctrlp:input.c.page1.xccw201
         ON ACTION controlp INFIELD xccw201
            #add-point:ON ACTION controlp INFIELD xccw201

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282a
         ON ACTION controlp INFIELD xccw282a
            #add-point:ON ACTION controlp INFIELD xccw282a

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282b
         ON ACTION controlp INFIELD xccw282b
            #add-point:ON ACTION controlp INFIELD xccw282b

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282c
         ON ACTION controlp INFIELD xccw282c
            #add-point:ON ACTION controlp INFIELD xccw282c

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282d
         ON ACTION controlp INFIELD xccw282d
            #add-point:ON ACTION controlp INFIELD xccw282d

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282e
         ON ACTION controlp INFIELD xccw282e
            #add-point:ON ACTION controlp INFIELD xccw282e

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282f
         ON ACTION controlp INFIELD xccw282f
            #add-point:ON ACTION controlp INFIELD xccw282f

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282g
         ON ACTION controlp INFIELD xccw282g
            #add-point:ON ACTION controlp INFIELD xccw282g

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282h
         ON ACTION controlp INFIELD xccw282h
            #add-point:ON ACTION controlp INFIELD xccw282h

            #END add-point
 
         #Ctrlp:input.c.page1.xccw282
         ON ACTION controlp INFIELD xccw282
            #add-point:ON ACTION controlp INFIELD xccw282

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202
         ON ACTION controlp INFIELD xccw202
            #add-point:ON ACTION controlp INFIELD xccw202

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202a
         ON ACTION controlp INFIELD xccw202a
            #add-point:ON ACTION controlp INFIELD xccw202a

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202b
         ON ACTION controlp INFIELD xccw202b
            #add-point:ON ACTION controlp INFIELD xccw202b

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202c
         ON ACTION controlp INFIELD xccw202c
            #add-point:ON ACTION controlp INFIELD xccw202c

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202d
         ON ACTION controlp INFIELD xccw202d
            #add-point:ON ACTION controlp INFIELD xccw202d

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202e
         ON ACTION controlp INFIELD xccw202e
            #add-point:ON ACTION controlp INFIELD xccw202e

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202f
         ON ACTION controlp INFIELD xccw202f
            #add-point:ON ACTION controlp INFIELD xccw202f

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202g
         ON ACTION controlp INFIELD xccw202g
            #add-point:ON ACTION controlp INFIELD xccw202g

            #END add-point
 
         #Ctrlp:input.c.page1.xccw202h
         ON ACTION controlp INFIELD xccw202h
            #add-point:ON ACTION controlp INFIELD xccw202h

            #END add-point
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
 
               LET INT_FLAG = 0
               LET g_xccw_d[l_ac].* = g_xccw_d_t.*
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccw_d[l_ac].xccw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
 
               LET g_xccw_d[l_ac].* = g_xccw_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
            
               #add-point:單身修改前
               IF 1=2 THEN 
               #end add-point
         
               UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
                   xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw009,xccw020,xccw021,
                   xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c,xccw282d,
                   xccw282e,xccw282f,xccw282g,xccw282h,xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,
                   xccw202f,xccw202g,xccw202h,xccw032,xccw033,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028, 
                   xccw029,xccw030,xccw031) = (g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
                   g_xccw_m.xccw006,g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008, 
                   g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011, 
                   g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009, 
                   g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
                   g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
                   g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
                   g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw202, 
                   g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c,g_xccw_d[l_ac].xccw202d, 
                   g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g,g_xccw_d[l_ac].xccw202h, 
                   g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023, 
                   g_xccw3_d[l_ac].xccw024,g_xccw3_d[l_ac].xccw025,g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027, 
                   g_xccw3_d[l_ac].xccw028,g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031) 
 
                WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld 
                 AND xccw003 = g_xccw_m.xccw003 
                 AND xccw004 = g_xccw_m.xccw004 
                 AND xccw005 = g_xccw_m.xccw005 
                 AND xccw006 = g_xccw_m.xccw006 
 
                 AND xccw001 = g_xccw_d_t.xccw001 #項次   
                 AND xccw002 = g_xccw_d_t.xccw002  
                 AND xccw007 = g_xccw_d_t.xccw007  
                 AND xccw008 = g_xccw_d_t.xccw008  
                 AND xccw009 = g_xccw_d_t.xccw009  
 
                 
               #add-point:單身修改中
               ELSE
                  CALL s_transaction_begin()  #140909
                  
                             #截位           
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282f
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282g
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202f                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202g                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa001,g_xccw_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw_d[l_ac].xccw202
           
            IF g_glaa019 = 'Y' THEN       
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282f
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282g
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202f                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202g                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa020,g_xccw5_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw5_d[l_ac].xccw202
             END IF
            IF g_glaa015 = 'Y' THEN       
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282a,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282b,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282c,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282d,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282e,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282f,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282f
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282g,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282g
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282h,4) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw282,4)  RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw282
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202a,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202a
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202b,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202b
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202c,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202c
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202d,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202d
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202e,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202e
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202f,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202f                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202g,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202g                                          
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202h,5) RETURNING g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202h
            CALL s_curr_round_ld(1,g_xccw_m.xccwld,g_glaa016,g_xccw6_d[l_ac].xccw202,5) RETURNING  g_sub_success,g_errno,g_xccw6_d[l_ac].xccw202             
            END IF
            IF cl_null(g_xccw_d[l_ac].xccw002)  THEN LET g_xccw_d[l_ac].xccw002 = ' ' END IF
                  IF cl_null(g_xccw_d[l_ac].xccw201)  THEN LET g_xccw_d[l_ac].xccw201 = 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282a) THEN LET g_xccw_d[l_ac].xccw282a= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282b) THEN LET g_xccw_d[l_ac].xccw282b= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282c) THEN LET g_xccw_d[l_ac].xccw282c= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282d) THEN LET g_xccw_d[l_ac].xccw282d= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282e) THEN LET g_xccw_d[l_ac].xccw282e= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282f) THEN LET g_xccw_d[l_ac].xccw282f= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282g) THEN LET g_xccw_d[l_ac].xccw282g= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282h) THEN LET g_xccw_d[l_ac].xccw282h= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw282)  THEN LET g_xccw_d[l_ac].xccw282 = 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202a) THEN LET g_xccw_d[l_ac].xccw202a= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202b) THEN LET g_xccw_d[l_ac].xccw202b= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202c) THEN LET g_xccw_d[l_ac].xccw202c= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202d) THEN LET g_xccw_d[l_ac].xccw202d= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202e) THEN LET g_xccw_d[l_ac].xccw202e= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202f) THEN LET g_xccw_d[l_ac].xccw202f= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202g) THEN LET g_xccw_d[l_ac].xccw202g= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202h) THEN LET g_xccw_d[l_ac].xccw202h= 0 END IF
                  IF cl_null(g_xccw_d[l_ac].xccw202)  THEN LET g_xccw_d[l_ac].xccw202 = 0 END IF 
                  IF cl_null(g_xccw6_d[l_ac].xccw201)  THEN LET g_xccw6_d[l_ac].xccw201 = 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282a) THEN LET g_xccw6_d[l_ac].xccw282a= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282b) THEN LET g_xccw6_d[l_ac].xccw282b= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282c) THEN LET g_xccw6_d[l_ac].xccw282c= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282d) THEN LET g_xccw6_d[l_ac].xccw282d= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282e) THEN LET g_xccw6_d[l_ac].xccw282e= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282f) THEN LET g_xccw6_d[l_ac].xccw282f= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282g) THEN LET g_xccw6_d[l_ac].xccw282g= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282h) THEN LET g_xccw6_d[l_ac].xccw282h= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw282)  THEN LET g_xccw6_d[l_ac].xccw282 = 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202a) THEN LET g_xccw6_d[l_ac].xccw202a= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202b) THEN LET g_xccw6_d[l_ac].xccw202b= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202c) THEN LET g_xccw6_d[l_ac].xccw202c= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202d) THEN LET g_xccw6_d[l_ac].xccw202d= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202e) THEN LET g_xccw6_d[l_ac].xccw202e= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202f) THEN LET g_xccw6_d[l_ac].xccw202f= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202g) THEN LET g_xccw6_d[l_ac].xccw202g= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202h) THEN LET g_xccw6_d[l_ac].xccw202h= 0 END IF
                  IF cl_null(g_xccw6_d[l_ac].xccw202)  THEN LET g_xccw6_d[l_ac].xccw202 = 0 END IF 
                  IF cl_null(g_xccw5_d[l_ac].xccw201)  THEN LET g_xccw5_d[l_ac].xccw201 = 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282a) THEN LET g_xccw5_d[l_ac].xccw282a= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282b) THEN LET g_xccw5_d[l_ac].xccw282b= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282c) THEN LET g_xccw5_d[l_ac].xccw282c= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282d) THEN LET g_xccw5_d[l_ac].xccw282d= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282e) THEN LET g_xccw5_d[l_ac].xccw282e= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282f) THEN LET g_xccw5_d[l_ac].xccw282f= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282g) THEN LET g_xccw5_d[l_ac].xccw282g= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282h) THEN LET g_xccw5_d[l_ac].xccw282h= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw282)  THEN LET g_xccw5_d[l_ac].xccw282 = 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202a) THEN LET g_xccw5_d[l_ac].xccw202a= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202b) THEN LET g_xccw5_d[l_ac].xccw202b= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202c) THEN LET g_xccw5_d[l_ac].xccw202c= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202d) THEN LET g_xccw5_d[l_ac].xccw202d= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202e) THEN LET g_xccw5_d[l_ac].xccw202e= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202f) THEN LET g_xccw5_d[l_ac].xccw202f= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202g) THEN LET g_xccw5_d[l_ac].xccw202g= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202h) THEN LET g_xccw5_d[l_ac].xccw202h= 0 END IF
                  IF cl_null(g_xccw5_d[l_ac].xccw202)  THEN LET g_xccw5_d[l_ac].xccw202 = 0 END IF 
                  UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
                      xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw020,xccw021,xccw043,xccw046,xccw044, 
                      xccw045,xccw201,xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282, 
                      xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw_m.xccwld, 
                      g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw006, g_xccw_d[l_ac].xccw001,
                      g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008,g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite, 
                      g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017, 
                      g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
                      g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
                      g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
                      g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282,g_xccw_d[l_ac].xccw202, 
                      g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c,g_xccw_d[l_ac].xccw202d, 
                      g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g,g_xccw_d[l_ac].xccw202h 
                      )
                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld 
                    AND xccw003 = g_xccw_m.xccw003 
                    AND xccw004 = g_xccw_m.xccw004 
                    AND xccw005 = g_xccw_m.xccw005 
                    AND xccw006 = g_xccw_m.xccw006 
                   
                    AND xccw001 = g_xccw_d_t.xccw001 #項次   
                    AND xccw002 = g_xccw_d_t.xccw002  
                    AND xccw007 = g_xccw_d_t.xccw007  
                    AND xccw008 = g_xccw_d_t.xccw008  
                    AND xccw009 = g_xccw_d_t.xccw009 
                    AND xccw001 = '1'
                    
                    
               END IF
               LET g_xccw3_d[l_ac].xccw282 = g_xccw_d[l_ac].xccw282 
               LET g_xccw3_d[l_ac].xccw202 = g_xccw_d[l_ac].xccw202
               DISPLAY BY NAME g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202
               CALL axct312_update()
               #end add-point
               
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "xccw_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
 
                     CALL s_transaction_end('N','0')
                  #WHEN SQLCA.sqlcode #其他錯誤
                  #   INITIALIZE g_errparam TO NULL 
                  #   LET g_errparam.extend = "xccw_t" 
                  #   LET g_errparam.code   = SQLCA.sqlcode 
                  #   LET g_errparam.popup  = TRUE 
                  #   CALL cl_err()
 
                  #   CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_xccw_m.xccwld
               LET gs_keys_bak[1] = g_xccwld_t
               LET gs_keys[2] = g_xccw_m.xccw003
               LET gs_keys_bak[2] = g_xccw003_t
               LET gs_keys[3] = g_xccw_m.xccw004
               LET gs_keys_bak[3] = g_xccw004_t
               LET gs_keys[4] = g_xccw_m.xccw005
               LET gs_keys_bak[4] = g_xccw005_t
               LET gs_keys[5] = g_xccw_m.xccw006
               LET gs_keys_bak[5] = g_xccw006_t
               LET gs_keys[6] = g_xccw_d[g_detail_idx].xccw001
               LET gs_keys_bak[6] = g_xccw_d_t.xccw001
               LET gs_keys[7] = g_xccw_d[g_detail_idx].xccw002
               LET gs_keys_bak[7] = g_xccw_d_t.xccw002
               LET gs_keys[8] = g_xccw_d[g_detail_idx].xccw007
               LET gs_keys_bak[8] = g_xccw_d_t.xccw007
               LET gs_keys[9] = g_xccw_d[g_detail_idx].xccw008
               LET gs_keys_bak[9] = g_xccw_d_t.xccw008
               LET gs_keys[10] = g_xccw_d[g_detail_idx].xccw009
               LET gs_keys_bak[10] = g_xccw_d_t.xccw009
               CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'1'")
                     #資料多語言用-增/改
                     
                     LET g_log1 = util.JSON.stringify(g_xccw_m),util.JSON.stringify(g_xccw_d_t)
                     LET g_log2 = util.JSON.stringify(g_xccw_m),util.JSON.stringify(g_xccw_d[l_ac])
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                        CALL s_transaction_end('N','0')
                     END IF
               END CASE
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
 
         AFTER INPUT
            #若單身還沒有輸入資料, 強制切換至單身
            IF g_xccw_d.getLength() = 0 THEN
               NEXT FIELD xccw001
            END IF
            #add-point:input段after input 
            
            #end add-point    
            
         ON ACTION controlo   
            CALL FGL_SET_ARR_CURR(g_xccw_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccw_d.getLength()+1
            
      END INPUT
 
      INPUT ARRAY g_xccw3_d FROM s_detail3.*
         ATTRIBUTE(COUNT = g_rec_b, WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct312_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN             
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
 
         BEFORE ROW 
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()                #returns the current row
            IF l_ac > g_rec_b THEN               #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct312_set_entry_b(l_cmd)
               #add-point:set_entry_b後

               #end add-point
               CALL axct312_set_no_entry_b(l_cmd)
               LET g_xccw3_d_t.* = g_xccw3_d[l_ac].*   #BACKUP  #page1
               LET g_xccw3_d_o.* = g_xccw3_d[l_ac].*   #BACKUP  #page1
            END IF 
            
             
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xccw001
 
            INITIALIZE g_xccw3_d_t.* TO NULL
            INITIALIZE g_xccw3_d_o.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccw3_d[l_ac].* TO NULL
            #公用欄位預設值
              
            #一般欄位預設值
            
            
            #add-point:modify段before備份

            #end add-point
            LET g_xccw3_d_t.* = g_xccw3_d[l_ac].*     #新輸入資料
            LET g_xccw3_d_o.* = g_xccw3_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct312_set_entry_b(l_cmd)
            #add-point:set_entry_b後

            #end add-point
            CALL axct312_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccw_d[li_reproduce_target].* = g_xccw_d[li_reproduce].*
               LET g_xccw2_d[li_reproduce_target].* = g_xccw2_d[li_reproduce].*
               LET g_xccw3_d[li_reproduce_target].* = g_xccw3_d[li_reproduce].*
 
               LET g_xccw3_d[li_reproduce_target].xccw001 = NULL
               LET g_xccw3_d[li_reproduce_target].xccw002 = NULL
               LET g_xccw3_d[li_reproduce_target].xccw007 = NULL
               LET g_xccw3_d[li_reproduce_target].xccw008 = NULL
               LET g_xccw3_d[li_reproduce_target].xccw009 = NULL
            END IF
            
#            #add-point:modify段before insert

#            #end add-point
#            
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' THEN
#               LET l_cmd='d'
#            ELSE
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "" 
#                  LET g_errparam.code   =  -263 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#                  CANCEL DELETE
#               END IF
#               IF axct312_before_delete() THEN 
#                  
#                  CALL s_transaction_end('Y','0')
#               ELSE 
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               END IF 
#               CLOSE axct312_bcl
#               CALL s_transaction_end('Y','0') 
#               LET l_count = g_xccw3_d.getLength()
#            END IF
#            
#         AFTER DELETE 
#            IF l_cmd <> 'd' THEN
#               #add-point:單身AFTER DELETE 

#               #end add-point
#                              CALL axct312_delete_b('xccw_t',gs_keys,"'3'")
#            END IF
#            #如果是最後一筆
#            IF l_ac = (g_xccw3_d.getLength() + 1) THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#            END IF
# 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code   = 9001 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xccw3_d[l_ac].* = g_xccw3_d_t.*
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_xccw_d[l_ac].xccw001 
               LET g_errparam.code   = -263 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
               LET g_xccw3_d[l_ac].* = g_xccw3_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前
#               IF 1=2 THEN 
#               #end add-point
#      
#               UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
#                   xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw009,xccw020,xccw021,xccw043, 
#                  xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,xccw282f, 
#                  xccw282g,xccw282h,xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g, 
#                  xccw202h,xccw032,xccw033,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028, 
#                  xccw029,xccw030,xccw031) = (g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
#                  g_xccw_m.xccw006,g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008, 
#                  g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011, 
#                  g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009, 
#                  g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
#                  g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
#                  g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
#                  g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw202, 
#                  g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c,g_xccw_d[l_ac].xccw202d, 
#                  g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g,g_xccw_d[l_ac].xccw202h, 
#                  g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023, 
#                  g_xccw3_d[l_ac].xccw024,g_xccw3_d[l_ac].xccw025,g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027, 
#                  g_xccw3_d[l_ac].xccw028,g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031)  
#                  #自訂欄位頁簽
#               WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
#                AND xccw003 = g_xccw_m.xccw003
#                AND xccw004 = g_xccw_m.xccw004
#                AND xccw005 = g_xccw_m.xccw005
#                AND xccw006 = g_xccw_m.xccw006
#                AND xccw001 = g_xccw3_d_t.xccw001 #項次 
#                AND xccw002 = g_xccw3_d_t.xccw002
#                AND xccw007 = g_xccw3_d_t.xccw007
#                AND xccw008 = g_xccw3_d_t.xccw008
#                AND xccw009 = g_xccw3_d_t.xccw009
#              #add-point:單身修改中
#               ELSE
                  UPDATE xccw_t SET (xccw032,xccw033,xccw022,xccw023,xccw024,
                                     xccw025,xccw026,xccw027,xccw028,xccw029,xccw030,xccw031) = 
                       (g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033,
                       g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024, g_xccw3_d[l_ac].xccw025,
                       g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028, g_xccw3_d[l_ac].xccw029,
                       g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031) #自訂欄位頁簽
                    WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                     AND xccw002 = g_xccw3_d_t.xccw002
                     AND xccw003 = g_xccw_m.xccw003
                     AND xccw004 = g_xccw_m.xccw004
                     AND xccw005 = g_xccw_m.xccw005
                     AND xccw006 = g_xccw_m.xccw006
                     AND xccw007 = g_xccw3_d_t.xccw007
                     AND xccw008 = g_xccw3_d_t.xccw008
                     AND xccw009 = g_xccw3_d_t.xccw009
#               END IF
#              #end add-point
              CASE
                 WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "xccw_t" 
                    LET g_errparam.code   = "std-00009" 
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    CALL s_transaction_end('N','0')
                 WHEN SQLCA.sqlcode #其他錯誤
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "xccw_t" 
                    LET g_errparam.code   = SQLCA.sqlcode 
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    CALL s_transaction_end('N','0')
                 OTHERWISE
#                                   INITIALIZE gs_keys TO NULL 
#              LET gs_keys[1] = g_xccw_m.xccwld
#              LET gs_keys_bak[1] = g_xccwld_t
#              LET gs_keys[2] = g_xccw_m.xccw003
#              LET gs_keys_bak[2] = g_xccw003_t
#              LET gs_keys[3] = g_xccw_m.xccw004
#              LET gs_keys_bak[3] = g_xccw004_t
#              LET gs_keys[4] = g_xccw_m.xccw005
#              LET gs_keys_bak[4] = g_xccw005_t
#              LET gs_keys[5] = g_xccw_m.xccw006
#              LET gs_keys_bak[5] = g_xccw006_t
#              LET gs_keys[6] = g_xccw3_d[g_detail_idx].xccw001
#              LET gs_keys_bak[6] = g_xccw3_d_t.xccw001
#              LET gs_keys[7] = g_xccw3_d[g_detail_idx].xccw002
#              LET gs_keys_bak[7] = g_xccw3_d_t.xccw002
#              LET gs_keys[8] = g_xccw3_d[g_detail_idx].xccw007
#              LET gs_keys_bak[8] = g_xccw3_d_t.xccw007
#              LET gs_keys[9] = g_xccw3_d[g_detail_idx].xccw008
#              LET gs_keys_bak[9] = g_xccw3_d_t.xccw008
#              LET gs_keys[10] = g_xccw3_d[g_detail_idx].xccw009
#              LET gs_keys_bak[10] = g_xccw3_d_t.xccw009
#              CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'3'")
#                    #多語言處理
#                    
#                    LET g_log1 = util.JSON.stringify(g_xccw_m),util.JSON.stringify(g_xccw3_d_t)
#                    LET g_log2 = util.JSON.stringify(g_xccw_m),util.JSON.stringify(g_xccw3_d[l_ac])
#                    IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
#                       CALL s_transaction_end('N','0')
#                    END IF
                 CALL s_transaction_end('Y','0')
              END CASE
              
#              #add-point:單身修改後

#              #end add-point
           END IF
#        
#                 #此段落由子樣板a01產生
        BEFORE FIELD xccw032
           #add-point:BEFORE FIELD xccw032

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw032
           
           #add-point:AFTER FIELD xccw032
            IF NOT cl_null(g_xccw3_d[l_ac].xccw032) THEN
               IF ( g_xccw3_d[l_ac].xccw032 != g_xccw3_d_t.xccw032 OR g_xccw3_d_t.xccw032 IS NULL ) THEN
                  CALL s_aap_glac002_chk(g_xccw3_d[l_ac].xccw032,g_xccw_m.xccwld) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#41 s983961--add(s)
                     LET g_errparam.replace[1] ='agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog ='agli020'
                     #160321-00016#41 s983961--add(e)
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xccw3_d[l_ac].xccw032        = g_xccw3_d_t.xccw032
                     LET g_xccw3_d[l_ac].xccw032_desc = g_xccw3_d_t.xccw032_desc
                     DISPLAY BY NAME g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw032_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE               
               LET g_xccw3_d[l_ac].xccw032 = ''
            END IF
            LET g_xccw3_d[l_ac].xccw032_desc = s_desc_get_account_desc(g_xccw_m.xccwld,g_xccw3_d[l_ac].xccw032)            
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw032_desc
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw032
           #add-point:ON CHANGE xccw032

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw033
           #add-point:BEFORE FIELD xccw033

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw033
#           
           #add-point:AFTER FIELD xccw033
            IF NOT cl_null(g_xccw3_d[l_ac].xccw033) THEN
               IF ( g_xccw3_d[l_ac].xccw033 != g_xccw3_d_t.xccw033 OR g_xccw3_d_t.xccw033 IS NULL ) THEN
                  CALL s_aap_glac002_chk(g_xccw3_d[l_ac].xccw033,g_xccw_m.xccwld) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#41 s983961--add(s)
                     LET g_errparam.replace[1] ='agli020'
                     LET g_errparam.replace[2] = cl_get_progname('agli020',g_lang,"2")
                     LET g_errparam.exeprog ='agli020'
                     #160321-00016#41 s983961--add(e)
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xccw3_d[l_ac].xccw033        = g_xccw3_d_t.xccw033
                     LET g_xccw3_d[l_ac].xccw033_desc = g_xccw3_d_t.xccw033_desc
                     DISPLAY BY NAME g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw033_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            ELSE               
               LET g_xccw3_d[l_ac].xccw033 = ''
            END IF
            LET g_xccw3_d[l_ac].xccw033_desc = s_desc_get_account_desc(g_xccw_m.xccwld,g_xccw3_d[l_ac].xccw033)            
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw033_desc
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw033
           #add-point:ON CHANGE xccw033

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw022
           #add-point:BEFORE FIELD xccw022

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw022
#           
           #add-point:AFTER FIELD xccw022
            IF NOT cl_null(g_xccw3_d[l_ac].xccw022) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw022
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00029:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pmaa001_6") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw022 = g_xccw3_d_t.xccw022
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw022
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw022_desc = '', g_rtn_fields[1] , ''  
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw022_desc   
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw022
           #add-point:ON CHANGE xccw022

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw023
           #add-point:BEFORE FIELD xccw023

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw023
           
           #add-point:AFTER FIELD xccw023
            IF NOT cl_null(g_xccw3_d[l_ac].xccw023) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw023
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apm-00093:sub-01302|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               LET g_chkparam.err_str[1] = "apm-00092:sub-01303|axmi021|",cl_get_progname("axmi021",g_lang,"2"),"|:EXEPROGaxmi021"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_281") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw023 = g_xccw3_d_t.xccw023
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw023
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw023_desc = '', g_rtn_fields[1] , ''   
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw023_desc
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw023
           #add-point:ON CHANGE xccw023

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw024
           #add-point:BEFORE FIELD xccw024

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw024
#           
           #add-point:AFTER FIELD xccw024
            IF NOT cl_null(g_xccw3_d[l_ac].xccw024) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw024
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axm-00004:sub-01302|axmi027|",cl_get_progname("axmi027",g_lang,"2"),"|:EXEPROGaxmi027"
               #160318-00025#12--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_287") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw024 = g_xccw3_d_t.xccw024
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw024
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw024_desc = '', g_rtn_fields[1] , '' 
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw024_desc   
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw024
           #add-point:ON CHANGE xccw024

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw025
           #add-point:BEFORE FIELD xccw025

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw025
#           
           #add-point:AFTER FIELD xccw025
            IF NOT cl_null(g_xccw3_d[l_ac].xccw025) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw025
               LET g_chkparam.arg2 = g_today
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooeg001_4") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw025 = g_xccw3_d_t.xccw025
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw025
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw025_desc = '', g_rtn_fields[1] , '' 
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw025_desc
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw025
           #add-point:ON CHANGE xccw025

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw026
           #add-point:BEFORE FIELD xccw026

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw026
           
           #add-point:AFTER FIELD xccw026
            IF NOT cl_null(g_xccw3_d[l_ac].xccw026) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '6013'
               LET g_chkparam.arg2 = g_xccw3_d[l_ac].xccw026
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_gzcb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw026 = g_xccw3_d_t.xccw026
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw026
            CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcbl001='6013' AND gzcbl002=? AND gzcbl003='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw026_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw026_desc
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw026
           #add-point:ON CHANGE xccw026

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw027
           #add-point:BEFORE FIELD xccw027

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw027
           
           #add-point:AFTER FIELD xccw027
            IF NOT cl_null(g_xccw3_d[l_ac].xccw027) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw027
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "axc-00301:sub-01302|apmi035|",cl_get_progname("apmi035",g_lang,"2"),"|:EXEPROGapmi035"
               LET g_chkparam.err_str[2] = "axc-00300:sub-01303|apmi035|",cl_get_progname("apmi035",g_lang,"2"),"|:EXEPROGapmi035"
               #160318-00025#12--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_2035") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw027 = g_xccw3_d_t.xccw027
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw027
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2035' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw027_desc = '', g_rtn_fields[1] , '' 
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw027_desc  
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw027
           #add-point:ON CHANGE xccw027

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw028
           #add-point:BEFORE FIELD xccw028

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw028
           
           #add-point:AFTER FIELD xccw028
            IF NOT cl_null(g_xccw3_d[l_ac].xccw028) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw028
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "anm-00081:sub-01302|aimi010|",cl_get_progname("aimi010",g_lang,"2"),"|:EXEPROGaimi010"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_rtax001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw028 = g_xccw3_d_t.xccw028
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw028
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw028_desc = '', g_rtn_fields[1] , '' 
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw028_desc 
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw028
           #add-point:ON CHANGE xccw028

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw029
           #add-point:BEFORE FIELD xccw029

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw029
           
           #add-point:AFTER FIELD xccw029
            IF NOT cl_null(g_xccw3_d[l_ac].xccw029) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw029
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_2002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw029 = g_xccw3_d_t.xccw029
                  NEXT FIELD CURRENT
               END IF
            

            END IF 

            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw029
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw029_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw029_desc 
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw029
           #add-point:ON CHANGE xccw029

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw030
           #add-point:BEFORE FIELD xccw030

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw030
           
           #add-point:AFTER FIELD xccw030
            IF NOT cl_null(g_xccw3_d[l_ac].xccw030) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw030
               #160318-00025#12--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "apj-00012:sub-01302|apjm200|",cl_get_progname("apjm200",g_lang,"2"),"|:EXEPROGapjm200"
               #160318-00025#12--add--end   
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjba001") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw030 = g_xccw3_d_t.xccw030
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw030
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw030_desc = '', g_rtn_fields[1] , '' 
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw030_desc  
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw030
           #add-point:ON CHANGE xccw030

           #END add-point
 
        #此段落由子樣板a01產生
        BEFORE FIELD xccw031
           #add-point:BEFORE FIELD xccw031

           #END add-point
 
        #此段落由子樣板a02產生
        AFTER FIELD xccw031
           
           #add-point:AFTER FIELD xccw031
            IF NOT cl_null(g_xccw3_d[l_ac].xccw031) THEN 
#此段落由子樣板a19產生
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_xccw3_d[l_ac].xccw030
               LET g_chkparam.arg2 = g_xccw3_d[l_ac].xccw031
                  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_pjbb002") THEN
                  #檢查成功時後續處理
                  #LET  = g_chkparam.return1
                  #DISPLAY BY NAME 
               ELSE
                  #檢查失敗時後續處理
                  LET g_xccw3_d[l_ac].xccw031 = g_xccw3_d_t.xccw031
                  NEXT FIELD CURRENT
               END IF
            

            END IF 
            
            #add reference fengmy141128
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw030            
            LET g_ref_fields[2] = g_xccw3_d[l_ac].xccw031
            CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_xccw3_d[l_ac].xccw031_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_xccw3_d[l_ac].xccw031_desc  
           #END add-point
           
 
        #此段落由子樣板a04產生
        ON CHANGE xccw031
           #add-point:ON CHANGE xccw031

           #END add-point
 
 
                 #Ctrlp:input.c.page3.xccw032
        ON ACTION controlp INFIELD xccw032
           #add-point:ON ACTION controlp INFIELD xccw032
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw032    
           LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科目類型)
           CALL aglt310_04()                               
           LET g_xccw3_d[l_ac].xccw032       = g_qryparam.return1
#           LET g_xccw_d[l_ac].xccw032_desc  = s_desc_get_account_desc(g_apca_m.apcald,g_xccw_d[l_ac].xccw032)
           DISPLAY  g_xccw3_d[l_ac].xccw032  TO xccw032
           #END add-point
 
        #Ctrlp:input.c.page3.xccw033
        ON ACTION controlp INFIELD xccw033
           #add-point:ON ACTION controlp INFIELD xccw033
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw033    
           LET g_qryparam.where = "glac001 = '",g_glaa004,"' AND  glac003 <>'1' "  #glac001(會計科目參照表)/glac003(科目類型)
           CALL aglt310_04()                               
           LET g_xccw3_d[l_ac].xccw033       = g_qryparam.return1
#           LET g_xccw_d[l_ac].xccw032_desc  = s_desc_get_account_desc(g_apca_m.apcald,g_xccw_d[l_ac].xccw032)
           DISPLAY g_xccw3_d[l_ac].xccw033 TO xccw033
           #END add-point
 
        #Ctrlp:input.c.page3.xccw022
        ON ACTION controlp INFIELD xccw022
           #add-point:ON ACTION controlp INFIELD xccw022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw022             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw022 = g_qryparam.return1              

            DISPLAY g_xccw3_d[l_ac].xccw022 TO xccw022              #

            NEXT FIELD xccw022                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw023
        ON ACTION controlp INFIELD xccw023
           #add-point:ON ACTION controlp INFIELD xccw023
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw023             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = '281'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw023 = g_qryparam.return1
            DISPLAY g_xccw3_d[l_ac].xccw023 TO xccw023              
            NEXT FIELD xccw023                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw024
        ON ACTION controlp INFIELD xccw024
           #add-point:ON ACTION controlp INFIELD xccw024
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw024             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = '287'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw024 = g_qryparam.return1 
            DISPLAY g_xccw3_d[l_ac].xccw024 TO xccw024             
            NEXT FIELD xccw024                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw025
        ON ACTION controlp INFIELD xccw025
           #add-point:ON ACTION controlp INFIELD xccw025
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw025             #給予default值
#            LET g_qryparam.where = " ooeg003 = '3'"
            #給予arg
            LET g_qryparam.arg1 = g_today

            
            CALL q_ooeg001_8()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw025 = g_qryparam.return1              

            DISPLAY g_xccw3_d[l_ac].xccw025 TO xccw025              #

            NEXT FIELD xccw025                          #返回原欄位

           #END add-point
 
        #Ctrlp:input.c.page3.xccw026
        ON ACTION controlp INFIELD xccw026
           #add-point:ON ACTION controlp INFIELD xccw026
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw026             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '6013'

            
            CALL q_gzcb001()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw026 = g_qryparam.return1              

            DISPLAY g_xccw3_d[l_ac].xccw026 TO xccw026              #

            NEXT FIELD xccw026                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw027
        ON ACTION controlp INFIELD xccw027
           #add-point:ON ACTION controlp INFIELD xccw027
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw027             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = '2035'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw027 = g_qryparam.return1
            DISPLAY g_xccw3_d[l_ac].xccw027 TO xccw027              
            NEXT FIELD xccw027                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw028
        ON ACTION controlp INFIELD xccw028
           #add-point:ON ACTION controlp INFIELD xccw028
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw028             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_rtax001_1()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw028 = g_qryparam.return1              

            DISPLAY g_xccw3_d[l_ac].xccw028 TO xccw028              #

            NEXT FIELD xccw028                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw029
        ON ACTION controlp INFIELD xccw029
           #add-point:ON ACTION controlp INFIELD xccw029
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw029             #給予default值
            LET g_qryparam.default2 = "" 
            #給予arg
            LET g_qryparam.arg1 = '2002'

            
            CALL q_oocq002()                                #呼叫開窗

            LET g_xccw3_d[l_ac].xccw029 = g_qryparam.return1 
            DISPLAY g_xccw3_d[l_ac].xccw029 TO xccw029             
            NEXT FIELD xccw029                          #返回原欄位
           #END add-point
 
        #Ctrlp:input.c.page3.xccw030
        ON ACTION controlp INFIELD xccw030
           #add-point:ON ACTION controlp INFIELD xccw030
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xccw3_d[l_ac].xccw030
            CALL q_pjba001()
            LET g_xccw3_d[l_ac].xccw030        = g_qryparam.return1
            DISPLAY g_xccw3_d[l_ac].xccw030 TO xccw030
            NEXT FIELD xccw030
           #END add-point
 
        #Ctrlp:input.c.page3.xccw031
        ON ACTION controlp INFIELD xccw031
           #add-point:ON ACTION controlp INFIELD xccw031
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_xccw3_d[l_ac].xccw030
            CALL q_pjbb002_1()                           #呼叫開窗
            LET g_xccw3_d[l_ac].xccw031        = g_qryparam.return1
            DISPLAY g_xccw3_d[l_ac].xccw031 TO xccw031  #顯示到畫面上
            NEXT FIELD xccw031                     #返回原欄位
           #END add-point
 
 
 
        AFTER ROW
           LET l_ac = ARR_CURR()
           LET l_ac_t = l_ac
           IF INT_FLAG THEN
              INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend = '' 
              LET g_errparam.code   = 9001 
              LET g_errparam.popup  = FALSE 
              CALL cl_err()
              LET INT_FLAG = 0
              IF l_cmd = 'u' THEN
                 LET g_xccw3_d[l_ac].* = g_xccw3_d_t.*
              END IF
              CLOSE axct312_bcl
              CALL s_transaction_end('N','0')
              EXIT DIALOG 
           END IF
 
           CLOSE axct312_bcl
           CALL s_transaction_end('Y','0')
 
        AFTER INPUT
           #add-point:input段after input 

           #end add-point    
 
        ON ACTION controlo
           CALL FGL_SET_ARR_CURR(g_xccw3_d.getLength()+1)
           LET lb_reproduce = TRUE
           LET li_reproduce = l_ac
           LET li_reproduce_target = g_xccw3_d.getLength()+1
 
     END INPUT
 
      
      DISPLAY ARRAY g_xccw2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
      
         BEFORE ROW
            CALL axct312_b_fill(g_wc2) 
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            LET l_ac = g_detail_idx
            DISPLAY g_detail_idx TO FORMONLY.idx
            CALL axct312_ui_detailshow()
        
         BEFORE DISPLAY 
            CALL FGL_SET_ARR_CURR(g_detail_idx)      
         
         #add-point:page2自定義行為

         #end add-point
         
      END DISPLAY
 
      
 
      
      #add-point:input段more_input
      #fengmy140903---------begin
#      INPUT ARRAY g_xccw4_d FROM s_detial4.*
#         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
#                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
#
#                   DELETE ROW = FALSE,
#                   APPEND ROW = FALSE)
# 
#         #自訂單身ACTION
#         
#                 
#         BEFORE INPUT
#            
#            CALL axct312_b_fill(g_wc2) 
#            IF g_rec_b != 0 THEN             
#               CALL fgl_set_arr_curr(l_ac)
#            END IF
#            #add-point:資料輸入前
#
#            #end add-point
# 
#         BEFORE ROW 
#            LET l_cmd = ''
#            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
#            LET l_ac = ARR_CURR()                #returns the current row
#            IF l_ac > g_rec_b THEN               #不可超過最後一筆
#               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
#            END IF
#           
#            LET l_lock_sw = 'N'                  #DEFAULT
#            LET l_n = ARR_COUNT()                #the number of rows containing  
#            
#            
#            CALL s_transaction_begin()
#            IF g_rec_b >= l_ac THEN
#               LET l_cmd='u'
#               CALL axct312_set_entry_b(l_cmd)
#               CALL axct312_set_no_entry_b(l_cmd)
#               LET g_xccw4_d_t.* = g_xccw4_d[l_ac].*   #BACKUP  #page1
#               CALL axct312_set_no_entry_b(l_cmd)
#               OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
#                                                g_xccw_m.xccw003,
#                                                g_xccw_m.xccw004,
#                                                g_xccw_m.xccw005,
#                                                g_xccw_m.xccw006,
# 
#                                                g_xccw4_d_t.xccw001
#                                                ,g_xccw4_d_t.xccw002
#                                                ,g_xccw4_d_t.xccw007
#                                                ,g_xccw4_d_t.xccw008
#                                                ,g_xccw4_d_t.xccw009
# 
#               IF STATUS THEN
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = "OPEN axct312_bcl:" 
#                  LET g_errparam.code   =  STATUS 
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
# 
#                  LET l_lock_sw='Y'
#               END IF
#            END IF 
#            CALL axct312_b_fill_1(g_wc2)
#            LET l_ac = ARR_CURR()
#            #多个币种资料一起锁
#            IF l_cmd='u' THEN
#              
#                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
#                                                     g_xccw_m.xccw003,
#                                                     g_xccw_m.xccw004,
#                                                     g_xccw_m.xccw005,
#                                                     g_xccw_m.xccw006,
#                    
#                                                    '1'
#                                                     ,g_xccw4_d_t.xccw002
#                                                     ,g_xccw4_d_t.xccw007
#                                                     ,g_xccw4_d_t.xccw008
#                                                     ,g_xccw4_d_t.xccw009
#                    
#                  IF STATUS THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "OPEN axct312_bcl:" 
#                     LET g_errparam.code   =  STATUS 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  
#                     LET l_lock_sw='Y'
#                  END IF
#               
#               IF g_glaa019 = 'Y' THEN
#                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
#                                                     g_xccw_m.xccw003,
#                                                     g_xccw_m.xccw004,
#                                                     g_xccw_m.xccw005,
#                                                     g_xccw_m.xccw006,
#                    
#                                                    '3'
#                                                     ,g_xccw4_d_t.xccw002
#                                                     ,g_xccw4_d_t.xccw007
#                                                     ,g_xccw4_d_t.xccw008
#                                                     ,g_xccw4_d_t.xccw009
#                    
#                  IF STATUS THEN
#                     INITIALIZE g_errparam TO NULL 
#                     LET g_errparam.extend = "OPEN axct312_bcl:" 
#                     LET g_errparam.code   =  STATUS 
#                     LET g_errparam.popup  = TRUE 
#                     CALL cl_err()
#                  
#                     LET l_lock_sw='Y'
#                  END IF
#               END IF
#            END IF
#            
#             
#         BEFORE INSERT
#            LET g_insert = 'Y' 
#            NEXT FIELD xccw001
# 
#            INITIALIZE g_xccw4_d_t.* TO NULL
#            LET l_insert = TRUE
#            LET l_n = ARR_COUNT()
#            LET l_cmd = 'a'
#            INITIALIZE g_xccw4_d[l_ac].* TO NULL
#            
#            #公用欄位預設值
#            #此段落由子樣板a14產生    
#     
#      ##LET .xcckstus = ""
# 
#  
#            
#            #一般欄位預設值
#            
#            
#            
#            LET g_xccw4_d_t.* = g_xccw4_d[l_ac].*     #新輸入資料
#            CALL cl_show_fld_cont()
#            CALL axct312_set_entry_b(l_cmd)
#            CALL axct312_set_no_entry_b(l_cmd)
#            IF lb_reproduce THEN
#               LET lb_reproduce = FALSE
#               LET g_xccw_d[li_reproduce_target].* = g_xccw_d[li_reproduce].*
#               LET g_xccw2_d[li_reproduce_target].* = g_xccw2_d[li_reproduce].*
#               LET g_xccw3_d[li_reproduce_target].* = g_xccw3_d[li_reproduce].*
#               LET g_xccw4_d[li_reproduce_target].* = g_xccw4_d[li_reproduce].*
#               LET g_xccw4_d[li_reproduce_target].* = g_xccw4_d[li_reproduce].*
# 
#               LET g_xccw4_d[li_reproduce_target].xccw001 = NULL
#               LET g_xccw4_d[li_reproduce_target].xccw009 = NULL
#               LET g_xccw4_d[li_reproduce_target].xccw007 = NULL
#               LET g_xccw4_d[li_reproduce_target].xccw008 = NULL
#            END IF
#            
#            #add-point:modify段before insert
# 
#            #end add-point
#            
#         BEFORE DELETE                            #是否取消單身
#            IF l_cmd = 'a' AND g_xccw4_d.getLength() < l_ac THEN
#               CALL FGL_SET_ARR_CURR(l_ac-1)
#               CALL g_xccw_d.deleteElement(l_ac)
#               NEXT FIELD xccw001
#            END IF
#            IF g_xccw_d_t.xccw001 IS NOT NULL
#               AND g_xccw_d_t.xccw010 IS NOT NULL
#               AND g_xccw_d_t.xccw007 IS NOT NULL
#               AND g_xccw_d_t.xccw008 IS NOT NULL
#            THEN
#               IF NOT cl_ask_del_detail() THEN
#                  CANCEL DELETE
#               END IF
#               IF l_lock_sw = "Y" THEN
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code =  -263
#                  LET g_errparam.extend = ""
#                  LET g_errparam.popup = TRUE
#                  CALL cl_err()
#
#                  CANCEL DELETE
#               END IF
#               IF axct312_before_delete() THEN 
#                  CALL s_transaction_end('Y','0')
#               ELSE 
#                  CALL s_transaction_end('N','0')
#                  CANCEL DELETE   
#               END IF 
#               CLOSE axct312_bcl
#               CALL s_transaction_end('Y','0') 
#               LET l_count = g_xccw4_d.getLength()
#            END IF
#            
#         AFTER DELETE 
# 
#         ON ROW CHANGE 
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 9001
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#
#               LET INT_FLAG = 0
#               LET g_xccw4_d[l_ac].* = g_xccw4_d_t.*
#               CLOSE axct312_bcl
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
#            
#            IF l_lock_sw = 'Y' THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = -263
#               LET g_errparam.extend = g_xccw_d[l_ac].xccw001
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#
#               LET g_xccw4_d[l_ac].* = g_xccw4_d_t.*
#            ELSE
#               #寫入修改者/修改日期資訊
#               
#                
#               #add-point:單身修改前
#               LET g_xccw4_d[l_ac].xccw282 = g_xccw4_d[l_ac].xccw282a + g_xccw4_d[l_ac].xccw282b +
#                                             g_xccw4_d[l_ac].xccw282c + g_xccw4_d[l_ac].xccw282d +
#                                             g_xccw4_d[l_ac].xccw282e + g_xccw4_d[l_ac].xccw282f +
#                                             g_xccw4_d[l_ac].xccw282g + g_xccw4_d[l_ac].xccw282h
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw202a + g_xccw4_d[l_ac].xccw202b +
#                                             g_xccw4_d[l_ac].xccw202c + g_xccw4_d[l_ac].xccw202d +
#                                             g_xccw4_d[l_ac].xccw202e + g_xccw4_d[l_ac].xccw202f +
#                                             g_xccw4_d[l_ac].xccw202g + g_xccw4_d[l_ac].xccw202h
#               #end add-point
#               UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
#                      xccwsite,xccw010,xccw011,xccw041,xccw042,xccw044,xccw201,xccw282a,xccw282b,xccw282c,xccw282d, 
#                      xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,
#                      xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw_m.xccwld, 
#                      g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw006,g_xccw4_d[l_ac].xccw001,
#                      g_xccw4_d[l_ac].xccw007, g_xccw4_d[l_ac].xccw008, g_xccw4_d[l_ac].xccw002,g_xccw4_d[l_ac].xccwsite, 
#                      g_xccw4_d[l_ac].xccw010, g_xccw4_d[l_ac].xccw011, g_xccw4_d[l_ac].xccw041, g_xccw4_d[l_ac].xccw042, g_xccw4_d[l_ac].xccw044,
#                      g_xccw4_d[l_ac].xccw201, g_xccw4_d[l_ac].xccw282a,g_xccw4_d[l_ac].xccw282b,g_xccw4_d[l_ac].xccw282c,
#                      g_xccw4_d[l_ac].xccw282d,g_xccw4_d[l_ac].xccw282e,g_xccw4_d[l_ac].xccw282f,g_xccw4_d[l_ac].xccw282g, 
#                      g_xccw4_d[l_ac].xccw282h,g_xccw4_d[l_ac].xccw282, g_xccw4_d[l_ac].xccw202, 
#                      g_xccw4_d[l_ac].xccw202a,g_xccw4_d[l_ac].xccw202b,g_xccw4_d[l_ac].xccw202c,g_xccw4_d[l_ac].xccw202d, 
#                      g_xccw4_d[l_ac].xccw202e,g_xccw4_d[l_ac].xccw202f,g_xccw4_d[l_ac].xccw202g,g_xccw4_d[l_ac].xccw202h) #自訂欄位頁簽
#                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
#                    AND xccw002 = g_xccw4_d_t.xccw002
#                    AND xccw003 = g_xccw_m.xccw003
#                    AND xccw004 = g_xccw_m.xccw004
#                    AND xccw005 = g_xccw_m.xccw005
#                    AND xccw006 = g_xccw_m.xccw006
#                   #AND xccw001 = g_xccw4_d_t.xccw001 #項次 
#                    AND xccw007 = g_xccw4_d_t.xccw007
#                    AND xccw008 = g_xccw4_d_t.xccw008
#                    AND xccw009 = g_xccw_d_t.xccw009
#                    AND xccw001 = '3'
#
#               #add-point:單身修改中
#
#               #end add-point
#               CASE
#                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = "std-00009"
#                     LET g_errparam.extend = "xccw_t"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#
#                     CALL s_transaction_end('N','0')
#                  WHEN SQLCA.sqlcode #其他錯誤
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code = SQLCA.sqlcode
#                     LET g_errparam.extend = "xccw_t"
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#  
#                     CALL s_transaction_end('N','0')
#                  OTHERWISE
#                                    INITIALIZE gs_keys TO NULL          
#               LET gs_keys[1] = g_xccw_m.xccwld
#               LET gs_keys_bak[1] = g_xccwld_t
#               LET gs_keys[2] = g_xccw_m.xccw003
#               LET gs_keys_bak[2] = g_xccw003_t
#               LET gs_keys[3] = g_xccw_m.xccw004
#               LET gs_keys_bak[3] = g_xccw004_t
#               LET gs_keys[4] = g_xccw_m.xccw005
#               LET gs_keys_bak[4] = g_xccw005_t
#               LET gs_keys[5] = g_xccw_m.xccw006
#               LET gs_keys_bak[5] = g_xccw006_t
#               LET gs_keys[6] = g_xccw4_d[g_detail_idx].xccw001
#               LET gs_keys_bak[6] = g_xccw4_d_t.xccw001
#               LET gs_keys[7] = g_xccw4_d[g_detail_idx].xccw002
#               LET gs_keys_bak[7] = g_xccw4_d_t.xccw002
#               LET gs_keys[8] = g_xccw4_d[g_detail_idx].xccw007
#               LET gs_keys_bak[8] = g_xccw4_d_t.xccw007
#               LET gs_keys[9] = g_xccw4_d[g_detail_idx].xccw008
#               LET gs_keys_bak[9] = g_xccw4_d_t.xccw008
#               LET gs_keys[10] = g_xccw4_d[g_detail_idx].xccw009
#               LET gs_keys_bak[10] = g_xccw4_d_t.xccw009
#               
#               CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'5'")
#                     #多語言處理
#                     
#               END CASE
#               
#               #add-point:單身修改後
#
#               #end add-point
#            END IF
#         
#         #---------------------<  Detail: page4  >---------------------
#         #----<<xccw041>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccw041
#            #add-point:BEFORE FIELD xccw041
#
#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccw041
#            
#            #add-point:AFTER FIELD xccw041
#
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccw041
#            #add-point:ON CHANGE xccw041
#
#            #END add-point
# 
#         #----<<xccw042>>----
#         #此段落由子樣板a01產生
#         BEFORE FIELD xccw042
#            #add-point:BEFORE FIELD xccw042
#
#            #END add-point
# 
#         #此段落由子樣板a02產生
#         AFTER FIELD xccw042
#            
#            #add-point:AFTER FIELD xccw042
#
#            #END add-point
#            
# 
#         #此段落由子樣板a04產生
#         ON CHANGE xccw042
#            #add-point:ON CHANGE xccw042
#
#            #END add-point
# 
#         AFTER FIELD xccw282a_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282a) THEN 
#               LET g_xccw4_d[l_ac].xccw202a = g_xccw4_d[l_ac].xccw282a * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282b_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282b) THEN 
#               LET g_xccw4_d[l_ac].xccw202b = g_xccw4_d[l_ac].xccw282b * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282c_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282c) THEN 
#               LET g_xccw4_d[l_ac].xccw202c = g_xccw4_d[l_ac].xccw282c * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282d_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282d) THEN 
#               LET g_xccw4_d[l_ac].xccw202d = g_xccw4_d[l_ac].xccw282d * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282e_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282e) THEN 
#               LET g_xccw4_d[l_ac].xccw202e = g_xccw4_d[l_ac].xccw282e * g_xccw4_d[l_ac].xccw201
#            END IF
#         
#         AFTER FIELD xccw282f_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282f) THEN 
#               LET g_xccw4_d[l_ac].xccw202f = g_xccw4_d[l_ac].xccw282f * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282g_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282g) THEN 
#               LET g_xccw4_d[l_ac].xccw202g = g_xccw4_d[l_ac].xccw282g * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282h_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282h) THEN 
#               LET g_xccw4_d[l_ac].xccw202h = g_xccw4_d[l_ac].xccw282h * g_xccw4_d[l_ac].xccw201
#            END IF
#            
#         AFTER FIELD xccw282_4
#            IF NOT cl_null(g_xccw4_d[l_ac].xccw282) THEN 
#               LET g_xccw4_d[l_ac].xccw202 = g_xccw4_d[l_ac].xccw282 * g_xccw4_d[l_ac].xccw201
#            END IF
# 
#         #---------------------<  Detail: page4  >---------------------
#         #----<<xccw041>>----
#         #Ctrlp:input.c.page4.xccw041
#         ON ACTION controlp INFIELD xccw041
#            #add-point:ON ACTION controlp INFIELD xccw041
#
#            #END add-point
# 
#         #----<<xccw042>>----
#         #Ctrlp:input.c.page4.xccw042
#         ON ACTION controlp INFIELD xccw042
#            #add-point:ON ACTION controlp INFIELD xccw042
#
#            #END add-point
# 
# 
# 
#         AFTER ROW
#            LET l_ac = ARR_CURR()
#            LET l_ac_t = l_ac
#            IF INT_FLAG THEN
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.code = 9001
#               LET g_errparam.extend = ''
#               LET g_errparam.popup = FALSE
#               CALL cl_err()
#
#               LET INT_FLAG = 0
#               IF l_cmd = 'u' THEN
#                  LET g_xccw4_d[l_ac].* = g_xccw4_d_t.*
#               END IF
#               CLOSE axct312_bcl
#               CALL s_transaction_end('N','0')
#               EXIT DIALOG 
#            END IF
# 
#            CLOSE axct312_bcl
#            CALL s_transaction_end('Y','0')
# 
#         AFTER INPUT
#            #add-point:input段after input 
#
#            #end add-point    
# 
#         ON ACTION controlo
#            CALL FGL_SET_ARR_CURR(g_xccw4_d.getLength()+1)
#            LET lb_reproduce = TRUE
#            LET li_reproduce = l_ac
#            LET li_reproduce_target = g_xccw4_d.getLength()+1
# 
#      END INPUT
      #fengmy140903---------end
      INPUT ARRAY g_xccw5_d FROM s_detail5.*
         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct312_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN             
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
 
         BEFORE ROW 
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = ARR_CURR()                #returns the current row
            IF l_ac > g_rec_b THEN               #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct312_set_entry_b(l_cmd)
               CALL axct312_set_no_entry_b(l_cmd)
               LET g_xccw5_d_t.* = g_xccw5_d[l_ac].*   #BACKUP  #page1
               CALL axct312_set_no_entry_b(l_cmd)
               OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                g_xccw_m.xccw003,
                                                g_xccw_m.xccw004,
                                                g_xccw_m.xccw005,
                                                g_xccw_m.xccw006,
 
                                                g_xccw5_d_t.xccw001
                                                ,g_xccw5_d_t.xccw002
                                                ,g_xccw5_d_t.xccw007
                                                ,g_xccw5_d_t.xccw008
                                                ,g_xccw5_d_t.xccw009
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct312_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               END IF
            END IF 
            CALL axct312_b_fill_1(g_wc2)
            LET l_ac = ARR_CURR()
            #多个币种资料一起锁
            IF l_cmd='u' THEN
              
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '1'
                                                     ,g_xccw5_d_t.xccw002
                                                     ,g_xccw5_d_t.xccw007
                                                     ,g_xccw5_d_t.xccw008
                                                     ,g_xccw5_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa015 = 'Y' THEN
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '2'
                                                     ,g_xccw5_d_t.xccw002
                                                     ,g_xccw5_d_t.xccw007
                                                     ,g_xccw5_d_t.xccw008
                                                     ,g_xccw5_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            
             
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xccw001
 
            INITIALIZE g_xccw5_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccw5_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
     
      ##LET .xcckstus = ""
 
  
            
            #一般欄位預設值
            
            
            
            LET g_xccw5_d_t.* = g_xccw5_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct312_set_entry_b(l_cmd)
            CALL axct312_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccw_d[li_reproduce_target].* = g_xccw_d[li_reproduce].*
               LET g_xccw2_d[li_reproduce_target].* = g_xccw2_d[li_reproduce].*
               LET g_xccw3_d[li_reproduce_target].* = g_xccw3_d[li_reproduce].*
               LET g_xccw6_d[li_reproduce_target].* = g_xccw6_d[li_reproduce].*
               LET g_xccw5_d[li_reproduce_target].* = g_xccw5_d[li_reproduce].*
 
               LET g_xccw5_d[li_reproduce_target].xccw001 = NULL
               LET g_xccw5_d[li_reproduce_target].xccw009 = NULL
               LET g_xccw5_d[li_reproduce_target].xccw007 = NULL
               LET g_xccw5_d[li_reproduce_target].xccw008 = NULL
            END IF
            
            #add-point:modify段before insert
 
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xccw5_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xccw_d.deleteElement(l_ac)
               NEXT FIELD xccw001
            END IF
            IF g_xccw_d_t.xccw001 IS NOT NULL
               AND g_xccw_d_t.xccw010 IS NOT NULL
               AND g_xccw_d_t.xccw007 IS NOT NULL
               AND g_xccw_d_t.xccw008 IS NOT NULL
            THEN
               CALL s_transaction_begin()  #140909
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct312_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct312_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xccw5_d.getLength()
            END IF
            
         AFTER DELETE 
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xccw5_d[l_ac].* = g_xccw5_d_t.*
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xccw_d[l_ac].xccw001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xccw5_d[l_ac].* = g_xccw5_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前
               LET g_xccw5_d[l_ac].xccw282 = g_xccw5_d[l_ac].xccw282a + g_xccw5_d[l_ac].xccw282b +
                                             g_xccw5_d[l_ac].xccw282c + g_xccw5_d[l_ac].xccw282d +
                                             g_xccw5_d[l_ac].xccw282e + g_xccw5_d[l_ac].xccw282f +
                                             g_xccw5_d[l_ac].xccw282g + g_xccw5_d[l_ac].xccw282h
               LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw202a + g_xccw5_d[l_ac].xccw202b +
                                             g_xccw5_d[l_ac].xccw202c + g_xccw5_d[l_ac].xccw202d +
                                             g_xccw5_d[l_ac].xccw202e + g_xccw5_d[l_ac].xccw202f +
                                             g_xccw5_d[l_ac].xccw202g + g_xccw5_d[l_ac].xccw202h
               CALL s_transaction_begin()  #140909
               #end add-point
#               UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
#                      xccwsite,xccw010,xccw011,xccw041,xccw042,xccw044,xccw201,xccw282a,xccw282b,xccw282c,xccw282d, 
#                      xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,
#                      xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw_m.xccwld, 
#                      g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw006,g_xccw5_d[l_ac].xccw001,
#                      g_xccw5_d[l_ac].xccw007, g_xccw5_d[l_ac].xccw008, g_xccw5_d[l_ac].xccw002,g_xccw5_d[l_ac].xccwsite, 
#                      g_xccw5_d[l_ac].xccw010, g_xccw5_d[l_ac].xccw011, g_xccw5_d[l_ac].xccw041, g_xccw5_d[l_ac].xccw042, g_xccw5_d[l_ac].xccw044,
#                      g_xccw5_d[l_ac].xccw201, g_xccw5_d[l_ac].xccw282a,g_xccw5_d[l_ac].xccw282b,g_xccw5_d[l_ac].xccw282c,
#                      g_xccw5_d[l_ac].xccw282d,g_xccw5_d[l_ac].xccw282e,g_xccw5_d[l_ac].xccw282f,g_xccw5_d[l_ac].xccw282g, 
#                      g_xccw5_d[l_ac].xccw282h,g_xccw5_d[l_ac].xccw282, g_xccw5_d[l_ac].xccw202, 
#                      g_xccw5_d[l_ac].xccw202a,g_xccw5_d[l_ac].xccw202b,g_xccw5_d[l_ac].xccw202c,g_xccw5_d[l_ac].xccw202d, 
#                      g_xccw5_d[l_ac].xccw202e,g_xccw5_d[l_ac].xccw202f,g_xccw5_d[l_ac].xccw202g,g_xccw5_d[l_ac].xccw202h) #自訂欄位頁簽
#                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
#                    AND xccw002 = g_xccw5_d_t.xccw002
#                    AND xccw003 = g_xccw_m.xccw003
#                    AND xccw004 = g_xccw_m.xccw004
#                    AND xccw005 = g_xccw_m.xccw005
#                    AND xccw006 = g_xccw_m.xccw006
#                   #AND xccw001 = g_xccw5_d_t.xccw001 #項次 
#                    AND xccw007 = g_xccw5_d_t.xccw007
#                    AND xccw008 = g_xccw5_d_t.xccw008
#                    AND xccw009 = g_xccw_d_t.xccw009
#                    AND xccw001 = '3'
#

                UPDATE xccw_t SET (xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282, 
                         xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h)
                         =
                         (g_xccw5_d[l_ac].xccw282a,g_xccw5_d[l_ac].xccw282b,g_xccw5_d[l_ac].xccw282c,
                          g_xccw5_d[l_ac].xccw282d,g_xccw5_d[l_ac].xccw282e,g_xccw5_d[l_ac].xccw282f,g_xccw5_d[l_ac].xccw282g, 
                          g_xccw5_d[l_ac].xccw282h,g_xccw5_d[l_ac].xccw282, g_xccw5_d[l_ac].xccw202, 
                          g_xccw5_d[l_ac].xccw202a,g_xccw5_d[l_ac].xccw202b,g_xccw5_d[l_ac].xccw202c,g_xccw5_d[l_ac].xccw202d, 
                          g_xccw5_d[l_ac].xccw202e,g_xccw5_d[l_ac].xccw202f,g_xccw5_d[l_ac].xccw202g,g_xccw5_d[l_ac].xccw202h)
                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                    AND xccw002 = g_xccw5_d_t.xccw002
                    AND xccw003 = g_xccw_m.xccw003
                    AND xccw004 = g_xccw_m.xccw004
                    AND xccw005 = g_xccw_m.xccw005
                    AND xccw006 = g_xccw_m.xccw006                  
                    AND xccw007 = g_xccw5_d_t.xccw007
                    AND xccw008 = g_xccw5_d_t.xccw008
                    AND xccw009 = g_xccw5_d_t.xccw009
#                    AND xccw009 = g_xccw_d[l_ac].xccw009
                    AND xccw001 = '3'   
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xccw_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xccw_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL          
               LET gs_keys[1] = g_xccw_m.xccwld
               LET gs_keys_bak[1] = g_xccwld_t
               LET gs_keys[2] = g_xccw_m.xccw003
               LET gs_keys_bak[2] = g_xccw003_t
               LET gs_keys[3] = g_xccw_m.xccw004
               LET gs_keys_bak[3] = g_xccw004_t
               LET gs_keys[4] = g_xccw_m.xccw005
               LET gs_keys_bak[4] = g_xccw005_t
               LET gs_keys[5] = g_xccw_m.xccw006
               LET gs_keys_bak[5] = g_xccw006_t
               LET gs_keys[6] = g_xccw5_d[g_detail_idx].xccw001
               LET gs_keys_bak[6] = g_xccw5_d_t.xccw001
               LET gs_keys[7] = g_xccw5_d[g_detail_idx].xccw002
               LET gs_keys_bak[7] = g_xccw5_d_t.xccw002
               LET gs_keys[8] = g_xccw5_d[g_detail_idx].xccw007
               LET gs_keys_bak[8] = g_xccw5_d_t.xccw007
               LET gs_keys[9] = g_xccw5_d[g_detail_idx].xccw008
               LET gs_keys_bak[9] = g_xccw5_d_t.xccw008
               LET gs_keys[10] = g_xccw4_d[g_detail_idx].xccw009
               LET gs_keys_bak[10] = g_xccw4_d_t.xccw009
               
               CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'5'")
                     #多語言處理
                     
               END CASE
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
         
         #---------------------<  Detail: page4  >---------------------
         #----<<xccw041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xccw041
            #add-point:BEFORE FIELD xccw041

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw041
            
            #add-point:AFTER FIELD xccw041

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw041
            #add-point:ON CHANGE xccw041

            #END add-point
 
         #----<<xccw042>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xccw042
            #add-point:BEFORE FIELD xccw042

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw042
            
            #add-point:AFTER FIELD xccw042

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw042
            #add-point:ON CHANGE xccw042

            #END add-point
 
         AFTER FIELD xccw282a_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282a,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282a
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282a) THEN 
               LET g_xccw5_d[l_ac].xccw202a = g_xccw5_d[l_ac].xccw282a * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282b_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282b,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282b
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282b) THEN 
               LET g_xccw5_d[l_ac].xccw202b = g_xccw5_d[l_ac].xccw282b * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282c_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282c,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282c
            END IF
            #160510-00037#1         
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282c) THEN 
               LET g_xccw5_d[l_ac].xccw202c = g_xccw5_d[l_ac].xccw282c * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282d_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282d,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282d
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282d) THEN 
               LET g_xccw5_d[l_ac].xccw202d = g_xccw5_d[l_ac].xccw282d * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282e_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282e,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282e
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282e) THEN 
               LET g_xccw5_d[l_ac].xccw202e = g_xccw5_d[l_ac].xccw282e * g_xccw5_d[l_ac].xccw201
            END IF
         
         AFTER FIELD xccw282f_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282f,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282f
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282f) THEN 
               LET g_xccw5_d[l_ac].xccw202f = g_xccw5_d[l_ac].xccw282f * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282g_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282g,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282g
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282g) THEN 
               LET g_xccw5_d[l_ac].xccw202g = g_xccw5_d[l_ac].xccw282g * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282h_5
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw5_d[l_ac].xccw282h,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282h
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282h) THEN 
               LET g_xccw5_d[l_ac].xccw202h = g_xccw5_d[l_ac].xccw282h * g_xccw5_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282_5
            IF NOT cl_null(g_xccw5_d[l_ac].xccw282) THEN 
               LET g_xccw5_d[l_ac].xccw202 = g_xccw5_d[l_ac].xccw282 * g_xccw5_d[l_ac].xccw201
            END IF
 
         #---------------------<  Detail: page4  >---------------------
         #----<<xccw041>>----
         #Ctrlp:input.c.page4.xccw041
         ON ACTION controlp INFIELD xccw041
            #add-point:ON ACTION controlp INFIELD xccw041

            #END add-point
 
         #----<<xccw042>>----
         #Ctrlp:input.c.page4.xccw042
         ON ACTION controlp INFIELD xccw042
            #add-point:ON ACTION controlp INFIELD xccw042

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccw5_d[l_ac].* = g_xccw5_d_t.*
               END IF
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct312_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point    
 
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xccw5_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccw5_d.getLength()+1
 
      END INPUT
      INPUT ARRAY g_xccw6_d FROM s_detail6.*
         ATTRIBUTE(COUNT = g_rec_b, MAXCOUNT = g_max_rec, WITHOUT DEFAULTS, 
                   INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 

                   DELETE ROW = FALSE,
                   APPEND ROW = FALSE)
 
         #自訂單身ACTION
         
                 
         BEFORE INPUT
            
            CALL axct312_b_fill(g_wc2) 
            IF g_rec_b != 0 THEN             
               CALL fgl_set_arr_curr(l_ac)
            END IF
            #add-point:資料輸入前

            #end add-point
 
         BEFORE ROW 
            LET l_cmd = ''
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail6")
            LET l_ac = ARR_CURR()                #returns the current row
            IF l_ac > g_rec_b THEN               #不可超過最後一筆
               CALL fgl_set_arr_curr(g_rec_b)   #moves to a specific row         
            END IF
           
            LET l_lock_sw = 'N'                  #DEFAULT
            LET l_n = ARR_COUNT()                #the number of rows containing  
            
            
            CALL s_transaction_begin()
            IF g_rec_b >= l_ac THEN
               LET l_cmd='u'
               CALL axct312_set_entry_b(l_cmd)
               CALL axct312_set_no_entry_b(l_cmd)
               LET g_xccw6_d_t.* = g_xccw6_d[l_ac].*   #BACKUP  #page1
               CALL axct312_set_no_entry_b(l_cmd)
               OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                g_xccw_m.xccw003,
                                                g_xccw_m.xccw004,
                                                g_xccw_m.xccw005,
                                                g_xccw_m.xccw006,
 
                                                g_xccw6_d_t.xccw001
                                                ,g_xccw6_d_t.xccw002
                                                ,g_xccw6_d_t.xccw007
                                                ,g_xccw6_d_t.xccw008
                                                ,g_xccw6_d_t.xccw009
 
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "OPEN axct312_bcl:" 
                  LET g_errparam.code   =  STATUS 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
 
                  LET l_lock_sw='Y'
               END IF
            END IF 
            CALL axct312_b_fill_1(g_wc2)
            LET l_ac = ARR_CURR()
            #多个币种资料一起锁
            IF l_cmd='u' THEN
              
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '1'
                                                     ,g_xccw6_d_t.xccw002
                                                     ,g_xccw6_d_t.xccw007
                                                     ,g_xccw6_d_t.xccw008
                                                     ,g_xccw6_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               
               IF g_glaa019 = 'Y' THEN
                  OPEN axct312_bcl USING g_enterprise,g_xccw_m.xccwld,
                                                     g_xccw_m.xccw003,
                                                     g_xccw_m.xccw004,
                                                     g_xccw_m.xccw005,
                                                     g_xccw_m.xccw006,
                    
                                                    '3' 
                                                     ,g_xccw6_d_t.xccw002
                                                     ,g_xccw6_d_t.xccw007
                                                     ,g_xccw6_d_t.xccw008
                                                     ,g_xccw6_d_t.xccw009
                    
                  IF STATUS THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "OPEN axct312_bcl:" 
                     LET g_errparam.code   =  STATUS 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  
                     LET l_lock_sw='Y'
                  END IF
               END IF
            END IF
            
             
         BEFORE INSERT
            LET g_insert = 'Y' 
            NEXT FIELD xccw001
 
            INITIALIZE g_xccw6_d_t.* TO NULL
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_xccw6_d[l_ac].* TO NULL
            
            #公用欄位預設值
            #此段落由子樣板a14產生    
     
      ##LET .xcckstus = ""
 
  
            
            #一般欄位預設值
            
            
            
            LET g_xccw6_d_t.* = g_xccw6_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL axct312_set_entry_b(l_cmd)
            CALL axct312_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_xccw_d[li_reproduce_target].* = g_xccw_d[li_reproduce].*
               LET g_xccw2_d[li_reproduce_target].* = g_xccw2_d[li_reproduce].*
               LET g_xccw3_d[li_reproduce_target].* = g_xccw3_d[li_reproduce].*
               LET g_xccw6_d[li_reproduce_target].* = g_xccw6_d[li_reproduce].*
               LET g_xccw6_d[li_reproduce_target].* = g_xccw6_d[li_reproduce].*
 
               LET g_xccw6_d[li_reproduce_target].xccw001 = NULL
               LET g_xccw6_d[li_reproduce_target].xccw009 = NULL
               LET g_xccw6_d[li_reproduce_target].xccw007 = NULL
               LET g_xccw6_d[li_reproduce_target].xccw008 = NULL
            END IF
            
            #add-point:modify段before insert
 
            #end add-point
            
         BEFORE DELETE                            #是否取消單身
            IF l_cmd = 'a' AND g_xccw6_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_xccw_d.deleteElement(l_ac)
               NEXT FIELD xccw001
            END IF
            IF g_xccw_d_t.xccw001 IS NOT NULL
               AND g_xccw_d_t.xccw010 IS NOT NULL
               AND g_xccw_d_t.xccw007 IS NOT NULL
               AND g_xccw_d_t.xccw008 IS NOT NULL
            THEN
               CALL s_transaction_begin()  #140909
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               IF axct312_before_delete() THEN 
                  CALL s_transaction_end('Y','0')
               ELSE 
                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               END IF 
               CLOSE axct312_bcl
               CALL s_transaction_end('Y','0') 
               LET l_count = g_xccw6_d.getLength()
            END IF
            
         AFTER DELETE 
 
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_xccw6_d[l_ac].* = g_xccw6_d_t.*
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xccw_d[l_ac].xccw001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_xccw6_d[l_ac].* = g_xccw6_d_t.*
            ELSE
               #寫入修改者/修改日期資訊
               
                
               #add-point:單身修改前
               LET g_xccw6_d[l_ac].xccw282 = g_xccw6_d[l_ac].xccw282a + g_xccw6_d[l_ac].xccw282b +
                                             g_xccw6_d[l_ac].xccw282c + g_xccw6_d[l_ac].xccw282d +
                                             g_xccw6_d[l_ac].xccw282e + g_xccw6_d[l_ac].xccw282f +
                                             g_xccw6_d[l_ac].xccw282g + g_xccw6_d[l_ac].xccw282h
               LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw202a + g_xccw6_d[l_ac].xccw202b +
                                             g_xccw6_d[l_ac].xccw202c + g_xccw6_d[l_ac].xccw202d +
                                             g_xccw6_d[l_ac].xccw202e + g_xccw6_d[l_ac].xccw202f +
                                             g_xccw6_d[l_ac].xccw202g + g_xccw6_d[l_ac].xccw202h
               CALL s_transaction_begin()  #140909
               #end add-point
#               UPDATE xccw_t SET (xccwld,xccw003,xccw004,xccw005,xccw006,xccw001,xccw007,xccw008,xccw002, 
#                      xccwsite,xccw010,xccw011,xccw041,xccw042,xccw044,xccw201,xccw282a,xccw282b,xccw282c,xccw282d, 
#                      xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,
#                      xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw_m.xccwld, 
#                      g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw006,g_xccw6_d[l_ac].xccw001,
#                      g_xccw6_d[l_ac].xccw007, g_xccw6_d[l_ac].xccw008, g_xccw6_d[l_ac].xccw002,g_xccw6_d[l_ac].xccwsite, 
#                      g_xccw6_d[l_ac].xccw010, g_xccw6_d[l_ac].xccw011, g_xccw6_d[l_ac].xccw041, g_xccw6_d[l_ac].xccw042, g_xccw6_d[l_ac].xccw044,
#                      g_xccw6_d[l_ac].xccw201, g_xccw6_d[l_ac].xccw282a,g_xccw6_d[l_ac].xccw282b,g_xccw6_d[l_ac].xccw282c,
#                      g_xccw6_d[l_ac].xccw282d,g_xccw6_d[l_ac].xccw282e,g_xccw6_d[l_ac].xccw282f,g_xccw6_d[l_ac].xccw282g, 
#                      g_xccw6_d[l_ac].xccw282h,g_xccw6_d[l_ac].xccw282, g_xccw6_d[l_ac].xccw202, 
#                      g_xccw6_d[l_ac].xccw202a,g_xccw6_d[l_ac].xccw202b,g_xccw6_d[l_ac].xccw202c,g_xccw6_d[l_ac].xccw202d, 
#                      g_xccw6_d[l_ac].xccw202e,g_xccw6_d[l_ac].xccw202f,g_xccw6_d[l_ac].xccw202g,g_xccw6_d[l_ac].xccw202h) #自訂欄位頁簽
#                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
#                    AND xccw002 = g_xccw6_d_t.xccw002
#                    AND xccw003 = g_xccw_m.xccw003
#                    AND xccw004 = g_xccw_m.xccw004
#                    AND xccw005 = g_xccw_m.xccw005
#                    AND xccw006 = g_xccw_m.xccw006
#                   #AND xccw001 = g_xccw6_d_t.xccw001 #項次 
#                    AND xccw007 = g_xccw6_d_t.xccw007
#                    AND xccw008 = g_xccw6_d_t.xccw008
#                    AND xccw009 = g_xccw_d_t.xccw009
#                    AND xccw001 = '3'
#

                UPDATE xccw_t SET (xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282, 
                         xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h)
                         =
                         (g_xccw6_d[l_ac].xccw282a,g_xccw6_d[l_ac].xccw282b,g_xccw6_d[l_ac].xccw282c,
                          g_xccw6_d[l_ac].xccw282d,g_xccw6_d[l_ac].xccw282e,g_xccw6_d[l_ac].xccw282f,g_xccw6_d[l_ac].xccw282g, 
                          g_xccw6_d[l_ac].xccw282h,g_xccw6_d[l_ac].xccw282, g_xccw6_d[l_ac].xccw202, 
                          g_xccw6_d[l_ac].xccw202a,g_xccw6_d[l_ac].xccw202b,g_xccw6_d[l_ac].xccw202c,g_xccw6_d[l_ac].xccw202d, 
                          g_xccw6_d[l_ac].xccw202e,g_xccw6_d[l_ac].xccw202f,g_xccw6_d[l_ac].xccw202g,g_xccw6_d[l_ac].xccw202h)
                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                    AND xccw002 = g_xccw6_d_t.xccw002
                    AND xccw003 = g_xccw_m.xccw003
                    AND xccw004 = g_xccw_m.xccw004
                    AND xccw005 = g_xccw_m.xccw005
                    AND xccw006 = g_xccw_m.xccw006                  
                    AND xccw007 = g_xccw6_d_t.xccw007
                    AND xccw008 = g_xccw6_d_t.xccw008
                    AND xccw009 = g_xccw6_d_t.xccw009
                   #AND xccw009 = g_xccw_d[l_ac].xccw009
                    AND xccw001 = '2'   
               #add-point:單身修改中

               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "xccw_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "xccw_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                  OTHERWISE
                                    INITIALIZE gs_keys TO NULL          
               LET gs_keys[1] = g_xccw_m.xccwld
               LET gs_keys_bak[1] = g_xccwld_t
               LET gs_keys[2] = g_xccw_m.xccw003
               LET gs_keys_bak[2] = g_xccw003_t
               LET gs_keys[3] = g_xccw_m.xccw004
               LET gs_keys_bak[3] = g_xccw004_t
               LET gs_keys[4] = g_xccw_m.xccw005
               LET gs_keys_bak[4] = g_xccw005_t
               LET gs_keys[5] = g_xccw_m.xccw006
               LET gs_keys_bak[5] = g_xccw006_t
               LET gs_keys[6] = g_xccw6_d[g_detail_idx].xccw001
               LET gs_keys_bak[6] = g_xccw6_d_t.xccw001
               LET gs_keys[7] = g_xccw6_d[g_detail_idx].xccw002
               LET gs_keys_bak[7] = g_xccw6_d_t.xccw002
               LET gs_keys[8] = g_xccw6_d[g_detail_idx].xccw007
               LET gs_keys_bak[8] = g_xccw6_d_t.xccw007
               LET gs_keys[9] = g_xccw6_d[g_detail_idx].xccw008
               LET gs_keys_bak[9] = g_xccw6_d_t.xccw008
               LET gs_keys[10] = g_xccw4_d[g_detail_idx].xccw009
               LET gs_keys_bak[10] = g_xccw4_d_t.xccw009
               
               CALL axct312_update_b('xccw_t',gs_keys,gs_keys_bak,"'5'")
                     #多語言處理
                     
               END CASE
               
               #add-point:單身修改後
               CALL s_transaction_end('Y','0') #140909
               #end add-point
            END IF
         
         #---------------------<  Detail: page4  >---------------------
         #----<<xccw041>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xccw041
            #add-point:BEFORE FIELD xccw041

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw041
            
            #add-point:AFTER FIELD xccw041

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw041
            #add-point:ON CHANGE xccw041

            #END add-point
 
         #----<<xccw042>>----
         #此段落由子樣板a01產生
         BEFORE FIELD xccw042
            #add-point:BEFORE FIELD xccw042

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD xccw042
            
            #add-point:AFTER FIELD xccw042

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE xccw042
            #add-point:ON CHANGE xccw042

            #END add-point
 
         AFTER FIELD xccw282a_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282a,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282a
            END IF
            #160510-00037#1          
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282a) THEN 
               LET g_xccw6_d[l_ac].xccw202a = g_xccw6_d[l_ac].xccw282a * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282b_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282b,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282b
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282b) THEN 
               LET g_xccw6_d[l_ac].xccw202b = g_xccw6_d[l_ac].xccw282b * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282c_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282c,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282c
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282c) THEN 
               LET g_xccw6_d[l_ac].xccw202c = g_xccw6_d[l_ac].xccw282c * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282d_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282d,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282d
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282d) THEN 
               LET g_xccw6_d[l_ac].xccw202d = g_xccw6_d[l_ac].xccw282d * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282e_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282e,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282e
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282e) THEN 
               LET g_xccw6_d[l_ac].xccw202e = g_xccw6_d[l_ac].xccw282e * g_xccw6_d[l_ac].xccw201
            END IF
         
         AFTER FIELD xccw282f_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282f,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282f
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282f) THEN 
               LET g_xccw6_d[l_ac].xccw202f = g_xccw6_d[l_ac].xccw282f * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282g_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw202g,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw202g
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282g) THEN 
               LET g_xccw6_d[l_ac].xccw202g = g_xccw6_d[l_ac].xccw282g * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282h_6
            #160510-00037#1
            IF NOT cl_ap_chk_range(g_xccw6_d[l_ac].xccw282h,"0","1","","","azz-00079",1) THEN
               NEXT FIELD xccw282h
            END IF
            #160510-00037#1           
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282h) THEN 
               LET g_xccw6_d[l_ac].xccw202h = g_xccw6_d[l_ac].xccw282h * g_xccw6_d[l_ac].xccw201
            END IF
            
         AFTER FIELD xccw282_6          
            IF NOT cl_null(g_xccw6_d[l_ac].xccw282) THEN 
               LET g_xccw6_d[l_ac].xccw202 = g_xccw6_d[l_ac].xccw282 * g_xccw6_d[l_ac].xccw201
            END IF
 
         #---------------------<  Detail: page4  >---------------------
         #----<<xccw041>>----
         #Ctrlp:input.c.page4.xccw041
         ON ACTION controlp INFIELD xccw041
            #add-point:ON ACTION controlp INFIELD xccw041

            #END add-point
 
         #----<<xccw042>>----
         #Ctrlp:input.c.page4.xccw042
         ON ACTION controlp INFIELD xccw042
            #add-point:ON ACTION controlp INFIELD xccw042

            #END add-point
 
 
 
         AFTER ROW
            LET l_ac = ARR_CURR()
            LET l_ac_t = l_ac
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_xccw6_d[l_ac].* = g_xccw6_d_t.*
               END IF
               CLOSE axct312_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
 
            CLOSE axct312_bcl
            CALL s_transaction_end('Y','0')
 
         AFTER INPUT
            #add-point:input段after input 

            #end add-point    
 
         ON ACTION controlo
            CALL FGL_SET_ARR_CURR(g_xccw6_d.getLength()+1)
            LET lb_reproduce = TRUE
            LET li_reproduce = l_ac
            LET li_reproduce_target = g_xccw6_d.getLength()+1
 
      END INPUT
      #end add-point    
      
      BEFORE DIALOG
         #CALL cl_err_collect_init()    
         #add-point:input段before_dialog
         IF p_cmd = 'a' THEN
            NEXT FIELD xccwld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccw001
               WHEN "s_detail2"
                  NEXT FIELD xccw001_2
               WHEN "s_detail3"
                  NEXT FIELD xccw001_3
               WHEN "s_detail4"
                  NEXT FIELD xccw001_4
               WHEN "s_detail5"
                  NEXT FIELD xccw001_5
               WHEN "s_detail6"
                  NEXT FIELD xccw001_6
            END CASE
         END IF
         #end add-point 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            NEXT FIELD xccwld
        ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD xccw001
               WHEN "s_detail2"
                  NEXT FIELD xccw001_2
               WHEN "s_detail3"
                  NEXT FIELD xccw001_3
 
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
   
   #add-point:input段after_input

   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION axct312_show()
   #add-point:show段define
   
   #end add-point
   
   #add-point:show段之前
   CALL axct312_show_ref()
   CALL cl_set_act_visible("reproduce", FALSE)
   CALL axct312_visible()
   #end add-point
   
   IF g_bfill = "Y" THEN
      CALL axct312_b_fill(g_wc2) #單身填充
      CALL axct312_b_fill2('0') #單身填充
   END IF
   
   
 
   #顯示followup圖示
   #+ 此段落由子樣板a48產生
   CALL axct312_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
 
 
   
   DISPLAY BY NAME g_xccw_m.xccwld,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp,g_xccw_m.xccwcomp_desc,g_xccw_m.xccw003, 
       g_xccw_m.xccw003_desc,g_xccw_m.xccw012,g_xccw_m.xccw006,g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005, 
       g_xccw_m.xcat003
   CALL axct312_b_fill(g_wc2_table1)                 #單身
   CALL axct312_b_fill2('0') #單身填充
 
   CALL axct312_ref_show()
 
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()  
 
   #add-point:show段之後
   IF g_xccw_m.xcat003 = '2' THEN 
      CALL cl_set_act_visible("modify,modify_detail", FALSE)
   ELSE
      CALL cl_set_act_visible("modify,modify_detail", TRUE)
   END IF
   #end add-point   
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.ref_show" >}
#+ 帶出reference資料
PRIVATE FUNCTION axct312_ref_show()
   DEFINE l_ac_t LIKE type_t.num10 #l_ac暫存用
   #add-point:ref_show段define
   
   #end add-point
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:ref_show段m_reference

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_xccw_m.xccwld
            #CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_xccw_m.xccwld_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_xccw_m.xccwld_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_xccw_m.xccwcomp
            #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            #LET g_xccw_m.xccwcomp_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_xccw_m.xccwcomp_desc

   #end add-point
 
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_xccw_d.getLength()
      #add-point:ref_show段d_reference
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_xccw2_d.getLength()
      #add-point:ref_show段d2_reference

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xccw2_d[l_ac].xcckownid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xccw2_d[l_ac].xcckownid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xccw2_d[l_ac].xcckownid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xccw2_d[l_ac].xcckowndp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xccw2_d[l_ac].xcckowndp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xccw2_d[l_ac].xcckowndp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xccw2_d[l_ac].xcckcrtid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xccw2_d[l_ac].xcckcrtid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xccw2_d[l_ac].xcckcrtid_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xccw2_d[l_ac].xcckcrtdp
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
#            LET g_xccw2_d[l_ac].xcckcrtdp_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xccw2_d[l_ac].xcckcrtdp_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_xccw2_d[l_ac].xcckmodid
#            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
#            LET g_xccw2_d[l_ac].xcckmodid_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_xccw2_d[l_ac].xcckmodid_desc
#
      #end add-point
   END FOR
   FOR l_ac = 1 TO g_xccw3_d.getLength()
      #add-point:ref_show段d3_reference
      
      #end add-point
   END FOR
 
   
   #add-point:ref_show段自訂
   
   #end add-point
   
   LET l_ac = l_ac_t
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION axct312_reproduce()
   DEFINE l_newno     LIKE xccw_t.xccwld 
   DEFINE l_oldno     LIKE xccw_t.xccwld 
   DEFINE l_newno02     LIKE xccw_t.xccw003 
   DEFINE l_oldno02     LIKE xccw_t.xccw003 
   DEFINE l_newno03     LIKE xccw_t.xccw004 
   DEFINE l_oldno03     LIKE xccw_t.xccw004 
   DEFINE l_newno04     LIKE xccw_t.xccw005 
   DEFINE l_oldno04     LIKE xccw_t.xccw005 
   DEFINE l_newno05     LIKE xccw_t.xccw006 
   DEFINE l_oldno05     LIKE xccw_t.xccw006 
 
   DEFINE l_master    RECORD LIKE xccw_t.*
   DEFINE l_detail    RECORD LIKE xccw_t.*
 
   DEFINE l_cnt       LIKE type_t.num5
   #add-point:reproduce段define
   
   #end add-point
 
   #切換畫面
   IF g_main_hidden THEN
      CALL gfrm_curr.setElementHidden("mainlayout",0)
      CALL gfrm_curr.setElementHidden("worksheet",1)
      LET g_main_hidden = 0
   END IF     
 
   IF g_xccw_m.xccwld IS NULL
      OR g_xccw_m.xccw003 IS NULL
      OR g_xccw_m.xccw004 IS NULL
      OR g_xccw_m.xccw005 IS NULL
      OR g_xccw_m.xccw006 IS NULL
 
      THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
   
   LET g_xccwld_t = g_xccw_m.xccwld
   LET g_xccw003_t = g_xccw_m.xccw003
   LET g_xccw004_t = g_xccw_m.xccw004
   LET g_xccw005_t = g_xccw_m.xccw005
   LET g_xccw006_t = g_xccw_m.xccw006
 
   
   LET g_xccw_m.xccwld = ""
   LET g_xccw_m.xccw003 = ""
   LET g_xccw_m.xccw004 = ""
   LET g_xccw_m.xccw005 = ""
   LET g_xccw_m.xccw006 = ""
 
    
   CALL axct312_set_entry('a')
   CALL axct312_set_no_entry('a')
   
   CALL cl_set_head_visible("","YES")
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   CALL axct312_input("r")
   
      LET g_xccw_m.xccwld_desc = ''
   DISPLAY BY NAME g_xccw_m.xccwld_desc
   LET g_xccw_m.xccw003_desc = ''
   DISPLAY BY NAME g_xccw_m.xccw003_desc
 
    
   IF INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      INITIALIZE g_xccw_m.* TO NULL
      INITIALIZE g_xccw_d TO NULL
      INITIALIZE g_xccw2_d TO NULL
      INITIALIZE g_xccw3_d TO NULL
 
      CALL axct312_show()
      LET INT_FLAG = 0
      RETURN
   END IF
   
   #將新增的資料併入搜尋條件中
   LET g_state = "Y"
   LET g_current_idx = 1 
   
   LET g_xccwld_t = g_xccw_m.xccwld
   LET g_xccw003_t = g_xccw_m.xccw003
   LET g_xccw004_t = g_xccw_m.xccw004
   LET g_xccw005_t = g_xccw_m.xccw005
   LET g_xccw006_t = g_xccw_m.xccw006
 
   
   LET g_current_idx = g_browser.getLength() + 1
   LET g_browser[g_current_idx].b_xccwld = g_xccw_m.xccwld
   LET g_browser[g_current_idx].b_xccw003 = g_xccw_m.xccw003
   LET g_browser[g_current_idx].b_xccw004 = g_xccw_m.xccw004
   LET g_browser[g_current_idx].b_xccw005 = g_xccw_m.xccw005
   LET g_browser[g_current_idx].b_xccw006 = g_xccw_m.xccw006
 
   
   LET g_detail_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_detail_cnt)
   
   #LET g_wc = "(", g_wc,  
   #           " OR (",
   #           " xccwld = '", g_xccw_m.xccwld CLIPPED, "' "
   #           ," AND xccw003 = '", g_xccw_m.xccw003 CLIPPED, "' "
   #           ," AND xccw004 = '", g_xccw_m.xccw004 CLIPPED, "' "
   #           ," AND xccw005 = '", g_xccw_m.xccw005 CLIPPED, "' "
   #           ," AND xccw006 = '", g_xccw_m.xccw006 CLIPPED, "' "
 
   #           , ")) "
   
   #add-point:完成複製段落後
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION axct312_detail_reproduce()
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE xccw_t.*
 
 
   #add-point:delete段define

   #end add-point    
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE axct312_detail
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axct312_detail AS ",
                "SELECT * FROM xccw_t "
   PREPARE repro_tbl FROM ls_sql
   EXECUTE repro_tbl
   FREE repro_tbl
                
   #將符合條件的資料丟入TEMP TABLE
   INSERT INTO axct312_detail SELECT * FROM xccw_t 
                                         WHERE xccwent = g_enterprise AND xccwld = g_xccwld_t
                                         AND xccw003 = g_xccw003_t
                                         AND xccw004 = g_xccw004_t
                                         AND xccw005 = g_xccw005_t
                                         AND xccw006 = g_xccw006_t
 
   
   #將key修正為調整後   
   UPDATE axct312_detail 
      #更新key欄位
      SET xccwld = g_xccw_m.xccwld
          , xccw003 = g_xccw_m.xccw003
          , xccw004 = g_xccw_m.xccw004
          , xccw005 = g_xccw_m.xccw005
          , xccw006 = g_xccw_m.xccw006
 
      #更新共用欄位
      
                                       
   #將資料塞回原table   
   INSERT INTO xccw_t SELECT * FROM axct312_detail
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct312_detail
   
   #add-point:單身複製後1

   #end add-point
 
 
   
 
   
   #多語言複製段落
      #此段落由子樣板a38產生
   #單身多語言複製
   DROP TABLE axct312_detail_lang
   
   #add-point:單身複製前1

   #end add-point
   
   #CREATE TEMP TABLE
   LET ls_sql = "CREATE GLOBAL TEMPORARY TABLE axct312_detail_lang AS ",
                "SELECT * FROM xcck_t "
   PREPARE repro_xcck_t FROM ls_sql
   EXECUTE repro_xcck_t
   FREE repro_xcck_t
                
   #將符合條件的資料丟入TEMP TABLE
 #  INSERT INTO axct312_detail_lang SELECT * FROM xcck_t 
 #                                            WHERE xcckent = g_enterprise AND  = g_xccwld_t
 #                                            AND  = g_xccw003_t                                             AND  = g_xccw004_t                                             AND  = g_xccw005_t                                             AND  = g_xccw006_t
 #  
 #  #將key修正為調整後   
 #  UPDATE axct312_detail_lang 
 #     #更新key欄位
 #     SET  = g_xccw_m.xccwld
 #         ,  = g_xccw_m.xccw003          ,  = g_xccw_m.xccw004          ,  = g_xccw_m.xccw005          ,  = g_xccw_m.xccw006
  
   #將資料塞回原table   
   INSERT INTO xcck_t SELECT * FROM axct312_detail_lang
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "reproduce" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   END IF
   
   #add-point:單身複製中1

   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE axct312_detail_lang
   
   #add-point:單身複製後1

   #end add-point
 
 
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_xccwld_t = g_xccw_m.xccwld
   LET g_xccw003_t = g_xccw_m.xccw003
   LET g_xccw004_t = g_xccw_m.xccw004
   LET g_xccw005_t = g_xccw_m.xccw005
   LET g_xccw006_t = g_xccw_m.xccw006
 
   
   DROP TABLE axct312_detail
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.delete" >}
#+ 資料刪除
PRIVATE FUNCTION axct312_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point     
   
   IF g_xccw_m.xccwld IS NULL
   OR g_xccw_m.xccw003 IS NULL
   OR g_xccw_m.xccw004 IS NULL
   OR g_xccw_m.xccw005 IS NULL
   OR g_xccw_m.xccw006 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      RETURN
   END IF
 
   EXECUTE axct312_master_referesh USING g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005, 
       g_xccw_m.xccw006 INTO g_xccw_m.xccwld,g_xccw_m.xccwcomp,g_xccw_m.xccw003,g_xccw_m.xccw012,g_xccw_m.xccw006, 
       g_xccw_m.xccw013,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003_desc
   
   CALL axct312_show()
   
   CALL s_transaction_begin()
   
   
 
   OPEN axct312_cl USING g_enterprise,g_xccw_m.xccwld
                                                       ,g_xccw_m.xccw003
                                                       ,g_xccw_m.xccw004
                                                       ,g_xccw_m.xccw005
                                                       ,g_xccw_m.xccw006
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN axct312_cl:" 
      LET g_errparam.code   =  STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      CLOSE axct312_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #鎖住將被更改或取消的資料
   FETCH axct312_cl INTO g_xccw_m.xccwld,g_xccw_m.xccwld_desc,g_xccw_m.xccwcomp,g_xccw_m.xccwcomp_desc, 
       g_xccw_m.xccw003,g_xccw_m.xccw003_desc,g_xccw_m.xccw012,g_xccw_m.xccw006,g_xccw_m.xccw013,g_xccw_m.xccw004, 
       g_xccw_m.xccw005,g_xccw_m.xcat003
   
   #若資料已被他人LOCK
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = g_xccw_m.xccwld 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #IF NOT cl_ask_delete() THEN             #確認一下
   IF cl_ask_del_master() THEN              #確認一下
      #+ 此段落由子樣板a47產生
      #刪除相關文件
      CALL axct312_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
  
 
      #add-point:單身刪除前
      
      #end add-point
      
      DELETE FROM xccw_t WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                                                               AND xccw003 = g_xccw_m.xccw003
                                                               AND xccw004 = g_xccw_m.xccw004
                                                               AND xccw005 = g_xccw_m.xccw005
                                                               AND xccw006 = g_xccw_m.xccw006
 
                                                               
      #add-point:單身刪除中
      
      #end add-point
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccw_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
 
         CALL s_transaction_end('N','0')
      END IF
 
      
  
      #add-point:單身刪除後 
      
      #end add-point
      
 
      
      CLEAR FORM
      CALL g_xccw_d.clear() 
      CALL g_xccw2_d.clear()       
      CALL g_xccw3_d.clear()       
 
     
      CALL axct312_ui_browser_refresh()  
      CALL axct312_ui_headershow()  
      CALL axct312_ui_detailshow()
       
      IF g_browser_cnt > 0 THEN 
         CALL axct312_fetch('P')
      ELSE
         LET g_wc = " 1=1"
         LET g_wc2 = " 1=1"
         CALL axct312_browser_fill("F")
      END IF
       
   END IF
 
   CLOSE axct312_cl
   CALL s_transaction_end('Y','0')
 
   #流程通知預埋點-D
   CALL cl_flow_notify(g_xccw_m.xccwld,'D')
    
END FUNCTION
 
{</section>}
 
{<section id="axct312.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axct312_b_fill(p_wc2)
   DEFINE p_wc2      STRING
   #add-point:b_fill段define
   IF 1=1 THEN 
      CALL axct312_b_fill_1(p_wc2)
      RETURN 
   END IF
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xccw_d.clear()
   CALL g_xccw2_d.clear()
   CALL g_xccw3_d.clear()
 
 
   #add-point:b_fill段sql_before

   #end add-point
   
   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw015,xccw016, 
       xccw017,xccw009,xccw020,xccw021,xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c, 
       xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,xccw202d, 
       xccw202e,xccw202f,xccw202g,xccw202h,xccw001,xccw007,xccw008,xccw002,xccw010,xccw011,xccw001,xccw007, 
       xccw008,xccw002,xccwsite,xccw010,xccw011,xccw021,xccw032,xccw033,xccw022,xccw023,xccw024,xccw025, 
       xccw026,xccw027,xccw028,xccw029,xccw030,xccw031,xccw201,xccw282,xccw202,xccw009 FROM xccw_t", 
          
             # " LEFT JOIN xcck_t ON xcckent = '"||g_enterprise||"' AND xccwld = xccw003 = xccw004 = xccw005 = xccw006 = xccw001 = xccw002 = xccw007 = xccw008 = xccw009 =",
               
               
               " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=?" 
 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED, cl_sql_add_filter("xccw_t")
   END IF
   
   #add-point:b_fill段sql_after
 
   #end add-point
   
   #子單身的WC
   
   
   #判斷是否填充
   IF axct312_fill_chk(1) THEN
      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw002,xccw_t.xccw007,xccw_t.xccw008,xccw_t.xccw009"
      
      #add-point:b_fill段fill_before

      #end add-point
      
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axct312_pb FROM g_sql
      DECLARE b_fill_cs CURSOR FOR axct312_pb
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs USING g_enterprise,g_xccw_m.xccwld,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,g_xccw_m.xccw006
                                               
      FOREACH b_fill_cs INTO g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008,g_xccw_d[l_ac].xccw002, 
          g_xccw_d[l_ac].xccwsite,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw015, 
          g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009,g_xccw_d[l_ac].xccw020, 
          g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046,g_xccw_d[l_ac].xccw044, 
          g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a,g_xccw_d[l_ac].xccw282b, 
          g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e,g_xccw_d[l_ac].xccw282f, 
          g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282,g_xccw_d[l_ac].xccw202, 
          g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c,g_xccw_d[l_ac].xccw202d, 
          g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g,g_xccw_d[l_ac].xccw202h, 
          g_xccw2_d[l_ac].xccw001,g_xccw2_d[l_ac].xccw007,g_xccw2_d[l_ac].xccw008,g_xccw2_d[l_ac].xccw002, 
          g_xccw2_d[l_ac].xccw010,g_xccw2_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw001,g_xccw3_d[l_ac].xccw007, 
          g_xccw3_d[l_ac].xccw008,g_xccw3_d[l_ac].xccw002,g_xccw3_d[l_ac].xccwsite,g_xccw3_d[l_ac].xccw010, 
          g_xccw3_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw021,g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033, 
          g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024,g_xccw3_d[l_ac].xccw025, 
          g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028,g_xccw3_d[l_ac].xccw029, 
          g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031,g_xccw3_d[l_ac].xccw201,g_xccw3_d[l_ac].xccw282, 
          g_xccw3_d[l_ac].xccw202,g_xccw3_d[l_ac].xccw009
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

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
 
            CALL g_xccw_d.deleteElement(g_xccw_d.getLength())
      CALL g_xccw2_d.deleteElement(g_xccw2_d.getLength())
      CALL g_xccw3_d.deleteElement(g_xccw3_d.getLength())
 
      
   END IF
   
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct312_pb   
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axct312_b_fill2(pi_idx)
   DEFINE pi_idx          LIKE type_t.num5
   DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define
 
   #end add-point
   
   LET li_ac = l_ac 
   
 
      
   #add-point:單身填充後
   
   #end add-point
    
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.before_delete" >}
#+ 單身db資料刪除
PRIVATE FUNCTION axct312_before_delete()
   #add-point:before_delete段define
   
   #end add-point 
   
   #add-point:單筆刪除前
   
   #end add-point
   
   DELETE FROM xccw_t
    WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld AND
                              xccw003 = g_xccw_m.xccw003 AND
                              xccw004 = g_xccw_m.xccw004 AND
                              xccw005 = g_xccw_m.xccw005 AND
                              xccw006 = g_xccw_m.xccw006 AND
 
          xccw001 = g_xccw_d_t.xccw001
      AND xccw002 = g_xccw_d_t.xccw002
      AND xccw007 = g_xccw_d_t.xccw007
      AND xccw008 = g_xccw_d_t.xccw008
      AND xccw009 = g_xccw_d_t.xccw009
 
      
   #add-point:單筆刪除中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccw_t" 
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
 
{</section>}
 
{<section id="axct312.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION axct312_delete_b(ps_table,ps_keys_bak,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys_bak DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   #add-point:delete_b段define
   
   #end add-point     
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION axct312_insert_b(ps_table,ps_keys,ps_page)
   DEFINE ps_table    STRING
   DEFINE ps_page     STRING
   DEFINE ps_keys     DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group    STRING
   DEFINE ls_page     STRING
   #add-point:insert_b段define
   
   #end add-point     
   
 
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION axct312_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
   DEFINE ps_table         STRING
   DEFINE ps_page          STRING
   DEFINE ps_keys          DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_keys_bak      DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ls_group         STRING
   DEFINE li_idx           LIKE type_t.num5 
   DEFINE lb_chk           BOOLEAN
   DEFINE l_new_key        DYNAMIC ARRAY OF STRING
   DEFINE l_old_key        DYNAMIC ARRAY OF STRING
   DEFINE l_field_key      DYNAMIC ARRAY OF STRING
   #add-point:update_b段define
   
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
 
{<section id="axct312.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION axct312_lock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:lock_b段define
   
   #end add-point   
   
   #先刷新資料
   #CALL axct312_b_fill()
   
 
   
   RETURN TRUE
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION axct312_unlock_b(ps_table,ps_page)
   DEFINE ps_page     STRING
   DEFINE ps_table    STRING
   DEFINE ls_group    STRING
   #add-point:unlock_b段define
   
   #end add-point  
   
 
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION axct312_set_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define
   
   #end add-point       
 
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("xccwld,xccw003,xccw004,xccw005,xccw006",TRUE)
      #add-point:set_entry段欄位控制
      CALL cl_set_comp_required("xccwld,xccw003,xccw006",TRUE)
      CALL cl_set_comp_entry("xccw004,xccw005",FALSE)
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   

   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION axct312_set_no_entry(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define
   
   #end add-point     
 
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("xccwld,xccw003,xccw004,xccw005,xccw006",FALSE)
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION axct312_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_entry_b段define
   
   #end add-point     
   
   #add-point:set_entry_b段
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION axct312_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry_b段define
   
   #end add-point    
   
   #add-point:set_no_entry_b段
 
   #end add-point 
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION axct312_default_search()
   DEFINE li_idx  LIKE type_t.num5
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " xccwld = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccw003 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccw004 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccw005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccw006 = '", g_argv[05], "' AND "
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
   
   #add-point:default_search段結束前
   LET ls_wc =' '
   IF NOT cl_null(g_argv[1]) THEN
      LET ls_wc = " xccw012 = '", g_argv[1], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " xccwld = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET ls_wc = ls_wc, " xccw003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET ls_wc = ls_wc, " xccw004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET ls_wc = ls_wc, " xccw005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET ls_wc = ls_wc, " xccw006 = '", g_argv[06], "' AND "
   END IF
   
   IF NOT cl_null(ls_wc) THEN
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
   ELSE
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
#   DISPLAY "axct312 g_wc=",g_wc  

   LET g_wc = " 1=2"   #fengmy150226 打开画面不查询

 
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION axct312_fill_chk(ps_idx)
   DEFINE ps_idx        LIKE type_t.chr10
   DEFINE lst_token     base.StringTokenizer
   DEFINE ls_token      STRING
   #add-point:fill_chk段define
   
   #end add-point
   
   #全部為1=1 or null時回傳true
   IF (cl_null(g_wc2_table1) OR g_wc2_table1.trim() = '1=1') THEN
      RETURN TRUE
   END IF
   
   #第一單身
   IF ps_idx = 1 AND
      ((NOT cl_null(g_wc2_table1) AND g_wc2_table1.trim() <> '1=1')) THEN
      RETURN TRUE
   END IF
   
   #根據wc判定是否需要填充
 
 
   
   #add-point:fill_chk段other
   
   #end add-point
   
   RETURN FALSE
 
END FUNCTION
 
{</section>}
 
{<section id="axct312.modify_detail_chk" >}
#+ 單身輸入判定
PRIVATE FUNCTION axct312_modify_detail_chk(ps_record)
   DEFINE ps_record STRING
   DEFINE ls_return STRING
   #add-point:modify_detail_chk段define
   
   #end add-point
   
   #add-point:modify_detail_chk段開始前
   
   #end add-point
   
   CASE ps_record
      WHEN "s_detail1" 
         LET ls_return = "xccw001"
      WHEN "s_detail2"
         LET ls_return = "xccw001_2"
      WHEN "s_detail3"
         LET ls_return = "xccw001_3"
 
      #add-point:modify_detail_chk段自訂page控制
      
      #end add-point
   END CASE
    
   #add-point:modify_detail_chk段結束前
   
   #end add-point
   
   RETURN ls_return
   
END FUNCTION
 
{</section>}
 
{<section id="axct312.state_change" >}
    
 
{</section>}
 
{<section id="axct312.set_pk_array" >}
   #+ 此段落由子樣板a51產生
#+ 給予pk_array內容
PRIVATE FUNCTION axct312_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_xccw_m.xccwld
   LET g_pk_array[1].column = 'xccwld'
   LET g_pk_array[2].values = g_xccw_m.xccw003
   LET g_pk_array[2].column = 'xccw003'
   LET g_pk_array[3].values = g_xccw_m.xccw004
   LET g_pk_array[3].column = 'xccw004'
   LET g_pk_array[4].values = g_xccw_m.xccw005
   LET g_pk_array[4].column = 'xccw005'
   LET g_pk_array[5].values = g_xccw_m.xccw006
   LET g_pk_array[5].column = 'xccw006'
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="axct312.other_function" readonly="Y" >}
# 參考欄位帶值
PRIVATE FUNCTION axct312_show_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccw_m.xccwld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccw_m.xccwld_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccw_m.xccwld_desc
   
   LET g_xccw_m.xccwcomp = ''
   #SELECT glaacomp
   #  INTO g_xccw_m.xccwcomp
   #  FROM glaa_t
   # WHERE glaaent = g_enterprise
   #   AND glaald = g_xccw_m.xccwld
   #DISPLAY BY NAME g_xccw_m.xccwcomp
   
   SELECT glaacomp,glaa015,glaa016,glaa017,glaa018,glaa019,glaa020,glaa021,glaa022,glaa025,glaa001,glaa003,glaa026,glaa004
     INTO g_xccw_m.xccwcomp,g_glaa015,g_glaa016,g_glaa017,g_glaa018,
          g_glaa019,g_glaa020,g_glaa021,g_glaa022,g_glaa025,g_glaa001,g_glaa003,g_glaa026,
          g_glaa004
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = g_xccw_m.xccwld
   DISPLAY BY NAME g_xccw_m.xccwcomp
   DISPLAY BY NAME g_xccw_m.xccw004
   DISPLAY BY NAME g_xccw_m.xccw005
   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccw_m.xccwcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccw_m.xccwcomp_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccw_m.xccwcomp_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_xccw_m.xccw003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_xccw_m.xccw003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_xccw_m.xccw003_desc
   
   SELECT xcat003 INTO g_xccw_m.xcat003
     FROM xcat_t
    WHERE xcatent = g_enterprise
      AND xcat001 = g_xccw_m.xccw003
   DISPLAY g_xccw_m.xcat003 TO xcat003
   
   LET g_xccw_m_o.xccwcomp = g_xccw_m.xccwcomp   #160824-00007#223 161202 by lori add
   LET g_xccw_m_o.xcat003 = g_xccw_m.xcat003     #160824-00007#223 161202 by lori add
END FUNCTION
# 根據雜項單據編號從庫存雜項交易單據單身檔(inbc_t)自動帶出單身的數據
PRIVATE FUNCTION axct312_xccw_ins_b()
   #161109-00085#24-s mod
#   DEFINE l_inba       RECORD  LIKE inba_t.*   #161109-00085#24-s mark
   DEFINE l_inba       RECORD  #雜項庫存異動單頭檔
       inbaent LIKE inba_t.inbaent, #企業編號
       inbasite LIKE inba_t.inbasite, #營運據點
       inbadocno LIKE inba_t.inbadocno, #單據編號
       inbadocdt LIKE inba_t.inbadocdt, #輸入日期
       inba001 LIKE inba_t.inba001, #單據類別
       inba002 LIKE inba_t.inba002, #扣帳日期
       inba003 LIKE inba_t.inba003, #申請人員
       inba004 LIKE inba_t.inba004, #申請部門
       inba005 LIKE inba_t.inba005, #來源資料類型
       inba006 LIKE inba_t.inba006, #來源單號
       inba007 LIKE inba_t.inba007, #理由碼
       inba008 LIKE inba_t.inba008, #備註
       inba009 LIKE inba_t.inba009, #保稅異動原因
       inba010 LIKE inba_t.inba010, #保稅進口報單
       inba011 LIKE inba_t.inba011, #保稅進口報單日期
       inbaownid LIKE inba_t.inbaownid, #資料所有者
       inbaowndp LIKE inba_t.inbaowndp, #資料所屬部門
       inbacrtid LIKE inba_t.inbacrtid, #資料建立者
       inbacrtdp LIKE inba_t.inbacrtdp, #資料建立部門
       inbacrtdt LIKE inba_t.inbacrtdt, #資料創建日
       inbamodid LIKE inba_t.inbamodid, #資料修改者
       inbamoddt LIKE inba_t.inbamoddt, #最近修改日
       inbacnfid LIKE inba_t.inbacnfid, #資料確認者
       inbacnfdt LIKE inba_t.inbacnfdt, #資料確認日
       inbapstid LIKE inba_t.inbapstid, #資料過帳者
       inbapstdt LIKE inba_t.inbapstdt, #資料過帳日
       inbastus LIKE inba_t.inbastus, #狀態碼
       inbaunit LIKE inba_t.inbaunit, #應用組織
       inba012 LIKE inba_t.inba012, #領用類型
       inba013 LIKE inba_t.inba013, #費用對象
       inba014 LIKE inba_t.inba014, #直接交款否
       inba015 LIKE inba_t.inba015, #庫位
       inba200 LIKE inba_t.inba200, #沖減方式
       inba201 LIKE inba_t.inba201, #管理品類
       inba202 LIKE inba_t.inba202, #來源作業
       inba203 LIKE inba_t.inba203, #管理品類
       inba204 LIKE inba_t.inba204, #供應商編號
       inba205 LIKE inba_t.inba205, #領用部門
       inba206 LIKE inba_t.inba206, #轉入庫位
       inba207 LIKE inba_t.inba207, #轉入管理品類
       inba208 LIKE inba_t.inba208  #返回
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_inbc       RECORD  LIKE inbc_t.*   #161109-00085#24-e mod
   DEFINE l_inbc       RECORD  #雜項庫存異動庫儲批明細檔
       inbcent LIKE inbc_t.inbcent, #企業編號
       inbcsite LIKE inbc_t.inbcsite, #營運據點
       inbcdocno LIKE inbc_t.inbcdocno, #單據編號
       inbcseq LIKE inbc_t.inbcseq, #項次
       inbcseq1 LIKE inbc_t.inbcseq1, #項序
       inbc001 LIKE inbc_t.inbc001, #料件編號
       inbc002 LIKE inbc_t.inbc002, #產品特徵
       inbc003 LIKE inbc_t.inbc003, #庫存管理特徵
       inbc004 LIKE inbc_t.inbc004, #包裝容器編號
       inbc005 LIKE inbc_t.inbc005, #庫位
       inbc006 LIKE inbc_t.inbc006, #儲位
       inbc007 LIKE inbc_t.inbc007, #批號
       inbc009 LIKE inbc_t.inbc009, #交易單位
       inbc010 LIKE inbc_t.inbc010, #數量
       inbc011 LIKE inbc_t.inbc011, #參考單位
       inbc015 LIKE inbc_t.inbc015, #參考數量
       inbc016 LIKE inbc_t.inbc016, #有效日期
       inbc017 LIKE inbc_t.inbc017, #存貨備註
       inbc018 LIKE inbc_t.inbc018, #QC單號
       inbc019 LIKE inbc_t.inbc019, #QC判定項次
       inbc020 LIKE inbc_t.inbc020, #判定結果
       inbc200 LIKE inbc_t.inbc200, #商品條碼
       inbc201 LIKE inbc_t.inbc201, #包裝單位
       inbc202 LIKE inbc_t.inbc202, #包裝數量
       inbcunit LIKE inbc_t.inbcunit, #應用組織
       inbc203 LIKE inbc_t.inbc203, #製造日期
       inbc021 LIKE inbc_t.inbc021, #專案編號
       inbc022 LIKE inbc_t.inbc022, #WBS
       inbc023 LIKE inbc_t.inbc023, #活動編號
       inbc204 LIKE inbc_t.inbc204, #領用/退回單價
       inbc205 LIKE inbc_t.inbc205, #領用/退回金額
       inbc206 LIKE inbc_t.inbc206, #成本單價
       inbc207 LIKE inbc_t.inbc207, #成本金額
       inbc208 LIKE inbc_t.inbc208, #費用編號
       inbc209 LIKE inbc_t.inbc209, #來源單據項次
       inbc210 LIKE inbc_t.inbc210, #來源單據項序
       inbc211 LIKE inbc_t.inbc211, #計價單位
       inbc212 LIKE inbc_t.inbc212  #計價數量
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_xccw       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
   DEFINE l_xccw       RECORD  #本期料件明細進出補成本檔
       xccwent LIKE xccw_t.xccwent, #企業編號
       xccwsite LIKE xccw_t.xccwsite, #site組織
       xccwcomp LIKE xccw_t.xccwcomp, #法人組織
       xccwld LIKE xccw_t.xccwld, #帳套
       xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
       xccw002 LIKE xccw_t.xccw002, #成本域
       xccw003 LIKE xccw_t.xccw003, #成本計算類型
       xccw004 LIKE xccw_t.xccw004, #年度
       xccw005 LIKE xccw_t.xccw005, #期別
       xccw006 LIKE xccw_t.xccw006, #參考單號
       xccw007 LIKE xccw_t.xccw007, #項次
       xccw008 LIKE xccw_t.xccw008, #項序
       xccw009 LIKE xccw_t.xccw009, #出入庫碼
       xccw010 LIKE xccw_t.xccw010, #料號
       xccw011 LIKE xccw_t.xccw011, #特性
       xccw012 LIKE xccw_t.xccw012, #單據類型
       xccw013 LIKE xccw_t.xccw013, #單據日期
       xccw014 LIKE xccw_t.xccw014, #時間
       xccw015 LIKE xccw_t.xccw015, #倉庫編號
       xccw016 LIKE xccw_t.xccw016, #儲位編號
       xccw017 LIKE xccw_t.xccw017, #批號
       xccw020 LIKE xccw_t.xccw020, #異動類型
       xccw021 LIKE xccw_t.xccw021, #原因碼
       xccw022 LIKE xccw_t.xccw022, #交易對象
       xccw023 LIKE xccw_t.xccw023, #客群
       xccw024 LIKE xccw_t.xccw024, #區域
       xccw025 LIKE xccw_t.xccw025, #成本中心
       xccw026 LIKE xccw_t.xccw026, #經營類別
       xccw027 LIKE xccw_t.xccw027, #通路
       xccw028 LIKE xccw_t.xccw028, #品類
       xccw029 LIKE xccw_t.xccw029, #品牌
       xccw030 LIKE xccw_t.xccw030, #專案號
       xccw031 LIKE xccw_t.xccw031, #WBS
       xccw032 LIKE xccw_t.xccw032, #存貨科目
       xccw033 LIKE xccw_t.xccw033, #費用成本科目
       xccw034 LIKE xccw_t.xccw034, #收入科目
       xccw040 LIKE xccw_t.xccw040, #交易幣別
       xccw041 LIKE xccw_t.xccw041, #本位幣別
       xccw042 LIKE xccw_t.xccw042, #匯率
       xccw043 LIKE xccw_t.xccw043, #交易單位
       xccw044 LIKE xccw_t.xccw044, #成本單位
       xccw045 LIKE xccw_t.xccw045, #換算率
       xccw046 LIKE xccw_t.xccw046, #交易數量
       xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
       xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
       xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
       xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
       xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
       xccw201 LIKE xccw_t.xccw201, #本期異動數量
       xccw202 LIKE xccw_t.xccw202, #本期異動金額
       xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
       xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
       xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
       xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
       xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
       xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
       xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
       xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
       xccw282 LIKE xccw_t.xccw282, #本期異動單價
       xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
       xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
       xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
       xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
       xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
       xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
       xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
       xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
       xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
       xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
       xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
       xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
       xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
       xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
       xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
       xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
       xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
       xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
       xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
       xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
       xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
       xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
       xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
       xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
       xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
       xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
       xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
       xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
       xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
       xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
       xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
       xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
       xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
       xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
       xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
       xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
       xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
       xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                 END RECORD
   #161109-00085#24-e mod
   DEFINE l_inba007    LIKE inba_t.inba007
   DEFINE l_success    LIKE type_t.num5
   DEFINE l_glcc002    LIKE glcc_t.glcc002
   DEFINE l_glcc004    LIKE glcc_t.glcc004
   DEFINE l_imag011    LIKE imag_t.imag011
   #161109-00085#24-s mod
#   DEFINE l_sfha       RECORD  LIKE  sfha_t.*   #161109-00085#24-s mark
   DEFINE l_sfha       RECORD  #當站下線單頭檔
       sfhaent LIKE sfha_t.sfhaent, #企業編號
       sfhasite LIKE sfha_t.sfhasite, #營運據點
       sfhadocno LIKE sfha_t.sfhadocno, #單據編號
       sfhadocdt LIKE sfha_t.sfhadocdt, #單據日期
       sfha001 LIKE sfha_t.sfha001, #過帳日期
       sfha002 LIKE sfha_t.sfha002, #申請人員
       sfha003 LIKE sfha_t.sfha003, #部門
       sfha004 LIKE sfha_t.sfha004, #工單單號
       sfha005 LIKE sfha_t.sfha005, #Run Card
       sfha006 LIKE sfha_t.sfha006, #作業編號
       sfha007 LIKE sfha_t.sfha007, #製程式
       sfha008 LIKE sfha_t.sfha008, #當站下線數量
       sfha009 LIKE sfha_t.sfha009, #備註
       sfha010 LIKE sfha_t.sfha010, #來源單號
       sfha011 LIKE sfha_t.sfha011, #來源單號項次
       sfha012 LIKE sfha_t.sfha012, #生產計畫
       sfha013 LIKE sfha_t.sfha013, #生產料號
       sfha014 LIKE sfha_t.sfha014, #BOM特性
       sfha015 LIKE sfha_t.sfha015, #產品特徵
       sfhaownid LIKE sfha_t.sfhaownid, #資料所有者
       sfhaowndp LIKE sfha_t.sfhaowndp, #資料所屬部門
       sfhacrtid LIKE sfha_t.sfhacrtid, #資料建立者
       sfhacrtdp LIKE sfha_t.sfhacrtdp, #資料建立部門
       sfhacrtdt LIKE sfha_t.sfhacrtdt, #資料創建日
       sfhamodid LIKE sfha_t.sfhamodid, #資料修改者
       sfhamoddt LIKE sfha_t.sfhamoddt, #最近修改日
       sfhacnfid LIKE sfha_t.sfhacnfid, #資料確認者
       sfhacnfdt LIKE sfha_t.sfhacnfdt, #資料確認日
       sfhapstid LIKE sfha_t.sfhapstid, #資料過帳者
       sfhapstdt LIKE sfha_t.sfhapstdt, #資料過帳日
       sfhastus LIKE sfha_t.sfhastus, #狀態碼
       sfha016 LIKE sfha_t.sfha016  #原因碼
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_sfhb       RECORD  LIKE  sfhb_t.*   #161109-00085#24-s mark
   DEFINE l_sfhb       RECORD  #工單當站下線入庫申請檔
       sfhbent LIKE sfhb_t.sfhbent, #企業編號
       sfhbsite LIKE sfhb_t.sfhbsite, #營運據點
       sfhbdocno LIKE sfhb_t.sfhbdocno, #單號
       sfhbseq LIKE sfhb_t.sfhbseq, #項次
       sfhb001 LIKE sfhb_t.sfhb001, #料件編號
       sfhb002 LIKE sfhb_t.sfhb002, #產品特徵
       sfhb003 LIKE sfhb_t.sfhb003, #庫位
       sfhb004 LIKE sfhb_t.sfhb004, #儲位
       sfhb005 LIKE sfhb_t.sfhb005, #批號
       sfhb006 LIKE sfhb_t.sfhb006, #庫存管理特徵
       sfhb007 LIKE sfhb_t.sfhb007, #單位
       sfhb008 LIKE sfhb_t.sfhb008, #數量
       sfhb009 LIKE sfhb_t.sfhb009, #參考單位
       sfhb010 LIKE sfhb_t.sfhb010, #參考數量
       sfhb011 LIKE sfhb_t.sfhb011, #生效日期
       sfhb012 LIKE sfhb_t.sfhb012  #存貨備註
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_inaj       RECORD  LIKE  inaj_t.*   #161109-00085#24-s mark
   DEFINE l_inaj       RECORD  #庫存交易明細檔
       inajent LIKE inaj_t.inajent, #企業編號
       inajsite LIKE inaj_t.inajsite, #營運據點
       inaj001 LIKE inaj_t.inaj001, #單據編號
       inaj002 LIKE inaj_t.inaj002, #項次
       inaj003 LIKE inaj_t.inaj003, #項序
       inaj004 LIKE inaj_t.inaj004, #出入庫碼
       inaj005 LIKE inaj_t.inaj005, #料件編號
       inaj006 LIKE inaj_t.inaj006, #產品特徵
       inaj007 LIKE inaj_t.inaj007, #庫存管理特徵
       inaj008 LIKE inaj_t.inaj008, #庫位編號
       inaj009 LIKE inaj_t.inaj009, #儲位編號
       inaj010 LIKE inaj_t.inaj010, #批號
       inaj011 LIKE inaj_t.inaj011, #交易數量
       inaj012 LIKE inaj_t.inaj012, #交易單位
       inaj013 LIKE inaj_t.inaj013, #交易單位與庫存單位換算率
       inaj014 LIKE inaj_t.inaj014, #交易單位與料件基本單位換算率
       inaj015 LIKE inaj_t.inaj015, #異動單據性質
       inaj016 LIKE inaj_t.inaj016, #理由碼
       inaj017 LIKE inaj_t.inaj017, #異動部門編號
       inaj018 LIKE inaj_t.inaj018, #異動供應商/客戶編號
       inaj019 LIKE inaj_t.inaj019, #備註
       inaj020 LIKE inaj_t.inaj020, #工單單號
       inaj021 LIKE inaj_t.inaj021, #多角序號
       inaj022 LIKE inaj_t.inaj022, #單據扣帳日期
       inaj023 LIKE inaj_t.inaj023, #實際執行扣帳日期
       inaj024 LIKE inaj_t.inaj024, #資料產生時間
       inaj025 LIKE inaj_t.inaj025, #異動資料產生者
       inaj026 LIKE inaj_t.inaj026, #參考單位
       inaj027 LIKE inaj_t.inaj027, #參考數量
       inaj028 LIKE inaj_t.inaj028, #成本料號
       inaj036 LIKE inaj_t.inaj036, #庫存異動類型
       inaj029 LIKE inaj_t.inaj029, #交易單位與成本單位換算率
       inaj030 LIKE inaj_t.inaj030, #VMI交易結算否
       inaj031 LIKE inaj_t.inaj031, #VMI對應入庫/倉退單號
       inaj032 LIKE inaj_t.inaj032, #VMI對應入庫/倉退項次
       inaj033 LIKE inaj_t.inaj033, #VMI對應雜發/雜收單號
       inaj034 LIKE inaj_t.inaj034, #VMI對應雜發/雜收項次
       inaj035 LIKE inaj_t.inaj035, #異動作業編號
       inaj037 LIKE inaj_t.inaj037, #成本中心
       inaj038 LIKE inaj_t.inaj038, #專案編號
       inaj039 LIKE inaj_t.inaj039, #WBS編號
       inaj040 LIKE inaj_t.inaj040, #重複性生產-計畫編號
       inaj041 LIKE inaj_t.inaj041, #重複性生產-生產料號
       inaj042 LIKE inaj_t.inaj042, #重複性生產-生產料號BOM特性
       inaj043 LIKE inaj_t.inaj043, #重複性生產-生產料號產品特徵
       inaj044 LIKE inaj_t.inaj044, #來源單號
       inaj200 LIKE inaj_t.inaj200, #內部結算否
       inaj201 LIKE inaj_t.inaj201, #業務類型
       inaj202 LIKE inaj_t.inaj202, #內部交易類型
       inaj203 LIKE inaj_t.inaj203, #幣別
       inaj204 LIKE inaj_t.inaj204, #稅別
       inaj205 LIKE inaj_t.inaj205, #內部結算未稅金額
       inaj206 LIKE inaj_t.inaj206, #內部結算含稅金額
       inaj207 LIKE inaj_t.inaj207, #交易所屬法人
       inaj208 LIKE inaj_t.inaj208, #內部交易對象組織
       inaj209 LIKE inaj_t.inaj209, #內部交易對象法人
       inaj045 LIKE inaj_t.inaj045, #異動時庫存單位
       inaj046 LIKE inaj_t.inaj046, #交易單位與庫存單位換算分子
       inaj047 LIKE inaj_t.inaj047, #交易單位與庫存單位換算分母
       inaj048 LIKE inaj_t.inaj048, #交易單位與料件基本單位換算分子
       inaj049 LIKE inaj_t.inaj049, #交易單位與料件基本單位換算分母
       inaj050 LIKE inaj_t.inaj050, #交易單位與成本單位換算分子
       inaj051 LIKE inaj_t.inaj051, #交易單位與成本單位換算分母
       inaj210 LIKE inaj_t.inaj210, #單據單價
       inaj211 LIKE inaj_t.inaj211  #品類
          END RECORD
   #161109-00085#24-e mod
   DEFINE l_inajsite   LIKE inaj_t.inajsite
   DEFINE l_inaj004    LIKE inaj_t.inaj004
   DEFINE l_inaj008    LIKE inaj_t.inaj008
   DEFINE l_errno      LIKE type_t.chr100     #錯誤訊息
   DEFINE l_today      DATETIME YEAR TO SECOND
   DEFINE l_sql        STRING 
   DEFINE l_acc        LIKE gzcb_t.gzcb004    #fengmy150512
   DEFINE l_dpt        LIKE inaj_t.inaj017    #fengmy150512
   
   CALL s_transaction_begin()
   CALL cl_showmsg_init()
   LET g_success = 'Y'
   
   
   #140912
      
      #161109-00085#24-s mod
#      LET g_sql = "SELECT * FROM inaj_t",   #161109-00085#24-s mark
      LET g_sql = "SELECT inajent,inajsite,inaj001,inaj002,inaj003,inaj004,inaj005,inaj006,inaj007,inaj008,
                          inaj009,inaj010,inaj011,inaj012,inaj013,inaj014,inaj015,inaj016,inaj017,inaj018,
                          inaj019,inaj020,inaj021,inaj022,inaj023,inaj024,inaj025,inaj026,inaj027,inaj028,
                          inaj036,inaj029,inaj030,inaj031,inaj032,inaj033,inaj034,inaj035,inaj037,inaj038,
                          inaj039,inaj040,inaj041,inaj042,inaj043,inaj044,inaj200,inaj201,inaj202,inaj203,
                          inaj204,inaj205,inaj206,inaj207,inaj208,inaj209,inaj045,inaj046,inaj047,inaj048,
                          inaj049,inaj050,inaj051,inaj210,inaj211 
                      FROM inaj_t",
      #161109-00085#24-e mod
                  " WHERE inajent='",g_enterprise,"'",
                  "   AND inaj001 = '",g_xccw_m.xccw006,"'"
      IF g_xccw012_p = '1' THEN 
         LET g_sql = g_sql," AND inaj036 = '101' "
      END IF
      IF g_xccw012_p = '2' THEN 
         LET g_sql = g_sql," AND inaj036 = '301' "
      END IF
      IF g_xccw012_p = '3' THEN 
         LET g_sql = g_sql," AND inaj036 = '115' "
      END IF      
      IF g_xccw012_p = '5' THEN 
         LET g_sql = g_sql," AND inaj036 = '401' "
      END IF
      PREPARE inaj_pre FROM g_sql
      DECLARE inaj_cur CURSOR FOR inaj_pre
      INITIALIZE l_xccw TO NULL
      
      #161109-00085#24-s mod
#      FOREACH inaj_cur INTO l_inaj.*   #161109-00085#24-s mark
      FOREACH inaj_cur INTO l_inaj.inajent,l_inaj.inajsite,l_inaj.inaj001,l_inaj.inaj002,l_inaj.inaj003,
                            l_inaj.inaj004,l_inaj.inaj005,l_inaj.inaj006,l_inaj.inaj007,l_inaj.inaj008,
                            l_inaj.inaj009,l_inaj.inaj010,l_inaj.inaj011,l_inaj.inaj012,l_inaj.inaj013,
                            l_inaj.inaj014,l_inaj.inaj015,l_inaj.inaj016,l_inaj.inaj017,l_inaj.inaj018,
                            l_inaj.inaj019,l_inaj.inaj020,l_inaj.inaj021,l_inaj.inaj022,l_inaj.inaj023,
                            l_inaj.inaj024,l_inaj.inaj025,l_inaj.inaj026,l_inaj.inaj027,l_inaj.inaj028,
                            l_inaj.inaj036,l_inaj.inaj029,l_inaj.inaj030,l_inaj.inaj031,l_inaj.inaj032,
                            l_inaj.inaj033,l_inaj.inaj034,l_inaj.inaj035,l_inaj.inaj037,l_inaj.inaj038,
                            l_inaj.inaj039,l_inaj.inaj040,l_inaj.inaj041,l_inaj.inaj042,l_inaj.inaj043,
                            l_inaj.inaj044,l_inaj.inaj200,l_inaj.inaj201,l_inaj.inaj202,l_inaj.inaj203,
                            l_inaj.inaj204,l_inaj.inaj205,l_inaj.inaj206,l_inaj.inaj207,l_inaj.inaj208,
                            l_inaj.inaj209,l_inaj.inaj045,l_inaj.inaj046,l_inaj.inaj047,l_inaj.inaj048,
                            l_inaj.inaj049,l_inaj.inaj050,l_inaj.inaj051,l_inaj.inaj210,l_inaj.inaj211 
      #161109-00085#24-e mod
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF

         LET l_xccw.xccwent = g_enterprise          #
         LET l_xccw.xccwsite= l_inaj.inajsite       #site组织
         LET l_xccw.xccwcomp= g_xccw_m.xccwcomp     #法人组织
         LET l_xccw.xccwld  = g_xccw_m.xccwld       #账套
         LET l_xccw.xccw001 = '1'                   #账套本位币顺序
         LET l_xccw.xccw003 = g_xccw_m.xccw003      #成本计算类型
         LET l_xccw.xccw004 = g_xccw_m.xccw004      #年度
         LET l_xccw.xccw005 = g_xccw_m.xccw005      #期别
         LET l_xccw.xccw006 = g_xccw_m.xccw006      #参考单号         
         LET l_xccw.xccw007 = l_inaj.inaj002        #项次     
         LET l_xccw.xccw008 = l_inaj.inaj003        #项序
         LET l_xccw.xccw009 = l_inaj.inaj004        #出入库码
         LET l_xccw.xccw010 = l_inaj.inaj005        #料号
         LET l_xccw.xccw011 = l_inaj.inaj006        #特性
         LET l_xccw.xccw012 = g_xccw_m.xccw012      #单据类型
         LET l_xccw.xccw013 = g_xccw_m.xccw013      #单据日期
         LET l_xccw.xccw014 = l_inaj.inaj024        #时间
         LET l_xccw.xccw015 = l_inaj.inaj008        #仓库编号
         LET l_xccw.xccw016 = l_inaj.inaj009        #储位编号
         LET l_xccw.xccw017 = l_inaj.inaj010        #批号         
         LET l_xccw.xccw020 = l_inaj.inaj036        #异动类型
         LET l_xccw.xccw021 = l_inaj.inaj016        #原因码
         LET l_xccw.xccw022 = l_inaj.inaj018        #交易对象
         LET l_xccw.xccw023 = ' '                   #客群
         LET l_xccw.xccw024 = ' '                   #区域
         LET l_xccw.xccw025 = l_inaj.inaj037        #成本中心
         LET l_xccw.xccw026 = ' '                   #经营类别
         LET l_xccw.xccw027 = ' '                   #渠道
         LET l_xccw.xccw028 = ' '                   #品类
         LET l_xccw.xccw029 = ' '                   #品牌
         LET l_xccw.xccw030 = l_inaj.inaj038        #项目号
         LET l_xccw.xccw031 = l_inaj.inaj039        #WBS
         LET l_xccw.xccw032 = ' '                   #存货科目         
         LET l_xccw.xccw033 = ' '                   #费用成本科目
         LET l_xccw.xccw034 = ' '                   #收入科目
         LET l_xccw.xccw040 = l_inaj.inaj203        #交易币别
         LET l_xccw.xccw041 = g_glaa001             #本位币别
         LET l_xccw.xccw042 = 1                     #汇率
         LET l_xccw.xccw043 = l_inaj.inaj012        #交易单位
         LET l_xccw.xccw044 = ' '                   #成本单位
         LET l_xccw.xccw045 = l_inaj.inaj014        #换算率
         LET l_xccw.xccw046 = l_inaj.inaj011        #交易数量
         LET l_xccw.xccw047 = l_inaj.inaj020        #在制单号(工单号/重复性代号)
         #fengmy add 141219-----begin  table alter
         LET l_xccw.xccw048 = l_inaj.inaj040        #重複性生產-計畫編號
         LET l_xccw.xccw049 = l_inaj.inaj041        #重複性生產-生產料號
         LET l_xccw.xccw050 = l_inaj.inaj042        #重複性生產-生產料號BOM特性
         LET l_xccw.xccw051 = l_inaj.inaj043        #重複性生產-生產料號產品特徵
         #fengmy add 141219-----end    table alter
         LET l_xccw.xccw201 = l_xccw.xccw045 * l_xccw.xccw046             #本期异动数量
         LET l_xccw.xccw202 = 0                     #本期异动金额
         LET l_xccw.xccw202a= 0                     #本期异动金额-材料
         LET l_xccw.xccw202b= 0                     #本期异动金额-人工
         LET l_xccw.xccw202c= 0                     #本期异动金额-加工费
         LET l_xccw.xccw202d= 0                     #本期异动金额-制费一
         LET l_xccw.xccw202e= 0                     #本期异动金额-制费二
         LET l_xccw.xccw202f= 0                     #本期异动金额-制费三
         LET l_xccw.xccw202g= 0                     #本期异动金额-制费四
         LET l_xccw.xccw202h= 0                     #本期异动金额-制费五
         LET l_xccw.xccw282 = 0                     #本期异动单价
         LET l_xccw.xccw282a= 0                     #本期异动单价-材料
         LET l_xccw.xccw282b= 0                     #本期异动单价-人工
         LET l_xccw.xccw282c= 0                     #本期异动单价-加工
         LET l_xccw.xccw282d= 0                     #本期异动单价-制费一
         LET l_xccw.xccw282e= 0                     #本期异动单价-制费二
         LET l_xccw.xccw282f= 0                     #本期异动单价-制费三
         LET l_xccw.xccw282g= 0                     #本期异动单价-制费四
         LET l_xccw.xccw282h= 0                     #本期异动单价-制费五
          #成本域 140902
         IF g_para_data = 'Y' THEN
            CASE g_para_data1
                 WHEN '1'
#                      SELECT xcbf001 INTO l_xccw.xccw002 FROM xcbf_t
#                       WHERE xcbfent = g_enterprise
#                         AND xcbfcomp = g_xccw_m.xccwcomp
#                         AND xcbf002  = l_inaj.inajsite
#                         AND xcbf003 = '1'
                       LET g_sql = " SELECT xcbf001 FROM xcbf_t ",
                                  "  WHERE xcbfent = '",g_enterprise,"'", 
                                  "    AND xcbfcomp = '",g_xccw_m.xccwcomp,"'",
                                  "    AND xcbf002 = '",l_inaj.inajsite,"'",
                                  "    AND xcbf003 = '1'"
                       PREPARE xcbf001_pre11 FROM g_sql
                       DECLARE xcbf001_cur11 CURSOR FOR xcbf001_pre11
                       OPEN xcbf001_cur11
                       FETCH xcbf001_cur11 INTO l_xccw.xccw002
                 WHEN '2'
#                      SELECT xcbf001 INTO l_xccw.xccw002 FROM xcbf_t
#                       WHERE xcbfent = g_enterprise
#                         AND xcbfcomp = g_xccw_m.xccwcomp
#                         AND xcbf002  = l_inaj.inaj008
#                         AND xcbf003 = '2'
                      LET g_sql = " SELECT xcbf001 FROM xcbf_t ",
                                  "  WHERE xcbfent = '",g_enterprise,"'",
                                  "    AND xcbfcomp = '",g_xccw_m.xccwcomp,"'",                                  
                                  "    AND xcbf002 = '",l_inaj.inaj008,"'",
                                  "    AND xcbf003 = '2'"
                      PREPARE xcbf001_pre12 FROM g_sql
                      DECLARE xcbf001_cur12 CURSOR FOR xcbf001_pre12
                      OPEN xcbf001_cur12 
                      FETCH xcbf001_cur12 INTO l_xccw.xccw002
                 WHEN '3'
                      LET l_xccw.xccw002 = l_inaj.inaj007
                 OTHERWISE
                      LET l_xccw.xccw002 = ' '
            END CASE
         END IF
         
         #      客群    区域     经营类别 渠道
         SELECT pmaa090,pmaa241,pmaa092,pmaa231 
           INTO l_xccw.xccw023,l_xccw.xccw024,l_xccw.xccw026,l_xccw.xccw027
           FROM pmaa_t
          WHERE pmaaent = g_enterprise
            AND pmaa001 = l_xccw.xccw022         
         #      品类     品牌
         SELECT imaa108,imaa126 INTO l_xccw.xccw028,l_xccw.xccw029
           FROM imaa_t
          WHERE imaaent = g_enterprise
            AND imaa001 = l_xccw.xccw010
         
          #待分析#################################
         #理由碼
#         LET l_inba007 = ''
#         SELECT inba007 INTO l_inba007 FROM inba_t WHERE inbaent = g_enterprise AND inbadocno = l_inbc.inbcdocno 
         #存貨科目(agli161)[140907 可能有些对应值为*]         
         CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_inaj.inaj005,'','',l_inaj.inajsite,l_inaj.inaj008)
         RETURNING l_success,l_xccw.xccw032
         #去site
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_inaj.inaj005,'','','',l_inaj.inaj008)
             RETURNING l_success,l_xccw.xccw032
         END IF 
         #去仓库
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_inaj.inaj005,'','',l_inaj.inajsite,'')
            RETURNING l_success,l_xccw.xccw032
         END IF
         #去料件
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1','','','',l_inaj.inajsite,l_inaj.inaj008)
            RETURNING l_success,l_xccw.xccw032
         END IF
         #去site，去仓库         
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_inaj.inaj005,'','','','')
             RETURNING l_success,l_xccw.xccw032
         END IF
         #去site，去料件
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1','','','','',l_inaj.inaj008)
             RETURNING l_success,l_xccw.xccw032
         END IF 
         #去仓库，去料件         
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1','','','',l_inaj.inajsite,'')
             RETURNING l_success,l_xccw.xccw032
         END IF 
         #去料件，去site，去仓库         
         IF cl_null(l_xccw.xccw032) THEN
            CALL s_get_item_acc(g_xccw_m.xccwld,'1','','','','','')
             RETURNING l_success,l_xccw.xccw032
         END IF 

         #費用科目（agli180）
#         LET l_glcc004 = ''
#         CALL s_fin_get_account(g_xccw_m.xccwld,'11','216',l_inba007) 
#         RETURNING l_success,l_glcc004,l_errno
#          CALL s_fin_get_account(g_xccw_m.xccwld,'11','216',l_xccw.xccw021)   #fengmy150512 mark
#          RETURNING l_success,l_xccw.xccw033,l_errno                          #fengmy150512 mark
#fengmy150512 ----b
          IF g_xccw012_p = '1' OR g_xccw012_p = '2' THEN 
             LET l_acc = '216'
          END IF
          IF g_xccw012_p = '3' THEN
             LET l_acc = '1125'
          END IF
          IF g_xccw012_p = '5' THEN
             LET l_acc = '306'
          END IF
          IF cl_null(l_inaj.inaj017) THEN
             IF g_xccw012_p = '1' OR g_xccw012_p = '2' THEN 
                SELECT inba004 INTO l_dpt FROM inba_t 
                 WHERE inbaent = g_enterprise AND inbadocno = l_xccw.xccw006
             END IF
             IF g_xccw012_p = '3' THEN 
                SELECT sfha003 INTO l_dpt FROM sfha_t 
                 WHERE sfhaent = g_enterprise AND sfhadocno = l_xccw.xccw006
             END IF
             IF g_xccw012_p = '5' THEN
                SELECT indc101 INTO l_dpt FROM indc_t 
                 WHERE indcent = g_enterprise AND indcdocno = l_xccw.xccw006
                IF cl_null(l_dpt) THEN
                 SELECT inde101 INTO l_dpt FROM inde_t 
                 WHERE indeent = g_enterprise AND indedocno = l_xccw.xccw006
                END IF
             END IF 
          ELSE
             LET l_dpt = l_inaj.inaj017
          END IF
          CALL s_fin_dept_reasons_with_ld_get_account(l_dpt,l_acc,l_xccw.xccw021,g_xccw_m.xccwld,'11',l_xccw.xccw013)
          RETURNING l_success,l_xccw.xccw033,l_errno 
#fengmy150512 ----e
#         #品類
#         LET l_imag011 = ''
#         SELECT imag011 INTO l_imag011 FROM imag_t WHERE imagent = g_enterprise AND imagsite = l_inbc.inbcsite AND imag001 = l_inbc.inbc001
         #待分析#################################
         
     
         
       #成本單位取axci120
       SELECT xcbb005 INTO l_xccw.xccw044 FROM xcbb_t
        WHERE xcbbent  = g_enterprise
          AND xcbbcomp = g_xccw_m.xccwcomp
          AND xcbb001  = g_xccw_m.xccw004
          AND xcbb002  = g_xccw_m.xccw005
          AND xcbb003  = l_xccw.xccw010

         
         IF cl_null(l_xccw.xccw002) THEN LET l_xccw.xccw002 = ' ' END IF
         IF cl_null(l_xccw.xccw201) THEN LET l_xccw.xccw201 = 0 END IF
         IF cl_null(l_xccw.xccw282a) THEN LET l_xccw.xccw282a= 0 END IF
         IF cl_null(l_xccw.xccw282b) THEN LET l_xccw.xccw282b= 0 END IF
         IF cl_null(l_xccw.xccw282c) THEN LET l_xccw.xccw282c= 0 END IF
         IF cl_null(l_xccw.xccw282d) THEN LET l_xccw.xccw282d= 0 END IF
         IF cl_null(l_xccw.xccw282e) THEN LET l_xccw.xccw282e= 0 END IF
         IF cl_null(l_xccw.xccw282f) THEN LET l_xccw.xccw282f= 0 END IF
         IF cl_null(l_xccw.xccw282g) THEN LET l_xccw.xccw282g= 0 END IF
         IF cl_null(l_xccw.xccw282h) THEN LET l_xccw.xccw282h= 0 END IF
         IF cl_null(l_xccw.xccw282) THEN LET l_xccw.xccw282 = 0 END IF
         IF cl_null(l_xccw.xccw202a) THEN LET l_xccw.xccw202a= 0 END IF
         IF cl_null(l_xccw.xccw202b) THEN LET l_xccw.xccw202b= 0 END IF
         IF cl_null(l_xccw.xccw202c) THEN LET l_xccw.xccw202c= 0 END IF
         IF cl_null(l_xccw.xccw202d) THEN LET l_xccw.xccw202d= 0 END IF
         IF cl_null(l_xccw.xccw202e) THEN LET l_xccw.xccw202e= 0 END IF
         IF cl_null(l_xccw.xccw202f) THEN LET l_xccw.xccw202f= 0 END IF
         IF cl_null(l_xccw.xccw202g) THEN LET l_xccw.xccw202g= 0 END IF
         IF cl_null(l_xccw.xccw202h) THEN LET l_xccw.xccw202h= 0 END IF
         IF cl_null(l_xccw.xccw202) THEN LET l_xccw.xccw202 = 0 END IF
         
         
         #161109-00085#24-s mod
#         INSERT INTO xccw_t VALUES (l_xccw.*)   #161109-00085#24-s mark
         INSERT INTO xccw_t (xccwent,xccwsite,xccwcomp,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,
                             xccw007,xccw008,xccw009,xccw010,xccw011,xccw012,xccw013,xccw014,xccw015,xccw016,
                             xccw017,xccw020,xccw021,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,
                             xccw029,xccw030,xccw031,xccw032,xccw033,xccw034,xccw040,xccw041,xccw042,xccw043,
                             xccw044,xccw045,xccw046,xccw047,xccw048,xccw049,xccw050,xccw051,xccw201,xccw202,
                             xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw282,xccw282a,
                             xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccwud001,xccwud002,xccwud003,
                             xccwud004,xccwud005,xccwud006,xccwud007,xccwud008,xccwud009,xccwud010,xccwud011,xccwud012,xccwud013,
                             xccwud014,xccwud015,xccwud016,xccwud017,xccwud018,xccwud019,xccwud020,xccwud021,xccwud022,xccwud023,
                             xccwud024,xccwud025,xccwud026,xccwud027,xccwud028,xccwud029,xccwud030)
                     VALUES (l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                             l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                             l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                             l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                             l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                             l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                             l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                             l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                             l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                             l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                             l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                             l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                             l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                             l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                             l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                             l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                             l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                             l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                             l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                             l_xccw.xccwud029,l_xccw.xccwud030)
         #161109-00085#24-e mod
         IF SQLCA.SQLcode  THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "insert_xccw"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
            LET g_success = 'N'                        
         END IF
         
         IF g_glaa015 = 'Y' THEN 
            LET l_xccw.xccw001 = '2'
            LET l_xccw.xccw041 = g_glaa016
                                     #匯率參照表;帳套;       日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,g_today,g_glaa001,
                                      #目的幣別;      交易金額; 匯類類型
                                      l_xccw.xccw041,0,g_glaa018)
            RETURNING l_xccw.xccw042
            

         IF cl_null(l_xccw.xccw002) THEN LET l_xccw.xccw002 = ' ' END IF
         IF cl_null(l_xccw.xccw201) THEN LET l_xccw.xccw201 = 0 END IF
         IF cl_null(l_xccw.xccw282a) THEN LET l_xccw.xccw282a= 0 END IF
         IF cl_null(l_xccw.xccw282b) THEN LET l_xccw.xccw282b= 0 END IF
         IF cl_null(l_xccw.xccw282c) THEN LET l_xccw.xccw282c= 0 END IF
         IF cl_null(l_xccw.xccw282d) THEN LET l_xccw.xccw282d= 0 END IF
         IF cl_null(l_xccw.xccw282e) THEN LET l_xccw.xccw282e= 0 END IF
         IF cl_null(l_xccw.xccw282f) THEN LET l_xccw.xccw282f= 0 END IF
         IF cl_null(l_xccw.xccw282g) THEN LET l_xccw.xccw282g= 0 END IF
         IF cl_null(l_xccw.xccw282h) THEN LET l_xccw.xccw282h= 0 END IF
         IF cl_null(l_xccw.xccw282) THEN LET l_xccw.xccw282 = 0 END IF
         IF cl_null(l_xccw.xccw202a) THEN LET l_xccw.xccw202a= 0 END IF
         IF cl_null(l_xccw.xccw202b) THEN LET l_xccw.xccw202b= 0 END IF
         IF cl_null(l_xccw.xccw202c) THEN LET l_xccw.xccw202c= 0 END IF
         IF cl_null(l_xccw.xccw202d) THEN LET l_xccw.xccw202d= 0 END IF
         IF cl_null(l_xccw.xccw202e) THEN LET l_xccw.xccw202e= 0 END IF
         IF cl_null(l_xccw.xccw202f) THEN LET l_xccw.xccw202f= 0 END IF
         IF cl_null(l_xccw.xccw202g) THEN LET l_xccw.xccw202g= 0 END IF
         IF cl_null(l_xccw.xccw202h) THEN LET l_xccw.xccw202h= 0 END IF
         IF cl_null(l_xccw.xccw202) THEN LET l_xccw.xccw202 = 0 END IF
            #161109-00085#24-s mod
#            INSERT INTO xccw_t VALUES (l_xccw.*)   #161109-00085#24-s mark
            INSERT INTO xccw_t (xccwent,xccwsite,xccwcomp,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,
                                xccw007,xccw008,xccw009,xccw010,xccw011,xccw012,xccw013,xccw014,xccw015,xccw016,
                                xccw017,xccw020,xccw021,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,
                                xccw029,xccw030,xccw031,xccw032,xccw033,xccw034,xccw040,xccw041,xccw042,xccw043,
                                xccw044,xccw045,xccw046,xccw047,xccw048,xccw049,xccw050,xccw051,xccw201,xccw202,
                                xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw282,xccw282a,
                                xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccwud001,xccwud002,xccwud003,
                                xccwud004,xccwud005,xccwud006,xccwud007,xccwud008,xccwud009,xccwud010,xccwud011,xccwud012,xccwud013,
                                xccwud014,xccwud015,xccwud016,xccwud017,xccwud018,xccwud019,xccwud020,xccwud021,xccwud022,xccwud023,
                                xccwud024,xccwud025,xccwud026,xccwud027,xccwud028,xccwud029,xccwud030)
                        VALUES (l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                                l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                                l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                                l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                                l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                                l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                                l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                                l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                                l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                                l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                                l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                                l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                                l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                                l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                                l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                                l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                                l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                                l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                                l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                                l_xccw.xccwud029,l_xccw.xccwud030)
            #161109-00085#24-e mod
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "insert_xccw"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
         END IF
         
         IF g_glaa019 = 'Y' THEN 
            LET l_xccw.xccw001 = '3'
            LET l_xccw.xccw041 = g_glaa020
                                     #匯率參照表;帳套;       日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,g_today,g_glaa001,
                                      #目的幣別;      交易金額; 匯類類型
                                      l_xccw.xccw041,0,g_glaa018)
            RETURNING l_xccw.xccw042
            

         IF cl_null(l_xccw.xccw002) THEN LET l_xccw.xccw002 = ' ' END IF
         IF cl_null(l_xccw.xccw201) THEN LET l_xccw.xccw201 = 0 END IF
         IF cl_null(l_xccw.xccw282a) THEN LET l_xccw.xccw282a= 0 END IF
         IF cl_null(l_xccw.xccw282b) THEN LET l_xccw.xccw282b= 0 END IF
         IF cl_null(l_xccw.xccw282c) THEN LET l_xccw.xccw282c= 0 END IF
         IF cl_null(l_xccw.xccw282d) THEN LET l_xccw.xccw282d= 0 END IF
         IF cl_null(l_xccw.xccw282e) THEN LET l_xccw.xccw282e= 0 END IF
         IF cl_null(l_xccw.xccw282f) THEN LET l_xccw.xccw282f= 0 END IF
         IF cl_null(l_xccw.xccw282g) THEN LET l_xccw.xccw282g= 0 END IF
         IF cl_null(l_xccw.xccw282h) THEN LET l_xccw.xccw282h= 0 END IF
         IF cl_null(l_xccw.xccw282) THEN LET l_xccw.xccw282 = 0 END IF
         IF cl_null(l_xccw.xccw202a) THEN LET l_xccw.xccw202a= 0 END IF
         IF cl_null(l_xccw.xccw202b) THEN LET l_xccw.xccw202b= 0 END IF
         IF cl_null(l_xccw.xccw202c) THEN LET l_xccw.xccw202c= 0 END IF
         IF cl_null(l_xccw.xccw202d) THEN LET l_xccw.xccw202d= 0 END IF
         IF cl_null(l_xccw.xccw202e) THEN LET l_xccw.xccw202e= 0 END IF
         IF cl_null(l_xccw.xccw202f) THEN LET l_xccw.xccw202f= 0 END IF
         IF cl_null(l_xccw.xccw202g) THEN LET l_xccw.xccw202g= 0 END IF
         IF cl_null(l_xccw.xccw202h) THEN LET l_xccw.xccw202h= 0 END IF
         IF cl_null(l_xccw.xccw202) THEN LET l_xccw.xccw202 = 0 END IF
            #161109-00085#24-s mod
#            INSERT INTO xccw_t VALUES (l_xccw.*)   #161109-00085#24-s mark
            INSERT INTO xccw_t (xccwent,xccwsite,xccwcomp,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,
                                xccw007,xccw008,xccw009,xccw010,xccw011,xccw012,xccw013,xccw014,xccw015,xccw016,
                                xccw017,xccw020,xccw021,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,
                                xccw029,xccw030,xccw031,xccw032,xccw033,xccw034,xccw040,xccw041,xccw042,xccw043,
                                xccw044,xccw045,xccw046,xccw047,xccw048,xccw049,xccw050,xccw051,xccw201,xccw202,
                                xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw282,xccw282a,
                                xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccwud001,xccwud002,xccwud003,
                                xccwud004,xccwud005,xccwud006,xccwud007,xccwud008,xccwud009,xccwud010,xccwud011,xccwud012,xccwud013,
                                xccwud014,xccwud015,xccwud016,xccwud017,xccwud018,xccwud019,xccwud020,xccwud021,xccwud022,xccwud023,
                                xccwud024,xccwud025,xccwud026,xccwud027,xccwud028,xccwud029,xccwud030)
                        VALUES (l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                                l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                                l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                                l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                                l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                                l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                                l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                                l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                                l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                                l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                                l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                                l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                                l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                                l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                                l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                                l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                                l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                                l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                                l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                                l_xccw.xccwud029,l_xccw.xccwud030)
            #161109-00085#24-e mod
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "insert_xccw"
            LET g_errparam.popup = TRUE
            CALL cl_err()
  
               LET g_success = 'N'                        
            END IF
         END IF
         
      END FOREACH 
  

   IF g_success = 'N' THEN
      CALL cl_err_showmsg() 
      CALL s_transaction_end('N','0') 
   ELSE
      
      LET g_xccw_m_t.* = g_xccw_m.* #140905
      CALL s_transaction_end('Y','0')
   END IF
END FUNCTION
# 單身填充
PRIVATE FUNCTION axct312_b_fill_1(p_wc2)

DEFINE p_wc2      STRING
   #add-point:b_fill段define
DEFINE l_xccw015_desc LIKE type_t.chr1000
DEFINE l_xccw016_desc LIKE type_t.chr1000
DEFINE l_xccw021_desc LIKE type_t.chr1000
LET g_cnt = l_ac
   #end add-point     
 
   #先清空單身變數內容
   CALL g_xccw_d.clear()
   CALL g_xccw2_d.clear()
   CALL g_xccw3_d.clear()
   CALL g_xccw4_d.clear()
   CALL g_xccw5_d.clear()
   CALL g_xccw6_d.clear()
   #dorislai-20151005-modify----(S)
#   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw015,xccw016,xccw017,xccw009,xccw020, 
#          xccw021,xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c,xccw282d,xccw282e, 
#          xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f, 
#          xccw202g,xccw202h,xccw001,xccw008,xccw009,xccw002,xccw006 FROM xccw_t", 
#             
#                  "",
#                  
#                  " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '1'" 

   #申請部門:aint302、aint301、asdft337、aint330(調撥)
   #單據備註:aint302、aint301、aint330(調撥)
   #存貨備註:aint302、asft337
   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw015,xccw016,
                               xccw017,xccw009,xccw020,xccw021,"

   CASE g_xccw012_p
      WHEN 1  #axct312
         LET g_sql = g_sql,"trim(inba004)||'.'||trim(t1.ooefl003),inbb020,inbb021,"
      WHEN 2  #axct313
         LET g_sql = g_sql,"trim(inba004)||'.'||trim(t1.ooefl003),inbb020,' ',"
      WHEN 3  #axct314
         LET g_sql = g_sql,"trim(sfha003)||'.'||trim(t2.ooefl003),' ',sfha012,"
      WHEN 5  #axct316
         LET g_sql = g_sql,"trim(indc101)||'.'||trim(t3.ooefl003),indd152,' ',"
   END CASE
   LET g_sql = g_sql,"xccw043,xccw046,xccw044,xccw045,xccw201,xccw282a,xccw282b,xccw282c,xccw282d,xccw282e,", 
                     "xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,",
                     "xccw202f,xccw202g,xccw202h,xccw001,xccw008,xccw009,xccw002,xccw006 ",
                     " FROM xccw_t",
                     " LEFT OUTER JOIN inba_t ON inbaent=xccwent AND inbadocno=xccw006 AND inbasite=xccwsite",
                     " LEFT OUTER JOIN inbb_t ON inbbent=xccwent AND inbbdocno=xccw006 AND inbbseq=xccw007 AND inbbsite=xccwsite ",
                     " LEFT OUTER JOIN sfha_t ON sfhaent=xccwent AND sfhadocno=xccw006 AND sfhasite=xccwsite ",
                     " LEFT OUTER JOIN sfhb_t ON sfhbent=xccwent AND sfhbdocno=xccw006 AND sfhbseq=xccw007 AND sfhbsite=xccwsite ", 
                     " LEFT OUTER JOIN indc_t ON indcent=xccwent AND indcdocno=xccw006 AND indcsite=xccwsite ",
                     " LEFT OUTER JOIN indd_t ON inddent=xccwent AND indddocno=xccw006 AND inddseq=xccw007 AND inddsite=xccwsite ", 
                     " LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent=inbaent AND t1.ooefl001=inba004 AND t1.ooefl002='",g_dlang,"'",
                     " LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent=sfhaent AND t2.ooefl001=sfha003 AND t2.ooefl002='",g_dlang,"'",
                     " LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent=indcent AND t3.ooefl001=indc101 AND t3.ooefl002='",g_dlang,"'",
                     " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '1'" 

   
   #dorislai-20151005-modify----(E)                                
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   IF g_xccw012_p = '1' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '1' "
   END IF
   IF g_xccw012_p = '2' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '2' "
   END IF
   IF g_xccw012_p = '3' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '3' "
   END IF
   IF g_xccw012_p = '4' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '4' "
   END IF
   IF g_xccw012_p = '5' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '5' "
   END IF
   
   #判斷是否填充
   IF axct312_fill_chk(1) THEN
#      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw010,xccw_t.xccw007,xccw_t.xccw008"  #140905
      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw007,xccw_t.xccw008,xccw_t.xccw010"  #140905
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct312_pb1 FROM g_sql
      DECLARE b_fill_cs1 CURSOR FOR axct312_pb1
        
#      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs1 USING g_enterprise,g_xccw_m.xccwld
                                               ,g_xccw_m.xccw003
                                               ,g_xccw_m.xccw004
                                               ,g_xccw_m.xccw005
                                              ,g_xccw_m.xccw006
     #dorislai-20151011-modify----(S)
#      FOREACH b_fill_cs1 INTO g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008,g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite, 
#                             g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009,  
#                             g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
#                             g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
#                             g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
#                             g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282, 
#                             g_xccw_d[l_ac].xccw202,g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c, 
#                             g_xccw_d[l_ac].xccw202d,g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g, 
#                             g_xccw_d[l_ac].xccw202h,g_xccw2_d[l_ac].xccw001,g_xccw2_d[l_ac].xccw007,g_xccw2_d[l_ac].xccw008,g_xccw2_d[l_ac].xccw002, 
#                             g_xccw2_d[l_ac].xccw010    

      FOREACH b_fill_cs1 INTO g_xccw_d[l_ac].xccw001,g_xccw_d[l_ac].xccw007,g_xccw_d[l_ac].xccw008,g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccwsite, 
                             g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw011,g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw017,g_xccw_d[l_ac].xccw009,  
                             g_xccw_d[l_ac].xccw020,g_xccw_d[l_ac].xccw021,g_xccw_d[l_ac].inba004_desc,g_xccw_d[l_ac].inbb020,g_xccw_d[l_ac].inbb021,
                             g_xccw_d[l_ac].xccw043,g_xccw_d[l_ac].xccw046, 
                             g_xccw_d[l_ac].xccw044,g_xccw_d[l_ac].xccw045,g_xccw_d[l_ac].xccw201,g_xccw_d[l_ac].xccw282a, 
                             g_xccw_d[l_ac].xccw282b,g_xccw_d[l_ac].xccw282c,g_xccw_d[l_ac].xccw282d,g_xccw_d[l_ac].xccw282e, 
                             g_xccw_d[l_ac].xccw282f,g_xccw_d[l_ac].xccw282g,g_xccw_d[l_ac].xccw282h,g_xccw_d[l_ac].xccw282, 
                             g_xccw_d[l_ac].xccw202,g_xccw_d[l_ac].xccw202a,g_xccw_d[l_ac].xccw202b,g_xccw_d[l_ac].xccw202c, 
                             g_xccw_d[l_ac].xccw202d,g_xccw_d[l_ac].xccw202e,g_xccw_d[l_ac].xccw202f,g_xccw_d[l_ac].xccw202g, 
                             g_xccw_d[l_ac].xccw202h,g_xccw2_d[l_ac].xccw001,g_xccw2_d[l_ac].xccw007,g_xccw2_d[l_ac].xccw008,g_xccw2_d[l_ac].xccw002, 
                             g_xccw2_d[l_ac].xccw010 
      #dorislai-20151011-modify----(E)
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axct312_ref_detail(g_xccw_d[l_ac].xccw002,g_xccw_d[l_ac].xccw010,g_xccw_d[l_ac].xccw015,g_xccw_d[l_ac].xccw016,g_xccw_d[l_ac].xccw021)
            RETURNING g_xccw_d[l_ac].xccw002_desc,g_xccw_d[l_ac].xccw010_desc,g_xccw_d[l_ac].xccw010_desc_desc,g_xccw_d[l_ac].xccw015_desc,g_xccw_d[l_ac].xccw016_desc,g_xccw_d[l_ac].xccw021_desc
           
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xccw2_d[l_ac].xcckownid_desc = cl_get_username(g_xccw2_d[l_ac].xcckownid)
      #LET g_xccw2_d[l_ac].xcckowndp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckowndp)
      #LET g_xccw2_d[l_ac].xcckcrtid_desc = cl_get_username(g_xccw2_d[l_ac].xcckcrtid)
      #LET g_xccw2_d[l_ac].xcckcrtdp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckcrtdp)
      #LET g_xccw2_d[l_ac].xcckmodid_desc = cl_get_username(g_xccw2_d[l_ac].xcckmodid)
      ##LET .xcckcnfid_desc = cl_get_deptname(.xcckcnfid)
      ##LET .xcckpstid_desc = cl_get_deptname(.xcckpstid)
      
 
 
         
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xccw_d.deleteElement(g_xccw_d.getLength())
      CALL g_xccw2_d.deleteElement(g_xccw2_d.getLength())
      CALL g_xccw3_d.deleteElement(g_xccw3_d.getLength())
      CALL g_xccw4_d.deleteElement(g_xccw4_d.getLength())
      CALL g_xccw5_d.deleteElement(g_xccw5_d.getLength())
      CALL g_xccw6_d.deleteElement(g_xccw6_d.getLength())
 
   END IF
   
   
   
   #單身二填充
   #dorislai-20151006-modify----(S)
#   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw021,xccw032, 
#                               xccw033,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,
#                               xccw029,xccw030,xccw031,xccw201, xccw282,xccw202,xccw009 FROM xccw_t", 
#             
#                  "",
#                  
#                  " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '1'"
   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw021,"
   
   CASE g_xccw012_p
      WHEN 1  #axct312
         LET g_sql = g_sql,"trim(inba004)||'.'||trim(t1.ooefl003),inbb020,inbb021,"
      WHEN 2  #axct313
         LET g_sql = g_sql,"trim(inba004)||'.'||trim(t1.ooefl003),inbb020,' ',"
      WHEN 3  #axct314
         LET g_sql = g_sql,"trim(sfha003)||'.'||trim(t2.ooefl003),' ',sfha012,"
      WHEN 5  #axct316
         LET g_sql = g_sql,"trim(indc101)||'.'||trim(t3.ooefl003),indd152,' ',"
   END CASE    
   
   LET g_sql = g_sql,"xccw032,xccw033,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,",
                     "xccw028,xccw029,xccw030,xccw031,xccw201, xccw282,xccw202,xccw009 ",
               " FROM xccw_t", 
               " LEFT OUTER JOIN inba_t ON inbaent=xccwent AND inbadocno=xccw006 AND inbasite=xccwsite",
               " LEFT OUTER JOIN inbb_t ON inbbent=xccwent AND inbbdocno=xccw006 AND inbbseq=xccw007 AND inbbsite=xccwsite ",
               " LEFT OUTER JOIN sfha_t ON sfhaent=xccwent AND sfhadocno=xccw006 AND sfhasite=xccwsite ",
               " LEFT OUTER JOIN sfhb_t ON sfhbent=xccwent AND sfhbdocno=xccw006 AND sfhbseq=xccw007 AND sfhbsite=xccwsite ", 
               " LEFT OUTER JOIN indc_t ON indcent=xccwent AND indcdocno=xccw006 AND indcsite=xccwsite ",
               " LEFT OUTER JOIN indd_t ON inddent=xccwent AND indddocno=xccw006 AND inddseq=xccw007 AND inddsite=xccwsite ", 
               " LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent=inbaent AND t1.ooefl001=inba004 AND t1.ooefl002='",g_dlang,"'",
               " LEFT OUTER JOIN ooefl_t t2 ON t2.ooeflent=sfhaent AND t2.ooefl001=sfha003 AND t2.ooefl002='",g_dlang,"'",
               " LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent=indcent AND t3.ooefl001=indc101 AND t3.ooefl002='",g_dlang,"'",
               " WHERE xccwent= ? AND xccwld=? AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '1'"
    
   #dorislai-20151006-modify----(E)                  
                  
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   IF g_xccw012_p = '1' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '1' "
   END IF
   IF g_xccw012_p = '2' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '2' "
   END IF
   IF g_xccw012_p = '3' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '3' "
   END IF
   IF g_xccw012_p = '4' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '4' "
   END IF
   IF g_xccw012_p = '5' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '5' "
   END IF
   
   #判斷是否填充
   IF axct312_fill_chk(1) THEN
     #      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw010,xccw_t.xccw007,xccw_t.xccw008"  #140905
      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw007,xccw_t.xccw008,xccw_t.xccw010"  #140905
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct312_pb2 FROM g_sql
      DECLARE b_fill_cs2 CURSOR FOR axct312_pb2
      
#      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs2 USING g_enterprise,g_xccw_m.xccwld
                                               ,g_xccw_m.xccw003
                                               ,g_xccw_m.xccw004
                                               ,g_xccw_m.xccw005
                                               ,g_xccw_m.xccw006
      #dorislai-20151012-modify----(S)
#      FOREACH b_fill_cs2 INTO g_xccw3_d[l_ac].xccw001,g_xccw3_d[l_ac].xccw007,g_xccw3_d[l_ac].xccw008,g_xccw3_d[l_ac].xccw002, 
#                              g_xccw3_d[l_ac].xccwsite,g_xccw3_d[l_ac].xccw010,g_xccw3_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw021, 
#                              g_xccw3_d[l_ac].xccw032,g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022,
#                              g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024, g_xccw3_d[l_ac].xccw025, 
#                              g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028,  
#                              g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031,
#                              g_xccw3_d[l_ac].xccw201,g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202,g_xccw3_d[l_ac].xccw009                                         
      FOREACH b_fill_cs2 INTO g_xccw3_d[l_ac].xccw001,g_xccw3_d[l_ac].xccw007,g_xccw3_d[l_ac].xccw008,g_xccw3_d[l_ac].xccw002, 
                              g_xccw3_d[l_ac].xccwsite,g_xccw3_d[l_ac].xccw010,g_xccw3_d[l_ac].xccw011,g_xccw3_d[l_ac].xccw021, 
                              g_xccw3_d[l_ac].inba004_desc,g_xccw3_d[l_ac].inbb020,g_xccw3_d[l_ac].inbb021,g_xccw3_d[l_ac].xccw032,
                              g_xccw3_d[l_ac].xccw033,g_xccw3_d[l_ac].xccw022,g_xccw3_d[l_ac].xccw023,g_xccw3_d[l_ac].xccw024,
                              g_xccw3_d[l_ac].xccw025,g_xccw3_d[l_ac].xccw026,g_xccw3_d[l_ac].xccw027,g_xccw3_d[l_ac].xccw028,  
                              g_xccw3_d[l_ac].xccw029,g_xccw3_d[l_ac].xccw030,g_xccw3_d[l_ac].xccw031,g_xccw3_d[l_ac].xccw201,
                              g_xccw3_d[l_ac].xccw282,g_xccw3_d[l_ac].xccw202,g_xccw3_d[l_ac].xccw009
      #dorislai-20151012-modify----(E)                       
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
          CALL axct312_ref_detail(g_xccw3_d[l_ac].xccw002,g_xccw3_d[l_ac].xccw010,'','',g_xccw3_d[l_ac].xccw021)
            RETURNING g_xccw3_d[l_ac].xccw002_desc,g_xccw3_d[l_ac].xccw010_desc,g_xccw3_d[l_ac].xccw010_desc_desc,l_xccw015_desc,l_xccw015_desc,g_xccw3_d[l_ac].xccw021_desc
         #交易对象，xccw022
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw022
         CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw022_desc = '', g_rtn_fields[1] , ''   
         #客群，xccw023
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw023
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw023_desc = '', g_rtn_fields[1] , ''   
         #区域，xccw024
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw024
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='287' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw024_desc = '', g_rtn_fields[1] , ''  
         #成本中心
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw025
         CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw025_desc = '', g_rtn_fields[1] , '' 
         #经营类别，xccw026
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw026
         CALL ap_ref_array2(g_ref_fields,"SELECT gzcbl004 FROM gzcbl_t WHERE gzcblent='"||g_enterprise||"' AND gzcbl001='6013' AND gzcbl002=? AND gzcbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw026_desc = '', g_rtn_fields[1] , '' 
         #渠道，xccw027
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw027
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2035' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw027_desc = '', g_rtn_fields[1] , '' 
         #品类，xccw028
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw028
         CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw028_desc = '', g_rtn_fields[1] , '' 
         #品牌，xccw029
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw029
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw029_desc = '', g_rtn_fields[1] , '' 
         #项目编号，xccw030
         INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw030
         CALL ap_ref_array2(g_ref_fields,"SELECT pjbal003 FROM pjbal_t WHERE pjbalent='"||g_enterprise||"' AND pjbal001=? AND pjbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw030_desc = '', g_rtn_fields[1] , '' 
         #WBS，xccw031
         INITIALIZE g_ref_fields TO NULL 
         LET g_ref_fields[1] = g_xccw3_d[l_ac].xccw030            
         LET g_ref_fields[2] = g_xccw3_d[l_ac].xccw031
         CALL ap_ref_array2(g_ref_fields,"SELECT pjbbl004 FROM pjbbl_t WHERE pjbblent='"||g_enterprise||"' AND pjbbl001=? AND pjbbl002=? AND pjbbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_xccw3_d[l_ac].xccw031_desc = '', g_rtn_fields[1] , ''
         DISPLAY BY NAME g_xccw3_d[l_ac].xccw031_desc   
         LET g_xccw3_d[l_ac].xccw032_desc = s_desc_get_account_desc(g_xccw_m.xccwld,g_xccw3_d[l_ac].xccw032)   
         LET g_xccw3_d[l_ac].xccw033_desc = s_desc_get_account_desc(g_xccw_m.xccwld,g_xccw3_d[l_ac].xccw033)           
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xccw2_d[l_ac].xcckownid_desc = cl_get_username(g_xccw2_d[l_ac].xcckownid)
      #LET g_xccw2_d[l_ac].xcckowndp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckowndp)
      #LET g_xccw2_d[l_ac].xcckcrtid_desc = cl_get_username(g_xccw2_d[l_ac].xcckcrtid)
      #LET g_xccw2_d[l_ac].xcckcrtdp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckcrtdp)
      #LET g_xccw2_d[l_ac].xcckmodid_desc = cl_get_username(g_xccw2_d[l_ac].xcckmodid)
      ##LET .xcckcnfid_desc = cl_get_deptname(.xcckcnfid)
      ##LET .xcckpstid_desc = cl_get_deptname(.xcckpstid)
      
 
 
         
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xccw3_d.deleteElement(g_xccw3_d.getLength())
 
   END IF
   IF g_glaa015 = 'Y' THEN
   #單身三填充
   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw041,xccw042,xccw044,xccw201,xccw282a, 
          xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b, 
          xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw009 FROM xccw_t", 
             
                  "",
                  
                  " WHERE xccwent= ? AND xccwld=?  AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '2'"  
                 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   IF g_xccw012_p = '1' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '1' "
   END IF
   IF g_xccw012_p = '2' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '2' "
   END IF
   IF g_xccw012_p = '3' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '3' "
   END IF
   IF g_xccw012_p = '4' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '4' "
   END IF
   IF g_xccw012_p = '5' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '5' "
   END IF
   
   #判斷是否填充
   IF axct312_fill_chk(1) THEN
#      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw010,xccw_t.xccw007,xccw_t.xccw008"  #140905
      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw007,xccw_t.xccw008,xccw_t.xccw010"  #140905
      
      #add-point:b_fill段fill_before

      #end add-point
      
      PREPARE axct312_pb3 FROM g_sql
      DECLARE b_fill_cs3 CURSOR FOR axct312_pb3
      
#      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_xccw_m.xccwld
                                               ,g_xccw_m.xccw003
                                               ,g_xccw_m.xccw004
                                               ,g_xccw_m.xccw005
                                               ,g_xccw_m.xccw006
 
                                               
      FOREACH b_fill_cs3 INTO g_xccw6_d[l_ac].xccw001,g_xccw6_d[l_ac].xccw007,g_xccw6_d[l_ac].xccw008,g_xccw6_d[l_ac].xccw002, 
                              g_xccw6_d[l_ac].xccwsite,g_xccw6_d[l_ac].xccw010,g_xccw6_d[l_ac].xccw011,g_xccw6_d[l_ac].xccw041, 
                              g_xccw6_d[l_ac].xccw042,g_xccw6_d[l_ac].xccw044,g_xccw6_d[l_ac].xccw201,g_xccw6_d[l_ac].xccw282a, 
                              g_xccw6_d[l_ac].xccw282b,g_xccw6_d[l_ac].xccw282c,g_xccw6_d[l_ac].xccw282d,g_xccw6_d[l_ac].xccw282e, 
                              g_xccw6_d[l_ac].xccw282f,g_xccw6_d[l_ac].xccw282g,g_xccw6_d[l_ac].xccw282h,g_xccw6_d[l_ac].xccw282, 
                              g_xccw6_d[l_ac].xccw202,g_xccw6_d[l_ac].xccw202a,g_xccw6_d[l_ac].xccw202b,g_xccw6_d[l_ac].xccw202c, 
                              g_xccw6_d[l_ac].xccw202d,g_xccw6_d[l_ac].xccw202e,g_xccw6_d[l_ac].xccw202f,g_xccw6_d[l_ac].xccw202g, 
                              g_xccw6_d[l_ac].xccw202h,g_xccw6_d[l_ac].xccw009
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充
         CALL axct312_ref_detail(g_xccw6_d[l_ac].xccw002,g_xccw6_d[l_ac].xccw010,'','','')
            RETURNING g_xccw6_d[l_ac].xccw002_desc,g_xccw6_d[l_ac].xccw010_desc,g_xccw6_d[l_ac].xccw010_desc_desc,l_xccw015_desc,l_xccw015_desc,l_xccw021_desc
         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xccw2_d[l_ac].xcckownid_desc = cl_get_username(g_xccw2_d[l_ac].xcckownid)
      #LET g_xccw2_d[l_ac].xcckowndp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckowndp)
      #LET g_xccw2_d[l_ac].xcckcrtid_desc = cl_get_username(g_xccw2_d[l_ac].xcckcrtid)
      #LET g_xccw2_d[l_ac].xcckcrtdp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckcrtdp)
      #LET g_xccw2_d[l_ac].xcckmodid_desc = cl_get_username(g_xccw2_d[l_ac].xcckmodid)
      ##LET .xcckcnfid_desc = cl_get_deptname(.xcckcnfid)
      ##LET .xcckpstid_desc = cl_get_deptname(.xcckpstid)
      
 
 
         
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xccw6_d.deleteElement(g_xccw6_d.getLength())
 
   END IF
   END IF
   IF g_glaa019 = 'Y' THEN
   #單身四填充
   LET g_sql = "SELECT  UNIQUE xccw001,xccw007,xccw008,xccw002,xccwsite,xccw010,xccw011,xccw041,xccw042,xccw044,xccw201,xccw282a, 
          xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b, 
          xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw009 FROM xccw_t", 
             
                  "",
                  
                  " WHERE xccwent= ? AND xccwld=?  AND xccw003=? AND xccw004=? AND xccw005=? AND xccw006=? AND xccw001 = '3'"  
                 
   IF NOT cl_null(g_wc2_table1) THEN
      LET g_sql = g_sql CLIPPED," AND ",g_wc2_table1 CLIPPED
   END IF
   IF g_xccw012_p = '1' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '1' "
   END IF
   IF g_xccw012_p = '2' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '2' "
   END IF
   IF g_xccw012_p = '3' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '3' "
   END IF
   IF g_xccw012_p = '4' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '4' "
   END IF
   IF g_xccw012_p = '5' THEN 
      LET g_sql = g_sql CLIPPED," AND xccw012 = '5' "
   END IF
   
   #判斷是否填充
   IF axct312_fill_chk(1) THEN
      #      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw010,xccw_t.xccw007,xccw_t.xccw008"  #140905
      LET g_sql = g_sql, " ORDER BY xccw_t.xccw001,xccw_t.xccw007,xccw_t.xccw008,xccw_t.xccw010"  #140905
      
      #add-point:b_fill段fill_before
      CALL axct312_ref_detail(g_xccw5_d[l_ac].xccw002,g_xccw5_d[l_ac].xccw010,'','','')
            RETURNING g_xccw5_d[l_ac].xccw002_desc,g_xccw5_d[l_ac].xccw010_desc,g_xccw5_d[l_ac].xccw010_desc_desc,l_xccw015_desc,l_xccw015_desc,l_xccw021_desc
      #end add-point
      
      PREPARE axct312_pb4 FROM g_sql
      DECLARE b_fill_cs4 CURSOR FOR axct312_pb4
      
#      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_xccw_m.xccwld
                                               ,g_xccw_m.xccw003
                                               ,g_xccw_m.xccw004
                                               ,g_xccw_m.xccw005
                                               ,g_xccw_m.xccw006
 
                                               
      FOREACH b_fill_cs4 INTO g_xccw5_d[l_ac].xccw001,g_xccw5_d[l_ac].xccw007,g_xccw5_d[l_ac].xccw008,g_xccw5_d[l_ac].xccw002, 
                              g_xccw5_d[l_ac].xccwsite,g_xccw5_d[l_ac].xccw010,g_xccw5_d[l_ac].xccw011,g_xccw5_d[l_ac].xccw041,g_xccw5_d[l_ac].xccw042, 
                              g_xccw5_d[l_ac].xccw044,
                              g_xccw5_d[l_ac].xccw201,g_xccw5_d[l_ac].xccw282a,g_xccw5_d[l_ac].xccw282b,g_xccw5_d[l_ac].xccw282c, 
                              g_xccw5_d[l_ac].xccw282d,g_xccw5_d[l_ac].xccw282e,g_xccw5_d[l_ac].xccw282f,g_xccw5_d[l_ac].xccw282g, 
                              g_xccw5_d[l_ac].xccw282h,g_xccw5_d[l_ac].xccw282,g_xccw5_d[l_ac].xccw202,g_xccw5_d[l_ac].xccw202a, 
                              g_xccw5_d[l_ac].xccw202b,g_xccw5_d[l_ac].xccw202c,g_xccw5_d[l_ac].xccw202d,g_xccw5_d[l_ac].xccw202e, 
                              g_xccw5_d[l_ac].xccw202f,g_xccw5_d[l_ac].xccw202g,g_xccw5_d[l_ac].xccw202h,g_xccw5_d[l_ac].xccw009
 
                             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
                           
         #add-point:b_fill段資料填充

         #end add-point
      
         #帶出公用欄位reference值
         
         
         #此段落由子樣板a12產生
      #LET g_xccw2_d[l_ac].xcckownid_desc = cl_get_username(g_xccw2_d[l_ac].xcckownid)
      #LET g_xccw2_d[l_ac].xcckowndp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckowndp)
      #LET g_xccw2_d[l_ac].xcckcrtid_desc = cl_get_username(g_xccw2_d[l_ac].xcckcrtid)
      #LET g_xccw2_d[l_ac].xcckcrtdp_desc = cl_get_deptname(g_xccw2_d[l_ac].xcckcrtdp)
      #LET g_xccw2_d[l_ac].xcckmodid_desc = cl_get_username(g_xccw2_d[l_ac].xcckmodid)
      ##LET .xcckcnfid_desc = cl_get_deptname(.xcckcnfid)
      ##LET .xcckpstid_desc = cl_get_deptname(.xcckpstid)
      
 
 
         
         
         
 
        
         #add-point:單身資料抓取

         #end add-point
      
         LET l_ac = l_ac + 1
         IF l_ac > g_max_rec THEN
            EXIT FOREACH
         END IF
         
      END FOREACH
      
      CALL g_xccw5_d.deleteElement(g_xccw5_d.getLength())
 
   END IF
   END IF 
   #add-point:b_fill段more

   #end add-point
   
   LET g_rec_b=l_ac-1
   DISPLAY g_rec_b TO FORMONLY.cnt  
   LET l_ac = g_cnt
   LET g_cnt = 0 
 
   FREE axct312_pb1 
   FREE axct312_pb2
   FREE axct312_pb3
   FREE axct312_pb4   
END FUNCTION
# 功能幣二三金額修改
PRIVATE FUNCTION axct312_update()
   
   IF g_glaa015 = 'Y' THEN 
      
          
      UPDATE xccw_t SET (xccw201,xccw282a,xccw282b,xccw282c,xccw282d, 
                      xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,
                      xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw6_d[l_ac].xccw201,g_xccw6_d[l_ac].xccw282a, 
                   g_xccw6_d[l_ac].xccw282b,g_xccw6_d[l_ac].xccw282c,g_xccw6_d[l_ac].xccw282d,g_xccw6_d[l_ac].xccw282e, 
                   g_xccw6_d[l_ac].xccw282f,g_xccw6_d[l_ac].xccw282g,g_xccw6_d[l_ac].xccw282h,g_xccw6_d[l_ac].xccw282,g_xccw6_d[l_ac].xccw202, 
                   g_xccw6_d[l_ac].xccw202a,g_xccw6_d[l_ac].xccw202b,g_xccw6_d[l_ac].xccw202c,g_xccw6_d[l_ac].xccw202d, 
                   g_xccw6_d[l_ac].xccw202e,g_xccw6_d[l_ac].xccw202f,g_xccw6_d[l_ac].xccw202g,g_xccw6_d[l_ac].xccw202h) #自訂欄位頁簽
                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                    AND xccw003 = g_xccw_m.xccw003
                    AND xccw004 = g_xccw_m.xccw004
                    AND xccw005 = g_xccw_m.xccw005
                    AND xccw006 = g_xccw_m.xccw006
#                    AND xccw001 = g_xccw6_d[l_ac].xccw001 #項次 
                    AND xccw007 = g_xccw6_d[l_ac].xccw007
                    AND xccw008 = g_xccw6_d[l_ac].xccw008
                    AND xccw009 = g_xccw6_d[l_ac].xccw009
                    AND xccw002 = g_xccw6_d[l_ac].xccw002
                    AND xccw001 = '2'
     END IF
     
     IF g_glaa019 = 'Y' THEN   
        UPDATE xccw_t SET (xccw201,xccw282a,xccw282b,xccw282c,xccw282d, 
                      xccw282e,xccw282f,xccw282g,xccw282h,xccw282,xccw202,xccw202a,xccw202b,xccw202c,
                      xccw202d,xccw202e,xccw202f,xccw202g,xccw202h) = (g_xccw5_d[l_ac].xccw201,g_xccw5_d[l_ac].xccw282a, 
                   g_xccw5_d[l_ac].xccw282b,g_xccw5_d[l_ac].xccw282c,g_xccw5_d[l_ac].xccw282d,g_xccw5_d[l_ac].xccw282e, 
                   g_xccw5_d[l_ac].xccw282f,g_xccw5_d[l_ac].xccw282g,g_xccw5_d[l_ac].xccw282h,g_xccw5_d[l_ac].xccw282,g_xccw5_d[l_ac].xccw202, 
                   g_xccw5_d[l_ac].xccw202a,g_xccw5_d[l_ac].xccw202b,g_xccw5_d[l_ac].xccw202c,g_xccw5_d[l_ac].xccw202d, 
                   g_xccw5_d[l_ac].xccw202e,g_xccw5_d[l_ac].xccw202f,g_xccw5_d[l_ac].xccw202g,g_xccw5_d[l_ac].xccw202h) #自訂欄位頁簽
                   WHERE xccwent = g_enterprise AND xccwld = g_xccw_m.xccwld
                    AND xccw003 = g_xccw_m.xccw003
                    AND xccw004 = g_xccw_m.xccw004
                    AND xccw005 = g_xccw_m.xccw005
                    AND xccw006 = g_xccw_m.xccw006
#                    AND xccw001 = g_xccw5_d[l_ac].xccw001 #項次 
                    AND xccw007 = g_xccw5_d[l_ac].xccw007 
                    AND xccw008 = g_xccw5_d[l_ac].xccw008
                    AND xccw009 = g_xccw5_d[l_ac].xccw009
                    AND xccw002 = g_xccw5_d[l_ac].xccw002
                    AND xccw001 = '3'
     END IF
END FUNCTION

################################################################################
# Descriptions...: 設置顯示本位幣二三
# Memo...........:
# Usage..........: CALL axct312_visible()
# Date & Author..: 2014/04/28 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axct312_visible()
    IF cl_null(g_xccw_m.xccwcomp) THEN
       CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING g_para_data   #采用成本域否  
    ELSE
       CALL cl_get_para(g_enterprise,g_xccw_m.xccwcomp,'S-FIN-6001') RETURNING g_para_data   #采用成本域否      
    END IF
      
    IF g_para_data = 'Y' THEN
       CALL cl_set_comp_visible('xccw002,xccw002_desc,xccw002_3,xccw002_3_desc,xccw002_6,xccw002_6_desc,xccw002_5,xccw002_5_desc',TRUE)                    
    ELSE
       CALL cl_set_comp_visible('xccw002,xccw002_desc,xccw002_3,xccw002_3_desc,xccw002_6,xccw002_6_desc,xccw002_5,xccw002_5_desc',FALSE)                
    END IF
   IF g_glaa015 = 'Y' THEN 
      CALL cl_set_comp_visible('page_2',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_2',FALSE) 
   END IF 
   IF g_glaa019 = 'Y' THEN 
      CALL cl_set_comp_visible('page_5',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_5',FALSE) 
   END IF 
END FUNCTION

################################################################################
# Descriptions...: 獲取成本域
# Memo...........:
# Usage..........: CALL axct312_get_xccw002(p_site,p_inaj001,p_inaj002,p_inaj003)
#                  RETURNING r_xccw002,r_xccw100
# Input parameter: p_site         組織編號
#                : p_inaj001      單號
#                : p_inaj002      項次
#                : p_inaj003      序號
# Return code....: r_xccw002      成本域
#                : r_xccw009      出入庫碼
# Date & Author..: 2014/04/28 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axct312_get_xccw002(p_site,p_inaj001,p_inaj002,p_inaj003)
   DEFINE p_site          LIKE inaj_t.inajsite
   DEFINE p_inaj001       LIKE inaj_t.inaj001
   DEFINE p_inaj002       LIKE inaj_t.inaj002
   DEFINE p_inaj003       LIKE inaj_t.inaj003
   DEFINE l_inajsite      LIKE inaj_t.inajsite
   DEFINE l_inaj008       LIKE inaj_t.inaj008
   DEFINE r_xccw002       LIKE xccw_t.xccw002
   DEFINE r_xccw009       LIKE xccw_t.xccw009
   
   LET l_inajsite = '' 
   LET l_inaj008 = ''
   LET r_xccw002 = ''
   LET r_xccw009 = ''
   SELECT inajsite,inaj004,inaj008 
     INTO l_inajsite,r_xccw009,l_inaj008
     FROM inaj_t 
    WHERE inajent = g_enterprise
      AND inajsite = p_site
      AND inaj001 = p_inaj001
      AND inaj002 = p_inaj002
      AND inaj003 = p_inaj003
   
   #成本域
   IF g_para_data = 'Y' THEN 
      IF g_para_data1 = '1' THEN 
         LET g_sql = " SELECT xcbf001 FROM xcbf_t ",
                     "  WHERE xcbfent = '",g_enterprise,"'", 
                     "    AND xcbfcomp = '",l_inajsite,"'",
                     "    AND xcbf003 = '1'"
         PREPARE xcbf001_pre FROM g_sql
         DECLARE xcbf001_cur CURSOR FOR xcbf001_pre
         OPEN xcbf001_cur
         FETCH xcbf001_cur INTO r_xccw002
      END IF
      IF g_para_data1 = '2' THEN 
         LET g_sql = " SELECT xcbf001 FROM xcbf_t ",
                     "  WHERE xcbfent = '",g_enterprise,"'", 
                     "    AND xcbf002 = '",l_inaj008,"'",
                     "    AND xcbf003 = '2'"
         PREPARE xcbf001_pre1 FROM g_sql
         DECLARE xcbf001_cur1 CURSOR FOR xcbf001_pre1
         OPEN xcbf001_cur1
         FETCH xcbf001_cur1 INTO r_xccw002
      END IF
   END IF
   IF cl_null(r_xccw002) THEN 
      LET r_xccw002 = ' '
   END IF
   
   RETURN r_xccw002,r_xccw009
END FUNCTION

################################################################################
# Descriptions...: 產生調撥出庫入庫成本資料
# Memo...........:
# Usage..........: CALL axct312_ins_xccw_5()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2014/04/28 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axct312_ins_xccw_5()
   #161109-00085#24-s mod
#   DEFINE l_indc          RECORD  LIKE indc_t.*   #161109-00085#24-s mark
   DEFINE l_indc          RECORD  #調撥單單頭檔
       indcent LIKE indc_t.indcent, #企業編號
       indcsite LIKE indc_t.indcsite, #營運據點
       indcunit LIKE indc_t.indcunit, #應用組織
       indcdocno LIKE indc_t.indcdocno, #調撥單號
       indcdocdt LIKE indc_t.indcdocdt, #調撥日期
       indc000 LIKE indc_t.indc000, #單據性質
       indc001 LIKE indc_t.indc001, #對應調撥單號
       indc002 LIKE indc_t.indc002, #來源類別
       indc003 LIKE indc_t.indc003, #來源單號
       indc004 LIKE indc_t.indc004, #調撥人員
       indc005 LIKE indc_t.indc005, #撥出營運據點
       indc006 LIKE indc_t.indc006, #撥入營運據點
       indc007 LIKE indc_t.indc007, #在途倉
       indc008 LIKE indc_t.indc008, #備註
       indc021 LIKE indc_t.indc021, #撥出確認人員
       indc022 LIKE indc_t.indc022, #撥出確認日期
       indc023 LIKE indc_t.indc023, #撥入確認人員
       indc024 LIKE indc_t.indc024, #撥入確認日期
       indcstus LIKE indc_t.indcstus, #狀態碼
       indcownid LIKE indc_t.indcownid, #資料所有者
       indcowndp LIKE indc_t.indcowndp, #資料所屬部門
       indccrtid LIKE indc_t.indccrtid, #資料建立者
       indccrtdp LIKE indc_t.indccrtdp, #資料建立部門
       indccrtdt LIKE indc_t.indccrtdt, #資料創建日
       indcmodid LIKE indc_t.indcmodid, #資料修改者
       indcmoddt LIKE indc_t.indcmoddt, #最近修改日
       indccnfid LIKE indc_t.indccnfid, #資料確認者
       indccnfdt LIKE indc_t.indccnfdt, #資料確認日
       indcpstid LIKE indc_t.indcpstid, #資料過帳者
       indcpstdt LIKE indc_t.indcpstdt, #資料過帳日
       indc101 LIKE indc_t.indc101, #調撥部門
       indc102 LIKE indc_t.indc102, #檢驗方式
       indc103 LIKE indc_t.indc103, #包裝單製作
       indc104 LIKE indc_t.indc104, #Invoice製作
       indc105 LIKE indc_t.indc105, #送貨地址
       indc106 LIKE indc_t.indc106, #運輸方式
       indc107 LIKE indc_t.indc107, #起運地點
       indc108 LIKE indc_t.indc108, #到達地點
       indc109 LIKE indc_t.indc109, #在途非成本庫位
       indc151 LIKE indc_t.indc151, #調撥理由
       indc199 LIKE indc_t.indc199, #調撥性質
       indc009 LIKE indc_t.indc009, #單一單位庫存單位變更
       indc200 LIKE indc_t.indc200, #撥出倉庫
       indc201 LIKE indc_t.indc201, #撥入倉庫
       indc010 LIKE indc_t.indc010, #調整單號
       indc202 LIKE indc_t.indc202, #操作類型
       indc025 LIKE indc_t.indc025, #前端單號
       indc026 LIKE indc_t.indc026  #前端類型
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_indd          RECORD  LIKE indd_t.*   #161109-00085#24-s mark
   DEFINE l_indd          RECORD  #調撥單單身明細檔
       inddent LIKE indd_t.inddent, #企業編號
       inddsite LIKE indd_t.inddsite, #營運據點
       inddunit LIKE indd_t.inddunit, #應用組織
       indddocno LIKE indd_t.indddocno, #調撥單號
       inddseq LIKE indd_t.inddseq, #項次
       indd001 LIKE indd_t.indd001, #來源項次
       indd002 LIKE indd_t.indd002, #商品編號
       indd003 LIKE indd_t.indd003, #商品條碼
       indd004 LIKE indd_t.indd004, #產品特徵
       indd005 LIKE indd_t.indd005, #經營方式
       indd006 LIKE indd_t.indd006, #庫存單位
       indd007 LIKE indd_t.indd007, #包裝單位
       indd008 LIKE indd_t.indd008, #件裝數
       indd009 LIKE indd_t.indd009, #預調撥量
       indd020 LIKE indd_t.indd020, #撥出件數
       indd021 LIKE indd_t.indd021, #撥出數量
       indd022 LIKE indd_t.indd022, #撥出庫位
       indd023 LIKE indd_t.indd023, #撥出儲位
       indd024 LIKE indd_t.indd024, #撥出批號
       indd030 LIKE indd_t.indd030, #撥入件數
       indd031 LIKE indd_t.indd031, #撥入數量
       indd032 LIKE indd_t.indd032, #撥入庫位
       indd033 LIKE indd_t.indd033, #撥入儲位
       indd034 LIKE indd_t.indd034, #撥入批號
       indd040 LIKE indd_t.indd040, #結案否
       indd101 LIKE indd_t.indd101, #來源單號
       indd102 LIKE indd_t.indd102, #庫存管理特徵
       indd103 LIKE indd_t.indd103, #撥出申請量
       indd104 LIKE indd_t.indd104, #參考單位
       indd105 LIKE indd_t.indd105, #撥出申請參考數量
       indd106 LIKE indd_t.indd106, #撥出合格參考數量
       indd107 LIKE indd_t.indd107, #撥入申請數量
       indd108 LIKE indd_t.indd108, #撥入申請參考數量
       indd109 LIKE indd_t.indd109, #撥入合格參考數量
       indd110 LIKE indd_t.indd110, #差異量
       indd111 LIKE indd_t.indd111, #差異原因
       indd112 LIKE indd_t.indd112, #差異已調整量
       indd151 LIKE indd_t.indd151, #調撥理由
       indd152 LIKE indd_t.indd152, #備註
       indd041 LIKE indd_t.indd041, #撥入單位
       indd042 LIKE indd_t.indd042, #專案編號
       indd043 LIKE indd_t.indd043, #WBS
       indd044 LIKE indd_t.indd044, #活動編號
       indd010 LIKE indd_t.indd010, #多庫儲否
       indd025 LIKE indd_t.indd025, #撥出組織庫存數量
       indd035 LIKE indd_t.indd035, #撥入組織庫存數量
       indd045 LIKE indd_t.indd045, #預估單價
       indd046 LIKE indd_t.indd046, #預估金額
       indd047 LIKE indd_t.indd047, #來源需求單號
       indd048 LIKE indd_t.indd048  #來源需求項次
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_inde          RECORD  LIKE inde_t.*    #161109-00085#24-s mark
   DEFINE l_inde          RECORD  #調撥差異調整單單頭檔
       indeent LIKE inde_t.indeent, #企業編號
       indesite LIKE inde_t.indesite, #營運據點
       indeunit LIKE inde_t.indeunit, #應用組織
       indedocno LIKE inde_t.indedocno, #單號
       indedocdt LIKE inde_t.indedocdt, #單據日期
       inde001 LIKE inde_t.inde001, #來源調撥單號
       inde002 LIKE inde_t.inde002, #調整人員
       inde003 LIKE inde_t.inde003, #撥出營運據點
       inde004 LIKE inde_t.inde004, #撥入營運據點
       inde005 LIKE inde_t.inde005, #在途倉
       inde101 LIKE inde_t.inde101, #調整部門
       inde102 LIKE inde_t.inde102, #在途庫位(非成本庫)
       inde006 LIKE inde_t.inde006, #備註
       indeownid LIKE inde_t.indeownid, #資料所有者
       indeowndp LIKE inde_t.indeowndp, #資料所屬部門
       indecrtid LIKE inde_t.indecrtid, #資料建立者
       indecrtdp LIKE inde_t.indecrtdp, #資料建立部門
       indecrtdt LIKE inde_t.indecrtdt, #資料創建日
       indemodid LIKE inde_t.indemodid, #資料修改者
       indemoddt LIKE inde_t.indemoddt, #最近修改日
       indecnfid LIKE inde_t.indecnfid, #資料確認者
       indecnfdt LIKE inde_t.indecnfdt, #資料確認日
       indestus LIKE inde_t.indestus  #狀態碼
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_indf          RECORD  LIKE indf_t.*   #161109-00085#24-s mark
   DEFINE l_indf          RECORD  #調撥差異調整單單身明細檔
       indfent LIKE indf_t.indfent, #企業編號
       indfsite LIKE indf_t.indfsite, #營運據點
       indfunit LIKE indf_t.indfunit, #應用組織
       indfdocno LIKE indf_t.indfdocno, #單號
       indfseq LIKE indf_t.indfseq, #項次
       indf001 LIKE indf_t.indf001, #來源項次
       indf002 LIKE indf_t.indf002, #商品編號
       indf003 LIKE indf_t.indf003, #商品條碼
       indf004 LIKE indf_t.indf004, #產品特徵
       indf005 LIKE indf_t.indf005, #經營方式
       indf006 LIKE indf_t.indf006, #庫存單位
       indf007 LIKE indf_t.indf007, #包裝單位
       indf008 LIKE indf_t.indf008, #件裝數
       indf020 LIKE indf_t.indf020, #撥出件數
       indf021 LIKE indf_t.indf021, #撥出數量
       indf022 LIKE indf_t.indf022, #撥出庫位
       indf023 LIKE indf_t.indf023, #撥出儲位
       indf024 LIKE indf_t.indf024, #撥出批號
       indf030 LIKE indf_t.indf030, #撥入件數
       indf031 LIKE indf_t.indf031, #撥入數量
       indf032 LIKE indf_t.indf032, #撥入庫位
       indf033 LIKE indf_t.indf033, #撥入儲位
       indf034 LIKE indf_t.indf034, #撥入批號
       indf040 LIKE indf_t.indf040, #申請調整數量
       indf041 LIKE indf_t.indf041, #核准數量
       indf042 LIKE indf_t.indf042, #原因碼
       indf043 LIKE indf_t.indf043, #備註
       indf101 LIKE indf_t.indf101, #來源調撥單號
       indf102 LIKE indf_t.indf102, #庫存管理特徵
       indf103 LIKE indf_t.indf103, #撥入方權責量
       indf104 LIKE indf_t.indf104, #參考單位
       indf105 LIKE indf_t.indf105, #撥出方權責參考數量
       indf106 LIKE indf_t.indf106, #撥入方權責參考數量
       indf044 LIKE indf_t.indf044, #撥入單位
       indf009 LIKE indf_t.indf009, #來源項序
       indf045 LIKE indf_t.indf045, #預估單價
       indf046 LIKE indf_t.indf046, #預估金額
       indf047 LIKE indf_t.indf047, #成本單價
       indf048 LIKE indf_t.indf048  #成本金額
          END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_xccw       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
   DEFINE l_xccw       RECORD  #本期料件明細進出補成本檔
          xccwent LIKE xccw_t.xccwent, #企業編號
          xccwsite LIKE xccw_t.xccwsite, #site組織
          xccwcomp LIKE xccw_t.xccwcomp, #法人組織
          xccwld LIKE xccw_t.xccwld, #帳套
          xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
          xccw002 LIKE xccw_t.xccw002, #成本域
          xccw003 LIKE xccw_t.xccw003, #成本計算類型
          xccw004 LIKE xccw_t.xccw004, #年度
          xccw005 LIKE xccw_t.xccw005, #期別
          xccw006 LIKE xccw_t.xccw006, #參考單號
          xccw007 LIKE xccw_t.xccw007, #項次
          xccw008 LIKE xccw_t.xccw008, #項序
          xccw009 LIKE xccw_t.xccw009, #出入庫碼
          xccw010 LIKE xccw_t.xccw010, #料號
          xccw011 LIKE xccw_t.xccw011, #特性
          xccw012 LIKE xccw_t.xccw012, #單據類型
          xccw013 LIKE xccw_t.xccw013, #單據日期
          xccw014 LIKE xccw_t.xccw014, #時間
          xccw015 LIKE xccw_t.xccw015, #倉庫編號
          xccw016 LIKE xccw_t.xccw016, #儲位編號
          xccw017 LIKE xccw_t.xccw017, #批號
          xccw020 LIKE xccw_t.xccw020, #異動類型
          xccw021 LIKE xccw_t.xccw021, #原因碼
          xccw022 LIKE xccw_t.xccw022, #交易對象
          xccw023 LIKE xccw_t.xccw023, #客群
          xccw024 LIKE xccw_t.xccw024, #區域
          xccw025 LIKE xccw_t.xccw025, #成本中心
          xccw026 LIKE xccw_t.xccw026, #經營類別
          xccw027 LIKE xccw_t.xccw027, #通路
          xccw028 LIKE xccw_t.xccw028, #品類
          xccw029 LIKE xccw_t.xccw029, #品牌
          xccw030 LIKE xccw_t.xccw030, #專案號
          xccw031 LIKE xccw_t.xccw031, #WBS
          xccw032 LIKE xccw_t.xccw032, #存貨科目
          xccw033 LIKE xccw_t.xccw033, #費用成本科目
          xccw034 LIKE xccw_t.xccw034, #收入科目
          xccw040 LIKE xccw_t.xccw040, #交易幣別
          xccw041 LIKE xccw_t.xccw041, #本位幣別
          xccw042 LIKE xccw_t.xccw042, #匯率
          xccw043 LIKE xccw_t.xccw043, #交易單位
          xccw044 LIKE xccw_t.xccw044, #成本單位
          xccw045 LIKE xccw_t.xccw045, #換算率
          xccw046 LIKE xccw_t.xccw046, #交易數量
          xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
          xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
          xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
          xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
          xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
          xccw201 LIKE xccw_t.xccw201, #本期異動數量
          xccw202 LIKE xccw_t.xccw202, #本期異動金額
          xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
          xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
          xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
          xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
          xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
          xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
          xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
          xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
          xccw282 LIKE xccw_t.xccw282, #本期異動單價
          xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
          xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
          xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
          xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
          xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
          xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
          xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
          xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
          xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
          xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
          xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
          xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
          xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
          xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
          xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
          xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
          xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
          xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
          xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
          xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
          xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
          xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
          xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
          xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
          xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
          xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
          xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
          xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
          xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
          xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
          xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
          xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
          xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
          xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
          xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
          xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
          xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
          xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                    END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_xccw_p       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
   DEFINE l_xccw_p       RECORD  #本期料件明細進出補成本檔
       xccwent LIKE xccw_t.xccwent, #企業編號
       xccwsite LIKE xccw_t.xccwsite, #site組織
       xccwcomp LIKE xccw_t.xccwcomp, #法人組織
       xccwld LIKE xccw_t.xccwld, #帳套
       xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
       xccw002 LIKE xccw_t.xccw002, #成本域
       xccw003 LIKE xccw_t.xccw003, #成本計算類型
       xccw004 LIKE xccw_t.xccw004, #年度
       xccw005 LIKE xccw_t.xccw005, #期別
       xccw006 LIKE xccw_t.xccw006, #參考單號
       xccw007 LIKE xccw_t.xccw007, #項次
       xccw008 LIKE xccw_t.xccw008, #項序
       xccw009 LIKE xccw_t.xccw009, #出入庫碼
       xccw010 LIKE xccw_t.xccw010, #料號
       xccw011 LIKE xccw_t.xccw011, #特性
       xccw012 LIKE xccw_t.xccw012, #單據類型
       xccw013 LIKE xccw_t.xccw013, #單據日期
       xccw014 LIKE xccw_t.xccw014, #時間
       xccw015 LIKE xccw_t.xccw015, #倉庫編號
       xccw016 LIKE xccw_t.xccw016, #儲位編號
       xccw017 LIKE xccw_t.xccw017, #批號
       xccw020 LIKE xccw_t.xccw020, #異動類型
       xccw021 LIKE xccw_t.xccw021, #原因碼
       xccw022 LIKE xccw_t.xccw022, #交易對象
       xccw023 LIKE xccw_t.xccw023, #客群
       xccw024 LIKE xccw_t.xccw024, #區域
       xccw025 LIKE xccw_t.xccw025, #成本中心
       xccw026 LIKE xccw_t.xccw026, #經營類別
       xccw027 LIKE xccw_t.xccw027, #通路
       xccw028 LIKE xccw_t.xccw028, #品類
       xccw029 LIKE xccw_t.xccw029, #品牌
       xccw030 LIKE xccw_t.xccw030, #專案號
       xccw031 LIKE xccw_t.xccw031, #WBS
       xccw032 LIKE xccw_t.xccw032, #存貨科目
       xccw033 LIKE xccw_t.xccw033, #費用成本科目
       xccw034 LIKE xccw_t.xccw034, #收入科目
       xccw040 LIKE xccw_t.xccw040, #交易幣別
       xccw041 LIKE xccw_t.xccw041, #本位幣別
       xccw042 LIKE xccw_t.xccw042, #匯率
       xccw043 LIKE xccw_t.xccw043, #交易單位
       xccw044 LIKE xccw_t.xccw044, #成本單位
       xccw045 LIKE xccw_t.xccw045, #換算率
       xccw046 LIKE xccw_t.xccw046, #交易數量
       xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
       xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
       xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
       xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
       xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
       xccw201 LIKE xccw_t.xccw201, #本期異動數量
       xccw202 LIKE xccw_t.xccw202, #本期異動金額
       xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
       xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
       xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
       xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
       xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
       xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
       xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
       xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
       xccw282 LIKE xccw_t.xccw282, #本期異動單價
       xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
       xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
       xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
       xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
       xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
       xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
       xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
       xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
       xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
       xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
       xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
       xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
       xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
       xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
       xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
       xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
       xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
       xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
       xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
       xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
       xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
       xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
       xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
       xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
       xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
       xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
       xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
       xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
       xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
       xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
       xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
       xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
       xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
       xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
       xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
       xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
       xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
       xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                 END RECORD
   #161109-00085#24-e mod
#   DEFINE l_xccc281       LIKE xccc_t.xccc281
#   DEFINE l_xccc281a      LIKE xccc_t.xccc281a
#   DEFINE l_xccc281b      LIKE xccc_t.xccc281b
#   DEFINE l_xccc281c      LIKE xccc_t.xccc281c
#   DEFINE l_xccc281d      LIKE xccc_t.xccc281d
#   DEFINE l_xccc281e      LIKE xccc_t.xccc281e
#   DEFINE l_xccc281f      LIKE xccc_t.xccc281f
#   DEFINE l_xccc281g      LIKE xccc_t.xccc281g
#   DEFINE l_xccc281h      LIKE xccc_t.xccc281h
   DEFINE l_xccc010       LIKE xccc_t.xccc010 
   DEFINE l_glcc002       LIKE glcc_t.glcc002
   DEFINE l_glab005       LIKE glab_t.glab005
   DEFINE l_imag011       LIKE imag_t.imag011
   DEFINE l_exrate        LIKE xccw_t.xccw042
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_xccw282       LIKE xccw_t.xccw282
   DEFINE l_xccw282a      LIKE xccw_t.xccw282a
   DEFINE l_xccw282b      LIKE xccw_t.xccw282b
   DEFINE l_xccw282c      LIKE xccw_t.xccw282c
   DEFINE l_xccw282d      LIKE xccw_t.xccw282d
   DEFINE l_xccw282e      LIKE xccw_t.xccw282e
   DEFINE l_xccw282f      LIKE xccw_t.xccw282f
   DEFINE l_xccw282g      LIKE xccw_t.xccw282g
   DEFINE l_xccw282h      LIKE xccw_t.xccw282h
   DEFINE l_flag          LIKE type_t.chr1       #檢核狀態
   DEFINE l_errno         LIKE type_t.chr100     #錯誤訊息
   DEFINE l_glav002       LIKE glav_t.glav002    #會計年度
   DEFINE l_glav005       LIKE glav_t.glav005    #歸屬季別
   DEFINE l_sdate_s       LIKE glav_t.glav004    #當季起始日
   DEFINE l_sdate_e       LIKE glav_t.glav004    #當季截止日
   DEFINE l_glav006       LIKE glav_t.glav006    #歸屬期別
   DEFINE l_pdate_s       LIKE glav_t.glav004    #當期起始日
   DEFINE l_pdate_e       LIKE glav_t.glav004    #當期截止日
   DEFINE l_glav007       LIKE glav_t.glav007    #歸屬週別
   DEFINE l_wdate_s       LIKE glav_t.glav004    #當週起始日
   DEFINE l_wdate_e       LIKE glav_t.glav004    #當週截止日
   DEFINE l_n             LIKE type_t.num5
   
   #161109-00085#24-s mod
#   LET g_sql = "SELECT * FROM indc_t,indd_t ",   #161109-00085#24-s mark
   LET g_sql = "SELECT indcent,indcsite,indcunit,indcdocno,indcdocdt,indc000,indc001,indc002,indc003,indc004,
                       indc005,indc006,indc007,indc008,indc021,indc022,indc023,indc024,indcstus,indcownid,indcowndp,
                       indccrtid,indccrtdp,indccrtdt,indcmodid,indcmoddt,indccnfid,indccnfdt,indcpstid,indcpstdt,
                       indc101,indc102,indc103,indc104,indc105,indc106,indc107,indc108,indc109,indc151,indc199,indc009,
                       indc200,indc201,indc010,indc202,indc025,indc026,inddent,inddsite,inddunit,indddocno,inddseq,indd001,
                       indd002,indd003,indd004,indd005,indd006,indd007,indd008,indd009,indd020,indd021,indd022,indd023,
                       indd024,indd030,indd031,indd032,indd033,indd034,indd040,indd101,indd102,indd103,indd104,indd105,
                       indd106,indd107,indd108,indd109,indd110,indd111,indd112,indd151,indd152,indd041,indd042,indd043,
                       indd044,indd010,indd025,indd035,indd045,indd046,indd047,indd048   
                  FROM indc_t,indd_t ",
   #161109-00085#24-e mod
               " WHERE indcent = '",g_enterprise,"'",
               "   AND indcdocno = '",g_xccw_m.xccw006,"'",
               "   AND indcent = inddent ",
               "   AND indcdocno = indddocno ",
               "   AND indcsite = inddsite ",
               "   AND indcstus IN ('O','P','C') "
   PREPARE indc_pre FROM g_sql
   DECLARE indc_cur CURSOR FOR indc_pre
   
   #費用科目（agli180）
   LET l_glab005=''
   CALL s_fin_get_account(g_xccw_m.xccwld,'11','8504','8504_01') RETURNING l_success,l_glab005,l_errno
   IF l_success=FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #161109-00085#24-s mod
#   FOREACH indc_cur INTO l_indc.*,l_indd.*   #161109-00085#24-s mark
   FOREACH indc_cur INTO l_indc.indcent,l_indc.indcsite,l_indc.indcunit,l_indc.indcdocno,l_indc.indcdocdt,l_indc.indc000,
                         l_indc.indc001,l_indc.indc002,l_indc.indc003,l_indc.indc004,l_indc.indc005,l_indc.indc006,
                         l_indc.indc007,l_indc.indc008,l_indc.indc021,l_indc.indc022,l_indc.indc023,l_indc.indc024,
                         l_indc.indcstus,l_indc.indcownid,l_indc.indcowndp,l_indc.indccrtid,l_indc.indccrtdp,l_indc.indccrtdt,
                         l_indc.indcmodid,l_indc.indcmoddt,l_indc.indccnfid,l_indc.indccnfdt,l_indc.indcpstid,l_indc.indcpstdt,
                         l_indc.indc101,l_indc.indc102,l_indc.indc103,l_indc.indc104,l_indc.indc105,l_indc.indc106,
                         l_indc.indc107,l_indc.indc108,l_indc.indc109,l_indc.indc151,l_indc.indc199,l_indc.indc009,
                         l_indc.indc200,l_indc.indc201,l_indc.indc010,l_indc.indc202,l_indc.indc025,l_indc.indc026,
                         l_indd.inddent,l_indd.inddsite,l_indd.inddunit,l_indd.indddocno,l_indd.inddseq,l_indd.indd001,
                         l_indd.indd002,l_indd.indd003,l_indd.indd004,l_indd.indd005,l_indd.indd006,l_indd.indd007,
                         l_indd.indd008,l_indd.indd009,l_indd.indd020,l_indd.indd021,l_indd.indd022,l_indd.indd023,
                         l_indd.indd024,l_indd.indd030,l_indd.indd031,l_indd.indd032,l_indd.indd033,l_indd.indd034,
                         l_indd.indd040,l_indd.indd101,l_indd.indd102,l_indd.indd103,l_indd.indd104,l_indd.indd105,
                         l_indd.indd106,l_indd.indd107,l_indd.indd108,l_indd.indd109,l_indd.indd110,l_indd.indd111,
                         l_indd.indd112,l_indd.indd151,l_indd.indd152,l_indd.indd041,l_indd.indd042,l_indd.indd043,
                         l_indd.indd044,l_indd.indd010,l_indd.indd025,l_indd.indd035,l_indd.indd045,l_indd.indd046,
                         l_indd.indd047,l_indd.indd048   

                         
   #161109-00085#24-e mod
      IF SQLCA.sqlcode THEN
         CALL cl_errmsg('','FOREACH indc_cur','',SQLCA.sqlcode,1)
         LET g_success='N'
         EXIT FOREACH
      END IF
      #成本域、出入庫碼
      CALL axct312_get_xccw002(l_indc.indc005,l_indc.indcdocno,l_indd.inddseq,l_indd.indd001) 
      RETURNING l_xccw.xccw002,l_xccw.xccw009

      #品類
      LET l_imag011 = ''
      SELECT imag011 INTO l_imag011 FROM imag_t
       WHERE imagent = g_enterprise AND imagsite = l_indc.indc005 AND imag001 = l_indd.indd002
      #存貨科目（agli161）
      LET l_glcc002 = ''
      CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_indd.indd002,'','',l_indc.indc005,'')
      RETURNING l_success,l_glcc002
      
      LET l_xccw.xccwent = g_enterprise
      LET l_xccw.xccwsite = l_indc.indc005
      LET l_xccw.xccwld  = g_xccw_m.xccwld
      LET l_xccw.xccwcomp= g_xccw_m.xccwcomp
      LET l_xccw.xccw001 = '1'
      LET l_xccw.xccw003 = g_xccw_m.xccw003
      LET l_xccw.xccw004 = g_xccw_m.xccw004
      LET l_xccw.xccw005 = g_xccw_m.xccw005
      LET l_xccw.xccw010 = l_indd.indd002
      LET l_xccw.xccw011 = l_indd.indd004
      LET l_xccw.xccw006 = l_indc.indcdocno
      LET l_xccw.xccw007 = l_indd.inddseq
      LET l_xccw.xccw008 = l_indd.indd001
      LET l_xccw.xccw014 = g_xccw012_p    #內部調撥
      LET l_xccw.xccw013 = l_indc.indcdocdt
      LET l_xccw.xccw015 = l_indd.indd022 #撥出倉庫
      LET l_xccw.xccw016 = l_indd.indd023 #撥出庫位
      LET l_xccw.xccw017 = l_indd.indd024 #撥出批號
      
      LET l_xccw.xccw020 = ''
      LET l_xccw.xccw021 = l_indc.indc151
      LET l_xccw.xccw043 = l_indd.indd007 #包裝單位
      LET l_xccw.xccw046 = l_indd.indd021 #撥出數量
      LET l_xccw.xccw044 = l_indd.indd006 #庫存單位
      CALL s_aimi190_get_convert(l_xccw.xccw010,l_xccw.xccw043,l_xccw.xccw044)
      RETURNING l_success,l_xccw.xccw045
      LET l_xccw.xccw201 = l_xccw.xccw045 * l_xccw.xccw046
      LET l_xccw.xccw032 = l_glcc002 #存貨科目
      LET l_xccw.xccw033 = l_glab005 #費用科目
      
      #沒有在調撥單中找到對應的字段，故賦值為空格
      #交易對象
      LET l_xccw.xccw022=' '
      #客群
      LET l_xccw.xccw023=' '
      #區域
      LET l_xccw.xccw024=' '
      #成本中心
      LET l_xccw.xccw025=' '
      #經營類別
      LET l_xccw.xccw026=l_indd.indd005
      #渠道
      LET l_xccw.xccw027=' '
      #品類
      LET l_xccw.xccw028 = l_imag011
      #品牌
      LET l_xccw.xccw029=' '
      #項目編號
      LET l_xccw.xccw030=' '
      #WBS編號
      LET l_xccw.xccw031=' '
      
     
      
      #獲取當前年度期別的第一天
      CALL s_get_accdate(g_glaa003,'',g_xccw_m.xccw004,g_xccw_m.xccw005)
      RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
      
      IF NOT cl_null(l_xccc010) THEN   #yangtt 将l_xcc009改成l_xcc010，因xcct_t中无此字段
                                    #  帳套;             日期;     來源幣別
         CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,l_pdate_s,g_glaa001,
                                   #目的幣別;  交易金額; 匯類類型
                                     l_xccc010,0,g_glaa025)
         RETURNING l_exrate
      ELSE
         LET l_exrate = 1
      END IF
      LET l_xccw.xccw040 = g_glaa001
      LET l_xccw.xccw041 = g_glaa001
      LET l_xccw.xccw042 = 1
      #單價
      LET l_xccw.xccw282  = 0
      LET l_xccw.xccw282a = 0
      LET l_xccw.xccw282b = 0
      LET l_xccw.xccw282c = 0
      LET l_xccw.xccw282d = 0
      LET l_xccw.xccw282e = 0
      LET l_xccw.xccw282f = 0
      LET l_xccw.xccw282g = 0
      LET l_xccw.xccw282h = 0
      #金額
      LET l_xccw.xccw202  = 0
      LET l_xccw.xccw202a = 0
      LET l_xccw.xccw202b = 0
      LET l_xccw.xccw202c = 0
      LET l_xccw.xccw202d = 0
      LET l_xccw.xccw202e = 0
      LET l_xccw.xccw202f = 0
      LET l_xccw.xccw202g = 0
      LET l_xccw.xccw202h = 0
      
      #161109-00085#24-s mod
#      CALL axct312_ins_xccw(l_xccw.*)   #161109-00085#24-s mark
      CALL axct312_ins_xccw(l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                            l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                            l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                            l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                            l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                            l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                            l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                            l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                            l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                            l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                            l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                            l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                            l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                            l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                            l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                            l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                            l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                            l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                            l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                            l_xccw.xccwud029,l_xccw.xccwud030)
      #161109-00085#24-e mod
      
      #當撥入確認或者正常結案時產生一筆進貨成本異動（營運據點=撥入組織）
      IF l_indc.indcstus='P' OR l_indc.indcstus='C' THEN 
         LET l_xccw_p.*=l_xccw.*   #161109-00085#24-s mark
         LET l_xccw_p.xccwsite= l_indc.indc006
         #成本域、出入庫碼
         CALL axct312_get_xccw002(l_indc.indc005,l_indc.indcdocno,l_indd.inddseq,l_indd.indd001) 
         RETURNING l_xccw_p.xccw002,l_xccw_p.xccw009
         #品類
         LET l_imag011 = ''
         SELECT imag011 INTO l_imag011 FROM imag_t
          WHERE imagent = g_enterprise AND imagsite = l_indc.indc006 AND imag001 = l_indd.indd002
         #存貨科目（agli161）
         LET l_glcc002 = ''
         CALL s_get_item_acc(g_xccw_m.xccwld,'1',l_indd.indd002,'','',l_indc.indc006,'')
         RETURNING l_success,l_glcc002
         LET l_xccw_p.xccw015 = l_indd.indd032 #撥入倉庫
         LET l_xccw_p.xccw016 = l_indd.indd033 #撥入庫位
         LET l_xccw_p.xccw017 = l_indd.indd034 #撥入批號 
         
         LET l_xccw_p.xccw046 = l_indd.indd031 #撥入數量
         LET l_xccw_p.xccw201 = l_xccw_p.xccw045 * l_xccw_p.xccw046 #撥入異動庫存數量
            
         #161109-00085#24-s mod            
#         CALL axct312_ins_xccw(l_xccw_p.*)   #161109-00085#24-s mark
         CALL axct312_ins_xccw(l_xccw_p.xccwent,l_xccw_p.xccwsite,l_xccw_p.xccwcomp,l_xccw_p.xccwld,l_xccw_p.xccw001,
                               l_xccw_p.xccw002,l_xccw_p.xccw003,l_xccw_p.xccw004,l_xccw_p.xccw005,l_xccw_p.xccw006,
                               l_xccw_p.xccw007,l_xccw_p.xccw008,l_xccw_p.xccw009,l_xccw_p.xccw010,l_xccw_p.xccw011,
                               l_xccw_p.xccw012,l_xccw_p.xccw013,l_xccw_p.xccw014,l_xccw_p.xccw015,l_xccw_p.xccw016,
                               l_xccw_p.xccw017,l_xccw_p.xccw020,l_xccw_p.xccw021,l_xccw_p.xccw022,l_xccw_p.xccw023,
                               l_xccw_p.xccw024,l_xccw_p.xccw025,l_xccw_p.xccw026,l_xccw_p.xccw027,l_xccw_p.xccw028,
                               l_xccw_p.xccw029,l_xccw_p.xccw030,l_xccw_p.xccw031,l_xccw_p.xccw032,l_xccw_p.xccw033,
                               l_xccw_p.xccw034,l_xccw_p.xccw040,l_xccw_p.xccw041,l_xccw_p.xccw042,l_xccw_p.xccw043,
                               l_xccw_p.xccw044,l_xccw_p.xccw045,l_xccw_p.xccw046,l_xccw_p.xccw047,l_xccw_p.xccw048,
                               l_xccw_p.xccw049,l_xccw_p.xccw050,l_xccw_p.xccw051,l_xccw_p.xccw201,l_xccw_p.xccw202,
                               l_xccw_p.xccw202a,l_xccw_p.xccw202b,l_xccw_p.xccw202c,l_xccw_p.xccw202d,l_xccw_p.xccw202e,
                               l_xccw_p.xccw202f,l_xccw_p.xccw202g,l_xccw_p.xccw202h,l_xccw_p.xccw282,l_xccw_p.xccw282a,
                               l_xccw_p.xccw282b,l_xccw_p.xccw282c,l_xccw_p.xccw282d,l_xccw_p.xccw282e,l_xccw_p.xccw282f,
                               l_xccw_p.xccw282g,l_xccw_p.xccw282h,l_xccw_p.xccwud001,l_xccw_p.xccwud002,l_xccw_p.xccwud003,
                               l_xccw_p.xccwud004,l_xccw_p.xccwud005,l_xccw_p.xccwud006,l_xccw_p.xccwud007,l_xccw_p.xccwud008,
                               l_xccw_p.xccwud009,l_xccw_p.xccwud010,l_xccw_p.xccwud011,l_xccw_p.xccwud012,l_xccw_p.xccwud013,
                               l_xccw_p.xccwud014,l_xccw_p.xccwud015,l_xccw_p.xccwud016,l_xccw_p.xccwud017,l_xccw_p.xccwud018,
                               l_xccw_p.xccwud019,l_xccw_p.xccwud020,l_xccw_p.xccwud021,l_xccw_p.xccwud022,l_xccw_p.xccwud023,
                               l_xccw_p.xccwud024,l_xccw_p.xccwud025,l_xccw_p.xccwud026,l_xccw_p.xccwud027,l_xccw_p.xccwud028,
                               l_xccw_p.xccwud029,l_xccw_p.xccwud030)
         #161109-00085#24-e mod
      END IF
      
      IF g_glaa015 = 'Y' THEN 
         LET l_xccw.xccw001 = '2'
         LET l_xccw.xccw040 = g_glaa001
         LET l_xccw.xccw041 = g_glaa016
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,l_pdate_s,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   l_xccw.xccw041,0,g_glaa018)
         RETURNING l_xccw.xccw042
         
         #161109-00085#24-s mod
#         CALL axct312_ins_xccw(l_xccw.*)   #161109-00085#24-s mark
         CALL axct312_ins_xccw(l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                               l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                               l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                               l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                               l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                               l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                               l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                               l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                               l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                               l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                               l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                               l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                               l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                               l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                               l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                               l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                               l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                               l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                               l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                               l_xccw.xccwud029,l_xccw.xccwud030)
         #161109-00085#24-e mod
            
         #當撥入確認或者正常結案時產生一筆進貨成本異動（營運據點=撥入組織）
         IF l_indc.indcstus='P' OR l_indc.indcstus='C' THEN 
            LET l_xccw_p.xccw001 = '2'
            LET l_xccw_p.xccw040 = g_glaa001
            LET l_xccw_p.xccw041 = g_glaa016
                                     #匯率參照表;帳套;       日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,l_pdate_s,g_glaa001,
                                      #目的幣別;      交易金額; 匯類類型
                                      l_xccw_p.xccw041,0,g_glaa018)
            RETURNING l_xccw_p.xccw042
            
            #161109-00085#24-s mod            
#            CALL axct312_ins_xccw(l_xccw_p.*)   #161109-00085#24-s mark
            CALL axct312_ins_xccw(l_xccw_p.xccwent,l_xccw_p.xccwsite,l_xccw_p.xccwcomp,l_xccw_p.xccwld,l_xccw_p.xccw001,
                                  l_xccw_p.xccw002,l_xccw_p.xccw003,l_xccw_p.xccw004,l_xccw_p.xccw005,l_xccw_p.xccw006,
                                  l_xccw_p.xccw007,l_xccw_p.xccw008,l_xccw_p.xccw009,l_xccw_p.xccw010,l_xccw_p.xccw011,
                                  l_xccw_p.xccw012,l_xccw_p.xccw013,l_xccw_p.xccw014,l_xccw_p.xccw015,l_xccw_p.xccw016,
                                  l_xccw_p.xccw017,l_xccw_p.xccw020,l_xccw_p.xccw021,l_xccw_p.xccw022,l_xccw_p.xccw023,
                                  l_xccw_p.xccw024,l_xccw_p.xccw025,l_xccw_p.xccw026,l_xccw_p.xccw027,l_xccw_p.xccw028,
                                  l_xccw_p.xccw029,l_xccw_p.xccw030,l_xccw_p.xccw031,l_xccw_p.xccw032,l_xccw_p.xccw033,
                                  l_xccw_p.xccw034,l_xccw_p.xccw040,l_xccw_p.xccw041,l_xccw_p.xccw042,l_xccw_p.xccw043,
                                  l_xccw_p.xccw044,l_xccw_p.xccw045,l_xccw_p.xccw046,l_xccw_p.xccw047,l_xccw_p.xccw048,
                                  l_xccw_p.xccw049,l_xccw_p.xccw050,l_xccw_p.xccw051,l_xccw_p.xccw201,l_xccw_p.xccw202,
                                  l_xccw_p.xccw202a,l_xccw_p.xccw202b,l_xccw_p.xccw202c,l_xccw_p.xccw202d,l_xccw_p.xccw202e,
                                  l_xccw_p.xccw202f,l_xccw_p.xccw202g,l_xccw_p.xccw202h,l_xccw_p.xccw282,l_xccw_p.xccw282a,
                                  l_xccw_p.xccw282b,l_xccw_p.xccw282c,l_xccw_p.xccw282d,l_xccw_p.xccw282e,l_xccw_p.xccw282f,
                                  l_xccw_p.xccw282g,l_xccw_p.xccw282h,l_xccw_p.xccwud001,l_xccw_p.xccwud002,l_xccw_p.xccwud003,
                                  l_xccw_p.xccwud004,l_xccw_p.xccwud005,l_xccw_p.xccwud006,l_xccw_p.xccwud007,l_xccw_p.xccwud008,
                                  l_xccw_p.xccwud009,l_xccw_p.xccwud010,l_xccw_p.xccwud011,l_xccw_p.xccwud012,l_xccw_p.xccwud013,
                                  l_xccw_p.xccwud014,l_xccw_p.xccwud015,l_xccw_p.xccwud016,l_xccw_p.xccwud017,l_xccw_p.xccwud018,
                                  l_xccw_p.xccwud019,l_xccw_p.xccwud020,l_xccw_p.xccwud021,l_xccw_p.xccwud022,l_xccw_p.xccwud023,
                                  l_xccw_p.xccwud024,l_xccw_p.xccwud025,l_xccw_p.xccwud026,l_xccw_p.xccwud027,l_xccw_p.xccwud028,
                                  l_xccw_p.xccwud029,l_xccw_p.xccwud030)
            #161109-00085#24-e mod
         END IF
      END IF
         
      IF g_glaa019 = 'Y' THEN 
         LET l_xccw.xccw001 = '3'
         LET l_xccw.xccw040 = g_glaa001
         LET l_xccw.xccw041 = g_glaa020
                                  #匯率參照表;帳套;       日期;    來源幣別
         CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,l_pdate_s,g_glaa001,
                                   #目的幣別;      交易金額; 匯類類型
                                   l_xccw.xccw041,0,g_glaa018)
         RETURNING l_xccw.xccw042
         
         #161109-00085#24-s mod
#         CALL axct312_ins_xccw(l_xccw.*)   #161109-00085#24-s mark
         CALL axct312_ins_xccw(l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                               l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                               l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                               l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                               l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                               l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                               l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                               l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                               l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                               l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                               l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                               l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                               l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                               l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                               l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                               l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                               l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                               l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                               l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                               l_xccw.xccwud029,l_xccw.xccwud030)
         #161109-00085#24-e mod
         #當撥入確認或者正常結案時產生一筆進貨成本異動（營運據點=撥入組織）
         IF l_indc.indcstus='P' OR l_indc.indcstus='C' THEN 
            LET l_xccw_p.xccw001 = '3'
            LET l_xccw_p.xccw040 = g_glaa001
            LET l_xccw_p.xccw041 = g_glaa020
                                     #匯率參照表;帳套;       日期;    來源幣別
            CALL s_aooi160_get_exrate('2',g_xccw_m.xccwld,l_pdate_s,g_glaa001,
                                      #目的幣別;      交易金額; 匯類類型
                                      l_xccw_p.xccw041,0,g_glaa018)
            RETURNING l_xccw_p.xccw042
            
            #161109-00085#24-s mod            
#            CALL axct312_ins_xccw(l_xccw_p.*)   #161109-00085#24-s mark
            CALL axct312_ins_xccw(l_xccw_p.xccwent,l_xccw_p.xccwsite,l_xccw_p.xccwcomp,l_xccw_p.xccwld,l_xccw_p.xccw001,
                                  l_xccw_p.xccw002,l_xccw_p.xccw003,l_xccw_p.xccw004,l_xccw_p.xccw005,l_xccw_p.xccw006,
                                  l_xccw_p.xccw007,l_xccw_p.xccw008,l_xccw_p.xccw009,l_xccw_p.xccw010,l_xccw_p.xccw011,
                                  l_xccw_p.xccw012,l_xccw_p.xccw013,l_xccw_p.xccw014,l_xccw_p.xccw015,l_xccw_p.xccw016,
                                  l_xccw_p.xccw017,l_xccw_p.xccw020,l_xccw_p.xccw021,l_xccw_p.xccw022,l_xccw_p.xccw023,
                                  l_xccw_p.xccw024,l_xccw_p.xccw025,l_xccw_p.xccw026,l_xccw_p.xccw027,l_xccw_p.xccw028,
                                  l_xccw_p.xccw029,l_xccw_p.xccw030,l_xccw_p.xccw031,l_xccw_p.xccw032,l_xccw_p.xccw033,
                                  l_xccw_p.xccw034,l_xccw_p.xccw040,l_xccw_p.xccw041,l_xccw_p.xccw042,l_xccw_p.xccw043,
                                  l_xccw_p.xccw044,l_xccw_p.xccw045,l_xccw_p.xccw046,l_xccw_p.xccw047,l_xccw_p.xccw048,
                                  l_xccw_p.xccw049,l_xccw_p.xccw050,l_xccw_p.xccw051,l_xccw_p.xccw201,l_xccw_p.xccw202,
                                  l_xccw_p.xccw202a,l_xccw_p.xccw202b,l_xccw_p.xccw202c,l_xccw_p.xccw202d,l_xccw_p.xccw202e,
                                  l_xccw_p.xccw202f,l_xccw_p.xccw202g,l_xccw_p.xccw202h,l_xccw_p.xccw282,l_xccw_p.xccw282a,
                                  l_xccw_p.xccw282b,l_xccw_p.xccw282c,l_xccw_p.xccw282d,l_xccw_p.xccw282e,l_xccw_p.xccw282f,
                                  l_xccw_p.xccw282g,l_xccw_p.xccw282h,l_xccw_p.xccwud001,l_xccw_p.xccwud002,l_xccw_p.xccwud003,
                                  l_xccw_p.xccwud004,l_xccw_p.xccwud005,l_xccw_p.xccwud006,l_xccw_p.xccwud007,l_xccw_p.xccwud008,
                                  l_xccw_p.xccwud009,l_xccw_p.xccwud010,l_xccw_p.xccwud011,l_xccw_p.xccwud012,l_xccw_p.xccwud013,
                                  l_xccw_p.xccwud014,l_xccw_p.xccwud015,l_xccw_p.xccwud016,l_xccw_p.xccwud017,l_xccw_p.xccwud018,
                                  l_xccw_p.xccwud019,l_xccw_p.xccwud020,l_xccw_p.xccwud021,l_xccw_p.xccwud022,l_xccw_p.xccwud023,
                                  l_xccw_p.xccwud024,l_xccw_p.xccwud025,l_xccw_p.xccwud026,l_xccw_p.xccwud027,l_xccw_p.xccwud028,
                                  l_xccw_p.xccwud029,l_xccw_p.xccwud030)
            #161109-00085#24-e mod
         END IF
      END IF
      
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 检查参考单号
# Memo...........:
# Usage..........: CALL axct312_xccw006_chk_5(p_xccw006)
#                  RETURNING r_errno
# Input parameter: p_xccw006      參考單號
# Return code....: r_errno        錯誤編號
# Date & Author..: 2014/04/29 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axct312_xccw006_chk_5(p_xccw006)
   DEFINE p_xccw006        LIKE xccw_t.xccw006
   DEFINE l_indcstus       LIKE indc_t.indcstus
   DEFINE r_errno          STRING
   
   LET r_errno=''
   SELECT indcstus INTO l_indcstus FROM indc_t
    WHERE indcent=g_enterprise AND indcdocno=p_xccw006
      AND indcsite=g_xccw_m.xccwcomp
   CASE
      WHEN SQLCA.SQLCODE = 100   LET r_errno ='ain-00075'
      WHEN l_indcstus = 'N'      LET r_errno ='axc-00285'
      WHEN l_indcstus = 'X'      LET r_errno ='axc-00286'
   END CASE
   RETURN r_errno
END FUNCTION

################################################################################
# Descriptions...: 插入xccw_t表中
# Memo...........:
# Usage..........: CALL axct312_ins_xccw(p_xccw)
# Input parameter: p_xccw   本期料件明細進出成本檔
# Date & Author..: 2014/04/28 By wangrr
# Modify.........:
################################################################################
PRIVATE FUNCTION axct312_ins_xccw(p_xccw)
   #161109-00085#24-s mod
#   DEFINE p_xccw       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
   DEFINE p_xccw       RECORD  #本期料件明細進出補成本檔
          xccwent LIKE xccw_t.xccwent, #企業編號
          xccwsite LIKE xccw_t.xccwsite, #site組織
          xccwcomp LIKE xccw_t.xccwcomp, #法人組織
          xccwld LIKE xccw_t.xccwld, #帳套
          xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
          xccw002 LIKE xccw_t.xccw002, #成本域
          xccw003 LIKE xccw_t.xccw003, #成本計算類型
          xccw004 LIKE xccw_t.xccw004, #年度
          xccw005 LIKE xccw_t.xccw005, #期別
          xccw006 LIKE xccw_t.xccw006, #參考單號
          xccw007 LIKE xccw_t.xccw007, #項次
          xccw008 LIKE xccw_t.xccw008, #項序
          xccw009 LIKE xccw_t.xccw009, #出入庫碼
          xccw010 LIKE xccw_t.xccw010, #料號
          xccw011 LIKE xccw_t.xccw011, #特性
          xccw012 LIKE xccw_t.xccw012, #單據類型
          xccw013 LIKE xccw_t.xccw013, #單據日期
          xccw014 LIKE xccw_t.xccw014, #時間
          xccw015 LIKE xccw_t.xccw015, #倉庫編號
          xccw016 LIKE xccw_t.xccw016, #儲位編號
          xccw017 LIKE xccw_t.xccw017, #批號
          xccw020 LIKE xccw_t.xccw020, #異動類型
          xccw021 LIKE xccw_t.xccw021, #原因碼
          xccw022 LIKE xccw_t.xccw022, #交易對象
          xccw023 LIKE xccw_t.xccw023, #客群
          xccw024 LIKE xccw_t.xccw024, #區域
          xccw025 LIKE xccw_t.xccw025, #成本中心
          xccw026 LIKE xccw_t.xccw026, #經營類別
          xccw027 LIKE xccw_t.xccw027, #通路
          xccw028 LIKE xccw_t.xccw028, #品類
          xccw029 LIKE xccw_t.xccw029, #品牌
          xccw030 LIKE xccw_t.xccw030, #專案號
          xccw031 LIKE xccw_t.xccw031, #WBS
          xccw032 LIKE xccw_t.xccw032, #存貨科目
          xccw033 LIKE xccw_t.xccw033, #費用成本科目
          xccw034 LIKE xccw_t.xccw034, #收入科目
          xccw040 LIKE xccw_t.xccw040, #交易幣別
          xccw041 LIKE xccw_t.xccw041, #本位幣別
          xccw042 LIKE xccw_t.xccw042, #匯率
          xccw043 LIKE xccw_t.xccw043, #交易單位
          xccw044 LIKE xccw_t.xccw044, #成本單位
          xccw045 LIKE xccw_t.xccw045, #換算率
          xccw046 LIKE xccw_t.xccw046, #交易數量
          xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
          xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
          xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
          xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
          xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
          xccw201 LIKE xccw_t.xccw201, #本期異動數量
          xccw202 LIKE xccw_t.xccw202, #本期異動金額
          xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
          xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
          xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
          xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
          xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
          xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
          xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
          xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
          xccw282 LIKE xccw_t.xccw282, #本期異動單價
          xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
          xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
          xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
          xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
          xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
          xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
          xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
          xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
          xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
          xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
          xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
          xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
          xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
          xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
          xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
          xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
          xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
          xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
          xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
          xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
          xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
          xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
          xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
          xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
          xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
          xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
          xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
          xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
          xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
          xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
          xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
          xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
          xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
          xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
          xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
          xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
          xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
          xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                    END RECORD
   #161109-00085#24-e mod
   #161109-00085#24-s mod
#   DEFINE l_xccw       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
   DEFINE l_xccw       RECORD  #本期料件明細進出補成本檔
          xccwent LIKE xccw_t.xccwent, #企業編號
          xccwsite LIKE xccw_t.xccwsite, #site組織
          xccwcomp LIKE xccw_t.xccwcomp, #法人組織
          xccwld LIKE xccw_t.xccwld, #帳套
          xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
          xccw002 LIKE xccw_t.xccw002, #成本域
          xccw003 LIKE xccw_t.xccw003, #成本計算類型
          xccw004 LIKE xccw_t.xccw004, #年度
          xccw005 LIKE xccw_t.xccw005, #期別
          xccw006 LIKE xccw_t.xccw006, #參考單號
          xccw007 LIKE xccw_t.xccw007, #項次
          xccw008 LIKE xccw_t.xccw008, #項序
          xccw009 LIKE xccw_t.xccw009, #出入庫碼
          xccw010 LIKE xccw_t.xccw010, #料號
          xccw011 LIKE xccw_t.xccw011, #特性
          xccw012 LIKE xccw_t.xccw012, #單據類型
          xccw013 LIKE xccw_t.xccw013, #單據日期
          xccw014 LIKE xccw_t.xccw014, #時間
          xccw015 LIKE xccw_t.xccw015, #倉庫編號
          xccw016 LIKE xccw_t.xccw016, #儲位編號
          xccw017 LIKE xccw_t.xccw017, #批號
          xccw020 LIKE xccw_t.xccw020, #異動類型
          xccw021 LIKE xccw_t.xccw021, #原因碼
          xccw022 LIKE xccw_t.xccw022, #交易對象
          xccw023 LIKE xccw_t.xccw023, #客群
          xccw024 LIKE xccw_t.xccw024, #區域
          xccw025 LIKE xccw_t.xccw025, #成本中心
          xccw026 LIKE xccw_t.xccw026, #經營類別
          xccw027 LIKE xccw_t.xccw027, #通路
          xccw028 LIKE xccw_t.xccw028, #品類
          xccw029 LIKE xccw_t.xccw029, #品牌
          xccw030 LIKE xccw_t.xccw030, #專案號
          xccw031 LIKE xccw_t.xccw031, #WBS
          xccw032 LIKE xccw_t.xccw032, #存貨科目
          xccw033 LIKE xccw_t.xccw033, #費用成本科目
          xccw034 LIKE xccw_t.xccw034, #收入科目
          xccw040 LIKE xccw_t.xccw040, #交易幣別
          xccw041 LIKE xccw_t.xccw041, #本位幣別
          xccw042 LIKE xccw_t.xccw042, #匯率
          xccw043 LIKE xccw_t.xccw043, #交易單位
          xccw044 LIKE xccw_t.xccw044, #成本單位
          xccw045 LIKE xccw_t.xccw045, #換算率
          xccw046 LIKE xccw_t.xccw046, #交易數量
          xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
          xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
          xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
          xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
          xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
          xccw201 LIKE xccw_t.xccw201, #本期異動數量
          xccw202 LIKE xccw_t.xccw202, #本期異動金額
          xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
          xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
          xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
          xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
          xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
          xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
          xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
          xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
          xccw282 LIKE xccw_t.xccw282, #本期異動單價
          xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
          xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
          xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
          xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
          xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
          xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
          xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
          xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
          xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
          xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
          xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
          xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
          xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
          xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
          xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
          xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
          xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
          xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
          xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
          xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
          xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
          xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
          xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
          xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
          xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
          xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
          xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
          xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
          xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
          xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
          xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
          xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
          xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
          xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
          xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
          xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
          xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
          xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                    END RECORD
   #161109-00085#24-e mod
   DEFINE l_n             LIKE type_t.num5
   
   LET l_xccw.* = p_xccw.*
   LET l_n = 0
   SELECT COUNT(*) INTO l_n
     FROM xccw_t
    WHERE xccwent = l_xccw.xccwent
      AND xccwld  = l_xccw.xccwld
      AND xccw001 = l_xccw.xccw001
      AND xccw002 = l_xccw.xccw002
      AND xccw003 = l_xccw.xccw003
      AND xccw004 = l_xccw.xccw004
      AND xccw005 = l_xccw.xccw005
      AND xccw006 = l_xccw.xccw006
      AND xccw007 = l_xccw.xccw007
      AND xccw008 = l_xccw.xccw008
      AND xccw009 = l_xccw.xccw009
      
   IF l_n = 0 THEN
      INSERT INTO xccw_t(xccwent,xccwsite,xccwld,xccwcomp,
                         xccw001,xccw002,xccw003,xccw004,xccw005,
                         xccw010,xccw011,xccw006,xccw007,xccw008,xccw012,
                         xccw013,xccw015,xccw016,xccw017,
                         xccw043,xccw044,xccw045,xccw046,xccw020,         
                         xccw021,xccw022,xccw023,xccw024,xccw025,
                         xccw026,xccw027,xccw028,xccw029,xccw030,
                         xccw031,xccw032,xccw033,xccw040,xccw041,
                         xccw042,xccw009,xccw201,
                         xccw202,xccw202a,xccw202b,xccw202c,xccw202d,
                         xccw202e,xccw202f,xccw202g,xccw202h,
                         xccw282,xccw282a,xccw282b,xccw282c,xccw282d,
                         xccw282e,xccw282f,xccw282g,xccw282h
                         )        
                  VALUES(l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwld,l_xccw.xccwcomp,
                         l_xccw.xccw001,l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,
                         l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw006,l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw012,
                         l_xccw.xccw013,l_xccw.xccw015,l_xccw.xccw016,l_xccw.xccw017,
                         l_xccw.xccw043,l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw020,
                         l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,l_xccw.xccw024,l_xccw.xccw025,
                         l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,l_xccw.xccw029,l_xccw.xccw030,
                         l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,l_xccw.xccw040,l_xccw.xccw041,
                         l_xccw.xccw042,l_xccw.xccw009,l_xccw.xccw201,
                         l_xccw.xccw202, l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,
                         l_xccw.xccw202e,l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,
                         l_xccw.xccw282, l_xccw.xccw282a,l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,
                         l_xccw.xccw282e,l_xccw.xccw282f,l_xccw.xccw282g,l_xccw.xccw282h
                         )
      
      IF SQLCA.SQLcode  THEN
         CALL cl_errmsg('','insert','',SQLCA.sqlcode,1) 
         LET g_success = 'N'                        
      END IF
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
PRIVATE FUNCTION axct312_generate_xcdw()
#161109-00085#24-s mod
#DEFINE l_xcdw          RECORD LIKE xcdw_t.*   #161109-00085#24-s mark
DEFINE l_xcdw          RECORD  #本期料件明細進出成本要素補成本檔
       xcdwent LIKE xcdw_t.xcdwent, #企業編號
       xcdwsite LIKE xcdw_t.xcdwsite, #site組織
       xcdwcomp LIKE xcdw_t.xcdwcomp, #法人組織
       xcdwld LIKE xcdw_t.xcdwld, #帳套編號
       xcdw001 LIKE xcdw_t.xcdw001, #帳套本位幣順序
       xcdw002 LIKE xcdw_t.xcdw002, #成本域
       xcdw003 LIKE xcdw_t.xcdw003, #成本計算類型
       xcdw004 LIKE xcdw_t.xcdw004, #年度
       xcdw005 LIKE xcdw_t.xcdw005, #期別
       xcdw006 LIKE xcdw_t.xcdw006, #參考單號
       xcdw007 LIKE xcdw_t.xcdw007, #項次
       xcdw008 LIKE xcdw_t.xcdw008, #項序
       xcdw009 LIKE xcdw_t.xcdw009, #出入庫碼
       xcdw010 LIKE xcdw_t.xcdw010, #成本要素
       xcdw011 LIKE xcdw_t.xcdw011, #料號
       xcdw012 LIKE xcdw_t.xcdw012, #特性
       xcdw013 LIKE xcdw_t.xcdw013, #單據類型
       xcdw014 LIKE xcdw_t.xcdw014, #單據日期
       xcdw015 LIKE xcdw_t.xcdw015, #時間
       xcdw016 LIKE xcdw_t.xcdw016, #倉庫編號
       xcdw017 LIKE xcdw_t.xcdw017, #儲位編號
       xcdw018 LIKE xcdw_t.xcdw018, #批號
       xcdw020 LIKE xcdw_t.xcdw020, #異動類型
       xcdw021 LIKE xcdw_t.xcdw021, #原因碼
       xcdw022 LIKE xcdw_t.xcdw022, #交易對象
       xcdw023 LIKE xcdw_t.xcdw023, #客群
       xcdw024 LIKE xcdw_t.xcdw024, #區域
       xcdw025 LIKE xcdw_t.xcdw025, #成本中心
       xcdw026 LIKE xcdw_t.xcdw026, #經營類別
       xcdw027 LIKE xcdw_t.xcdw027, #通路
       xcdw028 LIKE xcdw_t.xcdw028, #品類
       xcdw029 LIKE xcdw_t.xcdw029, #品牌
       xcdw030 LIKE xcdw_t.xcdw030, #專案編號
       xcdw031 LIKE xcdw_t.xcdw031, #WBS
       xcdw032 LIKE xcdw_t.xcdw032, #存貨科目
       xcdw033 LIKE xcdw_t.xcdw033, #費用成本科目
       xcdw034 LIKE xcdw_t.xcdw034, #收入科目
       xcdw047 LIKE xcdw_t.xcdw047, #工單號碼
       xcdw048 LIKE xcdw_t.xcdw048, #重複性生產-計畫編號
       xcdw049 LIKE xcdw_t.xcdw049, #重複性生產-生產料號
       xcdw050 LIKE xcdw_t.xcdw050, #重複性生產-生產料號BOM特性
       xcdw051 LIKE xcdw_t.xcdw051, #重複性生產-生產料號產品特徵
       xcdw201 LIKE xcdw_t.xcdw201, #本期異動數量
       xcdw202 LIKE xcdw_t.xcdw202, #本期異動金額
       xcdwstus LIKE xcdw_t.xcdwstus  #狀態碼
                END RECORD
#161109-00085#24-e mod
#161109-00085#24-s mod
#DEFINE l_xccw       RECORD  LIKE xccw_t.*   #161109-00085#24-s mark
DEFINE l_xccw       RECORD  #本期料件明細進出補成本檔
       xccwent LIKE xccw_t.xccwent, #企業編號
       xccwsite LIKE xccw_t.xccwsite, #site組織
       xccwcomp LIKE xccw_t.xccwcomp, #法人組織
       xccwld LIKE xccw_t.xccwld, #帳套
       xccw001 LIKE xccw_t.xccw001, #帳套本位幣順序
       xccw002 LIKE xccw_t.xccw002, #成本域
       xccw003 LIKE xccw_t.xccw003, #成本計算類型
       xccw004 LIKE xccw_t.xccw004, #年度
       xccw005 LIKE xccw_t.xccw005, #期別
       xccw006 LIKE xccw_t.xccw006, #參考單號
       xccw007 LIKE xccw_t.xccw007, #項次
       xccw008 LIKE xccw_t.xccw008, #項序
       xccw009 LIKE xccw_t.xccw009, #出入庫碼
       xccw010 LIKE xccw_t.xccw010, #料號
       xccw011 LIKE xccw_t.xccw011, #特性
       xccw012 LIKE xccw_t.xccw012, #單據類型
       xccw013 LIKE xccw_t.xccw013, #單據日期
       xccw014 LIKE xccw_t.xccw014, #時間
       xccw015 LIKE xccw_t.xccw015, #倉庫編號
       xccw016 LIKE xccw_t.xccw016, #儲位編號
       xccw017 LIKE xccw_t.xccw017, #批號
       xccw020 LIKE xccw_t.xccw020, #異動類型
       xccw021 LIKE xccw_t.xccw021, #原因碼
       xccw022 LIKE xccw_t.xccw022, #交易對象
       xccw023 LIKE xccw_t.xccw023, #客群
       xccw024 LIKE xccw_t.xccw024, #區域
       xccw025 LIKE xccw_t.xccw025, #成本中心
       xccw026 LIKE xccw_t.xccw026, #經營類別
       xccw027 LIKE xccw_t.xccw027, #通路
       xccw028 LIKE xccw_t.xccw028, #品類
       xccw029 LIKE xccw_t.xccw029, #品牌
       xccw030 LIKE xccw_t.xccw030, #專案號
       xccw031 LIKE xccw_t.xccw031, #WBS
       xccw032 LIKE xccw_t.xccw032, #存貨科目
       xccw033 LIKE xccw_t.xccw033, #費用成本科目
       xccw034 LIKE xccw_t.xccw034, #收入科目
       xccw040 LIKE xccw_t.xccw040, #交易幣別
       xccw041 LIKE xccw_t.xccw041, #本位幣別
       xccw042 LIKE xccw_t.xccw042, #匯率
       xccw043 LIKE xccw_t.xccw043, #交易單位
       xccw044 LIKE xccw_t.xccw044, #成本單位
       xccw045 LIKE xccw_t.xccw045, #換算率
       xccw046 LIKE xccw_t.xccw046, #交易數量
       xccw047 LIKE xccw_t.xccw047, #在製單號(工單號/重複性編號)
       xccw048 LIKE xccw_t.xccw048, #重複性生產-計畫編號
       xccw049 LIKE xccw_t.xccw049, #重複性生產-生產料號
       xccw050 LIKE xccw_t.xccw050, #重複性生產-生產料號BOM特性
       xccw051 LIKE xccw_t.xccw051, #重複性生產-生產料號產品特徵
       xccw201 LIKE xccw_t.xccw201, #本期異動數量
       xccw202 LIKE xccw_t.xccw202, #本期異動金額
       xccw202a LIKE xccw_t.xccw202a, #本期異動金額-材料
       xccw202b LIKE xccw_t.xccw202b, #本期異動金額-人工
       xccw202c LIKE xccw_t.xccw202c, #本期異動金額-加工費
       xccw202d LIKE xccw_t.xccw202d, #本期異動金額-制費一
       xccw202e LIKE xccw_t.xccw202e, #本期異動金額-制費二
       xccw202f LIKE xccw_t.xccw202f, #本期異動金額-制費三
       xccw202g LIKE xccw_t.xccw202g, #本期異動金額-制費四
       xccw202h LIKE xccw_t.xccw202h, #本期異動金額-制費五
       xccw282 LIKE xccw_t.xccw282, #本期異動單價
       xccw282a LIKE xccw_t.xccw282a, #本期異動單價-材料
       xccw282b LIKE xccw_t.xccw282b, #本期異動單價-人工
       xccw282c LIKE xccw_t.xccw282c, #本期異動單價-加工
       xccw282d LIKE xccw_t.xccw282d, #本期異動單價-制費一
       xccw282e LIKE xccw_t.xccw282e, #本期異動單價-制費二
       xccw282f LIKE xccw_t.xccw282f, #本期異動單價-制費三
       xccw282g LIKE xccw_t.xccw282g, #本期異動單價-制費四
       xccw282h LIKE xccw_t.xccw282h, #本期異動單價-制費五
       xccwud001 LIKE xccw_t.xccwud001, #自定義欄位(文字)001
       xccwud002 LIKE xccw_t.xccwud002, #自定義欄位(文字)002
       xccwud003 LIKE xccw_t.xccwud003, #自定義欄位(文字)003
       xccwud004 LIKE xccw_t.xccwud004, #自定義欄位(文字)004
       xccwud005 LIKE xccw_t.xccwud005, #自定義欄位(文字)005
       xccwud006 LIKE xccw_t.xccwud006, #自定義欄位(文字)006
       xccwud007 LIKE xccw_t.xccwud007, #自定義欄位(文字)007
       xccwud008 LIKE xccw_t.xccwud008, #自定義欄位(文字)008
       xccwud009 LIKE xccw_t.xccwud009, #自定義欄位(文字)009
       xccwud010 LIKE xccw_t.xccwud010, #自定義欄位(文字)010
       xccwud011 LIKE xccw_t.xccwud011, #自定義欄位(數字)011
       xccwud012 LIKE xccw_t.xccwud012, #自定義欄位(數字)012
       xccwud013 LIKE xccw_t.xccwud013, #自定義欄位(數字)013
       xccwud014 LIKE xccw_t.xccwud014, #自定義欄位(數字)014
       xccwud015 LIKE xccw_t.xccwud015, #自定義欄位(數字)015
       xccwud016 LIKE xccw_t.xccwud016, #自定義欄位(數字)016
       xccwud017 LIKE xccw_t.xccwud017, #自定義欄位(數字)017
       xccwud018 LIKE xccw_t.xccwud018, #自定義欄位(數字)018
       xccwud019 LIKE xccw_t.xccwud019, #自定義欄位(數字)019
       xccwud020 LIKE xccw_t.xccwud020, #自定義欄位(數字)020
       xccwud021 LIKE xccw_t.xccwud021, #自定義欄位(日期時間)021
       xccwud022 LIKE xccw_t.xccwud022, #自定義欄位(日期時間)022
       xccwud023 LIKE xccw_t.xccwud023, #自定義欄位(日期時間)023
       xccwud024 LIKE xccw_t.xccwud024, #自定義欄位(日期時間)024
       xccwud025 LIKE xccw_t.xccwud025, #自定義欄位(日期時間)025
       xccwud026 LIKE xccw_t.xccwud026, #自定義欄位(日期時間)026
       xccwud027 LIKE xccw_t.xccwud027, #自定義欄位(日期時間)027
       xccwud028 LIKE xccw_t.xccwud028, #自定義欄位(日期時間)028
       xccwud029 LIKE xccw_t.xccwud029, #自定義欄位(日期時間)029
       xccwud030 LIKE xccw_t.xccwud030  #自定義欄位(日期時間)030
                 END RECORD
#161109-00085#24-e mod
DEFINE l_sql           STRING
DEFINE l_success       LIKE type_t.chr1
DEFINE l_xcdw_count    LIKE type_t.num5
DEFINE l_xcdw_count1   LIKE type_t.num5
DEFINE la_param  RECORD
                 prog   STRING,
                 param  DYNAMIC ARRAY OF STRING
                 END RECORD
DEFINE ls_js     STRING
DEFINE l_cnt     LIKE type_t.num5      #成本次要素个数     #fengmy150312
DEFINE l_success1 LIKE type_t.num5

#fengmy150316--begin
IF NOT s_axct310_cre_tmp_table() THEN
   RETURN
END IF
#fengmy150316--end
CALL s_transaction_begin()
  LET l_success = 'Y'
#  #axct322已资料不能再抛过去
#  LET l_sql = "SELECT COUNT(*) FROM xcdw_t ",
#              " WHERE xcdwent = ? AND xcdwcomp = ? AND xcdwld = ?",
#              "   AND xcdw003 = ? AND xcdw004 = ? AND xcdw005 = ? ",
#              "   AND xcdw006 = ? AND xcdw013 = ? AND xcdw014 = ?"
##              AND xcdwstus <> 'N'"
#  DECLARE axct312_xcdw_count_cs CURSOR FROM l_sql 
#  OPEN axct312_xcdw_count_cs USING g_enterprise,g_xccw_m.xccwcomp,g_xccw_m.xccwld,
#                                   g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,
#                                   g_xccw_m.xccw006,g_xccw_m.xccw012,g_xccw_m.xccw013
#  FETCH axct312_xcdw_count_cs INTO l_xcdw_count
#  IF l_xcdw_count > 0 THEN
#     INITIALIZE g_errparam TO NULL
#     LET g_errparam.code = 'axc-00536'
#     LET g_errparam.extend = ''
#     LET g_errparam.popup = TRUE
#     CALL cl_err()
#     RETURN  
#  END IF 
  #删除axct322已有资料 
  LET l_sql = "SELECT COUNT(*) FROM xcdw_t ",
              " WHERE xcdwent = ? AND xcdwcomp = ? AND xcdwld = ?",
              "   AND xcdw003 = ? AND xcdw004 = ? AND xcdw005 = ? ",
              "   AND xcdw006 = ? AND xcdw013 = ? AND xcdw014 = ? "
              #AND xcdwstus = 'N'" 
  DECLARE axct312_xcdw_count_cs1 CURSOR FROM l_sql 
  OPEN axct312_xcdw_count_cs1 USING g_enterprise,g_xccw_m.xccwcomp,g_xccw_m.xccwld,
                                   g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,
                                   g_xccw_m.xccw006,g_xccw_m.xccw012,g_xccw_m.xccw013
  FETCH axct312_xcdw_count_cs1 INTO l_xcdw_count1
  IF l_xcdw_count1 > 0 THEN
     IF cl_ask_confirm('axc-00388') THEN   
        LET l_sql = "DELETE FROM xcdw_t ",
                    " WHERE xcdwent = '",g_enterprise,"'  AND xcdwcomp = '",g_xccw_m.xccwcomp,"'",
                    "   AND xcdwld = '",g_xccw_m.xccwld,"' AND xcdw003 = '",g_xccw_m.xccw003,"'",
                    "   AND xcdw004 = '",g_xccw_m.xccw004,"' AND xcdw005 = '",g_xccw_m.xccw005,"'",
                    "   AND xcdw006 = '",g_xccw_m.xccw006,"' AND xcdw013 = '",g_xccw_m.xccw012,"'",
                    "   AND xcdw014 = '",g_xccw_m.xccw013,"'"
                     
        PREPARE axct312_del_xcdw FROM l_sql
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "PREPARE delete xcdw_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF
        EXECUTE axct312_del_xcdw 
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code   = SQLCA.sqlcode
           LET g_errparam.extend = "EXECUTE delete xcdw_t"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN 
        END IF 
     ELSE 
        RETURN         
     END IF  
  END IF
    
  
  #生成axct322资料 
  #161109-00085#24-s mod
#  LET l_sql = "SELECT * ",   #161109-00085#24-s mark
  LET l_sql = "SELECT xccwent,xccwsite,xccwcomp,xccwld,xccw001,xccw002,xccw003,xccw004,xccw005,xccw006,
                      xccw007,xccw008,xccw009,xccw010,xccw011,xccw012,xccw013,xccw014,xccw015,xccw016,
                      xccw017,xccw020,xccw021,xccw022,xccw023,xccw024,xccw025,xccw026,xccw027,xccw028,
                      xccw029,xccw030,xccw031,xccw032,xccw033,xccw034,xccw040,xccw041,xccw042,xccw043,
                      xccw044,xccw045,xccw046,xccw047,xccw048,xccw049,xccw050,xccw051,xccw201,xccw202,
                      xccw202a,xccw202b,xccw202c,xccw202d,xccw202e,xccw202f,xccw202g,xccw202h,xccw282,xccw282a,
                      xccw282b,xccw282c,xccw282d,xccw282e,xccw282f,xccw282g,xccw282h,xccwud001,xccwud002,xccwud003,
                      xccwud004,xccwud005,xccwud006,xccwud007,xccwud008,xccwud009,xccwud010,xccwud011,xccwud012,xccwud013,
                      xccwud014,xccwud015,xccwud016,xccwud017,xccwud018,xccwud019,xccwud020,xccwud021,xccwud022,xccwud023,
                      xccwud024,xccwud025,xccwud026,xccwud027,xccwud028,xccwud029,xccwud030",
  #161109-00085#24-e mod
              "  FROM xccw_t WHERE xccwent = ? AND xccwcomp = ? AND xccwld = ?",
              "  AND xccw003 = ? AND xccw004 = ? AND xccw005 = ? ",
              "   AND xccw006 = ? AND xccw012 = ? AND xccw013 = ? ",
              "  ORDER BY xccw001"
  DECLARE axct312_xcdw_cs CURSOR FROM l_sql 
  
  FOREACH axct312_xcdw_cs USING g_enterprise,g_xccw_m.xccwcomp,g_xccw_m.xccwld,
                                g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,
                                g_xccw_m.xccw006,g_xccw_m.xccw012,g_xccw_m.xccw013 
                          #161109-00085#24-s mod
#                          INTO l_xccw.*   #161109-00085#24-s mark
                          INTO l_xccw.xccwent,l_xccw.xccwsite,l_xccw.xccwcomp,l_xccw.xccwld,l_xccw.xccw001,
                               l_xccw.xccw002,l_xccw.xccw003,l_xccw.xccw004,l_xccw.xccw005,l_xccw.xccw006,
                               l_xccw.xccw007,l_xccw.xccw008,l_xccw.xccw009,l_xccw.xccw010,l_xccw.xccw011,
                               l_xccw.xccw012,l_xccw.xccw013,l_xccw.xccw014,l_xccw.xccw015,l_xccw.xccw016,
                               l_xccw.xccw017,l_xccw.xccw020,l_xccw.xccw021,l_xccw.xccw022,l_xccw.xccw023,
                               l_xccw.xccw024,l_xccw.xccw025,l_xccw.xccw026,l_xccw.xccw027,l_xccw.xccw028,
                               l_xccw.xccw029,l_xccw.xccw030,l_xccw.xccw031,l_xccw.xccw032,l_xccw.xccw033,
                               l_xccw.xccw034,l_xccw.xccw040,l_xccw.xccw041,l_xccw.xccw042,l_xccw.xccw043,
                               l_xccw.xccw044,l_xccw.xccw045,l_xccw.xccw046,l_xccw.xccw047,l_xccw.xccw048,
                               l_xccw.xccw049,l_xccw.xccw050,l_xccw.xccw051,l_xccw.xccw201,l_xccw.xccw202,
                               l_xccw.xccw202a,l_xccw.xccw202b,l_xccw.xccw202c,l_xccw.xccw202d,l_xccw.xccw202e,
                               l_xccw.xccw202f,l_xccw.xccw202g,l_xccw.xccw202h,l_xccw.xccw282,l_xccw.xccw282a,
                               l_xccw.xccw282b,l_xccw.xccw282c,l_xccw.xccw282d,l_xccw.xccw282e,l_xccw.xccw282f,
                               l_xccw.xccw282g,l_xccw.xccw282h,l_xccw.xccwud001,l_xccw.xccwud002,l_xccw.xccwud003,
                               l_xccw.xccwud004,l_xccw.xccwud005,l_xccw.xccwud006,l_xccw.xccwud007,l_xccw.xccwud008,
                               l_xccw.xccwud009,l_xccw.xccwud010,l_xccw.xccwud011,l_xccw.xccwud012,l_xccw.xccwud013,
                               l_xccw.xccwud014,l_xccw.xccwud015,l_xccw.xccwud016,l_xccw.xccwud017,l_xccw.xccwud018,
                               l_xccw.xccwud019,l_xccw.xccwud020,l_xccw.xccwud021,l_xccw.xccwud022,l_xccw.xccwud023,
                               l_xccw.xccwud024,l_xccw.xccwud025,l_xccw.xccwud026,l_xccw.xccwud027,l_xccw.xccwud028,
                               l_xccw.xccwud029,l_xccw.xccwud030
                          #161109-00085#24-e mod
          CASE l_xcdw.xcdw001
             WHEN 2  IF g_glaa015 = 'N' THEN CONTINUE FOREACH END IF
             WHEN 3  IF g_glaa019 = 'N' THEN CONTINUE FOREACH END IF
             OTHERWISE
          END CASE                               
          LET l_xcdw.xcdwent = g_enterprise
          LET l_xcdw.xcdwsite= l_xccw.xccwsite
          LET l_xcdw.xcdwcomp = g_xccw_m.xccwcomp
          LET l_xcdw.xcdwld = g_xccw_m.xccwld
          LET l_xcdw.xcdw001 = l_xccw.xccw001
          LET l_xcdw.xcdw002 = l_xccw.xccw002
          LET l_xcdw.xcdw003 = g_xccw_m.xccw003
          LET l_xcdw.xcdw004 = g_xccw_m.xccw004
          LET l_xcdw.xcdw005 = g_xccw_m.xccw005
          LET l_xcdw.xcdw006 = l_xccw.xccw006
          LET l_xcdw.xcdw007 = l_xccw.xccw007
          LET l_xcdw.xcdw008 = l_xccw.xccw008
          LET l_xcdw.xcdw009 = l_xccw.xccw009
          LET l_xcdw.xcdw010 = ' '
          LET l_xcdw.xcdw011 = l_xccw.xccw010
          LET l_xcdw.xcdw012 = l_xccw.xccw011
          LET l_xcdw.xcdw013 = l_xccw.xccw012         
          LET l_xcdw.xcdw014 = l_xccw.xccw013
          LET l_xcdw.xcdw015 = l_xccw.xccw014
          LET l_xcdw.xcdw016 = l_xccw.xccw015
          LET l_xcdw.xcdw017 = l_xccw.xccw016
          LET l_xcdw.xcdw018 = l_xccw.xccw017
          LET l_xcdw.xcdw020 = l_xccw.xccw020
          LET l_xcdw.xcdw021 = l_xccw.xccw021
          LET l_xcdw.xcdw022 = l_xccw.xccw022
          LET l_xcdw.xcdw023 = l_xccw.xccw023
          LET l_xcdw.xcdw024 = l_xccw.xccw024
          LET l_xcdw.xcdw025 = l_xccw.xccw025
          LET l_xcdw.xcdw026 = l_xccw.xccw026
          LET l_xcdw.xcdw027 = l_xccw.xccw027
          LET l_xcdw.xcdw028 = l_xccw.xccw028
          LET l_xcdw.xcdw029 = l_xccw.xccw029
          LET l_xcdw.xcdw030 = l_xccw.xccw030
          LET l_xcdw.xcdw031 = l_xccw.xccw031
          LET l_xcdw.xcdw032 = l_xccw.xccw032
          LET l_xcdw.xcdw033 = l_xccw.xccw033
          LET l_xcdw.xcdw034 = l_xccw.xccw034
          #fengmy add 141219-----begin  table alter
          LET l_xcdw.xcdw047 = l_xccw.xccw047        #工單號碼
          LET l_xcdw.xcdw048 = l_xccw.xccw048        #重複性生產-計畫編號
          LET l_xcdw.xcdw049 = l_xccw.xccw049        #重複性生產-生產料號
          LET l_xcdw.xcdw050 = l_xccw.xccw050        #重複性生產-生產料號BOM特性
          LET l_xcdw.xcdw051 = l_xccw.xccw051        #重複性生產-生產料號產品特徵
         #fengmy add 141219-----end    table alter
          LET l_xcdw.xcdw201 = l_xccw.xccw201
          LET l_xcdw.xcdw202 = l_xccw.xccw202    
              
          LET l_xcdw.xcdwstus = 'Y'

#取次要素----fengmy150318--b
     CALL s_axct310_ins(g_xccw_m.xccwld,g_xccw_m.xccwcomp,l_xcdw.xcdw001,l_xcdw.xcdw002,g_xccw_m.xccw003,g_xccw_m.xccw004,g_xccw_m.xccw005,
                                        l_xcdw.xcdw011,l_xcdw.xcdw012,l_xcdw.xcdw018,l_xcdw.xcdw202)
          RETURNING l_success1,l_cnt
     IF l_success1 THEN
        LET l_sql =  " SELECT xcam004,amt FROM s_axct310_tmp2 "
        PREPARE s_axct310_tmp2_pb FROM l_sql
        DECLARE s_axct310_tmp2_cs CURSOR FOR s_axct310_tmp2_pb
        IF l_cnt = 1 THEN
           EXECUTE s_axct310_tmp2_pb INTO l_xcdw.xcdw010,l_xcdw.xcdw202
           #161109-00085#24-s mod
#           INSERT INTO xcdw_t VALUES(l_xcdw.*)   #161109-00085#24-s mark
           INSERT INTO xcdw_t(xcdwent,xcdwsite,xcdwcomp,xcdwld,xcdw001,xcdw002,xcdw003,xcdw004,
                              xcdw005,xcdw006,xcdw007,xcdw008,xcdw009,xcdw010,xcdw011,xcdw012,
                              xcdw013,xcdw014,xcdw015,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,
                              xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,
                              xcdw030,xcdw031,xcdw032,xcdw033,xcdw034,xcdw047,xcdw048,xcdw049,
                              xcdw050,xcdw051,xcdw201,xcdw202,xcdwstus)
                       VALUES(l_xcdw.xcdwent,l_xcdw.xcdwsite,l_xcdw.xcdwcomp,l_xcdw.xcdwld,l_xcdw.xcdw001,
                              l_xcdw.xcdw002,l_xcdw.xcdw003,l_xcdw.xcdw004,l_xcdw.xcdw005,l_xcdw.xcdw006,
                              l_xcdw.xcdw007,l_xcdw.xcdw008,l_xcdw.xcdw009,l_xcdw.xcdw010,l_xcdw.xcdw011,
                              l_xcdw.xcdw012,l_xcdw.xcdw013,l_xcdw.xcdw014,l_xcdw.xcdw015,l_xcdw.xcdw016,
                              l_xcdw.xcdw017,l_xcdw.xcdw018,l_xcdw.xcdw020,l_xcdw.xcdw021,l_xcdw.xcdw022,
                              l_xcdw.xcdw023,l_xcdw.xcdw024,l_xcdw.xcdw025,l_xcdw.xcdw026,l_xcdw.xcdw027,
                              l_xcdw.xcdw028,l_xcdw.xcdw029,l_xcdw.xcdw030,l_xcdw.xcdw031,l_xcdw.xcdw032,
                              l_xcdw.xcdw033,l_xcdw.xcdw034,l_xcdw.xcdw047,l_xcdw.xcdw048,l_xcdw.xcdw049,
                              l_xcdw.xcdw050,l_xcdw.xcdw051,l_xcdw.xcdw201,l_xcdw.xcdw202,l_xcdw.xcdwstus)
           #161109-00085#24-e mod
           IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = 'ins xcdw_t'
              LET g_errparam.popup = TRUE
              CALL cl_err()
              LET l_success = 'N' 
              EXIT FOREACH      
           END IF                           
        ELSE
           FOREACH s_axct310_tmp2_cs INTO l_xcdw.xcdw010,l_xcdw.xcdw202
              #161109-00085#24-s mod
#              INSERT INTO xcdw_t VALUES(l_xcdw.*)   #161109-00085#24-s mark
              INSERT INTO xcdw_t(xcdwent,xcdwsite,xcdwcomp,xcdwld,xcdw001,xcdw002,xcdw003,xcdw004,
                                 xcdw005,xcdw006,xcdw007,xcdw008,xcdw009,xcdw010,xcdw011,xcdw012,
                                 xcdw013,xcdw014,xcdw015,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,
                                 xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,
                                 xcdw030,xcdw031,xcdw032,xcdw033,xcdw034,xcdw047,xcdw048,xcdw049,
                                 xcdw050,xcdw051,xcdw201,xcdw202,xcdwstus)
                          VALUES(l_xcdw.xcdwent,l_xcdw.xcdwsite,l_xcdw.xcdwcomp,l_xcdw.xcdwld,l_xcdw.xcdw001,
                                 l_xcdw.xcdw002,l_xcdw.xcdw003,l_xcdw.xcdw004,l_xcdw.xcdw005,l_xcdw.xcdw006,
                                 l_xcdw.xcdw007,l_xcdw.xcdw008,l_xcdw.xcdw009,l_xcdw.xcdw010,l_xcdw.xcdw011,
                                 l_xcdw.xcdw012,l_xcdw.xcdw013,l_xcdw.xcdw014,l_xcdw.xcdw015,l_xcdw.xcdw016,
                                 l_xcdw.xcdw017,l_xcdw.xcdw018,l_xcdw.xcdw020,l_xcdw.xcdw021,l_xcdw.xcdw022,
                                 l_xcdw.xcdw023,l_xcdw.xcdw024,l_xcdw.xcdw025,l_xcdw.xcdw026,l_xcdw.xcdw027,
                                 l_xcdw.xcdw028,l_xcdw.xcdw029,l_xcdw.xcdw030,l_xcdw.xcdw031,l_xcdw.xcdw032,
                                 l_xcdw.xcdw033,l_xcdw.xcdw034,l_xcdw.xcdw047,l_xcdw.xcdw048,l_xcdw.xcdw049,
                                 l_xcdw.xcdw050,l_xcdw.xcdw051,l_xcdw.xcdw201,l_xcdw.xcdw202,l_xcdw.xcdwstus)
              #161109-00085#24-e mod
              IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = 'ins xcdw_t'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET l_success = 'N' 
                 EXIT FOREACH      
              END IF                     
           END FOREACH        
        END IF
     ELSE
        #161109-00085#24-s mod
#        INSERT INTO xcdw_t VALUES(l_xcdw.*)   #161109-00085#24-s mark
        INSERT INTO xcdw_t(xcdwent,xcdwsite,xcdwcomp,xcdwld,xcdw001,xcdw002,xcdw003,xcdw004,
                           xcdw005,xcdw006,xcdw007,xcdw008,xcdw009,xcdw010,xcdw011,xcdw012,
                           xcdw013,xcdw014,xcdw015,xcdw016,xcdw017,xcdw018,xcdw020,xcdw021,
                           xcdw022,xcdw023,xcdw024,xcdw025,xcdw026,xcdw027,xcdw028,xcdw029,
                           xcdw030,xcdw031,xcdw032,xcdw033,xcdw034,xcdw047,xcdw048,xcdw049,
                           xcdw050,xcdw051,xcdw201,xcdw202,xcdwstus)
                    VALUES(l_xcdw.xcdwent,l_xcdw.xcdwsite,l_xcdw.xcdwcomp,l_xcdw.xcdwld,l_xcdw.xcdw001,
                           l_xcdw.xcdw002,l_xcdw.xcdw003,l_xcdw.xcdw004,l_xcdw.xcdw005,l_xcdw.xcdw006,
                           l_xcdw.xcdw007,l_xcdw.xcdw008,l_xcdw.xcdw009,l_xcdw.xcdw010,l_xcdw.xcdw011,
                           l_xcdw.xcdw012,l_xcdw.xcdw013,l_xcdw.xcdw014,l_xcdw.xcdw015,l_xcdw.xcdw016,
                           l_xcdw.xcdw017,l_xcdw.xcdw018,l_xcdw.xcdw020,l_xcdw.xcdw021,l_xcdw.xcdw022,
                           l_xcdw.xcdw023,l_xcdw.xcdw024,l_xcdw.xcdw025,l_xcdw.xcdw026,l_xcdw.xcdw027,
                           l_xcdw.xcdw028,l_xcdw.xcdw029,l_xcdw.xcdw030,l_xcdw.xcdw031,l_xcdw.xcdw032,
                           l_xcdw.xcdw033,l_xcdw.xcdw034,l_xcdw.xcdw047,l_xcdw.xcdw048,l_xcdw.xcdw049,
                           l_xcdw.xcdw050,l_xcdw.xcdw051,l_xcdw.xcdw201,l_xcdw.xcdw202,l_xcdw.xcdwstus)
        #161109-00085#24-e mod
        IF SQLCA.SQLCODE AND (NOT cl_err_sql_dup_value(SQLCA.SQLCODE)) THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = 'ins xcdw_t'
           LET g_errparam.popup = TRUE
           CALL cl_err()
           LET l_success = 'N' 
           EXIT FOREACH      
        END IF               
     END IF
#fengmy150318---e
  END FOREACH
  IF l_success = 'N' THEN
     #CALL cl_err_showmsg() 
      CALL s_transaction_end('N','0') 
   ELSE  
      
      CALL s_transaction_end('Y','0')
   END IF  
CALL s_axct310_drop_tmp_table()    #fengmy150316   
  IF l_success = 'Y' THEN
     INITIALIZE la_param.* TO NULL
     CASE g_xccw012_p 
        WHEN '1'
           LET la_param.prog = "axct322"
        WHEN '2'
           LET la_param.prog = "axct323" 
        WHEN '3'
           LET la_param.prog = "axct324" 
        WHEN '5'
           LET la_param.prog = "axct326" 
     END CASE  
              
     LET la_param.param[1] = g_xccw_m.xccwld
     LET la_param.param[2] = g_xccw_m.xccw003
     LET la_param.param[3] = g_xccw_m.xccw004
     LET la_param.param[4] = g_xccw_m.xccw005
     LET la_param.param[5] = g_xccw_m.xccw006         
     LET ls_js = util.JSON.stringify(la_param)
     DISPLAY ls_js
     CALL cl_cmdrun(ls_js)
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
PRIVATE FUNCTION axct312_ref_detail(p_xccw002,p_xccw010,p_xccw015,p_xccw016,p_xccw021)
DEFINE p_xccw002 LIKE xccw_t.xccw002
DEFINE p_xccw010 LIKE xccw_t.xccw010
DEFINE p_xccw015 LIKE xccw_t.xccw015 
DEFINE p_xccw016 LIKE xccw_t.xccw016
DEFINE p_xccw021 LIKE xccw_t.xccw021
DEFINE l_xccw002_desc LIKE type_t.chr1000
DEFINE l_xccw010_desc LIKE type_t.chr1000
DEFINE l_xccw010_desc_desc LIKE type_t.chr1000
DEFINE l_xccw015_desc LIKE type_t.chr1000
DEFINE l_xccw016_desc LIKE type_t.chr1000
DEFINE l_xccw021_desc LIKE type_t.chr1000
#成本域
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                                
   LET g_ref_fields[1] = g_xccw_m.xccwcomp                                                                                                                                                 
   LET g_ref_fields[2] = p_xccw002                                                                                                                                            
   CALL ap_ref_array2(g_ref_fields,"SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbflcomp=? AND xcbfl001=? AND xcbfl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xccw002_desc = '', g_rtn_fields[1] , ''
#品名規格
   INITIALIZE g_ref_fields TO NULL                                                                                                                                                                                                                                                                                     
   LET g_ref_fields[1] = p_xccw010                                                                                                                            
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xccw010_desc = '', g_rtn_fields[1] , '' 
   LET l_xccw010_desc_desc = '', g_rtn_fields[2] , '' 
#倉庫
   CALL s_desc_get_stock_desc(g_site,p_xccw015) RETURNING l_xccw015_desc
#儲位
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xccw016
   CALL ap_ref_array2(g_ref_fields,"SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite='"||g_site||"' AND inab001 = '"||p_xccw015||"' AND inab002 = ? ","") RETURNING g_rtn_fields
   LET l_xccw016_desc = '', g_rtn_fields[1] , ''
#原因碼
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_xccw021
   CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='216' AND oocql002 = ? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET l_xccw021_desc = '', g_rtn_fields[1] , ''
    
   RETURN l_xccw002_desc,l_xccw010_desc,l_xccw010_desc_desc,l_xccw015_desc,l_xccw016_desc,l_xccw021_desc
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
PRIVATE FUNCTION axct312_chk_ld_comp()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_success        LIKE type_t.num5
   
   LET r_success = TRUE

   #只检查法人
   IF g_xccw_m.xccwld IS NULL AND g_xccw_m.xccwcomp IS NOT NULL THEN   
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccw_m.xccwcomp
         
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_ooef001_1") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #只检查账套
   IF g_xccw_m.xccwld IS NOT NULL AND g_xccw_m.xccwcomp IS NULL THEN
      #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
      INITIALIZE g_chkparam.* TO NULL
      
      #設定g_chkparam.*的參數
      LET g_chkparam.arg1 = g_xccw_m.xccwld
      #160318-00025#12--add--str
      LET g_errshow = TRUE 
      LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
      #160318-00025#12--add--end  
      #呼叫檢查存在並帶值的library
      IF cl_chk_exist("v_glaald") THEN
         #檢查成功時後續處理
         #LET  = g_chkparam.return1
         #DISPLAY BY NAME 
         CALL s_ld_chk_authorization(g_user,g_xccw_m.xccwld) RETURNING l_success
         IF l_success = FALSE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = 'axr-00022'
            LET g_errparam.extend = g_xccw_m.xccwld
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF 
      ELSE
         #檢查失敗時後續處理
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF

   #法人账套都存在，检查他们的关系
   IF NOT s_ld_chk_comp(g_xccw_m.xccwld,g_xccw_m.xccwcomp) THEN  #v_glaald_5 
      LET g_xccw_m.xccwcomp = g_xccw_m_t.xccwcomp
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
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
PRIVATE FUNCTION axct312_chk_year_period()
   DEFINE r_success        LIKE type_t.num5
   DEFINE l_bdate          LIKE type_t.dat    #起始年度+期別對應的起始截止日期
   DEFINE l_edate          LIKE type_t.dat
   DEFINE l_glaa003        LIKE glaa_t.glaa003
   DEFINE l_date  DATE
   DEFINE l_cnt            LIKE type_t.num5
   LET r_success = TRUE 
   #抓出会计周期参考表号  glaa003
   SELECT glaa003 INTO l_glaa003
        FROM glaa_t
       WHERE glaaent  = g_enterprise
         AND glaacomp = g_xccw_m.xccwcomp
         AND glaa014  = 'Y'   
   IF g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NULL THEN
      IF NOT s_fin_date_chk_year(g_xccw_m.xccw004) THEN  
         LET r_success = FALSE
         RETURN r_success      
      END IF
      SELECT COUNT(*) INTO l_cnt FROM glav_t
      WHERE glavent = g_enterprise
        AND glav001 = l_glaa003
        AND glav002 = g_xccw_m.xccw004
        AND glavstus = 'Y' 
      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00581'
         LET g_errparam.extend = g_xccw_m.xccw004
         LET g_errparam.popup = TRUE
         CALL cl_err() 
         LET r_success = FALSE
         RETURN r_success 
      END IF
   END IF
   

   IF g_xccw_m.xccw004 IS NOT NULL AND g_xccw_m.xccw005 IS NOT NULL THEN
      IF NOT s_fin_date_chk_period(l_glaa003,g_xccw_m.xccw004,g_xccw_m.xccw005) THEN
         LET r_success = FALSE
         RETURN r_success      
      END IF
   END IF
   RETURN r_success
END FUNCTION

 
{</section>}
 
