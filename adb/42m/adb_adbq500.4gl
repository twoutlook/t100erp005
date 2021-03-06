#該程式未解開Section, 採用最新樣板產出!
{<section id="adbq500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-03-24 17:15:00), PR版次:0004(2016-05-20 10:43:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000057
#+ Filename...: adbq500
#+ Description: 分銷訂單單據查詢列印作業
#+ Creator....: 02159(2015-01-22 13:55:40)
#+ Modifier...: 02159 -SD/PR- 06137
 
{</section>}
 
{<section id="adbq500.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_xmda_d RECORD
       
       sel LIKE type_t.chr1, 
   xmdasite LIKE xmda_t.xmdasite, 
   xmdasite_desc LIKE type_t.chr500, 
   xmdadocno LIKE xmda_t.xmdadocno, 
   xmdadocdt LIKE xmda_t.xmdadocdt, 
   xmda005 LIKE xmda_t.xmda005, 
   xmda202 LIKE xmda_t.xmda202, 
   xmda202_desc LIKE type_t.chr500, 
   xmda023 LIKE xmda_t.xmda023, 
   xmda023_desc LIKE type_t.chr500, 
   xmda004 LIKE xmda_t.xmda004, 
   xmda004_desc LIKE type_t.chr500, 
   xmda003 LIKE xmda_t.xmda003, 
   xmda003_desc LIKE type_t.chr500, 
   xmda002 LIKE xmda_t.xmda002, 
   xmda002_desc LIKE type_t.chr500, 
   xmda015 LIKE xmda_t.xmda015, 
   xmda015_desc LIKE type_t.chr500, 
   xmda021 LIKE xmda_t.xmda021, 
   xmda021_desc LIKE type_t.chr500, 
   xmda203 LIKE xmda_t.xmda203, 
   xmda203_desc LIKE type_t.chr500, 
   xmdastus LIKE xmda_t.xmdastus
       END RECORD
PRIVATE TYPE type_g_xmda2_d RECORD
       xmjaseq LIKE xmja_t.xmjaseq, 
   xmja002 LIKE xmja_t.xmja002, 
   xmja003 LIKE xmja_t.xmja003, 
   xmja003_desc LIKE type_t.chr500, 
   xmja003_desc_desc LIKE type_t.chr500, 
   xmja004 LIKE xmja_t.xmja004, 
   xmja014 LIKE xmja_t.xmja014, 
   xmja013 LIKE xmja_t.xmja013, 
   xmja013_desc LIKE type_t.chr500, 
   xmja031 LIKE xmja_t.xmja031, 
   xmja025 LIKE xmja_t.xmja025, 
   xmja025_desc LIKE type_t.chr500, 
   xmja026 LIKE xmja_t.xmja026, 
   xmja026_desc LIKE type_t.chr500, 
   xmja026_desc_1 LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_xmda3_d RECORD
       xmdddocno LIKE xmdd_t.xmdddocno, 
   xmddseq LIKE xmdd_t.xmddseq, 
   xmddseq1 LIKE xmdd_t.xmddseq1, 
   xmddseq2 LIKE xmdd_t.xmddseq2, 
   xmdd229 LIKE xmdd_t.xmdd229, 
   xmdd003 LIKE xmdd_t.xmdd003, 
   xmdd001 LIKE xmdd_t.xmdd001, 
   xmdd001_desc LIKE type_t.chr500, 
   xmdd001_desc_1 LIKE type_t.chr500, 
   xmdd002 LIKE xmdd_t.xmdd002, 
   xmdd200 LIKE xmdd_t.xmdd200, 
   xmdd200_desc LIKE type_t.chr500, 
   xmdd004 LIKE xmdd_t.xmdd004, 
   xmdd004_desc LIKE type_t.chr500, 
   xmdd005 LIKE xmdd_t.xmdd005, 
   xmdd011 LIKE xmdd_t.xmdd011, 
   xmdd012 LIKE xmdd_t.xmdd012, 
   xmdd006 LIKE xmdd_t.xmdd006, 
   xmdd201 LIKE xmdd_t.xmdd201, 
   xmdd201_desc LIKE type_t.chr500, 
   xmdd202 LIKE xmdd_t.xmdd202, 
   xmdd024 LIKE xmdd_t.xmdd024, 
   xmdd024_desc LIKE type_t.chr500, 
   xmdd025 LIKE xmdd_t.xmdd025, 
   xmdd026 LIKE xmdd_t.xmdd026, 
   xmdd026_desc LIKE type_t.chr500, 
   xmdd027 LIKE xmdd_t.xmdd027, 
   xmdd203 LIKE xmdd_t.xmdd203, 
   xmdd204 LIKE xmdd_t.xmdd204, 
   xmdd205 LIKE xmdd_t.xmdd205, 
   xmdd206 LIKE xmdd_t.xmdd206, 
   xmdd029 LIKE xmdd_t.xmdd029, 
   xmdd028 LIKE xmdd_t.xmdd028, 
   xmdd019 LIKE xmdd_t.xmdd019, 
   xmdd019_desc LIKE type_t.chr500, 
   xmdd030 LIKE xmdd_t.xmdd030, 
   xmdd207 LIKE xmdd_t.xmdd207, 
   xmdd207_desc LIKE type_t.chr500, 
   xmddunit LIKE xmdd_t.xmddunit, 
   xmddunit_desc LIKE type_t.chr500, 
   xmdd210 LIKE xmdd_t.xmdd210, 
   xmdd210_desc LIKE type_t.chr500, 
   xmdd212 LIKE xmdd_t.xmdd212, 
   xmdd213 LIKE xmdd_t.xmdd213, 
   xmdd213_desc LIKE type_t.chr500, 
   xmdd214 LIKE xmdd_t.xmdd214, 
   xmdd214_desc LIKE type_t.chr500, 
   xmdd215 LIKE xmdd_t.xmdd215, 
   xmdd009 LIKE xmdd_t.xmdd009, 
   xmdd031 LIKE xmdd_t.xmdd031, 
   xmdd014 LIKE xmdd_t.xmdd014, 
   xmdd015 LIKE xmdd_t.xmdd015, 
   xmdd016 LIKE xmdd_t.xmdd016, 
   xmdd017 LIKE xmdd_t.xmdd017, 
   xmdd221 LIKE xmdd_t.xmdd221, 
   xmddsite LIKE xmdd_t.xmddsite, 
   xmddsite_desc LIKE type_t.chr500, 
   xmdd218 LIKE xmdd_t.xmdd218, 
   xmdd218_desc LIKE type_t.chr500, 
   xmdd219 LIKE xmdd_t.xmdd219, 
   xmdd219_desc LIKE type_t.chr500, 
   xmdd220 LIKE xmdd_t.xmdd220, 
   xmdd220_desc LIKE type_t.chr500, 
   xmdd222 LIKE xmdd_t.xmdd222, 
   xmdd222_desc LIKE type_t.chr500, 
   xmdd223 LIKE xmdd_t.xmdd223, 
   xmdd223_desc LIKE type_t.chr500, 
   xmdd224 LIKE xmdd_t.xmdd224, 
   xmdd224_desc LIKE type_t.chr500, 
   xmddorga LIKE xmdd_t.xmddorga, 
   xmddorga_desc LIKE type_t.chr500, 
   xmdd226 LIKE xmdd_t.xmdd226, 
   xmdd227 LIKE xmdd_t.xmdd227, 
   xmdd227_desc LIKE type_t.chr500, 
   xmdd228 LIKE xmdd_t.xmdd228, 
   xmdd228_desc LIKE type_t.chr500, 
   xmdd013 LIKE xmdd_t.xmdd013, 
   xmdd018 LIKE xmdd_t.xmdd018, 
   xmdd020 LIKE xmdd_t.xmdd020, 
   xmdd021 LIKE xmdd_t.xmdd021, 
   xmdd021_desc LIKE type_t.chr500, 
   xmdd022 LIKE xmdd_t.xmdd022, 
   xmdd022_desc LIKE type_t.chr500, 
   xmdd023 LIKE xmdd_t.xmdd023, 
   xmdd023_desc LIKE type_t.chr500
       END RECORD
 
PRIVATE TYPE type_g_xmda4_d RECORD
       rticseq LIKE rtic_t.rticseq, 
   xmja0021 LIKE type_t.chr500, 
   xmja0031 LIKE type_t.chr500, 
   xmja0031_desc LIKE type_t.chr500, 
   xmja0031_desc_1 LIKE type_t.chr500, 
   xmja0171 LIKE type_t.chr10, 
   xmja0171_desc LIKE type_t.chr500, 
   xmja0181 LIKE type_t.num20_6, 
   xmja0081 LIKE type_t.num20_6, 
   xmja0091 LIKE type_t.num20_6, 
   xmja0101 LIKE type_t.num20_6, 
   xmja0211 LIKE type_t.num20_6, 
   rticseq1 LIKE rtic_t.rticseq1, 
   rtic001 LIKE rtic_t.rtic001, 
   rtic002 LIKE rtic_t.rtic002, 
   rtic003 LIKE rtic_t.rtic003, 
   rtic004 LIKE rtic_t.rtic004, 
   rtic005 LIKE rtic_t.rtic005, 
   rtic006 LIKE rtic_t.rtic006, 
   rtic007 LIKE rtic_t.rtic007, 
   rtic008 LIKE rtic_t.rtic008, 
   rtic009 LIKE rtic_t.rtic009, 
   rtic010 LIKE rtic_t.rtic010, 
   rtic011 LIKE rtic_t.rtic011, 
   rtic012 LIKE rtic_t.rtic012, 
   rtic013 LIKE rtic_t.rtic013, 
   rtic014 LIKE rtic_t.rtic014, 
   rtic015 LIKE rtic_t.rtic015, 
   rtic016 LIKE rtic_t.rtic016, 
   rtic017 LIKE rtic_t.rtic017, 
   rtic018 LIKE rtic_t.rtic018, 
   rtic019 LIKE rtic_t.rtic019, 
   rtic020 LIKE rtic_t.rtic020, 
   rtic021 LIKE rtic_t.rtic021, 
   rtic022 LIKE rtic_t.rtic022, 
   rtic023 LIKE rtic_t.rtic023, 
   rtic024 LIKE rtic_t.rtic024, 
   rtic025 LIKE rtic_t.rtic025, 
   rtic026 LIKE rtic_t.rtic026, 
   rtic027 LIKE rtic_t.rtic027, 
   rtic028 LIKE rtic_t.rtic028, 
   rtic029 LIKE rtic_t.rtic029
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_apca1_d_t     type_g_xmda_d 
 TYPE type_tm        RECORD
    stus           LIKE type_t.chr10,
    cnd1           LIKE type_t.chr1,
    cnd2           LIKE type_t.chr1
                     END RECORD
DEFINE tm              type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xmda_d            DYNAMIC ARRAY OF type_g_xmda_d
DEFINE g_xmda_d_t          type_g_xmda_d
DEFINE g_xmda2_d     DYNAMIC ARRAY OF type_g_xmda2_d
DEFINE g_xmda2_d_t   type_g_xmda2_d
 
DEFINE g_xmda3_d     DYNAMIC ARRAY OF type_g_xmda3_d
DEFINE g_xmda3_d_t   type_g_xmda3_d
 
DEFINE g_xmda4_d     DYNAMIC ARRAY OF type_g_xmda4_d
DEFINE g_xmda4_d_t   type_g_xmda4_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_detail2_page_action3 STRING
 
DEFINE g_wc2_table4   STRING
DEFINE g_detail2_page_action4 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
DEFINE g_wc2_filter_table3   STRING
 
DEFINE g_wc2_filter_table4   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adbq500.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adb","")
 
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
   DECLARE adbq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adbq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adbq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adbq500 WITH FORM cl_ap_formpath("adb",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adbq500_init()   
 
      #進入選單 Menu (="N")
      CALL adbq500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adbq500
      
   END IF 
   
   CLOSE adbq500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adbq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adbq500_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_xmdastus','13','N,Y,A,D,R,W,C,H,UH,X')
 
      CALL cl_set_combo_scc('b_xmda005','2063') 
   CALL cl_set_combo_scc('b_xmdd003','2055') 
   CALL cl_set_combo_scc('b_xmdd009','2057') 
   CALL cl_set_combo_scc('b_xmdd017','2058') 
   CALL cl_set_combo_scc('b_rtic001','6707') 
   CALL cl_set_combo_scc('b_rtic002','6708') 
   CALL cl_set_combo_scc('b_rtic006','6564') 
   CALL cl_set_combo_scc('b_rtic007','6565') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
 
   CALL adbq500_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adbq500.default_search" >}
PRIVATE FUNCTION adbq500_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xmdadocno = '", g_argv[01], "' AND "
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
 
{<section id="adbq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adbq500_ui_dialog() 
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
   DEFINE l_cmd           STRING
   DEFINE l_where           STRING
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
 
   
   CALL adbq500_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xmda_d.clear()
         CALL g_xmda2_d.clear()
 
         CALL g_xmda3_d.clear()
 
         CALL g_xmda4_d.clear()
 
 
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
 
         CALL adbq500_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT tm.stus,tm.cnd1,tm.cnd2
          FROM l_stus,l_cnd1,l_cnd2
            BEFORE INPUT
            
         END INPUT         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xmdasite,xmdadocno,xmdadocdt,xmda004,
                                   xmda021,xmda023,xmda002,xmda202
                                   
            ON ACTION controlp INFIELD xmdasite #銷售組織
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'xmdasite',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO xmdasite
               NEXT FIELD CURRENT  

            ON ACTION controlp INFIELD xmdadocno #訂單單號
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_xmdadocno_5()
               DISPLAY g_qryparam.return1 TO xmdadocno
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD xmda004 #經銷商編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE	
			      LET g_qryparam.where = "NOT (pmaa002 = '2' AND pmaa230 = '2')"
			      LET g_qryparam.arg1 = 'ALL'
               CALL q_pmaa001_6()
               DISPLAY g_qryparam.return1 TO xmda004
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD xmda021 #帳款客戶編號
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.arg2 = 'ALL'
               CALL q_pmac002_5()
               DISPLAY g_qryparam.return1 TO xmda021
               NEXT FIELD CURRENT               

            ON ACTION controlp INFIELD xmda023 #銷售渠道
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
		         LET g_qryparam.arg1 = "1"
               CALL q_oojd001_1()
               DISPLAY g_qryparam.return1 TO xmda023
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD xmda002 #業務人員
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO xmda002
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD xmda202 #銷售辦事處
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "ooef305 = 'Y'"
               CALL q_ooef001()
               DISPLAY g_qryparam.return1 TO xmda202
               NEXT FIELD CURRENT
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_xmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adbq500_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adbq500_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_xmda2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xmda3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xmda4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
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
            CALL adbq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET tm.stus = 'ALL'
            LET tm.cnd1 = 'N'
            LET tm.cnd2 = 'N'
            DISPLAY tm.stus,tm.cnd1,tm.cnd2 TO l_stus,l_cnd1,l_cnd2
            CALL cl_set_act_visible("insert,query", FALSE) 
            #end add-point
            NEXT FIELD xmdasite
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table4
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
            IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table3
            END IF
 
            IF NOT cl_null(g_wc2_table4) AND g_wc2_table4 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table4
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adbq500_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xmda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xmda2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_xmda3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_xmda4_d)
               LET g_export_id[4]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adbq500_b_fill()
 
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
            CALL adbq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adbq500_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adbq500_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adbq500_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xmda_d.getLength()
               LET g_xmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adbq500_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_xmda_d.getLength()
                  IF g_xmda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_xmda_d[li_idx].xmdadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_xmda_d[li_idx].xmdadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "xmdadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL adbr500_g01(l_where,tm.cnd1,tm.cnd2)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_xmda_d.getLength()
                  IF g_xmda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_xmda_d[li_idx].xmdadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_xmda_d[li_idx].xmdadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "xmdadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL adbr500_g01(l_where,tm.cnd1,tm.cnd2)
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
            LET g_action_choice="qbeclear"
            CALL adbq500_qbe_clear()
            EXIT DIALOG
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="adbq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adbq500_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'xmdasite') RETURNING l_where
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
 
   CALL g_xmda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF tm.stus != 'ALL' THEN
      LET l_where = l_where CLIPPED,"AND xmda005 IN ('1','2','3','6') AND xmda007 IN ('1','5','8') AND xmdastus = '",tm.stus CLIPPED,"'"
   END IF
   
   LET ls_wc = ls_wc CLIPPED,"AND xmda005 IN ('1','2','3','6') AND xmda007 IN ('1','5','8') AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',xmdasite,'',xmdadocno,xmdadocdt,xmda005,xmda202,'',xmda023,'', 
       xmda004,'',xmda003,'',xmda002,'',xmda015,'',xmda021,'',xmda203,'',xmdastus  ,DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK FROM xmda_t", 
 
 
#table2
                     " LEFT JOIN xmja_t ON xmjaent = xmdaent AND xmdadocno = xmjadocno",
#table3
                     " LEFT JOIN xmdd_t ON xmddent = xmdaent AND xmdadocno = xmdddocno",
#table4
                     " LEFT JOIN rtic_t ON rticent = xmdaent AND xmdadocno = rticdocno",
 
                     "",
                     " WHERE xmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                     " ORDER BY xmda_t.xmdadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET ls_sql_rank = "SELECT  UNIQUE 'N',xmdasite,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE xmdaent = ooeflent AND xmdasite = ooefl001 ",
                     "            AND ooefl002 = '",g_dlang,"') xmdasite_desc,",  #銷售組織說明
                     "        xmdadocno,xmdadocdt,xmda005,xmda202,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE xmdaent = ooeflent AND xmda202 = ooefl001 ",
                     "            AND ooefl002 = '",g_dlang,"') xmda202_desc,",   #銷售辦事處說明
                     "        xmda023,",
                     "        (SELECT oojdl003",
                     "           FROM oojdl_t",
                     "          WHERE xmdaent = oojdlent AND xmda023 = oojdl001 ",
                     "            AND oojdl002 = '",g_dlang,"') xmda023_desc,",   #銷售渠道說明
                     "               xmda004,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE xmdaent = pmaalent AND xmda004 = pmaal001 ",
                     "            AND pmaal002='",g_dlang,"') xmda004_desc,",     #經銷商編號說明
                     "        xmda003,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE xmdaent = ooeflent AND xmda003 = ooefl001 ",
                     "            AND ooefl002='",g_dlang,"') xmda003_desc,",     #業務部門說明
                     "        xmda002,",
                     "        (SELECT ooag011",
                     "           FROM ooag_t",
                     "          WHERE xmdaent = ooagent AND xmda002 = ooag001) xmda002_desc,", #業務人員說明
                     "        xmda015,",
                     "        (SELECT ooail003",
                     "           FROM ooail_t",
                     "          WHERE xmdaent = ooailent AND xmda015 = ooail001 ",
                     "            AND ooail002='",g_dlang,"') xmda015_desc,",     #幣別說明
                     "        xmda021,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE xmdaent = pmaalent AND xmda021 = pmaal001 ",
                     "            AND pmaal002='",g_dlang,"') xmda021_desc,",     #帳款客戶說明
                     "        xmda203,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE xmdaent = pmaalent AND xmda203 = pmaal001 ",
                     "            AND pmaal002='",g_dlang,"') xmda203_desc,",     #發票客戶說明
                     "         xmdastus,DENSE_RANK() OVER( ORDER BY xmda_t.xmdadocno) AS RANK ",
                     " FROM xmda_t",
                     "  LEFT JOIN xmja_t ON xmjaent = xmdaent AND xmdadocno = xmjadocno",
                     "  LEFT JOIN xmdd_t ON xmddent = xmdaent AND xmdadocno = xmdddocno",
                     "  LEFT JOIN rtic_t ON rticent = xmdaent AND xmdadocno = rticdocno",
                     " WHERE xmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xmda_t"),
                      " ORDER BY xmda_t.xmdadocno"
   #150826-00013#1 效能調整 20150909 add by beckxie---E
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
 
   LET g_sql = "SELECT '',xmdasite,'',xmdadocno,xmdadocdt,xmda005,xmda202,'',xmda023,'',xmda004,'',xmda003, 
       '',xmda002,'',xmda015,'',xmda021,'',xmda203,'',xmdastus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#1 效能調整 20150909 mark by beckxie---S
   #LET g_sql = "SELECT  UNIQUE 'N',xmdasite,t1.ooefl003,xmdadocno,xmdadocdt,xmda005,",
   #                  "               xmda202,t2.ooefl003,xmda023,t3.oojdl003,",
   #                  "               xmda004,t4.pmaal004,xmda003,t5.ooefl003,",
   #                  "               xmda002,t6.ooag011,xmda015,t7.ooail003,",
   #                  "               xmda021,t8.pmaal004,xmda203,t9.pmaal004,",
   #                  "               xmdastus",
   #                  " FROM xmda_t",
   #                  "  LEFT JOIN ooefl_t t1 ON xmdaent = t1.ooeflent AND xmdasite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #銷售組織說明
   #                  "  LEFT JOIN ooefl_t t2 ON xmdaent = t2.ooeflent AND xmda202 = t2.ooefl001 AND t2.ooefl002 = '",g_dlang,"' ",   #銷售辦事處說明
   #                  "  LEFT JOIN oojdl_t t3 ON xmdaent = t3.oojdlent AND xmda023 = t3.oojdl001 AND t3.oojdl002 = '",g_dlang,"' ",   #銷售渠道說明
   #                  "  LEFT JOIN pmaal_t t4 ON xmdaent = t4.pmaalent AND xmda004 = t4.pmaal001 AND t4.pmaal002='",g_dlang,"' ",     #經銷商編號說明
   #                  "  LEFT JOIN ooefl_t t5 ON xmdaent = t5.ooeflent AND xmda003 = t5.ooefl001 AND t5.ooefl002='",g_dlang,"' ",     #業務部門說明
   #                  "  LEFT JOIN ooag_t t6 ON xmdaent = t6.ooagent AND xmda002 = t6.ooag001 ",                                      #業務人員說明
   #                  "  LEFT JOIN ooail_t t7 ON xmdaent = t7.ooailent AND xmda015 = t7.ooail001 AND t7.ooail002='",g_dlang,"' ",     #幣別說明
   #                  "  LEFT JOIN pmaal_t t8 ON xmdaent = t8.pmaalent AND xmda021 = t8.pmaal001 AND t8.pmaal002='",g_dlang,"' ",     #帳款客戶說明
   #                  "  LEFT JOIN pmaal_t t9 ON xmdaent = t9.pmaalent AND xmda203 = t9.pmaal001 AND t9.pmaal002='",g_dlang,"' ",     #發票客戶說明
   #                  "  LEFT JOIN xmja_t ON xmjaent = xmdaent AND xmdadocno = xmjadocno",
   #                  "  LEFT JOIN xmdd_t ON xmddent = xmdaent AND xmdadocno = xmdddocno",
   #                  "  LEFT JOIN rtic_t ON rticent = xmdaent AND xmdadocno = rticdocno",
   #                  " WHERE xmdaent= ? AND 1=1 AND ", ls_wc," AND ",l_where
   #LET g_sql = g_sql, cl_sql_add_filter("xmda_t"),
   #                   " ORDER BY xmda_t.xmdadocno"
   #150826-00013#1 效能調整 20150909 mark by beckxie---E
   #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET g_sql = "SELECT 'N',xmdasite,xmdasite_desc,xmdadocno,xmdadocdt,xmda005,",
               "       xmda202,xmda202_desc,xmda023,xmda023_desc,",
               "       xmda004,xmda004_desc,xmda003,xmda003_desc,",
               "       xmda002,xmda002_desc,xmda015,xmda015_desc,",
               "       xmda021,xmda021_desc,xmda203,xmda203_desc,",
               "       xmdastus",
               " FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               "   AND RANK < ",g_pagestart + g_num_in_page                         
   #150826-00013#1 效能調整 20150909 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adbq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adbq500_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xmda_d[l_ac].sel,g_xmda_d[l_ac].xmdasite,g_xmda_d[l_ac].xmdasite_desc, 
       g_xmda_d[l_ac].xmdadocno,g_xmda_d[l_ac].xmdadocdt,g_xmda_d[l_ac].xmda005,g_xmda_d[l_ac].xmda202, 
       g_xmda_d[l_ac].xmda202_desc,g_xmda_d[l_ac].xmda023,g_xmda_d[l_ac].xmda023_desc,g_xmda_d[l_ac].xmda004, 
       g_xmda_d[l_ac].xmda004_desc,g_xmda_d[l_ac].xmda003,g_xmda_d[l_ac].xmda003_desc,g_xmda_d[l_ac].xmda002, 
       g_xmda_d[l_ac].xmda002_desc,g_xmda_d[l_ac].xmda015,g_xmda_d[l_ac].xmda015_desc,g_xmda_d[l_ac].xmda021, 
       g_xmda_d[l_ac].xmda021_desc,g_xmda_d[l_ac].xmda203,g_xmda_d[l_ac].xmda203_desc,g_xmda_d[l_ac].xmdastus 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adbq500_detail_show("'1'")
 
      CALL adbq500_xmda_t_mask()
 
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
 
   CALL g_xmda_d.deleteElement(g_xmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adbq500_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adbq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adbq500_detail_action_trans()
 
   LET l_ac = 1
   IF g_xmda_d.getLength() > 0 THEN
      CALL adbq500_b_fill2()
   END IF
 
      CALL adbq500_filter_show('xmdasite','b_xmdasite')
   CALL adbq500_filter_show('xmdadocno','b_xmdadocno')
   CALL adbq500_filter_show('xmdadocdt','b_xmdadocdt')
   CALL adbq500_filter_show('xmda005','b_xmda005')
   CALL adbq500_filter_show('xmda202','b_xmda202')
   CALL adbq500_filter_show('xmda023','b_xmda023')
   CALL adbq500_filter_show('xmda004','b_xmda004')
   CALL adbq500_filter_show('xmda003','b_xmda003')
   CALL adbq500_filter_show('xmda002','b_xmda002')
   CALL adbq500_filter_show('xmda015','b_xmda015')
   CALL adbq500_filter_show('xmda021','b_xmda021')
   CALL adbq500_filter_show('xmda203','b_xmda203')
   CALL adbq500_filter_show('xmdastus','b_xmdastus')
   CALL adbq500_filter_show('xmjaseq','b_xmjaseq')
   CALL adbq500_filter_show('xmja002','b_xmja002')
   CALL adbq500_filter_show('xmja003','b_xmja003')
   CALL adbq500_filter_show('xmja004','b_xmja004')
   CALL adbq500_filter_show('xmja014','b_xmja014')
   CALL adbq500_filter_show('xmja013','b_xmja013')
   CALL adbq500_filter_show('xmja031','b_xmja031')
   CALL adbq500_filter_show('xmja025','b_xmja025')
   CALL adbq500_filter_show('xmja026','b_xmja026')
   CALL adbq500_filter_show('xmdddocno','b_xmdddocno')
   CALL adbq500_filter_show('xmddseq','b_xmddseq')
   CALL adbq500_filter_show('xmddseq1','b_xmddseq1')
   CALL adbq500_filter_show('xmddseq2','b_xmddseq2')
   CALL adbq500_filter_show('xmdd229','b_xmdd229')
   CALL adbq500_filter_show('xmdd003','b_xmdd003')
   CALL adbq500_filter_show('xmdd001','b_xmdd001')
   CALL adbq500_filter_show('xmdd002','b_xmdd002')
   CALL adbq500_filter_show('xmdd200','b_xmdd200')
   CALL adbq500_filter_show('xmdd004','b_xmdd004')
   CALL adbq500_filter_show('xmdd005','b_xmdd005')
   CALL adbq500_filter_show('xmdd011','b_xmdd011')
   CALL adbq500_filter_show('xmdd012','b_xmdd012')
   CALL adbq500_filter_show('xmdd006','b_xmdd006')
   CALL adbq500_filter_show('xmdd201','b_xmdd201')
   CALL adbq500_filter_show('xmdd202','b_xmdd202')
   CALL adbq500_filter_show('xmdd024','b_xmdd024')
   CALL adbq500_filter_show('xmdd025','b_xmdd025')
   CALL adbq500_filter_show('xmdd026','b_xmdd026')
   CALL adbq500_filter_show('xmdd027','b_xmdd027')
   CALL adbq500_filter_show('xmdd203','b_xmdd203')
   CALL adbq500_filter_show('xmdd204','b_xmdd204')
   CALL adbq500_filter_show('xmdd205','b_xmdd205')
   CALL adbq500_filter_show('xmdd206','b_xmdd206')
   CALL adbq500_filter_show('xmdd029','b_xmdd029')
   CALL adbq500_filter_show('xmdd028','b_xmdd028')
   CALL adbq500_filter_show('xmdd019','b_xmdd019')
   CALL adbq500_filter_show('xmdd030','b_xmdd030')
   CALL adbq500_filter_show('xmdd207','b_xmdd207')
   CALL adbq500_filter_show('xmddunit','b_xmddunit')
   CALL adbq500_filter_show('xmdd210','b_xmdd210')
   CALL adbq500_filter_show('xmdd212','b_xmdd212')
   CALL adbq500_filter_show('xmdd213','b_xmdd213')
   CALL adbq500_filter_show('xmdd214','b_xmdd214')
   CALL adbq500_filter_show('xmdd215','b_xmdd215')
   CALL adbq500_filter_show('xmdd009','b_xmdd009')
   CALL adbq500_filter_show('xmdd031','b_xmdd031')
   CALL adbq500_filter_show('xmdd014','b_xmdd014')
   CALL adbq500_filter_show('xmdd015','b_xmdd015')
   CALL adbq500_filter_show('xmdd016','b_xmdd016')
   CALL adbq500_filter_show('xmdd017','b_xmdd017')
   CALL adbq500_filter_show('xmdd221','b_xmdd221')
   CALL adbq500_filter_show('xmddsite','b_xmddsite')
   CALL adbq500_filter_show('xmdd218','b_xmdd218')
   CALL adbq500_filter_show('xmdd219','b_xmdd219')
   CALL adbq500_filter_show('xmdd220','b_xmdd220')
   CALL adbq500_filter_show('xmdd222','b_xmdd222')
   CALL adbq500_filter_show('xmdd223','b_xmdd223')
   CALL adbq500_filter_show('xmdd224','b_xmdd224')
   CALL adbq500_filter_show('xmddorga','b_xmddorga')
   CALL adbq500_filter_show('xmdd226','b_xmdd226')
   CALL adbq500_filter_show('xmdd227','b_xmdd227')
   CALL adbq500_filter_show('xmdd228','b_xmdd228')
   CALL adbq500_filter_show('xmdd013','b_xmdd013')
   CALL adbq500_filter_show('xmdd018','b_xmdd018')
   CALL adbq500_filter_show('xmdd020','b_xmdd020')
   CALL adbq500_filter_show('xmdd021','b_xmdd021')
   CALL adbq500_filter_show('xmdd022','b_xmdd022')
   CALL adbq500_filter_show('xmdd023','b_xmdd023')
   CALL adbq500_filter_show('rticseq','b_rticseq')
   CALL adbq500_filter_show('rticseq1','b_rticseq1')
   CALL adbq500_filter_show('rtic001','b_rtic001')
   CALL adbq500_filter_show('rtic002','b_rtic002')
   CALL adbq500_filter_show('rtic003','b_rtic003')
   CALL adbq500_filter_show('rtic004','b_rtic004')
   CALL adbq500_filter_show('rtic005','b_rtic005')
   CALL adbq500_filter_show('rtic006','b_rtic006')
   CALL adbq500_filter_show('rtic007','b_rtic007')
   CALL adbq500_filter_show('rtic008','b_rtic008')
   CALL adbq500_filter_show('rtic009','b_rtic009')
   CALL adbq500_filter_show('rtic010','b_rtic010')
   CALL adbq500_filter_show('rtic011','b_rtic011')
   CALL adbq500_filter_show('rtic012','b_rtic012')
   CALL adbq500_filter_show('rtic013','b_rtic013')
   CALL adbq500_filter_show('rtic014','b_rtic014')
   CALL adbq500_filter_show('rtic015','b_rtic015')
   CALL adbq500_filter_show('rtic016','b_rtic016')
   CALL adbq500_filter_show('rtic017','b_rtic017')
   CALL adbq500_filter_show('rtic018','b_rtic018')
   CALL adbq500_filter_show('rtic019','b_rtic019')
   CALL adbq500_filter_show('rtic020','b_rtic020')
   CALL adbq500_filter_show('rtic021','b_rtic021')
   CALL adbq500_filter_show('rtic022','b_rtic022')
   CALL adbq500_filter_show('rtic023','b_rtic023')
   CALL adbq500_filter_show('rtic024','b_rtic024')
   CALL adbq500_filter_show('rtic025','b_rtic025')
   CALL adbq500_filter_show('rtic026','b_rtic026')
   CALL adbq500_filter_show('rtic027','b_rtic027')
   CALL adbq500_filter_show('rtic028','b_rtic028')
   CALL adbq500_filter_show('rtic029','b_rtic029')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adbq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adbq500_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_xmda2_d.clear()
#Page3
   CALL g_xmda3_d.clear()
#Page4
   CALL g_xmda4_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   #單身無資料時，直接RETURN
   LET l_cnt = g_xmda_d.getLength()
   IF l_cnt <= 0 THEN
     RETURN
   END IF
   #折扣明細篩選商品相關欄位用
   LET l_sql = "SELECT xmja002,xmja003,imaal003,imaal004,",
               "       xmja017,oocal003,xmja018,xmja008,",
               "       xmja009,xmja010,xmja021",
               "  FROM xmja_t",
               "  LEFT OUTER JOIN imaal_t ON xmjaent = imaalent AND xmja003 = imaal001 AND imaal002 = '",g_dlang,"'",
               "  LEFT OUTER JOIN oocal_t ON xmjaent = oocalent AND xmja017 = oocal001 AND oocal002 = '",g_dlang,"'",
               " WHERE xmjaent = ",g_enterprise,
               "   AND xmjadocno = '",g_xmda_d[g_detail_idx].xmdadocno,"'",
               "   AND xmjaseq = ?"
   PREPARE adbq500_xmja FROM l_sql   
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE xmjaseq,xmja002,xmja003,'','',xmja004,xmja014,xmja013,'',xmja031,xmja025, 
          '',xmja026,'','' FROM xmja_t",
                  "",
                  " WHERE xmjaent=? AND xmjadocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY xmja_t.xmjaseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      LET g_sql = "SELECT  UNIQUE xmjaseq,xmja002,xmja003,imaal003,imaal004,xmja004,xmja014,xmja013,oocal003,",
                  "               xmja031,xmja025,pmaal004,xmja026,'','' ",
                  "  FROM xmja_t",
                  "  LEFT JOIN imaal_t ON xmjaent = imaalent AND xmja003 = imaal001 AND imaal002 = '",g_dlang,"'", #商品名稱,規格
                  "  LEFT JOIN oocal_t ON xmjaent = oocalent AND xmja017 = oocal001 AND oocal002 = '",g_dlang,"'", #銷售單位說明
                  "  LEFT JOIN pmaal_t ON xmjaent = pmaalent AND xmja025 = pmaal001 AND pmaal002='",g_dlang,"' ",  #送貨客戶/網點說明
                  " WHERE xmjaent=? AND xmjadocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY xmja_t.xmjaseq"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE adbq500_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adbq500_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
      INTO g_xmda2_d[l_ac].xmjaseq,g_xmda2_d[l_ac].xmja002,g_xmda2_d[l_ac].xmja003,g_xmda2_d[l_ac].xmja003_desc, 
          g_xmda2_d[l_ac].xmja003_desc_desc,g_xmda2_d[l_ac].xmja004,g_xmda2_d[l_ac].xmja014,g_xmda2_d[l_ac].xmja013, 
          g_xmda2_d[l_ac].xmja013_desc,g_xmda2_d[l_ac].xmja031,g_xmda2_d[l_ac].xmja025,g_xmda2_d[l_ac].xmja025_desc, 
          g_xmda2_d[l_ac].xmja026,g_xmda2_d[l_ac].xmja026_desc,g_xmda2_d[l_ac].xmja026_desc_1
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      CALL adbq500_xmja026_ref()
      #end add-point
 
      CALL adbq500_detail_show("'2'")
 
      CALL adbq500_xmja_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table3
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd229,xmdd003,xmdd001,'','', 
          xmdd002,xmdd200,'',xmdd004,'',xmdd005,xmdd011,xmdd012,xmdd006,xmdd201,'',xmdd202,xmdd024,'', 
          xmdd025,xmdd026,'',xmdd027,xmdd203,xmdd204,xmdd205,xmdd206,xmdd029,xmdd028,xmdd019,'',xmdd030, 
          xmdd207,'',xmddunit,'',xmdd210,'',xmdd212,xmdd213,'',xmdd214,'',xmdd215,xmdd009,xmdd031,xmdd014, 
          xmdd015,xmdd016,xmdd017,xmdd221,xmddsite,'',xmdd218,'',xmdd219,'',xmdd220,'',xmdd222,'',xmdd223, 
          '',xmdd224,'',xmddorga,'',xmdd226,xmdd227,'',xmdd228,'',xmdd013,xmdd018,xmdd020,xmdd021,'', 
          xmdd022,'',xmdd023,'' FROM xmdd_t",
                  "",
                  " WHERE xmddent=? AND xmdddocno=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY xmdd_t.xmddseq,xmdd_t.xmddseq1,xmdd_t.xmddseq2"
  
      #add-point:單身填充前 name="b_fill2.before_fill3"
      LET g_sql = "SELECT  UNIQUE xmdddocno,xmddseq,xmddseq1,xmddseq2,xmdd229,xmdd003,xmdd001,t1.imaal003,t1.imaal004,", 
                  "               xmdd002,xmdd200,t2.prcfl003,xmdd004,t3.oocal003,xmdd005,xmdd011,xmdd012,xmdd006,xmdd201,",
                  "               t4.oocal003,xmdd202,xmdd024,t5.oocal003,xmdd025,xmdd026,t6.oocal003,xmdd027,xmdd203,xmdd204,",
                  "               xmdd205,xmdd206,xmdd029,xmdd028,xmdd019,t23.oodbl004,xmdd030,xmdd207,t7.pmaal004,xmddunit,t8.ooefl003,",  #160420-00039#1 Add By Ken 160520 原本稅別說明在Foreach中取值，改在SQL中取值  oodbl004
                  "               xmdd210,t9.oocql004,xmdd212,xmdd213,t10.inayl003,xmdd214,t11.inab003,xmdd215,xmdd009,xmdd031,",
                  "               xmdd014,xmdd015,xmdd016,xmdd017,xmdd221,xmddsite,t12.ooefl003,xmdd218,t13.oojdl003,xmdd219,t14.dbbal003,",
                  "               xmdd220,t15.dbbcl003,xmdd222,t16.ooefl003,xmdd223,t17.ooag011,xmdd224,t18.ooefl003,xmddorga,t19.ooefl003,",
                  "               xmdd226,xmdd227,t20.oocql004,xmdd228,t21.staal003,xmdd013,xmdd018,xmdd020,xmdd021,'',xmdd022,t22.ooag011,xmdd023,'' ",
                  "  FROM xmdd_t",
                  "  LEFT JOIN imaal_t t1 ON t1.imaalent = xmddent AND t1.imaal001 = xmdd001 AND t1.imaal002 = '",g_dlang,"' ",                               #商品名稱,規格
                  "  LEFT JOIN prcfl_t t2 ON t2.prcflent = xmddent AND t2.prcfl001 = xmdd200 AND t2.prcfl002 = '",g_dlang,"' ",                               #促銷方案說明
                  "  LEFT JOIN oocal_t t3 ON t3.oocalent = xmddent AND t3.oocal001 = xmdd004 AND t3.oocal002 = '",g_dlang,"' ",                               #銷售單位說明
                  "  LEFT JOIN oocal_t t4 ON t4.oocalent = xmddent AND t4.oocal001 = xmdd201 AND t4.oocal002 = '",g_dlang,"' ",                               #包裝單位說明
                  "  LEFT JOIN oocal_t t5 ON t5.oocalent = xmddent AND t5.oocal001 = xmdd024 AND t5.oocal002 = '",g_dlang,"' ",                               #參考單位說明
                  "  LEFT JOIN oocal_t t6 ON t6.oocalent = xmddent AND t6.oocal001 = xmdd026 AND t6.oocal002 = '",g_dlang,"' ",                               #計價單位說明
                  "  LEFT JOIN pmaal_t t7 ON t7.pmaalent = xmddent AND t7.pmaal001 = xmdd207 AND t7.pmaal002 = '",g_dlang,"' ",                               #網點名稱
                  "  LEFT JOIN ooefl_t t8 ON t8.ooeflent = xmddent AND t8.ooefl001 = xmddunit AND t8.ooefl002='",g_dlang,"' ",                                #發貨組織說明
                  "  LEFT JOIN oocql_t t9 ON t9.oocqlent = xmddent AND t9.oocql001 = '274' AND t9.oocql002 = xmdd210 AND t9.oocql003='",g_dlang,"' ",           #送貨時段說明
                  "  LEFT JOIN inayl_t t10 ON t10.inaylent = xmddent AND t10.inayl001 = xmdd213 ",                                                               #庫位/庫區說明
                  "  LEFT JOIN inab_t t11 ON t11.inabent = xmddent AND t11.inabsite = xmddunit AND t11.inab001 = xmdd213 AND t11.inab002 = xmdd214  ",        #儲位說明                 
                  "  LEFT JOIN ooefl_t t12 ON t12.ooeflent = xmddent AND t12.ooefl001 = xmddsite AND t12.ooefl002 = '",g_dlang,"' ",                          #銷售組織說明
                  "  LEFT JOIN oojdl_t t13 ON t13.oojdlent = xmddent AND t13.oojdl001 = xmdd218 AND t13.oojdl002='",g_dlang,"' ",                             #銷售渠道說明
                  "  LEFT JOIN dbbal_t t14 ON t14.dbbalent = xmddent AND t14.dbbal001 = xmdd219 AND t14.dbbal002='",g_dlang,"' ",                             #產品組說明
                  "  LEFT JOIN dbbcl_t t15 ON t15.dbbclent = xmddent AND t15.dbbcl001 = xmdd220 AND t15.dbbcl002='",g_dlang,"' ",                             #銷售範圍說明
                  "  LEFT JOIN ooefl_t t16 ON t16.ooeflent = xmddent AND t16.ooefl001 = xmdd222 AND t16.ooefl002='",g_dlang,"' ",                             #辦事處說明
                  "  LEFT JOIN ooag_t t17 ON t17.ooagent = xmddent AND t17.ooag001 = xmdd223  ",                                                              #業務人員說明
                  "  LEFT JOIN ooefl_t t18 ON t18.ooeflent = xmddent AND t18.ooefl001 = xmdd224 AND t18.ooefl002='",g_dlang,"' ",                             #業務部門說明                  
                  "  LEFT JOIN ooefl_t t19 ON t19.ooeflent = xmddent AND t19.ooefl001 = xmddorga AND t19.ooefl002 = '",g_dlang,"' ",                          #帳務組織說明
                  "  LEFT JOIN oocql_t t20 ON t20.oocqlent = xmddent AND t20.oocql001 = '2060' AND t20.oocql002 = xmdd227 AND t20.oocql003='",g_dlang,"' ",   #結算類型說明
                  "  LEFT JOIN staal_t t21 ON t21.staalent = xmddent AND t21.staal001 = xmdd228 AND t21.staal002='",g_dlang,"' ",                             #結算方式說明
                  "  LEFT JOIN ooag_t t22 ON t22.ooagent = xmddent AND t22.ooag001 = xmdd022  ",                    #最近修改人員名稱
                  #160420-00039#1 Add By Ken 160520(S)
                  "  LEFT JOIN (SELECT ooefent,ooef001,ooef019,oodbl002,oodbl003,oodbl004 ",
                  "               FROM oodbl_t,ooef_t ",
                  "              WHERE ooefent = oodblent AND ooef019 = oodbl001) t23 ",
                  "            ON t23.ooefent = xmddent AND t23.ooef001 = xmddsite AND t23.oodbl002 = xmdd019 AND t23.oodbl003='",g_dlang,"' ",
                  #160420-00039#1 Add By Ken 160520(E)
                  " WHERE xmddent=? AND xmdddocno=?"
      
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
      LET g_sql = g_sql, " ORDER BY xmdd_t.xmddseq,xmdd_t.xmddseq1,xmdd_t.xmddseq2"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE adbq500_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR adbq500_pb3
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs3 USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs3
      USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
      INTO g_xmda3_d[l_ac].xmdddocno,g_xmda3_d[l_ac].xmddseq,g_xmda3_d[l_ac].xmddseq1,g_xmda3_d[l_ac].xmddseq2, 
          g_xmda3_d[l_ac].xmdd229,g_xmda3_d[l_ac].xmdd003,g_xmda3_d[l_ac].xmdd001,g_xmda3_d[l_ac].xmdd001_desc, 
          g_xmda3_d[l_ac].xmdd001_desc_1,g_xmda3_d[l_ac].xmdd002,g_xmda3_d[l_ac].xmdd200,g_xmda3_d[l_ac].xmdd200_desc, 
          g_xmda3_d[l_ac].xmdd004,g_xmda3_d[l_ac].xmdd004_desc,g_xmda3_d[l_ac].xmdd005,g_xmda3_d[l_ac].xmdd011, 
          g_xmda3_d[l_ac].xmdd012,g_xmda3_d[l_ac].xmdd006,g_xmda3_d[l_ac].xmdd201,g_xmda3_d[l_ac].xmdd201_desc, 
          g_xmda3_d[l_ac].xmdd202,g_xmda3_d[l_ac].xmdd024,g_xmda3_d[l_ac].xmdd024_desc,g_xmda3_d[l_ac].xmdd025, 
          g_xmda3_d[l_ac].xmdd026,g_xmda3_d[l_ac].xmdd026_desc,g_xmda3_d[l_ac].xmdd027,g_xmda3_d[l_ac].xmdd203, 
          g_xmda3_d[l_ac].xmdd204,g_xmda3_d[l_ac].xmdd205,g_xmda3_d[l_ac].xmdd206,g_xmda3_d[l_ac].xmdd029, 
          g_xmda3_d[l_ac].xmdd028,g_xmda3_d[l_ac].xmdd019,g_xmda3_d[l_ac].xmdd019_desc,g_xmda3_d[l_ac].xmdd030, 
          g_xmda3_d[l_ac].xmdd207,g_xmda3_d[l_ac].xmdd207_desc,g_xmda3_d[l_ac].xmddunit,g_xmda3_d[l_ac].xmddunit_desc, 
          g_xmda3_d[l_ac].xmdd210,g_xmda3_d[l_ac].xmdd210_desc,g_xmda3_d[l_ac].xmdd212,g_xmda3_d[l_ac].xmdd213, 
          g_xmda3_d[l_ac].xmdd213_desc,g_xmda3_d[l_ac].xmdd214,g_xmda3_d[l_ac].xmdd214_desc,g_xmda3_d[l_ac].xmdd215, 
          g_xmda3_d[l_ac].xmdd009,g_xmda3_d[l_ac].xmdd031,g_xmda3_d[l_ac].xmdd014,g_xmda3_d[l_ac].xmdd015, 
          g_xmda3_d[l_ac].xmdd016,g_xmda3_d[l_ac].xmdd017,g_xmda3_d[l_ac].xmdd221,g_xmda3_d[l_ac].xmddsite, 
          g_xmda3_d[l_ac].xmddsite_desc,g_xmda3_d[l_ac].xmdd218,g_xmda3_d[l_ac].xmdd218_desc,g_xmda3_d[l_ac].xmdd219, 
          g_xmda3_d[l_ac].xmdd219_desc,g_xmda3_d[l_ac].xmdd220,g_xmda3_d[l_ac].xmdd220_desc,g_xmda3_d[l_ac].xmdd222, 
          g_xmda3_d[l_ac].xmdd222_desc,g_xmda3_d[l_ac].xmdd223,g_xmda3_d[l_ac].xmdd223_desc,g_xmda3_d[l_ac].xmdd224, 
          g_xmda3_d[l_ac].xmdd224_desc,g_xmda3_d[l_ac].xmddorga,g_xmda3_d[l_ac].xmddorga_desc,g_xmda3_d[l_ac].xmdd226, 
          g_xmda3_d[l_ac].xmdd227,g_xmda3_d[l_ac].xmdd227_desc,g_xmda3_d[l_ac].xmdd228,g_xmda3_d[l_ac].xmdd228_desc, 
          g_xmda3_d[l_ac].xmdd013,g_xmda3_d[l_ac].xmdd018,g_xmda3_d[l_ac].xmdd020,g_xmda3_d[l_ac].xmdd021, 
          g_xmda3_d[l_ac].xmdd021_desc,g_xmda3_d[l_ac].xmdd022,g_xmda3_d[l_ac].xmdd022_desc,g_xmda3_d[l_ac].xmdd023, 
          g_xmda3_d[l_ac].xmdd023_desc
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill3"
      #CALL s_desc_get_tax_desc1(g_xmda3_d[l_ac].xmddsite,g_xmda3_d[l_ac].xmdd019) RETURNING g_xmda3_d[l_ac].xmdd019_desc   #160420-00039#1 Mark By Ken 160520
      #end add-point
 
      CALL adbq500_detail_show("'3'")
 
      CALL adbq500_xmdd_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
#table4
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE rticseq,'','','','','','','','','','','',rticseq1,rtic001,rtic002, 
          rtic003,rtic004,rtic005,rtic006,rtic007,rtic008,rtic009,rtic010,rtic011,rtic012,rtic013,rtic014, 
          rtic015,rtic016,rtic017,rtic018,rtic019,rtic020,rtic021,rtic022,rtic023,rtic024,rtic025,rtic026, 
          rtic027,rtic028,rtic029 FROM rtic_t",
                  "",
                  " WHERE rticent=? AND rticdocno=?"
  
      IF NOT cl_null(g_wc2_table4) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table4 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY rtic_t.rticseq,rtic_t.rticseq1"
  
      #add-point:單身填充前 name="b_fill2.before_fill4"
 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE adbq500_pb4 FROM g_sql
      DECLARE b_fill_curs4 CURSOR FOR adbq500_pb4
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs4 USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs4
      USING g_enterprise,g_xmda_d[g_detail_idx].xmdadocno
 
      INTO g_xmda4_d[l_ac].rticseq,g_xmda4_d[l_ac].xmja0021,g_xmda4_d[l_ac].xmja0031,g_xmda4_d[l_ac].xmja0031_desc, 
          g_xmda4_d[l_ac].xmja0031_desc_1,g_xmda4_d[l_ac].xmja0171,g_xmda4_d[l_ac].xmja0171_desc,g_xmda4_d[l_ac].xmja0181, 
          g_xmda4_d[l_ac].xmja0081,g_xmda4_d[l_ac].xmja0091,g_xmda4_d[l_ac].xmja0101,g_xmda4_d[l_ac].xmja0211, 
          g_xmda4_d[l_ac].rticseq1,g_xmda4_d[l_ac].rtic001,g_xmda4_d[l_ac].rtic002,g_xmda4_d[l_ac].rtic003, 
          g_xmda4_d[l_ac].rtic004,g_xmda4_d[l_ac].rtic005,g_xmda4_d[l_ac].rtic006,g_xmda4_d[l_ac].rtic007, 
          g_xmda4_d[l_ac].rtic008,g_xmda4_d[l_ac].rtic009,g_xmda4_d[l_ac].rtic010,g_xmda4_d[l_ac].rtic011, 
          g_xmda4_d[l_ac].rtic012,g_xmda4_d[l_ac].rtic013,g_xmda4_d[l_ac].rtic014,g_xmda4_d[l_ac].rtic015, 
          g_xmda4_d[l_ac].rtic016,g_xmda4_d[l_ac].rtic017,g_xmda4_d[l_ac].rtic018,g_xmda4_d[l_ac].rtic019, 
          g_xmda4_d[l_ac].rtic020,g_xmda4_d[l_ac].rtic021,g_xmda4_d[l_ac].rtic022,g_xmda4_d[l_ac].rtic023, 
          g_xmda4_d[l_ac].rtic024,g_xmda4_d[l_ac].rtic025,g_xmda4_d[l_ac].rtic026,g_xmda4_d[l_ac].rtic027, 
          g_xmda4_d[l_ac].rtic028,g_xmda4_d[l_ac].rtic029
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill4"
      EXECUTE adbq500_xmja USING g_xmda4_d[l_ac].rticseq
         INTO g_xmda4_d[l_ac].xmja0021,g_xmda4_d[l_ac].xmja0031,g_xmda4_d[l_ac].xmja0031_desc,g_xmda4_d[l_ac].xmja0031_desc_1,
              g_xmda4_d[l_ac].xmja0171,g_xmda4_d[l_ac].xmja0171_desc,g_xmda4_d[l_ac].xmja0181,g_xmda4_d[l_ac].xmja0081,
              g_xmda4_d[l_ac].xmja0091,g_xmda4_d[l_ac].xmja0101,g_xmda4_d[l_ac].xmja0211
      #end add-point
 
      CALL adbq500_detail_show("'4'")
 
      CALL adbq500_rtic_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_xmda2_d.deleteElement(g_xmda2_d.getLength())
#Page3
   CALL g_xmda3_d.deleteElement(g_xmda3_d.getLength())
#Page4
   CALL g_xmda4_d.deleteElement(g_xmda4_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_xmda2_d.getLength()
#Page3
   LET li_ac = g_xmda3_d.getLength()
#Page4
   LET li_ac = g_xmda4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="adbq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adbq500_detail_show(ps_page)
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
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adbq500.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adbq500_filter()
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
      CONSTRUCT g_wc_filter ON xmdasite,xmdadocno,xmdadocdt,xmda005,xmda202,xmda023,xmda004,xmda003, 
          xmda002,xmda015,xmda021,xmda203,xmdastus
                          FROM s_detail1[1].b_xmdasite,s_detail1[1].b_xmdadocno,s_detail1[1].b_xmdadocdt, 
                              s_detail1[1].b_xmda005,s_detail1[1].b_xmda202,s_detail1[1].b_xmda023,s_detail1[1].b_xmda004, 
                              s_detail1[1].b_xmda003,s_detail1[1].b_xmda002,s_detail1[1].b_xmda015,s_detail1[1].b_xmda021, 
                              s_detail1[1].b_xmda203,s_detail1[1].b_xmdastus
 
         BEFORE CONSTRUCT
                     DISPLAY adbq500_filter_parser('xmdasite') TO s_detail1[1].b_xmdasite
            DISPLAY adbq500_filter_parser('xmdadocno') TO s_detail1[1].b_xmdadocno
            DISPLAY adbq500_filter_parser('xmdadocdt') TO s_detail1[1].b_xmdadocdt
            DISPLAY adbq500_filter_parser('xmda005') TO s_detail1[1].b_xmda005
            DISPLAY adbq500_filter_parser('xmda202') TO s_detail1[1].b_xmda202
            DISPLAY adbq500_filter_parser('xmda023') TO s_detail1[1].b_xmda023
            DISPLAY adbq500_filter_parser('xmda004') TO s_detail1[1].b_xmda004
            DISPLAY adbq500_filter_parser('xmda003') TO s_detail1[1].b_xmda003
            DISPLAY adbq500_filter_parser('xmda002') TO s_detail1[1].b_xmda002
            DISPLAY adbq500_filter_parser('xmda015') TO s_detail1[1].b_xmda015
            DISPLAY adbq500_filter_parser('xmda021') TO s_detail1[1].b_xmda021
            DISPLAY adbq500_filter_parser('xmda203') TO s_detail1[1].b_xmda203
            DISPLAY adbq500_filter_parser('xmdastus') TO s_detail1[1].b_xmdastus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xmdasite>>----
         #Ctrlp:construct.c.page1.b_xmdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdasite
            #add-point:ON ACTION controlp INFIELD b_xmdasite name="construct.c.filter.page1.b_xmdasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdasite  #顯示到畫面上
            NEXT FIELD b_xmdasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdasite_desc>>----
         #----<<b_xmdadocno>>----
         #Ctrlp:construct.c.page1.b_xmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocno
            #add-point:ON ACTION controlp INFIELD b_xmdadocno name="construct.c.filter.page1.b_xmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmdadocno  #顯示到畫面上
            NEXT FIELD b_xmdadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmdadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_xmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdadocdt
            #add-point:ON ACTION controlp INFIELD b_xmdadocdt name="construct.c.filter.page1.b_xmdadocdt"
            
            #END add-point
 
 
         #----<<b_xmda005>>----
         #Ctrlp:construct.c.filter.page1.b_xmda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda005
            #add-point:ON ACTION controlp INFIELD b_xmda005 name="construct.c.filter.page1.b_xmda005"
            
            #END add-point
 
 
         #----<<b_xmda202>>----
         #Ctrlp:construct.c.page1.b_xmda202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda202
            #add-point:ON ACTION controlp INFIELD b_xmda202 name="construct.c.filter.page1.b_xmda202"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda202  #顯示到畫面上
            NEXT FIELD b_xmda202                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda202_desc>>----
         #----<<b_xmda023>>----
         #Ctrlp:construct.c.page1.b_xmda023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda023
            #add-point:ON ACTION controlp INFIELD b_xmda023 name="construct.c.filter.page1.b_xmda023"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oojd001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda023  #顯示到畫面上
            NEXT FIELD b_xmda023                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda023_desc>>----
         #----<<b_xmda004>>----
         #Ctrlp:construct.c.page1.b_xmda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda004
            #add-point:ON ACTION controlp INFIELD b_xmda004 name="construct.c.filter.page1.b_xmda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda004  #顯示到畫面上
            NEXT FIELD b_xmda004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda004_desc>>----
         #----<<b_xmda003>>----
         #Ctrlp:construct.c.page1.b_xmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda003
            #add-point:ON ACTION controlp INFIELD b_xmda003 name="construct.c.filter.page1.b_xmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda003  #顯示到畫面上
            NEXT FIELD b_xmda003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda003_desc>>----
         #----<<b_xmda002>>----
         #Ctrlp:construct.c.page1.b_xmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda002
            #add-point:ON ACTION controlp INFIELD b_xmda002 name="construct.c.filter.page1.b_xmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda002  #顯示到畫面上
            NEXT FIELD b_xmda002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda002_desc>>----
         #----<<b_xmda015>>----
         #Ctrlp:construct.c.page1.b_xmda015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda015
            #add-point:ON ACTION controlp INFIELD b_xmda015 name="construct.c.filter.page1.b_xmda015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooaj002_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda015  #顯示到畫面上
            NEXT FIELD b_xmda015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda015_desc>>----
         #----<<b_xmda021>>----
         #Ctrlp:construct.c.page1.b_xmda021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda021
            #add-point:ON ACTION controlp INFIELD b_xmda021 name="construct.c.filter.page1.b_xmda021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda021  #顯示到畫面上
            NEXT FIELD b_xmda021                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda021_desc>>----
         #----<<b_xmda203>>----
         #Ctrlp:construct.c.page1.b_xmda203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmda203
            #add-point:ON ACTION controlp INFIELD b_xmda203 name="construct.c.filter.page1.b_xmda203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmac002_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xmda203  #顯示到畫面上
            NEXT FIELD b_xmda203                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_xmda203_desc>>----
         #----<<b_xmdastus>>----
         #Ctrlp:construct.c.filter.page1.b_xmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xmdastus
            #add-point:ON ACTION controlp INFIELD b_xmdastus name="construct.c.filter.page1.b_xmdastus"
            
            #END add-point
 
 
 
 
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
 
      CALL adbq500_filter_show('xmdasite','b_xmdasite')
   CALL adbq500_filter_show('xmdadocno','b_xmdadocno')
   CALL adbq500_filter_show('xmdadocdt','b_xmdadocdt')
   CALL adbq500_filter_show('xmda005','b_xmda005')
   CALL adbq500_filter_show('xmda202','b_xmda202')
   CALL adbq500_filter_show('xmda023','b_xmda023')
   CALL adbq500_filter_show('xmda004','b_xmda004')
   CALL adbq500_filter_show('xmda003','b_xmda003')
   CALL adbq500_filter_show('xmda002','b_xmda002')
   CALL adbq500_filter_show('xmda015','b_xmda015')
   CALL adbq500_filter_show('xmda021','b_xmda021')
   CALL adbq500_filter_show('xmda203','b_xmda203')
   CALL adbq500_filter_show('xmdastus','b_xmdastus')
   CALL adbq500_filter_show('xmjaseq','b_xmjaseq')
   CALL adbq500_filter_show('xmja002','b_xmja002')
   CALL adbq500_filter_show('xmja003','b_xmja003')
   CALL adbq500_filter_show('xmja004','b_xmja004')
   CALL adbq500_filter_show('xmja014','b_xmja014')
   CALL adbq500_filter_show('xmja013','b_xmja013')
   CALL adbq500_filter_show('xmja031','b_xmja031')
   CALL adbq500_filter_show('xmja025','b_xmja025')
   CALL adbq500_filter_show('xmja026','b_xmja026')
   CALL adbq500_filter_show('xmdddocno','b_xmdddocno')
   CALL adbq500_filter_show('xmddseq','b_xmddseq')
   CALL adbq500_filter_show('xmddseq1','b_xmddseq1')
   CALL adbq500_filter_show('xmddseq2','b_xmddseq2')
   CALL adbq500_filter_show('xmdd229','b_xmdd229')
   CALL adbq500_filter_show('xmdd003','b_xmdd003')
   CALL adbq500_filter_show('xmdd001','b_xmdd001')
   CALL adbq500_filter_show('xmdd002','b_xmdd002')
   CALL adbq500_filter_show('xmdd200','b_xmdd200')
   CALL adbq500_filter_show('xmdd004','b_xmdd004')
   CALL adbq500_filter_show('xmdd005','b_xmdd005')
   CALL adbq500_filter_show('xmdd011','b_xmdd011')
   CALL adbq500_filter_show('xmdd012','b_xmdd012')
   CALL adbq500_filter_show('xmdd006','b_xmdd006')
   CALL adbq500_filter_show('xmdd201','b_xmdd201')
   CALL adbq500_filter_show('xmdd202','b_xmdd202')
   CALL adbq500_filter_show('xmdd024','b_xmdd024')
   CALL adbq500_filter_show('xmdd025','b_xmdd025')
   CALL adbq500_filter_show('xmdd026','b_xmdd026')
   CALL adbq500_filter_show('xmdd027','b_xmdd027')
   CALL adbq500_filter_show('xmdd203','b_xmdd203')
   CALL adbq500_filter_show('xmdd204','b_xmdd204')
   CALL adbq500_filter_show('xmdd205','b_xmdd205')
   CALL adbq500_filter_show('xmdd206','b_xmdd206')
   CALL adbq500_filter_show('xmdd029','b_xmdd029')
   CALL adbq500_filter_show('xmdd028','b_xmdd028')
   CALL adbq500_filter_show('xmdd019','b_xmdd019')
   CALL adbq500_filter_show('xmdd030','b_xmdd030')
   CALL adbq500_filter_show('xmdd207','b_xmdd207')
   CALL adbq500_filter_show('xmddunit','b_xmddunit')
   CALL adbq500_filter_show('xmdd210','b_xmdd210')
   CALL adbq500_filter_show('xmdd212','b_xmdd212')
   CALL adbq500_filter_show('xmdd213','b_xmdd213')
   CALL adbq500_filter_show('xmdd214','b_xmdd214')
   CALL adbq500_filter_show('xmdd215','b_xmdd215')
   CALL adbq500_filter_show('xmdd009','b_xmdd009')
   CALL adbq500_filter_show('xmdd031','b_xmdd031')
   CALL adbq500_filter_show('xmdd014','b_xmdd014')
   CALL adbq500_filter_show('xmdd015','b_xmdd015')
   CALL adbq500_filter_show('xmdd016','b_xmdd016')
   CALL adbq500_filter_show('xmdd017','b_xmdd017')
   CALL adbq500_filter_show('xmdd221','b_xmdd221')
   CALL adbq500_filter_show('xmddsite','b_xmddsite')
   CALL adbq500_filter_show('xmdd218','b_xmdd218')
   CALL adbq500_filter_show('xmdd219','b_xmdd219')
   CALL adbq500_filter_show('xmdd220','b_xmdd220')
   CALL adbq500_filter_show('xmdd222','b_xmdd222')
   CALL adbq500_filter_show('xmdd223','b_xmdd223')
   CALL adbq500_filter_show('xmdd224','b_xmdd224')
   CALL adbq500_filter_show('xmddorga','b_xmddorga')
   CALL adbq500_filter_show('xmdd226','b_xmdd226')
   CALL adbq500_filter_show('xmdd227','b_xmdd227')
   CALL adbq500_filter_show('xmdd228','b_xmdd228')
   CALL adbq500_filter_show('xmdd013','b_xmdd013')
   CALL adbq500_filter_show('xmdd018','b_xmdd018')
   CALL adbq500_filter_show('xmdd020','b_xmdd020')
   CALL adbq500_filter_show('xmdd021','b_xmdd021')
   CALL adbq500_filter_show('xmdd022','b_xmdd022')
   CALL adbq500_filter_show('xmdd023','b_xmdd023')
   CALL adbq500_filter_show('rticseq','b_rticseq')
   CALL adbq500_filter_show('rticseq1','b_rticseq1')
   CALL adbq500_filter_show('rtic001','b_rtic001')
   CALL adbq500_filter_show('rtic002','b_rtic002')
   CALL adbq500_filter_show('rtic003','b_rtic003')
   CALL adbq500_filter_show('rtic004','b_rtic004')
   CALL adbq500_filter_show('rtic005','b_rtic005')
   CALL adbq500_filter_show('rtic006','b_rtic006')
   CALL adbq500_filter_show('rtic007','b_rtic007')
   CALL adbq500_filter_show('rtic008','b_rtic008')
   CALL adbq500_filter_show('rtic009','b_rtic009')
   CALL adbq500_filter_show('rtic010','b_rtic010')
   CALL adbq500_filter_show('rtic011','b_rtic011')
   CALL adbq500_filter_show('rtic012','b_rtic012')
   CALL adbq500_filter_show('rtic013','b_rtic013')
   CALL adbq500_filter_show('rtic014','b_rtic014')
   CALL adbq500_filter_show('rtic015','b_rtic015')
   CALL adbq500_filter_show('rtic016','b_rtic016')
   CALL adbq500_filter_show('rtic017','b_rtic017')
   CALL adbq500_filter_show('rtic018','b_rtic018')
   CALL adbq500_filter_show('rtic019','b_rtic019')
   CALL adbq500_filter_show('rtic020','b_rtic020')
   CALL adbq500_filter_show('rtic021','b_rtic021')
   CALL adbq500_filter_show('rtic022','b_rtic022')
   CALL adbq500_filter_show('rtic023','b_rtic023')
   CALL adbq500_filter_show('rtic024','b_rtic024')
   CALL adbq500_filter_show('rtic025','b_rtic025')
   CALL adbq500_filter_show('rtic026','b_rtic026')
   CALL adbq500_filter_show('rtic027','b_rtic027')
   CALL adbq500_filter_show('rtic028','b_rtic028')
   CALL adbq500_filter_show('rtic029','b_rtic029')
 
 
   CALL adbq500_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adbq500.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adbq500_filter_parser(ps_field)
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
 
{<section id="adbq500.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adbq500_filter_show(ps_field,ps_object)
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
   LET ls_condition = adbq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adbq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adbq500_detail_action_trans()
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
 
{<section id="adbq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adbq500_detail_index_setting()
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
            IF g_xmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xmda_d.getLength() AND g_xmda_d.getLength() > 0
            LET g_detail_idx = g_xmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xmda_d.getLength() THEN
               LET g_detail_idx = g_xmda_d.getLength()
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
 
{<section id="adbq500.mask_functions" >}
 &include "erp/adb/adbq500_mask.4gl"
 
{</section>}
 
{<section id="adbq500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取聯絡對象識別碼
# Memo...........:
# Usage..........: CALL adbq500_get_pmaa027(p_pmaa001)
#                  RETURNING r_pmaa027
# Input parameter: p_pmaa001   送貨地址
# Return code....: r_pmaa027   聯絡對象識別碼
# Date & Author..: 2015/01/23 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adbq500_get_pmaa027(p_pmaa001)
DEFINE p_pmaa001 LIKE pmaa_t.pmaa001
DEFINE r_pmaa027 LIKE pmaa_t.pmaa003

      LET r_pmaa027 = ''
      
      SELECT pmaa027 INTO r_pmaa027
        FROM pmaa_t
       WHERE pmaaent = g_enterprise
         AND pmaa001 = p_pmaa001
         
      RETURN r_pmaa027
END FUNCTION

################################################################################
# Descriptions...: 取送貨地址說明
# Memo...........:
# Usage..........: CALL adbq500_xmja026_ref()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/01/23 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adbq500_xmja026_ref()
  DEFINE l_pmaa027   LIKE pmaa_t.pmaa027
  DEFINE r_address   STRING
  DEFINE r_success   LIKE type_t.num5  
  
      LET l_pmaa027 = ''
      LET r_address = ''                                       
      CALL adbq500_get_pmaa027(g_xmda2_d[l_ac].xmja025) RETURNING l_pmaa027
      IF NOT cl_null(g_xmda2_d[l_ac].xmja026) THEN
         CALL s_aooi350_get_address(l_pmaa027,g_xmda2_d[l_ac].xmja026,g_lang)RETURNING r_success,r_address
         LET g_xmda2_d[l_ac].xmja026_desc_1 = r_address
      ELSE
         LET g_xmda2_d[l_ac].xmja026_desc_1 = ''
      END IF
END FUNCTION

################################################################################
# Descriptions...: 清除單身資料
# Memo...........:
# Usage..........: CALL adbq500_qbe_clear()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/03 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION adbq500_qbe_clear()
   CLEAR FORM
   CALL g_xmda_d.clear()
   CALL g_xmda2_d.clear()
   CALL g_xmda3_d.clear()
   CALL g_xmda4_d.clear()
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   INITIALIZE g_wc_filter TO NULL
END FUNCTION

 
{</section>}
 
