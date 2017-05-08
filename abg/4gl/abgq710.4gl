#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-12-29 16:52:19), PR版次:0001(2017-01-04 10:49:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: abgq710
#+ Description: 用人費用預算查詢
#+ Creator....: 05016(2016-12-21 09:22:01)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgq710.global" >}
#應用 q02 樣板自動產生(Version:42)
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
PRIVATE TYPE type_g_bggo_d RECORD
       #statepic       LIKE type_t.chr1,
       
       bggoseq LIKE bggo_t.bggoseq, 
   bggo007 LIKE bggo_t.bggo007, 
   bggo007_1_desc LIKE type_t.chr100, 
   bggo009 LIKE bggo_t.bggo009, 
   bggo009_desc LIKE type_t.chr100, 
   bggo012 LIKE type_t.chr500, 
   bggo012_desc LIKE type_t.chr100, 
   bggo013 LIKE type_t.chr500, 
   bggo013_desc LIKE type_t.chr100, 
   bggo014 LIKE type_t.chr500, 
   bggo014_desc LIKE type_t.chr100, 
   bggo015 LIKE type_t.chr500, 
   bggo015_desc LIKE type_t.chr100, 
   bggo016 LIKE type_t.chr500, 
   bggo016_desc LIKE type_t.chr100, 
   bggo017 LIKE type_t.chr500, 
   bggo017_desc LIKE type_t.chr100, 
   bggo018 LIKE type_t.chr500, 
   bggo018_desc LIKE type_t.chr100, 
   bggo019 LIKE type_t.chr500, 
   bggo019_desc LIKE type_t.chr100, 
   bggo020 LIKE type_t.chr500, 
   bggo020_desc LIKE type_t.chr100, 
   bggo021 LIKE type_t.chr500, 
   bggo021_desc LIKE type_t.chr100, 
   bggo022 LIKE bggo_t.bggo022, 
   bggo023 LIKE type_t.chr500, 
   bggo023_desc LIKE type_t.chr500, 
   bggo024 LIKE type_t.chr500, 
   bggo024_desc LIKE type_t.chr100, 
   bggo100 LIKE bggo_t.bggo100, 
   bggo106 LIKE bggo_t.bggo106, 
   l_amt LIKE type_t.num20_6, 
   bggo039 LIKE bggo_t.bggo039, 
   bggo039_desc LIKE type_t.chr500, 
   bggo040 LIKE bggo_t.bggo040, 
   bggo040_desc LIKE type_t.chr500, 
   bggo011 LIKE bggo_t.bggo011 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_bggo2_d RECORD
   bggoseq        LIKE bggo_t.bggoseq, 
   bggo007        LIKE bggo_t.bggo007, 
   bggo007_2_desc LIKE type_t.chr100, 
   bggo041        LIKE bggo_t.bggo041,
   bggo041_desc   LIKE type_t.chr100,
   bggo042        LIKE bggo_t.bggo042,
   bggo042_desc   LIKE type_t.chr100,
   bggo043        LIKE bggo_t.bggo043,
   bggo043_desc   LIKE type_t.chr100,
   bggo044        LIKE bggo_t.bggo044,         
   bggo044_desc   LIKE type_t.chr100,
   bggo012        LIKE type_t.chr500, 
   bggo012_desc   LIKE type_t.chr100, 
   bggo013        LIKE type_t.chr500, 
   bggo013_desc   LIKE type_t.chr100, 
   bggo014        LIKE type_t.chr500, 
   bggo014_desc   LIKE type_t.chr100, 
   bggo015        LIKE type_t.chr500, 
   bggo015_desc   LIKE type_t.chr100, 
   bggo016        LIKE type_t.chr500, 
   bggo016_desc   LIKE type_t.chr100, 
   bggo017        LIKE type_t.chr500, 
   bggo017_desc   LIKE type_t.chr100, 
   bggo018        LIKE type_t.chr500, 
   bggo018_desc   LIKE type_t.chr100, 
   bggo019        LIKE type_t.chr500, 
   bggo019_desc   LIKE type_t.chr100, 
   bggo020        LIKE type_t.chr500, 
   bggo020_desc   LIKE type_t.chr100, 
   bggo021        LIKE type_t.chr500, 
   bggo021_desc   LIKE type_t.chr100, 
   bggo022        LIKE bggo_t.bggo022, 
   bggo023        LIKE type_t.chr500, 
   bggo023_desc   LIKE type_t.chr500, 
   bggo024        LIKE type_t.chr500, 
   bggo024_desc   LIKE type_t.chr100, 
   l_use1         LIKE bggo_t.bggo035,
   l_accept1      LIKE bggo_t.bggo106,   
   l_amt1         LIKE type_t.num20_6, 
   l_use2         LIKE bggo_t.bggo035,
   l_accept2      LIKE bggo_t.bggo106, 
   l_amt2         LIKE type_t.num20_6, 
   l_use3         LIKE bggo_t.bggo035,
   l_accept3      LIKE bggo_t.bggo106,    
   l_amt3         LIKE type_t.num20_6, 
   l_use4         LIKE bggo_t.bggo035,
   l_accept4      LIKE bggo_t.bggo106,    
   l_amt4         LIKE type_t.num20_6, 
   l_use5         LIKE bggo_t.bggo035,
   l_accept5      LIKE bggo_t.bggo106,    
   l_amt5         LIKE type_t.num20_6, 
   l_use6         LIKE bggo_t.bggo035,
   l_accept6      LIKE bggo_t.bggo106,    
   l_amt6         LIKE type_t.num20_6, 
   l_use7         LIKE bggo_t.bggo035,
   l_accept7      LIKE bggo_t.bggo106,    
   l_amt7         LIKE type_t.num20_6, 
   l_use8         LIKE bggo_t.bggo035,
   l_accept8      LIKE bggo_t.bggo106,    
   l_amt8         LIKE type_t.num20_6, 
   l_use9         LIKE bggo_t.bggo035,
   l_accept9      LIKE bggo_t.bggo106,    
   l_amt9         LIKE type_t.num20_6, 
   l_use10        LIKE bggo_t.bggo035,
   l_accept10     LIKE bggo_t.bggo106,    
   l_amt10        LIKE type_t.num20_6, 
   l_use11        LIKE bggo_t.bggo035,
   l_accept11     LIKE bggo_t.bggo106, 
   l_amt11        LIKE type_t.num20_6, 
   l_use12        LIKE bggo_t.bggo035,
   l_accept12     LIKE bggo_t.bggo106, 
   l_amt12        LIKE type_t.num20_6, 
   l_use13        LIKE bggo_t.bggo035,
   l_accept13     LIKE bggo_t.bggo106, 
   l_amt13        LIKE type_t.num20_6
                  END RECORD
DEFINE g_bggo2_d   DYNAMIC ARRAY OF type_g_bggo2_d
DEFINE g_bggo2_d_t type_g_bggo2_d


#單頭欄位定義
PRIVATE TYPE type_input RECORD
         bggo002        LIKE bggo_t.bggo002,   
         bggo002_desc   LIKE type_t.chr100,   
         bggo003        LIKE bggo_t.bggo003, 
         bggo007        LIKE bggo_t.bggo007, 
         bggo007_desc   LIKE type_t.chr100, 
         l_lowersite    LIKE type_t.chr1,
         bggo001        LIKE bggo_t.bggo001,
         l_type         LIKE type_t.chr1, 
         bggostus       LIKE bggo_t.bggostus,
         l_curr         LIKE type_t.chr1,
         l_periods      LIKE type_t.chr1,   
         l_bgaa003      LIKE bgaa_t.bgaa003,
         hsx_bggo039    LIKE type_t.chr1,  #核算項顯示否 --s
         hsx_bggo012    LIKE type_t.chr1,
         hsx_bggo013    LIKE type_t.chr1,
         hsx_bggo014    LIKE type_t.chr1,
         hsx_bggo015    LIKE type_t.chr1,
         hsx_bggo016    LIKE type_t.chr1,
         hsx_bggo017    LIKE type_t.chr1,
         hsx_bggo018    LIKE type_t.chr1,
         hsx_bggo019    LIKE type_t.chr1,
         hsx_bggo020    LIKE type_t.chr1,
         hsx_bggo021    LIKE type_t.chr1,
         hsx_bggo022    LIKE type_t.chr1,
         hsx_bggo023    LIKE type_t.chr1,
         hsx_bggo024    LIKE type_t.chr1  #核算項顯示否 --e
                        END RECORD
#展組織樹欄位定義
DEFINE g_tree_idx       LIKE type_t.num10
DEFINE g_tree           DYNAMIC ARRAY OF RECORD
         show           LIKE type_t.chr100,    #外顯欄位
         pid            LIKE type_t.chr100,    #父節點id
         id             LIKE type_t.chr100,    #本身節點id
         exp            LIKE type_t.chr100,    #是否展開
         hasC           LIKE type_t.num5,      #是否有子節點
         isExp          LIKE type_t.num5,      #是否已展開
         expcode        LIKE type_t.num5,      #展開值
         bggo037        LIKE bggo_t.bggo037,   #KEY1
         bggo007        LIKE bggo_t.bggo007    #KEY1
                        END RECORD
DEFINE g_tree_pid       LIKE type_t.chr100      
DEFINE g_wc3            STRING
DEFINE g_input          type_input
DEFINE g_input_o        type_input
DEFINE g_current_row    LIKE type_t.num5
DEFINE g_current_idx    LIKE type_t.num10
DEFINE g_jump           LIKE type_t.num10
DEFINE g_no_ask         LIKE type_t.num5
DEFINE g_rec_b          LIKE type_t.num5 
#資料瀏覽之欄位          
DEFINE g_bggo           DYNAMIC ARRAY OF RECORD
         bggo007        LIKE bggo_t.bggo007
      END RECORD        
DEFINE g_hsx_wc         STRING  
DEFINE g_select_field   STRING  
DEFINE g_bggo007        STRING 
DEFINE g_bggo037        LIKE bggo_t.bggo037
DEFINE g_flag           LIKE type_t.num5     #紀錄是否為根節點
DEFINE g_max_period     LIKE bggo_t.bggo008
DEFINE g_xgrid_visible_column  STRING
DEFINE g_subrep_ins     LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_bggo_d
DEFINE g_master_t                   type_g_bggo_d
DEFINE g_bggo_d          DYNAMIC ARRAY OF type_g_bggo_d
DEFINE g_bggo_d_t        type_g_bggo_d
 
      
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
 
{<section id="abgq710.main" >}
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
   CALL cl_ap_init("abg","")
 
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
   DECLARE abgq710_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq710_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq710_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq710 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq710_init()   
 
      #進入選單 Menu (="N")
      CALL abgq710_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq710
      
   END IF 
   
   CLOSE abgq710_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq710.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abgq710_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL abgq710_default()
   CALL abgq710_creat_temp()
   #end add-point
 
   CALL abgq710_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="abgq710.default_search" >}
PRIVATE FUNCTION abgq710_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " bggo001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " bggo002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " bggo003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " bggo005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " bggo006 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " bggo007 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " bggo008 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " bggoseq = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " bggoseq2 = '", g_argv[09], "' AND "
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
 
