#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq811.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-10-13 10:04:01), PR版次:0001(2016-10-21 11:23:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000004
#+ Filename...: aglq811
#+ Description: 資產負債表(兩期比較)
#+ Creator....: 02599(2016-10-11 17:26:54)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq811.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160817-00009#9 2016/10/20 By 07900  财务新增报表。
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
PRIVATE TYPE type_g_glfb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glfb002 LIKE glfb_t.glfb002, 
   glfbl004 LIKE glfbl_t.glfbl004, 
   glfb003 LIKE glfb_t.glfb003, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   sum1 LIKE type_t.num20_6, 
   glfb010 LIKE type_t.chr500, 
   item LIKE type_t.chr500, 
   item_desc LIKE type_t.chr500, 
   line LIKE type_t.chr500, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   sum2 LIKE type_t.num20_6, 
   style LIKE type_t.chr1 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
DEFINE tm                    RECORD 
       glfa001               LIKE glfa_t.glfa001,
       glfa001_desc          LIKE glfal_t.glfal003,
       glfa005               LIKE glfa_t.glfa005,
       glfa005_desc          LIKE glaal_t.glaal002,
       glfa006               LIKE glfa_t.glfa006,
       glfa007               LIKE glfa_t.glfa007,
       year                  LIKE glfa_t.glfa006,
       month                 LIKE glfa_t.glfa007,
       glfa008               LIKE glfa_t.glfa008,
       glfa009               LIKE glfa_t.glfa009,
       show_ad               LIKE type_t.chr1,
       stus                  LIKE type_t.chr1,
       chg_curr              LIKE type_t.chr1,
       curr                  LIKE glaq_t.glaq005,
       curr_desc             LIKE type_t.chr500,
       rate                  LIKE glaq_t.glaq006 
       END RECORD
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa025             LIKE glaa_t.glaa025
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glfb_d
DEFINE g_master_t                   type_g_glfb_d
DEFINE g_glfb_d          DYNAMIC ARRAY OF type_g_glfb_d
DEFINE g_glfb_d_t        type_g_glfb_d
 
      
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
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e     
#end add-point
 
{</section>}
 
{<section id="aglq811.main" >}
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
   DECLARE aglq811_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq811_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq811_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq811 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq811_init()   
 
      #進入選單 Menu (="N")
      CALL aglq811_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq811
      
   END IF 
   
   CLOSE aglq811_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq811_tmp;
   DROP TABLE aglq811_tmp_1;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq811.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq811_init()
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
   CALL cl_set_combo_scc('glfa008','8705')
   CALL cl_set_combo_scc('stus','9922')
   CALL aglq811_default() #設置查詢預設條件
   #建临时表
   CALL aglq811_create_temp_table()  #160817-00009#9
   #end add-point
 
   CALL aglq811_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq811.default_search" >}
PRIVATE FUNCTION aglq811_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfb001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfbseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glfbseq1 = '", g_argv[03], "' AND "
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
 
{<section id="aglq811.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq811_ui_dialog()
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
#   DEFINE l_string STRING
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
      CALL aglq811_b_fill()
   ELSE
      CALL aglq811_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
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
 
         CALL aglq811_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq811_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq811_detail_action_trans()
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
            CALL aglq811_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq811_output()  #160817-00009#9 add 
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq811_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq811_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq811_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glfb_d)
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
            CALL aglq811_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq811_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq811_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq811_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            CALL g_glfb_d.clear()
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
 
