#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq970.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-10-28 15:02:45), PR版次:0004(2016-10-24 15:04:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: anmq970
#+ Description: 資金計劃狀況查詢
#+ Creator....: 02291(2015-10-15 14:08:53)
#+ Modifier...: 02291 -SD/PR- 08729
 
{</section>}
 
{<section id="anmq970.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#4  2016/07/28 By 08742   系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#161021-00050#2  2016/10/24 By 08729   處理組織開窗
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
PRIVATE TYPE type_g_nmbj_d RECORD
       #statepic       LIKE type_t.chr1,
       
       nmbj001 LIKE nmbj_t.nmbj001, 
   nmbj001_desc LIKE type_t.chr500, 
   nmbj002 LIKE nmbj_t.nmbj002, 
   nmbj002_desc LIKE type_t.chr500, 
   nmbj003 LIKE nmbj_t.nmbj003, 
   nmbj004 LIKE nmbj_t.nmbj004, 
   nmbj005 LIKE nmbj_t.nmbj005, 
   nmbj005_desc LIKE type_t.chr500, 
   nmbj006 LIKE nmbj_t.nmbj006, 
   nmbj007 LIKE nmbj_t.nmbj007, 
   nmbj008 LIKE nmbj_t.nmbj008, 
   nmbc103 LIKE type_t.num20_6, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_nmbj_d
DEFINE g_master_t                   type_g_nmbj_d
DEFINE g_nmbj_d          DYNAMIC ARRAY OF type_g_nmbj_d
DEFINE g_nmbj_d_t        type_g_nmbj_d
 
      
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
type type_g_nmbi_m        RECORD
      nmbi001        LIKE nmbi_t.nmbi001,
      nmbi001_desc   LIKE type_t.chr80,
      nmbidocno      LIKE nmbi_t.nmbidocno,
      a              LIKE type_t.chr1
     END RECORD
DEFINE g_nmbi_m          type_g_nmbi_m
            
DEFINE g_nmbi003      LIKE nmbi_t.nmbi003
DEFINE g_ooed001      LIKE ooed_t.ooed001
DEFINE g_ooed002      LIKE ooed_t.ooed002
DEFINE g_ooed003      LIKE ooed_t.ooed003
DEFINE g_ooed005      LIKE ooed_t.ooed005
DEFINE g_nmbi001_str  STRING
#end add-point
 
{</section>}
 
{<section id="anmq970.main" >}
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
   DECLARE anmq970_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq970_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq970_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq970 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq970_init()   
 
      #進入選單 Menu (="N")
      CALL anmq970_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq970
      
   END IF 
   
   CLOSE anmq970_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE anmq970_xg_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq970.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq970_init()
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
   CALL anmq970_create_tmp()
   LET g_nmbi_m.a = '0'
   DISPLAY g_nmbi_m.a TO a
   #end add-point
 
   CALL anmq970_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq970.default_search" >}
PRIVATE FUNCTION anmq970_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmbjdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmbjseq = '", g_argv[02], "' AND "
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
 
{<section id="anmq970.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq970_ui_dialog()
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
      CALL anmq970_b_fill()
   ELSE
      CALL anmq970_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmbj_d.clear()
 
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
 
         CALL anmq970_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmbj_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq970_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq970_detail_action_trans()
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
            CALL anmq970_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL anmq970_x01(' 1=1','anmq970_tmp01')          #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL anmq970_x01(' 1=1','anmq970_tmp01')          #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq970_query()
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
            CALL anmq970_filter()
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
            CALL anmq970_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmbj_d)
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
            CALL anmq970_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq970_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq970_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq970_b_fill()
 
         
         
 
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
 
{<section id="anmq970.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq970_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_n        LIKE type_t.num5
   DEFINE l_nmbi001  LIKE nmbi_t.nmbi001
   DEFINE l_sql      STRING
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmbj_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON nmbj001,nmbj002,nmbj003,nmbj004,nmbj005,nmbj006,nmbj007,nmbj008
           FROM s_detail1[1].b_nmbj001,s_detail1[1].b_nmbj002,s_detail1[1].b_nmbj003,s_detail1[1].b_nmbj004, 
               s_detail1[1].b_nmbj005,s_detail1[1].b_nmbj006,s_detail1[1].b_nmbj007,s_detail1[1].b_nmbj008 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_nmbj001>>----
         #Ctrlp:construct.c.page1.b_nmbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj001
            #add-point:ON ACTION controlp INFIELD b_nmbj001 name="construct.c.page1.b_nmbj001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbh004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj001  #顯示到畫面上
            NEXT FIELD b_nmbj001                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj001
            #add-point:BEFORE FIELD b_nmbj001 name="construct.b.page1.b_nmbj001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj001
            
            #add-point:AFTER FIELD b_nmbj001 name="construct.a.page1.b_nmbj001"
            
            #END add-point
            
 
 
         #----<<b_nmbj001_desc>>----
         #----<<b_nmbj002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj002
            #add-point:BEFORE FIELD b_nmbj002 name="construct.b.page1.b_nmbj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj002
            
            #add-point:AFTER FIELD b_nmbj002 name="construct.a.page1.b_nmbj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj002
            #add-point:ON ACTION controlp INFIELD b_nmbj002 name="construct.c.page1.b_nmbj002"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_nmbi003
            CALL q_nmbd002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj002  #顯示到畫面上
            NEXT FIELD b_nmbj002 
            #END add-point
 
 
         #----<<b_nmbj002_desc>>----
         #----<<b_nmbj003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj003
            #add-point:BEFORE FIELD b_nmbj003 name="construct.b.page1.b_nmbj003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj003
            
            #add-point:AFTER FIELD b_nmbj003 name="construct.a.page1.b_nmbj003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj003
            #add-point:ON ACTION controlp INFIELD b_nmbj003 name="construct.c.page1.b_nmbj003"
            
            #END add-point
 
 
         #----<<b_nmbj004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj004
            #add-point:BEFORE FIELD b_nmbj004 name="construct.b.page1.b_nmbj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj004
            
            #add-point:AFTER FIELD b_nmbj004 name="construct.a.page1.b_nmbj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj004
            #add-point:ON ACTION controlp INFIELD b_nmbj004 name="construct.c.page1.b_nmbj004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj004  #顯示到畫面上
            NEXT FIELD b_nmbj004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbj005>>----
         #Ctrlp:construct.c.page1.b_nmbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj005
            #add-point:ON ACTION controlp INFIELD b_nmbj005 name="construct.c.page1.b_nmbj005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj005  #顯示到畫面上
            NEXT FIELD b_nmbj005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj005
            #add-point:BEFORE FIELD b_nmbj005 name="construct.b.page1.b_nmbj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj005
            
            #add-point:AFTER FIELD b_nmbj005 name="construct.a.page1.b_nmbj005"
            
            #END add-point
            
 
 
         #----<<b_nmbj005_desc>>----
         #----<<b_nmbj006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj006
            #add-point:BEFORE FIELD b_nmbj006 name="construct.b.page1.b_nmbj006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj006
            
            #add-point:AFTER FIELD b_nmbj006 name="construct.a.page1.b_nmbj006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj006
            #add-point:ON ACTION controlp INFIELD b_nmbj006 name="construct.c.page1.b_nmbj006"
            
            #END add-point
 
 
         #----<<b_nmbj007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj007
            #add-point:BEFORE FIELD b_nmbj007 name="construct.b.page1.b_nmbj007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj007
            
            #add-point:AFTER FIELD b_nmbj007 name="construct.a.page1.b_nmbj007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj007
            #add-point:ON ACTION controlp INFIELD b_nmbj007 name="construct.c.page1.b_nmbj007"
            
            #END add-point
 
 
         #----<<b_nmbj008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmbj008
            #add-point:BEFORE FIELD b_nmbj008 name="construct.b.page1.b_nmbj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmbj008
            
            #add-point:AFTER FIELD b_nmbj008 name="construct.a.page1.b_nmbj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj008
            #add-point:ON ACTION controlp INFIELD b_nmbj008 name="construct.c.page1.b_nmbj008"
            
            #END add-point
 
 
         #----<<nmbc103>>----
         #----<<amt1>>----
         #----<<amt2>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT g_nmbi_m.nmbi001,g_nmbi_m.nmbidocno,g_nmbi_m.a FROM nmbi001,nmbidocno,a
         BEFORE INPUT
            LET g_nmbi_m.a = '0'
            DISPLAY g_nmbi_m.a TO a
         
         AFTER FIELD nmbi001
            IF NOT cl_null(g_nmbi_m.nmbi001) THEN
               CALL s_fin_account_center_chk(g_nmbi_m.nmbi001,g_nmbi_m.nmbi001,'6',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbi_m.nmbi001 = ''
                  LET g_nmbi_m.nmbi001_desc = ''
                  DISPLAY BY NAME g_nmbi_m.nmbi001_desc
                  NEXT FIELD CURRENT
               END IF
               LET g_nmbi_m.nmbi001_desc = s_desc_get_department_desc(g_nmbi_m.nmbi001)
               DISPLAY g_nmbi_m.nmbi001_desc TO nmbi001_desc
            END IF
            
         AFTER FIELD nmbidocno
            IF NOT cl_null(g_nmbi_m.nmbidocno) THEN
               SELECT COUNT(*),nmbi001 INTO l_n,l_nmbi001 FROM nmbi_t
                WHERE nmbient = g_enterprise AND nmbidocno = g_nmbi_m.nmbidocno
                  GROUP BY nmbi001
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00370'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbi_m.nmbidocno = ''
                  NEXT FIELD CURRENT
               END IF
               IF l_nmbi001 <> g_nmbi_m.nmbi001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00371'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmbi_m.nmbidocno = ''
                  NEXT FIELD CURRENT
               END IF
               SELECT nmbi003 INTO g_nmbi003 FROM nmbi_t WHERE nmbient = g_enterprise AND nmbidocno = g_nmbi_m.nmbidocno
            END IF
         
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD nmbi001
            #add-point:ON ACTION controlp INFIELD nmbi001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbi_m.nmbi001      #給予default值
            #LET g_qryparam.where = " ooef206 = 'Y'"                   #161021-00050#2 mark
            #CALL q_ooef001()                               #呼叫開窗   #161021-00050#2 mark
            CALL q_ooef001_33()                                        #161021-00050#2 add
            LET g_nmbi_m.nmbi001 = g_qryparam.return1       #將開窗取得的值回傳到變數
            DISPLAY g_nmbi_m.nmbi001 TO nmbi001             #顯示到畫面上
            LET g_nmbi_m.nmbi001_desc = s_desc_get_department_desc(g_nmbi_m.nmbi001)
            DISPLAY g_nmbi_m.nmbi001_desc TO nmbi001_desc
            
            NEXT FIELD nmbi001                              #返回原欄位
            #END add-point
         
         #Ctrlp:input.c.nmbidocno
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD nmbidocno
            #add-point:ON ACTION controlp INFIELD nmbidocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_nmbi_m.nmbidocno
            LET g_qryparam.where = " nmbi001 = '",g_nmbi_m.nmbi001,"'"
            CALL q_nmbidocno_1()
            LET g_nmbi_m.nmbidocno = g_qryparam.return1
            SELECT nmbi003 INTO g_nmbi003 FROM nmbi_t WHERE nmbient = g_enterprise AND nmbidocno = g_nmbi_m.nmbidocno
            DISPLAY g_nmbi_m.nmbidocno TO nmbidocno
            NEXT FIELD nmbidocno
            #END add-point
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
   CALL anmq970_b_fill()
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
 
{<section id="anmq970.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq970_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.chr1
   DEFINE l_nmbe003       LIKE nmbe_t.nmbe003
   DEFINE l_nmbe003_str   STRING
   DEFINE l_sql           STRING
   DEFINE l_nmbi001_desc  LIKE type_t.chr500
   DEFINE l_a_desc        LIKE type_t.chr500
   DEFINE l_str1          LIKE type_t.chr500   #单层展开时，取下阶组织，求其金额和
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   DELETE FROM anmq970_tmp01             #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01
   LET g_nmbi001_str = ''
   LET l_nmbe003_str = ''
   LET l_nmbi001_desc = g_nmbi_m.nmbi001," ",g_nmbi_m.nmbi001_desc
   CASE g_nmbi_m.a
    WHEN '0'
       SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd001 = 'anmq970' AND gzzd002 = g_lang AND gzzd003 = 'cbo_a.1'
    WHEN '0'
       SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd001 = 'anmq970' AND gzzd002 = g_lang AND gzzd003 = 'cbo_a.2'
    WHEN '0'
       SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd001 = 'anmq970' AND gzzd002 = g_lang AND gzzd003 = 'cbo_a.3'
   END CASE
   #按个体展开
   IF g_nmbi_m.a = '0' THEN
      LET g_nmbi001_str = "'",g_nmbi_m.nmbi001,"'"
   END IF
   #按组织树单层展开
   IF g_nmbi_m.a = '1' THEN
      CALL anmq970_get_next_ooed004(g_nmbi_m.nmbi001) RETURNING g_nmbi001_str,l_flag
      #除了最上层根节点,这边抓的少了自己本层,这边也要加上
      LET g_nmbi001_str = "'",g_ooed005,"'",",",g_nmbi001_str
   END IF

   #按组织树多层展开
   IF g_nmbi_m.a = '2' THEN
      CALL anmq970_get_ooed004() RETURNING g_nmbi001_str,l_flag
      #除了最上层根节点,这边抓的少了自己本层,这边也要加上
      LET g_nmbi001_str = "'",g_ooed005,"'",",",g_nmbi001_str
   END IF
   
   LET g_ooed001 = '6'
   LET l_sql = "SELECT DISTINCT ooed005,ooed002,ooed003 ",
               "  FROM ooed_t",
               " WHERE ooedent = '",g_enterprise,"'",
               "   AND ooed001 = '",g_ooed001,"'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed005 = ?",
               "   AND ooed006 <= '",g_today,"'",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')"
    
   LET l_sql = l_sql," ORDER BY ooed002,ooed005"
   PREPARE anmq970_ooed_pre2 FROM l_sql
   
   
   #取存提码
   LET l_sql = " SELECT nmbe003 FROM nmbe_t ",
               "  WHERE nmbeent = ",g_enterprise," AND nmbe001 = '",g_nmbi003,"'",
               "    AND nmbe002 = ?"
   PREPARE nmbe003_prep FROM l_sql
   DECLARE nmbe003_curs CURSOR FOR nmbe003_prep
   
   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE nmbj001,'',nmbj002,'',nmbj003,nmbj004,nmbj005,'',nmbj006,nmbj007, 
       nmbj008,'','',''  ,DENSE_RANK() OVER( ORDER BY nmbj_t.nmbjdocno,nmbj_t.nmbjseq) AS RANK FROM nmbj_t", 
 
 
 
                     "",
                     " WHERE nmbjent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbj_t"),
                     " ORDER BY nmbj_t.nmbjdocno,nmbj_t.nmbjseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT  UNIQUE nmbj001,'',nmbj002,'',nmbj003,nmbj004,nmbj005,'',nmbj006,nmbj007,nmbj008, 
        '','',''  ,DENSE_RANK() OVER( ORDER BY nmbj_t.nmbjdocno,nmbj_t.nmbjseq) AS RANK FROM nmbj_t", 
        
        
        
                      "",
                      " WHERE nmbjent= ? AND 1=1 AND ", ls_wc,
                      "   AND nmbjdocno = '",g_nmbi_m.nmbidocno,"' AND nmbj001 IN(",g_nmbi001_str,")"
   
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmbj_t"),
                     " ORDER BY nmbj_t.nmbjdocno"
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
 
   LET g_sql = "SELECT nmbj001,'',nmbj002,'',nmbj003,nmbj004,nmbj005,'',nmbj006,nmbj007,nmbj008,'','', 
       ''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"

   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq970_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq970_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmbj_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmbj_d[l_ac].nmbj001,g_nmbj_d[l_ac].nmbj001_desc,g_nmbj_d[l_ac].nmbj002, 
       g_nmbj_d[l_ac].nmbj002_desc,g_nmbj_d[l_ac].nmbj003,g_nmbj_d[l_ac].nmbj004,g_nmbj_d[l_ac].nmbj005, 
       g_nmbj_d[l_ac].nmbj005_desc,g_nmbj_d[l_ac].nmbj006,g_nmbj_d[l_ac].nmbj007,g_nmbj_d[l_ac].nmbj008, 
       g_nmbj_d[l_ac].nmbc103,g_nmbj_d[l_ac].amt1,g_nmbj_d[l_ac].amt2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmbj_d[l_ac].statepic = cl_get_actipic(g_nmbj_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #按组织树单层展开
      IF g_nmbi_m.a = '1' THEN
         CALL anmq970_get_next_ooed004(g_nmbj_d[l_ac].nmbj001) RETURNING l_str1,l_flag
         #除了最上层根节点,这边抓的少了自己本层,这边也要加上
         LET l_str1 = "'",g_nmbj_d[l_ac].nmbj001,"'",",",l_str1
         #若为单层展开，取金额合计
         LET l_sql= "SELECT SUM(nmbj006),SUM(nmbj007),SUM(nmbj008) FROM nmbj_t ",
                    " WHERE nmbjent = ",g_enterprise," AND nmbjdocno = '",g_nmbi_m.nmbidocno,"'",
                    "   AND nmbj001 IN(",l_str1,")"
         PREPARE anmq970_sum_prep FROM l_sql
         EXECUTE anmq970_sum_prep INTO g_nmbj_d[l_ac].nmbj006,g_nmbj_d[l_ac].nmbj007,g_nmbj_d[l_ac].nmbj008
      END IF
      
      IF cl_null(g_nmbj_d[l_ac].nmbj006) THEN LET g_nmbj_d[l_ac].nmbj006 = 0 END IF
      IF cl_null(g_nmbj_d[l_ac].nmbj007) THEN LET g_nmbj_d[l_ac].nmbj007 = 0 END IF
      IF cl_null(g_nmbj_d[l_ac].nmbj008) THEN LET g_nmbj_d[l_ac].nmbj008 = 0 END IF
      LET g_nmbj_d[l_ac].nmbj001_desc = s_desc_get_department_desc(g_nmbj_d[l_ac].nmbj001)
      
      SELECT nmbdl004 INTO g_nmbj_d[l_ac].nmbj002_desc FROM nmbdl_t
       WHERE nmbdlent = g_enterprise AND nmbdl001 = g_nmbi003
         AND nmbdl002 = g_nmbj_d[l_ac].nmbj002 AND nmbdl003 = g_dlang
      
      SELECT ooail003 INTO g_nmbj_d[l_ac].nmbj005_desc FROM ooail_t
       WHERE ooailent = g_enterprise AND ooail001 = g_nmbj_d[l_ac].nmbj005
         AND ooail002 = g_dlang
         
      #实际完成金额
      #按取得的收支项目+收支项目版本nmi003 取得对应的存提码  
      FOREACH nmbe003_curs USING g_nmbj_d[l_ac].nmbj002 INTO l_nmbe003
         IF cl_null(l_nmbe003_str) THEN
            LET l_nmbe003_str = "('",l_nmbe003,"'"
         ELSE
            LET l_nmbe003_str = l_nmbe003_str,",'",l_nmbe003,"'"
         END IF
      END FOREACH
      LET l_nmbe003_str = l_nmbe003_str,")"
      #按组织+存提码+起止日期nmbj003.004+币别 ,在nmbc表取得实际完成金额nmbc103
      LET l_sql = " SELECT SUM(nmbc103) FROM nmbc_t",
                  "  WHERE nmbcent = ",g_enterprise,
                  "    AND nmbc007 IN ",l_nmbe003_str,
                  "    AND nmbc100 = '",g_nmbj_d[l_ac].nmbj005,"'",
                  "    AND nmbc005 BETWEEN '",g_nmbj_d[l_ac].nmbj003,"' AND '",g_nmbj_d[l_ac].nmbj004,"'"
      IF g_nmbi_m.a = '1' THEN  #若为单层展开，需取下阶组织的金额合计
         LET l_sql = l_sql CLIPPED ," AND nmbcsite IN (",l_str1,")"
      ELSE
         LET l_sql = l_sql CLIPPED ," AND nmbcsite = '",g_nmbj_d[l_ac].nmbj001,"'"
      END IF
      PREPARE nmbc103_prep FROM l_sql
      EXECUTE nmbc103_prep INTO g_nmbj_d[l_ac].nmbc103
      
      IF cl_null(g_nmbj_d[l_ac].nmbc103) THEN LET g_nmbj_d[l_ac].nmbc103 = 0 END IF
      #差额=实际完成金额-审批金额
      LET g_nmbj_d[l_ac].amt1 = g_nmbj_d[l_ac].nmbc103 - g_nmbj_d[l_ac].nmbj008 
      #差异率=差额/审批金额
      LET g_nmbj_d[l_ac].amt2 = g_nmbj_d[l_ac].amt1/g_nmbj_d[l_ac].nmbj008
      
      #插入XG
      INSERT INTO anmq970_tmp01 VALUES(l_nmbi001_desc,g_nmbi_m.nmbidocno,l_a_desc,g_nmbj_d[l_ac].nmbj001,g_nmbj_d[l_ac].nmbj001_desc,g_nmbj_d[l_ac].nmbj002,     #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01 
       g_nmbj_d[l_ac].nmbj002_desc,g_nmbj_d[l_ac].nmbj003,g_nmbj_d[l_ac].nmbj004,g_nmbj_d[l_ac].nmbj005, 
       g_nmbj_d[l_ac].nmbj005_desc,g_nmbj_d[l_ac].nmbj006,g_nmbj_d[l_ac].nmbj007,g_nmbj_d[l_ac].nmbj008, 
       g_nmbj_d[l_ac].nmbc103,g_nmbj_d[l_ac].amt1,g_nmbj_d[l_ac].amt2)
      #end add-point
 
      CALL anmq970_detail_show("'1'")      
 
      CALL anmq970_nmbj_t_mask()
 
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
   
 
   
   CALL g_nmbj_d.deleteElement(g_nmbj_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
#   CALL anmq970_nmbjcomp_desc() #150715-00014#2
  #LET g_nmbj_m.nmckcomp_desc = s_desc_get_ooefl006_desc(g_nmbj_m.nmckcomp) #150715-00014#2
   #end add-point
 
   LET g_detail_cnt = g_nmbj_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq970_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq970_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq970_detail_action_trans()
 
   IF g_nmbj_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq970_fetch()
   END IF
   
      CALL anmq970_filter_show('nmbj001','b_nmbj001')
   CALL anmq970_filter_show('nmbj002','b_nmbj002')
   CALL anmq970_filter_show('nmbj003','b_nmbj003')
   CALL anmq970_filter_show('nmbj004','b_nmbj004')
   CALL anmq970_filter_show('nmbj005','b_nmbj005')
   CALL anmq970_filter_show('nmbj006','b_nmbj006')
   CALL anmq970_filter_show('nmbj007','b_nmbj007')
   CALL anmq970_filter_show('nmbj008','b_nmbj008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq970_fetch()
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
 
{<section id="anmq970.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq970_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_nmbj_d[l_ac].nmbj002
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmbj_d[l_ac].nmbj002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmbj_d[l_ac].nmbj002_desc
            
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq970_filter()
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
      CONSTRUCT g_wc_filter ON nmbj001,nmbj002,nmbj003,nmbj004,nmbj005,nmbj006,nmbj007,nmbj008
                          FROM s_detail1[1].b_nmbj001,s_detail1[1].b_nmbj002,s_detail1[1].b_nmbj003, 
                              s_detail1[1].b_nmbj004,s_detail1[1].b_nmbj005,s_detail1[1].b_nmbj006,s_detail1[1].b_nmbj007, 
                              s_detail1[1].b_nmbj008
 
         BEFORE CONSTRUCT
                     DISPLAY anmq970_filter_parser('nmbj001') TO s_detail1[1].b_nmbj001
            DISPLAY anmq970_filter_parser('nmbj002') TO s_detail1[1].b_nmbj002
            DISPLAY anmq970_filter_parser('nmbj003') TO s_detail1[1].b_nmbj003
            DISPLAY anmq970_filter_parser('nmbj004') TO s_detail1[1].b_nmbj004
            DISPLAY anmq970_filter_parser('nmbj005') TO s_detail1[1].b_nmbj005
            DISPLAY anmq970_filter_parser('nmbj006') TO s_detail1[1].b_nmbj006
            DISPLAY anmq970_filter_parser('nmbj007') TO s_detail1[1].b_nmbj007
            DISPLAY anmq970_filter_parser('nmbj008') TO s_detail1[1].b_nmbj008
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_nmbj001>>----
         #Ctrlp:construct.c.page1.b_nmbj001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj001
            #add-point:ON ACTION controlp INFIELD b_nmbj001 name="construct.c.filter.page1.b_nmbj001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmbh004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj001  #顯示到畫面上
            NEXT FIELD b_nmbj001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbj001_desc>>----
         #----<<b_nmbj002>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj002
            #add-point:ON ACTION controlp INFIELD b_nmbj002 name="construct.c.filter.page1.b_nmbj002"
            
            #END add-point
 
 
         #----<<b_nmbj002_desc>>----
         #----<<b_nmbj003>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj003
            #add-point:ON ACTION controlp INFIELD b_nmbj003 name="construct.c.filter.page1.b_nmbj003"
            
            #END add-point
 
 
         #----<<b_nmbj004>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj004
            #add-point:ON ACTION controlp INFIELD b_nmbj004 name="construct.c.filter.page1.b_nmbj004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj004  #顯示到畫面上
            NEXT FIELD b_nmbj004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbj005>>----
         #Ctrlp:construct.c.page1.b_nmbj005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj005
            #add-point:ON ACTION controlp INFIELD b_nmbj005 name="construct.c.filter.page1.b_nmbj005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmbj005  #顯示到畫面上
            NEXT FIELD b_nmbj005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmbj005_desc>>----
         #----<<b_nmbj006>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj006
            #add-point:ON ACTION controlp INFIELD b_nmbj006 name="construct.c.filter.page1.b_nmbj006"
            
            #END add-point
 
 
         #----<<b_nmbj007>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj007
            #add-point:ON ACTION controlp INFIELD b_nmbj007 name="construct.c.filter.page1.b_nmbj007"
            
            #END add-point
 
 
         #----<<b_nmbj008>>----
         #Ctrlp:construct.c.filter.page1.b_nmbj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmbj008
            #add-point:ON ACTION controlp INFIELD b_nmbj008 name="construct.c.filter.page1.b_nmbj008"
            
            #END add-point
 
 
         #----<<nmbc103>>----
         #----<<amt1>>----
         #----<<amt2>>----
   
 
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
   
      CALL anmq970_filter_show('nmbj001','b_nmbj001')
   CALL anmq970_filter_show('nmbj002','b_nmbj002')
   CALL anmq970_filter_show('nmbj003','b_nmbj003')
   CALL anmq970_filter_show('nmbj004','b_nmbj004')
   CALL anmq970_filter_show('nmbj005','b_nmbj005')
   CALL anmq970_filter_show('nmbj006','b_nmbj006')
   CALL anmq970_filter_show('nmbj007','b_nmbj007')
   CALL anmq970_filter_show('nmbj008','b_nmbj008')
 
    
   CALL anmq970_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq970_filter_parser(ps_field)
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
 
{<section id="anmq970.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq970_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq970_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.insert" >}
#+ insert
PRIVATE FUNCTION anmq970_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq970.modify" >}
#+ modify
PRIVATE FUNCTION anmq970_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq970_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.delete" >}
#+ delete
PRIVATE FUNCTION anmq970_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq970.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq970_detail_action_trans()
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
 
{<section id="anmq970.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq970_detail_index_setting()
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
            IF g_nmbj_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmbj_d.getLength() AND g_nmbj_d.getLength() > 0
            LET g_detail_idx = g_nmbj_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmbj_d.getLength() THEN
               LET g_detail_idx = g_nmbj_d.getLength()
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
 
{<section id="anmq970.mask_functions" >}
 &include "erp/anm/anmq970_mask.4gl"
 
{</section>}
 
{<section id="anmq970.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取节点下一层节点
################################################################################
PRIVATE FUNCTION anmq970_get_next_ooed004(p_ooed005)
   DEFINE p_ooed005           LIKE ooed_t.ooed005
   DEFINE l_sql               STRING
   DEFINE l_ooed004           LIKE ooed_t.ooed004
   DEFINE l_ooed004_str       STRING

   DELETE FROM anmq970_tmp;
   LET g_ooed001 = '6'
   LET l_sql = "SELECT DISTINCT ooed005,ooed002,ooed003 ",
               "  FROM ooed_t",
               " WHERE ooedent = '",g_enterprise,"'",
               "   AND ooed001 = '",g_ooed001,"'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed005 = '",p_ooed005,"'",
               "   AND ooed006 <= '",g_today,"'",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')"
    
   LET l_sql = l_sql," ORDER BY ooed002,ooed005"
   PREPARE anmq970_ooed_pre1 FROM l_sql
   EXECUTE anmq970_ooed_pre1 INTO g_ooed005,g_ooed002,g_ooed003
   
   LET l_ooed004_str = ''
   LET l_sql = "SELECT DISTINCT ooed004 ",
               "  FROM ooed_t ",
               "WHERE ooed001 = '",g_ooed001,"' ",
               "  AND ooed002 = '",g_ooed002,"' ",
               "  AND ooed003 = '",g_ooed003,"' ",
               "  AND ooed005 = '",g_ooed005,"' ",
               "  ORDER BY ooed004 "
   PREPARE anmq970_ooed004_pre1 FROM l_sql
   DECLARE anmq970_ooed004_cs1 CURSOR FOR anmq970_ooed004_pre1
   FOREACH anmq970_ooed004_cs1 INTO l_ooed004
      IF cl_null(l_ooed004_str) THEN
         LET l_ooed004_str = "'",l_ooed004,"'"
      ELSE
         LET l_ooed004_str = l_ooed004_str,",","'",l_ooed004,"'"
      END IF

      INSERT INTO anmq970_tmp VALUES(l_ooed004)
   END FOREACH

   RETURN l_ooed004_str,'Y'
END FUNCTION

################################################################################
# Descriptions...: 創建臨時表
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq970_create_tmp()
   DROP TABLE anmq970_tmp;
   CREATE TEMP TABLE anmq970_tmp(
   ooed004           VARCHAR(10)
   );
   
   DROP TABLE anmq970_tmp01;           #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01
   CREATE TEMP TABLE anmq970_tmp01(    #160727-00019#4 Mod  anmq970_print_tmp--> anmq970_tmp01
   l_nmbi001_desc  VARCHAR(500),
   nmbidocno  VARCHAR(20),
   l_a_desc  VARCHAR(500),
   nmbj001  VARCHAR(10), 
   nmbj001_desc  VARCHAR(500), 
   nmbj002  VARCHAR(10), 
   nmbj002_desc  VARCHAR(500), 
   nmbj003  DATE, 
   nmbj004  DATE, 
   nmbj005  VARCHAR(10), 
   nmbj005_desc  VARCHAR(500), 
   nmbj006  DECIMAL(20,6), 
   nmbj007  DECIMAL(20,6), 
   nmbj008  DECIMAL(20,6), 
   nmbc103  DECIMAL(20,6), 
   amt1  DECIMAL(20,6), 
   amt2  DECIMAL(20,6)
   );
END FUNCTION

################################################################################
# Descriptions...: 根据组织类型、最上层组织、版本，查询下层所有组织
# Date & Author..: 2015/10/16 By yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq970_get_ooed004()
   DEFINE l_sql               STRING
   DEFINE l_ooed004           LIKE ooed_t.ooed004
   DEFINE l_ooed004_str       STRING

   DELETE FROM aglq840_tmp;
   
   LET g_ooed001 = '6'
   LET l_sql = "SELECT DISTINCT ooed005,ooed002,ooed003 ",
               "  FROM ooed_t",
               " WHERE ooedent = '",g_enterprise,"'",
               "   AND ooed001 = '",g_ooed001,"'",
               "   AND ooed004 <> ooed005 ",
               "   AND ooed005 = '",g_nmbi_m.nmbi001,"'",
               "   AND ooed006 <= '",g_today,"'",
               "   AND (ooed007 IS NULL OR ooed007 >= '",g_today,"')"
    
   LET l_sql = l_sql," ORDER BY ooed002,ooed005"
   PREPARE anmq970_ooed004_pre2 FROM l_sql
   EXECUTE anmq970_ooed004_pre2 INTO g_ooed005,g_ooed002,g_ooed003

   LET l_ooed004_str = ''
   LET l_sql = "SELECT DISTINCT ooed004 ",
               "  FROM ooed_t ",
               "WHERE ooed001 = '",g_ooed001,"' ",
               "  AND ooed002 = '",g_ooed002,"' ",
               "  AND ooed003 = '",g_ooed003,"' ",
               "  AND ooed004 <> ooed005 ",
               "START WITH ooed005 = '",g_ooed005,"' ",
               "       AND ooed001 = '",g_ooed001,"' ",
               "       AND ooed002 = '",g_ooed002,"' ",
               "       AND ooed003 = '",g_ooed003,"' ",
               "  AND ooed004 <> ooed005 ",
               "CONNECT BY ooed005 = PRIOR ooed004 ",
               "       AND ooed001 = '",g_ooed001,"' ",
               "       AND ooed002 = '",g_ooed002,"' ",
               "       AND ooed003 = '",g_ooed003,"' ",
               "  AND ooed004 <> ooed005 ",
               "  ORDER BY ooed004 "
   PREPARE anmq970_ooed004_pre FROM l_sql
   DECLARE anmq970_ooed004_cs CURSOR FOR anmq970_ooed004_pre
   FOREACH anmq970_ooed004_cs INTO l_ooed004
      IF cl_null(l_ooed004_str) THEN
         LET l_ooed004_str = "'",l_ooed004,"'"
      ELSE
         LET l_ooed004_str = l_ooed004_str,",","'",l_ooed004,"'"
      END IF

      INSERT INTO anmq470_tmp VALUES(l_ooed004)
   END FOREACH

   RETURN l_ooed004_str,'Y'
END FUNCTION

 
{</section>}
 
