#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq501.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-10-10 15:09:18), PR版次:0002(2016-04-20 15:32:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000061
#+ Filename...: aglq501
#+ Description: 傳票過帳後檢查
#+ Creator....: 02599(2015-10-08 17:30:55)
#+ Modifier...: 02599 -SD/PR- 07675
 
{</section>}
 
{<section id="aglq501.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#7   2016/04/20 By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
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
PRIVATE TYPE type_g_glar_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glar001 LIKE glar_t.glar001, 
   glar001_desc LIKE type_t.chr500, 
   glar009 LIKE glar_t.glar009, 
   odamt1 LIKE type_t.num20_6, 
   odamt2 LIKE type_t.num20_6, 
   oddiff LIKE type_t.num20_6, 
   ocamt1 LIKE type_t.num20_6, 
   ocamt2 LIKE type_t.num20_6, 
   ocdiff LIKE type_t.num20_6, 
   damt1 LIKE type_t.num20_6, 
   damt2 LIKE type_t.num20_6, 
   ddiff LIKE type_t.num20_6, 
   camt1 LIKE type_t.num20_6, 
   camt2 LIKE type_t.num20_6, 
   cdiff LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_glar2_d RECORD
       glaq002 LIKE type_t.chr500, 
   glaq002_desc LIKE type_t.chr500, 
   glaq005 LIKE type_t.chr10, 
   odsum1 LIKE type_t.num20_6, 
   odsum2 LIKE type_t.num20_6, 
   diff01 LIKE type_t.num20_6, 
   ocsum1 LIKE type_t.num20_6, 
   ocsum2 LIKE type_t.num20_6, 
   diff02 LIKE type_t.num20_6, 
   dsum1 LIKE type_t.num20_6, 
   dsum2 LIKE type_t.num20_6, 
   diff03 LIKE type_t.num20_6, 
   csum1 LIKE type_t.num20_6, 
   csum2 LIKE type_t.num20_6, 
   diff04 LIKE type_t.num20_6
       END RECORD
 
 
 
#模組變數(Module Variables)
DEFINE g_glar2_d   DYNAMIC ARRAY OF type_g_glar2_d
DEFINE g_glar2_d_t type_g_glar2_d
DEFINE l_ac2       LIKE type_t.num10

DEFINE tm              RECORD
       glaald          LIKE glaa_t.glaald,
       glaald_desc     LIKE glaal_t.glaal002,
       glaacomp        LIKE glaa_t.glaacomp,
       glaacomp_desc   LIKE ooefl_t.ooefl003,
       syear           LIKE glaa_t.glaa010,    #起始年度
       smonth          LIKE glaa_t.glaa011,    #起始期別
       eyear           LIKE glaa_t.glaa010,    #截止年度
       emonth          LIKE glaa_t.glaa011,    #截止期別
       chk1            LIKE type_t.chr1,       #檢查上級科目與下級科目匯總金額是否一致
       chk2            LIKE type_t.chr1        #檢查傳票金額與統計檔金額是否一致
       END RECORD
DEFINE g_glaa001       LIKE glaa_t.glaa001
DEFINE g_glaa003       LIKE glaa_t.glaa003
DEFINE g_glaa004       LIKE glaa_t.glaa004
DEFINE g_glaa015       LIKE glaa_t.glaa015
DEFINE g_glaa016       LIKE glaa_t.glaa016
DEFINE g_glaa019       LIKE glaa_t.glaa019
DEFINE g_glaa020       LIKE glaa_t.glaa020
DEFINE g_max_period    LIKE glap_t.glap004
DEFINE g_max_period2   LIKE glap_t.glap004
DEFINE g_flag          LIKE type_t.num5    #标示当前光标在哪个页签中
#用于显示可打印页签
DEFINE gr_page         DYNAMIC ARRAY OF RECORD
       l_sel           LIKE type_t.chr1,
       l_page          LIKE type_t.chr50
       END RECORD
DEFINE g_page_name     DYNAMIC ARRAY OF VARCHAR(200)      
DEFINE g_data_cnt      LIKE type_t.num5
DEFINE g_accept        LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glar_d
DEFINE g_master_t                   type_g_glar_d
DEFINE g_glar_d          DYNAMIC ARRAY OF type_g_glar_d
DEFINE g_glar_d_t        type_g_glar_d
 
      
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
 
{<section id="aglq501.main" >}
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
   DECLARE aglq501_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq501_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq501_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq501 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq501_init()   
 
      #進入選單 Menu (="N")
      CALL aglq501_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq501
      
   END IF 
   
   CLOSE aglq501_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq501_tmp1
   DROP TABLE aglq501_tmp2
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq501.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq501_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success   LIKE type_t.num5
   DEFINE l_pass      LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   #获取账别
   IF cl_null(tm.glaald) THEN
      CALL s_ld_bookno()  RETURNING l_success,tm.glaald
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,tm.glaald) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = tm.glaald
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN
      END IF
   END IF
   CALL aglq501_glaald_desc(tm.glaald)   
   CALL aglq501_set_default_value()
   
   CALL aglq501_creat_temp_table()
   #end add-point
 
   CALL aglq501_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq501.default_search" >}
PRIVATE FUNCTION aglq501_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glarld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glar001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glar002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glar003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " glar004 = '", g_argv[05], "' AND "
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
 
