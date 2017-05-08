#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq116.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-03-03 14:02:10), PR版次:0007(2016-10-18 16:06:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: adeq116
#+ Description: 門店管理品類預算同比經營日查詢作業
#+ Creator....: 01752(2015-07-06 21:36:03)
#+ Modifier...: 06137 -SD/PR- 02159
 
{</section>}
 
{<section id="adeq116.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#52 2016/04/27 By 07673   將重複內容的錯誤訊息置換為公用錯誤訊息
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   adeq116_debs_temp -->adeq116_tmp01
#                                      Mod   adeq116_rtja_temp -->adeq116_tmp02
#                                      Mod   adeq116_date_temp -->adeq116_tmp03
#161006-00008#4  2016/10/18 by sakura  整批修改組織
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
PRIVATE TYPE type_g_debs_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   debs002 LIKE debs_t.debs002, 
   debssite LIKE debs_t.debssite, 
   debssite_desc LIKE type_t.chr500, 
   debs005 LIKE debs_t.debs005, 
   debs005_desc LIKE type_t.chr500, 
   debs016 LIKE debs_t.debs016, 
   l_debs016_b LIKE type_t.num20_6, 
   l_debs016_r2 LIKE type_t.num20_6, 
   l_debs016_p LIKE type_t.num20_6, 
   l_debs016_r3 LIKE type_t.num20_6, 
   debs017 LIKE debs_t.debs017, 
   l_debs017_b LIKE type_t.num20_6, 
   l_debs017_r1 LIKE type_t.num20_6, 
   l_debs017_p LIKE type_t.num20_6, 
   debs018 LIKE debs_t.debs018, 
   l_debs018_b LIKE type_t.num20_6, 
   l_debs018_r1 LIKE type_t.num20_6, 
   l_debs018_p LIKE type_t.num20_6, 
   l_debs018_r2 LIKE type_t.num20_6, 
   debs012 LIKE debs_t.debs012, 
   l_debs012_p LIKE type_t.num20_6, 
   debs019 LIKE debs_t.debs019, 
   l_debs019_p LIKE type_t.num20_6, 
   l_debs019_r1 LIKE type_t.num20_6, 
   debs034 LIKE debs_t.debs034, 
   l_debs034_p LIKE type_t.num20_6, 
   l_debs034_r1 LIKE type_t.num20_6, 
   l_stock_cost LIKE type_t.num20_6, 
   l_stock_cost_p LIKE type_t.num20_6, 
   l_self_sale LIKE type_t.num20_6, 
   l_self_sale_p LIKE type_t.num20_6, 
   l_uni_sale LIKE type_t.num20_6, 
   l_uni_sale_p LIKE type_t.num20_6, 
   l_debs016_r1 LIKE type_t.num20_6, 
   l_ooef113 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_debs2_d DYNAMIC ARRAY OF RECORD
       debssite          LIKE debs_t.debssite, 
       debssite_desc     LIKE type_t.chr500, 
       debs005           LIKE debs_t.debs005, 
       debs005_desc      LIKE type_t.chr500, 
       debs016           LIKE debs_t.debs016, 
       l_debs016_b       LIKE type_t.num20_6, 
       l_debs016_r2      LIKE type_t.num20_6, 
       l_debs016_p       LIKE type_t.num20_6, 
       l_debs016_r3      LIKE type_t.num20_6, 
       debs017           LIKE debs_t.debs017, 
       l_debs017_b       LIKE type_t.num20_6, 
       l_debs017_r1      LIKE type_t.num20_6, 
       l_debs017_p       LIKE type_t.num20_6, 
       debs018           LIKE debs_t.debs018, 
       l_debs018_b       LIKE type_t.num20_6, 
       l_debs018_r1      LIKE type_t.num20_6, 
       l_debs018_p       LIKE type_t.num20_6, 
       l_debs018_r2      LIKE type_t.num20_6, 
       debs012           LIKE debs_t.debs012, 
       l_debs012_p       LIKE type_t.num20_6, 
       debs019           LIKE debs_t.debs019, 
       l_debs019_p       LIKE type_t.num20_6, 
       l_debs019_r1      LIKE type_t.num20_6, 
       debs034           LIKE debs_t.debs034, 
       l_debs034_p       LIKE type_t.num20_6, 
       l_debs034_r1      LIKE type_t.num20_6, 
       l_stock_cost      LIKE type_t.num20_6, 
       l_stock_cost_p    LIKE type_t.num20_6, 
       l_self_sale       LIKE type_t.num20_6, 
       l_self_sale_p     LIKE type_t.num20_6, 
       l_uni_sale        LIKE type_t.num20_6, 
       l_uni_sale_p      LIKE type_t.num20_6, 
       l_debs016_r1      LIKE type_t.num20_6, 
       l_ooef113         LIKE type_t.num20_6 
                END RECORD
DEFINE g_last_year_date     LIKE type_t.dat
DEFINE g_total_debs016      LIKE debs_t.debs016
DEFINE g_last_year_date2    LIKE type_t.dat      #150716-00020#2 15/07/20 s983961--add
DEFINE g_maxdata            LIKE type_t.dat      #150716-00020#2 15/07/20 s983961--add 搜尋出來的最大筆統計日期

#160126-00007#3 Add By Ken 160215(S)
TYPE type_g_input             RECORD
     l_sale_qbe               LIKE rtca_t.rtca001,
     l_sale_qbe_desc          LIKE rtcal_t.rtcal003,
     l_gross_profit_qbe       LIKE rtca_t.rtca001,
     l_gross_profit_desc      LIKE rtcal_t.rtcal003
                              END RECORD
DEFINE g_input                type_g_input
DEFINE g_input_t              type_g_input
#160126-00007#3 Add By Ken 160215(E)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_debs_d
DEFINE g_master_t                   type_g_debs_d
DEFINE g_debs_d          DYNAMIC ARRAY OF type_g_debs_d
DEFINE g_debs_d_t        type_g_debs_d
 
      
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
 
{<section id="adeq116.main" >}
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
   DECLARE adeq116_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq116_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq116_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq116 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq116_init()   
 
      #進入選單 Menu (="N")
      CALL adeq116_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq116
      
   END IF 
   
   CLOSE adeq116_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL adeq116_drop_temp() RETURNING l_success
   CALL adeq116_drop_temp1() RETURNING l_success  #150916-00011#7 Add By Ken 151015
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq116.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq116_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success      LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq116_create_temp() RETURNING l_success
   CALL adeq116_create_temp1() RETURNING l_success  #150916-00011#7 Add By Ken 151015
   #end add-point
 
   CALL adeq116_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq116.default_search" >}
PRIVATE FUNCTION adeq116_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " debssite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " debs002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " debs005 = '", g_argv[03], "' AND "
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
 
{<section id="adeq116.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq116_ui_dialog()
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
      CALL adeq116_b_fill()
   ELSE
      CALL adeq116_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_debs_d.clear()
 
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
 
         CALL adeq116_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_debs_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq116_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq116_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_debs2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2)
            #BEFORE DISPLAY 
            #   LET g_current_page = 2
            #   LET g_detail_cnt2 = g_debs2_d.getLength()
            #   
            #BEFORE ROW
            #  LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
            #  LET l_ac = g_detail_idx
            #  DISPLAY g_detail_idx TO FORMONLY.h_index
            #  DISPLAY g_detail_cnt2 TO FORMONLY.h_count
 
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq116_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert,selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq116_insert()
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
               CALL adeq116_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG
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
            CALL adeq116_filter()
            #add-point:ON ACTION filter name="menu.filter"
            #EXIT DIALOG
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
            CALL adeq116_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_debs_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_debs2_d)
               LET g_export_id[2]   = "s_detail2"
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
            CALL adeq116_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq116_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq116_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq116_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_debs_d.getLength()
               LET g_debs_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_debs_d.getLength()
               LET g_debs_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_debs_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debs_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_debs_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_debs_d[li_idx].sel = "N"
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
 
