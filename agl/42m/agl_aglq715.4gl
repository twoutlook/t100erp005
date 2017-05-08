#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq715.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-05-16 15:45:36), PR版次:0006(2016-10-24 09:47:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: aglq715
#+ Description: 應收付對象交易統計查詢
#+ Creator....: 01727(2015-03-06 14:22:10)
#+ Modifier...: 02599 -SD/PR- 06821
 
{</section>}
 
{<section id="aglq715.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151030  151030   By albireo  SQL擴散 修正
#160318-00025#44 2016/04/26  By 07959 將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160505-00007#10 2016/05/16  By 02599 程式优化，修改期末余额取值,
#                                     BUG修正，抓取'来源模组'资料,合计金额取值改用画面中设置金额合计,修正显示单身笔数
#                                     ‘单身汇总方式’去除‘1.账套+交易对象’，只可以为‘2.账套+交易对象+科目’
#160811-00039#3  2016/08/12  By 02599 账务中心开窗要限定为账务中心组织编号,修正单身资料抓取录入账务中心下法人资料对应有权限的账套资料 
#161021-00037#1  2016/10/24  By 06821 組織類型與職能開窗調整
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
PRIVATE TYPE type_g_glat_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glat001 LIKE glat_t.glat001, 
   glat002 LIKE glat_t.glat002, 
   glat004 LIKE glat_t.glat004, 
   glatcomp LIKE glat_t.glatcomp, 
   glatcomp_desc LIKE type_t.chr500, 
   glatld LIKE glat_t.glatld, 
   glatld_desc LIKE type_t.chr500, 
   glat003 LIKE glat_t.glat003, 
   glat005 LIKE glat_t.glat005, 
   glat005_desc LIKE type_t.chr500, 
   glat007 LIKE glat_t.glat007, 
   glat007_desc LIKE type_t.chr500, 
   glat100 LIKE glat_t.glat100, 
   l_glat103 LIKE type_t.num20_6, 
   glat103 LIKE glat_t.glat103, 
   glat104 LIKE glat_t.glat104, 
   l_glat104 LIKE type_t.num20_6, 
   l_glat113 LIKE type_t.num20_6, 
   glat113 LIKE glat_t.glat113, 
   glat114 LIKE glat_t.glat114, 
   l_glat114 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_master_m RECORD
      site       LIKE xrca_t.xrcasite,
      site_desc  LIKE ooefl_t.ooefl003,
      year       LIKE type_t.num5, 
      bmonth     LIKE type_t.num5, 
      emonth     LIKE type_t.num5, 
      check      LIKE type_t.chr1, 
      comb       LIKE type_t.chr1
       END RECORD

DEFINE g_master_m        type_g_master_m
DEFINE g_wc_xrcald       STRING
DEFINE g_wc_xrcacomp     STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glat_d
DEFINE g_master_t                   type_g_glat_d
DEFINE g_glat_d          DYNAMIC ARRAY OF type_g_glat_d
DEFINE g_glat_d_t        type_g_glat_d
 
      
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
 
{<section id="aglq715.main" >}
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
   CALL cl_ap_init("agl","")
 
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
   DECLARE aglq715_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq715_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq715_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq715 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq715_init()   
 
      #進入選單 Menu (="N")
      CALL aglq715_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq715
      
   END IF 
   
   CLOSE aglq715_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq715.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq715_init()
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
   LET g_master_m.year = NULL
   LET g_master_m.bmonth = NULL
   LET g_master_m.emonth = NULL

   CALL s_fin_create_account_center_tmp()
   CALL aglq715_create_tmp()

   CALL cl_set_combo_scc('b_glat003','8007')
   CALL cl_set_combo_scc('b_glat005','8035') 
   #end add-point
 
   CALL aglq715_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq715.default_search" >}
PRIVATE FUNCTION aglq715_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glatld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glat001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glat002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glat003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " glat004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " glat007 = '", g_argv[06], "' AND "
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
 
{<section id="aglq715.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq715_ui_dialog()
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
      CALL aglq715_b_fill()
   ELSE
      CALL aglq715_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glat_d.clear()
 
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
 
         CALL aglq715_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glat_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq715_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq715_detail_action_trans()
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
            CALL aglq715_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglq715_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aglq716
            LET g_action_choice="open_aglq716"
            IF cl_auth_chk_act("open_aglq716") THEN
               
               #add-point:ON ACTION open_aglq716 name="menu.open_aglq716"
               CALL aglq715_open()
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
               CALL aglq715_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq715_filter()
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
            CALL aglq715_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glat_d)
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
            CALL aglq715_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq715_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq715_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq715_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glat_d.getLength()
               LET g_glat_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glat_d.getLength()
               LET g_glat_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glat_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glat_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glat_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glat_d[li_idx].sel = "N"
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
 
{<section id="aglq715.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq715_query()
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
   CALL g_glat_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glatcomp,glatld,glat003,glat005,glat007,glat100
           FROM s_detail1[1].b_glatcomp,s_detail1[1].b_glatld,s_detail1[1].b_glat003,s_detail1[1].b_glat005, 
               s_detail1[1].b_glat007,s_detail1[1].b_glat100
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glat001>>----
         #----<<b_glat002>>----
         #----<<b_glat004>>----
         #----<<b_glatcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glatcomp
            #add-point:BEFORE FIELD b_glatcomp name="construct.b.page1.b_glatcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glatcomp
            
            #add-point:AFTER FIELD b_glatcomp name="construct.a.page1.b_glatcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glatcomp
            #add-point:ON ACTION controlp INFIELD b_glatcomp name="construct.c.page1.b_glatcomp"
            
            #END add-point
 
 
         #----<<glatcomp_desc>>----
         #----<<b_glatld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glatld
            #add-point:BEFORE FIELD b_glatld name="construct.b.page1.b_glatld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glatld
            
            #add-point:AFTER FIELD b_glatld name="construct.a.page1.b_glatld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glatld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glatld
            #add-point:ON ACTION controlp INFIELD b_glatld name="construct.c.page1.b_glatld"
            
            #END add-point
 
 
         #----<<glatld_desc>>----
         #----<<b_glat003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glat003
            #add-point:BEFORE FIELD b_glat003 name="construct.b.page1.b_glat003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glat003
            
            #add-point:AFTER FIELD b_glat003 name="construct.a.page1.b_glat003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat003
            #add-point:ON ACTION controlp INFIELD b_glat003 name="construct.c.page1.b_glat003"
            
            #END add-point
 
 
         #----<<b_glat005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glat005
            #add-point:BEFORE FIELD b_glat005 name="construct.b.page1.b_glat005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glat005
            
            #add-point:AFTER FIELD b_glat005 name="construct.a.page1.b_glat005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glat005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat005
            #add-point:ON ACTION controlp INFIELD b_glat005 name="construct.c.page1.b_glat005"
            
            #END add-point
 
 
         #----<<glat005_desc>>----
         #----<<b_glat007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glat007
            #add-point:BEFORE FIELD b_glat007 name="construct.b.page1.b_glat007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glat007
            
            #add-point:AFTER FIELD b_glat007 name="construct.a.page1.b_glat007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat007
            #add-point:ON ACTION controlp INFIELD b_glat007 name="construct.c.page1.b_glat007"
            
            #END add-point
 
 
         #----<<glat007_desc>>----
         #----<<b_glat100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glat100
            #add-point:BEFORE FIELD b_glat100 name="construct.b.page1.b_glat100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glat100
            
            #add-point:AFTER FIELD b_glat100 name="construct.a.page1.b_glat100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glat100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat100
            #add-point:ON ACTION controlp INFIELD b_glat100 name="construct.c.page1.b_glat100"
            
            #END add-point
 
 
         #----<<l_glat103>>----
         #----<<b_glat103>>----
         #----<<b_glat104>>----
         #----<<l_glat104>>----
         #----<<l_glat113>>----
         #----<<b_glat113>>----
         #----<<b_glat114>>----
         #----<<l_glat114>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_master_m.site,g_master_m.year,g_master_m.bmonth,g_master_m.emonth,g_master_m.check,g_master_m.comb
         FROM b_site,b_year,b_bmonth,b_emonth,b_check,b_comb ATTRIBUTE(WITHOUT DEFAULTS)

         #AFTER FIELD site  #161021-00037#1 mark 這裡應該改用b_site,才會檢核的到
         AFTER FIELD b_site #161021-00037#1 add
            LET g_master_m.site_desc = ''
            IF NOT cl_null(g_master_m.site) THEN
               INITIALIZE g_chkparam.* TO NULL
               LET g_chkparam.arg1 = g_master_m.site
               #161021-00037#1 --s mark
               #160318-00025#44  2016/04/26  by pengxin  add(S)
               #LET g_errshow = TRUE #是否開窗 
               #LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               #160318-00025#44  2016/04/26  by pengxin  add(E)
               #161021-00037#1 --e mark
               #IF NOT cl_chk_exist("v_ooef001") THEN     #161021-00037#1 mark
               IF NOT cl_chk_exist("v_ooef001_212") THEN  #161021-00037#1 add
                  LET g_master_m.site = ''
                  LET g_master_m.site_desc = ''
                  DISPLAY BY NAME g_master_m.site_desc,g_master_m.site
                  NEXT FIELD CURRENT
               END IF
               #160811-00039#3--mark--str--
#               CALL s_fin_account_center_sons_query('3',g_master_m.site,g_today,'1')
#               #取得帳務中心底下之組織範圍
#               CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    
#               CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
#               #取得帳務中心底下的帳套範圍   
#               CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#               CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald 
               #160811-00039#3--mark--end
               LET g_master_m.site_desc = s_desc_get_department_desc(g_master_m.site)
               DISPLAY BY NAME g_master_m.site_desc
            END IF

         ON ACTION controlp  INFIELD b_site               
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_master_m.site
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00039#3 add   #161021-00037#1 mark
            #CALL q_ooef001()   #161021-00037#1 mark
            CALL q_ooef001_46() #161021-00037#1 add
            LET g_master_m.site = g_qryparam.return1
            #160811-00039#3--mark--str--
#            CALL s_fin_account_center_sons_query('3',g_master_m.site,g_today,'1')
#            #取得帳務中心底下之組織範圍
#            CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
#            CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
#            #取得帳務中心底下的帳套範圍   
#            CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#            CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
            #160811-00039#3--mark--end
            LET g_master_m.site_desc = s_desc_get_department_desc(g_master_m.site)            
            CALL s_desc_get_department_desc(g_master_m.site) RETURNING g_master_m.site_desc
            DISPLAY BY NAME g_master_m.site,g_master_m.site_desc
            NEXT FIELD b_site

         ON CHANGE b_check
            CALL aglq715_entry()

         ON CHANGE b_comb
            CALL aglq715_entry()

      END INPUT

      BEFORE DIALOG
         CALL aglq715_def()
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
   CALL aglq715_get_data()
   #end add-point
        
   LET g_error_show = 1
   CALL aglq715_b_fill()
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
 
{<section id="aglq715.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq715_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_str           STRING
   DEFINE l_glaa004       LIKE glaa_t.glaa004
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_amt1          LIKE xrca_t.xrca108
   DEFINE l_amt2          LIKE xrca_t.xrca108
   DEFINE l_amt3          LIKE xrca_t.xrca108
   DEFINE l_amt4          LIKE xrca_t.xrca108
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glat001,glat002,glat004,glatcomp,'',glatld,'',glat003,glat005, 
       '',glat007,'',glat100,'',glat103,glat104,'','',glat113,glat114,''  ,DENSE_RANK() OVER( ORDER BY glat_t.glatld, 
       glat_t.glat001,glat_t.glat002,glat_t.glat003,glat_t.glat004,glat_t.glat007) AS RANK FROM glat_t", 
 
 
 
                     "",
                     " WHERE glatent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glat_t"),
                     " ORDER BY glat_t.glatld,glat_t.glat001,glat_t.glat002,glat_t.glat003,glat_t.glat004,glat_t.glat007"
 
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
 
   LET g_sql = "SELECT '',glat001,glat002,glat004,glatcomp,'',glatld,'',glat003,glat005,'',glat007,'', 
       glat100,'',glat103,glat104,'','',glat113,glat114,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET l_str = "glatcomp,'',glatld,'','',glat005,''" #160505-00007#10 mark
   LET l_str = "glatcomp,t1.ooefl003,glatld,t3.glaal002,glat003,glat005,t2.pmaal003" #160505-00007#10 add

   IF g_master_m.comb = '1' THEN
      LET l_str = l_str,",'',''"
   ELSE
#      LET l_str = l_str,",glat007,''"   #160505-00007#10 mark
      LET l_str = l_str,",glat007,t4.glacl004"  #160505-00007#10 add
   END IF

   IF g_master_m.check = 'Y' THEN
      LET l_str = l_str,",glat100"
   ELSE
      LET l_str = l_str,",''"
   END IF

   LET g_sql = "SELECT '','','','',",l_str CLIPPED,",SUM(glat1030),SUM(glat103),SUM(glat104),SUM(glat1041),SUM(glat1130),SUM(glat113),SUM(glat114),SUM(glat1141)",
               "  FROM aglq715_tmp",
               #160505-00007#10--add--str--
               "  LEFT JOIN ooefl_t t1 ON t1.ooeflent=",g_enterprise," AND t1.ooefl001=glatcomp AND t1.ooefl002='",g_dlang,"'",
               "  LEFT JOIN pmaal_t t2 ON t2.pmaalent=",g_enterprise," AND t2.pmaal001=glat005 AND t2.pmaal002='",g_dlang,"'",
               "  LEFT JOIN glaal_t t3 ON t3.glaalent=",g_enterprise," AND t3.glaalld=glatld AND t3.glaal001='",g_dlang,"'",
               "  LEFT JOIN (SELECT glaald,glac002,glacl004 ",
               "               FROM glaa_t,glac_t LEFT JOIN glacl_t ON glacent=glaclent AND glac001=glacl001 AND glac002=glacl002 AND glacl003='",g_dlang,"'",
               "              WHERE glaaent=glacent AND glaa004=glac001 AND glacent=",g_enterprise,
               "            )t4 ON t4.glaald=glatld AND t4.glac002=glat007",
               #160505-00007#10--add--end
               " WHERE 1=1 AND ",ls_wc CLIPPED,
               "   AND glatent = ?",
               " GROUP BY ",l_str,
               " ORDER BY ",l_str
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq715_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq715_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glat_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glat_d[l_ac].sel,g_glat_d[l_ac].glat001,g_glat_d[l_ac].glat002,g_glat_d[l_ac].glat004, 
       g_glat_d[l_ac].glatcomp,g_glat_d[l_ac].glatcomp_desc,g_glat_d[l_ac].glatld,g_glat_d[l_ac].glatld_desc, 
       g_glat_d[l_ac].glat003,g_glat_d[l_ac].glat005,g_glat_d[l_ac].glat005_desc,g_glat_d[l_ac].glat007, 
       g_glat_d[l_ac].glat007_desc,g_glat_d[l_ac].glat100,g_glat_d[l_ac].l_glat103,g_glat_d[l_ac].glat103, 
       g_glat_d[l_ac].glat104,g_glat_d[l_ac].l_glat104,g_glat_d[l_ac].l_glat113,g_glat_d[l_ac].glat113, 
       g_glat_d[l_ac].glat114,g_glat_d[l_ac].l_glat114
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glat_d[l_ac].statepic = cl_get_actipic(g_glat_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
#160505-00007#10--mark--str--
#      #說明欄位填充
#      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_glat_d[l_ac].glatld
#      CALL s_axrt300_xrca_ref('xrcasite',g_glat_d[l_ac].glatcomp,'','') RETURNING l_success,g_glat_d[l_ac].glatcomp_desc
#      CALL s_axrt300_xrca_ref('xrcald'  ,g_glat_d[l_ac].glatld  ,'','') RETURNING l_success,g_glat_d[l_ac].glatld_desc
#      CALL s_axrt300_xrca_ref('xrca004' ,g_glat_d[l_ac].glat005 ,'','') RETURNING l_success,g_glat_d[l_ac].glat005_desc
#      CALL s_axrt300_xrca_ref('xrca035' ,g_glat_d[l_ac].glat007 ,l_glaa004,'') RETURNING l_success,g_glat_d[l_ac].glat007_desc


#      LET l_flag1 = '1'
#      SELECT glac008 INTO l_flag1 FROM glac_t,glaa_t WHERE glacent = glaaent AND glacent = g_enterprise
#         AND glaa004 = glac001
#         AND glac002 = g_glat_d[l_ac].glat007
#         AND glaald  = g_glat_d[l_ac].glatld

#      IF l_flag1 = '1' THEN
#        LET g_glat_d[l_ac].l_glat104 = g_glat_d[l_ac].l_glat103 + g_glat_d[l_ac].glat103 - g_glat_d[l_ac].glat104
#        LET g_glat_d[l_ac].l_glat114 = g_glat_d[l_ac].l_glat113 + g_glat_d[l_ac].glat113 - g_glat_d[l_ac].glat114
#      ELSE
#        LET g_glat_d[l_ac].l_glat104 = g_glat_d[l_ac].l_glat103 + g_glat_d[l_ac].glat104 - g_glat_d[l_ac].glat103
#        LET g_glat_d[l_ac].l_glat114 = g_glat_d[l_ac].l_glat113 + g_glat_d[l_ac].glat114 - g_glat_d[l_ac].glat113
#      END IF

#      #小計
#      LET l_amt1 = l_amt1 + g_glat_d[l_ac].l_glat113
#      LET l_amt2 = l_amt2 + g_glat_d[l_ac].glat113
#      LET l_amt3 = l_amt3 + g_glat_d[l_ac].glat114
#      LET l_amt4 = l_amt4 + g_glat_d[l_ac].l_glat114
#160505-00007#10--mark--end
      #end add-point
 
      CALL aglq715_detail_show("'1'")      
 
      CALL aglq715_glat_t_mask()
 
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
   
 
   
   CALL g_glat_d.deleteElement(g_glat_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
#160505-00007#10--mark--str--
#   #小計
#   INITIALIZE g_glat_d[l_ac].* TO NULL
#   LET g_glat_d[l_ac].glat005_desc = "合计:"
#   LET g_glat_d[l_ac].l_glat113 = l_amt1
#   LET g_glat_d[l_ac].glat113   = l_amt2
#   LET g_glat_d[l_ac].glat114   = l_amt3
#   LET g_glat_d[l_ac].l_glat114 = l_amt4
#160505-00007#10--mark--end
   LET g_tot_cnt = g_glat_d.getLength()  #160505-00007#10 add
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glat_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq715_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq715_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq715_detail_action_trans()
 
   IF g_glat_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq715_fetch()
   END IF
   
      CALL aglq715_filter_show('glatcomp','b_glatcomp')
   CALL aglq715_filter_show('glatld','b_glatld')
   CALL aglq715_filter_show('glat003','b_glat003')
   CALL aglq715_filter_show('glat005','b_glat005')
   CALL aglq715_filter_show('glat007','b_glat007')
   CALL aglq715_filter_show('glat100','b_glat100')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq715_fetch()
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
 
{<section id="aglq715.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq715_detail_show(ps_page)
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
 
{<section id="aglq715.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq715_filter()
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
      CONSTRUCT g_wc_filter ON glatcomp,glatld,glat003,glat005,glat007,glat100
                          FROM s_detail1[1].b_glatcomp,s_detail1[1].b_glatld,s_detail1[1].b_glat003, 
                              s_detail1[1].b_glat005,s_detail1[1].b_glat007,s_detail1[1].b_glat100
 
         BEFORE CONSTRUCT
                     DISPLAY aglq715_filter_parser('glatcomp') TO s_detail1[1].b_glatcomp
            DISPLAY aglq715_filter_parser('glatld') TO s_detail1[1].b_glatld
            DISPLAY aglq715_filter_parser('glat003') TO s_detail1[1].b_glat003
            DISPLAY aglq715_filter_parser('glat005') TO s_detail1[1].b_glat005
            DISPLAY aglq715_filter_parser('glat007') TO s_detail1[1].b_glat007
            DISPLAY aglq715_filter_parser('glat100') TO s_detail1[1].b_glat100
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glat001>>----
         #----<<b_glat002>>----
         #----<<b_glat004>>----
         #----<<b_glatcomp>>----
         #Ctrlp:construct.c.filter.page1.b_glatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glatcomp
            #add-point:ON ACTION controlp INFIELD b_glatcomp name="construct.c.filter.page1.b_glatcomp"
            
            #END add-point
 
 
         #----<<glatcomp_desc>>----
         #----<<b_glatld>>----
         #Ctrlp:construct.c.filter.page1.b_glatld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glatld
            #add-point:ON ACTION controlp INFIELD b_glatld name="construct.c.filter.page1.b_glatld"
            
            #END add-point
 
 
         #----<<glatld_desc>>----
         #----<<b_glat003>>----
         #Ctrlp:construct.c.filter.page1.b_glat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat003
            #add-point:ON ACTION controlp INFIELD b_glat003 name="construct.c.filter.page1.b_glat003"
            
            #END add-point
 
 
         #----<<b_glat005>>----
         #Ctrlp:construct.c.filter.page1.b_glat005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat005
            #add-point:ON ACTION controlp INFIELD b_glat005 name="construct.c.filter.page1.b_glat005"
            
            #END add-point
 
 
         #----<<glat005_desc>>----
         #----<<b_glat007>>----
         #Ctrlp:construct.c.filter.page1.b_glat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat007
            #add-point:ON ACTION controlp INFIELD b_glat007 name="construct.c.filter.page1.b_glat007"
            
            #END add-point
 
 
         #----<<glat007_desc>>----
         #----<<b_glat100>>----
         #Ctrlp:construct.c.filter.page1.b_glat100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glat100
            #add-point:ON ACTION controlp INFIELD b_glat100 name="construct.c.filter.page1.b_glat100"
            
            #END add-point
 
 
         #----<<l_glat103>>----
         #----<<b_glat103>>----
         #----<<b_glat104>>----
         #----<<l_glat104>>----
         #----<<l_glat113>>----
         #----<<b_glat113>>----
         #----<<b_glat114>>----
         #----<<l_glat114>>----
   
 
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
   
      CALL aglq715_filter_show('glatcomp','b_glatcomp')
   CALL aglq715_filter_show('glatld','b_glatld')
   CALL aglq715_filter_show('glat003','b_glat003')
   CALL aglq715_filter_show('glat005','b_glat005')
   CALL aglq715_filter_show('glat007','b_glat007')
   CALL aglq715_filter_show('glat100','b_glat100')
 
    
   CALL aglq715_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq715_filter_parser(ps_field)
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
 
{<section id="aglq715.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq715_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq715_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.insert" >}
#+ insert
PRIVATE FUNCTION aglq715_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq715.modify" >}
#+ modify
PRIVATE FUNCTION aglq715_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq715_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.delete" >}
#+ delete
PRIVATE FUNCTION aglq715_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq715.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq715_detail_action_trans()
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
 
{<section id="aglq715.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq715_detail_index_setting()
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
            IF g_glat_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glat_d.getLength() AND g_glat_d.getLength() > 0
            LET g_detail_idx = g_glat_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glat_d.getLength() THEN
               LET g_detail_idx = g_glat_d.getLength()
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
 
{<section id="aglq715.mask_functions" >}
 &include "erp/agl/aglq715_mask.4gl"
 
{</section>}
 
{<section id="aglq715.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 給予預設值
# Memo...........:
# Usage..........: CALL aglq715_def()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq715_def()

   IF cl_null(g_master_m.site) THEN
      LET g_master_m.site = g_site   
      LET g_master_m.site_desc = s_desc_get_department_desc(g_master_m.site)
   END IF
   IF cl_null(g_master_m.check) THEN
      LET g_master_m.check = 'Y'
   END IF
   IF cl_null(g_master_m.comb) THEN
#      LET g_master_m.comb = '1'  #160505-00007#10 mark
      LET g_master_m.comb = '2'   #160505-00007#10 add
   END IF
   CALL cl_set_comp_entry('b_comb',FALSE) #160505-00007#10 add
   CALL aglq715_entry()
   IF cl_null(g_master_m.year) THEN
      LET g_master_m.year = YEAR(g_today)
      LET g_master_m.bmonth = MONTH(g_today)
      LET g_master_m.emonth = MONTH(g_today)
   END IF
   #160811-00039#3--mark--str--
#   CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
#   #取得帳務中心底下之組織範圍
#   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
#   CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp
#   #取得帳務中心底下的帳套範圍   
#   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald
#   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald
   #160811-00039#3--mark--end
   
   DISPLAY BY NAME g_master_m.site,g_master_m.site_desc,g_master_m.comb,
                   g_master_m.year,g_master_m.bmonth,g_master_m.emonth,g_master_m.check

END FUNCTION

################################################################################
# Descriptions...: 欄位顯示
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
PRIVATE FUNCTION aglq715_entry()

   IF NOT cl_null(g_master_m.check) THEN
      IF g_master_m.check = 'Y' THEN
         CALL cl_set_comp_visible('b_glat100,l_glat103,b_glat103,b_glat104,l_glat104',TRUE)
      ELSE
         CALL cl_set_comp_visible('b_glat100,l_glat103,b_glat103,b_glat104,l_glat104',FALSE)
      END IF
   END IF

   IF NOT cl_null(g_master_m.comb) THEN
      IF g_master_m.comb = '2' THEN
         CALL cl_set_comp_visible('b_glat007,glat007_desc',TRUE)
      ELSE
         CALL cl_set_comp_visible('b_glat007,glat007_desc',FALSE)
      END IF
   END IF

END FUNCTION
################################################################################
# Descriptions...: 建立臨時表
# Memo...........:
# Usage..........: CALL aglq715_create_tmp()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq715_create_tmp()

   DROP TABLE aglq715_tmp;
   CREATE TEMP TABLE aglq715_tmp(
      glatcomp        VARCHAR(10),       
      glatld          VARCHAR(5), 
      glat003         VARCHAR(10),
      glat005         VARCHAR(10),
      glat007         VARCHAR(24),
      glat100         VARCHAR(10),
      glat1030        DECIMAL(20,6),
      glat103         DECIMAL(20,6),
      glat104         DECIMAL(20,6),
      glat1041        DECIMAL(20,6),
      glat1130        DECIMAL(20,6),
      glat113         DECIMAL(20,6),
      glat114         DECIMAL(20,6),
      glat1141        DECIMAL(20,6),
      glatent         SMALLINT
         )

END FUNCTION
################################################################################
# Descriptions...: 將符合條件的資料存入臨時表
# Memo...........:
# Usage..........: CALL aglq715_get_data()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/03/04 By 01727
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq715_get_data()
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_wc            STRING  #160811-00039#3 add
   DEFINE l_ld_str        STRING  #160811-00039#3 add
   
   DELETE FROM aglq715_tmp

   CALL s_fin_account_center_sons_query('3',g_master_m.site,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_xrcacomp    #150127-00007#1 add
   CALL s_fin_get_wc_str(g_wc_xrcacomp) RETURNING g_wc_xrcacomp              
   #取得帳務中心底下的帳套範圍   
#   CALL s_fin_account_center_ld_str() RETURNING g_wc_xrcald #160811-00039#3 mark
#   CALL s_fin_get_wc_str(g_wc_xrcald) RETURNING g_wc_xrcald #160811-00039#3 mark
   #160811-00039#3--add--str--
   LET l_wc=g_wc_xrcacomp.substring(3,g_wc_xrcacomp.getLength()-2)
   #账套范围
   CALL s_axrt300_get_site(g_user,l_wc,'2')  RETURNING l_ld_str 
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","glatld")
   IF cl_null(l_ld_str) THEN   
      LET l_ld_str = " 1=1 "
   END IF
   #160811-00039#3--add--end

   #STEP1:將期初餘額匯入臨時表
   LET g_sql = "   INSERT INTO aglq715_tmp                                                                  ",
               "   SELECT glatcomp,glatld,glat003,glat005,glat007,glat100,                                  ",
               "          SUM (CASE WHEN glac008 = 1 THEN glat103 - glat104 ELSE glat104 - glat103 END),0,0,0,",
               "          SUM (CASE WHEN glac008 = 1 THEN glat113 - glat114 ELSE glat114 - glat113 END),0,0,0,",
               "          glatent                                                                             ",
               "     FROM glat_t,glac_t,glaa_t                                                              ",  
               "    WHERE     glatld = glaald                     AND glatent = glacent                     ",
               "          AND glat001 = '",g_master_m.year,"'              AND glat002 < '",g_master_m.bmonth,"'               ",
               "          AND glatent = glaaent                   AND glatent = '",g_enterprise,"'          ",
               "          AND glac002 = glat007                   AND glaa004 = glac001                     ",
#               "          AND glatld IN ",g_wc_xrcald CLIPPED , #160811-00039#3 mark
               "          AND ",l_ld_str,  #160811-00039#3 add
               " GROUP BY glatcomp,glatld,glat003,glat005,glat007,glat100,glatent                            "  
   PREPARE aglq715_tmp01 FROM g_sql
   EXECUTE aglq715_tmp01

   #STEP2:將本期異動匯入臨時表
   
   
   #本期異動
   
   #albireo 151030-----s
#   LET g_sql = "   INSERT INTO aglq715_tmp                               ",
#               "   SELECT glatcomp,glatld,glat003,glat005,glat007,glat100,             ",   
#               "          0,SUM(glat103),  ",
#               "          SUM(glat104),0,  ",
#               "          0,SUM(glat113),  ",
#               "          SUM(glat114),0,  ",                                           
#               "          glatent                                                      ",
#               "     FROM glat_t,glac_t,glaa_t                                         ",
#               "    WHERE     glatld = glaald         AND glaa004 = glac001            ",
#               "          AND glatent = glaaent       AND glatent = '",g_enterprise,"' ",
#               "          AND glac002 = glat007       AND glatld IN ",g_wc_xrcald CLIPPED ,
#               "          AND glat001 = '",g_master_m.year,"' AND glatent = glaaent ",
#               "          AND glat002 BETWEEN '",g_master_m.bmonth,"' AND '",g_master_m.emonth,"' ",
#               " GROUP BY glatcomp,glatld,glat003,glat005,glat007,glat100,glatent"   

 LET g_sql = "   INSERT INTO aglq715_tmp                               ",
               "   SELECT glatcomp,glatld,glat003,glat005,glat007,glat100,             ",
               "          0,SUM(glat103),  ",
               "          SUM(glat104),0,  ",
               "          0,SUM(glat113),  ",
               "          SUM(glat114),0,  ",
               "          glatent                                                      ",
               "     FROM glat_t                                         ",
               "    WHERE     ",
               "          glatent = '",g_enterprise,"' ",
#               "          AND glatld IN ",g_wc_xrcald CLIPPED , #160811-00039#3 mark
               "          AND ",l_ld_str,  #160811-00039#3 add
               "          AND glat001 = '",g_master_m.year,"' ",
               "          AND glat002 BETWEEN '",g_master_m.bmonth,"' AND '",g_master_m.emonth,"' ",
               "          AND glat007 IN (",
               "              SELECT glac002  FROM glac_t,glaa_t ",
               "               WHERE glacent = glaaent ",
               "                 AND glaaent = glatent ",
               "                 AND glaald = glatld   ",
               "                 AND glac001 = glaa004 ",
               "                         )",
               " GROUP BY glatcomp,glatld,glat003,glat005,glat007,glat100,glatent"
   #albireo 151028-----e
   #albireo 151030-----e
   PREPARE aglq715_tmp02 FROM g_sql
   EXECUTE aglq715_tmp02 
   
   #160505-00007#10--add--str--
   #期末余额
   LET g_sql = "   INSERT INTO aglq715_tmp",
               "   SELECT glatcomp,glatld,glat003,glat005,glat007,glat100,",
               "          0,0,0,",
               "          SUM(CASE WHEN glac008=1 THEN glat1030+glat103-glat104 ELSE glat1030+glat104-glat103 END),",
               "          0,0,0,",
               "          SUM(CASE WHEN glac008=1 THEN glat1130+glat113-glat114 ELSE glat1130+glat114-glat113 END),",
               "          glatent",
               "     FROM aglq715_tmp,glaa_t,glac_t ",
               "    WHERE glatent=glaaent AND glaaent=glacent ",
               "      AND glatld=glaald AND glat007=glac002 ",
               "      AND glaa004=glac001",
               "    GROUP BY glatcomp,glatld,glat003,glat005,glat007,glat100,glatent"
   PREPARE aglq715_tmp03 FROM g_sql
   EXECUTE aglq715_tmp03 
   #160505-00007#10--add--end
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
PRIVATE FUNCTION aglq715_open()
   DEFINE la_param          RECORD
          prog              STRING,
          param             DYNAMIC ARRAY OF STRING
                            END RECORD
   DEFINE ls_js             STRING
   DEFINE l_glat007         LIKE glat_t.glat007

   IF cl_null(g_glat_d[l_ac].glatcomp) THEN RETURN END IF

   LET l_glat007 = NULL
   IF g_master_m.comb = '2' THEN
      LET l_glat007 = g_glat_d[l_ac].glat007
   END IF

   LET la_param.prog = "aglq716"
   LET la_param.param[1] = g_master_m.site
   LET la_param.param[2] = MDY(g_master_m.bmonth,1,g_master_m.year)
   LET la_param.param[3] = MDY(g_master_m.emonth + 1,1,g_master_m.year) - 1
   LET la_param.param[4] = g_master_m.check
   LET la_param.param[5] = g_glat_d[l_ac].glatcomp
   LET la_param.param[6] = g_glat_d[l_ac].glatld
   LET la_param.param[7] = g_glat_d[l_ac].glat003
   LET la_param.param[8] = g_glat_d[l_ac].glat005
   LET la_param.param[9] = l_glat007
   LET ls_js = util.JSON.stringify(la_param)
   CALL cl_cmdrun_wait(ls_js)

END FUNCTION

 
{</section>}
 