{<section id="aglq501.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq501_ui_dialog()
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
   LET g_flag = 1  #标示在第一个页签“上級與下級科目匯總金額差異清單” 中
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aglq501_b_fill()
   ELSE
      CALL aglq501_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glar_d.clear()
 
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
 
         CALL aglq501_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glar_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq501_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq501_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               LET g_flag = 1  #标示在第一个页签“上級與下級科目匯總金額差異清單” 中
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_glar2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq501_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq501_detail_action_trans()
               #add-point:input段before row
               LET g_flag = 2  #标示在第一个页签“傳票與統計檔金額差異清單” 中
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq501_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            IF g_flag = 2 THEN
               NEXT FIELD glaq002
            END IF
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq501_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aglq501_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq501_query()
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
            CALL aglq501_filter()
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
            CALL aglq501_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glar_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               LET g_export_node[2] = base.typeInfo.create(g_glar2_d)
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
            CALL aglq501_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq501_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq501_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq501_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glar_d.getLength()
               LET g_glar_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glar_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glar_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify_detail") THEN
               IF g_detail_idx>=1 THEN
                  CALL aglq501_cmdrun() #串查aglq740或aglq760資料                    
               END IF
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
 
{<section id="aglq501.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq501_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_pass      LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glar_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glar001,glar009
           FROM s_detail1[1].b_glar001,s_detail1[1].b_glar009
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001 name="construct.c.page1.b_glar001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar001
            #add-point:BEFORE FIELD b_glar001 name="construct.b.page1.b_glar001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar001
            
            #add-point:AFTER FIELD b_glar001 name="construct.a.page1.b_glar001"
            
            #END add-point
            
 
 
         #----<<b_glar001_desc>>----
         #----<<b_glar009>>----
         #Ctrlp:construct.c.page1.b_glar009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009 name="construct.c.page1.b_glar009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glar009
            #add-point:BEFORE FIELD b_glar009 name="construct.b.page1.b_glar009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glar009
            
            #add-point:AFTER FIELD b_glar009 name="construct.a.page1.b_glar009"
            
            #END add-point
            
 
 
         #----<<odamt1>>----
         #----<<odamt2>>----
         #----<<oddiff>>----
         #----<<ocamt1>>----
         #----<<ocamt2>>----
         #----<<ocdiff>>----
         #----<<damt1>>----
         #----<<damt2>>----
         #----<<ddiff>>----
         #----<<camt1>>----
         #----<<camt2>>----
         #----<<cdiff>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME tm.glaald,tm.glaacomp,tm.syear,tm.smonth,tm.eyear,tm.emonth,tm.chk1,tm.chk2
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            DISPLAY BY NAME tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,
                            tm.syear,tm.smonth,tm.eyear,tm.emonth,tm.chk1,tm.chk2
         AFTER FIELD glaald
            IF NOT cl_null(tm.glaald) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.glaald
               #160318-00025#7--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "agl-00051:sub-01302|agli010|",cl_get_progname("agli010",g_lang,"2"),"|:EXEPROGagli010"
               #160318-00025#7--add--end  
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glaald") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.glaald=''
                  NEXT FIELD CURRENT
               END IF
               
               CALL s_ld_chk_authorization(g_user,tm.glaald) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = tm.glaald
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               
                  NEXT FIELD glaald
               END IF
               CALL aglq501_glaald_desc(tm.glaald)
               DISPLAY BY NAME tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc
            END IF
         
         AFTER FIELD syear
            IF NOT cl_null(tm.syear) THEN
               IF NOT cl_null(tm.eyear) AND tm.syear > tm.eyear THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00378'
                  LET g_errparam.extend = tm.syear
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD syear
               END IF
               IF NOT cl_null(tm.eyear) AND NOT cl_null(tm.smonth) AND NOT cl_null(tm.emonth) AND 
                  tm.syear = tm.eyear AND tm.smonth > tm.emonth THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00227'
                  LET g_errparam.extend = tm.smonth
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD smonth
               END IF
                
               #獲取現行會計週期最大期別
               SELECT MAX(glav006) INTO g_max_period FROM glav_t 
               WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
               
            END IF
            
         AFTER FIELD smonth
            IF NOT cl_null(tm.smonth) THEN
               IF NOT cl_ap_chk_Range(tm.smonth,"0","1",g_max_period,"1","azz-00087",1) THEN
                  NEXT FIELD smonth
               END IF
               IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.emonth) AND 
                  tm.syear = tm.eyear AND tm.smonth > tm.emonth THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00227'
                  LET g_errparam.extend = tm.smonth
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD smonth
               END IF
            END IF
          
         AFTER FIELD eyear
            IF NOT cl_null(tm.eyear) THEN
               IF NOT cl_null(tm.syear) AND tm.eyear < tm.syear THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00373'
                  LET g_errparam.extend = tm.eyear
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD eyear
               END IF
               IF NOT cl_null(tm.syear) AND NOT cl_null(tm.smonth) AND NOT cl_null(tm.emonth) AND 
                  tm.syear = tm.eyear AND tm.emonth < tm.smonth THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00228'
                  LET g_errparam.extend = tm.emonth
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD emonth
               END IF
               
               #獲取現行會計週期最大期別
               SELECT MAX(glav006) INTO g_max_period2 FROM glav_t 
               WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.eyear
               
            END IF
            
         AFTER FIELD emonth
            IF NOT cl_null(tm.emonth) THEN
               IF NOT cl_ap_chk_Range(tm.emonth,"0","1",g_max_period,"1","azz-00087",1) THEN
                  NEXT FIELD emonth
               END IF
               IF NOT cl_null(tm.syear) AND NOT cl_null(tm.eyear) AND NOT cl_null(tm.smonth) AND 
                  tm.syear = tm.eyear AND tm.emonth < tm.smonth THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00228'
                  LET g_errparam.extend = tm.emonth
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD emonth
               END IF
            END IF
            
         AFTER FIELD chk1
            IF tm.chk1 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk1
            END IF
            IF tm.chk1 = 'Y' THEN
               CALL cl_set_comp_visible("page_1",TRUE)
            ELSE
               CALL cl_set_comp_visible("page_1",FALSE)
            END IF
            
        AFTER FIELD chk2
            IF tm.chk2 NOT MATCHES '[yYnN]' THEN
               NEXT FIELD chk2
            END IF
            IF tm.chk2 = 'Y' THEN
               CALL cl_set_comp_visible("page_2",TRUE)
            ELSE
               CALL cl_set_comp_visible("page_2",FALSE)
            END IF
        
        ON ACTION controlp INFIELD glaald
           INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'i'
           LET g_qryparam.reqry = FALSE
           #給予arg
           LET g_qryparam.arg1 = g_user
           LET g_qryparam.arg2 = g_dept
           CALL q_authorised_ld()                                #呼叫開窗
           LET tm.glaald = g_qryparam.return1
           DISPLAY tm.glaald TO glaald 
           NEXT FIELD glaald
               
        AFTER INPUT
            IF NOT cl_null(tm.smonth) AND NOT cl_ap_chk_Range(tm.smonth,"0","1",g_max_period,"1","azz-00087",1) THEN
               NEXT FIELD smonth
            END IF
            IF NOT cl_null(tm.emonth) AND NOT cl_ap_chk_Range(tm.emonth,"0","1",g_max_period2,"1","azz-00087",1) THEN
               NEXT FIELD emonth
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
   
   #end add-point
        
   LET g_error_show = 1
   CALL aglq501_b_fill()
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
 
{<section id="aglq501.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq501_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL cl_err_collect_init()
   #检查统制科目与其下属明细科目汇总金额是否一致
   IF tm.chk1 = 'Y' THEN
     CALL aglq501_b_fill1()
   END IF
   #检查凭证金额与统计档金额是否一致
   IF tm.chk2 = 'Y' THEN
      CALL aglq501_b_fill2()
   END IF
   CALL cl_err_collect_show()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glar001,'',glar009,'','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glar_t.glarld, 
       glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004) AS RANK FROM glar_t",
 
 
                     "",
                     " WHERE glarent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glar_t"),
                     " ORDER BY glar_t.glarld,glar_t.glar001,glar_t.glar002,glar_t.glar003,glar_t.glar004"
 
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
 
   LET g_sql = "SELECT '',glar001,'',glar009,'','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq501_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq501_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glar_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glar_d[l_ac].sel,g_glar_d[l_ac].glar001,g_glar_d[l_ac].glar001_desc,g_glar_d[l_ac].glar009, 
       g_glar_d[l_ac].odamt1,g_glar_d[l_ac].odamt2,g_glar_d[l_ac].oddiff,g_glar_d[l_ac].ocamt1,g_glar_d[l_ac].ocamt2, 
       g_glar_d[l_ac].ocdiff,g_glar_d[l_ac].damt1,g_glar_d[l_ac].damt2,g_glar_d[l_ac].ddiff,g_glar_d[l_ac].camt1, 
       g_glar_d[l_ac].camt2,g_glar_d[l_ac].cdiff
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glar_d[l_ac].statepic = cl_get_actipic(g_glar_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq501_detail_show("'1'")      
 
      CALL aglq501_glar_t_mask()
 
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
   
 
   
   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glar_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq501_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq501_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq501_detail_action_trans()
 
   IF g_glar_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq501_fetch()
   END IF
   
      CALL aglq501_filter_show('glar001','b_glar001')
   CALL aglq501_filter_show('glar009','b_glar009')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq501_fetch()
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
 
{<section id="aglq501.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq501_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_glar_d[l_ac].glar001
            LET ls_sql = "SELECT glacl004 FROM glacl_t WHERE glaclent='"||g_enterprise||"' AND glacl001='' AND glacl002=? AND glacl003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_glar_d[l_ac].glar001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_glar_d[l_ac].glar001_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq501_filter()
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
      CONSTRUCT g_wc_filter ON glar001,glar009
                          FROM s_detail1[1].b_glar001,s_detail1[1].b_glar009
 
         BEFORE CONSTRUCT
                     DISPLAY aglq501_filter_parser('glar001') TO s_detail1[1].b_glar001
            DISPLAY aglq501_filter_parser('glar009') TO s_detail1[1].b_glar009
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glar001>>----
         #Ctrlp:construct.c.page1.b_glar001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar001
            #add-point:ON ACTION controlp INFIELD b_glar001 name="construct.c.filter.page1.b_glar001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL aglt310_04()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar001  #顯示到畫面上
            NEXT FIELD b_glar001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glar001_desc>>----
         #----<<b_glar009>>----
         #Ctrlp:construct.c.page1.b_glar009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glar009
            #add-point:ON ACTION controlp INFIELD b_glar009 name="construct.c.filter.page1.b_glar009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glar009  #顯示到畫面上
            NEXT FIELD b_glar009                     #返回原欄位
    


            #END add-point
 
 
         #----<<odamt1>>----
         #----<<odamt2>>----
         #----<<oddiff>>----
         #----<<ocamt1>>----
         #----<<ocamt2>>----
         #----<<ocdiff>>----
         #----<<damt1>>----
         #----<<damt2>>----
         #----<<ddiff>>----
         #----<<camt1>>----
         #----<<camt2>>----
         #----<<cdiff>>----
   
 
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
   
      CALL aglq501_filter_show('glar001','b_glar001')
   CALL aglq501_filter_show('glar009','b_glar009')
 
    
   CALL aglq501_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq501_filter_parser(ps_field)
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
 
{<section id="aglq501.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq501_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq501_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.insert" >}
#+ insert
PRIVATE FUNCTION aglq501_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq501.modify" >}
#+ modify
PRIVATE FUNCTION aglq501_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq501_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.delete" >}
#+ delete
PRIVATE FUNCTION aglq501_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq501.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq501_detail_action_trans()
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
 
{<section id="aglq501.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq501_detail_index_setting()
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
            IF g_glar_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glar_d.getLength() AND g_glar_d.getLength() > 0
            LET g_detail_idx = g_glar_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glar_d.getLength() THEN
               LET g_detail_idx = g_glar_d.getLength()
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
 
{<section id="aglq501.mask_functions" >}
 &include "erp/agl/aglq501_mask.4gl"
 
{</section>}
 
{<section id="aglq501.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 設置預設值
# Memo...........:
# Usage..........: CALL aglq501_set_default_value()
# Input parameter: 
# Return code....:
# Date & Author..: 2015/10/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_set_default_value()
   DEFINE l_flag           LIKE type_t.chr1
   DEFINE l_errno          LIKE type_t.chr100
   DEFINE l_glav002        LIKE glav_t.glav002
   DEFINE l_glav005        LIKE glav_t.glav005
   DEFINE l_sdate_s        LIKE glav_t.glav004
   DEFINE l_sdate_e        LIKE glav_t.glav004
   DEFINE l_glav006        LIKE glav_t.glav006
   DEFINE l_pdate_s        LIKE glav_t.glav004
   DEFINE l_pdate_e        LIKE glav_t.glav004
   DEFINE l_glav007        LIKE glav_t.glav007
   DEFINE l_wdate_s        LIKE glav_t.glav004
   DEFINE l_wdate_e        LIKE glav_t.glav004
   
   CALL s_get_accdate(g_glaa003,g_today,'','')
   RETURNING l_flag,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

   END IF
   LET tm.syear=l_glav002
   LET tm.smonth=l_glav006
   LET tm.eyear=l_glav002
   LET tm.emonth=l_glav006
   #獲取現行會計週期最大期別
   SELECT MAX(glav006) INTO g_max_period FROM glav_t 
   WHERE glavent=g_enterprise AND glav001=g_glaa003 AND glav002=tm.syear
   LET g_max_period2=g_max_period
   
   #檢查上級科目與下級科目匯總金額是否一致
   LET tm.chk1='Y'
   #檢查傳票金額與統計檔金額是否一致
   LET tm.chk2='Y'
END FUNCTION

################################################################################
# Descriptions...:帳套相關資料查詢
# Memo...........:
# Usage..........: CALL aglq501_glaald_desc(p_glaald)
# Input parameter: p_glaald       帳套
# Return code....: 
# Date & Author..: 2015/10/08 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_glaald_desc(p_glaald)
   DEFINE p_glaald          LIKE glaa_t.glaald
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glaald 
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glaald_desc=g_rtn_fields[1]
   #依据对应的主账套编码，抓取对应法人，币别，汇率参照编号，会计科目参照编号,关账日期
   SELECT glaacomp,glaa001,glaa003,glaa004,glaa015,glaa016,glaa019,glaa020
     INTO tm.glaacomp,g_glaa001,g_glaa003,g_glaa004,g_glaa015,g_glaa016,g_glaa019,g_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald = p_glaald 
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.glaacomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glaacomp_desc= g_rtn_fields[1]
   
END FUNCTION

################################################################################
# Descriptions...: 检查统制科目与其下属明细科目汇总金额是否一致
# Memo...........:
# Usage..........: CALL aglq501_b_fill1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   DEFINE l_sql           STRING
   DEFINE l_sql1,l_sql2   STRING
   DEFINE l_str           STRING
   DEFINE l_glac002       STRING
   DEFINE l_glar001       LIKE glar_t.glar001
   DEFINE l_glar009       LIKE glar_t.glar009 
   DEFINE l_odamt1        LIKE type_t.num20_6 
   DEFINE l_odamt2        LIKE type_t.num20_6 
   DEFINE l_oddiff        LIKE type_t.num20_6 
   DEFINE l_ocamt1        LIKE type_t.num20_6 
   DEFINE l_ocamt2        LIKE type_t.num20_6 
   DEFINE l_ocdiff        LIKE type_t.num20_6 
   DEFINE l_damt1         LIKE type_t.num20_6 
   DEFINE l_damt2         LIKE type_t.num20_6 
   DEFINE l_ddiff         LIKE type_t.num20_6 
   DEFINE l_camt1         LIKE type_t.num20_6 
   DEFINE l_camt2         LIKE type_t.num20_6 
   DEFINE l_cdiff         LIKE type_t.num20_6 
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   CALL g_glar_d.clear()
   
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
   
   #1.抓取帳套+年期範圍內所有的科目+幣別，抓取统治科目
   IF tm.syear=tm.eyear THEN
      LET g_sql="SELECT UNIQUE glar001,glar009 ",
                " FROM glar_t,glac_t",
                " WHERE glarent=glacent AND glar001=glac002 ",
                "   AND glac001='",g_glaa004,"' AND glac003='1' ",
                "   AND glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                "   AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth,
                "   AND ",ls_wc
                
      #依据科目+币别抓取原币、本币借贷方金额          
      LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM glar_t ",
                " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                "   AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth,
                "   AND glar001=? AND glar009=? "
   ELSE
      #跨年處理:根據年度分段處理
      LET l_sql1="SELECT UNIQUE glar001,glar009 ",
                 "  FROM glar_t,glac_t",
                "  WHERE glarent=glacent AND glar001=glac002 ",
                "    AND glac001='",g_glaa004,"' AND glac003='1' ",
                "    AND glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                "    AND ",ls_wc
      LET g_sql="(",l_sql1," AND glar002=",tm.syear," AND glar003 >=",tm.smonth,")"
                
      #依据科目+币别抓取原币、本币借贷方金额
      LET l_sql2="SELECT glar010,glar011,glar005,glar006 FROM glar_t", 
                 "  WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                 "    AND glar001=? AND glar009=? "
      LET l_sql="(",l_sql2," AND glar002=",tm.syear," AND glar003 >=",tm.smonth,")"
                
      IF tm.syear+1 < tm.eyear THEN
         LET g_sql=g_sql," UNION ",
                   "(",l_sql1," AND glar002>",tm.syear," AND glar002 <",tm.eyear,")"
         #依据科目+币别抓取原币、本币借贷方金额          
         LET l_sql=l_sql," UNION ",
                   "(",l_sql2," AND glar002>",tm.syear," AND glar002 <",tm.eyear,")"
      END IF
      
      LET g_sql=g_sql," UNION ",
                "(",l_sql1," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth,")"
      #依据科目+币别抓取原币、本币借贷方金额          
      LET l_sql=l_sql," UNION ",
                "(",l_sql2," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth,")"
                
      LET g_sql="SELECT UNIQUE glar001,glar009 FROM (",g_sql,")"
      
      #依据科目+币别抓取原币、本币借贷方金额
      LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM (",l_sql,")"
   END IF
   LET g_sql=g_sql," ORDER BY glar001,glar009"
   PREPARE aglq501_glar001_pr FROM g_sql
   DECLARE aglq501_glar001_cs CURSOR FOR aglq501_glar001_pr
   #依据科目+币别抓取原币、本币借贷方金额
   PREPARE aglq501_sum_pr FROM l_sql
   
   FOREACH aglq501_glar001_cs INTO l_glar001,l_glar009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:aglq501_glar001_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #2.根据科目+币别抓取对应原币、本币借贷方金额
      LET l_odamt1 = 0
      LET l_ocamt1 = 0
      LET l_damt1  = 0
      LET l_camt1  = 0
      IF tm.syear=tm.eyear THEN
         EXECUTE aglq501_sum_pr USING l_glar001,l_glar009 
                                 INTO l_odamt1,l_ocamt1,l_damt1,l_camt1
         
      ELSE
         IF tm.syear+1 < tm.eyear THEN
            EXECUTE aglq501_sum_pr USING l_glar001,l_glar009,l_glar001,l_glar009,l_glar001,l_glar009 
                                 INTO l_odamt1,l_ocamt1,l_damt1,l_camt1
         ELSE
            EXECUTE aglq501_sum_pr USING l_glar001,l_glar009,l_glar001,l_glar009
                                 INTO l_odamt1,l_ocamt1,l_damt1,l_camt1
         END IF
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'EXECUTE:aglq501_sum_pr'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      IF cl_null(l_odamt1) THEN LET l_odamt1 = 0 END IF
      IF cl_null(l_ocamt1) THEN LET l_ocamt1 = 0 END IF
      IF cl_null(l_damt1) THEN LET l_damt1 = 0 END IF
      IF cl_null(l_camt1) THEN LET l_camt1 = 0 END IF
      
      #3.抓取该科目+币别对应的下级科目的原币、本币借贷方金额
      #抓取科目对应的明细科目或者独立科目
      LET l_glac002=''
      CALL s_voucher_get_glac_str(g_glaa004,l_glar001) RETURNING l_glac002
      #当该统治科目无下层科目时，结束本次循环
      IF cl_null(l_glac002) THEN
         CONTINUE FOREACH
      END IF
      IF tm.syear=tm.eyear THEN
         #依据科目+币别抓取原币、本币借贷方金额          
         LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM glar_t ",
                   " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                   "   AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth,
                   "   AND glar001 IN (",l_glac002,") AND glar009='",l_glar009,"'"
      ELSE
         #跨年處理:根據年度分段處理
         #依据科目+币别抓取原币、本币借贷方金额
         LET l_sql2="SELECT glar010,glar011,glar005,glar006 FROM glar_t", 
                    "  WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                    "   AND glar001 IN (",l_glac002,") AND glar009='",l_glar009,"'"
         LET l_sql="(",l_sql2," AND glar002=",tm.syear," AND glar003 >=",tm.smonth,")"
                   
         IF tm.syear+1 < tm.eyear THEN
            #依据科目+币别抓取原币、本币借贷方金额          
            LET l_sql=l_sql," UNION ",
                      "(",l_sql2," AND glar002>",tm.syear," AND glar002 <",tm.eyear,")"
         END IF
         #依据科目+币别抓取原币、本币借贷方金额          
         LET l_sql=l_sql," UNION ",
                   "(",l_sql2," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth,")"
         #依据科目+币别抓取原币、本币借贷方金额
         LET l_sql="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM (",l_sql,")"
      END IF
      
      PREPARE aglq501_sum_pr1 FROM l_sql
      
      LET l_odamt2 = 0
      LET l_ocamt2 = 0
      LET l_damt2  = 0
      LET l_camt2  = 0
      
      EXECUTE aglq501_sum_pr1 INTO l_odamt2,l_ocamt2,l_damt2,l_camt2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'EXECUTE:aglq501_sum_pr1'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      IF cl_null(l_odamt2) THEN LET l_odamt2 = 0 END IF
      IF cl_null(l_ocamt2) THEN LET l_ocamt2 = 0 END IF
      IF cl_null(l_damt2) THEN LET l_damt2 = 0 END IF
      IF cl_null(l_camt2) THEN LET l_camt2 = 0 END IF
      
      #4.上级科目与下级科目金额比较，当有差异时，插入单身中
      LET l_oddiff = 0
      LET l_ocdiff = 0
      LET l_ddiff  = 0
      LET l_cdiff  = 0
      #原币借方差异金额
      LET l_oddiff = l_odamt1 - l_odamt2
      #原币贷方差异金额
      LET l_ocdiff = l_ocamt1 - l_ocamt2
      #本币借方差异金额
      LET l_ddiff  = l_damt1 - l_damt2
      #本币贷方差异金额
      LET l_cdiff  = l_camt1 - l_camt2
      
      #当存在差异时，插入单身中
      IF l_oddiff <> 0 OR l_ocdiff <> 0 OR l_ddiff <> 0 OR l_cdiff <> 0 THEN
         LET g_glar_d[l_ac].sel = 'N'
         LET g_glar_d[l_ac].glar001 = l_glar001
         LET g_glar_d[l_ac].glar001_desc = s_desc_get_account_desc(tm.glaald,l_glar001)
         LET g_glar_d[l_ac].glar009 = l_glar009
         LET g_glar_d[l_ac].odamt1 = l_odamt1
         LET g_glar_d[l_ac].odamt2 = l_odamt2
         LET g_glar_d[l_ac].oddiff = l_oddiff
         LET g_glar_d[l_ac].ocamt1 = l_ocamt1
         LET g_glar_d[l_ac].ocamt2 = l_ocamt2
         LET g_glar_d[l_ac].ocdiff = l_ocdiff
         LET g_glar_d[l_ac].damt1 = l_damt1
         LET g_glar_d[l_ac].damt2 = l_damt2
         LET g_glar_d[l_ac].ddiff = l_ddiff
         LET g_glar_d[l_ac].camt1 = l_camt1
         LET g_glar_d[l_ac].camt2 = l_camt2
         LET g_glar_d[l_ac].cdiff = l_cdiff
         
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
      END IF
   END FOREACH
      
   LET g_error_show = 0
#   CALL g_glar_d.deleteElement(g_glar_d.getLength())   
 
   LET g_detail_cnt = g_glar_d.getLength()
   LET g_tot_cnt = g_detail_cnt
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq501_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq501_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq501_detail_action_trans()
 
   IF g_glar_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq501_fetch()
   END IF
   
   CALL aglq501_filter_show('glar001','b_glar001')
   CALL aglq501_filter_show('glar009','b_glar009')
END FUNCTION

################################################################################
# Descriptions...: 检查凭证金额与统计档金额是否一致
# Memo...........:
# Usage..........: CALL aglq501_b_fill2()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_b_fill2()
   DEFINE l_sdate            LIKE glap_t.glapdocdt
   DEFINE l_edate            LIKE glap_t.glapdocdt
   DEFINE l_pdate_s          LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
   DEFINE l_pdate_e          LIKE glav_t.glav004
   DEFINE l_flag1            LIKE type_t.chr1
   DEFINE l_errno            LIKE type_t.chr100
   DEFINE l_glav002          LIKE glav_t.glav002
   DEFINE l_glav005          LIKE glav_t.glav005
   DEFINE l_sdate_s          LIKE glav_t.glav004
   DEFINE l_sdate_e          LIKE glav_t.glav004
   DEFINE l_glav006          LIKE glav_t.glav006
   DEFINE l_glav007          LIKE glav_t.glav007
   DEFINE l_wdate_s          LIKE glav_t.glav004
   DEFINE l_wdate_e          LIKE glav_t.glav004
   DEFINE l_sql,l_sql1       STRING
   DEFINE l_sql2,l_sql3      STRING 
   DEFINE l_wc               STRING
   DEFINE ls_wc              STRING
   DEFINE l_glaq002          LIKE type_t.chr500
   DEFINE l_glaq005          LIKE type_t.chr10 
   DEFINE l_odsum1           LIKE type_t.num20_6 
   DEFINE l_odsum2           LIKE type_t.num20_6 
   DEFINE l_diff01           LIKE type_t.num20_6 
   DEFINE l_ocsum1           LIKE type_t.num20_6 
   DEFINE l_ocsum2           LIKE type_t.num20_6 
   DEFINE l_diff02           LIKE type_t.num20_6 
   DEFINE l_dsum1            LIKE type_t.num20_6 
   DEFINE l_dsum2            LIKE type_t.num20_6 
   DEFINE l_diff03           LIKE type_t.num20_6 
   DEFINE l_csum1            LIKE type_t.num20_6 
   DEFINE l_csum2            LIKE type_t.num20_6 
   DEFINE l_diff04           LIKE type_t.num20_6
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   LET l_wc = cl_replace_str(ls_wc,'glar001','glaq002')
   LET l_wc = cl_replace_str(ls_wc,'glar009','glaq005')
   CALL g_glar2_d.clear()
   
   #根据起始截止年期转换出起始截止日期   
   CALL s_get_accdate(g_glaa003,'',tm.syear,tm.smonth) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   LET l_sdate=l_pdate_s
   
   CALL s_get_accdate(g_glaa003,'',tm.eyear,tm.emonth) 
   RETURNING l_flag1,l_errno,l_glav002,l_glav005,l_sdate_s,l_sdate_e,
             l_glav006,l_pdate_s,l_pdate_e,l_glav007,l_wdate_s,l_wdate_e
   IF l_flag1='N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = l_errno
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   LET l_edate=l_pdate_e
   
   #1.抓取帳套+年期範圍內所有的科目+幣別 ,抓取明细或独立科目 
   #1.1.抓取凭证中科目+币别   
   LET l_sql="(SELECT UNIQUE glaq002,glaq005 ",
             "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno",
             "  WHERE glapent=",g_enterprise," AND glapld='",tm.glaald,"'",
             "    AND glapdocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'",
             "    AND glapstus='S' AND ",l_wc,")"
   #1.2.抓取余额档中科目+币别
   IF tm.syear=tm.eyear THEN
      LET g_sql="(SELECT UNIQUE glar001 glaq002,glar009 glaq005 ",
                 "   FROM glar_t,glac_t",
                 "  WHERE glarent=glacent AND glar001=glac002 ",
                 "    AND glac001='",g_glaa004,"' AND glac003 IN ('2','3') ",
                 "    AND glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                 "    AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth,
                 "    AND ",ls_wc,")"
                
      #依据科目+币别抓取原币、本币借贷方金额          
      LET l_sql2="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM glar_t ",
                 " WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                 "   AND glar002=",tm.syear," AND glar003 BETWEEN ",tm.smonth," AND ",tm.emonth,
                 "   AND glar001=? AND glar009=? "
   ELSE
      #跨年處理:根據年度分段處理
      LET l_sql1="SELECT UNIQUE glar001 glaq002,glar009 glaq005 ",
                 "  FROM glar_t,glac_t",
                 "  WHERE glarent=glacent AND glar001=glac002 ",
                 "    AND glac001='",g_glaa004,"' AND glac003 IN ('2','3') ",
                 "    AND glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                 "    AND ",ls_wc
      LET g_sql="(",l_sql1," AND glar002=",tm.syear," AND glar003 >=",tm.smonth,")"
                
      #依据科目+币别抓取原币、本币借贷方金额
      LET l_sql3="SELECT glar010,glar011,glar005,glar006 FROM glar_t", 
                 "  WHERE glarent=",g_enterprise," AND glarld='",tm.glaald,"'",
                 "    AND glar001=? AND glar009=? "
      LET l_sql2="(",l_sql3," AND glar002=",tm.syear," AND glar003 >=",tm.smonth,")"
                
      IF tm.syear+1 < tm.eyear THEN
         LET g_sql=g_sql," UNION ",
                   "(",l_sql1," AND glar002>",tm.syear," AND glar002 <",tm.eyear,")"
                   
         #依据科目+币别抓取原币、本币借贷方金额          
         LET l_sql2=l_sql2," UNION ",
                   "(",l_sql3," AND glar002>",tm.syear," AND glar002 <",tm.eyear,")"
      END IF
      
      LET g_sql=g_sql," UNION ",
                "(",l_sql1," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth,")"
                
      #依据科目+币别抓取原币、本币借贷方金额          
      LET l_sql2=l_sql2," UNION ",
                "(",l_sql3," AND glar002=",tm.eyear," AND glar003 <=",tm.emonth,")"
      #依据科目+币别抓取原币、本币借贷方金额
      LET l_sql2="SELECT SUM(glar010),SUM(glar011),SUM(glar005),SUM(glar006) FROM (",l_sql2,")"
   END IF
   
   LET g_sql="SELECT UNIQUE glaq002,glaq005 ",
             "  FROM (",l_sql," UNION ",g_sql,")",
             " ORDER BY glaq002,glaq005"
   PREPARE aglq501_glaq002_pr FROM g_sql
   DECLARE aglq501_glaq002_cs CURSOR FOR aglq501_glaq002_pr
   
   #2.抓取科目+币别对应的原币本币金额
   #2.1.抓取凭证中金额
   LET g_sql="SELECT SUM(CASE WHEN glaq003<>0 THEN glaq010 ELSE 0 END ),",
             "       SUM(CASE WHEN glaq004<>0 THEN glaq010 ELSE 0 END ),",
             "       SUM(glaq003),SUM(glaq004)",
             "  FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno",
             " WHERE glapent=",g_enterprise," AND glapld='",tm.glaald,"'",
             "   AND glapdocdt BETWEEN '",l_sdate,"' AND '",l_edate,"'",
             "   AND glapstus='S' ",
             "   AND glaq002=? AND glaq005=?"
   PREPARE aglq501_sum_glaq_pr FROM g_sql
   #2.2.抓取余额档中金额
   PREPARE aglq501_sum_glar_pr FROM l_sql2
   LET l_ac2=1
   
   FOREACH aglq501_glaq002_cs INTO l_glaq002,l_glaq005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:aglq501_glaq002_cs" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #2.根据科目+币别抓取对应原币、本币借贷方金额
      #2.1.抓取凭证中金额
      LET l_odsum1 = 0
      LET l_ocsum1 = 0
      LET l_dsum1  = 0
      LET l_csum1  = 0
      EXECUTE aglq501_sum_glaq_pr USING l_glaq002,l_glaq005
                                   INTO l_odsum1,l_ocsum1,l_dsum1,l_csum1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'EXECUTE:aglq501_sum_glaq_pr'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      IF cl_null(l_odsum1) THEN LET l_odsum1 = 0 END IF
      IF cl_null(l_ocsum1) THEN LET l_ocsum1 = 0 END IF
      IF cl_null(l_dsum1) THEN LET l_dsum1 = 0 END IF
      IF cl_null(l_csum1) THEN LET l_csum1 = 0 END IF
      
      #2.2.抓取余额档中金额
      LET l_odsum2 = 0
      LET l_ocsum2 = 0
      LET l_dsum2  = 0
      LET l_csum2  = 0
      IF tm.syear=tm.eyear THEN
         EXECUTE aglq501_sum_glar_pr USING l_glaq002,l_glaq005
                                   INTO l_odsum2,l_ocsum2,l_dsum2,l_csum2
      ELSE
         #跨年處理:根據年度分段處理
         IF tm.syear+1 < tm.eyear THEN
            EXECUTE aglq501_sum_glar_pr USING l_glaq002,l_glaq005,l_glaq002,l_glaq005,l_glaq002,l_glaq005
                                   INTO l_odsum2,l_ocsum2,l_dsum2,l_csum2
         ELSE
            EXECUTE aglq501_sum_glar_pr USING l_glaq002,l_glaq005,l_glaq002,l_glaq005
                                   INTO l_odsum2,l_ocsum2,l_dsum2,l_csum2
         END IF
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'EXECUTE:aglq501_sum_glar_pr'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      IF cl_null(l_odsum2) THEN LET l_odsum2 = 0 END IF
      IF cl_null(l_ocsum2) THEN LET l_ocsum2 = 0 END IF
      IF cl_null(l_dsum2) THEN LET l_dsum2 = 0 END IF
      IF cl_null(l_csum2) THEN LET l_csum2 = 0 END IF
      
      #4.上级科目与下级科目金额比较，当有差异时，插入单身中
      LET l_diff01 = 0
      LET l_diff02 = 0
      LET l_diff03 = 0
      LET l_diff04 = 0
      #原币借方差异金额
      LET l_diff01 = l_odsum1 - l_odsum2
      #原币贷方差异金额
      LET l_diff02 = l_ocsum1 - l_ocsum2
      #本币借方差异金额
      LET l_diff03  = l_dsum1 - l_dsum2
      #本币贷方差异金额
      LET l_diff04  = l_csum1 - l_csum2
      
      #当存在差异时，插入单身中
      IF l_diff01 <> 0 OR l_diff02 <> 0 OR l_diff03 <> 0 OR l_diff04 <> 0 THEN
         LET g_glar2_d[l_ac2].glaq002 = l_glaq002
         LET g_glar2_d[l_ac2].glaq002_desc = s_desc_get_account_desc(tm.glaald,l_glaq002)
         LET g_glar2_d[l_ac2].glaq005 = l_glaq005
         LET g_glar2_d[l_ac2].odsum1 = l_odsum1
         LET g_glar2_d[l_ac2].odsum2 = l_odsum2
         LET g_glar2_d[l_ac2].diff01 = l_diff01
         LET g_glar2_d[l_ac2].ocsum1 = l_ocsum1
         LET g_glar2_d[l_ac2].ocsum2 = l_ocsum2
         LET g_glar2_d[l_ac2].diff02 = l_diff02
         LET g_glar2_d[l_ac2].dsum1 = l_dsum1
         LET g_glar2_d[l_ac2].dsum2 = l_dsum2
         LET g_glar2_d[l_ac2].diff03 = l_diff03
         LET g_glar2_d[l_ac2].csum1 = l_csum1
         LET g_glar2_d[l_ac2].csum2 = l_csum2
         LET g_glar2_d[l_ac2].diff04 = l_diff04
         
         IF l_ac2 > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend =  "" 
               LET g_errparam.code   =  9035 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         LET l_ac2 = l_ac2 + 1
      END IF
   END FOREACH
