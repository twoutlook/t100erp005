#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq150.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-06-01 17:38:06), PR版次:0006(2016-10-18 16:47:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000050
#+ Filename...: adeq150
#+ Description:  門店銷售單品週結查詢
#+ Creator....: 06529(2015-06-19 10:28:30)
#+ Modifier...: 06137 -SD/PR- 02159
 
{</section>}
 
{<section id="adeq150.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160908-00032#1   2016/09/08 by rainy       q_pmaa001()開窗加上條件pmaa002='1' or '3'
#161006-00008#4   2016/10/18 by sakura      整批修改組織
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
PRIVATE TYPE type_g_decf_d RECORD
       #statepic       LIKE type_t.chr1,
       
       decfsite LIKE decf_t.decfsite, 
   decfsite_desc LIKE type_t.chr500, 
   decf001 LIKE decf_t.decf001, 
   decf041 LIKE decf_t.decf041, 
   decf042 LIKE decf_t.decf042, 
   decf005 LIKE decf_t.decf005, 
   decf005_desc LIKE type_t.chr500, 
   decf006 LIKE decf_t.decf006, 
   decf007 LIKE decf_t.decf007, 
   decf008 LIKE decf_t.decf008, 
   decf010 LIKE decf_t.decf010, 
   decf009 LIKE decf_t.decf009, 
   decf011 LIKE decf_t.decf011, 
   decf012 LIKE decf_t.decf012, 
   decf043 LIKE decf_t.decf043, 
   decf043_desc LIKE type_t.chr500, 
   decf013 LIKE decf_t.decf013, 
   decf013_desc LIKE type_t.chr500, 
   decf014 LIKE decf_t.decf014, 
   decf014_desc LIKE type_t.chr500, 
   decf015 LIKE decf_t.decf015, 
   decf015_desc LIKE type_t.chr500, 
   decf016 LIKE decf_t.decf016, 
   decf016_desc LIKE type_t.chr500, 
   decf017 LIKE decf_t.decf017, 
   decf017_desc LIKE type_t.chr500, 
   decf018 LIKE decf_t.decf018, 
   decf018_desc LIKE type_t.chr500, 
   decf019 LIKE decf_t.decf019, 
   decf020 LIKE decf_t.decf020, 
   decf020_desc LIKE type_t.chr500, 
   decf021 LIKE decf_t.decf021, 
   decf022 LIKE decf_t.decf022, 
   decf023 LIKE decf_t.decf023, 
   decf024 LIKE decf_t.decf024, 
   decf025 LIKE decf_t.decf025, 
   decf026 LIKE decf_t.decf026, 
   decf045 LIKE decf_t.decf045, 
   decf046 LIKE decf_t.decf046, 
   decf047 LIKE decf_t.decf047, 
   decf027 LIKE decf_t.decf027, 
   decf028 LIKE decf_t.decf028, 
   decf029 LIKE decf_t.decf029, 
   decf048 LIKE decf_t.decf048, 
   decf030 LIKE decf_t.decf030, 
   decf031 LIKE decf_t.decf031, 
   decf032 LIKE decf_t.decf032, 
   decf033 LIKE decf_t.decf033, 
   decf034 LIKE decf_t.decf034, 
   decf035 LIKE decf_t.decf035, 
   decf036 LIKE decf_t.decf036, 
   decf037 LIKE decf_t.decf037, 
   decf038 LIKE decf_t.decf038, 
   decf039 LIKE decf_t.decf039, 
   decf040 LIKE decf_t.decf040, 
   decf049 LIKE decf_t.decf049, 
   decf053 LIKE decf_t.decf053, 
   decf054 LIKE decf_t.decf054 
       END RECORD
PRIVATE TYPE type_g_decf3_d RECORD
       decg020 LIKE decg_t.decg020, 
   decg020_desc LIKE type_t.chr500, 
   decg021 LIKE decg_t.decg021, 
   decg021_desc LIKE type_t.chr500, 
   decg022 LIKE decg_t.decg022, 
   decg023 LIKE decg_t.decg023, 
   decg027 LIKE decg_t.decg027, 
   decg032 LIKE decg_t.decg032, 
   decg033 LIKE decg_t.decg033, 
   decg034 LIKE decg_t.decg034, 
   decg028 LIKE decg_t.decg028, 
   decg029 LIKE decg_t.decg029, 
   decg030 LIKE decg_t.decg030, 
   decg031 LIKE decg_t.decg031, 
   decg038 LIKE decg_t.decg038
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_decf_d
DEFINE g_master_t                   type_g_decf_d
DEFINE g_decf_d          DYNAMIC ARRAY OF type_g_decf_d
DEFINE g_decf_d_t        type_g_decf_d
DEFINE g_decf3_d   DYNAMIC ARRAY OF type_g_decf3_d
DEFINE g_decf3_d_t type_g_decf3_d
 
 
      
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
 
{<section id="adeq150.main" >}
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
   DECLARE adeq150_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq150_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq150_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq150 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq150_init()   
 
      #進入選單 Menu (="N")
      CALL adeq150_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq150
      
   END IF 
   
   CLOSE adeq150_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq150.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq150_init()
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
   
      CALL cl_set_combo_scc('b_decf001','6540') 
   CALL cl_set_combo_scc('b_decf006','6200') 
   CALL cl_set_combo_scc('b_decf007','6203') 
   CALL cl_set_combo_scc('b_decf008','6201') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   CALL adeq150_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq150.default_search" >}
PRIVATE FUNCTION adeq150_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " decfsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " decf005 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " decf009 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " decf014 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " decf015 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " decf017 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " decf018 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " decf020 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " decf041 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " decf042 = '", g_argv[10], "' AND "
   END IF
   IF NOT cl_null(g_argv[11]) THEN
      LET g_wc = g_wc, " decf043 = '", g_argv[11], "' AND "
   END IF
   IF NOT cl_null(g_argv[12]) THEN
      LET g_wc = g_wc, " decf049 = '", g_argv[12], "' AND "
   END IF
   IF NOT cl_null(g_argv[13]) THEN
      LET g_wc = g_wc, " decf053 = '", g_argv[13], "' AND "
   END IF
   IF NOT cl_null(g_argv[14]) THEN
      LET g_wc = g_wc, " decf054 = '", g_argv[14], "' AND "
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
 
{<section id="adeq150.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq150_ui_dialog()
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
      CALL adeq150_b_fill()
   ELSE
      CALL adeq150_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_decf_d.clear()
         CALL g_decf3_d.clear()
 
 
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
 
         CALL adeq150_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_decf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq150_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq150_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_decf3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_decf3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq150_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq150_insert()
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
               CALL adeq150_query()
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
            CALL adeq150_filter()
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
            CALL adeq150_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_decf_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_decf3_d)
               LET g_export_id[2]   = "s_detail3"
 
 
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
            CALL adeq150_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq150_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq150_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq150_b_fill()
 
         
         
 
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
 
{<section id="adeq150.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq150_query()
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
   CALL g_decf_d.clear()
   CALL g_decf3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON decfsite,decf001,decf041,decf042,decf005,decf006,decf007,decf008,decf010, 
          decf009,decf011,decf012,decf043,decf013,decf014,decf015,decf016,decf017,decf018,decf019,decf020, 
          decf021,decf022,decf023,decf024,decf025,decf026,decf045,decf046,decf047,decf027,decf028,decf029, 
          decf048,decf030,decf031,decf032,decf033,decf034,decf035,decf036,decf037,decf038,decf039,decf040, 
          decf049,decf053,decf054
           FROM s_detail1[1].b_decfsite,s_detail1[1].b_decf001,s_detail1[1].b_decf041,s_detail1[1].b_decf042, 
               s_detail1[1].b_decf005,s_detail1[1].b_decf006,s_detail1[1].b_decf007,s_detail1[1].b_decf008, 
               s_detail1[1].b_decf010,s_detail1[1].b_decf009,s_detail1[1].b_decf011,s_detail1[1].b_decf012, 
               s_detail1[1].b_decf043,s_detail1[1].b_decf013,s_detail1[1].b_decf014,s_detail1[1].b_decf015, 
               s_detail1[1].b_decf016,s_detail1[1].b_decf017,s_detail1[1].b_decf018,s_detail1[1].b_decf019, 
               s_detail1[1].b_decf020,s_detail1[1].b_decf021,s_detail1[1].b_decf022,s_detail1[1].b_decf023, 
               s_detail1[1].b_decf024,s_detail1[1].b_decf025,s_detail1[1].b_decf026,s_detail1[1].b_decf045, 
               s_detail1[1].b_decf046,s_detail1[1].b_decf047,s_detail1[1].b_decf027,s_detail1[1].b_decf028, 
               s_detail1[1].b_decf029,s_detail1[1].b_decf048,s_detail1[1].b_decf030,s_detail1[1].b_decf031, 
               s_detail1[1].b_decf032,s_detail1[1].b_decf033,s_detail1[1].b_decf034,s_detail1[1].b_decf035, 
               s_detail1[1].b_decf036,s_detail1[1].b_decf037,s_detail1[1].b_decf038,s_detail1[1].b_decf039, 
               s_detail1[1].b_decf040,s_detail1[1].b_decf049,s_detail1[1].b_decf053,s_detail1[1].b_decf054 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #150705-00001#11 20150706 add by beckxie
            DISPLAY g_site TO s_detail1[1].b_decfsite
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_decfsite>>----
         #Ctrlp:construct.c.page1.b_decfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decfsite
            #add-point:ON ACTION controlp INFIELD b_decfsite name="construct.c.page1.b_decfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decfsite  #顯示到畫面上
            NEXT FIELD b_decfsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decfsite
            #add-point:BEFORE FIELD b_decfsite name="construct.b.page1.b_decfsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decfsite
            
            #add-point:AFTER FIELD b_decfsite name="construct.a.page1.b_decfsite"
            
            #END add-point
            
 
 
         #----<<b_decfsite_desc>>----
         #----<<b_decf001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf001
            #add-point:BEFORE FIELD b_decf001 name="construct.b.page1.b_decf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf001
            
            #add-point:AFTER FIELD b_decf001 name="construct.a.page1.b_decf001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf001
            #add-point:ON ACTION controlp INFIELD b_decf001 name="construct.c.page1.b_decf001"
            
            #END add-point
 
 
         #----<<b_decf041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf041
            #add-point:BEFORE FIELD b_decf041 name="construct.b.page1.b_decf041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf041
            
            #add-point:AFTER FIELD b_decf041 name="construct.a.page1.b_decf041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf041
            #add-point:ON ACTION controlp INFIELD b_decf041 name="construct.c.page1.b_decf041"
            
            #END add-point
 
 
         #----<<b_decf042>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf042
            #add-point:BEFORE FIELD b_decf042 name="construct.b.page1.b_decf042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf042
            
            #add-point:AFTER FIELD b_decf042 name="construct.a.page1.b_decf042"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf042
            #add-point:ON ACTION controlp INFIELD b_decf042 name="construct.c.page1.b_decf042"
            
            #END add-point
 
 
         #----<<b_decf005>>----
         #Ctrlp:construct.c.page1.b_decf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf005
            #add-point:ON ACTION controlp INFIELD b_decf005 name="construct.c.page1.b_decf005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '2'
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf005  #顯示到畫面上
            NEXT FIELD b_decf005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf005
            #add-point:BEFORE FIELD b_decf005 name="construct.b.page1.b_decf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf005
            
            #add-point:AFTER FIELD b_decf005 name="construct.a.page1.b_decf005"
            
            #END add-point
            
 
 
         #----<<b_decf005_desc>>----
         #----<<b_decf006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf006
            #add-point:BEFORE FIELD b_decf006 name="construct.b.page1.b_decf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf006
            
            #add-point:AFTER FIELD b_decf006 name="construct.a.page1.b_decf006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf006
            #add-point:ON ACTION controlp INFIELD b_decf006 name="construct.c.page1.b_decf006"
            
            #END add-point
 
 
         #----<<b_decf007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf007
            #add-point:BEFORE FIELD b_decf007 name="construct.b.page1.b_decf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf007
            
            #add-point:AFTER FIELD b_decf007 name="construct.a.page1.b_decf007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf007
            #add-point:ON ACTION controlp INFIELD b_decf007 name="construct.c.page1.b_decf007"
            
            #END add-point
 
 
         #----<<b_decf008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf008
            #add-point:BEFORE FIELD b_decf008 name="construct.b.page1.b_decf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf008
            
            #add-point:AFTER FIELD b_decf008 name="construct.a.page1.b_decf008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf008
            #add-point:ON ACTION controlp INFIELD b_decf008 name="construct.c.page1.b_decf008"
            
            #END add-point
 
 
         #----<<b_decf010>>----
         #Ctrlp:construct.c.page1.b_decf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf010
            #add-point:ON ACTION controlp INFIELD b_decf010 name="construct.c.page1.b_decf010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf010  #顯示到畫面上
            NEXT FIELD b_decf010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf010
            #add-point:BEFORE FIELD b_decf010 name="construct.b.page1.b_decf010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf010
            
            #add-point:AFTER FIELD b_decf010 name="construct.a.page1.b_decf010"
            
            #END add-point
            
 
 
         #----<<b_decf009>>----
         #Ctrlp:construct.c.page1.b_decf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf009
            #add-point:ON ACTION controlp INFIELD b_decf009 name="construct.c.page1.b_decf009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf009  #顯示到畫面上
            NEXT FIELD b_decf009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf009
            #add-point:BEFORE FIELD b_decf009 name="construct.b.page1.b_decf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf009
            
            #add-point:AFTER FIELD b_decf009 name="construct.a.page1.b_decf009"
            
            #END add-point
            
 
 
         #----<<b_decf011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf011
            #add-point:BEFORE FIELD b_decf011 name="construct.b.page1.b_decf011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf011
            
            #add-point:AFTER FIELD b_decf011 name="construct.a.page1.b_decf011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf011
            #add-point:ON ACTION controlp INFIELD b_decf011 name="construct.c.page1.b_decf011"
            
            #END add-point
 
 
         #----<<b_decf012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf012
            #add-point:BEFORE FIELD b_decf012 name="construct.b.page1.b_decf012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf012
            
            #add-point:AFTER FIELD b_decf012 name="construct.a.page1.b_decf012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf012
            #add-point:ON ACTION controlp INFIELD b_decf012 name="construct.c.page1.b_decf012"
            
            #END add-point
 
 
         #----<<b_decf043>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf043
            #add-point:BEFORE FIELD b_decf043 name="construct.b.page1.b_decf043"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf043
            
            #add-point:AFTER FIELD b_decf043 name="construct.a.page1.b_decf043"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf043
            #add-point:ON ACTION controlp INFIELD b_decf043 name="construct.c.page1.b_decf043"
            
            #END add-point
 
 
         #----<<decf043_desc>>----
         #----<<b_decf013>>----
         #Ctrlp:construct.c.page1.b_decf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf013
            #add-point:ON ACTION controlp INFIELD b_decf013 name="construct.c.page1.b_decf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2002'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf013  #顯示到畫面上
            NEXT FIELD b_decf013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf013
            #add-point:BEFORE FIELD b_decf013 name="construct.b.page1.b_decf013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf013
            
            #add-point:AFTER FIELD b_decf013 name="construct.a.page1.b_decf013"
            
            #END add-point
            
 
 
         #----<<b_decf013_desc>>----
         #----<<b_decf014>>----
         #Ctrlp:construct.c.page1.b_decf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf014
            #add-point:ON ACTION controlp INFIELD b_decf014 name="construct.c.page1.b_decf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf014  #顯示到畫面上
            NEXT FIELD b_decf014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf014
            #add-point:BEFORE FIELD b_decf014 name="construct.b.page1.b_decf014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf014
            
            #add-point:AFTER FIELD b_decf014 name="construct.a.page1.b_decf014"
            
            #END add-point
            
 
 
         #----<<b_decf014_desc>>----
         #----<<b_decf015>>----
         #Ctrlp:construct.c.page1.b_decf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf015
            #add-point:ON ACTION controlp INFIELD b_decf015 name="construct.c.page1.b_decf015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf015  #顯示到畫面上
            NEXT FIELD b_decf015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf015
            #add-point:BEFORE FIELD b_decf015 name="construct.b.page1.b_decf015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf015
            
            #add-point:AFTER FIELD b_decf015 name="construct.a.page1.b_decf015"
            
            #END add-point
            
 
 
         #----<<b_decf015_desc>>----
         #----<<b_decf016>>----
         #Ctrlp:construct.c.page1.b_decf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf016
            #add-point:ON ACTION controlp INFIELD b_decf016 name="construct.c.page1.b_decf016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf016  #顯示到畫面上
            NEXT FIELD b_decf016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf016
            #add-point:BEFORE FIELD b_decf016 name="construct.b.page1.b_decf016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf016
            
            #add-point:AFTER FIELD b_decf016 name="construct.a.page1.b_decf016"
            
            #END add-point
            
 
 
         #----<<b_decf016_desc>>----
         #----<<b_decf017>>----
         #Ctrlp:construct.c.page1.b_decf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf017
            #add-point:ON ACTION controlp INFIELD b_decf017 name="construct.c.page1.b_decf017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf017  #顯示到畫面上
            NEXT FIELD b_decf017                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf017
            #add-point:BEFORE FIELD b_decf017 name="construct.b.page1.b_decf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf017
            
            #add-point:AFTER FIELD b_decf017 name="construct.a.page1.b_decf017"
            
            #END add-point
            
 
 
         #----<<b_decf017_desc>>----
         #----<<b_decf018>>----
         #Ctrlp:construct.c.page1.b_decf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf018
            #add-point:ON ACTION controlp INFIELD b_decf018 name="construct.c.page1.b_decf018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf018  #顯示到畫面上
            NEXT FIELD b_decf018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf018
            #add-point:BEFORE FIELD b_decf018 name="construct.b.page1.b_decf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf018
            
            #add-point:AFTER FIELD b_decf018 name="construct.a.page1.b_decf018"
            
            #END add-point
            
 
 
         #----<<b_decf018_desc>>----
         #----<<b_decf019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf019
            #add-point:BEFORE FIELD b_decf019 name="construct.b.page1.b_decf019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf019
            
            #add-point:AFTER FIELD b_decf019 name="construct.a.page1.b_decf019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf019
            #add-point:ON ACTION controlp INFIELD b_decf019 name="construct.c.page1.b_decf019"
            
            #END add-point
 
 
         #----<<b_decf020>>----
         #Ctrlp:construct.c.page1.b_decf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf020
            #add-point:ON ACTION controlp INFIELD b_decf020 name="construct.c.page1.b_decf020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf020  #顯示到畫面上
            NEXT FIELD b_decf020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf020
            #add-point:BEFORE FIELD b_decf020 name="construct.b.page1.b_decf020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf020
            
            #add-point:AFTER FIELD b_decf020 name="construct.a.page1.b_decf020"
            
            #END add-point
            
 
 
         #----<<b_decf020_desc>>----
         #----<<b_decf021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf021
            #add-point:BEFORE FIELD b_decf021 name="construct.b.page1.b_decf021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf021
            
            #add-point:AFTER FIELD b_decf021 name="construct.a.page1.b_decf021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf021
            #add-point:ON ACTION controlp INFIELD b_decf021 name="construct.c.page1.b_decf021"
            
            #END add-point
 
 
         #----<<b_decf022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf022
            #add-point:BEFORE FIELD b_decf022 name="construct.b.page1.b_decf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf022
            
            #add-point:AFTER FIELD b_decf022 name="construct.a.page1.b_decf022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf022
            #add-point:ON ACTION controlp INFIELD b_decf022 name="construct.c.page1.b_decf022"
            
            #END add-point
 
 
         #----<<b_decf023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf023
            #add-point:BEFORE FIELD b_decf023 name="construct.b.page1.b_decf023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf023
            
            #add-point:AFTER FIELD b_decf023 name="construct.a.page1.b_decf023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf023
            #add-point:ON ACTION controlp INFIELD b_decf023 name="construct.c.page1.b_decf023"
            
            #END add-point
 
 
         #----<<b_decf024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf024
            #add-point:BEFORE FIELD b_decf024 name="construct.b.page1.b_decf024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf024
            
            #add-point:AFTER FIELD b_decf024 name="construct.a.page1.b_decf024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf024
            #add-point:ON ACTION controlp INFIELD b_decf024 name="construct.c.page1.b_decf024"
            
            #END add-point
 
 
         #----<<b_decf025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf025
            #add-point:BEFORE FIELD b_decf025 name="construct.b.page1.b_decf025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf025
            
            #add-point:AFTER FIELD b_decf025 name="construct.a.page1.b_decf025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf025
            #add-point:ON ACTION controlp INFIELD b_decf025 name="construct.c.page1.b_decf025"
            
            #END add-point
 
 
         #----<<b_decf026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf026
            #add-point:BEFORE FIELD b_decf026 name="construct.b.page1.b_decf026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf026
            
            #add-point:AFTER FIELD b_decf026 name="construct.a.page1.b_decf026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf026
            #add-point:ON ACTION controlp INFIELD b_decf026 name="construct.c.page1.b_decf026"
            
            #END add-point
 
 
         #----<<b_decf045>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf045
            #add-point:BEFORE FIELD b_decf045 name="construct.b.page1.b_decf045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf045
            
            #add-point:AFTER FIELD b_decf045 name="construct.a.page1.b_decf045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf045
            #add-point:ON ACTION controlp INFIELD b_decf045 name="construct.c.page1.b_decf045"
            
            #END add-point
 
 
         #----<<b_decf046>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf046
            #add-point:BEFORE FIELD b_decf046 name="construct.b.page1.b_decf046"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf046
            
            #add-point:AFTER FIELD b_decf046 name="construct.a.page1.b_decf046"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf046
            #add-point:ON ACTION controlp INFIELD b_decf046 name="construct.c.page1.b_decf046"
            
            #END add-point
 
 
         #----<<b_decf047>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf047
            #add-point:BEFORE FIELD b_decf047 name="construct.b.page1.b_decf047"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf047
            
            #add-point:AFTER FIELD b_decf047 name="construct.a.page1.b_decf047"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf047
            #add-point:ON ACTION controlp INFIELD b_decf047 name="construct.c.page1.b_decf047"
            
            #END add-point
 
 
         #----<<b_decf027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf027
            #add-point:BEFORE FIELD b_decf027 name="construct.b.page1.b_decf027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf027
            
            #add-point:AFTER FIELD b_decf027 name="construct.a.page1.b_decf027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf027
            #add-point:ON ACTION controlp INFIELD b_decf027 name="construct.c.page1.b_decf027"
            
            #END add-point
 
 
         #----<<b_decf028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf028
            #add-point:BEFORE FIELD b_decf028 name="construct.b.page1.b_decf028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf028
            
            #add-point:AFTER FIELD b_decf028 name="construct.a.page1.b_decf028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf028
            #add-point:ON ACTION controlp INFIELD b_decf028 name="construct.c.page1.b_decf028"
            
            #END add-point
 
 
         #----<<b_decf029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf029
            #add-point:BEFORE FIELD b_decf029 name="construct.b.page1.b_decf029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf029
            
            #add-point:AFTER FIELD b_decf029 name="construct.a.page1.b_decf029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf029
            #add-point:ON ACTION controlp INFIELD b_decf029 name="construct.c.page1.b_decf029"
            
            #END add-point
 
 
         #----<<b_decf048>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf048
            #add-point:BEFORE FIELD b_decf048 name="construct.b.page1.b_decf048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf048
            
            #add-point:AFTER FIELD b_decf048 name="construct.a.page1.b_decf048"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf048
            #add-point:ON ACTION controlp INFIELD b_decf048 name="construct.c.page1.b_decf048"
            
            #END add-point
 
 
         #----<<b_decf030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf030
            #add-point:BEFORE FIELD b_decf030 name="construct.b.page1.b_decf030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf030
            
            #add-point:AFTER FIELD b_decf030 name="construct.a.page1.b_decf030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf030
            #add-point:ON ACTION controlp INFIELD b_decf030 name="construct.c.page1.b_decf030"
            
            #END add-point
 
 
         #----<<b_decf031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf031
            #add-point:BEFORE FIELD b_decf031 name="construct.b.page1.b_decf031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf031
            
            #add-point:AFTER FIELD b_decf031 name="construct.a.page1.b_decf031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf031
            #add-point:ON ACTION controlp INFIELD b_decf031 name="construct.c.page1.b_decf031"
            
            #END add-point
 
 
         #----<<b_decf032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf032
            #add-point:BEFORE FIELD b_decf032 name="construct.b.page1.b_decf032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf032
            
            #add-point:AFTER FIELD b_decf032 name="construct.a.page1.b_decf032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf032
            #add-point:ON ACTION controlp INFIELD b_decf032 name="construct.c.page1.b_decf032"
            
            #END add-point
 
 
         #----<<b_decf033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf033
            #add-point:BEFORE FIELD b_decf033 name="construct.b.page1.b_decf033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf033
            
            #add-point:AFTER FIELD b_decf033 name="construct.a.page1.b_decf033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf033
            #add-point:ON ACTION controlp INFIELD b_decf033 name="construct.c.page1.b_decf033"
            
            #END add-point
 
 
         #----<<b_decf034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf034
            #add-point:BEFORE FIELD b_decf034 name="construct.b.page1.b_decf034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf034
            
            #add-point:AFTER FIELD b_decf034 name="construct.a.page1.b_decf034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf034
            #add-point:ON ACTION controlp INFIELD b_decf034 name="construct.c.page1.b_decf034"
            
            #END add-point
 
 
         #----<<b_decf035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf035
            #add-point:BEFORE FIELD b_decf035 name="construct.b.page1.b_decf035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf035
            
            #add-point:AFTER FIELD b_decf035 name="construct.a.page1.b_decf035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf035
            #add-point:ON ACTION controlp INFIELD b_decf035 name="construct.c.page1.b_decf035"
            
            #END add-point
 
 
         #----<<b_decf036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf036
            #add-point:BEFORE FIELD b_decf036 name="construct.b.page1.b_decf036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf036
            
            #add-point:AFTER FIELD b_decf036 name="construct.a.page1.b_decf036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf036
            #add-point:ON ACTION controlp INFIELD b_decf036 name="construct.c.page1.b_decf036"
            
            #END add-point
 
 
         #----<<b_decf037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf037
            #add-point:BEFORE FIELD b_decf037 name="construct.b.page1.b_decf037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf037
            
            #add-point:AFTER FIELD b_decf037 name="construct.a.page1.b_decf037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf037
            #add-point:ON ACTION controlp INFIELD b_decf037 name="construct.c.page1.b_decf037"
            
            #END add-point
 
 
         #----<<b_decf038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf038
            #add-point:BEFORE FIELD b_decf038 name="construct.b.page1.b_decf038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf038
            
            #add-point:AFTER FIELD b_decf038 name="construct.a.page1.b_decf038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf038
            #add-point:ON ACTION controlp INFIELD b_decf038 name="construct.c.page1.b_decf038"
            
            #END add-point
 
 
         #----<<b_decf039>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf039
            #add-point:BEFORE FIELD b_decf039 name="construct.b.page1.b_decf039"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf039
            
            #add-point:AFTER FIELD b_decf039 name="construct.a.page1.b_decf039"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf039
            #add-point:ON ACTION controlp INFIELD b_decf039 name="construct.c.page1.b_decf039"
            
            #END add-point
 
 
         #----<<b_decf040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf040
            #add-point:BEFORE FIELD b_decf040 name="construct.b.page1.b_decf040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf040
            
            #add-point:AFTER FIELD b_decf040 name="construct.a.page1.b_decf040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf040
            #add-point:ON ACTION controlp INFIELD b_decf040 name="construct.c.page1.b_decf040"
            
            #END add-point
 
 
         #----<<b_decf049>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf049
            #add-point:BEFORE FIELD b_decf049 name="construct.b.page1.b_decf049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf049
            
            #add-point:AFTER FIELD b_decf049 name="construct.a.page1.b_decf049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf049
            #add-point:ON ACTION controlp INFIELD b_decf049 name="construct.c.page1.b_decf049"
            
            #END add-point
 
 
         #----<<b_decf053>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf053
            #add-point:BEFORE FIELD b_decf053 name="construct.b.page1.b_decf053"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf053
            
            #add-point:AFTER FIELD b_decf053 name="construct.a.page1.b_decf053"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf053
            #add-point:ON ACTION controlp INFIELD b_decf053 name="construct.c.page1.b_decf053"
            
            #END add-point
 
 
         #----<<b_decf054>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decf054
            #add-point:BEFORE FIELD b_decf054 name="construct.b.page1.b_decf054"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decf054
            
            #add-point:AFTER FIELD b_decf054 name="construct.a.page1.b_decf054"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decf054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf054
            #add-point:ON ACTION controlp INFIELD b_decf054 name="construct.c.page1.b_decf054"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON decg020,decg021,decg022,decg023,decg027,decg032,decg033,decg034,decg028, 
          decg029,decg030,decg031,decg038
           FROM s_detail3[1].b_decg020,s_detail3[1].b_decg021,s_detail3[1].b_decg022,s_detail3[1].b_decg023, 
               s_detail3[1].b_decg027,s_detail3[1].b_decg032,s_detail3[1].b_decg033,s_detail3[1].b_decg034, 
               s_detail3[1].b_decg028,s_detail3[1].b_decg029,s_detail3[1].b_decg030,s_detail3[1].b_decg031, 
               s_detail3[1].b_decg038
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            #150705-00001#11 20150706 add by beckxie
            DISPLAY '' TO s_detail3[1].b_decg020
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_decg020>>----
         #Ctrlp:construct.c.page3.b_decg020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg020
            #add-point:ON ACTION controlp INFIELD b_decg020 name="construct.c.page3.b_decg020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decg020  #顯示到畫面上
            NEXT FIELD b_decg020                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg020
            #add-point:BEFORE FIELD b_decg020 name="construct.b.page3.b_decg020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg020
            
            #add-point:AFTER FIELD b_decg020 name="construct.a.page3.b_decg020"
            
            #END add-point
            
 
 
         #----<<b_decg020_desc>>----
         #----<<b_decg021>>----
         #Ctrlp:construct.c.page3.b_decg021
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg021
            #add-point:ON ACTION controlp INFIELD b_decg021 name="construct.c.page3.b_decg021"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2024'
            CALL q_oocq002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decg021  #顯示到畫面上
            NEXT FIELD b_decg021                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg021
            #add-point:BEFORE FIELD b_decg021 name="construct.b.page3.b_decg021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg021
            
            #add-point:AFTER FIELD b_decg021 name="construct.a.page3.b_decg021"
            
            #END add-point
            
 
 
         #----<<b_decg021_desc>>----
         #----<<b_decg022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg022
            #add-point:BEFORE FIELD b_decg022 name="construct.b.page3.b_decg022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg022
            
            #add-point:AFTER FIELD b_decg022 name="construct.a.page3.b_decg022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg022
            #add-point:ON ACTION controlp INFIELD b_decg022 name="construct.c.page3.b_decg022"
            
            #END add-point
 
 
         #----<<b_decg023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg023
            #add-point:BEFORE FIELD b_decg023 name="construct.b.page3.b_decg023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg023
            
            #add-point:AFTER FIELD b_decg023 name="construct.a.page3.b_decg023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg023
            #add-point:ON ACTION controlp INFIELD b_decg023 name="construct.c.page3.b_decg023"
            
            #END add-point
 
 
         #----<<b_decg027>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg027
            #add-point:BEFORE FIELD b_decg027 name="construct.b.page3.b_decg027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg027
            
            #add-point:AFTER FIELD b_decg027 name="construct.a.page3.b_decg027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg027
            #add-point:ON ACTION controlp INFIELD b_decg027 name="construct.c.page3.b_decg027"
            
            #END add-point
 
 
         #----<<b_decg032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg032
            #add-point:BEFORE FIELD b_decg032 name="construct.b.page3.b_decg032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg032
            
            #add-point:AFTER FIELD b_decg032 name="construct.a.page3.b_decg032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg032
            #add-point:ON ACTION controlp INFIELD b_decg032 name="construct.c.page3.b_decg032"
            
            #END add-point
 
 
         #----<<b_decg033>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg033
            #add-point:BEFORE FIELD b_decg033 name="construct.b.page3.b_decg033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg033
            
            #add-point:AFTER FIELD b_decg033 name="construct.a.page3.b_decg033"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg033
            #add-point:ON ACTION controlp INFIELD b_decg033 name="construct.c.page3.b_decg033"
            
            #END add-point
 
 
         #----<<b_decg034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg034
            #add-point:BEFORE FIELD b_decg034 name="construct.b.page3.b_decg034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg034
            
            #add-point:AFTER FIELD b_decg034 name="construct.a.page3.b_decg034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg034
            #add-point:ON ACTION controlp INFIELD b_decg034 name="construct.c.page3.b_decg034"
            
            #END add-point
 
 
         #----<<b_decg028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg028
            #add-point:BEFORE FIELD b_decg028 name="construct.b.page3.b_decg028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg028
            
            #add-point:AFTER FIELD b_decg028 name="construct.a.page3.b_decg028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg028
            #add-point:ON ACTION controlp INFIELD b_decg028 name="construct.c.page3.b_decg028"
            
            #END add-point
 
 
         #----<<b_decg029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg029
            #add-point:BEFORE FIELD b_decg029 name="construct.b.page3.b_decg029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg029
            
            #add-point:AFTER FIELD b_decg029 name="construct.a.page3.b_decg029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg029
            #add-point:ON ACTION controlp INFIELD b_decg029 name="construct.c.page3.b_decg029"
            
            #END add-point
 
 
         #----<<b_decg030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg030
            #add-point:BEFORE FIELD b_decg030 name="construct.b.page3.b_decg030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg030
            
            #add-point:AFTER FIELD b_decg030 name="construct.a.page3.b_decg030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg030
            #add-point:ON ACTION controlp INFIELD b_decg030 name="construct.c.page3.b_decg030"
            
            #END add-point
 
 
         #----<<b_decg031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg031
            #add-point:BEFORE FIELD b_decg031 name="construct.b.page3.b_decg031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg031
            
            #add-point:AFTER FIELD b_decg031 name="construct.a.page3.b_decg031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg031
            #add-point:ON ACTION controlp INFIELD b_decg031 name="construct.c.page3.b_decg031"
            
            #END add-point
 
 
         #----<<b_decg038>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decg038
            #add-point:BEFORE FIELD b_decg038 name="construct.b.page3.b_decg038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decg038
            
            #add-point:AFTER FIELD b_decg038 name="construct.a.page3.b_decg038"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decg038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decg038
            #add-point:ON ACTION controlp INFIELD b_decg038 name="construct.c.page3.b_decg038"
            
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
   CALL adeq150_b_fill()
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
 
{<section id="adeq150.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq150_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'decfsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE decfsite,'',decf001,decf041,decf042,decf005,'',decf006,decf007, 
       decf008,decf010,decf009,decf011,decf012,decf043,'',decf013,'',decf014,'',decf015,'',decf016,'', 
       decf017,'',decf018,'',decf019,decf020,'',decf021,decf022,decf023,decf024,decf025,decf026,decf045, 
       decf046,decf047,decf027,decf028,decf029,decf048,decf030,decf031,decf032,decf033,decf034,decf035, 
       decf036,decf037,decf038,decf039,decf040,decf049,decf053,decf054  ,DENSE_RANK() OVER( ORDER BY decf_t.decfsite, 
       decf_t.decf005,decf_t.decf009,decf_t.decf014,decf_t.decf015,decf_t.decf017,decf_t.decf018,decf_t.decf020, 
       decf_t.decf041,decf_t.decf042,decf_t.decf043,decf_t.decf049,decf_t.decf053,decf_t.decf054) AS RANK FROM decf_t", 
 
 
                     " LEFT JOIN decg_t ON decgent = decfent AND decfsite = decgsite AND decf005 = decg005 AND decf009 = decg009 AND decf014 = decg014 AND decf015 = decg015 AND decf017 = decg017 AND decf018 = decg018 AND decf020 = decg019 AND decf041 = decg035 AND decf042 = decg036 AND decf043 = decg037 AND decf049 = decg039 AND decf053 = decg040 AND decf054 = decg041",
 
 
                     "",
                     " WHERE decfent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decf_t"),
                     " ORDER BY decf_t.decfsite,decf_t.decf005,decf_t.decf009,decf_t.decf014,decf_t.decf015,decf_t.decf017,decf_t.decf018,decf_t.decf020,decf_t.decf041,decf_t.decf042,decf_t.decf043,decf_t.decf049,decf_t.decf053,decf_t.decf054"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 20150909 s983961--mark and mod(s) 效能調整   
   #LET ls_sql_rank = "SELECT UNIQUE ",
   #            "              decfsite,    t1.ooefl001 decfsite_desc, decf001,     decf041, decf042, ",
   #            "              decf005,     t2.inayl003 decf005_desc, decf006,     decf007, ",
   #            "              decf008,     decf010,     decf009,     decf011, decf012, decf043, '',",   
   #            "              decf013,     decf014,     t3.pmaal003 decf014_desc, decf015, t4.staal003 decf015_desc, ",
   #            "              decf016,     t5.rtaxl003 decf016_desc, decf017,     decf018, t6.oodbl004 decf018_desc, ",
   #            "              decf019,     decf020,     decf021,     decf022, decf023, ",
   #            "              decf024,     decf025,     decf026,     decf045, decf046,decf047,   ",  
   #            "              decf027,     decf028, ",
   #            #"              decf029,     decf030,     decf031,     decf032, decf033, ",   #150705-00001#11 20150706 mark by beckxie
   #            "              decf029,     decf048,     decf030,     decf031,     decf032, decf033, ",   #150705-00001#11 20150706 add by beckxie
   #            "              decf034,     decf035,     decf036,     decf037, decf038,",
   #            "              decf039,     decf040,     decf049,     decf053, decf054 ",
   #            "  FROM decf_t",  
   #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = decfent AND t1.ooefl001 = decfsite AND t1.ooefl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN inayl_t t2 ON t2.inaylent = decfent AND t2.inayl001 = decf005 AND t2.inayl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN pmaal_t t3 ON t3.pmaalent = decfent AND t3.pmaal001 = decf014 AND t3.pmaal002 = '",g_dlang,"' ",
   #            "       LEFT JOIN staal_t t4 ON t4.staalent = decfent AND t4.staal001 = decf015 AND t4.staal002 = '",g_dlang,"' ",
   #            "       LEFT JOIN rtaxl_t t5 ON t5.rtaxlent = decfent AND t5.rtaxl001 = decf016 AND t5.rtaxl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN (SELECT oodblent,ooef001,oodbl002,oodbl003,oodbl004 ",
   #            "                    FROM ooef_t,oodbl_t WHERE ooefent = oodblent AND ooef019 = oodbl001) t6",
   #            "              ON t6.oodblent = decfent AND t6.ooef001 = decfsite AND t6.oodbl002 = decf018 AND t6.oodbl003 = '",g_dlang,"' ",
   #            "       LEFT JOIN decg_t ON decgent = decfent AND decfsite = decgsite  ",
   #            #"                       AND decf005 = decg005 AND decf009 = decg009 AND decf010 = decg010 ",  
   #            "                       AND decf005 = decg005 AND decf009 = decg009 ",                        
   #            "                       AND decf017 = decg017 AND decf018 = decg018 AND decf020 = decg019 ",
   #            " WHERE decfent= ? AND 1=1 AND ", ls_wc
               
      LET ls_sql_rank = "SELECT UNIQUE ",
               "                decfsite,    ",
               "                (SELECT ooefl003 FROM ooefl_t ",
               "                  WHERE ooeflent = decfent ",
               "                    AND ooefl001 = decfsite ",
               "                    AND ooefl002 ='"||g_dlang||"') decfsite_desc, ",   
               "                decf001,     decf041,   ",
               "                decf042,     decf005,   ",
               "                (SELECT inayl003 FROM inayl_t ",
               "                  WHERE inaylent = decfent ",
               "                    AND inayl001 = decf005 ",
               "                    AND inayl002 ='"||g_dlang||"') decf005_desc, ",   
               "                decf006,     decf007,   ",
               "                decf008,     decf010,   ",
               "                decf009,     decf011,   ",
               "                decf012,     decf043,'',",   
               "                decf013,",
               #151012-00012#2 20151013 add by beckxie---S
               "                (SELECT oocql004",
               "                   FROM oocql_t",
               "                  WHERE oocqlent=decfent",
               "                    AND oocql001='2002'",
               "                    AND oocql002=decf013",
               "                    AND oocql003='"||g_dlang||"') decf013_desc,",
               #151012-00012#2 20151013 add by beckxie---E
               "                decf014,   ",
               "                (SELECT pmaal003 FROM pmaal_t ",
               "                  WHERE pmaalent = decfent ",
               "                    AND pmaal001 = decf014 ",
               "                    AND pmaal002 ='"||g_dlang||"') decf014_desc, ",   
               "                decf015,  ",
               "                (SELECT staal003 FROM staal_t ",
               "                  WHERE staalent = decfent ",
               "                    AND staal001 = decf015 ",
               "                    AND staal002 ='"||g_dlang||"') decf015_desc, ",   
               "                decf016,  ",
               "                (SELECT rtaxl003 FROM rtaxl_t ",
               "                  WHERE rtaxlent = decfent ",
               "                    AND rtaxl001 = decf016 ",
               "                    AND rtaxl002 ='"||g_dlang||"') decf016_desc, ",   
               "                decf017,",
               #151012-00012#2 20151013 add by beckxie---S
               "                (SELECT mhael023",
               "                   FROM mhael_t",
               "                  WHERE mhaelent=decfent",
               "                    AND mhael001=decf017",
               "                    AND mhael022='"||g_dlang||"') decf017_desc, ",
               #151012-00012#2 20151013 add by beckxie---E
               "                decf018, ",
               "                (SELECT oodbl004 ",
               "                   FROM (SELECT oodblent,oodbl002,oodbl003,oodbl004,ooef001",
               "                           FROM ooef_t,oodbl_t ",
               "                          WHERE ooefent = oodblent AND ooef019 = oodbl001) ",
               "                  WHERE oodblent = decfent ",
               "                    AND ooef001 = decfsite",
               "                    AND oodbl002 = decf018 ",
               "                    AND oodbl003 ='"||g_dlang||"') decf018_desc, ", 
               "                decf019,     decf020,",
               #151012-00012#2 20151013 add by beckxie---S
               "                (SELECT oocal003",
               "                   FROM oocal_t",
               "                  WHERE oocalent=decfent",
               "                    AND oocal001=decf020",
               "                    AND oocal002='"||g_dlang||"') decf020_desc, ",
               #151012-00012#2 20151013 add by beckxie---E
               "                decf021,   decf022,  decf023, ",
               "                decf024,     decf025,     decf026,   decf045,  decf046, ",  
               "                decf047,      decf027,    decf028,   decf029,          ",
               #"                decf029,     decf030,     decf031,     decf032, decf033, ",   #150705-00001#11 20150706 mark by beckxie
               "                decf048,     decf030,     decf031,   decf032,  decf033, ",   #150705-00001#11 20150706 add by beckxie
               "                decf034,     decf035,     decf036,   decf037,  decf038,",
               "                decf039,     decf040,     decf049,   decf053,  decf054 ",
               "  FROM decf_t",  
               "       LEFT JOIN decg_t ON decgent = decfent AND decfsite = decgsite  ",  
               "                       AND decf005 = decg005 AND decf009 = decg009 AND decf014 = decg014 ",
               "                       AND decf015 = decg015 AND decf009 = decg009 AND decf017 = decg017 ", 
               "                       AND decf018 = decg018 AND decf020 = decg019 AND decf041 = decg035 ",
               "                       AND decf042 = decg036 AND decf043 = decg037 AND decf049 = decg039 ",
               "                       AND decf053 = decg040 AND decf054 = decg041 ",                 
               " WHERE decfent= ? AND 1=1 AND ", ls_wc
      #150826-00013#2 20150909 s983961--mark and mod(e) 效能調整            
      LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decf_t"),
                     " ORDER BY decf_t.decfsite,decf_t.decf005,decf_t.decf009,decf_t.decf017,decf_t.decf018,decf_t.decf020,decf_t.decf041,decf_t.decf042,decf_t.decf043"
 
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
 
   LET g_sql = "SELECT decfsite,'',decf001,decf041,decf042,decf005,'',decf006,decf007,decf008,decf010, 
       decf009,decf011,decf012,decf043,'',decf013,'',decf014,'',decf015,'',decf016,'',decf017,'',decf018, 
       '',decf019,decf020,'',decf021,decf022,decf023,decf024,decf025,decf026,decf045,decf046,decf047, 
       decf027,decf028,decf029,decf048,decf030,decf031,decf032,decf033,decf034,decf035,decf036,decf037, 
       decf038,decf039,decf040,decf049,decf053,decf054",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT decfsite,decfsite_desc,decf001,decf041,decf042,",
               "        decf005,decf005_desc,decf006,decf007,decf008,",
               "        decf010,decf009,decf011,decf012,decf043,",
               "        '',decf013,decf013_desc,decf014,decf014_desc,",
               "        decf015,decf015_desc,decf016,decf016_desc,decf017,",
               "        decf017_desc,decf018,decf018_desc,decf019,decf020,decf020_desc,",
               "        decf021,decf022,decf023,decf024,decf025,",
               "        decf026,decf045,decf046,decf047,decf027,",
               "        decf028,decf029,decf048,decf030,decf031,",
               "        decf032,decf033,decf034,decf035,decf036,",
               "        decf037,decf038,decf039,decf040,decf049,",
               "        decf053,decf054",
               "  FROM (",ls_sql_rank,")"
#              " WHERE RANK >= ",g_pagestart,
#                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq150_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq150_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_decf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_decf_d[l_ac].decfsite,g_decf_d[l_ac].decfsite_desc,g_decf_d[l_ac].decf001, 
       g_decf_d[l_ac].decf041,g_decf_d[l_ac].decf042,g_decf_d[l_ac].decf005,g_decf_d[l_ac].decf005_desc, 
       g_decf_d[l_ac].decf006,g_decf_d[l_ac].decf007,g_decf_d[l_ac].decf008,g_decf_d[l_ac].decf010,g_decf_d[l_ac].decf009, 
       g_decf_d[l_ac].decf011,g_decf_d[l_ac].decf012,g_decf_d[l_ac].decf043,g_decf_d[l_ac].decf043_desc, 
       g_decf_d[l_ac].decf013,g_decf_d[l_ac].decf013_desc,g_decf_d[l_ac].decf014,g_decf_d[l_ac].decf014_desc, 
       g_decf_d[l_ac].decf015,g_decf_d[l_ac].decf015_desc,g_decf_d[l_ac].decf016,g_decf_d[l_ac].decf016_desc, 
       g_decf_d[l_ac].decf017,g_decf_d[l_ac].decf017_desc,g_decf_d[l_ac].decf018,g_decf_d[l_ac].decf018_desc, 
       g_decf_d[l_ac].decf019,g_decf_d[l_ac].decf020,g_decf_d[l_ac].decf020_desc,g_decf_d[l_ac].decf021, 
       g_decf_d[l_ac].decf022,g_decf_d[l_ac].decf023,g_decf_d[l_ac].decf024,g_decf_d[l_ac].decf025,g_decf_d[l_ac].decf026, 
       g_decf_d[l_ac].decf045,g_decf_d[l_ac].decf046,g_decf_d[l_ac].decf047,g_decf_d[l_ac].decf027,g_decf_d[l_ac].decf028, 
       g_decf_d[l_ac].decf029,g_decf_d[l_ac].decf048,g_decf_d[l_ac].decf030,g_decf_d[l_ac].decf031,g_decf_d[l_ac].decf032, 
       g_decf_d[l_ac].decf033,g_decf_d[l_ac].decf034,g_decf_d[l_ac].decf035,g_decf_d[l_ac].decf036,g_decf_d[l_ac].decf037, 
       g_decf_d[l_ac].decf038,g_decf_d[l_ac].decf039,g_decf_d[l_ac].decf040,g_decf_d[l_ac].decf049,g_decf_d[l_ac].decf053, 
       g_decf_d[l_ac].decf054
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_decf_d[l_ac].statepic = cl_get_actipic(g_decf_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq150_detail_show("'1'")      
 
      CALL adeq150_decf_t_mask()
 
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
   
 
   
   CALL g_decf_d.deleteElement(g_decf_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_decf_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq150_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq150_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq150_detail_action_trans()
 
   IF g_decf_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq150_fetch()
   END IF
   
      CALL adeq150_filter_show('decfsite','b_decfsite')
   CALL adeq150_filter_show('decf001','b_decf001')
   CALL adeq150_filter_show('decf041','b_decf041')
   CALL adeq150_filter_show('decf042','b_decf042')
   CALL adeq150_filter_show('decf005','b_decf005')
   CALL adeq150_filter_show('decf006','b_decf006')
   CALL adeq150_filter_show('decf007','b_decf007')
   CALL adeq150_filter_show('decf008','b_decf008')
   CALL adeq150_filter_show('decf010','b_decf010')
   CALL adeq150_filter_show('decf009','b_decf009')
   CALL adeq150_filter_show('decf011','b_decf011')
   CALL adeq150_filter_show('decf012','b_decf012')
   CALL adeq150_filter_show('decf043','b_decf043')
   CALL adeq150_filter_show('decf013','b_decf013')
   CALL adeq150_filter_show('decf014','b_decf014')
   CALL adeq150_filter_show('decf015','b_decf015')
   CALL adeq150_filter_show('decf016','b_decf016')
   CALL adeq150_filter_show('decf017','b_decf017')
   CALL adeq150_filter_show('decf018','b_decf018')
   CALL adeq150_filter_show('decf019','b_decf019')
   CALL adeq150_filter_show('decf020','b_decf020')
   CALL adeq150_filter_show('decf021','b_decf021')
   CALL adeq150_filter_show('decf022','b_decf022')
   CALL adeq150_filter_show('decf023','b_decf023')
   CALL adeq150_filter_show('decf024','b_decf024')
   CALL adeq150_filter_show('decf025','b_decf025')
   CALL adeq150_filter_show('decf026','b_decf026')
   CALL adeq150_filter_show('decf045','b_decf045')
   CALL adeq150_filter_show('decf046','b_decf046')
   CALL adeq150_filter_show('decf047','b_decf047')
   CALL adeq150_filter_show('decf027','b_decf027')
   CALL adeq150_filter_show('decf028','b_decf028')
   CALL adeq150_filter_show('decf029','b_decf029')
   CALL adeq150_filter_show('decf048','b_decf048')
   CALL adeq150_filter_show('decf030','b_decf030')
   CALL adeq150_filter_show('decf031','b_decf031')
   CALL adeq150_filter_show('decf032','b_decf032')
   CALL adeq150_filter_show('decf033','b_decf033')
   CALL adeq150_filter_show('decf034','b_decf034')
   CALL adeq150_filter_show('decf035','b_decf035')
   CALL adeq150_filter_show('decf036','b_decf036')
   CALL adeq150_filter_show('decf037','b_decf037')
   CALL adeq150_filter_show('decf038','b_decf038')
   CALL adeq150_filter_show('decf039','b_decf039')
   CALL adeq150_filter_show('decf040','b_decf040')
   CALL adeq150_filter_show('decf049','b_decf049')
   CALL adeq150_filter_show('decf053','b_decf053')
   CALL adeq150_filter_show('decf054','b_decf054')
   CALL adeq150_filter_show('decg020','b_decg020')
   CALL adeq150_filter_show('decg021','b_decg021')
   CALL adeq150_filter_show('decg022','b_decg022')
   CALL adeq150_filter_show('decg023','b_decg023')
   CALL adeq150_filter_show('decg027','b_decg027')
   CALL adeq150_filter_show('decg032','b_decg032')
   CALL adeq150_filter_show('decg033','b_decg033')
   CALL adeq150_filter_show('decg034','b_decg034')
   CALL adeq150_filter_show('decg028','b_decg028')
   CALL adeq150_filter_show('decg029','b_decg029')
   CALL adeq150_filter_show('decg030','b_decg030')
   CALL adeq150_filter_show('decg031','b_decg031')
   CALL adeq150_filter_show('decg038','b_decg038')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq150_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_decf3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE decg020,'',decg021,'',decg022,decg023,decg027,decg032,decg033,decg034, 
          decg028,decg029,decg030,decg031,decg038 FROM decg_t",    
                  "",
                  " WHERE decgent=? AND decgsite=? AND decg005=? AND decg009=? AND decg014=? AND decg015=? AND decg017=? AND decg018=? AND decg019=? AND decg035=? AND decg036=? AND decg037=? AND decg039=? AND decg040=? AND decg041=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decg_t.decg020,decg_t.decg021" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      LET g_sql = "SELECT UNIQUE decg020, (SELECT mmanl003 FROM mmanl_t ",
                  "                         WHERE mmanlent = decgent ",
                  "                           AND mmanl001 = decg020 ",
                  "                           AND mmanl002 ='"||g_dlang||"'), ",
                  "              decg021, (SELECT oocql004 FROM oocql_t",
                  "                         WHERE oocqlent = decgent",
                  "                           AND oocql001 = '2024'",
                  "                           AND oocql002 = decg021",
                  "                           AND oocql003 ='"||g_dlang||"'), ",
                  "              decg022, decg023, decg027, decg032,",
                  "              decg033, decg034, ",
                  "              decg028, decg029, decg030, decg031, decg038 ", #160524-00023#1 Add By Ken 160601
                  "  FROM decg_t",
                  " WHERE decgent = ?",
                  "   AND decgsite = ?",
                  "   AND decg005 = ?",
                  "   AND decg009 = ?",
                  "   AND decg014 = ?",
                  "   AND decg015 = ?",
                  "   AND decg017 = ?",
                  "   AND decg018 = ?",
                  "   AND decg019 = ?",
                  "   AND decg035 = ?",
                  "   AND decg036 = ?",
                  "   AND decg037 = ?",
                  "   AND decg039 = ?",
                  "   AND decg040 = ?",
                  "   AND decg041 = ?"
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF

      LET g_sql = g_sql, " ORDER BY decg_t.decg020,decg_t.decg021"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq150_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adeq150_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_decf_d[g_detail_idx].decfsite
#                                 ,g_decf_d[g_detail_idx].decf005
 
#                                 ,g_decf_d[g_detail_idx].decf009
 
#                                 ,g_decf_d[g_detail_idx].decf014
 
#                                 ,g_decf_d[g_detail_idx].decf015
 
#                                 ,g_decf_d[g_detail_idx].decf017
 
#                                 ,g_decf_d[g_detail_idx].decf018
 
#                                 ,g_decf_d[g_detail_idx].decf020
 
#                                 ,g_decf_d[g_detail_idx].decf041
 
#                                 ,g_decf_d[g_detail_idx].decf042
 
#                                 ,g_decf_d[g_detail_idx].decf043
 
#                                 ,g_decf_d[g_detail_idx].decf049
 
#                                 ,g_decf_d[g_detail_idx].decf053
 
#                                 ,g_decf_d[g_detail_idx].decf054
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_decf_d[g_detail_idx].decfsite   #(ver:42)
                                     ,g_decf_d[g_detail_idx].decf005   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf009   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf014   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf015   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf017   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf018   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf020   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf041   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf042   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf043   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf049   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf053   #(ver:42)
 
                                     ,g_decf_d[g_detail_idx].decf054   #(ver:42)
 
 
        INTO g_decf3_d[l_ac].decg020,g_decf3_d[l_ac].decg020_desc,g_decf3_d[l_ac].decg021,g_decf3_d[l_ac].decg021_desc, 
            g_decf3_d[l_ac].decg022,g_decf3_d[l_ac].decg023,g_decf3_d[l_ac].decg027,g_decf3_d[l_ac].decg032, 
            g_decf3_d[l_ac].decg033,g_decf3_d[l_ac].decg034,g_decf3_d[l_ac].decg028,g_decf3_d[l_ac].decg029, 
            g_decf3_d[l_ac].decg030,g_decf3_d[l_ac].decg031,g_decf3_d[l_ac].decg038   #(ver:42)
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
      
      CALL adeq150_detail_show("'2'")      
 
      CALL adeq150_decg_t_mask()
 
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
   
   CALL g_decf3_d.deleteElement(g_decf3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_decf3_d.getLength()
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
 
{<section id="adeq150.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq150_detail_show(ps_page)
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

      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decfsite
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decfsite_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decfsite_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decfsite
      #LET g_ref_fields[2] = g_decf_d[l_ac].decf005
      #LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decf005_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decf005_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decf014
      #LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decf014_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decf014_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decf015
      #LET ls_sql = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decf015_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decf015_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decf016
      #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decf016_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decf016_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf_d[l_ac].decf018
      #LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl002=? AND oodbl003='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf_d[l_ac].decf018_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf_d[l_ac].decf018_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_decf3_d[l_ac].decg020
      #LET ls_sql = "SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf3_d[l_ac].decg020_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf3_d[l_ac].decg020_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_decf3_d[l_ac].decg021_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_decf3_d[l_ac].decg021_desc
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq150_filter()
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
      CONSTRUCT g_wc_filter ON decfsite,decf001,decf041,decf042,decf005,decf006,decf007,decf008,decf010, 
          decf009,decf011,decf012,decf043,decf013,decf014,decf015,decf016,decf017,decf018,decf019,decf020, 
          decf021,decf022,decf023,decf024,decf025,decf026,decf045,decf046,decf047,decf027,decf028,decf029, 
          decf048,decf030,decf031,decf032,decf033,decf034,decf035,decf036,decf037,decf038,decf039,decf040, 
          decf049,decf053,decf054
                          FROM s_detail1[1].b_decfsite,s_detail1[1].b_decf001,s_detail1[1].b_decf041, 
                              s_detail1[1].b_decf042,s_detail1[1].b_decf005,s_detail1[1].b_decf006,s_detail1[1].b_decf007, 
                              s_detail1[1].b_decf008,s_detail1[1].b_decf010,s_detail1[1].b_decf009,s_detail1[1].b_decf011, 
                              s_detail1[1].b_decf012,s_detail1[1].b_decf043,s_detail1[1].b_decf013,s_detail1[1].b_decf014, 
                              s_detail1[1].b_decf015,s_detail1[1].b_decf016,s_detail1[1].b_decf017,s_detail1[1].b_decf018, 
                              s_detail1[1].b_decf019,s_detail1[1].b_decf020,s_detail1[1].b_decf021,s_detail1[1].b_decf022, 
                              s_detail1[1].b_decf023,s_detail1[1].b_decf024,s_detail1[1].b_decf025,s_detail1[1].b_decf026, 
                              s_detail1[1].b_decf045,s_detail1[1].b_decf046,s_detail1[1].b_decf047,s_detail1[1].b_decf027, 
                              s_detail1[1].b_decf028,s_detail1[1].b_decf029,s_detail1[1].b_decf048,s_detail1[1].b_decf030, 
                              s_detail1[1].b_decf031,s_detail1[1].b_decf032,s_detail1[1].b_decf033,s_detail1[1].b_decf034, 
                              s_detail1[1].b_decf035,s_detail1[1].b_decf036,s_detail1[1].b_decf037,s_detail1[1].b_decf038, 
                              s_detail1[1].b_decf039,s_detail1[1].b_decf040,s_detail1[1].b_decf049,s_detail1[1].b_decf053, 
                              s_detail1[1].b_decf054
 
         BEFORE CONSTRUCT
                     DISPLAY adeq150_filter_parser('decfsite') TO s_detail1[1].b_decfsite
            DISPLAY adeq150_filter_parser('decf001') TO s_detail1[1].b_decf001
            DISPLAY adeq150_filter_parser('decf041') TO s_detail1[1].b_decf041
            DISPLAY adeq150_filter_parser('decf042') TO s_detail1[1].b_decf042
            DISPLAY adeq150_filter_parser('decf005') TO s_detail1[1].b_decf005
            DISPLAY adeq150_filter_parser('decf006') TO s_detail1[1].b_decf006
            DISPLAY adeq150_filter_parser('decf007') TO s_detail1[1].b_decf007
            DISPLAY adeq150_filter_parser('decf008') TO s_detail1[1].b_decf008
            DISPLAY adeq150_filter_parser('decf010') TO s_detail1[1].b_decf010
            DISPLAY adeq150_filter_parser('decf009') TO s_detail1[1].b_decf009
            DISPLAY adeq150_filter_parser('decf011') TO s_detail1[1].b_decf011
            DISPLAY adeq150_filter_parser('decf012') TO s_detail1[1].b_decf012
            DISPLAY adeq150_filter_parser('decf043') TO s_detail1[1].b_decf043
            DISPLAY adeq150_filter_parser('decf013') TO s_detail1[1].b_decf013
            DISPLAY adeq150_filter_parser('decf014') TO s_detail1[1].b_decf014
            DISPLAY adeq150_filter_parser('decf015') TO s_detail1[1].b_decf015
            DISPLAY adeq150_filter_parser('decf016') TO s_detail1[1].b_decf016
            DISPLAY adeq150_filter_parser('decf017') TO s_detail1[1].b_decf017
            DISPLAY adeq150_filter_parser('decf018') TO s_detail1[1].b_decf018
            DISPLAY adeq150_filter_parser('decf019') TO s_detail1[1].b_decf019
            DISPLAY adeq150_filter_parser('decf020') TO s_detail1[1].b_decf020
            DISPLAY adeq150_filter_parser('decf021') TO s_detail1[1].b_decf021
            DISPLAY adeq150_filter_parser('decf022') TO s_detail1[1].b_decf022
            DISPLAY adeq150_filter_parser('decf023') TO s_detail1[1].b_decf023
            DISPLAY adeq150_filter_parser('decf024') TO s_detail1[1].b_decf024
            DISPLAY adeq150_filter_parser('decf025') TO s_detail1[1].b_decf025
            DISPLAY adeq150_filter_parser('decf026') TO s_detail1[1].b_decf026
            DISPLAY adeq150_filter_parser('decf045') TO s_detail1[1].b_decf045
            DISPLAY adeq150_filter_parser('decf046') TO s_detail1[1].b_decf046
            DISPLAY adeq150_filter_parser('decf047') TO s_detail1[1].b_decf047
            DISPLAY adeq150_filter_parser('decf027') TO s_detail1[1].b_decf027
            DISPLAY adeq150_filter_parser('decf028') TO s_detail1[1].b_decf028
            DISPLAY adeq150_filter_parser('decf029') TO s_detail1[1].b_decf029
            DISPLAY adeq150_filter_parser('decf048') TO s_detail1[1].b_decf048
            DISPLAY adeq150_filter_parser('decf030') TO s_detail1[1].b_decf030
            DISPLAY adeq150_filter_parser('decf031') TO s_detail1[1].b_decf031
            DISPLAY adeq150_filter_parser('decf032') TO s_detail1[1].b_decf032
            DISPLAY adeq150_filter_parser('decf033') TO s_detail1[1].b_decf033
            DISPLAY adeq150_filter_parser('decf034') TO s_detail1[1].b_decf034
            DISPLAY adeq150_filter_parser('decf035') TO s_detail1[1].b_decf035
            DISPLAY adeq150_filter_parser('decf036') TO s_detail1[1].b_decf036
            DISPLAY adeq150_filter_parser('decf037') TO s_detail1[1].b_decf037
            DISPLAY adeq150_filter_parser('decf038') TO s_detail1[1].b_decf038
            DISPLAY adeq150_filter_parser('decf039') TO s_detail1[1].b_decf039
            DISPLAY adeq150_filter_parser('decf040') TO s_detail1[1].b_decf040
            DISPLAY adeq150_filter_parser('decf049') TO s_detail1[1].b_decf049
            DISPLAY adeq150_filter_parser('decf053') TO s_detail1[1].b_decf053
            DISPLAY adeq150_filter_parser('decf054') TO s_detail1[1].b_decf054
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_decfsite>>----
         #Ctrlp:construct.c.page1.b_decfsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decfsite
            #add-point:ON ACTION controlp INFIELD b_decfsite name="construct.c.filter.page1.b_decfsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooed004_3()                           #呼叫開窗   #161006-00008#4 by sakura mark
            #161006-00008#4 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            #161006-00008#4 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_decfsite  #顯示到畫面上
            NEXT FIELD b_decfsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decfsite_desc>>----
         #----<<b_decf001>>----
         #Ctrlp:construct.c.filter.page1.b_decf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf001
            #add-point:ON ACTION controlp INFIELD b_decf001 name="construct.c.filter.page1.b_decf001"
            
            #END add-point
 
 
         #----<<b_decf041>>----
         #Ctrlp:construct.c.filter.page1.b_decf041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf041
            #add-point:ON ACTION controlp INFIELD b_decf041 name="construct.c.filter.page1.b_decf041"
            
            #END add-point
 
 
         #----<<b_decf042>>----
         #Ctrlp:construct.c.filter.page1.b_decf042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf042
            #add-point:ON ACTION controlp INFIELD b_decf042 name="construct.c.filter.page1.b_decf042"
            
            #END add-point
 
 
         #----<<b_decf005>>----
         #Ctrlp:construct.c.page1.b_decf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf005
            #add-point:ON ACTION controlp INFIELD b_decf005 name="construct.c.filter.page1.b_decf005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf005  #顯示到畫面上
            NEXT FIELD b_decf005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf005_desc>>----
         #----<<b_decf006>>----
         #Ctrlp:construct.c.filter.page1.b_decf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf006
            #add-point:ON ACTION controlp INFIELD b_decf006 name="construct.c.filter.page1.b_decf006"
            
            #END add-point
 
 
         #----<<b_decf007>>----
         #Ctrlp:construct.c.filter.page1.b_decf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf007
            #add-point:ON ACTION controlp INFIELD b_decf007 name="construct.c.filter.page1.b_decf007"
            
            #END add-point
 
 
         #----<<b_decf008>>----
         #Ctrlp:construct.c.filter.page1.b_decf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf008
            #add-point:ON ACTION controlp INFIELD b_decf008 name="construct.c.filter.page1.b_decf008"
            
            #END add-point
 
 
         #----<<b_decf010>>----
         #Ctrlp:construct.c.page1.b_decf010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf010
            #add-point:ON ACTION controlp INFIELD b_decf010 name="construct.c.filter.page1.b_decf010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf010  #顯示到畫面上
            NEXT FIELD b_decf010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf009>>----
         #Ctrlp:construct.c.page1.b_decf009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf009
            #add-point:ON ACTION controlp INFIELD b_decf009 name="construct.c.filter.page1.b_decf009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtdx001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf009  #顯示到畫面上
            NEXT FIELD b_decf009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf011>>----
         #Ctrlp:construct.c.filter.page1.b_decf011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf011
            #add-point:ON ACTION controlp INFIELD b_decf011 name="construct.c.filter.page1.b_decf011"
            
            #END add-point
 
 
         #----<<b_decf012>>----
         #Ctrlp:construct.c.filter.page1.b_decf012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf012
            #add-point:ON ACTION controlp INFIELD b_decf012 name="construct.c.filter.page1.b_decf012"
            
            #END add-point
 
 
         #----<<b_decf043>>----
         #Ctrlp:construct.c.filter.page1.b_decf043
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf043
            #add-point:ON ACTION controlp INFIELD b_decf043 name="construct.c.filter.page1.b_decf043"
            
            #END add-point
 
 
         #----<<decf043_desc>>----
         #----<<b_decf013>>----
         #Ctrlp:construct.c.page1.b_decf013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf013
            #add-point:ON ACTION controlp INFIELD b_decf013 name="construct.c.filter.page1.b_decf013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf013  #顯示到畫面上
            NEXT FIELD b_decf013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf013_desc>>----
         #----<<b_decf014>>----
         #Ctrlp:construct.c.page1.b_decf014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf014
            #add-point:ON ACTION controlp INFIELD b_decf014 name="construct.c.filter.page1.b_decf014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf014  #顯示到畫面上
            NEXT FIELD b_decf014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf014_desc>>----
         #----<<b_decf015>>----
         #Ctrlp:construct.c.page1.b_decf015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf015
            #add-point:ON ACTION controlp INFIELD b_decf015 name="construct.c.filter.page1.b_decf015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf015  #顯示到畫面上
            NEXT FIELD b_decf015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf015_desc>>----
         #----<<b_decf016>>----
         #Ctrlp:construct.c.page1.b_decf016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf016
            #add-point:ON ACTION controlp INFIELD b_decf016 name="construct.c.filter.page1.b_decf016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf016  #顯示到畫面上
            NEXT FIELD b_decf016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf016_desc>>----
         #----<<b_decf017>>----
         #Ctrlp:construct.c.page1.b_decf017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf017
            #add-point:ON ACTION controlp INFIELD b_decf017 name="construct.c.filter.page1.b_decf017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf017  #顯示到畫面上
            NEXT FIELD b_decf017                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf017_desc>>----
         #----<<b_decf018>>----
         #Ctrlp:construct.c.page1.b_decf018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf018
            #add-point:ON ACTION controlp INFIELD b_decf018 name="construct.c.filter.page1.b_decf018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf018  #顯示到畫面上
            NEXT FIELD b_decf018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf018_desc>>----
         #----<<b_decf019>>----
         #Ctrlp:construct.c.filter.page1.b_decf019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf019
            #add-point:ON ACTION controlp INFIELD b_decf019 name="construct.c.filter.page1.b_decf019"
            
            #END add-point
 
 
         #----<<b_decf020>>----
         #Ctrlp:construct.c.page1.b_decf020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf020
            #add-point:ON ACTION controlp INFIELD b_decf020 name="construct.c.filter.page1.b_decf020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decf020  #顯示到畫面上
            NEXT FIELD b_decf020                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decf020_desc>>----
         #----<<b_decf021>>----
         #Ctrlp:construct.c.filter.page1.b_decf021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf021
            #add-point:ON ACTION controlp INFIELD b_decf021 name="construct.c.filter.page1.b_decf021"
            
            #END add-point
 
 
         #----<<b_decf022>>----
         #Ctrlp:construct.c.filter.page1.b_decf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf022
            #add-point:ON ACTION controlp INFIELD b_decf022 name="construct.c.filter.page1.b_decf022"
            
            #END add-point
 
 
         #----<<b_decf023>>----
         #Ctrlp:construct.c.filter.page1.b_decf023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf023
            #add-point:ON ACTION controlp INFIELD b_decf023 name="construct.c.filter.page1.b_decf023"
            
            #END add-point
 
 
         #----<<b_decf024>>----
         #Ctrlp:construct.c.filter.page1.b_decf024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf024
            #add-point:ON ACTION controlp INFIELD b_decf024 name="construct.c.filter.page1.b_decf024"
            
            #END add-point
 
 
         #----<<b_decf025>>----
         #Ctrlp:construct.c.filter.page1.b_decf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf025
            #add-point:ON ACTION controlp INFIELD b_decf025 name="construct.c.filter.page1.b_decf025"
            
            #END add-point
 
 
         #----<<b_decf026>>----
         #Ctrlp:construct.c.filter.page1.b_decf026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf026
            #add-point:ON ACTION controlp INFIELD b_decf026 name="construct.c.filter.page1.b_decf026"
            
            #END add-point
 
 
         #----<<b_decf045>>----
         #Ctrlp:construct.c.filter.page1.b_decf045
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf045
            #add-point:ON ACTION controlp INFIELD b_decf045 name="construct.c.filter.page1.b_decf045"
            
            #END add-point
 
 
         #----<<b_decf046>>----
         #Ctrlp:construct.c.filter.page1.b_decf046
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf046
            #add-point:ON ACTION controlp INFIELD b_decf046 name="construct.c.filter.page1.b_decf046"
            
            #END add-point
 
 
         #----<<b_decf047>>----
         #Ctrlp:construct.c.filter.page1.b_decf047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf047
            #add-point:ON ACTION controlp INFIELD b_decf047 name="construct.c.filter.page1.b_decf047"
            
            #END add-point
 
 
         #----<<b_decf027>>----
         #Ctrlp:construct.c.filter.page1.b_decf027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf027
            #add-point:ON ACTION controlp INFIELD b_decf027 name="construct.c.filter.page1.b_decf027"
            
            #END add-point
 
 
         #----<<b_decf028>>----
         #Ctrlp:construct.c.filter.page1.b_decf028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf028
            #add-point:ON ACTION controlp INFIELD b_decf028 name="construct.c.filter.page1.b_decf028"
            
            #END add-point
 
 
         #----<<b_decf029>>----
         #Ctrlp:construct.c.filter.page1.b_decf029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf029
            #add-point:ON ACTION controlp INFIELD b_decf029 name="construct.c.filter.page1.b_decf029"
            
            #END add-point
 
 
         #----<<b_decf048>>----
         #Ctrlp:construct.c.filter.page1.b_decf048
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf048
            #add-point:ON ACTION controlp INFIELD b_decf048 name="construct.c.filter.page1.b_decf048"
            
            #END add-point
 
 
         #----<<b_decf030>>----
         #Ctrlp:construct.c.filter.page1.b_decf030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf030
            #add-point:ON ACTION controlp INFIELD b_decf030 name="construct.c.filter.page1.b_decf030"
            
            #END add-point
 
 
         #----<<b_decf031>>----
         #Ctrlp:construct.c.filter.page1.b_decf031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf031
            #add-point:ON ACTION controlp INFIELD b_decf031 name="construct.c.filter.page1.b_decf031"
            
            #END add-point
 
 
         #----<<b_decf032>>----
         #Ctrlp:construct.c.filter.page1.b_decf032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf032
            #add-point:ON ACTION controlp INFIELD b_decf032 name="construct.c.filter.page1.b_decf032"
            
            #END add-point
 
 
         #----<<b_decf033>>----
         #Ctrlp:construct.c.filter.page1.b_decf033
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf033
            #add-point:ON ACTION controlp INFIELD b_decf033 name="construct.c.filter.page1.b_decf033"
            
            #END add-point
 
 
         #----<<b_decf034>>----
         #Ctrlp:construct.c.filter.page1.b_decf034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf034
            #add-point:ON ACTION controlp INFIELD b_decf034 name="construct.c.filter.page1.b_decf034"
            
            #END add-point
 
 
         #----<<b_decf035>>----
         #Ctrlp:construct.c.filter.page1.b_decf035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf035
            #add-point:ON ACTION controlp INFIELD b_decf035 name="construct.c.filter.page1.b_decf035"
            
            #END add-point
 
 
         #----<<b_decf036>>----
         #Ctrlp:construct.c.filter.page1.b_decf036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf036
            #add-point:ON ACTION controlp INFIELD b_decf036 name="construct.c.filter.page1.b_decf036"
            
            #END add-point
 
 
         #----<<b_decf037>>----
         #Ctrlp:construct.c.filter.page1.b_decf037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf037
            #add-point:ON ACTION controlp INFIELD b_decf037 name="construct.c.filter.page1.b_decf037"
            
            #END add-point
 
 
         #----<<b_decf038>>----
         #Ctrlp:construct.c.filter.page1.b_decf038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf038
            #add-point:ON ACTION controlp INFIELD b_decf038 name="construct.c.filter.page1.b_decf038"
            
            #END add-point
 
 
         #----<<b_decf039>>----
         #Ctrlp:construct.c.filter.page1.b_decf039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf039
            #add-point:ON ACTION controlp INFIELD b_decf039 name="construct.c.filter.page1.b_decf039"
            
            #END add-point
 
 
         #----<<b_decf040>>----
         #Ctrlp:construct.c.filter.page1.b_decf040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf040
            #add-point:ON ACTION controlp INFIELD b_decf040 name="construct.c.filter.page1.b_decf040"
            
            #END add-point
 
 
         #----<<b_decf049>>----
         #Ctrlp:construct.c.filter.page1.b_decf049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf049
            #add-point:ON ACTION controlp INFIELD b_decf049 name="construct.c.filter.page1.b_decf049"
            
            #END add-point
 
 
         #----<<b_decf053>>----
         #Ctrlp:construct.c.filter.page1.b_decf053
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf053
            #add-point:ON ACTION controlp INFIELD b_decf053 name="construct.c.filter.page1.b_decf053"
            
            #END add-point
 
 
         #----<<b_decf054>>----
         #Ctrlp:construct.c.filter.page1.b_decf054
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decf054
            #add-point:ON ACTION controlp INFIELD b_decf054 name="construct.c.filter.page1.b_decf054"
            
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
   
      CALL adeq150_filter_show('decfsite','b_decfsite')
   CALL adeq150_filter_show('decf001','b_decf001')
   CALL adeq150_filter_show('decf041','b_decf041')
   CALL adeq150_filter_show('decf042','b_decf042')
   CALL adeq150_filter_show('decf005','b_decf005')
   CALL adeq150_filter_show('decf006','b_decf006')
   CALL adeq150_filter_show('decf007','b_decf007')
   CALL adeq150_filter_show('decf008','b_decf008')
   CALL adeq150_filter_show('decf010','b_decf010')
   CALL adeq150_filter_show('decf009','b_decf009')
   CALL adeq150_filter_show('decf011','b_decf011')
   CALL adeq150_filter_show('decf012','b_decf012')
   CALL adeq150_filter_show('decf043','b_decf043')
   CALL adeq150_filter_show('decf013','b_decf013')
   CALL adeq150_filter_show('decf014','b_decf014')
   CALL adeq150_filter_show('decf015','b_decf015')
   CALL adeq150_filter_show('decf016','b_decf016')
   CALL adeq150_filter_show('decf017','b_decf017')
   CALL adeq150_filter_show('decf018','b_decf018')
   CALL adeq150_filter_show('decf019','b_decf019')
   CALL adeq150_filter_show('decf020','b_decf020')
   CALL adeq150_filter_show('decf021','b_decf021')
   CALL adeq150_filter_show('decf022','b_decf022')
   CALL adeq150_filter_show('decf023','b_decf023')
   CALL adeq150_filter_show('decf024','b_decf024')
   CALL adeq150_filter_show('decf025','b_decf025')
   CALL adeq150_filter_show('decf026','b_decf026')
   CALL adeq150_filter_show('decf045','b_decf045')
   CALL adeq150_filter_show('decf046','b_decf046')
   CALL adeq150_filter_show('decf047','b_decf047')
   CALL adeq150_filter_show('decf027','b_decf027')
   CALL adeq150_filter_show('decf028','b_decf028')
   CALL adeq150_filter_show('decf029','b_decf029')
   CALL adeq150_filter_show('decf048','b_decf048')
   CALL adeq150_filter_show('decf030','b_decf030')
   CALL adeq150_filter_show('decf031','b_decf031')
   CALL adeq150_filter_show('decf032','b_decf032')
   CALL adeq150_filter_show('decf033','b_decf033')
   CALL adeq150_filter_show('decf034','b_decf034')
   CALL adeq150_filter_show('decf035','b_decf035')
   CALL adeq150_filter_show('decf036','b_decf036')
   CALL adeq150_filter_show('decf037','b_decf037')
   CALL adeq150_filter_show('decf038','b_decf038')
   CALL adeq150_filter_show('decf039','b_decf039')
   CALL adeq150_filter_show('decf040','b_decf040')
   CALL adeq150_filter_show('decf049','b_decf049')
   CALL adeq150_filter_show('decf053','b_decf053')
   CALL adeq150_filter_show('decf054','b_decf054')
   CALL adeq150_filter_show('decg020','b_decg020')
   CALL adeq150_filter_show('decg021','b_decg021')
   CALL adeq150_filter_show('decg022','b_decg022')
   CALL adeq150_filter_show('decg023','b_decg023')
   CALL adeq150_filter_show('decg027','b_decg027')
   CALL adeq150_filter_show('decg032','b_decg032')
   CALL adeq150_filter_show('decg033','b_decg033')
   CALL adeq150_filter_show('decg034','b_decg034')
   CALL adeq150_filter_show('decg028','b_decg028')
   CALL adeq150_filter_show('decg029','b_decg029')
   CALL adeq150_filter_show('decg030','b_decg030')
   CALL adeq150_filter_show('decg031','b_decg031')
   CALL adeq150_filter_show('decg038','b_decg038')
 
    
   CALL adeq150_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq150_filter_parser(ps_field)
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
 
{<section id="adeq150.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq150_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq150_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.insert" >}
#+ insert
PRIVATE FUNCTION adeq150_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq150.modify" >}
#+ modify
PRIVATE FUNCTION adeq150_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq150_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.delete" >}
#+ delete
PRIVATE FUNCTION adeq150_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq150.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq150_detail_action_trans()
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
 
{<section id="adeq150.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq150_detail_index_setting()
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
            IF g_decf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_decf_d.getLength() AND g_decf_d.getLength() > 0
            LET g_detail_idx = g_decf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_decf_d.getLength() THEN
               LET g_detail_idx = g_decf_d.getLength()
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
 
{<section id="adeq150.mask_functions" >}
 &include "erp/ade/adeq150_mask.4gl"
 
{</section>}
 
{<section id="adeq150.other_function" readonly="Y" >}

 
{</section>}
 
