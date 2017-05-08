#該程式未解開Section, 採用最新樣板產出!
{<section id="apsq500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:24(2016-08-08 10:39:45), PR版次:0024(2017-02-09 19:59:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000137
#+ Filename...: apsq500
#+ Description: APS模擬結果查詢
#+ Creator....: 05293(2014-07-03 15:07:48)
#+ Modifier...: 07024 -SD/PR- 06978
 
{</section>}
 
{<section id="apsq500.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151124-00021#1   2015/11/24 By shiun   新增庫存明細頁簽
#160222-00006#1   2016/02/22 By Ann_Huang    修正交期重排減少量與交期重排增加量公式
#160414-00007#1   2016/04/14 By Smapmin   修改參數寫死中文字問題 
#160614-00027#1   2016/06/15 By ming      供需明細畫面上增加保稅否欄位在數量後面(當供需類別為I.庫存時，此欄位一律顯示為null)
#160608-00013#2   2016/06/20 By ming      1.psph007=pspa006  調整為  psph010=pspa006 
#                                         2.ORDER BY psph009 調整為  ORDER BY psph004 
#160615-00042#1   2016/06/26 By ming      庫存明細單身沒有清空，導致資料殘留  
#160621-00010#1   2016/06/26 By ming      1.庫存明細在儲位名稱後 新增 批號pspt013、庫存管理特徵pspt014、保稅否papt015(checkbox)三個欄位
#                                         2.供需明細中，當供需類別為I.庫存時，原先不顯示保稅否，改為正常顯示保稅否的值
#160701-00030#1   2016/07/04 By ming      效能優化 
#160727-00026#1   2016/08/08 By dorislai  修正供需明細頁簽資料沒有清空的問題
#160728-00024#1   2016/08/08 By dorislai  修正供需明細頁簽，預計結存數欄位值沒有出來的問題(與型態有關)
#161007-00015#1   2016/10/07 By Sarah     修正FUNCTION apsq500_query()的 add-point:query段define-標準 段落裡面有寫到非DEFINE的程式段，
#                                         將之搬到 add-point:FUNCTION前置處理 name="query.before_function"
#160923-00029#1   2016/12/08 By dorislai  1.替代量欄位多增加計算psoz044的值(替代採購在驗數量)  
#                                         2.細部顯示function，多顯示psoz033(替代規劃採購量)、psoz035(替代規劃製造量)、psoz044(替代採購在驗數量)
#170207-00023#1   2017/02/09 By ywtsai    修改查詢資料時，判斷若供需匯總數量皆為0的日期資料就不須顯示
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
PRIVATE TYPE type_g_psoz_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   psoz001 LIKE psoz_t.psoz001, 
   psoz002 LIKE psoz_t.psoz002, 
   psoz003 LIKE psoz_t.psoz003, 
   psoz038 LIKE psoz_t.psoz038, 
   psoz039 LIKE psoz_t.psoz039, 
   psoz004 LIKE psoz_t.psoz004, 
   qty1 LIKE type_t.num20_6, 
   psoz012 LIKE psoz_t.psoz012, 
   psoz014 LIKE psoz_t.psoz014, 
   psoz018 LIKE psoz_t.psoz018, 
   psoz021 LIKE psoz_t.psoz021, 
   psoz022 LIKE psoz_t.psoz022, 
   qty2 LIKE type_t.num20_6, 
   qty3 LIKE type_t.num20_6, 
   qty4 LIKE type_t.num20_6, 
   psoz031 LIKE psoz_t.psoz031, 
   psoz029 LIKE psoz_t.psoz029, 
   psoz030 LIKE psoz_t.psoz030, 
   psoz036 LIKE psoz_t.psoz036, 
   qty5 LIKE type_t.num20_6, 
   psoz037 LIKE psoz_t.psoz037, 
   psoz005 LIKE psoz_t.psoz005, 
   psoz006 LIKE psoz_t.psoz006, 
   psoz007 LIKE psoz_t.psoz007, 
   psoz009 LIKE psoz_t.psoz009, 
   psoz010 LIKE psoz_t.psoz010, 
   psoz013 LIKE psoz_t.psoz013, 
   psoz015 LIKE psoz_t.psoz015, 
   psoz020 LIKE psoz_t.psoz020, 
   psoz026 LIKE psoz_t.psoz026, 
   psoz027 LIKE psoz_t.psoz027, 
   psoz028 LIKE psoz_t.psoz028 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單頭 type 宣告
 TYPE type_g_psoz_m RECORD
   psoz001   LIKE psoz_t.psoz001, 
   psoz001_desc  LIKE pscal_t.pscal003,
   psozsite  LIKE psoz_t.psozsite, 
   psoz002   LIKE psoz_t.psoz002, 
   psoz003   LIKE psoz_t.psoz003, 
   psoz038   LIKE psoz_t.psoz038,
   imaal003  LIKE imaal_t.imaal003, 
   imaal004  LIKE imaal_t.imaal004, 
   psoz039   LIKE psoz_t.psoz039,  
   imaf013   LIKE imaf_t.imaf013
            END RECORD
DEFINE g_psoz_m          type_g_psoz_m
DEFINE g_psoz_m_t        type_g_psoz_m

#單身 type 宣告
 TYPE type_g_psoz2_d RECORD
   pspa004             LIKE pspa_t.pspa004, 
   pspa020             LIKE pspa_t.pspa020, 
   pspa006             LIKE pspa_t.pspa006,
   psph009             LIKE psph_t.psph009,   #2015/01/13 by stellar add
   pspa014             LIKE pspa_t.pspa014,     #2015/10/12 by stellar add
   pspa014_desc        LIKE imaal_t.imaal003,   #2015/10/12 by stellar add
   pspa014_desc1       LIKE imaal_t.imaal004,   #2015/10/12 by stellar add
   pspa009             LIKE pspa_t.pspa009,  
   pspa021             LIKE pspa_t.pspa021,     #160614-00027#1 20160615 by ming add 
   qty6                LIKE psoz_t.psoz036,
   pspa017             LIKE pspa_t.pspa017,     #2015/09/17 by stellar add
   pspa017_desc        LIKE imaal_t.imaal003,   #2015/09/17 by stellar add
   pspa017_desc1       LIKE imaal_t.imaal004    #2015/09/17 by stellar add
       END RECORD
DEFINE g_psoz2_d   DYNAMIC ARRAY OF type_g_psoz2_d
#add--151124-00021#1 By shiun--(S)
 TYPE type_g_psoz3_d RECORD
   pspt005        LIKE pspt_t.pspt005,
   pspt005_desc   LIKE inayl_t.inayl003,
   pspt006        LIKE pspt_t.pspt006,
   pspt006_desc   LIKE inab_t.inab003,
   pspt013        LIKE pspt_t.pspt013,     #160621-00010#1 20160626 by ming add 
   pspt014        LIKE pspt_t.pspt014,     #160621-00010#1 20160626 by ming add 
   pspt015        LIKE pspt_t.pspt015,     #160621-00010#1 20160626 by ming add 
   pspt007        LIKE pspt_t.pspt007
       END RECORD
DEFINE g_psoz3_d   DYNAMIC ARRAY OF type_g_psoz3_d
#add--151124-00021#1 By shiun--(S)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_psoz_d
DEFINE g_master_t                   type_g_psoz_d
DEFINE g_psoz_d          DYNAMIC ARRAY OF type_g_psoz_d
DEFINE g_psoz_d_t        type_g_psoz_d
 
      
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
DEFINE g_no_ask      LIKE type_t.num5
DEFINE g_jump        LIKE type_t.num10
DEFINE g_row_count   LIKE type_t.num10   
DEFINE g_curs_index  LIKE type_t.num10 
DEFINE g_wc3         STRING
#add--151124-00021#1 By shiun--(S)
DEFINE g_detail_cnt3        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_idx3        LIKE type_t.num10
#add--151124-00021#1 By shiun--(E)
#end add-point
 
{</section>}
 
{<section id="apsq500.main" >}
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
   CALL cl_ap_init("aps","")
 
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
   DECLARE apsq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apsq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apsq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apsq500 WITH FORM cl_ap_formpath("aps",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apsq500_init()   
 
      #進入選單 Menu (="N")
      CALL apsq500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apsq500
      
   END IF 
   
   CLOSE apsq500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
 
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apsq500.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apsq500_init()
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
   CALL cl_set_combo_scc('imaf013','2022')
   CALL cl_set_combo_scc('b_pspa020','5440')
#   LET g_detail_idx3 = 1   #add--151124-00021# By shiun
   #end add-point
 
   CALL apsq500_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="apsq500.default_search" >}
PRIVATE FUNCTION apsq500_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " psoz001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " psoz002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " psoz003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " psoz004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " psoz038 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " psoz039 = '", g_argv[06], "' AND "
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
 
{<section id="apsq500.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION apsq500_ui_dialog()
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
#   LET g_detail_idx3 = 1   #add--151124-00021# By shiun
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL apsq500_b_fill()
   ELSE
      CALL apsq500_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_psoz_d.clear()
 
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
 
         CALL apsq500_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_psoz_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apsq500_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL apsq500_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL apsq500_qty1_show()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_psoz2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt2)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_psoz2_d.getLength() TO FORMONLY.cnt
        
               
         END DISPLAY
         
         #add--151124-00021#1 By shiun--(S)
         DISPLAY ARRAY g_psoz3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt2)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               DISPLAY g_detail_idx2 TO FORMONLY.idx
               DISPLAY g_psoz3_d.getLength() TO FORMONLY.cnt
        
               
         END DISPLAY
         #add--151124-00021#1 By shiun--(E)
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apsq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_navigator_setting(g_curs_index,g_row_count)
            CALL cl_set_comp_visible("sel",FALSE)
            CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
            CALL apsq500_qty1_show()
            #end add-point
 
         
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
               CALL apsq500_query()
               #add-point:ON ACTION query name="menu.query"
               CALL cl_set_comp_visible("sel",FALSE)
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
            CALL apsq500_filter()
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
            CALL apsq500_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_psoz_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"

               LET g_export_node[2] = base.typeInfo.create(g_psoz2_d)
               LET g_export_id[2]   = "s_detail2"
               
               #add--151124-00021#1 By shiun--(S)
               LET g_export_node[3] = base.typeInfo.create(g_psoz3_d)
               LET g_export_id[3]   = "s_detail3"
               #add--151124-00021#1 By shiun--(E)
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
            CALL apsq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apsq500_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apsq500_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apsq500_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_psoz_d.getLength()
               LET g_psoz_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_psoz_d.getLength()
               LET g_psoz_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_psoz_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psoz_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_psoz_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_psoz_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         # l<<
         ON ACTION first
            LET g_action_choice="first"
#            IF cl_auth_chk_act("first") THEN  #150602 by whitney mark
               CALL apsq500_fetch_page('F')
               CALL cl_navigator_setting(g_curs_index,g_row_count)
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               CONTINUE DIALOG
               #END add-point
               EXIT DIALOG
#            END IF  #150602 by whitney mark
            
         # <
         ON ACTION previous
            LET g_action_choice="previous"
#            IF cl_auth_chk_act("previous") THEN  #150602 by whitney mark
               CALL apsq500_fetch_page('P')
               CALL cl_navigator_setting(g_curs_index,g_row_count)
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               CONTINUE DIALOG
               #END add-point
               EXIT DIALOG
#            END IF  #150602 by whitney mark
            
         # O   
         ON ACTION jump
            LET g_action_choice="jump"
#            IF cl_auth_chk_act("jump") THEN  #150602 by whitney mark
               CALL apsq500_fetch_page('/')
               CALL cl_navigator_setting(g_curs_index,g_row_count)
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               CONTINUE DIALOG
               #END add-point
               EXIT DIALOG
#            END IF  #150602 by whitney mark
            
         # >   
         ON ACTION next
            LET g_action_choice="next"
#            IF cl_auth_chk_act("next") THEN  #150602 by whitney mark
               CALL apsq500_fetch_page('N')
               CALL cl_navigator_setting(g_curs_index,g_row_count)
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)              
               CONTINUE DIALOG
               #END add-point
               EXIT DIALOG
