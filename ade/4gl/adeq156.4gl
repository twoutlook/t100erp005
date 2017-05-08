#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq156.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-12-02 16:55:48), PR版次:0004(2016-10-18 17:28:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: adeq156
#+ Description: 門店銷售部門週結查詢
#+ Creator....: 06778(2015-06-19 11:31:18)
#+ Modifier...: 06815 -SD/PR- 02159
 
{</section>}
 
{<section id="adeq156.global" >}
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
PRIVATE TYPE type_g_decn_d RECORD
       #statepic       LIKE type_t.chr1,
       
       decnsite LIKE decn_t.decnsite, 
   decnsite_desc LIKE type_t.chr500, 
   decn001 LIKE decn_t.decn001, 
   decn024 LIKE decn_t.decn024, 
   decn025 LIKE decn_t.decn025, 
   decn005 LIKE decn_t.decn005, 
   decn005_desc LIKE type_t.chr500, 
   decn006 LIKE decn_t.decn006, 
   decn007 LIKE decn_t.decn007, 
   decn008 LIKE decn_t.decn008, 
   decn009 LIKE decn_t.decn009, 
   decn010 LIKE decn_t.decn010, 
   decn011 LIKE decn_t.decn011, 
   decn012 LIKE decn_t.decn012, 
   decn013 LIKE decn_t.decn013, 
   decn022 LIKE decn_t.decn022, 
   decn023 LIKE decn_t.decn023, 
   decn014 LIKE decn_t.decn014, 
   decn015 LIKE decn_t.decn015, 
   decn016 LIKE decn_t.decn016, 
   decn017 LIKE decn_t.decn017, 
   decn020 LIKE decn_t.decn020, 
   decn021 LIKE decn_t.decn021, 
   decn018 LIKE decn_t.decn018, 
   decn019 LIKE decn_t.decn019 
       END RECORD
PRIVATE TYPE type_g_decn2_d RECORD
       deco006 LIKE deco_t.deco006, 
   deco006_desc LIKE type_t.chr500, 
   deco007 LIKE deco_t.deco007, 
   deco007_desc LIKE type_t.chr500, 
   deco008 LIKE deco_t.deco008, 
   deco009 LIKE deco_t.deco009, 
   deco010 LIKE deco_t.deco010, 
   deco011 LIKE deco_t.deco011, 
   deco012 LIKE deco_t.deco012, 
   deco013 LIKE deco_t.deco013, 
   deco018 LIKE deco_t.deco018, 
   deco019 LIKE deco_t.deco019, 
   deco020 LIKE deco_t.deco020, 
   deco014 LIKE deco_t.deco014, 
   deco015 LIKE deco_t.deco015, 
   deco016 LIKE deco_t.deco016, 
   deco017 LIKE deco_t.deco017
       END RECORD
 
PRIVATE TYPE type_g_decn3_d RECORD
       decp007 LIKE decp_t.decp007, 
   decp006 LIKE decp_t.decp006, 
   decp006_desc LIKE type_t.chr500, 
   decp008 LIKE decp_t.decp008
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_decn4_d RECORD
       decp007 LIKE decp_t.decp007, 
   decp006 LIKE decp_t.decp006, 
   decp006_desc_1 LIKE type_t.chr500, 
   decp008 LIKE decp_t.decp008
       END RECORD
DEFINE g_decn4_d   DYNAMIC ARRAY OF type_g_decn4_d
DEFINE g_decn4_d_t type_g_decn4_d
DEFINE g_site_type    LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_decn_d
DEFINE g_master_t                   type_g_decn_d
DEFINE g_decn_d          DYNAMIC ARRAY OF type_g_decn_d
DEFINE g_decn_d_t        type_g_decn_d
DEFINE g_decn2_d   DYNAMIC ARRAY OF type_g_decn2_d
DEFINE g_decn2_d_t type_g_decn2_d
 
DEFINE g_decn3_d   DYNAMIC ARRAY OF type_g_decn3_d
DEFINE g_decn3_d_t type_g_decn3_d
 
 
      
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

#end add-point
 
{</section>}
 
