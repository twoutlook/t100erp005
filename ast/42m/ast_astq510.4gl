#該程式未解開Section, 採用最新樣板產出!
{<section id="astq510.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-14 13:38:09), PR版次:0003(2016-09-14 13:34:57)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: astq510
#+ Description: 銷售明細對比查詢
#+ Creator....: 06536(2015-09-07 10:41:49)
#+ Modifier...: 08742 -SD/PR- 08742
 
{</section>}
 
{<section id="astq510.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160913-00034#3  2016/09/14    by 08742    q_pmaa001開窗改成 q_pmaa001_1抓類型=3 的條件
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
PRIVATE TYPE type_g_stgg_d RECORD
       #statepic       LIKE type_t.chr1,
       
       stggsite LIKE stgg_t.stggsite, 
   stggsite_1_desc LIKE type_t.chr500, 
   stgg005 LIKE stgg_t.stgg005, 
   stgg005_1_desc LIKE type_t.chr500, 
   stgg003 LIKE stgg_t.stgg003, 
   stgg003_1_desc LIKE type_t.chr500, 
   stfa051 LIKE stfa_t.stfa051, 
   stfa051_1_desc LIKE type_t.chr500, 
   stgg004 LIKE stgg_t.stgg004, 
   stgg004_1_desc LIKE type_t.chr500, 
   stgg002 LIKE stgg_t.stgg002, 
   stgg002_desc LIKE type_t.chr500, 
   l_st71 LIKE type_t.chr10, 
   l_st72 LIKE type_t.num20_6, 
   l_ycha1 LIKE type_t.chr100, 
   l_st73 LIKE type_t.num20_6, 
   l_ycha2 LIKE type_t.chr100, 
   l_st81 LIKE type_t.num20_6, 
   l_st82 LIKE type_t.num20_6, 
   l_scha1 LIKE type_t.chr100, 
   l_st83 LIKE type_t.num20_6, 
   l_scha2 LIKE type_t.chr100, 
   l_st91 LIKE type_t.num20_6, 
   l_st92 LIKE type_t.num20_6, 
   l_mcha1 LIKE type_t.chr100, 
   l__st93 LIKE type_t.num20_6, 
   l_mcha2 LIKE type_t.chr100, 
   l_st11 LIKE type_t.num20_6, 
   l_st12 LIKE type_t.num20_6, 
   l_lcha1 LIKE type_t.chr100, 
   l_st13 LIKE type_t.num20_6, 
   l_lcha2 LIKE type_t.chr100, 
   l_st41 LIKE type_t.num20_6, 
   l_st42 LIKE type_t.num20_6, 
   l_zcha1 LIKE type_t.chr100, 
   l_st43 LIKE type_t.num20_6, 
   l_zcha2 LIKE type_t.chr100 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE ls_sql               STRING
DEFINE g_sql_ins            STRING
DEFINE g_sql_upd1            STRING
DEFINE g_sql_upd2            STRING
DEFINE g_sql_del            STRING
DEFINE g_sql_del1            STRING
DEFINE date11 LIKE type_t.dat
DEFINE date12 LIKE type_t.dat
DEFINE date21 LIKE type_t.dat
DEFINE date22 LIKE type_t.dat
DEFINE date31 LIKE type_t.dat
DEFINE date32 LIKE type_t.dat
DEFINE stggsite LIKE stgg_t.stggsite
DEFINE l_sys2       LIKE type_t.num5  
#
TYPE type_g_tm  record
 stggsite like stgg_t.stggsite,
 stgg002 like stgg_t.stgg002,
 stgg003 like stgg_t.stgg003,
 stgg004 like stgg_t.stgg004,
 stgg005 like stgg_t.stgg005,
 stfa051 like stfa_t.stfa051,
 date11 like type_t.dat,
 date12 like type_t.dat,
 date21 like type_t.dat,
 date22 like type_t.dat,
 date31 like type_t.dat,
 date32 like type_t.dat
 end record
DEFINE g_tm     type_g_tm
DEFINE l_str     LIKE type_t.chr500 

DEFINE g_stgg_d2 DYNAMIC ARRAY OF RECORD  #按楼层stgg005
   stggsite_2 LIKE stgg_t.stggsite,
   stggsite_2_desc LIKE type_t.chr500,
   stgg005 LIKE stgg_t.stgg005,
   stgg005_desc LIKE type_t.chr500, 
   l_st271 LIKE type_t.num20_6,l_st272 LIKE type_t.num20_6,l_ycha21 LIKE type_t.num20_6,l_st273 LIKE type_t.num20_6,l_ycha22 LIKE type_t.num20_6, 
   l_st281 LIKE type_t.num20_6,l_st282 LIKE type_t.num20_6,l_scha21 LIKE type_t.num20_6,l_st283 LIKE type_t.num20_6,l_scha22 LIKE type_t.num20_6, 
   l_st291 LIKE type_t.num20_6,l_st292 LIKE type_t.num20_6,l_mcha21 LIKE type_t.num20_6,l_st293 LIKE type_t.num20_6,l_mcha22 LIKE type_t.num20_6, 
   l_st211 LIKE type_t.num20_6,l_st212 LIKE type_t.num20_6,l_lcha21 LIKE type_t.num20_6,l_st213 LIKE type_t.num20_6,l_lcha22 LIKE type_t.num20_6, 
   l_st241 LIKE type_t.num20_6,l_st242 LIKE type_t.num20_6,l_zcha21 LIKE type_t.num20_6,l_st243 LIKE type_t.num20_6,l_zcha22 LIKE type_t.num20_6 
       END RECORD
       


DEFINE g_stgg_d3 DYNAMIC ARRAY OF RECORD  #按专柜stgg003 
   stggsite_3 LIKE stgg_t.stggsite, 
   stggsite_3_desc LIKE type_t.chr500,   
   stgg004_3 LIKE stgg_t.stgg004, 
   stgg004_3_desc LIKE type_t.chr500, 
   stgg003 LIKE stgg_t.stgg003, 
   stgg003_desc LIKE type_t.chr500, 
   l_st371 LIKE type_t.num20_6,l_st372 LIKE type_t.num20_6,l_ycha31 LIKE type_t.num20_6,l_st373 LIKE type_t.num20_6,l_ycha32 LIKE type_t.num20_6, 
   l_st381 LIKE type_t.num20_6,l_st382 LIKE type_t.num20_6,l_scha31 LIKE type_t.num20_6,l_st383 LIKE type_t.num20_6,l_scha32 LIKE type_t.num20_6, 
   l_st391 LIKE type_t.num20_6,l_st392 LIKE type_t.num20_6,l_mcha31 LIKE type_t.num20_6,l_st393 LIKE type_t.num20_6,l_mcha32 LIKE type_t.num20_6, 
   l_st311 LIKE type_t.num20_6,l_st312 LIKE type_t.num20_6,l_lcha31 LIKE type_t.num20_6,l_st313 LIKE type_t.num20_6,l_lcha32 LIKE type_t.num20_6, 
   l_st341 LIKE type_t.num20_6,l_st342 LIKE type_t.num20_6,l_zcha31 LIKE type_t.num20_6,l_st343 LIKE type_t.num20_6,l_zcha32 LIKE type_t.num20_6  
       END RECORD
 
DEFINE g_stgg_d4 DYNAMIC ARRAY OF RECORD  #按品类stfa051
   stggsite_4 LIKE stgg_t.stggsite, 
   stggsite_4_desc LIKE type_t.chr500, 
   stfa051 LIKE stfa_t.stfa051, 
   stfa051_desc LIKE type_t.chr500, 
   l_st471 LIKE type_t.num20_6,l_st472 LIKE type_t.num20_6,l_ycha41 LIKE type_t.num20_6,l_st473 LIKE type_t.num20_6,l_ycha42 LIKE type_t.num20_6, 
   l_st481 LIKE type_t.num20_6,l_st482 LIKE type_t.num20_6,l_scha41 LIKE type_t.num20_6,l_st483 LIKE type_t.num20_6,l_scha42 LIKE type_t.num20_6, 
   l_st491 LIKE type_t.num20_6,l_st492 LIKE type_t.num20_6,l_mcha41 LIKE type_t.num20_6,l_st493 LIKE type_t.num20_6,l_mcha42 LIKE type_t.num20_6,
   l_st411 LIKE type_t.num20_6,l_st412 LIKE type_t.num20_6,l_lcha41 LIKE type_t.num20_6,l_st413 LIKE type_t.num20_6,l_lcha42 LIKE type_t.num20_6, 
   l_st441 LIKE type_t.num20_6,l_st442 LIKE type_t.num20_6,l_zcha41 LIKE type_t.num20_6,l_st443 LIKE type_t.num20_6,l_zcha42 LIKE type_t.num20_6 
       END RECORD


      
DEFINE g_stgg_d5 DYNAMIC ARRAY OF RECORD  #按供应商stgg004
   stggsite_5 LIKE stgg_t.stggsite, 
   stggsite_5_desc LIKE type_t.chr500, 
   stgg004 LIKE stgg_t.stgg004, 
   stgg004_desc LIKE type_t.chr500, 
   l_st571 LIKE type_t.num20_6,l_st572 LIKE type_t.num20_6,l_ycha51 LIKE type_t.num20_6,l_st573 LIKE type_t.num20_6,l_ycha52 LIKE type_t.num20_6, 
   l_st581 LIKE type_t.num20_6,l_st582 LIKE type_t.num20_6,l_scha51 LIKE type_t.num20_6,l_st583 LIKE type_t.num20_6,l_scha52 LIKE type_t.num20_6, 
   l_st591 LIKE type_t.num20_6,l_st592 LIKE type_t.num20_6,l_mcha51 LIKE type_t.num20_6,l_st593 LIKE type_t.num20_6,l_mcha52 LIKE type_t.num20_6, 
   l_st511 LIKE type_t.num20_6,l_st512 LIKE type_t.num20_6,l_lcha51 LIKE type_t.num20_6,l_st513 LIKE type_t.num20_6,l_lcha52 LIKE type_t.num20_6, 
   l_st541 LIKE type_t.num20_6,l_st542 LIKE type_t.num20_6,l_zcha51 LIKE type_t.num20_6,l_st543 LIKE type_t.num20_6,l_zcha52 LIKE type_t.num20_6 
       END RECORD


DEFINE g_stgg_d6 DYNAMIC ARRAY OF RECORD  #按门店
   stggsite      LIKE stgg_t.stggsite, 
   stggsite_desc LIKE type_t.chr500, 
   l_st671  LIKE type_t.num20_6,l_st672  LIKE type_t.num20_6,l_ycha61 LIKE type_t.num20_6,l_st673  LIKE type_t.num20_6,l_ycha62 LIKE type_t.num20_6, 
   l_st681  LIKE type_t.num20_6,l_st682  LIKE type_t.num20_6,l_scha61 LIKE type_t.num20_6,l_st683  LIKE type_t.num20_6,l_scha62 LIKE type_t.num20_6,
   l_st691  LIKE type_t.num20_6,l_st692  LIKE type_t.num20_6,l_mcha61 LIKE type_t.num20_6,l_st693  LIKE type_t.num20_6,l_mcha62 LIKE type_t.num20_6, 
   l_st611  LIKE type_t.num20_6,l_st612  LIKE type_t.num20_6,l_lcha61 LIKE type_t.num20_6,l_st613  LIKE type_t.num20_6,l_lcha62 LIKE type_t.num20_6, 
   l_st641  LIKE type_t.num20_6,l_st642  LIKE type_t.num20_6,l_zcha61 LIKE type_t.num20_6,l_st643  LIKE type_t.num20_6,l_zcha62 LIKE type_t.num20_6 
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stgg_d
DEFINE g_master_t                   type_g_stgg_d
DEFINE g_stgg_d          DYNAMIC ARRAY OF type_g_stgg_d
DEFINE g_stgg_d_t        type_g_stgg_d
 
      
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
 
{<section id="astq510.main" >}
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
   CALL cl_ap_init("ast","")
 
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
   DECLARE astq510_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq510_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq510_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq510 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq510_init()   
 
      #進入選單 Menu (="N")
      CALL astq510_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq510
      
   END IF 
   
   CLOSE astq510_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL astq510_drop_tmp() RETURNING l_success
  # CALL astq510_drop_tmp1() RETURNING l_success
   CALL s_aooi500_drop_temp() RETURNING l_success    #add by dengdd 151020
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq510.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astq510_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
    CALL s_aooi500_create_temp()             RETURNING l_success
   CALL astq510_create_tmp()                 RETURNING l_success
  INITIALIZE g_tm.* TO NULL  
   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_str
    let date11 = g_today
             let date12 = g_today
             let date21 = g_today
             let date22 = g_today
             let date31 = g_today
             let date32 = g_today
             display by name date11,date12,date21,date22,date31,date32
   #end add-point
 
   CALL astq510_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astq510.default_search" >}
PRIVATE FUNCTION astq510_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stggsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stgg001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " stgg002 = '", g_argv[03], "' AND "
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
 
{<section id="astq510.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astq510_ui_dialog()
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
   LET g_wc = g_wc," AND 1=1"   #160126-00002#3 160130 By s983961 add(S)
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL astq510_b_fill()
   ELSE
      CALL astq510_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stgg_d.clear()
 
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
 
         CALL astq510_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stgg_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq510_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astq510_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160126-00002#3 160130 By s983961 add(S)
         CONSTRUCT g_wc
             ON stggsite,stgg003,stgg004,stgg005,stfa051,stgg002
           FROM stggsite,stgg003,stgg004,stgg005,stfa051,stgg002
                
          ON ACTION controlp INFIELD stggsite      #门店编号
            #add-point:ON ACTION controlp INFIELD mmbhsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stggsite',g_site,'c')   #150308-00001#4  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO debssite  #顯示到畫面上
            NEXT FIELD stggsite                     #返回原欄位
    
         ON ACTION controlp INFIELD stgg002       #库区编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg002  #顯示到畫面上
            NEXT FIELD stgg002                     #返回原欄位
    
         ON ACTION controlp INFIELD stgg003        #专柜编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg003  #顯示到畫面上
            NEXT FIELD stgg003                     #返回原欄位
  
         ON ACTION controlp INFIELD stgg004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#3 -S
            #CALL q_pmaa001()                                       
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#3 -E
            DISPLAY g_qryparam.return1 TO stgg004  #顯示到畫面上
            NEXT FIELD stgg004                     #返回原欄位
       
         ON ACTION controlp INFIELD stgg005   #楼层编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg005  #顯示到畫面上
            NEXT FIELD stgg005                     #返回原欄位

         ON ACTION controlp INFIELD stfa051
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
	         CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
	         let g_qryparam.where =" rtax001 like '5_' or rtax001 like '6_' "
	         LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa051  #顯示到畫面上
            NEXT FIELD stfa051                     #返回原欄位
          
          
           AFTER FIELD stggsite
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stggsite
            AFTER FIELD stgg002
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg002
           AFTER FIELD stgg003
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg003
                
           AFTER FIELD stgg004
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg004
                
           AFTER FIELD stgg005
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg005
                
           AFTER FIELD stfa051
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stfa051

           #add-point:cs段more_construct
           BEFORE CONSTRUCT                     
             LET stggsite = g_site 
             DISPLAY stggsite TO stggsite
            
           #end add-point 
      
       
          END CONSTRUCT
      
          INPUT date11,date12,date21,date22,date31,date32 
           FROM date11,date12,date21,date22,date31,date32    
            ATTRIBUTE(WITHOUT DEFAULTS)
               
                    BEFORE INPUT
           
               
                 AFTER FIELD date11
                  
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date11
                     
                 AFTER FIELD date12 
                   IF NOT cl_null(date11) AND  date12 < date11 THEN
                         INITIALIZE g_errparam TO NULL 
                         LET g_errparam.extend = "" 
                         LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                         LET g_errparam.popup  = TRUE 
                         CALL cl_err()
                         NEXT FIELD date12
                    END IF                  
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date12    
               AFTER FIELD date21
                   IF NOT cl_null(date21) THEN
                      IF NOT cl_null(date22) AND date21 > date22 THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "" 
                            LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            NEXT FIELD date21
                          END IF
                      END IF
                   CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date21
                     
                 AFTER FIELD date22
                    IF NOT cl_null(date22) THEN
                        CALL cl_set_comp_required("date31",FALSE)
                        CALL cl_set_comp_required("date32",FALSE) 
                       IF NOT cl_null(date21) AND  date22 < date21 THEN
                          INITIALIZE g_errparam TO NULL 
                          LET g_errparam.extend = "" 
                          LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                          LET g_errparam.popup  = TRUE 
                          CALL cl_err()
                          NEXT FIELD date22
                        END IF
                     ELSE 
                        IF NOT cl_null(date31) AND NOT cl_null(date32) THEN 
                           CALL cl_set_comp_required("date21",FALSE)
                           CALL cl_set_comp_required("date22",FALSE)
                        ELSE
                           CALL cl_set_comp_required("date31",TRUE)
                           CALL cl_set_comp_required("date32",TRUE) 
                           CALL cl_set_comp_visible("l_st72,l_ycha1,l_st82,l_scha1,l_st92",FALSE)
                           CALL cl_set_comp_visible("l_st272,l_ycha21,l_st282,l_scha21,l_st292",FALSE)                     
                           CALL cl_set_comp_visible("l_st372,l_ycha31,l_st382,l_scha31,l_st392",FALSE)
                           CALL cl_set_comp_visible("l_st472,l_ycha41,l_st482,l_scha41,l_st492",FALSE)
                           CALL cl_set_comp_visible("l_st572,l_ycha51,l_st582,l_scha51,l_st592",FALSE)                     
                           CALL cl_set_comp_visible("l_st672,l_ycha61,l_st682,l_scha61,l_st692",FALSE)                                                
                           CALL cl_set_comp_visible("l_mcha1,l_st12,l_lcha1,l_st42,l_zcha1",FALSE)
                           CALL cl_set_comp_visible("l_mcha21,l_st212,l_lcha21,l_st242,l_zcha21",FALSE)                     
                           CALL cl_set_comp_visible("l_mcha31,l_st312,l_lcha31,l_st342,l_zcha31",FALSE)
                           CALL cl_set_comp_visible("l_mcha41,l_st412,l_lcha41,l_st442,l_zcha41",FALSE)
                           CALL cl_set_comp_visible("l_mcha51,l_st512,l_lcha51,l_st542,l_zcha51",FALSE)                     
                           CALL cl_set_comp_visible("l_mcha61,l_st612,l_lcha61,l_st642,l_zcha61",FALSE)                             
                        END IF               
                    END IF
                    CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date22               
                       
                AFTER FIELD date31
                   IF NOT cl_null(date31) THEN
                      IF NOT cl_null(date32) AND date31 > date32 THEN
                            INITIALIZE g_errparam TO NULL 
                            LET g_errparam.extend = "" 
                            LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                            LET g_errparam.popup  = TRUE 
                            CALL cl_err()
                            NEXT FIELD date31
                        END IF
                     END IF 
                 CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date31                
                     
                    AFTER FIELD date32
                      IF NOT cl_null(date32) THEN
                         CALL cl_set_comp_required("date21",FALSE)
                         CALL cl_set_comp_required("date22",FALSE)  
                         IF NOT cl_null(date31) AND date32 < date31 THEN
                               INITIALIZE g_errparam TO NULL 
                               LET g_errparam.extend = "" 
                               LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                               LET g_errparam.popup  = TRUE 
                               CALL cl_err()
                               NEXT FIELD date32
                          END IF
                       ELSE
                         IF NOT  cl_null(date21) AND NOT cl_null(date22) THEN 
                            CALL cl_set_comp_required("date31",FALSE)
                            CALL cl_set_comp_required("date32",FALSE)
                         ELSE
                            CALL cl_set_comp_required("date21",TRUE)
                            CALL cl_set_comp_required("date22",TRUE)  
                            CALL cl_set_comp_visible("l_st73,l_ycha2,l_st83,l_scha2,l_st93",FALSE)
                            CALL cl_set_comp_visible("l_st273,l_ycha22,l_st283,l_scha22,l_st293",FALSE)                     
                            CALL cl_set_comp_visible("l_st373,l_ycha32,l_st383,l_scha32,l_st393",FALSE)
                            CALL cl_set_comp_visible("l_st473,l_ycha42,l_st483,l_scha42,l_st493",FALSE)
                            CALL cl_set_comp_visible("l_st573,l_ycha52,l_st583,l_scha52,l_st593",FALSE)                     
                            CALL cl_set_comp_visible("l_st673,l_ycha62,l_st683,l_scha62,l_st693",FALSE)                                   
                            CALL cl_set_comp_visible("l_mcha2,l_st13,l_lcha2,l_st43,l_zcha2",FALSE)
                            CALL cl_set_comp_visible("l_mcha22,l_st213,l_lcha22,l_st243,l_zcha22",FALSE)                     
                            CALL cl_set_comp_visible("l_mcha32,l_st313,l_lcha32,l_st343,l_zcha32",FALSE)
                            CALL cl_set_comp_visible("l_mcha42,l_st413,l_lcha42,l_st443,l_zcha42",FALSE)
                            CALL cl_set_comp_visible("l_mcha52,l_st513,l_lcha52,l_st543,l_zcha52",FALSE)                     
                            CALL cl_set_comp_visible("l_mcha62,l_st613,l_lcha62,l_st643,l_zcha62",FALSE)     
                         END IF                       
                       END IF
                      CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date32
                         
                      AFTER INPUT
                         IF INT_FLAG THEN
           
                         END IF
                            
         END INPUT           
         #160126-00002#3 160130 By s983961 add(E)
         
         #楼层
         DISPLAY ARRAY g_stgg_d2 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stgg_d2.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
         
         #专柜
         DISPLAY ARRAY g_stgg_d3 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt) #MARKED BY LANJJ 2015-12-22
         #DISPLAY ARRAY g_stgg_d3 TO s_detail6.* ATTRIBUTE(COUNT=g_detail_cnt)  #added by lanjj 2015-12-22
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")      #s_detail4 modified by lanjj 2015-12-22
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stgg_d3.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         
         #品类
         DISPLAY ARRAY g_stgg_d4 TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stgg_d4.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         
         #供应商
         DISPLAY ARRAY g_stgg_d5 TO s_detail6.* ATTRIBUTE(COUNT=g_detail_cnt) #MARKED BY LANJJ 2015-12-22
         #DISPLAY ARRAY g_stgg_d5 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)  #added by lanjj 2015-12-22
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail6")     #s_detail6 modified by lanjj 2015-12-22
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stgg_d5.getLength() TO FORMONLY.h_count
 
         END DISPLAY
         
           #门店
        DISPLAY ARRAY g_stgg_d6 TO s_detail7.* ATTRIBUTE(COUNT=g_detail_cnt) 
            
            BEFORE DISPLAY
               LET g_current_page = 2

            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail7")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               DISPLAY g_stgg_d6.getLength() TO FORMONLY.h_count
 
         END DISPLAY 
        
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail2", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq510_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#3 160127 By s983961 add(S)
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            #160126-00002#3 160127 By s983961 add(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astq510_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
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
               CALL astq510_query()
               #add-point:ON ACTION query name="menu.query"
               CALL astq510_query2()
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
            CALL astq510_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #160126-00002#3 160127 By s983961 add
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
            CALL astq510_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stgg_d)
               LET g_export_id[1]   = "s_detail2"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_stgg_d3)
               LET g_export_id[2]   = "s_detail4"
               LET g_export_node[3] = base.typeInfo.create(g_stgg_d5)
               LET g_export_id[3]   = "s_detail6"
               LET g_export_node[4] = base.typeInfo.create(g_stgg_d2)
               LET g_export_id[4]   = "s_detail3"
               LET g_export_node[5] = base.typeInfo.create(g_stgg_d4)
               LET g_export_id[5]   = "s_detail5"
               LET g_export_node[6] = base.typeInfo.create(g_stgg_d6)
               LET g_export_id[6]   = "s_detail7"
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
            CALL astq510_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq510_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq510_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq510_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION mendian
            LET g_action_choice="mendian"
            IF cl_auth_chk_act("mendian") THEN
               CALL astq510_b_fill6()
            END IF
        
         ON ACTION louceng
            LET g_action_choice="louceng"
            IF cl_auth_chk_act("louceng") THEN
               CALL astq510_b_fill2()
            END IF
        
          ON ACTION pinlei
            LET g_action_choice="pinlei"
            IF cl_auth_chk_act("pinlei") THEN
               CALL astq510_b_fill4()
            END IF
            
          ON ACTION gongyingshang
            LET g_action_choice="gongyingshang"
            IF cl_auth_chk_act("gongyingshang") THEN
               CALL astq510_b_fill5()
            END IF
        
         ON ACTION zhuangui
            LET g_action_choice="zhuangui"
            IF cl_auth_chk_act("zhuangui") THEN
               CALL astq510_b_fill3()
            END IF 
            
         #160126-00002#3 160127 By s983961 add(S)   
         ON ACTION ACCEPT                  
            IF cl_null(date11) THEN        
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD date11
            END IF
            
            IF NOT cl_null(date12) THEN
              IF NOT cl_null(date11) AND date12 < date11 THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   NEXT FIELD date12
              END IF  
            ELSE              
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD date12
            END IF
            
            IF NOT cl_null(date21) THEN
                IF NOT cl_null(date22) AND date21 > date22 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD date21
                END IF
            ELSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD date21
            END IF
            
            IF NOT cl_null(date22) THEN
                #CALL cl_set_comp_required("date31",FALSE)
                #CALL cl_set_comp_required("date32",FALSE) 
               IF NOT cl_null(date21) AND  date22 < date21 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD date22
                END IF
            ELSE 
               IF NOT cl_null(date31) AND NOT cl_null(date32) THEN 
                  #CALL cl_set_comp_required("date21",FALSE)
                  #CALL cl_set_comp_required("date22",FALSE)
               ELSE
                  #CALL cl_set_comp_required("date31",TRUE)
                  #CALL cl_set_comp_required("date32",TRUE) 
                  CALL cl_set_comp_visible("l_st72,l_ycha1,l_st82,l_scha1,l_st92",FALSE)
                  CALL cl_set_comp_visible("l_st272,l_ycha21,l_st282,l_scha21,l_st292",FALSE)                     
                  CALL cl_set_comp_visible("l_st372,l_ycha31,l_st382,l_scha31,l_st392",FALSE)
                  CALL cl_set_comp_visible("l_st472,l_ycha41,l_st482,l_scha41,l_st492",FALSE)
                  CALL cl_set_comp_visible("l_st572,l_ycha51,l_st582,l_scha51,l_st592",FALSE)                     
                  CALL cl_set_comp_visible("l_st672,l_ycha61,l_st682,l_scha61,l_st692",FALSE)                                                
                  CALL cl_set_comp_visible("l_mcha1,l_st12,l_lcha1,l_st42,l_zcha1",FALSE)
                  CALL cl_set_comp_visible("l_mcha21,l_st212,l_lcha21,l_st242,l_zcha21",FALSE)                     
                  CALL cl_set_comp_visible("l_mcha31,l_st312,l_lcha31,l_st342,l_zcha31",FALSE)
                  CALL cl_set_comp_visible("l_mcha41,l_st412,l_lcha41,l_st442,l_zcha41",FALSE)
                  CALL cl_set_comp_visible("l_mcha51,l_st512,l_lcha51,l_st542,l_zcha51",FALSE)                     
                  CALL cl_set_comp_visible("l_mcha61,l_st612,l_lcha61,l_st642,l_zcha61",FALSE)                             
               END IF  
               
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD date22                
            END IF
                    
            IF NOT cl_null(date31) THEN
              IF NOT cl_null(date32) AND date31 > date32 THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "" 
                    LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    NEXT FIELD date31
              END IF
            ELSE
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD date31           
            END IF    

            IF NOT cl_null(date32) THEN
              CALL cl_set_comp_required("date21",FALSE)
              CALL cl_set_comp_required("date22",FALSE)  
              IF NOT cl_null(date31) AND date32 < date31 THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "" 
                    LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    NEXT FIELD date32
               END IF
            ELSE
              IF NOT  cl_null(date21) AND NOT cl_null(date22) THEN 
                 CALL cl_set_comp_required("date31",FALSE)
                 CALL cl_set_comp_required("date32",FALSE)
              ELSE
                 CALL cl_set_comp_required("date21",TRUE)
                 CALL cl_set_comp_required("date22",TRUE)  
                 CALL cl_set_comp_visible("l_st73,l_ycha2,l_st83,l_scha2,l_st93",FALSE)
                 CALL cl_set_comp_visible("l_st273,l_ycha22,l_st283,l_scha22,l_st293",FALSE)                     
                 CALL cl_set_comp_visible("l_st373,l_ycha32,l_st383,l_scha32,l_st393",FALSE)
                 CALL cl_set_comp_visible("l_st473,l_ycha42,l_st483,l_scha42,l_st493",FALSE)
                 CALL cl_set_comp_visible("l_st573,l_ycha52,l_st583,l_scha52,l_st593",FALSE)                     
                 CALL cl_set_comp_visible("l_st673,l_ycha62,l_st683,l_scha62,l_st693",FALSE)                                   
                 CALL cl_set_comp_visible("l_mcha2,l_st13,l_lcha2,l_st43,l_zcha2",FALSE)
                 CALL cl_set_comp_visible("l_mcha22,l_st213,l_lcha22,l_st243,l_zcha22",FALSE)                     
                 CALL cl_set_comp_visible("l_mcha32,l_st313,l_lcha32,l_st343,l_zcha32",FALSE)
                 CALL cl_set_comp_visible("l_mcha42,l_st413,l_lcha42,l_st443,l_zcha42",FALSE)
                 CALL cl_set_comp_visible("l_mcha52,l_st513,l_lcha52,l_st543,l_zcha52",FALSE)                     
                 CALL cl_set_comp_visible("l_mcha62,l_st613,l_lcha62,l_st643,l_zcha62",FALSE)     
              END IF       
             
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = 'acr-00015'
              LET g_errparam.extend = ''
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD date32             
            END IF
            
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq510_b_fill()
            IF g_stgg_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail2", g_detail_idx)
            END IF
                     
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
            
         #160126-00002#3 160127 By s983961 add(E)     
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
 
