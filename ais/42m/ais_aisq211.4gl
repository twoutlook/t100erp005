#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq211.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-30 15:37:36), PR版次:0001(2016-09-14 14:46:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: aisq211
#+ Description: 門市發票狀態查詢作業
#+ Creator....: 08732(2016-08-30 15:37:36)
#+ Modifier...: 08732 -SD/PR- 08732
 
{</section>}
 
{<section id="aisq211.global" >}
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
PRIVATE TYPE type_g_isae_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isaecomp LIKE isae_t.isaecomp, 
   isaecomp_desc LIKE type_t.chr500, 
   isaesite LIKE isae_t.isaesite, 
   isaesite_desc LIKE type_t.chr500, 
   isae022 LIKE isae_t.isae022, 
   isae002 LIKE isae_t.isae002, 
   isae003 LIKE isae_t.isae003, 
   isae016 LIKE isae_t.isae016, 
   isae017 LIKE isae_t.isae017, 
   isae018 LIKE isae_t.isae018, 
   isae018_desc LIKE type_t.chr500, 
   isae004 LIKE isae_t.isae004, 
   isae004_desc LIKE type_t.chr500, 
   isae001 LIKE isae_t.isae001, 
   isae006 LIKE isae_t.isae006, 
   isae008 LIKE isae_t.isae008, 
   isae007 LIKE isae_t.isae007, 
   isae009 LIKE isae_t.isae009, 
   isae010 LIKE isae_t.isae010, 
   isae005 LIKE isae_t.isae005, 
   isae011 LIKE isae_t.isae011, 
   isae012 LIKE isae_t.isae012, 
   isae013 LIKE isae_t.isae013, 
   isae014 LIKE isae_t.isae014, 
   isae021 LIKE isae_t.isae021, 
   isae023 LIKE isae_t.isae023, 
   isae015 LIKE isae_t.isae015, 
   isaestus LIKE isae_t.isaestus 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
PRIVATE TYPE type_g_isae_m RECORD
       l_isaecomp        LIKE  isae_t.isaecomp, 
       l_isaecomp_desc   LIKE  type_t.chr500, 
       l_isaesite        LIKE  isae_t.isaesite, 
       l_isaesite_desc   LIKE  type_t.chr500, 
       l_isac001         LIKE  isae_t.isae001, 
       l_isac001_desc    LIKE  type_t.chr500, 
       l_isae022         LIKE  isae_t.isae022,
       l_isae022_desc    LIKE  type_t.chr500, 
       l_isae016         LIKE  isae_t.isae016
       END RECORD

DEFINE g_isae_m          type_g_isae_m
DEFINE g_isae_m_o        type_g_isae_m 
DEFINE g_isae_wc         STRING
DEFINE g_xg_visible      STRING     #XG欄位隱藏條件
DEFINE g_wc_cs_comp      STRING
DEFINE g_wc_apgborga     STRING
   #DEFINE l_isae_wc   STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isae_d
DEFINE g_master_t                   type_g_isae_d
DEFINE g_isae_d          DYNAMIC ARRAY OF type_g_isae_d
DEFINE g_isae_d_t        type_g_isae_d
 
      
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
 
{<section id="aisq211.main" >}
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
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_fin_create_account_center_tmp()
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
   DECLARE aisq211_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq211_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq211_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq211 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq211_init()   
 
      #進入選單 Menu (="N")
      CALL aisq211_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq211
      
   END IF 
   
   CLOSE aisq211_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq211.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq211_init()
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
      CALL cl_set_combo_scc_part('b_isaestus','13','N,Y,X')
 
      CALL cl_set_combo_scc('b_isae006','9713') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_isae021','9759')
   CALL cl_set_combo_scc('b_isae015','9760')
   CALL aisq211_qbe_clear()
   #end add-point
 
   CALL aisq211_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq211.default_search" >}
PRIVATE FUNCTION aisq211_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isaesite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isaecomp = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " isae001 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " isae002 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " isae003 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " isae004 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " isae016 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " isae017 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " isae018 = '", g_argv[09], "' AND "
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
 
