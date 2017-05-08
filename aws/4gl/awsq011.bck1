#該程式已解開Section, 不再透過樣板產出!
{<section id="awsq011.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-21 15:43:01), PR版次:0001(2017-01-03 11:53:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: awsq011
#+ Description: BPM簽核歷程查詢作業
#+ Creator....: 07375(2016-11-21 15:43:01)
#+ Modifier...: 07375 -SD/PR- 07375
 
{</section>}
 
{<section id="awsq011.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
IMPORT xml
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_wsba_d RECORD
       
       wsba001 LIKE wsba_t.wsba001, 
   wsba002 LIKE wsba_t.wsba002, 
   wsba003 LIKE wsba_t.wsba003, 
   wsba005 LIKE wsba_t.wsba005, 
   wsba006 LIKE wsba_t.wsba006, 
   wsba007 LIKE wsba_t.wsba007, 
   wsba004 LIKE wsba_t.wsba004,
   wsba008 LIKE wsba_t.wsba008
       END RECORD
PRIVATE TYPE type_g_wsba2_d RECORD
       wsbd001 LIKE wsbd_t.wsbd001, 
   wsbd003 LIKE wsbd_t.wsbd003, 
   wsbd003_desc LIKE type_t.chr500, 
   wsbd004 LIKE wsbd_t.wsbd004, 
   wsbd005 LIKE wsbd_t.wsbd005,
   wsbd007 LIKE type_t.chr100
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_srvcode          STRING   #服務執行結果狀態代碼
DEFINE g_ws_code          STRING   #sql代碼
DEFINE g_ws_sqlcode       STRING   #sql代碼
DEFINE g_ws_description   STRING   #錯誤描述
DEFINE g_docno            LIKE type_t.chr20
DEFINE g_bpm_err            STRING
DEFINE wsbd_tmp DYNAMIC ARRAY OF RECORD 
       wsbd006 LIKE wsbd_t.wsbd006
       END RECORD

#tag中所要設定的屬性資料
TYPE type_g_attribute DYNAMIC ARRAY OF RECORD
                name         STRING,      #屬性名稱
                value        STRING       #屬性值
             END RECORD
#BPM單據簽核記錄檔           
TYPE type_g_wsba RECORD
       wsba001          LIKE wsba_t.wsba001,   #營運據點
       wsba002          LIKE wsba_t.wsba002,   #單據性質
       wsba003          LIKE wsba_t.wsba003,   #單據組合Key
       wsba004          LIKE wsba_t.wsba004,   #BPM簽核流程代號
       wsba005          LIKE wsba_t.wsba005,   #BPM簽核流程序號
       wsba006          LIKE wsba_t.wsba006,   #簽核時間
       wsba007          LIKE wsba_t.wsba007,   #簽核狀態
       wsba008          LIKE wsba_t.wsba008    #簽核意見
       END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_wsba_d            DYNAMIC ARRAY OF type_g_wsba_d
DEFINE g_wsba_d_t          type_g_wsba_d
DEFINE g_wsba2_d     DYNAMIC ARRAY OF type_g_wsba2_d
DEFINE g_wsba2_d_t   type_g_wsba2_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="awsq011.main" >}
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
   CALL cl_ap_init("aws","")
 
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
   DECLARE awsq011_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE awsq011_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE awsq011_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_awsq011 WITH FORM cl_ap_formpath("aws",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL awsq011_init()   
 
      #進入選單 Menu (="N")
      CALL awsq011_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_awsq011
      
   END IF 
   
   CLOSE awsq011_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="awsq011.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION awsq011_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   #初始化SCC
   CALL cl_set_combo_scc('wsba_t.wsba007','248')
   CALL cl_set_combo_scc('b_wsba007','248')
   CALL cl_set_combo_scc('b_wsbd004','249')
   #end add-point
 
   CALL awsq011_default_search()
END FUNCTION
 
{</section>}
 
{<section id="awsq011.default_search" >}
PRIVATE FUNCTION awsq011_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " wsba001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " wsba002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " wsba003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " wsba005 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " wsba007 = '", g_argv[05], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION awsq011_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"

   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"

   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"

   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"

   #end add-point
 
   
   CALL awsq011_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_wsba_d.clear()
         CALL g_wsba2_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL awsq011_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON wsba003,wsba005,wsba001,wsba002,wsba007 

         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            
         ON ACTION controlp INFIELD wsba001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_wsae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO wsba001  #顯示到畫面上
            
            NEXT FIELD wsba001                     #返回原欄位
         
         ON ACTION controlp INFIELD wsba002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_wsaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO wsba002  #顯示到畫面上
            
            NEXT FIELD wsba002
         

         END CONSTRUCT
         
         
         #end add-point
     
         DISPLAY ARRAY g_wsba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               
               CALL awsq011_detail_action_trans()
 
               LET g_master_idx = l_ac
               #DISPLAY "l_ac: ", l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL awsq011_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
         DISPLAY ARRAY g_wsba2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
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
            CALL awsq011_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"

            #end add-point
            NEXT FIELD wsba003
            
         ON ACTION query_detail
            LET g_action_choice="query_detail"
            CALL awsq011_bpm_status()
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"

            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            #CALL awsq011_detail_fill()
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            IF l_ac = 0 OR g_detail_idx = 0 THEN
               LET g_detail_idx = 1
               LET l_ac = g_detail_idx
            END IF
            CALL awsq011_b_fill()
            IF l_ac = 0 OR g_detail_idx = 0 THEN
               LET g_detail_idx = 1
               LET l_ac = g_detail_idx
            END IF
            CALL awsq011_b_fill2()
            
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_wsba_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_wsba2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL awsq011_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL awsq011_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL awsq011_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL awsq011_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL awsq011_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL awsq011_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG
 
         
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
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
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"

            #end add-point
                 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION awsq011_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"

   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_start         LIKE type_t.num10
   DEFINE l_idx           LIKE type_t.num10
   DEFINE l_end           LIKE type_t.num10
   DEFINE l_docno         LIKE wsba_t.wsba003
   DEFINE l_str           STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_buf           base.StringBuffer
   DEFINE l_tmp           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   DISPLAY g_wc
   #end add-point
 
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET l_start = g_wc.getIndexOf("wsba003=", 1)
   LET l_end   = 0   
   LET l_cnt   = 0
   IF l_start > 0 THEN
      #取得單號位置(LIKE條件內)
      FOR l_idx = l_start + 6 TO g_wc.getLength()
         IF g_wc.subString(l_idx,l_idx) == "'" THEN
            LET l_cnt = l_cnt + 1
            IF l_cnt == 2 THEN
               LET l_end = l_idx - 1
               EXIT FOR
            END IF
         END IF
      END FOR
      LET l_docno = g_wc.subString(l_start + 9,l_end)
      
      #取得wsba003後g_wc條件
      LET l_tmp = g_wc.subString(l_end + 2, g_wc.getLength()) 
      
      #替換為wsba003 LIKE條件
      LET l_str = "wsba003 LIKE '%", l_docno, "%'", l_tmp
      DISPLAY l_str      
      LET g_wc = l_str
     
   END IF      
           
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_wsba_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"

   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT wsba001,wsba002,wsba003,wsba005,wsba006,wsba007,wsba004,wsba008  ,DENSE_RANK() OVER( ORDER BY wsba_t.wsba001, 
       wsba_t.wsba002,wsba_t.wsba003,wsba_t.wsba006) AS RANK FROM wsba_t",
                     " WHERE 1=1 AND ", ls_wc
   {IF NOT cl_null(docno) THEN
      IF docno = "%" THEN
         LET ls_sql_rank = ls_sql_rank, "AND 1=1"
      ELSE
         LET ls_sql_rank = ls_sql_rank, "AND wsba003 LIKE '%", docno, "%'"
      END IF
   END IF}
                     
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("wsba_t"),
                     #"ORDER BY wsba_t.wsba001,wsba_t.wsba002,wsba_t.wsba003,"
                     "ORDER BY  wsba_t.wsba006"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #LET docno = ""
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
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
 
   LET g_sql = "SELECT wsba001,wsba002,wsba003,wsba005,wsba006,wsba007,wsba004,wsba008",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE awsq011_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR awsq011_pb
 
   OPEN b_fill_curs
 
   FOREACH b_fill_curs INTO g_wsba_d[l_ac].wsba001,g_wsba_d[l_ac].wsba002,g_wsba_d[l_ac].wsba003,g_wsba_d[l_ac].wsba005, 
       g_wsba_d[l_ac].wsba006,g_wsba_d[l_ac].wsba007,g_wsba_d[l_ac].wsba004,g_wsba_d[l_ac].wsba008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #格式化時間
      LET l_buf = base.StringBuffer.create()
      CALL l_buf.append(g_wsba_d[l_ac].wsba006)
      LET l_tmp = l_buf.toString()
      LET l_tmp = l_tmp.subString(1,4), "-", l_tmp.subString(5,6), "-", 
                  l_tmp.subString(7,8), " ", l_tmp.subString(9,10), ":", 
                  l_tmp.subString(11,12), ":", l_tmp.subString(13,14)
      LET g_wsba_d[l_ac].wsba006 = l_tmp
      LET l_tmp = ""
      #end add-point
 
      CALL awsq011_detail_show("'1'")
 
      CALL awsq011_wsba_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:3)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"

   #end add-point
 
   CALL g_wsba_d.deleteElement(g_wsba_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"

   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_wsba_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE awsq011_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL awsq011_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL awsq011_detail_action_trans()
 
   LET l_ac = 1
   IF g_wsba_d.getLength() > 0 THEN
      CALL awsq011_b_fill2()
   END IF
 
      CALL awsq011_filter_show('wsba001','b_wsba001')
   CALL awsq011_filter_show('wsba002','b_wsba002')
   CALL awsq011_filter_show('wsba003','b_wsba003')
   CALL awsq011_filter_show('wsba007','b_wsba007')
   CALL awsq011_filter_show('wsba006','b_wsba006')
   CALL awsq011_filter_show('wsba004','b_wsba004')
   CALL awsq011_filter_show('wsba005','b_wsba005')
   CALL awsq011_filter_show('wsba008','b_wsba008')
   CALL awsq011_filter_show('wsbd001','b_wsbd001')
   CALL awsq011_filter_show('wsbd003','b_wsbd003')
   CALL awsq011_filter_show('wsbd004','b_wsbd004')
   CALL awsq011_filter_show('wsbd005','b_wsbd005')
   CALL awsq011_filter_show('wsbd007','b_wsbd007')
 
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION awsq011_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"

   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   DEFINE l_buf           base.StringBuffer
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_tmp           STRING
   DEFINE l_tmp2          STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"

   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:6)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_wsba2_d.clear()
   DISPLAY "g_detail_idx: ", g_detail_idx
   DISPLAY "g_detail_idx2: ",g_detail_idx2
   #add-point:陣列清空 name="b_fill2.array_clear"

   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   #IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE wsbd001,wsbd003,'',wsbd004,wsbd005,wsbd006,wsbd007 FROM wsbd_t",
                  " WHERE wsbdent = ", g_enterprise
      LET g_sql = g_sql, " AND wsbd001 LIKE '%", g_wsba_d[g_detail_idx].wsba003, "%'"
      
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY wsbd_t.wsbd007"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"

      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE awsq011_pb2   FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR awsq011_pb2
   #END IF
 
   OPEN b_fill_curs2 
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_wsba2_d[l_ac].wsbd001,g_wsba2_d[l_ac].wsbd003,g_wsba2_d[l_ac].wsbd003_desc, 
       g_wsba2_d[l_ac].wsbd004,g_wsba2_d[l_ac].wsbd005,wsbd_tmp[l_ac].wsbd006,g_wsba2_d[l_ac].wsbd007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
       
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      #格式化時間
      LET l_buf = base.StringBuffer.create()
      CALL l_buf.append(wsbd_tmp[l_ac].wsbd006)
      CALL l_buf.replace("/" ,"-",0)
      LET l_tmp = l_buf.toString()
      LET l_tmp2 = g_wsba2_d[l_ac].wsbd007
      LET l_tmp2 = l_tmp2.subString(1,8)
      LET l_tmp = l_tmp," ", l_tmp2
      LET g_wsba2_d[l_ac].wsbd007 = l_tmp
      LET l_tmp = ""
      LET l_tmp2 = ""
      #end add-point
 
      CALL awsq011_detail_show("'2'")
 
      CALL awsq011_wsbd_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_wsba2_d.deleteElement(g_wsba2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"

   #end add-point
 
#Page2
   LET li_ac = g_wsba2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"

   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION awsq011_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_wsba2_d[l_ac].wsbd003
            LET ls_sql = "SELECT ooag011 FROM ooag_t ",
                         " WHERE ooag001 =  ",
                         "(SELECT ooap001 FROM ooap_t WHERE ooapent = '"||g_enterprise||"'",
                         "    AND ooap002 = ?) AND ooagent = '"||g_enterprise||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_wsba2_d[l_ac].wsbd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_wsba2_d[l_ac].wsbd003_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION awsq011_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"

   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"

   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"

   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON wsba001,wsba002,wsba003,wsba005,wsba006,wsba007,wsba004,wsba008
                          FROM s_detail1[1].b_wsba001,s_detail1[1].b_wsba002,s_detail1[1].b_wsba003, 
                              s_detail1[1].b_wsba005,s_detail1[1].b_wsba006,s_detail1[1].b_wsba007,s_detail1[1].b_wsba004,s_detail1[1].b_wsba008
 
 
         BEFORE CONSTRUCT
                     DISPLAY awsq011_filter_parser('wsba001') TO s_detail1[1].b_wsba001
            DISPLAY awsq011_filter_parser('wsba002') TO s_detail1[1].b_wsba002
            DISPLAY awsq011_filter_parser('wsba003') TO s_detail1[1].b_wsba003
            DISPLAY awsq011_filter_parser('wsba007') TO s_detail1[1].b_wsba007
            DISPLAY awsq011_filter_parser('wsba006') TO s_detail1[1].b_wsba006
            DISPLAY awsq011_filter_parser('wsba004') TO s_detail1[1].b_wsba004
            DISPLAY awsq011_filter_parser('wsba005') TO s_detail1[1].b_wsba005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_wsba001>>----
         #Ctrlp:construct.c.filter.page1.b_wsba001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba001
            #add-point:ON ACTION controlp INFIELD b_wsba001 name="construct.c.filter.page1.b_wsba001"

            #END add-point
 
 
         #----<<b_wsba002>>----
         #Ctrlp:construct.c.filter.page1.b_wsba002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba002
            #add-point:ON ACTION controlp INFIELD b_wsba002 name="construct.c.filter.page1.b_wsba002"

            #END add-point
 
 
         #----<<b_wsba003>>----
         #Ctrlp:construct.c.filter.page1.b_wsba003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba003
            #add-point:ON ACTION controlp INFIELD b_wsba003 name="construct.c.filter.page1.b_wsba003"

            #END add-point
 
 
         #----<<b_wsba007>>----
         #Ctrlp:construct.c.filter.page1.b_wsba007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba007
            #add-point:ON ACTION controlp INFIELD b_wsba007 name="construct.c.filter.page1.b_wsba007"

            #END add-point
 
 
         #----<<b_wsba006>>----
         #Ctrlp:construct.c.filter.page1.b_wsba006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba006
            #add-point:ON ACTION controlp INFIELD b_wsba006 name="construct.c.filter.page1.b_wsba006"

            #END add-point
 
 
         #----<<b_wsba004>>----
         #Ctrlp:construct.c.filter.page1.b_wsba004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba004
            #add-point:ON ACTION controlp INFIELD b_wsba004 name="construct.c.filter.page1.b_wsba004"

            #END add-point
 
 
         #----<<b_wsba005>>----
         #Ctrlp:construct.c.filter.page1.b_wsba005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_wsba005
            #add-point:ON ACTION controlp INFIELD b_wsba005 name="construct.c.filter.page1.b_wsba005"

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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"

   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL awsq011_filter_show('wsba001','b_wsba001')
   CALL awsq011_filter_show('wsba002','b_wsba002')
   CALL awsq011_filter_show('wsba003','b_wsba003')
   CALL awsq011_filter_show('wsba007','b_wsba007')
   CALL awsq011_filter_show('wsba006','b_wsba006')
   CALL awsq011_filter_show('wsba004','b_wsba004')
   CALL awsq011_filter_show('wsba005','b_wsba005')
   CALL awsq011_filter_show('wsba008','b_wsba008')
   CALL awsq011_filter_show('wsbd001','b_wsbd001')
   CALL awsq011_filter_show('wsbd003','b_wsbd003')
   CALL awsq011_filter_show('wsbd004','b_wsbd004')
   CALL awsq011_filter_show('wsbd005','b_wsbd005')
   CALL awsq011_filter_show('wsbd007','b_wsbd007')
 
 
   CALL awsq011_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="awsq011.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION awsq011_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="awsq011.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION awsq011_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = awsq011_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="awsq011.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION awsq011_detail_action_trans()
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
 
{<section id="awsq011.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION awsq011_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
            IF g_wsba_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_wsba_d.getLength() AND g_wsba_d.getLength() > 0
            LET g_detail_idx = g_wsba_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_wsba_d.getLength() THEN
               LET g_detail_idx = g_wsba_d.getLength()
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
 
{<section id="awsq011.mask_functions" >}
 &include "erp/aws/awsq011_mask.4gl"
 
{</section>}
 
{<section id="awsq011.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢BPM流程狀況
# Memo...........:
# Usage..........: CALL awsq011_bpm_status()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq011_bpm_status()
DEFINE l_dzag002       LIKE dzag_t.dzag002
DEFINE l_tmp           STRING
DEFINE l_start         INTEGER
   
   WHENEVER ERROR CALL cl_err_msg_log

   CALL cl_bpm_data_init()
   LET l_ac = g_detail_idx
   LET g_docno = ""
   
   #取得程式主要資料表代碼
   LET l_tmp = g_wsba_d[l_ac].wsba003
   LET l_tmp = l_tmp.subString(1,4)
   LET l_dzag002 = l_tmp, "_t"
   IF cl_null(l_dzag002) OR NOT l_dzag002 LIKE "%_t" THEN
      RETURN #FALSE
   END IF

   #取得單據編號
   LET l_tmp = g_wsba_d[l_ac].wsba003
   LET l_start = l_tmp.getIndexOF("docno",1)
   LET l_tmp = l_tmp.subString(l_start + 6, l_tmp.getLength())
   LET g_docno = l_tmp
   DISPLAY "g_docno: ",g_docno
   IF cl_null(g_docno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN #FALSE
   END IF

   IF NOT awsq011_bpm_process_info_get(l_dzag002) THEN
      RETURN #FALSE
   END IF

   #RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 執行『查詢流程狀態』功能
# Memo...........:
# Usage..........: CALL awsq011_bpm_process_info_get(p_dzeb001)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq011_bpm_process_info_get(p_dzeb001)
   DEFINE p_dzeb001              LIKE dzeb_t.dzeb001   #資料表代碼   
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode           #Request XML Node
   DEFINE l_tag                  STRING                #節點tag名稱
   DEFINE l_attr                 type_g_attribute      #節點屬性資料
   DEFINE l_node                 xml.DomNode
   DEFINE l_request_doc          xml.DomDocument       #傳送的單據資料內容
   DEFINE l_request_content      xml.DomNode
   DEFINE l_request              xml.DomNode
   DEFINE l_response_content     xml.DomNode
   DEFINE l_node_list            xml.DomNodeList
   DEFINE l_child_node           xml.DomNode
   DEFINE l_url                  STRING                #BPM簽核流程檢視網址
   DEFINE l_response_content_str STRING
   #DEFINE l_wsab                 type_g_wsab
   DEFINE l_slip                 LIKE ooba_t.ooba002   #單別
   DEFINE l_doc_key              LIKE wsba_t.wsba003   #單據組合Key
   DEFINE l_wsba                 type_g_wsba
   DEFINE l_wsab002              LIKE wsab_t.wsab002   #參照表編號 
   DEFINE l_processSN            LIKE wsba_t.wsba005   #BPM流程序號
   DEFINE l_success              LIKE type_t.chr1
   DEFINE l_str                  STRING
   DEFINE l_file                 STRING
   DEFINE l_oobx003              LIKE oobx_t.oobx003   #單據性質
   DEFINE l_bpm_url              LIKE ooaa_t.ooaa002
   DEFINE l_site                 LIKE wsba_t.wsba001
   DEFINE l_status               LIKE wsba_t.wsba007

   INITIALIZE l_request_root TO NULL
   INITIALIZE l_node TO NULL
   INITIALIZE l_request_content TO NULL
   INITIALIZE l_request TO NULL
   
   
   #INITIALIZE l_wsab TO NULL

   #取得單別
   CALL cl_getslip_get_slip(g_docno) RETURNING l_success, l_slip                 
   IF NOT l_success THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00036" #取得單據別編號失敗
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()   
      RETURN FALSE 
   END IF

   LET l_doc_key = ""
  
   #取得單據狀態碼
   LET l_status = g_wsba_d[l_ac].wsba007
   
   #取得單據性質 todo:需再確認取單據性質方法(一個單別會對應到一個單據性質)
   LET l_oobx003 = g_wsba_d[l_ac].wsba002

   #取得營運據點
   LET l_site = g_wsba_d[l_ac].wsba001
   
   #由營運據點抓取aooi100單據別參照表號
   CALL s_aooi100_sel_ooef004(l_site) RETURNING l_success,l_wsab002
   IF NOT l_success THEN
      RETURN l_success
   END IF
         
   #建立 Request XML Document
   CALL cl_bpm_create_request_head("ProcessInfoGet")
      RETURNING l_req_doc, l_request_root

   #建立datakey (p_doc_key:參數對於『查看流程狀況』功能來說一定是用組的)
   CALL awsq011_bpm_create_data_key(l_req_doc, l_request_root, l_slip, p_dzeb001, l_wsab002, l_oobx003)
      RETURNING l_req_doc, l_doc_key

   IF l_req_doc IS NULL THEN
      RETURN FALSE
   END IF

   #先取得[工作流序號]
   #取得發起時間最後一筆工作流序號
   #SELECT wsbb005 INTO l_processSN FROM wsbb_t
   #  WHERE wsbb001 = l_site
   #    AND wsbb002 = l_oobx003
   #    AND wsbb003 = l_doc_key
   #    AND wsbb007 = (SELECT MAX(wsbb007) FROM wsbb_t
   #                     WHERE wsbb001 = l_site
   #                       AND wsbb002 = l_oobx003
   #                       AND wsbb003 = l_doc_key)
      
   #IF SQLCA.sqlcode AND SQLCA.sqlcode <> 100 THEN
      # CALL cl_err("sel wsbb_t error!", SQLCA.sqlcode, 1)
      #RETURN FALSE
   #   LET l_str = "sel wsbb_t error!"
   #END IF

   #無法取得[工作流序號]時,則取得該單據編號的[BPM簽核流程序號]
   IF cl_null(l_processSN) THEN
      #取得簽核時間最後一筆簽核流序號
      
      SELECT wsba005 INTO l_processSN FROM wsba_t
        WHERE wsba001 = l_site
          AND wsba002 = l_oobx003
          AND wsba003 = l_doc_key
          AND wsba007 = l_status
          AND wsba006 = (SELECT MAX(wsba006) FROM wsba_t
                           WHERE wsba001 = l_site
                             AND wsba002 = l_oobx003
                             AND wsba003 = l_doc_key
                             AND wsba007 = l_status)
          
      IF SQLCA.sqlcode THEN
         #CALL cl_err("sel wsba_t error!", SQLCA.sqlcode, 1)
         #RETURN FALSE
         LET l_str = "sel wsba_t error!"
      END IF
   END IF

   #取得流程序號失敗
   IF cl_null(l_processSN) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00031"
      LET g_errparam.extend = l_str
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF
   
      
   #建立request真正資料內容(payload)
   CALL cl_bpm_create_payload(l_req_doc, l_request_root)
      RETURNING l_req_doc, l_request_root
      
   #建立傳送資料內容
   CALL cl_bpm_request_content_pre()
      RETURNING l_request_doc, l_request

   #建立Parameter節點
   LET l_tag = "Parameter"
   CALL l_attr.clear()
   CALL cl_bpm_create_node(l_request_doc, l_request, l_tag, l_attr)
      RETURNING l_request_doc, l_node

   #建立Record節點
   LET l_tag = "Record"
   CALL l_attr.clear()
   CALL cl_bpm_create_node(l_request_doc, l_node, l_tag, l_attr)
      RETURNING l_request_doc, l_node

   #建立Field節點(BPM 流程序號)
   LET l_tag = "Field"
   CALL l_attr.clear()
    
   LET l_attr[1].name = "name"
   LET l_attr[1].value = "processSN"

   LET l_attr[2].name = "value"
   LET l_attr[2].value = l_processSN
   
   CALL cl_bpm_create_node(l_request_doc, l_node, l_tag, l_attr)
      RETURNING l_request_doc, l_node

   #建立Document節點
   LET l_tag = "Document"
   CALL l_attr.clear()
   CALL cl_bpm_create_node(l_request_doc, l_request, l_tag, l_attr)
      RETURNING l_request_doc, l_node
      
   LET l_request_content = l_req_doc.createCDataSection(l_request_doc.saveToString())
   CALL l_request_root.appendChild(l_request_content)
   
   CALL l_req_doc.setFeature("format-pretty-print", true)   
   
   LET l_file = os.Path.join(FGL_GETENV("TEMPDIR"), "myfile.xml")   
   CALL l_req_doc.save(l_file)

   #呼叫 BPM 服務
   CALL cl_bpm_api_call(l_req_doc.saveToString())
      RETURNING l_response_content_str

   IF cl_null(l_response_content_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aws-00106"
      LET g_errparam.extend = g_bpm_err
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF 
 
   #取得BPM 處理的回傳資料本體
   CALL awsq011_bpm_get_response(l_response_content_str)
      RETURNING l_response_content
   
   IF g_ws_code <> 0 OR g_ws_sqlcode <> 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00029"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  g_ws_code CLIPPED 
      LET g_errparam.replace[2] =  g_ws_description CLIPPED
      CALL cl_err()

      RETURN FALSE
   END IF
   
   IF l_response_content IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "aws-00106"
      LET g_errparam.extend = g_bpm_err
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN FALSE
   END IF

   
   
    #取得URL資料
    LET l_node_list = l_response_content.selectByXPath("//Parameter/Record/Field[@name=\"url\"]","")
    IF l_node_list.getCount() > 0 THEN
        LET l_child_node = l_node_list.getitem(1)
        LET l_url = l_child_node.getAttribute("value")
        LET l_bpm_url = cl_aws_prod_para(g_enterprise,"bpm-0002")
        LET l_url = l_bpm_url , l_url
        DISPLAY "URL:", l_url        
        CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [] )
    END IF      

    RETURN TRUE
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
PRIVATE FUNCTION awsq011_bpm_get_response(p_response_str)
   DEFINE p_response_str         STRING   
   DEFINE l_res_doc              xml.DomDocument
   DEFINE l_tag                  STRING             #節點tag名稱   
   DEFINE l_response_cdata       STRING
   DEFINE l_bpm_response         xml.DomDocument
   DEFINE l_node_list            xml.DomNodeList
   DEFINE l_record_node          xml.DomNode
   DEFINE l_child_node           xml.DomNode
   DEFINE l_name                 STRING
   DEFINE l_processSN            STRING
   DEFINE l_status               STRING
   DEFINE l_response_content     xml.DomNode

   INITIALIZE l_response_content TO NULL
   
   #建立 Response XML Document
   LET l_res_doc = xml.DomDocument.create()
   CALL l_res_doc.loadFromString(p_response_str)

   #response字串轉換成XML格式失敗
   IF l_res_doc IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00023"
      LET g_errparam.extend = "Response"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #Response isn't valid XML document
      RETURN l_response_content
   END IF
   
   
   #取得服務執行結果狀態代碼 (<srvcode>)
   LET l_tag = "srvcode"
   LET g_srvcode = cl_bpm_get_node_value(l_res_doc, l_tag)

   #服務執行結果狀態代碼
   IF g_srvcode <> "000" THEN 
      DISPLAY "srvcode:", g_srvcode
      #RETURN l_response_content
   END IF

   #取得bpm response處理姞果(CDATA section 包覆的 XML 資料)                 
   LET l_tag = "param"
   LET l_response_cdata = cl_bpm_get_node_value(l_res_doc, l_tag)
   #DISPLAY "response:", l_response_cdata, ";"

   #建立 BPM Request XML Document
   LET l_bpm_response = xml.DomDocument.create()
   CALL l_bpm_response.loadFromString(l_response_cdata)

   #取得bpm處理結果
   LET l_tag = "Status"
   LET g_ws_code = cl_bpm_get_node_attribute(l_bpm_response, l_tag , "code")
   LET g_ws_sqlcode = cl_bpm_get_node_attribute(l_bpm_response, l_tag , "sqlcode")
   LET g_ws_description = cl_bpm_get_node_attribute(l_bpm_response, l_tag , "description")
   #DISPLAY "ws code:", g_ws_code, "; "
   #DISPLAY "ws sqlcode:", g_ws_sqlcode, "; "
   #DISPLAY "ws description:", g_ws_description, ";"

   IF g_ws_code <> 0 OR g_ws_sqlcode <> 0 THEN
      RETURN l_response_content
   END IF

   #取得ResponseContent(bpm response本文)
   LET l_tag = "ResponseContent"
   LET l_node_list = l_bpm_response.getElementsByTagName(l_tag.trim())
   LET l_response_content = l_node_list.getitem(1)

   RETURN l_response_content
END FUNCTION

################################################################################
# Descriptions...: 建立datakey
# Memo...........:
# Usage..........: CALL awsq011_bpm_create_data_key
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq011_bpm_create_data_key(p_req_doc,p_node,p_slip,p_dzeb001,p_wsab002,p_oobx003)
   DEFINE p_req_doc              xml.DomDocument       #XML Document
   DEFINE p_node                 xml.DomNode           #要增加子節點的node
   DEFINE p_slip                 STRING                #單別
   DEFINE p_dzeb001              LIKE dzeb_t.dzeb001   #資料表代碼
   DEFINE p_wsab002              LIKE wsab_t.wsab002   #參照表編號
   DEFINE p_oobx003              LIKE oobx_t.oobx003   #單據性質
   
   DEFINE l_child_node           xml.DomNode
   DEFINE l_key_node             xml.DomNode
   DEFINE l_doc_key              STRING
   DEFINE l_site                 LIKE wsba_t.wsba001               

   LET l_doc_key = ""
   LET l_site = g_wsba_d[l_ac].wsba001

   #<datakey type="FOM"(opt.)>
   LET l_child_node = p_req_doc.createElement("datakey")    #建立 <datakey>
   CALL p_node.appendChild(l_child_node)
   CALL l_child_node.setAttribute("type", "FOM")

   #<datakey>下建立子節點
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "EntId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(g_enterprise))
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "CompanyId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(l_site))

   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "RefId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_wsab002))
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "DocProp")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_oobx003))

   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "Prog")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(g_wsba_d[l_ac].wsba002))

   #設定單別
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "FormId")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(p_slip))

   #設定單據編號
   IF cl_null(g_docno) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00025"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE p_req_doc TO NULL
      RETURN p_req_doc, l_doc_key
   END IF
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "SheetNo")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(g_docno))

   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "PK3")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(""))

   #設定單據的組合key:依資料表代碼(dzeb001)取得PK欄位
   #IF NOT cl_null(p_dzeb001) THEN
   #   LET l_doc_key = awsq011_bpm_get_pk_field(p_dzeb001, "1")
   #END IF
   LET l_doc_key = g_wsba_d[l_ac].wsba003

   IF cl_null(l_doc_key) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00030"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE p_req_doc TO NULL
      RETURN p_req_doc, l_doc_key
   END IF
   
   LET l_key_node = l_child_node.appendChildElement("key")
   CALL l_key_node.setAttribute("name", "DocKey")
   CALL l_key_node.appendChild(p_req_doc.createTextNode(l_doc_key.trim()))

   RETURN p_req_doc, l_doc_key