{<section id="adeq116.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq116_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   #160126-00007#3 Add By Ken 160217(S)
   INITIALIZE g_input.* TO NULL
   DISPLAY BY NAME  g_input.l_sale_qbe, g_input.l_sale_qbe_desc,
                    g_input.l_gross_profit_qbe, g_input.l_gross_profit_desc   
   CALL g_debs2_d.clear()
   LET g_wc2 = " 1=1"
   #160126-00007#3 Add By Ken 160217(E)
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_debs_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON debs002,debssite,debs005,debs016,debs017,debs018,debs012,debs019,debs034 
 
           FROM s_detail1[1].b_debs002,s_detail1[1].b_debssite,s_detail1[1].b_debs005,s_detail1[1].b_debs016, 
               s_detail1[1].b_debs017,s_detail1[1].b_debs018,s_detail1[1].b_debs012,s_detail1[1].b_debs019, 
               s_detail1[1].b_debs034
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO b_debssite  
            DISPLAY g_today - 1 TO b_debs002  
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_debs002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs002
            #add-point:BEFORE FIELD b_debs002 name="construct.b.page1.b_debs002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs002
            
            #add-point:AFTER FIELD b_debs002 name="construct.a.page1.b_debs002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs002
            #add-point:ON ACTION controlp INFIELD b_debs002 name="construct.c.page1.b_debs002"
            
            #END add-point
 
 
         #----<<b_debssite>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debssite
            #add-point:BEFORE FIELD b_debssite name="construct.b.page1.b_debssite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debssite
            
            #add-point:AFTER FIELD b_debssite name="construct.a.page1.b_debssite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debssite
            #add-point:ON ACTION controlp INFIELD b_debssite name="construct.c.page1.b_debssite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debssite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_debssite  #顯示到畫面上
            NEXT FIELD b_debssite                     #返回原欄位  
            #END add-point
 
 
         #----<<b_debssite_desc>>----
         #----<<b_debs005>>----
         #Ctrlp:construct.c.page1.b_debs005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs005
            #add-point:ON ACTION controlp INFIELD b_debs005 name="construct.c.page1.b_debs005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,g_site,'E-CIR-0001')
            CALL q_rtax001_2()
            DISPLAY g_qryparam.return1 TO b_debs005  #顯示到畫面上
            NEXT FIELD b_debs005                     #返回原欄位  
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs005
            #add-point:BEFORE FIELD b_debs005 name="construct.b.page1.b_debs005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs005
            
            #add-point:AFTER FIELD b_debs005 name="construct.a.page1.b_debs005"
            
            #END add-point
            
 
 
         #----<<b_debs005_desc>>----
         #----<<b_debs016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs016
            #add-point:BEFORE FIELD b_debs016 name="construct.b.page1.b_debs016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs016
            
            #add-point:AFTER FIELD b_debs016 name="construct.a.page1.b_debs016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs016
            #add-point:ON ACTION controlp INFIELD b_debs016 name="construct.c.page1.b_debs016"
            
            #END add-point
 
 
         #----<<l_debs016_b>>----
         #----<<l_debs016_r2>>----
         #----<<l_debs016_p>>----
         #----<<l_debs016_r3>>----
         #----<<b_debs017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs017
            #add-point:BEFORE FIELD b_debs017 name="construct.b.page1.b_debs017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs017
            
            #add-point:AFTER FIELD b_debs017 name="construct.a.page1.b_debs017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs017
            #add-point:ON ACTION controlp INFIELD b_debs017 name="construct.c.page1.b_debs017"
            
            #END add-point
 
 
         #----<<l_debs017_b>>----
         #----<<l_debs017_r1>>----
         #----<<l_debs017_p>>----
         #----<<b_debs018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs018
            #add-point:BEFORE FIELD b_debs018 name="construct.b.page1.b_debs018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs018
            
            #add-point:AFTER FIELD b_debs018 name="construct.a.page1.b_debs018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs018
            #add-point:ON ACTION controlp INFIELD b_debs018 name="construct.c.page1.b_debs018"
            
            #END add-point
 
 
         #----<<l_debs018_b>>----
         #----<<l_debs018_r1>>----
         #----<<l_debs018_p>>----
         #----<<l_debs018_r2>>----
         #----<<b_debs012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs012
            #add-point:BEFORE FIELD b_debs012 name="construct.b.page1.b_debs012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs012
            
            #add-point:AFTER FIELD b_debs012 name="construct.a.page1.b_debs012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs012
            #add-point:ON ACTION controlp INFIELD b_debs012 name="construct.c.page1.b_debs012"
            
            #END add-point
 
 
         #----<<l_debs012_p>>----
         #----<<b_debs019>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs019
            #add-point:BEFORE FIELD b_debs019 name="construct.b.page1.b_debs019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs019
            
            #add-point:AFTER FIELD b_debs019 name="construct.a.page1.b_debs019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs019
            #add-point:ON ACTION controlp INFIELD b_debs019 name="construct.c.page1.b_debs019"
            
            #END add-point
 
 
         #----<<l_debs019_p>>----
         #----<<l_debs019_r1>>----
         #----<<b_debs034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_debs034
            #add-point:BEFORE FIELD b_debs034 name="construct.b.page1.b_debs034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_debs034
            
            #add-point:AFTER FIELD b_debs034 name="construct.a.page1.b_debs034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_debs034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs034
            #add-point:ON ACTION controlp INFIELD b_debs034 name="construct.c.page1.b_debs034"
            
            #END add-point
 
 
         #----<<l_debs034_p>>----
         #----<<l_debs034_r1>>----
         #----<<l_stock_cost>>----
         #----<<l_stock_cost_p>>----
         #----<<l_self_sale>>----
         #----<<l_self_sale_p>>----
         #----<<l_uni_sale>>----
         #----<<l_uni_sale_p>>----
         #----<<l_debs016_r1>>----
         #----<<l_ooef113>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #160126-00007#3 Add By Ken 160215(S)
      INPUT BY NAME g_input.l_sale_qbe, g_input.l_gross_profit_qbe ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            IF NOT cl_null(g_input.l_sale_qbe) THEN
               LET g_input.l_sale_qbe_desc = adeq116_rtca001_ref(g_input.l_sale_qbe)
               DISPLAY BY NAME g_input.l_sale_qbe_desc
            END IF
            IF NOT cl_null(g_input.l_gross_profit_qbe) THEN
               LET g_input.l_gross_profit_desc = adeq116_rtca001_ref(g_input.l_gross_profit_qbe)
               DISPLAY BY NAME g_input.l_gross_profit_desc
            END IF
            
         AFTER FIELD l_sale_qbe
            IF NOT cl_null(g_input.l_sale_qbe) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_input.l_sale_qbe
               LET g_errshow = TRUE   #160318-00025#52
               LET g_chkparam.err_str[1] = "art-00050:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"    #160318-00025#52
               IF NOT cl_chk_exist("v_rtca001") THEN
                  LET g_input.l_sale_qbe = g_input_t.l_sale_qbe
                  LET g_input.l_sale_qbe_desc = adeq116_rtca001_ref(g_input.l_sale_qbe)
                  DISPLAY BY NAME  g_input.l_sale_qbe,g_input.l_sale_qbe_desc  
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_input.l_sale_qbe_desc = adeq116_rtca001_ref(g_input.l_sale_qbe)
            DISPLAY BY NAME  g_input.l_sale_qbe,g_input.l_sale_qbe_desc  
            
         AFTER FIELD l_gross_profit_qbe
            IF NOT cl_null(g_input.l_gross_profit_qbe) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_input.l_gross_profit_qbe
               LET g_errshow = TRUE   #160318-00025#52
               LET g_chkparam.err_str[1] = "art-00050:sub-01302|aimm200|",cl_get_progname("aimm200",g_lang,"2"),"|:EXEPROGaimm200"    #160318-00025#52         
               IF NOT cl_chk_exist("v_rtca001") THEN
                  LET g_input.l_gross_profit_qbe = g_input_t.l_gross_profit_qbe
                  LET g_input.l_gross_profit_desc = adeq116_rtca001_ref(g_input.l_gross_profit_qbe)
                  DISPLAY BY NAME  g_input.l_gross_profit_qbe,g_input.l_gross_profit_desc  
                  NEXT FIELD CURRENT
               END IF
            END IF
            LET g_input.l_gross_profit_desc = adeq116_rtca001_ref(g_input.l_gross_profit_qbe)
            DISPLAY BY NAME  g_input.l_gross_profit_qbe,g_input.l_gross_profit_desc  
         
         ON ACTION controlp INFIELD l_sale_qbe
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001()                          
            LET g_input.l_sale_qbe = g_qryparam.return1
            LET g_input.l_sale_qbe_desc = adeq116_rtca001_ref(g_input.l_sale_qbe)
            
            DISPLAY BY NAME  g_input.l_sale_qbe,g_input.l_sale_qbe_desc  
            
            NEXT FIELD l_sale_qbe 
            
         ON ACTION controlp INFIELD l_gross_profit_qbe
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            CALL q_rtca001()                          
            LET g_input.l_gross_profit_qbe = g_qryparam.return1
            LET g_input.l_gross_profit_desc = adeq116_rtca001_ref(g_input.l_gross_profit_qbe)
            DISPLAY g_input.l_gross_profit_qbe TO l_gross_profit_qbe
            DISPLAY g_input.l_gross_profit_desc TO l_gross_profit_desc 
            
            NEXT FIELD l_gross_profit_qbe          
      END INPUT
      
      BEFORE DIALOG
            DISPLAY g_site TO b_debssite  
            DISPLAY g_today - 1 TO b_debs002     
      #160126-00007#3 Add By Ken 160215(E)
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         #IF g_wc_table = " 1=1" THEN
         #   INITIALIZE g_errparam TO NULL 
         #   LET g_errparam.code   = 'ade-00140'
         #   LET g_errparam.popup  = TRUE 
         #   CALL cl_err()
         #   NEXT FIELD b_debs002
         #END IF
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
         #160126-00007#3 Add By Ken 160217 (S)
         INITIALIZE g_input.* TO NULL
         DISPLAY BY NAME  g_input.l_sale_qbe,g_input.l_sale_qbe_desc,
                          g_input.l_gross_profit_qbe, g_input.l_gross_profit_desc
         #160126-00007#3 Add By Ken 160217 (E)
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
   CALL adeq116_b_fill()
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
 
{<section id="adeq116.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq116_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_debssite_t    LIKE debs_t.debssite
   DEFINE l_debs005_t     LIKE debs_t.debs005   
   DEFINE l_success       LIKE type_t.num5
   
   #150916-00011#7 Add By Ken 151015(S) 調整效能
   DEFINE l_where_tmp         STRING               
   DEFINE ls_wc_tmp           STRING          
   DEFINE l_tmp_sql           STRING    
   DEFINE l_sys               LIKE type_t.num5
   DEFINE l_sdata_tmp         STRING
   DEFINE l_edata_tmp         STRING   
   DEFINE l_debssite          LIKE debs_t.debssite
   DEFINE l_debs002           LIKE debs_t.debs002
   DEFINE l_debsent           LIKE debs_t.debsent   
   DEFINE l_last_year_date    LIKE type_t.dat
   #150916-00011#7 Add By Ken 151015(E) 調整效能   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'debssite')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',debs002,debssite,'',debs005,'',debs016,'','','','',debs017,'', 
       '','',debs018,'','','','',debs012,'',debs019,'','',debs034,'','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY debs_t.debssite, 
       debs_t.debs002,debs_t.debs005) AS RANK FROM debs_t",
 
 
                     "",
                     " WHERE debsent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debs_t"),
                     " ORDER BY debs_t.debssite,debs_t.debs002,debs_t.debs005"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#2 20150915 s983961--mark and mod(s) 效能調整  
   #LET ls_sql_rank = "SELECT  UNIQUE 'N',debs002,debssite,t1.ooefl003 debssite_desc,debs005,t2.rtaxl003 debs005_desc,SUM(COALESCE(debs016,0)) debs016,'','','','',SUM(COALESCE(debs017,0)) debs017,'', 
   #    '','','','','','','',SUM(COALESCE(debs012,0)) debs012,'','','','','','','','','','','','','','',t3.ooef113 ooef113  ,DENSE_RANK() OVER( ORDER BY debs_t.debssite, 
   #    debs_t.debs002,debs_t.debs005) AS RANK ",
   #                  "  FROM debs_t",
   #                  "       LEFT OUTER JOIN ooefl_t t1 ON t1.ooeflent = debsent AND t1.ooefl001 = debssite AND t1.ooefl002 = '",g_dlang,"'",
   #                  "       LEFT OUTER JOIN rtaxl_t t2 ON t2.rtaxlent = debsent AND t2.rtaxl001 = debs005  AND t2.rtaxl002 = '",g_dlang,"'",
   #                  "       LEFT OUTER JOIN ooef_t  t3 ON t3.ooefent  = debsent AND t3.ooef001  = debssite ",
   #                  " WHERE debsent= ? AND 1=1 AND ", ls_wc,
   #                  "   AND debs035 = '1' ",   #debs_t 依debs035切成7個維度,在這邊要取debs035 ='1'的資料 才會是正確的
   #                  "   AND ",l_where
   # 
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debs_t"),
   #                  " GROUP BY debs002,debssite,t1.ooefl003,debs005,t2.rtaxl003,t3.ooef113",
   #                  " ORDER BY debs_t.debssite,debs_t.debs002,debs_t.debs005"
   
   #150916-00011#7 Modify By Ken 160303(S) 效能調整 debs035由原本取1改取8   
   #LET ls_sql_rank = "SELECT  UNIQUE 'N',debs002,debssite, ",
   #                   "                  (SELECT ooefl003 ",
   #                   "                     FROM ooefl_t ",
   #                   "                    WHERE ooeflent = debsent AND ooefl001 = debssite AND ooefl002 ='"||g_dlang||"') debssite_desc, ",
   #                   "                  debs005, ",
   #                   "                  (SELECT rtaxl003 ",
   #                   "                     FROM rtaxl_t ",
   #                   "                    WHERE rtaxlent = debsent AND rtaxl001 = debs005  AND rtaxl002 ='"||g_dlang||"') debs005_desc, ",
   #                   "                  debs016,'','','','',debs017,'', ", 
   #                   "                   '','','','','','','',debs012,  ",
   #                   "                   '','','','','','','', ",
   #                   "                   '','','','','','','', ",
   #                   "                  (SELECT ooef113 ",
   #                   "                     FROM ooef_t ",
   #                   "                    WHERE ooefent  = debsent AND ooef001  = debssite) ooef113, ",
   #                   " DENSE_RANK() OVER( ORDER BY debssite,debs002,debs005) AS RANK ",
   #    
   #                   "  FROM (SELECT  debs002,debssite,debs005,SUM(COALESCE(debs016,0)) debs016,SUM(COALESCE(debs017,0)) debs017, ", 
   #                   "                SUM(COALESCE(debs012,0)) debs012,debsent ",
   #                   "          FROM debs_t",
   #                   "         WHERE debsent= ? AND 1=1 AND ",ls_wc,
   #                   "           AND debs035 = '1'  ",   #debs_t 依debs035切成7個維度,在這邊要取debs035 ='1'的資料 才會是正確的
   #                   "         GROUP BY debs002,debssite,debs005,debsent) ",
   
   LET ls_sql_rank = "SELECT  UNIQUE 'N',debs002,debssite, ",
                      "                  (SELECT ooefl003 ",
                      "                     FROM ooefl_t ",
                      "                    WHERE ooeflent = debsent AND ooefl001 = debssite AND ooefl002 ='"||g_dlang||"') debssite_desc, ",
                      "                  debs005, ",
                      "                  (SELECT rtaxl003 ",
                      "                     FROM rtaxl_t ",
                      "                    WHERE rtaxlent = debsent AND rtaxl001 = debs005  AND rtaxl002 ='"||g_dlang||"') debs005_desc, ",
                      "                  debs016,'','','','',debs017,'', ", 
                      "                   '','','','','','','',debs012,  ",
                      "                   '',debs019,'','','','','', ",
                      "                   '','','','','','','', ",
                      "                  (SELECT ooef113 ",
                      "                     FROM ooef_t ",
                      "                    WHERE ooefent  = debsent AND ooef001  = debssite) ooef113, ",
                      " DENSE_RANK() OVER( ORDER BY debssite,debs002,debs005) AS RANK ",
       
                      "  FROM (SELECT  debs002,debssite,debs005,debs016,debs017, ", 
                      "                debs012,debsent,debs019 ",
                      "          FROM debs_t",
                      "         WHERE debsent= ? AND 1=1 AND ",ls_wc,
                      "           AND debs035 = '8')  ",   #debs_t 依debs035切成7個維度,在這邊要取debs035 ='1'的資料 才會是正確的
                      #"         GROUP BY debs002,debssite,debs005,debsent) ", 
   #150916-00011#7 Modify By Ken 160303(E) 效能調整 debs035由原本取1改取8                      
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("debs_t"),
                     
                     " ORDER BY debs002,debssite,debs005 "             
   #150826-00013#2 20150915 s983961--mark and mod(e) 效能調整    
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
 
   LET g_sql = "SELECT '',debs002,debssite,'',debs005,'',debs016,'','','','',debs017,'','','',debs018, 
       '','','','',debs012,'',debs019,'','',debs034,'','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150916-00011#7 Modify By Ken 160303(S) 效能調整
   #LET g_sql = "SELECT 'N',debs002,debssite,debssite_desc,debs005,debs005_desc,debs016,0,0,0,0,debs017,0,0,0,0, 
   #    0,0,0,0,debs012,0,0,0,0,0,0,0,0,0,0,0,0,0,0,ooef113",
   LET g_sql = "SELECT 'N',debs002,debssite,debssite_desc,debs005,debs005_desc,debs016,0,0,0,0,debs017,0,0,0,0, 
       0,0,0,0,debs012,0,debs019,0,0,0,0,0,0,0,0,0,0,0,0,ooef113",   
   #150916-00011#7 Modify By Ken 160303(E) 效能調整
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page,
              " ORDER BY debssite,debs002,debs005" 
   DISPLAY "g_wc:",g_wc
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq116_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq116_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_debs_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_debs2_d.clear()
   LET g_total_debs016    = 0 
   LET g_detail_cnt2 = 1   
   DELETE FROM adeq116_tmp01       #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
   
   #150916-00011#7 Mark By Ken 151015(S)
   #LET g_sql = "SELECT COUNT(rtjadocno) FROM rtja_t ",
   #            " WHERE rtjadocdt= ? ",
   #            "   AND rtjasite = ? ",
   #            "   AND EXISTS( SELECT 1 FROM rtjb_t ",
   #            "                        JOIN imaa_t ON imaa001 = rtjb004 ",
   #            "                                   AND imaa009 IN (SELECT rtaw002 FROM rtaw_t WHERE rtaw001 = ? ) ",
   #            "                WHERE  rtjaent=rtjbent AND rtjadocno = rtjbdocno ) "
   #150916-00011#7 Mark By Ken 151015(E)
   
   #20160204 Mark By Ken 效能測試(s)
   #150916-00011#7 Add By Ken 151015(S)
   ##取得今年查詢日期範圍
   #LET g_sql = "SELECT UNIQUE debsent,debssite,debs002 ",  
   #            "  FROM debs_t ",
   #            " WHERE debsent= ? ",
   #            "   AND 1=1 ",
   #            "   AND ",ls_wc,
   #            "   AND debs035 = '1'  ",   
   #            "   AND ", l_where
   #DELETE FROM adeq116_date_temp
   ##DISPLAY "g_sql:",g_sql               
   #LET l_tmp_sql = " INSERT INTO adeq116_date_temp ",g_sql               
   #PREPARE date_tmp_ins FROM l_tmp_sql
   #EXECUTE date_tmp_ins USING g_enterprise  
   ##取得去年查詢日期範圍
   #LET g_sql = " SELECT debsent,debssite,debs002 ",   
   #            "   FROM adeq116_date_temp "
   #PREPARE date_tmp_ins2 FROM g_sql   
   #DECLARE date_tmp_ins2_curs CURSOR FOR date_tmp_ins2   
   #FOREACH date_tmp_ins2_curs INTO l_debsent,l_debssite,l_debs002          
   #   LET l_last_year_date = MDY(MONTH(l_debs002),DAY(l_debs002),YEAR(l_debs002) - 1)
   #   IF NOT cl_null(l_last_year_date) THEN
   #      LET l_tmp_sql = " INSERT INTO adeq116_date_temp VALUES('",l_debsent,"','",l_debssite,"','",l_last_year_date,"')"   
   #      PREPARE date_tmp_ins3 FROM l_tmp_sql
   #      EXECUTE date_tmp_ins3
   #   END IF   
   #END FOREACH
   #   
   ##LET ls_wc_tmp = cl_replace_str(ls_wc,'debs002','rtjadocdt')
   ##LET ls_wc_tmp = cl_replace_str(ls_wc_tmp,'debs005','rtaw001')
   ##LET ls_wc_tmp = cl_replace_str(ls_wc_tmp,'debssite','rtjasite')    
   #CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級   
   #20160204 Mark By Ken 效能測試(e)
     
   #LET g_sql = " SELECT rtjaent,rtjasite,rtjadocdt,rtaw001,count(rtjadocno) debs019 ",
   #            "   FROM ( ",
   #            "         SELECT UNIQUE rtjaent,rtjasite,rtjadocno,rtjadocdt,rtaw001 ",
   #            "           FROM rtja_t,rtjb_t ",
   #            "                LEFT JOIN imaa_t ON imaaent = rtjbent AND imaa001 = rtjb004 ",
   #            "                LEFT JOIN rtaw_t ON rtawent = rtjbent AND rtaw002 = imaa009 ",
   #            "          WHERE rtjaent = rtjbent and rtjasite=rtjbsite and rtjadocno=rtjbdocno   ",
   #            "            AND rtjaent = ?  AND ", ls_wc_tmp, "AND rtaw003 = ",l_sys ," ) ",
   #            "          GROUP BY rtjaent,rtjasite,rtjadocdt,rtaw001 " 
      
   #LET g_sql = " SELECT rtjaent,         rtjasite,         rtjadocdt,         rtaw001,         COUNT(rtjadocno) debs019 ",
   #            "   FROM (SELECT UNIQUE rtjaent,            rtjasite,          rtjadocno,       rtjadocdt,       rtaw001 ",
   #            "           FROM (SELECT rtaw001, rtjbent, rtjbdocno ",
   #            "                   FROM (SELECT rtjbent,rtjbdocno,rtjb004 FROM rtjb_t), ",
   #            "                        (SELECT imaaent,imaa001,imaa009 FROM imaa_t) ",
   #            "                   LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 ",
   #            "                  WHERE rtjbent = imaaent ",
   #            "                    AND rtjb004 = imaa001 ",
   #            "                    AND rtaw003 = ",l_sys ," ), ",
   #            "                 rtja_t ",
   #            "          WHERE rtjbent = rtjaent ",
   #            "            AND rtjbdocno = rtjadocno ",
   #            "            AND rtjaent = ? ",
   #            "            AND EXISTS (SELECT 1 FROM adeq116_date_temp ",
   #            "                         WHERE rtjasite = debssite ",
   #            "                           AND rtjadocdt = debs002 ",
   #            "                           AND rtjaent = debsent) "," ) ",
   #            "  GROUP BY rtjaent,  rtjasite, rtjadocdt, rtaw001 "
   
   #亭如
   #LET g_sql = " SELECT rtjaent,rtjasite,rtjadocdt,rtaw001,count(rtjadocno) debs019 ",
   #            "   FROM ( ",
   #            "         SELECT UNIQUE rtjaent,rtjasite,rtjadocno,rtjadocdt,rtaw001 ",
   #            "           FROM rtja_t,rtjb_t,imaa_t ",
   #            #"                LEFT JOIN imaa_t ON imaaent = rtjbent AND imaa001 = rtjb004 ",
   #            "                LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 ",
   #            "          WHERE rtjaent = rtjbent ",
   #            "            AND rtjasite = rtjbsite ",
   #            "            AND rtjadocno = rtjbdocno ",
   #            "            AND rtjbent = imaaent ",
   #            "            AND rtjb004 = imaa001 ",
   #            "            AND rtjaent = ? ",
   #            "            AND EXISTS (SELECT 1 FROM adeq116_date_temp ",
   #            "                         WHERE rtjasite = debssite ",
   #            "                           AND rtjadocdt = debs002 ",
   #            "                           AND rtjaent = debsent) ",                
   #            "            AND rtaw003 = ",l_sys ," ) ",
   #            "          GROUP BY rtjaent,rtjasite,rtjadocdt,rtaw001 " 
   
   #20160204 Mark By Ken 效能測試(s)
   ##新版
   #LET g_sql = " SELECT rtjaent,rtjasite,rtjadocdt,rtaw001,count(rtjadocno) debs019 ",
   #            "   FROM ( ",
   #            "      SELECT UNIQUE rtjaent, rtjasite, rtjadocno, rtjadocdt, rtaw001 FROM ( ",
   #            "         SELECT rtjaent,rtjasite,rtjadocdt,rtjadocno,rtjb004 ",
   #            "           FROM (SELECT rtjaent,rtjasite,rtjadocdt,rtjadocno FROM rtja_t ",
   #            "          WHERE rtjaent = ? ",
   #            "            AND EXISTS (SELECT 1 FROM adeq116_date_temp ",
   #            "                         WHERE rtjasite = debssite ",
   #            "                           AND rtjadocdt = debs002 ",
   #            "                           AND rtjaent = debsent)   ),rtjb_t ",
   #            "          WHERE rtjaent = rtjbent ",
   #            "            AND rtjasite = rtjbsite ",
   #            "            AND rtjadocno = rtjbdocno )A ",
   #            "           LEFT JOIN imaa_t on imaaent = A.rtjaent AND imaa001 = A.rtjb004 ",
   #            "           LEFT JOIN rtaw_t ON rtawent = A.rtjaent AND rtaw002 = imaa009 ",
   #            "          WHERE rtaw003 = ",l_sys ," ) ",
   #            "  GROUP BY rtjaent,rtjasite,rtjadocdt,rtaw001 "   
   ##存到tmp table 
   #DELETE FROM adeq116_rtja_temp
   #DISPLAY "g_sql:",g_sql
   #LET l_tmp_sql = " INSERT INTO adeq116_rtja_temp ",g_sql
   #PREPARE rtja_tmp_ins FROM l_tmp_sql
   #DISPLAY "Start:",cl_get_timestamp()
   #EXECUTE rtja_tmp_ins USING g_enterprise    
   #DISPLAY "End:",cl_get_timestamp()
   #
   #LET g_sql = "SELECT debs019 FROM adeq116_rtja_temp ",
   #            " WHERE rtjaent = ",g_enterprise,
   #            "   AND rtjadocdt= ? ",
   #            "   AND rtjasite = ? ",
   #            "   AND rtaw001  = ? "
   ##150916-00011#7 Add By Ken 151015(E)
   #20160204 Mark By Ken 效能測試(e)
   
   #150916-00011#7 Mark By Ken 151015(S)
   #LET g_sql = "SELECT COUNT(rtjadocno) FROM rtja_t ",
   #            " WHERE rtjaent = ",g_enterprise,
   #            "   AND rtjadocdt= ? ",
   #            "   AND rtjasite = ? ",
   #            "   AND EXISTS( SELECT 1 FROM rtjb_t ",
   #            "                        JOIN imaa_t ON imaaent = rtjbent AND imaa001 = rtjb004 ",
   #            "                                   AND imaa009 IN (SELECT rtaw002 FROM rtaw_t WHERE rtaw001 = ? AND rtawent = ",g_enterprise," ) ",
   #            "                WHERE  rtjaent=rtjbent AND rtjasite = rtjbsite AND rtjadocno = rtjbdocno ) "   
   #150916-00011#7 Mark By Ken 151015(E)
   #150916-00011#7 Add By Ken 160303(S) 效能調整
   LET g_sql = " SELECT debs019 FROM debs_t ",
               "  WHERE debsent = ",g_enterprise,
               "    AND debs002 = ? ",
               "    AND debssite = ? ",
               "    AND debs005 = ? ",
               "    AND debs035 = '8' "
   PREPARE adeq116_debs019_cnt_prep FROM g_sql 
   #150916-00011#7 Add By Ken 160303(E) 效能調整   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_debs_d[l_ac].sel,g_debs_d[l_ac].debs002,g_debs_d[l_ac].debssite,g_debs_d[l_ac].debssite_desc, 
       g_debs_d[l_ac].debs005,g_debs_d[l_ac].debs005_desc,g_debs_d[l_ac].debs016,g_debs_d[l_ac].l_debs016_b, 
       g_debs_d[l_ac].l_debs016_r2,g_debs_d[l_ac].l_debs016_p,g_debs_d[l_ac].l_debs016_r3,g_debs_d[l_ac].debs017, 
       g_debs_d[l_ac].l_debs017_b,g_debs_d[l_ac].l_debs017_r1,g_debs_d[l_ac].l_debs017_p,g_debs_d[l_ac].debs018, 
       g_debs_d[l_ac].l_debs018_b,g_debs_d[l_ac].l_debs018_r1,g_debs_d[l_ac].l_debs018_p,g_debs_d[l_ac].l_debs018_r2, 
       g_debs_d[l_ac].debs012,g_debs_d[l_ac].l_debs012_p,g_debs_d[l_ac].debs019,g_debs_d[l_ac].l_debs019_p, 
       g_debs_d[l_ac].l_debs019_r1,g_debs_d[l_ac].debs034,g_debs_d[l_ac].l_debs034_p,g_debs_d[l_ac].l_debs034_r1, 
       g_debs_d[l_ac].l_stock_cost,g_debs_d[l_ac].l_stock_cost_p,g_debs_d[l_ac].l_self_sale,g_debs_d[l_ac].l_self_sale_p, 
       g_debs_d[l_ac].l_uni_sale,g_debs_d[l_ac].l_uni_sale_p,g_debs_d[l_ac].l_debs016_r1,g_debs_d[l_ac].l_ooef113 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_debs_d[l_ac].statepic = cl_get_actipic(g_debs_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      CALL adeq116_get_budget()
      
      #EXECUTE adeq116_debs019_cnt_prep USING g_debs_d[l_ac].debs002,g_debs_d[l_ac].debssite,g_debs_d[l_ac].debs005
      #   INTO g_debs_d[l_ac].debs019
      
      LET g_last_year_date = MDY(MONTH(g_debs_d[l_ac].debs002),DAY(g_debs_d[l_ac].debs002),YEAR(g_debs_d[l_ac].debs002) - 1)
            
      CALL adeq116_compute_number()
      
      
      CALL adeq116_ins_temp() RETURNING l_success       
      IF NOT l_success THEN
         RETURN
      END IF
      
      DISPLAY "number:",l_ac
      #end add-point
 
      CALL adeq116_detail_show("'1'")      
 
      CALL adeq116_debs_t_mask()
 
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
   
 
   
   CALL g_debs_d.deleteElement(g_debs_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #150716-00020#2 s98396l--add(debs002)
  LET g_sql = "SELECT MAX(debs002), ",
              "       debssite,                        debssite_desc,                  debs005,",
              "       debs005_desc,                    SUM(COALESCE(debs016,0)),       SUM(COALESCE(l_debs016_b,0)),",
              "       SUM(COALESCE(l_debs016_p,0)),    SUM(COALESCE(debs017,0)),       SUM(COALESCE(l_debs017_b,0)),",
              "       SUM(COALESCE(l_debs017_p,0)),    SUM(COALESCE(debs012,0)),       SUM(COALESCE(l_debs012_p,0)), ",
              "       SUM(COALESCE(debs019,0)),        SUM(COALESCE(l_debs019_p,0)),   SUM(COALESCE(l_stock_cost,0)),",
              "       SUM(COALESCE(l_stock_cost_p,0)), SUM(COALESCE(l_self_sale,0)),   SUM(COALESCE(l_self_sale_p,0)), ",
              "       SUM(COALESCE(l_uni_sale,0)),     SUM(COALESCE(l_uni_sale_p,0)),  l_ooef113 ",
              "  FROM adeq116_tmp01 ",            #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
              " GROUP BY debssite,debssite_desc,debs005,debs005_desc,l_ooef113",
              " ORDER BY debssite,debs005 "
              
   PREPARE adeq116_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR adeq116_pb2
   
   FOREACH b_fill_curs2 INTO g_maxdata,
                             g_debs2_d[g_detail_cnt2].debssite,       g_debs2_d[g_detail_cnt2].debssite_desc, g_debs2_d[g_detail_cnt2].debs005,
                             g_debs2_d[g_detail_cnt2].debs005_desc,   g_debs2_d[g_detail_cnt2].debs016,       g_debs2_d[g_detail_cnt2].l_debs016_b, 
                             g_debs2_d[g_detail_cnt2].l_debs016_p,    g_debs2_d[g_detail_cnt2].debs017,       g_debs2_d[g_detail_cnt2].l_debs017_b,
                             g_debs2_d[g_detail_cnt2].l_debs017_p,    g_debs2_d[g_detail_cnt2].debs012,       g_debs2_d[g_detail_cnt2].l_debs012_p,
                             g_debs2_d[g_detail_cnt2].debs019,        g_debs2_d[g_detail_cnt2].l_debs019_p,   g_debs2_d[g_detail_cnt2].l_stock_cost,
                             g_debs2_d[g_detail_cnt2].l_stock_cost_p, g_debs2_d[g_detail_cnt2].l_self_sale,   g_debs2_d[g_detail_cnt2].l_self_sale_p, 
                             g_debs2_d[g_detail_cnt2].l_uni_sale,     g_debs2_d[g_detail_cnt2].l_uni_sale_p,  g_debs2_d[g_detail_cnt2].l_ooef113 

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      

      LET g_debs2_d[g_detail_cnt2].l_debs016_r2 = 0
      LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = 0
      LET g_debs2_d[g_detail_cnt2].l_debs017_r1 = 0
      LET g_debs2_d[g_detail_cnt2].debs018      = 0   
      LET g_debs2_d[g_detail_cnt2].l_debs018_b  = 0 
      LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = 0
      LET g_debs2_d[g_detail_cnt2].l_debs018_p  = 0 
      LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = 0
      LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = 0 
      LET g_debs2_d[g_detail_cnt2].debs034      = 0
      LET g_debs2_d[g_detail_cnt2].l_debs034_p  = 0
      LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = 0
      LET g_debs2_d[g_detail_cnt2].l_debs016_r1 = 0
      LET g_last_year_date2 = MDY(MONTH(g_maxdata),DAY(g_maxdata),YEAR(g_maxdata) - 1)
      
      CALL adeq116_compute_g_debs2_d()
      
      IF g_detail_cnt2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err() 
         END IF
         EXIT FOREACH
      END IF
      
      LET g_detail_cnt2 = g_detail_cnt2 + 1
   END FOREACH 
   
   CALL g_debs2_d.deleteElement(g_debs2_d.getLength()) 
   
   IF g_total_debs016 > 0 THEN
      FOR l_i = 1 TO g_debs_d.getLength()
         LET g_debs_d[l_i].l_debs016_r1 = g_debs_d[l_i].debs016 / g_total_debs016 * 100
      END FOR
      FOR l_i = 1 TO g_debs2_d.getLength()
         LET g_debs2_d[l_i].l_debs016_r1 = g_debs2_d[l_i].debs016 / g_total_debs016 * 100
      END FOR
   END IF
   #150716-00020#3 2015/07/20 s983961--add(s)
   IF g_total_debs016=0  THEN 
      FOR l_i = 1 TO g_debs_d.getLength()
      CASE 
         WHEN g_debs_d[l_i].debs016 > 0
            LET g_debs_d[l_i].l_debs016_r1 = 100
         WHEN g_debs_d[l_i].debs016 = 0
            LET g_debs_d[l_i].l_debs016_r1 = 0
         WHEN g_debs_d[l_i].debs016 < 0
            LET g_debs_d[l_i].l_debs016_r1 = -100
      END CASE      
      END FOR
      
      FOR l_i = 1 TO g_debs2_d.getLength()
      CASE 
         WHEN g_debs2_d[l_i].debs016 > 0
            LET g_debs2_d[l_i].l_debs016_r1 = 100
         WHEN g_debs2_d[l_i].debs016 = 0
            LET g_debs2_d[l_i].l_debs016_r1 = 0
         WHEN g_debs2_d[l_i].debs016 < 0
            LET g_debs2_d[l_i].l_debs016_r1 = -100
      END CASE      
      END FOR
   END IF 
   #150716-00020#3 2015/07/20 s983961--add(e)   
    
   #end add-point
 
   LET g_detail_cnt = g_debs_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq116_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq116_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq116_detail_action_trans()
 
   IF g_debs_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq116_fetch()
   END IF
   
      CALL adeq116_filter_show('debs002','b_debs002')
   CALL adeq116_filter_show('debssite','b_debssite')
   CALL adeq116_filter_show('debs005','b_debs005')
   CALL adeq116_filter_show('debs016','b_debs016')
   CALL adeq116_filter_show('debs017','b_debs017')
   CALL adeq116_filter_show('debs018','b_debs018')
   CALL adeq116_filter_show('debs012','b_debs012')
   CALL adeq116_filter_show('debs019','b_debs019')
   CALL adeq116_filter_show('debs034','b_debs034')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   LET g_detail_cnt2 = g_debs2_d.getLength()
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq116_fetch()
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
 
{<section id="adeq116.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq116_detail_show(ps_page)
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
      #150826-00013#2 20150915 s983961--mark(s) 效能調整 
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_debs_d[l_ac].debssite
      #      LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_debs_d[l_ac].debssite_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_debs_d[l_ac].debssite_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_debs_d[l_ac].debs005
      #      LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_debs_d[l_ac].debs005_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_debs_d[l_ac].debs005_desc
      #150826-00013#2 20150915 s983961--mark(e) 效能調整 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq116_filter()
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
      CONSTRUCT g_wc_filter ON debs002,debssite,debs005,debs016,debs017,debs018,debs012,debs019,debs034 
 
                          FROM s_detail1[1].b_debs002,s_detail1[1].b_debssite,s_detail1[1].b_debs005, 
                              s_detail1[1].b_debs016,s_detail1[1].b_debs017,s_detail1[1].b_debs018,s_detail1[1].b_debs012, 
                              s_detail1[1].b_debs019,s_detail1[1].b_debs034
 
         BEFORE CONSTRUCT
                     DISPLAY adeq116_filter_parser('debs002') TO s_detail1[1].b_debs002
            DISPLAY adeq116_filter_parser('debssite') TO s_detail1[1].b_debssite
            DISPLAY adeq116_filter_parser('debs005') TO s_detail1[1].b_debs005
            DISPLAY adeq116_filter_parser('debs016') TO s_detail1[1].b_debs016
            DISPLAY adeq116_filter_parser('debs017') TO s_detail1[1].b_debs017
            DISPLAY adeq116_filter_parser('debs018') TO s_detail1[1].b_debs018
            DISPLAY adeq116_filter_parser('debs012') TO s_detail1[1].b_debs012
            DISPLAY adeq116_filter_parser('debs019') TO s_detail1[1].b_debs019
            DISPLAY adeq116_filter_parser('debs034') TO s_detail1[1].b_debs034
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_debs002>>----
         #Ctrlp:construct.c.filter.page1.b_debs002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs002
            #add-point:ON ACTION controlp INFIELD b_debs002 name="construct.c.filter.page1.b_debs002"
            
            #END add-point
 
 
         #----<<b_debssite>>----
         #Ctrlp:construct.c.filter.page1.b_debssite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debssite
            #add-point:ON ACTION controlp INFIELD b_debssite name="construct.c.filter.page1.b_debssite"
            #161006-00008#4 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debssite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_debssite
            NEXT FIELD b_debssite
            #161006-00008#4 by sakura add(E)
            #END add-point
 
 
         #----<<b_debssite_desc>>----
         #----<<b_debs005>>----
         #Ctrlp:construct.c.page1.b_debs005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs005
            #add-point:ON ACTION controlp INFIELD b_debs005 name="construct.c.filter.page1.b_debs005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debs005  #顯示到畫面上
            NEXT FIELD b_debs005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debs005_desc>>----
         #----<<b_debs016>>----
         #Ctrlp:construct.c.filter.page1.b_debs016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs016
            #add-point:ON ACTION controlp INFIELD b_debs016 name="construct.c.filter.page1.b_debs016"
            
            #END add-point
 
 
         #----<<l_debs016_b>>----
         #----<<l_debs016_r2>>----
         #----<<l_debs016_p>>----
         #----<<l_debs016_r3>>----
         #----<<b_debs017>>----
         #Ctrlp:construct.c.filter.page1.b_debs017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs017
            #add-point:ON ACTION controlp INFIELD b_debs017 name="construct.c.filter.page1.b_debs017"
            
            #END add-point
 
 
         #----<<l_debs017_b>>----
         #----<<l_debs017_r1>>----
         #----<<l_debs017_p>>----
         #----<<b_debs018>>----
         #Ctrlp:construct.c.filter.page1.b_debs018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs018
            #add-point:ON ACTION controlp INFIELD b_debs018 name="construct.c.filter.page1.b_debs018"
            
            #END add-point
 
 
         #----<<l_debs018_b>>----
         #----<<l_debs018_r1>>----
         #----<<l_debs018_p>>----
         #----<<l_debs018_r2>>----
         #----<<b_debs012>>----
         #Ctrlp:construct.c.filter.page1.b_debs012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs012
            #add-point:ON ACTION controlp INFIELD b_debs012 name="construct.c.filter.page1.b_debs012"
            
            #END add-point
 
 
         #----<<l_debs012_p>>----
         #----<<b_debs019>>----
         #Ctrlp:construct.c.filter.page1.b_debs019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs019
            #add-point:ON ACTION controlp INFIELD b_debs019 name="construct.c.filter.page1.b_debs019"
            
            #END add-point
 
 
         #----<<l_debs019_p>>----
         #----<<l_debs019_r1>>----
         #----<<b_debs034>>----
         #Ctrlp:construct.c.filter.page1.b_debs034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debs034
            #add-point:ON ACTION controlp INFIELD b_debs034 name="construct.c.filter.page1.b_debs034"
            
            #END add-point
 
 
         #----<<l_debs034_p>>----
         #----<<l_debs034_r1>>----
         #----<<l_stock_cost>>----
         #----<<l_stock_cost_p>>----
         #----<<l_self_sale>>----
         #----<<l_self_sale_p>>----
         #----<<l_uni_sale>>----
         #----<<l_uni_sale_p>>----
         #----<<l_debs016_r1>>----
         #----<<l_ooef113>>----
   
 
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
   
      CALL adeq116_filter_show('debs002','b_debs002')
   CALL adeq116_filter_show('debssite','b_debssite')
   CALL adeq116_filter_show('debs005','b_debs005')
   CALL adeq116_filter_show('debs016','b_debs016')
   CALL adeq116_filter_show('debs017','b_debs017')
   CALL adeq116_filter_show('debs018','b_debs018')
   CALL adeq116_filter_show('debs012','b_debs012')
   CALL adeq116_filter_show('debs019','b_debs019')
   CALL adeq116_filter_show('debs034','b_debs034')
 
    
   CALL adeq116_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq116_filter_parser(ps_field)
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
 
{<section id="adeq116.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq116_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq116_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.insert" >}
#+ insert
PRIVATE FUNCTION adeq116_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq116.modify" >}
#+ modify
PRIVATE FUNCTION adeq116_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq116_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.delete" >}
#+ delete
PRIVATE FUNCTION adeq116_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq116.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq116_detail_action_trans()
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
 
{<section id="adeq116.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq116_detail_index_setting()
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
            IF g_debs_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_debs_d.getLength() AND g_debs_d.getLength() > 0
            LET g_detail_idx = g_debs_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_debs_d.getLength() THEN
               LET g_detail_idx = g_debs_d.getLength()
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
 
{<section id="adeq116.mask_functions" >}
 &include "erp/ade/adeq116_mask.4gl"
 
{</section>}
 
{<section id="adeq116.other_function" readonly="Y" >}
#取出預算相關欄位值
PRIVATE FUNCTION adeq116_get_budget()
   DEFINE l_rtcd1    RECORD
            rtcd007    LIKE debs_t.debs016,
            rtcd008    LIKE debs_t.debs016,
            rtcd009    LIKE debs_t.debs016,
            rtcd010    LIKE debs_t.debs016,
            rtcd011    LIKE debs_t.debs016,
            rtcd012    LIKE debs_t.debs016,
            rtcd013    LIKE debs_t.debs016,
            rtcd014    LIKE debs_t.debs016,
            rtcd015    LIKE debs_t.debs016,
            rtcd016    LIKE debs_t.debs016,
            rtcd017    LIKE debs_t.debs016,
            rtcd018    LIKE debs_t.debs016,
            rtcd019    LIKE debs_t.debs016,
            rtcd020    LIKE debs_t.debs016,
            rtcd021    LIKE debs_t.debs016,
            rtcd022    LIKE debs_t.debs016,
            rtcd023    LIKE debs_t.debs016,
            rtcd024    LIKE debs_t.debs016,
            rtcd025    LIKE debs_t.debs016,
            rtcd026    LIKE debs_t.debs016,
            rtcd027    LIKE debs_t.debs016,
            rtcd028    LIKE debs_t.debs016,
            rtcd029    LIKE debs_t.debs016,
            rtcd030    LIKE debs_t.debs016,             
            rtcd031    LIKE debs_t.debs016,
            rtcd032    LIKE debs_t.debs016,
            rtcd033    LIKE debs_t.debs016,
            rtcd034    LIKE debs_t.debs016,
            rtcd035    LIKE debs_t.debs016,
            rtcd036    LIKE debs_t.debs016,
            rtcd037    LIKE debs_t.debs016
                    END RECORD
   DEFINE l_rtcd2    RECORD
            rtcd007    LIKE debs_t.debs016,
            rtcd008    LIKE debs_t.debs016,
            rtcd009    LIKE debs_t.debs016,
            rtcd010    LIKE debs_t.debs016,
            rtcd011    LIKE debs_t.debs016,
            rtcd012    LIKE debs_t.debs016,
            rtcd013    LIKE debs_t.debs016,
            rtcd014    LIKE debs_t.debs016,
            rtcd015    LIKE debs_t.debs016,
            rtcd016    LIKE debs_t.debs016,
            rtcd017    LIKE debs_t.debs016,
            rtcd018    LIKE debs_t.debs016,
            rtcd019    LIKE debs_t.debs016,
            rtcd020    LIKE debs_t.debs016,
            rtcd021    LIKE debs_t.debs016,
            rtcd022    LIKE debs_t.debs016,
            rtcd023    LIKE debs_t.debs016,
            rtcd024    LIKE debs_t.debs016,
            rtcd025    LIKE debs_t.debs016,
            rtcd026    LIKE debs_t.debs016,
            rtcd027    LIKE debs_t.debs016,
            rtcd028    LIKE debs_t.debs016,
            rtcd029    LIKE debs_t.debs016,
            rtcd030    LIKE debs_t.debs016,             
            rtcd031    LIKE debs_t.debs016,
            rtcd032    LIKE debs_t.debs016,
            rtcd033    LIKE debs_t.debs016,
            rtcd034    LIKE debs_t.debs016,
            rtcd035    LIKE debs_t.debs016,
            rtcd036    LIKE debs_t.debs016,
            rtcd037    LIKE debs_t.debs016
                    END RECORD
   DEFINE l_rtcd001    LIKE rtcd_t.rtcd001
   DEFINE l_rtcd005_1  LIKE rtcd_t.rtcd005     #預算銷售額的指標編號
   DEFINE l_rtcd005_2  LIKE rtcd_t.rtcd005     #預算毛利額的指標編號
   DEFINE l_day        LIKE type_t.num5
   
   #160126-00007#3 Mark By Ken 160215(S)
   #LET l_rtcd005_1 = '0001'  #暫時寫死   
   #LET l_rtcd005_2 = '0002'  #暫時寫死  
   #160126-00007#3 Mark By Ken 160215(E)
   
   #160126-00007#3 Add By Ken 160215(S)
   LET l_rtcd005_1 = g_input.l_sale_qbe
   LET l_rtcd005_2 = g_input.l_gross_profit_qbe
   #160126-00007#3 Add By Ken 160215(E)   
   
   LET l_rtcd001 = YEAR(g_debs_d[l_ac].debs002) * 100 + MONTH(g_debs_d[l_ac].debs002)          
              
   SELECT SUM(COALESCE(rtcd007,'0')),SUM(COALESCE(rtcd008,'0')),SUM(COALESCE(rtcd009,'0')),SUM(COALESCE(rtcd010,'0')),SUM(COALESCE(rtcd011,'0')),
          SUM(COALESCE(rtcd012,'0')),SUM(COALESCE(rtcd013,'0')),SUM(COALESCE(rtcd014,'0')),SUM(COALESCE(rtcd015,'0')),SUM(COALESCE(rtcd016,'0')),
          SUM(COALESCE(rtcd017,'0')),SUM(COALESCE(rtcd018,'0')),SUM(COALESCE(rtcd019,'0')),SUM(COALESCE(rtcd020,'0')),SUM(COALESCE(rtcd021,'0')),
          SUM(COALESCE(rtcd022,'0')),SUM(COALESCE(rtcd023,'0')),SUM(COALESCE(rtcd024,'0')),SUM(COALESCE(rtcd025,'0')),SUM(COALESCE(rtcd026,'0')),
          SUM(COALESCE(rtcd027,'0')),SUM(COALESCE(rtcd028,'0')),SUM(COALESCE(rtcd029,'0')),SUM(COALESCE(rtcd030,'0')),SUM(COALESCE(rtcd031,'0')),
          SUM(COALESCE(rtcd032,'0')),SUM(COALESCE(rtcd033,'0')),SUM(COALESCE(rtcd034,'0')),SUM(COALESCE(rtcd035,'0')),SUM(COALESCE(rtcd036,'0')),
          SUM(COALESCE(rtcd037,'0'))
     INTO l_rtcd1.*
     FROM rtcd_t
    WHERE rtcdent  = g_enterprise
      AND rtcdsite = g_debs_d[l_ac].debssite
      AND rtcd001  = l_rtcd001
      AND rtcd003  = g_debs_d[l_ac].debs005
      AND rtcd004  = '4'
      AND rtcd005  = l_rtcd005_1
      
   SELECT SUM(COALESCE(rtcd007,'0')),SUM(COALESCE(rtcd008,'0')),SUM(COALESCE(rtcd009,'0')),SUM(COALESCE(rtcd010,'0')),SUM(COALESCE(rtcd011,'0')),
          SUM(COALESCE(rtcd012,'0')),SUM(COALESCE(rtcd013,'0')),SUM(COALESCE(rtcd014,'0')),SUM(COALESCE(rtcd015,'0')),SUM(COALESCE(rtcd016,'0')),
          SUM(COALESCE(rtcd017,'0')),SUM(COALESCE(rtcd018,'0')),SUM(COALESCE(rtcd019,'0')),SUM(COALESCE(rtcd020,'0')),SUM(COALESCE(rtcd021,'0')),
          SUM(COALESCE(rtcd022,'0')),SUM(COALESCE(rtcd023,'0')),SUM(COALESCE(rtcd024,'0')),SUM(COALESCE(rtcd025,'0')),SUM(COALESCE(rtcd026,'0')),
          SUM(COALESCE(rtcd027,'0')),SUM(COALESCE(rtcd028,'0')),SUM(COALESCE(rtcd029,'0')),SUM(COALESCE(rtcd030,'0')),SUM(COALESCE(rtcd031,'0')),
          SUM(COALESCE(rtcd032,'0')),SUM(COALESCE(rtcd033,'0')),SUM(COALESCE(rtcd034,'0')),SUM(COALESCE(rtcd035,'0')),SUM(COALESCE(rtcd036,'0')),
          SUM(COALESCE(rtcd037,'0'))
     INTO l_rtcd2.*
     FROM rtcd_t
    WHERE rtcdent  = g_enterprise
      AND rtcdsite = g_debs_d[l_ac].debssite
      AND rtcd001  = l_rtcd001
      AND rtcd003  = g_debs_d[l_ac].debs005
      AND rtcd004  = '4'
      AND rtcd005  = l_rtcd005_2   
   
   
   LET l_day = DAY(g_debs_d[l_ac].debs002)
   
   CASE l_day
   
   
      WHEN 1 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd007
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd007
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd007 / l_rtcd1.rtcd007 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd007 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd007 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd007 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd007 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd007 / l_rtcd1.rtcd007 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
     WHEN 2 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd008
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd008   
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd008 / l_rtcd1.rtcd008 * 100   
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd008 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd008 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd008 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd008 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd008 / l_rtcd1.rtcd008 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
         
      WHEN 3 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd009
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd009
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd009 / l_rtcd1.rtcd009 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd009 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd009 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd009 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd009 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd009 / l_rtcd1.rtcd009 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 4 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd010
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd010
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd010 / l_rtcd1.rtcd010 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd010 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd010 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd010 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd010 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd010 / l_rtcd1.rtcd010 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 5 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd011
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd011
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd011 / l_rtcd1.rtcd011 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd011 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd011 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd011 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd011 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd011 / l_rtcd1.rtcd011 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 6 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd012
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd012
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd012 / l_rtcd1.rtcd012 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd012 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd012 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd012 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd012 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd012 / l_rtcd1.rtcd012 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 7 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd013
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd013
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd013 / l_rtcd1.rtcd013 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd013 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd013 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd013 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd013 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd013 / l_rtcd1.rtcd013 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 8 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd014
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd014
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd014 / l_rtcd1.rtcd014 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd014 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd014 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd014 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd014 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
           LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd014 / l_rtcd1.rtcd014 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 9 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd015
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd015
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd015 / l_rtcd1.rtcd015 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd015 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd015 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd015 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd015 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd015 / l_rtcd1.rtcd015 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 10 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd016
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd016
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd016 / l_rtcd1.rtcd016 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd016 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd016 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd016 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd016 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd016 / l_rtcd1.rtcd016 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 11 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd017
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd017
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd017 / l_rtcd1.rtcd017 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd017 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd017 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd017 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd017 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd017 / l_rtcd1.rtcd017 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 12 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd018
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd018
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd018 / l_rtcd1.rtcd018 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd018 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd018 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd018 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd018 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd018 / l_rtcd1.rtcd018 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 13 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd019
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd019
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd019 / l_rtcd1.rtcd019 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd019 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd019 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd019 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd019 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd019 / l_rtcd1.rtcd019 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 14 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd020
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd020
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd020 / l_rtcd1.rtcd020 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd020 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd020 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd020 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd020 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd020 / l_rtcd1.rtcd020 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 15 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd021
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd021
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd021 / l_rtcd1.rtcd021 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd021 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd021 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd021 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd021 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd021 / l_rtcd1.rtcd021 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 16 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd022
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd022
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd022 / l_rtcd1.rtcd022 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd022 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd022 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd022 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd022 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd022 / l_rtcd1.rtcd022 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 17 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd023
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd023
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd023 / l_rtcd1.rtcd023 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd023 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd023 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd023 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd023 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd023 / l_rtcd1.rtcd023 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 18 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd024
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd024
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd024 / l_rtcd1.rtcd024 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd024 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd024 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd024 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd024 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd024 / l_rtcd1.rtcd024 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 19 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd025
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd025
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd025 / l_rtcd1.rtcd025 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd025 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd025 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd025 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd025 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd025 / l_rtcd1.rtcd025 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 20 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd026
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd026
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd026 / l_rtcd1.rtcd026 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd026 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd026 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd026 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd026 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd026 / l_rtcd1.rtcd026 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 21 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd027
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd027
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd027 / l_rtcd1.rtcd027 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd027 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd027 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd027 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd027 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd027 / l_rtcd1.rtcd027 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 22 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd028
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd028
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd028 / l_rtcd1.rtcd028 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd028 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd028 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd028 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd028 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd028 / l_rtcd1.rtcd028 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 23 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd029
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd029
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd029 / l_rtcd1.rtcd029 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd029 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd029 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd029 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd029 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd029 / l_rtcd1.rtcd029 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 24 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd030
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd030
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd030 / l_rtcd1.rtcd030 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd030 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd030 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd030 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd030 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd030 / l_rtcd1.rtcd030 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 25 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd031
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd031
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd031 / l_rtcd1.rtcd031 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd031 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd031 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd031 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd031 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd031 / l_rtcd1.rtcd031 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 26 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd032
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd032
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd032 / l_rtcd1.rtcd032 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd032 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd032 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd032 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd032 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd032 / l_rtcd1.rtcd032 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 27 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd033
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd033
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd033 / l_rtcd1.rtcd033 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd033 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd033 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd033 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd033 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd033 / l_rtcd1.rtcd033 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 28 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd034
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd034
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd034 / l_rtcd1.rtcd034 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd034 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd034 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd034 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd034 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd034 / l_rtcd1.rtcd034 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 29 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd035
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd035
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd035 / l_rtcd1.rtcd035 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd035 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd035 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd035 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd035 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd035 / l_rtcd1.rtcd035 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 30 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd036
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd036
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd036 / l_rtcd1.rtcd036 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd036 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd036 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd036 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd036 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd036 / l_rtcd1.rtcd036 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
      WHEN 31 
         LET g_debs_d[l_ac].l_debs016_b = l_rtcd1.rtcd037
         LET g_debs_d[l_ac].l_debs017_b = l_rtcd2.rtcd037
         #LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd037 / l_rtcd1.rtcd037 * 100
         #150716-00020#3 2015/07/20 s983961--add(s)
         IF l_rtcd1.rtcd037 = 0  THEN
            CASE 
                WHEN l_rtcd2.rtcd037 > 0
                   LET g_debs_d[l_ac].l_debs018_b = 100
                WHEN l_rtcd2.rtcd037 = 0
                   LET g_debs_d[l_ac].l_debs018_b = 0
                WHEN l_rtcd2.rtcd037 < 0
                   LET g_debs_d[l_ac].l_debs018_b = -100
            END CASE      
         ELSE
            LET g_debs_d[l_ac].l_debs018_b = l_rtcd2.rtcd037 / l_rtcd1.rtcd037 * 100
         END IF     
         #150716-00020#3 2015/07/20 s983961--add(e)
   END CASE
   
   IF cl_null(g_debs_d[l_ac].l_debs016_b) THEN LET g_debs_d[l_ac].l_debs016_b = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_debs017_b) THEN LET g_debs_d[l_ac].l_debs017_b = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_debs018_b) THEN LET g_debs_d[l_ac].l_debs018_b = 0 END IF
   
   
END FUNCTION

PRIVATE FUNCTION adeq116_compute_number()
   
   IF g_debs_d[l_ac].debs019 = 0 THEN 
      LET g_debs_d[l_ac].debs034 = 0
   ELSE
      LET g_debs_d[l_ac].debs034 = g_debs_d[l_ac].debs016 / g_debs_d[l_ac].debs019
   END IF   

   IF g_debs_d[l_ac].debs016 = 0 THEN 
      #裴軍與QC均認為 當 應收金額為0時,此時的毛利率要給1
      CASE  
         WHEN g_debs_d[l_ac].debs017 > 0 
            LET g_debs_d[l_ac].debs018 = 1 * 100  
         WHEN g_debs_d[l_ac].debs017 = 0
            LET g_debs_d[l_ac].debs018 = 0
         WHEN g_debs_d[l_ac].debs017 < 0
            LET g_debs_d[l_ac].debs018 = -1 * 100  
      END CASE
   ELSE
      LET g_debs_d[l_ac].debs018 = g_debs_d[l_ac].debs017 / g_debs_d[l_ac].debs016 * 100
   END IF
      
   SELECT SUM(COALESCE(deba026,0)) INTO g_debs_d[l_ac].l_self_sale 
     FROM deba_t
    WHERE debaent  = g_enterprise
      AND debasite = g_debs_d[l_ac].debssite
      AND deba002  = g_debs_d[l_ac].debs002
      AND deba049  = '1'  
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs_d[l_ac].debs005)
                     
   IF cl_null(g_debs_d[l_ac].l_self_sale) THEN LET g_debs_d[l_ac].l_self_sale = 0 END IF
   
   SELECT SUM(COALESCE(deba026,0)) INTO g_debs_d[l_ac].l_uni_sale 
     FROM deba_t
    WHERE debaent  = g_enterprise
      AND debasite = g_debs_d[l_ac].debssite
      AND deba002  = g_debs_d[l_ac].debs002
      AND deba049  = '4'
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs_d[l_ac].debs005)
                     
   IF cl_null(g_debs_d[l_ac].l_uni_sale) THEN LET g_debs_d[l_ac].l_uni_sale = 0 END IF   
   
   IF NOT cl_null(g_last_year_date) THEN
      SELECT SUM(COALESCE(debs012,0)),SUM(COALESCE(debs016,0)),SUM(COALESCE(debs017,0))
        INTO g_debs_d[l_ac].l_debs012_p,g_debs_d[l_ac].l_debs016_p,g_debs_d[l_ac].l_debs017_p
        FROM debs_t
       WHERE debsent  = g_enterprise
         AND debssite = g_debs_d[l_ac].debssite
         AND debs002  = g_last_year_date
         AND debs005  = g_debs_d[l_ac].debs005
         
      #EXECUTE adeq116_debs019_cnt_prep USING  g_last_year_date,g_debs_d[l_ac].debssite,g_debs_d[l_ac].debs005
      #   INTO g_debs_d[l_ac].l_debs019_p      
     
      SELECT SUM(COALESCE(deba026,0)) INTO g_debs_d[l_ac].l_self_sale_p
        FROM deba_t
       WHERE debaent  = g_enterprise
         AND debasite = g_debs_d[l_ac].debssite
         AND deba002  = g_last_year_date
         AND deba016  = g_debs_d[l_ac].debs005
         AND deba049  = '1'  
      IF cl_null(g_debs_d[l_ac].l_self_sale_p) THEN LET g_debs_d[l_ac].l_self_sale_p = 0 END IF
      
      SELECT SUM(COALESCE(deba026,0)) INTO g_debs_d[l_ac].l_uni_sale_p
        FROM deba_t
       WHERE debaent  = g_enterprise
         AND debasite = g_debs_d[l_ac].debssite
         AND deba002  = g_last_year_date
         AND deba016  = g_debs_d[l_ac].debs005
         AND deba049  = '4'
      IF cl_null(g_debs_d[l_ac].l_uni_sale_p) THEN LET g_debs_d[l_ac].l_uni_sale_p = 0 END IF 
   END IF
   
   IF cl_null(g_debs_d[l_ac].l_debs012_p)   THEN LET g_debs_d[l_ac].l_debs012_p = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_debs016_p)   THEN LET g_debs_d[l_ac].l_debs016_p = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_debs017_p)   THEN LET g_debs_d[l_ac].l_debs017_p = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_debs019_p)   THEN LET g_debs_d[l_ac].l_debs019_p = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_self_sale_p) THEN LET g_debs_d[l_ac].l_self_sale_p = 0 END IF
   IF cl_null(g_debs_d[l_ac].l_uni_sale_p)  THEN LET g_debs_d[l_ac].l_uni_sale_p = 0 END IF
   
   IF g_debs_d[l_ac].l_debs019_p = 0 THEN 
      LET g_debs_d[l_ac].l_debs034_p = 0
   ELSE
      LET g_debs_d[l_ac].l_debs034_p = g_debs_d[l_ac].l_debs016_p / g_debs_d[l_ac].l_debs019_p
   END IF   

   IF g_debs_d[l_ac].l_debs016_p = 0 THEN 
      #裴軍與QC均認為 當 應收金額為0時,此時的毛利率要給1
      CASE 
         WHEN g_debs_d[l_ac].l_debs017_p  > 0 
            LET g_debs_d[l_ac].l_debs018_p = 1 * 100  
         WHEN g_debs_d[l_ac].l_debs017_p = 0
            LET g_debs_d[l_ac].l_debs018_p = 0
         WHEN g_debs_d[l_ac].l_debs017_p < 0
            LET g_debs_d[l_ac].l_debs018_p = -1 * 100  
      END CASE
   ELSE
      LET g_debs_d[l_ac].l_debs018_p = g_debs_d[l_ac].l_debs017_p / g_debs_d[l_ac].l_debs016_p * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs016_b = 0 THEN      
      CASE 
         WHEN g_debs_d[l_ac].debs016 > 0 
            LET g_debs_d[l_ac].l_debs016_r2 = 1 * 100 
         WHEN g_debs_d[l_ac].debs016 = 0 
            LET g_debs_d[l_ac].l_debs016_r2 = 0
         WHEN g_debs_d[l_ac].debs016 > 0 
            LET g_debs_d[l_ac].l_debs016_r2 = -1 * 100 
      END CASE
   ELSE
      LET g_debs_d[l_ac].l_debs016_r2 = g_debs_d[l_ac].debs016 / g_debs_d[l_ac].l_debs016_b * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs016_p = 0 THEN
      #LET g_debs_d[l_ac].l_debs016_r3 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs_d[l_ac].debs016 > 0
             LET g_debs_d[l_ac].l_debs016_r3 = 100
          WHEN g_debs_d[l_ac].debs016 = 0
             LET g_debs_d[l_ac].l_debs016_r3 = 0
          WHEN g_debs_d[l_ac].debs016 < 0
             LET g_debs_d[l_ac].l_debs016_r3 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)    
   ELSE 
      LET g_debs_d[l_ac].l_debs016_r3 = g_debs_d[l_ac].debs016 / g_debs_d[l_ac].l_debs016_p * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs019_p = 0 THEN
      #LET g_debs_d[l_ac].l_debs019_r1 = 0
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs_d[l_ac].debs019 > 0
             LET g_debs_d[l_ac].l_debs019_r1 = 100
          WHEN g_debs_d[l_ac].debs019 = 0
             LET g_debs_d[l_ac].l_debs019_r1 = 0
          WHEN g_debs_d[l_ac].debs019 < 0
             LET g_debs_d[l_ac].l_debs019_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)      
   ELSE
      LET g_debs_d[l_ac].l_debs019_r1 = g_debs_d[l_ac].debs019 / g_debs_d[l_ac].l_debs019_p * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs034_p = 0 THEN
      #LET g_debs_d[l_ac].l_debs034_r1 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs_d[l_ac].debs034 > 0
             LET g_debs_d[l_ac].l_debs034_r1 = 100
          WHEN g_debs_d[l_ac].debs034 = 0
             LET g_debs_d[l_ac].l_debs034_r1 = 0
          WHEN g_debs_d[l_ac].debs034 < 0
             LET g_debs_d[l_ac].l_debs034_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e) 
   ELSE
      LET g_debs_d[l_ac].l_debs034_r1 = g_debs_d[l_ac].debs034 / g_debs_d[l_ac].l_debs034_p * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs018_b = 0 THEN
      #LET g_debs_d[l_ac].l_debs018_r1 = 0
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs_d[l_ac].debs018 > 0
             LET g_debs_d[l_ac].l_debs018_r1 = 100
          WHEN g_debs_d[l_ac].debs018 = 0
             LET g_debs_d[l_ac].l_debs018_r1 = 0
          WHEN g_debs_d[l_ac].debs018 < 0
             LET g_debs_d[l_ac].l_debs018_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)       
   ELSE
      LET g_debs_d[l_ac].l_debs018_r1 = g_debs_d[l_ac].debs018 / g_debs_d[l_ac].l_debs018_b * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs018_p = 0 THEN
      #LET g_debs_d[l_ac].l_debs018_r2 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs_d[l_ac].debs018 > 0
             LET g_debs_d[l_ac].l_debs018_r2 = 100
          WHEN g_debs_d[l_ac].debs018 = 0
             LET g_debs_d[l_ac].l_debs018_r2 = 0
          WHEN g_debs_d[l_ac].debs018 < 0
             LET g_debs_d[l_ac].l_debs018_r2 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)     
   ELSE
      LET g_debs_d[l_ac].l_debs018_r2 = g_debs_d[l_ac].debs018 / g_debs_d[l_ac].l_debs018_p * 100
   END IF
   
   IF g_debs_d[l_ac].l_debs017_b = 0 THEN
      #裴軍認為 當 毛利預算額為0時,此時的毛利預算比要給1
      CASE  
         WHEN g_debs_d[l_ac].debs017 > 0 
            LET g_debs_d[l_ac].l_debs017_r1 = 1 * 100  
         WHEN g_debs_d[l_ac].debs017 = 0
            LET g_debs_d[l_ac].l_debs017_r1 = 0
         WHEN g_debs_d[l_ac].debs017 < 0
            LET g_debs_d[l_ac].l_debs017_r1 = -1 * 100  
      END CASE
   ELSE
      LET g_debs_d[l_ac].l_debs017_r1 = g_debs_d[l_ac].debs017 / g_debs_d[l_ac].l_debs017_b * 100
   END IF
   
      
   LET g_total_debs016 = g_total_debs016 + g_debs_d[l_ac].debs016
   
   ##150716-00020#2 15/07/20 s983961 庫存成本額(s)
   #當天庫存金額
   LET g_debs_d[l_ac].l_stock_cost = 0
   SELECT SUM(deba052) INTO g_debs_d[l_ac].l_stock_cost
     FROM deba_t
    WHERE debaent = g_enterprise 
      AND debasite = g_debs_d[l_ac].debssite
      AND deba002 = g_debs_d[l_ac].debs002    
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs_d[l_ac].debs005)        
   IF cl_null(g_debs_d[l_ac].l_stock_cost) THEN
   LET g_debs_d[l_ac].l_stock_cost = 0
   END IF  
  
   #去年庫存金額150716-00020#2 15/07/20 s983961
   LET g_debs_d[l_ac].l_stock_cost_p = 0   
   SELECT SUM(deba052) INTO g_debs_d[l_ac].l_stock_cost_p
     FROM deba_t
    WHERE debaent = g_enterprise 
      AND debasite = g_debs_d[l_ac].debssite
      AND deba002 = g_last_year_date
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs_d[l_ac].debs005)     
   IF cl_null(g_debs_d[l_ac].l_stock_cost_p) THEN
   LET g_debs_d[l_ac].l_stock_cost_p = 0
   END IF     
   ##150716-00020#2 15/07/20 s983961 庫存成本額(e)
      