#   LET l_ac2= l_ac2 - 1
   LET g_error_show = 0
#   CALL g_glar2_d.deleteElement(g_glar2_d.getLength())
   LET g_detail_cnt = g_glar2_d.getLength()
   LET g_tot_cnt = g_detail_cnt
END FUNCTION

################################################################################
# Descriptions...: 双击单身串查
# Memo...........: 当双击第一个单身串查aglq740,当双击第二个单身串查aglq760
# Usage..........: CALL aglq501_cmdrun()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/09 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_cmdrun()
   DEFINE la_param     RECORD
          prog         STRING,
          param        DYNAMIC ARRAY OF STRING
                       END RECORD
   DEFINE ls_js        STRING
   
   INITIALIZE la_param.* TO NULL
   IF g_flag = 1 THEN #光标在第一个页签中
      #aglq740不支持跨年查询
      IF tm.syear <> tm.eyear THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00376'
         LET g_errparam.extend = ''
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
      LET la_param.prog = 'aglq740'
      LET la_param.param[1] = tm.glaald    #帳別
      LET la_param.param[2] = tm.syear    #年度   
      LET la_param.param[3] = tm.smonth   #起始期別
      LET la_param.param[4] = tm.emonth   #截止期別
      LET la_param.param[5] = 'N'         #按科目分頁管理
      LET la_param.param[6] = '0'         #多本位幣顯示
      LET la_param.param[7] = 'Y'         #顯示統制科目
      LET la_param.param[8] = 99          #科目層級
      LET la_param.param[9] = '1'         #單據狀態
      LET la_param.param[10] = 'Y'        #含內部管理
      LET la_param.param[11] = 'Y'        #含月結
      LET la_param.param[12] = 'Y'        #含年結
      LET la_param.param[13] = '*'        #科目編號
      LET la_param.param[14] = 'Y'        #含審計調整傳票 
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF
   IF g_flag = 2 THEN #光标在第二个页签中
      IF g_detail_idx<1 THEN RETURN END IF
      LET la_param.prog = 'aglq760'
      LET la_param.param[1] = tm.glaald    #帳別
      LET la_param.param[2] = tm.syear     #起始年度
      LET la_param.param[3] = tm.smonth    #起始期別
      LET la_param.param[4] = tm.eyear     #截止年度
      LET la_param.param[5] = tm.emonth    #截止期別
      LET la_param.param[6] = '0'          #多本位幣顯示
      LET la_param.param[7] = 'N'          #顯示原幣
      LET la_param.param[8] = 'N'          #按幣別分頁
      LET la_param.param[9] = 'N'          #按科目分頁
      LET la_param.param[10] = 'Y'          #顯示統制科目
      LET la_param.param[11] = 99          #科目層級
      LET la_param.param[12] = '1'         #單據狀態
      LET la_param.param[13] = 'Y'         #含內部管理
      LET la_param.param[14] = 'Y'         #含月結
      LET la_param.param[15] = 'Y'         #含年結
      LET la_param.param[16] = g_glar2_d[g_detail_idx].glaq002  #科目編號
      LET la_param.param[17] = 'Y'         #含審計調整傳票 
      LET ls_js = util.JSON.stringify( la_param )
      CALL cl_cmdrun(ls_js)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 创建临时表用于列印报表
