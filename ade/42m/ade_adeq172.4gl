#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq172.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-11-05 17:09:53), PR版次:0004(2016-10-18 17:52:12)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: adeq172
#+ Description: 門店銷售品牌月結查詢作業
#+ Creator....: 06815(2015-08-31 17:25:06)
#+ Modifier...: 06815 -SD/PR- 02159
 
{</section>}
 
{<section id="adeq172.global" >}
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
PRIVATE TYPE type_g_dedq_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   dedqsite LIKE dedq_t.dedqsite, 
   dedqsite_desc LIKE type_t.chr500, 
   dedq001 LIKE dedq_t.dedq001, 
   dedq034 LIKE dedq_t.dedq034, 
   dedq035 LIKE dedq_t.dedq035, 
   dedq006 LIKE dedq_t.dedq006, 
   dedq006_desc LIKE type_t.chr500, 
   dedq008 LIKE dedq_t.dedq008, 
   dedq008_desc LIKE type_t.chr500, 
   dedq037 LIKE dedq_t.dedq037, 
   dedq009 LIKE dedq_t.dedq009, 
   dedq009_desc LIKE type_t.chr500, 
   dedq010 LIKE dedq_t.dedq010, 
   dedq011 LIKE dedq_t.dedq011, 
   dedq012 LIKE dedq_t.dedq012, 
   dedq013 LIKE dedq_t.dedq013, 
   dedq014 LIKE dedq_t.dedq014, 
   dedq015 LIKE dedq_t.dedq015, 
   dedq016 LIKE dedq_t.dedq016, 
   dedq031 LIKE dedq_t.dedq031, 
   dedq032 LIKE dedq_t.dedq032, 
   dedq033 LIKE dedq_t.dedq033, 
   dedq017 LIKE dedq_t.dedq017, 
   dedq018 LIKE dedq_t.dedq018, 
   dedq019 LIKE dedq_t.dedq019, 
   dedq036 LIKE dedq_t.dedq036, 
   dedq020 LIKE dedq_t.dedq020, 
   dedq021 LIKE dedq_t.dedq021, 
   dedq022 LIKE dedq_t.dedq022, 
   dedq023 LIKE dedq_t.dedq023, 
   dedq024 LIKE dedq_t.dedq024, 
   dedq025 LIKE dedq_t.dedq025, 
   dedq026 LIKE dedq_t.dedq026, 
   dedq027 LIKE dedq_t.dedq027, 
   dedq028 LIKE dedq_t.dedq028, 
   dedq029 LIKE dedq_t.dedq029, 
   dedq030 LIKE dedq_t.dedq030 
       END RECORD
PRIVATE TYPE type_g_dedq2_d RECORD
       dedr010 LIKE dedr_t.dedr010, 
   dedr010_desc LIKE type_t.chr500, 
   dedr011 LIKE dedr_t.dedr011, 
   dedr011_desc LIKE type_t.chr500, 
   dedr012 LIKE dedr_t.dedr012, 
   dedr013 LIKE dedr_t.dedr013, 
   dedr017 LIKE dedr_t.dedr017, 
   dedr022 LIKE dedr_t.dedr022, 
   dedr023 LIKE dedr_t.dedr023, 
   dedr024 LIKE dedr_t.dedr024, 
   dedr018 LIKE dedr_t.dedr018, 
   dedr019 LIKE dedr_t.dedr019, 
   dedr020 LIKE dedr_t.dedr020, 
   dedr021 LIKE dedr_t.dedr021, 
   dedr027 LIKE dedr_t.dedr027
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_dedq_d
DEFINE g_master_t                   type_g_dedq_d
DEFINE g_dedq_d          DYNAMIC ARRAY OF type_g_dedq_d
DEFINE g_dedq_d_t        type_g_dedq_d
DEFINE g_dedq2_d   DYNAMIC ARRAY OF type_g_dedq2_d
DEFINE g_dedq2_d_t type_g_dedq2_d
 
 
      
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

#end add-point
 
{</section>}
 
{<section id="adeq172.main" >}
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
   DECLARE adeq172_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq172_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq172_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq172 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq172_init()   
 
      #進入選單 Menu (="N")
      CALL adeq172_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq172
      
   END IF 
   
   CLOSE adeq172_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq172.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq172_init()
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
   
      CALL cl_set_combo_scc('b_dedq037','6839') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success 
   CALL cl_set_combo_scc("b_dedq001","6540")
   #end add-point
 
   CALL adeq172_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq172.default_search" >}
PRIVATE FUNCTION adeq172_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " dedqsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " dedq034 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " dedq035 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " dedq006 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " dedq008 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " dedq009 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " dedq037 = '", g_argv[07], "' AND "
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
 
{<section id="adeq172.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq172_ui_dialog()
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
      CALL adeq172_b_fill()
   ELSE
      CALL adeq172_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dedq_d.clear()
         CALL g_dedq2_d.clear()
 
 
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
 
         CALL adeq172_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dedq_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq172_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq172_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_dedq2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_dedq2_d.getLength() TO FORMONLY.cnt
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
            CALL adeq172_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)                     
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq172_insert()
               #add-point:ON ACTION insert name="menu.insert"
               EXIT DIALOG 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               EXIT DIALOG  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               EXIT DIALOG  
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL adeq172_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               EXIT DIALOG   
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq172_filter()
            #add-point:ON ACTION filter name="menu.filter"
            EXIT DIALOG
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
            CALL adeq172_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_dedq_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_dedq2_d)
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
            CALL adeq172_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq172_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq172_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq172_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_dedq_d.getLength()
               LET g_dedq_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_dedq_d.getLength()
               LET g_dedq_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_dedq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_dedq_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_dedq_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_dedq_d[li_idx].sel = "N"
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
 