{<section id="astq510.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astq510_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   return
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stgg_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON stgg002
           FROM s_detail2[1].b_stgg002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_stggsite_1>>----
         #----<<b_stggsite_1_desc>>----
         #----<<b_stgg005_1>>----
         #----<<b_stgg005_1_desc>>----
         #----<<b_stgg003_1>>----
         #----<<b_stgg003_1_desc>>----
         #----<<b_stfa051_1>>----
         #----<<b_stfa051_1_desc>>----
         #----<<b_stgg004_1>>----
         #----<<b_stgg004_1_desc>>----
         #----<<b_stgg002>>----
         #Ctrlp:construct.c.page2.b_stgg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgg002
            #add-point:ON ACTION controlp INFIELD b_stgg002 name="construct.c.page2.b_stgg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgg002  #顯示到畫面上
            NEXT FIELD b_stgg002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stgg002
            #add-point:BEFORE FIELD b_stgg002 name="construct.b.page2.b_stgg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stgg002
            
            #add-point:AFTER FIELD b_stgg002 name="construct.a.page2.b_stgg002"
            
            #END add-point
            
 
 
         #----<<b_stgg002_desc>>----
         #----<<l_st71>>----
         #----<<l_st72>>----
         #----<<l_ycha1>>----
         #----<<l_st73>>----
         #----<<l_ycha2>>----
         #----<<l_st81>>----
         #----<<l_st82>>----
         #----<<l_scha1>>----
         #----<<l_st83>>----
         #----<<l_scha2>>----
         #----<<l_st91>>----
         #----<<l_st92>>----
         #----<<l_mcha1>>----
         #----<<l__st93>>----
         #----<<l_mcha2>>----
         #----<<l_st11>>----
         #----<<l_st12>>----
         #----<<l_lcha1>>----
         #----<<l_st13>>----
         #----<<l_lcha2>>----
         #----<<l_st41>>----
         #----<<l_st42>>----
         #----<<l_zcha1>>----
         #----<<l_st43>>----
         #----<<l_zcha2>>----
   
       
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
   CALL astq510_b_fill()
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
 
{<section id="astq510.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq510_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE g_sql11           STRING
   DEFINE g_sql22           STRING
   DEFINE g_sql33           STRING
   DEFINE g_sql2           STRING
   DEFINE g_sql3           STRING
   DEFINE r_success          LIKE type_t.num5
  
   
   DEFINE l_stg RECORD 
 stg73 LIKE stgg_t.stgg007,
  stg83 LIKE stgg_t.stgg008,
 stg93 LIKE stgg_t.stgg009,
 stg103 LIKE stgg_t.stgg009,
 stg143 LIKE  stgg_t.stgg014,
 stggent LIKE stgg_t.stggent,
 stggsite LIKE stgg_t.stggsite,
 stgg002 LIKE stgg_t.stgg002,
 stgg003 LIKE stgg_t.stgg003,
 stgg004 LIKE stgg_t.stgg004,
 stgg005 LIKE stgg_t.stgg005,
 stfa051 LIKE stfa_t.stfa051
END RECORD

DEFINE l_stgg RECORD 
 stg72 LIKE stgg_t.stgg007,
 stg82 LIKE stgg_t.stgg008,
 stg92 LIKE stgg_t.stgg009,
 stg102 LIKE stgg_t.stgg009,
 stg142 LIKE  stgg_t.stgg014,
 stggent LIKE stgg_t.stggent,
 stggsite LIKE stgg_t.stggsite,
 stgg002 LIKE stgg_t.stgg002,
 stgg003 LIKE stgg_t.stgg003,
 stgg004 LIKE stgg_t.stgg004,
 stgg005 LIKE stgg_t.stgg005,
 stfa051 LIKE stfa_t.stfa051
END RECORD
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   define g_max_rec_t     like type_t.num20
   DEFINE l_where         STRING
   DEFINE l_success       LIKE type_t.num5
  
   CALL s_aooi500_sql_where(g_prog,'stggsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','',stgg002,'','','','','','','','','', 
       '','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY stgg_t.stggsite, 
       stgg_t.stgg001,stgg_t.stgg002) AS RANK FROM stgg_t",
 
 
                     "",
                     " WHERE stggent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stgg_t"),
                     " ORDER BY stgg_t.stggsite,stgg_t.stgg001,stgg_t.stgg002"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
  LET ls_wc=ls_wc CLIPPED," AND ",l_where  #add by dengdd 151020
  
  #应收金额st7、实收金额st8、毛利金额st9、租金金额st14
   LET ls_sql_rank = " select stggent,stgg001,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,stgg003,mhael023,stgg004,
                              pmaal003,stgg002,inayl003,
                              COALESCE(stgg007,0) st7 ,COALESCE(stgg008,0) st8,
                              COALESCE(stgg009,0) st9 ,COALESCE(stgg014,0) st14
                        from stgg_t 
                        left join ooefl_t on stggent = ooeflent AND stggsite = ooefl001 AND ooefl002 =  '",g_dlang,"' 
                        LEFT JOIN mhae_t  ON stggent= mhaeent AND stggsite = mhaesite AND stgg003=mhae001                                       
                        LEFT JOIN mhael_t ON mhaeent = mhaelent AND mhaesite =mhaelsite AND mhae001 = mhael001 AND mhael022 =  '",g_dlang,"' 
                        LEFT JOIN mhabl_t ON mhaeent = mhablent AND mhae020=mhabl001 AND mhae021 = mhabl002 AND mhabl003 =  '",g_dlang,"' 
                        left join stfa_t on stfa005 = stgg003
                        
                        LEFT JOIN rtaxl_t ON stggent=rtaxlent AND stfa051=rtaxl001 AND rtaxl002 =   '",g_dlang,"' 
                        LEFT JOIN pmaal_t ON stggent=pmaalent AND stgg004=pmaal001 AND pmaal002 =  '",g_dlang,"' 
                        LEFT JOIN inayl_t ON stggent=inaylent AND stgg002=inayl001 AND inayl002 =  '",g_dlang,"' ",
                        " WHERE stggent= ? AND 1=1 AND ", ls_wc,
#                        " and (rtaxl001 like '5_' or rtaxl001 like '6_' ) "  #mark by dengdd 151020
                        "  AND stfa003 IN ('4','5') "                         #add  by dengdd 151020
                       
                        
     LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stgg_t"),
                       " group by stggent,stgg001,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003 ,stgg007,stgg008,stgg009,stgg014 "
                       



   
  #日期区间一(应收金额1、实收金额1、毛利金额1、毛利率1(实收/毛利)、租金金额1)
#  LET g_sql11 = "select stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
#                        stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003,
#                        sum(COALESCE(st7,0)) stg71,0,0,0,0,
#                        sum(COALESCE(st8,0)) stg81,0,0,0,0,
#                        sum(COALESCE(st9,0)) stg91,0,0,0,0,
#                        decode(sum(COALESCE(st8,0)),0,100,sum(COALESCE(st9,0))/sum(COALESCE(st8,0))) stg101,0,0,0,0,
#                        sum(COALESCE(st14,0)) stg141,0,0,0,0
#                   from (",ls_sql_rank,") 
#                  where stgg001 between to_date('",date11,"','yy/mm/dd') and to_date('",date12,"','yy/mm/dd') ",
#                " group by stggent, stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
#                           stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003  "             #marked by lanjj 2015-12-22
  LET g_sql11 = " SELECT stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                         stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003,
                         SUM(COALESCE(st7,0)) stg71,'','','','',
                         SUM(COALESCE(st8,0)) stg81,'','','','',
                         SUM(COALESCE(st9,0)) stg91,'','','','',
                         decode(sum(COALESCE(st8,0)),0,100,sum(COALESCE(st9,0))/sum(COALESCE(st8,0))) stg101,'','','','',
                         SUM(COALESCE(st14,0)) stg141,'','','',''
                    FROM (",ls_sql_rank,") 
                   WHERE stgg001 BETWEEN to_date('",date11,"','yy/mm/dd') AND to_date('",date12,"','yy/mm/dd') ",
                "  GROUP BY stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                           stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003  "              #ADDED BY LANJJ 2015-12-22
   
  LET g_sql_del = "DELETE FROM astq510_tmp "
  EXECUTE IMMEDIATE g_sql_del  
  #日期区间1的数据insert进临时表
  LET g_sql_ins = " INSERT INTO astq510_tmp (stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,stgg003,mhael023,
                                             stgg004,pmaal003,stgg002,inayl003,
                                              l_st71,l_st72,l_y1,l_st73,l_y2,
                                              l_st81,l_st82,l_s1,l_st83,l_s2,
                                              l_st91,l_st92,l_m1,l_st93,l_m2,
                                              l_st11,l_st12,l_l1,l_st13,l_l2,
                                              l_st41,l_st42,l_z1,l_st43,l_z2 ) ",g_sql11                                                                      
  PREPARE ins_tmp FROM g_sql_ins
  EXECUTE ins_tmp USING g_enterprise
  
  #抓取日期区间2的金额
    LET g_sql2 = "MERGE INTO astq510_tmp t3
                       USING ( select stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                                 stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003,
                                sum(COALESCE(st7,0)) stg72,
                                sum(COALESCE(st8,0)) stg82,
                                sum(COALESCE(st9,0)) stg92,
                                decode(sum(COALESCE(st8,0)),0,100,sum(COALESCE(st9,0))/sum(COALESCE(st8,0))) stg102,
                                sum(COALESCE(st14,0)) stg142
                                 from (",ls_sql_rank,")
                                where stgg001 between to_date('",date21,"','yy/mm/dd') and to_date('",date22,"','yy/mm/dd') 
                                group by stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                                       stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003  ) t4    ",
                           " ON (t4.stggent = t3.stggent and t4.stggsite = t3.stggsite and t4.stgg002 = t3.stgg002 
                                 and t4.stgg003 = t3.stgg003 and t4.stgg004  = t3.stgg004  and t4.stgg005 = t3.stgg005) " ,
                           " WHEN MATCHED THEN   ",
                           " UPDATE SET   ",
                           " l_st72  =stg72 ,  
                             l_st82  =stg82,
                             l_st92  =stg92,
                             l_st12  =stg102,
                             l_st42  =stg142   ",
                           " WHEN NOT MATCHED THEN  ",
                           " INSERT
                             VALUES ( t4.stggent,t4.stggsite,t4.ooefl003,t4.stgg005,t4.mhabl004,t4.stfa051,t4.rtaxl003,t4.stgg003,t4.mhael023,
                                             t4.stgg004,t4.pmaal003,t4.stgg002,t4.inayl003,
                                             0,t4.stg72,0,0,0,
                                             0,t4.stg82,0,0,0,
                                             0,t4.stg92,0,0,0,
                                             0,t4.stg102,0,0,0,
                                             0,t4.stg142,0,0,0  )    "
                              
         PREPARE ins_tmp2 FROM g_sql2
         EXECUTE ins_tmp2 USING g_enterprise                 
      
    #抓取日期区间3的金额
   LET g_sql3 = "MERGE INTO astq510_tmp t5
                       USING ( select stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                                 stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003,
                                sum(COALESCE(st7,0)) stg73,
                                sum(COALESCE(st8,0)) stg83,
                                sum(COALESCE(st9,0)) stg93,
                                decode(sum(COALESCE(st8,0)),0,100,sum(COALESCE(st9,0))/sum(COALESCE(st8,0))) stg103,
                                sum(COALESCE(st14,0)) stg143
                                 from (",ls_sql_rank,")
                                where stgg001 between to_date('",date31,"','yy/mm/dd') and to_date('",date32,"','yy/mm/dd') 
                                group by stggent,stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,
                                       stgg003,mhael023,stgg004,pmaal003,stgg002,inayl003  ) t6    ",
                           " ON (t6.stggent = t5.stggent and t6.stggsite = t5.stggsite and t6.stgg002 = t5.stgg002 
                                 and t6.stgg003 = t5.stgg003 and t6.stgg004  = t5.stgg004  and t6.stgg005 = t5.stgg005) " ,
                           " WHEN MATCHED THEN   ",
                           " UPDATE SET   ",
                           " l_st73  =stg73 ,  
                             l_st83  =stg83,
                             l_st93  =stg93,
                             l_st13  =stg103,
                             l_st43  =stg143   ",
                           " WHEN NOT MATCHED THEN  ",
                           " INSERT 
                             VALUES ( t6.stggent,t6.stggsite,t6.ooefl003,t6.stgg005,t6.mhabl004,t6.stfa051,t6.rtaxl003,t6.stgg003,t6.mhael023,
                                             t6.stgg004,t6.pmaal003,t6.stgg002,t6.inayl003,
                                             0,0,0,t6.stg73,0,
                                             0,0,0,t6.stg83,0,
                                             0,0,0,t6.stg93,0,
                                             0,0,0,t6.stg103,0,
                                             0,0,0,t6.stg143,0  )    "     
   
           PREPARE ins_tmp3 FROM g_sql3
  EXECUTE ins_tmp3 USING g_enterprise
  #计算应收差额、实收差额、毛利差额、租金差额
  LET g_sql22 = "
         MERGE INTO astq510_tmp t1
         USING (SELECT * FROM astq510_tmp ) t2
            ON ( t2.stggent = t1.stggent and t2.stggsite = t1.stggsite and t2.stgg002 = t1.stgg002 
             and t2.stgg003 = t1.stgg003 and t2.stgg004  = t1.stgg004  and t2.stgg005 = t1.stgg005)
         WHEN MATCHED THEN
         UPDATE SET  ",
         "  t1.l_y1   =  t2.l_st71   -  t2.l_st72  ,
            t1.l_y2   =  t2.l_st71   -  t2.l_st73  ,  
            t1.l_s1   =  t2.l_st81   -  t2.l_st82  ,
            t1.l_s2   =  t2.l_st81   -  t2.l_st83  ,
            t1.l_m1   =  t2.l_st91   -  t2.l_st92  , 
            t1.l_m2   =  t2.l_st91   -  t2.l_st93  ,
            t1.l_st11 =  decode(t2.l_st81,0,100,t2.l_st91  / t2.l_st81 ) ,
            t1.l_st12 =  decode(t2.l_st82,0,100,t2.l_st92  / t2.l_st82 ) ,
            t1.l_l1   =  decode(t2.l_st81,0,100,t2.l_st91  / t2.l_st81 )   -  decode(t2.l_st82,0,100,t2.l_st92  / t2.l_st82 )   ,
            t1.l_st13 =  decode(t2.l_st83,0,100,t2.l_st93  / t2.l_st83 ) ,
            t1.l_l2   =  decode(t2.l_st81,0,100,t2.l_st91  / t2.l_st81 )   -  decode(t2.l_st83,0,100,t2.l_st93  / t2.l_st83 )    ,
            t1.l_z1   =  t2.l_st41   -  t2.l_st42  ,
            t1.l_z2   =  t2.l_st41   -  t2.l_st43   "
         
         
      
       EXECUTE IMMEDIATE g_sql22 
  #计算毛利率1、2、3、
  #计算毛利率差
                           
  #隐藏栏位
  
  
  #隐藏栏位
  
  
      
    LET ls_sql_rank = " SELECT   stggsite,ooefl003,stgg005,mhabl004,stgg003,mhael023,stfa051,rtaxl003,
                                 stgg004,pmaal003,stgg002,inayl003,
                                  l_st71,l_st72,l_y1,l_st73,l_y2,
                                  l_st81,l_st82,l_s1,l_st83,l_s2,
                                  l_st91,l_st92,l_m1,l_st93,l_m2,
                                  l_st11,l_st12,l_l1,l_st13,l_l2,
                                  l_st41,l_st42,l_z1,l_st43,l_z2   ",
                       "  FROM  astq510_tmp WHERE stggent = ? ",
                       " group  by  stggsite,ooefl003,stgg005,mhabl004,stfa051,rtaxl003,stgg003,mhael023,stgg004,
                                    pmaal003,stgg002,inayl003,l_st71,l_st72,l_y1,l_st73,l_y2,
                                  l_st81,l_st82,l_s1,l_st83,l_s2,
                                  l_st91,l_st92,l_m1,l_st93,l_m2,
                                  l_st11,l_st12,l_l1,l_st13,l_l2,
                                  l_st41,l_st42,l_z1,l_st43,l_z2 " 

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
 
   LET g_sql = "SELECT '','','','','','','','','','',stgg002,'','','','','','','','','','','','','', 
       '','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

      LET g_sql = ls_sql_rank               
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq510_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq510_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stgg_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_stgg_d[l_ac].stggsite,g_stgg_d[l_ac].stggsite_1_desc,g_stgg_d[l_ac].stgg005, 
       g_stgg_d[l_ac].stgg005_1_desc,g_stgg_d[l_ac].stgg003,g_stgg_d[l_ac].stgg003_1_desc,g_stgg_d[l_ac].stfa051, 
       g_stgg_d[l_ac].stfa051_1_desc,g_stgg_d[l_ac].stgg004,g_stgg_d[l_ac].stgg004_1_desc,g_stgg_d[l_ac].stgg002, 
       g_stgg_d[l_ac].stgg002_desc,g_stgg_d[l_ac].l_st71,g_stgg_d[l_ac].l_st72,g_stgg_d[l_ac].l_ycha1, 
       g_stgg_d[l_ac].l_st73,g_stgg_d[l_ac].l_ycha2,g_stgg_d[l_ac].l_st81,g_stgg_d[l_ac].l_st82,g_stgg_d[l_ac].l_scha1, 
       g_stgg_d[l_ac].l_st83,g_stgg_d[l_ac].l_scha2,g_stgg_d[l_ac].l_st91,g_stgg_d[l_ac].l_st92,g_stgg_d[l_ac].l_mcha1, 
       g_stgg_d[l_ac].l__st93,g_stgg_d[l_ac].l_mcha2,g_stgg_d[l_ac].l_st11,g_stgg_d[l_ac].l_st12,g_stgg_d[l_ac].l_lcha1, 
       g_stgg_d[l_ac].l_st13,g_stgg_d[l_ac].l_lcha2,g_stgg_d[l_ac].l_st41,g_stgg_d[l_ac].l_st42,g_stgg_d[l_ac].l_zcha1, 
       g_stgg_d[l_ac].l_st43,g_stgg_d[l_ac].l_zcha2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_stgg_d[l_ac].statepic = cl_get_actipic(g_stgg_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL astq510_detail_show("'1'")      
 
      CALL astq510_stgg_t_mask()
 
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
   
 
   
   CALL g_stgg_d.deleteElement(g_stgg_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   let g_max_rec = g_max_rec_t
   let g_tot_cnt = l_ac-1
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_stgg_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astq510_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq510_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq510_detail_action_trans()
 
   IF g_stgg_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astq510_fetch()
   END IF
   
      CALL astq510_filter_show('stgg002','b_stgg002')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq510.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq510_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
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
 
{<section id="astq510.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq510_detail_show(ps_page)
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
 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq510.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astq510_filter()
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
      CONSTRUCT g_wc_filter ON stgg002
                          FROM s_detail2[1].b_stgg002
 
         BEFORE CONSTRUCT
                     DISPLAY astq510_filter_parser('stgg002') TO s_detail2[1].b_stgg002
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_stggsite_1>>----
         #----<<b_stggsite_1_desc>>----
         #----<<b_stgg005_1>>----
         #----<<b_stgg005_1_desc>>----
         #----<<b_stgg003_1>>----
         #----<<b_stgg003_1_desc>>----
         #----<<b_stfa051_1>>----
         #----<<b_stfa051_1_desc>>----
         #----<<b_stgg004_1>>----
         #----<<b_stgg004_1_desc>>----
         #----<<b_stgg002>>----
         #Ctrlp:construct.c.page2.b_stgg002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgg002
            #add-point:ON ACTION controlp INFIELD b_stgg002 name="construct.c.filter.page2.b_stgg002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgg002  #顯示到畫面上
            NEXT FIELD b_stgg002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgg002_desc>>----
         #----<<l_st71>>----
         #----<<l_st72>>----
         #----<<l_ycha1>>----
         #----<<l_st73>>----
         #----<<l_ycha2>>----
         #----<<l_st81>>----
         #----<<l_st82>>----
         #----<<l_scha1>>----
         #----<<l_st83>>----
         #----<<l_scha2>>----
         #----<<l_st91>>----
         #----<<l_st92>>----
         #----<<l_mcha1>>----
         #----<<l__st93>>----
         #----<<l_mcha2>>----
         #----<<l_st11>>----
         #----<<l_st12>>----
         #----<<l_lcha1>>----
         #----<<l_st13>>----
         #----<<l_lcha2>>----
         #----<<l_st41>>----
         #----<<l_st42>>----
         #----<<l_zcha1>>----
         #----<<l_st43>>----
         #----<<l_zcha2>>----
   
 
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL astq510_filter_show('stgg002','b_stgg002')
 
    
   CALL astq510_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq510.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astq510_filter_parser(ps_field)
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
 
{<section id="astq510.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astq510_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq510_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astq510.insert" >}
#+ insert
PRIVATE FUNCTION astq510_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astq510.modify" >}
#+ modify
PRIVATE FUNCTION astq510_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq510.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astq510_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq510.delete" >}
#+ delete
PRIVATE FUNCTION astq510_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq510.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq510_detail_action_trans()
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
 
{<section id="astq510.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq510_detail_index_setting()
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
            IF g_stgg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stgg_d.getLength() AND g_stgg_d.getLength() > 0
            LET g_detail_idx = g_stgg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stgg_d.getLength() THEN
               LET g_detail_idx = g_stgg_d.getLength()
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
 
{<section id="astq510.mask_functions" >}
 &include "erp/ast/astq510_mask.4gl"
 
{</section>}
 
{<section id="astq510.other_function" readonly="Y" >}

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
PRIVATE FUNCTION astq510_query2()

DEFINE ls_wc      LIKE type_t.chr500
DEFINE ls_wc2     LIKE type_t.chr500
DEFINE ls_return  STRING
DEFINE ls_result  STRING 
define l_day      like type_t.chr500
   #add-point:query段define-標準

   #end add-point 
   #add-point:query段define-客製

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stgg_d.clear()
   
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
   #开启栏位可见-start
   
    CALL cl_set_comp_visible("l_st72,l_ycha1,l_st82,l_scha1,l_st92",TRUE)
    CALL cl_set_comp_visible("l_st272,l_ycha21,l_st282,l_scha21,l_st292",TRUE)                     
    CALL cl_set_comp_visible("l_st372,l_ycha31,l_st382,l_scha31,l_st392",TRUE)
    CALL cl_set_comp_visible("l_st472,l_ycha41,l_st482,l_scha41,l_st492",TRUE)
    CALL cl_set_comp_visible("l_st572,l_ycha51,l_st582,l_scha51,l_st592",TRUE)                     
    CALL cl_set_comp_visible("l_st672,l_ycha61,l_st682,l_scha61,l_st692",TRUE)                                                
    CALL cl_set_comp_visible("l_mcha1,l_st12,l_lcha1,l_st42,l_zcha1",TRUE)
    CALL cl_set_comp_visible("l_mcha21,l_st212,l_lcha21,l_st242,l_zcha21",TRUE)                     
    CALL cl_set_comp_visible("l_mcha31,l_st312,l_lcha31,l_st342,l_zcha31",TRUE)
    CALL cl_set_comp_visible("l_mcha41,l_st412,l_lcha41,l_st442,l_zcha41",TRUE)
    CALL cl_set_comp_visible("l_mcha51,l_st512,l_lcha51,l_st542,l_zcha51",TRUE)                     
    CALL cl_set_comp_visible("l_mcha61,l_st612,l_lcha61,l_st642,l_zcha61",TRUE)         
     CALL cl_set_comp_visible("l_st73,l_ycha2,l_st83,l_scha2,l_st93",TRUE)
     CALL cl_set_comp_visible("l_st273,l_ycha22,l_st283,l_scha22,l_st293",TRUE)                     
     CALL cl_set_comp_visible("l_st373,l_ycha32,l_st383,l_scha32,l_st393",TRUE)
     CALL cl_set_comp_visible("l_st473,l_ycha42,l_st483,l_scha42,l_st493",TRUE)
     CALL cl_set_comp_visible("l_st573,l_ycha52,l_st583,l_scha52,l_st593",TRUE)                     
     CALL cl_set_comp_visible("l_st673,l_ycha62,l_st683,l_scha62,l_st693",TRUE)                                   
     CALL cl_set_comp_visible("l_mcha2,l_st13,l_lcha2,l_st43,l_zcha2",TRUE)
     CALL cl_set_comp_visible("l_mcha22,l_st213,l_lcha22,l_st243,l_zcha22",TRUE)                     
     CALL cl_set_comp_visible("l_mcha32,l_st313,l_lcha32,l_st343,l_zcha32",TRUE)
     CALL cl_set_comp_visible("l_mcha42,l_st413,l_lcha42,l_st443,l_zcha42",TRUE)
     CALL cl_set_comp_visible("l_mcha52,l_st513,l_lcha52,l_st543,l_zcha52",TRUE)                     
     CALL cl_set_comp_visible("l_mcha62,l_st613,l_lcha62,l_st643,l_zcha62",TRUE) 
    
   #开启栏位可见-end
   #关闭栏位必录
   CALL cl_set_comp_required("date21",FALSE)
   CALL cl_set_comp_required("date22",FALSE)
   CALL cl_set_comp_required("date31",FALSE)
   CALL cl_set_comp_required("date32",FALSE)
   #关闭栏位必录
 
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      CONSTRUCT g_wc_table 
             ON stggsite,stgg003,stgg004,stgg005,stfa051,stgg002
           FROM stggsite,stgg003,stgg004,stgg005,stfa051,stgg002
                
          ON ACTION controlp INFIELD stggsite      #门店编号
            #add-point:ON ACTION controlp INFIELD mmbhsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stggsite',g_site,'c')   #150308-00001#4  By benson add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO debssite  #顯示到畫面上
            NEXT FIELD stggsite                     #返回原欄位
    
         ON ACTION controlp INFIELD stgg002       #库区编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg002  #顯示到畫面上
            NEXT FIELD stgg002                     #返回原欄位
    
         ON ACTION controlp INFIELD stgg003        #专柜编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg003  #顯示到畫面上
            NEXT FIELD stgg003                     #返回原欄位
  
         ON ACTION controlp INFIELD stgg004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#3 -S
            #CALL q_pmaa001()                                       
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#3 -E
            DISPLAY g_qryparam.return1 TO stgg004  #顯示到畫面上
            NEXT FIELD stgg004                     #返回原欄位
       
         ON ACTION controlp INFIELD stgg005   #楼层编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgg005  #顯示到畫面上
            NEXT FIELD stgg005                     #返回原欄位

         ON ACTION controlp INFIELD stfa051
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
	         CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
	         let g_qryparam.where =" rtax001 like '5_' or rtax001 like '6_' "
	         LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa051  #顯示到畫面上
            NEXT FIELD stfa051                     #返回原欄位
          
          
           AFTER FIELD stggsite
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stggsite
            AFTER FIELD stgg002
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg002
           AFTER FIELD stgg003
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg003
                
           AFTER FIELD stgg004
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg004
                
           AFTER FIELD stgg005
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stgg005
                
           AFTER FIELD stfa051
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.stfa051

            #add-point:cs段more_construct
           BEFORE CONSTRUCT                     
             LET stggsite = g_site 
             DISPLAY stggsite TO stggsite
            
          #end add-point 
      
       
      END CONSTRUCT
      
     INPUT date11,date12,date21,date22,date31,date32 
      FROM date11,date12,date21,date22,date31,date32    
       ATTRIBUTE(WITHOUT DEFAULTS)
          
               BEFORE INPUT

          
            AFTER FIELD date11
             IF NOT cl_null(date12) AND date11 > date12 THEN
                   INITIALIZE g_errparam TO NULL 
                   LET g_errparam.extend = "" 
                   LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                   LET g_errparam.popup  = TRUE 
                   CALL cl_err()
                   NEXT FIELD date11
              END IF
              CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date11
                
            AFTER FIELD date12 
              IF NOT cl_null(date11) AND  date12 < date11 THEN
                    INITIALIZE g_errparam TO NULL 
                    LET g_errparam.extend = "" 
                    LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                    LET g_errparam.popup  = TRUE 
                    CALL cl_err()
                    NEXT FIELD date12
               END IF                  
              CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date12    
          AFTER FIELD date21
              IF NOT cl_null(date21) THEN
                 IF NOT cl_null(date22) AND date21 > date22 THEN
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = "" 
                       LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                       LET g_errparam.popup  = TRUE 
                       CALL cl_err()
                       NEXT FIELD date21
                     END IF
                 END IF
              CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date21
                
            AFTER FIELD date22
               IF NOT cl_null(date22) THEN
                   CALL cl_set_comp_required("date31",FALSE)
                   CALL cl_set_comp_required("date32",FALSE) 
                  IF NOT cl_null(date21) AND  date22 < date21 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD date22
                   END IF
                ELSE 
                   IF NOT cl_null(date31) AND NOT cl_null(date32) THEN 
                      CALL cl_set_comp_required("date21",FALSE)
                      CALL cl_set_comp_required("date22",FALSE)
                   ELSE
                      CALL cl_set_comp_required("date31",TRUE)
                      CALL cl_set_comp_required("date32",TRUE) 
                      CALL cl_set_comp_visible("l_st72,l_ycha1,l_st82,l_scha1,l_st92",FALSE)
                      CALL cl_set_comp_visible("l_st272,l_ycha21,l_st282,l_scha21,l_st292",FALSE)                     
                      CALL cl_set_comp_visible("l_st372,l_ycha31,l_st382,l_scha31,l_st392",FALSE)
                      CALL cl_set_comp_visible("l_st472,l_ycha41,l_st482,l_scha41,l_st492",FALSE)
                      CALL cl_set_comp_visible("l_st572,l_ycha51,l_st582,l_scha51,l_st592",FALSE)                     
                      CALL cl_set_comp_visible("l_st672,l_ycha61,l_st682,l_scha61,l_st692",FALSE)                                                
                      CALL cl_set_comp_visible("l_mcha1,l_st12,l_lcha1,l_st42,l_zcha1",FALSE)
                      CALL cl_set_comp_visible("l_mcha21,l_st212,l_lcha21,l_st242,l_zcha21",FALSE)                     
                      CALL cl_set_comp_visible("l_mcha31,l_st312,l_lcha31,l_st342,l_zcha31",FALSE)
                      CALL cl_set_comp_visible("l_mcha41,l_st412,l_lcha41,l_st442,l_zcha41",FALSE)
                      CALL cl_set_comp_visible("l_mcha51,l_st512,l_lcha51,l_st542,l_zcha51",FALSE)                     
                      CALL cl_set_comp_visible("l_mcha61,l_st612,l_lcha61,l_st642,l_zcha61",FALSE)                             
                   END IF               
               END IF
               CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date22               
                  
           AFTER FIELD date31
              IF NOT cl_null(date31) THEN
                 IF NOT cl_null(date32) AND date31 > date32 THEN
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = "" 
                       LET g_errparam.code   = 'ast-00454' # 起始时间不可大于截止时间
                       LET g_errparam.popup  = TRUE 
                       CALL cl_err()
                       NEXT FIELD date31
                   END IF
                END IF 
            CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date31                
                
               AFTER FIELD date32
                 IF NOT cl_null(date32) THEN
                    CALL cl_set_comp_required("date21",FALSE)
                    CALL cl_set_comp_required("date22",FALSE)  
                    IF NOT cl_null(date31) AND date32 < date31 THEN
                          INITIALIZE g_errparam TO NULL 
                          LET g_errparam.extend = "" 
                          LET g_errparam.code   = 'ast-00455' # 结束时间不可小于开始时间
                          LET g_errparam.popup  = TRUE 
                          CALL cl_err()
                          NEXT FIELD date32
                     END IF
                  ELSE
                    IF NOT  cl_null(date21) AND NOT cl_null(date22) THEN 
                       CALL cl_set_comp_required("date31",FALSE)
                       CALL cl_set_comp_required("date32",FALSE)
                    ELSE
                       CALL cl_set_comp_required("date21",TRUE)
                       CALL cl_set_comp_required("date22",TRUE)  
                       CALL cl_set_comp_visible("l_st73,l_ycha2,l_st83,l_scha2,l_st93",FALSE)
                       CALL cl_set_comp_visible("l_st273,l_ycha22,l_st283,l_scha22,l_st293",FALSE)                     
                       CALL cl_set_comp_visible("l_st373,l_ycha32,l_st383,l_scha32,l_st393",FALSE)
                       CALL cl_set_comp_visible("l_st473,l_ycha42,l_st483,l_scha42,l_st493",FALSE)
                       CALL cl_set_comp_visible("l_st573,l_ycha52,l_st583,l_scha52,l_st593",FALSE)                     
                       CALL cl_set_comp_visible("l_st673,l_ycha62,l_st683,l_scha62,l_st693",FALSE)                                   
                       CALL cl_set_comp_visible("l_mcha2,l_st13,l_lcha2,l_st43,l_zcha2",FALSE)
                       CALL cl_set_comp_visible("l_mcha22,l_st213,l_lcha22,l_st243,l_zcha22",FALSE)                     
                       CALL cl_set_comp_visible("l_mcha32,l_st313,l_lcha32,l_st343,l_zcha32",FALSE)
                       CALL cl_set_comp_visible("l_mcha42,l_st413,l_lcha42,l_st443,l_zcha42",FALSE)
                       CALL cl_set_comp_visible("l_mcha52,l_st513,l_lcha52,l_st543,l_zcha52",FALSE)                     
                       CALL cl_set_comp_visible("l_mcha62,l_st613,l_lcha62,l_st643,l_zcha62",FALSE)     
                    END IF                       
                  END IF
                 CALL FGL_DIALOG_GETBUFFER() RETURNING g_tm.date32
                    
                 AFTER INPUT
                    IF INT_FLAG THEN
      
                    END IF
            

      END INPUT 
 
  
      #add-point:query段more_construct

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後
     before dialog
            DISPLAY BY NAME g_tm.* 
    
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc2 = ls_wc2
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL astq510_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
################################################################################
PRIVATE FUNCTION astq510_create_tmp()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT astq510_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE astq510_tmp(
      stggent     SMALLINT,
      stggsite    VARCHAR(10),        #门店编号
      ooefl003    VARCHAR(500), 
      stgg005     VARCHAR(10),         #楼层编号
      mhabl004    VARCHAR(500), 
      stfa051     VARCHAR(10),         #管理品类
      rtaxl003    VARCHAR(500), 
      stgg003     VARCHAR(20),         #专柜编号
      mhael023    VARCHAR(80), 
      stgg004     VARCHAR(10),         #供应商编号 
      pmaal003    VARCHAR(255), 
      stgg002     VARCHAR(10),         #库区编号
      inayl003    VARCHAR(500),  
      l_st71      VARCHAR(500),          #应收金额1
      l_st72      VARCHAR(500),          #应收金额2
      l_y1        VARCHAR(500),          #应收差异1
      l_st73      VARCHAR(500),          #应收金额3
      l_y2        VARCHAR(500),          #应收差异2
      l_st81      VARCHAR(500),          #实收金额1
      l_st82      VARCHAR(500),          #实收金额2
      l_s1        VARCHAR(500),          #实收差额1
      l_st83      VARCHAR(500),          #实收金额3
      l_s2        VARCHAR(500),          #实收差额2
      l_st91      VARCHAR(500),          #毛利金额1
      l_st92      VARCHAR(500),          #毛利金额2      
      l_m1        VARCHAR(500),          #毛利差额1  
      l_st93      VARCHAR(500),          #毛利金额3
      l_m2        VARCHAR(500),          #毛利差额2 
      l_st11      VARCHAR(500),          #毛利率1
      l_st12      VARCHAR(500),          #毛利率2
      l_l1        VARCHAR(500),          #毛利率差1
      l_st13      VARCHAR(500),          #毛利率3
      l_l2        VARCHAR(500),          #毛利率差2
      l_st41      VARCHAR(500),          #租金金额1
      l_st42      VARCHAR(500),          #租金金额2
      l_z1        VARCHAR(500),          #租金差额1
      l_st43      VARCHAR(500),          #租金金额3
      l_z2        VARCHAR(500)     #租金差额2
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create astq510_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 删除临时表
################################################################################
PRIVATE FUNCTION astq510_drop_tmp()

DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE astq510_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop astq510_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success

END FUNCTION

################################################################################
# Descriptions...: 楼层stgg005
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
PRIVATE FUNCTION astq510_b_fill2()

DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_stgg_d2.clear()
   
   
  # CALL cl_set_comp_visible("   ",FALSE)
   LET l_sql1 = " SELECT UNIQUE stggsite,ooefl003,stgg005,mhabl004,
                         sum(l_st71),sum(l_st72),sum(l_y1),sum(l_st73),sum(l_y2),
                         sum(l_st81),sum(l_st82),sum(l_s1),sum(l_st83),sum(l_s2),
                         sum(l_st91),sum(l_st92),sum(l_m1),sum(l_st93),sum(l_m2),
                         sum(l_st11),sum(l_st12),sum(l_l1),sum(l_st13),sum(l_l2),
                         sum(l_st41),sum(l_st42),sum(l_z1),sum(l_st43),sum(l_z2) ",
                   " FROM astq510_tmp  ",
                   " group by stggsite,ooefl003,stgg005,mhabl004 "
 
   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_stgg2_pre1 FROM l_sql1
   DECLARE sel_stgg2_cs1  CURSOR FOR sel_stgg2_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_stgg2_cs1 # USING g_enterprise 
                       INTO g_stgg_d2[l_ac].stggsite_2, g_stgg_d2[l_ac].stggsite_2_desc,
                            g_stgg_d2[l_ac].stgg005,    g_stgg_d2[l_ac].stgg005_desc,    
                            g_stgg_d2[l_ac].l_st271,g_stgg_d2[l_ac].l_st272,g_stgg_d2[l_ac].l_ycha21,g_stgg_d2[l_ac].l_st273,g_stgg_d2[l_ac].l_ycha22,     
                            g_stgg_d2[l_ac].l_st281,g_stgg_d2[l_ac].l_st282,g_stgg_d2[l_ac].l_scha21,g_stgg_d2[l_ac].l_st283,g_stgg_d2[l_ac].l_scha22,     
                            g_stgg_d2[l_ac].l_st291,g_stgg_d2[l_ac].l_st292,g_stgg_d2[l_ac].l_mcha21,g_stgg_d2[l_ac].l_st293,g_stgg_d2[l_ac].l_mcha22,  
                            g_stgg_d2[l_ac].l_st211,g_stgg_d2[l_ac].l_st212,g_stgg_d2[l_ac].l_lcha21,g_stgg_d2[l_ac].l_st213,g_stgg_d2[l_ac].l_lcha22,
                            g_stgg_d2[l_ac].l_st241,g_stgg_d2[l_ac].l_st242,g_stgg_d2[l_ac].l_zcha21,g_stgg_d2[l_ac].l_st243,g_stgg_d2[l_ac].l_zcha22                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_stgg_d2.deleteElement(g_stgg_d2.getLength())
   
   FREE sel_stgg2_cs1

END FUNCTION

################################################################################
# Descriptions...: 专柜
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
PRIVATE FUNCTION astq510_b_fill3()

DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_stgg_d3.clear()

   LET l_sql1 = " SELECT UNIQUE stggsite,ooefl003,stgg004 ,pmaal003,stgg003,mhael023,
                         sum(l_st71),sum(l_st72),sum(l_y1),sum(l_st73),sum(l_y2),
                         sum(l_st81),sum(l_st82),sum(l_s1),sum(l_st83),sum(l_s2),
                         sum(l_st91),sum(l_st92),sum(l_m1),sum(l_st93),sum(l_m2),
                         sum(l_st11),sum(l_st12),sum(l_l1),sum(l_st13),sum(l_l2),
                         sum(l_st41),sum(l_st42),sum(l_z1),sum(l_st43),sum(l_z2) ",                        
                  " FROM astq510_tmp ",
                   " group by stggsite,ooefl003,stgg004 ,pmaal003,stgg003,mhael023   "
 
   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_stgg3_pre1 FROM l_sql1
   DECLARE sel_stgg3_cs1  CURSOR FOR sel_stgg3_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_stgg3_cs1 # USING g_enterprise 
                       INTO g_stgg_d3[l_ac].stggsite_3, g_stgg_d3[l_ac].stggsite_3_desc,
                            g_stgg_d3[l_ac].stgg004_3,  g_stgg_d3[l_ac].stgg004_3_desc,    
                            g_stgg_d3[l_ac].stgg003,    g_stgg_d3[l_ac].stgg003_desc,    
                            g_stgg_d3[l_ac].l_st371,g_stgg_d3[l_ac].l_st372,g_stgg_d3[l_ac].l_ycha31,g_stgg_d3[l_ac].l_st373,g_stgg_d3[l_ac].l_ycha32,     
                            g_stgg_d3[l_ac].l_st381,g_stgg_d3[l_ac].l_st382,g_stgg_d3[l_ac].l_scha31,g_stgg_d3[l_ac].l_st383,g_stgg_d3[l_ac].l_scha32,     
                            g_stgg_d3[l_ac].l_st391,g_stgg_d3[l_ac].l_st392,g_stgg_d3[l_ac].l_mcha31,g_stgg_d3[l_ac].l_st393,g_stgg_d3[l_ac].l_mcha32,  
                            g_stgg_d3[l_ac].l_st311,g_stgg_d3[l_ac].l_st312,g_stgg_d3[l_ac].l_lcha31,g_stgg_d3[l_ac].l_st313,g_stgg_d3[l_ac].l_lcha32,
                            g_stgg_d3[l_ac].l_st341,g_stgg_d3[l_ac].l_st342,g_stgg_d3[l_ac].l_zcha31,g_stgg_d3[l_ac].l_st343,g_stgg_d3[l_ac].l_zcha32                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_stgg_d3.deleteElement(g_stgg_d3.getLength())
   
   FREE sel_stgg3_cs1


END FUNCTION

################################################################################
# Descriptions...: 品类
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
PRIVATE FUNCTION astq510_b_fill4()


DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_stgg_d4.clear()

   LET l_sql1 = " SELECT UNIQUE stggsite,ooefl003,stfa051,rtaxl003,
                   sum(l_st71),sum(l_st72),sum(l_y1),sum(l_st73),sum(l_y2),
                   sum(l_st81),sum(l_st82),sum(l_s1),sum(l_st83),sum(l_s2),
                   sum(l_st91),sum(l_st92),sum(l_m1),sum(l_st93),sum(l_m2),
                   sum(l_st11),sum(l_st12),sum(l_l1),sum(l_st13),sum(l_l2),
                   sum(l_st41),sum(l_st42),sum(l_z1),sum(l_st43),sum(l_z2) ",
                   " FROM astq510_tmp ",
                   " group by stggsite,ooefl003,stfa051,rtaxl003 "
 
   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_stgg4_pre1 FROM l_sql1
   DECLARE sel_stgg4_cs1  CURSOR FOR sel_stgg4_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_stgg4_cs1 # USING g_enterprise 
                       INTO g_stgg_d4[l_ac].stggsite_4, g_stgg_d4[l_ac].stggsite_4_desc,
                            g_stgg_d4[l_ac].stfa051,  g_stgg_d4[l_ac].stfa051_desc,       
                            g_stgg_d4[l_ac].l_st471,g_stgg_d4[l_ac].l_st472,g_stgg_d4[l_ac].l_ycha41,g_stgg_d4[l_ac].l_st473,g_stgg_d4[l_ac].l_ycha42,     
                            g_stgg_d4[l_ac].l_st481,g_stgg_d4[l_ac].l_st482,g_stgg_d4[l_ac].l_scha41,g_stgg_d4[l_ac].l_st483,g_stgg_d4[l_ac].l_scha42,     
                            g_stgg_d4[l_ac].l_st491,g_stgg_d4[l_ac].l_st492,g_stgg_d4[l_ac].l_mcha41,g_stgg_d4[l_ac].l_st493,g_stgg_d4[l_ac].l_mcha42,  
                            g_stgg_d4[l_ac].l_st411,g_stgg_d4[l_ac].l_st412,g_stgg_d4[l_ac].l_lcha41,g_stgg_d4[l_ac].l_st413,g_stgg_d4[l_ac].l_lcha42,
                            g_stgg_d4[l_ac].l_st441,g_stgg_d4[l_ac].l_st442,g_stgg_d4[l_ac].l_zcha41,g_stgg_d4[l_ac].l_st443,g_stgg_d4[l_ac].l_zcha42                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_stgg_d4.deleteElement(g_stgg_d4.getLength())

   FREE sel_stgg4_cs1

END FUNCTION

################################################################################
# Descriptions...: 供应商
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
PRIVATE FUNCTION astq510_b_fill5()

DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_stgg_d5.clear()

   LET l_sql1 = " SELECT UNIQUE stggsite,ooefl003,stgg004 ,pmaal003,
                         sum(l_st71),sum(l_st72),sum(l_y1),sum(l_st73),sum(l_y2),
                         sum(l_st81),sum(l_st82),sum(l_s1),sum(l_st83),sum(l_s2),
                         sum(l_st91),sum(l_st92),sum(l_m1),sum(l_st93),sum(l_m2),
                         sum(l_st11),sum(l_st12),sum(l_l1),sum(l_st13),sum(l_l2),
                         sum(l_st41),sum(l_st42),sum(l_z1),sum(l_st43),sum(l_z2) ", 
                   " FROM astq510_tmp ",
                   "  group by stggsite,ooefl003,stgg004 ,pmaal003  "
                   
 
   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_stgg5_pre1 FROM l_sql1
   DECLARE sel_stgg5_cs1  CURSOR FOR sel_stgg5_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_stgg5_cs1 # USING g_enterprise 
                       INTO g_stgg_d5[l_ac].stggsite_5, g_stgg_d5[l_ac].stggsite_5_desc,
                            g_stgg_d5[l_ac].stgg004,    g_stgg_d5[l_ac].stgg004_desc,    
                            g_stgg_d5[l_ac].l_st571,g_stgg_d5[l_ac].l_st572,g_stgg_d5[l_ac].l_ycha51,g_stgg_d5[l_ac].l_st573,g_stgg_d5[l_ac].l_ycha52,     
                            g_stgg_d5[l_ac].l_st581,g_stgg_d5[l_ac].l_st582,g_stgg_d5[l_ac].l_scha51,g_stgg_d5[l_ac].l_st583,g_stgg_d5[l_ac].l_scha52,     
                            g_stgg_d5[l_ac].l_st591,g_stgg_d5[l_ac].l_st592,g_stgg_d5[l_ac].l_mcha51,g_stgg_d5[l_ac].l_st593,g_stgg_d5[l_ac].l_mcha52,  
                            g_stgg_d5[l_ac].l_st511,g_stgg_d5[l_ac].l_st512,g_stgg_d5[l_ac].l_lcha51,g_stgg_d5[l_ac].l_st513,g_stgg_d5[l_ac].l_lcha52,
                            g_stgg_d5[l_ac].l_st541,g_stgg_d5[l_ac].l_st542,g_stgg_d5[l_ac].l_zcha51,g_stgg_d5[l_ac].l_st543,g_stgg_d5[l_ac].l_zcha52                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_stgg_d5.deleteElement(g_stgg_d5.getLength())
 
   FREE sel_stgg5_cs1

END FUNCTION

################################################################################
# Descriptions...: 门店
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
PRIVATE FUNCTION astq510_b_fill6()

DEFINE l_sql    STRING
DEFINE l_sql1   STRING
DEFINE l_sql3   STRING
DEFINE l_cnt2   LIKE type_t.num5 
 
   CALL g_stgg_d6.clear()

   LET l_sql1 = " SELECT UNIQUE stggsite,ooefl003,
                         sum(l_st71),sum(l_st72),sum(l_y1),sum(l_st73),sum(l_y2),
                         sum(l_st81),sum(l_st82),sum(l_s1),sum(l_st83),sum(l_s2),
                         sum(l_st91),sum(l_st92),sum(l_m1),sum(l_st93),sum(l_m2),
                         sum(l_st11),sum(l_st12),sum(l_l1),sum(l_st13),sum(l_l2),
                         sum(l_st41),sum(l_st42),sum(l_z1),sum(l_st43),sum(l_z2) ",
                   " FROM astq510_tmp ",
                   " group by stggsite,ooefl003 "
 
   DISPLAY "l_sql1:",l_sql1  
   PREPARE sel_stgg6_pre1 FROM l_sql1
   DECLARE sel_stgg6_cs1  CURSOR FOR sel_stgg6_pre1   
   
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH sel_stgg6_cs1 # USING g_enterprise 
                       INTO g_stgg_d6[l_ac].stggsite, g_stgg_d6[l_ac].stggsite_desc,   
                            g_stgg_d6[l_ac].l_st671,g_stgg_d6[l_ac].l_st672,g_stgg_d6[l_ac].l_ycha61,g_stgg_d6[l_ac].l_st673,g_stgg_d6[l_ac].l_ycha62,     
                            g_stgg_d6[l_ac].l_st681,g_stgg_d6[l_ac].l_st682,g_stgg_d6[l_ac].l_scha61,g_stgg_d6[l_ac].l_st683,g_stgg_d6[l_ac].l_scha62,     
                            g_stgg_d6[l_ac].l_st691,g_stgg_d6[l_ac].l_st692,g_stgg_d6[l_ac].l_mcha61,g_stgg_d6[l_ac].l_st693,g_stgg_d6[l_ac].l_mcha62,  
                            g_stgg_d6[l_ac].l_st611,g_stgg_d6[l_ac].l_st612,g_stgg_d6[l_ac].l_lcha61,g_stgg_d6[l_ac].l_st613,g_stgg_d6[l_ac].l_lcha62,
                            g_stgg_d6[l_ac].l_st641,g_stgg_d6[l_ac].l_st642,g_stgg_d6[l_ac].l_zcha61,g_stgg_d6[l_ac].l_st643,g_stgg_d6[l_ac].l_zcha62                                 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
   END FOREACH
   
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CALL g_stgg_d6.deleteElement(g_stgg_d6.getLength())
   
 
   FREE sel_stgg6_cs1

END FUNCTION

 
{</section>}
 
