#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq111.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-09-17 14:48:55), PR版次:0003(2016-09-08 16:18:08)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000040
#+ Filename...: adeq111
#+ Description: 部門商品實時銷售與庫存查詢
#+ Creator....: 06815(2015-09-16 18:21:54)
#+ Modifier...: 06815 -SD/PR- 00700
 
{</section>}
 
{<section id="adeq111.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160908-00032#1   2016/09/08 by rainy       q_pmaa001()開窗加上條件pmaa002='1' or '3'
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
PRIVATE TYPE type_g_rtjb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   rtjasite LIKE rtja_t.rtjasite, 
   rtjasite_desc LIKE type_t.chr500, 
   rtaw001 LIKE rtaw_t.rtaw001, 
   rtaw001_desc LIKE type_t.chr500, 
   imaa101 LIKE imaa_t.imaa101, 
   imaa101_desc LIKE type_t.chr500, 
   rtjb003 LIKE rtjb_t.rtjb003, 
   rtjb004 LIKE rtjb_t.rtjb004, 
   imaal003 LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   l_rtdx003 LIKE type_t.chr10, 
   rtjb010 LIKE rtjb_t.rtjb010, 
   l_scount LIKE type_t.num15_3, 
   rtjb013 LIKE rtjb_t.rtjb013, 
   rtjb013_desc LIKE type_t.chr500, 
   l_sell LIKE type_t.num20_6, 
   l_account LIKE type_t.num20_6, 
   rtjbdocno LIKE rtjb_t.rtjbdocno, 
   rtjbseq LIKE rtjb_t.rtjbseq 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_str              STRING
DEFINE g_wc_a             STRING #add by guomy 2015/8/18 for 增加经营方式
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtjb_d
DEFINE g_master_t                   type_g_rtjb_d
DEFINE g_rtjb_d          DYNAMIC ARRAY OF type_g_rtjb_d
DEFINE g_rtjb_d_t        type_g_rtjb_d
 
      
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
 
{<section id="adeq111.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
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
   DECLARE adeq111_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq111_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq111_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq111 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq111_init()   
 
      #進入選單 Menu (="N")
      CALL adeq111_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq111
      
   END IF 
   
   CLOSE adeq111_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq111.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION adeq111_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('imaa109','2004')
   CALL cl_set_combo_scc('b_imaa109','2004')
   CALL cl_get_para(g_enterprise,'','E-CIR-0001') RETURNING l_str
   CALL cl_set_combo_scc('l_rtdx003','6013')  #經營方式
   CALL s_aooi500_create_temp() RETURNING l_success
   #end add-point
 
   CALL adeq111_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="adeq111.default_search" >}
PRIVATE FUNCTION adeq111_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtjbseq = '", g_argv[02], "' AND "
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
 
{<section id="adeq111.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION adeq111_ui_dialog()
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
      CALL adeq111_b_fill()
   ELSE
      CALL adeq111_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtjb_d.clear()
 
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
 
         CALL adeq111_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtjb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq111_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL adeq111_detail_action_trans()
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
            CALL adeq111_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)  
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL adeq111_insert()
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
               CALL adeq111_query()
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
            CALL adeq111_filter()
            #add-point:ON ACTION filter name="menu.filter"
            EXIT DIALOG
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
            CALL adeq111_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtjb_d)
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
            CALL adeq111_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq111_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq111_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq111_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               LET g_rtjb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               LET g_rtjb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtjb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtjb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtjb_d[li_idx].sel = "N"
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
 
