#該程式未解開Section, 採用最新樣板產出!
{<section id="aprq122.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-07-04 12:44:38), PR版次:0008(2016-03-04 14:29:55)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000151
#+ Filename...: aprq122
#+ Description: 門店生鮮商品清單查詢作業
#+ Creator....: 03247(2014-05-21 14:12:21)
#+ Modifier...: 03247 -SD/PR- 06189
 
{</section>}
 
{<section id="aprq122.global" >}
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
PRIVATE TYPE type_g_prbh_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   prbhstus LIKE prbh_t.prbhstus, 
   prbhsite LIKE prbh_t.prbhsite, 
   prbhsite_desc LIKE type_t.chr500, 
   prbh001 LIKE prbh_t.prbh001, 
   prbh002 LIKE prbh_t.prbh002, 
   prbh004 LIKE prbh_t.prbh004, 
   prbh003 LIKE prbh_t.prbh003, 
   prbh003_desc LIKE type_t.chr500, 
   prbh003_desc_1 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   prbh006 LIKE prbh_t.prbh006, 
   prbh006_desc LIKE type_t.chr500, 
   prbh007 LIKE prbh_t.prbh007, 
   prbh008 LIKE prbh_t.prbh008, 
   prbh009 LIKE prbh_t.prbh009, 
   prbh009_desc LIKE type_t.chr500, 
   prbh010 LIKE prbh_t.prbh010, 
   prbh016 LIKE prbh_t.prbh016, 
   prbh017 LIKE prbh_t.prbh017, 
   prbh011 LIKE prbh_t.prbh011, 
   prbh011_desc LIKE type_t.chr500, 
   prbh012 LIKE prbh_t.prbh012, 
   prbh013 LIKE prbh_t.prbh013, 
   prbh014 LIKE prbh_t.prbh014, 
   prbh015 LIKE prbh_t.prbh015, 
   prbh018 LIKE prbh_t.prbh018, 
   prbh019 LIKE prbh_t.prbh019 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_prbh_d
DEFINE g_master_t                   type_g_prbh_d
DEFINE g_prbh_d          DYNAMIC ARRAY OF type_g_prbh_d
DEFINE g_prbh_d_t        type_g_prbh_d
 
      
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
 
{<section id="aprq122.main" >}
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
   DECLARE aprq122_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aprq122_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aprq122_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aprq122 WITH FORM cl_ap_formpath("apr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aprq122_init()   
 
      #進入選單 Menu (="N")
      CALL aprq122_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aprq122
      
   END IF 
   
   CLOSE aprq122_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aprq122.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aprq122_init()
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
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   #add by geza 20160304(S)
   #栏位名称重新显示
   CALL s_desc_gzcbl004_desc('6899','1') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbh013",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','2') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbh014",l_gzcbl004)
   CALL s_desc_gzcbl004_desc('6899','3') RETURNING l_gzcbl004
   CALL cl_set_comp_att_text("b_prbh015",l_gzcbl004)
   #add by geza 20160304(E) 
   #end add-point
 
   CALL aprq122_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aprq122.default_search" >}
PRIVATE FUNCTION aprq122_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " prbhsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " prbh001 = '", g_argv[02], "' AND "
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
 
{<section id="aprq122.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aprq122_ui_dialog()
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
      CALL aprq122_b_fill()
   ELSE
      CALL aprq122_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_prbh_d.clear()
 
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
 
         CALL aprq122_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_prbh_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aprq122_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aprq122_detail_action_trans()
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
            CALL aprq122_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aprq122_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aprq122_query()
               #add-point:ON ACTION query name="menu.query"
               
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aprq122_filter()
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
            CALL aprq122_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_prbh_d)
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
            CALL aprq122_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aprq122_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aprq122_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aprq122_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_prbh_d.getLength()
               LET g_prbh_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_prbh_d.getLength()
               LET g_prbh_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_prbh_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prbh_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_prbh_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_prbh_d[li_idx].sel = "N"
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
 
{<section id="aprq122.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aprq122_query()
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
   CALL g_prbh_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON prbhstus,prbhsite,prbh001,prbh002,prbh004,prbh003,prbh006,prbh007,prbh008, 
          prbh009,prbh010,prbh016,prbh017,prbh011,prbh012,prbh013,prbh014,prbh015,prbh018,prbh019
           FROM s_detail1[1].b_prbhstus,s_detail1[1].b_prbhsite,s_detail1[1].b_prbh001,s_detail1[1].b_prbh002, 
               s_detail1[1].b_prbh004,s_detail1[1].b_prbh003,s_detail1[1].b_prbh006,s_detail1[1].b_prbh007, 
               s_detail1[1].b_prbh008,s_detail1[1].b_prbh009,s_detail1[1].b_prbh010,s_detail1[1].b_prbh016, 
               s_detail1[1].b_prbh017,s_detail1[1].b_prbh011,s_detail1[1].b_prbh012,s_detail1[1].b_prbh013, 
               s_detail1[1].b_prbh014,s_detail1[1].b_prbh015,s_detail1[1].b_prbh018,s_detail1[1].b_prbh019 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbhcrtdt>>----
         #AFTER FIELD prbhcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbhmoddt>>----
         #AFTER FIELD prbhmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbhcnfdt>>----
         #AFTER FIELD prbhcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbhpstdt>>----
         #AFTER FIELD prbhpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_prbhstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbhstus
            #add-point:BEFORE FIELD b_prbhstus name="construct.b.page1.b_prbhstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbhstus
            
            #add-point:AFTER FIELD b_prbhstus name="construct.a.page1.b_prbhstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbhstus
            #add-point:ON ACTION controlp INFIELD b_prbhstus name="construct.c.page1.b_prbhstus"
            
            #END add-point
 
 
         #----<<b_prbhsite>>----
         #Ctrlp:construct.c.page1.b_prbhsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbhsite
            #add-point:ON ACTION controlp INFIELD b_prbhsite name="construct.c.page1.b_prbhsite"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = '8'
#            CALL q_ooed004_3()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prbhsite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_prbhsite  #顯示到畫面上
            NEXT FIELD b_prbhsite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbhsite
            #add-point:BEFORE FIELD b_prbhsite name="construct.b.page1.b_prbhsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbhsite
            
            #add-point:AFTER FIELD b_prbhsite name="construct.a.page1.b_prbhsite"
            
            #END add-point
            
 
 
         #----<<b_prbhsite_desc>>----
         #----<<b_prbh001>>----
         #Ctrlp:construct.c.page1.b_prbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh001
            #add-point:ON ACTION controlp INFIELD b_prbh001 name="construct.c.page1.b_prbh001"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prbh001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh001  #顯示到畫面上
            NEXT FIELD b_prbh001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh001
            #add-point:BEFORE FIELD b_prbh001 name="construct.b.page1.b_prbh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh001
            
            #add-point:AFTER FIELD b_prbh001 name="construct.a.page1.b_prbh001"
            
            #END add-point
            
 
 
         #----<<b_prbh002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh002
            #add-point:BEFORE FIELD b_prbh002 name="construct.b.page1.b_prbh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh002
            
            #add-point:AFTER FIELD b_prbh002 name="construct.a.page1.b_prbh002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh002
            #add-point:ON ACTION controlp INFIELD b_prbh002 name="construct.c.page1.b_prbh002"
            
            #END add-point
 
 
         #----<<b_prbh004>>----
         #Ctrlp:construct.c.page1.b_prbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh004
            #add-point:ON ACTION controlp INFIELD b_prbh004 name="construct.c.page1.b_prbh004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ",
                                   #" START WITH rtax003 IN (SELECT oocq002 FROM oocq_t,rtax_t  WHERE oocqent = rtaxent AND oocq002 = rtax001 AND oocq001 = '2099' AND oocqstus = 'Y') ",       #150506-00018#1--mark by dongsz
                                   " START WITH rtax003 IN (SELECT prbs001 FROM prbs_t,rtax_t  WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y') ",       #150506-00018#1--add by dongsz
                                   " CONNECT BY nocycle PRIOR rtax001 = rtax003 ",
                                   #" UNION SELECT rtax001 FROM rtax_t WHERE rtax001 IN (SELECT oocq002 FROM oocq_t,rtax_t WHERE oocqent = rtaxent AND oocq002 = rtax001 AND oocq001 = '2099' AND oocqstus = 'Y')) "  #150506-00018#1--mark by dongsz
                                   " UNION SELECT rtax001 FROM rtax_t WHERE rtax001 IN (SELECT prbs001 FROM prbs_t,rtax_t WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y')) "    #150506-00018#1--add by dongsz                               
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh004  #顯示到畫面上
            NEXT FIELD b_prbh004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh004
            #add-point:BEFORE FIELD b_prbh004 name="construct.b.page1.b_prbh004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh004
            
            #add-point:AFTER FIELD b_prbh004 name="construct.a.page1.b_prbh004"
            
            #END add-point
            
 
 
         #----<<b_prbh003>>----
         #Ctrlp:construct.c.page1.b_prbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh003
            #add-point:ON ACTION controlp INFIELD b_prbh003 name="construct.c.page1.b_prbh003"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imaa009 IN (SELECT DISTINCT rtax001 FROM rtax_t WHERE rtax005 = 0 ",
                                   #" START WITH rtax003 IN (SELECT oocq002 FROM oocq_t,rtax_t  WHERE oocqent = rtaxent AND oocq002 = rtax001 AND oocq001 = '2099' AND oocqstus = 'Y') ",       #150506-00018#1--mark by dongsz
                                   " START WITH rtax003 IN (SELECT prbs001 FROM prbs_t,rtax_t  WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y') ",       #150506-00018#1--add by dongsz
                                   " CONNECT BY nocycle PRIOR rtax001 = rtax003 ",
                                   #" UNION SELECT rtax001 FROM rtax_t WHERE rtax001 IN (SELECT oocq002 FROM oocq_t,rtax_t WHERE oocqent = rtaxent AND oocq002 = rtax001 AND oocq001 = '2099' AND oocqstus = 'Y')) "   #150506-00018#1--mark by dongsz
                                   " UNION SELECT rtax001 FROM rtax_t WHERE rtax001 IN (SELECT prbs001 FROM prbs_t,rtax_t WHERE prbsent = rtaxent AND prbs001 = rtax001 AND prbsstus = 'Y')) "   #150506-00018#1--add by dongsz
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh003  #顯示到畫面上
            NEXT FIELD b_prbh003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh003
            #add-point:BEFORE FIELD b_prbh003 name="construct.b.page1.b_prbh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh003
            
            #add-point:AFTER FIELD b_prbh003 name="construct.a.page1.b_prbh003"
            
            #END add-point
            
 
 
         #----<<b_prbh003_desc>>----
         #----<<b_prbh003_desc_1>>----
         #----<<b_imaa009>>----
         #----<<b_imaa009_desc>>----
         #----<<b_prbh006>>----
         #Ctrlp:construct.c.page1.b_prbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh006
            #add-point:ON ACTION controlp INFIELD b_prbh006 name="construct.c.page1.b_prbh006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh006  #顯示到畫面上
            NEXT FIELD b_prbh006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh006
            #add-point:BEFORE FIELD b_prbh006 name="construct.b.page1.b_prbh006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh006
            
            #add-point:AFTER FIELD b_prbh006 name="construct.a.page1.b_prbh006"
            
            #END add-point
            
 
 
         #----<<b_prbh006_desc>>----
         #----<<b_prbh007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh007
            #add-point:BEFORE FIELD b_prbh007 name="construct.b.page1.b_prbh007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh007
            
            #add-point:AFTER FIELD b_prbh007 name="construct.a.page1.b_prbh007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh007
            #add-point:ON ACTION controlp INFIELD b_prbh007 name="construct.c.page1.b_prbh007"
            
            #END add-point
 
 
         #----<<b_prbh008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh008
            #add-point:BEFORE FIELD b_prbh008 name="construct.b.page1.b_prbh008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh008
            
            #add-point:AFTER FIELD b_prbh008 name="construct.a.page1.b_prbh008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh008
            #add-point:ON ACTION controlp INFIELD b_prbh008 name="construct.c.page1.b_prbh008"
            
            #END add-point
 
 
         #----<<b_prbh009>>----
         #Ctrlp:construct.c.page1.b_prbh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh009
            #add-point:ON ACTION controlp INFIELD b_prbh009 name="construct.c.page1.b_prbh009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh009  #顯示到畫面上
            NEXT FIELD b_prbh009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh009
            #add-point:BEFORE FIELD b_prbh009 name="construct.b.page1.b_prbh009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh009
            
            #add-point:AFTER FIELD b_prbh009 name="construct.a.page1.b_prbh009"
            
            #END add-point
            
 
 
         #----<<b_prbh009_desc>>----
         #----<<b_prbh010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh010
            #add-point:BEFORE FIELD b_prbh010 name="construct.b.page1.b_prbh010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh010
            
            #add-point:AFTER FIELD b_prbh010 name="construct.a.page1.b_prbh010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh010
            #add-point:ON ACTION controlp INFIELD b_prbh010 name="construct.c.page1.b_prbh010"
            
            #END add-point
 
 
         #----<<b_prbh016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh016
            #add-point:BEFORE FIELD b_prbh016 name="construct.b.page1.b_prbh016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh016
            
            #add-point:AFTER FIELD b_prbh016 name="construct.a.page1.b_prbh016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh016
            #add-point:ON ACTION controlp INFIELD b_prbh016 name="construct.c.page1.b_prbh016"
            
            #END add-point
 
 
         #----<<b_prbh017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh017
            #add-point:BEFORE FIELD b_prbh017 name="construct.b.page1.b_prbh017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh017
            
            #add-point:AFTER FIELD b_prbh017 name="construct.a.page1.b_prbh017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh017
            #add-point:ON ACTION controlp INFIELD b_prbh017 name="construct.c.page1.b_prbh017"
            
            #END add-point
 
 
         #----<<b_prbh011>>----
         #Ctrlp:construct.c.page1.b_prbh011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh011
            #add-point:ON ACTION controlp INFIELD b_prbh011 name="construct.c.page1.b_prbh011"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh011  #顯示到畫面上
            NEXT FIELD b_prbh011                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh011
            #add-point:BEFORE FIELD b_prbh011 name="construct.b.page1.b_prbh011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh011
            
            #add-point:AFTER FIELD b_prbh011 name="construct.a.page1.b_prbh011"
            
            #END add-point
            
 
 
         #----<<b_prbh011_desc>>----
         #----<<b_prbh012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh012
            #add-point:BEFORE FIELD b_prbh012 name="construct.b.page1.b_prbh012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh012
            
            #add-point:AFTER FIELD b_prbh012 name="construct.a.page1.b_prbh012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh012
            #add-point:ON ACTION controlp INFIELD b_prbh012 name="construct.c.page1.b_prbh012"
            
            #END add-point
 
 
         #----<<b_prbh013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh013
            #add-point:BEFORE FIELD b_prbh013 name="construct.b.page1.b_prbh013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh013
            
            #add-point:AFTER FIELD b_prbh013 name="construct.a.page1.b_prbh013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh013
            #add-point:ON ACTION controlp INFIELD b_prbh013 name="construct.c.page1.b_prbh013"
            
            #END add-point
 
 
         #----<<b_prbh014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh014
            #add-point:BEFORE FIELD b_prbh014 name="construct.b.page1.b_prbh014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh014
            
            #add-point:AFTER FIELD b_prbh014 name="construct.a.page1.b_prbh014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh014
            #add-point:ON ACTION controlp INFIELD b_prbh014 name="construct.c.page1.b_prbh014"
            
            #END add-point
 
 
         #----<<b_prbh015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh015
            #add-point:BEFORE FIELD b_prbh015 name="construct.b.page1.b_prbh015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh015
            
            #add-point:AFTER FIELD b_prbh015 name="construct.a.page1.b_prbh015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh015
            #add-point:ON ACTION controlp INFIELD b_prbh015 name="construct.c.page1.b_prbh015"
            
            #END add-point
 
 
         #----<<b_prbh018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh018
            #add-point:BEFORE FIELD b_prbh018 name="construct.b.page1.b_prbh018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh018
            
            #add-point:AFTER FIELD b_prbh018 name="construct.a.page1.b_prbh018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh018
            #add-point:ON ACTION controlp INFIELD b_prbh018 name="construct.c.page1.b_prbh018"
            
            #END add-point
 
 
         #----<<b_prbh019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prbh019
            #add-point:BEFORE FIELD b_prbh019 name="construct.b.page1.b_prbh019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prbh019
            
            #add-point:AFTER FIELD b_prbh019 name="construct.a.page1.b_prbh019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prbh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh019
            #add-point:ON ACTION controlp INFIELD b_prbh019 name="construct.c.page1.b_prbh019"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_table1 ON imaa009
           FROM s_detail1[1].b_imaa009
           
         ON ACTION controlp INFIELD b_imaa009
            #add-point:ON ACTION controlp INFIELD b_rtax001
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa009  #顯示到畫面上
            NEXT FIELD b_imaa009                     #返回原欄位
            
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
   CALL aprq122_b_fill()
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
 
{<section id="aprq122.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aprq122_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'prbhsite')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',prbhstus,prbhsite,'',prbh001,prbh002,prbh004,prbh003,'','','', 
       '',prbh006,'',prbh007,prbh008,prbh009,'',prbh010,prbh016,prbh017,prbh011,'',prbh012,prbh013,prbh014, 
       prbh015,prbh018,prbh019  ,DENSE_RANK() OVER( ORDER BY prbh_t.prbhsite,prbh_t.prbh001) AS RANK FROM prbh_t", 
 
 
 
                     "",
                     " WHERE prbhent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("prbh_t"),
                     " ORDER BY prbh_t.prbhsite,prbh_t.prbh001"
 
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
 
   LET g_sql = "SELECT '',prbhstus,prbhsite,'',prbh001,prbh002,prbh004,prbh003,'','','','',prbh006,'', 
       prbh007,prbh008,prbh009,'',prbh010,prbh016,prbh017,prbh011,'',prbh012,prbh013,prbh014,prbh015, 
       prbh018,prbh019",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET ls_wc = ls_wc," AND prbhsite IN (SELECT ooed004 FROM ooed_t ",
#                     " START WITH ooed005='",g_site,"' AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
#                     " CONNECT BY NOCYCLE PRIOR ooed004=ooed005 AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL) ",
#                     " UNION SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"') "
   #150605-00024#1--mark by dongsz--str---
#   IF ls_wc.getIndexOf("imaa",1)>0 THEN
#      LET g_sql = "SELECT UNIQUE '',prbhstus,prbhsite,'',prbh001,prbh002,prbh003,prbh004,'','',imaa009,'',prbh006, 
#       '',prbh007,prbh008,prbh009,'',prbh010,prbh011,'',prbh012,prbh013,prbh014,prbh015 FROM prbh_t",
#                  " LEFT JOIN imaa_t ON imaa001=prbh003 AND imaaent=prbhent ",
#                  
#                  "",
#               " WHERE prbhent= ? AND 1=1 AND ", ls_wc
#   ELSE
#      LET g_sql = "SELECT UNIQUE '',prbhstus,prbhsite,'',prbh001,prbh002,prbh003,prbh004,'','','','',prbh006, 
#       '',prbh007,prbh008,prbh009,'',prbh010,prbh011,'',prbh012,prbh013,prbh014,prbh015 FROM prbh_t", 
#
# 
# 
#               "",
#               " WHERE prbhent= ? AND 1=1 AND ", ls_wc
#   END IF
#   LET g_sql = g_sql, " ORDER BY prbh_t.prbhsite,prbh_t.prbh001"
   #150605-00024#1--mark by dongsz--end---
   #150605-00024#1--add by dongsz--str---
   IF ls_wc.getIndexOf("imaa",1)>0 THEN
      LET g_sql = "SELECT UNIQUE '',prbhstus,prbhsite,'',prbh001,prbh002,prbh004,prbh003,'','',imaa009,'',prbh006, 
       '',prbh007,prbh008,prbh009,'',prbh010,prbh016,prbh017,prbh011,'',prbh012,prbh013,prbh014,prbh015,prbh018,prbh019 FROM prbh_t",
                  " LEFT JOIN imaa_t ON imaa001=prbh003 AND imaaent=prbhent ",
                  
                  "",
               " WHERE prbhent= ? AND 1=1 AND ", ls_wc
   ELSE
      LET g_sql = "SELECT UNIQUE '',prbhstus,prbhsite,'',prbh001,prbh002,prbh004,prbh003,'','','','',prbh006, 
       '',prbh007,prbh008,prbh009,'',prbh010,prbh016,prbh017,prbh011,'',prbh012,prbh013,prbh014,prbh015,prbh018,prbh019 FROM prbh_t", 

 
 
               "",
               " WHERE prbhent= ? AND 1=1 AND ", ls_wc
   END IF
   LET g_sql = g_sql, " ORDER BY prbh_t.prbhsite,prbh_t.prbh001"
   #150605-00024#1--add by dongsz--end---
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aprq122_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aprq122_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_prbh_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_prbh_d[l_ac].sel,g_prbh_d[l_ac].prbhstus,g_prbh_d[l_ac].prbhsite,g_prbh_d[l_ac].prbhsite_desc, 
       g_prbh_d[l_ac].prbh001,g_prbh_d[l_ac].prbh002,g_prbh_d[l_ac].prbh004,g_prbh_d[l_ac].prbh003,g_prbh_d[l_ac].prbh003_desc, 
       g_prbh_d[l_ac].prbh003_desc_1,g_prbh_d[l_ac].imaa009,g_prbh_d[l_ac].imaa009_desc,g_prbh_d[l_ac].prbh006, 
       g_prbh_d[l_ac].prbh006_desc,g_prbh_d[l_ac].prbh007,g_prbh_d[l_ac].prbh008,g_prbh_d[l_ac].prbh009, 
       g_prbh_d[l_ac].prbh009_desc,g_prbh_d[l_ac].prbh010,g_prbh_d[l_ac].prbh016,g_prbh_d[l_ac].prbh017, 
       g_prbh_d[l_ac].prbh011,g_prbh_d[l_ac].prbh011_desc,g_prbh_d[l_ac].prbh012,g_prbh_d[l_ac].prbh013, 
       g_prbh_d[l_ac].prbh014,g_prbh_d[l_ac].prbh015,g_prbh_d[l_ac].prbh018,g_prbh_d[l_ac].prbh019
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_prbh_d[l_ac].statepic = cl_get_actipic(g_prbh_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_prbh_d[l_ac].sel = 'N'
      CALL aprq122_prbh_ref()
      #end add-point
 
      CALL aprq122_detail_show("'1'")      
 
      CALL aprq122_prbh_t_mask()
 
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
   
 
   
   CALL g_prbh_d.deleteElement(g_prbh_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_prbh_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aprq122_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aprq122_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aprq122_detail_action_trans()
 
   IF g_prbh_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aprq122_fetch()
   END IF
   
      CALL aprq122_filter_show('prbhstus','b_prbhstus')
   CALL aprq122_filter_show('prbhsite','b_prbhsite')
   CALL aprq122_filter_show('prbh001','b_prbh001')
   CALL aprq122_filter_show('prbh002','b_prbh002')
   CALL aprq122_filter_show('prbh004','b_prbh004')
   CALL aprq122_filter_show('prbh003','b_prbh003')
   CALL aprq122_filter_show('prbh006','b_prbh006')
   CALL aprq122_filter_show('prbh007','b_prbh007')
   CALL aprq122_filter_show('prbh008','b_prbh008')
   CALL aprq122_filter_show('prbh009','b_prbh009')
   CALL aprq122_filter_show('prbh010','b_prbh010')
   CALL aprq122_filter_show('prbh016','b_prbh016')
   CALL aprq122_filter_show('prbh017','b_prbh017')
   CALL aprq122_filter_show('prbh011','b_prbh011')
   CALL aprq122_filter_show('prbh012','b_prbh012')
   CALL aprq122_filter_show('prbh013','b_prbh013')
   CALL aprq122_filter_show('prbh014','b_prbh014')
   CALL aprq122_filter_show('prbh015','b_prbh015')
   CALL aprq122_filter_show('prbh018','b_prbh018')
   CALL aprq122_filter_show('prbh019','b_prbh019')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aprq122_fetch()
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
 
{<section id="aprq122.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aprq122_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbh_d[l_ac].prbhsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbh_d[l_ac].prbhsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbh_d[l_ac].prbhsite_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbh_d[l_ac].prbh003
            CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbh_d[l_ac].prbh003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbh_d[l_ac].prbh003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_prbh_d[l_ac].imaa009
            CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_prbh_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_prbh_d[l_ac].imaa009_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aprq122_filter()
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
      CONSTRUCT g_wc_filter ON prbhstus,prbhsite,prbh001,prbh002,prbh004,prbh003,prbh006,prbh007,prbh008, 
          prbh009,prbh010,prbh016,prbh017,prbh011,prbh012,prbh013,prbh014,prbh015,prbh018,prbh019
                          FROM s_detail1[1].b_prbhstus,s_detail1[1].b_prbhsite,s_detail1[1].b_prbh001, 
                              s_detail1[1].b_prbh002,s_detail1[1].b_prbh004,s_detail1[1].b_prbh003,s_detail1[1].b_prbh006, 
                              s_detail1[1].b_prbh007,s_detail1[1].b_prbh008,s_detail1[1].b_prbh009,s_detail1[1].b_prbh010, 
                              s_detail1[1].b_prbh016,s_detail1[1].b_prbh017,s_detail1[1].b_prbh011,s_detail1[1].b_prbh012, 
                              s_detail1[1].b_prbh013,s_detail1[1].b_prbh014,s_detail1[1].b_prbh015,s_detail1[1].b_prbh018, 
                              s_detail1[1].b_prbh019
 
         BEFORE CONSTRUCT
                     DISPLAY aprq122_filter_parser('prbhstus') TO s_detail1[1].b_prbhstus
            DISPLAY aprq122_filter_parser('prbhsite') TO s_detail1[1].b_prbhsite
            DISPLAY aprq122_filter_parser('prbh001') TO s_detail1[1].b_prbh001
            DISPLAY aprq122_filter_parser('prbh002') TO s_detail1[1].b_prbh002
            DISPLAY aprq122_filter_parser('prbh004') TO s_detail1[1].b_prbh004
            DISPLAY aprq122_filter_parser('prbh003') TO s_detail1[1].b_prbh003
            DISPLAY aprq122_filter_parser('prbh006') TO s_detail1[1].b_prbh006
            DISPLAY aprq122_filter_parser('prbh007') TO s_detail1[1].b_prbh007
            DISPLAY aprq122_filter_parser('prbh008') TO s_detail1[1].b_prbh008
            DISPLAY aprq122_filter_parser('prbh009') TO s_detail1[1].b_prbh009
            DISPLAY aprq122_filter_parser('prbh010') TO s_detail1[1].b_prbh010
            DISPLAY aprq122_filter_parser('prbh016') TO s_detail1[1].b_prbh016
            DISPLAY aprq122_filter_parser('prbh017') TO s_detail1[1].b_prbh017
            DISPLAY aprq122_filter_parser('prbh011') TO s_detail1[1].b_prbh011
            DISPLAY aprq122_filter_parser('prbh012') TO s_detail1[1].b_prbh012
            DISPLAY aprq122_filter_parser('prbh013') TO s_detail1[1].b_prbh013
            DISPLAY aprq122_filter_parser('prbh014') TO s_detail1[1].b_prbh014
            DISPLAY aprq122_filter_parser('prbh015') TO s_detail1[1].b_prbh015
            DISPLAY aprq122_filter_parser('prbh018') TO s_detail1[1].b_prbh018
            DISPLAY aprq122_filter_parser('prbh019') TO s_detail1[1].b_prbh019
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<prbhcrtdt>>----
         #AFTER FIELD prbhcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<prbhmoddt>>----
         #AFTER FIELD prbhmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbhcnfdt>>----
         #AFTER FIELD prbhcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<prbhpstdt>>----
         #AFTER FIELD prbhpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_prbhstus>>----
         #Ctrlp:construct.c.filter.page1.b_prbhstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbhstus
            #add-point:ON ACTION controlp INFIELD b_prbhstus name="construct.c.filter.page1.b_prbhstus"
            
            #END add-point
 
 
         #----<<b_prbhsite>>----
         #Ctrlp:construct.c.page1.b_prbhsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbhsite
            #add-point:ON ACTION controlp INFIELD b_prbhsite name="construct.c.filter.page1.b_prbhsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbhsite  #顯示到畫面上
            NEXT FIELD b_prbhsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbhsite_desc>>----
         #----<<b_prbh001>>----
         #Ctrlp:construct.c.page1.b_prbh001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh001
            #add-point:ON ACTION controlp INFIELD b_prbh001 name="construct.c.filter.page1.b_prbh001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prbh001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh001  #顯示到畫面上
            NEXT FIELD b_prbh001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh002>>----
         #Ctrlp:construct.c.filter.page1.b_prbh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh002
            #add-point:ON ACTION controlp INFIELD b_prbh002 name="construct.c.filter.page1.b_prbh002"
            
            #END add-point
 
 
         #----<<b_prbh004>>----
         #Ctrlp:construct.c.page1.b_prbh004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh004
            #add-point:ON ACTION controlp INFIELD b_prbh004 name="construct.c.filter.page1.b_prbh004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh004  #顯示到畫面上
            NEXT FIELD b_prbh004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh003>>----
         #Ctrlp:construct.c.page1.b_prbh003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh003
            #add-point:ON ACTION controlp INFIELD b_prbh003 name="construct.c.filter.page1.b_prbh003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh003  #顯示到畫面上
            NEXT FIELD b_prbh003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh003_desc>>----
         #----<<b_prbh003_desc_1>>----
         #----<<b_imaa009>>----
         #----<<b_imaa009_desc>>----
         #----<<b_prbh006>>----
         #Ctrlp:construct.c.page1.b_prbh006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh006
            #add-point:ON ACTION controlp INFIELD b_prbh006 name="construct.c.filter.page1.b_prbh006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh006  #顯示到畫面上
            NEXT FIELD b_prbh006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh006_desc>>----
         #----<<b_prbh007>>----
         #Ctrlp:construct.c.filter.page1.b_prbh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh007
            #add-point:ON ACTION controlp INFIELD b_prbh007 name="construct.c.filter.page1.b_prbh007"
            
            #END add-point
 
 
         #----<<b_prbh008>>----
         #Ctrlp:construct.c.filter.page1.b_prbh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh008
            #add-point:ON ACTION controlp INFIELD b_prbh008 name="construct.c.filter.page1.b_prbh008"
            
            #END add-point
 
 
         #----<<b_prbh009>>----
         #Ctrlp:construct.c.page1.b_prbh009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh009
            #add-point:ON ACTION controlp INFIELD b_prbh009 name="construct.c.filter.page1.b_prbh009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh009  #顯示到畫面上
            NEXT FIELD b_prbh009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh009_desc>>----
         #----<<b_prbh010>>----
         #Ctrlp:construct.c.filter.page1.b_prbh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh010
            #add-point:ON ACTION controlp INFIELD b_prbh010 name="construct.c.filter.page1.b_prbh010"
            
            #END add-point
 
 
         #----<<b_prbh016>>----
         #Ctrlp:construct.c.filter.page1.b_prbh016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh016
            #add-point:ON ACTION controlp INFIELD b_prbh016 name="construct.c.filter.page1.b_prbh016"
            
            #END add-point
 
 
         #----<<b_prbh017>>----
         #Ctrlp:construct.c.filter.page1.b_prbh017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh017
            #add-point:ON ACTION controlp INFIELD b_prbh017 name="construct.c.filter.page1.b_prbh017"
            
            #END add-point
 
 
         #----<<b_prbh011>>----
         #Ctrlp:construct.c.page1.b_prbh011
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh011
            #add-point:ON ACTION controlp INFIELD b_prbh011 name="construct.c.filter.page1.b_prbh011"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oodb002_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prbh011  #顯示到畫面上
            NEXT FIELD b_prbh011                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_prbh011_desc>>----
         #----<<b_prbh012>>----
         #Ctrlp:construct.c.filter.page1.b_prbh012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh012
            #add-point:ON ACTION controlp INFIELD b_prbh012 name="construct.c.filter.page1.b_prbh012"
            
            #END add-point
 
 
         #----<<b_prbh013>>----
         #Ctrlp:construct.c.filter.page1.b_prbh013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh013
            #add-point:ON ACTION controlp INFIELD b_prbh013 name="construct.c.filter.page1.b_prbh013"
            
            #END add-point
 
 
         #----<<b_prbh014>>----
         #Ctrlp:construct.c.filter.page1.b_prbh014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh014
            #add-point:ON ACTION controlp INFIELD b_prbh014 name="construct.c.filter.page1.b_prbh014"
            
            #END add-point
 
 
         #----<<b_prbh015>>----
         #Ctrlp:construct.c.filter.page1.b_prbh015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh015
            #add-point:ON ACTION controlp INFIELD b_prbh015 name="construct.c.filter.page1.b_prbh015"
            
            #END add-point
 
 
         #----<<b_prbh018>>----
         #Ctrlp:construct.c.filter.page1.b_prbh018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh018
            #add-point:ON ACTION controlp INFIELD b_prbh018 name="construct.c.filter.page1.b_prbh018"
            
            #END add-point
 
 
         #----<<b_prbh019>>----
         #Ctrlp:construct.c.filter.page1.b_prbh019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prbh019
            #add-point:ON ACTION controlp INFIELD b_prbh019 name="construct.c.filter.page1.b_prbh019"
            
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
   
      CALL aprq122_filter_show('prbhstus','b_prbhstus')
   CALL aprq122_filter_show('prbhsite','b_prbhsite')
   CALL aprq122_filter_show('prbh001','b_prbh001')
   CALL aprq122_filter_show('prbh002','b_prbh002')
   CALL aprq122_filter_show('prbh004','b_prbh004')
   CALL aprq122_filter_show('prbh003','b_prbh003')
   CALL aprq122_filter_show('prbh006','b_prbh006')
   CALL aprq122_filter_show('prbh007','b_prbh007')
   CALL aprq122_filter_show('prbh008','b_prbh008')
   CALL aprq122_filter_show('prbh009','b_prbh009')
   CALL aprq122_filter_show('prbh010','b_prbh010')
   CALL aprq122_filter_show('prbh016','b_prbh016')
   CALL aprq122_filter_show('prbh017','b_prbh017')
   CALL aprq122_filter_show('prbh011','b_prbh011')
   CALL aprq122_filter_show('prbh012','b_prbh012')
   CALL aprq122_filter_show('prbh013','b_prbh013')
   CALL aprq122_filter_show('prbh014','b_prbh014')
   CALL aprq122_filter_show('prbh015','b_prbh015')
   CALL aprq122_filter_show('prbh018','b_prbh018')
   CALL aprq122_filter_show('prbh019','b_prbh019')
 
    
   CALL aprq122_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aprq122_filter_parser(ps_field)
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
 
{<section id="aprq122.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aprq122_filter_show(ps_field,ps_object)
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
   LET ls_condition = aprq122_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.insert" >}
#+ insert
PRIVATE FUNCTION aprq122_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aprq122.modify" >}
#+ modify
PRIVATE FUNCTION aprq122_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aprq122_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.delete" >}
#+ delete
PRIVATE FUNCTION aprq122_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aprq122.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aprq122_detail_action_trans()
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
 
{<section id="aprq122.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aprq122_detail_index_setting()
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
            IF g_prbh_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_prbh_d.getLength() AND g_prbh_d.getLength() > 0
            LET g_detail_idx = g_prbh_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_prbh_d.getLength() THEN
               LET g_detail_idx = g_prbh_d.getLength()
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
 
{<section id="aprq122.mask_functions" >}
 &include "erp/apr/aprq122_mask.4gl"
 
{</section>}
 
{<section id="aprq122.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 說明欄位顯示
# Memo...........:
# Usage..........: CALL aprq122_prbh_ref()
# Date & Author..: 20140522 By dongsz
# Modify.........:
################################################################################
PRIVATE FUNCTION aprq122_prbh_ref()
DEFINE l_ooef019      LIKE ooef_t.ooef019

   SELECT ooefl003 INTO g_prbh_d[l_ac].prbhsite_desc FROM ooefl_t
    WHERE ooeflent = g_enterprise AND ooefl001 = g_prbh_d[l_ac].prbhsite
      AND ooefl002 = g_dlang
      
   SELECT imaal003,imaal004 INTO g_prbh_d[l_ac].prbh003_desc, g_prbh_d[l_ac].prbh003_desc_1
     FROM imaal_t WHERE imaal001 = g_prbh_d[l_ac].prbh003 AND imaalent = g_enterprise
      AND imaal002 = g_dlang
      
   SELECT imaa009 INTO g_prbh_d[l_ac].imaa009
     FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_prbh_d[l_ac].prbh003
   SELECT rtaxl003 INTO g_prbh_d[l_ac].imaa009_desc FROM rtaxl_t
    WHERE rtaxl001 = g_prbh_d[l_ac].imaa009
      AND rtaxl002 = g_dlang
      AND rtaxlent = g_enterprise
      
   SELECT oocal003 INTO g_prbh_d[l_ac].prbh006_desc FROM oocal_t
    WHERE oocal001 = g_prbh_d[l_ac].prbh006 AND oocal002=g_dlang
      AND oocalent = g_enterprise
      
   SELECT ooef019 INTO l_ooef019 FROM ooef_t
    WHERE ooef001 = g_prbh_d[l_ac].prbhsite
      AND ooefent = g_enterprise
   SELECT oodbl004 INTO g_prbh_d[l_ac].prbh009_desc FROM oodbl_t
    WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbh_d[l_ac].prbh009 AND oodbl003 = g_dlang
   SELECT oodbl004 INTO g_prbh_d[l_ac].prbh011_desc FROM oodbl_t
    WHERE oodblent = g_enterprise AND oodbl001 = l_ooef019
      AND oodbl002 = g_prbh_d[l_ac].prbh011 AND oodbl003 = g_dlang

END FUNCTION

 
{</section>}
 
