#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq103.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-08-20 22:14:40), PR版次:0005(2016-10-18 18:05:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000045
#+ Filename...: adeq103
#+ Description: 門店單品銷售核銷供應商日結作業
#+ Creator....: 06815(2015-08-20 16:02:07)
#+ Modifier...: 06815 -SD/PR- 02749
 
{</section>}
 
{<section id="adeq103.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160908-00032#1   2016/09/08 by rainy       q_pmaa001()開窗加上條件pmaa002='1' or '3'
#161017-00006#1   2016/10/18 by lori        子查詢未加ENT條件造成查詢時報錯：回傳不只一列
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
PRIVATE TYPE type_g_debf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   debfsite LIKE debf_t.debfsite, 
   debfsite_desc LIKE type_t.chr500, 
   debf001 LIKE debf_t.debf001, 
   debf053 LIKE debf_t.debf053, 
   debf053_desc LIKE type_t.chr500, 
   debf002 LIKE debf_t.debf002, 
   debf041 LIKE debf_t.debf041, 
   debf042 LIKE debf_t.debf042, 
   debf003 LIKE debf_t.debf003, 
   debf004 LIKE debf_t.debf004, 
   debf005 LIKE debf_t.debf005, 
   debf005_desc LIKE type_t.chr500, 
   debf006 LIKE debf_t.debf006, 
   debf007 LIKE debf_t.debf007, 
   debf008 LIKE debf_t.debf008, 
   debf010 LIKE debf_t.debf010, 
   debf009 LIKE debf_t.debf009, 
   debf011 LIKE debf_t.debf011, 
   debf012 LIKE debf_t.debf012, 
   debf043 LIKE debf_t.debf043, 
   debf043_desc LIKE type_t.chr500, 
   debf013 LIKE debf_t.debf013, 
   debf013_desc LIKE type_t.chr500, 
   debf014 LIKE debf_t.debf014, 
   debf014_desc LIKE type_t.chr500, 
   debf015 LIKE debf_t.debf015, 
   debf015_desc LIKE type_t.chr500, 
   debf016 LIKE debf_t.debf016, 
   debf016_desc LIKE type_t.chr500, 
   debf017 LIKE debf_t.debf017, 
   debf017_desc LIKE type_t.chr500, 
   debf049 LIKE debf_t.debf049, 
   debf018 LIKE debf_t.debf018, 
   debf018_desc LIKE type_t.chr500, 
   debf019 LIKE debf_t.debf019, 
   debf021 LIKE debf_t.debf021, 
   debf020 LIKE debf_t.debf020, 
   debf020_desc LIKE type_t.chr500, 
   debf022 LIKE debf_t.debf022, 
   debf023 LIKE debf_t.debf023, 
   debf024 LIKE debf_t.debf024, 
   debf025 LIKE debf_t.debf025, 
   debf026 LIKE debf_t.debf026, 
   debf045 LIKE debf_t.debf045, 
   debf046 LIKE debf_t.debf046, 
   debf047 LIKE debf_t.debf047, 
   debf027 LIKE debf_t.debf027, 
   debf028 LIKE debf_t.debf028, 
   debf030 LIKE debf_t.debf030, 
   debf031 LIKE debf_t.debf031, 
   debf032 LIKE debf_t.debf032, 
   debf033 LIKE debf_t.debf033, 
   debf034 LIKE debf_t.debf034, 
   debf035 LIKE debf_t.debf035, 
   debf036 LIKE debf_t.debf036, 
   debf037 LIKE debf_t.debf037, 
   debf038 LIKE debf_t.debf038, 
   debf039 LIKE debf_t.debf039, 
   debf040 LIKE debf_t.debf040 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_debf_d
DEFINE g_master_t                   type_g_debf_d
DEFINE g_debf_d          DYNAMIC ARRAY OF type_g_debf_d
DEFINE g_debf_d_t        type_g_debf_d
 
      
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
 
{<section id="adeq103.main" >}
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
   DECLARE adeq103_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq103_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq103_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq103 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq103_init()   
 
      #進入選單 Menu (="N")
      CALL adeq103_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq103
      
   END IF 
   
   CLOSE adeq103_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq103.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq103_init()
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
   
      CALL cl_set_combo_scc('b_debf001','6540') 
   CALL cl_set_combo_scc('b_debf006','6200') 
   CALL cl_set_combo_scc('b_debf007','6203') 
   CALL cl_set_combo_scc('b_debf008','6201') 
   CALL cl_set_combo_scc('b_debf049','6013') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   CALL adeq103_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq103.default_search" >}
PRIVATE FUNCTION adeq103_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " debfsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " debf002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " debf009 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " debf014 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " debf020 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " debf043 = '", g_argv[06], "' AND "
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
 
{<section id="adeq103.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq103_ui_dialog()
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
      CALL adeq103_b_fill()
   ELSE
      CALL adeq103_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_debf_d.clear()
 
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
 
         CALL adeq103_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_debf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq103_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq103_detail_action_trans()
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
            CALL adeq103_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)       
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq103_insert()
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
               CALL adeq103_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG
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
            CALL adeq103_filter()
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
            CALL adeq103_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_debf_d)
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
            CALL adeq103_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq103_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq103_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq103_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_debf_d.getLength()
               LET g_debf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_debf_d.getLength()
               LET g_debf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_debf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_debf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debf_d[li_idx].sel = "N"
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
 
