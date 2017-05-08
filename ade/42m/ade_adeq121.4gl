#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq121.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-11 16:22:21), PR版次:0003(2016-09-01 18:26:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: adeq121
#+ Description: 小類門店對比分析查詢作業
#+ Creator....: 06814(2016-04-06 16:46:16)
#+ Modifier...: 06814 -SD/PR- 08742
 
{</section>}
 
{<section id="adeq121.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   adeq121_site_temp -->adeq121_tmp01
#                                      Mod   adeq121_data_temp -->adeq121_tmp02
#                                      Mod   adeq121_data_temp1 -->adeq121_tmp03
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
PRIVATE TYPE type_g_deba_d RECORD
       
       sel LIKE type_t.chr1, 
   l_deba016_5 LIKE type_t.chr10, 
   deba016_desc_desc LIKE type_t.chr500, 
   l_deba016_6 LIKE type_t.chr10, 
   deba016_desc_desc_desc LIKE type_t.chr500, 
   deba016 LIKE deba_t.deba016, 
   deba016_desc LIKE type_t.chr500, 
   deba013 LIKE deba_t.deba013, 
   deba013_desc LIKE type_t.chr500, 
   l_sum_ndeba026 LIKE type_t.num20_6, 
   l_sum_ldeba026 LIKE type_t.num20_6, 
   l_count0 LIKE type_t.num20_6, 
   l_count1 LIKE type_t.num20_6, 
   l_count2 LIKE type_t.num20_6, 
   l_count5 LIKE type_t.num20_6, 
   l_count3 LIKE type_t.num20_6, 
   l_count4 LIKE type_t.num20_6, 
   l_sum_ndeba026_1 LIKE type_t.num20_6, 
   l_sum_ldeba026_1 LIKE type_t.num20_6, 
   l_count0_1 LIKE type_t.num20_6, 
   l_count1_1 LIKE type_t.num20_6, 
   l_count2_1 LIKE type_t.num20_6, 
   l_count5_1 LIKE type_t.num20_6, 
   l_count3_1 LIKE type_t.num20_6, 
   l_count4_1 LIKE type_t.num20_6, 
   l_sum_ndeba026_2 LIKE type_t.num20_6, 
   l_sum_ldeba026_2 LIKE type_t.num20_6, 
   l_count0_2 LIKE type_t.num20_6, 
   l_count1_2 LIKE type_t.num20_6, 
   l_count2_2 LIKE type_t.num20_6, 
   l_count5_2 LIKE type_t.num20_6, 
   l_count3_2 LIKE type_t.num20_6, 
   l_count4_2 LIKE type_t.num20_6, 
   l_sum_ndeba026_3 LIKE type_t.num20_6, 
   l_sum_ldeba026_3 LIKE type_t.num20_6, 
   l_count0_3 LIKE type_t.num20_6, 
   l_count1_3 LIKE type_t.num20_6, 
   l_count2_3 LIKE type_t.num20_6, 
   l_count5_3 LIKE type_t.num20_6, 
   l_count3_3 LIKE type_t.num20_6, 
   l_count4_3 LIKE type_t.num20_6, 
   l_sum_ndeba026_4 LIKE type_t.num20_6, 
   l_sum_ldeba026_4 LIKE type_t.num20_6, 
   l_count0_4 LIKE type_t.num20_6, 
   l_count1_4 LIKE type_t.num20_6, 
   l_count2_4 LIKE type_t.num20_6, 
   l_count5_4 LIKE type_t.num20_6, 
   l_count3_4 LIKE type_t.num20_6, 
   l_count4_4 LIKE type_t.num20_6, 
   l_sum_ndeba026_5 LIKE type_t.num20_6, 
   l_sum_ldeba026_5 LIKE type_t.num20_6, 
   l_count0_5 LIKE type_t.num20_6, 
   l_count1_5 LIKE type_t.num20_6, 
   l_count2_5 LIKE type_t.num20_6, 
   l_count5_5 LIKE type_t.num20_6, 
   l_count3_5 LIKE type_t.num20_6, 
   l_count4_5 LIKE type_t.num20_6, 
   l_sum_ndeba026_6 LIKE type_t.num20_6, 
   l_sum_ldeba026_6 LIKE type_t.num20_6, 
   l_count0_6 LIKE type_t.num20_6, 
   l_count1_6 LIKE type_t.num20_6, 
   l_count2_6 LIKE type_t.num20_6, 
   l_count5_6 LIKE type_t.num20_6, 
   l_count3_6 LIKE type_t.num20_6, 
   l_count4_6 LIKE type_t.num20_6, 
   l_sum_ndeba026_7 LIKE type_t.num20_6, 
   l_sum_ldeba026_7 LIKE type_t.num20_6, 
   l_count0_7 LIKE type_t.num20_6, 
   l_count1_7 LIKE type_t.num20_6, 
   l_count2_7 LIKE type_t.num20_6, 
   l_count5_7 LIKE type_t.num20_6, 
   l_count3_7 LIKE type_t.num20_6, 
   l_count4_7 LIKE type_t.num20_6, 
   l_sum_ndeba026_8 LIKE type_t.num20_6, 
   l_sum_ldeba026_8 LIKE type_t.num20_6, 
   l_count0_8 LIKE type_t.num20_6, 
   l_count1_8 LIKE type_t.num20_6, 
   l_count2_8 LIKE type_t.num20_6, 
   l_count5_8 LIKE type_t.num20_6, 
   l_count3_8 LIKE type_t.num20_6, 
   l_count4_8 LIKE type_t.num20_6, 
   l_sum_ndeba026_9 LIKE type_t.num20_6, 
   l_sum_ldeba026_9 LIKE type_t.num20_6, 
   l_count0_9 LIKE type_t.num20_6, 
   l_count1_9 LIKE type_t.num20_6, 
   l_count2_9 LIKE type_t.num20_6, 
   l_count5_9 LIKE type_t.num20_6, 
   l_count3_9 LIKE type_t.num20_6, 
   l_count4_9 LIKE type_t.num20_6, 
   l_sum_ndeba026_10 LIKE type_t.num20_6, 
   l_sum_ldeba026_10 LIKE type_t.num20_6, 
   l_count0_10 LIKE type_t.num20_6, 
   l_count1_10 LIKE type_t.num20_6, 
   l_count2_10 LIKE type_t.num20_6, 
   l_count5_10 LIKE type_t.num20_6, 
   l_count3_10 LIKE type_t.num20_6, 
   l_count4_10 LIKE type_t.num20_6, 
   l_sum_ndeba026_11 LIKE type_t.num20_6, 
   l_sum_ldeba026_11 LIKE type_t.num20_6, 
   l_count0_11 LIKE type_t.num20_6, 
   l_count1_11 LIKE type_t.num20_6, 
   l_count2_11 LIKE type_t.num20_6, 
   l_count5_11 LIKE type_t.num20_6, 
   l_count3_11 LIKE type_t.num20_6, 
   l_count4_11 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_head                    RECORD
       debasite                  LIKE deba_t.debasite,
       l_bdate_1                 LIKE type_t.dat,
       l_edate_1                 LIKE type_t.dat,
       deba013                   LIKE deba_t.deba013,
       l_deba016_3               LIKE deba_t.deba016,
       l_deba016_4               LIKE deba_t.deba016,
       deba016                   LIKE deba_t.deba016,
       deba049                   LIKE deba_t.deba049
                                 END RECORD
DEFINE g_site_cnt                LIKE type_t.num5 #查詢的site數量
DEFINE g_para                    LIKE type_t.num5
DEFINE g_debasite                LIKE type_t.chr500
DEFINE g_bdate_last              LIKE type_t.dat
DEFINE g_edate_last              LIKE type_t.dat
DEFINE g_time1                   DATETIME YEAR TO FRACTION
DEFINE g_time2                   DATETIME YEAR TO FRACTION
DEFINE g_deba_d_color            DYNAMIC ARRAY OF RECORD
       sel                       STRING, 
       l_deba016_5               STRING, 
       deba016_desc_desc         STRING, 
       l_deba016_6               STRING, 
       deba016_desc_desc_desc    STRING, 
       deba016                   STRING, 
       deba016_desc              STRING, 
       deba013                   STRING, 
       deba013_desc              STRING, 
       l_sum_ndeba026            STRING, 
       l_sum_ldeba026            STRING, 
       l_count0                  STRING, 
       l_count1                  STRING, 
       l_count2                  STRING, 
       l_count5                  STRING, 
       l_count3                  STRING, 
       l_count4                  STRING, 
       l_sum_ndeba026_1          STRING, 
       l_sum_ldeba026_1          STRING, 
       l_count0_1                STRING, 
       l_count1_1                STRING, 
       l_count2_1                STRING, 
       l_count5_1                STRING, 
       l_count3_1                STRING, 
       l_count4_1                STRING, 
       l_sum_ndeba026_2          STRING, 
       l_sum_ldeba026_2          STRING, 
       l_count0_2                STRING, 
       l_count1_2                STRING, 
       l_count2_2                STRING, 
       l_count5_2                STRING, 
       l_count3_2                STRING, 
       l_count4_2                STRING, 
       l_sum_ndeba026_3          STRING, 
       l_sum_ldeba026_3          STRING, 
       l_count0_3                STRING, 
       l_count1_3                STRING, 
       l_count2_3                STRING, 
       l_count5_3                STRING, 
       l_count3_3                STRING, 
       l_count4_3                STRING, 
       l_sum_ndeba026_4          STRING, 
       l_sum_ldeba026_4          STRING, 
       l_count0_4                STRING, 
       l_count1_4                STRING, 
       l_count2_4                STRING, 
       l_count5_4                STRING, 
       l_count3_4                STRING, 
       l_count4_4                STRING, 
       l_sum_ndeba026_5          STRING, 
       l_sum_ldeba026_5          STRING, 
       l_count0_5                STRING, 
       l_count1_5                STRING, 
       l_count2_5                STRING, 
       l_count5_5                STRING, 
       l_count3_5                STRING, 
       l_count4_5                STRING, 
       l_sum_ndeba026_6          STRING, 
       l_sum_ldeba026_6          STRING, 
       l_count0_6                STRING, 
       l_count1_6                STRING, 
       l_count2_6                STRING, 
       l_count5_6                STRING, 
       l_count3_6                STRING, 
       l_count4_6                STRING, 
       l_sum_ndeba026_7          STRING, 
       l_sum_ldeba026_7          STRING, 
       l_count0_7                STRING, 
       l_count1_7                STRING, 
       l_count2_7                STRING, 
       l_count5_7                STRING, 
       l_count3_7                STRING, 
       l_count4_7                STRING, 
       l_sum_ndeba026_8          STRING, 
       l_sum_ldeba026_8          STRING, 
       l_count0_8                STRING, 
       l_count1_8                STRING, 
       l_count2_8                STRING, 
       l_count5_8                STRING, 
       l_count3_8                STRING, 
       l_count4_8                STRING, 
       l_sum_ndeba026_9          STRING, 
       l_sum_ldeba026_9          STRING, 
       l_count0_9                STRING, 
       l_count1_9                STRING, 
       l_count2_9                STRING, 
       l_count5_9                STRING, 
       l_count3_9                STRING, 
       l_count4_9                STRING, 
       l_sum_ndeba026_10         STRING, 
       l_sum_ldeba026_10         STRING, 
       l_count0_10               STRING, 
       l_count1_10               STRING, 
       l_count2_10               STRING, 
       l_count5_10               STRING, 
       l_count3_10               STRING, 
       l_count4_10               STRING, 
       l_sum_ndeba026_11         STRING, 
       l_sum_ldeba026_11         STRING, 
       l_count0_11               STRING, 
       l_count1_11               STRING, 
       l_count2_11               STRING, 
       l_count5_11               STRING, 
       l_count3_11               STRING, 
       l_count4_11               STRING
                                 END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_deba_d            DYNAMIC ARRAY OF type_g_deba_d
DEFINE g_deba_d_t          type_g_deba_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adeq121.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
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
   DECLARE adeq121_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq121_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq121_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq121 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq121_init()   
 
      #進入選單 Menu (="N")
      CALL adeq121_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq121
      
   END IF 
   
   CLOSE adeq121_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL adeq121_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq121.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq121_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   DEFINE l_session LIKE type_t.num10
   DEFINE l_str     STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('deba049','6013') 
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq121_create_temp() RETURNING l_success
   LET g_site_cnt = 0
   
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   LET l_str = l_session
   LET l_str = l_str.trim()
   DISPLAY "[adeq121_session_id:] ",l_session
   DISPLAY "[sel_temp_sql:] "
   DISPLAY "SELECT * FROM ", "TT",l_str,"_ADEQ121_TMP02;"          #160727-00019#10 Mod   ADEQ121_DATA_TEMP -->adeq121_tmp02
   DISPLAY "SELECT * FROM ", "TT",l_str,"_ADEQ121_TMP03;"         #160727-00019#10 Mod   ADEQ121_DATA_TEMP1 -->adeq121_tmp03
   DISPLAY "SELECT * FROM ", "TT",l_str,"_ADEQ121_TMP01;"          #160727-00019#10 Mod   ADEQ121_SITE_TEMP -->adeq121_tmp01
   #end add-point
 
   CALL adeq121_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq121.default_search" >}
PRIVATE FUNCTION adeq121_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " debasite = '", g_argv[02], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " deba002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " deba005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " deba009 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " deba017 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " deba018 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " deba020 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " deba043 = '", g_argv[09], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq121_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
   CALL adeq121_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deba_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL adeq121_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_head.l_bdate_1,g_head.l_edate_1,g_head.deba049
             FROM l_bdate_1,l_edate_1,deba049  
           
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON deba013,l_deba016_3,l_deba016_4,deba016
           
            ON ACTION controlp INFIELD deba013
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO deba013  #顯示到畫面上
               NEXT FIELD deba013                     #返回原欄位
            
            ON ACTION controlp INFIELD l_deba016_3
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rtax004 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' "
               CALL q_rtax001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_deba016_3  #顯示到畫面上
               NEXT FIELD l_deba016_3                     #返回原欄位
               
            ON ACTION controlp INFIELD l_deba016_4
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rtax004 = '",cl_get_para(g_enterprise,"","E-CIR-0062"),"' " 
               CALL q_rtax001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO l_deba016_4  #顯示到畫面上
               NEXT FIELD l_deba016_4                     #返回原欄位
               
            ON ACTION controlp INFIELD deba016
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO deba016  #顯示到畫面上
               NEXT FIELD deba016                     #返回原欄位
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc2 ON debasite          
            BEFORE CONSTRUCT 
               LET g_debasite = GET_FLDBUF(debasite)
               
            ON ACTION controlp INFIELD debasite
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')
               CALL q_ooef001_24()                    #呼叫開窗
               DISPLAY g_qryparam.return1 TO debasite    #顯示到畫面上
               LET g_debasite = GET_FLDBUF(debasite)
               NEXT FIELD debasite                    #返回原欄位
               
            AFTER CONSTRUCT 
               LET g_debasite = GET_FLDBUF(debasite)
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_deba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq121_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq121_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq121_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE) 
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            #LET g_head.debasite = g_site
            #LET g_wc_site = g_site 
            LET g_head.l_bdate_1 = g_today
            LET g_head.l_edate_1 = g_today
            LET g_head.deba049 = '1'
            LET g_site_cnt = 0   #site計數重製
            CALL DIALOG.setCellAttributes(g_deba_d_color)    #参数：屏幕变量,属性数组
            CALL DIALOG.setArrayAttributes("s_detail1",g_deba_d_color)    #参数：屏幕变量,属性数组 
            #end add-point
            NEXT FIELD debasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            LET g_debasite = GET_FLDBUF(debasite)
            CALL s_date_get_date(g_head.l_bdate_1,-12,0) RETURNING g_bdate_last
            CALL s_date_get_date(g_head.l_edate_1,-12,0) RETURNING g_edate_last
            IF cl_null(g_debasite) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'sub-00507'
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               NEXT FIELD debasite
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adeq121_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_deba_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq121_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL adeq121_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq121_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq121_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq121_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_deba_d.getLength()
               LET g_deba_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_deba_d.getLength()
               LET g_deba_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_deba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deba_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_deba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deba_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq121_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq121_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_orderby       STRING
   DEFINE l_i       LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL cl_get_para(g_enterprise,"","E-CIR-0062") RETURNING g_para
   

   CALL s_aooi500_sql_where(g_prog,'debasite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   LET g_wc = g_wc," AND ",l_where
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_deba_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','',deba016,'',deba013,'','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY deba_t.debasite, 
       deba_t.deba002,deba_t.deba005,deba_t.deba009,deba_t.deba017,deba_t.deba018,deba_t.deba020,deba_t.deba043) AS RANK FROM deba_t", 
 
 
 
                     "",
                     " WHERE debaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deba_t"),
                     " ORDER BY deba_t.debasite,deba_t.deba002,deba_t.deba005,deba_t.deba009,deba_t.deba017,deba_t.deba018,deba_t.deba020,deba_t.deba043"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   IF NOT cl_null(ls_wc) THEN
      LET ls_wc = cl_str_replace(ls_wc,"l_deba016_4","t2.rtaw001")
      LET ls_wc = cl_str_replace(ls_wc,"l_deba016_3","t1.deba053")
   END IF
   
   #條件若不是1=2
   IF NOT ls_wc.getIndexOf(" 1=2",1) THEN 
      CALL adeq121_ins_site_temp() 
      CALL adeq121_ins_data_temp(ls_wc)
   END IF
   CALL adeq121_set_comp_visible()
   CALL adeq121_set_comp_no_visible()
   CALL adeq121_set_comp_visible_b()
   CALL adeq121_set_comp_no_visible_b()
   
   
   

   CASE g_argv[01]
      WHEN '1'
         LET l_orderby = "deba016,deba016_1,deba016_2"
      WHEN '2'
         LET l_orderby = "deba016_2,deba016_1"
      WHEN '3'
         LET l_orderby = "deba013"
   END CASE
   LET ls_sql_rank = "SELECT UNIQUE 'N', ",
                     "       deba016_1, ",
                     "       (SELECT rtaxl003 ",
                     "          FROM rtaxl_t ",
                     "         WHERE rtaxlent = debaent ",
                     "           AND rtaxl001 = deba016_1 ",
                     "           AND rtaxl002 = '",g_dlang,"' ) deba016_1_desc,  ",
                     "       deba016_2,",
                     "       (SELECT rtaxl003 ",
                     "          FROM rtaxl_t ",
                     "         WHERE rtaxlent = debaent ",
                     "           AND rtaxl001 = deba016_2 ",
                     "           AND rtaxl002 = '",g_dlang,"' ) deba016_2_desc, ",
                     "       deba016, ",
                     "       (SELECT rtaxl003 ",
                     "          FROM rtaxl_t ",
                     "         WHERE rtaxlent = debaent ",
                     "           AND rtaxl001 = deba016 ",
                     "           AND rtaxl002 = '",g_dlang,"' ) deba016_desc,",
                     "       deba013,",
                     "       (SELECT oocql004 ",
                     "          FROM oocql_t ",
                     "         WHERE oocqlent = debaent ",
                     "           AND oocql001 = '2002' ",
                     "           AND oocql002 = deba013 ",
                     "           AND oocql003 = '",g_dlang,"' ) deba013_desc,",
                     "       sum_deba026,sum_deba026_o,cnt_deba026,percent_deba026,",
                     "       sum_deba027,sum_deba027_o,cnt_deba027,percent_deba027, ",
                     "       sum_deba026_1,sum_deba026_o_1,cnt_deba026_1,percent_deba026_1,sum_deba027_1,sum_deba027_o_1,cnt_deba027_1,percent_deba027_1, ",
                     "       sum_deba026_2,sum_deba026_o_2,cnt_deba026_2,percent_deba026_2,sum_deba027_2,sum_deba027_o_2,cnt_deba027_2,percent_deba027_2, ",
                     "       sum_deba026_3,sum_deba026_o_3,cnt_deba026_3,percent_deba026_3,sum_deba027_3,sum_deba027_o_3,cnt_deba027_3,percent_deba027_3, ",
                     "       sum_deba026_4,sum_deba026_o_4,cnt_deba026_4,percent_deba026_4,sum_deba027_4,sum_deba027_o_4,cnt_deba027_4,percent_deba027_4, ",
                     "       sum_deba026_5,sum_deba026_o_5,cnt_deba026_5,percent_deba026_5,sum_deba027_5,sum_deba027_o_5,cnt_deba027_5,percent_deba027_5, ",
                     "       sum_deba026_6,sum_deba026_o_6,cnt_deba026_6,percent_deba026_6,sum_deba027_6,sum_deba027_o_6,cnt_deba027_6,percent_deba027_6, ",
                     "       sum_deba026_7,sum_deba026_o_7,cnt_deba026_7,percent_deba026_7,sum_deba027_7,sum_deba027_o_7,cnt_deba027_7,percent_deba027_7, ",
                     "       sum_deba026_8,sum_deba026_o_8,cnt_deba026_8,percent_deba026_8,sum_deba027_8,sum_deba027_o_8,cnt_deba027_8,percent_deba027_8, ",
                     "       sum_deba026_9,sum_deba026_o_9,cnt_deba026_9,percent_deba026_9,sum_deba027_9,sum_deba027_o_9,cnt_deba027_9,percent_deba027_9, ",
                     "       sum_deba026_10,sum_deba026_o_10,cnt_deba026_10,percent_deba026_10,sum_deba027_10,sum_deba027_o_10,cnt_deba027_10,percent_deba027_10, ",
                     "       sum_deba026_11,sum_deba026_o_11,cnt_deba026_11,percent_deba026_11,sum_deba027_11,sum_deba027_o_11,cnt_deba027_11,percent_deba027_11, ",
                     "       DENSE_RANK() OVER( ORDER BY ",l_orderby,") AS RANK ",
                     "  FROM adeq121_tmp03 ",     #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
                     "",
                     " WHERE debaent= ? "
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '','','','','',deba016,'',deba013,'','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT 'N',  ",
               "       deba016_1,deba016_1_desc,deba016_2,deba016_2_desc,deba016, ",
               "       deba016_desc,deba013,deba013_desc, ",
               "       sum_deba026,sum_deba026_o,cnt_deba026,percent_deba026,",
               "       sum_deba027,sum_deba027_o,cnt_deba027,percent_deba027, ",
               "       sum_deba026_1,sum_deba026_o_1,cnt_deba026_1,percent_deba026_1,sum_deba027_1,sum_deba027_o_1,cnt_deba027_1,percent_deba027_1, ",
               "       sum_deba026_2,sum_deba026_o_2,cnt_deba026_2,percent_deba026_2,sum_deba027_2,sum_deba027_o_2,cnt_deba027_2,percent_deba027_2, ",
               "       sum_deba026_3,sum_deba026_o_3,cnt_deba026_3,percent_deba026_3,sum_deba027_3,sum_deba027_o_3,cnt_deba027_3,percent_deba027_3, ",
               "       sum_deba026_4,sum_deba026_o_4,cnt_deba026_4,percent_deba026_4,sum_deba027_4,sum_deba027_o_4,cnt_deba027_4,percent_deba027_4, ",
               "       sum_deba026_5,sum_deba026_o_5,cnt_deba026_5,percent_deba026_5,sum_deba027_5,sum_deba027_o_5,cnt_deba027_5,percent_deba027_5, ",
               "       sum_deba026_6,sum_deba026_o_6,cnt_deba026_6,percent_deba026_6,sum_deba027_6,sum_deba027_o_6,cnt_deba027_6,percent_deba027_6, ",
               "       sum_deba026_7,sum_deba026_o_7,cnt_deba026_7,percent_deba026_7,sum_deba027_7,sum_deba027_o_7,cnt_deba027_7,percent_deba027_7, ",
               "       sum_deba026_8,sum_deba026_o_8,cnt_deba026_8,percent_deba026_8,sum_deba027_8,sum_deba027_o_8,cnt_deba027_8,percent_deba027_8, ",
               "       sum_deba026_9,sum_deba026_o_9,cnt_deba026_9,percent_deba026_9,sum_deba027_9,sum_deba027_o_9,cnt_deba027_9,percent_deba027_9, ",
               "       sum_deba026_10,sum_deba026_o_10,cnt_deba026_10,percent_deba026_10,sum_deba027_10,sum_deba027_o_10,cnt_deba027_10,percent_deba027_10, ",
               "       sum_deba026_11,sum_deba026_o_11,cnt_deba026_11,percent_deba026_11,sum_deba027_11,sum_deba027_o_11,cnt_deba027_11,percent_deba027_11  ",
               "  FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               "   AND RANK < ",g_pagestart + g_num_in_page,
               " ORDER BY RANK"
               
   #DISPLAY "[b_fill_curs ] SQL: ",g_sql 
   LET g_time1 = cl_get_timestamp()
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq121_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq121_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_deba_d[l_ac].sel,g_deba_d[l_ac].l_deba016_5,g_deba_d[l_ac].deba016_desc_desc, 
       g_deba_d[l_ac].l_deba016_6,g_deba_d[l_ac].deba016_desc_desc_desc,g_deba_d[l_ac].deba016,g_deba_d[l_ac].deba016_desc, 
       g_deba_d[l_ac].deba013,g_deba_d[l_ac].deba013_desc,g_deba_d[l_ac].l_sum_ndeba026,g_deba_d[l_ac].l_sum_ldeba026, 
       g_deba_d[l_ac].l_count0,g_deba_d[l_ac].l_count1,g_deba_d[l_ac].l_count2,g_deba_d[l_ac].l_count5, 
       g_deba_d[l_ac].l_count3,g_deba_d[l_ac].l_count4,g_deba_d[l_ac].l_sum_ndeba026_1,g_deba_d[l_ac].l_sum_ldeba026_1, 
       g_deba_d[l_ac].l_count0_1,g_deba_d[l_ac].l_count1_1,g_deba_d[l_ac].l_count2_1,g_deba_d[l_ac].l_count5_1, 
       g_deba_d[l_ac].l_count3_1,g_deba_d[l_ac].l_count4_1,g_deba_d[l_ac].l_sum_ndeba026_2,g_deba_d[l_ac].l_sum_ldeba026_2, 
       g_deba_d[l_ac].l_count0_2,g_deba_d[l_ac].l_count1_2,g_deba_d[l_ac].l_count2_2,g_deba_d[l_ac].l_count5_2, 
       g_deba_d[l_ac].l_count3_2,g_deba_d[l_ac].l_count4_2,g_deba_d[l_ac].l_sum_ndeba026_3,g_deba_d[l_ac].l_sum_ldeba026_3, 
       g_deba_d[l_ac].l_count0_3,g_deba_d[l_ac].l_count1_3,g_deba_d[l_ac].l_count2_3,g_deba_d[l_ac].l_count5_3, 
       g_deba_d[l_ac].l_count3_3,g_deba_d[l_ac].l_count4_3,g_deba_d[l_ac].l_sum_ndeba026_4,g_deba_d[l_ac].l_sum_ldeba026_4, 
       g_deba_d[l_ac].l_count0_4,g_deba_d[l_ac].l_count1_4,g_deba_d[l_ac].l_count2_4,g_deba_d[l_ac].l_count5_4, 
       g_deba_d[l_ac].l_count3_4,g_deba_d[l_ac].l_count4_4,g_deba_d[l_ac].l_sum_ndeba026_5,g_deba_d[l_ac].l_sum_ldeba026_5, 
       g_deba_d[l_ac].l_count0_5,g_deba_d[l_ac].l_count1_5,g_deba_d[l_ac].l_count2_5,g_deba_d[l_ac].l_count5_5, 
       g_deba_d[l_ac].l_count3_5,g_deba_d[l_ac].l_count4_5,g_deba_d[l_ac].l_sum_ndeba026_6,g_deba_d[l_ac].l_sum_ldeba026_6, 
       g_deba_d[l_ac].l_count0_6,g_deba_d[l_ac].l_count1_6,g_deba_d[l_ac].l_count2_6,g_deba_d[l_ac].l_count5_6, 
       g_deba_d[l_ac].l_count3_6,g_deba_d[l_ac].l_count4_6,g_deba_d[l_ac].l_sum_ndeba026_7,g_deba_d[l_ac].l_sum_ldeba026_7, 
       g_deba_d[l_ac].l_count0_7,g_deba_d[l_ac].l_count1_7,g_deba_d[l_ac].l_count2_7,g_deba_d[l_ac].l_count5_7, 
       g_deba_d[l_ac].l_count3_7,g_deba_d[l_ac].l_count4_7,g_deba_d[l_ac].l_sum_ndeba026_8,g_deba_d[l_ac].l_sum_ldeba026_8, 
       g_deba_d[l_ac].l_count0_8,g_deba_d[l_ac].l_count1_8,g_deba_d[l_ac].l_count2_8,g_deba_d[l_ac].l_count5_8, 
       g_deba_d[l_ac].l_count3_8,g_deba_d[l_ac].l_count4_8,g_deba_d[l_ac].l_sum_ndeba026_9,g_deba_d[l_ac].l_sum_ldeba026_9, 
       g_deba_d[l_ac].l_count0_9,g_deba_d[l_ac].l_count1_9,g_deba_d[l_ac].l_count2_9,g_deba_d[l_ac].l_count5_9, 
       g_deba_d[l_ac].l_count3_9,g_deba_d[l_ac].l_count4_9,g_deba_d[l_ac].l_sum_ndeba026_10,g_deba_d[l_ac].l_sum_ldeba026_10, 
       g_deba_d[l_ac].l_count0_10,g_deba_d[l_ac].l_count1_10,g_deba_d[l_ac].l_count2_10,g_deba_d[l_ac].l_count5_10, 
       g_deba_d[l_ac].l_count3_10,g_deba_d[l_ac].l_count4_10,g_deba_d[l_ac].l_sum_ndeba026_11,g_deba_d[l_ac].l_sum_ldeba026_11, 
       g_deba_d[l_ac].l_count0_11,g_deba_d[l_ac].l_count1_11,g_deba_d[l_ac].l_count2_11,g_deba_d[l_ac].l_count5_11, 
       g_deba_d[l_ac].l_count3_11,g_deba_d[l_ac].l_count4_11
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL adeq121_set_color()
      #end add-point
 
      CALL adeq121_detail_show("'1'")
 
      CALL adeq121_deba_t_mask()
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_deba_d.deleteElement(g_deba_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[b_fill_curs ] COUNT: ", SQLCA.sqlerrd[3]," ,Start: ", g_time1," ,End: ",g_time2," ,Total: ",g_time2-g_time1
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_deba_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq121_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq121_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq121_detail_action_trans()
 
   LET l_ac = 1
   IF g_deba_d.getLength() > 0 THEN
      CALL adeq121_b_fill2()
   END IF
 
      CALL adeq121_filter_show('deba016','b_deba016')
   CALL adeq121_filter_show('deba013','b_deba013')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq121_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq121_detail_show(ps_page)
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

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_deba_d[l_ac].deba016
            #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_deba_d[l_ac].deba016_desc_desc_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_deba_d[l_ac].deba016_desc_desc_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_deba_d[l_ac].deba016
            #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_deba_d[l_ac].deba016_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_deba_d[l_ac].deba016_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_deba_d[l_ac].deba016
            #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_deba_d[l_ac].deba016_desc_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_deba_d[l_ac].deba016_desc_desc
            #
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq121_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON deba016,deba013
                          FROM s_detail1[1].b_deba016,s_detail1[1].b_deba013
 
         BEFORE CONSTRUCT
                     DISPLAY adeq121_filter_parser('deba016') TO s_detail1[1].b_deba016
            DISPLAY adeq121_filter_parser('deba013') TO s_detail1[1].b_deba013
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<l_deba016_5>>----
         #----<<b_deba016_desc_desc>>----
         #----<<l_deba016_6>>----
         #----<<b_deba016_desc_desc_desc>>----
         #----<<b_deba016>>----
         #Ctrlp:construct.c.page1.b_deba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba016
            #add-point:ON ACTION controlp INFIELD b_deba016 name="construct.c.filter.page1.b_deba016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba016  #顯示到畫面上
            NEXT FIELD b_deba016                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_deba016_desc>>----
         #----<<b_deba013>>----
         #Ctrlp:construct.c.page1.b_deba013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba013
            #add-point:ON ACTION controlp INFIELD b_deba013 name="construct.c.filter.page1.b_deba013"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba013  #顯示到畫面上
            NEXT FIELD b_deba013                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_deba013_desc>>----
         #----<<l_sum_ndeba026>>----
         #----<<l_sum_ldeba026>>----
         #----<<l_count0>>----
         #----<<l_count1>>----
         #----<<l_count2>>----
         #----<<l_count5>>----
         #----<<l_count3>>----
         #----<<l_count4>>----
         #----<<l_sum_ndeba026_1>>----
         #----<<l_sum_ldeba026_1>>----
         #----<<l_count0_1>>----
         #----<<l_count1_1>>----
         #----<<l_count2_1>>----
         #----<<l_count5_1>>----
         #----<<l_count3_1>>----
         #----<<l_count4_1>>----
         #----<<l_sum_ndeba026_2>>----
         #----<<l_sum_ldeba026_2>>----
         #----<<l_count0_2>>----
         #----<<l_count1_2>>----
         #----<<l_count2_2>>----
         #----<<l_count5_2>>----
         #----<<l_count3_2>>----
         #----<<l_count4_2>>----
         #----<<l_sum_ndeba026_3>>----
         #----<<l_sum_ldeba026_3>>----
         #----<<l_count0_3>>----
         #----<<l_count1_3>>----
         #----<<l_count2_3>>----
         #----<<l_count5_3>>----
         #----<<l_count3_3>>----
         #----<<l_count4_3>>----
         #----<<l_sum_ndeba026_4>>----
         #----<<l_sum_ldeba026_4>>----
         #----<<l_count0_4>>----
         #----<<l_count1_4>>----
         #----<<l_count2_4>>----
         #----<<l_count5_4>>----
         #----<<l_count3_4>>----
         #----<<l_count4_4>>----
         #----<<l_sum_ndeba026_5>>----
         #----<<l_sum_ldeba026_5>>----
         #----<<l_count0_5>>----
         #----<<l_count1_5>>----
         #----<<l_count2_5>>----
         #----<<l_count5_5>>----
         #----<<l_count3_5>>----
         #----<<l_count4_5>>----
         #----<<l_sum_ndeba026_6>>----
         #----<<l_sum_ldeba026_6>>----
         #----<<l_count0_6>>----
         #----<<l_count1_6>>----
         #----<<l_count2_6>>----
         #----<<l_count5_6>>----
         #----<<l_count3_6>>----
         #----<<l_count4_6>>----
         #----<<l_sum_ndeba026_7>>----
         #----<<l_sum_ldeba026_7>>----
         #----<<l_count0_7>>----
         #----<<l_count1_7>>----
         #----<<l_count2_7>>----
         #----<<l_count5_7>>----
         #----<<l_count3_7>>----
         #----<<l_count4_7>>----
         #----<<l_sum_ndeba026_8>>----
         #----<<l_sum_ldeba026_8>>----
         #----<<l_count0_8>>----
         #----<<l_count1_8>>----
         #----<<l_count2_8>>----
         #----<<l_count5_8>>----
         #----<<l_count3_8>>----
         #----<<l_count4_8>>----
         #----<<l_sum_ndeba026_9>>----
         #----<<l_sum_ldeba026_9>>----
         #----<<l_count0_9>>----
         #----<<l_count1_9>>----
         #----<<l_count2_9>>----
         #----<<l_count5_9>>----
         #----<<l_count3_9>>----
         #----<<l_count4_9>>----
         #----<<l_sum_ndeba026_10>>----
         #----<<l_sum_ldeba026_10>>----
         #----<<l_count0_10>>----
         #----<<l_count1_10>>----
         #----<<l_count2_10>>----
         #----<<l_count5_10>>----
         #----<<l_count3_10>>----
         #----<<l_count4_10>>----
         #----<<l_sum_ndeba026_11>>----
         #----<<l_sum_ldeba026_11>>----
         #----<<l_count0_11>>----
         #----<<l_count1_11>>----
         #----<<l_count2_11>>----
         #----<<l_count5_11>>----
         #----<<l_count3_11>>----
         #----<<l_count4_11>>----
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL adeq121_filter_show('deba016','b_deba016')
   CALL adeq121_filter_show('deba013','b_deba013')
 
 
   CALL adeq121_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq121.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq121_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="adeq121.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq121_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = adeq121_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq121.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq121_detail_action_trans()
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
 
{<section id="adeq121.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq121_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
            IF g_deba_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deba_d.getLength() AND g_deba_d.getLength() > 0
            LET g_detail_idx = g_deba_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deba_d.getLength() THEN
               LET g_detail_idx = g_deba_d.getLength()
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
 
{<section id="adeq121.mask_functions" >}
 &include "erp/ade/adeq121_mask.4gl"
 
{</section>}
 
{<section id="adeq121.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位顯示
# Memo...........:
# Usage..........: CALL adeq121_set_comp_visible()
# Date & Author..: 20160407 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_set_comp_visible()
   CALL cl_set_comp_visible("lbl_deba013,deba013", TRUE)
   CALL cl_set_comp_visible("lbl_deba016,deba016", TRUE)
   CALL cl_set_comp_visible("lbl_deba016_1,l_deba016_3,lbl_deba016_2,l_deba016_4", TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL adeq121_set_comp_no_visible()
# Date & Author..: 20160407 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_set_comp_no_visible()
   CASE g_argv[01] 
      WHEN '1'
         CALL cl_set_comp_visible("lbl_deba013,deba013", FALSE)
      WHEN '2'
         CALL cl_set_comp_visible("lbl_deba013,deba013,lbl_deba016,deba016", FALSE)
      WHEN '3'
         CALL cl_set_comp_visible("lbl_deba016_1,l_deba016_3,lbl_deba016_2,l_deba016_4", FALSE)
         CALL cl_set_comp_visible("lbl_deba016,deba016", FALSE)
      OTHERWISE
   END CASE
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
PRIVATE FUNCTION adeq121_set_comp_visible_b()
   CALL cl_set_comp_visible("b_deba013,b_deba013_desc", TRUE)
   CALL cl_set_comp_visible("b_deba016,b_deba016_desc", TRUE)
   CALL cl_set_comp_visible("l_deba016_5", TRUE)
   CALL cl_set_comp_visible("b_deba016_desc_desc", TRUE)
   CALL cl_set_comp_visible("l_deba016_6", TRUE)
   CALL cl_set_comp_visible("b_deba016_desc_desc_desc", TRUE)
   
   CALL cl_set_comp_visible("l_sum_ndeba026_1", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_1", TRUE)
   CALL cl_set_comp_visible("l_count0_1,l_count1_1,l_count2_1,l_count3_1,l_count4_1,l_count5_1", TRUE)  
   CALL cl_set_comp_visible("l_sum_ndeba026_2", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_2", TRUE)
   CALL cl_set_comp_visible("l_count0_2,l_count1_2,l_count2_2,l_count3_2,l_count4_2,l_count5_2", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_3", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_3", TRUE)
   CALL cl_set_comp_visible("l_count0_3,l_count1_3,l_count2_3,l_count3_3,l_count4_3,l_count5_3", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_4", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_4", TRUE)
   CALL cl_set_comp_visible("l_count0_4,l_count1_4,l_count2_4,l_count3_4,l_count4_4,l_count5_4", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_5", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_5", TRUE)
   CALL cl_set_comp_visible("l_count0_5,l_count1_5,l_count2_5,l_count3_5,l_count4_5,l_count5_5", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_6", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_6", TRUE)
   CALL cl_set_comp_visible("l_count0_6,l_count1_6,l_count2_6,l_count3_6,l_count4_6,l_count5_6", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_7", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_7", TRUE)
   CALL cl_set_comp_visible("l_count0_7,l_count1_7,l_count2_7,l_count3_7,l_count4_7,l_count5_7", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_8", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_8", TRUE)
   CALL cl_set_comp_visible("l_count0_8,l_count1_8,l_count2_8,l_count3_8,l_count4_8,l_count5_8", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_9", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_9", TRUE)
   CALL cl_set_comp_visible("l_count0_9,l_count1_9,l_count2_9,l_count3_9,l_count4_9,l_count5_9", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_10", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_10", TRUE)
   CALL cl_set_comp_visible("l_count0_10,l_count1_10,l_count2_10,l_count3_10,l_count4_10,l_count5_10", TRUE)
   CALL cl_set_comp_visible("l_sum_ndeba026_11", TRUE)
   CALL cl_set_comp_visible("l_sum_ldeba026_11", TRUE)
   CALL cl_set_comp_visible("l_count0_11,l_count1_11,l_count2_11,l_count3_11,l_count4_11,l_count5_11", TRUE)
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
PRIVATE FUNCTION adeq121_set_comp_no_visible_b()
   
   CASE g_argv[01] 
      WHEN '1'
         CALL cl_set_comp_visible("b_deba013,b_deba013_desc", FALSE)
      WHEN '2'
         CALL cl_set_comp_visible("b_deba013,b_deba013_desc,b_deba016,b_deba016_desc", FALSE)
      WHEN '3'
         CALL cl_set_comp_visible("l_deba016_5", FALSE)
         CALL cl_set_comp_visible("b_deba016_desc_desc", FALSE)
         CALL cl_set_comp_visible("l_deba016_6", FALSE)
         CALL cl_set_comp_visible("b_deba016_desc_desc_desc", FALSE)
         CALL cl_set_comp_visible("b_deba016", FALSE)
         CALL cl_set_comp_visible("b_deba016_desc", FALSE)
      OTHERWISE
   END CASE
   IF g_site_cnt < 1 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_1", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_1", FALSE)
      CALL cl_set_comp_visible("l_count0_1,l_count1_1,l_count2_1,l_count3_1,l_count4_1,l_count5_1", FALSE)  
   END IF
   IF g_site_cnt < 2 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_2", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_2", FALSE)
      CALL cl_set_comp_visible("l_count0_2,l_count1_2,l_count2_2,l_count3_2,l_count4_2,l_count5_2", FALSE)
   END IF
   IF g_site_cnt < 3 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_3", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_3", FALSE)
      CALL cl_set_comp_visible("l_count0_3,l_count1_3,l_count2_3,l_count3_3,l_count4_3,l_count5_3", FALSE)
   END IF
   IF g_site_cnt < 4 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_4", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_4", FALSE)
      CALL cl_set_comp_visible("l_count0_4,l_count1_4,l_count2_4,l_count3_4,l_count4_4,l_count5_4", FALSE)
   END IF
   IF g_site_cnt < 5 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_5", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_5", FALSE)
      CALL cl_set_comp_visible("l_count0_5,l_count1_5,l_count2_5,l_count3_5,l_count4_5,l_count5_5", FALSE)
   END IF
   IF g_site_cnt < 6 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_6", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_6", FALSE)
      CALL cl_set_comp_visible("l_count0_6,l_count1_6,l_count2_6,l_count3_6,l_count4_6,l_count5_6", FALSE)
   END IF
   IF g_site_cnt < 7 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_7", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_7", FALSE)
      CALL cl_set_comp_visible("l_count0_7,l_count1_7,l_count2_7,l_count3_7,l_count4_7,l_count5_7", FALSE)
   END IF
   IF g_site_cnt < 8 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_8", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_8", FALSE)
      CALL cl_set_comp_visible("l_count0_8,l_count1_8,l_count2_8,l_count3_8,l_count4_8,l_count5_8", FALSE)
   END IF
   IF g_site_cnt < 9 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_9", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_9", FALSE)
      CALL cl_set_comp_visible("l_count0_9,l_count1_9,l_count2_9,l_count3_9,l_count4_9,l_count5_9", FALSE)
   END IF
   IF g_site_cnt < 10 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_10", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_10", FALSE)
      CALL cl_set_comp_visible("l_count0_10,l_count1_10,l_count2_10,l_count3_10,l_count4_10,l_count5_10", FALSE)
   END IF
   IF g_site_cnt < 11 THEN 
      CALL cl_set_comp_visible("l_sum_ndeba026_11", FALSE)
      CALL cl_set_comp_visible("l_sum_ldeba026_11", FALSE)
      CALL cl_set_comp_visible("l_count0_11,l_count1_11,l_count2_11,l_count3_11,l_count4_11,l_count5_11", FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION adeq121_create_temp()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   
   IF NOT adeq121_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adeq121_tmp01(     #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
           seq       SMALLINT,       
      debasite       VARCHAR(10),
      debasite_desc  VARCHAR(500)
      )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create adeq121_tmp01'      #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
   CREATE TEMP TABLE adeq121_tmp02(     #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
      debaent              SMALLINT,         #企業編號
      debasite             VARCHAR(10),        #營運據點
      deba002              DATE,         #統計日期
      deba013              VARCHAR(20),         #品牌
      deba016              VARCHAR(10),         #品類編號
      deba016_1            VARCHAR(10),         #管理品類
      deba016_2            VARCHAR(10),         #中類
      deba026              DECIMAL(20,6),         #應收金額
      deba027              DECIMAL(20,6)     #毛利
      )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create adeq121_tmp02'   #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE adeq121_tmp03(         #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
      debaent              SMALLINT,         #企業編號
      deba013              VARCHAR(20),         #品牌
      deba016              VARCHAR(10),         #品類編號
      deba016_1            VARCHAR(10),         #管理品類
      deba016_2            VARCHAR(10),         #中類
      sum_deba026          DECIMAL(20,6),         #本期銷售額
      sum_deba026_o        DECIMAL(20,6),         #去年銷售額
      cnt_deba026          DECIMAL(20,6),         #銷售差額
      percent_deba026      DECIMAL(20,6),         #銷售增長率
      sum_deba027          DECIMAL(20,6),         #本期毛利額
      sum_deba027_o        DECIMAL(20,6),         #去年毛利額
      cnt_deba027          DECIMAL(20,6),         #毛利差額
      percent_deba027      DECIMAL(20,6),         #毛利增長率
      sum_deba026_1        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_1      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_1        DECIMAL(20,6),         #銷售差額
      percent_deba026_1    DECIMAL(20,6),         #銷售增長率
      sum_deba027_1        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_1      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_1        DECIMAL(20,6),         #毛利差額
      percent_deba027_1    DECIMAL(20,6),         #毛利增長率
      sum_deba026_2        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_2      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_2        DECIMAL(20,6),         #銷售差額
      percent_deba026_2    DECIMAL(20,6),         #銷售增長率
      sum_deba027_2        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_2      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_2        DECIMAL(20,6),         #毛利差額
      percent_deba027_2    DECIMAL(20,6),         #毛利增長率
      sum_deba026_3        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_3      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_3        DECIMAL(20,6),         #銷售差額
      percent_deba026_3    DECIMAL(20,6),         #銷售增長率
      sum_deba027_3        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_3      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_3        DECIMAL(20,6),         #毛利差額
      percent_deba027_3    DECIMAL(20,6),         #毛利增長率
      sum_deba026_4        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_4      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_4        DECIMAL(20,6),         #銷售差額
      percent_deba026_4    DECIMAL(20,6),         #銷售增長率
      sum_deba027_4        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_4      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_4        DECIMAL(20,6),         #毛利差額
      percent_deba027_4    DECIMAL(20,6),         #毛利增長率
      sum_deba026_5        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_5      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_5        DECIMAL(20,6),         #銷售差額
      percent_deba026_5    DECIMAL(20,6),         #銷售增長率
      sum_deba027_5        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_5      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_5        DECIMAL(20,6),         #毛利差額
      percent_deba027_5    DECIMAL(20,6),         #毛利增長率
      sum_deba026_6        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_6      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_6        DECIMAL(20,6),         #銷售差額
      percent_deba026_6    DECIMAL(20,6),         #銷售增長率
      sum_deba027_6        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_6      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_6        DECIMAL(20,6),         #毛利差額
      percent_deba027_6    DECIMAL(20,6),         #毛利增長率
      sum_deba026_7        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_7      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_7        DECIMAL(20,6),         #銷售差額
      percent_deba026_7    DECIMAL(20,6),         #銷售增長率
      sum_deba027_7        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_7      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_7        DECIMAL(20,6),         #毛利差額
      percent_deba027_7    DECIMAL(20,6),         #毛利增長率
      sum_deba026_8        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_8      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_8        DECIMAL(20,6),         #銷售差額
      percent_deba026_8    DECIMAL(20,6),         #銷售增長率
      sum_deba027_8        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_8      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_8        DECIMAL(20,6),         #毛利差額
      percent_deba027_8    DECIMAL(20,6),         #毛利增長率
      sum_deba026_9        DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_9      DECIMAL(20,6),         #去年銷售額
      cnt_deba026_9        DECIMAL(20,6),         #銷售差額
      percent_deba026_9    DECIMAL(20,6),         #銷售增長率
      sum_deba027_9        DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_9      DECIMAL(20,6),         #去年毛利額
      cnt_deba027_9        DECIMAL(20,6),         #毛利差額
      percent_deba027_9    DECIMAL(20,6),         #毛利增長率
      sum_deba026_10       DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_10     DECIMAL(20,6),         #去年銷售額
      cnt_deba026_10       DECIMAL(20,6),         #銷售差額
      percent_deba026_10   DECIMAL(20,6),         #銷售增長率
      sum_deba027_10       DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_10     DECIMAL(20,6),         #去年毛利額
      cnt_deba027_10       DECIMAL(20,6),         #毛利差額
      percent_deba027_10   DECIMAL(20,6),         #毛利增長率
      sum_deba026_11       DECIMAL(20,6),         #本期銷售額
      sum_deba026_o_11     DECIMAL(20,6),         #去年銷售額
      cnt_deba026_11       DECIMAL(20,6),         #銷售差額
      percent_deba026_11   DECIMAL(20,6),         #銷售增長率
      sum_deba027_11       DECIMAL(20,6),         #本期毛利額
      sum_deba027_o_11     DECIMAL(20,6),         #去年毛利額
      cnt_deba027_11       DECIMAL(20,6),         #毛利差額
      percent_deba027_11   DECIMAL(20,6)     #毛利增長率
      )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create adeq121_tmp03'     #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adeq121_drop_temp()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   DROP TABLE adeq121_tmp01            #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq121_tmp01'        #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE adeq121_tmp02                   #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq121_tmp02'   #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   DROP TABLE adeq121_tmp03     #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq121_tmp03'      #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03    
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: ins至site_temp
# Memo...........:
# Usage..........: CALL adeq121_ins_site_temp()
# Input parameter: 無
# Date & Author..: 20160407 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_ins_site_temp()
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_wc      STRING
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_site    LIKE deba_t.debasite
   DEFINE l_sql     STRING
   DEFINE l_desc    LIKE type_t.chr500
   DEFINE l_str     STRING
   
   #清空adeq121_tmp01
   DELETE FROM adeq121_tmp01         #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_adeq121_tmp01'            #160727-00019#10 Mod   del_site_temp -->del_adeq121_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   LET l_wc = cl_str_replace_multistr(g_wc2,"debasite","ooef001")
   LET l_sql ="INSERT INTO adeq121_tmp01(seq,debasite,debasite_desc) ",    #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "       SELECT ROW_NUMBER() OVER (ORDER BY ooef001) seq,ooef001, ",
              "              (SELECT ooefl003 FROM ooefl_t ",
              "                WHERE ooeflent = ",g_enterprise," AND ooefl001 = ooef001 AND ooefl002 = '",g_dlang,"') ",
              "         FROM  ",
              "            (SELECT UNIQUE ooef001 FROM ooef_t ",
              "              WHERE ooefent = ",g_enterprise," AND ",l_wc," )"
   #DISPLAY "[ins_site_temp_pre ] SQL: ",l_sql 
   LET g_time1 = cl_get_timestamp()
   PREPARE ins_site_temp_pre FROM l_sql
   EXECUTE ins_site_temp_pre 
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[ins_adeq121_tmp01_pre ] COUNT: ", SQLCA.sqlerrd[3]," ,Start: ", g_time1," ,End: ",g_time2," ,Total: ",g_time2-g_time1          #160727-00019#10 Mod   ins_site_temp_pre -->ins_adeq121_tmp01_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_adeq121_tmp01_pre'              #160727-00019#10 Mod   ins_site_temp_pre -->ins_adeq121_tmp01_pre
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF 
   
     
   LET l_cnt = 0
   SELECT MAX(seq) INTO l_cnt
     FROM adeq121_tmp01        #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
     
   IF l_cnt > 11 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'ade-00169' #只顯示11家門店
      LET g_errparam.replace[1] = "11"
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      DELETE FROM adeq121_tmp01 WHERE seq > 11         #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins_adeq121_tmp01_pre'           #160727-00019#10 Mod   ins_site_temp_pre -->ins_adeq121_tmp01_pre
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF 
   END IF
   LET g_site_cnt = 0
   SELECT MAX(seq) INTO g_site_cnt
     FROM adeq121_tmp01             #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
     
   #將lbl字替換
   #取原欄位名:本期銷售額
   CALL adeq121_get_field_name('adeq121','sum_ndeba026_1') RETURNING l_str
   FOR l_i = 1 TO g_site_cnt
      SELECT debasite,debasite_desc INTO l_site,l_desc
        FROM adeq121_tmp01         #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
       WHERE seq = l_i 
      CALL adeq121_init_lbl(l_i,l_site,l_desc,l_str)
   END FOR
   
   
