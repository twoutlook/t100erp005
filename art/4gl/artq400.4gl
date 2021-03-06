#該程式未解開Section, 採用最新樣板產出!
{<section id="artq400.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2016-05-12 10:40:56), PR版次:0009(2016-08-03 17:45:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000330
#+ Filename...: artq400
#+ Description: 營運組織商品清單查詢作業
#+ Creator....: 04226(2015-01-29 14:32:32)
#+ Modifier...: 06137 -SD/PR- 08742
 
{</section>}
 
{<section id="artq400.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#16 2016/08/03 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod  artq400_rtdx_tmp -->artq400_tmp01
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
 
#單身 type 宣告
PRIVATE TYPE type_g_rtdx_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500, 
   rtdx001_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   rtdx003 LIKE rtdx_t.rtdx003, 
   rtdx010 LIKE rtdx_t.rtdx010, 
   rtdx027 LIKE rtdx_t.rtdx027, 
   rtdx028 LIKE rtdx_t.rtdx028, 
   rtdx028_desc LIKE type_t.chr500, 
   rtdx029 LIKE rtdx_t.rtdx029, 
   rtdx029_desc LIKE type_t.chr500, 
   rtdx032 LIKE rtdx_t.rtdx032, 
   rtdx041 LIKE rtdx_t.rtdx041, 
   rtdx042 LIKE rtdx_t.rtdx042, 
   rtdx034 LIKE rtdx_t.rtdx034, 
   rtdx051 LIKE rtdx_t.rtdx051, 
   rtdx052 LIKE rtdx_t.rtdx052, 
   rtdx035 LIKE rtdx_t.rtdx035, 
   rtdx035_desc LIKE type_t.chr500, 
   l_rtdx035_oodb006 LIKE type_t.num26_10, 
   l_rtdx035_oodb005 LIKE type_t.chr1, 
   imaf143 LIKE imaf_t.imaf143, 
   imaf143_desc LIKE type_t.chr500, 
   imaf144 LIKE imaf_t.imaf144, 
   imaf144_desc LIKE type_t.chr500, 
   imaf145 LIKE imaf_t.imaf145, 
   imaf146 LIKE imaf_t.imaf146, 
   rtdx044 LIKE rtdx_t.rtdx044, 
   rtdx044_desc LIKE type_t.chr500, 
   imaf153 LIKE imaf_t.imaf153, 
   imaf153_desc LIKE type_t.chr500, 
   imaf147 LIKE imaf_t.imaf147, 
   imaf152 LIKE imaf_t.imaf152, 
   imaf158 LIKE imaf_t.imaf158, 
   imaf164 LIKE imaf_t.imaf164, 
   imaf166 LIKE imaf_t.imaf166 
       END RECORD
PRIVATE TYPE type_g_rtdx2_d RECORD
       rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_2_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_2_desc LIKE type_t.chr500, 
   rtdx001_2_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_2_desc LIKE type_t.chr500, 
   rtdx004 LIKE rtdx_t.rtdx004, 
   rtdx004_desc LIKE type_t.chr500, 
   rtdx005 LIKE rtdx_t.rtdx005, 
   rtdx011 LIKE rtdx_t.rtdx011, 
   rtdx013 LIKE rtdx_t.rtdx013, 
   rtdx014 LIKE rtdx_t.rtdx014, 
   rtdx014_desc LIKE type_t.chr500, 
   l_rtdx014_oodb006 LIKE type_t.num26_10, 
   l_rtdx014_oodb005 LIKE type_t.chr1, 
   rtdx053 LIKE rtdx_t.rtdx053, 
   rtdx054 LIKE rtdx_t.rtdx054, 
   rtdx016 LIKE rtdx_t.rtdx016, 
   rtdx101 LIKE rtdx_t.rtdx101, 
   rtdx020 LIKE rtdx_t.rtdx020, 
   rtdx021 LIKE rtdx_t.rtdx021, 
   rtdx017 LIKE rtdx_t.rtdx017, 
   rtdx018 LIKE rtdx_t.rtdx018, 
   rtdx019 LIKE rtdx_t.rtdx019, 
   rtdx102 LIKE rtdx_t.rtdx102, 
   rtdx103 LIKE rtdx_t.rtdx103, 
   rtdx046 LIKE rtdx_t.rtdx046, 
   rtdx022 LIKE rtdx_t.rtdx022, 
   rtdx023 LIKE rtdx_t.rtdx023, 
   rtdx024 LIKE rtdx_t.rtdx024, 
   rtdx025 LIKE rtdx_t.rtdx025, 
   rtdx026 LIKE rtdx_t.rtdx026, 
   rtdx036 LIKE rtdx_t.rtdx036, 
   rtdx037 LIKE rtdx_t.rtdx037, 
   rtdx038 LIKE rtdx_t.rtdx038, 
   rtdx039 LIKE rtdx_t.rtdx039, 
   rtdx040 LIKE rtdx_t.rtdx040, 
   rtdx047 LIKE rtdx_t.rtdx047, 
   rtdx048 LIKE rtdx_t.rtdx048, 
   rtdx045 LIKE rtdx_t.rtdx045, 
   rtdx045_desc LIKE type_t.num20_6, 
   imaf112 LIKE imaf_t.imaf112, 
   imaf112_desc LIKE type_t.chr500, 
   imaf113 LIKE imaf_t.imaf113, 
   imaf113_desc LIKE type_t.chr500, 
   imaf114 LIKE imaf_t.imaf114, 
   imaf115 LIKE imaf_t.imaf115, 
   imaf122 LIKE imaf_t.imaf122
       END RECORD
 
PRIVATE TYPE type_g_rtdx3_d RECORD
       rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_3_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_3_desc LIKE type_t.chr500, 
   rtdx001_3_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_3_desc LIKE type_t.chr500, 
   rtdx043 LIKE rtdx_t.rtdx043, 
   rtdx006 LIKE rtdx_t.rtdx006, 
   rtdx007 LIKE rtdx_t.rtdx007, 
   rtdx008 LIKE rtdx_t.rtdx008, 
   rtdx009 LIKE rtdx_t.rtdx009, 
   rtdx012 LIKE rtdx_t.rtdx012
       END RECORD
 
PRIVATE TYPE type_g_rtdx4_d RECORD
       rtdxstus LIKE rtdx_t.rtdxstus, 
   rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_4_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_4_desc LIKE type_t.chr500, 
   rtdx001_4_desc_desc LIKE type_t.chr500, 
   rtdxownid LIKE rtdx_t.rtdxownid, 
   rtdxownid_desc LIKE type_t.chr500, 
   rtdxowndp LIKE rtdx_t.rtdxowndp, 
   rtdxowndp_desc LIKE type_t.chr500, 
   rtdxcrtid LIKE rtdx_t.rtdxcrtid, 
   rtdxcrtid_desc LIKE type_t.chr500, 
   rtdxcrtdp LIKE rtdx_t.rtdxcrtdp, 
   rtdxcrtdp_desc LIKE type_t.chr500, 
   rtdxcrtdt DATETIME YEAR TO SECOND, 
   rtdxmodid LIKE rtdx_t.rtdxmodid, 
   rtdxmodid_desc LIKE type_t.chr500, 
   rtdxmoddt DATETIME YEAR TO SECOND
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ls_wc               STRING  #160107-00016#1 Add By Ken 160108

 TYPE type_g_rtdx_d2 RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500, 
   rtdx001_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_desc LIKE type_t.chr500, 
   rtdx003 LIKE rtdx_t.rtdx003, 
   rtdx010 LIKE rtdx_t.rtdx010, 
   rtdx027 LIKE rtdx_t.rtdx027, 
   rtdx028 LIKE rtdx_t.rtdx028, 
   rtdx028_desc LIKE type_t.chr500, 
   rtdx029 LIKE rtdx_t.rtdx029, 
   rtdx029_desc LIKE type_t.chr500, 
   rtdx032 LIKE rtdx_t.rtdx032, 
   rtdx041 LIKE rtdx_t.rtdx041, 
   rtdx042 LIKE rtdx_t.rtdx042, 
   rtdx034 LIKE rtdx_t.rtdx034, 
   rtdx051 LIKE rtdx_t.rtdx051,
   rtdx052 LIKE rtdx_t.rtdx052,   
   rtdx035 LIKE rtdx_t.rtdx035, 
   rtdx035_desc LIKE type_t.chr500, 
   l_rtdx035_oodb006 LIKE type_t.num26_10, 
   l_rtdx035_oodb005 LIKE type_t.chr1, 
   imaf143 LIKE imaf_t.imaf143, 
   imaf143_desc LIKE type_t.chr500, 
   imaf144 LIKE imaf_t.imaf144, 
   imaf144_desc LIKE type_t.chr500, 
   imaf145 LIKE imaf_t.imaf145, 
   imaf146 LIKE imaf_t.imaf146, 
   rtdx044 LIKE rtdx_t.rtdx044, 
   rtdx044_desc LIKE type_t.chr500, 
   imaf153 LIKE imaf_t.imaf153, 
   imaf153_desc LIKE type_t.chr500, 
   imaf147 LIKE imaf_t.imaf147, 
   imaf152 LIKE imaf_t.imaf152, 
   imaf158 LIKE imaf_t.imaf158, 
   imaf164 LIKE imaf_t.imaf164, 
   imaf166 LIKE imaf_t.imaf166 
       END RECORD
 TYPE type_g_rtdx2_d2 RECORD
       rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_2_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_2_desc LIKE type_t.chr500, 
   rtdx001_2_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_2_desc LIKE type_t.chr500, 
   rtdx004 LIKE rtdx_t.rtdx004, 
   rtdx004_desc LIKE type_t.chr500, 
   rtdx005 LIKE rtdx_t.rtdx005, 
   rtdx011 LIKE rtdx_t.rtdx011, 
   rtdx013 LIKE rtdx_t.rtdx013, 
   rtdx014 LIKE rtdx_t.rtdx014, 
   rtdx014_desc LIKE type_t.chr500, 
   l_rtdx014_oodb006 LIKE type_t.num26_10, 
   l_rtdx014_oodb005 LIKE type_t.chr1, 
   rtdx053 LIKE rtdx_t.rtdx053, 
   rtdx054 LIKE rtdx_t.rtdx054,   
   rtdx016 LIKE rtdx_t.rtdx016,
   rtdx101 LIKE rtdx_t.rtdx101,   #160506-00009#14 Add By Ken 160512  
   rtdx020 LIKE rtdx_t.rtdx020, 
   rtdx021 LIKE rtdx_t.rtdx021,     
   rtdx017 LIKE rtdx_t.rtdx017, 
   rtdx018 LIKE rtdx_t.rtdx018, 
   rtdx019 LIKE rtdx_t.rtdx019,  
   rtdx102 LIKE rtdx_t.rtdx102,    #160506-00009#14 Add By Ken 160512  
   rtdx103 LIKE rtdx_t.rtdx103,    #160506-00009#14 Add By Ken 160512  
   rtdx046 LIKE rtdx_t.rtdx046, 
   rtdx022 LIKE rtdx_t.rtdx022, 
   rtdx023 LIKE rtdx_t.rtdx023, 
   rtdx024 LIKE rtdx_t.rtdx024, 
   rtdx025 LIKE rtdx_t.rtdx025, 
   rtdx026 LIKE rtdx_t.rtdx026, 
   rtdx036 LIKE rtdx_t.rtdx036, 
   rtdx037 LIKE rtdx_t.rtdx037, 
   rtdx038 LIKE rtdx_t.rtdx038, 
   rtdx039 LIKE rtdx_t.rtdx039, 
   rtdx040 LIKE rtdx_t.rtdx040, 
   rtdx047 LIKE rtdx_t.rtdx047, 
   rtdx048 LIKE rtdx_t.rtdx048,   
   rtdx045 LIKE rtdx_t.rtdx045, 
   rtdx045_desc LIKE type_t.num20_6, 
   imaf112 LIKE imaf_t.imaf112, 
   imaf112_desc LIKE type_t.chr500, 
   imaf113 LIKE imaf_t.imaf113, 
   imaf113_desc LIKE type_t.chr500, 
   imaf114 LIKE imaf_t.imaf114, 
   imaf115 LIKE imaf_t.imaf115, 
   imaf122 LIKE imaf_t.imaf122
       END RECORD
 
 TYPE type_g_rtdx3_d2 RECORD
       rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_3_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_3_desc LIKE type_t.chr500, 
   rtdx001_3_desc_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   imaa009 LIKE imaa_t.imaa009, 
   imaa009_3_desc LIKE type_t.chr500, 
   rtdx043 LIKE rtdx_t.rtdx043, 
   rtdx006 LIKE rtdx_t.rtdx006, 
   rtdx007 LIKE rtdx_t.rtdx007, 
   rtdx008 LIKE rtdx_t.rtdx008, 
   rtdx009 LIKE rtdx_t.rtdx009, 
   rtdx012 LIKE rtdx_t.rtdx012
       END RECORD
 
 TYPE type_g_rtdx4_d2 RECORD
       rtdxstus LIKE rtdx_t.rtdxstus, 
   rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_4_desc LIKE type_t.chr500, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_4_desc LIKE type_t.chr500, 
   rtdx001_4_desc_desc LIKE type_t.chr500, 
   rtdxownid LIKE rtdx_t.rtdxownid, 
   rtdxownid_desc LIKE type_t.chr500, 
   rtdxowndp LIKE rtdx_t.rtdxowndp, 
   rtdxowndp_desc LIKE type_t.chr500, 
   rtdxcrtid LIKE rtdx_t.rtdxcrtid, 
   rtdxcrtid_desc LIKE type_t.chr500, 
   rtdxcrtdp LIKE rtdx_t.rtdxcrtdp, 
   rtdxcrtdp_desc LIKE type_t.chr500, 
   rtdxcrtdt DATETIME YEAR TO SECOND, 
   rtdxmodid LIKE rtdx_t.rtdxmodid, 
   rtdxmodid_desc LIKE type_t.chr500, 
   rtdxmoddt DATETIME YEAR TO SECOND
       END RECORD
       
DEFINE g_rtdx_d2          DYNAMIC ARRAY OF type_g_rtdx_d2
DEFINE g_rtdx2_d2         DYNAMIC ARRAY OF type_g_rtdx2_d2
DEFINE g_rtdx3_d2         DYNAMIC ARRAY OF type_g_rtdx3_d2
DEFINE g_rtdx4_d2         DYNAMIC ARRAY OF type_g_rtdx4_d2
DEFINE g_rtdx101_flag     LIKE type_t.chr10    #160506-00009#14 Add By Ken 160512 啟用積分超市flag
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtdx_d
DEFINE g_master_t                   type_g_rtdx_d
DEFINE g_rtdx_d          DYNAMIC ARRAY OF type_g_rtdx_d
DEFINE g_rtdx_d_t        type_g_rtdx_d
DEFINE g_rtdx2_d   DYNAMIC ARRAY OF type_g_rtdx2_d
DEFINE g_rtdx2_d_t type_g_rtdx2_d
 
DEFINE g_rtdx3_d   DYNAMIC ARRAY OF type_g_rtdx3_d
DEFINE g_rtdx3_d_t type_g_rtdx3_d
 
DEFINE g_rtdx4_d   DYNAMIC ARRAY OF type_g_rtdx4_d
DEFINE g_rtdx4_d_t type_g_rtdx4_d
 
 
      
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
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="artq400.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq400_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artq400_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq400_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artq400 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artq400_init()   
 
      #進入選單 Menu (="N")
      CALL artq400_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artq400
      
   END IF 
   
   CLOSE artq400_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL artq400_drop_tmp()     #160107-00016#1 Add By Ken 160108
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artq400.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artq400_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160304
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_rtdx003','6013') 
   CALL cl_set_combo_scc('b_rtdx027','6014') 
   CALL cl_set_combo_scc('b_imaf147','2025') 
   CALL cl_set_combo_scc('b_imaf152','2028') 
   CALL cl_set_combo_scc('b_imaf158','2027') 
   CALL cl_set_combo_scc('b_imaf122','2027') 
   CALL cl_set_combo_scc('b_rtdx008','6205') 
   CALL cl_set_combo_scc('b_rtdx009','6206') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   #160506-00009#14 Add By Ken 160512(s)
   LET g_rtdx101_flag = cl_get_para(g_enterprise,g_site,"S-CIR-2028")
   IF g_rtdx101_flag = 'N' THEN
      CALL cl_set_comp_visible("b_rtdx101,b_rtdx102,b_rtdx103",FALSE)
   END IF
   #160506-00009#14 Add By Ken 160512(e)
   CALL cl_set_combo_scc_part('b_rtdx003','6013','1,2,3,4,5,') 
   CALL cl_set_comp_visible("sel",FALSE)
   CALL cl_set_act_visible("selall",FALSE)
   CALL cl_set_act_visible("selnone",FALSE)
   CALL cl_set_act_visible("sel",FALSE)
   CALL cl_set_act_visible("unsel",FALSE)
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   CALL artq400_create_tmp() RETURNING l_success  #160107-00016#1 Add By Ken 160108
   CALL s_life_cycle_display(g_prog,'b_rtdx006','1')
   #add by geza 20160304(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','7') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx017",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','8') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx018",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','9') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx019",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','4') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx038",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','5') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx039",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','6') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_rtdx040",l_gzcbl004)
   #add by geza 20160304(E) 
   #end add-point
 
   CALL artq400_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="artq400.default_search" >}
PRIVATE FUNCTION artq400_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtdxsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtdx001 = '", g_argv[02], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION artq400_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL artq400_b_fill()
   ELSE
      CALL artq400_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdx_d.clear()
         CALL g_rtdx2_d.clear()
 
         CALL g_rtdx3_d.clear()
 
         CALL g_rtdx4_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL artq400_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL artq400_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL artq400_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL artq400_detail_action_trans()    #160107-00016#1 Add By Ken 160108
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_rtdx2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_rtdx2_d.getLength() TO FORMONLY.h_count
               CALL artq400_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               CALL artq400_detail_action_trans()    #160107-00016#1 Add By Ken 160108
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_rtdx3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_rtdx3_d.getLength() TO FORMONLY.h_count
               CALL artq400_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body3.before_row"
               CALL artq400_detail_action_trans()    #160107-00016#1 Add By Ken 160108
               #end add-point  
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_rtdx4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 4
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_rtdx4_d.getLength() TO FORMONLY.h_count
               CALL artq400_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body4.before_row"
               CALL artq400_detail_action_trans()    #160107-00016#1 Add By Ken 160108
               #end add-point  
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL artq400_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_comp_visible("sel", FALSE)
            CALL cl_set_act_visible("selall",FALSE)
            CALL cl_set_act_visible("selnone",FALSE)
            CALL cl_set_act_visible("sel",FALSE)
            CALL cl_set_act_visible("unsel",FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL artq400_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible("sel", FALSE)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL artq400_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL artq400_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtdx2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_rtdx3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_rtdx4_d)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               CALL artq400_to_excel()
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtdx_d2)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtdx2_d2)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_rtdx3_d2)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_rtdx4_d2)
               LET g_export_id[4]   = "s_detail4"
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL artq400_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL artq400_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL artq400_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL artq400_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               LET g_rtdx_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtdx_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtdx_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artq400_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_rtdx_d.clear()
   CALL g_rtdx2_d.clear()
 
   CALL g_rtdx3_d.clear()
 
   CALL g_rtdx4_d.clear()
 
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON rtdxsite,rtdx001,rtdx002,imaa009,rtdx003,rtdx010,rtdx027,rtdx028,rtdx029, 
          rtdx032,rtdx041,rtdx042,rtdx034,rtdx051,rtdx052,rtdx035,imaf143,imaf144,imaf145,imaf146,rtdx044, 
          imaf153,imaf147,imaf152,imaf158,imaf164,imaf166,rtdx004,rtdx005,rtdx011,rtdx013,rtdx014,rtdx053, 
          rtdx054,rtdx016,rtdx101,rtdx020,rtdx021,rtdx017,rtdx018,rtdx019,rtdx102,rtdx103,rtdx046,rtdx022, 
          rtdx023,rtdx024,rtdx025,rtdx026,rtdx036,rtdx037,rtdx038,rtdx039,rtdx040,rtdx047,rtdx048,rtdx045, 
          imaf112,imaf113,imaf114,imaf115,imaf122,rtdx043,rtdx006,rtdx007,rtdx008,rtdx009,rtdx012,rtdxstus, 
          rtdxownid,rtdxowndp,rtdxcrtid,rtdxcrtdp,rtdxcrtdt,rtdxmodid,rtdxmoddt
           FROM s_detail1[1].b_rtdxsite,s_detail1[1].b_rtdx001,s_detail1[1].b_rtdx002,s_detail1[1].b_imaa009, 
               s_detail1[1].b_rtdx003,s_detail1[1].b_rtdx010,s_detail1[1].b_rtdx027,s_detail1[1].b_rtdx028, 
               s_detail1[1].b_rtdx029,s_detail1[1].b_rtdx032,s_detail1[1].b_rtdx041,s_detail1[1].b_rtdx042, 
               s_detail1[1].b_rtdx034,s_detail1[1].b_rtdx051,s_detail1[1].b_rtdx052,s_detail1[1].b_rtdx035, 
               s_detail1[1].b_imaf143,s_detail1[1].b_imaf144,s_detail1[1].b_imaf145,s_detail1[1].b_imaf146, 
               s_detail1[1].b_rtdx044,s_detail1[1].b_imaf153,s_detail1[1].b_imaf147,s_detail1[1].b_imaf152, 
               s_detail1[1].b_imaf158,s_detail1[1].b_imaf164,s_detail1[1].b_imaf166,s_detail2[1].b_rtdx004, 
               s_detail2[1].b_rtdx005,s_detail2[1].b_rtdx011,s_detail2[1].b_rtdx013,s_detail2[1].b_rtdx014, 
               s_detail2[1].b_rtdx053,s_detail2[1].b_rtdx054,s_detail2[1].b_rtdx016,s_detail2[1].b_rtdx101, 
               s_detail2[1].b_rtdx020,s_detail2[1].b_rtdx021,s_detail2[1].b_rtdx017,s_detail2[1].b_rtdx018, 
               s_detail2[1].b_rtdx019,s_detail2[1].b_rtdx102,s_detail2[1].b_rtdx103,s_detail2[1].b_rtdx046, 
               s_detail2[1].b_rtdx022,s_detail2[1].b_rtdx023,s_detail2[1].b_rtdx024,s_detail2[1].b_rtdx025, 
               s_detail2[1].b_rtdx026,s_detail2[1].b_rtdx036,s_detail2[1].b_rtdx037,s_detail2[1].b_rtdx038, 
               s_detail2[1].b_rtdx039,s_detail2[1].b_rtdx040,s_detail2[1].b_rtdx047,s_detail2[1].b_rtdx048, 
               s_detail2[1].b_rtdx045,s_detail2[1].b_imaf112,s_detail2[1].b_imaf113,s_detail2[1].b_imaf114, 
               s_detail2[1].b_imaf115,s_detail2[1].b_imaf122,s_detail3[1].b_rtdx043,s_detail3[1].b_rtdx006, 
               s_detail3[1].b_rtdx007,s_detail3[1].b_rtdx008,s_detail3[1].b_rtdx009,s_detail3[1].b_rtdx012, 
               s_detail4[1].b_rtdxstus,s_detail4[1].b_rtdxownid,s_detail4[1].b_rtdxowndp,s_detail4[1].b_rtdxcrtid, 
               s_detail4[1].b_rtdxcrtdp,s_detail4[1].b_rtdxcrtdt,s_detail4[1].b_rtdxmodid,s_detail4[1].b_rtdxmoddt 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #150706-00009#1 150706 BY pomelo add(S)
            DISPLAY g_site TO b_rtdxsite   
            #150706-00009#1 150706 BY pomelo add(E)
            LET g_ls_wc = '1'  #160107-00016#1 Add By Ken 160108
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdxcrtdt>>----
         AFTER FIELD rtdxcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdxmoddt>>----
         AFTER FIELD rtdxmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdxcnfdt>>----
         #AFTER FIELD rtdxcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdxpstdt>>----
         #AFTER FIELD rtdxpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_rtdxsite>>----
         #Ctrlp:construct.c.page1.b_rtdxsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxsite
            #add-point:ON ACTION controlp INFIELD b_rtdxsite name="construct.c.page1.b_rtdxsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxsite  #顯示到畫面上
            NEXT FIELD b_rtdxsite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxsite
            #add-point:BEFORE FIELD b_rtdxsite name="construct.b.page1.b_rtdxsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxsite
            
            #add-point:AFTER FIELD b_rtdxsite name="construct.a.page1.b_rtdxsite"
            
            #END add-point
            
 
 
         #----<<b_rtdxsite_desc>>----
         #----<<b_rtdx001>>----
         #Ctrlp:construct.c.page1.b_rtdx001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD b_rtdx001 name="construct.c.page1.b_rtdx001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx001  #顯示到畫面上
            NEXT FIELD b_rtdx001                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx001
            #add-point:BEFORE FIELD b_rtdx001 name="construct.b.page1.b_rtdx001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx001
            
            #add-point:AFTER FIELD b_rtdx001 name="construct.a.page1.b_rtdx001"
            
            #END add-point
            
 
 
         #----<<b_rtdx001_desc>>----
         #----<<b_rtdx001_desc_desc>>----
         #----<<b_rtdx002>>----
         #Ctrlp:construct.c.page1.b_rtdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD b_rtdx002 name="construct.c.page1.b_rtdx002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_7()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx002  #顯示到畫面上
            NEXT FIELD b_rtdx002                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx002
            #add-point:BEFORE FIELD b_rtdx002 name="construct.b.page1.b_rtdx002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx002
            
            #add-point:AFTER FIELD b_rtdx002 name="construct.a.page1.b_rtdx002"
            
            #END add-point
            
 
 
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaa009
            #add-point:BEFORE FIELD b_imaa009 name="construct.b.page1.b_imaa009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaa009
            
            #add-point:AFTER FIELD b_imaa009 name="construct.a.page1.b_imaa009"
            
            #END add-point
            
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_rtdx003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx003
            #add-point:BEFORE FIELD b_rtdx003 name="construct.b.page1.b_rtdx003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx003
            
            #add-point:AFTER FIELD b_rtdx003 name="construct.a.page1.b_rtdx003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx003
            #add-point:ON ACTION controlp INFIELD b_rtdx003 name="construct.c.page1.b_rtdx003"
            
            #END add-point
 
 
         #----<<b_rtdx010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx010
            #add-point:BEFORE FIELD b_rtdx010 name="construct.b.page1.b_rtdx010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx010
            
            #add-point:AFTER FIELD b_rtdx010 name="construct.a.page1.b_rtdx010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx010
            #add-point:ON ACTION controlp INFIELD b_rtdx010 name="construct.c.page1.b_rtdx010"
            
            #END add-point
 
 
         #----<<b_rtdx027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx027
            #add-point:BEFORE FIELD b_rtdx027 name="construct.b.page1.b_rtdx027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx027
            
            #add-point:AFTER FIELD b_rtdx027 name="construct.a.page1.b_rtdx027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx027
            #add-point:ON ACTION controlp INFIELD b_rtdx027 name="construct.c.page1.b_rtdx027"
            
            #END add-point
 
 
         #----<<b_rtdx028>>----
         #Ctrlp:construct.c.page1.b_rtdx028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx028
            #add-point:ON ACTION controlp INFIELD b_rtdx028 name="construct.c.page1.b_rtdx028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'rtdx028') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdx028',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef303 = 'Y' "
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO b_rtdx028  #顯示到畫面上
            NEXT FIELD b_rtdx028                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx028
            #add-point:BEFORE FIELD b_rtdx028 name="construct.b.page1.b_rtdx028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx028
            
            #add-point:AFTER FIELD b_rtdx028 name="construct.a.page1.b_rtdx028"
            
            #END add-point
            
 
 
         #----<<b_rtdx028_desc>>----
         #----<<b_rtdx029>>----
         #Ctrlp:construct.c.page1.b_rtdx029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx029
            #add-point:ON ACTION controlp INFIELD b_rtdx029 name="construct.c.page1.b_rtdx029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'rtdx029') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdx029',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef302 = 'Y' "
               CALL q_ooef001() 
            END IF
            DISPLAY g_qryparam.return1 TO b_rtdx029  #顯示到畫面上
            NEXT FIELD b_rtdx029                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx029
            #add-point:BEFORE FIELD b_rtdx029 name="construct.b.page1.b_rtdx029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx029
            
            #add-point:AFTER FIELD b_rtdx029 name="construct.a.page1.b_rtdx029"
            
            #END add-point
            
 
 
         #----<<b_rtdx029_desc>>----
         #----<<b_rtdx032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx032
            #add-point:BEFORE FIELD b_rtdx032 name="construct.b.page1.b_rtdx032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx032
            
            #add-point:AFTER FIELD b_rtdx032 name="construct.a.page1.b_rtdx032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx032
            #add-point:ON ACTION controlp INFIELD b_rtdx032 name="construct.c.page1.b_rtdx032"
            
            #END add-point
 
 
         #----<<b_rtdx041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx041
            #add-point:BEFORE FIELD b_rtdx041 name="construct.b.page1.b_rtdx041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx041
            
            #add-point:AFTER FIELD b_rtdx041 name="construct.a.page1.b_rtdx041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx041
            #add-point:ON ACTION controlp INFIELD b_rtdx041 name="construct.c.page1.b_rtdx041"
            
            #END add-point
 
 
         #----<<b_rtdx042>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx042
            #add-point:BEFORE FIELD b_rtdx042 name="construct.b.page1.b_rtdx042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx042
            
            #add-point:AFTER FIELD b_rtdx042 name="construct.a.page1.b_rtdx042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx042
            #add-point:ON ACTION controlp INFIELD b_rtdx042 name="construct.c.page1.b_rtdx042"
            
            #END add-point
 
 
         #----<<b_rtdx034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx034
            #add-point:BEFORE FIELD b_rtdx034 name="construct.b.page1.b_rtdx034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx034
            
            #add-point:AFTER FIELD b_rtdx034 name="construct.a.page1.b_rtdx034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx034
            #add-point:ON ACTION controlp INFIELD b_rtdx034 name="construct.c.page1.b_rtdx034"
            
            #END add-point
 
 
         #----<<b_rtdx051>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx051
            #add-point:BEFORE FIELD b_rtdx051 name="construct.b.page1.b_rtdx051"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx051
            
            #add-point:AFTER FIELD b_rtdx051 name="construct.a.page1.b_rtdx051"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx051
            #add-point:ON ACTION controlp INFIELD b_rtdx051 name="construct.c.page1.b_rtdx051"
            
            #END add-point
 
 
         #----<<b_rtdx052>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx052
            #add-point:BEFORE FIELD b_rtdx052 name="construct.b.page1.b_rtdx052"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx052
            
            #add-point:AFTER FIELD b_rtdx052 name="construct.a.page1.b_rtdx052"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtdx052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx052
            #add-point:ON ACTION controlp INFIELD b_rtdx052 name="construct.c.page1.b_rtdx052"
            
            #END add-point
 
 
         #----<<b_rtdx035>>----
         #Ctrlp:construct.c.page1.b_rtdx035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx035
            #add-point:ON ACTION controlp INFIELD b_rtdx035 name="construct.c.page1.b_rtdx035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx035  #顯示到畫面上
            NEXT FIELD b_rtdx035                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx035
            #add-point:BEFORE FIELD b_rtdx035 name="construct.b.page1.b_rtdx035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx035
            
            #add-point:AFTER FIELD b_rtdx035 name="construct.a.page1.b_rtdx035"
            
            #END add-point
            
 
 
         #----<<b_rtdx035_desc>>----
         #----<<l_rtdx035_oodb006>>----
         #----<<l_rtdx035_oodb005>>----
         #----<<b_imaf143>>----
         #Ctrlp:construct.c.page1.b_imaf143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf143
            #add-point:ON ACTION controlp INFIELD b_imaf143 name="construct.c.page1.b_imaf143"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf143  #顯示到畫面上
            NEXT FIELD b_imaf143                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf143
            #add-point:BEFORE FIELD b_imaf143 name="construct.b.page1.b_imaf143"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf143
            
            #add-point:AFTER FIELD b_imaf143 name="construct.a.page1.b_imaf143"
            
            #END add-point
            
 
 
         #----<<b_imaf143_desc>>----
         #----<<b_imaf144>>----
         #Ctrlp:construct.c.page1.b_imaf144
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf144
            #add-point:ON ACTION controlp INFIELD b_imaf144 name="construct.c.page1.b_imaf144"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf144  #顯示到畫面上
            NEXT FIELD b_imaf144                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf144
            #add-point:BEFORE FIELD b_imaf144 name="construct.b.page1.b_imaf144"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf144
            
            #add-point:AFTER FIELD b_imaf144 name="construct.a.page1.b_imaf144"
            
            #END add-point
            
 
 
         #----<<b_imaf144_desc>>----
         #----<<b_imaf145>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf145
            #add-point:BEFORE FIELD b_imaf145 name="construct.b.page1.b_imaf145"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf145
            
            #add-point:AFTER FIELD b_imaf145 name="construct.a.page1.b_imaf145"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf145
            #add-point:ON ACTION controlp INFIELD b_imaf145 name="construct.c.page1.b_imaf145"
            
            #END add-point
 
 
         #----<<b_imaf146>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf146
            #add-point:BEFORE FIELD b_imaf146 name="construct.b.page1.b_imaf146"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf146
            
            #add-point:AFTER FIELD b_imaf146 name="construct.a.page1.b_imaf146"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf146
            #add-point:ON ACTION controlp INFIELD b_imaf146 name="construct.c.page1.b_imaf146"
            
            #END add-point
 
 
         #----<<b_rtdx044>>----
         #Ctrlp:construct.c.page1.b_rtdx044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx044
            #add-point:ON ACTION controlp INFIELD b_rtdx044 name="construct.c.page1.b_rtdx044"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                         
            DISPLAY g_qryparam.return1 TO b_rtdx044  
            NEXT FIELD b_rtdx044  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx044
            #add-point:BEFORE FIELD b_rtdx044 name="construct.b.page1.b_rtdx044"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx044
            
            #add-point:AFTER FIELD b_rtdx044 name="construct.a.page1.b_rtdx044"
           
            #END add-point
            
 
 
         #----<<b_rtdx044_desc>>----
         #----<<b_imaf153>>----
         #Ctrlp:construct.c.page1.b_imaf153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf153
            #add-point:ON ACTION controlp INFIELD b_imaf153 name="construct.c.page1.b_imaf153"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf153  #顯示到畫面上
            NEXT FIELD b_imaf153                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf153
            #add-point:BEFORE FIELD b_imaf153 name="construct.b.page1.b_imaf153"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf153
            
            #add-point:AFTER FIELD b_imaf153 name="construct.a.page1.b_imaf153"
            
            #END add-point
            
 
 
         #----<<b_imaf153_desc>>----
         #----<<b_imaf147>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf147
            #add-point:BEFORE FIELD b_imaf147 name="construct.b.page1.b_imaf147"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf147
            
            #add-point:AFTER FIELD b_imaf147 name="construct.a.page1.b_imaf147"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf147
            #add-point:ON ACTION controlp INFIELD b_imaf147 name="construct.c.page1.b_imaf147"
            
            #END add-point
 
 
         #----<<b_imaf152>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf152
            #add-point:BEFORE FIELD b_imaf152 name="construct.b.page1.b_imaf152"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf152
            
            #add-point:AFTER FIELD b_imaf152 name="construct.a.page1.b_imaf152"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf152
            #add-point:ON ACTION controlp INFIELD b_imaf152 name="construct.c.page1.b_imaf152"
            
            #END add-point
 
 
         #----<<b_imaf158>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf158
            #add-point:BEFORE FIELD b_imaf158 name="construct.b.page1.b_imaf158"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf158
            
            #add-point:AFTER FIELD b_imaf158 name="construct.a.page1.b_imaf158"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf158
            #add-point:ON ACTION controlp INFIELD b_imaf158 name="construct.c.page1.b_imaf158"
            
            #END add-point
 
 
         #----<<b_imaf164>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf164
            #add-point:BEFORE FIELD b_imaf164 name="construct.b.page1.b_imaf164"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf164
            
            #add-point:AFTER FIELD b_imaf164 name="construct.a.page1.b_imaf164"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf164
            #add-point:ON ACTION controlp INFIELD b_imaf164 name="construct.c.page1.b_imaf164"
            
            #END add-point
 
 
         #----<<b_imaf166>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf166
            #add-point:BEFORE FIELD b_imaf166 name="construct.b.page1.b_imaf166"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf166
            
            #add-point:AFTER FIELD b_imaf166 name="construct.a.page1.b_imaf166"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaf166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf166
            #add-point:ON ACTION controlp INFIELD b_imaf166 name="construct.c.page1.b_imaf166"
            
            #END add-point
 
 
         #----<<rtdxsite_2_desc>>----
         #----<<rtdx001_2_desc>>----
         #----<<rtdx001_2_desc_desc>>----
         #----<<imaa009_2_desc>>----
         #----<<b_rtdx004>>----
         #Ctrlp:construct.c.page2.b_rtdx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx004
            #add-point:ON ACTION controlp INFIELD b_rtdx004 name="construct.c.page2.b_rtdx004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx004  #顯示到畫面上
            NEXT FIELD b_rtdx004                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx004
            #add-point:BEFORE FIELD b_rtdx004 name="construct.b.page2.b_rtdx004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx004
            
            #add-point:AFTER FIELD b_rtdx004 name="construct.a.page2.b_rtdx004"
            
            #END add-point
            
 
 
         #----<<b_rtdx004_desc>>----
         #----<<b_rtdx005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx005
            #add-point:BEFORE FIELD b_rtdx005 name="construct.b.page2.b_rtdx005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx005
            
            #add-point:AFTER FIELD b_rtdx005 name="construct.a.page2.b_rtdx005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx005
            #add-point:ON ACTION controlp INFIELD b_rtdx005 name="construct.c.page2.b_rtdx005"
            
            #END add-point
 
 
         #----<<b_rtdx011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx011
            #add-point:BEFORE FIELD b_rtdx011 name="construct.b.page2.b_rtdx011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx011
            
            #add-point:AFTER FIELD b_rtdx011 name="construct.a.page2.b_rtdx011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx011
            #add-point:ON ACTION controlp INFIELD b_rtdx011 name="construct.c.page2.b_rtdx011"
            
            #END add-point
 
 
         #----<<b_rtdx013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx013
            #add-point:BEFORE FIELD b_rtdx013 name="construct.b.page2.b_rtdx013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx013
            
            #add-point:AFTER FIELD b_rtdx013 name="construct.a.page2.b_rtdx013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx013
            #add-point:ON ACTION controlp INFIELD b_rtdx013 name="construct.c.page2.b_rtdx013"
            
            #END add-point
 
 
         #----<<b_rtdx014>>----
         #Ctrlp:construct.c.page2.b_rtdx014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx014
            #add-point:ON ACTION controlp INFIELD b_rtdx014 name="construct.c.page2.b_rtdx014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx014  #顯示到畫面上
            NEXT FIELD b_rtdx014                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx014
            #add-point:BEFORE FIELD b_rtdx014 name="construct.b.page2.b_rtdx014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx014
            
            #add-point:AFTER FIELD b_rtdx014 name="construct.a.page2.b_rtdx014"
            
            #END add-point
            
 
 
         #----<<b_rtdx014_desc>>----
         #----<<l_rtdx014_oodb006>>----
         #----<<l_rtdx014_oodb005>>----
         #----<<b_rtdx053>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx053
            #add-point:BEFORE FIELD b_rtdx053 name="construct.b.page2.b_rtdx053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx053
            
            #add-point:AFTER FIELD b_rtdx053 name="construct.a.page2.b_rtdx053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx053
            #add-point:ON ACTION controlp INFIELD b_rtdx053 name="construct.c.page2.b_rtdx053"
            
            #END add-point
 
 
         #----<<b_rtdx054>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx054
            #add-point:BEFORE FIELD b_rtdx054 name="construct.b.page2.b_rtdx054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx054
            
            #add-point:AFTER FIELD b_rtdx054 name="construct.a.page2.b_rtdx054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx054
            #add-point:ON ACTION controlp INFIELD b_rtdx054 name="construct.c.page2.b_rtdx054"
            
            #END add-point
 
 
         #----<<b_rtdx016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx016
            #add-point:BEFORE FIELD b_rtdx016 name="construct.b.page2.b_rtdx016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx016
            
            #add-point:AFTER FIELD b_rtdx016 name="construct.a.page2.b_rtdx016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx016
            #add-point:ON ACTION controlp INFIELD b_rtdx016 name="construct.c.page2.b_rtdx016"
            
            #END add-point
 
 
         #----<<b_rtdx101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx101
            #add-point:BEFORE FIELD b_rtdx101 name="construct.b.page2.b_rtdx101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx101
            
            #add-point:AFTER FIELD b_rtdx101 name="construct.a.page2.b_rtdx101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx101
            #add-point:ON ACTION controlp INFIELD b_rtdx101 name="construct.c.page2.b_rtdx101"
            
            #END add-point
 
 
         #----<<b_rtdx020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx020
            #add-point:BEFORE FIELD b_rtdx020 name="construct.b.page2.b_rtdx020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx020
            
            #add-point:AFTER FIELD b_rtdx020 name="construct.a.page2.b_rtdx020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx020
            #add-point:ON ACTION controlp INFIELD b_rtdx020 name="construct.c.page2.b_rtdx020"
            
            #END add-point
 
 
         #----<<b_rtdx021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx021
            #add-point:BEFORE FIELD b_rtdx021 name="construct.b.page2.b_rtdx021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx021
            
            #add-point:AFTER FIELD b_rtdx021 name="construct.a.page2.b_rtdx021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx021
            #add-point:ON ACTION controlp INFIELD b_rtdx021 name="construct.c.page2.b_rtdx021"
            
            #END add-point
 
 
         #----<<b_rtdx017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx017
            #add-point:BEFORE FIELD b_rtdx017 name="construct.b.page2.b_rtdx017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx017
            
            #add-point:AFTER FIELD b_rtdx017 name="construct.a.page2.b_rtdx017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx017
            #add-point:ON ACTION controlp INFIELD b_rtdx017 name="construct.c.page2.b_rtdx017"
            
            #END add-point
 
 
         #----<<b_rtdx018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx018
            #add-point:BEFORE FIELD b_rtdx018 name="construct.b.page2.b_rtdx018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx018
            
            #add-point:AFTER FIELD b_rtdx018 name="construct.a.page2.b_rtdx018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx018
            #add-point:ON ACTION controlp INFIELD b_rtdx018 name="construct.c.page2.b_rtdx018"
            
            #END add-point
 
 
         #----<<b_rtdx019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx019
            #add-point:BEFORE FIELD b_rtdx019 name="construct.b.page2.b_rtdx019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx019
            
            #add-point:AFTER FIELD b_rtdx019 name="construct.a.page2.b_rtdx019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx019
            #add-point:ON ACTION controlp INFIELD b_rtdx019 name="construct.c.page2.b_rtdx019"
            
            #END add-point
 
 
         #----<<b_rtdx102>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx102
            #add-point:BEFORE FIELD b_rtdx102 name="construct.b.page2.b_rtdx102"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx102
            
            #add-point:AFTER FIELD b_rtdx102 name="construct.a.page2.b_rtdx102"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx102
            #add-point:ON ACTION controlp INFIELD b_rtdx102 name="construct.c.page2.b_rtdx102"
            
            #END add-point
 
 
         #----<<b_rtdx103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx103
            #add-point:BEFORE FIELD b_rtdx103 name="construct.b.page2.b_rtdx103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx103
            
            #add-point:AFTER FIELD b_rtdx103 name="construct.a.page2.b_rtdx103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx103
            #add-point:ON ACTION controlp INFIELD b_rtdx103 name="construct.c.page2.b_rtdx103"
            
            #END add-point
 
 
         #----<<b_rtdx046>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx046
            #add-point:BEFORE FIELD b_rtdx046 name="construct.b.page2.b_rtdx046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx046
            
            #add-point:AFTER FIELD b_rtdx046 name="construct.a.page2.b_rtdx046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx046
            #add-point:ON ACTION controlp INFIELD b_rtdx046 name="construct.c.page2.b_rtdx046"
            
            #END add-point
 
 
         #----<<b_rtdx022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx022
            #add-point:BEFORE FIELD b_rtdx022 name="construct.b.page2.b_rtdx022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx022
            
            #add-point:AFTER FIELD b_rtdx022 name="construct.a.page2.b_rtdx022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx022
            #add-point:ON ACTION controlp INFIELD b_rtdx022 name="construct.c.page2.b_rtdx022"
            
            #END add-point
 
 
         #----<<b_rtdx023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx023
            #add-point:BEFORE FIELD b_rtdx023 name="construct.b.page2.b_rtdx023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx023
            
            #add-point:AFTER FIELD b_rtdx023 name="construct.a.page2.b_rtdx023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx023
            #add-point:ON ACTION controlp INFIELD b_rtdx023 name="construct.c.page2.b_rtdx023"
            
            #END add-point
 
 
         #----<<b_rtdx024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx024
            #add-point:BEFORE FIELD b_rtdx024 name="construct.b.page2.b_rtdx024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx024
            
            #add-point:AFTER FIELD b_rtdx024 name="construct.a.page2.b_rtdx024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx024
            #add-point:ON ACTION controlp INFIELD b_rtdx024 name="construct.c.page2.b_rtdx024"
            
            #END add-point
 
 
         #----<<b_rtdx025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx025
            #add-point:BEFORE FIELD b_rtdx025 name="construct.b.page2.b_rtdx025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx025
            
            #add-point:AFTER FIELD b_rtdx025 name="construct.a.page2.b_rtdx025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx025
            #add-point:ON ACTION controlp INFIELD b_rtdx025 name="construct.c.page2.b_rtdx025"
            
            #END add-point
 
 
         #----<<b_rtdx026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx026
            #add-point:BEFORE FIELD b_rtdx026 name="construct.b.page2.b_rtdx026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx026
            
            #add-point:AFTER FIELD b_rtdx026 name="construct.a.page2.b_rtdx026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx026
            #add-point:ON ACTION controlp INFIELD b_rtdx026 name="construct.c.page2.b_rtdx026"
            
            #END add-point
 
 
         #----<<b_rtdx036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx036
            #add-point:BEFORE FIELD b_rtdx036 name="construct.b.page2.b_rtdx036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx036
            
            #add-point:AFTER FIELD b_rtdx036 name="construct.a.page2.b_rtdx036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx036
            #add-point:ON ACTION controlp INFIELD b_rtdx036 name="construct.c.page2.b_rtdx036"
            
            #END add-point
 
 
         #----<<b_rtdx037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx037
            #add-point:BEFORE FIELD b_rtdx037 name="construct.b.page2.b_rtdx037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx037
            
            #add-point:AFTER FIELD b_rtdx037 name="construct.a.page2.b_rtdx037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx037
            #add-point:ON ACTION controlp INFIELD b_rtdx037 name="construct.c.page2.b_rtdx037"
            
            #END add-point
 
 
         #----<<b_rtdx038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx038
            #add-point:BEFORE FIELD b_rtdx038 name="construct.b.page2.b_rtdx038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx038
            
            #add-point:AFTER FIELD b_rtdx038 name="construct.a.page2.b_rtdx038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx038
            #add-point:ON ACTION controlp INFIELD b_rtdx038 name="construct.c.page2.b_rtdx038"
            
            #END add-point
 
 
         #----<<b_rtdx039>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx039
            #add-point:BEFORE FIELD b_rtdx039 name="construct.b.page2.b_rtdx039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx039
            
            #add-point:AFTER FIELD b_rtdx039 name="construct.a.page2.b_rtdx039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx039
            #add-point:ON ACTION controlp INFIELD b_rtdx039 name="construct.c.page2.b_rtdx039"
            
            #END add-point
 
 
         #----<<b_rtdx040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx040
            #add-point:BEFORE FIELD b_rtdx040 name="construct.b.page2.b_rtdx040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx040
            
            #add-point:AFTER FIELD b_rtdx040 name="construct.a.page2.b_rtdx040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx040
            #add-point:ON ACTION controlp INFIELD b_rtdx040 name="construct.c.page2.b_rtdx040"
            
            #END add-point
 
 
         #----<<b_rtdx047>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx047
            #add-point:BEFORE FIELD b_rtdx047 name="construct.b.page2.b_rtdx047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx047
            
            #add-point:AFTER FIELD b_rtdx047 name="construct.a.page2.b_rtdx047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx047
            #add-point:ON ACTION controlp INFIELD b_rtdx047 name="construct.c.page2.b_rtdx047"
            
            #END add-point
 
 
         #----<<b_rtdx048>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx048
            #add-point:BEFORE FIELD b_rtdx048 name="construct.b.page2.b_rtdx048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx048
            
            #add-point:AFTER FIELD b_rtdx048 name="construct.a.page2.b_rtdx048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx048
            #add-point:ON ACTION controlp INFIELD b_rtdx048 name="construct.c.page2.b_rtdx048"
            
            #END add-point
 
 
         #----<<b_rtdx045>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx045
            #add-point:BEFORE FIELD b_rtdx045 name="construct.b.page2.b_rtdx045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx045
            
            #add-point:AFTER FIELD b_rtdx045 name="construct.a.page2.b_rtdx045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_rtdx045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx045
            #add-point:ON ACTION controlp INFIELD b_rtdx045 name="construct.c.page2.b_rtdx045"
            
            #END add-point
 
 
         #----<<rtdx045_desc>>----
         #----<<b_imaf112>>----
         #Ctrlp:construct.c.page2.b_imaf112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf112
            #add-point:ON ACTION controlp INFIELD b_imaf112 name="construct.c.page2.b_imaf112"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf112  #顯示到畫面上
            NEXT FIELD b_imaf112                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf112
            #add-point:BEFORE FIELD b_imaf112 name="construct.b.page2.b_imaf112"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf112
            
            #add-point:AFTER FIELD b_imaf112 name="construct.a.page2.b_imaf112"
            
            #END add-point
            
 
 
         #----<<b_imaf112_desc>>----
         #----<<b_imaf113>>----
         #Ctrlp:construct.c.page2.b_imaf113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf113
            #add-point:ON ACTION controlp INFIELD b_imaf113 name="construct.c.page2.b_imaf113"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf113  #顯示到畫面上
            NEXT FIELD b_imaf113                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf113
            #add-point:BEFORE FIELD b_imaf113 name="construct.b.page2.b_imaf113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf113
            
            #add-point:AFTER FIELD b_imaf113 name="construct.a.page2.b_imaf113"
            
            #END add-point
            
 
 
         #----<<b_imaf113_desc>>----
         #----<<b_imaf114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf114
            #add-point:BEFORE FIELD b_imaf114 name="construct.b.page2.b_imaf114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf114
            
            #add-point:AFTER FIELD b_imaf114 name="construct.a.page2.b_imaf114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_imaf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf114
            #add-point:ON ACTION controlp INFIELD b_imaf114 name="construct.c.page2.b_imaf114"
            
            #END add-point
 
 
         #----<<b_imaf115>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf115
            #add-point:BEFORE FIELD b_imaf115 name="construct.b.page2.b_imaf115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf115
            
            #add-point:AFTER FIELD b_imaf115 name="construct.a.page2.b_imaf115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_imaf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf115
            #add-point:ON ACTION controlp INFIELD b_imaf115 name="construct.c.page2.b_imaf115"
            
            #END add-point
 
 
         #----<<b_imaf122>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaf122
            #add-point:BEFORE FIELD b_imaf122 name="construct.b.page2.b_imaf122"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaf122
            
            #add-point:AFTER FIELD b_imaf122 name="construct.a.page2.b_imaf122"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_imaf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf122
            #add-point:ON ACTION controlp INFIELD b_imaf122 name="construct.c.page2.b_imaf122"
            
            #END add-point
 
 
         #----<<rtdxsite_3_desc>>----
         #----<<rtdx001_3_desc>>----
         #----<<rtdx001_3_desc_desc>>----
         #----<<imaa009_3_desc>>----
         #----<<b_rtdx043>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx043
            #add-point:BEFORE FIELD b_rtdx043 name="construct.b.page3.b_rtdx043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx043
            
            #add-point:AFTER FIELD b_rtdx043 name="construct.a.page3.b_rtdx043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_rtdx043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx043
            #add-point:ON ACTION controlp INFIELD b_rtdx043 name="construct.c.page3.b_rtdx043"
            
            #END add-point
 
 
         #----<<b_rtdx006>>----
         #Ctrlp:construct.c.page3.b_rtdx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx006
            #add-point:ON ACTION controlp INFIELD b_rtdx006 name="construct.c.page3.b_rtdx006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa010_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx006  #顯示到畫面上
            NEXT FIELD b_rtdx006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx006
            #add-point:BEFORE FIELD b_rtdx006 name="construct.b.page3.b_rtdx006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx006
            
            #add-point:AFTER FIELD b_rtdx006 name="construct.a.page3.b_rtdx006"
            
            #END add-point
            
 
 
         #----<<b_rtdx007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx007
            #add-point:BEFORE FIELD b_rtdx007 name="construct.b.page3.b_rtdx007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx007
            
            #add-point:AFTER FIELD b_rtdx007 name="construct.a.page3.b_rtdx007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_rtdx007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx007
            #add-point:ON ACTION controlp INFIELD b_rtdx007 name="construct.c.page3.b_rtdx007"
            
            #END add-point
 
 
         #----<<b_rtdx008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx008
            #add-point:BEFORE FIELD b_rtdx008 name="construct.b.page3.b_rtdx008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx008
            
            #add-point:AFTER FIELD b_rtdx008 name="construct.a.page3.b_rtdx008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_rtdx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx008
            #add-point:ON ACTION controlp INFIELD b_rtdx008 name="construct.c.page3.b_rtdx008"
            
            #END add-point
 
 
         #----<<b_rtdx009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx009
            #add-point:BEFORE FIELD b_rtdx009 name="construct.b.page3.b_rtdx009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx009
            
            #add-point:AFTER FIELD b_rtdx009 name="construct.a.page3.b_rtdx009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_rtdx009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx009
            #add-point:ON ACTION controlp INFIELD b_rtdx009 name="construct.c.page3.b_rtdx009"
            
            #END add-point
 
 
         #----<<b_rtdx012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdx012
            #add-point:BEFORE FIELD b_rtdx012 name="construct.b.page3.b_rtdx012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdx012
            
            #add-point:AFTER FIELD b_rtdx012 name="construct.a.page3.b_rtdx012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_rtdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx012
            #add-point:ON ACTION controlp INFIELD b_rtdx012 name="construct.c.page3.b_rtdx012"
            
            #END add-point
 
 
         #----<<b_rtdxstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxstus
            #add-point:BEFORE FIELD b_rtdxstus name="construct.b.page4.b_rtdxstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxstus
            
            #add-point:AFTER FIELD b_rtdxstus name="construct.a.page4.b_rtdxstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page4.b_rtdxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxstus
            #add-point:ON ACTION controlp INFIELD b_rtdxstus name="construct.c.page4.b_rtdxstus"
            
            #END add-point
 
 
         #----<<rtdxsite_4_desc>>----
         #----<<rtdx001_4_desc>>----
         #----<<rtdx001_4_desc_desc>>----
         #----<<b_rtdxownid>>----
         #Ctrlp:construct.c.page4.b_rtdxownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxownid
            #add-point:ON ACTION controlp INFIELD b_rtdxownid name="construct.c.page4.b_rtdxownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxownid  #顯示到畫面上
            NEXT FIELD b_rtdxownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxownid
            #add-point:BEFORE FIELD b_rtdxownid name="construct.b.page4.b_rtdxownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxownid
            
            #add-point:AFTER FIELD b_rtdxownid name="construct.a.page4.b_rtdxownid"
            
            #END add-point
            
 
 
         #----<<b_rtdxownid_desc>>----
         #----<<b_rtdxowndp>>----
         #Ctrlp:construct.c.page4.b_rtdxowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxowndp
            #add-point:ON ACTION controlp INFIELD b_rtdxowndp name="construct.c.page4.b_rtdxowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxowndp  #顯示到畫面上
            NEXT FIELD b_rtdxowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxowndp
            #add-point:BEFORE FIELD b_rtdxowndp name="construct.b.page4.b_rtdxowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxowndp
            
            #add-point:AFTER FIELD b_rtdxowndp name="construct.a.page4.b_rtdxowndp"
            
            #END add-point
            
 
 
         #----<<b_rtdxowndp_desc>>----
         #----<<b_rtdxcrtid>>----
         #Ctrlp:construct.c.page4.b_rtdxcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxcrtid
            #add-point:ON ACTION controlp INFIELD b_rtdxcrtid name="construct.c.page4.b_rtdxcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxcrtid  #顯示到畫面上
            NEXT FIELD b_rtdxcrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxcrtid
            #add-point:BEFORE FIELD b_rtdxcrtid name="construct.b.page4.b_rtdxcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxcrtid
            
            #add-point:AFTER FIELD b_rtdxcrtid name="construct.a.page4.b_rtdxcrtid"
            
            #END add-point
            
 
 
         #----<<b_rtdxcrtid_desc>>----
         #----<<b_rtdxcrtdp>>----
         #Ctrlp:construct.c.page4.b_rtdxcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxcrtdp
            #add-point:ON ACTION controlp INFIELD b_rtdxcrtdp name="construct.c.page4.b_rtdxcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxcrtdp  #顯示到畫面上
            NEXT FIELD b_rtdxcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxcrtdp
            #add-point:BEFORE FIELD b_rtdxcrtdp name="construct.b.page4.b_rtdxcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxcrtdp
            
            #add-point:AFTER FIELD b_rtdxcrtdp name="construct.a.page4.b_rtdxcrtdp"
            
            #END add-point
            
 
 
         #----<<b_rtdxcrtdp_desc>>----
         #----<<b_rtdxcrtdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxcrtdt
            #add-point:BEFORE FIELD b_rtdxcrtdt name="construct.b.page4.b_rtdxcrtdt"
            
            #END add-point
 
 
         #----<<b_rtdxmodid>>----
         #Ctrlp:construct.c.page4.b_rtdxmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxmodid
            #add-point:ON ACTION controlp INFIELD b_rtdxmodid name="construct.c.page4.b_rtdxmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxmodid  #顯示到畫面上
            NEXT FIELD b_rtdxmodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxmodid
            #add-point:BEFORE FIELD b_rtdxmodid name="construct.b.page4.b_rtdxmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtdxmodid
            
            #add-point:AFTER FIELD b_rtdxmodid name="construct.a.page4.b_rtdxmodid"
            
            #END add-point
            
 
 
         #----<<b_rtdxmodid_desc>>----
         #----<<b_rtdxmoddt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtdxmoddt
            #add-point:BEFORE FIELD b_rtdxmoddt name="construct.b.page4.b_rtdxmoddt"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      BEFORE DIALOG
         CALL cl_set_comp_visible("sel",FALSE)
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
 
   #end add-point
        
   LET g_error_show = 1
   CALL artq400_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="artq400.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artq400_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_tmp_sql       STRING   #160107-00016#1 Add By Ken 160108
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtdxsite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   #LET g_wc = g_wc," AND ",l_where
   #160107-00016#1 Add By Ken 160120
   IF g_action_choice = 'query' OR g_action_choice = 'filter' THEN
      LET g_ls_wc = '1'
   END IF
   DISPLAY 'g_action_choice:',g_action_choice
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',rtdxsite,'',rtdx001,'','',rtdx002,'','',rtdx003,rtdx010,rtdx027, 
       rtdx028,'',rtdx029,'',rtdx032,rtdx041,rtdx042,rtdx034,rtdx051,rtdx052,rtdx035,'','','','','', 
       '','','','',rtdx044,'','','','','','','','','','','','','','','','',rtdx004,'',rtdx005,rtdx011, 
       rtdx013,rtdx014,'','','',rtdx053,rtdx054,rtdx016,rtdx101,rtdx020,rtdx021,rtdx017,rtdx018,rtdx019, 
       rtdx102,rtdx103,rtdx046,rtdx022,rtdx023,rtdx024,rtdx025,rtdx026,rtdx036,rtdx037,rtdx038,rtdx039, 
       rtdx040,rtdx047,rtdx048,rtdx045,'','','','','','','','','','','','','','','','',rtdx043,rtdx006, 
       rtdx007,rtdx008,rtdx009,rtdx012,rtdxstus,'','','','','',rtdxownid,'',rtdxowndp,'',rtdxcrtid,'', 
       rtdxcrtdp,'',rtdxcrtdt,rtdxmodid,'',rtdxmoddt  ,DENSE_RANK() OVER( ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001) AS RANK FROM rtdx_t", 
 
 
 
                     " LEFT JOIN imaf_t ON rtdxsite = imafsite AND rtdx001 = imaf001",
                     " WHERE rtdxent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtdx_t"),
                     " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
