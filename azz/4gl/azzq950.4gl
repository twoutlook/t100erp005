#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq950.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:12(2015-12-29 10:06:14), PR版次:0012(2016-09-05 14:57:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000154
#+ Filename...: azzq950
#+ Description: 背景排程查詢作業
#+ Creator....: 00824(2014-05-02 14:20:00)
#+ Modifier...: 00824 -SD/PR- 00824
 
{</section>}
 
{<section id="azzq950.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160704-00003 #1 2016/07/04 by jrg542 最後展開時間欄位沒有及時更新顯示
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
PRIVATE TYPE type_g_gzpc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   gzpc002 LIKE gzpc_t.gzpc002, 
   gzpc000 LIKE gzpc_t.gzpc000, 
   gzpc001 LIKE gzpc_t.gzpc001, 
   gzpa002 LIKE type_t.chr500, 
   gzpc003 LIKE gzpc_t.gzpc003, 
   gzpc004 LIKE gzpc_t.gzpc004, 
   gzpc006 LIKE gzpc_t.gzpc006, 
   gzpc005 LIKE gzpc_t.gzpc005, 
   gzpc007 LIKE gzpc_t.gzpc007 
       END RECORD
PRIVATE TYPE type_g_gzpc2_d RECORD
       gzpd003 LIKE gzpd_t.gzpd003, 
   gzpd011 LIKE gzpd_t.gzpd011, 
   gzpd004 LIKE gzpd_t.gzpd004, 
   gzpd004_desc LIKE type_t.chr500, 
   gzpd007 LIKE gzpd_t.gzpd007, 
   gzpd008 LIKE gzpd_t.gzpd008, 
   gzpd010 LIKE gzpd_t.gzpd010, 
   gzpd005 LIKE gzpd_t.gzpd005, 
   gzpd009 LIKE gzpd_t.gzpd009, 
   gzpd009_desc LIKE type_t.chr500, 
   gzpd006 LIKE gzpd_t.gzpd006, 
   gzpd012 LIKE gzpd_t.gzpd012, 
   gzpd013 LIKE gzpd_t.gzpd013, 
   gzpd014 LIKE gzpd_t.gzpd014
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_master_m RECORD
   g_gzpa_cnt LIKE type_t.num10, 
   g_gzpc_cnt LIKE type_t.num10,
   g_zone     STRING,
   g_zone_cnt LIKE type_t.num10,
   lt_end     DATETIME YEAR TO SECOND 
END RECORD  

DEFINE g_master_m  type_master_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gzpc_d
DEFINE g_master_t                   type_g_gzpc_d
DEFINE g_gzpc_d          DYNAMIC ARRAY OF type_g_gzpc_d
DEFINE g_gzpc_d_t        type_g_gzpc_d
DEFINE g_gzpc2_d   DYNAMIC ARRAY OF type_g_gzpc2_d
DEFINE g_gzpc2_d_t type_g_gzpc2_d
 
 
      
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
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzq950.main" >}
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
   CALL cl_ap_init("azz","")
 
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
   DECLARE azzq950_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzq950_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq950_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq950 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzq950_init()   
 
      #進入選單 Menu (="N")
      CALL azzq950_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzq950
      
   END IF 
   
   CLOSE azzq950_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzq950.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzq950_init()
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
   
      CALL cl_set_combo_scc('b_gzpc003','66') 
   CALL cl_set_combo_scc('b_gzpc004','65') 
   CALL cl_set_combo_scc('b_gzpd007','64') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   #CALl azzq950_get_schedule_info() #160704-00003
   #end add-point
 
   CALL azzq950_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="azzq950.default_search" >}
PRIVATE FUNCTION azzq950_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gzpc000 = '", g_argv[01], "' AND "
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
 