# Memo...........:
# Usage..........: CALL aglq501_creat_temp_table()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_creat_temp_table()
   DROP TABLE aglq501_tmp1
   CREATE TEMP TABLE aglq501_tmp1(
   glarld   VARCHAR(5),
   glarld_desc  VARCHAR(500),
   glarcomp  VARCHAR(10),
   glarcomp_desc  VARCHAR(500),
   syear  SMALLINT,
   smonth  SMALLINT,
   eyear  SMALLINT,
   emonth  SMALLINT,
   glar001  VARCHAR(24), 
   glar001_desc  VARCHAR(500), 
   glar009  VARCHAR(10), 
   odamt1  DECIMAL(20,6), 
   odamt2  DECIMAL(20,6), 
   oddiff  DECIMAL(20,6), 
   ocamt1  DECIMAL(20,6), 
   ocamt2  DECIMAL(20,6), 
   ocdiff  DECIMAL(20,6), 
   damt1  DECIMAL(20,6), 
   damt2  DECIMAL(20,6), 
   ddiff  DECIMAL(20,6), 
   camt1  DECIMAL(20,6), 
   camt2  DECIMAL(20,6), 
   cdiff  DECIMAL(20,6))
   
   DROP TABLE aglq501_tmp2
   CREATE TEMP TABLE aglq501_tmp2(
   glaqld   VARCHAR(5),
   glaqld_desc  VARCHAR(500),
   glaqcomp  VARCHAR(10),
   glaqcomp_desc  VARCHAR(500),
   syear  SMALLINT,
   smonth  SMALLINT,
   eyear  SMALLINT,
   emonth  SMALLINT,
   glaq002  VARCHAR(500), 
   glaq002_desc  VARCHAR(500), 
   glaq005  VARCHAR(10), 
   odsum1  DECIMAL(20,6), 
   odsum2  DECIMAL(20,6), 
   diff01  DECIMAL(20,6), 
   ocsum1  DECIMAL(20,6), 
   ocsum2  DECIMAL(20,6), 
   diff02  DECIMAL(20,6), 
   dsum1  DECIMAL(20,6), 
   dsum2  DECIMAL(20,6), 
   diff03  DECIMAL(20,6), 
   csum1  DECIMAL(20,6), 
   csum2  DECIMAL(20,6), 
   diff04  DECIMAL(20,6))
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
PRIVATE FUNCTION aglq501_output()
   DEFINE l_i,l_j         LIKE type_t.num10
  
   LET g_accept = 'N'
   
   #弹出窗口显示可打印的页签，供用户选择需打印页签   
   CALL aglq501_output_to_getpage()
 
  
   #取消打印操作
   IF g_accept = 'N' THEN
      RETURN
   END IF
   #打印勾选的页签
   FOR l_i =1 TO g_data_cnt
      IF gr_page[l_i].l_sel = 'Y' THEN
         IF g_page_name[l_i] = 'page_1' THEN
            DELETE FROM aglq501_tmp1
            FOR l_j =1 TO g_glar_d.getLength()
               INSERT INTO aglq501_tmp1(glarld,glarld_desc,glarcomp,glarcomp_desc,syear,smonth,eyear,emonth,
                                        glar001,glar001_desc,glar009,odamt1,odamt2,oddiff,ocamt1,ocamt2,ocdiff,
                                        damt1,damt2,ddiff,camt1,camt2,cdiff)
               VALUES(tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.syear,tm.smonth,tm.eyear,tm.emonth,
                      g_glar_d[l_j].glar001,g_glar_d[l_j].glar001_desc,g_glar_d[l_j].glar009,
                      g_glar_d[l_j].odamt1,g_glar_d[l_j].odamt2,g_glar_d[l_j].oddiff,
                      g_glar_d[l_j].ocamt1,g_glar_d[l_j].ocamt2,g_glar_d[l_j].ocdiff,
                      g_glar_d[l_j].damt1,g_glar_d[l_j].damt2,g_glar_d[l_j].ddiff,
                      g_glar_d[l_j].camt1,g_glar_d[l_j].camt2,g_glar_d[l_j].cdiff)
            END FOR
            CALL aglq501_x01(' 1=1','aglq501_tmp1')
         END IF
         IF g_page_name[l_i] = 'page_2' THEN
            DELETE FROM aglq501_tmp2
            FOR l_j =1 TO g_glar2_d.getLength()
               INSERT INTO aglq501_tmp2(glaqld,glaqld_desc,glaqcomp,glaqcomp_desc,syear,smonth,eyear,emonth,
                                        glaq002,glaq002_desc,glaq005,odsum1,odsum2,diff01,ocsum1,ocsum2,diff02,
                                        dsum1,dsum2,diff03,csum1,csum2,diff04)
               VALUES(tm.glaald,tm.glaald_desc,tm.glaacomp,tm.glaacomp_desc,tm.syear,tm.smonth,tm.eyear,tm.emonth,
                      g_glar2_d[l_j].glaq002,g_glar2_d[l_j].glaq002_desc,g_glar2_d[l_j].glaq005,
                      g_glar2_d[l_j].odsum1,g_glar2_d[l_j].odsum2,g_glar2_d[l_j].diff01,
                      g_glar2_d[l_j].ocsum1,g_glar2_d[l_j].ocsum2,g_glar2_d[l_j].diff02,
                      g_glar2_d[l_j].dsum1,g_glar2_d[l_j].dsum2,g_glar2_d[l_j].diff03,
                      g_glar2_d[l_j].csum1,g_glar2_d[l_j].csum2,g_glar2_d[l_j].diff04)
            END FOR
            CALL aglq501_x02(' 1=1','aglq501_tmp2')
         END IF
      END IF
   END FOR  
