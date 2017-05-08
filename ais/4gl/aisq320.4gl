#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq320.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-01-14 16:32:29), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: aisq320
#+ Description: 電子發票歷程查詢作業
#+ Creator....: 05016(2016-01-14 16:32:29)
#+ Modifier...: 05016 -SD/PR- 00000
 
{</section>}
 
{<section id="aisq320.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#10 2016/08/01 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aisq320_print_tmp -->aisq320_tmp01
#160905-00002#4  2016/09/05 By 06821   補入WHERE條件漏掉ENT的部分
#161006-00005#26 2016/10/21 By Reanna  1.法人(isatcomp)需控卡azzi800 2.營運據點(isatsite) where條件為 ooef201 = 'Y' 和azzi800控卡
#                                      3.銷方稅務編號(isat012)開窗改用q_ooef001( )，增加ooef201 = 'Y' 條件，開窗後顯示的資料需存在aisi090
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
PRIVATE TYPE type_g_isat_d RECORD
       #statepic       LIKE type_t.chr1,
       
       isat001 LIKE isat_t.isat001, 
   isat001_desc LIKE type_t.chr500, 
   isat003 LIKE type_t.chr500, 
   isat004 LIKE isat_t.isat004, 
   isat014 LIKE isat_t.isat014, 
   isat025 LIKE isat_t.isat025, 
   isatseq LIKE isat_t.isatseq, 
   isat007 LIKE isat_t.isat007, 
   isat008 DATETIME YEAR TO FRACTION(5), 
   isat208 LIKE isat_t.isat208, 
   isat209 LIKE isat_t.isat209, 
   isat012 LIKE isat_t.isat012, 
   isat009 LIKE isat_t.isat009, 
   isat002 LIKE isat_t.isat002, 
   isat021 LIKE isat_t.isat021, 
   isat205 LIKE isat_t.isat205, 
   isat206 LIKE isat_t.isat206, 
   isat207 LIKE isat_t.isat207, 
   isat204 LIKE isat_t.isat204, 
   isat006 LIKE isat_t.isat006, 
   isat201 LIKE isat_t.isat201, 
   isat202 LIKE isat_t.isat202, 
   isat203 LIKE isat_t.isat203, 
   isat005 LIKE isat_t.isat005, 
   isat022 LIKE isat_t.isat022, 
   isat113 LIKE isat_t.isat113, 
   isat114 LIKE isat_t.isat114, 
   isat115 LIKE isat_t.isat115, 
   isat020 LIKE isat_t.isat020, 
   isatdocno LIKE isat_t.isatdocno, 
   isat013 LIKE isat_t.isat013, 
   isatcomp LIKE isat_t.isatcomp 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input          RECORD
          isatcomp         LIKE isat_t.isatcomp,
          isatcomp_desc    LIKE type_t.chr100,
          isatsite         LIKE isat_t.isatsite,
          isatsite_desc    LIKE type_t.chr100,
          isat007s         LIKE isat_t.isat007,
          isat007e         LIKE isat_t.isat007
                        END RECORD
DEFINE g_isai002        LIKE isai_t.isai002
DEFINE g_ooef019        LIKE ooef_t.ooef019
DEFINE g_wc_isatcomp    STRING     #161006-00005#26
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_isat_d
DEFINE g_master_t                   type_g_isat_d
DEFINE g_isat_d          DYNAMIC ARRAY OF type_g_isat_d
DEFINE g_isat_d_t        type_g_isat_d
 
      
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
 
{<section id="aisq320.main" >}
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
   CALL cl_ap_init("ais","")
 
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
   DECLARE aisq320_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aisq320_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aisq320_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aisq320 WITH FORM cl_ap_formpath("ais",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aisq320_init()   
 
      #進入選單 Menu (="N")
      CALL aisq320_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aisq320
      
   END IF 
   
   CLOSE aisq320_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aisq320.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aisq320_init()
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
   CALL aisq320_create_tmp()
   CALL s_fin_create_account_center_tmp()     #展組織下階成員所需之暫存檔  #161006-00005#26 change set
   CALL aisq320_default()
   CALL cl_set_combo_scc('b_isat022','9708')
   CALL cl_set_combo_scc('b_isat014','9716')
   CALL cl_set_combo_scc('b_isat025','9716')
   CALL cl_set_combo_scc('b_isat005','9734')
   CALL cl_set_combo_scc('b_isat208','9754')
   CALL cl_set_combo_scc_part('b_isat022','9708','1,2,3')
   #end add-point
 
   CALL aisq320_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aisq320.default_search" >}
PRIVATE FUNCTION aisq320_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " isatcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " isatseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " isat003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " isat004 = '", g_argv[04], "' AND "
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
 
{<section id="aisq320.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aisq320_ui_dialog()
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
      CALL aisq320_b_fill()
   ELSE
      CALL aisq320_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_isat_d.clear()
 
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
 
         CALL aisq320_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_isat_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aisq320_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aisq320_detail_action_trans()
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
            CALL aisq320_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aisq320_print()
               CALL aisq320_x01(' 1=1','aisq320_tmp01',g_isai002)         #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL aisq320_print()
               CALL aisq320_x01(' 1=1','aisq320_tmp01',g_isai002)         #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aisq320_query()
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
            CALL aisq320_filter()
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
            CALL aisq320_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_isat_d)
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
            CALL aisq320_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aisq320_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aisq320_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aisq320_b_fill()
 
         
         
 
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
 
{<section id="aisq320.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aisq320_query()
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
   CALL g_isat_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON isat001,isat004,isat014,isat025,isatseq,isat007,isat208,isat209,isat012, 
          isat009,isat002,isat021,isat205,isat206,isat207,isat204,isat006,isat201,isat202,isat203,isat005, 
          isat022,isat113,isat114,isat115,isat020,isatdocno,isat013,isatcomp
           FROM s_detail1[1].b_isat001,s_detail1[1].b_isat004,s_detail1[1].b_isat014,s_detail1[1].b_isat025, 
               s_detail1[1].b_isatseq,s_detail1[1].b_isat007,s_detail1[1].b_isat208,s_detail1[1].b_isat209, 
               s_detail1[1].b_isat012,s_detail1[1].b_isat009,s_detail1[1].b_isat002,s_detail1[1].b_isat021, 
               s_detail1[1].b_isat205,s_detail1[1].b_isat206,s_detail1[1].b_isat207,s_detail1[1].b_isat204, 
               s_detail1[1].b_isat006,s_detail1[1].b_isat201,s_detail1[1].b_isat202,s_detail1[1].b_isat203, 
               s_detail1[1].b_isat005,s_detail1[1].b_isat022,s_detail1[1].b_isat113,s_detail1[1].b_isat114, 
               s_detail1[1].b_isat115,s_detail1[1].b_isat020,s_detail1[1].b_isatdocno,s_detail1[1].b_isat013, 
               s_detail1[1].b_isatcomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            #NEXT FIELD isatcomp
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_isat001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat001
            #add-point:BEFORE FIELD b_isat001 name="construct.b.page1.b_isat001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat001
            
            #add-point:AFTER FIELD b_isat001 name="construct.a.page1.b_isat001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat001
            #add-point:ON ACTION controlp INFIELD b_isat001 name="construct.c.page1.b_isat001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_ooef019,"' "
            CALL q_isac002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat001  #顯示到畫面上
            NEXT FIELD b_isat001                     #返回原欄位
            #END add-point
 
 
         #----<<isat001_desc>>----
         #----<<b_isat003>>----
         #----<<b_isat004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat004
            #add-point:BEFORE FIELD b_isat004 name="construct.b.page1.b_isat004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat004
            
            #add-point:AFTER FIELD b_isat004 name="construct.a.page1.b_isat004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat004
            #add-point:ON ACTION controlp INFIELD b_isat004 name="construct.c.page1.b_isat004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isat004 IN (SELECT isat004 FROM isat_t               ",
                                   "              WHERE isatent = '",g_enterprise,"'      ",
                                   "                AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                AND isatsite = '",g_input.isatsite,"' ",
                                   "                AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'  ",
                                   "                AND isat002 = 'Y')                    " 
            CALL q_isat004()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat004  #顯示到畫面上
            NEXT FIELD b_isat004                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat014
            #add-point:BEFORE FIELD b_isat014 name="construct.b.page1.b_isat014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat014
            
            #add-point:AFTER FIELD b_isat014 name="construct.a.page1.b_isat014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat014
            #add-point:ON ACTION controlp INFIELD b_isat014 name="construct.c.page1.b_isat014"
            
            #END add-point
 
 
         #----<<b_isat025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat025
            #add-point:BEFORE FIELD b_isat025 name="construct.b.page1.b_isat025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat025
            
            #add-point:AFTER FIELD b_isat025 name="construct.a.page1.b_isat025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat025
            #add-point:ON ACTION controlp INFIELD b_isat025 name="construct.c.page1.b_isat025"
            
            #END add-point
 
 
         #----<<b_isatseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isatseq
            #add-point:BEFORE FIELD b_isatseq name="construct.b.page1.b_isatseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isatseq
            
            #add-point:AFTER FIELD b_isatseq name="construct.a.page1.b_isatseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isatseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatseq
            #add-point:ON ACTION controlp INFIELD b_isatseq name="construct.c.page1.b_isatseq"
            
            #END add-point
 
 
         #----<<b_isat007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat007
            #add-point:BEFORE FIELD b_isat007 name="construct.b.page1.b_isat007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat007
            
            #add-point:AFTER FIELD b_isat007 name="construct.a.page1.b_isat007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat007
            #add-point:ON ACTION controlp INFIELD b_isat007 name="construct.c.page1.b_isat007"
            
            #END add-point
 
 
         #----<<b_isat008>>----
         #----<<b_isat208>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat208
            #add-point:BEFORE FIELD b_isat208 name="construct.b.page1.b_isat208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat208
            
            #add-point:AFTER FIELD b_isat208 name="construct.a.page1.b_isat208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat208
            #add-point:ON ACTION controlp INFIELD b_isat208 name="construct.c.page1.b_isat208"
            
            #END add-point
 
 
         #----<<b_isat209>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat209
            #add-point:BEFORE FIELD b_isat209 name="construct.b.page1.b_isat209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat209
            
            #add-point:AFTER FIELD b_isat209 name="construct.a.page1.b_isat209"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat209
            #add-point:ON ACTION controlp INFIELD b_isat209 name="construct.c.page1.b_isat209"
            
            #END add-point
 
 
         #----<<b_isat012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat012
            #add-point:BEFORE FIELD b_isat012 name="construct.b.page1.b_isat012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat012
            
            #add-point:AFTER FIELD b_isat012 name="construct.a.page1.b_isat012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat012
            #add-point:ON ACTION controlp INFIELD b_isat012 name="construct.c.page1.b_isat012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef002 IN (SELECT isat012 FROM isat_t",
                                   "              WHERE isatent = ",g_enterprise,
                                   "                AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                AND isatsite = '",g_input.isatsite,"' ",
                                   "                AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'",
                                   "                AND isat002 = 'Y')" 
            #161006-00005#26 add ------
            LET g_qryparam.where = g_qryparam.where,
                                   " AND ooef002 IN (SELECT isao001 FROM isao_t",
                                   "                  WHERE isaoent = ",g_enterprise,
                                   "                    AND isaosite = '",g_input.isatsite,"') "
            #161006-00005#26 add end---
            CALL q_ooef001_02()
            DISPLAY g_qryparam.return2 TO b_isat012
            NEXT FIELD b_isat012
            #END add-point
 
 
         #----<<b_isat009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat009
            #add-point:BEFORE FIELD b_isat009 name="construct.b.page1.b_isat009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat009
            
            #add-point:AFTER FIELD b_isat009 name="construct.a.page1.b_isat009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat009
            #add-point:ON ACTION controlp INFIELD b_isat009 name="construct.c.page1.b_isat009"
            
            #END add-point
 
 
         #----<<b_isat002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat002
            #add-point:BEFORE FIELD b_isat002 name="construct.b.page1.b_isat002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat002
            
            #add-point:AFTER FIELD b_isat002 name="construct.a.page1.b_isat002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat002
            #add-point:ON ACTION controlp INFIELD b_isat002 name="construct.c.page1.b_isat002"
            
            #END add-point
 
 
         #----<<b_isat021>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat021
            #add-point:BEFORE FIELD b_isat021 name="construct.b.page1.b_isat021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat021
            
            #add-point:AFTER FIELD b_isat021 name="construct.a.page1.b_isat021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat021
            #add-point:ON ACTION controlp INFIELD b_isat021 name="construct.c.page1.b_isat021"
            
            #END add-point
 
 
         #----<<b_isat205>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat205
            #add-point:BEFORE FIELD b_isat205 name="construct.b.page1.b_isat205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat205
            
            #add-point:AFTER FIELD b_isat205 name="construct.a.page1.b_isat205"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat205
            #add-point:ON ACTION controlp INFIELD b_isat205 name="construct.c.page1.b_isat205"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '3802'
            CALL q_oocq002()                  
            DISPLAY g_qryparam.return1 TO b_isat205  #顯示到畫面上
            NEXT FIELD b_isat205                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat206>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat206
            #add-point:BEFORE FIELD b_isat206 name="construct.b.page1.b_isat206"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat206
            
            #add-point:AFTER FIELD b_isat206 name="construct.a.page1.b_isat206"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat206
            #add-point:ON ACTION controlp INFIELD b_isat206 name="construct.c.page1.b_isat206"
            
            #END add-point
 
 
         #----<<b_isat207>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat207
            #add-point:BEFORE FIELD b_isat207 name="construct.b.page1.b_isat207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat207
            
            #add-point:AFTER FIELD b_isat207 name="construct.a.page1.b_isat207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat207
            #add-point:ON ACTION controlp INFIELD b_isat207 name="construct.c.page1.b_isat207"
            
            #END add-point
 
 
         #----<<b_isat204>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat204
            #add-point:BEFORE FIELD b_isat204 name="construct.b.page1.b_isat204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat204
            
            #add-point:AFTER FIELD b_isat204 name="construct.a.page1.b_isat204"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat204
            #add-point:ON ACTION controlp INFIELD b_isat204 name="construct.c.page1.b_isat204"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3801'            
            CALL q_oocq002()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat204  #顯示到畫面上
            NEXT FIELD b_isat204                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat006
            #add-point:BEFORE FIELD b_isat006 name="construct.b.page1.b_isat006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat006
            
            #add-point:AFTER FIELD b_isat006 name="construct.a.page1.b_isat006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat006
            #add-point:ON ACTION controlp INFIELD b_isat006 name="construct.c.page1.b_isat006"
            
            #END add-point
 
 
         #----<<b_isat201>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat201
            #add-point:BEFORE FIELD b_isat201 name="construct.b.page1.b_isat201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat201
            
            #add-point:AFTER FIELD b_isat201 name="construct.a.page1.b_isat201"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat201
            #add-point:ON ACTION controlp INFIELD b_isat201 name="construct.c.page1.b_isat201"
            
            #END add-point
 
 
         #----<<b_isat202>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat202
            #add-point:BEFORE FIELD b_isat202 name="construct.b.page1.b_isat202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat202
            
            #add-point:AFTER FIELD b_isat202 name="construct.a.page1.b_isat202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat202
            #add-point:ON ACTION controlp INFIELD b_isat202 name="construct.c.page1.b_isat202"
            
            #END add-point
 
 
         #----<<b_isat203>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat203
            #add-point:BEFORE FIELD b_isat203 name="construct.b.page1.b_isat203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat203
            
            #add-point:AFTER FIELD b_isat203 name="construct.a.page1.b_isat203"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat203
            #add-point:ON ACTION controlp INFIELD b_isat203 name="construct.c.page1.b_isat203"
            
            #END add-point
 
 
         #----<<b_isat005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat005
            #add-point:BEFORE FIELD b_isat005 name="construct.b.page1.b_isat005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat005
            
            #add-point:AFTER FIELD b_isat005 name="construct.a.page1.b_isat005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat005
            #add-point:ON ACTION controlp INFIELD b_isat005 name="construct.c.page1.b_isat005"
            
            #END add-point
 
 
         #----<<b_isat022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat022
            #add-point:BEFORE FIELD b_isat022 name="construct.b.page1.b_isat022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat022
            
            #add-point:AFTER FIELD b_isat022 name="construct.a.page1.b_isat022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat022
            #add-point:ON ACTION controlp INFIELD b_isat022 name="construct.c.page1.b_isat022"
            
            #END add-point
 
 
         #----<<b_isat113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat113
            #add-point:BEFORE FIELD b_isat113 name="construct.b.page1.b_isat113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat113
            
            #add-point:AFTER FIELD b_isat113 name="construct.a.page1.b_isat113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat113
            #add-point:ON ACTION controlp INFIELD b_isat113 name="construct.c.page1.b_isat113"
            
            #END add-point
 
 
         #----<<b_isat114>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat114
            #add-point:BEFORE FIELD b_isat114 name="construct.b.page1.b_isat114"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat114
            
            #add-point:AFTER FIELD b_isat114 name="construct.a.page1.b_isat114"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat114
            #add-point:ON ACTION controlp INFIELD b_isat114 name="construct.c.page1.b_isat114"
            
            #END add-point
 
 
         #----<<b_isat115>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat115
            #add-point:BEFORE FIELD b_isat115 name="construct.b.page1.b_isat115"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat115
            
            #add-point:AFTER FIELD b_isat115 name="construct.a.page1.b_isat115"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat115
            #add-point:ON ACTION controlp INFIELD b_isat115 name="construct.c.page1.b_isat115"
            
            #END add-point
 
 
         #----<<b_isat020>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat020
            #add-point:BEFORE FIELD b_isat020 name="construct.b.page1.b_isat020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat020
            
            #add-point:AFTER FIELD b_isat020 name="construct.a.page1.b_isat020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat020
            #add-point:ON ACTION controlp INFIELD b_isat020 name="construct.c.page1.b_isat020"
            
            #END add-point
 
 
         #----<<b_isatdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isatdocno
            #add-point:BEFORE FIELD b_isatdocno name="construct.b.page1.b_isatdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isatdocno
            
            #add-point:AFTER FIELD b_isatdocno name="construct.a.page1.b_isatdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isatdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatdocno
            #add-point:ON ACTION controlp INFIELD b_isatdocno name="construct.c.page1.b_isatdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isatdocno IN (SELECT isatdocno FROM isat_t               ",
                                   "                WHERE isatent = '",g_enterprise,"'      ",
                                   "                  AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                  AND isatsite = '",g_input.isatsite,"' ",
                                   "                  AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'  ",
                                   "                  AND isat002 = 'Y')                    " 
            CALL q_isat003_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isatdocno  #顯示到畫面上
            NEXT FIELD b_isatdocno                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isat013
            #add-point:BEFORE FIELD b_isat013 name="construct.b.page1.b_isat013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isat013
            
            #add-point:AFTER FIELD b_isat013 name="construct.a.page1.b_isat013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isat013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat013
            #add-point:ON ACTION controlp INFIELD b_isat013 name="construct.c.page1.b_isat013"
            
            #END add-point
 
 
         #----<<b_isatcomp>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_isatcomp
            #add-point:BEFORE FIELD b_isatcomp name="construct.b.page1.b_isatcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_isatcomp
            
            #add-point:AFTER FIELD b_isatcomp name="construct.a.page1.b_isatcomp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_isatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatcomp
            #add-point:ON ACTION controlp INFIELD b_isatcomp name="construct.c.page1.b_isatcomp"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.isatcomp,g_input.isatsite,g_input.isat007s,g_input.isat007e
         ATTRIBUTE(WITHOUT DEFAULTS) 
          
         AFTER FIELD isatcomp
            IF NOT cl_null(g_input.isatcomp) THEN
               LET g_input.isatsite = ''
               LET g_input.isatsite_desc = ''
               DISPLAY BY NAME g_input.isatsite,g_input.isatsite_desc
               CALL aisq320_isat_chk(g_input.isatcomp,g_input.isatsite) RETURNING g_sub_success,g_errno 
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isatcomp = ''
                  LET g_input.isatcomp_desc = ''
                  DISPLAY BY NAME g_input.isatcomp_desc
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#26 add ------
               #檢查輸入帳套是否存在帳務中心下帳套範圍內
               IF s_chr_get_index_of(g_wc_isatcomp,g_input.isatcomp,1) = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aap-00127'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isatcomp = ''
                  LET g_input.isatcomp_desc = s_desc_get_department_desc(g_input.isatcomp) 
                  DISPLAY BY NAME g_input.isatcomp,g_input.isatcomp_desc
                  NEXT FIELD CURRENT
               END IF
               #161006-00005#26 add end---
               SELECT ooef019 INTO g_ooef019 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.isatcomp
            END IF
            CALL s_desc_get_department_desc(g_input.isatcomp) RETURNING g_input.isatcomp_desc
            DISPLAY BY NAME g_input.isatcomp_desc,g_input.isatsite,g_input.isatsite_desc
             
         AFTER FIELD isatsite
            IF NOT cl_null(g_input.isatsite) THEN
               CALL aisq320_isat_chk(g_input.isatcomp,g_input.isatsite) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_input.isatsite = ''
                  LET g_input.isatsite_desc = ''
                  DISPLAY BY NAME g_input.isatsite_desc
                  NEXT FIELD CURRENT
               END IF
            END IF
            CALL s_desc_get_department_desc(g_input.isatsite) RETURNING g_input.isatsite_desc
            DISPLAY BY NAME g_input.isatsite_desc
          
         ON ACTION controlp INFIELD isatcomp
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.isatcomp
            LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN (SELECT DISTINCT isaosite FROM isao_t  ",
                                   "                                WHERE isaoent = ",g_enterprise," AND isao017 = 'Y') "
            LET g_qryparam.where = g_qryparam.where," AND ooef001 IN ",g_wc_isatcomp CLIPPED  #161006-00005#26
            CALL q_ooef001()
            LET g_input.isatcomp = g_qryparam.return1
            LET g_input.isatsite = ''
            LET g_input.isatsite_desc = ''
            DISPLAY BY NAME g_input.isatcomp,g_input.isatsite_desc
            NEXT FIELD isatcomp
             
          ON ACTION controlp INFIELD isatsite
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'i'
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.default1 = g_input.isatsite
             LET g_qryparam.where = "  ooef001 IN (SELECT DISTINCT isaosite FROM isao_t     ",
                                    "               WHERE isaoent = '",g_enterprise,"'      ",
                                    "                 AND isao017 = 'Y'                     ",
                                    "                 AND isaosite IN (SELECT ooef001       ",
                                    "                                    FROM ooef_t        ",
                                    "                                   WHERE ooefent = '",g_enterprise,"'         ",
                                    "                                     AND ooef017 = '",g_input.isatcomp,"'  )) "
             LET g_qryparam.where = g_qryparam.where," AND ooef201 = 'Y' "  #161006-00005#26
             CALL q_ooef001()
             LET g_input.isatsite = g_qryparam.return1
             DISPLAY BY NAME g_input.isatsite
             NEXT FIELD isatsite
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
         CALL aisq320_default()
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
   CALL aisq320_b_fill()
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
 
{<section id="aisq320.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aisq320_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aisq320_set_entry_invoice_code()
                       
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
 
   LET ls_sql_rank = "SELECT  UNIQUE isat001,'','',isat004,isat014,isat025,isatseq,isat007,isat008,isat208, 
       isat209,isat012,isat009,isat002,isat021,isat205,isat206,isat207,isat204,isat006,isat201,isat202, 
       isat203,isat005,isat022,isat113,isat114,isat115,isat020,isatdocno,isat013,isatcomp  ,DENSE_RANK() OVER( ORDER BY isat_t.isatcomp, 
       isat_t.isatseq,isat_t.isat003,isat_t.isat004) AS RANK FROM isat_t",
 
 
                     "",
                     " WHERE isatent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("isat_t"),
                     " ORDER BY isat_t.isatcomp,isat_t.isatseq,isat_t.isat003,isat_t.isat004"
 
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
 
   LET g_sql = "SELECT isat001,'','',isat004,isat014,isat025,isatseq,isat007,isat008,isat208,isat209, 
       isat012,isat009,isat002,isat021,isat205,isat206,isat207,isat204,isat006,isat201,isat202,isat203, 
       isat005,isat022,isat113,isat114,isat115,isat020,isatdocno,isat013,isatcomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT  UNIQUE isat001,'','',isat004,isat014,isat025,isatseq,isat007,isat008,isat208,     
                        isat209,isat012,isat009,isat002,isat021,isat205,isat206,isat207,isat204,isat006,isat201,isat202,    
                       isat203,isat005,isat022,isat113,isat114,isat115,isat020,isatdocno,isat013,isatcomp 
                  FROM isat_t WHERE isatent= ?   AND  " ,ls_wc



   LET g_sql = g_sql CLIPPED, " AND isatcomp = '",g_input.isatcomp,"' ",
                              " AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'       ",
                              " AND isat002 = 'Y' "    
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aisq320_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aisq320_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_isat_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_isat_d[l_ac].isat001,g_isat_d[l_ac].isat001_desc,g_isat_d[l_ac].isat003, 
       g_isat_d[l_ac].isat004,g_isat_d[l_ac].isat014,g_isat_d[l_ac].isat025,g_isat_d[l_ac].isatseq,g_isat_d[l_ac].isat007, 
       g_isat_d[l_ac].isat008,g_isat_d[l_ac].isat208,g_isat_d[l_ac].isat209,g_isat_d[l_ac].isat012,g_isat_d[l_ac].isat009, 
       g_isat_d[l_ac].isat002,g_isat_d[l_ac].isat021,g_isat_d[l_ac].isat205,g_isat_d[l_ac].isat206,g_isat_d[l_ac].isat207, 
       g_isat_d[l_ac].isat204,g_isat_d[l_ac].isat006,g_isat_d[l_ac].isat201,g_isat_d[l_ac].isat202,g_isat_d[l_ac].isat203, 
       g_isat_d[l_ac].isat005,g_isat_d[l_ac].isat022,g_isat_d[l_ac].isat113,g_isat_d[l_ac].isat114,g_isat_d[l_ac].isat115, 
       g_isat_d[l_ac].isat020,g_isat_d[l_ac].isatdocno,g_isat_d[l_ac].isat013,g_isat_d[l_ac].isatcomp 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_isat_d[l_ac].statepic = cl_get_actipic(g_isat_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_isat_d[l_ac].isat001_desc =  s_desc_get_invoice_type_desc1(g_input.isatcomp,g_isat_d[l_ac].isat001)
      #end add-point
 
      CALL aisq320_detail_show("'1'")      
 
      CALL aisq320_isat_t_mask()
 
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
   
 
   
   CALL g_isat_d.deleteElement(g_isat_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_tot_cnt = g_isat_d.getLength()
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_isat_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aisq320_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aisq320_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aisq320_detail_action_trans()
 
   IF g_isat_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aisq320_fetch()
   END IF
   
      CALL aisq320_filter_show('isat001','b_isat001')
   CALL aisq320_filter_show('isat004','b_isat004')
   CALL aisq320_filter_show('isat014','b_isat014')
   CALL aisq320_filter_show('isat025','b_isat025')
   CALL aisq320_filter_show('isatseq','b_isatseq')
   CALL aisq320_filter_show('isat007','b_isat007')
   CALL aisq320_filter_show('isat208','b_isat208')
   CALL aisq320_filter_show('isat209','b_isat209')
   CALL aisq320_filter_show('isat012','b_isat012')
   CALL aisq320_filter_show('isat009','b_isat009')
   CALL aisq320_filter_show('isat002','b_isat002')
   CALL aisq320_filter_show('isat021','b_isat021')
   CALL aisq320_filter_show('isat205','b_isat205')
   CALL aisq320_filter_show('isat206','b_isat206')
   CALL aisq320_filter_show('isat207','b_isat207')
   CALL aisq320_filter_show('isat204','b_isat204')
   CALL aisq320_filter_show('isat006','b_isat006')
   CALL aisq320_filter_show('isat201','b_isat201')
   CALL aisq320_filter_show('isat202','b_isat202')
   CALL aisq320_filter_show('isat203','b_isat203')
   CALL aisq320_filter_show('isat005','b_isat005')
   CALL aisq320_filter_show('isat022','b_isat022')
   CALL aisq320_filter_show('isat113','b_isat113')
   CALL aisq320_filter_show('isat114','b_isat114')
   CALL aisq320_filter_show('isat115','b_isat115')
   CALL aisq320_filter_show('isat020','b_isat020')
   CALL aisq320_filter_show('isatdocno','b_isatdocno')
   CALL aisq320_filter_show('isat013','b_isat013')
   CALL aisq320_filter_show('isatcomp','b_isatcomp')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aisq320_fetch()
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
 
{<section id="aisq320.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aisq320_detail_show(ps_page)
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
 
{<section id="aisq320.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aisq320_filter()
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
      CONSTRUCT g_wc_filter ON isat001,isat004,isat014,isat025,isatseq,isat007,isat208,isat209,isat012, 
          isat009,isat002,isat021,isat205,isat206,isat207,isat204,isat006,isat201,isat202,isat203,isat005, 
          isat022,isat113,isat114,isat115,isat020,isatdocno,isat013,isatcomp
                          FROM s_detail1[1].b_isat001,s_detail1[1].b_isat004,s_detail1[1].b_isat014, 
                              s_detail1[1].b_isat025,s_detail1[1].b_isatseq,s_detail1[1].b_isat007,s_detail1[1].b_isat208, 
                              s_detail1[1].b_isat209,s_detail1[1].b_isat012,s_detail1[1].b_isat009,s_detail1[1].b_isat002, 
                              s_detail1[1].b_isat021,s_detail1[1].b_isat205,s_detail1[1].b_isat206,s_detail1[1].b_isat207, 
                              s_detail1[1].b_isat204,s_detail1[1].b_isat006,s_detail1[1].b_isat201,s_detail1[1].b_isat202, 
                              s_detail1[1].b_isat203,s_detail1[1].b_isat005,s_detail1[1].b_isat022,s_detail1[1].b_isat113, 
                              s_detail1[1].b_isat114,s_detail1[1].b_isat115,s_detail1[1].b_isat020,s_detail1[1].b_isatdocno, 
                              s_detail1[1].b_isat013,s_detail1[1].b_isatcomp
 
         BEFORE CONSTRUCT
                     DISPLAY aisq320_filter_parser('isat001') TO s_detail1[1].b_isat001
            DISPLAY aisq320_filter_parser('isat004') TO s_detail1[1].b_isat004
            DISPLAY aisq320_filter_parser('isat014') TO s_detail1[1].b_isat014
            DISPLAY aisq320_filter_parser('isat025') TO s_detail1[1].b_isat025
            DISPLAY aisq320_filter_parser('isatseq') TO s_detail1[1].b_isatseq
            DISPLAY aisq320_filter_parser('isat007') TO s_detail1[1].b_isat007
            DISPLAY aisq320_filter_parser('isat208') TO s_detail1[1].b_isat208
            DISPLAY aisq320_filter_parser('isat209') TO s_detail1[1].b_isat209
            DISPLAY aisq320_filter_parser('isat012') TO s_detail1[1].b_isat012
            DISPLAY aisq320_filter_parser('isat009') TO s_detail1[1].b_isat009
            DISPLAY aisq320_filter_parser('isat002') TO s_detail1[1].b_isat002
            DISPLAY aisq320_filter_parser('isat021') TO s_detail1[1].b_isat021
            DISPLAY aisq320_filter_parser('isat205') TO s_detail1[1].b_isat205
            DISPLAY aisq320_filter_parser('isat206') TO s_detail1[1].b_isat206
            DISPLAY aisq320_filter_parser('isat207') TO s_detail1[1].b_isat207
            DISPLAY aisq320_filter_parser('isat204') TO s_detail1[1].b_isat204
            DISPLAY aisq320_filter_parser('isat006') TO s_detail1[1].b_isat006
            DISPLAY aisq320_filter_parser('isat201') TO s_detail1[1].b_isat201
            DISPLAY aisq320_filter_parser('isat202') TO s_detail1[1].b_isat202
            DISPLAY aisq320_filter_parser('isat203') TO s_detail1[1].b_isat203
            DISPLAY aisq320_filter_parser('isat005') TO s_detail1[1].b_isat005
            DISPLAY aisq320_filter_parser('isat022') TO s_detail1[1].b_isat022
            DISPLAY aisq320_filter_parser('isat113') TO s_detail1[1].b_isat113
            DISPLAY aisq320_filter_parser('isat114') TO s_detail1[1].b_isat114
            DISPLAY aisq320_filter_parser('isat115') TO s_detail1[1].b_isat115
            DISPLAY aisq320_filter_parser('isat020') TO s_detail1[1].b_isat020
            DISPLAY aisq320_filter_parser('isatdocno') TO s_detail1[1].b_isatdocno
            DISPLAY aisq320_filter_parser('isat013') TO s_detail1[1].b_isat013
            DISPLAY aisq320_filter_parser('isatcomp') TO s_detail1[1].b_isatcomp
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_isat001>>----
         #Ctrlp:construct.c.filter.page1.b_isat001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat001
            #add-point:ON ACTION controlp INFIELD b_isat001 name="construct.c.filter.page1.b_isat001"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isac001 = '",g_ooef019,"' "
            CALL q_isac002()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat001  #顯示到畫面上
            NEXT FIELD b_isat001                     #返回原欄位
            #END add-point
 
 
         #----<<isat001_desc>>----
         #----<<b_isat003>>----
         #----<<b_isat004>>----
         #Ctrlp:construct.c.filter.page1.b_isat004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat004
            #add-point:ON ACTION controlp INFIELD b_isat004 name="construct.c.filter.page1.b_isat004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isat004 IN (SELECT isat004 FROM isat_t               ",
                                   "              WHERE isatent = '",g_enterprise,"'      ",
                                   "                AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                AND isatsite = '",g_input.isatsite,"' ",
                                   "                AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'  ",
                                   "                AND isat002 = 'Y')                    " 
            CALL q_isat004()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat004  #顯示到畫面上
            NEXT FIELD b_isat004                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat014>>----
         #Ctrlp:construct.c.filter.page1.b_isat014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat014
            #add-point:ON ACTION controlp INFIELD b_isat014 name="construct.c.filter.page1.b_isat014"
            
            #END add-point
 
 
         #----<<b_isat025>>----
         #Ctrlp:construct.c.filter.page1.b_isat025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat025
            #add-point:ON ACTION controlp INFIELD b_isat025 name="construct.c.filter.page1.b_isat025"
            
            #END add-point
 
 
         #----<<b_isatseq>>----
         #Ctrlp:construct.c.filter.page1.b_isatseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatseq
            #add-point:ON ACTION controlp INFIELD b_isatseq name="construct.c.filter.page1.b_isatseq"
            
            #END add-point
 
 
         #----<<b_isat007>>----
         #Ctrlp:construct.c.filter.page1.b_isat007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat007
            #add-point:ON ACTION controlp INFIELD b_isat007 name="construct.c.filter.page1.b_isat007"
            
            #END add-point
 
 
         #----<<b_isat008>>----
         #----<<b_isat208>>----
         #Ctrlp:construct.c.filter.page1.b_isat208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat208
            #add-point:ON ACTION controlp INFIELD b_isat208 name="construct.c.filter.page1.b_isat208"
            
            #END add-point
 
 
         #----<<b_isat209>>----
         #Ctrlp:construct.c.filter.page1.b_isat209
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat209
            #add-point:ON ACTION controlp INFIELD b_isat209 name="construct.c.filter.page1.b_isat209"
            
            #END add-point
 
 
         #----<<b_isat012>>----
         #Ctrlp:construct.c.filter.page1.b_isat012
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat012
            #add-point:ON ACTION controlp INFIELD b_isat012 name="construct.c.filter.page1.b_isat012"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef002 IN (SELECT isat012 FROM isat_t               ",
                                   "              WHERE isatent = '",g_enterprise,"'      ",
                                   "                AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                AND isatsite = '",g_input.isatsite,"' ",
                                   "                AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'  ",
                                   "                AND isat002 = 'Y')                    " 
            CALL q_ooef001_02()                       #呼叫開窗
            DISPLAY g_qryparam.return2 TO b_isat012  #顯示到畫面上
            NEXT FIELD b_isat012                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat009>>----
         #Ctrlp:construct.c.filter.page1.b_isat009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat009
            #add-point:ON ACTION controlp INFIELD b_isat009 name="construct.c.filter.page1.b_isat009"
            
            #END add-point
 
 
         #----<<b_isat002>>----
         #Ctrlp:construct.c.filter.page1.b_isat002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat002
            #add-point:ON ACTION controlp INFIELD b_isat002 name="construct.c.filter.page1.b_isat002"
            
            #END add-point
 
 
         #----<<b_isat021>>----
         #Ctrlp:construct.c.filter.page1.b_isat021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat021
            #add-point:ON ACTION controlp INFIELD b_isat021 name="construct.c.filter.page1.b_isat021"
            
            #END add-point
 
 
         #----<<b_isat205>>----
         #Ctrlp:construct.c.filter.page1.b_isat205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat205
            #add-point:ON ACTION controlp INFIELD b_isat205 name="construct.c.filter.page1.b_isat205"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '3802'
            CALL q_oocq002()                  
            DISPLAY g_qryparam.return1 TO b_isat205  #顯示到畫面上
            NEXT FIELD b_isat205                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat206>>----
         #Ctrlp:construct.c.filter.page1.b_isat206
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat206
            #add-point:ON ACTION controlp INFIELD b_isat206 name="construct.c.filter.page1.b_isat206"
            
            #END add-point
 
 
         #----<<b_isat207>>----
         #Ctrlp:construct.c.filter.page1.b_isat207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat207
            #add-point:ON ACTION controlp INFIELD b_isat207 name="construct.c.filter.page1.b_isat207"
            
            #END add-point
 
 
         #----<<b_isat204>>----
         #Ctrlp:construct.c.filter.page1.b_isat204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat204
            #add-point:ON ACTION controlp INFIELD b_isat204 name="construct.c.filter.page1.b_isat204"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE  
            LET g_qryparam.arg1 = '3801'            
            CALL q_oocq002()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isat204  #顯示到畫面上
            NEXT FIELD b_isat204                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat006>>----
         #Ctrlp:construct.c.filter.page1.b_isat006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat006
            #add-point:ON ACTION controlp INFIELD b_isat006 name="construct.c.filter.page1.b_isat006"
            
            #END add-point
 
 
         #----<<b_isat201>>----
         #Ctrlp:construct.c.filter.page1.b_isat201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat201
            #add-point:ON ACTION controlp INFIELD b_isat201 name="construct.c.filter.page1.b_isat201"
            
            #END add-point
 
 
         #----<<b_isat202>>----
         #Ctrlp:construct.c.filter.page1.b_isat202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat202
            #add-point:ON ACTION controlp INFIELD b_isat202 name="construct.c.filter.page1.b_isat202"
            
            #END add-point
 
 
         #----<<b_isat203>>----
         #Ctrlp:construct.c.filter.page1.b_isat203
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat203
            #add-point:ON ACTION controlp INFIELD b_isat203 name="construct.c.filter.page1.b_isat203"
            
            #END add-point
 
 
         #----<<b_isat005>>----
         #Ctrlp:construct.c.filter.page1.b_isat005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat005
            #add-point:ON ACTION controlp INFIELD b_isat005 name="construct.c.filter.page1.b_isat005"
            
            #END add-point
 
 
         #----<<b_isat022>>----
         #Ctrlp:construct.c.filter.page1.b_isat022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat022
            #add-point:ON ACTION controlp INFIELD b_isat022 name="construct.c.filter.page1.b_isat022"
            
            #END add-point
 
 
         #----<<b_isat113>>----
         #Ctrlp:construct.c.filter.page1.b_isat113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat113
            #add-point:ON ACTION controlp INFIELD b_isat113 name="construct.c.filter.page1.b_isat113"
            
            #END add-point
 
 
         #----<<b_isat114>>----
         #Ctrlp:construct.c.filter.page1.b_isat114
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat114
            #add-point:ON ACTION controlp INFIELD b_isat114 name="construct.c.filter.page1.b_isat114"
            
            #END add-point
 
 
         #----<<b_isat115>>----
         #Ctrlp:construct.c.filter.page1.b_isat115
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat115
            #add-point:ON ACTION controlp INFIELD b_isat115 name="construct.c.filter.page1.b_isat115"
            
            #END add-point
 
 
         #----<<b_isat020>>----
         #Ctrlp:construct.c.filter.page1.b_isat020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat020
            #add-point:ON ACTION controlp INFIELD b_isat020 name="construct.c.filter.page1.b_isat020"
            
            #END add-point
 
 
         #----<<b_isatdocno>>----
         #Ctrlp:construct.c.filter.page1.b_isatdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatdocno
            #add-point:ON ACTION controlp INFIELD b_isatdocno name="construct.c.filter.page1.b_isatdocno"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " isatdocno IN (SELECT isatdocno FROM isat_t               ",
                                   "                WHERE isatent = '",g_enterprise,"'      ",
                                   "                  AND isatcomp = '",g_input.isatcomp,"' ",
                                   "                  AND isatsite = '",g_input.isatsite,"' ",
                                   "                  AND isat007 BETWEEN '",g_input.isat007s,"' AND '",g_input.isat007e,"'  ",
                                   "                  AND isat002 = 'Y')                    " 
            CALL q_isat003_2()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_isatdocno  #顯示到畫面上
            NEXT FIELD b_isatdocno                     #返回原欄位
            #END add-point
 
 
         #----<<b_isat013>>----
         #Ctrlp:construct.c.filter.page1.b_isat013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isat013
            #add-point:ON ACTION controlp INFIELD b_isat013 name="construct.c.filter.page1.b_isat013"
            
            #END add-point
 
 
         #----<<b_isatcomp>>----
         #Ctrlp:construct.c.filter.page1.b_isatcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_isatcomp
            #add-point:ON ACTION controlp INFIELD b_isatcomp name="construct.c.filter.page1.b_isatcomp"
            
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
   
      CALL aisq320_filter_show('isat001','b_isat001')
   CALL aisq320_filter_show('isat004','b_isat004')
   CALL aisq320_filter_show('isat014','b_isat014')
   CALL aisq320_filter_show('isat025','b_isat025')
   CALL aisq320_filter_show('isatseq','b_isatseq')
   CALL aisq320_filter_show('isat007','b_isat007')
   CALL aisq320_filter_show('isat208','b_isat208')
   CALL aisq320_filter_show('isat209','b_isat209')
   CALL aisq320_filter_show('isat012','b_isat012')
   CALL aisq320_filter_show('isat009','b_isat009')
   CALL aisq320_filter_show('isat002','b_isat002')
   CALL aisq320_filter_show('isat021','b_isat021')
   CALL aisq320_filter_show('isat205','b_isat205')
   CALL aisq320_filter_show('isat206','b_isat206')
   CALL aisq320_filter_show('isat207','b_isat207')
   CALL aisq320_filter_show('isat204','b_isat204')
   CALL aisq320_filter_show('isat006','b_isat006')
   CALL aisq320_filter_show('isat201','b_isat201')
   CALL aisq320_filter_show('isat202','b_isat202')
   CALL aisq320_filter_show('isat203','b_isat203')
   CALL aisq320_filter_show('isat005','b_isat005')
   CALL aisq320_filter_show('isat022','b_isat022')
   CALL aisq320_filter_show('isat113','b_isat113')
   CALL aisq320_filter_show('isat114','b_isat114')
   CALL aisq320_filter_show('isat115','b_isat115')
   CALL aisq320_filter_show('isat020','b_isat020')
   CALL aisq320_filter_show('isatdocno','b_isatdocno')
   CALL aisq320_filter_show('isat013','b_isat013')
   CALL aisq320_filter_show('isatcomp','b_isatcomp')
 
    
   CALL aisq320_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aisq320_filter_parser(ps_field)
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
 
{<section id="aisq320.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aisq320_filter_show(ps_field,ps_object)
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
   LET ls_condition = aisq320_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.insert" >}
#+ insert
PRIVATE FUNCTION aisq320_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq320.modify" >}
#+ modify
PRIVATE FUNCTION aisq320_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aisq320_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.delete" >}
#+ delete
PRIVATE FUNCTION aisq320_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aisq320.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aisq320_detail_action_trans()
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
 
{<section id="aisq320.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aisq320_detail_index_setting()
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
            IF g_isat_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_isat_d.getLength() AND g_isat_d.getLength() > 0
            LET g_detail_idx = g_isat_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_isat_d.getLength() THEN
               LET g_detail_idx = g_isat_d.getLength()
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
 
{<section id="aisq320.mask_functions" >}
 &include "erp/ais/aisq320_mask.4gl"
 
{</section>}
 
{<section id="aisq320.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aisq320_default()
# Date & Author..: 2016/01/14 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq320_default()
   
   LET g_input.isatcomp = ''
   LET g_input.isatsite = ''
   LET g_input.isat007s = g_today
   LET g_input.isat007e = g_today
   DISPLAY g_input.isat007s,g_input.isat007e
   
   #161006-00005#26 add ------
   CALL s_fin_account_center_sons_query('3',g_site,g_today,'')
   CALL s_fin_account_center_comp_str() RETURNING g_wc_isatcomp
   CALL s_fin_get_wc_str(g_wc_isatcomp) RETURNING g_wc_isatcomp
   #161006-00005#26 add end---
   
END FUNCTION

################################################################################
# Descriptions...: 法人檢核
# Memo...........:
# Usage..........: CALL aisq320_isatcomp_chk(p_isatcomp)
# Date & Author..: 2016/01/14 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq320_isat_chk(p_isatcomp,p_isatsite)
DEFINE l_count        LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE r_errno        LIKE gzze_t.gzze001
DEFINE p_isatcomp     LIKE isat_t.isatcomp
DEFINE p_isatsite     LIKE isat_t.isatsite

   LET r_success =TRUE 

   IF NOT cl_null(p_isatcomp) THEN   
      LET l_count = 0   
      SELECT COUNT(*) INTO l_count 
        FROM  ooef_t 
       WHERE  ooefent = g_enterprise  AND ooefstus = 'Y'  AND ooef003 = 'Y'
         AND  ooef001 = p_isatcomp
         AND  ooef001 IN (SELECT DISTINCT isaosite FROM isao_t                
                            WHERE isaoent = g_enterprise AND isao017 = 'Y' )
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00261'
         RETURN r_success,r_errno
      END IF 
   END IF
   

   IF NOT cl_null(p_isatsite) THEN   
      LET l_count = 0
      SELECT COUNT(*) INTO l_count 
        FROM  ooef_t 
       WHERE  ooefent = g_enterprise  AND ooefstus = 'Y'
         AND  ooef001 = p_isatsite       
         AND  ooef001 IN (SELECT DISTINCT isaosite FROM isao_t                
                            WHERE isaoent = g_enterprise AND isao017 = 'Y' 
                              #AND isaosite IN ( SELECT ooef001 FROM ooef_t WHERE ooef017 = p_isatcomp  ) )                           #160905-00002#4 mark
                              AND isaosite IN ( SELECT ooef001 FROM ooef_t WHERE ooefent = g_enterprise AND ooef017 = p_isatcomp  ) ) #160905-00002#4 add
      IF cl_null(l_count) THEN LET l_count = 0 END IF
      
      IF l_count = 0 THEN
         LET r_success = FALSE
         LET r_errno = 'ais-00262'
         RETURN r_success,r_errno
      END IF 
   END IF
   
   
   RETURN r_success,r_errno

   



END FUNCTION

################################################################################
# Descriptions...: 用"發票編碼方式"決定是否隱藏"發票代碼"
# Memo...........:
# Usage..........: CALL set_entry_invoice_code()
# Date & Author..: 2016/01/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq320_set_entry_invoice_code()

   SELECT isai002 INTO g_isai002
     FROM ooef_t
     LEFT JOIN isai_t ON ooefent = isaient AND ooef019 = isai001
    WHERE ooefent = g_enterprise
      AND ooef001 = g_input.isatcomp
   
   CALL cl_set_comp_visible('b_isat003',TRUE)
   IF g_isai002 <> '2' THEN
      CALL cl_set_comp_visible('b_isat003',FALSE)
   END IF


END FUNCTION

################################################################################
# Descriptions...: 創建臨時擋
# Memo...........:
# Usage..........: CALL aisq320_create_tmp()
# Date & Author..: 2016/01/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq320_create_tmp()

   DROP TABLE aisq320_tmp01;             #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
      CREATE TEMP TABLE aisq320_tmp01 (  #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
         isat001      LIKE isat_t.isat001, 
         isat001_desc LIKE type_t.chr100,
         isat003 LIKE isat_t.isat003, 
         isat004 LIKE isat_t.isat004, 
         l_isat014 LIKE type_t.chr100, 
         l_isat025 LIKE type_t.chr100, 
         isatseq LIKE isat_t.isatseq, 
         isat007 LIKE isat_t.isat007, 
         isat008 DATETIME YEAR TO FRACTION(5), 
         l_isat208 LIKE type_t.chr100, 
         isat209 LIKE isat_t.isat209, 
         isat012 LIKE type_t.chr500, 
         isat009 LIKE isat_t.isat009, 
         isat002 LIKE isat_t.isat002, 
         isat021 LIKE isat_t.isat021, 
         isat205 LIKE isat_t.isat205, 
         isat206 LIKE isat_t.isat206, 
         isat207 LIKE isat_t.isat207, 
         isat204 LIKE isat_t.isat204, 
         isat006 LIKE isat_t.isat006, 
         isat201 LIKE isat_t.isat201, 
         isat202 LIKE isat_t.isat202, 
         isat203 LIKE isat_t.isat203, 
         isat005 LIKE isat_t.isat005, 
         l_isat022 LIKE type_t.chr500, 
         isat113 LIKE isat_t.isat113, 
         isat114 LIKE isat_t.isat114, 
         isat115 LIKE isat_t.isat115, 
         isat020 LIKE isat_t.isat020, 
         isatdocno LIKE isat_t.isatdocno, 
         isat013 LIKE isat_t.isat013, 
         l_isatcomp_desc LIKE type_t.chr500,
         l_isatsite_desc LIKE type_t.chr500,
         l_isat007s      LIKE isat_t.isat007,
         l_isat007e      LIKE isat_t.isat007,         
         isatcomp        LIKE isat_t.isatcomp,
         isatsite        LIKE isat_t.isatsite,
         isatent         LIKE isat_t.isatent         
                 )


END FUNCTION

################################################################################
# Descriptions...: ins aisq510_print_tmp
# Memo...........:
# Usage..........: CALL aisq320_print()
# Date & Author..: 2016/01/15 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION aisq320_print()
DEFINE l_i LIKE type_t.num5
DEFINE l_isatcomp_desc  LIKE type_t.chr500
DEFINE l_isatsite_desc  LIKE type_t.chr500
DEFINE l_isat022_desc   LIKE type_t.chr500
DEFINE l_isat014_desc   LIKE type_t.chr100
DEFINE l_isat025_desc   LIKE type_t.chr100
DEFINE l_isat208_desc   LIKE type_t.chr100
 
   LET l_isatcomp_desc = g_input.isatcomp,':',g_input.isatcomp_desc
   LET l_isatsite_desc = g_input.isatsite,':',g_input.isatsite_desc

  

  DELETE FROM aisq320_tmp01             #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
  FOR l_i = 1 TO g_isat_d.getLength()
    IF NOT cl_null(g_isat_d[l_i].isat022) THEN 
       LET l_isat022_desc = g_isat_d[l_i].isat022,':',s_desc_gzcbl004_desc('9708',g_isat_d[l_i].isat022)
    END IF
    IF NOT cl_null(g_isat_d[l_i].isat014) THEN 
       LET l_isat014_desc = g_isat_d[l_i].isat014,':',s_desc_gzcbl004_desc('9716',g_isat_d[l_i].isat014)
    END IF
    IF NOT cl_null(g_isat_d[l_i].isat025) THEN 
       LET l_isat025_desc = g_isat_d[l_i].isat025,':',s_desc_gzcbl004_desc('9716',g_isat_d[l_i].isat025)
    END IF
    IF NOT cl_null(g_isat_d[l_i].isat208) THEN 
       LET l_isat208_desc = g_isat_d[l_i].isat208,':',s_desc_gzcbl004_desc('9754',g_isat_d[l_i].isat208)
    END IF
    INSERT INTO aisq320_tmp01           #160727-00019#10 Mod   aisq320_print_tmp -->aisq320_tmp01
    VALUES( g_isat_d[l_i].isat001,g_isat_d[l_i].isat001_desc,g_isat_d[l_i].isat003,g_isat_d[l_i].isat004,l_isat014_desc, 
     l_isat025_desc,g_isat_d[l_i].isatseq,g_isat_d[l_i].isat007,g_isat_d[l_i].isat008,l_isat208_desc, 
     g_isat_d[l_i].isat209,g_isat_d[l_i].isat012,g_isat_d[l_i].isat009,g_isat_d[l_i].isat002,g_isat_d[l_i].isat021, 
     g_isat_d[l_i].isat205,g_isat_d[l_i].isat206,g_isat_d[l_i].isat207,g_isat_d[l_i].isat204,g_isat_d[l_i].isat006, 
     g_isat_d[l_i].isat201,g_isat_d[l_i].isat202,g_isat_d[l_i].isat203,g_isat_d[l_i].isat005,l_isat022_desc, 
     g_isat_d[l_i].isat113,g_isat_d[l_i].isat114,g_isat_d[l_i].isat115,g_isat_d[l_i].isat020,g_isat_d[l_i].isatdocno, 
     g_isat_d[l_i].isat013,l_isatcomp_desc,l_isatsite_desc,g_input.isat007s,g_input.isat007e,
     g_isat_d[l_i].isatcomp,g_input.isatsite,g_enterprise)
    
  END FOR



END FUNCTION

 
{</section>}
 
