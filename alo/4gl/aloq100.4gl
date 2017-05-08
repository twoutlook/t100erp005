#該程式未解開Section, 採用最新樣板產出!
{<section id="aloq100.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2014-06-04 11:51:20), PR版次:0001(2014-06-05 16:54:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000110
#+ Filename...: aloq100
#+ Description: 事件檢視器
#+ Creator....: 00824(2014-05-23 11:29:36)
#+ Modifier...: 00824 -SD/PR- 00824
 
{</section>}
 
{<section id="aloq100.global" >}
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
PRIVATE TYPE type_g_logt_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   logt001 LIKE logt_t.logt001, 
   logt002 LIKE logt_t.logt002, 
   logt003 LIKE logt_t.logt003, 
   logt004 LIKE logt_t.logt004, 
   logt004_desc LIKE type_t.chr500, 
   logt005 LIKE logt_t.logt005, 
   logt006 LIKE logt_t.logt006, 
   logt007 LIKE logt_t.logt007, 
   logt008 LIKE logt_t.logt008 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_logt2_d RECORD
     logt009        LIKE logt_t.logt009,
     totsum         LIKE type_t.num10,
     spnum          LIKE type_t.num10,
     dnum           LIKE type_t.num10,
     sfnum          LIKE type_t.num10
                    END RECORD
DEFINE g_logt2_d    DYNAMIC ARRAY OF type_g_logt2_d
DEFINE g_wc_table2  STRING
DEFINE ls_str       STRING
DEFINE g_first      LIKE type_t.chr1
DEFINE g_head_wc    STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_logt_d
DEFINE g_master_t                   type_g_logt_d
DEFINE g_logt_d          DYNAMIC ARRAY OF type_g_logt_d
DEFINE g_logt_d_t        type_g_logt_d
 
      
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
 
{<section id="aloq100.main" >}
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
   CALL cl_ap_init("alo","")
 
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
   DECLARE aloq100_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aloq100_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aloq100_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aloq100 WITH FORM cl_ap_formpath("alo",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aloq100_init()   
 
      #進入選單 Menu (="N")
      CALL aloq100_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aloq100
      
   END IF 
   
   CLOSE aloq100_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aloq100.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aloq100_init()
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
   
      CALL cl_set_combo_scc('b_logt001','116') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('b_logt009','110')
   LET g_first = "Y"
   #end add-point
 
   CALL aloq100_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aloq100.default_search" >}
PRIVATE FUNCTION aloq100_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " logt001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " logt002 = '", g_argv[02], "' AND "
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
 
{<section id="aloq100.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aloq100_ui_dialog()
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
      CALL aloq100_b_fill()
   ELSE
      CALL aloq100_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_logt_d.clear()
 
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
 
         CALL aloq100_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_logt_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aloq100_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aloq100_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_logt2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               CALL aloq100_b_fill()
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aloq100_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL DIALOG.setSelectionMode("s_detail2", 1)
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
               CALL aloq100_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION org_data_del
            LET g_action_choice="org_data_del"
            IF cl_auth_chk_act("org_data_del") THEN
               
               #add-point:ON ACTION org_data_del name="menu.org_data_del"
               MENU "" ATTRIBUTE(STYLE="popup")
                  ON ACTION del_loga
                     LET g_action_choice="del_loga"
                     CALL aloq100_org_data_del("del_loga","")
                     EXIT DIALOG

                  ON ACTION del_logb
                     LET g_action_choice="del_logb"
                     CALL aloq100_org_data_del("del_logb","")
                     EXIT DIALOG

                  ON ACTION del_logd
                     LET g_action_choice="del_logd"
                     CALL aloq100_org_data_del("del_logd","")
                     EXIT DIALOG

                  ON ACTION del_logi
                     LET g_action_choice="del_logi"
                     CALL aloq100_org_data_del("del_logi","")
                     EXIT DIALOG

                  ON ACTION del_logs
                     LET g_action_choice="del_logs"
                     CALL aloq100_org_data_del("del_logs","")
                     EXIT DIALOG

                  ON ACTION del_logw
                     LET g_action_choice="del_logw"
                     CALL aloq100_org_data_del("del_logw","")
                     EXIT DIALOG

               END MENU
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aloq100_query()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION condition_delete
            LET g_action_choice="condition_delete"
            IF cl_auth_chk_act("condition_delete") THEN
               
               #add-point:ON ACTION condition_delete name="menu.condition_delete"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION data_export
            LET g_action_choice="data_export"
            IF cl_auth_chk_act("data_export") THEN
               
               #add-point:ON ACTION data_export name="menu.data_export"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION data_delete
            LET g_action_choice="data_delete"
            IF cl_auth_chk_act("data_delete") THEN
               
               #add-point:ON ACTION data_delete name="menu.data_delete"
               CALL aloq100_data_delete()
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aloq100_filter()
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
            CALL aloq100_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_logt_d)
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
            CALL aloq100_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aloq100_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aloq100_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aloq100_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_logt_d.getLength()
               LET g_logt_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_logt_d.getLength()
               LET g_logt_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_logt_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_logt_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_logt_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_logt_d[li_idx].sel = "N"
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
 
{<section id="aloq100.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aloq100_query()
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
   CALL g_logt_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON logt001,logt002,logt003,logt004,logt005,logt006,logt007,logt008
           FROM s_detail1[1].b_logt001,s_detail1[1].b_logt002,s_detail1[1].b_logt003,s_detail1[1].b_logt004, 
               s_detail1[1].b_logt005,s_detail1[1].b_logt006,s_detail1[1].b_logt007,s_detail1[1].b_logt008 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_logt001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt001
            #add-point:BEFORE FIELD b_logt001 name="construct.b.page1.b_logt001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt001
            
            #add-point:AFTER FIELD b_logt001 name="construct.a.page1.b_logt001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt001
            #add-point:ON ACTION controlp INFIELD b_logt001 name="construct.c.page1.b_logt001"
            
            #END add-point
 
 
         #----<<b_logt002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt002
            #add-point:BEFORE FIELD b_logt002 name="construct.b.page1.b_logt002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt002
            
            #add-point:AFTER FIELD b_logt002 name="construct.a.page1.b_logt002"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt002
            #add-point:ON ACTION controlp INFIELD b_logt002 name="construct.c.page1.b_logt002"
            
            #END add-point
 
 
         #----<<b_logt003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt003
            #add-point:BEFORE FIELD b_logt003 name="construct.b.page1.b_logt003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt003
            
            #add-point:AFTER FIELD b_logt003 name="construct.a.page1.b_logt003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt003
            #add-point:ON ACTION controlp INFIELD b_logt003 name="construct.c.page1.b_logt003"
            
            #END add-point
 
 
         #----<<b_logt004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt004
            #add-point:BEFORE FIELD b_logt004 name="construct.b.page1.b_logt004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt004
            
            #add-point:AFTER FIELD b_logt004 name="construct.a.page1.b_logt004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt004
            #add-point:ON ACTION controlp INFIELD b_logt004 name="construct.c.page1.b_logt004"
            
            #END add-point
 
 
         #----<<b_logt004_desc>>----
         #----<<b_logt005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt005
            #add-point:BEFORE FIELD b_logt005 name="construct.b.page1.b_logt005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt005
            
            #add-point:AFTER FIELD b_logt005 name="construct.a.page1.b_logt005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt005
            #add-point:ON ACTION controlp INFIELD b_logt005 name="construct.c.page1.b_logt005"
            
            #END add-point
 
 
         #----<<b_logt006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt006
            #add-point:BEFORE FIELD b_logt006 name="construct.b.page1.b_logt006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt006
            
            #add-point:AFTER FIELD b_logt006 name="construct.a.page1.b_logt006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt006
            #add-point:ON ACTION controlp INFIELD b_logt006 name="construct.c.page1.b_logt006"
            
            #END add-point
 
 
         #----<<b_logt007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt007
            #add-point:BEFORE FIELD b_logt007 name="construct.b.page1.b_logt007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt007
            
            #add-point:AFTER FIELD b_logt007 name="construct.a.page1.b_logt007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt007
            #add-point:ON ACTION controlp INFIELD b_logt007 name="construct.c.page1.b_logt007"
            
            #END add-point
 
 
         #----<<b_logt008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_logt008
            #add-point:BEFORE FIELD b_logt008 name="construct.b.page1.b_logt008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_logt008
            
            #add-point:AFTER FIELD b_logt008 name="construct.a.page1.b_logt008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_logt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt008
            #add-point:ON ACTION controlp INFIELD b_logt008 name="construct.c.page1.b_logt008"
            
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
   CALL aloq100_b_fill_head()
   #end add-point
        
   LET g_error_show = 1
   CALL aloq100_b_fill()
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
 
{<section id="aloq100.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aloq100_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_head_wc) THEN
      LET g_head_wc = " 1=1"
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',logt001,logt002,logt003,logt004,'',logt005,logt006,logt007,logt008  , 
       DENSE_RANK() OVER( ORDER BY logt_t.logt001,logt_t.logt002) AS RANK FROM logt_t",
 
 
                     "",
                     " WHERE logtent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("logt_t"),
                     " ORDER BY logt_t.logt001,logt_t.logt002"
 
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
 
   LET g_sql = "SELECT '',logt001,logt002,logt003,logt004,'',logt005,logt006,logt007,logt008",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = cl_replace_str(g_sql, 'SELECT  UNIQUE', 'SELECT')

   LET ls_str = NULL
   IF g_sql.getIndexOf('ORDER BY',1) > 0 THEN
      LET ls_str = g_sql.subString(g_sql.getIndexOf('ORDER BY',1),g_sql.getLength())
      LET g_sql = g_sql.subString(1,g_sql.getIndexOf('ORDER BY',1)-1)
   END IF
   LET g_sql = g_sql," AND logt009 = '",g_logt2_d[g_detail_idx2].logt009,"' "
   IF NOT cl_null(ls_str) THEN
      LET g_sql = g_sql, ls_str
   END IF
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aloq100_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aloq100_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_logt_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_logt_d[l_ac].sel,g_logt_d[l_ac].logt001,g_logt_d[l_ac].logt002,g_logt_d[l_ac].logt003, 
       g_logt_d[l_ac].logt004,g_logt_d[l_ac].logt004_desc,g_logt_d[l_ac].logt005,g_logt_d[l_ac].logt006, 
       g_logt_d[l_ac].logt007,g_logt_d[l_ac].logt008
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_logt_d[l_ac].statepic = cl_get_actipic(g_logt_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aloq100_detail_show("'1'")      
 
      CALL aloq100_logt_t_mask()
 
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
   
 
   
   CALL g_logt_d.deleteElement(g_logt_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_logt_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aloq100_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aloq100_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aloq100_detail_action_trans()
 
   IF g_logt_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aloq100_fetch()
   END IF
   
      CALL aloq100_filter_show('logt001','b_logt001')
   CALL aloq100_filter_show('logt002','b_logt002')
   CALL aloq100_filter_show('logt003','b_logt003')
   CALL aloq100_filter_show('logt004','b_logt004')
   CALL aloq100_filter_show('logt005','b_logt005')
   CALL aloq100_filter_show('logt006','b_logt006')
   CALL aloq100_filter_show('logt007','b_logt007')
   CALL aloq100_filter_show('logt008','b_logt008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aloq100_fetch()
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
 
{<section id="aloq100.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aloq100_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_logt_d[l_ac].logt004
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_logt_d[l_ac].logt004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_logt_d[l_ac].logt004_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aloq100_filter()
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
      CONSTRUCT g_wc_filter ON logt001,logt002,logt003,logt004,logt005,logt006,logt007,logt008
                          FROM s_detail1[1].b_logt001,s_detail1[1].b_logt002,s_detail1[1].b_logt003, 
                              s_detail1[1].b_logt004,s_detail1[1].b_logt005,s_detail1[1].b_logt006,s_detail1[1].b_logt007, 
                              s_detail1[1].b_logt008
 
         BEFORE CONSTRUCT
                     DISPLAY aloq100_filter_parser('logt001') TO s_detail1[1].b_logt001
            DISPLAY aloq100_filter_parser('logt002') TO s_detail1[1].b_logt002
            DISPLAY aloq100_filter_parser('logt003') TO s_detail1[1].b_logt003
            DISPLAY aloq100_filter_parser('logt004') TO s_detail1[1].b_logt004
            DISPLAY aloq100_filter_parser('logt005') TO s_detail1[1].b_logt005
            DISPLAY aloq100_filter_parser('logt006') TO s_detail1[1].b_logt006
            DISPLAY aloq100_filter_parser('logt007') TO s_detail1[1].b_logt007
            DISPLAY aloq100_filter_parser('logt008') TO s_detail1[1].b_logt008
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_logt001>>----
         #Ctrlp:construct.c.filter.page1.b_logt001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt001
            #add-point:ON ACTION controlp INFIELD b_logt001 name="construct.c.filter.page1.b_logt001"
            
            #END add-point
 
 
         #----<<b_logt002>>----
         #Ctrlp:construct.c.filter.page1.b_logt002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt002
            #add-point:ON ACTION controlp INFIELD b_logt002 name="construct.c.filter.page1.b_logt002"
            
            #END add-point
 
 
         #----<<b_logt003>>----
         #Ctrlp:construct.c.filter.page1.b_logt003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt003
            #add-point:ON ACTION controlp INFIELD b_logt003 name="construct.c.filter.page1.b_logt003"
            
            #END add-point
 
 
         #----<<b_logt004>>----
         #Ctrlp:construct.c.filter.page1.b_logt004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt004
            #add-point:ON ACTION controlp INFIELD b_logt004 name="construct.c.filter.page1.b_logt004"
            
            #END add-point
 
 
         #----<<b_logt004_desc>>----
         #----<<b_logt005>>----
         #Ctrlp:construct.c.filter.page1.b_logt005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt005
            #add-point:ON ACTION controlp INFIELD b_logt005 name="construct.c.filter.page1.b_logt005"
            
            #END add-point
 
 
         #----<<b_logt006>>----
         #Ctrlp:construct.c.filter.page1.b_logt006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt006
            #add-point:ON ACTION controlp INFIELD b_logt006 name="construct.c.filter.page1.b_logt006"
            
            #END add-point
 
 
         #----<<b_logt007>>----
         #Ctrlp:construct.c.filter.page1.b_logt007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt007
            #add-point:ON ACTION controlp INFIELD b_logt007 name="construct.c.filter.page1.b_logt007"
            
            #END add-point
 
 
         #----<<b_logt008>>----
         #Ctrlp:construct.c.filter.page1.b_logt008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_logt008
            #add-point:ON ACTION controlp INFIELD b_logt008 name="construct.c.filter.page1.b_logt008"
            
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
   
      CALL aloq100_filter_show('logt001','b_logt001')
   CALL aloq100_filter_show('logt002','b_logt002')
   CALL aloq100_filter_show('logt003','b_logt003')
   CALL aloq100_filter_show('logt004','b_logt004')
   CALL aloq100_filter_show('logt005','b_logt005')
   CALL aloq100_filter_show('logt006','b_logt006')
   CALL aloq100_filter_show('logt007','b_logt007')
   CALL aloq100_filter_show('logt008','b_logt008')
 
    
   CALL aloq100_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aloq100_filter_parser(ps_field)
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
 
{<section id="aloq100.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aloq100_filter_show(ps_field,ps_object)
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
   LET ls_condition = aloq100_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.insert" >}
#+ insert
PRIVATE FUNCTION aloq100_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aloq100.modify" >}
#+ modify
PRIVATE FUNCTION aloq100_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aloq100_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.delete" >}
#+ delete
PRIVATE FUNCTION aloq100_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aloq100.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aloq100_detail_action_trans()
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
 
{<section id="aloq100.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aloq100_detail_index_setting()
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
            IF g_logt_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_logt_d.getLength() AND g_logt_d.getLength() > 0
            LET g_detail_idx = g_logt_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_logt_d.getLength() THEN
               LET g_detail_idx = g_logt_d.getLength()
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
 
{<section id="aloq100.mask_functions" >}
 &include "erp/alo/aloq100_mask.4gl"
 
{</section>}
 
{<section id="aloq100.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 單頭頁籤資訊填充
# Memo...........:
# Usage..........: CALL aloq100_b_fill_head()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aloq100_b_fill_head()
   DEFINE ls_i     LIKE type_t.num5
   DEFINE ls_j     LIKE type_t.num5


   IF cl_null(g_head_wc) THEN
      LET g_head_wc = " 1=1"
   END IF
   IF cl_null(g_wc_table) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF

   CALL g_logt2_d.clear()

   LET g_sql = "SELECT COUNT(UNIQUE logt009) FROM logt_t",
               " WHERE logtent = ? AND ",g_wc," AND ",g_head_wc,
                 " AND ",g_wc_filter,
                 " AND logt009 = ?"
   PREPARE b_fill_head_count_pre FROM g_sql

   # 計算筆數
   # 總數
   LET g_sql = "SELECT COUNT(*) FROM logt_t",
               " WHERE logtent = ?",
                 " AND ",g_wc ," AND ",g_head_wc,
                 " AND ",g_wc_filter,
                 " AND logt009 = ?"
   PREPARE b_fill_head_totsum_pre FROM g_sql

   # 細項筆數
   LET g_sql = "SELECT COUNT(*) FROM logt_t",
               " WHERE logtent = ?",
                 " AND ",g_wc ," AND ",g_head_wc,
                 " AND ",g_wc_filter,
                 " AND logt009 = ?",
                 " AND logt001 = ?"
   PREPARE b_fill_head_typesum_pre FROM g_sql

   # 需依照指定的4個等級(E、I、W、G)取出資料呈現
   FOR ls_i = 1 TO 4   # 目前事件等級只有4個
      LET ls_j = 0
      CASE
         WHEN ls_i = 1
            EXECUTE b_fill_head_count_pre USING g_enterprise,"E" INTO ls_j
            IF ls_j > 0 THEN
               LET l_ac = g_logt2_d.getLength() + 1
               LET g_logt2_d[l_ac].logt009 = "E"
            END IF

         WHEN ls_i = 2
            EXECUTE b_fill_head_count_pre USING g_enterprise,"I" INTO ls_j
            IF ls_j > 0 THEN
               LET l_ac = g_logt2_d.getLength() + 1
               LET g_logt2_d[l_ac].logt009 = "I"
            END IF

         WHEN ls_i = 3
            EXECUTE b_fill_head_count_pre USING g_enterprise,"W" INTO ls_j
            IF ls_j > 0 THEN
               LET l_ac = g_logt2_d.getLength() + 1
               LET g_logt2_d[l_ac].logt009 = "W"
            END IF

         WHEN ls_i = 4
            EXECUTE b_fill_head_count_pre USING g_enterprise,"G" INTO ls_j
            IF ls_j > 0 THEN
               LET l_ac = g_logt2_d.getLength() + 1
               LET g_logt2_d[l_ac].logt009 = "G"
            END IF
      END CASE
      
      IF ls_j > 0 THEN
         # 計算筆數
         # 總數
         EXECUTE b_fill_head_totsum_pre USING g_enterprise,g_logt2_d[l_ac].logt009 INTO g_logt2_d[l_ac].totsum

         # 細項筆數
         # 系統與程式運行
         EXECUTE b_fill_head_typesum_pre USING g_enterprise,g_logt2_d[l_ac].logt009,"A" INTO g_logt2_d[l_ac].spnum

         # 資料處理
         EXECUTE b_fill_head_typesum_pre USING g_enterprise,g_logt2_d[l_ac].logt009,"B" INTO g_logt2_d[l_ac].dnum

         # 服務與功能
         EXECUTE b_fill_head_typesum_pre USING g_enterprise,g_logt2_d[l_ac].logt009,"C" INTO g_logt2_d[l_ac].sfnum
      END IF
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 刪除log資料
# Memo...........:
# Usage..........: CALL aloq100_data_detele()
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aloq100_data_delete()
   DEFINE ls_msg    STRING
   DEFINE ls_str    STRING

   IF cl_null(g_head_wc) THEN
      LET g_head_wc = " 1=1"
   END IF
   IF cl_null(g_wc_table) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF

   LET ls_msg = "[",cl_get_feldname('logt009',g_lang),"：",g_logt2_d[g_detail_idx2].logt009," ]"
   LET ls_str = cl_getmsg('alo-00001',g_lang)
   LET ls_str = "(alo-00001)",cl_replace_str(ls_str, '%1', ls_msg)
   
   IF cl_ask_confirm2('',ls_str) THEN
      LET g_sql = "DELETE FROM logt_t",
                  " WHERE logtent = ",g_enterprise,
                    " AND ",g_wc,
                    " AND ",g_head_wc,
                    " AND ",g_wc_filter,
                    " AND logt009 = '",g_logt2_d[g_detail_idx2].logt009,"'"
      PREPARE aloq100_delete_all_pre FROM g_sql
      EXECUTE aloq100_delete_all_pre
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DELETE_ALL:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 刪除原始來源table的資料
# Memo...........:
# Usage..........: CALL aloq100_org_data_del(ls_action,ls_where)
# Input parameter: ls_action      動作
#                : ls_where       WHERE條件
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION aloq100_org_data_del(ls_action,ls_where)
   DEFINE ls_action      STRING
   DEFINE ls_where       STRING
   DEFINE ls_table       STRING
   DEFINE ls_table_name  STRING
   DEFINE ls_msg         STRING
   DEFINE ls_str         STRING


   IF cl_null(ls_action) THEN
      RETURN
   END IF
   IF cl_null(ls_where) THEN
      LET ls_where = " 1=1"
   END IF

   LET ls_table = ls_action.subString(ls_action.getIndexOf("del_",1)+4,ls_action.getLength()),"_t"
   LET ls_table_name = cl_get_table_name(ls_table,g_lang)
   LET ls_msg = "[",ls_table_name,"(",ls_table,") ]"
   LET ls_str = cl_getmsg('alo-00002',g_lang)
   LET ls_str = "(alo-00002)\n",cl_replace_str(ls_str, '%1', ls_msg)

   IF cl_ask_confirm2('',ls_str) THEN
      LET g_sql = "DELETE FROM ",ls_table,
                  " WHERE ",ls_where

      PREPARE aloq100_delete_org_pre FROM g_sql
      EXECUTE aloq100_delete_org_pre
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "DELETE_ORG:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
END FUNCTION

 
{</section>}
 