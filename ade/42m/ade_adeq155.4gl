#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq155.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-12-02 16:55:23), PR版次:0004(2016-10-18 17:34:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: adeq155
#+ Description: 門店銷售專櫃周結查詢作業
#+ Creator....: 06131(2015-06-19 14:22:28)
#+ Modifier...: 06815 -SD/PR- 02159
 
{</section>}
 
{<section id="adeq155.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#4   2016/10/18 by sakura 整批修改組織
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
PRIVATE TYPE type_g_deck_d RECORD
       #statepic       LIKE type_t.chr1,
       
       decksite LIKE deck_t.decksite, 
   decksite_desc LIKE type_t.chr500, 
   deck001 LIKE deck_t.deck001, 
   deck027 LIKE deck_t.deck027, 
   deck028 LIKE deck_t.deck028, 
   deck005 LIKE deck_t.deck005, 
   deck005_desc LIKE type_t.chr500, 
   deck007 LIKE deck_t.deck007, 
   deck007_desc LIKE type_t.chr500, 
   deck008 LIKE deck_t.deck008, 
   deck008_desc LIKE type_t.chr500, 
   deck009 LIKE deck_t.deck009, 
   deck010 LIKE deck_t.deck010, 
   deck011 LIKE deck_t.deck011, 
   deck012 LIKE deck_t.deck012, 
   deck013 LIKE deck_t.deck013, 
   deck014 LIKE deck_t.deck014, 
   deck015 LIKE deck_t.deck015, 
   deck016 LIKE deck_t.deck016, 
   deck025 LIKE deck_t.deck025, 
   deck026 LIKE deck_t.deck026, 
   deck017 LIKE deck_t.deck017, 
   deck018 LIKE deck_t.deck018, 
   deck019 LIKE deck_t.deck019, 
   deck020 LIKE deck_t.deck020, 
   deck023 LIKE deck_t.deck023, 
   deck024 LIKE deck_t.deck024, 
   deck021 LIKE deck_t.deck021, 
   deck022 LIKE deck_t.deck022 
       END RECORD
PRIVATE TYPE type_g_deck2_d RECORD
       decl008 LIKE decl_t.decl008, 
   decl008_desc LIKE type_t.chr500, 
   decl009 LIKE decl_t.decl009, 
   decl009_desc LIKE type_t.chr500, 
   decl010 LIKE decl_t.decl010, 
   decl011 LIKE decl_t.decl011, 
   decl015 LIKE decl_t.decl015, 
   decl020 LIKE decl_t.decl020, 
   decl021 LIKE decl_t.decl021, 
   decl022 LIKE decl_t.decl022, 
   decl016 LIKE decl_t.decl016, 
   decl017 LIKE decl_t.decl017, 
   decl018 LIKE decl_t.decl018, 
   decl019 LIKE decl_t.decl019
       END RECORD
 
PRIVATE TYPE type_g_deck3_d RECORD
       decm010 LIKE decm_t.decm010, 
   decm009 LIKE decm_t.decm009, 
   decm009_desc LIKE type_t.chr500, 
   decm011 LIKE decm_t.decm011
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_deck4_d RECORD
       decm010_1 LIKE decm_t.decm010, 
   decm009_1 LIKE decm_t.decm009, 
   decm009_desc_1 LIKE type_t.chr500, 
   decm011_1 LIKE decm_t.decm011
       END RECORD
DEFINE g_deck4_d   DYNAMIC ARRAY OF type_g_deck4_d
DEFINE g_deck4_d_t type_g_deck4_d
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_deck_d
DEFINE g_master_t                   type_g_deck_d
DEFINE g_deck_d          DYNAMIC ARRAY OF type_g_deck_d
DEFINE g_deck_d_t        type_g_deck_d
DEFINE g_deck2_d   DYNAMIC ARRAY OF type_g_deck2_d
DEFINE g_deck2_d_t type_g_deck2_d
 
DEFINE g_deck3_d   DYNAMIC ARRAY OF type_g_deck3_d
DEFINE g_deck3_d_t type_g_deck3_d
 
 
      
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_wc2_filter_table2    STRING
DEFINE g_detail2_page_action2 STRING
 
DEFINE g_wc2_table3   STRING
DEFINE g_wc2_filter_table3    STRING
DEFINE g_detail2_page_action3 STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adeq155.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #151012-00012#4 20151022 add by beckxie
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
   DECLARE adeq155_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq155_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq155_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq155 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq155_init()   
 
      #進入選單 Menu (="N")
      CALL adeq155_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq155
      
   END IF 
   
   CLOSE adeq155_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #151012-00012#4 20151022 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq155.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq155_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #151012-00012#4 20151022 add by beckxie
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_deck001','6540') 
   CALL cl_set_combo_scc('b_decm010','8310') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #151012-00012#4 20151022 add by beckxie
   CALL cl_set_combo_scc('b_decm010_1','8310') 
   CALL g_deck4_d.clear()   #151012-00012#4 20151022 add by beckxie
   #end add-point
 
   CALL adeq155_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq155.default_search" >}
PRIVATE FUNCTION adeq155_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " decksite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " deck005 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " deck007 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " deck008 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " deck027 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " deck028 = '", g_argv[06], "' AND "
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
 
{<section id="adeq155.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq155_ui_dialog()
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
      CALL adeq155_b_fill()
   ELSE
      CALL adeq155_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deck_d.clear()
         CALL g_deck2_d.clear()
 
         CALL g_deck3_d.clear()
 
 
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
 
         CALL adeq155_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_deck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq155_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq155_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_deck2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_deck2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_deck3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_deck3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_deck4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 4
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_deck4_d.getLength() TO FORMONLY.cnt
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq155_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq155_insert()
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
               CALL adeq155_query()
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
            CALL adeq155_filter()
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
            CALL adeq155_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_deck_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_deck2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_deck3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL adeq155_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq155_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq155_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq155_b_fill()
 
         
         
 
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
 
{<section id="adeq155.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq155_query()
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
   CALL g_deck_d.clear()
   CALL g_deck2_d.clear()
 
   CALL g_deck3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON decksite,deck001,deck027,deck028,deck005,deck007,deck008,deck009,deck010, 
          deck011,deck012,deck013,deck014,deck015,deck016,deck025,deck026,deck017,deck018,deck019,deck020, 
          deck023,deck024,deck021,deck022
           FROM s_detail1[1].b_decksite,s_detail1[1].b_deck001,s_detail1[1].b_deck027,s_detail1[1].b_deck028, 
               s_detail1[1].b_deck005,s_detail1[1].b_deck007,s_detail1[1].b_deck008,s_detail1[1].b_deck009, 
               s_detail1[1].b_deck010,s_detail1[1].b_deck011,s_detail1[1].b_deck012,s_detail1[1].b_deck013, 
               s_detail1[1].b_deck014,s_detail1[1].b_deck015,s_detail1[1].b_deck016,s_detail1[1].b_deck025, 
               s_detail1[1].b_deck026,s_detail1[1].b_deck017,s_detail1[1].b_deck018,s_detail1[1].b_deck019, 
               s_detail1[1].b_deck020,s_detail1[1].b_deck023,s_detail1[1].b_deck024,s_detail1[1].b_deck021, 
               s_detail1[1].b_deck022
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO s_detail1[1].b_decksite   #151012-00012#4 20151022 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_decksite>>----
         #Ctrlp:construct.c.page1.b_decksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decksite
            #add-point:ON ACTION controlp INFIELD b_decksite name="construct.c.page1.b_decksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decksite',g_site,'c') 
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_decksite  #顯示到畫面上
            NEXT FIELD b_decksite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decksite
            #add-point:BEFORE FIELD b_decksite name="construct.b.page1.b_decksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decksite
            
            #add-point:AFTER FIELD b_decksite name="construct.a.page1.b_decksite"
            
            #END add-point
            
 
 
         #----<<b_decksite_desc>>----
         #----<<b_deck001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck001
            #add-point:BEFORE FIELD b_deck001 name="construct.b.page1.b_deck001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck001
            
            #add-point:AFTER FIELD b_deck001 name="construct.a.page1.b_deck001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck001
            #add-point:ON ACTION controlp INFIELD b_deck001 name="construct.c.page1.b_deck001"
            
            #END add-point
 
 
         #----<<b_deck027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck027
            #add-point:BEFORE FIELD b_deck027 name="construct.b.page1.b_deck027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck027
            
            #add-point:AFTER FIELD b_deck027 name="construct.a.page1.b_deck027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck027
            #add-point:ON ACTION controlp INFIELD b_deck027 name="construct.c.page1.b_deck027"
            
            #END add-point
 
 
         #----<<b_deck028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck028
            #add-point:BEFORE FIELD b_deck028 name="construct.b.page1.b_deck028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck028
            
            #add-point:AFTER FIELD b_deck028 name="construct.a.page1.b_deck028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck028
            #add-point:ON ACTION controlp INFIELD b_deck028 name="construct.c.page1.b_deck028"
            
            #END add-point
 
 
         #----<<b_deck005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck005
            #add-point:BEFORE FIELD b_deck005 name="construct.b.page1.b_deck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck005
            
            #add-point:AFTER FIELD b_deck005 name="construct.a.page1.b_deck005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck005
            #add-point:ON ACTION controlp INFIELD b_deck005 name="construct.c.page1.b_deck005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck005  #顯示到畫面上
            NEXT FIELD b_deck005                     #返回原欄位
            #END add-point
 
 
         #----<<b_deck005_desc>>----
         #----<<b_deck007>>----
         #Ctrlp:construct.c.page1.b_deck007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck007
            #add-point:ON ACTION controlp INFIELD b_deck007 name="construct.c.page1.b_deck007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck007  #顯示到畫面上
            NEXT FIELD b_deck007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck007
            #add-point:BEFORE FIELD b_deck007 name="construct.b.page1.b_deck007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck007
            
            #add-point:AFTER FIELD b_deck007 name="construct.a.page1.b_deck007"
            
            #END add-point
            
 
 
         #----<<b_deck007_desc>>----
         #----<<b_deck008>>----
         #Ctrlp:construct.c.page1.b_deck008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck008
            #add-point:ON ACTION controlp INFIELD b_deck008 name="construct.c.page1.b_deck008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck008  #顯示到畫面上
            NEXT FIELD b_deck008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck008
            #add-point:BEFORE FIELD b_deck008 name="construct.b.page1.b_deck008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck008
            
            #add-point:AFTER FIELD b_deck008 name="construct.a.page1.b_deck008"
            
            #END add-point
            
 
 
         #----<<b_deck008_desc>>----
         #----<<b_deck009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck009
            #add-point:BEFORE FIELD b_deck009 name="construct.b.page1.b_deck009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck009
            
            #add-point:AFTER FIELD b_deck009 name="construct.a.page1.b_deck009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck009
            #add-point:ON ACTION controlp INFIELD b_deck009 name="construct.c.page1.b_deck009"
            
            #END add-point
 
 
         #----<<b_deck010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck010
            #add-point:BEFORE FIELD b_deck010 name="construct.b.page1.b_deck010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck010
            
            #add-point:AFTER FIELD b_deck010 name="construct.a.page1.b_deck010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck010
            #add-point:ON ACTION controlp INFIELD b_deck010 name="construct.c.page1.b_deck010"
            
            #END add-point
 
 
         #----<<b_deck011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck011
            #add-point:BEFORE FIELD b_deck011 name="construct.b.page1.b_deck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck011
            
            #add-point:AFTER FIELD b_deck011 name="construct.a.page1.b_deck011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck011
            #add-point:ON ACTION controlp INFIELD b_deck011 name="construct.c.page1.b_deck011"
            
            #END add-point
 
 
         #----<<b_deck012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck012
            #add-point:BEFORE FIELD b_deck012 name="construct.b.page1.b_deck012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck012
            
            #add-point:AFTER FIELD b_deck012 name="construct.a.page1.b_deck012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck012
            #add-point:ON ACTION controlp INFIELD b_deck012 name="construct.c.page1.b_deck012"
            
            #END add-point
 
 
         #----<<b_deck013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck013
            #add-point:BEFORE FIELD b_deck013 name="construct.b.page1.b_deck013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck013
            
            #add-point:AFTER FIELD b_deck013 name="construct.a.page1.b_deck013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck013
            #add-point:ON ACTION controlp INFIELD b_deck013 name="construct.c.page1.b_deck013"
            
            #END add-point
 
 
         #----<<b_deck014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck014
            #add-point:BEFORE FIELD b_deck014 name="construct.b.page1.b_deck014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck014
            
            #add-point:AFTER FIELD b_deck014 name="construct.a.page1.b_deck014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck014
            #add-point:ON ACTION controlp INFIELD b_deck014 name="construct.c.page1.b_deck014"
            
            #END add-point
 
 
         #----<<b_deck015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck015
            #add-point:BEFORE FIELD b_deck015 name="construct.b.page1.b_deck015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck015
            
            #add-point:AFTER FIELD b_deck015 name="construct.a.page1.b_deck015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck015
            #add-point:ON ACTION controlp INFIELD b_deck015 name="construct.c.page1.b_deck015"
            
            #END add-point
 
 
         #----<<b_deck016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck016
            #add-point:BEFORE FIELD b_deck016 name="construct.b.page1.b_deck016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck016
            
            #add-point:AFTER FIELD b_deck016 name="construct.a.page1.b_deck016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck016
            #add-point:ON ACTION controlp INFIELD b_deck016 name="construct.c.page1.b_deck016"
            
            #END add-point
 
 
         #----<<b_deck025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck025
            #add-point:BEFORE FIELD b_deck025 name="construct.b.page1.b_deck025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck025
            
            #add-point:AFTER FIELD b_deck025 name="construct.a.page1.b_deck025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck025
            #add-point:ON ACTION controlp INFIELD b_deck025 name="construct.c.page1.b_deck025"
            
            #END add-point
 
 
         #----<<b_deck026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck026
            #add-point:BEFORE FIELD b_deck026 name="construct.b.page1.b_deck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck026
            
            #add-point:AFTER FIELD b_deck026 name="construct.a.page1.b_deck026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck026
            #add-point:ON ACTION controlp INFIELD b_deck026 name="construct.c.page1.b_deck026"
            
            #END add-point
 
 
         #----<<b_deck017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck017
            #add-point:BEFORE FIELD b_deck017 name="construct.b.page1.b_deck017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck017
            
            #add-point:AFTER FIELD b_deck017 name="construct.a.page1.b_deck017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck017
            #add-point:ON ACTION controlp INFIELD b_deck017 name="construct.c.page1.b_deck017"
            
            #END add-point
 
 
         #----<<b_deck018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck018
            #add-point:BEFORE FIELD b_deck018 name="construct.b.page1.b_deck018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck018
            
            #add-point:AFTER FIELD b_deck018 name="construct.a.page1.b_deck018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck018
            #add-point:ON ACTION controlp INFIELD b_deck018 name="construct.c.page1.b_deck018"
            
            #END add-point
 
 
         #----<<b_deck019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck019
            #add-point:BEFORE FIELD b_deck019 name="construct.b.page1.b_deck019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck019
            
            #add-point:AFTER FIELD b_deck019 name="construct.a.page1.b_deck019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck019
            #add-point:ON ACTION controlp INFIELD b_deck019 name="construct.c.page1.b_deck019"
            
            #END add-point
 
 
         #----<<b_deck020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck020
            #add-point:BEFORE FIELD b_deck020 name="construct.b.page1.b_deck020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck020
            
            #add-point:AFTER FIELD b_deck020 name="construct.a.page1.b_deck020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck020
            #add-point:ON ACTION controlp INFIELD b_deck020 name="construct.c.page1.b_deck020"
            
            #END add-point
 
 
         #----<<b_deck023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck023
            #add-point:BEFORE FIELD b_deck023 name="construct.b.page1.b_deck023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck023
            
            #add-point:AFTER FIELD b_deck023 name="construct.a.page1.b_deck023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck023
            #add-point:ON ACTION controlp INFIELD b_deck023 name="construct.c.page1.b_deck023"
            
            #END add-point
 
 
         #----<<b_deck024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck024
            #add-point:BEFORE FIELD b_deck024 name="construct.b.page1.b_deck024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck024
            
            #add-point:AFTER FIELD b_deck024 name="construct.a.page1.b_deck024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck024
            #add-point:ON ACTION controlp INFIELD b_deck024 name="construct.c.page1.b_deck024"
            
            #END add-point
 
 
         #----<<b_deck021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck021
            #add-point:BEFORE FIELD b_deck021 name="construct.b.page1.b_deck021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck021
            
            #add-point:AFTER FIELD b_deck021 name="construct.a.page1.b_deck021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck021
            #add-point:ON ACTION controlp INFIELD b_deck021 name="construct.c.page1.b_deck021"
            
            #END add-point
 
 
         #----<<b_deck022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deck022
            #add-point:BEFORE FIELD b_deck022 name="construct.b.page1.b_deck022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deck022
            
            #add-point:AFTER FIELD b_deck022 name="construct.a.page1.b_deck022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deck022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck022
            #add-point:ON ACTION controlp INFIELD b_deck022 name="construct.c.page1.b_deck022"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON decl008,decl009,decl010,decl011,decl015,decl020,decl021,decl022,decl016, 
          decl017,decl018,decl019
           FROM s_detail2[1].b_decl008,s_detail2[1].b_decl009,s_detail2[1].b_decl010,s_detail2[1].b_decl011, 
               s_detail2[1].b_decl015,s_detail2[1].b_decl020,s_detail2[1].b_decl021,s_detail2[1].b_decl022, 
               s_detail2[1].b_decl016,s_detail2[1].b_decl017,s_detail2[1].b_decl018,s_detail2[1].b_decl019 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            DISPLAY '' TO s_detail2[1].b_decl008   #151012-00012#4 20151022 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_decl008>>----
         #Ctrlp:construct.c.page2.b_decl008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl008
            #add-point:ON ACTION controlp INFIELD b_decl008 name="construct.c.page2.b_decl008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decl008  #顯示到畫面上
            NEXT FIELD b_decl008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl008
            #add-point:BEFORE FIELD b_decl008 name="construct.b.page2.b_decl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl008
            
            #add-point:AFTER FIELD b_decl008 name="construct.a.page2.b_decl008"
            
            #END add-point
            
 
 
         #----<<b_decl008_desc>>----
         #----<<b_decl009>>----
         #Ctrlp:construct.c.page2.b_decl009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl009
            #add-point:ON ACTION controlp INFIELD b_decl009 name="construct.c.page2.b_decl009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2024'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decl009  #顯示到畫面上
            NEXT FIELD b_decl009                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl009
            #add-point:BEFORE FIELD b_decl009 name="construct.b.page2.b_decl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl009
            
            #add-point:AFTER FIELD b_decl009 name="construct.a.page2.b_decl009"
            
            #END add-point
            
 
 
         #----<<b_decl009_desc>>----
         #----<<b_decl010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl010
            #add-point:BEFORE FIELD b_decl010 name="construct.b.page2.b_decl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl010
            
            #add-point:AFTER FIELD b_decl010 name="construct.a.page2.b_decl010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl010
            #add-point:ON ACTION controlp INFIELD b_decl010 name="construct.c.page2.b_decl010"
            
            #END add-point
 
 
         #----<<b_decl011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl011
            #add-point:BEFORE FIELD b_decl011 name="construct.b.page2.b_decl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl011
            
            #add-point:AFTER FIELD b_decl011 name="construct.a.page2.b_decl011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl011
            #add-point:ON ACTION controlp INFIELD b_decl011 name="construct.c.page2.b_decl011"
            
            #END add-point
 
 
         #----<<b_decl015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl015
            #add-point:BEFORE FIELD b_decl015 name="construct.b.page2.b_decl015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl015
            
            #add-point:AFTER FIELD b_decl015 name="construct.a.page2.b_decl015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl015
            #add-point:ON ACTION controlp INFIELD b_decl015 name="construct.c.page2.b_decl015"
            
            #END add-point
 
 
         #----<<b_decl020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl020
            #add-point:BEFORE FIELD b_decl020 name="construct.b.page2.b_decl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl020
            
            #add-point:AFTER FIELD b_decl020 name="construct.a.page2.b_decl020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl020
            #add-point:ON ACTION controlp INFIELD b_decl020 name="construct.c.page2.b_decl020"
            
            #END add-point
 
 
         #----<<b_decl021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl021
            #add-point:BEFORE FIELD b_decl021 name="construct.b.page2.b_decl021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl021
            
            #add-point:AFTER FIELD b_decl021 name="construct.a.page2.b_decl021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl021
            #add-point:ON ACTION controlp INFIELD b_decl021 name="construct.c.page2.b_decl021"
            
            #END add-point
 
 
         #----<<b_decl022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl022
            #add-point:BEFORE FIELD b_decl022 name="construct.b.page2.b_decl022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl022
            
            #add-point:AFTER FIELD b_decl022 name="construct.a.page2.b_decl022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl022
            #add-point:ON ACTION controlp INFIELD b_decl022 name="construct.c.page2.b_decl022"
            
            #END add-point
 
 
         #----<<b_decl016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl016
            #add-point:BEFORE FIELD b_decl016 name="construct.b.page2.b_decl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl016
            
            #add-point:AFTER FIELD b_decl016 name="construct.a.page2.b_decl016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl016
            #add-point:ON ACTION controlp INFIELD b_decl016 name="construct.c.page2.b_decl016"
            
            #END add-point
 
 
         #----<<b_decl017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl017
            #add-point:BEFORE FIELD b_decl017 name="construct.b.page2.b_decl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl017
            
            #add-point:AFTER FIELD b_decl017 name="construct.a.page2.b_decl017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl017
            #add-point:ON ACTION controlp INFIELD b_decl017 name="construct.c.page2.b_decl017"
            
            #END add-point
 
 
         #----<<b_decl018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl018
            #add-point:BEFORE FIELD b_decl018 name="construct.b.page2.b_decl018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl018
            
            #add-point:AFTER FIELD b_decl018 name="construct.a.page2.b_decl018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl018
            #add-point:ON ACTION controlp INFIELD b_decl018 name="construct.c.page2.b_decl018"
            
            #END add-point
 
 
         #----<<b_decl019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decl019
            #add-point:BEFORE FIELD b_decl019 name="construct.b.page2.b_decl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decl019
            
            #add-point:AFTER FIELD b_decl019 name="construct.a.page2.b_decl019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_decl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decl019
            #add-point:ON ACTION controlp INFIELD b_decl019 name="construct.c.page2.b_decl019"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON decm010,decm009,decm011
           FROM s_detail3[1].b_decm010,s_detail3[1].b_decm009,s_detail3[1].b_decm011
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body3.before_construct"
            DISPLAY '' TO s_detail3[1].b_decm010   #151012-00012#4 20151022 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_decm010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decm010
            #add-point:BEFORE FIELD b_decm010 name="construct.b.page3.b_decm010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decm010
            
            #add-point:AFTER FIELD b_decm010 name="construct.a.page3.b_decm010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decm010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decm010
            #add-point:ON ACTION controlp INFIELD b_decm010 name="construct.c.page3.b_decm010"
            
            #END add-point
 
 
         #----<<b_decm009>>----
         #Ctrlp:construct.c.page3.b_decm009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decm009
            #add-point:ON ACTION controlp INFIELD b_decm009 name="construct.c.page3.b_decm009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decm009  #顯示到畫面上
            NEXT FIELD b_decm009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decm009
            #add-point:BEFORE FIELD b_decm009 name="construct.b.page3.b_decm009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decm009
            
            #add-point:AFTER FIELD b_decm009 name="construct.a.page3.b_decm009"
            
            #END add-point
            
 
 
         #----<<b_decm009_desc>>----
         #----<<b_decm011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decm011
            #add-point:BEFORE FIELD b_decm011 name="construct.b.page3.b_decm011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decm011
            
            #add-point:AFTER FIELD b_decm011 name="construct.a.page3.b_decm011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decm011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decm011
            #add-point:ON ACTION controlp INFIELD b_decm011 name="construct.c.page3.b_decm011"
            
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
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2_table2
   END IF
 
   IF NOT cl_null(g_wc2_table3) AND g_wc2_table3 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2_table3
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
   CALL adeq155_b_fill()
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
 
{<section id="adeq155.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq155_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'decksite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE decksite,'',deck001,deck027,deck028,deck005,'',deck007,'',deck008, 
       '',deck009,deck010,deck011,deck012,deck013,deck014,deck015,deck016,deck025,deck026,deck017,deck018, 
       deck019,deck020,deck023,deck024,deck021,deck022  ,DENSE_RANK() OVER( ORDER BY deck_t.decksite, 
       deck_t.deck005,deck_t.deck007,deck_t.deck008,deck_t.deck027,deck_t.deck028) AS RANK FROM deck_t", 
 
 
                     " LEFT JOIN decl_t ON declent = deckent AND decksite = declsite AND deck005 = decl005 AND deck007 = decl006 AND deck008 = decl007 AND deck027 = decl023 AND deck028 = decl024",
 
                     " LEFT JOIN decm_t ON decment = deckent AND decksite = decmsite AND deck005 = decm005 AND deck007 = decm007 AND deck008 = decm008 AND deck027 = decm012 AND deck028 = decm013",
 
 
                     "",
                     " WHERE deckent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deck_t"),
                     " ORDER BY deck_t.decksite,deck_t.deck005,deck_t.deck007,deck_t.deck008,deck_t.deck027,deck_t.deck028"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 20150911 s983961--add(s) 效能調整 
   LET ls_sql_rank = "SELECT UNIQUE decksite, ",
            "                (SELECT ooefl003 FROM ooefl_t ",
            "                  WHERE ooeflent = deckent ",
            "                    AND ooefl001 = decksite ",
            "                    AND ooefl002 ='"||g_dlang||"') decksite_desc, ",
            "                deck001,deck027,deck028,deck005, ",
            "                (SELECT mhael023 FROM mhael_t ",
            "                  WHERE mhaelent = deckent ",
            "                    AND mhaelsite = decksite ",
            "                    AND mhael001 = deck005 ",
            "                    AND mhael022 ='"||g_dlang||"') deck005_desc, ",
            "                deck007, ",
            "                (SELECT rtaxl003 FROM rtaxl_t ",
            "                  WHERE rtaxlent = deckent ",
            "                    AND rtaxl001 = deck007 ",
            "                    AND rtaxl002 ='"||g_dlang||"') deck007_desc, ",
            "                deck008, ",
            "                (SELECT oodbl004 FROM oodbl_t ",
            "                  WHERE oodblent = deckent ",
            "                    AND oodbl002 = deck008 ",
            "                    AND oodbl001 = ooef019 ",
            "                    AND oodbl003 ='"||g_dlang||"') deck008_desc, ",
            "                deck009,deck010,deck011,deck012,deck013,deck014,deck015,deck016,deck025, ",
            "                deck026,deck017,deck018,deck019,deck020,deck023,deck024,deck021,deck022,",
            " DENSE_RANK() OVER( ORDER BY deck_t.decksite,deck_t.deck005,deck_t.deck007,deck_t.deck008,deck_t.deck027,deck_t.deck028) AS RANK ",
            "           FROM deck_t ",  
            #20151026 s983961--add(s) ooef改為inner join/left join第二第三單身 QBE查詢才能串的到條件       
            "      INNER JOIN ooef_t  ON ooefent = deckent AND ooef001 = decksite ",     
            "       LEFT JOIN decl_t ON declent = deckent AND decksite = declsite AND deck005 = decl005 AND deck007 = decl006 AND deck008 = decl007 AND deck027 = decl023 AND deck028 = decl024",
            "       LEFT JOIN decm_t ON decment = deckent AND decksite = decmsite AND deck005 = decm005 AND deck007 = decm007 AND deck008 = decm008 AND deck027 = decm012 AND deck028 = decm013",
            #20151026 s983961--add(e) ooef改為inner join/left join第二第三單身 QBE查詢才能串的到條件                  
            " WHERE deckent = ? ",
            "   AND ", ls_wc
            
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deck_t"),
                     " ORDER BY deck_t.decksite,deck_t.deck005,deck_t.deck007,deck_t.deck008,deck_t.deck027,deck_t.deck028"  
   #150826-00013#2 20150911 s983961--add(e) 效能調整                      
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
 
   LET g_sql = "SELECT decksite,'',deck001,deck027,deck028,deck005,'',deck007,'',deck008,'',deck009, 
       deck010,deck011,deck012,deck013,deck014,deck015,deck016,deck025,deck026,deck017,deck018,deck019, 
       deck020,deck023,deck024,deck021,deck022",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整
   #LET g_sql = "SELECT decksite,t1.ooefl003,deck001,deck027,deck028,deck005,t3.ooeal003,deck007,t4.rtaxl003,deck008,t6.oodbl004,deck009, 
   #   deck010,deck011,deck012,deck013,deck014,deck015,deck016,deck025,deck026,deck017,deck018,deck019, 
   #   deck020,deck023,deck024,deck021,deck022",
   #           " FROM deck_t ",
   #        "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = deckent AND t1.ooefl001 = decksite AND t1.ooefl002 = '",g_dlang,"' ",
   # 
   #        "       LEFT JOIN inaa_t  t2 ON t2.inaaent = deckent AND t2.inaasite = decksite ",   
   #        "       LEFT JOIN ooeal_t t3 ON t3.ooealent=t2.inaaent  AND  t3.ooeal001= t2.inaa120 AND t3.ooeal002 = '",g_dlang,"' ",      
   #
   #        "       LEFT JOIN rtaxl_t t4 ON t4.rtaxlent = deckent AND t4.rtaxl001 = deck007 AND t4.rtaxl002 = '",g_dlang,"' ",
   #  
   #        "       LEFT JOIN ooef_t t5 ON t5.ooefent = deckent AND t5.ooef001 = decksite ",
   #        "       LEFT JOIN oodbl_t t6 ON t6.oodblent = deckent AND t6.oodbl002 = deck008 AND t6.oodbl001 =t5.ooef019 AND t6.oodbl003 = '",g_dlang,"' ",
   # 
   #        " WHERE deckent = ? ",
   #        "   AND ", ls_wc,cl_sql_add_filter("deck_t")
   #   
   #LET g_sql = g_sql, cl_sql_add_filter("deck_t"),
   #               " ORDER BY deck_t.decksite,deck_t.deck005,deck_t.deck007,deck_t.deck008,deck_t.deck027,deck_t.deck028 "   
   
   LET g_sql = "SELECT decksite,decksite_desc,deck001,deck027,deck028,deck005,deck005_desc,
       deck007,deck007_desc,deck008,deck008_desc,
       deck009,deck010,deck011,deck012,deck013,deck014,
       deck015,deck016,deck025,deck026,deck017,deck018,
       deck019, deck020,deck023,deck024,deck021,deck022",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq155_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq155_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_deck_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_deck_d[l_ac].decksite,g_deck_d[l_ac].decksite_desc,g_deck_d[l_ac].deck001, 
       g_deck_d[l_ac].deck027,g_deck_d[l_ac].deck028,g_deck_d[l_ac].deck005,g_deck_d[l_ac].deck005_desc, 
       g_deck_d[l_ac].deck007,g_deck_d[l_ac].deck007_desc,g_deck_d[l_ac].deck008,g_deck_d[l_ac].deck008_desc, 
       g_deck_d[l_ac].deck009,g_deck_d[l_ac].deck010,g_deck_d[l_ac].deck011,g_deck_d[l_ac].deck012,g_deck_d[l_ac].deck013, 
       g_deck_d[l_ac].deck014,g_deck_d[l_ac].deck015,g_deck_d[l_ac].deck016,g_deck_d[l_ac].deck025,g_deck_d[l_ac].deck026, 
       g_deck_d[l_ac].deck017,g_deck_d[l_ac].deck018,g_deck_d[l_ac].deck019,g_deck_d[l_ac].deck020,g_deck_d[l_ac].deck023, 
       g_deck_d[l_ac].deck024,g_deck_d[l_ac].deck021,g_deck_d[l_ac].deck022
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_deck_d[l_ac].statepic = cl_get_actipic(g_deck_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #150826-00013#2 20150916 s983961--mark and mod(s) 效能調整 
      #LET g_sql = " SELECT decm010,decm009,ooial003,SUM(decm011) ",
      #            "   FROM (SELECT UNIQUE deckent,decksite,deck005,deck007,deck008, ",
      #            "                       deck027,deck028,decm010,decm009,decm011,t1.ooial003 ",
      #            "           FROM deck_t ",
      #            "                LEFT JOIN decl_t ON declent = deckent AND declsite = decksite ",
      #            "                                AND decl005 = deck005 AND decl006  = deck007 ",
      #            "                                AND decl007 = deck008 AND decl023  = deck027 ",
      #            "                                AND decl024 = deck028 ",
      #            "                LEFT JOIN decm_t ON decment = deckent AND decmsite = decksite ",
      #            "                                AND decm005 = deck005 AND decm007  = deck007 ",
      #            "                                AND decm008 = deck008 AND decm012  = deck027 ",
      #            "                                AND decm013 = deck028 ",
      #            "                LEFT JOIN ooial_t t1 ON t1.ooialent = decment AND t1.ooial001 = decm009 ",
      #            "                                    AND t1.ooial002 = '",g_dlang,"' ",
      #            "          WHERE deckent= ? AND decm009 IS NOT NULL AND ", ls_wc,") ",
      #            " GROUP BY decm010,decm009,ooial003 ",
      #            " ORDER BY decm010,decm009 "
      
      #151012-00012#4 20151022 mark by beckxie---S            
      #LET g_sql = " SELECT decm010,decm009, ",
      #            "        (SELECT ooial003 ",
      #            "           FROM ooial_t  ",
      #            "          WHERE ooialent = deckent AND ooial001 = decm009 AND ooial002 = '",g_dlang,"') ooial003, ",  
      #            "        decm011 ",
      #            "   FROM (SELECT UNIQUE deckent,decksite,deck005,deck007,deck008, ",
      #            "                       deck027,deck028,decm010,decm009,SUM(decm011) decm011",                
      #            "           FROM deck_t ",
      #            "                LEFT JOIN decl_t ON declent = deckent AND declsite = decksite ",
      #            "                                AND decl005 = deck005 AND decl006  = deck007 ",
      #            "                                AND decl007 = deck008 AND decl023  = deck027 ",
      #            "                                AND decl024 = deck028 ",
      #            "                LEFT JOIN decm_t ON decment = deckent AND decmsite = decksite ",
      #            "                                AND decm005 = deck005 AND decm007  = deck007 ",
      #            "                                AND decm008 = deck008 AND decm012  = deck027 ",
      #            "                                AND decm013 = deck028 ",
      #            "          WHERE deckent= ? AND decm009 IS NOT NULL AND ", ls_wc," ",                  
      #            " GROUP BY deckent,decksite,deck005,deck007,deck008,deck027,deck028,decm010,decm009) ",
      #            " ORDER BY decm010,decm009 "
      #PREPARE adeq155_pb1 FROM g_sql
      #DECLARE b_fill_curs1 CURSOR FOR adeq155_pb1
      #151012-00012#4 20151022 mark by beckxie---E
      #150826-00013#2 20150916 s983961--mark and mod(e) 效能調整   
      
      
      #end add-point
 
      CALL adeq155_detail_show("'1'")      
 
      CALL adeq155_deck_t_mask()
 
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
   
 
   
   CALL g_deck_d.deleteElement(g_deck_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #151012-00012#4 20151022 add by beckxie---S
   LET g_sql = "SELECT decm010,decm009,ooial003,SUM(decm011)",
            "  FROM ",
            "      (SELECT decm010,decm009, ",
            "             (SELECT ooial003 ",
            "                FROM ooial_t  ",
            "               WHERE ooialent = deckent AND ooial001 = decm009 AND ooial002 = '",g_dlang,"') ooial003, ",  
            "             decm011 ",
            "        FROM (SELECT UNIQUE deckent,decksite,deck005,deck007,deck008, ",
            "                            deck027,deck028,decm010,decm009,SUM(decm011) decm011",                
            "                FROM deck_t ",
            "                     LEFT JOIN decl_t ON declent = deckent AND declsite = decksite ",
            "                                     AND decl005 = deck005 AND decl006  = deck007 ",
            "                                     AND decl007 = deck008 AND decl023  = deck027 ",
            "                                     AND decl024 = deck028 ",
            "                     LEFT JOIN decm_t ON decment = deckent AND decmsite = decksite ",
            "                                     AND decm005 = deck005 AND decm007  = deck007 ",
            "                                     AND decm008 = deck008 AND decm012  = deck027 ",
            "                                     AND decm013 = deck028 ",
            "               WHERE deckent= ? AND decm009 IS NOT NULL AND ", ls_wc," ",                  
            "      GROUP BY deckent,decksite,deck005,deck007,deck008,deck027,deck028,decm010,decm009) ",
            "      )",    
            "GROUP BY decm010,decm009,ooial003 ",
            "ORDER BY decm010,decm009"
   PREPARE adeq155_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq155_pb1
   #151012-00012#4 20151022 add by beckxie---E                  
   #end add-point
 
   LET g_detail_cnt = g_deck_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq155_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq155_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq155_detail_action_trans()
 
   IF g_deck_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq155_fetch()
   END IF
   
      CALL adeq155_filter_show('decksite','b_decksite')
   CALL adeq155_filter_show('deck001','b_deck001')
   CALL adeq155_filter_show('deck027','b_deck027')
   CALL adeq155_filter_show('deck028','b_deck028')
   CALL adeq155_filter_show('deck005','b_deck005')
   CALL adeq155_filter_show('deck007','b_deck007')
   CALL adeq155_filter_show('deck008','b_deck008')
   CALL adeq155_filter_show('deck009','b_deck009')
   CALL adeq155_filter_show('deck010','b_deck010')
   CALL adeq155_filter_show('deck011','b_deck011')
   CALL adeq155_filter_show('deck012','b_deck012')
   CALL adeq155_filter_show('deck013','b_deck013')
   CALL adeq155_filter_show('deck014','b_deck014')
   CALL adeq155_filter_show('deck015','b_deck015')
   CALL adeq155_filter_show('deck016','b_deck016')
   CALL adeq155_filter_show('deck025','b_deck025')
   CALL adeq155_filter_show('deck026','b_deck026')
   CALL adeq155_filter_show('deck017','b_deck017')
   CALL adeq155_filter_show('deck018','b_deck018')
   CALL adeq155_filter_show('deck019','b_deck019')
   CALL adeq155_filter_show('deck020','b_deck020')
   CALL adeq155_filter_show('deck023','b_deck023')
   CALL adeq155_filter_show('deck024','b_deck024')
   CALL adeq155_filter_show('deck021','b_deck021')
   CALL adeq155_filter_show('deck022','b_deck022')
   CALL adeq155_filter_show('decl008','b_decl008')
   CALL adeq155_filter_show('decl009','b_decl009')
   CALL adeq155_filter_show('decl010','b_decl010')
   CALL adeq155_filter_show('decl011','b_decl011')
   CALL adeq155_filter_show('decl015','b_decl015')
   CALL adeq155_filter_show('decl020','b_decl020')
   CALL adeq155_filter_show('decl021','b_decl021')
   CALL adeq155_filter_show('decl022','b_decl022')
   CALL adeq155_filter_show('decl016','b_decl016')
   CALL adeq155_filter_show('decl017','b_decl017')
   CALL adeq155_filter_show('decl018','b_decl018')
   CALL adeq155_filter_show('decl019','b_decl019')
   CALL adeq155_filter_show('decm010','b_decm010')
   CALL adeq155_filter_show('decm009','b_decm009')
   CALL adeq155_filter_show('decm011','b_decm011')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq155_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_deck2_d.clear()
 
   CALL g_deck3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   CALL g_deck4_d.clear()   #151012-00012#4 20151022 add by beckxie
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE decl008,'',decl009,'',decl010,decl011,decl015,decl020,decl021,decl022, 
          decl016,decl017,decl018,decl019 FROM decl_t",    
                  "",
                  " WHERE declent=? AND declsite=? AND decl005=? AND decl006=? AND decl007=? AND decl023=? AND decl024=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decl_t.decl008,decl_t.decl009" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      #150826-00013#2 201509106 s983961--mark and mod(s) 效能調整
      #LET g_sql = "SELECT  UNIQUE decl008,t1.mmanl002,decl009,t2.oocql004,decl010,decl011,decl015,decl020,decl021,decl022, 
      #    decl016,decl017,decl018,decl019 FROM decl_t",    
      #   
      #    "       LEFT JOIN mmanl_t t1 ON t1.mmanlent = declent AND t1.mmanl001 = decl008 AND t1.mmanl002 = '",g_dlang,"' ",
      #    "       LEFT JOIN oocql_t t2 ON t2.oocqlent = declent AND t2.oocql001 = '2024'  AND t2.oocql002 = decl009 AND t2.oocql003 = '",g_dlang,"' ",          
      #                     
      #            
      #            
      #            " WHERE declent=? AND declsite=? AND decl005=? AND decl006=? AND decl007=? AND decl023=? AND decl024=?"
      
      LET g_sql = "SELECT  UNIQUE decl008, ",
          "                       (SELECT mmanl003 ",
          "                          FROM mmanl_t  ",
          "                         WHERE mmanlent = declent AND mmanl001 = decl008 AND mmanl002 = '",g_dlang,"') decl008_desc, ",  
          "                       decl009, ",
          "                       (SELECT oocql004 ",
          "                          FROM oocql_t  ",
          "                         WHERE oocqlent = declent AND oocql001 = '2024' AND oocql002 = decl009 AND oocql003 = '",g_dlang,"') decl009_desc, ",  
          "                       decl010,decl011,decl015,decl020,decl021, ",
          "                       decl022,decl016,decl017,decl018,decl019  ",
          "          FROM decl_t",                    
          "         WHERE declent=? AND declsite=? AND decl005=? AND decl006=? AND decl007=? AND decl023=? AND decl024=?"
      #150826-00013#2 20150916 s983961--mark and mod(e) 效能調整
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decl_t.decl008,decl_t.decl009"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq155_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adeq155_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_deck_d[g_detail_idx].decksite
#                                 ,g_deck_d[g_detail_idx].deck005
 
#                                 ,g_deck_d[g_detail_idx].deck007
 
#                                 ,g_deck_d[g_detail_idx].deck008
 
#                                 ,g_deck_d[g_detail_idx].deck027
 
#                                 ,g_deck_d[g_detail_idx].deck028
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_deck_d[g_detail_idx].decksite   #(ver:42)
                                     ,g_deck_d[g_detail_idx].deck005   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck007   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck008   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck027   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck028   #(ver:42)
 
 
        INTO g_deck2_d[l_ac].decl008,g_deck2_d[l_ac].decl008_desc,g_deck2_d[l_ac].decl009,g_deck2_d[l_ac].decl009_desc, 
            g_deck2_d[l_ac].decl010,g_deck2_d[l_ac].decl011,g_deck2_d[l_ac].decl015,g_deck2_d[l_ac].decl020, 
            g_deck2_d[l_ac].decl021,g_deck2_d[l_ac].decl022,g_deck2_d[l_ac].decl016,g_deck2_d[l_ac].decl017, 
            g_deck2_d[l_ac].decl018,g_deck2_d[l_ac].decl019   #(ver:42)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
 
      #add-point:b_fill段資料填充 name="fetch.fill2"
      
      #end add-point
      
      CALL adeq155_detail_show("'2'")      
 
      CALL adeq155_decl_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
 
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE decm010,decm009,'',decm011 FROM decm_t",    
                  "",
                  " WHERE decment=? AND decmsite=? AND decm005=? AND decm007=? AND decm008=? AND decm012=? AND decm013=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decm_t.decm009" 
                         
      #add-point:單身填充前 name="fetch.before_fill3"
      #150826-00013#2 20150916 s983961--mark and mod(s) 效能調整
      #LET g_sql = "SELECT  UNIQUE decm010,decm009,t1.ooial003,decm011 FROM decm_t",    
      #            "       LEFT JOIN ooial_t t1 ON t1.ooialent = decment AND t1.ooial001 = decm009 AND t1.ooial002 = '",g_dlang,"' ",      
      #            " WHERE decment=? AND decmsite=? AND decm005=? AND decm007=? AND decm008=? AND decm012=? AND decm013=?"
  
      LET g_sql = "SELECT  UNIQUE decm010,decm009, ",
                  "               (SELECT ooial003 ",
                  "                  FROM ooial_t  ",
                  "                 WHERE ooialent = decment AND ooial001 = decm009 AND ooial002 = '",g_dlang,"') ooial003, ",  
                  "               decm011 ",
                  "  FROM decm_t",        
                  " WHERE decment=? AND decmsite=? AND decm005=? AND decm007=? AND decm008=? AND decm012=? AND decm013=?",
                  "   AND decm009 IS NOT NULL"   #151012-00012#4 20151022 add by beckxie
      #150826-00013#2 20150916 s983961--mark and mod(e) 效能調整
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decm_t.decm009" 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq155_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR adeq155_pb3
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs3 USING g_enterprise,g_deck_d[g_detail_idx].decksite
#                                 ,g_deck_d[g_detail_idx].deck005
 
#                                 ,g_deck_d[g_detail_idx].deck007
 
#                                 ,g_deck_d[g_detail_idx].deck008
 
#                                 ,g_deck_d[g_detail_idx].deck027
 
#                                 ,g_deck_d[g_detail_idx].deck028
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs3 USING g_enterprise,g_deck_d[g_detail_idx].decksite   #(ver:42)
                                     ,g_deck_d[g_detail_idx].deck005   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck007   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck008   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck027   #(ver:42)
 
                                     ,g_deck_d[g_detail_idx].deck028   #(ver:42)
 
 
        INTO g_deck3_d[l_ac].decm010,g_deck3_d[l_ac].decm009,g_deck3_d[l_ac].decm009_desc,g_deck3_d[l_ac].decm011  
              #(ver:42)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
 
      #add-point:b_fill段資料填充 name="fetch.fill3"
      
      #end add-point
      
      CALL adeq155_detail_show("'3'")      
 
      CALL adeq155_decm_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code = 9035 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
 
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   LET l_ac = 1
   FOREACH b_fill_curs1 USING g_enterprise INTO g_deck4_d[l_ac].decm010_1,g_deck4_d[l_ac].decm009_1,
                                                g_deck4_d[l_ac].decm009_desc_1,
                                                g_deck4_d[l_ac].decm011_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
   #end add-point 
   
   CALL g_deck2_d.deleteElement(g_deck2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_deck2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_deck3_d.deleteElement(g_deck3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_deck3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   #20151026 s983961--add(s)第四單身 重取
   CALL g_deck4_d.deleteElement(g_deck4_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_deck4_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   #20151026 s983961--add(e)第四單身 重取
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adeq155.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq155_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck_d[l_ac].decksite
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck_d[l_ac].decksite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck_d[l_ac].decksite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck_d[l_ac].deck005
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck_d[l_ac].deck005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck_d[l_ac].deck005_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck_d[l_ac].deck007
#            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck_d[l_ac].deck007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck_d[l_ac].deck007_desc
#
#            SELECT ooef019 INTO l_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_deck_d[l_ac].decksite
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = l_ooef019
#            LET g_ref_fields[2] = g_deck_d[l_ac].deck008
#            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck_d[l_ac].deck008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck_d[l_ac].deck008_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck2_d[l_ac].decl008
#            LET ls_sql = "SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck2_d[l_ac].decl008_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck2_d[l_ac].decl008_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck2_d[l_ac].decl009
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck2_d[l_ac].decl009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck2_d[l_ac].decl009_desc
#
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_deck3_d[l_ac].decm009
#            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_deck3_d[l_ac].decm009_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_deck3_d[l_ac].decm009_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq155_filter()
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
      CONSTRUCT g_wc_filter ON decksite,deck001,deck027,deck028,deck005,deck007,deck008,deck009,deck010, 
          deck011,deck012,deck013,deck014,deck015,deck016,deck025,deck026,deck017,deck018,deck019,deck020, 
          deck023,deck024,deck021,deck022
                          FROM s_detail1[1].b_decksite,s_detail1[1].b_deck001,s_detail1[1].b_deck027, 
                              s_detail1[1].b_deck028,s_detail1[1].b_deck005,s_detail1[1].b_deck007,s_detail1[1].b_deck008, 
                              s_detail1[1].b_deck009,s_detail1[1].b_deck010,s_detail1[1].b_deck011,s_detail1[1].b_deck012, 
                              s_detail1[1].b_deck013,s_detail1[1].b_deck014,s_detail1[1].b_deck015,s_detail1[1].b_deck016, 
                              s_detail1[1].b_deck025,s_detail1[1].b_deck026,s_detail1[1].b_deck017,s_detail1[1].b_deck018, 
                              s_detail1[1].b_deck019,s_detail1[1].b_deck020,s_detail1[1].b_deck023,s_detail1[1].b_deck024, 
                              s_detail1[1].b_deck021,s_detail1[1].b_deck022
 
         BEFORE CONSTRUCT
                     DISPLAY adeq155_filter_parser('decksite') TO s_detail1[1].b_decksite
            DISPLAY adeq155_filter_parser('deck001') TO s_detail1[1].b_deck001
            DISPLAY adeq155_filter_parser('deck027') TO s_detail1[1].b_deck027
            DISPLAY adeq155_filter_parser('deck028') TO s_detail1[1].b_deck028
            DISPLAY adeq155_filter_parser('deck005') TO s_detail1[1].b_deck005
            DISPLAY adeq155_filter_parser('deck007') TO s_detail1[1].b_deck007
            DISPLAY adeq155_filter_parser('deck008') TO s_detail1[1].b_deck008
            DISPLAY adeq155_filter_parser('deck009') TO s_detail1[1].b_deck009
            DISPLAY adeq155_filter_parser('deck010') TO s_detail1[1].b_deck010
            DISPLAY adeq155_filter_parser('deck011') TO s_detail1[1].b_deck011
            DISPLAY adeq155_filter_parser('deck012') TO s_detail1[1].b_deck012
            DISPLAY adeq155_filter_parser('deck013') TO s_detail1[1].b_deck013
            DISPLAY adeq155_filter_parser('deck014') TO s_detail1[1].b_deck014
            DISPLAY adeq155_filter_parser('deck015') TO s_detail1[1].b_deck015
            DISPLAY adeq155_filter_parser('deck016') TO s_detail1[1].b_deck016
            DISPLAY adeq155_filter_parser('deck025') TO s_detail1[1].b_deck025
            DISPLAY adeq155_filter_parser('deck026') TO s_detail1[1].b_deck026
            DISPLAY adeq155_filter_parser('deck017') TO s_detail1[1].b_deck017
            DISPLAY adeq155_filter_parser('deck018') TO s_detail1[1].b_deck018
            DISPLAY adeq155_filter_parser('deck019') TO s_detail1[1].b_deck019
            DISPLAY adeq155_filter_parser('deck020') TO s_detail1[1].b_deck020
            DISPLAY adeq155_filter_parser('deck023') TO s_detail1[1].b_deck023
            DISPLAY adeq155_filter_parser('deck024') TO s_detail1[1].b_deck024
            DISPLAY adeq155_filter_parser('deck021') TO s_detail1[1].b_deck021
            DISPLAY adeq155_filter_parser('deck022') TO s_detail1[1].b_deck022
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_decksite>>----
         #Ctrlp:construct.c.page1.b_decksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decksite
            #add-point:ON ACTION controlp INFIELD b_decksite name="construct.c.filter.page1.b_decksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooed004_3()                           #呼叫開窗   #161006-00008#4 by sakura mark
            #161006-00008#4 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decksite',g_site,'c') 
            CALL q_ooef001_24()
            #161006-00008#4 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_decksite  #顯示到畫面上
            NEXT FIELD b_decksite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decksite_desc>>----
         #----<<b_deck001>>----
         #Ctrlp:construct.c.filter.page1.b_deck001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck001
            #add-point:ON ACTION controlp INFIELD b_deck001 name="construct.c.filter.page1.b_deck001"
            
            #END add-point
 
 
         #----<<b_deck027>>----
         #Ctrlp:construct.c.filter.page1.b_deck027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck027
            #add-point:ON ACTION controlp INFIELD b_deck027 name="construct.c.filter.page1.b_deck027"
            
            #END add-point
 
 
         #----<<b_deck028>>----
         #Ctrlp:construct.c.filter.page1.b_deck028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck028
            #add-point:ON ACTION controlp INFIELD b_deck028 name="construct.c.filter.page1.b_deck028"
            
            #END add-point
 
 
         #----<<b_deck005>>----
         #Ctrlp:construct.c.filter.page1.b_deck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck005
            #add-point:ON ACTION controlp INFIELD b_deck005 name="construct.c.filter.page1.b_deck005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa120()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck005  #顯示到畫面上
            NEXT FIELD b_deck005                     #返回原欄位
            #END add-point
 
 
         #----<<b_deck005_desc>>----
         #----<<b_deck007>>----
         #Ctrlp:construct.c.page1.b_deck007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck007
            #add-point:ON ACTION controlp INFIELD b_deck007 name="construct.c.filter.page1.b_deck007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck007  #顯示到畫面上
            NEXT FIELD b_deck007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deck007_desc>>----
         #----<<b_deck008>>----
         #Ctrlp:construct.c.page1.b_deck008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck008
            #add-point:ON ACTION controlp INFIELD b_deck008 name="construct.c.filter.page1.b_deck008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deck008  #顯示到畫面上
            NEXT FIELD b_deck008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deck008_desc>>----
         #----<<b_deck009>>----
         #Ctrlp:construct.c.filter.page1.b_deck009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck009
            #add-point:ON ACTION controlp INFIELD b_deck009 name="construct.c.filter.page1.b_deck009"
            
            #END add-point
 
 
         #----<<b_deck010>>----
         #Ctrlp:construct.c.filter.page1.b_deck010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck010
            #add-point:ON ACTION controlp INFIELD b_deck010 name="construct.c.filter.page1.b_deck010"
            
            #END add-point
 
 
         #----<<b_deck011>>----
         #Ctrlp:construct.c.filter.page1.b_deck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck011
            #add-point:ON ACTION controlp INFIELD b_deck011 name="construct.c.filter.page1.b_deck011"
            
            #END add-point
 
 
         #----<<b_deck012>>----
         #Ctrlp:construct.c.filter.page1.b_deck012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck012
            #add-point:ON ACTION controlp INFIELD b_deck012 name="construct.c.filter.page1.b_deck012"
            
            #END add-point
 
 
         #----<<b_deck013>>----
         #Ctrlp:construct.c.filter.page1.b_deck013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck013
            #add-point:ON ACTION controlp INFIELD b_deck013 name="construct.c.filter.page1.b_deck013"
            
            #END add-point
 
 
         #----<<b_deck014>>----
         #Ctrlp:construct.c.filter.page1.b_deck014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck014
            #add-point:ON ACTION controlp INFIELD b_deck014 name="construct.c.filter.page1.b_deck014"
            
            #END add-point
 
 
         #----<<b_deck015>>----
         #Ctrlp:construct.c.filter.page1.b_deck015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck015
            #add-point:ON ACTION controlp INFIELD b_deck015 name="construct.c.filter.page1.b_deck015"
            
            #END add-point
 
 
         #----<<b_deck016>>----
         #Ctrlp:construct.c.filter.page1.b_deck016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck016
            #add-point:ON ACTION controlp INFIELD b_deck016 name="construct.c.filter.page1.b_deck016"
            
            #END add-point
 
 
         #----<<b_deck025>>----
         #Ctrlp:construct.c.filter.page1.b_deck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck025
            #add-point:ON ACTION controlp INFIELD b_deck025 name="construct.c.filter.page1.b_deck025"
            
            #END add-point
 
 
         #----<<b_deck026>>----
         #Ctrlp:construct.c.filter.page1.b_deck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck026
            #add-point:ON ACTION controlp INFIELD b_deck026 name="construct.c.filter.page1.b_deck026"
            
            #END add-point
 
 
         #----<<b_deck017>>----
         #Ctrlp:construct.c.filter.page1.b_deck017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck017
            #add-point:ON ACTION controlp INFIELD b_deck017 name="construct.c.filter.page1.b_deck017"
            
            #END add-point
 
 
         #----<<b_deck018>>----
         #Ctrlp:construct.c.filter.page1.b_deck018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck018
            #add-point:ON ACTION controlp INFIELD b_deck018 name="construct.c.filter.page1.b_deck018"
            
            #END add-point
 
 
         #----<<b_deck019>>----
         #Ctrlp:construct.c.filter.page1.b_deck019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck019
            #add-point:ON ACTION controlp INFIELD b_deck019 name="construct.c.filter.page1.b_deck019"
            
            #END add-point
 
 
         #----<<b_deck020>>----
         #Ctrlp:construct.c.filter.page1.b_deck020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck020
            #add-point:ON ACTION controlp INFIELD b_deck020 name="construct.c.filter.page1.b_deck020"
            
            #END add-point
 
 
         #----<<b_deck023>>----
         #Ctrlp:construct.c.filter.page1.b_deck023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck023
            #add-point:ON ACTION controlp INFIELD b_deck023 name="construct.c.filter.page1.b_deck023"
            
            #END add-point
 
 
         #----<<b_deck024>>----
         #Ctrlp:construct.c.filter.page1.b_deck024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck024
            #add-point:ON ACTION controlp INFIELD b_deck024 name="construct.c.filter.page1.b_deck024"
            
            #END add-point
 
 
         #----<<b_deck021>>----
         #Ctrlp:construct.c.filter.page1.b_deck021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck021
            #add-point:ON ACTION controlp INFIELD b_deck021 name="construct.c.filter.page1.b_deck021"
            
            #END add-point
 
 
         #----<<b_deck022>>----
         #Ctrlp:construct.c.filter.page1.b_deck022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deck022
            #add-point:ON ACTION controlp INFIELD b_deck022 name="construct.c.filter.page1.b_deck022"
            
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
   
      CALL adeq155_filter_show('decksite','b_decksite')
   CALL adeq155_filter_show('deck001','b_deck001')
   CALL adeq155_filter_show('deck027','b_deck027')
   CALL adeq155_filter_show('deck028','b_deck028')
   CALL adeq155_filter_show('deck005','b_deck005')
   CALL adeq155_filter_show('deck007','b_deck007')
   CALL adeq155_filter_show('deck008','b_deck008')
   CALL adeq155_filter_show('deck009','b_deck009')
   CALL adeq155_filter_show('deck010','b_deck010')
   CALL adeq155_filter_show('deck011','b_deck011')
   CALL adeq155_filter_show('deck012','b_deck012')
   CALL adeq155_filter_show('deck013','b_deck013')
   CALL adeq155_filter_show('deck014','b_deck014')
   CALL adeq155_filter_show('deck015','b_deck015')
   CALL adeq155_filter_show('deck016','b_deck016')
   CALL adeq155_filter_show('deck025','b_deck025')
   CALL adeq155_filter_show('deck026','b_deck026')
   CALL adeq155_filter_show('deck017','b_deck017')
   CALL adeq155_filter_show('deck018','b_deck018')
   CALL adeq155_filter_show('deck019','b_deck019')
   CALL adeq155_filter_show('deck020','b_deck020')
   CALL adeq155_filter_show('deck023','b_deck023')
   CALL adeq155_filter_show('deck024','b_deck024')
   CALL adeq155_filter_show('deck021','b_deck021')
   CALL adeq155_filter_show('deck022','b_deck022')
   CALL adeq155_filter_show('decl008','b_decl008')
   CALL adeq155_filter_show('decl009','b_decl009')
   CALL adeq155_filter_show('decl010','b_decl010')
   CALL adeq155_filter_show('decl011','b_decl011')
   CALL adeq155_filter_show('decl015','b_decl015')
   CALL adeq155_filter_show('decl020','b_decl020')
   CALL adeq155_filter_show('decl021','b_decl021')
   CALL adeq155_filter_show('decl022','b_decl022')
   CALL adeq155_filter_show('decl016','b_decl016')
   CALL adeq155_filter_show('decl017','b_decl017')
   CALL adeq155_filter_show('decl018','b_decl018')
   CALL adeq155_filter_show('decl019','b_decl019')
   CALL adeq155_filter_show('decm010','b_decm010')
   CALL adeq155_filter_show('decm009','b_decm009')
   CALL adeq155_filter_show('decm011','b_decm011')
 
    
   CALL adeq155_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq155_filter_parser(ps_field)
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
 
{<section id="adeq155.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq155_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq155_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.insert" >}
#+ insert
PRIVATE FUNCTION adeq155_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq155.modify" >}
#+ modify
PRIVATE FUNCTION adeq155_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq155_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.delete" >}
#+ delete
PRIVATE FUNCTION adeq155_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq155.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq155_detail_action_trans()
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
 
{<section id="adeq155.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq155_detail_index_setting()
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
            IF g_deck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deck_d.getLength() AND g_deck_d.getLength() > 0
            LET g_detail_idx = g_deck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deck_d.getLength() THEN
               LET g_detail_idx = g_deck_d.getLength()
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
 
{<section id="adeq155.mask_functions" >}
 &include "erp/ade/adeq155_mask.4gl"
 
{</section>}
 
{<section id="adeq155.other_function" readonly="Y" >}

 
{</section>}
 
