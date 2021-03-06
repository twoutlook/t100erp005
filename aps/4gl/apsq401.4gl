#該程式未解開Section, 採用最新樣板產出!
{<section id="apsq401.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-01-09 09:48:25), PR版次:0005(2016-10-18 11:08:07)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000181
#+ Filename...: apsq401
#+ Description: 銷售預測沖銷明細查詢
#+ Creator....: 04441(2014-04-07 09:01:09)
#+ Modifier...: 04441 -SD/PR- 05384
 
{</section>}
 
{<section id="apsq401.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161013-00051#1  2016/10/18 By shiun        整批調整據點組織開窗
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
PRIVATE TYPE type_g_psbc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   psbc001 LIKE psbc_t.psbc001, 
   psbc004 LIKE psbc_t.psbc004, 
   psbc004_desc_desc LIKE type_t.chr500, 
   psbc004_desc LIKE type_t.chr500, 
   psbc005 LIKE psbc_t.psbc005, 
   psbc006 LIKE psbc_t.psbc006, 
   psbc006_desc LIKE type_t.chr500, 
   psbc003 LIKE psbc_t.psbc003, 
   psbc003_desc LIKE type_t.chr500, 
   psbc002 LIKE psbc_t.psbc002, 
   psbc002_desc LIKE type_t.chr500, 
   psbc007 LIKE psbc_t.psbc007, 
   psbc007_desc LIKE type_t.chr500, 
   psbc008 LIKE psbc_t.psbc008, 
   psbc009 LIKE psbc_t.psbc009, 
   psbc010 LIKE psbc_t.psbc010, 
   psbc011 LIKE psbc_t.psbc011, 
   psbc012 LIKE psbc_t.psbc012, 
   psbc013 LIKE psbc_t.psbc013, 
   psbc014 LIKE psbc_t.psbc014, 
   psbc015 LIKE psbc_t.psbc015 
       END RECORD
PRIVATE TYPE type_g_psbc2_d RECORD
       psbd009 LIKE psbd_t.psbd009, 
   psbd010 LIKE psbd_t.psbd010, 
   psbd011 LIKE psbd_t.psbd011, 
   psbd012 LIKE psbd_t.psbd012, 
   psbd017 LIKE psbd_t.psbd017, 
   psbd017_desc LIKE type_t.chr500, 
   psbd014 LIKE psbd_t.psbd014, 
   psbd014_desc LIKE type_t.chr500, 
   psbd013 LIKE psbd_t.psbd013, 
   psbd013_desc LIKE type_t.chr500, 
   psbd018 LIKE psbd_t.psbd018, 
   psbd018_desc LIKE type_t.chr500, 
   psbd015 LIKE psbd_t.psbd015, 
   psbd015_desc_desc LIKE type_t.chr500, 
   psbd015_desc LIKE type_t.chr500, 
   psbd019 LIKE psbd_t.psbd019, 
   psbd020 LIKE psbd_t.psbd020
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單頭 type 宣告
 TYPE type_g_psbc_m RECORD
   psbc001 LIKE psbc_t.psbc001, 
   psbc001_desc LIKE type_t.chr80, 
   psbc019 DATETIME YEAR TO SECOND, 
   psbc016 LIKE psbc_t.psbc016, 
   psbc016_desc LIKE type_t.chr80, 
   psbc017 LIKE psbc_t.psbc017, 
   psbc018 LIKE psbc_t.psbc018
       END RECORD
DEFINE g_psbc_m          type_g_psbc_m
DEFINE g_psbc_m_t        type_g_psbc_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_psbc_d
DEFINE g_master_t                   type_g_psbc_d
DEFINE g_psbc_d          DYNAMIC ARRAY OF type_g_psbc_d
DEFINE g_psbc_d_t        type_g_psbc_d
DEFINE g_psbc2_d   DYNAMIC ARRAY OF type_g_psbc2_d
DEFINE g_psbc2_d_t type_g_psbc2_d
 
 
      
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
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"
DEFINE g_no_ask      LIKE type_t.num5
DEFINE g_jump        LIKE type_t.num10
DEFINE g_row_count   LIKE type_t.num10   
DEFINE g_curs_index  LIKE type_t.num10 
DEFINE g_wc3         STRING
#end add-point
 
{</section>}
 
{<section id="apsq401.main" >}
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
   CALL cl_ap_init("aps","")
 
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
   DECLARE apsq401_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apsq401_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsq401_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsq401 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsq401_init()   
 
      #進入選單 Menu (="N")
      CALL apsq401_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsq401
      
   END IF 
   
   CLOSE apsq401_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apsq401.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsq401_init()
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
   
      CALL cl_set_combo_scc('b_psbc011','5403') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_psbc011','5403')

   #end add-point
 
   CALL apsq401_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="apsq401.default_search" >}
PRIVATE FUNCTION apsq401_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " psbc001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " psbc002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " psbc003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " psbc004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " psbc005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " psbc006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " psbc007 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " psbc008 = '", g_argv[08], "' AND "
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
 
{<section id="apsq401.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION apsq401_ui_dialog()
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
      CALL apsq401_b_fill()
   ELSE
      CALL apsq401_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_psbc_d.clear()
         CALL g_psbc2_d.clear()
 
 
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
 
         CALL apsq401_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_psbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apsq401_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL apsq401_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_psbc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_psbc2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apsq401_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_navigator_setting(g_curs_index,g_row_count)
            CALL cl_set_comp_visible("sel",FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apsq401_insert()
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
               CALL apsq401_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible("sel",FALSE)
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
            CALL apsq401_filter()
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
            CALL apsq401_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_psbc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_psbc2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
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
            CALL apsq401_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apsq401_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apsq401_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apsq401_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_psbc_d.getLength()
               LET g_psbc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_psbc_d.getLength()
               LET g_psbc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_psbc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psbc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_psbc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psbc_d[li_idx].sel = "N"
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
 
{<section id="apsq401.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsq401_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_wc       STRING
   DEFINE l_page_sql STRING
   
   
   DISPLAY ' ' TO FORMONLY.page
   DISPLAY ' ' TO FORMONLY.tot_page
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting(g_curs_index,g_row_count)
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_psbc_d.clear()
   CALL g_psbc2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON psbc001,psbc004,psbc005,psbc006,psbc003,psbc002,psbc007,psbc008,psbc009, 
          psbc010,psbc011,psbc012,psbc013,psbc014,psbc015
           FROM s_detail1[1].b_psbc001,s_detail1[1].b_psbc004,s_detail1[1].b_psbc005,s_detail1[1].b_psbc006, 
               s_detail1[1].b_psbc003,s_detail1[1].b_psbc002,s_detail1[1].b_psbc007,s_detail1[1].b_psbc008, 
               s_detail1[1].b_psbc009,s_detail1[1].b_psbc010,s_detail1[1].b_psbc011,s_detail1[1].b_psbc012, 
               s_detail1[1].b_psbc013,s_detail1[1].b_psbc014,s_detail1[1].b_psbc015
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_psbc001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc001
            #add-point:BEFORE FIELD b_psbc001 name="construct.b.page1.b_psbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc001
            
            #add-point:AFTER FIELD b_psbc001 name="construct.a.page1.b_psbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc001
            #add-point:ON ACTION controlp INFIELD b_psbc001 name="construct.c.page1.b_psbc001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_psba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc001  #顯示到畫面上
            NEXT FIELD b_psbc001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_psbc004>>----
         #Ctrlp:construct.c.page1.b_psbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc004
            #add-point:ON ACTION controlp INFIELD b_psbc004 name="construct.c.page1.b_psbc004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc004  #顯示到畫面上
            NEXT FIELD b_psbc004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc004
            #add-point:BEFORE FIELD b_psbc004 name="construct.b.page1.b_psbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc004
            
            #add-point:AFTER FIELD b_psbc004 name="construct.a.page1.b_psbc004"
            
            #END add-point
            
 
 
         #----<<b_psbc004_desc_desc>>----
         #----<<b_psbc004_desc>>----
         #----<<b_psbc005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc005
            #add-point:BEFORE FIELD b_psbc005 name="construct.b.page1.b_psbc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc005
            
            #add-point:AFTER FIELD b_psbc005 name="construct.a.page1.b_psbc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc005
            #add-point:ON ACTION controlp INFIELD b_psbc005 name="construct.c.page1.b_psbc005"
            
            #END add-point
 
 
         #----<<b_psbc006>>----
         #Ctrlp:construct.c.page1.b_psbc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc006
            #add-point:ON ACTION controlp INFIELD b_psbc006 name="construct.c.page1.b_psbc006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc006  #顯示到畫面上
            NEXT FIELD b_psbc006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc006
            #add-point:BEFORE FIELD b_psbc006 name="construct.b.page1.b_psbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc006
            
            #add-point:AFTER FIELD b_psbc006 name="construct.a.page1.b_psbc006"
            
            #END add-point
            
 
 
         #----<<b_psbc006_desc>>----
         #----<<b_psbc003>>----
         #Ctrlp:construct.c.page1.b_psbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc003
            #add-point:ON ACTION controlp INFIELD b_psbc003 name="construct.c.page1.b_psbc003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc003  #顯示到畫面上
            NEXT FIELD b_psbc003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc003
            #add-point:BEFORE FIELD b_psbc003 name="construct.b.page1.b_psbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc003
            
            #add-point:AFTER FIELD b_psbc003 name="construct.a.page1.b_psbc003"
            
            #END add-point
            
 
 
         #----<<b_psbc003_desc>>----
         #----<<b_psbc002>>----
         #Ctrlp:construct.c.page1.b_psbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc002
            #add-point:ON ACTION controlp INFIELD b_psbc002 name="construct.c.page1.b_psbc002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()                           #呼叫開窗
            CALL q_ooef001_16()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO b_psbc002  #顯示到畫面上
            NEXT FIELD b_psbc002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc002
            #add-point:BEFORE FIELD b_psbc002 name="construct.b.page1.b_psbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc002
            
            #add-point:AFTER FIELD b_psbc002 name="construct.a.page1.b_psbc002"
            
            #END add-point
            
 
 
         #----<<b_psbc002_desc>>----
         #----<<b_psbc007>>----
         #Ctrlp:construct.c.page1.b_psbc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc007
            #add-point:ON ACTION controlp INFIELD b_psbc007 name="construct.c.page1.b_psbc007"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc007  #顯示到畫面上
            NEXT FIELD b_psbc007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc007
            #add-point:BEFORE FIELD b_psbc007 name="construct.b.page1.b_psbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc007
            
            #add-point:AFTER FIELD b_psbc007 name="construct.a.page1.b_psbc007"
            
            #END add-point
            
 
 
         #----<<b_psbc007_desc>>----
         #----<<b_psbc008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc008
            #add-point:BEFORE FIELD b_psbc008 name="construct.b.page1.b_psbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc008
            
            #add-point:AFTER FIELD b_psbc008 name="construct.a.page1.b_psbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc008
            #add-point:ON ACTION controlp INFIELD b_psbc008 name="construct.c.page1.b_psbc008"
            
            #END add-point
 
 
         #----<<b_psbc009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc009
            #add-point:BEFORE FIELD b_psbc009 name="construct.b.page1.b_psbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc009
            
            #add-point:AFTER FIELD b_psbc009 name="construct.a.page1.b_psbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc009
            #add-point:ON ACTION controlp INFIELD b_psbc009 name="construct.c.page1.b_psbc009"
            
            #END add-point
 
 
         #----<<b_psbc010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc010
            #add-point:BEFORE FIELD b_psbc010 name="construct.b.page1.b_psbc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc010
            
            #add-point:AFTER FIELD b_psbc010 name="construct.a.page1.b_psbc010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc010
            #add-point:ON ACTION controlp INFIELD b_psbc010 name="construct.c.page1.b_psbc010"
            
            #END add-point
 
 
         #----<<b_psbc011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc011
            #add-point:BEFORE FIELD b_psbc011 name="construct.b.page1.b_psbc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc011
            
            #add-point:AFTER FIELD b_psbc011 name="construct.a.page1.b_psbc011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc011
            #add-point:ON ACTION controlp INFIELD b_psbc011 name="construct.c.page1.b_psbc011"
            
            #END add-point
 
 
         #----<<b_psbc012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc012
            #add-point:BEFORE FIELD b_psbc012 name="construct.b.page1.b_psbc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc012
            
            #add-point:AFTER FIELD b_psbc012 name="construct.a.page1.b_psbc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc012
            #add-point:ON ACTION controlp INFIELD b_psbc012 name="construct.c.page1.b_psbc012"
            
            #END add-point
 
 
         #----<<b_psbc013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc013
            #add-point:BEFORE FIELD b_psbc013 name="construct.b.page1.b_psbc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc013
            
            #add-point:AFTER FIELD b_psbc013 name="construct.a.page1.b_psbc013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc013
            #add-point:ON ACTION controlp INFIELD b_psbc013 name="construct.c.page1.b_psbc013"
            
            #END add-point
 
 
         #----<<b_psbc014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc014
            #add-point:BEFORE FIELD b_psbc014 name="construct.b.page1.b_psbc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc014
            
            #add-point:AFTER FIELD b_psbc014 name="construct.a.page1.b_psbc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc014
            #add-point:ON ACTION controlp INFIELD b_psbc014 name="construct.c.page1.b_psbc014"
            
            #END add-point
 
 
         #----<<b_psbc015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbc015
            #add-point:BEFORE FIELD b_psbc015 name="construct.b.page1.b_psbc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbc015
            
            #add-point:AFTER FIELD b_psbc015 name="construct.a.page1.b_psbc015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc015
            #add-point:ON ACTION controlp INFIELD b_psbc015 name="construct.c.page1.b_psbc015"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON psbd009,psbd010,psbd011,psbd012,psbd017,psbd014,psbd013,psbd018,psbd015, 
          psbd019,psbd020
           FROM s_detail2[1].b_psbd009,s_detail2[1].b_psbd010,s_detail2[1].b_psbd011,s_detail2[1].b_psbd012, 
               s_detail2[1].b_psbd017,s_detail2[1].b_psbd014,s_detail2[1].b_psbd013,s_detail2[1].b_psbd018, 
               s_detail2[1].b_psbd015,s_detail2[1].b_psbd019,s_detail2[1].b_psbd020
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_psbd009>>----
         #Ctrlp:construct.c.page2.b_psbd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd009
            #add-point:ON ACTION controlp INFIELD b_psbd009 name="construct.c.page2.b_psbd009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd009  #顯示到畫面上
            NEXT FIELD b_psbd009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd009
            #add-point:BEFORE FIELD b_psbd009 name="construct.b.page2.b_psbd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd009
            
            #add-point:AFTER FIELD b_psbd009 name="construct.a.page2.b_psbd009"
            
            #END add-point
            
 
 
         #----<<b_psbd010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd010
            #add-point:BEFORE FIELD b_psbd010 name="construct.b.page2.b_psbd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd010
            
            #add-point:AFTER FIELD b_psbd010 name="construct.a.page2.b_psbd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_psbd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd010
            #add-point:ON ACTION controlp INFIELD b_psbd010 name="construct.c.page2.b_psbd010"
            
            #END add-point
 
 
         #----<<b_psbd011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd011
            #add-point:BEFORE FIELD b_psbd011 name="construct.b.page2.b_psbd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd011
            
            #add-point:AFTER FIELD b_psbd011 name="construct.a.page2.b_psbd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_psbd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd011
            #add-point:ON ACTION controlp INFIELD b_psbd011 name="construct.c.page2.b_psbd011"
            
            #END add-point
 
 
         #----<<b_psbd012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd012
            #add-point:BEFORE FIELD b_psbd012 name="construct.b.page2.b_psbd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd012
            
            #add-point:AFTER FIELD b_psbd012 name="construct.a.page2.b_psbd012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_psbd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd012
            #add-point:ON ACTION controlp INFIELD b_psbd012 name="construct.c.page2.b_psbd012"
            
            #END add-point
 
 
         #----<<b_psbd017>>----
         #Ctrlp:construct.c.page2.b_psbd017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd017
            #add-point:ON ACTION controlp INFIELD b_psbd017 name="construct.c.page2.b_psbd017"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd017  #顯示到畫面上
            NEXT FIELD b_psbd017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd017
            #add-point:BEFORE FIELD b_psbd017 name="construct.b.page2.b_psbd017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd017
            
            #add-point:AFTER FIELD b_psbd017 name="construct.a.page2.b_psbd017"
            
            #END add-point
            
 
 
         #----<<b_psbd017_desc>>----
         #----<<b_psbd014>>----
         #Ctrlp:construct.c.page2.b_psbd014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd014
            #add-point:ON ACTION controlp INFIELD b_psbd014 name="construct.c.page2.b_psbd014"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd014  #顯示到畫面上
            NEXT FIELD b_psbd014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd014
            #add-point:BEFORE FIELD b_psbd014 name="construct.b.page2.b_psbd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd014
            
            #add-point:AFTER FIELD b_psbd014 name="construct.a.page2.b_psbd014"
            
            #END add-point
            
 
 
         #----<<b_psbd014_desc>>----
         #----<<b_psbd013>>----
         #Ctrlp:construct.c.page2.b_psbd013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd013
            #add-point:ON ACTION controlp INFIELD b_psbd013 name="construct.c.page2.b_psbd013"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd013  #顯示到畫面上
            NEXT FIELD b_psbd013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd013
            #add-point:BEFORE FIELD b_psbd013 name="construct.b.page2.b_psbd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd013
            
            #add-point:AFTER FIELD b_psbd013 name="construct.a.page2.b_psbd013"
            
            #END add-point
            
 
 
         #----<<b_psbd013_desc>>----
         #----<<b_psbd018>>----
         #Ctrlp:construct.c.page2.b_psbd018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd018
            #add-point:ON ACTION controlp INFIELD b_psbd018 name="construct.c.page2.b_psbd018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd018  #顯示到畫面上
            NEXT FIELD b_psbd018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd018
            #add-point:BEFORE FIELD b_psbd018 name="construct.b.page2.b_psbd018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd018
            
            #add-point:AFTER FIELD b_psbd018 name="construct.a.page2.b_psbd018"
            
            #END add-point
            
 
 
         #----<<b_psbd018_desc>>----
         #----<<b_psbd015>>----
         #Ctrlp:construct.c.page2.b_psbd015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd015
            #add-point:ON ACTION controlp INFIELD b_psbd015 name="construct.c.page2.b_psbd015"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbd015  #顯示到畫面上
            NEXT FIELD b_psbd015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd015
            #add-point:BEFORE FIELD b_psbd015 name="construct.b.page2.b_psbd015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd015
            
            #add-point:AFTER FIELD b_psbd015 name="construct.a.page2.b_psbd015"
            
            #END add-point
            
 
 
         #----<<b_psbd015_desc_desc>>----
         #----<<b_psbd015_desc>>----
         #----<<b_psbd019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd019
            #add-point:BEFORE FIELD b_psbd019 name="construct.b.page2.b_psbd019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd019
            
            #add-point:AFTER FIELD b_psbd019 name="construct.a.page2.b_psbd019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_psbd019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd019
            #add-point:ON ACTION controlp INFIELD b_psbd019 name="construct.c.page2.b_psbd019"
            
            #END add-point
 
 
         #----<<b_psbd020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psbd020
            #add-point:BEFORE FIELD b_psbd020 name="construct.b.page2.b_psbd020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psbd020
            
            #add-point:AFTER FIELD b_psbd020 name="construct.a.page2.b_psbd020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_psbd020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbd020
            #add-point:ON ACTION controlp INFIELD b_psbd020 name="construct.c.page2.b_psbd020"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME l_wc ON psbc001,psbc019,psbc016,psbc017,psbc018
 
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD psbc001
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_psba001()
            DISPLAY g_qryparam.return1 TO psbc001
            NEXT FIELD psbc001
            
         AFTER FIELD psbc001
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = GET_FLDBUF(psbc001)
            CALL ap_ref_array2(g_ref_fields,"SELECT psbal003 FROM psbal_t WHERE psbalent='"||g_enterprise||"' AND psbal001=? AND psbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_psbc_m.psbc001_desc = '', g_rtn_fields[1] , '' 
            DISPLAY g_psbc_m.psbc001_desc TO psbc001_desc
            
         AFTER FIELD psbc019
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            
         ON ACTION controlp INFIELD psbc016
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_xmia001()
            DISPLAY g_qryparam.return1 TO psbc016
            NEXT FIELD psbc016

         AFTER FIELD psbc016
            INITIALIZE g_ref_fields TO NULL 
            LET g_ref_fields[1] = GET_FLDBUF(psbc016)
            CALL ap_ref_array2(g_ref_fields,"SELECT xmial003 FROM xmial_t WHERE xmialent='"||g_enterprise||"' AND xmial001=? AND xmial002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_psbc_m.psbc016_desc = '', g_rtn_fields[1] , '' 
            DISPLAY g_psbc_m.psbc016_desc TO psbc016_desc

         AFTER FIELD psbc017
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
      END CONSTRUCT
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
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2, " AND ", g_wc2_table2
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
   LET l_page_sql = "SELECT DISTINCT psbc001,psbc019,psbc016,psbc017,psbc018 FROM psbc_t",
                    " WHERE psbcent = '",g_enterprise,"' AND psbcsite = '",g_site,"' ",
                    "   AND ",g_wc_filter CLIPPED,
                    "   AND ",g_wc CLIPPED,
                    "   AND ",g_wc2 CLIPPED,
                    "   AND ",l_wc CLIPPED,
                    " GROUP BY psbc001,psbc019,psbc016,psbc017,psbc018 ",
                    " ORDER BY psbc001 "
   PREPARE apsq401_page_pb FROM l_page_sql
   DECLARE apsq401_page_cs SCROLL CURSOR WITH HOLD FOR apsq401_page_pb
   LET l_page_sql = "SELECT COUNT(*) FROM (",l_page_sql,")"
   PREPARE apsq401_cnt_pb FROM l_page_sql
   DECLARE apsq401_cnt_cs CURSOR FOR apsq401_cnt_pb
   OPEN apsq401_page_cs
   OPEN apsq401_cnt_cs
   FETCH apsq401_cnt_cs INTO g_row_count
   DISPLAY g_row_count TO FORMONLY.tot_page
   CALL apsq401_fetch_page('F')
   #end add-point
        
   LET g_error_show = 1
   CALL apsq401_b_fill()
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
 
{<section id="apsq401.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsq401_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',psbc001,psbc004,'','',psbc005,psbc006,'',psbc003,'',psbc002, 
       '',psbc007,'',psbc008,psbc009,psbc010,psbc011,psbc012,psbc013,psbc014,psbc015  ,DENSE_RANK() OVER( ORDER BY psbc_t.psbc001, 
       psbc_t.psbc002,psbc_t.psbc003,psbc_t.psbc004,psbc_t.psbc005,psbc_t.psbc006,psbc_t.psbc007,psbc_t.psbc008) AS RANK FROM psbc_t", 
 
 
                     " LEFT JOIN psbd_t ON psbdent = psbcent AND psbdsite = psbcsite AND psbc001 = psbd001 AND psbc002 = psbd002 AND psbc003 = psbd003 AND psbc004 = psbd004 AND psbc005 = psbd005 AND psbc006 = psbd006 AND psbc007 = psbd007 AND psbc008 = psbd008",
 
 
                     "",
                     " WHERE psbcent= ? AND psbcsite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("psbc_t"),
                     " ORDER BY psbc_t.psbc001,psbc_t.psbc002,psbc_t.psbc003,psbc_t.psbc004,psbc_t.psbc005,psbc_t.psbc006,psbc_t.psbc007,psbc_t.psbc008"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
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
 
   LET g_sql = "SELECT '',psbc001,psbc004,'','',psbc005,psbc006,'',psbc003,'',psbc002,'',psbc007,'', 
       psbc008,psbc009,psbc010,psbc011,psbc012,psbc013,psbc014,psbc015",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, " AND ", g_wc3
   
   LET g_sql = "SELECT  UNIQUE '',psbc001,psbc004,'','',psbc005,psbc006,'',psbc003,'',psbc002,'',psbc007, 
       '',psbc008,psbc009,psbc010,psbc011,psbc012,psbc013,psbc014,psbc015 FROM psbc_t",
 
               " LEFT JOIN psbd_t ON psbdent = psbcent AND psbdsite = psbcsite AND psbc001 = psbd001 AND psbc002 = psbd002 AND psbc003 = psbd003 AND psbc004 = psbd004 AND psbc005 = psbd005 AND psbc006 = psbd006 AND psbc007 = psbd007 AND psbc008 = psbd008",
 
 
               "",
               " WHERE psbcent= ? AND psbcsite= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("psbc_t")
    
   LET g_sql = g_sql, cl_sql_add_filter("psbc_t"),
                      " ORDER BY psbc_t.psbc001,psbc_t.psbc002,psbc_t.psbc003,psbc_t.psbc004,psbc_t.psbc005,psbc_t.psbc006,psbc_t.psbc007,psbc_t.psbc008"


   INITIALIZE g_psbc_m.* TO NULL
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apsq401_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsq401_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_psbc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_psbc_d[l_ac].sel,g_psbc_d[l_ac].psbc001,g_psbc_d[l_ac].psbc004,g_psbc_d[l_ac].psbc004_desc_desc, 
       g_psbc_d[l_ac].psbc004_desc,g_psbc_d[l_ac].psbc005,g_psbc_d[l_ac].psbc006,g_psbc_d[l_ac].psbc006_desc, 
       g_psbc_d[l_ac].psbc003,g_psbc_d[l_ac].psbc003_desc,g_psbc_d[l_ac].psbc002,g_psbc_d[l_ac].psbc002_desc, 
       g_psbc_d[l_ac].psbc007,g_psbc_d[l_ac].psbc007_desc,g_psbc_d[l_ac].psbc008,g_psbc_d[l_ac].psbc009, 
       g_psbc_d[l_ac].psbc010,g_psbc_d[l_ac].psbc011,g_psbc_d[l_ac].psbc012,g_psbc_d[l_ac].psbc013,g_psbc_d[l_ac].psbc014, 
       g_psbc_d[l_ac].psbc015
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_psbc_d[l_ac].statepic = cl_get_actipic(g_psbc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
 
      #end add-point
 
      CALL apsq401_detail_show("'1'")      
 
      CALL apsq401_psbc_t_mask()
 
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
   
 
   
   CALL g_psbc_d.deleteElement(g_psbc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_psbc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apsq401_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apsq401_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apsq401_detail_action_trans()
 
   IF g_psbc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL apsq401_fetch()
   END IF
   
      CALL apsq401_filter_show('psbc001','b_psbc001')
   CALL apsq401_filter_show('psbc004','b_psbc004')
   CALL apsq401_filter_show('psbc005','b_psbc005')
   CALL apsq401_filter_show('psbc006','b_psbc006')
   CALL apsq401_filter_show('psbc003','b_psbc003')
   CALL apsq401_filter_show('psbc002','b_psbc002')
   CALL apsq401_filter_show('psbc007','b_psbc007')
   CALL apsq401_filter_show('psbc008','b_psbc008')
   CALL apsq401_filter_show('psbc009','b_psbc009')
   CALL apsq401_filter_show('psbc010','b_psbc010')
   CALL apsq401_filter_show('psbc011','b_psbc011')
   CALL apsq401_filter_show('psbc012','b_psbc012')
   CALL apsq401_filter_show('psbc013','b_psbc013')
   CALL apsq401_filter_show('psbc014','b_psbc014')
   CALL apsq401_filter_show('psbc015','b_psbc015')
   CALL apsq401_filter_show('psbd009','b_psbd009')
   CALL apsq401_filter_show('psbd010','b_psbd010')
   CALL apsq401_filter_show('psbd011','b_psbd011')
   CALL apsq401_filter_show('psbd012','b_psbd012')
   CALL apsq401_filter_show('psbd017','b_psbd017')
   CALL apsq401_filter_show('psbd014','b_psbd014')
   CALL apsq401_filter_show('psbd013','b_psbd013')
   CALL apsq401_filter_show('psbd018','b_psbd018')
   CALL apsq401_filter_show('psbd015','b_psbd015')
   CALL apsq401_filter_show('psbd019','b_psbd019')
   CALL apsq401_filter_show('psbd020','b_psbd020')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsq401_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   IF cl_null(g_detail_idx) OR g_detail_idx = 0 THEN
      RETURN
   END IF
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_psbc2_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE psbd009,psbd010,psbd011,psbd012,psbd017,'',psbd014,'',psbd013,'',psbd018, 
          '',psbd015,'','',psbd019,psbd020 FROM psbd_t",    
                  "",
                  " WHERE psbdent=? AND psbdsite=? AND psbd001=? AND psbd002=? AND psbd003=? AND psbd004=? AND psbd005=? AND psbd006=? AND psbd007=? AND psbd008=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY psbd_t.psbd009,psbd_t.psbd010,psbd_t.psbd011,psbd_t.psbd012" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE apsq401_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apsq401_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise, g_site,g_psbc_d[g_detail_idx].psbc001
#                                 ,g_psbc_d[g_detail_idx].psbc002
 
#                                 ,g_psbc_d[g_detail_idx].psbc003
 
#                                 ,g_psbc_d[g_detail_idx].psbc004
 
#                                 ,g_psbc_d[g_detail_idx].psbc005
 
#                                 ,g_psbc_d[g_detail_idx].psbc006
 
#                                 ,g_psbc_d[g_detail_idx].psbc007
 
#                                 ,g_psbc_d[g_detail_idx].psbc008
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise, g_site,g_psbc_d[g_detail_idx].psbc001   #(ver:42)
                                     ,g_psbc_d[g_detail_idx].psbc002   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc003   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc004   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc005   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc006   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc007   #(ver:42)
 
                                     ,g_psbc_d[g_detail_idx].psbc008   #(ver:42)
 
 
        INTO g_psbc2_d[l_ac].psbd009,g_psbc2_d[l_ac].psbd010,g_psbc2_d[l_ac].psbd011,g_psbc2_d[l_ac].psbd012, 
            g_psbc2_d[l_ac].psbd017,g_psbc2_d[l_ac].psbd017_desc,g_psbc2_d[l_ac].psbd014,g_psbc2_d[l_ac].psbd014_desc, 
            g_psbc2_d[l_ac].psbd013,g_psbc2_d[l_ac].psbd013_desc,g_psbc2_d[l_ac].psbd018,g_psbc2_d[l_ac].psbd018_desc, 
            g_psbc2_d[l_ac].psbd015,g_psbc2_d[l_ac].psbd015_desc_desc,g_psbc2_d[l_ac].psbd015_desc,g_psbc2_d[l_ac].psbd019, 
            g_psbc2_d[l_ac].psbd020   #(ver:42)
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
      
      CALL apsq401_detail_show("'2'")      
 
      CALL apsq401_psbd_t_mask()
 
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
   
   #end add-point 
   
   CALL g_psbc2_d.deleteElement(g_psbc2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_psbc2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsq401.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsq401_detail_show(ps_page)
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
      CALL s_desc_get_item_desc(g_psbc_d[l_ac].psbc004) RETURNING g_psbc_d[l_ac].psbc004_desc_desc,g_psbc_d[l_ac].psbc004_desc
      
      CALL s_desc_get_trading_partner_abbr_desc(g_psbc_d[l_ac].psbc006) RETURNING g_psbc_d[l_ac].psbc006_desc
      
      CALL s_desc_get_person_desc(g_psbc_d[l_ac].psbc003) RETURNING g_psbc_d[l_ac].psbc003_desc
      
      CALL s_desc_get_department_desc(g_psbc_d[l_ac].psbc002) RETURNING g_psbc_d[l_ac].psbc002_desc
      
      CALL s_desc_get_acc_desc('275',g_psbc_d[l_ac].psbc007) RETURNING g_psbc_d[l_ac].psbc007_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      CALL s_desc_get_item_desc(g_psbc2_d[l_ac].psbd015) RETURNING g_psbc2_d[l_ac].psbd015_desc_desc,g_psbc2_d[l_ac].psbd015_desc
      
      CALL s_desc_get_trading_partner_abbr_desc(g_psbc2_d[l_ac].psbd017) RETURNING g_psbc2_d[l_ac].psbd017_desc
      
      CALL s_desc_get_person_desc(g_psbc2_d[l_ac].psbd014) RETURNING g_psbc2_d[l_ac].psbd014_desc
      
      CALL s_desc_get_department_desc(g_psbc2_d[l_ac].psbd013) RETURNING g_psbc2_d[l_ac].psbd013_desc
      
      CALL s_desc_get_acc_desc('275',g_psbc2_d[l_ac].psbd018) RETURNING g_psbc2_d[l_ac].psbd018_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsq401_filter()
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
      CONSTRUCT g_wc_filter ON psbc001,psbc004,psbc005,psbc006,psbc003,psbc002,psbc007,psbc008,psbc009, 
          psbc010,psbc011,psbc012,psbc013,psbc014,psbc015
                          FROM s_detail1[1].b_psbc001,s_detail1[1].b_psbc004,s_detail1[1].b_psbc005, 
                              s_detail1[1].b_psbc006,s_detail1[1].b_psbc003,s_detail1[1].b_psbc002,s_detail1[1].b_psbc007, 
                              s_detail1[1].b_psbc008,s_detail1[1].b_psbc009,s_detail1[1].b_psbc010,s_detail1[1].b_psbc011, 
                              s_detail1[1].b_psbc012,s_detail1[1].b_psbc013,s_detail1[1].b_psbc014,s_detail1[1].b_psbc015 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apsq401_filter_parser('psbc001') TO s_detail1[1].b_psbc001
            DISPLAY apsq401_filter_parser('psbc004') TO s_detail1[1].b_psbc004
            DISPLAY apsq401_filter_parser('psbc005') TO s_detail1[1].b_psbc005
            DISPLAY apsq401_filter_parser('psbc006') TO s_detail1[1].b_psbc006
            DISPLAY apsq401_filter_parser('psbc003') TO s_detail1[1].b_psbc003
            DISPLAY apsq401_filter_parser('psbc002') TO s_detail1[1].b_psbc002
            DISPLAY apsq401_filter_parser('psbc007') TO s_detail1[1].b_psbc007
            DISPLAY apsq401_filter_parser('psbc008') TO s_detail1[1].b_psbc008
            DISPLAY apsq401_filter_parser('psbc009') TO s_detail1[1].b_psbc009
            DISPLAY apsq401_filter_parser('psbc010') TO s_detail1[1].b_psbc010
            DISPLAY apsq401_filter_parser('psbc011') TO s_detail1[1].b_psbc011
            DISPLAY apsq401_filter_parser('psbc012') TO s_detail1[1].b_psbc012
            DISPLAY apsq401_filter_parser('psbc013') TO s_detail1[1].b_psbc013
            DISPLAY apsq401_filter_parser('psbc014') TO s_detail1[1].b_psbc014
            DISPLAY apsq401_filter_parser('psbc015') TO s_detail1[1].b_psbc015
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_psbc001>>----
         #Ctrlp:construct.c.filter.page1.b_psbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc001
            #add-point:ON ACTION controlp INFIELD b_psbc001 name="construct.c.filter.page1.b_psbc001"
            
            #END add-point
 
 
         #----<<b_psbc004>>----
         #Ctrlp:construct.c.page1.b_psbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc004
            #add-point:ON ACTION controlp INFIELD b_psbc004 name="construct.c.filter.page1.b_psbc004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc004  #顯示到畫面上
            NEXT FIELD b_psbc004                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_psbc004_desc_desc>>----
         #----<<b_psbc004_desc>>----
         #----<<b_psbc005>>----
         #Ctrlp:construct.c.filter.page1.b_psbc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc005
            #add-point:ON ACTION controlp INFIELD b_psbc005 name="construct.c.filter.page1.b_psbc005"
            
            #END add-point
 
 
         #----<<b_psbc006>>----
         #Ctrlp:construct.c.page1.b_psbc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc006
            #add-point:ON ACTION controlp INFIELD b_psbc006 name="construct.c.filter.page1.b_psbc006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc006  #顯示到畫面上
            NEXT FIELD b_psbc006                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_psbc006_desc>>----
         #----<<b_psbc003>>----
         #Ctrlp:construct.c.page1.b_psbc003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc003
            #add-point:ON ACTION controlp INFIELD b_psbc003 name="construct.c.filter.page1.b_psbc003"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc003  #顯示到畫面上
            NEXT FIELD b_psbc003                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_psbc003_desc>>----
         #----<<b_psbc002>>----
         #Ctrlp:construct.c.page1.b_psbc002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc002
            #add-point:ON ACTION controlp INFIELD b_psbc002 name="construct.c.filter.page1.b_psbc002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #mod--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()                           #呼叫開窗
            CALL q_ooef001_16()
            #mod--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO b_psbc002  #顯示到畫面上
            NEXT FIELD b_psbc002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_psbc002_desc>>----
         #----<<b_psbc007>>----
         #Ctrlp:construct.c.page1.b_psbc007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc007
            #add-point:ON ACTION controlp INFIELD b_psbc007 name="construct.c.filter.page1.b_psbc007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_psbc007  #顯示到畫面上
            NEXT FIELD b_psbc007                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_psbc007_desc>>----
         #----<<b_psbc008>>----
         #Ctrlp:construct.c.filter.page1.b_psbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc008
            #add-point:ON ACTION controlp INFIELD b_psbc008 name="construct.c.filter.page1.b_psbc008"
            
            #END add-point
 
 
         #----<<b_psbc009>>----
         #Ctrlp:construct.c.filter.page1.b_psbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc009
            #add-point:ON ACTION controlp INFIELD b_psbc009 name="construct.c.filter.page1.b_psbc009"
            
            #END add-point
 
 
         #----<<b_psbc010>>----
         #Ctrlp:construct.c.filter.page1.b_psbc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc010
            #add-point:ON ACTION controlp INFIELD b_psbc010 name="construct.c.filter.page1.b_psbc010"
            
            #END add-point
 
 
         #----<<b_psbc011>>----
         #Ctrlp:construct.c.filter.page1.b_psbc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc011
            #add-point:ON ACTION controlp INFIELD b_psbc011 name="construct.c.filter.page1.b_psbc011"
            
            #END add-point
 
 
         #----<<b_psbc012>>----
         #Ctrlp:construct.c.filter.page1.b_psbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc012
            #add-point:ON ACTION controlp INFIELD b_psbc012 name="construct.c.filter.page1.b_psbc012"
            
            #END add-point
 
 
         #----<<b_psbc013>>----
         #Ctrlp:construct.c.filter.page1.b_psbc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc013
            #add-point:ON ACTION controlp INFIELD b_psbc013 name="construct.c.filter.page1.b_psbc013"
            
            #END add-point
 
 
         #----<<b_psbc014>>----
         #Ctrlp:construct.c.filter.page1.b_psbc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc014
            #add-point:ON ACTION controlp INFIELD b_psbc014 name="construct.c.filter.page1.b_psbc014"
            
            #END add-point
 
 
         #----<<b_psbc015>>----
         #Ctrlp:construct.c.filter.page1.b_psbc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psbc015
            #add-point:ON ACTION controlp INFIELD b_psbc015 name="construct.c.filter.page1.b_psbc015"
            
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
   
      CALL apsq401_filter_show('psbc001','b_psbc001')
   CALL apsq401_filter_show('psbc004','b_psbc004')
   CALL apsq401_filter_show('psbc005','b_psbc005')
   CALL apsq401_filter_show('psbc006','b_psbc006')
   CALL apsq401_filter_show('psbc003','b_psbc003')
   CALL apsq401_filter_show('psbc002','b_psbc002')
   CALL apsq401_filter_show('psbc007','b_psbc007')
   CALL apsq401_filter_show('psbc008','b_psbc008')
   CALL apsq401_filter_show('psbc009','b_psbc009')
   CALL apsq401_filter_show('psbc010','b_psbc010')
   CALL apsq401_filter_show('psbc011','b_psbc011')
   CALL apsq401_filter_show('psbc012','b_psbc012')
   CALL apsq401_filter_show('psbc013','b_psbc013')
   CALL apsq401_filter_show('psbc014','b_psbc014')
   CALL apsq401_filter_show('psbc015','b_psbc015')
   CALL apsq401_filter_show('psbd009','b_psbd009')
   CALL apsq401_filter_show('psbd010','b_psbd010')
   CALL apsq401_filter_show('psbd011','b_psbd011')
   CALL apsq401_filter_show('psbd012','b_psbd012')
   CALL apsq401_filter_show('psbd017','b_psbd017')
   CALL apsq401_filter_show('psbd014','b_psbd014')
   CALL apsq401_filter_show('psbd013','b_psbd013')
   CALL apsq401_filter_show('psbd018','b_psbd018')
   CALL apsq401_filter_show('psbd015','b_psbd015')
   CALL apsq401_filter_show('psbd019','b_psbd019')
   CALL apsq401_filter_show('psbd020','b_psbd020')
 
    
   CALL apsq401_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsq401_filter_parser(ps_field)
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
 
{<section id="apsq401.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsq401_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsq401_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.insert" >}
#+ insert
PRIVATE FUNCTION apsq401_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apsq401.modify" >}
#+ modify
PRIVATE FUNCTION apsq401_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.reproduce" >}
#+ reproduce
PRIVATE FUNCTION apsq401_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.delete" >}
#+ delete
PRIVATE FUNCTION apsq401_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq401.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apsq401_detail_action_trans()
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
 
{<section id="apsq401.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apsq401_detail_index_setting()
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
            IF g_psbc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_psbc_d.getLength() AND g_psbc_d.getLength() > 0
            LET g_detail_idx = g_psbc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_psbc_d.getLength() THEN
               LET g_detail_idx = g_psbc_d.getLength()
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
 
{<section id="apsq401.mask_functions" >}
 &include "erp/aps/apsq401_mask.4gl"
 
{</section>}
 
{<section id="apsq401.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 指定PK後抓取單頭其他資料
# Memo...........:
# Usage..........: CALL apsq401_fetch_page(p_flag)
# Input parameter: p_flag
# Return code....: no
# Date & Author..: 140425 By whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq401_fetch_page(p_flag)
DEFINE p_flag     LIKE type_t.chr1      #處理方式
DEFINE ls_msg     STRING
DEFINE l_wc       STRING
   CASE p_flag
      WHEN 'N' FETCH NEXT     apsq401_page_cs INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
      WHEN 'P' FETCH PREVIOUS apsq401_page_cs INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
      WHEN 'F' FETCH FIRST    apsq401_page_cs INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
      WHEN 'L' FETCH LAST     apsq401_page_cs INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         LET g_no_ask = FALSE
         FETCH ABSOLUTE g_jump apsq401_page_cs INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
   END CASE

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "psbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_psbc_m.* TO NULL
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
      CALL cl_navigator_setting(g_curs_index,g_row_count)
   END IF
   SELECT UNIQUE psbc001,psbc019,psbc016,psbc017,psbc018
     INTO g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
     FROM psbc_t 
    WHERE psbc001 = g_psbc_m.psbc001
      AND psbc019 = g_psbc_m.psbc019
      AND psbc016 = g_psbc_m.psbc016
      AND psbc017 = g_psbc_m.psbc017
      AND psbc018 = g_psbc_m.psbc018
      AND psbcent = g_enterprise
      AND psbcsite = g_site
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "psbc_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_psbc_m.* TO NULL
      RETURN
   END IF
   LET g_wc3 = "psbc001='",g_psbc_m.psbc001,"' "
   DISPLAY BY NAME g_psbc_m.psbc001,g_psbc_m.psbc019,g_psbc_m.psbc016,g_psbc_m.psbc017,g_psbc_m.psbc018
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_psbc_m.psbc001
   CALL ap_ref_array2(g_ref_fields,"SELECT psbal003 FROM psbal_t WHERE psbalent='"||g_enterprise||"' AND psbal001=? AND psbal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psbc_m.psbc001_desc = '', g_rtn_fields[1] , '' 
   DISPLAY g_psbc_m.psbc001_desc TO psbc001_desc
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = g_psbc_m.psbc016
   CALL ap_ref_array2(g_ref_fields,"SELECT xmial003 FROM xmial_t WHERE xmialent='"||g_enterprise||"' AND xmial001=? AND xmial002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psbc_m.psbc016_desc = '', g_rtn_fields[1] , '' 
   DISPLAY g_psbc_m.psbc016_desc TO psbc016_desc
   DISPLAY g_curs_index TO FORMONLY.page
   CALL apsq401_b_fill()
END FUNCTION

 
{</section>}
 
