#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq095.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-10-12 10:40:33), PR版次:0003(2016-10-12 11:36:46)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: abgq095
#+ Description: 預算完成程度查詢
#+ Creator....: 02291(2015-09-06 16:28:13)
#+ Modifier...: 05016 -SD/PR- 05016
 
{</section>}
 
{<section id="abgq095.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160404-00001#5    160407   By albireo  修正串科餘檔時年月取法
#161003-00014#9    161006   By Hans     預算值皆以正數呈現,,加二次篩選
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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       bgbd001 LIKE bgbd_t.bgbd001, 
   bgbd001_desc LIKE type_t.chr80, 
   bgbd002 LIKE bgbd_t.bgbd002, 
   bgbd003 LIKE bgbd_t.bgbd003, 
   bgbd003_desc LIKE type_t.chr80, 
   bgbd006 LIKE bgbd_t.bgbd006, 
   glaa001 LIKE type_t.chr500, 
   glaa001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       bgbd007 LIKE bgbd_t.bgbd007, 
   bgbd007_desc LIKE type_t.chr500, 
   bgbd011 LIKE bgbd_t.bgbd011, 
   bgbd034 LIKE bgbd_t.bgbd034, 
   bgbd035 LIKE bgbd_t.bgbd035, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_detail3 RECORD
       
       bgbd001 LIKE bgbd_t.bgbd001,
       bgbd006 LIKE bgbd_t.bgbd006,
       bgbd002 LIKE bgbd_t.bgbd002,
       bgbd003 LIKE bgbd_t.bgbd003
       END RECORD
 
DEFINE g_detail3            DYNAMIC ARRAY OF type_g_detail3
DEFINE g_glaald             LIKE glaa_t.glaald
DEFINE g_cs_flag            LIKE type_t.chr1  #161003-00014#9
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
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
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
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
 
{<section id="abgq095.main" >}
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
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq095_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq095_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq095_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq095 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq095_init()   
 
      #進入選單 Menu (="N")
      CALL abgq095_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq095
      
   END IF 
   
   CLOSE abgq095_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq095.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgq095_init()
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
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL abgq095_create_tmp()
   #end add-point
 
   CALL abgq095_default_search()
END FUNCTION
 
{</section>}
 
{<section id="abgq095.default_search" >}
PRIVATE FUNCTION abgq095_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
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
 
{<section id="abgq095.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq095_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   CALL abgq095_ui_dialog_1()
   RETURN
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL abgq095_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL abgq095_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgq095_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq095_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL abgq095_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD bgbd001
 
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
 
            CALL abgq095_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
            
            #end add-point
            CALL abgq095_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         
         
         
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
 
{<section id="abgq095.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION abgq095_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE abgq095_pre FROM g_sql
   DECLARE abgq095_curs SCROLL CURSOR WITH HOLD FOR abgq095_pre
   OPEN abgq095_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = " SELECT COUNT(*) FROM abgq095_tmp "
   #end add-point
   PREPARE abgq095_precount FROM g_cnt_sql
   EXECUTE abgq095_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL abgq095_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="abgq095.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION abgq095_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   CALL abgq095_fetch1(p_flag)
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_bgbd001,bgbd001_desc,b_bgbd002,b_bgbd003,bgbd003_desc,b_bgbd006,glaa001, 
          glaa001_desc
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL abgq095_show()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq095.show" >}
PRIVATE FUNCTION abgq095_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_bgbd001,bgbd001_desc,b_bgbd002,b_bgbd003,bgbd003_desc,b_bgbd006,glaa001,glaa001_desc 
 
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL abgq095_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq095.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq095_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL abgq095_b_fill1()
   RETURN
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq095_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq095_detail_action_trans()
 
   CALL abgq095_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgq095.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq095_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq095.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq095_detail_show(ps_page)
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
 
{<section id="abgq095.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION abgq095_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgq095.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq095_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
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
 
{<section id="abgq095.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq095_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="abgq095.mask_functions" >}
 &include "erp/abg/abgq095_mask.4gl"
 
{</section>}
 
{<section id="abgq095.other_function" readonly="Y" >}

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
PRIVATE FUNCTION abgq095_ui_dialog_1()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準

   #end add-point
   #add-point:ui_dialog段define-客製

   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL abgq095_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL abgq095_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落

         #end add-point
 
         #add-point:construct段落
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgq095_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq095_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL abgq095_fetch('')
 
            #add-point:ui_dialog段before dialog
            LET g_cs_flag = 'N' #161003-00014#9 
            CALL abgq095_construct()
            #161003-00014#8 ---s---
            IF g_cs_flag = 'N' THEN
               CALL abgq095_set_page()
               CALL abgq095_cs()
            END IF
            #161003-00014#8 ---e---
            CALL abgq095_fetch1('F')
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

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
 
 
            #add-point:ON ACTION accept
           #CALL abgq095_set_page()
            #end add-point
 
            CALL abgq095_cs()
         #161003-00014#8 ---s---   
         ON ACTION filter
            LET g_action_choice="filter"
            CALL abgq095_filter()
         #161003-00014#8 ---e---
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel

               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo

            #end add-point
            CALL abgq095_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq095_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq095_b_fill()

 
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION output
#            LET g_action_choice="output"
#            IF cl_auth_chk_act("output") THEN
#               
#               #add-point:ON ACTION output
#
#               #END add-point
#               
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               #清除畫面及相關資料
               CLEAR FORM
               INITIALIZE g_master.* TO NULL
               CALL g_detail.clear()
               
               LET g_wc  = " 1=2"
               LET g_wc2 = " 1=1"
               LET g_action_choice = ""
               LET g_detail_page_action = "detail_first"
               LET g_pagestart = 1
               LET g_current_row_tot = 0
               LET g_page_start_num = 1
               LET g_page_end_num = g_num_in_page
               LET g_master_row_move = "Y"
               LET g_detail_idx = 1
               LET g_detail_idx2 = 1
 
               CALL abgq095_init()
               CALL abgq095_construct()
               CALL abgq095_fetch1('F')
               #END add-point
               
               
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後
            CALL g_detail.clear()
            
            LET g_wc  = " 1=2"
            LET g_wc2 = " 1=1"
            LET g_action_choice = ""
            LET g_detail_page_action = "detail_first"
            LET g_pagestart = 1
            LET g_current_row_tot = 0
            LET g_page_start_num = 1
            LET g_page_end_num = g_num_in_page
            LET g_master_row_move = "Y"
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point 
 
      END DIALOG 
   
   END WHILE
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
PRIVATE FUNCTION abgq095_set_page()
   DEFINE li_idx      LIKE type_t.num5
   DEFINE l_sql       STRING
   
   DELETE FROM abgq095_tmp
   LET li_idx = 1
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbd001','bgbd001')
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbd006','bgbd006')
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbd002','bgbd002')
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbd003','bgbd003')
   
   
   #161003-00014#8---s---
   LET g_wc_filter= cl_replace_str(g_wc_filter,'b_bgbd007','bgbd007')
   
   IF NOT cl_null(g_wc_filter) THEN 
      CALL g_detail3.clear()      
      LET g_wc2 = g_wc2 ," AND ",g_wc_filter 
   END IF
   CALL g_detail3.clear()
   #161003-00014#8---e---   
   
   LET l_sql = " SELECT UNIQUE bgbd001,bgbd006,bgbd002,bgbd003 FROM bgbd_t ",
               "  WHERE bgbdent = ",g_enterprise,
               "    AND ",g_wc2 CLIPPED
                   
   PREPARE bgbd_page_prep FROM l_sql
   DECLARE bgbd_page_curs CURSOR FOR bgbd_page_prep
   FOREACH bgbd_page_curs INTO g_detail3[li_idx].bgbd001,g_detail3[li_idx].bgbd006,g_detail3[li_idx].bgbd002,g_detail3[li_idx].bgbd003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'bgbd_page_curs'
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      INSERT INTO abgq095_tmp VALUES(g_detail3[li_idx].bgbd001,g_detail3[li_idx].bgbd006,g_detail3[li_idx].bgbd002,g_detail3[li_idx].bgbd003)
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET li_idx=li_idx - 1
   CALL g_detail3.deleteElement(g_detail3.getLength())
   LET g_header_cnt = g_detail3.getLength()
  #LET g_rec_b = li_idx

   DISPLAY g_header_cnt TO FORMONLY.h_count
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
PRIVATE FUNCTION abgq095_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準

   #end add-point
   #add-point:fetch段define-客製

   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:2)
   #add-point:fetch段CURSOR移動
   

   #end add-point

   CASE p_flag
      WHEN 'F' LET g_current_idx = 1
      WHEN 'P' LET g_current_idx = g_current_idx - 1
      WHEN 'N' LET g_current_idx = g_current_idx + 1
      WHEN 'L' LET g_current_idx = g_row_count
      WHEN '/' LET g_current_idx = g_jump
   END CASE
   DISPLAY g_current_idx TO FORMONLY.h_index
   DISPLAY g_row_count TO FORMONLY.h_count
   CALL cl_navigator_setting( g_current_idx, g_row_count )

 
   #add-point:fetch結束前
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_master.bgbd001 = g_detail3[g_current_idx].bgbd001
   LET g_master.bgbd001_desc = s_desc_get_budget_desc(g_detail3[g_current_idx].bgbd001)
   LET g_master.bgbd006 = g_detail3[g_current_idx].bgbd006
   LET g_master.bgbd002 = g_detail3[g_current_idx].bgbd002
   LET g_master.bgbd003 = g_detail3[g_current_idx].bgbd003
   LET g_master.bgbd003_desc = s_desc_get_department_desc(g_detail3[g_current_idx].bgbd003)
   LET g_glaald = ''
   LET g_master.glaa001 = ''
   SELECT glaa001,glaald INTO g_master.glaa001,g_glaald FROM glaa_t,ooef_t
    WHERE glaaent = ooefent AND ooef017 = glaacomp 
      AND glaaent = g_enterprise AND ooef001 = g_master.bgbd003
      AND glaa014 = 'Y'
   SELECT ooail003 INTO g_master.glaa001_desc FROM ooail_t
    WHERE ooailent = g_enterprise AND ooail001 = g_master.glaa001
      AND ooail002 = g_dlang
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL abgq095_show()
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
PRIVATE FUNCTION abgq095_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE l_sql           STRING
   DEFINE l_bgbd011       LIKE bgbd_t.bgbd011
   DEFINE l_bgbd012       LIKE bgbd_t.bgbd012
   DEFINE l_bgbd034       LIKE bgbd_t.bgbd034
   DEFINE l_bgbd035       LIKE bgbd_t.bgbd035
   DEFINE l_bgaa012       LIKE bgaa_t.bgaa012
   DEFINE l_bgaa008       LIKE bgaa_t.bgaa008
   DEFINE l_glac008       LIKE glac_t.glac008
   DEFINE l_bgaa002       LIKE bgaa_t.bgaa002
   DEFINE l_glar005       LIKE glar_t.glar005
   DEFINE l_glar006       LIKE glar_t.glar006
   DEFINE l_bgam008       LIKE bgam_t.bgam008
   DEFINE l_glaa003       LIKE glaa_t.glaa003    #160404-00001#5  add
   #end add-point
   #add-point:b_fill段define-客製

   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   
   LET g_wc_filter= cl_replace_str(g_wc_filter,'b_bgbd007','bgbd007')  #161003-00014#9
   #albireo 160407 160404-00001#5 -----s
   LET l_glaa003 = NULL
   SELECT glaa003 INTO l_glaa003 FROM glaa_t,ooef_t
    WHERE glaaent = g_enterprise
      AND glaacomp = ooef017
      AND glaa014 = 'Y'
      AND ooefent = glaaent
      AND ooef001 = g_master.bgbd003
   #albireo 160407 160404-00001#5 -----e
   
   LET l_sql = " SELECT UNIQUE bgbd007,SUM(bgbd011),SUM(bgbd012),SUM(bgbd034),SUM(bgbd035) FROM bgbd_t ",
               "  WHERE bgbdent = ",g_enterprise,
               "    AND bgbd001 = '",g_master.bgbd001,"' AND bgbd006 = ",g_master.bgbd006,
               "    AND bgbd002 = '",g_master.bgbd002,"' AND bgbd003 = '",g_master.bgbd003,"'"
  IF NOT cl_null(g_wc_filter) THEN LET  l_sql = l_sql," AND ",g_wc_filter  END IF     #161003-00014#9
  LET l_sql = l_sql ," GROUP BY bgbd007 "                                             #161003-00014#9
               #"  GROUP BY bgbd007                                                   #161003-00014#9
   PREPARE b_fill_prep FROM l_sql
   DECLARE b_fill_curs CURSOR FOR b_fill_prep
  
   #end add-point
 
   #add-point:b_fill段資料填充(其他單身)
   FOREACH b_fill_curs INTO g_detail[l_ac].bgbd007,l_bgbd011,l_bgbd012,g_detail[l_ac].bgbd034,g_detail[l_ac].bgbd035
      
      IF cl_null(l_bgbd011) THEN LET l_bgbd011 = 0 END IF
      IF cl_null(l_bgbd012) THEN LET l_bgbd012 = 0 END IF
      
      SELECT bgaa012,bgaa008,bgaa002 INTO l_bgaa012,l_bgaa008,l_bgaa002 FROM bgaa_t
       WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgbd001
      
      #取借貸方向
      IF l_bgaa012 = 'Y' THEN  #agli020
         SELECT glac008 INTO l_glac008 FROM glac_t
          WHERE glacent = g_enterprise AND glac001 = l_bgaa008
            AND glac002 = g_detail[l_ac].bgbd007
         
#         #160404-00001#5  mark-----s         
#         #年度=>依預算編號+滾動期別 對應預算週期表 取得年度
#         SELECT glav002 INTO l_bgam008 FROM glav_t
#          WHERE glavent = g_enterprise AND glav001 = l_bgaa008
#         #160404-00001#5  mark-----e
         
         SELECT glacl004 INTO g_detail[l_ac].bgbd007_desc FROM glacl_t
          WHERE glaclent = g_enterprise AND glacl001 = l_bgaa008
            AND glacl002 = g_detail[l_ac].bgbd007 AND glacl003 = g_dlang
            
      ELSE  #abgi040
         SELECT bgae002 INTO l_glac008 FROM bgae_t
          WHERE bgaeent = g_enterprise AND bgae006 = l_bgaa008
            #AND bgae002 = g_detail[l_ac].bgbd007 #161003-00014#9 
            AND bgae001 = g_detail[l_ac].bgbd007  #161003-00014#9  
            
#         #160404-00001#5 mark-----s
#         #年度=>依預算編號+滾動期別 對應預算週期表 取得年度
#         SELECT bgam008 INTO l_bgam008 FROM bgam_t
#          WHERE bgament = g_enterprise AND bgam001 = l_bgaa002
#            AND bgam002 = l_bgaa008
#         #160404-00001#5 mark-----e
         
         LET g_detail[l_ac].bgbd007_desc = s_abg_bgae001_desc(l_bgaa008,g_detail[l_ac].bgbd007)
      END IF

      #160404-00001#5 -----s
      #年度=>依預算編號+滾動期別 對應預算週期表 取得年度
      SELECT bgam008 INTO l_bgam008 FROM bgam_t
       WHERE bgament = g_enterprise AND bgam001 = l_bgaa002
         AND bgam002 = l_glaa003
      #160404-00001#5 -----e
      
      #取glar_t借方，貸方金額   
      SELECT SUM(glar005),SUM(glar006) INTO l_glar005,l_glar006 FROM glar_t
       WHERE glarent = g_enterprise AND glarld = g_glaald
         AND glar001 = g_detail[l_ac].bgbd007 AND glar002 = l_bgam008
         AND glar003 = g_master.bgbd006
      IF cl_null(l_glar005) THEN LET l_glar005 = 0 END IF
      IF cl_null(l_glar006) THEN LET l_glar006 = 0 END IF
      
#      #取借貸方向
#      IF l_bgaa012 = 'Y' THEN  #agli020
#         SELECT glac008 INTO l_glac008 FROM glac_t
#          WHERE glacent = g_enterprise AND glac001 = l_bgaa008
#            AND glac002 = g_detail[l_ac].bgbd007
#      ELSE  #abgi040
#         SELECT bgae002 INTO l_glac008 FROM bgae_t
#          WHERE bgaeent = g_enterprise AND bgae006 = l_bgaa008
#            AND bgae002 = g_detail[l_ac].bgbd007
#      END IF
      #預算金額=借方金额-贷方金额（根据预算项目判断借-贷或贷-借）
      #實際完成=取 glar_t 的金額 （根据预算项目判断借-贷或贷-借）key:預算項目+年度+期別+帳套
      IF l_glac008 = '1' THEN  #借方
         LET g_detail[l_ac].bgbd011 = l_bgbd011 - l_bgbd012
         LET g_detail[l_ac].amt2 = l_glar005 - l_glar006
      ELSE   #貸方
         LET g_detail[l_ac].bgbd011 = l_bgbd012 - l_bgbd011
         LET g_detail[l_ac].amt2 = l_glar006 - l_glar005
      END IF
      
      IF cl_null(g_detail[l_ac].bgbd035) THEN LET g_detail[l_ac].bgbd035 = 0 END IF
      IF cl_null(g_detail[l_ac].bgbd034) THEN LET g_detail[l_ac].bgbd034 = 0 END IF
      #合計金額
      LET g_detail[l_ac].amt1 = g_detail[l_ac].bgbd011 + g_detail[l_ac].bgbd034 + g_detail[l_ac].bgbd035
      
      #差額=實際完成-合計金額
      LET g_detail[l_ac].amt3 = g_detail[l_ac].amt2 - g_detail[l_ac].amt1
      
      #差異率
      LET g_detail[l_ac].amt4 = g_detail[l_ac].amt3 / g_detail[l_ac].amt1
      
      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
 
  #CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整
   LET l_ac = l_ac - 1
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq095_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq095_detail_action_trans()
 
   CALL abgq095_b_fill2()
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
PRIVATE FUNCTION abgq095_create_tmp()
    WHENEVER ERROR CONTINUE
   DROP TABLE abgq095_tmp
   CREATE TEMP TABLE abgq095_tmp(
   bgbd001  VARCHAR(10),
   bgbd006  SMALLINT,
   bgbd002  VARCHAR(10), 
   bgbd003  VARCHAR(10)
   )
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
PRIVATE FUNCTION abgq095_construct()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準

   #end add-point
   #add-point:ui_dialog段define-客製

   #end add-point
 
   CLEAR FORM  
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落

         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc2 ON b_bgbd001,b_bgbd006,b_bgbd002,b_bgbd003
            BEFORE CONSTRUCT
 
            #Ctrlp:construct.c.b_bgbd001
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbd001
               #add-point:ON ACTION controlp INFIELD b_bgbd001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_bgbd001()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bgbd001 #顯示到畫面上
               LET g_qryparam.where = ""
               
               NEXT FIELD b_bgbd001                    #返回原欄位
               #END add-point
            
            #Ctrlp:construct.c.b_bgbd006
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbd006
               #add-point:ON ACTION controlp INFIELD b_bgbd006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_bgbd006()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bgbd006 #顯示到畫面上
               LET g_qryparam.where = ""
               
               NEXT FIELD b_bgbd006                    #返回原欄位
               #END add-point
            
            #Ctrlp:construct.c.b_bgbd002
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbd002
               #add-point:ON ACTION controlp INFIELD b_bgbd002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_bgbd002()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bgbd002 #顯示到畫面上
               LET g_qryparam.where = ""
               
               NEXT FIELD b_bgbd002                    #返回原欄位
               #END add-point
               
            #Ctrlp:construct.c.b_bgbd003
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbd003
               #add-point:ON ACTION controlp INFIELD b_bgbd003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_bgbd003()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bgbd003 #顯示到畫面上
               LET g_qryparam.where = ""
               
               NEXT FIELD b_bgbd003                    #返回原欄位
               #END add-point
               
            
            AFTER CONSTRUCT
               
         
         END CONSTRUCT
         #end add-point
      
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
            #add-point:ON ACTION accept
            LET g_cs_flag = 'Y' #161003-00014#9
            CALL abgq095_set_page()
            CALL abgq095_cs()
            ACCEPT DIALOG
            #end add-point
 
 
      
         #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   IF INT_FLAG THEN
      LET g_cs_flag = 'Y' #161003-00014#9
      LET INT_FLAG = 0
      RETURN
   END IF

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
PRIVATE FUNCTION abgq095_filter()
 DEFINE  ls_result   STRING
   #add-point:ui_dialog段define-標準
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = ''
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落

         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc_filter ON b_bgbd007
             BEFORE CONSTRUCT
                DISPLAY abgq095_filter_parser('bgbd001') TO s_detail3[1].b_bgbd001
                DISPLAY abgq095_filter_parser('bgbd002') TO s_detail3[1].b_bgbd002
                DISPLAY abgq095_filter_parser('bgbd003') TO s_detail3[1].b_bgbd003
                DISPLAY abgq095_filter_parser('bgbd006') TO s_detail3[1].b_bgbd006

           ON ACTION controlp INFIELD b_bgbd007
              #add-point:ON ACTION controlp INFIELD b_bgbd007
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c'
		        LET g_qryparam.reqry = FALSE
		        LET g_qryparam.where = " bgbd001 = '",g_detail3[1].bgbd001,"' ",
		                               " AND bgbd002 = '",g_detail3[1].bgbd002,"' ",
		                               " AND bgbd003 = '",g_detail3[1].bgbd003,"' ",
		                               " AND bgbd006 = '",g_detail3[1].bgbd006,"' "
              CALL q_bgbd007()                      #呼叫開窗
              DISPLAY g_qryparam.return1 TO b_bgbd007 #顯示到畫面上
              
              NEXT FIELD b_bgbd007                    #返回原欄位
              #END add-point                       
               
            
            AFTER CONSTRUCT
               
         
         END CONSTRUCT
         #end add-point
     

        ON ACTION accept
         CALL abgq095_set_page()
         CALL abgq095_cs()
         ACCEPT DIALOG 
         
 
        ON ACTION cancel
          LET INT_FLAG = 1
          EXIT DIALOG 
       &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG 
   
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
   CALL abgq095_b_fill1()
   CALL cl_set_act_visible("first,previous,jump,next,last",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL abgq095_filter_parser(ps_field)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq095_filter_parser(ps_field)
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
 