{<section id="adeq172.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq172_query()
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
   CALL g_dedq_d.clear()
   CALL g_dedq2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON dedqsite,dedq001,dedq034,dedq035,dedq006,dedq008,dedq037,dedq009,dedq010, 
          dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032,dedq033,dedq017,dedq018,dedq019, 
          dedq036,dedq020,dedq021,dedq022,dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029,dedq030 
 
           FROM s_detail1[1].b_dedqsite,s_detail1[1].b_dedq001,s_detail1[1].b_dedq034,s_detail1[1].b_dedq035, 
               s_detail1[1].b_dedq006,s_detail1[1].b_dedq008,s_detail1[1].b_dedq037,s_detail1[1].b_dedq009, 
               s_detail1[1].b_dedq010,s_detail1[1].b_dedq011,s_detail1[1].b_dedq012,s_detail1[1].b_dedq013, 
               s_detail1[1].b_dedq014,s_detail1[1].b_dedq015,s_detail1[1].b_dedq016,s_detail1[1].b_dedq031, 
               s_detail1[1].b_dedq032,s_detail1[1].b_dedq033,s_detail1[1].b_dedq017,s_detail1[1].b_dedq018, 
               s_detail1[1].b_dedq019,s_detail1[1].b_dedq036,s_detail1[1].b_dedq020,s_detail1[1].b_dedq021, 
               s_detail1[1].b_dedq022,s_detail1[1].b_dedq023,s_detail1[1].b_dedq024,s_detail1[1].b_dedq025, 
               s_detail1[1].b_dedq026,s_detail1[1].b_dedq027,s_detail1[1].b_dedq028,s_detail1[1].b_dedq029, 
               s_detail1[1].b_dedq030
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY ' ' TO b_dedqsite    #0706 查詢帶預設         
            DISPLAY g_site TO b_dedqsite #0706 查詢帶預設
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_dedqsite>>----
         #Ctrlp:construct.c.page1.b_dedqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedqsite
            #add-point:ON ACTION controlp INFIELD b_dedqsite name="construct.c.page1.b_dedqsite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = s_aooi500_q_where(g_prog,'dedqsite',g_site,'c')             
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedqsite  #顯示到畫面上
            NEXT FIELD b_dedqsite                     #返回原欄位		
  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedqsite
            #add-point:BEFORE FIELD b_dedqsite name="construct.b.page1.b_dedqsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedqsite
            
            #add-point:AFTER FIELD b_dedqsite name="construct.a.page1.b_dedqsite"
            
            #END add-point
            
 
 
         #----<<b_dedqsite_desc>>----
         #----<<b_dedq001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq001
            #add-point:BEFORE FIELD b_dedq001 name="construct.b.page1.b_dedq001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq001
            
            #add-point:AFTER FIELD b_dedq001 name="construct.a.page1.b_dedq001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq001
            #add-point:ON ACTION controlp INFIELD b_dedq001 name="construct.c.page1.b_dedq001"
            
            #END add-point
 
 
         #----<<b_dedq034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq034
            #add-point:BEFORE FIELD b_dedq034 name="construct.b.page1.b_dedq034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq034
            
            #add-point:AFTER FIELD b_dedq034 name="construct.a.page1.b_dedq034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq034
            #add-point:ON ACTION controlp INFIELD b_dedq034 name="construct.c.page1.b_dedq034"
            
            #END add-point
 
 
         #----<<b_dedq035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq035
            #add-point:BEFORE FIELD b_dedq035 name="construct.b.page1.b_dedq035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq035
            
            #add-point:AFTER FIELD b_dedq035 name="construct.a.page1.b_dedq035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq035
            #add-point:ON ACTION controlp INFIELD b_dedq035 name="construct.c.page1.b_dedq035"
            
            #END add-point
 
 
         #----<<b_dedq006>>----
         #Ctrlp:construct.c.page1.b_dedq006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq006
            #add-point:ON ACTION controlp INFIELD b_dedq006 name="construct.c.page1.b_dedq006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedq006  #顯示到畫面上
            NEXT FIELD b_dedq006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq006
            #add-point:BEFORE FIELD b_dedq006 name="construct.b.page1.b_dedq006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq006
            
            #add-point:AFTER FIELD b_dedq006 name="construct.a.page1.b_dedq006"
            
            #END add-point
            
 
 
         #----<<b_dedq006_desc>>----
         #----<<b_dedq008>>----
         #Ctrlp:construct.c.page1.b_dedq008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq008
            #add-point:ON ACTION controlp INFIELD b_dedq008 name="construct.c.page1.b_dedq008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedq008  #顯示到畫面上
            NEXT FIELD b_dedq008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq008
            #add-point:BEFORE FIELD b_dedq008 name="construct.b.page1.b_dedq008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq008
            
            #add-point:AFTER FIELD b_dedq008 name="construct.a.page1.b_dedq008"
            
            #END add-point
            
 
 
         #----<<b_dedq008_desc>>----
         #----<<b_dedq037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq037
            #add-point:BEFORE FIELD b_dedq037 name="construct.b.page1.b_dedq037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq037
            
            #add-point:AFTER FIELD b_dedq037 name="construct.a.page1.b_dedq037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq037
            #add-point:ON ACTION controlp INFIELD b_dedq037 name="construct.c.page1.b_dedq037"
            
            #END add-point
 
 
         #----<<b_dedq009>>----
         #Ctrlp:construct.c.page1.b_dedq009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq009
            #add-point:ON ACTION controlp INFIELD b_dedq009 name="construct.c.page1.b_dedq009"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            CALL q_oodb002() 
            DISPLAY g_qryparam.return1 TO b_dedq009 
            NEXT FIELD b_dedq009 
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq009
            #add-point:BEFORE FIELD b_dedq009 name="construct.b.page1.b_dedq009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq009
            
            #add-point:AFTER FIELD b_dedq009 name="construct.a.page1.b_dedq009"
            
            #END add-point
            
 
 
         #----<<b_dedq009_desc>>----
         #----<<b_dedq010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq010
            #add-point:BEFORE FIELD b_dedq010 name="construct.b.page1.b_dedq010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq010
            
            #add-point:AFTER FIELD b_dedq010 name="construct.a.page1.b_dedq010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq010
            #add-point:ON ACTION controlp INFIELD b_dedq010 name="construct.c.page1.b_dedq010"
            
            #END add-point
 
 
         #----<<b_dedq011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq011
            #add-point:BEFORE FIELD b_dedq011 name="construct.b.page1.b_dedq011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq011
            
            #add-point:AFTER FIELD b_dedq011 name="construct.a.page1.b_dedq011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq011
            #add-point:ON ACTION controlp INFIELD b_dedq011 name="construct.c.page1.b_dedq011"
            
            #END add-point
 
 
         #----<<b_dedq012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq012
            #add-point:BEFORE FIELD b_dedq012 name="construct.b.page1.b_dedq012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq012
            
            #add-point:AFTER FIELD b_dedq012 name="construct.a.page1.b_dedq012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq012
            #add-point:ON ACTION controlp INFIELD b_dedq012 name="construct.c.page1.b_dedq012"
            
            #END add-point
 
 
         #----<<b_dedq013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq013
            #add-point:BEFORE FIELD b_dedq013 name="construct.b.page1.b_dedq013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq013
            
            #add-point:AFTER FIELD b_dedq013 name="construct.a.page1.b_dedq013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq013
            #add-point:ON ACTION controlp INFIELD b_dedq013 name="construct.c.page1.b_dedq013"
            
            #END add-point
 
 
         #----<<b_dedq014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq014
            #add-point:BEFORE FIELD b_dedq014 name="construct.b.page1.b_dedq014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq014
            
            #add-point:AFTER FIELD b_dedq014 name="construct.a.page1.b_dedq014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq014
            #add-point:ON ACTION controlp INFIELD b_dedq014 name="construct.c.page1.b_dedq014"
            
            #END add-point
 
 
         #----<<b_dedq015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq015
            #add-point:BEFORE FIELD b_dedq015 name="construct.b.page1.b_dedq015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq015
            
            #add-point:AFTER FIELD b_dedq015 name="construct.a.page1.b_dedq015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq015
            #add-point:ON ACTION controlp INFIELD b_dedq015 name="construct.c.page1.b_dedq015"
            
            #END add-point
 
 
         #----<<b_dedq016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq016
            #add-point:BEFORE FIELD b_dedq016 name="construct.b.page1.b_dedq016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq016
            
            #add-point:AFTER FIELD b_dedq016 name="construct.a.page1.b_dedq016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq016
            #add-point:ON ACTION controlp INFIELD b_dedq016 name="construct.c.page1.b_dedq016"
            
            #END add-point
 
 
         #----<<b_dedq031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq031
            #add-point:BEFORE FIELD b_dedq031 name="construct.b.page1.b_dedq031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq031
            
            #add-point:AFTER FIELD b_dedq031 name="construct.a.page1.b_dedq031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq031
            #add-point:ON ACTION controlp INFIELD b_dedq031 name="construct.c.page1.b_dedq031"
            
            #END add-point
 
 
         #----<<b_dedq032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq032
            #add-point:BEFORE FIELD b_dedq032 name="construct.b.page1.b_dedq032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq032
            
            #add-point:AFTER FIELD b_dedq032 name="construct.a.page1.b_dedq032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq032
            #add-point:ON ACTION controlp INFIELD b_dedq032 name="construct.c.page1.b_dedq032"
            
            #END add-point
 
 
         #----<<b_dedq033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq033
            #add-point:BEFORE FIELD b_dedq033 name="construct.b.page1.b_dedq033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq033
            
            #add-point:AFTER FIELD b_dedq033 name="construct.a.page1.b_dedq033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq033
            #add-point:ON ACTION controlp INFIELD b_dedq033 name="construct.c.page1.b_dedq033"
            
            #END add-point
 
 
         #----<<b_dedq017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq017
            #add-point:BEFORE FIELD b_dedq017 name="construct.b.page1.b_dedq017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq017
            
            #add-point:AFTER FIELD b_dedq017 name="construct.a.page1.b_dedq017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq017
            #add-point:ON ACTION controlp INFIELD b_dedq017 name="construct.c.page1.b_dedq017"
            
            #END add-point
 
 
         #----<<b_dedq018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq018
            #add-point:BEFORE FIELD b_dedq018 name="construct.b.page1.b_dedq018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq018
            
            #add-point:AFTER FIELD b_dedq018 name="construct.a.page1.b_dedq018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq018
            #add-point:ON ACTION controlp INFIELD b_dedq018 name="construct.c.page1.b_dedq018"
            
            #END add-point
 
 
         #----<<b_dedq019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq019
            #add-point:BEFORE FIELD b_dedq019 name="construct.b.page1.b_dedq019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq019
            
            #add-point:AFTER FIELD b_dedq019 name="construct.a.page1.b_dedq019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq019
            #add-point:ON ACTION controlp INFIELD b_dedq019 name="construct.c.page1.b_dedq019"
            
            #END add-point
 
 
         #----<<b_dedq036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq036
            #add-point:BEFORE FIELD b_dedq036 name="construct.b.page1.b_dedq036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq036
            
            #add-point:AFTER FIELD b_dedq036 name="construct.a.page1.b_dedq036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq036
            #add-point:ON ACTION controlp INFIELD b_dedq036 name="construct.c.page1.b_dedq036"
            
            #END add-point
 
 
         #----<<b_dedq020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq020
            #add-point:BEFORE FIELD b_dedq020 name="construct.b.page1.b_dedq020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq020
            
            #add-point:AFTER FIELD b_dedq020 name="construct.a.page1.b_dedq020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq020
            #add-point:ON ACTION controlp INFIELD b_dedq020 name="construct.c.page1.b_dedq020"
            
            #END add-point
 
 
         #----<<b_dedq021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq021
            #add-point:BEFORE FIELD b_dedq021 name="construct.b.page1.b_dedq021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq021
            
            #add-point:AFTER FIELD b_dedq021 name="construct.a.page1.b_dedq021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq021
            #add-point:ON ACTION controlp INFIELD b_dedq021 name="construct.c.page1.b_dedq021"
            
            #END add-point
 
 
         #----<<b_dedq022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq022
            #add-point:BEFORE FIELD b_dedq022 name="construct.b.page1.b_dedq022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq022
            
            #add-point:AFTER FIELD b_dedq022 name="construct.a.page1.b_dedq022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq022
            #add-point:ON ACTION controlp INFIELD b_dedq022 name="construct.c.page1.b_dedq022"
            
            #END add-point
 
 
         #----<<b_dedq023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq023
            #add-point:BEFORE FIELD b_dedq023 name="construct.b.page1.b_dedq023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq023
            
            #add-point:AFTER FIELD b_dedq023 name="construct.a.page1.b_dedq023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq023
            #add-point:ON ACTION controlp INFIELD b_dedq023 name="construct.c.page1.b_dedq023"
            
            #END add-point
 
 
         #----<<b_dedq024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq024
            #add-point:BEFORE FIELD b_dedq024 name="construct.b.page1.b_dedq024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq024
            
            #add-point:AFTER FIELD b_dedq024 name="construct.a.page1.b_dedq024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq024
            #add-point:ON ACTION controlp INFIELD b_dedq024 name="construct.c.page1.b_dedq024"
            
            #END add-point
 
 
         #----<<b_dedq025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq025
            #add-point:BEFORE FIELD b_dedq025 name="construct.b.page1.b_dedq025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq025
            
            #add-point:AFTER FIELD b_dedq025 name="construct.a.page1.b_dedq025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq025
            #add-point:ON ACTION controlp INFIELD b_dedq025 name="construct.c.page1.b_dedq025"
            
            #END add-point
 
 
         #----<<b_dedq026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq026
            #add-point:BEFORE FIELD b_dedq026 name="construct.b.page1.b_dedq026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq026
            
            #add-point:AFTER FIELD b_dedq026 name="construct.a.page1.b_dedq026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq026
            #add-point:ON ACTION controlp INFIELD b_dedq026 name="construct.c.page1.b_dedq026"
            
            #END add-point
 
 
         #----<<b_dedq027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq027
            #add-point:BEFORE FIELD b_dedq027 name="construct.b.page1.b_dedq027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq027
            
            #add-point:AFTER FIELD b_dedq027 name="construct.a.page1.b_dedq027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq027
            #add-point:ON ACTION controlp INFIELD b_dedq027 name="construct.c.page1.b_dedq027"
            
            #END add-point
 
 
         #----<<b_dedq028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq028
            #add-point:BEFORE FIELD b_dedq028 name="construct.b.page1.b_dedq028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq028
            
            #add-point:AFTER FIELD b_dedq028 name="construct.a.page1.b_dedq028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq028
            #add-point:ON ACTION controlp INFIELD b_dedq028 name="construct.c.page1.b_dedq028"
            
            #END add-point
 
 
         #----<<b_dedq029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq029
            #add-point:BEFORE FIELD b_dedq029 name="construct.b.page1.b_dedq029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq029
            
            #add-point:AFTER FIELD b_dedq029 name="construct.a.page1.b_dedq029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq029
            #add-point:ON ACTION controlp INFIELD b_dedq029 name="construct.c.page1.b_dedq029"
            
            #END add-point
 
 
         #----<<b_dedq030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedq030
            #add-point:BEFORE FIELD b_dedq030 name="construct.b.page1.b_dedq030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedq030
            
            #add-point:AFTER FIELD b_dedq030 name="construct.a.page1.b_dedq030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dedq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq030
            #add-point:ON ACTION controlp INFIELD b_dedq030 name="construct.c.page1.b_dedq030"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON dedr010,dedr011,dedr012,dedr013,dedr017,dedr022,dedr023,dedr024,dedr018, 
          dedr019,dedr020,dedr021,dedr027
           FROM s_detail2[1].b_dedr010,s_detail2[1].b_dedr011,s_detail2[1].b_dedr012,s_detail2[1].b_dedr013, 
               s_detail2[1].b_dedr017,s_detail2[1].b_dedr022,s_detail2[1].b_dedr023,s_detail2[1].b_dedr024, 
               s_detail2[1].b_dedr018,s_detail2[1].b_dedr019,s_detail2[1].b_dedr020,s_detail2[1].b_dedr021, 
               s_detail2[1].b_dedr027
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            DISPLAY '' TO s_detail2[1].b_dedr010 
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_dedr010>>----
         #Ctrlp:construct.c.page2.b_dedr010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr010
            #add-point:ON ACTION controlp INFIELD b_dedr010 name="construct.c.page2.b_dedr010"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mman001() 
            DISPLAY g_qryparam.return1 TO b_dedr010   #顯示到畫面上
            NEXT FIELD b_dedr010                      #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr010
            #add-point:BEFORE FIELD b_dedr010 name="construct.b.page2.b_dedr010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr010
            
            #add-point:AFTER FIELD b_dedr010 name="construct.a.page2.b_dedr010"
            
            #END add-point
            
 
 
         #----<<b_dedr010_desc>>----
         #----<<b_dedr011>>----
         #Ctrlp:construct.c.page2.b_dedr011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr011
            #add-point:ON ACTION controlp INFIELD b_dedr011 name="construct.c.page2.b_dedr011"
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE 
            LET g_qryparam.arg1 = '2024' 
            CALL q_oocq002() 
            DISPLAY g_qryparam.return1 TO b_dedr011 
            NEXT FIELD b_dedr011        
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr011
            #add-point:BEFORE FIELD b_dedr011 name="construct.b.page2.b_dedr011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr011
            
            #add-point:AFTER FIELD b_dedr011 name="construct.a.page2.b_dedr011"
            
            #END add-point
            
 
 
         #----<<b_dedr011_desc>>----
         #----<<b_dedr012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr012
            #add-point:BEFORE FIELD b_dedr012 name="construct.b.page2.b_dedr012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr012
            
            #add-point:AFTER FIELD b_dedr012 name="construct.a.page2.b_dedr012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr012
            #add-point:ON ACTION controlp INFIELD b_dedr012 name="construct.c.page2.b_dedr012"
            
            #END add-point
 
 
         #----<<b_dedr013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr013
            #add-point:BEFORE FIELD b_dedr013 name="construct.b.page2.b_dedr013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr013
            
            #add-point:AFTER FIELD b_dedr013 name="construct.a.page2.b_dedr013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr013
            #add-point:ON ACTION controlp INFIELD b_dedr013 name="construct.c.page2.b_dedr013"
            
            #END add-point
 
 
         #----<<b_dedr017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr017
            #add-point:BEFORE FIELD b_dedr017 name="construct.b.page2.b_dedr017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr017
            
            #add-point:AFTER FIELD b_dedr017 name="construct.a.page2.b_dedr017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr017
            #add-point:ON ACTION controlp INFIELD b_dedr017 name="construct.c.page2.b_dedr017"
            
            #END add-point
 
 
         #----<<b_dedr022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr022
            #add-point:BEFORE FIELD b_dedr022 name="construct.b.page2.b_dedr022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr022
            
            #add-point:AFTER FIELD b_dedr022 name="construct.a.page2.b_dedr022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr022
            #add-point:ON ACTION controlp INFIELD b_dedr022 name="construct.c.page2.b_dedr022"
            
            #END add-point
 
 
         #----<<b_dedr023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr023
            #add-point:BEFORE FIELD b_dedr023 name="construct.b.page2.b_dedr023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr023
            
            #add-point:AFTER FIELD b_dedr023 name="construct.a.page2.b_dedr023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr023
            #add-point:ON ACTION controlp INFIELD b_dedr023 name="construct.c.page2.b_dedr023"
            
            #END add-point
 
 
         #----<<b_dedr024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr024
            #add-point:BEFORE FIELD b_dedr024 name="construct.b.page2.b_dedr024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr024
            
            #add-point:AFTER FIELD b_dedr024 name="construct.a.page2.b_dedr024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr024
            #add-point:ON ACTION controlp INFIELD b_dedr024 name="construct.c.page2.b_dedr024"
            
            #END add-point
 
 
         #----<<b_dedr018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr018
            #add-point:BEFORE FIELD b_dedr018 name="construct.b.page2.b_dedr018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr018
            
            #add-point:AFTER FIELD b_dedr018 name="construct.a.page2.b_dedr018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr018
            #add-point:ON ACTION controlp INFIELD b_dedr018 name="construct.c.page2.b_dedr018"
            
            #END add-point
 
 
         #----<<b_dedr019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr019
            #add-point:BEFORE FIELD b_dedr019 name="construct.b.page2.b_dedr019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr019
            
            #add-point:AFTER FIELD b_dedr019 name="construct.a.page2.b_dedr019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr019
            #add-point:ON ACTION controlp INFIELD b_dedr019 name="construct.c.page2.b_dedr019"
            
            #END add-point
 
 
         #----<<b_dedr020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr020
            #add-point:BEFORE FIELD b_dedr020 name="construct.b.page2.b_dedr020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr020
            
            #add-point:AFTER FIELD b_dedr020 name="construct.a.page2.b_dedr020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr020
            #add-point:ON ACTION controlp INFIELD b_dedr020 name="construct.c.page2.b_dedr020"
            
            #END add-point
 
 
         #----<<b_dedr021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr021
            #add-point:BEFORE FIELD b_dedr021 name="construct.b.page2.b_dedr021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr021
            
            #add-point:AFTER FIELD b_dedr021 name="construct.a.page2.b_dedr021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr021
            #add-point:ON ACTION controlp INFIELD b_dedr021 name="construct.c.page2.b_dedr021"
            
            #END add-point
 
 
         #----<<b_dedr027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dedr027
            #add-point:BEFORE FIELD b_dedr027 name="construct.b.page2.b_dedr027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dedr027
            
            #add-point:AFTER FIELD b_dedr027 name="construct.a.page2.b_dedr027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_dedr027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedr027
            #add-point:ON ACTION controlp INFIELD b_dedr027 name="construct.c.page2.b_dedr027"
            
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
   
   #end add-point
        
   LET g_error_show = 1
   CALL adeq172_b_fill()
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
 
{<section id="adeq172.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq172_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'dedqsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',dedqsite,'',dedq001,dedq034,dedq035,dedq006,'',dedq008,'',dedq037, 
       dedq009,'',dedq010,dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032,dedq033,dedq017, 
       dedq018,dedq019,dedq036,dedq020,dedq021,dedq022,dedq023,dedq024,dedq025,dedq026,dedq027,dedq028, 
       dedq029,dedq030  ,DENSE_RANK() OVER( ORDER BY dedq_t.dedqsite,dedq_t.dedq034,dedq_t.dedq035,dedq_t.dedq006, 
       dedq_t.dedq008,dedq_t.dedq009,dedq_t.dedq037) AS RANK FROM dedq_t",
 
                     " LEFT JOIN dedr_t ON dedrent = dedqent AND dedqsite = dedrsite AND dedq034 = dedr034 AND dedq035 = dedr035 AND dedq006 = dedr006 AND dedq008 = dedr008 AND dedq009 = dedr009",
 
 
                     "",
                     " WHERE dedqent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("dedq_t"),
                     " ORDER BY dedq_t.dedqsite,dedq_t.dedq034,dedq_t.dedq035,dedq_t.dedq006,dedq_t.dedq008,dedq_t.dedq009,dedq_t.dedq037"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150716-00020#7 20150707 s983961 add(s) 重新r.a 調整為直接取日結類型的資料，其餘皆由批次處理
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   #150826-00013#2 20150908 s983961--mark and mod(s) 效能調整
   #LET ls_sql_rank = "SELECT  UNIQUE 'N',dedqsite,t1.ooefl003 dedqsite_desc,dedq001,dedq034,dedq035,dedq006,t2.oocql004 dedq006_desc, ",
   #                  "                   dedq008,t4.staal003 dedq008_desc,dedq037,dedq009,t3.oodbl004 dedq009_desc,dedq010, ",
   #                  "                   dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032, ",
   #                  "                   dedq033,dedq017,dedq018,dedq019,dedq036,dedq020,dedq021,dedq022, ",
   #                  "                   dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029,dedq030, ",              
   #                  " DENSE_RANK() OVER( ORDER BY dedq_t.dedqsite,dedq_t.dedq034,dedq_t.dedq035,dedq_t.dedq006, dedq_t.dedq008,dedq_t.dedq009) AS RANK ",
   #                  "  FROM dedq_t ",
   #                  "  ",
   #                  "  LEFT JOIN dedr_t ON dedrent = dedqent AND dedqsite = dedrsite AND dedq034 = dedr025 AND dedq035 = dedr026     ", 
   #                  "                 AND dedq006 = dedr006 AND dedq008 = dedr008   AND dedq009 = dedr009 AND dedq037 = dedr028      ",
   #                  "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = dedqent AND t1.ooefl001 = dedqsite AND t1.ooefl002 = '",g_dlang,"' ",
   #                  "       LEFT JOIN oocql_t t2 ON t2.oocqlent = dedqent AND t2.oocql001 = '2002' AND t2.oocql002 = dedq006 AND t2.oocql003 = '",g_dlang,"' ",
   #                  "       LEFT JOIN (SELECT oodblent,ooef001,oodbl002,oodbl003,oodbl004 ",
   #                  "                    FROM ooef_t,oodbl_t WHERE ooefent = oodblent AND ooef019 = oodbl001) t3",
   #                  "              ON t3.oodblent = dedqent AND t3.ooef001 = dedqsite AND t3.oodbl002 = dedq009 AND t3.oodbl003 = '",g_dlang,"' ",
   #                  "       LEFT JOIN staal_t t4 ON t4.staalent=dedqent AND t4.staal001=dedq008 AND t4.staal002='",g_dlang,"'",                   
   #                  " WHERE dedqent = ? ",
   #                  "  AND dedq037='3'  ",                   
   #                  "  AND 1=1 AND ", ls_wc
   
   LET ls_sql_rank = "SELECT  UNIQUE 'N',dedqsite,",
                     "                   (SELECT ooefl003 FROM ooefl_t ",
                     "                     WHERE ooeflent = dedqent ",
                     "                       AND ooefl001 = dedqsite ",
                     "                       AND ooefl002 ='"||g_dlang||"') dedqsite_desc,",
                     "                   dedq001,dedq034, ",
                     "                   dedq035,dedq006, ",
                     "                   (SELECT oocql004 FROM oocql_t ",
                     "                     WHERE oocqlent = dedqent ",
                     "                       AND oocql001 = '2002'  ",
                     "                       AND oocql002 = dedq006 ",
                     "                       AND oocql003 ='"||g_dlang||"') dedq006_desc,",
                     "                   dedq008, ",
                     "                   (SELECT staal003 FROM staal_t ",
                     "                     WHERE staalent = dedqent ",
                     "                       AND staal001 = dedq008 ",
                     "                       AND staal002 ='"||g_dlang||"') dedq008_desc, ", 
                     "                   dedq037,dedq009, ",
                     "                   (SELECT oodbl004 ", 
                     "                      FROM (SELECT oodblent,ooef001,oodbl002,oodbl003,oodbl004 ",
                     "                    FROM ooef_t,oodbl_t WHERE ooefent = oodblent AND ooef019 = oodbl001) ", 
                     "                     WHERE oodblent = dedqent ",
                     "                       AND ooef001 = dedqsite ",
                     "                       AND oodbl002 = dedq009 ",
                     "                       AND oodbl003 ='"||g_dlang||"') dedq009_desc, ", 
                     "                   dedq010, ",
                     "                   dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032, ",
                     "                   dedq033,dedq017,dedq018,dedq019,dedq036,dedq020,dedq021,dedq022, ",
                     "                   dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029,dedq030, ",              
                     " DENSE_RANK() OVER( ORDER BY dedq_t.dedqsite,dedq_t.dedq034,dedq_t.dedq035,dedq_t.dedq006, dedq_t.dedq008,dedq_t.dedq009) AS RANK ",
                     "  FROM dedq_t ",
                     "  LEFT JOIN dedr_t ON dedrent = dedqent AND dedqsite = dedrsite AND dedq034 = dedr025 AND dedq035 = dedr026  ", 
                     "                 AND dedq006 = dedr006 AND dedq008 = dedr008   AND dedq009 = dedr009 AND dedq037 = dedr028   ",    
                     " WHERE dedqent = ? ",
                     "  AND dedq037='3'  ",                   
                     "  AND 1=1 AND ", ls_wc
   #150826-00013#2 20150908 s983961--mark and mod(e) 效能調整                  
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("dedq_t"),
                     " ORDER BY dedq_t.dedqsite,dedq_t.dedq034,dedq_t.dedq035,dedq_t.dedq006,dedq_t.dedq008,dedq_t.dedq009"      
   #150716-00020#7 20150707 s983961 add(e) 重新r.a 調整為直接取日結類型的資料，其餘皆由批次處理                     
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
 
   LET g_sql = "SELECT '',dedqsite,'',dedq001,dedq034,dedq035,dedq006,'',dedq008,'',dedq037,dedq009, 
       '',dedq010,dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032,dedq033,dedq017,dedq018, 
       dedq019,dedq036,dedq020,dedq021,dedq022,dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029, 
       dedq030",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT 'N',dedqsite,dedqsite_desc,dedq001,dedq034,dedq035,dedq006,dedq006_desc,
       dedq008,dedq008_desc,dedq037,dedq009, dedq009_desc,dedq010,dedq011,dedq012,dedq013,dedq014,
       dedq015,dedq016,dedq031,dedq032,dedq033,dedq017,dedq018,dedq019,dedq036,dedq020,dedq021,
       dedq022,dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029, dedq030",
              "  FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
              "   AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq172_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq172_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dedq_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_dedq_d[l_ac].sel,g_dedq_d[l_ac].dedqsite,g_dedq_d[l_ac].dedqsite_desc, 
       g_dedq_d[l_ac].dedq001,g_dedq_d[l_ac].dedq034,g_dedq_d[l_ac].dedq035,g_dedq_d[l_ac].dedq006,g_dedq_d[l_ac].dedq006_desc, 
       g_dedq_d[l_ac].dedq008,g_dedq_d[l_ac].dedq008_desc,g_dedq_d[l_ac].dedq037,g_dedq_d[l_ac].dedq009, 
       g_dedq_d[l_ac].dedq009_desc,g_dedq_d[l_ac].dedq010,g_dedq_d[l_ac].dedq011,g_dedq_d[l_ac].dedq012, 
       g_dedq_d[l_ac].dedq013,g_dedq_d[l_ac].dedq014,g_dedq_d[l_ac].dedq015,g_dedq_d[l_ac].dedq016,g_dedq_d[l_ac].dedq031, 
       g_dedq_d[l_ac].dedq032,g_dedq_d[l_ac].dedq033,g_dedq_d[l_ac].dedq017,g_dedq_d[l_ac].dedq018,g_dedq_d[l_ac].dedq019, 
       g_dedq_d[l_ac].dedq036,g_dedq_d[l_ac].dedq020,g_dedq_d[l_ac].dedq021,g_dedq_d[l_ac].dedq022,g_dedq_d[l_ac].dedq023, 
       g_dedq_d[l_ac].dedq024,g_dedq_d[l_ac].dedq025,g_dedq_d[l_ac].dedq026,g_dedq_d[l_ac].dedq027,g_dedq_d[l_ac].dedq028, 
       g_dedq_d[l_ac].dedq029,g_dedq_d[l_ac].dedq030
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_dedq_d[l_ac].statepic = cl_get_actipic(g_dedq_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq172_detail_show("'1'")      
 
      CALL adeq172_dedq_t_mask()
 
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
   
 
   
   CALL g_dedq_d.deleteElement(g_dedq_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_dedq_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq172_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq172_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq172_detail_action_trans()
 
   IF g_dedq_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq172_fetch()
   END IF
   
      CALL adeq172_filter_show('dedqsite','b_dedqsite')
   CALL adeq172_filter_show('dedq001','b_dedq001')
   CALL adeq172_filter_show('dedq034','b_dedq034')
   CALL adeq172_filter_show('dedq035','b_dedq035')
   CALL adeq172_filter_show('dedq006','b_dedq006')
   CALL adeq172_filter_show('dedq008','b_dedq008')
   CALL adeq172_filter_show('dedq037','b_dedq037')
   CALL adeq172_filter_show('dedq009','b_dedq009')
   CALL adeq172_filter_show('dedq010','b_dedq010')
   CALL adeq172_filter_show('dedq011','b_dedq011')
   CALL adeq172_filter_show('dedq012','b_dedq012')
   CALL adeq172_filter_show('dedq013','b_dedq013')
   CALL adeq172_filter_show('dedq014','b_dedq014')
   CALL adeq172_filter_show('dedq015','b_dedq015')
   CALL adeq172_filter_show('dedq016','b_dedq016')
   CALL adeq172_filter_show('dedq031','b_dedq031')
   CALL adeq172_filter_show('dedq032','b_dedq032')
   CALL adeq172_filter_show('dedq033','b_dedq033')
   CALL adeq172_filter_show('dedq017','b_dedq017')
   CALL adeq172_filter_show('dedq018','b_dedq018')
   CALL adeq172_filter_show('dedq019','b_dedq019')
   CALL adeq172_filter_show('dedq036','b_dedq036')
   CALL adeq172_filter_show('dedq020','b_dedq020')
   CALL adeq172_filter_show('dedq021','b_dedq021')
   CALL adeq172_filter_show('dedq022','b_dedq022')
   CALL adeq172_filter_show('dedq023','b_dedq023')
   CALL adeq172_filter_show('dedq024','b_dedq024')
   CALL adeq172_filter_show('dedq025','b_dedq025')
   CALL adeq172_filter_show('dedq026','b_dedq026')
   CALL adeq172_filter_show('dedq027','b_dedq027')
   CALL adeq172_filter_show('dedq028','b_dedq028')
   CALL adeq172_filter_show('dedq029','b_dedq029')
   CALL adeq172_filter_show('dedq030','b_dedq030')
   CALL adeq172_filter_show('dedr010','b_dedr010')
   CALL adeq172_filter_show('dedr011','b_dedr011')
   CALL adeq172_filter_show('dedr012','b_dedr012')
   CALL adeq172_filter_show('dedr013','b_dedr013')
   CALL adeq172_filter_show('dedr017','b_dedr017')
   CALL adeq172_filter_show('dedr022','b_dedr022')
   CALL adeq172_filter_show('dedr023','b_dedr023')
   CALL adeq172_filter_show('dedr024','b_dedr024')
   CALL adeq172_filter_show('dedr018','b_dedr018')
   CALL adeq172_filter_show('dedr019','b_dedr019')
   CALL adeq172_filter_show('dedr020','b_dedr020')
   CALL adeq172_filter_show('dedr021','b_dedr021')
   CALL adeq172_filter_show('dedr027','b_dedr027')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq172_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_dedq2_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE dedr010,'',dedr011,'',dedr012,dedr013,dedr017,dedr022,dedr023,dedr024, 
          dedr018,dedr019,dedr020,dedr021,dedr027 FROM dedr_t",    
                  "",
                  " WHERE dedrent=? AND dedrsite=? AND dedr034=? AND dedr035=? AND dedr006=? AND dedr008=? AND dedr009=? AND dedr026=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY dedr_t.dedr0010,dedr_t.dedr011" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      #150826-00013#2 20150908 s983961--mark and mod(s) 效能調整
      #LET g_sql = "SELECT  UNIQUE dedr010,t1.mmanl003,dedr011,t2.oocql004,dedr012,dedr013, ",
      #            "               dedr017,dedr022,dedr023,dedr024, ",
      #            "               dedr018,dedr019,dedr020,dedr021, ",
      #            "               dedr027,dedr014,dedr015,dedr016  ",
      #            "  FROM dedr_t ",
      #            "       LEFT JOIN mmanl_t t1 ON t1.mmanlent = dedrent AND t1.mmanl001 = dedr010 AND t1.mmanl002 = '",g_dlang,"' ",
      #            "       LEFT JOIN (SELECT oocqlent,oocql002,oocql004",
      #            "                    FROM oocql_t,oocq_t ",
      #            "                   WHERE oocqlent = oocqent AND oocql001 = oocq004 AND oocql003 = '",g_dlang,"' ",
      #            "                     AND oocq001 = '2049'   AND oocq002 = '09') t2 ",
      #            "              ON t2.oocqlent = dedrent AND t2.oocql002 = dedr011 ",
      #            " WHERE dedrent = ? ", 
      #            "   AND dedrsite = ?", 
      #            "   AND dedr025 = ? ", 
      #            "   AND dedr026 = ? ", 
      #            "   AND dedr006 = ? ", 
      #            "   AND dedr008 = ? ",
      #            "   AND dedr009 = ? ",
      #            "   AND dedr028 = ? "
      
      LET g_sql = "SELECT  UNIQUE dedr010, ",
                  "               (SELECT mmanl003 FROM mmanl_t ",
                  "                 WHERE mmanlent = dedrent ",
                  "                   AND mmanl001 = dedr010 ",
                  "                   AND mmanl002 ='"||g_dlang||"') dedr010_desc, ", 
                  "               dedr011, ",
                  "               (SELECT oocql004 ",
                  "                  FROM  (SELECT oocqlent,oocql002,oocql004",
                  "                           FROM oocql_t,oocq_t ",
                  "                          WHERE oocqlent = oocqent AND oocql001 = oocq004 AND oocql003 = '",g_dlang,"' ",
                  "                            AND oocq001 = '2049'   AND oocq002 = '09') ",       
                  "                 WHERE oocqlent = dedrent ",
                  "                   AND oocql002 = dedr011) dedr011_desc, ",   
                  "               dedr012,dedr013,dedr017,dedr022, ",
                  "               dedr023,dedr024,dedr018,dedr019, ",
                  "               dedr020,dedr021,dedr027 ",
                  "  FROM dedr_t ",
                  " WHERE dedrent = ? ", 
                  "   AND dedrsite = ?", 
                  "   AND dedr025 = ? ", 
                  "   AND dedr026 = ? ", 
                  "   AND dedr006 = ? ", 
                  "   AND dedr008 = ? ",
                  "   AND dedr009 = ? ",
                  "   AND dedr028 = ? "
      #150826-00013#2 20150908 s983961--mark and mod(e) 效能調整            
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF  
      LET g_sql = g_sql, " ORDER BY dedr_t.dedr010,dedr_t.dedr011"   
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq172_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adeq172_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_dedq_d[g_detail_idx].dedqsite
#                                 ,g_dedq_d[g_detail_idx].dedq034
 
#                                 ,g_dedq_d[g_detail_idx].dedq035
 
#                                 ,g_dedq_d[g_detail_idx].dedq006
 
#                                 ,g_dedq_d[g_detail_idx].dedq008
 
#                                 ,g_dedq_d[g_detail_idx].dedq009
 
#                                 ,g_dedq_d[g_detail_idx].dedq037
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_dedq_d[g_detail_idx].dedqsite   #(ver:42)
                                     ,g_dedq_d[g_detail_idx].dedq034   #(ver:42)
 
                                     ,g_dedq_d[g_detail_idx].dedq035   #(ver:42)
 
                                     ,g_dedq_d[g_detail_idx].dedq006   #(ver:42)
 
                                     ,g_dedq_d[g_detail_idx].dedq008   #(ver:42)
 
                                     ,g_dedq_d[g_detail_idx].dedq009   #(ver:42)
 
                                     ,g_dedq_d[g_detail_idx].dedq037   #(ver:42)
 
 
        INTO g_dedq2_d[l_ac].dedr010,g_dedq2_d[l_ac].dedr010_desc,g_dedq2_d[l_ac].dedr011,g_dedq2_d[l_ac].dedr011_desc, 
            g_dedq2_d[l_ac].dedr012,g_dedq2_d[l_ac].dedr013,g_dedq2_d[l_ac].dedr017,g_dedq2_d[l_ac].dedr022, 
            g_dedq2_d[l_ac].dedr023,g_dedq2_d[l_ac].dedr024,g_dedq2_d[l_ac].dedr018,g_dedq2_d[l_ac].dedr019, 
            g_dedq2_d[l_ac].dedr020,g_dedq2_d[l_ac].dedr021,g_dedq2_d[l_ac].dedr027   #(ver:42)
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
      
      CALL adeq172_detail_show("'2'")      
 
      CALL adeq172_dedr_t_mask()
 
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
   
   CALL g_dedq2_d.deleteElement(g_dedq2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_dedq2_d.getLength()
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
 
{<section id="adeq172.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq172_detail_show(ps_page)
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

      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq_d[l_ac].dedqsite
      #      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq_d[l_ac].dedqsite_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq_d[l_ac].dedqsite_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq_d[l_ac].dedq006
      #      LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2002' AND oocql002=? AND oocql003='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq_d[l_ac].dedq006_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq_d[l_ac].dedq006_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq_d[l_ac].dedq008
      #      LET ls_sql = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq_d[l_ac].dedq008_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq_d[l_ac].dedq008_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq_d[l_ac].dedq009
      #      LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq_d[l_ac].dedq009_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq_d[l_ac].dedq009_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq2_d[l_ac].dedr010
      #      LET ls_sql = "SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq2_d[l_ac].dedr010_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq2_d[l_ac].dedr010_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_dedq2_d[l_ac].dedr011
      #      LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2024' AND oocql002=? AND oocql003='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_dedq2_d[l_ac].dedr011_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_dedq2_d[l_ac].dedr011_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq172_filter()
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
      CONSTRUCT g_wc_filter ON dedqsite,dedq001,dedq034,dedq035,dedq006,dedq008,dedq037,dedq009,dedq010, 
          dedq011,dedq012,dedq013,dedq014,dedq015,dedq016,dedq031,dedq032,dedq033,dedq017,dedq018,dedq019, 
          dedq036,dedq020,dedq021,dedq022,dedq023,dedq024,dedq025,dedq026,dedq027,dedq028,dedq029,dedq030 
 
                          FROM s_detail1[1].b_dedqsite,s_detail1[1].b_dedq001,s_detail1[1].b_dedq034, 
                              s_detail1[1].b_dedq035,s_detail1[1].b_dedq006,s_detail1[1].b_dedq008,s_detail1[1].b_dedq037, 
                              s_detail1[1].b_dedq009,s_detail1[1].b_dedq010,s_detail1[1].b_dedq011,s_detail1[1].b_dedq012, 
                              s_detail1[1].b_dedq013,s_detail1[1].b_dedq014,s_detail1[1].b_dedq015,s_detail1[1].b_dedq016, 
                              s_detail1[1].b_dedq031,s_detail1[1].b_dedq032,s_detail1[1].b_dedq033,s_detail1[1].b_dedq017, 
                              s_detail1[1].b_dedq018,s_detail1[1].b_dedq019,s_detail1[1].b_dedq036,s_detail1[1].b_dedq020, 
                              s_detail1[1].b_dedq021,s_detail1[1].b_dedq022,s_detail1[1].b_dedq023,s_detail1[1].b_dedq024, 
                              s_detail1[1].b_dedq025,s_detail1[1].b_dedq026,s_detail1[1].b_dedq027,s_detail1[1].b_dedq028, 
                              s_detail1[1].b_dedq029,s_detail1[1].b_dedq030
 
         BEFORE CONSTRUCT
                     DISPLAY adeq172_filter_parser('dedqsite') TO s_detail1[1].b_dedqsite
            DISPLAY adeq172_filter_parser('dedq001') TO s_detail1[1].b_dedq001
            DISPLAY adeq172_filter_parser('dedq034') TO s_detail1[1].b_dedq034
            DISPLAY adeq172_filter_parser('dedq035') TO s_detail1[1].b_dedq035
            DISPLAY adeq172_filter_parser('dedq006') TO s_detail1[1].b_dedq006
            DISPLAY adeq172_filter_parser('dedq008') TO s_detail1[1].b_dedq008
            DISPLAY adeq172_filter_parser('dedq037') TO s_detail1[1].b_dedq037
            DISPLAY adeq172_filter_parser('dedq009') TO s_detail1[1].b_dedq009
            DISPLAY adeq172_filter_parser('dedq010') TO s_detail1[1].b_dedq010
            DISPLAY adeq172_filter_parser('dedq011') TO s_detail1[1].b_dedq011
            DISPLAY adeq172_filter_parser('dedq012') TO s_detail1[1].b_dedq012
            DISPLAY adeq172_filter_parser('dedq013') TO s_detail1[1].b_dedq013
            DISPLAY adeq172_filter_parser('dedq014') TO s_detail1[1].b_dedq014
            DISPLAY adeq172_filter_parser('dedq015') TO s_detail1[1].b_dedq015
            DISPLAY adeq172_filter_parser('dedq016') TO s_detail1[1].b_dedq016
            DISPLAY adeq172_filter_parser('dedq031') TO s_detail1[1].b_dedq031
            DISPLAY adeq172_filter_parser('dedq032') TO s_detail1[1].b_dedq032
            DISPLAY adeq172_filter_parser('dedq033') TO s_detail1[1].b_dedq033
            DISPLAY adeq172_filter_parser('dedq017') TO s_detail1[1].b_dedq017
            DISPLAY adeq172_filter_parser('dedq018') TO s_detail1[1].b_dedq018
            DISPLAY adeq172_filter_parser('dedq019') TO s_detail1[1].b_dedq019
            DISPLAY adeq172_filter_parser('dedq036') TO s_detail1[1].b_dedq036
            DISPLAY adeq172_filter_parser('dedq020') TO s_detail1[1].b_dedq020
            DISPLAY adeq172_filter_parser('dedq021') TO s_detail1[1].b_dedq021
            DISPLAY adeq172_filter_parser('dedq022') TO s_detail1[1].b_dedq022
            DISPLAY adeq172_filter_parser('dedq023') TO s_detail1[1].b_dedq023
            DISPLAY adeq172_filter_parser('dedq024') TO s_detail1[1].b_dedq024
            DISPLAY adeq172_filter_parser('dedq025') TO s_detail1[1].b_dedq025
            DISPLAY adeq172_filter_parser('dedq026') TO s_detail1[1].b_dedq026
            DISPLAY adeq172_filter_parser('dedq027') TO s_detail1[1].b_dedq027
            DISPLAY adeq172_filter_parser('dedq028') TO s_detail1[1].b_dedq028
            DISPLAY adeq172_filter_parser('dedq029') TO s_detail1[1].b_dedq029
            DISPLAY adeq172_filter_parser('dedq030') TO s_detail1[1].b_dedq030
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_dedqsite>>----
         #Ctrlp:construct.c.page1.b_dedqsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedqsite
            #add-point:ON ACTION controlp INFIELD b_dedqsite name="construct.c.filter.page1.b_dedqsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'dedqsite',g_site,'c')   #161006-00008#4 by sakura add
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedqsite  #顯示到畫面上
            NEXT FIELD b_dedqsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dedqsite_desc>>----
         #----<<b_dedq001>>----
         #Ctrlp:construct.c.filter.page1.b_dedq001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq001
            #add-point:ON ACTION controlp INFIELD b_dedq001 name="construct.c.filter.page1.b_dedq001"
            
            #END add-point
 
 
         #----<<b_dedq034>>----
         #Ctrlp:construct.c.filter.page1.b_dedq034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq034
            #add-point:ON ACTION controlp INFIELD b_dedq034 name="construct.c.filter.page1.b_dedq034"
            
            #END add-point
 
 
         #----<<b_dedq035>>----
         #Ctrlp:construct.c.filter.page1.b_dedq035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq035
            #add-point:ON ACTION controlp INFIELD b_dedq035 name="construct.c.filter.page1.b_dedq035"
            
            #END add-point
 
 
         #----<<b_dedq006>>----
         #Ctrlp:construct.c.page1.b_dedq006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq006
            #add-point:ON ACTION controlp INFIELD b_dedq006 name="construct.c.filter.page1.b_dedq006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedq006  #顯示到畫面上
            NEXT FIELD b_dedq006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dedq006_desc>>----
         #----<<b_dedq008>>----
         #Ctrlp:construct.c.page1.b_dedq008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq008
            #add-point:ON ACTION controlp INFIELD b_dedq008 name="construct.c.filter.page1.b_dedq008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedq008  #顯示到畫面上
            NEXT FIELD b_dedq008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dedq008_desc>>----
         #----<<b_dedq037>>----
         #Ctrlp:construct.c.filter.page1.b_dedq037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq037
            #add-point:ON ACTION controlp INFIELD b_dedq037 name="construct.c.filter.page1.b_dedq037"
            
            #END add-point
 
 
         #----<<b_dedq009>>----
         #Ctrlp:construct.c.page1.b_dedq009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq009
            #add-point:ON ACTION controlp INFIELD b_dedq009 name="construct.c.filter.page1.b_dedq009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dedq009  #顯示到畫面上
            NEXT FIELD b_dedq009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dedq009_desc>>----
         #----<<b_dedq010>>----
         #Ctrlp:construct.c.filter.page1.b_dedq010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq010
            #add-point:ON ACTION controlp INFIELD b_dedq010 name="construct.c.filter.page1.b_dedq010"
            
            #END add-point
 
 
         #----<<b_dedq011>>----
         #Ctrlp:construct.c.filter.page1.b_dedq011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq011
            #add-point:ON ACTION controlp INFIELD b_dedq011 name="construct.c.filter.page1.b_dedq011"
            
            #END add-point
 
 
         #----<<b_dedq012>>----
         #Ctrlp:construct.c.filter.page1.b_dedq012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq012
            #add-point:ON ACTION controlp INFIELD b_dedq012 name="construct.c.filter.page1.b_dedq012"
            
            #END add-point
 
 
         #----<<b_dedq013>>----
         #Ctrlp:construct.c.filter.page1.b_dedq013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq013
            #add-point:ON ACTION controlp INFIELD b_dedq013 name="construct.c.filter.page1.b_dedq013"
            
            #END add-point
 
 
         #----<<b_dedq014>>----
         #Ctrlp:construct.c.filter.page1.b_dedq014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq014
            #add-point:ON ACTION controlp INFIELD b_dedq014 name="construct.c.filter.page1.b_dedq014"
            
            #END add-point
 
 
         #----<<b_dedq015>>----
         #Ctrlp:construct.c.filter.page1.b_dedq015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq015
            #add-point:ON ACTION controlp INFIELD b_dedq015 name="construct.c.filter.page1.b_dedq015"
            
            #END add-point
 
 
         #----<<b_dedq016>>----
         #Ctrlp:construct.c.filter.page1.b_dedq016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq016
            #add-point:ON ACTION controlp INFIELD b_dedq016 name="construct.c.filter.page1.b_dedq016"
            
            #END add-point
 
 
         #----<<b_dedq031>>----
         #Ctrlp:construct.c.filter.page1.b_dedq031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq031
            #add-point:ON ACTION controlp INFIELD b_dedq031 name="construct.c.filter.page1.b_dedq031"
            
            #END add-point
 
 
         #----<<b_dedq032>>----
         #Ctrlp:construct.c.filter.page1.b_dedq032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq032
            #add-point:ON ACTION controlp INFIELD b_dedq032 name="construct.c.filter.page1.b_dedq032"
            
            #END add-point
 
 
         #----<<b_dedq033>>----
         #Ctrlp:construct.c.filter.page1.b_dedq033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq033
            #add-point:ON ACTION controlp INFIELD b_dedq033 name="construct.c.filter.page1.b_dedq033"
            
            #END add-point
 
 
         #----<<b_dedq017>>----
         #Ctrlp:construct.c.filter.page1.b_dedq017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq017
            #add-point:ON ACTION controlp INFIELD b_dedq017 name="construct.c.filter.page1.b_dedq017"
            
            #END add-point
 
 
         #----<<b_dedq018>>----
         #Ctrlp:construct.c.filter.page1.b_dedq018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq018
            #add-point:ON ACTION controlp INFIELD b_dedq018 name="construct.c.filter.page1.b_dedq018"
            
            #END add-point
 
 
         #----<<b_dedq019>>----
         #Ctrlp:construct.c.filter.page1.b_dedq019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq019
            #add-point:ON ACTION controlp INFIELD b_dedq019 name="construct.c.filter.page1.b_dedq019"
            
            #END add-point
 
 
         #----<<b_dedq036>>----
         #Ctrlp:construct.c.filter.page1.b_dedq036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq036
            #add-point:ON ACTION controlp INFIELD b_dedq036 name="construct.c.filter.page1.b_dedq036"
            
            #END add-point
 
 
         #----<<b_dedq020>>----
         #Ctrlp:construct.c.filter.page1.b_dedq020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq020
            #add-point:ON ACTION controlp INFIELD b_dedq020 name="construct.c.filter.page1.b_dedq020"
            
            #END add-point
 
 
         #----<<b_dedq021>>----
         #Ctrlp:construct.c.filter.page1.b_dedq021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq021
            #add-point:ON ACTION controlp INFIELD b_dedq021 name="construct.c.filter.page1.b_dedq021"
            
            #END add-point
 
 
         #----<<b_dedq022>>----
         #Ctrlp:construct.c.filter.page1.b_dedq022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq022
            #add-point:ON ACTION controlp INFIELD b_dedq022 name="construct.c.filter.page1.b_dedq022"
            
            #END add-point
 
 
         #----<<b_dedq023>>----
         #Ctrlp:construct.c.filter.page1.b_dedq023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq023
            #add-point:ON ACTION controlp INFIELD b_dedq023 name="construct.c.filter.page1.b_dedq023"
            
            #END add-point
 
 
         #----<<b_dedq024>>----
         #Ctrlp:construct.c.filter.page1.b_dedq024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq024
            #add-point:ON ACTION controlp INFIELD b_dedq024 name="construct.c.filter.page1.b_dedq024"
            
            #END add-point
 
 
         #----<<b_dedq025>>----
         #Ctrlp:construct.c.filter.page1.b_dedq025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq025
            #add-point:ON ACTION controlp INFIELD b_dedq025 name="construct.c.filter.page1.b_dedq025"
            
            #END add-point
 
 
         #----<<b_dedq026>>----
         #Ctrlp:construct.c.filter.page1.b_dedq026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq026
            #add-point:ON ACTION controlp INFIELD b_dedq026 name="construct.c.filter.page1.b_dedq026"
            
            #END add-point
 
 
         #----<<b_dedq027>>----
         #Ctrlp:construct.c.filter.page1.b_dedq027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq027
            #add-point:ON ACTION controlp INFIELD b_dedq027 name="construct.c.filter.page1.b_dedq027"
            
            #END add-point
 
 
         #----<<b_dedq028>>----
         #Ctrlp:construct.c.filter.page1.b_dedq028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq028
            #add-point:ON ACTION controlp INFIELD b_dedq028 name="construct.c.filter.page1.b_dedq028"
            
            #END add-point
 
 
         #----<<b_dedq029>>----
         #Ctrlp:construct.c.filter.page1.b_dedq029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq029
            #add-point:ON ACTION controlp INFIELD b_dedq029 name="construct.c.filter.page1.b_dedq029"
            
            #END add-point
 
 
         #----<<b_dedq030>>----
         #Ctrlp:construct.c.filter.page1.b_dedq030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dedq030
            #add-point:ON ACTION controlp INFIELD b_dedq030 name="construct.c.filter.page1.b_dedq030"
            
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
   
      CALL adeq172_filter_show('dedqsite','b_dedqsite')
   CALL adeq172_filter_show('dedq001','b_dedq001')
   CALL adeq172_filter_show('dedq034','b_dedq034')
   CALL adeq172_filter_show('dedq035','b_dedq035')
   CALL adeq172_filter_show('dedq006','b_dedq006')
   CALL adeq172_filter_show('dedq008','b_dedq008')
   CALL adeq172_filter_show('dedq037','b_dedq037')
   CALL adeq172_filter_show('dedq009','b_dedq009')
   CALL adeq172_filter_show('dedq010','b_dedq010')
   CALL adeq172_filter_show('dedq011','b_dedq011')
   CALL adeq172_filter_show('dedq012','b_dedq012')
   CALL adeq172_filter_show('dedq013','b_dedq013')
   CALL adeq172_filter_show('dedq014','b_dedq014')
   CALL adeq172_filter_show('dedq015','b_dedq015')
   CALL adeq172_filter_show('dedq016','b_dedq016')
   CALL adeq172_filter_show('dedq031','b_dedq031')
   CALL adeq172_filter_show('dedq032','b_dedq032')
   CALL adeq172_filter_show('dedq033','b_dedq033')
   CALL adeq172_filter_show('dedq017','b_dedq017')
   CALL adeq172_filter_show('dedq018','b_dedq018')
   CALL adeq172_filter_show('dedq019','b_dedq019')
   CALL adeq172_filter_show('dedq036','b_dedq036')
   CALL adeq172_filter_show('dedq020','b_dedq020')
   CALL adeq172_filter_show('dedq021','b_dedq021')
   CALL adeq172_filter_show('dedq022','b_dedq022')
   CALL adeq172_filter_show('dedq023','b_dedq023')
   CALL adeq172_filter_show('dedq024','b_dedq024')
   CALL adeq172_filter_show('dedq025','b_dedq025')
   CALL adeq172_filter_show('dedq026','b_dedq026')
   CALL adeq172_filter_show('dedq027','b_dedq027')
   CALL adeq172_filter_show('dedq028','b_dedq028')
   CALL adeq172_filter_show('dedq029','b_dedq029')
   CALL adeq172_filter_show('dedq030','b_dedq030')
   CALL adeq172_filter_show('dedr010','b_dedr010')
   CALL adeq172_filter_show('dedr011','b_dedr011')
   CALL adeq172_filter_show('dedr012','b_dedr012')
   CALL adeq172_filter_show('dedr013','b_dedr013')
   CALL adeq172_filter_show('dedr017','b_dedr017')
   CALL adeq172_filter_show('dedr022','b_dedr022')
   CALL adeq172_filter_show('dedr023','b_dedr023')
   CALL adeq172_filter_show('dedr024','b_dedr024')
   CALL adeq172_filter_show('dedr018','b_dedr018')
   CALL adeq172_filter_show('dedr019','b_dedr019')
   CALL adeq172_filter_show('dedr020','b_dedr020')
   CALL adeq172_filter_show('dedr021','b_dedr021')
   CALL adeq172_filter_show('dedr027','b_dedr027')
 
    
   CALL adeq172_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq172_filter_parser(ps_field)
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
 
{<section id="adeq172.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq172_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq172_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.insert" >}
#+ insert
PRIVATE FUNCTION adeq172_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq172.modify" >}
#+ modify
PRIVATE FUNCTION adeq172_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq172_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.delete" >}
#+ delete
PRIVATE FUNCTION adeq172_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq172.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq172_detail_action_trans()
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
 
{<section id="adeq172.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq172_detail_index_setting()
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
            IF g_dedq_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_dedq_d.getLength() AND g_dedq_d.getLength() > 0
            LET g_detail_idx = g_dedq_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_dedq_d.getLength() THEN
               LET g_detail_idx = g_dedq_d.getLength()
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
 
{<section id="adeq172.mask_functions" >}
 &include "erp/ade/adeq172_mask.4gl"
 
{</section>}
 
{<section id="adeq172.other_function" readonly="Y" >}

 
{</section>}
 
