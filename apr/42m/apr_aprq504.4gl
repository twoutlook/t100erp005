#該程式未解開Section, 採用最新樣板產出!
{<section id="aprq504.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2015-01-19 16:20:28), PR版次:0006(2016-10-31 15:48:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000068
#+ Filename...: aprq504
#+ Description: 內部指定日期價格查詢
#+ Creator....: 03247(2014-10-30 16:18:03)
#+ Modifier...: 06189 -SD/PR- 08742
 
{</section>}
 
{<section id="aprq504.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#8   2016/10/26  by 08742  组织开窗修改
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
PRIVATE TYPE type_g_prfm_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   prfmsite LIKE prfm_t.prfmsite, 
   prfmsite_desc LIKE type_t.chr500, 
   prfm002 LIKE prfm_t.prfm002, 
   prfm002_desc LIKE type_t.chr500, 
   ldate LIKE type_t.chr500, 
   prfm001 LIKE prfm_t.prfm001, 
   prfm004 LIKE prfm_t.prfm004 
       END RECORD
PRIVATE TYPE type_g_prfm2_d RECORD
       prfm020 LIKE prfm_t.prfm020, 
   prfm003 LIKE prfm_t.prfm003, 
   prfm003_desc LIKE type_t.chr500, 
   prfm003_desc_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   prfm005 LIKE prfm_t.prfm005, 
   prfm005_desc LIKE type_t.chr500, 
   prfm006 LIKE prfm_t.prfm006, 
   prfm006_desc LIKE type_t.chr500, 
   prfm009 LIKE prfm_t.prfm009, 
   prfm009_desc LIKE type_t.chr500, 
   prfm010 LIKE prfm_t.prfm010, 
   prfm011 LIKE prfm_t.prfm011, 
   prfm012 LIKE prfm_t.prfm012, 
   prfm013 LIKE prfm_t.prfm013, 
   prfm014 LIKE prfm_t.prfm014, 
   prfm015 LIKE prfm_t.prfm015, 
   prfm016 LIKE prfm_t.prfm016, 
   prfm019 LIKE prfm_t.prfm019, 
   prfm017 LIKE prfm_t.prfm017, 
   prfm018 LIKE prfm_t.prfm018
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_date      LIKE prfm_t.prfm007
DEFINE l_ac1       LIKE type_t.num5
DEFINE g_wc3       STRING
DEFINE g_aw        STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_prfm_d
DEFINE g_master_t                   type_g_prfm_d
DEFINE g_prfm_d          DYNAMIC ARRAY OF type_g_prfm_d
DEFINE g_prfm_d_t        type_g_prfm_d
DEFINE g_prfm2_d   DYNAMIC ARRAY OF type_g_prfm2_d
DEFINE g_prfm2_d_t type_g_prfm2_d
 
 
      
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
 
{<section id="aprq504.main" >}
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
   CALL cl_ap_init("apr","")
 
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
   DECLARE aprq504_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprq504_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprq504_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprq504 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprq504_init()   
 
      #進入選單 Menu (="N")
      CALL aprq504_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
 
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprq504
      
   END IF 
   
   CLOSE aprq504_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprq504.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aprq504_init()
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
   
      CALL cl_set_combo_scc('b_prfm001','6043') 
   CALL cl_set_combo_scc('b_prfm004','6042') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309
   #end add-point
 
   CALL aprq504_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aprq504.default_search" >}
PRIVATE FUNCTION aprq504_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " prfmsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " prfm001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " prfm002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " prfm003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " prfm004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " prfm005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " prfm006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " prfm007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " prfm008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " prfm009 = '", g_argv[10], "' AND "
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
 
{<section id="aprq504.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aprq504_ui_dialog()
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
   DEFINE l_cmd    STRING
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
      CALL aprq504_b_fill()
   ELSE
      CALL aprq504_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_prfm_d.clear()
         CALL g_prfm2_d.clear()
 
 
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
 
         CALL aprq504_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prfm_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aprq504_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aprq504_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               LET l_ac_d = l_ac
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_prfm2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_prfm2_d.getLength() TO FORMONLY.h_count
               CALL aprq504_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               CALL aprq504_b_fill()
               IF l_ac_d = 0 THEN
                  LET l_ac_d = 1
               END IF
               IF l_ac_d > g_prfm_d.getLength() THEN
                  LET l_ac_d = 1
               END IF
               LET l_ac = l_ac_d
               CALL aprq504_fetch()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac1 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_prfm2_d.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac1
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
            CALL aprq504_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_curr_diag = ui.DIALOG.getCurrent()
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
               CALL aprq504_query()
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
            CALL aprq504_filter()
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
            CALL aprq504_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_prfm_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_prfm2_d)
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
            CALL aprq504_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aprq504_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aprq504_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aprq504_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_prfm_d.getLength()
               LET g_prfm_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_prfm_d.getLength()
               LET g_prfm_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_prfm_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prfm_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_prfm_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prfm_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            LET g_aw = g_curr_diag.getCurrentItem()
            IF g_aw = "s_detail2" AND g_detail_idx > 0 THEN
               IF NOT cl_null(g_prfm2_d[g_detail_idx].prfm017) THEN
                  LET la_param.prog = "aprm504"
                  LET la_param.param[1] = ''
                  LET la_param.param[2] = ''
                  LET la_param.param[3] = ''
                  LET la_param.param[4] = ''
                  LET la_param.param[5] = g_prfm2_d[g_detail_idx].prfm017
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun_wait(ls_js)
               END IF
            END IF
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
 
{<section id="aprq504.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprq504_query()
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
   CALL g_prfm_d.clear()
   CALL g_prfm2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON prfmsite,prfm002
           FROM s_detail1[1].b_prfmsite,s_detail1[1].b_prfm002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            IF cl_null(g_date) THEN
               LET g_date = g_today
            END IF
            DISPLAY g_date TO b_ldate
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_prfmsite>>----
         #Ctrlp:construct.c.page1.b_prfmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prfmsite
            #add-point:ON ACTION controlp INFIELD b_prfmsite name="construct.c.page1.b_prfmsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfmsite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfmsite  #顯示到畫面上
            NEXT FIELD b_prfmsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prfmsite
            #add-point:BEFORE FIELD b_prfmsite name="construct.b.page1.b_prfmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prfmsite
            
            #add-point:AFTER FIELD b_prfmsite name="construct.a.page1.b_prfmsite"
            
            #END add-point
            
 
 
         #----<<b_prfmsite_desc>>----
         #----<<b_prfm002>>----
         #Ctrlp:construct.c.page1.b_prfm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prfm002
            #add-point:ON ACTION controlp INFIELD b_prfm002 name="construct.c.page1.b_prfm002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'prfm002') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prfm002',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()                           #呼叫開窗
            ELSE
               LET g_qryparam.where = " AND ooef201 = 'Y'"      #161024-00025#8   2016/10/31  by 08742  add
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_prfm002  #顯示到畫面上
            NEXT FIELD b_prfm002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prfm002
            #add-point:BEFORE FIELD b_prfm002 name="construct.b.page1.b_prfm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prfm002
            
            #add-point:AFTER FIELD b_prfm002 name="construct.a.page1.b_prfm002"
            
            #END add-point
            
 
 
         #----<<b_prfm002_desc>>----
         #----<<b_ldate>>----
         #----<<b_prfm001>>----
         #----<<b_prfm004>>----
         #----<<b_prfm020>>----
         #----<<b_prfm003>>----
         #----<<b_prfm003_desc>>----
         #----<<b_prfm003_desc_desc>>----
         #----<<b_imaa009>>----
         #----<<b_prfm005>>----
         #----<<b_prfm005_desc>>----
         #----<<b_prfm006>>----
         #----<<prfm006_desc>>----
         #----<<b_prfm009>>----
         #----<<b_prfm009_desc>>----
         #----<<b_prfm010>>----
         #----<<b_prfm011>>----
         #----<<b_prfm012>>----
         #----<<b_prfm013>>----
         #----<<b_prfm014>>----
         #----<<b_prfm015>>----
         #----<<b_prfm016>>----
         #----<<b_prfm019>>----
         #----<<b_prfm017>>----
         #----<<b_prfm018>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_date FROM s_detail1[1].b_ldate
      
      END INPUT
      
      CONSTRUCT g_wc3 ON prfm020,prfm003,prfm005,prfm006,prfm009,prfm010,prfm011,prfm012,prfm013,prfm014,prfm015,
                         prfm016,prfm019,prfm017,prfm018
         FROM s_detail2[1].b_prfm020,s_detail2[1].b_prfm003,s_detail2[1].b_prfm005,s_detail2[1].b_prfm006,s_detail2[1].b_prfm009,
              s_detail2[1].b_prfm010,s_detail2[1].b_prfm011,s_detail2[1].b_prfm012,s_detail2[1].b_prfm013,s_detail2[1].b_prfm014,
              s_detail2[1].b_prfm015,s_detail2[1].b_prfm016,s_detail2[1].b_prfm019,s_detail2[1].b_prfm017,s_detail2[1].b_prfm018
         
         ON ACTION controlp INFIELD b_prfm020
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm020  #顯示到畫面上
            NEXT FIELD b_prfm020                     #返回原欄位
         
         ON ACTION controlp INFIELD b_prfm003
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm003  #顯示到畫面上
            NEXT FIELD b_prfm003                     #返回原欄位
            
         ON ACTION controlp INFIELD b_prfm005
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm005  #顯示到畫面上
            NEXT FIELD b_prfm005                     #返回原欄位
            
         ON ACTION controlp INFIELD b_prfm006
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm006  #顯示到畫面上
            NEXT FIELD b_prfm006                     #返回原欄位
            
         ON ACTION controlp INFIELD b_prfm009
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm009  #顯示到畫面上
            NEXT FIELD b_prfm009                     #返回原欄位
            
         ON ACTION controlp INFIELD b_prfm017
            #add-point:ON ACTION controlp INFIELD b_prfm003
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " prfi001 = '2' "
            CALL q_prfidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm017  #顯示到畫面上
            NEXT FIELD b_prfm017                    #返回原欄位

         AFTER FIELD b_prfm019
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

            #END add-point
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
   LET g_wc = g_wc," AND TO_DATE('",g_date,"','YY/MM/DD') BETWEEN prfm007 AND prfm008"
   #end add-point
        
   LET g_error_show = 1
   CALL aprq504_b_fill()
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
 
{<section id="aprq504.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprq504_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING       #161024-00025#8   2016/10/26  by 08742       add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #161024-00025#8   2016/10/26  by 08742  -S
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'prfmsite') RETURNING l_where
   IF cl_null(g_wc) THEN
     LET g_wc = " 1=1"
   END IF
   LET g_wc = g_wc," AND ",l_where
   #161024-00025#8   2016/10/26  by 08742   -E
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',prfmsite,'',prfm002,'','',prfm001,prfm004,prfm020,prfm003,'', 
       '','',prfm005,'',prfm006,'',prfm009,'',prfm010,prfm011,prfm012,prfm013,prfm014,prfm015,prfm016, 
       prfm019,prfm017,prfm018  ,DENSE_RANK() OVER( ORDER BY prfm_t.prfmsite,prfm_t.prfm001,prfm_t.prfm002, 
       prfm_t.prfm003,prfm_t.prfm004,prfm_t.prfm005,prfm_t.prfm006,prfm_t.prfm007,prfm_t.prfm008,prfm_t.prfm009) AS RANK FROM prfm_t", 
 
 
 
                     "",
                     " WHERE prfment= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("prfm_t"),
                     " ORDER BY prfm_t.prfmsite,prfm_t.prfm001,prfm_t.prfm002,prfm_t.prfm003,prfm_t.prfm004,prfm_t.prfm005,prfm_t.prfm006,prfm_t.prfm007,prfm_t.prfm008,prfm_t.prfm009"
 
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
 
   LET g_sql = "SELECT '',prfmsite,'',prfm002,'','',prfm001,prfm004,prfm020,prfm003,'','','',prfm005, 
       '',prfm006,'',prfm009,'',prfm010,prfm011,prfm012,prfm013,prfm014,prfm015,prfm016,prfm019,prfm017, 
       prfm018",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   LET g_sql = "SELECT  UNIQUE '',prfmsite,'',prfm002,'','",g_date,"',prfm001,prfm004,'','','','','','',  
       '','','','','','','','','','','','','','', 
       '' FROM prfm_t",
 
 
               "",
               " WHERE prfment= ? AND 1=1 AND prfm001 = '3' AND ",ls_wc,cl_sql_add_filter("prfm_t"),
               " AND ",g_wc3
    
   LET g_sql = g_sql, cl_sql_add_filter("prfm_t"),
                      " ORDER BY prfm_t.prfmsite,prfm_t.prfm002"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aprq504_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aprq504_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_prfm_d.clear()
   CALL g_prfm2_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_prfm_d[l_ac].sel,g_prfm_d[l_ac].prfmsite,g_prfm_d[l_ac].prfmsite_desc, 
       g_prfm_d[l_ac].prfm002,g_prfm_d[l_ac].prfm002_desc,g_prfm_d[l_ac].ldate,g_prfm_d[l_ac].prfm001, 
       g_prfm_d[l_ac].prfm004,g_prfm2_d[l_ac].prfm020,g_prfm2_d[l_ac].prfm003,g_prfm2_d[l_ac].prfm003_desc, 
       g_prfm2_d[l_ac].prfm003_desc_desc,g_prfm2_d[l_ac].imaa009,g_prfm2_d[l_ac].prfm005,g_prfm2_d[l_ac].prfm005_desc, 
       g_prfm2_d[l_ac].prfm006,g_prfm2_d[l_ac].prfm006_desc,g_prfm2_d[l_ac].prfm009,g_prfm2_d[l_ac].prfm009_desc, 
       g_prfm2_d[l_ac].prfm010,g_prfm2_d[l_ac].prfm011,g_prfm2_d[l_ac].prfm012,g_prfm2_d[l_ac].prfm013, 
       g_prfm2_d[l_ac].prfm014,g_prfm2_d[l_ac].prfm015,g_prfm2_d[l_ac].prfm016,g_prfm2_d[l_ac].prfm019, 
       g_prfm2_d[l_ac].prfm017,g_prfm2_d[l_ac].prfm018
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_prfm_d[l_ac].statepic = cl_get_actipic(g_prfm_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_prfm_d[l_ac].sel = 'N'
      #end add-point
 
      CALL aprq504_detail_show("'1'")      
 
      CALL aprq504_prfm_t_mask()
 
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
   
 
   
   CALL g_prfm_d.deleteElement(g_prfm_d.getLength())   
   CALL g_prfm2_d.deleteElement(g_prfm2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_prfm_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aprq504_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aprq504_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aprq504_detail_action_trans()
 
   IF g_prfm_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aprq504_fetch()
   END IF
   
      CALL aprq504_filter_show('prfmsite','b_prfmsite')
   CALL aprq504_filter_show('prfm002','b_prfm002')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprq504_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_sql           STRING
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
   CALL g_prfm2_d.clear()
#   IF l_ac_d = 0 THEN
#      LET l_ac_d = 1
#   END IF
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   LET l_sql = " SELECT UNIQUE prfm020,prfm003,'','','',prfm005,'',prfm006,'',prfm009,'',prfm010, ",
               "        prfm011,prfm012,prfm013,prfm014,prfm015,prfm016,prfm019,prfm017,prfm018 ",
               "   FROM prfm_t",
               "  WHERE prfment = ? AND prfmsite = ? ",
               "    AND prfm001 = ? AND prfm002 = ? AND prfm004 = ? ",
               "    AND TO_DATE('",g_date,"','YY/MM/DD') BETWEEN prfm007 AND prfm008 ",
               "    AND ",g_wc3,
               "  ORDER BY prfm003 "
   PREPARE aprq504_pb2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR aprq504_pb2
   
   OPEN b_fill_curs2 USING g_enterprise,g_prfm_d[l_ac].prfmsite,g_prfm_d[l_ac].prfm001,
                           g_prfm_d[l_ac].prfm002,g_prfm_d[l_ac].prfm004
 
   LET l_ac1 = 1
   FOREACH b_fill_curs2 INTO g_prfm2_d[l_ac1].prfm020,g_prfm2_d[l_ac1].prfm003,g_prfm2_d[l_ac1].prfm003_desc, 
       g_prfm2_d[l_ac1].prfm003_desc_desc,g_prfm2_d[l_ac1].imaa009,g_prfm2_d[l_ac1].prfm005,g_prfm2_d[l_ac1].prfm005_desc, 
       g_prfm2_d[l_ac1].prfm006,g_prfm2_d[l_ac1].prfm006_desc,g_prfm2_d[l_ac1].prfm009,g_prfm2_d[l_ac1].prfm009_desc, 
       g_prfm2_d[l_ac1].prfm010,g_prfm2_d[l_ac1].prfm011,g_prfm2_d[l_ac1].prfm012,g_prfm2_d[l_ac1].prfm013, 
       g_prfm2_d[l_ac1].prfm014,g_prfm2_d[l_ac1].prfm015,g_prfm2_d[l_ac1].prfm016,g_prfm2_d[l_ac1].prfm019, 
       g_prfm2_d[l_ac1].prfm017,g_prfm2_d[l_ac1].prfm018
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #add-point:b_fill段資料填充

      #end add-point
      
      CALL aprq504_detail_show("'2'")      
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac1 = l_ac1 + 1
      
   END FOREACH
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   CALL g_prfm2_d.deleteElement(g_prfm2_d.getLength())
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="aprq504.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aprq504_detail_show(ps_page)
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
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prfm_d[l_ac].prfmsite
      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_prfm_d[l_ac].prfmsite_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prfm_d[l_ac].prfmsite_desc


      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_prfm_d[l_ac].prfm002
      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      LET g_prfm_d[l_ac].prfm002_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_prfm_d[l_ac].prfm002_desc
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfm2_d[l_ac1].prfm003
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].prfm003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].prfm003_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfm2_d[l_ac1].prfm003
            LET ls_sql = "SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].prfm003_desc_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].prfm003_desc_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfm2_d[l_ac1].prfm003
            LET ls_sql = "SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].imaa009 = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].imaa009

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfm2_d[l_ac1].prfm005
            LET ls_sql = "SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].prfm005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].prfm005_desc

            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_prfm_d[l_ac].prfmsite
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_prfm2_d[l_ac1].prfm006
            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].prfm006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].prfm006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prfm2_d[l_ac1].prfm009
            LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_prfm2_d[l_ac1].prfm009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prfm2_d[l_ac1].prfm009_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq504_filter()
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
      CONSTRUCT g_wc_filter ON prfmsite,prfm002
                          FROM s_detail1[1].b_prfmsite,s_detail1[1].b_prfm002
 
         BEFORE CONSTRUCT
                     DISPLAY aprq504_filter_parser('prfmsite') TO s_detail1[1].b_prfmsite
            DISPLAY aprq504_filter_parser('prfm002') TO s_detail1[1].b_prfm002
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_prfmsite>>----
         #Ctrlp:construct.c.page1.b_prfmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prfmsite
            #add-point:ON ACTION controlp INFIELD b_prfmsite name="construct.c.filter.page1.b_prfmsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfmsite  #顯示到畫面上
            NEXT FIELD b_prfmsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prfmsite_desc>>----
         #----<<b_prfm002>>----
         #Ctrlp:construct.c.page1.b_prfm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prfm002
            #add-point:ON ACTION controlp INFIELD b_prfm002 name="construct.c.filter.page1.b_prfm002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prfm002  #顯示到畫面上
            NEXT FIELD b_prfm002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prfm002_desc>>----
         #----<<b_ldate>>----
         #----<<b_prfm001>>----
         #----<<b_prfm004>>----
         #----<<b_prfm020>>----
         #----<<b_prfm003>>----
         #----<<b_prfm003_desc>>----
         #----<<b_prfm003_desc_desc>>----
         #----<<b_imaa009>>----
         #----<<b_prfm005>>----
         #----<<b_prfm005_desc>>----
         #----<<b_prfm006>>----
         #----<<prfm006_desc>>----
         #----<<b_prfm009>>----
         #----<<b_prfm009_desc>>----
         #----<<b_prfm010>>----
         #----<<b_prfm011>>----
         #----<<b_prfm012>>----
         #----<<b_prfm013>>----
         #----<<b_prfm014>>----
         #----<<b_prfm015>>----
         #----<<b_prfm016>>----
         #----<<b_prfm019>>----
         #----<<b_prfm017>>----
         #----<<b_prfm018>>----
   
 
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
   
      CALL aprq504_filter_show('prfmsite','b_prfmsite')
   CALL aprq504_filter_show('prfm002','b_prfm002')
 
    
   CALL aprq504_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aprq504_filter_parser(ps_field)
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
 
{<section id="aprq504.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aprq504_filter_show(ps_field,ps_object)
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
   LET ls_condition = aprq504_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.insert" >}
#+ insert
PRIVATE FUNCTION aprq504_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprq504.modify" >}
#+ modify
PRIVATE FUNCTION aprq504_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aprq504_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.delete" >}
#+ delete
PRIVATE FUNCTION aprq504_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq504.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aprq504_detail_action_trans()
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
 
{<section id="aprq504.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aprq504_detail_index_setting()
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
            IF g_prfm_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_prfm_d.getLength() AND g_prfm_d.getLength() > 0
            LET g_detail_idx = g_prfm_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_prfm_d.getLength() THEN
               LET g_detail_idx = g_prfm_d.getLength()
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
 
{<section id="aprq504.mask_functions" >}
 &include "erp/apr/aprq504_mask.4gl"
 
{</section>}
 
{<section id="aprq504.other_function" readonly="Y" >}

 
{</section>}
 
