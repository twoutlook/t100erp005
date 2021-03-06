#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq610.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-07-06 10:52:11), PR版次:0008(2016-10-18 10:19:50)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000082
#+ Filename...: adeq610
#+ Description: 經銷商日銷售查詢作業
#+ Creator....: 04226(2014-07-14 15:46:35)
#+ Modifier...: 06815 -SD/PR- 06137
 
{</section>}
 
{<section id="adeq610.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#6   2016/10/18  by 06137       組織類型與職能開窗清單調整
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
PRIVATE TYPE type_g_dema_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   demasite LIKE dema_t.demasite, 
   demasite_desc LIKE type_t.chr500, 
   dema001 LIKE dema_t.dema001, 
   dema002 LIKE dema_t.dema002, 
   dema003 LIKE dema_t.dema003, 
   dema004 LIKE dema_t.dema004, 
   dema005 LIKE dema_t.dema005, 
   dema005_desc LIKE type_t.chr500, 
   dema006 LIKE dema_t.dema006, 
   dema007 LIKE dema_t.dema007, 
   dema008 LIKE dema_t.dema008, 
   dema008_desc LIKE type_t.chr500, 
   dema009 LIKE dema_t.dema009, 
   dema009_desc LIKE type_t.chr500, 
   dema010 LIKE dema_t.dema010, 
   dema010_desc LIKE type_t.chr500, 
   dema011 LIKE dema_t.dema011, 
   dema011_desc LIKE type_t.chr500, 
   dema012 LIKE dema_t.dema012, 
   dema012_desc LIKE type_t.chr500, 
   dema013 LIKE dema_t.dema013, 
   dema014 LIKE dema_t.dema014, 
   dema015 LIKE dema_t.dema015, 
   dema016 LIKE dema_t.dema016, 
   dema017 LIKE dema_t.dema017, 
   dema018 LIKE dema_t.dema018, 
   dema019 LIKE dema_t.dema019, 
   dema020 LIKE dema_t.dema020, 
   dema021 LIKE dema_t.dema021, 
   dema022 LIKE dema_t.dema022, 
   dema023 LIKE dema_t.dema023, 
   dema024 LIKE dema_t.dema024, 
   dema025 LIKE dema_t.dema025, 
   dema026 LIKE dema_t.dema026, 
   dema027 LIKE dema_t.dema027, 
   dema028 LIKE dema_t.dema028, 
   dema029 LIKE dema_t.dema029, 
   dema030 LIKE dema_t.dema030, 
   dema031 LIKE dema_t.dema031, 
   dema032 LIKE dema_t.dema032, 
   dema033 LIKE dema_t.dema033, 
   dema034 LIKE dema_t.dema034, 
   dema035 LIKE dema_t.dema035, 
   dema036 LIKE dema_t.dema036, 
   dema037 LIKE dema_t.dema037 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_dema_d
DEFINE g_master_t                   type_g_dema_d
DEFINE g_dema_d          DYNAMIC ARRAY OF type_g_dema_d
DEFINE g_dema_d_t        type_g_dema_d
 
      
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
 
{<section id="adeq610.main" >}
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
   DECLARE adeq610_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq610_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq610_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq610 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq610_init()   
 
      #進入選單 Menu (="N")
      CALL adeq610_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq610
      
   END IF 
   
   CLOSE adeq610_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq610.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq610_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_dema001','2040') 
   CALL cl_set_combo_scc('b_dema007','6013') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309
   #end add-point
 
   CALL adeq610_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq610.default_search" >}
PRIVATE FUNCTION adeq610_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " demasite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " dema002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " dema005 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " dema006 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " dema007 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " dema008 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " dema009 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " dema010 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " dema011 = '", g_argv[09], "' AND "
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
 
{<section id="adeq610.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq610_ui_dialog()
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
      CALL adeq610_b_fill()
   ELSE
      CALL adeq610_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_dema_d.clear()
 
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
 
         CALL adeq610_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_dema_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq610_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq610_detail_action_trans()
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
            CALL adeq610_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) #sakura add 
            CALL cl_set_comp_visible("sel", FALSE)                     #sakura add
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq610_insert()
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
               CALL adeq610_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG #sakura add
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
            CALL adeq610_filter()
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
            CALL adeq610_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_dema_d)
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
            CALL adeq610_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq610_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq610_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq610_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_dema_d.getLength()
               LET g_dema_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_dema_d.getLength()
               LET g_dema_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_dema_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_dema_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_dema_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_dema_d[li_idx].sel = "N"
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
 