END FUNCTION

################################################################################
# Descriptions...: 設定欄位顯示名稱
# Memo...........:
# Usage..........: adeq121_init_lbl(p_cnt,p_site,p_str,p_str1)
# Input parameter: p_cnt          第幾個site
#                  p_site         營運組織
#                  p_desc         營運組織說明
#                  p_str          lbl的標題字串
# Date & Author..: 20160407 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_init_lbl(p_cnt,p_site,p_desc,p_str)
   DEFINE p_cnt      LIKE type_t.num5 
   DEFINE p_site     LIKE deba_t.debasite
   DEFINE p_desc     LIKE type_t.chr500
   DEFINE p_str      STRING
   DEFINE l_sitedesc LIKE type_t.chr500
   DEFINE l_str      STRING
   
   LET l_str  = ''
   
   #組字串:(門店)本期銷售額
   LET l_str = "(",p_site,p_desc,")",p_str
   CASE p_cnt
      WHEN '1'
         CALL cl_set_comp_att_text('l_sum_ndeba026_1',l_str)
      WHEN '2'
         CALL cl_set_comp_att_text('l_sum_ndeba026_2',l_str)
      WHEN '3'
         CALL cl_set_comp_att_text('l_sum_ndeba026_3',l_str)
      WHEN '4'
         CALL cl_set_comp_att_text('l_sum_ndeba026_4',l_str)
      WHEN '5'
         CALL cl_set_comp_att_text('l_sum_ndeba026_5',l_str)
      WHEN '6'
         CALL cl_set_comp_att_text('l_sum_ndeba026_6',l_str)
      WHEN '7'
         CALL cl_set_comp_att_text('l_sum_ndeba026_7',l_str)
      WHEN '8'
         CALL cl_set_comp_att_text('l_sum_ndeba026_8',l_str)
      WHEN '9'
         CALL cl_set_comp_att_text('l_sum_ndeba026_9',l_str)
      WHEN '10'
         CALL cl_set_comp_att_text('l_sum_ndeba026_10',l_str)
      WHEN '11'
         CALL cl_set_comp_att_text('l_sum_ndeba026_11',l_str)
   END CASE
   