END FUNCTION

PRIVATE FUNCTION adeq116_compute_g_debs2_d()
   
   IF g_detail_cnt2 = 0 THEN RETURN END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs016_b = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs018_b = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].l_debs017_b > 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_b = 100
          WHEN g_debs2_d[g_detail_cnt2].l_debs017_b = 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_b = 0
          WHEN g_debs2_d[g_detail_cnt2].l_debs017_b < 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_b = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)   
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs018_b = g_debs2_d[g_detail_cnt2].l_debs017_b / g_debs2_d[g_detail_cnt2].l_debs016_b * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].debs019 = 0 THEN 
      #LET g_debs2_d[g_detail_cnt2].debs034 = 0
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs016 > 0
             LET g_debs2_d[g_detail_cnt2].debs034 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs016 = 0
             LET g_debs2_d[g_detail_cnt2].debs034 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs016 < 0
             LET g_debs2_d[g_detail_cnt2].debs034 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)   
   ELSE
      LET g_debs2_d[g_detail_cnt2].debs034 = g_debs2_d[g_detail_cnt2].debs016 / g_debs2_d[g_detail_cnt2].debs019
   END IF   

   IF g_debs2_d[g_detail_cnt2].debs016 = 0 THEN 
      #裴軍與QC均認為 當 應收金額為0時,此時的毛利率要給1
      CASE 
         WHEN g_debs2_d[g_detail_cnt2].debs017 > 0 
            LET g_debs2_d[g_detail_cnt2].debs018 = 1 * 100  
         WHEN g_debs2_d[g_detail_cnt2].debs017 = 0
            LET g_debs2_d[g_detail_cnt2].debs018 = 0
         WHEN g_debs2_d[g_detail_cnt2].debs017 < 0
            LET g_debs2_d[g_detail_cnt2].debs018 = -1 * 100  
      END CASE
   ELSE
      LET g_debs2_d[g_detail_cnt2].debs018 = g_debs2_d[g_detail_cnt2].debs017 / g_debs2_d[g_detail_cnt2].debs016 * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs019_p = 0 THEN 
      #LET g_debs2_d[g_detail_cnt2].l_debs034_p = 0
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].l_debs016_p > 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_p = 100
          WHEN g_debs2_d[g_detail_cnt2].l_debs016_p = 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_p = 0
          WHEN g_debs2_d[g_detail_cnt2].l_debs016_p < 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_p = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)   
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs034_p = g_debs2_d[g_detail_cnt2].l_debs016_p / g_debs2_d[g_detail_cnt2].l_debs019_p
   END IF   

   IF g_debs2_d[g_detail_cnt2].l_debs016_p = 0 THEN 
      #裴軍與QC均認為 當 應收金額為0時,此時的毛利率要給1
      CASE 
         WHEN g_debs2_d[g_detail_cnt2].l_debs017_p > 0 
            LET g_debs2_d[g_detail_cnt2].l_debs018_p = 1 * 100  
         WHEN g_debs2_d[g_detail_cnt2].l_debs017_p = 0
            LET g_debs2_d[g_detail_cnt2].l_debs018_p = 0
         WHEN g_debs2_d[g_detail_cnt2].l_debs017_p < 0
            LET g_debs2_d[g_detail_cnt2].l_debs018_p = -1 * 100  
      END CASE
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs018_p = g_debs2_d[g_detail_cnt2].l_debs017_p / g_debs2_d[g_detail_cnt2].l_debs016_p * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs016_b = 0 THEN
      CASE 
         WHEN g_debs2_d[g_detail_cnt2].debs016 > 0 
            LET g_debs2_d[g_detail_cnt2].l_debs016_r2 = 1 * 100  
         WHEN g_debs2_d[g_detail_cnt2].debs016 = 0
            LET g_debs2_d[g_detail_cnt2].l_debs016_r2 = 0
         WHEN g_debs2_d[g_detail_cnt2].debs016 < 0
            LET g_debs2_d[g_detail_cnt2].l_debs016_r2 = -1 * 100  
      END CASE
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs016_r2 = g_debs2_d[g_detail_cnt2].debs016 / g_debs2_d[g_detail_cnt2].l_debs016_b * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs016_p = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs016 > 0
             LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs016 = 0
             LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs016 < 0
             LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)   
   ELSE 
      LET g_debs2_d[g_detail_cnt2].l_debs016_r3 = g_debs2_d[g_detail_cnt2].debs016 / g_debs2_d[g_detail_cnt2].l_debs016_p * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs019_p = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs019 > 0
             LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs019 = 0
             LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs019 < 0
             LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e)   
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs019_r1 = g_debs2_d[g_detail_cnt2].debs019 / g_debs2_d[g_detail_cnt2].l_debs019_p * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs034_p = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs034 > 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs034 = 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs034 < 0
             LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e) 
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs034_r1 = g_debs2_d[g_detail_cnt2].debs034 / g_debs2_d[g_detail_cnt2].l_debs034_p * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs018_b = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs018 > 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs018 = 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs018 < 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e) 
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs018_r1 = g_debs2_d[g_detail_cnt2].debs018 / g_debs2_d[g_detail_cnt2].l_debs018_b * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs018_p = 0 THEN
      #LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = 0 
      #150716-00020#3 2015/07/20 s983961--add(s)  
      CASE 
          WHEN g_debs2_d[g_detail_cnt2].debs018 > 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = 100
          WHEN g_debs2_d[g_detail_cnt2].debs018 = 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = 0
          WHEN g_debs2_d[g_detail_cnt2].debs018 < 0
             LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = -100
      END CASE         
      #150716-00020#3 2015/07/20 s983961--add(e) 
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs018_r2 = g_debs2_d[g_detail_cnt2].debs018 / g_debs2_d[g_detail_cnt2].l_debs018_p * 100
   END IF
   
   IF g_debs2_d[g_detail_cnt2].l_debs017_b = 0 THEN
      #裴軍認為 當 毛利預算額為0時,此時的毛利預算比要給1
      CASE 
         WHEN g_debs2_d[g_detail_cnt2].debs017 > 0 
            LET g_debs2_d[g_detail_cnt2].l_debs017_r1 = 1 * 100  
         WHEN g_debs2_d[g_detail_cnt2].debs017 = 0
            LET g_debs2_d[g_detail_cnt2].l_debs017_r1 = 0
         WHEN g_debs2_d[g_detail_cnt2].debs017 < 0
            LET g_debs2_d[g_detail_cnt2].l_debs017_r1 = -1 * 100  
      END CASE
   ELSE
      LET g_debs2_d[g_detail_cnt2].l_debs017_r1 = g_debs2_d[g_detail_cnt2].debs017 / g_debs2_d[g_detail_cnt2].l_debs017_b * 100
   END IF   
   
   ##150716-00020#2 15/07/20 s983961 庫存成本額(s)   
   #當天庫存金額
   LET g_debs2_d[g_detail_cnt2].l_stock_cost = 0
   SELECT SUM(deba052) INTO g_debs2_d[g_detail_cnt2].l_stock_cost
     FROM deba_t
    WHERE 
      debaent = g_enterprise 
      AND debasite = g_debs2_d[g_detail_cnt2].debssite
      AND deba002 = g_maxdata    
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs2_d[g_detail_cnt2].debs005)         
   IF cl_null(g_debs2_d[g_detail_cnt2].l_stock_cost) THEN
   LET g_debs2_d[g_detail_cnt2].l_stock_cost = 0
   END IF    
   #去年庫存金額150716-00020#2 15/07/20 s983961
   LET g_debs2_d[g_detail_cnt2].l_stock_cost_p = 0   
   SELECT SUM(deba052) INTO g_debs2_d[g_detail_cnt2].l_stock_cost_p
     FROM deba_t
    WHERE debaent = g_enterprise 
      AND debasite = g_debs2_d[g_detail_cnt2].debssite
      AND deba002 = g_last_year_date2
      AND EXISTS (SELECT 1 FROM rtaw_t
                   WHERE rtawent = debaent
                     AND rtaw002 = deba016
                     AND rtaw001 = g_debs2_d[g_detail_cnt2].debs005)       
   IF cl_null(g_debs2_d[g_detail_cnt2].l_stock_cost_p) THEN
   LET g_debs2_d[g_detail_cnt2].l_stock_cost_p = 0
   END IF      
   ##150716-00020#2 15/07/20 s983961 庫存成本額(e) 