{<section id="aisq211.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq211_ui_dialog()
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
   CALL aisq211_create_tmp()
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aisq211_b_fill()
   ELSE
      CALL aisq211_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isae_d.clear()
 
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
 
         CALL aisq211_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isae_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq211_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq211_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
 
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aisq211_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #CALL aisq211_qbe_clear()
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aisq211_ins_x01_tmp()
               CALL aisq211_x01('1=1','aisq211_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aisq211_ins_x01_tmp()
               CALL aisq211_x01('1=1','aisq211_x01_tmp',g_xg_visible)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq211_query()
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
            CALL aisq211_filter()
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
            CALL aisq211_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isae_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
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
            CALL aisq211_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq211_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq211_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq211_b_fill()
 
         
         
 
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
 
{<section id="aisq211.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq211_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE g_glaald        LIKE glaa_t.glaald
   DEFINE l_count         LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
 
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isae_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isaecomp,isaesite,isae022,isae002,isae003,isae016,isae017,isae018,isae004, 
          isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012,isae013,isae014,isae021, 
          isae023,isae015,isaestus
           FROM s_detail1[1].b_isaecomp,s_detail1[1].b_isaesite,s_detail1[1].b_isae022,s_detail1[1].b_isae002, 
               s_detail1[1].b_isae003,s_detail1[1].b_isae016,s_detail1[1].b_isae017,s_detail1[1].b_isae018, 
               s_detail1[1].b_isae004,s_detail1[1].b_isae001,s_detail1[1].b_isae006,s_detail1[1].b_isae008, 
               s_detail1[1].b_isae007,s_detail1[1].b_isae009,s_detail1[1].b_isae010,s_detail1[1].b_isae005, 
               s_detail1[1].b_isae011,s_detail1[1].b_isae012,s_detail1[1].b_isae013,s_detail1[1].b_isae014, 
               s_detail1[1].b_isae021,s_detail1[1].b_isae023,s_detail1[1].b_isae015,s_detail1[1].b_isaestus 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isaecrtdt>>----
         #AFTER FIELD isaecrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<isaemoddt>>----
         #AFTER FIELD isaemoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaecnfdt>>----
         #AFTER FIELD isaecnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaepstdt>>----
         #AFTER FIELD isaepstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<b_isaecomp>>----
         #Ctrlp:construct.c.page1.b_isaecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaecomp
            #add-point:ON ACTION controlp INFIELD b_isaecomp name="construct.c.page1.b_isaecomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaecomp  #顯示到畫面上
            NEXT FIELD b_isaecomp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaecomp
            #add-point:BEFORE FIELD b_isaecomp name="construct.b.page1.b_isaecomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaecomp
            
            #add-point:AFTER FIELD b_isaecomp name="construct.a.page1.b_isaecomp"
            
            #END add-point
            
 
 
         #----<<b_isaecomp_desc>>----
         #----<<b_isaesite>>----
         #Ctrlp:construct.c.page1.b_isaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaesite
            #add-point:ON ACTION controlp INFIELD b_isaesite name="construct.c.page1.b_isaesite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaesite  #顯示到畫面上
            NEXT FIELD b_isaesite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaesite
            #add-point:BEFORE FIELD b_isaesite name="construct.b.page1.b_isaesite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaesite
            
            #add-point:AFTER FIELD b_isaesite name="construct.a.page1.b_isaesite"
            
            #END add-point
            
 
 
         #----<<b_isaesite_desc>>----
         #----<<b_isae022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae022
            #add-point:BEFORE FIELD b_isae022 name="construct.b.page1.b_isae022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae022
            
            #add-point:AFTER FIELD b_isae022 name="construct.a.page1.b_isae022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae022
            #add-point:ON ACTION controlp INFIELD b_isae022 name="construct.c.page1.b_isae022"
            
            #END add-point
 
 
         #----<<b_isae002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae002
            #add-point:BEFORE FIELD b_isae002 name="construct.b.page1.b_isae002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae002
            
            #add-point:AFTER FIELD b_isae002 name="construct.a.page1.b_isae002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae002
            #add-point:ON ACTION controlp INFIELD b_isae002 name="construct.c.page1.b_isae002"
            
            #END add-point
 
 
         #----<<b_isae003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae003
            #add-point:BEFORE FIELD b_isae003 name="construct.b.page1.b_isae003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae003
            
            #add-point:AFTER FIELD b_isae003 name="construct.a.page1.b_isae003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae003
            #add-point:ON ACTION controlp INFIELD b_isae003 name="construct.c.page1.b_isae003"
            
            #END add-point
 
 
         #----<<b_isae016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae016
            #add-point:BEFORE FIELD b_isae016 name="construct.b.page1.b_isae016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae016
            
            #add-point:AFTER FIELD b_isae016 name="construct.a.page1.b_isae016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae016
            #add-point:ON ACTION controlp INFIELD b_isae016 name="construct.c.page1.b_isae016"
            
            #END add-point
 
 
         #----<<b_isae017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae017
            #add-point:BEFORE FIELD b_isae017 name="construct.b.page1.b_isae017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae017
            
            #add-point:AFTER FIELD b_isae017 name="construct.a.page1.b_isae017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae017
            #add-point:ON ACTION controlp INFIELD b_isae017 name="construct.c.page1.b_isae017"
            
            #END add-point
 
 
         #----<<b_isae018>>----
         #Ctrlp:construct.c.page1.b_isae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae018
            #add-point:ON ACTION controlp INFIELD b_isae018 name="construct.c.page1.b_isae018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae018  #顯示到畫面上
            NEXT FIELD b_isae018                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae018
            #add-point:BEFORE FIELD b_isae018 name="construct.b.page1.b_isae018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae018
            
            #add-point:AFTER FIELD b_isae018 name="construct.a.page1.b_isae018"
            
            #END add-point
            
 
 
         #----<<b_isae018_desc>>----
         #----<<b_isae004>>----
         #Ctrlp:construct.c.page1.b_isae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae004
            #add-point:ON ACTION controlp INFIELD b_isae004 name="construct.c.page1.b_isae004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_isae_m.l_isac001,"' "
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae004  #顯示到畫面上
            NEXT FIELD b_isae004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae004
            #add-point:BEFORE FIELD b_isae004 name="construct.b.page1.b_isae004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae004
            
            #add-point:AFTER FIELD b_isae004 name="construct.a.page1.b_isae004"
            
            #END add-point
            
 
 
         #----<<b_isae004_desc>>----
         #----<<b_isae001>>----
         #Ctrlp:construct.c.page1.b_isae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae001
            #add-point:ON ACTION controlp INFIELD b_isae001 name="construct.c.page1.b_isae001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae001  #顯示到畫面上
            NEXT FIELD b_isae001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae001
            #add-point:BEFORE FIELD b_isae001 name="construct.b.page1.b_isae001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae001
            
            #add-point:AFTER FIELD b_isae001 name="construct.a.page1.b_isae001"
            
            #END add-point
            
 
 
         #----<<b_isae006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae006
            #add-point:BEFORE FIELD b_isae006 name="construct.b.page1.b_isae006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae006
            
            #add-point:AFTER FIELD b_isae006 name="construct.a.page1.b_isae006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae006
            #add-point:ON ACTION controlp INFIELD b_isae006 name="construct.c.page1.b_isae006"
            
            #END add-point
 
 
         #----<<b_isae008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae008
            #add-point:BEFORE FIELD b_isae008 name="construct.b.page1.b_isae008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae008
            
            #add-point:AFTER FIELD b_isae008 name="construct.a.page1.b_isae008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae008
            #add-point:ON ACTION controlp INFIELD b_isae008 name="construct.c.page1.b_isae008"
            
            #END add-point
 
 
         #----<<b_isae007>>----
         #Ctrlp:construct.c.page1.b_isae007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae007
            #add-point:ON ACTION controlp INFIELD b_isae007 name="construct.c.page1.b_isae007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isad005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae007  #顯示到畫面上
            NEXT FIELD b_isae007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae007
            #add-point:BEFORE FIELD b_isae007 name="construct.b.page1.b_isae007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae007
            
            #add-point:AFTER FIELD b_isae007 name="construct.a.page1.b_isae007"
            
            #END add-point
            
 
 
         #----<<b_isae009>>----
         #Ctrlp:construct.c.page1.b_isae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae009
            #add-point:ON ACTION controlp INFIELD b_isae009 name="construct.c.page1.b_isae009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae009  #顯示到畫面上
            NEXT FIELD b_isae009                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae009
            #add-point:BEFORE FIELD b_isae009 name="construct.b.page1.b_isae009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae009
            
            #add-point:AFTER FIELD b_isae009 name="construct.a.page1.b_isae009"
            
            #END add-point
            
 
 
         #----<<b_isae010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae010
            #add-point:BEFORE FIELD b_isae010 name="construct.b.page1.b_isae010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae010
            
            #add-point:AFTER FIELD b_isae010 name="construct.a.page1.b_isae010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae010
            #add-point:ON ACTION controlp INFIELD b_isae010 name="construct.c.page1.b_isae010"
            
            #END add-point
 
 
         #----<<b_isae005>>----
         #Ctrlp:construct.c.page1.b_isae005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae005
            #add-point:ON ACTION controlp INFIELD b_isae005 name="construct.c.page1.b_isae005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isad005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae005  #顯示到畫面上
            NEXT FIELD b_isae005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae005
            #add-point:BEFORE FIELD b_isae005 name="construct.b.page1.b_isae005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae005
            
            #add-point:AFTER FIELD b_isae005 name="construct.a.page1.b_isae005"
            
            #END add-point
            
 
 
         #----<<b_isae011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae011
            #add-point:BEFORE FIELD b_isae011 name="construct.b.page1.b_isae011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae011
            
            #add-point:AFTER FIELD b_isae011 name="construct.a.page1.b_isae011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae011
            #add-point:ON ACTION controlp INFIELD b_isae011 name="construct.c.page1.b_isae011"
            
            #END add-point
 
 
         #----<<b_isae012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae012
            #add-point:BEFORE FIELD b_isae012 name="construct.b.page1.b_isae012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae012
            
            #add-point:AFTER FIELD b_isae012 name="construct.a.page1.b_isae012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae012
            #add-point:ON ACTION controlp INFIELD b_isae012 name="construct.c.page1.b_isae012"
            
            #END add-point
 
 
         #----<<b_isae013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae013
            #add-point:BEFORE FIELD b_isae013 name="construct.b.page1.b_isae013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae013
            
            #add-point:AFTER FIELD b_isae013 name="construct.a.page1.b_isae013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae013
            #add-point:ON ACTION controlp INFIELD b_isae013 name="construct.c.page1.b_isae013"
            
            #END add-point
 
 
         #----<<b_isae014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae014
            #add-point:BEFORE FIELD b_isae014 name="construct.b.page1.b_isae014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae014
            
            #add-point:AFTER FIELD b_isae014 name="construct.a.page1.b_isae014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae014
            #add-point:ON ACTION controlp INFIELD b_isae014 name="construct.c.page1.b_isae014"
            
            #END add-point
 
 
         #----<<b_isae021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae021
            #add-point:BEFORE FIELD b_isae021 name="construct.b.page1.b_isae021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae021
            
            #add-point:AFTER FIELD b_isae021 name="construct.a.page1.b_isae021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae021
            #add-point:ON ACTION controlp INFIELD b_isae021 name="construct.c.page1.b_isae021"
            
            #END add-point
 
 
         #----<<b_isae023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae023
            #add-point:BEFORE FIELD b_isae023 name="construct.b.page1.b_isae023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae023
            
            #add-point:AFTER FIELD b_isae023 name="construct.a.page1.b_isae023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae023
            #add-point:ON ACTION controlp INFIELD b_isae023 name="construct.c.page1.b_isae023"
            
            #END add-point
 
 
         #----<<b_isae015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isae015
            #add-point:BEFORE FIELD b_isae015 name="construct.b.page1.b_isae015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isae015
            
            #add-point:AFTER FIELD b_isae015 name="construct.a.page1.b_isae015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae015
            #add-point:ON ACTION controlp INFIELD b_isae015 name="construct.c.page1.b_isae015"
            
            #END add-point
 
 
         #----<<b_isaestus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaestus
            #add-point:BEFORE FIELD b_isaestus name="construct.b.page1.b_isaestus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaestus
            
            #add-point:AFTER FIELD b_isaestus name="construct.a.page1.b_isaestus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaestus
            #add-point:ON ACTION controlp INFIELD b_isaestus name="construct.c.page1.b_isaestus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_isae_m.l_isaecomp,g_isae_m.l_isaesite,g_isae_m.l_isae022 ATTRIBUTE (WITHOUT DEFAULTS)
      
      
         ON ACTION controlp INFIELD l_isaecomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM isae_t WHERE isaeent = ooefent",
                                   " AND isaecomp = ooef001 AND isaestus = 'Y' ",
                                            ") ",
                                   " AND ooef003 = 'Y'" ,
                                   " AND ooef001 IN ",g_wc_cs_comp
            LET g_qryparam.default1 = g_isae_m.l_isaecomp
            CALL q_ooef001()
            LET g_isae_m.l_isaecomp = g_qryparam.return1
            DISPLAY g_isae_m.l_isaecomp TO l_isaecomp
            CALL s_desc_get_department_desc(g_isae_m.l_isaecomp) RETURNING g_isae_m.l_isaecomp_desc
            DISPLAY BY NAME g_isae_m.l_isaecomp_desc
            NEXT FIELD l_isaecomp
            
            
         AFTER FIELD l_isaecomp
            LET g_isae_m.l_isaecomp_desc = ''
            DISPLAY BY NAME g_isae_m.l_isaecomp_desc
            IF NOT cl_null(g_isae_m.l_isaecomp) THEN
               IF g_isae_m.l_isaecomp != g_isae_m_o.l_isaecomp OR cl_null(g_isae_m_o.l_isaecomp) THEN
                  
                  LET l_count = NULL
                  SELECT count(1) INTO l_count 
                    FROM isae_t,ooef_t
                   WHERE isaeent  = ooefent
                     AND ooefent = g_enterprise
                     AND ooef001 = g_isae_m.l_isaecomp 
                     AND isaestus = 'Y'
                     
                  IF cl_null(l_count) THEN LET l_count = 0 END IF 
                     
                  IF l_count = 0 THEN
                     LET g_isae_m.l_isaecomp = g_isae_m_o.l_isaecomp
                     LET g_isae_m.l_isaecomp_desc = g_isae_m_o.l_isaecomp_desc
                     LET g_isae_m.l_isac001 = g_isae_m_o.l_isac001
                     DISPLAY BY NAME g_isae_m.l_isaecomp,g_isae_m.l_isaecomp_desc
                  
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aap-00115'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF  
                  
                  LET l_count = NULL
                  SELECT count(1) INTO l_count 
                    FROM s_fin_tmp1
                   WHERE comp = g_isae_m.l_isaecomp
                     AND comp IN (SELECT ooef001 FROM s_fin_tmp1)
                     
                  IF cl_null(l_count) THEN LET l_count = 0 END IF 
                  
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isaecomp = g_isae_m_o.l_isaecomp
                     LET g_isae_m.l_isaecomp_desc = g_isae_m_o.l_isaecomp_desc
                     LET g_isae_m.l_isac001 = g_isae_m_o.l_isac001
                     DISPLAY BY NAME g_isae_m.l_isaecomp,g_isae_m.l_isaecomp_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL aisq211_isae_chk(g_isae_m.l_isaecomp,g_isae_m.l_isaesite,g_isae_m.l_isae022) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isaecomp = g_isae_m_o.l_isaecomp
                     LET g_isae_m.l_isaecomp_desc = g_isae_m_o.l_isaecomp_desc
                     DISPLAY BY NAME g_isae_m.l_isaecomp,g_isae_m.l_isaecomp_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isae_m.l_isaecomp) RETURNING g_isae_m.l_isaecomp_desc
            
            #所屬法人的稅區
            LET g_isae_m.l_isac001 = NULL
            SELECT ooef019 INTO g_isae_m.l_isac001
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_isae_m.l_isaecomp
            
            CALL aisq211_set_visible()
            CALL aisq211_set_no_visible() 
            
            DISPLAY BY NAME g_isae_m.l_isaecomp_desc,g_isae_m.l_isac001
            LET g_isae_m_o.* = g_isae_m.*
            


         ON ACTION controlp INFIELD l_isaesite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isaecomp = '",g_isae_m.l_isaecomp,"' ",
                                   " AND isaestus = 'Y'"," AND isaesite IN ",g_wc_apgborga
            LET g_qryparam.default1 = g_isae_m.l_isaesite
            CALL q_isaesite()
            LET g_isae_m.l_isaesite = g_qryparam.return1
            DISPLAY g_isae_m.l_isaesite TO l_isaesite
            CALL s_desc_get_department_desc(g_isae_m.l_isaesite) RETURNING g_isae_m.l_isaesite_desc
            DISPLAY BY NAME g_isae_m.l_isaesite_desc
            NEXT FIELD l_isaesite         
            
            
         AFTER FIELD l_isaesite
            LET g_isae_m.l_isaesite_desc = ''
            DISPLAY BY NAME g_isae_m.l_isaesite_desc
            IF NOT cl_null(g_isae_m.l_isaesite) THEN
               IF g_isae_m.l_isaesite != g_isae_m_o.l_isaesite OR cl_null(g_isae_m_o.l_isaesite) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_chkparam.arg1 = g_isae_m.l_isaesite
                  LET g_errshow = TRUE  #是否彈窗
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_isae_m.l_isaesite = g_isae_m_o.l_isaesite
                     LET g_isae_m.l_isaesite_desc = g_isae_m_o.l_isaesite_desc
                     DISPLAY BY NAME g_isae_m.l_isaesite_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = NULL
                  SELECT count(1) INTO l_count 
                    FROM s_fin_tmp1
                   WHERE comp    = g_isae_m.l_isaecomp
                     AND ooef001 = g_isae_m.l_isaesite
                     
                  IF cl_null(l_count) THEN LET l_count = 0 END IF  
                     
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isaesite = g_isae_m_o.l_isaesite
                     LET g_isae_m.l_isaesite_desc = g_isae_m_o.l_isaesite_desc
                     DISPLAY BY NAME g_isae_m.l_isaesite_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL aisq211_isae_chk(g_isae_m.l_isaecomp,g_isae_m.l_isaesite,g_isae_m.l_isae022) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isaesite = g_isae_m_o.l_isaesite
                     LET g_isae_m.l_isaesite_desc = g_isae_m_o.l_isaesite_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isae_m.l_isaesite) RETURNING g_isae_m.l_isaesite_desc
            DISPLAY BY NAME g_isae_m.l_isaesite_desc
            LET g_isae_m_o.* = g_isae_m.*
         
         
         ON ACTION controlp INFIELD l_isae022
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " EXISTS (SELECT 1 FROM isae_t WHERE isaecomp = '",g_isae_m.l_isaecomp,"' ",
                                   " AND isaesite = '",g_isae_m.l_isaesite,"'",
                                   " AND isaeent = ooefent AND isae022 = ooef001",
                                            ") ",
                                   " AND ooef017 = '",g_isae_m.l_isaecomp,"' "," AND (ooef304='Y' OR ooef201='Y') ",
                                   " AND ooef001 IN ",g_wc_apgborga
            LET g_qryparam.default1 = g_isae_m.l_isae022
            CALL q_ooef001_01()
            LET g_isae_m.l_isae022 = g_qryparam.return1
            DISPLAY g_isae_m.l_isae022 TO l_isae022
            CALL s_desc_get_department_desc(g_isae_m.l_isae022) RETURNING g_isae_m.l_isae022_desc
            DISPLAY BY NAME g_isae_m.l_isae022_desc
            NEXT FIELD l_isae022
            
            
         AFTER FIELD l_isae022
            LET g_isae_m.l_isae022_desc = ''
            DISPLAY BY NAME g_isae_m.l_isae022_desc
            IF NOT cl_null(g_isae_m.l_isae022) THEN
               IF g_isae_m.l_isae022 != g_isae_m_o.l_isae022 OR cl_null(g_isae_m_o.l_isae022) THEN
                  LET g_chkparam.arg1 = g_isae_m.l_isae022
                  LET g_errshow = TRUE #是否彈窗
                  IF NOT cl_chk_exist("v_ooef001") THEN
                     LET g_isae_m.l_isae022 = g_isae_m_o.l_isae022
                     LET g_isae_m.l_isae022_desc = g_isae_m_o.l_isae022_desc
                     DISPLAY BY NAME g_isae_m.l_isae022_desc
                     NEXT FIELD CURRENT
                  END IF
                  
                  LET l_count = NULL
                  SELECT count(1) INTO l_count 
                    FROM s_fin_tmp1
                   WHERE ooef001 = g_isae_m.l_isae022
                   
                  IF cl_null(l_count) THEN LET l_count = 0 END IF 
                     
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isae022 = g_isae_m_o.l_isae022
                     LET g_isae_m.l_isae022_desc = g_isae_m_o.l_isae022_desc
                     DISPLAY BY NAME g_isae_m.l_isae022_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL aisq211_isae_chk(g_isae_m.l_isaecomp,g_isae_m.l_isaesite,g_isae_m.l_isae022) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_isae_m.l_isae022 = g_isae_m_o.l_isae022
                     LET g_isae_m.l_isae022_desc = g_isae_m_o.l_isae022_desc
                     DISPLAY BY NAME g_isae_m.l_isae022_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_department_desc(g_isae_m.l_isae022) RETURNING g_isae_m.l_isae022_desc
            DISPLAY BY NAME g_isae_m.l_isae022_desc
            LET g_isae_m_o.* = g_isae_m.*
            

      END INPUT
      
      CONSTRUCT g_isae_wc ON isae016 FROM l_isae016
         
         ON ACTION controlp INFIELD l_isae016
      END CONSTRUCT
      
      BEFORE DIALOG
      
        CALL aisq211_qbe_clear()
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
         CALL aisq211_qbe_clear()
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
   CALL aisq211_b_fill()
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
 
{<section id="aisq211.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq211_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE ls_sql          STRING
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE isaecomp,'',isaesite,'',isae022,isae002,isae003,isae016,isae017, 
       isae018,'',isae004,'',isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012, 
       isae013,isae014,isae021,isae023,isae015,isaestus  ,DENSE_RANK() OVER( ORDER BY isae_t.isaesite, 
       isae_t.isaecomp,isae_t.isae001,isae_t.isae002,isae_t.isae003,isae_t.isae004,isae_t.isae016,isae_t.isae017, 
       isae_t.isae018) AS RANK FROM isae_t",
 
 
                     "",
                     " WHERE isaeent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isae_t"),
                     " ORDER BY isae_t.isaesite,isae_t.isaecomp,isae_t.isae001,isae_t.isae002,isae_t.isae003,isae_t.isae004,isae_t.isae016,isae_t.isae017,isae_t.isae018"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc       = ls_wc CLIPPED," AND isaecomp = '",g_isae_m.l_isaecomp,"' AND isaesite = '",g_isae_m.l_isaesite,"' ",
                    " AND isae022 = '",g_isae_m.l_isae022,"' AND ",g_isae_wc CLIPPED  
   
   LET ls_sql_rank = "SELECT  UNIQUE isaecomp,'',isaesite,'',isae022,isae002,isae003,isae016,isae017,",
                     "isae018,'',isae004,",
                     "(SELECT isacl004 FROM isacl_t WHERE isaclent = isaeent AND isacl001 = '",g_isae_m.l_isac001,"' AND isacl002 = isae004 AND isacl003 = '",g_dlang,"') isae004_desc,",
                     "isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012,",
                     "isae013,isae014,isae021,isae023,isae015,isaestus  ,",
                     "DENSE_RANK() OVER( ORDER BY isae_t.isaesite, ",
                     "isae_t.isaecomp,isae_t.isae001,isae_t.isae002,isae_t.isae003,isae_t.isae004,isae_t.isae016,isae_t.isae017,",
                         "isae_t.isae018) AS RANK ",
                     "FROM isae_t",
 
 
                     "",
                     " WHERE isaeent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isae_t"),
                     " ORDER BY isae_t.isaesite,isae_t.isaecomp,isae_t.isae001,isae_t.isae002,isae_t.isae003,isae_t.isae004,isae_t.isae016,isae_t.isae017,isae_t.isae018"
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
 
   LET g_sql = "SELECT isaecomp,'',isaesite,'',isae022,isae002,isae003,isae016,isae017,isae018,'',isae004, 
       '',isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012,isae013,isae014,isae021, 
       isae023,isae015,isaestus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT isaecomp,'',isaesite,'',isae022,isae002,isae003,isae016,isae017,isae018,'',isae004, 
       isae004_desc,isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012,isae013,isae014,isae021, 
       isae023,isae015,isaestus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq211_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq211_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isae_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isae_d[l_ac].isaecomp,g_isae_d[l_ac].isaecomp_desc,g_isae_d[l_ac].isaesite, 
       g_isae_d[l_ac].isaesite_desc,g_isae_d[l_ac].isae022,g_isae_d[l_ac].isae002,g_isae_d[l_ac].isae003, 
       g_isae_d[l_ac].isae016,g_isae_d[l_ac].isae017,g_isae_d[l_ac].isae018,g_isae_d[l_ac].isae018_desc, 
       g_isae_d[l_ac].isae004,g_isae_d[l_ac].isae004_desc,g_isae_d[l_ac].isae001,g_isae_d[l_ac].isae006, 
       g_isae_d[l_ac].isae008,g_isae_d[l_ac].isae007,g_isae_d[l_ac].isae009,g_isae_d[l_ac].isae010,g_isae_d[l_ac].isae005, 
       g_isae_d[l_ac].isae011,g_isae_d[l_ac].isae012,g_isae_d[l_ac].isae013,g_isae_d[l_ac].isae014,g_isae_d[l_ac].isae021, 
       g_isae_d[l_ac].isae023,g_isae_d[l_ac].isae015,g_isae_d[l_ac].isaestus
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isae_d[l_ac].statepic = cl_get_actipic(g_isae_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      CALL aisq211_detail_show("'1'")      
 
      CALL aisq211_isae_t_mask()
 
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
   
 
   
   CALL g_isae_d.deleteElement(g_isae_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isae_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq211_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq211_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq211_detail_action_trans()
 
   IF g_isae_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq211_fetch()
   END IF
   
      CALL aisq211_filter_show('isaecomp','b_isaecomp')
   CALL aisq211_filter_show('isaesite','b_isaesite')
   CALL aisq211_filter_show('isae022','b_isae022')
   CALL aisq211_filter_show('isae002','b_isae002')
   CALL aisq211_filter_show('isae003','b_isae003')
   CALL aisq211_filter_show('isae016','b_isae016')
   CALL aisq211_filter_show('isae017','b_isae017')
   CALL aisq211_filter_show('isae018','b_isae018')
   CALL aisq211_filter_show('isae004','b_isae004')
   CALL aisq211_filter_show('isae001','b_isae001')
   CALL aisq211_filter_show('isae006','b_isae006')
   CALL aisq211_filter_show('isae008','b_isae008')
   CALL aisq211_filter_show('isae007','b_isae007')
   CALL aisq211_filter_show('isae009','b_isae009')
   CALL aisq211_filter_show('isae010','b_isae010')
   CALL aisq211_filter_show('isae005','b_isae005')
   CALL aisq211_filter_show('isae011','b_isae011')
   CALL aisq211_filter_show('isae012','b_isae012')
   CALL aisq211_filter_show('isae013','b_isae013')
   CALL aisq211_filter_show('isae014','b_isae014')
   CALL aisq211_filter_show('isae021','b_isae021')
   CALL aisq211_filter_show('isae023','b_isae023')
   CALL aisq211_filter_show('isae015','b_isae015')
   CALL aisq211_filter_show('isaestus','b_isaestus')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq211_fetch()
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
 
{<section id="aisq211.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq211_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq211_filter()
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
      CONSTRUCT g_wc_filter ON isaecomp,isaesite,isae022,isae002,isae003,isae016,isae017,isae018,isae004, 
          isae001,isae006,isae008,isae007,isae009,isae010,isae005,isae011,isae012,isae013,isae014,isae021, 
          isae023,isae015,isaestus
                          FROM s_detail1[1].b_isaecomp,s_detail1[1].b_isaesite,s_detail1[1].b_isae022, 
                              s_detail1[1].b_isae002,s_detail1[1].b_isae003,s_detail1[1].b_isae016,s_detail1[1].b_isae017, 
                              s_detail1[1].b_isae018,s_detail1[1].b_isae004,s_detail1[1].b_isae001,s_detail1[1].b_isae006, 
                              s_detail1[1].b_isae008,s_detail1[1].b_isae007,s_detail1[1].b_isae009,s_detail1[1].b_isae010, 
                              s_detail1[1].b_isae005,s_detail1[1].b_isae011,s_detail1[1].b_isae012,s_detail1[1].b_isae013, 
                              s_detail1[1].b_isae014,s_detail1[1].b_isae021,s_detail1[1].b_isae023,s_detail1[1].b_isae015, 
                              s_detail1[1].b_isaestus
 
         BEFORE CONSTRUCT
                     DISPLAY aisq211_filter_parser('isaecomp') TO s_detail1[1].b_isaecomp
            DISPLAY aisq211_filter_parser('isaesite') TO s_detail1[1].b_isaesite
            DISPLAY aisq211_filter_parser('isae022') TO s_detail1[1].b_isae022
            DISPLAY aisq211_filter_parser('isae002') TO s_detail1[1].b_isae002
            DISPLAY aisq211_filter_parser('isae003') TO s_detail1[1].b_isae003
            DISPLAY aisq211_filter_parser('isae016') TO s_detail1[1].b_isae016
            DISPLAY aisq211_filter_parser('isae017') TO s_detail1[1].b_isae017
            DISPLAY aisq211_filter_parser('isae018') TO s_detail1[1].b_isae018
            DISPLAY aisq211_filter_parser('isae004') TO s_detail1[1].b_isae004
            DISPLAY aisq211_filter_parser('isae001') TO s_detail1[1].b_isae001
            DISPLAY aisq211_filter_parser('isae006') TO s_detail1[1].b_isae006
            DISPLAY aisq211_filter_parser('isae008') TO s_detail1[1].b_isae008
            DISPLAY aisq211_filter_parser('isae007') TO s_detail1[1].b_isae007
            DISPLAY aisq211_filter_parser('isae009') TO s_detail1[1].b_isae009
            DISPLAY aisq211_filter_parser('isae010') TO s_detail1[1].b_isae010
            DISPLAY aisq211_filter_parser('isae005') TO s_detail1[1].b_isae005
            DISPLAY aisq211_filter_parser('isae011') TO s_detail1[1].b_isae011
            DISPLAY aisq211_filter_parser('isae012') TO s_detail1[1].b_isae012
            DISPLAY aisq211_filter_parser('isae013') TO s_detail1[1].b_isae013
            DISPLAY aisq211_filter_parser('isae014') TO s_detail1[1].b_isae014
            DISPLAY aisq211_filter_parser('isae021') TO s_detail1[1].b_isae021
            DISPLAY aisq211_filter_parser('isae023') TO s_detail1[1].b_isae023
            DISPLAY aisq211_filter_parser('isae015') TO s_detail1[1].b_isae015
            DISPLAY aisq211_filter_parser('isaestus') TO s_detail1[1].b_isaestus
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<isaecrtdt>>----
         #AFTER FIELD isaecrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<isaemoddt>>----
         #AFTER FIELD isaemoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaecnfdt>>----
         #AFTER FIELD isaecnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<isaepstdt>>----
         #AFTER FIELD isaepstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<b_isaecomp>>----
         #Ctrlp:construct.c.page1.b_isaecomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaecomp
            #add-point:ON ACTION controlp INFIELD b_isaecomp name="construct.c.filter.page1.b_isaecomp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaecomp  #顯示到畫面上
            NEXT FIELD b_isaecomp                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isaecomp_desc>>----
         #----<<b_isaesite>>----
         #Ctrlp:construct.c.page1.b_isaesite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaesite
            #add-point:ON ACTION controlp INFIELD b_isaesite name="construct.c.filter.page1.b_isaesite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaesite  #顯示到畫面上
            NEXT FIELD b_isaesite                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isaesite_desc>>----
         #----<<b_isae022>>----
         #Ctrlp:construct.c.filter.page1.b_isae022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae022
            #add-point:ON ACTION controlp INFIELD b_isae022 name="construct.c.filter.page1.b_isae022"
            
            #END add-point
 
 
         #----<<b_isae002>>----
         #Ctrlp:construct.c.filter.page1.b_isae002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae002
            #add-point:ON ACTION controlp INFIELD b_isae002 name="construct.c.filter.page1.b_isae002"
            
            #END add-point
 
 
         #----<<b_isae003>>----
         #Ctrlp:construct.c.filter.page1.b_isae003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae003
            #add-point:ON ACTION controlp INFIELD b_isae003 name="construct.c.filter.page1.b_isae003"
            
            #END add-point
 
 
         #----<<b_isae016>>----
         #Ctrlp:construct.c.filter.page1.b_isae016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae016
            #add-point:ON ACTION controlp INFIELD b_isae016 name="construct.c.filter.page1.b_isae016"
            
            #END add-point
 
 
         #----<<b_isae017>>----
         #Ctrlp:construct.c.filter.page1.b_isae017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae017
            #add-point:ON ACTION controlp INFIELD b_isae017 name="construct.c.filter.page1.b_isae017"
            
            #END add-point
 
 
         #----<<b_isae018>>----
         #Ctrlp:construct.c.page1.b_isae018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae018
            #add-point:ON ACTION controlp INFIELD b_isae018 name="construct.c.filter.page1.b_isae018"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae018  #顯示到畫面上
            NEXT FIELD b_isae018                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isae018_desc>>----
         #----<<b_isae004>>----
         #Ctrlp:construct.c.page1.b_isae004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae004
            #add-point:ON ACTION controlp INFIELD b_isae004 name="construct.c.filter.page1.b_isae004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_isae_m.l_isac001,"' "
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae004  #顯示到畫面上
            NEXT FIELD b_isae004                     #返回原欄位



            #END add-point
 
 
         #----<<b_isae004_desc>>----
         #----<<b_isae001>>----
         #Ctrlp:construct.c.page1.b_isae001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae001
            #add-point:ON ACTION controlp INFIELD b_isae001 name="construct.c.filter.page1.b_isae001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaesite()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae001  #顯示到畫面上
            NEXT FIELD b_isae001                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isae006>>----
         #Ctrlp:construct.c.filter.page1.b_isae006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae006
            #add-point:ON ACTION controlp INFIELD b_isae006 name="construct.c.filter.page1.b_isae006"
            
            #END add-point
 
 
         #----<<b_isae008>>----
         #Ctrlp:construct.c.filter.page1.b_isae008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae008
            #add-point:ON ACTION controlp INFIELD b_isae008 name="construct.c.filter.page1.b_isae008"
            
            #END add-point
 
 
         #----<<b_isae007>>----
         #Ctrlp:construct.c.page1.b_isae007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae007
            #add-point:ON ACTION controlp INFIELD b_isae007 name="construct.c.filter.page1.b_isae007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isad005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae007  #顯示到畫面上
            NEXT FIELD b_isae007                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isae009>>----
         #Ctrlp:construct.c.page1.b_isae009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae009
            #add-point:ON ACTION controlp INFIELD b_isae009 name="construct.c.filter.page1.b_isae009"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isac002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae009  #顯示到畫面上
            NEXT FIELD b_isae009                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isae010>>----
         #Ctrlp:construct.c.filter.page1.b_isae010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae010
            #add-point:ON ACTION controlp INFIELD b_isae010 name="construct.c.filter.page1.b_isae010"
            
            #END add-point
 
 
         #----<<b_isae005>>----
         #Ctrlp:construct.c.page1.b_isae005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae005
            #add-point:ON ACTION controlp INFIELD b_isae005 name="construct.c.filter.page1.b_isae005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isad005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isae005  #顯示到畫面上
            NEXT FIELD b_isae005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isae011>>----
         #Ctrlp:construct.c.filter.page1.b_isae011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae011
            #add-point:ON ACTION controlp INFIELD b_isae011 name="construct.c.filter.page1.b_isae011"
            
            #END add-point
 
 
         #----<<b_isae012>>----
         #Ctrlp:construct.c.filter.page1.b_isae012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae012
            #add-point:ON ACTION controlp INFIELD b_isae012 name="construct.c.filter.page1.b_isae012"
            
            #END add-point
 
 
         #----<<b_isae013>>----
         #Ctrlp:construct.c.filter.page1.b_isae013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae013
            #add-point:ON ACTION controlp INFIELD b_isae013 name="construct.c.filter.page1.b_isae013"
            
            #END add-point
 
 
         #----<<b_isae014>>----
         #Ctrlp:construct.c.filter.page1.b_isae014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae014
            #add-point:ON ACTION controlp INFIELD b_isae014 name="construct.c.filter.page1.b_isae014"
            
            #END add-point
 
 
         #----<<b_isae021>>----
         #Ctrlp:construct.c.filter.page1.b_isae021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae021
            #add-point:ON ACTION controlp INFIELD b_isae021 name="construct.c.filter.page1.b_isae021"
            
            #END add-point
 
 
         #----<<b_isae023>>----
         #Ctrlp:construct.c.filter.page1.b_isae023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae023
            #add-point:ON ACTION controlp INFIELD b_isae023 name="construct.c.filter.page1.b_isae023"
            
            #END add-point
 
 
         #----<<b_isae015>>----
         #Ctrlp:construct.c.filter.page1.b_isae015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isae015
            #add-point:ON ACTION controlp INFIELD b_isae015 name="construct.c.filter.page1.b_isae015"
            
            #END add-point
 
 
         #----<<b_isaestus>>----
         #Ctrlp:construct.c.filter.page1.b_isaestus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaestus
            #add-point:ON ACTION controlp INFIELD b_isaestus name="construct.c.filter.page1.b_isaestus"
            
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
   
      CALL aisq211_filter_show('isaecomp','b_isaecomp')
   CALL aisq211_filter_show('isaesite','b_isaesite')
   CALL aisq211_filter_show('isae022','b_isae022')
   CALL aisq211_filter_show('isae002','b_isae002')
   CALL aisq211_filter_show('isae003','b_isae003')
   CALL aisq211_filter_show('isae016','b_isae016')
   CALL aisq211_filter_show('isae017','b_isae017')
   CALL aisq211_filter_show('isae018','b_isae018')
   CALL aisq211_filter_show('isae004','b_isae004')
   CALL aisq211_filter_show('isae001','b_isae001')
   CALL aisq211_filter_show('isae006','b_isae006')
   CALL aisq211_filter_show('isae008','b_isae008')
   CALL aisq211_filter_show('isae007','b_isae007')
   CALL aisq211_filter_show('isae009','b_isae009')
   CALL aisq211_filter_show('isae010','b_isae010')
   CALL aisq211_filter_show('isae005','b_isae005')
   CALL aisq211_filter_show('isae011','b_isae011')
   CALL aisq211_filter_show('isae012','b_isae012')
   CALL aisq211_filter_show('isae013','b_isae013')
   CALL aisq211_filter_show('isae014','b_isae014')
   CALL aisq211_filter_show('isae021','b_isae021')
   CALL aisq211_filter_show('isae023','b_isae023')
   CALL aisq211_filter_show('isae015','b_isae015')
   CALL aisq211_filter_show('isaestus','b_isaestus')
 
    
   CALL aisq211_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq211_filter_parser(ps_field)
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
 
{<section id="aisq211.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq211_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq211_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.insert" >}
#+ insert
PRIVATE FUNCTION aisq211_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq211.modify" >}
#+ modify
PRIVATE FUNCTION aisq211_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq211_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.delete" >}
#+ delete
PRIVATE FUNCTION aisq211_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq211.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq211_detail_action_trans()
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
 
{<section id="aisq211.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq211_detail_index_setting()
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
            IF g_isae_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isae_d.getLength() AND g_isae_d.getLength() > 0
            LET g_detail_idx = g_isae_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isae_d.getLength() THEN
               LET g_detail_idx = g_isae_d.getLength()
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
 
{<section id="aisq211.mask_functions" >}
 &include "erp/ais/aisq211_mask.4gl"
 
{</section>}
 
{<section id="aisq211.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 檢查法人,營運據點,發票門市是否有資料
# Memo...........:
# Usage..........: CALL aisq211_isae_chk(p_isaecomp,p_isaesite,p_isae022)
# Input parameter: p_isaecomp   法人
#                : p_isaesite   營運據點
#                : p_isae022    發票門市
# Date & Author..: 2016/09/02 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_isae_chk(p_isaecomp,p_isaesite,p_isae022)
DEFINE  p_isaecomp  LIKE isae_t.isaecomp
DEFINE  p_isaesite  LIKE isae_t.isaesite
DEFINE  p_isae022   LIKE isae_t.isae022
DEFINE  r_success   LIKE type_t.num5
DEFINE  r_errno     LIKE gzze_t.gzze001
DEFINE  l_n         LIKE type_t.num5
   
LET r_success = TRUE
LET r_errno = ''
   
   IF NOT cl_null(p_isaecomp) AND NOT cl_null(p_isaesite)THEN
     #法人跟組織關係
     CALL s_fin_site_belong_to_comp_chk(p_isaesite,p_isaecomp) RETURNING g_sub_success,g_errno
     IF NOT g_sub_success THEN
        LET r_success = FALSE
        LET r_errno = 'aap-00011'
        RETURN r_success,r_errno
     END IF        
   END IF

   IF NOT cl_null(p_isaecomp) AND NOT cl_null(p_isae022)THEN
      #法人跟門市
      CALL s_fin_site_belong_to_comp_chk(p_isae022,p_isaecomp) RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         LET r_success = FALSE
         LET r_errno = 'aap-00011'
         RETURN r_success,r_errno
      END IF        
   END IF
   
   IF NOT cl_null(p_isaecomp) AND NOT cl_null(p_isae022) AND NOT cl_null(p_isaesite)THEN
      #判斷是否存在
      LET l_n = NULL
      SELECT count(1) INTO l_n
        FROM isae_t
       WHERE isaecomp = p_isaecomp
         AND isaesite = p_isaesite
         AND isae022  = p_isae022
         AND isaeent = g_enterprise 
     
      IF cl_null(l_n) THEN LET l_n = 0 END IF         
      
      IF l_n = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00340'
         RETURN r_success,r_errno
      END IF
      
      #判斷是否有效
      LET l_n = NULL
      SELECT count(1) INTO l_n
        FROM isae_t
       WHERE isaecomp = p_isaecomp
         AND isaesite = p_isaesite
         AND isae022  = p_isae022
         AND isaeent = g_enterprise
         AND isaestus = 'Y'  
    
      IF cl_null(l_n) THEN LET l_n = 0 END IF      
      
      IF l_n = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00341'
         RETURN r_success,r_errno
      END IF
   END IF
   RETURN r_success,r_errno
   
   

END FUNCTION

################################################################################
# Descriptions...: 資料清空還原預設值
# Memo...........:
# Usage..........: CALL aisq211_qbe_clear()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/09/02 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_qbe_clear()
DEFINE l_success       LIKE type_t.num5
#DEFINE l_comp_str      STRING
#DEFINE l_site_str      STRING

   CALL s_fin_azzi800_sons_query(g_today) 
   CALL s_fin_account_center_comp_str() RETURNING g_wc_cs_comp
   CALL s_fin_get_wc_str(g_wc_cs_comp) RETURNING g_wc_cs_comp
   CALL s_fin_account_center_sons_str() RETURNING g_wc_apgborga
   CALL s_fin_get_wc_str(g_wc_apgborga) RETURNING g_wc_apgborga
   #CALL s_axrt300_get_site(g_user,'','1') RETURNING l_site_str
   #CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
   #LET g_wc_cs_comp = cl_replace_str(l_comp_str,"ooef017","isaecomp")
   #LET g_wc_apgborga = cl_replace_str(l_site_str,"ooef001","isaesite")
   
   CALL s_aooi100_get_comp(g_site) RETURNING l_success,g_isae_m.l_isaecomp
   LET g_isae_m.l_isaecomp_desc = s_desc_get_department_desc(g_isae_m.l_isaecomp) 
   LET g_isae_m.l_isaesite = g_site
   LET g_isae_m.l_isaesite_desc = s_desc_get_department_desc(g_isae_m.l_isaesite)
   LET g_isae_m.l_isae022 = ''
   LET g_isae_m_o.l_isae022 = ''
   
   #所屬法人的稅區
   SELECT ooef019 INTO g_isae_m.l_isac001
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_isae_m.l_isaecomp
   
   CALL aisq211_set_visible()
   CALL aisq211_set_no_visible()
   
   LET g_isae_m_o.* = g_isae_m.*
   DISPLAY BY NAME g_isae_m.l_isaecomp,g_isae_m.l_isaesite,g_isae_m.l_isaecomp_desc,
                   g_isae_m.l_isaesite_desc,g_isae_m.l_isac001
   
   
                   
   
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #160518-00068#4
# Usage..........: CALL aisq211_create_tmp()
# Date & Author..: 2016/09/05 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_create_tmp()
   
   #建立臨時表     
   DROP TABLE aisq211_x01_tmp;
   CREATE TEMP TABLE aisq211_x01_tmp(
      isaeent            SMALLINT,
      isaecomp           VARCHAR(10),
      l_isaecomp_desc    VARCHAR(100),
      isaesite           VARCHAR(10),
      l_isaesite_desc    VARCHAR(100),
      l_isac001_desc     VARCHAR(100),
      isae022            VARCHAR(10),
      l_isae022_desc     VARCHAR(100),
      isae002            DATE,
      isae003            DATE,
      isae016            SMALLINT,
      isae017            SMALLINT,
      isae018            SMALLINT,
      isae004            VARCHAR(2),
      isacl004           VARCHAR(500),
      isae001            VARCHAR(10),
      isae006            VARCHAR(1),
      l_isae006_desc     VARCHAR(100),
      isae008            VARCHAR(20),
      isae007            VARCHAR(20),
      isae009            VARCHAR(20),
      isae010            VARCHAR(20),
      isae005            VARCHAR(1),
      isae011            INTEGER,
      isae012            VARCHAR(20),
      isae013            SMALLINT,
      isae014            DATE,
      isae021            VARCHAR(10),
      l_isae021_desc     VARCHAR(100),
      isae023            VARCHAR(10),
      isae015            VARCHAR(1),
      l_isae015_desc     VARCHAR(100),
      isaestus           VARCHAR(10)
      )
      
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #160518-00068#4
# Usage..........: CALL aisq211_ins_x01_tmp()
# Date & Author..: 2016/09/05 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_ins_x01_tmp()
DEFINE l_i                 LIKE type_t.num5
DEFINE l_isaecomp_desc     LIKE type_t.chr100
DEFINE l_isaesite_desc     LIKE type_t.chr100
DEFINE l_isac001_desc      LIKE type_t.chr100
DEFINE l_isae022_desc      LIKE type_t.chr100
DEFINE l_isae006_desc      LIKE type_t.chr100
DEFINE l_isae021_desc      LIKE type_t.chr100
DEFINE l_isae015_desc      LIKE type_t.chr100

   #單頭
   
   LET l_isaecomp_desc = g_isae_m.l_isaecomp,':',g_isae_m.l_isaecomp_desc 
   LET l_isaesite_desc = g_isae_m.l_isaesite,':',g_isae_m.l_isaesite_desc
   LET l_isac001_desc = g_isae_m.l_isac001
   LET l_isae022_desc = g_isae_m.l_isae022,':',g_isae_m.l_isae022_desc
   
   DELETE FROM aisq211_x01_tmp
   
   #單身
   LET l_i = 1
   FOR l_i = 1 TO g_isae_d.getLength()     
      
      IF NOT cl_null(g_isae_d[l_i].isae006) THEN 
         LET l_isae006_desc = g_isae_d[l_i].isae006,":",s_desc_gzcbl004_desc('9713',g_isae_d[l_i].isae006)
      ELSE
         LET l_isae006_desc = ''
      END IF   

      IF NOT cl_null(g_isae_d[l_i].isae021) THEN 
         LET l_isae021_desc = g_isae_d[l_i].isae021,":",s_desc_gzcbl004_desc('9759',g_isae_d[l_i].isae021)
      ELSE
         LET l_isae021_desc = ''
      END IF
      
      IF NOT cl_null(g_isae_d[l_i].isae015) THEN 
         LET l_isae015_desc = g_isae_d[l_i].isae015,":",s_desc_gzcbl004_desc('9760',g_isae_d[l_i].isae015) 
      ELSE
         LET l_isae015_desc = ''         
      END IF

      
   INSERT INTO aisq211_x01_tmp
      VALUES(g_enterprise,             g_isae_d[l_i].isaecomp,   l_isaecomp_desc,
             g_isae_d[l_i].isaesite,   l_isaesite_desc,          l_isac001_desc,
             g_isae_d[l_i].isae022,    l_isae022_desc,           g_isae_d[l_i].isae002,
             g_isae_d[l_i].isae003,    g_isae_d[l_i].isae016,    g_isae_d[l_i].isae017,
             g_isae_d[l_i].isae018,    g_isae_d[l_i].isae004,    g_isae_d[l_i].isae004_desc,
             g_isae_d[l_i].isae001,    g_isae_d[l_i].isae006,    l_isae006_desc,
             g_isae_d[l_i].isae008,    g_isae_d[l_i].isae007,    g_isae_d[l_i].isae009,
             g_isae_d[l_i].isae010,    g_isae_d[l_i].isae005,    g_isae_d[l_i].isae011,
             g_isae_d[l_i].isae012,    g_isae_d[l_i].isae013,    g_isae_d[l_i].isae014,
             g_isae_d[l_i].isae021,    l_isae021_desc,           g_isae_d[l_i].isae023,
             g_isae_d[l_i].isae015,    l_isae015_desc,           g_isae_d[l_i].isaestus
             )
             
   END FOR
   CALL aisq211_xg_visible()
   
END FUNCTION

################################################################################
# Descriptions...: 傳進XG報表隱藏欄位設置
# Memo...........: #160518-00068#4
# Usage..........: CALL aisq211_xg_visible()
# Date & Author..: 2016/09/05 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_xg_visible()

   DEFINE l_isae008  LIKE isae_t.isae008
   
   LET g_xg_visible = NULL
   LET l_isae008 = ''
   
   SELECT isai002 INTO l_isae008
     FROM ooef_t
     LEFT JOIN isai_t ON isaient = ooefent AND isai001 = ooef019
     WHERE ooefent = g_enterprise
     AND ooef001 = g_isae_m.l_isaesite
     AND ooef017 = g_isae_m.l_isaecomp
     

   IF l_isae008 != 2 THEN      
      LET g_xg_visible = "isae008"
   ELSE
      LET g_xg_visible = "isae007"
   END IF
      
END FUNCTION

################################################################################
# Descriptions...: 開啟發票代碼、字軌欄位顯隱
# Memo...........:
# Usage..........: CALL aisq211_set_visible()
# Input parameter: 無
# Date & Author..: 2016/09/13 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_set_visible()
   
   CALL cl_set_comp_visible('b_isae008,b_isae007',TRUE)
   
END FUNCTION

################################################################################
# Descriptions...: 關閉發票代碼、字軌欄位顯隱
# Memo...........:
# Usage..........: CALL aisq211_set_no_visible()
# Input parameter: 無
# Date & Author..: 2016/09/13 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq211_set_no_visible()
DEFINE l_isai002  LIKE isai_t.isai002   

   SELECT isai002 INTO l_isai002
     FROM isai_t,ooef_t 
    WHERE ooefent = isaient 
      AND ooef019 = isai001
      AND ooef001 = g_isae_m.l_isaecomp
      AND isaient = g_enterprise
      
    
   IF l_isai002 = 2 THEN
      CALL cl_set_comp_visible("b_isae007", FALSE)
   ELSE
      CALL cl_set_comp_visible("b_isae008", FALSE)
   END IF
   
END FUNCTION

 
{</section>}
 
