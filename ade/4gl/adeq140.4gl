#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq140.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-11-15 20:20:14), PR版次:0001(2016-11-21 11:05:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: adeq140
#+ Description: 門店會員折扣、積點、轉儲統計查詢作業
#+ Creator....: 02749(2016-11-14 18:13:02)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="adeq140.global" >}
#應用 q01 樣板自動產生(Version:34)
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
PRIVATE TYPE type_g_rtja_d RECORD
       
       sel LIKE type_t.chr1, 
   rtjasite LIKE rtja_t.rtjasite, 
   rtjasite_desc LIKE type_t.chr500, 
   l_discount LIKE type_t.num20_6, 
   l_discount_y LIKE type_t.num20_6, 
   l_point LIKE type_t.num15_3, 
   l_point_y LIKE type_t.num15_3, 
   l_txn_point LIKE type_t.num15_3, 
   l_txn_point_y LIKE type_t.num15_3, 
   l_gift_value LIKE type_t.num20_6, 
   l_gift_value_y LIKE type_t.num20_6, 
   l_gift_point LIKE type_t.num15_3, 
   l_gift_point_y LIKE type_t.num15_3, 
   l_gift_price LIKE type_t.num20_6, 
   l_gift_price_y LIKE type_t.num20_6, 
   l_add_price LIKE type_t.num20_6, 
   l_add_price_y LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master RECORD
          l_date_s    LIKE type_t.dat,
          l_date_e    LIKE type_t.dat
                END RECORD

DEFINE g_master_t RECORD
          l_date_s    LIKE type_t.dat,
          l_date_e    LIKE type_t.dat
                END RECORD

DEFINE g_requery      LIKE type_t.num5    #是否重新查詢(判斷是否重新取得統計資料來源)
DEFINE g_date_y       LIKE type_t.dat     #年至今起始日期
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtja_d            DYNAMIC ARRAY OF type_g_rtja_d
DEFINE g_rtja_d_t          type_g_rtja_d
 
 
 
 
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
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="adeq140.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success      LIKE type_t.num5
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
   DECLARE adeq140_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq140_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq140_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq140 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq140_init()   
 
      #進入選單 Menu (="N")
      CALL adeq140_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq140
      
   END IF 
   
   CLOSE adeq140_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   LET l_success = ''
   CALL s_aooi500_drop_temp() RETURNING l_success
   
   DROP TABLE adeq140_tmp_01
   DROP TABLE adeq140_tmp_02   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq140.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq140_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   LET l_success = ''
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq140_create_tmp()
   #end add-point
 
   CALL adeq140_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq140.default_search" >}
PRIVATE FUNCTION adeq140_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjadocno = '", g_argv[01], "' AND "
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
 