END FUNCTION

################################################################################
# Descriptions...: 取得單據pk欄位的key, value組合(ex:單號)
# Memo...........:
# Usage..........: CALL awsq011_bpm_get_pk_field(p_dzeb001,p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq011_bpm_get_pk_field(p_dzeb001,p_type)
   DEFINE p_dzeb001        LIKE dzeb_t.dzeb001
   DEFINE p_type           LIKE type_t.chr1
   
   DEFINE l_sql            STRING
   DEFINE l_dzeb002        LIKE dzeb_t.dzeb002
   DEFINE l_gztd003        LIKE gztd_t.gztd003   #資料型態
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_value          STRING                #PK欄位的值
   DEFINE l_pk_key         STRING                #單據pk欄位的key/value組合
   DEFINE l_data_type      STRING                #欄位型態
   
   LET l_pk_key = ""
   
   #取得資料表的PK欄位   
   LET l_sql = "SELECT dzeb021, dzeb002, gztd003 FROM dzeb_t", 
               "  LEFT JOIN gztd_t ON dzeb006 = gztd001 ",
               "  WHERE dzeb001 = ? ",
               "    AND dzeb004 = 'Y' ",
               "  ORDER BY dzeb021"
   
   DECLARE bpm_get_pk_field_cs CURSOR FROM l_sql
   FOREACH bpm_get_pk_field_cs USING p_dzeb001 INTO l_i, l_dzeb002, l_gztd003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH bpm_get_pk_field_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         LET l_pk_key = ""
         RETURN l_pk_key
      END IF

      #取得欄位值
      CALL cl_bpm_get_field_value(l_dzeb002)
         RETURNING l_value
      IF l_dzeb002 LIKE '%docno%' THEN
         LET l_value = g_docno
      END IF

      IF cl_null(l_value) THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "lib-00022"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_dzeb002 CLIPPED
         CALL cl_err()

         LET l_pk_key = ""
         RETURN l_pk_key
      END IF

      CASE p_type
         WHEN "1"   #單據的組合key(XML [DocKey] tag資料)
            IF cl_null(l_pk_key) THEN
               LET l_pk_key = l_dzeb002 CLIPPED, "=", l_value.trim()
            ELSE
               LET l_pk_key = l_pk_key, "{+}", l_dzeb002 CLIPPED, "=", l_value.trim()
            END IF

         WHEN "2"   #SQL statement的where條件式
            LET l_data_type = l_gztd003 CLIPPED
            
            CASE l_data_type.toUpperCase()
               WHEN "NUMBER"
                  LET l_value = l_value.trim()

               OTHERWISE
                  LET l_value = "'", l_value.trim(), "'"
            END CASE

            IF cl_null(l_pk_key) THEN
               LET l_pk_key = l_dzeb002 CLIPPED, " = ", l_value.trim(), " "
            ELSE
               LET l_pk_key = l_pk_key, " AND ", l_dzeb002 CLIPPED, " = ", l_value.trim(), " "
            END IF
         
         WHEN "3"   #URL裡單據資料的參數值
            IF l_dzeb002 MATCHES "*ent" THEN
               CONTINUE FOREACH
            END IF
            
            IF cl_null(l_pk_key) THEN
               LET l_pk_key = l_value.trim()
            ELSE
               LET l_pk_key = l_pk_key, "|", l_value.trim()
            END IF
            
         WHEN "5"   
            IF cl_null(l_pk_key) THEN
               LET l_pk_key = l_dzeb002
            ELSE
               LET l_pk_key = l_pk_key, "|",l_dzeb002
            END IF
      END CASE
      
   END FOREACH

   RETURN l_pk_key
