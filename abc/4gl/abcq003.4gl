#該程式已解開Section, 不再透過樣板產出!
{<section id="abcq003.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2017-01-11 09:47:37), PR版次:0001(2017-03-03 13:46:50)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000009
#+ Filename...: abcq003
#+ Description: 條碼庫存列表查詢
#+ Creator....: 04543(2017-01-11 09:47:37)
#+ Modifier...: 04543 -SD/PR- 04543
 
{</section>}
 
{<section id="abcq003.global" >}
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
PRIVATE TYPE type_g_bcaa_d RECORD
       #statepic       LIKE type_t.chr1,
       
       bcaa001 LIKE bcaa_t.bcaa001, 
   bcaa002 LIKE bcaa_t.bcaa002, 
   bcaa002_desc LIKE type_t.chr500, 
   bcaa002_desc_desc LIKE type_t.chr500, 
   bcaa008 LIKE bcaa_t.bcaa008, 
   bcaa008_desc LIKE type_t.chr500, 
   bcaa013 LIKE bcaa_t.bcaa013, 
   bcaa012 LIKE bcaa_t.bcaa012, 
   sum LIKE type_t.num20_6 
       END RECORD
PRIVATE TYPE type_g_bcaa2_d RECORD
       bcab002 LIKE bcab_t.bcab002, 
   bcab002_desc LIKE type_t.chr500, 
   bcab003 LIKE bcab_t.bcab003, 
   bcab003_desc LIKE type_t.chr500, 
   bcab004 LIKE bcab_t.bcab004, 
   bcab008 LIKE bcab_t.bcab008, 
   bcab009 LIKE bcab_t.bcab009, 
   bcab007 LIKE bcab_t.bcab007
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_bcaa_d
DEFINE g_master_t                   type_g_bcaa_d
DEFINE g_bcaa_d          DYNAMIC ARRAY OF type_g_bcaa_d
DEFINE g_bcaa_d_t        type_g_bcaa_d
DEFINE g_bcaa2_d   DYNAMIC ARRAY OF type_g_bcaa2_d
DEFINE g_bcaa2_d_t type_g_bcaa2_d
 
 
      
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
 
{<section id="abcq003.main" >}
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
   CALL cl_ap_init("abc","")
 
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
   DECLARE abcq003_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abcq003_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abcq003_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abcq003 WITH FORM cl_ap_formpath("abc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abcq003_init()   
 
      #進入選單 Menu (="N")
      CALL abcq003_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abcq003
      
   END IF 
   
   CLOSE abcq003_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abcq003.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION abcq003_init()
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
   #判斷據點參數若不使用產品特徵時，則產品特徵需隱藏不可以維護(據點參數:S-BAS-0036)
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0036') = 'N' THEN
      CALL cl_set_comp_visible("b_bcaa008,b_bcaa008_desc",FALSE)
   END IF

   #end add-point
 
   CALL abcq003_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="abcq003.default_search" >}
PRIVATE FUNCTION abcq003_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " bcaa000 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " bcaa001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " bcaa002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " bcaa003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " bcaa004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " bcaa005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " bcaa006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " bcaa007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " bcaa008 = '", g_argv[09], "' AND "
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
 
{<section id="abcq003.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION abcq003_ui_dialog()
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
      CALL abcq003_b_fill()
   ELSE
      CALL abcq003_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_bcaa_d.clear()
         CALL g_bcaa2_d.clear()
 
 
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
 
         CALL abcq003_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_bcaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL abcq003_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL abcq003_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
         DISPLAY ARRAY g_bcaa2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_bcaa2_d.getLength() TO FORMONLY.cnt
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
            CALL abcq003_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL abcq003_query()
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
            CALL abcq003_filter()
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
            CALL abcq003_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_bcaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_bcaa2_d)
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
            CALL abcq003_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL abcq003_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL abcq003_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL abcq003_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               CALL abcq003_print()
            END IF

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
 
{<section id="abcq003.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION abcq003_query()
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
   CALL g_bcaa_d.clear()
   CALL g_bcaa2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON bcaa001,bcaa002,bcaa008,bcaa013,bcaa012
           FROM s_detail1[1].b_bcaa001,s_detail1[1].b_bcaa002,s_detail1[1].b_bcaa008,s_detail1[1].b_bcaa013, 
               s_detail1[1].b_bcaa012
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_bcaa001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcaa001
            #add-point:BEFORE FIELD b_bcaa001 name="construct.b.page1.b_bcaa001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcaa001
            
            #add-point:AFTER FIELD b_bcaa001 name="construct.a.page1.b_bcaa001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bcaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa001
            #add-point:ON ACTION controlp INFIELD b_bcaa001 name="construct.c.page1.b_bcaa001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_bcaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcaa001  #顯示到畫面上
            NEXT FIELD b_bcaa001
            #END add-point
 
 
         #----<<b_bcaa002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcaa002
            #add-point:BEFORE FIELD b_bcaa002 name="construct.b.page1.b_bcaa002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcaa002
            
            #add-point:AFTER FIELD b_bcaa002 name="construct.a.page1.b_bcaa002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bcaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa002
            #add-point:ON ACTION controlp INFIELD b_bcaa002 name="construct.c.page1.b_bcaa002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_15()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcaa002  #顯示到畫面上
            NEXT FIELD b_bcaa002
            #END add-point
 
 
         #----<<b_bcaa002_desc>>----
         #----<<b_bcaa002_desc_desc>>----
         #----<<b_bcaa008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcaa008
            #add-point:BEFORE FIELD b_bcaa008 name="construct.b.page1.b_bcaa008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcaa008
            
            #add-point:AFTER FIELD b_bcaa008 name="construct.a.page1.b_bcaa008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bcaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa008
            #add-point:ON ACTION controlp INFIELD b_bcaa008 name="construct.c.page1.b_bcaa008"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inam002()                           #呼叫開窗
            DISPLAY g_qryparam.return2 TO b_bcaa008  #顯示到畫面上
            NEXT FIELD b_bcaa008
            #END add-point
 
 
         #----<<b_bcaa008_desc>>----
         #----<<b_bcaa013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcaa013
            #add-point:BEFORE FIELD b_bcaa013 name="construct.b.page1.b_bcaa013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcaa013
            
            #add-point:AFTER FIELD b_bcaa013 name="construct.a.page1.b_bcaa013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bcaa013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa013
            #add-point:ON ACTION controlp INFIELD b_bcaa013 name="construct.c.page1.b_bcaa013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_bcaa013()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcaa013  #顯示到畫面上
            NEXT FIELD b_bcaa013
            #END add-point
 
 
         #----<<b_bcaa012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcaa012
            #add-point:BEFORE FIELD b_bcaa012 name="construct.b.page1.b_bcaa012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcaa012
            
            #add-point:AFTER FIELD b_bcaa012 name="construct.a.page1.b_bcaa012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_bcaa012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa012
            #add-point:ON ACTION controlp INFIELD b_bcaa012 name="construct.c.page1.b_bcaa012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcaa012  #顯示到畫面上
            NEXT FIELD b_bcaa012

            #END add-point
 
 
         #----<<sum>>----
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON bcab002,bcab003,bcab004,bcab008,bcab009,bcab007
           FROM s_detail2[1].b_bcab002,s_detail2[1].b_bcab003,s_detail2[1].b_bcab004,s_detail2[1].b_bcab008, 
               s_detail2[1].b_bcab009,s_detail2[1].b_bcab007
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #----<<b_bcab002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab002
            #add-point:BEFORE FIELD b_bcab002 name="construct.b.page2.b_bcab002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab002
            
            #add-point:AFTER FIELD b_bcab002 name="construct.a.page2.b_bcab002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab002
            #add-point:ON ACTION controlp INFIELD b_bcab002 name="construct.c.page2.b_bcab002"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_inaa001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcab002  #顯示到畫面上
            NEXT FIELD b_bcab002                     #返回原欄位


            #END add-point
 
 
         #----<<b_bcab002_desc>>----
         #----<<b_bcab003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab003
            #add-point:BEFORE FIELD b_bcab003 name="construct.b.page2.b_bcab003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab003
            
            #add-point:AFTER FIELD b_bcab003 name="construct.a.page2.b_bcab003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab003
            #add-point:ON ACTION controlp INFIELD b_bcab003 name="construct.c.page2.b_bcab003"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_5()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO b_bcab003  #顯示到畫面上

            NEXT FIELD b_bcab003                     #返回原欄位


            #END add-point
 
 
         #----<<b_bcab003_desc>>----
         #----<<b_bcab004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab004
            #add-point:BEFORE FIELD b_bcab004 name="construct.b.page2.b_bcab004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab004
            
            #add-point:AFTER FIELD b_bcab004 name="construct.a.page2.b_bcab004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab004
            #add-point:ON ACTION controlp INFIELD b_bcab004 name="construct.c.page2.b_bcab004"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_bcab004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcab004  #顯示到畫面上
            NEXT FIELD b_bcab004

            #END add-point
 
 
         #----<<b_bcab008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab008
            #add-point:BEFORE FIELD b_bcab008 name="construct.b.page2.b_bcab008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab008
            
            #add-point:AFTER FIELD b_bcab008 name="construct.a.page2.b_bcab008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab008
            #add-point:ON ACTION controlp INFIELD b_bcab008 name="construct.c.page2.b_bcab008"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_bcab008()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcab008  #顯示到畫面上
            NEXT FIELD b_bcab008

            #END add-point
 
 
         #----<<b_bcab009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab009
            #add-point:BEFORE FIELD b_bcab009 name="construct.b.page2.b_bcab009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab009
            
            #add-point:AFTER FIELD b_bcab009 name="construct.a.page2.b_bcab009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab009
            #add-point:ON ACTION controlp INFIELD b_bcab009 name="construct.c.page2.b_bcab009"

            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE

            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_bcab009  #顯示到畫面上
            NEXT FIELD b_bcab009

            #END add-point
 
 
         #----<<b_bcab007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_bcab007
            #add-point:BEFORE FIELD b_bcab007 name="construct.b.page2.b_bcab007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_bcab007
            
            #add-point:AFTER FIELD b_bcab007 name="construct.a.page2.b_bcab007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_bcab007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcab007
            #add-point:ON ACTION controlp INFIELD b_bcab007 name="construct.c.page2.b_bcab007"
            
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
   LET g_wc2 = " 1=1"
   #end add-point
        
   LET g_error_show = 1
   CALL abcq003_b_fill()
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
 
{<section id="abcq003.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abcq003_b_fill()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE bcaa001,bcaa002,'','',bcaa008,'',bcaa013,bcaa012,''  ,DENSE_RANK() OVER( ORDER BY bcaa_t.bcaa000, 
       bcaa_t.bcaa001,bcaa_t.bcaa002,bcaa_t.bcaa003,bcaa_t.bcaa004,bcaa_t.bcaa005,bcaa_t.bcaa006,bcaa_t.bcaa007, 
       bcaa_t.bcaa008) AS RANK FROM bcaa_t",
 
                     " LEFT JOIN bcab_t ON bcabent = bcaaent AND bcabsite = bcaasite AND bcaa000 = bcab001",
 
 
                     "",
                     " WHERE bcaaent= ? AND bcaasite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("bcaa_t"),
                     " ORDER BY bcaa_t.bcaa000,bcaa_t.bcaa001,bcaa_t.bcaa002,bcaa_t.bcaa003,bcaa_t.bcaa004,bcaa_t.bcaa005,bcaa_t.bcaa006,bcaa_t.bcaa007,bcaa_t.bcaa008"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT UNIQUE bcaa001,bcaa002,'','',bcaa008,'',bcaa013,bcaa012,",
                     "              COALESCE(SUM(bcab007),0) sum_num,",
                     "        DENSE_RANK() OVER(ORDER BY bcaa001,bcaa002,bcaa008) AS RANK ",
                     "  FROM bcaa_t",
                     "  LEFT JOIN bcab_t ON bcabent = bcaaent AND bcabsite = bcaasite AND bcab001 = bcaa001",
                     " WHERE bcaaent= ? AND bcaasite= ? AND 1=1 AND ", ls_wc
                     
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("bcaa_t"),
                     " GROUP BY bcaa001,bcaa002,bcaa008,bcaa013,bcaa012",
                     " ORDER BY bcaa001,bcaa002,bcaa008"
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
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
 
   LET g_sql = "SELECT bcaa001,bcaa002,'','',bcaa008,'',bcaa013,bcaa012,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   LET g_sql = "SELECT bcaa001,bcaa002,'','',bcaa008,'',bcaa013,bcaa012,sum_num",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page

   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE abcq003_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR abcq003_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_bcaa_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_bcaa_d[l_ac].bcaa001,g_bcaa_d[l_ac].bcaa002,g_bcaa_d[l_ac].bcaa002_desc, 
       g_bcaa_d[l_ac].bcaa002_desc_desc,g_bcaa_d[l_ac].bcaa008,g_bcaa_d[l_ac].bcaa008_desc,g_bcaa_d[l_ac].bcaa013, 
       g_bcaa_d[l_ac].bcaa012,g_bcaa_d[l_ac].sum
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_bcaa_d[l_ac].statepic = cl_get_actipic(g_bcaa_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_desc_get_item_desc(g_bcaa_d[l_ac].bcaa002)
      RETURNING g_bcaa_d[l_ac].bcaa002_desc,g_bcaa_d[l_ac].bcaa002_desc_desc
       
      CALL s_desc_get_feature_description(g_bcaa_d[l_ac].bcaa002,g_bcaa_d[l_ac].bcaa008)
      RETURNING g_bcaa_d[l_ac].bcaa008_desc
      #end add-point
 
      CALL abcq003_detail_show("'1'")      
 
      CALL abcq003_bcaa_t_mask()
 
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
   
 
   
   CALL g_bcaa_d.deleteElement(g_bcaa_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_bcaa_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE abcq003_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abcq003_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abcq003_detail_action_trans()
 
   IF g_bcaa_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL abcq003_fetch()
   END IF
   
      CALL abcq003_filter_show('bcaa001','b_bcaa001')
   CALL abcq003_filter_show('bcaa002','b_bcaa002')
   CALL abcq003_filter_show('bcaa008','b_bcaa008')
   CALL abcq003_filter_show('bcaa013','b_bcaa013')
   CALL abcq003_filter_show('bcaa012','b_bcaa012')
   CALL abcq003_filter_show('bcab002','b_bcab002')
   CALL abcq003_filter_show('bcab003','b_bcab003')
   CALL abcq003_filter_show('bcab004','b_bcab004')
   CALL abcq003_filter_show('bcab008','b_bcab008')
   CALL abcq003_filter_show('bcab009','b_bcab009')
   CALL abcq003_filter_show('bcab007','b_bcab007')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abcq003_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"

   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"

   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"

   #end add-point
 
   CALL g_bcaa2_d.clear()
 
 
   #add-point:陣列清空 name="fetch.array_clear"

   #end add-point
   
   LET li_ac = l_ac 
   
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE bcab002,'',bcab003,'',bcab004,bcab008,bcab009,bcab007 FROM bcab_t", 
              
                  "",
                  " WHERE bcabent=? AND bcabsite=? AND bcab001=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY bcab_t.bcab002,bcab_t.bcab003,bcab_t.bcab004,bcab_t.bcab008,bcab_t.bcab009" 
                         
      #add-point:單身填充前 name="fetch.before_fill2"

      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料   
      PREPARE abcq003_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR abcq003_pb2
   END IF
 
   LET l_ac = 1
   FOREACH b_fill_curs2 USING g_enterprise, g_site,g_bcaa_d[g_detail_idx].bcaa001   #(ver:42)
   
      INTO g_bcaa2_d[l_ac].bcab002,g_bcaa2_d[l_ac].bcab002_desc,g_bcaa2_d[l_ac].bcab003,g_bcaa2_d[l_ac].bcab003_desc, 
           g_bcaa2_d[l_ac].bcab004,g_bcaa2_d[l_ac].bcab008,g_bcaa2_d[l_ac].bcab009,g_bcaa2_d[l_ac].bcab007  
           
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
 
      #add-point:b_fill段資料填充 name="fetch.fill2"
      CALL s_desc_get_stock_desc(g_site,g_bcaa2_d[l_ac].bcab002)
      RETURNING g_bcaa2_d[l_ac].bcab002_desc
      
      CALL s_desc_get_locator_desc(g_site,g_bcaa2_d[l_ac].bcab002,g_bcaa2_d[l_ac].bcab003)
      RETURNING g_bcaa2_d[l_ac].bcab003_desc
      #end add-point
      
      CALL abcq003_detail_show("'2'")      
 
      CALL abcq003_bcab_t_mask()
 
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
   
   CALL g_bcaa2_d.deleteElement(g_bcaa2_d.getLength())   
 
   #單身總筆數顯示
   LET g_detail_cnt2 = g_bcaa2_d.getLength()
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
 
{<section id="abcq003.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abcq003_detail_show(ps_page)
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
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION abcq003_filter()
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
      CONSTRUCT g_wc_filter ON bcaa001,bcaa002,bcaa008,bcaa013,bcaa012
                          FROM s_detail1[1].b_bcaa001,s_detail1[1].b_bcaa002,s_detail1[1].b_bcaa008, 
                              s_detail1[1].b_bcaa013,s_detail1[1].b_bcaa012
 
         BEFORE CONSTRUCT
                     DISPLAY abcq003_filter_parser('bcaa001') TO s_detail1[1].b_bcaa001
            DISPLAY abcq003_filter_parser('bcaa002') TO s_detail1[1].b_bcaa002
            DISPLAY abcq003_filter_parser('bcaa008') TO s_detail1[1].b_bcaa008
            DISPLAY abcq003_filter_parser('bcaa013') TO s_detail1[1].b_bcaa013
            DISPLAY abcq003_filter_parser('bcaa012') TO s_detail1[1].b_bcaa012
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_bcaa001>>----
         #Ctrlp:construct.c.filter.page1.b_bcaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa001
            #add-point:ON ACTION controlp INFIELD b_bcaa001 name="construct.c.filter.page1.b_bcaa001"
            
            #END add-point
 
 
         #----<<b_bcaa002>>----
         #Ctrlp:construct.c.filter.page1.b_bcaa002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa002
            #add-point:ON ACTION controlp INFIELD b_bcaa002 name="construct.c.filter.page1.b_bcaa002"
            
            #END add-point
 
 
         #----<<b_bcaa002_desc>>----
         #----<<b_bcaa002_desc_desc>>----
         #----<<b_bcaa008>>----
         #Ctrlp:construct.c.filter.page1.b_bcaa008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa008
            #add-point:ON ACTION controlp INFIELD b_bcaa008 name="construct.c.filter.page1.b_bcaa008"
            
            #END add-point
 
 
         #----<<b_bcaa008_desc>>----
         #----<<b_bcaa013>>----
         #Ctrlp:construct.c.filter.page1.b_bcaa013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa013
            #add-point:ON ACTION controlp INFIELD b_bcaa013 name="construct.c.filter.page1.b_bcaa013"
            
            #END add-point
 
 
         #----<<b_bcaa012>>----
         #Ctrlp:construct.c.filter.page1.b_bcaa012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_bcaa012
            #add-point:ON ACTION controlp INFIELD b_bcaa012 name="construct.c.filter.page1.b_bcaa012"
            
            #END add-point
 
 
         #----<<sum>>----
   
 
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
   
      CALL abcq003_filter_show('bcaa001','b_bcaa001')
   CALL abcq003_filter_show('bcaa002','b_bcaa002')
   CALL abcq003_filter_show('bcaa008','b_bcaa008')
   CALL abcq003_filter_show('bcaa013','b_bcaa013')
   CALL abcq003_filter_show('bcaa012','b_bcaa012')
   CALL abcq003_filter_show('bcab002','b_bcab002')
   CALL abcq003_filter_show('bcab003','b_bcab003')
   CALL abcq003_filter_show('bcab004','b_bcab004')
   CALL abcq003_filter_show('bcab008','b_bcab008')
   CALL abcq003_filter_show('bcab009','b_bcab009')
   CALL abcq003_filter_show('bcab007','b_bcab007')
 
    
   CALL abcq003_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION abcq003_filter_parser(ps_field)
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
 
{<section id="abcq003.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION abcq003_filter_show(ps_field,ps_object)
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
   LET ls_condition = abcq003_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.insert" >}
#+ insert
PRIVATE FUNCTION abcq003_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abcq003.modify" >}
#+ modify
PRIVATE FUNCTION abcq003_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.reproduce" >}
#+ reproduce
PRIVATE FUNCTION abcq003_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.delete" >}
#+ delete
PRIVATE FUNCTION abcq003_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="abcq003.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abcq003_detail_action_trans()
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
 
{<section id="abcq003.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abcq003_detail_index_setting()
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
            IF g_bcaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_bcaa_d.getLength() AND g_bcaa_d.getLength() > 0
            LET g_detail_idx = g_bcaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_bcaa_d.getLength() THEN
               LET g_detail_idx = g_bcaa_d.getLength()
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
 
{<section id="abcq003.mask_functions" >}
 &include "erp/abc/abcq003_mask.4gl"
 
{</section>}
 
{<section id="abcq003.other_function" readonly="Y" >}

PRIVATE FUNCTION abcq003_b_fill_2()
#   DEFINE l_sql    STRING
#   
#   LET l_sql = "SELECT bcab002,bcab003,bcab004,bcab008,bcab009,bcab007,",
#               "       (SELECT inayl003 FROM inayl_t WHERE inaylent = bcabent AND inayl001 = bcab002 AND inayl002 = '",g_dlang,"') inayl003,",
#               "       (SELECT inab003 FROM inab_t WHERE inabent = bcabent AND inabsite = bcabsite AND inab001 = bcab002 AND inab002 = bcab003) inab003",
#               "  FROM bcab_t",
#               " WHERE bcabent =",g_enterprise,
#               "   AND bcabsite = '",g_site,"'",
#               "   AND bcab001 = ?",
#               "   AND bcab009 = ?",
#               " ORDER BY bcab002,bcab003,bcab004,bcab008,bcab009,bcab007"
#               
#   PREPARE b_fill2_pre FROM l_sql
#   DECLARE b_fill2_curs CURSOR FOR b_fill2_pre
#   
#   OPEN b_fill2_curs USING g_bcaa_d[l_ac].bcaa001,g_bcaa_d[l_ac].bcaa012
# 
#   CALL g_bcab_d.clear()
# 
#   LET l_ac2 = 1   
# 
#   FOREACH b_fill2_curs INTO g_bcab_d[l_ac2].bcab002,g_bcab_d[l_ac2].bcab003,g_bcab_d[l_ac2].bcab004,g_bcab_d[l_ac2].bcab008, 
#                             g_bcab_d[l_ac2].bcab009,g_bcab_d[l_ac2].bcab007,
#                             g_bcab_d[l_ac2].bcab002_desc,g_bcab_d[l_ac2].bcab003_desc
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      
#      IF l_ac2 > g_max_rec THEN
#         IF g_error_show = 1 THEN
#            INITIALIZE g_errparam TO NULL 
#            LET g_errparam.extend =  "" 
#            LET g_errparam.code   =  9035 
#            LET g_errparam.popup  = TRUE 
#            CALL cl_err()
# 
#         END IF
#         EXIT FOREACH
#      END IF
#      LET l_ac2 = l_ac2 + 1
#      
#   END FOREACH
#   LET g_error_show = 0
#     
#   CALL g_bcab_d.deleteElement(g_bcab_d.getLength())
#   
#   CLOSE b_fill2_curs
#   FREE b_fill2_pre
   
END FUNCTION

#列印
PRIVATE FUNCTION abcq003_print()
   DEFINE l_master RECORD
      bcaa001        LIKE bcaa_t.bcaa001,
      bcaa002        LIKE bcaa_t.bcaa002,
      bcaa004        LIKE bcaa_t.bcaa004,
      bcaa005        LIKE bcaa_t.bcaa005,
      input_chk      LIKE type_t.chr500,
      b_bcaa001      LIKE type_t.chr500,
      b_bcaa002      LIKE type_t.chr500,
      bcaa002_desc   LIKE type_t.chr80,
      bcaa002_desc_1 LIKE type_t.chr80,
      bcaa002_desc_2 LIKE type_t.chr80,
      b_bcaa013      LIKE type_t.chr30,
      b_bcaa009      LIKE type_t.num20_6,
      print_num      LIKE type_t.num10,
      bcaastus       LIKE bcaa_t.bcaastus,
      wc             STRING
                   END RECORD
   DEFINE la_param   RECORD
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
          END RECORD
   DEFINE ls_js      STRING

   INITIALIZE l_master.* TO NULL

   IF NOT cl_null(g_bcaa_d[g_detail_idx].bcaa001) THEN
      LET l_master.bcaa001        = g_bcaa_d[g_detail_idx].bcaa001
      LET l_master.bcaa002        = g_bcaa_d[g_detail_idx].bcaa002
      LET l_master.input_chk      = 'N'
      LET l_master.print_num      = '1'
      LET l_master.bcaastus       = 'Y'
      LET l_master.wc             = "     bcaa001 = '",g_bcaa_d[g_detail_idx].bcaa001,"'",
                                    " AND bcaa002 = '",g_bcaa_d[g_detail_idx].bcaa002,"'"
      LET ls_js = util.JSON.stringify(l_master)

      INITIALIZE la_param.* TO NULL
      LET la_param.prog     = 'abcr002'
      LET la_param.param[1] = ls_js
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF

   RETURN

END FUNCTION

 
{</section>}
 