{<section id="adeq156.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #151012-00012#5 20151022 add by beckxie
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
   DECLARE adeq156_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq156_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq156_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq156 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq156_init()   
 
      #進入選單 Menu (="N")
      CALL adeq156_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq156
      
   END IF 
   
   CLOSE adeq156_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #151012-00012#5 20151022 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq156.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq156_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #151012-00012#5 20151022 add by beckxie
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_decn001','6540') 
   CALL cl_set_combo_scc('b_decp007','8310') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #151012-00012#5 20151022 add by beckxie
   CALL cl_set_combo_scc('b_decp007_1','8310')
   CALL g_decn4_d.clear()   #151012-00012#5 20151022 add by beckxie
   #end add-point
 
   CALL adeq156_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq156.default_search" >}
PRIVATE FUNCTION adeq156_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " decnsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " decn005 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " decn024 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " decn025 = '", g_argv[04], "' AND "
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
 
{<section id="adeq156.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq156_ui_dialog()
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
      CALL adeq156_b_fill()
   ELSE
      CALL adeq156_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_decn_d.clear()
         CALL g_decn2_d.clear()
 
         CALL g_decn3_d.clear()
 
 
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
 
         CALL adeq156_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_decn_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq156_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq156_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_decn2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_decn2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_decn3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_decn3_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point 
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_decn4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 4
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_decn4_d.getLength() TO FORMONLY.cnt        
         END DISPLAY

         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq156_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq156_insert()
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
               CALL adeq156_query()
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
            CALL adeq156_filter()
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
            CALL adeq156_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_decn_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_decn2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_decn3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL adeq156_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq156_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq156_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq156_b_fill()
 
         
         
 
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
 
{<section id="adeq156.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq156_query()
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
   CALL g_decn_d.clear()
   CALL g_decn2_d.clear()
 
   CALL g_decn3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON decnsite,decn001,decn024,decn025,decn005,decn006,decn007,decn008,decn009, 
          decn010,decn011,decn012,decn013,decn022,decn023,decn014,decn015,decn016,decn017,decn020,decn021, 
          decn018,decn019
           FROM s_detail1[1].b_decnsite,s_detail1[1].b_decn001,s_detail1[1].b_decn024,s_detail1[1].b_decn025, 
               s_detail1[1].b_decn005,s_detail1[1].b_decn006,s_detail1[1].b_decn007,s_detail1[1].b_decn008, 
               s_detail1[1].b_decn009,s_detail1[1].b_decn010,s_detail1[1].b_decn011,s_detail1[1].b_decn012, 
               s_detail1[1].b_decn013,s_detail1[1].b_decn022,s_detail1[1].b_decn023,s_detail1[1].b_decn014, 
               s_detail1[1].b_decn015,s_detail1[1].b_decn016,s_detail1[1].b_decn017,s_detail1[1].b_decn020, 
               s_detail1[1].b_decn021,s_detail1[1].b_decn018,s_detail1[1].b_decn019
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO s_detail1[1].b_decnsite   #151012-00012#5 20151026 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_decnsite>>----
         #Ctrlp:construct.c.page1.b_decnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decnsite
            #add-point:ON ACTION controlp INFIELD b_decnsite name="construct.c.page1.b_decnsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decnsite',g_site,'c') #150308-00001#2  By sakura add 'c'
            CALL q_ooef001_24()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decnsite  #顯示到畫面上
            NEXT FIELD b_decnsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decnsite
            #add-point:BEFORE FIELD b_decnsite name="construct.b.page1.b_decnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decnsite
            
            #add-point:AFTER FIELD b_decnsite name="construct.a.page1.b_decnsite"
            
            #END add-point
            
 
 
         #----<<b_decnsite_desc>>----
         #----<<b_decn001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn001
            #add-point:BEFORE FIELD b_decn001 name="construct.b.page1.b_decn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn001
            
            #add-point:AFTER FIELD b_decn001 name="construct.a.page1.b_decn001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn001
            #add-point:ON ACTION controlp INFIELD b_decn001 name="construct.c.page1.b_decn001"
            
            #END add-point
 
 
         #----<<b_decn024>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn024
            #add-point:BEFORE FIELD b_decn024 name="construct.b.page1.b_decn024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn024
            
            #add-point:AFTER FIELD b_decn024 name="construct.a.page1.b_decn024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn024
            #add-point:ON ACTION controlp INFIELD b_decn024 name="construct.c.page1.b_decn024"
            
            #END add-point
 
 
         #----<<b_decn025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn025
            #add-point:BEFORE FIELD b_decn025 name="construct.b.page1.b_decn025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn025
            
            #add-point:AFTER FIELD b_decn025 name="construct.a.page1.b_decn025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn025
            #add-point:ON ACTION controlp INFIELD b_decn025 name="construct.c.page1.b_decn025"
            
            #END add-point
 
 
         #----<<b_decn005>>----
         #Ctrlp:construct.c.page1.b_decn005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn005
            #add-point:ON ACTION controlp INFIELD b_decn005 name="construct.c.page1.b_decn005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_today
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decn005  #顯示到畫面上
            NEXT FIELD b_decn005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn005
            #add-point:BEFORE FIELD b_decn005 name="construct.b.page1.b_decn005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn005
            
            #add-point:AFTER FIELD b_decn005 name="construct.a.page1.b_decn005"
            
            #END add-point
            
 
 
         #----<<b_decn005_desc>>----
         #----<<b_decn006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn006
            #add-point:BEFORE FIELD b_decn006 name="construct.b.page1.b_decn006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn006
            
            #add-point:AFTER FIELD b_decn006 name="construct.a.page1.b_decn006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn006
            #add-point:ON ACTION controlp INFIELD b_decn006 name="construct.c.page1.b_decn006"
            
            #END add-point
 
 
         #----<<b_decn007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn007
            #add-point:BEFORE FIELD b_decn007 name="construct.b.page1.b_decn007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn007
            
            #add-point:AFTER FIELD b_decn007 name="construct.a.page1.b_decn007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn007
            #add-point:ON ACTION controlp INFIELD b_decn007 name="construct.c.page1.b_decn007"
            
            #END add-point
 
 
         #----<<b_decn008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn008
            #add-point:BEFORE FIELD b_decn008 name="construct.b.page1.b_decn008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn008
            
            #add-point:AFTER FIELD b_decn008 name="construct.a.page1.b_decn008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn008
            #add-point:ON ACTION controlp INFIELD b_decn008 name="construct.c.page1.b_decn008"
            
            #END add-point
 
 
         #----<<b_decn009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn009
            #add-point:BEFORE FIELD b_decn009 name="construct.b.page1.b_decn009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn009
            
            #add-point:AFTER FIELD b_decn009 name="construct.a.page1.b_decn009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn009
            #add-point:ON ACTION controlp INFIELD b_decn009 name="construct.c.page1.b_decn009"
            
            #END add-point
 
 
         #----<<b_decn010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn010
            #add-point:BEFORE FIELD b_decn010 name="construct.b.page1.b_decn010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn010
            
            #add-point:AFTER FIELD b_decn010 name="construct.a.page1.b_decn010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn010
            #add-point:ON ACTION controlp INFIELD b_decn010 name="construct.c.page1.b_decn010"
            
            #END add-point
 
 
         #----<<b_decn011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn011
            #add-point:BEFORE FIELD b_decn011 name="construct.b.page1.b_decn011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn011
            
            #add-point:AFTER FIELD b_decn011 name="construct.a.page1.b_decn011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn011
            #add-point:ON ACTION controlp INFIELD b_decn011 name="construct.c.page1.b_decn011"
            
            #END add-point
 
 
         #----<<b_decn012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn012
            #add-point:BEFORE FIELD b_decn012 name="construct.b.page1.b_decn012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn012
            
            #add-point:AFTER FIELD b_decn012 name="construct.a.page1.b_decn012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn012
            #add-point:ON ACTION controlp INFIELD b_decn012 name="construct.c.page1.b_decn012"
            
            #END add-point
 
 
         #----<<b_decn013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn013
            #add-point:BEFORE FIELD b_decn013 name="construct.b.page1.b_decn013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn013
            
            #add-point:AFTER FIELD b_decn013 name="construct.a.page1.b_decn013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn013
            #add-point:ON ACTION controlp INFIELD b_decn013 name="construct.c.page1.b_decn013"
            
            #END add-point
 
 
         #----<<b_decn022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn022
            #add-point:BEFORE FIELD b_decn022 name="construct.b.page1.b_decn022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn022
            
            #add-point:AFTER FIELD b_decn022 name="construct.a.page1.b_decn022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn022
            #add-point:ON ACTION controlp INFIELD b_decn022 name="construct.c.page1.b_decn022"
            
            #END add-point
 
 
         #----<<b_decn023>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn023
            #add-point:BEFORE FIELD b_decn023 name="construct.b.page1.b_decn023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn023
            
            #add-point:AFTER FIELD b_decn023 name="construct.a.page1.b_decn023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn023
            #add-point:ON ACTION controlp INFIELD b_decn023 name="construct.c.page1.b_decn023"
            
            #END add-point
 
 
         #----<<b_decn014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn014
            #add-point:BEFORE FIELD b_decn014 name="construct.b.page1.b_decn014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn014
            
            #add-point:AFTER FIELD b_decn014 name="construct.a.page1.b_decn014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn014
            #add-point:ON ACTION controlp INFIELD b_decn014 name="construct.c.page1.b_decn014"
            
            #END add-point
 
 
         #----<<b_decn015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn015
            #add-point:BEFORE FIELD b_decn015 name="construct.b.page1.b_decn015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn015
            
            #add-point:AFTER FIELD b_decn015 name="construct.a.page1.b_decn015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn015
            #add-point:ON ACTION controlp INFIELD b_decn015 name="construct.c.page1.b_decn015"
            
            #END add-point
 
 
         #----<<b_decn016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn016
            #add-point:BEFORE FIELD b_decn016 name="construct.b.page1.b_decn016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn016
            
            #add-point:AFTER FIELD b_decn016 name="construct.a.page1.b_decn016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn016
            #add-point:ON ACTION controlp INFIELD b_decn016 name="construct.c.page1.b_decn016"
            
            #END add-point
 
 
         #----<<b_decn017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn017
            #add-point:BEFORE FIELD b_decn017 name="construct.b.page1.b_decn017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn017
            
            #add-point:AFTER FIELD b_decn017 name="construct.a.page1.b_decn017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn017
            #add-point:ON ACTION controlp INFIELD b_decn017 name="construct.c.page1.b_decn017"
            
            #END add-point
 
 
         #----<<b_decn020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn020
            #add-point:BEFORE FIELD b_decn020 name="construct.b.page1.b_decn020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn020
            
            #add-point:AFTER FIELD b_decn020 name="construct.a.page1.b_decn020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn020
            #add-point:ON ACTION controlp INFIELD b_decn020 name="construct.c.page1.b_decn020"
            
            #END add-point
 
 
         #----<<b_decn021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn021
            #add-point:BEFORE FIELD b_decn021 name="construct.b.page1.b_decn021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn021
            
            #add-point:AFTER FIELD b_decn021 name="construct.a.page1.b_decn021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn021
            #add-point:ON ACTION controlp INFIELD b_decn021 name="construct.c.page1.b_decn021"
            
            #END add-point
 
 
         #----<<b_decn018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn018
            #add-point:BEFORE FIELD b_decn018 name="construct.b.page1.b_decn018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn018
            
            #add-point:AFTER FIELD b_decn018 name="construct.a.page1.b_decn018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn018
            #add-point:ON ACTION controlp INFIELD b_decn018 name="construct.c.page1.b_decn018"
            
            #END add-point
 
 
         #----<<b_decn019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decn019
            #add-point:BEFORE FIELD b_decn019 name="construct.b.page1.b_decn019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decn019
            
            #add-point:AFTER FIELD b_decn019 name="construct.a.page1.b_decn019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_decn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn019
            #add-point:ON ACTION controlp INFIELD b_decn019 name="construct.c.page1.b_decn019"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON deco006,deco007,deco008,deco009,deco010,deco011,deco012,deco013,deco018, 
          deco019,deco020,deco014,deco015,deco016,deco017
           FROM s_detail2[1].b_deco006,s_detail2[1].b_deco007,s_detail2[1].b_deco008,s_detail2[1].b_deco009, 
               s_detail2[1].b_deco010,s_detail2[1].b_deco011,s_detail2[1].b_deco012,s_detail2[1].b_deco013, 
               s_detail2[1].b_deco018,s_detail2[1].b_deco019,s_detail2[1].b_deco020,s_detail2[1].b_deco014, 
               s_detail2[1].b_deco015,s_detail2[1].b_deco016,s_detail2[1].b_deco017
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            DISPLAY '' TO s_detail2[1].b_deco006   #151012-00012#5 20151026 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_deco006>>----
         #Ctrlp:construct.c.page2.b_deco006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco006
            #add-point:ON ACTION controlp INFIELD b_deco006 name="construct.c.page2.b_deco006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_mman001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deco006  #顯示到畫面上
            NEXT FIELD b_deco006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco006
            #add-point:BEFORE FIELD b_deco006 name="construct.b.page2.b_deco006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco006
            
            #add-point:AFTER FIELD b_deco006 name="construct.a.page2.b_deco006"
            
            #END add-point
            
 
 
         #----<<b_deco006_desc>>----
         #----<<b_deco007>>----
         #Ctrlp:construct.c.page2.b_deco007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco007
            #add-point:ON ACTION controlp INFIELD b_deco007 name="construct.c.page2.b_deco007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2024'
            CALL q_oocq002()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deco007  #顯示到畫面上
            NEXT FIELD b_deco007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco007
            #add-point:BEFORE FIELD b_deco007 name="construct.b.page2.b_deco007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco007
            
            #add-point:AFTER FIELD b_deco007 name="construct.a.page2.b_deco007"
            
            #END add-point
            
 
 
         #----<<b_deco007_desc>>----
         #----<<b_deco008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco008
            #add-point:BEFORE FIELD b_deco008 name="construct.b.page2.b_deco008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco008
            
            #add-point:AFTER FIELD b_deco008 name="construct.a.page2.b_deco008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco008
            #add-point:ON ACTION controlp INFIELD b_deco008 name="construct.c.page2.b_deco008"
            
            #END add-point
 
 
         #----<<b_deco009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco009
            #add-point:BEFORE FIELD b_deco009 name="construct.b.page2.b_deco009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco009
            
            #add-point:AFTER FIELD b_deco009 name="construct.a.page2.b_deco009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco009
            #add-point:ON ACTION controlp INFIELD b_deco009 name="construct.c.page2.b_deco009"
            
            #END add-point
 
 
         #----<<b_deco010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco010
            #add-point:BEFORE FIELD b_deco010 name="construct.b.page2.b_deco010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco010
            
            #add-point:AFTER FIELD b_deco010 name="construct.a.page2.b_deco010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco010
            #add-point:ON ACTION controlp INFIELD b_deco010 name="construct.c.page2.b_deco010"
            
            #END add-point
 
 
         #----<<b_deco011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco011
            #add-point:BEFORE FIELD b_deco011 name="construct.b.page2.b_deco011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco011
            
            #add-point:AFTER FIELD b_deco011 name="construct.a.page2.b_deco011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco011
            #add-point:ON ACTION controlp INFIELD b_deco011 name="construct.c.page2.b_deco011"
            
            #END add-point
 
 
         #----<<b_deco012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco012
            #add-point:BEFORE FIELD b_deco012 name="construct.b.page2.b_deco012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco012
            
            #add-point:AFTER FIELD b_deco012 name="construct.a.page2.b_deco012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco012
            #add-point:ON ACTION controlp INFIELD b_deco012 name="construct.c.page2.b_deco012"
            
            #END add-point
 
 
         #----<<b_deco013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco013
            #add-point:BEFORE FIELD b_deco013 name="construct.b.page2.b_deco013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco013
            
            #add-point:AFTER FIELD b_deco013 name="construct.a.page2.b_deco013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco013
            #add-point:ON ACTION controlp INFIELD b_deco013 name="construct.c.page2.b_deco013"
            
            #END add-point
 
 
         #----<<b_deco018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco018
            #add-point:BEFORE FIELD b_deco018 name="construct.b.page2.b_deco018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco018
            
            #add-point:AFTER FIELD b_deco018 name="construct.a.page2.b_deco018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco018
            #add-point:ON ACTION controlp INFIELD b_deco018 name="construct.c.page2.b_deco018"
            
            #END add-point
 
 
         #----<<b_deco019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco019
            #add-point:BEFORE FIELD b_deco019 name="construct.b.page2.b_deco019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco019
            
            #add-point:AFTER FIELD b_deco019 name="construct.a.page2.b_deco019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco019
            #add-point:ON ACTION controlp INFIELD b_deco019 name="construct.c.page2.b_deco019"
            
            #END add-point
 
 
         #----<<b_deco020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco020
            #add-point:BEFORE FIELD b_deco020 name="construct.b.page2.b_deco020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco020
            
            #add-point:AFTER FIELD b_deco020 name="construct.a.page2.b_deco020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco020
            #add-point:ON ACTION controlp INFIELD b_deco020 name="construct.c.page2.b_deco020"
            
            #END add-point
 
 
         #----<<b_deco014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco014
            #add-point:BEFORE FIELD b_deco014 name="construct.b.page2.b_deco014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco014
            
            #add-point:AFTER FIELD b_deco014 name="construct.a.page2.b_deco014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco014
            #add-point:ON ACTION controlp INFIELD b_deco014 name="construct.c.page2.b_deco014"
            
            #END add-point
 
 
         #----<<b_deco015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco015
            #add-point:BEFORE FIELD b_deco015 name="construct.b.page2.b_deco015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco015
            
            #add-point:AFTER FIELD b_deco015 name="construct.a.page2.b_deco015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco015
            #add-point:ON ACTION controlp INFIELD b_deco015 name="construct.c.page2.b_deco015"
            
            #END add-point
 
 
         #----<<b_deco016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco016
            #add-point:BEFORE FIELD b_deco016 name="construct.b.page2.b_deco016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco016
            
            #add-point:AFTER FIELD b_deco016 name="construct.a.page2.b_deco016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco016
            #add-point:ON ACTION controlp INFIELD b_deco016 name="construct.c.page2.b_deco016"
            
            #END add-point
 
 
         #----<<b_deco017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deco017
            #add-point:BEFORE FIELD b_deco017 name="construct.b.page2.b_deco017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deco017
            
            #add-point:AFTER FIELD b_deco017 name="construct.a.page2.b_deco017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_deco017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deco017
            #add-point:ON ACTION controlp INFIELD b_deco017 name="construct.c.page2.b_deco017"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
 
      CONSTRUCT g_wc2_table3 ON decp007,decp006,decp008
           FROM s_detail3[1].b_decp007,s_detail3[1].b_decp006,s_detail3[1].b_decp008
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body3.before_construct"
            DISPLAY '' TO s_detail3[1].b_decp007   #151012-00012#5 20151026 add by beckxie
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 3)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_decp007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decp007
            #add-point:BEFORE FIELD b_decp007 name="construct.b.page3.b_decp007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decp007
            
            #add-point:AFTER FIELD b_decp007 name="construct.a.page3.b_decp007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decp007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decp007
            #add-point:ON ACTION controlp INFIELD b_decp007 name="construct.c.page3.b_decp007"
            
            #END add-point
 
 
         #----<<b_decp006>>----
         #Ctrlp:construct.c.page3.b_decp006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decp006
            #add-point:ON ACTION controlp INFIELD b_decp006 name="construct.c.page3.b_decp006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_ooia001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decp006  #顯示到畫面上
            NEXT FIELD b_decp006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decp006
            #add-point:BEFORE FIELD b_decp006 name="construct.b.page3.b_decp006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decp006
            
            #add-point:AFTER FIELD b_decp006 name="construct.a.page3.b_decp006"
            
            #END add-point
            
 
 
         #----<<b_decp006_desc>>----
         #----<<b_decp008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_decp008
            #add-point:BEFORE FIELD b_decp008 name="construct.b.page3.b_decp008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_decp008
            
            #add-point:AFTER FIELD b_decp008 name="construct.a.page3.b_decp008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_decp008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decp008
            #add-point:ON ACTION controlp INFIELD b_decp008 name="construct.c.page3.b_decp008"
            
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
   CALL adeq156_b_fill()
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
 
{<section id="adeq156.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq156_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'decnsite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE decnsite,'',decn001,decn024,decn025,decn005,'',decn006,decn007, 
       decn008,decn009,decn010,decn011,decn012,decn013,decn022,decn023,decn014,decn015,decn016,decn017, 
       decn020,decn021,decn018,decn019  ,DENSE_RANK() OVER( ORDER BY decn_t.decnsite,decn_t.decn005, 
       decn_t.decn024,decn_t.decn025) AS RANK FROM decn_t",
 
                     " LEFT JOIN deco_t ON decoent = decnent AND decnsite = decosite AND decn005 = deco005 AND decn024 = deco021 AND decn025 = deco022",
 
                     " LEFT JOIN decp_t ON decpent = decnent AND decnsite = decpsite AND decn005 = decp005 AND decn024 = decp009 AND decn025 = decp010",
 
 
                     "",
                     " WHERE decnent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decn_t"),
                     " ORDER BY decn_t.decnsite,decn_t.decn005,decn_t.decn024,decn_t.decn025"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 20150911 s983961--add(s) 效能調整
   LET ls_sql_rank = "SELECT  UNIQUE decnsite, ",
         "                   (SELECT ooefl003 FROM ooefl_t ",
         "                     WHERE ooeflent = decnent ",
         "                       AND ooefl001 = decnsite ",
         "                       AND ooefl002 ='"||g_dlang||"') decnsite_desc, ",   
         "                   decn001,decn024,decn025,decn005, ",
         "                   (SELECT ooefl003 FROM ooefl_t ",
         "                     WHERE ooeflent = decnent ",
         "                       AND ooefl001 = decn005 ",
         "                       AND ooefl002 ='"||g_dlang||"') decn005_desc, ",
         "                   decn006,decn007,decn008,decn009, ",
         "                   decn010,decn011,decn012,decn013, ",
         "                   decn022,decn023,decn014,decn015, ",
         "                   decn016,decn017,decn020,decn021, ",
         "                   decn018,decn019,",
         "   DENSE_RANK() OVER( ORDER BY decn_t.decnsite,decn_t.decn005,decn_t.decn024,decn_t.decn025) AS RANK ",
         "               FROM decn_t ",
         #20151026 s983961--add(s) left join第二第三單身 QBE查詢才能串的到條件 
         "         LEFT JOIN deco_t ON decoent = decnent AND decnsite = decosite AND decn005 = deco005 AND decn024 = deco021 AND decn025 = deco022",
         "         LEFT JOIN decp_t ON decpent = decnent AND decnsite = decpsite AND decn005 = decp005 AND decn024 = decp009 AND decn025 = decp010",
         #20151026 s983961--add(s) left join第二第三單身 QBE查詢才能串的到條件 
         "              WHERE decnent = ? ",
         "                AND 1=1 ",
         "                AND ", ls_wc
       
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decn_t"),
                 " ORDER BY decn_t.decnsite,decn_t.decn005,decn_t.decn024,decn_t.decn025"
   #150826-00013#2 20150911 s983961--add(e) 效能調整               
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
 
   LET g_sql = "SELECT decnsite,'',decn001,decn024,decn025,decn005,'',decn006,decn007,decn008,decn009, 
       decn010,decn011,decn012,decn013,decn022,decn023,decn014,decn015,decn016,decn017,decn020,decn021, 
       decn018,decn019",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整
   #LET g_sql = "SELECT decnsite,t1.ooefl003,decn001,decn024,decn025,decn005,t2.ooefl003,decn006,decn007,decn008,decn009, 
   #    decn010,decn011,decn012,decn013,decn022,decn023,decn014,decn015,decn016,decn017,decn020,decn021, 
   #    decn018,decn019",
   #            " FROM decn_t ",
   #    "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = decnent AND t1.ooefl001 = decnsite AND t1.ooefl002 = '",g_dlang,"' ",
   #    "       LEFT JOIN ooefl_t t2 ON t2.ooeflent = decnent AND t2.ooefl001 = decn005  AND t2.ooefl002 = '",g_dlang,"' ",
   #    " WHERE decnent = ? ",
   #    "   AND ", ls_wc,cl_sql_add_filter("decn_t")
   #    
   #    LET g_sql = g_sql, cl_sql_add_filter("decn_t"),
   #                   " ORDER BY decn_t.decnsite,decn_t.decn005,decn_t.decn024,decn_t.decn025"
   
   LET g_sql = "SELECT decnsite,decnsite_desc,decn001,decn024,decn025,decn005,decn005_desc,
                       decn006,decn007,decn008,decn009,decn010,decn011,decn012,decn013,decn022,
                       decn023,decn014,decn015,decn016,decn017,decn020,decn021,decn018,decn019",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整            
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq156_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq156_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_decn_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_decn_d[l_ac].decnsite,g_decn_d[l_ac].decnsite_desc,g_decn_d[l_ac].decn001, 
       g_decn_d[l_ac].decn024,g_decn_d[l_ac].decn025,g_decn_d[l_ac].decn005,g_decn_d[l_ac].decn005_desc, 
       g_decn_d[l_ac].decn006,g_decn_d[l_ac].decn007,g_decn_d[l_ac].decn008,g_decn_d[l_ac].decn009,g_decn_d[l_ac].decn010, 
       g_decn_d[l_ac].decn011,g_decn_d[l_ac].decn012,g_decn_d[l_ac].decn013,g_decn_d[l_ac].decn022,g_decn_d[l_ac].decn023, 
       g_decn_d[l_ac].decn014,g_decn_d[l_ac].decn015,g_decn_d[l_ac].decn016,g_decn_d[l_ac].decn017,g_decn_d[l_ac].decn020, 
       g_decn_d[l_ac].decn021,g_decn_d[l_ac].decn018,g_decn_d[l_ac].decn019
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_decn_d[l_ac].statepic = cl_get_actipic(g_decn_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq156_detail_show("'1'")      
 
      CALL adeq156_decn_t_mask()
 
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
   
 
   
   CALL g_decn_d.deleteElement(g_decn_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整   
   #LET g_sql = " SELECT decp007,decp006,ooial003,SUM(decp008) ",
   #            "   FROM (SELECT UNIQUE decnent,decnsite,decn005,decn024,decn025, ",
   #            "                       decp007,decp006,decp008,t1.ooial003 ",
   #            "           FROM decn_t",
   #            "                LEFT JOIN deco_t ON decoent = decnent AND decosite = decnsite AND deco005 = decn005 ",        
   #            "                                AND deco021 = decn024 AND deco022 = decn025",
   #            "                LEFT JOIN decp_t ON decpent = decnent AND decpsite = decnsite AND decp005 = decn005 ",
   #            "                                AND decp009 = decn024 AND decp010 = decn025 ",
   #            "                LEFT JOIN ooial_t t1 ON t1.ooialent = decnent AND t1.ooial001 = decp006 ",
   #            "                                    AND t1.ooial002 = '",g_dlang,"' ",
   #            "          WHERE decnent= ? AND decp006 IS NOT NULL AND ", ls_wc,")",
   #            " GROUP BY decp007,decp006,ooial003",
   #            " ORDER BY decp007,decp006"
   #
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)
   
   LET g_sql = " SELECT decp007,decp006, ",
               "        ooial003, ",
               "        SUM(decp008) ",
               "   FROM (SELECT UNIQUE decnent,decnsite,decn005,decn024,decn025, ",
               "                       decp007,decp006,decp008, ",
               "                       (SELECT ooial003 FROM ooial_t ",
               "                         WHERE ooialent = decnent ",
               "                           AND ooial001 = decp006 ",
               "                           AND ooial002 ='"||g_dlang||"') ooial003 ",   
               "           FROM decn_t",
               "                LEFT JOIN deco_t ON decoent = decnent AND decosite = decnsite AND deco005 = decn005 ",        
               "                                AND deco021 = decn024 AND deco022 = decn025",
               "                LEFT JOIN decp_t ON decpent = decnent AND decpsite = decnsite AND decp005 = decn005 ",
               "                                AND decp009 = decn024 AND decp010 = decn025 ",
               "          WHERE decnent= ? AND decp006 IS NOT NULL AND ", ls_wc,")",
               " GROUP BY decp007,decp006,ooial003",
               " ORDER BY decp007,decp006"
   PREPARE adeq156_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq156_pb1
   #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整   
   #end add-point
 
   LET g_detail_cnt = g_decn_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq156_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq156_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq156_detail_action_trans()
 
   IF g_decn_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq156_fetch()
   END IF
   
      CALL adeq156_filter_show('decnsite','b_decnsite')
   CALL adeq156_filter_show('decn001','b_decn001')
   CALL adeq156_filter_show('decn024','b_decn024')
   CALL adeq156_filter_show('decn025','b_decn025')
   CALL adeq156_filter_show('decn005','b_decn005')
   CALL adeq156_filter_show('decn006','b_decn006')
   CALL adeq156_filter_show('decn007','b_decn007')
   CALL adeq156_filter_show('decn008','b_decn008')
   CALL adeq156_filter_show('decn009','b_decn009')
   CALL adeq156_filter_show('decn010','b_decn010')
   CALL adeq156_filter_show('decn011','b_decn011')
   CALL adeq156_filter_show('decn012','b_decn012')
   CALL adeq156_filter_show('decn013','b_decn013')
   CALL adeq156_filter_show('decn022','b_decn022')
   CALL adeq156_filter_show('decn023','b_decn023')
   CALL adeq156_filter_show('decn014','b_decn014')
   CALL adeq156_filter_show('decn015','b_decn015')
   CALL adeq156_filter_show('decn016','b_decn016')
   CALL adeq156_filter_show('decn017','b_decn017')
   CALL adeq156_filter_show('decn020','b_decn020')
   CALL adeq156_filter_show('decn021','b_decn021')
   CALL adeq156_filter_show('decn018','b_decn018')
   CALL adeq156_filter_show('decn019','b_decn019')
   CALL adeq156_filter_show('deco006','b_deco006')
   CALL adeq156_filter_show('deco007','b_deco007')
   CALL adeq156_filter_show('deco008','b_deco008')
   CALL adeq156_filter_show('deco009','b_deco009')
   CALL adeq156_filter_show('deco010','b_deco010')
   CALL adeq156_filter_show('deco011','b_deco011')
   CALL adeq156_filter_show('deco012','b_deco012')
   CALL adeq156_filter_show('deco013','b_deco013')
   CALL adeq156_filter_show('deco018','b_deco018')
   CALL adeq156_filter_show('deco019','b_deco019')
   CALL adeq156_filter_show('deco020','b_deco020')
   CALL adeq156_filter_show('deco014','b_deco014')
   CALL adeq156_filter_show('deco015','b_deco015')
   CALL adeq156_filter_show('deco016','b_deco016')
   CALL adeq156_filter_show('deco017','b_deco017')
   CALL adeq156_filter_show('decp007','b_decp007')
   CALL adeq156_filter_show('decp006','b_decp006')
   CALL adeq156_filter_show('decp008','b_decp008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq156_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_decn2_d.clear()
 
   CALL g_decn3_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   CALL g_decn4_d.clear()   #151012-00012#5 20151022 add by beckxie
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE deco006,'',deco007,'',deco008,deco009,deco010,deco011,deco012,deco013, 
          deco018,deco019,deco020,deco014,deco015,deco016,deco017 FROM deco_t",    
                  "",
                  " WHERE decoent=? AND decosite=? AND deco005=? AND deco021=? AND deco022=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY deco_t.deco006,deco_t.deco007" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整   
      #LET g_sql = "SELECT  UNIQUE deco006,t1.mmanl003,deco007,t2.oocql004,deco008,deco009,deco010,deco011,deco012,deco013, 
      #    deco018,deco019,deco020,deco014,deco015,deco016,deco017 FROM deco_t ",    
      #    "       LEFT JOIN mmanl_t t1 ON t1.mmanlent = decoent AND t1.mmanl001 = deco006 AND t1.mmanl002 = '",g_dlang,"' ",
      #    "       LEFT JOIN oocql_t t2 ON t2.oocqlent = decoent AND t2.oocql001 = '2024' AND t2.oocql002 = deco007 AND t2.oocql003 = '",g_dlang,"' ",          
      #    " WHERE decoent=? AND decosite=? AND deco005=? AND deco021=? AND deco022=?"
          
      LET g_sql = "SELECT  UNIQUE deco006, ",
              "                   (SELECT mmanl003 FROM mmanl_t ",
              "                     WHERE mmanlent = decoent ",
              "                       AND mmanl001 = deco006 ",
              "                       AND mmanl002 ='"||g_dlang||"') deco006_desc, ",   
              "                   deco007, ",
              "                   (SELECT oocql004 FROM oocql_t ",
              "                     WHERE oocqlent = decoent ",
              "                       AND oocql001 = '2024' ",
              "                       AND oocql002 = deco007 ",
              "                       AND oocql003 ='"||g_dlang||"') deco006_desc, ",   
              "                   deco008,deco009,deco010,deco011,deco012,deco013, ", 
              "                   deco018,deco019,deco020,deco014,deco015,deco016,deco017 ",
              "      FROM deco_t ",     
              "     WHERE decoent=? AND decosite=? AND deco005=? AND deco021=? AND deco022=?"    
      #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整   
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY deco_t.deco006,deco_t.deco007"
      

      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq156_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR adeq156_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_decn_d[g_detail_idx].decnsite
#                                 ,g_decn_d[g_detail_idx].decn005
 
#                                 ,g_decn_d[g_detail_idx].decn024
 
#                                 ,g_decn_d[g_detail_idx].decn025
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_decn_d[g_detail_idx].decnsite   #(ver:42)
                                     ,g_decn_d[g_detail_idx].decn005   #(ver:42)
 
                                     ,g_decn_d[g_detail_idx].decn024   #(ver:42)
 
                                     ,g_decn_d[g_detail_idx].decn025   #(ver:42)
 
 
        INTO g_decn2_d[l_ac].deco006,g_decn2_d[l_ac].deco006_desc,g_decn2_d[l_ac].deco007,g_decn2_d[l_ac].deco007_desc, 
            g_decn2_d[l_ac].deco008,g_decn2_d[l_ac].deco009,g_decn2_d[l_ac].deco010,g_decn2_d[l_ac].deco011, 
            g_decn2_d[l_ac].deco012,g_decn2_d[l_ac].deco013,g_decn2_d[l_ac].deco018,g_decn2_d[l_ac].deco019, 
            g_decn2_d[l_ac].deco020,g_decn2_d[l_ac].deco014,g_decn2_d[l_ac].deco015,g_decn2_d[l_ac].deco016, 
            g_decn2_d[l_ac].deco017   #(ver:42)
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
      
      CALL adeq156_detail_show("'2'")      
 
      CALL adeq156_deco_t_mask()
 
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
      LET g_sql = "SELECT  UNIQUE decp007,decp006,'',decp008 FROM decp_t",    
                  "",
                  " WHERE decpent=? AND decpsite=? AND decp005=? AND decp009=? AND decp010=?"
  
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decp_t.decp006" 
                         
      #add-point:單身填充前 name="fetch.before_fill3"
      #150826-00013#2 20150910 s983961--mark and mod(s) 效能調整   
      #LET g_sql = "SELECT  UNIQUE decp007,decp006,t1.ooial003,decp008 FROM decp_t",    
      #            "       LEFT JOIN ooial_t t1 ON t1.ooialent = decpent AND t1.ooial001 = decp006 AND t1.ooial002 = '",g_dlang,"' ",          
      #            " WHERE decpent=? AND decpsite=? AND decp005=? AND decp009=? AND decp010=?"
                  
      LET g_sql = "SELECT  UNIQUE decp007, ",
                  "               decp006, ",
                  "               (SELECT ooial003 FROM ooial_t ",
                  "                 WHERE ooialent = decpent ",
                  "                   AND ooial001 = decp006 ",
                  "                   AND ooial002 ='"||g_dlang||"') decp006_desc, ",
                  "               decp008 ",
                  "  FROM decp_t",    
                  " WHERE decpent=? AND decpsite=? AND decp005=? AND decp009=? AND decp010=?",
                  "   AND decp006 IS NOT NULL"   #151012-00012#5 20151022 add by beckxie
      #150826-00013#2 20150910 s983961--mark and mod(e) 效能調整   
      
      IF NOT cl_null(g_wc2_table3) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table3 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY decp_t.decp006" 
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE adeq156_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR adeq156_pb3
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs3 USING g_enterprise,g_decn_d[g_detail_idx].decnsite
#                                 ,g_decn_d[g_detail_idx].decn005
 
#                                 ,g_decn_d[g_detail_idx].decn024
 
#                                 ,g_decn_d[g_detail_idx].decn025
 
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs3 USING g_enterprise,g_decn_d[g_detail_idx].decnsite   #(ver:42)
                                     ,g_decn_d[g_detail_idx].decn005   #(ver:42)
 
                                     ,g_decn_d[g_detail_idx].decn024   #(ver:42)
 
                                     ,g_decn_d[g_detail_idx].decn025   #(ver:42)
 
 
        INTO g_decn3_d[l_ac].decp007,g_decn3_d[l_ac].decp006,g_decn3_d[l_ac].decp006_desc,g_decn3_d[l_ac].decp008  
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
      
      #end add-point
      
      CALL adeq156_detail_show("'3'")      
 
      CALL adeq156_decp_t_mask()
 
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
   FOREACH b_fill_curs1 USING g_enterprise INTO g_decn4_d[l_ac].decp007,g_decn4_d[l_ac].decp006,
                                                g_decn4_d[l_ac].decp006_desc_1,  
                                                g_decn4_d[l_ac].decp008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
     

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH

   #end add-point 
   
   CALL g_decn2_d.deleteElement(g_decn2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_decn2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
   CALL g_decn3_d.deleteElement(g_decn3_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_decn3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
 
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   #20151026 s983961--add(s)第四單身 重取
   CALL g_decn4_d.deleteElement(g_decn4_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_decn4_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   #20151026 s983961--add(e)第四單身 重取
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="adeq156.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq156_detail_show(ps_page)
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
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decn_d[l_ac].decnsite
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decn_d[l_ac].decnsite_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decn_d[l_ac].decnsite_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decn_d[l_ac].decn005
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decn_d[l_ac].decn005_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decn_d[l_ac].decn005_desc

      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decn2_d[l_ac].deco006
#            LET ls_sql = "SELECT mmanl003 FROM mmanl_t WHERE mmanlent='"||g_enterprise||"' AND mmanl001=? AND mmanl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decn2_d[l_ac].deco006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decn2_d[l_ac].deco006_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decn2_d[l_ac].deco007
#            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001 = '2024' AND oocql002=? AND oocql003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decn2_d[l_ac].deco007_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decn2_d[l_ac].deco007_desc
#
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_decn3_d[l_ac].decp006
#            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_decn3_d[l_ac].decp006_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_decn3_d[l_ac].decp006_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq156_filter()
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
      CONSTRUCT g_wc_filter ON decnsite,decn001,decn024,decn025,decn005,decn006,decn007,decn008,decn009, 
          decn010,decn011,decn012,decn013,decn022,decn023,decn014,decn015,decn016,decn017,decn020,decn021, 
          decn018,decn019
                          FROM s_detail1[1].b_decnsite,s_detail1[1].b_decn001,s_detail1[1].b_decn024, 
                              s_detail1[1].b_decn025,s_detail1[1].b_decn005,s_detail1[1].b_decn006,s_detail1[1].b_decn007, 
                              s_detail1[1].b_decn008,s_detail1[1].b_decn009,s_detail1[1].b_decn010,s_detail1[1].b_decn011, 
                              s_detail1[1].b_decn012,s_detail1[1].b_decn013,s_detail1[1].b_decn022,s_detail1[1].b_decn023, 
                              s_detail1[1].b_decn014,s_detail1[1].b_decn015,s_detail1[1].b_decn016,s_detail1[1].b_decn017, 
                              s_detail1[1].b_decn020,s_detail1[1].b_decn021,s_detail1[1].b_decn018,s_detail1[1].b_decn019 
 
 
         BEFORE CONSTRUCT
                     DISPLAY adeq156_filter_parser('decnsite') TO s_detail1[1].b_decnsite
            DISPLAY adeq156_filter_parser('decn001') TO s_detail1[1].b_decn001
            DISPLAY adeq156_filter_parser('decn024') TO s_detail1[1].b_decn024
            DISPLAY adeq156_filter_parser('decn025') TO s_detail1[1].b_decn025
            DISPLAY adeq156_filter_parser('decn005') TO s_detail1[1].b_decn005
            DISPLAY adeq156_filter_parser('decn006') TO s_detail1[1].b_decn006
            DISPLAY adeq156_filter_parser('decn007') TO s_detail1[1].b_decn007
            DISPLAY adeq156_filter_parser('decn008') TO s_detail1[1].b_decn008
            DISPLAY adeq156_filter_parser('decn009') TO s_detail1[1].b_decn009
            DISPLAY adeq156_filter_parser('decn010') TO s_detail1[1].b_decn010
            DISPLAY adeq156_filter_parser('decn011') TO s_detail1[1].b_decn011
            DISPLAY adeq156_filter_parser('decn012') TO s_detail1[1].b_decn012
            DISPLAY adeq156_filter_parser('decn013') TO s_detail1[1].b_decn013
            DISPLAY adeq156_filter_parser('decn022') TO s_detail1[1].b_decn022
            DISPLAY adeq156_filter_parser('decn023') TO s_detail1[1].b_decn023
            DISPLAY adeq156_filter_parser('decn014') TO s_detail1[1].b_decn014
            DISPLAY adeq156_filter_parser('decn015') TO s_detail1[1].b_decn015
            DISPLAY adeq156_filter_parser('decn016') TO s_detail1[1].b_decn016
            DISPLAY adeq156_filter_parser('decn017') TO s_detail1[1].b_decn017
            DISPLAY adeq156_filter_parser('decn020') TO s_detail1[1].b_decn020
            DISPLAY adeq156_filter_parser('decn021') TO s_detail1[1].b_decn021
            DISPLAY adeq156_filter_parser('decn018') TO s_detail1[1].b_decn018
            DISPLAY adeq156_filter_parser('decn019') TO s_detail1[1].b_decn019
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_decnsite>>----
         #Ctrlp:construct.c.page1.b_decnsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decnsite
            #add-point:ON ACTION controlp INFIELD b_decnsite name="construct.c.filter.page1.b_decnsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooed004_3()                           #呼叫開窗   #161006-00008#4 by sakura add
            #161006-00008#4 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'decnsite',g_site,'c')
            CALL q_ooef001_24()                          #呼叫開窗
            #161006-00008#4 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_decnsite  #顯示到畫面上
            NEXT FIELD b_decnsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decnsite_desc>>----
         #----<<b_decn001>>----
         #Ctrlp:construct.c.filter.page1.b_decn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn001
            #add-point:ON ACTION controlp INFIELD b_decn001 name="construct.c.filter.page1.b_decn001"
            
            #END add-point
 
 
         #----<<b_decn024>>----
         #Ctrlp:construct.c.filter.page1.b_decn024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn024
            #add-point:ON ACTION controlp INFIELD b_decn024 name="construct.c.filter.page1.b_decn024"
            
            #END add-point
 
 
         #----<<b_decn025>>----
         #Ctrlp:construct.c.filter.page1.b_decn025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn025
            #add-point:ON ACTION controlp INFIELD b_decn025 name="construct.c.filter.page1.b_decn025"
            
            #END add-point
 
 
         #----<<b_decn005>>----
         #Ctrlp:construct.c.page1.b_decn005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn005
            #add-point:ON ACTION controlp INFIELD b_decn005 name="construct.c.filter.page1.b_decn005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_decn005  #顯示到畫面上
            NEXT FIELD b_decn005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_decn005_desc>>----
         #----<<b_decn006>>----
         #Ctrlp:construct.c.filter.page1.b_decn006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn006
            #add-point:ON ACTION controlp INFIELD b_decn006 name="construct.c.filter.page1.b_decn006"
            
            #END add-point
 
 
         #----<<b_decn007>>----
         #Ctrlp:construct.c.filter.page1.b_decn007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn007
            #add-point:ON ACTION controlp INFIELD b_decn007 name="construct.c.filter.page1.b_decn007"
            
            #END add-point
 
 
         #----<<b_decn008>>----
         #Ctrlp:construct.c.filter.page1.b_decn008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn008
            #add-point:ON ACTION controlp INFIELD b_decn008 name="construct.c.filter.page1.b_decn008"
            
            #END add-point
 
 
         #----<<b_decn009>>----
         #Ctrlp:construct.c.filter.page1.b_decn009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn009
            #add-point:ON ACTION controlp INFIELD b_decn009 name="construct.c.filter.page1.b_decn009"
            
            #END add-point
 
 
         #----<<b_decn010>>----
         #Ctrlp:construct.c.filter.page1.b_decn010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn010
            #add-point:ON ACTION controlp INFIELD b_decn010 name="construct.c.filter.page1.b_decn010"
            
            #END add-point
 
 
         #----<<b_decn011>>----
         #Ctrlp:construct.c.filter.page1.b_decn011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn011
            #add-point:ON ACTION controlp INFIELD b_decn011 name="construct.c.filter.page1.b_decn011"
            
            #END add-point
 
 
         #----<<b_decn012>>----
         #Ctrlp:construct.c.filter.page1.b_decn012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn012
            #add-point:ON ACTION controlp INFIELD b_decn012 name="construct.c.filter.page1.b_decn012"
            
            #END add-point
 
 
         #----<<b_decn013>>----
         #Ctrlp:construct.c.filter.page1.b_decn013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn013
            #add-point:ON ACTION controlp INFIELD b_decn013 name="construct.c.filter.page1.b_decn013"
            
            #END add-point
 
 
         #----<<b_decn022>>----
         #Ctrlp:construct.c.filter.page1.b_decn022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn022
            #add-point:ON ACTION controlp INFIELD b_decn022 name="construct.c.filter.page1.b_decn022"
            
            #END add-point
 
 
         #----<<b_decn023>>----
         #Ctrlp:construct.c.filter.page1.b_decn023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn023
            #add-point:ON ACTION controlp INFIELD b_decn023 name="construct.c.filter.page1.b_decn023"
            
            #END add-point
 
 
         #----<<b_decn014>>----
         #Ctrlp:construct.c.filter.page1.b_decn014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn014
            #add-point:ON ACTION controlp INFIELD b_decn014 name="construct.c.filter.page1.b_decn014"
            
            #END add-point
 
 
         #----<<b_decn015>>----
         #Ctrlp:construct.c.filter.page1.b_decn015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn015
            #add-point:ON ACTION controlp INFIELD b_decn015 name="construct.c.filter.page1.b_decn015"
            
            #END add-point
 
 
         #----<<b_decn016>>----
         #Ctrlp:construct.c.filter.page1.b_decn016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn016
            #add-point:ON ACTION controlp INFIELD b_decn016 name="construct.c.filter.page1.b_decn016"
            
            #END add-point
 
 
         #----<<b_decn017>>----
         #Ctrlp:construct.c.filter.page1.b_decn017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn017
            #add-point:ON ACTION controlp INFIELD b_decn017 name="construct.c.filter.page1.b_decn017"
            
            #END add-point
 
 
         #----<<b_decn020>>----
         #Ctrlp:construct.c.filter.page1.b_decn020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn020
            #add-point:ON ACTION controlp INFIELD b_decn020 name="construct.c.filter.page1.b_decn020"
            
            #END add-point
 
 
         #----<<b_decn021>>----
         #Ctrlp:construct.c.filter.page1.b_decn021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn021
            #add-point:ON ACTION controlp INFIELD b_decn021 name="construct.c.filter.page1.b_decn021"
            
            #END add-point
 
 
         #----<<b_decn018>>----
         #Ctrlp:construct.c.filter.page1.b_decn018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn018
            #add-point:ON ACTION controlp INFIELD b_decn018 name="construct.c.filter.page1.b_decn018"
            
            #END add-point
 
 
         #----<<b_decn019>>----
         #Ctrlp:construct.c.filter.page1.b_decn019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_decn019
            #add-point:ON ACTION controlp INFIELD b_decn019 name="construct.c.filter.page1.b_decn019"
            
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
   
      CALL adeq156_filter_show('decnsite','b_decnsite')
   CALL adeq156_filter_show('decn001','b_decn001')
   CALL adeq156_filter_show('decn024','b_decn024')
   CALL adeq156_filter_show('decn025','b_decn025')
   CALL adeq156_filter_show('decn005','b_decn005')
   CALL adeq156_filter_show('decn006','b_decn006')
   CALL adeq156_filter_show('decn007','b_decn007')
   CALL adeq156_filter_show('decn008','b_decn008')
   CALL adeq156_filter_show('decn009','b_decn009')
   CALL adeq156_filter_show('decn010','b_decn010')
   CALL adeq156_filter_show('decn011','b_decn011')
   CALL adeq156_filter_show('decn012','b_decn012')
   CALL adeq156_filter_show('decn013','b_decn013')
   CALL adeq156_filter_show('decn022','b_decn022')
   CALL adeq156_filter_show('decn023','b_decn023')
   CALL adeq156_filter_show('decn014','b_decn014')
   CALL adeq156_filter_show('decn015','b_decn015')
   CALL adeq156_filter_show('decn016','b_decn016')
   CALL adeq156_filter_show('decn017','b_decn017')
   CALL adeq156_filter_show('decn020','b_decn020')
   CALL adeq156_filter_show('decn021','b_decn021')
   CALL adeq156_filter_show('decn018','b_decn018')
   CALL adeq156_filter_show('decn019','b_decn019')
   CALL adeq156_filter_show('deco006','b_deco006')
   CALL adeq156_filter_show('deco007','b_deco007')
   CALL adeq156_filter_show('deco008','b_deco008')
   CALL adeq156_filter_show('deco009','b_deco009')
   CALL adeq156_filter_show('deco010','b_deco010')
   CALL adeq156_filter_show('deco011','b_deco011')
   CALL adeq156_filter_show('deco012','b_deco012')
   CALL adeq156_filter_show('deco013','b_deco013')
   CALL adeq156_filter_show('deco018','b_deco018')
   CALL adeq156_filter_show('deco019','b_deco019')
   CALL adeq156_filter_show('deco020','b_deco020')
   CALL adeq156_filter_show('deco014','b_deco014')
   CALL adeq156_filter_show('deco015','b_deco015')
   CALL adeq156_filter_show('deco016','b_deco016')
   CALL adeq156_filter_show('deco017','b_deco017')
   CALL adeq156_filter_show('decp007','b_decp007')
   CALL adeq156_filter_show('decp006','b_decp006')
   CALL adeq156_filter_show('decp008','b_decp008')
 
    
   CALL adeq156_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq156_filter_parser(ps_field)
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
 
{<section id="adeq156.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq156_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq156_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.insert" >}
#+ insert
PRIVATE FUNCTION adeq156_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq156.modify" >}
#+ modify
PRIVATE FUNCTION adeq156_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq156_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.delete" >}
#+ delete
PRIVATE FUNCTION adeq156_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq156.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq156_detail_action_trans()
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
 
{<section id="adeq156.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq156_detail_index_setting()
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
            IF g_decn_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_decn_d.getLength() AND g_decn_d.getLength() > 0
            LET g_detail_idx = g_decn_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_decn_d.getLength() THEN
               LET g_detail_idx = g_decn_d.getLength()
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
 
{<section id="adeq156.mask_functions" >}
 &include "erp/ade/adeq156_mask.4gl"
 
{</section>}
 
{<section id="adeq156.other_function" readonly="Y" >}

 
{</section>}
 