END FUNCTION

################################################################################
# Descriptions...: 取得單據性質
# Memo...........:
# Usage..........: CALL awsq011_bpm_get_docprop(p_slip)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsq011_bpm_get_docprop(p_slip)
   DEFINE p_slip                 LIKE ooba_t.ooba002   #單別
   
   DEFINE l_oobx003              LIKE oobx_t.oobx003   #單據性質
   DEFINE r_success              LIKE type_t.chr1
   DEFINE l_prog                 LIKE wsba_t.wsba002
   
   LET l_oobx003 = ""
   LET r_success = TRUE
   LET l_prog = g_wsba_d[l_ac].wsba002
   
   SELECT wsaa001 INTO l_oobx003 FROM wsaa_t  WHERE wsaa001 = l_prog

   IF NOT cl_null(l_oobx003) THEN
      RETURN r_success, l_oobx003
   END IF
   
   #取得單據性質 todo:需再確認取單據性質方法(一個單別會對應到一個單據性質)
   SELECT oobx003 INTO l_oobx003 FROM oobx_t
     WHERE oobxent = g_enterprise
       AND oobx001 = p_slip
       AND oobx004 = l_prog
       AND oobxstus = 'Y'
   
   IF cl_null(l_oobx003) THEN
      SELECT gzzz006 INTO l_oobx003 FROM gzzz_t  #單據性質
       WHERE gzzz001 = l_prog 
   END IF
   
   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      LET l_oobx003 = ""
   END IF
   
   RETURN r_success,l_oobx003
END FUNCTION

 
{</section>}
 
