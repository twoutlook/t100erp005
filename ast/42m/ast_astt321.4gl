#該程式未解開Section, 採用最新樣板產出!
{<section id="astt321.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-05-18 14:17:56), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: astt321
#+ Description: 跨月費用單維護作業
#+ Creator....: 03247(2015-05-18 14:17:56)
#+ Modifier...: 03247 -SD/PR- 00000
 
{</section>}
 
{<section id="astt321.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#161024-00025#3   2016/10/26   By dongsz  b_stbg014开窗替换q_ooef001_24，条件ooef201=Y
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
PRIVATE TYPE type_g_stbg_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   stbgstus LIKE stbg_t.stbgstus, 
   stbg001 LIKE stbg_t.stbg001, 
   stbg002 LIKE stbg_t.stbg002, 
   stbgunit LIKE stbg_t.stbgunit, 
   stbgunit_desc LIKE type_t.chr500, 
   stbgdocno LIKE stbg_t.stbgdocno, 
   stbgseq LIKE stbg_t.stbgseq, 
   stbg003 LIKE stbg_t.stbg003, 
   stbg004 LIKE stbg_t.stbg004, 
   stbg005 LIKE stbg_t.stbg005, 
   stbg005_desc LIKE type_t.chr500, 
   stbg006 LIKE stbg_t.stbg006, 
   stbg006_desc LIKE type_t.chr500, 
   stbg007 LIKE stbg_t.stbg007, 
   stbg007_desc LIKE type_t.chr500, 
   stbg008 LIKE stbg_t.stbg008, 
   stbg008_desc LIKE type_t.chr500, 
   stbg009 LIKE stbg_t.stbg009, 
   stbg009_desc LIKE type_t.chr500, 
   stbg010 LIKE stbg_t.stbg010, 
   stbg010_desc LIKE type_t.chr500, 
   stbg011 LIKE stbg_t.stbg011, 
   stbg012 LIKE stbg_t.stbg012, 
   stbg012_desc LIKE type_t.chr500, 
   stbg013 LIKE stbg_t.stbg013, 
   stbg014 LIKE stbg_t.stbg014, 
   stbg014_desc LIKE type_t.chr500, 
   stbg015 LIKE stbg_t.stbg015, 
   stbg015_desc LIKE type_t.chr500, 
   stbg016 LIKE stbg_t.stbg016, 
   stbg016_desc LIKE type_t.chr500, 
   stbgsite LIKE stbg_t.stbgsite 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_aw                  STRING                        #確定當下點擊的單身

DEFINE g_date_m              RECORD
          stbg001            LIKE stbg_t.stbg001,
          stbg002            LIKE stbg_t.stbg002
                             END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stbg_d
DEFINE g_master_t                   type_g_stbg_d
DEFINE g_stbg_d          DYNAMIC ARRAY OF type_g_stbg_d
DEFINE g_stbg_d_t        type_g_stbg_d
 
      
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
 
{<section id="astt321.main" >}
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
   CALL cl_ap_init("ast","")
 
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
   DECLARE astt321_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astt321_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astt321_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astt321 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astt321_init()   
 
      #進入選單 Menu (="N")
      CALL astt321_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astt321
      
   END IF 
   
   CLOSE astt321_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astt321.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astt321_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_stbgstus','6811')
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   CALL astt321_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astt321.default_search" >}
PRIVATE FUNCTION astt321_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stbgdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stbgseq = '", g_argv[02], "' AND "
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
 
{<section id="astt321.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astt321_ui_dialog()
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
      CALL astt321_b_fill()
   ELSE
      CALL astt321_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stbg_d.clear()
 
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
 
         CALL astt321_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stbg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astt321_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astt321_detail_action_trans()
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
            CALL astt321_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION get_data
            LET g_action_choice="get_data"
            IF cl_auth_chk_act("get_data") THEN
               
               #add-point:ON ACTION get_data name="menu.get_data"
               #CALL cl_set_act_visible("accept,cancel", TRUE)
               CALL astt321_get_data()
               #CALL cl_set_act_visible("accept,cancel", FALSE)
               CALL astt321_b_fill()
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
               CALL astt321_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL astt321_filter()
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
            CALL astt321_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stbg_d)
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
            CALL astt321_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astt321_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astt321_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astt321_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_stbg_d.getLength()
               LET g_stbg_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_stbg_d.getLength()
               LET g_stbg_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_stbg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stbg_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_stbg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_stbg_d[li_idx].sel = "N"
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
 
{<section id="astt321.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astt321_query()
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
   CALL g_stbg_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON stbgstus,stbg001,stbg002,stbgunit,stbgdocno,stbgseq,stbg003,stbg004,stbg005, 
          stbg006,stbg007,stbg008,stbg009,stbg010,stbg011,stbg012,stbg013,stbg014,stbg015,stbg016,stbgsite 
 
           FROM s_detail1[1].b_stbgstus,s_detail1[1].b_stbg001,s_detail1[1].b_stbg002,s_detail1[1].b_stbgunit, 
               s_detail1[1].b_stbgdocno,s_detail1[1].b_stbgseq,s_detail1[1].b_stbg003,s_detail1[1].b_stbg004, 
               s_detail1[1].b_stbg005,s_detail1[1].b_stbg006,s_detail1[1].b_stbg007,s_detail1[1].b_stbg008, 
               s_detail1[1].b_stbg009,s_detail1[1].b_stbg010,s_detail1[1].b_stbg011,s_detail1[1].b_stbg012, 
               s_detail1[1].b_stbg013,s_detail1[1].b_stbg014,s_detail1[1].b_stbg015,s_detail1[1].b_stbg016, 
               s_detail1[1].b_stbgsite
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stbgcrtdt>>----
         #AFTER FIELD stbgcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stbgmoddt>>----
         #AFTER FIELD stbgmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbgcnfdt>>----
         #AFTER FIELD stbgcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbgpstdt>>----
         #AFTER FIELD stbgpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_stbgstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbgstus
            #add-point:BEFORE FIELD b_stbgstus name="construct.b.page1.b_stbgstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbgstus
            
            #add-point:AFTER FIELD b_stbgstus name="construct.a.page1.b_stbgstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgstus
            #add-point:ON ACTION controlp INFIELD b_stbgstus name="construct.c.page1.b_stbgstus"
            
            #END add-point
 
 
         #----<<b_stbg001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg001
            #add-point:BEFORE FIELD b_stbg001 name="construct.b.page1.b_stbg001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg001
            
            #add-point:AFTER FIELD b_stbg001 name="construct.a.page1.b_stbg001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg001
            #add-point:ON ACTION controlp INFIELD b_stbg001 name="construct.c.page1.b_stbg001"
            
            #END add-point
 
 
         #----<<b_stbg002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg002
            #add-point:BEFORE FIELD b_stbg002 name="construct.b.page1.b_stbg002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg002
            
            #add-point:AFTER FIELD b_stbg002 name="construct.a.page1.b_stbg002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg002
            #add-point:ON ACTION controlp INFIELD b_stbg002 name="construct.c.page1.b_stbg002"
            
            #END add-point
 
 
         #----<<b_stbgunit>>----
         #Ctrlp:construct.c.page1.b_stbgunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgunit
            #add-point:ON ACTION controlp INFIELD b_stbgunit name="construct.c.page1.b_stbgunit"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbgunit',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbgunit  #顯示到畫面上
            NEXT FIELD b_stbgunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbgunit
            #add-point:BEFORE FIELD b_stbgunit name="construct.b.page1.b_stbgunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbgunit
            
            #add-point:AFTER FIELD b_stbgunit name="construct.a.page1.b_stbgunit"
            
            #END add-point
            
 
 
         #----<<b_stbgunit_desc>>----
         #----<<b_stbgdocno>>----
         #Ctrlp:construct.c.page1.b_stbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgdocno
            #add-point:ON ACTION controlp INFIELD b_stbgdocno name="construct.c.page1.b_stbgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbgdocno  #顯示到畫面上
            NEXT FIELD b_stbgdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbgdocno
            #add-point:BEFORE FIELD b_stbgdocno name="construct.b.page1.b_stbgdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbgdocno
            
            #add-point:AFTER FIELD b_stbgdocno name="construct.a.page1.b_stbgdocno"
            
            #END add-point
            
 
 
         #----<<b_stbgseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbgseq
            #add-point:BEFORE FIELD b_stbgseq name="construct.b.page1.b_stbgseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbgseq
            
            #add-point:AFTER FIELD b_stbgseq name="construct.a.page1.b_stbgseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgseq
            #add-point:ON ACTION controlp INFIELD b_stbgseq name="construct.c.page1.b_stbgseq"
            
            #END add-point
 
 
         #----<<b_stbg003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg003
            #add-point:BEFORE FIELD b_stbg003 name="construct.b.page1.b_stbg003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg003
            
            #add-point:AFTER FIELD b_stbg003 name="construct.a.page1.b_stbg003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg003
            #add-point:ON ACTION controlp INFIELD b_stbg003 name="construct.c.page1.b_stbg003"
            
            #END add-point
 
 
         #----<<b_stbg004>>----
         #Ctrlp:construct.c.page1.b_stbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg004
            #add-point:ON ACTION controlp INFIELD b_stbg004 name="construct.c.page1.b_stbg004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stan001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg004  #顯示到畫面上
            NEXT FIELD b_stbg004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg004
            #add-point:BEFORE FIELD b_stbg004 name="construct.b.page1.b_stbg004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg004
            
            #add-point:AFTER FIELD b_stbg004 name="construct.a.page1.b_stbg004"
            
            #END add-point
            
 
 
         #----<<b_stbg005>>----
         #Ctrlp:construct.c.page1.b_stbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg005
            #add-point:ON ACTION controlp INFIELD b_stbg005 name="construct.c.page1.b_stbg005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg005  #顯示到畫面上
            NEXT FIELD b_stbg005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg005
            #add-point:BEFORE FIELD b_stbg005 name="construct.b.page1.b_stbg005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg005
            
            #add-point:AFTER FIELD b_stbg005 name="construct.a.page1.b_stbg005"
            
            #END add-point
            
 
 
         #----<<b_stbg005_desc>>----
         #----<<b_stbg006>>----
         #Ctrlp:construct.c.page1.b_stbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg006
            #add-point:ON ACTION controlp INFIELD b_stbg006 name="construct.c.page1.b_stbg006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg006  #顯示到畫面上
            NEXT FIELD b_stbg006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg006
            #add-point:BEFORE FIELD b_stbg006 name="construct.b.page1.b_stbg006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg006
            
            #add-point:AFTER FIELD b_stbg006 name="construct.a.page1.b_stbg006"
            
            #END add-point
            
 
 
         #----<<b_stbg006_desc>>----
         #----<<b_stbg007>>----
         #Ctrlp:construct.c.page1.b_stbg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg007
            #add-point:ON ACTION controlp INFIELD b_stbg007 name="construct.c.page1.b_stbg007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2060'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg007  #顯示到畫面上
            NEXT FIELD b_stbg007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg007
            #add-point:BEFORE FIELD b_stbg007 name="construct.b.page1.b_stbg007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg007
            
            #add-point:AFTER FIELD b_stbg007 name="construct.a.page1.b_stbg007"
            
            #END add-point
            
 
 
         #----<<b_stbg007_desc>>----
         #----<<b_stbg008>>----
         #Ctrlp:construct.c.page1.b_stbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg008
            #add-point:ON ACTION controlp INFIELD b_stbg008 name="construct.c.page1.b_stbg008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stbg008') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbg008',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               CALL q_ooef001_23() 
            END IF
            DISPLAY g_qryparam.return1 TO b_stbg008  #顯示到畫面上
            NEXT FIELD b_stbg008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg008
            #add-point:BEFORE FIELD b_stbg008 name="construct.b.page1.b_stbg008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg008
            
            #add-point:AFTER FIELD b_stbg008 name="construct.a.page1.b_stbg008"
            
            #END add-point
            
 
 
         #----<<b_stbg008_desc>>----
         #----<<b_stbg009>>----
         #Ctrlp:construct.c.page1.b_stbg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg009
            #add-point:ON ACTION controlp INFIELD b_stbg009 name="construct.c.page1.b_stbg009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg009  #顯示到畫面上
            NEXT FIELD b_stbg009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg009
            #add-point:BEFORE FIELD b_stbg009 name="construct.b.page1.b_stbg009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg009
            
            #add-point:AFTER FIELD b_stbg009 name="construct.a.page1.b_stbg009"
            
            #END add-point
            
 
 
         #----<<b_stbg009_desc>>----
         #----<<b_stbg010>>----
         #Ctrlp:construct.c.page1.b_stbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg010
            #add-point:ON ACTION controlp INFIELD b_stbg010 name="construct.c.page1.b_stbg010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2058'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg010  #顯示到畫面上
            NEXT FIELD b_stbg010                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg010
            #add-point:BEFORE FIELD b_stbg010 name="construct.b.page1.b_stbg010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg010
            
            #add-point:AFTER FIELD b_stbg010 name="construct.a.page1.b_stbg010"
            
            #END add-point
            
 
 
         #----<<b_stbg010_desc>>----
         #----<<b_stbg011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg011
            #add-point:BEFORE FIELD b_stbg011 name="construct.b.page1.b_stbg011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg011
            
            #add-point:AFTER FIELD b_stbg011 name="construct.a.page1.b_stbg011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg011
            #add-point:ON ACTION controlp INFIELD b_stbg011 name="construct.c.page1.b_stbg011"
            
            #END add-point
 
 
         #----<<b_stbg012>>----
         #Ctrlp:construct.c.page1.b_stbg012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg012
            #add-point:ON ACTION controlp INFIELD b_stbg012 name="construct.c.page1.b_stbg012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg012  #顯示到畫面上
            NEXT FIELD b_stbg012                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg012
            #add-point:BEFORE FIELD b_stbg012 name="construct.b.page1.b_stbg012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg012
            
            #add-point:AFTER FIELD b_stbg012 name="construct.a.page1.b_stbg012"
            
            #END add-point
            
 
 
         #----<<b_stbg012_desc>>----
         #----<<b_stbg013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg013
            #add-point:BEFORE FIELD b_stbg013 name="construct.b.page1.b_stbg013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg013
            
            #add-point:AFTER FIELD b_stbg013 name="construct.a.page1.b_stbg013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg013
            #add-point:ON ACTION controlp INFIELD b_stbg013 name="construct.c.page1.b_stbg013"
            
            #END add-point
 
 
         #----<<b_stbg014>>----
         #Ctrlp:construct.c.page1.b_stbg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg014
            #add-point:ON ACTION controlp INFIELD b_stbg014 name="construct.c.page1.b_stbg014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stbg014') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbg014',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               #CALL q_ooef001_14()       #161024-00025#3 mark
               LET g_qryparam.where = " ooef201 = 'Y' "    #161024-00025#3 add
               CALL q_ooef001_24()        #161024-00025#3 add
            END IF
            DISPLAY g_qryparam.return1 TO b_stbg014  #顯示到畫面上
            NEXT FIELD b_stbg014                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg014
            #add-point:BEFORE FIELD b_stbg014 name="construct.b.page1.b_stbg014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg014
            
            #add-point:AFTER FIELD b_stbg014 name="construct.a.page1.b_stbg014"
            
            #END add-point
            
 
 
         #----<<b_stbg014_desc>>----
         #----<<b_stbg015>>----
         #Ctrlp:construct.c.page1.b_stbg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg015
            #add-point:ON ACTION controlp INFIELD b_stbg015 name="construct.c.page1.b_stbg015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg015  #顯示到畫面上
            NEXT FIELD b_stbg015                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg015
            #add-point:BEFORE FIELD b_stbg015 name="construct.b.page1.b_stbg015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg015
            
            #add-point:AFTER FIELD b_stbg015 name="construct.a.page1.b_stbg015"
            
            #END add-point
            
 
 
         #----<<b_stbg015_desc>>----
         #----<<b_stbg016>>----
         #Ctrlp:construct.c.page1.b_stbg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg016
            #add-point:ON ACTION controlp INFIELD b_stbg016 name="construct.c.page1.b_stbg016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg016  #顯示到畫面上
            NEXT FIELD b_stbg016                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbg016
            #add-point:BEFORE FIELD b_stbg016 name="construct.b.page1.b_stbg016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbg016
            
            #add-point:AFTER FIELD b_stbg016 name="construct.a.page1.b_stbg016"
            
            #END add-point
            
 
 
         #----<<b_stbg016_desc>>----
         #----<<b_stbgsite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stbgsite
            #add-point:BEFORE FIELD b_stbgsite name="construct.b.page1.b_stbgsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stbgsite
            
            #add-point:AFTER FIELD b_stbgsite name="construct.a.page1.b_stbgsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stbgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgsite
            #add-point:ON ACTION controlp INFIELD b_stbgsite name="construct.c.page1.b_stbgsite"
            
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
   CALL astt321_b_fill()
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
 
{<section id="astt321.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astt321_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',stbgstus,stbg001,stbg002,stbgunit,'',stbgdocno,stbgseq,stbg003, 
       stbg004,stbg005,'',stbg006,'',stbg007,'',stbg008,'',stbg009,'',stbg010,'',stbg011,stbg012,'', 
       stbg013,stbg014,'',stbg015,'',stbg016,'',stbgsite  ,DENSE_RANK() OVER( ORDER BY stbg_t.stbgdocno, 
       stbg_t.stbgseq) AS RANK FROM stbg_t",
 
 
                     "",
                     " WHERE stbgent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stbg_t"),
                     " ORDER BY stbg_t.stbgdocno,stbg_t.stbgseq"
 
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
 
   LET g_sql = "SELECT '',stbgstus,stbg001,stbg002,stbgunit,'',stbgdocno,stbgseq,stbg003,stbg004,stbg005, 
       '',stbg006,'',stbg007,'',stbg008,'',stbg009,'',stbg010,'',stbg011,stbg012,'',stbg013,stbg014, 
       '',stbg015,'',stbg016,'',stbgsite",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astt321_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astt321_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stbg_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_stbg_d[l_ac].sel,g_stbg_d[l_ac].stbgstus,g_stbg_d[l_ac].stbg001,g_stbg_d[l_ac].stbg002, 
       g_stbg_d[l_ac].stbgunit,g_stbg_d[l_ac].stbgunit_desc,g_stbg_d[l_ac].stbgdocno,g_stbg_d[l_ac].stbgseq, 
       g_stbg_d[l_ac].stbg003,g_stbg_d[l_ac].stbg004,g_stbg_d[l_ac].stbg005,g_stbg_d[l_ac].stbg005_desc, 
       g_stbg_d[l_ac].stbg006,g_stbg_d[l_ac].stbg006_desc,g_stbg_d[l_ac].stbg007,g_stbg_d[l_ac].stbg007_desc, 
       g_stbg_d[l_ac].stbg008,g_stbg_d[l_ac].stbg008_desc,g_stbg_d[l_ac].stbg009,g_stbg_d[l_ac].stbg009_desc, 
       g_stbg_d[l_ac].stbg010,g_stbg_d[l_ac].stbg010_desc,g_stbg_d[l_ac].stbg011,g_stbg_d[l_ac].stbg012, 
       g_stbg_d[l_ac].stbg012_desc,g_stbg_d[l_ac].stbg013,g_stbg_d[l_ac].stbg014,g_stbg_d[l_ac].stbg014_desc, 
       g_stbg_d[l_ac].stbg015,g_stbg_d[l_ac].stbg015_desc,g_stbg_d[l_ac].stbg016,g_stbg_d[l_ac].stbg016_desc, 
       g_stbg_d[l_ac].stbgsite
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_stbg_d[l_ac].statepic = cl_get_actipic(g_stbg_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_stbg_d[l_ac].sel = 'N'
      #end add-point
 
      CALL astt321_detail_show("'1'")      
 
      CALL astt321_stbg_t_mask()
 
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
   
 
   
   CALL g_stbg_d.deleteElement(g_stbg_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_stbg_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astt321_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astt321_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astt321_detail_action_trans()
 
   IF g_stbg_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astt321_fetch()
   END IF
   
      CALL astt321_filter_show('stbgstus','b_stbgstus')
   CALL astt321_filter_show('stbg001','b_stbg001')
   CALL astt321_filter_show('stbg002','b_stbg002')
   CALL astt321_filter_show('stbgunit','b_stbgunit')
   CALL astt321_filter_show('stbgdocno','b_stbgdocno')
   CALL astt321_filter_show('stbgseq','b_stbgseq')
   CALL astt321_filter_show('stbg003','b_stbg003')
   CALL astt321_filter_show('stbg004','b_stbg004')
   CALL astt321_filter_show('stbg005','b_stbg005')
   CALL astt321_filter_show('stbg006','b_stbg006')
   CALL astt321_filter_show('stbg007','b_stbg007')
   CALL astt321_filter_show('stbg008','b_stbg008')
   CALL astt321_filter_show('stbg009','b_stbg009')
   CALL astt321_filter_show('stbg010','b_stbg010')
   CALL astt321_filter_show('stbg011','b_stbg011')
   CALL astt321_filter_show('stbg012','b_stbg012')
   CALL astt321_filter_show('stbg013','b_stbg013')
   CALL astt321_filter_show('stbg014','b_stbg014')
   CALL astt321_filter_show('stbg015','b_stbg015')
   CALL astt321_filter_show('stbg016','b_stbg016')
   CALL astt321_filter_show('stbgsite','b_stbgsite')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt321.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astt321_fetch()
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
 
{<section id="astt321.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astt321_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbgunit
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbgunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbgunit_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg005
            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg006
            LET ls_sql = "SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg006_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg007
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2060' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg007_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg008
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg008_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg009
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg009_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg010
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2058' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg014
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg014_desc
            
            SELECT ooef019 INTO l_ooef019 FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_stbg_d[l_ac].stbgunit
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = l_ooef019
            LET g_ref_fields[2] = g_stbg_d[l_ac].stbg012
            LET ls_sql = "SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg012_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg012_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg015
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg015_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stbg_d[l_ac].stbg016
            LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stbg_d[l_ac].stbg016_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stbg_d[l_ac].stbg016_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astt321.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astt321_filter()
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
      CONSTRUCT g_wc_filter ON stbgstus,stbg001,stbg002,stbgunit,stbgdocno,stbgseq,stbg003,stbg004,stbg005, 
          stbg006,stbg007,stbg008,stbg009,stbg010,stbg011,stbg012,stbg013,stbg014,stbg015,stbg016,stbgsite 
 
                          FROM s_detail1[1].b_stbgstus,s_detail1[1].b_stbg001,s_detail1[1].b_stbg002, 
                              s_detail1[1].b_stbgunit,s_detail1[1].b_stbgdocno,s_detail1[1].b_stbgseq, 
                              s_detail1[1].b_stbg003,s_detail1[1].b_stbg004,s_detail1[1].b_stbg005,s_detail1[1].b_stbg006, 
                              s_detail1[1].b_stbg007,s_detail1[1].b_stbg008,s_detail1[1].b_stbg009,s_detail1[1].b_stbg010, 
                              s_detail1[1].b_stbg011,s_detail1[1].b_stbg012,s_detail1[1].b_stbg013,s_detail1[1].b_stbg014, 
                              s_detail1[1].b_stbg015,s_detail1[1].b_stbg016,s_detail1[1].b_stbgsite
 
         BEFORE CONSTRUCT
                     DISPLAY astt321_filter_parser('stbgstus') TO s_detail1[1].b_stbgstus
            DISPLAY astt321_filter_parser('stbg001') TO s_detail1[1].b_stbg001
            DISPLAY astt321_filter_parser('stbg002') TO s_detail1[1].b_stbg002
            DISPLAY astt321_filter_parser('stbgunit') TO s_detail1[1].b_stbgunit
            DISPLAY astt321_filter_parser('stbgdocno') TO s_detail1[1].b_stbgdocno
            DISPLAY astt321_filter_parser('stbgseq') TO s_detail1[1].b_stbgseq
            DISPLAY astt321_filter_parser('stbg003') TO s_detail1[1].b_stbg003
            DISPLAY astt321_filter_parser('stbg004') TO s_detail1[1].b_stbg004
            DISPLAY astt321_filter_parser('stbg005') TO s_detail1[1].b_stbg005
            DISPLAY astt321_filter_parser('stbg006') TO s_detail1[1].b_stbg006
            DISPLAY astt321_filter_parser('stbg007') TO s_detail1[1].b_stbg007
            DISPLAY astt321_filter_parser('stbg008') TO s_detail1[1].b_stbg008
            DISPLAY astt321_filter_parser('stbg009') TO s_detail1[1].b_stbg009
            DISPLAY astt321_filter_parser('stbg010') TO s_detail1[1].b_stbg010
            DISPLAY astt321_filter_parser('stbg011') TO s_detail1[1].b_stbg011
            DISPLAY astt321_filter_parser('stbg012') TO s_detail1[1].b_stbg012
            DISPLAY astt321_filter_parser('stbg013') TO s_detail1[1].b_stbg013
            DISPLAY astt321_filter_parser('stbg014') TO s_detail1[1].b_stbg014
            DISPLAY astt321_filter_parser('stbg015') TO s_detail1[1].b_stbg015
            DISPLAY astt321_filter_parser('stbg016') TO s_detail1[1].b_stbg016
            DISPLAY astt321_filter_parser('stbgsite') TO s_detail1[1].b_stbgsite
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<stbgcrtdt>>----
         #AFTER FIELD stbgcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<stbgmoddt>>----
         #AFTER FIELD stbgmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbgcnfdt>>----
         #AFTER FIELD stbgcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<stbgpstdt>>----
         #AFTER FIELD stbgpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_stbgstus>>----
         #Ctrlp:construct.c.filter.page1.b_stbgstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgstus
            #add-point:ON ACTION controlp INFIELD b_stbgstus name="construct.c.filter.page1.b_stbgstus"
            
            #END add-point
 
 
         #----<<b_stbg001>>----
         #Ctrlp:construct.c.filter.page1.b_stbg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg001
            #add-point:ON ACTION controlp INFIELD b_stbg001 name="construct.c.filter.page1.b_stbg001"
            
            #END add-point
 
 
         #----<<b_stbg002>>----
         #Ctrlp:construct.c.filter.page1.b_stbg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg002
            #add-point:ON ACTION controlp INFIELD b_stbg002 name="construct.c.filter.page1.b_stbg002"
            
            #END add-point
 
 
         #----<<b_stbgunit>>----
         #Ctrlp:construct.c.page1.b_stbgunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgunit
            #add-point:ON ACTION controlp INFIELD b_stbgunit name="construct.c.filter.page1.b_stbgunit"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbgunit',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbgunit  #顯示到畫面上
            NEXT FIELD b_stbgunit                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbgunit_desc>>----
         #----<<b_stbgdocno>>----
         #Ctrlp:construct.c.page1.b_stbgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgdocno
            #add-point:ON ACTION controlp INFIELD b_stbgdocno name="construct.c.filter.page1.b_stbgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stbgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbgdocno  #顯示到畫面上
            NEXT FIELD b_stbgdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbgseq>>----
         #Ctrlp:construct.c.filter.page1.b_stbgseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgseq
            #add-point:ON ACTION controlp INFIELD b_stbgseq name="construct.c.filter.page1.b_stbgseq"
            
            #END add-point
 
 
         #----<<b_stbg003>>----
         #Ctrlp:construct.c.filter.page1.b_stbg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg003
            #add-point:ON ACTION controlp INFIELD b_stbg003 name="construct.c.filter.page1.b_stbg003"
            
            #END add-point
 
 
         #----<<b_stbg004>>----
         #Ctrlp:construct.c.page1.b_stbg004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg004
            #add-point:ON ACTION controlp INFIELD b_stbg004 name="construct.c.filter.page1.b_stbg004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stan001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg004  #顯示到畫面上
            NEXT FIELD b_stbg004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg005>>----
         #Ctrlp:construct.c.page1.b_stbg005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg005
            #add-point:ON ACTION controlp INFIELD b_stbg005 name="construct.c.filter.page1.b_stbg005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_10()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg005  #顯示到畫面上
            NEXT FIELD b_stbg005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg005_desc>>----
         #----<<b_stbg006>>----
         #Ctrlp:construct.c.page1.b_stbg006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg006
            #add-point:ON ACTION controlp INFIELD b_stbg006 name="construct.c.filter.page1.b_stbg006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg006  #顯示到畫面上
            NEXT FIELD b_stbg006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg006_desc>>----
         #----<<b_stbg007>>----
         #Ctrlp:construct.c.page1.b_stbg007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg007
            #add-point:ON ACTION controlp INFIELD b_stbg007 name="construct.c.filter.page1.b_stbg007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2060'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg007  #顯示到畫面上
            NEXT FIELD b_stbg007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg007_desc>>----
         #----<<b_stbg008>>----
         #Ctrlp:construct.c.page1.b_stbg008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg008
            #add-point:ON ACTION controlp INFIELD b_stbg008 name="construct.c.filter.page1.b_stbg008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stbg008') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbg008',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               CALL q_ooef001_23() 
            END IF                        
            DISPLAY g_qryparam.return1 TO b_stbg008  #顯示到畫面上
            NEXT FIELD b_stbg008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg008_desc>>----
         #----<<b_stbg009>>----
         #Ctrlp:construct.c.page1.b_stbg009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg009
            #add-point:ON ACTION controlp INFIELD b_stbg009 name="construct.c.filter.page1.b_stbg009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg009  #顯示到畫面上
            NEXT FIELD b_stbg009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg009_desc>>----
         #----<<b_stbg010>>----
         #Ctrlp:construct.c.page1.b_stbg010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg010
            #add-point:ON ACTION controlp INFIELD b_stbg010 name="construct.c.filter.page1.b_stbg010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2058'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg010  #顯示到畫面上
            NEXT FIELD b_stbg010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg010_desc>>----
         #----<<b_stbg011>>----
         #Ctrlp:construct.c.filter.page1.b_stbg011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg011
            #add-point:ON ACTION controlp INFIELD b_stbg011 name="construct.c.filter.page1.b_stbg011"
            
            #END add-point
 
 
         #----<<b_stbg012>>----
         #Ctrlp:construct.c.page1.b_stbg012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg012
            #add-point:ON ACTION controlp INFIELD b_stbg012 name="construct.c.filter.page1.b_stbg012"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg012  #顯示到畫面上
            NEXT FIELD b_stbg012                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg012_desc>>----
         #----<<b_stbg013>>----
         #Ctrlp:construct.c.filter.page1.b_stbg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg013
            #add-point:ON ACTION controlp INFIELD b_stbg013 name="construct.c.filter.page1.b_stbg013"
            
            #END add-point
 
 
         #----<<b_stbg014>>----
         #Ctrlp:construct.c.page1.b_stbg014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg014
            #add-point:ON ACTION controlp INFIELD b_stbg014 name="construct.c.filter.page1.b_stbg014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'stbg014') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'stbg014',g_site,'c')
               CALL q_ooef001_24() 
            ELSE
               #CALL q_ooef001_14()           #161024-00025#3 mark
               LET g_qryparam.where = " ooef201 = 'Y' "    #161024-00025#3 add
               CALL q_ooef001_24()        #161024-00025#3 add
            END IF
            DISPLAY g_qryparam.return1 TO b_stbg014  #顯示到畫面上
            NEXT FIELD b_stbg014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg014_desc>>----
         #----<<b_stbg015>>----
         #Ctrlp:construct.c.page1.b_stbg015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg015
            #add-point:ON ACTION controlp INFIELD b_stbg015 name="construct.c.filter.page1.b_stbg015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg015  #顯示到畫面上
            NEXT FIELD b_stbg015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg015_desc>>----
         #----<<b_stbg016>>----
         #Ctrlp:construct.c.page1.b_stbg016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbg016
            #add-point:ON ACTION controlp INFIELD b_stbg016 name="construct.c.filter.page1.b_stbg016"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_stbg016  #顯示到畫面上
            NEXT FIELD b_stbg016                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_stbg016_desc>>----
         #----<<b_stbgsite>>----
         #Ctrlp:construct.c.filter.page1.b_stbgsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stbgsite
            #add-point:ON ACTION controlp INFIELD b_stbgsite name="construct.c.filter.page1.b_stbgsite"
            
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
   
      CALL astt321_filter_show('stbgstus','b_stbgstus')
   CALL astt321_filter_show('stbg001','b_stbg001')
   CALL astt321_filter_show('stbg002','b_stbg002')
   CALL astt321_filter_show('stbgunit','b_stbgunit')
   CALL astt321_filter_show('stbgdocno','b_stbgdocno')
   CALL astt321_filter_show('stbgseq','b_stbgseq')
   CALL astt321_filter_show('stbg003','b_stbg003')
   CALL astt321_filter_show('stbg004','b_stbg004')
   CALL astt321_filter_show('stbg005','b_stbg005')
   CALL astt321_filter_show('stbg006','b_stbg006')
   CALL astt321_filter_show('stbg007','b_stbg007')
   CALL astt321_filter_show('stbg008','b_stbg008')
   CALL astt321_filter_show('stbg009','b_stbg009')
   CALL astt321_filter_show('stbg010','b_stbg010')
   CALL astt321_filter_show('stbg011','b_stbg011')
   CALL astt321_filter_show('stbg012','b_stbg012')
   CALL astt321_filter_show('stbg013','b_stbg013')
   CALL astt321_filter_show('stbg014','b_stbg014')
   CALL astt321_filter_show('stbg015','b_stbg015')
   CALL astt321_filter_show('stbg016','b_stbg016')
   CALL astt321_filter_show('stbgsite','b_stbgsite')
 
    
   CALL astt321_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astt321.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astt321_filter_parser(ps_field)
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
 
{<section id="astt321.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astt321_filter_show(ps_field,ps_object)
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
   LET ls_condition = astt321_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astt321.insert" >}
#+ insert
PRIVATE FUNCTION astt321_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astt321.modify" >}
#+ modify
PRIVATE FUNCTION astt321_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt321.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astt321_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt321.delete" >}
#+ delete
PRIVATE FUNCTION astt321_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astt321.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astt321_detail_action_trans()
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
 
{<section id="astt321.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astt321_detail_index_setting()
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
            IF g_stbg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stbg_d.getLength() AND g_stbg_d.getLength() > 0
            LET g_detail_idx = g_stbg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stbg_d.getLength() THEN
               LET g_detail_idx = g_stbg_d.getLength()
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
 
{<section id="astt321.mask_functions" >}
 &include "erp/ast/astt321_mask.4gl"
 
{</section>}
 
{<section id="astt321.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取未結清的費用單資料
# Memo...........:
# Usage..........: CALL astt321_get_data()
# Date & Author..: 20150518 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION astt321_get_data()
DEFINE l_date_s      LIKE stbb_t.stbb006
DEFINE l_date_e      LIKE stbb_t.stbb006
DEFINE l_sql         STRING

   LET INT_FLAG = FALSE
   #畫面開啟 (identifier)
   OPEN WINDOW w_astt321_s01 WITH FORM cl_ap_formpath("ast","astt321_s01")
   
   CALL cl_ui_init()
   #輸入前處理
   #add-point:單頭前置處理
   INITIALIZE g_date_m.* TO NULL
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      INPUT BY NAME g_date_m.stbg001,g_date_m.stbg002 ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
            LET g_date_m.stbg001 = YEAR(g_today)
            LET g_date_m.stbg002 = MONTH(g_today)
         
         BEFORE FIELD stbg001
         
         AFTER FIELD stbg001
         
         ON CHANGE stbg001
         
         BEFORE FIELD stbg002
         
         AFTER FIELD stbg002
         
         ON CHANGE stbg002
         
         AFTER INPUT
         
      END INPUT
      
      #公用action
      ON ACTION accept_01
         ACCEPT DIALOG

      ON ACTION cancel_01
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION close
         LET INT_FLAG = TRUE
         EXIT DIALOG

      ON ACTION exit
         LET INT_FLAG = TRUE
         EXIT DIALOG

      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG

   #add-point:畫面關閉前
   IF INT_FLAG THEN
      INITIALIZE g_date_m.* TO NULL
   END IF
   #CALL cl_set_act_visible("accept,cancel", FALSE)
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_astt321_s01
   
   IF cl_null(g_date_m.stbg001) OR cl_null(g_date_m.stbg002) THEN
      RETURN
   END IF
   
   #日期區間
   CALL s_date_get_ymtodate(g_date_m.stbg001,g_date_m.stbg002,g_date_m.stbg001,g_date_m.stbg002) 
      RETURNING l_date_s,l_date_e
   #獲取費用單資料
   LET l_sql = " MERGE INTO stbg_t ",
               " USING (SELECT stbaunit,stbc004,stbc005,stbc002,stba010,stba002,stbc010,stbc011, ",
               "               stbc001,stbc012,stae003,stbc013,stbc014,stbb009,stbbsite,stbb012,stbb011 ",
               "          FROM stba_t,stbb_t,stbc_t,stae_t ",
               "         WHERE stbaent = stbbent AND stbbent = stbcent AND stbcent = staeent AND stbaent = ",g_enterprise," ",
               "           AND stbadocno = stbbdocno AND stbbdocno = stbc004 AND stbbseq = stbc005 ",
               "           AND stbc012 = stae001 AND stae005 = '2' ",
               "           AND stbc019 <> 0 ",
               "           AND stbb006 <= '",l_date_e,"') ",
               "    ON (stbgent = ",g_enterprise," AND stbgdocno = stbc004 AND stbgseq = stbc005) ",
               "  WHEN NOT MATCHED THEN ",
               "       INSERT (stbgent,stbgunit,stbgsite,stbgdocno,stbgseq,stbgstus,stbg001,stbg002, ",
               "                    stbg003,stbg004,stbg005,stbg006,stbg007,stbg008,stbg009,stbg010,stbg011, ",
               "                    stbg012,stbg013,stbg014,stbg015,stbg016) ",
               "          VALUES (",g_enterprise,",stbaunit,stbaunit,stbc004,stbc005,'1',",g_date_m.stbg001,",",g_date_m.stbg002,", ",
               "                  stbc002,stba010,stba002,stbc010,stbc011,stbc001,stbc012,stae003,stbc013, ",
               "                  stbc014,stbb009,stbbsite,stbb012,stbb011) ",
               "  WHEN MATCHED THEN ",
               "       UPDATE SET stbgunit = stbaunit,stbgsite = stbaunit,stbg003 = stbc002,stbg004 = stba010, ",
               "                  stbg005 = stba002,stbg006 = stbc010,stbg007 = stbc011,stbg008 = stbc001, ",
               "                  stbg009 = stbc012,stbg010 = stae003,stbg011 = stbc013,stbg012 = stbc014, ",
               "                  stbg013 = stbb009,stbg014 = stbbsite,stbg015 = stbb012,stbg016 = stbb011 "
   PREPARE ins_stbg_pre FROM l_sql
   EXECUTE ins_stbg_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      
      RETURN
   END IF

END FUNCTION

 
{</section>}
 
