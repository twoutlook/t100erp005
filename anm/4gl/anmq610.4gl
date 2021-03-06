#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq610.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-08-18 14:17:48), PR版次:0007(2016-09-29 14:34:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000043
#+ Filename...: anmq610
#+ Description: 資金系統現金流量表
#+ Creator....: 02097(2015-08-03 10:44:29)
#+ Modifier...: 06816 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq610.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151013-00016#6  2015/10/29 By RayHuang anmq610/620 add glbc015 = 'Y'
#160321-00016#39 2016/03/30 By Jessy    將重複內容的錯誤訊息置換為公用錯誤訊息
#160704-00011#8  2016/7/26  By 02599    现金变动码的直接法改用公用函数s_cashflow_direct抓取
#160125-00005#8  2016/08/08 By 02599    查詢時加上帳套人員權限條件過濾
#160905-00007#8  2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160816-00012#4  2016/09/20  By 07900    ANM增加资金中心，帐套，法人三个栏位权限
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
PRIVATE TYPE type_g_glbc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       nmail004 LIKE nmail_t.nmail004, 
   nmai004 LIKE nmai_t.nmai004, 
   l_amt1 LIKE type_t.num20_6, 
   l_amt2 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE tm    RECORD
         b_glaald          LIKE glaa_t.glaald,
         b_glaacomp        LIKE glaa_t.glaacomp,
         b_glaald_desc     LIKE type_t.chr500,
         b_glaacomp_desc   LIKE type_t.chr500,
         b_glbc001         LIKE glbc_t.glbc001,
         b_glbc002s        LIKE glbc_t.glbc002,
         b_glbc002e        LIKE glbc_t.glbc002,
         b_glbc0011        LIKE glbc_t.glbc001,
         b_glbc0021s       LIKE glbc_t.glbc002,
         b_glbc0021e       LIKE glbc_t.glbc002
           END RECORD
DEFINE g_glaa003 LIKE glaa_t.glaa003
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glbc_d
DEFINE g_master_t                   type_g_glbc_d
DEFINE g_glbc_d          DYNAMIC ARRAY OF type_g_glbc_d
DEFINE g_glbc_d_t        type_g_glbc_d
 
      
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
 
{<section id="anmq610.main" >}
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
   CALL cl_ap_init("anm","")
 
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
   DECLARE anmq610_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq610_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq610_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq610 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq610_init()   
 
      #進入選單 Menu (="N")
      CALL anmq610_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq610
      
   END IF 
   
   CLOSE anmq610_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq610.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq610_init()
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
   CALL anmq610_create_tmp()
   #end add-point
 
   CALL anmq610_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq610.default_search" >}
PRIVATE FUNCTION anmq610_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glbcld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glbcdocno = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glbcseq = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " glbcseq1 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " glbc001 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " glbc002 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " glbc010 = '", g_argv[07], "' AND "
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
 
{<section id="anmq610.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq610_ui_dialog()
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
      CALL anmq610_b_fill()
   ELSE
      CALL anmq610_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glbc_d.clear()
 
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
 
         CALL anmq610_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glbc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq610_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq610_detail_action_trans()
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
            CALL anmq610_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq610_query()
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
            CALL anmq610_filter()
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
            CALL anmq610_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glbc_d)
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
            CALL anmq610_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq610_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq610_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq610_b_fill()
 
         
         
 
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
 
