#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq251.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-10-30 09:08:52), PR版次:0003(2016-01-06 11:30:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: adeq251
#+ Description: 門店收款周結查詢作業
#+ Creator....: 06541(2015-06-24 16:08:11)
#+ Modifier...: 06137 -SD/PR- 06815
 
{</section>}
 
{<section id="adeq251.global" >}
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
PRIVATE TYPE type_g_decv_d RECORD
       #statepic       LIKE type_t.chr1,
       
       decv019 LIKE decv_t.decv019, 
   decv020 LIKE decv_t.decv020, 
   decvsite LIKE decv_t.decvsite, 
   decvsite_desc LIKE type_t.chr500, 
   decv001 LIKE decv_t.decv001, 
   decv002 LIKE decv_t.decv002, 
   decv002_desc LIKE type_t.chr500, 
   decv004 LIKE decv_t.decv004, 
   decv005 LIKE decv_t.decv005, 
   decv006 LIKE decv_t.decv006, 
   decv007 LIKE decv_t.decv007, 
   decv008 LIKE decv_t.decv008, 
   decv008_desc LIKE type_t.chr500, 
   decv009 LIKE decv_t.decv009, 
   decv010 LIKE decv_t.decv010, 
   decv012 LIKE decv_t.decv012, 
   decv013 LIKE decv_t.decv013, 
   decv014 LIKE decv_t.decv014, 
   decv015 LIKE decv_t.decv015, 
   decv011 LIKE decv_t.decv011, 
   decv011_desc LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_decv_d
DEFINE g_master_t                   type_g_decv_d
DEFINE g_decv_d          DYNAMIC ARRAY OF type_g_decv_d
DEFINE g_decv_d_t        type_g_decv_d
 
      
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
 