END FUNCTION

################################################################################
# Descriptions...: 弹出窗口显示可打印的页签，供用户选择需打印页签
# Memo...........:
# Usage..........: CALL aglq501_output_to_getpage()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_output_to_getpage()
   DEFINE w                     ui.Window
   DEFINE twindow               om.DomNode
   DEFINE l_text                STRING
   DEFINE li_ac                 LIKE type_t.num5
   DEFINE ldig_curr             ui.Dialog
   
   LET w = ui.Window.getCurrent()
   LET twindow = w.getNode()

   CALL gr_page.clear()
   CALL aglq501_output_to_result_set(twindow)

   IF g_data_cnt <> 0 THEN
      OPEN WINDOW w_pageqry_xg WITH FORM cl_ap_formpath("lib","cl_export_s01")
         ATTRIBUTE(STYLE="openwin")
      CALL cl_ui_init()   

      LET INT_FLAG = FALSE         #避免被其他函式影響
      #設定開窗識別碼的說明
      LET gwin_curr = ui.Window.forName("w_pageqry_xg")
      LET l_text = cl_getmsg('agl-00375',g_lang)
      CALL gwin_curr.setText(l_text)

      #勾选需打印页签
      DIALOG ATTRIBUTES(UNBUFFERED)
         INPUT ARRAY gr_page FROM s_detail1.*
            ATTRIBUTES(COUNT=g_data_cnt,
                       APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE)
     
            BEFORE ROW
               LET li_ac = DIALOG.getCurrentRow("s_detail1")
     
            ON CHANGE l_sel   #改變勾選狀態
         END INPUT
     
         BEFORE DIALOG
            LET ldig_curr = ui.Dialog.getCurrent()
     
         ON ACTION btn_accept 
            LET g_accept = 'Y'
            EXIT DIALOG
     
         ON ACTION btn_cancel
            LET g_accept = 'N'
            LET INT_FLAG = TRUE
            EXIT DIALOG
     
         ON ACTION close 
            LET g_accept = 'N'
            LET INT_FLAG = TRUE
            EXIT DIALOG
      END DIALOG

      IF INT_FLAG THEN
         LET INT_FLAG = 0
      END IF

      CLOSE WINDOW w_pageqry_xg
   END IF
 
