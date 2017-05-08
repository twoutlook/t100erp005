#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq054.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2016-04-27 15:37:18), PR版次:0009(2017-01-17 10:07:54)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: abgq054
#+ Description: 科目預算與實際各期比較表
#+ Creator....: 03080(2015-11-20 17:15:40)
#+ Modifier...: 03080 -SD/PR- 06821
 
{</section>}
 
{<section id="abgq054.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160127-00033#4 抓資料變更的邏輯內容調整在s_abgt053中;預設值預設變更
#160318-00005#4  160321 By Jessy 修正azzi920重複定義之錯誤訊息
#160425-00020#1  160427 By albireo 依SA測試修改  科目對映預算項目
#160920-00019#4  160920 By 08732   交易對象開窗調整為q_pmaa001_25
#161006-00005#23 161021 By 08732   組織類型與職能開窗調整
#161108-00017#5  161109 By 08732   程式中DEFINE RECORD LIKE、INSERT INTO 時不可以用*的寫法，要一個一個欄位定義
#161129-00019#10 170117 By 06821   預算組織權限,不卡 azzi800 有權限, 改call 元件s_abg2_get_budget_site(...)
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
PRIVATE TYPE type_g_bgbc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       l_cond2 LIKE type_t.chr500, 
   l_cond2_desc LIKE type_t.chr500, 
   bgbc007 LIKE bgbc_t.bgbc007, 
   bgbc007_desc LIKE type_t.chr500, 
   l_rowtype LIKE type_t.chr500, 
   l_sum1 LIKE type_t.num20_6, 
   l_sum2 LIKE type_t.num20_6, 
   l_sum3 LIKE type_t.num20_6, 
   l_sum4 LIKE type_t.num20_6, 
   l_sum5 LIKE type_t.num20_6, 
   l_sum6 LIKE type_t.num20_6, 
   l_sum7 LIKE type_t.num20_6, 
   l_sum8 LIKE type_t.num20_6, 
   l_sum9 LIKE type_t.num20_6, 
   l_sum10 LIKE type_t.num20_6, 
   l_sum11 LIKE type_t.num20_6, 
   l_sum12 LIKE type_t.num20_6, 
   l_sum13 LIKE type_t.num20_6, 
   l_sumall LIKE type_t.num20_6, 
   l_bgbdsum1 LIKE type_t.num20_6, 
   l_glarsum1 LIKE type_t.num20_6, 
   l_diff1 LIKE type_t.num20_6, 
   l_rate1 LIKE type_t.num20_6, 
   l_bgbdsum2 LIKE type_t.num20_6, 
   l_glarsum2 LIKE type_t.num20_6, 
   l_diff2 LIKE type_t.num20_6, 
   l_rate2 LIKE type_t.num20_6, 
   bgbc001 LIKE bgbc_t.bgbc001, 
   bgbc002 LIKE bgbc_t.bgbc002, 
   bgbc003 LIKE bgbc_t.bgbc003, 
   bgbc004 LIKE bgbc_t.bgbc004, 
   l_acc LIKE type_t.chr1 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input RECORD
               l_bgaa001      LIKE bgaa_t.bgaa001,   #預算編號
               l_bgaa001_desc LIKE type_t.chr500,   
               l_bgbc002      LIKE bgbc_t.bgbc002,   #版本
               l_bgbc003      LIKE bgbc_t.bgbc003,   #預算組織
               l_bgbc003_desc LIKE type_t.chr500,    
               l_ogtype       LIKE type_t.chr1,      #選項
               l_withbgbd     LIKE type_t.chr1,      #
               l_ld           LIKE glaa_t.glaald,
               l_comp         LIKE ooef_t.ooef001,
               l_curr         LIKE apca_t.apca100,
               l_yy1          LIKE type_t.num5,
               l_mm1          LIKE type_t.num5,
               l_yy2          LIKE type_t.num5,
               l_mm2          LIKE type_t.num5,
               l_bgbc007      LIKE type_t.chr1000,
               l_sumtype      LIKE type_t.chr10,
               l_condtype     LIKE type_t.chr10,
               l_cond         LIKE type_t.chr1000,
               l_ld_desc      LIKE type_t.chr500,
               l_comp_desc    LIKE type_t.chr500
               END RECORD
DEFINE g_bgaa  RECORD
               bgaa003    LIKE bgaa_t.bgaa003,
               bgaa008    LIKE bgaa_t.bgaa008
               END RECORD
DEFINE  g_field_3   LIKE type_t.chr80
DEFINE g_userorga            STRING   #161006-00005#23   add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_bgbc_d
DEFINE g_master_t                   type_g_bgbc_d
DEFINE g_bgbc_d          DYNAMIC ARRAY OF type_g_bgbc_d
DEFINE g_bgbc_d_t        type_g_bgbc_d
 
      
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
 
{<section id="abgq054.main" >}
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
   CALL cl_ap_init("abg","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   #161006-00005#23  add ---s
   CALL s_fin_create_account_center_tmp()
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_sons_str() RETURNING g_userorga
   CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   #161006-00005#23  add ---e
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq054_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq054_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq054_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq054 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq054_init()   
 
      #進入選單 Menu (="N")
      CALL abgq054_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq054
      
   END IF 
   
   CLOSE abgq054_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq054.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abgq054_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('l_condtype','9934')
   CALL cl_set_combo_scc_part('l_sumtype','9925',"1,3,4")
   #CALL s_fin_create_account_center_tmp()   #161006-00005#23   mark
   CALL s_abgq053_cre_tmp()   
   CALL abgq054_cre_tmp()
   #end add-point
 
   CALL abgq054_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="abgq054.default_search" >}
PRIVATE FUNCTION abgq054_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " bgbc001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " bgbc002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " bgbc003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " bgbc004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " bgbc006 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " bgbc007 = '", g_argv[06], "' AND "
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
 
{<section id="abgq054.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abgq054_ui_dialog()
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
      CALL abgq054_b_fill()
   ELSE
      CALL abgq054_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_bgbc_d.clear()
 
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
 
         CALL abgq054_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bgbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL abgq054_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL abgq054_detail_action_trans()
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
            CALL abgq054_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL abgq054_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abgq054_query()
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
            CALL abgq054_filter()
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
            CALL abgq054_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bgbc_d)
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
            CALL abgq054_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL abgq054_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL abgq054_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL abgq054_b_fill()
 
         
         
 
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
 
{<section id="abgq054.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abgq054_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_orga                 STRING             #161006-00005#23   add
   DEFINE l_site_str             STRING             #161129-00019#10 add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_bgbc_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON bgbc007,bgbc001,bgbc002,bgbc003,bgbc004
           FROM s_detail1[1].b_bgbc007,s_detail1[1].b_bgbc001,s_detail1[1].b_bgbc002,s_detail1[1].b_bgbc003, 
               s_detail1[1].b_bgbc004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_cond2>>----
         #----<<l_cond2_desc>>----
         #----<<b_bgbc007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgbc007
            #add-point:BEFORE FIELD b_bgbc007 name="construct.b.page1.b_bgbc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgbc007
            
            #add-point:AFTER FIELD b_bgbc007 name="construct.a.page1.b_bgbc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc007
            #add-point:ON ACTION controlp INFIELD b_bgbc007 name="construct.c.page1.b_bgbc007"
            
            #END add-point
 
 
         #----<<bgbc007_desc>>----
         #----<<l_rowtype>>----
         #----<<l_sum1>>----
         #----<<l_sum2>>----
         #----<<l_sum3>>----
         #----<<l_sum4>>----
         #----<<l_sum5>>----
         #----<<l_sum6>>----
         #----<<l_sum7>>----
         #----<<l_sum8>>----
         #----<<l_sum9>>----
         #----<<l_sum10>>----
         #----<<l_sum11>>----
         #----<<l_sum12>>----
         #----<<l_sum13>>----
         #----<<l_sumall>>----
         #----<<l_bgbdsum1>>----
         #----<<l_glarsum1>>----
         #----<<l_diff1>>----
         #----<<l_rate1>>----
         #----<<l_bgbdsum2>>----
         #----<<l_glarsum2>>----
         #----<<l_diff2>>----
         #----<<l_rate2>>----
         #----<<b_bgbc001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgbc001
            #add-point:BEFORE FIELD b_bgbc001 name="construct.b.page1.b_bgbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgbc001
            
            #add-point:AFTER FIELD b_bgbc001 name="construct.a.page1.b_bgbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc001
            #add-point:ON ACTION controlp INFIELD b_bgbc001 name="construct.c.page1.b_bgbc001"
            
            #END add-point
 
 
         #----<<b_bgbc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgbc002
            #add-point:BEFORE FIELD b_bgbc002 name="construct.b.page1.b_bgbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgbc002
            
            #add-point:AFTER FIELD b_bgbc002 name="construct.a.page1.b_bgbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc002
            #add-point:ON ACTION controlp INFIELD b_bgbc002 name="construct.c.page1.b_bgbc002"
            
            #END add-point
 
 
         #----<<b_bgbc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgbc003
            #add-point:BEFORE FIELD b_bgbc003 name="construct.b.page1.b_bgbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgbc003
            
            #add-point:AFTER FIELD b_bgbc003 name="construct.a.page1.b_bgbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc003
            #add-point:ON ACTION controlp INFIELD b_bgbc003 name="construct.c.page1.b_bgbc003"
            
            #END add-point
 
 
         #----<<b_bgbc004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bgbc004
            #add-point:BEFORE FIELD b_bgbc004 name="construct.b.page1.b_bgbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bgbc004
            
            #add-point:AFTER FIELD b_bgbc004 name="construct.a.page1.b_bgbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bgbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc004
            #add-point:ON ACTION controlp INFIELD b_bgbc004 name="construct.c.page1.b_bgbc004"
            
            #END add-point
 
 
         #----<<l_acc>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME
               g_input.l_bgaa001,g_input.l_bgaa001_desc,g_input.l_bgbc002,   
               g_input.l_bgbc003,g_input.l_bgbc003_desc,g_input.l_ogtype,   
               g_input.l_withbgbd,g_input.l_ld,g_input.l_comp,
               g_input.l_curr,g_input.l_yy1,g_input.l_mm1,
               g_input.l_yy2,g_input.l_mm2,g_input.l_bgbc007,
               g_input.l_sumtype,g_input.l_condtype,g_input.l_cond
                    
         ATTRIBUTE (WITHOUT DEFAULTS)
         
         AFTER FIELD l_bgaa001
            IF NOT cl_null(g_input.l_bgaa001) THEN
               CALL abgq054_bgbc_chk(g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  #160318-00005#4 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160318-00005#4 --e add
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_input.l_bgaa001    = ''
                  LET g_input.l_bgbc002    = ''
                  LET g_input.l_bgbc003    = ''
                  LET g_input.l_bgaa001_desc = ''
                  LET g_input.l_ld  = ''
                  LET g_input.l_comp = ''
                  LET g_input.l_curr = ''
                  LET g_input.l_bgbc003_desc = ''
                  LET g_input.l_ld_desc = ''
                  LET g_input.l_comp_desc =''
                  DISPLAY BY NAME g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_bgaa001_desc,
                                  g_input.l_ld,g_input.l_comp,g_input.l_curr,g_input.l_ld_desc,g_input.l_comp_desc,
                                  g_input.l_bgbc003_desc
                  NEXT FIELD l_bgaa001                 
               END IF                       
            END IF
            CALL s_fin_abg_center_sons_query(g_input.l_bgaa001,'','') #取得預算組織編號組織樹
            CALL s_desc_get_budget_desc(g_input.l_bgaa001) RETURNING g_input.l_bgaa001_desc
            #取得科目參照表/預算幣別
            SELECT bgaa008,bgaa003 INTO g_bgaa.bgaa008,g_bgaa.bgaa003
              FROM bgaa_t
             WHERE bgaaent = g_enterprise
               AND bgaa001 = g_input.l_bgaa001     


         AFTER FIELD l_bgbc002           
            IF NOT cl_null(g_input.l_bgbc002)THEN
               CALL s_chr_alphanumeric(g_input.l_bgbc002,1)RETURNING g_sub_success
               IF NOT g_sub_success THEN
                  NEXT FIELD CURRENT
               END IF
               CALL abgq054_bgbc_chk(g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  #160318-00005#4 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160318-00005#4 --e add
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_input.l_bgaa001    = ''
                  LET g_input.l_bgbc002    = ''
                  LET g_input.l_bgbc003    = ''
                  LET g_input.l_bgaa001_desc = ''
                  LET g_input.l_ld  = ''
                  LET g_input.l_comp = ''
                  LET g_input.l_curr = ''
                  LET g_input.l_bgbc003_desc = ''
                  LET g_input.l_ld_desc = ''
                  LET g_input.l_comp_desc =''
                  DISPLAY BY NAME g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_bgaa001_desc,
                                  g_input.l_ld,g_input.l_comp,g_input.l_curr,g_input.l_ld_desc,g_input.l_comp_desc,
                                  g_input.l_bgbc003_desc
                  NEXT FIELD l_bgbc002
               END IF                     
               LET g_input.l_bgbc002 = g_input.l_bgbc002 USING '<<<<<<<<<<'
               DISPLAY BY NAME g_input.l_bgbc002
            END IF         

    
         AFTER FIELD l_bgbc003
            IF NOT cl_null(g_input.l_bgbc003) THEN
               CALL s_fin_abg_center_sons_query(g_input.l_bgaa001,'','')   #161006-00005#23   add
               CALL abgq054_bgbc_chk(g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  #160318-00005#4 --s add
                  LET g_errparam.replace[1] = 'aooi125'
                  LET g_errparam.replace[2] = cl_get_progname('aooi125',g_lang,"2")
                  LET g_errparam.exeprog = 'aooi125'
                  #160318-00005#4 --e add
                  LET g_errparam.extend = ''
                  CALL cl_err()
                  LET g_input.l_bgaa001    = ''
                  LET g_input.l_bgbc002    = ''
                  LET g_input.l_bgbc003    = ''
                  LET g_input.l_bgaa001_desc = ''
                  LET g_input.l_ld  = ''
                  LET g_input.l_comp = ''
                  LET g_input.l_curr = ''
                  LET g_input.l_bgbc003_desc = ''
                  LET g_input.l_ld_desc = ''
                  LET g_input.l_comp_desc =''
                  DISPLAY BY NAME g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_bgaa001_desc,
                                  g_input.l_ld,g_input.l_comp,g_input.l_curr,g_input.l_ld_desc,g_input.l_comp_desc,
                                  g_input.l_bgbc003_desc
                  NEXT FIELD l_bgbc003
               END IF   
               #161129-00019#10 --s add
               #檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_input.l_bgaa001,'',g_input.l_bgbc003,'07')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.l_bgaa001    = ''
                  LET g_input.l_bgbc002    = ''
                  LET g_input.l_bgbc003    = ''
                  LET g_input.l_bgaa001_desc = ''
                  LET g_input.l_ld  = ''
                  LET g_input.l_comp = ''
                  LET g_input.l_curr = ''
                  LET g_input.l_bgbc003_desc = ''
                  LET g_input.l_ld_desc = ''
                  LET g_input.l_comp_desc =''
                  DISPLAY BY NAME g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_bgaa001_desc,
                                  g_input.l_ld,g_input.l_comp,g_input.l_curr,g_input.l_ld_desc,g_input.l_comp_desc,
                                  g_input.l_bgbc003_desc
                  NEXT FIELD l_bgbc003
               END IF
               #161129-00019#10 --e add               
            END IF
            CALL s_fin_orga_get_comp_ld(g_input.l_bgbc003) 
               RETURNING g_sub_success,g_errno,g_input.l_comp,g_input.l_ld
            CALL s_desc_get_department_desc(g_input.l_bgbc003) RETURNING g_input.l_bgbc003_desc
            SELECT glaa001 INTO g_input.l_curr
              FROM glaa_t
             WHERE glaaent = g_enterprise
               AND glaald = g_input.l_ld
               
            CALL s_desc_get_ld_desc(g_input.l_ld)RETURNING g_input.l_ld_desc
            CALL s_desc_get_department_desc(g_input.l_comp) RETURNING g_input.l_comp_desc             
            DISPLAY BY NAME g_input.l_bgbc003_desc,g_input.l_comp,g_input.l_ld,g_input.l_curr,g_input.l_comp_desc,
                            g_input.l_ld_desc,g_input.l_curr
            

         ON ACTION controlp INFIELD l_bgaa001
             INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.l_bgaa001
            LET g_qryparam.where = " bgaastus = 'Y' ",
                                   #" AND bgaa012 = 'Y'                      ",  #使用科目預算  #albireo 1604 mark  #160425-00020#1
                                   " AND bgaa001 IN (SELECT bgbc001 FROM bgbc_t            ",
                                   "                   WHERE bgbcent = '",g_enterprise,"' )"  
            CALL q_bgaa001()
            LET g_input.l_bgaa001 = g_qryparam.return1
            DISPLAY BY NAME g_input.l_bgaa001
            NEXT FIELD l_bgaa001
         ON ACTION controlp INFIELD l_bgbc003
            #161129-00019#10 --s mark
            ##161006-00005#23  add----s
            #CALL s_fin_abg_center_sons_query(g_input.l_bgaa001,'','')
            #CALL s_fin_account_center_sons_str() RETURNING l_orga  
            #CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            ##161006-00005#23  add----e
            #161129-00019#10 --e mark
            #161129-00019#10 --s add
            #檢查預算組織是否在abgi090中可操作的組織中
            LET l_site_str = ''
            CALL s_abg2_get_budget_site(g_input.l_bgaa001,'',g_user,'07') RETURNING l_site_str
            CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            #161129-00019#10 --e add              
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.l_bgbc003  #給予default值
            #161006-00005#23   mark---s
            #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) ",
            #                       "  AND ooef001 IN (SELECT bgaj002 FROM bgaj_t  ",
            #                       "                    WHERE bgajent = '",g_enterprise,"'         ",
            #                       "                      AND bgaj001 = '",g_input.l_bgaa001,"' )  "
            #CALL q_ooef001()     
            #161006-00005#23   mark---e
            #161006-00005#23   add---s
            LET g_qryparam.where = " ooef001 IN (SELECT bgaj002 FROM bgaj_t  ",
                                   "                    WHERE bgajent = '",g_enterprise,"'         ",
                                   "                      AND bgaj001 = '",g_input.l_bgaa001,"' )  ",
                                   #" AND ooef001 IN ", g_userorga #161129-00019#10 mark
                                   " AND ooef001 IN ", l_site_str  #161129-00019#10 add
            #161129-00019#10 --s mark
            #IF NOT cl_null(g_input.l_bgaa001) THEN 
            #   LET g_qryparam.where = g_qryparam.where CLIPPED," AND ooef001 IN ", l_orga
            #END IF
            #161129-00019#10 --e mark
            CALL q_ooef001_77()   
            #161006-00005#23   add---e
            LET g_input.l_bgbc003 = g_qryparam.return1
            DISPLAY BY NAME g_input.l_bgbc003
            NEXT FIELD l_bgbc003            
         ON ACTION controlp INFIELD l_bgbc007
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            IF NOT cl_null(g_bgaa.bgaa008) THEN
               LET g_qryparam.where = "glac001 = '",g_bgaa.bgaa008,"'"
            END IF
            CALL aglt310_04()                     #呼叫開窗
            LET g_input.l_bgbc007 = g_qryparam.return1
            DISPLAY g_qryparam.return1 TO l_bgbc007
            
            NEXT FIELD l_bgbc007 
            
            
         ON ACTION controlp INFIELD l_cond
             INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CASE g_input.l_condtype
                  WHEN '1' #營運據點
                     #LET g_qryparam.where = "ooeg201='Y' AND ooef001 IN ",g_userorga   #161006-00005#23   add #161129-00019#10 mark
                     LET g_qryparam.where = "ooef201='Y' AND ooef001 IN ",g_userorga    #161129-00019#10 add 原串錯欄位導致開窗失敗,串ooef201 而非 ooeg201 
                     CALL q_ooef001()
                  WHEN '2' #部門
                     LET g_qryparam.where = "ooegstus='Y'"
                     CALL q_ooeg001_4()
                  WHEN '3' #利潤/成本中心
                     LET g_qryparam.where = "ooegstus='Y' AND ooeg003 IN ('1','2','3')"
                     CALL q_ooeg001_4() 
                  WHEN '4' #區域
                     LET g_qryparam.arg1 = '287'
                     CALL q_oocq002_287()  
                  WHEN '5' #交易客商
                     #CALL q_pmaa001()    #160920-00019#4--mark
                     CALL q_pmaa001_25()  #160920-00019#4--add 
                  WHEN '6' #帳款客戶
                     #CALL q_pmaa001()    #160920-00019#4--mark
                     CALL q_pmaa001_25()  #160920-00019#4--add
                  WHEN '7' #客群
                     CALL q_oocq002_281() 
                  WHEN '8' #產品類別
                     CALL q_rtax001_1() 
                  WHEN '9' #經營方式
                     LET g_qryparam.arg1 = '6013'
                     CALL q_gzcb001()
                  WHEN '10' #渠道
                     CALL q_oojd001_2()
                  WHEN '11' #品牌
                     CALL q_oocq002_2002() 
                  WHEN '12' #人員
                     CALL q_ooag001_8()
                  WHEN '13' #專案
                     CALL q_pjba001()
                  WHEN '14' #WBS
                     LET g_qryparam.where = "pjbb012='1' "
                     CALL q_pjbb002()
                  WHEN '15' #自由核算項一
                     CALL q_glar024()
                  WHEN '16' #自由核算項二
                     CALL q_glar025()
                  WHEN '17' #自由核算項三
                     CALL q_glar026()
                  WHEN '18' #自由核算項四
                     CALL q_glar027()
                  WHEN '19' #自由核算項五
                     CALL q_glar028()
                  WHEN '20' #自由核算項六
                     CALL q_glar029()
                  WHEN '21' #自由核算項七
                     CALL q_glar030()
                  WHEN '22' #自由核算項八
                     CALL q_glar031()
                  WHEN '23' #自由核算項九
                     CALL q_glar032()
                  WHEN '24' #自由核算項十
                     CALL q_glar033()
               END CASE
               LET g_input.l_cond = g_qryparam.return1
               DISPLAY BY NAME g_input.l_cond   #顯示到畫面上
               NEXT FIELD l_cond
      END INPUT
      
      BEFORE DIALOG
         CALL abgq054_qbe_clear()
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
         CALL abgq054_qbe_clear()
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
   #重新construct
   CONSTRUCT g_wc ON bgbc007,l_cond FROM l_bgbc007,l_cond
      BEFORE CONSTRUCT

         IF cl_null(g_input.l_cond) OR cl_null(g_input.l_condtype) THEN LET g_input.l_cond = '*' END IF
         DISPLAY BY NAME g_input.l_bgbc007,g_input.l_cond
         EXIT CONSTRUCT
   END CONSTRUCT

   CALL cl_set_comp_visible('l_cond2,l_cond2_desc',TRUE)
   IF cl_null(g_input.l_condtype)THEN
      CALL cl_set_comp_visible('l_cond2,l_cond2_desc',FALSE)   
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL abgq054_b_fill()
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
 
{<section id="abgq054.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq054_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_title  DYNAMIC ARRAY OF RECORD
                   a  LIKE type_t.chr100,
                   b  LIKE type_t.chr100
                   END RECORD
   DEFINE l_str    STRING
   DEFINE l_i      LIKE type_t.num5
   DEFINE l_sql    STRING
   DEFINE l_gzzd005  LIKE gzzd_t.gzzd005
   DEFINE l_str2   LIKE   type_t.chr100
   DEFINE l_bgbcsum RECORD
             l_sum1 LIKE type_t.num20_6, 
             l_sum2 LIKE type_t.num20_6, 
             l_sum3 LIKE type_t.num20_6, 
             l_sum4 LIKE type_t.num20_6, 
             l_sum5 LIKE type_t.num20_6, 
             l_sum6 LIKE type_t.num20_6, 
             l_sum7 LIKE type_t.num20_6, 
             l_sum8 LIKE type_t.num20_6, 
             l_sum9 LIKE type_t.num20_6, 
             l_sum10 LIKE type_t.num20_6, 
             l_sum11 LIKE type_t.num20_6, 
             l_sum12 LIKE type_t.num20_6, 
             l_sum13 LIKE type_t.num20_6, 
             l_sumall LIKE type_t.num20_6    
                    END RECORD
   DEFINE l_glarsum RECORD
             l_sum1 LIKE type_t.num20_6, 
             l_sum2 LIKE type_t.num20_6, 
             l_sum3 LIKE type_t.num20_6, 
             l_sum4 LIKE type_t.num20_6, 
             l_sum5 LIKE type_t.num20_6, 
             l_sum6 LIKE type_t.num20_6, 
             l_sum7 LIKE type_t.num20_6, 
             l_sum8 LIKE type_t.num20_6, 
             l_sum9 LIKE type_t.num20_6, 
             l_sum10 LIKE type_t.num20_6, 
             l_sum11 LIKE type_t.num20_6, 
             l_sum12 LIKE type_t.num20_6, 
             l_sum13 LIKE type_t.num20_6, 
             l_sumall LIKE type_t.num20_6    
                    END RECORD
   DEFINE l_wc_tmp STRING
   DEFINE l_lastmon LIKE type_t.num5
   
   #albireo 1604 #160425-00020#1-----s
   DEFINE l_bgaa008   LIKE bgaa_t.bgaa008
   DEFINE l_type    RECORD
                    sumtype   LIKE type_t.chr1,
                    sourcetype LIKE type_t.chr1
                    END RECORD
   DEFINE l_lsjs    STRING
   #albireo 1604 #160425-00020#1-----e
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','',bgbc007,'','','','','','','','','','','','','','','','','', 
       '','','','','','','',bgbc001,bgbc002,bgbc003,bgbc004,''  ,DENSE_RANK() OVER( ORDER BY bgbc_t.bgbc001, 
       bgbc_t.bgbc002,bgbc_t.bgbc003,bgbc_t.bgbc004,bgbc_t.bgbc006,bgbc_t.bgbc007) AS RANK FROM bgbc_t", 
 
 
 
                     "",
                     " WHERE bgbcent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("bgbc_t"),
                     " ORDER BY bgbc_t.bgbc001,bgbc_t.bgbc002,bgbc_t.bgbc003,bgbc_t.bgbc004,bgbc_t.bgbc006,bgbc_t.bgbc007"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #albireo 1604 #160425-00020#1-----s
   LET l_bgaa008 = NULL
   SELECT bgaa008 INTO l_bgaa008 FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_input.l_bgaa001
   #albireo 1604 #160425-00020#1-----e
   
   #處理單身title
   LET l_title[1].a = 'l_bgbdsum1'   LET l_title[2].a = 'l_glarsum1'   
   LET l_title[3].a = 'l_diff1'   LET l_title[4].a = 'l_rate1'
   LET l_title[1].b = 'l_bgbdsum2'   LET l_title[2].b = 'l_glarsum2'
   LET l_title[3].b = 'l_diff2'   LET l_title[4].b = 'l_rate2'
   
   
   LET l_sql = "SELECT gzzd005 FROM gzzd_t",
               " WHERE gzzd001 = ? AND gzzd002 = '",g_lang,"'",
               "   AND gzzd003 = ? AND gzzdstus = 'Y'"
   PREPARE get_title_pre FROM l_sql
   FOR l_i =1 TO 4 
      CASE
         WHEN g_input.l_sumtype = '1'
            #1   2015/11期XXX
            LET l_str = g_input.l_yy2 USING '&&&&','/',g_input.l_mm2 USING '&&',cl_getmsg('abg-00121',g_dlang) CLIPPED
            LET l_str2 = "lbl_",l_title[l_i].a
            EXECUTE get_title_pre USING g_prog,l_str2 INTO l_gzzd005
            LET l_str = l_str CLIPPED,l_gzzd005
            CALL cl_set_comp_att_text(l_title[l_i].a,l_str)
            
            #2   2015/10~2015/11期XXX
            LET l_str = g_input.l_yy1 USING '&&&&','/',g_input.l_mm1 USING '&&','~',g_input.l_yy2 USING '&&&&','/',g_input.l_mm2 USING '&&',cl_getmsg('abg-00121',g_dlang) CLIPPED
            LET l_str2 = "lbl_",l_title[l_i].b
            EXECUTE get_title_pre USING g_prog,l_str2 INTO l_gzzd005
            LET l_str = l_str CLIPPED,l_gzzd005
            CALL cl_set_comp_att_text(l_title[l_i].b,l_str)
                 
         OTHERWISE
            #1#2   2015/0~2015/11期XXX
            LET l_str = g_input.l_yy1 USING '&&&&','/0~',g_input.l_yy2 USING '&&&&','/',g_input.l_mm2 USING '&&',cl_getmsg('abg-00121',g_dlang) CLIPPED
            LET l_str2 = "lbl_",l_title[l_i].a
            EXECUTE get_title_pre USING g_prog,l_str2 INTO l_gzzd005
            LET l_str = l_str CLIPPED,l_gzzd005
            CALL cl_set_comp_att_text(l_title[l_i].a,l_str)   
            LET l_str2 = "lbl_",l_title[l_i].b
            EXECUTE get_title_pre USING g_prog,l_str2 INTO l_gzzd005
            LET l_str = l_str CLIPPED,l_gzzd005
            CALL cl_set_comp_att_text(l_title[l_i].b,l_str)            
      END CASE
   END FOR
   
   #CALL abgq054_ins_tmp()
   SELECT MAX(bgac004) INTO l_lastmon
     FROM bgac_t,bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_input.l_bgaa001
      AND bgaaent = bgacent
      AND bgaa002 = bgac001    
   
   IF l_lastmon > 12 THEN 
      LET l_lastmon = 13
   ELSE
      LET l_lastmon = 12
   END IF
   CALL cl_set_comp_visible('l_sum13',TRUE)
   IF l_lastmon = '12' THEN
      CALL cl_set_comp_visible('l_sum13',FALSE)    
   END IF
   
   #LET l_wc_tmp = " bgbc006 BETWEEN '1' AND '",l_lastmon,"' "   ##151207-00009#2 mark
   LET l_wc_tmp = " BETWEEN '1' AND '",l_lastmon,"' "   #albireo 151207   ##151207-00009#2
 
   #albireo 1604 #160425-00020#1-----s
#   CALL s_abgq053_ins_tmp(g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_ld,g_input.l_yy2,
#                          g_input.l_condtype,g_input.l_withbgbd,l_wc_tmp,
#                          g_input.l_sumtype)   ##151207-00009#4 add   
   LET l_type.sumtype = g_input.l_sumtype
   LET l_type.sourcetype = g_input.l_ogtype
   
   LET l_lsjs = util.JSON.stringify(l_type)
   CALL s_abgq053_ins_tmp2(g_input.l_bgaa001,g_input.l_bgbc002,g_input.l_bgbc003,g_input.l_ld,g_input.l_yy2,
                          g_input.l_condtype,g_input.l_withbgbd,l_wc_tmp,
                          l_lsjs)
   #albireo 1604 #160425-00020#1-----e
   CALL abgq054_ins_tmp2()
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
 
   LET g_sql = "SELECT '','',bgbc007,'','','','','','','','','','','','','','','','','','','','','', 
       '','','',bgbc001,bgbc002,bgbc003,bgbc004,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET g_sql = "SELECT l_cond,'',bgbc007,'', ",
#               "       '',0,0,0,0,0, 0,0,0,0,0, 0,0,0,0,",
#               "       '','','','','','','','','','','','' ",
#               " FROM s_abgq054_tmp1 ",
#               " WHERE ent = ? ",
#               "   AND ",g_wc CLIPPED,
#               " GROUP BY bgbc007,l_cond"
    LET g_sql = "SELECT l_cond,'',bgbc007,'', ",
                "       l_rowtype,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5, l_sum6,l_sum7,l_sum8,l_sum9,l_sum10, l_sum11,l_sum12,l_sum13,l_sumall,",
                "       '','','','','','','','','','','','' ",
                "      ,acc ",   #albireo 1604 #160425-00020#1
                " FROM abgq054_tmp1 ",
                " WHERE ent = ? ",
                "   AND ",g_wc CLIPPED,
                "   AND bgbc007 <> 'abgq054sum' ",
                " ORDER BY l_cond,bgbc007,acc,l_rowtype"   #albireo 1604 #160425-00020#1
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abgq054_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abgq054_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_bgbc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_bgbc_d[l_ac].l_cond2,g_bgbc_d[l_ac].l_cond2_desc,g_bgbc_d[l_ac].bgbc007, 
       g_bgbc_d[l_ac].bgbc007_desc,g_bgbc_d[l_ac].l_rowtype,g_bgbc_d[l_ac].l_sum1,g_bgbc_d[l_ac].l_sum2, 
       g_bgbc_d[l_ac].l_sum3,g_bgbc_d[l_ac].l_sum4,g_bgbc_d[l_ac].l_sum5,g_bgbc_d[l_ac].l_sum6,g_bgbc_d[l_ac].l_sum7, 
       g_bgbc_d[l_ac].l_sum8,g_bgbc_d[l_ac].l_sum9,g_bgbc_d[l_ac].l_sum10,g_bgbc_d[l_ac].l_sum11,g_bgbc_d[l_ac].l_sum12, 
       g_bgbc_d[l_ac].l_sum13,g_bgbc_d[l_ac].l_sumall,g_bgbc_d[l_ac].l_bgbdsum1,g_bgbc_d[l_ac].l_glarsum1, 
       g_bgbc_d[l_ac].l_diff1,g_bgbc_d[l_ac].l_rate1,g_bgbc_d[l_ac].l_bgbdsum2,g_bgbc_d[l_ac].l_glarsum2, 
       g_bgbc_d[l_ac].l_diff2,g_bgbc_d[l_ac].l_rate2,g_bgbc_d[l_ac].bgbc001,g_bgbc_d[l_ac].bgbc002,g_bgbc_d[l_ac].bgbc003, 
       g_bgbc_d[l_ac].bgbc004,g_bgbc_d[l_ac].l_acc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_bgbc_d[l_ac].statepic = cl_get_actipic(g_bgbc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_bgbc_d[l_ac].l_acc = 'Y' THEN  #albireo 1604 #160425-00020#1
         CALL s_desc_get_account_desc(g_input.l_ld,g_bgbc_d[l_ac].bgbc007)RETURNING g_bgbc_d[l_ac].bgbc007_desc
         LET g_bgbc_d[l_ac].bgbc007_desc = '*',g_bgbc_d[l_ac].bgbc007_desc
      ELSE
         CALL s_abg_bgae001_desc(l_bgaa008,g_bgbc_d[l_ac].bgbc007)RETURNING g_bgbc_d[l_ac].bgbc007_desc
      END IF
      CALL s_merge_source_desc(g_input.l_condtype,g_bgbc_d[l_ac].l_cond2)RETURNING g_bgbc_d[l_ac].l_cond2_desc
      IF g_bgbc_d[l_ac].l_rowtype <> '1' THEN
         LET g_bgbc_d[l_ac].l_cond2      = ''
         LET g_bgbc_d[l_ac].l_cond2_desc = ''
         LET g_bgbc_d[l_ac].bgbc007      = ''
         LET g_bgbc_d[l_ac].bgbc007_desc = ''
      END IF
      #end add-point
 
      CALL abgq054_detail_show("'1'")      
 
      CALL abgq054_bgbc_t_mask()
 
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
   
 
   
   CALL g_bgbc_d.deleteElement(g_bgbc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
#    LET g_sql = "SELECT l_cond,'',bgbc007,'', ",
#                "       l_rowtype,l_sum1,l_sum2,l_sum3,l_sum4,l_sum5, l_sum6,l_sum7,l_sum8,l_sum9,l_sum10, l_sum11,l_sum12,l_sum13,l_sumall,",
#                "       '','','','','','','','','','','','' ",
#                " FROM abgq054_tmp1 ",
#                " WHERE ent = ? ",
#                "   AND ",g_wc CLIPPED,
#                "   AND bgbc007 = 'abgq054sum' ",
#                " ORDER BY l_cond,bgbc007,l_rowtype"
#   PREPARE abgq054_pb2 FROM g_sql
#   DECLARE b_fill_curs2 CURSOR FOR abgq054_pb2
#   
#   OPEN b_fill_curs2 USING g_enterprise 
#      
#   FOREACH b_fill_curs2 INTO g_bgbc_d[l_ac].l_cond2,g_bgbc_d[l_ac].l_cond2_desc,g_bgbc_d[l_ac].bgbc007, 
#       g_bgbc_d[l_ac].bgbc007_desc,g_bgbc_d[l_ac].l_rowtype,g_bgbc_d[l_ac].l_sum1,g_bgbc_d[l_ac].l_sum2, 
#       g_bgbc_d[l_ac].l_sum3,g_bgbc_d[l_ac].l_sum4,g_bgbc_d[l_ac].l_sum5,g_bgbc_d[l_ac].l_sum6,g_bgbc_d[l_ac].l_sum7, 
#       g_bgbc_d[l_ac].l_sum8,g_bgbc_d[l_ac].l_sum9,g_bgbc_d[l_ac].l_sum10,g_bgbc_d[l_ac].l_sum11,g_bgbc_d[l_ac].l_sum12, 
#       g_bgbc_d[l_ac].l_sum13,g_bgbc_d[l_ac].l_sumall,g_bgbc_d[l_ac].l_bgbdsum1,g_bgbc_d[l_ac].l_glarsum1, 
#       g_bgbc_d[l_ac].l_diff1,g_bgbc_d[l_ac].l_rate1,g_bgbc_d[l_ac].l_bgbdsum2,g_bgbc_d[l_ac].l_glarsum2, 
#       g_bgbc_d[l_ac].l_diff2,g_bgbc_d[l_ac].l_rate2,g_bgbc_d[l_ac].bgbc001,g_bgbc_d[l_ac].bgbc002,g_bgbc_d[l_ac].bgbc003, 
#       g_bgbc_d[l_ac].bgbc004
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      LET g_bgbc_d[l_ac].bgbc007 = ''
#      LET g_bgbc_d[l_ac].bgbc007_desc = cl_getmsg('aps-00134',g_dlang)
#      IF g_bgbc_d[l_ac].l_rowtype <> '1' THEN
#         LET g_bgbc_d[l_ac].l_cond2      = ''
#         LET g_bgbc_d[l_ac].l_cond2_desc = ''
#         LET g_bgbc_d[l_ac].bgbc007      = ''
#         LET g_bgbc_d[l_ac].bgbc007_desc = ''
#      END IF      
#      LET l_ac = l_ac + 1
#      
#   END FOREACH
   
   LET l_sql = "SELECT ",
                "       SUM(l_sum1),SUM(l_sum2),SUM(l_sum3),SUM(l_sum4),SUM(l_sum5),SUM(l_sum6),",
                "       SUM(l_sum7),SUM(l_sum8),SUM(l_sum9),SUM(l_sum10),SUM(l_sum11),SUM(l_sum12),",
                "       SUM(l_sum13),SUM(l_sumall) ",
                "  FROM abgq054_tmp1 ",
                " WHERE ",g_wc CLIPPED,
                "   AND l_rowtype = ? "
   PREPARE sel_tmpp4 FROM l_sql
   IF l_ac > 1 THEN
      #合計
      EXECUTE sel_tmpp4 USING '1' INTO l_bgbcsum.*
      EXECUTE sel_tmpp4 USING '2' INTO l_glarsum.*
      
      #預算數      
      LET g_bgbc_d[l_ac].l_cond2 = ''
      LET g_bgbc_d[l_ac].l_cond2_desc = ''
      LET g_bgbc_d[l_ac].bgbc007 = ''
      LET g_bgbc_d[l_ac].bgbc007_desc = cl_getmsg('aps-00134',g_dlang)
      LET g_bgbc_d[l_ac].l_rowtype = '1' 
      LET g_bgbc_d[l_ac].l_sum1   = l_bgbcsum.l_sum1
      LET g_bgbc_d[l_ac].l_sum2   = l_bgbcsum.l_sum2
      LET g_bgbc_d[l_ac].l_sum3   = l_bgbcsum.l_sum3
      LET g_bgbc_d[l_ac].l_sum4   = l_bgbcsum.l_sum4
      LET g_bgbc_d[l_ac].l_sum5   = l_bgbcsum.l_sum5
      LET g_bgbc_d[l_ac].l_sum6   = l_bgbcsum.l_sum6
      LET g_bgbc_d[l_ac].l_sum7   = l_bgbcsum.l_sum7
      LET g_bgbc_d[l_ac].l_sum8   = l_bgbcsum.l_sum8
      LET g_bgbc_d[l_ac].l_sum9   = l_bgbcsum.l_sum9
      LET g_bgbc_d[l_ac].l_sum10  = l_bgbcsum.l_sum10
      LET g_bgbc_d[l_ac].l_sum11  = l_bgbcsum.l_sum11
      LET g_bgbc_d[l_ac].l_sum12  = l_bgbcsum.l_sum12 
      LET g_bgbc_d[l_ac].l_sum13  = l_bgbcsum.l_sum13
      LET g_bgbc_d[l_ac].l_sumall = l_bgbcsum.l_sumall      
      LET l_ac = l_ac + 1
      
      #實際數
      LET g_bgbc_d[l_ac].l_cond2 = ''
      LET g_bgbc_d[l_ac].l_cond2_desc = ''
      LET g_bgbc_d[l_ac].bgbc007 = ''
      LET g_bgbc_d[l_ac].bgbc007_desc = ''
      LET g_bgbc_d[l_ac].l_rowtype = '2' 
      LET g_bgbc_d[l_ac].l_sum1   = l_glarsum.l_sum1
      LET g_bgbc_d[l_ac].l_sum2   = l_glarsum.l_sum2
      LET g_bgbc_d[l_ac].l_sum3   = l_glarsum.l_sum3
      LET g_bgbc_d[l_ac].l_sum4   = l_glarsum.l_sum4
      LET g_bgbc_d[l_ac].l_sum5   = l_glarsum.l_sum5
      LET g_bgbc_d[l_ac].l_sum6   = l_glarsum.l_sum6
      LET g_bgbc_d[l_ac].l_sum7   = l_glarsum.l_sum7
      LET g_bgbc_d[l_ac].l_sum8   = l_glarsum.l_sum8
      LET g_bgbc_d[l_ac].l_sum9   = l_glarsum.l_sum9
      LET g_bgbc_d[l_ac].l_sum10  = l_glarsum.l_sum10
      LET g_bgbc_d[l_ac].l_sum11  = l_glarsum.l_sum11
      LET g_bgbc_d[l_ac].l_sum12  = l_glarsum.l_sum12 
      LET g_bgbc_d[l_ac].l_sum13  = l_glarsum.l_sum13
      LET g_bgbc_d[l_ac].l_sumall = l_glarsum.l_sumall      
      LET l_ac = l_ac + 1
      
      #差異數
      LET g_bgbc_d[l_ac].l_cond2 = ''
      LET g_bgbc_d[l_ac].l_cond2_desc = ''
      LET g_bgbc_d[l_ac].bgbc007 = ''
      LET g_bgbc_d[l_ac].bgbc007_desc = ''
      LET g_bgbc_d[l_ac].l_rowtype = '3' 
      LET g_bgbc_d[l_ac].l_sum1   = l_bgbcsum.l_sum1  - l_glarsum.l_sum1
      LET g_bgbc_d[l_ac].l_sum2   = l_bgbcsum.l_sum2  - l_glarsum.l_sum2
      LET g_bgbc_d[l_ac].l_sum3   = l_bgbcsum.l_sum3  - l_glarsum.l_sum3
      LET g_bgbc_d[l_ac].l_sum4   = l_bgbcsum.l_sum4  - l_glarsum.l_sum4
      LET g_bgbc_d[l_ac].l_sum5   = l_bgbcsum.l_sum5  - l_glarsum.l_sum5
      LET g_bgbc_d[l_ac].l_sum6   = l_bgbcsum.l_sum6  - l_glarsum.l_sum6
      LET g_bgbc_d[l_ac].l_sum7   = l_bgbcsum.l_sum7  - l_glarsum.l_sum7
      LET g_bgbc_d[l_ac].l_sum8   = l_bgbcsum.l_sum8  - l_glarsum.l_sum8
      LET g_bgbc_d[l_ac].l_sum9   = l_bgbcsum.l_sum9  - l_glarsum.l_sum9
      LET g_bgbc_d[l_ac].l_sum10  = l_bgbcsum.l_sum10 - l_glarsum.l_sum10
      LET g_bgbc_d[l_ac].l_sum11  = l_bgbcsum.l_sum11 - l_glarsum.l_sum11
      LET g_bgbc_d[l_ac].l_sum12  = l_bgbcsum.l_sum12 - l_glarsum.l_sum12 
      LET g_bgbc_d[l_ac].l_sum13  = l_bgbcsum.l_sum13 - l_glarsum.l_sum13
      LET g_bgbc_d[l_ac].l_sumall = l_bgbcsum.l_sumall- l_glarsum.l_sumall      
      LET l_ac = l_ac + 1
      
      #比率%
      LET g_bgbc_d[l_ac].l_cond2 = ''
      LET g_bgbc_d[l_ac].l_cond2_desc = ''
      LET g_bgbc_d[l_ac].bgbc007 = ''
      LET g_bgbc_d[l_ac].bgbc007_desc = ''
      LET g_bgbc_d[l_ac].l_rowtype = '4' 
      IF l_bgbcsum.l_sum1 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum1 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum1   = (l_bgbcsum.l_sum1 - l_glarsum.l_sum1)  / l_bgbcsum.l_sum1   * 100 
      END IF
      IF l_bgbcsum.l_sum2 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum2 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum2   = (l_bgbcsum.l_sum2 - l_glarsum.l_sum1)  / l_bgbcsum.l_sum2   * 100 
      END IF
      IF l_bgbcsum.l_sum3 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum3 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum3   = (l_bgbcsum.l_sum3 - l_glarsum.l_sum3)  / l_bgbcsum.l_sum3   * 100 
      END IF
      IF l_bgbcsum.l_sum4 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum4 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum4   = (l_bgbcsum.l_sum4 - l_glarsum.l_sum4)  / l_bgbcsum.l_sum4   * 100 
      END IF
      IF l_bgbcsum.l_sum5 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum5 = 0
      ELSE      
         LET g_bgbc_d[l_ac].l_sum5   = (l_bgbcsum.l_sum5 - l_glarsum.l_sum5)  / l_bgbcsum.l_sum5   * 100 
      END IF
      IF l_bgbcsum.l_sum6 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum6 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum6   = (l_bgbcsum.l_sum6 - l_glarsum.l_sum6)  / l_bgbcsum.l_sum6   * 100 
      END IF
      IF l_bgbcsum.l_sum7 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum7 = 0
      ELSE      
         LET g_bgbc_d[l_ac].l_sum7   = (l_bgbcsum.l_sum7 - l_glarsum.l_sum7) / l_bgbcsum.l_sum7   * 100 
      END IF
      IF l_bgbcsum.l_sum8 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum8 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum8   = (l_bgbcsum.l_sum8 - l_glarsum.l_sum8) / l_bgbcsum.l_sum8   * 100 
      END IF
      IF l_bgbcsum.l_sum9 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum9 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum9   = (l_bgbcsum.l_sum9 - l_glarsum.l_sum9)  / l_bgbcsum.l_sum9   * 100 
      END IF
      IF l_bgbcsum.l_sum10 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum10 = 0
      ELSE      
         LET g_bgbc_d[l_ac].l_sum10  = (l_bgbcsum.l_sum10 - l_glarsum.l_sum10) / l_bgbcsum.l_sum10   * 100 
      END IF
      IF l_bgbcsum.l_sum11 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum11 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum11  = (l_bgbcsum.l_sum11 - l_glarsum.l_sum11) / l_bgbcsum.l_sum11   * 100 
      END IF
      IF l_bgbcsum.l_sum12 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum12 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum12  = (l_bgbcsum.l_sum12 - l_glarsum.l_sum12) / l_bgbcsum.l_sum12    * 100 
      END IF
      IF l_bgbcsum.l_sum13 = 0 THEN
         LET g_bgbc_d[l_ac].l_sum13 = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sum13  = (l_bgbcsum.l_sum13 - l_glarsum.l_sum13) / l_bgbcsum.l_sum13    * 100 
      END IF
      IF l_bgbcsum.l_sumall = 0 THEN
         LET g_bgbc_d[l_ac].l_sumall = 0
      ELSE
         LET g_bgbc_d[l_ac].l_sumall = (l_bgbcsum.l_sumall - l_glarsum.l_sumall)/ l_bgbcsum.l_sumall  * 100    
      END IF
      LET l_ac = l_ac + 1
   END IF

   LET g_tot_cnt = g_bgbc_d.getLength()
   #end add-point
 
   LET g_detail_cnt = g_bgbc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE abgq054_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq054_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq054_detail_action_trans()
 
   IF g_bgbc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL abgq054_fetch()
   END IF
   
      CALL abgq054_filter_show('bgbc007','b_bgbc007')
   CALL abgq054_filter_show('bgbc001','b_bgbc001')
   CALL abgq054_filter_show('bgbc002','b_bgbc002')
   CALL abgq054_filter_show('bgbc003','b_bgbc003')
   CALL abgq054_filter_show('bgbc004','b_bgbc004')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq054_fetch()
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
 
{<section id="abgq054.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq054_detail_show(ps_page)
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
      
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abgq054_filter()
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
      CONSTRUCT g_wc_filter ON bgbc007,bgbc001,bgbc002,bgbc003,bgbc004
                          FROM s_detail1[1].b_bgbc007,s_detail1[1].b_bgbc001,s_detail1[1].b_bgbc002, 
                              s_detail1[1].b_bgbc003,s_detail1[1].b_bgbc004
 
         BEFORE CONSTRUCT
                     DISPLAY abgq054_filter_parser('bgbc007') TO s_detail1[1].b_bgbc007
            DISPLAY abgq054_filter_parser('bgbc001') TO s_detail1[1].b_bgbc001
            DISPLAY abgq054_filter_parser('bgbc002') TO s_detail1[1].b_bgbc002
            DISPLAY abgq054_filter_parser('bgbc003') TO s_detail1[1].b_bgbc003
            DISPLAY abgq054_filter_parser('bgbc004') TO s_detail1[1].b_bgbc004
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<l_cond2>>----
         #----<<l_cond2_desc>>----
         #----<<b_bgbc007>>----
         #Ctrlp:construct.c.filter.page1.b_bgbc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc007
            #add-point:ON ACTION controlp INFIELD b_bgbc007 name="construct.c.filter.page1.b_bgbc007"
            
            #END add-point
 
 
         #----<<bgbc007_desc>>----
         #----<<l_rowtype>>----
         #----<<l_sum1>>----
         #----<<l_sum2>>----
         #----<<l_sum3>>----
         #----<<l_sum4>>----
         #----<<l_sum5>>----
         #----<<l_sum6>>----
         #----<<l_sum7>>----
         #----<<l_sum8>>----
         #----<<l_sum9>>----
         #----<<l_sum10>>----
         #----<<l_sum11>>----
         #----<<l_sum12>>----
         #----<<l_sum13>>----
         #----<<l_sumall>>----
         #----<<l_bgbdsum1>>----
         #----<<l_glarsum1>>----
         #----<<l_diff1>>----
         #----<<l_rate1>>----
         #----<<l_bgbdsum2>>----
         #----<<l_glarsum2>>----
         #----<<l_diff2>>----
         #----<<l_rate2>>----
         #----<<b_bgbc001>>----
         #Ctrlp:construct.c.filter.page1.b_bgbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc001
            #add-point:ON ACTION controlp INFIELD b_bgbc001 name="construct.c.filter.page1.b_bgbc001"
            
            #END add-point
 
 
         #----<<b_bgbc002>>----
         #Ctrlp:construct.c.filter.page1.b_bgbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc002
            #add-point:ON ACTION controlp INFIELD b_bgbc002 name="construct.c.filter.page1.b_bgbc002"
            
            #END add-point
 
 
         #----<<b_bgbc003>>----
         #Ctrlp:construct.c.filter.page1.b_bgbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc003
            #add-point:ON ACTION controlp INFIELD b_bgbc003 name="construct.c.filter.page1.b_bgbc003"
            
            #END add-point
 
 
         #----<<b_bgbc004>>----
         #Ctrlp:construct.c.filter.page1.b_bgbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bgbc004
            #add-point:ON ACTION controlp INFIELD b_bgbc004 name="construct.c.filter.page1.b_bgbc004"
            
            #END add-point
 
 
         #----<<l_acc>>----
   
 
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
   
      CALL abgq054_filter_show('bgbc007','b_bgbc007')
   CALL abgq054_filter_show('bgbc001','b_bgbc001')
   CALL abgq054_filter_show('bgbc002','b_bgbc002')
   CALL abgq054_filter_show('bgbc003','b_bgbc003')
   CALL abgq054_filter_show('bgbc004','b_bgbc004')
 
    
   CALL abgq054_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abgq054_filter_parser(ps_field)
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
 
{<section id="abgq054.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abgq054_filter_show(ps_field,ps_object)
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
   LET ls_condition = abgq054_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.insert" >}
#+ insert
PRIVATE FUNCTION abgq054_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgq054.modify" >}
#+ modify
PRIVATE FUNCTION abgq054_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.reproduce" >}
#+ reproduce
PRIVATE FUNCTION abgq054_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.delete" >}
#+ delete
PRIVATE FUNCTION abgq054_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abgq054.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq054_detail_action_trans()
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
 
{<section id="abgq054.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq054_detail_index_setting()
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
            IF g_bgbc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_bgbc_d.getLength() AND g_bgbc_d.getLength() > 0
            LET g_detail_idx = g_bgbc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_bgbc_d.getLength() THEN
               LET g_detail_idx = g_bgbc_d.getLength()
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
 
{<section id="abgq054.mask_functions" >}
 &include "erp/abg/abgq054_mask.4gl"
 
{</section>}
 
{<section id="abgq054.other_function" readonly="Y" >}

PRIVATE FUNCTION abgq054_qbe_clear()
   INITIALIZE g_input.* TO NULL 
   LET g_input.l_ogtype ='1'
   LET g_input.l_withbgbd = 'Y'   #160127-00033#3   N >>>> Y             
   LET g_input.l_yy1 = YEAR(g_today)        
   LET g_input.l_mm1 = MONTH(g_today)
   LET g_input.l_yy2 = YEAR(g_today) 
   LET g_input.l_mm2 = MONTH(g_today)            
   LET g_input.l_sumtype = '1'
END FUNCTION

PRIVATE FUNCTION abgq054_bgbc_chk(p_bgbc001,p_bgbc002,p_bgbc003)
DEFINE p_bgbc001   LIKE bgbc_t.bgbc001
DEFINE p_bgbc002   LIKE bgbc_t.bgbc002
DEFINE p_bgbc003   LIKE bgbc_t.bgbc003
DEFINE l_count     LIKE type_t.num5
DEFINE l_ooefstus  LIKE ooef_t.ooefstus
DEFINE r_success   LIKE type_t.num5
DEFINE r_errno     LIKE gzze_t.gzze001
 
   LET r_errno = NULL   LET r_success = TRUE   LET l_ooefstus = NULL
  
  #單獨檢查組織
   IF NOT cl_null(p_bgbc003)THEN 
      SELECT ooefstus INTO l_ooefstus
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = p_bgbc003

  　   IF SQLCA.SQLCODE = '100' THEN
          LET r_success = FALSE
          LET r_errno =　'aoo-00094'
          RETURN r_success,r_errno
  　   END IF

       IF l_ooefstus != 'Y' THEN
          LET r_success = FALSE
          #LET r_errno = 'aoo-00095'  #160318-00005#4 mark
          LET r_errno = 'sub-01302'   #160318-00005#4 add
          RETURN r_success,r_errno  
       END IF
   END IF
   
   #單獨檢查預算編號
   IF NOT cl_null(p_bgbc001) THEN
      SELECT COUNT(*) INTO l_count
        FROM bgaa_t
       WHERE bgaaent = g_enterprise AND bgaastus = 'Y'
         AND bgaa001 = p_bgbc001
         #AND bgaa012 ='Y'  #使用科目預算   #albireo 1604 mark #160425-00020#1
         
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00116'
         RETURN r_success,r_errno
      END IF
   END IF
     
   #檢查預算編號下的組織
   IF NOT cl_null(p_bgbc001) AND NOT cl_null(p_bgbc003) THEN  
       CALL s_abg_site_chk(p_bgbc003)RETURNING g_sub_success,g_errno
       IF NOT g_sub_success THEN
          LET r_success = FALSE
          LET r_errno  = g_errno
          RETURN r_success,r_errno
      END IF
   END IF
   
   #檢查編號/版本是否符合
   IF NOT cl_null(p_bgbc001) AND NOT cl_null(p_bgbc002) THEN 
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM bgbc_t
       WHERE bgbcent = g_enterprise
         AND bgbc001 = p_bgbc001
         AND bgbc002 = p_bgbc002
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00117'
         RETURN r_success,r_errno
      END IF   
   END IF
   
   #檢核版本/編號/項目 是否符合
   IF NOT cl_null(p_bgbc001) AND NOT cl_null(p_bgbc003) AND NOT cl_null(p_bgbc002) THEN  
      LET l_count = 0
      SELECT COUNT(*) INTO l_count
        FROM bgbc_t
       WHERE bgbcent = g_enterprise
         AND bgbc001 = p_bgbc001
         AND bgbc002 = p_bgbc002
         AND bgbc003 = p_bgbc003  
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'abg-00117'
         RETURN r_success,r_errno
      END IF
   
   END IF
  
   RETURN r_success,r_errno
END FUNCTION

PRIVATE FUNCTION abgq054_cre_tmp()
#   DROP TABLE s_abgq054_tmp1
#   CREATE TEMP TABLE s_abgq054_tmp1(
#      bgbc007   LIKE bgbc_t.bgbc007,
#      bgbc006   LIKE bgbc_t.bgbc006,
#      l_cond    LIKE type_t.chr1000,      
#      bgbcsum   LIKE type_t.num20_6,
#      glarsum   LIKE type_t.num20_6,
#      diffsum   LIKE type_t.num20_6,
#      ent       LIKE type_t.num5
#   )
#   
   
   #151123 albireo -----s
   DROP TABLE abgq054_tmp1
   CREATE TEMP TABLE abgq054_tmp1(   
      l_cond LIKE type_t.chr500, 
      bgbc007 LIKE bgbc_t.bgbc007,  
      l_rowtype LIKE type_t.chr500, 
      l_sum1 LIKE type_t.num20_6, 
      l_sum2 LIKE type_t.num20_6, 
      l_sum3 LIKE type_t.num20_6, 
      l_sum4 LIKE type_t.num20_6, 
      l_sum5 LIKE type_t.num20_6, 
      l_sum6 LIKE type_t.num20_6, 
      l_sum7 LIKE type_t.num20_6, 
      l_sum8 LIKE type_t.num20_6, 
      l_sum9 LIKE type_t.num20_6, 
      l_sum10 LIKE type_t.num20_6, 
      l_sum11 LIKE type_t.num20_6, 
      l_sum12 LIKE type_t.num20_6, 
      l_sum13 LIKE type_t.num20_6, 
      l_sumall LIKE type_t.num20_6, 
      ent     LIKE type_t.num5,
      acc     LIKE type_t.chr1   #albireo 1604 #160425-00020#1
   )
   #151123 albireo -----e
END FUNCTION

PRIVATE FUNCTION abgq054_ins_tmp()
#   DEFINE l_sql   STRING
#   DEFINE l_group   STRING
#   DEFINE l_tmp     RECORD
#                    bgbc007   LIKE bgbc_t.bgbc007,
#                    bgbc006   LIKE bgbc_t.bgbc006,
#                    l_cond    LIKE type_t.chr1000,
#                    bgbcsum   LIKE type_t.num20_6,
#                    glarsum   LIKE type_t.num20_6,
#                    diffsum   LIKE type_t.num20_6,
#                    ent       LIKE type_t.num5
#                    END RECORD
#   DEFINE p_wc      STRING
#   DEFINE l_cond    STRING
#   DEFINE l_rate    LIKE type_t.num20_6
#   DEFINE l_glaa025 LIKE glaa_t.glaa025
#   DEFINE l_acctype LIKE type_t.chr1
#   DEFINE l_bgbdsum LIKE type_t.num20_6
#   DEFINE l_lastmon LIKE type_t.num5
#   
#   LET l_glaa025 = NULL
#   SELECT glaa025 INTO l_glaa025 FROM glaa_t
#    WHERE glaaent = g_enterprise
#      AND glaald = g_input.l_ld
#   
#   CALL s_aooi160_get_exrate_avg('2',g_input.l_ld,g_today,g_bgaa.bgaa003,g_input.l_curr,0,l_glaa025)
#              RETURNING g_sub_success,g_errno,l_rate  
#   
#   LET l_group = 'bgbc007,bgbc006'
#   CASE g_input.l_condtype
#      WHEN '1' #營運據點
#         #LET l_group = l_group,",bgb",
#      WHEN '2' #部門
#         LET l_group = l_group,",bgbc017"
#         LET l_cond = "bgbc017"
#         LET g_field_3="glar013"
#      WHEN '3' #利潤/成本中心
#         LET l_group = l_group,",bgbc018"
#         LET l_cond = "bgbc018"
#         LET g_field_3="glar014"
#      WHEN '4' #區域
#         LET l_group = l_group,",bgbc019"
#         LET g_field_3="glar015"
#         LET l_cond = "bgbc019"
#      WHEN '5' #交易客商
#         LET l_group = l_group,",bgbc020"
#         LET g_field_3="glar016"
#         LET l_cond = "bgbc020"
#      WHEN '6' #帳款客戶
#         LET l_group = l_group,",bgbc021"
#         LET g_field_3="glar017"
#         LET l_cond = "bgbc021"
#      WHEN '7' #客群
#         LET l_group = l_group,",bgbc022"
#         LET g_field_3="glar018"
#         LET l_cond = "bgbc022"
#      WHEN '8' #產品類別
#         LET l_group = l_group,",bgbc023"
#         LET g_field_3="glar019"
#         LET l_cond = "bgbc023"
#      WHEN '9' #經營方式
#         LET l_group = l_group,",bgbc027"
#         LET g_field_3="glar051"
#         LET l_cond = "bgbc027"
#      WHEN '10' #渠道
#         LET l_group = l_group,",bgbc028"
#         LET g_field_3="glar052"
#         LET l_cond = "bgbc028"
#      WHEN '11' #品牌
#         LET l_group = l_group,",bgbc040"
#         LET g_field_3="glar053"
#         LET l_cond = "bgbc040"
#      WHEN '12' #人員
#         LET l_group = l_group,",bgbc024"
#         LET g_field_3="glar020"
#         LET l_cond = "bgbc024"
#      WHEN '13' #專案
#         LET l_group = l_group,",bgbc025"
#         LET g_field_3="glar022"
#         LET l_cond = "bgbc025"
#      WHEN '14' #WBS
#         LET l_group = l_group,",bgbc026"
#         LET g_field_3="glar023"
#         LET l_cond = "bgbc026"
#      WHEN '15' #自由核算項一
#         LET l_group = l_group,",bgbc029"
#         LET g_field_3="glar024"
#         LET l_cond = "bgbc029"
#      WHEN '16' #自由核算項二
#         LET l_group = l_group,",bgbc030"
#         LET g_field_3="glar025"
#         LET l_cond = "bgbc030"
#      WHEN '17' #自由核算項三
#         LET l_group = l_group,",bgbc031"
#         LET g_field_3="glar026"
#         LET l_cond = "bgbc031"
#      WHEN '18' #自由核算項四
#         LET l_group = l_group,",bgbc032"
#         LET g_field_3="glar027"
#         LET l_cond = "bgbc032"
#      WHEN '19' #自由核算項五
#         LET l_group = l_group,",bgbc033"
#         LET g_field_3="glar028"
#         LET l_cond = "bgbc033"
#      WHEN '20' #自由核算項六
#         LET l_group = l_group,",bgbc034"
#         LET g_field_3="glar029"
#         LET l_cond = "bgbc034"
#      WHEN '21' #自由核算項七
#         LET l_group = l_group,",bgbc035"
#         LET g_field_3="glar030"
#         LET l_cond = "bgbc035"
#      WHEN '22' #自由核算項八
#         LET l_group = l_group,",bgbc036"
#         LET g_field_3="glar031"
#         LET l_cond = "bgbc036"
#      WHEN '23' #自由核算項九
#         LET l_group = l_group,",bgbc037"
#         LET g_field_3="glar032"
#         LET l_cond = "bgbc037"
#      WHEN '24' #自由核算項十
#         LET l_group = l_group,",bgbc038"
#         LET g_field_3="glar033"
#         LET l_cond = "bgbc038"
#      OTHERWISE
#         LET l_group = l_group,",'' "         
#         LET l_cond = "1"
#         LET g_field_3 = "1"
#   END CASE
#   
##   IF g_input.l_sumtype = '1' THEN
##      LET p_wc = " bgbc006 BETWEEN '",g_input.l_mm1,"' AND '",g_input.l_mm2,"' "
##   ELSE
##      LET p_wc = " bgbc006 BETWEEN '0' AND '",g_input.l_mm2,"' "
##   END IF
#   IF l_lastmon > 12 THEN 
#      LET l_lastmon = 13
#   ELSE
#      LET l_lastmon = 12
#   END IF
#   LET p_wc = " bgbc006 BETWEEN '1' AND '",l_lastmon,"' "
#   IF cl_null(p_wc)THEN LET p_wc = ' 1=1' END IF
#   LET l_sql = "SELECT  ",l_group,
#               " ,0,0,0,0 ",
#               "  FROM bgbc_t ",
#               " WHERE bgbcent = ",g_enterprise,
#               "   AND bgbc001 = '",g_input.l_bgaa001,"' ",
#               "   AND bgbc002 = '",g_input.l_bgbc002,"' ",
#               "   AND bgbc003 = '",g_input.l_bgbc003,"' ",
#               "   AND ",p_wc,
#               "  GROUP BY ",l_group," "
#   PREPARE sel_bgbcp1 FROM l_sql
#   DECLARE sel_bgbcc1 CURSOR FOR sel_bgbcp1
#
#   LET l_sql = "SELECT SUM(bgbc008-bgbc009) ",
#               "  FROM bgbc_t ",
#               " WHERE bgbcent = ",g_enterprise,
#               "   AND bgbc001 = '",g_input.l_bgaa001,"' ",
#               "   AND bgbc002 = '",g_input.l_bgbc002,"' ",
#               "   AND bgbc003 = '",g_input.l_bgbc003,"' ",
#               "   AND bgbc007 = ? ",
#               "   AND bgbc006 = ? "
#   IF cl_null(g_input.l_condtype)THEN
#      LET l_sql = l_sql," AND 1=?"
#   ELSE
#      LET l_sql = l_sql,"   AND COALESCE(",l_cond,",' ')=COALESCE(?,' ') "   
#   END IF
#
#   PREPARE sel_bgbcp2 FROM l_sql
#      
#   LET l_sql = "SELECT SUM(glar008-glar009) ",
#               "  FROM glar_t ",
#               " WHERE glarent = ",g_enterprise," ",
#               "   AND glarld = '",g_input.l_ld,"' ",
#               "   AND glar001 = ? ",
#               "   AND glar002 = '",g_input.l_yy2,"' ",
#               "   AND glar003 = ? "
#   IF cl_null(g_input.l_condtype)THEN
#      LET l_sql = l_sql," AND 1=?"
#   ELSE
#      LET l_sql = l_sql,"   AND COALESCE(",g_field_3,",' ')=COALESCE(?,' ') "   
#   END IF
#   PREPARE sel_glarp1 FROM l_sql
#   
#   
#   LET l_sql = "SELECT SUM(bgbd034+bgbd035) ",
#               "  FROM bgbd_t ",
#               " WHERE bgbdent = ",g_enterprise,"  ",
#               "   AND bgbd001 = '",g_input.l_bgaa001,"' AND bgbd002 = '",g_input.l_bgbc002,"'   ",
#               "   AND bgbd007 = ? ",
#               "   AND bgbd006 = ? "#,
#               #""
#   PREPARE sel_bgbdp1 FROM l_sql               
#               
#           
#   DELETE FROM s_abgq054_tmp1
#   FOREACH sel_bgbcc1 INTO l_tmp.*
#      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
#      
#      #預算額
#      LET l_tmp.bgbcsum= NULL
#      IF cl_null(g_input.l_condtype) THEN LET l_tmp.l_cond = '1' END IF
#      EXECUTE sel_bgbcp2 USING l_tmp.bgbc007,l_tmp.bgbc006,l_tmp.l_cond INTO l_tmp.bgbcsum
#      IF cl_null(l_tmp.bgbcsum)THEN LET l_tmp.bgbcsum = 0 END IF
#      LET l_tmp.bgbcsum = l_tmp.bgbcsum * l_rate
#      #本幣取位
#      
#      IF g_input.l_withbgbd = 'Y' THEN
#         #bgbd已經是帳套本幣看是否加上
#         LET l_bgbdsum = NULL
#         EXECUTE sel_bgbdp1 USING l_tmp.bgbc007,l_tmp.bgbc006 INTO l_bgbdsum
#         IF cl_null(l_bgbdsum)THEN LET l_bgbdsum = 0 END IF     
#         LET l_tmp.bgbcsum = l_tmp.bgbcsum + l_bgbdsum
#      END IF
#      
#      #發生額
#      LET l_tmp.glarsum= NULL
#      IF cl_null(g_input.l_condtype) THEN LET l_tmp.l_cond = '1' END IF
#      EXECUTE sel_glarp1 USING l_tmp.bgbc007,l_tmp.bgbc006,l_tmp.l_cond INTO l_tmp.glarsum
#      IF cl_null(l_tmp.glarsum)THEN LET l_tmp.glarsum = 0 END IF
#      
#      #差異額
#      LET l_tmp.diffsum = l_tmp.bgbcsum - l_tmp.glarsum 
#      
#      LET l_tmp.ent = g_enterprise
#      IF cl_null(l_tmp.l_cond)THEN LET l_tmp.l_cond = ' ' END IF
#      
#      CALL s_abg_bgae001_acctype(g_input.l_bgaa001,l_tmp.bgbc007)RETURNING l_acctype
#      
#      IF l_acctype = '2' THEN
#         LET l_tmp.diffsum = l_tmp.diffsum * -1
#         LET l_tmp.glarsum = l_tmp.glarsum * -1
#         LET l_tmp.bgbcsum = l_tmp.bgbcsum * -1
#      END IF
#      INSERT INTO s_abgq054_tmp1 VALUES(l_tmp.*)
#   END FOREACH
   
END FUNCTION

PRIVATE FUNCTION abgq054_ins_tmp2()
   DEFINE l_tmp2 RECORD
         l_cond2 LIKE type_t.chr500, 
         bgbc007 LIKE bgbc_t.bgbc007,  
         l_rowtype LIKE type_t.chr500, 
         l_sum1 LIKE type_t.num20_6, 
         l_sum2 LIKE type_t.num20_6, 
         l_sum3 LIKE type_t.num20_6, 
         l_sum4 LIKE type_t.num20_6, 
         l_sum5 LIKE type_t.num20_6, 
         l_sum6 LIKE type_t.num20_6, 
         l_sum7 LIKE type_t.num20_6, 
         l_sum8 LIKE type_t.num20_6, 
         l_sum9 LIKE type_t.num20_6, 
         l_sum10 LIKE type_t.num20_6, 
         l_sum11 LIKE type_t.num20_6, 
         l_sum12 LIKE type_t.num20_6, 
         l_sum13 LIKE type_t.num20_6, 
         l_sumall LIKE type_t.num20_6, 
         ent     LIKE type_t.num5,
         l_acc   LIKE type_t.chr1
                 END RECORD
   DEFINE l_monrow  DYNAMIC ARRAY OF RECORD
                    bgbcsum   LIKE type_t.num20_6,
                    glarsum   LIKE type_t.num20_6,
                    diffsum   LIKE type_t.num20_6,
                    rate      LIKE type_t.num20_6
                    END RECORD   
   DEFINE l_lastmon LIKE type_t.num5
   DEFINE l_i       LIKE type_t.num10
   DEFINE l_sql     STRING
   DEFINE l_bgbc007 LIKE bgbc_t.bgbc007
   DEFINE l_cond2   LIKE type_t.chr500
   DEFINE l_sumall  RECORD
                    bgbcsum   LIKE type_t.num20_6,
                    glarsum   LIKE type_t.num20_6,
                    diffsum   LIKE type_t.num20_6,
                    rate      LIKE type_t.num20_6   
                    END RECORD
   DEFINE l_acc     LIKE type_t.chr1   #albireo 1604 #160425-00020#1
                    
   #抓預算編號對應周期最大月份
   SELECT MAX(bgac004) INTO l_lastmon
     FROM bgac_t,bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_input.l_bgaa001
      AND bgaaent = bgacent
      AND bgaa002 = bgac001    
   
   IF l_lastmon > 12 THEN 
      LET l_lastmon = 13
   ELSE
      LET l_lastmon = 12
   END IF
   
   LET l_sql = "SELECT bgbc007,l_cond ",
               "      ,acc ",   #albireo 1604 #160425-00020#1
               "  FROM s_abgq053_tmp1 ",
               " GROUP BY bgbc007,l_cond ",",acc"   #albireo 1604 add #160425-00020#1
   PREPARE sel_bgbcp3 FROM l_sql
   DECLARE sel_bgbcc3 CURSOR FOR sel_bgbcp3
   
   #LET l_sql = "SELECT bgbcsum,glarsum,diffsum,0 FROM s_abgq053_tmp1 ",   ##151207-00009#2 mark
   LET l_sql = "SELECT SUM(bgbcsum),SUM(glarsum),SUM(diffsum),0 FROM s_abgq053_tmp1 ",   #albireo 151207 #151207-00009#2
               " WHERE bgbc007 = ? ",
               "   AND bgbc006 = ? ",
               "   AND l_cond = ? ",
               "   AND acc = ? "   #albireo 1604 #160425-00020#1
   PREPARE sel_tmpp1 FROM l_sql
   
   DELETE FROM abgq054_tmp1
   
   FOREACH sel_bgbcc3 INTO l_bgbc007,l_cond2,l_acc   #albireo 1604 add l_acc #160425-00020#1
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      
      CALL l_monrow.clear()
      FOR l_i = 1 TO l_lastmon 
         EXECUTE sel_tmpp1 USING l_bgbc007,l_i,l_cond2,l_acc   #albireo 1604 #160425-00020#1
            INTO l_monrow[l_i].bgbcsum,l_monrow[l_i].glarsum,l_monrow[l_i].diffsum
         IF cl_null(l_monrow[l_i].bgbcsum)THEN LET l_monrow[l_i].bgbcsum = 0 END IF
         IF cl_null(l_monrow[l_i].glarsum)THEN LET l_monrow[l_i].glarsum = 0 END IF
         IF cl_null(l_monrow[l_i].diffsum)THEN LET l_monrow[l_i].diffsum = 0 END IF
         IF l_monrow[l_i].bgbcsum = 0 THEN
            LET l_monrow[l_i].rate = 0 
         ELSE
            LET l_monrow[l_i].rate = l_monrow[l_i].diffsum / l_monrow[l_i].bgbcsum * 100  #albireo 1604 * 100
         END IF
      END FOR
      
      IF cl_null(l_monrow[13].diffsum)THEN LET l_monrow[13].diffsum = 0 END IF
      IF cl_null(l_monrow[13].glarsum)THEN LET l_monrow[13].glarsum = 0 END IF
      IF cl_null(l_monrow[13].bgbcsum)THEN LET l_monrow[13].bgbcsum = 0 END IF
      IF cl_null(l_monrow[13].rate)THEN LET l_monrow[13].rate = 0 END IF
      
      LET l_sumall.glarsum = l_monrow[1].glarsum+l_monrow[2].glarsum+l_monrow[3].glarsum+l_monrow[4].glarsum+
                             l_monrow[5].glarsum+l_monrow[6].glarsum+l_monrow[7].glarsum+l_monrow[8].glarsum+
                             l_monrow[9].glarsum+l_monrow[10].glarsum+l_monrow[11].glarsum+l_monrow[12].glarsum+
                             l_monrow[13].glarsum
                             
      LET l_sumall.bgbcsum = l_monrow[1].bgbcsum+l_monrow[2].bgbcsum+l_monrow[3].bgbcsum+l_monrow[4].bgbcsum+
                             l_monrow[5].bgbcsum+l_monrow[6].bgbcsum+l_monrow[7].bgbcsum+l_monrow[8].bgbcsum+
                             l_monrow[9].bgbcsum+l_monrow[10].bgbcsum+l_monrow[11].bgbcsum+l_monrow[12].bgbcsum+
                             l_monrow[13].bgbcsum

      LET l_sumall.diffsum = l_monrow[1].diffsum+l_monrow[2].diffsum+l_monrow[3].diffsum+l_monrow[4].diffsum+
                             l_monrow[5].diffsum+l_monrow[6].diffsum+l_monrow[7].diffsum+l_monrow[8].diffsum+
                             l_monrow[9].diffsum+l_monrow[10].diffsum+l_monrow[11].diffsum+l_monrow[12].diffsum+
                             l_monrow[13].diffsum
      IF l_sumall.bgbcsum = 0 THEN
         LET l_sumall.rate = 0 
      ELSE
         LET l_sumall.rate = l_sumall.diffsum / l_sumall.bgbcsum * 100  #albireo 1604 * 100 #160425-00020#1
      END IF
      
      INITIALIZE l_tmp2.* TO NULL
      LET l_tmp2.ent = g_enterprise
      LET l_tmp2.l_cond2 = l_cond2
      LET l_tmp2.bgbc007 = l_bgbc007
      LET l_tmp2.l_acc   = l_acc   #albireo 1604 #160425-00020#1
      #預算數
      LET l_tmp2.l_rowtype = '1'
      LET l_tmp2.l_sum1    = l_monrow[1].bgbcsum
      LET l_tmp2.l_sum2    = l_monrow[2].bgbcsum
      LET l_tmp2.l_sum3    = l_monrow[3].bgbcsum
      LET l_tmp2.l_sum4    = l_monrow[4].bgbcsum
      LET l_tmp2.l_sum5    = l_monrow[5].bgbcsum
      LET l_tmp2.l_sum6    = l_monrow[6].bgbcsum
      LET l_tmp2.l_sum7    = l_monrow[7].bgbcsum
      LET l_tmp2.l_sum8    = l_monrow[8].bgbcsum
      LET l_tmp2.l_sum9    = l_monrow[9].bgbcsum
      LET l_tmp2.l_sum10   = l_monrow[10].bgbcsum
      LET l_tmp2.l_sum11   = l_monrow[11].bgbcsum
      LET l_tmp2.l_sum12   = l_monrow[12].bgbcsum
      LET l_tmp2.l_sum13   = l_monrow[13].bgbcsum
      LET l_tmp2.l_sumall  = l_sumall.bgbcsum   
      #INSERT INTO abgq054_tmp1 VALUES(l_tmp2.*)   #161108-00017#5  mark
      #161108-00017#5  add---s
      INSERT INTO abgq054_tmp1 (l_cond,bgbc007,l_rowtype,l_sum1,l_sum2, 
                                l_sum3,l_sum4,l_sum5,l_sum6,l_sum7, 
                                l_sum8,l_sum9,l_sum10,l_sum11,l_sum12, 
                                l_sum13,l_sumall,ent,acc)
                        VALUES (l_tmp2.l_cond2,l_tmp2.bgbc007,l_tmp2.l_rowtype,l_tmp2.l_sum1,l_tmp2.l_sum2, 
                                l_tmp2.l_sum3,l_tmp2.l_sum4,l_tmp2.l_sum5,l_tmp2.l_sum6,l_tmp2.l_sum7, 
                                l_tmp2.l_sum8,l_tmp2.l_sum9,l_tmp2.l_sum10,l_tmp2.l_sum11,l_tmp2.l_sum12, 
                                l_tmp2.l_sum13,l_tmp2.l_sumall,l_tmp2.ent,l_tmp2.l_acc) 
      #161108-00017#5  add---e                                

      
      #實際數
      LET l_tmp2.l_rowtype = '2'
      LET l_tmp2.l_sum1    = l_monrow[1].glarsum
      LET l_tmp2.l_sum2    = l_monrow[2].glarsum
      LET l_tmp2.l_sum3    = l_monrow[3].glarsum
      LET l_tmp2.l_sum4    = l_monrow[4].glarsum
      LET l_tmp2.l_sum5    = l_monrow[5].glarsum
      LET l_tmp2.l_sum6    = l_monrow[6].glarsum
      LET l_tmp2.l_sum7    = l_monrow[7].glarsum
      LET l_tmp2.l_sum8    = l_monrow[8].glarsum
      LET l_tmp2.l_sum9    = l_monrow[9].glarsum
      LET l_tmp2.l_sum10   = l_monrow[10].glarsum
      LET l_tmp2.l_sum11   = l_monrow[11].glarsum
      LET l_tmp2.l_sum12   = l_monrow[12].glarsum
      LET l_tmp2.l_sum13   = l_monrow[13].glarsum
      LET l_tmp2.l_sumall  = l_sumall.glarsum   
      #INSERT INTO abgq054_tmp1 VALUES(l_tmp2.*)   #161108-00017#5  mark
      #161108-00017#5  add---s
      INSERT INTO abgq054_tmp1 (l_cond,bgbc007,l_rowtype,l_sum1,l_sum2, 
                                l_sum3,l_sum4,l_sum5,l_sum6,l_sum7, 
                                l_sum8,l_sum9,l_sum10,l_sum11,l_sum12, 
                                l_sum13,l_sumall,ent,acc)
                        VALUES (l_tmp2.l_cond2,l_tmp2.bgbc007,l_tmp2.l_rowtype,l_tmp2.l_sum1,l_tmp2.l_sum2, 
                                l_tmp2.l_sum3,l_tmp2.l_sum4,l_tmp2.l_sum5,l_tmp2.l_sum6,l_tmp2.l_sum7, 
                                l_tmp2.l_sum8,l_tmp2.l_sum9,l_tmp2.l_sum10,l_tmp2.l_sum11,l_tmp2.l_sum12, 
                                l_tmp2.l_sum13,l_tmp2.l_sumall,l_tmp2.ent,l_tmp2.l_acc) 
      #161108-00017#5  add---e 
      
      #差異
      LET l_tmp2.l_rowtype = '3'
      LET l_tmp2.l_sum1    = l_monrow[1].diffsum
      LET l_tmp2.l_sum2    = l_monrow[2].diffsum
      LET l_tmp2.l_sum3    = l_monrow[3].diffsum
      LET l_tmp2.l_sum4    = l_monrow[4].diffsum
      LET l_tmp2.l_sum5    = l_monrow[5].diffsum
      LET l_tmp2.l_sum6    = l_monrow[6].diffsum
      LET l_tmp2.l_sum7    = l_monrow[7].diffsum
      LET l_tmp2.l_sum8    = l_monrow[8].diffsum
      LET l_tmp2.l_sum9    = l_monrow[9].diffsum
      LET l_tmp2.l_sum10   = l_monrow[10].diffsum
      LET l_tmp2.l_sum11   = l_monrow[11].diffsum
      LET l_tmp2.l_sum12   = l_monrow[12].diffsum
      LET l_tmp2.l_sum13   = l_monrow[13].diffsum
      LET l_tmp2.l_sumall  = l_sumall.diffsum   
      #INSERT INTO abgq054_tmp1 VALUES(l_tmp2.*)   #161108-00017#5  mark
      #161108-00017#5  add---s
      INSERT INTO abgq054_tmp1 (l_cond,bgbc007,l_rowtype,l_sum1,l_sum2, 
                                l_sum3,l_sum4,l_sum5,l_sum6,l_sum7, 
                                l_sum8,l_sum9,l_sum10,l_sum11,l_sum12, 
                                l_sum13,l_sumall,ent,acc)
                        VALUES (l_tmp2.l_cond2,l_tmp2.bgbc007,l_tmp2.l_rowtype,l_tmp2.l_sum1,l_tmp2.l_sum2, 
                                l_tmp2.l_sum3,l_tmp2.l_sum4,l_tmp2.l_sum5,l_tmp2.l_sum6,l_tmp2.l_sum7, 
                                l_tmp2.l_sum8,l_tmp2.l_sum9,l_tmp2.l_sum10,l_tmp2.l_sum11,l_tmp2.l_sum12, 
                                l_tmp2.l_sum13,l_tmp2.l_sumall,l_tmp2.ent,l_tmp2.l_acc) 
      #161108-00017#5  add---e      
      
      #rate
      LET l_tmp2.l_rowtype = '4'
      LET l_tmp2.l_sum1    = l_monrow[1].rate
      LET l_tmp2.l_sum2    = l_monrow[2].rate
      LET l_tmp2.l_sum3    = l_monrow[3].rate
      LET l_tmp2.l_sum4    = l_monrow[4].rate
      LET l_tmp2.l_sum5    = l_monrow[5].rate
      LET l_tmp2.l_sum6    = l_monrow[6].rate
      LET l_tmp2.l_sum7    = l_monrow[7].rate
      LET l_tmp2.l_sum8    = l_monrow[8].rate
      LET l_tmp2.l_sum9    = l_monrow[9].rate
      LET l_tmp2.l_sum10   = l_monrow[10].rate
      LET l_tmp2.l_sum11   = l_monrow[11].rate
      LET l_tmp2.l_sum12   = l_monrow[12].rate
      LET l_tmp2.l_sum13   = l_monrow[13].rate
      LET l_tmp2.l_sumall  = l_sumall.rate   
      #INSERT INTO abgq054_tmp1 VALUES(l_tmp2.*)   #161108-00017#5  mark
      #161108-00017#5  add---s
      INSERT INTO abgq054_tmp1 (l_cond,bgbc007,l_rowtype,l_sum1,l_sum2, 
                                l_sum3,l_sum4,l_sum5,l_sum6,l_sum7, 
                                l_sum8,l_sum9,l_sum10,l_sum11,l_sum12, 
                                l_sum13,l_sumall,ent,acc)
                        VALUES (l_tmp2.l_cond2,l_tmp2.bgbc007,l_tmp2.l_rowtype,l_tmp2.l_sum1,l_tmp2.l_sum2, 
                                l_tmp2.l_sum3,l_tmp2.l_sum4,l_tmp2.l_sum5,l_tmp2.l_sum6,l_tmp2.l_sum7, 
                                l_tmp2.l_sum8,l_tmp2.l_sum9,l_tmp2.l_sum10,l_tmp2.l_sum11,l_tmp2.l_sum12, 
                                l_tmp2.l_sum13,l_tmp2.l_sumall,l_tmp2.ent,l_tmp2.l_acc) 
      #161108-00017#5  add---e        
   END FOREACH
               
#   #塞合計
#   LET l_sql = "SELECT ' ','abgq054sum',l_rowtype,",
#               "       SUM(l_sum1),SUM(l_sum2),SUM(l_sum3),SUM(l_sum4),SUM(l_sum5),SUM(l_sum6),",
#               "       SUM(l_sum7),SUM(l_sum8),SUM(l_sum9),SUM(l_sum10),SUM(l_sum11),SUM(l_sum12),",
#               "       SUM(l_sum13),SUM(l_sumall),0 ",
#               "  FROM abgq054_tmp1 ",
#               " GROUP BY l_rowtype "
#   PREPARE sel_tmpp2 FROM l_sql
#   DECLARE sel_tmpc2 CURSOR FOR sel_tmpp2
#   
#   FOREACH sel_tmpc2 INTO l_tmp2.*
#      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
#      
#      LET l_tmp2.ent = g_enterprise
#      INSERT INTO abgq054_tmp1 VALUES(l_tmp2.*)  
#   END FOREACH
               
   
END FUNCTION

 
{</section>}
 