#160107-00016#1 Add By Ken 160120 標準分頁功能Mark(S)
#LET ls_sql_rank =  "SELECT UNIQUE 'N',          rtdxsite a,   ooefl003,     rtdx001 b,    imaal003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003
#                #"              t2.imaal004,  rtdx002,      rtdx003,      rtdx010,      rtdx027,",    #150602-00074#1--mark by dongsz
#                "              imaal004,     rtdx002,      imaa009,      rtaxl003,     rtdx003,  ", #150602-00074#1--add by dongsz #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal004改imaal004,t19.rtaxl003改rtaxl003
#                "              rtdx010,      rtdx027,      rtdx028,      ",
#                "              (SELECT ooefl003",
#                "                 FROM ooefl_t",
#                "                WHERE ooeflent = rtdxent",       #採購中心
#                "                  AND ooefl001 = rtdx028",
#                "                  AND ooefl002 = '",g_dlang,"') rtdx028_desc,",
#                "              rtdx029,      ",
#                "              (SELECT ooefl003",
#                "                 FROM ooefl_t",
#                "                WHERE ooeflent = rtdxent",      #配送中心
#                "                  AND ooefl001 = rtdx029",
#                "                  AND ooefl002 = '",g_dlang,"') rtdx029_desc,",
#                "              rtdx032,      rtdx041,      rtdx042,      rtdx034,      rtdx051, rtdx052, ", #20150925 dongsz add rtdx051,rtdx052
#                "              rtdx035,      t17.oodbl004, t17.oodb006,  t17.oodb005,  imaf143, ",
#                "              (SELECT oocal003",
#                "                 FROM oocal_t",
#                "                WHERE oocalent = imafent",     #採購單位
#                "                  AND oocal001 = imaf143",
#                "                  AND oocal002 = '",g_dlang,"') imaf143_desc,",
#                "              imaf144,",
#                "              (SELECT oocal003",
#                "                 FROM oocal_t",
#                "                WHERE oocalent = imafent",     #採購計價單位
#                "                  AND oocal001 = imaf144",
#                "                  AND oocal002 = '",g_dlang,"') imaf144_desc,",
#                "              imaf145,      imaf146,      rtdx044,",
#                "              (SELECT inayl003",
#                "                 FROM inayl_t",
#                "                WHERE inaylent = rtdxent",     #庫位
#                "                  AND inayl001 = rtdx044",
#                "                  AND inayl002 = '",g_dlang,"') rtdx044_desc,",
#                "              imaf153,",
#                "              (SELECT pmaal004",
#                "                 FROM pmaal_t",
#                "                WHERE pmaalent = imafent",     #主要供應商
#                "                  AND pmaal001 = imaf153",
#                "                  AND pmaal002 = '",g_dlang,"') imaf153_desc,",
#                "              imaf147,      imaf152,      imaf158,      imaf164,      imaf166, ",
#                "              rtdxsite rtdxsite_2,     ooefl003 ooefl003_2,     rtdx001 rtdx001_2,      imaal003 imaal003_2,     imaal004 imaal004_2, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003,t2.imaal004 改imaal004 ,t2.imaal003改imaal003
#                "              rtdx002 rtdx002_2,      imaa009 imaa009_2,      rtaxl003 rtaxl003_2,     rtdx004, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
#                "              (SELECT oocal003",
#                "                 FROM oocal_t",
#                "                WHERE oocalent = rtdxent",      #包裝單位
#                "                  AND oocal001 = rtdx004",
#                "                  AND oocal002 = '",g_dlang,"') rtdx004_desc,",#150602-00074#1--add by dongsz                
#                "              rtdx005,      rtdx011,      rtdx013,      rtdx014,      t16.oodbl004 oodbl004_2, ",
#                "              t16.oodb006 oodb006_2,  t16.oodb005 oodb005_2,  rtdx053,   rtdx054,  rtdx016,      rtdx017,      rtdx018, ",  #20151113 dongsz add rtdx053,rtdx054
#                "              rtdx019,      rtdx020,      rtdx021,      rtdx046,      rtdx022, ", #150616-00035#2--add by geza rtdx046
#                "              rtdx023,      rtdx024,      rtdx025,      rtdx026,      rtdx036, ",
#                "              rtdx037,      rtdx038,      rtdx039,      rtdx040,      rtdx047, rtdx048, rtdx045, ",   #20151105 dongsz add rtdx047,rtdx048
#                #150923-00001#1 Add By Ken 151001(s) 取促銷扣率
#                "              (SELECT stbi017 ",
#                "                 FROM stbi_t,stbh_t ",
#                "                WHERE stbient = stbhent ",
#                "                  AND stbidocno = stbhdocno ",
#                "                  AND stbisite = stbhsite ",
#                "                  AND stbient = rtdxent ",
#                "                  AND stbisite = rtdxsite ",
#                "                  AND stbi001 = rtdx001 ",
#                "                  AND stbh002 = imaf153 ",
#                "                  AND stbh003 = rtdx003 ",
#                "                  AND stbi011 <= '",g_today,"'",
#                "                  AND stbi012 >= '",g_today,"'",
#                "                  AND stbh003 = '3' ",
#                "                  AND stbhstus = 'Y') stbi017, ",
#                "              imaf112,",
#                "              (SELECT oocal003",   #150616-00035#12 add rtdx045,'' by yangxf
#                "                 FROM oocal_t",
#                "                WHERE oocalent = imafent",     #銷售單位
#                "                  AND oocal001 = imaf112",
#                "                  AND oocal002 = '",g_dlang,"') imaf112_desc,",
#                "              imaf113,",
#                "              (SELECT oocal003",
#                "                 FROM oocal_t",
#                "                WHERE oocalent = imafent",     #銷售計價單位
#                "                  AND oocal001 = imaf113",
#                "                  AND oocal002 = '",g_dlang,"') imaf113_desc,",
#                "              imaf114,      imaf115,      imaf122,      rtdxsite rtdxsite_3,     ooefl003 ooefl003_3, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003,t2.imaal004改imaal004
#                "              rtdx001 rtdx001_3,      imaal003 imaal003_3,     imaal004 imaal004_3,     rtdx002 rtdx002_3,      imaa009 imaa009_3, ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
#                "              rtaxl003 rtaxl003_3,     rtdx043,      rtdx006,      rtdx007,      rtdx008,",   #150602-00074#1--add dongsz  #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
#                "              rtdx009,      rtdx012,      rtdxstus,     rtdxsite rtdxsite_4,     ooefl003 ooefl003_4,",  #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 
#                "              rtdx001 rtdx001_4,      imaal003 imaal003_4,     imaal004 imaal004_4,     rtdxownid,    ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
#                "              (SELECT ooag011",
#                "                 FROM ooag_t",
#                "                WHERE ooagent = rtdxent",        #資料所有者
#                "                  AND ooag001 = rtdxownid) rtdxownid_desc,",
#                "              rtdxowndp,",
#                "              (SELECT ooefl003",
#                "                 FROM ooefl_t",
#                "                WHERE  ooeflent = rtdxent",      #資料所屬部門
#                "                  AND ooefl001 = rtdxowndp",
#                "                  AND ooefl002 = '",g_dlang,"') rtdxowndp_desc,",
#                "              rtdxcrtid,",
#                "              (SELECT ooag011",
#                "                 FROM ooag_t",
#                "                WHERE ooagent = rtdxent",        #資料建立者
#                "                  AND ooag001 = rtdxcrtid) rtdxcrtid_desc,",
#                "              rtdxcrtdp,",
#                "              (SELECT ooefl003",
#                "                 FROM ooefl_t",
#                "                WHERE ooeflent = rtdxent",      #資料建立部門
#                "                  AND ooefl001 = rtdxcrtdp",
#                "                  AND ooefl002 = '",g_dlang,"') rtdxcrtdp_desc,",
#                "              rtdxcrtdt,    rtdxmodid,",
#                "              (SELECT ooag011",
#                "                 FROM ooag_t",
#                "                WHERE ooagent = rtdxent",      #資料修改者
#                "                  AND ooag001 = rtdxmodid) rtdxmodid_desc,",
#                "              rtdxmoddt ,DENSE_RANK() OVER( ORDER BY rtdxsite,rtdx001) AS RANK",
#                "         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   imaa009,   rtdx003,   rtdx010,",   #150602-00074#1--add by dongsz
#                "                      rtdx027,   rtdx028,   rtdx029,   rtdx032,   rtdx041,",
#                "                      rtdx042,   rtdx034,   rtdx051,   rtdx052,   rtdx035,   imaf143,   imaf144,",   #20150925 dongsz add rtdx051,rtdx052
#                "                      imaf145,   imaf146,   rtdx044,   imaf153,   imaf147,",
#                "                      imaf152,   imaf158,   imaf164,   imaf166,   rtdx004,",    
#                "                      rtdx005,   rtdx011,   rtdx013,   rtdx014,   rtdx053, rtdx054, rtdx016,",  #20151113 dongsz add rtdx053,rtdx054
#                "                      rtdx017,   rtdx018,   rtdx019,   rtdx020,   rtdx021, rtdx046,", #150616-00035#2--add by geza rtdx046
#                "                      rtdx022,   rtdx023,   rtdx024,   rtdx025,   rtdx026,",
#                "                      rtdx036,   rtdx037,   rtdx038,   rtdx039,   rtdx040,rtdx047,rtdx048,rtdx045,'',",   #add by yangxf rtdx045,''  #20151105 dongsz add rtdx047,rtdx048
#                "                      imaf112,   imaf113,   imaf114,   imaf115,   imaf122,",
#                "                      rtdx043,   rtdx006,   rtdx007,   rtdx008,   rtdx009,",
#                "                      rtdx012,   rtdxstus,  rtdxownid, rtdxowndp, rtdxcrtid,",
#                "                      rtdxcrtdp, rtdxcrtdt, rtdxmodid, rtdxmoddt, imafent,",
#                "                      rtdxent,   imaaent,   ooef019,",    #150602-00074#1--add by dongsz
#                "                      (SELECT rtaxl003 FROM  rtaxl_t ",
#                "                        WHERE rtaxlent = imaaent ",
#                "                          AND rtaxl001 = imaa009 ",
#                "                          AND rtaxl002 = '",g_dlang,"')rtaxl003, ",
#                "                      (SELECT ooefl003 FROM ooefl_t t1 ",
#                "                        WHERE t1.ooeflent = rtdxent ",
#                "                          AND t1.ooefl001 = rtdxsite ",
#                "                          AND t1.ooefl002 = '",g_dlang,"') ooefl003, ",
#                "                      (SELECT imaal003 FROM imaal_t t2 ",
#                "                        WHERE t2.imaalent = rtdxent ",
#                "                          AND t2.imaal001 = rtdx001 ",
#                "                          AND t2.imaal002 = '",g_dlang,"') imaal003, ",
#                "                      (SELECT imaal004 FROM imaal_t t3 ",
#                "                        WHERE t3.imaalent = rtdxent ",
#                "                          AND t3.imaal001 = rtdx001 ",
#                "                          AND t3.imaal002 = '",g_dlang,"') imaal004 ",
#                "                 FROM rtdx_t, imaa_t, imaf_t, ooef_t ",   #150602-00074#1--add by dongsz       
#                "                WHERE imafent = rtdxent",
#                "                      AND imafsite = rtdxsite",
#                "                      AND imaf001 = rtdx001",
#                "                      AND ooefent = rtdxent",
#                "                      AND ooef001 = rtdxsite",
#                "                      AND rtdxent = imaaent AND rtdx001 = imaa001 ",   #150602-00074#1--add by dongsz
#                "                      AND rtdxent = ?",
#                "                      AND ",ls_wc,cl_sql_add_filter("rtdx_t"),")",
#                "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
#                "                                 (SELECT oodbl004 FROM oodbl_t ",  #銷項稅別
#                "                                   WHERE oodbent = oodblent",
#                "                                                   AND oodb001 = oodbl001",
#                "                                                   AND oodb002 = oodbl002",
#                "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
#                "                    FROM oodb_t) t16 ",
#                "                      ON t16.oodbent = rtdxent",
#                "                     AND t16.oodb001 = ooef019",
#                "                     AND t16.oodb002 = rtdx014",
#                "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
#                "                                 (SELECT oodbl004 FROM oodbl_t ",  #進項稅別
#                "                                   WHERE oodbent = oodblent",
#                "                                                   AND oodb001 = oodbl001",
#                "                                                   AND oodb002 = oodbl002",
#                "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
#                "                    FROM oodb_t) t17 ",
#                "                      ON t17.oodbent = rtdxent",
#                "                     AND t17.oodb001 = ooef019",
#                "                     AND t17.oodb002 = rtdx035",
#                " ORDER BY a,b"             
#   
#   DISPLAY 'ls_sql_rank:',ls_sql_rank
   #160107-00016#1 Add By Ken 160120 標準分頁功能Mark(E)
   
   
   #160107-00016#1 Add By Ken 160108(S)
   
   #LET ls_sql_rank =  "SELECT UNIQUE 'N',          rtdxsite a,   ooefl003,     rtdx001 b,    imaal003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003
   LET l_tmp_sql=" INSERT INTO artq400_tmp01( ",           #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
                 "        sel,              rtdxsite,          rtdxsite_desc,       rtdx001,           rtdx001_desc, ",
                 "        rtdx001_desc_desc,rtdx002,           imaa009,             imaa009_desc,      rtdx003,      ",
                 "        rtdx010,          rtdx027,           rtdx028,             rtdx028_desc,      rtdx029,      ",
                 "        rtdx029_desc,     rtdx032,           rtdx041,             rtdx042,           rtdx034,      ",
                 "        rtdx051,          rtdx052,           rtdx035,             rtdx035_desc,      l_rtdx035_oodb006, l_rtdx035_oodb005, ",
                 "        imaf143,          imaf143_desc,      imaf144,             imaf144_desc,      imaf145,      ",
                 "        imaf146,          rtdx044,           rtdx044_desc,        imaf153,           imaf153_desc, ",
                 "        imaf147,          imaf152,           imaf158,             imaf164,           imaf166,      ",
                 "        rtdxsite2,        rtdxsite_2_desc,   rtdx001_2,           rtdx001_2_desc,    rtdx001_2_desc_desc, ",
                 "        rtdx002_2,        imaa009_2,         imaa009_2_desc,      rtdx004,           rtdx004_desc, ",
                 "        rtdx005,          rtdx011,           rtdx013,             rtdx014,           rtdx014_desc, ",
                 "        l_rtdx014_oodb006,l_rtdx014_oodb005, rtdx053,             rtdx054,           rtdx016,      ",
                 "        rtdx101,          rtdx020,           rtdx021,             rtdx017,           rtdx018,      ",  #160506-00009#14 Add By Ken 160512 加rtdx101
                 "        rtdx019,          rtdx102,           rtdx103,             rtdx046,           rtdx022,      ",  #160506-00009#14 Add By Ken 160512 加rtdx102,rtdx103
                 "        rtdx023,          rtdx024,           rtdx025,             rtdx026,           rtdx036,      ",
                 "        rtdx037,          rtdx038,           rtdx039,             rtdx040,           rtdx047,     rtdx048,      rtdx045,      ",
                 "        rtdx045_desc,     imaf112,           imaf112_desc,        imaf113,           imaf113_desc, ",
                 "        imaf114,          imaf115,           imaf122,             rtdxsite3,         rtdxsite_3_desc, ",
                 "        rtdx001_3,        rtdx001_3_desc,    rtdx001_3_desc_desc, rtdx002_3,         imaa009_3,      ",
                 "        imaa009_3_desc,   rtdx043,           rtdx006,             rtdx007,           rtdx008,      ",
                 "        rtdx009,          rtdx012,           rtdxstus,            rtdxsite4,         rtdxsite_4_desc, ",
                 "        rtdx001_4,        rtdx001_4_desc,    rtdx001_4_desc_desc, rtdxownid,         rtdxownid_desc, ",
                 "        rtdxowndp,        rtdxowndp_desc,    rtdxcrtid,           rtdxcrtid_desc,    rtdxcrtdp,    ",
                 "        rtdxcrtdp_desc,   rtdxcrtdt,         rtdxmodid,           rtdxmodid_desc,    rtdxmoddt,    ",
                 "        RANK,             rtdxent ",
                 " ) ",
                 " SELECT UNIQUE 'N',          rtdxsite a,   ooefl003,     rtdx001 b,    imaal003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003
                 "              imaal004,     rtdx002,      imaa009,      rtaxl003,     rtdx003,  ", #150602-00074#1--add by dongsz #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal004改imaal004,t19.rtaxl003改rtaxl003
                 "              rtdx010,      rtdx027,      rtdx028,      ",
                 "              (SELECT ooefl003",
                 "                 FROM ooefl_t",
                 "                WHERE ooeflent = rtdxent",       #採購中心
                 "                  AND ooefl001 = rtdx028",
                 "                  AND ooefl002 = '",g_dlang,"') rtdx028_desc,",
                 "              rtdx029,      ",
                 "              (SELECT ooefl003",
                 "                 FROM ooefl_t",
                 "                WHERE ooeflent = rtdxent",      #配送中心
                 "                  AND ooefl001 = rtdx029",
                 "                  AND ooefl002 = '",g_dlang,"') rtdx029_desc,",
                 "              rtdx032,      rtdx041,      rtdx042,      rtdx034,      rtdx051,   rtdx052, ", #20150925 dongsz add rtdx051
                 "              rtdx035,      t17.oodbl004, t17.oodb006,  t17.oodb005,  imaf143, ",
                 "              (SELECT oocal003",
                 "                 FROM oocal_t",
                 "                WHERE oocalent = imafent",     #採購單位
                 "                  AND oocal001 = imaf143",
                 "                  AND oocal002 = '",g_dlang,"') imaf143_desc,",
                 "              imaf144,",
                 "              (SELECT oocal003",
                 "                 FROM oocal_t",
                 "                WHERE oocalent = imafent",     #採購計價單位
                 "                  AND oocal001 = imaf144",
                 "                  AND oocal002 = '",g_dlang,"') imaf144_desc,",
                 "              imaf145,      imaf146,      rtdx044,",
                 "              (SELECT inayl003",
                 "                 FROM inayl_t",
                 "                WHERE inaylent = rtdxent",     #庫位
                 "                  AND inayl001 = rtdx044",
                 "                  AND inayl002 = '",g_dlang,"') rtdx044_desc,",
                 "              imaf153,",
                 "              (SELECT pmaal004",
                 "                 FROM pmaal_t",
                 "                WHERE pmaalent = imafent",     #主要供應商
                 "                  AND pmaal001 = imaf153",
                 "                  AND pmaal002 = '",g_dlang,"') imaf153_desc,",
                 "              imaf147,      imaf152,      imaf158,      imaf164,      imaf166, ",
                 "              rtdxsite,     ooefl003,     rtdx001,      imaal003,     imaal004, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003,t2.imaal004 改imaal004 ,t2.imaal003改imaal003
                 "              rtdx002,      imaa009,      rtaxl003,     rtdx004, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
                 "              (SELECT oocal003",
                 "                 FROM oocal_t",
                 "                WHERE oocalent = rtdxent",      #包裝單位
                 "                  AND oocal001 = rtdx004",
                 "                  AND oocal002 = '",g_dlang,"') rtdx004_desc,",#150602-00074#1--add by dongsz                
                 "              rtdx005,      rtdx011,      rtdx013,      rtdx014,      t16.oodbl004, ",
                 "              t16.oodb006,  t16.oodb005,  rtdx053,      rtdx054,      rtdx016, ",
                 "              rtdx101,      rtdx020,      rtdx021,      rtdx017,      rtdx018, ", #160506-00009#14 Add By Ken 160512 加rtdx101,rtdx102,rtdx103
                 "              rtdx019,      rtdx102,      rtdx103,      rtdx046,      rtdx022, ", #150616-00035#2--add by geza rtdx046
                 "              rtdx023,      rtdx024,      rtdx025,      rtdx026,      rtdx036, ",
                 "              rtdx037,      rtdx038,      rtdx039,      rtdx040,      rtdx047,      rtdx048,      rtdx045, ",
                 #150923-00001#1 Add By Ken 151001(s) 取促銷扣率
                 "              (SELECT stbi017 ",
                 "                 FROM stbi_t,stbh_t ",
                 "                WHERE stbient = stbhent ",
                 "                  AND stbidocno = stbhdocno ",
                 "                  AND stbisite = stbhsite ",
                 "                  AND stbient = rtdxent ",
                 "                  AND stbisite = rtdxsite ",
                 "                  AND stbi001 = rtdx001 ",
                 "                  AND stbh002 = imaf153 ",
                 "                  AND stbh003 = rtdx003 ",
                 "                  AND stbi011 <= '",g_today,"'",
                 "                  AND stbi012 >= '",g_today,"'",
                 "                  AND stbh003 = '3' ",
                 "                  AND stbhstus = 'Y') stbi017, ",
                 #150923-00001#1 Add By Ken 151001(e)
                 "              imaf112,",
                 "              (SELECT oocal003",   #150616-00035#12 add rtdx045,'' by yangxf
                 "                 FROM oocal_t",
                 "                WHERE oocalent = imafent",     #銷售單位
                 "                  AND oocal001 = imaf112",
                 "                  AND oocal002 = '",g_dlang,"') imaf112_desc,",
                 "              imaf113,",
                 "              (SELECT oocal003",
                 "                 FROM oocal_t",
                 "                WHERE oocalent = imafent",     #銷售計價單位
                 "                  AND oocal001 = imaf113",
                 "                  AND oocal002 = '",g_dlang,"') imaf113_desc,",
                 "              imaf114,      imaf115,      imaf122,      rtdxsite,     ooefl003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003,t2.imaal004改imaal004
                 "              rtdx001,      imaal003,     imaal004,     rtdx002,      imaa009, ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
                 "              rtaxl003,     rtdx043,      rtdx006,      rtdx007,      rtdx008,",   #150602-00074#1--add dongsz  #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
                 "              rtdx009,      rtdx012,      rtdxstus,     rtdxsite,     ooefl003,",  #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 
                 "              rtdx001,      imaal003,     imaal004,     rtdxownid,    ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
                 "              (SELECT ooag011",
                 "                 FROM ooag_t",
                 "                WHERE ooagent = rtdxent",        #資料所有者
                 "                  AND ooag001 = rtdxownid) rtdxownid_desc,",
                 "              rtdxowndp,",
                 "              (SELECT ooefl003",
                 "                 FROM ooefl_t",
                 "                WHERE  ooeflent = rtdxent",      #資料所屬部門
                 "                  AND ooefl001 = rtdxowndp",
                 "                  AND ooefl002 = '",g_dlang,"') rtdxowndp_desc,",
                 "              rtdxcrtid,",
                 "              (SELECT ooag011",
                 "                 FROM ooag_t",
                 "                WHERE ooagent = rtdxent",        #資料建立者
                 "                  AND ooag001 = rtdxcrtid) rtdxcrtid_desc,",
                 "              rtdxcrtdp,",
                 "              (SELECT ooefl003",
                 "                 FROM ooefl_t",
                 "                WHERE ooeflent = rtdxent",      #資料建立部門
                 "                  AND ooefl001 = rtdxcrtdp",
                 "                  AND ooefl002 = '",g_dlang,"') rtdxcrtdp_desc,",
                 "              rtdxcrtdt,    rtdxmodid,",
                 "              (SELECT ooag011",
                 "                 FROM ooag_t",
                 "                WHERE ooagent = rtdxent",      #資料修改者
                 "                  AND ooag001 = rtdxmodid) rtdxmodid_desc,",
                 "              rtdxmoddt,",
                 "              DENSE_RANK() OVER( ORDER BY rtdxsite,rtdx001) AS RANK, ",
                 "              rtdxent ",
                 "         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   imaa009,   rtdx003,   rtdx010,",   #150602-00074#1--add by dongsz
                 "                      rtdx027,   rtdx028,   rtdx029,   rtdx032,   rtdx041,",
                 "                      rtdx042,   rtdx034,   rtdx051,   rtdx052,   rtdx035,   imaf143,   imaf144,",   #20150925 dongsz add rtdx051
                 "                      imaf145,   imaf146,   rtdx044,   imaf153,   imaf147,",
                 "                      imaf152,   imaf158,   imaf164,   imaf166,   rtdx004,",    
                 "                      rtdx005,   rtdx011,   rtdx013,   rtdx014,   rtdx053,   rtdx054,   rtdx016,",
                 "                      rtdx101,   rtdx020,   rtdx021,   rtdx017,   rtdx018,  ",  #160506-00009#14 Add By Ken 160512 加rtdx101,rtdx102,rtdx103
                 "                      rtdx019,   rtdx102,   rtdx103,   rtdx046,",               #150616-00035#2--add by geza rtdx046
                 "                      rtdx022,   rtdx023,   rtdx024,   rtdx025,   rtdx026,",
                 "                      rtdx036,   rtdx037,   rtdx038,   rtdx039,   rtdx040,   rtdx047,   rtdx048,   rtdx045,'',",       #add by yangxf rtdx045,''
                 "                      imaf112,   imaf113,   imaf114,   imaf115,   imaf122,",
                 "                      rtdx043,   rtdx006,   rtdx007,   rtdx008,   rtdx009,",
                 "                      rtdx012,   rtdxstus,  rtdxownid, rtdxowndp, rtdxcrtid,",
                 "                      rtdxcrtdp, rtdxcrtdt, rtdxmodid, rtdxmoddt, imafent,",
                 "                      rtdxent,   imaaent,   ooef019,",    #150602-00074#1--add by dongsz
                 "                      (SELECT rtaxl003 FROM  rtaxl_t ",
                 "                        WHERE rtaxlent = imaaent ",
                 "                          AND rtaxl001 = imaa009 ",
                 "                          AND rtaxl002 = '",g_dlang,"')rtaxl003, ",
                 "                      (SELECT ooefl003 FROM ooefl_t t1 ",
                 "                        WHERE t1.ooeflent = rtdxent ",
                 "                          AND t1.ooefl001 = rtdxsite ",
                 "                          AND t1.ooefl002 = '",g_dlang,"') ooefl003, ",
                 "                      (SELECT imaal003 FROM imaal_t t2 ",
                 "                        WHERE t2.imaalent = rtdxent ",
                 "                          AND t2.imaal001 = rtdx001 ",
                 "                          AND t2.imaal002 = '",g_dlang,"') imaal003, ",
                 "                      (SELECT imaal004 FROM imaal_t t3 ",
                 "                        WHERE t3.imaalent = rtdxent ",
                 "                          AND t3.imaal001 = rtdx001 ",
                 "                          AND t3.imaal002 = '",g_dlang,"') imaal004 ",
                 "                 FROM rtdx_t, imaa_t, imaf_t, ooef_t ",   #150602-00074#1--add by dongsz       
                 "                WHERE imafent = rtdxent",
                 "                      AND imafsite = rtdxsite",
                 "                      AND imaf001 = rtdx001",
                 "                      AND ooefent = rtdxent",
                 "                      AND ooef001 = rtdxsite",
                 "                      AND rtdxent = imaaent AND rtdx001 = imaa001 ",   #150602-00074#1--add by dongsz
                 "                      AND rtdxent = ?",
                 "                      AND ",l_where ,
                 "                      AND ",ls_wc,cl_sql_add_filter("rtdx_t"),")",
                 "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
                 "                                 (SELECT oodbl004 FROM oodbl_t ",  #銷項稅別
                 "                                   WHERE oodbent = oodblent",
                 "                                                   AND oodb001 = oodbl001",
                 "                                                   AND oodb002 = oodbl002",
                 "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
                 "                    FROM oodb_t) t16 ",
                 "                      ON t16.oodbent = rtdxent",
                 "                     AND t16.oodb001 = ooef019",
                 "                     AND t16.oodb002 = rtdx014",
                 "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
                 "                                 (SELECT oodbl004 FROM oodbl_t ",  #進項稅別
                 "                                   WHERE oodbent = oodblent",
                 "                                                   AND oodb001 = oodbl001",
                 "                                                   AND oodb002 = oodbl002",
                 "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
                 "                    FROM oodb_t) t17 ",
                 "                      ON t17.oodbent = rtdxent",
                 "                     AND t17.oodb001 = ooef019",
                 "                     AND t17.oodb002 = rtdx035",
                 " ORDER BY a,b"  
   #DISPLAY "ls_sql_rank:",ls_sql_rank
   #存到tmp table 
   IF (ls_wc != g_ls_wc) THEN #Add By ken 150916 如查詢條件不變只做切換頁，主要頁面資料不需重新查詢
      DROP INDEX artq400_rtdx_tmp_idx      
      
      DELETE FROM artq400_tmp01         #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
      #LET l_tmp_sql = " INSERT INTO artq400_rtdx_tmp ",ls_sql_rank
      PREPARE artq400_rtdx_tmp_ins FROM l_tmp_sql
      EXECUTE artq400_rtdx_tmp_ins USING g_enterprise
      
   
      #CREATE INDEX citq100_deba_tmp ON deba_tmp(debaent,debasite,deba001,deba053,deba010,deba009,
                                                #deba011,deba012,deba043,deba013,deba016,deba020)       
   END IF
   
   
   LET ls_sql_rank = " SELECT rtdx001 ",
                     "   FROM artq400_tmp01 ",        #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
                     "  WHERE rtdxent = ? "
   #160107-00016#1 Add By Ken 160108
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',rtdxsite,'',rtdx001,'','',rtdx002,'','',rtdx003,rtdx010,rtdx027,rtdx028,'', 
       rtdx029,'',rtdx032,rtdx041,rtdx042,rtdx034,rtdx051,rtdx052,rtdx035,'','','','','','','','','', 
       rtdx044,'','','','','','','','','','','','','','','','',rtdx004,'',rtdx005,rtdx011,rtdx013,rtdx014, 
       '','','',rtdx053,rtdx054,rtdx016,rtdx101,rtdx020,rtdx021,rtdx017,rtdx018,rtdx019,rtdx102,rtdx103, 
       rtdx046,rtdx022,rtdx023,rtdx024,rtdx025,rtdx026,rtdx036,rtdx037,rtdx038,rtdx039,rtdx040,rtdx047, 
       rtdx048,rtdx045,'','','','','','','','','','','','','','','','',rtdx043,rtdx006,rtdx007,rtdx008, 
       rtdx009,rtdx012,rtdxstus,'','','','','',rtdxownid,'',rtdxowndp,'',rtdxcrtid,'',rtdxcrtdp,'',rtdxcrtdt, 
       rtdxmodid,'',rtdxmoddt",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160107-00016#1 Add By Ken 160108(S) 
   #LET ls_sql_rank = " SELECT sel,              rtdxsite,          rtdxsite_desc,       rtdx001,           rtdx001_desc, ",
   #                  "        rtdx001_desc_desc,rtdx002,           imaa009,             imaa009_desc,      rtdx003,      ",
   #                  "        rtdx010,          rtdx027,           rtdx028,             rtdx028_desc,      rtdx029,      ",
   #                  "        rtdx029_desc,     rtdx032,           rtdx041,             rtdx042,           rtdx034,      ",
   #                  "        rtdx051,          rtdx052,           rtdx035,             rtdx035_desc,      l_rtdx035_oodb006, l_rtdx035_oodb005, ",
   #                  "        imaf143,          imaf143_desc,      imaf144,             imaf144_desc,      imaf145,      ",
   #                  "        imaf146,          rtdx044,           rtdx044_desc,        imaf153,           imaf153_desc, ",
   #                  "        imaf147,          imaf152,           imaf158,             imaf164,           imaf166,      ",
   #                  "        rtdxsite2,        rtdxsite_2_desc,   rtdx001_2,           rtdx001_2_desc,    rtdx001_2_desc_desc, ",
   #                  "        rtdx002_2,        imaa009_2,         imaa009_2_desc,      rtdx004,           rtdx004_desc, ",
   #                  "        rtdx005,          rtdx011,           rtdx013,             rtdx014,           rtdx014_desc, ",
   #                  "        l_rtdx014_oodb006,l_rtdx014_oodb005, rtdx053,             rtdx054,           rtdx016,             rtdx017,           rtdx018,      ",
   #                  "        rtdx019,          rtdx020,           rtdx021,             rtdx046,           rtdx022,      ",
   #                  "        rtdx023,          rtdx024,           rtdx025,             rtdx026,           rtdx036,      ",
   #                  "        rtdx037,          rtdx038,           rtdx039,             rtdx040,           rtdx047,     rtdx048,      rtdx045,      ",
   #                  "        rtdx045_desc,     imaf112,           imaf112_desc,        imaf113,           imaf113_desc, ",
   #                  "        imaf114,          imaf115,           imaf122,             rtdxsite3,         rtdxsite_3_desc, ",
   #                  "        rtdx001_3,        rtdx001_3_desc,    rtdx001_3_desc_desc, rtdx002_3,         imaa009_3,      ",
   #                  "        imaa009_3_desc,   rtdx043,           rtdx006,             rtdx007,           rtdx008,      ",
   #                  "        rtdx009,          rtdx012,           rtdxstus,            rtdxsite4,         rtdxsite_4_desc, ",
   #                  "        rtdx001_4,        rtdx001_4_desc,    rtdx001_4_desc_desc, rtdxownid,         rtdxownid_desc, ",
   #                  "        rtdxowndp,        rtdxowndp_desc,    rtdxcrtid,           rtdxcrtid_desc,    rtdxcrtdp,    ",
   #                  "        rtdxcrtdp_desc,   rtdxcrtdt,         rtdxmodid,           rtdxmodid_desc,    rtdxmoddt,    ",
   #                  "        RANK,             rtdxent ",
   #                  "   FROM artq400_rtdx_tmp ",
   #                  "  WHERE rtdxent = ? "                                         
   
   LET g_sql = " SELECT sel,              rtdxsite,          rtdxsite_desc,       rtdx001,           rtdx001_desc, ",
               "        rtdx001_desc_desc,rtdx002,           imaa009,             imaa009_desc,      rtdx003,      ",
               "        rtdx010,          rtdx027,           rtdx028,             rtdx028_desc,      rtdx029,      ",
               "        rtdx029_desc,     rtdx032,           rtdx041,             rtdx042,           rtdx034,      ",
               "        rtdx051,          rtdx052,           rtdx035,             rtdx035_desc,      l_rtdx035_oodb006, l_rtdx035_oodb005, ",
               "        imaf143,          imaf143_desc,      imaf144,             imaf144_desc,      imaf145,      ",
               "        imaf146,          rtdx044,           rtdx044_desc,        imaf153,           imaf153_desc, ",
               "        imaf147,          imaf152,           imaf158,             imaf164,           imaf166,      ",
               "        rtdxsite2,        rtdxsite_2_desc,   rtdx001_2,           rtdx001_2_desc,    rtdx001_2_desc_desc, ",
               "        rtdx002_2,        imaa009_2,         imaa009_2_desc,      rtdx004,           rtdx004_desc, ",
               "        rtdx005,          rtdx011,           rtdx013,             rtdx014,           rtdx014_desc, ",
               "        l_rtdx014_oodb006,l_rtdx014_oodb005, rtdx053,             rtdx054,           rtdx016,      ",
               "        rtdx101,          rtdx020,           rtdx021,             rtdx017,           rtdx018,      ", #160506-00009#14 Add By Ken 160512 加rtdx101
               "        rtdx019,          rtdx102,           rtdx103,             rtdx046,           rtdx022,      ", #160506-00009#14 Add By Ken 160512 加rtdx102,rtdx103
               "        rtdx023,          rtdx024,           rtdx025,             rtdx026,           rtdx036,      ",
               "        rtdx037,          rtdx038,           rtdx039,             rtdx040,           rtdx047,     rtdx048,      rtdx045,      ",
               "        rtdx045_desc,     imaf112,           imaf112_desc,        imaf113,           imaf113_desc, ",
               "        imaf114,          imaf115,           imaf122,             rtdxsite3,         rtdxsite_3_desc, ",
               "        rtdx001_3,        rtdx001_3_desc,    rtdx001_3_desc_desc, rtdx002_3,         imaa009_3,      ",
               "        imaa009_3_desc,   rtdx043,           rtdx006,             rtdx007,           rtdx008,      ",
               "        rtdx009,          rtdx012,           rtdxstus,            rtdxsite4,         rtdxsite_4_desc, ",
               "        rtdx001_4,        rtdx001_4_desc,    rtdx001_4_desc_desc, rtdxownid,         rtdxownid_desc, ",
               "        rtdxowndp,        rtdxowndp_desc,    rtdxcrtid,           rtdxcrtid_desc,    rtdxcrtdp,    ",
               "        rtdxcrtdp_desc,   rtdxcrtdt,         rtdxmodid,           rtdxmodid_desc,    rtdxmoddt    ",
               #"   FROM (",ls_sql_rank,")",
               "   FROM artq400_tmp01 ",          #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
               "  WHERE rtdxent = ? ",
               "    AND RANK >= ",g_pagestart,               
               "    AND RANK < ",g_pagestart + g_num_in_page      
   #160107-00016#1 Add By Ken 160108(E)   
   
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)
   #LET g_sql = "SELECT UNIQUE 'N',         rtdxsite,    t1.ooefl003, rtdx001,",
   #            "              t2.imaal003, t2.imaal004, rtdx002,     rtdx003,",
   #            "              rtdx010,     rtdx027,     rtdx028,     t3.ooefl003,",
   #            "              rtdx029,     t4.ooefl003, rtdx032,     rtdx034,",
   #            "              rtdx035,     '',          '',          '',",
   #            "              imaf143,     '',          imaf144,     '',",
   #            "              imaf145,     imaf146,     imaf153,     '',",
   #            "              imaf147,     imaf152,     imaf158,     imaf164,",
   #            "              imaf166,     rtdxsite,    t1.ooefl003, rtdx001,",
   #            "              t2.imaal003, t2.imaal004, rtdx002,     rtdx004,",
   #            "              t5.oocal003, rtdx005,     rtdx011,     rtdx013,",
   #            "              rtdx014,     '',          '',          '',",
   #            "              rtdx016,     rtdx017,     rtdx018,     rtdx019,",
   #            "              rtdx020,     rtdx021,     rtdx022,     rtdx023,",
   #            "              rtdx024,     rtdx025,     rtdx026,     rtdx036,",
   #            "              rtdx037,     rtdx038,     rtdx039,     rtdx040,",
   #            "              imaf112,     '',          imaf113,     '',",
   #            "              imaf114,     imaf115,     imaf122,     rtdxsite,",
   #            "              t1.ooefl003, rtdx001,     t2.imaal003, t2.imaal004,",
   #            "              rtdx002,     rtdx006,     rtdx007,     rtdx008,     rtdx009,     rtdx012,",
   #            "              rtdxstus,    rtdxsite,    t1.ooefl003, rtdx001,",
   #            "              t2.imaal003, t2.imaal004, rtdxownid,   t6.ooag011,",
   #            "              rtdxowndp,   t7.ooefl003, rtdxcrtid,   t8.ooag011,",
   #            "              rtdxcrtdp,   t9.ooefl003, rtdxcrtdt,   rtdxmodid,",
   #            "              t10.ooag011, rtdxmoddt",
   #            "  FROM rtdx_t",
   #            "  LEFT OUTER JOIN imaf_t ON imafent = rtdxent",           #營運據點商品清單
   #            "                        AND imafsite = rtdxsite",
   #            "                        AND imaf001 = rtdx001",
   #            "  LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = rtdxent",      #營運組織
   #            "                            AND t1.ooefl001 = rtdxsite",
   #            "                            AND t1.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN imaal_t t2 ON t2.imaalent = rtdxent",      #商品編號
   #            "                            AND t2.imaal001 = rtdx001",
   #            "                            AND t2.imaal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = rtdxent",      #採購中心
   #            "                            AND t3.ooefl001 = rtdx028",
   #            "                            AND t3.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooefl_t t4 ON t4.ooeflent = rtdxent",      #配送中心
   #            "                            AND t4.ooefl001 = rtdx029",
   #            "                            AND t4.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN oocal_t t5 ON t5.oocalent = rtdxent",      #包裝單位
   #            "                            AND t5.oocal001 = rtdx004",
   #            "                            AND t5.oocal002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooag_t  t6 ON t6.ooagent = rtdxent",       #資料所有者
   #            "                            AND t6.ooag001 = rtdxownid",
   #            "  LEFT OUTER JOIN ooefl_t t7 ON t7.ooeflent = rtdxent",      #資料所屬部門
   #            "                            AND t7.ooefl001 = rtdxowndp",
   #            "                            AND t7.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooag_t  t8 ON t8.ooagent = rtdxent",       #資料建立者
   #            "                            AND t8.ooag001 = rtdxcrtid",
   #            "  LEFT OUTER JOIN ooefl_t t9 ON t9.ooeflent = rtdxent",      #資料建立部門
   #            "                            AND t9.ooefl001 = rtdxcrtdp",
   #            "                            AND t9.ooefl002 = '",g_dlang,"'",
   #            "  LEFT OUTER JOIN ooag_t t10 ON t10.ooagent = rtdxent",      #資料修改者
   #            "                            AND t10.ooag001 = rtdxmodid",
   #            " WHERE rtdxent= ?",
   #            "   AND 1 = 1",
   #            "   AND ", ls_wc,cl_sql_add_filter("rtdx_t"),
   #            " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)      

   ##150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #LET g_sql = "SELECT UNIQUE 'N',          rtdxsite,     t1.ooefl003,  rtdx001,      t2.imaal003, ",
   #            "              t2.imaal004,  rtdx002,      rtdx003,      rtdx010,      rtdx027, ",
   #            "              rtdx028,      t3.ooefl003,  rtdx029,      t4.ooefl003,  rtdx032, ",
   #            "              rtdx041,      rtdx042, ",                                                #150401-00003#1--add by dongsz
   #            "              rtdx034,      rtdx035,      t11.oodbl004, t11.oodb006,  t11.oodb005, ",
   #            "              imaf143,      imaf143_desc, imaf144,      imaf144_desc, imaf145, ",
   #            "              imaf146,      rtdx044,      t12.inayl003, ",                             #150515-00006#1 150516 by lori522612 add rtdx044,inayl003 
   #            "              imaf153,      imaf153_desc, imaf147,      imaf152, ",           
   #            "              imaf158,      imaf164,      imaf166,      rtdxsite,     t1.ooefl003, ",
   #            "              rtdx001,      t2.imaal003,  t2.imaal004,  rtdx002,      rtdx004, ",
   #            "              t5.oocal003,  rtdx005,      rtdx011,      rtdx013,      rtdx014, ",
   #            "              t17.oodbl004, t17.oodb006,  t17.oodb005,  rtdx016,      rtdx017, ",
   #            "              rtdx018,      rtdx019,      rtdx020,      rtdx021,      rtdx022, ",
   #            "              rtdx023,      rtdx024,      rtdx025,      rtdx026,      rtdx036, ",
   #            "              rtdx037,      rtdx038,      rtdx039,      rtdx040,      imaf112, ",
   #            "              imaf112_desc, imaf113,      imaf113_desc, imaf114,      imaf115, ",
   #            "              imaf122,      rtdxsite,     t1.ooefl003,  rtdx001,      t2.imaal003, ",
   #            "              t2.imaal004,  rtdx002,      rtdx043,      rtdx006,      rtdx007,      rtdx008, ",  #150402-00005#15--add rtdx043 by s983961
   #            "              rtdx009,      rtdx012,      rtdxstus,     rtdxsite,     t1.ooefl003, ",
   #            "              rtdx001,      t2.imaal003,  t2.imaal004,  rtdxownid,    t6.ooag011, ",
   #            "              rtdxowndp,    t7.ooefl003,  rtdxcrtid,    t8.ooag011,   rtdxcrtdp, ",
   #            "              t9.ooefl003,  rtdxcrtdt,    rtdxmodid,    t10.ooag011,  rtdxmoddt ",
   #            "  FROM rtdx_t",
   #            "       LEFT JOIN (SELECT imafent, imafsite, imaf001, imaf114, imaf115, ",       #營運據點商品清單
   #            "                         imaf122, imaf166,  imaf145, imaf146, imaf147, ",
   #            "                         imaf152, imaf158,  imaf164, ",
   #            "                         imaf143, t12.oocal003 imaf143_desc, ",                  #採購單位
   #            "                         imaf144, t13.oocal003 imaf144_desc, ",                  #採購計價單位 
   #            "                         imaf153, t14.pmaal004 imaf153_desc, ",                  #主要供應商
   #            "                         imaf112, t15.oocal003 imaf112_desc, ",                  #銷售單位
   #            "                         imaf113, t16.oocal003 imaf113_desc  ",                  #銷售計價單位
   #            "                    FROM imaf_t ",               
   #            "                         LEFT JOIN oocal_t t12 ON t12.oocalent = imafent AND t12.oocal001 = imaf143 AND t12.oocal002 = '",g_dlang,"' ",    
   #            "                         LEFT JOIN oocal_t t13 ON t13.oocalent = imafent AND t13.oocal001 = imaf144 AND t13.oocal002 = '",g_dlang,"' ",    
   #            "                         LEFT JOIN pmaal_t t14 ON t14.pmaalent = imafent AND t14.pmaal001 = imaf153 AND t14.pmaal002 = '",g_dlang,"' ",
   #            "                         LEFT JOIN oocal_t t15 ON t15.oocalent = imafent AND t15.oocal001 = imaf112 AND t15.oocal002 = '",g_dlang,"' ",    
   #            "                         LEFT JOIN oocal_t t16 ON t16.oocalent = imafent AND t16.oocal001 = imaf113 AND t16.oocal002 = '",g_dlang,"') ",    
   #            "              ON imafent = rtdxent AND imafsite = rtdxsite AND imaf001 = rtdx001 ",
   #            "       LEFT JOIN ooefl_t t1  ON t1.ooeflent = rtdxent AND t1.ooefl001 = rtdxsite  AND t1.ooefl002 = '",g_dlang,"' ",      #營運組織
   #            "       LEFT JOIN imaal_t t2  ON t2.imaalent = rtdxent AND t2.imaal001 = rtdx001   AND t2.imaal002 = '",g_dlang,"' ",      #商品編號
   #            "       LEFT JOIN ooefl_t t3  ON t3.ooeflent = rtdxent AND t3.ooefl001 = rtdx028   AND t3.ooefl002 = '",g_dlang,"' ",      #採購中心
   #            "       LEFT JOIN ooefl_t t4  ON t4.ooeflent = rtdxent AND t4.ooefl001 = rtdx029   AND t4.ooefl002 = '",g_dlang,"' ",      #配送中心
   #            "       LEFT JOIN oocal_t t5  ON t5.oocalent = rtdxent AND t5.oocal001 = rtdx004   AND t5.oocal002 = '",g_dlang,"' ",      #包裝單位
   #            "       LEFT JOIN ooag_t  t6  ON t6.ooagent  = rtdxent AND t6.ooag001 = rtdxownid ",                                       #資料所有者
   #            "       LEFT JOIN ooefl_t t7  ON t7.ooeflent = rtdxent AND t7.ooefl001 = rtdxowndp AND t7.ooefl002 = '",g_dlang,"' ",      #資料所屬部門
   #            "       LEFT JOIN ooag_t  t8  ON t8.ooagent  = rtdxent AND t8.ooag001 = rtdxcrtid",                                        #資料建立者
   #            "       LEFT JOIN ooefl_t t9  ON t9.ooeflent = rtdxent AND t9.ooefl001 = rtdxcrtdp AND t9.ooefl002 = '",g_dlang,"' ",      #資料建立部門
   #            "       LEFT JOIN ooag_t  t10 ON t10.ooagent = rtdxent AND t10.ooag001 = rtdxmodid ",                                      #資料修改者
   #            "       LEFT JOIN (SELECT oodblent,ooef001,oodb006,oodb005,oodbl002,oodbl003,oodbl004 ",                                  #進項稅目、稅率、含稅
   #            "                    FROM ooef_t,oodb_t LEFT JOIN oodbl_t ON oodblent = oodbent AND oodbl001 = oodb001 AND oodbl002 = oodb002 ",
   #            "                   WHERE ooefent = oodblent AND ooef019 = oodbl001) t11 ",
   #            "              ON t11.oodblent = rtdxent AND t11.ooef001 = rtdxsite AND t11.oodbl002 = rtdx035 AND t11.oodbl003 = '",g_dlang,"' ",
   #            "       LEFT JOIN inayl_t t12 ON t12.inaylent = rtdxent AND t12.inayl001 = rtdx044 AND t12.inayl002 = '",g_dlang,"' ",   #庫位   #150515-00006#1 150516 by lori522612 add
   #            "       LEFT JOIN (SELECT oodblent,ooef001,oodb006,oodb005,oodbl002,oodbl003,oodbl004 ",                                  #銷項稅目、稅率、含稅
   #            "                    FROM ooef_t,oodb_t LEFT JOIN oodbl_t ON oodblent = oodbent AND oodbl001 = oodb001 AND oodbl002 = oodb002 ",
   #            "                   WHERE ooefent = oodblent AND ooef019 = oodbl001) t17 ",
   #            "              ON t17.oodblent = rtdxent AND t17.ooef001 = rtdxsite AND t17.oodbl002 = rtdx014 AND t17.oodbl003 = '",g_dlang,"' ",
   #            " WHERE rtdxent= ?",
   #            "   AND 1 = 1",
   #            "   AND ", ls_wc,cl_sql_add_filter("rtdx_t"),
   #            " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)
   #150826-00013#1 效能調整 20150911 mark by beckxie---S
   ##150521-00024# Add By Ken 150521
   #LET g_sql =  "SELECT UNIQUE 'N',          rtdxsite a,   t1.ooefl003,  rtdx001 b,    t2.imaal003,",
   #             #"              t2.imaal004,  rtdx002,      rtdx003,      rtdx010,      rtdx027,",    #150602-00074#1--mark by dongsz
   #             "              t2.imaal004,  rtdx002,      imaa009,      t19.rtaxl003, rtdx003,      rtdx010,      rtdx027,",     #150602-00074#1--add by dongsz
   #             "              rtdx028,      t3.ooefl003,  rtdx029,      t4.ooefl003,  rtdx032,",
   #             "              rtdx041,      rtdx042,      rtdx034,      rtdx035,      t17.oodbl004,",
   #             "              t17.oodb006,  t17.oodb005,  imaf143,      t11.oocal003, imaf144,",
   #             "              t12.oocal003, imaf145,      imaf146,      rtdx044,      t18.inayl003,",
   #             "              imaf153,      t13.pmaal004, imaf147,      imaf152,      imaf158,",
   #             "              imaf164,      imaf166,      rtdxsite,     t1.ooefl003,  rtdx001,",
   #             #"              t2.imaal003,  t2.imaal004,  rtdx002,      rtdx004,      t5.oocal003,",  #150602-00074#1--mark by dongsz
   #             "              t2.imaal003,  t2.imaal004,  rtdx002,      imaa009,      t19.rtaxl003, rtdx004,      t5.oocal003,",  #150602-00074#1--add by dongsz
   #             "              rtdx005,      rtdx011,      rtdx013,      rtdx014,      t16.oodbl004,",
   #             "              t16.oodb006,  t16.oodb005,  rtdx016,      rtdx017,      rtdx018,",
   #             "              rtdx019,      rtdx020,      rtdx021,      rtdx046,      rtdx022,      rtdx023,",#150616-00035#2--add by geza rtdx046
   #             "              rtdx024,      rtdx025,      rtdx026,      rtdx036,      rtdx037,",
   #             "              rtdx038,      rtdx039,      rtdx040,      rtdx045,'',   imaf112,      t14.oocal003,",   #150616-00035#12 add rtdx045,'' by yangxf
   #             "              imaf113,      t15.oocal003, imaf114,      imaf115,      imaf122,",
   #             "              rtdxsite,     t1.ooefl003,  rtdx001,      t2.imaal003,  t2.imaal004,",
   #             #"              rtdx002,      rtdx043,      rtdx006,      rtdx007,      rtdx008,",   #150602-00074#1--mark by dongsz
   #             "              rtdx002,      imaa009,      t19.rtaxl003, rtdx043,      rtdx006,      rtdx007,      rtdx008,",   #150602-00074#1--add dongsz
   #             "              rtdx009,      rtdx012,      rtdxstus,     rtdxsite,     t1.ooefl003,",
   #             "              rtdx001,      t2.imaal003,  t2.imaal004,  rtdxownid,    t6.ooag011,",
   #             "              rtdxowndp,    t7.ooefl003,  rtdxcrtid,    t8.ooag011,   rtdxcrtdp,",
   #             "              t9.ooefl003,  rtdxcrtdt,    rtdxmodid,    t10.ooag011,  rtdxmoddt",
   #             #"         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   rtdx003,   rtdx010,",   #150602-00074#1--mark by dongsz
   #             "         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   imaa009,   rtdx003,   rtdx010,",   #150602-00074#1--add by dongsz
   #             "                      rtdx027,   rtdx028,   rtdx029,   rtdx032,   rtdx041,",
   #             "                      rtdx042,   rtdx034,   rtdx035,   imaf143,   imaf144,",
   #             "                      imaf145,   imaf146,   rtdx044,   imaf153,   imaf147,",
   #             "                      imaf152,   imaf158,   imaf164,   imaf166,   rtdx004,",    
   #             "                      rtdx005,   rtdx011,   rtdx013,   rtdx014,   rtdx016,",
   #             "                      rtdx017,   rtdx018,   rtdx019,   rtdx020,   rtdx021, rtdx046,", #150616-00035#2--add by geza rtdx046
   #             "                      rtdx022,   rtdx023,   rtdx024,   rtdx025,   rtdx026,",
   #             "                      rtdx036,   rtdx037,   rtdx038,   rtdx039,   rtdx040,rtdx045,'',",       #add by yangxf rtdx045,''
   #             "                      imaf112,   imaf113,   imaf114,   imaf115,   imaf122,",
   #             "                      rtdx043,   rtdx006,   rtdx007,   rtdx008,   rtdx009,",
   #             "                      rtdx012,   rtdxstus,  rtdxownid, rtdxowndp, rtdxcrtid,",
   #             "                      rtdxcrtdp, rtdxcrtdt, rtdxmodid, rtdxmoddt, imafent,",
   #             #"                      rtdxent,   ooef019",    #150602-00074#1--mark by dongsz
   #             "                      rtdxent,   imaaent,   ooef019",    #150602-00074#1--add by dongsz
   #             #"                 FROM ooef_t, imaf_t, rtdx_t",   #150602-00074#1--mark by dongsz
   #             "                 FROM ooef_t, imaf_t, rtdx_t, imaa_t ",   #150602-00074#1--add by dongsz
   #             "                WHERE imafent = rtdxent",
   #             "                      AND imafsite = rtdxsite",
   #             "                      AND imaf001 = rtdx001",
   #             "                      AND ooefent = rtdxent",
   #             "                      AND ooef001 = rtdxsite",
   #             "                      AND rtdxent = imaaent AND rtdx001 = imaa001 ",   #150602-00074#1--add by dongsz
   #             "                      AND rtdxent = ?",
   #             "                      AND ",ls_wc,cl_sql_add_filter("rtdx_t"),")",
   #             "         LEFT OUTER JOIN oocal_t t11 ON t11.oocalent = imafent",     #採購單位
   #             "                                    AND t11.oocal001 = imaf143",
   #             "                                    AND t11.oocal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN oocal_t t12 ON t12.oocalent = imafent",     #採購計價單位
   #             "                                    AND t12.oocal001 = imaf144",
   #             "                                    AND t12.oocal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN pmaal_t t13 ON t13.pmaalent = imafent",     #主要供應商
   #             "                                    AND t13.pmaal001 = imaf153",
   #             "                                    AND t13.pmaal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN oocal_t t14 ON t14.oocalent = imafent",     #銷售單位
   #             "                                    AND t14.oocal001 = imaf112",
   #             "                                    AND t14.oocal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN oocal_t t15 ON t15.oocalent = imafent",     #銷售計價單位
   #             "                                    AND t15.oocal001 = imaf113",
   #             "                                    AND t15.oocal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN rtaxl_t t19 ON t19.rtaxlent = imaaent ",    #品類   #150602-00074#1--add by dongsz
   #             "                                    AND t19.rtaxl001 = imaa009 ",    #150602-00074#1--add by dongsz
   #             "                                    AND t19.rtaxl002 = '",g_dlang,"' ",  #150602-00074#1--add by dongsz
   #             "         LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = rtdxent",       #營運組織
   #             "                                   AND t1.ooefl001 = rtdxsite",
   #             "                                   AND t1.ooefl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN imaal_t t2 ON t2.imaalent = rtdxent",       #商品編號
   #             "                                   AND t2.imaal001 = rtdx001",
   #             "                                   AND t2.imaal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN ooefl_t t3 ON t3.ooeflent = rtdxent",       #採購中心
   #             "                                   AND t3.ooefl001 = rtdx028",
   #             "                                   AND t3.ooefl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN ooefl_t t4 ON t4.ooeflent = rtdxent",      #配送中心
   #             "                                   AND t4.ooefl001 = rtdx029",
   #             "                                   AND t4.ooefl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN oocal_t t5 ON t5.oocalent = rtdxent",      #包裝單位
   #             "                                   AND t5.oocal001 = rtdx004",
   #             "                                   AND t5.oocal002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN ooag_t t6 ON t6.ooagent = rtdxent",        #資料所有者
   #             "                                  AND t6.ooag001 = rtdxownid",
   #             "         LEFT OUTER JOIN ooefl_t t7 ON t7.ooeflent = rtdxent",      #資料所屬部門
   #             "                                   AND t7.ooefl001 = rtdxowndp",
   #             "                                   AND t7.ooefl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN ooag_t t8 ON t8.ooagent = rtdxent",        #資料建立者
   #             "                                  AND t8.ooag001 = rtdxcrtid",
   #             "         LEFT OUTER JOIN ooefl_t t9 ON t9.ooeflent = rtdxent",      #資料建立部門
   #             "                                   AND t9.ooefl001 = rtdxcrtdp",
   #             "                                   AND t9.ooefl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN ooag_t t10 ON t10.ooagent = rtdxent",      #資料修改者
   #             "                                   AND t10.ooag001 = rtdxmodid",
   #             "         LEFT OUTER JOIN inayl_t t18 ON t18.inaylent = rtdxent",     #庫位
   #             "                                    AND t18.inayl001 = rtdx044",
   #             "                                    AND t18.inayl002 = '",g_dlang,"'",
   #             "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006,oodbl004",  #銷項稅別
   #             "                            FROM oodb_t",
   #             "                            LEFT OUTER JOIN oodbl_t ON oodbent = oodblent",
   #             "                                                   AND oodb001 = oodbl001",
   #             "                                                   AND oodb002 = oodbl002",
   #             "                                                   AND oodbl003 = '",g_dlang,"') t16 ON t16.oodbent = rtdxent",
   #             "                                                                                    AND t16.oodb001 = ooef019",
   #             "                                                                                    AND t16.oodb002 = rtdx014",
   #             "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006,oodbl004",  #進項稅別
   #             "                            FROM oodb_t",
   #             "                            LEFT OUTER JOIN oodbl_t ON oodbent = oodblent",
   #             "                                                   AND oodb001 = oodbl001",
   #             "                                                   AND oodb002 = oodbl002",
   #             "                                                   AND oodbl003 = '",g_dlang,"') t17 ON t17.oodbent = rtdxent",
   #             "                                                                                    AND t17.oodb001 = ooef019",
   #             "                                                                                    AND t17.oodb002 = rtdx035",
   #             " ORDER BY a,b"             
   ##150521-00024# Add By Ken 150521
   #150826-00013#1 效能調整 20150911 mark by beckxie---E
   
   #160107-00016#1 Mark By Ken 160108(S)
   ##150923-00001#1 Add By Ken 151016 效能調整(s)
   #LET g_sql =  "SELECT UNIQUE 'N',          rtdxsite a,   ooefl003,     rtdx001 b,    imaal003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003
   #             #"              t2.imaal004,  rtdx002,      rtdx003,      rtdx010,      rtdx027,",    #150602-00074#1--mark by dongsz
   #             "              imaal004,     rtdx002,      imaa009,      rtaxl003,     rtdx003,  ", #150602-00074#1--add by dongsz #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal004改imaal004,t19.rtaxl003改rtaxl003
   #             "              rtdx010,      rtdx027,      rtdx028,      ",
   #             "              (SELECT ooefl003",
   #             "                 FROM ooefl_t",
   #             "                WHERE ooeflent = rtdxent",       #採購中心
   #             "                  AND ooefl001 = rtdx028",
   #             "                  AND ooefl002 = '",g_dlang,"') rtdx028_desc,",
   #             "              rtdx029,      ",
   #             "              (SELECT ooefl003",
   #             "                 FROM ooefl_t",
   #             "                WHERE ooeflent = rtdxent",      #配送中心
   #             "                  AND ooefl001 = rtdx029",
   #             "                  AND ooefl002 = '",g_dlang,"') rtdx029_desc,",
   #             "              rtdx032,      rtdx041,      rtdx042,      rtdx034,      rtdx051, rtdx052, ", #20150925 dongsz add rtdx051,rtdx052
   #             "              rtdx035,      t17.oodbl004, t17.oodb006,  t17.oodb005,  imaf143, ",
   #             "              (SELECT oocal003",
   #             "                 FROM oocal_t",
   #             "                WHERE oocalent = imafent",     #採購單位
   #             "                  AND oocal001 = imaf143",
   #             "                  AND oocal002 = '",g_dlang,"') imaf143_desc,",
   #             "              imaf144,",
   #             "              (SELECT oocal003",
   #             "                 FROM oocal_t",
   #             "                WHERE oocalent = imafent",     #採購計價單位
   #             "                  AND oocal001 = imaf144",
   #             "                  AND oocal002 = '",g_dlang,"') imaf144_desc,",
   #             "              imaf145,      imaf146,      rtdx044,",
   #             "              (SELECT inayl003",
   #             "                 FROM inayl_t",
   #             "                WHERE inaylent = rtdxent",     #庫位
   #             "                  AND inayl001 = rtdx044",
   #             "                  AND inayl002 = '",g_dlang,"') rtdx044_desc,",
   #             "              imaf153,",
   #             "              (SELECT pmaal004",
   #             "                 FROM pmaal_t",
   #             "                WHERE pmaalent = imafent",     #主要供應商
   #             "                  AND pmaal001 = imaf153",
   #             "                  AND pmaal002 = '",g_dlang,"') imaf153_desc,",
   #             "              imaf147,      imaf152,      imaf158,      imaf164,      imaf166, ",
   #             "              rtdxsite,     ooefl003,     rtdx001,      imaal003,     imaal004, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003,t2.imaal004 改imaal004 ,t2.imaal003改imaal003
   #             "              rtdx002,      imaa009,      rtaxl003,     rtdx004, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
   #             "              (SELECT oocal003",
   #             "                 FROM oocal_t",
   #             "                WHERE oocalent = rtdxent",      #包裝單位
   #             "                  AND oocal001 = rtdx004",
   #             "                  AND oocal002 = '",g_dlang,"') rtdx004_desc,",#150602-00074#1--add by dongsz                
   #             "              rtdx005,      rtdx011,      rtdx013,      rtdx014,      t16.oodbl004, ",
   #             "              t16.oodb006,  t16.oodb005,  rtdx053,   rtdx054,  rtdx016,      rtdx017,      rtdx018, ",  #20151113 dongsz add rtdx053,rtdx054
   #             "              rtdx019,      rtdx020,      rtdx021,      rtdx046,      rtdx022, ", #150616-00035#2--add by geza rtdx046
   #             "              rtdx023,      rtdx024,      rtdx025,      rtdx026,      rtdx036, ",
   #             "              rtdx037,      rtdx038,      rtdx039,      rtdx040,      rtdx047, rtdx048, rtdx045, ",   #20151105 dongsz add rtdx047,rtdx048
   #             #150923-00001#1 Add By Ken 151001(s) 取促銷扣率
   #             "              (SELECT stbi017 ",
   #             "                 FROM stbi_t,stbh_t ",
   #             "                WHERE stbient = stbhent ",
   #             "                  AND stbidocno = stbhdocno ",
   #             "                  AND stbisite = stbhsite ",
   #             "                  AND stbient = rtdxent ",
   #             "                  AND stbisite = rtdxsite ",
   #             "                  AND stbi001 = rtdx001 ",
   #             "                  AND stbh002 = imaf153 ",
   #             "                  AND stbh003 = rtdx003 ",
   #             "                  AND stbi011 <= '",g_today,"'",
   #             "                  AND stbi012 >= '",g_today,"'",
   #             "                  AND stbh003 = '3' ",
   #             "                  AND stbhstus = 'Y') stbi017, ",
   #             #150923-00001#1 Add By Ken 151001(e)
   #             #"              '',   ",  #150923-00001#1 Mark By Ken 151001
   #             "              imaf112,",
   #             "              (SELECT oocal003",   #150616-00035#12 add rtdx045,'' by yangxf
   #             "                 FROM oocal_t",
   #             "                WHERE oocalent = imafent",     #銷售單位
   #             "                  AND oocal001 = imaf112",
   #             "                  AND oocal002 = '",g_dlang,"') imaf112_desc,",
   #             "              imaf113,",
   #             "              (SELECT oocal003",
   #             "                 FROM oocal_t",
   #             "                WHERE oocalent = imafent",     #銷售計價單位
   #             "                  AND oocal001 = imaf113",
   #             "                  AND oocal002 = '",g_dlang,"') imaf113_desc,",
   #             "              imaf114,      imaf115,      imaf122,      rtdxsite,     ooefl003, ", #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 ,t2.imaal003改imaal003,t2.imaal004改imaal004
   #             "              rtdx001,      imaal003,     imaal004,     rtdx002,      imaa009, ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
   #             "              rtaxl003,     rtdx043,      rtdx006,      rtdx007,      rtdx008,",   #150602-00074#1--add dongsz  #150923-00001#1 Modify By Ken 151022 調整效能 原t19.rtaxl003改rtaxl003
   #             "              rtdx009,      rtdx012,      rtdxstus,     rtdxsite,     ooefl003,",  #150923-00001#1 Modify By Ken 151022 調整效能 原t1.ooefl003 改ooefl003 
   #             "              rtdx001,      imaal003,     imaal004,     rtdxownid,    ",  #150923-00001#1 Modify By Ken 151022 調整效能 原t2.imaal003改imaal003,t2.imaal004改imaal004
   #             "              (SELECT ooag011",
   #             "                 FROM ooag_t",
   #             "                WHERE ooagent = rtdxent",        #資料所有者
   #             "                  AND ooag001 = rtdxownid) rtdxownid_desc,",
   #             "              rtdxowndp,",
   #             "              (SELECT ooefl003",
   #             "                 FROM ooefl_t",
   #             "                WHERE  ooeflent = rtdxent",      #資料所屬部門
   #             "                  AND ooefl001 = rtdxowndp",
   #             "                  AND ooefl002 = '",g_dlang,"') rtdxowndp_desc,",
   #             "              rtdxcrtid,",
   #             "              (SELECT ooag011",
   #             "                 FROM ooag_t",
   #             "                WHERE ooagent = rtdxent",        #資料建立者
   #             "                  AND ooag001 = rtdxcrtid) rtdxcrtid_desc,",
   #             "              rtdxcrtdp,",
   #             "              (SELECT ooefl003",
   #             "                 FROM ooefl_t",
   #             "                WHERE ooeflent = rtdxent",      #資料建立部門
   #             "                  AND ooefl001 = rtdxcrtdp",
   #             "                  AND ooefl002 = '",g_dlang,"') rtdxcrtdp_desc,",
   #             "              rtdxcrtdt,    rtdxmodid,",
   #             "              (SELECT ooag011",
   #             "                 FROM ooag_t",
   #             "                WHERE ooagent = rtdxent",      #資料修改者
   #             "                  AND ooag001 = rtdxmodid) rtdxmodid_desc,",
   #             "              rtdxmoddt",
   #             #"         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   rtdx003,   rtdx010,",   #150602-00074#1--mark by dongsz
   #             "         FROM (SELECT rtdxsite,  rtdx001,   rtdx002,   imaa009,   rtdx003,   rtdx010,",   #150602-00074#1--add by dongsz
   #             "                      rtdx027,   rtdx028,   rtdx029,   rtdx032,   rtdx041,",
   #             "                      rtdx042,   rtdx034,   rtdx051,   rtdx052,   rtdx035,   imaf143,   imaf144,",   #20150925 dongsz add rtdx051,rtdx052
   #             "                      imaf145,   imaf146,   rtdx044,   imaf153,   imaf147,",
   #             "                      imaf152,   imaf158,   imaf164,   imaf166,   rtdx004,",    
   #             "                      rtdx005,   rtdx011,   rtdx013,   rtdx014,   rtdx053, rtdx054, rtdx016,",  #20151113 dongsz add rtdx053,rtdx054
   #             "                      rtdx017,   rtdx018,   rtdx019,   rtdx020,   rtdx021, rtdx046,", #150616-00035#2--add by geza rtdx046
   #             "                      rtdx022,   rtdx023,   rtdx024,   rtdx025,   rtdx026,",
   #             "                      rtdx036,   rtdx037,   rtdx038,   rtdx039,   rtdx040,rtdx047,rtdx048,rtdx045,'',",   #add by yangxf rtdx045,''  #20151105 dongsz add rtdx047,rtdx048
   #             "                      imaf112,   imaf113,   imaf114,   imaf115,   imaf122,",
   #             "                      rtdx043,   rtdx006,   rtdx007,   rtdx008,   rtdx009,",
   #             "                      rtdx012,   rtdxstus,  rtdxownid, rtdxowndp, rtdxcrtid,",
   #             "                      rtdxcrtdp, rtdxcrtdt, rtdxmodid, rtdxmoddt, imafent,",
   #             #"                      rtdxent,   ooef019",    #150602-00074#1--mark by dongsz
   #             "                      rtdxent,   imaaent,   ooef019,",    #150602-00074#1--add by dongsz
   #             #150923-00001#1 Add By Ken 151022 調整效能(S)
   #             "                      (SELECT rtaxl003 FROM  rtaxl_t ",
   #             "                        WHERE rtaxlent = imaaent ",
   #             "                          AND rtaxl001 = imaa009 ",
   #             "                          AND rtaxl002 = '",g_dlang,"')rtaxl003, ",
   #             "                      (SELECT ooefl003 FROM ooefl_t t1 ",
   #             "                        WHERE t1.ooeflent = rtdxent ",
   #             "                          AND t1.ooefl001 = rtdxsite ",
   #             "                          AND t1.ooefl002 = '",g_dlang,"') ooefl003, ",
   #             "                      (SELECT imaal003 FROM imaal_t t2 ",
   #             "                        WHERE t2.imaalent = rtdxent ",
   #             "                          AND t2.imaal001 = rtdx001 ",
   #             "                          AND t2.imaal002 = '",g_dlang,"') imaal003, ",
   #             "                      (SELECT imaal004 FROM imaal_t t3 ",
   #             "                        WHERE t3.imaalent = rtdxent ",
   #             "                          AND t3.imaal001 = rtdx001 ",
   #             "                          AND t3.imaal002 = '",g_dlang,"') imaal004 ",
   #             #150923-00001#1 Add By Ken 151022 調整效能(E)
   #             #"                 FROM ooef_t, imaf_t, rtdx_t",   #150602-00074#1--mark by dongsz
   #             "                 FROM rtdx_t, imaa_t, imaf_t, ooef_t ",   #150602-00074#1--add by dongsz       
   #             "                WHERE imafent = rtdxent",
   #             "                      AND imafsite = rtdxsite",
   #             "                      AND imaf001 = rtdx001",
   #             "                      AND ooefent = rtdxent",
   #             "                      AND ooef001 = rtdxsite",
   #             "                      AND rtdxent = imaaent AND rtdx001 = imaa001 ",   #150602-00074#1--add by dongsz
   #             "                      AND rtdxent = ?",
   #             "                      AND ",ls_wc,cl_sql_add_filter("rtdx_t"),")",
   #             #150923-00001#1 Mark By Ken 151022 調整效能(S)
   #             #"         LEFT OUTER JOIN rtaxl_t t19 ON t19.rtaxlent = imaaent ",    #品類   #150602-00074#1--add by dongsz
   #             #"                                    AND t19.rtaxl001 = imaa009 ",    #150602-00074#1--add by dongsz
   #             #"                                    AND t19.rtaxl002 = '",g_dlang,"' ",  #150602-00074#1--add by dongsz
   #             #"         LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = rtdxent",       #營運組織
   #             #"                                   AND t1.ooefl001 = rtdxsite",
   #             #"                                   AND t1.ooefl002 = '",g_dlang,"'",
   #             #"         LEFT OUTER JOIN imaal_t t2 ON t2.imaalent = rtdxent",       #商品編號
   #             #"                                   AND t2.imaal001 = rtdx001",
   #             #"                                   AND t2.imaal002 = '",g_dlang,"'",
   #             #150923-00001#1 Mark By Ken 151022 調整效能(E)
   #             "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
   #             "                                 (SELECT oodbl004 FROM oodbl_t ",  #銷項稅別
   #             "                                   WHERE oodbent = oodblent",
   #             "                                                   AND oodb001 = oodbl001",
   #             "                                                   AND oodb002 = oodbl002",
   #             "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
   #             "                    FROM oodb_t) t16 ",
   #             "                      ON t16.oodbent = rtdxent",
   #             "                     AND t16.oodb001 = ooef019",
   #             "                     AND t16.oodb002 = rtdx014",
   #             "         LEFT OUTER JOIN (SELECT oodbent,oodb001,oodb002,oodb005,oodb006, ",
   #             "                                 (SELECT oodbl004 FROM oodbl_t ",  #進項稅別
   #             "                                   WHERE oodbent = oodblent",
   #             "                                                   AND oodb001 = oodbl001",
   #             "                                                   AND oodb002 = oodbl002",
   #             "                                                   AND oodbl003 = '",g_dlang,"')oodbl004 ",
   #             "                    FROM oodb_t) t17 ",
   #             "                      ON t17.oodbent = rtdxent",
   #             "                     AND t17.oodb001 = ooef019",
   #             "                     AND t17.oodb002 = rtdx035",
   #             " ORDER BY a,b"             
   ##150923-00001#1 Add By Ken 151016 效能調整(e)
   #DISPLAY "g_sql:",g_sql
   #160107-00016#1 Mark By Ken 160108(E)
   
   #160107-00016#1 Add By Ken 160120 標準分頁功能Mark(S)
   #LET g_sql = "SELECT 'N',a,ooefl003,b,imaal003,imaal004,rtdx002,imaa009,rtaxl003,rtdx003,rtdx010,rtdx027,rtdx028,rtdx028_desc, 
   #    rtdx029,rtdx029_desc,rtdx032,rtdx041,rtdx042,rtdx034,rtdx051,rtdx052,rtdx035,oodbl004,oodb006,oodb005,imaf143,imaf143_desc,imaf144,imaf144_desc,imaf145,imaf146, 
   #    rtdx044,rtdx044_desc,imaf153,imaf153_desc,imaf147,imaf152,imaf158,imaf164,imaf166,rtdxsite_2,ooefl003_2,rtdx001_2,imaal003_2,imaal004_2,rtdx002_2,imaa009_2,rtaxl003_2,rtdx004,rtdx044_desc,rtdx005,rtdx011,rtdx013, 
   #    rtdx014,oodbl004_2,oodb006_2,oodb005_2,rtdx053,rtdx054,rtdx016,rtdx017,rtdx018,rtdx019,rtdx020,rtdx021,rtdx046,rtdx022, 
   #    rtdx023,rtdx024,rtdx025,rtdx026,rtdx036,rtdx037,rtdx038,rtdx039,rtdx040,rtdx047,rtdx048,rtdx045, 
   #    stbi017,imaf112,imaf112_desc,imaf113,imaf113_desc,imaf114,imaf115,imaf122,rtdxsite_3,ooefl003_3,rtdx001_3,imaal003_3,imaal004_3,rtdx002_3,imaa009_3,rtaxl003_3,rtdx043,rtdx006,rtdx007,rtdx008,rtdx009, 
   #    rtdx012,rtdxstus,rtdxsite_4,ooefl003_4,rtdx001_4,imaal003_4,imaal004_4,rtdxownid,rtdxownid_desc,rtdxowndp,rtdxowndp_desc,rtdxcrtid,rtdxcrtid_desc,rtdxcrtdp,rtdxcrtdp_desc,rtdxcrtdt, 
   #    rtdxmodid,rtdxmodid_desc,rtdxmoddt",
   #            " FROM (",ls_sql_rank,")",
   #           " WHERE RANK >= ",g_pagestart,
   #             " AND RANK < ",g_pagestart + g_num_in_page   
   #160107-00016#1 Add By Ken 160120 標準分頁功能Mark(E)
   #DISPLAY 'g_sql:',g_sql
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq400_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq400_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtdx_d.clear()
   CALL g_rtdx2_d.clear()   
 
   CALL g_rtdx3_d.clear()   
 
   CALL g_rtdx4_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #150302-00004#8 150312 by lori522612 mark---(S) 
   ##稅率、含稅
   #LET g_sql = "SELECT oodb006,oodb005",
   #            "  FROM oodb_t,ooef_t",
   #            " WHERE oodbent = ",g_enterprise,
   #            "   AND ooefent = oodbent",
   #            "   AND ooef019  = oodb001",
   #            "   AND ooef001  = ?",
   #            "   AND oodb002 = ?"
   #PREPARE artq400_oodb FROM g_sql
   #
   ##稅目
   #LET g_sql = "SELECT oodbl004",
   #            "  FROM oodbl_t,ooef_t",
   #            " WHERE oodblent = ",g_enterprise,
   #            "   AND ooefent = oodblent",
   #            "   AND ooef019  = oodbl001",
   #            "   AND ooef001  = ?",
   #            "   AND oodbl002 = ?",
   #            "   AND oodbl003 = '",g_dlang,"'"
   #PREPARE artq400_oodbl004 FROM g_sql
   #
   ##單位
   #LET g_sql = "SELECT oocal003",
   #            "  FROM oocal_t",
   #            " WHERE oocalent = ",g_enterprise,
   #            "   AND oocal001 = ?",
   #            "   AND oocal002 = '",g_dlang,"'"
   #PREPARE artq400_oocal003 FROM g_sql
   #
   ##主要供應商
   #LET g_sql = "SELECT pmaal004",
   #            "  FROM pmaal_t",
   #            " WHERE pmaalent = ",g_enterprise,
   #            "   AND pmaal001 = ?",
   #            "   AND pmaal002 = '",g_dlang,"'"
   #PREPARE artq400_pmaal004 FROM g_sql
   #150302-00004#8 150312 by lori522612 mark---(E) 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_rtdx_d[l_ac].sel,g_rtdx_d[l_ac].rtdxsite,g_rtdx_d[l_ac].rtdxsite_desc, 
       g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_desc,g_rtdx_d[l_ac].rtdx002, 
       g_rtdx_d[l_ac].imaa009,g_rtdx_d[l_ac].imaa009_desc,g_rtdx_d[l_ac].rtdx003,g_rtdx_d[l_ac].rtdx010, 
       g_rtdx_d[l_ac].rtdx027,g_rtdx_d[l_ac].rtdx028,g_rtdx_d[l_ac].rtdx028_desc,g_rtdx_d[l_ac].rtdx029, 
       g_rtdx_d[l_ac].rtdx029_desc,g_rtdx_d[l_ac].rtdx032,g_rtdx_d[l_ac].rtdx041,g_rtdx_d[l_ac].rtdx042, 
       g_rtdx_d[l_ac].rtdx034,g_rtdx_d[l_ac].rtdx051,g_rtdx_d[l_ac].rtdx052,g_rtdx_d[l_ac].rtdx035,g_rtdx_d[l_ac].rtdx035_desc, 
       g_rtdx_d[l_ac].l_rtdx035_oodb006,g_rtdx_d[l_ac].l_rtdx035_oodb005,g_rtdx_d[l_ac].imaf143,g_rtdx_d[l_ac].imaf143_desc, 
       g_rtdx_d[l_ac].imaf144,g_rtdx_d[l_ac].imaf144_desc,g_rtdx_d[l_ac].imaf145,g_rtdx_d[l_ac].imaf146, 
       g_rtdx_d[l_ac].rtdx044,g_rtdx_d[l_ac].rtdx044_desc,g_rtdx_d[l_ac].imaf153,g_rtdx_d[l_ac].imaf153_desc, 
       g_rtdx_d[l_ac].imaf147,g_rtdx_d[l_ac].imaf152,g_rtdx_d[l_ac].imaf158,g_rtdx_d[l_ac].imaf164,g_rtdx_d[l_ac].imaf166, 
       g_rtdx2_d[l_ac].rtdxsite,g_rtdx2_d[l_ac].rtdxsite_2_desc,g_rtdx2_d[l_ac].rtdx001,g_rtdx2_d[l_ac].rtdx001_2_desc, 
       g_rtdx2_d[l_ac].rtdx001_2_desc_desc,g_rtdx2_d[l_ac].rtdx002,g_rtdx2_d[l_ac].imaa009,g_rtdx2_d[l_ac].imaa009_2_desc, 
       g_rtdx2_d[l_ac].rtdx004,g_rtdx2_d[l_ac].rtdx004_desc,g_rtdx2_d[l_ac].rtdx005,g_rtdx2_d[l_ac].rtdx011, 
       g_rtdx2_d[l_ac].rtdx013,g_rtdx2_d[l_ac].rtdx014,g_rtdx2_d[l_ac].rtdx014_desc,g_rtdx2_d[l_ac].l_rtdx014_oodb006, 
       g_rtdx2_d[l_ac].l_rtdx014_oodb005,g_rtdx2_d[l_ac].rtdx053,g_rtdx2_d[l_ac].rtdx054,g_rtdx2_d[l_ac].rtdx016, 
       g_rtdx2_d[l_ac].rtdx101,g_rtdx2_d[l_ac].rtdx020,g_rtdx2_d[l_ac].rtdx021,g_rtdx2_d[l_ac].rtdx017, 
       g_rtdx2_d[l_ac].rtdx018,g_rtdx2_d[l_ac].rtdx019,g_rtdx2_d[l_ac].rtdx102,g_rtdx2_d[l_ac].rtdx103, 
       g_rtdx2_d[l_ac].rtdx046,g_rtdx2_d[l_ac].rtdx022,g_rtdx2_d[l_ac].rtdx023,g_rtdx2_d[l_ac].rtdx024, 
       g_rtdx2_d[l_ac].rtdx025,g_rtdx2_d[l_ac].rtdx026,g_rtdx2_d[l_ac].rtdx036,g_rtdx2_d[l_ac].rtdx037, 
       g_rtdx2_d[l_ac].rtdx038,g_rtdx2_d[l_ac].rtdx039,g_rtdx2_d[l_ac].rtdx040,g_rtdx2_d[l_ac].rtdx047, 
       g_rtdx2_d[l_ac].rtdx048,g_rtdx2_d[l_ac].rtdx045,g_rtdx2_d[l_ac].rtdx045_desc,g_rtdx2_d[l_ac].imaf112, 
       g_rtdx2_d[l_ac].imaf112_desc,g_rtdx2_d[l_ac].imaf113,g_rtdx2_d[l_ac].imaf113_desc,g_rtdx2_d[l_ac].imaf114, 
       g_rtdx2_d[l_ac].imaf115,g_rtdx2_d[l_ac].imaf122,g_rtdx3_d[l_ac].rtdxsite,g_rtdx3_d[l_ac].rtdxsite_3_desc, 
       g_rtdx3_d[l_ac].rtdx001,g_rtdx3_d[l_ac].rtdx001_3_desc,g_rtdx3_d[l_ac].rtdx001_3_desc_desc,g_rtdx3_d[l_ac].rtdx002, 
       g_rtdx3_d[l_ac].imaa009,g_rtdx3_d[l_ac].imaa009_3_desc,g_rtdx3_d[l_ac].rtdx043,g_rtdx3_d[l_ac].rtdx006, 
       g_rtdx3_d[l_ac].rtdx007,g_rtdx3_d[l_ac].rtdx008,g_rtdx3_d[l_ac].rtdx009,g_rtdx3_d[l_ac].rtdx012, 
       g_rtdx4_d[l_ac].rtdxstus,g_rtdx4_d[l_ac].rtdxsite,g_rtdx4_d[l_ac].rtdxsite_4_desc,g_rtdx4_d[l_ac].rtdx001, 
       g_rtdx4_d[l_ac].rtdx001_4_desc,g_rtdx4_d[l_ac].rtdx001_4_desc_desc,g_rtdx4_d[l_ac].rtdxownid, 
       g_rtdx4_d[l_ac].rtdxownid_desc,g_rtdx4_d[l_ac].rtdxowndp,g_rtdx4_d[l_ac].rtdxowndp_desc,g_rtdx4_d[l_ac].rtdxcrtid, 
       g_rtdx4_d[l_ac].rtdxcrtid_desc,g_rtdx4_d[l_ac].rtdxcrtdp,g_rtdx4_d[l_ac].rtdxcrtdp_desc,g_rtdx4_d[l_ac].rtdxcrtdt, 
       g_rtdx4_d[l_ac].rtdxmodid,g_rtdx4_d[l_ac].rtdxmodid_desc,g_rtdx4_d[l_ac].rtdxmoddt
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_rtdx_d[l_ac].statepic = cl_get_actipic(g_rtdx_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #SELECT stbi017 INTO g_rtdx2_d[l_ac].rtdx045_desc
      #  FROM stbi_t,stbh_t
      # WHERE stbient = stbhent
      #   AND stbidocno = stbhdocno
      #   AND stbient = g_enterprise
      #   AND stbisite = g_rtdx2_d[l_ac].rtdxsite
      #   AND stbi001 = g_rtdx3_d[l_ac].rtdx001
      #   AND stbh002 = g_rtdx_d[l_ac].imaf153
      #   AND stbh003 = g_rtdx_d[l_ac].rtdx003
      #   AND stbi011 <= g_today
      #   AND stbi012 >= g_today
      
      #end add-point
 
      CALL artq400_detail_show("'1'")      
 
      CALL artq400_rtdx_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())   
   CALL g_rtdx2_d.deleteElement(g_rtdx2_d.getLength())
 
   CALL g_rtdx3_d.deleteElement(g_rtdx3_d.getLength())
 
   CALL g_rtdx4_d.deleteElement(g_rtdx4_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_ls_wc = ls_wc   #160107-00016#1 Add By Ken 160108
   #end add-point
 
   LET g_detail_cnt = g_rtdx_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE artq400_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq400_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq400_detail_action_trans()
 
   IF g_rtdx_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL artq400_fetch()
   END IF
   
      CALL artq400_filter_show('rtdxsite','b_rtdxsite')
   CALL artq400_filter_show('rtdx001','b_rtdx001')
   CALL artq400_filter_show('rtdx002','b_rtdx002')
   CALL artq400_filter_show('imaa009','b_imaa009')
   CALL artq400_filter_show('rtdx003','b_rtdx003')
   CALL artq400_filter_show('rtdx010','b_rtdx010')
   CALL artq400_filter_show('rtdx027','b_rtdx027')
   CALL artq400_filter_show('rtdx028','b_rtdx028')
   CALL artq400_filter_show('rtdx029','b_rtdx029')
   CALL artq400_filter_show('rtdx032','b_rtdx032')
   CALL artq400_filter_show('rtdx041','b_rtdx041')
   CALL artq400_filter_show('rtdx042','b_rtdx042')
   CALL artq400_filter_show('rtdx034','b_rtdx034')
   CALL artq400_filter_show('rtdx051','b_rtdx051')
   CALL artq400_filter_show('rtdx052','b_rtdx052')
   CALL artq400_filter_show('rtdx035','b_rtdx035')
   CALL artq400_filter_show('imaf143','b_imaf143')
   CALL artq400_filter_show('imaf144','b_imaf144')
   CALL artq400_filter_show('imaf145','b_imaf145')
   CALL artq400_filter_show('imaf146','b_imaf146')
   CALL artq400_filter_show('rtdx044','b_rtdx044')
   CALL artq400_filter_show('imaf153','b_imaf153')
   CALL artq400_filter_show('imaf147','b_imaf147')
   CALL artq400_filter_show('imaf152','b_imaf152')
   CALL artq400_filter_show('imaf158','b_imaf158')
   CALL artq400_filter_show('imaf164','b_imaf164')
   CALL artq400_filter_show('imaf166','b_imaf166')
   CALL artq400_filter_show('rtdx004','b_rtdx004')
   CALL artq400_filter_show('rtdx005','b_rtdx005')
   CALL artq400_filter_show('rtdx011','b_rtdx011')
   CALL artq400_filter_show('rtdx013','b_rtdx013')
   CALL artq400_filter_show('rtdx014','b_rtdx014')
   CALL artq400_filter_show('rtdx053','b_rtdx053')
   CALL artq400_filter_show('rtdx054','b_rtdx054')
   CALL artq400_filter_show('rtdx016','b_rtdx016')
   CALL artq400_filter_show('rtdx101','b_rtdx101')
   CALL artq400_filter_show('rtdx020','b_rtdx020')
   CALL artq400_filter_show('rtdx021','b_rtdx021')
   CALL artq400_filter_show('rtdx017','b_rtdx017')
   CALL artq400_filter_show('rtdx018','b_rtdx018')
   CALL artq400_filter_show('rtdx019','b_rtdx019')
   CALL artq400_filter_show('rtdx102','b_rtdx102')
   CALL artq400_filter_show('rtdx103','b_rtdx103')
   CALL artq400_filter_show('rtdx046','b_rtdx046')
   CALL artq400_filter_show('rtdx022','b_rtdx022')
   CALL artq400_filter_show('rtdx023','b_rtdx023')
   CALL artq400_filter_show('rtdx024','b_rtdx024')
   CALL artq400_filter_show('rtdx025','b_rtdx025')
   CALL artq400_filter_show('rtdx026','b_rtdx026')
   CALL artq400_filter_show('rtdx036','b_rtdx036')
   CALL artq400_filter_show('rtdx037','b_rtdx037')
   CALL artq400_filter_show('rtdx038','b_rtdx038')
   CALL artq400_filter_show('rtdx039','b_rtdx039')
   CALL artq400_filter_show('rtdx040','b_rtdx040')
   CALL artq400_filter_show('rtdx047','b_rtdx047')
   CALL artq400_filter_show('rtdx048','b_rtdx048')
   CALL artq400_filter_show('rtdx045','b_rtdx045')
   CALL artq400_filter_show('imaf112','b_imaf112')
   CALL artq400_filter_show('imaf113','b_imaf113')
   CALL artq400_filter_show('imaf114','b_imaf114')
   CALL artq400_filter_show('imaf115','b_imaf115')
   CALL artq400_filter_show('imaf122','b_imaf122')
   CALL artq400_filter_show('rtdx043','b_rtdx043')
   CALL artq400_filter_show('rtdx006','b_rtdx006')
   CALL artq400_filter_show('rtdx007','b_rtdx007')
   CALL artq400_filter_show('rtdx008','b_rtdx008')
   CALL artq400_filter_show('rtdx009','b_rtdx009')
   CALL artq400_filter_show('rtdx012','b_rtdx012')
   CALL artq400_filter_show('rtdxstus','b_rtdxstus')
   CALL artq400_filter_show('rtdxownid','b_rtdxownid')
   CALL artq400_filter_show('rtdxowndp','b_rtdxowndp')
   CALL artq400_filter_show('rtdxcrtid','b_rtdxcrtid')
   CALL artq400_filter_show('rtdxcrtdp','b_rtdxcrtdp')
   CALL artq400_filter_show('rtdxcrtdt','b_rtdxcrtdt')
   CALL artq400_filter_show('rtdxmodid','b_rtdxmodid')
   CALL artq400_filter_show('rtdxmoddt','b_rtdxmoddt')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   CALL cl_set_comp_visible("sel", FALSE)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artq400_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE ls_result  STRING 
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="artq400.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artq400_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      #150302-00004#8 150312 by lori522612 mark---(S)
      ##進項稅目
      #EXECUTE artq400_oodbl004 USING g_rtdx_d[l_ac].rtdxsite,g_rtdx_d[l_ac].rtdx035
      #   INTO g_rtdx_d[l_ac].rtdx035_desc
      #
      ##進項稅率、含稅
      #EXECUTE artq400_oodb USING g_rtdx_d[l_ac].rtdxsite,g_rtdx_d[l_ac].rtdx035
      #   INTO g_rtdx_d[l_ac].l_rtdx035_oodb006, g_rtdx_d[l_ac].l_rtdx035_oodb005
      #   
      ##採購單位
      #EXECUTE artq400_oocal003 USING g_rtdx_d[l_ac].imaf143
      #   INTO g_rtdx_d[l_ac].imaf143_desc
      #
      ##採購計價單位
      #EXECUTE artq400_oocal003 USING g_rtdx_d[l_ac].imaf144
      #   INTO g_rtdx_d[l_ac].imaf144_desc
      #   
      ##主要供應商
      #EXECUTE artq400_pmaal004 USING g_rtdx_d[l_ac].imaf153
      #   INTO g_rtdx_d[l_ac].imaf153_desc
      #
      ##銷項稅目
      #EXECUTE artq400_oodbl004 USING g_rtdx2_d[l_ac].rtdxsite,g_rtdx2_d[l_ac].rtdx014
      #   INTO g_rtdx2_d[l_ac].rtdx014_desc
      #
      ##銷項稅率、含稅
      #EXECUTE artq400_oodb USING g_rtdx_d[l_ac].rtdxsite,g_rtdx2_d[l_ac].rtdx014
      #   INTO g_rtdx2_d[l_ac].l_rtdx014_oodb006, g_rtdx2_d[l_ac].l_rtdx014_oodb005
      #
      ##銷售單位
      #EXECUTE artq400_oocal003 USING g_rtdx2_d[l_ac].imaf112
      #   INTO g_rtdx2_d[l_ac].imaf112_desc
      #
      ##銷售計價單位
      #EXECUTE artq400_oocal003 USING g_rtdx2_d[l_ac].imaf113
      #   INTO g_rtdx2_d[l_ac].imaf113_desc
      #150302-00004#8 150312 by lori522612 mark---(E)   
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body4.reference"

#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_rtdx4_d[l_ac].rtdxownid
#      LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_rtdx4_d[l_ac].rtdxownid_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_rtdx4_d[l_ac].rtdxownid_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_rtdx4_d[l_ac].rtdxowndp
#      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_rtdx4_d[l_ac].rtdxowndp_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_rtdx4_d[l_ac].rtdxowndp_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_rtdx4_d[l_ac].rtdxcrtid
#      LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_rtdx4_d[l_ac].rtdxcrtid_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_rtdx4_d[l_ac].rtdxcrtid_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_rtdx4_d[l_ac].rtdxcrtdp
#      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_rtdx4_d[l_ac].rtdxcrtdp_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_rtdx4_d[l_ac].rtdxcrtdp_desc
#      
#      INITIALIZE g_ref_fields TO NULL
#      LET g_ref_fields[1] = g_rtdx4_d[l_ac].rtdxmodid
#      LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
#      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#      LET g_rtdx4_d[l_ac].rtdxmodid_desc = '', g_rtn_fields[1] , ''
#      DISPLAY BY NAME g_rtdx4_d[l_ac].rtdxmodid_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION artq400_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
 
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON rtdxsite,rtdx001,rtdx002,imaa009,rtdx003,rtdx010,rtdx027,rtdx028,rtdx029, 
          rtdx032,rtdx041,rtdx042,rtdx034,rtdx051,rtdx052,rtdx035,imaf143,imaf144,imaf145,imaf146,rtdx044, 
          imaf153,imaf147,imaf152,imaf158,imaf164,imaf166,rtdx004,rtdx005,rtdx011,rtdx013,rtdx014,rtdx053, 
          rtdx054,rtdx016,rtdx101,rtdx020,rtdx021,rtdx017,rtdx018,rtdx019,rtdx102,rtdx103,rtdx046,rtdx022, 
          rtdx023,rtdx024,rtdx025,rtdx026,rtdx036,rtdx037,rtdx038,rtdx039,rtdx040,rtdx047,rtdx048,rtdx045, 
          imaf112,imaf113,imaf114,imaf115,imaf122,rtdx043,rtdx006,rtdx007,rtdx008,rtdx009,rtdx012,rtdxstus, 
          rtdxownid,rtdxowndp,rtdxcrtid,rtdxcrtdp,rtdxcrtdt,rtdxmodid,rtdxmoddt
                          FROM s_detail1[1].b_rtdxsite,s_detail1[1].b_rtdx001,s_detail1[1].b_rtdx002, 
                              s_detail1[1].b_imaa009,s_detail1[1].b_rtdx003,s_detail1[1].b_rtdx010,s_detail1[1].b_rtdx027, 
                              s_detail1[1].b_rtdx028,s_detail1[1].b_rtdx029,s_detail1[1].b_rtdx032,s_detail1[1].b_rtdx041, 
                              s_detail1[1].b_rtdx042,s_detail1[1].b_rtdx034,s_detail1[1].b_rtdx051,s_detail1[1].b_rtdx052, 
                              s_detail1[1].b_rtdx035,s_detail1[1].b_imaf143,s_detail1[1].b_imaf144,s_detail1[1].b_imaf145, 
                              s_detail1[1].b_imaf146,s_detail1[1].b_rtdx044,s_detail1[1].b_imaf153,s_detail1[1].b_imaf147, 
                              s_detail1[1].b_imaf152,s_detail1[1].b_imaf158,s_detail1[1].b_imaf164,s_detail1[1].b_imaf166, 
                              s_detail2[1].b_rtdx004,s_detail2[1].b_rtdx005,s_detail2[1].b_rtdx011,s_detail2[1].b_rtdx013, 
                              s_detail2[1].b_rtdx014,s_detail2[1].b_rtdx053,s_detail2[1].b_rtdx054,s_detail2[1].b_rtdx016, 
                              s_detail2[1].b_rtdx101,s_detail2[1].b_rtdx020,s_detail2[1].b_rtdx021,s_detail2[1].b_rtdx017, 
                              s_detail2[1].b_rtdx018,s_detail2[1].b_rtdx019,s_detail2[1].b_rtdx102,s_detail2[1].b_rtdx103, 
                              s_detail2[1].b_rtdx046,s_detail2[1].b_rtdx022,s_detail2[1].b_rtdx023,s_detail2[1].b_rtdx024, 
                              s_detail2[1].b_rtdx025,s_detail2[1].b_rtdx026,s_detail2[1].b_rtdx036,s_detail2[1].b_rtdx037, 
                              s_detail2[1].b_rtdx038,s_detail2[1].b_rtdx039,s_detail2[1].b_rtdx040,s_detail2[1].b_rtdx047, 
                              s_detail2[1].b_rtdx048,s_detail2[1].b_rtdx045,s_detail2[1].b_imaf112,s_detail2[1].b_imaf113, 
                              s_detail2[1].b_imaf114,s_detail2[1].b_imaf115,s_detail2[1].b_imaf122,s_detail3[1].b_rtdx043, 
                              s_detail3[1].b_rtdx006,s_detail3[1].b_rtdx007,s_detail3[1].b_rtdx008,s_detail3[1].b_rtdx009, 
                              s_detail3[1].b_rtdx012,s_detail4[1].b_rtdxstus,s_detail4[1].b_rtdxownid, 
                              s_detail4[1].b_rtdxowndp,s_detail4[1].b_rtdxcrtid,s_detail4[1].b_rtdxcrtdp, 
                              s_detail4[1].b_rtdxcrtdt,s_detail4[1].b_rtdxmodid,s_detail4[1].b_rtdxmoddt 
 
 
         BEFORE CONSTRUCT
                     DISPLAY artq400_filter_parser('rtdxsite') TO s_detail1[1].b_rtdxsite
            DISPLAY artq400_filter_parser('rtdx001') TO s_detail1[1].b_rtdx001
            DISPLAY artq400_filter_parser('rtdx002') TO s_detail1[1].b_rtdx002
            DISPLAY artq400_filter_parser('imaa009') TO s_detail1[1].b_imaa009
            DISPLAY artq400_filter_parser('rtdx003') TO s_detail1[1].b_rtdx003
            DISPLAY artq400_filter_parser('rtdx010') TO s_detail1[1].b_rtdx010
            DISPLAY artq400_filter_parser('rtdx027') TO s_detail1[1].b_rtdx027
            DISPLAY artq400_filter_parser('rtdx028') TO s_detail1[1].b_rtdx028
            DISPLAY artq400_filter_parser('rtdx029') TO s_detail1[1].b_rtdx029
            DISPLAY artq400_filter_parser('rtdx032') TO s_detail1[1].b_rtdx032
            DISPLAY artq400_filter_parser('rtdx041') TO s_detail1[1].b_rtdx041
            DISPLAY artq400_filter_parser('rtdx042') TO s_detail1[1].b_rtdx042
            DISPLAY artq400_filter_parser('rtdx034') TO s_detail1[1].b_rtdx034
            DISPLAY artq400_filter_parser('rtdx051') TO s_detail1[1].b_rtdx051
            DISPLAY artq400_filter_parser('rtdx052') TO s_detail1[1].b_rtdx052
            DISPLAY artq400_filter_parser('rtdx035') TO s_detail1[1].b_rtdx035
            DISPLAY artq400_filter_parser('imaf143') TO s_detail1[1].b_imaf143
            DISPLAY artq400_filter_parser('imaf144') TO s_detail1[1].b_imaf144
            DISPLAY artq400_filter_parser('imaf145') TO s_detail1[1].b_imaf145
            DISPLAY artq400_filter_parser('imaf146') TO s_detail1[1].b_imaf146
            DISPLAY artq400_filter_parser('rtdx044') TO s_detail1[1].b_rtdx044
            DISPLAY artq400_filter_parser('imaf153') TO s_detail1[1].b_imaf153
            DISPLAY artq400_filter_parser('imaf147') TO s_detail1[1].b_imaf147
            DISPLAY artq400_filter_parser('imaf152') TO s_detail1[1].b_imaf152
            DISPLAY artq400_filter_parser('imaf158') TO s_detail1[1].b_imaf158
            DISPLAY artq400_filter_parser('imaf164') TO s_detail1[1].b_imaf164
            DISPLAY artq400_filter_parser('imaf166') TO s_detail1[1].b_imaf166
            DISPLAY artq400_filter_parser('rtdx004') TO s_detail2[1].b_rtdx004
            DISPLAY artq400_filter_parser('rtdx005') TO s_detail2[1].b_rtdx005
            DISPLAY artq400_filter_parser('rtdx011') TO s_detail2[1].b_rtdx011
            DISPLAY artq400_filter_parser('rtdx013') TO s_detail2[1].b_rtdx013
            DISPLAY artq400_filter_parser('rtdx014') TO s_detail2[1].b_rtdx014
            DISPLAY artq400_filter_parser('rtdx053') TO s_detail2[1].b_rtdx053
            DISPLAY artq400_filter_parser('rtdx054') TO s_detail2[1].b_rtdx054
            DISPLAY artq400_filter_parser('rtdx016') TO s_detail2[1].b_rtdx016
            DISPLAY artq400_filter_parser('rtdx101') TO s_detail2[1].b_rtdx101
            DISPLAY artq400_filter_parser('rtdx020') TO s_detail2[1].b_rtdx020
            DISPLAY artq400_filter_parser('rtdx021') TO s_detail2[1].b_rtdx021
            DISPLAY artq400_filter_parser('rtdx017') TO s_detail2[1].b_rtdx017
            DISPLAY artq400_filter_parser('rtdx018') TO s_detail2[1].b_rtdx018
            DISPLAY artq400_filter_parser('rtdx019') TO s_detail2[1].b_rtdx019
            DISPLAY artq400_filter_parser('rtdx102') TO s_detail2[1].b_rtdx102
            DISPLAY artq400_filter_parser('rtdx103') TO s_detail2[1].b_rtdx103
            DISPLAY artq400_filter_parser('rtdx046') TO s_detail2[1].b_rtdx046
            DISPLAY artq400_filter_parser('rtdx022') TO s_detail2[1].b_rtdx022
            DISPLAY artq400_filter_parser('rtdx023') TO s_detail2[1].b_rtdx023
            DISPLAY artq400_filter_parser('rtdx024') TO s_detail2[1].b_rtdx024
            DISPLAY artq400_filter_parser('rtdx025') TO s_detail2[1].b_rtdx025
            DISPLAY artq400_filter_parser('rtdx026') TO s_detail2[1].b_rtdx026
            DISPLAY artq400_filter_parser('rtdx036') TO s_detail2[1].b_rtdx036
            DISPLAY artq400_filter_parser('rtdx037') TO s_detail2[1].b_rtdx037
            DISPLAY artq400_filter_parser('rtdx038') TO s_detail2[1].b_rtdx038
            DISPLAY artq400_filter_parser('rtdx039') TO s_detail2[1].b_rtdx039
            DISPLAY artq400_filter_parser('rtdx040') TO s_detail2[1].b_rtdx040
            DISPLAY artq400_filter_parser('rtdx047') TO s_detail2[1].b_rtdx047
            DISPLAY artq400_filter_parser('rtdx048') TO s_detail2[1].b_rtdx048
            DISPLAY artq400_filter_parser('rtdx045') TO s_detail2[1].b_rtdx045
            DISPLAY artq400_filter_parser('imaf112') TO s_detail2[1].b_imaf112
            DISPLAY artq400_filter_parser('imaf113') TO s_detail2[1].b_imaf113
            DISPLAY artq400_filter_parser('imaf114') TO s_detail2[1].b_imaf114
            DISPLAY artq400_filter_parser('imaf115') TO s_detail2[1].b_imaf115
            DISPLAY artq400_filter_parser('imaf122') TO s_detail2[1].b_imaf122
            DISPLAY artq400_filter_parser('rtdx043') TO s_detail3[1].b_rtdx043
            DISPLAY artq400_filter_parser('rtdx006') TO s_detail3[1].b_rtdx006
            DISPLAY artq400_filter_parser('rtdx007') TO s_detail3[1].b_rtdx007
            DISPLAY artq400_filter_parser('rtdx008') TO s_detail3[1].b_rtdx008
            DISPLAY artq400_filter_parser('rtdx009') TO s_detail3[1].b_rtdx009
            DISPLAY artq400_filter_parser('rtdx012') TO s_detail3[1].b_rtdx012
            DISPLAY artq400_filter_parser('rtdxstus') TO s_detail4[1].b_rtdxstus
            DISPLAY artq400_filter_parser('rtdxownid') TO s_detail4[1].b_rtdxownid
            DISPLAY artq400_filter_parser('rtdxowndp') TO s_detail4[1].b_rtdxowndp
            DISPLAY artq400_filter_parser('rtdxcrtid') TO s_detail4[1].b_rtdxcrtid
            DISPLAY artq400_filter_parser('rtdxcrtdp') TO s_detail4[1].b_rtdxcrtdp
            DISPLAY artq400_filter_parser('rtdxcrtdt') TO s_detail4[1].b_rtdxcrtdt
            DISPLAY artq400_filter_parser('rtdxmodid') TO s_detail4[1].b_rtdxmodid
            DISPLAY artq400_filter_parser('rtdxmoddt') TO s_detail4[1].b_rtdxmoddt
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<rtdxcrtdt>>----
         AFTER FIELD rtdxcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<rtdxmoddt>>----
         AFTER FIELD rtdxmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdxcnfdt>>----
         #AFTER FIELD rtdxcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<rtdxpstdt>>----
         #AFTER FIELD rtdxpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtdxsite>>----
         #Ctrlp:construct.c.page1.b_rtdxsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxsite
            #add-point:ON ACTION controlp INFIELD b_rtdxsite name="construct.c.filter.page1.b_rtdxsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxsite  #顯示到畫面上
            NEXT FIELD b_rtdxsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxsite_desc>>----
         #----<<b_rtdx001>>----
         #Ctrlp:construct.c.page1.b_rtdx001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD b_rtdx001 name="construct.c.filter.page1.b_rtdx001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx001  #顯示到畫面上
            NEXT FIELD b_rtdx001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx001_desc>>----
         #----<<b_rtdx001_desc_desc>>----
         #----<<b_rtdx002>>----
         #Ctrlp:construct.c.page1.b_rtdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD b_rtdx002 name="construct.c.filter.page1.b_rtdx002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx002  #顯示到畫面上
            NEXT FIELD b_rtdx002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009>>----
         #Ctrlp:construct.c.page1.b_imaa009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_imaa009 name="construct.c.filter.page1.b_imaa009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa009_desc>>----
         #----<<b_rtdx003>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx003
            #add-point:ON ACTION controlp INFIELD b_rtdx003 name="construct.c.filter.page1.b_rtdx003"
            
            #END add-point
 
 
         #----<<b_rtdx010>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx010
            #add-point:ON ACTION controlp INFIELD b_rtdx010 name="construct.c.filter.page1.b_rtdx010"
            
            #END add-point
 
 
         #----<<b_rtdx027>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx027
            #add-point:ON ACTION controlp INFIELD b_rtdx027 name="construct.c.filter.page1.b_rtdx027"
            
            #END add-point
 
 
         #----<<b_rtdx028>>----
         #Ctrlp:construct.c.page1.b_rtdx028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx028
            #add-point:ON ACTION controlp INFIELD b_rtdx028 name="construct.c.filter.page1.b_rtdx028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx028  #顯示到畫面上
            NEXT FIELD b_rtdx028                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx028_desc>>----
         #----<<b_rtdx029>>----
         #Ctrlp:construct.c.page1.b_rtdx029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx029
            #add-point:ON ACTION controlp INFIELD b_rtdx029 name="construct.c.filter.page1.b_rtdx029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_03()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx029  #顯示到畫面上
            NEXT FIELD b_rtdx029                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx029_desc>>----
         #----<<b_rtdx032>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx032
            #add-point:ON ACTION controlp INFIELD b_rtdx032 name="construct.c.filter.page1.b_rtdx032"
            
            #END add-point
 
 
         #----<<b_rtdx041>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx041
            #add-point:ON ACTION controlp INFIELD b_rtdx041 name="construct.c.filter.page1.b_rtdx041"
            
            #END add-point
 
 
         #----<<b_rtdx042>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx042
            #add-point:ON ACTION controlp INFIELD b_rtdx042 name="construct.c.filter.page1.b_rtdx042"
            
            #END add-point
 
 
         #----<<b_rtdx034>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx034
            #add-point:ON ACTION controlp INFIELD b_rtdx034 name="construct.c.filter.page1.b_rtdx034"
            
            #END add-point
 
 
         #----<<b_rtdx051>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx051
            #add-point:ON ACTION controlp INFIELD b_rtdx051 name="construct.c.filter.page1.b_rtdx051"
            
            #END add-point
 
 
         #----<<b_rtdx052>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx052
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx052
            #add-point:ON ACTION controlp INFIELD b_rtdx052 name="construct.c.filter.page1.b_rtdx052"
            
            #END add-point
 
 
         #----<<b_rtdx035>>----
         #Ctrlp:construct.c.page1.b_rtdx035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx035
            #add-point:ON ACTION controlp INFIELD b_rtdx035 name="construct.c.filter.page1.b_rtdx035"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx035  #顯示到畫面上
            NEXT FIELD b_rtdx035                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx035_desc>>----
         #----<<l_rtdx035_oodb006>>----
         #----<<l_rtdx035_oodb005>>----
         #----<<b_imaf143>>----
         #Ctrlp:construct.c.page1.b_imaf143
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf143
            #add-point:ON ACTION controlp INFIELD b_imaf143 name="construct.c.filter.page1.b_imaf143"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf143  #顯示到畫面上
            NEXT FIELD b_imaf143                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf143_desc>>----
         #----<<b_imaf144>>----
         #Ctrlp:construct.c.page1.b_imaf144
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf144
            #add-point:ON ACTION controlp INFIELD b_imaf144 name="construct.c.filter.page1.b_imaf144"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf144  #顯示到畫面上
            NEXT FIELD b_imaf144                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf144_desc>>----
         #----<<b_imaf145>>----
         #Ctrlp:construct.c.filter.page1.b_imaf145
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf145
            #add-point:ON ACTION controlp INFIELD b_imaf145 name="construct.c.filter.page1.b_imaf145"
            
            #END add-point
 
 
         #----<<b_imaf146>>----
         #Ctrlp:construct.c.filter.page1.b_imaf146
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf146
            #add-point:ON ACTION controlp INFIELD b_imaf146 name="construct.c.filter.page1.b_imaf146"
            
            #END add-point
 
 
         #----<<b_rtdx044>>----
         #Ctrlp:construct.c.page1.b_rtdx044
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx044
            #add-point:ON ACTION controlp INFIELD b_rtdx044 name="construct.c.filter.page1.b_rtdx044"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx044  #顯示到畫面上
            NEXT FIELD b_rtdx044                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx044_desc>>----
         #----<<b_imaf153>>----
         #Ctrlp:construct.c.page1.b_imaf153
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf153
            #add-point:ON ACTION controlp INFIELD b_imaf153 name="construct.c.filter.page1.b_imaf153"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf153  #顯示到畫面上
            NEXT FIELD b_imaf153                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf153_desc>>----
         #----<<b_imaf147>>----
         #Ctrlp:construct.c.filter.page1.b_imaf147
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf147
            #add-point:ON ACTION controlp INFIELD b_imaf147 name="construct.c.filter.page1.b_imaf147"
            
            #END add-point
 
 
         #----<<b_imaf152>>----
         #Ctrlp:construct.c.filter.page1.b_imaf152
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf152
            #add-point:ON ACTION controlp INFIELD b_imaf152 name="construct.c.filter.page1.b_imaf152"
            
            #END add-point
 
 
         #----<<b_imaf158>>----
         #Ctrlp:construct.c.filter.page1.b_imaf158
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf158
            #add-point:ON ACTION controlp INFIELD b_imaf158 name="construct.c.filter.page1.b_imaf158"
            
            #END add-point
 
 
         #----<<b_imaf164>>----
         #Ctrlp:construct.c.filter.page1.b_imaf164
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf164
            #add-point:ON ACTION controlp INFIELD b_imaf164 name="construct.c.filter.page1.b_imaf164"
            
            #END add-point
 
 
         #----<<b_imaf166>>----
         #Ctrlp:construct.c.filter.page1.b_imaf166
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf166
            #add-point:ON ACTION controlp INFIELD b_imaf166 name="construct.c.filter.page1.b_imaf166"
            
            #END add-point
 
 
         #----<<rtdxsite_2_desc>>----
         #----<<rtdx001_2_desc>>----
         #----<<rtdx001_2_desc_desc>>----
         #----<<imaa009_2_desc>>----
         #----<<b_rtdx004>>----
         #Ctrlp:construct.c.page2.b_rtdx004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx004
            #add-point:ON ACTION controlp INFIELD b_rtdx004 name="construct.c.filter.page2.b_rtdx004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx004  #顯示到畫面上
            NEXT FIELD b_rtdx004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx004_desc>>----
         #----<<b_rtdx005>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx005
            #add-point:ON ACTION controlp INFIELD b_rtdx005 name="construct.c.filter.page2.b_rtdx005"
            
            #END add-point
 
 
         #----<<b_rtdx011>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx011
            #add-point:ON ACTION controlp INFIELD b_rtdx011 name="construct.c.filter.page2.b_rtdx011"
            
            #END add-point
 
 
         #----<<b_rtdx013>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx013
            #add-point:ON ACTION controlp INFIELD b_rtdx013 name="construct.c.filter.page2.b_rtdx013"
            
            #END add-point
 
 
         #----<<b_rtdx014>>----
         #Ctrlp:construct.c.page2.b_rtdx014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx014
            #add-point:ON ACTION controlp INFIELD b_rtdx014 name="construct.c.filter.page2.b_rtdx014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx014  #顯示到畫面上
            NEXT FIELD b_rtdx014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx014_desc>>----
         #----<<l_rtdx014_oodb006>>----
         #----<<l_rtdx014_oodb005>>----
         #----<<b_rtdx053>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx053
            #add-point:ON ACTION controlp INFIELD b_rtdx053 name="construct.c.filter.page2.b_rtdx053"
            
            #END add-point
 
 
         #----<<b_rtdx054>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx054
            #add-point:ON ACTION controlp INFIELD b_rtdx054 name="construct.c.filter.page2.b_rtdx054"
            
            #END add-point
 
 
         #----<<b_rtdx016>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx016
            #add-point:ON ACTION controlp INFIELD b_rtdx016 name="construct.c.filter.page2.b_rtdx016"
            
            #END add-point
 
 
         #----<<b_rtdx101>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx101
            #add-point:ON ACTION controlp INFIELD b_rtdx101 name="construct.c.filter.page2.b_rtdx101"
            
            #END add-point
 
 
         #----<<b_rtdx020>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx020
            #add-point:ON ACTION controlp INFIELD b_rtdx020 name="construct.c.filter.page2.b_rtdx020"
            
            #END add-point
 
 
         #----<<b_rtdx021>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx021
            #add-point:ON ACTION controlp INFIELD b_rtdx021 name="construct.c.filter.page2.b_rtdx021"
            
            #END add-point
 
 
         #----<<b_rtdx017>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx017
            #add-point:ON ACTION controlp INFIELD b_rtdx017 name="construct.c.filter.page2.b_rtdx017"
            
            #END add-point
 
 
         #----<<b_rtdx018>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx018
            #add-point:ON ACTION controlp INFIELD b_rtdx018 name="construct.c.filter.page2.b_rtdx018"
            
            #END add-point
 
 
         #----<<b_rtdx019>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx019
            #add-point:ON ACTION controlp INFIELD b_rtdx019 name="construct.c.filter.page2.b_rtdx019"
            
            #END add-point
 
 
         #----<<b_rtdx102>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx102
            #add-point:ON ACTION controlp INFIELD b_rtdx102 name="construct.c.filter.page2.b_rtdx102"
            
            #END add-point
 
 
         #----<<b_rtdx103>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx103
            #add-point:ON ACTION controlp INFIELD b_rtdx103 name="construct.c.filter.page2.b_rtdx103"
            
            #END add-point
 
 
         #----<<b_rtdx046>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx046
            #add-point:ON ACTION controlp INFIELD b_rtdx046 name="construct.c.filter.page2.b_rtdx046"
            
            #END add-point
 
 
         #----<<b_rtdx022>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx022
            #add-point:ON ACTION controlp INFIELD b_rtdx022 name="construct.c.filter.page2.b_rtdx022"
            
            #END add-point
 
 
         #----<<b_rtdx023>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx023
            #add-point:ON ACTION controlp INFIELD b_rtdx023 name="construct.c.filter.page2.b_rtdx023"
            
            #END add-point
 
 
         #----<<b_rtdx024>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx024
            #add-point:ON ACTION controlp INFIELD b_rtdx024 name="construct.c.filter.page2.b_rtdx024"
            
            #END add-point
 
 
         #----<<b_rtdx025>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx025
            #add-point:ON ACTION controlp INFIELD b_rtdx025 name="construct.c.filter.page2.b_rtdx025"
            
            #END add-point
 
 
         #----<<b_rtdx026>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx026
            #add-point:ON ACTION controlp INFIELD b_rtdx026 name="construct.c.filter.page2.b_rtdx026"
            
            #END add-point
 
 
         #----<<b_rtdx036>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx036
            #add-point:ON ACTION controlp INFIELD b_rtdx036 name="construct.c.filter.page2.b_rtdx036"
            
            #END add-point
 
 
         #----<<b_rtdx037>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx037
            #add-point:ON ACTION controlp INFIELD b_rtdx037 name="construct.c.filter.page2.b_rtdx037"
            
            #END add-point
 
 
         #----<<b_rtdx038>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx038
            #add-point:ON ACTION controlp INFIELD b_rtdx038 name="construct.c.filter.page2.b_rtdx038"
            
            #END add-point
 
 
         #----<<b_rtdx039>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx039
            #add-point:ON ACTION controlp INFIELD b_rtdx039 name="construct.c.filter.page2.b_rtdx039"
            
            #END add-point
 
 
         #----<<b_rtdx040>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx040
            #add-point:ON ACTION controlp INFIELD b_rtdx040 name="construct.c.filter.page2.b_rtdx040"
            
            #END add-point
 
 
         #----<<b_rtdx047>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx047
            #add-point:ON ACTION controlp INFIELD b_rtdx047 name="construct.c.filter.page2.b_rtdx047"
            
            #END add-point
 
 
         #----<<b_rtdx048>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx048
            #add-point:ON ACTION controlp INFIELD b_rtdx048 name="construct.c.filter.page2.b_rtdx048"
            
            #END add-point
 
 
         #----<<b_rtdx045>>----
         #Ctrlp:construct.c.filter.page2.b_rtdx045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx045
            #add-point:ON ACTION controlp INFIELD b_rtdx045 name="construct.c.filter.page2.b_rtdx045"
            
            #END add-point
 
 
         #----<<rtdx045_desc>>----
         #----<<b_imaf112>>----
         #Ctrlp:construct.c.page2.b_imaf112
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf112
            #add-point:ON ACTION controlp INFIELD b_imaf112 name="construct.c.filter.page2.b_imaf112"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf112  #顯示到畫面上
            NEXT FIELD b_imaf112                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf112_desc>>----
         #----<<b_imaf113>>----
         #Ctrlp:construct.c.page2.b_imaf113
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf113
            #add-point:ON ACTION controlp INFIELD b_imaf113 name="construct.c.filter.page2.b_imaf113"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaf113  #顯示到畫面上
            NEXT FIELD b_imaf113                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaf113_desc>>----
         #----<<b_imaf114>>----
         #Ctrlp:construct.c.filter.page2.b_imaf114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf114
            #add-point:ON ACTION controlp INFIELD b_imaf114 name="construct.c.filter.page2.b_imaf114"
            
            #END add-point
 
 
         #----<<b_imaf115>>----
         #Ctrlp:construct.c.filter.page2.b_imaf115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf115
            #add-point:ON ACTION controlp INFIELD b_imaf115 name="construct.c.filter.page2.b_imaf115"
            
            #END add-point
 
 
         #----<<b_imaf122>>----
         #Ctrlp:construct.c.filter.page2.b_imaf122
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaf122
            #add-point:ON ACTION controlp INFIELD b_imaf122 name="construct.c.filter.page2.b_imaf122"
            
            #END add-point
 
 
         #----<<rtdxsite_3_desc>>----
         #----<<rtdx001_3_desc>>----
         #----<<rtdx001_3_desc_desc>>----
         #----<<imaa009_3_desc>>----
         #----<<b_rtdx043>>----
         #Ctrlp:construct.c.filter.page3.b_rtdx043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx043
            #add-point:ON ACTION controlp INFIELD b_rtdx043 name="construct.c.filter.page3.b_rtdx043"
            
            #END add-point
 
 
         #----<<b_rtdx006>>----
         #Ctrlp:construct.c.page3.b_rtdx006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx006
            #add-point:ON ACTION controlp INFIELD b_rtdx006 name="construct.c.filter.page3.b_rtdx006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa010_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx006  #顯示到畫面上
            NEXT FIELD b_rtdx006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx007>>----
         #Ctrlp:construct.c.filter.page3.b_rtdx007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx007
            #add-point:ON ACTION controlp INFIELD b_rtdx007 name="construct.c.filter.page3.b_rtdx007"
            
            #END add-point
 
 
         #----<<b_rtdx008>>----
         #Ctrlp:construct.c.filter.page3.b_rtdx008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx008
            #add-point:ON ACTION controlp INFIELD b_rtdx008 name="construct.c.filter.page3.b_rtdx008"
            
            #END add-point
 
 
         #----<<b_rtdx009>>----
         #Ctrlp:construct.c.filter.page3.b_rtdx009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx009
            #add-point:ON ACTION controlp INFIELD b_rtdx009 name="construct.c.filter.page3.b_rtdx009"
            
            #END add-point
 
 
         #----<<b_rtdx012>>----
         #Ctrlp:construct.c.filter.page3.b_rtdx012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx012
            #add-point:ON ACTION controlp INFIELD b_rtdx012 name="construct.c.filter.page3.b_rtdx012"
            
            #END add-point
 
 
         #----<<b_rtdxstus>>----
         #Ctrlp:construct.c.filter.page4.b_rtdxstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxstus
            #add-point:ON ACTION controlp INFIELD b_rtdxstus name="construct.c.filter.page4.b_rtdxstus"
            
            #END add-point
 
 
         #----<<rtdxsite_4_desc>>----
         #----<<rtdx001_4_desc>>----
         #----<<rtdx001_4_desc_desc>>----
         #----<<b_rtdxownid>>----
         #Ctrlp:construct.c.page4.b_rtdxownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxownid
            #add-point:ON ACTION controlp INFIELD b_rtdxownid name="construct.c.filter.page4.b_rtdxownid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxownid  #顯示到畫面上
            NEXT FIELD b_rtdxownid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxownid_desc>>----
         #----<<b_rtdxowndp>>----
         #Ctrlp:construct.c.page4.b_rtdxowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxowndp
            #add-point:ON ACTION controlp INFIELD b_rtdxowndp name="construct.c.filter.page4.b_rtdxowndp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxowndp  #顯示到畫面上
            NEXT FIELD b_rtdxowndp                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxowndp_desc>>----
         #----<<b_rtdxcrtid>>----
         #Ctrlp:construct.c.page4.b_rtdxcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxcrtid
            #add-point:ON ACTION controlp INFIELD b_rtdxcrtid name="construct.c.filter.page4.b_rtdxcrtid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxcrtid  #顯示到畫面上
            NEXT FIELD b_rtdxcrtid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxcrtid_desc>>----
         #----<<b_rtdxcrtdp>>----
         #Ctrlp:construct.c.page4.b_rtdxcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxcrtdp
            #add-point:ON ACTION controlp INFIELD b_rtdxcrtdp name="construct.c.filter.page4.b_rtdxcrtdp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxcrtdp  #顯示到畫面上
            NEXT FIELD b_rtdxcrtdp                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxcrtdp_desc>>----
         #----<<b_rtdxcrtdt>>----
         #----<<b_rtdxmodid>>----
         #Ctrlp:construct.c.page4.b_rtdxmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxmodid
            #add-point:ON ACTION controlp INFIELD b_rtdxmodid name="construct.c.filter.page4.b_rtdxmodid"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdxmodid  #顯示到畫面上
            NEXT FIELD b_rtdxmodid                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdxmodid_desc>>----
         #----<<b_rtdxmoddt>>----
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         CALL cl_set_comp_visible("sel", FALSE)
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL artq400_filter_show('rtdxsite','b_rtdxsite')
   CALL artq400_filter_show('rtdx001','b_rtdx001')
   CALL artq400_filter_show('rtdx002','b_rtdx002')
   CALL artq400_filter_show('imaa009','b_imaa009')
   CALL artq400_filter_show('rtdx003','b_rtdx003')
   CALL artq400_filter_show('rtdx010','b_rtdx010')
   CALL artq400_filter_show('rtdx027','b_rtdx027')
   CALL artq400_filter_show('rtdx028','b_rtdx028')
   CALL artq400_filter_show('rtdx029','b_rtdx029')
   CALL artq400_filter_show('rtdx032','b_rtdx032')
   CALL artq400_filter_show('rtdx041','b_rtdx041')
   CALL artq400_filter_show('rtdx042','b_rtdx042')
   CALL artq400_filter_show('rtdx034','b_rtdx034')
   CALL artq400_filter_show('rtdx051','b_rtdx051')
   CALL artq400_filter_show('rtdx052','b_rtdx052')
   CALL artq400_filter_show('rtdx035','b_rtdx035')
   CALL artq400_filter_show('imaf143','b_imaf143')
   CALL artq400_filter_show('imaf144','b_imaf144')
   CALL artq400_filter_show('imaf145','b_imaf145')
   CALL artq400_filter_show('imaf146','b_imaf146')
   CALL artq400_filter_show('rtdx044','b_rtdx044')
   CALL artq400_filter_show('imaf153','b_imaf153')
   CALL artq400_filter_show('imaf147','b_imaf147')
   CALL artq400_filter_show('imaf152','b_imaf152')
   CALL artq400_filter_show('imaf158','b_imaf158')
   CALL artq400_filter_show('imaf164','b_imaf164')
   CALL artq400_filter_show('imaf166','b_imaf166')
   CALL artq400_filter_show('rtdx004','b_rtdx004')
   CALL artq400_filter_show('rtdx005','b_rtdx005')
   CALL artq400_filter_show('rtdx011','b_rtdx011')
   CALL artq400_filter_show('rtdx013','b_rtdx013')
   CALL artq400_filter_show('rtdx014','b_rtdx014')
   CALL artq400_filter_show('rtdx053','b_rtdx053')
   CALL artq400_filter_show('rtdx054','b_rtdx054')
   CALL artq400_filter_show('rtdx016','b_rtdx016')
   CALL artq400_filter_show('rtdx101','b_rtdx101')
   CALL artq400_filter_show('rtdx020','b_rtdx020')
   CALL artq400_filter_show('rtdx021','b_rtdx021')
   CALL artq400_filter_show('rtdx017','b_rtdx017')
   CALL artq400_filter_show('rtdx018','b_rtdx018')
   CALL artq400_filter_show('rtdx019','b_rtdx019')
   CALL artq400_filter_show('rtdx102','b_rtdx102')
   CALL artq400_filter_show('rtdx103','b_rtdx103')
   CALL artq400_filter_show('rtdx046','b_rtdx046')
   CALL artq400_filter_show('rtdx022','b_rtdx022')
   CALL artq400_filter_show('rtdx023','b_rtdx023')
   CALL artq400_filter_show('rtdx024','b_rtdx024')
   CALL artq400_filter_show('rtdx025','b_rtdx025')
   CALL artq400_filter_show('rtdx026','b_rtdx026')
   CALL artq400_filter_show('rtdx036','b_rtdx036')
   CALL artq400_filter_show('rtdx037','b_rtdx037')
   CALL artq400_filter_show('rtdx038','b_rtdx038')
   CALL artq400_filter_show('rtdx039','b_rtdx039')
   CALL artq400_filter_show('rtdx040','b_rtdx040')
   CALL artq400_filter_show('rtdx047','b_rtdx047')
   CALL artq400_filter_show('rtdx048','b_rtdx048')
   CALL artq400_filter_show('rtdx045','b_rtdx045')
   CALL artq400_filter_show('imaf112','b_imaf112')
   CALL artq400_filter_show('imaf113','b_imaf113')
   CALL artq400_filter_show('imaf114','b_imaf114')
   CALL artq400_filter_show('imaf115','b_imaf115')
   CALL artq400_filter_show('imaf122','b_imaf122')
   CALL artq400_filter_show('rtdx043','b_rtdx043')
   CALL artq400_filter_show('rtdx006','b_rtdx006')
   CALL artq400_filter_show('rtdx007','b_rtdx007')
   CALL artq400_filter_show('rtdx008','b_rtdx008')
   CALL artq400_filter_show('rtdx009','b_rtdx009')
   CALL artq400_filter_show('rtdx012','b_rtdx012')
   CALL artq400_filter_show('rtdxstus','b_rtdxstus')
   CALL artq400_filter_show('rtdxownid','b_rtdxownid')
   CALL artq400_filter_show('rtdxowndp','b_rtdxowndp')
   CALL artq400_filter_show('rtdxcrtid','b_rtdxcrtid')
   CALL artq400_filter_show('rtdxcrtdp','b_rtdxcrtdp')
   CALL artq400_filter_show('rtdxcrtdt','b_rtdxcrtdt')
   CALL artq400_filter_show('rtdxmodid','b_rtdxmodid')
   CALL artq400_filter_show('rtdxmoddt','b_rtdxmoddt')
 
    
   CALL artq400_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION artq400_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="artq400.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION artq400_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = artq400_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.insert" >}