END FUNCTION

################################################################################
# Descriptions...: 處理資料至data_temp
# Memo...........:
# Usage..........: CALL adeq121_ins_data_temp(ls_wc)
# Input parameter: ls_wc   條件
# Date & Author..: 20160412 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_ins_data_temp(ls_wc)
   DEFINE l_sql           STRING
   DEFINE ls_wc           STRING
   DEFINE l_group_by      STRING
   DEFINE l_sel_group_by  STRING
   DEFINE l_join_on_2     STRING
   DEFINE l_join_on_3     STRING
   DEFINE l_join_on_4     STRING
   DEFINE l_join_on_5     STRING
   DEFINE l_join_on_6     STRING
   DEFINE l_join_on_7     STRING
   DEFINE l_join_on_8     STRING
   DEFINE l_join_on_9     STRING
   DEFINE l_join_on_10    STRING
   DEFINE l_join_on_11    STRING
   DEFINE l_join_on_12    STRING
   DEFINE l_sel           STRING
   DEFINE l_wc            STRING

   
   DELETE FROM adeq121_tmp02                  #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_adeq121_tmp02'        #160727-00019#10 Mod   del_data_temp -->del_adeq121_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   DELETE FROM adeq121_tmp03          #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'del_adeq121_tmp03'         #160727-00019#10 Mod   del_data_temp1 -->adeq121_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
   #將之後會使用到的資料ins至data_temp
   CASE 
      WHEN g_argv[01] = '1' OR g_argv[01] = '2'
         LET l_sql ="INSERT INTO adeq121_tmp02 ",         #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
                    "        (debaent,debasite,deba002,deba013, ",
                    "         deba016,deba016_1,deba016_2,",
                    "         deba026,deba027) ",
                    "         SELECT  t1.debaent t1_debaent,t1.debasite t1_debasite,t1.deba002 t1_deba002,TRIM(t1.deba013) t1_deba013,",
                    "                 TRIM(t1.deba016) t1_deba016, ",
                    "                 TRIM(t1.deba053) t1_deba053, ",
                    "                 TRIM(t2.rtaw001) t2_rtaw001, ",
                    "                 COALESCE(t1.deba026,0) t1_deba026,COALESCE(t1.deba027,0) t1_deba027 ",
                    "           FROM deba_t t1 LEFT JOIN rtaw_t t2 ON t2.rtawent = t1.debaent AND t2.rtaw002 = t1.deba016 ",
                    "            AND t2.rtaw003 = '",g_para,"' ",
                    "          WHERE t1.debaent = ",g_enterprise," ",
                    "            AND (t1.deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' ",               #去年開始日-去年截止日區間
                    "                 OR t1.deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"') ",   #撈取今年開始日-今年截止日區間
                    "            AND t1.deba049 = '",g_head.deba049,"' ",
                    "            AND ", ls_wc
         
         #依傳入作業參數組SQL:sel & group by
         IF g_argv[01] = '1' THEN
            LET l_sel = " t1.debaent,t1.deba016_1,t1.deba016_2,",             
                     " t1.deba016,'' deba013,"
            LET l_wc = "deba016 = t1.deba016"
            LET l_group_by = "t1.debaent, t1.deba016_1, t1.deba016_2, t1.deba016 "
            LET l_sel_group_by = "debaent, deba016_1, deba016_2, deba016 "
            LET l_join_on_2 = " t1.debaent = t2.debaent AND t1.deba016 = t2.deba016 "

         END IF
         IF g_argv[01] = '2' THEN
               LET l_sel = " t1.debaent,t1.deba016_1,t1.deba016_2,",             
                        " '' deba016,'' deba013,"
               LET l_wc = "deba016_1 = t1.deba016_1"
               LET l_group_by = "t1.debaent, t1.deba016_1, t1.deba016_2 "
               LET l_sel_group_by = "debaent, deba016_1, deba016_2 "
               #LET l_join_on_2 = " t1.debaent = t2.debaent AND t1.deba016_2 = t2.deba016_2 "  #160513-00004#1 20160513 mark by beckxie
               #160513-00004#1 20160513 add by beckxie---S
               #因deba053為日結當下的管理品類(此處的deba016_1),所以呈現報表時同一種中類可能會有多種管理品類
               #必須加在join on 的條件內才不會擴散資料異常
               LET l_join_on_2 = " t1.debaent = t2.debaent AND t1.deba016_1 = t2.deba016_1 AND t1.deba016_2 = t2.deba016_2 "   
               #160513-00004#1 20160513 add by beckxie---E
            END IF
      WHEN g_argv[01] = '3'
         LET l_sql ="INSERT INTO adeq121_tmp02 ",             #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "      (debaent,debasite,deba002,deba013, ",
              "       deba026,deba027) ",
              " SELECT  t1.debaent,t1.debasite,t1.deba002,TRIM(t1.deba013),",
              "         COALESCE(t1.deba026,0),COALESCE(t1.deba027,0) ",
              "   FROM deba_t t1 ",
              "  WHERE t1.debaent = ",g_enterprise," ",
              "    AND (t1.deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' ",               #去年開始日-去年截止日區間
              "         OR t1.deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"') ",   #撈取今年開始日-今年截止日區間
              "    AND t1.deba049 = '",g_head.deba049,"' ",
              "    AND ", ls_wc
         LET l_sel = " t1.debaent,'' deba016_1,'' deba016_2,",             
                     " '' deba016,t1.deba013,"
         LET l_wc = "deba013 = t1.deba013"
         LET l_group_by = "t1.debaent, t1.deba013 "
         LET l_sel_group_by = "debaent, deba013 "
         LET l_join_on_2 = " t1.debaent = t2.debaent AND t1.deba013 = t2.deba013 "
   END CASE
   LET l_join_on_3 = cl_str_replace(l_join_on_2,"t2.","t3.")
   LET l_join_on_4 = cl_str_replace(l_join_on_2,"t2.","t4.")
   LET l_join_on_5 = cl_str_replace(l_join_on_2,"t2.","t5.")
   LET l_join_on_6 = cl_str_replace(l_join_on_2,"t2.","t6.")
   LET l_join_on_7 = cl_str_replace(l_join_on_2,"t2.","t7.")
   LET l_join_on_8 = cl_str_replace(l_join_on_2,"t2.","t8.")
   LET l_join_on_9 = cl_str_replace(l_join_on_2,"t2.","t9.")
   LET l_join_on_10 =cl_str_replace(l_join_on_2,"t2.","t10.")
   LET l_join_on_11 =cl_str_replace(l_join_on_2,"t2.","t11.")
   LET l_join_on_12 =cl_str_replace(l_join_on_2,"t2.","t12.")
   #DISPLAY "[ins_data_temp_pre ] SQL: ",l_sql 
   LET g_time1 = cl_get_timestamp()
   PREPARE ins_data_temp_pre FROM l_sql
   EXECUTE ins_data_temp_pre 
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[ins_adeq121_tmp02_pre  ] COUNT: ", SQLCA.sqlerrd[3]," ,Start: ", g_time1," ,End: ",g_time2," ,Total: ",g_time2-g_time1        #160727-00019#10 Mod   ins_data_temp_pre -->ins_adeq121_tmp02_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_adeq121_tmp02_pre'           #160727-00019#10 Mod   ins_data_temp_pre -->ins_adeq121_tmp02_pre
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   CASE 
      WHEN g_argv[01]  = '1' OR g_argv[01]  = '2' 
         CREATE INDEX adeq101_tmp_index ON adeq121_tmp02(debasite,deba002,deba016_1,deba016_2,deba016)      #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "CREATE INDEX adeq121_tmp02"     #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
            LET g_errparam.popup = TRUE
            #DISPLAY "g_errparam.code:",g_errparam.code
         END IF
      WHEN g_argv[01] = '3'
         CREATE INDEX adeq101_tmp_index ON adeq121_tmp02(debasite,deba002,deba013)        #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "CREATE INDEX adeq121_tmp02"      #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
            LET g_errparam.popup = TRUE
            #DISPLAY "g_errparam.code:",g_errparam.code
         END IF
   END CASE
   IF cl_db_generate_analyze("adeq121_tmp02") THEN END IF     #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
   
   LET l_sql = "INSERT INTO adeq121_tmp03 ( ",        #160727-00019#10 Mod   adeq121_data_temp1 -->adeq121_tmp03
              "       debaent,deba016_1,deba016_2, ",
              "       deba016,deba013, ",
              "       sum_deba026,sum_deba026_o,cnt_deba026,percent_deba026, ",
              "       sum_deba027,sum_deba027_o,cnt_deba027,percent_deba027, ",
              "       sum_deba026_1,sum_deba026_o_1,cnt_deba026_1,percent_deba026_1,sum_deba027_1,sum_deba027_o_1,cnt_deba027_1,percent_deba027_1, ", 
              "       sum_deba026_2,sum_deba026_o_2,cnt_deba026_2,percent_deba026_2,sum_deba027_2,sum_deba027_o_2,cnt_deba027_2,percent_deba027_2, ", 
              "       sum_deba026_3,sum_deba026_o_3,cnt_deba026_3,percent_deba026_3,sum_deba027_3,sum_deba027_o_3,cnt_deba027_3,percent_deba027_3, ", 
              "       sum_deba026_4,sum_deba026_o_4,cnt_deba026_4,percent_deba026_4,sum_deba027_4,sum_deba027_o_4,cnt_deba027_4,percent_deba027_4, ", 
              "       sum_deba026_5,sum_deba026_o_5,cnt_deba026_5,percent_deba026_5,sum_deba027_5,sum_deba027_o_5,cnt_deba027_5,percent_deba027_5, ", 
              "       sum_deba026_6,sum_deba026_o_6,cnt_deba026_6,percent_deba026_6,sum_deba027_6,sum_deba027_o_6,cnt_deba027_6,percent_deba027_6, ", 
              "       sum_deba026_7,sum_deba026_o_7,cnt_deba026_7,percent_deba026_7,sum_deba027_7,sum_deba027_o_7,cnt_deba027_7,percent_deba027_7, ", 
              "       sum_deba026_8,sum_deba026_o_8,cnt_deba026_8,percent_deba026_8,sum_deba027_8,sum_deba027_o_8,cnt_deba027_8,percent_deba027_8, ", 
              "       sum_deba026_9,sum_deba026_o_9,cnt_deba026_9,percent_deba026_9,sum_deba027_9,sum_deba027_o_9,cnt_deba027_9,percent_deba027_9, ", 
              "       sum_deba026_10,sum_deba026_o_10,cnt_deba026_10,percent_deba026_10,sum_deba027_10,sum_deba027_o_10,cnt_deba027_10,percent_deba027_10, ",  
              "       sum_deba026_11,sum_deba026_o_11,cnt_deba026_11,percent_deba026_11,sum_deba027_11,sum_deba027_o_11,cnt_deba027_11,percent_deba027_11) ",
              "SELECT ",
              "       debaent,deba016_1,deba016_2, ",
              "       deba016,deba013, ",
              "       COALESCE(sum_deba026,0) sum_deba026,COALESCE(sum_deba026_o,0) sum_deba026_o,(COALESCE(sum_deba026,0)-COALESCE(sum_deba026_o,0)) cnt_deba026, ",
              "       (CASE WHEN COALESCE(sum_deba026_o,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026,0)-COALESCE(sum_deba026_o,0))/COALESCE(sum_deba026_o,1) * 100    ",
              "       END) percent_deba026, ",
              "       COALESCE(sum_deba027,0) sum_deba027,COALESCE(sum_deba027_o,0) sum_deba027_o,(COALESCE(sum_deba027,0)-COALESCE(sum_deba027_o,0)) cnt_deba027, ",
              "       (CASE WHEN COALESCE(sum_deba027_o,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027,0)-COALESCE(sum_deba027_o,0))/COALESCE(sum_deba027_o,1) * 100    ",
              "       END) percent_deba027, ",
              #_1
              "       COALESCE(sum_deba026_1,0) sum_deba026_1,COALESCE(sum_deba026_o_1,0) sum_deba026_o_1,(COALESCE(sum_deba026_1,0)-COALESCE(sum_deba026_o_1,0)) cnt_deba026_1, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_1,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_1,0)-COALESCE(sum_deba026_o_1,0))/COALESCE(sum_deba026_o_1,1) * 100    ",
              "       END) percent_deba026_1, ",
              "       COALESCE(sum_deba027_1,0) sum_deba027_1,COALESCE(sum_deba027_o_1,0) sum_deba027_o_1,(COALESCE(sum_deba027_1,0)-COALESCE(sum_deba027_o_1,0)) cnt_deba027_1, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_1,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_1,0)-COALESCE(sum_deba027_o_1,0))/COALESCE(sum_deba027_o_1,1) * 100    ",
              "       END) percent_deba027_1, ",
              #_2
              "       COALESCE(sum_deba026_2,0) sum_deba026_2,COALESCE(sum_deba026_o_2,0) sum_deba026_o_2,(COALESCE(sum_deba026_2,0)-COALESCE(sum_deba026_o_2,0)) cnt_deba026_2, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_2,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_2,0)-COALESCE(sum_deba026_o_2,0))/COALESCE(sum_deba026_o_2,1) * 100    ",
              "       END) percent_deba026_2, ",
              "       COALESCE(sum_deba027_2,0) sum_deba027_2,COALESCE(sum_deba027_o_2,0) sum_deba027_o_2,(COALESCE(sum_deba027_2,0)-COALESCE(sum_deba027_o_2,0)) cnt_deba027_2, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_2,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_2,0)-COALESCE(sum_deba027_o_2,0))/COALESCE(sum_deba027_o_2,1) * 100    ",
              "       END) percent_deba027_2, ",
              #_3
              "       COALESCE(sum_deba026_3,0) sum_deba026_3,COALESCE(sum_deba026_o_3,0) sum_deba026_o_3,(COALESCE(sum_deba026_3,0)-COALESCE(sum_deba026_o_3,0)) cnt_deba026_3, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_3,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_3,0)-COALESCE(sum_deba026_o_3,0))/COALESCE(sum_deba026_o_3,1) * 100    ",
              "       END) percent_deba026_3, ",
              "       COALESCE(sum_deba027_3,0) sum_deba027_3,COALESCE(sum_deba027_o_3,0) sum_deba027_o_3,(COALESCE(sum_deba027_3,0)-COALESCE(sum_deba027_o_3,0)) cnt_deba027_3, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_3,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_3,0)-COALESCE(sum_deba027_o_3,0))/COALESCE(sum_deba027_o_3,1) * 100    ",
              "       END) percent_deba027_3, ",
              #_4
              "       COALESCE(sum_deba026_4,0) sum_deba026_4,COALESCE(sum_deba026_o_4,0) sum_deba026_o_4,(COALESCE(sum_deba026_4,0)-COALESCE(sum_deba026_o_4,0)) cnt_deba026_4, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_4,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_4,0)-COALESCE(sum_deba026_o_4,0))/COALESCE(sum_deba026_o_4,1) * 100    ",
              "       END) percent_deba026_4, ",
              "       COALESCE(sum_deba027_4,0) sum_deba027_4,COALESCE(sum_deba027_o_4,0) sum_deba027_o_4,(COALESCE(sum_deba027_4,0)-COALESCE(sum_deba027_o_4,0)) cnt_deba027_4, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_4,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_4,0)-COALESCE(sum_deba027_o_4,0))/COALESCE(sum_deba027_o_4,1) * 100    ",
              "       END) percent_deba027_4, ",
              #_5
              "       COALESCE(sum_deba026_5,0) sum_deba026_5,COALESCE(sum_deba026_o_5,0) sum_deba026_o_5,(COALESCE(sum_deba026_5,0)-COALESCE(sum_deba026_o_5,0)) cnt_deba026_5, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_5,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_5,0)-COALESCE(sum_deba026_o_5,0))/COALESCE(sum_deba026_o_5,1) * 100    ",
              "       END) percent_deba026_5, ",
              "       COALESCE(sum_deba027_5,0) sum_deba027_5,COALESCE(sum_deba027_o_5,0) sum_deba027_o_5,(COALESCE(sum_deba027_5,0)-COALESCE(sum_deba027_o_5,0)) cnt_deba027_5, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_5,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_5,0)-COALESCE(sum_deba027_o_5,0))/COALESCE(sum_deba027_o_5,1) * 100    ",
              "       END) percent_deba027_5, ",
              #_6
              "       COALESCE(sum_deba026_6,0) sum_deba026_6,COALESCE(sum_deba026_o_6,0) sum_deba026_o_6,(COALESCE(sum_deba026_6,0)-COALESCE(sum_deba026_o_6,0)) cnt_deba026_6, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_6,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_6,0)-COALESCE(sum_deba026_o_6,0))/COALESCE(sum_deba026_o_6,1) * 100    ",
              "       END) percent_deba026_6, ",
              "       COALESCE(sum_deba027_6,0) sum_deba027_6,COALESCE(sum_deba027_o_6,0) sum_deba027_o_6,(COALESCE(sum_deba027_6,0)-COALESCE(sum_deba027_o_6,0)) cnt_deba027_6, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_6,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_6,0)-COALESCE(sum_deba027_o_6,0))/COALESCE(sum_deba027_o_6,1) * 100    ",
              "       END) percent_deba027_6, ",
              #_7
              "       COALESCE(sum_deba026_7,0) sum_deba026_7,COALESCE(sum_deba026_o_7,0) sum_deba026_o_7,(COALESCE(sum_deba026_7,0)-COALESCE(sum_deba026_o_7,0)) cnt_deba026_7, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_7,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_7,0)-COALESCE(sum_deba026_o_7,0))/COALESCE(sum_deba026_o_7,1) * 100    ",
              "       END) percent_deba026_7, ",
              "       COALESCE(sum_deba027_7,0) sum_deba027_7,COALESCE(sum_deba027_o_7,0) sum_deba027_o_7,(COALESCE(sum_deba027_7,0)-COALESCE(sum_deba027_o_7,0)) cnt_deba027_7, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_7,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_7,0)-COALESCE(sum_deba027_o_7,0))/COALESCE(sum_deba027_o_7,1) * 100    ",
              "       END) percent_deba027_7, ",
              #_8
              "       COALESCE(sum_deba026_8,0) sum_deba026_8,COALESCE(sum_deba026_o_8,0) sum_deba026_o_8,(COALESCE(sum_deba026_8,0)-COALESCE(sum_deba026_o_8,0)) cnt_deba026_8, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_8,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_8,0)-COALESCE(sum_deba026_o_8,0))/COALESCE(sum_deba026_o_8,1) * 100    ",
              "       END) percent_deba026_8, ",
              "       COALESCE(sum_deba027_8,0) sum_deba027_8,COALESCE(sum_deba027_o_8,0) sum_deba027_o_8,(COALESCE(sum_deba027_8,0)-COALESCE(sum_deba027_o_8,0)) cnt_deba027_8, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_8,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_8,0)-COALESCE(sum_deba027_o_8,0))/COALESCE(sum_deba027_o_8,1) * 100    ",
              "       END) percent_deba027_8, ",
              #_9
              "       COALESCE(sum_deba026_9,0) sum_deba026_9,COALESCE(sum_deba026_o_9,0) sum_deba026_o_9,(COALESCE(sum_deba026_9,0)-COALESCE(sum_deba026_o_9,0)) cnt_deba026_9, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_9,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_9,0)-COALESCE(sum_deba026_o_9,0))/COALESCE(sum_deba026_o_9,1) * 100    ",
              "       END) percent_deba026_9, ",
              "       COALESCE(sum_deba027_9,0) sum_deba027_9,COALESCE(sum_deba027_o_9,0) sum_deba027_o_9,(COALESCE(sum_deba027_9,0)-COALESCE(sum_deba027_o_9,0)) cnt_deba027_9, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_9,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_9,0)-COALESCE(sum_deba027_o_9,0))/COALESCE(sum_deba027_o_9,1) * 100    ",
              "       END) percent_deba027_9, ",
              #_10
              "       COALESCE(sum_deba026_10,0) sum_deba026_10,COALESCE(sum_deba026_o_10,0) sum_deba026_o_10,(COALESCE(sum_deba026_10,0)-COALESCE(sum_deba026_o_10,0)) cnt_deba026_10, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_10,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_10,0)-COALESCE(sum_deba026_o_10,0))/COALESCE(sum_deba026_o_10,1) * 100    ",
              "       END) percent_deba026_10, ",
              "       COALESCE(sum_deba027_10,0) sum_deba027_10,COALESCE(sum_deba027_o_10,0) sum_deba027_o_10,(COALESCE(sum_deba027_10,0)-COALESCE(sum_deba027_o_10,0)) cnt_deba027_10, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_10,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_10,0)-COALESCE(sum_deba027_o_10,0))/COALESCE(sum_deba027_o_10,1) * 100    ",
              "       END) percent_deba027_10, ",
              #_11
              "       COALESCE(sum_deba026_11,0) sum_deba026_11,COALESCE(sum_deba026_o_11,0) sum_deba026_o_11,(COALESCE(sum_deba026_11,0)-COALESCE(sum_deba026_o_11,0)) cnt_deba026_11, ",
              "       (CASE WHEN COALESCE(sum_deba026_o_11,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba026_11,0)-COALESCE(sum_deba026_o_11,0))/COALESCE(sum_deba026_o_11,1) * 100    ",
              "       END) percent_deba026_11, ",
              "       COALESCE(sum_deba027_11,0) sum_deba027_11,COALESCE(sum_deba027_o_11,0) sum_deba027_o_11,(COALESCE(sum_deba027_11,0)-COALESCE(sum_deba027_o_11,0)) cnt_deba027_11, ",
              "       (CASE WHEN COALESCE(sum_deba027_o_11,0) = 0 THEN 0   ",
              "              ELSE    ",
              "                 (COALESCE(sum_deba027_11,0)-COALESCE(sum_deba027_o_11,0))/COALESCE(sum_deba027_o_11,1) * 100    ",
              "       END) percent_deba027_11 ",
              "FROM ( ",
              "      SELECT ",l_sel,
              "             SUM(t1.sum_deba026)  sum_deba026,       SUM(t1.sum_deba026_o) sum_deba026_o,       SUM(t1.sum_deba027) sum_deba027,       SUM(t1.sum_deba027_o) sum_deba027_o, ",
              "             SUM(t2.sum_deba026_1) sum_deba026_1,    SUM(t2.sum_deba026_o_1) sum_deba026_o_1,   SUM(t2.sum_deba027_1) sum_deba027_1,   SUM(t2.sum_deba027_o_1) sum_deba027_o_1, ",
              "             SUM(t3.sum_deba026_2) sum_deba026_2,    SUM(t3.sum_deba026_o_2) sum_deba026_o_2,   SUM(t3.sum_deba027_2) sum_deba027_2,   SUM(t3.sum_deba027_o_2) sum_deba027_o_2, ",
              "             SUM(t4.sum_deba026_3) sum_deba026_3,    SUM(t4.sum_deba026_o_3) sum_deba026_o_3,   SUM(t4.sum_deba027_3) sum_deba027_3,   SUM(t4.sum_deba027_o_3) sum_deba027_o_3, ",
              "             SUM(t5.sum_deba026_4) sum_deba026_4,    SUM(t5.sum_deba026_o_4) sum_deba026_o_4,   SUM(t5.sum_deba027_4) sum_deba027_4,   SUM(t5.sum_deba027_o_4) sum_deba027_o_4, ",
              "             SUM(t6.sum_deba026_5) sum_deba026_5,    SUM(t6.sum_deba026_o_5) sum_deba026_o_5,   SUM(t6.sum_deba027_5) sum_deba027_5,   SUM(t6.sum_deba027_o_5) sum_deba027_o_5, ",
              "             SUM(t7.sum_deba026_6) sum_deba026_6,    SUM(t7.sum_deba026_o_6) sum_deba026_o_6,   SUM(t7.sum_deba027_6) sum_deba027_6,   SUM(t7.sum_deba027_o_6) sum_deba027_o_6, ",
              "             SUM(t8.sum_deba026_7) sum_deba026_7,    SUM(t8.sum_deba026_o_7) sum_deba026_o_7,   SUM(t8.sum_deba027_7) sum_deba027_7,   SUM(t8.sum_deba027_o_7) sum_deba027_o_7, ",
              "             SUM(t9.sum_deba026_8) sum_deba026_8,    SUM(t9.sum_deba026_o_8) sum_deba026_o_8,   SUM(t9.sum_deba027_8) sum_deba027_8,   SUM(t9.sum_deba027_o_8) sum_deba027_o_8, ",
              "             SUM(t10.sum_deba026_9) sum_deba026_9,   SUM(t10.sum_deba026_o_9) sum_deba026_o_9,  SUM(t10.sum_deba027_9) sum_deba027_9,  SUM(t10.sum_deba027_o_9) sum_deba027_o_9, ",
              "             SUM(t11.sum_deba026_10) sum_deba026_10, SUM(t11.sum_deba026_o_10) sum_deba026_o_10,SUM(t11.sum_deba027_10) sum_deba027_10,SUM(t11.sum_deba027_o_10) sum_deba027_o_10, ",
              "             SUM(t12.sum_deba026_11) sum_deba026_11, SUM(t12.sum_deba026_o_11) sum_deba026_o_11,SUM(t12.sum_deba027_11) sum_deba027_11,SUM(t12.sum_deba027_o_11) sum_deba027_o_11 ",
              "        FROM  (SELECT ",l_sel_group_by ,",",
              "                      SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o, ",
              "                      SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026, ",
              "                      SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o, ",
              "                      SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027 ", 
              "                 FROM adeq121_tmp02 s1 ",            #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                WHERE EXISTS (SELECT 1 ",
              "                                FROM adeq121_tmp01 s2 ",      #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                               WHERE s1.debasite = s2.debasite AND seq <= 11) ",
              "                GROUP BY  ",l_sel_group_by ,
              "               ) t1 ",
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_1, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_1, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_1 , ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_1 ", 
              "                                   FROM adeq121_tmp02  ",          #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=1) ",   #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t2 ",
              "                          ON ",l_join_on_2 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_2, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_2, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_2, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_2 ", 
              "                                   FROM adeq121_tmp02  ",         #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=2) ",   #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t3 ",
              "                          ON ",l_join_on_3 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_3, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_3, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_3, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_3      ",
              "                                   FROM adeq121_tmp02  ",      #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=3) ",   #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t4 ",
              "                          ON ",l_join_on_4 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_4, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_4, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_4, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_4 ",
              "                                   FROM adeq121_tmp02  ",      #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=4) ",    #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t5 ",
              "                          ON ",l_join_on_5 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_5, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_5, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_5, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_5 ",
              "                                   FROM adeq121_tmp02  ",    #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=5) ",   #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t6 ",
              "                          ON ",l_join_on_6 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_6, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_6, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_6, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_6 ",
              "                                   FROM adeq121_tmp02  ",         #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=6) ",    #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t7 ",
              "                          ON ",l_join_on_7 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_7, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_7, ", 
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_7, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_7 ",
              "                                   FROM adeq121_tmp02  ",    #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=7) ",    #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t8 ",
              "                          ON ",l_join_on_8 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_8, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_8, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_8, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_8  ",
              "                                   FROM adeq121_tmp02  ",    #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=8) ",     #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t9 ",
              "                          ON ",l_join_on_9 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_9, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_9, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_9, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_9  ",
              "                                   FROM adeq121_tmp02  ",    #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=9) ",     #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t10 ",
              "                          ON ",l_join_on_10 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_10, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_10, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_10, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_10 ",
              "                                   FROM adeq121_tmp02  ",        #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=10) ",      #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t11 ",
              "                          ON ",l_join_on_11 ,
              "               LEFT JOIN  (SELECT ",l_sel_group_by ,",",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"' AND '",g_edate_last,"'  THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_o_11, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba026,0) ELSE 0 END) sum_deba026_11, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_bdate_last,"'  AND '",g_edate_last,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_o_11, ",
              "                                             SUM(CASE WHEN deba002 BETWEEN '",g_head.l_bdate_1,"' AND '",g_head.l_edate_1,"' THEN COALESCE(deba027,0) ELSE 0 END) sum_deba027_11 ",
              "                                   FROM adeq121_tmp02  ",     #160727-00019#10 Mod   adeq121_data_temp -->adeq121_tmp02
              "                                 WHERE debasite = (SELECT debasite FROM adeq121_tmp01 WHERE seq=11) ",      #160727-00019#10 Mod   adeq121_site_temp -->adeq121_tmp01
              "                                 GROUP BY  ",l_sel_group_by ,
              "                                ) t12 ",
              "                          ON ",l_join_on_12 ,
              "        GROUP BY ",l_group_by ," )"
   #DISPLAY "[ins_data_temp1_pre ] SQL: ",l_sql 
   LET g_time1 = cl_get_timestamp()


   PREPARE ins_data_temp1_pre FROM l_sql
   EXECUTE ins_data_temp1_pre 
   LET g_time2 = cl_get_timestamp()
   DISPLAY "[ins_adeq121_tmp03_pre ] COUNT: ", SQLCA.sqlerrd[3]," ,Start: ", g_time1," ,End: ",g_time2," ,Total: ",g_time2-g_time1     #160727-00019#10 Mod   ins_data_temp1_pre -->ins_adeq121_tmp03_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins_adeq121_tmp03_pre'        #160727-00019#10 Mod   ins_data_temp1_pre -->ins_adeq121_tmp03_pre
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: set color
# Memo...........:
# Usage..........: CALL adeq121_set_color()
# Date & Author..: 20160414 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_set_color()
   DEFINE l_color STRING 
   LET l_color = 'light yellow reverse'
   
   LET g_deba_d_color[l_ac].l_sum_ndeba026_1  = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_1  = l_color
   LET g_deba_d_color[l_ac].l_count0_1        = l_color
   LET g_deba_d_color[l_ac].l_count1_1        = l_color
   LET g_deba_d_color[l_ac].l_count2_1        = l_color
   LET g_deba_d_color[l_ac].l_count5_1        = l_color
   LET g_deba_d_color[l_ac].l_count3_1        = l_color
   LET g_deba_d_color[l_ac].l_count4_1        = l_color
   LET g_deba_d_color[l_ac].l_sum_ndeba026_3  = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_3  = l_color
   LET g_deba_d_color[l_ac].l_count0_3        = l_color
   LET g_deba_d_color[l_ac].l_count1_3        = l_color
   LET g_deba_d_color[l_ac].l_count2_3        = l_color
   LET g_deba_d_color[l_ac].l_count5_3        = l_color
   LET g_deba_d_color[l_ac].l_count3_3        = l_color
   LET g_deba_d_color[l_ac].l_count4_3        = l_color
   LET g_deba_d_color[l_ac].l_sum_ndeba026_5  = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_5  = l_color
   LET g_deba_d_color[l_ac].l_count0_5        = l_color
   LET g_deba_d_color[l_ac].l_count1_5        = l_color
   LET g_deba_d_color[l_ac].l_count2_5        = l_color
   LET g_deba_d_color[l_ac].l_count5_5        = l_color
   LET g_deba_d_color[l_ac].l_count3_5        = l_color
   LET g_deba_d_color[l_ac].l_count4_5        = l_color
   LET g_deba_d_color[l_ac].l_sum_ndeba026_7  = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_7  = l_color
   LET g_deba_d_color[l_ac].l_count0_7        = l_color
   LET g_deba_d_color[l_ac].l_count1_7        = l_color
   LET g_deba_d_color[l_ac].l_count2_7        = l_color
   LET g_deba_d_color[l_ac].l_count5_7        = l_color
   LET g_deba_d_color[l_ac].l_count3_7        = l_color
   LET g_deba_d_color[l_ac].l_count4_7        = l_color
   LET g_deba_d_color[l_ac].l_sum_ndeba026_9  = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_9  = l_color
   LET g_deba_d_color[l_ac].l_count0_9        = l_color
   LET g_deba_d_color[l_ac].l_count1_9        = l_color
   LET g_deba_d_color[l_ac].l_count2_9        = l_color
   LET g_deba_d_color[l_ac].l_count5_9        = l_color
   LET g_deba_d_color[l_ac].l_count3_9        = l_color
   LET g_deba_d_color[l_ac].l_count4_9        = l_color
   LET g_deba_d_color[l_ac].l_sum_ndeba026_11 = l_color
   LET g_deba_d_color[l_ac].l_sum_ldeba026_11 = l_color
   LET g_deba_d_color[l_ac].l_count0_11       = l_color
   LET g_deba_d_color[l_ac].l_count1_11       = l_color
   LET g_deba_d_color[l_ac].l_count2_11       = l_color
   LET g_deba_d_color[l_ac].l_count5_11       = l_color
   LET g_deba_d_color[l_ac].l_count3_11       = l_color
   LET g_deba_d_color[l_ac].l_count4_11       = l_color
