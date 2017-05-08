#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq833.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-11-04 10:51:03), PR版次:0002(2016-12-14 15:38:02)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aglq833
#+ Description: 現金流量表（全年）
#+ Creator....: 01531(2016-10-25 13:41:40)
#+ Modifier...: 01531 -SD/PR- 07900
 
{</section>}
 
{<section id="aglq833.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160817-00009#11 2016/12/01  By 07900 新增报表
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
   nmai004 LIKE nmai_t.nmai004, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6, 
   amt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.num20_6, 
   amt11 LIKE type_t.num20_6, 
   amt12 LIKE type_t.num20_6, 
   amt13 LIKE type_t.num20_6, 
   glfb001 LIKE glfb_t.glfb001, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfbseq1 LIKE glfb_t.glfbseq1 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm                    RECORD 
       glfa005               LIKE glfa_t.glfa005,
       glfa005_desc          LIKE glaal_t.glaal002,
       glfa010               LIKE glfa_t.glfa010,
       glfa008               LIKE glfa_t.glfa008,
       glfa009               LIKE glfa_t.glfa009,
       show_ad               LIKE type_t.chr1,
       stus                  LIKE type_t.chr1,
       chg_curr              LIKE type_t.chr1,
       curr                  LIKE glaq_t.glaq005,
       rate                  LIKE glaq_t.glaq006,
       type_a                LIKE type_t.chr1,
       type_b                LIKE type_t.chr1,
       type_c                LIKE type_t.chr1
       END RECORD
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa025             LIKE glaa_t.glaa025  
DEFINE g_glav006             LIKE glav_t.glav006
DEFINE g_glaa003             LIKE glaa_t.glaa003
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

#end add-point
 
{</section>}
 
{<section id="aglq833.main" >}
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
   DECLARE aglq833_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq833_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq833_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq833 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq833_init()   
 
      #進入選單 Menu (="N")
      CALL aglq833_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq833
      
   END IF 
   
   CLOSE aglq833_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq833.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq833_init()
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
   CALL cl_set_combo_scc('glfbl004','8026')
   CALL cl_set_comp_visible('sel',FALSE)
   
   #建立临时表
   CALL aglq833_create_temp_table()
   
   #end add-point
 
   CALL aglq833_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq833.default_search" >}
PRIVATE FUNCTION aglq833_default_search()
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
 
{<section id="aglq833.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq833_ui_dialog()
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
      CALL aglq833_b_fill()
   ELSE
      CALL aglq833_query()
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
 
         CALL aglq833_init()
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
               CALL aglq833_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq833_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq833_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglq833_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq833_g01(" 1=1","aglq833_tmp",tm.glfa005,tm.glfa010,tm.glfa009,tm.glfa008,g_glav006)  #160817-00009#11 ADD xul
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq833_g01(" 1=1","aglq833_tmp",tm.glfa005,tm.glfa010,tm.glfa009,tm.glfa008,g_glav006)  #160817-00009#11 ADD xul
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq833_query()
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
            CALL aglq833_filter()
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
            CALL aglq833_b_fill()
 
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
            CALL aglq833_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq833_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq833_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq833_b_fill()
 
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
 
{<section id="aglq833.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq833_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_pass          LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_origin_str    STRING    
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_flag1         LIKE type_t.chr1
   DEFINE l_errno         LIKE type_t.chr100
   DEFINE l_glav002       LIKE glav_t.glav002
   DEFINE l_glav005       LIKE glav_t.glav005
   DEFINE l_sdate_s       LIKE glav_t.glav004
   DEFINE l_sdate_e       LIKE glav_t.glav004
   DEFINE l_glav006       LIKE glav_t.glav006
   DEFINE l_pdate_s       LIKE glav_t.glav004
   DEFINE l_pdate_e       LIKE glav_t.glav004
   DEFINE l_glav007       LIKE glav_t.glav007
   DEFINE l_wdate_s       LIKE glav_t.glav004
   DEFINE l_wdate_e       LIKE glav_t.glav004   
   
   
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

   LET tm.glfa010=YEAR(g_today)
   LET tm.glfa008='1' 
   LET tm.glfa009=2
   LET tm.type_a='Y'
   LET tm.type_b='Y'
   LET tm.type_c='Y' 
   LET tm.show_ad='Y'
   LET tm.stus='1'
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   LET g_glaa001=''
   LET g_glaa025=''
   SELECT glaa001,glaa025,glaa003 INTO g_glaa001,g_glaa025,g_glaa003 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005 
   DISPLAY BY NAME tm.glfa005,tm.glfa010,tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c,
                   tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate 


   LET l_date=MDY(12,1,tm.glfa010)
  
   CALL s_get_accdate(g_glaa003,l_date,'','') 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   LET g_glav006 = l_glav006
   IF g_glav006 = 13 THEN 
      CALL cl_set_comp_visible("amt13,b_amt13",TRUE) 
   ELSE
      CALL cl_set_comp_visible("amt13,b_amt13",FALSE) 
   END IF
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
      CONSTRUCT g_wc_table ON glfb002,glfb001,glfbseq,glfbseq1
           FROM s_detail1[1].b_glfb002,s_detail1[1].b_glfb001,s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb002
            #add-point:BEFORE FIELD b_glfb002 name="construct.b.page1.b_glfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb002
            
            #add-point:AFTER FIELD b_glfb002 name="construct.a.page1.b_glfb002"
            
            #END add-point
            
 
 
         #----<<b_glfbl004>>----
         #----<<b_nmai004>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<amt13>>----
         #----<<b_glfb001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb001
            #add-point:BEFORE FIELD b_glfb001 name="construct.b.page1.b_glfb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb001
            
            #add-point:AFTER FIELD b_glfb001 name="construct.a.page1.b_glfb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb001
            #add-point:ON ACTION controlp INFIELD b_glfb001 name="construct.c.page1.b_glfb001"
            
            #END add-point
 
 
         #----<<b_glfbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq
            #add-point:BEFORE FIELD b_glfbseq name="construct.b.page1.b_glfbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq
            
            #add-point:AFTER FIELD b_glfbseq name="construct.a.page1.b_glfbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfbseq1
            #add-point:BEFORE FIELD b_glfbseq1 name="construct.b.page1.b_glfbseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfbseq1
            
            #add-point:AFTER FIELD b_glfbseq1 name="construct.a.page1.b_glfbseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.page1.b_glfbseq1"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME tm.glfa005,tm.glfa010,tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c,
                    tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate   
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL aglq833_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
            DISPLAY tm.glfa005_desc TO glfa005_desc
         
         AFTER FIELD glfa005

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
            END IF
 
             CALL aglq833_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
             DISPLAY tm.glfa005_desc TO glfa005_desc
             SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005

         AFTER FIELD glfa010
            IF NOT cl_null(tm.glfa010) THEN
               LET l_date=MDY(1,1,tm.glfa010)
               CALL s_get_accdate(tm.glfa005,l_date,'','') 
               RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
                         l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
               LET g_glav006 = l_glav006
               IF l_flag1='N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                
                  NEXT FIELD glfa010
               END IF  
            END IF    

         AFTER FIELD glfa009
            IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glfa009
            END IF
            
            
         AFTER FIELD type_a
            IF tm.type_a NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
            
         AFTER FIELD type_b
            IF tm.type_b NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD type_c
            IF tm.type_c NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
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
               LET tm.rate=''
               DISPLAY BY NAME tm.curr,tm.rate
            END IF
            
         AFTER FIELD curr
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
 
         ON ACTION controlp INFIELD glfa005
            CALL s_fin_create_account_center_tmp()
            CALL s_fin_account_center_comp_str() RETURNING ls_wc
            CALL s_fin_get_wc_str(ls_wc) RETURNING l_origin_str
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
       
            LET g_qryparam.default1 = tm.glfa005        #給予default值
            LET g_qryparam.default2 = "" #glaald #帳別編號
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            LET g_qryparam.where = " glaacomp IN ",l_origin_str 
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
   CALL aglq833_get_data()
   #end add-point
        
   LET g_error_show = 1
   CALL aglq833_b_fill()
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
 
{<section id="aglq833.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq833_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq833_b_fill1()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb002,'','','','','','','','','','','','','','','',glfb001, 
       glfbseq,glfbseq1  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK FROM glfb_t", 
 
 
 
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
 
   LET g_sql = "SELECT '',glfb002,'','','','','','','','','','','','','','','',glfb001,glfbseq,glfbseq1", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq833_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq833_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004, 
       g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2,g_glfb_d[l_ac].amt3,g_glfb_d[l_ac].amt4,g_glfb_d[l_ac].amt5, 
       g_glfb_d[l_ac].amt6,g_glfb_d[l_ac].amt7,g_glfb_d[l_ac].amt8,g_glfb_d[l_ac].amt9,g_glfb_d[l_ac].amt10, 
       g_glfb_d[l_ac].amt11,g_glfb_d[l_ac].amt12,g_glfb_d[l_ac].amt13,g_glfb_d[l_ac].glfb001,g_glfb_d[l_ac].glfbseq, 
       g_glfb_d[l_ac].glfbseq1
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
 
      CALL aglq833_detail_show("'1'")      
 
      CALL aglq833_glfb_t_mask()
 
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
   FREE aglq833_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq833_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq833_detail_action_trans()
 
   IF g_glfb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq833_fetch()
   END IF
   
      CALL aglq833_filter_show('glfb002','b_glfb002')
   CALL aglq833_filter_show('glfb001','b_glfb001')
   CALL aglq833_filter_show('glfbseq','b_glfbseq')
   CALL aglq833_filter_show('glfbseq1','b_glfbseq1')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq833_fetch()
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
 
{<section id="aglq833.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq833_detail_show(ps_page)
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
 
{<section id="aglq833.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq833_filter()
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
      CONSTRUCT g_wc_filter ON glfb002,glfb001,glfbseq,glfbseq1
                          FROM s_detail1[1].b_glfb002,s_detail1[1].b_glfb001,s_detail1[1].b_glfbseq, 
                              s_detail1[1].b_glfbseq1
 
         BEFORE CONSTRUCT
                     DISPLAY aglq833_filter_parser('glfb002') TO s_detail1[1].b_glfb002
            DISPLAY aglq833_filter_parser('glfb001') TO s_detail1[1].b_glfb001
            DISPLAY aglq833_filter_parser('glfbseq') TO s_detail1[1].b_glfbseq
            DISPLAY aglq833_filter_parser('glfbseq1') TO s_detail1[1].b_glfbseq1
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.filter.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_glfbl004>>----
         #----<<b_nmai004>>----
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<amt13>>----
         #----<<b_glfb001>>----
         #Ctrlp:construct.c.filter.page1.b_glfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb001
            #add-point:ON ACTION controlp INFIELD b_glfb001 name="construct.c.filter.page1.b_glfb001"
            
            #END add-point
 
 
         #----<<b_glfbseq>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.filter.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.filter.page1.b_glfbseq1"
            
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
   
      CALL aglq833_filter_show('glfb002','b_glfb002')
   CALL aglq833_filter_show('glfb001','b_glfb001')
   CALL aglq833_filter_show('glfbseq','b_glfbseq')
   CALL aglq833_filter_show('glfbseq1','b_glfbseq1')
 
    
   CALL aglq833_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq833_filter_parser(ps_field)
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
 
{<section id="aglq833.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq833_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq833_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.insert" >}
#+ insert
PRIVATE FUNCTION aglq833_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq833.modify" >}
#+ modify
PRIVATE FUNCTION aglq833_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq833_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.delete" >}
#+ delete
PRIVATE FUNCTION aglq833_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq833.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq833_detail_action_trans()
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
 
{<section id="aglq833.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq833_detail_index_setting()
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
 
{<section id="aglq833.mask_functions" >}
 &include "erp/agl/aglq833_mask.4gl"
 
{</section>}
 
{<section id="aglq833.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL aglq833_create_temp_table()
# Date & Author..: 2016/10/25 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq833_create_temp_table()
   DROP TABLE aglq833_tmp;
   CREATE TEMP TABLE aglq833_tmp(
   seq             SMALLINT,
   glfb002         VARCHAR(10),
   glfbl004        VARCHAR(500),
   nmai004         INTEGER,
   amt1            DECIMAL(20,6),
   amt2            DECIMAL(20,6),
   amt3            DECIMAL(20,6),
   amt4            DECIMAL(20,6),
   amt5            DECIMAL(20,6),
   amt6            DECIMAL(20,6),
   amt7            DECIMAL(20,6),
   amt8            DECIMAL(20,6),
   amt9            DECIMAL(20,6),
   amt10           DECIMAL(20,6),
   amt11           DECIMAL(20,6),
   amt12           DECIMAL(20,6),
   amt13           DECIMAL(20,6)
   );
   DROP TABLE aglq830_tmp;
   CREATE TEMP TABLE aglq830_tmp(
   seq             SMALLINT,
   glfb002         VARCHAR(10),
   glfbl004        VARCHAR(500),
   nmai004         INTEGER,
   amt1            DECIMAL(20,6),
   amt2            DECIMAL(20,6),
   flag            SMALLINT     #记录期别
   );   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL aglq833_get_data()
# Date & Author..: 2016/10/25 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq833_get_data()
   DEFINE l_amt1               LIKE type_t.num20_6
   DEFINE l_amt2               LIKE type_t.num20_6
   DEFINE l_amt_s1             LIKE type_t.num20_6
   DEFINE l_amt_s2             LIKE type_t.num20_6
   DEFINE l_seq                LIKE type_t.num5
   DEFINE l_nmak001            LIKE nmak_t.nmak001
   DEFINE l_nmakl003           LIKE nmakl_t.nmakl003
   DEFINE l_nmai002            LIKE nmai_t.nmai002
   DEFINE l_nmail004           LIKE nmail_t.nmail004
   DEFINE l_nmai004            LIKE nmai_t.nmai004
   DEFINE l_glbd001            LIKE glbd_t.glbd001
   DEFINE l_glbdl003           LIKE glbdl_t.glbdl003
   DEFINE l_glbd003            LIKE glbd_t.glbd003
   DEFINE l_glbe002            LIKE glbe_t.glbe002    
   DEFINE l_glbe003            LIKE glbe_t.glbe003
   DEFINE l_glbe004            LIKE glbe_t.glbe004
   DEFINE l_glbg005            LIKE glbg_t.glbg005
   DEFINE l_glac008            LIKE glac_t.glac008
   DEFINE l_period             LIKE type_t.num5
   DEFINE l_period_e           LIKE type_t.num5
   DEFINE l_count              LIKE type_t.num5
   DEFINE l_period_e1          LIKE type_t.num5
   DEFINE l_amt                LIKE type_t.num20_6
   DEFINE l_sql1               STRING
   DEFINE l_amt1_s             LIKE type_t.num20_6
   DEFINE l_amt2_s             LIKE type_t.num20_6
   DEFINE l_sum1               LIKE type_t.num20_6
   DEFINE l_sum2               LIKE type_t.num20_6
   DEFINE l_nmak002            LIKE nmak_t.nmak002
   DEFINE l_nmak002_o          LIKE nmak_t.nmak002
   DEFINE l_desc1              LIKE nmakl_t.nmakl003
   DEFINE l_desc2              LIKE nmakl_t.nmakl003
   DEFINE l_desc               LIKE nmakl_t.nmakl003
   DEFINE l_cash_sum1          LIKE type_t.num20_6   
   DEFINE l_cash_sum2          LIKE type_t.num20_6   
   DEFINE l_nmak004            LIKE nmak_t.nmak004
   DEFINE l_nmak004_o          LIKE nmak_t.nmak004
   DEFINE l_nmai005            LIKE nmai_t.nmai005
   DEFINE l_glbd005            LIKE glbd_t.glbd005
   DEFINE l_flag_seq           LIKE type_t.num5
   DEFINE l_success            LIKE type_t.num5 #160704-00011#8 add
   DEFINE l_sql_pr6_1          STRING
   DEFINE l_sql_pr7_1          STRING
   DEFINE l_sql_pr8_1          STRING
   DEFINE l_sql_pr6_2          STRING
   DEFINE l_sql_pr7_2          STRING
   DEFINE l_sql_pr8_2          STRING
   DEFINE l_glaa004            LIKE glaa_t.glaa004
   DEFINE l_glac003            LIKE glac_t.glac003
   DEFINE l_glaq002            STRING
   DEFINE l_sum   DYNAMIC ARRAY OF RECORD
                    l_amt_s   LIKE type_t.num20_6,
                    l_amt     LIKE type_t.num20_6,
                    l_amt1    LIKE type_t.num20_6
                    END RECORD     
   DEFINE l_i                  LIKE type_t.num5 
   DEFINE l_amt_0              LIKE type_t.num20_6    
   DEFINE l_amt_s_0            LIKE type_t.num20_6 
   DEFINE l_flag               LIKE type_t.num5
   DEFINE l_amt_sum            LIKE type_t.num20_6 
   
   #刪除臨時表中資料
   DELETE FROM aglq833_tmp
   DELETE FROM aglq830_tmp
   #間接法
   IF tm.type_b='Y' THEN
      LET g_sql="SELECT DISTINCT glbd001,glbdl003,glbd003,glbd005 ",   
                "  FROM glbe_t,glbd_t ",
                "  LEFT JOIN glbdl_t ON glbdent=glbdlent AND glbd001=glbdl001 AND glbdlent='"||g_enterprise||"' AND glbdl002='"||g_dlang||"' ",
                " WHERE glbdent=glbeent AND glbd001=glbe001 AND glbdstus='Y' ",
                "   AND glbdent=",g_enterprise," AND glbeld='",tm.glfa005,"'",
                " ORDER BY glbd001,glbd003 "
     
      PREPARE aglq833_pr4 FROM g_sql
      DECLARE aglq833_cs4 CURSOR FOR aglq833_pr4
      
      LET g_sql="SELECT glbe002,glbe003,glbe004 ",
                "  FROM glbe_t ",
                " WHERE glbeent=",g_enterprise," AND glbeld='",tm.glfa005,"'",
                "   AND glbe001=? AND glbestus='Y' ",
                " ORDER BY glbe002 "
                
      PREPARE aglq833_pr5 FROM g_sql
      DECLARE aglq833_cs5 CURSOR FOR aglq833_pr5
      
      #借方-貸方
      LET g_sql=" SELECT SUM(glar005-glar006) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003=? "
      PREPARE aglq833_pr6 FROM g_sql
      
      #借方
      LET g_sql=" SELECT SUM(glar005) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003=? "
      PREPARE aglq833_pr7 FROM g_sql
      
      #貸方
      LET g_sql=" SELECT SUM(glar006) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003=? "
      PREPARE aglq833_pr8 FROM g_sql
      
      #表内小计
      LET g_sql=" SELECT SUM(amt1),SUM(amt2),SUM(amt3),SUM(amt4),SUM(amt5),SUM(amt6),",
                "        SUM(amt7),SUM(amt8),SUM(amt9),SUM(amt10),SUM(amt11),SUM(amt12),SUM(amt13)", 
                "   FROM aglq833_tmp ",
                "  WHERE glfb002 = ? ",
                "    AND seq > ?"  #用于限定抓取的是间接法资料
      PREPARE aglq833_sum_tmp_pr1 FROM g_sql
      
      #人工輸入金額(agli220)
      LET g_sql="SELECT SUM(glbf007) FROM glbf_t ",
                " WHERE glbfent=",g_enterprise," AND glbfld='",tm.glfa005,"'",
                "   AND glbf001=? AND glbf002=? ",
                "   AND glbf003=? AND glbf004=? "
      PREPARE aglq833_pr9 FROM g_sql
      
      #抓取凭证状态为未审核或已审核的凭证金额（+）
      IF tm.stus <> '1' THEN
         CASE tm.stus
            WHEN '2' LET l_sql1=" AND glapstus ='Y' "
            WHEN '3' LET l_sql1=" AND glapstus IN ('Y','N') "
         END CASE
         #借方-貸方
         LET l_sql_pr6_1=" SELECT SUM(glaq003-glaq004) ",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         l_sql1
 
         
         #借方
         LET l_sql_pr7_1=" SELECT SUM(glaq003) ",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         l_sql1
 
         
         #貸方
         LET l_sql_pr8_1=" SELECT SUM(glaq004)",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         l_sql1
 
      END IF
      #扣减AD审计调整凭证金额(-)
      IF tm.show_ad='N' THEN
         CASE tm.stus
            WHEN '1' LET l_sql1=" AND glapstus ='S' "
            WHEN '2' LET l_sql1=" AND glapstus IN ('Y','S')  "
            WHEN '3' LET l_sql1=" AND glapstus IN ('N','Y','S') "
         END CASE
         #借方-貸方
         LET l_sql_pr6_2=" SELECT SUM(glaq003-glaq004) ",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         "    AND glap007='AD' ",l_sql1
         
         #借方
         LET l_sql_pr7_2=" SELECT SUM(glaq003) ",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         "    AND glap007='AD' ",l_sql1
 
         
         #貸方
         LET l_sql_pr8_2=" SELECT SUM(glaq004)",  
                         "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                         "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
                         "    AND glap002=? AND glap004=? ",
                         "    AND glap007='AD' ",l_sql1
 
      END IF
   END IF
   
   #附註揭露
   IF tm.type_c='Y' THEN
      LET g_sql="SELECT DISTINCT glbg005 ",
                "  FROM glbg_t ",
                " WHERE glbgent=",g_enterprise," AND glbgld='",tm.glfa005,"'",
                "   AND glbg001='3' ",
                "   AND glbg002=",tm.glfa010," AND glbg003=? "
              
      PREPARE aglq833_pr10 FROM g_sql
      DECLARE aglq833_cs10 CURSOR FOR aglq833_pr10
      
      LET g_sql="SELECT SUM(glbg006) ",
                "  FROM glbg_t ",
                " WHERE glbgent=",g_enterprise," AND glbgld='",tm.glfa005,"'",
                "   AND glbg001='3' ",
                "   AND glbg002=? AND glbg003=? ",
                "   AND glbg005=? "
                
     PREPARE aglq833_pr11 FROM g_sql
   END IF
   
   CALL cl_err_collect_init()
   LET g_success = TRUE
   LET l_seq=0
   LET l_cash_sum1=0   
   LET l_cash_sum2=0   
   #直接法
   IF tm.type_a='Y' THEN
      LET g_prog = 'aglq830'
      FOR l_i = 1 TO g_glav006
         CALL s_cashflow_direct(tm.glfa005,'1',tm.glfa010,l_i,l_i,'','','',
                                tm.glfa009,tm.glfa008,tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate)
         RETURNING l_success
         IF l_success = FALSE THEN
            LET g_success = FALSE
         END IF 
         UPDATE aglq830_tmp SET flag = l_i 
                WHERE flag IS NULL 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'UPD aglq830_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF                
      END FOR   
      LET g_prog = 'aglq833'
      LET g_sql = " SELECT seq,glfb002,glfbl004,nmai004,amt1 FROM aglq830_tmp WHERE flag IS NOT NULL AND flag = 1"
      PREPARE aglq833_pr12 FROM g_sql
      DECLARE aglq833_cs12 CURSOR FOR aglq833_pr12
      FOREACH aglq833_cs12 INTO l_seq,l_glbd001,l_glbdl003,l_glbd003,l_sum[1].l_amt
      INSERT INTO aglq833_tmp(seq,glfb002,glfbl004,nmai004,
                              amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,amt11,amt12,amt13)
            VALUES(l_seq,l_glbd001,l_glbdl003,l_glbd003,l_sum[1].l_amt,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL) 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins1 aglq833_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF  
      END FOREACH      
      
      FOR l_i = 2 TO g_glav006      
         LET g_sql = " SELECT seq,glfb002,glfbl004,nmai004,amt1,flag FROM aglq830_tmp WHERE flag IS NOT NULL AND flag =",l_i," ORDER BY flag "
         PREPARE aglq833_pr13 FROM g_sql
         DECLARE aglq833_cs13 CURSOR FOR aglq833_pr13
         FOREACH aglq833_cs13 INTO l_seq,l_glbd001,l_glbdl003,l_glbd003,l_amt_sum,l_flag
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq833_cs13'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF      
            
            IF cl_null(l_amt_sum) THEN 
               LET l_amt_sum = 0 
            END IF
            
            CASE l_flag
               WHEN '2' UPDATE aglq833_tmp SET amt2 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003 
                          AND amt1 IS NOT NULL
               WHEN '3' UPDATE aglq833_tmp SET amt3 = l_amt_sum
                         WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003 
                          AND amt1 IS NOT NULL
               WHEN '4' UPDATE aglq833_tmp SET amt4 = l_amt_sum
                         WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL
               WHEN '5' UPDATE aglq833_tmp SET amt5 = l_amt_sum
                         WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003 
                          AND amt1 IS NOT NULL                          
               WHEN '6' UPDATE aglq833_tmp SET amt6 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                          
               WHEN '7' UPDATE aglq833_tmp SET amt7 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                          
               WHEN '8' UPDATE aglq833_tmp SET amt8 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003 
                          AND amt1 IS NOT NULL                            
               WHEN '9' UPDATE aglq833_tmp SET amt9 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                            
               WHEN '10' UPDATE aglq833_tmp SET amt10 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                            
               WHEN '11' UPDATE aglq833_tmp SET amt11 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                            
               WHEN '12' UPDATE aglq833_tmp SET amt12 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                            
               WHEN '13' UPDATE aglq833_tmp SET amt13 = l_amt_sum
                        WHERE glfb002 = l_glbd001
                          AND glfbl004 = l_glbdl003
                          AND amt1 IS NOT NULL                            
            END CASE
         
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'UPD aglq833_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF
         END FOREACH 
      END FOR         
   END IF
   
   #重新取得临时表中的项次seq值
   SELECT MAX(seq) INTO l_seq FROM aglq833_tmp
   IF cl_null(l_seq) THEN LET l_seq = 0 END IF
   
   #間接法
   IF tm.type_b='Y' THEN
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005  
      
      LET l_flag_seq = l_seq  #用于表内合计，限定抓取临时表资料，都是抓取的间接法资料 
      FOREACH aglq833_cs4 INTO l_glbd001,l_glbdl003,l_glbd003,l_glbd005   
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglq833_cs4'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_seq=l_seq+1
         
         #当群组类型是1.标题时，显示说明，金额给NULL
         IF l_glbd005 = '1' THEN
            INSERT INTO aglq833_tmp(seq,glfb002,glfbl004,nmai004,
                                    amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,amt11,amt12,amt13)
            VALUES(l_seq,l_glbd001,l_glbdl003,l_glbd003,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins aglq833_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF
            CONTINUE FOREACH
        END IF
         
         CALL l_sum.clear()
         FOREACH aglq833_cs5 USING l_glbd001 INTO l_glbe002,l_glbe003,l_glbe004
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq833_cs5'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            
            IF (l_glbe004<>'4' AND l_glbe004<>'7') AND (tm.stus <>'1'  OR tm.show_ad='N') THEN
               SELECT glac003 INTO l_glac003 FROM glac_t 
                WHERE glacent=g_enterprise 
                  AND glac001=l_glaa004
                  AND glac002=l_glbe002 
               IF l_glac003 = '1' THEN
                  #抓取科目对应的明细科目或者独立科目
                  CALL s_voucher_get_glac_str(l_glaa004,l_glbe002) RETURNING l_glaq002
               ELSE
                  LET l_glaq002 = "'",l_glbe002,"'"
               END IF
               #抓取凭证状态为未审核或已审核的凭证金额（+）
               IF tm.stus <> '1' THEN
                  CASE
                     #異動 #期初 #期末
                     WHEN l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3' 
                        #SUM(借方-貸方)
                        LET g_sql=l_sql_pr6_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr6_1 FROM g_sql
                     #借方異動
                     WHEN l_glbe004='5' 
                        #SUM(借方)
                        LET g_sql=l_sql_pr7_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr7_1 FROM g_sql
                     #貸方異動
                     WHEN l_glbe004='6' 
                        #SUM(貸方)
                        LET g_sql=l_sql_pr8_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr8_1 FROM g_sql
                  END CASE
               END IF
               #扣减AD审计调整凭证金额(-)
               IF tm.show_ad='N' THEN
                  CASE
                     #異動 #期初 #期末
                     WHEN l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3'
                        #SUM(借方-貸方)
                        LET g_sql=l_sql_pr6_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr6_2 FROM g_sql
                     #借方異動
                     WHEN l_glbe004='5' 
                        #SUM(借方)
                        LET g_sql=l_sql_pr7_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr7_2 FROM g_sql
                     #貸方異動
                     WHEN l_glbe004='6'
                        #SUM(貸方)
                        LET g_sql=l_sql_pr8_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq833_pr8_2 FROM g_sql
                  END CASE
               END IF
            END IF
 
            
            CASE
               
               WHEN l_glbe004='1' #異動
                  FOR l_i = 1 TO g_glav006 
                     #本期數
                     EXECUTE aglq833_pr6 USING l_glbe002,tm.glfa010,l_i INTO l_sum[l_i].l_amt_s
                     IF cl_null(l_sum[l_i].l_amt_s) THEN LET l_sum[l_i].l_amt_s=0 END IF 
                      
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq833_pr6_1 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_sum[l_i].l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq833_pr6_2 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s - l_sum[l_i].l_amt
                     END IF
                  END FOR
                  
                     
               WHEN l_glbe004='2' #期初
                  FOR l_i = 1 TO g_glav006 
                     #LET l_period=0
                     #本期數
                     LET l_period_e=l_i-1
                     EXECUTE aglq833_pr6 USING l_glbe002,tm.glfa010,l_period_e INTO l_sum[l_i].l_amt_s
                  
                     IF cl_null(l_sum[l_i].l_amt_s) THEN LET l_sum[l_i].l_amt_s=0 END IF
                     
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq833_pr6_1 USING tm.glfa010,l_period_e INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_sum[l_i].l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq833_pr6_2 USING tm.glfa010,l_period_e INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s - l_sum[l_i].l_amt
                     END IF
                  END FOR
                  
               WHEN l_glbe004='3' #期末
                  FOR l_i = 1 TO g_glav006 
                     #本期數
                     EXECUTE aglq833_pr6 USING l_glbe002,tm.glfa010,l_i INTO l_sum[l_i].l_amt_s
                     IF l_i = 1 THEN 
                        LET l_period=0
                        EXECUTE aglq833_pr6 USING l_glbe002,tm.glfa010,l_period INTO l_amt_s_0
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_amt_s_0  #1期加上0期                      
                     END IF                  
                     IF cl_null(l_sum[l_i].l_amt_s) THEN LET l_sum[l_i].l_amt_s=0 END IF
                     
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN   
                        #本期數
                        EXECUTE aglq833_pr6_1 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        IF l_i = 1 THEN 
                           LET l_period = 0
                           EXECUTE aglq833_pr6_1 USING tm.glfa010,l_period INTO l_amt_0
                           LET l_sum[l_i].l_amt = l_sum[l_i].l_amt + l_amt_0 
                        END IF                        
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_sum[l_i].l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq833_pr6_2 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_amt) THEN LET l_amt=0 END IF    
                        IF l_i = 1 THEN 
                           LET l_period = 0 
                           EXECUTE aglq833_pr6_2 USING tm.glfa010,l_period INTO l_amt_0
                           LET l_sum[l_i].l_amt = l_sum[l_i].l_amt + l_amt_0 
                        END IF                           
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s - l_sum[l_i].l_amt
                     END IF
                  END FOR
                  
               WHEN l_glbe004='4' #人工輸入
                  FOR l_i = 1 TO g_glav006 
                     #本期數
                     EXECUTE aglq833_pr9 USING tm.glfa010,l_i,l_glbd001,l_glbe002 INTO l_sum[l_i].l_amt_s
                  END FOR
                  
               WHEN l_glbe004='5' #借方異動
                  FOR l_i = 1 TO g_glav006
                     #本期數
                     EXECUTE aglq833_pr7 USING l_glbe002,tm.glfa010,l_i INTO l_sum[l_i].l_amt_s
                  
                      IF cl_null(l_sum[l_i].l_amt_s) THEN LET l_sum[l_i].l_amt_s=0 END IF
                     
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq833_pr7_1 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_sum[l_i].l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq833_pr7_2 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s - l_sum[l_i].l_amt
                     END IF
                     
                  END FOR
                  
               WHEN l_glbe004='6' #貸方異動
                  FOR l_i = 1 TO g_glav006   
                     #本期數
                     EXECUTE aglq833_pr8 USING l_glbe002,tm.glfa010,l_i INTO l_sum[l_i].l_amt_s
                     IF cl_null(l_sum[l_i].l_amt_s) THEN LET l_sum[l_i].l_amt_s=0 END IF
                      
                     #抓取未审核或已审核的凭证金额(+)
                     IF tm.stus <>'1' THEN
                        #本期數
                        EXECUTE aglq833_pr8_1 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s + l_sum[l_i].l_amt
                     END IF
                     
                     #扣减AD审计调整凭证金额(-)
                     IF tm.show_ad='N' THEN
                        #本期數
                        EXECUTE aglq833_pr8_2 USING tm.glfa010,l_i INTO l_sum[l_i].l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                        IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
                        LET l_sum[l_i].l_amt_s = l_sum[l_i].l_amt_s - l_sum[l_i].l_amt
                     END IF
                  END FOR
                  
               WHEN l_glbe004='7' #表内小计
                     EXECUTE aglq833_sum_tmp_pr1 USING l_glbe002,l_flag_seq INTO 
                                       l_sum[1].l_amt_s,l_sum[2].l_amt_s,l_sum[3].l_amt_s,l_sum[4].l_amt_s,l_sum[5].l_amt_s,
                                       l_sum[6].l_amt_s,l_sum[7].l_amt_s,l_sum[8].l_amt_s,l_sum[9].l_amt_s,l_sum[10].l_amt_s,
                                       l_sum[11].l_amt_s,l_sum[12].l_amt_s,l_sum[13].l_amt_s
                
            END CASE
            IF cl_null(l_sum[1].l_amt_s) THEN LET l_sum[1].l_amt_s=0 END IF
            IF cl_null(l_sum[2].l_amt_s) THEN LET l_sum[2].l_amt_s=0 END IF
            IF cl_null(l_sum[3].l_amt_s) THEN LET l_sum[3].l_amt_s=0 END IF
            IF cl_null(l_sum[4].l_amt_s) THEN LET l_sum[4].l_amt_s=0 END IF
            IF cl_null(l_sum[5].l_amt_s) THEN LET l_sum[5].l_amt_s=0 END IF
            IF cl_null(l_sum[6].l_amt_s) THEN LET l_sum[6].l_amt_s=0 END IF
            IF cl_null(l_sum[7].l_amt_s) THEN LET l_sum[7].l_amt_s=0 END IF
            IF cl_null(l_sum[8].l_amt_s) THEN LET l_sum[8].l_amt_s=0 END IF
            IF cl_null(l_sum[9].l_amt_s) THEN LET l_sum[9].l_amt_s=0 END IF
            IF cl_null(l_sum[10].l_amt_s) THEN LET l_sum[10].l_amt_s=0 END IF
            IF cl_null(l_sum[11].l_amt_s) THEN LET l_sum[11].l_amt_s=0 END IF
            IF cl_null(l_sum[12].l_amt_s) THEN LET l_sum[12].l_amt_s=0 END IF
            IF cl_null(l_sum[13].l_amt_s) THEN LET l_sum[13].l_amt_s=0 END IF
            IF l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3' THEN
               #該科目正常餘額形態
               SELECT glac008 INTO l_glac008 FROM glac_t
                WHERE glacent=g_enterprise 
                  AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005)
                  AND glac002=l_glbe002  
               IF l_glac008='2' THEN #餘額在貸方
                  LET l_sum[1].l_amt_s=(-1)*l_sum[1].l_amt_s
                  LET l_sum[2].l_amt_s=(-1)*l_sum[2].l_amt_s
                  LET l_sum[3].l_amt_s=(-1)*l_sum[3].l_amt_s
                  LET l_sum[4].l_amt_s=(-1)*l_sum[4].l_amt_s
                  LET l_sum[5].l_amt_s=(-1)*l_sum[5].l_amt_s
                  LET l_sum[6].l_amt_s=(-1)*l_sum[6].l_amt_s
                  LET l_sum[7].l_amt_s=(-1)*l_sum[7].l_amt_s
                  LET l_sum[8].l_amt_s=(-1)*l_sum[8].l_amt_s
                  LET l_sum[9].l_amt_s=(-1)*l_sum[9].l_amt_s
                  LET l_sum[10].l_amt_s=(-1)*l_sum[10].l_amt_s
                  LET l_sum[11].l_amt_s=(-1)*l_sum[11].l_amt_s
                  LET l_sum[12].l_amt_s=(-1)*l_sum[12].l_amt_s
                  LET l_sum[13].l_amt_s=(-1)*l_sum[13].l_amt_s
               END IF
            END IF
            IF cl_null(l_sum[1].l_amt1) THEN LET l_sum[1].l_amt1=0 END IF
            IF cl_null(l_sum[2].l_amt1) THEN LET l_sum[2].l_amt1=0 END IF
            IF cl_null(l_sum[3].l_amt1) THEN LET l_sum[3].l_amt1=0 END IF
            IF cl_null(l_sum[4].l_amt1) THEN LET l_sum[4].l_amt1=0 END IF
            IF cl_null(l_sum[5].l_amt1) THEN LET l_sum[5].l_amt1=0 END IF
            IF cl_null(l_sum[6].l_amt1) THEN LET l_sum[6].l_amt1=0 END IF
            IF cl_null(l_sum[7].l_amt1) THEN LET l_sum[7].l_amt1=0 END IF
            IF cl_null(l_sum[8].l_amt1) THEN LET l_sum[8].l_amt1=0 END IF
            IF cl_null(l_sum[9].l_amt1) THEN LET l_sum[9].l_amt1=0 END IF
            IF cl_null(l_sum[10].l_amt1) THEN LET l_sum[10].l_amt1=0 END IF
            IF cl_null(l_sum[11].l_amt1) THEN LET l_sum[11].l_amt1=0 END IF
            IF cl_null(l_sum[12].l_amt1) THEN LET l_sum[12].l_amt1=0 END IF
            IF cl_null(l_sum[13].l_amt1) THEN LET l_sum[13].l_amt1=0 END IF            
            IF l_glbe003='+' THEN
               LET l_sum[1].l_amt1=l_sum[1].l_amt1 + l_sum[1].l_amt_s
               LET l_sum[2].l_amt1=l_sum[2].l_amt1 + l_sum[2].l_amt_s
               LET l_sum[3].l_amt1=l_sum[3].l_amt1 + l_sum[3].l_amt_s
               LET l_sum[4].l_amt1=l_sum[4].l_amt1 + l_sum[4].l_amt_s
               LET l_sum[5].l_amt1=l_sum[5].l_amt1 + l_sum[5].l_amt_s
               LET l_sum[6].l_amt1=l_sum[6].l_amt1 + l_sum[6].l_amt_s
               LET l_sum[7].l_amt1=l_sum[7].l_amt1 + l_sum[7].l_amt_s
               LET l_sum[8].l_amt1=l_sum[8].l_amt1 + l_sum[8].l_amt_s
               LET l_sum[9].l_amt1=l_sum[9].l_amt1 + l_sum[9].l_amt_s
               LET l_sum[10].l_amt1=l_sum[10].l_amt1 + l_sum[10].l_amt_s
               LET l_sum[11].l_amt1=l_sum[11].l_amt1 + l_sum[11].l_amt_s
               LET l_sum[12].l_amt1=l_sum[12].l_amt1 + l_sum[12].l_amt_s
               LET l_sum[13].l_amt1=l_sum[13].l_amt1 + l_sum[13].l_amt_s
            END IF
            IF l_glbe003='-' THEN
               LET l_sum[1].l_amt1=l_sum[1].l_amt1 - l_sum[1].l_amt_s
               LET l_sum[2].l_amt1=l_sum[2].l_amt1 - l_sum[2].l_amt_s
               LET l_sum[3].l_amt1=l_sum[3].l_amt1 - l_sum[3].l_amt_s
               LET l_sum[4].l_amt1=l_sum[4].l_amt1 - l_sum[4].l_amt_s
               LET l_sum[5].l_amt1=l_sum[5].l_amt1 - l_sum[5].l_amt_s
               LET l_sum[6].l_amt1=l_sum[6].l_amt1 - l_sum[6].l_amt_s
               LET l_sum[7].l_amt1=l_sum[7].l_amt1 - l_sum[7].l_amt_s
               LET l_sum[8].l_amt1=l_sum[8].l_amt1 - l_sum[8].l_amt_s
               LET l_sum[9].l_amt1=l_sum[9].l_amt1 - l_sum[9].l_amt_s
               LET l_sum[10].l_amt1=l_sum[10].l_amt1 - l_sum[10].l_amt_s
               LET l_sum[11].l_amt1=l_sum[11].l_amt1 - l_sum[11].l_amt_s
               LET l_sum[12].l_amt1=l_sum[12].l_amt1 - l_sum[12].l_amt_s
               LET l_sum[13].l_amt1=l_sum[13].l_amt1 - l_sum[13].l_amt_s
            END IF            
         END FOREACH
         
         CASE tm.glfa008
            WHEN '2'  #千
               LET l_sum[1].l_amt1 = l_sum[1].l_amt1 / 1000
               LET l_sum[2].l_amt1 = l_sum[2].l_amt1 / 1000
               LET l_sum[3].l_amt1 = l_sum[3].l_amt1 / 1000
               LET l_sum[4].l_amt1 = l_sum[4].l_amt1 / 1000
               LET l_sum[5].l_amt1 = l_sum[5].l_amt1 / 1000
               LET l_sum[6].l_amt1 = l_sum[6].l_amt1 / 1000
               LET l_sum[7].l_amt1 = l_sum[7].l_amt1 / 1000
               LET l_sum[8].l_amt1 = l_sum[8].l_amt1 / 1000
               LET l_sum[9].l_amt1 = l_sum[9].l_amt1 / 1000
               LET l_sum[10].l_amt1 = l_sum[10].l_amt1 / 1000
               LET l_sum[11].l_amt1 = l_sum[11].l_amt1 / 1000
               LET l_sum[12].l_amt1 = l_sum[12].l_amt1 / 1000
               LET l_sum[13].l_amt1 = l_sum[13].l_amt1 / 1000
            WHEN '3'  #萬
               LET l_sum[1].l_amt1 = l_sum[1].l_amt1 / 10000
               LET l_sum[2].l_amt1 = l_sum[2].l_amt1 / 10000
               LET l_sum[3].l_amt1 = l_sum[3].l_amt1 / 10000
               LET l_sum[4].l_amt1 = l_sum[4].l_amt1 / 10000
               LET l_sum[5].l_amt1 = l_sum[5].l_amt1 / 10000
               LET l_sum[6].l_amt1 = l_sum[6].l_amt1 / 10000
               LET l_sum[7].l_amt1 = l_sum[7].l_amt1 / 10000
               LET l_sum[8].l_amt1 = l_sum[8].l_amt1 / 10000
               LET l_sum[9].l_amt1 = l_sum[9].l_amt1 / 10000
               LET l_sum[10].l_amt1 = l_sum[10].l_amt1 / 10000
               LET l_sum[11].l_amt1 = l_sum[11].l_amt1 / 10000
               LET l_sum[12].l_amt1 = l_sum[12].l_amt1 / 10000
               LET l_sum[13].l_amt1 = l_sum[13].l_amt1 / 10000               
         END CASE

         #是否進行幣別轉換
         IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
            LET l_sum[1].l_amt1 = l_sum[1].l_amt1 * tm.rate
            LET l_sum[2].l_amt1 = l_sum[2].l_amt1 * tm.rate
            LET l_sum[3].l_amt1 = l_sum[3].l_amt1 * tm.rate
            LET l_sum[4].l_amt1 = l_sum[4].l_amt1 * tm.rate
            LET l_sum[5].l_amt1 = l_sum[5].l_amt1 * tm.rate
            LET l_sum[6].l_amt1 = l_sum[6].l_amt1 * tm.rate
            LET l_sum[7].l_amt1 = l_sum[7].l_amt1 * tm.rate
            LET l_sum[8].l_amt1 = l_sum[8].l_amt1 * tm.rate
            LET l_sum[9].l_amt1 = l_sum[9].l_amt1 * tm.rate
            LET l_sum[10].l_amt = l_sum[10].l_amt1 * tm.rate
            LET l_sum[11].l_amt = l_sum[11].l_amt1 * tm.rate
            LET l_sum[12].l_amt = l_sum[12].l_amt1 * tm.rate
            LET l_sum[13].l_amt = l_sum[13].l_amt1 * tm.rate
         END IF
            
         #小數取位
         CALL s_num_round('1',l_sum[1].l_amt1,tm.glfa009) RETURNING l_sum[1].l_amt1
         CALL s_num_round('1',l_sum[2].l_amt1,tm.glfa009) RETURNING l_sum[2].l_amt1
         CALL s_num_round('1',l_sum[3].l_amt1,tm.glfa009) RETURNING l_sum[3].l_amt1
         CALL s_num_round('1',l_sum[4].l_amt1,tm.glfa009) RETURNING l_sum[4].l_amt1
         CALL s_num_round('1',l_sum[5].l_amt1,tm.glfa009) RETURNING l_sum[5].l_amt1
         CALL s_num_round('1',l_sum[6].l_amt1,tm.glfa009) RETURNING l_sum[6].l_amt1
         CALL s_num_round('1',l_sum[7].l_amt1,tm.glfa009) RETURNING l_sum[7].l_amt1
         CALL s_num_round('1',l_sum[8].l_amt1,tm.glfa009) RETURNING l_sum[8].l_amt1
         CALL s_num_round('1',l_sum[9].l_amt1,tm.glfa009) RETURNING l_sum[9].l_amt1
         CALL s_num_round('1',l_sum[10].l_amt1,tm.glfa009) RETURNING l_sum[10].l_amt1
         CALL s_num_round('1',l_sum[11].l_amt1,tm.glfa009) RETURNING l_sum[11].l_amt1
         CALL s_num_round('1',l_sum[12].l_amt1,tm.glfa009) RETURNING l_sum[12].l_amt1
         CALL s_num_round('1',l_sum[13].l_amt1,tm.glfa009) RETURNING l_sum[13].l_amt1
         
         
         INSERT INTO aglq833_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,
         amt11,amt12,amt13)
         VALUES(l_seq,l_glbd001,l_glbdl003,l_glbd003,
                l_sum[1].l_amt1,l_sum[2].l_amt1,l_sum[3].l_amt1,l_sum[4].l_amt1,
                l_sum[5].l_amt1,l_sum[6].l_amt1,l_sum[7].l_amt1,l_sum[8].l_amt1,
                l_sum[9].l_amt1,l_sum[10].l_amt1,l_sum[11].l_amt1,l_sum[12].l_amt1,l_sum[13].l_amt1)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins aglq833_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF
      END FOREACH 
   END IF
   
   #附註揭露
   IF tm.type_c='Y' THEN
      FOREACH aglq833_cs10 INTO l_glbg005
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglq833_cs10'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_seq=l_seq+1
         FOR l_i=1 TO g_glav006
            #本期數
            EXECUTE aglq833_pr11 USING tm.glfa010,l_i,l_glbg005 INTO l_sum[l_i].l_amt
            IF cl_null(l_sum[l_i].l_amt) THEN LET l_sum[l_i].l_amt=0 END IF
         END FOR   
         
         CASE tm.glfa008
            WHEN '2'  #千
               LET l_sum[1].l_amt = l_sum[1].l_amt / 1000
               LET l_sum[2].l_amt = l_sum[2].l_amt / 1000
               LET l_sum[3].l_amt = l_sum[3].l_amt / 1000
               LET l_sum[4].l_amt = l_sum[4].l_amt / 1000
               LET l_sum[5].l_amt = l_sum[5].l_amt / 1000
               LET l_sum[6].l_amt = l_sum[6].l_amt / 1000
               LET l_sum[7].l_amt = l_sum[7].l_amt / 1000
               LET l_sum[8].l_amt = l_sum[8].l_amt / 1000
               LET l_sum[9].l_amt = l_sum[9].l_amt / 1000
               LET l_sum[10].l_amt = l_sum[10].l_amt / 1000
               LET l_sum[11].l_amt = l_sum[11].l_amt / 1000
               LET l_sum[12].l_amt = l_sum[12].l_amt / 1000
               LET l_sum[13].l_amt = l_sum[13].l_amt / 1000                 
            WHEN '3'  #萬
               LET l_sum[1].l_amt = l_sum[1].l_amt / 10000
               LET l_sum[2].l_amt = l_sum[2].l_amt / 10000
               LET l_sum[3].l_amt = l_sum[3].l_amt / 10000
               LET l_sum[4].l_amt = l_sum[4].l_amt / 10000
               LET l_sum[5].l_amt = l_sum[5].l_amt / 10000
               LET l_sum[6].l_amt = l_sum[6].l_amt / 10000
               LET l_sum[7].l_amt = l_sum[7].l_amt / 10000
               LET l_sum[8].l_amt = l_sum[8].l_amt / 10000
               LET l_sum[9].l_amt = l_sum[9].l_amt / 10000
               LET l_sum[10].l_amt = l_sum[10].l_amt / 10000
               LET l_sum[11].l_amt = l_sum[11].l_amt / 10000
               LET l_sum[12].l_amt = l_sum[12].l_amt / 10000
               LET l_sum[13].l_amt = l_sum[13].l_amt / 10000                 
         END CASE

         #是否進行幣別轉換
         IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
            LET l_sum[1].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[2].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[3].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[4].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[5].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[6].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[7].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[8].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[9].l_amt = l_sum[1].l_amt * tm.rate
            LET l_sum[10].l_amt = l_sum[10].l_amt * tm.rate
            LET l_sum[11].l_amt = l_sum[11].l_amt * tm.rate
            LET l_sum[12].l_amt = l_sum[12].l_amt * tm.rate
            LET l_sum[13].l_amt = l_sum[13].l_amt * tm.rate           
         END IF
            
         #小數取位
         CALL s_num_round('1',l_sum[1].l_amt,tm.glfa009) RETURNING l_sum[1].l_amt
         CALL s_num_round('1',l_sum[2].l_amt,tm.glfa009) RETURNING l_sum[2].l_amt
         CALL s_num_round('1',l_sum[3].l_amt,tm.glfa009) RETURNING l_sum[3].l_amt
         CALL s_num_round('1',l_sum[4].l_amt,tm.glfa009) RETURNING l_sum[4].l_amt
         CALL s_num_round('1',l_sum[5].l_amt,tm.glfa009) RETURNING l_sum[5].l_amt
         CALL s_num_round('1',l_sum[6].l_amt,tm.glfa009) RETURNING l_sum[6].l_amt
         CALL s_num_round('1',l_sum[7].l_amt,tm.glfa009) RETURNING l_sum[7].l_amt
         CALL s_num_round('1',l_sum[8].l_amt,tm.glfa009) RETURNING l_sum[8].l_amt
         CALL s_num_round('1',l_sum[9].l_amt,tm.glfa009) RETURNING l_sum[9].l_amt
         CALL s_num_round('1',l_sum[10].l_amt,tm.glfa009) RETURNING l_sum[10].l_amt
         CALL s_num_round('1',l_sum[11].l_amt,tm.glfa009) RETURNING l_sum[11].l_amt
         CALL s_num_round('1',l_sum[12].l_amt,tm.glfa009) RETURNING l_sum[12].l_amt
         CALL s_num_round('1',l_sum[13].l_amt,tm.glfa009) RETURNING l_sum[13].l_amt      
         
         INSERT INTO aglq833_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
         VALUES(l_seq,'',l_glbg005,'',
                l_sum[1].l_amt,l_sum[2].l_amt,l_sum[3].l_amt,l_sum[4].l_amt,
                l_sum[5].l_amt,l_sum[6].l_amt,l_sum[7].l_amt,l_sum[8].l_amt,
                l_sum[9].l_amt,l_sum[10].l_amt,l_sum[11].l_amt,l_sum[12].l_amt,l_sum[13].l_amt)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins aglq833_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF
      END FOREACH
   END IF
   
   IF g_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq833_tmp
      DELETE FROM aglq830_tmp
   END IF   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL aglq833_b_fill1()
# Date & Author..: 2016/10/25 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq833_b_fill1()
   DEFINE l_seq           LIKE glfb_t.glfbseq
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
   
   CALL g_glfb_d.clear()
   LET g_sql = "SELECT UNIQUE seq,glfb002,glfbl004,nmai004,amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,amt11,amt12,amt13",
               "  FROM aglq833_tmp ",
               " ORDER BY seq"
  
   PREPARE aglq833_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq833_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   #資產
   FOREACH b_fill_curs1 INTO l_seq,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004, 
                             g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2,g_glfb_d[l_ac].amt3,g_glfb_d[l_ac].amt4,
                             g_glfb_d[l_ac].amt5,g_glfb_d[l_ac].amt6,g_glfb_d[l_ac].amt7,g_glfb_d[l_ac].amt8,
                             g_glfb_d[l_ac].amt9,g_glfb_d[l_ac].amt10,g_glfb_d[l_ac].amt11,g_glfb_d[l_ac].amt12,
                             g_glfb_d[l_ac].amt13
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_glfb_d[l_ac].sel = "N"     
 
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
   CALL cl_set_comp_format("amt1,amt2,amt3,amt4,amt5,amt6,amt7,amt8,amt9,amt10,amt11,amt12,amt13",l_format)
   
   LET l_ac = 1
   CALL aglq833_fetch()
   
   CALL aglq833_filter_show('glfb002','b_glfb002')
   CALL aglq833_filter_show('glfbl004','b_glfbl004')
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL aglq833_glfa005_desc(p_glfa005)
# Date & Author..: 2016/10/25 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq833_glfa005_desc(p_glfa005)
   DEFINE p_glfa005             LIKE glfa_t.glfa005
   DEFINE r_desc                LIKE glaal_t.glaal002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glfa005
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

 
{</section>}
 