#+ insert
PRIVATE FUNCTION artq400_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artq400.modify" >}
#+ modify
PRIVATE FUNCTION artq400_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq400.reproduce" >}
#+ reproduce
PRIVATE FUNCTION artq400_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq400.delete" >}
#+ delete
PRIVATE FUNCTION artq400_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq400.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION artq400_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION artq400_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_rtdx_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtdx_d.getLength() AND g_rtdx_d.getLength() > 0
            LET g_detail_idx = g_rtdx_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtdx_d.getLength() THEN
               LET g_detail_idx = g_rtdx_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="artq400.mask_functions" >}
 &include "erp/art/artq400_mask.4gl"
 
{</section>}
 
{<section id="artq400.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立tmp table (改分頁功能使用)
# Memo...........: 
# Usage..........: CALL artq400_create_tmp()
# Return code....: r_success      TRUE/FALSE
# Date & Author..: 2016/01/08 By Ken  #160107-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION artq400_create_tmp()
   DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE artq400_tmp01            #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
   
   CREATE TEMP TABLE artq400_tmp01(      #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
       sel                   LIKE type_t.chr1, 
       rtdxsite              LIKE rtdx_t.rtdxsite, 
       rtdxsite_desc         LIKE type_t.chr500, 
       rtdx001               LIKE rtdx_t.rtdx001, 
       rtdx001_desc          LIKE type_t.chr500, 
       rtdx001_desc_desc     LIKE type_t.chr500, 
       rtdx002               LIKE rtdx_t.rtdx002, 
       imaa009               LIKE imaa_t.imaa009, 
       imaa009_desc          LIKE type_t.chr500, 
       rtdx003               LIKE rtdx_t.rtdx003, 
       rtdx010               LIKE rtdx_t.rtdx010, 
       rtdx027               LIKE rtdx_t.rtdx027, 
       rtdx028               LIKE rtdx_t.rtdx028, 
       rtdx028_desc          LIKE type_t.chr500, 
       rtdx029               LIKE rtdx_t.rtdx029, 
       rtdx029_desc          LIKE type_t.chr500, 
       rtdx032               LIKE rtdx_t.rtdx032, 
       rtdx041               LIKE rtdx_t.rtdx041, 
       rtdx042               LIKE rtdx_t.rtdx042, 
       rtdx034               LIKE rtdx_t.rtdx034, 
       rtdx051               LIKE rtdx_t.rtdx051, 
       rtdx052               LIKE rtdx_t.rtdx052,
       rtdx035               LIKE rtdx_t.rtdx035, 
       rtdx035_desc          LIKE type_t.chr500, 
       l_rtdx035_oodb006     LIKE type_t.num26_10, 
       l_rtdx035_oodb005     LIKE type_t.chr1, 
       imaf143               LIKE imaf_t.imaf143, 
       imaf143_desc          LIKE type_t.chr500, 
       imaf144               LIKE imaf_t.imaf144, 
       imaf144_desc          LIKE type_t.chr500, 
       imaf145               LIKE imaf_t.imaf145, 
       imaf146               LIKE imaf_t.imaf146, 
       rtdx044               LIKE rtdx_t.rtdx044, 
       rtdx044_desc          LIKE type_t.chr500, 
       imaf153               LIKE imaf_t.imaf153, 
       imaf153_desc          LIKE type_t.chr500, 
       imaf147               LIKE imaf_t.imaf147, 
       imaf152               LIKE imaf_t.imaf152, 
       imaf158               LIKE imaf_t.imaf158, 
       imaf164               LIKE imaf_t.imaf164, 
       imaf166               LIKE imaf_t.imaf166,                
       rtdxsite2             LIKE rtdx_t.rtdxsite,  
       rtdxsite_2_desc       LIKE type_t.chr500, 
       rtdx001_2             LIKE rtdx_t.rtdx001, 
       rtdx001_2_desc        LIKE type_t.chr500, 
       rtdx001_2_desc_desc   LIKE type_t.chr500, 
       rtdx002_2             LIKE rtdx_t.rtdx002, 
       imaa009_2             LIKE imaa_t.imaa009, 
       imaa009_2_desc        LIKE type_t.chr500, 
       rtdx004               LIKE rtdx_t.rtdx004, 
       rtdx004_desc          LIKE type_t.chr500, 
       rtdx005               LIKE rtdx_t.rtdx005, 
       rtdx011               LIKE rtdx_t.rtdx011, 
       rtdx013               LIKE rtdx_t.rtdx013, 
       rtdx014               LIKE rtdx_t.rtdx014, 
       rtdx014_desc          LIKE type_t.chr500, 
       l_rtdx014_oodb006     LIKE type_t.num26_10, 
       l_rtdx014_oodb005     LIKE type_t.chr1, 
       rtdx053               LIKE rtdx_t.rtdx053,
       rtdx054               LIKE rtdx_t.rtdx054,
       rtdx016               LIKE rtdx_t.rtdx016, 
       rtdx101               LIKE rtdx_t.rtdx101, #160506-00009#14 Add By Ken 160512
       rtdx020               LIKE rtdx_t.rtdx020, 
       rtdx021               LIKE rtdx_t.rtdx021,               
       rtdx017               LIKE rtdx_t.rtdx017, 
       rtdx018               LIKE rtdx_t.rtdx018, 
       rtdx019               LIKE rtdx_t.rtdx019, 
       rtdx102               LIKE rtdx_t.rtdx102, #160506-00009#14 Add By Ken 160512
       rtdx103               LIKE rtdx_t.rtdx103, #160506-00009#14 Add By Ken 160512
       rtdx046               LIKE rtdx_t.rtdx046, 
       rtdx022               LIKE rtdx_t.rtdx022, 
       rtdx023               LIKE rtdx_t.rtdx023, 
       rtdx024               LIKE rtdx_t.rtdx024, 
       rtdx025               LIKE rtdx_t.rtdx025, 
       rtdx026               LIKE rtdx_t.rtdx026, 
       rtdx036               LIKE rtdx_t.rtdx036, 
       rtdx037               LIKE rtdx_t.rtdx037, 
       rtdx038               LIKE rtdx_t.rtdx038, 
       rtdx039               LIKE rtdx_t.rtdx039, 
       rtdx040               LIKE rtdx_t.rtdx040,
       rtdx047               LIKE rtdx_t.rtdx047,
       rtdx048               LIKE rtdx_t.rtdx048,       
       rtdx045               LIKE rtdx_t.rtdx045, 
       rtdx045_desc          LIKE type_t.num20_6, 
       imaf112               LIKE imaf_t.imaf112, 
       imaf112_desc          LIKE type_t.chr500, 
       imaf113               LIKE imaf_t.imaf113, 
       imaf113_desc          LIKE type_t.chr500, 
       imaf114               LIKE imaf_t.imaf114, 
       imaf115               LIKE imaf_t.imaf115, 
       imaf122               LIKE imaf_t.imaf122, 
       rtdxsite3             LIKE rtdx_t.rtdxsite, 
       rtdxsite_3_desc       LIKE type_t.chr500, 
       rtdx001_3             LIKE rtdx_t.rtdx001, 
       rtdx001_3_desc        LIKE type_t.chr500, 
       rtdx001_3_desc_desc   LIKE type_t.chr500, 
       rtdx002_3             LIKE rtdx_t.rtdx002, 
       imaa009_3             LIKE imaa_t.imaa009, 
       imaa009_3_desc        LIKE type_t.chr500, 
       rtdx043               LIKE rtdx_t.rtdx043, 
       rtdx006               LIKE rtdx_t.rtdx006, 
       rtdx007               LIKE rtdx_t.rtdx007, 
       rtdx008               LIKE rtdx_t.rtdx008, 
       rtdx009               LIKE rtdx_t.rtdx009, 
       rtdx012               LIKE rtdx_t.rtdx012,       
       rtdxstus              LIKE rtdx_t.rtdxstus, 
       rtdxsite4             LIKE rtdx_t.rtdxsite, 
       rtdxsite_4_desc       LIKE type_t.chr500, 
       rtdx001_4             LIKE rtdx_t.rtdx001, 
       rtdx001_4_desc        LIKE type_t.chr500, 
       rtdx001_4_desc_desc   LIKE type_t.chr500, 
       rtdxownid             LIKE rtdx_t.rtdxownid, 
       rtdxownid_desc        LIKE type_t.chr500, 
       rtdxowndp             LIKE rtdx_t.rtdxowndp, 
       rtdxowndp_desc        LIKE type_t.chr500, 
       rtdxcrtid             LIKE rtdx_t.rtdxcrtid, 
       rtdxcrtid_desc        LIKE type_t.chr500, 
       rtdxcrtdp             LIKE rtdx_t.rtdxcrtdp, 
       rtdxcrtdp_desc        LIKE type_t.chr500, 
       rtdxcrtdt             LIKE rtdx_t.rtdxcrtdt,   
       rtdxmodid             LIKE rtdx_t.rtdxmodid, 
       rtdxmodid_desc        LIKE type_t.chr500, 
       rtdxmoddt             LIKE rtdx_t.rtdxmoddt,                   
       RANK                  LIKE type_t.num20,
       rtdxent               LIKE rtdx_t.rtdxent)   
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table artq400_tmp01'       #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
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
PRIVATE FUNCTION artq400_drop_tmp()
   DROP TABLE artq400_tmp01         #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
END FUNCTION

################################################################################
# Descriptions...: 匯出Excel使用的Array
# Memo...........: 把查詢到的全部資料寫入匯出Excel專用的Array
# Usage..........: CALL artq400_to_excel()
# Date & Author..: 20156/01/08 By Ken  #160107-00016#1
# Modify.........:
################################################################################
PRIVATE FUNCTION artq400_to_excel()
DEFINE g_sql         STRING

   CALL cl_progress_bar(g_tot_cnt/1000+1)
   CALL cl_progress_ing("Data processing... ")
   LET g_sql  = " SELECT sel,              rtdxsite,          rtdxsite_desc,       rtdx001,           rtdx001_desc, ",
                "        rtdx001_desc_desc,rtdx002,           imaa009,             imaa009_desc,      rtdx003,      ",
                "        rtdx010,          rtdx027,           rtdx028,             rtdx028_desc,      rtdx029,      ",
                "        rtdx029_desc,     rtdx032,           rtdx041,             rtdx042,           rtdx034,      ",
                "        rtdx051,          rtdx052,           rtdx035,             rtdx035_desc,      l_rtdx035_oodb006, l_rtdx035_oodb005, ",
                "        imaf143,          imaf143_desc,      imaf144,             imaf144_desc,      imaf145,      ",
                "        imaf146,          rtdx044,           rtdx044_desc,        imaf153,           imaf153_desc, ",
                "        imaf147,          imaf152,           imaf158,             imaf164,           imaf166,      ",
                "        rtdxsite2,        rtdxsite_2_desc,   rtdx001_2,           rtdx001_2_desc,    rtdx001_2_desc_desc, ",
                "        rtdx002_2,        imaa009_2,         imaa009_2_desc,      rtdx004,           rtdx004_desc, ",
                "        rtdx005,          rtdx011,           rtdx013,             rtdx014,           rtdx014_desc, ",
                "        l_rtdx014_oodb006,l_rtdx014_oodb005, rtdx053,             rtdx054,           rtdx016,      ",
                "        rtdx101,          rtdx020,           rtdx021,             rtdx017,           rtdx018,      ",  #160506-00009#14 Add By Ken 160512 加rtdx101
                "        rtdx019,          rtdx102,           rtdx103,             rtdx046,           rtdx022,      ",  #160506-00009#14 Add By Ken 160512 加rtdx102,rtdx103
                "        rtdx023,          rtdx024,           rtdx025,             rtdx026,           rtdx036,      ",
                "        rtdx037,          rtdx038,           rtdx039,             rtdx040,           rtdx047,             rtdx048,           rtdx045,      ",
                "        rtdx045_desc,     imaf112,           imaf112_desc,        imaf113,           imaf113_desc, ",
                "        imaf114,          imaf115,           imaf122,             rtdxsite3,         rtdxsite_3_desc, ",
                "        rtdx001_3,        rtdx001_3_desc,    rtdx001_3_desc_desc, rtdx002_3,         imaa009_3,      ",
                "        imaa009_3_desc,   rtdx043,           rtdx006,             rtdx007,           rtdx008,      ",
                "        rtdx009,          rtdx012,           rtdxstus,            rtdxsite4,         rtdxsite_4_desc, ",
                "        rtdx001_4,        rtdx001_4_desc,    rtdx001_4_desc_desc, rtdxownid,         rtdxownid_desc, ",
                "        rtdxowndp,        rtdxowndp_desc,    rtdxcrtid,           rtdxcrtid_desc,    rtdxcrtdp,    ",
                "        rtdxcrtdp_desc,   rtdxcrtdt,         rtdxmodid,           rtdxmodid_desc,    rtdxmoddt    ",
                "   FROM artq400_tmp01 ",        #160727-00019#16 Mod   artq400_rtdx_tmp -->artq400_tmp01
                "  WHERE rtdxent = ? " 

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq400_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR artq400_pb1
   
   OPEN b_fill_curs1 USING g_enterprise
 
   CALL g_rtdx_d2.clear()
   CALL g_rtdx2_d2.clear()   
 
   CALL g_rtdx3_d2.clear()   
 
   CALL g_rtdx4_d2.clear() 
   
   LET l_ac = 1
   FOREACH b_fill_curs1 INTO g_rtdx_d2[l_ac].sel,               g_rtdx_d2[l_ac].rtdxsite,       g_rtdx_d2[l_ac].rtdxsite_desc, 
                             g_rtdx_d2[l_ac].rtdx001,           g_rtdx_d2[l_ac].rtdx001_desc,   g_rtdx_d2[l_ac].rtdx001_desc_desc,
                             g_rtdx_d2[l_ac].rtdx002,           g_rtdx_d2[l_ac].imaa009,        g_rtdx_d2[l_ac].imaa009_desc,
                             g_rtdx_d2[l_ac].rtdx003,           g_rtdx_d2[l_ac].rtdx010,        g_rtdx_d2[l_ac].rtdx027,
                             g_rtdx_d2[l_ac].rtdx028,           g_rtdx_d2[l_ac].rtdx028_desc,   g_rtdx_d2[l_ac].rtdx029, 
                             g_rtdx_d2[l_ac].rtdx029_desc,      g_rtdx_d2[l_ac].rtdx032,        g_rtdx_d2[l_ac].rtdx041,
                             g_rtdx_d2[l_ac].rtdx042,           g_rtdx_d2[l_ac].rtdx034,        g_rtdx_d2[l_ac].rtdx051,    g_rtdx_d2[l_ac].rtdx052,
                             g_rtdx_d2[l_ac].rtdx035,           g_rtdx_d2[l_ac].rtdx035_desc,   g_rtdx_d2[l_ac].l_rtdx035_oodb006,
                             g_rtdx_d2[l_ac].l_rtdx035_oodb005, g_rtdx_d2[l_ac].imaf143,        g_rtdx_d2[l_ac].imaf143_desc, 
                             g_rtdx_d2[l_ac].imaf144,           g_rtdx_d2[l_ac].imaf144_desc,   g_rtdx_d2[l_ac].imaf145,
                             g_rtdx_d2[l_ac].imaf146,           g_rtdx_d2[l_ac].rtdx044,        g_rtdx_d2[l_ac].rtdx044_desc,
                             g_rtdx_d2[l_ac].imaf153,           g_rtdx_d2[l_ac].imaf153_desc,   g_rtdx_d2[l_ac].imaf147,
                             g_rtdx_d2[l_ac].imaf152,           g_rtdx_d2[l_ac].imaf158,        g_rtdx_d2[l_ac].imaf164,
                             g_rtdx_d2[l_ac].imaf166,           
                             g_rtdx2_d2[l_ac].rtdxsite,         g_rtdx2_d2[l_ac].rtdxsite_2_desc,     g_rtdx2_d2[l_ac].rtdx001,
                             g_rtdx2_d2[l_ac].rtdx001_2_desc,   g_rtdx2_d2[l_ac].rtdx001_2_desc_desc, g_rtdx2_d2[l_ac].rtdx002,
                             g_rtdx2_d2[l_ac].imaa009,          g_rtdx2_d2[l_ac].imaa009_2_desc,      g_rtdx2_d2[l_ac].rtdx004,
                             g_rtdx2_d2[l_ac].rtdx004_desc,     g_rtdx2_d2[l_ac].rtdx005,             g_rtdx2_d2[l_ac].rtdx011, 
                             g_rtdx2_d2[l_ac].rtdx013,          g_rtdx2_d2[l_ac].rtdx014,             g_rtdx2_d2[l_ac].rtdx014_desc,
                             g_rtdx2_d2[l_ac].l_rtdx014_oodb006,g_rtdx2_d2[l_ac].l_rtdx014_oodb005,   g_rtdx2_d2[l_ac].rtdx053,    
                             g_rtdx2_d2[l_ac].rtdx054,          g_rtdx2_d2[l_ac].rtdx016,             g_rtdx2_d2[l_ac].rtdx101,  #160506-00009#14 Add By Ken 160512 加rtdx101
                             g_rtdx2_d2[l_ac].rtdx020,          g_rtdx2_d2[l_ac].rtdx021,             g_rtdx2_d2[l_ac].rtdx017,  
                             g_rtdx2_d2[l_ac].rtdx018,          g_rtdx2_d2[l_ac].rtdx019,             g_rtdx2_d2[l_ac].rtdx102,  #160506-00009#14 Add By Ken 160512 加rtdx102
                             g_rtdx2_d2[l_ac].rtdx103,          g_rtdx2_d2[l_ac].rtdx046,                                        #160506-00009#14 Add By Ken 160512 加rtdx103
                             g_rtdx2_d2[l_ac].rtdx022,          g_rtdx2_d2[l_ac].rtdx023,             g_rtdx2_d2[l_ac].rtdx024,
                             g_rtdx2_d2[l_ac].rtdx025,          g_rtdx2_d2[l_ac].rtdx026,             g_rtdx2_d2[l_ac].rtdx036,
                             g_rtdx2_d2[l_ac].rtdx037,          g_rtdx2_d2[l_ac].rtdx038,             g_rtdx2_d2[l_ac].rtdx039,
                             g_rtdx2_d2[l_ac].rtdx040,          g_rtdx2_d2[l_ac].rtdx047,             g_rtdx2_d2[l_ac].rtdx048,    g_rtdx2_d2[l_ac].rtdx045,             g_rtdx2_d2[l_ac].rtdx045_desc, 
                             g_rtdx2_d2[l_ac].imaf112,          g_rtdx2_d2[l_ac].imaf112_desc,        g_rtdx2_d2[l_ac].imaf113,
                             g_rtdx2_d2[l_ac].imaf113_desc,     g_rtdx2_d2[l_ac].imaf114,             g_rtdx2_d2[l_ac].imaf115,
                             g_rtdx2_d2[l_ac].imaf122,
                             g_rtdx3_d2[l_ac].rtdxsite,         g_rtdx3_d2[l_ac].rtdxsite_3_desc,     g_rtdx3_d2[l_ac].rtdx001,
                             g_rtdx3_d2[l_ac].rtdx001_3_desc,   g_rtdx3_d2[l_ac].rtdx001_3_desc_desc, g_rtdx3_d2[l_ac].rtdx002,
                             g_rtdx3_d2[l_ac].imaa009,          g_rtdx3_d2[l_ac].imaa009_3_desc,      g_rtdx3_d2[l_ac].rtdx043, 
                             g_rtdx3_d2[l_ac].rtdx006,          g_rtdx3_d2[l_ac].rtdx007,             g_rtdx3_d2[l_ac].rtdx008,
                             g_rtdx3_d2[l_ac].rtdx009,          g_rtdx3_d2[l_ac].rtdx012,             
                             g_rtdx4_d2[l_ac].rtdxstus,         g_rtdx4_d2[l_ac].rtdxsite,            g_rtdx4_d2[l_ac].rtdxsite_4_desc, 
                             g_rtdx4_d2[l_ac].rtdx001,          g_rtdx4_d2[l_ac].rtdx001_4_desc,      g_rtdx4_d2[l_ac].rtdx001_4_desc_desc,
                             g_rtdx4_d2[l_ac].rtdxownid,        g_rtdx4_d2[l_ac].rtdxownid_desc,      g_rtdx4_d2[l_ac].rtdxowndp,
                             g_rtdx4_d2[l_ac].rtdxowndp_desc,   g_rtdx4_d2[l_ac].rtdxcrtid,           g_rtdx4_d2[l_ac].rtdxcrtid_desc,
                             g_rtdx4_d2[l_ac].rtdxcrtdp,        g_rtdx4_d2[l_ac].rtdxcrtdp_desc,      g_rtdx4_d2[l_ac].rtdxcrtdt, 
                             g_rtdx4_d2[l_ac].rtdxmodid,        g_rtdx4_d2[l_ac].rtdxmodid_desc,      g_rtdx4_d2[l_ac].rtdxmoddt
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF     
      
      
      IF l_ac MOD 1000 = 0 THEN
         CALL cl_progress_ing("Data processing... ")
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
END FUNCTION

 
{</section>}
 
