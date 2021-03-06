#該程式未解開Section, 採用最新樣板產出!
{<section id="afmq030.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-03-07 09:43:00), PR版次:0006(2016-10-24 09:25:04)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000029
#+ Filename...: afmq030
#+ Description: 預估還本付息清單
#+ Creator....: 01727(2016-03-07 09:43:00)
#+ Modifier...: 01727 -SD/PR- 06814
 
{</section>}
 
{<section id="afmq030.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160318-00025#6   2016/04/19  By 07675       將重複內容的錯誤訊息置換為公用錯誤訊息(r.v）
#160830-00011#1   2016/08/30  By 01727       调整首次付息日期计算逻辑
#160905-00002#3   160905      By albireo     SQL補ENT
#161006-00005#24  161024      By 06814       投資組織(fmcjsite)開窗改用q_ooef001_33( )
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
PRIVATE TYPE type_g_fmcl_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   fmclseq2 LIKE fmcl_t.fmclseq2, 
   fmcldocno LIKE fmcl_t.fmcldocno, 
   fmclseq LIKE fmcl_t.fmclseq, 
   fmcl005 LIKE fmcl_t.fmcl005, 
   fmcl001 LIKE fmcl_t.fmcl001, 
   fmck002 LIKE fmck_t.fmck002, 
   fmcl006 LIKE fmcl_t.fmcl006 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_fmcj RECORD
   fmcjsite      LIKE fmcj_t.fmcjsite, 
   fmcjsite_desc LIKE ooefl_t.ooefl003, 
   fmcjcomp      LIKE fmcj_t.fmcjcomp, 
   fmcjcomp_desc LIKE ooefl_t.ooefl003, 
   fmcjdocno     LIKE fmcj_t.fmcjdocno, 
   fmcj001       LIKE fmcj_t.fmcj001,
   fmcj001_desc  LIKE fmaal_t.fmaal003
       END RECORD

DEFINE g_fmcj    type_g_fmcj
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_fmcl_d
DEFINE g_master_t                   type_g_fmcl_d
DEFINE g_fmcl_d          DYNAMIC ARRAY OF type_g_fmcl_d
DEFINE g_fmcl_d_t        type_g_fmcl_d
 
      
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
 
{<section id="afmq030.main" >}
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
   CALL cl_ap_init("afm","")
 
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
   DECLARE afmq030_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afmq030_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afmq030_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afmq030 WITH FORM cl_ap_formpath("afm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afmq030_init()   
 
      #進入選單 Menu (="N")
      CALL afmq030_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afmq030
      
   END IF 
   
   CLOSE afmq030_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afmq030.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION afmq030_init()
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
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL cl_set_combo_scc('b_fmcl001','8859')
   #end add-point
 
   CALL afmq030_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="afmq030.default_search" >}
PRIVATE FUNCTION afmq030_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " fmclseq = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " fmclseq2 = '", g_argv[02], "' AND "
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
 
{<section id="afmq030.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION afmq030_ui_dialog()
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
      CALL afmq030_b_fill()
   ELSE
      CALL afmq030_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_fmcl_d.clear()
 
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
 
         CALL afmq030_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_fmcl_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL afmq030_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL afmq030_detail_action_trans()
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
            CALL afmq030_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL afmq030_insert()
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
               CALL afmq030_query()
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
            CALL afmq030_filter()
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
            CALL afmq030_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_fmcl_d)
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
            CALL afmq030_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL afmq030_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL afmq030_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL afmq030_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_fmcl_d.getLength()
               LET g_fmcl_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_fmcl_d.getLength()
               LET g_fmcl_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_fmcl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_fmcl_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_fmcl_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_fmcl_d[li_idx].sel = "N"
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
 
{<section id="afmq030.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION afmq030_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_ld       LIKE glaa_t.glaald
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_fmcl_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON fmclseq2
           FROM s_detail1[1].b_fmclseq2
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_fmclseq2>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmclseq2
            #add-point:BEFORE FIELD b_fmclseq2 name="construct.b.page1.b_fmclseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmclseq2
            
            #add-point:AFTER FIELD b_fmclseq2 name="construct.a.page1.b_fmclseq2"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmclseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmclseq2
            #add-point:ON ACTION controlp INFIELD b_fmclseq2 name="construct.c.page1.b_fmclseq2"
            
            #END add-point
 
 
         #----<<b_fmcldocno>>----
         #----<<b_fmclseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_fmclseq
            #add-point:BEFORE FIELD b_fmclseq name="construct.b.page1.b_fmclseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_fmclseq
            
            #add-point:AFTER FIELD b_fmclseq name="construct.a.page1.b_fmclseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_fmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmclseq
            #add-point:ON ACTION controlp INFIELD b_fmclseq name="construct.c.page1.b_fmclseq"
            
            #END add-point
 
 
         #----<<b_fmcl005>>----
         #----<<b_fmcl001>>----
         #----<<b_fmck002>>----
         #----<<b_fmcl006>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_fmcj.fmcjsite,g_fmcj.fmcjdocno,g_fmcj.fmcj001
         ATTRIBUTE(WITHOUT DEFAULTS)

         BEFORE INPUT
            LET g_fmcj.fmcjsite = g_site
            CALL s_fin_orga_get_comp_ld(g_site) RETURNING l_success,g_errno,g_fmcj.fmcjcomp,l_ld
            LET g_fmcj.fmcjsite_desc = s_desc_get_department_desc(g_fmcj.fmcjsite)
            LET g_fmcj.fmcjcomp_desc = s_desc_get_department_desc(g_fmcj.fmcjcomp)
            DISPLAY BY NAME g_fmcj.*

         AFTER FIELD fmcjsite
            IF NOT cl_null(g_fmcj.fmcjsite) THEN
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj.fmcjsite
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooef001_42") THEN
                  #檢查成功時後續處理
                  CALL s_fin_orga_get_comp_ld(g_fmcj.fmcjsite) RETURNING l_success,g_errno,g_fmcj.fmcjcomp,l_ld
                  LET g_fmcj.fmcjsite_desc = s_desc_get_department_desc(g_fmcj.fmcjsite)
                  LET g_fmcj.fmcjcomp_desc = s_desc_get_department_desc(g_fmcj.fmcjcomp)
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF
            DISPLAY BY NAME g_fmcj.*

         AFTER FIELD fmcjdocno
            IF NOT cl_null(g_fmcj.fmcjdocno) THEN
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj.fmcjdocno
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "abm-00079:sub-01302|apmm100|",cl_get_progname("apmm100",g_lang,"2"),"|:EXEPROGapmm100"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmckdocno") THEN
                  #檢查成功時後續處理
                  SELECT fmcj001 INTO g_fmcj.fmcj001 FROM fmcj_t WHERE fmcjent = g_enterprise
                     AND fmcjdocno = g_fmcj.fmcjdocno
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_fmcj.fmcj001
                  CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_fmcj.fmcj001_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_fmcj.fmcj001,g_fmcj.fmcj001_desc
               ELSE
                  NEXT FIELD CURRENT
               END IF
            END IF

         AFTER FIELD fmcj001
            IF NOT cl_null(g_fmcj.fmcj001) THEN
               #欄位存在檢查
               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_fmcj.fmcj001
               #160318-00025#6--add--str
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "afm-00140:sub-01302|afmi010|",cl_get_progname("afmi010",g_lang,"2"),"|:EXEPROGafmi010"
               #160318-00025#6--add--end
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_fmaa001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  NEXT FIELD CURRENT
               END IF
            END IF
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj.fmcj001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj.fmcj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj.fmcj001_desc

         ON ACTION controlp INFIELD fmcjsite
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_fmcj.fmcjsite             #給予default值
            #161006-00005#24 20161021 mark by beckxie---S
            #LET g_qryparam.where    = " ooef201 = 'Y'"
            #CALL q_ooef001()                                #呼叫開窗
            #161006-00005#24 20161021 mark by beckxie---E
            CALL q_ooef001_33()                              #161006-00005#24 20161021 add by beckxie
            LET g_fmcj.fmcjsite = g_qryparam.return1
            DISPLAY g_fmcj.fmcjsite TO fmcjsite              #
            CALL s_fin_orga_get_comp_ld(g_fmcj.fmcjsite) RETURNING l_success,g_errno,g_fmcj.fmcjcomp,l_ld
            LET g_fmcj.fmcjsite_desc = s_desc_get_department_desc(g_fmcj.fmcjsite)
            LET g_fmcj.fmcjcomp_desc = s_desc_get_department_desc(g_fmcj.fmcjcomp)
            DISPLAY BY NAME g_fmcj.*
            NEXT FIELD fmcjsite                          #返回原欄位

         ON ACTION controlp INFIELD fmcjdocno
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj.fmcjdocno     #給予default值
            CALL q_fmcjdocno_1()                            #呼叫開窗
            LET g_fmcj.fmcjdocno = g_qryparam.return1
            LET g_fmcj.fmcj001   = g_qryparam.return2
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj.fmcj001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj.fmcj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY g_fmcj.fmcjdocno,g_fmcj.fmcj001,g_fmcj.fmcj001_desc
                 TO fmcjdocno,fmcj001,fmcj001_desc
            NEXT FIELD fmcjdocno                             #返回原欄位

         ON ACTION controlp INFIELD fmcj001
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_fmcj.fmcj001     #給予default值
            CALL q_fmaa001_1()                               #呼叫開窗
            LET g_fmcj.fmcj001 = g_qryparam.return1
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_fmcj.fmcj001
            CALL ap_ref_array2(g_ref_fields,"SELECT fmaal003 FROM fmaal_t WHERE fmaalent='"||g_enterprise||"' AND fmaal001=? AND fmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_fmcj.fmcj001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_fmcj.fmcj001_desc
            DISPLAY g_fmcj.fmcj001 TO fmcj001
            NEXT FIELD fmcj001                             #返回原欄位

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
   CALL afmq030_b_fill()
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
 
{<section id="afmq030.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afmq030_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_date          LIKE fmcl_t.fmcl005
   DEFINE l_fmcl002       LIKE fmcl_t.fmcl002
   DEFINE l_fmcl003       LIKE fmcl_t.fmcl003
   DEFINE l_fmcl004       LIKE fmcl_t.fmcl004
   DEFINE l_fmcj006       LIKE fmcj_t.fmcj006
   DEFINE l_fmcj007       LIKE fmcj_t.fmcj007
   DEFINE l_fmcj009       LIKE fmcj_t.fmcj009
   DEFINE l_fmcn007       LIKE fmcn_t.fmcn007
   DEFINE l_fmck004       LIKE fmck_t.fmck004
   DEFINE l_fmck005       LIKE fmck_t.fmck005
   DEFINE l_fmck007       LIKE fmck_t.fmck007
   DEFINE l_glaald        LIKE glaa_t.glaald
   DEFINE l_success       LIKE type_t.num5
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',fmclseq2,fmcldocno,fmclseq,fmcl005,fmcl001,'',fmcl006  ,DENSE_RANK() OVER( ORDER BY fmcl_t.fmclseq, 
       fmcl_t.fmclseq2) AS RANK FROM fmcl_t",
 
 
                     "",
                     " WHERE fmclent=? AND fmcldocno=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("fmcl_t"),
                     " ORDER BY fmcl_t.fmclseq,fmcl_t.fmclseq2"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT  UNIQUE '',fmclseq2,fmcldocno,fmclseq,fmcl005,fmcl001,'',fmcl006  ,DENSE_RANK() OVER( ORDER BY fmcl_t.fmclseq) AS RANK FROM fmcl_t,fmcj_t",
                     " WHERE fmclent=? AND ", ls_wc CLIPPED,
                     "   AND fmcjsite = '",g_fmcj.fmcjsite,"'",
                     "   AND fmcldocno = '",g_fmcj.fmcjdocno,"'",
                     "   AND fmcj001 = '",g_fmcj.fmcj001,"'",
                     "   AND fmcjent = fmclent ",
                     "   AND fmcjdocno = fmcldocno",
                     "   AND fmcjstus = 'Y'"
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("fmcl_t"),
                     " ORDER BY fmcl_t.fmclseq,fmcl_t.fmclseq2"
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
 
   LET g_sql = "SELECT '',fmclseq2,fmcldocno,fmclseq,fmcl005,fmcl001,'',fmcl006",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE afmq030_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR afmq030_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_fmcl_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   SELECT glaald INTO l_glaald FROM glaa_t WHERE glaacomp = g_fmcj.fmcjcomp
      AND glaa014 = 'Y'
      AND glaaent = g_enterprise    #160905-00002#3


   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_fmcl_d[l_ac].sel,g_fmcl_d[l_ac].fmclseq2,g_fmcl_d[l_ac].fmcldocno,g_fmcl_d[l_ac].fmclseq, 
       g_fmcl_d[l_ac].fmcl005,g_fmcl_d[l_ac].fmcl001,g_fmcl_d[l_ac].fmck002,g_fmcl_d[l_ac].fmcl006
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_fmcl_d[l_ac].statepic = cl_get_actipic(g_fmcl_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT fmck002,fmck004,fmck005,fmck007 INTO g_fmcl_d[l_ac].fmck002,l_fmck004,l_fmck005,l_fmck007
        FROM fmck_t WHERE fmckent = g_enterprise
         AND fmckdocno = g_fmcl_d[l_ac].fmcldocno
         AND fmckseq   = g_fmcl_d[l_ac].fmclseq

      IF g_fmcl_d[l_ac].fmcl001 = '2' THEN
         SELECT fmcl002,fmcl003,fmcl004 INTO l_fmcl002,l_fmcl003,l_fmcl004 FROM fmcl_t
          WHERE fmclent = g_enterprise
            AND fmcldocno = g_fmcl_d[l_ac].fmcldocno
            AND fmclseq   = g_fmcl_d[l_ac].fmclseq
            AND fmclseq2  = g_fmcl_d[l_ac].fmclseq2

         SELECT fmcj006,fmcj007,fmcj009 INTO l_fmcj006,l_fmcj007,l_fmcj009
           FROM fmcj_t WHERE fmcjent = g_enterprise
            AND fmcjdocno = g_fmcl_d[l_ac].fmcldocno
         LET g_fmcl_d[l_ac].fmcl005 = ''   #160830-00011#1 Add
      END IF

      LET l_date =""
      WHILE TRUE
         IF g_fmcl_d[l_ac].fmcl001 = '1' THEN
            EXIT WHILE
         END IF

         IF cl_null(g_fmcl_d[l_ac].fmcl005) THEN
            #首次付息日
            #160830-00011#1 Mark ---(S)---
           #IF MONTH(l_fmcj006) > l_fmcl003 THEN
           #   LET g_fmcl_d[l_ac].fmcl005 = MDY(l_fmcl003,l_fmcl004,YEAR(l_fmcj006) + 1)
           #ELSE
           #   LET g_fmcl_d[l_ac].fmcl005 = MDY(l_fmcl003,l_fmcl004,YEAR(l_fmcj006))
           #END IF
            #160830-00011#1 Mark ---(E)---
            #160830-00011#1 Add ---(S)---
            CASE
               WHEN l_fmcl002 = '2'
                  LET l_fmcl003 = l_fmcl003 * 12
               WHEN l_fmcl002 = '3'
                  LET l_fmcl003 = l_fmcl003 * 6
               WHEN l_fmcl002 = '4'
                  LET l_fmcl003 = l_fmcl003 * 3
               WHEN l_fmcl002 = '5'
                  LET l_fmcl003 = l_fmcl003 * 1
            END CASE
            IF MONTH(l_fmcj006) + l_fmcl003 > 12 THEN
               LET g_fmcl_d[l_ac].fmcl005 = MDY(MONTH(l_fmcj006) + l_fmcl003 - 12,l_fmcl004,YEAR(l_fmcj006) + 1)
            ELSE
               LET g_fmcl_d[l_ac].fmcl005 = MDY(MONTH(l_fmcj006) + l_fmcl003,l_fmcl004,YEAR(l_fmcj006))
            END IF
            IF g_fmcl_d[l_ac].fmcl005 > l_fmcj007 THEN
               LET g_fmcl_d[l_ac].fmcl005 = l_fmcj007
            END IF
            #160830-00011#1 Add ---(E)---
            LET l_date = l_fmcj006
         ELSE
            CASE
               WHEN l_fmcl002 = '2'
                  LET g_fmcl_d[l_ac].fmcl005 = s_date_get_date(g_fmcl_d[l_ac].fmcl005,12,0)
               WHEN l_fmcl002 = '3'
                  LET g_fmcl_d[l_ac].fmcl005 = s_date_get_date(g_fmcl_d[l_ac].fmcl005,6,0)
               WHEN l_fmcl002 = '4'
                  LET g_fmcl_d[l_ac].fmcl005 = s_date_get_date(g_fmcl_d[l_ac].fmcl005,3,0)
               WHEN l_fmcl002 = '5'
                  LET g_fmcl_d[l_ac].fmcl005 = s_date_get_date(g_fmcl_d[l_ac].fmcl005,1,0)
            END CASE
            IF g_fmcl_d[l_ac].fmcl005 > l_fmcj007 THEN
               LET g_fmcl_d[l_ac].fmcl005 = l_fmcj007
            END IF
            LET l_date = g_fmcl_d[l_ac - 1].fmcl005
         END IF

         IF l_fmck005 = '2' THEN
            LET l_fmcn007 = ''
            SELECT fmcn007 INTO l_fmcn007 FROM fmcn_t 
             WHERE fmcn002 IN (SELECT MAX(fmcn002) FROM fmcn_t WHERE fmcn002 <= g_fmcl_d[l_ac].fmcl005
                                  AND fmcndocno = g_fmcl_d[l_ac].fmcldocno
                                  AND fmcnseq = g_fmcl_d[l_ac].fmclseq
                                  AND fmcnent = g_enterprise
                              )
               AND fmcndocno = g_fmcl_d[l_ac].fmcldocno
               AND fmcnseq = g_fmcl_d[l_ac].fmclseq
               AND fmcnent = g_enterprise
             IF NOT cl_null(l_fmcn007) THEN
                LET l_fmck007 = l_fmcn007
             END IF
         END IF

         #計算預估利息
         LET g_fmcl_d[l_ac].fmcl006 = l_fmck004 * l_fmck007 / 100 / l_fmcj009 * (g_fmcl_d[l_ac].fmcl005 - l_date)
         CALL s_curr_round_ld('1',l_glaald,g_fmcl_d[l_ac].fmck002,g_fmcl_d[l_ac].fmcl006,2)
            RETURNING l_success,g_errno,g_fmcl_d[l_ac].fmcl006

         IF g_fmcl_d[l_ac].fmcl005 = l_fmcj007 OR l_fmcl002 = '1' THEN #160830-00011#1 Add 
            EXIT WHILE
         ELSE
            LET g_fmcl_d[l_ac + 1].* = g_fmcl_d[l_ac].*
            LET l_ac = l_ac + 1
         END IF

      END　WHILE

      #end add-point
 
      CALL afmq030_detail_show("'1'")      
 
      CALL afmq030_fmcl_t_mask()
 
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
   
 
   
   CALL g_fmcl_d.deleteElement(g_fmcl_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_fmcl_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE afmq030_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afmq030_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afmq030_detail_action_trans()
 
   IF g_fmcl_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL afmq030_fetch()
   END IF
   
      CALL afmq030_filter_show('fmclseq2','b_fmclseq2')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afmq030_fetch()
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
 
{<section id="afmq030.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afmq030_detail_show(ps_page)
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
 
{<section id="afmq030.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION afmq030_filter()
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
      CONSTRUCT g_wc_filter ON fmclseq2
                          FROM s_detail1[1].b_fmclseq2
 
         BEFORE CONSTRUCT
                     DISPLAY afmq030_filter_parser('fmclseq2') TO s_detail1[1].b_fmclseq2
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_fmclseq2>>----
         #Ctrlp:construct.c.filter.page1.b_fmclseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmclseq2
            #add-point:ON ACTION controlp INFIELD b_fmclseq2 name="construct.c.filter.page1.b_fmclseq2"
            
            #END add-point
 
 
         #----<<b_fmcldocno>>----
         #----<<b_fmclseq>>----
         #Ctrlp:construct.c.filter.page1.b_fmclseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_fmclseq
            #add-point:ON ACTION controlp INFIELD b_fmclseq name="construct.c.filter.page1.b_fmclseq"
            
            #END add-point
 
 
         #----<<b_fmcl005>>----
         #----<<b_fmcl001>>----
         #----<<b_fmck002>>----
         #----<<b_fmcl006>>----
   
 
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
   
      CALL afmq030_filter_show('fmclseq2','b_fmclseq2')
 
    
   CALL afmq030_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION afmq030_filter_parser(ps_field)
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
 
{<section id="afmq030.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION afmq030_filter_show(ps_field,ps_object)
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
   LET ls_condition = afmq030_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.insert" >}
#+ insert
PRIVATE FUNCTION afmq030_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmq030.modify" >}
#+ modify
PRIVATE FUNCTION afmq030_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.reproduce" >}
#+ reproduce
PRIVATE FUNCTION afmq030_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.delete" >}
#+ delete
PRIVATE FUNCTION afmq030_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="afmq030.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afmq030_detail_action_trans()
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
 
{<section id="afmq030.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afmq030_detail_index_setting()
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
            IF g_fmcl_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_fmcl_d.getLength() AND g_fmcl_d.getLength() > 0
            LET g_detail_idx = g_fmcl_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_fmcl_d.getLength() THEN
               LET g_detail_idx = g_fmcl_d.getLength()
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
 
{<section id="afmq030.mask_functions" >}
 &include "erp/afm/afmq030_mask.4gl"
 
{</section>}
 
{<section id="afmq030.other_function" readonly="Y" >}

 
{</section>}
 