END FUNCTION

################################################################################
# Descriptions...: 抓取单身需要打印的页签资料，填入选择子画面单身汇总
# Memo...........:
# Usage..........: CALL aglq501_output_to_result_set(nRoot)
#                  RETURNING 回传参数
# Input parameter: nRoot          当前程序画面
# Return code....: 
# Date & Author..: 2015/10/12 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq501_output_to_result_set(nRoot)
   DEFINE nRoot                 om.DomNode
   DEFINE lst_page              om.NodeList         #<Page>节点列表
   DEFINE page                  om.DomNode          #<Page>节点
   DEFINE lst_table             om.NodeList         #<Table>节点列表
   DEFINE l_i                   LIKE type_t.num5
   DEFINE l_j                   LIKE type_t.num5
   DEFINE l_k                   LIKE type_t.num5
   DEFINE l_m                   LIKE type_t.num5
   DEFINE n_table               om.DomNode
   DEFINE l_check               LIKE type_t.chr1

   CALL gr_page.clear()
   CALL g_page_name.clear()
   
   LET lst_page = nRoot.selectByTagName("Page")
   LET l_i = 1
   FOR l_j = 1 TO lst_page.getLength()
       LET page = lst_page.item(l_j)
       #判断Page节点是否隐藏
       IF (page.getAttribute("hidden") IS NULL OR page.getAttribute("hidden") = 0) THEN   #add by wangxy 20141225
          LET lst_table = page.selectByTagName("Table")
          IF lst_table.getLength() <> 0 THEN 
             LET l_check = 'N'
             FOR l_m = 1 TO lst_table.getLength()
                #得到当前Table节点
                LET n_table = lst_table.item(l_m)
                IF (n_table.getAttribute("isTree") IS NULL OR n_table.getAttribute("isTree") = 0) THEN
                   LET l_check = 'Y'
                   EXIT FOR
                END IF
             END FOR
             IF l_check = 'Y' THEN
                #若page名称like"*page_info"预设不打勾
                IF page.getAttribute("name") MATCHES "*page_info*" THEN
                   LET gr_page[l_i].l_sel = 'N'
                ELSE
                   LET gr_page[l_i].l_sel = 'Y'
                END IF
                LET gr_page[l_i].l_page = page.getAttribute("text")
                LET g_page_name[l_i] = page.getAttribute("name")
                LET l_i = l_i + 1
             END IF
          END IF
      END IF   #add by wangxy 20141225
   END FOR
   LET l_i = l_i - 1
   LET g_data_cnt = l_i

END FUNCTION

 
{</section>}
 