{<section id="azzq950.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzq950_ui_dialog()
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
   DEFINE li_pos   LIKE type_t.num10
   DEFINE ls_cmd   STRING
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
      CALL azzq950_b_fill()
   ELSE
      CALL azzq950_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gzpc_d.clear()
         CALL g_gzpc2_d.clear()
 
 
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
 
         CALL azzq950_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzpc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL azzq950_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL azzq950_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               LET g_gzpc_d_t.* = g_gzpc_d[l_ac].*
               LET g_gzpc2_d_t.* = g_gzpc2_d[l_ac].*
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            ON UPDATE
               CALL azzq950_set_not_entry_b() 
               INPUT g_gzpc_d[l_ac].* WITHOUT DEFAULTS FROM s_detail1[l_ac].*
               CALL azzq950_set_entry_b() 
               #更新gzpce003(排程執行模式)
               IF g_gzpc_d[l_ac].gzpc003 <> g_gzpc_d_t.gzpc003 THEN
                  UPDATE gzpc_t SET gzpc003 = g_gzpc_d[l_ac].gzpc003 
                   WHERE gzpcent = g_enterprise 
                     AND gzpc000 = g_gzpc_d[l_ac].gzpc000
                     AND gzpc001 = g_gzpc_d[l_ac].gzpc001
               END IF
               #更新gzpce004(排程執行狀況)
               IF g_gzpc_d[l_ac].gzpc004 <> g_gzpc_d_t.gzpc004 THEN
                  IF g_gzpc_d[l_ac].gzpc004 <> "N" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = "azz-00371"
                     LET g_errparam.code   = "azz-00371"
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()

                     LET g_gzpc_d[l_ac].gzpc004 = g_gzpc_d_t.gzpc004
                  ELSE
                     UPDATE gzpc_t SET gzpc004 = g_gzpc_d[l_ac].gzpc004
                      WHERE gzpcent = g_enterprise
                        AND gzpc000 = g_gzpc_d[l_ac].gzpc000
                        AND gzpc001 = g_gzpc_d[l_ac].gzpc001

                     UPDATE gzpd_t SET gzpd007 = "N"
                      WHERE gzpdent = g_enterprise
                        AND gzpd001 = g_gzpc_d[l_ac].gzpc000
                        AND gzpd002 = g_gzpc_d[l_ac].gzpc001
                  END IF
               END IF
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_gzpc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_gzpc2_d.getLength() TO FORMONLY.cnt
               #add-point:input段before row name="input.body2.before_row"
               
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
            CALL azzq950_detail_action_trans()
 
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
               CALL azzq950_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzq950_query()
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
         ON ACTION restart
            LET g_action_choice="restart"
            IF cl_auth_chk_act("restart") THEN
               
               #add-point:ON ACTION restart name="menu.restart"
               IF g_account = "tiptop" THEN
                  LET ls_cmd = "r.r azzp950 kill"
                  RUN ls_cmd
                  DISPLAY "kill azzp950  status_1:",status
                  LET ls_cmd = "r.r azzp951 kill"
                  RUN ls_cmd
                  DISPLAY "kill azzp951  status_2:",status
                  LET ls_cmd = "r.r azzp952"
                  RUN ls_cmd
                  DISPLAY "run azzp952  status_3:",status
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "azz-00366"
                  LET g_errparam.code   = "azz-00366"
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail
            LET g_action_choice="detail"
               
               #add-point:ON ACTION detail name="menu.detail"
               
               #END add-point
               
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION purge
            LET g_action_choice="purge"
            IF cl_auth_chk_act("purge") THEN
               
               #add-point:ON ACTION purge name="menu.purge"
               CALL azzq950_clear_30days_record()
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL azzq950_filter()
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
            CALL azzq950_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzpc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_gzpc2_d)
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
            CALL azzq950_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL azzq950_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL azzq950_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL azzq950_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_gzpc_d.getLength()
               LET g_gzpc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_gzpc_d.getLength()
               LET g_gzpc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_gzpc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzpc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_gzpc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzpc_d[li_idx].sel = "N"
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
 
