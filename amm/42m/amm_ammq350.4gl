#該程式未解開Section, 採用最新樣板產出!
{<section id="ammq350.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-05-12 13:52:11), PR版次:0003(2015-05-12 16:29:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000140
#+ Filename...: ammq350
#+ Description: 會員卡儲值異動查詢作業
#+ Creator....: 02748(2014-02-14 15:50:10)
#+ Modifier...: 03247 -SD/PR- 03247
 
{</section>}
 
{<section id="ammq350.global" >}
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
PRIVATE TYPE type_g_mmau_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   mmau001 LIKE mmau_t.mmau001, 
   mmaq002 LIKE type_t.chr500, 
   mmaq002_desc LIKE type_t.chr500, 
   mmau002 LIKE mmau_t.mmau002, 
   mmau002_desc LIKE type_t.chr500, 
   mmau003 LIKE mmau_t.mmau003, 
   mmau004 LIKE mmau_t.mmau004, 
   mmau005 LIKE mmau_t.mmau005, 
   mmau018 LIKE mmau_t.mmau018, 
   mmau018_desc LIKE type_t.chr500, 
   mmau006 LIKE mmau_t.mmau006, 
   mmau007 LIKE mmau_t.mmau007, 
   mmau008 LIKE mmau_t.mmau008, 
   mmau009 LIKE mmau_t.mmau009, 
   mmau010 LIKE mmau_t.mmau010, 
   mmau011 LIKE mmau_t.mmau011, 
   mmau012 LIKE mmau_t.mmau012, 
   mmau013 LIKE mmau_t.mmau013, 
   mmau014 LIKE mmau_t.mmau014, 
   mmau015 LIKE mmau_t.mmau015, 
   mmau016 LIKE mmau_t.mmau016, 
   mmau017 LIKE mmau_t.mmau017, 
   mmau019 LIKE mmau_t.mmau019, 
   mmau019_desc LIKE type_t.chr500, 
   mmauseq LIKE mmau_t.mmauseq 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table2          STRING          #150204-00001#48--add by dongsz
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_mmau_d
DEFINE g_master_t                   type_g_mmau_d
DEFINE g_mmau_d          DYNAMIC ARRAY OF type_g_mmau_d
DEFINE g_mmau_d_t        type_g_mmau_d
 
      
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
 
{<section id="ammq350.main" >}
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
   CALL cl_ap_init("amm","")
 
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
   DECLARE ammq350_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ammq350_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ammq350_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ammq350 WITH FORM cl_ap_formpath("amm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ammq350_init()   
 
      #進入選單 Menu (="N")
      CALL ammq350_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ammq350
      
   END IF 
   
   CLOSE ammq350_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ammq350.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION ammq350_init()
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
   
      CALL cl_set_combo_scc('b_mmau003','6512') 
   CALL cl_set_combo_scc('b_mmau004','6514') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc("b_mmau003",6512) 
   CALL cl_set_combo_scc("b_mmau004",6514)
   #end add-point
 
   CALL ammq350_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="ammq350.default_search" >}
PRIVATE FUNCTION ammq350_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " mmau001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " mmau004 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " mmau005 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " mmauseq = '", g_argv[04], "' AND "
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
 
{<section id="ammq350.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION ammq350_ui_dialog()
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
      CALL ammq350_b_fill()
   ELSE
      CALL ammq350_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_mmau_d.clear()
 
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
 
         CALL ammq350_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_mmau_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ammq350_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL ammq350_detail_action_trans()
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
            CALL ammq350_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
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
               CALL ammq350_query()
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
            CALL ammq350_filter()
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
            CALL ammq350_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_mmau_d)
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
            CALL ammq350_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ammq350_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ammq350_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ammq350_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_mmau_d.getLength()
               LET g_mmau_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_mmau_d.getLength()
               LET g_mmau_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_mmau_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmau_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_mmau_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmau_d[li_idx].sel = "N"
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
 
{<section id="ammq350.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION ammq350_query()
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
   CALL g_mmau_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON mmau001,mmau002,mmau003,mmau004,mmau005,mmau018,mmau006,mmau007,mmau008, 
          mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017,mmau019,mmauseq
           FROM s_detail1[1].b_mmau001,s_detail1[1].b_mmau002,s_detail1[1].b_mmau003,s_detail1[1].b_mmau004, 
               s_detail1[1].b_mmau005,s_detail1[1].b_mmau018,s_detail1[1].b_mmau006,s_detail1[1].b_mmau007, 
               s_detail1[1].b_mmau008,s_detail1[1].b_mmau009,s_detail1[1].b_mmau010,s_detail1[1].b_mmau011, 
               s_detail1[1].b_mmau012,s_detail1[1].b_mmau013,s_detail1[1].b_mmau014,s_detail1[1].b_mmau015, 
               s_detail1[1].b_mmau016,s_detail1[1].b_mmau017,s_detail1[1].b_mmau019,s_detail1[1].b_mmauseq 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_mmau001>>----
         #Ctrlp:construct.c.page1.b_mmau001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau001
            #add-point:ON ACTION controlp INFIELD b_mmau001 name="construct.c.page1.b_mmau001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau001  #顯示到畫面上

            NEXT FIELD b_mmau001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau001
            #add-point:BEFORE FIELD b_mmau001 name="construct.b.page1.b_mmau001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau001
            
            #add-point:AFTER FIELD b_mmau001 name="construct.a.page1.b_mmau001"
            
            #END add-point
            
 
 
         #----<<b_mmaq002>>----
         #----<<b_mmaq002_desc>>----
         #----<<b_mmau002>>----
         #Ctrlp:construct.c.page1.b_mmau002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau002
            #add-point:ON ACTION controlp INFIELD b_mmau002 name="construct.c.page1.b_mmau002"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau002  #顯示到畫面上

            NEXT FIELD b_mmau002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau002
            #add-point:BEFORE FIELD b_mmau002 name="construct.b.page1.b_mmau002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau002
            
            #add-point:AFTER FIELD b_mmau002 name="construct.a.page1.b_mmau002"
            
            #END add-point
            
 
 
         #----<<b_mmau002_desc>>----
         #----<<b_mmau003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau003
            #add-point:BEFORE FIELD b_mmau003 name="construct.b.page1.b_mmau003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau003
            
            #add-point:AFTER FIELD b_mmau003 name="construct.a.page1.b_mmau003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau003
            #add-point:ON ACTION controlp INFIELD b_mmau003 name="construct.c.page1.b_mmau003"
            
            #END add-point
 
 
         #----<<b_mmau004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau004
            #add-point:BEFORE FIELD b_mmau004 name="construct.b.page1.b_mmau004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau004
            
            #add-point:AFTER FIELD b_mmau004 name="construct.a.page1.b_mmau004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau004
            #add-point:ON ACTION controlp INFIELD b_mmau004 name="construct.c.page1.b_mmau004"
            
            #END add-point
 
 
         #----<<b_mmau005>>----
         #Ctrlp:construct.c.page1.b_mmau005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau005
            #add-point:ON ACTION controlp INFIELD b_mmau005 name="construct.c.page1.b_mmau005"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mmau005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau005  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO mmau006 #異動日期 

            NEXT FIELD b_mmau005                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau005
            #add-point:BEFORE FIELD b_mmau005 name="construct.b.page1.b_mmau005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau005
            
            #add-point:AFTER FIELD b_mmau005 name="construct.a.page1.b_mmau005"
            
            #END add-point
            
 
 
         #----<<b_mmau018>>----
         #Ctrlp:construct.c.page1.b_mmau018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau018
            #add-point:ON ACTION controlp INFIELD b_mmau018 name="construct.c.page1.b_mmau018"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   #150309-00041#1 150320 By pomelo add(S)
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '9'
            #150309-00041#1 150320 By pomelo add(E)
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau018  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD b_mmau018                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau018
            #add-point:BEFORE FIELD b_mmau018 name="construct.b.page1.b_mmau018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau018
            
            #add-point:AFTER FIELD b_mmau018 name="construct.a.page1.b_mmau018"
            
            #END add-point
            
 
 
         #----<<b_mmau018_desc>>----
         #----<<b_mmau006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau006
            #add-point:BEFORE FIELD b_mmau006 name="construct.b.page1.b_mmau006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau006
            
            #add-point:AFTER FIELD b_mmau006 name="construct.a.page1.b_mmau006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau006
            #add-point:ON ACTION controlp INFIELD b_mmau006 name="construct.c.page1.b_mmau006"
            
            #END add-point
 
 
         #----<<b_mmau007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau007
            #add-point:BEFORE FIELD b_mmau007 name="construct.b.page1.b_mmau007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau007
            
            #add-point:AFTER FIELD b_mmau007 name="construct.a.page1.b_mmau007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau007
            #add-point:ON ACTION controlp INFIELD b_mmau007 name="construct.c.page1.b_mmau007"
            
            #END add-point
 
 
         #----<<b_mmau008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau008
            #add-point:BEFORE FIELD b_mmau008 name="construct.b.page1.b_mmau008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau008
            
            #add-point:AFTER FIELD b_mmau008 name="construct.a.page1.b_mmau008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau008
            #add-point:ON ACTION controlp INFIELD b_mmau008 name="construct.c.page1.b_mmau008"
            
            #END add-point
 
 
         #----<<b_mmau009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau009
            #add-point:BEFORE FIELD b_mmau009 name="construct.b.page1.b_mmau009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau009
            
            #add-point:AFTER FIELD b_mmau009 name="construct.a.page1.b_mmau009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau009
            #add-point:ON ACTION controlp INFIELD b_mmau009 name="construct.c.page1.b_mmau009"
            
            #END add-point
 
 
         #----<<b_mmau010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau010
            #add-point:BEFORE FIELD b_mmau010 name="construct.b.page1.b_mmau010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau010
            
            #add-point:AFTER FIELD b_mmau010 name="construct.a.page1.b_mmau010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau010
            #add-point:ON ACTION controlp INFIELD b_mmau010 name="construct.c.page1.b_mmau010"
            
            #END add-point
 
 
         #----<<b_mmau011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau011
            #add-point:BEFORE FIELD b_mmau011 name="construct.b.page1.b_mmau011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau011
            
            #add-point:AFTER FIELD b_mmau011 name="construct.a.page1.b_mmau011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau011
            #add-point:ON ACTION controlp INFIELD b_mmau011 name="construct.c.page1.b_mmau011"
            
            #END add-point
 
 
         #----<<b_mmau012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau012
            #add-point:BEFORE FIELD b_mmau012 name="construct.b.page1.b_mmau012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau012
            
            #add-point:AFTER FIELD b_mmau012 name="construct.a.page1.b_mmau012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau012
            #add-point:ON ACTION controlp INFIELD b_mmau012 name="construct.c.page1.b_mmau012"
            
            #END add-point
 
 
         #----<<b_mmau013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau013
            #add-point:BEFORE FIELD b_mmau013 name="construct.b.page1.b_mmau013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau013
            
            #add-point:AFTER FIELD b_mmau013 name="construct.a.page1.b_mmau013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau013
            #add-point:ON ACTION controlp INFIELD b_mmau013 name="construct.c.page1.b_mmau013"
            
            #END add-point
 
 
         #----<<b_mmau014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau014
            #add-point:BEFORE FIELD b_mmau014 name="construct.b.page1.b_mmau014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau014
            
            #add-point:AFTER FIELD b_mmau014 name="construct.a.page1.b_mmau014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau014
            #add-point:ON ACTION controlp INFIELD b_mmau014 name="construct.c.page1.b_mmau014"
            
            #END add-point
 
 
         #----<<b_mmau015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau015
            #add-point:BEFORE FIELD b_mmau015 name="construct.b.page1.b_mmau015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau015
            
            #add-point:AFTER FIELD b_mmau015 name="construct.a.page1.b_mmau015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau015
            #add-point:ON ACTION controlp INFIELD b_mmau015 name="construct.c.page1.b_mmau015"
            
            #END add-point
 
 
         #----<<b_mmau016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau016
            #add-point:BEFORE FIELD b_mmau016 name="construct.b.page1.b_mmau016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau016
            
            #add-point:AFTER FIELD b_mmau016 name="construct.a.page1.b_mmau016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau016
            #add-point:ON ACTION controlp INFIELD b_mmau016 name="construct.c.page1.b_mmau016"
            
            #END add-point
 
 
         #----<<b_mmau017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau017
            #add-point:BEFORE FIELD b_mmau017 name="construct.b.page1.b_mmau017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau017
            
            #add-point:AFTER FIELD b_mmau017 name="construct.a.page1.b_mmau017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmau017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau017
            #add-point:ON ACTION controlp INFIELD b_mmau017 name="construct.c.page1.b_mmau017"
 
            #END add-point
 
 
         #----<<b_mmau019>>----
         #Ctrlp:construct.c.page1.b_mmau019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau019
            #add-point:ON ACTION controlp INFIELD b_mmau019 name="construct.c.page1.b_mmau019"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = g_site
		   	LET g_qryparam.arg2 = '2'
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau019  #顯示到畫面上
            NEXT FIELD b_mmau019                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmau019
            #add-point:BEFORE FIELD b_mmau019 name="construct.b.page1.b_mmau019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmau019
            
            #add-point:AFTER FIELD b_mmau019 name="construct.a.page1.b_mmau019"
            
            #END add-point
            
 
 
         #----<<b_mmau019_desc>>----
         #----<<b_mmauseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_mmauseq
            #add-point:BEFORE FIELD b_mmauseq name="construct.b.page1.b_mmauseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_mmauseq
            
            #add-point:AFTER FIELD b_mmauseq name="construct.a.page1.b_mmauseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_mmauseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmauseq
            #add-point:ON ACTION controlp INFIELD b_mmauseq name="construct.c.page1.b_mmauseq"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_table2 ON mmaq002
           FROM s_detail1[1].b_mmaq002
           
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD b_mmaq002
            #add-point:ON ACTION controlp INFIELD b_mmau001
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmaq002  #顯示到畫面上

            NEXT FIELD b_mmaq002                     #返回原欄位
            
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
 
   #end add-point
        
   LET g_error_show = 1
   CALL ammq350_b_fill()
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
 
{<section id="ammq350.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ammq350_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_wc = cl_replace_str(g_wc,"mmau006","TRUNC(mmau006)")
   LET g_wc_filter = cl_replace_str(g_wc_filter,"mmau006","TRUNC(mmau006)")
   #150204-00001#48--add by dongsz--str---
   IF cl_null(g_wc_table2) THEN
      LET g_wc_table2 = " 1=1 "
   END IF
   #150204-00001#48--add by dongsz--end---
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',mmau001,'','',mmau002,'',mmau003,mmau004,mmau005,mmau018,'', 
       mmau006,mmau007,mmau008,mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017, 
       mmau019,'',mmauseq  ,DENSE_RANK() OVER( ORDER BY mmau_t.mmau001,mmau_t.mmau004,mmau_t.mmau005, 
       mmau_t.mmauseq) AS RANK FROM mmau_t",
 
 
                     "",
                     " WHERE mmauent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("mmau_t"),
                     " ORDER BY mmau_t.mmau001,mmau_t.mmau004,mmau_t.mmau005,mmau_t.mmauseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150204-00001#48--add by dongsz--str---
   LET ls_sql_rank = "SELECT  UNIQUE '',mmau001,mmaq002,mmanl003,mmau002,'',mmau003,mmau004,mmau005,mmau018,'', 
       mmau006,mmau007,mmau008,mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017, 
       mmau019,'',mmauseq  ,DENSE_RANK() OVER( ORDER BY mmau_t.mmau001,mmau_t.mmau004,mmau_t.mmau005, 
       mmau_t.mmauseq) AS RANK FROM mmau_t,mmaq_t ",
 
 
                     " LEFT JOIN mmanl_t ON mmaqent = mmanlent AND mmaq002 = mmanl001 AND mmanl002 = '",g_dlang,"' ",
                     " WHERE mmauent= ? AND 1=1 AND ", ls_wc,
                     "   AND mmauent = mmaqent AND mmau001 = mmaq001 AND ",g_wc_table2
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("mmau_t"),
                     " ORDER BY mmau_t.mmau001,mmau_t.mmau004,mmau_t.mmau005,mmau_t.mmauseq"
   #150204-00001#48--add by dongsz--end---
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
 
   LET g_sql = "SELECT '',mmau001,'','',mmau002,'',mmau003,mmau004,mmau005,mmau018,'',mmau006,mmau007, 
       mmau008,mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017,mmau019,'',mmauseq", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150204-00001#48--add by dongsz--str---
   LET g_sql = "SELECT '',mmau001,mmaq002,mmanl003,mmau002,'',mmau003,mmau004,mmau005,mmau018,'',mmau006,mmau007, 
       mmau008,mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017,mmau019,'',mmauseq", 

               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150204-00001#48--add by dongsz--end---
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ammq350_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ammq350_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_mmau_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_mmau_d[l_ac].sel,g_mmau_d[l_ac].mmau001,g_mmau_d[l_ac].mmaq002,g_mmau_d[l_ac].mmaq002_desc, 
       g_mmau_d[l_ac].mmau002,g_mmau_d[l_ac].mmau002_desc,g_mmau_d[l_ac].mmau003,g_mmau_d[l_ac].mmau004, 
       g_mmau_d[l_ac].mmau005,g_mmau_d[l_ac].mmau018,g_mmau_d[l_ac].mmau018_desc,g_mmau_d[l_ac].mmau006, 
       g_mmau_d[l_ac].mmau007,g_mmau_d[l_ac].mmau008,g_mmau_d[l_ac].mmau009,g_mmau_d[l_ac].mmau010,g_mmau_d[l_ac].mmau011, 
       g_mmau_d[l_ac].mmau012,g_mmau_d[l_ac].mmau013,g_mmau_d[l_ac].mmau014,g_mmau_d[l_ac].mmau015,g_mmau_d[l_ac].mmau016, 
       g_mmau_d[l_ac].mmau017,g_mmau_d[l_ac].mmau019,g_mmau_d[l_ac].mmau019_desc,g_mmau_d[l_ac].mmauseq 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_mmau_d[l_ac].statepic = cl_get_actipic(g_mmau_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_mmau_d[l_ac].sel = 'N'             #150204-00001#48--add by dongsz
      #end add-point
 
      CALL ammq350_detail_show("'1'")      
 
      CALL ammq350_mmau_t_mask()
 
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
   
 
   
   CALL g_mmau_d.deleteElement(g_mmau_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_mmau_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE ammq350_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ammq350_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ammq350_detail_action_trans()
 
   IF g_mmau_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL ammq350_fetch()
   END IF
   
      CALL ammq350_filter_show('mmau001','b_mmau001')
   CALL ammq350_filter_show('mmau002','b_mmau002')
   CALL ammq350_filter_show('mmau003','b_mmau003')
   CALL ammq350_filter_show('mmau004','b_mmau004')
   CALL ammq350_filter_show('mmau005','b_mmau005')
   CALL ammq350_filter_show('mmau018','b_mmau018')
   CALL ammq350_filter_show('mmau006','b_mmau006')
   CALL ammq350_filter_show('mmau007','b_mmau007')
   CALL ammq350_filter_show('mmau008','b_mmau008')
   CALL ammq350_filter_show('mmau009','b_mmau009')
   CALL ammq350_filter_show('mmau010','b_mmau010')
   CALL ammq350_filter_show('mmau011','b_mmau011')
   CALL ammq350_filter_show('mmau012','b_mmau012')
   CALL ammq350_filter_show('mmau013','b_mmau013')
   CALL ammq350_filter_show('mmau014','b_mmau014')
   CALL ammq350_filter_show('mmau015','b_mmau015')
   CALL ammq350_filter_show('mmau016','b_mmau016')
   CALL ammq350_filter_show('mmau017','b_mmau017')
   CALL ammq350_filter_show('mmau019','b_mmau019')
   CALL ammq350_filter_show('mmauseq','b_mmauseq')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ammq350_fetch()
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
 
{<section id="ammq350.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ammq350_detail_show(ps_page)
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
            CALL ammq350_mmau018_ref()
            CALL ammq350_mmau002_ref()
            CALL ammq350_mmau019_ref()      #150204-00001#48--add by dongsz
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION ammq350_filter()
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
      CONSTRUCT g_wc_filter ON mmau001,mmau002,mmau003,mmau004,mmau005,mmau018,mmau006,mmau007,mmau008, 
          mmau009,mmau010,mmau011,mmau012,mmau013,mmau014,mmau015,mmau016,mmau017,mmau019,mmauseq
                          FROM s_detail1[1].b_mmau001,s_detail1[1].b_mmau002,s_detail1[1].b_mmau003, 
                              s_detail1[1].b_mmau004,s_detail1[1].b_mmau005,s_detail1[1].b_mmau018,s_detail1[1].b_mmau006, 
                              s_detail1[1].b_mmau007,s_detail1[1].b_mmau008,s_detail1[1].b_mmau009,s_detail1[1].b_mmau010, 
                              s_detail1[1].b_mmau011,s_detail1[1].b_mmau012,s_detail1[1].b_mmau013,s_detail1[1].b_mmau014, 
                              s_detail1[1].b_mmau015,s_detail1[1].b_mmau016,s_detail1[1].b_mmau017,s_detail1[1].b_mmau019, 
                              s_detail1[1].b_mmauseq
 
         BEFORE CONSTRUCT
                     DISPLAY ammq350_filter_parser('mmau001') TO s_detail1[1].b_mmau001
            DISPLAY ammq350_filter_parser('mmau002') TO s_detail1[1].b_mmau002
            DISPLAY ammq350_filter_parser('mmau003') TO s_detail1[1].b_mmau003
            DISPLAY ammq350_filter_parser('mmau004') TO s_detail1[1].b_mmau004
            DISPLAY ammq350_filter_parser('mmau005') TO s_detail1[1].b_mmau005
            DISPLAY ammq350_filter_parser('mmau018') TO s_detail1[1].b_mmau018
            DISPLAY ammq350_filter_parser('mmau006') TO s_detail1[1].b_mmau006
            DISPLAY ammq350_filter_parser('mmau007') TO s_detail1[1].b_mmau007
            DISPLAY ammq350_filter_parser('mmau008') TO s_detail1[1].b_mmau008
            DISPLAY ammq350_filter_parser('mmau009') TO s_detail1[1].b_mmau009
            DISPLAY ammq350_filter_parser('mmau010') TO s_detail1[1].b_mmau010
            DISPLAY ammq350_filter_parser('mmau011') TO s_detail1[1].b_mmau011
            DISPLAY ammq350_filter_parser('mmau012') TO s_detail1[1].b_mmau012
            DISPLAY ammq350_filter_parser('mmau013') TO s_detail1[1].b_mmau013
            DISPLAY ammq350_filter_parser('mmau014') TO s_detail1[1].b_mmau014
            DISPLAY ammq350_filter_parser('mmau015') TO s_detail1[1].b_mmau015
            DISPLAY ammq350_filter_parser('mmau016') TO s_detail1[1].b_mmau016
            DISPLAY ammq350_filter_parser('mmau017') TO s_detail1[1].b_mmau017
            DISPLAY ammq350_filter_parser('mmau019') TO s_detail1[1].b_mmau019
            DISPLAY ammq350_filter_parser('mmauseq') TO s_detail1[1].b_mmauseq
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_mmau001>>----
         #Ctrlp:construct.c.page1.b_mmau001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau001
            #add-point:ON ACTION controlp INFIELD b_mmau001 name="construct.c.filter.page1.b_mmau001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau001  #顯示到畫面上
            NEXT FIELD b_mmau001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmaq002>>----
         #----<<b_mmaq002_desc>>----
         #----<<b_mmau002>>----
         #Ctrlp:construct.c.page1.b_mmau002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau002
            #add-point:ON ACTION controlp INFIELD b_mmau002 name="construct.c.filter.page1.b_mmau002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau002  #顯示到畫面上
            NEXT FIELD b_mmau002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmau002_desc>>----
         #----<<b_mmau003>>----
         #Ctrlp:construct.c.filter.page1.b_mmau003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau003
            #add-point:ON ACTION controlp INFIELD b_mmau003 name="construct.c.filter.page1.b_mmau003"
            
            #END add-point
 
 
         #----<<b_mmau004>>----
         #Ctrlp:construct.c.filter.page1.b_mmau004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau004
            #add-point:ON ACTION controlp INFIELD b_mmau004 name="construct.c.filter.page1.b_mmau004"
            
            #END add-point
 
 
         #----<<b_mmau005>>----
         #Ctrlp:construct.c.page1.b_mmau005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau005
            #add-point:ON ACTION controlp INFIELD b_mmau005 name="construct.c.filter.page1.b_mmau005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmau005()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau005  #顯示到畫面上
            NEXT FIELD b_mmau005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmau018>>----
         #Ctrlp:construct.c.page1.b_mmau018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau018
            #add-point:ON ACTION controlp INFIELD b_mmau018 name="construct.c.filter.page1.b_mmau018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #150309-00041#1 150320 By pomelo add(S)
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = '9'
            #150309-00041#1 150320 By pomelo add(E)
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau018  #顯示到畫面上
            NEXT FIELD b_mmau018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmau018_desc>>----
         #----<<b_mmau006>>----
         #Ctrlp:construct.c.filter.page1.b_mmau006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau006
            #add-point:ON ACTION controlp INFIELD b_mmau006 name="construct.c.filter.page1.b_mmau006"
            
            #END add-point
 
 
         #----<<b_mmau007>>----
         #Ctrlp:construct.c.filter.page1.b_mmau007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau007
            #add-point:ON ACTION controlp INFIELD b_mmau007 name="construct.c.filter.page1.b_mmau007"
            
            #END add-point
 
 
         #----<<b_mmau008>>----
         #Ctrlp:construct.c.filter.page1.b_mmau008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau008
            #add-point:ON ACTION controlp INFIELD b_mmau008 name="construct.c.filter.page1.b_mmau008"
            
            #END add-point
 
 
         #----<<b_mmau009>>----
         #Ctrlp:construct.c.filter.page1.b_mmau009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau009
            #add-point:ON ACTION controlp INFIELD b_mmau009 name="construct.c.filter.page1.b_mmau009"
            
            #END add-point
 
 
         #----<<b_mmau010>>----
         #Ctrlp:construct.c.filter.page1.b_mmau010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau010
            #add-point:ON ACTION controlp INFIELD b_mmau010 name="construct.c.filter.page1.b_mmau010"
            
            #END add-point
 
 
         #----<<b_mmau011>>----
         #Ctrlp:construct.c.filter.page1.b_mmau011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau011
            #add-point:ON ACTION controlp INFIELD b_mmau011 name="construct.c.filter.page1.b_mmau011"
            
            #END add-point
 
 
         #----<<b_mmau012>>----
         #Ctrlp:construct.c.filter.page1.b_mmau012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau012
            #add-point:ON ACTION controlp INFIELD b_mmau012 name="construct.c.filter.page1.b_mmau012"
            
            #END add-point
 
 
         #----<<b_mmau013>>----
         #Ctrlp:construct.c.filter.page1.b_mmau013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau013
            #add-point:ON ACTION controlp INFIELD b_mmau013 name="construct.c.filter.page1.b_mmau013"
            
            #END add-point
 
 
         #----<<b_mmau014>>----
         #Ctrlp:construct.c.filter.page1.b_mmau014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau014
            #add-point:ON ACTION controlp INFIELD b_mmau014 name="construct.c.filter.page1.b_mmau014"
            
            #END add-point
 
 
         #----<<b_mmau015>>----
         #Ctrlp:construct.c.filter.page1.b_mmau015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau015
            #add-point:ON ACTION controlp INFIELD b_mmau015 name="construct.c.filter.page1.b_mmau015"
            
            #END add-point
 
 
         #----<<b_mmau016>>----
         #Ctrlp:construct.c.filter.page1.b_mmau016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau016
            #add-point:ON ACTION controlp INFIELD b_mmau016 name="construct.c.filter.page1.b_mmau016"
            
            #END add-point
 
 
         #----<<b_mmau017>>----
         #Ctrlp:construct.c.filter.page1.b_mmau017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau017
            #add-point:ON ACTION controlp INFIELD b_mmau017 name="construct.c.filter.page1.b_mmau017"
            
            #END add-point
 
 
         #----<<b_mmau019>>----
         #Ctrlp:construct.c.page1.b_mmau019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmau019
            #add-point:ON ACTION controlp INFIELD b_mmau019 name="construct.c.filter.page1.b_mmau019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmau019  #顯示到畫面上
            NEXT FIELD b_mmau019                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmau019_desc>>----
         #----<<b_mmauseq>>----
         #Ctrlp:construct.c.filter.page1.b_mmauseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmauseq
            #add-point:ON ACTION controlp INFIELD b_mmauseq name="construct.c.filter.page1.b_mmauseq"
            
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
   
      CALL ammq350_filter_show('mmau001','b_mmau001')
   CALL ammq350_filter_show('mmau002','b_mmau002')
   CALL ammq350_filter_show('mmau003','b_mmau003')
   CALL ammq350_filter_show('mmau004','b_mmau004')
   CALL ammq350_filter_show('mmau005','b_mmau005')
   CALL ammq350_filter_show('mmau018','b_mmau018')
   CALL ammq350_filter_show('mmau006','b_mmau006')
   CALL ammq350_filter_show('mmau007','b_mmau007')
   CALL ammq350_filter_show('mmau008','b_mmau008')
   CALL ammq350_filter_show('mmau009','b_mmau009')
   CALL ammq350_filter_show('mmau010','b_mmau010')
   CALL ammq350_filter_show('mmau011','b_mmau011')
   CALL ammq350_filter_show('mmau012','b_mmau012')
   CALL ammq350_filter_show('mmau013','b_mmau013')
   CALL ammq350_filter_show('mmau014','b_mmau014')
   CALL ammq350_filter_show('mmau015','b_mmau015')
   CALL ammq350_filter_show('mmau016','b_mmau016')
   CALL ammq350_filter_show('mmau017','b_mmau017')
   CALL ammq350_filter_show('mmau019','b_mmau019')
   CALL ammq350_filter_show('mmauseq','b_mmauseq')
 
    
   CALL ammq350_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION ammq350_filter_parser(ps_field)
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
 
{<section id="ammq350.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION ammq350_filter_show(ps_field,ps_object)
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
   LET ls_condition = ammq350_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.insert" >}
#+ insert
PRIVATE FUNCTION ammq350_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="ammq350.modify" >}
#+ modify
PRIVATE FUNCTION ammq350_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.reproduce" >}
#+ reproduce
PRIVATE FUNCTION ammq350_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.delete" >}
#+ delete
PRIVATE FUNCTION ammq350_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="ammq350.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ammq350_detail_action_trans()
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
 
{<section id="ammq350.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ammq350_detail_index_setting()
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
            IF g_mmau_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_mmau_d.getLength() AND g_mmau_d.getLength() > 0
            LET g_detail_idx = g_mmau_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_mmau_d.getLength() THEN
               LET g_detail_idx = g_mmau_d.getLength()
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
 
{<section id="ammq350.mask_functions" >}
 &include "erp/amm/ammq350_mask.4gl"
 
{</section>}
 
{<section id="ammq350.other_function" readonly="Y" >}

PUBLIC FUNCTION ammq350_mmau018_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmau_d[l_ac].mmau018
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_mmau_d[l_ac].mmau018_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmau_d[l_ac].mmau018_desc
END FUNCTION

PUBLIC FUNCTION ammq350_mmau002_ref()
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmau_d[l_ac].mmau002
            CALL ap_ref_array2(g_ref_fields,"SELECT mmaf008 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? ","") RETURNING g_rtn_fields
            LET g_mmau_d[l_ac].mmau002_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_mmau_d[l_ac].mmau002_desc
END FUNCTION

################################################################################
# Date & Author..: 20150512 By dongsz #150204-00001#48
# Modify.........:
################################################################################
PRIVATE FUNCTION ammq350_mmau019_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_mmau_d[l_ac].mmau019
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_mmau_d[l_ac].mmau019_desc = g_rtn_fields[1]
   DISPLAY BY NAME g_mmau_d[l_ac].mmau019_desc
END FUNCTION

 
{</section>}
 