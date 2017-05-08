#該程式已解開Section, 不再透過樣板產出!
{<section id="astq811.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-21 13:17:36), PR版次:0001(2016-08-26 18:43:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: astq811
#+ Description: 招商租賃合約費用條款查詢作業
#+ Creator....: 07142(2016-08-21 13:17:36)
#+ Modifier...: 07142 -SD/PR- 07142
 
{</section>}
 
{<section id="astq811.global" >}
#應用 q01 樣板自動產生(Version:30)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_stje_d RECORD
       
       sel LIKE type_t.chr1, 
   stje007 LIKE stje_t.stje007, 
   stje007_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje005 LIKE stje_t.stje005, 
   stje019 LIKE stje_t.stje019, 
   stje019_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_desc LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_desc LIKE type_t.chr500, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   stje022 LIKE stje_t.stje022, 
   stje022_desc LIKE type_t.chr500, 
   stje030 LIKE stje_t.stje030, 
   stje030_desc LIKE type_t.chr500, 
   stje031 LIKE stje_t.stje031, 
   stje031_desc LIKE type_t.chr500, 
   stje045 LIKE stje_t.stje045, 
   stjfseq LIKE stjf_t.stjfseq, 
   stjf002 LIKE stjf_t.stjf002, 
   stjf003 LIKE stjf_t.stjf003, 
   stjf021 LIKE stjf_t.stjf021, 
   stjf004 LIKE stjf_t.stjf004, 
   stjf004_desc LIKE type_t.chr500, 
   stae004 LIKE stae_t.stae004, 
   stjf022 LIKE stjf_t.stjf022, 
   stjf022_desc LIKE type_t.chr500, 
   stjf005 LIKE stjf_t.stjf005, 
   stjf006 LIKE stjf_t.stjf006, 
   stjf007 LIKE stjf_t.stjf007, 
   stjf008 LIKE stjf_t.stjf008, 
   stjf009 LIKE stjf_t.stjf009, 
   stjf010 LIKE stjf_t.stjf010, 
   stjf011 LIKE stjf_t.stjf011, 
   stjf018 LIKE stjf_t.stjf018, 
   stjf012 LIKE stjf_t.stjf012, 
   stjf019 LIKE stjf_t.stjf019, 
   stjf013 LIKE stjf_t.stjf013, 
   stjf014 LIKE stjf_t.stjf014, 
   stjf015 LIKE stjf_t.stjf015, 
   stjf016 LIKE stjf_t.stjf016, 
   stjf017 LIKE stjf_t.stjf017, 
   stjf020 LIKE stjf_t.stjf020, 
   stjf023 LIKE stjf_t.stjf023, 
   stjf024 LIKE stjf_t.stjf024, 
   stjf024_desc LIKE type_t.chr500, 
   stjf025 LIKE stjf_t.stjf025
       END RECORD
PRIVATE TYPE type_g_stje2_d RECORD
       sel_6 LIKE type_t.chr500, 
   stje007 LIKE stje_t.stje007, 
   stje007_1_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_1_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje005 LIKE stje_t.stje005, 
   stje019 LIKE stje_t.stje019, 
   stje019_1_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_1_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_1_desc_1 LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_1_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_1_desc LIKE type_t.chr500, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   stje022 LIKE stje_t.stje022, 
   stje022_1_desc LIKE type_t.chr500, 
   stje030 LIKE stje_t.stje030, 
   stje030_1_desc LIKE type_t.chr500, 
   stje031 LIKE stje_t.stje031, 
   stje031_1_desc LIKE type_t.chr500, 
   stje045 LIKE stje_t.stje045, 
   stjhseq LIKE stjh_t.stjhseq, 
   stjh002 LIKE stjh_t.stjh002, 
   stjh002_desc LIKE type_t.chr500, 
   stae004 LIKE stae_t.stae004, 
   stjh003 LIKE stjh_t.stjh003, 
   stjh008 LIKE stjh_t.stjh008, 
   stjh004 LIKE stjh_t.stjh004, 
   stjh005 LIKE stjh_t.stjh005, 
   stjh006 LIKE stjh_t.stjh006, 
   stjh007 LIKE stjh_t.stjh007
       END RECORD
 
PRIVATE TYPE type_g_stje3_d RECORD
       sel_7 LIKE type_t.chr500, 
   stje007 LIKE stje_t.stje007, 
   stje007_2_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_2_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje005 LIKE stje_t.stje005, 
   stje019 LIKE stje_t.stje019, 
   stje019_2_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_2_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_2_desc LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_2_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_2_desc LIKE type_t.chr500, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   stje022 LIKE stje_t.stje022, 
   stje022_2_desc LIKE type_t.chr500, 
   stje030 LIKE stje_t.stje030, 
   stje030_2_desc LIKE type_t.chr500, 
   stje031 LIKE stje_t.stje031, 
   stje031_2_desc LIKE type_t.chr500, 
   stje045 LIKE stje_t.stje045, 
   stjlseq LIKE stjl_t.stjlseq, 
   stjl002 LIKE stjl_t.stjl002, 
   stjl003 LIKE stjl_t.stjl003, 
   stjl003_desc LIKE type_t.chr500, 
   stjl004 LIKE stjl_t.stjl004, 
   stjl005 LIKE stjl_t.stjl005, 
   stjl006 LIKE stjl_t.stjl006, 
   stjl007 LIKE stjl_t.stjl007, 
   stjl008 LIKE stjl_t.stjl008
       END RECORD
 
PRIVATE TYPE type_g_stje4_d RECORD
       sel_8 LIKE type_t.chr500, 
   stje007 LIKE stje_t.stje007, 
   stje007_3_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_3_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje005 LIKE stje_t.stje005, 
   stje019 LIKE stje_t.stje019, 
   stje019_3_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_3_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_3_desc LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_3_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_3_desc LIKE type_t.chr500, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   stje022 LIKE stje_t.stje022, 
   stje022_3_desc LIKE type_t.chr500, 
   stje030 LIKE stje_t.stje030, 
   stje030_3_desc LIKE type_t.chr500, 
   stje031 LIKE stje_t.stje031, 
   stje031_3_desc LIKE type_t.chr500, 
   stje045 LIKE stje_t.stje045, 
   stjjacti LIKE stjj_t.stjjacti, 
   stjjseq LIKE stjj_t.stjjseq, 
   stjj002 LIKE stjj_t.stjj002, 
   stjj002_desc LIKE type_t.chr500, 
   stjj003 LIKE stjj_t.stjj003, 
   stjj004 LIKE stjj_t.stjj004, 
   stjj005 LIKE stjj_t.stjj005, 
   stjj009 LIKE stjj_t.stjj009
       END RECORD
 
PRIVATE TYPE type_g_stje5_d RECORD
       sel_9 LIKE type_t.chr500, 
   stje007 LIKE stje_t.stje007, 
   stje007_4_desc LIKE type_t.chr500, 
   stje008 LIKE stje_t.stje008, 
   stje008_4_desc LIKE type_t.chr500, 
   stje001 LIKE stje_t.stje001, 
   stje005 LIKE stje_t.stje005, 
   stje019 LIKE stje_t.stje019, 
   stje019_4_desc LIKE type_t.chr500, 
   stje020 LIKE stje_t.stje020, 
   stje020_4_desc LIKE type_t.chr500, 
   stje021 LIKE stje_t.stje021, 
   stje021_4_desc LIKE type_t.chr500, 
   stje029 LIKE stje_t.stje029, 
   stje029_4_desc LIKE type_t.chr500, 
   stje028 LIKE stje_t.stje028, 
   stje028_4_desc LIKE type_t.chr500, 
   stje011 LIKE stje_t.stje011, 
   stje012 LIKE stje_t.stje012, 
   stje022 LIKE stje_t.stje022, 
   stje022_4_desc LIKE type_t.chr500, 
   stje030 LIKE stje_t.stje030, 
   stje030_4_desc LIKE type_t.chr500, 
   stje031 LIKE stje_t.stje031, 
   stje031_4_desc LIKE type_t.chr500, 
   stje045 LIKE stje_t.stje045, 
   stjkacti LIKE stjk_t.stjkacti, 
   stjkseq LIKE stjk_t.stjkseq, 
   stjk002 LIKE stjk_t.stjk002, 
   stjk002_desc LIKE type_t.chr500, 
   stjk004 LIKE stjk_t.stjk004, 
   stjk003 LIKE stjk_t.stjk003, 
   stjk003_desc LIKE type_t.chr500, 
   stjk005 LIKE stjk_t.stjk005
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_stje_d            DYNAMIC ARRAY OF type_g_stje_d
DEFINE g_stje_d_t          type_g_stje_d
DEFINE g_stje2_d     DYNAMIC ARRAY OF type_g_stje2_d
DEFINE g_stje2_d_t   type_g_stje2_d
 
DEFINE g_stje3_d     DYNAMIC ARRAY OF type_g_stje3_d
DEFINE g_stje3_d_t   type_g_stje3_d
 
DEFINE g_stje4_d     DYNAMIC ARRAY OF type_g_stje4_d
DEFINE g_stje4_d_t   type_g_stje4_d
 
DEFINE g_stje5_d     DYNAMIC ARRAY OF type_g_stje5_d
DEFINE g_stje5_d_t   type_g_stje5_d
 
 
 
 
 
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
 
{<section id="astq811.main" >}
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
   DECLARE astq811_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq811_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq811_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq811 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq811_init()   
 
      #進入選單 Menu (="N")
      CALL astq811_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq811
      
   END IF 
   
   CLOSE astq811_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq811.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astq811_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_stje005','6785') 
   CALL cl_set_combo_scc('b_stae004','6004') 
   CALL cl_set_combo_scc('b_stjf007','6920') 
   CALL cl_set_combo_scc('b_stjf009','6910') 
   CALL cl_set_combo_scc('b_stjf010','6904') 
   CALL cl_set_combo_scc('b_stjf013','6010') 
   CALL cl_set_combo_scc('b_stjf016','6011') 
   CALL cl_set_combo_scc('b_stjf023','6932') 
   CALL cl_set_combo_scc('b_stjh008','6915') 
   CALL cl_set_combo_scc('b_stjl002','6848') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL cl_set_combo_scc('stje005','6785') 
   CALL cl_set_combo_scc('b_stje005_1','6785') 
   CALL cl_set_combo_scc('b_stje005_2','6785') 
   CALL cl_set_combo_scc('b_stje005_3','6785') 
   CALL cl_set_combo_scc('b_stje005_4','6785') 
   CALL cl_set_combo_scc('b_stae004_1','6004') 
   #end add-point
 
   CALL astq811_default_search()
END FUNCTION
 
{</section>}
 
{<section id="astq811.default_search" >}
PRIVATE FUNCTION astq811_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stje001 = '", g_argv[01], "' AND "
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
 
{<section id="astq811.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astq811_ui_dialog() 
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
 
   
   CALL astq811_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stje_d.clear()
         CALL g_stje2_d.clear()
 
         CALL g_stje3_d.clear()
 
         CALL g_stje4_d.clear()
 
         CALL g_stje5_d.clear()
 
 
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
 
         CALL astq811_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT g_wc ON stje007,stje008,stje001,stje005,stje019,stje020,stje021,
                   stje029,stje028,stje011,stje012,stje022,stje030,stje031,stje045
         FROM stje007,stje008,stje001,stje005,stje019,stje020,stje021,
                   stje029,stje028,stje011,stje012,stje022,stje030,stje031,stje045
         BEFORE CONSTRUCT
               
           CALL cl_set_act_visible("filter",FALSE)              
                   
               ON ACTION controlp
                  CASE
                     WHEN INFIELD(stje007)
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       LET g_qryparam.arg1 = "('1','3')" 
                       CALL q_pmaa001_1() 
                       DISPLAY g_qryparam.return1 TO stje007
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje008)   #
                        INITIALIZE g_qryparam.* TO NULL
                        LET g_qryparam.state = 'c' 
                        LET g_qryparam.reqry = FALSE
                        CALL q_mhbe001()              
                        DISPLAY g_qryparam.return1 TO stje008 
                        NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje001)   #供应商编号
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       CALL q_stje001()    
                       DISPLAY g_qryparam.return1 TO stje001 
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje019)   #合同编号
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       CALL q_mhaa001()                           #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje019 
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje020)   #业务员
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       CALL q_mhab002()                           #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje020
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje021)   #结算中心
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       CALL q_mhac003()                           #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje021 
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje028)   #单号
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001') #
                       CALL q_rtax001_3()                              #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje028  
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje029)   #专柜管理方式
                        INITIALIZE g_qryparam.* TO NULL
                        LET g_qryparam.state = 'c' 
                        LET g_qryparam.reqry = FALSE
                        CALL q_oocq002_2002()                           #呼叫開窗
                        DISPLAY g_qryparam.return1 TO stje029
                        NEXT FIELD CURRENT
                        
                     WHEN INFIELD(stje030) 
                         INITIALIZE g_qryparam.* TO NULL
                         LET g_qryparam.state = 'c' 
                         LET g_qryparam.reqry = FALSE
                         CALL q_ooef001_23()       
                         DISPLAY g_qryparam.return1 TO stje030 
                    
                     WHEN INFIELD(stje031)
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       CALL q_staa001()                           #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje031 
                       NEXT FIELD CURRENT
                       
                     WHEN INFIELD(stje022)
                       INITIALIZE g_qryparam.* TO NULL
                       LET g_qryparam.state = 'c' 
                       LET g_qryparam.reqry = FALSE
                       LET g_qryparam.arg1 = '2144'
                       CALL q_oocq002()                           #呼叫開窗
                       DISPLAY g_qryparam.return1 TO stje022 
                       NEXT FIELD CURRENT
		   	   
                END CASE
         END CONSTRUCT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"

         #end add-point
     
         DISPLAY ARRAY g_stje_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               LET g_detail_cnt = g_stje_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               CALL astq811_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq811_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               #LET g_detail_cnt = g_stje_d.getLength()
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_stje2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               LET g_detail_cnt = g_stje2_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               #add-point:input段before row name="input.body2.before_row"
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               
               #LET g_detail_cnt = g_stje2_d.getLength()
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_stje3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               LET g_detail_cnt = g_stje3_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
 
               #add-point:input段before row name="input.body3.before_row"
               #LET g_detail_cnt = g_stje3_d.getLength()
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_stje4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 4
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               LET g_detail_cnt = g_stje4_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
 
               #add-point:input段before row name="input.body4.before_row"
               #LET g_detail_cnt = g_stje4_d.getLength()
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               #end add-point
 
            #自訂ACTION(detail_show,page_4)
            
 
            #add-point:page4自定義行為 name="ui_dialog.body4.action"

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_stje5_d TO s_detail5.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 5
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               LET g_detail_cnt = g_stje5_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               #add-point:input段before row name="input.body5.before_row"
               #LET g_detail_cnt = g_stje5_d.getLength()
               DISPLAY g_detail_idx2 TO FORMONLY.h_index
               #end add-point
 
            #自訂ACTION(detail_show,page_5)
            
 
            #add-point:page5自定義行為 name="ui_dialog.body5.action"

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq811_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"

            #end add-point
            NEXT FIELD stje007
 
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
            call astq811_cre_tmp()
            call astq811_b_fill_1()
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            #CALL astq811_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
            LET g_detail_cnt = g_stje_d.getLength()
            DISPLAY g_detail_cnt TO FORMONLY.h_count
            DISPLAY ' ' TO FORMONLY.h_index
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stje_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_stje2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_stje3_d)
               LET g_export_id[3]   = "s_detail3"
 
               LET g_export_node[4] = base.typeInfo.create(g_stje4_d)
               LET g_export_id[4]   = "s_detail4"
 
               LET g_export_node[5] = base.typeInfo.create(g_stje5_d)
               LET g_export_id[5]   = "s_detail5"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL astq811_b_fill()
 
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
            CALL astq811_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq811_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq811_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq811_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_stje_d.getLength()
               LET g_stje_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_stje_d.getLength()
               LET g_stje_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_stje_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stje_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_stje_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stje_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"

            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astq811_filter()
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
 