END FUNCTION

PRIVATE FUNCTION adeq116_create_temp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   IF NOT adeq116_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   #150716-00020#2 s98396l--add(debs002)
   CREATE TEMP TABLE adeq116_tmp01(         #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
       debs002           LIKE debs_t.debs002, 
       debssite          LIKE debs_t.debssite, 
       debssite_desc     LIKE type_t.chr500, 
       debs005           LIKE debs_t.debs005, 
       debs005_desc      LIKE type_t.chr500, 
       debs016           LIKE debs_t.debs016, 
       l_debs016_b       LIKE type_t.num20_6, 
       l_debs016_p       LIKE type_t.num20_6, 
       debs017           LIKE debs_t.debs017, 
       l_debs017_b       LIKE type_t.num20_6, 
       l_debs017_p       LIKE type_t.num20_6, 
       debs012           LIKE debs_t.debs012, 
       l_debs012_p       LIKE type_t.num20_6, 
       debs019           LIKE debs_t.debs019, 
       l_debs019_p       LIKE type_t.num20_6, 
       l_stock_cost      LIKE type_t.num20_6, 
       l_stock_cost_p    LIKE type_t.num20_6, 
       l_self_sale       LIKE type_t.num20_6, 
       l_self_sale_p     LIKE type_t.num20_6, 
       l_uni_sale        LIKE type_t.num20_6, 
       l_uni_sale_p      LIKE type_t.num20_6, 
       l_ooef113         LIKE type_t.num20_6 
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create adeq116_tmp01'          #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adeq116_drop_temp()
   DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE

   DROP TABLE adeq116_tmp01            #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq116_tmp01'              #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adeq116_ins_temp()
   DEFINE r_success      LIKE type_t.num5
   
   LET r_success = TRUE
   #150716-00020#2 s98396l--add(debs002)
   INSERT INTO adeq116_tmp01( debs002,              #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
                                  debssite,      debssite_desc, debs005,      
                                  debs005_desc,  debs016,       l_debs016_b,
                                  l_debs016_p,   debs017,       l_debs017_b,
                                  l_debs017_p,   debs012,       l_debs012_p, 
                                  debs019,       l_debs019_p,   l_stock_cost,
                                  l_stock_cost_p,l_self_sale,   l_self_sale_p, 
                                  l_uni_sale,    l_uni_sale_p,  l_ooef113)
          VALUES(g_debs_d[l_ac].debs002,
                 g_debs_d[l_ac].debssite,       g_debs_d[l_ac].debssite_desc, g_debs_d[l_ac].debs005,      
                 g_debs_d[l_ac].debs005_desc,   g_debs_d[l_ac].debs016,       g_debs_d[l_ac].l_debs016_b,  
                 g_debs_d[l_ac].l_debs016_p,    g_debs_d[l_ac].debs017,       g_debs_d[l_ac].l_debs017_b,  
                 g_debs_d[l_ac].l_debs017_p,    g_debs_d[l_ac].debs012,       g_debs_d[l_ac].l_debs012_p,  
                 g_debs_d[l_ac].debs019,        g_debs_d[l_ac].l_debs019_p,   g_debs_d[l_ac].l_stock_cost, 
                 g_debs_d[l_ac].l_stock_cost_p, g_debs_d[l_ac].l_self_sale,   g_debs_d[l_ac].l_self_sale_p,
                 g_debs_d[l_ac].l_uni_sale,     g_debs_d[l_ac].l_uni_sale_p,  g_debs_d[l_ac].l_ooef113)
   
   IF SQLCA.SQLcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "INSERT adeq116_tmp01"      #160727-00019#10 Mod   adeq116_debs_temp -->adeq116_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF           
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 建立tmp table
# Memo...........:
# Usage..........: CALL adeq116_create_temp1()
# Date & Author..: 2015/10/23 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq116_create_temp1()
DEFINE r_success         LIKE type_t.num5 

   WHENEVER ERROR CONTINUE
   
   LET r_success = TRUE
   
   IF NOT adeq116_drop_temp1() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   CREATE TEMP TABLE adeq116_tmp02(        #160727-00019#10 Mod   adeq116_rtja_temp -->adeq116_tmp02
       rtjaent        LIKE rtja_t.rtjaent,
       rtjasite       LIKE rtja_t.rtjasite,                      
       rtjadocdt      LIKE rtja_t.rtjadocdt,
       rtaw001        LIKE rtaw_t.rtaw001,
       debs019        LIKE debs_t.debs019
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create adeq116_tmp02'        #160727-00019#10 Mod   adeq116_rtja_temp -->adeq116_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF       


   CREATE TEMP TABLE adeq116_tmp03(         #160727-00019#10 Mod   adeq116_date_temp -->adeq116_tmp03
       debsent        LIKE debs_t.debsent, 
       debssite       LIKE debs_t.debssite,                      
       debs002        LIKE debs_t.debs002
     )

   IF SQLCA.sqlcode != 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create adeq116_tmp03'           #160727-00019#10 Mod   adeq116_date_temp -->adeq116_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 刪除tmp table 
# Memo...........:
# Usage..........: CALL adeq116_drop_temp1()
# Date & Author..: 2015/10/23 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq116_drop_temp1()
DEFINE r_success          LIKE type_t.num5

   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   DROP TABLE adeq116_tmp02             #160727-00019#10 Mod   adeq116_rtja_temp -->adeq116_tmp02

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq116_tmp02'       #160727-00019#10 Mod   adeq116_rtja_temp -->adeq116_tmp02
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF   
   
   DROP TABLE adeq116_tmp03                     #160727-00019#10 Mod   adeq116_date_temp -->adeq116_tmp03

   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop adeq116_tmp03'    #160727-00019#10 Mod   adeq116_date_temp -->adeq116_tmp03
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF     

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 指標说明
# Memo...........:
# Usage..........: CALL adeq116_rtca001_ref(p_rtca001)
#                     RETURNING r_rtcal003
# Input parameter: p_rtca001      指標編號
# Return code....: rtcal003       指標說明
# Date & Author..: 2016/02/15 By Ken
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq116_rtca001_ref(p_rtca001)
DEFINE p_rtca001         LIKE rtca_t.rtca001
DEFINE r_rtcal003        LIKE rtcal_t.rtcal003
   
   LET r_rtcal003 = ''
   
   SELECT rtcal003 INTO r_rtcal003
     FROM rtcal_t
    WHERE rtcalent = g_enterprise
      AND rtcal001 = p_rtca001
      AND rtcal002 = g_dlang
      
   RETURN r_rtcal003
END FUNCTION

 
{</section>}
 