{<section id="abgq710.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abgq710_ui_dialog()
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
      CALL abgq710_b_fill()
   ELSE
      CALL abgq710_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_bggo_d.clear()
 
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
 
         CALL abgq710_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bggo_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL abgq710_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL abgq710_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_bggo_d.getLength() TO FORMONLY.h_count               
               #show 第二單身
               IF g_detail_idx > 0 THEN
                  CALL abgq710_b_fill2(g_detail_idx)
               END IF      
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #第二單身ARRAY
         DISPLAY ARRAY g_bggo2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_bggo2_d.getLength() TO FORMONLY.h_count
               CALL abgq710_fetch()
               LET g_master_idx = l_ac
 
         END DISPLAY
         
         #組織樹ARRAY
         DISPLAY ARRAY g_tree TO s_detail3.* ATTRIBUTES(COUNT=g_tree_idx)
            BEFORE ROW        
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               CALL abgq710_tree_fetch(l_ac)
               IF NOT cl_null(g_bggo007) THEN
                  CALL abgq710_b_fill()
               END IF
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL abgq710_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL abgq710_print()
               CALL abgq710_x01('1=1','abgq710_x01_tmp','abgq710_x01_tmp1',g_xgrid_visible_column) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL abgq710_print()
               CALL abgq710_x01('1=1','abgq710_x01_tmp','abgq710_x01_tmp1',g_xgrid_visible_column) 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgq710_query()
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL abgq710_filter()
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
            CALL abgq710_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bggo_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_bggo2_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL abgq710_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL abgq710_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL abgq710_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL abgq710_b_fill()
 
         
         
 
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
 
{<section id="abgq710.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgq710_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_site_str  STRING
   DEFINE l_bgaa006   LIKE bgaa_t.bgaa006
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL g_bggo2_d.clear()
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_bggo_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON bggo009,bggo022,bggo100,bggo106,bggo011
           FROM s_detail1[1].b_bggo009,s_detail1[1].b_bggo022,s_detail1[1].b_bggo100,s_detail1[1].b_bggo106, 
               s_detail1[1].b_bggo011
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD b_bggo002
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_bggoseq>>----
         #----<<bggo007_1_desc>>----
         #----<<b_bggo009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bggo009
            #add-point:BEFORE FIELD b_bggo009 name="construct.b.page1.b_bggo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bggo009
            
            #add-point:AFTER FIELD b_bggo009 name="construct.a.page1.b_bggo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bggo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo009
            #add-point:ON ACTION controlp INFIELD b_bggo009 name="construct.c.page1.b_bggo009"
            
            #END add-point
 
 
         #----<<bggo009_desc>>----
         #----<<b_bggo012>>----
         #----<<bggo012_desc>>----
         #----<<b_bggo013>>----
         #----<<bggo013_desc>>----
         #----<<b_bggo014>>----
         #----<<bggo014_desc>>----
         #----<<b_bggo015>>----
         #----<<bggo015_desc>>----
         #----<<b_bggo016>>----
         #----<<bggo016_desc>>----
         #----<<b_bggo017>>----
         #----<<bggo017_desc>>----
         #----<<b_bggo018>>----
         #----<<bggo018_desc>>----
         #----<<b_bggo019>>----
         #----<<bggo019_desc>>----
         #----<<b_bggo020>>----
         #----<<bggo020_desc>>----
         #----<<b_bggo021>>----
         #----<<bggo021_desc>>----
         #----<<b_bggo022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bggo022
            #add-point:BEFORE FIELD b_bggo022 name="construct.b.page1.b_bggo022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bggo022
            
            #add-point:AFTER FIELD b_bggo022 name="construct.a.page1.b_bggo022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bggo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo022
            #add-point:ON ACTION controlp INFIELD b_bggo022 name="construct.c.page1.b_bggo022"
            
            #END add-point
 
 
         #----<<b_bggo023>>----
         #----<<bggo023_desc>>----
         #----<<b_bggo024>>----
         #----<<bggo024_desc>>----
         #----<<b_bggo100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bggo100
            #add-point:BEFORE FIELD b_bggo100 name="construct.b.page1.b_bggo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bggo100
            
            #add-point:AFTER FIELD b_bggo100 name="construct.a.page1.b_bggo100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bggo100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo100
            #add-point:ON ACTION controlp INFIELD b_bggo100 name="construct.c.page1.b_bggo100"
            
            #END add-point
 
 
         #----<<b_bggo106>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bggo106
            #add-point:BEFORE FIELD b_bggo106 name="construct.b.page1.b_bggo106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bggo106
            
            #add-point:AFTER FIELD b_bggo106 name="construct.a.page1.b_bggo106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo106
            #add-point:ON ACTION controlp INFIELD b_bggo106 name="construct.c.page1.b_bggo106"
            
            #END add-point
 
 
         #----<<l_amt>>----
         #----<<b_bggo039>>----
         #----<<bggo039_desc>>----
         #----<<b_bggo040>>----
         #----<<bggo040_desc>>----
         #----<<b_bggo011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bggo011
            #add-point:BEFORE FIELD b_bggo011 name="construct.b.page1.b_bggo011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bggo011
            
            #add-point:AFTER FIELD b_bggo011 name="construct.a.page1.b_bggo011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bggo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo011
            #add-point:ON ACTION controlp INFIELD b_bggo011 name="construct.c.page1.b_bggo011"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #QBE
      CONSTRUCT BY NAME g_wc3 ON bggo041,bggo009
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD bggo041
            #工資方案#開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bggc003()
            DISPLAY g_qryparam.return1 TO bggo041
            NEXT FIELD bggo041
         
         ON ACTION controlp INFIELD bggo009     
            #工資項目  #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1  = "3401"
            CALL q_bggb002()
            DISPLAY g_qryparam.return1 TO bggo009
            NEXT FIELD bggo009
          
      END CONSTRUCT 
      
      INPUT g_input.bggo002,g_input.bggo002_desc,g_input.bggo003,g_input.bggo007,
            g_input.bggo007_desc,g_input.l_lowersite,
            g_input.bggo001,g_input.l_type,g_input.bggostus,g_input.l_curr,
            g_input.hsx_bggo039,
            g_input.hsx_bggo012,g_input.hsx_bggo013,g_input.hsx_bggo014,g_input.hsx_bggo015,
            g_input.hsx_bggo016,g_input.hsx_bggo017,g_input.hsx_bggo018,g_input.hsx_bggo019,
            g_input.hsx_bggo020,g_input.hsx_bggo021,g_input.hsx_bggo022,g_input.hsx_bggo023,
            g_input.hsx_bggo024 
       FROM b_bggo002,bggo002_desc,b_bggo003,b_bggo007,
            bggo007_desc,l_lowersite,
            b_bggo001,l_type,b_bggostus,l_curr,
            hsx_bggo039,
            hsx_bggo012,hsx_bggo013,hsx_bggo014,hsx_bggo015,
            hsx_bggo016,hsx_bggo017,hsx_bggo018,hsx_bggo019,
            hsx_bggo020,hsx_bggo021,hsx_bggo022,hsx_bggo023,
            hsx_bggo024 
         ATTRIBUTE(WITHOUT DEFAULTS)

         AFTER FIELD b_bggo002
            LET g_input.bggo002_desc = ''
            DISPLAY BY NAME g_input.bggo002_desc
            IF NOT cl_null(g_input.bggo002) THEN
               IF g_input.bggo002 != g_input_o.bggo002 OR cl_null(g_input_o.bggo002) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.bggo002
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "abg-00008:sub-01302|abgi010|",cl_get_progname("abgi010",g_lang,"2"),"|:EXEPROGabgi010"
                  IF cl_chk_exist("v_bgaa001") THEN
                     #是否使用預測
                     LET l_bgaa006 = ''
                     SELECT bgaa006 INTO l_bgaa006 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bggo002 AND bgaastus = 'Y'
                     IF l_bgaa006 <> '1' THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00292'
                        LET g_errparam.extend = g_input.bggo002
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.bggo002 = g_input_o.bggo002
                        CALL s_desc_get_budget_desc(g_input.bggo002) RETURNING g_input.bggo002_desc
                        DISPLAY BY NAME g_input.bggo002_desc
                        NEXT FIELD CURRENT
                     END IF                  
                  
                     IF NOT cl_null(g_input.bggo007) THEN
                        CALL s_abg2_bgai004_chk(g_input.bggo002,'',g_input.bggo007,'')
                        IF NOT cl_null(g_errno) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = g_errno
                           LET g_errparam.extend = g_input.bggo002," + ",g_input.bggo007
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                           LET g_input.bggo002 = g_input_o.bggo002
                           CALL s_desc_get_budget_desc(g_input.bggo002) RETURNING g_input.bggo002_desc
                           DISPLAY BY NAME g_input.bggo002_desc
                           NEXT FIELD CURRENT
                        END IF
                     END IF
                  ELSE
                     #檢查失敗時後續處理
                     LET g_input.bggo002 = g_input_o.bggo002
                     CALL s_desc_get_budget_desc(g_input.bggo002) RETURNING g_input.bggo002_desc
                     DISPLAY BY NAME g_input.bggo002_desc
                     NEXT FIELD CURRENT
                  END IF                
               END IF                
            END IF     
            #預算幣別            
            LET g_input.l_bgaa003 = ''
            SELECT bgaa003 INTO g_input.l_bgaa003 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bggo002
            DISPLAY g_input.l_bgaa003 TO l_bgaa003           
            CALL s_desc_get_budget_desc(g_input.bggo002) RETURNING g_input.bggo002_desc
            DISPLAY BY NAME g_input.bggo002_desc       
            LET g_input_o.* = g_input.*          
      
         ON ACTION controlp INFIELD b_bggo002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.bggo002
            LET g_qryparam.where = "bgaastus = 'Y' AND bgaa006 = '1' "   #使用預測才可以開 
            CALL q_bgaa001()
            LET g_input.bggo002 = g_qryparam.return1
            DISPLAY g_input.bggo002 TO b_bggo002
            NEXT FIELD b_bggo002
            
         AFTER FIELD b_bggo007
            #預算組織
            LET g_input.bggo007_desc = ''
            DISPLAY BY NAME g_input.bggo007_desc
            IF NOT cl_null(g_input.bggo007) THEN
               IF g_input.bggo007 != g_input_o.bggo007 OR cl_null(g_input_o.bggo007) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.bggo007
                  LET g_errshow = TRUE
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  IF NOT cl_chk_exist("v_ooef001_24") THEN
                     LET g_input.bggo007 = g_input_o.bggo007
                     CALL s_desc_get_department_desc(g_input.bggo007) RETURNING g_input.bggo007_desc
                     DISPLAY BY NAME g_input.bggo007_desc
                     NEXT FIELD CURRENT
                  END IF

                  CALL s_abg2_bgai004_chk(g_input.bggo002,'',g_input.bggo007,'')
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_input.bggo007
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_input.bggo007 = g_input_o.bggo007
                     CALL s_desc_get_department_desc(g_input.bggo007) RETURNING g_input.bggo007_desc
                     DISPLAY BY NAME g_input.bggo007_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_input.bggo007_desc = s_desc_get_department_desc(g_input.bggo007)
            DISPLAY BY NAME g_input.bggo007_desc
            LET g_input_o.* = g_input.*
      
         ON ACTION controlp INFIELD b_bggo007
            #預算組織
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.bggo007
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t ",
                                   "              WHERE bgajent = ooefent AND bgajent = ",g_enterprise,
                                   "                AND bgaj001 = '",g_input.bggo002,"' AND bgajstus = 'Y') "
            CALL s_abg2_get_budget_site(g_input.bggo002,'',g_user,'') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ",l_site_str
            CALL q_ooef001()
            LET g_input.bggo007 = g_qryparam.return1
            DISPLAY g_input.bggo007 TO b_bggo007
            NEXT FIELD b_bggo007       
         

         ON CHANGE l_curr
            CALL cl_set_comp_visible('l_amt,b_bggo100',TRUE)
            CALL cl_set_comp_visible('l_amt1,l_amt2,l_amt3,l_amt4,l_amt5',TRUE)
            CALL cl_set_comp_visible('l_amt6,l_amt7,l_amt8,l_amt9,l_amt10',TRUE)
            CALL cl_set_comp_visible('l_amt11,l_amt12,l_amt13',TRUE)
            IF g_input.l_curr = 'N' THEN
               CALL cl_set_comp_visible('l_amt,b_bggo100',FALSE)
               CALL cl_set_comp_visible('l_amt1,l_amt2,l_amt3,l_amt4,l_amt5',FALSE)
               CALL cl_set_comp_visible('l_amt6,l_amt7,l_amt8,l_amt9,l_amt10',FALSE)
               CALL cl_set_comp_visible('l_amt11,l_amt12,l_amt13',FALSE)
            END IF
         
         ON CHANGE l_type
            CALL cl_set_comp_visible('group_2',TRUE)
            IF g_input.l_type = '1' THEN
               LET g_input.hsx_bggo039 = 'Y'
               CALL cl_set_comp_visible('group_2',FALSE)
            END IF
         
         AFTER INPUT
               
            
      END INPUT  
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
         CALL abgq710_default()
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
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   CALL abgq710_grow_tree()
   CALL abgq710_set_title()
   CALL abgq710_tree_fetch('1')   
   #end add-point
        
   LET g_error_show = 1
   CALL abgq710_b_fill()
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
 
{<section id="abgq710.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq710_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_begin_amt_sql STRING
   DEFINE l_bgae002       LIKE bgae_t.bgae002
   DEFINE l_sum_bgbj032   LIKE bgbj_t.bgbj032
   DEFINE l_sum_bgbj033   LIKE bgbj_t.bgbj033
   DEFINE l_bgaa008       LIKE bgaa_t.bgaa008
   DEFINE l_bggo007_str   STRING
   DEFINE l_t040_hsx_wc   STRING    
   DEFINE l_stus          STRING   
   DEFINE l_bggo100       LIKE bggo_t.bggo100
   DEFINE l_bggo106       LIKE bggo_t.bggo106
   DEFINE l_amt           LIKE bggo_t.bggo106
   DEFINE l_sql           STRING
   
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #如不展下層,則直接展畫面上預算組織
   IF g_input.l_lowersite = 'N' THEN
      LET l_bggo007_str = g_input.bggo007
      LET g_bggo007 = g_input.bggo007
   END IF
   
   #組合組織條件
   IF cl_null(g_bggo007) THEN 
      CALL abgq710_tree_fetch('1')
   END IF
   LET l_bggo007_str = "('",g_bggo007,"')" 
   
   #使用預算細項參照表
   LET l_bgaa008 = ''
   SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t 
    WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bggo002 AND bgaastus = 'Y'
   
   #QBE 條件
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET g_hsx_wc = g_hsx_wc.trim()
   LET g_hsx_wc = cl_replace_str(g_hsx_wc,'1=1,','')
  
  #最大週期數
   SELECT MAX(bgac004) INTO g_max_period FROM bgac_t
    WHERE bgacent = g_enterprise 
      AND bgac001= (SELECT bgaa002 FROM bgaa_t WHERE bgaaent = g_enterprise AND bgaa001 = g_input.bggo002) 
   CASE g_input.bggostus
      WHEN 0 
         LET l_stus = " bggostus = 'Y' "
      WHEN 1
         LET l_stus = " bggostus = 'N' "
      WHEN 2 
         LET l_stus = " bggostus = 'FC' "
      WHEN 3
         LET l_stus =  " 1=1"  
   END CASE
   IF g_hsx_wc = "1=1" THEN LET g_hsx_wc = '' END IF
   CALL cl_set_comp_visible('l_use13,l_accept13,l_amt13',TRUE)
   IF g_max_period <> '13' THEN
      CALL cl_set_comp_visible('l_use13,l_accept13,l_amt13',FALSE)
   END IF
   IF g_input.l_curr = 'N' THEN CALL cl_set_comp_visible('l_amt13',FALSE) END IF      
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
 
   LET ls_sql_rank = "SELECT  UNIQUE bggoseq,'','',bggo009,'','','','','','','','','','','','','','', 
       '','','','','','','',bggo022,'','','','',bggo100,bggo106,'',bggo039,'',bggo040,'',bggo011  ,DENSE_RANK() OVER( ORDER BY bggo_t.bggo001, 
       bggo_t.bggo002,bggo_t.bggo003,bggo_t.bggo005,bggo_t.bggo006,bggo_t.bggo007,bggo_t.bggo008,bggo_t.bggoseq, 
       bggo_t.bggoseq2) AS RANK FROM bggo_t",
 
 
                     "",
                     " WHERE bggoent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("bggo_t"),
                     " ORDER BY bggo_t.bggo001,bggo_t.bggo002,bggo_t.bggo003,bggo_t.bggo005,bggo_t.bggo006,bggo_t.bggo007,bggo_t.bggo008,bggo_t.bggoseq,bggo_t.bggoseq2"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
 
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
 
   LET g_sql = "SELECT bggoseq,'','',bggo009,'','','','','','','','','','','','','','','','','','','', 
       '','',bggo022,'','','','',bggo100,bggo106,'',bggo039,'',bggo040,'',bggo011",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #CALL abgq710_insert_temp()
   
               
   LET g_select_field = cl_replace_str(g_select_field,'bggo007',"''")   
   LET g_sql = " SELECT DISTINCT ",g_select_field," ",
               "   FROM bggo_t ",
               "  WHERE bggoent = ?  ",
               "    AND bggo007 IN ",l_bggo007_str,"    ",
               "    AND bggo001 = '",g_input.bggo001,"' ",
               "    AND bggo002 = '",g_input.bggo002,"' ",
               "    AND bggo003 = '",g_input.bggo003,"' ",
               "    AND ",g_wc3,
               "    AND ",l_stus,
               "    AND bggo008 BETWEEN 1 AND '",g_max_period,"'  "
   IF NOT cl_null(g_hsx_wc) THEN                
      LET g_sql = g_sql," GROUP BY ",g_hsx_wc,",bggo100,bggo009    ",
                        " ORDER BY ",g_hsx_wc,",bggo100,bggo009    "
   ELSE
      LET g_sql = g_sql," GROUP BY bggo100,bggo009    ",
                        " ORDER BY bggo100,bggo009    "
   END IF
                     
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgq710_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abgq710_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_bggo_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_bggo2_d.clear() 
   DELETE FROM abgq710_currtmp
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_bggo_d[l_ac].bggoseq,g_bggo_d[l_ac].bggo007,g_bggo_d[l_ac].bggo007_1_desc, 
       g_bggo_d[l_ac].bggo009,g_bggo_d[l_ac].bggo009_desc,g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo012_desc, 
       g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo013_desc,g_bggo_d[l_ac].bggo014,g_bggo_d[l_ac].bggo014_desc, 
       g_bggo_d[l_ac].bggo015,g_bggo_d[l_ac].bggo015_desc,g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo016_desc, 
       g_bggo_d[l_ac].bggo017,g_bggo_d[l_ac].bggo017_desc,g_bggo_d[l_ac].bggo018,g_bggo_d[l_ac].bggo018_desc, 
       g_bggo_d[l_ac].bggo019,g_bggo_d[l_ac].bggo019_desc,g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo020_desc, 
       g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo021_desc,g_bggo_d[l_ac].bggo022,g_bggo_d[l_ac].bggo023, 
       g_bggo_d[l_ac].bggo023_desc,g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo024_desc,g_bggo_d[l_ac].bggo100, 
       g_bggo_d[l_ac].bggo106,g_bggo_d[l_ac].l_amt,g_bggo_d[l_ac].bggo039,g_bggo_d[l_ac].bggo039_desc, 
       g_bggo_d[l_ac].bggo040,g_bggo_d[l_ac].bggo040_desc,g_bggo_d[l_ac].bggo011
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_bggo_d[l_ac].statepic = cl_get_actipic(g_bggo_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #項次
      LET g_bggo_d[l_ac].bggoseq = l_ac

      #組織
      IF g_flag THEN
         LET g_bggo_d[l_ac].bggo007 = g_bggo037
      ELSE
         LET g_bggo_d[l_ac].bggo007 = g_bggo007
      END IF
        
      #工資項目
      CALL s_desc_get_acc_desc('3401',g_bggo_d[l_ac].bggo009) RETURNING g_bggo_d[l_ac].bggo009_desc
      LET g_bggo_d[l_ac].bggo009_desc = s_desc_show1(g_bggo_d[l_ac].bggo009,g_bggo_d[l_ac].bggo009_desc)
      
      LET g_bggo_d[l_ac].bggo007_1_desc = s_desc_get_department_desc(g_bggo_d[l_ac].bggo007)
      ####核算項  -------------s
      #預算細項
      CALL s_abg_bgae001_desc(l_bgaa008,g_bggo_d[l_ac].bggo039) RETURNING g_bggo_d[l_ac].bggo039_desc  
      LET g_bggo_d[l_ac].bggo039_desc = s_desc_show1(g_bggo_d[l_ac].bggo039,g_bggo_d[l_ac].bggo039_desc)   
      CALL s_abg_bgae001_desc(l_bgaa008,g_bggo_d[l_ac].bggo040) RETURNING g_bggo_d[l_ac].bggo040_desc  
      LET g_bggo_d[l_ac].bggo040_desc = s_desc_show1(g_bggo_d[l_ac].bggo040,g_bggo_d[l_ac].bggo040_desc)
      #人員
      CALL s_desc_get_person_desc(g_bggo_d[l_ac].bggo012) RETURNING g_bggo_d[l_ac].bggo012_desc
      LET g_bggo_d[l_ac].bggo012_desc = s_desc_show1(g_bggo_d[l_ac].bggo012,g_bggo_d[l_ac].bggo012_desc)
      #部門
      CALL s_desc_get_department_desc(g_bggo_d[l_ac].bggo013) RETURNING g_bggo_d[l_ac].bggo013_desc
      LET g_bggo_d[l_ac].bggo013_desc = s_desc_show1(g_bggo_d[l_ac].bggo013,g_bggo_d[l_ac].bggo013_desc)
      #成本利潤中心
      CALL s_desc_get_department_desc(g_bggo_d[l_ac].bggo014) RETURNING g_bggo_d[l_ac].bggo014_desc
      LET g_bggo_d[l_ac].bggo014_desc = s_desc_show1(g_bggo_d[l_ac].bggo014,g_bggo_d[l_ac].bggo014_desc)
      #區域
      CALL s_desc_get_acc_desc('287',g_bggo_d[l_ac].bggo015) RETURNING g_bggo_d[l_ac].bggo015_desc
      LET g_bggo_d[l_ac].bggo015_desc = s_desc_show1(g_bggo_d[l_ac].bggo015,g_bggo_d[l_ac].bggo015_desc)
      #收付款客商
      CALL s_desc_get_bgap001_desc(g_bggo_d[l_ac].bggo016) RETURNING g_bggo_d[l_ac].bggo016_desc
      LET g_bggo_d[l_ac].bggo016_desc = s_desc_show1(g_bggo_d[l_ac].bggo016,g_bggo_d[l_ac].bggo016_desc)
      #收款客商
      CALL s_desc_get_bgap001_desc(g_bggo_d[l_ac].bggo017) RETURNING g_bggo_d[l_ac].bggo017_desc
      LET g_bggo_d[l_ac].bggo017_desc = s_desc_show1(g_bggo_d[l_ac].bggo017,g_bggo_d[l_ac].bggo017_desc)
      #客群
      CALL s_desc_get_acc_desc('281',g_bggo_d[l_ac].bggo018) RETURNING g_bggo_d[l_ac].bggo018_desc
      LET g_bggo_d[l_ac].bggo018_desc = s_desc_show1(g_bggo_d[l_ac].bggo018,g_bggo_d[l_ac].bggo018_desc)
      #產品類別
      CALL s_desc_get_rtaxl003_desc(g_bggo_d[l_ac].bggo019) RETURNING g_bggo_d[l_ac].bggo019_desc
      LET g_bggo_d[l_ac].bggo019_desc = s_desc_show1(g_bggo_d[l_ac].bggo019,g_bggo_d[l_ac].bggo019_desc)
      #專案編號
      CALL s_desc_get_project_desc(g_bggo_d[l_ac].bggo020) RETURNING g_bggo_d[l_ac].bggo020_desc
      LET g_bggo_d[l_ac].bggo020_desc = s_desc_show1(g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo020_desc)
      #WBS
      CALL s_desc_get_wbs_desc(g_bggo_d[l_ac].bggo020,g_bggo_d[l_ac].bggo021) RETURNING g_bggo_d[l_ac].bggo021_desc
      LET g_bggo_d[l_ac].bggo021_desc = s_desc_show1(g_bggo_d[l_ac].bggo021,g_bggo_d[l_ac].bggo021_desc)
      #經營方式
      LET g_bggo_d[l_ac].bggo022 = g_bggo_d[l_ac].bggo022
      #通路
      CALL s_desc_get_oojdl003_desc(g_bggo_d[l_ac].bggo023) RETURNING g_bggo_d[l_ac].bggo023_desc
      LET g_bggo_d[l_ac].bggo023_desc = s_desc_show1(g_bggo_d[l_ac].bggo023,g_bggo_d[l_ac].bggo023_desc)
      #品牌
      CALL s_desc_get_acc_desc('2002',g_bggo_d[l_ac].bggo024) RETURNING g_bggo_d[l_ac].bggo024_desc
      LET g_bggo_d[l_ac].bggo024_desc = s_desc_show1(g_bggo_d[l_ac].bggo024,g_bggo_d[l_ac].bggo024_desc)
      ####-------------e
      
      #小計
      INSERT INTO abgq710_currtmp 
           VALUES(g_bggo_d[l_ac].bggo100,g_bggo_d[l_ac].bggo106,g_bggo_d[l_ac].l_amt)      
      
      #end add-point
 
      CALL abgq710_detail_show("'1'")      
 
      CALL abgq710_bggo_t_mask()
 
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
   
 
   
   CALL g_bggo_d.deleteElement(g_bggo_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF g_bggo_d.getLength() > 0 THEN    
      LET l_bggo100 = ''
      LET l_bggo106 = 0
      LET l_amt = 0
      LET l_sql = "  SELECT bggo100,SUM(bggo106),SUM(l_amt) ",
                  "    FROM abgq710_currtmp ",
                  "   GROUP BY bggo100 ",
                  "   ORDER BY bggo100 "    
      PREPARE abgq710_currsum_p FROM l_sql
      DECLARE abgq710_currsum_c CURSOR FOR abgq710_currsum_p                    
      FOREACH abgq710_currsum_c INTO l_bggo100,l_bggo106,l_amt
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "FOREACH:abgq710_currsum_c"
            LET g_errparam.code   = SQLCA.sqlcode
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF 
         
         LET g_bggo_d[l_ac].bggo009_desc = cl_getmsg('aap-00287',g_lang)
         LET g_bggo_d[l_ac].bggo100 = l_bggo100
         LET g_bggo_d[l_ac].bggo106 = l_bggo106
         LET g_bggo_d[l_ac].l_amt   = l_amt
         LET l_ac = l_ac + 1
      END FOREACH
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   LET g_detail_cnt = g_bggo_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE abgq710_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq710_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq710_detail_action_trans()
 
   IF g_bggo_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL abgq710_fetch()
   END IF
   
      CALL abgq710_filter_show('bggo009','b_bggo009')
   CALL abgq710_filter_show('bggo022','b_bggo022')
   CALL abgq710_filter_show('bggo100','b_bggo100')
   CALL abgq710_filter_show('bggo106','b_bggo106')
   CALL abgq710_filter_show('bggo011','b_bggo011')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   CALL abgq710_b_fill2(1)
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq710_fetch()
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
 
{<section id="abgq710.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq710_detail_show(ps_page)
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
 
{<section id="abgq710.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abgq710_filter()
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
      CONSTRUCT g_wc_filter ON bggo009,bggo022,bggo100,bggo106,bggo011
                          FROM s_detail1[1].b_bggo009,s_detail1[1].b_bggo022,s_detail1[1].b_bggo100, 
                              s_detail1[1].b_bggo106,s_detail1[1].b_bggo011
 
         BEFORE CONSTRUCT
                     DISPLAY abgq710_filter_parser('bggo009') TO s_detail1[1].b_bggo009
            DISPLAY abgq710_filter_parser('bggo022') TO s_detail1[1].b_bggo022
            DISPLAY abgq710_filter_parser('bggo100') TO s_detail1[1].b_bggo100
            DISPLAY abgq710_filter_parser('bggo106') TO s_detail1[1].b_bggo106
            DISPLAY abgq710_filter_parser('bggo011') TO s_detail1[1].b_bggo011
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_bggoseq>>----
         #----<<bggo007_1_desc>>----
         #----<<b_bggo009>>----
         #Ctrlp:construct.c.filter.page1.b_bggo009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo009
            #add-point:ON ACTION controlp INFIELD b_bggo009 name="construct.c.filter.page1.b_bggo009"
            
            #END add-point
 
 
         #----<<bggo009_desc>>----
         #----<<b_bggo012>>----
         #----<<bggo012_desc>>----
         #----<<b_bggo013>>----
         #----<<bggo013_desc>>----
         #----<<b_bggo014>>----
         #----<<bggo014_desc>>----
         #----<<b_bggo015>>----
         #----<<bggo015_desc>>----
         #----<<b_bggo016>>----
         #----<<bggo016_desc>>----
         #----<<b_bggo017>>----
         #----<<bggo017_desc>>----
         #----<<b_bggo018>>----
         #----<<bggo018_desc>>----
         #----<<b_bggo019>>----
         #----<<bggo019_desc>>----
         #----<<b_bggo020>>----
         #----<<bggo020_desc>>----
         #----<<b_bggo021>>----
         #----<<bggo021_desc>>----
         #----<<b_bggo022>>----
         #Ctrlp:construct.c.filter.page1.b_bggo022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo022
            #add-point:ON ACTION controlp INFIELD b_bggo022 name="construct.c.filter.page1.b_bggo022"
            
            #END add-point
 
 
         #----<<b_bggo023>>----
         #----<<bggo023_desc>>----
         #----<<b_bggo024>>----
         #----<<bggo024_desc>>----
         #----<<b_bggo100>>----
         #Ctrlp:construct.c.filter.page1.b_bggo100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo100
            #add-point:ON ACTION controlp INFIELD b_bggo100 name="construct.c.filter.page1.b_bggo100"
            
            #END add-point
 
 
         #----<<b_bggo106>>----
         #Ctrlp:construct.c.filter.page1.b_bggo106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo106
            #add-point:ON ACTION controlp INFIELD b_bggo106 name="construct.c.filter.page1.b_bggo106"
            
            #END add-point
 
 
         #----<<l_amt>>----
         #----<<b_bggo039>>----
         #----<<bggo039_desc>>----
         #----<<b_bggo040>>----
         #----<<bggo040_desc>>----
         #----<<b_bggo011>>----
         #Ctrlp:construct.c.filter.page1.b_bggo011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bggo011
            #add-point:ON ACTION controlp INFIELD b_bggo011 name="construct.c.filter.page1.b_bggo011"
            
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL abgq710_filter_show('bggo009','b_bggo009')
   CALL abgq710_filter_show('bggo022','b_bggo022')
   CALL abgq710_filter_show('bggo100','b_bggo100')
   CALL abgq710_filter_show('bggo106','b_bggo106')
   CALL abgq710_filter_show('bggo011','b_bggo011')
 
    
   CALL abgq710_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abgq710_filter_parser(ps_field)
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
 
{<section id="abgq710.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abgq710_filter_show(ps_field,ps_object)
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
   LET ls_condition = abgq710_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.insert" >}
#+ insert
PRIVATE FUNCTION abgq710_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgq710.modify" >}
#+ modify
PRIVATE FUNCTION abgq710_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.reproduce" >}
#+ reproduce
PRIVATE FUNCTION abgq710_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.delete" >}
#+ delete
PRIVATE FUNCTION abgq710_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq710.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq710_detail_action_trans()
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
 
{<section id="abgq710.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq710_detail_index_setting()
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
            IF g_bggo_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_bggo_d.getLength() AND g_bggo_d.getLength() > 0
            LET g_detail_idx = g_bggo_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_bggo_d.getLength() THEN
               LET g_detail_idx = g_bggo_d.getLength()
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
 
{<section id="abgq710.mask_functions" >}
 &include "erp/abg/abgq710_mask.4gl"
 
{</section>}
 
{<section id="abgq710.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預設值
# Memo...........:
# Usage..........: CALL abgq710_default()
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_default()
  
  
   CALL cl_set_comp_visible('l_amt1,l_amt2,l_amt3,l_amt4,l_amt5',TRUE)
   CALL cl_set_comp_visible('l_amt6,l_amt7,l_amt8,l_amt9,l_amt10',TRUE)
   CALL cl_set_comp_visible('l_amt11,l_amt12,l_amt13',TRUE)  
       
   CALL cl_set_combo_scc('b_bggo022','6013')      #經營方式
   CALL cl_set_combo_scc('b_bggo022_2','6013')    #經營方式
   
   LET g_input.l_lowersite = 'Y'    #含下層組織
   LET g_input.l_curr      = 'Y'    #顯示交易原幣
   LET g_input.bggo001     = '20'  
   LET g_input.l_type      = '2'    #維度選項
   LET g_input.bggostus    = '3'    #狀態碼別
   LET g_input.hsx_bggo039 = 'Y'    #核算項 --s
   LET g_input.hsx_bggo012 = 'N'
   LET g_input.hsx_bggo013 = 'N'
   LET g_input.hsx_bggo014 = 'N'
   LET g_input.hsx_bggo015 = 'N'
   LET g_input.hsx_bggo016 = 'N'
   LET g_input.hsx_bggo017 = 'N'
   LET g_input.hsx_bggo018 = 'N'
   LET g_input.hsx_bggo019 = 'N'
   LET g_input.hsx_bggo020 = 'N'
   LET g_input.hsx_bggo021 = 'N'
   LET g_input.hsx_bggo022 = 'N'
   LET g_input.hsx_bggo023 = 'N'
   LET g_input.hsx_bggo024 = 'N'   #核算項 --e

   DISPLAY BY NAME g_input.l_lowersite,g_input.l_curr,
                   g_input.hsx_bggo039,g_input.hsx_bggo012,g_input.hsx_bggo013,g_input.hsx_bggo014,
                   g_input.hsx_bggo015,g_input.hsx_bggo016,g_input.hsx_bggo017,g_input.hsx_bggo018,
                   g_input.hsx_bggo019,g_input.hsx_bggo020,g_input.hsx_bggo021,g_input.hsx_bggo022,
                   g_input.hsx_bggo023,g_input.hsx_bggo024,g_input.bggostus
END FUNCTION

################################################################################
# Descriptions...: 依條件展tree
# Memo...........:
# Usage..........: CALL abgq710_grow_tree()
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_grow_tree()
DEFINE l_root    DYNAMIC ARRAY OF RECORD
         bggo037 LIKE bggo_t.bggo037, #上層組織
         bggo007 LIKE bggo_t.bggo007  #預算組織
                 END RECORD
DEFINE l_idx     LIKE type_t.num5     #array index
DEFINE l_sql     STRING
#從pid串取得實際pid用-----s
DEFINE l_iddummy LIKE type_t.num5
DEFINE l_idroot  LIKE type_t.num5
DEFINE l_string  STRING   
DEFINE l_pid     LIKE type_t.num5
#從pid串取得實際pid用-----e        
   
   #如不展下層組織,隱藏組織樹結構區塊
   CALL cl_set_comp_visible('vbox_2',TRUE)
   IF g_input.l_lowersite = 'N' THEN 
      CALL cl_set_comp_visible('vbox_2',FALSE)
      RETURN 
   END IF
   
   #畫面上key資訊為空則不展樹
   IF cl_null(g_input.bggo002) OR cl_null(g_input.bggo003) OR cl_null(g_input.bggo007) THEN
      RETURN
   END IF
   
   CALL g_tree.clear()
   #FOREACH 根節點 存成ARRAY
   LET l_sql = "SELECT UNIQUE ooed005,ooed004 FROM ooed_t ",
               " WHERE ooedent = ",g_enterprise,
               "   AND ooed001  = '4'",
               "   AND ooed002 = (SELECT bgaa011 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bggo002,"' AND bgaastus = 'Y' ) ", #最上層組織
               "   AND ooed003 = (SELECT bgaa010 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bggo002,"' AND bgaastus = 'Y' ) ", #版本
               "   AND ooed004 = '",g_input.bggo007,"' ",
               "   AND ooed005 = '",g_input.bggo007,"' " #上級組織編號
               
   PREPARE sel_abgq710_rootp1 FROM l_sql
   DECLARE sel_abgq710_rootc1 CURSOR FOR sel_abgq710_rootp1
   
   LET l_idx = 1 
   FOREACH sel_abgq710_rootc1 INTO l_root[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF
      
      LET l_idx = l_idx + 1
   END FOREACH
   CALL l_root.deleteElement(l_idx)
   
   IF l_root.getLength() <= 0 THEN
      LET g_tree[1].show = g_input.bggo007,'-',s_desc_get_department_desc(g_input.bggo007)
      LET g_tree[1].pid  = g_tree_pid CLIPPED
      LET g_tree[1].id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
      LET g_tree[1].exp  = 'TRUE'
      LET g_tree[1].isExp = FALSE
      LET g_tree[1].expcode = FALSE  
      LET g_tree[1].hasC = TRUE
      LET g_tree[1].bggo037 = g_input.bggo007   
      LET l_root[1].bggo007 = g_input.bggo007
      RETURN
   END IF
   #用存起來的根節點呼叫遞迴
   LET g_tree_idx = 1
   
   FOR l_idx = 1 TO l_root.getLength()
      LET g_tree_pid = '0'    #代表是起始節點
      CALL abgq710_grow_tree_node(l_root[l_idx].bggo037)
   END FOR

   #如果是最根節點時KEY值會為空
   #此時就要把上層節點的資料KEY給進去
   #方便後續重show畫面
   FOR l_idx = 1 TO g_tree.getLength()
      IF cl_null(g_tree[l_idx].bggo037)THEN
         LET l_string = g_tree[l_idx].pid
         LET l_iddummy = 1
         LET l_idroot = 0
         WHILE TRUE
            LET l_iddummy = l_string.getIndexOf('.',l_iddummy)
            IF l_iddummy = 0 THEN 
               EXIT WHILE
            ELSE
               LET l_idroot = l_iddummy + 1
            END IF
            LET l_iddummy = l_iddummy + 1
         END WHILE

         LET l_string = l_string.substring(l_idroot,l_string.getLength())
         LET l_pid = l_string
         IF NOT cl_null(l_pid) AND l_pid > 0 THEN 
            LET g_tree[l_idx].bggo037 = g_tree[l_pid].bggo037 
         END IF
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 根節點以外往下長節點
# Memo...........:
# Usage..........: CALL abgq710_grow_tree_node(p_ooed005)
# Date & Author..: 161212 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_grow_tree_node(p_ooed005)
DEFINE p_ooed005  LIKE ooed_t.ooed005
DEFINE l_node     DYNAMIC ARRAY OF RECORD
         bggo037  LIKE bggo_t.bggo037, #上層組織
         bggo007  LIKE bggo_t.bggo007  #預算組織
                  END RECORD                    
DEFINE l_idx      LIKE type_t.num10
DEFINE l_id       LIKE type_t.chr100
DEFINE l_sql      STRING
DEFINE l_field    LIKE type_t.chr100

   #用傳入的根節點 FOREACH 抓下節點放入l_node
   LET l_sql = "SELECT UNIQUE ooed005,ooed004 FROM ooed_t ",
               " WHERE ooedent = ",g_enterprise,
               "   AND ooed001  = '4'",
               "   AND ooed002 = (SELECT bgaa011 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bggo002,"' AND bgaastus = 'Y' ) ", #最上層組織
               "   AND ooed003 = (SELECT bgaa010 FROM bgaa_t WHERE bgaaent = ",g_enterprise," AND bgaa001 = '",g_input.bggo002,"' AND bgaastus = 'Y' ) ", #版本
               "   AND ooed005 = '",p_ooed005,"' ",  #上級組織編號
               "   AND ooed004 <> '",p_ooed005,"'  " #排除自己,以免落無窮迴圈  
               
   PREPARE sel_abgq710_nodep1 FROM l_sql
   DECLARE sel_abgq710_nodec1 CURSOR FOR sel_abgq710_nodep1
          
   CALL l_node.clear()
   LET l_idx = 1    
   FOREACH sel_abgq710_nodec1 INTO l_node[l_idx].*
      IF SQLCA.SQLCODE THEN
         EXIT FOREACH
      END IF

      LET l_idx = l_idx + 1
   END FOREACH

   #如果l_idx = 1 代表沒往下的節點
   #          > 1 代表有往下的節點
   #把上層節點給到g_tree去
   #g_tree_idx + 1
   LET g_tree[g_tree_idx].show = p_ooed005,'-',s_desc_get_department_desc(p_ooed005)
   LET g_tree[g_tree_idx].pid  = g_tree_pid CLIPPED
   LET g_tree[g_tree_idx].id   = g_tree_pid CLIPPED,'.',g_tree_idx USING '<<<<<<<<<<<<<<<<'
   LET g_tree[g_tree_idx].exp  = 'TRUE'
   LET g_tree[g_tree_idx].isExp = FALSE
   LET g_tree[g_tree_idx].expcode = FALSE   #每個節點都收起來
   
   IF l_idx = 1 THEN
   ELSE
      LET g_tree[g_tree_idx].hasC = TRUE
      LET g_tree[g_tree_idx].bggo037 = p_ooed005
   END IF
   IF g_tree_pid = '0' THEN
      LET g_tree[g_tree_idx].hasC = TRUE
      LET g_tree[g_tree_idx].bggo037 = p_ooed005
   END IF
   LET l_id = g_tree[g_tree_idx].id    #自己是誰要記錄
   LET g_tree_idx = g_tree_idx + 1
  
   CALL l_node.deleteElement(l_idx)   

   #FOR 跑遞迴 再往下找節點
   FOR l_idx = 1 TO l_node.getLength()   
      LET g_tree_pid = l_id CLIPPED 
      LET g_tree[g_tree_idx].bggo037 = l_node[l_idx].bggo037      
      LET g_tree[g_tree_idx].bggo007 = l_node[l_idx].bggo007      
      CALL abgq710_grow_tree_node(l_node[l_idx].bggo007)
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 核算項顯示否
# Memo...........:
# Usage..........: CALL abgq710_set_title()
# Date & Author..: 161214 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_set_title()
DEFINE l_title           LIKE gzzd_t.gzzd005
DEFINE l_yy              LIKE type_t.num5
DEFINE l_i               LIKE type_t.num5
DEFINE l_title_name      STRING
DEFINE l_title_1         STRING
DEFINE l_bgac002         LIKE bgac_t.bgac002
DEFINE l_i_str           STRING
DEFINE l_yy_str          STRING
DEFINE l_bggo007_str     STRING
DEFINE l_hsx_wc RECORD
       bggo012   LIKE type_t.chr1,
       bggo013   LIKE type_t.chr1,
       bggo014   LIKE type_t.chr1,
       bggo015   LIKE type_t.chr1,
       bggo016   LIKE type_t.chr1,
       bggo017   LIKE type_t.chr1,
       bggo018   LIKE type_t.chr1,
       bggo019   LIKE type_t.chr1,
       bggo020   LIKE type_t.chr1,
       bggo021   LIKE type_t.chr1,
       bggo022   LIKE type_t.chr1,
       bggo023   LIKE type_t.chr1,
       bggo024   LIKE type_t.chr1       
END RECORD
DEFINE l_sql STRING
DEFINE l_bggo039 LIKE bggo_t.bggo039
DEFINE l_bgg007  LIKE bggo_t.bggo007
DEFINE l_array DYNAMIC ARRAY OF RECORD
             chr1   LIKE type_t.chr1
       END RECORD
DEFINE l_bggo007 LIKE bggo_t.bggo007
DEFINE l_bgaw002 LIKE bgaw_t.bgaw002
DEFINE l_bgaw005 LIKE bgaw_t.bgaw005
DEFINE l_bggo011 LIKE bggo_t.bggo011
   
   IF g_input.l_lowersite = 'Y' THEN
       CALL s_abgt026_get_dnstep_site(g_input.bggo002,'','',g_input.bggo007)
       RETURNING l_bggo007_str
   ELSE
      LET l_bggo007_str = g_input.bggo007 
   END IF
   IF cl_null(l_bggo007_str) THEN LET l_bggo007_str = g_input.bggo007 END IF
   CALL s_fin_get_wc_str(l_bggo007_str) RETURNING l_bggo007_str 
  
   LET g_xgrid_visible_column = "#@!" #xg 核算項隱顯
   #核算項顯示否----------------
   CALL cl_set_comp_visible("bggo039_desc,bggo040_desc,bggo012_desc,bggo013_desc",TRUE)
   CALL cl_set_comp_visible("bggo014_desc,bggo015_desc,bggo016_desc",TRUE)
   CALL cl_set_comp_visible("bggo017_desc,bggo018_desc,bggo019_desc",TRUE)
   CALL cl_set_comp_visible("bggo020_desc,bggo021_desc,b_bggo022",TRUE)
   CALL cl_set_comp_visible("bggo023_desc,bggo024_desc",TRUE)

   LET g_hsx_wc  = " 1=1"
    
   LET g_select_field = " ''    ,bggo007,''     ,bggo009,''      ,      ",
                        " bggo012,''     ,bggo013,''     ,bggo014,'',   ",
                        " bggo015,''     ,bggo016,''     ,bggo017,'',   ",
                        " bggo018,''     ,bggo019,''     ,bggo020,'',   ",
                        " bggo021,''     ,bggo022,bggo023,''     ,      ",
                        " bggo024,''     ,                              ",
                        " bggo100,SUM(bggo106) ,SUM(bggo101*bggo106),   ",
                        " bggo039,'',bggo040,'',bggo011                  "                                        
   #預算細項 #依照畫面樣表
   IF g_input.l_type = '2' THEN   
      IF g_input.hsx_bggo039 = 'Y' THEN
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo039,bggo040"
      ELSE
         CALL cl_set_comp_visible("bggo039_desc,bggo040_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo039',"''")
         LET g_select_field = cl_replace_str(g_select_field,'bggo040',"''")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo039_desc|l_bggo040_desc"
      END IF 
      #人員
      IF g_input.hsx_bggo012 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo012"
      ELSE
         CALL cl_set_comp_visible("bggo012_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo012',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo012_desc"         
      END IF   
      #部門
      IF g_input.hsx_bggo013 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo013"
      ELSE
         CALL cl_set_comp_visible("bggo013_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo013',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo013_desc"         
      END IF   
      #成本利潤中心
      IF g_input.hsx_bggo014 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo014"
      ELSE
         CALL cl_set_comp_visible("bggo014_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo014',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo014_desc"         
      END IF
      #區域
      IF g_input.hsx_bggo015 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo015"
      ELSE
         CALL cl_set_comp_visible("bggo015_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo015',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo015_desc"         
      END IF   
      #收付款客商
      IF g_input.hsx_bggo016 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo016"
      ELSE
         CALL cl_set_comp_visible("bggo016_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo016',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo016_desc"                  
      END IF   
      #帳款客商
      IF g_input.hsx_bggo017 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo017"
      ELSE
         CALL cl_set_comp_visible("bggo017_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo017',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo017_desc"                  
      END IF  
      #客群
      IF g_input.hsx_bggo018 = 'Y' THEN
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo018"
      ELSE
         CALL cl_set_comp_visible("bggo018_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo018',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo018_desc"                  
      END IF     
      #產品類別
      IF g_input.hsx_bggo019 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo019"
      ELSE
         CALL cl_set_comp_visible("bggo019_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo019',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo019_desc"                  
      END IF  
      #專案編號
      IF g_input.hsx_bggo020 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo020"
      ELSE
         CALL cl_set_comp_visible("bggo020_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo020',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo020_desc"                  
      END IF  
      #WBS
      IF g_input.hsx_bggo021 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo021"
      ELSE
         CALL cl_set_comp_visible("bggo021_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo021',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo021_desc"                  
      END IF  
      #經營方式
      IF g_input.hsx_bggo022 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo022"
      ELSE
         CALL cl_set_comp_visible("b_bggo022",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo022',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo022_desc"                  
      END IF  
      #通路
      IF g_input.hsx_bggo023 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo023"
      ELSE
         CALL cl_set_comp_visible("bggo023_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo023',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo023_desc"                  
      END IF  
      #品牌
      IF g_input.hsx_bggo024 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo024"
      ELSE
         CALL cl_set_comp_visible("bggo024_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo024',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo024_desc"                  
      END IF  
      LET g_select_field = cl_replace_str(g_select_field,'bggo011',"' '")
   ELSE    
      LET l_hsx_wc.bggo012 ='Y'
      LET l_hsx_wc.bggo013 ='Y'
      LET l_hsx_wc.bggo014 ='Y'
      LET l_hsx_wc.bggo015 ='Y'
      LET l_hsx_wc.bggo016 ='Y'
      LET l_hsx_wc.bggo017 ='Y'
      LET l_hsx_wc.bggo018 ='Y'
      LET l_hsx_wc.bggo019 ='Y'
      LET l_hsx_wc.bggo020 ='Y'
      LET l_hsx_wc.bggo021 ='Y'
      LET l_hsx_wc.bggo022 ='Y'
      LET l_hsx_wc.bggo023 ='Y'
      LET l_hsx_wc.bggo024 ='Y'   
      LET l_sql = " SELECT bgaw002,bgaw005           ",
            "  FROM bgaw_t                           ",
            " WHERE bgawent = '",g_enterprise,"'     ",
            "   AND bgaw001 =  ?                     ",
            "   ORDER BY bgaw002                     "
      PREPARE abgq710_bgaw005_p FROM l_sql
      DECLARE abgq710_bgaw005_c CURSOR FOR abgq710_bgaw005_p
   
      LET l_sql = " SELECT DISTINCT bggo011 FROM bggo_t    ",
                  "  WHERE bggoent = ",g_enterprise,"      ",
                  "    AND bggo002 = '",g_input.bggo002,"' ",
                  "    AND bggo003 = '",g_input.bggo003,"' ",
                  "    AND bggo007 IN ",l_bggo007_str 
      PREPARE abgq710_bggo011_p FROM l_sql
      DECLARE abgq710_bggo011_c CURSOR FOR abgq710_bggo011_p
      FOREACH abgq710_bggo011_c INTO l_bggo011
         FOREACH abgq710_bgaw005_c USING l_bggo011 INTO l_bgaw002,l_bgaw005 
            CASE l_bgaw002 
               WHEN 1  #預算組織
               WHEN 2  #預算細項
               WHEN 3  #部門
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo013 ='N' END IF        
               WHEN 4  #利潤成本中心
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo014 ='N' END IF        
               WHEN 5  #區域
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo015 ='N' END IF       
               WHEN 6  #收付款客商
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo016 ='N' END IF       
               WHEN 7 #帳款客戶
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo017 ='N' END IF       
               WHEN 8 #客群
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo018 ='N' END IF       
               WHEN 9 #產品類別
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo019 ='N' END IF       
               WHEN 10 #經營方式
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo022 ='N' END IF          
               WHEN 11 #通路
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo023 ='N' END IF          
               WHEN 12 #品牌
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo024 ='N' END IF 
               WHEN 13 #人員
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo012 ='N' END IF      
               WHEN 14 #專案編號
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo020 ='N' END IF      
               WHEN 15 #WBS
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo021 ='N' END IF                   
            END CASE                       
         END FOREACH                              
      END FOREACH
      #人員
      IF l_hsx_wc.bggo012 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo012"
      ELSE
         CALL cl_set_comp_visible("bggo012_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo012',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo012_desc"                  
      END IF   
      #部門
      IF l_hsx_wc.bggo013 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo013"
      ELSE
         CALL cl_set_comp_visible("bggo013_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo013',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo013_desc"                  
      END IF   
      #成本利潤中心
      IF l_hsx_wc.bggo014 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo014"
      ELSE
         CALL cl_set_comp_visible("bggo014_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo014',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo014_desc"                  
      END IF
      #區域
      IF l_hsx_wc.bggo015 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo015"
      ELSE
         CALL cl_set_comp_visible("bggo015_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo015',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo015_desc"                  
      END IF   
      #收付款客商
      IF l_hsx_wc.bggo016 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo016"
      ELSE
         CALL cl_set_comp_visible("bggo016_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo016',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo016_desc"                  
      END IF   
      #帳款客商
      IF l_hsx_wc.bggo017 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo017"
      ELSE
         CALL cl_set_comp_visible("bggo017_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo017',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo017_desc"                  
      END IF  
      #客群
      IF l_hsx_wc.bggo018 = 'Y' THEN
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo018"
      ELSE
         CALL cl_set_comp_visible("bggo018_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo018',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo018_desc"                  
      END IF     
      #產品類別
      IF l_hsx_wc.bggo019 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo019"
      ELSE
         CALL cl_set_comp_visible("bggo019_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo019',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo019_desc"                  
      END IF  
      #專案編號
      IF l_hsx_wc.bggo020 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo020"
      ELSE
         CALL cl_set_comp_visible("bggo020_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo020',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo020_desc"                  
      END IF  
      #WBS
      IF l_hsx_wc.bggo021 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo021"
      ELSE
         CALL cl_set_comp_visible("bggo021_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo021',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo021_desc"                  
      END IF  
      #經營方式
      IF l_hsx_wc.bggo022 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo022"
      ELSE
         CALL cl_set_comp_visible("b_bggo022",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo022',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo022_desc"                  
      END IF  
      #通路
      IF l_hsx_wc.bggo023 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo023"
      ELSE
         CALL cl_set_comp_visible("bggo023_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo023',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo023_desc"                  
      END IF  
      #品牌
      IF l_hsx_wc.bggo024 = 'Y' THEN 
         LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo024"
      ELSE
         CALL cl_set_comp_visible("bggo024_desc",FALSE)
         LET g_select_field = cl_replace_str(g_select_field,'bggo024',"' '")
         LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_bggo024_desc"                  
      END IF  
           
      LET g_hsx_wc = g_hsx_wc CLIPPED,",bggo011,bggo039,bggo040 "
      
   END IF    
   IF g_input.l_curr = 'N' THEN
      LET g_xgrid_visible_column = g_xgrid_visible_column CLIPPED ,"|l_amt"
   END IF     
   #xg核算項
   LET g_xgrid_visible_column = cl_replace_str(g_xgrid_visible_column,'#@!|','')
   LET g_xgrid_visible_column = cl_replace_str(g_xgrid_visible_column,'#@!','')
   
   #第二單身
   LET l_hsx_wc.bggo012 ='N'  LET l_hsx_wc.bggo013 ='N'  LET l_hsx_wc.bggo014 ='N'
   LET l_hsx_wc.bggo015 ='N'  LET l_hsx_wc.bggo016 ='N'  LET l_hsx_wc.bggo017 ='N'
   LET l_hsx_wc.bggo018 ='N'  LET l_hsx_wc.bggo019 ='N'  LET l_hsx_wc.bggo020 ='N'
   LET l_hsx_wc.bggo021 ='N'  LET l_hsx_wc.bggo022 ='N'  LET l_hsx_wc.bggo023 ='N'
   LET l_hsx_wc.bggo024 ='N'   
         
   CALL l_array.clear()
   #單身核算項 取得abgi110 需要開那些欄位。
   LET l_sql = " SELECT bgal005,bgal006,bgal007,bgal008,bgal009, ", #部門/成本中心/區域/交易客商/收款客商
               "        bgal010,bgal011,bgal012,bgal013,bgal014, ", #客群/產品類別/人員/專案編號/WBS
               "        bgal025,bgal026,bgal027                  ", #經營方式/通路/品牌
               "   FROM bgal_t                                   ",
               "  WHERE bgalent = ",g_enterprise,"               ",
               "    AND bgal001 = '",g_input.bggo002,"'          ",
               "    AND bgal002 = ? AND bgal003 = ?              "                
   PREPARE abgq710_detail2_set1_p FROM l_sql
      
   LET l_sql = " SELECT DISTINCT bggo007,bggo039 FROM bggo_t    ",
               " WHERE bggoent = ",g_enterprise,"       ",
               "    AND bggo002 = '",g_input.bggo002,"' ",
               "    AND bggo003 = '",g_input.bggo003,"' ",
               "    AND bggo007 IN ",l_bggo007_str 
   PREPARE abgq710_detail2_set2_p FROM l_sql
   DECLARE abgq710_detail2_set2_c CURSOR FOR abgq710_detail2_set2_p
   FOREACH abgq710_detail2_set2_c INTO l_bggo007,l_bggo039
      EXECUTE abgq710_detail2_set1_p USING l_bggo007,l_bggo039 INTO
         l_array[1].chr1 ,l_array[2].chr1 ,l_array[3].chr1 ,l_array[4].chr1,l_array[5].chr1,
         l_array[6].chr1 ,l_array[7].chr1 ,l_array[8].chr1 ,l_array[9].chr1,l_array[10].chr1,
         l_array[11].chr1,l_array[12].chr1,l_array[13].chr1,l_array[14].chr1
      IF l_array[1].chr1  = 'Y' THEN LET l_hsx_wc.bggo013 = 'Y' END IF   #部門
      IF l_array[2].chr1  = 'Y' THEN LET l_hsx_wc.bggo014 = 'Y' END IF   #成本中心
      IF l_array[3].chr1  = 'Y' THEN LET l_hsx_wc.bggo015 = 'Y' END IF   #區域
      IF l_array[4].chr1  = 'Y' THEN LET l_hsx_wc.bggo016 = 'Y' END IF   #交易客商
      IF l_array[5].chr1  = 'Y' THEN LET l_hsx_wc.bggo017 = 'Y' END IF   #收款客商
      IF l_array[6].chr1  = 'Y' THEN LET l_hsx_wc.bggo018 = 'Y' END IF   #客群
      IF l_array[7].chr1  = 'Y' THEN LET l_hsx_wc.bggo019 = 'Y' END IF   #產品類別
      IF l_array[8].chr1  = 'Y' THEN LET l_hsx_wc.bggo012 = 'Y' END IF   #人員
      IF l_array[9].chr1  = 'Y' THEN LET l_hsx_wc.bggo020 = 'Y' END IF   #專案編號
      IF l_array[10].chr1 = 'Y' THEN LET l_hsx_wc.bggo021 = 'Y' END IF   #WBS
      IF l_array[11].chr1 = 'Y' THEN LET l_hsx_wc.bggo022 = 'Y' END IF   #經營方式
      IF l_array[12].chr1 = 'Y' THEN LET l_hsx_wc.bggo023 = 'Y' END IF   #通路
      IF l_array[13].chr1 = 'Y' THEN LET l_hsx_wc.bggo024 = 'Y' END IF   #品牌   
   END FOREACH
   CALL cl_set_comp_visible("bggo012_desc_2,bggo013_desc_2,bggo014_desc_2,bggo015_desc_2",TRUE)
   CALL cl_set_comp_visible("bggo016_desc_2,bggo017_desc_2,bggo018_desc_2,bggo019_desc_2",TRUE)   
   CALL cl_set_comp_visible("bggo020_desc_2,bggo021_desc_2,bggo022_desc_2,bggo023_desc_2,bggo024_desc_2",TRUE)   
   
   #人員
   IF l_hsx_wc.bggo012 = 'N' THEN CALL cl_set_comp_visible("bggo012_desc_2",FALSE) END IF   
   #部門
   IF l_hsx_wc.bggo013 = 'N' THEN CALL cl_set_comp_visible("bggo013_desc_2",FALSE) END IF   
   #成本利潤中心
   IF l_hsx_wc.bggo014 = 'N' THEN CALL cl_set_comp_visible("bggo014_desc_2",FALSE) END IF
   #區域
   IF l_hsx_wc.bggo015 = 'N' THEN CALL cl_set_comp_visible("bggo015_desc_2",FALSE) END IF
   #收付款客商
   IF l_hsx_wc.bggo016 = 'N' THEN CALL cl_set_comp_visible("bggo016_desc_2",FALSE) END IF   
   #帳款客商
   IF l_hsx_wc.bggo017 = 'N' THEN CALL cl_set_comp_visible("bggo017_desc_2",FALSE) END IF  
   #客群
   IF l_hsx_wc.bggo018 = 'N' THEN CALL cl_set_comp_visible("bggo018_desc_2",FALSE) END IF     
   #產品類別
   IF l_hsx_wc.bggo019 = 'N' THEN CALL cl_set_comp_visible("bggo019_desc_2",FALSE) END IF  
   #專案編號
   IF l_hsx_wc.bggo020 = 'N' THEN CALL cl_set_comp_visible("bggo020_desc_2",FALSE) END IF  
   #WBS
   IF l_hsx_wc.bggo021 = 'N' THEN CALL cl_set_comp_visible("bggo021_desc_2",FALSE) END IF  
   #經營方式
   IF l_hsx_wc.bggo022 = 'N' THEN CALL cl_set_comp_visible("b_bggo022_2",FALSE) END IF  
   #通路
   IF l_hsx_wc.bggo023 = 'N' THEN CALL cl_set_comp_visible("bggo023_desc_2",FALSE) END IF  
   #品牌
   IF l_hsx_wc.bggo024 = 'N' THEN CALL cl_set_comp_visible("bggo024_desc_2",FALSE) END IF  
             
  
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL abgq710_creat_temp()
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_creat_temp()
       
       
       
 #幣別小計
   DROP TABLE abgq710_currtmp;
   CREATE TEMP TABLE abgq710_currtmp(
      bggo100     LIKE bggo_t.bggo100, 
      bggo106     LIKE type_t.num20_6, 
      l_amt       LIKE type_t.num20_6
                )                 
              
       
       
       
   #xg列印    
   DROP TABLE abgq710_x01_tmp;
   CREATE TEMP TABLE abgq710_x01_tmp(
      bggo002_desc  LIKE type_t.chr100,     #單頭
      bggo003         LIKE bggo_t.bggo003, 
      bggo007_desc  LIKE type_t.chr100, 
      lowersite     LIKE type_t.chr1,       #含下層組織
      bgaa003       LIKE bgaa_t.bgaa003,    #預算幣別
      bggo001       LIKE type_t.chr100,     #來源作業
      type_desc     LIKE type_t.chr100,  
      bggostus      LIKE type_t.chr100, 
      curr          LIKE type_t.chr100,     #顯示預算幣別
      bggoseq       LIKE bggo_t.bggoseq,    #第一單身
      bggo007_2_desc  LIKE type_t.chr100, 
      bggo009_desc  LIKE type_t.chr100, 
      bggo012_desc  LIKE type_t.chr100, 
      bggo013_desc  LIKE type_t.chr100, 
      bggo014_desc  LIKE type_t.chr100, 
      bggo015_desc  LIKE type_t.chr100, 
      bggo016_desc  LIKE type_t.chr100, 
      bggo017_desc  LIKE type_t.chr100, 
      bggo018_desc  LIKE type_t.chr100, 
      bggo019_desc  LIKE type_t.chr100, 
      bggo020_desc  LIKE type_t.chr100, 
      bggo021_desc  LIKE type_t.chr100, 
      bggo022_desc  LIKE type_t.chr100, 
      bggo023_desc  LIKE type_t.chr500, 
      bggo024_desc  LIKE type_t.chr100, 
      bggo100       LIKE bggo_t.bggo100, 
      bggo106       LIKE type_t.num20_6, 
      amt           LIKE type_t.num20_6,
      bggo039_desc  LIKE type_t.chr100,
      bggo040_desc  LIKE type_t.chr100   
      )       
      
            
   #xg列印-子報表
   DROP TABLE abgq710_x01_tmp1;
   CREATE TEMP TABLE abgq710_x01_tmp1(
        bggoseq        LIKE bggo_t.bggoseq,
        bggo007_desc   LIKE type_t.chr100, 
        bggo041_desc   LIKE type_t.chr100,
        bggo042_desc   LIKE type_t.chr100,
        bggo043_desc   LIKE type_t.chr100,
        bggo044_desc   LIKE type_t.chr100,
        bggo012_desc   LIKE type_t.chr100, 
        bggo013_desc   LIKE type_t.chr100, 
        bggo014_desc   LIKE type_t.chr100,        
        bggo015_desc   LIKE type_t.chr100, 
        bggo016_desc   LIKE type_t.chr100, 
        bggo017_desc   LIKE type_t.chr100, 
        bggo018_desc   LIKE type_t.chr100, 
        bggo019_desc   LIKE type_t.chr100, 
        bggo020_desc   LIKE type_t.chr100, 
        bggo021_desc   LIKE type_t.chr100, 
        bggo022_desc   LIKE bggo_t.bggo022, 
        bggo023_desc   LIKE type_t.chr500, 
        bggo024_desc   LIKE type_t.chr100, 
        l_use1         LIKE bggo_t.bggo035,
        l_accept1      LIKE bggo_t.bggo106, 
        l_amt1         LIKE type_t.num20_6, 
        l_use2         LIKE bggo_t.bggo035,
        l_accept2      LIKE bggo_t.bggo106, 
        l_amt2         LIKE type_t.num20_6, 
        l_use3         LIKE bggo_t.bggo035,
        l_accept3      LIKE bggo_t.bggo106, 
        l_amt3         LIKE type_t.num20_6, 
        l_use4         LIKE bggo_t.bggo035,
        l_accept4      LIKE bggo_t.bggo106, 
        l_amt4         LIKE type_t.num20_6, 
        l_use5         LIKE bggo_t.bggo035,
        l_accept5      LIKE bggo_t.bggo106, 
        l_amt5         LIKE type_t.num20_6, 
        l_use6         LIKE bggo_t.bggo035,
        l_accept6      LIKE bggo_t.bggo106, 
        l_amt6         LIKE type_t.num20_6, 
        l_use7         LIKE bggo_t.bggo035,
        l_accept7      LIKE bggo_t.bggo106, 
        l_amt7         LIKE type_t.num20_6, 
        l_use8         LIKE bggo_t.bggo035,
        l_accept8      LIKE bggo_t.bggo106, 
        l_amt8         LIKE type_t.num20_6, 
        l_use9         LIKE bggo_t.bggo035,
        l_accept9      LIKE bggo_t.bggo106, 
        l_amt9         LIKE type_t.num20_6, 
        l_use10        LIKE bggo_t.bggo035,
        l_accept10     LIKE bggo_t.bggo106, 
        l_amt10        LIKE type_t.num20_6, 
        l_use11        LIKE bggo_t.bggo035,
        l_accept11     LIKE bggo_t.bggo106, 
        l_amt11        LIKE type_t.num20_6, 
        l_use12        LIKE bggo_t.bggo035,
        l_accept12     LIKE bggo_t.bggo106, 
        l_amt12        LIKE type_t.num20_6, 
        l_use13        LIKE bggo_t.bggo035,
        l_accept13     LIKE bggo_t.bggo106, 
        l_amt13        LIKE type_t.num20_6,
        bggoseq2       LIKE bggo_t.bggoseq
        )
END FUNCTION

################################################################################
# Descriptions...: 寫入tmp
# Memo...........:
# Usage..........: CALL abgq710_insert_temp()
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_insert_temp()
DEFINE l_sql         STRING
DEFINE l_bggo007_str STRING
DEFINE l_periods     STRING
DEFINE l_bggo033     LIKE bgie_t.bgie033  #往來類型
DEFINE l_bgap004_str STRING               #關係人選項
DEFINE l_tmp         RECORD
         bggo007     LIKE bggo_t.bggo007, #預算組織
         bggo039     LIKE bggo_t.bggo039, #預算細項      
         bggo012     LIKE bggo_t.bggo012, #人員
         bggo013     LIKE bggo_t.bggo013, #部門
         bggo014     LIKE bggo_t.bggo014, #成本利潤中心
         bggo015     LIKE bggo_t.bggo015, #區域
         bggo016     LIKE bggo_t.bggo016, #收付款客商
         bggo017     LIKE bggo_t.bggo017, #帳款客商
         bggo018     LIKE bggo_t.bggo018, #客群
         bggo019     LIKE bggo_t.bggo019, #產品類別
         bggo020     LIKE bggo_t.bggo020, #專案編號
         bggo021     LIKE bggo_t.bggo021, #WBS
         bggo022     LIKE bggo_t.bggo022, #經營方式
         bggo023     LIKE bggo_t.bggo023, #通路
         bggo024     LIKE bggo_t.bggo024, #品牌
         bgie034     LIKE bgie_t.bgie034, #借貸別
         #l_beg_amt   LIKE bggo_t.bggo103, #期初金額  #1220
         l_amt_d     LIKE bggo_t.bggo103, #借方金額 
         l_amt_c     LIKE bggo_t.bggo103, #貸方金額 
         bggo100     LIKE bggo_t.bggo100, #交易幣別
         bggo103     LIKE bggo_t.bggo103, #本幣交易金額
         bggo106     LIKE bggo_t.bggo106, #原幣交易金額
         l_yymm      LIKE type_t.chr100   #年度月份
                     END RECORD
#DEFINE l_begin_amt_sql  STRING  
#DEFINE l_t040_hsx_wc    STRING  
#DEFINE l_sum_bgbj032    LIKE bgbj_t.bgbj032
#DEFINE l_sum_bgbj033    LIKE bgbj_t.bgbj033

   #前置條件處理--------------------------------------------------s
   IF cl_null(g_bggo007) THEN 
      RETURN 
   ELSE
      LET l_bggo007_str = "('",g_bggo007,"')" 
   END IF
        
   #前置條件處理--------------------------------------------------e
   
   
   DELETE FROM abgq710_tmp   
               #預算組織/預算細項/預算期別/帳款日期/#現金收支日期 
   #LET l_sql = " SELECT bggo007,bggo039,bggo008,bgie031,bgie032, ",
               #預算組織/預算細項/人員/部門/成本利潤中心
   LET l_sql = " SELECT bggo007,bggo039,bggo012,bggo013,bggo014, ",
               #區域/收付款客商/帳款客商/客群/產品類別
               "        bggo015,bggo016,bggo017,bggo018,bggo019, ",
               #專案編號/WBS/經營方式/通路/品牌
               "        bggo020,bggo021,bggo022,bggo023,bggo024, ",
               #借貸別/借方金額/貸方金額/交易幣別/本幣交易金額
               "        bgie034,bggo103,bggo103,bggo100,bggo103, ",
               #原幣交易金額/年度期別
               "        bggo106,",l_periods,"  ",    
               "   FROM bggo_t ",
               "  WHERE bggoent = ",g_enterprise," ",        #企業編號
               "    AND bggo002 = '",g_input.bggo002,"' ",   #預算編號
               "    AND bggo003 = '",g_input.bggo003,"' ",   #預算版本
               "    AND bggo007 IN ",l_bggo007_str," ",      #預算組織
               "    AND bgie033 = '",l_bggo033,"' ",         #往來類型
               "    AND ",l_bgap004_str," ",                 #關係人選項
               "    AND ",g_wc3                              #QBE條件

   PREPARE abgq710_pb1 FROM l_sql
   DECLARE abgq710_c1 CURSOR FOR abgq710_pb1   
   FOREACH abgq710_c1 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "FOREACH:abgq710_c1"
         LET g_errparam.code   = SQLCA.sqlcode
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
     
      ##串出核算項條件
      #LET l_t040_hsx_wc = " 1=1"
      ##預算細項
      ##IF g_input.hsx_bggo039 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj003 = '",l_tmp.bggo039,"' "             
      ##END IF   
      ##人員
      ##IF g_input.hsx_bggo012 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj012 = '",l_tmp.bggo012,"' "
      ##END IF       
      ##部門
      ##IF g_input.hsx_bggo013 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj005 = '",l_tmp.bggo013,"' "     
      ##END IF  
      ##成本利潤中心
      ##IF g_input.hsx_bggo014 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj006 = '",l_tmp.bggo014,"' "    
      ##END IF
      ##區域
      ##IF g_input.hsx_bggo015 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj007 = '",l_tmp.bggo015,"' "      
      ##END IF   
      ##收付款客商
      ##IF g_input.hsx_bggo016 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj008 = '",l_tmp.bggo016,"' "    
      ##END IF 
      ##帳款客商
      ##IF g_input.hsx_bggo017 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj009 = '",l_tmp.bggo017,"' "    
      ##END IF 
      ##客群
      ##IF g_input.hsx_bggo018 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj010 = '",l_tmp.bggo018,"' "   
      ##END IF   
      ##產品類別
      ##IF g_input.hsx_bggo019 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj011 = '",l_tmp.bggo019,"' "   
      ##END IF 
      ##專案編號
      ##IF g_input.hsx_bggo020 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj013 = '",l_tmp.bggo020,"' "    
      ##END IF
      ##WBS
      ##IF g_input.hsx_bggo021 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj014 = '",l_tmp.bggo021,"' "     
      ##END IF  
      ##經營方式
      ##IF g_input.hsx_bggo022 = 'Y'  THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj015 = '",l_tmp.bggo022,"' "    
      ##END IF  
      ##通路
      ##IF g_input.hsx_bggo023 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj016 = '",l_tmp.bggo023,"' "     
      ##END IF
      ##品牌
      ##IF g_input.hsx_bggo024 = 'Y' THEN
      #   LET l_t040_hsx_wc = l_t040_hsx_wc CLIPPED," AND bgbj017 = '",l_tmp.bggo024,"' "     
      ##END IF
      #IF cl_null(l_t040_hsx_wc) THEN LET l_t040_hsx_wc = " 1=1" END IF   #bgbj組核算項
      #
      #LET l_sum_bgbj032 = 0
      #LET l_sum_bgbj033 = 0
      ##SQL FOR 期初金額
      #LET l_begin_amt_sql = " SELECT SUM(bgbj032),SUM(bgbj033) ",
      #                      "   FROM bgbj_t ",
      #                      "  WHERE bgbjent = ",g_enterprise,"  ",
      #                      "    AND bgbj001 = '",g_input.bggo002,"'  ",
      #                      "    AND bgbj002 = '",l_tmp.bggo007,"' ",
      #                      "    AND ",l_t040_hsx_wc," ", #核算項
      #                      "    AND bgbj028 = '",l_tmp.bggo100,"' "
      #PREPARE l_begin_amt_pre1 FROM l_begin_amt_sql   
      #EXECUTE l_begin_amt_pre1 INTO l_sum_bgbj032,l_sum_bgbj033
      #IF cl_null(l_sum_bgbj032)THEN LET l_sum_bgbj032 = 0 END IF
      #IF cl_null(l_sum_bgbj033)THEN LET l_sum_bgbj033 = 0 END IF     
     
      IF g_input.l_curr = '1' THEN  
         #LET l_tmp.l_beg_amt = l_sum_bgbj032 #1220
         #顯示交易原幣
         IF l_tmp.bgie034 = '1' THEN
            #1.借方
            LET l_tmp.l_amt_d = l_tmp.bggo106
            LET l_tmp.l_amt_c = 0
         ELSE
            #2.貸方
            LET l_tmp.l_amt_d = 0
            LET l_tmp.l_amt_c = l_tmp.bggo106         
         END IF
      ELSE
         #LET l_tmp.l_beg_amt = l_sum_bgbj033 #1220
         #顯示預算幣別
         IF l_tmp.bgie034 = '1' THEN
            #1.借方
            LET l_tmp.l_amt_d = l_tmp.bggo103 
            LET l_tmp.l_amt_c = 0
         ELSE
            #2.貸方
            LET l_tmp.l_amt_d = 0
            LET l_tmp.l_amt_c = l_tmp.bggo103           
         END IF
      END IF
      
      INSERT INTO abgq710_tmp VALUES(g_enterprise,l_tmp.*)

   END FOREACH
   
END FUNCTION

################################################################################
# Descriptions...: 第二單身
# Memo...........:
# Usage..........: CALL abgq710_b_fill2(p_idx)
# Date & Author..: 161215 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_b_fill2(p_idx)
DEFINE p_idx                LIKE type_t.num5
DEFINE l_dnstep_str         STRING
DEFINE l_sql                STRING
DEFINE l_sql_1              STRING
DEFINE l_sql_2              STRING
DEFINE l_field              STRING
DEFINE l_bggo039            LIKE bggo_t.bggo039
DEFINE l_bggo040            LIKE bggo_t.bggo040
DEFINE l_amt1,l_amt2,l_amt3 LIKE bggo_t.bggo106
DEFINE l_dnstep_wc          STRING
DEFINE l_i                  LIKE type_t.num5
DEFINE l_stus              STRING
DEFINE l_hsx_wc RECORD
       bggo012   LIKE type_t.chr1,
       bggo013   LIKE type_t.chr1,
       bggo014   LIKE type_t.chr1,
       bggo015   LIKE type_t.chr1,
       bggo016   LIKE type_t.chr1,
       bggo017   LIKE type_t.chr1,
       bggo018   LIKE type_t.chr1,
       bggo019   LIKE type_t.chr1,
       bggo020   LIKE type_t.chr1,
       bggo021   LIKE type_t.chr1,
       bggo022   LIKE type_t.chr1,
       bggo023   LIKE type_t.chr1,
       bggo024   LIKE type_t.chr1       
END RECORD
DEFINE l_bggo011 LIKE bggo_t.bggo011
DEFINE l_bggo007 LIKE bggo_t.bggo007
DEFINE l_bgaw002 LIKE bgaw_t.bgaw002
DEFINE l_bgaw005 LIKE bgaw_t.bgaw005
DEFINE l_bggo007_desc LIKE type_t.chr100
DEFINE l_bggo022_desc LIKE type_t.chr100


   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF
  
   ##前置資料-----------------------------------------------------
   CASE g_input.bggostus
      WHEN 0 
         LET l_stus = " bggostus = 'Y' "
      WHEN 1
         LET l_stus = " bggostus = 'N' "
      WHEN 2 
         LET l_stus = " bggostus = 'FC' "
      WHEN 3
         LET l_stus =  " 1=1"  
   END CASE
   
   #取得組織條件
   IF g_input.l_lowersite = 'Y' THEN
      CALL s_abgt026_get_dnstep_site(g_input.bggo002,'','',g_bggo_d[p_idx].bggo007)
         RETURNING l_dnstep_str
      IF cl_null(l_dnstep_str) THEN LET l_dnstep_str = g_bggo_d[p_idx].bggo007 END IF
      CALL s_fin_get_wc_str(l_dnstep_str) RETURNING l_dnstep_wc        
   ELSE
      LET l_dnstep_str = g_bggo_d[p_idx].bggo007
      CALL s_fin_get_wc_str(l_dnstep_str) RETURNING l_dnstep_wc       
   END IF
          
  #LET l_sql=" SELECT SUM(bggo035),SUM(bggo106),SUM(bggo106*bggo101)  ",
  #          "   FROM bggo_t                                 ",
  #           " WHERE bggoent=",g_enterprise,"               ",
  #           "   AND bggo001='20'                           ",
  #           "   AND bggo002='",g_input.bggo002,"'          ",
  #           "   AND bggo003='",g_input.bggo003,"'          ",              
  #           "   AND bggo009='",g_bggo_d[p_idx].bggo009,"'  ",
  #           "   AND bggo100='",g_bggo_d[p_idx].bggo100,"'  ",
  #           "   AND ",l_stus,                
  #           "   AND bggo008=? AND bggo007=?                ",
  #           "   AND bggo041=? AND bggo042 =? AND bggo043 = ? AND bggo044 = ? ",
  #           "   AND bggo012=? AND bggo013=? AND bggo014=?  ",
  #           "   AND bggo015=? AND bggo016=? AND bggo017=?  ",
  #           "   AND bggo018=? AND bggo019=? AND bggo020=?  ",
  #           "   AND bggo021=? AND bggo022=? AND bggo023=?  ",
  #           "   AND bggo024=? " --AND bggo039=? AND bggo040=?  "  
  #PREPARE abgq710_pc1_p2 FROM l_sql
    
           
   #-----------------------------------------------------------

   CALL g_bggo2_d.clear() 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
   
   LET l_sql  =  " SELECT DISTINCT ''     ,bggo007,''     ,bggo041,''  , ",
                 "         bggo042,''     ,bggo043,''     ,bggo044,''  , ",
                 "         bggo012,''     ,bggo013,''     ,bggo014,''  , ",
                 "         bggo015,''     ,bggo016,''     ,bggo017,''  , ",
                 "         bggo018,''     ,bggo019,''     ,bggo020,''  , ",
                 "         bggo021,''     ,bggo022,bggo023,''     ,bggo024,''  ",
                 "   FROM bggo_t WHERE bggoent = ",g_enterprise,"              ",
                 "    AND bggo007 IN ",l_dnstep_wc,                             
                 "    AND ",l_stus,                                             
                 "    AND bggo001='20'                                         ",
                 "    AND bggo002 = '",g_input.bggo002,"'                      ",
                 "    AND bggo003 = '",g_input.bggo003,"'                      "  
                 
   IF g_input.l_type = '2' THEN   #自設維度 根據樣表給第二單身條件
      IF g_input.hsx_bggo039 = 'Y' THEN
         LET l_sql=l_sql," AND bggo039='",g_bggo_d[p_idx].bggo039,"'"
         LET l_sql=l_sql," AND bggo040='",g_bggo_d[p_idx].bggo040,"'"
      END IF 
      #人員
      IF g_input.hsx_bggo012 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo012='",g_bggo_d[p_idx].bggo012,"'"
      END IF   
      #部門
      IF g_input.hsx_bggo013 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo013='",g_bggo_d[p_idx].bggo013,"'"
      END IF   
      #成本利潤中心
      IF g_input.hsx_bggo014 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo014='",g_bggo_d[p_idx].bggo014,"'"
      END IF
      #區域
      IF g_input.hsx_bggo015 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo015='",g_bggo_d[p_idx].bggo015,"'"
      END IF   
      #收付款客商
      IF g_input.hsx_bggo016 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo016='",g_bggo_d[p_idx].bggo016,"'"
      END IF   
      #帳款客商
      IF g_input.hsx_bggo017 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo017='",g_bggo_d[p_idx].bggo017,"'"
      END IF  
      #客群
      IF g_input.hsx_bggo018 = 'Y' THEN
         LET l_sql=l_sql," AND bggo018='",g_bggo_d[p_idx].bggo018,"'"
      END IF     
      #產品類別
      IF g_input.hsx_bggo019 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo019='",g_bggo_d[p_idx].bggo019,"'"
      END IF  
      #專案編號
      IF g_input.hsx_bggo020 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo020='",g_bggo_d[p_idx].bggo020,"'"
      END IF  
      #WBS
      IF g_input.hsx_bggo021 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo021 ='",g_bggo_d[p_idx].bggo021,"'"
      END IF  
      #經營方式
      IF g_input.hsx_bggo022 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo022 ='",g_bggo_d[p_idx].bggo022,"'"
      END IF  
      #通路
      IF g_input.hsx_bggo023 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo023 ='",g_bggo_d[p_idx].bggo023,"'"
      END IF  
      #品牌
      IF g_input.hsx_bggo024 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo024 ='",g_bggo_d[p_idx].bggo024,"'"
      END IF  
   ELSE
      LET l_hsx_wc.bggo012 ='Y'
      LET l_hsx_wc.bggo013 ='Y'
      LET l_hsx_wc.bggo014 ='Y'
      LET l_hsx_wc.bggo015 ='Y'
      LET l_hsx_wc.bggo016 ='Y'
      LET l_hsx_wc.bggo017 ='Y'
      LET l_hsx_wc.bggo018 ='Y'
      LET l_hsx_wc.bggo019 ='Y'
      LET l_hsx_wc.bggo020 ='Y'
      LET l_hsx_wc.bggo021 ='Y'
      LET l_hsx_wc.bggo022 ='Y'
      LET l_hsx_wc.bggo023 ='Y'
      LET l_hsx_wc.bggo024 ='Y'   
      LET l_sql_1 = " SELECT bgaw002,bgaw005                 ",
                    "  FROM bgaw_t                           ",
                    " WHERE bgawent = '",g_enterprise,"'     ",
                    "   AND bgaw001 =  ?                     ",
                    "   ORDER BY bgaw002                     "
      PREPARE abgq710_bgaw005_p2 FROM l_sql_1
      DECLARE abgq710_bgaw005_c2 CURSOR FOR abgq710_bgaw005_p2
   
      LET l_sql_1 = " SELECT DISTINCT bggo011 FROM bggo_t    ",
                    "  WHERE bggoent = ",g_enterprise,"      ",
                    "    AND bggo002 = '",g_input.bggo002,"' ",
                    "    AND bggo003 = '",g_input.bggo003,"' ",
                    "    AND bggo007 IN ",l_dnstep_wc 
      PREPARE abgq710_bggo011_p2 FROM l_sql_1
      DECLARE abgq710_bggo011_c2 CURSOR FOR abgq710_bggo011_p
      FOREACH abgq710_bggo011_c2 INTO l_bggo011
         FOREACH abgq710_bgaw005_c2 USING l_bggo011 INTO l_bgaw002,l_bgaw005 
            CASE l_bgaw002 
               WHEN 1  #預算組織
               WHEN 2  #預算細項
               WHEN 3  #部門
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo013 ='N' END IF        
               WHEN 4  #利潤成本中心
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo014 ='N' END IF        
               WHEN 5  #區域
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo015 ='N' END IF       
               WHEN 6  #收付款客商
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo016 ='N' END IF       
               WHEN 7 #帳款客戶
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo017 ='N' END IF       
               WHEN 8 #客群
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo018 ='N' END IF       
               WHEN 9 #產品類別
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo019 ='N' END IF       
               WHEN 10 #經營方式
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo022 ='N' END IF          
               WHEN 11 #通路
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo023 ='N' END IF          
               WHEN 12 #品牌
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo024 ='N' END IF 
               WHEN 13 #人員
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo012 ='N' END IF      
               WHEN 14 #專案編號
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo020 ='N' END IF      
               WHEN 15 #WBS
                  IF l_bgaw005 = 'N' THEN LET l_hsx_wc.bggo021 ='N' END IF                   
            END CASE                       
         END FOREACH                              
      END FOREACH
      #人員
      IF l_hsx_wc.bggo012 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo012='",g_bggo_d[p_idx].bggo012,"'"   
      END IF   
      #部門
      IF l_hsx_wc.bggo013 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo013='",g_bggo_d[p_idx].bggo013,"'"
      END IF   
      #成本利潤中心
      IF l_hsx_wc.bggo014 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo014='",g_bggo_d[p_idx].bggo014,"'"
      END IF
      #區域
      IF l_hsx_wc.bggo015 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo015='",g_bggo_d[p_idx].bggo015,"'"
      END IF   
      #收付款客商
      IF l_hsx_wc.bggo016 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo016='",g_bggo_d[p_idx].bggo016,"'"
      END IF   
      #帳款客商
      IF l_hsx_wc.bggo017 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo017='",g_bggo_d[p_idx].bggo017,"'"
      END IF  
      #客群
      IF l_hsx_wc.bggo018 = 'Y' THEN
         LET l_sql=l_sql," AND bggo018='",g_bggo_d[p_idx].bggo018,"'"
      END IF     
      #產品類別
      IF l_hsx_wc.bggo019 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo019='",g_bggo_d[p_idx].bggo019,"'"
      END IF  
      #專案編號
      IF l_hsx_wc.bggo020 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo020='",g_bggo_d[p_idx].bggo020,"'"
      END IF  
      #WBS
      IF l_hsx_wc.bggo021 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo021='",g_bggo_d[p_idx].bggo021,"'"
      END IF  
      #經營方式
      IF l_hsx_wc.bggo022 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo022='",g_bggo_d[p_idx].bggo022,"'"
      END IF  
      #通路
      IF l_hsx_wc.bggo023 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo023='",g_bggo_d[p_idx].bggo023,"'"
      END IF  
      #品牌
      IF l_hsx_wc.bggo024 = 'Y' THEN 
         LET l_sql=l_sql," AND bggo024='",g_bggo_d[p_idx].bggo023,"'"
      END IF  
      LET l_sql=l_sql," AND bggo011='",g_bggo_d[p_idx].bggo011,"' ",
                      " AND bggo039='",g_bggo_d[p_idx].bggo039,"' ",
                      " AND bggo040='",g_bggo_d[p_idx].bggo040,"' "
   END IF
   
  
   LET l_sql  = l_sql," ORDER BY bggo007,bggo012,bggo013,bggo014,bggo015,bggo016, ",              
                      "          bggo017,bggo018,bggo019,bggo020,bggo021,bggo022, ",    
                      "          bggo023,bggo024                                  " 
   PREPARE abgq710_pc1_p FROM l_sql   
   DECLARE abgq710_pc1_c CURSOR FOR abgq710_pc1_p 
   FOREACH abgq710_pc1_c INTO  g_bggo2_d[l_ac].bggoseq,g_bggo2_d[l_ac].bggo007,g_bggo2_d[l_ac].bggo007_2_desc,
                               g_bggo2_d[l_ac].bggo041,g_bggo2_d[l_ac].bggo041_desc,g_bggo2_d[l_ac].bggo042,g_bggo2_d[l_ac].bggo042_desc,
                               g_bggo2_d[l_ac].bggo043,g_bggo2_d[l_ac].bggo043_desc,g_bggo2_d[l_ac].bggo044,g_bggo2_d[l_ac].bggo044_desc, 
                               g_bggo2_d[l_ac].bggo012,g_bggo2_d[l_ac].bggo012_desc,
                               g_bggo2_d[l_ac].bggo013,g_bggo2_d[l_ac].bggo013_desc,g_bggo2_d[l_ac].bggo014,g_bggo2_d[l_ac].bggo014_desc,
                               g_bggo2_d[l_ac].bggo015,g_bggo2_d[l_ac].bggo015_desc,g_bggo2_d[l_ac].bggo016,g_bggo2_d[l_ac].bggo016_desc,
                               g_bggo2_d[l_ac].bggo017,g_bggo2_d[l_ac].bggo017_desc,g_bggo2_d[l_ac].bggo018,g_bggo2_d[l_ac].bggo018_desc,
                               g_bggo2_d[l_ac].bggo019,g_bggo2_d[l_ac].bggo019_desc,g_bggo2_d[l_ac].bggo020,g_bggo2_d[l_ac].bggo020_desc,
                               g_bggo2_d[l_ac].bggo021,g_bggo2_d[l_ac].bggo021_desc,g_bggo2_d[l_ac].bggo022,
                               g_bggo2_d[l_ac].bggo023,g_bggo2_d[l_ac].bggo023_desc,g_bggo2_d[l_ac].bggo024,g_bggo2_d[l_ac].bggo024_desc
      LET g_bggo2_d[l_ac].bggoseq = l_ac
      
      IF g_input.hsx_bggo039 = 'Y' THEN #有組預算細項
         LET l_sql=" SELECT SUM(bggo035),SUM(bggo106),SUM(bggo106*bggo101)  ",
                 "   FROM bggo_t                                 ",
                 " WHERE bggoent=",g_enterprise,"               ",
                 "   AND bggo001='20'                           ",
                 "   AND bggo002='",g_input.bggo002,"'          ",
                 "   AND bggo003='",g_input.bggo003,"'          ",  
                 "   AND bggo009='",g_bggo_d[p_idx].bggo009,"'  ",
                 "   AND bggo100='",g_bggo_d[p_idx].bggo100,"'  ",
                 "   AND ",l_stus,                
                 "   AND bggo008=? AND bggo007=?                ",
                 "   AND bggo041=? AND bggo042 =? AND bggo043 = ? AND bggo044 = ? ",
                 "   AND bggo012=? AND bggo013=? AND bggo014=?  ",
                 "   AND bggo015=? AND bggo016=? AND bggo017=?  ",
                 "   AND bggo018=? AND bggo019=? AND bggo020=?  ",
                 "   AND bggo021=? AND bggo022=? AND bggo023=?  ",
                 "   AND bggo024=? AND bggo039=? AND bggo040=?  "  
         PREPARE abgq710_pc1_p2 FROM l_sql                        
         FOR l_i = 1 TO g_max_period EXECUTE abgq710_pc1_p2 
            USING  l_i,g_bggo2_d[l_ac].bggo007,
                      g_bggo2_d[l_ac].bggo041,g_bggo2_d[l_ac].bggo042,g_bggo2_d[l_ac].bggo043,g_bggo2_d[l_ac].bggo044,
                      g_bggo2_d[l_ac].bggo012,g_bggo2_d[l_ac].bggo013,
                      g_bggo2_d[l_ac].bggo014,g_bggo2_d[l_ac].bggo015,g_bggo2_d[l_ac].bggo016,
                      g_bggo2_d[l_ac].bggo017,g_bggo2_d[l_ac].bggo018,g_bggo2_d[l_ac].bggo019,
                      g_bggo2_d[l_ac].bggo020,g_bggo2_d[l_ac].bggo021,g_bggo2_d[l_ac].bggo022,
                      g_bggo2_d[l_ac].bggo023,g_bggo2_d[l_ac].bggo024,g_bggo_d[p_idx].bggo039,g_bggo_d[p_idx].bggo040                  
            INTO l_amt1,l_amt2,l_amt3
            IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF                  
            CASE l_i                    
               WHEN 1
                  LET g_bggo2_d[l_ac].l_use1    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept1 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt1    = l_amt3                                               
               WHEN 2
                  LET g_bggo2_d[l_ac].l_use2    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept2 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt2    = l_amt3                                            
              WHEN 3
                  LET g_bggo2_d[l_ac].l_use3    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept3 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt3    = l_amt3  
               WHEN 4
                  LET g_bggo2_d[l_ac].l_use4    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept4 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt4    = l_amt3  
               WHEN 5
                  LET g_bggo2_d[l_ac].l_use5    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept5 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt5    = l_amt3  
               WHEN 6
                  LET g_bggo2_d[l_ac].l_use6    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept6 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt6    = l_amt3  
               WHEN 7
                  LET g_bggo2_d[l_ac].l_use7    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept7 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt7    = l_amt3 
               WHEN 8
                  LET g_bggo2_d[l_ac].l_use8    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept8 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt8    = l_amt3 
              WHEN 9
                  LET g_bggo2_d[l_ac].l_use9    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept9 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt9    = l_amt3 
               WHEN 10
                  LET g_bggo2_d[l_ac].l_use10    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept10 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt10    = l_amt3 
               WHEN 11
                  LET g_bggo2_d[l_ac].l_use11    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept11 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt11    = l_amt3                                                                
               WHEN 12
                  LET g_bggo2_d[l_ac].l_use12    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept12 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt12    = l_amt3  
               WHEN 13
                  LET g_bggo2_d[l_ac].l_use13    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept13 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt13    = l_amt3  
            END CASE                  
         END FOR
      ELSE
         LET l_sql=" SELECT SUM(bggo035),SUM(bggo106),SUM(bggo106*bggo101)  ",
                   "   FROM bggo_t                                 ",
                   " WHERE bggoent=",g_enterprise,"               ",
                   "   AND bggo001='20'                           ",
                   "   AND bggo002='",g_input.bggo002,"'          ",
                   "   AND bggo003='",g_input.bggo003,"'          ",              
                   "   AND bggo009='",g_bggo_d[p_idx].bggo009,"'  ",
                   "   AND bggo100='",g_bggo_d[p_idx].bggo100,"'  ",
                   "   AND ",l_stus,                
                   "   AND bggo008=? AND bggo007=?                ",
                   "   AND bggo041=? AND bggo042 =? AND bggo043 = ? AND bggo044 = ? ",
                   "   AND bggo012=? AND bggo013=? AND bggo014=?  ",
                   "   AND bggo015=? AND bggo016=? AND bggo017=?  ",
                   "   AND bggo018=? AND bggo019=? AND bggo020=?  ",
                   "   AND bggo021=? AND bggo022=? AND bggo023=?  ",
                   "   AND bggo024=?  "  
         PREPARE abgq710_pc1_p3 FROM l_sql                        
         FOR l_i = 1 TO g_max_period EXECUTE abgq710_pc1_p3
            USING  l_i,g_bggo2_d[l_ac].bggo007,
                      g_bggo2_d[l_ac].bggo041,g_bggo2_d[l_ac].bggo042,g_bggo2_d[l_ac].bggo043,g_bggo2_d[l_ac].bggo044,
                      g_bggo2_d[l_ac].bggo012,g_bggo2_d[l_ac].bggo013,
                      g_bggo2_d[l_ac].bggo014,g_bggo2_d[l_ac].bggo015,g_bggo2_d[l_ac].bggo016,
                      g_bggo2_d[l_ac].bggo017,g_bggo2_d[l_ac].bggo018,g_bggo2_d[l_ac].bggo019,
                      g_bggo2_d[l_ac].bggo020,g_bggo2_d[l_ac].bggo021,g_bggo2_d[l_ac].bggo022,
                      g_bggo2_d[l_ac].bggo023,g_bggo2_d[l_ac].bggo024               
            INTO l_amt1,l_amt2,l_amt3
            IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
            IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
            IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF                  
            CASE l_i                    
               WHEN 1
                  LET g_bggo2_d[l_ac].l_use1    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept1 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt1    = l_amt3                                               
               WHEN 2
                  LET g_bggo2_d[l_ac].l_use2    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept2 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt2    = l_amt3                                            
              WHEN 3
                  LET g_bggo2_d[l_ac].l_use3    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept3 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt3    = l_amt3  
               WHEN 4
                  LET g_bggo2_d[l_ac].l_use4    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept4 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt4    = l_amt3  
               WHEN 5
                  LET g_bggo2_d[l_ac].l_use5    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept5 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt5    = l_amt3  
               WHEN 6
                  LET g_bggo2_d[l_ac].l_use6    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept6 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt6    = l_amt3  
               WHEN 7
                  LET g_bggo2_d[l_ac].l_use7    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept7 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt7    = l_amt3 
               WHEN 8
                  LET g_bggo2_d[l_ac].l_use8    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept8 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt8    = l_amt3 
              WHEN 9
                  LET g_bggo2_d[l_ac].l_use9    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept9 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt9    = l_amt3 
               WHEN 10
                  LET g_bggo2_d[l_ac].l_use10    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept10 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt10    = l_amt3 
               WHEN 11
                  LET g_bggo2_d[l_ac].l_use11    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept11 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt11    = l_amt3                                                                
               WHEN 12
                  LET g_bggo2_d[l_ac].l_use12    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept12 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt12    = l_amt3  
               WHEN 13
                  LET g_bggo2_d[l_ac].l_use13    = l_amt1
                  LET g_bggo2_d[l_ac].l_accept13 = l_amt2
                  LET g_bggo2_d[l_ac].l_amt13    = l_amt3  
            END CASE                  
         END FOR
      END IF    
     
     
      #工資方案
      CALL s_desc_get_bggbl004_desc(g_bggo2_d[l_ac].bggo041) RETURNING g_bggo2_d[l_ac].bggo041_desc
      LET g_bggo2_d[l_ac].bggo041_desc = s_desc_show1(g_bggo2_d[l_ac].bggo041,g_bggo2_d[l_ac].bggo041_desc)
      #職級
      CALL s_desc_get_bggal004_desc('abgi710',g_bggo2_d[l_ac].bggo042) RETURNING g_bggo2_d[l_ac].bggo042_desc
      LET g_bggo2_d[l_ac].bggo042_desc = s_desc_show1(g_bggo2_d[l_ac].bggo042,g_bggo2_d[l_ac].bggo042_desc)
      #職等
      CALL s_desc_get_bggal004_desc('abgi720',g_bggo2_d[l_ac].bggo043) RETURNING g_bggo2_d[l_ac].bggo043_desc 
      LET g_bggo2_d[l_ac].bggo043_desc = s_desc_show1(g_bggo2_d[l_ac].bggo043,g_bggo2_d[l_ac].bggo043_desc)            
      #用工屬性
      CALL s_desc_get_bggal004_desc('abgi730',g_bggo2_d[l_ac].bggo044) RETURNING g_bggo2_d[l_ac].bggo044_desc
      LET g_bggo2_d[l_ac].bggo044_desc = s_desc_show1(g_bggo2_d[l_ac].bggo044,g_bggo2_d[l_ac].bggo044_desc)                  
      ## 組織 
      LET g_bggo2_d[l_ac].bggo007_2_desc = s_desc_get_department_desc(g_bggo2_d[l_ac].bggo007)      
      #人員
      CALL s_desc_get_person_desc(g_bggo2_d[l_ac].bggo012) RETURNING g_bggo2_d[l_ac].bggo012_desc
      LET g_bggo2_d[l_ac].bggo012_desc = s_desc_show1(g_bggo2_d[l_ac].bggo012,g_bggo2_d[l_ac].bggo012_desc)
      #部門
      CALL s_desc_get_department_desc(g_bggo2_d[l_ac].bggo013) RETURNING g_bggo2_d[l_ac].bggo013_desc
      LET g_bggo2_d[l_ac].bggo013_desc = s_desc_show1(g_bggo2_d[l_ac].bggo013,g_bggo2_d[l_ac].bggo013_desc)
      #成本利潤中心
      CALL s_desc_get_department_desc(g_bggo2_d[l_ac].bggo014) RETURNING g_bggo2_d[l_ac].bggo014_desc
      LET g_bggo2_d[l_ac].bggo014_desc = s_desc_show1(g_bggo2_d[l_ac].bggo014,g_bggo2_d[l_ac].bggo014_desc)
      #區域
      CALL s_desc_get_acc_desc('287',g_bggo2_d[l_ac].bggo015) RETURNING g_bggo2_d[l_ac].bggo015_desc
      LET g_bggo2_d[l_ac].bggo015_desc = s_desc_show1(g_bggo2_d[l_ac].bggo015,g_bggo2_d[l_ac].bggo015_desc)
      #收付款客商
      CALL s_desc_get_bgap001_desc(g_bggo2_d[l_ac].bggo016) RETURNING g_bggo2_d[l_ac].bggo016_desc
      LET g_bggo2_d[l_ac].bggo016_desc = s_desc_show1(g_bggo2_d[l_ac].bggo016,g_bggo2_d[l_ac].bggo016_desc)
      #收款客商
      CALL s_desc_get_bgap001_desc(g_bggo2_d[l_ac].bggo017) RETURNING g_bggo2_d[l_ac].bggo017_desc
      LET g_bggo2_d[l_ac].bggo017_desc = s_desc_show1(g_bggo2_d[l_ac].bggo017,g_bggo2_d[l_ac].bggo017_desc)
      #客群
      CALL s_desc_get_acc_desc('281',g_bggo2_d[l_ac].bggo018) RETURNING g_bggo2_d[l_ac].bggo018_desc
      LET g_bggo2_d[l_ac].bggo018_desc = s_desc_show1(g_bggo2_d[l_ac].bggo018,g_bggo2_d[l_ac].bggo018_desc)
      #產品類別
      CALL s_desc_get_rtaxl003_desc(g_bggo2_d[l_ac].bggo019) RETURNING g_bggo2_d[l_ac].bggo019_desc
      LET g_bggo2_d[l_ac].bggo019_desc = s_desc_show1(g_bggo2_d[l_ac].bggo019,g_bggo2_d[l_ac].bggo019_desc)
      #專案編號
      CALL s_desc_get_project_desc(g_bggo2_d[l_ac].bggo020) RETURNING g_bggo2_d[l_ac].bggo020_desc
      LET g_bggo2_d[l_ac].bggo020_desc = s_desc_show1(g_bggo2_d[l_ac].bggo020,g_bggo2_d[l_ac].bggo020_desc)
      #WBS
      CALL s_desc_get_wbs_desc(g_bggo2_d[l_ac].bggo020,g_bggo2_d[l_ac].bggo021) RETURNING g_bggo2_d[l_ac].bggo021_desc
      LET g_bggo2_d[l_ac].bggo021_desc = s_desc_show1(g_bggo2_d[l_ac].bggo021,g_bggo2_d[l_ac].bggo021_desc)
      #經營方式
      LET g_bggo2_d[l_ac].bggo022 = g_bggo2_d[l_ac].bggo022
      #通路
      CALL s_desc_get_oojdl003_desc(g_bggo2_d[l_ac].bggo023) RETURNING g_bggo2_d[l_ac].bggo023_desc
      LET g_bggo2_d[l_ac].bggo023_desc = s_desc_show1(g_bggo2_d[l_ac].bggo023,g_bggo2_d[l_ac].bggo023_desc)
      #品牌
      CALL s_desc_get_acc_desc('2002',g_bggo2_d[l_ac].bggo024) RETURNING g_bggo2_d[l_ac].bggo024_desc
      LET g_bggo2_d[l_ac].bggo024_desc = s_desc_show1(g_bggo2_d[l_ac].bggo024,g_bggo2_d[l_ac].bggo024_desc)
      ####-------------e              
      ###ins abgq710_x01_tmp1
      IF g_subrep_ins = 'Y' THEN
         IF NOT cl_null(g_bggo2_d[l_ac].bggo007_2_desc) THEN
            LET l_bggo007_desc = g_bggo2_d[l_ac].bggo007,':',g_bggo2_d[l_ac].bggo007_2_desc
         ELSE
            LET l_bggo007_desc = g_bggo2_d[l_ac].bggo007
         END IF         
         
         IF NOT cl_null(g_bggo2_d[l_i].bggo022) THEN
            LET l_bggo022_desc = g_bggo2_d[l_i].bggo022,':',s_desc_gzcbl004_desc(g_bggo2_d[l_i].bggo022,'6013')
         END IF
         
         
         
         INSERT INTO abgq710_x01_tmp1
         VALUES( g_bggo2_d[l_ac].bggoseq,l_bggo007_desc,
                 g_bggo2_d[l_ac].bggo041_desc,g_bggo2_d[l_ac].bggo042_desc,g_bggo2_d[l_ac].bggo043_desc,g_bggo2_d[l_ac].bggo044_desc,
                 g_bggo2_d[l_ac].bggo012_desc,g_bggo2_d[l_ac].bggo013_desc,g_bggo2_d[l_ac].bggo014_desc,g_bggo2_d[l_ac].bggo015_desc,
                 g_bggo2_d[l_ac].bggo016_desc,g_bggo2_d[l_ac].bggo017_desc,g_bggo2_d[l_ac].bggo018_desc,g_bggo2_d[l_ac].bggo019_desc,
                 g_bggo2_d[l_ac].bggo020_desc,g_bggo2_d[l_ac].bggo021_desc,l_bggo022_desc              ,g_bggo2_d[l_ac].bggo023_desc,
                 g_bggo2_d[l_ac].bggo024_desc,
                 g_bggo2_d[l_ac].l_use1 ,g_bggo2_d[l_ac].l_accept1, g_bggo2_d[l_ac].l_amt1,
                 g_bggo2_d[l_ac].l_use2 ,g_bggo2_d[l_ac].l_accept2, g_bggo2_d[l_ac].l_amt2,
                 g_bggo2_d[l_ac].l_use3 ,g_bggo2_d[l_ac].l_accept3, g_bggo2_d[l_ac].l_amt3,
                 g_bggo2_d[l_ac].l_use4 ,g_bggo2_d[l_ac].l_accept4, g_bggo2_d[l_ac].l_amt4,
                 g_bggo2_d[l_ac].l_use5 ,g_bggo2_d[l_ac].l_accept5, g_bggo2_d[l_ac].l_amt5,
                 g_bggo2_d[l_ac].l_use6 ,g_bggo2_d[l_ac].l_accept6, g_bggo2_d[l_ac].l_amt6,
                 g_bggo2_d[l_ac].l_use7 ,g_bggo2_d[l_ac].l_accept7, g_bggo2_d[l_ac].l_amt7,
                 g_bggo2_d[l_ac].l_use8 ,g_bggo2_d[l_ac].l_accept8, g_bggo2_d[l_ac].l_amt8,
                 g_bggo2_d[l_ac].l_use9 ,g_bggo2_d[l_ac].l_accept9, g_bggo2_d[l_ac].l_amt9,
                 g_bggo2_d[l_ac].l_use10,g_bggo2_d[l_ac].l_accept10, g_bggo2_d[l_ac].l_amt10,
                 g_bggo2_d[l_ac].l_use11,g_bggo2_d[l_ac].l_accept11, g_bggo2_d[l_ac].l_amt11,
                 g_bggo2_d[l_ac].l_use12,g_bggo2_d[l_ac].l_accept12, g_bggo2_d[l_ac].l_amt12,
                 g_bggo2_d[l_ac].l_use13,g_bggo2_d[l_ac].l_accept13, g_bggo2_d[l_ac].l_amt13,p_idx  )               
      END IF                                    
      LET l_ac = l_ac + 1 
     
   END FOREACH   
   
   LET g_error_show = 0      
   CALL g_bggo2_d.deleteElement(g_bggo2_d.getLength())
   
   LET g_detail_cnt = g_bggo2_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
END FUNCTION

################################################################################
# Descriptions...: Tree選取點
# Memo...........:
# Usage..........: CALL abgq710_tree_fetch(p_idx)
# Date & Author..: 161219 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_tree_fetch(p_idx)
   DEFINE p_idx     LIKE type_t.num5
   DEFINE l_idx     LIKE type_t.num5
   

   IF cl_null(p_idx) OR p_idx <= 0 THEN RETURN END IF
   
   LET g_bggo007 = ''
   LET g_bggo037 = ''
   LET g_flag = FALSE
   
   #根節點
   IF cl_null(g_tree[p_idx].bggo007) AND NOT cl_null(g_tree[p_idx].bggo037) THEN
      LET g_bggo037 = g_tree[p_idx].bggo037 #存取根節點
      LET g_flag = TRUE
      FOR l_idx = 1 TO g_tree.getLength()
         #將旗下子節點接上
         IF g_bggo037 = g_tree[l_idx].bggo037 THEN
            IF cl_null(g_bggo007) THEN
               LET g_bggo007 = g_bggo037
            ELSE
               LET g_bggo007 = g_bggo007,"','",g_tree[l_idx].bggo007
            END IF
         END IF
      END FOR
   ELSE
   #本身為子節點
      LET g_bggo007 = g_tree[p_idx].bggo007
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: 取得第一單身核算項條件
# Memo...........:
# Usage..........: CALL abgq710_get_hsx_wc(p_idx)
# Date & Author..: 161219 By 06821
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_get_hsx_wc(p_idx)
DEFINE p_idx         LIKE type_t.num5
DEFINE r_hsx_wc2     STRING 
DEFINE r_t040_hsx_wc STRING 

   LET r_hsx_wc2 = " 1=1"
   LET r_t040_hsx_wc = " 1=1"

   #預算細項
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo039 = '",g_bggo_d[p_idx].bggo039,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj003 = '",g_bggo_d[p_idx].bggo039,"' "  
   #人員
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo012 = '",g_bggo_d[p_idx].bggo012,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj012 = '",g_bggo_d[p_idx].bggo012,"' "
   #部門
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo013 = '",g_bggo_d[p_idx].bggo013,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj005 = '",g_bggo_d[p_idx].bggo013,"' "     
   #成本利潤中心
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo014 = '",g_bggo_d[p_idx].bggo014,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj006 = '",g_bggo_d[p_idx].bggo014,"' "     
   #區域
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo015 = '",g_bggo_d[p_idx].bggo015,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj007 = '",g_bggo_d[p_idx].bggo015,"' "      
   #收付款客商
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo016 = '",g_bggo_d[p_idx].bggo016,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj008 = '",g_bggo_d[p_idx].bggo016,"' "      
   #帳款客商
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo017 = '",g_bggo_d[p_idx].bggo017,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj009 = '",g_bggo_d[p_idx].bggo017,"' "     
   #客群
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo018 = '",g_bggo_d[p_idx].bggo018,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj010 = '",g_bggo_d[p_idx].bggo018,"' "     
   #產品類別
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo019 = '",g_bggo_d[p_idx].bggo019,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj011 = '",g_bggo_d[p_idx].bggo019,"' "      
   #專案編號
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo020 = '",g_bggo_d[p_idx].bggo020,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj013 = '",g_bggo_d[p_idx].bggo020,"' "      
   #WBS
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo021 = '",g_bggo_d[p_idx].bggo021,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj014 = '",g_bggo_d[p_idx].bggo021,"' "      
   #經營方式
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo022 = '",g_bggo_d[p_idx].bggo022,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj015 = '",g_bggo_d[p_idx].bggo022,"' "      
   #通路
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo023 = '",g_bggo_d[p_idx].bggo023,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj016 = '",g_bggo_d[p_idx].bggo023,"' "     
   #品牌
   LET r_hsx_wc2 = r_hsx_wc2 CLIPPED," AND bggo024 = '",g_bggo_d[p_idx].bggo024,"' "
   LET r_t040_hsx_wc = r_t040_hsx_wc CLIPPED," AND bgbj017 = '",g_bggo_d[p_idx].bggo024,"' "     

   RETURN r_hsx_wc2,r_t040_hsx_wc
END FUNCTION

################################################################################
# Descriptions...: xg列印
# Memo...........:
# Usage..........: CALL abgq710_print()
# Date & Author..: 2016/12/29 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq710_print()
DEFINE l_bggo001_desc    LIKE type_t.chr100
DEFINE l_bggo002_desc    LIKE type_t.chr100
DEFINE l_bggo007_desc    LIKE type_t.chr100
DEFINE l_bggo0072_desc    LIKE type_t.chr100
DEFINE l_bggo009_desc    LIKE type_t.chr100
DEFINE l_bggo022_desc    LIKE type_t.chr100
DEFINE l_type_desc       LIKE type_t.chr100
DEFINE l_stus_desc       LIKE type_t.chr100
DEFINE l_i               LIKE type_t.num5

   LET g_subrep_ins = 'Y'
   LET l_bggo002_desc = g_input.bggo002,':',g_input.bggo002_desc
   LET l_bggo007_desc = g_input.bggo007,':',g_input.bggo007_desc

   LET l_bggo001_desc = ''
   CASE g_input.bggo001
      WHEN '20'   #20.人工預算
         SELECT gzzd005 INTO l_bggo001_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggo001.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
      WHEN '30'   #30.人工審核
         SELECT gzzd005 INTO l_bggo001_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggo001.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
   END CASE  
   
   LET l_type_desc = ''
   CASE g_input.l_type #維度選項
      WHEN '1'   #一照樣表
         SELECT gzzd005 INTO l_type_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_type.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
      WHEN '2'   #自設維度
         SELECT gzzd005 INTO l_type_desc FROM gzzd_t WHERE gzzd003 = 'cbo_l_type.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
   END CASE  
   
   LET l_stus_desc = ''
   CASE g_input.bggostus
      WHEN '0'  
         SELECT gzzd005 INTO l_stus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggostus.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
      WHEN '1'   
         SELECT gzzd005 INTO l_stus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggostus.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
      WHEN '2'
         SELECT gzzd005 INTO l_stus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggostus.3' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'
      WHEN '3'
         SELECT gzzd005 INTO l_stus_desc FROM gzzd_t WHERE gzzd003 = 'cbo_b_bggostus.4' AND gzzd002 = g_dlang AND gzzd001 = 'abgq710'  
   END CASE  


   #第一單身資料--------------------
   DELETE FROM abgq710_x01_tmp
   LET l_i = 1
   FOR l_i = 1 TO g_bggo_d.getLength() 
      IF NOT cl_null(g_bggo_d[l_i].bggo007_1_desc) THEN
         LET l_bggo0072_desc = g_bggo_d[l_i].bggo007,':',g_bggo_d[l_i].bggo007_1_desc
      ELSE
         LET l_bggo0072_desc = g_bggo_d[l_i].bggo007
      END IF
      #IF NOT cl_null(g_bggo_d[l_i].bggo009_desc) THEN
      #   LET l_bggo009_desc = g_bggo_d[l_i].bggo009,':',g_bggo_d[l_i].bggo009_desc
      #ELSE
      #   LET l_bggo009_desc = g_bggo_d[l_i].bggo009 
      #END IF
      LET l_bggo009_desc = g_bggo_d[l_i].bggo009_desc
      IF NOT cl_null(g_bggo_d[l_i].bggo022) THEN
         LET l_bggo022_desc = g_bggo_d[l_i].bggo022,':',s_desc_gzcbl004_desc(g_bggo_d[l_i].bggo022,'6013')
      END IF
      
      
      INSERT INTO abgq710_x01_tmp
            VALUES(l_bggo002_desc,g_input.bggo003,l_bggo007_desc,g_input.l_lowersite,
                   g_input.l_bgaa003,l_bggo001_desc,l_type_desc,l_stus_desc,g_input.l_curr,
                   g_bggo_d[l_i].bggoseq,l_bggo0072_desc,l_bggo009_desc,       
                   g_bggo_d[l_i].bggo012_desc,g_bggo_d[l_i].bggo013_desc,g_bggo_d[l_i].bggo014_desc,
                   g_bggo_d[l_i].bggo015_desc,g_bggo_d[l_i].bggo016_desc,g_bggo_d[l_i].bggo017_desc,
                   g_bggo_d[l_i].bggo018_desc,g_bggo_d[l_i].bggo019_desc,g_bggo_d[l_i].bggo020_desc,
                   g_bggo_d[l_i].bggo021_desc,l_bggo022_desc            ,g_bggo_d[l_i].bggo023_desc,
                   g_bggo_d[l_i].bggo024_desc,
                   g_bggo_d[l_i].bggo100,     g_bggo_d[l_i].bggo106     ,g_bggo_d[l_i].l_amt,
                   g_bggo_d[l_ac].bggo039_desc,g_bggo_d[l_ac].bggo040_desc )                                      
      CALL abgq710_b_fill2(g_bggo_d[l_i].bggoseq)
   END FOR
   LET g_subrep_ins = 'N'


END FUNCTION

 
{</section>}
 