{<section id="astq811.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq811_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_stje_d.clear()
   CALL g_stje2_d.clear()
 
   CALL g_stje3_d.clear()
 
   CALL g_stje4_d.clear()
 
   CALL g_stje5_d.clear()
 
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',stje007,'',stje008,'',stje001,stje005,stje019,'',stje020,'', 
       stje021,'',stje029,'',stje028,'',stje011,stje012,stje022,'',stje030,'',stje031,'',stje045,'', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY stje_t.stje001) AS RANK FROM stje_t", 
 
 
 
                     " LEFT JOIN stjh_t ON stje001 = stjhseq AND  LEFT JOIN stjl_t ON stje001 = stjlseq AND  LEFT JOIN stjj_t ON stje001 = stjjseq AND  LEFT JOIN stjk_t ON stje001 = stjkseq AND",
                     " WHERE stjeent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stje_t"),
                     " ORDER BY stje_t.stje001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank="SELECT  UNIQUE 'Y' " 
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
 
   LET g_sql = "SELECT '',stje007,'',stje008,'',stje001,stje005,stje019,'',stje020,'',stje021,'',stje029, 
       '',stje028,'',stje011,stje012,stje022,'',stje030,'',stje031,'',stje045,'','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq811_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq811_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_stje_d[l_ac].sel,g_stje_d[l_ac].stje007,g_stje_d[l_ac].stje007_desc,g_stje_d[l_ac].stje008, 
       g_stje_d[l_ac].stje008_desc,g_stje_d[l_ac].stje001,g_stje_d[l_ac].stje005,g_stje_d[l_ac].stje019, 
       g_stje_d[l_ac].stje019_desc,g_stje_d[l_ac].stje020,g_stje_d[l_ac].stje020_desc,g_stje_d[l_ac].stje021, 
       g_stje_d[l_ac].stje021_desc,g_stje_d[l_ac].stje029,g_stje_d[l_ac].stje029_desc,g_stje_d[l_ac].stje028, 
       g_stje_d[l_ac].stje028_desc,g_stje_d[l_ac].stje011,g_stje_d[l_ac].stje012,g_stje_d[l_ac].stje022, 
       g_stje_d[l_ac].stje022_desc,g_stje_d[l_ac].stje030,g_stje_d[l_ac].stje030_desc,g_stje_d[l_ac].stje031, 
       g_stje_d[l_ac].stje031_desc,g_stje_d[l_ac].stje045,g_stje_d[l_ac].stjfseq,g_stje_d[l_ac].stjf002, 
       g_stje_d[l_ac].stjf003,g_stje_d[l_ac].stjf021,g_stje_d[l_ac].stjf004,g_stje_d[l_ac].stjf004_desc, 
       g_stje_d[l_ac].stae004,g_stje_d[l_ac].stjf022,g_stje_d[l_ac].stjf022_desc,g_stje_d[l_ac].stjf005, 
       g_stje_d[l_ac].stjf006,g_stje_d[l_ac].stjf007,g_stje_d[l_ac].stjf008,g_stje_d[l_ac].stjf009,g_stje_d[l_ac].stjf010, 
       g_stje_d[l_ac].stjf011,g_stje_d[l_ac].stjf018,g_stje_d[l_ac].stjf012,g_stje_d[l_ac].stjf019,g_stje_d[l_ac].stjf013, 
       g_stje_d[l_ac].stjf014,g_stje_d[l_ac].stjf015,g_stje_d[l_ac].stjf016,g_stje_d[l_ac].stjf017,g_stje_d[l_ac].stjf020, 
       g_stje_d[l_ac].stjf023,g_stje_d[l_ac].stjf024,g_stje_d[l_ac].stjf024_desc,g_stje_d[l_ac].stjf025, 
       g_stje2_d[l_ac].sel_6,g_stje2_d[l_ac].stje007,g_stje2_d[l_ac].stje007_1_desc,g_stje2_d[l_ac].stje008, 
       g_stje2_d[l_ac].stje008_1_desc,g_stje2_d[l_ac].stje001,g_stje2_d[l_ac].stje005,g_stje2_d[l_ac].stje019, 
       g_stje2_d[l_ac].stje019_1_desc,g_stje2_d[l_ac].stje020,g_stje2_d[l_ac].stje020_1_desc,g_stje2_d[l_ac].stje021, 
       g_stje2_d[l_ac].stje021_1_desc_1,g_stje2_d[l_ac].stje029,g_stje2_d[l_ac].stje029_1_desc,g_stje2_d[l_ac].stje028, 
       g_stje2_d[l_ac].stje028_1_desc,g_stje2_d[l_ac].stje011,g_stje2_d[l_ac].stje012,g_stje2_d[l_ac].stje022, 
       g_stje2_d[l_ac].stje022_1_desc,g_stje2_d[l_ac].stje030,g_stje2_d[l_ac].stje030_1_desc,g_stje2_d[l_ac].stje031, 
       g_stje2_d[l_ac].stje031_1_desc,g_stje2_d[l_ac].stje045,g_stje2_d[l_ac].stjhseq,g_stje2_d[l_ac].stjh002, 
       g_stje2_d[l_ac].stjh002_desc,g_stje2_d[l_ac].stae004,g_stje2_d[l_ac].stjh003,g_stje2_d[l_ac].stjh008, 
       g_stje2_d[l_ac].stjh004,g_stje2_d[l_ac].stjh005,g_stje2_d[l_ac].stjh006,g_stje2_d[l_ac].stjh007, 
       g_stje3_d[l_ac].sel_7,g_stje3_d[l_ac].stje007,g_stje3_d[l_ac].stje007_2_desc,g_stje3_d[l_ac].stje008, 
       g_stje3_d[l_ac].stje008_2_desc,g_stje3_d[l_ac].stje001,g_stje3_d[l_ac].stje005,g_stje3_d[l_ac].stje019, 
       g_stje3_d[l_ac].stje019_2_desc,g_stje3_d[l_ac].stje020,g_stje3_d[l_ac].stje020_2_desc,g_stje3_d[l_ac].stje021, 
       g_stje3_d[l_ac].stje021_2_desc,g_stje3_d[l_ac].stje029,g_stje3_d[l_ac].stje029_2_desc,g_stje3_d[l_ac].stje028, 
       g_stje3_d[l_ac].stje028_2_desc,g_stje3_d[l_ac].stje011,g_stje3_d[l_ac].stje012,g_stje3_d[l_ac].stje022, 
       g_stje3_d[l_ac].stje022_2_desc,g_stje3_d[l_ac].stje030,g_stje3_d[l_ac].stje030_2_desc,g_stje3_d[l_ac].stje031, 
       g_stje3_d[l_ac].stje031_2_desc,g_stje3_d[l_ac].stje045,g_stje3_d[l_ac].stjlseq,g_stje3_d[l_ac].stjl002, 
       g_stje3_d[l_ac].stjl003,g_stje3_d[l_ac].stjl003_desc,g_stje3_d[l_ac].stjl004,g_stje3_d[l_ac].stjl005, 
       g_stje3_d[l_ac].stjl006,g_stje3_d[l_ac].stjl007,g_stje3_d[l_ac].stjl008,g_stje4_d[l_ac].sel_8, 
       g_stje4_d[l_ac].stje007,g_stje4_d[l_ac].stje007_3_desc,g_stje4_d[l_ac].stje008,g_stje4_d[l_ac].stje008_3_desc, 
       g_stje4_d[l_ac].stje001,g_stje4_d[l_ac].stje005,g_stje4_d[l_ac].stje019,g_stje4_d[l_ac].stje019_3_desc, 
       g_stje4_d[l_ac].stje020,g_stje4_d[l_ac].stje020_3_desc,g_stje4_d[l_ac].stje021,g_stje4_d[l_ac].stje021_3_desc, 
       g_stje4_d[l_ac].stje029,g_stje4_d[l_ac].stje029_3_desc,g_stje4_d[l_ac].stje028,g_stje4_d[l_ac].stje028_3_desc, 
       g_stje4_d[l_ac].stje011,g_stje4_d[l_ac].stje012,g_stje4_d[l_ac].stje022,g_stje4_d[l_ac].stje022_3_desc, 
       g_stje4_d[l_ac].stje030,g_stje4_d[l_ac].stje030_3_desc,g_stje4_d[l_ac].stje031,g_stje4_d[l_ac].stje031_3_desc, 
       g_stje4_d[l_ac].stje045,g_stje4_d[l_ac].stjjacti,g_stje4_d[l_ac].stjjseq,g_stje4_d[l_ac].stjj002, 
       g_stje4_d[l_ac].stjj002_desc,g_stje4_d[l_ac].stjj003,g_stje4_d[l_ac].stjj004,g_stje4_d[l_ac].stjj005, 
       g_stje4_d[l_ac].stjj009,g_stje5_d[l_ac].sel_9,g_stje5_d[l_ac].stje007,g_stje5_d[l_ac].stje007_4_desc, 
       g_stje5_d[l_ac].stje008,g_stje5_d[l_ac].stje008_4_desc,g_stje5_d[l_ac].stje001,g_stje5_d[l_ac].stje005, 
       g_stje5_d[l_ac].stje019,g_stje5_d[l_ac].stje019_4_desc,g_stje5_d[l_ac].stje020,g_stje5_d[l_ac].stje020_4_desc, 
       g_stje5_d[l_ac].stje021,g_stje5_d[l_ac].stje021_4_desc,g_stje5_d[l_ac].stje029,g_stje5_d[l_ac].stje029_4_desc, 
       g_stje5_d[l_ac].stje028,g_stje5_d[l_ac].stje028_4_desc,g_stje5_d[l_ac].stje011,g_stje5_d[l_ac].stje012, 
       g_stje5_d[l_ac].stje022,g_stje5_d[l_ac].stje022_4_desc,g_stje5_d[l_ac].stje030,g_stje5_d[l_ac].stje030_4_desc, 
       g_stje5_d[l_ac].stje031,g_stje5_d[l_ac].stje031_4_desc,g_stje5_d[l_ac].stje045,g_stje5_d[l_ac].stjkacti, 
       g_stje5_d[l_ac].stjkseq,g_stje5_d[l_ac].stjk002,g_stje5_d[l_ac].stjk002_desc,g_stje5_d[l_ac].stjk004, 
       g_stje5_d[l_ac].stjk003,g_stje5_d[l_ac].stjk003_desc,g_stje5_d[l_ac].stjk005
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
 
      CALL astq811_detail_show("'1'")
 
      CALL astq811_stje_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:3)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   CALL g_stje_d.deleteElement(g_stje_d.getLength())
   CALL g_stje2_d.deleteElement(g_stje2_d.getLength())
 
   CALL g_stje3_d.deleteElement(g_stje3_d.getLength())
 
   CALL g_stje4_d.deleteElement(g_stje4_d.getLength())
 
   CALL g_stje5_d.deleteElement(g_stje5_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_stje_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE astq811_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq811_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq811_detail_action_trans()
 
   LET l_ac = 1
   IF g_stje_d.getLength() > 0 THEN
      CALL astq811_b_fill2()
   END IF
 
      CALL astq811_filter_show('stje007','b_stje007')
   CALL astq811_filter_show('stje008','b_stje008')
   CALL astq811_filter_show('stje001','b_stje001')
   CALL astq811_filter_show('stje005','b_stje005')
   CALL astq811_filter_show('stje019','b_stje019')
   CALL astq811_filter_show('stje020','b_stje020')
   CALL astq811_filter_show('stje021','b_stje021')
   CALL astq811_filter_show('stje029','b_stje029')
   CALL astq811_filter_show('stje028','b_stje028')
   CALL astq811_filter_show('stje011','b_stje011')
   CALL astq811_filter_show('stje012','b_stje012')
   CALL astq811_filter_show('stje022','b_stje022')
   CALL astq811_filter_show('stje030','b_stje030')
   CALL astq811_filter_show('stje031','b_stje031')
   CALL astq811_filter_show('stje045','b_stje045')
   CALL astq811_filter_show('stjfseq','b_stjfseq')
   CALL astq811_filter_show('stjf002','b_stjf002')
   CALL astq811_filter_show('stjf003','b_stjf003')
   CALL astq811_filter_show('stjf021','b_stjf021')
   CALL astq811_filter_show('stjf004','b_stjf004')
   CALL astq811_filter_show('stae004','b_stae004')
   CALL astq811_filter_show('stjf022','b_stjf022')
   CALL astq811_filter_show('stjf005','b_stjf005')
   CALL astq811_filter_show('stjf006','b_stjf006')
   CALL astq811_filter_show('stjf007','b_stjf007')
   CALL astq811_filter_show('stjf008','b_stjf008')
   CALL astq811_filter_show('stjf009','b_stjf009')
   CALL astq811_filter_show('stjf010','b_stjf010')
   CALL astq811_filter_show('stjf011','b_stjf011')
   CALL astq811_filter_show('stjf018','b_stjf018')
   CALL astq811_filter_show('stjf012','b_stjf012')
   CALL astq811_filter_show('stjf019','b_stjf019')
   CALL astq811_filter_show('stjf013','b_stjf013')
   CALL astq811_filter_show('stjf014','b_stjf014')
   CALL astq811_filter_show('stjf015','b_stjf015')
   CALL astq811_filter_show('stjf016','b_stjf016')
   CALL astq811_filter_show('stjf017','b_stjf017')
   CALL astq811_filter_show('stjf020','b_stjf020')
   CALL astq811_filter_show('stjf023','b_stjf023')
   CALL astq811_filter_show('stjf024','b_stjf024')
   CALL astq811_filter_show('stjf025','b_stjf025')
   CALL astq811_filter_show('stjhseq','b_stjhseq')
   CALL astq811_filter_show('stjh002','b_stjh002')
   CALL astq811_filter_show('stjh003','b_stjh003')
   CALL astq811_filter_show('stjh008','b_stjh008')
   CALL astq811_filter_show('stjh004','b_stjh004')
   CALL astq811_filter_show('stjh005','b_stjh005')
   CALL astq811_filter_show('stjh006','b_stjh006')
   CALL astq811_filter_show('stjh007','b_stjh007')
   CALL astq811_filter_show('stjlseq','b_stjlseq')
   CALL astq811_filter_show('stjl002','b_stjl002')
   CALL astq811_filter_show('stjl003','b_stjl003')
   CALL astq811_filter_show('stjl004','b_stjl004')
   CALL astq811_filter_show('stjl005','b_stjl005')
   CALL astq811_filter_show('stjl006','b_stjl006')
   CALL astq811_filter_show('stjl007','b_stjl007')
   CALL astq811_filter_show('stjl008','b_stjl008')
   CALL astq811_filter_show('stjjacti','b_stjjacti')
   CALL astq811_filter_show('stjjseq','b_stjjseq')
   CALL astq811_filter_show('stjj002','b_stjj002')
   CALL astq811_filter_show('stjj003','b_stjj003')
   CALL astq811_filter_show('stjj004','b_stjj004')
   CALL astq811_filter_show('stjj005','b_stjj005')
   CALL astq811_filter_show('stjj009','b_stjj009')
   CALL astq811_filter_show('stjkacti','b_stjkacti')
   CALL astq811_filter_show('stjkseq','b_stjkseq')
   CALL astq811_filter_show('stjk002','b_stjk002')
   CALL astq811_filter_show('stjk004','b_stjk004')
   CALL astq811_filter_show('stjk003','b_stjk003')
   CALL astq811_filter_show('stjk005','b_stjk005')
 
 
END FUNCTION
 
{</section>}
 
{<section id="astq811.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq811_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:6)
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
 
{<section id="astq811.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq811_detail_show(ps_page)
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje007
#            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje008
#            LET ls_sql = "SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=? AND mhbel002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje019
#            LET g_ref_fields[2] = g_stje_d[l_ac].stje020
#            LET ls_sql = "SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje020_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje020_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje019
#            LET g_ref_fields[2] = g_stje_d[l_ac].stje020
#            LET g_ref_fields[3] = g_stje_d[l_ac].stje021
#            LET ls_sql = "SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND mhacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje021_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje021_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje029
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje029_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje029_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stje028
#            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stje028_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stje028_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stjf004
#            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stjf004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stjf004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stjf022
#            LET ls_sql = "SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl004=? AND mhadl005='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stjf022_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stjf022_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje_d[l_ac].stjf024
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje_d[l_ac].stjf024_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje_d[l_ac].stjf024_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje2_d[l_ac].stjh002
#            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje2_d[l_ac].stjh002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje2_d[l_ac].stjh002_desc
#
#   INITIALIZE g_ref_fields TO NULL 
#   #LET g_ref_fields[1] = .stje001
#   LET ls_sql = " SELECT stjhseq,stjh002,stjh003,stjh008,stjh004,stjh005,stjh006,stjh007 FROM stjh_t WHERE stjhent = '"||g_enterprise||"' AND stjhseq = ? AND stjh001 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
#   LET g_stje2_d[l_ac].stjhseq = g_rtn_fields[1] 
#   LET g_stje2_d[l_ac].stjh002 = g_rtn_fields[2] 
#   LET g_stje2_d[l_ac].stjh003 = g_rtn_fields[3] 
#   LET g_stje2_d[l_ac].stjh008 = g_rtn_fields[4] 
#   LET g_stje2_d[l_ac].stjh004 = g_rtn_fields[5] 
#   LET g_stje2_d[l_ac].stjh005 = g_rtn_fields[6] 
#   LET g_stje2_d[l_ac].stjh006 = g_rtn_fields[7] 
#   LET g_stje2_d[l_ac].stjh007 = g_rtn_fields[8] 
  # DISPLAY BY NAME g_stje2_d[l_ac].stjhseq,g_stje2_d[l_ac].stjh002,g_stje2_d[l_ac].stjh003,g_stje2_d[l_ac].stjh008,g_stje2_d[l_ac].stjh004,g_stje2_d[l_ac].stjh005,g_stje2_d[l_ac].stjh006,g_stje2_d[l_ac].stjh007
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje3_d[l_ac].stjl003
#            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje3_d[l_ac].stjl003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje3_d[l_ac].stjl003_desc
#
#   INITIALIZE g_ref_fields TO NULL 
#   #LET g_ref_fields[1] = .stje001
#   LET ls_sql = " SELECT stjhseq,stjh002,stjh003,stjh008,stjh004,stjh005,stjh006,stjh007,stjlseq,stjl002,stjl003,stjl004,stjl005,stjl006,stjl007,stjl008 FROM stjl_t WHERE stjlent = '"||g_enterprise||"' AND stjlseq = ? AND stjl001 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
#   LET g_stje2_d[l_ac].stjhseq = g_rtn_fields[1] 
#   LET g_stje2_d[l_ac].stjh002 = g_rtn_fields[2] 
#   LET g_stje2_d[l_ac].stjh003 = g_rtn_fields[3] 
#   LET g_stje2_d[l_ac].stjh008 = g_rtn_fields[4] 
#   LET g_stje2_d[l_ac].stjh004 = g_rtn_fields[5] 
#   LET g_stje2_d[l_ac].stjh005 = g_rtn_fields[6] 
#   LET g_stje2_d[l_ac].stjh006 = g_rtn_fields[7] 
#   LET g_stje2_d[l_ac].stjh007 = g_rtn_fields[8] 
#   LET g_stje3_d[l_ac].stjlseq = g_rtn_fields[9] 
#   LET g_stje3_d[l_ac].stjl002 = g_rtn_fields[10] 
#   LET g_stje3_d[l_ac].stjl003 = g_rtn_fields[11] 
#   LET g_stje3_d[l_ac].stjl004 = g_rtn_fields[12] 
#   LET g_stje3_d[l_ac].stjl005 = g_rtn_fields[13] 
#   LET g_stje3_d[l_ac].stjl006 = g_rtn_fields[14] 
#   LET g_stje3_d[l_ac].stjl007 = g_rtn_fields[15] 
#   LET g_stje3_d[l_ac].stjl008 = g_rtn_fields[16] 
#   DISPLAY BY NAME g_stje2_d[l_ac].stjhseq,g_stje2_d[l_ac].stjh002,g_stje2_d[l_ac].stjh003,g_stje2_d[l_ac].stjh008,g_stje2_d[l_ac].stjh004,g_stje2_d[l_ac].stjh005,g_stje2_d[l_ac].stjh006,g_stje2_d[l_ac].stjh007,g_stje3_d[l_ac].stjlseq,g_stje3_d[l_ac].stjl002,g_stje3_d[l_ac].stjl003,g_stje3_d[l_ac].stjl004,g_stje3_d[l_ac].stjl005,g_stje3_d[l_ac].stjl006,g_stje3_d[l_ac].stjl007,g_stje3_d[l_ac].stjl008
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'4'",1) > 0 THEN
      #帶出公用欄位reference值page4
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje4_d[l_ac].stjj006
#            LET g_ref_fields[2] = g_stje4_d[l_ac].stjj007
#            LET g_ref_fields[3] = g_stje4_d[l_ac].stjj008
#            LET g_ref_fields[4] = g_stje4_d[l_ac].stjj002
#            LET ls_sql = "SELECT mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl001=? AND mhadl002=? AND mhadl003=? AND mhadl004=? AND mhadl005='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje4_d[l_ac].stjj002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje4_d[l_ac].stjj002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje4_d[l_ac].stjj006
#            LET ls_sql = "SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=? AND mhaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje4_d[l_ac].stjj006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje4_d[l_ac].stjj006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje4_d[l_ac].stjj006
#            LET g_ref_fields[2] = g_stje4_d[l_ac].stjj007
#            LET ls_sql = "SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=? AND mhabl002=? AND mhabl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje4_d[l_ac].stjj007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje4_d[l_ac].stjj007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje4_d[l_ac].stjj006
#            LET g_ref_fields[2] = g_stje4_d[l_ac].stjj007
#            LET g_ref_fields[3] = g_stje4_d[l_ac].stjj008
#            LET ls_sql = "SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=? AND hacl002=? AND mhacl003=? AND mhacl004='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje4_d[l_ac].stjj008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje4_d[l_ac].stjj008_desc
#
#   INITIALIZE g_ref_fields TO NULL 
#   #LET g_ref_fields[1] = .stje001
#   LET ls_sql = " SELECT stjhseq,stjh002,stjh003,stjh008,stjh004,stjh005,stjh006,stjh007,stjlseq,stjl002,stjl003,stjl004,stjl005,stjl006,stjl007,stjl008,stjjacti,stjjseq,stjj002,stjj003,stjj004,stjj005,stjj006,stjj007,stjj008,stjj009 FROM stjj_t WHERE stjjent = '"||g_enterprise||"' AND stjjseq = ? AND stjj001 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
#   LET g_stje2_d[l_ac].stjhseq = g_rtn_fields[1] 
#   LET g_stje2_d[l_ac].stjh002 = g_rtn_fields[2] 
#   LET g_stje2_d[l_ac].stjh003 = g_rtn_fields[3] 
#   LET g_stje2_d[l_ac].stjh008 = g_rtn_fields[4] 
#   LET g_stje2_d[l_ac].stjh004 = g_rtn_fields[5] 
#   LET g_stje2_d[l_ac].stjh005 = g_rtn_fields[6] 
#   LET g_stje2_d[l_ac].stjh006 = g_rtn_fields[7] 
#   LET g_stje2_d[l_ac].stjh007 = g_rtn_fields[8] 
#   LET g_stje3_d[l_ac].stjlseq = g_rtn_fields[9] 
#   LET g_stje3_d[l_ac].stjl002 = g_rtn_fields[10] 
#   LET g_stje3_d[l_ac].stjl003 = g_rtn_fields[11] 
#   LET g_stje3_d[l_ac].stjl004 = g_rtn_fields[12] 
#   LET g_stje3_d[l_ac].stjl005 = g_rtn_fields[13] 
#   LET g_stje3_d[l_ac].stjl006 = g_rtn_fields[14] 
#   LET g_stje3_d[l_ac].stjl007 = g_rtn_fields[15] 
#   LET g_stje3_d[l_ac].stjl008 = g_rtn_fields[16] 
#   LET g_stje4_d[l_ac].stjjacti = g_rtn_fields[17] 
#   LET g_stje4_d[l_ac].stjjseq = g_rtn_fields[18] 
#   LET g_stje4_d[l_ac].stjj002 = g_rtn_fields[19] 
#   LET g_stje4_d[l_ac].stjj003 = g_rtn_fields[20] 
#   LET g_stje4_d[l_ac].stjj004 = g_rtn_fields[21] 
#   LET g_stje4_d[l_ac].stjj005 = g_rtn_fields[22] 
#   LET g_stje4_d[l_ac].stjj006 = g_rtn_fields[23] 
#   LET g_stje4_d[l_ac].stjj007 = g_rtn_fields[24] 
#   LET g_stje4_d[l_ac].stjj008 = g_rtn_fields[25] 
#   LET g_stje4_d[l_ac].stjj009 = g_rtn_fields[26] 
#   DISPLAY BY NAME g_stje2_d[l_ac].stjhseq,g_stje2_d[l_ac].stjh002,g_stje2_d[l_ac].stjh003,g_stje2_d[l_ac].stjh008,g_stje2_d[l_ac].stjh004,g_stje2_d[l_ac].stjh005,g_stje2_d[l_ac].stjh006,g_stje2_d[l_ac].stjh007,g_stje3_d[l_ac].stjlseq,g_stje3_d[l_ac].stjl002,g_stje3_d[l_ac].stjl003,g_stje3_d[l_ac].stjl004,g_stje3_d[l_ac].stjl005,g_stje3_d[l_ac].stjl006,g_stje3_d[l_ac].stjl007,g_stje3_d[l_ac].stjl008,g_stje4_d[l_ac].stjjacti,g_stje4_d[l_ac].stjjseq,g_stje4_d[l_ac].stjj002,g_stje4_d[l_ac].stjj003,g_stje4_d[l_ac].stjj004,g_stje4_d[l_ac].stjj005,g_stje4_d[l_ac].stjj006,g_stje4_d[l_ac].stjj007,g_stje4_d[l_ac].stjj008,g_stje4_d[l_ac].stjj009
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'5'",1) > 0 THEN
      #帶出公用欄位reference值page5
      
 
      #add-point:show段單身reference name="detail_show.body5.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stje5_d[l_ac].stjk002
#            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stje5_d[l_ac].stjk002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stje5_d[l_ac].stjk002_desc
#
#   INITIALIZE g_ref_fields TO NULL 
#   #LET g_ref_fields[1] = .stje001
#   LET ls_sql = " SELECT stjhseq,stjh002,stjh003,stjh008,stjh004,stjh005,stjh006,stjh007,stjlseq,stjl002,stjl003,stjl004,stjl005,stjl006,stjl007,stjl008,stjjacti,stjjseq,stjj002,stjj003,stjj004,stjj005,stjj006,stjj007,stjj008,stjj009,stjkacti,stjkseq,stjk002,stjk004,stjk003,stjk005 FROM stjk_t WHERE stjkent = '"||g_enterprise||"' AND stjkseq = ? AND stjk001 = ? "
#   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields 
#   LET g_stje2_d[l_ac].stjhseq = g_rtn_fields[1] 
#   LET g_stje2_d[l_ac].stjh002 = g_rtn_fields[2] 
#   LET g_stje2_d[l_ac].stjh003 = g_rtn_fields[3] 
#   LET g_stje2_d[l_ac].stjh008 = g_rtn_fields[4] 
#   LET g_stje2_d[l_ac].stjh004 = g_rtn_fields[5] 
#   LET g_stje2_d[l_ac].stjh005 = g_rtn_fields[6] 
#   LET g_stje2_d[l_ac].stjh006 = g_rtn_fields[7] 
#   LET g_stje2_d[l_ac].stjh007 = g_rtn_fields[8] 
#   LET g_stje3_d[l_ac].stjlseq = g_rtn_fields[9] 
#   LET g_stje3_d[l_ac].stjl002 = g_rtn_fields[10] 
#   LET g_stje3_d[l_ac].stjl003 = g_rtn_fields[11] 
#   LET g_stje3_d[l_ac].stjl004 = g_rtn_fields[12] 
#   LET g_stje3_d[l_ac].stjl005 = g_rtn_fields[13] 
#   LET g_stje3_d[l_ac].stjl006 = g_rtn_fields[14] 
#   LET g_stje3_d[l_ac].stjl007 = g_rtn_fields[15] 
#   LET g_stje3_d[l_ac].stjl008 = g_rtn_fields[16] 
#   LET g_stje4_d[l_ac].stjjacti = g_rtn_fields[17] 
#   LET g_stje4_d[l_ac].stjjseq = g_rtn_fields[18] 
#   LET g_stje4_d[l_ac].stjj002 = g_rtn_fields[19] 
#   LET g_stje4_d[l_ac].stjj003 = g_rtn_fields[20] 
#   LET g_stje4_d[l_ac].stjj004 = g_rtn_fields[21] 
#   LET g_stje4_d[l_ac].stjj005 = g_rtn_fields[22] 
#   LET g_stje4_d[l_ac].stjj006 = g_rtn_fields[23] 
#   LET g_stje4_d[l_ac].stjj007 = g_rtn_fields[24] 
#   LET g_stje4_d[l_ac].stjj008 = g_rtn_fields[25] 
#   LET g_stje4_d[l_ac].stjj009 = g_rtn_fields[26] 
#   LET g_stje5_d[l_ac].stjkacti = g_rtn_fields[27] 
#   LET g_stje5_d[l_ac].stjkseq = g_rtn_fields[28] 
#   LET g_stje5_d[l_ac].stjk002 = g_rtn_fields[29] 
#   LET g_stje5_d[l_ac].stjk004 = g_rtn_fields[30] 
#   LET g_stje5_d[l_ac].stjk003 = g_rtn_fields[31] 
#   LET g_stje5_d[l_ac].stjk005 = g_rtn_fields[32] 
#   DISPLAY BY NAME g_stje2_d[l_ac].stjhseq,g_stje2_d[l_ac].stjh002,g_stje2_d[l_ac].stjh003,g_stje2_d[l_ac].stjh008,g_stje2_d[l_ac].stjh004,g_stje2_d[l_ac].stjh005,g_stje2_d[l_ac].stjh006,g_stje2_d[l_ac].stjh007,g_stje3_d[l_ac].stjlseq,g_stje3_d[l_ac].stjl002,g_stje3_d[l_ac].stjl003,g_stje3_d[l_ac].stjl004,g_stje3_d[l_ac].stjl005,g_stje3_d[l_ac].stjl006,g_stje3_d[l_ac].stjl007,g_stje3_d[l_ac].stjl008,g_stje4_d[l_ac].stjjacti,g_stje4_d[l_ac].stjjseq,g_stje4_d[l_ac].stjj002,g_stje4_d[l_ac].stjj003,g_stje4_d[l_ac].stjj004,g_stje4_d[l_ac].stjj005,g_stje4_d[l_ac].stjj006,g_stje4_d[l_ac].stjj007,g_stje4_d[l_ac].stjj008,g_stje4_d[l_ac].stjj009,g_stje5_d[l_ac].stjkacti,g_stje5_d[l_ac].stjkseq,g_stje5_d[l_ac].stjk002,g_stje5_d[l_ac].stjk004,g_stje5_d[l_ac].stjk003,g_stje5_d[l_ac].stjk005
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq811.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION astq811_filter()
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
      CONSTRUCT g_wc_filter ON stje007,stje008,stje001,stje005,stje019,stje020,stje021,stje029,stje028, 
          stje011,stje012,stje022,stje030,stje031,stje045,stjfseq,stjf002,stjf003,stjf021,stjf004,stae004, 
          stjf022,stjf005,stjf006,stjf007,stjf008,stjf009,stjf010,stjf011,stjf018,stjf012,stjf019,stjf013, 
          stjf014,stjf015,stjf016,stjf017,stjf020,stjf023,stjf024,stjf025,stjhseq,stjh002,stjh003,stjh008, 
          stjh004,stjh005,stjh006,stjh007,stjlseq,stjl002,stjl003,stjl004,stjl005,stjl006,stjl007,stjl008, 
          stjjacti,stjjseq,stjj002,stjj003,stjj004,stjj005,stjj009,stjkacti,stjkseq,stjk002,stjk004, 
          stjk003,stjk005
                          FROM s_detail1[1].b_stje007,s_detail1[1].b_stje008,s_detail1[1].b_stje001, 
                              s_detail1[1].b_stje005,s_detail1[1].b_stje019,s_detail1[1].b_stje020,s_detail1[1].b_stje021, 
                              s_detail1[1].b_stje029,s_detail1[1].b_stje028,s_detail1[1].b_stje011,s_detail1[1].b_stje012, 
                              s_detail1[1].b_stje022,s_detail1[1].b_stje030,s_detail1[1].b_stje031,s_detail1[1].b_stje045, 
                              s_detail1[1].b_stjfseq,s_detail1[1].b_stjf002,s_detail1[1].b_stjf003,s_detail1[1].b_stjf021, 
                              s_detail1[1].b_stjf004,s_detail1[1].b_stae004,s_detail1[1].b_stjf022,s_detail1[1].b_stjf005, 
                              s_detail1[1].b_stjf006,s_detail1[1].b_stjf007,s_detail1[1].b_stjf008,s_detail1[1].b_stjf009, 
                              s_detail1[1].b_stjf010,s_detail1[1].b_stjf011,s_detail1[1].b_stjf018,s_detail1[1].b_stjf012, 
                              s_detail1[1].b_stjf019,s_detail1[1].b_stjf013,s_detail1[1].b_stjf014,s_detail1[1].b_stjf015, 
                              s_detail1[1].b_stjf016,s_detail1[1].b_stjf017,s_detail1[1].b_stjf020,s_detail1[1].b_stjf023, 
                              s_detail1[1].b_stjf024,s_detail1[1].b_stjf025,s_detail2[1].b_stjhseq,s_detail2[1].b_stjh002, 
                              s_detail2[1].b_stjh003,s_detail2[1].b_stjh008,s_detail2[1].b_stjh004,s_detail2[1].b_stjh005, 
                              s_detail2[1].b_stjh006,s_detail2[1].b_stjh007,s_detail3[1].b_stjlseq,s_detail3[1].b_stjl002, 
                              s_detail3[1].b_stjl003,s_detail3[1].b_stjl004,s_detail3[1].b_stjl005,s_detail3[1].b_stjl006, 
                              s_detail3[1].b_stjl007,s_detail3[1].b_stjl008,s_detail4[1].b_stjjacti, 
                              s_detail4[1].b_stjjseq,s_detail4[1].b_stjj002,s_detail4[1].b_stjj003,s_detail4[1].b_stjj004, 
                              s_detail4[1].b_stjj005,s_detail4[1].b_stjj009,s_detail5[1].b_stjkacti, 
                              s_detail5[1].b_stjkseq,s_detail5[1].b_stjk002,s_detail5[1].b_stjk004,s_detail5[1].b_stjk003, 
                              s_detail5[1].b_stjk005
 
         BEFORE CONSTRUCT
                     DISPLAY astq811_filter_parser('stje007') TO s_detail1[1].b_stje007
            DISPLAY astq811_filter_parser('stje008') TO s_detail1[1].b_stje008
            DISPLAY astq811_filter_parser('stje001') TO s_detail1[1].b_stje001
            DISPLAY astq811_filter_parser('stje005') TO s_detail1[1].b_stje005
            DISPLAY astq811_filter_parser('stje019') TO s_detail1[1].b_stje019
            DISPLAY astq811_filter_parser('stje020') TO s_detail1[1].b_stje020
            DISPLAY astq811_filter_parser('stje021') TO s_detail1[1].b_stje021
            DISPLAY astq811_filter_parser('stje029') TO s_detail1[1].b_stje029
            DISPLAY astq811_filter_parser('stje028') TO s_detail1[1].b_stje028
            DISPLAY astq811_filter_parser('stje011') TO s_detail1[1].b_stje011
            DISPLAY astq811_filter_parser('stje012') TO s_detail1[1].b_stje012
            DISPLAY astq811_filter_parser('stje022') TO s_detail1[1].b_stje022
            DISPLAY astq811_filter_parser('stje030') TO s_detail1[1].b_stje030
            DISPLAY astq811_filter_parser('stje031') TO s_detail1[1].b_stje031
            DISPLAY astq811_filter_parser('stje045') TO s_detail1[1].b_stje045
            DISPLAY astq811_filter_parser('stjfseq') TO s_detail1[1].b_stjfseq
            DISPLAY astq811_filter_parser('stjf002') TO s_detail1[1].b_stjf002
            DISPLAY astq811_filter_parser('stjf003') TO s_detail1[1].b_stjf003
            DISPLAY astq811_filter_parser('stjf021') TO s_detail1[1].b_stjf021
            DISPLAY astq811_filter_parser('stjf004') TO s_detail1[1].b_stjf004
            DISPLAY astq811_filter_parser('stae004') TO s_detail1[1].b_stae004
            DISPLAY astq811_filter_parser('stjf022') TO s_detail1[1].b_stjf022
            DISPLAY astq811_filter_parser('stjf005') TO s_detail1[1].b_stjf005
            DISPLAY astq811_filter_parser('stjf006') TO s_detail1[1].b_stjf006
            DISPLAY astq811_filter_parser('stjf007') TO s_detail1[1].b_stjf007
            DISPLAY astq811_filter_parser('stjf008') TO s_detail1[1].b_stjf008
            DISPLAY astq811_filter_parser('stjf009') TO s_detail1[1].b_stjf009
            DISPLAY astq811_filter_parser('stjf010') TO s_detail1[1].b_stjf010
            DISPLAY astq811_filter_parser('stjf011') TO s_detail1[1].b_stjf011
            DISPLAY astq811_filter_parser('stjf018') TO s_detail1[1].b_stjf018
            DISPLAY astq811_filter_parser('stjf012') TO s_detail1[1].b_stjf012
            DISPLAY astq811_filter_parser('stjf019') TO s_detail1[1].b_stjf019
            DISPLAY astq811_filter_parser('stjf013') TO s_detail1[1].b_stjf013
            DISPLAY astq811_filter_parser('stjf014') TO s_detail1[1].b_stjf014
            DISPLAY astq811_filter_parser('stjf015') TO s_detail1[1].b_stjf015
            DISPLAY astq811_filter_parser('stjf016') TO s_detail1[1].b_stjf016
            DISPLAY astq811_filter_parser('stjf017') TO s_detail1[1].b_stjf017
            DISPLAY astq811_filter_parser('stjf020') TO s_detail1[1].b_stjf020
            DISPLAY astq811_filter_parser('stjf023') TO s_detail1[1].b_stjf023
            DISPLAY astq811_filter_parser('stjf024') TO s_detail1[1].b_stjf024
            DISPLAY astq811_filter_parser('stjf025') TO s_detail1[1].b_stjf025
            DISPLAY astq811_filter_parser('stjhseq') TO s_detail2[1].b_stjhseq
            DISPLAY astq811_filter_parser('stjh002') TO s_detail2[1].b_stjh002
            DISPLAY astq811_filter_parser('stjh003') TO s_detail2[1].b_stjh003
            DISPLAY astq811_filter_parser('stjh008') TO s_detail2[1].b_stjh008
            DISPLAY astq811_filter_parser('stjh004') TO s_detail2[1].b_stjh004
            DISPLAY astq811_filter_parser('stjh005') TO s_detail2[1].b_stjh005
            DISPLAY astq811_filter_parser('stjh006') TO s_detail2[1].b_stjh006
            DISPLAY astq811_filter_parser('stjh007') TO s_detail2[1].b_stjh007
            DISPLAY astq811_filter_parser('stjlseq') TO s_detail3[1].b_stjlseq
            DISPLAY astq811_filter_parser('stjl002') TO s_detail3[1].b_stjl002
            DISPLAY astq811_filter_parser('stjl003') TO s_detail3[1].b_stjl003
            DISPLAY astq811_filter_parser('stjl004') TO s_detail3[1].b_stjl004
            DISPLAY astq811_filter_parser('stjl005') TO s_detail3[1].b_stjl005
            DISPLAY astq811_filter_parser('stjl006') TO s_detail3[1].b_stjl006
            DISPLAY astq811_filter_parser('stjl007') TO s_detail3[1].b_stjl007
            DISPLAY astq811_filter_parser('stjl008') TO s_detail3[1].b_stjl008
            DISPLAY astq811_filter_parser('stjjacti') TO s_detail4[1].b_stjjacti
            DISPLAY astq811_filter_parser('stjjseq') TO s_detail4[1].b_stjjseq
            DISPLAY astq811_filter_parser('stjj002') TO s_detail4[1].b_stjj002
            DISPLAY astq811_filter_parser('stjj003') TO s_detail4[1].b_stjj003
            DISPLAY astq811_filter_parser('stjj004') TO s_detail4[1].b_stjj004
            DISPLAY astq811_filter_parser('stjj005') TO s_detail4[1].b_stjj005
            DISPLAY astq811_filter_parser('stjj009') TO s_detail4[1].b_stjj009
            DISPLAY astq811_filter_parser('stjkacti') TO s_detail5[1].b_stjkacti
            DISPLAY astq811_filter_parser('stjkseq') TO s_detail5[1].b_stjkseq
            DISPLAY astq811_filter_parser('stjk002') TO s_detail5[1].b_stjk002
            DISPLAY astq811_filter_parser('stjk004') TO s_detail5[1].b_stjk004
            DISPLAY astq811_filter_parser('stjk003') TO s_detail5[1].b_stjk003
            DISPLAY astq811_filter_parser('stjk005') TO s_detail5[1].b_stjk005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_stje007>>----
         #Ctrlp:construct.c.filter.page1.b_stje007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje007
            #add-point:ON ACTION controlp INFIELD b_stje007 name="construct.c.filter.page1.b_stje007"
            
            #END add-point
 
 
         #----<<b_stje007_desc>>----
         #----<<b_stje008>>----
         #Ctrlp:construct.c.filter.page1.b_stje008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje008
            #add-point:ON ACTION controlp INFIELD b_stje008 name="construct.c.filter.page1.b_stje008"
            
            #END add-point
 
 
         #----<<b_stje008_desc>>----
         #----<<b_stje001>>----
         #Ctrlp:construct.c.filter.page1.b_stje001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje001
            #add-point:ON ACTION controlp INFIELD b_stje001 name="construct.c.filter.page1.b_stje001"
            
            #END add-point
 
 
         #----<<b_stje005>>----
         #Ctrlp:construct.c.filter.page1.b_stje005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje005
            #add-point:ON ACTION controlp INFIELD b_stje005 name="construct.c.filter.page1.b_stje005"
            
            #END add-point
 
 
         #----<<b_stje019>>----
         #Ctrlp:construct.c.filter.page1.b_stje019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje019
            #add-point:ON ACTION controlp INFIELD b_stje019 name="construct.c.filter.page1.b_stje019"
            
            #END add-point
 
 
         #----<<b_stje019_desc>>----
         #----<<b_stje020>>----
         #Ctrlp:construct.c.filter.page1.b_stje020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje020
            #add-point:ON ACTION controlp INFIELD b_stje020 name="construct.c.filter.page1.b_stje020"
            
            #END add-point
 
 
         #----<<b_stje020_desc>>----
         #----<<b_stje021>>----
         #Ctrlp:construct.c.filter.page1.b_stje021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje021
            #add-point:ON ACTION controlp INFIELD b_stje021 name="construct.c.filter.page1.b_stje021"
            
            #END add-point
 
 
         #----<<b_stje021_desc>>----
         #----<<b_stje029>>----
         #Ctrlp:construct.c.filter.page1.b_stje029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje029
            #add-point:ON ACTION controlp INFIELD b_stje029 name="construct.c.filter.page1.b_stje029"
            
            #END add-point
 
 
         #----<<b_stje029_desc>>----
         #----<<b_stje028>>----
         #Ctrlp:construct.c.filter.page1.b_stje028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje028
            #add-point:ON ACTION controlp INFIELD b_stje028 name="construct.c.filter.page1.b_stje028"
            
            #END add-point
 
 
         #----<<b_stje028_desc>>----
         #----<<b_stje011>>----
         #Ctrlp:construct.c.filter.page1.b_stje011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje011
            #add-point:ON ACTION controlp INFIELD b_stje011 name="construct.c.filter.page1.b_stje011"
            
            #END add-point
 
 
         #----<<b_stje012>>----
         #Ctrlp:construct.c.filter.page1.b_stje012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje012
            #add-point:ON ACTION controlp INFIELD b_stje012 name="construct.c.filter.page1.b_stje012"
            
            #END add-point
 
 
         #----<<b_stje022>>----
         #Ctrlp:construct.c.filter.page1.b_stje022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje022
            #add-point:ON ACTION controlp INFIELD b_stje022 name="construct.c.filter.page1.b_stje022"
            
            #END add-point
 
 
         #----<<b_stje022_desc>>----
         #----<<b_stje030>>----
         #Ctrlp:construct.c.filter.page1.b_stje030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje030
            #add-point:ON ACTION controlp INFIELD b_stje030 name="construct.c.filter.page1.b_stje030"
            
            #END add-point
 
 
         #----<<b_stje030_desc>>----
         #----<<b_stje031>>----
         #Ctrlp:construct.c.filter.page1.b_stje031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje031
            #add-point:ON ACTION controlp INFIELD b_stje031 name="construct.c.filter.page1.b_stje031"
            
            #END add-point
 
 
         #----<<b_stje031_desc>>----
         #----<<b_stje045>>----
         #Ctrlp:construct.c.filter.page1.b_stje045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stje045
            #add-point:ON ACTION controlp INFIELD b_stje045 name="construct.c.filter.page1.b_stje045"
            
            #END add-point
 
 
         #----<<b_stjfseq>>----
         #Ctrlp:construct.c.filter.page1.b_stjfseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjfseq
            #add-point:ON ACTION controlp INFIELD b_stjfseq name="construct.c.filter.page1.b_stjfseq"
            
            #END add-point
 
 
         #----<<b_stjf002>>----
         #Ctrlp:construct.c.filter.page1.b_stjf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf002
            #add-point:ON ACTION controlp INFIELD b_stjf002 name="construct.c.filter.page1.b_stjf002"
            
            #END add-point
 
 
         #----<<b_stjf003>>----
         #Ctrlp:construct.c.filter.page1.b_stjf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf003
            #add-point:ON ACTION controlp INFIELD b_stjf003 name="construct.c.filter.page1.b_stjf003"
            
            #END add-point
 
 
         #----<<b_stjf021>>----
         #Ctrlp:construct.c.filter.page1.b_stjf021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf021
            #add-point:ON ACTION controlp INFIELD b_stjf021 name="construct.c.filter.page1.b_stjf021"
            
            #END add-point
 
 
         #----<<b_stjf004>>----
         #Ctrlp:construct.c.filter.page1.b_stjf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf004
            #add-point:ON ACTION controlp INFIELD b_stjf004 name="construct.c.filter.page1.b_stjf004"
            
            #END add-point
 
 
         #----<<b_stjf004_desc>>----
         #----<<b_stae004>>----
         #Ctrlp:construct.c.filter.page1.b_stae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stae004
            #add-point:ON ACTION controlp INFIELD b_stae004 name="construct.c.filter.page1.b_stae004"
            
            #END add-point
 
 
         #----<<b_stjf022>>----
         #Ctrlp:construct.c.filter.page1.b_stjf022
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf022
            #add-point:ON ACTION controlp INFIELD b_stjf022 name="construct.c.filter.page1.b_stjf022"
            
            #END add-point
 
 
         #----<<b_stjf022_desc>>----
         #----<<b_stjf005>>----
         #Ctrlp:construct.c.filter.page1.b_stjf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf005
            #add-point:ON ACTION controlp INFIELD b_stjf005 name="construct.c.filter.page1.b_stjf005"
            
            #END add-point
 
 
         #----<<b_stjf006>>----
         #Ctrlp:construct.c.filter.page1.b_stjf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf006
            #add-point:ON ACTION controlp INFIELD b_stjf006 name="construct.c.filter.page1.b_stjf006"
            
            #END add-point
 
 
         #----<<b_stjf007>>----
         #Ctrlp:construct.c.filter.page1.b_stjf007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf007
            #add-point:ON ACTION controlp INFIELD b_stjf007 name="construct.c.filter.page1.b_stjf007"
            
            #END add-point
 
 
         #----<<b_stjf008>>----
         #Ctrlp:construct.c.filter.page1.b_stjf008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf008
            #add-point:ON ACTION controlp INFIELD b_stjf008 name="construct.c.filter.page1.b_stjf008"
            
            #END add-point
 
 
         #----<<b_stjf009>>----
         #Ctrlp:construct.c.filter.page1.b_stjf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf009
            #add-point:ON ACTION controlp INFIELD b_stjf009 name="construct.c.filter.page1.b_stjf009"
            
            #END add-point
 
 
         #----<<b_stjf010>>----
         #Ctrlp:construct.c.filter.page1.b_stjf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf010
            #add-point:ON ACTION controlp INFIELD b_stjf010 name="construct.c.filter.page1.b_stjf010"
            
            #END add-point
 
 
         #----<<b_stjf011>>----
         #Ctrlp:construct.c.filter.page1.b_stjf011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf011
            #add-point:ON ACTION controlp INFIELD b_stjf011 name="construct.c.filter.page1.b_stjf011"
            
            #END add-point
 
 
         #----<<b_stjf018>>----
         #Ctrlp:construct.c.filter.page1.b_stjf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf018
            #add-point:ON ACTION controlp INFIELD b_stjf018 name="construct.c.filter.page1.b_stjf018"
            
            #END add-point
 
 
         #----<<b_stjf012>>----
         #Ctrlp:construct.c.filter.page1.b_stjf012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf012
            #add-point:ON ACTION controlp INFIELD b_stjf012 name="construct.c.filter.page1.b_stjf012"
            
            #END add-point
 
 
         #----<<b_stjf019>>----
         #Ctrlp:construct.c.filter.page1.b_stjf019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf019
            #add-point:ON ACTION controlp INFIELD b_stjf019 name="construct.c.filter.page1.b_stjf019"
            
            #END add-point
 
 
         #----<<b_stjf013>>----
         #Ctrlp:construct.c.filter.page1.b_stjf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf013
            #add-point:ON ACTION controlp INFIELD b_stjf013 name="construct.c.filter.page1.b_stjf013"
            
            #END add-point
 
 
         #----<<b_stjf014>>----
         #Ctrlp:construct.c.filter.page1.b_stjf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf014
            #add-point:ON ACTION controlp INFIELD b_stjf014 name="construct.c.filter.page1.b_stjf014"
            
            #END add-point
 
 
         #----<<b_stjf015>>----
         #Ctrlp:construct.c.filter.page1.b_stjf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf015
            #add-point:ON ACTION controlp INFIELD b_stjf015 name="construct.c.filter.page1.b_stjf015"
            
            #END add-point
 
 
         #----<<b_stjf016>>----
         #Ctrlp:construct.c.filter.page1.b_stjf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf016
            #add-point:ON ACTION controlp INFIELD b_stjf016 name="construct.c.filter.page1.b_stjf016"
            
            #END add-point
 
 
         #----<<b_stjf017>>----
         #Ctrlp:construct.c.filter.page1.b_stjf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf017
            #add-point:ON ACTION controlp INFIELD b_stjf017 name="construct.c.filter.page1.b_stjf017"
            
            #END add-point
 
 
         #----<<b_stjf020>>----
         #Ctrlp:construct.c.filter.page1.b_stjf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf020
            #add-point:ON ACTION controlp INFIELD b_stjf020 name="construct.c.filter.page1.b_stjf020"
            
            #END add-point
 
 
         #----<<b_stjf023>>----
         #Ctrlp:construct.c.filter.page1.b_stjf023
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf023
            #add-point:ON ACTION controlp INFIELD b_stjf023 name="construct.c.filter.page1.b_stjf023"
            
            #END add-point
 
 
         #----<<b_stjf024>>----
         #Ctrlp:construct.c.filter.page1.b_stjf024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf024
            #add-point:ON ACTION controlp INFIELD b_stjf024 name="construct.c.filter.page1.b_stjf024"
            
            #END add-point
 
 
         #----<<b_stjf024_desc>>----
         #----<<b_stjf025>>----
         #Ctrlp:construct.c.filter.page1.b_stjf025
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjf025
            #add-point:ON ACTION controlp INFIELD b_stjf025 name="construct.c.filter.page1.b_stjf025"
            
            #END add-point
 
 
         #----<<sel_6>>----
         #----<<b_stje007_1>>----
         #----<<b_stje007_1_desc>>----
         #----<<b_stje008_1>>----
         #----<<b_stje008_1_desc>>----
         #----<<b_stje001_1>>----
         #----<<b_stje005_1>>----
         #----<<b_stje019_1>>----
         #----<<b_stje019_1_desc>>----
         #----<<b_stje020_1>>----
         #----<<b_stje020_1_desc>>----
         #----<<b_stje021_1>>----
         #----<<b_stje021_1_desc_1>>----
         #----<<b_stje029_1>>----
         #----<<b_stje029_1_desc>>----
         #----<<b_stje028_1>>----
         #----<<b_stje028_1_desc>>----
         #----<<b_stje011_1>>----
         #----<<b_stje012_1>>----
         #----<<b_stje022_1>>----
         #----<<b_stje022_1_desc>>----
         #----<<b_stje030_1>>----
         #----<<b_stje030_1_desc>>----
         #----<<b_stje031_1>>----
         #----<<b_stje031_1_desc>>----
         #----<<b_stje045_1>>----
         #----<<b_stjhseq>>----
         #Ctrlp:construct.c.filter.page2.b_stjhseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjhseq
            #add-point:ON ACTION controlp INFIELD b_stjhseq name="construct.c.filter.page2.b_stjhseq"
            
            #END add-point
 
 
         #----<<b_stjh002>>----
         #Ctrlp:construct.c.filter.page2.b_stjh002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh002
            #add-point:ON ACTION controlp INFIELD b_stjh002 name="construct.c.filter.page2.b_stjh002"
            
            #END add-point
 
 
         #----<<b_stjh002_desc>>----
         #----<<b_stae004_1>>----
         #----<<b_stjh003>>----
         #Ctrlp:construct.c.filter.page2.b_stjh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh003
            #add-point:ON ACTION controlp INFIELD b_stjh003 name="construct.c.filter.page2.b_stjh003"
            
            #END add-point
 
 
         #----<<b_stjh008>>----
         #Ctrlp:construct.c.filter.page2.b_stjh008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh008
            #add-point:ON ACTION controlp INFIELD b_stjh008 name="construct.c.filter.page2.b_stjh008"
            
            #END add-point
 
 
         #----<<b_stjh004>>----
         #Ctrlp:construct.c.filter.page2.b_stjh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh004
            #add-point:ON ACTION controlp INFIELD b_stjh004 name="construct.c.filter.page2.b_stjh004"
            
            #END add-point
 
 
         #----<<b_stjh005>>----
         #Ctrlp:construct.c.filter.page2.b_stjh005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh005
            #add-point:ON ACTION controlp INFIELD b_stjh005 name="construct.c.filter.page2.b_stjh005"
            
            #END add-point
 
 
         #----<<b_stjh006>>----
         #Ctrlp:construct.c.filter.page2.b_stjh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh006
            #add-point:ON ACTION controlp INFIELD b_stjh006 name="construct.c.filter.page2.b_stjh006"
            
            #END add-point
 
 
         #----<<b_stjh007>>----
         #Ctrlp:construct.c.filter.page2.b_stjh007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjh007
            #add-point:ON ACTION controlp INFIELD b_stjh007 name="construct.c.filter.page2.b_stjh007"
            
            #END add-point
 
 
         #----<<sel_7>>----
         #----<<b_stje007_2>>----
         #----<<b_stje007_2_desc>>----
         #----<<b_stje008_2>>----
         #----<<b_stje008_2_desc>>----
         #----<<b_stje001_2>>----
         #----<<b_stje005_2>>----
         #----<<b_stje019_2>>----
         #----<<b_stje019_2_desc>>----
         #----<<b_stje020_2>>----
         #----<<b_stje020_2_desc>>----
         #----<<b_stje021_2>>----
         #----<<b_stje021_2_desc>>----
         #----<<b_stje029_2>>----
         #----<<b_stje029_2_desc>>----
         #----<<b_stje028_2>>----
         #----<<b_stje028_2_desc>>----
         #----<<b_stje011_2>>----
         #----<<b_stje012_2>>----
         #----<<b_stje022_2>>----
         #----<<b_stje022_2_desc>>----
         #----<<b_stje030_2>>----
         #----<<b_stje030_2_desc>>----
         #----<<b_stje031_2>>----
         #----<<b_stje031_2_desc>>----
         #----<<b_stje045_2>>----
         #----<<b_stjlseq>>----
         #Ctrlp:construct.c.filter.page3.b_stjlseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjlseq
            #add-point:ON ACTION controlp INFIELD b_stjlseq name="construct.c.filter.page3.b_stjlseq"
            
            #END add-point
 
 
         #----<<b_stjl002>>----
         #Ctrlp:construct.c.filter.page3.b_stjl002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl002
            #add-point:ON ACTION controlp INFIELD b_stjl002 name="construct.c.filter.page3.b_stjl002"
            
            #END add-point
 
 
         #----<<b_stjl003>>----
         #Ctrlp:construct.c.filter.page3.b_stjl003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl003
            #add-point:ON ACTION controlp INFIELD b_stjl003 name="construct.c.filter.page3.b_stjl003"
            
            #END add-point
 
 
         #----<<b_stjl003_desc>>----
         #----<<b_stjl004>>----
         #Ctrlp:construct.c.filter.page3.b_stjl004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl004
            #add-point:ON ACTION controlp INFIELD b_stjl004 name="construct.c.filter.page3.b_stjl004"
            
            #END add-point
 
 
         #----<<b_stjl005>>----
         #Ctrlp:construct.c.filter.page3.b_stjl005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl005
            #add-point:ON ACTION controlp INFIELD b_stjl005 name="construct.c.filter.page3.b_stjl005"
            
            #END add-point
 
 
         #----<<b_stjl006>>----
         #Ctrlp:construct.c.filter.page3.b_stjl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl006
            #add-point:ON ACTION controlp INFIELD b_stjl006 name="construct.c.filter.page3.b_stjl006"
            
            #END add-point
 
 
         #----<<b_stjl007>>----
         #Ctrlp:construct.c.filter.page3.b_stjl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl007
            #add-point:ON ACTION controlp INFIELD b_stjl007 name="construct.c.filter.page3.b_stjl007"
            
            #END add-point
 
 
         #----<<b_stjl008>>----
         #Ctrlp:construct.c.filter.page3.b_stjl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjl008
            #add-point:ON ACTION controlp INFIELD b_stjl008 name="construct.c.filter.page3.b_stjl008"
            
            #END add-point
 
 
         #----<<sel_8>>----
         #----<<b_stje007_3>>----
         #----<<b_stje007_3_desc>>----
         #----<<b_stje008_3>>----
         #----<<b_stje008_3_desc>>----
         #----<<b_stje001_3>>----
         #----<<b_stje005_3>>----
         #----<<b_stje019_3>>----
         #----<<b_stje019_3_desc>>----
         #----<<b_stje020_3>>----
         #----<<b_stje020_3_desc>>----
         #----<<b_stje021_3>>----
         #----<<b_stje021_3_desc>>----
         #----<<b_stje029_3>>----
         #----<<b_stje029_3_desc>>----
         #----<<b_stje028_3>>----
         #----<<b_stje028_3_desc>>----
         #----<<b_stje011_3>>----
         #----<<b_stje012_3>>----
         #----<<b_stje022_3>>----
         #----<<b_stje022_3_desc>>----
         #----<<b_stje030_3>>----
         #----<<b_stje030_3_desc>>----
         #----<<b_stje031_3>>----
         #----<<b_stje031_3_desc>>----
         #----<<b_stje045_3>>----
         #----<<b_stjjacti>>----
         #Ctrlp:construct.c.filter.page4.b_stjjacti
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjjacti
            #add-point:ON ACTION controlp INFIELD b_stjjacti name="construct.c.filter.page4.b_stjjacti"
            
            #END add-point
 
 
         #----<<b_stjjseq>>----
         #Ctrlp:construct.c.filter.page4.b_stjjseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjjseq
            #add-point:ON ACTION controlp INFIELD b_stjjseq name="construct.c.filter.page4.b_stjjseq"
            
            #END add-point
 
 
         #----<<b_stjj002>>----
         #Ctrlp:construct.c.filter.page4.b_stjj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjj002
            #add-point:ON ACTION controlp INFIELD b_stjj002 name="construct.c.filter.page4.b_stjj002"
            
            #END add-point
 
 
         #----<<b_stjj002_desc>>----
         #----<<b_stjj003>>----
         #Ctrlp:construct.c.filter.page4.b_stjj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjj003
            #add-point:ON ACTION controlp INFIELD b_stjj003 name="construct.c.filter.page4.b_stjj003"
            
            #END add-point
 
 
         #----<<b_stjj004>>----
         #Ctrlp:construct.c.filter.page4.b_stjj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjj004
            #add-point:ON ACTION controlp INFIELD b_stjj004 name="construct.c.filter.page4.b_stjj004"
            
            #END add-point
 
 
         #----<<b_stjj005>>----
         #Ctrlp:construct.c.filter.page4.b_stjj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjj005
            #add-point:ON ACTION controlp INFIELD b_stjj005 name="construct.c.filter.page4.b_stjj005"
            
            #END add-point
 
 
         #----<<b_stjj009>>----
         #Ctrlp:construct.c.filter.page4.b_stjj009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjj009
            #add-point:ON ACTION controlp INFIELD b_stjj009 name="construct.c.filter.page4.b_stjj009"
            
            #END add-point
 
 
         #----<<sel_9>>----
         #----<<b_stje007_4>>----
         #----<<b_stje007_4_desc>>----
         #----<<b_stje008_4>>----
         #----<<b_stje008_4_desc>>----
         #----<<b_stje001_4>>----
         #----<<b_stje005_4>>----
         #----<<b_stje019_4>>----
         #----<<b_stje019_4_desc>>----
         #----<<b_stje020_4>>----
         #----<<b_stje020_4_desc>>----
         #----<<b_stje021_4>>----
         #----<<b_stje021_4_desc>>----
         #----<<b_stje029_4>>----
         #----<<b_stje029_4_desc>>----
         #----<<b_stje028_4>>----
         #----<<b_stje028_4_desc>>----
         #----<<b_stje011_4>>----
         #----<<b_stje012_4>>----
         #----<<b_stje022_4>>----
         #----<<b_stje022_4_desc>>----
         #----<<b_stje030_4>>----
         #----<<b_stje030_4_desc>>----
         #----<<b_stje031_4>>----
         #----<<b_stje031_4_desc>>----
         #----<<b_stje045_4>>----
         #----<<b_stjkacti>>----
         #Ctrlp:construct.c.filter.page5.b_stjkacti
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjkacti
            #add-point:ON ACTION controlp INFIELD b_stjkacti name="construct.c.filter.page5.b_stjkacti"
            
            #END add-point
 
 
         #----<<b_stjkseq>>----
         #Ctrlp:construct.c.filter.page5.b_stjkseq
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjkseq
            #add-point:ON ACTION controlp INFIELD b_stjkseq name="construct.c.filter.page5.b_stjkseq"
            
            #END add-point
 
 
         #----<<b_stjk002>>----
         #Ctrlp:construct.c.filter.page5.b_stjk002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjk002
            #add-point:ON ACTION controlp INFIELD b_stjk002 name="construct.c.filter.page5.b_stjk002"
            
            #END add-point
 
 
         #----<<b_stjk002_desc>>----
         #----<<b_stjk004>>----
         #Ctrlp:construct.c.filter.page5.b_stjk004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjk004
            #add-point:ON ACTION controlp INFIELD b_stjk004 name="construct.c.filter.page5.b_stjk004"
            
            #END add-point
 
 
         #----<<b_stjk003>>----
         #Ctrlp:construct.c.filter.page5.b_stjk003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjk003
            #add-point:ON ACTION controlp INFIELD b_stjk003 name="construct.c.filter.page5.b_stjk003"
            
            #END add-point
 
 
         #----<<b_stjk003_desc>>----
         #----<<b_stjk005>>----
         #Ctrlp:construct.c.filter.page5.b_stjk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stjk005
            #add-point:ON ACTION controlp INFIELD b_stjk005 name="construct.c.filter.page5.b_stjk005"
            
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
 
      CALL astq811_filter_show('stje007','b_stje007')
   CALL astq811_filter_show('stje008','b_stje008')
   CALL astq811_filter_show('stje001','b_stje001')
   CALL astq811_filter_show('stje005','b_stje005')
   CALL astq811_filter_show('stje019','b_stje019')
   CALL astq811_filter_show('stje020','b_stje020')
   CALL astq811_filter_show('stje021','b_stje021')
   CALL astq811_filter_show('stje029','b_stje029')
   CALL astq811_filter_show('stje028','b_stje028')
   CALL astq811_filter_show('stje011','b_stje011')
   CALL astq811_filter_show('stje012','b_stje012')
   CALL astq811_filter_show('stje022','b_stje022')
   CALL astq811_filter_show('stje030','b_stje030')
   CALL astq811_filter_show('stje031','b_stje031')
   CALL astq811_filter_show('stje045','b_stje045')
   CALL astq811_filter_show('stjfseq','b_stjfseq')
   CALL astq811_filter_show('stjf002','b_stjf002')
   CALL astq811_filter_show('stjf003','b_stjf003')
   CALL astq811_filter_show('stjf021','b_stjf021')
   CALL astq811_filter_show('stjf004','b_stjf004')
   CALL astq811_filter_show('stae004','b_stae004')
   CALL astq811_filter_show('stjf022','b_stjf022')
   CALL astq811_filter_show('stjf005','b_stjf005')
   CALL astq811_filter_show('stjf006','b_stjf006')
   CALL astq811_filter_show('stjf007','b_stjf007')
   CALL astq811_filter_show('stjf008','b_stjf008')
   CALL astq811_filter_show('stjf009','b_stjf009')
   CALL astq811_filter_show('stjf010','b_stjf010')
   CALL astq811_filter_show('stjf011','b_stjf011')
   CALL astq811_filter_show('stjf018','b_stjf018')
   CALL astq811_filter_show('stjf012','b_stjf012')
   CALL astq811_filter_show('stjf019','b_stjf019')
   CALL astq811_filter_show('stjf013','b_stjf013')
   CALL astq811_filter_show('stjf014','b_stjf014')
   CALL astq811_filter_show('stjf015','b_stjf015')
   CALL astq811_filter_show('stjf016','b_stjf016')
   CALL astq811_filter_show('stjf017','b_stjf017')
   CALL astq811_filter_show('stjf020','b_stjf020')
   CALL astq811_filter_show('stjf023','b_stjf023')
   CALL astq811_filter_show('stjf024','b_stjf024')
   CALL astq811_filter_show('stjf025','b_stjf025')
   CALL astq811_filter_show('stjhseq','b_stjhseq')
   CALL astq811_filter_show('stjh002','b_stjh002')
   CALL astq811_filter_show('stjh003','b_stjh003')
   CALL astq811_filter_show('stjh008','b_stjh008')
   CALL astq811_filter_show('stjh004','b_stjh004')
   CALL astq811_filter_show('stjh005','b_stjh005')
   CALL astq811_filter_show('stjh006','b_stjh006')
   CALL astq811_filter_show('stjh007','b_stjh007')
   CALL astq811_filter_show('stjlseq','b_stjlseq')
   CALL astq811_filter_show('stjl002','b_stjl002')
   CALL astq811_filter_show('stjl003','b_stjl003')
   CALL astq811_filter_show('stjl004','b_stjl004')
   CALL astq811_filter_show('stjl005','b_stjl005')
   CALL astq811_filter_show('stjl006','b_stjl006')
   CALL astq811_filter_show('stjl007','b_stjl007')
   CALL astq811_filter_show('stjl008','b_stjl008')
   CALL astq811_filter_show('stjjacti','b_stjjacti')
   CALL astq811_filter_show('stjjseq','b_stjjseq')
   CALL astq811_filter_show('stjj002','b_stjj002')
   CALL astq811_filter_show('stjj003','b_stjj003')
   CALL astq811_filter_show('stjj004','b_stjj004')
   CALL astq811_filter_show('stjj005','b_stjj005')
   CALL astq811_filter_show('stjj009','b_stjj009')
   CALL astq811_filter_show('stjkacti','b_stjkacti')
   CALL astq811_filter_show('stjkseq','b_stjkseq')
   CALL astq811_filter_show('stjk002','b_stjk002')
   CALL astq811_filter_show('stjk004','b_stjk004')
   CALL astq811_filter_show('stjk003','b_stjk003')
   CALL astq811_filter_show('stjk005','b_stjk005')
 
 
   CALL astq811_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq811.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION astq811_filter_parser(ps_field)
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
 
{<section id="astq811.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION astq811_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq811_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="astq811.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq811_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"

   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"

   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"

   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   #DISPLAY g_tot_cnt TO FORMONLY.h_count
 
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
 
{<section id="astq811.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq811_detail_index_setting()
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
            IF g_stje_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stje_d.getLength() AND g_stje_d.getLength() > 0
            LET g_detail_idx = g_stje_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stje_d.getLength() THEN
               LET g_detail_idx = g_stje_d.getLength()
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
 
{<section id="astq811.mask_functions" >}
 &include "erp/ast/astq811_mask.4gl"
 
{</section>}
 
{<section id="astq811.other_function" readonly="Y" >}

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
PRIVATE FUNCTION astq811_cre_tmp()
DROP TABLE astq811_tmp
CREATE TEMP TABLE astq811_tmp (
       stje007        VARCHAR(10),
       stje007_desc   VARCHAR(255),
       stje008        VARCHAR(20),
       stje008_desc   VARCHAR(500),
       stje001        VARCHAR(20),
       stje005        VARCHAR(10),
       stje019        VARCHAR(10),       
       stje019_desc   VARCHAR(500), 
       stje020        VARCHAR(10),       
       stje020_desc   VARCHAR(500),   
       stje021        VARCHAR(10),       
       stje021_desc   VARCHAR(500),
       stje029        VARCHAR(10),       
       stje029_desc   VARCHAR(500),   
       stje028        VARCHAR(10),       
       stje028_desc   VARCHAR(500),
       stje011        DATE,
       stje012        DATE,
       stje045        DATE, 
       stje022        VARCHAR(10),       
       stje022_desc   VARCHAR(500),   
       stje030        VARCHAR(10),       
       stje030_desc   VARCHAR(500),
       stje031        VARCHAR(10),       
       stje031_desc   VARCHAR(500))
       
       
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
PRIVATE FUNCTION astq811_b_fill_1()
DEFINE l_sql      STRING
DEFINE l_sql1      STRING 
DEFINE l_sql2      STRING 
DEFINE l_sql3      STRING
DEFINE l_sql4      STRING 
DEFINE l_sql5      STRING 
DEFINE l_where    STRING
DEFINE l_ac1       int
DEFINE l_ac2       int
DEFINE l_ac3       int
DEFINE l_ac4       int
DEFINE l_ac5       int

CALL g_stje_d.clear()
CALL g_stje2_d.clear() 
CALL g_stje3_d.clear() 
CALL g_stje4_d.clear() 
CALL g_stje5_d.clear()
CALL s_aooi500_sql_where(g_prog,'stjesite') RETURNING l_where
IF cl_null(g_wc) THEN 
   LET g_wc = " 1=1 "
END IF 
LET l_sql="SELECT stje007,(SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=stje007 AND pmaal002='"||g_dlang||"') stje007_desc,",
          "stje008,(SELECT mhbel003 FROM mhbel_t WHERE mhbelent='"||g_enterprise||"' AND mhbel001=stje008 AND mhbel002='"||g_dlang||"') stje008_desc,",
          "stje001,stje005,",
          "stje019,(SELECT mhaal003 FROM mhaal_t WHERE mhaalent='"||g_enterprise||"' AND mhaal001=stje019 AND mhaal002='"||g_dlang||"') stje019_desc,",
          "stje020,(SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl001=stje019 AND mhabl002=stje020 AND mhabl003='"||g_dlang||"') stje020_desc,",
          "stje021,(SELECT mhacl005 FROM mhacl_t WHERE mhaclent='"||g_enterprise||"' AND mhacl001=stje019 AND mhacl002=stje020 AND mhacl003=stje021 AND mhacl004='"||g_dlang||"') stje021_desc,",
          "stje029,(SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002'  AND oocql002=stje029 AND oocql003='"||g_dlang||"') stje029_desc,",
          "stje028,(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=stje028 AND rtaxl002='"||g_dlang||"') stje029_desc,",
          "stje011,stje012,stje045,",
          "stje022,(SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2144'  AND oocql002=stje022 AND oocql003='"||g_dlang||"') stje022_desc,",
          "stje030,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=stje030 AND ooefl002='"||g_dlang||"') stje030_desc,",
          "stje031,(SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=stje031 AND staal002='"||g_dlang||"') stje031_desc ",
          "from stje_t ",
          "where stjeent=",g_enterprise,
          "  and ",l_where,
          "  and ",g_wc
          
LET l_sql="INSERT INTO astq811_tmp ",l_sql
PREPARE astq811_ins_tmp FROM l_sql  
EXECUTE astq811_ins_tmp
IF SQLCA.sqlcode<>0 AND SQLCA.sqlcode<>100 THEN
   INITIALIZE g_errparam TO NULL 
   LET g_errparam.extend = "EXECUTE:astq811_tmp" 
   LET g_errparam.code   = SQLCA.sqlcode 
   LET g_errparam.popup  = TRUE 
   CALL cl_err()
END IF
let l_ac1=1
let l_ac2=1
let l_ac3=1
let l_ac4=1
let l_ac5=1
LET l_sql1="SELECT '',stje007,stje007_desc,stje008,stje008_desc,stje001,stje005,",
           "stje019,stje019_desc,stje020,stje020_desc,stje021,stje021_desc,",
           "stje029,stje029_desc,stje028,stje028_desc,stje011,stje012,",
           "stje022,stje022_desc,stje030,stje030_desc,stje031,stje031_desc,stje045,",
           "stjfseq,stjf004,stjf003,stjf021,",
           "stjf004,(SELECT stael003 from stael_t where staelent='"||g_enterprise||"' AND stael001=stjf004 AND stael002='"||g_dlang||"') stjf004_desc,",
           "(select stae004 from stae_t where staeent='"||g_enterprise||"' and stae001=stjf004) stae004,",
           "stjf022,(SELECT distinct mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl004=stjf022 AND mhadl005='"||g_dlang||"') stjf022_desc,",
           "stjf005,stjf006,stjf007,stjf008,stjf009,stjf010,stjf011,stjf018,stjf012,",
           "stjf019,stjf013,stjf014,stjf015,stjf016,stjf017,stjf020,stjf023,",
           "stjf024,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=stjf024 AND ooefl002='"||g_dlang||"') stjf024_desc,",
           "stjf025 from astq811_tmp,stjf_t ",
           "where stjfent= '"||g_enterprise||"' and stjf001=stje001 ",
           "order by stje001,stjfseq"
PREPARE astq811_pb1 FROM l_sql1
DECLARE b_fill_cs1 CURSOR FOR astq811_pb1
FOREACH b_fill_cs1 into g_stje_d[l_ac1].* 
   let l_ac1=l_ac1+1
   IF l_ac1 > g_max_rec THEN
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
CALL g_stje_d.deleteElement(l_ac1)
#let l_ac1=l_ac1-1
LET l_sql2="SELECT '',stje007,stje007_desc,stje008,stje008_desc,stje001,stje005,",
           "stje019,stje019_desc,stje020,stje020_desc,stje021,stje021_desc,",
           "stje029,stje029_desc,stje028,stje028_desc,stje011,stje012,",
           "stje022,stje022_desc,stje030,stje030_desc,stje031,stje031_desc,stje045,",
           "stjhseq,",
           "stjh002,(SELECT stael003 from stael_t where staelent='"||g_enterprise||"' AND stael001=stjh002 AND stael002='"||g_dlang||"') stjh002_desc,",
           "(select stae004 from stae_t where staeent='"||g_enterprise||"' and stae001=stjh002) stae004,",
           "stjh003,stjh008,stjh004,stjh005,stjh006,stjh007 ",
           "from astq811_tmp,stjh_t ",
           "where  stjhent= '"||g_enterprise||"' and stjh001=stje001 ",
           "order by stje001,stjhseq"
PREPARE astq811_pb2 FROM l_sql2
DECLARE b_fill_cs2 CURSOR FOR astq811_pb2
FOREACH b_fill_cs2 into g_stje2_d[l_ac2].*
   let l_ac2=l_ac2+1
END FOREACH
CALL g_stje2_d.deleteElement(l_ac2)
#let l_ac2=l_ac2-1
LET l_sql3="SELECT '',stje007,stje007_desc,stje008,stje008_desc,stje001,stje005,",
           "stje019,stje019_desc,stje020,stje020_desc,stje021,stje021_desc,",
           "stje029,stje029_desc,stje028,stje028_desc,stje011,stje012,",
           "stje022,stje022_desc,stje030,stje030_desc,stje031,stje031_desc,stje045,",
           "stjlseq,stjl002,",
           "stjl003,(SELECT stael003 from stael_t where staelent='"||g_enterprise||"' AND stael001=stjl003 AND stael002='"||g_dlang||"') stjl003_desc,",
           "stjl004,stjl005,stjl006,stjl007,stjl008 ",
           "from astq811_tmp,stjl_t ",
           "where stjlent= '"||g_enterprise||"' and stjl001=stje001 ",
           "order by stje001,stjlseq"
PREPARE astq811_pb3 FROM l_sql3
DECLARE b_fill_cs3 CURSOR FOR astq811_pb3
FOREACH b_fill_cs3 into g_stje3_d[l_ac3].*
   let l_ac3=l_ac3+1
END FOREACH
CALL g_stje3_d.deleteElement(l_ac3)
#let l_ac3=l_ac3-1
LET l_sql4="SELECT '',stje007,stje007_desc,stje008,stje008_desc,stje001,stje005,",
           "stje019,stje019_desc,stje020,stje020_desc,stje021,stje021_desc,",
           "stje029,stje029_desc,stje028,stje028_desc,stje011,stje012,",
           "stje022,stje022_desc,stje030,stje030_desc,stje031,stje031_desc,stje045,",
           "stjjacti,stjjseq,",
           "stjj002,(SELECT distinct mhadl006 FROM mhadl_t WHERE mhadlent='"||g_enterprise||"' AND mhadl004=stjj002 AND mhadl005='"||g_dlang||"') stjj002_desc,",
           "stjj003,stjj004,stjj005,stjj009 ",
           "from astq811_tmp,stjj_t ",
           "where stjjent= '"||g_enterprise||"' and stjj001=stje001 ",
           "order by stje001,stjjseq"
PREPARE astq811_pb4 FROM l_sql4
DECLARE b_fill_cs4 CURSOR FOR astq811_pb4
FOREACH b_fill_cs4 into g_stje4_d[l_ac4].*
   let l_ac4=l_ac4+1
END FOREACH
CALL g_stje4_d.deleteElement(l_ac4)
#let l_ac4=l_ac4-1
LET l_sql5="SELECT '',stje007,stje007_desc,stje008,stje008_desc,stje001,stje005,",
           "stje019,stje019_desc,stje020,stje020_desc,stje021,stje021_desc,",
           "stje029,stje029_desc,stje028,stje028_desc,stje011,stje012,",
           "stje022,stje022_desc,stje030,stje030_desc,stje031,stje031_desc,stje045,",
           "stjkacti,stjkseq,",
           "stjk002,(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=stjk002 AND rtaxl002='"||g_dlang||"') stjk002_desc,",
           "stjk004,",
           "stjk003,(SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=stjk003 AND oocql003='"||g_dlang||"') stjk003_desc,",
           "stjk005 ",
           "from astq811_tmp,stjk_t ",
           "where stjkent= '"||g_enterprise||"' and stjk001=stje001 ",
           "order by stje001,stjkseq"
PREPARE astq811_pb5 FROM l_sql5
DECLARE b_fill_cs5 CURSOR FOR astq811_pb5
FOREACH b_fill_cs5 into g_stje5_d[l_ac5].*
   let l_ac5=l_ac5+1
END FOREACH
CALL g_stje5_d.deleteElement(l_ac5)
#let l_ac5=l_ac5-1

LET g_detail_cnt = g_stje_d.getLength()
END FUNCTION

 
{</section>}
 
