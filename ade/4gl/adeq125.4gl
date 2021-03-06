#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq125.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2015-12-02 16:54:13), PR版次:0010(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000245
#+ Filename...: adeq125
#+ Description: 門店銷售部門日結查詢
#+ Creator....: 02748(2014-03-13 18:57:31)
#+ Modifier...: 06815 -SD/PR- 00000
 
{</section>}
 
{<section id="adeq125.global" >}
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
PRIVATE TYPE type_g_debk_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   debksite LIKE debk_t.debksite, 
   debksite_desc LIKE type_t.chr500, 
   debk001 LIKE debk_t.debk001, 
   debk002 LIKE debk_t.debk002, 
   debk003 LIKE debk_t.debk003, 
   debk004 LIKE debk_t.debk004, 
   debk005 LIKE debk_t.debk005, 
   debk005_desc LIKE type_t.chr500, 
   debk006 LIKE debk_t.debk006, 
   debk007 LIKE debk_t.debk007, 
   debk008 LIKE debk_t.debk008, 
   debk009 LIKE debk_t.debk009, 
   debk010 LIKE debk_t.debk010, 
   debk011 LIKE debk_t.debk011, 
   debk012 LIKE debk_t.debk012, 
   debk013 LIKE debk_t.debk013, 
   debk022 LIKE debk_t.debk022, 
   debk023 LIKE debk_t.debk023, 
   debk014 LIKE debk_t.debk014, 
   debk015 LIKE debk_t.debk015, 
   debk016 LIKE debk_t.debk016, 
   debk017 LIKE debk_t.debk017, 
   debk020 LIKE debk_t.debk020, 
   debk021 LIKE debk_t.debk021, 
   debk018 LIKE debk_t.debk018, 
   debk019 LIKE debk_t.debk019 
       END RECORD
PRIVATE TYPE type_g_debk2_d RECORD
       debl006 LIKE debl_t.debl006, 
   debl006_desc LIKE type_t.chr500, 
   debl007 LIKE debl_t.debl007, 
   debl007_desc LIKE type_t.chr500, 
   debl008 LIKE debl_t.debl008, 
   debl009 LIKE debl_t.debl009, 
   debl010 LIKE debl_t.debl010, 
   debl011 LIKE debl_t.debl011, 
   debl012 LIKE debl_t.debl012, 
   debl013 LIKE debl_t.debl013, 
   debl018 LIKE debl_t.debl018, 
   debl019 LIKE debl_t.debl019, 
   debl020 LIKE debl_t.debl020, 
   debl014 LIKE debl_t.debl014, 
   debl015 LIKE debl_t.debl015, 
   debl016 LIKE debl_t.debl016, 
   debl017 LIKE debl_t.debl017
       END RECORD
 
PRIVATE TYPE type_g_debk3_d RECORD
       debm007 LIKE debm_t.debm007, 
   debm006 LIKE debm_t.debm006, 
   debm006_desc LIKE type_t.chr500, 
   debm008 LIKE debm_t.debm008
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_debk4_d RECORD
       debm007 LIKE debm_t.debm007, 
   debm006 LIKE debm_t.debm006, 
   debm006_desc_1 LIKE type_t.chr500, 
   debm008 LIKE debm_t.debm008
       END RECORD
DEFINE g_debk4_d   DYNAMIC ARRAY OF type_g_debk4_d
DEFINE g_debk4_d_t type_g_debk4_d
DEFINE g_site_type    LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_debk_d
DEFINE g_master_t                   type_g_debk_d
DEFINE g_debk_d          DYNAMIC ARRAY OF type_g_debk_d
DEFINE g_debk_d_t        type_g_debk_d
DEFINE g_debk2_d   DYNAMIC ARRAY OF type_g_debk2_d
DEFINE g_debk2_d_t type_g_debk2_d
 
DEFINE g_debk3_d   DYNAMIC ARRAY OF type_g_debk3_d
DEFINE g_debk3_d_t type_g_debk3_d
 
 
      
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
   #argv[1] type_t.chr1 #組織類型
#end add-point
 
{</section>}
 
{<section id="adeq125.main" >}
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
   LET g_site_type = g_argv[1]
   IF cl_null(g_site_type) THEN
      LET g_site_type = '2'
   END IF
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
   DECLARE adeq125_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq125_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq125_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq125 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq125_init()   
 
      #進入選單 Menu (="N")
      CALL adeq125_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq125
      
   END IF 
   
   CLOSE adeq125_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq125.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq125_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("b_debk001",6540)
   CALL cl_set_combo_scc("b_debm007",8310)
   CALL cl_set_combo_scc("b_debm007_1",8310)
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
 
   CALL adeq125_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq125.default_search" >}
PRIVATE FUNCTION adeq125_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " debksite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " debk002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " debk005 = '", g_argv[03], "' AND "
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
 
{<section id="adeq125.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq125_ui_dialog()
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
      CALL adeq125_b_fill()
   ELSE
      CALL adeq125_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_debk_d.clear()
         CALL g_debk2_d.clear()
 
         CALL g_debk3_d.clear()
 
 
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
 
         CALL adeq125_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_debk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq125_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq125_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_debk2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_debk2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_debk3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_debk3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_debk4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 4
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_debk4_d.getLength() TO FORMONLY.cnt        
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq125_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) #sakura add
            CALL cl_set_comp_visible("sel", FALSE)                     #sakura add
            #end add-point
 
         
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
               CALL adeq125_query()
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
            CALL adeq125_filter()
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
            CALL adeq125_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_debk_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_debk2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_debk3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               #ken---add---s 需求單號：150107-00009 項次：7
               LET g_export_node[4] = base.typeInfo.create(g_debk4_d)
               LET g_export_id[4]   = "s_detail4"
               #ken---add---e
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
            CALL adeq125_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq125_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq125_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq125_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_debk_d.getLength()
               LET g_debk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_debk_d.getLength()
               LET g_debk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_debk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_debk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debk_d[li_idx].sel = "N"
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
 
