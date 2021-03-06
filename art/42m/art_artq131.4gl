#該程式未解開Section, 採用最新樣板產出!
{<section id="artq131.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-08-03 15:41:28), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: artq131
#+ Description: 特殊條碼銷售查詢作業
#+ Creator....: 03247(2015-02-25 14:39:09)
#+ Modifier...: 03247 -SD/PR- 00000
 
{</section>}
 
{<section id="artq131.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_rtja_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   rtjasite LIKE rtja_t.rtjasite, 
   rtjasite_desc LIKE type_t.chr500, 
   rtjadocdt LIKE rtja_t.rtjadocdt, 
   rtjadocno LIKE rtja_t.rtjadocno, 
   rtja001 LIKE rtja_t.rtja001, 
   rtja001_desc LIKE type_t.chr500, 
   rtja002 LIKE rtja_t.rtja002, 
   rtja002_desc LIKE type_t.chr500, 
   rtja004 LIKE rtja_t.rtja004, 
   rtja004_desc LIKE type_t.chr500, 
   rtja005 LIKE rtja_t.rtja005, 
   rtja005_desc LIKE type_t.chr500, 
   rtja037 LIKE rtja_t.rtja037, 
   rtja037_desc LIKE type_t.chr500, 
   rtja032 LIKE rtja_t.rtja032, 
   rtja033 LIKE rtja_t.rtja033, 
   rtja034 LIKE rtja_t.rtja034, 
   rtja035 LIKE rtja_t.rtja035, 
   rtjkseq LIKE type_t.chr500, 
   rtjk001 LIKE type_t.chr500, 
   rtjk002 LIKE type_t.chr500, 
   rtjk003 LIKE type_t.chr500, 
   rtjk001_desc LIKE type_t.chr500, 
   rtjk013 LIKE type_t.chr500, 
   rtjk013_desc LIKE type_t.chr500, 
   rtjk008 LIKE type_t.chr500, 
   rtjk010 LIKE type_t.chr500, 
   rtjk012 LIKE type_t.chr500, 
   rtjk014 LIKE type_t.chr500, 
   rtjk015 LIKE type_t.chr500, 
   rtjk019 LIKE type_t.chr500, 
   rtjk019_desc LIKE type_t.chr500, 
   rtjk020 LIKE type_t.chr500, 
   rtjk020_desc LIKE type_t.chr500, 
   rtjk021 LIKE type_t.chr500, 
   rtjk022 LIKE type_t.chr500, 
   rtjk022_desc LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table2          STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_rtja_d
DEFINE g_master_t                   type_g_rtja_d
DEFINE g_rtja_d          DYNAMIC ARRAY OF type_g_rtja_d
DEFINE g_rtja_d_t        type_g_rtja_d
 
      
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
 
{<section id="artq131.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("art","")
 
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
   DECLARE artq131_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE artq131_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE artq131_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_artq131 WITH FORM cl_ap_formpath("art",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL artq131_init()   
 
      #進入選單 Menu (="N")
      CALL artq131_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_artq131
      
   END IF 
   
   CLOSE artq131_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#5  By benson 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="artq131.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION artq131_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#5  By benson 150309
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_rtja032','6544') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#5  By benson 150309
   #end add-point
 
   CALL artq131_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="artq131.default_search" >}
PRIVATE FUNCTION artq131_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjadocno = '", g_argv[01], "' AND "
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
 
{<section id="artq131.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION artq131_ui_dialog()
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
      CALL artq131_b_fill()
   ELSE
      CALL artq131_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtja_d.clear()
 
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
 
         CALL artq131_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_rtja_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL artq131_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL artq131_detail_action_trans()
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
            CALL artq131_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
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
               CALL artq131_query()
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
            CALL artq131_filter()
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
            CALL artq131_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_rtja_d)
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
            CALL artq131_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL artq131_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL artq131_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL artq131_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "N"
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
 
{<section id="artq131.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION artq131_query()
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
   CALL g_rtja_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON rtjasite,rtjadocdt,rtjadocno,rtja001,rtja002,rtja004,rtja005,rtja037,rtja032, 
          rtja033,rtja034,rtja035
           FROM s_detail1[1].b_rtjasite,s_detail1[1].b_rtjadocdt,s_detail1[1].b_rtjadocno,s_detail1[1].b_rtja001, 
               s_detail1[1].b_rtja002,s_detail1[1].b_rtja004,s_detail1[1].b_rtja005,s_detail1[1].b_rtja037, 
               s_detail1[1].b_rtja032,s_detail1[1].b_rtja033,s_detail1[1].b_rtja034,s_detail1[1].b_rtja035 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
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
            #CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
            CALL q_ooef001_24()
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
         #----<<b_rtjadocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjadocdt
            #add-point:BEFORE FIELD b_rtjadocdt name="construct.b.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjadocdt
            
            #add-point:AFTER FIELD b_rtjadocdt name="construct.a.page1.b_rtjadocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocdt
            #add-point:ON ACTION controlp INFIELD b_rtjadocdt name="construct.c.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #----<<b_rtjadocno>>----
         #Ctrlp:construct.c.page1.b_rtjadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocno
            #add-point:ON ACTION controlp INFIELD b_rtjadocno name="construct.c.page1.b_rtjadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtjadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjadocno  #顯示到畫面上
            NEXT FIELD b_rtjadocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtjadocno
            #add-point:BEFORE FIELD b_rtjadocno name="construct.b.page1.b_rtjadocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtjadocno
            
            #add-point:AFTER FIELD b_rtjadocno name="construct.a.page1.b_rtjadocno"
            
            #END add-point
            
 
 
         #----<<b_rtja001>>----
         #Ctrlp:construct.c.page1.b_rtja001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja001
            #add-point:ON ACTION controlp INFIELD b_rtja001 name="construct.c.page1.b_rtja001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja001  #顯示到畫面上
            NEXT FIELD b_rtja001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja001
            #add-point:BEFORE FIELD b_rtja001 name="construct.b.page1.b_rtja001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja001
            
            #add-point:AFTER FIELD b_rtja001 name="construct.a.page1.b_rtja001"
            
            #END add-point
            
 
 
         #----<<b_rtja001_desc>>----
         #----<<b_rtja002>>----
         #Ctrlp:construct.c.page1.b_rtja002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja002
            #add-point:ON ACTION controlp INFIELD b_rtja002 name="construct.c.page1.b_rtja002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja002  #顯示到畫面上
            NEXT FIELD b_rtja002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja002
            #add-point:BEFORE FIELD b_rtja002 name="construct.b.page1.b_rtja002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja002
            
            #add-point:AFTER FIELD b_rtja002 name="construct.a.page1.b_rtja002"
            
            #END add-point
            
 
 
         #----<<b_rtja002_desc>>----
         #----<<b_rtja004>>----
         #Ctrlp:construct.c.page1.b_rtja004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja004
            #add-point:ON ACTION controlp INFIELD b_rtja004 name="construct.c.page1.b_rtja004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_oofa003()                           #呼叫開窗
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_rtja004  #顯示到畫面上
            NEXT FIELD b_rtja004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja004
            #add-point:BEFORE FIELD b_rtja004 name="construct.b.page1.b_rtja004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja004
            
            #add-point:AFTER FIELD b_rtja004 name="construct.a.page1.b_rtja004"
            
            #END add-point
            
 
 
         #----<<b_rtja004_desc>>----
         #----<<b_rtja005>>----
         #Ctrlp:construct.c.page1.b_rtja005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja005
            #add-point:ON ACTION controlp INFIELD b_rtja005 name="construct.c.page1.b_rtja005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja005  #顯示到畫面上
            NEXT FIELD b_rtja005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja005
            #add-point:BEFORE FIELD b_rtja005 name="construct.b.page1.b_rtja005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja005
            
            #add-point:AFTER FIELD b_rtja005 name="construct.a.page1.b_rtja005"
            
            #END add-point
            
 
 
         #----<<b_rtja005_desc>>----
         #----<<b_rtja037>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja037
            #add-point:BEFORE FIELD b_rtja037 name="construct.b.page1.b_rtja037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja037
            
            #add-point:AFTER FIELD b_rtja037 name="construct.a.page1.b_rtja037"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtja037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja037
            #add-point:ON ACTION controlp INFIELD b_rtja037 name="construct.c.page1.b_rtja037"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtja037  #顯示到畫面上

            NEXT FIELD rtja037
            #END add-point
 
 
         #----<<b_rtja037_desc>>----
         #----<<b_rtja032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja032
            #add-point:BEFORE FIELD b_rtja032 name="construct.b.page1.b_rtja032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja032
            
            #add-point:AFTER FIELD b_rtja032 name="construct.a.page1.b_rtja032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtja032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja032
            #add-point:ON ACTION controlp INFIELD b_rtja032 name="construct.c.page1.b_rtja032"
            
            #END add-point
 
 
         #----<<b_rtja033>>----
         #Ctrlp:construct.c.page1.b_rtja033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja033
            #add-point:ON ACTION controlp INFIELD b_rtja033 name="construct.c.page1.b_rtja033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtja033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja033  #顯示到畫面上
            NEXT FIELD b_rtja033                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja033
            #add-point:BEFORE FIELD b_rtja033 name="construct.b.page1.b_rtja033"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja033
            
            #add-point:AFTER FIELD b_rtja033 name="construct.a.page1.b_rtja033"
            
            #END add-point
            
 
 
         #----<<b_rtja034>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja034
            #add-point:BEFORE FIELD b_rtja034 name="construct.b.page1.b_rtja034"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja034
            
            #add-point:AFTER FIELD b_rtja034 name="construct.a.page1.b_rtja034"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtja034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja034
            #add-point:ON ACTION controlp INFIELD b_rtja034 name="construct.c.page1.b_rtja034"
            
            #END add-point
 
 
         #----<<b_rtja035>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_rtja035
            #add-point:BEFORE FIELD b_rtja035 name="construct.b.page1.b_rtja035"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_rtja035
            
            #add-point:AFTER FIELD b_rtja035 name="construct.a.page1.b_rtja035"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_rtja035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja035
            #add-point:ON ACTION controlp INFIELD b_rtja035 name="construct.c.page1.b_rtja035"
            
            #END add-point
 
 
         #----<<b_rtjkseq>>----
         #----<<b_rtjk001>>----
         #----<<b_rtjk002>>----
         #----<<b_rtjk003>>----
         #----<<b_rtjk001_desc>>----
         #----<<b_rtjk013>>----
         #----<<b_rtjk013_desc>>----
         #----<<b_rtjk008>>----
         #----<<b_rtjk010>>----
         #----<<b_rtjk012>>----
         #----<<b_rtjk014>>----
         #----<<b_rtjk015>>----
         #----<<b_rtjk019>>----
         #----<<b_rtjk019_desc>>----
         #----<<b_rtjk020>>----
         #----<<b_rtjk020_desc>>----
         #----<<b_rtjk021>>----
         #----<<b_rtjk022>>----
         #----<<b_rtjk022_desc>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_table2 ON rtjkseq,rtjk003,rtjk013,rtjk008,rtjk010,rtjk012,rtjk014,rtjk015,rtjk019, 
          rtjk020,rtjk021,rtjk022
           FROM s_detail1[1].b_rtjkseq,s_detail1[1].b_rtjk003,s_detail1[1].b_rtjk013,s_detail1[1].b_rtjk008, 
                s_detail1[1].b_rtjk010,s_detail1[1].b_rtjk012,s_detail1[1].b_rtjk014,s_detail1[1].b_rtjk015, 
                s_detail1[1].b_rtjk019,s_detail1[1].b_rtjk020,s_detail1[1].b_rtjk021,s_detail1[1].b_rtjk022 

                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjk003
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_rtjk003
            #add-point:ON ACTION controlp INFIELD b_rtjk003
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtjk003()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjk003  #顯示到畫面上
            NEXT FIELD b_rtjk003                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD b_rtjk003
            #add-point:BEFORE FIELD b_rtjasite

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD b_rtjk003
            
            #add-point:AFTER FIELD b_rtjasite

            #END add-point

         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_rtjk013
            #add-point:ON ACTION controlp INFIELD b_rtjk013
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjk013  #顯示到畫面上
            NEXT FIELD b_rtjk013                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD b_rtjk013
            #add-point:BEFORE FIELD b_rtjadocno

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD b_rtjk013
            
            #add-point:AFTER FIELD b_rtjadocno

            #END add-point
            
 
         #----<<b_rtja001>>----
         #Ctrlp:construct.c.page1.b_rtjk019
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_rtjk019
            #add-point:ON ACTION controlp INFIELD b_rtjk019
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjk019  #顯示到畫面上
            NEXT FIELD b_rtjk019                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD b_rtjk019
            #add-point:BEFORE FIELD b_rtja001

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD b_rtjk019
            
            #add-point:AFTER FIELD b_rtja001

            #END add-point
            
 
         #----<<b_rtja001_desc>>----
         #----<<b_rtja002>>----
         #Ctrlp:construct.c.page1.b_rtjk020
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_rtjk020
            #add-point:ON ACTION controlp INFIELD b_rtjk020
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag005_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjk020  #顯示到畫面上
            NEXT FIELD b_rtjk020                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD b_rtjk020
            #add-point:BEFORE FIELD b_rtja002

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD b_rtjk020
            
            #add-point:AFTER FIELD b_rtja002

            #END add-point
            
 
         #----<<b_rtja002_desc>>----
         #----<<b_rtja004>>----
         #Ctrlp:construct.c.page1.b_rtjk021
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD b_rtjk021
            #add-point:ON ACTION controlp INFIELD b_rtjk021
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inag006()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjk021  #顯示到畫面上
            NEXT FIELD b_rtjk021                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD b_rtjk021
            #add-point:BEFORE FIELD b_rtja004

            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD b_rtjk021
            
            #add-point:AFTER FIELD b_rtja004

            #END add-point
 
         #----<<b_rtjkseq>>----
         #----<<b_rtjk003>>----
         #----<<b_rtjk001>>----
         #----<<b_rtjk001_desc>>----
         #----<<b_rtjk013>>----
         #----<<b_rtjk014_desc>>----
         #----<<b_rtjk008>>----
         #----<<b_rtjk010>>----
         #----<<b_rtjk012>>----
         #----<<b_rtjk014>>----
         #----<<b_rtjk015>>----
         #----<<b_rtjk019>>----
         #----<<b_rtjk019_desc>>----
         #----<<b_rtjk020>>----
         #----<<b_rtjk020_desc>>----
         #----<<b_rtjk021>>----
         #----<<b_rtjk022>>----
         #----<<b_rtjk022_desc>>----
   
       
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
   LET g_wc2 = g_wc_table2
   #end add-point
        
   LET g_error_show = 1
   CALL artq131_b_fill()
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
 
{<section id="artq131.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION artq131_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'rtjasite')
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',rtjasite,'',rtjadocdt,rtjadocno,rtja001,'',rtja002,'',rtja004, 
       '',rtja005,'',rtja037,'',rtja032,rtja033,rtja034,rtja035,'','','','','','','','','','','','', 
       '','','','','','',''  ,DENSE_RANK() OVER( ORDER BY rtja_t.rtjadocno) AS RANK FROM rtja_t",
 
 
                     "",
                     " WHERE AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtja_t"),
                     " ORDER BY rtja_t.rtjadocno"
 
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
 
   LET g_sql = "SELECT '',rtjasite,'',rtjadocdt,rtjadocno,rtja001,'',rtja002,'',rtja004,'',rtja005,'', 
       rtja037,'',rtja032,rtja033,rtja034,rtja035,'','','','','','','','','','','','','','','','','', 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150311 by lori522612 mark 效能調整---(S) 
   #LET g_sql = " SELECT  UNIQUE '',rtjasite,'',rtjadocdt,rtjadocno,rtja001,'',rtja002,'',rtja004,'',rtja005, ",
   #    " '',rtja037,'',rtja032,rtja033,rtja034,rtja035,rtjkseq,rtjk003,rtjk001,rtjk002,'',rtjk013,'',rtjk008,rtjk010, ",
   #    " rtjk012,rtjk014,rtjk015,rtjk019,'',rtjk020,'',rtjk021,rtjk022,'' FROM rtja_t,rtjk_t ",
   #    " WHERE rtjaent = ? AND 1=1 ",
   #    "   AND rtjaent = rtjkent ",
   #    "   AND rtjadocno = rtjkdocno ",
   #    "   AND ",ls_wc,cl_sql_add_filter("rtja_t")
   #LET g_sql = g_sql, cl_sql_add_filter("rtja_t"),
   #                   " ORDER BY rtja_t.rtjasite,rtja_t.rtjadocdt,rtja_t.rtjadocno,rtjkseq"
   #150302-00004#8 150311 by lori522612 mark 效能調整---(E) 
   
   #150302-00004#8 150311 by lori522612 add 效能調整---(S) 
   LET g_sql = " SELECT  UNIQUE '', ",
               "                rtjasite, t1.ooefl003, rtjadocdt,   rtjadocno,  rtja001, ",
               "                mmaf008,  rtja002,     t2.pmaal004, rtja004,    t3.ooag011, ",
               #"                rtja005,  t4.ooefl003, rtja037,     t5.ooag011, rtja032, ",
               "                rtja005,  t4.ooefl003, rtja037,     t5.pcab003, rtja032, ",
               "                rtja033,  rtja034,     rtja035,     rtjkseq,    rtjk001, ",
               "                rtjk002,  rtjk003,     '',          rtjk013,    t6.oocal003, ",
               "                rtjk008,  rtjk010,     rtjk012,     rtjk014,    rtjk015, ",
               "                rtjk019,  t7.inayl003, rtjk020,     t8.inab003, rtjk021, ",
               "                rtjk022,'' ",                                                  #尚無專櫃編號說明
               "  FROM rtja_t ",
               "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = rtjaent AND t1.ooefl001 = rtjasite AND t1.ooefl002 = '",g_dlang,"' ",
               "       LEFT JOIN pmaal_t t2 ON t2.pmaalent = rtjaent AND t2.pmaal001 = rtja002  AND t2.pmaal002 = '",g_dlang,"' ",
               "       LEFT JOIN ooag_t  t3 ON t3.ooagent  = rtjaent AND t3.ooag001  = rtja004 ",
               "       LEFT JOIN ooefl_t t4 ON t4.ooeflent = rtjaent AND t4.ooefl001 = rtja005  AND t4.ooefl002 = '",g_dlang,"' ", 
               #"       LEFT JOIN ooag_t  t5 ON t5.ooagent  = rtjaent AND t5.ooag001  = rtja037 ",
               "       LEFT JOIN pcab_t  t5 ON t5.pcabent  = rtjaent AND t5.pcab001  = rtja037 ",
               "       LEFT JOIN (SELECT mmaqent,mmaq001,mmaf008 ",
               "                    FROM mmaq_t ",
               "                         LEFT JOIN mmaf_t ON mmafent = mmaqent AND mmaf001 = mmaq003)",
               "              ON mmaqent = rtjaent AND mmaq001 = rtja001 ",
               "      ,rtjk_t ",
               "       LEFT JOIN oocal_t t6 ON t6.oocalent = rtjkent AND t6.oocal001 = rtjk013  AND t6.oocal002 = '",g_dlang,"' ",
               "       LEFT JOIN inayl_t t7 ON t7.inaylent = rtjkent AND t7.inayl001 = rtjk019  AND t7.inayl002 = '",g_dlang,"' ",
               "       LEFT JOIN inab_t  t8 ON t8.inabent  = rtjkent AND t8.inabsite = rtjksite AND t8.inab001 = rtjk019 AND t8.inab002 = rtjk020 ",
               " WHERE rtjaent = ? AND 1=1 ",
               "   AND rtjaent = rtjkent ",
               "   AND rtjadocno = rtjkdocno ",
               "   AND ",ls_wc,cl_sql_add_filter("rtja_t")
   LET g_sql = g_sql, cl_sql_add_filter("rtja_t"),
                      " ORDER BY rtja_t.rtjasite,rtja_t.rtjadocdt,rtja_t.rtjadocno,rtjkseq"
   #150302-00004#8 150311 by lori522612 add 效能調整---(E)                  
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE artq131_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR artq131_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_rtja_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_rtja_d[l_ac].sel,g_rtja_d[l_ac].rtjasite,g_rtja_d[l_ac].rtjasite_desc, 
       g_rtja_d[l_ac].rtjadocdt,g_rtja_d[l_ac].rtjadocno,g_rtja_d[l_ac].rtja001,g_rtja_d[l_ac].rtja001_desc, 
       g_rtja_d[l_ac].rtja002,g_rtja_d[l_ac].rtja002_desc,g_rtja_d[l_ac].rtja004,g_rtja_d[l_ac].rtja004_desc, 
       g_rtja_d[l_ac].rtja005,g_rtja_d[l_ac].rtja005_desc,g_rtja_d[l_ac].rtja037,g_rtja_d[l_ac].rtja037_desc, 
       g_rtja_d[l_ac].rtja032,g_rtja_d[l_ac].rtja033,g_rtja_d[l_ac].rtja034,g_rtja_d[l_ac].rtja035,g_rtja_d[l_ac].rtjkseq, 
       g_rtja_d[l_ac].rtjk001,g_rtja_d[l_ac].rtjk002,g_rtja_d[l_ac].rtjk003,g_rtja_d[l_ac].rtjk001_desc, 
       g_rtja_d[l_ac].rtjk013,g_rtja_d[l_ac].rtjk013_desc,g_rtja_d[l_ac].rtjk008,g_rtja_d[l_ac].rtjk010, 
       g_rtja_d[l_ac].rtjk012,g_rtja_d[l_ac].rtjk014,g_rtja_d[l_ac].rtjk015,g_rtja_d[l_ac].rtjk019,g_rtja_d[l_ac].rtjk019_desc, 
       g_rtja_d[l_ac].rtjk020,g_rtja_d[l_ac].rtjk020_desc,g_rtja_d[l_ac].rtjk021,g_rtja_d[l_ac].rtjk022, 
       g_rtja_d[l_ac].rtjk022_desc
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_rtja_d[l_ac].statepic = cl_get_actipic(g_rtja_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_rtja_d[l_ac].sel = 'N'
      
      SELECT prbo005 INTO g_rtja_d[l_ac].rtjk001_desc
        FROM prbo_t
       WHERE prboent = g_enterprise
         AND prbodocno = g_rtja_d[l_ac].rtjk001
      IF SQLCA.sqlcode = 100 THEN
         SELECT prbr009 INTO g_rtja_d[l_ac].rtjk001_desc
           FROM prbr_t
          WHERE prbrent = g_enterprise
            AND prbrdocno = g_rtja_d[l_ac].rtjk001
            AND prbrseq = g_rtja_d[l_ac].rtjk002
      END IF
      #end add-point
 
      CALL artq131_detail_show("'1'")      
 
      CALL artq131_rtja_t_mask()
 
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
   
 
   
   CALL g_rtja_d.deleteElement(g_rtja_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_rtja_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE artq131_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL artq131_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL artq131_detail_action_trans()
 
   IF g_rtja_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL artq131_fetch()
   END IF
   
      CALL artq131_filter_show('rtjasite','b_rtjasite')
   CALL artq131_filter_show('rtjadocdt','b_rtjadocdt')
   CALL artq131_filter_show('rtjadocno','b_rtjadocno')
   CALL artq131_filter_show('rtja001','b_rtja001')
   CALL artq131_filter_show('rtja002','b_rtja002')
   CALL artq131_filter_show('rtja004','b_rtja004')
   CALL artq131_filter_show('rtja005','b_rtja005')
   CALL artq131_filter_show('rtja037','b_rtja037')
   CALL artq131_filter_show('rtja032','b_rtja032')
   CALL artq131_filter_show('rtja033','b_rtja033')
   CALL artq131_filter_show('rtja034','b_rtja034')
   CALL artq131_filter_show('rtja035','b_rtja035')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq131.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION artq131_fetch()
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
 
{<section id="artq131.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION artq131_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   DEFINE l_mmaq003  LIKE mmaq_t.mmaq003
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      #150302-00004#8 150311 by lori522612 mark---(S)  
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtjasite
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtjasite_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtjasite_desc
      #
      #SELECT mmaq003 INTO l_mmaq003 
      #  FROM mmaq_t
      # WHERE mmaq001 = g_rtja_d[l_ac].rtja001
      #   AND mmaqent = g_enterprise
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = l_mmaq003
      #LET ls_sql = "SELECT mmaf008 FROM mmaf_t WHERE mmafent='"||g_enterprise||"' AND mmaf001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtja001_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtja001_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtja002
      #LET ls_sql = "SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtja002_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtja002_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtja004
      #LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtja004_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtja004_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtja005
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtja005_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtja005_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtja037
      #LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtja037_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtja037_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtjk013
      #LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"' "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtjk013_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtjk013_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtjasite
      #LET g_ref_fields[2] = g_rtja_d[l_ac].rtjk019
      #LET ls_sql = "SELECT inaa002 FROM inaa_t WHERE inaaent='"||g_enterprise||"' AND inaasite=? AND inaa001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtjk019_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtjk019_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_rtja_d[l_ac].rtjasite
      #LET g_ref_fields[2] = g_rtja_d[l_ac].rtjk019
      #LET g_ref_fields[3] = g_rtja_d[l_ac].rtjk020
      #LET ls_sql = "SELECT inab003 FROM inab_t WHERE inabent='"||g_enterprise||"' AND inabsite=? AND inab001=? AND inab002=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_rtja_d[l_ac].rtjk020_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_rtja_d[l_ac].rtjk020_desc
      #150302-00004#8 150311 by lori522612 mark---(E) 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="artq131.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION artq131_filter()
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
      CONSTRUCT g_wc_filter ON rtjasite,rtjadocdt,rtjadocno,rtja001,rtja002,rtja004,rtja005,rtja037, 
          rtja032,rtja033,rtja034,rtja035
                          FROM s_detail1[1].b_rtjasite,s_detail1[1].b_rtjadocdt,s_detail1[1].b_rtjadocno, 
                              s_detail1[1].b_rtja001,s_detail1[1].b_rtja002,s_detail1[1].b_rtja004,s_detail1[1].b_rtja005, 
                              s_detail1[1].b_rtja037,s_detail1[1].b_rtja032,s_detail1[1].b_rtja033,s_detail1[1].b_rtja034, 
                              s_detail1[1].b_rtja035
 
         BEFORE CONSTRUCT
                     DISPLAY artq131_filter_parser('rtjasite') TO s_detail1[1].b_rtjasite
            DISPLAY artq131_filter_parser('rtjadocdt') TO s_detail1[1].b_rtjadocdt
            DISPLAY artq131_filter_parser('rtjadocno') TO s_detail1[1].b_rtjadocno
            DISPLAY artq131_filter_parser('rtja001') TO s_detail1[1].b_rtja001
            DISPLAY artq131_filter_parser('rtja002') TO s_detail1[1].b_rtja002
            DISPLAY artq131_filter_parser('rtja004') TO s_detail1[1].b_rtja004
            DISPLAY artq131_filter_parser('rtja005') TO s_detail1[1].b_rtja005
            DISPLAY artq131_filter_parser('rtja037') TO s_detail1[1].b_rtja037
            DISPLAY artq131_filter_parser('rtja032') TO s_detail1[1].b_rtja032
            DISPLAY artq131_filter_parser('rtja033') TO s_detail1[1].b_rtja033
            DISPLAY artq131_filter_parser('rtja034') TO s_detail1[1].b_rtja034
            DISPLAY artq131_filter_parser('rtja035') TO s_detail1[1].b_rtja035
 
 
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
            #CALL q_ooed004()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjasite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_rtjasite  #顯示到畫面上
            NEXT FIELD b_rtjasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtjasite_desc>>----
         #----<<b_rtjadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_rtjadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocdt
            #add-point:ON ACTION controlp INFIELD b_rtjadocdt name="construct.c.filter.page1.b_rtjadocdt"
            
            #END add-point
 
 
         #----<<b_rtjadocno>>----
         #Ctrlp:construct.c.page1.b_rtjadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjadocno
            #add-point:ON ACTION controlp INFIELD b_rtjadocno name="construct.c.filter.page1.b_rtjadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtjadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtjadocno  #顯示到畫面上
            NEXT FIELD b_rtjadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja001>>----
         #Ctrlp:construct.c.page1.b_rtja001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja001
            #add-point:ON ACTION controlp INFIELD b_rtja001 name="construct.c.filter.page1.b_rtja001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaq001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja001  #顯示到畫面上
            NEXT FIELD b_rtja001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja001_desc>>----
         #----<<b_rtja002>>----
         #Ctrlp:construct.c.page1.b_rtja002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja002
            #add-point:ON ACTION controlp INFIELD b_rtja002 name="construct.c.filter.page1.b_rtja002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_7()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja002  #顯示到畫面上
            NEXT FIELD b_rtja002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja002_desc>>----
         #----<<b_rtja004>>----
         #Ctrlp:construct.c.page1.b_rtja004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja004
            #add-point:ON ACTION controlp INFIELD b_rtja004 name="construct.c.filter.page1.b_rtja004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_oofa003()                           #呼叫開窗
            CALL q_ooag001()
            DISPLAY g_qryparam.return1 TO b_rtja004  #顯示到畫面上
            NEXT FIELD b_rtja004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja004_desc>>----
         #----<<b_rtja005>>----
         #Ctrlp:construct.c.page1.b_rtja005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja005
            #add-point:ON ACTION controlp INFIELD b_rtja005 name="construct.c.filter.page1.b_rtja005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooea001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja005  #顯示到畫面上
            NEXT FIELD b_rtja005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja005_desc>>----
         #----<<b_rtja037>>----
         #Ctrlp:construct.c.filter.page1.b_rtja037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja037
            #add-point:ON ACTION controlp INFIELD b_rtja037 name="construct.c.filter.page1.b_rtja037"
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pcab001_1()                            #呼叫開窗
            DISPLAY g_qryparam.return1 TO rtja037  #顯示到畫面上

            NEXT FIELD rtja037
            #END add-point
 
 
         #----<<b_rtja037_desc>>----
         #----<<b_rtja032>>----
         #Ctrlp:construct.c.filter.page1.b_rtja032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja032
            #add-point:ON ACTION controlp INFIELD b_rtja032 name="construct.c.filter.page1.b_rtja032"
            
            #END add-point
 
 
         #----<<b_rtja033>>----
         #Ctrlp:construct.c.page1.b_rtja033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja033
            #add-point:ON ACTION controlp INFIELD b_rtja033 name="construct.c.filter.page1.b_rtja033"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtja033()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtja033  #顯示到畫面上
            NEXT FIELD b_rtja033                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtja034>>----
         #Ctrlp:construct.c.filter.page1.b_rtja034
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja034
            #add-point:ON ACTION controlp INFIELD b_rtja034 name="construct.c.filter.page1.b_rtja034"
            
            #END add-point
 
 
         #----<<b_rtja035>>----
         #Ctrlp:construct.c.filter.page1.b_rtja035
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtja035
            #add-point:ON ACTION controlp INFIELD b_rtja035 name="construct.c.filter.page1.b_rtja035"
            
            #END add-point
 
 
         #----<<b_rtjkseq>>----
         #----<<b_rtjk001>>----
         #----<<b_rtjk002>>----
         #----<<b_rtjk003>>----
         #----<<b_rtjk001_desc>>----
         #----<<b_rtjk013>>----
         #----<<b_rtjk013_desc>>----
         #----<<b_rtjk008>>----
         #----<<b_rtjk010>>----
         #----<<b_rtjk012>>----
         #----<<b_rtjk014>>----
         #----<<b_rtjk015>>----
         #----<<b_rtjk019>>----
         #----<<b_rtjk019_desc>>----
         #----<<b_rtjk020>>----
         #----<<b_rtjk020_desc>>----
         #----<<b_rtjk021>>----
         #----<<b_rtjk022>>----
         #----<<b_rtjk022_desc>>----
   
 
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
   
      CALL artq131_filter_show('rtjasite','b_rtjasite')
   CALL artq131_filter_show('rtjadocdt','b_rtjadocdt')
   CALL artq131_filter_show('rtjadocno','b_rtjadocno')
   CALL artq131_filter_show('rtja001','b_rtja001')
   CALL artq131_filter_show('rtja002','b_rtja002')
   CALL artq131_filter_show('rtja004','b_rtja004')
   CALL artq131_filter_show('rtja005','b_rtja005')
   CALL artq131_filter_show('rtja037','b_rtja037')
   CALL artq131_filter_show('rtja032','b_rtja032')
   CALL artq131_filter_show('rtja033','b_rtja033')
   CALL artq131_filter_show('rtja034','b_rtja034')
   CALL artq131_filter_show('rtja035','b_rtja035')
 
    
   CALL artq131_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="artq131.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION artq131_filter_parser(ps_field)
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
 
{<section id="artq131.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION artq131_filter_show(ps_field,ps_object)
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
   LET ls_condition = artq131_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="artq131.insert" >}
#+ insert
PRIVATE FUNCTION artq131_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="artq131.modify" >}
#+ modify
PRIVATE FUNCTION artq131_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq131.reproduce" >}
#+ reproduce
PRIVATE FUNCTION artq131_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq131.delete" >}
#+ delete
PRIVATE FUNCTION artq131_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="artq131.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION artq131_detail_action_trans()
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
 
{<section id="artq131.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION artq131_detail_index_setting()
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
            IF g_rtja_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtja_d.getLength() AND g_rtja_d.getLength() > 0
            LET g_detail_idx = g_rtja_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtja_d.getLength() THEN
               LET g_detail_idx = g_rtja_d.getLength()
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
 
{<section id="artq131.mask_functions" >}
 &include "erp/art/artq131_mask.4gl"
 
{</section>}
 
{<section id="artq131.other_function" readonly="Y" >}

 
{</section>}
 
