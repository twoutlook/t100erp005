#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq710.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-07-08 18:29:14), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: azzq710
#+ Description: 訊息追蹤查詢
#+ Creator....: 01856(2015-07-08 18:29:14)
#+ Modifier...: 01856 -SD/PR- 00000
 
{</section>}
 
{<section id="azzq710.global" >}
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
PRIVATE TYPE type_g_lokg_d RECORD
       
       sel LIKE type_t.chr1, 
   lokg013 LIKE lokg_t.lokg013, 
   lokg014 LIKE lokg_t.lokg014, 
   lokg021 LIKE lokg_t.lokg021, 
   lokg015 LIKE lokg_t.lokg015, 
   lokg005 LIKE lokg_t.lokg005, 
   lokg002 LIKE lokg_t.lokg002, 
   lokg003 LIKE lokg_t.lokg003, 
   lokg003_desc LIKE type_t.chr500, 
   lokg012 LIKE lokg_t.lokg012, 
   lokg016 LIKE lokg_t.lokg016, 
   lokg001 LIKE lokg_t.lokg001, 
   lokg009 LIKE lokg_t.lokg009, 
   lokg006 LIKE lokg_t.lokg006, 
   lokg019 LIKE lokg_t.lokg019, 
   lokg020 LIKE lokg_t.lokg020, 
   lokg017 LIKE lokg_t.lokg017, 
   lokg018 LIKE lokg_t.lokg018, 
   lokg010 LIKE lokg_t.lokg010
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm        RECORD
                      rdg_1     LIKE type_t.chr1                      
                 END RECORD  
DEFINE tm2   RECORD
               rdg_2     LIKE type_t.chr1,
               bdate     LIKE type_t.dat,
               edate     LIKE type_t.dat
             END RECORD     
#end add-point
 
#模組變數(Module Variables)
DEFINE g_lokg_d            DYNAMIC ARRAY OF type_g_lokg_d
DEFINE g_lokg_d_t          type_g_lokg_d
 
 
 
 
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
 
{<section id="azzq710.main" >}
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
   DECLARE azzq710_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzq710_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq710_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq710 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzq710_init()   
 
      #進入選單 Menu (="N")
      CALL azzq710_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzq710
      
   END IF 
   
   CLOSE azzq710_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzq710.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzq710_init()
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
   CALL cl_set_combo_scc('lokg_t.lokg013','180')   
   CALL cl_set_combo_scc('b_lokg013','180')   
   CALL cl_set_combo_scc('lokg_t.lokg014','181')   
   CALL cl_set_combo_scc('b_lokg014','181')   
   CALL cl_set_combo_scc('b_lokg021','183')  
   CALL cl_set_combo_scc('lokg_t.lokg021','183')     
   #end add-point
 
   CALL azzq710_default_search()
END FUNCTION
 
{</section>}
 
{<section id="azzq710.default_search" >}
PRIVATE FUNCTION azzq710_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " lokg001 = '", g_argv[01], "' AND "
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
 