{<section id="adeq111.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION adeq111_query()
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
   CALL g_rtjb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON rtjasite,rtaw001,imaa101,rtjb003,rtjb004,rtjb010,rtjb013,rtjbdocno,rtjbseq 
 
           FROM s_detail1[1].b_rtjasite,s_detail1[1].b_rtaw001,s_detail1[1].b_imaa101,s_detail1[1].b_rtjb003, 
               s_detail1[1].b_rtjb004,s_detail1[1].b_rtjb010,s_detail1[1].b_rtjb013,s_detail1[1].b_rtjbdocno, 
               s_detail1[1].b_rtjbseq
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            DISPLAY g_site TO b_rtjasite
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjasite
            #add-point:ON ACTION controlp INFIELD b_rtjasite name="construct.c.page1.b_rtjasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c') 
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjasite  #顯示到畫面上
            NEXT FIELD b_rtjasite                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjasite
            #add-point:BEFORE FIELD b_rtjasite name="construct.b.page1.b_rtjasite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjasite
            
            #add-point:AFTER FIELD b_rtjasite name="construct.a.page1.b_rtjasite"
            
            #END add-point
            
 
 
         #----<<b_rtjasite_desc>>----
         #----<<b_rtaw001>>----
         #Ctrlp:construct.c.page1.b_rtaw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaw001
            #add-point:ON ACTION controlp INFIELD b_rtaw001 name="construct.c.page1.b_rtaw001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,'','E-CIR-0001') 
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtaw001  #顯示到畫面上
            NEXT FIELD b_rtaw001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtaw001
            #add-point:BEFORE FIELD b_rtaw001 name="construct.b.page1.b_rtaw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtaw001
            
            #add-point:AFTER FIELD b_rtaw001 name="construct.a.page1.b_rtaw001"
            
            #END add-point
            
 
 
         #----<<b_rtaw001_desc>>----
         #----<<b_imaa101>>----
         #Ctrlp:construct.c.page1.b_imaa101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa101
            #add-point:ON ACTION controlp INFIELD b_imaa101 name="construct.c.page1.b_imaa101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa101  #顯示到畫面上
            NEXT FIELD b_imaa101                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_imaa101
            #add-point:BEFORE FIELD b_imaa101 name="construct.b.page1.b_imaa101"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_imaa101
            
            #add-point:AFTER FIELD b_imaa101 name="construct.a.page1.b_imaa101"
            
            #END add-point
            
 
 
         #----<<b_imaa101_desc>>----
         #----<<b_rtjb003>>----
         #Ctrlp:construct.c.page1.b_rtjb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb003
            #add-point:ON ACTION controlp INFIELD b_rtjb003 name="construct.c.page1.b_rtjb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb003  #顯示到畫面上
            NEXT FIELD b_rtjb003                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb003
            #add-point:BEFORE FIELD b_rtjb003 name="construct.b.page1.b_rtjb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb003
            
            #add-point:AFTER FIELD b_rtjb003 name="construct.a.page1.b_rtjb003"
            
            #END add-point
            
 
 
         #----<<b_rtjb004>>----
         #Ctrlp:construct.c.page1.b_rtjb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb004
            #add-point:ON ACTION controlp INFIELD b_rtjb004 name="construct.c.page1.b_rtjb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb004  #顯示到畫面上
            NEXT FIELD b_rtjb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb004
            #add-point:BEFORE FIELD b_rtjb004 name="construct.b.page1.b_rtjb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb004
            
            #add-point:AFTER FIELD b_rtjb004 name="construct.a.page1.b_rtjb004"
            
            #END add-point
            
 
 
         #----<<b_imaal003>>----
         #----<<b_imaal004>>----
         #----<<l_rtdx003>>----
         #----<<b_rtjb010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb010
            #add-point:BEFORE FIELD b_rtjb010 name="construct.b.page1.b_rtjb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb010
            
            #add-point:AFTER FIELD b_rtjb010 name="construct.a.page1.b_rtjb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb010
            #add-point:ON ACTION controlp INFIELD b_rtjb010 name="construct.c.page1.b_rtjb010"
            
            #END add-point
 
 
         #----<<l_scount>>----
         #----<<b_rtjb013>>----
         #Ctrlp:construct.c.page1.b_rtjb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb013
            #add-point:ON ACTION controlp INFIELD b_rtjb013 name="construct.c.page1.b_rtjb013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb013  #顯示到畫面上
            NEXT FIELD b_rtjb013                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjb013
            #add-point:BEFORE FIELD b_rtjb013 name="construct.b.page1.b_rtjb013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjb013
            
            #add-point:AFTER FIELD b_rtjb013 name="construct.a.page1.b_rtjb013"
            
            #END add-point
            
 
 
         #----<<b_rtjb013_desc>>----
         #----<<l_sell>>----
         #----<<l_account>>----
         #----<<b_rtjbdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjbdocno
            #add-point:BEFORE FIELD b_rtjbdocno name="construct.b.page1.b_rtjbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjbdocno
            
            #add-point:AFTER FIELD b_rtjbdocno name="construct.a.page1.b_rtjbdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbdocno
            #add-point:ON ACTION controlp INFIELD b_rtjbdocno name="construct.c.page1.b_rtjbdocno"
            
            #END add-point
 
 
         #----<<b_rtjbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjbseq
            #add-point:BEFORE FIELD b_rtjbseq name="construct.b.page1.b_rtjbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjbseq
            
            #add-point:AFTER FIELD b_rtjbseq name="construct.a.page1.b_rtjbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbseq
            #add-point:ON ACTION controlp INFIELD b_rtjbseq name="construct.c.page1.b_rtjbseq"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT BY NAME g_wc_a ON l_rtdx003 #add by guomy 2015/8/18
      END CONSTRUCT
      
      BEFORE DIALOG
         LET g_rtjb_d[1].sel = ' '
         DISPLAY ARRAY g_rtjb_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
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
   CALL adeq111_b_fill()
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
 
{<section id="adeq111.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq111_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_account1      LIKE inag_t.inag008
   DEFINE l_account2      LIKE inag_t.inag008
                         
   DEFINE l_kind          LIKE rtaw_t.rtaw001
   DEFINE l_account       LIKE inag_t.inag008
   DEFINE l_busi_date     LIKE type_t.dat     #系统营业日期
   DEFINE l_imaa004       LIKE imaa_t.imaa004 # add by yuhl 2015/08/22
   DEFINE l_where         STRING
   DEFINE l_sql           STRING              #150911-00001#1 15/10/01 s983961--ADD b_fill段資料填充
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #系统营业日期
   CALL cl_get_para(g_enterprise,g_site,'S-CIR-0003') RETURNING l_busi_date
   CALL s_aooi500_sql_where(g_prog,'rtjbsite') RETURNING l_where
   
    #ADD BY GUOMY 2015/8/18   start-----
    IF cl_null(g_wc_a) THEN 
       LET g_wc_a="1=1"
    ELSE 
       LET g_wc_a = cl_replace_str(g_wc_a,"l_rtdx003","rtdx003") 
       LET g_wc = g_wc, " AND ",g_wc_a
    END IF 
    #ADD BY GUOMY 2015/8/18   end -----

#   IF cl_null(g_wc_a) THEN 
#      LET g_wc_a="1=1"
#   ELSE 
#      LET g_wc_a = cl_replace_str(g_wc_a,"l_rtdx003","stfa003") 
#      LET g_wc = g_wc, " AND ",g_wc_a
#   END IF   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','',rtjb003,rtjb004,'','','',rtjb010,'',rtjb013, 
       '','','',rtjbdocno,rtjbseq  ,DENSE_RANK() OVER( ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq) AS RANK FROM rtjb_t", 
 
 
 
                     "",
                     " WHERE rtjbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtjb_t"),
                     " ORDER BY rtjb_t.rtjbdocno,rtjb_t.rtjbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150911-00001#1 20150924 s983961--mark and mod(s) 效能調整
   #ADDED BY LANJJ 2015-09-07   
   #LET ls_sql_rank =" SELECT RTJBSITE,OOEFL003,RTAW001,IMAA101,PMAAL003,RTJB004, ",
   #                    "        RTJB003,IMAAL003,IMAAL004,STFA003,RTJB013, ",
   #                    "        DECODE(SUM(RTJB014), 0, 0, SUM(RTJB031) / SUM(RTJB014)) RTJB010, ",
   #                    "        SUM(RTJB014) L_SCOUNT, ",
   #                    "        SUM(RTJB031) L_SELL, ",
   #                    "        DENSE_RANK() OVER( ORDER BY rtjbsite,rtaw001,rtjb004) AS RANK ",
   #                    " FROM rtja_t,rtjb_t  ",
   #                    "       LEFT JOIN stfa_t ON rtjbent = stfaent AND rtjb028 = stfa005 AND stfastus = 'Y' AND stfa004 = '3' ",
   #                    "       LEFT JOIN ooefl_t ON ooeflent = rtjbent AND ooefl001 = rtjbsite AND ooefl002 = '",g_dlang,"' ",
   #                    "       LEFT JOIN imaa_t ON rtjbent = imaaent AND rtjb004 = imaa001  ",
   #                    "       LEFT JOIN rtaw_t ON rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"'  ",
   #                    "       LEFT JOIN pmaal_t ON imaaent = pmaalent AND imaa101 = pmaal001 AND pmaal002 = '",g_dlang,"' ",
   #                    "       LEFT JOIN imaal_t ON imaaent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"' ",
   #                    " WHERE rtjaent = rtjbent AND rtjadocno = rtjbdocno ",
   #                    "   AND rtjadocdt = TO_DATE('",l_busi_date,"', 'YY/MM/DD')   ",
   #                    "   AND rtjbent= ? ",
   #                    "   AND ", ls_wc,
   #                    " GROUP BY RTJBSITE,OOEFL003,RTAW001,IMAA101,PMAAL003,RTJB004,RTJB003,IMAAL003,IMAAL004,STFA003,RTJB013,RTJB010   "
   # 
   #LET ls_wc = ls_wc CLIPPED," AND ",l_where    
                    
   LET ls_sql_rank =" SELECT  'N',rtjbsite, ",
                    "         (SELECT ooefl003 FROM ooefl_t ",
                    "           WHERE ooeflent=rtjbent AND ooefl001=rtjbsite  ",
                    "             AND ooefl002='"||g_dlang||"') rtjbsite_desc,",
                    "         rtaw001, ",
                    "         (SELECT rtaxl003 FROM rtaxl_t ",
                    "           WHERE rtaxlent=rtjbent AND rtaxl001=rtaw001  ",
                    "             AND rtaxl002='"||g_dlang||"') rtaw001_desc,",
                    "         imaa101, ",
                    "         (SELECT pmaal003 FROM pmaal_t ",
                    "           WHERE pmaalent = rtjbent AND pmaal001 = imaa101 AND pmaal002 = '"||g_dlang||"') imaa101_desc, ",
                    "         rtjb003,rtjb004,imaal003,imaal004, ", #商品明細
                    #"         stfa003, ", #經營方式  #Marked by lanjj 2015-12-15 150706-00010#4
                    "         rtdx003, ", #經營方式   #Aded by lanjj 2015-12-15 150706-00010#4 经营方式抓值改变
                    "         rtjb010, ", #交易價          
                    "         l_scount, ",#銷售數量
                    "         rtjb013, ",
                    "         (SELECT oocal003 FROM oocal_t ",
                    "           WHERE oocalent = rtjbent AND oocal001 = rtjb013  ",
                    "             AND oocal002 = '"||g_dlang||"') rtjb013_desc,",
                    "         l_sell, ", #實際銷售額
                    "         (SELECT SUM(inag008) FROM inag_t",  #2015/10/07
                    "           WHERE inagent = rtjbent AND inagsite = rtjbsite AND inag001 = rtjb004) l_account,imaa004,",  #2015/10/07
                    "  DENSE_RANK() OVER( ORDER BY rtjbsite,rtaw001,rtjb004) AS RANK ",
                    "   FROM  (SELECT 'N',rtjbsite,rtaw001, ",
                    "                  imaa101, ",
                    "                  rtjb003, ",
                    "                  rtjb004, ",
                    #"                  stfa003, ", #Marked by lanjj 2015-12-15 150706-00010#4
                    "                  rtdx003, ",  #Aded by lanjj 2015-12-15 150706-00010#4 经营方式抓值改变
                    "                  CASE WHEN SUM(rtjb012) = 0 THEN 0 ELSE SUM(RTJB031)/SUM(rtjb012) END AS rtjb010, ", #交易價          
                    "                  SUM(rtjb012) l_scount, ",#銷售數量
                    "                  rtjb013, ", #單位
                    "                  SUM(rtjb031) l_sell, ", #實際銷售額
                    "                  imaa004,",  #2015/10/07
                    "                  rtjbent ",  #串說明條件
                    "            FROM rtjb_t  ",
                    #"            LEFT JOIN stfa_t ON rtjbent = stfaent AND rtjb028 = stfa005 AND stfastus = 'Y' AND stfa004 = '3' ",       #Marked by lanjj 2015-12-15 150706-00010#4
                    "             LEFT JOIN RTDX_T on rtdxent = rtjbent and rtdxsite = rtjbsite and rtdx001 = rtjb004 and rtdxstus = 'Y' ", #Aded by lanjj 2015-12-15 150706-00010#4 经营方式抓值改变
                    "                ,imaa_t,rtaw_t,rtja_t ",              
                    "           WHERE rtjaent = rtjbent AND rtjadocno = rtjbdocno ",
                    "             AND imaaent = rtjbent AND imaa001 = rtjb004 ",
                    "             AND rtawent = imaaent AND rtaw002 = imaa009 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"'  ",
                    "             AND rtjadocdt = '",l_busi_date,"'  ",#當前營業日
                    "             AND rtjbent= ? ",
                    "             AND ", ls_wc," ", 
                    #"           GROUP BY rtjbsite,rtaw001,imaa101,rtjb003,rtjb004,stfa003,rtjb010,rtjb013,rtjbent) " ,
                    "           GROUP BY rtjbsite,rtaw001,imaa101,rtjb003,rtjb004,rtdx003,rtjb010,rtjb013,imaa004,rtjbent) " ,   #2015/10/07                   
                    "   LEFT JOIN imaal_t ON imaalent = rtjbent AND imaal001 = rtjb004 AND imaal002 = '",g_dlang,"' "   
   #150911-00001#1 20150924 s983961--mark and mod(e) 效能調整                                     
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   LET g_pagestart = 0
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
 
   LET g_sql = "SELECT '','','','','','','',rtjb003,rtjb004,'','','',rtjb010,'',rtjb013,'','','',rtjbdocno, 
       rtjbseq",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   #LET g_sql = " SELECT 'N',rtjbsite,ooefl003,rtaw001,'',imaa101,pmaal003,rtjb003, ",
   #            "        rtjb004,imaal003,imaal004,rtjb010, ",
   #            "        l_scount,rtjb013,'',l_sell,'','','' ",
   #            "  FROM (",ls_sql_rank,")"#,
   #            #" WHERE RANK >= ",g_pagestart,
   #            #"   AND RANK < ",g_pagestart + g_num_in_page     #客户要求取消翻页

   LET g_sql = " SELECT 'N',rtjbsite,rtjbsite_desc, ",
               "        rtaw001,rtaw001_desc, ",
               "        imaa101,imaa101_desc, ",
               "        rtjb003,rtjb004,imaal003,imaal004, ",
               "        rtdx003,rtjb010,l_scount, ",
               #"        rtjb013,rtjb013_desc,l_sell,'','','' ",
               "        rtjb013,rtjb013_desc,l_sell,(CASE imaa004 WHEN 'E' THEN 0 ELSE l_account-l_scount END),'','' ",  #2015/10/07
               "  FROM (",ls_sql_rank,")"#,
               #" WHERE RANK >= ",g_pagestart,
               #"   AND RANK < ",g_pagestart + g_num_in_page     #客户要求取消翻页
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq111_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq111_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtjb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #150911-00001#1 15/10/01 s983961-add(s)
   #LET l_sql = "SELECT COALESCE(SUM(inag008),0) - ?",
   #            "  FROM inag_t",
   #            " WHERE inagent = ",g_enterprise,
   #            "   AND inagsite = ?",
   #            "   AND inag001 = ?"
   #PREPARE adeq216_sum_inag008 FROM l_sql   
   #
   #LET l_sql = "SELECT imaa004 ",
   #            "  FROM imaa_t ",
   #            " WHERE imaaent=",g_enterprise,
   #            "   AND imaa001= ? "
   #PREPARE adeq216_l_imaa004 FROM l_sql  
   #150911-00001#1 15/10/01 s983961-add(e) 
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_rtjb_d[l_ac].sel,g_rtjb_d[l_ac].rtjasite,g_rtjb_d[l_ac].rtjasite_desc, 
       g_rtjb_d[l_ac].rtaw001,g_rtjb_d[l_ac].rtaw001_desc,g_rtjb_d[l_ac].imaa101,g_rtjb_d[l_ac].imaa101_desc, 
       g_rtjb_d[l_ac].rtjb003,g_rtjb_d[l_ac].rtjb004,g_rtjb_d[l_ac].imaal003,g_rtjb_d[l_ac].imaal004, 
       g_rtjb_d[l_ac].l_rtdx003,g_rtjb_d[l_ac].rtjb010,g_rtjb_d[l_ac].l_scount,g_rtjb_d[l_ac].rtjb013, 
       g_rtjb_d[l_ac].rtjb013_desc,g_rtjb_d[l_ac].l_sell,g_rtjb_d[l_ac].l_account,g_rtjb_d[l_ac].rtjbdocno, 
       g_rtjb_d[l_ac].rtjbseq
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_rtjb_d[l_ac].statepic = cl_get_actipic(g_rtjb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #150911-00001#1 15/10/01 s983961-MARK & MOD(s)
      ##150718 by lori add---(S)
      #SELECT COALESCE(SUM(inag008),0) - g_rtjb_d[l_ac].l_scount
      #  INTO g_rtjb_d[l_ac].l_account #實際庫存數量
      #  FROM inag_t
      # WHERE inagent = g_enterprise 
      #   AND inagsite = g_rtjb_d[l_ac].rtjasite
      #   AND inag001 = g_rtjb_d[l_ac].rtjb004  
      ##150718 by lori add---(E)
      #EXECUTE adeq216_sum_inag008 USING g_rtjb_d[l_ac].l_scount,g_rtjb_d[l_ac].rtjasite,g_rtjb_d[l_ac].rtjb004
      #   INTO g_rtjb_d[l_ac].l_account
         
      # add by yuhl 2015/08/22 (S)        
      #150911-00001#1 s983961--mark(s)回歸標準
      #IF g_rtjb_d[l_ac].l_rtdx003='A' OR g_rtjb_d[l_ac].l_rtdx003='B' THEN
      #   LET g_rtjb_d[l_ac].l_account=0
      #END IF
      #150911-00001#1 s983961--mark(e)回歸標準      
      
      #LET l_imaa004=NULL
      #SELECT DISTINCT imaa004 INTO l_imaa004
      #  FROM imaa_t
      # WHERE imaaent=g_enterprise
      #   AND imaa001=g_rtjb_d[l_ac].rtjb004
      #LET l_imaa004=NULL
      #EXECUTE adeq216_l_imaa004 USING g_rtjb_d[l_ac].rtjb004
      #   INTO l_imaa004   
      #150911-00001#1 15/10/01 s983961-MARK & MOD(e)
      
      #IF l_imaa004='E' THEN
      #   LET g_rtjb_d[l_ac].l_account=0
      #END IF 
      # add by yuhl 2015/08/22 (E)
      #end add-point
 
      CALL adeq111_detail_show("'1'")      
 
      CALL adeq111_rtjb_t_mask()
 
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
   
 
   
   CALL g_rtjb_d.deleteElement(g_rtjb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_rtjb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE adeq111_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq111_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq111_detail_action_trans()
 
   IF g_rtjb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL adeq111_fetch()
   END IF
   
      CALL adeq111_filter_show('rtjasite','b_rtjasite')
   CALL adeq111_filter_show('rtaw001','b_rtaw001')
   CALL adeq111_filter_show('imaa101','b_imaa101')
   CALL adeq111_filter_show('rtjb003','b_rtjb003')
   CALL adeq111_filter_show('rtjb004','b_rtjb004')
   CALL adeq111_filter_show('rtjb010','b_rtjb010')
   CALL adeq111_filter_show('rtjb013','b_rtjb013')
   CALL adeq111_filter_show('rtjbdocno','b_rtjbdocno')
   CALL adeq111_filter_show('rtjbseq','b_rtjbseq')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq111_fetch()
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
 
{<section id="adeq111.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq111_detail_show(ps_page)
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

      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjb004
      #      LET ls_sql = "SELECT imaal002 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal003='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_rtjb_d[l_ac].rtjb004_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_rtjb_d[l_ac].rtjb004_desc
      #
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_rtjb_d[l_ac].rtjb013
      #      LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_rtjb_d[l_ac].rtjb013_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_rtjb_d[l_ac].rtjb013_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION adeq111_filter()
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
      CONSTRUCT g_wc_filter ON rtjasite,rtaw001,imaa101,rtjb003,rtjb004,rtjb010,rtjb013,rtjbdocno,rtjbseq 
 
                          FROM s_detail1[1].b_rtjasite,s_detail1[1].b_rtaw001,s_detail1[1].b_imaa101, 
                              s_detail1[1].b_rtjb003,s_detail1[1].b_rtjb004,s_detail1[1].b_rtjb010,s_detail1[1].b_rtjb013, 
                              s_detail1[1].b_rtjbdocno,s_detail1[1].b_rtjbseq
 
         BEFORE CONSTRUCT
                     DISPLAY adeq111_filter_parser('rtjasite') TO s_detail1[1].b_rtjasite
            DISPLAY adeq111_filter_parser('rtaw001') TO s_detail1[1].b_rtaw001
            DISPLAY adeq111_filter_parser('imaa101') TO s_detail1[1].b_imaa101
            DISPLAY adeq111_filter_parser('rtjb003') TO s_detail1[1].b_rtjb003
            DISPLAY adeq111_filter_parser('rtjb004') TO s_detail1[1].b_rtjb004
            DISPLAY adeq111_filter_parser('rtjb010') TO s_detail1[1].b_rtjb010
            DISPLAY adeq111_filter_parser('rtjb013') TO s_detail1[1].b_rtjb013
            DISPLAY adeq111_filter_parser('rtjbdocno') TO s_detail1[1].b_rtjbdocno
            DISPLAY adeq111_filter_parser('rtjbseq') TO s_detail1[1].b_rtjbseq
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjasite
            #add-point:ON ACTION controlp INFIELD b_rtjasite name="construct.c.filter.page1.b_rtjasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c') 
            CALL q_ooef001_24()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjasite  #顯示到畫面上
            NEXT FIELD b_rtjasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjasite_desc>>----
         #----<<b_rtaw001>>----
         #Ctrlp:construct.c.page1.b_rtaw001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtaw001
            #add-point:ON ACTION controlp INFIELD b_rtaw001 name="construct.c.filter.page1.b_rtaw001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = cl_get_para(g_enterprise,'','E-CIR-0001') 
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtaw001  #顯示到畫面上
            NEXT FIELD b_rtaw001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtaw001_desc>>----
         #----<<b_imaa101>>----
         #Ctrlp:construct.c.page1.b_imaa101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_imaa101
            #add-point:ON ACTION controlp INFIELD b_imaa101 name="construct.c.filter.page1.b_imaa101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_imaa101  #顯示到畫面上
            NEXT FIELD b_imaa101                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaa101_desc>>----
         #----<<b_rtjb003>>----
         #Ctrlp:construct.c.page1.b_rtjb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb003
            #add-point:ON ACTION controlp INFIELD b_rtjb003 name="construct.c.filter.page1.b_rtjb003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb003  #顯示到畫面上
            NEXT FIELD b_rtjb003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjb004>>----
         #Ctrlp:construct.c.page1.b_rtjb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb004
            #add-point:ON ACTION controlp INFIELD b_rtjb004 name="construct.c.filter.page1.b_rtjb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb004  #顯示到畫面上
            NEXT FIELD b_rtjb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_imaal003>>----
         #----<<b_imaal004>>----
         #----<<l_rtdx003>>----
         #----<<b_rtjb010>>----
         #Ctrlp:construct.c.filter.page1.b_rtjb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb010
            #add-point:ON ACTION controlp INFIELD b_rtjb010 name="construct.c.filter.page1.b_rtjb010"
            
            #END add-point
 
 
         #----<<l_scount>>----
         #----<<b_rtjb013>>----
         #Ctrlp:construct.c.page1.b_rtjb013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjb013
            #add-point:ON ACTION controlp INFIELD b_rtjb013 name="construct.c.filter.page1.b_rtjb013"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjb013  #顯示到畫面上
            NEXT FIELD b_rtjb013                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjb013_desc>>----
         #----<<l_sell>>----
         #----<<l_account>>----
         #----<<b_rtjbdocno>>----
         #Ctrlp:construct.c.filter.page1.b_rtjbdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbdocno
            #add-point:ON ACTION controlp INFIELD b_rtjbdocno name="construct.c.filter.page1.b_rtjbdocno"
            
            #END add-point
 
 
         #----<<b_rtjbseq>>----
         #Ctrlp:construct.c.filter.page1.b_rtjbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjbseq
            #add-point:ON ACTION controlp INFIELD b_rtjbseq name="construct.c.filter.page1.b_rtjbseq"
            
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
   
      CALL adeq111_filter_show('rtjasite','b_rtjasite')
   CALL adeq111_filter_show('rtaw001','b_rtaw001')
   CALL adeq111_filter_show('imaa101','b_imaa101')
   CALL adeq111_filter_show('rtjb003','b_rtjb003')
   CALL adeq111_filter_show('rtjb004','b_rtjb004')
   CALL adeq111_filter_show('rtjb010','b_rtjb010')
   CALL adeq111_filter_show('rtjb013','b_rtjb013')
   CALL adeq111_filter_show('rtjbdocno','b_rtjbdocno')
   CALL adeq111_filter_show('rtjbseq','b_rtjbseq')
 
    
   CALL adeq111_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION adeq111_filter_parser(ps_field)
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
 
{<section id="adeq111.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq111_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq111_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.insert" >}
#+ insert
PRIVATE FUNCTION adeq111_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="adeq111.modify" >}
#+ modify
PRIVATE FUNCTION adeq111_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.reproduce" >}
#+ reproduce
PRIVATE FUNCTION adeq111_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.delete" >}
#+ delete
PRIVATE FUNCTION adeq111_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="adeq111.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq111_detail_action_trans()
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
 
{<section id="adeq111.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq111_detail_index_setting()
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
            IF g_rtjb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtjb_d.getLength() AND g_rtjb_d.getLength() > 0
            LET g_detail_idx = g_rtjb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtjb_d.getLength() THEN
               LET g_detail_idx = g_rtjb_d.getLength()
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
 
{<section id="adeq111.mask_functions" >}
 &include "erp/ade/adeq111_mask.4gl"
 
{</section>}
 
{<section id="adeq111.other_function" readonly="Y" >}

 
{</section>}
 
