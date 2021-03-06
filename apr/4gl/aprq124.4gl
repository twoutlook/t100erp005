#該程式未解開Section, 採用最新樣板產出!
{<section id="aprq124.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-05-16 10:17:44), PR版次:0008(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000118
#+ Filename...: aprq124
#+ Description: 調價清單查詢
#+ Creator....: 02296(2014-03-20 00:00:00)
#+ Modifier...: 03247 -SD/PR- 00000
 
{</section>}
 
{<section id="aprq124.global" >}
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
PRIVATE TYPE type_g_prbk_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   prbkstus LIKE prbk_t.prbkstus, 
   prbk025 LIKE prbk_t.prbk025, 
   prbksite LIKE prbk_t.prbksite, 
   prbksite_desc LIKE type_t.chr500, 
   prbk003 LIKE prbk_t.prbk003, 
   prbk001 LIKE prbk_t.prbk001, 
   prbk002 LIKE prbk_t.prbk002, 
   prbk004 LIKE prbk_t.prbk004, 
   prbk005 LIKE prbk_t.prbk005, 
   prbk005_desc LIKE type_t.chr500, 
   prbk006 LIKE prbk_t.prbk006, 
   prbk008 LIKE prbk_t.prbk008, 
   prbk007 LIKE prbk_t.prbk007, 
   prbk009 LIKE prbk_t.prbk009, 
   prbk011 LIKE prbk_t.prbk011, 
   prbk010 LIKE prbk_t.prbk010, 
   prbk010_desc LIKE type_t.chr500, 
   prbk010_desc1 LIKE type_t.chr500, 
   prbk010_desc2 LIKE type_t.chr500, 
   prbk010_desc2_desc LIKE type_t.chr500, 
   prbk012 LIKE prbk_t.prbk012, 
   prbk013 LIKE prbk_t.prbk013, 
   prbk014 LIKE prbk_t.prbk014, 
   prbk014_desc LIKE type_t.chr500, 
   prbk015 LIKE prbk_t.prbk015, 
   prbk016 LIKE prbk_t.prbk016, 
   prbk017 LIKE prbk_t.prbk017, 
   prbk017_desc LIKE type_t.chr500, 
   prbk018 LIKE prbk_t.prbk018, 
   prbk019 LIKE prbk_t.prbk019, 
   prbk019_desc LIKE type_t.chr500, 
   prbk020 LIKE prbk_t.prbk020, 
   prbk021 LIKE prbk_t.prbk021, 
   prbk022 LIKE prbk_t.prbk022, 
   prbk023 LIKE prbk_t.prbk023, 
   prbk028 LIKE prbk_t.prbk028, 
   prbk024 LIKE prbk_t.prbk024, 
   prbk026 LIKE prbk_t.prbk026, 
   prbk026_desc LIKE type_t.chr500, 
   prbk027 LIKE prbk_t.prbk027, 
   prbk027_desc LIKE type_t.chr500, 
   prbkunit LIKE prbk_t.prbkunit 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_prbk_d
DEFINE g_master_t                   type_g_prbk_d
DEFINE g_prbk_d          DYNAMIC ARRAY OF type_g_prbk_d
DEFINE g_prbk_d_t        type_g_prbk_d
 
      
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
 
{<section id="aprq124.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
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
   DECLARE aprq124_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprq124_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprq124_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprq124 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprq124_init()   
 
      #進入選單 Menu (="N")
      CALL aprq124_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprq124
      
   END IF 
   
   CLOSE aprq124_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprq124.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aprq124_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add
   DEFINE l_gzcbl004   LIKE gzcbl_t.gzcbl004 #add by geza 20160304
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_prbk025','6779') 
   CALL cl_set_combo_scc('b_prbk003','6033') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   
   CALL cl_set_combo_scc('b_prbkstus','6034')
   #add by geza 20160304(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbk021",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbk022",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbk023",l_gzcbl004)
   #add by geza 20160304(E)
   #end add-point
 
   CALL aprq124_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aprq124.default_search" >}
PRIVATE FUNCTION aprq124_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " prbksite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " prbk001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " prbk002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " prbk006 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " prbk025 = '", g_argv[05], "' AND "
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
 
{<section id="aprq124.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aprq124_ui_dialog()
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
      CALL aprq124_b_fill()
   ELSE
      CALL aprq124_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_prbk_d.clear()
 
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
 
         CALL aprq124_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prbk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aprq124_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aprq124_detail_action_trans()
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
            CALL aprq124_detail_action_trans()
 
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
               CALL aprq124_query()
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
            CALL aprq124_filter()
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
            CALL aprq124_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_prbk_d)
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
            CALL aprq124_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aprq124_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aprq124_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aprq124_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_prbk_d.getLength()
               LET g_prbk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_prbk_d.getLength()
               LET g_prbk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_prbk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prbk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_prbk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prbk_d[li_idx].sel = "N"
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
 
{<section id="aprq124.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprq124_query()
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
   CALL g_prbk_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON prbkstus,prbk025,prbksite,prbk003,prbk001,prbk002,prbk004,prbk005,prbk006, 
          prbk008,prbk007,prbk009,prbk011,prbk010,prbk012,prbk013,prbk014,prbk015,prbk016,prbk017,prbk018, 
          prbk019,prbk020,prbk021,prbk022,prbk023,prbk028,prbk024,prbk026,prbk027,prbkunit
           FROM s_detail1[1].b_prbkstus,s_detail1[1].b_prbk025,s_detail1[1].b_prbksite,s_detail1[1].b_prbk003, 
               s_detail1[1].b_prbk001,s_detail1[1].b_prbk002,s_detail1[1].b_prbk004,s_detail1[1].b_prbk005, 
               s_detail1[1].b_prbk006,s_detail1[1].b_prbk008,s_detail1[1].b_prbk007,s_detail1[1].b_prbk009, 
               s_detail1[1].b_prbk011,s_detail1[1].b_prbk010,s_detail1[1].b_prbk012,s_detail1[1].b_prbk013, 
               s_detail1[1].b_prbk014,s_detail1[1].b_prbk015,s_detail1[1].b_prbk016,s_detail1[1].b_prbk017, 
               s_detail1[1].b_prbk018,s_detail1[1].b_prbk019,s_detail1[1].b_prbk020,s_detail1[1].b_prbk021, 
               s_detail1[1].b_prbk022,s_detail1[1].b_prbk023,s_detail1[1].b_prbk028,s_detail1[1].b_prbk024, 
               s_detail1[1].b_prbk026,s_detail1[1].b_prbk027,s_detail1[1].b_prbkunit
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            IF NOT cl_null(g_argv[1]) THEN
               EXIT DIALOG
            END IF
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbkcrtdt>>----
         #AFTER FIELD prbkcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbkmoddt>>----
         #AFTER FIELD prbkmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbkcnfdt>>----
         #AFTER FIELD prbkcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbkpstdt>>----
         #AFTER FIELD prbkpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_prbkstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbkstus
            #add-point:BEFORE FIELD b_prbkstus name="construct.b.page1.b_prbkstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbkstus
            
            #add-point:AFTER FIELD b_prbkstus name="construct.a.page1.b_prbkstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbkstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbkstus
            #add-point:ON ACTION controlp INFIELD b_prbkstus name="construct.c.page1.b_prbkstus"
            
            #END add-point
 
 
         #----<<b_prbk025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk025
            #add-point:BEFORE FIELD b_prbk025 name="construct.b.page1.b_prbk025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk025
            
            #add-point:AFTER FIELD b_prbk025 name="construct.a.page1.b_prbk025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk025
            #add-point:ON ACTION controlp INFIELD b_prbk025 name="construct.c.page1.b_prbk025"
            
            #END add-point
 
 
         #----<<b_prbksite>>----
         #Ctrlp:construct.c.page1.b_prbksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbksite
            #add-point:ON ACTION controlp INFIELD b_prbksite name="construct.c.page1.b_prbksite"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
#            CALL q_ooef001()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbksite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_prbksite  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD b_prbksite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbksite
            #add-point:BEFORE FIELD b_prbksite name="construct.b.page1.b_prbksite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbksite
            
            #add-point:AFTER FIELD b_prbksite name="construct.a.page1.b_prbksite"
            
            #END add-point
            
 
 
         #----<<b_prbksite_desc>>----
         #----<<b_prbk003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk003
            #add-point:BEFORE FIELD b_prbk003 name="construct.b.page1.b_prbk003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk003
            
            #add-point:AFTER FIELD b_prbk003 name="construct.a.page1.b_prbk003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk003
            #add-point:ON ACTION controlp INFIELD b_prbk003 name="construct.c.page1.b_prbk003"
            
            #END add-point
 
 
         #----<<b_prbk001>>----
         #Ctrlp:construct.c.page1.b_prbk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk001
            #add-point:ON ACTION controlp INFIELD b_prbk001 name="construct.c.page1.b_prbk001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prbk001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk001  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO prbk003 #單據類型 

            NEXT FIELD b_prbk001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk001
            #add-point:BEFORE FIELD b_prbk001 name="construct.b.page1.b_prbk001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk001
            
            #add-point:AFTER FIELD b_prbk001 name="construct.a.page1.b_prbk001"
            
            #END add-point
            
 
 
         #----<<b_prbk002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk002
            #add-point:BEFORE FIELD b_prbk002 name="construct.b.page1.b_prbk002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk002
            
            #add-point:AFTER FIELD b_prbk002 name="construct.a.page1.b_prbk002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk002
            #add-point:ON ACTION controlp INFIELD b_prbk002 name="construct.c.page1.b_prbk002"
            
            #END add-point
 
 
         #----<<b_prbk004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk004
            #add-point:BEFORE FIELD b_prbk004 name="construct.b.page1.b_prbk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk004
            
            #add-point:AFTER FIELD b_prbk004 name="construct.a.page1.b_prbk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk004
            #add-point:ON ACTION controlp INFIELD b_prbk004 name="construct.c.page1.b_prbk004"
            
            #END add-point
 
 
         #----<<b_prbk005>>----
         #Ctrlp:construct.c.page1.b_prbk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk005
            #add-point:ON ACTION controlp INFIELD b_prbk005 name="construct.c.page1.b_prbk005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk005  #顯示到畫面上
            NEXT FIELD b_prbk005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk005
            #add-point:BEFORE FIELD b_prbk005 name="construct.b.page1.b_prbk005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk005
            
            #add-point:AFTER FIELD b_prbk005 name="construct.a.page1.b_prbk005"
            
            #END add-point
            
 
 
         #----<<b_prbk005_desc>>----
         #----<<b_prbk006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk006
            #add-point:BEFORE FIELD b_prbk006 name="construct.b.page1.b_prbk006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk006
            
            #add-point:AFTER FIELD b_prbk006 name="construct.a.page1.b_prbk006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk006
            #add-point:ON ACTION controlp INFIELD b_prbk006 name="construct.c.page1.b_prbk006"
            
            #END add-point
 
 
         #----<<b_prbk008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk008
            #add-point:BEFORE FIELD b_prbk008 name="construct.b.page1.b_prbk008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk008
            
            #add-point:AFTER FIELD b_prbk008 name="construct.a.page1.b_prbk008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk008
            #add-point:ON ACTION controlp INFIELD b_prbk008 name="construct.c.page1.b_prbk008"
            
            #END add-point
 
 
         #----<<b_prbk007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk007
            #add-point:BEFORE FIELD b_prbk007 name="construct.b.page1.b_prbk007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk007
            
            #add-point:AFTER FIELD b_prbk007 name="construct.a.page1.b_prbk007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk007
            #add-point:ON ACTION controlp INFIELD b_prbk007 name="construct.c.page1.b_prbk007"
            
            #END add-point
 
 
         #----<<b_prbk009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk009
            #add-point:BEFORE FIELD b_prbk009 name="construct.b.page1.b_prbk009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk009
            
            #add-point:AFTER FIELD b_prbk009 name="construct.a.page1.b_prbk009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk009
            #add-point:ON ACTION controlp INFIELD b_prbk009 name="construct.c.page1.b_prbk009"
            
            #END add-point
 
 
         #----<<b_prbk011>>----
         #Ctrlp:construct.c.page1.b_prbk011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk011
            #add-point:ON ACTION controlp INFIELD b_prbk011 name="construct.c.page1.b_prbk011"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk011  #顯示到畫面上

            NEXT FIELD b_prbk011                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk011
            #add-point:BEFORE FIELD b_prbk011 name="construct.b.page1.b_prbk011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk011
            
            #add-point:AFTER FIELD b_prbk011 name="construct.a.page1.b_prbk011"
            
            #END add-point
            
 
 
         #----<<b_prbk010>>----
         #Ctrlp:construct.c.page1.b_prbk010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk010
            #add-point:ON ACTION controlp INFIELD b_prbk010 name="construct.c.page1.b_prbk010"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001_15()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk010  #顯示到畫面上

            NEXT FIELD b_prbk010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk010
            #add-point:BEFORE FIELD b_prbk010 name="construct.b.page1.b_prbk010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk010
            
            #add-point:AFTER FIELD b_prbk010 name="construct.a.page1.b_prbk010"
            
            #END add-point
            
 
 
         #----<<b_prbk010_desc>>----
         #----<<b_prbk010_desc1>>----
         #----<<b_prbk010_desc2>>----
         #----<<b_prbk010_desc2_desc>>----
         #----<<b_prbk012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk012
            #add-point:BEFORE FIELD b_prbk012 name="construct.b.page1.b_prbk012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk012
            
            #add-point:AFTER FIELD b_prbk012 name="construct.a.page1.b_prbk012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk012
            #add-point:ON ACTION controlp INFIELD b_prbk012 name="construct.c.page1.b_prbk012"
            
            #END add-point
 
 
         #----<<b_prbk013>>----
         #Ctrlp:construct.c.page1.b_prbk013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk013
            #add-point:ON ACTION controlp INFIELD b_prbk013 name="construct.c.page1.b_prbk013"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_prbh001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk013  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO imaal004 #規格 
               #DISPLAY g_qryparam.return3 TO prbh001 #PLU編碼 
               #DISPLAY g_qryparam.return4 TO prbh002 #PLU說明 
               #DISPLAY g_qryparam.return5 TO prbh003 #商品編碼 
               #DISPLAY g_qryparam.return6 TO prbh004 #商品條碼 

            NEXT FIELD b_prbk013                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk013
            #add-point:BEFORE FIELD b_prbk013 name="construct.b.page1.b_prbk013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk013
            
            #add-point:AFTER FIELD b_prbk013 name="construct.a.page1.b_prbk013"
            
            #END add-point
            
 
 
         #----<<b_prbk014>>----
         #Ctrlp:construct.c.page1.b_prbk014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk014
            #add-point:ON ACTION controlp INFIELD b_prbk014 name="construct.c.page1.b_prbk014"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk014  #顯示到畫面上

            NEXT FIELD b_prbk014                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk014
            #add-point:BEFORE FIELD b_prbk014 name="construct.b.page1.b_prbk014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk014
            
            #add-point:AFTER FIELD b_prbk014 name="construct.a.page1.b_prbk014"
            
            #END add-point
            
 
 
         #----<<b_prbk014_desc>>----
         #----<<b_prbk015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk015
            #add-point:BEFORE FIELD b_prbk015 name="construct.b.page1.b_prbk015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk015
            
            #add-point:AFTER FIELD b_prbk015 name="construct.a.page1.b_prbk015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk015
            #add-point:ON ACTION controlp INFIELD b_prbk015 name="construct.c.page1.b_prbk015"
            
            #END add-point
 
 
         #----<<b_prbk016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk016
            #add-point:BEFORE FIELD b_prbk016 name="construct.b.page1.b_prbk016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk016
            
            #add-point:AFTER FIELD b_prbk016 name="construct.a.page1.b_prbk016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk016
            #add-point:ON ACTION controlp INFIELD b_prbk016 name="construct.c.page1.b_prbk016"
            
            #END add-point
 
 
         #----<<b_prbk017>>----
         #Ctrlp:construct.c.page1.b_prbk017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk017
            #add-point:ON ACTION controlp INFIELD b_prbk017 name="construct.c.page1.b_prbk017"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk017  #顯示到畫面上

            NEXT FIELD b_prbk017                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk017
            #add-point:BEFORE FIELD b_prbk017 name="construct.b.page1.b_prbk017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk017
            
            #add-point:AFTER FIELD b_prbk017 name="construct.a.page1.b_prbk017"
            
            #END add-point
            
 
 
         #----<<b_prbk017_desc>>----
         #----<<b_prbk018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk018
            #add-point:BEFORE FIELD b_prbk018 name="construct.b.page1.b_prbk018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk018
            
            #add-point:AFTER FIELD b_prbk018 name="construct.a.page1.b_prbk018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk018
            #add-point:ON ACTION controlp INFIELD b_prbk018 name="construct.c.page1.b_prbk018"
            
            #END add-point
 
 
         #----<<b_prbk019>>----
         #Ctrlp:construct.c.page1.b_prbk019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk019
            #add-point:ON ACTION controlp INFIELD b_prbk019 name="construct.c.page1.b_prbk019"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk019  #顯示到畫面上

            NEXT FIELD b_prbk019                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk019
            #add-point:BEFORE FIELD b_prbk019 name="construct.b.page1.b_prbk019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk019
            
            #add-point:AFTER FIELD b_prbk019 name="construct.a.page1.b_prbk019"
            
            #END add-point
            
 
 
         #----<<b_prbk019_desc>>----
         #----<<b_prbk020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk020
            #add-point:BEFORE FIELD b_prbk020 name="construct.b.page1.b_prbk020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk020
            
            #add-point:AFTER FIELD b_prbk020 name="construct.a.page1.b_prbk020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk020
            #add-point:ON ACTION controlp INFIELD b_prbk020 name="construct.c.page1.b_prbk020"
            
            #END add-point
 
 
         #----<<b_prbk021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk021
            #add-point:BEFORE FIELD b_prbk021 name="construct.b.page1.b_prbk021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk021
            
            #add-point:AFTER FIELD b_prbk021 name="construct.a.page1.b_prbk021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk021
            #add-point:ON ACTION controlp INFIELD b_prbk021 name="construct.c.page1.b_prbk021"
            
            #END add-point
 
 
         #----<<b_prbk022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk022
            #add-point:BEFORE FIELD b_prbk022 name="construct.b.page1.b_prbk022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk022
            
            #add-point:AFTER FIELD b_prbk022 name="construct.a.page1.b_prbk022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk022
            #add-point:ON ACTION controlp INFIELD b_prbk022 name="construct.c.page1.b_prbk022"
            
            #END add-point
 
 
         #----<<b_prbk023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk023
            #add-point:BEFORE FIELD b_prbk023 name="construct.b.page1.b_prbk023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk023
            
            #add-point:AFTER FIELD b_prbk023 name="construct.a.page1.b_prbk023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk023
            #add-point:ON ACTION controlp INFIELD b_prbk023 name="construct.c.page1.b_prbk023"
            
            #END add-point
 
 
         #----<<b_prbk028>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk028
            #add-point:BEFORE FIELD b_prbk028 name="construct.b.page1.b_prbk028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk028
            
            #add-point:AFTER FIELD b_prbk028 name="construct.a.page1.b_prbk028"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk028
            #add-point:ON ACTION controlp INFIELD b_prbk028 name="construct.c.page1.b_prbk028"
            
            #END add-point
 
 
         #----<<b_prbk024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk024
            #add-point:BEFORE FIELD b_prbk024 name="construct.b.page1.b_prbk024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk024
            
            #add-point:AFTER FIELD b_prbk024 name="construct.a.page1.b_prbk024"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbk024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk024
            #add-point:ON ACTION controlp INFIELD b_prbk024 name="construct.c.page1.b_prbk024"
            
            #END add-point
 
 
         #----<<b_prbk026>>----
         #Ctrlp:construct.c.page1.b_prbk026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk026
            #add-point:ON ACTION controlp INFIELD b_prbk026 name="construct.c.page1.b_prbk026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk026  #顯示到畫面上
            NEXT FIELD b_prbk026                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk026
            #add-point:BEFORE FIELD b_prbk026 name="construct.b.page1.b_prbk026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk026
            
            #add-point:AFTER FIELD b_prbk026 name="construct.a.page1.b_prbk026"
            
            #END add-point
            
 
 
         #----<<b_prbk026_desc>>----
         #----<<b_prbk027>>----
         #Ctrlp:construct.c.page1.b_prbk027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk027
            #add-point:ON ACTION controlp INFIELD b_prbk027 name="construct.c.page1.b_prbk027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk027  #顯示到畫面上
            NEXT FIELD b_prbk027                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbk027
            #add-point:BEFORE FIELD b_prbk027 name="construct.b.page1.b_prbk027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbk027
            
            #add-point:AFTER FIELD b_prbk027 name="construct.a.page1.b_prbk027"
            
            #END add-point
            
 
 
         #----<<b_prbk027_desc>>----
         #----<<b_prbkunit>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbkunit
            #add-point:BEFORE FIELD b_prbkunit name="construct.b.page1.b_prbkunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbkunit
            
            #add-point:AFTER FIELD b_prbkunit name="construct.a.page1.b_prbkunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbkunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbkunit
            #add-point:ON ACTION controlp INFIELD b_prbkunit name="construct.c.page1.b_prbkunit"
            
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
   IF NOT cl_null(g_argv[1]) THEN
      LET g_wc = g_wc," AND prbk010 = '",g_argv[1],"' AND prbkstus = '1' "
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL aprq124_b_fill()
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
 
{<section id="aprq124.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprq124_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'prbksite')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',prbkstus,prbk025,prbksite,'',prbk003,prbk001,prbk002,prbk004, 
       prbk005,'',prbk006,prbk008,prbk007,prbk009,prbk011,prbk010,'','','','',prbk012,prbk013,prbk014, 
       '',prbk015,prbk016,prbk017,'',prbk018,prbk019,'',prbk020,prbk021,prbk022,prbk023,prbk028,prbk024, 
       prbk026,'',prbk027,'',prbkunit  ,DENSE_RANK() OVER( ORDER BY prbk_t.prbksite,prbk_t.prbk001,prbk_t.prbk002, 
       prbk_t.prbk006,prbk_t.prbk025) AS RANK FROM prbk_t",
 
 
                     "",
                     " WHERE prbkent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("prbk_t"),
                     " ORDER BY prbk_t.prbksite,prbk_t.prbk001,prbk_t.prbk002,prbk_t.prbk006,prbk_t.prbk025"
 
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
 
   LET g_sql = "SELECT '',prbkstus,prbk025,prbksite,'',prbk003,prbk001,prbk002,prbk004,prbk005,'',prbk006, 
       prbk008,prbk007,prbk009,prbk011,prbk010,'','','','',prbk012,prbk013,prbk014,'',prbk015,prbk016, 
       prbk017,'',prbk018,prbk019,'',prbk020,prbk021,prbk022,prbk023,prbk028,prbk024,prbk026,'',prbk027, 
       '',prbkunit",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aprq124_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aprq124_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_prbk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_prbk_d[l_ac].sel,g_prbk_d[l_ac].prbkstus,g_prbk_d[l_ac].prbk025,g_prbk_d[l_ac].prbksite, 
       g_prbk_d[l_ac].prbksite_desc,g_prbk_d[l_ac].prbk003,g_prbk_d[l_ac].prbk001,g_prbk_d[l_ac].prbk002, 
       g_prbk_d[l_ac].prbk004,g_prbk_d[l_ac].prbk005,g_prbk_d[l_ac].prbk005_desc,g_prbk_d[l_ac].prbk006, 
       g_prbk_d[l_ac].prbk008,g_prbk_d[l_ac].prbk007,g_prbk_d[l_ac].prbk009,g_prbk_d[l_ac].prbk011,g_prbk_d[l_ac].prbk010, 
       g_prbk_d[l_ac].prbk010_desc,g_prbk_d[l_ac].prbk010_desc1,g_prbk_d[l_ac].prbk010_desc2,g_prbk_d[l_ac].prbk010_desc2_desc, 
       g_prbk_d[l_ac].prbk012,g_prbk_d[l_ac].prbk013,g_prbk_d[l_ac].prbk014,g_prbk_d[l_ac].prbk014_desc, 
       g_prbk_d[l_ac].prbk015,g_prbk_d[l_ac].prbk016,g_prbk_d[l_ac].prbk017,g_prbk_d[l_ac].prbk017_desc, 
       g_prbk_d[l_ac].prbk018,g_prbk_d[l_ac].prbk019,g_prbk_d[l_ac].prbk019_desc,g_prbk_d[l_ac].prbk020, 
       g_prbk_d[l_ac].prbk021,g_prbk_d[l_ac].prbk022,g_prbk_d[l_ac].prbk023,g_prbk_d[l_ac].prbk028,g_prbk_d[l_ac].prbk024, 
       g_prbk_d[l_ac].prbk026,g_prbk_d[l_ac].prbk026_desc,g_prbk_d[l_ac].prbk027,g_prbk_d[l_ac].prbk027_desc, 
       g_prbk_d[l_ac].prbkunit
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_prbk_d[l_ac].statepic = cl_get_actipic(g_prbk_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_prbk_d[l_ac].sel = 'N'
      #end add-point
 
      CALL aprq124_detail_show("'1'")      
 
      CALL aprq124_prbk_t_mask()
 
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
   
 
   
   CALL g_prbk_d.deleteElement(g_prbk_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_prbk_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aprq124_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aprq124_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aprq124_detail_action_trans()
 
   IF g_prbk_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aprq124_fetch()
   END IF
   
      CALL aprq124_filter_show('prbkstus','b_prbkstus')
   CALL aprq124_filter_show('prbk025','b_prbk025')
   CALL aprq124_filter_show('prbksite','b_prbksite')
   CALL aprq124_filter_show('prbk003','b_prbk003')
   CALL aprq124_filter_show('prbk001','b_prbk001')
   CALL aprq124_filter_show('prbk002','b_prbk002')
   CALL aprq124_filter_show('prbk004','b_prbk004')
   CALL aprq124_filter_show('prbk005','b_prbk005')
   CALL aprq124_filter_show('prbk006','b_prbk006')
   CALL aprq124_filter_show('prbk008','b_prbk008')
   CALL aprq124_filter_show('prbk007','b_prbk007')
   CALL aprq124_filter_show('prbk009','b_prbk009')
   CALL aprq124_filter_show('prbk011','b_prbk011')
   CALL aprq124_filter_show('prbk010','b_prbk010')
   CALL aprq124_filter_show('prbk012','b_prbk012')
   CALL aprq124_filter_show('prbk013','b_prbk013')
   CALL aprq124_filter_show('prbk014','b_prbk014')
   CALL aprq124_filter_show('prbk015','b_prbk015')
   CALL aprq124_filter_show('prbk016','b_prbk016')
   CALL aprq124_filter_show('prbk017','b_prbk017')
   CALL aprq124_filter_show('prbk018','b_prbk018')
   CALL aprq124_filter_show('prbk019','b_prbk019')
   CALL aprq124_filter_show('prbk020','b_prbk020')
   CALL aprq124_filter_show('prbk021','b_prbk021')
   CALL aprq124_filter_show('prbk022','b_prbk022')
   CALL aprq124_filter_show('prbk023','b_prbk023')
   CALL aprq124_filter_show('prbk028','b_prbk028')
   CALL aprq124_filter_show('prbk024','b_prbk024')
   CALL aprq124_filter_show('prbk026','b_prbk026')
   CALL aprq124_filter_show('prbk027','b_prbk027')
   CALL aprq124_filter_show('prbkunit','b_prbkunit')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprq124_fetch()
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
 
{<section id="aprq124.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aprq124_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
   CALL aprq124_prbk_ref_show()
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq124_filter()
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
      CONSTRUCT g_wc_filter ON prbkstus,prbk025,prbksite,prbk003,prbk001,prbk002,prbk004,prbk005,prbk006, 
          prbk008,prbk007,prbk009,prbk011,prbk010,prbk012,prbk013,prbk014,prbk015,prbk016,prbk017,prbk018, 
          prbk019,prbk020,prbk021,prbk022,prbk023,prbk028,prbk024,prbk026,prbk027,prbkunit
                          FROM s_detail1[1].b_prbkstus,s_detail1[1].b_prbk025,s_detail1[1].b_prbksite, 
                              s_detail1[1].b_prbk003,s_detail1[1].b_prbk001,s_detail1[1].b_prbk002,s_detail1[1].b_prbk004, 
                              s_detail1[1].b_prbk005,s_detail1[1].b_prbk006,s_detail1[1].b_prbk008,s_detail1[1].b_prbk007, 
                              s_detail1[1].b_prbk009,s_detail1[1].b_prbk011,s_detail1[1].b_prbk010,s_detail1[1].b_prbk012, 
                              s_detail1[1].b_prbk013,s_detail1[1].b_prbk014,s_detail1[1].b_prbk015,s_detail1[1].b_prbk016, 
                              s_detail1[1].b_prbk017,s_detail1[1].b_prbk018,s_detail1[1].b_prbk019,s_detail1[1].b_prbk020, 
                              s_detail1[1].b_prbk021,s_detail1[1].b_prbk022,s_detail1[1].b_prbk023,s_detail1[1].b_prbk028, 
                              s_detail1[1].b_prbk024,s_detail1[1].b_prbk026,s_detail1[1].b_prbk027,s_detail1[1].b_prbkunit 
 
 
         BEFORE CONSTRUCT
                     DISPLAY aprq124_filter_parser('prbkstus') TO s_detail1[1].b_prbkstus
            DISPLAY aprq124_filter_parser('prbk025') TO s_detail1[1].b_prbk025
            DISPLAY aprq124_filter_parser('prbksite') TO s_detail1[1].b_prbksite
            DISPLAY aprq124_filter_parser('prbk003') TO s_detail1[1].b_prbk003
            DISPLAY aprq124_filter_parser('prbk001') TO s_detail1[1].b_prbk001
            DISPLAY aprq124_filter_parser('prbk002') TO s_detail1[1].b_prbk002
            DISPLAY aprq124_filter_parser('prbk004') TO s_detail1[1].b_prbk004
            DISPLAY aprq124_filter_parser('prbk005') TO s_detail1[1].b_prbk005
            DISPLAY aprq124_filter_parser('prbk006') TO s_detail1[1].b_prbk006
            DISPLAY aprq124_filter_parser('prbk008') TO s_detail1[1].b_prbk008
            DISPLAY aprq124_filter_parser('prbk007') TO s_detail1[1].b_prbk007
            DISPLAY aprq124_filter_parser('prbk009') TO s_detail1[1].b_prbk009
            DISPLAY aprq124_filter_parser('prbk011') TO s_detail1[1].b_prbk011
            DISPLAY aprq124_filter_parser('prbk010') TO s_detail1[1].b_prbk010
            DISPLAY aprq124_filter_parser('prbk012') TO s_detail1[1].b_prbk012
            DISPLAY aprq124_filter_parser('prbk013') TO s_detail1[1].b_prbk013
            DISPLAY aprq124_filter_parser('prbk014') TO s_detail1[1].b_prbk014
            DISPLAY aprq124_filter_parser('prbk015') TO s_detail1[1].b_prbk015
            DISPLAY aprq124_filter_parser('prbk016') TO s_detail1[1].b_prbk016
            DISPLAY aprq124_filter_parser('prbk017') TO s_detail1[1].b_prbk017
            DISPLAY aprq124_filter_parser('prbk018') TO s_detail1[1].b_prbk018
            DISPLAY aprq124_filter_parser('prbk019') TO s_detail1[1].b_prbk019
            DISPLAY aprq124_filter_parser('prbk020') TO s_detail1[1].b_prbk020
            DISPLAY aprq124_filter_parser('prbk021') TO s_detail1[1].b_prbk021
            DISPLAY aprq124_filter_parser('prbk022') TO s_detail1[1].b_prbk022
            DISPLAY aprq124_filter_parser('prbk023') TO s_detail1[1].b_prbk023
            DISPLAY aprq124_filter_parser('prbk028') TO s_detail1[1].b_prbk028
            DISPLAY aprq124_filter_parser('prbk024') TO s_detail1[1].b_prbk024
            DISPLAY aprq124_filter_parser('prbk026') TO s_detail1[1].b_prbk026
            DISPLAY aprq124_filter_parser('prbk027') TO s_detail1[1].b_prbk027
            DISPLAY aprq124_filter_parser('prbkunit') TO s_detail1[1].b_prbkunit
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbkcrtdt>>----
         #AFTER FIELD prbkcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbkmoddt>>----
         #AFTER FIELD prbkmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbkcnfdt>>----
         #AFTER FIELD prbkcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbkpstdt>>----
         #AFTER FIELD prbkpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_prbkstus>>----
         #Ctrlp:construct.c.filter.page1.b_prbkstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbkstus
            #add-point:ON ACTION controlp INFIELD b_prbkstus name="construct.c.filter.page1.b_prbkstus"
            
            #END add-point
 
 
         #----<<b_prbk025>>----
         #Ctrlp:construct.c.filter.page1.b_prbk025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk025
            #add-point:ON ACTION controlp INFIELD b_prbk025 name="construct.c.filter.page1.b_prbk025"
            
            #END add-point
 
 
         #----<<b_prbksite>>----
         #Ctrlp:construct.c.page1.b_prbksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbksite
            #add-point:ON ACTION controlp INFIELD b_prbksite name="construct.c.filter.page1.b_prbksite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbksite  #顯示到畫面上
            NEXT FIELD b_prbksite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbksite_desc>>----
         #----<<b_prbk003>>----
         #Ctrlp:construct.c.filter.page1.b_prbk003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk003
            #add-point:ON ACTION controlp INFIELD b_prbk003 name="construct.c.filter.page1.b_prbk003"
            
            #END add-point
 
 
         #----<<b_prbk001>>----
         #Ctrlp:construct.c.page1.b_prbk001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk001
            #add-point:ON ACTION controlp INFIELD b_prbk001 name="construct.c.filter.page1.b_prbk001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prbk001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk001  #顯示到畫面上
            NEXT FIELD b_prbk001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk002>>----
         #Ctrlp:construct.c.filter.page1.b_prbk002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk002
            #add-point:ON ACTION controlp INFIELD b_prbk002 name="construct.c.filter.page1.b_prbk002"
            
            #END add-point
 
 
         #----<<b_prbk004>>----
         #Ctrlp:construct.c.filter.page1.b_prbk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk004
            #add-point:ON ACTION controlp INFIELD b_prbk004 name="construct.c.filter.page1.b_prbk004"
            
            #END add-point
 
 
         #----<<b_prbk005>>----
         #Ctrlp:construct.c.page1.b_prbk005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk005
            #add-point:ON ACTION controlp INFIELD b_prbk005 name="construct.c.filter.page1.b_prbk005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk005  #顯示到畫面上
            NEXT FIELD b_prbk005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk005_desc>>----
         #----<<b_prbk006>>----
         #Ctrlp:construct.c.filter.page1.b_prbk006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk006
            #add-point:ON ACTION controlp INFIELD b_prbk006 name="construct.c.filter.page1.b_prbk006"
            
            #END add-point
 
 
         #----<<b_prbk008>>----
         #Ctrlp:construct.c.filter.page1.b_prbk008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk008
            #add-point:ON ACTION controlp INFIELD b_prbk008 name="construct.c.filter.page1.b_prbk008"
            
            #END add-point
 
 
         #----<<b_prbk007>>----
         #Ctrlp:construct.c.filter.page1.b_prbk007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk007
            #add-point:ON ACTION controlp INFIELD b_prbk007 name="construct.c.filter.page1.b_prbk007"
            
            #END add-point
 
 
         #----<<b_prbk009>>----
         #Ctrlp:construct.c.filter.page1.b_prbk009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk009
            #add-point:ON ACTION controlp INFIELD b_prbk009 name="construct.c.filter.page1.b_prbk009"
            
            #END add-point
 
 
         #----<<b_prbk011>>----
         #Ctrlp:construct.c.page1.b_prbk011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk011
            #add-point:ON ACTION controlp INFIELD b_prbk011 name="construct.c.filter.page1.b_prbk011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk011  #顯示到畫面上
            NEXT FIELD b_prbk011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk010>>----
         #Ctrlp:construct.c.page1.b_prbk010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk010
            #add-point:ON ACTION controlp INFIELD b_prbk010 name="construct.c.filter.page1.b_prbk010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk010  #顯示到畫面上
            NEXT FIELD b_prbk010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk010_desc>>----
         #----<<b_prbk010_desc1>>----
         #----<<b_prbk010_desc2>>----
         #----<<b_prbk010_desc2_desc>>----
         #----<<b_prbk012>>----
         #Ctrlp:construct.c.filter.page1.b_prbk012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk012
            #add-point:ON ACTION controlp INFIELD b_prbk012 name="construct.c.filter.page1.b_prbk012"
            
            #END add-point
 
 
         #----<<b_prbk013>>----
         #Ctrlp:construct.c.page1.b_prbk013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk013
            #add-point:ON ACTION controlp INFIELD b_prbk013 name="construct.c.filter.page1.b_prbk013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prbh001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk013  #顯示到畫面上
            NEXT FIELD b_prbk013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk014>>----
         #Ctrlp:construct.c.page1.b_prbk014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk014
            #add-point:ON ACTION controlp INFIELD b_prbk014 name="construct.c.filter.page1.b_prbk014"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk014  #顯示到畫面上
            NEXT FIELD b_prbk014                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk014_desc>>----
         #----<<b_prbk015>>----
         #Ctrlp:construct.c.filter.page1.b_prbk015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk015
            #add-point:ON ACTION controlp INFIELD b_prbk015 name="construct.c.filter.page1.b_prbk015"
            
            #END add-point
 
 
         #----<<b_prbk016>>----
         #Ctrlp:construct.c.filter.page1.b_prbk016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk016
            #add-point:ON ACTION controlp INFIELD b_prbk016 name="construct.c.filter.page1.b_prbk016"
            
            #END add-point
 
 
         #----<<b_prbk017>>----
         #Ctrlp:construct.c.page1.b_prbk017
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk017
            #add-point:ON ACTION controlp INFIELD b_prbk017 name="construct.c.filter.page1.b_prbk017"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk017  #顯示到畫面上
            NEXT FIELD b_prbk017                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk017_desc>>----
         #----<<b_prbk018>>----
         #Ctrlp:construct.c.filter.page1.b_prbk018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk018
            #add-point:ON ACTION controlp INFIELD b_prbk018 name="construct.c.filter.page1.b_prbk018"
            
            #END add-point
 
 
         #----<<b_prbk019>>----
         #Ctrlp:construct.c.page1.b_prbk019
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk019
            #add-point:ON ACTION controlp INFIELD b_prbk019 name="construct.c.filter.page1.b_prbk019"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk019  #顯示到畫面上
            NEXT FIELD b_prbk019                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk019_desc>>----
         #----<<b_prbk020>>----
         #Ctrlp:construct.c.filter.page1.b_prbk020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk020
            #add-point:ON ACTION controlp INFIELD b_prbk020 name="construct.c.filter.page1.b_prbk020"
            
            #END add-point
 
 
         #----<<b_prbk021>>----
         #Ctrlp:construct.c.filter.page1.b_prbk021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk021
            #add-point:ON ACTION controlp INFIELD b_prbk021 name="construct.c.filter.page1.b_prbk021"
            
            #END add-point
 
 
         #----<<b_prbk022>>----
         #Ctrlp:construct.c.filter.page1.b_prbk022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk022
            #add-point:ON ACTION controlp INFIELD b_prbk022 name="construct.c.filter.page1.b_prbk022"
            
            #END add-point
 
 
         #----<<b_prbk023>>----
         #Ctrlp:construct.c.filter.page1.b_prbk023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk023
            #add-point:ON ACTION controlp INFIELD b_prbk023 name="construct.c.filter.page1.b_prbk023"
            
            #END add-point
 
 
         #----<<b_prbk028>>----
         #Ctrlp:construct.c.filter.page1.b_prbk028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk028
            #add-point:ON ACTION controlp INFIELD b_prbk028 name="construct.c.filter.page1.b_prbk028"
            
            #END add-point
 
 
         #----<<b_prbk024>>----
         #Ctrlp:construct.c.filter.page1.b_prbk024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk024
            #add-point:ON ACTION controlp INFIELD b_prbk024 name="construct.c.filter.page1.b_prbk024"
            
            #END add-point
 
 
         #----<<b_prbk026>>----
         #Ctrlp:construct.c.page1.b_prbk026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk026
            #add-point:ON ACTION controlp INFIELD b_prbk026 name="construct.c.filter.page1.b_prbk026"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk026  #顯示到畫面上
            NEXT FIELD b_prbk026                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk026_desc>>----
         #----<<b_prbk027>>----
         #Ctrlp:construct.c.page1.b_prbk027
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbk027
            #add-point:ON ACTION controlp INFIELD b_prbk027 name="construct.c.filter.page1.b_prbk027"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbk027  #顯示到畫面上
            NEXT FIELD b_prbk027                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbk027_desc>>----
         #----<<b_prbkunit>>----
         #Ctrlp:construct.c.filter.page1.b_prbkunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbkunit
            #add-point:ON ACTION controlp INFIELD b_prbkunit name="construct.c.filter.page1.b_prbkunit"
            
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
   
      CALL aprq124_filter_show('prbkstus','b_prbkstus')
   CALL aprq124_filter_show('prbk025','b_prbk025')
   CALL aprq124_filter_show('prbksite','b_prbksite')
   CALL aprq124_filter_show('prbk003','b_prbk003')
   CALL aprq124_filter_show('prbk001','b_prbk001')
   CALL aprq124_filter_show('prbk002','b_prbk002')
   CALL aprq124_filter_show('prbk004','b_prbk004')
   CALL aprq124_filter_show('prbk005','b_prbk005')
   CALL aprq124_filter_show('prbk006','b_prbk006')
   CALL aprq124_filter_show('prbk008','b_prbk008')
   CALL aprq124_filter_show('prbk007','b_prbk007')
   CALL aprq124_filter_show('prbk009','b_prbk009')
   CALL aprq124_filter_show('prbk011','b_prbk011')
   CALL aprq124_filter_show('prbk010','b_prbk010')
   CALL aprq124_filter_show('prbk012','b_prbk012')
   CALL aprq124_filter_show('prbk013','b_prbk013')
   CALL aprq124_filter_show('prbk014','b_prbk014')
   CALL aprq124_filter_show('prbk015','b_prbk015')
   CALL aprq124_filter_show('prbk016','b_prbk016')
   CALL aprq124_filter_show('prbk017','b_prbk017')
   CALL aprq124_filter_show('prbk018','b_prbk018')
   CALL aprq124_filter_show('prbk019','b_prbk019')
   CALL aprq124_filter_show('prbk020','b_prbk020')
   CALL aprq124_filter_show('prbk021','b_prbk021')
   CALL aprq124_filter_show('prbk022','b_prbk022')
   CALL aprq124_filter_show('prbk023','b_prbk023')
   CALL aprq124_filter_show('prbk028','b_prbk028')
   CALL aprq124_filter_show('prbk024','b_prbk024')
   CALL aprq124_filter_show('prbk026','b_prbk026')
   CALL aprq124_filter_show('prbk027','b_prbk027')
   CALL aprq124_filter_show('prbkunit','b_prbkunit')
 
    
   CALL aprq124_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aprq124_filter_parser(ps_field)
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
 
{<section id="aprq124.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aprq124_filter_show(ps_field,ps_object)
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
   LET ls_condition = aprq124_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.insert" >}
#+ insert
PRIVATE FUNCTION aprq124_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprq124.modify" >}
#+ modify
PRIVATE FUNCTION aprq124_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aprq124_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.delete" >}
#+ delete
PRIVATE FUNCTION aprq124_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq124.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aprq124_detail_action_trans()
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
 
{<section id="aprq124.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aprq124_detail_index_setting()
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
            IF g_prbk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_prbk_d.getLength() AND g_prbk_d.getLength() > 0
            LET g_detail_idx = g_prbk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_prbk_d.getLength() THEN
               LET g_detail_idx = g_prbk_d.getLength()
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
 
{<section id="aprq124.mask_functions" >}
 &include "erp/apr/aprq124_mask.4gl"
 
{</section>}
 
{<section id="aprq124.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 說明欄位顯示
# Memo...........:
# Usage..........: CALL aprq124_prbk_ref_show()
# Date & Author..: 2014/03/20 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq124_prbk_ref_show()
DEFINE l_ooef019      LIKE ooef_t.ooef019


   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk005
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk005_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk005_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk026
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk026_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk026_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk027
   CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk027_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk027_desc            
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbksite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbksite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbksite_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk010_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk010_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk010_desc1 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk010_desc1
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? ","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk010_desc2 = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk010_desc2
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk010_desc2
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk010_desc2_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk010_desc2_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_prbk_d[l_ac].prbk014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk014_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk014_desc
   
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_prbk_d[l_ac].prbksite
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooef019
   LET g_ref_fields[2] = g_prbk_d[l_ac].prbk017
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk017_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk017_desc

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = l_ooef019
   LET g_ref_fields[2] = g_prbk_d[l_ac].prbk019
   CALL ap_ref_array2(g_ref_fields,"SELECT oodbl004 FROM oodbl_t WHERE oodblent='"||g_enterprise||"' AND oodbl001=? AND oodbl002=? AND oodbl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_prbk_d[l_ac].prbk019_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_prbk_d[l_ac].prbk019_desc
            
END FUNCTION

 
{</section>}
 