{<section id="aglq811.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq811_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_str      STRING
   
   SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
   
   DISPLAY BY NAME tm.glfa001,tm.glfa001_desc,tm.glfa005,tm.glfa005_desc,tm.glfa006,tm.glfa007,tm.year,tm.month,
                   tm.glfa008,tm.glfa009,tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.curr_desc,tm.rate 
   
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glfb002,glfbl004,glfb003
           FROM s_detail1[1].b_glfb002,s_detail1[1].b_glfbl004,s_detail1[1].b_glfb003
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb002
            #add-point:BEFORE FIELD b_glfb002 name="construct.b.page1.b_glfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb002
            
            #add-point:AFTER FIELD b_glfb002 name="construct.a.page1.b_glfb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.page1.b_glfb002"
            
            #END add-point
 
 
         #----<<b_glfbl004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbl004
            #add-point:BEFORE FIELD b_glfbl004 name="construct.b.page1.b_glfbl004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbl004
            
            #add-point:AFTER FIELD b_glfbl004 name="construct.a.page1.b_glfbl004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbl004
            #add-point:ON ACTION controlp INFIELD b_glfbl004 name="construct.c.page1.b_glfbl004"
            
            #END add-point
 
 
         #----<<b_glfb003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb003
            #add-point:BEFORE FIELD b_glfb003 name="construct.b.page1.b_glfb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb003
            
            #add-point:AFTER FIELD b_glfb003 name="construct.a.page1.b_glfb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb003
            #add-point:ON ACTION controlp INFIELD b_glfb003 name="construct.c.page1.b_glfb003"
            
            #END add-point
 
 
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<sum1>>----
         #----<<glfb010>>----
         #----<<item>>----
         #----<<item_desc>>----
         #----<<line>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<sum2>>----
         #----<<style>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_table1 ON item_desc,line
          FROM s_detail1[1].item_desc,s_detail1[1].line
          
      END CONSTRUCT
      
      INPUT BY NAME tm.glfa001,tm.glfa005,tm.glfa006,tm.glfa007,tm.year,tm.month,tm.glfa008,tm.glfa009,
                    tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate
                    
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL aglq811_glfa001_desc(tm.glfa001) RETURNING tm.glfa001_desc
            DISPLAY tm.glfa001_desc TO glfa001_desc
            CALL aglq811_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
            DISPLAY tm.glfa005_desc TO glfa005_desc
            
         AFTER FIELD glfa001
            CALL aglq811_glfa001_desc(tm.glfa001) RETURNING tm.glfa001_desc
            DISPLAY tm.glfa001_desc TO glfa001_desc
            IF NOT cl_null(tm.glfa001) THEN
               SELECT COUNT(*) INTO l_cnt FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001 AND glfa016='1'
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00249'
                  LET g_errparam.extend = tm.glfa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                
                  NEXT FIELD glfa001
               END IF
               SELECT glfa002 INTO l_glfa002 FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=tm.glfa001 
               IF l_glfa002<>'1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00255'
                  LET g_errparam.extend = tm.glfa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                
                  NEXT FIELD glfa001
               END IF
               SELECT glfa004 INTO l_glfa004 FROM glfa_t WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
               #檢查帳套使用的科目參照表號是否與報表模板使用科目參照表號相同
               IF NOT cl_null(tm.glfa005) THEN
                  SELECT COUNT(*) INTO l_cnt FROM glaa_t 
                  WHERE glaaent=g_enterprise AND glaald=tm.glfa005 AND glaa004=l_glfa004
                  IF l_cnt=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00242'
                     LET g_errparam.extend = tm.glfa005
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD glfa005
                  END IF
               END IF
            END IF
            
            
         AFTER FIELD glfa005
            CALL aglq811_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
            DISPLAY tm.glfa005_desc TO glfa005_desc
            IF NOT cl_null(tm.glfa005) THEN
               SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00055'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa005
               END IF
               SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005 AND glaastus='Y'
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00051'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa005
               END IF
               CALL s_ld_chk_authorization(g_user,tm.glfa005) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD glfa005
               END IF
               IF NOT cl_null(tm.glfa001) THEN
                  SELECT glfa004 INTO l_glfa004 FROM glfa_t 
                   WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
                  SELECT COUNT(*) INTO l_cnt FROM glaa_t 
                  WHERE glaaent=g_enterprise AND glaald=tm.glfa005 AND glaa004=l_glfa004
                  IF l_cnt=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00242'
                     LET g_errparam.extend = tm.glfa005
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD glfa005
                  END IF
               END IF
               SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
            END IF
            
           
         AFTER FIELD glfa007
            IF NOT cl_null(tm.glfa007) THEN
               IF NOT cl_ap_chk_Range(tm.glfa007,"1","1","13","1","azz-00079",1) THEN
                  NEXT FIELD glfa007
               END IF
               SELECT MAX(glav006) INTO l_glav006 FROM glav_t
               WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa006
               IF NOT cl_null(l_glav006) THEN
                  IF tm.glfa007>l_glav006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00427'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
               
                     NEXT FIELD glfa007
                  END IF
               END IF 
            END IF
            
         AFTER FIELD month
            IF NOT cl_null(tm.month) THEN
               IF NOT cl_ap_chk_Range(tm.month,"1","1","13","1","azz-00079",1) THEN
                  NEXT FIELD month
               END IF
               SELECT MAX(glav006) INTO l_glav006 FROM glav_t
               WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.year
               IF NOT cl_null(l_glav006) THEN
                  IF tm.month>l_glav006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00427'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
               
                     NEXT FIELD month
                  END IF
               END IF
            END IF
            
         AFTER FIELD glfa009
            IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glfa009
            END IF

         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
         
         ON CHANGE chg_curr
            IF tm.chg_curr = 'Y' THEN
               CALL cl_set_comp_entry('curr,rate',TRUE)
            ELSE
               CALL cl_set_comp_entry('curr,rate',FALSE)
               LET tm.curr=''
               LET tm.curr_desc=''
               LET tm.rate=''
               DISPLAY BY NAME tm.curr,tm.curr_desc,tm.rate
            END IF
            
         AFTER FIELD curr
            CALL s_desc_get_currency_desc(tm.curr) RETURNING tm.curr_desc
            DISPLAY BY NAME tm.curr_desc
            IF NOT cl_null(tm.curr) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.curr
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.curr=''
                  LET tm.curr_desc=''
                  DISPLAY BY NAME tm.curr_desc
                  NEXT FIELD CURRENT
               END IF
               #匯率
               CALL s_aooi160_get_exrate('2',tm.glfa005,g_today,tm.curr,g_glaa001,0,g_glaa025)
               RETURNING  tm.rate
               DISPLAY BY NAME tm.rate
            END IF
            
         AFTER FIELD rate
            IF NOT cl_null(tm.rate) THEN
               IF tm.curr=g_glaa001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00327'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET tm.rate=1
                  NEXT FIELD rate
               END IF
               CALL s_num_isnum(tm.rate) RETURNING l_success
               IF l_success=FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD rate
               END IF
            END IF
         
         ON ACTION controlp INFIELD glfa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.glfa001
            LET g_qryparam.where = " glfa002='1' AND glfa016 = '1'"
            CALL q_glfa001()                          #呼叫開窗
            LET tm.glfa001 = g_qryparam.return1
            DISPLAY tm.glfa001 TO glfa001  #顯示到畫面上
            NEXT FIELD glfa001 
               
         ON ACTION controlp INFIELD glfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
       
            LET g_qryparam.default1 = tm.glfa005        #給予default值
            LET g_qryparam.default2 = "" #glaald #帳別編號
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(tm.glfa001) THEN
               SELECT glfa004 INTO l_glfa004 FROM glfa_t WHERE glfaent=g_enterprise AND glfa001=tm.glfa001
               LET g_qryparam.where = " glaa004='",l_glfa004,"'"
            END IF
            CALL q_authorised_ld()                                #呼叫開窗
       
            LET tm.glfa005 = g_qryparam.return1              
            DISPLAY tm.glfa005 TO glfa005            
            NEXT FIELD glfa005
            
         ON ACTION controlp INFIELD curr
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.curr  
            CALL q_ooai001()                          #呼叫開窗
            LET tm.curr = g_qryparam.return1
            DISPLAY tm.curr TO curr  #顯示到畫面上
            NEXT FIELD curr 
      END INPUT
      
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
   IF NOT cl_null(g_wc_table1) AND g_wc_table1 <> " 1=1" THEN
      LET g_wc_table1=cl_replace_str(g_wc_table1,'item_desc','glfbl004')
      LET g_wc_table1=cl_replace_str(g_wc_table1,'line','glfb003')
   END IF
   #上年同期改成2016年10月
   LET l_str=tm.year USING "&&&&",cl_getmsg("agl-00274",g_dlang),tm.month USING "&&",cl_getmsg("axc-00589",g_dlang)
   CALL cl_set_comp_att_text('sum1',l_str)
   CALL cl_set_comp_att_text('sum2',l_str)
   #end add-point
        
   LET g_error_show = 1
   CALL aglq811_b_fill()
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
 
{<section id="aglq811.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq811_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq811_b_fill1()
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb002,'',glfb003,'','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfb001, 
       glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK FROM glfb_t",
 
 
                     "",
                     " WHERE glfbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1"
 
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
 
   LET g_sql = "SELECT '',glfb002,'',glfb003,'','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq811_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq811_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].glfb003, 
       g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2,g_glfb_d[l_ac].sum1,g_glfb_d[l_ac].glfb010,g_glfb_d[l_ac].item, 
       g_glfb_d[l_ac].item_desc,g_glfb_d[l_ac].line,g_glfb_d[l_ac].amt3,g_glfb_d[l_ac].amt4,g_glfb_d[l_ac].sum2, 
       g_glfb_d[l_ac].style
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glfb_d[l_ac].statepic = cl_get_actipic(g_glfb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq811_detail_show("'1'")      
 
      CALL aglq811_glfb_t_mask()
 
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
   
 
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   LET g_detail_cnt = g_glfb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq811_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq811_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq811_detail_action_trans()
 
   IF g_glfb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq811_fetch()
   END IF
   
      CALL aglq811_filter_show('glfb002','b_glfb002')
   CALL aglq811_filter_show('glfbl004','b_glfbl004')
   CALL aglq811_filter_show('glfb003','b_glfb003')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq811_fetch()
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
 
{<section id="aglq811.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq811_detail_show(ps_page)
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
 
{<section id="aglq811.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq811_filter()
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
      CONSTRUCT g_wc_filter ON glfb002,glfbl004,glfb003
                          FROM s_detail1[1].b_glfb002,s_detail1[1].b_glfbl004,s_detail1[1].b_glfb003
 
         BEFORE CONSTRUCT
                     DISPLAY aglq811_filter_parser('glfb002') TO s_detail1[1].b_glfb002
            DISPLAY aglq811_filter_parser('glfbl004') TO s_detail1[1].b_glfbl004
            DISPLAY aglq811_filter_parser('glfb003') TO s_detail1[1].b_glfb003
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.filter.page1.b_glfb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.filter.page1.b_glfb002"
            
            #END add-point
 
 
         #----<<b_glfbl004>>----
         #Ctrlp:construct.c.filter.page1.b_glfbl004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbl004
            #add-point:ON ACTION controlp INFIELD b_glfbl004 name="construct.c.filter.page1.b_glfbl004"
            
            #END add-point
 
 
         #----<<b_glfb003>>----
         #Ctrlp:construct.c.filter.page1.b_glfb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb003
            #add-point:ON ACTION controlp INFIELD b_glfb003 name="construct.c.filter.page1.b_glfb003"
            
            #END add-point
 
 
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<sum1>>----
         #----<<glfb010>>----
         #----<<item>>----
         #----<<item_desc>>----
         #----<<line>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<sum2>>----
         #----<<style>>----
   
 
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
   
      CALL aglq811_filter_show('glfb002','b_glfb002')
   CALL aglq811_filter_show('glfbl004','b_glfbl004')
   CALL aglq811_filter_show('glfb003','b_glfb003')
 
    
   CALL aglq811_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq811_filter_parser(ps_field)
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
 
{<section id="aglq811.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq811_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq811_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.insert" >}
#+ insert
PRIVATE FUNCTION aglq811_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq811.modify" >}
#+ modify
PRIVATE FUNCTION aglq811_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq811_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.delete" >}
#+ delete
PRIVATE FUNCTION aglq811_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq811.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq811_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_tot_cnt = g_glfb_d.getLength()
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
 
{<section id="aglq811.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq811_detail_index_setting()
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
            IF g_glfb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glfb_d.getLength() AND g_glfb_d.getLength() > 0
            LET g_detail_idx = g_glfb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glfb_d.getLength() THEN
               LET g_detail_idx = g_glfb_d.getLength()
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
 
{<section id="aglq811.mask_functions" >}
 &include "erp/agl/aglq811_mask.4gl"
 
{</section>}
 
{<section id="aglq811.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 重寫填充單身
# Memo...........:
# Usage..........: CALL aglq811_b_fill1()
# Date & Author..: 2016/10/11 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_b_fill1()
   DEFINE l_glfbseq       LIKE glfb_t.glfbseq
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_amt1_fm       LIKE type_t.num20_6
   DEFINE l_amt2_fm       LIKE type_t.num20_6
   DEFINE l_glfbseq1      LIKE glfb_t.glfbseq1
   DEFINE l_type          LIKE type_t.chr1
   DEFINE l_sql           STRING
   
   CALL g_glfb_d.clear()
   LET l_sql="SELECT DISTINCT 'N',glfbseq,glfb002,glfbl004,glfb003,glfb010 ",
             "  FROM glfb_t ",
             "  LEFT JOIN glfbl_t ON glfbent=glfblent AND glfb001 = glfbl001 AND glfbseq = glfblseq AND glfb002 = glfbl002 AND glfbl003 = '",g_lang,"' ",
             " WHERE glfbent=",g_enterprise," AND glfb001='",tm.glfa001,"'",
             " AND ",g_wc_filter 
   
   #資產
   LET g_sql = l_sql," AND glfbseq1 IN ('A','B')  AND ",g_wc_table,
                      " ORDER BY glfb003"  
   PREPARE aglq811_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq811_pb1
   
   #負債
   LET g_sql = l_sql," AND glfbseq1 IN ('C','D')  AND ",g_wc_table1,
                     " ORDER BY glfb003"                  
  
   PREPARE aglq811_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR aglq811_pb2
 
   CALL cl_err_collect_init()
 
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   #資產
   FOREACH b_fill_curs1 INTO g_glfb_d[l_ac].sel,l_glfbseq,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,
                             g_glfb_d[l_ac].glfb003,g_glfb_d[l_ac].glfb010
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #年初餘額
      LET l_glfbseq1='A'
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.glfa006,0) RETURNING g_glfb_d[l_ac].amt1
      #期末餘額
      LET l_glfbseq1='B'
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.glfa006,tm.glfa007) RETURNING g_glfb_d[l_ac].amt2      
      #上年同期
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.year,tm.month) RETURNING g_glfb_d[l_ac].sum1
      
      #是否進行幣別轉換
      IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
         LET g_glfb_d[l_ac].amt1 = g_glfb_d[l_ac].amt1 * tm.rate
         LET g_glfb_d[l_ac].amt2 = g_glfb_d[l_ac].amt2 * tm.rate
         LET g_glfb_d[l_ac].sum1 = g_glfb_d[l_ac].sum1 * tm.rate
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   #負債
   LET l_ac=1
   FOREACH b_fill_curs2 INTO g_glfb_d[l_ac].sel,l_glfbseq,g_glfb_d[l_ac].item,g_glfb_d[l_ac].item_desc,
                             g_glfb_d[l_ac].line,g_glfb_d[l_ac].style
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF      
 
      #年初數
      LET l_glfbseq1='C'
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.glfa006,0) RETURNING g_glfb_d[l_ac].amt3
      #期末數
      LET l_glfbseq1='D'
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.glfa006,tm.glfa007) RETURNING g_glfb_d[l_ac].amt4
      #上年同期
      CALL aglq811_get_amt(l_glfbseq,l_glfbseq1,tm.year,tm.month) RETURNING g_glfb_d[l_ac].sum2
      #是否進行幣別轉換
      IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
         LET g_glfb_d[l_ac].amt3 = g_glfb_d[l_ac].amt3 * tm.rate
         LET g_glfb_d[l_ac].amt4 = g_glfb_d[l_ac].amt4 * tm.rate
         LET g_glfb_d[l_ac].sum2 = g_glfb_d[l_ac].sum2 * tm.rate
      END IF
      
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL cl_err_collect_show()
   LET g_error_show = 0
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
       
   LET g_detail_cnt = g_glfb_d.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO tm.glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("amt1,amt2,amt3,amt4,sum1,sum2",l_format)
   
   LET l_ac = 1
   CALL aglq811_fetch()
   
   CALL aglq811_filter_show('glfb002','b_glfb002')
   CALL aglq811_filter_show('glfbl004','b_glfbl004')
   CALL aglq811_filter_show('glfb003','b_glfb003')
END FUNCTION

################################################################################
# Descriptions...: 抓取帳套說明
# Memo...........:
# Usage..........: CALL aglq811_glfa005_desc(p_glfa005)
#                  RETURNING r_desc
# Input parameter: p_glfb005      帳套編號
# Return code....: r_desc         說明
# Date & Author..: 2016/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_glfa005_desc(p_glfa005)
   DEFINE p_glfa005             LIKE glfa_t.glfa005
   DEFINE r_desc                LIKE glaal_t.glaal002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glfa005
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aglq811_get_amt(p_glfbseq,p_glfbseq1,p_glfa006,p_glfa007)
#                  RETURNING r_amt
# Input parameter: p_glfbseq      取數公式來源
#                : p_glfbseq1     數值數公式
#                : p_glfa006      年度
#                : p_glfa007      期別
# Return code....: r_amt          金額
# Date & Author..: 2016/10/11 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_get_amt(p_glfbseq,p_glfbseq1,p_glfa006,p_glfa007)
   DEFINE p_glfbseq          LIKE glfb_t.glfbseq
   DEFINE p_glfbseq1         LIKE glfb_t.glfbseq1
   DEFINE p_glfa006          LIKE glfa_t.glfa006
   DEFINE p_glfa007          LIKE glfa_t.glfa007
   DEFINE r_amt              LIKE type_t.num20_6
   DEFINE l_glfb004          LIKE glfb_t.glfb004
   DEFINE l_glfb005          LIKE glfb_t.glfb005
   DEFINE l_success          LIKE type_t.num5
   
   SELECT glfb004,glfb005 INTO l_glfb004,l_glfb005 
     FROM glfb_t
    WHERE glfbent=g_enterprise AND glfb001=tm.glfa001
      AND glfbseq=p_glfbseq AND glfbseq1=p_glfbseq1
   IF NOT cl_null(l_glfb005) THEN
                        #帳別      #年度       #起始期別  #截止期別 #小數位數   #單位      #報表模板編號       
      CALL s_analy_form(tm.glfa005,p_glfa006,p_glfa007,p_glfa007,tm.glfa009,tm.glfa008,tm.glfa001,
                        #取數公式來源  #計算公式    #含審計調整傳票否  #傳票狀態
                        l_glfb004,    l_glfb005,'',tm.show_ad,      tm.stus)   
      RETURNING l_success,r_amt
   ELSE
      LET r_amt=' '
   END IF 
   RETURN r_amt
END FUNCTION

################################################################################
# Descriptions...: 查詢設置初始值
# Memo...........:
# Usage..........: CALL aglq811_default()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_default()
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   
   #獲取帳套
   CALL s_ld_bookno()  RETURNING l_success,tm.glfa005
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   CALL s_ld_chk_authorization(g_user,tm.glfa005) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = tm.glfa005
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET tm.glfa005=NULL
   END IF
   CALL aglq811_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
   
   LET tm.glfa006=YEAR(g_today)
   LET tm.glfa007=MONTH(g_today)
   LET tm.year=tm.glfa006 - 1
   LET tm.month=tm.glfa007
   LET tm.glfa008='1' 
   LET tm.glfa009=2
   LET tm.show_ad='Y'
   LET tm.stus='1'
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.curr_desc=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   LET g_glaa001=''
   LET g_glaa025=''
   SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
END FUNCTION

################################################################################
# Descriptions...: 获取报表模板名称
# Memo...........:
# Usage..........: CALL aglq811_glfa001_desc(p_glfa001)
#                  RETURNING r_desc
# Input parameter: p_glfa001      报表模板编号
# Return code....: r_desc         报表模板说明
# Date & Author..: 2016/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_glfa001_desc(p_glfa001)
   DEFINE p_glfa001             LIKE glfa_t.glfa001
   DEFINE r_desc                LIKE glfal_t.glfal003
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glfa001
   CALL ap_ref_array2(g_ref_fields,"SELECT glfal003 FROM glfal_t WHERE glfalent='"||g_enterprise||"' AND glfal001=? AND glfal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

################################################################################
# Descriptions...: #160817-00009#9
# Memo...........: 建临时表
# Date & Author..:  20161020 By 07900
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_create_temp_table()
   DROP TABLE aglq811_tmp;
   CREATE TEMP TABLE aglq811_tmp(
   glfbent         SMALLINT,
   glfb001         VARCHAR(10),         #报表模板编号
   glfbseq         INTEGER,
   glfb002         VARCHAR(10),    
   glfbl004        VARCHAR(500),       #资产说明
   glfb003         SMALLINT,         #行序
   amt1            DECIMAL(20,6),         #年初数
   amt2            DECIMAL(20,6),         #期末余额
   sum1            DECIMAL(20,6),         #去年同期
   glfb010         VARCHAR(1),         #呈现格式  
   item_desc       VARCHAR(500),       #负债及所有者权益项目
   line            SMALLINT,         #行序
   amt3            DECIMAL(20,6),         #年初数
   amt4            DECIMAL(20,6),         #期末余额
   sum2            DECIMAL(20,6),          #去年同期
   style           VARCHAR(1)     #呈现格式
   );
END FUNCTION

################################################################################
# Descriptions...: 打印
# Memo...........: #160817-00009#9
# Date & Author..: 20161020 By 07900
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq811_output()
 DEFINE l_i      LIKE type_t.num5
   DELETE FROM aglq811_tmp
   FOR l_i = 1 TO g_glfb_d.getLength()
       INSERT INTO aglq811_tmp(glfbent,glfb001,glfbseq,glfb002,glfbl004,glfb003,amt1,amt2,
                                sum1,glfb010,item_desc,line,amt3,amt4,sum2,style)
       VALUES(g_enterprise,tm.glfa001,l_i,g_glfb_d[l_i].glfb002,g_glfb_d[l_i].glfbl004,g_glfb_d[l_i].glfb003,
              g_glfb_d[l_i].amt1,g_glfb_d[l_i].amt2,g_glfb_d[l_i].sum1,g_glfb_d[l_i].glfb010,g_glfb_d[l_i].item_desc,
              g_glfb_d[l_i].line,g_glfb_d[l_i].amt3,g_glfb_d[l_i].amt4,g_glfb_d[l_i].sum2,g_glfb_d[l_i].style)                           
   END FOR 
                      #条件wc,临时表,报表模板编号,账套,年度,期别,比较年度,比较期别,小数字数,单位                      
   CALL aglq811_g01('1=1','aglq811_tmp',tm.glfa001,tm.glfa005,tm.glfa006,tm.glfa007,tm.year,tm.month,tm.glfa009,tm.glfa008)
END FUNCTION

 
{</section>}
 
