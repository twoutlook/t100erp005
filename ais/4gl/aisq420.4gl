#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2014-12-29 13:56:38), PR版次:0007(2017-01-24 16:20:49)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000065
#+ Filename...: aisq420
#+ Description: 出貨發票查詢作業
#+ Creator....: 05016(2014-12-22 16:03:32)
#+ Modifier...: 05016 -SD/PR- 06821
 
{</section>}
 
{<section id="aisq420.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151231-00010#3  2016/01/21 By albireo    增加控制組判斷
#160414-00018#27 2016/05/16 By 03538      效能改善
#160920-00019#6  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#28 2016/10/24 By Reanna     來源組織(isagorga)增加ooef201 = 'Y'條件且需azzi800控卡
#170123-00045#4  2017/01/24 By 06821      SQL中撈取資料時使用 rownum 語法撰寫方式調整
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
PRIVATE TYPE type_g_isag_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   isagcomp LIKE isag_t.isagcomp, 
   isagdocno LIKE isag_t.isagdocno, 
   isagseq LIKE isag_t.isagseq, 
   isagorga LIKE isag_t.isagorga, 
   isagorga_desc LIKE type_t.chr500, 
   isaf002 LIKE isaf_t.isaf002, 
   isaf002_desc LIKE type_t.chr500, 
   isag002 LIKE isag_t.isag002, 
   isag003 LIKE isag_t.isag003, 
   isag009 LIKE isag_t.isag009, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   isafdocno LIKE isaf_t.isafdocno, 
   isafdocdt LIKE isaf_t.isafdocdt, 
   isaf018 LIKE isaf_t.isaf018, 
   isaf100 LIKE isaf_t.isaf100, 
   isat003 LIKE isat_t.isat003, 
   isat004 LIKE type_t.chr500, 
   isaf101 LIKE isaf_t.isaf101, 
   isag103 LIKE isag_t.isag103, 
   isag104 LIKE isag_t.isag104, 
   isag105 LIKE isag_t.isag105, 
   isag113 LIKE isag_t.isag113, 
   isag114 LIKE isag_t.isag114, 
   isag115 LIKE isag_t.isag115 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_combo       LIKE type_t.chr1
DEFINE g_isag002     LIKE isag_t.isag002
DEFINE g_isag003     LIKE isag_t.isag003
#151231-00010#3-----s
DEFINE g_ctl_where   STRING    #交易對象控制組WHERE CON
#151231-00010#3-----e
DEFINE g_wc_isagorga STRING    #161006-00005#28
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isag_d
DEFINE g_master_t                   type_g_isag_d
DEFINE g_isag_d          DYNAMIC ARRAY OF type_g_isag_d
DEFINE g_isag_d_t        type_g_isag_d
 
      
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
 
{<section id="aisq420.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_comp LIKE ooef_t.ooef001   #151231-00010#3
   DEFINE l_sql  STRING                #160414-00018#27
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ais","")
 
   #add-point:作業初始化 name="main.init"
   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
   CALL s_control_get_customer_sql('2',l_comp,g_user,g_dept,'') RETURNING g_sub_success,g_ctl_where   
   #151231-00010#3-----e 
   #160414-00018#27--s
   LET l_sql = "SELECT isat004 FROM isat_t ",
               " WHERE isatent = '",g_enterprise,"'",
               "   AND isatdocno = ? ",      
               "   AND  ((isat014 LIKE '11%')OR (isat014 LIKE '21%')) "
   PREPARE sel_isat004_pre FROM l_sql       
   DECLARE sel_isat004_curs CURSOR FOR sel_isat004_pre
   #160414-00018#27--e
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
   DECLARE aisq420_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq420_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq420_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq420 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq420_init()   
 
      #進入選單 Menu (="N")
      CALL aisq420_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq420
      
   END IF 
   
   CLOSE aisq420_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq420.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq420_init()
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
   LET g_isag002 = g_argv[1] #單號
   LET g_isag003 = g_argv[2] #項次
   
   IF NOT cl_null (g_isag003) THEN 
      LET g_combo = 1
   ELSE
      LET g_combo = 0
   END IF   
   CALL s_fin_create_account_center_tmp()  #161006-00005#28
   #end add-point
 
   CALL aisq420_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq420.default_search" >}
PRIVATE FUNCTION aisq420_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " isagcomp = '", g_argv[03], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " isagdocno = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " isagseq = '", g_argv[05], "' AND "
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
 
{<section id="aisq420.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq420_ui_dialog()
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
      CALL aisq420_b_fill()
   ELSE
      CALL aisq420_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isag_d.clear()
 
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
 
         CALL aisq420_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isag_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq420_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq420_detail_action_trans()
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
            CALL aisq420_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("insert,output", FALSE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aisq420_insert()
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
               CALL aisq420_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible('sel', FALSE)
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
            CALL aisq420_filter()
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
            CALL aisq420_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isag_d)
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
            CALL aisq420_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq420_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq420_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq420_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_isag_d.getLength()
               LET g_isag_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_isag_d.getLength()
               LET g_isag_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_isag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_isag_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_isag_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_isag_d[li_idx].sel = "N"
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
 
{<section id="aisq420.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq420_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_comp     LIKE ooef_t.ooef001
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_isag_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isagcomp,isagdocno,isagseq,isagorga,isaf002,isag002,isag003,isag009,imaal003, 
          imaal004,isafdocno,isafdocdt,isaf018,isaf100,isat003,isaf101,isag103,isag104,isag105,isag113, 
          isag114,isag115
           FROM s_detail1[1].b_isagcomp,s_detail1[1].b_isagdocno,s_detail1[1].b_isagseq,s_detail1[1].b_isagorga, 
               s_detail1[1].b_isaf002,s_detail1[1].b_isag002,s_detail1[1].b_isag003,s_detail1[1].b_isag009, 
               s_detail1[1].b_imaal003,s_detail1[1].b_imaal004,s_detail1[1].b_isafdocno,s_detail1[1].b_isafdocdt, 
               s_detail1[1].b_isaf018,s_detail1[1].b_isaf100,s_detail1[1].b_isat003,s_detail1[1].b_isaf101, 
               s_detail1[1].b_isag103,s_detail1[1].b_isag104,s_detail1[1].b_isag105,s_detail1[1].b_isag113, 
               s_detail1[1].b_isag114,s_detail1[1].b_isag115
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_isagcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isagcomp
            #add-point:BEFORE FIELD b_isagcomp name="construct.b.page1.b_isagcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isagcomp
            
            #add-point:AFTER FIELD b_isagcomp name="construct.a.page1.b_isagcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isagcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagcomp
            #add-point:ON ACTION controlp INFIELD b_isagcomp name="construct.c.page1.b_isagcomp"
            
            #END add-point
 
 
         #----<<b_isagdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isagdocno
            #add-point:BEFORE FIELD b_isagdocno name="construct.b.page1.b_isagdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isagdocno
            
            #add-point:AFTER FIELD b_isagdocno name="construct.a.page1.b_isagdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isagdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagdocno
            #add-point:ON ACTION controlp INFIELD b_isagdocno name="construct.c.page1.b_isagdocno"
            
            #END add-point
 
 
         #----<<b_isagseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isagseq
            #add-point:BEFORE FIELD b_isagseq name="construct.b.page1.b_isagseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isagseq
            
            #add-point:AFTER FIELD b_isagseq name="construct.a.page1.b_isagseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isagseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagseq
            #add-point:ON ACTION controlp INFIELD b_isagseq name="construct.c.page1.b_isagseq"
            
            #END add-point
 
 
         #----<<b_isagorga>>----
         #Ctrlp:construct.c.page1.b_isagorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagorga
            #add-point:ON ACTION controlp INFIELD b_isagorga name="construct.c.page1.b_isagorga"
            #來源組織
            #開窗c段
            #161006-00005#28 add ------
            CALL s_fin_account_center_sons_query('3',g_site,g_today,'1')
            CALL s_fin_account_center_sons_str() RETURNING g_wc_isagorga
            CALL s_fin_get_wc_str(g_wc_isagorga) RETURNING g_wc_isagorga
            #161006-00005#28 add end---
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef201 = 'Y' AND ooef001 IN ",g_wc_isagorga CLIPPED #161006-00005#28
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_isagorga
            NEXT FIELD b_isagorga
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isagorga
            #add-point:BEFORE FIELD b_isagorga name="construct.b.page1.b_isagorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isagorga
            
            #add-point:AFTER FIELD b_isagorga name="construct.a.page1.b_isagorga"
            
            #END add-point
            
 
 
         #----<<b_isagorga_desc>>----
         #----<<b_isaf002>>----
         #Ctrlp:construct.c.page1.b_isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf002
            #add-point:ON ACTION controlp INFIELD b_isaf002 name="construct.c.page1.b_isaf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #151231-00010#3-----s
            LET l_comp = NULL
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
            LET g_qryparam.where = g_ctl_where," AND EXISTS (SELECT 1 FROM pmab_t ",
                                               " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                               "   AND pmabsite = '",l_comp,"' )"
            #151231-00010#3-----e
            #CALL q_pmaa001()  #呼叫開窗   #160920-00019#6--mark
            CALL q_pmaa001_13()           #160920-00019#6--add
            DISPLAY g_qryparam.return1 TO b_isaf002
            NEXT FIELD b_isaf002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf002
            #add-point:BEFORE FIELD b_isaf002 name="construct.b.page1.b_isaf002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf002
            
            #add-point:AFTER FIELD b_isaf002 name="construct.a.page1.b_isaf002"
            
            #END add-point
            
 
 
         #----<<isaf002_desc>>----
         #----<<b_isag002>>----
         #Ctrlp:construct.c.page1.b_isag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag002
            #add-point:ON ACTION controlp INFIELD b_isag002 name="construct.c.page1.b_isag002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xmdk000 in ('1','2','3','6')  ",
                                   " AND xmdkstus = 'S' AND ( xmdk000='6' or (xmdk000<>'6' and xmdk002='1'))"
            CALL q_xmdkdocno_11()
            DISPLAY g_qryparam.return1 TO b_isag002
            NEXT FIELD b_isag002
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag002
            #add-point:BEFORE FIELD b_isag002 name="construct.b.page1.b_isag002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag002
            
            #add-point:AFTER FIELD b_isag002 name="construct.a.page1.b_isag002"
            
            #END add-point
            
 
 
         #----<<b_isag003>>----
         #Ctrlp:construct.c.page1.b_isag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag003
            #add-point:ON ACTION controlp INFIELD b_isag003 name="construct.c.page1.b_isag003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isag003  #顯示到畫面上
            NEXT FIELD b_isag003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag003
            #add-point:BEFORE FIELD b_isag003 name="construct.b.page1.b_isag003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag003
            
            #add-point:AFTER FIELD b_isag003 name="construct.a.page1.b_isag003"
            
            #END add-point
            
 
 
         #----<<b_isag009>>----
         #Ctrlp:construct.c.page1.b_isag009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag009
            #add-point:ON ACTION controlp INFIELD b_isag009 name="construct.c.page1.b_isag009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isag009  #顯示到畫面上
            NEXT FIELD b_isag009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag009
            #add-point:BEFORE FIELD b_isag009 name="construct.b.page1.b_isag009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag009
            
            #add-point:AFTER FIELD b_isag009 name="construct.a.page1.b_isag009"
            
            #END add-point
            
 
 
         #----<<b_imaal003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaal003
            #add-point:BEFORE FIELD b_imaal003 name="construct.b.page1.b_imaal003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaal003
            
            #add-point:AFTER FIELD b_imaal003 name="construct.a.page1.b_imaal003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal003
            #add-point:ON ACTION controlp INFIELD b_imaal003 name="construct.c.page1.b_imaal003"
            
            #END add-point
 
 
         #----<<b_imaal004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaal004
            #add-point:BEFORE FIELD b_imaal004 name="construct.b.page1.b_imaal004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaal004
            
            #add-point:AFTER FIELD b_imaal004 name="construct.a.page1.b_imaal004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal004
            #add-point:ON ACTION controlp INFIELD b_imaal004 name="construct.c.page1.b_imaal004"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.page1.b_isafdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isafstus = 'Y'"
            CALL q_isafdocno()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO b_isafdocno  #顯示到畫面上
            NEXT FIELD b_isafdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafdocno
            #add-point:BEFORE FIELD b_isafdocno name="construct.b.page1.b_isafdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafdocno
            
            #add-point:AFTER FIELD b_isafdocno name="construct.a.page1.b_isafdocno"
            
            #END add-point
            
 
 
         #----<<b_isafdocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isafdocdt
            #add-point:BEFORE FIELD b_isafdocdt name="construct.b.page1.b_isafdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isafdocdt
            
            #add-point:AFTER FIELD b_isafdocdt name="construct.a.page1.b_isafdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocdt
            #add-point:ON ACTION controlp INFIELD b_isafdocdt name="construct.c.page1.b_isafdocdt"
            
            #END add-point
 
 
         #----<<b_isaf018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf018
            #add-point:BEFORE FIELD b_isaf018 name="construct.b.page1.b_isaf018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf018
            
            #add-point:AFTER FIELD b_isaf018 name="construct.a.page1.b_isaf018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf018
            #add-point:ON ACTION controlp INFIELD b_isaf018 name="construct.c.page1.b_isaf018"
            
            #END add-point
 
 
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.page1.b_isaf100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf100  #顯示到畫面上
            NEXT FIELD b_isaf100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf100
            #add-point:BEFORE FIELD b_isaf100 name="construct.b.page1.b_isaf100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf100
            
            #add-point:AFTER FIELD b_isaf100 name="construct.a.page1.b_isaf100"
            
            #END add-point
            
 
 
         #----<<b_isat003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat003
            #add-point:BEFORE FIELD b_isat003 name="construct.b.page1.b_isat003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat003
            
            #add-point:AFTER FIELD b_isat003 name="construct.a.page1.b_isat003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat003
            #add-point:ON ACTION controlp INFIELD b_isat003 name="construct.c.page1.b_isat003"
            
            #END add-point
 
 
         #----<<b_isat004>>----
         #----<<b_isaf101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf101
            #add-point:BEFORE FIELD b_isaf101 name="construct.b.page1.b_isaf101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf101
            
            #add-point:AFTER FIELD b_isaf101 name="construct.a.page1.b_isaf101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf101
            #add-point:ON ACTION controlp INFIELD b_isaf101 name="construct.c.page1.b_isaf101"
            
            #END add-point
 
 
         #----<<b_isag103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag103
            #add-point:BEFORE FIELD b_isag103 name="construct.b.page1.b_isag103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag103
            
            #add-point:AFTER FIELD b_isag103 name="construct.a.page1.b_isag103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag103
            #add-point:ON ACTION controlp INFIELD b_isag103 name="construct.c.page1.b_isag103"
            
            #END add-point
 
 
         #----<<b_isag104>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag104
            #add-point:BEFORE FIELD b_isag104 name="construct.b.page1.b_isag104"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag104
            
            #add-point:AFTER FIELD b_isag104 name="construct.a.page1.b_isag104"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag104
            #add-point:ON ACTION controlp INFIELD b_isag104 name="construct.c.page1.b_isag104"
            
            #END add-point
 
 
         #----<<b_isag105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag105
            #add-point:BEFORE FIELD b_isag105 name="construct.b.page1.b_isag105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag105
            
            #add-point:AFTER FIELD b_isag105 name="construct.a.page1.b_isag105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag105
            #add-point:ON ACTION controlp INFIELD b_isag105 name="construct.c.page1.b_isag105"
            
            #END add-point
 
 
         #----<<b_isag113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag113
            #add-point:BEFORE FIELD b_isag113 name="construct.b.page1.b_isag113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag113
            
            #add-point:AFTER FIELD b_isag113 name="construct.a.page1.b_isag113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag113
            #add-point:ON ACTION controlp INFIELD b_isag113 name="construct.c.page1.b_isag113"
            
            #END add-point
 
 
         #----<<b_isag114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag114
            #add-point:BEFORE FIELD b_isag114 name="construct.b.page1.b_isag114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag114
            
            #add-point:AFTER FIELD b_isag114 name="construct.a.page1.b_isag114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag114
            #add-point:ON ACTION controlp INFIELD b_isag114 name="construct.c.page1.b_isag114"
            
            #END add-point
 
 
         #----<<b_isag115>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isag115
            #add-point:BEFORE FIELD b_isag115 name="construct.b.page1.b_isag115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isag115
            
            #add-point:AFTER FIELD b_isag115 name="construct.a.page1.b_isag115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isag115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag115
            #add-point:ON ACTION controlp INFIELD b_isag115 name="construct.c.page1.b_isag115"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_combo FROM combo
             ATTRIBUTE(WITHOUT DEFAULTS)              
         
         ON CHANGE combo
         IF g_combo = 0 THEN
            CALL cl_set_comp_visible('b_isag003,b_isag009,b_imaal003,b_imaal004',FALSE)
         ELSE
            CALL cl_set_comp_visible('b_isag003,b_isag009,b_imaal003,b_imaal004',TRUE)
         END IF
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
   #151231-00010#3-----s
   LET l_comp = NULL
   SELECT ooef017 INTO l_comp FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
                                            
   LET g_wc = g_wc CLIPPED," AND EXISTS   (SELECT 1 FROM pmaa_t,pmab_t ",
                                            " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                            "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                            "   AND pmabsite = '",l_comp,"'",
                                            "   AND pmaaent = isafent AND pmaa001 = isaf003 )"                                            
   #151231-00010#3-----e
   #end add-point
        
   LET g_error_show = 1
   CALL aisq420_b_fill()
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
 
{<section id="aisq420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq420_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_isat004       LIKE isat_t.isat004 
   #160414-00018#27--s
   DEFINE l_ooefl003_sql  STRING
   DEFINE l_pmaal004_sql  STRING
   DEFINE l_imaal003_sql  STRING
   DEFINE l_imaal004_sql  STRING
   DEFINE l_isat003_sql   STRING
   #160414-00018#27--e
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',isagcomp,isagdocno,isagseq,isagorga,'','','',isag002,isag003, 
       isag009,'','','','','','','','','',isag103,isag104,isag105,isag113,isag114,isag115  ,DENSE_RANK() OVER( ORDER BY isag_t.isagcomp, 
       isag_t.isagdocno,isag_t.isagseq) AS RANK FROM isag_t",
 
 
                     "",
                     " WHERE isagent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isag_t"),
                     " ORDER BY isag_t.isagcomp,isag_t.isagdocno,isag_t.isagseq"
 
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
 
   LET g_sql = "SELECT '',isagcomp,isagdocno,isagseq,isagorga,'','','',isag002,isag003,isag009,'','', 
       '','','','','','','',isag103,isag104,isag105,isag113,isag114,isag115",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #160414-00018#27--s
   LET l_ooefl003_sql = s_fin_get_department_sql('a','isagent','isagorga')
   LET l_pmaal004_sql = s_fin_get_trading_partner_abbr_sql('b','isagent','isaf002')
   LET l_imaal003_sql = " (SELECT imaal003 FROM imaal_t WHERE imaalent=isagent AND imaal001=isag009 AND imaal002='",g_dlang,"')"
   LET l_imaal004_sql = " (SELECT imaal004 FROM imaal_t WHERE imaalent=isagent AND imaal001=isag009 AND imaal002='",g_dlang,"')"
   #170123-00045#4 --s mark
   #LET l_isat003_sql =  " (SELECT DISTINCT isat003 FROM isat_t WHERE isatent = isagent AND isatdocno = isafdocno ",
   #                     "     AND ((isat014 LIKE '11%') OR (isat014 LIKE '21%')) AND rownum=1)"
   #170123-00045#4 --e mark
   #160414-00018#27--e
   #170123-00045#4 --s add
   LET l_isat003_sql = " SELECT DISTINCT isat003 FROM isat_t WHERE isatent = ",g_enterprise," AND isatdocno = ?  ",
                       "     AND ((isat014 LIKE '11%') OR (isat014 LIKE '21%'))"
   PREPARE aisq420_isat003_pre FROM l_isat003_sql    
   DECLARE aisq420_isat003_cur SCROLL CURSOR FOR aisq420_isat003_pre
   #170123-00045#4 --e add  
   
   IF g_combo = 0 THEN
      CALL cl_set_comp_visible('b_isag003,b_isag009,b_imaal003,b_imaal004',FALSE)
   ELSE
      CALL cl_set_comp_visible('b_isag003,b_isag009,b_imaal003,b_imaal004',TRUE)
   END IF
   DISPLAY g_combo TO combo   
   IF g_combo  = 1 THEN #明細
      LET g_sql = " SELECT 'N',''      ,''       ,''       ,isagorga,        ",
                 #"            ''      ,isaf002  ,''       ,isag002 ,        ",              #160414-00018#27 mark
                  "           ",l_ooefl003_sql," ,isaf002  ,",l_pmaal004_sql,",isag002 ,",   #160414-00018#27 
                 #"           isag003  ,isag009  ,''       ,''      ,        ",              #160414-00018#27 mark
                  "           isag003  ,isag009  ,",l_imaal003_sql,",",l_imaal004_sql,",",   #160414-00018#27 
                  "           isafdocno,isafdocdt,isaf018  ,isaf100 ,        ",
                 #"           ''       ,''       ,isaf101  ,                 ",              #160414-00018#27 mark
                  #"           ",l_isat003_sql,"  ,''       ,isaf101  ,       ",              #160414-00018#27  #170123-00045#4 mark
                  "           ''  ,''       ,isaf101  ,       ",                             #170123-00045#4 add 調整給值位置
                  "          isag103*isag015,isag104*isag015,isag105*isag015,", 
                  "          isag113*isag015,isag114*isag015,isag115*isag015 ", 
                  "   FROM isag_t,isaf_t                                     ",
                  "  WHERE isagent = isafent  AND isagent =?                 ",
                  "    AND isagdocno = isafdocno AND isafstus = 'Y'          "
       IF NOT cl_null(g_isag002) AND NOT cl_null(g_isag003)THEN
          LET g_sql = g_sql, " AND isag002 = '",g_isag002,"' AND isag003 = '",g_isag003,"' "
       ELSE
          LET g_sql = g_sql," AND ",ls_wc 
       END IF
   ELSE #匯總
      LET g_sql = " SELECT 'N',''      ,''        ,''       ,isagorga,         ",
                 #"            ''       ,isaf002  ,''       ,isag002 ,        ",               #160414-00018#27 mark
                  "           ",l_ooefl003_sql,"  ,isaf002   ,",l_pmaal004_sql,",isag002 ,",   #160414-00018#27 
                  "            ''       ,   ''     ,''       ,''      ,        ",
                  "           isafdocno ,isafdocdt ,isaf018  ,isaf100 ,        ",
                 #"           ''        ,''        ,isaf101  ,                 ",              #160414-00018#27 mark
                  #"           ",l_isat003_sql,"    ,''        ,isaf101  ,      ",              #160414-00018#27  #170123-00045#4 mark
                  "          '',''        ,isaf101  ,      ",                                  #170123-00045#4 add 調整給值位置
                  "          sum(isag103*isag015),sum(isag104*isag015),sum(isag105*isag015) ,          ",
                  "          sum(isag113*isag015),sum(isag114*isag015),sum(isag115*isag015)            ",      
                  "   FROM isag_t,isaf_t                                     ",
                  "  WHERE isagent = isafent  AND isagent =?                 ",
                  "    AND isagdocno = isafdocno AND isafstus = 'Y'          "                

      IF NOT cl_null(g_isag002)THEN
          LET g_sql = g_sql," AND isag002 = '",g_isag002,"' "
      ELSE
          LET g_sql = g_sql," AND ",ls_wc
      END IF
      LET g_sql = g_sql," GROUP By isagorga,isaf002,isag002,isafdocno,isafdocdt, ",
                        "          isaf018,isaf100,isaf101,isagent               "    #160414-00018#27 add isagent       
                       ," ORDER BY isagorga,isaf002,isag002,isafdocno,isafdocdt, ",   #160414-00018#27 
                        "          isaf018,isaf100,isaf101                       "    #160414-00018#27                        
   END IF
    
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq420_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq420_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isag_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isag_d[l_ac].sel,g_isag_d[l_ac].isagcomp,g_isag_d[l_ac].isagdocno,g_isag_d[l_ac].isagseq, 
       g_isag_d[l_ac].isagorga,g_isag_d[l_ac].isagorga_desc,g_isag_d[l_ac].isaf002,g_isag_d[l_ac].isaf002_desc, 
       g_isag_d[l_ac].isag002,g_isag_d[l_ac].isag003,g_isag_d[l_ac].isag009,g_isag_d[l_ac].imaal003, 
       g_isag_d[l_ac].imaal004,g_isag_d[l_ac].isafdocno,g_isag_d[l_ac].isafdocdt,g_isag_d[l_ac].isaf018, 
       g_isag_d[l_ac].isaf100,g_isag_d[l_ac].isat003,g_isag_d[l_ac].isat004,g_isag_d[l_ac].isaf101,g_isag_d[l_ac].isag103, 
       g_isag_d[l_ac].isag104,g_isag_d[l_ac].isag105,g_isag_d[l_ac].isag113,g_isag_d[l_ac].isag114,g_isag_d[l_ac].isag115 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isag_d[l_ac].statepic = cl_get_actipic(g_isag_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160414-00018#27 mark--s
      ##發票客戶
      #CALL s_desc_get_trading_partner_abbr_desc( g_isag_d[l_ac].isaf002) RETURNING g_isag_d[l_ac].isaf002_desc
      ##品名規格
      #CALL s_desc_get_item_desc(g_isag_d[l_ac].isag009)RETURNING g_isag_d[l_ac].imaal003,g_isag_d[l_ac].imaal004
      
      
      ##發票代碼/號碼
      #SELECT DISTINCT isat003
      #  INTO g_isag_d[l_ac].isat003
      #  FROM isat_t 
      # WHERE  isatdocno = g_isag_d[l_ac].isafdocno
      #   AND  ((isat014 LIKE '11%')OR (isat014 LIKE '21%'))
      #160414-00018#27 mark--e         
     
      #160414-00018#27 mod--s
      #LET l_sql=  "   SELECT isat004                                        ",
      #            "     FROM isat_t                                         ",
      #            "    WHERE  isatdocno =  '",g_isag_d[l_ac].isafdocno,"'    ",      
      #            "      AND  ((isat014 LIKE '11%')OR (isat014 LIKE '21%')) "
      #PREPARE aisq420_pre  FROM l_sql
      #DECLARE aisq420_curs CURSOR FOR aisq420_pre
      #FOREACH aisq420_curs INTO l_isat004
      
      #170123-00045#4 --s add
      OPEN aisq420_isat003_cur USING g_isag_d[l_ac].isafdocno
      FETCH FIRST aisq420_isat003_cur INTO g_isag_d[l_ac].isat003
      CLOSE aisq420_isat003_cur 
      #170123-00045#4 --e add       
      
      FOREACH sel_isat004_curs USING g_isag_d[l_ac].isafdocno INTO l_isat004
      #160414-00018#27 mod--e
         IF NOT cl_null(l_isat004)THEN 
            IF cl_null(g_isag_d[l_ac].isat004 ) THEN
               LET g_isag_d[l_ac].isat004 = l_isat004
            ELSE
               LET g_isag_d[l_ac].isat004 = g_isag_d[l_ac].isat004,'/',l_isat004
            END IF
         END IF
      END FOREACH
      
      #end add-point
 
      CALL aisq420_detail_show("'1'")      
 
      CALL aisq420_isag_t_mask()
 
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
   
 
   
   CALL g_isag_d.deleteElement(g_isag_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isag_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq420_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq420_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq420_detail_action_trans()
 
   IF g_isag_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq420_fetch()
   END IF
   
      CALL aisq420_filter_show('isagcomp','b_isagcomp')
   CALL aisq420_filter_show('isagdocno','b_isagdocno')
   CALL aisq420_filter_show('isagseq','b_isagseq')
   CALL aisq420_filter_show('isagorga','b_isagorga')
   CALL aisq420_filter_show('isaf002','b_isaf002')
   CALL aisq420_filter_show('isag002','b_isag002')
   CALL aisq420_filter_show('isag003','b_isag003')
   CALL aisq420_filter_show('isag009','b_isag009')
   CALL aisq420_filter_show('imaal003','b_imaal003')
   CALL aisq420_filter_show('imaal004','b_imaal004')
   CALL aisq420_filter_show('isafdocno','b_isafdocno')
   CALL aisq420_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq420_filter_show('isaf018','b_isaf018')
   CALL aisq420_filter_show('isaf100','b_isaf100')
   CALL aisq420_filter_show('isat003','b_isat003')
   CALL aisq420_filter_show('isaf101','b_isaf101')
   CALL aisq420_filter_show('isag103','b_isag103')
   CALL aisq420_filter_show('isag104','b_isag104')
   CALL aisq420_filter_show('isag105','b_isag105')
   CALL aisq420_filter_show('isag113','b_isag113')
   CALL aisq420_filter_show('isag114','b_isag114')
   CALL aisq420_filter_show('isag115','b_isag115')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq420_fetch()
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
 
{<section id="aisq420.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq420_detail_show(ps_page)
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
           #160414-00018#27 mark--s
           #INITIALIZE g_ref_fields TO NULL
           #LET g_ref_fields[1] = g_isag_d[l_ac].isagorga
           #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
           #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
           #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
           #LET g_isag_d[l_ac].isagorga_desc = '', g_rtn_fields[1] , ''
           #DISPLAY BY NAME g_isag_d[l_ac].isagorga_desc
           #160414-00018#27 mark--e

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq420_filter()
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
      CONSTRUCT g_wc_filter ON isagcomp,isagdocno,isagseq,isagorga,isaf002,isag002,isag003,isag009,imaal003, 
          imaal004,isafdocno,isafdocdt,isaf018,isaf100,isat003,isaf101,isag103,isag104,isag105,isag113, 
          isag114,isag115
                          FROM s_detail1[1].b_isagcomp,s_detail1[1].b_isagdocno,s_detail1[1].b_isagseq, 
                              s_detail1[1].b_isagorga,s_detail1[1].b_isaf002,s_detail1[1].b_isag002, 
                              s_detail1[1].b_isag003,s_detail1[1].b_isag009,s_detail1[1].b_imaal003, 
                              s_detail1[1].b_imaal004,s_detail1[1].b_isafdocno,s_detail1[1].b_isafdocdt, 
                              s_detail1[1].b_isaf018,s_detail1[1].b_isaf100,s_detail1[1].b_isat003,s_detail1[1].b_isaf101, 
                              s_detail1[1].b_isag103,s_detail1[1].b_isag104,s_detail1[1].b_isag105,s_detail1[1].b_isag113, 
                              s_detail1[1].b_isag114,s_detail1[1].b_isag115
 
         BEFORE CONSTRUCT
                     DISPLAY aisq420_filter_parser('isagcomp') TO s_detail1[1].b_isagcomp
            DISPLAY aisq420_filter_parser('isagdocno') TO s_detail1[1].b_isagdocno
            DISPLAY aisq420_filter_parser('isagseq') TO s_detail1[1].b_isagseq
            DISPLAY aisq420_filter_parser('isagorga') TO s_detail1[1].b_isagorga
            DISPLAY aisq420_filter_parser('isaf002') TO s_detail1[1].b_isaf002
            DISPLAY aisq420_filter_parser('isag002') TO s_detail1[1].b_isag002
            DISPLAY aisq420_filter_parser('isag003') TO s_detail1[1].b_isag003
            DISPLAY aisq420_filter_parser('isag009') TO s_detail1[1].b_isag009
            DISPLAY aisq420_filter_parser('imaal003') TO s_detail1[1].b_imaal003
            DISPLAY aisq420_filter_parser('imaal004') TO s_detail1[1].b_imaal004
            DISPLAY aisq420_filter_parser('isafdocno') TO s_detail1[1].b_isafdocno
            DISPLAY aisq420_filter_parser('isafdocdt') TO s_detail1[1].b_isafdocdt
            DISPLAY aisq420_filter_parser('isaf018') TO s_detail1[1].b_isaf018
            DISPLAY aisq420_filter_parser('isaf100') TO s_detail1[1].b_isaf100
            DISPLAY aisq420_filter_parser('isat003') TO s_detail1[1].b_isat003
            DISPLAY aisq420_filter_parser('isaf101') TO s_detail1[1].b_isaf101
            DISPLAY aisq420_filter_parser('isag103') TO s_detail1[1].b_isag103
            DISPLAY aisq420_filter_parser('isag104') TO s_detail1[1].b_isag104
            DISPLAY aisq420_filter_parser('isag105') TO s_detail1[1].b_isag105
            DISPLAY aisq420_filter_parser('isag113') TO s_detail1[1].b_isag113
            DISPLAY aisq420_filter_parser('isag114') TO s_detail1[1].b_isag114
            DISPLAY aisq420_filter_parser('isag115') TO s_detail1[1].b_isag115
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_isagcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isagcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagcomp
            #add-point:ON ACTION controlp INFIELD b_isagcomp name="construct.c.filter.page1.b_isagcomp"
            
            #END add-point
 
 
         #----<<b_isagdocno>>----
         #Ctrlp:construct.c.filter.page1.b_isagdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagdocno
            #add-point:ON ACTION controlp INFIELD b_isagdocno name="construct.c.filter.page1.b_isagdocno"
            
            #END add-point
 
 
         #----<<b_isagseq>>----
         #Ctrlp:construct.c.filter.page1.b_isagseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagseq
            #add-point:ON ACTION controlp INFIELD b_isagseq name="construct.c.filter.page1.b_isagseq"
            
            #END add-point
 
 
         #----<<b_isagorga>>----
         #Ctrlp:construct.c.page1.b_isagorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isagorga
            #add-point:ON ACTION controlp INFIELD b_isagorga name="construct.c.filter.page1.b_isagorga"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isagorga  #顯示到畫面上
            NEXT FIELD b_isagorga                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isagorga_desc>>----
         #----<<b_isaf002>>----
         #Ctrlp:construct.c.page1.b_isaf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf002
            #add-point:ON ACTION controlp INFIELD b_isaf002 name="construct.c.filter.page1.b_isaf002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_pmaa001()  #呼叫開窗   #160920-00019#6--mark   
            CALL q_pmaa001_13()           #160920-00019#6--add
            DISPLAY g_qryparam.return1 TO b_isaf002  #顯示到畫面上
            NEXT FIELD b_isaf002                     #返回原欄位
    


            #END add-point
 
 
         #----<<isaf002_desc>>----
         #----<<b_isag002>>----
         #Ctrlp:construct.c.page1.b_isag002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag002
            #add-point:ON ACTION controlp INFIELD b_isag002 name="construct.c.filter.page1.b_isag002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isag002  #顯示到畫面上
            NEXT FIELD b_isag002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isag003>>----
         #Ctrlp:construct.c.page1.b_isag003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag003
            #add-point:ON ACTION controlp INFIELD b_isag003 name="construct.c.filter.page1.b_isag003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_xrcadocno_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isag003  #顯示到畫面上
            NEXT FIELD b_isag003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isag009>>----
         #Ctrlp:construct.c.page1.b_isag009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag009
            #add-point:ON ACTION controlp INFIELD b_isag009 name="construct.c.filter.page1.b_isag009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaf001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isag009  #顯示到畫面上
            NEXT FIELD b_isag009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaal003>>----
         #Ctrlp:construct.c.filter.page1.b_imaal003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal003
            #add-point:ON ACTION controlp INFIELD b_imaal003 name="construct.c.filter.page1.b_imaal003"
            
            #END add-point
 
 
         #----<<b_imaal004>>----
         #Ctrlp:construct.c.filter.page1.b_imaal004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaal004
            #add-point:ON ACTION controlp INFIELD b_imaal004 name="construct.c.filter.page1.b_imaal004"
            
            #END add-point
 
 
         #----<<b_isafdocno>>----
         #Ctrlp:construct.c.page1.b_isafdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocno
            #add-point:ON ACTION controlp INFIELD b_isafdocno name="construct.c.filter.page1.b_isafdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isafdocno  #顯示到畫面上
            NEXT FIELD b_isafdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isafdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_isafdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isafdocdt
            #add-point:ON ACTION controlp INFIELD b_isafdocdt name="construct.c.filter.page1.b_isafdocdt"
            
            #END add-point
 
 
         #----<<b_isaf018>>----
         #Ctrlp:construct.c.filter.page1.b_isaf018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf018
            #add-point:ON ACTION controlp INFIELD b_isaf018 name="construct.c.filter.page1.b_isaf018"
            
            #END add-point
 
 
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.filter.page1.b_isaf100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isaf100  #顯示到畫面上
            NEXT FIELD b_isaf100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isat003>>----
         #Ctrlp:construct.c.filter.page1.b_isat003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat003
            #add-point:ON ACTION controlp INFIELD b_isat003 name="construct.c.filter.page1.b_isat003"
            
            #END add-point
 
 
         #----<<b_isat004>>----
         #----<<b_isaf101>>----
         #Ctrlp:construct.c.filter.page1.b_isaf101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf101
            #add-point:ON ACTION controlp INFIELD b_isaf101 name="construct.c.filter.page1.b_isaf101"
            
            #END add-point
 
 
         #----<<b_isag103>>----
         #Ctrlp:construct.c.filter.page1.b_isag103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag103
            #add-point:ON ACTION controlp INFIELD b_isag103 name="construct.c.filter.page1.b_isag103"
            
            #END add-point
 
 
         #----<<b_isag104>>----
         #Ctrlp:construct.c.filter.page1.b_isag104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag104
            #add-point:ON ACTION controlp INFIELD b_isag104 name="construct.c.filter.page1.b_isag104"
            
            #END add-point
 
 
         #----<<b_isag105>>----
         #Ctrlp:construct.c.filter.page1.b_isag105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag105
            #add-point:ON ACTION controlp INFIELD b_isag105 name="construct.c.filter.page1.b_isag105"
            
            #END add-point
 
 
         #----<<b_isag113>>----
         #Ctrlp:construct.c.filter.page1.b_isag113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag113
            #add-point:ON ACTION controlp INFIELD b_isag113 name="construct.c.filter.page1.b_isag113"
            
            #END add-point
 
 
         #----<<b_isag114>>----
         #Ctrlp:construct.c.filter.page1.b_isag114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag114
            #add-point:ON ACTION controlp INFIELD b_isag114 name="construct.c.filter.page1.b_isag114"
            
            #END add-point
 
 
         #----<<b_isag115>>----
         #Ctrlp:construct.c.filter.page1.b_isag115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isag115
            #add-point:ON ACTION controlp INFIELD b_isag115 name="construct.c.filter.page1.b_isag115"
            
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
   
      CALL aisq420_filter_show('isagcomp','b_isagcomp')
   CALL aisq420_filter_show('isagdocno','b_isagdocno')
   CALL aisq420_filter_show('isagseq','b_isagseq')
   CALL aisq420_filter_show('isagorga','b_isagorga')
   CALL aisq420_filter_show('isaf002','b_isaf002')
   CALL aisq420_filter_show('isag002','b_isag002')
   CALL aisq420_filter_show('isag003','b_isag003')
   CALL aisq420_filter_show('isag009','b_isag009')
   CALL aisq420_filter_show('imaal003','b_imaal003')
   CALL aisq420_filter_show('imaal004','b_imaal004')
   CALL aisq420_filter_show('isafdocno','b_isafdocno')
   CALL aisq420_filter_show('isafdocdt','b_isafdocdt')
   CALL aisq420_filter_show('isaf018','b_isaf018')
   CALL aisq420_filter_show('isaf100','b_isaf100')
   CALL aisq420_filter_show('isat003','b_isat003')
   CALL aisq420_filter_show('isaf101','b_isaf101')
   CALL aisq420_filter_show('isag103','b_isag103')
   CALL aisq420_filter_show('isag104','b_isag104')
   CALL aisq420_filter_show('isag105','b_isag105')
   CALL aisq420_filter_show('isag113','b_isag113')
   CALL aisq420_filter_show('isag114','b_isag114')
   CALL aisq420_filter_show('isag115','b_isag115')
 
    
   CALL aisq420_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq420_filter_parser(ps_field)
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
 
{<section id="aisq420.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq420_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.insert" >}
#+ insert
PRIVATE FUNCTION aisq420_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq420.modify" >}
#+ modify
PRIVATE FUNCTION aisq420_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq420_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.delete" >}
#+ delete
PRIVATE FUNCTION aisq420_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq420.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq420_detail_action_trans()
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
 
{<section id="aisq420.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq420_detail_index_setting()
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
            IF g_isag_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isag_d.getLength() AND g_isag_d.getLength() > 0
            LET g_detail_idx = g_isag_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isag_d.getLength() THEN
               LET g_detail_idx = g_isag_d.getLength()
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
 
{<section id="aisq420.mask_functions" >}
 &include "erp/ais/aisq420_mask.4gl"
 
{</section>}
 
{<section id="aisq420.other_function" readonly="Y" >}

 
{</section>}
 
