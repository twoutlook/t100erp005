#該程式未解開Section, 採用最新樣板產出!
{<section id="astq506.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-09-14 09:49:56), PR版次:0003(2016-09-14 09:29:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: astq506
#+ Description: 專櫃每日促銷銷售情況查詢作業
#+ Creator....: 06814(2015-05-11 09:05:34)
#+ Modifier...: 08742 -SD/PR- 08742
 
{</section>}
 
{<section id="astq506.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160913-00034#2    2016/09/14 by 08742      q_pmaa001開窗改成 q_pmaa001_1抓類型=3 的條件
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
PRIVATE TYPE type_g_stgf_d RECORD
       
       sel LIKE type_t.chr1, 
   stgfent LIKE type_t.num5, 
   stgf001 LIKE stgf_t.stgf001, 
   stgfsite LIKE stgf_t.stgfsite, 
   stgfsite_desc LIKE type_t.chr500, 
   stgf002 LIKE stgf_t.stgf002, 
   stgf002_desc LIKE type_t.chr500, 
   stgf003 LIKE stgf_t.stgf003, 
   stgf003_desc LIKE type_t.chr500, 
   stgf004 LIKE stgf_t.stgf004, 
   stgf004_desc LIKE type_t.chr500, 
   stgf005 LIKE stgf_t.stgf005, 
   stgf005_desc LIKE type_t.chr500, 
   stgf013 LIKE stgf_t.stgf013, 
   stgf013_desc LIKE type_t.chr500, 
   stgf006 LIKE stgf_t.stgf006, 
   stgf006_desc LIKE type_t.chr500, 
   stgf007 LIKE stgf_t.stgf007, 
   stgf007_desc LIKE type_t.chr500, 
   stgf014 LIKE stgf_t.stgf014, 
   stgf015 LIKE stgf_t.stgf015, 
   stgf017 LIKE stgf_t.stgf017, 
   stgf009 LIKE stgf_t.stgf009, 
   stgf010 LIKE stgf_t.stgf010, 
   stgf011 LIKE stgf_t.stgf011, 
   stgf018 LIKE stgf_t.stgf018, 
   stgf008 LIKE stgf_t.stgf008, 
   stgf012 LIKE stgf_t.stgf012
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_stgf2_d RECORD
       sel2 LIKE type_t.chr500, 
   stgfent LIKE stgf_t.stgfent, 
   l_stgf001_s LIKE type_t.dat, 
   l_stgf001_e LIKE type_t.dat, 
   stgfsite LIKE stgf_t.stgfsite, 
   stgfsite_1_desc LIKE type_t.chr500, 
   stgf002 LIKE stgf_t.stgf002, 
   stgf002_1_desc LIKE type_t.chr500, 
   stgf003 LIKE stgf_t.stgf003, 
   stgf003_1_desc LIKE type_t.chr500, 
   stgf004 LIKE stgf_t.stgf004, 
   stgf004_1_desc LIKE type_t.chr500, 
   stgf005 LIKE stgf_t.stgf005, 
   stgf005_1_desc LIKE type_t.chr500, 
   stgf013 LIKE stgf_t.stgf013, 
   stgf013_1_desc LIKE type_t.chr500, 
   stgf006 LIKE stgf_t.stgf006, 
   stgf006_1_desc LIKE type_t.chr500, 
   stgf007 LIKE stgf_t.stgf007, 
   stgf007_1_desc LIKE type_t.chr500, 
   stgf014 LIKE stgf_t.stgf014, 
   stgf015 LIKE stgf_t.stgf015, 
   stgf017 LIKE stgf_t.stgf017, 
   stgf009 LIKE stgf_t.stgf009, 
   stgf010 LIKE stgf_t.stgf010, 
   stgf011 LIKE stgf_t.stgf011, 
   stgf018 LIKE stgf_t.stgf018, 
   stgf008 LIKE stgf_t.stgf008, 
   stgf012 LIKE stgf_t.stgf012
       END RECORD
 
 TYPE type_g_stgf3_d RECORD
       sel3 LIKE type_t.chr500, 
   stgfent LIKE stgf_t.stgfent, 
   stgf001 LIKE stgf_t.stgf001, 
   stgfsite LIKE stgf_t.stgfsite, 
   stgfsite_2_desc LIKE type_t.chr500, 
   stgf004 LIKE stgf_t.stgf004, 
   stgf004_2_desc LIKE type_t.chr500, 
   stgf005 LIKE stgf_t.stgf005, 
   stgf005_2_desc LIKE type_t.chr500, 
   stgf013 LIKE stgf_t.stgf013, 
   stgf013_2_desc LIKE type_t.chr500, 
   stgf006 LIKE stgf_t.stgf006, 
   stgf006_2_desc LIKE type_t.chr500, 
   stgf014 LIKE stgf_t.stgf014, 
   stgf015 LIKE stgf_t.stgf015, 
   stgf017 LIKE stgf_t.stgf017, 
   stgf009 LIKE stgf_t.stgf009, 
   stgf010 LIKE stgf_t.stgf010, 
   stgf011 LIKE stgf_t.stgf011, 
   stgf018 LIKE stgf_t.stgf018, 
   stgf008 LIKE stgf_t.stgf008, 
   stgf012 LIKE stgf_t.stgf012
       END RECORD
 
 TYPE type_g_stgf4_d RECORD
       sel4 LIKE type_t.chr500, 
   stgfent LIKE stgf_t.stgfent, 
   stgf001 LIKE stgf_t.stgf001, 
   stgfsite LIKE stgf_t.stgfsite, 
   stgfsite_desc_2 LIKE type_t.chr500, 
   stgf013 LIKE stgf_t.stgf013, 
   stgf013_desc_2 LIKE type_t.chr500, 
   stgf014 LIKE stgf_t.stgf014, 
   stgf015 LIKE stgf_t.stgf015, 
   stgf017 LIKE stgf_t.stgf017, 
   stgf009 LIKE stgf_t.stgf009, 
   stgf010 LIKE stgf_t.stgf010, 
   stgf011 LIKE stgf_t.stgf011, 
   stgf018 LIKE stgf_t.stgf018, 
   stgf008 LIKE stgf_t.stgf008, 
   stgf012 LIKE stgf_t.stgf012
       END RECORD
 
 TYPE type_g_stgf5_d RECORD
       sel5 LIKE type_t.chr500, 
   stgfent LIKE stgf_t.stgfent, 
   stgf001 LIKE stgf_t.stgf001, 
   stgfsite LIKE stgf_t.stgfsite, 
   stgfsite_desc_3 LIKE type_t.chr500, 
   stgf014 LIKE stgf_t.stgf014, 
   stgf015 LIKE stgf_t.stgf015, 
   stgf017 LIKE stgf_t.stgf017, 
   stgf009 LIKE stgf_t.stgf009, 
   stgf010 LIKE stgf_t.stgf010, 
   stgf011 LIKE stgf_t.stgf011, 
   stgf018 LIKE stgf_t.stgf018, 
   stgf008 LIKE stgf_t.stgf008, 
   stgf012 LIKE stgf_t.stgf012
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_stgf2_d     DYNAMIC ARRAY OF type_g_stgf2_d
DEFINE g_stgf2_d_t   type_g_stgf2_d
 
DEFINE g_stgf3_d     DYNAMIC ARRAY OF type_g_stgf3_d
DEFINE g_stgf3_d_t   type_g_stgf3_d
 
DEFINE g_stgf4_d     DYNAMIC ARRAY OF type_g_stgf4_d
DEFINE g_stgf4_d_t   type_g_stgf4_d
 
DEFINE g_stgf5_d     DYNAMIC ARRAY OF type_g_stgf5_d
DEFINE g_stgf5_d_t   type_g_stgf5_d



#INPUT 条件
DEFINE stgf001_e           LIKE stgf_t.stgf001
DEFINE stgf001_s           LIKE stgf_t.stgf001

DEFINE g_sql_del           STRING
DEFINE g_sql_ins           STRING
DEFINE l_where           STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_stgf_d            DYNAMIC ARRAY OF type_g_stgf_d
DEFINE g_stgf_d_t          type_g_stgf_d
 
 
 
 
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
 
{<section id="astq506.main" >}
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
   DECLARE astq506_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq506_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq506_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq506 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq506_init()   
 
      #進入選單 Menu (="N")
      CALL astq506_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq506
      
   END IF 
   
   CLOSE astq506_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq506.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION astq506_init()
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
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('stgf014','6808')
   CALL cl_set_combo_scc('stgf015','6866')
   #151117-00002#1 20151118  add by beckxie---S
   CALL cl_set_combo_scc('b_stgf014','6808')   
   CALL cl_set_combo_scc('b_stgf015','6866')   
   CALL cl_set_combo_scc('b_stgf014_1','6808')   
   CALL cl_set_combo_scc('b_stgf015_1','6866')   
   CALL cl_set_combo_scc('b_stgf014_2','6808')   
   CALL cl_set_combo_scc('b_stgf015_2','6866')   
   CALL cl_set_combo_scc('b_stgf014_3','6808')   
   CALL cl_set_combo_scc('b_stgf015_3','6866')   
   CALL cl_set_combo_scc('b_stgf014_4','6808')   
   CALL cl_set_combo_scc('b_stgf015_4','6866')
   #151117-00002#1 20151118  add by beckxie---E
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL astq506_create_tmp() RETURNING l_success
   
   
   #end add-point
 
   CALL astq506_default_search()
END FUNCTION
 
{</section>}
 
{<section id="astq506.default_search" >}
PRIVATE FUNCTION astq506_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stgfsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stgf001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " stgf002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " stgf003 = '", g_argv[04], "' AND "
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
 
{<section id="astq506.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION astq506_ui_dialog() 
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
   DEFINE l_sys       LIKE type_t.num5   #151117-00002#1 20151126 add by beckxie
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
 
   
   CALL astq506_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stgf_d.clear()
 
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
 
         CALL astq506_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT stgf001_s,stgf001_e FROM stgf001_s,stgf001_e
          ATTRIBUTE(WITHOUT DEFAULTS)
              #151117-00002#1 20151118 add by beckxie---S
              BEFORE INPUT
                 #讓沒下查詢條件(沒進CONSTRUCT段)也能查的到資料
                 CALL cl_str_replace(g_wc,"1=2","1=1") RETURNING g_wc   
              #151117-00002#1 20151118 add by beckxie---E
              AFTER FIELD stgf001_s
                 IF NOT cl_null(stgf001_s) THEN
                    IF stgf001_s > stgf001_e THEN
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = "" 
                       LET g_errparam.code   = 'amr-00072' # 起始时间不可大于截止时间
                       LET g_errparam.popup  = TRUE 
                       CALL cl_err()
                       NEXT FIELD stgf001_s
                    END IF
                 END IF
              AFTER FIELD stgf001_e
                 IF NOT cl_null(stgf001_e) THEN
                    IF stgf001_e < stgf001_s THEN
                       INITIALIZE g_errparam TO NULL 
                       LET g_errparam.extend = "" 
                       LET g_errparam.code   = 'amm-00094' # 结束时间必须大于等于开始时间
                       LET g_errparam.popup  = TRUE 
                       CALL cl_err()
                       NEXT FIELD stgf001_e
                       END IF
                 END IF
       
            AFTER INPUT
               IF INT_FLAG THEN
                  RETURN
               END IF
         END INPUT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON stgf002,stgf003,stgf004,stgf005,stgf006,stgf007,stgfsite,
                                   stgf013,stgf014,stgf015,stfa050                                                                 #add by dengdd 150922
         
         
         
         #ON ACTION controlp INFIELD stgf001
           
            
         ON ACTION controlp INFIELD stgf002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgf002  #顯示到畫面上
            NEXT FIELD stgf002                     #返回原欄位
    
         ON ACTION controlp INFIELD stgf003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgf003  #顯示到畫面上
            NEXT FIELD stgf003                     #返回原欄位
    
         ON ACTION controlp INFIELD stgf004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgf004  #顯示到畫面上
            NEXT FIELD stgf004                     #返回原欄位
    
         ON ACTION controlp INFIELD stgf005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#2 -S
            #CALL q_pmaa001()                           #呼叫開窗            
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#2 -E
            DISPLAY g_qryparam.return1 TO stgf005  #顯示到畫面上
            NEXT FIELD stgf005                     #返回原欄位
    
         ON ACTION controlp INFIELD stgf006
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgf006  #顯示到畫面上
            NEXT FIELD stgf006                     #返回原欄位
    
         ON ACTION controlp INFIELD stgf007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgf007  #顯示到畫面上
            NEXT FIELD stgf007                     #返回原欄位
            
         ON ACTION controlp INFIELD stgfsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stgfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stgfsite  #顯示到畫面上
            NEXT FIELD stgfsite                     #返回原欄位
            
            
         ON ACTION controlp INFIELD stgf013
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #151117-00002#1 20151126 add by beckxie---S
            #取得品類管理層級
            CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys
            LET g_qryparam.arg1 = l_sys
            CALL q_rtax001_3()
            #151117-00002#1 20151126 add by beckxie---E
            #CALL q_rtax001()   #151117-00002#1 20151126 mark by beckxie
            DISPLAY g_qryparam.return1 TO stgf013  #顯示到畫面上
            NEXT FIELD stgf013                     #返回原欄位
            
         END CONSTRUCT
         
         
         #end add-point
     
         DISPLAY ARRAY g_stgf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL astq506_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq506_b_fill2()
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
        #促销销售汇总        
        DISPLAY ARRAY g_stgf2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL astq506_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq506_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
         END DISPLAY
         
         #按专柜汇总页签
         DISPLAY ARRAY g_stgf3_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               CALL astq506_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq506_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
         END DISPLAY
         
         #按管理品类汇总
         DISPLAY ARRAY g_stgf4_d TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx
               CALL astq506_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq506_b_fill2()
               LET g_action_choice = lc_action_choice_old

         END DISPLAY
         
         #按活动力度汇总
         DISPLAY ARRAY g_stgf5_d TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac = g_detail_idx
               CALL astq506_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq506_b_fill2()
               LET g_action_choice = lc_action_choice_old

         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq506_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            
            LET stgf001_s=g_today
            LET stgf001_e=g_today
            DISPLAY stgf001_s,stgf001_e TO stgf001_s,stgf001_e
            #end add-point
            NEXT FIELD stgf001_s
 
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
            #LET g_wc=" 1=1 "   #151117-00002#1 20151118 mark by beckxie
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq506_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_stgf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL astq506_b_fill()
 
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
            CALL astq506_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq506_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq506_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq506_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_stgf_d.getLength()
               LET g_stgf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_stgf_d.getLength()
               LET g_stgf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_stgf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stgf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_stgf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stgf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astq506_filter()
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
 
{<section id="astq506.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq506_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'stgfsite') RETURNING l_where
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
 
   CALL g_stgf_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '','',stgf001,stgfsite,'',stgf002,'',stgf003,'',stgf004,'',stgf005, 
       '',stgf013,'',stgf006,'',stgf007,'',stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008, 
       stgf012  ,DENSE_RANK() OVER( ORDER BY stgf_t.stgfsite,stgf_t.stgf001,stgf_t.stgf002,stgf_t.stgf003) AS RANK FROM stgf_t", 
 
 
 
                     "",
                     " WHERE stgfent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stgf_t"),
                     " ORDER BY stgf_t.stgfsite,stgf_t.stgf001,stgf_t.stgf002,stgf_t.stgf003"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
#mark by dengdd 150922-----str--------------------------------------------------------------------------
#LET ls_wc = ls_wc CLIPPED," AND ",l_where

#   LET ls_sql_rank = "SELECT  UNIQUE          'N',stgf001,stgf002,imaal003 stgf002_desc,stgf003,                                                    ",
#                     "      inayl003 stgf003_desc,stgf004,mhael023 stgf004_desc,stgf005,pmaal004 stgf005_desc,                                      ",
#                     "                    stgf006,mhabl004 stgf006_desc,stgf007,rtaxl003 stgf007_desc,stgf008,                                      ",
#                     "                    stgf009,stgf010,stgf011,stgf012,stgfsite,                                                                 ",
#                     "     ooefl003 stgfsite_desc,                                                                                                  ",
#                     "       DENSE_RANK() OVER( ORDER BY stgf_t.stgfsite,stgf_t.stgf001,stgf_t.stgf002,stgf_t.stgf003) AS RANK                      ",
#                     "  FROM stgf_t                                                                                                                 ",
#                     "       LEFT JOIN imaal_t ON stgfent=imaalent AND stgf002=imaal001 AND imaal002 = '"||g_dlang||"'                              ",
#                     "       LEFT JOIN inayl_t ON stgfent=inaylent AND stgf003=inayl001 AND inayl002 = '"||g_dlang||"'                              ",
#                     "       LEFT JOIN mhae_t  ON stgfent= mhaeent AND stgfsite = mhaesite AND stgf004=mhae001                                      ",
#                     "       LEFT JOIN mhael_t ON mhaeent = mhaelent AND mhaesite =mhaelsite AND mhae001 = mhael001 AND mhael022 ='"||g_dlang||"'   ",
#                     "       LEFT JOIN mhabl_t ON mhaeent = mhablent AND mhae020=mhabl001 AND mhae021 = mhabl002 AND mhabl003 = '"||g_dlang||"'     ",
#                     "       LEFT JOIN pmaal_t ON stgfent=pmaalent AND stgf005=pmaal001 AND pmaal002 = '"||g_dlang||"'                              ",
#                     "       LEFT JOIN rtaxl_t ON stgfent=rtaxlent AND stgf007=rtaxl001 AND rtaxl002 = '"||g_dlang||"'                              ",
#                     "       LEFT JOIN ooefl_t ON stgfent=ooeflent AND stgfsite=ooefl001 AND ooefl002 = '"||g_dlang||"'                             ",
#                     
#                     "",
#                     " WHERE stgfent= ? AND 1=1 AND ", ls_wc
#   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stgf_t"),
#                     " ORDER BY stgf_t.stgfsite,stgf_t.stgf001,stgf_t.stgf002,stgf_t.stgf003"
#mark by dengdd 150922-----end----------------------------------------------------------------------------

#add by dengdd 150922------str----------------------------------------------------------------------------
    LET ls_wc = ls_wc CLIPPED," AND ",l_where
    
    LET ls_sql_rank="SELECT  UNIQUE 'N',stgfent,stgf001,stgfsite,t8.ooefl003,stgf002,t1.imaal003,stgf003,t2.inayl003, ",
                     "       stgf004,t4.mhael023,stgf005,t6.pmaal004,stgf013,t9.rtaxl003,stgf006,t5.mhabl004,",
                     "       stgf007,t7.rtaxl003,stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008,stgf012 ",
#                     "       DENSE_RANK() OVER( ORDER BY t0.stgfsite,t0.stgf001,t0.stgf002,t0.stgf003) AS RANK ",
                     "  FROM stgf_t t0 ",
                     "       LEFT JOIN stfa_t  t10 ON t0.stgfent=t10.stfaent AND t0.stgfsite = t10.stfasite AND t0.stgf004=t10.stfa005 ", #add by dengdd 151012
                     "       LEFT JOIN imaal_t t1 ON t0.stgfent=t1.imaalent AND t0.stgf002=t1.imaal001 AND t1.imaal002 = '"||g_dlang||"' ",
                     "       LEFT JOIN inayl_t t2 ON t0.stgfent=t2.inaylent AND t0.stgf003=t2.inayl001 AND t2.inayl002 = '"||g_dlang||"' ",
                     "       LEFT JOIN mhae_t  t3 ON t0.stgfent=t3.mhaeent  AND t0.stgfsite=t3.mhaesite AND t0.stgf004=t3.mhae001 AND t0.stgf006=t3.mhae021",
                     "       LEFT JOIN mhael_t t4 ON t3.mhaeent=t4.mhaelent AND t3.mhaesite=t4.mhaelsite AND t3.mhae001 = t4.mhael001 AND t4.mhael022 ='"||g_dlang||"' ",
                     "       LEFT JOIN mhabl_t t5 ON t3.mhaeent=t5.mhablent AND t3.mhae021 = t5.mhabl002 AND t5.mhabl003 = '"||g_dlang||"' ",
                     "       LEFT JOIN pmaal_t t6 ON t0.stgfent=t6.pmaalent AND t0.stgf005=t6.pmaal001 AND t6.pmaal002 = '"||g_dlang||"' ",
                     "       LEFT JOIN rtaxl_t t7 ON t0.stgfent=t7.rtaxlent AND t0.stgf007=t7.rtaxl001 AND t7.rtaxl002 = '"||g_dlang||"' ",
                     "       LEFT JOIN ooefl_t t8 ON t0.stgfent=t8.ooeflent AND t0.stgfsite=t8.ooefl001 AND t8.ooefl002 = '"||g_dlang||"' ",
                     "       LEFT JOIN rtaxl_t t9 ON t0.stgfent=t9.rtaxlent AND t0.stgf013=t9.rtaxl001 AND t9.rtaxl002 = '"||g_dlang||"' ",
                     " WHERE stgfent= ? AND 1=1 AND ", ls_wc,
                     "   AND stgf001 BETWEEN to_date('",stgf001_s,"','yy/mm/dd') ",
                     "   AND to_date('",stgf001_e,"','yy/mm/dd') "
                     
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stgf_t"),
                     " ORDER BY t0.stgfsite,t0.stgf001,t0.stgf002,t0.stgf003"
                     
    #清空临时表
    LET g_sql_del = "DELETE FROM astq506_tmp "
    EXECUTE IMMEDIATE g_sql_del
    
    #数据插入临时表
    LET g_sql_ins = " INSERT INTO astq506_tmp ",ls_sql_rank         
    PREPARE ins_tmp FROM g_sql_ins
    EXECUTE ins_tmp USING g_enterprise

    #从临时表取数，填充g_debg_d
    LET ls_sql_rank = " SELECT UNIQUE sel,enterprise,stgf001,site,ooefl003,stgf002,imaal003,stgf003,inayl003, ",
                      "         stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
                      "         stgf007,rtaxl003_2,stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008,stgf012, ",
                      "         DENSE_RANK() OVER( ORDER BY site,stgf001,stgf002,stgf003) AS RANK ",
                      "   FROM astq506_tmp ",
                      "  WHERE enterprise = ? ",
                      " ORDER BY site,stgf001,stgf002,stgf003"
#add by dengdd 150922------end---------------------------------------------------------------------------
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
 
   LET g_sql = "SELECT '','',stgf001,stgfsite,'',stgf002,'',stgf003,'',stgf004,'',stgf005,'',stgf013, 
       '',stgf006,'',stgf007,'',stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008,stgf012", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT   sel,enterprise,stgf001,site,ooefl003,stgf002,imaal003,stgf003,inayl003, ",
               "         stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
               "         stgf007,rtaxl003_2,stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008,stgf012 ",
               "  FROM (",ls_sql_rank,")                                   ",
               " WHERE RANK >= ",g_pagestart,
               " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq506_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq506_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_stgf_d[l_ac].sel,g_stgf_d[l_ac].stgfent,g_stgf_d[l_ac].stgf001,g_stgf_d[l_ac].stgfsite, 
       g_stgf_d[l_ac].stgfsite_desc,g_stgf_d[l_ac].stgf002,g_stgf_d[l_ac].stgf002_desc,g_stgf_d[l_ac].stgf003, 
       g_stgf_d[l_ac].stgf003_desc,g_stgf_d[l_ac].stgf004,g_stgf_d[l_ac].stgf004_desc,g_stgf_d[l_ac].stgf005, 
       g_stgf_d[l_ac].stgf005_desc,g_stgf_d[l_ac].stgf013,g_stgf_d[l_ac].stgf013_desc,g_stgf_d[l_ac].stgf006, 
       g_stgf_d[l_ac].stgf006_desc,g_stgf_d[l_ac].stgf007,g_stgf_d[l_ac].stgf007_desc,g_stgf_d[l_ac].stgf014, 
       g_stgf_d[l_ac].stgf015,g_stgf_d[l_ac].stgf017,g_stgf_d[l_ac].stgf009,g_stgf_d[l_ac].stgf010,g_stgf_d[l_ac].stgf011, 
       g_stgf_d[l_ac].stgf018,g_stgf_d[l_ac].stgf008,g_stgf_d[l_ac].stgf012
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
 
      CALL astq506_detail_show("'1'")
 
      CALL astq506_stgf_t_mask()
 
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
   CALL astq506_b_fill3()
   CALL astq506_b_fill4()
   CALL astq506_b_fill5()
   CALL astq506_b_fill6()
   #end add-point
 
   CALL g_stgf_d.deleteElement(g_stgf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_stgf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE astq506_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq506_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq506_detail_action_trans()
 
   LET l_ac = 1
   IF g_stgf_d.getLength() > 0 THEN
      CALL astq506_b_fill2()
   END IF
 
      CALL astq506_filter_show('stgf001','b_stgf001')
   CALL astq506_filter_show('stgfsite','b_stgfsite')
   CALL astq506_filter_show('stgf002','b_stgf002')
   CALL astq506_filter_show('stgf003','b_stgf003')
   CALL astq506_filter_show('stgf004','b_stgf004')
   CALL astq506_filter_show('stgf005','b_stgf005')
   CALL astq506_filter_show('stgf013','b_stgf013')
   CALL astq506_filter_show('stgf006','b_stgf006')
   CALL astq506_filter_show('stgf007','b_stgf007')
   CALL astq506_filter_show('stgf014','b_stgf014')
   CALL astq506_filter_show('stgf015','b_stgf015')
   CALL astq506_filter_show('stgf017','b_stgf017')
   CALL astq506_filter_show('stgf009','b_stgf009')
   CALL astq506_filter_show('stgf010','b_stgf010')
   CALL astq506_filter_show('stgf011','b_stgf011')
   CALL astq506_filter_show('stgf018','b_stgf018')
   CALL astq506_filter_show('stgf008','b_stgf008')
   CALL astq506_filter_show('stgf012','b_stgf012')
 
 
END FUNCTION
 
{</section>}
 
{<section id="astq506.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq506_b_fill2()
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
 
{<section id="astq506.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq506_detail_show(ps_page)
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
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf002
#            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf003
#            LET ls_sql = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf003_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf003_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf004
#            LET ls_sql = "SELECT mhael023 FROM mhael_t WHERE mhaelent='"||g_enterprise||"' AND mhael001=? AND mhael022='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf004_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf004_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf005
#            LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf006
#            LET ls_sql = "SELECT mhabl004 FROM mhabl_t WHERE mhablent='"||g_enterprise||"' AND mhabl002=? AND mhabl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgf007
#            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgf007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgf007_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_stgf_d[l_ac].stgfsite
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_stgf_d[l_ac].stgfsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_stgf_d[l_ac].stgfsite_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq506.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION astq506_filter()
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
      CONSTRUCT g_wc_filter ON stgf001,stgfsite,stgf002,stgf003,stgf004,stgf005,stgf013,stgf006,stgf007, 
          stgf014,stgf015,stgf017,stgf009,stgf010,stgf011,stgf018,stgf008,stgf012
                          FROM s_detail1[1].b_stgf001,s_detail1[1].b_stgfsite,s_detail1[1].b_stgf002, 
                              s_detail1[1].b_stgf003,s_detail1[1].b_stgf004,s_detail1[1].b_stgf005,s_detail1[1].b_stgf013, 
                              s_detail1[1].b_stgf006,s_detail1[1].b_stgf007,s_detail1[1].b_stgf014,s_detail1[1].b_stgf015, 
                              s_detail1[1].b_stgf017,s_detail1[1].b_stgf009,s_detail1[1].b_stgf010,s_detail1[1].b_stgf011, 
                              s_detail1[1].b_stgf018,s_detail1[1].b_stgf008,s_detail1[1].b_stgf012
 
         BEFORE CONSTRUCT
                     DISPLAY astq506_filter_parser('stgf001') TO s_detail1[1].b_stgf001
            DISPLAY astq506_filter_parser('stgfsite') TO s_detail1[1].b_stgfsite
            DISPLAY astq506_filter_parser('stgf002') TO s_detail1[1].b_stgf002
            DISPLAY astq506_filter_parser('stgf003') TO s_detail1[1].b_stgf003
            DISPLAY astq506_filter_parser('stgf004') TO s_detail1[1].b_stgf004
            DISPLAY astq506_filter_parser('stgf005') TO s_detail1[1].b_stgf005
            DISPLAY astq506_filter_parser('stgf013') TO s_detail1[1].b_stgf013
            DISPLAY astq506_filter_parser('stgf006') TO s_detail1[1].b_stgf006
            DISPLAY astq506_filter_parser('stgf007') TO s_detail1[1].b_stgf007
            DISPLAY astq506_filter_parser('stgf014') TO s_detail1[1].b_stgf014
            DISPLAY astq506_filter_parser('stgf015') TO s_detail1[1].b_stgf015
            DISPLAY astq506_filter_parser('stgf017') TO s_detail1[1].b_stgf017
            DISPLAY astq506_filter_parser('stgf009') TO s_detail1[1].b_stgf009
            DISPLAY astq506_filter_parser('stgf010') TO s_detail1[1].b_stgf010
            DISPLAY astq506_filter_parser('stgf011') TO s_detail1[1].b_stgf011
            DISPLAY astq506_filter_parser('stgf018') TO s_detail1[1].b_stgf018
            DISPLAY astq506_filter_parser('stgf008') TO s_detail1[1].b_stgf008
            DISPLAY astq506_filter_parser('stgf012') TO s_detail1[1].b_stgf012
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<stgfent>>----
         #----<<b_stgf001>>----
         #Ctrlp:construct.c.filter.page1.b_stgf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf001
            #add-point:ON ACTION controlp INFIELD b_stgf001 name="construct.c.filter.page1.b_stgf001"
            
            #END add-point
 
 
         #----<<b_stgfsite>>----
         #Ctrlp:construct.c.page1.b_stgfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgfsite
            #add-point:ON ACTION controlp INFIELD b_stgfsite name="construct.c.filter.page1.b_stgfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stgfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgfsite  #顯示到畫面上
            NEXT FIELD b_stgfsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgfsite_desc>>----
         #----<<b_stgf002>>----
         #Ctrlp:construct.c.page1.b_stgf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf002
            #add-point:ON ACTION controlp INFIELD b_stgf002 name="construct.c.filter.page1.b_stgf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgf002  #顯示到畫面上
            NEXT FIELD b_stgf002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf002_desc>>----
         #----<<b_stgf003>>----
         #Ctrlp:construct.c.page1.b_stgf003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf003
            #add-point:ON ACTION controlp INFIELD b_stgf003 name="construct.c.filter.page1.b_stgf003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgf003  #顯示到畫面上
            NEXT FIELD b_stgf003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf003_desc>>----
         #----<<b_stgf004>>----
         #Ctrlp:construct.c.page1.b_stgf004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf004
            #add-point:ON ACTION controlp INFIELD b_stgf004 name="construct.c.filter.page1.b_stgf004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgf004  #顯示到畫面上
            NEXT FIELD b_stgf004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf004_desc>>----
         #----<<b_stgf005>>----
         #Ctrlp:construct.c.page1.b_stgf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf005
            #add-point:ON ACTION controlp INFIELD b_stgf005 name="construct.c.filter.page1.b_stgf005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#2 -S
            #CALL q_pmaa001()                           #呼叫開窗            
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#2 -E
            DISPLAY g_qryparam.return1 TO b_stgf005  #顯示到畫面上
            NEXT FIELD b_stgf005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf005_desc>>----
         #----<<b_stgf013>>----
         #Ctrlp:construct.c.filter.page1.b_stgf013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf013
            #add-point:ON ACTION controlp INFIELD b_stgf013 name="construct.c.filter.page1.b_stgf013"
            
            #END add-point
 
 
         #----<<b_stgf013_desc>>----
         #----<<b_stgf006>>----
         #Ctrlp:construct.c.page1.b_stgf006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf006
            #add-point:ON ACTION controlp INFIELD b_stgf006 name="construct.c.filter.page1.b_stgf006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhab002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgf006  #顯示到畫面上
            NEXT FIELD b_stgf006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf006_desc>>----
         #----<<b_stgf007>>----
         #Ctrlp:construct.c.page1.b_stgf007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf007
            #add-point:ON ACTION controlp INFIELD b_stgf007 name="construct.c.filter.page1.b_stgf007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stgf007  #顯示到畫面上
            NEXT FIELD b_stgf007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stgf007_desc>>----
         #----<<b_stgf014>>----
         #Ctrlp:construct.c.filter.page1.b_stgf014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf014
            #add-point:ON ACTION controlp INFIELD b_stgf014 name="construct.c.filter.page1.b_stgf014"
            
            #END add-point
 
 
         #----<<b_stgf015>>----
         #Ctrlp:construct.c.filter.page1.b_stgf015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf015
            #add-point:ON ACTION controlp INFIELD b_stgf015 name="construct.c.filter.page1.b_stgf015"
            
            #END add-point
 
 
         #----<<b_stgf017>>----
         #Ctrlp:construct.c.filter.page1.b_stgf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf017
            #add-point:ON ACTION controlp INFIELD b_stgf017 name="construct.c.filter.page1.b_stgf017"
            
            #END add-point
 
 
         #----<<b_stgf009>>----
         #Ctrlp:construct.c.filter.page1.b_stgf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf009
            #add-point:ON ACTION controlp INFIELD b_stgf009 name="construct.c.filter.page1.b_stgf009"
            
            #END add-point
 
 
         #----<<b_stgf010>>----
         #Ctrlp:construct.c.filter.page1.b_stgf010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf010
            #add-point:ON ACTION controlp INFIELD b_stgf010 name="construct.c.filter.page1.b_stgf010"
            
            #END add-point
 
 
         #----<<b_stgf011>>----
         #Ctrlp:construct.c.filter.page1.b_stgf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf011
            #add-point:ON ACTION controlp INFIELD b_stgf011 name="construct.c.filter.page1.b_stgf011"
            
            #END add-point
 
 
         #----<<b_stgf018>>----
         #Ctrlp:construct.c.filter.page1.b_stgf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf018
            #add-point:ON ACTION controlp INFIELD b_stgf018 name="construct.c.filter.page1.b_stgf018"
            
            #END add-point
 
 
         #----<<b_stgf008>>----
         #Ctrlp:construct.c.filter.page1.b_stgf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf008
            #add-point:ON ACTION controlp INFIELD b_stgf008 name="construct.c.filter.page1.b_stgf008"
            
            #END add-point
 
 
         #----<<b_stgf012>>----
         #Ctrlp:construct.c.filter.page1.b_stgf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stgf012
            #add-point:ON ACTION controlp INFIELD b_stgf012 name="construct.c.filter.page1.b_stgf012"
            
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
 
      CALL astq506_filter_show('stgf001','b_stgf001')
   CALL astq506_filter_show('stgfsite','b_stgfsite')
   CALL astq506_filter_show('stgf002','b_stgf002')
   CALL astq506_filter_show('stgf003','b_stgf003')
   CALL astq506_filter_show('stgf004','b_stgf004')
   CALL astq506_filter_show('stgf005','b_stgf005')
   CALL astq506_filter_show('stgf013','b_stgf013')
   CALL astq506_filter_show('stgf006','b_stgf006')
   CALL astq506_filter_show('stgf007','b_stgf007')
   CALL astq506_filter_show('stgf014','b_stgf014')
   CALL astq506_filter_show('stgf015','b_stgf015')
   CALL astq506_filter_show('stgf017','b_stgf017')
   CALL astq506_filter_show('stgf009','b_stgf009')
   CALL astq506_filter_show('stgf010','b_stgf010')
   CALL astq506_filter_show('stgf011','b_stgf011')
   CALL astq506_filter_show('stgf018','b_stgf018')
   CALL astq506_filter_show('stgf008','b_stgf008')
   CALL astq506_filter_show('stgf012','b_stgf012')
 
 
   CALL astq506_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq506.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION astq506_filter_parser(ps_field)
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
 
{<section id="astq506.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION astq506_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq506_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="astq506.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq506_detail_action_trans()
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
 
{<section id="astq506.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq506_detail_index_setting()
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
            IF g_stgf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stgf_d.getLength() AND g_stgf_d.getLength() > 0
            LET g_detail_idx = g_stgf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stgf_d.getLength() THEN
               LET g_detail_idx = g_stgf_d.getLength()
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
 
{<section id="astq506.mask_functions" >}
 &include "erp/ast/astq506_mask.4gl"
 
{</section>}
 
{<section id="astq506.other_function" readonly="Y" >}

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
PRIVATE FUNCTION astq506_create_tmp()
DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT astq506_drop_tmp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE astq506_tmp(
          sel            VARCHAR(1),
          enterprise     VARCHAR(10),
          stgf001        DATE,          
          site           VARCHAR(10),          
          ooefl003       VARCHAR(500),
          stgf002        VARCHAR(40),
          imaal003       VARCHAR(255),
          stgf003        VARCHAR(10),
          inayl003       VARCHAR(500),
          stgf004        VARCHAR(20),
          mhael023       VARCHAR(80),
          stgf005        VARCHAR(10),
          pmaal004       VARCHAR(80),
          stgf013        VARCHAR(10),
          rtaxl003_1     VARCHAR(500),
          stgf006        VARCHAR(10),
          mhabl004       VARCHAR(500),
          stgf007        VARCHAR(10),
          rtaxl003_2     VARCHAR(500),
          stgf014        VARCHAR(10),
          stgf015        VARCHAR(10),
          stgf017        VARCHAR(10),
          stgf009        DECIMAL(20,6),
          stgf010        DECIMAL(20,6),
          stgf011        DECIMAL(20,6),
          stgf018        DECIMAL(20,6),
          stgf008        DECIMAL(20,6),
          stgf012        DECIMAL(20,6)
     )
  
   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create astq506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
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
PRIVATE FUNCTION astq506_drop_tmp()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE astq506_tmp

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop astq506_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
END FUNCTION

################################################################################
# Descriptions...: 促销销售情况汇总
# Memo...........:
# Usage..........: CALL astq506_b_fill3()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/9/24 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astq506_b_fill3()
DEFINE li_ac           LIKE type_t.num10
DEFINE ls_wc           STRING
DEFINE l_pid           LIKE type_t.chr50
DEFINE ls_sql_rank     STRING

   
    
   CALL g_stgf2_d.clear()
   

   LET ls_sql_rank = " SELECT UNIQUE sel,enterprise,MIN(stgf001) stgf001_s,MAX(stgf001) stgf001_e,site,ooefl003,stgf002,imaal003,stgf003,inayl003, ",
                     "         stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
                     "         stgf007,rtaxl003_2,stgf014,stgf015,stgf017,sum(stgf009) l_stgf009,sum(stgf010) l_stgf010,sum(stgf011) l_stgf011,
                               sum(stgf018) l_stgf018,stgf008,sum(stgf012) l_stgf012, ",
                     "         DENSE_RANK() OVER( ORDER BY site,stgf002,stgf003,stgf004,stgf005,stgf013,stgf006,stgf007,stgf014,
                                                                stgf015,stgf017,stgf008) AS RANK ",
                     "   FROM astq506_tmp ",
                     "  WHERE enterprise = ? ",
                     " GROUP BY sel,enterprise,site,ooefl003,stgf002,imaal003,stgf003,inayl003,stgf004,mhael023,
                                stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,stgf007,rtaxl003_2,stgf014,stgf015,stgf017,stgf008 ",
                     " ORDER BY site,stgf002,stgf003,stgf004,stgf005,stgf013,stgf006,stgf007,stgf014,stgf015,stgf017,stgf008 "
                    
                     
     
    LET g_sql = "SELECT   sel,enterprise,stgf001_s,stgf001_e,site,ooefl003,stgf002,imaal003,stgf003,inayl003, ",
                      "         stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
                      "         stgf007,rtaxl003_2,stgf014,stgf015,stgf017,l_stgf009,l_stgf010,l_stgf011,l_stgf018,stgf008,l_stgf012 ",
                      "  FROM (",ls_sql_rank,")                                   ",
                      " WHERE RANK >= ",g_pagestart,
                      " AND RANK < ",g_pagestart + g_num_in_page

 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sel_stgf_sum FROM g_sql
   DECLARE sel_stgf_sum_cs  CURSOR FOR sel_stgf_sum   
   

   LET l_ac = 1
   
   OPEN sel_stgf_sum_cs USING g_enterprise
   
   FOREACH sel_stgf_sum_cs INTO g_stgf2_d[l_ac].sel2,
                            g_stgf2_d[l_ac].stgfent,
                            g_stgf2_d[l_ac].l_stgf001_s,
                            g_stgf2_d[l_ac].l_stgf001_e,
                            g_stgf2_d[l_ac].stgfsite,         
                            g_stgf2_d[l_ac].stgfsite_1_desc, 
                            g_stgf2_d[l_ac].stgf002,         
                            g_stgf2_d[l_ac].stgf002_1_desc,  
                            g_stgf2_d[l_ac].stgf003,         
                            g_stgf2_d[l_ac].stgf003_1_desc,  
                            g_stgf2_d[l_ac].stgf004,         
                            g_stgf2_d[l_ac].stgf004_1_desc,  
                            g_stgf2_d[l_ac].stgf005,         
                            g_stgf2_d[l_ac].stgf005_1_desc, 
                            g_stgf2_d[l_ac].stgf013,         
                            g_stgf2_d[l_ac].stgf013_1_desc,  
                            g_stgf2_d[l_ac].stgf006,         
                            g_stgf2_d[l_ac].stgf006_1_desc,  
                            g_stgf2_d[l_ac].stgf007,        
                            g_stgf2_d[l_ac].stgf007_1_desc, 
                            g_stgf2_d[l_ac].stgf014,        
                            g_stgf2_d[l_ac].stgf015,          
                            g_stgf2_d[l_ac].stgf017, 
                            g_stgf2_d[l_ac].stgf009, 
                            g_stgf2_d[l_ac].stgf010, 
                            g_stgf2_d[l_ac].stgf011, 
                            g_stgf2_d[l_ac].stgf018, 
                            g_stgf2_d[l_ac].stgf008, 
                            g_stgf2_d[l_ac].stgf012
   
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "FOREACH:"
              LET g_errparam.popup = TRUE
              CALL cl_err()
             
              EXIT FOREACH
           END IF
           
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
   
   
   LET g_detail_cnt = l_ac-1
   
   CALL g_stgf2_d.deleteElement(g_stgf2_d.getLength())
   
   DISPLAY ARRAY g_stgf2_d TO s_detail2.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   CLOSE sel_stgf_sum_cs
   
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
   
END FUNCTION

################################################################################
# Descriptions...: 按专柜汇总
# Memo...........:
# Usage..........: CALL astq506_b_fill4()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/9/24 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astq506_b_fill4()
DEFINE li_ac           LIKE type_t.num10
DEFINE ls_wc           STRING
DEFINE l_pid           LIKE type_t.chr50
DEFINE ls_sql_rank     STRING

   
    
   CALL g_stgf3_d.clear()
   

   LET ls_sql_rank = " SELECT UNIQUE sel,enterprise,stgf001,site,ooefl003, ",
                     "         stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
                     "         stgf014,stgf015,stgf017,sum(stgf009) l_stgf009,sum(stgf010) l_stgf010,sum(stgf011) l_stgf011,
                               sum(stgf018) l_stgf018,stgf008,sum(stgf012) l_stgf012, ",
                     "         DENSE_RANK() OVER( ORDER BY site,stgf001,stgf004,stgf005,stgf013,stgf006,stgf014,
                                                                stgf015,stgf017,stgf008) AS RANK ",
                     "   FROM astq506_tmp ",
                     "  WHERE enterprise = ? ",
                     " GROUP BY sel,enterprise,stgf001,site,ooefl003,stgf004,mhael023,stgf005,pmaal004,
                                stgf013,rtaxl003_1,stgf006,mhabl004,stgf014,stgf015,stgf017,stgf008 ",
                     " ORDER BY site,stgf001,stgf004,stgf005,stgf013,stgf006,stgf014,stgf015,stgf017,stgf008 "
                    
 
    LET g_sql = "SELECT   sel,enterprise,stgf001,site,ooefl003, ",
                      "   stgf004,mhael023,stgf005,pmaal004,stgf013,rtaxl003_1,stgf006,mhabl004,",
                      "   stgf014,stgf015,stgf017,l_stgf009,l_stgf010,l_stgf011,l_stgf018,stgf008,l_stgf012 ",
                      "  FROM (",ls_sql_rank,")                                   ",
                      " WHERE RANK >= ",g_pagestart,
                      " AND RANK < ",g_pagestart + g_num_in_page

 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sel_stgf_sum1 FROM g_sql
   DECLARE sel_stgf_sum_cs1  CURSOR FOR sel_stgf_sum1 
   

   LET l_ac = 1
   
   OPEN sel_stgf_sum_cs1 USING g_enterprise
   
   FOREACH sel_stgf_sum_cs1 INTO g_stgf3_d[l_ac].sel3,        
                                 g_stgf3_d[l_ac].stgfent,    
                                 g_stgf3_d[l_ac].stgf001,                                 
                                 g_stgf3_d[l_ac].stgfsite,          
                                 g_stgf3_d[l_ac].stgfsite_2_desc,                            
                                 g_stgf3_d[l_ac].stgf004,       
                                 g_stgf3_d[l_ac].stgf004_2_desc, 
                                 g_stgf3_d[l_ac].stgf005,            
                                 g_stgf3_d[l_ac].stgf005_2_desc, 
                                 g_stgf3_d[l_ac].stgf013,        
                                 g_stgf3_d[l_ac].stgf013_2_desc, 
                                 g_stgf3_d[l_ac].stgf006,           
                                 g_stgf3_d[l_ac].stgf006_2_desc,
                                 g_stgf3_d[l_ac].stgf014,        
                                 g_stgf3_d[l_ac].stgf015,          
                                 g_stgf3_d[l_ac].stgf017, 
                                 g_stgf3_d[l_ac].stgf009, 
                                 g_stgf3_d[l_ac].stgf010, 
                                 g_stgf3_d[l_ac].stgf011, 
                                 g_stgf3_d[l_ac].stgf018, 
                                 g_stgf3_d[l_ac].stgf008, 
                                 g_stgf3_d[l_ac].stgf012
   
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "FOREACH:"
              LET g_errparam.popup = TRUE
              CALL cl_err()
             
              EXIT FOREACH
           END IF
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
   
   
   LET g_detail_cnt = l_ac-1
   
   CALL g_stgf3_d.deleteElement(g_stgf3_d.getLength())
   
   DISPLAY ARRAY g_stgf3_d TO s_detail3.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   CLOSE sel_stgf_sum_cs1
   
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   
END FUNCTION

################################################################################
# Descriptions...: 按管理品类汇总
# Memo...........:
# Usage..........: CALL astq506_b_fill5()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/9/24 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astq506_b_fill5()
DEFINE li_ac           LIKE type_t.num10
DEFINE ls_wc           STRING
DEFINE l_pid           LIKE type_t.chr50
DEFINE ls_sql_rank     STRING


   CALL g_stgf4_d.clear()
   

   LET ls_sql_rank = " SELECT UNIQUE sel,enterprise,stgf001,site,ooefl003,stgf013,rtaxl003_1, ",
                     "         stgf014,stgf015,stgf017,sum(stgf009) l_stgf009,sum(stgf010) l_stgf010,sum(stgf011) l_stgf011,
                               sum(stgf018) l_stgf018,stgf008,sum(stgf012) l_stgf012, ",
                     "         DENSE_RANK() OVER( ORDER BY site,stgf001,stgf013,stgf014,stgf015,stgf017,stgf008) AS RANK ",
                     "   FROM astq506_tmp ",
                     "  WHERE enterprise = ? ",
                     " GROUP BY sel,enterprise,stgf001,site,ooefl003,stgf013,rtaxl003_1,stgf014,stgf015,stgf017,stgf008 ",
                     " ORDER BY site,stgf001,stgf013,stgf014,stgf015,stgf017,stgf008 "
                     
 
    LET g_sql = "SELECT   sel,enterprise,stgf001,site,ooefl003,stgf013,rtaxl003_1, ",
                      "   stgf014,stgf015,stgf017,l_stgf009,l_stgf010,l_stgf011,l_stgf018,stgf008,l_stgf012 ",
                      "  FROM (",ls_sql_rank,")                                   ",
                      " WHERE RANK >= ",g_pagestart,
                      " AND RANK < ",g_pagestart + g_num_in_page

 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sel_stgf_sum2 FROM g_sql
   DECLARE sel_stgf_sum_cs2  CURSOR FOR sel_stgf_sum2
   

   LET l_ac = 1
   
   OPEN sel_stgf_sum_cs2 USING g_enterprise
   
   FOREACH sel_stgf_sum_cs2 INTO g_stgf4_d[l_ac].sel4,        
                                 g_stgf4_d[l_ac].stgfent,    
                                 g_stgf4_d[l_ac].stgf001,                                 
                                 g_stgf4_d[l_ac].stgfsite,          
                                 g_stgf4_d[l_ac].stgfsite_desc_2,                            
                                 g_stgf4_d[l_ac].stgf013,       
                                 g_stgf4_d[l_ac].stgf013_desc_2, 
                                 g_stgf4_d[l_ac].stgf014,   
                                 g_stgf4_d[l_ac].stgf015,
                                 g_stgf4_d[l_ac].stgf017,
                                 g_stgf4_d[l_ac].stgf009,
                                 g_stgf4_d[l_ac].stgf010, 
                                 g_stgf4_d[l_ac].stgf011,
                                 g_stgf4_d[l_ac].stgf018,
                                 g_stgf4_d[l_ac].stgf008, 
                                 g_stgf4_d[l_ac].stgf012
   
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "FOREACH:"
              LET g_errparam.popup = TRUE
              CALL cl_err()
             
              EXIT FOREACH
           END IF
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
   
   
   LET g_detail_cnt = l_ac-1
   
   CALL g_stgf4_d.deleteElement(g_stgf4_d.getLength())
   
   DISPLAY ARRAY g_stgf4_d TO s_detail4.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   CLOSE sel_stgf_sum_cs2
   
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   
END FUNCTION

################################################################################
# Descriptions...: 按活动力度汇总
# Memo...........:
# Usage..........: CALL astq506_b_fill5()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION astq506_b_fill6()
DEFINE li_ac           LIKE type_t.num10
DEFINE ls_wc           STRING
DEFINE l_pid           LIKE type_t.chr50
DEFINE ls_sql_rank     STRING


   CALL g_stgf5_d.clear()
   

   LET ls_sql_rank = " SELECT UNIQUE sel,enterprise,stgf001,site,ooefl003, ",
                     "         stgf014,stgf015,stgf017,sum(stgf009) l_stgf009,sum(stgf010) l_stgf010,sum(stgf011) l_stgf011,
                               sum(stgf018) l_stgf018,stgf008,sum(stgf012) l_stgf012, ",
                     "         DENSE_RANK() OVER( ORDER BY site,stgf001,stgf014,stgf015,stgf017,stgf008) AS RANK ",
                     "   FROM astq506_tmp ",
                     "  WHERE enterprise = ? ",
                     " GROUP BY sel,enterprise,stgf001,site,ooefl003,stgf014,stgf015,stgf017,stgf008 ",
                     " ORDER BY site,stgf014,stgf015,stgf017,stgf008 "
                    
 
    LET g_sql = "SELECT   sel,enterprise,stgf001,site,ooefl003, ",
                      "   stgf014,stgf015,stgf017,l_stgf009,l_stgf010,l_stgf011,l_stgf018,stgf008,l_stgf012 ",
                      "  FROM (",ls_sql_rank,")                                   ",
                      " WHERE RANK >= ",g_pagestart,
                      " AND RANK < ",g_pagestart + g_num_in_page

 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE sel_stgf_sum3 FROM g_sql
   DECLARE sel_stgf_sum_cs3  CURSOR FOR sel_stgf_sum3
   

   LET l_ac = 1
   
   OPEN sel_stgf_sum_cs3 USING g_enterprise
   
   FOREACH sel_stgf_sum_cs3 INTO g_stgf5_d[l_ac].sel5,        
                                 g_stgf5_d[l_ac].stgfent,    
                                 g_stgf5_d[l_ac].stgf001,                                 
                                 g_stgf5_d[l_ac].stgfsite,          
                                 g_stgf5_d[l_ac].stgfsite_desc_3, 
                                 g_stgf5_d[l_ac].stgf014,   
                                 g_stgf5_d[l_ac].stgf015,
                                 g_stgf5_d[l_ac].stgf017,
                                 g_stgf5_d[l_ac].stgf009,
                                 g_stgf5_d[l_ac].stgf010, 
                                 g_stgf5_d[l_ac].stgf011,
                                 g_stgf5_d[l_ac].stgf018,
                                 g_stgf5_d[l_ac].stgf008, 
                                 g_stgf5_d[l_ac].stgf012

           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "FOREACH:"
              LET g_errparam.popup = TRUE
              CALL cl_err()
             
              EXIT FOREACH
           END IF
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
   
   
   LET g_detail_cnt = l_ac-1
   
   CALL g_stgf5_d.deleteElement(g_stgf5_d.getLength())
   
   DISPLAY ARRAY g_stgf5_d TO s_detail5.* ATTRIBUTES(COUNT=g_detail_cnt)  
   
      BEFORE DISPLAY 
         EXIT DISPLAY

   END DISPLAY

   CLOSE sel_stgf_sum_cs3
   
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   
END FUNCTION

 
{</section>}
 