{<section id="adeq140.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq140_ui_dialog() 
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
 
   
   CALL adeq140_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtja_d.clear()
 
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
 
         CALL adeq140_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.l_date_s,g_master.l_date_e ATTRIBUTE(WITHOUT DEFAULTS)

            #避免操作不便,將判斷控制點置於此
            AFTER INPUT
               IF NOT cl_null(g_master.l_date_s) AND NOT cl_null(g_master.l_date_e) THEN
                   IF g_master.l_date_s > g_master.l_date_e THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ""
                      LET g_errparam.code   = "ade-00177"
                      LET g_errparam.popup  = TRUE
                      CALL cl_err()

                      NEXT FIELD l_date_s
                   END IF
               END IF

         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtjasite
            ON ACTION controlp INFIELD rtjasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')

               CALL q_ooef001_24()

               DISPLAY g_qryparam.return1 TO rtjasite
               NEXT FIELD rtjasite               
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_rtja_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq140_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq140_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq140_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL adeq140_set_act_no_visible()
            LET g_requery = FALSE
            INITIALIZE  g_master.* TO NULL
            INITIALIZE  g_master_t.* TO NULL
            
            LET g_master.l_date_s = s_date_get_first_date(g_today)
            LET g_master.l_date_e = g_today
            
            DISPLAY g_master.l_date_s TO l_date_s
            DISPLAY g_master.l_date_e TO l_date_e
            
            LET g_master_t.* = g_master.*
            #end add-point
            NEXT FIELD rtjasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* = g_master.*
            LET g_wc_t = g_wc
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
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            IF NOT cl_null(g_master.l_date_s) AND NOT cl_null(g_master.l_date_e) THEN
                IF g_master.l_date_s > g_master.l_date_e THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = ""
                   LET g_errparam.code   = "ade-00177"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err() 
             
                   NEXT FIELD l_date_s
                END IF
            END IF
            
            IF   g_master.l_date_s <> g_master_t.l_date_s
              OR g_master.l_date_e <> g_master_t.l_date_e
              OR g_wc <> g_wc_t OR cl_null(g_wc_t) THEN
               LET g_requery = TRUE

               CALL DIALOG.setCurrentRow("s_detail1", 1)
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adeq140_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtja_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq140_b_fill()
 
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
            CALL adeq140_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq140_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq140_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq140_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq140_filter()
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
 
{<section id="adeq140.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq140_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_requery THEN
      CALL adeq140_ins_tmp()
      LET g_requery = FALSE
   ELSE
      RETURN
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_rtja_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',rtjasite,'','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY rtja_t.rtjadocno) AS RANK FROM rtja_t", 
 
 
 
                     "",
                     " WHERE rtjaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtja_t"),
                     " ORDER BY rtja_t.rtjadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT ooef001, ",                        #門店編號
                     "       (SELECT ooefl003 FROM ooefl_t ",   #門店名稱
                     "         WHERE ooeflent = ",g_enterprise,
                     "           AND ooefl001 = ooef001 AND ooefl002 = '",g_dlang,"') ooef001_desc, ",
                     "       (SELECT COALESCE(SUM(COALESCE(deca036,0)),0) FROM deca_t ",   #本期會員折扣金額
                     "         WHERE decaent = ooefent AND decasite = ooef001 ",
                     "           AND deca002 >= '",g_master.l_date_s,"' AND deca002 <= '",g_master.l_date_e,"' ",
                     "           AND deca035 IS NOT NULL) discount, ",
                     "       (SELECT COALESCE(SUM(COALESCE(deca036,0)),0) FROM deca_t ",   #年至今會員折扣金額
                     "         WHERE decaent = ooefent AND decasite = ooef001 ",
                     "           AND deca002 >= '",g_date_y,"' AND deca002 <= '",g_master.l_date_e,"' ",
                     "           AND deca035 IS NOT NULL) discount_y, ",                     
                     "       COALESCE(point,0) point, ",                                   #本期送出積點
                     "       COALESCE(point_y,0) point_y, ",                               #年至今送出積點
                     "       (SELECT COALESCE(SUM(COALESCE(rtja047,0)),0) FROM rtja_t ",   #本期兌換積點
                     "         WHERE rtjaent = ooefent AND rtjasite = ooef001 ",
                     "           AND rtja000 = 'ammt450' AND rtjastus <> 'X' ",
                     "           AND rtja001 IS NOT NULL ",
                     "           AND rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') txn_point, ",
                     "       (SELECT COALESCE(SUM(COALESCE(rtja047,0)),0) FROM rtja_t ",   #年至今兌換積點
                     "         WHERE rtjaent = ooefent AND rtjasite = ooef001 ",
                     "           AND rtja000 = 'ammt450' AND rtjastus <> 'X' ",
                     "           AND rtja001 IS NOT NULL ",
                     "           AND rtjadocdt >= '",g_date_y,"' AND rtjadocdt <= '",g_master.l_date_e,"') txn_point_y, ",
                     "       COALESCE(gift_value,0)   gift_value,   ",   #本期轉儲金額       
                     "       COALESCE(gift_value_y,0) gift_value_y, ",   #年至今轉儲金額
                     "       COALESCE(gift_point,0)   gift_point,   ",   #本期換贈積點       
                     "       COALESCE(gift_point_y,0) gift_point_y, ",   #年至今換贈積點
                     "       COALESCE(gift_price,0)   gift_price,   ",   #本期換贈品金額     
                     "       COALESCE(gift_price_y,0) gift_price_y, ",   #年至今換贈品金額
                     "       COALESCE(add_price,0)    add_price,    ",   #本期換贈加價金額  
                     "       COALESCE(add_price_y,0)  add_price_y,  ",   #年至今換贈加價金額
                     "       DENSE_RANK() OVER( ORDER BY ooef001) AS RANK ",
                     "  FROM (SELECT ooefent,ooef001, ",
                     "               SUM(CASE WHEN amt_flag = 'Y' THEN rtja016 ELSE 0 END) point, ",           #本期送出積點
                     "               SUM(rtja016) point_y, ",                                                  #年至今送出積點
                     "               SUM(CASE WHEN amt_flag = 'Y' THEN gift_value ELSE 0 END) gift_value, ",   #本期轉儲金額
                     "               SUM(gift_value) gift_value_y, ",                                          #年至今轉儲金額
                     "               SUM(CASE WHEN amt_flag = 'Y' THEN gift_point ELSE 0 END) gift_point, ",   #本期換贈積點
                     "               SUM(gift_point) gift_point_y, ",                                          #年至今換贈積點
                     "               SUM(CASE WHEN amt_flag = 'Y' THEN gift_price ELSE 0 END) gift_price, ",   #本期換贈品金額
                     "               SUM(gift_price) gift_price_y, ",                                          #年至今換贈品金額
                     "               SUM(CASE WHEN amt_flag = 'Y' THEN add_price ELSE 0 END) add_price, ",     #本期換贈加價金額
                     "               SUM(add_price) add_price_y ",                                            #年至今換贈加價金額                     "               
                     "          FROM adeq140_tmp_01 LEFT JOIN adeq140_tmp_02 ON ooef001 = rtjasite ",
                     "         WHERE ooefent = ? ",
                     "           AND ",g_wc_filter,
                     "         GROUP BY ooefent,ooef001 ) ",
                     " ORDER BY ooef001 "
  #DISPLAY "[ls_sql_rank] ",ls_sql_rank                  
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '',rtjasite,'','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT '' sel, ",
               "       ooef001, ",        #門店編號
               "       ooef001_desc, ",   #門店名稱
               "       discount, ",       #本期會員折扣金額
               "       discount_y, ",     #年至今會員折扣金額               
               "       point, ",          #本期送出積點
               "       point_y, ",        #年至今送出積點
               "       txn_point, ",      #本期兌換積點
               "       txn_point_y, ",    #年至今兌換積點
               "       gift_value, ",     #本期轉儲金額       
               "       gift_value_y, ",   #年至今轉儲金額
               "       gift_point, ",     #本期換贈積點       
               "       gift_point_y, ",   #年至今換贈積點
               "       gift_price, ",     #本期換贈品金額     
               "       gift_price_y, ",   #年至今換贈品金額
               "       add_price, ",      #本期換贈加價金額  
               "       add_price_y ",     #年至今換贈加價金額
               "  FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               "   AND RANK < ",g_pagestart + g_num_in_page
  #DISPLAY "[adeq140_pb] ",g_sql            
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq140_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq140_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtja_d[l_ac].sel,g_rtja_d[l_ac].rtjasite,g_rtja_d[l_ac].rtjasite_desc, 
       g_rtja_d[l_ac].l_discount,g_rtja_d[l_ac].l_discount_y,g_rtja_d[l_ac].l_point,g_rtja_d[l_ac].l_point_y, 
       g_rtja_d[l_ac].l_txn_point,g_rtja_d[l_ac].l_txn_point_y,g_rtja_d[l_ac].l_gift_value,g_rtja_d[l_ac].l_gift_value_y, 
       g_rtja_d[l_ac].l_gift_point,g_rtja_d[l_ac].l_gift_point_y,g_rtja_d[l_ac].l_gift_price,g_rtja_d[l_ac].l_gift_price_y, 
       g_rtja_d[l_ac].l_add_price,g_rtja_d[l_ac].l_add_price_y
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL adeq140_detail_show("'1'")
 
      CALL adeq140_rtja_t_mask()
 
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
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_rtja_d.deleteElement(g_rtja_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq140_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq140_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq140_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtja_d.getLength() > 0 THEN
      CALL adeq140_b_fill2()
   END IF
 
      CALL adeq140_filter_show('rtjasite','b_rtjasite')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq140.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq140_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="adeq140.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq140_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_rtja_d[l_ac].rtjasite
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_rtja_d[l_ac].rtjasite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_rtja_d[l_ac].rtjasite_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq140.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq140_filter()
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
      CONSTRUCT g_wc_filter ON rtjasite
                          FROM s_detail1[1].b_rtjasite
 
         BEFORE CONSTRUCT
                     DISPLAY adeq140_filter_parser('rtjasite') TO s_detail1[1].b_rtjasite
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjasite
            #add-point:ON ACTION controlp INFIELD b_rtjasite name="construct.c.filter.page1.b_rtjasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooed004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjasite  #顯示到畫面上
            NEXT FIELD b_rtjasite                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_rtjasite_desc>>----
         #----<<l_discount>>----
         #----<<l_discount_y>>----
         #----<<l_point>>----
         #----<<l_point_y>>----
         #----<<l_txn_point>>----
         #----<<l_txn_point_y>>----
         #----<<l_gift_value>>----
         #----<<l_gift_value_y>>----
         #----<<l_gift_point>>----
         #----<<l_gift_point_y>>----
         #----<<l_gift_price>>----
         #----<<l_gift_price_y>>----
         #----<<l_add_price>>----
         #----<<l_add_price_y>>----
 
 
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
 
      CALL adeq140_filter_show('rtjasite','b_rtjasite')
 
 
   CALL adeq140_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq140.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq140_filter_parser(ps_field)
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
 
{<section id="adeq140.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq140_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq140_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq140.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq140_detail_action_trans()
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
 
{<section id="adeq140.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq140_detail_index_setting()
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
            IF g_rtja_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtja_d.getLength() AND g_rtja_d.getLength() > 0
            LET g_detail_idx = g_rtja_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtja_d.getLength() THEN
               LET g_detail_idx = g_rtja_d.getLength()
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
 
{<section id="adeq140.mask_functions" >}
 &include "erp/ade/adeq140_mask.4gl"
 
{</section>}
 
{<section id="adeq140.other_function" readonly="Y" >}

################################################################################
# Descriptions...: ACTION功能失效設定
# Memo...........:
# Usage..........: CALL adeq140_set_act_no_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/11/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq140_set_act_no_visible()
   CALL cl_set_act_visible("sel,unsel,selall,selnone",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 建立暫存檔
# Memo...........:
# Usage..........: CALL adeq140_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/11/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq140_create_tmp()
   DEFINE l_session_id       LIKE type_t.num20

   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id

   #統計門店
   DROP TABLE adeq140_tmp_01
   
   CREATE TEMP TABLE adeq140_tmp_01(
      ooefent      LIKE ooef_t.ooefent,   #企業編號
      ooef001      LIKE ooef_t.ooef001)   #組織編號
      
   #統計資料
   DROP TABLE adeq140_tmp_02

   CREATE TEMP TABLE adeq140_tmp_02(
      rtjasite     LIKE rtja_t.rtjasite,    #門店編號
      rtja016      LIKE rtja_t.rtja016,     #送出積點
      gift_value   LIKE rtja_t.rtja031,     #積點轉儲金額
      gift_point   LIKE rtjb_t.rtjb029,     #換贈積點
      gift_price   LIKE rtdx_t.rtdx016,     #換贈品金額
      add_price    LIKE rtjb_t.rtjb021,     #換贈加價金額
      amt_flag     LIKE type_t.chr10)       #本期統計範圍否
      
END FUNCTION

################################################################################
# Descriptions...: 取得統計資料
# Memo...........:
# Usage..........: CALL adeq140_ins_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/11/14 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq140_ins_tmp()
   DEFINE l_ins_sql    STRING
   DEFINE l_sour_sql   STRING
   DEFINE l_sql        STRING
   DEFINE l_where      STRING
   DEFINE l_year       LIKE type_t.num5
   DEFINE l_date       STRING
   
   DELETE FROM adeq140_tmp_01
   DELETE FROM adeq140_tmp_02
   
   LET l_year = YEAR(g_master.l_date_e)
   LET l_date = l_year,"/1/1"   #組出截止日所屬年度的1/1日
   LET g_date_y = l_date   
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   
   #組織資料:須依aooi500管控過濾
   LET l_where = ''
   CALL s_aooi500_sql_where(g_prog,'rtjasite') RETURNING l_where
   IF cl_null(l_where) THEN
      LET l_where = " 1=1 "
   END IF
   
   LET l_where = cl_replace_str(l_where,"rtjasite","ooef001")
   
   LET l_sql = "INSERT INTO adeq140_tmp_01(ooefent,ooef001) ",
               "SELECT ooefent,ooef001 ",
               "  FROM ooef_t ",
               " WHERE ooefent = ",g_enterprise,
               "   AND ",l_where
   PREPARE adeq140_ins_tmp1 FROM l_sql
   EXECUTE adeq140_ins_tmp1    
   
   #統計資料:按單據匯總
   LET l_ins_sql = "INSERT INTO adeq140_tmp_02( rtjasite,   rtja016, ",
                   "                            gift_value, gift_point, gift_price, add_price,  amt_flag) "
   #銷售資料:銷售-銷退
   LET l_sour_sql = "SELECT rtjasite, ",
                    "       SUM(rtja016), ",     #送出積點
                    "       SUM(gift_value), ",  #積點轉儲金額
                    "       SUM(gift_point), ",  #換贈積點
                    "       SUM(gift_price), ",  #換贈品金額
                    "       SUM(add_price), ",   #換贈加價金額
                    "       amt_flag ",          #本期統計範圍否                
                    "  FROM (SELECT rtjasite, ",
                    "               (CASE WHEN rtja000 = 'artt700' THEN COALESCE(rtja016,0)*-1 ELSE COALESCE(rtja016,0) END) rtja016, ",   #送出積點
                    "               0 gift_value, ",  #積點轉儲金額
                    "               0 gift_point, ",  #換贈積點
                    "               0 gift_price, ",  #換贈品金額
                    "               0 add_price , ",  #換贈加價金額
                    "               (CASE WHEN (rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') THEN 'Y' END) amt_flag ",   #本期統計範圍否                
                    "          FROM rtja_t ",
                    "         WHERE rtjaent = ",g_enterprise,
                    "         AND rtja000 IN ('artt600','artt610','artt700') ",
                    "           AND rtja001 IS NOT NULL ",
                    "           AND rtjastus <> 'X' ",
                    "           AND ((rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') ",
                    "             OR (rtjadocdt >= '",g_date_y,"' AND rtjadocdt <= '",g_master.l_date_e,"')) ",
                    "           AND ",g_wc,
                    " ) ",
                    " GROUP BY rtjasite,amt_flag "
    
   LET l_sql = l_ins_sql,l_sour_sql
   PREPARE adeq140_ins_tmp2_pre1 FROM l_sql
   EXECUTE adeq140_ins_tmp2_pre1
  #DISPLAY "[adeq140_ins_tmp2_pre1] ",l_sql

   #換贈資料  
   LET l_sour_sql = "SELECT rtjasite, ",
                    "       0 rtja016, ",         #送出積點
                    "       SUM(gift_value), ",   #積點轉儲金額
                    "       SUM(gift_point), ",   #換贈積點
                    "       SUM(gift_price), ",   #換贈品金額
                    "       SUM(add_price) , ",   #換贈加價金額
                    "       amt_flag ",           #本期統計範圍否                
                    "  FROM (SELECT rtjasite, ",
                    "               (CASE WHEN mmfe012 = 'P' THEN COALESCE(mmfe008,0) ELSE 0 END) gift_value, ",                          #積點轉儲金額
                    "               (CASE WHEN imaa004 <> 'E' ",                                                                           #換贈積點
                    "                        THEN (SELECT COALESCE(rtja047, 0) FROM rtja_t WHERE rtjaent = rtjbent AND rtjadocno = rtjbdocno) ",
                    "                     ELSE 0 END) gift_point, ",                        
                    "               (CASE WHEN imaa004 <> 'E' THEN COALESCE(rtdx016,0) * COALESCE(mmfe008,0) ELSE 0 END) gift_price, ",   #換贈品金額
                    "               (CASE WHEN imaa004 <> 'E' THEN COALESCE(mmfe009,0) ELSE 0 END) add_price , ",                         #換贈加價金額
                    "               amt_flag ",   #本期統計範圍否                
                    "          FROM mmfe_t, ",
                    "               (SELECT rtjbent,rtjbdocno,rtjbseq,rtjb004, ",
                    "                       rtjasite, rtjadocdt, ",
                    "                       (CASE WHEN (rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') THEN 'Y' END) amt_flag, ",   #本期統計範圍否 
                    "                       (SELECT rtdx016 FROM rtdx_t ",
                    "                         WHERE rtdxent = rtjbent AND rtdxsite = rtjbsite AND rtdx001 = rtjb004) rtdx016, ",
                    "                       (SELECT imaa004 FROM imaa_t ",
                    "                         WHERE imaaent = rtjbent AND imaa001 = rtjb004) imaa004 ",
                    "                  FROM rtjb_t,rtja_t ",
                    "                 WHERE rtjbent = rtjaent AND rtjbdocno = rtjadocno ",
                    "                   AND rtjaent = ",g_enterprise,
                    "                   AND rtja000 = 'ammt450' ",
                    "                   AND rtja001 IS NOT NULL ",
                    "                   AND rtjastus <> 'X' ",
                    "                   AND ((rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') ",
                    "                     OR (rtjadocdt >= '",g_date_y,"' AND rtjadocdt <= '",g_master.l_date_e,"')) ",
                    "               ) ",
                    "         WHERE mmfeent = rtjbent AND mmfedocno = rtjbdocno AND mmfeseq = rtjbseq ",
                    "           AND ",g_wc,
                    "        ) ",
                    " GROUP BY rtjasite,amt_flag "                    
                    
   LET l_sql = l_ins_sql,l_sour_sql
   PREPARE adeq140_ins_tmp2_pre2 FROM l_sql
   EXECUTE adeq140_ins_tmp2_pre2    
   DISPLAY "[adeq140_ins_tmp2_pre2] ",l_sql
END FUNCTION

 
{</section>}
 