{<section id="azzq710.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzq710_ui_dialog() 
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
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE li_result     BOOLEAN
                
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
   LET tm.rdg_1 = '1'
   
   LET tm2.rdg_2 = '1'
   LET tm2.bdate = ''
   LET tm2.edate = ''   
  
   #end add-point
 
   
   CALL azzq710_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_lokg_d.clear()
 
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
 
         CALL azzq710_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT BY NAME g_wc ON lokg013,lokg014,lokg021,lokg005,lokg012 #,lokg003
            BEFORE CONSTRUCT
               
             
               
#               #部門主管
#               SELECT COUNT(*) INTO l_cnt FROM gzkh_t WHERE gzkh002 = g_user
#               IF l_cnt > 0 THEN                 
#                  CALL cl_set_comp_visible("group_2", TRUE)
#               ELSE
#                  CALL cl_set_comp_visible("group_2", FALSE)
#               END IF
#               
#               IF g_user = '00544' THEN
#                  CALL cl_set_comp_visible("group_2", TRUE)
#               END IF
               
         END CONSTRUCT
         
         INPUT BY NAME tm.rdg_1 ATTRIBUTE(WITHOUT DEFAULTS)
           
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT
         
         INPUT BY NAME tm2.rdg_2,tm2.bdate,tm2.edate ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               CALL azzq710_set_no_entry()
               CALL azzq710_set_entry()               
              
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
               
            ON CHANGE rdg_2
               CALL azzq710_set_no_entry()
               CALL azzq710_set_entry()
               IF tm2.rdg_2 != '6' THEN
                  LET tm2.bdate = ''
                  LET tm2.edate = ''
                  DISPLAY BY NAME tm2.bdate,tm2.edate
               END IF
               
            AFTER FIELD bdate               
               
            AFTER FIELD edate
              
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_lokg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL azzq710_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL azzq710_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               IF cl_null(g_lokg_d[l_ac].lokg006) THEN
                  CALL cl_set_act_visible("msg_content", FALSE)
               ELSE               
                  CALL cl_set_act_visible("msg_content", TRUE)
               END IF
               CALL azzq710_detail_show("1")
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
            CALL azzq710_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert", FALSE)
            CALL cl_set_act_visible("sel,unsel,selall,selnone", FALSE)    
            CALL cl_set_act_visible("msg_content", FALSE)
            #預設查詢條件
            DISPLAY '1','N',g_user TO lokg013,lokg021,lokg003            
            #end add-point
            NEXT FIELD lokg013
 
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
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL azzq710_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_lokg_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL azzq710_b_fill()
 
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
            CALL azzq710_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL azzq710_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL azzq710_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL azzq710_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_lokg_d.getLength()
               LET g_lokg_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_lokg_d.getLength()
               LET g_lokg_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_lokg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_lokg_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_lokg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_lokg_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL azzq710_filter()
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
         ON ACTION msg_content
            LET g_action_choice="msg_content"
            IF cl_auth_chk_act("msg_content") THEN
               
               #add-point:ON ACTION msg_content name="menu.msg_content"
               IF NOT cl_null(g_lokg_d[l_ac].lokg006) THEN
                  CALL ui.Interface.frontCall("standard", "launchurl", g_lokg_d[l_ac].lokg006, li_result)   
               END IF
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
 
{<section id="azzq710.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzq710_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ooag001       LIKE ooag_t.ooag001 
   DEFINE l_ooag003       LIKE ooag_t.ooag003
   DEFINE ls_wc2          STRING
   DEFINE ls_wc_t         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF NOT cl_null(tm2.bdate) AND NOT cl_null(tm2.edate) THEN
      IF tm2.bdate > tm2.edate THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ''
         LET g_errparam.code   = 'acr-00068'     #起始日期不能大於截止日期！   
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         RETURN
      END IF
   END IF
   #查詢部門資料
   LET ls_wc2 = ""
   LET ls_wc_t = g_wc
   
   IF tm.rdg_1 = '2'  THEN
       SELECT ooag003 INTO l_ooag003 FROM ooag_t WHERE ooag001 = g_user
       IF NOT cl_null(l_ooag003) THEN
          LET ls_wc2 = " OR lokg003 in (SELECT ooag001 FROM ooag_t WHERE ooag003 = '" , l_ooag003 , "')"          
       END IF
   END IF
   
   IF cl_null(ls_wc2) THEN
      LET g_wc = g_wc , " AND lokg003 = '", g_user ,"'"
   ELSE
      LET g_wc = g_wc , " AND (lokg003 = '", g_user ,"' "  ,ls_wc2 , ")"
   END IF
   
   #查詢日期範圍
   IF NOT cl_null(tm2.rdg_2) THEN      
      LET g_wc2 = azzq710_query_time(tm2.rdg_2)
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
 
   CALL g_lokg_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',lokg013,lokg014,lokg021,lokg015,lokg005,lokg002,lokg003,'',lokg012, 
       lokg016,lokg001,lokg009,lokg006,lokg019,lokg020,lokg017,lokg018,lokg010  ,DENSE_RANK() OVER( ORDER BY lokg_t.lokg001) AS RANK FROM lokg_t", 
 
 
 
                     "",
                     " WHERE lokgent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("lokg_t"),
                     " ORDER BY lokg_t.lokg001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
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
 
   LET g_sql = "SELECT '',lokg013,lokg014,lokg021,lokg015,lokg005,lokg002,lokg003,'',lokg012,lokg016, 
       lokg001,lokg009,lokg006,lokg019,lokg020,lokg017,lokg018,lokg010",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzq710_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzq710_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_lokg_d[l_ac].sel,g_lokg_d[l_ac].lokg013,g_lokg_d[l_ac].lokg014,g_lokg_d[l_ac].lokg021, 
       g_lokg_d[l_ac].lokg015,g_lokg_d[l_ac].lokg005,g_lokg_d[l_ac].lokg002,g_lokg_d[l_ac].lokg003,g_lokg_d[l_ac].lokg003_desc, 
       g_lokg_d[l_ac].lokg012,g_lokg_d[l_ac].lokg016,g_lokg_d[l_ac].lokg001,g_lokg_d[l_ac].lokg009,g_lokg_d[l_ac].lokg006, 
       g_lokg_d[l_ac].lokg019,g_lokg_d[l_ac].lokg020,g_lokg_d[l_ac].lokg017,g_lokg_d[l_ac].lokg018,g_lokg_d[l_ac].lokg010 
 
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
 
      CALL azzq710_detail_show("'1'")
 
      CALL azzq710_lokg_t_mask()
 
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
 
   CALL g_lokg_d.deleteElement(g_lokg_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF g_lokg_d.getLength() = 0 THEN
      CALL cl_set_act_visible("msg_content", FALSE)
   ELSE
      CALL cl_set_act_visible("msg_content", TRUE)
   END IF
   
   LET g_wc = ls_wc_t    #還原 g_wc
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_lokg_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE azzq710_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL azzq710_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL azzq710_detail_action_trans()
 
   LET l_ac = 1
   IF g_lokg_d.getLength() > 0 THEN
      CALL azzq710_b_fill2()
   END IF
 
      CALL azzq710_filter_show('lokg013','b_lokg013')
   CALL azzq710_filter_show('lokg014','b_lokg014')
   CALL azzq710_filter_show('lokg021','b_lokg021')
   CALL azzq710_filter_show('lokg015','b_lokg015')
   CALL azzq710_filter_show('lokg005','b_lokg005')
   CALL azzq710_filter_show('lokg002','b_lokg002')
   CALL azzq710_filter_show('lokg003','b_lokg003')
   CALL azzq710_filter_show('lokg012','b_lokg012')
   CALL azzq710_filter_show('lokg016','b_lokg016')
   CALL azzq710_filter_show('lokg001','b_lokg001')
   CALL azzq710_filter_show('lokg009','b_lokg009')
   CALL azzq710_filter_show('lokg006','b_lokg006')
   CALL azzq710_filter_show('lokg019','b_lokg019')
   CALL azzq710_filter_show('lokg020','b_lokg020')
   CALL azzq710_filter_show('lokg017','b_lokg017')
   CALL azzq710_filter_show('lokg018','b_lokg018')
   CALL azzq710_filter_show('lokg010','b_lokg010')
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzq710.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzq710_b_fill2()
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
 
{<section id="azzq710.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzq710_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   DISPLAY g_lokg_d[l_ac].lokg017 TO s_lokg017
   DISPLAY g_lokg_d[l_ac].lokg018 TO s_lokg018
   DISPLAY g_lokg_d[l_ac].lokg019 TO s_lokg019
   DISPLAY g_lokg_d[l_ac].lokg020 TO s_lokg020
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_lokg_d[l_ac].lokg003
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_lokg_d[l_ac].lokg003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_lokg_d[l_ac].lokg003_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq710.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION azzq710_filter()
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
      CONSTRUCT g_wc_filter ON lokg013,lokg014,lokg021,lokg015,lokg005,lokg002,lokg003,lokg012,lokg016, 
          lokg001,lokg009,lokg006,lokg019,lokg020,lokg017,lokg018,lokg010
                          FROM s_detail1[1].b_lokg013,s_detail1[1].b_lokg014,s_detail1[1].b_lokg021, 
                              s_detail1[1].b_lokg015,s_detail1[1].b_lokg005,s_detail1[1].b_lokg002,s_detail1[1].b_lokg003, 
                              s_detail1[1].b_lokg012,s_detail1[1].b_lokg016,s_detail1[1].b_lokg001,s_detail1[1].b_lokg009, 
                              s_detail1[1].b_lokg006,s_detail1[1].b_lokg019,s_detail1[1].b_lokg020,s_detail1[1].b_lokg017, 
                              s_detail1[1].b_lokg018,s_detail1[1].b_lokg010
 
         BEFORE CONSTRUCT
                     DISPLAY azzq710_filter_parser('lokg013') TO s_detail1[1].b_lokg013
            DISPLAY azzq710_filter_parser('lokg014') TO s_detail1[1].b_lokg014
            DISPLAY azzq710_filter_parser('lokg021') TO s_detail1[1].b_lokg021
            DISPLAY azzq710_filter_parser('lokg015') TO s_detail1[1].b_lokg015
            DISPLAY azzq710_filter_parser('lokg005') TO s_detail1[1].b_lokg005
            DISPLAY azzq710_filter_parser('lokg002') TO s_detail1[1].b_lokg002
            DISPLAY azzq710_filter_parser('lokg003') TO s_detail1[1].b_lokg003
            DISPLAY azzq710_filter_parser('lokg012') TO s_detail1[1].b_lokg012
            DISPLAY azzq710_filter_parser('lokg016') TO s_detail1[1].b_lokg016
            DISPLAY azzq710_filter_parser('lokg001') TO s_detail1[1].b_lokg001
            DISPLAY azzq710_filter_parser('lokg009') TO s_detail1[1].b_lokg009
            DISPLAY azzq710_filter_parser('lokg006') TO s_detail1[1].b_lokg006
            DISPLAY azzq710_filter_parser('lokg019') TO s_detail1[1].b_lokg019
            DISPLAY azzq710_filter_parser('lokg020') TO s_detail1[1].b_lokg020
            DISPLAY azzq710_filter_parser('lokg017') TO s_detail1[1].b_lokg017
            DISPLAY azzq710_filter_parser('lokg018') TO s_detail1[1].b_lokg018
            DISPLAY azzq710_filter_parser('lokg010') TO s_detail1[1].b_lokg010
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_lokg013>>----
         #Ctrlp:construct.c.filter.page1.b_lokg013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg013
            #add-point:ON ACTION controlp INFIELD b_lokg013 name="construct.c.filter.page1.b_lokg013"
            
            #END add-point
 
 
         #----<<b_lokg014>>----
         #Ctrlp:construct.c.filter.page1.b_lokg014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg014
            #add-point:ON ACTION controlp INFIELD b_lokg014 name="construct.c.filter.page1.b_lokg014"
            
            #END add-point
 
 
         #----<<b_lokg021>>----
         #Ctrlp:construct.c.filter.page1.b_lokg021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg021
            #add-point:ON ACTION controlp INFIELD b_lokg021 name="construct.c.filter.page1.b_lokg021"
            
            #END add-point
 
 
         #----<<b_lokg015>>----
         #Ctrlp:construct.c.filter.page1.b_lokg015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg015
            #add-point:ON ACTION controlp INFIELD b_lokg015 name="construct.c.filter.page1.b_lokg015"
            
            #END add-point
 
 
         #----<<b_lokg005>>----
         #Ctrlp:construct.c.filter.page1.b_lokg005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg005
            #add-point:ON ACTION controlp INFIELD b_lokg005 name="construct.c.filter.page1.b_lokg005"
            
            #END add-point
 
 
         #----<<b_lokg002>>----
         #Ctrlp:construct.c.filter.page1.b_lokg002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg002
            #add-point:ON ACTION controlp INFIELD b_lokg002 name="construct.c.filter.page1.b_lokg002"
            
            #END add-point
 
 
         #----<<b_lokg003>>----
         #Ctrlp:construct.c.filter.page1.b_lokg003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg003
            #add-point:ON ACTION controlp INFIELD b_lokg003 name="construct.c.filter.page1.b_lokg003"
            
            #END add-point
 
 
         #----<<b_lokg003_desc>>----
         #----<<b_lokg012>>----
         #Ctrlp:construct.c.filter.page1.b_lokg012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg012
            #add-point:ON ACTION controlp INFIELD b_lokg012 name="construct.c.filter.page1.b_lokg012"
            
            #END add-point
 
 
         #----<<b_lokg016>>----
         #Ctrlp:construct.c.filter.page1.b_lokg016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg016
            #add-point:ON ACTION controlp INFIELD b_lokg016 name="construct.c.filter.page1.b_lokg016"
            
            #END add-point
 
 
         #----<<b_lokg001>>----
         #Ctrlp:construct.c.filter.page1.b_lokg001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg001
            #add-point:ON ACTION controlp INFIELD b_lokg001 name="construct.c.filter.page1.b_lokg001"
            
            #END add-point
 
 
         #----<<b_lokg009>>----
         #Ctrlp:construct.c.filter.page1.b_lokg009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg009
            #add-point:ON ACTION controlp INFIELD b_lokg009 name="construct.c.filter.page1.b_lokg009"
            
            #END add-point
 
 
         #----<<b_lokg006>>----
         #Ctrlp:construct.c.filter.page1.b_lokg006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg006
            #add-point:ON ACTION controlp INFIELD b_lokg006 name="construct.c.filter.page1.b_lokg006"
            
            #END add-point
 
 
         #----<<b_lokg019>>----
         #Ctrlp:construct.c.filter.page1.b_lokg019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg019
            #add-point:ON ACTION controlp INFIELD b_lokg019 name="construct.c.filter.page1.b_lokg019"
            
            #END add-point
 
 
         #----<<b_lokg020>>----
         #Ctrlp:construct.c.filter.page1.b_lokg020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg020
            #add-point:ON ACTION controlp INFIELD b_lokg020 name="construct.c.filter.page1.b_lokg020"
            
            #END add-point
 
 
         #----<<b_lokg017>>----
         #Ctrlp:construct.c.filter.page1.b_lokg017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg017
            #add-point:ON ACTION controlp INFIELD b_lokg017 name="construct.c.filter.page1.b_lokg017"
            
            #END add-point
 
 
         #----<<b_lokg018>>----
         #Ctrlp:construct.c.filter.page1.b_lokg018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg018
            #add-point:ON ACTION controlp INFIELD b_lokg018 name="construct.c.filter.page1.b_lokg018"
            
            #END add-point
 
 
         #----<<b_lokg010>>----
         #Ctrlp:construct.c.filter.page1.b_lokg010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_lokg010
            #add-point:ON ACTION controlp INFIELD b_lokg010 name="construct.c.filter.page1.b_lokg010"
            
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
 
      CALL azzq710_filter_show('lokg013','b_lokg013')
   CALL azzq710_filter_show('lokg014','b_lokg014')
   CALL azzq710_filter_show('lokg021','b_lokg021')
   CALL azzq710_filter_show('lokg015','b_lokg015')
   CALL azzq710_filter_show('lokg005','b_lokg005')
   CALL azzq710_filter_show('lokg002','b_lokg002')
   CALL azzq710_filter_show('lokg003','b_lokg003')
   CALL azzq710_filter_show('lokg012','b_lokg012')
   CALL azzq710_filter_show('lokg016','b_lokg016')
   CALL azzq710_filter_show('lokg001','b_lokg001')
   CALL azzq710_filter_show('lokg009','b_lokg009')
   CALL azzq710_filter_show('lokg006','b_lokg006')
   CALL azzq710_filter_show('lokg019','b_lokg019')
   CALL azzq710_filter_show('lokg020','b_lokg020')
   CALL azzq710_filter_show('lokg017','b_lokg017')
   CALL azzq710_filter_show('lokg018','b_lokg018')
   CALL azzq710_filter_show('lokg010','b_lokg010')
 
 
   CALL azzq710_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq710.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION azzq710_filter_parser(ps_field)
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
 
{<section id="azzq710.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION azzq710_filter_show(ps_field,ps_object)
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
   LET ls_condition = azzq710_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="azzq710.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION azzq710_detail_action_trans()
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
 
{<section id="azzq710.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION azzq710_detail_index_setting()
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
            IF g_lokg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_lokg_d.getLength() AND g_lokg_d.getLength() > 0
            LET g_detail_idx = g_lokg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_lokg_d.getLength() THEN
               LET g_detail_idx = g_lokg_d.getLength()
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
 
{<section id="azzq710.mask_functions" >}
 &include "erp/azz/azzq710_mask.4gl"
 
{</section>}
 
{<section id="azzq710.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq710_query_time(p_str)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq710_query_time(p_str)
   DEFINE p_str            STRING
   DEFINE l_sql            STRING

   DEFINE l_time_tmp       RECORD         
          bdate            DATETIME YEAR TO SECOND,      #起始日
          edate            DATETIME YEAR TO SECOND       #截止日
          END RECORD
  
   CASE p_str         
       WHEN "1"  #近一週            
          LET l_time_tmp.bdate = s_date_get_date(g_today,0,-7)          
          
       WHEN "2"  #近一個月            
          LET l_time_tmp.bdate = s_date_get_date(g_today,-1,0)          
          
       WHEN "3"  #近一季         
          LET l_time_tmp.bdate = s_date_get_date(g_today,-3,0)          
          
       WHEN "4"  #近半年             
          LET l_time_tmp.bdate = s_date_get_date(g_today,-6,0)          
          
       WHEN "5"  #近一年             
          LET l_time_tmp.bdate = s_date_get_date(g_today,-12,0)          
          
       WHEN "6"  #自訂
          LET l_time_tmp.bdate = tm2.bdate          
          
   END CASE
    
   #查詢範圍包含時間
   IF p_str = "6" THEN
      LET l_time_tmp.edate = tm2.edate + 1
   ELSE
      LET l_time_tmp.edate = g_today + 1
   END IF
   
   LET l_sql = sfmt(" lokg015 BETWEEN TO_DATE('%1','YYYY-MM-DD HH24:MI:SS') AND TO_DATE('%2','YYYY-MM-DD HH24:MI:SS') " , l_time_tmp.bdate ,l_time_tmp.edate)
   RETURN l_sql
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq710_set_entry()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq710_set_entry()
   IF tm2.rdg_2 = '6' THEN
      CALL cl_set_comp_entry('bdate,edate',TRUE)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL　azzq710_set_no_entry()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq710_set_no_entry()
   CALL cl_set_comp_entry('bdate,edate',FALSE)
END FUNCTION

 
{</section>}
 