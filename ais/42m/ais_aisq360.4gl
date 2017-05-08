#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq360.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-11-01 16:22:39), PR版次:0008(2017-01-06 09:20:21)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000076
#+ Filename...: aisq360
#+ Description: 對帳單發票開立明細查詢
#+ Creator....: 03080(2015-01-22 17:47:39)
#+ Modifier...: 08732 -SD/PR- 03080
 
{</section>}
 
{<section id="aisq360.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150127-00007#1  2015/02/26 By Reanna     掃把清空之後不能在下QBE的問題
#151231-00010#3  2016/01/21 By albireo    增加控制組判斷
#160920-00019#5  2016/09/20 By 08732      交易對象開窗調整為q_pmaa001_13
#161006-00005#27 2016/10/24 By Reanna     帳務中心(isafsite)開窗改用q_ooef001_46()
#161013-00020#1  2016/11/01 By 08732      1.增加貨物或應稅勞務編碼(isah003)欄位放置於 isah004 之前  2.增加列印 XG 功能
#161025-00020#1  2016/11/03 By 08171      需加入“正负值”已有字段：isah010,图5,否则报表异常
#161214-00007#1  161214     By albireo    修正 b_fill sql調整後未同步調整count的sql造成總筆數問題
#170105-00040#1  170106     By albireo    declare修正

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
PRIVATE TYPE type_g_isah_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isahcomp LIKE isah_t.isahcomp, 
   isahorga LIKE isah_t.isahorga, 
   isaf003 LIKE type_t.chr100, 
   isaf100 LIKE isaf_t.isaf100, 
   isahdocno LIKE isah_t.isahdocno, 
   isahseq LIKE isah_t.isahseq, 
   isah011 LIKE isah_t.isah011, 
   isaf022 LIKE isaf_t.isaf022, 
   isah003 LIKE isah_t.isah003, 
   isah004 LIKE isah_t.isah004, 
   isah013 LIKE isah_t.isah013, 
   isah005 LIKE isah_t.isah005, 
   isah010 LIKE isah_t.isah010, 
   isah006 LIKE isah_t.isah006, 
   isah101 LIKE isah_t.isah101, 
   isah103 LIKE isah_t.isah103, 
   isah105 LIKE isah_t.isah105, 
   l_isah1032 LIKE type_t.num20_6, 
   isah106 LIKE isah_t.isah106, 
   isah012 LIKE isah_t.isah012, 
   isba001 LIKE type_t.chr500, 
   isat004 LIKE type_t.chr500, 
   isaf017 LIKE isaf_t.isaf017 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_input      RECORD   
                   isafsite    LIKE isaf_t.isafsite,
                   isafsite_desc LIKE type_t.chr100,
                   strdat      LIKE type_t.dat,
                   enddat      LIKE type_t.dat,
                   type        LIKE type_t.chr1
                   END RECORD
DEFINE g_wc_site   STRING
DEFINE g_wc_ld     STRING
DEFINE g_wc_comp   STRING
DEFINE g_input          type_g_input
DEFINE g_input_o        type_g_input
#151231-00010#3-----s
DEFINE g_ctl_where          STRING    #交易對象控制組WHERE CON
#151231-00010#3-----e
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isah_d
DEFINE g_master_t                   type_g_isah_d
DEFINE g_isah_d          DYNAMIC ARRAY OF type_g_isah_d
DEFINE g_isah_d_t        type_g_isah_d
 
      
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
 
{<section id="aisq360.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_comp LIKE ooef_t.ooef001   #151231-00010#3
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
   DECLARE aisq360_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq360_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq360_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq360 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq360_init()   
 
      #進入選單 Menu (="N")
      CALL aisq360_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq360
      
   END IF 
   
   CLOSE aisq360_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq360.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq360_init()
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
   CALL cl_set_combo_scc('type','9964')
   CALL s_fin_create_account_center_tmp()    #組織範圍
   #end add-point
 
   CALL aisq360_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq360.default_search" >}
PRIVATE FUNCTION aisq360_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isahcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isahdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " isahseq = '", g_argv[03], "' AND "
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
 
{<section id="aisq360.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq360_ui_dialog()
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
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
   ELSE
      CALL aisq360_qbe_clear()
   END IF
   
   CALL aisq360_create_tmp()   #161013-00020#1   add
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aisq360_b_fill()
   ELSE
      CALL aisq360_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isah_d.clear()
 
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
 
         CALL aisq360_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isah_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq360_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq360_detail_action_trans()
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
            CALL aisq360_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible('insert',FALSE)
            #CALL cl_set_act_visible('output',FALSE)   #161013-00020#1   mark
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_aisq360_01
            LET g_action_choice="open_aisq360_01"
            IF cl_auth_chk_act("open_aisq360_01") THEN
               
               #add-point:ON ACTION open_aisq360_01 name="menu.open_aisq360_01"
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               IF cl_null(l_ac) OR l_ac <= 0 THEN
                  LET l_ac = 1
               END IF
               
               IF cl_null(g_isah_d[l_ac].isahcomp) OR cl_null(g_isah_d[l_ac].isahdocno)THEN
               #提示錯誤
               ELSE
                  CALL aisq360_01(g_isah_d[l_ac].isahcomp,g_isah_d[l_ac].isahdocno)
                  LET g_action_choice = 'open_aisq360_01'
               END IF
               
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aisq360_insert()
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #161013-00020#1   add---s
               CALL aisq360_ins_x01_tmp()
               CALL aisq360_x01('1=1','aisq360_x01_tmp')
               #161013-00020#1   add---e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #161013-00020#1   add---s
               CALL aisq360_ins_x01_tmp()
               CALL aisq360_x01('1=1','aisq360_x01_tmp')
               #161013-00020#1   add---e
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq360_query()
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
            CALL aisq360_filter()
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
            CALL aisq360_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isah_d)
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
            CALL aisq360_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq360_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq360_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq360_b_fill()
 
         
         
 
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
 
{<section id="aisq360.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq360_query()
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
   CALL g_isah_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isahcomp,isahorga,isaf100,isahdocno,isahseq,isah011,isaf022,isah003,isah004, 
          isah013,isah005,isah010,isah006,isah101,isah103,isah105,isah106,isah012,isaf017
           FROM s_detail1[1].b_isahcomp,s_detail1[1].b_isahorga,s_detail1[1].b_isaf100,s_detail1[1].b_isahdocno, 
               s_detail1[1].b_isahseq,s_detail1[1].b_isah011,s_detail1[1].b_isaf022,s_detail1[1].b_isah003, 
               s_detail1[1].b_isah004,s_detail1[1].b_isah013,s_detail1[1].b_isah005,s_detail1[1].b_isah010, 
               s_detail1[1].b_isah006,s_detail1[1].b_isah101,s_detail1[1].b_isah103,s_detail1[1].b_isah105, 
               s_detail1[1].b_isah106,s_detail1[1].b_isah012,s_detail1[1].b_isaf017
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_isahcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isahcomp
            #add-point:BEFORE FIELD b_isahcomp name="construct.b.page1.b_isahcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isahcomp
            
            #add-point:AFTER FIELD b_isahcomp name="construct.a.page1.b_isahcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isahcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahcomp
            #add-point:ON ACTION controlp INFIELD b_isahcomp name="construct.c.page1.b_isahcomp"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef001 IN ",g_wc_comp," "
            CALL q_ooef001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isahcomp  #顯示到畫面上
            NEXT FIELD b_isahcomp 
            #END add-point
 
 
         #----<<b_isahorga>>----
         #Ctrlp:construct.c.page1.b_isahorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahorga
            #add-point:ON ACTION controlp INFIELD b_isahorga name="construct.c.page1.b_isahorga"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isahorga  #顯示到畫面上
            NEXT FIELD b_isahorga                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isahorga
            #add-point:BEFORE FIELD b_isahorga name="construct.b.page1.b_isahorga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isahorga
            
            #add-point:AFTER FIELD b_isahorga name="construct.a.page1.b_isahorga"
            
            #END add-point
            
 
 
         #----<<b_isaf003>>----
         #----<<b_isaf100>>----
         #Ctrlp:construct.c.page1.b_isaf100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf100
            #add-point:ON ACTION controlp INFIELD b_isaf100 name="construct.c.page1.b_isaf100"
            #Reanna 15/02/11 mod----------------------------
            #開窗c段-幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()
            DISPLAY g_qryparam.return1 TO b_isaf100
            NEXT FIELD b_isaf100
            #Reanna 15/02/11 mod end------------------------
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf100
            #add-point:BEFORE FIELD b_isaf100 name="construct.b.page1.b_isaf100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf100
            
            #add-point:AFTER FIELD b_isaf100 name="construct.a.page1.b_isaf100"
            
            #END add-point
            
 
 
         #----<<b_isahdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isahdocno
            #add-point:BEFORE FIELD b_isahdocno name="construct.b.page1.b_isahdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isahdocno
            
            #add-point:AFTER FIELD b_isahdocno name="construct.a.page1.b_isahdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isahdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahdocno
            #add-point:ON ACTION controlp INFIELD b_isahdocno name="construct.c.page1.b_isahdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isafsite IN ",g_wc_site," AND isafdocdt BETWEEN '",g_input.strdat,"' AND '",g_input.enddat,"' "
            #151231-00010#3-----s
            LET l_comp = NULL
            SELECT ooef017 INTO l_comp FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
                                                    
            LET g_qryparam.where = g_qryparam.where CLIPPED," AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                                    " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                                    "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                                    "   AND pmabsite = '",l_comp,"' ",
                                                    "   AND pmaaent = isafent AND pmaa001 = isaf003)"
            #151231-00010#3-----e
            CALL q_isafdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isahdocno
            NEXT FIELD b_isahdocno
            #END add-point
 
 
         #----<<b_isahseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isahseq
            #add-point:BEFORE FIELD b_isahseq name="construct.b.page1.b_isahseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isahseq
            
            #add-point:AFTER FIELD b_isahseq name="construct.a.page1.b_isahseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahseq
            #add-point:ON ACTION controlp INFIELD b_isahseq name="construct.c.page1.b_isahseq"
            
            #END add-point
 
 
         #----<<b_isah011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah011
            #add-point:BEFORE FIELD b_isah011 name="construct.b.page1.b_isah011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah011
            
            #add-point:AFTER FIELD b_isah011 name="construct.a.page1.b_isah011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah011
            #add-point:ON ACTION controlp INFIELD b_isah011 name="construct.c.page1.b_isah011"
            
            #END add-point
 
 
         #----<<b_isaf022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf022
            #add-point:BEFORE FIELD b_isaf022 name="construct.b.page1.b_isaf022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf022
            
            #add-point:AFTER FIELD b_isaf022 name="construct.a.page1.b_isaf022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf022
            #add-point:ON ACTION controlp INFIELD b_isaf022 name="construct.c.page1.b_isaf022"
            
            #END add-point
 
 
         #----<<b_isah003>>----
         #Ctrlp:construct.c.page1.b_isah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah003
            #add-point:ON ACTION controlp INFIELD b_isah003 name="construct.c.page1.b_isah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isah003  #顯示到畫面上
            NEXT FIELD b_isah003                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah003
            #add-point:BEFORE FIELD b_isah003 name="construct.b.page1.b_isah003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah003
            
            #add-point:AFTER FIELD b_isah003 name="construct.a.page1.b_isah003"
            
            #END add-point
            
 
 
         #----<<b_isah004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah004
            #add-point:BEFORE FIELD b_isah004 name="construct.b.page1.b_isah004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah004
            
            #add-point:AFTER FIELD b_isah004 name="construct.a.page1.b_isah004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah004
            #add-point:ON ACTION controlp INFIELD b_isah004 name="construct.c.page1.b_isah004"
            
            #END add-point
 
 
         #----<<b_isah013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah013
            #add-point:BEFORE FIELD b_isah013 name="construct.b.page1.b_isah013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah013
            
            #add-point:AFTER FIELD b_isah013 name="construct.a.page1.b_isah013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah013
            #add-point:ON ACTION controlp INFIELD b_isah013 name="construct.c.page1.b_isah013"
            
            #END add-point
 
 
         #----<<b_isah005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah005
            #add-point:BEFORE FIELD b_isah005 name="construct.b.page1.b_isah005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah005
            
            #add-point:AFTER FIELD b_isah005 name="construct.a.page1.b_isah005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah005
            #add-point:ON ACTION controlp INFIELD b_isah005 name="construct.c.page1.b_isah005"
            
            #END add-point
 
 
         #----<<b_isah010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah010
            #add-point:BEFORE FIELD b_isah010 name="construct.b.page1.b_isah010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah010
            
            #add-point:AFTER FIELD b_isah010 name="construct.a.page1.b_isah010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah010
            #add-point:ON ACTION controlp INFIELD b_isah010 name="construct.c.page1.b_isah010"
            
            #END add-point
 
 
         #----<<b_isah006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah006
            #add-point:BEFORE FIELD b_isah006 name="construct.b.page1.b_isah006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah006
            
            #add-point:AFTER FIELD b_isah006 name="construct.a.page1.b_isah006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah006
            #add-point:ON ACTION controlp INFIELD b_isah006 name="construct.c.page1.b_isah006"
            
            #END add-point
 
 
         #----<<b_isah101>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah101
            #add-point:BEFORE FIELD b_isah101 name="construct.b.page1.b_isah101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah101
            
            #add-point:AFTER FIELD b_isah101 name="construct.a.page1.b_isah101"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah101
            #add-point:ON ACTION controlp INFIELD b_isah101 name="construct.c.page1.b_isah101"
            
            #END add-point
 
 
         #----<<b_isah103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah103
            #add-point:BEFORE FIELD b_isah103 name="construct.b.page1.b_isah103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah103
            
            #add-point:AFTER FIELD b_isah103 name="construct.a.page1.b_isah103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah103
            #add-point:ON ACTION controlp INFIELD b_isah103 name="construct.c.page1.b_isah103"
            
            #END add-point
 
 
         #----<<b_isah105>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah105
            #add-point:BEFORE FIELD b_isah105 name="construct.b.page1.b_isah105"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah105
            
            #add-point:AFTER FIELD b_isah105 name="construct.a.page1.b_isah105"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah105
            #add-point:ON ACTION controlp INFIELD b_isah105 name="construct.c.page1.b_isah105"
            
            #END add-point
 
 
         #----<<l_isah1032>>----
         #----<<b_isah106>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah106
            #add-point:BEFORE FIELD b_isah106 name="construct.b.page1.b_isah106"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah106
            
            #add-point:AFTER FIELD b_isah106 name="construct.a.page1.b_isah106"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah106
            #add-point:ON ACTION controlp INFIELD b_isah106 name="construct.c.page1.b_isah106"
            
            #END add-point
 
 
         #----<<b_isah012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isah012
            #add-point:BEFORE FIELD b_isah012 name="construct.b.page1.b_isah012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isah012
            
            #add-point:AFTER FIELD b_isah012 name="construct.a.page1.b_isah012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah012
            #add-point:ON ACTION controlp INFIELD b_isah012 name="construct.c.page1.b_isah012"
            
            #END add-point
 
 
         #----<<b_isba001>>----
         #----<<b_isat004>>----
         #----<<b_isaf017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isaf017
            #add-point:BEFORE FIELD b_isaf017 name="construct.b.page1.b_isaf017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isaf017
            
            #add-point:AFTER FIELD b_isaf017 name="construct.a.page1.b_isaf017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf017
            #add-point:ON ACTION controlp INFIELD b_isaf017 name="construct.c.page1.b_isaf017"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.isafsite,g_input.strdat,g_input.enddat,g_input.type
            ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
            
            AFTER FIELD isafsite
               IF NOT cl_null(g_input.isafsite) THEN
                  IF (g_input.isafsite != g_input_o.isafsite OR g_input_o.isafsite IS NULL) THEN
                     CALL s_fin_account_center_with_ld_chk(g_input.isafsite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
                     IF NOT g_sub_success THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = g_errno
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_input.isafsite = ''
                        LET g_input.isafsite_desc = ''
                        LET g_wc_site = ''
                        LET g_wc_ld   = ''
                        LET g_wc_comp = ''
                        LET g_input_o.isafsite = g_input.isafsite
                        LET g_input_o.isafsite_desc = g_input.isafsite_desc
                        DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc
                        NEXT FIELD CURRENT
                     END IF
                     CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
                     #取得帳務中心底下之組織範圍
                     CALL s_fin_account_center_sons_str() RETURNING g_wc_site
                     CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
                     #取得帳務中心底下的帳套範圍
                     CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
                     CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
                     #取得帳務中心底下的法人範圍
                     CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
                     CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
                     LET g_input.isafsite_desc= s_desc_get_department_desc(g_input.isafsite)
                     DISPLAY BY NAME g_input.isafsite_desc
                  END IF
               ELSE
                  LET g_input.isafsite_desc = ''
                  LET g_wc_site = ''
                  LET g_wc_ld   = ''
                  LET g_wc_comp = ''
                  DISPLAY BY NAME g_input.isafsite_desc
               END IF
               CALL s_desc_get_department_desc(g_input.isafsite)RETURNING g_input.isafsite_desc
               LET g_input_o.isafsite = g_input.isafsite
            
            
            AFTER FIELD enddat
               #僅提示  實際查詢再卡住
               IF NOT cl_null(g_input.strdat) AND NOT cl_null(g_input.enddat)THEN
                  IF g_input.strdat > g_input.enddat THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ''
                     LET g_errparam.code   = 'acr-00068'
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  END IF
               END IF
            
            
            ON ACTION controlp INFIELD isafsite
               #帳務中心
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.isafsite
               #CALL q_ooef001()      #161006-00005#26 mark
               CALL q_ooef001_46()    #161006-00005#26
               LET g_input.isafsite = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.isafsite) RETURNING g_input.isafsite_desc
               DISPLAY BY NAME g_input.isafsite,g_input.isafsite_desc
               NEXT FIELD isafsite

         END INPUT
      
      BEFORE DIALOG
         CALL s_desc_get_department_desc(g_input.isafsite)RETURNING g_input.isafsite_desc
         DISPLAY BY NAME g_input.isafsite_desc
         LET l_ac = 1
         LET g_isah_d[l_ac].isahcomp = ' ' 
         DISPLAY ARRAY g_isah_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         
         CALL aisq360_qbe_clear() #150127-00007#1
         
      AFTER DIALOG
         IF g_input.strdat > g_input.enddat THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = ''
            LET g_errparam.code   = 'acr-00068'
            LET g_errparam.popup  = TRUE 
            CALL cl_err()      
            NEXT FIELD CURRENT
         END IF
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
         CALL aisq360_qbe_clear()
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

   LET g_wc = g_wc CLIPPED," AND EXISTS     (SELECT 1 FROM pmaa_t,pmab_t ",
                                            " WHERE pmab001 = pmaa001 AND pmabent = pmaaent ",
                                            "   AND pmaaent = ",g_enterprise," AND ",g_ctl_where,
                                            "   AND pmabsite = '",l_comp,"' ",
                                            "   AND pmaaent = isafent AND pmaa001 = isaf003)"
   #151231-00010#3-----e
   #end add-point
        
   LET g_error_show = 1
   CALL aisq360_b_fill()
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
 
{<section id="aisq360.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq360_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_isah_d.clear()
   IF g_wc = ' 1=2' THEN
      LET g_wc = ' 1=1'
      RETURN
   END IF
   
   LET g_wc = " 1=1 "  #161025-00020#1 add

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
 
   LET ls_sql_rank = "SELECT  UNIQUE isahcomp,isahorga,'','',isahdocno,isahseq,isah011,'',isah003,isah004, 
       isah013,isah005,isah010,isah006,isah101,isah103,isah105,'',isah106,isah012,'','',''  ,DENSE_RANK() OVER( ORDER BY isah_t.isahcomp, 
       isah_t.isahdocno,isah_t.isahseq) AS RANK FROM isah_t",
 
 
                     "",
                     " WHERE isahent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isah_t"),
                     " ORDER BY isah_t.isahcomp,isah_t.isahdocno,isah_t.isahseq"
 
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
 
   LET g_sql = "SELECT isahcomp,isahorga,'','',isahdocno,isahseq,isah011,'',isah003,isah004,isah013, 
       isah005,isah010,isah006,isah101,isah103,isah105,'',isah106,isah012,'','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#   IF cl_null(g_wc_filter2)THEN
#      LET g_wc_filter2 = " 1=1"
#   END IF
#   LET ls_wc = ls_wc CLIPPED," AND ",g_wc_filter2
   #組織範圍區間
   LET ls_wc = ls_wc CLIPPED," AND isafsite IN ",g_wc_site," ",
                             " AND isafcomp IN ",g_wc_comp," AND isafstus = 'Y' "
   #日期區間
   LET ls_wc = ls_wc CLIPPED," AND isafdocdt BETWEEN '",g_input.strdat,"' AND '",g_input.enddat,"' "
   
   #想看到的資料範圍
   CASE
      WHEN g_input.type = '0'
         #未開發票
         LET ls_wc = ls_wc CLIPPED," AND NOT EXISTS(SELECT 1 FROM isat_t WHERE isatent = isafent ",
                                   "                   AND isatdocno = isafdocno ",
                                   "                   AND isatcomp  = isafcomp) "
      WHEN g_input.type = '1'
         #已開發票
         LET ls_wc = ls_wc CLIPPED," AND EXISTS(SELECT 1 FROM isat_t WHERE isatent = isafent ",
                                   "               AND isatdocno = isafdocno ",
                                   "               AND isatcomp  = isafcomp) "   
      WHEN g_input.type = '2'
              
   END CASE
   
   #161013-00020#1   mark---s
   #LET g_sql = "SELECT isahcomp,isaf003,isaf100,isahdocno,",
   #            "       isahseq,isah011,isaf022,isah003,isah004,",
   #            "       isah013,isah005,isah006,isah101,isah103,",
   #            "       isah105,isah010,0,isah106,isah012,",
   #            "       '','',isaf017 ",
   #            "  FROM isah_t,isaf_t ",
   #            " WHERE isahent = isafent ",
   #            "   AND isahdocno = isafdocno ",
   #            "   AND isahcomp  = isafcomp ",
   #            "   AND isafent = ? ",
   #            "   AND ",ls_wc CLIPPED 
   #161013-00020#1   mark---e
   
   #161013-00020#1   add---s
   LET g_sql = "SELECT isahcomp,'',isaf003,isaf100,isahdocno,",
               "       isahseq,isah011,isaf022,isah003,isah004,",
              #"       isah013,isah005,isah006,isah101,isah103,",         #161025-00020#1 mark
              #"       isah105,isah010,0,isah106,isah012,",               #161025-00020#1 mark
               "       isah013,isah005,isah010,isah006,isah101,isah103,", #161025-00020#1 add
               "       isah105,0,isah106,isah012,",                       #161025-00020#1 add
               "       '','',isaf017 ",
               "  FROM isah_t,isaf_t ",
               " WHERE isahent = isafent ",
               "   AND isahdocno = isafdocno ",
               "   AND isahcomp  = isafcomp ",
               "   AND isafent = ? ",
               "   AND ",ls_wc CLIPPED 
   #161013-00020#1   add---e

   LET g_sql = g_sql, cl_sql_add_filter("isah_t"),cl_sql_add_filter("isaf_t")    #table權限
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq360_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq360_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isah_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL aisq360_prepare_declare()   #170105-00040#1
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isah_d[l_ac].isahcomp,g_isah_d[l_ac].isahorga,g_isah_d[l_ac].isaf003,g_isah_d[l_ac].isaf100, 
       g_isah_d[l_ac].isahdocno,g_isah_d[l_ac].isahseq,g_isah_d[l_ac].isah011,g_isah_d[l_ac].isaf022, 
       g_isah_d[l_ac].isah003,g_isah_d[l_ac].isah004,g_isah_d[l_ac].isah013,g_isah_d[l_ac].isah005,g_isah_d[l_ac].isah010, 
       g_isah_d[l_ac].isah006,g_isah_d[l_ac].isah101,g_isah_d[l_ac].isah103,g_isah_d[l_ac].isah105,g_isah_d[l_ac].l_isah1032, 
       g_isah_d[l_ac].isah106,g_isah_d[l_ac].isah012,g_isah_d[l_ac].isba001,g_isah_d[l_ac].isat004,g_isah_d[l_ac].isaf017 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isah_d[l_ac].statepic = cl_get_actipic(g_isah_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aisq360_detail_show("'1'")      
 
      CALL aisq360_isah_t_mask()
 
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
   
 
   
   CALL g_isah_d.deleteElement(g_isah_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_tot_cnt = l_ac - 1    #161214-00007#1 add
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isah_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq360_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq360_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq360_detail_action_trans()
 
   IF g_isah_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq360_fetch()
   END IF
   
      CALL aisq360_filter_show('isahcomp','b_isahcomp')
   CALL aisq360_filter_show('isahorga','b_isahorga')
   CALL aisq360_filter_show('isaf100','b_isaf100')
   CALL aisq360_filter_show('isahdocno','b_isahdocno')
   CALL aisq360_filter_show('isahseq','b_isahseq')
   CALL aisq360_filter_show('isah011','b_isah011')
   CALL aisq360_filter_show('isaf022','b_isaf022')
   CALL aisq360_filter_show('isah003','b_isah003')
   CALL aisq360_filter_show('isah004','b_isah004')
   CALL aisq360_filter_show('isah013','b_isah013')
   CALL aisq360_filter_show('isah005','b_isah005')
   CALL aisq360_filter_show('isah010','b_isah010')
   CALL aisq360_filter_show('isah006','b_isah006')
   CALL aisq360_filter_show('isah101','b_isah101')
   CALL aisq360_filter_show('isah103','b_isah103')
   CALL aisq360_filter_show('isah105','b_isah105')
   CALL aisq360_filter_show('isah106','b_isah106')
   CALL aisq360_filter_show('isah012','b_isah012')
   CALL aisq360_filter_show('isaf017','b_isaf017')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   DISPLAY l_ac TO FORMONLY.h_index
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq360_fetch()
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
 
{<section id="aisq360.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq360_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_desc     LIKE type_t.chr100
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
#處理說明及數字運算
      #
      #客戶:客戶編號客戶名稱
      #isaf003
      LET g_isah_d[l_ac].isaf003 = g_isah_d[l_ac].isaf003,s_desc_get_trading_partner_abbr_desc(g_isah_d[l_ac].isaf003)
      #單位直接帶說明
      #isah005
      LET g_isah_d[l_ac].isah005 = s_desc_get_unit_desc(g_isah_d[l_ac].isah005)
      #處理要合計的金額欄位
      #
      IF cl_null(g_isah_d[l_ac].isah103)THEN LET g_isah_d[l_ac].isah103 = 0 END IF
      IF cl_null(g_isah_d[l_ac].isah105)THEN LET g_isah_d[l_ac].isah105 = 0 END IF
      IF cl_null(g_isah_d[l_ac].isah010)THEN LET g_isah_d[l_ac].isah010 = 0 END IF
      
      IF g_isah_d[l_ac].isaf017 = 'Y' THEN
         LET g_isah_d[l_ac].l_isah1032 = g_isah_d[l_ac].isah105 * g_isah_d[l_ac].isah010
      ELSE
         LET g_isah_d[l_ac].l_isah1032 = g_isah_d[l_ac].isah103 * g_isah_d[l_ac].isah010
      END IF
      
      #收款人
      LET g_isah_d[l_ac].isba001 = NULL
      SELECT isba001 
        INTO g_isah_d[l_ac].isba001
        FROM isba_t,isbc_t 
       WHERE isbadocno = isbcdocno 
         AND isbaent   = isbcent
         AND isbadocdt BETWEEN g_input.strdat AND g_input.enddat 
         AND isbc004 = g_isah_d[l_ac].isahdocno  
         AND isbastus ='Y'  #可能未收款取不到資料時空白
         
      IF NOT cl_null(g_isah_d[l_ac].isba001)THEN
         LET l_desc = s_desc_get_person_desc(g_isah_d[l_ac].isba001)
         IF NOT cl_null(l_desc)THEN
            LET g_isah_d[l_ac].isba001 = l_desc
         END IF
      END IF
      
      #發票號碼
      LET g_isah_d[l_ac].isat004 = aisq360_get_isat004_str(g_isah_d[l_ac].isahcomp,g_isah_d[l_ac].isahdocno)
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq360_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_comp       LIKE ooef_t.ooef001
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
      CONSTRUCT g_wc_filter ON isahcomp,isahorga,isaf100,isahdocno,isahseq,isah011,isaf022,isah003,isah004, 
          isah013,isah005,isah010,isah006,isah101,isah103,isah105,isah106,isah012,isaf017
                          FROM s_detail1[1].b_isahcomp,s_detail1[1].b_isahorga,s_detail1[1].b_isaf100, 
                              s_detail1[1].b_isahdocno,s_detail1[1].b_isahseq,s_detail1[1].b_isah011, 
                              s_detail1[1].b_isaf022,s_detail1[1].b_isah003,s_detail1[1].b_isah004,s_detail1[1].b_isah013, 
                              s_detail1[1].b_isah005,s_detail1[1].b_isah010,s_detail1[1].b_isah006,s_detail1[1].b_isah101, 
                              s_detail1[1].b_isah103,s_detail1[1].b_isah105,s_detail1[1].b_isah106,s_detail1[1].b_isah012, 
                              s_detail1[1].b_isaf017
 
         BEFORE CONSTRUCT
                     DISPLAY aisq360_filter_parser('isahcomp') TO s_detail1[1].b_isahcomp
            DISPLAY aisq360_filter_parser('isahorga') TO s_detail1[1].b_isahorga
            DISPLAY aisq360_filter_parser('isaf100') TO s_detail1[1].b_isaf100
            DISPLAY aisq360_filter_parser('isahdocno') TO s_detail1[1].b_isahdocno
            DISPLAY aisq360_filter_parser('isahseq') TO s_detail1[1].b_isahseq
            DISPLAY aisq360_filter_parser('isah011') TO s_detail1[1].b_isah011
            DISPLAY aisq360_filter_parser('isaf022') TO s_detail1[1].b_isaf022
            DISPLAY aisq360_filter_parser('isah003') TO s_detail1[1].b_isah003
            DISPLAY aisq360_filter_parser('isah004') TO s_detail1[1].b_isah004
            DISPLAY aisq360_filter_parser('isah013') TO s_detail1[1].b_isah013
            DISPLAY aisq360_filter_parser('isah005') TO s_detail1[1].b_isah005
            DISPLAY aisq360_filter_parser('isah010') TO s_detail1[1].b_isah010
            DISPLAY aisq360_filter_parser('isah006') TO s_detail1[1].b_isah006
            DISPLAY aisq360_filter_parser('isah101') TO s_detail1[1].b_isah101
            DISPLAY aisq360_filter_parser('isah103') TO s_detail1[1].b_isah103
            DISPLAY aisq360_filter_parser('isah105') TO s_detail1[1].b_isah105
            DISPLAY aisq360_filter_parser('isah106') TO s_detail1[1].b_isah106
            DISPLAY aisq360_filter_parser('isah012') TO s_detail1[1].b_isah012
            DISPLAY aisq360_filter_parser('isaf017') TO s_detail1[1].b_isaf017
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isahcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isahcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahcomp
            #add-point:ON ACTION controlp INFIELD b_isahcomp name="construct.c.filter.page1.b_isahcomp"
            
            #END add-point
 
 
         #----<<b_isahorga>>----
         #Ctrlp:construct.c.page1.b_isahorga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahorga
            #add-point:ON ACTION controlp INFIELD b_isahorga name="construct.c.filter.page1.b_isahorga"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isahorga  #顯示到畫面上
            NEXT FIELD b_isahorga                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_isaf003>>----
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
 
 
         #----<<b_isahdocno>>----
         #Ctrlp:construct.c.filter.page1.b_isahdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahdocno
            #add-point:ON ACTION controlp INFIELD b_isahdocno name="construct.c.filter.page1.b_isahdocno"
            
            #END add-point
 
 
         #----<<b_isahseq>>----
         #Ctrlp:construct.c.filter.page1.b_isahseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isahseq
            #add-point:ON ACTION controlp INFIELD b_isahseq name="construct.c.filter.page1.b_isahseq"
            
            #END add-point
 
 
         #----<<b_isah011>>----
         #Ctrlp:construct.c.filter.page1.b_isah011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah011
            #add-point:ON ACTION controlp INFIELD b_isah011 name="construct.c.filter.page1.b_isah011"
            
            #END add-point
 
 
         #----<<b_isaf022>>----
         #Ctrlp:construct.c.filter.page1.b_isaf022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf022
            #add-point:ON ACTION controlp INFIELD b_isaf022 name="construct.c.filter.page1.b_isaf022"
            
            #END add-point
 
 
         #----<<b_isah003>>----
         #Ctrlp:construct.c.page1.b_isah003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah003
            #add-point:ON ACTION controlp INFIELD b_isah003 name="construct.c.filter.page1.b_isah003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isah003  #顯示到畫面上
            NEXT FIELD b_isah003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_isah004>>----
         #Ctrlp:construct.c.filter.page1.b_isah004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah004
            #add-point:ON ACTION controlp INFIELD b_isah004 name="construct.c.filter.page1.b_isah004"
            
            #END add-point
 
 
         #----<<b_isah013>>----
         #Ctrlp:construct.c.filter.page1.b_isah013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah013
            #add-point:ON ACTION controlp INFIELD b_isah013 name="construct.c.filter.page1.b_isah013"
            
            #END add-point
 
 
         #----<<b_isah005>>----
         #Ctrlp:construct.c.filter.page1.b_isah005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah005
            #add-point:ON ACTION controlp INFIELD b_isah005 name="construct.c.filter.page1.b_isah005"
            
            #END add-point
 
 
         #----<<b_isah010>>----
         #Ctrlp:construct.c.filter.page1.b_isah010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah010
            #add-point:ON ACTION controlp INFIELD b_isah010 name="construct.c.filter.page1.b_isah010"
            
            #END add-point
 
 
         #----<<b_isah006>>----
         #Ctrlp:construct.c.filter.page1.b_isah006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah006
            #add-point:ON ACTION controlp INFIELD b_isah006 name="construct.c.filter.page1.b_isah006"
            
            #END add-point
 
 
         #----<<b_isah101>>----
         #Ctrlp:construct.c.filter.page1.b_isah101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah101
            #add-point:ON ACTION controlp INFIELD b_isah101 name="construct.c.filter.page1.b_isah101"
            
            #END add-point
 
 
         #----<<b_isah103>>----
         #Ctrlp:construct.c.filter.page1.b_isah103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah103
            #add-point:ON ACTION controlp INFIELD b_isah103 name="construct.c.filter.page1.b_isah103"
            
            #END add-point
 
 
         #----<<b_isah105>>----
         #Ctrlp:construct.c.filter.page1.b_isah105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah105
            #add-point:ON ACTION controlp INFIELD b_isah105 name="construct.c.filter.page1.b_isah105"
            
            #END add-point
 
 
         #----<<l_isah1032>>----
         #----<<b_isah106>>----
         #Ctrlp:construct.c.filter.page1.b_isah106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah106
            #add-point:ON ACTION controlp INFIELD b_isah106 name="construct.c.filter.page1.b_isah106"
            
            #END add-point
 
 
         #----<<b_isah012>>----
         #Ctrlp:construct.c.filter.page1.b_isah012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isah012
            #add-point:ON ACTION controlp INFIELD b_isah012 name="construct.c.filter.page1.b_isah012"
            
            #END add-point
 
 
         #----<<b_isba001>>----
         #----<<b_isat004>>----
         #----<<b_isaf017>>----
         #Ctrlp:construct.c.filter.page1.b_isaf017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isaf017
            #add-point:ON ACTION controlp INFIELD b_isaf017 name="construct.c.filter.page1.b_isaf017"
            
            #END add-point
 
 
   
 
      END CONSTRUCT
 
      #add-point:filter段add_cs name="filter.add_cs"
      ON ACTION controlp 
         CASE
            WHEN INFIELD(b_isahdocno)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " isafsite IN ",g_wc_site," AND isafdocdt BETWEEN '",g_input.strdat,"' AND '",g_input.enddat,"' "
               CALL q_isafdocno()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_isahdocno
               NEXT FIELD b_isahdocno
            WHEN INFIELD(b_isahcomp)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef001 IN ",g_wc_comp," "
               CALL q_ooef001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_isahcomp  #顯示到畫面上
               NEXT FIELD b_isahcomp 
         
            WHEN INFIELD(b_isaf003)
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
               #CALL q_pmaa001()  #呼叫開窗   #160920-00019#5--mark   
               CALL q_pmaa001_13()           #160920-00019#5--add
               DISPLAY g_qryparam.return1 TO b_isaf003
               NEXT FIELD b_isaf003
         
            WHEN INFIELD(b_isaf100)
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_aooi001_1()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_isaf100
               NEXT FIELD b_isaf100
       END CASE
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog name="filter.b_dialog"
         LET l_ac = 1
         LET g_isah_d[l_ac].isahcomp = ' ' 
         DISPLAY ARRAY g_isah_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
   
      CALL aisq360_filter_show('isahcomp','b_isahcomp')
   CALL aisq360_filter_show('isahorga','b_isahorga')
   CALL aisq360_filter_show('isaf100','b_isaf100')
   CALL aisq360_filter_show('isahdocno','b_isahdocno')
   CALL aisq360_filter_show('isahseq','b_isahseq')
   CALL aisq360_filter_show('isah011','b_isah011')
   CALL aisq360_filter_show('isaf022','b_isaf022')
   CALL aisq360_filter_show('isah003','b_isah003')
   CALL aisq360_filter_show('isah004','b_isah004')
   CALL aisq360_filter_show('isah013','b_isah013')
   CALL aisq360_filter_show('isah005','b_isah005')
   CALL aisq360_filter_show('isah010','b_isah010')
   CALL aisq360_filter_show('isah006','b_isah006')
   CALL aisq360_filter_show('isah101','b_isah101')
   CALL aisq360_filter_show('isah103','b_isah103')
   CALL aisq360_filter_show('isah105','b_isah105')
   CALL aisq360_filter_show('isah106','b_isah106')
   CALL aisq360_filter_show('isah012','b_isah012')
   CALL aisq360_filter_show('isaf017','b_isaf017')
 
    
   CALL aisq360_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq360_filter_parser(ps_field)
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
 
{<section id="aisq360.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq360_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq360_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.insert" >}
#+ insert
PRIVATE FUNCTION aisq360_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq360.modify" >}
#+ modify
PRIVATE FUNCTION aisq360_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq360_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.delete" >}
#+ delete
PRIVATE FUNCTION aisq360_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq360.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq360_detail_action_trans()
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
 
{<section id="aisq360.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq360_detail_index_setting()
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
            IF g_isah_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isah_d.getLength() AND g_isah_d.getLength() > 0
            LET g_detail_idx = g_isah_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isah_d.getLength() THEN
               LET g_detail_idx = g_isah_d.getLength()
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
 
{<section id="aisq360.mask_functions" >}
 &include "erp/ais/aisq360_mask.4gl"
 
{</section>}
 
{<section id="aisq360.other_function" readonly="Y" >}

################################################################################
# Descriptions...: INPUT等預設值與掃把功能
# Memo...........:
# Date & Author..: 150119 By albireo 
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq360_qbe_clear()
   DEFINE l_ld    LIKE glaa_t.glaald
   DEFINE l_comp  LIKE ooef_t.ooef001
   DEFINE l_year  LIKE type_t.num5
   DEFINE l_month LIKE type_t.num5
   
   INITIALIZE g_input.* TO NULL
   INITIALIZE g_input_o.* TO NULL
   CALL g_isah_d.clear()
   
   #LET g_wc = NULL
   LET g_wc_filter = NULL
   #LET g_wc_filter2 =NULL
   #帳務中心/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,
                                                      g_input.isafsite,l_ld,l_comp
   CALL s_fin_account_center_sons_query('3',g_input.isafsite,g_today,'1')
   #取得帳務中心底下之組織範圍
   CALL s_fin_account_center_sons_str() RETURNING g_wc_site
   CALL s_fin_get_wc_str(g_wc_site) RETURNING g_wc_site
   #取得帳務中心底下的帳套範圍
   CALL s_fin_account_center_ld_str() RETURNING g_wc_ld
   CALL s_fin_get_wc_str(g_wc_ld) RETURNING g_wc_ld
   #取得帳務中心底下的法人範圍
   CALL s_fin_account_center_comp_str() RETURNING g_wc_comp
   CALL s_fin_get_wc_str(g_wc_comp) RETURNING g_wc_comp
   #取帳務中心說明
   CALL s_desc_get_department_desc(g_input.isafsite)RETURNING g_input.isafsite_desc
   #日期區間給本月起始與結束
   LET g_input.strdat = MDY(MONTH(g_today),1,YEAR(g_today))
   
   LET l_month = MONTH(g_today)
   LET l_year  = YEAR(g_today)
   LET l_month = l_month + 1 
   IF l_month = 13 THEN
      LET l_month = 1
      LET l_year  = l_year + 1 
   END IF
   LET g_input.enddat = MDY(l_month,1,l_year) - 1
   
   LET g_input.type   = '0'   #未開發票
   
   DISPLAY BY NAME g_input.isafsite,g_input.strdat,g_input.enddat,g_input.type,g_input.isafsite_desc
   
   LET g_input_o.* = g_input.*
   
   #150127-00007#1 add---
   LET l_ac = 1
   LET g_isah_d[l_ac].isahcomp = ' ' 
   DISPLAY ARRAY g_isah_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
   #150127-00007#1 add end---
   
END FUNCTION

PRIVATE FUNCTION aisq360_prepare_declare()
DEFINE l_sql  STRING

   LET l_sql = "SELECT isat004 FROM isat_t ",
               " WHERE isatent = ? ",
               "   AND isatcomp = ? ",
               "   AND isatdocno = ? "
   PREPARE aisq360_selisatp1 FROM l_sql
   DECLARE aisq360_selisatc1 CURSOR FOR aisq360_selisatp1
END FUNCTION

################################################################################
# Descriptions...: 取發票號碼字串
# Memo...........: 要在aisq360_prepare_declare之後
# Date & Author..: 150119 By albireo
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq360_get_isat004_str(p_comp,p_docno)
   DEFINE p_comp    LIKE isaf_t.isafcomp
   DEFINE p_docno   LIKE isaf_t.isafdocno
   DEFINE r_str     LIKE type_t.chr1000
   DEFINE l_isat004 LIKE isat_t.isat004
   
   LET r_str = NULL
   FOREACH aisq360_selisatc1 USING g_enterprise,p_comp,p_docno 
      INTO l_isat004
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam.* TO NULL
         LET g_errparam.code = SQLCA.SQLCODE
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      
      IF cl_null(r_str)THEN
         LET r_str = l_isat004
      ELSE
         LET r_str = r_str CLIPPED,'/',l_isat004
      END IF
   END FOREACH
   RETURN r_str
END FUNCTION

################################################################################
# Descriptions...: 建立臨時表
# Memo...........: #161013-00020#1
# Usage..........: CALL aisq360_create_tmp()
# Date & Author..: 2016/11/01 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq360_create_tmp()

   #建立臨時表     
   DROP TABLE aisq360_x01_tmp;
   CREATE TEMP TABLE aisq360_x01_tmp(
      isahent            SMALLINT,
      isahcomp           VARCHAR(10),
      isahorga           VARCHAR(10),
      l_isaf003          VARCHAR(100), 
      l_isaf100          VARCHAR(10),
      isahdocno          VARCHAR(20),
      isahseq            INTEGER,
      isah011            INTEGER,
      l_isaf022          VARCHAR(20), 
      isah003            VARCHAR(40),
      isah004            VARCHAR(255),
      isah013            VARCHAR(255),
      isah005            VARCHAR(10),
      isah006            DECIMAL(20,6),
      isah101            DECIMAL(20,6),
      isah103            DECIMAL(20,6), 
      isah105            DECIMAL(20,6),
      isah010            SMALLINT,
      l_isah1032         DECIMAL(20,6),
      isah106            DECIMAL(20,6),
      isah012            VARCHAR(255), 
      l_isba001          VARCHAR(500), 
      l_isat004          VARCHAR(500), 
      l_isaf017          VARCHAR(1)
      )
END FUNCTION

################################################################################
# Descriptions...: 報表列印
# Memo...........: #161013-00020#1
# Usage..........: CALL aisq360_ins_x01_tmp()
# Date & Author..: 2016/11/01 By 08732
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq360_ins_x01_tmp()
DEFINE l_i                 LIKE type_t.num5
   
   DELETE FROM aisq360_x01_tmp
   
   #單身
   LET l_i = 1
   FOR l_i = 1 TO g_isah_d.getLength()
      INSERT INTO aisq360_x01_tmp
         VALUES(g_enterprise,               g_isah_d[l_i].isahcomp,     g_isah_d[l_i].isahorga,    
                g_isah_d[l_i].isaf003,      g_isah_d[l_i].isaf100,      g_isah_d[l_i].isahdocno,    
                g_isah_d[l_i].isahseq,      g_isah_d[l_i].isah011,      g_isah_d[l_i].isaf022,      
                g_isah_d[l_i].isah003,      g_isah_d[l_i].isah004,      g_isah_d[l_i].isah013,      
                g_isah_d[l_i].isah005,      g_isah_d[l_i].isah006,      g_isah_d[l_i].isah101,      
                g_isah_d[l_i].isah103,      g_isah_d[l_i].isah105,      g_isah_d[l_i].isah010,      
                g_isah_d[l_i].l_isah1032,   g_isah_d[l_i].isah106,      g_isah_d[l_i].isah012,      
                g_isah_d[l_i].isba001,      g_isah_d[l_i].isat004,      g_isah_d[l_i].isaf017
                )
   END FOR
END FUNCTION

 
{</section>}
 