{<section id="adeq251.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5  #150922-00001#3 20150924 S983961--ADD
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
   DECLARE adeq251_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq251_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq251_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq251 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq251_init()   
 
      #進入選單 Menu (="N")
      CALL adeq251_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq251
      
   END IF 
   
   CLOSE adeq251_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150922-00001#3 20150924 S983961--ADD
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq251.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq251_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5  #150922-00001#3 20150924 S983961--ADD
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_decv001','8310') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150922-00001#3 20150924 S983961--ADD
   #end add-point
 
   CALL adeq251_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq251.default_search" >}
PRIVATE FUNCTION adeq251_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " decvsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " decv002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " decv005 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " decv007 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " decv008 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " decv009 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " decv010 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " decv011 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " decv013 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " decv015 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET g_wc = g_wc, " decv019 = '", g_argv[11], "' AND "
   END IF
   IF NOT cl_null(g_argv[12]) THEN
      LET g_wc = g_wc, " decv020 = '", g_argv[12], "' AND "
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
 
{<section id="adeq251.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq251_ui_dialog()
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
      CALL adeq251_b_fill()
   ELSE
      CALL adeq251_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_decv_d.clear()
 
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
 
         CALL adeq251_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_decv_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq251_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq251_detail_action_trans()
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
            CALL adeq251_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq251_insert()
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
               CALL adeq251_query()
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
            CALL adeq251_filter()
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
            CALL adeq251_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_decv_d)
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
            CALL adeq251_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq251_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq251_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq251_b_fill()
 
         
         
 
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
 
{<section id="adeq251.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq251_query()
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
   CALL g_decv_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON decv019,decv020,decvsite,decv001,decv002,decv004,decv005,decv006,decv007, 
          decv008,decv009,decv010,decv012,decv013,decv014,decv015,decv011
           FROM s_detail1[1].b_decv019,s_detail1[1].b_decv020,s_detail1[1].b_decvsite,s_detail1[1].b_decv001, 
               s_detail1[1].b_decv002,s_detail1[1].b_decv004,s_detail1[1].b_decv005,s_detail1[1].b_decv006, 
               s_detail1[1].b_decv007,s_detail1[1].b_decv008,s_detail1[1].b_decv009,s_detail1[1].b_decv010, 
               s_detail1[1].b_decv012,s_detail1[1].b_decv013,s_detail1[1].b_decv014,s_detail1[1].b_decv015, 
               s_detail1[1].b_decv011
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO b_decvsite #150703-00010#4 Add By Ken 150706 預設查詢條件
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_decv019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv019
            #add-point:BEFORE FIELD b_decv019 name="construct.b.page1.b_decv019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv019
            
            #add-point:AFTER FIELD b_decv019 name="construct.a.page1.b_decv019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv019
            #add-point:ON ACTION controlp INFIELD b_decv019 name="construct.c.page1.b_decv019"
            
            #END add-point
 
 
         #----<<b_decv020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv020
            #add-point:BEFORE FIELD b_decv020 name="construct.b.page1.b_decv020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv020
            
            #add-point:AFTER FIELD b_decv020 name="construct.a.page1.b_decv020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv020
            #add-point:ON ACTION controlp INFIELD b_decv020 name="construct.c.page1.b_decv020"
            
            #END add-point
 
 
         #----<<b_decvsite>>----
         #Ctrlp:construct.c.page1.b_decvsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decvsite
            #add-point:ON ACTION controlp INFIELD b_decvsite name="construct.c.page1.b_decvsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = s_aooi500_q_where(g_prog,'decvsite',g_site,'c')            
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decvsite  #顯示到畫面上
            NEXT FIELD b_decvsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decvsite
            #add-point:BEFORE FIELD b_decvsite name="construct.b.page1.b_decvsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decvsite
            
            #add-point:AFTER FIELD b_decvsite name="construct.a.page1.b_decvsite"
            
            #END add-point
            
 
 
         #----<<b_decvsite_desc>>----
         #----<<b_decv001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv001
            #add-point:BEFORE FIELD b_decv001 name="construct.b.page1.b_decv001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv001
            
            #add-point:AFTER FIELD b_decv001 name="construct.a.page1.b_decv001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv001
            #add-point:ON ACTION controlp INFIELD b_decv001 name="construct.c.page1.b_decv001"
            
            #END add-point
 
 
         #----<<b_decv002>>----
         #Ctrlp:construct.c.page1.b_decv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv002
            #add-point:ON ACTION controlp INFIELD b_decv002 name="construct.c.page1.b_decv002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv002  #顯示到畫面上
            NEXT FIELD b_decv002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv002
            #add-point:BEFORE FIELD b_decv002 name="construct.b.page1.b_decv002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv002
            
            #add-point:AFTER FIELD b_decv002 name="construct.a.page1.b_decv002"
            
            #END add-point
            
 
 
         #----<<b_decv002_desc>>----
         #----<<b_decv004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv004
            #add-point:BEFORE FIELD b_decv004 name="construct.b.page1.b_decv004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv004
            
            #add-point:AFTER FIELD b_decv004 name="construct.a.page1.b_decv004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv004
            #add-point:ON ACTION controlp INFIELD b_decv004 name="construct.c.page1.b_decv004"
            
            #END add-point
 
 
         #----<<b_decv005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv005
            #add-point:BEFORE FIELD b_decv005 name="construct.b.page1.b_decv005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv005
            
            #add-point:AFTER FIELD b_decv005 name="construct.a.page1.b_decv005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv005
            #add-point:ON ACTION controlp INFIELD b_decv005 name="construct.c.page1.b_decv005"
            
            #END add-point
 
 
         #----<<b_decv006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv006
            #add-point:BEFORE FIELD b_decv006 name="construct.b.page1.b_decv006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv006
            
            #add-point:AFTER FIELD b_decv006 name="construct.a.page1.b_decv006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv006
            #add-point:ON ACTION controlp INFIELD b_decv006 name="construct.c.page1.b_decv006"
            
            #END add-point
 
 
         #----<<b_decv007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv007
            #add-point:BEFORE FIELD b_decv007 name="construct.b.page1.b_decv007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv007
            
            #add-point:AFTER FIELD b_decv007 name="construct.a.page1.b_decv007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv007
            #add-point:ON ACTION controlp INFIELD b_decv007 name="construct.c.page1.b_decv007"
            
            #END add-point
 
 
         #----<<b_decv008>>----
         #Ctrlp:construct.c.page1.b_decv008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv008
            #add-point:ON ACTION controlp INFIELD b_decv008 name="construct.c.page1.b_decv008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv008  #顯示到畫面上
            NEXT FIELD b_decv008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv008
            #add-point:BEFORE FIELD b_decv008 name="construct.b.page1.b_decv008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv008
            
            #add-point:AFTER FIELD b_decv008 name="construct.a.page1.b_decv008"
            
            #END add-point
            
 
 
         #----<<b_decv008_desc>>----
         #----<<b_decv009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv009
            #add-point:BEFORE FIELD b_decv009 name="construct.b.page1.b_decv009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv009
            
            #add-point:AFTER FIELD b_decv009 name="construct.a.page1.b_decv009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv009
            #add-point:ON ACTION controlp INFIELD b_decv009 name="construct.c.page1.b_decv009"
            
            #END add-point
 
 
         #----<<b_decv010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv010
            #add-point:BEFORE FIELD b_decv010 name="construct.b.page1.b_decv010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv010
            
            #add-point:AFTER FIELD b_decv010 name="construct.a.page1.b_decv010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv010
            #add-point:ON ACTION controlp INFIELD b_decv010 name="construct.c.page1.b_decv010"
            
            #END add-point
 
 
         #----<<b_decv012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv012
            #add-point:BEFORE FIELD b_decv012 name="construct.b.page1.b_decv012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv012
            
            #add-point:AFTER FIELD b_decv012 name="construct.a.page1.b_decv012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv012
            #add-point:ON ACTION controlp INFIELD b_decv012 name="construct.c.page1.b_decv012"
            
            #END add-point
 
 
         #----<<b_decv013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv013
            #add-point:BEFORE FIELD b_decv013 name="construct.b.page1.b_decv013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv013
            
            #add-point:AFTER FIELD b_decv013 name="construct.a.page1.b_decv013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv013
            #add-point:ON ACTION controlp INFIELD b_decv013 name="construct.c.page1.b_decv013"
            
            #END add-point
 
 
         #----<<b_decv014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv014
            #add-point:BEFORE FIELD b_decv014 name="construct.b.page1.b_decv014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv014
            
            #add-point:AFTER FIELD b_decv014 name="construct.a.page1.b_decv014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv014
            #add-point:ON ACTION controlp INFIELD b_decv014 name="construct.c.page1.b_decv014"
            
            #END add-point
 
 
         #----<<b_decv015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv015
            #add-point:BEFORE FIELD b_decv015 name="construct.b.page1.b_decv015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv015
            
            #add-point:AFTER FIELD b_decv015 name="construct.a.page1.b_decv015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decv015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv015
            #add-point:ON ACTION controlp INFIELD b_decv015 name="construct.c.page1.b_decv015"
            
            #END add-point
 
 
         #----<<b_decv011>>----
         #Ctrlp:construct.c.page1.b_decv011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv011
            #add-point:ON ACTION controlp INFIELD b_decv011 name="construct.c.page1.b_decv011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv011  #顯示到畫面上
            NEXT FIELD b_decv011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decv011
            #add-point:BEFORE FIELD b_decv011 name="construct.b.page1.b_decv011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decv011
            
            #add-point:AFTER FIELD b_decv011 name="construct.a.page1.b_decv011"
            
            #END add-point
            
 
 
         #----<<b_decv011_desc>>----
   
       
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
   CALL adeq251_b_fill()
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
 
{<section id="adeq251.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq251_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'decvsite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc CLIPPED," AND ",l_where
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE decv019,decv020,decvsite,'',decv001,decv002,'',decv004,decv005, 
       decv006,decv007,decv008,'',decv009,decv010,decv012,decv013,decv014,decv015,decv011,''  ,DENSE_RANK() OVER( ORDER BY decv_t.decvsite, 
       decv_t.decv002,decv_t.decv005,decv_t.decv007,decv_t.decv008,decv_t.decv009,decv_t.decv010,decv_t.decv011, 
       decv_t.decv013,decv_t.decv015,decv_t.decv019,decv_t.decv020) AS RANK FROM decv_t",
 
 
                     "",
                     " WHERE decvent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decv_t"),
                     " ORDER BY decv_t.decvsite,decv_t.decv002,decv_t.decv005,decv_t.decv007,decv_t.decv008,decv_t.decv009,decv_t.decv010,decv_t.decv011,decv_t.decv013,decv_t.decv015,decv_t.decv019,decv_t.decv020"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 20150911 s983961--add(s) 效能調整
   LET ls_sql_rank = "SELECT UNIQUE decv019,decv020,decvsite, ",
             "                      (SELECT ooefl003",
             "                         FROM ooefl_t",
             "                        WHERE ooeflent = decvent AND ooefl001 = decvsite AND ooefl002 = '",g_dlang,"') decvsite_desc, ",
             "                      decv001,decv002,",
             "                      (SELECT ooial003",
             "                         FROM ooial_t",
             "                        WHERE ooialent = decvent AND ooial001 = decv002 AND ooial002 = '",g_dlang,"') decv002_desc, ",
             "                      decv004,decv005,",
             "                      decv006,decv007,", 
             "                      decv008, ",
             "                      (SELECT nmabl003",
             "                         FROM nmabl_t",
             "                        WHERE nmablent = decvent AND nmabl001 = decv008 AND nmabl002 = '",g_dlang,"') decv008_desc, ",
             "                      decv009,decv010,decv012, ",
             "                      decv013,decv014,decv015, ",
             "                      decv011, ",
             "                      (CASE WHEN decv001 ='60' THEN (SELECT mmanl003 FROM mmanl_t ",
             "                                                                   WHERE mmanl002 = '",g_dlang,"' AND mmanlent = decvent AND mmanl001 = decv011) ",
             "                            WHEN decv001 ='40' THEN (SELECT gcafl003 FROM gcafl_t ",
             "                                                                   WHERE gcafl002 = '",g_dlang,"' AND gcaflent = decvent AND gcafl001 = decv011) END) decv011_desc, ",         
             " DENSE_RANK() OVER( ORDER BY decv_t.decvsite,decv_t.decv002,decv_t.decv005,decv_t.decv007, ",
             "                             decv_t.decv008,decv_t.decv009,decv_t.decv010,decv_t.decv011,  ",
             "                             decv_t.decv013,decv_t.decv015,decv_t.decv019,decv_t.decv020) AS RANK ",
             "          FROM  decv_t",
             "         WHERE decvent= ? AND 1=1 AND ", ls_wc
       
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decv_t"),
            " ORDER BY decv_t.decvsite,decv_t.decv002,decv_t.decv005,decv_t.decv007,decv_t.decv008,decv_t.decv009,decv_t.decv010,decv_t.decv011,decv_t.decv013,decv_t.decv015,decv_t.decv019,decv_t.decv020"
   #150826-00013#2 20150911 s983961--add(s) 效能調整
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
 
   LET g_sql = "SELECT decv019,decv020,decvsite,'',decv001,decv002,'',decv004,decv005,decv006,decv007, 
       decv008,'',decv009,decv010,decv012,decv013,decv014,decv015,decv011,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整
   #LET g_sql = "SELECT decv019,decv020,decvsite,ooefl_t.ooefl003,decv001,decv002,ooial_t.ooial003,
   #    decv004,decv005,decv006,decv007, 
   #    decv008,nmabl_t.nmabl003,decv009,decv010,decv012,decv013,decv014,decv015,decv011,mmanl_t.mmanl003",
   #    "          FROM  decv_t",
   #    "          LEFT JOIN ooefl_t ON ooefl_t.ooeflent=decv_t.decvent AND ooefl_t.ooefl001=decv_t.decvsite AND ooefl_t.ooefl002 = '",g_dlang,"' ",
   #    "          LEFT JOIN ooial_t ON ooial_t.ooialent=decv_t.decvent AND ooial_t.ooial001=decv_t.decv002  AND ooial_t.ooial002='",g_dlang,"' ",
   #    "          LEFT JOIN nmabl_t ON nmabl_t.nmablent=decv_t.decvent AND nmabl_t.nmabl001=decv_t.decv008  AND nmabl_t.nmabl002='",g_dlang,"' ",
   #    "          LEFT JOIN mmanl_t ON mmanl_t.mmanlent=decv_t.decvent AND mmanl_t.mmanl001=decv_t.decv011  AND mmanl_t.mmanl002='",g_dlang,"' ",
   #    "         WHERE decvent = ? ",
   #    "           AND ", ls_wc,cl_sql_add_filter("decv_t")  
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decv_t"),
   #                  " ORDER BY decv_t.decvsite,decv_t.decv002,decv_t.decv005,decv_t.decv011,decv_t.decv019,decv_t.decv020"
   LET g_sql = "SELECT decv019,decv020,decvsite,decvsite_desc,
                       decv001,decv002,decv002_desc,decv004,
                       decv005,decv006,decv007,decv008,decv008_desc,
                       decv009,decv010,decv012,decv013,decv014,decv015,decv011,decv011_desc",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page  
   #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq251_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq251_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_decv_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_decv_d[l_ac].decv019,g_decv_d[l_ac].decv020,g_decv_d[l_ac].decvsite,g_decv_d[l_ac].decvsite_desc, 
       g_decv_d[l_ac].decv001,g_decv_d[l_ac].decv002,g_decv_d[l_ac].decv002_desc,g_decv_d[l_ac].decv004, 
       g_decv_d[l_ac].decv005,g_decv_d[l_ac].decv006,g_decv_d[l_ac].decv007,g_decv_d[l_ac].decv008,g_decv_d[l_ac].decv008_desc, 
       g_decv_d[l_ac].decv009,g_decv_d[l_ac].decv010,g_decv_d[l_ac].decv012,g_decv_d[l_ac].decv013,g_decv_d[l_ac].decv014, 
       g_decv_d[l_ac].decv015,g_decv_d[l_ac].decv011,g_decv_d[l_ac].decv011_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_decv_d[l_ac].statepic = cl_get_actipic(g_decv_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq251_detail_show("'1'")      
 
      CALL adeq251_decv_t_mask()
 
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
   
 
   
   CALL g_decv_d.deleteElement(g_decv_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_decv_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq251_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq251_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq251_detail_action_trans()
 
   IF g_decv_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq251_fetch()
   END IF
   
      CALL adeq251_filter_show('decv019','b_decv019')
   CALL adeq251_filter_show('decv020','b_decv020')
   CALL adeq251_filter_show('decvsite','b_decvsite')
   CALL adeq251_filter_show('decv001','b_decv001')
   CALL adeq251_filter_show('decv002','b_decv002')
   CALL adeq251_filter_show('decv004','b_decv004')
   CALL adeq251_filter_show('decv005','b_decv005')
   CALL adeq251_filter_show('decv006','b_decv006')
   CALL adeq251_filter_show('decv007','b_decv007')
   CALL adeq251_filter_show('decv008','b_decv008')
   CALL adeq251_filter_show('decv009','b_decv009')
   CALL adeq251_filter_show('decv010','b_decv010')
   CALL adeq251_filter_show('decv012','b_decv012')
   CALL adeq251_filter_show('decv013','b_decv013')
   CALL adeq251_filter_show('decv014','b_decv014')
   CALL adeq251_filter_show('decv015','b_decv015')
   CALL adeq251_filter_show('decv011','b_decv011')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq251_fetch()
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
 
{<section id="adeq251.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq251_detail_show(ps_page)
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
#            LET g_ref_fields[1] = g_decv_d[l_ac].decvsite
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decv_d[l_ac].decvsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decv_d[l_ac].decvsite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decv_d[l_ac].decv002
#            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decv_d[l_ac].decv002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decv_d[l_ac].decv002_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decv_d[l_ac].decv008
#            LET ls_sql = "SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decv_d[l_ac].decv008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decv_d[l_ac].decv008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decv_d[l_ac].decv011
#            LET ls_sql = "SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decv_d[l_ac].decv011_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decv_d[l_ac].decv011_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq251_filter()
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
      CONSTRUCT g_wc_filter ON decv019,decv020,decvsite,decv001,decv002,decv004,decv005,decv006,decv007, 
          decv008,decv009,decv010,decv012,decv013,decv014,decv015,decv011
                          FROM s_detail1[1].b_decv019,s_detail1[1].b_decv020,s_detail1[1].b_decvsite, 
                              s_detail1[1].b_decv001,s_detail1[1].b_decv002,s_detail1[1].b_decv004,s_detail1[1].b_decv005, 
                              s_detail1[1].b_decv006,s_detail1[1].b_decv007,s_detail1[1].b_decv008,s_detail1[1].b_decv009, 
                              s_detail1[1].b_decv010,s_detail1[1].b_decv012,s_detail1[1].b_decv013,s_detail1[1].b_decv014, 
                              s_detail1[1].b_decv015,s_detail1[1].b_decv011
 
         BEFORE CONSTRUCT
                     DISPLAY adeq251_filter_parser('decv019') TO s_detail1[1].b_decv019
            DISPLAY adeq251_filter_parser('decv020') TO s_detail1[1].b_decv020
            DISPLAY adeq251_filter_parser('decvsite') TO s_detail1[1].b_decvsite
            DISPLAY adeq251_filter_parser('decv001') TO s_detail1[1].b_decv001
            DISPLAY adeq251_filter_parser('decv002') TO s_detail1[1].b_decv002
            DISPLAY adeq251_filter_parser('decv004') TO s_detail1[1].b_decv004
            DISPLAY adeq251_filter_parser('decv005') TO s_detail1[1].b_decv005
            DISPLAY adeq251_filter_parser('decv006') TO s_detail1[1].b_decv006
            DISPLAY adeq251_filter_parser('decv007') TO s_detail1[1].b_decv007
            DISPLAY adeq251_filter_parser('decv008') TO s_detail1[1].b_decv008
            DISPLAY adeq251_filter_parser('decv009') TO s_detail1[1].b_decv009
            DISPLAY adeq251_filter_parser('decv010') TO s_detail1[1].b_decv010
            DISPLAY adeq251_filter_parser('decv012') TO s_detail1[1].b_decv012
            DISPLAY adeq251_filter_parser('decv013') TO s_detail1[1].b_decv013
            DISPLAY adeq251_filter_parser('decv014') TO s_detail1[1].b_decv014
            DISPLAY adeq251_filter_parser('decv015') TO s_detail1[1].b_decv015
            DISPLAY adeq251_filter_parser('decv011') TO s_detail1[1].b_decv011
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_decv019>>----
         #Ctrlp:construct.c.filter.page1.b_decv019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv019
            #add-point:ON ACTION controlp INFIELD b_decv019 name="construct.c.filter.page1.b_decv019"
            
            #END add-point
 
 
         #----<<b_decv020>>----
         #Ctrlp:construct.c.filter.page1.b_decv020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv020
            #add-point:ON ACTION controlp INFIELD b_decv020 name="construct.c.filter.page1.b_decv020"
            
            #END add-point
 
 
         #----<<b_decvsite>>----
         #Ctrlp:construct.c.page1.b_decvsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decvsite
            #add-point:ON ACTION controlp INFIELD b_decvsite name="construct.c.filter.page1.b_decvsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decvsite',g_site,'c')
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decvsite  #顯示到畫面上
            NEXT FIELD b_decvsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decvsite_desc>>----
         #----<<b_decv001>>----
         #Ctrlp:construct.c.filter.page1.b_decv001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv001
            #add-point:ON ACTION controlp INFIELD b_decv001 name="construct.c.filter.page1.b_decv001"
            
            #END add-point
 
 
         #----<<b_decv002>>----
         #Ctrlp:construct.c.page1.b_decv002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv002
            #add-point:ON ACTION controlp INFIELD b_decv002 name="construct.c.filter.page1.b_decv002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv002  #顯示到畫面上
            NEXT FIELD b_decv002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decv002_desc>>----
         #----<<b_decv004>>----
         #Ctrlp:construct.c.filter.page1.b_decv004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv004
            #add-point:ON ACTION controlp INFIELD b_decv004 name="construct.c.filter.page1.b_decv004"
            
            #END add-point
 
 
         #----<<b_decv005>>----
         #Ctrlp:construct.c.filter.page1.b_decv005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv005
            #add-point:ON ACTION controlp INFIELD b_decv005 name="construct.c.filter.page1.b_decv005"
            
            #END add-point
 
 
         #----<<b_decv006>>----
         #Ctrlp:construct.c.filter.page1.b_decv006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv006
            #add-point:ON ACTION controlp INFIELD b_decv006 name="construct.c.filter.page1.b_decv006"
            
            #END add-point
 
 
         #----<<b_decv007>>----
         #Ctrlp:construct.c.filter.page1.b_decv007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv007
            #add-point:ON ACTION controlp INFIELD b_decv007 name="construct.c.filter.page1.b_decv007"
            
            #END add-point
 
 
         #----<<b_decv008>>----
         #Ctrlp:construct.c.page1.b_decv008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv008
            #add-point:ON ACTION controlp INFIELD b_decv008 name="construct.c.filter.page1.b_decv008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv008  #顯示到畫面上
            NEXT FIELD b_decv008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decv008_desc>>----
         #----<<b_decv009>>----
         #Ctrlp:construct.c.filter.page1.b_decv009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv009
            #add-point:ON ACTION controlp INFIELD b_decv009 name="construct.c.filter.page1.b_decv009"
            
            #END add-point
 
 
         #----<<b_decv010>>----
         #Ctrlp:construct.c.filter.page1.b_decv010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv010
            #add-point:ON ACTION controlp INFIELD b_decv010 name="construct.c.filter.page1.b_decv010"
            
            #END add-point
 
 
         #----<<b_decv012>>----
         #Ctrlp:construct.c.filter.page1.b_decv012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv012
            #add-point:ON ACTION controlp INFIELD b_decv012 name="construct.c.filter.page1.b_decv012"
            
            #END add-point
 
 
         #----<<b_decv013>>----
         #Ctrlp:construct.c.filter.page1.b_decv013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv013
            #add-point:ON ACTION controlp INFIELD b_decv013 name="construct.c.filter.page1.b_decv013"
            
            #END add-point
 
 
         #----<<b_decv014>>----
         #Ctrlp:construct.c.filter.page1.b_decv014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv014
            #add-point:ON ACTION controlp INFIELD b_decv014 name="construct.c.filter.page1.b_decv014"
            
            #END add-point
 
 
         #----<<b_decv015>>----
         #Ctrlp:construct.c.filter.page1.b_decv015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv015
            #add-point:ON ACTION controlp INFIELD b_decv015 name="construct.c.filter.page1.b_decv015"
            
            #END add-point
 
 
         #----<<b_decv011>>----
         #Ctrlp:construct.c.page1.b_decv011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decv011
            #add-point:ON ACTION controlp INFIELD b_decv011 name="construct.c.filter.page1.b_decv011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decv011  #顯示到畫面上
            NEXT FIELD b_decv011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decv011_desc>>----
   
 
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
   
      CALL adeq251_filter_show('decv019','b_decv019')
   CALL adeq251_filter_show('decv020','b_decv020')
   CALL adeq251_filter_show('decvsite','b_decvsite')
   CALL adeq251_filter_show('decv001','b_decv001')
   CALL adeq251_filter_show('decv002','b_decv002')
   CALL adeq251_filter_show('decv004','b_decv004')
   CALL adeq251_filter_show('decv005','b_decv005')
   CALL adeq251_filter_show('decv006','b_decv006')
   CALL adeq251_filter_show('decv007','b_decv007')
   CALL adeq251_filter_show('decv008','b_decv008')
   CALL adeq251_filter_show('decv009','b_decv009')
   CALL adeq251_filter_show('decv010','b_decv010')
   CALL adeq251_filter_show('decv012','b_decv012')
   CALL adeq251_filter_show('decv013','b_decv013')
   CALL adeq251_filter_show('decv014','b_decv014')
   CALL adeq251_filter_show('decv015','b_decv015')
   CALL adeq251_filter_show('decv011','b_decv011')
 
    
   CALL adeq251_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq251_filter_parser(ps_field)
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
 
{<section id="adeq251.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq251_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq251_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.insert" >}
#+ insert
PRIVATE FUNCTION adeq251_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq251.modify" >}
#+ modify
PRIVATE FUNCTION adeq251_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq251_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.delete" >}
#+ delete
PRIVATE FUNCTION adeq251_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq251.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq251_detail_action_trans()
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
 
{<section id="adeq251.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq251_detail_index_setting()
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
            IF g_decv_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_decv_d.getLength() AND g_decv_d.getLength() > 0
            LET g_detail_idx = g_decv_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_decv_d.getLength() THEN
               LET g_detail_idx = g_decv_d.getLength()
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
 
{<section id="adeq251.mask_functions" >}
 &include "erp/ade/adeq251_mask.4gl"
 
{</section>}
 
{<section id="adeq251.other_function" readonly="Y" >}

 
{</section>}
 
