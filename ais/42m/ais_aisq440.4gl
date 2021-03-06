#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq440.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-06-22 08:30:11), PR版次:0003(2016-11-10 14:14:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000034
#+ Filename...: aisq440
#+ Description: 進項明細查詢
#+ Creator....: 06816(2015-06-18 14:19:18)
#+ Modifier...: 06816 -SD/PR- 08171
 
{</section>}
 
{<section id="aisq440.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160905-00002#4    2016/09/05 By 06821  補入WHERE條件漏掉ENT的部分
#161108-00017#6    2016/11/10 By 08171  程式中INSERT時不可以用*的寫法，要一個一個欄位定義
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
PRIVATE TYPE type_g_isaj_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isaj018 LIKE isaj_t.isaj018, 
   isaj006 LIKE isaj_t.isaj006, 
   isaj008 LIKE isaj_t.isaj008, 
   isaj014 LIKE isaj_t.isaj014, 
   isaj009 LIKE isaj_t.isaj009, 
   isaj103 LIKE isaj_t.isaj103, 
   isaj104 LIKE isaj_t.isaj104, 
   isaj105 LIKE isaj_t.isaj105, 
   isaj015 LIKE isaj_t.isaj015, 
   isaj017 LIKE isaj_t.isaj017, 
   isaj010 LIKE isaj_t.isaj010, 
   isaj001 LIKE isaj_t.isaj001, 
   isaj003 LIKE isaj_t.isaj003, 
   isaj003_desc LIKE type_t.chr500, 
   isaj005 LIKE isaj_t.isaj005, 
   isaj007 LIKE isaj_t.isaj007, 
   isaj019 LIKE isaj_t.isaj019, 
   isaj020 LIKE isaj_t.isaj020, 
   isajcomp LIKE isaj_t.isajcomp 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input     RECORD
   isaj003         LIKE isaj_t.isaj003,
   l_isaj003_desc  LIKE ooefl_t.ooefl003,
   isajcomp        LIKE isaj_t.isajcomp,
   l_isajcomp_desc LIKE ooefl_t.ooefl003,
   isaj019         LIKE isaj_t.isaj019,
   isaj020         LIKE isaj_t.isaj020
                   END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isaj_d
DEFINE g_master_t                   type_g_isaj_d
DEFINE g_isaj_d          DYNAMIC ARRAY OF type_g_isaj_d
DEFINE g_isaj_d_t        type_g_isaj_d
 
      
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
 
{<section id="aisq440.main" >}
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
   CALL cl_ap_init("ais","")
 
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
   DECLARE aisq440_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq440_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq440_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq440 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq440_init()   
 
      #進入選單 Menu (="N")
      CALL aisq440_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq440
      
   END IF 
   
   CLOSE aisq440_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq440.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq440_init()
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
   
      CALL cl_set_combo_scc('b_isaj014','9719') 
   CALL cl_set_combo_scc('b_isaj015','9708') 
   CALL cl_set_combo_scc('b_isaj001','9720') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_isaj014','9719') 
   CALL cl_set_combo_scc('b_isaj015','9708') 
   CALL cl_set_combo_scc('b_isaj001','9720') 
   CALL aisq440_default()
   CALL aisq440_x01_tmp()
   #end add-point
 
   CALL aisq440_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq440.default_search" >}
PRIVATE FUNCTION aisq440_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isajcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isaj001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " isaj003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " isaj005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " isaj006 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " isaj007 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " isaj019 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " isaj020 = '", g_argv[08], "' AND "
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
 
{<section id="aisq440.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq440_ui_dialog()
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
      CALL aisq440_b_fill()
   ELSE
      CALL aisq440_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isaj_d.clear()
 
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
 
         CALL aisq440_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isaj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq440_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq440_detail_action_trans()
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
            CALL aisq440_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aisq440_insert_tmp()
               CALL aisq440_x01(" 1 = 1","aisq440_x01_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aisq440_insert_tmp()
               CALL aisq440_x01(" 1 = 1","aisq440_x01_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq440_query()
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
            CALL aisq440_filter()
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
            CALL aisq440_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isaj_d)
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
            CALL aisq440_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq440_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq440_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq440_b_fill()
 
         
         
 
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
 
{<section id="aisq440.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq440_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_isaa007  LIKE isaa_t.isaa007
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_ooef019  LIKE ooef_t.ooef019
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isaj_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105,isaj015, 
          isaj017,isaj010,isaj001,isaj003,isaj005,isaj007,isaj019,isaj020,isajcomp
           FROM s_detail1[1].b_isaj018,s_detail1[1].b_isaj006,s_detail1[1].b_isaj008,s_detail1[1].b_isaj014, 
               s_detail1[1].b_isaj009,s_detail1[1].b_isaj103,s_detail1[1].b_isaj104,s_detail1[1].b_isaj105, 
               s_detail1[1].b_isaj015,s_detail1[1].b_isaj017,s_detail1[1].b_isaj010,s_detail1[1].b_isaj001, 
               s_detail1[1].b_isaj003,s_detail1[1].b_isaj005,s_detail1[1].b_isaj007,s_detail1[1].b_isaj019, 
               s_detail1[1].b_isaj020,s_detail1[1].b_isajcomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_isaj018>>----
         #Ctrlp:construct.c.page1.b_isaj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj018
            #add-point:ON ACTION controlp INFIELD b_isaj018 name="construct.c.page1.b_isaj018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             #WHERE ooef001 = g_input.isaj003 AND ooef017 = g_input.isajcomp                            #160905-00002#4 mark
             WHERE ooefent = g_enterprise AND ooef001 = g_input.isaj003 AND ooef017 = g_input.isajcomp  #160905-00002#4 add
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "isap001 = '",l_ooef019 CLIPPED,"' "
            CALL q_isap002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaj018  #顯示到畫面上
            NEXT FIELD b_isaj018                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj018
            #add-point:BEFORE FIELD b_isaj018 name="construct.b.page1.b_isaj018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj018
            
            #add-point:AFTER FIELD b_isaj018 name="construct.a.page1.b_isaj018"
            
            #END add-point
            
 
 
         #----<<b_isaj006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj006
            #add-point:BEFORE FIELD b_isaj006 name="construct.b.page1.b_isaj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj006
            
            #add-point:AFTER FIELD b_isaj006 name="construct.a.page1.b_isaj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj006
            #add-point:ON ACTION controlp INFIELD b_isaj006 name="construct.c.page1.b_isaj006"
            
            #END add-point
 
 
         #----<<b_isaj008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj008
            #add-point:BEFORE FIELD b_isaj008 name="construct.b.page1.b_isaj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj008
            
            #add-point:AFTER FIELD b_isaj008 name="construct.a.page1.b_isaj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj008
            #add-point:ON ACTION controlp INFIELD b_isaj008 name="construct.c.page1.b_isaj008"
            
            #END add-point
 
 
         #----<<b_isaj014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj014
            #add-point:BEFORE FIELD b_isaj014 name="construct.b.page1.b_isaj014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj014
            
            #add-point:AFTER FIELD b_isaj014 name="construct.a.page1.b_isaj014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj014
            #add-point:ON ACTION controlp INFIELD b_isaj014 name="construct.c.page1.b_isaj014"
            
            #END add-point
 
 
         #----<<b_isaj009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj009
            #add-point:BEFORE FIELD b_isaj009 name="construct.b.page1.b_isaj009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj009
            
            #add-point:AFTER FIELD b_isaj009 name="construct.a.page1.b_isaj009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj009
            #add-point:ON ACTION controlp INFIELD b_isaj009 name="construct.c.page1.b_isaj009"
            
            #END add-point
 
 
         #----<<b_isaj103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj103
            #add-point:BEFORE FIELD b_isaj103 name="construct.b.page1.b_isaj103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj103
            
            #add-point:AFTER FIELD b_isaj103 name="construct.a.page1.b_isaj103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj103
            #add-point:ON ACTION controlp INFIELD b_isaj103 name="construct.c.page1.b_isaj103"
            
            #END add-point
 
 
         #----<<b_isaj104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj104
            #add-point:BEFORE FIELD b_isaj104 name="construct.b.page1.b_isaj104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj104
            
            #add-point:AFTER FIELD b_isaj104 name="construct.a.page1.b_isaj104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj104
            #add-point:ON ACTION controlp INFIELD b_isaj104 name="construct.c.page1.b_isaj104"
            
            #END add-point
 
 
         #----<<b_isaj105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj105
            #add-point:BEFORE FIELD b_isaj105 name="construct.b.page1.b_isaj105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj105
            
            #add-point:AFTER FIELD b_isaj105 name="construct.a.page1.b_isaj105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj105
            #add-point:ON ACTION controlp INFIELD b_isaj105 name="construct.c.page1.b_isaj105"
            
            #END add-point
 
 
         #----<<b_isaj015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj015
            #add-point:BEFORE FIELD b_isaj015 name="construct.b.page1.b_isaj015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj015
            
            #add-point:AFTER FIELD b_isaj015 name="construct.a.page1.b_isaj015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj015
            #add-point:ON ACTION controlp INFIELD b_isaj015 name="construct.c.page1.b_isaj015"
            
            #END add-point
 
 
         #----<<b_isaj017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj017
            #add-point:BEFORE FIELD b_isaj017 name="construct.b.page1.b_isaj017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj017
            
            #add-point:AFTER FIELD b_isaj017 name="construct.a.page1.b_isaj017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj017
            #add-point:ON ACTION controlp INFIELD b_isaj017 name="construct.c.page1.b_isaj017"
            
            #END add-point
 
 
         #----<<b_isaj010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj010
            #add-point:BEFORE FIELD b_isaj010 name="construct.b.page1.b_isaj010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj010
            
            #add-point:AFTER FIELD b_isaj010 name="construct.a.page1.b_isaj010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj010
            #add-point:ON ACTION controlp INFIELD b_isaj010 name="construct.c.page1.b_isaj010"
            
            #END add-point
 
 
         #----<<b_isaj001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj001
            #add-point:BEFORE FIELD b_isaj001 name="construct.b.page1.b_isaj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj001
            
            #add-point:AFTER FIELD b_isaj001 name="construct.a.page1.b_isaj001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj001
            #add-point:ON ACTION controlp INFIELD b_isaj001 name="construct.c.page1.b_isaj001"
            
            #END add-point
 
 
         #----<<b_isaj003>>----
         #Ctrlp:construct.c.page1.b_isaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj003
            #add-point:ON ACTION controlp INFIELD b_isaj003 name="construct.c.page1.b_isaj003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaj003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaj003  #顯示到畫面上
            NEXT FIELD b_isaj003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj003
            #add-point:BEFORE FIELD b_isaj003 name="construct.b.page1.b_isaj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj003
            
            #add-point:AFTER FIELD b_isaj003 name="construct.a.page1.b_isaj003"
            
            #END add-point
            
 
 
         #----<<b_isaj003_desc>>----
         #----<<b_isaj005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj005
            #add-point:BEFORE FIELD b_isaj005 name="construct.b.page1.b_isaj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj005
            
            #add-point:AFTER FIELD b_isaj005 name="construct.a.page1.b_isaj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj005
            #add-point:ON ACTION controlp INFIELD b_isaj005 name="construct.c.page1.b_isaj005"
            
            #END add-point
 
 
         #----<<b_isaj007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj007
            #add-point:BEFORE FIELD b_isaj007 name="construct.b.page1.b_isaj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj007
            
            #add-point:AFTER FIELD b_isaj007 name="construct.a.page1.b_isaj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj007
            #add-point:ON ACTION controlp INFIELD b_isaj007 name="construct.c.page1.b_isaj007"
            
            #END add-point
 
 
         #----<<b_isaj019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj019
            #add-point:BEFORE FIELD b_isaj019 name="construct.b.page1.b_isaj019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj019
            
            #add-point:AFTER FIELD b_isaj019 name="construct.a.page1.b_isaj019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj019
            #add-point:ON ACTION controlp INFIELD b_isaj019 name="construct.c.page1.b_isaj019"
            
            #END add-point
 
 
         #----<<b_isaj020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaj020
            #add-point:BEFORE FIELD b_isaj020 name="construct.b.page1.b_isaj020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaj020
            
            #add-point:AFTER FIELD b_isaj020 name="construct.a.page1.b_isaj020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj020
            #add-point:ON ACTION controlp INFIELD b_isaj020 name="construct.c.page1.b_isaj020"
            
            #END add-point
 
 
         #----<<b_isajcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isajcomp
            #add-point:BEFORE FIELD b_isajcomp name="construct.b.page1.b_isajcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isajcomp
            
            #add-point:AFTER FIELD b_isajcomp name="construct.a.page1.b_isajcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isajcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isajcomp
            #add-point:ON ACTION controlp INFIELD b_isajcomp name="construct.c.page1.b_isajcomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_input.isaj003,g_input.l_isaj003_desc,g_input.isajcomp,g_input.l_isajcomp_desc,g_input.isaj019,g_input.isaj020 
       FROM isaj003,isaj003_desc,isajcomp,isajcomp_desc,isaj019,isaj020
            ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL aisq440_default()
                                    
         AFTER FIELD isaj003
           IF NOT cl_null(g_input.isaj003) THEN
           #申報單位須存在aisi010裡面
               SELECT COUNT(*) INTO l_cnt
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_input.isaj003
               IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ais-00193'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
            END IF               
            SELECT ooef017 INTO g_input.isajcomp
            FROM ooef_t
            WHERE ooefent = g_enterprise AND ooef001 = g_input.isaj003
            CALL s_desc_get_department_desc(g_input.isajcomp) RETURNING g_input.l_isajcomp_desc
            CALL s_desc_get_department_desc(g_input.isaj003) RETURNING g_input.l_isaj003_desc
            DISPLAY BY NAME g_input.l_isaj003_desc,g_input.isajcomp,g_input.l_isajcomp_desc
            
         AFTER FIELD isaj020
            IF NOT cl_null(g_input.isaj020) THEN
               IF NOT cl_ap_chk_range(g_input.isaj020,"1.000","1","12.000","1","azz-00087",1) THEN
                  NEXT FIELD isaj020
               END IF
               SELECT isaa007 INTO l_isaa007
                 FROM isaa_t
                WHERE isaaent = g_enterprise
                  AND isaa001 = g_input.isaj003
               IF l_isaa007 = '1' THEN
                  IF g_input.isaj020 MOD 2 = 1 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00209'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD isaj020
                  END IF
               END IF                 
            END IF 
         
         ON ACTION controlp INFIELD isaj003
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master.isaj003             #給予default值
            LET g_qryparam.arg1 = g_input.isajcomp
            LET g_qryparam.where = "isaastus = 'Y' "
            CALL q_isaa001_01()                                #呼叫開窗
            LET g_input.isaj003 = g_qryparam.return1              
            CALL s_desc_get_department_desc(g_input.isaj003) RETURNING g_input.l_isaj003_desc
            DISPLAY BY NAME g_input.isaj003,g_input.l_isaj003_desc
            
            SELECT ooef017 INTO g_input.isajcomp
            FROM ooef_t
            WHERE ooefent = g_enterprise AND ooef001 = g_input.isaj003
            CALL s_desc_get_department_desc(g_input.isajcomp) RETURNING g_input.l_isajcomp_desc
            DISPLAY BY NAME g_input.isaj003,g_input.l_isaj003_desc,g_input.isajcomp,g_input.l_isajcomp_desc           
            NEXT FIELD isaj003                          #返回原欄位
            
         AFTER INPUT   
            
      END INPUT
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
   CALL aisq440_b_fill()
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
 
{<section id="aisq440.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq440_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_isaj103_sum   LIKE isaj_t.isaj103     #小計
   DEFINE l_isaj104_sum   LIKE isaj_t.isaj104     #小計
   DEFINE l_isaj105_sum   LIKE isaj_t.isaj105     #小計
   DEFINE l_isaj103_total LIKE isaj_t.isaj103     #總計
   DEFINE l_isaj104_total LIKE isaj_t.isaj104     #總計
   DEFINE l_isaj105_total LIKE isaj_t.isaj105     #總計
   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105, 
       isaj015,isaj017,isaj010,isaj001,isaj003,'',isaj005,isaj007,isaj019,isaj020,isajcomp  ,DENSE_RANK() OVER( ORDER BY isaj_t.isajcomp, 
       isaj_t.isaj001,isaj_t.isaj003,isaj_t.isaj005,isaj_t.isaj006,isaj_t.isaj007,isaj_t.isaj019,isaj_t.isaj020) AS RANK FROM isaj_t", 
 
 
 
                     "",
                     " WHERE isajent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaj_t"),
                     " ORDER BY isaj_t.isajcomp,isaj_t.isaj001,isaj_t.isaj003,isaj_t.isaj005,isaj_t.isaj006,isaj_t.isaj007,isaj_t.isaj019,isaj_t.isaj020"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc =ls_wc CLIPPED ," AND isaj033='1' AND isaj003 = '",g_input.isaj003,"' ",
              " AND isaj019 = ",g_input.isaj019," AND isaj020 = ",g_input.isaj020," AND isajstus = 'Y' "
   LET ls_sql_rank = "SELECT  UNIQUE isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105, 
       isaj015,isaj017,isaj010,isaj001,isaj003,'',isaj005,isaj007,isaj019,isaj020,isajcomp  ,DENSE_RANK() OVER( ORDER BY isaj_t.isaj018, 
       isaj_t.isaj009,isaj_t.isaj006) AS RANK FROM isaj_t", 
                     "",
                     " WHERE isajent= ? AND 1=1 AND ", ls_wc    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isaj_t"),
                     " ORDER BY isaj_t.isaj018,isaj_t.isaj009,isaj_t.isaj006 "

   LET g_sql = "SELECT COUNT(*) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre02 FROM g_sql
   EXECUTE b_fill_cnt_pre02 USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre02
 
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
 
   LET g_sql = "SELECT isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105,isaj015,isaj017, 
       isaj010,isaj001,isaj003,'',isaj005,isaj007,isaj019,isaj020,isajcomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after
   LET g_sql = g_sql CLIPPED," ORDER BY isaj018,isaj009,isaj006"
   LET l_isaj103_sum   = 0
   LET l_isaj104_sum   = 0
   LET l_isaj105_sum   = 0
   LET l_isaj103_total = 0
   LET l_isaj104_total = 0
   LET l_isaj105_total = 0
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq440_pb02 FROM g_sql
   DECLARE b_fill_curs02 CURSOR FOR aisq440_pb02
   
   OPEN b_fill_curs02 USING g_enterprise
 
   CALL g_isaj_d.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs02 INTO g_isaj_d[l_ac].isaj018,g_isaj_d[l_ac].isaj006,g_isaj_d[l_ac].isaj008,g_isaj_d[l_ac].isaj014, 
       g_isaj_d[l_ac].isaj009,g_isaj_d[l_ac].isaj103,g_isaj_d[l_ac].isaj104,g_isaj_d[l_ac].isaj105,g_isaj_d[l_ac].isaj015, 
       g_isaj_d[l_ac].isaj017,g_isaj_d[l_ac].isaj010,g_isaj_d[l_ac].isaj001,g_isaj_d[l_ac].isaj003,g_isaj_d[l_ac].isaj003_desc, 
       g_isaj_d[l_ac].isaj005,g_isaj_d[l_ac].isaj007,g_isaj_d[l_ac].isaj019,g_isaj_d[l_ac].isaj020,g_isaj_d[l_ac].isajcomp 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isaj_d[l_ac].statepic = cl_get_actipic(g_isaj_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充
      IF g_isaj_d[l_ac].isaj017 = 'A' THEN 
         LET  g_isaj_d[l_ac].isaj017 = 'Y' 
      ELSE
         LET  g_isaj_d[l_ac].isaj017 = 'N'
      END IF
      
      IF g_isaj_d[l_ac].isaj103 IS NULL THEN LET  g_isaj_d[l_ac].isaj103 = 0 END IF 
      IF g_isaj_d[l_ac].isaj104 IS NULL THEN LET  g_isaj_d[l_ac].isaj104 = 0 END IF 
      IF g_isaj_d[l_ac].isaj105 IS NULL THEN LET  g_isaj_d[l_ac].isaj105 = 0 END IF 
      IF l_ac > 1 THEN
         IF g_isaj_d[l_ac].isaj018 IS NULL THEN LET  g_isaj_d[l_ac].isaj018 = ' ' END IF      
         IF g_isaj_d[l_ac].isaj018 !=  g_isaj_d[l_ac - 1].isaj018 THEN
            LET g_isaj_d[l_ac + 1].* = g_isaj_d[l_ac].*  
            INITIALIZE  g_isaj_d[l_ac].* TO NULL
            LET g_isaj_d[l_ac].isaj017 = "N"
            LET g_isaj_d[l_ac].isaj018 = g_isaj_d[l_ac - 1].isaj018
            LET g_isaj_d[l_ac].isaj006 = cl_getmsg("axc-00205",g_lang) 
            LET g_isaj_d[l_ac].isaj103 = l_isaj103_sum 
            LET g_isaj_d[l_ac].isaj104 = l_isaj104_sum 
            LET g_isaj_d[l_ac].isaj105 = l_isaj105_sum 
            LET l_ac = l_ac + 1
            LET l_isaj103_sum = 0
            LET l_isaj104_sum = 0
            LET l_isaj105_sum = 0
         END IF
      END IF
      #小計
      LET l_isaj103_sum   = l_isaj103_sum   + g_isaj_d[l_ac].isaj103
      LET l_isaj104_sum   = l_isaj104_sum   + g_isaj_d[l_ac].isaj104
      LET l_isaj105_sum   = l_isaj105_sum   + g_isaj_d[l_ac].isaj105
      #總計
      LET l_isaj103_total = l_isaj103_total + g_isaj_d[l_ac].isaj103
      LET l_isaj104_total = l_isaj104_total + g_isaj_d[l_ac].isaj104
      LET l_isaj105_total = l_isaj105_total + g_isaj_d[l_ac].isaj105   
      #end add-point
 
      CALL aisq440_detail_show("'1'")      
 
      CALL aisq440_isaj_t_mask()
 
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
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_isaj_d.deleteElement(g_isaj_d.getLength())   
 
   #add-point:陣列長度調整
   IF l_ac > 1 THEN
      LET g_isaj_d[l_ac].isaj017 = "N"
      LET g_isaj_d[l_ac].isaj018 = g_isaj_d[l_ac - 1].isaj018
      LET g_isaj_d[l_ac].isaj006 = cl_getmsg("axc-00205",g_lang) 
      LET g_isaj_d[l_ac].isaj103 = l_isaj103_sum
      LET g_isaj_d[l_ac].isaj104 = l_isaj104_sum
      LET g_isaj_d[l_ac].isaj105 = l_isaj105_sum
      LET l_ac = l_ac + 1
      LET g_isaj_d[l_ac].isaj017 = "N"
      LET g_isaj_d[l_ac].isaj006 = cl_getmsg("lib-00133",g_lang)
      LET g_isaj_d[l_ac].isaj006 = g_isaj_d[l_ac].isaj006,":"      
      LET g_isaj_d[l_ac].isaj103 = l_isaj103_total 
      LET g_isaj_d[l_ac].isaj104 = l_isaj104_total 
      LET g_isaj_d[l_ac].isaj105 = l_isaj105_total     
   END IF
   LET g_tot_cnt = g_isaj_d.getLength()
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身)

   #end add-point
 
   LET g_detail_cnt = g_isaj_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs02
   FREE aisq440_pb02
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq440_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq440_detail_action_trans()
 
   IF g_isaj_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq440_fetch()
   END IF
   
      CALL aisq440_filter_show('isaj018','b_isaj018')
   CALL aisq440_filter_show('isaj006','b_isaj006')
   CALL aisq440_filter_show('isaj008','b_isaj008')
   CALL aisq440_filter_show('isaj014','b_isaj014')
   CALL aisq440_filter_show('isaj009','b_isaj009')
   CALL aisq440_filter_show('isaj103','b_isaj103')
   CALL aisq440_filter_show('isaj104','b_isaj104')
   CALL aisq440_filter_show('isaj105','b_isaj105')
   CALL aisq440_filter_show('isaj015','b_isaj015')
   CALL aisq440_filter_show('isaj017','b_isaj017')
   CALL aisq440_filter_show('isaj010','b_isaj010')
   CALL aisq440_filter_show('isaj001','b_isaj001')
   CALL aisq440_filter_show('isaj003','b_isaj003')
   CALL aisq440_filter_show('isaj005','b_isaj005')
   CALL aisq440_filter_show('isaj007','b_isaj007')
   CALL aisq440_filter_show('isaj019','b_isaj019')
   CALL aisq440_filter_show('isaj020','b_isaj020')
   CALL aisq440_filter_show('isajcomp','b_isajcomp')
 
   RETURN
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
 
   LET g_sql = "SELECT isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105,isaj015,isaj017, 
       isaj010,isaj001,isaj003,'',isaj005,isaj007,isaj019,isaj020,isajcomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql CLIPPED," ORDER BY isaj018,isaj009,isaj006"
   LET l_isaj103_sum   = 0
   LET l_isaj104_sum   = 0
   LET l_isaj105_sum   = 0
   LET l_isaj103_total = 0
   LET l_isaj104_total = 0
   LET l_isaj105_total = 0
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq440_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq440_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_isaj_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isaj_d[l_ac].isaj018,g_isaj_d[l_ac].isaj006,g_isaj_d[l_ac].isaj008,g_isaj_d[l_ac].isaj014, 
       g_isaj_d[l_ac].isaj009,g_isaj_d[l_ac].isaj103,g_isaj_d[l_ac].isaj104,g_isaj_d[l_ac].isaj105,g_isaj_d[l_ac].isaj015, 
       g_isaj_d[l_ac].isaj017,g_isaj_d[l_ac].isaj010,g_isaj_d[l_ac].isaj001,g_isaj_d[l_ac].isaj003,g_isaj_d[l_ac].isaj003_desc, 
       g_isaj_d[l_ac].isaj005,g_isaj_d[l_ac].isaj007,g_isaj_d[l_ac].isaj019,g_isaj_d[l_ac].isaj020,g_isaj_d[l_ac].isajcomp 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isaj_d[l_ac].statepic = cl_get_actipic(g_isaj_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_isaj_d[l_ac].isaj103 IS NULL THEN LET  g_isaj_d[l_ac].isaj103 = 0 END IF 
      IF g_isaj_d[l_ac].isaj104 IS NULL THEN LET  g_isaj_d[l_ac].isaj104 = 0 END IF 
      IF g_isaj_d[l_ac].isaj105 IS NULL THEN LET  g_isaj_d[l_ac].isaj105 = 0 END IF 
      IF l_ac > 1 THEN
         IF g_isaj_d[l_ac].isaj018 IS NULL THEN LET  g_isaj_d[l_ac].isaj018 = ' ' END IF      
         IF g_isaj_d[l_ac].isaj018 !=  g_isaj_d[l_ac - 1].isaj018 THEN
            LET g_isaj_d[l_ac + 1].* = g_isaj_d[l_ac].*  
            INITIALIZE  g_isaj_d[l_ac].* TO NULL
            LET g_isaj_d[l_ac].isaj017 = "N"
            LET g_isaj_d[l_ac].isaj018 = g_isaj_d[l_ac - 1].isaj018
            LET g_isaj_d[l_ac].isaj006 = cl_getmsg("axc-00205",g_lang) 
            LET g_isaj_d[l_ac].isaj103 = l_isaj103_sum 
            LET g_isaj_d[l_ac].isaj104 = l_isaj104_sum 
            LET g_isaj_d[l_ac].isaj105 = l_isaj105_sum 
            LET l_ac = l_ac + 1
            LET l_isaj103_sum = 0
            LET l_isaj104_sum = 0
            LET l_isaj105_sum = 0
         END IF
      END IF
      #小計
      LET l_isaj103_sum   = l_isaj103_sum   + g_isaj_d[l_ac].isaj103
      LET l_isaj104_sum   = l_isaj104_sum   + g_isaj_d[l_ac].isaj104
      LET l_isaj105_sum   = l_isaj105_sum   + g_isaj_d[l_ac].isaj105
      #總計
      LET l_isaj103_total = l_isaj103_total + g_isaj_d[l_ac].isaj103
      LET l_isaj104_total = l_isaj104_total + g_isaj_d[l_ac].isaj104
      LET l_isaj105_total = l_isaj105_total + g_isaj_d[l_ac].isaj105   
      #end add-point
 
      CALL aisq440_detail_show("'1'")      
 
      CALL aisq440_isaj_t_mask()
 
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
   
 
   
   CALL g_isaj_d.deleteElement(g_isaj_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN
      LET g_isaj_d[l_ac].isaj017 = "N"
      LET g_isaj_d[l_ac].isaj018 = g_isaj_d[l_ac - 1].isaj018
      LET g_isaj_d[l_ac].isaj006 = cl_getmsg("axc-00205",g_lang) 
      LET g_isaj_d[l_ac].isaj103 = l_isaj103_sum
      LET g_isaj_d[l_ac].isaj104 = l_isaj104_sum
      LET g_isaj_d[l_ac].isaj105 = l_isaj105_sum
      LET l_ac = l_ac + 1
      LET g_isaj_d[l_ac].isaj017 = "N"
      LET g_isaj_d[l_ac].isaj006 = cl_getmsg("lib-00133",g_lang)
      LET g_isaj_d[l_ac].isaj006 = g_isaj_d[l_ac].isaj006,":"      
      LET g_isaj_d[l_ac].isaj103 = l_isaj103_total 
      LET g_isaj_d[l_ac].isaj104 = l_isaj104_total 
      LET g_isaj_d[l_ac].isaj105 = l_isaj105_total     
   END IF
   LET g_tot_cnt = g_isaj_d.getLength()
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isaj_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq440_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq440_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq440_detail_action_trans()
 
   IF g_isaj_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq440_fetch()
   END IF
   
      CALL aisq440_filter_show('isaj018','b_isaj018')
   CALL aisq440_filter_show('isaj006','b_isaj006')
   CALL aisq440_filter_show('isaj008','b_isaj008')
   CALL aisq440_filter_show('isaj014','b_isaj014')
   CALL aisq440_filter_show('isaj009','b_isaj009')
   CALL aisq440_filter_show('isaj103','b_isaj103')
   CALL aisq440_filter_show('isaj104','b_isaj104')
   CALL aisq440_filter_show('isaj105','b_isaj105')
   CALL aisq440_filter_show('isaj015','b_isaj015')
   CALL aisq440_filter_show('isaj017','b_isaj017')
   CALL aisq440_filter_show('isaj010','b_isaj010')
   CALL aisq440_filter_show('isaj001','b_isaj001')
   CALL aisq440_filter_show('isaj003','b_isaj003')
   CALL aisq440_filter_show('isaj005','b_isaj005')
   CALL aisq440_filter_show('isaj007','b_isaj007')
   CALL aisq440_filter_show('isaj019','b_isaj019')
   CALL aisq440_filter_show('isaj020','b_isaj020')
   CALL aisq440_filter_show('isajcomp','b_isajcomp')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq440_fetch()
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
 
{<section id="aisq440.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq440_detail_show(ps_page)
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
      CALL s_desc_get_department_desc(g_input.isaj003) RETURNING g_input.l_isaj003_desc
      DISPLAY BY NAME g_input.isaj003,g_input.l_isaj003_desc
      SELECT ooef017 INTO g_input.isajcomp
      FROM ooef_t
      WHERE ooefent = g_enterprise AND ooef001 = g_input.isaj003
      CALL s_desc_get_department_desc(g_input.isajcomp) RETURNING g_input.l_isajcomp_desc
      DISPLAY BY NAME g_input.isaj003,g_input.l_isaj003_desc,g_input.isajcomp,g_input.l_isajcomp_desc                
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq440_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ooef019  LIKE ooef_t.ooef019
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
      CONSTRUCT g_wc_filter ON isaj018,isaj006,isaj008,isaj014,isaj009,isaj103,isaj104,isaj105,isaj015, 
          isaj017,isaj010,isaj001,isaj003,isaj005,isaj007,isaj019,isaj020,isajcomp
                          FROM s_detail1[1].b_isaj018,s_detail1[1].b_isaj006,s_detail1[1].b_isaj008, 
                              s_detail1[1].b_isaj014,s_detail1[1].b_isaj009,s_detail1[1].b_isaj103,s_detail1[1].b_isaj104, 
                              s_detail1[1].b_isaj105,s_detail1[1].b_isaj015,s_detail1[1].b_isaj017,s_detail1[1].b_isaj010, 
                              s_detail1[1].b_isaj001,s_detail1[1].b_isaj003,s_detail1[1].b_isaj005,s_detail1[1].b_isaj007, 
                              s_detail1[1].b_isaj019,s_detail1[1].b_isaj020,s_detail1[1].b_isajcomp
 
         BEFORE CONSTRUCT
                     DISPLAY aisq440_filter_parser('isaj018') TO s_detail1[1].b_isaj018
            DISPLAY aisq440_filter_parser('isaj006') TO s_detail1[1].b_isaj006
            DISPLAY aisq440_filter_parser('isaj008') TO s_detail1[1].b_isaj008
            DISPLAY aisq440_filter_parser('isaj014') TO s_detail1[1].b_isaj014
            DISPLAY aisq440_filter_parser('isaj009') TO s_detail1[1].b_isaj009
            DISPLAY aisq440_filter_parser('isaj103') TO s_detail1[1].b_isaj103
            DISPLAY aisq440_filter_parser('isaj104') TO s_detail1[1].b_isaj104
            DISPLAY aisq440_filter_parser('isaj105') TO s_detail1[1].b_isaj105
            DISPLAY aisq440_filter_parser('isaj015') TO s_detail1[1].b_isaj015
            DISPLAY aisq440_filter_parser('isaj017') TO s_detail1[1].b_isaj017
            DISPLAY aisq440_filter_parser('isaj010') TO s_detail1[1].b_isaj010
            DISPLAY aisq440_filter_parser('isaj001') TO s_detail1[1].b_isaj001
            DISPLAY aisq440_filter_parser('isaj003') TO s_detail1[1].b_isaj003
            DISPLAY aisq440_filter_parser('isaj005') TO s_detail1[1].b_isaj005
            DISPLAY aisq440_filter_parser('isaj007') TO s_detail1[1].b_isaj007
            DISPLAY aisq440_filter_parser('isaj019') TO s_detail1[1].b_isaj019
            DISPLAY aisq440_filter_parser('isaj020') TO s_detail1[1].b_isaj020
            DISPLAY aisq440_filter_parser('isajcomp') TO s_detail1[1].b_isajcomp
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isaj018>>----
         #Ctrlp:construct.c.page1.b_isaj018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj018
            #add-point:ON ACTION controlp INFIELD b_isaj018 name="construct.c.filter.page1.b_isaj018"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            SELECT ooef019 INTO l_ooef019
              FROM ooef_t
             #WHERE ooef001 = g_input.isaj003 AND ooef017 = g_input.isajcomp                            #160905-00002#4 mark
             WHERE ooefent = g_enterprise AND ooef001 = g_input.isaj003 AND ooef017 = g_input.isajcomp  #160905-00002#4 add
             
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "isap001 = '",l_ooef019 CLIPPED,"' "
            CALL q_isap002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaj018  #顯示到畫面上
            NEXT FIELD b_isaj018                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaj006>>----
         #Ctrlp:construct.c.filter.page1.b_isaj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj006
            #add-point:ON ACTION controlp INFIELD b_isaj006 name="construct.c.filter.page1.b_isaj006"
            
            #END add-point
 
 
         #----<<b_isaj008>>----
         #Ctrlp:construct.c.filter.page1.b_isaj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj008
            #add-point:ON ACTION controlp INFIELD b_isaj008 name="construct.c.filter.page1.b_isaj008"
            
            #END add-point
 
 
         #----<<b_isaj014>>----
         #Ctrlp:construct.c.filter.page1.b_isaj014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj014
            #add-point:ON ACTION controlp INFIELD b_isaj014 name="construct.c.filter.page1.b_isaj014"
            
            #END add-point
 
 
         #----<<b_isaj009>>----
         #Ctrlp:construct.c.filter.page1.b_isaj009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj009
            #add-point:ON ACTION controlp INFIELD b_isaj009 name="construct.c.filter.page1.b_isaj009"
            
            #END add-point
 
 
         #----<<b_isaj103>>----
         #Ctrlp:construct.c.filter.page1.b_isaj103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj103
            #add-point:ON ACTION controlp INFIELD b_isaj103 name="construct.c.filter.page1.b_isaj103"
            
            #END add-point
 
 
         #----<<b_isaj104>>----
         #Ctrlp:construct.c.filter.page1.b_isaj104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj104
            #add-point:ON ACTION controlp INFIELD b_isaj104 name="construct.c.filter.page1.b_isaj104"
            
            #END add-point
 
 
         #----<<b_isaj105>>----
         #Ctrlp:construct.c.filter.page1.b_isaj105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj105
            #add-point:ON ACTION controlp INFIELD b_isaj105 name="construct.c.filter.page1.b_isaj105"
            
            #END add-point
 
 
         #----<<b_isaj015>>----
         #Ctrlp:construct.c.filter.page1.b_isaj015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj015
            #add-point:ON ACTION controlp INFIELD b_isaj015 name="construct.c.filter.page1.b_isaj015"
            
            #END add-point
 
 
         #----<<b_isaj017>>----
         #Ctrlp:construct.c.filter.page1.b_isaj017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj017
            #add-point:ON ACTION controlp INFIELD b_isaj017 name="construct.c.filter.page1.b_isaj017"
            
            #END add-point
 
 
         #----<<b_isaj010>>----
         #Ctrlp:construct.c.filter.page1.b_isaj010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj010
            #add-point:ON ACTION controlp INFIELD b_isaj010 name="construct.c.filter.page1.b_isaj010"
            
            #END add-point
 
 
         #----<<b_isaj001>>----
         #Ctrlp:construct.c.filter.page1.b_isaj001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj001
            #add-point:ON ACTION controlp INFIELD b_isaj001 name="construct.c.filter.page1.b_isaj001"
            
            #END add-point
 
 
         #----<<b_isaj003>>----
         #Ctrlp:construct.c.page1.b_isaj003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj003
            #add-point:ON ACTION controlp INFIELD b_isaj003 name="construct.c.filter.page1.b_isaj003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isaj003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaj003  #顯示到畫面上
            NEXT FIELD b_isaj003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isaj003_desc>>----
         #----<<b_isaj005>>----
         #Ctrlp:construct.c.filter.page1.b_isaj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj005
            #add-point:ON ACTION controlp INFIELD b_isaj005 name="construct.c.filter.page1.b_isaj005"
            
            #END add-point
 
 
         #----<<b_isaj007>>----
         #Ctrlp:construct.c.filter.page1.b_isaj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj007
            #add-point:ON ACTION controlp INFIELD b_isaj007 name="construct.c.filter.page1.b_isaj007"
            
            #END add-point
 
 
         #----<<b_isaj019>>----
         #Ctrlp:construct.c.filter.page1.b_isaj019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj019
            #add-point:ON ACTION controlp INFIELD b_isaj019 name="construct.c.filter.page1.b_isaj019"
            
            #END add-point
 
 
         #----<<b_isaj020>>----
         #Ctrlp:construct.c.filter.page1.b_isaj020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaj020
            #add-point:ON ACTION controlp INFIELD b_isaj020 name="construct.c.filter.page1.b_isaj020"
            
            #END add-point
 
 
         #----<<b_isajcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isajcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isajcomp
            #add-point:ON ACTION controlp INFIELD b_isajcomp name="construct.c.filter.page1.b_isajcomp"
            
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
   
      CALL aisq440_filter_show('isaj018','b_isaj018')
   CALL aisq440_filter_show('isaj006','b_isaj006')
   CALL aisq440_filter_show('isaj008','b_isaj008')
   CALL aisq440_filter_show('isaj014','b_isaj014')
   CALL aisq440_filter_show('isaj009','b_isaj009')
   CALL aisq440_filter_show('isaj103','b_isaj103')
   CALL aisq440_filter_show('isaj104','b_isaj104')
   CALL aisq440_filter_show('isaj105','b_isaj105')
   CALL aisq440_filter_show('isaj015','b_isaj015')
   CALL aisq440_filter_show('isaj017','b_isaj017')
   CALL aisq440_filter_show('isaj010','b_isaj010')
   CALL aisq440_filter_show('isaj001','b_isaj001')
   CALL aisq440_filter_show('isaj003','b_isaj003')
   CALL aisq440_filter_show('isaj005','b_isaj005')
   CALL aisq440_filter_show('isaj007','b_isaj007')
   CALL aisq440_filter_show('isaj019','b_isaj019')
   CALL aisq440_filter_show('isaj020','b_isaj020')
   CALL aisq440_filter_show('isajcomp','b_isajcomp')
 
    
   CALL aisq440_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq440_filter_parser(ps_field)
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
 
{<section id="aisq440.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq440_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq440_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.insert" >}
#+ insert
PRIVATE FUNCTION aisq440_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq440.modify" >}
#+ modify
PRIVATE FUNCTION aisq440_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq440_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.delete" >}
#+ delete
PRIVATE FUNCTION aisq440_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq440.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq440_detail_action_trans()
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
 
{<section id="aisq440.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq440_detail_index_setting()
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
            IF g_isaj_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isaj_d.getLength() AND g_isaj_d.getLength() > 0
            LET g_detail_idx = g_isaj_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isaj_d.getLength() THEN
               LET g_detail_idx = g_isaj_d.getLength()
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
 
{<section id="aisq440.mask_functions" >}
 &include "erp/ais/aisq440_mask.4gl"
 
{</section>}
 
{<section id="aisq440.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 清空欄位,並給予預設值
# Memo...........:
# Usage..........: CALL aisq440_default()
# Date & Author..: 150622 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq440_default()
   LET g_input.l_isaj003_desc = ''
   LET g_input.isaj019        = ''
   LET g_input.isaj020        = ''
   LET g_input.isaj003        = g_site
   SELECT ooef017 INTO g_input.isajcomp
   FROM ooef_t
   WHERE ooefent = g_enterprise AND ooef001 = g_site
   CALL s_desc_get_department_desc(g_input.isaj003) RETURNING g_input.l_isaj003_desc
   CALL s_desc_get_department_desc(g_input.isajcomp) RETURNING g_input.l_isajcomp_desc
   DISPLAY BY NAME g_input.isajcomp,g_input.isaj003,g_input.l_isaj003_desc,g_input.isaj019,g_input.isaj020,g_input.l_isajcomp_desc
END FUNCTION
################################################################################
# Descriptions...: 建立TMP TABLE供Q轉XG用
# Memo...........: 
#
# Date & Author..: 150622 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq440_x01_tmp()
   DROP TABLE aisq440_x01_tmp;
   CREATE TEMP TABLE aisq440_x01_tmp(
      isaj018            VARCHAR(10), 
      isaj006            VARCHAR(20), 
      isaj008            VARCHAR(20), 
      l_isaj014_desc     VARCHAR(500),
      isaj009            DATE, 
      isaj103            DECIMAL(20,10), 
      isaj104            DECIMAL(20,6), 
      isaj105            DECIMAL(20,6), 
      l_isaj015_desc     VARCHAR(500),
      isaj017            VARCHAR(1), 
      isaj010            VARCHAR(20), 
      l_isaj003_desc     VARCHAR(500), 
      l_isaj019_isaj020  VARCHAR(500), 
      l_isajcomp_desc    VARCHAR(500)
      )
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: 
#
# Date & Author..: 150622 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq440_insert_tmp()
   DEFINE l_i LIKE type_t.num10
   DEFINE l_isaj014_desc  LIKE type_t.chr500    
   DEFINE l_isaj015_desc  LIKE type_t.chr500    
   DEFINE l_isaj003_desc  LIKE type_t.chr500
   DEFINE l_isajcomp_desc LIKE type_t.chr500
   DEFINE l_x01_tmp     RECORD
      isaj018           LIKE isaj_t.isaj018, 
      isaj006           LIKE isaj_t.isaj006, 
      isaj008           LIKE isaj_t.isaj008, 
      l_isaj014_desc    LIKE type_t.chr500,
      isaj009           LIKE isaj_t.isaj009, 
      isaj103           LIKE isaj_t.isaj103, 
      isaj104           LIKE isaj_t.isaj104, 
      isaj105           LIKE isaj_t.isaj105, 
      l_isaj015_desc    LIKE type_t.chr500,
      isaj017           LIKE isaj_t.isaj017, 
      isaj010           LIKE isaj_t.isaj010, 
      l_isaj003_desc    LIKE type_t.chr500, 
      l_isaj019_isaj020 LIKE type_t.chr500, 
      l_isajcomp_desc   LIKE type_t.chr500
                        END RECORD
   DELETE FROM aisq440_x01_tmp;
   FOR l_i = 1 TO g_isaj_d.getLength()
      CALL s_desc_gzcbl004_desc('9719',g_isaj_d[l_i].isaj014) RETURNING l_isaj014_desc
      CALL s_desc_gzcbl004_desc('9708',g_isaj_d[l_i].isaj015) RETURNING l_isaj015_desc
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.isaj018           = g_isaj_d[l_i].isaj018 
      LET l_x01_tmp.isaj006           = g_isaj_d[l_i].isaj006 
      LET l_x01_tmp.isaj008           = g_isaj_d[l_i].isaj008 
      IF NOT cl_null(g_isaj_d[l_i].isaj014) THEN
         LET l_x01_tmp.l_isaj014_desc = g_isaj_d[l_i].isaj014,":",l_isaj014_desc
      ELSE
         LET l_x01_tmp.l_isaj014_desc = "" 
      END IF
      LET l_x01_tmp.isaj009           = g_isaj_d[l_i].isaj009 
      LET l_x01_tmp.isaj103           = g_isaj_d[l_i].isaj103 
      LET l_x01_tmp.isaj104           = g_isaj_d[l_i].isaj104 
      LET l_x01_tmp.isaj105           = g_isaj_d[l_i].isaj105 
      IF NOT cl_null(g_isaj_d[l_i].isaj015) THEN
         LET l_x01_tmp.l_isaj015_desc = g_isaj_d[l_i].isaj015,":",l_isaj015_desc
      ELSE
         LET l_x01_tmp.l_isaj015_desc = "" 
      END IF
      IF g_isaj_d[l_i].isaj017 = 'Y' THEN
         LET l_x01_tmp.isaj017        = 'A' 
      ELSE
         LET l_x01_tmp.isaj017        = '' 
      END IF
      LET l_x01_tmp.isaj010           = g_isaj_d[l_i].isaj010 
      LET l_x01_tmp.l_isaj003_desc    = g_input.isaj003,":",g_input.l_isaj003_desc
      LET l_x01_tmp.l_isaj019_isaj020 = g_input.isaj019," ",g_input.isaj020
      LET l_x01_tmp.l_isajcomp_desc   = g_input.isajcomp,":",g_input.l_isajcomp_desc
     #INSERT INTO aisq440_x01_tmp VALUES(l_x01_tmp.*) #161108-00017#6 mark
      #161108-00017#6 --s add
      INSERT INTO aisq440_x01_tmp(isaj018,isaj006,isaj008,l_isaj014_desc,isaj009,          
                                  isaj103,isaj104,isaj105,l_isaj015_desc,isaj017,          
                                  isaj010,l_isaj003_desc,l_isaj019_isaj020,l_isajcomp_desc) 
      VALUES(l_x01_tmp.isaj018,l_x01_tmp.isaj006,l_x01_tmp.isaj008,l_x01_tmp.l_isaj014_desc,l_x01_tmp.isaj009,          
             l_x01_tmp.isaj103,l_x01_tmp.isaj104,l_x01_tmp.isaj105,l_x01_tmp.l_isaj015_desc,l_x01_tmp.isaj017,          
             l_x01_tmp.isaj010,l_x01_tmp.l_isaj003_desc,l_x01_tmp.l_isaj019_isaj020,l_x01_tmp.l_isajcomp_desc)
      #161108-00017#6 --e add
   END FOR
END FUNCTION

 
{</section>}
 