{<section id="adeq610.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq610_query()
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
   CALL g_dema_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON demasite,dema001,dema002,dema003,dema004,dema005,dema006,dema007,dema008, 
          dema009,dema010,dema011,dema012,dema013,dema014,dema015,dema016,dema017,dema018,dema019,dema020, 
          dema021,dema022,dema023,dema024,dema025,dema026,dema027,dema028,dema029,dema030,dema031,dema032, 
          dema033,dema034,dema035,dema036,dema037
           FROM s_detail1[1].b_demasite,s_detail1[1].b_dema001,s_detail1[1].b_dema002,s_detail1[1].b_dema003, 
               s_detail1[1].b_dema004,s_detail1[1].b_dema005,s_detail1[1].b_dema006,s_detail1[1].b_dema007, 
               s_detail1[1].b_dema008,s_detail1[1].b_dema009,s_detail1[1].b_dema010,s_detail1[1].b_dema011, 
               s_detail1[1].b_dema012,s_detail1[1].b_dema013,s_detail1[1].b_dema014,s_detail1[1].b_dema015, 
               s_detail1[1].b_dema016,s_detail1[1].b_dema017,s_detail1[1].b_dema018,s_detail1[1].b_dema019, 
               s_detail1[1].b_dema020,s_detail1[1].b_dema021,s_detail1[1].b_dema022,s_detail1[1].b_dema023, 
               s_detail1[1].b_dema024,s_detail1[1].b_dema025,s_detail1[1].b_dema026,s_detail1[1].b_dema027, 
               s_detail1[1].b_dema028,s_detail1[1].b_dema029,s_detail1[1].b_dema030,s_detail1[1].b_dema031, 
               s_detail1[1].b_dema032,s_detail1[1].b_dema033,s_detail1[1].b_dema034,s_detail1[1].b_dema035, 
               s_detail1[1].b_dema036,s_detail1[1].b_dema037
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO b_demasite    #2015/11/6 s983961 無法使用QBE修正
            DISPLAY g_today-1 TO b_dema002  #2015/12/2 s983961 QBE預設欄位/值應和其他adeq* 一致
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_demasite>>----
         #Ctrlp:construct.c.page1.b_demasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_demasite
            #add-point:ON ACTION controlp INFIELD b_demasite name="construct.c.page1.b_demasite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'demasite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_demasite  #顯示到畫面上
            NEXT FIELD b_demasite                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_demasite
            #add-point:BEFORE FIELD b_demasite name="construct.b.page1.b_demasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_demasite
            
            #add-point:AFTER FIELD b_demasite name="construct.a.page1.b_demasite"
            
            #END add-point
            
 
 
         #----<<b_demasite_desc>>----
         #----<<b_dema001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema001
            #add-point:BEFORE FIELD b_dema001 name="construct.b.page1.b_dema001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema001
            
            #add-point:AFTER FIELD b_dema001 name="construct.a.page1.b_dema001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema001
            #add-point:ON ACTION controlp INFIELD b_dema001 name="construct.c.page1.b_dema001"
            
            #END add-point
 
 
         #----<<b_dema002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema002
            #add-point:BEFORE FIELD b_dema002 name="construct.b.page1.b_dema002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema002
            
            #add-point:AFTER FIELD b_dema002 name="construct.a.page1.b_dema002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema002
            #add-point:ON ACTION controlp INFIELD b_dema002 name="construct.c.page1.b_dema002"
            
            #END add-point
 
 
         #----<<b_dema003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema003
            #add-point:BEFORE FIELD b_dema003 name="construct.b.page1.b_dema003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema003
            
            #add-point:AFTER FIELD b_dema003 name="construct.a.page1.b_dema003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema003
            #add-point:ON ACTION controlp INFIELD b_dema003 name="construct.c.page1.b_dema003"
            
            #END add-point
 
 
         #----<<b_dema004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema004
            #add-point:BEFORE FIELD b_dema004 name="construct.b.page1.b_dema004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema004
            
            #add-point:AFTER FIELD b_dema004 name="construct.a.page1.b_dema004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema004
            #add-point:ON ACTION controlp INFIELD b_dema004 name="construct.c.page1.b_dema004"
            
            #END add-point
 
 
         #----<<b_dema005>>----
         #Ctrlp:construct.c.page1.b_dema005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema005
            #add-point:ON ACTION controlp INFIELD b_dema005 name="construct.c.page1.b_dema005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_21()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema005  #顯示到畫面上
            NEXT FIELD b_dema005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema005
            #add-point:BEFORE FIELD b_dema005 name="construct.b.page1.b_dema005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema005
            
            #add-point:AFTER FIELD b_dema005 name="construct.a.page1.b_dema005"
            
            #END add-point
            
 
 
         #----<<b_dema005_desc>>----
         #----<<b_dema006>>----
         #Ctrlp:construct.c.page1.b_dema006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema006
            #add-point:ON ACTION controlp INFIELD b_dema006 name="construct.c.page1.b_dema006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_stce001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema006  #顯示到畫面上
            NEXT FIELD b_dema006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema006
            #add-point:BEFORE FIELD b_dema006 name="construct.b.page1.b_dema006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema006
            
            #add-point:AFTER FIELD b_dema006 name="construct.a.page1.b_dema006"
            
            #END add-point
            
 
 
         #----<<b_dema007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema007
            #add-point:BEFORE FIELD b_dema007 name="construct.b.page1.b_dema007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema007
            
            #add-point:AFTER FIELD b_dema007 name="construct.a.page1.b_dema007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema007
            #add-point:ON ACTION controlp INFIELD b_dema007 name="construct.c.page1.b_dema007"
            
            #END add-point
 
 
         #----<<b_dema008>>----
         #Ctrlp:construct.c.page1.b_dema008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema008
            #add-point:ON ACTION controlp INFIELD b_dema008 name="construct.c.page1.b_dema008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2060'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema008  #顯示到畫面上
            NEXT FIELD b_dema008                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema008
            #add-point:BEFORE FIELD b_dema008 name="construct.b.page1.b_dema008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema008
            
            #add-point:AFTER FIELD b_dema008 name="construct.a.page1.b_dema008"
            
            #END add-point
            
 
 
         #----<<b_dema008_desc>>----
         #----<<b_dema009>>----
         #Ctrlp:construct.c.page1.b_dema009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema009
            #add-point:ON ACTION controlp INFIELD b_dema009 name="construct.c.page1.b_dema009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema009  #顯示到畫面上
            NEXT FIELD b_dema009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema009
            #add-point:BEFORE FIELD b_dema009 name="construct.b.page1.b_dema009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema009
            
            #add-point:AFTER FIELD b_dema009 name="construct.a.page1.b_dema009"
            
            #END add-point
            
 
 
         #----<<b_dema009_desc>>----
         #----<<b_dema010>>----
         #Ctrlp:construct.c.page1.b_dema010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema010
            #add-point:ON ACTION controlp INFIELD b_dema010 name="construct.c.page1.b_dema010"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema010  #顯示到畫面上
            NEXT FIELD b_dema010                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema010
            #add-point:BEFORE FIELD b_dema010 name="construct.b.page1.b_dema010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema010
            
            #add-point:AFTER FIELD b_dema010 name="construct.a.page1.b_dema010"
            
            #END add-point
            
 
 
         #----<<b_dema010_desc>>----
         #----<<b_dema011>>----
         #Ctrlp:construct.c.page1.b_dema011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema011
            #add-point:ON ACTION controlp INFIELD b_dema011 name="construct.c.page1.b_dema011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_4()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema011  #顯示到畫面上
            NEXT FIELD b_dema011                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema011
            #add-point:BEFORE FIELD b_dema011 name="construct.b.page1.b_dema011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema011
            
            #add-point:AFTER FIELD b_dema011 name="construct.a.page1.b_dema011"
            
            #END add-point
            
 
 
         #----<<b_dema011_desc>>----
         #----<<b_dema012>>----
         #Ctrlp:construct.c.page1.b_dema012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema012
            #add-point:ON ACTION controlp INFIELD b_dema012 name="construct.c.page1.b_dema012"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema012  #顯示到畫面上
            NEXT FIELD b_dema012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema012
            #add-point:BEFORE FIELD b_dema012 name="construct.b.page1.b_dema012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema012
            
            #add-point:AFTER FIELD b_dema012 name="construct.a.page1.b_dema012"
            
            #END add-point
            
 
 
         #----<<b_dema012_desc>>----
         #----<<b_dema013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema013
            #add-point:BEFORE FIELD b_dema013 name="construct.b.page1.b_dema013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema013
            
            #add-point:AFTER FIELD b_dema013 name="construct.a.page1.b_dema013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema013
            #add-point:ON ACTION controlp INFIELD b_dema013 name="construct.c.page1.b_dema013"
            
            #END add-point
 
 
         #----<<b_dema014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema014
            #add-point:BEFORE FIELD b_dema014 name="construct.b.page1.b_dema014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema014
            
            #add-point:AFTER FIELD b_dema014 name="construct.a.page1.b_dema014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema014
            #add-point:ON ACTION controlp INFIELD b_dema014 name="construct.c.page1.b_dema014"
            
            #END add-point
 
 
         #----<<b_dema015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema015
            #add-point:BEFORE FIELD b_dema015 name="construct.b.page1.b_dema015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema015
            
            #add-point:AFTER FIELD b_dema015 name="construct.a.page1.b_dema015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema015
            #add-point:ON ACTION controlp INFIELD b_dema015 name="construct.c.page1.b_dema015"
            
            #END add-point
 
 
         #----<<b_dema016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema016
            #add-point:BEFORE FIELD b_dema016 name="construct.b.page1.b_dema016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema016
            
            #add-point:AFTER FIELD b_dema016 name="construct.a.page1.b_dema016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema016
            #add-point:ON ACTION controlp INFIELD b_dema016 name="construct.c.page1.b_dema016"
            
            #END add-point
 
 
         #----<<b_dema017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema017
            #add-point:BEFORE FIELD b_dema017 name="construct.b.page1.b_dema017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema017
            
            #add-point:AFTER FIELD b_dema017 name="construct.a.page1.b_dema017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema017
            #add-point:ON ACTION controlp INFIELD b_dema017 name="construct.c.page1.b_dema017"
            
            #END add-point
 
 
         #----<<b_dema018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema018
            #add-point:BEFORE FIELD b_dema018 name="construct.b.page1.b_dema018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema018
            
            #add-point:AFTER FIELD b_dema018 name="construct.a.page1.b_dema018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema018
            #add-point:ON ACTION controlp INFIELD b_dema018 name="construct.c.page1.b_dema018"
            
            #END add-point
 
 
         #----<<b_dema019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema019
            #add-point:BEFORE FIELD b_dema019 name="construct.b.page1.b_dema019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema019
            
            #add-point:AFTER FIELD b_dema019 name="construct.a.page1.b_dema019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema019
            #add-point:ON ACTION controlp INFIELD b_dema019 name="construct.c.page1.b_dema019"
            
            #END add-point
 
 
         #----<<b_dema020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema020
            #add-point:BEFORE FIELD b_dema020 name="construct.b.page1.b_dema020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema020
            
            #add-point:AFTER FIELD b_dema020 name="construct.a.page1.b_dema020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema020
            #add-point:ON ACTION controlp INFIELD b_dema020 name="construct.c.page1.b_dema020"
            
            #END add-point
 
 
         #----<<b_dema021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema021
            #add-point:BEFORE FIELD b_dema021 name="construct.b.page1.b_dema021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema021
            
            #add-point:AFTER FIELD b_dema021 name="construct.a.page1.b_dema021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema021
            #add-point:ON ACTION controlp INFIELD b_dema021 name="construct.c.page1.b_dema021"
            
            #END add-point
 
 
         #----<<b_dema022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema022
            #add-point:BEFORE FIELD b_dema022 name="construct.b.page1.b_dema022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema022
            
            #add-point:AFTER FIELD b_dema022 name="construct.a.page1.b_dema022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema022
            #add-point:ON ACTION controlp INFIELD b_dema022 name="construct.c.page1.b_dema022"
            
            #END add-point
 
 
         #----<<b_dema023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema023
            #add-point:BEFORE FIELD b_dema023 name="construct.b.page1.b_dema023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema023
            
            #add-point:AFTER FIELD b_dema023 name="construct.a.page1.b_dema023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema023
            #add-point:ON ACTION controlp INFIELD b_dema023 name="construct.c.page1.b_dema023"
            
            #END add-point
 
 
         #----<<b_dema024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema024
            #add-point:BEFORE FIELD b_dema024 name="construct.b.page1.b_dema024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema024
            
            #add-point:AFTER FIELD b_dema024 name="construct.a.page1.b_dema024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema024
            #add-point:ON ACTION controlp INFIELD b_dema024 name="construct.c.page1.b_dema024"
            
            #END add-point
 
 
         #----<<b_dema025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema025
            #add-point:BEFORE FIELD b_dema025 name="construct.b.page1.b_dema025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema025
            
            #add-point:AFTER FIELD b_dema025 name="construct.a.page1.b_dema025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema025
            #add-point:ON ACTION controlp INFIELD b_dema025 name="construct.c.page1.b_dema025"
            
            #END add-point
 
 
         #----<<b_dema026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema026
            #add-point:BEFORE FIELD b_dema026 name="construct.b.page1.b_dema026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema026
            
            #add-point:AFTER FIELD b_dema026 name="construct.a.page1.b_dema026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema026
            #add-point:ON ACTION controlp INFIELD b_dema026 name="construct.c.page1.b_dema026"
            
            #END add-point
 
 
         #----<<b_dema027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema027
            #add-point:BEFORE FIELD b_dema027 name="construct.b.page1.b_dema027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema027
            
            #add-point:AFTER FIELD b_dema027 name="construct.a.page1.b_dema027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema027
            #add-point:ON ACTION controlp INFIELD b_dema027 name="construct.c.page1.b_dema027"
            
            #END add-point
 
 
         #----<<b_dema028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema028
            #add-point:BEFORE FIELD b_dema028 name="construct.b.page1.b_dema028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema028
            
            #add-point:AFTER FIELD b_dema028 name="construct.a.page1.b_dema028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema028
            #add-point:ON ACTION controlp INFIELD b_dema028 name="construct.c.page1.b_dema028"
            
            #END add-point
 
 
         #----<<b_dema029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema029
            #add-point:BEFORE FIELD b_dema029 name="construct.b.page1.b_dema029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema029
            
            #add-point:AFTER FIELD b_dema029 name="construct.a.page1.b_dema029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema029
            #add-point:ON ACTION controlp INFIELD b_dema029 name="construct.c.page1.b_dema029"
            
            #END add-point
 
 
         #----<<b_dema030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema030
            #add-point:BEFORE FIELD b_dema030 name="construct.b.page1.b_dema030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema030
            
            #add-point:AFTER FIELD b_dema030 name="construct.a.page1.b_dema030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema030
            #add-point:ON ACTION controlp INFIELD b_dema030 name="construct.c.page1.b_dema030"
            
            #END add-point
 
 
         #----<<b_dema031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema031
            #add-point:BEFORE FIELD b_dema031 name="construct.b.page1.b_dema031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema031
            
            #add-point:AFTER FIELD b_dema031 name="construct.a.page1.b_dema031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema031
            #add-point:ON ACTION controlp INFIELD b_dema031 name="construct.c.page1.b_dema031"
            
            #END add-point
 
 
         #----<<b_dema032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema032
            #add-point:BEFORE FIELD b_dema032 name="construct.b.page1.b_dema032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema032
            
            #add-point:AFTER FIELD b_dema032 name="construct.a.page1.b_dema032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema032
            #add-point:ON ACTION controlp INFIELD b_dema032 name="construct.c.page1.b_dema032"
            
            #END add-point
 
 
         #----<<b_dema033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema033
            #add-point:BEFORE FIELD b_dema033 name="construct.b.page1.b_dema033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema033
            
            #add-point:AFTER FIELD b_dema033 name="construct.a.page1.b_dema033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema033
            #add-point:ON ACTION controlp INFIELD b_dema033 name="construct.c.page1.b_dema033"
            
            #END add-point
 
 
         #----<<b_dema034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema034
            #add-point:BEFORE FIELD b_dema034 name="construct.b.page1.b_dema034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema034
            
            #add-point:AFTER FIELD b_dema034 name="construct.a.page1.b_dema034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema034
            #add-point:ON ACTION controlp INFIELD b_dema034 name="construct.c.page1.b_dema034"
            
            #END add-point
 
 
         #----<<b_dema035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema035
            #add-point:BEFORE FIELD b_dema035 name="construct.b.page1.b_dema035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema035
            
            #add-point:AFTER FIELD b_dema035 name="construct.a.page1.b_dema035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema035
            #add-point:ON ACTION controlp INFIELD b_dema035 name="construct.c.page1.b_dema035"
            
            #END add-point
 
 
         #----<<b_dema036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema036
            #add-point:BEFORE FIELD b_dema036 name="construct.b.page1.b_dema036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema036
            
            #add-point:AFTER FIELD b_dema036 name="construct.a.page1.b_dema036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema036
            #add-point:ON ACTION controlp INFIELD b_dema036 name="construct.c.page1.b_dema036"
            
            #END add-point
 
 
         #----<<b_dema037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_dema037
            #add-point:BEFORE FIELD b_dema037 name="construct.b.page1.b_dema037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_dema037
            
            #add-point:AFTER FIELD b_dema037 name="construct.a.page1.b_dema037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_dema037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema037
            #add-point:ON ACTION controlp INFIELD b_dema037 name="construct.c.page1.b_dema037"
            
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
   CALL adeq610_b_fill()
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
 
{<section id="adeq610.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq610_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   CALL s_aooi500_sql_where(g_prog,'demasite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',demasite,'',dema001,dema002,dema003,dema004,dema005,'',dema006, 
       dema007,dema008,'',dema009,'',dema010,'',dema011,'',dema012,'',dema013,dema014,dema015,dema016, 
       dema017,dema018,dema019,dema020,dema021,dema022,dema023,dema024,dema025,dema026,dema027,dema028, 
       dema029,dema030,dema031,dema032,dema033,dema034,dema035,dema036,dema037  ,DENSE_RANK() OVER( ORDER BY dema_t.demasite, 
       dema_t.dema002,dema_t.dema005,dema_t.dema006,dema_t.dema007,dema_t.dema008,dema_t.dema009,dema_t.dema010, 
       dema_t.dema011) AS RANK FROM dema_t",
 
 
                     "",
                     " WHERE demaent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("dema_t"),
                     " ORDER BY dema_t.demasite,dema_t.dema002,dema_t.dema005,dema_t.dema006,dema_t.dema007,dema_t.dema008,dema_t.dema009,dema_t.dema010,dema_t.dema011"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)  
   LET ls_sql_rank = "SELECT UNIQUE '', ",
               "              demasite,    ",
               "              (SELECT ooefl003",
               "                 FROM ooefl_t",
               "                WHERE ooeflent = demaent AND ooefl001 = demasite ",
               "                  AND ooefl002 = '",g_dlang,"') demasite_desc,",
               "              dema001,dema002,dema003,dema004,dema005, ",
               "              (SELECT pmaal004",
               "                 FROM pmaal_t",
               "                WHERE pmaalent = demaent AND pmaal001 = dema005  ",
               "                  AND pmaal002 = '",g_dlang,"') dema005_desc,",
               "              dema006,dema007, dema008,",
               "              (SELECT oocql004",
               "                 FROM oocql_t",
               "                WHERE oocqlent = demaent AND oocql001 = '2060'   ",
               "                  AND oocql002 = dema008 AND oocql003 = '",g_dlang,"') dema008_desc,",
               "              dema009,",
               "              (SELECT staal003",
               "                 FROM staal_t",
               "                WHERE staalent = demaent AND staal001 = dema009 ",
               "                  AND staal002 = '",g_dlang,"') dema009_desc,",
               "              dema010,",
               "              (SELECT oocql004",
               "                 FROM oocql_t",
               "                WHERE oocqlent = demaent AND oocql001 = '2002'  ",
               "                  AND oocql002 = dema010 AND oocql003 = '",g_dlang,"') dema010_desc,",
               "              dema011,t6.oodbl004 dema011_desc, dema012,",
               "              (SELECT ooail003",
               "                 FROM ooail_t",
               "                WHERE ooailent = demaent AND ooail001 = dema012 ",
               "                  AND ooail002 = '",g_dlang,"') dema012_desc,",
               "              dema013,     dema014,     dema015,     dema016,     dema017, ",
               "              dema018,     dema019,     dema020,     dema021,     dema022, ",
               "              dema023,     dema024,     dema025,     dema026,     dema027, ",
               "              dema028,     dema029,     dema030,     dema031,     dema032, ",
               "              dema033,     dema034,     dema035,     dema036,     dema037, ",
               " DENSE_RANK() OVER( ORDER BY dema_t.demasite,dema_t.dema002,dema_t.dema005,",
               "dema_t.dema006,dema_t.dema007,dema_t.dema008,dema_t.dema009,dema_t.dema010,",
               "dema_t.dema011) AS RANK",
               "  FROM dema_t",
               "       LEFT JOIN (SELECT oodblent,ooef001,oodbl002,oodbl003,oodbl004 ",
               "                    FROM ooef_t,oodbl_t WHERE ooefent = oodblent AND ooef019 = oodbl001) t6 ",
               "              ON t6.oodblent = demaent AND t6.ooef001 = demasite AND t6.oodbl002 = dema011 AND t6.oodbl003 = '",g_dlang,"' ",
               " WHERE demaent = ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("dema_t")   
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)   
   
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("dema_t"),
               "   AND EXISTS (SELECT 1",
               "                 FROM ooed_t ",
               "                WHERE ooedent = demaent",
               "                  AND ooed001 = '9' ",
               "                  AND ooed004 = demasite",
               "                  AND ooed006 <= '",g_today,"'",
               "                  AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "                  AND ooed004 IN (SELECT ooed004 FROM ooed_t  ",
               "                                   START WITH ooed005 = '",g_site,"'",
               "                                     AND ooed001 = '9' ",
               "                                     AND ooed006 <= '",g_today,"'",
               "                                     AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "                                 CONNECT BY NOCYCLE PRIOR ooed004 = ooed005 ",
               "                                                      AND ooed001 = '9' ",
               "                                                      AND ooed006 <= '",g_today,"'",
               "                                                      AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
               "                                   UNION ",
               "                                  SELECT ooed004 FROM ooed_t ",
               "                                   WHERE ooed004 = '",g_site,"'))",
               " ORDER BY dema_t.demasite,dema_t.dema002,dema_t.dema005,dema_t.dema006,dema_t.dema007,dema_t.dema008,dema_t.dema009,dema_t.dema010,dema_t.dema011"
   #150826-00013#1 效能調整 20150910 add by beckxie---E
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
 
   LET g_sql = "SELECT '',demasite,'',dema001,dema002,dema003,dema004,dema005,'',dema006,dema007,dema008, 
       '',dema009,'',dema010,'',dema011,'',dema012,'',dema013,dema014,dema015,dema016,dema017,dema018, 
       dema019,dema020,dema021,dema022,dema023,dema024,dema025,dema026,dema027,dema028,dema029,dema030, 
       dema031,dema032,dema033,dema034,dema035,dema036,dema037",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S) 
   #LET g_sql = "SELECT UNIQUE '',demasite,'',dema001,dema002,",
   #            "              dema003,dema004,dema005,'',dema006,",
   #            "              dema007,dema008,'',dema009,'',",
   #            "              dema010,'',dema011,'',dema012,",
   #            "              '',dema013,dema014,dema015,dema016,",
   #            "              dema017,dema018,dema019,dema020,dema021,",
   #            "              dema022,dema023,dema024,dema025,dema026,",
   #            "              dema027,dema028,dema029,dema030,dema031,",
   #            "              dema032,dema033,dema034,dema035,dema036,",
   #            "              dema037",
   #            "  FROM dema_t",
   #            " WHERE demaent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("dema_t")
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E) 
   #150826-00013#1 效能調整 20150910 mark by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)  
   #LET g_sql = "SELECT UNIQUE '', ",
   #            "              demasite,    t1.ooefl003, dema001,     dema002,     dema003, ",
   #            "              dema004,     dema005,     t2.pmaal004, dema006,     dema007, ",
   #            "              dema008,     t3.oocql004, dema009,     t4.staal003, dema010,",
   #            "              t5.oocql004, dema011,     t6.oodbl004, dema012,     t7.ooail003, ",
   #            "              dema013,     dema014,     dema015,     dema016,     dema017, ",
   #            "              dema018,     dema019,     dema020,     dema021,     dema022, ",
   #            "              dema023,     dema024,     dema025,     dema026,     dema027, ",
   #            "              dema028,     dema029,     dema030,     dema031,     dema032, ",
   #            "              dema033,     dema034,     dema035,     dema036,     dema037  ",
   #            "  FROM dema_t",
   #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = demaent AND t1.ooefl001 = demasite AND t1.ooefl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN pmaal_t t2 ON t2.pmaalent = demaent AND t2.pmaal001 = dema005  AND t2.pmaal002 = '",g_dlang,"' ",
   #            "       LEFT JOIN oocql_t t3 ON t3.oocqlent = demaent AND t3.oocql001 = '2060'   AND t3.oocql002 = dema008 AND t3.oocql003 = '",g_dlang,"' ",
   #            "       LEFT JOIN staal_t t4 ON t4.staalent = demaent AND t4.staal001 = dema009  AND t4.staal002 = '",g_dlang,"' ",
   #            "       LEFT JOIN oocql_t t5 ON t5.oocqlent = demaent AND t5.oocql001 = '2002'   AND t5.oocql002 = dema010 AND t5.oocql003 = '",g_dlang,"' ",
   #            "       LEFT JOIN (SELECT oodblent,ooef001,oodbl002,oodbl003,oodbl004 ",
   #            "                    FROM ooef_t,oodbl_t WHERE ooefent = oodblent AND ooef019 = oodbl001) t6 ",
   #            "              ON t6.oodblent = demaent AND t6.ooef001 = demasite AND t6.oodbl002 = dema011 AND t6.oodbl003 = '",g_dlang,"' ",
   #            "       LEFT JOIN ooail_t t7 ON t7.ooailent = demaent AND t7.ooail001 = dema012  AND t7.ooail002 = '",g_dlang,"' ",
   #            " WHERE demaent = ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("dema_t")   
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)   
   #
   #LET g_sql = g_sql, cl_sql_add_filter("dema_t"),
   #            "   AND EXISTS (SELECT 1",
   #            "                 FROM ooed_t ",
   #            "                WHERE ooedent = demaent",
   #            "                  AND ooed001 = '9' ",
   #            "                  AND ooed004 = demasite",
   #            "                  AND ooed006 <= '",g_today,"'",
   #            "                  AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
   #            "                  AND ooed004 IN (SELECT ooed004 FROM ooed_t  ",
   #            "                                   START WITH ooed005 = '",g_site,"'",
   #            "                                     AND ooed001 = '9' ",
   #            "                                     AND ooed006 <= '",g_today,"'",
   #            "                                     AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
   #            "                                 CONNECT BY NOCYCLE PRIOR ooed004 = ooed005 ",
   #            "                                                      AND ooed001 = '9' ",
   #            "                                                      AND ooed006 <= '",g_today,"'",
   #            "                                                      AND (ooed007 >= '",g_today,"' OR ooed007 IS NULL) ",
   #            "                                   UNION ",
   #            "                                  SELECT ooed004 FROM ooed_t ",
   #            "                                   WHERE ooed004 = '",g_site,"'))",
   #            " ORDER BY dema_t.demasite,dema_t.dema002,dema_t.dema005,dema_t.dema006,dema_t.dema007,dema_t.dema008,dema_t.dema009,dema_t.dema010,dema_t.dema011"
   #150826-00013#1 效能調整 20150910 mark by beckxie---E
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   LET g_sql = "SELECT 'N',demasite,demasite_desc,dema001,dema002,dema003,dema004,dema005,dema005_desc,dema006,dema007,dema008, 
       dema008_desc,dema009,dema009_desc,dema010,dema010_desc,dema011,dema011_desc,dema012,dema012_desc,dema013,dema014,dema015,dema016,dema017,dema018, 
       dema019,dema020,dema021,dema022,dema023,dema024,dema025,dema026,dema027,dema028,dema029,dema030, 
       dema031,dema032,dema033,dema034,dema035,dema036,dema037",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150910 add by beckxie---E             
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq610_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq610_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_dema_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_dema_d[l_ac].sel,g_dema_d[l_ac].demasite,g_dema_d[l_ac].demasite_desc, 
       g_dema_d[l_ac].dema001,g_dema_d[l_ac].dema002,g_dema_d[l_ac].dema003,g_dema_d[l_ac].dema004,g_dema_d[l_ac].dema005, 
       g_dema_d[l_ac].dema005_desc,g_dema_d[l_ac].dema006,g_dema_d[l_ac].dema007,g_dema_d[l_ac].dema008, 
       g_dema_d[l_ac].dema008_desc,g_dema_d[l_ac].dema009,g_dema_d[l_ac].dema009_desc,g_dema_d[l_ac].dema010, 
       g_dema_d[l_ac].dema010_desc,g_dema_d[l_ac].dema011,g_dema_d[l_ac].dema011_desc,g_dema_d[l_ac].dema012, 
       g_dema_d[l_ac].dema012_desc,g_dema_d[l_ac].dema013,g_dema_d[l_ac].dema014,g_dema_d[l_ac].dema015, 
       g_dema_d[l_ac].dema016,g_dema_d[l_ac].dema017,g_dema_d[l_ac].dema018,g_dema_d[l_ac].dema019,g_dema_d[l_ac].dema020, 
       g_dema_d[l_ac].dema021,g_dema_d[l_ac].dema022,g_dema_d[l_ac].dema023,g_dema_d[l_ac].dema024,g_dema_d[l_ac].dema025, 
       g_dema_d[l_ac].dema026,g_dema_d[l_ac].dema027,g_dema_d[l_ac].dema028,g_dema_d[l_ac].dema029,g_dema_d[l_ac].dema030, 
       g_dema_d[l_ac].dema031,g_dema_d[l_ac].dema032,g_dema_d[l_ac].dema033,g_dema_d[l_ac].dema034,g_dema_d[l_ac].dema035, 
       g_dema_d[l_ac].dema036,g_dema_d[l_ac].dema037
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_dema_d[l_ac].statepic = cl_get_actipic(g_dema_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_dema_d[l_ac].sel = 'N'
      #end add-point
 
      CALL adeq610_detail_show("'1'")      
 
      CALL adeq610_dema_t_mask()
 
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
   
 
   
   CALL g_dema_d.deleteElement(g_dema_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_dema_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq610_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq610_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq610_detail_action_trans()
 
   IF g_dema_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq610_fetch()
   END IF
   
      CALL adeq610_filter_show('demasite','b_demasite')
   CALL adeq610_filter_show('dema001','b_dema001')
   CALL adeq610_filter_show('dema002','b_dema002')
   CALL adeq610_filter_show('dema003','b_dema003')
   CALL adeq610_filter_show('dema004','b_dema004')
   CALL adeq610_filter_show('dema005','b_dema005')
   CALL adeq610_filter_show('dema006','b_dema006')
   CALL adeq610_filter_show('dema007','b_dema007')
   CALL adeq610_filter_show('dema008','b_dema008')
   CALL adeq610_filter_show('dema009','b_dema009')
   CALL adeq610_filter_show('dema010','b_dema010')
   CALL adeq610_filter_show('dema011','b_dema011')
   CALL adeq610_filter_show('dema012','b_dema012')
   CALL adeq610_filter_show('dema013','b_dema013')
   CALL adeq610_filter_show('dema014','b_dema014')
   CALL adeq610_filter_show('dema015','b_dema015')
   CALL adeq610_filter_show('dema016','b_dema016')
   CALL adeq610_filter_show('dema017','b_dema017')
   CALL adeq610_filter_show('dema018','b_dema018')
   CALL adeq610_filter_show('dema019','b_dema019')
   CALL adeq610_filter_show('dema020','b_dema020')
   CALL adeq610_filter_show('dema021','b_dema021')
   CALL adeq610_filter_show('dema022','b_dema022')
   CALL adeq610_filter_show('dema023','b_dema023')
   CALL adeq610_filter_show('dema024','b_dema024')
   CALL adeq610_filter_show('dema025','b_dema025')
   CALL adeq610_filter_show('dema026','b_dema026')
   CALL adeq610_filter_show('dema027','b_dema027')
   CALL adeq610_filter_show('dema028','b_dema028')
   CALL adeq610_filter_show('dema029','b_dema029')
   CALL adeq610_filter_show('dema030','b_dema030')
   CALL adeq610_filter_show('dema031','b_dema031')
   CALL adeq610_filter_show('dema032','b_dema032')
   CALL adeq610_filter_show('dema033','b_dema033')
   CALL adeq610_filter_show('dema034','b_dema034')
   CALL adeq610_filter_show('dema035','b_dema035')
   CALL adeq610_filter_show('dema036','b_dema036')
   CALL adeq610_filter_show('dema037','b_dema037')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq610_fetch()
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
 
{<section id="adeq610.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq610_detail_show(ps_page)
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
      #150302-00004#8 150312 by lori522612 mark---(S) 
      #CALL s_desc_get_department_desc(g_dema_d[l_ac].demasite)
      #   RETURNING g_dema_d[l_ac].demasite_desc
      #DISPLAY BY NAME g_dema_d[l_ac].demasite_desc
      #
      #CALL s_desc_get_trading_partner_abbr_desc(g_dema_d[l_ac].dema005)
      #   RETURNING g_dema_d[l_ac].dema005_desc
      #DISPLAY BY NAME g_dema_d[l_ac].dema005_desc
      #
      #CALL s_desc_get_acc_desc('2060',g_dema_d[l_ac].dema008)
      #   RETURNING g_dema_d[l_ac].dema008_desc
      #DISPLAY BY NAME g_dema_d[l_ac].dema008_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_dema_d[l_ac].dema009
      #CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_dema_d[l_ac].dema009_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_dema_d[l_ac].dema009_desc
      #
      #CALL s_desc_get_acc_desc('2002',g_dema_d[l_ac].dema010)
      #   RETURNING g_dema_d[l_ac].dema010_desc
      #DISPLAY BY NAME g_dema_d[l_ac].dema010_desc
      #
      #CALL s_desc_get_tax_desc1(g_dema_d[l_ac].demasite,g_dema_d[l_ac].dema011)
      #   RETURNING g_dema_d[l_ac].dema011_desc
      #DISPLAY BY NAME g_dema_d[l_ac].dema011_desc
      #
      #CALL s_desc_get_currency_desc(g_dema_d[l_ac].dema012)
      #   RETURNING g_dema_d[l_ac].dema012_desc
      #DISPLAY BY NAME g_dema_d[l_ac].dema012_desc
      #150302-00004#8 150312 by lori522612 mark---(E) 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq610_filter()
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
      CONSTRUCT g_wc_filter ON demasite,dema001,dema002,dema003,dema004,dema005,dema006,dema007,dema008, 
          dema009,dema010,dema011,dema012,dema013,dema014,dema015,dema016,dema017,dema018,dema019,dema020, 
          dema021,dema022,dema023,dema024,dema025,dema026,dema027,dema028,dema029,dema030,dema031,dema032, 
          dema033,dema034,dema035,dema036,dema037
                          FROM s_detail1[1].b_demasite,s_detail1[1].b_dema001,s_detail1[1].b_dema002, 
                              s_detail1[1].b_dema003,s_detail1[1].b_dema004,s_detail1[1].b_dema005,s_detail1[1].b_dema006, 
                              s_detail1[1].b_dema007,s_detail1[1].b_dema008,s_detail1[1].b_dema009,s_detail1[1].b_dema010, 
                              s_detail1[1].b_dema011,s_detail1[1].b_dema012,s_detail1[1].b_dema013,s_detail1[1].b_dema014, 
                              s_detail1[1].b_dema015,s_detail1[1].b_dema016,s_detail1[1].b_dema017,s_detail1[1].b_dema018, 
                              s_detail1[1].b_dema019,s_detail1[1].b_dema020,s_detail1[1].b_dema021,s_detail1[1].b_dema022, 
                              s_detail1[1].b_dema023,s_detail1[1].b_dema024,s_detail1[1].b_dema025,s_detail1[1].b_dema026, 
                              s_detail1[1].b_dema027,s_detail1[1].b_dema028,s_detail1[1].b_dema029,s_detail1[1].b_dema030, 
                              s_detail1[1].b_dema031,s_detail1[1].b_dema032,s_detail1[1].b_dema033,s_detail1[1].b_dema034, 
                              s_detail1[1].b_dema035,s_detail1[1].b_dema036,s_detail1[1].b_dema037
 
         BEFORE CONSTRUCT
                     DISPLAY adeq610_filter_parser('demasite') TO s_detail1[1].b_demasite
            DISPLAY adeq610_filter_parser('dema001') TO s_detail1[1].b_dema001
            DISPLAY adeq610_filter_parser('dema002') TO s_detail1[1].b_dema002
            DISPLAY adeq610_filter_parser('dema003') TO s_detail1[1].b_dema003
            DISPLAY adeq610_filter_parser('dema004') TO s_detail1[1].b_dema004
            DISPLAY adeq610_filter_parser('dema005') TO s_detail1[1].b_dema005
            DISPLAY adeq610_filter_parser('dema006') TO s_detail1[1].b_dema006
            DISPLAY adeq610_filter_parser('dema007') TO s_detail1[1].b_dema007
            DISPLAY adeq610_filter_parser('dema008') TO s_detail1[1].b_dema008
            DISPLAY adeq610_filter_parser('dema009') TO s_detail1[1].b_dema009
            DISPLAY adeq610_filter_parser('dema010') TO s_detail1[1].b_dema010
            DISPLAY adeq610_filter_parser('dema011') TO s_detail1[1].b_dema011
            DISPLAY adeq610_filter_parser('dema012') TO s_detail1[1].b_dema012
            DISPLAY adeq610_filter_parser('dema013') TO s_detail1[1].b_dema013
            DISPLAY adeq610_filter_parser('dema014') TO s_detail1[1].b_dema014
            DISPLAY adeq610_filter_parser('dema015') TO s_detail1[1].b_dema015
            DISPLAY adeq610_filter_parser('dema016') TO s_detail1[1].b_dema016
            DISPLAY adeq610_filter_parser('dema017') TO s_detail1[1].b_dema017
            DISPLAY adeq610_filter_parser('dema018') TO s_detail1[1].b_dema018
            DISPLAY adeq610_filter_parser('dema019') TO s_detail1[1].b_dema019
            DISPLAY adeq610_filter_parser('dema020') TO s_detail1[1].b_dema020
            DISPLAY adeq610_filter_parser('dema021') TO s_detail1[1].b_dema021
            DISPLAY adeq610_filter_parser('dema022') TO s_detail1[1].b_dema022
            DISPLAY adeq610_filter_parser('dema023') TO s_detail1[1].b_dema023
            DISPLAY adeq610_filter_parser('dema024') TO s_detail1[1].b_dema024
            DISPLAY adeq610_filter_parser('dema025') TO s_detail1[1].b_dema025
            DISPLAY adeq610_filter_parser('dema026') TO s_detail1[1].b_dema026
            DISPLAY adeq610_filter_parser('dema027') TO s_detail1[1].b_dema027
            DISPLAY adeq610_filter_parser('dema028') TO s_detail1[1].b_dema028
            DISPLAY adeq610_filter_parser('dema029') TO s_detail1[1].b_dema029
            DISPLAY adeq610_filter_parser('dema030') TO s_detail1[1].b_dema030
            DISPLAY adeq610_filter_parser('dema031') TO s_detail1[1].b_dema031
            DISPLAY adeq610_filter_parser('dema032') TO s_detail1[1].b_dema032
            DISPLAY adeq610_filter_parser('dema033') TO s_detail1[1].b_dema033
            DISPLAY adeq610_filter_parser('dema034') TO s_detail1[1].b_dema034
            DISPLAY adeq610_filter_parser('dema035') TO s_detail1[1].b_dema035
            DISPLAY adeq610_filter_parser('dema036') TO s_detail1[1].b_dema036
            DISPLAY adeq610_filter_parser('dema037') TO s_detail1[1].b_dema037
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_demasite>>----
         #Ctrlp:construct.c.page1.b_demasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_demasite
            #add-point:ON ACTION controlp INFIELD b_demasite name="construct.c.filter.page1.b_demasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'demasite',g_site,'c') #161006-00008#6 Add By Ken 161018
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_demasite  #顯示到畫面上
            NEXT FIELD b_demasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_demasite_desc>>----
         #----<<b_dema001>>----
         #Ctrlp:construct.c.filter.page1.b_dema001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema001
            #add-point:ON ACTION controlp INFIELD b_dema001 name="construct.c.filter.page1.b_dema001"
            
            #END add-point
 
 
         #----<<b_dema002>>----
         #Ctrlp:construct.c.filter.page1.b_dema002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema002
            #add-point:ON ACTION controlp INFIELD b_dema002 name="construct.c.filter.page1.b_dema002"
            
            #END add-point
 
 
         #----<<b_dema003>>----
         #Ctrlp:construct.c.filter.page1.b_dema003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema003
            #add-point:ON ACTION controlp INFIELD b_dema003 name="construct.c.filter.page1.b_dema003"
            
            #END add-point
 
 
         #----<<b_dema004>>----
         #Ctrlp:construct.c.filter.page1.b_dema004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema004
            #add-point:ON ACTION controlp INFIELD b_dema004 name="construct.c.filter.page1.b_dema004"
            
            #END add-point
 
 
         #----<<b_dema005>>----
         #Ctrlp:construct.c.page1.b_dema005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema005
            #add-point:ON ACTION controlp INFIELD b_dema005 name="construct.c.filter.page1.b_dema005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_21()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema005  #顯示到畫面上
            NEXT FIELD b_dema005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema005_desc>>----
         #----<<b_dema006>>----
         #Ctrlp:construct.c.page1.b_dema006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema006
            #add-point:ON ACTION controlp INFIELD b_dema006 name="construct.c.filter.page1.b_dema006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stce001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema006  #顯示到畫面上
            NEXT FIELD b_dema006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema007>>----
         #Ctrlp:construct.c.filter.page1.b_dema007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema007
            #add-point:ON ACTION controlp INFIELD b_dema007 name="construct.c.filter.page1.b_dema007"
            
            #END add-point
 
 
         #----<<b_dema008>>----
         #Ctrlp:construct.c.page1.b_dema008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema008
            #add-point:ON ACTION controlp INFIELD b_dema008 name="construct.c.filter.page1.b_dema008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema008  #顯示到畫面上
            NEXT FIELD b_dema008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema008_desc>>----
         #----<<b_dema009>>----
         #Ctrlp:construct.c.page1.b_dema009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema009
            #add-point:ON ACTION controlp INFIELD b_dema009 name="construct.c.filter.page1.b_dema009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema009  #顯示到畫面上
            NEXT FIELD b_dema009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema009_desc>>----
         #----<<b_dema010>>----
         #Ctrlp:construct.c.page1.b_dema010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema010
            #add-point:ON ACTION controlp INFIELD b_dema010 name="construct.c.filter.page1.b_dema010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema010  #顯示到畫面上
            NEXT FIELD b_dema010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema010_desc>>----
         #----<<b_dema011>>----
         #Ctrlp:construct.c.page1.b_dema011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema011
            #add-point:ON ACTION controlp INFIELD b_dema011 name="construct.c.filter.page1.b_dema011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema011  #顯示到畫面上
            NEXT FIELD b_dema011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema011_desc>>----
         #----<<b_dema012>>----
         #Ctrlp:construct.c.page1.b_dema012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema012
            #add-point:ON ACTION controlp INFIELD b_dema012 name="construct.c.filter.page1.b_dema012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_dema012  #顯示到畫面上
            NEXT FIELD b_dema012                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_dema012_desc>>----
         #----<<b_dema013>>----
         #Ctrlp:construct.c.filter.page1.b_dema013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema013
            #add-point:ON ACTION controlp INFIELD b_dema013 name="construct.c.filter.page1.b_dema013"
            
            #END add-point
 
 
         #----<<b_dema014>>----
         #Ctrlp:construct.c.filter.page1.b_dema014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema014
            #add-point:ON ACTION controlp INFIELD b_dema014 name="construct.c.filter.page1.b_dema014"
            
            #END add-point
 
 
         #----<<b_dema015>>----
         #Ctrlp:construct.c.filter.page1.b_dema015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema015
            #add-point:ON ACTION controlp INFIELD b_dema015 name="construct.c.filter.page1.b_dema015"
            
            #END add-point
 
 
         #----<<b_dema016>>----
         #Ctrlp:construct.c.filter.page1.b_dema016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema016
            #add-point:ON ACTION controlp INFIELD b_dema016 name="construct.c.filter.page1.b_dema016"
            
            #END add-point
 
 
         #----<<b_dema017>>----
         #Ctrlp:construct.c.filter.page1.b_dema017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema017
            #add-point:ON ACTION controlp INFIELD b_dema017 name="construct.c.filter.page1.b_dema017"
            
            #END add-point
 
 
         #----<<b_dema018>>----
         #Ctrlp:construct.c.filter.page1.b_dema018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema018
            #add-point:ON ACTION controlp INFIELD b_dema018 name="construct.c.filter.page1.b_dema018"
            
            #END add-point
 
 
         #----<<b_dema019>>----
         #Ctrlp:construct.c.filter.page1.b_dema019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema019
            #add-point:ON ACTION controlp INFIELD b_dema019 name="construct.c.filter.page1.b_dema019"
            
            #END add-point
 
 
         #----<<b_dema020>>----
         #Ctrlp:construct.c.filter.page1.b_dema020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema020
            #add-point:ON ACTION controlp INFIELD b_dema020 name="construct.c.filter.page1.b_dema020"
            
            #END add-point
 
 
         #----<<b_dema021>>----
         #Ctrlp:construct.c.filter.page1.b_dema021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema021
            #add-point:ON ACTION controlp INFIELD b_dema021 name="construct.c.filter.page1.b_dema021"
            
            #END add-point
 
 
         #----<<b_dema022>>----
         #Ctrlp:construct.c.filter.page1.b_dema022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema022
            #add-point:ON ACTION controlp INFIELD b_dema022 name="construct.c.filter.page1.b_dema022"
            
            #END add-point
 
 
         #----<<b_dema023>>----
         #Ctrlp:construct.c.filter.page1.b_dema023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema023
            #add-point:ON ACTION controlp INFIELD b_dema023 name="construct.c.filter.page1.b_dema023"
            
            #END add-point
 
 
         #----<<b_dema024>>----
         #Ctrlp:construct.c.filter.page1.b_dema024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema024
            #add-point:ON ACTION controlp INFIELD b_dema024 name="construct.c.filter.page1.b_dema024"
            
            #END add-point
 
 
         #----<<b_dema025>>----
         #Ctrlp:construct.c.filter.page1.b_dema025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema025
            #add-point:ON ACTION controlp INFIELD b_dema025 name="construct.c.filter.page1.b_dema025"
            
            #END add-point
 
 
         #----<<b_dema026>>----
         #Ctrlp:construct.c.filter.page1.b_dema026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema026
            #add-point:ON ACTION controlp INFIELD b_dema026 name="construct.c.filter.page1.b_dema026"
            
            #END add-point
 
 
         #----<<b_dema027>>----
         #Ctrlp:construct.c.filter.page1.b_dema027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema027
            #add-point:ON ACTION controlp INFIELD b_dema027 name="construct.c.filter.page1.b_dema027"
            
            #END add-point
 
 
         #----<<b_dema028>>----
         #Ctrlp:construct.c.filter.page1.b_dema028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema028
            #add-point:ON ACTION controlp INFIELD b_dema028 name="construct.c.filter.page1.b_dema028"
            
            #END add-point
 
 
         #----<<b_dema029>>----
         #Ctrlp:construct.c.filter.page1.b_dema029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema029
            #add-point:ON ACTION controlp INFIELD b_dema029 name="construct.c.filter.page1.b_dema029"
            
            #END add-point
 
 
         #----<<b_dema030>>----
         #Ctrlp:construct.c.filter.page1.b_dema030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema030
            #add-point:ON ACTION controlp INFIELD b_dema030 name="construct.c.filter.page1.b_dema030"
            
            #END add-point
 
 
         #----<<b_dema031>>----
         #Ctrlp:construct.c.filter.page1.b_dema031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema031
            #add-point:ON ACTION controlp INFIELD b_dema031 name="construct.c.filter.page1.b_dema031"
            
            #END add-point
 
 
         #----<<b_dema032>>----
         #Ctrlp:construct.c.filter.page1.b_dema032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema032
            #add-point:ON ACTION controlp INFIELD b_dema032 name="construct.c.filter.page1.b_dema032"
            
            #END add-point
 
 
         #----<<b_dema033>>----
         #Ctrlp:construct.c.filter.page1.b_dema033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema033
            #add-point:ON ACTION controlp INFIELD b_dema033 name="construct.c.filter.page1.b_dema033"
            
            #END add-point
 
 
         #----<<b_dema034>>----
         #Ctrlp:construct.c.filter.page1.b_dema034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema034
            #add-point:ON ACTION controlp INFIELD b_dema034 name="construct.c.filter.page1.b_dema034"
            
            #END add-point
 
 
         #----<<b_dema035>>----
         #Ctrlp:construct.c.filter.page1.b_dema035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema035
            #add-point:ON ACTION controlp INFIELD b_dema035 name="construct.c.filter.page1.b_dema035"
            
            #END add-point
 
 
         #----<<b_dema036>>----
         #Ctrlp:construct.c.filter.page1.b_dema036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema036
            #add-point:ON ACTION controlp INFIELD b_dema036 name="construct.c.filter.page1.b_dema036"
            
            #END add-point
 
 
         #----<<b_dema037>>----
         #Ctrlp:construct.c.filter.page1.b_dema037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_dema037
            #add-point:ON ACTION controlp INFIELD b_dema037 name="construct.c.filter.page1.b_dema037"
            
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
   
      CALL adeq610_filter_show('demasite','b_demasite')
   CALL adeq610_filter_show('dema001','b_dema001')
   CALL adeq610_filter_show('dema002','b_dema002')
   CALL adeq610_filter_show('dema003','b_dema003')
   CALL adeq610_filter_show('dema004','b_dema004')
   CALL adeq610_filter_show('dema005','b_dema005')
   CALL adeq610_filter_show('dema006','b_dema006')
   CALL adeq610_filter_show('dema007','b_dema007')
   CALL adeq610_filter_show('dema008','b_dema008')
   CALL adeq610_filter_show('dema009','b_dema009')
   CALL adeq610_filter_show('dema010','b_dema010')
   CALL adeq610_filter_show('dema011','b_dema011')
   CALL adeq610_filter_show('dema012','b_dema012')
   CALL adeq610_filter_show('dema013','b_dema013')
   CALL adeq610_filter_show('dema014','b_dema014')
   CALL adeq610_filter_show('dema015','b_dema015')
   CALL adeq610_filter_show('dema016','b_dema016')
   CALL adeq610_filter_show('dema017','b_dema017')
   CALL adeq610_filter_show('dema018','b_dema018')
   CALL adeq610_filter_show('dema019','b_dema019')
   CALL adeq610_filter_show('dema020','b_dema020')
   CALL adeq610_filter_show('dema021','b_dema021')
   CALL adeq610_filter_show('dema022','b_dema022')
   CALL adeq610_filter_show('dema023','b_dema023')
   CALL adeq610_filter_show('dema024','b_dema024')
   CALL adeq610_filter_show('dema025','b_dema025')
   CALL adeq610_filter_show('dema026','b_dema026')
   CALL adeq610_filter_show('dema027','b_dema027')
   CALL adeq610_filter_show('dema028','b_dema028')
   CALL adeq610_filter_show('dema029','b_dema029')
   CALL adeq610_filter_show('dema030','b_dema030')
   CALL adeq610_filter_show('dema031','b_dema031')
   CALL adeq610_filter_show('dema032','b_dema032')
   CALL adeq610_filter_show('dema033','b_dema033')
   CALL adeq610_filter_show('dema034','b_dema034')
   CALL adeq610_filter_show('dema035','b_dema035')
   CALL adeq610_filter_show('dema036','b_dema036')
   CALL adeq610_filter_show('dema037','b_dema037')
 
    
   CALL adeq610_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq610_filter_parser(ps_field)
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
 
{<section id="adeq610.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq610_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq610_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.insert" >}
#+ insert
PRIVATE FUNCTION adeq610_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq610.modify" >}
#+ modify
PRIVATE FUNCTION adeq610_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq610_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.delete" >}
#+ delete
PRIVATE FUNCTION adeq610_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq610.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq610_detail_action_trans()
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
 
{<section id="adeq610.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq610_detail_index_setting()
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
            IF g_dema_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_dema_d.getLength() AND g_dema_d.getLength() > 0
            LET g_detail_idx = g_dema_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_dema_d.getLength() THEN
               LET g_detail_idx = g_dema_d.getLength()
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
 
{<section id="adeq610.mask_functions" >}
 &include "erp/ade/adeq610_mask.4gl"
 
{</section>}
 
{<section id="adeq610.other_function" readonly="Y" >}

 
{</section>}
 