#            END IF  #150602 by whitney mark
            
         # >>l
         ON ACTION last
            LET g_action_choice="last"
#            IF cl_auth_chk_act("last") THEN  #150602 by whitney mark
               CALL apsq500_fetch_page('L')
               CALL cl_navigator_setting(g_curs_index,g_row_count)
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               CONTINUE DIALOG
               EXIT DIALOG
#            END IF  #150602 by whitney mark
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
 
{<section id="apsq500.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apsq500_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_wc       STRING   #組單頭construct
   DEFINE l_page_sql STRING   #組單頭sql
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
#161007-00015#1-s mod
   DISPLAY ' ' TO FORMONLY.page
   DISPLAY ' ' TO FORMONLY.tot_page
   LET g_row_count = 0
   LET g_curs_index = 0
   CALL cl_navigator_setting(g_curs_index,g_row_count)
#161007-00015#1-e mod

   #160727-00026#1-add-(S)
   CALL g_psoz2_d.clear()
   CALL g_psoz3_d.clear()
   #160727-00026#1-add-(E)
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_psoz_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON psoz004,psoz012,psoz014,psoz018,psoz021,psoz022,psoz031,psoz029,psoz030, 
          psoz036,psoz037
           FROM s_detail1[1].b_psoz004,s_detail1[1].b_psoz012,s_detail1[1].b_psoz014,s_detail1[1].b_psoz018, 
               s_detail1[1].b_psoz021,s_detail1[1].b_psoz022,s_detail1[1].b_psoz031,s_detail1[1].b_psoz029, 
               s_detail1[1].b_psoz030,s_detail1[1].b_psoz036,s_detail1[1].b_psoz037
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
 
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_psoz001>>----
         #----<<b_psoz002>>----
         #----<<b_psoz003>>----
         #----<<b_psoz038>>----
         #----<<b_psoz039>>----
         #----<<b_psoz004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz004
            #add-point:BEFORE FIELD b_psoz004 name="construct.b.page1.b_psoz004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz004
            
            #add-point:AFTER FIELD b_psoz004 name="construct.a.page1.b_psoz004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz004
            #add-point:ON ACTION controlp INFIELD b_psoz004 name="construct.c.page1.b_psoz004"
            
            #END add-point
 
 
         #----<<b_qty1>>----
         #----<<b_psoz012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz012
            #add-point:BEFORE FIELD b_psoz012 name="construct.b.page1.b_psoz012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz012
            
            #add-point:AFTER FIELD b_psoz012 name="construct.a.page1.b_psoz012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz012
            #add-point:ON ACTION controlp INFIELD b_psoz012 name="construct.c.page1.b_psoz012"
            
            #END add-point
 
 
         #----<<b_psoz014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz014
            #add-point:BEFORE FIELD b_psoz014 name="construct.b.page1.b_psoz014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz014
            
            #add-point:AFTER FIELD b_psoz014 name="construct.a.page1.b_psoz014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz014
            #add-point:ON ACTION controlp INFIELD b_psoz014 name="construct.c.page1.b_psoz014"
            
            #END add-point
 
 
         #----<<b_psoz018>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz018
            #add-point:BEFORE FIELD b_psoz018 name="construct.b.page1.b_psoz018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz018
            
            #add-point:AFTER FIELD b_psoz018 name="construct.a.page1.b_psoz018"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz018
            #add-point:ON ACTION controlp INFIELD b_psoz018 name="construct.c.page1.b_psoz018"
            
            #END add-point
 
 
         #----<<b_psoz021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz021
            #add-point:BEFORE FIELD b_psoz021 name="construct.b.page1.b_psoz021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz021
            
            #add-point:AFTER FIELD b_psoz021 name="construct.a.page1.b_psoz021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz021
            #add-point:ON ACTION controlp INFIELD b_psoz021 name="construct.c.page1.b_psoz021"
            
            #END add-point
 
 
         #----<<b_psoz022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz022
            #add-point:BEFORE FIELD b_psoz022 name="construct.b.page1.b_psoz022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz022
            
            #add-point:AFTER FIELD b_psoz022 name="construct.a.page1.b_psoz022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz022
            #add-point:ON ACTION controlp INFIELD b_psoz022 name="construct.c.page1.b_psoz022"
            
            #END add-point
 
 
         #----<<b_qty2>>----
         #----<<b_qty3>>----
         #----<<b_qty4>>----
         #----<<b_psoz031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz031
            #add-point:BEFORE FIELD b_psoz031 name="construct.b.page1.b_psoz031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz031
            
            #add-point:AFTER FIELD b_psoz031 name="construct.a.page1.b_psoz031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz031
            #add-point:ON ACTION controlp INFIELD b_psoz031 name="construct.c.page1.b_psoz031"
            
            #END add-point
 
 
         #----<<b_psoz029>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz029
            #add-point:BEFORE FIELD b_psoz029 name="construct.b.page1.b_psoz029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz029
            
            #add-point:AFTER FIELD b_psoz029 name="construct.a.page1.b_psoz029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz029
            #add-point:ON ACTION controlp INFIELD b_psoz029 name="construct.c.page1.b_psoz029"
            
            #END add-point
 
 
         #----<<b_psoz030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz030
            #add-point:BEFORE FIELD b_psoz030 name="construct.b.page1.b_psoz030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz030
            
            #add-point:AFTER FIELD b_psoz030 name="construct.a.page1.b_psoz030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz030
            #add-point:ON ACTION controlp INFIELD b_psoz030 name="construct.c.page1.b_psoz030"
            
            #END add-point
 
 
         #----<<b_psoz036>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz036
            #add-point:BEFORE FIELD b_psoz036 name="construct.b.page1.b_psoz036"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz036
            
            #add-point:AFTER FIELD b_psoz036 name="construct.a.page1.b_psoz036"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz036
            #add-point:ON ACTION controlp INFIELD b_psoz036 name="construct.c.page1.b_psoz036"
            
            #END add-point
 
 
         #----<<b_qty5>>----
         #----<<b_psoz037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_psoz037
            #add-point:BEFORE FIELD b_psoz037 name="construct.b.page1.b_psoz037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_psoz037
            
            #add-point:AFTER FIELD b_psoz037 name="construct.a.page1.b_psoz037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_psoz037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz037
            #add-point:ON ACTION controlp INFIELD b_psoz037 name="construct.c.page1.b_psoz037"
            
            #END add-point
 
 
         #----<<b_psoz005>>----
         #----<<b_psoz006>>----
         #----<<b_psoz007>>----
         #----<<b_psoz009>>----
         #----<<b_psoz010>>----
         #----<<b_psoz013>>----
         #----<<b_psoz015>>----
         #----<<b_psoz020>>----
         #----<<b_psoz026>>----
         #----<<b_psoz027>>----
         #----<<b_psoz028>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME l_wc ON psoz001,psoz038,psoz039,imaf013
 
         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD psoz001
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
            CALL q_psca001()
            DISPLAY g_qryparam.return1 TO psoz001
            NEXT FIELD psoz001
            
         ON ACTION controlp INFIELD psoz038
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_imaf001()
            DISPLAY g_qryparam.return1 TO psoz038
            NEXT FIELD psoz038

         AFTER FIELD psoz038
            CALL apsq500_psoz038_ref(GET_FLDBUF(psoz038))
            

      END CONSTRUCT
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
#2015/01/29 by stellar modify ----- (S)
#   LET l_page_sql = "SELECT DISTINCT psoz001,MAX(psoz002) psoz002,psoz038,psoz039,imaf013 ",
#                    " FROM psoz_t ",
#                    " LEFT OUTER JOIN imaf_t ON psozent = imafent AND psozsite = imafsite AND psoz038 = imaf001 ",
#                    " WHERE psozent = '",g_enterprise,"' ",
#                    "   AND psozsite = '",g_site,"' ",
#                    "   AND ",g_wc_filter CLIPPED,
#                    "   AND ",g_wc CLIPPED,
#                    "   AND ",g_wc2 CLIPPED,
#                    "   AND ",l_wc CLIPPED,
#                    " GROUP BY psoz001,psoz038,psoz039,imaf013 ",
#                    " ORDER BY psoz001 "
   LET l_page_sql = "SELECT DISTINCT psoz001,psoz002,psoz038,psoz039,imaf013 ",
                    " FROM psoz_t ",
                    " LEFT OUTER JOIN imaf_t ON psozent = imafent AND psozsite = imafsite AND psoz038 = imaf001 ",
                    "    ,(SELECT psozent as b_psozent,psozsite as b_psozsite,psoz001 as b_psoz001,MAX(psoz002) as b_psoz002 FROM psoz_t GROUP BY psozent,psozsite,psoz001) b",
                    " WHERE psozent = '",g_enterprise,"' ",
                    "   AND psozsite = '",g_site,"' ",
                    "   AND ",g_wc_filter CLIPPED,
                    "   AND ",g_wc CLIPPED,
                    "   AND ",g_wc2 CLIPPED,
                    "   AND ",l_wc CLIPPED,
                    "   AND psozent = b_psozent ",
                    "   AND psozsite= b_psozsite ",
                    "   AND psoz001 = b_psoz001 ",
                    "   AND psoz002 = b_psoz002 ",
                    " ORDER BY psoz001 "
   #2015/01/29 by stellar modify ----- (E)
   PREPARE apsq500_page_pb FROM l_page_sql
   DECLARE apsq500_page_cs SCROLL CURSOR WITH HOLD FOR apsq500_page_pb
   LET l_page_sql = "SELECT COUNT(*) FROM (",l_page_sql,")"
   PREPARE apsq500_cnt_pb FROM l_page_sql
   DECLARE apsq500_cnt_cs CURSOR FOR apsq500_cnt_pb
   OPEN apsq500_page_cs
   OPEN apsq500_cnt_cs
   FETCH apsq500_cnt_cs INTO g_row_count
   DISPLAY g_row_count TO FORMONLY.tot_page
   CALL apsq500_fetch_page('F')
   #end add-point
        
   LET g_error_show = 1
   CALL apsq500_b_fill()
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
 
{<section id="apsq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apsq500_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_psoz      RECORD
          psoz019   LIKE psoz_t.psoz019,
          psoz024   LIKE psoz_t.psoz024,
          psoz025   LIKE psoz_t.psoz025,
          psoz032   LIKE psoz_t.psoz032,
          psoz033   LIKE psoz_t.psoz033,
          psoz034   LIKE psoz_t.psoz034,
          psoz035   LIKE psoz_t.psoz035,
          psoz041   LIKE psoz_t.psoz041,
          psoz044   LIKE psoz_t.psoz044,  #160923-00029#1-add
          qty1      LIKE psoz_t.psoz012,
          qty2      LIKE psoz_t.psoz012,
          qty3      LIKE psoz_t.psoz012,
          qty4      LIKE psoz_t.psoz012,
          qty5      LIKE psoz_t.psoz012
                   END RECORD
   DEFINE l_gztd007   LIKE gztd_t.gztd007   #2015/01/26 by stellar add    
   DEFINE l_wc_t      STRING                #2015/08/25 by stellar add
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #2015/01/26 by stellar add ----- (S)
   LET l_gztd007 = ''
   SELECT gztd007 INTO l_gztd007
     FROM gztd_t
    WHERE gztd001 = 'N101'
   #2015/01/26 by stellar add ----- (E)
   
   #2015/08/25 by stellar add ----- (S)
   LET l_wc_t = g_wc
   IF cl_null(g_wc) THEN
      LET g_wc = g_wc3
   ELSE
      LET g_wc= g_wc, " AND ", g_wc3
   END IF
   #2015/08/25 by stellar add ----- (E)
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',psoz001,psoz002,psoz003,psoz038,psoz039,psoz004,'',psoz012,psoz014, 
       psoz018,psoz021,psoz022,'','','',psoz031,psoz029,psoz030,psoz036,'',psoz037,psoz005,psoz006,psoz007, 
       psoz009,psoz010,psoz013,psoz015,psoz020,psoz026,psoz027,psoz028  ,DENSE_RANK() OVER( ORDER BY psoz_t.psoz001, 
       psoz_t.psoz002,psoz_t.psoz003,psoz_t.psoz004,psoz_t.psoz038,psoz_t.psoz039) AS RANK FROM psoz_t", 
 
 
 
                     "",
                     " WHERE psozent= ? AND psozsite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("psoz_t"),
                     " ORDER BY psoz_t.psoz001,psoz_t.psoz002,psoz_t.psoz003,psoz_t.psoz004,psoz_t.psoz038,psoz_t.psoz039"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET g_wc = l_wc_t   #2015/08/25 by stellar add
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   #170207-00023#1 add---start---
   LET ls_sql_rank = "SELECT  UNIQUE '',psoz001,psoz002,psoz003,psoz038,psoz039,psoz004,'',psoz012,psoz014, 
       psoz018,psoz021,psoz022,'','','',psoz031,psoz029,psoz030,psoz036,'',psoz037,psoz005,psoz006,psoz007, 
       psoz009,psoz010,psoz013,psoz015,psoz020,psoz026,psoz027,psoz028  ,DENSE_RANK() OVER( ORDER BY psoz_t.psoz001, 
       psoz_t.psoz002,psoz_t.psoz003,psoz_t.psoz004,psoz_t.psoz038,psoz_t.psoz039) AS RANK FROM psoz_t", 
                     " WHERE psozent= ? AND psozsite= ? AND 1=1 ",
                     "   AND (psoz012 > 0 OR psoz014 > 0 OR psoz018 > 0 OR psoz021 > 0 OR psoz022 > 0 ",
                     "    OR psoz031 > 0 OR (psoz029-psoz016)> 0 OR (psoz030-psoz017) > 0 ",
                     "    OR psoz036 > 0 OR psoz037 > 0 OR psoz005 > 0 OR psoz006 > 0 OR psoz007 > 0 ",
                     "    OR psoz009 > 0 OR psoz010 > 0 OR psoz013 > 0 OR psoz015 > 0 ",
                     "    OR psoz020 > 0 OR psoz026 > 0 OR psoz027 > 0 OR psoz028 > 0 OR psoz019 > 0 ",
                     "    OR psoz041 > 0 OR psoz024 > 0 OR psoz025 > 0 OR psoz032 > 0 ",
                     "    OR psoz033 > 0 OR psoz034 > 0 OR psoz035 > 0 OR psoz044 > 0) AND ",ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("psoz_t"),
                     " ORDER BY psoz_t.psoz001,psoz_t.psoz002,psoz_t.psoz003,psoz_t.psoz004,psoz_t.psoz038,psoz_t.psoz039"
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
   PREPARE b_fill_cnt_pre1 FROM g_sql
   EXECUTE b_fill_cnt_pre1 USING g_enterprise, g_site INTO g_tot_cnt
   FREE b_fill_cnt_pre1
   #170207-00023#1 add---end---
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
 
   LET g_sql = "SELECT '',psoz001,psoz002,psoz003,psoz038,psoz039,psoz004,'',psoz012,psoz014,psoz018, 
       psoz021,psoz022,'','','',psoz031,psoz029,psoz030,psoz036,'',psoz037,psoz005,psoz006,psoz007,psoz009, 
       psoz010,psoz013,psoz015,psoz020,psoz026,psoz027,psoz028",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, " AND ", g_wc3   #2015/08/25 by stellar mark
   
   #160222-00006#1  By Ann_Huang --- mark Start ---
   #ming 2015/05/06 modify memo -----(S) 
   #交期重排減少量=psoz016+psoz029
   #交期重排增加量=psoz017+psoz030
   #ming 2015/05/06 modify memo -----(E)
   #160222-00006#1  By Ann_Huang --- mark End ---

   #160222-00006#1  By Ann_Huang --- add Start ---
   #交期重排減少量 = -psoz016+psoz029
   #交期重排增加量 = -psoz017+psoz030
   #160222-00006#1  By Ann_Huang --- add End ---
   
   #160701-00030#1 20160704 modify -----(S) 
   #LET g_sql = "SELECT  UNIQUE '',psoz001,psoz002,psoz003,psoz038,psoz039,psoz004,'',psoz012,psoz014,psoz018, ",
   #            #"               psoz021,psoz022,'','','',psoz031,psoz016+psoz029,psoz017+psoz030,psoz036,'',psoz037,psoz005, ",     #160222-00006#1  By Ann_Huang --- mark 
   #            "               psoz021,psoz022,'','','',psoz031,(-psoz016+psoz029),(-psoz017+psoz030),psoz036,'',psoz037,psoz005, ", #160222-00006#1  By Ann_Huang --- add
   #            "               psoz006,psoz007,psoz009,psoz010,psoz013,psoz015,psoz020,psoz026,psoz027,psoz028 ", 
   LET g_sql = "SELECT  UNIQUE '',psoz001,psoz002,psoz003,psoz038,psoz039,psoz004,'',psoz012,psoz014,psoz018, ",
               "               psoz021,psoz022,'','','',psoz031,(-psoz016+psoz029),(-psoz017+psoz030),psoz036,'', ",
               "               psoz037,COALESCE(psoz005,0), ",
               "               COALESCE(psoz006,0),COALESCE(psoz007,0),COALESCE(psoz009,0),COALESCE(psoz010,0), ",
               "               COALESCE(psoz013,0),COALESCE(psoz015,0),COALESCE(psoz020,0),COALESCE(psoz026,0), ",
               "               COALESCE(psoz027,0),COALESCE(psoz028,0) ",
   #160701-00030#1 20160704 modify -----(E) 
               "  FROM psoz_t ",
               " LEFT OUTER JOIN pspa_t ON pspaent = psozent ",
               "                       AND pspasite = psozsite ",
               "                       AND psoz001 = pspa001 ",
               "                       AND psoz002 = pspa002 ",
               "                       AND psoz003 = pspa016 ",
               " WHERE psozent= ? AND psozsite= ? AND 1=1 AND ", ls_wc
   #170207-00023#1 add---start---
   LET g_sql = g_sql, "AND (psoz012 > 0 OR psoz014 > 0 OR psoz018 > 0 OR psoz021 > 0 OR psoz022 > 0 ", 
                      " OR psoz031 > 0 OR (psoz029-psoz016)> 0 OR (psoz030-psoz017) > 0 ",
                      " OR psoz036 > 0 OR psoz037 > 0 OR psoz005 > 0 OR psoz006 > 0 OR psoz007 > 0 ",
                      " OR psoz009 > 0 OR psoz010 > 0 OR psoz013 > 0 OR psoz015 > 0 ",
                      " OR psoz020 > 0 OR psoz026 > 0 OR psoz027 > 0 OR psoz028 > 0 OR psoz019 > 0 ",
                      " OR psoz041 > 0 OR psoz024 > 0 OR psoz025 > 0 OR psoz032 > 0 ",
                      " OR psoz033 > 0 OR psoz034 > 0 OR psoz035 > 0 OR psoz044 > 0)"
   #170207-00023#1 add---end---
    
   LET g_sql = g_sql, " ORDER BY psoz_t.psoz004 "


   INITIALIZE g_psoz_m.* TO NULL
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apsq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apsq500_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_psoz_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #160923-00029#1-s-mod 多抓psoz044
   ##160701-00030#1 20160704 add -----(S) 
   #LET g_sql = "SELECT COALESCE(psoz019,0),COALESCE(psoz024,0),COALESCE(psoz025,0), ",
   #            "       COALESCE(psoz032,0),COALESCE(psoz033,0),COALESCE(psoz034,0), ",
   #            "       COALESCE(psoz035,0),COALESCE(psoz041,0) ",
   #            "  FROM psoz_t ",
   #            " WHERE psozent  = '",g_enterprise,"' ",
   #            "   AND psozsite = '",g_site,"' ",
   #            "   AND psoz001  = ? ",
   #            "   AND psoz002  = ? ",
   #            "   AND psoz003  = ? ",
   #            "   AND psoz004  = ? ",
   #            "   AND psoz038  = ? ",
   #            "   AND psoz039  = ? "
   #PREPARE apsq500_b_fill_get_psoz_prep FROM g_sql
   #160701-00030#1 20160704 add -----(E) 
   LET g_sql = "SELECT COALESCE(psoz019,0),COALESCE(psoz024,0),COALESCE(psoz025,0), ",
               "       COALESCE(psoz032,0),COALESCE(psoz033,0),COALESCE(psoz034,0), ",
               "       COALESCE(psoz035,0),COALESCE(psoz041,0),COALESCE(psoz044,0) ",
               "  FROM psoz_t ",
               " WHERE psozent  = '",g_enterprise,"' ",
               "   AND psozsite = '",g_site,"' ",
               "   AND psoz001  = ? ",
               "   AND psoz002  = ? ",
               "   AND psoz003  = ? ",
               "   AND psoz004  = ? ",
               "   AND psoz038  = ? ",
               "   AND psoz039  = ? "
   PREPARE apsq500_b_fill_get_psoz_prep FROM g_sql
   #160923-00029#1-e-mod
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_psoz_d[l_ac].sel,g_psoz_d[l_ac].psoz001,g_psoz_d[l_ac].psoz002,g_psoz_d[l_ac].psoz003, 
       g_psoz_d[l_ac].psoz038,g_psoz_d[l_ac].psoz039,g_psoz_d[l_ac].psoz004,g_psoz_d[l_ac].qty1,g_psoz_d[l_ac].psoz012, 
       g_psoz_d[l_ac].psoz014,g_psoz_d[l_ac].psoz018,g_psoz_d[l_ac].psoz021,g_psoz_d[l_ac].psoz022,g_psoz_d[l_ac].qty2, 
       g_psoz_d[l_ac].qty3,g_psoz_d[l_ac].qty4,g_psoz_d[l_ac].psoz031,g_psoz_d[l_ac].psoz029,g_psoz_d[l_ac].psoz030, 
       g_psoz_d[l_ac].psoz036,g_psoz_d[l_ac].qty5,g_psoz_d[l_ac].psoz037,g_psoz_d[l_ac].psoz005,g_psoz_d[l_ac].psoz006, 
       g_psoz_d[l_ac].psoz007,g_psoz_d[l_ac].psoz009,g_psoz_d[l_ac].psoz010,g_psoz_d[l_ac].psoz013,g_psoz_d[l_ac].psoz015, 
       g_psoz_d[l_ac].psoz020,g_psoz_d[l_ac].psoz026,g_psoz_d[l_ac].psoz027,g_psoz_d[l_ac].psoz028
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_psoz_d[l_ac].statepic = cl_get_actipic(g_psoz_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      INITIALIZE l_psoz.* TO NULL
      #160923-00029#1-s-mod 多抓取psoz044
      ##160701-00030#1 20160704 modify -----(S) 
      ##移到foreach之外 
      ##且，使用execute即可，key值都對上了，也只會抓到唯一的資料  
      ##DECLARE psoz_curs CURSOR FOR
      ##   SELECT psoz019,psoz024,psoz025,psoz032,psoz033,psoz034,psoz035,psoz041  
      ##     FROM psoz_t 
      ##    WHERE psozent = g_enterprise
      ##      AND psozsite = g_site
      ##      AND psoz001 = g_psoz_d[l_ac].psoz001
      ##      AND psoz002 = g_psoz_d[l_ac].psoz002
      ##      AND psoz003 = g_psoz_d[l_ac].psoz003
      ##      AND psoz004 = g_psoz_d[l_ac].psoz004
      ##      AND psoz038 = g_psoz_d[l_ac].psoz038
      ##      AND psoz039 = g_psoz_d[l_ac].psoz039
      ##      
      ##FOREACH psoz_curs INTO l_psoz.psoz019,l_psoz.psoz024,l_psoz.psoz025,l_psoz.psoz032,
      ##                       l_psoz.psoz033,l_psoz.psoz034,l_psoz.psoz035,l_psoz.psoz041
      ##   IF SQLCA.sqlcode THEN
      ##      INITIALIZE g_errparam TO NULL
      ##      LET g_errparam.code = SQLCA.sqlcode
      ##      LET g_errparam.extend = "psoz_curs"
      ##      LET g_errparam.popup = TRUE
      ##      CALL cl_err()
      ##
      ##      EXIT FOREACH
      ##   END IF
      ##END FOREACH
      #
      #EXECUTE apsq500_b_fill_get_psoz_prep USING g_psoz_d[l_ac].psoz001,g_psoz_d[l_ac].psoz002,
      #                                           g_psoz_d[l_ac].psoz003,g_psoz_d[l_ac].psoz004,
      #                                           g_psoz_d[l_ac].psoz038,g_psoz_d[l_ac].psoz039
      #                                      INTO l_psoz.psoz019,l_psoz.psoz024,l_psoz.psoz025,
      #                                           l_psoz.psoz032,l_psoz.psoz033,l_psoz.psoz034,
      #                                           l_psoz.psoz035,l_psoz.psoz041
      ##160701-00030#1 20160704 modify -----(E) 
      EXECUTE apsq500_b_fill_get_psoz_prep USING g_psoz_d[l_ac].psoz001,g_psoz_d[l_ac].psoz002,
                                                 g_psoz_d[l_ac].psoz003,g_psoz_d[l_ac].psoz004,
                                                 g_psoz_d[l_ac].psoz038,g_psoz_d[l_ac].psoz039
                                            INTO l_psoz.psoz019,l_psoz.psoz024,l_psoz.psoz025,
                                                 l_psoz.psoz032,l_psoz.psoz033,l_psoz.psoz034,
                                                 l_psoz.psoz035,l_psoz.psoz041,l_psoz.psoz044
      #160923-00029#1-e-mod
      #受訂量qty1:訂單未交量psoz005+預測數量psoz006+安全庫存量psoz007
      #160701-00030#1 20160704 mark -----(S) 
      #把判斷的時間移除，在sql中如果是null的話就以0取出  
      #IF g_psoz_d[l_ac].psoz005 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz005 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz006 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz006 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz007 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz007 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      
      LET l_psoz.qty1 =  g_psoz_d[l_ac].psoz005 + g_psoz_d[l_ac].psoz006 + g_psoz_d[l_ac].psoz007
      LET g_psoz_d[l_ac].qty1 =  l_psoz.qty1
      LET g_psoz_d[l_ac].qty1 = g_psoz_d[l_ac].qty1 USING l_gztd007   #2015/01/26 by stellar add
      DISPLAY BY NAME g_psoz_d[l_ac].qty1
      
      #在驗量qty2:psoz019+psoz041
      #160701-00030#1 20160704 mark -----(S) 
      #移到sql直接取0
      #IF l_psoz.psoz019 IS NULL THEN
      #   LET l_psoz.psoz019 = 0
      #END IF
      #IF l_psoz.psoz041 IS NULL THEN
      #   LET l_psoz.psoz041 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      
      LET l_psoz.qty2 = l_psoz.psoz019 + l_psoz.psoz041
      LET g_psoz_d[l_ac].qty2 = l_psoz.qty2
      LET g_psoz_d[l_ac].qty2 = g_psoz_d[l_ac].qty2 USING l_gztd007   #2015/01/26 by stellar add
      DISPLAY BY NAME g_psoz_d[l_ac].qty2
      
      #在製量qty3:psoz024+psoz025
      #160701-00030#1 20160704 mark -----(S) 
      #直接移到sql中取0
      #IF l_psoz.psoz024 IS NULL THEN
      #   LET l_psoz.psoz024 = 0
      #END IF
      #IF l_psoz.psoz025 IS NULL THEN
      #   LET l_psoz.psoz025 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 

      LET l_psoz.qty3 = l_psoz.psoz024 + l_psoz.psoz025
      LET g_psoz_d[l_ac].qty3 = l_psoz.qty3
      LET g_psoz_d[l_ac].qty3 = g_psoz_d[l_ac].qty3 USING l_gztd007   #2015/01/26 by stellar add
      DISPLAY BY NAME g_psoz_d[l_ac].qty3
      
      #替代量qty4:訂單未交替他需求量psoz009+預測替他需求量psoz010+計劃備料替他需求量psoz013
      #         +工單備料替他需求量psoz015+替代庫存量psoz020+替代請購量psoz026+替代採購量+psoz027+替代在製量psoz028
      #160701-00030#1 20160704 mark -----(S) 
      #移到sql中，是null的話，直接取0
      #IF g_psoz_d[l_ac].psoz009 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz009 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz010 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz010 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz013 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz013 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz015 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz015 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz020 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz020 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz026 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz026 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz027 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz027 = 0
      #END IF
      #IF g_psoz_d[l_ac].psoz028 IS NULL THEN
      #   LET g_psoz_d[l_ac].psoz028 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      
      #20151105 by stellar add ----- (S)
      #將替代規劃採購量及替代規劃製造量移到替代量加項內
      #160701-00030#1 20160704 mark -----(S) 
      #移到sql中，如果是null的話，就直接抓0出來 
      #IF l_psoz.psoz033 IS NULL THEN
      #   LET l_psoz.psoz033 = 0
      #END IF
      #IF l_psoz.psoz035 IS NULL THEN
      #   LET l_psoz.psoz035 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      #20151105 by stellar add ----- (E)
      #2014/10/30 by stellar add --------------- (S)
      LET g_psoz_d[l_ac].psoz009 = g_psoz_d[l_ac].psoz009 * (-1)
      LET g_psoz_d[l_ac].psoz010 = g_psoz_d[l_ac].psoz010 * (-1)
      LET g_psoz_d[l_ac].psoz013 = g_psoz_d[l_ac].psoz013 * (-1)
      LET g_psoz_d[l_ac].psoz015 = g_psoz_d[l_ac].psoz015 * (-1)
      #2014/10/30 by stellar add --------------- (E)
      LET l_psoz.qty4 = g_psoz_d[l_ac].psoz009 + g_psoz_d[l_ac].psoz010 + g_psoz_d[l_ac].psoz013 
                      + g_psoz_d[l_ac].psoz015 + g_psoz_d[l_ac].psoz020 + g_psoz_d[l_ac].psoz026 
                      + g_psoz_d[l_ac].psoz027 + g_psoz_d[l_ac].psoz028
      #               + l_psoz.psoz033 + l_psoz.psoz035   #20151105 by stellar add  #160923-00029#1-s-mod
                      + l_psoz.psoz033 + l_psoz.psoz035 + l_psoz.psoz044            #160923-00029#1-e-mod
                      
      LET g_psoz_d[l_ac].qty4 = l_psoz.qty4
      LET g_psoz_d[l_ac].qty4 = g_psoz_d[l_ac].qty4 USING l_gztd007   #2015/01/26 by stellar add
      DISPLAY BY NAME g_psoz_d[l_ac].qty4
      
      #規畫採購或製造量qty5:psoz032+psoz033+psoz034+psoz035
      #160701-00030#1 20160704 mark -----(S) 
      #移到sql中直接處理 
      #IF l_psoz.psoz032 IS NULL THEN
      #   LET l_psoz.psoz032 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      
      #20151105 by stellar mark ----- (S)
      #將替代規劃採購量及替代規劃製造量移到替代量加項內
#      IF l_psoz.psoz033 IS NULL THEN
#         LET l_psoz.psoz033 = 0
#      END IF
      #20151105 by stellar mark ----- (E)
      #160701-00030#1 20160704 mark -----(S) 
      #移到sql中直接處理
      #IF l_psoz.psoz034 IS NULL THEN
      #   LET l_psoz.psoz034 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      #20151105 by stellar modify ----- (S)
      #將替代規劃採購量及替代規劃製造量移到替代量加項內
#      IF l_psoz.psoz035 IS NULL THEN
#         LET l_psoz.psoz035 = 0
#      END IF
#      LET l_psoz.qty5 = l_psoz.psoz032 + l_psoz.psoz033 + l_psoz.psoz034 + l_psoz.psoz035
      LET l_psoz.qty5 = l_psoz.psoz032 + l_psoz.psoz034
      #20151105 by stellar modify ----- (E)
      LET g_psoz_d[l_ac].qty5 = l_psoz.qty5
      LET g_psoz_d[l_ac].qty5 = g_psoz_d[l_ac].qty5 USING l_gztd007   #2015/01/26 by stellar add
      DISPLAY BY NAME g_psoz_d[l_ac].qty5
      #end add-point
 
      CALL apsq500_detail_show("'1'")      
 
      CALL apsq500_psoz_t_mask()
 
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
   
 
   
   CALL g_psoz_d.deleteElement(g_psoz_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF g_detail_idx > g_psoz_d.getLength() THEN
      LET g_detail_idx = g_psoz_d.getLength()
      DISPLAY g_detail_idx TO FORMONLY.h_index
   END IF
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL apsq500_qty1_show()
   #end add-point
 
   LET g_detail_cnt = g_psoz_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apsq500_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apsq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apsq500_detail_action_trans()
 
   IF g_psoz_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL apsq500_fetch()
   END IF
   
      CALL apsq500_filter_show('psoz004','b_psoz004')
   CALL apsq500_filter_show('psoz012','b_psoz012')
   CALL apsq500_filter_show('psoz014','b_psoz014')
   CALL apsq500_filter_show('psoz018','b_psoz018')
   CALL apsq500_filter_show('psoz021','b_psoz021')
   CALL apsq500_filter_show('psoz022','b_psoz022')
   CALL apsq500_filter_show('psoz031','b_psoz031')
   CALL apsq500_filter_show('psoz029','b_psoz029')
   CALL apsq500_filter_show('psoz030','b_psoz030')
   CALL apsq500_filter_show('psoz036','b_psoz036')
   CALL apsq500_filter_show('psoz037','b_psoz037')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apsq500_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE l_gzcb003       LIKE gzcb_t.gzcb003
   DEFINE l_gztd007       LIKE gztd_t.gztd007   #2015/01/26 by stellar add 
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   IF g_detail_idx = 0 THEN
      RETURN
   END IF
   CALL g_psoz2_d.clear()
   #2015/01/26 by stellar add ----- (S)
   LET l_gztd007 = ''
   SELECT gztd007 INTO l_gztd007
     FROM gztd_t
    WHERE gztd001 = 'N101'
   #2015/01/26 by stellar add ----- (E)
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   #160701-00030#1 20160704 modify -----(S) 
   ##160614-00027#1 20160615 modify by ming -----(S) 
   ##LET g_sql = "SELECT UNIQUE pspa004,pspa020,pspa006,'', ",
   ##            "       pspa014,'','', ",  #2015/10/12 by stellar add
   ##            "       pspa009,'' ",      #2015/01/13 by stellar add ''
   ##            "      ,pspa017,'','' ",   #2015/09/17 by stellar add
   ##            "  FROM pspa_t ",   
   ##            " WHERE pspaent = '",g_enterprise,"' ",
   ##            "   AND pspasite = '",g_site,"' ",
   ##            "   AND pspa001 = ? AND pspa002 = ? ",
   ##            "   AND pspa012 = ? AND NVL(pspa013,' ') = NVL(?,' ') ",
   ##            " ORDER BY pspa004 "
   #LET g_sql = "SELECT UNIQUE pspa004,pspa020,pspa006,'', ",
   #            "       pspa014,'','', ",  
   #            "       pspa009,COALESCE(pspa021,'N'),'' ",      
   #            "      ,pspa017,'','' ",   
   #            "  FROM pspa_t ",   
   #            " WHERE pspaent = '",g_enterprise,"' ",
   #            "   AND pspasite = '",g_site,"' ",
   #            "   AND pspa001 = ? AND pspa002 = ? ",
   #            "   AND pspa012 = ? AND NVL(pspa013,' ') = NVL(?,' ') ",
   #            " ORDER BY pspa004 "
   ##160614-00027#1 20160615 modify by ming -----(E) 
   LET g_sql = "SELECT UNIQUE pspa004,pspa020,pspa006, ", 
               "       (SELECT psph009 FROM psph_t ", 
               "         WHERE psphent = pspaent AND psphsite = pspasite ", 
               "           AND psph001 = pspa001 AND psph002  = pspa002 ", 
               "           AND psph010 = pspa006 AND ROWNUM   = 1 ", 
               "           AND psph004 = (SELECT MIN(psph004) FROM psph_t ", 
               "                           WHERE psphent = pspaent AND psphsite = pspasite ", 
               "                             AND psph001 = pspa001 AND psph002  = pspa002 ", 
               "                             AND psph010 = pspa006 )), ",
               "       pspa014,(SELECT imaal003 FROM imaal_t ",
               "                 WHERE imaalent = '",g_enterprise,"' ",
               "                   AND imaal001 = pspa014 ",
               "                   AND imaal002 = '",g_dlang,"' ), ",
               "               (SELECT imaal004 FROM imaal_t ",
               "                 WHERE imaalent = '",g_enterprise,"' ",
               "                   AND imaal001 = pspa014 ",
               "                   AND imaal002 = '",g_dlang,"' ), ",
               "       COALESCE(pspa009,0),COALESCE(pspa021,'N'),'', ",
               "       pspa017,(SELECT imaal003 FROM imaal_t ",
               "                 WHERE imaalent = '",g_enterprise,"' ",
               "                   AND imaal001 = pspa017 ",
               "                   AND imaal002 = '",g_dlang,"' ), ",
               "               (SELECT imaal004 FROM imaal_t ",
               "                 WHERE imaalent = '",g_enterprise,"' ",
               "                   AND imaal001 = pspa017 ",
               "                   AND imaal002 = '",g_dlang,"' ) ",
               "  FROM pspa_t ",
               " WHERE pspaent  = '",g_enterprise,"' ",
               "   AND pspasite = '",g_site,"' ",
               "   AND pspa001  = ? AND pspa002 = ? ",
               "   AND pspa012  = ? AND NVL(pspa013,' ') = NVL(?,' ') ",
               " ORDER BY pspa004 "
   #160701-00030#1 20160704 modify -----(E) 
   
   PREPARE apsq500_pb2 FROM g_sql
   DECLARE b_fill_curs2 CURSOR FOR apsq500_pb2
   
   OPEN b_fill_curs2 USING g_psoz_d[g_detail_idx].psoz001,
                           g_psoz_d[g_detail_idx].psoz002,
                           g_psoz_d[g_detail_idx].psoz038,
                           g_psoz_d[g_detail_idx].psoz039

 
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_psoz2_d[l_ac].pspa004,g_psoz2_d[l_ac].pspa020,g_psoz2_d[l_ac].pspa006,
                             g_psoz2_d[l_ac].psph009,   #2015/01/13 by stellar add
                             g_psoz2_d[l_ac].pspa014,g_psoz2_d[l_ac].pspa014_desc,g_psoz2_d[l_ac].pspa014_desc1,   #2015/10/12 by stellar add
                             #160614-00027#1 20160615 modify by ming -----(S) 
                             #g_psoz2_d[l_ac].pspa009,g_psoz2_d[l_ac].qty6
                             g_psoz2_d[l_ac].pspa009,g_psoz2_d[l_ac].pspa021,g_psoz2_d[l_ac].qty6
                             #160614-00027#1 20160615 modify by ming -----(E) 
                            ,g_psoz2_d[l_ac].pspa017,g_psoz2_d[l_ac].pspa017_desc,   #2015/09/17 by stellar add
                             g_psoz2_d[l_ac].pspa017_desc1   #2015/09/17 by stellar add
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      #避免計算時有空值
      #160701-00030#1 20160704 mark -----(S) 
      #
      #IF g_psoz2_d[l_ac].pspa009 IS NULL THEN
      #   LET g_psoz2_d[l_ac].pspa009 = 0
      #END IF
      #160701-00030#1 20160704 mark -----(E) 
      
      #160701-00030#1 20160704 mark -----(S) 
      #移到主sql中處理 
      ##2015/01/13 by stellar add ----- (S)
      ##單據號碼改顯示訂單單號
      ##160608-00013#2 20160620 modify by ming -----(S) 
      ##DECLARE psph009_cs CURSOR FOR
      ## SELECT psph009 FROM psph_t
      ##  WHERE psphent = g_enterprise
      ##    AND psphsite = g_site
      ##    AND psph001 = g_psoz_d[g_detail_idx].psoz001
      ##    AND psph002 = g_psoz_d[g_detail_idx].psoz002
      ##    AND psph007 = g_psoz2_d[l_ac].pspa006
      ##  ORDER BY psph009
      #DECLARE psph009_cs CURSOR FOR
      # SELECT psph009 FROM psph_t
      #  WHERE psphent = g_enterprise
      #    AND psphsite = g_site
      #    AND psph001 = g_psoz_d[g_detail_idx].psoz001
      #    AND psph002 = g_psoz_d[g_detail_idx].psoz002
      #    AND psph010 = g_psoz2_d[l_ac].pspa006
      #  ORDER BY psph004
      ##160608-00013#2 20160620 modify by ming -----(E) 
      #  
      #FOREACH psph009_cs INTO g_psoz2_d[l_ac].psph009
      #   EXIT FOREACH
      #END FOREACH
      ##2015/01/13 by stellar add ----- (E)
      #160701-00030#1 20160704 mark -----(E) 
      
      #抓取系統應用欄位一來決定正負
      #160728-00024#1-mod-(S) gzcb003是char，替代字元應為字元型態
      ##160701-00030#1 20160704 modify -----(S) 
      ##LET l_gzcb003 = 0
      ##SELECT gzcb003 INTO l_gzcb003 FROM gzcb_t
      ## WHERE gzcb001 = '5440'
      ##   AND gzcb002 = g_psoz2_d[l_ac].pspa020
      ##IF cl_null(l_gzcb003) THEN LET l_gzcb003 = 0 END IF
      #LET l_gzcb003 = 0
      #SELECT COALESCE(gzcb003,0) INTO l_gzcb003 FROM gzcb_t
      # WHERE gzcb001 = '5440'
      #   AND gzcb002 = g_psoz2_d[l_ac].pspa020
      ##160701-00030#1 20160704 modify -----(E) 
      LET l_gzcb003 = 0
      SELECT COALESCE(gzcb003,'0') INTO l_gzcb003 FROM gzcb_t
       WHERE gzcb001 = '5440'
         AND gzcb002 = g_psoz2_d[l_ac].pspa020
      #160728-00024#1-mod-(E)
      IF l_ac = 1 THEN
         LET g_psoz2_d[l_ac].qty6 = g_psoz2_d[l_ac].pspa009 * l_gzcb003
      ELSE
         IF l_ac > 1 THEN
            LET g_psoz2_d[l_ac].qty6 = (g_psoz2_d[l_ac].pspa009 * l_gzcb003) + g_psoz2_d[l_ac-1].qty6
         END IF
      END IF 
      
      LET g_psoz2_d[l_ac].qty6 = g_psoz2_d[l_ac].qty6 USING l_gztd007   #2015/01/26 by stellar add
      
      #160701-00030#1 20160704 mark -----(S) 
      #移到主sql中 
      ##2015/09/17 by stellar add ----- (S)
      #CALL s_desc_get_item_desc(g_psoz2_d[l_ac].pspa017)
      #     RETURNING g_psoz2_d[l_ac].pspa017_desc,g_psoz2_d[l_ac].pspa017_desc1
      ##2015/09/17 by stellar add ----- (E)
      #
      ##2015/10/12 by stellar add ----- (S)
      #IF NOT cl_null(g_psoz2_d[l_ac].pspa014) THEN
      #   CALL s_desc_get_item_desc(g_psoz2_d[l_ac].pspa014)
      #        RETURNING g_psoz2_d[l_ac].pspa014_desc,g_psoz2_d[l_ac].pspa014_desc1
      #END IF
      #2015/10/12 by stellar add ----- (E) 
      #160701-00030#1 20160704 mark -----(E) 
      
      #160621-00010#1 20160626 mark by ming -----(S) 
      #改正常顯示 
      ##160614-00027#1 20160615 add by ming -----(S) 
      ##當供需類別為I.庫存時，此欄位一律顯示為null 
      #IF g_psoz2_d[l_ac].pspa020 = 'I' THEN 
      #   LET g_psoz2_d[l_ac].pspa021 = ''
      #END IF 
      ##160614-00027#1 20160615 add by ming -----(E) 
      #160621-00010#1 20160626 mark by ming -----(E) 
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   
   #160615-00042#1 20160626 add by ming -----(S) 
   CALL g_psoz3_d.clear()
   #160615-00042#1 20160626 add by ming -----(E) 
   
   #160701-00030#1 20160704 modify -----(S) 
   ##add--151124-00021#1 By shiun--(S)
   ##160621-00010#1 20160626 modify by ming -----(S) 
   ##LET g_sql = "SELECT UNIQUE pspt005,'',pspt006,'',pspt007,pspt003 ",
   #LET g_sql = "SELECT UNIQUE pspt005,'',pspt006,'',pspt013,pspt014,COALESCE(pspt015,'N'),pspt007,pspt003 ",
   ##160621-00010#1 20160626 modify by ming -----(E) 
   #            "  FROM pspt_t ",   
   #            " WHERE psptent = '",g_enterprise,"' ",
   #            "   AND psptsite = '",g_site,"' ",
   #            "   AND pspt001 = ? AND pspt002 = ? ",
   #            "   AND pspt011 = ? AND NVL(pspt012,' ') = NVL(?,' ') ",
   #            " ORDER BY pspt003 "
   LET g_sql = "SELECT UNIQUE pspt005,(SELECT inayl003 FROM inayl_t ",
               "                        WHERE inaylent = '",g_enterprise,"' ",
               "                          AND inayl001 = pspt005 ",
               "                          AND inayl002 = '",g_dlang,"' ), ",
               "       pspt006,(SELECT inab003 FROM inab_t ",
               "                 WHERE inabent = '",g_enterprise,"' ",
               "                   AND inabsite = '",g_site,"' ",
               "                   AND inab001 = pspt005 ",
               "                   AND inab002 = pspt006 ), ",
               "       pspt013,pspt014,COALESCE(pspt015,'N'),pspt007,pspt003 ",
               "  FROM pspt_t ",
               " WHERE psptent = '",g_enterprise,"' ",
               "   AND psptsite = '",g_site,"' ",
               "   AND pspt001 = ? AND pspt002 = ? ",
               "   AND pspt011 = ? AND NVL(pspt012,' ') = NVL(?,' ') ",
               " ORDER BY pspt003 "
   #160701-00030#1 20160704 modify -----(E) 
   
   PREPARE apsq500_pb3 FROM g_sql
   DECLARE b_fill_curs3 CURSOR FOR apsq500_pb3
   
   OPEN b_fill_curs3 USING g_psoz_d[g_detail_idx].psoz001,
                           g_psoz_d[g_detail_idx].psoz002,
                           g_psoz_d[g_detail_idx].psoz038,
                           g_psoz_d[g_detail_idx].psoz039

 
 
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_psoz3_d[l_ac].pspt005,g_psoz3_d[l_ac].pspt005_desc,g_psoz3_d[l_ac].pspt006,
                             g_psoz3_d[l_ac].pspt006_desc,
                             g_psoz3_d[l_ac].pspt013,g_psoz3_d[l_ac].pspt014, #160621-00010#1 20160626 add by ming 
                             g_psoz3_d[l_ac].pspt015,                         #160621-00010#1 20160626 add by ming 
                             g_psoz3_d[l_ac].pspt007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      #160701-00030#1 20160704 mark -----(S) 
      #移到主sql 
      #CALL s_desc_get_stock_desc(g_site,g_psoz3_d[l_ac].pspt005) RETURNING g_psoz3_d[l_ac].pspt005_desc
      #CALL s_desc_get_locator_desc(g_site,g_psoz3_d[l_ac].pspt005,g_psoz3_d[l_ac].pspt006) RETURNING g_psoz3_d[l_ac].pspt006_desc
      #160701-00030#1 20160704 mark -----(E) 
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  9035
         LET g_errparam.extend =  ""
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
   END FOREACH
   #add--151124-00021#1 By shiun--(E)
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   CALL g_psoz2_d.deleteElement(g_psoz2_d.getLength())  
   FREE apsq500_pb2
   

   #單身2總筆數顯示
   LET g_detail_cnt2 = g_psoz2_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
   #add--151124-00021#1 By shiun--(S)
   CALL g_psoz3_d.deleteElement(g_psoz3_d.getLength())  
   FREE apsq500_pb3
   #單身2總筆數顯示
   LET g_detail_cnt2 = g_psoz3_d.getLength()
   DISPLAY g_detail_cnt2 TO FORMONLY.cnt
   IF g_detail_cnt2 > 0 THEN
      LET g_detail_idx2 = 1
      DISPLAY g_detail_idx2 TO FORMONLY.idx
   ELSE
      LET g_detail_idx2 = 0
      DISPLAY ' ' TO FORMONLY.idx
   END IF
   
   
   #add--151124-00021#1 By shiun--(E)
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="apsq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apsq500_detail_show(ps_page)
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
 
{<section id="apsq500.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apsq500_filter()
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
      CONSTRUCT g_wc_filter ON psoz004,psoz012,psoz014,psoz018,psoz021,psoz022,psoz031,psoz029,psoz030, 
          psoz036,psoz037
                          FROM s_detail1[1].b_psoz004,s_detail1[1].b_psoz012,s_detail1[1].b_psoz014, 
                              s_detail1[1].b_psoz018,s_detail1[1].b_psoz021,s_detail1[1].b_psoz022,s_detail1[1].b_psoz031, 
                              s_detail1[1].b_psoz029,s_detail1[1].b_psoz030,s_detail1[1].b_psoz036,s_detail1[1].b_psoz037 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apsq500_filter_parser('psoz004') TO s_detail1[1].b_psoz004
            DISPLAY apsq500_filter_parser('psoz012') TO s_detail1[1].b_psoz012
            DISPLAY apsq500_filter_parser('psoz014') TO s_detail1[1].b_psoz014
            DISPLAY apsq500_filter_parser('psoz018') TO s_detail1[1].b_psoz018
            DISPLAY apsq500_filter_parser('psoz021') TO s_detail1[1].b_psoz021
            DISPLAY apsq500_filter_parser('psoz022') TO s_detail1[1].b_psoz022
            DISPLAY apsq500_filter_parser('psoz031') TO s_detail1[1].b_psoz031
            DISPLAY apsq500_filter_parser('psoz029') TO s_detail1[1].b_psoz029
            DISPLAY apsq500_filter_parser('psoz030') TO s_detail1[1].b_psoz030
            DISPLAY apsq500_filter_parser('psoz036') TO s_detail1[1].b_psoz036
            DISPLAY apsq500_filter_parser('psoz037') TO s_detail1[1].b_psoz037
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_psoz001>>----
         #----<<b_psoz002>>----
         #----<<b_psoz003>>----
         #----<<b_psoz038>>----
         #----<<b_psoz039>>----
         #----<<b_psoz004>>----
         #Ctrlp:construct.c.filter.page1.b_psoz004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz004
            #add-point:ON ACTION controlp INFIELD b_psoz004 name="construct.c.filter.page1.b_psoz004"
            
            #END add-point
 
 
         #----<<b_qty1>>----
         #----<<b_psoz012>>----
         #Ctrlp:construct.c.filter.page1.b_psoz012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz012
            #add-point:ON ACTION controlp INFIELD b_psoz012 name="construct.c.filter.page1.b_psoz012"
            
            #END add-point
 
 
         #----<<b_psoz014>>----
         #Ctrlp:construct.c.filter.page1.b_psoz014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz014
            #add-point:ON ACTION controlp INFIELD b_psoz014 name="construct.c.filter.page1.b_psoz014"
            
            #END add-point
 
 
         #----<<b_psoz018>>----
         #Ctrlp:construct.c.filter.page1.b_psoz018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz018
            #add-point:ON ACTION controlp INFIELD b_psoz018 name="construct.c.filter.page1.b_psoz018"
            
            #END add-point
 
 
         #----<<b_psoz021>>----
         #Ctrlp:construct.c.filter.page1.b_psoz021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz021
            #add-point:ON ACTION controlp INFIELD b_psoz021 name="construct.c.filter.page1.b_psoz021"
            
            #END add-point
 
 
         #----<<b_psoz022>>----
         #Ctrlp:construct.c.filter.page1.b_psoz022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz022
            #add-point:ON ACTION controlp INFIELD b_psoz022 name="construct.c.filter.page1.b_psoz022"
            
            #END add-point
 
 
         #----<<b_qty2>>----
         #----<<b_qty3>>----
         #----<<b_qty4>>----
         #----<<b_psoz031>>----
         #Ctrlp:construct.c.filter.page1.b_psoz031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz031
            #add-point:ON ACTION controlp INFIELD b_psoz031 name="construct.c.filter.page1.b_psoz031"
            
            #END add-point
 
 
         #----<<b_psoz029>>----
         #Ctrlp:construct.c.filter.page1.b_psoz029
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz029
            #add-point:ON ACTION controlp INFIELD b_psoz029 name="construct.c.filter.page1.b_psoz029"
            
            #END add-point
 
 
         #----<<b_psoz030>>----
         #Ctrlp:construct.c.filter.page1.b_psoz030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz030
            #add-point:ON ACTION controlp INFIELD b_psoz030 name="construct.c.filter.page1.b_psoz030"
            
            #END add-point
 
 
         #----<<b_psoz036>>----
         #Ctrlp:construct.c.filter.page1.b_psoz036
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz036
            #add-point:ON ACTION controlp INFIELD b_psoz036 name="construct.c.filter.page1.b_psoz036"
            
            #END add-point
 
 
         #----<<b_qty5>>----
         #----<<b_psoz037>>----
         #Ctrlp:construct.c.filter.page1.b_psoz037
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_psoz037
            #add-point:ON ACTION controlp INFIELD b_psoz037 name="construct.c.filter.page1.b_psoz037"
            
            #END add-point
 
 
         #----<<b_psoz005>>----
         #----<<b_psoz006>>----
         #----<<b_psoz007>>----
         #----<<b_psoz009>>----
         #----<<b_psoz010>>----
         #----<<b_psoz013>>----
         #----<<b_psoz015>>----
         #----<<b_psoz020>>----
         #----<<b_psoz026>>----
         #----<<b_psoz027>>----
         #----<<b_psoz028>>----
   
 
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
   
      CALL apsq500_filter_show('psoz004','b_psoz004')
   CALL apsq500_filter_show('psoz012','b_psoz012')
   CALL apsq500_filter_show('psoz014','b_psoz014')
   CALL apsq500_filter_show('psoz018','b_psoz018')
   CALL apsq500_filter_show('psoz021','b_psoz021')
   CALL apsq500_filter_show('psoz022','b_psoz022')
   CALL apsq500_filter_show('psoz031','b_psoz031')
   CALL apsq500_filter_show('psoz029','b_psoz029')
   CALL apsq500_filter_show('psoz030','b_psoz030')
   CALL apsq500_filter_show('psoz036','b_psoz036')
   CALL apsq500_filter_show('psoz037','b_psoz037')
 
    
   CALL apsq500_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apsq500_filter_parser(ps_field)
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
 
{<section id="apsq500.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apsq500_filter_show(ps_field,ps_object)
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
   LET ls_condition = apsq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.insert" >}
#+ insert
PRIVATE FUNCTION apsq500_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apsq500.modify" >}
#+ modify
PRIVATE FUNCTION apsq500_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.reproduce" >}
#+ reproduce
PRIVATE FUNCTION apsq500_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.delete" >}
#+ delete
PRIVATE FUNCTION apsq500_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apsq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apsq500_detail_action_trans()
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
 
{<section id="apsq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apsq500_detail_index_setting()
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
            IF g_psoz_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_psoz_d.getLength() AND g_psoz_d.getLength() > 0
            LET g_detail_idx = g_psoz_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_psoz_d.getLength() THEN
               LET g_detail_idx = g_psoz_d.getLength()
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
 
{<section id="apsq500.mask_functions" >}
 &include "erp/aps/apsq500_mask.4gl"
 
{</section>}
 
{<section id="apsq500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取切換頁資料
# Memo...........:
# Usage..........: CALL apsq500_fetch_page(p_flag)
#                  
# Input parameter: p_flag         action代號
#                : 
# Return code....:
#                : 
# Date & Author..: 14/07/04 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_fetch_page(p_flag)
DEFINE p_flag     LIKE type_t.chr1      #處理方式
DEFINE ls_msg     STRING
DEFINE l_wc       STRING
   
   CASE p_flag
      WHEN 'N' FETCH NEXT     apsq500_page_cs INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                                                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
      WHEN 'P' FETCH PREVIOUS apsq500_page_cs INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                                                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
      WHEN 'F' FETCH FIRST    apsq500_page_cs INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                                                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
      WHEN 'L' FETCH LAST     apsq500_page_cs INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                                                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
      WHEN '/'
         IF (NOT g_no_ask) THEN
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
            CALL cl_set_act_visible("accept,cancel", FALSE)    
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
            END IF
         END IF
         LET g_no_ask = FALSE
         FETCH ABSOLUTE g_jump apsq500_page_cs INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                                                    g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
   END CASE

   #2015/01/29 by stellar add ----- (S)
   LET g_wc3 = "psoz001='",g_psoz_m.psoz001,"' AND psoz002='",g_psoz_m.psoz002,"' ",
               " AND psoz038='",g_psoz_m.psoz038,"'  AND psoz039='",g_psoz_m.psoz039,"' "
   #2015/01/29 by stellar add ----- (E)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "psoz_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_psoz_m.* TO NULL
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_curs_index = 1
         WHEN 'P' LET g_curs_index = g_curs_index - 1
         WHEN 'N' LET g_curs_index = g_curs_index + 1
         WHEN 'L' LET g_curs_index = g_row_count
         WHEN '/' LET g_curs_index = g_jump
      END CASE
      CALL cl_navigator_setting(g_curs_index,g_row_count)
      
      
   END IF
   
   IF g_psoz_m.imaf013 IS NULL THEN
      SELECT UNIQUE psoz001,psoz002,psoz038,psoz039,imaf013
              INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
         FROM psoz_t 
         LEFT OUTER JOIN imaf_t ON psozent = imafent AND psozsite = imafsite AND psoz038 = imaf001
       WHERE psoz001 = g_psoz_m.psoz001
         AND psoz002 = g_psoz_m.psoz002
         AND psoz038 = g_psoz_m.psoz038
         AND psoz039 = g_psoz_m.psoz039
         AND imaf013 IS NULL
         AND psozent = g_enterprise
         AND psozsite = g_site  
   ELSE
      SELECT UNIQUE psoz001,psoz002,psoz038,psoz039,imaf013
              INTO g_psoz_m.psoz001,g_psoz_m.psoz002,
                   g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
         FROM psoz_t 
         LEFT OUTER JOIN imaf_t ON psozent = imafent AND psozsite = imafsite AND psoz038 = imaf001
       WHERE psoz001 = g_psoz_m.psoz001
         AND psoz002 = g_psoz_m.psoz002
         AND psoz038 = g_psoz_m.psoz038
         AND psoz039 = g_psoz_m.psoz039
         AND imaf013 = g_psoz_m.imaf013
         AND psozent = g_enterprise
         AND psozsite = g_site  
   END IF
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "psoz_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()

      INITIALIZE g_psoz_m.* TO NULL
      RETURN
   END IF
   #2015/01/29 by stellar mark ----- (S)
   #移至上面，避免查不到資料時，g_wc3還是錯的
#   LET g_wc3 = "psoz001='",g_psoz_m.psoz001,"' AND psoz002='",g_psoz_m.psoz002,"' ",
#               " AND psoz038='",g_psoz_m.psoz038,"'  AND psoz039='",g_psoz_m.psoz039,"' "
   #2015/01/29 by stellar mark ----- (E)
   DISPLAY BY NAME g_psoz_m.psoz001,g_psoz_m.psoz038,g_psoz_m.psoz039,g_psoz_m.imaf013
   
   #補給策略= 2 or 3，顯示規畫製造量 
   IF NOT cl_null(g_psoz_m.imaf013) THEN 
      #補給策略= 1 or 4，顯示規畫採購量   
      IF g_psoz_m.imaf013 = '1' OR g_psoz_m.imaf013 = '4' THEN
         #CALL cl_set_comp_att_text('b_qty5','規畫採購量')   #160414-00007#1 mark
         CALL cl_set_comp_att_text('b_qty5',cl_getmsg("aps-00184",g_dlang))   #160414-00007#1 
      END IF
      #補給策略= 2 or 3，顯示規畫製造量
      IF g_psoz_m.imaf013 = '2' OR g_psoz_m.imaf013 = '3' THEN
         #CALL cl_set_comp_att_text('b_qty5','規畫製造量')   #160414-00007#1 mark
         CALL cl_set_comp_att_text('b_qty5',cl_getmsg("aps-00185",g_dlang))   #160414-00007#1 
      END IF
   END IF
   
   #帶出APS版本說明
   CALL apsq500_psoz001_ref(g_psoz_m.psoz001)
   
   #帶出料號品名、規格
   CALL apsq500_psoz038_ref(g_psoz_m.psoz038)
  
   DISPLAY g_curs_index TO FORMONLY.page
   CALL apsq500_b_fill()
   
END FUNCTION

################################################################################
# Descriptions...: 抓取料件的品名、規格
# Memo...........:
# Usage..........: CALL apsq500_psoz038_ref()
#                  
# Input parameter: p_psoz038     料號
#                : 
# Return code....:
#                : 
# Date & Author..: 14/07/04 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_psoz038_ref(p_psoz038)
DEFINE p_psoz038     LIKE psoz_t.psoz038

   LET g_psoz_m.imaal003 = ''
   LET g_psoz_m.imaal004 = ''
   DISPLAY g_psoz_m.imaal003 TO imaal003
   DISPLAY g_psoz_m.imaal004 TO imaal004
   
   IF cl_null(p_psoz038) THEN
      RETURN
   END IF
   
   INITIALIZE g_ref_fields TO NULL 
   LET g_ref_fields[1] = p_psoz038
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_psoz_m.imaal003 = '', g_rtn_fields[1] , '' 
   LET g_psoz_m.imaal004 = '', g_rtn_fields[2] , '' 
   DISPLAY g_psoz_m.imaal003 TO imaal003
   DISPLAY g_psoz_m.imaal004 TO imaal004
END FUNCTION

################################################################################
# Descriptions...: 用show hint方式顯示細部數量
# Memo...........:
# Usage..........: CALL apsq500_qty1_show()
#                  
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 14/07/08 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_qty1_show()
DEFINE l_str     STRING
DEFINE l_msg     STRING
DEFINE l_msg1    STRING   #160923-00029#1-add
DEFINE l_str1    STRING
DEFINE l_str2    STRING
DEFINE l_str3    STRING
DEFINE l_str4    STRING
DEFINE l_str5    STRING
DEFINE l_str6    STRING
DEFINE l_str7    STRING
DEFINE l_str8    STRING
#160923-00029#1-s-add
DEFINE l_str9    STRING
DEFINE l_str10   STRING
DEFINE l_str11   STRING
DEFINE l_psoz      RECORD
        psoz019   LIKE psoz_t.psoz019,
        psoz024   LIKE psoz_t.psoz024,
        psoz025   LIKE psoz_t.psoz025,
        psoz032   LIKE psoz_t.psoz032,
        psoz033   LIKE psoz_t.psoz033,
        psoz034   LIKE psoz_t.psoz034,
        psoz035   LIKE psoz_t.psoz035,
        psoz041   LIKE psoz_t.psoz041,
        psoz044   LIKE psoz_t.psoz044,  
        qty1      LIKE psoz_t.psoz012,
        qty2      LIKE psoz_t.psoz012,
        qty3      LIKE psoz_t.psoz012,
        qty4      LIKE psoz_t.psoz012,
        qty5      LIKE psoz_t.psoz012
                 END RECORD
#160923-00029#1-e-add

   IF g_detail_idx = 0 THEN
      RETURN
   END IF
   
   #160923-00029#1-s-add 重新抓取資料
   INITIALIZE l_psoz.* TO NULL
   EXECUTE apsq500_b_fill_get_psoz_prep USING g_psoz_d[g_detail_idx].psoz001,g_psoz_d[g_detail_idx].psoz002,
                                              g_psoz_d[g_detail_idx].psoz003,g_psoz_d[g_detail_idx].psoz004,
                                              g_psoz_d[g_detail_idx].psoz038,g_psoz_d[g_detail_idx].psoz039
                                         INTO l_psoz.psoz019,l_psoz.psoz024,l_psoz.psoz025,
                                              l_psoz.psoz032,l_psoz.psoz033,l_psoz.psoz034,
                                              l_psoz.psoz035,l_psoz.psoz041,l_psoz.psoz044
   #160923-00029#1-e-add
   
   #指到受訂量欄位(qty1)的值上時，用show hint方式顯示細部的3個數字
   LET l_str1 = g_psoz_d[g_detail_idx].psoz005
   LET l_str2 = g_psoz_d[g_detail_idx].psoz006
   LET l_str3 = g_psoz_d[g_detail_idx].psoz007

   LET l_str = l_str1.trim() ,'|', l_str2.trim() ,'|', l_str3.trim()
 
   LET l_msg = cl_getmsg_parm('aps-00107',g_lang,l_str)
   LET l_msg = cl_replace_str(l_msg,"*","\n")
   CALL s_hint_show_set_comments('b_qty1',l_msg)
   
   #指到替代量欄位(qty4)的值上時，用show hint方式顯示細部的個各數量
   LET l_str1 = g_psoz_d[g_detail_idx].psoz009
   LET l_str2 = g_psoz_d[g_detail_idx].psoz010
   LET l_str3 = g_psoz_d[g_detail_idx].psoz013
   LET l_str4 = g_psoz_d[g_detail_idx].psoz015
   LET l_str5 = g_psoz_d[g_detail_idx].psoz020
   LET l_str6 = g_psoz_d[g_detail_idx].psoz026
   LET l_str7 = g_psoz_d[g_detail_idx].psoz027
   LET l_str8 = g_psoz_d[g_detail_idx].psoz028
   #160923-00029#1-s-add
   LET l_str9 = l_psoz.psoz033
   LET l_str10 = l_psoz.psoz035
   LET l_str11 = l_psoz.psoz044
   #160923-00029#1-e-add
   
   
   LET l_str = l_str1.trim() ,'|', l_str2.trim() ,'|', l_str3.trim() ,'|', 
               l_str4.trim() ,'|', l_str5.trim() ,'|', l_str6.trim() ,'|',
               l_str7.trim() ,'|', l_str8.trim()
   LET l_msg = cl_getmsg_parm('aps-00108',g_lang,l_str)
   LET l_msg = cl_replace_str(l_msg,"*","\n")
   #160923-00029#1-s-add
   LET l_str = l_str9.trim() ,'|', l_str10.trim() ,'|', l_str11.trim()
   LET l_msg1 = cl_getmsg_parm('aps-00202',g_lang,l_str)
   LET l_msg1 = cl_replace_str(l_msg1,"*","\n")
   LET l_msg = l_msg||"\n"||l_msg1
   #160923-00029#1-e-add
   
   CALL s_hint_show_set_comments('b_qty4',l_msg)
      
END FUNCTION

################################################################################
# Descriptions...: 欄位關閉控制
# Memo...........:
# Usage..........: CALL apsq500_set_no_entry()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/08 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_set_no_entry()
   #將formonly欄位關閉
    CALL cl_set_comp_entry("qty1,qty2,qty3,qty4,qty5,qty6",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 單身筆數變更
# Memo...........:
# Usage..........: CALL apsq500_idx_chk()
#                  
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/07/08 By emma
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_idx_chk()

   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_detail_cnt THEN
         LET g_detail_idx = g_detail_cnt
      END IF
      IF g_detail_idx = 0 AND g_detail_cnt <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.h_index
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 抓取APS版本的說明
# Memo...........:
# Usage..........: CALL apsq500_psoz001_ref(p_psoz001)
#                  
# Input parameter: p_psoz001      APS版本
#                : 
# Return code....: 
#                : 
# Date & Author..: 14/09/23 By stellar
# Modify.........:
################################################################################
PRIVATE FUNCTION apsq500_psoz001_ref(p_psoz001)
DEFINE p_psoz001         LIKE psoz_t.psoz001

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_psoz001
   CALL ap_ref_array2(g_ref_fields,"SELECT pscal003 FROM pscal_t WHERE pscalent='"||g_enterprise||"' AND pscalsite='"||g_site||"' AND pscal001=? AND pscal002='"||g_dlang||"'",
       "") RETURNING g_rtn_fields
   LET g_psoz_m.psoz001_desc= '', g_rtn_fields[1] , ''
   DISPLAY g_psoz_m.psoz001_desc TO psoz001_desc
   
END FUNCTION

 
{</section>}
 