{<section id="azzq950.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzq950_query()
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
   CALL g_gzpc_d.clear()
   CALL g_gzpc2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON gzpc002,gzpc000,gzpc001,gzpc003,gzpc004,gzpc006,gzpc005,gzpc007
           FROM s_detail1[1].b_gzpc002,s_detail1[1].b_gzpc000,s_detail1[1].b_gzpc001,s_detail1[1].b_gzpc003, 
               s_detail1[1].b_gzpc004,s_detail1[1].b_gzpc006,s_detail1[1].b_gzpc005,s_detail1[1].b_gzpc007 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
             CALL azzq950_get_schedule_info() #160704-00003
             CALl azzq950_show_info()
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_gzpc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc002
            #add-point:BEFORE FIELD b_gzpc002 name="construct.b.page1.b_gzpc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc002
            
            #add-point:AFTER FIELD b_gzpc002 name="construct.a.page1.b_gzpc002"
            #帶出完整的日期區間
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc002
            #add-point:ON ACTION controlp INFIELD b_gzpc002 name="construct.c.page1.b_gzpc002"
            
            #END add-point
 
 
         #----<<b_gzpc000>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc000
            #add-point:BEFORE FIELD b_gzpc000 name="construct.b.page1.b_gzpc000"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc000
            
            #add-point:AFTER FIELD b_gzpc000 name="construct.a.page1.b_gzpc000"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc000
            #add-point:ON ACTION controlp INFIELD b_gzpc000 name="construct.c.page1.b_gzpc000"
            
            #END add-point
 
 
         #----<<b_gzpc001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc001
            #add-point:BEFORE FIELD b_gzpc001 name="construct.b.page1.b_gzpc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc001
            
            #add-point:AFTER FIELD b_gzpc001 name="construct.a.page1.b_gzpc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc001
            #add-point:ON ACTION controlp INFIELD b_gzpc001 name="construct.c.page1.b_gzpc001"
            
            #END add-point
 
 
         #----<<b_gzpa002>>----
         #----<<b_gzpc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc003
            #add-point:BEFORE FIELD b_gzpc003 name="construct.b.page1.b_gzpc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc003
            
            #add-point:AFTER FIELD b_gzpc003 name="construct.a.page1.b_gzpc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc003
            #add-point:ON ACTION controlp INFIELD b_gzpc003 name="construct.c.page1.b_gzpc003"
            
            #END add-point
 
 
         #----<<b_gzpc004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc004
            #add-point:BEFORE FIELD b_gzpc004 name="construct.b.page1.b_gzpc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc004
            
            #add-point:AFTER FIELD b_gzpc004 name="construct.a.page1.b_gzpc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc004
            #add-point:ON ACTION controlp INFIELD b_gzpc004 name="construct.c.page1.b_gzpc004"
            
            #END add-point
 
 
         #----<<b_gzpc006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc006
            #add-point:BEFORE FIELD b_gzpc006 name="construct.b.page1.b_gzpc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc006
            
            #add-point:AFTER FIELD b_gzpc006 name="construct.a.page1.b_gzpc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc006
            #add-point:ON ACTION controlp INFIELD b_gzpc006 name="construct.c.page1.b_gzpc006"
            
            #END add-point
 
 
         #----<<b_gzpc005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc005
            #add-point:BEFORE FIELD b_gzpc005 name="construct.b.page1.b_gzpc005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc005
            
            #add-point:AFTER FIELD b_gzpc005 name="construct.a.page1.b_gzpc005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc005
            #add-point:ON ACTION controlp INFIELD b_gzpc005 name="construct.c.page1.b_gzpc005"
            
            #END add-point
 
 
         #----<<b_gzpc007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpc007
            #add-point:BEFORE FIELD b_gzpc007 name="construct.b.page1.b_gzpc007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpc007
            
            #add-point:AFTER FIELD b_gzpc007 name="construct.a.page1.b_gzpc007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzpc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc007
            #add-point:ON ACTION controlp INFIELD b_gzpc007 name="construct.c.page1.b_gzpc007"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON gzpd003,gzpd011,gzpd004,gzpd007,gzpd008,gzpd010,gzpd005,gzpd009,gzpd006, 
          gzpd012,gzpd013,gzpd014
           FROM s_detail2[1].b_gzpd003,s_detail2[1].b_gzpd011,s_detail2[1].b_gzpd004,s_detail2[1].b_gzpd007, 
               s_detail2[1].b_gzpd008,s_detail2[1].b_gzpd010,s_detail2[1].b_gzpd005,s_detail2[1].b_gzpd009, 
               s_detail2[1].b_gzpd006,s_detail2[1].b_gzpd012,s_detail2[1].b_gzpd013,s_detail2[1].b_gzpd014 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_gzpd003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd003
            #add-point:BEFORE FIELD b_gzpd003 name="construct.b.page2.b_gzpd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd003
            
            #add-point:AFTER FIELD b_gzpd003 name="construct.a.page2.b_gzpd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd003
            #add-point:ON ACTION controlp INFIELD b_gzpd003 name="construct.c.page2.b_gzpd003"
            
            #END add-point
 
 
         #----<<b_gzpd011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd011
            #add-point:BEFORE FIELD b_gzpd011 name="construct.b.page2.b_gzpd011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd011
            
            #add-point:AFTER FIELD b_gzpd011 name="construct.a.page2.b_gzpd011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd011
            #add-point:ON ACTION controlp INFIELD b_gzpd011 name="construct.c.page2.b_gzpd011"
            
            #END add-point
 
 
         #----<<b_gzpd004>>----
         #Ctrlp:construct.c.page2.b_gzpd004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd004
            #add-point:ON ACTION controlp INFIELD b_gzpd004 name="construct.c.page2.b_gzpd004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzza001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzpd004  #顯示到畫面上
            NEXT FIELD b_gzpd004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd004
            #add-point:BEFORE FIELD b_gzpd004 name="construct.b.page2.b_gzpd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd004
            
            #add-point:AFTER FIELD b_gzpd004 name="construct.a.page2.b_gzpd004"
            
            #END add-point
            
 
 
         #----<<b_gzpd004_desc>>----
         #----<<b_gzpd007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd007
            #add-point:BEFORE FIELD b_gzpd007 name="construct.b.page2.b_gzpd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd007
            
            #add-point:AFTER FIELD b_gzpd007 name="construct.a.page2.b_gzpd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd007
            #add-point:ON ACTION controlp INFIELD b_gzpd007 name="construct.c.page2.b_gzpd007"
            
            #END add-point
 
 
         #----<<b_gzpd008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd008
            #add-point:BEFORE FIELD b_gzpd008 name="construct.b.page2.b_gzpd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd008
            
            #add-point:AFTER FIELD b_gzpd008 name="construct.a.page2.b_gzpd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd008
            #add-point:ON ACTION controlp INFIELD b_gzpd008 name="construct.c.page2.b_gzpd008"
            
            #END add-point
 
 
         #----<<b_gzpd010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd010
            #add-point:BEFORE FIELD b_gzpd010 name="construct.b.page2.b_gzpd010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd010
            
            #add-point:AFTER FIELD b_gzpd010 name="construct.a.page2.b_gzpd010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd010
            #add-point:ON ACTION controlp INFIELD b_gzpd010 name="construct.c.page2.b_gzpd010"
            
            #END add-point
 
 
         #----<<b_gzpd005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd005
            #add-point:BEFORE FIELD b_gzpd005 name="construct.b.page2.b_gzpd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd005
            
            #add-point:AFTER FIELD b_gzpd005 name="construct.a.page2.b_gzpd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd005
            #add-point:ON ACTION controlp INFIELD b_gzpd005 name="construct.c.page2.b_gzpd005"
            
            #END add-point
 
 
         #----<<b_gzpd009>>----
         #Ctrlp:construct.c.page2.b_gzpd009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd009
            #add-point:ON ACTION controlp INFIELD b_gzpd009 name="construct.c.page2.b_gzpd009"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzxa001_2()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzpd009  #顯示到畫面上
            NEXT FIELD b_gzpd009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd009
            #add-point:BEFORE FIELD b_gzpd009 name="construct.b.page2.b_gzpd009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd009
            
            #add-point:AFTER FIELD b_gzpd009 name="construct.a.page2.b_gzpd009"
            
            #END add-point
            
 
 
         #----<<b_gzpd009_desc>>----
         #----<<b_gzpd006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd006
            #add-point:BEFORE FIELD b_gzpd006 name="construct.b.page2.b_gzpd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd006
            
            #add-point:AFTER FIELD b_gzpd006 name="construct.a.page2.b_gzpd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd006
            #add-point:ON ACTION controlp INFIELD b_gzpd006 name="construct.c.page2.b_gzpd006"
            
            #END add-point
 
 
         #----<<b_gzpd012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd012
            #add-point:BEFORE FIELD b_gzpd012 name="construct.b.page2.b_gzpd012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd012
            
            #add-point:AFTER FIELD b_gzpd012 name="construct.a.page2.b_gzpd012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd012
            #add-point:ON ACTION controlp INFIELD b_gzpd012 name="construct.c.page2.b_gzpd012"
            
            #END add-point
 
 
         #----<<b_gzpd013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd013
            #add-point:BEFORE FIELD b_gzpd013 name="construct.b.page2.b_gzpd013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd013
            
            #add-point:AFTER FIELD b_gzpd013 name="construct.a.page2.b_gzpd013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd013
            #add-point:ON ACTION controlp INFIELD b_gzpd013 name="construct.c.page2.b_gzpd013"
            
            #END add-point
 
 
         #----<<b_gzpd014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzpd014
            #add-point:BEFORE FIELD b_gzpd014 name="construct.b.page2.b_gzpd014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzpd014
            
            #add-point:AFTER FIELD b_gzpd014 name="construct.a.page2.b_gzpd014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_gzpd014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpd014
            #add-point:ON ACTION controlp INFIELD b_gzpd014 name="construct.c.page2.b_gzpd014"
            
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
         CALL azzq950_get_schedule_info() #160704-00003
         CALL azzq950_show_info()
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc = g_wc, " AND ", g_wc2_table2
   END IF
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
      LET g_wc2 = g_wc2, " AND ", g_wc2_table2
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
   CALL azzq950_b_fill()
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
 
{<section id="azzq950.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzq950_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',gzpc002,gzpc000,gzpc001,'',gzpc003,gzpc004,gzpc006,gzpc005,gzpc007  , 
       DENSE_RANK() OVER( ORDER BY gzpc_t.gzpc000) AS RANK FROM gzpc_t",
 
                     " LEFT JOIN gzpd_t ON gzpdent = gzpcent AND gzpc000 = gzpd001",
 
 
                     "",
                     " WHERE gzpcent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gzpc_t"),
                     " ORDER BY gzpc_t.gzpc000"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = ""
   LET ls_sql_rank = "SELECT  UNIQUE '',gzpc002,gzpc000,gzpc001,'',",
                            " gzpc003,gzpc004,gzpc006,gzpc005,gzpc007, ",
                            " DENSE_RANK() OVER( ORDER BY gzpc_t.gzpc002 DESC ) AS RANK FROM gzpc_t", 
                     " LEFT JOIN gzpd_t ON gzpdent = gzpcent AND gzpc000 = gzpd001",
                     "",
                     " WHERE gzpcent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gzpc_t"),
                     " ORDER BY gzpc_t.gzpc002 DESC" 
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
 
   LET g_sql = "SELECT '',gzpc002,gzpc000,gzpc001,'',gzpc003,gzpc004,gzpc006,gzpc005,gzpc007",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzq950_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzq950_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_gzpc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_gzpc_d[l_ac].sel,g_gzpc_d[l_ac].gzpc002,g_gzpc_d[l_ac].gzpc000,g_gzpc_d[l_ac].gzpc001, 
       g_gzpc_d[l_ac].gzpa002,g_gzpc_d[l_ac].gzpc003,g_gzpc_d[l_ac].gzpc004,g_gzpc_d[l_ac].gzpc006,g_gzpc_d[l_ac].gzpc005, 
       g_gzpc_d[l_ac].gzpc007
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_gzpc_d[l_ac].statepic = cl_get_actipic(g_gzpc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT gzpa002 INTO g_gzpc_d[l_ac].gzpa002 FROM gzpa_t 
       WHERE gzpa001 = g_gzpc_d[l_ac].gzpc001       
      
      #end add-point
 
      CALL azzq950_detail_show("'1'")      
 
      CALL azzq950_gzpc_t_mask()
 
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
   
 
   
   CALL g_gzpc_d.deleteElement(g_gzpc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_gzpc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE azzq950_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL azzq950_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL azzq950_detail_action_trans()
 
   IF g_gzpc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL azzq950_fetch()
   END IF
   
      CALL azzq950_filter_show('gzpc002','b_gzpc002')
   CALL azzq950_filter_show('gzpc000','b_gzpc000')
   CALL azzq950_filter_show('gzpc001','b_gzpc001')
   CALL azzq950_filter_show('gzpc003','b_gzpc003')
   CALL azzq950_filter_show('gzpc004','b_gzpc004')
   CALL azzq950_filter_show('gzpc006','b_gzpc006')
   CALL azzq950_filter_show('gzpc005','b_gzpc005')
   CALL azzq950_filter_show('gzpc007','b_gzpc007')
   CALL azzq950_filter_show('gzpd003','b_gzpd003')
   CALL azzq950_filter_show('gzpd011','b_gzpd011')
   CALL azzq950_filter_show('gzpd004','b_gzpd004')
   CALL azzq950_filter_show('gzpd007','b_gzpd007')
   CALL azzq950_filter_show('gzpd008','b_gzpd008')
   CALL azzq950_filter_show('gzpd010','b_gzpd010')
   CALL azzq950_filter_show('gzpd005','b_gzpd005')
   CALL azzq950_filter_show('gzpd009','b_gzpd009')
   CALL azzq950_filter_show('gzpd006','b_gzpd006')
   CALL azzq950_filter_show('gzpd012','b_gzpd012')
   CALL azzq950_filter_show('gzpd013','b_gzpd013')
   CALL azzq950_filter_show('gzpd014','b_gzpd014')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzq950_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   CALL g_gzpc2_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE gzpd003,gzpd011,gzpd004,'',gzpd007,gzpd008,gzpd010,gzpd005,gzpd009, 
          '',gzpd006,gzpd012,gzpd013,gzpd014 FROM gzpd_t",    
                  "",
                  " WHERE gzpdent=? AND gzpd001=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY gzpd_t.gzpd003" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"
      
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE azzq950_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR azzq950_pb2
   END IF
 
#(ver:42) mark ---start---
#  OPEN b_fill_curs2 USING g_enterprise,g_gzpc_d[g_detail_idx].gzpc000
 
#(ver:42) mark --- end ---
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise,g_gzpc_d[g_detail_idx].gzpc000   #(ver:42)
 
        INTO g_gzpc2_d[l_ac].gzpd003,g_gzpc2_d[l_ac].gzpd011,g_gzpc2_d[l_ac].gzpd004,g_gzpc2_d[l_ac].gzpd004_desc, 
            g_gzpc2_d[l_ac].gzpd007,g_gzpc2_d[l_ac].gzpd008,g_gzpc2_d[l_ac].gzpd010,g_gzpc2_d[l_ac].gzpd005, 
            g_gzpc2_d[l_ac].gzpd009,g_gzpc2_d[l_ac].gzpd009_desc,g_gzpc2_d[l_ac].gzpd006,g_gzpc2_d[l_ac].gzpd012, 
            g_gzpc2_d[l_ac].gzpd013,g_gzpc2_d[l_ac].gzpd014   #(ver:42)
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
      
      CALL azzq950_detail_show("'2'")      
 
      CALL azzq950_gzpd_t_mask()
 
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
   
   #end add-point 
   
   CALL g_gzpc2_d.deleteElement(g_gzpc2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_gzpc2_d.getLength()
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
 
{<section id="azzq950.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzq950_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE lc_gzxa003 LIKE gzxa_t.gzxa003
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      
      #end add-point
   END IF
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzpc2_d[l_ac].gzpd004
            CALL ap_ref_array2(g_ref_fields,"SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'","") RETURNING g_rtn_fields
            LET g_gzpc2_d[l_ac].gzpd004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzpc2_d[l_ac].gzpd004_desc

            SELECT gzxa003 INTO lc_gzxa003 FROM gzxa_t
             WHERE gzxaent = g_enterprise 
              AND gzxa001 = g_gzpc2_d[l_ac].gzpd009
              
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = lc_gzxa003
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzpc2_d[l_ac].gzpd009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzpc2_d[l_ac].gzpd009_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION azzq950_filter()
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
      CONSTRUCT g_wc_filter ON gzpc002,gzpc000,gzpc001,gzpc003,gzpc004,gzpc006,gzpc005,gzpc007
                          FROM s_detail1[1].b_gzpc002,s_detail1[1].b_gzpc000,s_detail1[1].b_gzpc001, 
                              s_detail1[1].b_gzpc003,s_detail1[1].b_gzpc004,s_detail1[1].b_gzpc006,s_detail1[1].b_gzpc005, 
                              s_detail1[1].b_gzpc007
 
         BEFORE CONSTRUCT
                     DISPLAY azzq950_filter_parser('gzpc002') TO s_detail1[1].b_gzpc002
            DISPLAY azzq950_filter_parser('gzpc000') TO s_detail1[1].b_gzpc000
            DISPLAY azzq950_filter_parser('gzpc001') TO s_detail1[1].b_gzpc001
            DISPLAY azzq950_filter_parser('gzpc003') TO s_detail1[1].b_gzpc003
            DISPLAY azzq950_filter_parser('gzpc004') TO s_detail1[1].b_gzpc004
            DISPLAY azzq950_filter_parser('gzpc006') TO s_detail1[1].b_gzpc006
            DISPLAY azzq950_filter_parser('gzpc005') TO s_detail1[1].b_gzpc005
            DISPLAY azzq950_filter_parser('gzpc007') TO s_detail1[1].b_gzpc007
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_gzpc002>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc002
            #add-point:ON ACTION controlp INFIELD b_gzpc002 name="construct.c.filter.page1.b_gzpc002"
            
            #END add-point
 
 
         #----<<b_gzpc000>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc000
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc000
            #add-point:ON ACTION controlp INFIELD b_gzpc000 name="construct.c.filter.page1.b_gzpc000"
            
            #END add-point
 
 
         #----<<b_gzpc001>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc001
            #add-point:ON ACTION controlp INFIELD b_gzpc001 name="construct.c.filter.page1.b_gzpc001"
            
            #END add-point
 
 
         #----<<b_gzpa002>>----
         #----<<b_gzpc003>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc003
            #add-point:ON ACTION controlp INFIELD b_gzpc003 name="construct.c.filter.page1.b_gzpc003"
            
            #END add-point
 
 
         #----<<b_gzpc004>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc004
            #add-point:ON ACTION controlp INFIELD b_gzpc004 name="construct.c.filter.page1.b_gzpc004"
            
            #END add-point
 
 
         #----<<b_gzpc006>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc006
            #add-point:ON ACTION controlp INFIELD b_gzpc006 name="construct.c.filter.page1.b_gzpc006"
            
            #END add-point
 
 
         #----<<b_gzpc005>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc005
            #add-point:ON ACTION controlp INFIELD b_gzpc005 name="construct.c.filter.page1.b_gzpc005"
            
            #END add-point
 
 
         #----<<b_gzpc007>>----
         #Ctrlp:construct.c.filter.page1.b_gzpc007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzpc007
            #add-point:ON ACTION controlp INFIELD b_gzpc007 name="construct.c.filter.page1.b_gzpc007"
            
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
   
      CALL azzq950_filter_show('gzpc002','b_gzpc002')
   CALL azzq950_filter_show('gzpc000','b_gzpc000')
   CALL azzq950_filter_show('gzpc001','b_gzpc001')
   CALL azzq950_filter_show('gzpc003','b_gzpc003')
   CALL azzq950_filter_show('gzpc004','b_gzpc004')
   CALL azzq950_filter_show('gzpc006','b_gzpc006')
   CALL azzq950_filter_show('gzpc005','b_gzpc005')
   CALL azzq950_filter_show('gzpc007','b_gzpc007')
   CALL azzq950_filter_show('gzpd003','b_gzpd003')
   CALL azzq950_filter_show('gzpd011','b_gzpd011')
   CALL azzq950_filter_show('gzpd004','b_gzpd004')
   CALL azzq950_filter_show('gzpd007','b_gzpd007')
   CALL azzq950_filter_show('gzpd008','b_gzpd008')
   CALL azzq950_filter_show('gzpd010','b_gzpd010')
   CALL azzq950_filter_show('gzpd005','b_gzpd005')
   CALL azzq950_filter_show('gzpd009','b_gzpd009')
   CALL azzq950_filter_show('gzpd006','b_gzpd006')
   CALL azzq950_filter_show('gzpd012','b_gzpd012')
   CALL azzq950_filter_show('gzpd013','b_gzpd013')
   CALL azzq950_filter_show('gzpd014','b_gzpd014')
 
    
   CALL azzq950_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION azzq950_filter_parser(ps_field)
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
 
{<section id="azzq950.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION azzq950_filter_show(ps_field,ps_object)
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
   LET ls_condition = azzq950_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.insert" >}
#+ insert
PRIVATE FUNCTION azzq950_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzq950.modify" >}
#+ modify
PRIVATE FUNCTION azzq950_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.reproduce" >}
#+ reproduce
PRIVATE FUNCTION azzq950_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.delete" >}
#+ delete
PRIVATE FUNCTION azzq950_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq950.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION azzq950_detail_action_trans()
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
 
{<section id="azzq950.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION azzq950_detail_index_setting()
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
            IF g_gzpc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gzpc_d.getLength() AND g_gzpc_d.getLength() > 0
            LET g_detail_idx = g_gzpc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gzpc_d.getLength() THEN
               LET g_detail_idx = g_gzpc_d.getLength()
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
 
{<section id="azzq950.mask_functions" >}
 &include "erp/azz/azzq950_mask.4gl"
 
{</section>}
 
{<section id="azzq950.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 作業特殊處裡
# Memo...........:
# Usage..........: CALL azzq950_prog_status_change(ps_param)
#                  RETURNING 
# Input parameter: ps_param 參數 STRING　
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_prog_status_change(ps_param)
   DEFINE ps_param   STRING 
   DEFINE ls_cmd     STRING 
   DEFINE lch_pipe   base.Channel
   DEFINE ls_tmp     STRING
   DEFINE lc_gzpd007 LIKE gzpd_t.gzpd007 
   DEFINE ls_tmp2    STRING  

   #排程暫停  kill -19  PID 
   #排程繼續  kill -18  PID 
   #排程停止  kill -15  PID
   LET ls_tmp2 = NULL 
   LET ls_cmd = "ps -ef | grep " ,g_gzpc2_d[l_ac].gzpd004 ," | grep ", g_gzpc2_d[l_ac].gzpd012 #,            
   LET lch_pipe = base.Channel.create() 
   CALL lch_pipe.openPipe(ls_cmd.trim(), "r")   
   WHILE lch_pipe.read(ls_tmp)
      IF ls_tmp.trim() IS NULL THEN CONTINUE WHILE END IF
      IF ls_tmp.getIndexOf("sessionkey",1) THEN 
          #取出PID
          CALL azzq950_token(ls_tmp) RETURNING ls_tmp2
          EXIT WHILE 
      END IF 
   END WHILE
   CALL lch_pipe.close()

   IF NOT cl_null(ls_tmp2)THEN 
      RUN "kill "||ps_param || " " || ls_tmp2
      CASE 
         WHEN ps_param = "-15"
            LET lc_gzpd007 = "S"  #強制停止
         WHEN ps_param = "-18"
            LET lc_gzpd007 = "R"  #執行中
         WHEN ps_param = "-19"
            LET lc_gzpd007 = "P"  #暫停執行
      END CASE 

   UPDATE gzpd_t SET gzpd007 = lc_gzpd007
    WHERE gzpdent = g_enterprise  
      AND gzpd001 = g_gzpc_d[g_detail_idx].gzpc000
      AND gzpd003 = g_gzpc2_d[g_detail_idx2].gzpd003
   END IF 
   
END FUNCTION

################################################################################
# Descriptions...: token 字串
# Memo...........:
# Usage..........: CALL azzq950_token(ps_tmp)
#                  RETURNING 
# Input parameter: ps_tmp 字串 STRING
#                : 
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_token(ps_tmp)
   DEFINE ps_tmp STRING 
   DEFINE ls_token STRING 
   DEFINE l_token base.StringTokenizer  
   LET l_token = base.StringTokenizer.create(ps_tmp," ")
   WHILE l_token.hasMoreTokens()
      LET ls_token = l_token.nextToken()
      LET ls_token = l_token.nextToken()
      EXIT WHILE 
  END WHILE

  RETURN ls_token
END FUNCTION

################################################################################
# Descriptions...: 排程執行狀況 "N"(未執行) or "R"(執行中) 才可變更執行狀態
# Memo...........:
# Usage..........: CALL azzp950_chk_process()
#                  RETURNING 回传参数
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp950_chk_process()
   DEFINE li_chk LIKE type_t.num5
   
   IF g_gzpc_d[g_detail_idx].gzpc004 = "N" OR g_gzpc_d[g_detail_idx].gzpc004 = "R" THEN 
      LET li_chk =  TRUE  
   ELSE 
      LET li_chk =  FALSE 
   END IF 
   RETURN li_chk
END FUNCTION

################################################################################
# Descriptions...: 排程狀態改變
# Memo...........:
# Usage..........: CALL azzp950_process_status_change(ps_param)
#                  RETURNING 回传参数
# Input parameter: ps_param 參數 STRING 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp950_process_status_change(ps_param)
    DEFINE ps_param   STRING 
   DEFINE ls_cmd     STRING 
   DEFINE lch_pipe   base.Channel
   DEFINE ls_tmp     STRING
   DEFINE lc_gzpd007 LIKE gzpd_t.gzpd007 
   DEFINE ls_tmp2    STRING  
   DEFINE lc_gzpc004 LIKE gzpc_t.gzpc004 
 
   #排程暫停  kill -19  PID 
   #排程停止  kill -15  PID
   CASE
      WHEN ps_param = "-19"
         LET lc_gzpc004 = "P" #P:暫停執行
      WHEN ps_param = "-15"
         LET lc_gzpc004 = "C" #C:關閉排程  
   END CASE 

   UPDATE gzpc_t SET gzpc004 = lc_gzpc004
    WHERE gzpcent = g_enterprise  
      AND gzpc000 = g_gzpc_d[g_detail_idx].gzpc000
      AND gzpc001 = g_gzpc_d[g_detail_idx].gzpc001
      AND gzpc002 = g_gzpc_d[g_detail_idx].gzpc002
      AND gzpc003 = g_gzpc_d[g_detail_idx].gzpc003

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_modify_gzpc003(li_pos)
   DEFINE li_pos LIKE type_t.num10
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT g_gzpc_d[li_pos].gzpc003 FROM gzpc003
         BEFORE INPUT
      END INPUT
   END DIALOG
END FUNCTION

################################################################################
# Descriptions...: 取有效設定排程總數、已展開排程總數、最後展開排程時間
# Memo...........:
# Usage..........: CALL azzq950_get_schedule_info()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/05/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_get_schedule_info()
   
   SELECT COUNT(*) INTO g_master_m.g_gzpa_cnt FROM gzpa_t 
    WHERE gzpaent = g_enterprise 
     AND gzpastus = 'Y'

   DISPLAY g_master_m.g_gzpa_cnt TO l_process_cnt 

   SELECT COUNT(*) INTO g_master_m.g_gzpc_cnt FROM gzpc_t 
    WHERE gzpcent = g_enterprise 
     

   DISPLAY g_master_m.g_gzpa_cnt TO l_expend_cnt
   
   SELECT gzpf002 INTO g_master_m.lt_end FROM gzpf_t 
    WHERE gzpfent = g_enterprise 
     AND gzpf001 = 'azzp950'

   LET g_master_m.g_zone = FGL_GETENV("ZONE")

   SELECT COUNT(*) INTO g_master_m.g_zone_cnt FROM gzpa_t 
    WHERE gzpastus = 'Y'   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq950_set_entry_b()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_set_entry_b()
   CALL cl_set_comp_entry("sel,b_gzpc002,b_gzpc000,b_gzpc001,b_gzpa002,b_gzpc004,b_gzpc006",TRUE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq950_set_not_entry_b()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
# Return code....: 回传参数变量1   回传参数变量说明1
# Date & Author..: 2015/05/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_set_not_entry_b()
   CALL cl_set_comp_entry("sel,b_gzpc002,b_gzpc000,b_gzpc001,b_gzpa002,b_gzpc006",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq950_show_info()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_show_info()
   
   DISPLAY g_master_m.g_gzpa_cnt TO l_process_cnt  #企業內有效排程數

   SELECT COUNT(1) INTO g_master_m.g_gzpc_cnt FROM gzpc_t
    WHERE gzpcent = g_enterprise
   DISPLAY g_master_m.g_gzpc_cnt TO l_expend_cnt   #展開排程總數
   
   DISPLAY g_master_m.lt_end TO l_expend_time      #最近一次排程啟動掃描時間(azzp950 )

   DISPLAY g_master_m.g_zone TO l_zone             #區域

   DISPLAY g_master_m.g_zone_cnt TO l_zone_cnt     #區域內有效排程總數
END FUNCTION

################################################################################
# Descriptions...: 清除30天前的紀錄
# Memo...........:
# Usage..........: CALL azzq950_clear_30days_record (传入参数)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq950_clear_30days_record()
   DEFINE ls_deadline    LIKE gzpc_t.gzpc002
   DEFINE ls_sql         STRING
   DEFINE ls_tot_cnt     LIKE type_t.num10
   DEFINE ls_gzpc000     LIKE gzpc_t.gzpc000
   DEFINE ls_err         LIKE type_t.chr1
   
   
   LET ls_err = "N"
   LET ls_deadline = g_today - 30
DISPLAY "ls_deadline:",ls_deadline

   CALL s_transaction_begin()

   IF cl_ask_del_master() THEN
      #計算此次處理的總筆數
      LET ls_tot_cnt = 0
      LET ls_sql = "SELECT COUNT(1) FROM gzpc_t ",
                   " WHERE gzpcent = ",g_enterprise,
                     " AND gzpc002 < ? "
      PREPARE azzq950_get_tot_rows_pre FROM ls_sql
      EXECUTE azzq950_get_tot_rows_pre USING ls_deadline INTO ls_tot_cnt
      
      IF ls_tot_cnt > 0 THEN
         #計算progress bar總筆數
         CALL cl_progress_bar(ls_tot_cnt)

         #選取要刪除的資料
         LET ls_sql = "SELECT gzpc000 FROM gzpc_t ",
                      " WHERE gzpcent = ",g_enterprise,
                        " AND gzpc002 < ? "
         PREPARE azzq950_get_gzpc000_pre FROM ls_sql
         DECLARE azzq950_get_gzpc000_curs CURSOR FOR azzq950_get_gzpc000_pre
         FOREACH azzq950_get_gzpc000_curs USING ls_deadline INTO ls_gzpc000
            #顯示progress bar進度
            CALL cl_progress_ing("Delete gzpc_t & gzpd_t data ... " || ls_gzpc000)

            #依據取出的單頭資訊，先刪除單身再刪除單頭資料
            #刪除單身資料
            DELETE FROM gzpd_t
             WHERE gzpdent = g_enterprise
               AND gzpd001 = ls_gzpc000
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "gzpd_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET ls_err = "Y"

               EXIT FOREACH
            END IF

            #刪除單頭資料
            DELETE FROM gzpc_t
             WHERE gzpcent = g_enterprise
               AND gzpc000 = ls_gzpc000
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = "gzpc_t"
               LET g_errparam.code   = SQLCA.sqlcode
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET ls_err = "Y"

               EXIT FOREACH
            END IF
         END FOREACH

         IF ls_err = "Y" THEN
            CALL s_transaction_end('N','0')
         ELSE
            CALL s_transaction_end('Y','0')
            CALL cl_ask_pressanykey("azz-00365")           
         END IF
         
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "asf-00697"
         LET g_errparam.code   = "asf-00697"
         LET g_errparam.popup  = TRUE
         CALL cl_err()

         CALL s_transaction_end('N','0')
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   
END FUNCTION

 
{</section>}
 