END FUNCTION

################################################################################
# Descriptions...: 取得欄位名稱
# Memo...........:
# Usage..........: CALL adeq121_get_field_name(p_prog,p_field)
#                  RETURNING r_field_name
# Input parameter: p_prog         作業代號
#                : p_field        欄位編號
# Return code....: r_field_name   欄位名稱
# Date & Author..: 20160128 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq121_get_field_name(p_prog,p_field)
   DEFINE p_prog          LIKE gzzd_t.gzzd001    
   DEFINE p_field         LIKE dzebl_t.dzebl001
   DEFINE l_label         LIKE gzzd_t.gzzd003      #待轉標籤
   DEFINE r_field_name    LIKE dzebl_t.dzebl003    #欄位名稱

   WHENEVER ERROR CONTINUE
   LET r_field_name = ''

   LET l_label = "lbl_",p_field
   #抓取azzi912
   SELECT gzzf005 INTO r_field_name
     FROM gzzf_t
    WHERE gzzf001 = p_prog
      AND gzzf002 = g_dlang
      AND gzzf003 = l_label

   IF NOT cl_null(r_field_name) THEN
      RETURN r_field_name
   END IF
   
   #抓取azzi902
   SELECT gzzd005 INTO r_field_name
     FROM gzzd_t
    WHERE gzzd001 = p_prog
      AND gzzd002 = g_dlang
      AND gzzd003 = l_label
      AND gzzd004 = 's'

   IF NOT cl_null(r_field_name) THEN
      RETURN r_field_name
   END IF
   
   #抓取資料庫說明
   SELECT dzebl003 INTO r_field_name
     FROM dzebl_t
    WHERE dzebl001 = p_field
      AND dzebl002 = g_dlang

   IF cl_null(r_field_name) THEN
      LET r_field_name = p_field
   END IF
   
   RETURN r_field_name
END FUNCTION

 
{</section>}
 