{<section id="anmq610.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq610_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_max      LIKE type_t.num5
   DEFINE l_min      LIKE type_t.num5
   DEFINE l_ld_str   STRING                  #160125-00005#8
   DEFINE l_glaald   LIKE glaa_t.glaald      #160816-00012#4
   DEFINE l_glaald_desc  LIKE type_t.chr500  #160816-00012#4
   DEFINE l_glaacomp LIKE glaa_t.glaacomp    #160816-00012#4
   DEFINE l_glaacomp_desc LIKE type_t.chr500  #160816-00012#4
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glbc_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON nmail004,nmai004
           FROM s_detail1[1].b_nmail004,s_detail1[1].b_nmai004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_nmail004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmail004
            #add-point:BEFORE FIELD b_nmail004 name="construct.b.page1.b_nmail004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmail004
            
            #add-point:AFTER FIELD b_nmail004 name="construct.a.page1.b_nmail004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmail004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmail004
            #add-point:ON ACTION controlp INFIELD b_nmail004 name="construct.c.page1.b_nmail004"
            
            #END add-point
 
 
         #----<<b_nmai004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmai004
            #add-point:BEFORE FIELD b_nmai004 name="construct.b.page1.b_nmai004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmai004
            
            #add-point:AFTER FIELD b_nmai004 name="construct.a.page1.b_nmai004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmai004
            #add-point:ON ACTION controlp INFIELD b_nmai004 name="construct.c.page1.b_nmai004"
            
            #END add-point
 
 
         #----<<l_amt1>>----
         #----<<l_amt2>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
     #BEFORE DIALOG
     #   NEXT FIELD b_glaald
      #INPUT 條件
      INPUT tm.b_glaald,
            tm.b_glbc001 ,tm.b_glbc002s ,tm.b_glbc002e,
            tm.b_glbc0011,tm.b_glbc0021s,tm.b_glbc0021e
       FROM b_glaald,
            b_glbc001 ,b_glbc002s ,b_glbc002e,
            b_glbc0011,b_glbc0021s,b_glbc0021e
            ATTRIBUTE(WITHOUT DEFAULTS)
         #160816-00012#4--add--s--
         BEFORE FIELD b_glaald 
             LET l_glaald = tm.b_glaald                  
             LET l_glaald_desc = tm.b_glaald_desc 
             LET l_glaacomp = tm.b_glaacomp
             LET l_glaacomp_desc = tm.b_glaacomp_desc
         #160816-00012#4--add--e--                 
         ON ACTION controlp INFIELD b_glaald
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.b_glaald
            LET g_qryparam.arg1 = g_user                                 #人員權限
            LET g_qryparam.arg2 = g_dept                                 #部門權限
            #160125-00005#8--add--str--
            #账套范围
            CALL s_axrt300_get_site(g_user,'','2')  RETURNING l_ld_str 
            IF NOT cl_null(l_ld_str) THEN   
               LET g_qryparam.where = l_ld_str
            END IF
            #160125-00005#8--add--end
            CALL q_authorised_ld()                                 
            LET tm.b_glaald = g_qryparam.return1
            CALL s_desc_get_ld_desc(tm.b_glaald) RETURNING tm.b_glaald_desc
            CALL s_fin_ld_carry(tm.b_glaald,'')  RETURNING g_sub_success,tm.b_glaald,tm.b_glaacomp,g_errno
            CALL s_desc_get_department_desc(tm.b_glaacomp) RETURNING tm.b_glaacomp_desc
            DISPLAY BY NAME tm.b_glaald,tm.b_glaald_desc,tm.b_glaacomp,tm.b_glaacomp_desc            
         
         AFTER FIELD b_glaald
            IF NOT cl_null(tm.b_glaald) THEN
               CALL s_fin_ld_chk(tm.b_glaald,g_user,'Y') RETURNING g_sub_success,g_errno  #160816-00012#4  add 'Y'
               IF NOT g_sub_success THEN
                  
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code  = g_errno
                  #160321-00016#39 --s add
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  #160321-00016#39 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET tm.b_glaald = l_glaald  #160816-00012#4 add l_glaald
                  LET tm.b_glaald_desc = l_glaald_desc  #160816-00012#4 add l_glaald_desc
                  LET tm.b_glaacomp = l_glaacomp  #160816-00012#4 add l_glaacomp 
                  LET tm.b_glaacomp_desc = l_glaacomp_desc #160816-00012#4 add  l_glaacomp_desc
                  DISPLAY BY NAME tm.b_glaald,tm.b_glaald_desc,tm.b_glaacomp,tm.b_glaacomp_desc
                  NEXT FIELD b_glaald
               END IF
               SELECT glaa003 INTO g_glaa003 FROM glaa_t WHERE glaald = tm.b_glaald AND glaaent = g_enterprise  #160905-00007#8 add glaaent = g_enterprise  
               CALL s_desc_get_ld_desc(tm.b_glaald) RETURNING tm.b_glaald_desc
               CALL s_fin_ld_carry(tm.b_glaald,'')  RETURNING g_sub_success,tm.b_glaald,tm.b_glaacomp,g_errno
               CALL s_desc_get_department_desc(tm.b_glaacomp) RETURNING tm.b_glaacomp_desc
               DISPLAY BY NAME tm.b_glaald,tm.b_glaald_desc,tm.b_glaacomp,tm.b_glaacomp_desc
            END IF
         
         AFTER FIELD b_glbc001   #本期年度
            IF NOT cl_null(tm.b_glbc001) THEN
               IF tm.b_glbc001 < 2000 OR tm.b_glbc001 > 2999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code  = "aap-00225"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc001
               END IF
            END IF
            
         AFTER FIELD b_glbc0011  #上期年度
            IF NOT cl_null(tm.b_glbc001) THEN
               IF tm.b_glbc0011 < 2000 OR tm.b_glbc0011 > 2999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code  = "aap-00225"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc0011
               END IF
            END IF
            
         AFTER FIELD b_glbc002s  #本期起始期別
            IF NOT cl_null(tm.b_glaald) AND NOT cl_null(tm.b_glbc001) 
            AND NOT cl_null(tm.b_glbc002s) AND NOT cl_null(tm.b_glbc002e) THEN
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = g_glaa003  AND glav002 = tm.b_glbc001 AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
               IF tm.b_glbc002s < l_min OR tm.b_glbc002s > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = tm.b_glbc002s
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc002s
               END IF
               IF tm.b_glbc002s > tm.b_glbc002e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = tm.b_glbc002s
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc002s
               END IF
            END IF
            
         AFTER FIELD b_glbc002e  #本期截止期別
            IF NOT cl_null(tm.b_glaald) AND NOT cl_null(tm.b_glbc001) 
            AND NOT cl_null(tm.b_glbc002s) AND NOT cl_null(tm.b_glbc002e) THEN
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = g_glaa003  AND glav002 = tm.b_glbc001 AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
               IF tm.b_glbc002e < l_min OR tm.b_glbc002e > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = tm.b_glbc002e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc002e
               END IF
               IF tm.b_glbc002e < tm.b_glbc002s THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = tm.b_glbc002e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc002e
               END IF
            END IF
         AFTER FIELD b_glbc0021s  #上期起始期別
            IF NOT cl_null(tm.b_glaald) AND NOT cl_null(tm.b_glbc0011) 
            AND NOT cl_null(tm.b_glbc0021s) AND NOT cl_null(tm.b_glbc0021e) THEN
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = g_glaa003  AND glav002 = tm.b_glbc001 AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
               IF tm.b_glbc0021s < l_min OR tm.b_glbc0021s > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = tm.b_glbc0021s
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc0021s
               END IF
               IF tm.b_glbc0021s > tm.b_glbc0021e THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = tm.b_glbc0021s
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc0021s
               END IF
            END IF
            
         AFTER FIELD b_glbc0021e  #上期截止期別
            IF NOT cl_null(tm.b_glaald) AND NOT cl_null(tm.b_glbc0011) 
            AND NOT cl_null(tm.b_glbc0021s) AND NOT cl_null(tm.b_glbc0021e) THEN
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = g_glaa003  AND glav002 = tm.b_glbc001 AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
               IF tm.b_glbc0021e < l_min OR tm.b_glbc0021e > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = tm.b_glbc0021e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc0021e
               END IF
               IF tm.b_glbc0021e < tm.b_glbc0021s THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = tm.b_glbc0021e
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD b_glbc0021e
               END IF
            END IF   
      END INPUT
      
      BEFORE DIALOG
         CALL anmq610_qbe_clear()
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
         CALL anmq610_qbe_clear()
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
   CALL anmq610_b_fill()
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
 
{<section id="anmq610.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq610_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL anmq610_insert_tmp()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','',''  ,DENSE_RANK() OVER( ORDER BY glbc_t.glbcld,glbc_t.glbcdocno, 
       glbc_t.glbcseq,glbc_t.glbcseq1,glbc_t.glbc001,glbc_t.glbc002,glbc_t.glbc010) AS RANK FROM glbc_t", 
 
 
 
                     "",
                     " WHERE glbcent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glbc_t"),
                     " ORDER BY glbc_t.glbcld,glbc_t.glbcdocno,glbc_t.glbcseq,glbc_t.glbcseq1,glbc_t.glbc001,glbc_t.glbc002,glbc_t.glbc010"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq ",
                     "  FROM anmq610_tmp",
                     " WHERE glbcent= ? AND 1=1 AND ",ls_wc,
                     " ORDER BY seq"
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
 
   LET g_sql = "SELECT '','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT nmail004,nmai004,amt1,amt2 ",
               " FROM (",ls_sql_rank,")"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq610_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq610_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glbc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glbc_d[l_ac].nmail004,g_glbc_d[l_ac].nmai004,g_glbc_d[l_ac].l_amt1,g_glbc_d[l_ac].l_amt2 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glbc_d[l_ac].statepic = cl_get_actipic(g_glbc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL anmq610_detail_show("'1'")      
 
      CALL anmq610_glbc_t_mask()
 
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
   
 
   
   CALL g_glbc_d.deleteElement(g_glbc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glbc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq610_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq610_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq610_detail_action_trans()
 
   IF g_glbc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq610_fetch()
   END IF
   
      CALL anmq610_filter_show('nmail004','b_nmail004')
   CALL anmq610_filter_show('nmai004','b_nmai004')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq610_fetch()
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
 
{<section id="anmq610.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq610_detail_show(ps_page)
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
 
{<section id="anmq610.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq610_filter()
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
      CONSTRUCT g_wc_filter ON nmail004,nmai004
                          FROM s_detail1[1].b_nmail004,s_detail1[1].b_nmai004
 
         BEFORE CONSTRUCT
                     DISPLAY anmq610_filter_parser('nmail004') TO s_detail1[1].b_nmail004
            DISPLAY anmq610_filter_parser('nmai004') TO s_detail1[1].b_nmai004
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_nmail004>>----
         #Ctrlp:construct.c.filter.page1.b_nmail004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmail004
            #add-point:ON ACTION controlp INFIELD b_nmail004 name="construct.c.filter.page1.b_nmail004"
            
            #END add-point
 
 
         #----<<b_nmai004>>----
         #Ctrlp:construct.c.filter.page1.b_nmai004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmai004
            #add-point:ON ACTION controlp INFIELD b_nmai004 name="construct.c.filter.page1.b_nmai004"
            
            #END add-point
 
 
         #----<<l_amt1>>----
         #----<<l_amt2>>----
   
 
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
   
      CALL anmq610_filter_show('nmail004','b_nmail004')
   CALL anmq610_filter_show('nmai004','b_nmai004')
 
    
   CALL anmq610_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq610_filter_parser(ps_field)
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
 
{<section id="anmq610.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq610_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq610_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.insert" >}
#+ insert
PRIVATE FUNCTION anmq610_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq610.modify" >}
#+ modify
PRIVATE FUNCTION anmq610_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq610_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.delete" >}
#+ delete
PRIVATE FUNCTION anmq610_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq610.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq610_detail_action_trans()
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
 
{<section id="anmq610.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq610_detail_index_setting()
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
            IF g_glbc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glbc_d.getLength() AND g_glbc_d.getLength() > 0
            LET g_detail_idx = g_glbc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glbc_d.getLength() THEN
               LET g_detail_idx = g_glbc_d.getLength()
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
 
{<section id="anmq610.mask_functions" >}
 &include "erp/anm/anmq610_mask.4gl"
 
{</section>}
 
{<section id="anmq610.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL anmq610_create_tmp()
# Date & Author..: 15/08/18  By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq610_create_tmp()
DROP TABLE anmq610_tmp;
   CREATE TEMP TABLE anmq610_tmp(
   glbcent        LIKE glbc_t.glbcent,
#   nmak002        LIKE nmak_t.nmak002, #160704-00011#8 mark
   nmak002        LIKE nmai_t.nmai002,  #160704-00011#8 add
   nmail004       LIKE nmail_t.nmail004,
   nmai004        LIKE nmai_t.nmai004,
   amt1           LIKE type_t.num20_6,
   amt2           LIKE type_t.num20_6,
   seq            LIKE type_t.num5
   );
END FUNCTION
################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmq610_insert_tmp()
# Date & Author..: 150818 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq610_insert_tmp()
DEFINE l_sql      STRING
DEFINE l_seq      LIKE type_t.num5
DEFINE l_count    LIKE type_t.num5
DEFINE l_nmak001  LIKE nmak_t.nmak001
DEFINE l_nmakl003 LIKE nmakl_t.nmakl003
DEFINE l_nmak002  LIKE nmak_t.nmak002
DEFINE l_nmai002  LIKE nmai_t.nmai002
DEFINE l_nmail004 LIKE nmail_t.nmail004
DEFINE l_nmai004  LIKE nmai_t.nmai004
DEFINE l_amt1     LIKE type_t.num20_6
DEFINE l_amt2     LIKE type_t.num20_6
DEFINE l_before   LIKE type_t.num20_6
DEFINE l_after    LIKE type_t.num20_6
DEFINE l_total1   LIKE type_t.num20_6
DEFINE l_total2   LIKE type_t.num20_6
DEFINE l_nmbx001  LIKE nmbx_t.nmbx001
DEFINE l_nmbx002  LIKE nmbx_t.nmbx002
DEFINE l_glav006  LIKE glav_t.glav006
DEFINE l_msg      LIKE type_t.chr500
   DELETE FROM anmq610_tmp
   
   #160704-00011#8--add--str--
   #直接法计算逻辑拿到sub s_cashflow_direct()中，原抓取资料逻辑mark，调用sub
   #注：因anmq610的现金变动码来源是glbc010=2.资金模组，所以sub中的参数从小数位数开始，可传入默认值。
   CALL cl_err_collect_init()
   LET g_success = TRUE
                          #账套/来源/本期年度/本期起始期别/本期截止期别/上期年度/上期起始期别/上期截止期别
   CALL s_cashflow_direct(tm.b_glaald,'2',tm.b_glbc001,tm.b_glbc002s,tm.b_glbc002e,tm.b_glbc0011,tm.b_glbc0021s,tm.b_glbc0021e,
                          #小数位数/单位/含审计调整凭证/凭证状态/是否转换币别/转换币别/转换汇率
                          NULL,'1','N','1','N',NULL,NULL)
   RETURNING g_success
   UPDATE anmq610_tmp SET glbcent = g_enterprise
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'UPDATE anmq610_tmp'
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_success = FALSE
   END IF
   CALL cl_err_collect_show()
   #160704-00011#8 --add--end
   
#160704-00011#8--mark--str--
#   LET g_sql="SELECT DISTINCT nmak001,nmakl003,nmak002",
#             "  FROM nmak_t LEFT JOIN nmakl_t ON nmakent=nmaklent AND nmakl001=nmak001 ",
#             "          AND nmaklent='"||g_enterprise||"' AND nmakl002='"||g_dlang||"' ",
#             " WHERE nmakent=",g_enterprise," AND nmakstus='Y'AND nmak002 <>'5'        ",
#             " ORDER BY nmak002,nmak001                                                "      
#   PREPARE anmq610_pr1 FROM g_sql
#   DECLARE anmq610_cs1 CURSOR FOR anmq610_pr1  
#   #現金變動碼分類下包含的現金變動碼的數量
#   LET g_sql="SELECT COUNT(DISTINCT nmai002) ",
#             "  FROM nmai_t ",
#             " WHERE nmaient=",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
#             "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.b_glaald,"' )"    
#   PREPARE anmq610_count_pr FROM g_sql
#   #抓取現金變動碼資料
#   LET g_sql="SELECT DISTINCT nmai002,nmail004,nmai004 ",
#             "  FROM nmai_t ",
#             "  LEFT JOIN nmail_t ON nmaient=nmailent AND nmai001=nmail001 AND nmai002=nmail002 AND nmailent='"||g_enterprise||"' AND nmail003='"||g_dlang||"' ",
#             " WHERE nmaient = ",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
#             "   AND nmai001 = (SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.b_glaald,"' )",
#             " ORDER BY nmai002,nmai004"          
#   PREPARE anmq610_pr2 FROM g_sql
#   DECLARE anmq610_cs2 CURSOR FOR anmq610_pr2
#   LET g_sql="SELECT SUM(COALESCE(CASE WHEN glbc003='1' THEN glbc009 ELSE (-1)*glbc009 END,0)) ",
#             "  FROM glbc_t ",  
#             " WHERE glbcent=",g_enterprise," AND glbc010 = '2'    ",
#             "   AND glbcld='",tm.b_glaald,"' AND glbc015 = 'Y'    ",  #151013-00016#6 add
#             "   AND glbc001=? AND glbc002 BETWEEN ? AND ? ",
#             "   AND glbc004=? "          
#   PREPARE anmq610_pr3 FROM g_sql
#   LET l_seq = 0 
#   LET l_msg = cl_getmsg("lib-00156",g_lang)
#   FOREACH anmq610_cs1 INTO l_nmak001,l_nmakl003,l_nmak002
#      #判斷該現金變動碼分類下是否包含現金變動碼
#      LET l_count = 0
#      EXECUTE anmq610_count_pr USING l_nmak001 INTO l_count
#      IF l_count = 0 THEN
#         CONTINUE FOREACH
#      END IF
#      LET l_seq = l_seq + 1
#      LET l_total1 = 0
#      LET l_total2 = 0
#      INSERT INTO anmq610_tmp(glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq)
#                       VALUES(g_enterprise,l_nmak002,l_nmakl003,'','','',l_seq)
#      FOREACH anmq610_cs2 USING l_nmak001 INTO l_nmai002,l_nmail004,l_nmai004 
#         LET l_seq=l_seq + 1
#         #本期數
#         EXECUTE anmq610_pr3 USING tm.b_glbc001,tm.b_glbc002s,tm.b_glbc002e,l_nmai002 INTO l_amt1
#         #上期數
#         EXECUTE anmq610_pr3 USING tm.b_glbc0011,tm.b_glbc0021s,tm.b_glbc0021e,l_nmai002 INTO l_amt2
#         IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
#         IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
#         LET l_total1 = l_total1 + l_amt1
#         LET l_total2 = l_total2 + l_amt2
#         INSERT INTO anmq610_tmp(glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq)
#              VALUES(g_enterprise,l_nmak002,l_nmail004,l_nmai004,l_amt1,l_amt2,l_seq)
#      END FOREACH
#      LET l_seq = l_seq + 1
#      INSERT INTO anmq610_tmp(glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq)
#                       VALUES(g_enterprise,'',l_msg,'',l_total1,l_total2,l_seq)
#   END FOREACH
#   
##   LET l_seq = l_seq + 1 
##   #變動碼大類 = 4
##   LET l_amt1 = 0
##   LET l_amt2 = 0
##   #先把大類 = 4的加總起來
##   SELECT SUM(COALESCE(amt1,0)),SUM(COALESCE(amt2,0)) INTO l_amt1,l_amt2          
##     FROM anmq610_tmp
##    WHERE nmak002 = '4'
#    #刪除4的資料
#   DELETE FROM anmq610_tmp
#    WHERE nmak002 = '4';
#   UPDATE anmq610_tmp
#      SET nmak002 = '4' , nmail004 = l_nmakl003 
#    WHERE seq = l_seq
##    #放入合計後的金額
##    INSERT INTO anmq610_tmp(glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq)
##              VALUES(g_enterprise,'4',l_nmail004,l_nmai004,l_amt1,l_amt2,l_seq)
#   #大類 = 5 
#   LET l_seq = l_seq + 1
#   LET l_after = 0
#   LET l_before = 0
#   SELECT DISTINCT nmakl003,nmak002 INTO l_nmakl003,l_nmak002
#     FROM nmak_t LEFT JOIN nmakl_t ON nmakent = nmaklent AND nmakl001=nmak001 
#      AND nmakl002 = g_dlang
#    WHERE nmakent= g_enterprise AND nmakstus='Y'AND nmak002  = '5'       
#   #本期(現金及現金等價物淨增加額)
#   SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_after
#     FROM nmbx_t 
#    WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#      AND nmbx001 = tm.b_glbc001 AND nmbx002 = tm.b_glbc002e
#   IF cl_null(l_after) THEN LET l_after = 0 END IF
#   IF tm.b_glbc002s = '1' THEN
#      SELECT MAX(glav006) INTO l_glav006 
#        FROM glav_t
#       WHERE glav001 = g_glaa003 AND glav002 = tm.b_glbc001
#      LET l_nmbx001 = tm.b_glbc001 - 1
#      LET l_nmbx002 = l_glav006
#      SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_before
#        FROM nmbx_t 
#       WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#         AND nmbx001 = l_nmbx001 AND nmbx002 = l_nmbx002
#   ELSE
#      LET l_nmbx001 = tm.b_glbc001 
#      LET l_nmbx002 = l_glav006 -1
#      SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_before
#        FROM nmbx_t 
#       WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#         AND nmbx001 = l_nmbx001 AND nmbx002 = l_nmbx002
#   END IF
#   IF cl_null(l_before) THEN LET l_before = 0 END IF
#   LET l_amt1 = l_after - l_before
#   #上期(現金及現金等價物淨增加額)
#   LET l_after = 0
#   LET l_before = 0
#   SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_after
#     FROM nmbx_t 
#    WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#      AND nmbx001 = tm.b_glbc0011 AND nmbx002 = tm.b_glbc0021e
#   IF cl_null(l_after) THEN LET l_after = 0 END IF
#   IF tm.b_glbc0021s = '1' THEN
#      SELECT MAX(glav006) INTO l_glav006 
#        FROM glav_t
#       WHERE glav001 = g_glaa003 AND glav002 = tm.b_glbc0011
#      LET l_nmbx001 = tm.b_glbc0011 - 1
#      LET l_nmbx002 = l_glav006
#      SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_before
#        FROM nmbx_t 
#       WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#         AND nmbx001 = l_nmbx001 AND nmbx002 = l_nmbx002
#   ELSE
#      LET l_nmbx001 = tm.b_glbc0011 
#      LET l_nmbx002 = l_glav006 - 1
#      SELECT SUM(COALESCE(nmbx113,0)) - SUM(COALESCE(nmbx114,0))  INTO l_before
#        FROM nmbx_t 
#       WHERE nmbxent = g_enterprise AND nmbxcomp = tm.b_glaacomp 
#         AND nmbx001 = l_nmbx001 AND nmbx002 = l_nmbx002
#   END IF
#   IF cl_null(l_before) THEN LET l_before = 0 END IF
#   LET l_amt2 = l_after - l_before
#   INSERT INTO anmq610_tmp(glbcent,nmak002,nmail004,nmai004,amt1,amt2,seq)
#          VALUES(g_enterprise,'5',l_nmakl003,'',l_amt1,l_amt2,l_seq)
#   CALL cl_err_collect_show()
 #160704-00011#8--mark--end
END FUNCTION
################################################################################
# Descriptions...: 清空還原預設
# Memo...........: 
# Usage..........: CALL anmq610_qbe_clear()
# Date & Author..: 150818 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq610_qbe_clear()
DEFINE l_success  LIKE type_t.num5
DEFINE l_glav006  LIKE glav_t.glav006
   #清空欄位
   CLEAR FORM
   INITIALIZE tm.* TO NULL
   CALL g_glbc_d.clear()
   #給帳套預設值
   CALL s_ld_bookno()  RETURNING l_success,tm.b_glaald   
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   #帶出所屬法人
   SELECT glaacomp,glaa003
     INTO tm.b_glaacomp,g_glaa003
     FROM glaa_t
    WHERE glaald = tm.b_glaald AND glaaent = g_enterprise
   
   #預設年度-當前年度
   LET tm.b_glbc001 = YEAR(g_today) 
   #預設期別-當前期別
   SELECT glav006 INTO l_glav006 FROM glav_t
    WHERE glav001 = g_glaa003 AND glav002 = tm.b_glbc001
      AND glav004 = g_today
      AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
   LET tm.b_glbc002s = l_glav006
   LET tm.b_glbc002e = l_glav006
   #判斷上期年度&期別
   IF l_glav006 = '1' THEN
      SELECT MAX(glav006) INTO l_glav006 
        FROM glav_t
       WHERE glav001 = g_glaa003 AND glav002 = tm.b_glbc001
         AND glavent = g_enterprise  #160905-00007#8 add glavent = g_enterprise 
      LET tm.b_glbc0011  = tm.b_glbc001 - 1
      LET tm.b_glbc0021s = l_glav006
      LET tm.b_glbc0021e = l_glav006
   ELSE
      LET tm.b_glbc0011  = tm.b_glbc001
      LET tm.b_glbc0021s = tm.b_glbc002s - 1
      LET tm.b_glbc0021e = tm.b_glbc002s - 1
   END IF
   
   #帳套及法人說明
   LET tm.b_glaald_desc = s_desc_get_ld_desc(tm.b_glaald)
   LET tm.b_glaacomp_desc = s_desc_get_department_desc(tm.b_glaacomp) 
   
   DISPLAY BY NAME tm.b_glaald,tm.b_glaald_desc,
                   tm.b_glaacomp,tm.b_glaacomp_desc,
                   tm.b_glbc001,tm.b_glbc0011,
                   tm.b_glbc002s,tm.b_glbc0021e,
                   tm.b_glbc002s,tm.b_glbc0021e
END FUNCTION

 
{</section>}
 