{<section id="adeq103.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq103_query()
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
   CALL g_debf_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON debfsite,debf001,debf053,debf002,debf041,debf042,debf003,debf004,debf005, 
          debf006,debf007,debf008,debf010,debf009,debf011,debf012,debf043,debf013,debf014,debf015,debf016, 
          debf017,debf049,debf018,debf019,debf021,debf020,debf022,debf023,debf024,debf025,debf026,debf045, 
          debf046,debf047,debf027,debf028,debf030,debf031,debf032,debf033,debf034,debf035,debf036,debf037, 
          debf038,debf039,debf040
           FROM s_detail1[1].b_debfsite,s_detail1[1].b_debf001,s_detail1[1].b_debf053,s_detail1[1].b_debf002, 
               s_detail1[1].b_debf041,s_detail1[1].b_debf042,s_detail1[1].b_debf003,s_detail1[1].b_debf004, 
               s_detail1[1].b_debf005,s_detail1[1].b_debf006,s_detail1[1].b_debf007,s_detail1[1].b_debf008, 
               s_detail1[1].b_debf010,s_detail1[1].b_debf009,s_detail1[1].b_debf011,s_detail1[1].b_debf012, 
               s_detail1[1].b_debf043,s_detail1[1].b_debf013,s_detail1[1].b_debf014,s_detail1[1].b_debf015, 
               s_detail1[1].b_debf016,s_detail1[1].b_debf017,s_detail1[1].b_debf049,s_detail1[1].b_debf018, 
               s_detail1[1].b_debf019,s_detail1[1].b_debf021,s_detail1[1].b_debf020,s_detail1[1].b_debf022, 
               s_detail1[1].b_debf023,s_detail1[1].b_debf024,s_detail1[1].b_debf025,s_detail1[1].b_debf026, 
               s_detail1[1].b_debf045,s_detail1[1].b_debf046,s_detail1[1].b_debf047,s_detail1[1].b_debf027, 
               s_detail1[1].b_debf028,s_detail1[1].b_debf030,s_detail1[1].b_debf031,s_detail1[1].b_debf032, 
               s_detail1[1].b_debf033,s_detail1[1].b_debf034,s_detail1[1].b_debf035,s_detail1[1].b_debf036, 
               s_detail1[1].b_debf037,s_detail1[1].b_debf038,s_detail1[1].b_debf039,s_detail1[1].b_debf040 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO b_debfsite
            DISPLAY g_today-1 TO b_debf002
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_debfsite>>----
         #Ctrlp:construct.c.page1.b_debfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debfsite
            #add-point:ON ACTION controlp INFIELD b_debfsite name="construct.c.page1.b_debfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debfsite  #顯示到畫面上
            NEXT FIELD b_debfsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debfsite
            #add-point:BEFORE FIELD b_debfsite name="construct.b.page1.b_debfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debfsite
            
            #add-point:AFTER FIELD b_debfsite name="construct.a.page1.b_debfsite"
            
            #END add-point
            
 
 
         #----<<b_debfsite_desc>>----
         #----<<b_debf001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf001
            #add-point:BEFORE FIELD b_debf001 name="construct.b.page1.b_debf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf001
            
            #add-point:AFTER FIELD b_debf001 name="construct.a.page1.b_debf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf001
            #add-point:ON ACTION controlp INFIELD b_debf001 name="construct.c.page1.b_debf001"
            
            #END add-point
 
 
         #----<<b_debf053>>----
         #Ctrlp:construct.c.page1.b_debf053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf053
            #add-point:ON ACTION controlp INFIELD b_debf053 name="construct.c.page1.b_debf053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,'','E-CIR-0001')  
            CALL q_rtax001_3()                           #呼叫開窗            
            DISPLAY g_qryparam.return1 TO b_debf053  #顯示到畫面上
            NEXT FIELD b_debf053                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf053
            #add-point:BEFORE FIELD b_debf053 name="construct.b.page1.b_debf053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf053
            
            #add-point:AFTER FIELD b_debf053 name="construct.a.page1.b_debf053"
            
            #END add-point
            
 
 
         #----<<b_debf053_desc>>----
         #----<<b_debf002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf002
            #add-point:BEFORE FIELD b_debf002 name="construct.b.page1.b_debf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf002
            
            #add-point:AFTER FIELD b_debf002 name="construct.a.page1.b_debf002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf002
            #add-point:ON ACTION controlp INFIELD b_debf002 name="construct.c.page1.b_debf002"
            
            #END add-point
 
 
         #----<<b_debf041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf041
            #add-point:BEFORE FIELD b_debf041 name="construct.b.page1.b_debf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf041
            
            #add-point:AFTER FIELD b_debf041 name="construct.a.page1.b_debf041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf041
            #add-point:ON ACTION controlp INFIELD b_debf041 name="construct.c.page1.b_debf041"
            
            #END add-point
 
 
         #----<<b_debf042>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf042
            #add-point:BEFORE FIELD b_debf042 name="construct.b.page1.b_debf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf042
            
            #add-point:AFTER FIELD b_debf042 name="construct.a.page1.b_debf042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf042
            #add-point:ON ACTION controlp INFIELD b_debf042 name="construct.c.page1.b_debf042"
            
            #END add-point
 
 
         #----<<b_debf003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf003
            #add-point:BEFORE FIELD b_debf003 name="construct.b.page1.b_debf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf003
            
            #add-point:AFTER FIELD b_debf003 name="construct.a.page1.b_debf003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf003
            #add-point:ON ACTION controlp INFIELD b_debf003 name="construct.c.page1.b_debf003"
            
            #END add-point
 
 
         #----<<b_debf004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf004
            #add-point:BEFORE FIELD b_debf004 name="construct.b.page1.b_debf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf004
            
            #add-point:AFTER FIELD b_debf004 name="construct.a.page1.b_debf004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf004
            #add-point:ON ACTION controlp INFIELD b_debf004 name="construct.c.page1.b_debf004"
            
            #END add-point
 
 
         #----<<b_debf005>>----
         #Ctrlp:construct.c.page1.b_debf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf005
            #add-point:ON ACTION controlp INFIELD b_debf005 name="construct.c.page1.b_debf005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf005  #顯示到畫面上
            NEXT FIELD b_debf005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf005
            #add-point:BEFORE FIELD b_debf005 name="construct.b.page1.b_debf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf005
            
            #add-point:AFTER FIELD b_debf005 name="construct.a.page1.b_debf005"
            
            #END add-point
            
 
 
         #----<<b_debf005_desc>>----
         #----<<b_debf006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf006
            #add-point:BEFORE FIELD b_debf006 name="construct.b.page1.b_debf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf006
            
            #add-point:AFTER FIELD b_debf006 name="construct.a.page1.b_debf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf006
            #add-point:ON ACTION controlp INFIELD b_debf006 name="construct.c.page1.b_debf006"
            
            #END add-point
 
 
         #----<<b_debf007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf007
            #add-point:BEFORE FIELD b_debf007 name="construct.b.page1.b_debf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf007
            
            #add-point:AFTER FIELD b_debf007 name="construct.a.page1.b_debf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf007
            #add-point:ON ACTION controlp INFIELD b_debf007 name="construct.c.page1.b_debf007"
            
            #END add-point
 
 
         #----<<b_debf008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf008
            #add-point:BEFORE FIELD b_debf008 name="construct.b.page1.b_debf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf008
            
            #add-point:AFTER FIELD b_debf008 name="construct.a.page1.b_debf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf008
            #add-point:ON ACTION controlp INFIELD b_debf008 name="construct.c.page1.b_debf008"
            
            #END add-point
 
 
         #----<<b_debf010>>----
         #Ctrlp:construct.c.page1.b_debf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf010
            #add-point:ON ACTION controlp INFIELD b_debf010 name="construct.c.page1.b_debf010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf010  #顯示到畫面上
            NEXT FIELD b_debf010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf010
            #add-point:BEFORE FIELD b_debf010 name="construct.b.page1.b_debf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf010
            
            #add-point:AFTER FIELD b_debf010 name="construct.a.page1.b_debf010"
            
            #END add-point
            
 
 
         #----<<b_debf009>>----
         #Ctrlp:construct.c.page1.b_debf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf009
            #add-point:ON ACTION controlp INFIELD b_debf009 name="construct.c.page1.b_debf009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf009  #顯示到畫面上
            NEXT FIELD b_debf009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf009
            #add-point:BEFORE FIELD b_debf009 name="construct.b.page1.b_debf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf009
            
            #add-point:AFTER FIELD b_debf009 name="construct.a.page1.b_debf009"
            
            #END add-point
            
 
 
         #----<<b_debf011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf011
            #add-point:BEFORE FIELD b_debf011 name="construct.b.page1.b_debf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf011
            
            #add-point:AFTER FIELD b_debf011 name="construct.a.page1.b_debf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf011
            #add-point:ON ACTION controlp INFIELD b_debf011 name="construct.c.page1.b_debf011"
            
            #END add-point
 
 
         #----<<b_debf012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf012
            #add-point:BEFORE FIELD b_debf012 name="construct.b.page1.b_debf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf012
            
            #add-point:AFTER FIELD b_debf012 name="construct.a.page1.b_debf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf012
            #add-point:ON ACTION controlp INFIELD b_debf012 name="construct.c.page1.b_debf012"
            
            #END add-point
 
 
         #----<<b_debf043>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf043
            #add-point:BEFORE FIELD b_debf043 name="construct.b.page1.b_debf043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf043
            
            #add-point:AFTER FIELD b_debf043 name="construct.a.page1.b_debf043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf043
            #add-point:ON ACTION controlp INFIELD b_debf043 name="construct.c.page1.b_debf043"
            
            #END add-point
 
 
         #----<<b_debf043_desc>>----
         #----<<b_debf013>>----
         #Ctrlp:construct.c.page1.b_debf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf013
            #add-point:ON ACTION controlp INFIELD b_debf013 name="construct.c.page1.b_debf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf013  #顯示到畫面上
            NEXT FIELD b_debf013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf013
            #add-point:BEFORE FIELD b_debf013 name="construct.b.page1.b_debf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf013
            
            #add-point:AFTER FIELD b_debf013 name="construct.a.page1.b_debf013"
            
            #END add-point
            
 
 
         #----<<b_debf013_desc>>----
         #----<<b_debf014>>----
         #Ctrlp:construct.c.page1.b_debf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf014
            #add-point:ON ACTION controlp INFIELD b_debf014 name="construct.c.page1.b_debf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf014  #顯示到畫面上
            NEXT FIELD b_debf014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf014
            #add-point:BEFORE FIELD b_debf014 name="construct.b.page1.b_debf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf014
            
            #add-point:AFTER FIELD b_debf014 name="construct.a.page1.b_debf014"
            
            #END add-point
            
 
 
         #----<<b_debf014_desc>>----
         #----<<b_debf015>>----
         #Ctrlp:construct.c.page1.b_debf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf015
            #add-point:ON ACTION controlp INFIELD b_debf015 name="construct.c.page1.b_debf015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf015  #顯示到畫面上
            NEXT FIELD b_debf015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf015
            #add-point:BEFORE FIELD b_debf015 name="construct.b.page1.b_debf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf015
            
            #add-point:AFTER FIELD b_debf015 name="construct.a.page1.b_debf015"
            
            #END add-point
            
 
 
         #----<<b_debf015_desc>>----
         #----<<b_debf016>>----
         #Ctrlp:construct.c.page1.b_debf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf016
            #add-point:ON ACTION controlp INFIELD b_debf016 name="construct.c.page1.b_debf016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf016  #顯示到畫面上
            NEXT FIELD b_debf016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf016
            #add-point:BEFORE FIELD b_debf016 name="construct.b.page1.b_debf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf016
            
            #add-point:AFTER FIELD b_debf016 name="construct.a.page1.b_debf016"
            
            #END add-point
            
 
 
         #----<<b_debf016_desc>>----
         #----<<b_debf017>>----
         #Ctrlp:construct.c.page1.b_debf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf017
            #add-point:ON ACTION controlp INFIELD b_debf017 name="construct.c.page1.b_debf017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf017  #顯示到畫面上
            NEXT FIELD b_debf017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf017
            #add-point:BEFORE FIELD b_debf017 name="construct.b.page1.b_debf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf017
            
            #add-point:AFTER FIELD b_debf017 name="construct.a.page1.b_debf017"
            
            #END add-point
            
 
 
         #----<<b_debf017_desc>>----
         #----<<b_debf049>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf049
            #add-point:BEFORE FIELD b_debf049 name="construct.b.page1.b_debf049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf049
            
            #add-point:AFTER FIELD b_debf049 name="construct.a.page1.b_debf049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf049
            #add-point:ON ACTION controlp INFIELD b_debf049 name="construct.c.page1.b_debf049"
            
            #END add-point
 
 
         #----<<b_debf018>>----
         #Ctrlp:construct.c.page1.b_debf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf018
            #add-point:ON ACTION controlp INFIELD b_debf018 name="construct.c.page1.b_debf018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf018  #顯示到畫面上
            NEXT FIELD b_debf018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf018
            #add-point:BEFORE FIELD b_debf018 name="construct.b.page1.b_debf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf018
            
            #add-point:AFTER FIELD b_debf018 name="construct.a.page1.b_debf018"
            
            #END add-point
            
 
 
         #----<<b_debf018_desc>>----
         #----<<b_debf019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf019
            #add-point:BEFORE FIELD b_debf019 name="construct.b.page1.b_debf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf019
            
            #add-point:AFTER FIELD b_debf019 name="construct.a.page1.b_debf019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf019
            #add-point:ON ACTION controlp INFIELD b_debf019 name="construct.c.page1.b_debf019"
            
            #END add-point
 
 
         #----<<b_debf021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf021
            #add-point:BEFORE FIELD b_debf021 name="construct.b.page1.b_debf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf021
            
            #add-point:AFTER FIELD b_debf021 name="construct.a.page1.b_debf021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf021
            #add-point:ON ACTION controlp INFIELD b_debf021 name="construct.c.page1.b_debf021"
            
            #END add-point
 
 
         #----<<b_debf020>>----
         #Ctrlp:construct.c.page1.b_debf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf020
            #add-point:ON ACTION controlp INFIELD b_debf020 name="construct.c.page1.b_debf020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf020  #顯示到畫面上
            NEXT FIELD b_debf020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf020
            #add-point:BEFORE FIELD b_debf020 name="construct.b.page1.b_debf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf020
            
            #add-point:AFTER FIELD b_debf020 name="construct.a.page1.b_debf020"
            
            #END add-point
            
 
 
         #----<<b_debf020_desc>>----
         #----<<b_debf022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf022
            #add-point:BEFORE FIELD b_debf022 name="construct.b.page1.b_debf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf022
            
            #add-point:AFTER FIELD b_debf022 name="construct.a.page1.b_debf022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf022
            #add-point:ON ACTION controlp INFIELD b_debf022 name="construct.c.page1.b_debf022"
            
            #END add-point
 
 
         #----<<b_debf023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf023
            #add-point:BEFORE FIELD b_debf023 name="construct.b.page1.b_debf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf023
            
            #add-point:AFTER FIELD b_debf023 name="construct.a.page1.b_debf023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf023
            #add-point:ON ACTION controlp INFIELD b_debf023 name="construct.c.page1.b_debf023"
            
            #END add-point
 
 
         #----<<b_debf024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf024
            #add-point:BEFORE FIELD b_debf024 name="construct.b.page1.b_debf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf024
            
            #add-point:AFTER FIELD b_debf024 name="construct.a.page1.b_debf024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf024
            #add-point:ON ACTION controlp INFIELD b_debf024 name="construct.c.page1.b_debf024"
            
            #END add-point
 
 
         #----<<b_debf025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf025
            #add-point:BEFORE FIELD b_debf025 name="construct.b.page1.b_debf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf025
            
            #add-point:AFTER FIELD b_debf025 name="construct.a.page1.b_debf025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf025
            #add-point:ON ACTION controlp INFIELD b_debf025 name="construct.c.page1.b_debf025"
            
            #END add-point
 
 
         #----<<b_debf026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf026
            #add-point:BEFORE FIELD b_debf026 name="construct.b.page1.b_debf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf026
            
            #add-point:AFTER FIELD b_debf026 name="construct.a.page1.b_debf026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf026
            #add-point:ON ACTION controlp INFIELD b_debf026 name="construct.c.page1.b_debf026"
            
            #END add-point
 
 
         #----<<b_debf045>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf045
            #add-point:BEFORE FIELD b_debf045 name="construct.b.page1.b_debf045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf045
            
            #add-point:AFTER FIELD b_debf045 name="construct.a.page1.b_debf045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf045
            #add-point:ON ACTION controlp INFIELD b_debf045 name="construct.c.page1.b_debf045"
            
            #END add-point
 
 
         #----<<b_debf046>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf046
            #add-point:BEFORE FIELD b_debf046 name="construct.b.page1.b_debf046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf046
            
            #add-point:AFTER FIELD b_debf046 name="construct.a.page1.b_debf046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf046
            #add-point:ON ACTION controlp INFIELD b_debf046 name="construct.c.page1.b_debf046"
            
            #END add-point
 
 
         #----<<b_debf047>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf047
            #add-point:BEFORE FIELD b_debf047 name="construct.b.page1.b_debf047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf047
            
            #add-point:AFTER FIELD b_debf047 name="construct.a.page1.b_debf047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf047
            #add-point:ON ACTION controlp INFIELD b_debf047 name="construct.c.page1.b_debf047"
            
            #END add-point
 
 
         #----<<b_debf027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf027
            #add-point:BEFORE FIELD b_debf027 name="construct.b.page1.b_debf027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf027
            
            #add-point:AFTER FIELD b_debf027 name="construct.a.page1.b_debf027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf027
            #add-point:ON ACTION controlp INFIELD b_debf027 name="construct.c.page1.b_debf027"
            
            #END add-point
 
 
         #----<<b_debf028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf028
            #add-point:BEFORE FIELD b_debf028 name="construct.b.page1.b_debf028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf028
            
            #add-point:AFTER FIELD b_debf028 name="construct.a.page1.b_debf028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf028
            #add-point:ON ACTION controlp INFIELD b_debf028 name="construct.c.page1.b_debf028"
            
            #END add-point
 
 
         #----<<b_debf030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf030
            #add-point:BEFORE FIELD b_debf030 name="construct.b.page1.b_debf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf030
            
            #add-point:AFTER FIELD b_debf030 name="construct.a.page1.b_debf030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf030
            #add-point:ON ACTION controlp INFIELD b_debf030 name="construct.c.page1.b_debf030"
            
            #END add-point
 
 
         #----<<b_debf031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf031
            #add-point:BEFORE FIELD b_debf031 name="construct.b.page1.b_debf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf031
            
            #add-point:AFTER FIELD b_debf031 name="construct.a.page1.b_debf031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf031
            #add-point:ON ACTION controlp INFIELD b_debf031 name="construct.c.page1.b_debf031"
            
            #END add-point
 
 
         #----<<b_debf032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf032
            #add-point:BEFORE FIELD b_debf032 name="construct.b.page1.b_debf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf032
            
            #add-point:AFTER FIELD b_debf032 name="construct.a.page1.b_debf032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf032
            #add-point:ON ACTION controlp INFIELD b_debf032 name="construct.c.page1.b_debf032"
            
            #END add-point
 
 
         #----<<b_debf033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf033
            #add-point:BEFORE FIELD b_debf033 name="construct.b.page1.b_debf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf033
            
            #add-point:AFTER FIELD b_debf033 name="construct.a.page1.b_debf033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf033
            #add-point:ON ACTION controlp INFIELD b_debf033 name="construct.c.page1.b_debf033"
            
            #END add-point
 
 
         #----<<b_debf034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf034
            #add-point:BEFORE FIELD b_debf034 name="construct.b.page1.b_debf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf034
            
            #add-point:AFTER FIELD b_debf034 name="construct.a.page1.b_debf034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf034
            #add-point:ON ACTION controlp INFIELD b_debf034 name="construct.c.page1.b_debf034"
            
            #END add-point
 
 
         #----<<b_debf035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf035
            #add-point:BEFORE FIELD b_debf035 name="construct.b.page1.b_debf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf035
            
            #add-point:AFTER FIELD b_debf035 name="construct.a.page1.b_debf035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf035
            #add-point:ON ACTION controlp INFIELD b_debf035 name="construct.c.page1.b_debf035"
            
            #END add-point
 
 
         #----<<b_debf036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf036
            #add-point:BEFORE FIELD b_debf036 name="construct.b.page1.b_debf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf036
            
            #add-point:AFTER FIELD b_debf036 name="construct.a.page1.b_debf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf036
            #add-point:ON ACTION controlp INFIELD b_debf036 name="construct.c.page1.b_debf036"
            
            #END add-point
 
 
         #----<<b_debf037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf037
            #add-point:BEFORE FIELD b_debf037 name="construct.b.page1.b_debf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf037
            
            #add-point:AFTER FIELD b_debf037 name="construct.a.page1.b_debf037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf037
            #add-point:ON ACTION controlp INFIELD b_debf037 name="construct.c.page1.b_debf037"
            
            #END add-point
 
 
         #----<<b_debf038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf038
            #add-point:BEFORE FIELD b_debf038 name="construct.b.page1.b_debf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf038
            
            #add-point:AFTER FIELD b_debf038 name="construct.a.page1.b_debf038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf038
            #add-point:ON ACTION controlp INFIELD b_debf038 name="construct.c.page1.b_debf038"
            
            #END add-point
 
 
         #----<<b_debf039>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf039
            #add-point:BEFORE FIELD b_debf039 name="construct.b.page1.b_debf039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf039
            
            #add-point:AFTER FIELD b_debf039 name="construct.a.page1.b_debf039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf039
            #add-point:ON ACTION controlp INFIELD b_debf039 name="construct.c.page1.b_debf039"
            
            #END add-point
 
 
         #----<<b_debf040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debf040
            #add-point:BEFORE FIELD b_debf040 name="construct.b.page1.b_debf040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debf040
            
            #add-point:AFTER FIELD b_debf040 name="construct.a.page1.b_debf040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf040
            #add-point:ON ACTION controlp INFIELD b_debf040 name="construct.c.page1.b_debf040"
            
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
   CALL adeq103_b_fill()
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
 
{<section id="adeq103.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq103_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_success       LIKE type_t.num5 
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'debfsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',debfsite,'',debf001,debf053,'',debf002,debf041,debf042,debf003, 
       debf004,debf005,'',debf006,debf007,debf008,debf010,debf009,debf011,debf012,debf043,'',debf013, 
       '',debf014,'',debf015,'',debf016,'',debf017,'',debf049,debf018,'',debf019,debf021,debf020,'', 
       debf022,debf023,debf024,debf025,debf026,debf045,debf046,debf047,debf027,debf028,debf030,debf031, 
       debf032,debf033,debf034,debf035,debf036,debf037,debf038,debf039,debf040  ,DENSE_RANK() OVER( ORDER BY debf_t.debfsite, 
       debf_t.debf002,debf_t.debf009,debf_t.debf014,debf_t.debf020,debf_t.debf043) AS RANK FROM debf_t", 
 
 
 
                     "",
                     " WHERE debfent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debf_t"),
                     " ORDER BY debf_t.debfsite,debf_t.debf002,debf_t.debf009,debf_t.debf014,debf_t.debf020,debf_t.debf043"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 s983961--mark(s) 效能調整 
   #LET ls_sql_rank =  "SELECT  UNIQUE 'N',",
   #            "               debfsite,ooefl003 debfsite_desc,debf001,debf053,t1.rtaxl003 debf053_desc,debf002,debf041,      ",           
   #            "               debf042,debf003, debf004,debf005,'',debf006,debf007,debf008,        ", 
   #            "               debf010,debf009,debf011,debf012,debf043,'',debf013,oocql004 debf013_desc,debf014, ",
   #            "               pmaal003 debf014_desc,debf015,staal003 debf015_desc,debf016,t2.rtaxl003 debf016_desc,debf017,mhael023 debf017_desc,debf049, ",
   #            "               debf018,oodbl004 debf018_desc,debf019,debf021,debf020,oocal003 debf020_desc,debf022,debf023,debf024, ",
   #            "               debf025,debf026,debf045,debf046,debf047,debf027,debf028,debf030,debf031, ",
   #            "               debf032,debf033,debf034,debf035,debf036,debf037,debf038,debf039,debf040, ",
   #            "               DENSE_RANK() OVER( ORDER BY debf_t.debfsite,debf_t.debf002,debf_t.debf009,debf_t.debf014,debf_t.debf020,debf_t.debf043) AS RANK  ",
   #            " FROM debf_t ", 
   #            "            LEFT JOIN ooefl_t ON ooeflent=debfent AND ooefl001=debfsite AND ooefl002 = '",g_dlang,"' ",
   #            "            LEFT JOIN rtaxl_t t1 ON t1.rtaxlent=debfent AND t1.rtaxl001=debf053 AND t1.rtaxl002 = '",g_dlang,"' ",
   #            "            LEFT JOIN rtaxl_t t2 ON t2.rtaxlent=debfent AND t2.rtaxl001=debf016 AND t2.rtaxl002 = '",g_dlang,"' ",
   #            "            LEFT JOIN oocql_t ON oocql001='2002'  AND oocql002=debf013  AND oocql003 = '",g_dlang,"' ",
   #            "            LEFT JOIN pmaal_t ON pmaalent=debfent AND pmaal001=debf014  AND pmaal002 = '",g_dlang,"' ",
   #            "            LEFT JOIN staal_t ON staalent=debfent AND staal001=debf015  AND staal002 = '",g_dlang,"' ",
   #            "            LEFT JOIN mhael_t ON mhaelsite=debfsite AND mhael001=debf017 AND mhael022 = '",g_dlang,"' ",
   #            "            LEFT JOIN oodbl_t ON oodblent=debfent AND oodbl002=debfsite AND oodbl003 = '",g_dlang,"' ",
   #            "            LEFT JOIN oocal_t ON oocal001=debf020 AND oocal002 = '",g_dlang,"' ",
   #            " WHERE debfent= ? AND 1=1 AND ", ls_wc
   #150826-00013#2 s983961--mark(e) 效能調整             
               
                         
   #150826-00013#2 s983961--add(s) 效能調整            
   LET ls_sql_rank =  "SELECT  UNIQUE 'N',debfsite, ",
               "                 (SELECT ooefl003 FROM ooefl_t ",
               "                   WHERE ooeflent=debfent AND ooefl001=debfsite  ",
               "                     AND ooefl002='"||g_dlang||"') debfsite_desc,",
               "                 debf001,debf053, ",
               "                 (SELECT rtaxl003 FROM rtaxl_t ",
               "                   WHERE rtaxlent=debfent AND rtaxl001=debf053  ",
               "                     AND rtaxl002='"||g_dlang||"') debf053_desc,",
               "                 debf002,debf041,debf042, ",           
               "                 debf003,debf004,debf005, ",
               "                 '',debf006,debf007,      ", 
               "                 debf008,debf010,debf009, ",
               "                 debf011,debf012,debf043, ",
               "                 '',debf013,              ",
               "                 (SELECT oocql004 FROM oocql_t ",
               "                   WHERE oocqlent = debfent ",                        #161017-00006#1 161018 by lori mod:補上ent條件
               "                     AND oocql001='2002'  AND oocql002=debf013  ",    #161017-00006#1 161018 by lori mod 
               "                     AND oocql003='"||g_dlang||"') debf013_desc,",
               "                 debf014, ",
               "                 (SELECT pmaal003 FROM pmaal_t ",
               "                   WHERE pmaalent=debfent AND pmaal001=debf014  ",
               "                     AND pmaal002='"||g_dlang||"') debf014_desc,",
               "                 debf015, ",
               "                 (SELECT staal003 FROM staal_t ",
               "                   WHERE staalent=debfent AND staal001=debf015  ",
               "                     AND staal002='"||g_dlang||"') debf015_desc,",
               "                 debf016, ",
               "                 (SELECT rtaxl003 FROM rtaxl_t ",
               "                   WHERE rtaxlent=debfent AND rtaxl001=debf016  ",
               "                     AND rtaxl002='"||g_dlang||"') debf016_desc,",
               "                 debf017, ",
               "                 (SELECT mhael023 FROM mhael_t ",
               "                   WHERE mhaelsite=debfsite AND mhael001=debf017 ",
               "                     AND mhael022='"||g_dlang||"') debf017_desc, ",
               "                 debf049,debf018, ",
               "                 (SELECT oodbl004 FROM oodbl_t ",
               "                   WHERE oodblent=debfent AND oodbl002=debfsite ",
               "                     AND oodbl003='"||g_dlang||"') debf018_desc,",
               "                 debf019,debf021,debf020, ",
               "                 (SELECT oocal003 FROM oocal_t ",
               "                   WHERE oocalent=debfent AND oocal001=debf020  ",
               "                     AND oocal002='"||g_dlang||"') debf020_desc,",
               "                 debf022,debf023,debf024, ",
               "                 debf025,debf026,debf045, ",
               "                 debf046,debf047,debf027, ",
               "                 debf028,debf030,debf031, ",
               "                 debf032,debf033,debf034, ",
               "                 debf035,debf036,debf037, ",
               "                 debf038,debf039,debf040, ",
               "                 DENSE_RANK() OVER( ORDER BY debf_t.debfsite,debf_t.debf002,debf_t.debf009,debf_t.debf014,debf_t.debf020,debf_t.debf043) AS RANK  ",
               "   FROM debf_t ", 
               "  WHERE debfent= ? AND 1=1 AND ", ls_wc             
  #150826-00013#2 s983961--add(e) 效能調整              
                        
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debf_t"),
               " ORDER BY debf_t.debfsite,debf_t.debf002,debf_t.debf009,debf_t.debf014,debf_t.debf020,debf_t.debf043"    
                      
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
 
   LET g_sql = "SELECT '',debfsite,'',debf001,debf053,'',debf002,debf041,debf042,debf003,debf004,debf005, 
       '',debf006,debf007,debf008,debf010,debf009,debf011,debf012,debf043,'',debf013,'',debf014,'',debf015, 
       '',debf016,'',debf017,'',debf049,debf018,'',debf019,debf021,debf020,'',debf022,debf023,debf024, 
       debf025,debf026,debf045,debf046,debf047,debf027,debf028,debf030,debf031,debf032,debf033,debf034, 
       debf035,debf036,debf037,debf038,debf039,debf040",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT 'N',debfsite,debfsite_desc,debf001,debf053,debf053_desc,debf002,debf041,debf042,debf003,debf004,debf005, 
       '',debf006,debf007,debf008,debf010,debf009,debf011,debf012,debf043,'',debf013,debf013_desc,debf014,debf014_desc,debf015, 
       debf015_desc,debf016,debf016_desc,debf017,debf017_desc,debf049,debf018,debf018_desc,debf019,debf021,debf020,debf020_desc,debf022,debf023,debf024, 
       debf025,debf026,debf045,debf046,debf047,debf027,debf028,debf030,debf031,debf032,debf033,debf034, 
       debf035,debf036,debf037,debf038,debf039,debf040",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq103_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq103_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_debf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_debf_d[l_ac].sel,g_debf_d[l_ac].debfsite,g_debf_d[l_ac].debfsite_desc, 
       g_debf_d[l_ac].debf001,g_debf_d[l_ac].debf053,g_debf_d[l_ac].debf053_desc,g_debf_d[l_ac].debf002, 
       g_debf_d[l_ac].debf041,g_debf_d[l_ac].debf042,g_debf_d[l_ac].debf003,g_debf_d[l_ac].debf004,g_debf_d[l_ac].debf005, 
       g_debf_d[l_ac].debf005_desc,g_debf_d[l_ac].debf006,g_debf_d[l_ac].debf007,g_debf_d[l_ac].debf008, 
       g_debf_d[l_ac].debf010,g_debf_d[l_ac].debf009,g_debf_d[l_ac].debf011,g_debf_d[l_ac].debf012,g_debf_d[l_ac].debf043, 
       g_debf_d[l_ac].debf043_desc,g_debf_d[l_ac].debf013,g_debf_d[l_ac].debf013_desc,g_debf_d[l_ac].debf014, 
       g_debf_d[l_ac].debf014_desc,g_debf_d[l_ac].debf015,g_debf_d[l_ac].debf015_desc,g_debf_d[l_ac].debf016, 
       g_debf_d[l_ac].debf016_desc,g_debf_d[l_ac].debf017,g_debf_d[l_ac].debf017_desc,g_debf_d[l_ac].debf049, 
       g_debf_d[l_ac].debf018,g_debf_d[l_ac].debf018_desc,g_debf_d[l_ac].debf019,g_debf_d[l_ac].debf021, 
       g_debf_d[l_ac].debf020,g_debf_d[l_ac].debf020_desc,g_debf_d[l_ac].debf022,g_debf_d[l_ac].debf023, 
       g_debf_d[l_ac].debf024,g_debf_d[l_ac].debf025,g_debf_d[l_ac].debf026,g_debf_d[l_ac].debf045,g_debf_d[l_ac].debf046, 
       g_debf_d[l_ac].debf047,g_debf_d[l_ac].debf027,g_debf_d[l_ac].debf028,g_debf_d[l_ac].debf030,g_debf_d[l_ac].debf031, 
       g_debf_d[l_ac].debf032,g_debf_d[l_ac].debf033,g_debf_d[l_ac].debf034,g_debf_d[l_ac].debf035,g_debf_d[l_ac].debf036, 
       g_debf_d[l_ac].debf037,g_debf_d[l_ac].debf038,g_debf_d[l_ac].debf039,g_debf_d[l_ac].debf040
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_debf_d[l_ac].statepic = cl_get_actipic(g_debf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #產品特徵說明
      CALL s_feature_description(g_debf_d[l_ac].debf009,g_debf_d[l_ac].debf043)
      RETURNING l_success,g_debf_d[l_ac].debf043_desc    
      #160420-00039#3 s983961--mark(s)s_adep103已經有處理
      ##毛利率=毛利/應收金額*100  
      #SELECT SUM(debf027)/SUM(debf026)*100 INTO  g_debf_d[l_ac].debf028
      #  FROM debf_t
      # WHERE debfent = g_enterprise
      #   AND debfsite = g_debf_d[l_ac].debfsite
      #   AND debf002 = g_debf_d[l_ac].debf002
      #   AND debf009 = g_debf_d[l_ac].debf009
      #   AND debf014 = g_debf_d[l_ac].debf014
      #   AND debf020 = g_debf_d[l_ac].debf020
      #   AND debf043 = g_debf_d[l_ac].debf043
      #160420-00039#3 s983961--mark(e)s_adep103已經有處理
      #end add-point
 
      CALL adeq103_detail_show("'1'")      
 
      CALL adeq103_debf_t_mask()
 
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
   
 
   
   CALL g_debf_d.deleteElement(g_debf_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_debf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq103_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq103_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq103_detail_action_trans()
 
   IF g_debf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq103_fetch()
   END IF
   
      CALL adeq103_filter_show('debfsite','b_debfsite')
   CALL adeq103_filter_show('debf001','b_debf001')
   CALL adeq103_filter_show('debf053','b_debf053')
   CALL adeq103_filter_show('debf002','b_debf002')
   CALL adeq103_filter_show('debf041','b_debf041')
   CALL adeq103_filter_show('debf042','b_debf042')
   CALL adeq103_filter_show('debf003','b_debf003')
   CALL adeq103_filter_show('debf004','b_debf004')
   CALL adeq103_filter_show('debf005','b_debf005')
   CALL adeq103_filter_show('debf006','b_debf006')
   CALL adeq103_filter_show('debf007','b_debf007')
   CALL adeq103_filter_show('debf008','b_debf008')
   CALL adeq103_filter_show('debf010','b_debf010')
   CALL adeq103_filter_show('debf009','b_debf009')
   CALL adeq103_filter_show('debf011','b_debf011')
   CALL adeq103_filter_show('debf012','b_debf012')
   CALL adeq103_filter_show('debf043','b_debf043')
   CALL adeq103_filter_show('debf013','b_debf013')
   CALL adeq103_filter_show('debf014','b_debf014')
   CALL adeq103_filter_show('debf015','b_debf015')
   CALL adeq103_filter_show('debf016','b_debf016')
   CALL adeq103_filter_show('debf017','b_debf017')
   CALL adeq103_filter_show('debf049','b_debf049')
   CALL adeq103_filter_show('debf018','b_debf018')
   CALL adeq103_filter_show('debf019','b_debf019')
   CALL adeq103_filter_show('debf021','b_debf021')
   CALL adeq103_filter_show('debf020','b_debf020')
   CALL adeq103_filter_show('debf022','b_debf022')
   CALL adeq103_filter_show('debf023','b_debf023')
   CALL adeq103_filter_show('debf024','b_debf024')
   CALL adeq103_filter_show('debf025','b_debf025')
   CALL adeq103_filter_show('debf026','b_debf026')
   CALL adeq103_filter_show('debf045','b_debf045')
   CALL adeq103_filter_show('debf046','b_debf046')
   CALL adeq103_filter_show('debf047','b_debf047')
   CALL adeq103_filter_show('debf027','b_debf027')
   CALL adeq103_filter_show('debf028','b_debf028')
   CALL adeq103_filter_show('debf030','b_debf030')
   CALL adeq103_filter_show('debf031','b_debf031')
   CALL adeq103_filter_show('debf032','b_debf032')
   CALL adeq103_filter_show('debf033','b_debf033')
   CALL adeq103_filter_show('debf034','b_debf034')
   CALL adeq103_filter_show('debf035','b_debf035')
   CALL adeq103_filter_show('debf036','b_debf036')
   CALL adeq103_filter_show('debf037','b_debf037')
   CALL adeq103_filter_show('debf038','b_debf038')
   CALL adeq103_filter_show('debf039','b_debf039')
   CALL adeq103_filter_show('debf040','b_debf040')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq103_fetch()
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
 
{<section id="adeq103.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq103_detail_show(ps_page)
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

        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debfsite
        #   LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debfsite_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debfsite_desc
        #
        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debfsite
        #   LET g_ref_fields[2] = g_debf_d[l_ac].debf005
        #   LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debf005_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debf005_desc
        #
        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debf014
        #   LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debf014_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debf014_desc
        #
        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debf015
        #   LET ls_sql = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'"
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debf015_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debf015_desc
        #
        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debf016
        #   LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debf016_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debf016_desc
        #
        #   INITIALIZE g_ref_fields TO NULL
        #   LET g_ref_fields[1] = g_debf_d[l_ac].debf018
        #   LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'"
        #   LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
        #   CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
        #   LET g_debf_d[l_ac].debf018_desc = '', g_rtn_fields[1] , ''
        #   DISPLAY BY NAME g_debf_d[l_ac].debf018_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq103_filter()
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
      CONSTRUCT g_wc_filter ON debfsite,debf001,debf053,debf002,debf041,debf042,debf003,debf004,debf005, 
          debf006,debf007,debf008,debf010,debf009,debf011,debf012,debf043,debf013,debf014,debf015,debf016, 
          debf017,debf049,debf018,debf019,debf021,debf020,debf022,debf023,debf024,debf025,debf026,debf045, 
          debf046,debf047,debf027,debf028,debf030,debf031,debf032,debf033,debf034,debf035,debf036,debf037, 
          debf038,debf039,debf040
                          FROM s_detail1[1].b_debfsite,s_detail1[1].b_debf001,s_detail1[1].b_debf053, 
                              s_detail1[1].b_debf002,s_detail1[1].b_debf041,s_detail1[1].b_debf042,s_detail1[1].b_debf003, 
                              s_detail1[1].b_debf004,s_detail1[1].b_debf005,s_detail1[1].b_debf006,s_detail1[1].b_debf007, 
                              s_detail1[1].b_debf008,s_detail1[1].b_debf010,s_detail1[1].b_debf009,s_detail1[1].b_debf011, 
                              s_detail1[1].b_debf012,s_detail1[1].b_debf043,s_detail1[1].b_debf013,s_detail1[1].b_debf014, 
                              s_detail1[1].b_debf015,s_detail1[1].b_debf016,s_detail1[1].b_debf017,s_detail1[1].b_debf049, 
                              s_detail1[1].b_debf018,s_detail1[1].b_debf019,s_detail1[1].b_debf021,s_detail1[1].b_debf020, 
                              s_detail1[1].b_debf022,s_detail1[1].b_debf023,s_detail1[1].b_debf024,s_detail1[1].b_debf025, 
                              s_detail1[1].b_debf026,s_detail1[1].b_debf045,s_detail1[1].b_debf046,s_detail1[1].b_debf047, 
                              s_detail1[1].b_debf027,s_detail1[1].b_debf028,s_detail1[1].b_debf030,s_detail1[1].b_debf031, 
                              s_detail1[1].b_debf032,s_detail1[1].b_debf033,s_detail1[1].b_debf034,s_detail1[1].b_debf035, 
                              s_detail1[1].b_debf036,s_detail1[1].b_debf037,s_detail1[1].b_debf038,s_detail1[1].b_debf039, 
                              s_detail1[1].b_debf040
 
         BEFORE CONSTRUCT
                     DISPLAY adeq103_filter_parser('debfsite') TO s_detail1[1].b_debfsite
            DISPLAY adeq103_filter_parser('debf001') TO s_detail1[1].b_debf001
            DISPLAY adeq103_filter_parser('debf053') TO s_detail1[1].b_debf053
            DISPLAY adeq103_filter_parser('debf002') TO s_detail1[1].b_debf002
            DISPLAY adeq103_filter_parser('debf041') TO s_detail1[1].b_debf041
            DISPLAY adeq103_filter_parser('debf042') TO s_detail1[1].b_debf042
            DISPLAY adeq103_filter_parser('debf003') TO s_detail1[1].b_debf003
            DISPLAY adeq103_filter_parser('debf004') TO s_detail1[1].b_debf004
            DISPLAY adeq103_filter_parser('debf005') TO s_detail1[1].b_debf005
            DISPLAY adeq103_filter_parser('debf006') TO s_detail1[1].b_debf006
            DISPLAY adeq103_filter_parser('debf007') TO s_detail1[1].b_debf007
            DISPLAY adeq103_filter_parser('debf008') TO s_detail1[1].b_debf008
            DISPLAY adeq103_filter_parser('debf010') TO s_detail1[1].b_debf010
            DISPLAY adeq103_filter_parser('debf009') TO s_detail1[1].b_debf009
            DISPLAY adeq103_filter_parser('debf011') TO s_detail1[1].b_debf011
            DISPLAY adeq103_filter_parser('debf012') TO s_detail1[1].b_debf012
            DISPLAY adeq103_filter_parser('debf043') TO s_detail1[1].b_debf043
            DISPLAY adeq103_filter_parser('debf013') TO s_detail1[1].b_debf013
            DISPLAY adeq103_filter_parser('debf014') TO s_detail1[1].b_debf014
            DISPLAY adeq103_filter_parser('debf015') TO s_detail1[1].b_debf015
            DISPLAY adeq103_filter_parser('debf016') TO s_detail1[1].b_debf016
            DISPLAY adeq103_filter_parser('debf017') TO s_detail1[1].b_debf017
            DISPLAY adeq103_filter_parser('debf049') TO s_detail1[1].b_debf049
            DISPLAY adeq103_filter_parser('debf018') TO s_detail1[1].b_debf018
            DISPLAY adeq103_filter_parser('debf019') TO s_detail1[1].b_debf019
            DISPLAY adeq103_filter_parser('debf021') TO s_detail1[1].b_debf021
            DISPLAY adeq103_filter_parser('debf020') TO s_detail1[1].b_debf020
            DISPLAY adeq103_filter_parser('debf022') TO s_detail1[1].b_debf022
            DISPLAY adeq103_filter_parser('debf023') TO s_detail1[1].b_debf023
            DISPLAY adeq103_filter_parser('debf024') TO s_detail1[1].b_debf024
            DISPLAY adeq103_filter_parser('debf025') TO s_detail1[1].b_debf025
            DISPLAY adeq103_filter_parser('debf026') TO s_detail1[1].b_debf026
            DISPLAY adeq103_filter_parser('debf045') TO s_detail1[1].b_debf045
            DISPLAY adeq103_filter_parser('debf046') TO s_detail1[1].b_debf046
            DISPLAY adeq103_filter_parser('debf047') TO s_detail1[1].b_debf047
            DISPLAY adeq103_filter_parser('debf027') TO s_detail1[1].b_debf027
            DISPLAY adeq103_filter_parser('debf028') TO s_detail1[1].b_debf028
            DISPLAY adeq103_filter_parser('debf030') TO s_detail1[1].b_debf030
            DISPLAY adeq103_filter_parser('debf031') TO s_detail1[1].b_debf031
            DISPLAY adeq103_filter_parser('debf032') TO s_detail1[1].b_debf032
            DISPLAY adeq103_filter_parser('debf033') TO s_detail1[1].b_debf033
            DISPLAY adeq103_filter_parser('debf034') TO s_detail1[1].b_debf034
            DISPLAY adeq103_filter_parser('debf035') TO s_detail1[1].b_debf035
            DISPLAY adeq103_filter_parser('debf036') TO s_detail1[1].b_debf036
            DISPLAY adeq103_filter_parser('debf037') TO s_detail1[1].b_debf037
            DISPLAY adeq103_filter_parser('debf038') TO s_detail1[1].b_debf038
            DISPLAY adeq103_filter_parser('debf039') TO s_detail1[1].b_debf039
            DISPLAY adeq103_filter_parser('debf040') TO s_detail1[1].b_debf040
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_debfsite>>----
         #Ctrlp:construct.c.page1.b_debfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debfsite
            #add-point:ON ACTION controlp INFIELD b_debfsite name="construct.c.filter.page1.b_debfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debfsite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debfsite  #顯示到畫面上
            NEXT FIELD b_debfsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debfsite_desc>>----
         #----<<b_debf001>>----
         #Ctrlp:construct.c.filter.page1.b_debf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf001
            #add-point:ON ACTION controlp INFIELD b_debf001 name="construct.c.filter.page1.b_debf001"
            
            #END add-point
 
 
         #----<<b_debf053>>----
         #Ctrlp:construct.c.page1.b_debf053
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf053
            #add-point:ON ACTION controlp INFIELD b_debf053 name="construct.c.filter.page1.b_debf053"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,'','E-CIR-0001')  
            CALL q_rtax001_3()                           #呼叫開窗            
            DISPLAY g_qryparam.return1 TO b_debf053  #顯示到畫面上
            NEXT FIELD b_debf053                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf053_desc>>----
         #----<<b_debf002>>----
         #Ctrlp:construct.c.filter.page1.b_debf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf002
            #add-point:ON ACTION controlp INFIELD b_debf002 name="construct.c.filter.page1.b_debf002"
            
            #END add-point
 
 
         #----<<b_debf041>>----
         #Ctrlp:construct.c.filter.page1.b_debf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf041
            #add-point:ON ACTION controlp INFIELD b_debf041 name="construct.c.filter.page1.b_debf041"
            
            #END add-point
 
 
         #----<<b_debf042>>----
         #Ctrlp:construct.c.filter.page1.b_debf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf042
            #add-point:ON ACTION controlp INFIELD b_debf042 name="construct.c.filter.page1.b_debf042"
            
            #END add-point
 
 
         #----<<b_debf003>>----
         #Ctrlp:construct.c.filter.page1.b_debf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf003
            #add-point:ON ACTION controlp INFIELD b_debf003 name="construct.c.filter.page1.b_debf003"
            
            #END add-point
 
 
         #----<<b_debf004>>----
         #Ctrlp:construct.c.filter.page1.b_debf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf004
            #add-point:ON ACTION controlp INFIELD b_debf004 name="construct.c.filter.page1.b_debf004"
            
            #END add-point
 
 
         #----<<b_debf005>>----
         #Ctrlp:construct.c.page1.b_debf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf005
            #add-point:ON ACTION controlp INFIELD b_debf005 name="construct.c.filter.page1.b_debf005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf005  #顯示到畫面上
            NEXT FIELD b_debf005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf005_desc>>----
         #----<<b_debf006>>----
         #Ctrlp:construct.c.filter.page1.b_debf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf006
            #add-point:ON ACTION controlp INFIELD b_debf006 name="construct.c.filter.page1.b_debf006"
            
            #END add-point
 
 
         #----<<b_debf007>>----
         #Ctrlp:construct.c.filter.page1.b_debf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf007
            #add-point:ON ACTION controlp INFIELD b_debf007 name="construct.c.filter.page1.b_debf007"
            
            #END add-point
 
 
         #----<<b_debf008>>----
         #Ctrlp:construct.c.filter.page1.b_debf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf008
            #add-point:ON ACTION controlp INFIELD b_debf008 name="construct.c.filter.page1.b_debf008"
            
            #END add-point
 
 
         #----<<b_debf010>>----
         #Ctrlp:construct.c.page1.b_debf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf010
            #add-point:ON ACTION controlp INFIELD b_debf010 name="construct.c.filter.page1.b_debf010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf010  #顯示到畫面上
            NEXT FIELD b_debf010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf009>>----
         #Ctrlp:construct.c.page1.b_debf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf009
            #add-point:ON ACTION controlp INFIELD b_debf009 name="construct.c.filter.page1.b_debf009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf009  #顯示到畫面上
            NEXT FIELD b_debf009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf011>>----
         #Ctrlp:construct.c.filter.page1.b_debf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf011
            #add-point:ON ACTION controlp INFIELD b_debf011 name="construct.c.filter.page1.b_debf011"
            
            #END add-point
 
 
         #----<<b_debf012>>----
         #Ctrlp:construct.c.filter.page1.b_debf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf012
            #add-point:ON ACTION controlp INFIELD b_debf012 name="construct.c.filter.page1.b_debf012"
            
            #END add-point
 
 
         #----<<b_debf043>>----
         #Ctrlp:construct.c.filter.page1.b_debf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf043
            #add-point:ON ACTION controlp INFIELD b_debf043 name="construct.c.filter.page1.b_debf043"
            
            #END add-point
 
 
         #----<<b_debf043_desc>>----
         #----<<b_debf013>>----
         #Ctrlp:construct.c.page1.b_debf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf013
            #add-point:ON ACTION controlp INFIELD b_debf013 name="construct.c.filter.page1.b_debf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf013  #顯示到畫面上
            NEXT FIELD b_debf013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf013_desc>>----
         #----<<b_debf014>>----
         #Ctrlp:construct.c.page1.b_debf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf014
            #add-point:ON ACTION controlp INFIELD b_debf014 name="construct.c.filter.page1.b_debf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf014  #顯示到畫面上
            NEXT FIELD b_debf014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf014_desc>>----
         #----<<b_debf015>>----
         #Ctrlp:construct.c.page1.b_debf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf015
            #add-point:ON ACTION controlp INFIELD b_debf015 name="construct.c.filter.page1.b_debf015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf015  #顯示到畫面上
            NEXT FIELD b_debf015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf015_desc>>----
         #----<<b_debf016>>----
         #Ctrlp:construct.c.page1.b_debf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf016
            #add-point:ON ACTION controlp INFIELD b_debf016 name="construct.c.filter.page1.b_debf016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf016  #顯示到畫面上
            NEXT FIELD b_debf016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf016_desc>>----
         #----<<b_debf017>>----
         #Ctrlp:construct.c.page1.b_debf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf017
            #add-point:ON ACTION controlp INFIELD b_debf017 name="construct.c.filter.page1.b_debf017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mhae001_2()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf017  #顯示到畫面上
            NEXT FIELD b_debf017                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf017_desc>>----
         #----<<b_debf049>>----
         #Ctrlp:construct.c.filter.page1.b_debf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf049
            #add-point:ON ACTION controlp INFIELD b_debf049 name="construct.c.filter.page1.b_debf049"
            
            #END add-point
 
 
         #----<<b_debf018>>----
         #Ctrlp:construct.c.page1.b_debf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf018
            #add-point:ON ACTION controlp INFIELD b_debf018 name="construct.c.filter.page1.b_debf018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf018  #顯示到畫面上
            NEXT FIELD b_debf018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf018_desc>>----
         #----<<b_debf019>>----
         #Ctrlp:construct.c.filter.page1.b_debf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf019
            #add-point:ON ACTION controlp INFIELD b_debf019 name="construct.c.filter.page1.b_debf019"
            
            #END add-point
 
 
         #----<<b_debf021>>----
         #Ctrlp:construct.c.filter.page1.b_debf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf021
            #add-point:ON ACTION controlp INFIELD b_debf021 name="construct.c.filter.page1.b_debf021"
            
            #END add-point
 
 
         #----<<b_debf020>>----
         #Ctrlp:construct.c.page1.b_debf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf020
            #add-point:ON ACTION controlp INFIELD b_debf020 name="construct.c.filter.page1.b_debf020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debf020  #顯示到畫面上
            NEXT FIELD b_debf020                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debf020_desc>>----
         #----<<b_debf022>>----
         #Ctrlp:construct.c.filter.page1.b_debf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf022
            #add-point:ON ACTION controlp INFIELD b_debf022 name="construct.c.filter.page1.b_debf022"
            
            #END add-point
 
 
         #----<<b_debf023>>----
         #Ctrlp:construct.c.filter.page1.b_debf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf023
            #add-point:ON ACTION controlp INFIELD b_debf023 name="construct.c.filter.page1.b_debf023"
            
            #END add-point
 
 
         #----<<b_debf024>>----
         #Ctrlp:construct.c.filter.page1.b_debf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf024
            #add-point:ON ACTION controlp INFIELD b_debf024 name="construct.c.filter.page1.b_debf024"
            
            #END add-point
 
 
         #----<<b_debf025>>----
         #Ctrlp:construct.c.filter.page1.b_debf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf025
            #add-point:ON ACTION controlp INFIELD b_debf025 name="construct.c.filter.page1.b_debf025"
            
            #END add-point
 
 
         #----<<b_debf026>>----
         #Ctrlp:construct.c.filter.page1.b_debf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf026
            #add-point:ON ACTION controlp INFIELD b_debf026 name="construct.c.filter.page1.b_debf026"
            
            #END add-point
 
 
         #----<<b_debf045>>----
         #Ctrlp:construct.c.filter.page1.b_debf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf045
            #add-point:ON ACTION controlp INFIELD b_debf045 name="construct.c.filter.page1.b_debf045"
            
            #END add-point
 
 
         #----<<b_debf046>>----
         #Ctrlp:construct.c.filter.page1.b_debf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf046
            #add-point:ON ACTION controlp INFIELD b_debf046 name="construct.c.filter.page1.b_debf046"
            
            #END add-point
 
 
         #----<<b_debf047>>----
         #Ctrlp:construct.c.filter.page1.b_debf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf047
            #add-point:ON ACTION controlp INFIELD b_debf047 name="construct.c.filter.page1.b_debf047"
            
            #END add-point
 
 
         #----<<b_debf027>>----
         #Ctrlp:construct.c.filter.page1.b_debf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf027
            #add-point:ON ACTION controlp INFIELD b_debf027 name="construct.c.filter.page1.b_debf027"
            
            #END add-point
 
 
         #----<<b_debf028>>----
         #Ctrlp:construct.c.filter.page1.b_debf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf028
            #add-point:ON ACTION controlp INFIELD b_debf028 name="construct.c.filter.page1.b_debf028"
            
            #END add-point
 
 
         #----<<b_debf030>>----
         #Ctrlp:construct.c.filter.page1.b_debf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf030
            #add-point:ON ACTION controlp INFIELD b_debf030 name="construct.c.filter.page1.b_debf030"
            
            #END add-point
 
 
         #----<<b_debf031>>----
         #Ctrlp:construct.c.filter.page1.b_debf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf031
            #add-point:ON ACTION controlp INFIELD b_debf031 name="construct.c.filter.page1.b_debf031"
            
            #END add-point
 
 
         #----<<b_debf032>>----
         #Ctrlp:construct.c.filter.page1.b_debf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf032
            #add-point:ON ACTION controlp INFIELD b_debf032 name="construct.c.filter.page1.b_debf032"
            
            #END add-point
 
 
         #----<<b_debf033>>----
         #Ctrlp:construct.c.filter.page1.b_debf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf033
            #add-point:ON ACTION controlp INFIELD b_debf033 name="construct.c.filter.page1.b_debf033"
            
            #END add-point
 
 
         #----<<b_debf034>>----
         #Ctrlp:construct.c.filter.page1.b_debf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf034
            #add-point:ON ACTION controlp INFIELD b_debf034 name="construct.c.filter.page1.b_debf034"
            
            #END add-point
 
 
         #----<<b_debf035>>----
         #Ctrlp:construct.c.filter.page1.b_debf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf035
            #add-point:ON ACTION controlp INFIELD b_debf035 name="construct.c.filter.page1.b_debf035"
            
            #END add-point
 
 
         #----<<b_debf036>>----
         #Ctrlp:construct.c.filter.page1.b_debf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf036
            #add-point:ON ACTION controlp INFIELD b_debf036 name="construct.c.filter.page1.b_debf036"
            
            #END add-point
 
 
         #----<<b_debf037>>----
         #Ctrlp:construct.c.filter.page1.b_debf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf037
            #add-point:ON ACTION controlp INFIELD b_debf037 name="construct.c.filter.page1.b_debf037"
            
            #END add-point
 
 
         #----<<b_debf038>>----
         #Ctrlp:construct.c.filter.page1.b_debf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf038
            #add-point:ON ACTION controlp INFIELD b_debf038 name="construct.c.filter.page1.b_debf038"
            
            #END add-point
 
 
         #----<<b_debf039>>----
         #Ctrlp:construct.c.filter.page1.b_debf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf039
            #add-point:ON ACTION controlp INFIELD b_debf039 name="construct.c.filter.page1.b_debf039"
            
            #END add-point
 
 
         #----<<b_debf040>>----
         #Ctrlp:construct.c.filter.page1.b_debf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debf040
            #add-point:ON ACTION controlp INFIELD b_debf040 name="construct.c.filter.page1.b_debf040"
            
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
   
      CALL adeq103_filter_show('debfsite','b_debfsite')
   CALL adeq103_filter_show('debf001','b_debf001')
   CALL adeq103_filter_show('debf053','b_debf053')
   CALL adeq103_filter_show('debf002','b_debf002')
   CALL adeq103_filter_show('debf041','b_debf041')
   CALL adeq103_filter_show('debf042','b_debf042')
   CALL adeq103_filter_show('debf003','b_debf003')
   CALL adeq103_filter_show('debf004','b_debf004')
   CALL adeq103_filter_show('debf005','b_debf005')
   CALL adeq103_filter_show('debf006','b_debf006')
   CALL adeq103_filter_show('debf007','b_debf007')
   CALL adeq103_filter_show('debf008','b_debf008')
   CALL adeq103_filter_show('debf010','b_debf010')
   CALL adeq103_filter_show('debf009','b_debf009')
   CALL adeq103_filter_show('debf011','b_debf011')
   CALL adeq103_filter_show('debf012','b_debf012')
   CALL adeq103_filter_show('debf043','b_debf043')
   CALL adeq103_filter_show('debf013','b_debf013')
   CALL adeq103_filter_show('debf014','b_debf014')
   CALL adeq103_filter_show('debf015','b_debf015')
   CALL adeq103_filter_show('debf016','b_debf016')
   CALL adeq103_filter_show('debf017','b_debf017')
   CALL adeq103_filter_show('debf049','b_debf049')
   CALL adeq103_filter_show('debf018','b_debf018')
   CALL adeq103_filter_show('debf019','b_debf019')
   CALL adeq103_filter_show('debf021','b_debf021')
   CALL adeq103_filter_show('debf020','b_debf020')
   CALL adeq103_filter_show('debf022','b_debf022')
   CALL adeq103_filter_show('debf023','b_debf023')
   CALL adeq103_filter_show('debf024','b_debf024')
   CALL adeq103_filter_show('debf025','b_debf025')
   CALL adeq103_filter_show('debf026','b_debf026')
   CALL adeq103_filter_show('debf045','b_debf045')
   CALL adeq103_filter_show('debf046','b_debf046')
   CALL adeq103_filter_show('debf047','b_debf047')
   CALL adeq103_filter_show('debf027','b_debf027')
   CALL adeq103_filter_show('debf028','b_debf028')
   CALL adeq103_filter_show('debf030','b_debf030')
   CALL adeq103_filter_show('debf031','b_debf031')
   CALL adeq103_filter_show('debf032','b_debf032')
   CALL adeq103_filter_show('debf033','b_debf033')
   CALL adeq103_filter_show('debf034','b_debf034')
   CALL adeq103_filter_show('debf035','b_debf035')
   CALL adeq103_filter_show('debf036','b_debf036')
   CALL adeq103_filter_show('debf037','b_debf037')
   CALL adeq103_filter_show('debf038','b_debf038')
   CALL adeq103_filter_show('debf039','b_debf039')
   CALL adeq103_filter_show('debf040','b_debf040')
 
    
   CALL adeq103_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq103_filter_parser(ps_field)
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
 
{<section id="adeq103.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq103_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq103_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.insert" >}
#+ insert
PRIVATE FUNCTION adeq103_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq103.modify" >}
#+ modify
PRIVATE FUNCTION adeq103_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq103_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.delete" >}
#+ delete
PRIVATE FUNCTION adeq103_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq103.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq103_detail_action_trans()
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
 
{<section id="adeq103.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq103_detail_index_setting()
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
            IF g_debf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_debf_d.getLength() AND g_debf_d.getLength() > 0
            LET g_detail_idx = g_debf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_debf_d.getLength() THEN
               LET g_detail_idx = g_debf_d.getLength()
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
 
{<section id="adeq103.mask_functions" >}
 &include "erp/ade/adeq103_mask.4gl"
 
{</section>}
 
{<section id="adeq103.other_function" readonly="Y" >}

 
{</section>}
 