{<section id="adeq125.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq125_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_oocq004 LIKE oocq_t.oocq004
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_debk_d.clear()
   CALL g_debk2_d.clear()
 
   CALL g_debk3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON debksite,debk001,debk002,debk003,debk004,debk005,debk006,debk007,debk008, 
          debk009,debk010,debk011,debk012,debk013,debk022,debk023,debk014,debk015,debk016,debk017,debk020, 
          debk021,debk018,debk019
           FROM s_detail1[1].b_debksite,s_detail1[1].b_debk001,s_detail1[1].b_debk002,s_detail1[1].b_debk003, 
               s_detail1[1].b_debk004,s_detail1[1].b_debk005,s_detail1[1].b_debk006,s_detail1[1].b_debk007, 
               s_detail1[1].b_debk008,s_detail1[1].b_debk009,s_detail1[1].b_debk010,s_detail1[1].b_debk011, 
               s_detail1[1].b_debk012,s_detail1[1].b_debk013,s_detail1[1].b_debk022,s_detail1[1].b_debk023, 
               s_detail1[1].b_debk014,s_detail1[1].b_debk015,s_detail1[1].b_debk016,s_detail1[1].b_debk017, 
               s_detail1[1].b_debk020,s_detail1[1].b_debk021,s_detail1[1].b_debk018,s_detail1[1].b_debk019 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #2015 07/07 s983961 add(s)預設查詢
            DISPLAY '' TO b_debksite      
            DISPLAY g_site TO b_debksite     
            DISPLAY g_today-1 TO b_debk002 
            #2015 07/07 s983961 add(s)預設查詢
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_debksite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debksite
            #add-point:BEFORE FIELD b_debksite name="construct.b.page1.b_debksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debksite
            
            #add-point:AFTER FIELD b_debksite name="construct.a.page1.b_debksite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debksite
            #add-point:ON ACTION controlp INFIELD b_debksite name="construct.c.page1.b_debksite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debksite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()            
            DISPLAY g_qryparam.return1 TO b_debksite  #顯示到畫面上
            NEXT FIELD b_debksite                     #返回原欄位
            #END add-point
 
 
         #----<<b_debksite_desc>>----
         #----<<b_debk001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk001
            #add-point:BEFORE FIELD b_debk001 name="construct.b.page1.b_debk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk001
            
            #add-point:AFTER FIELD b_debk001 name="construct.a.page1.b_debk001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk001
            #add-point:ON ACTION controlp INFIELD b_debk001 name="construct.c.page1.b_debk001"
            
            #END add-point
 
 
         #----<<b_debk002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk002
            #add-point:BEFORE FIELD b_debk002 name="construct.b.page1.b_debk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk002
            
            #add-point:AFTER FIELD b_debk002 name="construct.a.page1.b_debk002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk002
            #add-point:ON ACTION controlp INFIELD b_debk002 name="construct.c.page1.b_debk002"
            
            #END add-point
 
 
         #----<<b_debk003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk003
            #add-point:BEFORE FIELD b_debk003 name="construct.b.page1.b_debk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk003
            
            #add-point:AFTER FIELD b_debk003 name="construct.a.page1.b_debk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk003
            #add-point:ON ACTION controlp INFIELD b_debk003 name="construct.c.page1.b_debk003"
            
            #END add-point
 
 
         #----<<b_debk004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk004
            #add-point:BEFORE FIELD b_debk004 name="construct.b.page1.b_debk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk004
            
            #add-point:AFTER FIELD b_debk004 name="construct.a.page1.b_debk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk004
            #add-point:ON ACTION controlp INFIELD b_debk004 name="construct.c.page1.b_debk004"
            
            #END add-point
 
 
         #----<<b_debk005>>----
         #Ctrlp:construct.c.page1.b_debk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk005
            #add-point:ON ACTION controlp INFIELD b_debk005 name="construct.c.page1.b_debk005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debk005  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooeg001 #部門編號 

            NEXT FIELD b_debk005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk005
            #add-point:BEFORE FIELD b_debk005 name="construct.b.page1.b_debk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk005
            
            #add-point:AFTER FIELD b_debk005 name="construct.a.page1.b_debk005"
            
            #END add-point
            
 
 
         #----<<b_debk005_desc>>----
         #----<<b_debk006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk006
            #add-point:BEFORE FIELD b_debk006 name="construct.b.page1.b_debk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk006
            
            #add-point:AFTER FIELD b_debk006 name="construct.a.page1.b_debk006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk006
            #add-point:ON ACTION controlp INFIELD b_debk006 name="construct.c.page1.b_debk006"
            
            #END add-point
 
 
         #----<<b_debk007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk007
            #add-point:BEFORE FIELD b_debk007 name="construct.b.page1.b_debk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk007
            
            #add-point:AFTER FIELD b_debk007 name="construct.a.page1.b_debk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk007
            #add-point:ON ACTION controlp INFIELD b_debk007 name="construct.c.page1.b_debk007"
            
            #END add-point
 
 
         #----<<b_debk008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk008
            #add-point:BEFORE FIELD b_debk008 name="construct.b.page1.b_debk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk008
            
            #add-point:AFTER FIELD b_debk008 name="construct.a.page1.b_debk008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk008
            #add-point:ON ACTION controlp INFIELD b_debk008 name="construct.c.page1.b_debk008"
            
            #END add-point
 
 
         #----<<b_debk009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk009
            #add-point:BEFORE FIELD b_debk009 name="construct.b.page1.b_debk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk009
            
            #add-point:AFTER FIELD b_debk009 name="construct.a.page1.b_debk009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk009
            #add-point:ON ACTION controlp INFIELD b_debk009 name="construct.c.page1.b_debk009"
            
            #END add-point
 
 
         #----<<b_debk010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk010
            #add-point:BEFORE FIELD b_debk010 name="construct.b.page1.b_debk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk010
            
            #add-point:AFTER FIELD b_debk010 name="construct.a.page1.b_debk010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk010
            #add-point:ON ACTION controlp INFIELD b_debk010 name="construct.c.page1.b_debk010"
            
            #END add-point
 
 
         #----<<b_debk011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk011
            #add-point:BEFORE FIELD b_debk011 name="construct.b.page1.b_debk011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk011
            
            #add-point:AFTER FIELD b_debk011 name="construct.a.page1.b_debk011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk011
            #add-point:ON ACTION controlp INFIELD b_debk011 name="construct.c.page1.b_debk011"
            
            #END add-point
 
 
         #----<<b_debk012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk012
            #add-point:BEFORE FIELD b_debk012 name="construct.b.page1.b_debk012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk012
            
            #add-point:AFTER FIELD b_debk012 name="construct.a.page1.b_debk012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk012
            #add-point:ON ACTION controlp INFIELD b_debk012 name="construct.c.page1.b_debk012"
            
            #END add-point
 
 
         #----<<b_debk013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk013
            #add-point:BEFORE FIELD b_debk013 name="construct.b.page1.b_debk013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk013
            
            #add-point:AFTER FIELD b_debk013 name="construct.a.page1.b_debk013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk013
            #add-point:ON ACTION controlp INFIELD b_debk013 name="construct.c.page1.b_debk013"
            
            #END add-point
 
 
         #----<<b_debk022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk022
            #add-point:BEFORE FIELD b_debk022 name="construct.b.page1.b_debk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk022
            
            #add-point:AFTER FIELD b_debk022 name="construct.a.page1.b_debk022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk022
            #add-point:ON ACTION controlp INFIELD b_debk022 name="construct.c.page1.b_debk022"
            
            #END add-point
 
 
         #----<<b_debk023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk023
            #add-point:BEFORE FIELD b_debk023 name="construct.b.page1.b_debk023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk023
            
            #add-point:AFTER FIELD b_debk023 name="construct.a.page1.b_debk023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk023
            #add-point:ON ACTION controlp INFIELD b_debk023 name="construct.c.page1.b_debk023"
            
            #END add-point
 
 
         #----<<b_debk014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk014
            #add-point:BEFORE FIELD b_debk014 name="construct.b.page1.b_debk014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk014
            
            #add-point:AFTER FIELD b_debk014 name="construct.a.page1.b_debk014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk014
            #add-point:ON ACTION controlp INFIELD b_debk014 name="construct.c.page1.b_debk014"
            
            #END add-point
 
 
         #----<<b_debk015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk015
            #add-point:BEFORE FIELD b_debk015 name="construct.b.page1.b_debk015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk015
            
            #add-point:AFTER FIELD b_debk015 name="construct.a.page1.b_debk015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk015
            #add-point:ON ACTION controlp INFIELD b_debk015 name="construct.c.page1.b_debk015"
            
            #END add-point
 
 
         #----<<b_debk016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk016
            #add-point:BEFORE FIELD b_debk016 name="construct.b.page1.b_debk016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk016
            
            #add-point:AFTER FIELD b_debk016 name="construct.a.page1.b_debk016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk016
            #add-point:ON ACTION controlp INFIELD b_debk016 name="construct.c.page1.b_debk016"
            
            #END add-point
 
 
         #----<<b_debk017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk017
            #add-point:BEFORE FIELD b_debk017 name="construct.b.page1.b_debk017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk017
            
            #add-point:AFTER FIELD b_debk017 name="construct.a.page1.b_debk017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk017
            #add-point:ON ACTION controlp INFIELD b_debk017 name="construct.c.page1.b_debk017"
            
            #END add-point
 
 
         #----<<b_debk020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk020
            #add-point:BEFORE FIELD b_debk020 name="construct.b.page1.b_debk020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk020
            
            #add-point:AFTER FIELD b_debk020 name="construct.a.page1.b_debk020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk020
            #add-point:ON ACTION controlp INFIELD b_debk020 name="construct.c.page1.b_debk020"
            
            #END add-point
 
 
         #----<<b_debk021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk021
            #add-point:BEFORE FIELD b_debk021 name="construct.b.page1.b_debk021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk021
            
            #add-point:AFTER FIELD b_debk021 name="construct.a.page1.b_debk021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk021
            #add-point:ON ACTION controlp INFIELD b_debk021 name="construct.c.page1.b_debk021"
            
            #END add-point
 
 
         #----<<b_debk018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk018
            #add-point:BEFORE FIELD b_debk018 name="construct.b.page1.b_debk018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk018
            
            #add-point:AFTER FIELD b_debk018 name="construct.a.page1.b_debk018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk018
            #add-point:ON ACTION controlp INFIELD b_debk018 name="construct.c.page1.b_debk018"
            
            #END add-point
 
 
         #----<<b_debk019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debk019
            #add-point:BEFORE FIELD b_debk019 name="construct.b.page1.b_debk019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debk019
            
            #add-point:AFTER FIELD b_debk019 name="construct.a.page1.b_debk019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debk019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk019
            #add-point:ON ACTION controlp INFIELD b_debk019 name="construct.c.page1.b_debk019"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON debl006,debl007,debl008,debl009,debl010,debl011,debl012,debl013,debl018, 
          debl019,debl020,debl014,debl015,debl016,debl017
           FROM s_detail2[1].b_debl006,s_detail2[1].b_debl007,s_detail2[1].b_debl008,s_detail2[1].b_debl009, 
               s_detail2[1].b_debl010,s_detail2[1].b_debl011,s_detail2[1].b_debl012,s_detail2[1].b_debl013, 
               s_detail2[1].b_debl018,s_detail2[1].b_debl019,s_detail2[1].b_debl020,s_detail2[1].b_debl014, 
               s_detail2[1].b_debl015,s_detail2[1].b_debl016,s_detail2[1].b_debl017
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            DISPLAY '' TO b_debl006  #2015 07/07 s983961 add 預設查詢
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_debl006>>----
         #Ctrlp:construct.c.page2.b_debl006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl006
            #add-point:ON ACTION controlp INFIELD b_debl006 name="construct.c.page2.b_debl006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debl006  #顯示到畫面上

            NEXT FIELD b_debl006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl006
            #add-point:BEFORE FIELD b_debl006 name="construct.b.page2.b_debl006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl006
            
            #add-point:AFTER FIELD b_debl006 name="construct.a.page2.b_debl006"
            
            #END add-point
            
 
 
         #----<<b_debl006_desc>>----
         #----<<b_debl007>>----
         #Ctrlp:construct.c.page2.b_debl007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl007
            #add-point:ON ACTION controlp INFIELD b_debl007 name="construct.c.page2.b_debl007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2024'
            CALL q_oocq002() 
            DISPLAY g_qryparam.return1 TO b_debl007  #顯示到畫面上

            NEXT FIELD b_debl007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl007
            #add-point:BEFORE FIELD b_debl007 name="construct.b.page2.b_debl007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl007
            
            #add-point:AFTER FIELD b_debl007 name="construct.a.page2.b_debl007"
            
            #END add-point
            
 
 
         #----<<b_debl007_desc>>----
         #----<<b_debl008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl008
            #add-point:BEFORE FIELD b_debl008 name="construct.b.page2.b_debl008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl008
            
            #add-point:AFTER FIELD b_debl008 name="construct.a.page2.b_debl008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl008
            #add-point:ON ACTION controlp INFIELD b_debl008 name="construct.c.page2.b_debl008"
            
            #END add-point
 
 
         #----<<b_debl009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl009
            #add-point:BEFORE FIELD b_debl009 name="construct.b.page2.b_debl009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl009
            
            #add-point:AFTER FIELD b_debl009 name="construct.a.page2.b_debl009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl009
            #add-point:ON ACTION controlp INFIELD b_debl009 name="construct.c.page2.b_debl009"
            
            #END add-point
 
 
         #----<<b_debl010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl010
            #add-point:BEFORE FIELD b_debl010 name="construct.b.page2.b_debl010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl010
            
            #add-point:AFTER FIELD b_debl010 name="construct.a.page2.b_debl010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl010
            #add-point:ON ACTION controlp INFIELD b_debl010 name="construct.c.page2.b_debl010"
            
            #END add-point
 
 
         #----<<b_debl011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl011
            #add-point:BEFORE FIELD b_debl011 name="construct.b.page2.b_debl011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl011
            
            #add-point:AFTER FIELD b_debl011 name="construct.a.page2.b_debl011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl011
            #add-point:ON ACTION controlp INFIELD b_debl011 name="construct.c.page2.b_debl011"
            
            #END add-point
 
 
         #----<<b_debl012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl012
            #add-point:BEFORE FIELD b_debl012 name="construct.b.page2.b_debl012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl012
            
            #add-point:AFTER FIELD b_debl012 name="construct.a.page2.b_debl012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl012
            #add-point:ON ACTION controlp INFIELD b_debl012 name="construct.c.page2.b_debl012"
            
            #END add-point
 
 
         #----<<b_debl013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl013
            #add-point:BEFORE FIELD b_debl013 name="construct.b.page2.b_debl013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl013
            
            #add-point:AFTER FIELD b_debl013 name="construct.a.page2.b_debl013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl013
            #add-point:ON ACTION controlp INFIELD b_debl013 name="construct.c.page2.b_debl013"
            
            #END add-point
 
 
         #----<<b_debl018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl018
            #add-point:BEFORE FIELD b_debl018 name="construct.b.page2.b_debl018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl018
            
            #add-point:AFTER FIELD b_debl018 name="construct.a.page2.b_debl018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl018
            #add-point:ON ACTION controlp INFIELD b_debl018 name="construct.c.page2.b_debl018"
            
            #END add-point
 
 
         #----<<b_debl019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl019
            #add-point:BEFORE FIELD b_debl019 name="construct.b.page2.b_debl019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl019
            
            #add-point:AFTER FIELD b_debl019 name="construct.a.page2.b_debl019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl019
            #add-point:ON ACTION controlp INFIELD b_debl019 name="construct.c.page2.b_debl019"
            
            #END add-point
 
 
         #----<<b_debl020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl020
            #add-point:BEFORE FIELD b_debl020 name="construct.b.page2.b_debl020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl020
            
            #add-point:AFTER FIELD b_debl020 name="construct.a.page2.b_debl020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl020
            #add-point:ON ACTION controlp INFIELD b_debl020 name="construct.c.page2.b_debl020"
            
            #END add-point
 
 
         #----<<b_debl014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl014
            #add-point:BEFORE FIELD b_debl014 name="construct.b.page2.b_debl014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl014
            
            #add-point:AFTER FIELD b_debl014 name="construct.a.page2.b_debl014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl014
            #add-point:ON ACTION controlp INFIELD b_debl014 name="construct.c.page2.b_debl014"
            
            #END add-point
 
 
         #----<<b_debl015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl015
            #add-point:BEFORE FIELD b_debl015 name="construct.b.page2.b_debl015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl015
            
            #add-point:AFTER FIELD b_debl015 name="construct.a.page2.b_debl015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl015
            #add-point:ON ACTION controlp INFIELD b_debl015 name="construct.c.page2.b_debl015"
            
            #END add-point
 
 
         #----<<b_debl016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl016
            #add-point:BEFORE FIELD b_debl016 name="construct.b.page2.b_debl016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl016
            
            #add-point:AFTER FIELD b_debl016 name="construct.a.page2.b_debl016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl016
            #add-point:ON ACTION controlp INFIELD b_debl016 name="construct.c.page2.b_debl016"
            
            #END add-point
 
 
         #----<<b_debl017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debl017
            #add-point:BEFORE FIELD b_debl017 name="construct.b.page2.b_debl017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debl017
            
            #add-point:AFTER FIELD b_debl017 name="construct.a.page2.b_debl017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_debl017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debl017
            #add-point:ON ACTION controlp INFIELD b_debl017 name="construct.c.page2.b_debl017"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON debm007,debm006,debm008
           FROM s_detail3[1].b_debm007,s_detail3[1].b_debm006,s_detail3[1].b_debm008
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body3.before_construct"
            DISPLAY '' TO b_debm007  #2015 07/07 s983961 add 預設查詢
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_debm007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debm007
            #add-point:BEFORE FIELD b_debm007 name="construct.b.page3.b_debm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debm007
            
            #add-point:AFTER FIELD b_debm007 name="construct.a.page3.b_debm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_debm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debm007
            #add-point:ON ACTION controlp INFIELD b_debm007 name="construct.c.page3.b_debm007"
            
            #END add-point
 
 
         #----<<b_debm006>>----
         #Ctrlp:construct.c.page3.b_debm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debm006
            #add-point:ON ACTION controlp INFIELD b_debm006 name="construct.c.page3.b_debm006"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooia001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debm006  #顯示到畫面上

            NEXT FIELD b_debm006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debm006
            #add-point:BEFORE FIELD b_debm006 name="construct.b.page3.b_debm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debm006
            
            #add-point:AFTER FIELD b_debm006 name="construct.a.page3.b_debm006"
            
            #END add-point
            
 
 
         #----<<b_debm006_desc>>----
         #----<<b_debm008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debm008
            #add-point:BEFORE FIELD b_debm008 name="construct.b.page3.b_debm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debm008
            
            #add-point:AFTER FIELD b_debm008 name="construct.a.page3.b_debm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_debm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debm008
            #add-point:ON ACTION controlp INFIELD b_debm008 name="construct.c.page3.b_debm008"
            
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
   CALL adeq125_b_fill()
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
 
{<section id="adeq125.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq125_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'debksite')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',debksite,'',debk001,debk002,debk003,debk004,debk005,'',debk006, 
       debk007,debk008,debk009,debk010,debk011,debk012,debk013,debk022,debk023,debk014,debk015,debk016, 
       debk017,debk020,debk021,debk018,debk019  ,DENSE_RANK() OVER( ORDER BY debk_t.debksite,debk_t.debk002, 
       debk_t.debk005) AS RANK FROM debk_t",
 
                     " LEFT JOIN debl_t ON deblent = debkent AND debksite = deblsite AND debk002 = debl002 AND debk005 = debl005",
 
                     " LEFT JOIN debm_t ON debment = debkent AND debksite = debmsite AND debk002 = debm002 AND debk005 = debm005",
 
 
                     "",
                     " WHERE debkent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debk_t"),
                     " ORDER BY debk_t.debksite,debk_t.debk002,debk_t.debk005"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"

   LET ls_sql_rank = "SELECT UNIQUE 'N', ",
               "              debksite, ",
               "              (SELECT ooefl003 FROM ooefl_t ",
               "                WHERE ooeflent = debkent ",
               "                  AND ooefl001 = debksite ",
               "                  AND ooefl002 ='"||g_dlang||"') debksite_desc,",
               "              debk001,  ",
               "              debk002,  ",
               "              debk003,  ",
               "              debk004,  ",
               "              debk005,  ",  
               "              (SELECT DISTINCT ooefl003 FROM ooefl_t ",
               "                WHERE ooeflent = debkent ",
               "                  AND ooefl001 = debk005 ",
               "                  AND ooefl002 ='"||g_dlang||"') debk005_desc,",
               "              debk006,  debk007, debk008, debk009, ",
               "              debk010,  debk011, debk012, ",
               "              debk013,  debk022, debk023, ",  #150513-00007 #7 2015/05/15 by s983961 add
               "              debk014,  debk015, debk016, debk017, ",
               "              debk020,  debk021, debk018, debk019, ",
               "              DENSE_RANK() OVER( ORDER BY debk_t.debksite,debk_t.debk002,debk_t.debk005) AS RANK ",
               "        FROM debk_t",            
               "       LEFT JOIN debl_t ON deblent = debkent AND debksite = deblsite AND debk002 = debl002 AND debk005 = debl005",
               "       LEFT JOIN debm_t ON debment = debkent AND debksite = debmsite AND debk002 = debm002 AND debk005 = debm005",
               "       WHERE debkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debk_t"),
               " ORDER BY debk_t.debksite,debk_t.debk002,debk_t.debk005"
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)
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
 
   LET g_sql = "SELECT '',debksite,'',debk001,debk002,debk003,debk004,debk005,'',debk006,debk007,debk008, 
       debk009,debk010,debk011,debk012,debk013,debk022,debk023,debk014,debk015,debk016,debk017,debk020, 
       debk021,debk018,debk019",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#2 20150907 s983961--mark and mod(s) 效能調整
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #LET g_sql = "SELECT UNIQUE '', ",
   #            "              debksite, t1.ooefl003, debk001,     debk002, debk003, ",
   #            "              debk004,  debk005,     t2.ooial003, debk006, debk007, ",
   #            "              debk008,  debk009,     debk010,     debk011, debk012, ",
   #            "              debk013,  debk022,     debk023,              ",  #150513-00007 #7 2015/05/15 by s983961 add
   #            "              debk014,  debk015,     debk016,     debk017, ",
   #            "              debk020,  debk021,     debk018,     debk019 ",
   #            "  FROM debk_t",
   #            "       LEFT JOIN debl_t ON deblent = debkent AND debksite = deblsite AND debk002 = debl002 AND debk005 = debl005",
   #            "       LEFT JOIN debm_t ON debment = debkent AND debksite = debmsite AND debk002 = debm002 AND debk005 = debm005",
   #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = debkent AND t1.ooefl001 = debksite AND t1.ooefl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN ooial_t t2 ON t2.ooialent = debkent AND t2.ooial001 = debk005 AND t2.ooial002 = '",g_dlang,"' ",
   #            " WHERE debkent = ? ",
   #            "   AND ", ls_wc,cl_sql_add_filter("debk_t")
   # 
   #LET g_sql = g_sql, cl_sql_add_filter("debk_t"),
   #                   " ORDER BY debk_t.debksite,debk_t.debk002,debk_t.debk005"   
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)
   
   LET g_sql = "SELECT 'N',debksite, debksite_desc, debk001, debk002, debk003, debk004, debk005, debk005_desc,
                          debk006, debk007, debk008, debk009, debk010, debk011, debk012, debk013, debk022,
                          debk023, debk014, debk015, debk016, debk017, debk020, debk021, debk018, debk019 ",
            " FROM (",ls_sql_rank,")",
           " WHERE RANK >= ",g_pagestart,
             " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#2 20150907 s983961--mark and mod(e) 效能調整
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq125_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq125_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_debk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_debk_d[l_ac].sel,g_debk_d[l_ac].debksite,g_debk_d[l_ac].debksite_desc, 
       g_debk_d[l_ac].debk001,g_debk_d[l_ac].debk002,g_debk_d[l_ac].debk003,g_debk_d[l_ac].debk004,g_debk_d[l_ac].debk005, 
       g_debk_d[l_ac].debk005_desc,g_debk_d[l_ac].debk006,g_debk_d[l_ac].debk007,g_debk_d[l_ac].debk008, 
       g_debk_d[l_ac].debk009,g_debk_d[l_ac].debk010,g_debk_d[l_ac].debk011,g_debk_d[l_ac].debk012,g_debk_d[l_ac].debk013, 
       g_debk_d[l_ac].debk022,g_debk_d[l_ac].debk023,g_debk_d[l_ac].debk014,g_debk_d[l_ac].debk015,g_debk_d[l_ac].debk016, 
       g_debk_d[l_ac].debk017,g_debk_d[l_ac].debk020,g_debk_d[l_ac].debk021,g_debk_d[l_ac].debk018,g_debk_d[l_ac].debk019 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_debk_d[l_ac].statepic = cl_get_actipic(g_debk_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF cl_null(g_debk_d[l_ac].sel) THEN
         LET g_debk_d[l_ac].sel = 'N'
      END IF
      #end add-point
 
      CALL adeq125_detail_show("'1'")      
 
      CALL adeq125_debk_t_mask()
 
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
   
 
   
   CALL g_debk_d.deleteElement(g_debk_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)
   #LET g_sql = " SELECT debm007,debm006,SUM(debm008) ",
   #            "   FROM ",
   #            "(SELECT DISTINCT debkent,debksite,debk002,debk005,debm007,debm006,debm008 ",
   #            "   FROM debk_t",
   #            "   LEFT JOIN debl_t ON deblent = debkent AND debksite = deblsite AND debk002 = debl002 AND debk005 = debl005",
   #            "   LEFT JOIN debm_t ON debment = debkent AND debksite = debmsite AND debk002 = debm002 AND debk005 = debm005",
   #            "  WHERE debkent= ? AND debm006 IS NOT NULL AND ", ls_wc,")",
   #            " GROUP BY debm007,debm006",
   #            " ORDER BY debm007,debm006"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)
   
   #150826-00013#2 20150907 s983961--mark and mod(s) 效能調整
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #LET g_sql = " SELECT debm007,debm006,ooial003,SUM(debm008) ",
   #            "   FROM (SELECT UNIQUE debkent,debksite,debk002,debk005,debm007, ",
   #            "                       debm006,debm008,t1.ooial003 ",
   #            "           FROM debk_t",
   #            "                LEFT JOIN debl_t ON deblent = debkent AND deblsite = debksite AND debl002 = debk002 ",
   #            "                                AND debl005 = debk005",
   #            "                LEFT JOIN debm_t ON debment = debkent AND debmsite = debksite AND debm002 = debk002 ",
   #            "                                AND debm005 = debk005 ",
   #            "                LEFT JOIN ooial_t t1 ON t1.ooialent = debkent AND t1.ooial001 = debm006 ",
   #            "                                    AND t1.ooial002 = '",g_dlang,"' ",
   #            "          WHERE debkent= ? AND debm006 IS NOT NULL AND ", ls_wc,")",
   #            " GROUP BY debm007,debm006,ooial003",
   #            " ORDER BY debm007,debm006"
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)
   
   LET g_sql = " SELECT debm007,debm006,ooial003,SUM(debm008) ",
               "   FROM (SELECT UNIQUE debkent,debksite,debk002,debk005,debm007, ",
               "                       debm006, ",
               "                       debm008, ",
               "                       (SELECT ooial003 FROM ooial_t ",
               "                         WHERE ooialent = debkent ",
               "                           AND ooial001 = debm006 ",
               "                           AND ooial002 ='"||g_dlang||"') ooial003 ",
               "           FROM debk_t",
               "                LEFT JOIN debl_t ON deblent = debkent AND deblsite = debksite AND debl002 = debk002 ",
               "                                AND debl005 = debk005",
               "                LEFT JOIN debm_t ON debment = debkent AND debmsite = debksite AND debm002 = debk002 ",
               "                                AND debm005 = debk005 ",
               "          WHERE debkent= ? AND debm006 IS NOT NULL AND ", ls_wc,")",
               " GROUP BY debm007,debm006,ooial003",
               " ORDER BY debm007,debm006"
   #150826-00013#2 20150907 s983961--mark and mod(e) 效能調整            
   PREPARE adeq125_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq125_pb1
   #end add-point
 
   LET g_detail_cnt = g_debk_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq125_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq125_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq125_detail_action_trans()
 
   IF g_debk_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq125_fetch()
   END IF
   
      CALL adeq125_filter_show('debksite','b_debksite')
   CALL adeq125_filter_show('debk001','b_debk001')
   CALL adeq125_filter_show('debk002','b_debk002')
   CALL adeq125_filter_show('debk003','b_debk003')
   CALL adeq125_filter_show('debk004','b_debk004')
   CALL adeq125_filter_show('debk005','b_debk005')
   CALL adeq125_filter_show('debk006','b_debk006')
   CALL adeq125_filter_show('debk007','b_debk007')
   CALL adeq125_filter_show('debk008','b_debk008')
   CALL adeq125_filter_show('debk009','b_debk009')
   CALL adeq125_filter_show('debk010','b_debk010')
   CALL adeq125_filter_show('debk011','b_debk011')
   CALL adeq125_filter_show('debk012','b_debk012')
   CALL adeq125_filter_show('debk013','b_debk013')
   CALL adeq125_filter_show('debk022','b_debk022')
   CALL adeq125_filter_show('debk023','b_debk023')
   CALL adeq125_filter_show('debk014','b_debk014')
   CALL adeq125_filter_show('debk015','b_debk015')
   CALL adeq125_filter_show('debk016','b_debk016')
   CALL adeq125_filter_show('debk017','b_debk017')
   CALL adeq125_filter_show('debk020','b_debk020')
   CALL adeq125_filter_show('debk021','b_debk021')
   CALL adeq125_filter_show('debk018','b_debk018')
   CALL adeq125_filter_show('debk019','b_debk019')
   CALL adeq125_filter_show('debl006','b_debl006')
   CALL adeq125_filter_show('debl007','b_debl007')
   CALL adeq125_filter_show('debl008','b_debl008')
   CALL adeq125_filter_show('debl009','b_debl009')
   CALL adeq125_filter_show('debl010','b_debl010')
   CALL adeq125_filter_show('debl011','b_debl011')
   CALL adeq125_filter_show('debl012','b_debl012')
   CALL adeq125_filter_show('debl013','b_debl013')
   CALL adeq125_filter_show('debl018','b_debl018')
   CALL adeq125_filter_show('debl019','b_debl019')
   CALL adeq125_filter_show('debl020','b_debl020')
   CALL adeq125_filter_show('debl014','b_debl014')
   CALL adeq125_filter_show('debl015','b_debl015')
   CALL adeq125_filter_show('debl016','b_debl016')
   CALL adeq125_filter_show('debl017','b_debl017')
   CALL adeq125_filter_show('debm007','b_debm007')
   CALL adeq125_filter_show('debm006','b_debm006')
   CALL adeq125_filter_show('debm008','b_debm008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq125_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
 
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_debk2_d.clear()
 
   CALL g_debk3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE debl006,'',debl007,'',debl008,debl009,debl010,debl011,debl012,debl013, 
          debl018,debl019,debl020,debl014,debl015,debl016,debl017 FROM debl_t",    
                  "",
                  " WHERE deblent=? AND deblsite=? AND debl002=? AND debl005=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY debl_t.debl006,debl_t.debl007" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      #150826-00013#2 20150907 s983961--mark and mod(s) 效能調整  
      #150302-00004#8 150312 by lori522612 add 效能調整---(S)
      #LET g_sql = "SELECT UNIQUE debl006, t1.mmanl003, debl007, t2.oocql004, debl008, ",
      #            "              debl009, debl010,     debl011, debl012,     debl013, ",
      #            "              debl018, debl019,     debl020,         ",  #150513-00007#7 2015/05/15 by s983961 add
      #            "              debl014, debl015,     debl016, debl017 ",
      #            "  FROM debl_t ", 
      #            "       LEFT JOIN mmanl_t t1 ON t1.mmanlent = deblent AND t1.mmanl001 = debl006 AND t1.mmanl002 = '",g_dlang,"' ",
      #            "       LEFT JOIN (SELECT oocqlent,oocql002,oocql004",
      #            "                    FROM oocql_t,oocq_t ",
      #            "                   WHERE oocqlent = oocqent AND oocql001 = oocq004 AND oocql003 = '",g_dlang,"' ",
      #            "                     AND oocq001 = '2049'   AND oocq002 = '09') t2 ",
      #            "              ON t2.oocqlent = deblent AND t2.oocql002 = debl007 ",
      #            " WHERE deblent = ? AND deblsite = ? AND debl002 = ? AND debl005 = ? "
      #
      #IF NOT cl_null(g_wc2_table2) THEN
      #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      #END IF
      #
      #LET g_sql = g_sql, " ORDER BY debl_t.debl006,debl_t.debl007"       
      #150302-00004#8 150312 by lori522612 add 效能調整---(E)
      
      LET g_sql = "SELECT UNIQUE debl006, ",
                  "              (SELECT mmanl003 FROM mmanl_t ",
                  "                WHERE mmanlent = deblent ",
                  "                  AND mmanl001 = debl006 ",
                  "                  AND mmanl002 ='"||g_dlang||"') debl006_desc,",
                  "              debl007, ",
                  "              (SELECT oocql004 ", 
                  "                FROM (SELECT oocqlent,oocql002,oocql004 ",
                  "                        FROM oocql_t,oocq_t ",
                  "                       WHERE oocqlent = oocqent AND oocql001 = oocq004 AND oocql003 = '",g_dlang,"' ",
                  "                         AND oocq001 = '2049'   AND oocq002 = '09')  ",
                  "                WHERE oocqlent = deblent ",
                  "                  AND oocql002 = debl007) debl007_desc, ",
                  "              debl008, ",
                  "              debl009, debl010, ",
                  "              debl011, debl012, ",
                  "              debl013, debl018, ",
                  "              debl019, debl020, ",  #150513-00007#7 2015/05/15 by s983961 add
                  "              debl014, debl015, ",
                  "              debl016, debl017  ",
                  "  FROM debl_t ", 
                  " WHERE deblent = ? AND deblsite = ? AND debl002 = ? AND debl005 = ? "

      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY debl_t.debl006,debl_t.debl007"   
      #150826-00013#2 20150907 s983961--mark and mod(e) 效能調整  
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq125_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adeq125_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_debk_d[g_detail_idx].debksite
#                                 ,g_debk_d[g_detail_idx].debk002
 
#                                 ,g_debk_d[g_detail_idx].debk005
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_debk_d[g_detail_idx].debksite   #(ver:42)
                                     ,g_debk_d[g_detail_idx].debk002   #(ver:42)
 
                                     ,g_debk_d[g_detail_idx].debk005   #(ver:42)
 
 
        INTO g_debk2_d[l_ac].debl006,g_debk2_d[l_ac].debl006_desc,g_debk2_d[l_ac].debl007,g_debk2_d[l_ac].debl007_desc, 
            g_debk2_d[l_ac].debl008,g_debk2_d[l_ac].debl009,g_debk2_d[l_ac].debl010,g_debk2_d[l_ac].debl011, 
            g_debk2_d[l_ac].debl012,g_debk2_d[l_ac].debl013,g_debk2_d[l_ac].debl018,g_debk2_d[l_ac].debl019, 
            g_debk2_d[l_ac].debl020,g_debk2_d[l_ac].debl014,g_debk2_d[l_ac].debl015,g_debk2_d[l_ac].debl016, 
            g_debk2_d[l_ac].debl017   #(ver:42)
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
 
      #add-point:b_fill段資料填充 name="fetch.fill2"
      #150302-00004#8 150312 by lori522612 mark---(S) 
      #CALL adeq125_debl006_ref()
      #CALL adeq125_debl007_ref()
      #150302-00004#8 150312 by lori522612 mark---(E)  
      #end add-point
      
      CALL adeq125_detail_show("'2'")      
 
      CALL adeq125_debl_t_mask()
 
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
      LET g_sql = "SELECT  UNIQUE debm007,debm006,'',debm008 FROM debm_t",    
                  "",
                  " WHERE debment=? AND debmsite=? AND debm002=? AND debm005=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY debm_t.debm006" 
                         
      #add-point:單身填充前 name="fetch.before_fill3"
      #150826-00013#2 20150907 s983961--mark and mod(s) 效能調整   
      #150302-00004#8 150312 by lori522612 add 效能調整---(S)
      #LET g_sql = "SELECT UNIQUE debm007,debm006,t1.ooial003,debm008 ",
      #            "  FROM debm_t",    
      #            "       LEFT JOIN ooial_t t1 ON t1.ooialent = debment AND t1.ooial001 = debm006 AND t1.ooial002 = '",g_dlang,"' ",
      #            " WHERE debment = ? AND debmsite = ? AND debm002 = ? AND debm005 = ? "
      #
      #IF NOT cl_null(g_wc2_table3) THEN
      #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      #END IF
      #
      #LET g_sql = g_sql, " ORDER BY debm_t.debm006"       
      #150302-00004#8 150312 by lori522612 add 效能調整---(E)
     
      LET g_sql = "SELECT UNIQUE debm007, ",
                  "              debm006, ",
                  "              (SELECT ooial003 FROM ooial_t ",
                  "                WHERE ooialent = debment ",
                  "                  AND ooial001 = debm006 ",
                  "                  AND ooial002 ='"||g_dlang||"') debm006_desc,",
                  "              debm008  ",
                  "  FROM debm_t",    
                  " WHERE debment = ? AND debmsite = ? AND debm002 = ? AND debm005 = ? "
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY debm_t.debm006"       
      #150826-00013#2 20150907 s983961--mark and mod(e) 效能調整  
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq125_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR adeq125_pb3
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs3 USING g_enterprise,g_debk_d[g_detail_idx].debksite
#                                 ,g_debk_d[g_detail_idx].debk002
 
#                                 ,g_debk_d[g_detail_idx].debk005
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs3 USING g_enterprise,g_debk_d[g_detail_idx].debksite   #(ver:42)
                                     ,g_debk_d[g_detail_idx].debk002   #(ver:42)
 
                                     ,g_debk_d[g_detail_idx].debk005   #(ver:42)
 
 
        INTO g_debk3_d[l_ac].debm007,g_debk3_d[l_ac].debm006,g_debk3_d[l_ac].debm006_desc,g_debk3_d[l_ac].debm008  
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
      #CALL adeq125_debm006_ref()   #150302-00004#8 150312 by lori522612 mark
      #end add-point
      
      CALL adeq125_detail_show("'3'")      
 
      CALL adeq125_debm_t_mask()
 
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
   FOREACH b_fill_curs1 USING g_enterprise INTO g_debk4_d[l_ac].debm007,g_debk4_d[l_ac].debm006,
                                                g_debk4_d[l_ac].debm006_desc_1,   #150302-00004#8 150312 by lori522612 add
                                                g_debk4_d[l_ac].debm008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #CALL adeq125_debm006_ref2()   #150302-00004#8 150312 by lori522612 mark

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   #end add-point 
   
   CALL g_debk2_d.deleteElement(g_debk2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_debk2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_debk3_d.deleteElement(g_debk3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_debk3_d.getLength()
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
 
{<section id="adeq125.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq125_detail_show(ps_page)
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
      #CALL adeq125_debksite_ref()
      #CALL adeq125_debk005_ref()
      #150302-00004#8 150312 by lori522612 mark---(E)     
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq125_filter()
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
      CONSTRUCT g_wc_filter ON debksite,debk001,debk002,debk003,debk004,debk005,debk006,debk007,debk008, 
          debk009,debk010,debk011,debk012,debk013,debk022,debk023,debk014,debk015,debk016,debk017,debk020, 
          debk021,debk018,debk019
                          FROM s_detail1[1].b_debksite,s_detail1[1].b_debk001,s_detail1[1].b_debk002, 
                              s_detail1[1].b_debk003,s_detail1[1].b_debk004,s_detail1[1].b_debk005,s_detail1[1].b_debk006, 
                              s_detail1[1].b_debk007,s_detail1[1].b_debk008,s_detail1[1].b_debk009,s_detail1[1].b_debk010, 
                              s_detail1[1].b_debk011,s_detail1[1].b_debk012,s_detail1[1].b_debk013,s_detail1[1].b_debk022, 
                              s_detail1[1].b_debk023,s_detail1[1].b_debk014,s_detail1[1].b_debk015,s_detail1[1].b_debk016, 
                              s_detail1[1].b_debk017,s_detail1[1].b_debk020,s_detail1[1].b_debk021,s_detail1[1].b_debk018, 
                              s_detail1[1].b_debk019
 
         BEFORE CONSTRUCT
                     DISPLAY adeq125_filter_parser('debksite') TO s_detail1[1].b_debksite
            DISPLAY adeq125_filter_parser('debk001') TO s_detail1[1].b_debk001
            DISPLAY adeq125_filter_parser('debk002') TO s_detail1[1].b_debk002
            DISPLAY adeq125_filter_parser('debk003') TO s_detail1[1].b_debk003
            DISPLAY adeq125_filter_parser('debk004') TO s_detail1[1].b_debk004
            DISPLAY adeq125_filter_parser('debk005') TO s_detail1[1].b_debk005
            DISPLAY adeq125_filter_parser('debk006') TO s_detail1[1].b_debk006
            DISPLAY adeq125_filter_parser('debk007') TO s_detail1[1].b_debk007
            DISPLAY adeq125_filter_parser('debk008') TO s_detail1[1].b_debk008
            DISPLAY adeq125_filter_parser('debk009') TO s_detail1[1].b_debk009
            DISPLAY adeq125_filter_parser('debk010') TO s_detail1[1].b_debk010
            DISPLAY adeq125_filter_parser('debk011') TO s_detail1[1].b_debk011
            DISPLAY adeq125_filter_parser('debk012') TO s_detail1[1].b_debk012
            DISPLAY adeq125_filter_parser('debk013') TO s_detail1[1].b_debk013
            DISPLAY adeq125_filter_parser('debk022') TO s_detail1[1].b_debk022
            DISPLAY adeq125_filter_parser('debk023') TO s_detail1[1].b_debk023
            DISPLAY adeq125_filter_parser('debk014') TO s_detail1[1].b_debk014
            DISPLAY adeq125_filter_parser('debk015') TO s_detail1[1].b_debk015
            DISPLAY adeq125_filter_parser('debk016') TO s_detail1[1].b_debk016
            DISPLAY adeq125_filter_parser('debk017') TO s_detail1[1].b_debk017
            DISPLAY adeq125_filter_parser('debk020') TO s_detail1[1].b_debk020
            DISPLAY adeq125_filter_parser('debk021') TO s_detail1[1].b_debk021
            DISPLAY adeq125_filter_parser('debk018') TO s_detail1[1].b_debk018
            DISPLAY adeq125_filter_parser('debk019') TO s_detail1[1].b_debk019
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_debksite>>----
         #Ctrlp:construct.c.filter.page1.b_debksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debksite
            #add-point:ON ACTION controlp INFIELD b_debksite name="construct.c.filter.page1.b_debksite"
            #161006-00008#4 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debksite',g_site,'c')
            CALL q_ooef001_24()            
            DISPLAY g_qryparam.return1 TO b_debksite  #顯示到畫面上
            NEXT FIELD b_debksite                     #返回原欄位
            #161006-00008#4 by sakura add(E)
            #END add-point
 
 
         #----<<b_debksite_desc>>----
         #----<<b_debk001>>----
         #Ctrlp:construct.c.filter.page1.b_debk001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk001
            #add-point:ON ACTION controlp INFIELD b_debk001 name="construct.c.filter.page1.b_debk001"
            
            #END add-point
 
 
         #----<<b_debk002>>----
         #Ctrlp:construct.c.filter.page1.b_debk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk002
            #add-point:ON ACTION controlp INFIELD b_debk002 name="construct.c.filter.page1.b_debk002"
            
            #END add-point
 
 
         #----<<b_debk003>>----
         #Ctrlp:construct.c.filter.page1.b_debk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk003
            #add-point:ON ACTION controlp INFIELD b_debk003 name="construct.c.filter.page1.b_debk003"
            
            #END add-point
 
 
         #----<<b_debk004>>----
         #Ctrlp:construct.c.filter.page1.b_debk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk004
            #add-point:ON ACTION controlp INFIELD b_debk004 name="construct.c.filter.page1.b_debk004"
            
            #END add-point
 
 
         #----<<b_debk005>>----
         #Ctrlp:construct.c.page1.b_debk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk005
            #add-point:ON ACTION controlp INFIELD b_debk005 name="construct.c.filter.page1.b_debk005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debk005  #顯示到畫面上
            NEXT FIELD b_debk005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debk005_desc>>----
         #----<<b_debk006>>----
         #Ctrlp:construct.c.filter.page1.b_debk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk006
            #add-point:ON ACTION controlp INFIELD b_debk006 name="construct.c.filter.page1.b_debk006"
            
            #END add-point
 
 
         #----<<b_debk007>>----
         #Ctrlp:construct.c.filter.page1.b_debk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk007
            #add-point:ON ACTION controlp INFIELD b_debk007 name="construct.c.filter.page1.b_debk007"
            
            #END add-point
 
 
         #----<<b_debk008>>----
         #Ctrlp:construct.c.filter.page1.b_debk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk008
            #add-point:ON ACTION controlp INFIELD b_debk008 name="construct.c.filter.page1.b_debk008"
            
            #END add-point
 
 
         #----<<b_debk009>>----
         #Ctrlp:construct.c.filter.page1.b_debk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk009
            #add-point:ON ACTION controlp INFIELD b_debk009 name="construct.c.filter.page1.b_debk009"
            
            #END add-point
 
 
         #----<<b_debk010>>----
         #Ctrlp:construct.c.filter.page1.b_debk010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk010
            #add-point:ON ACTION controlp INFIELD b_debk010 name="construct.c.filter.page1.b_debk010"
            
            #END add-point
 
 
         #----<<b_debk011>>----
         #Ctrlp:construct.c.filter.page1.b_debk011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk011
            #add-point:ON ACTION controlp INFIELD b_debk011 name="construct.c.filter.page1.b_debk011"
            
            #END add-point
 
 
         #----<<b_debk012>>----
         #Ctrlp:construct.c.filter.page1.b_debk012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk012
            #add-point:ON ACTION controlp INFIELD b_debk012 name="construct.c.filter.page1.b_debk012"
            
            #END add-point
 
 
         #----<<b_debk013>>----
         #Ctrlp:construct.c.filter.page1.b_debk013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk013
            #add-point:ON ACTION controlp INFIELD b_debk013 name="construct.c.filter.page1.b_debk013"
            
            #END add-point
 
 
         #----<<b_debk022>>----
         #Ctrlp:construct.c.filter.page1.b_debk022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk022
            #add-point:ON ACTION controlp INFIELD b_debk022 name="construct.c.filter.page1.b_debk022"
            
            #END add-point
 
 
         #----<<b_debk023>>----
         #Ctrlp:construct.c.filter.page1.b_debk023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk023
            #add-point:ON ACTION controlp INFIELD b_debk023 name="construct.c.filter.page1.b_debk023"
            
            #END add-point
 
 
         #----<<b_debk014>>----
         #Ctrlp:construct.c.filter.page1.b_debk014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk014
            #add-point:ON ACTION controlp INFIELD b_debk014 name="construct.c.filter.page1.b_debk014"
            
            #END add-point
 
 
         #----<<b_debk015>>----
         #Ctrlp:construct.c.filter.page1.b_debk015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk015
            #add-point:ON ACTION controlp INFIELD b_debk015 name="construct.c.filter.page1.b_debk015"
            
            #END add-point
 
 
         #----<<b_debk016>>----
         #Ctrlp:construct.c.filter.page1.b_debk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk016
            #add-point:ON ACTION controlp INFIELD b_debk016 name="construct.c.filter.page1.b_debk016"
            
            #END add-point
 
 
         #----<<b_debk017>>----
         #Ctrlp:construct.c.filter.page1.b_debk017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk017
            #add-point:ON ACTION controlp INFIELD b_debk017 name="construct.c.filter.page1.b_debk017"
            
            #END add-point
 
 
         #----<<b_debk020>>----
         #Ctrlp:construct.c.filter.page1.b_debk020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk020
            #add-point:ON ACTION controlp INFIELD b_debk020 name="construct.c.filter.page1.b_debk020"
            
            #END add-point
 
 
         #----<<b_debk021>>----
         #Ctrlp:construct.c.filter.page1.b_debk021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk021
            #add-point:ON ACTION controlp INFIELD b_debk021 name="construct.c.filter.page1.b_debk021"
            
            #END add-point
 
 
         #----<<b_debk018>>----
         #Ctrlp:construct.c.filter.page1.b_debk018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk018
            #add-point:ON ACTION controlp INFIELD b_debk018 name="construct.c.filter.page1.b_debk018"
            
            #END add-point
 
 
         #----<<b_debk019>>----
         #Ctrlp:construct.c.filter.page1.b_debk019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debk019
            #add-point:ON ACTION controlp INFIELD b_debk019 name="construct.c.filter.page1.b_debk019"
            
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
   
      CALL adeq125_filter_show('debksite','b_debksite')
   CALL adeq125_filter_show('debk001','b_debk001')
   CALL adeq125_filter_show('debk002','b_debk002')
   CALL adeq125_filter_show('debk003','b_debk003')
   CALL adeq125_filter_show('debk004','b_debk004')
   CALL adeq125_filter_show('debk005','b_debk005')
   CALL adeq125_filter_show('debk006','b_debk006')
   CALL adeq125_filter_show('debk007','b_debk007')
   CALL adeq125_filter_show('debk008','b_debk008')
   CALL adeq125_filter_show('debk009','b_debk009')
   CALL adeq125_filter_show('debk010','b_debk010')
   CALL adeq125_filter_show('debk011','b_debk011')
   CALL adeq125_filter_show('debk012','b_debk012')
   CALL adeq125_filter_show('debk013','b_debk013')
   CALL adeq125_filter_show('debk022','b_debk022')
   CALL adeq125_filter_show('debk023','b_debk023')
   CALL adeq125_filter_show('debk014','b_debk014')
   CALL adeq125_filter_show('debk015','b_debk015')
   CALL adeq125_filter_show('debk016','b_debk016')
   CALL adeq125_filter_show('debk017','b_debk017')
   CALL adeq125_filter_show('debk020','b_debk020')
   CALL adeq125_filter_show('debk021','b_debk021')
   CALL adeq125_filter_show('debk018','b_debk018')
   CALL adeq125_filter_show('debk019','b_debk019')
   CALL adeq125_filter_show('debl006','b_debl006')
   CALL adeq125_filter_show('debl007','b_debl007')
   CALL adeq125_filter_show('debl008','b_debl008')
   CALL adeq125_filter_show('debl009','b_debl009')
   CALL adeq125_filter_show('debl010','b_debl010')
   CALL adeq125_filter_show('debl011','b_debl011')
   CALL adeq125_filter_show('debl012','b_debl012')
   CALL adeq125_filter_show('debl013','b_debl013')
   CALL adeq125_filter_show('debl018','b_debl018')
   CALL adeq125_filter_show('debl019','b_debl019')
   CALL adeq125_filter_show('debl020','b_debl020')
   CALL adeq125_filter_show('debl014','b_debl014')
   CALL adeq125_filter_show('debl015','b_debl015')
   CALL adeq125_filter_show('debl016','b_debl016')
   CALL adeq125_filter_show('debl017','b_debl017')
   CALL adeq125_filter_show('debm007','b_debm007')
   CALL adeq125_filter_show('debm006','b_debm006')
   CALL adeq125_filter_show('debm008','b_debm008')
 
    
   CALL adeq125_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq125_filter_parser(ps_field)
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
 
{<section id="adeq125.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq125_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq125_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.insert" >}
#+ insert
PRIVATE FUNCTION adeq125_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq125.modify" >}
#+ modify
PRIVATE FUNCTION adeq125_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq125_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.delete" >}
#+ delete
PRIVATE FUNCTION adeq125_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq125.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq125_detail_action_trans()
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
 
{<section id="adeq125.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq125_detail_index_setting()
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
            IF g_debk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_debk_d.getLength() AND g_debk_d.getLength() > 0
            LET g_detail_idx = g_debk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_debk_d.getLength() THEN
               LET g_detail_idx = g_debk_d.getLength()
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
 
{<section id="adeq125.mask_functions" >}
 &include "erp/ade/adeq125_mask.4gl"
 
{</section>}
 
{<section id="adeq125.other_function" readonly="Y" >}

PUBLIC FUNCTION adeq125_debl006_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_debk2_d[l_ac].debl006
      CALL ap_ref_array2(g_ref_fields,"SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk2_d[l_ac].debl006_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_debk2_d[l_ac].debl006_desc
END FUNCTION

PUBLIC FUNCTION adeq125_debl007_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = '2024'
      LET g_ref_fields[2] = g_debk2_d[l_ac].debl007
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001=? AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk2_d[l_ac].debl007_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_debk2_d[l_ac].debl007_desc
END FUNCTION

PUBLIC FUNCTION adeq125_debm006_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_debk3_d[l_ac].debm006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk3_d[l_ac].debm006_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_debk3_d[l_ac].debm006_desc
END FUNCTION

PUBLIC FUNCTION adeq125_debm006_ref2()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_debk4_d[l_ac].debm006
      CALL ap_ref_array2(g_ref_fields,"SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk4_d[l_ac].debm006_desc_1 = g_rtn_fields[1]
END FUNCTION

PUBLIC FUNCTION adeq125_debksite_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_debk_d[l_ac].debksite
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk_d[l_ac].debksite_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_debk_d[l_ac].debksite_desc
END FUNCTION

PUBLIC FUNCTION adeq125_debk005_ref()
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_debk_d[l_ac].debk005
      CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_debk_d[l_ac].debk005_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_debk_d[l_ac].debk005_desc
END FUNCTION

 
{</section>}
 
