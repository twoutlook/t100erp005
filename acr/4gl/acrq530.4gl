#該程式未解開Section, 採用最新樣板產出!
{<section id="acrq530.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-02-23 16:20:20), PR版次:0005(2016-11-16 16:23:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: acrq530
#+ Description: 品類會員屬性查詢作業
#+ Creator....: 02003(2014-07-14 00:00:00)
#+ Modifier...: 02003 -SD/PR- 02481
 
{</section>}
 
{<section id="acrq530.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160705-00042#11   2016/07/13  By sakura   程式中寫死g_prog部分改寫MATCHES方式
#161111-00028#4    2016/11/16   by 02481   标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE TYPE type_g_decc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   deca016 LIKE deca_t.deca016, 
   rtaxl003 LIKE type_t.chr500, 
   num LIKE type_t.chr500, 
   deca027 LIKE deca_t.deca027, 
   deca028 LIKE deca_t.deca028, 
   age LIKE type_t.chr500 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bdate              LIKE type_t.dat
DEFINE g_edate              LIKE type_t.dat
DEFINE g_sel1               LIKE type_t.chr1
DEFINE g_num1               LIKE rtjf_t.rtjf003
DEFINE g_wc_master          STRING 
DEFINE g_mmag002            LIKE mmag_t.mmag002
DEFINE g_mmag002_desc       LIKE oocql_t.oocql004
DEFINE g_mmag004            STRING 
 TYPE type_g_deca_d RECORD
   mmag004   LIKE mmag_t.mmag004, 
   oocql004  LIKE oocql_t.oocql004, 
   l_deca020 LIKE deca_t.deca027, 
   l_deca027 LIKE deca_t.deca027, 
   l_deca028 LIKE deca_t.deca028
       END RECORD
      
DEFINE g_deca_d          DYNAMIC ARRAY OF type_g_deca_d
DEFINE l_ac2             LIKE type_t.num5  
DEFINE g_str             STRING 
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_decc_d
DEFINE g_master_t                   type_g_decc_d
DEFINE g_decc_d          DYNAMIC ARRAY OF type_g_decc_d
DEFINE g_decc_d_t        type_g_decc_d
 
      
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
 
{<section id="acrq530.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("acr","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"

   IF g_argv[1] = '2' THEN 
      LET g_prog = 'acrq531'
   END IF 
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrq530_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE acrq530_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrq530_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrq530 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrq530_init()   
 
      #進入選單 Menu (="N")
      CALL acrq530_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE acrq530_tmp
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrq530
      
   END IF 
   
   CLOSE acrq530_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acrq530.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION acrq530_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_msg      STRING
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   #IF g_prog = 'acrq531' THEN        #160705-00042#11 160713 by sakura mark
   IF g_prog MATCHES 'acrq531' THEN   #160705-00042#11 160713 by sakura add
      CALL cl_getmsg('acr-00053',g_lang) RETURNING l_msg
      CALL cl_set_comp_att_text("deca016",l_msg)
      CALL cl_set_comp_att_text("b_deca016",l_msg)
   END IF 
   #end add-point
 
   CALL acrq530_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="acrq530.default_search" >}
PRIVATE FUNCTION acrq530_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " decc001 = '", g_argv[02], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " decc002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " decc023 = '", g_argv[04], "' AND "
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
 
{<section id="acrq530.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION acrq530_ui_dialog()
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
   DEFINE l_year   LIKE type_t.num5
   DEFINE l_month  LIKE type_t.num5
   DEFINE l_date   LIKE type_t.dat
   DEFINE l_sql    STRING 
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
   #160126-00002#1 160126 By pomelo add(S)
   LET g_bdate = g_today
   LET g_edate = g_today
   CALL cl_set_act_visible("filter",FALSE)
   LET g_wc = g_wc," AND 1=1"
   #160126-00002#1 160126 By pomelo add(E)
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL acrq530_b_fill()
   ELSE
      CALL acrq530_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_decc_d.clear()
 
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
 
         CALL acrq530_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_decc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL acrq530_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL acrq530_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               IF l_ac > 0 THEN 
                  CALL acrq530_b2_fill()
                  CALL acrq530_b2_refresh()
               END IF 
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_deca_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
      
            BEFORE ROW
               LET l_ac2 = DIALOG.getCurrentRow("s_detail2")
               
         END DISPLAY
         
         #160126-00002#1 160126 By pomelo add(S)
         CONSTRUCT g_wc_master ON deca016,decasite
            FROM deca016,decasite
            
            ON ACTION controlp INFIELD deca016
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "1=1"
               #IF g_prog = 'acrq530' THEN        #160705-00042#11 160713 by sakura mark
               IF g_prog MATCHES 'acrq530' THEN   #160705-00042#11 160713 by sakura add
                  CALL q_rtax001_1()
               ELSE
                  LET g_qryparam.arg1 = '2002'
                  CALL q_oocq002()
               END IF  
               DISPLAY g_qryparam.return1 TO deca016
         
            ON ACTION controlp INFIELD decasite
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'decasite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO decasite
               
            AFTER CONSTRUCT 
               #IF g_prog = 'acrq531' THEN        #160705-00042#11 160713 by sakura mark
               IF g_prog MATCHES 'acrq531' THEN   #160705-00042#11 160713 by sakura add
                  LET g_wc_master = cl_replace_str(g_wc_master,"deca016","deca013")
               END IF 
               
         END CONSTRUCT 
         
         INPUT g_mmag002,g_bdate,g_edate FROM mmag002,bdate,edate ATTRIBUTE(WITHOUT DEFAULTS)
          
            BEFORE INPUT 
               DISPLAY g_mmag002,g_mmag002_desc,g_bdate,g_edate
                    TO mmag002,mmag002_desc,bdate,edate
            
            AFTER FIELD mmag002
               IF NOT cl_null(g_mmag002) THEN 
                  CALL acrq530_mmag002_chk()
                  IF NOT cl_null(g_errno) THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_mmag002 = ''
                     DISPLAY g_mmag002 TO mmag002
                     DISPLAY '' TO mmag002_desc
                     NEXT FIELD mmag002
                  END IF 
               ELSE
                  DISPLAY '' TO mmag002_desc
               END IF 
            
            AFTER FIELD bdate
               IF NOT cl_null(g_bdate) THEN 
                  IF NOT cl_null(g_edate) THEN 
                     IF g_bdate > g_edate THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00063'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bdate = ''
                        NEXT FIELD CURRENT 
                     END IF 
                  END IF 
               END IF 
               
            AFTER FIELD edate 
               IF NOT cl_null(g_edate) THEN 
                  IF NOT cl_null(g_bdate) THEN 
                     IF g_bdate > g_edate THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00063'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_edate = ''
                        NEXT FIELD CURRENT 
                     END IF 
                  END IF 
               END IF 
               
            ON ACTION controlp INFIELD mmag002
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "i"
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "1=1"
               LET g_qryparam.arg1 = "2049"
               CALL q_oocq002()
               LET g_mmag002 = g_qryparam.return1
               LET g_mmag002_desc = g_qryparam.return2
               DISPLAY g_mmag002 TO mmag002    
               DISPLAY g_mmag002_desc TO mmag002_desc
               
            ON CHANGE mmag002
               DISPLAY g_mmag002 TO mmag002
               
            ON CHANGE bdate
               DISPLAY g_bdate TO bdate
               
            ON CHANGE edate
               DISPLAY g_edate TO edate
         END INPUT
         #160126-00002#1 160126 By pomelo add(E)
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL acrq530_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#1 160126 By pomelo add(S)
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)
            NEXT FIELD deca016
            #160126-00002#1 160126 By pomelo add(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL acrq530_insert()
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
               CALL acrq530_query()
               #add-point:ON ACTION query name="menu.query"
               IF l_ac > 0 THEN 
                  CALL acrq530_b2_fill()
                  CALL acrq530_b2_refresh()
               END IF 
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
            CALL acrq530_filter()
            #add-point:ON ACTION filter name="menu.filter"
            #160126-00002#1 160126 By pomelo add(S)
            CALL cl_set_comp_visible("sel", FALSE)
            IF g_decc_d.getLength() > 0 THEN
               CALL acrq530_b2_fill()
            END IF
            #160126-00002#1 160126 By pomelo add(E)
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
            CALL acrq530_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_decc_d)
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
            CALL acrq530_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL acrq530_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL acrq530_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL acrq530_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_decc_d.getLength()
               LET g_decc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_decc_d.getLength()
               LET g_decc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_decc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_decc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_decc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_decc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
         
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         #160126-00002#1 160126 By pomelo add(S)
         ON ACTION accept
            IF cl_null(g_mmag002) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD mmag002
            END IF
            IF cl_null(g_bdate) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD bdate
            END IF
            IF cl_null(g_edate) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00015'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               NEXT FIELD edate
            END IF
            CALL acrq530_ins_tmp()
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL acrq530_b_fill()
            IF g_decc_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               CALL acrq530_b2_fill()
            END IF
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
            #160126-00002#1 160126 By pomelo add(E)
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
 
{<section id="acrq530.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrq530_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_where         STRING 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_decc_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON deca016
           FROM s_detail1[1].b_deca016
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD deca016
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_deca016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_deca016
            #add-point:BEFORE FIELD b_deca016 name="construct.b.page1.b_deca016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_deca016
            
            #add-point:AFTER FIELD b_deca016 name="construct.a.page1.b_deca016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_deca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deca016
            #add-point:ON ACTION controlp INFIELD b_deca016 name="construct.c.page1.b_deca016"
            
            #END add-point
 
 
         #----<<b_rtaxl003>>----
         #----<<b_num>>----
         #----<<b_deca027>>----
         #----<<b_deca028>>----
         #----<<b_age>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      #160126-00002#1 160127 By pomelo mark(S)
      #CONSTRUCT g_wc_master ON deca016,decasite
      #     FROM deca016,decasite
      #
      #   BEFORE CONSTRUCT
      #   
      #   ON ACTION controlp INFIELD deca016
      #      ###  ### start ###
      #      INITIALIZE g_qryparam.* TO NULL 
      #      LET g_qryparam.state = "c"
      #      LET g_qryparam.reqry = FALSE
      #      LET g_qryparam.where = "1=1"
      #      IF g_prog = 'acrq530' THEN 
      #         CALL q_rtax001_1()
      #      ELSE
      #         LET g_qryparam.arg1 = '2002'
      #         CALL q_oocq002()
      #      END IF  
      #      DISPLAY g_qryparam.return1 TO deca016
      #      ###  ### end ###
      #
      #   ON ACTION controlp INFIELD decasite
      #      ###  ### start ###
      #      INITIALIZE g_qryparam.* TO NULL 
      #      LET g_qryparam.state = "c"
      #      LET g_qryparam.reqry = FALSE
#     #       LET g_qryparam.where = "1=1"
#     #       CALL q_ooef001_01()
      #      LET g_qryparam.where = s_aooi500_q_where(g_prog,'decasite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
      #      CALL q_ooef001_24()
      #      DISPLAY g_qryparam.return1 TO decasite
      #      ###  ### end ###
      #      
      #
      #      ###  ### end ###
      #      
      #   AFTER CONSTRUCT 
      #      IF g_prog = 'acrq531' THEN 
      #         LET g_wc_master = cl_replace_str(g_wc_master,"deca016","deca013")
      #      END IF 
      #      
      #END CONSTRUCT 
      #
      #INPUT g_mmag002,g_bdate,g_edate
      # FROM mmag002,bdate,edate
      # ATTRIBUTE(WITHOUT DEFAULTS)
      # 
      #   BEFORE INPUT 
      #      DISPLAY g_mmag002,g_mmag002_desc,g_bdate,g_edate
      #           TO mmag002,mmag002_desc,bdate,edate
      #   
      #   AFTER FIELD mmag002
      #      IF NOT cl_null(g_mmag002) THEN 
      #         CALL acrq530_mmag002_chk()
      #         IF NOT cl_null(g_errno) THEN 
      #            INITIALIZE g_errparam TO NULL
      #            LET g_errparam.code = g_errno
      #            LET g_errparam.extend = ''
      #            LET g_errparam.popup = TRUE
      #            CALL cl_err()
      #            LET g_mmag002 = ''
      #            DISPLAY g_mmag002 TO mmag002
      #            DISPLAY '' TO mmag002_desc
      #            NEXT FIELD mmag002
      #         END IF 
      #      ELSE
      #         DISPLAY '' TO mmag002_desc
      #      END IF 
      #   
      #   AFTER FIELD bdate
      #      IF NOT cl_null(g_bdate) THEN 
      #         IF NOT cl_null(g_edate) THEN 
      #            IF g_bdate > g_edate THEN 
      #               INITIALIZE g_errparam TO NULL
      #               LET g_errparam.code = 'ast-00063'
      #               LET g_errparam.extend = ''
      #               LET g_errparam.popup = TRUE
      #               CALL cl_err()
      #
      #               LET g_bdate = ''
      #               NEXT FIELD CURRENT 
      #            END IF 
      #         END IF 
      #      END IF 
      #      
      #   AFTER FIELD edate 
      #      IF NOT cl_null(g_edate) THEN 
      #         IF NOT cl_null(g_bdate) THEN 
      #            IF g_bdate > g_edate THEN 
      #               INITIALIZE g_errparam TO NULL
      #               LET g_errparam.code = 'ast-00063'
      #               LET g_errparam.extend = ''
      #               LET g_errparam.popup = TRUE
      #               CALL cl_err()
      #
      #               LET g_edate = ''
      #               NEXT FIELD CURRENT 
      #            END IF 
      #         END IF 
      #      END IF 
      #      
      #   ON ACTION controlp INFIELD mmag002
      #      ###  ### start ###
      #      INITIALIZE g_qryparam.* TO NULL 
      #      LET g_qryparam.state = "i"
      #      LET g_qryparam.reqry = FALSE
      #      LET g_qryparam.where = "1=1"
      #      LET g_qryparam.arg1 = "2049"
      #      CALL q_oocq002()
      #      LET g_mmag002 = g_qryparam.return1
      #      LET g_mmag002_desc = g_qryparam.return2
      #      DISPLAY g_mmag002 TO mmag002    
      #      DISPLAY g_mmag002_desc TO mmag002_desc           
      #END INPUT 
      #BEFORE DIALOG 
      #   NEXT FIELD mmag002
      #160126-00002#1 160127 By pomelo mark(E)
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
   IF cl_null(g_wc_master) THEN 
      LET g_wc_master = " 1=1"
   END IF 
   LET l_where = s_aooi500_sql_where(g_prog,'deccsite')
   LET l_where = cl_replace_str(l_where,'deccsite','decasite') 
   LET g_wc_master = g_wc_master CLIPPED," AND ",l_where
   
   CALL acrq530_ins_tmp()
   #end add-point
        
   LET g_error_show = 1
   CALL acrq530_b_fill()
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
 
{<section id="acrq530.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrq530_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc_master) THEN 
      LET g_wc_master = " 1=1"
   END IF 
   LET l_where = s_aooi500_sql_where(g_prog,'deccsite')
   LET l_where = cl_replace_str(l_where,'deccsite','decasite') 
   
   CALL acrq530_ins_tmp()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','',''  ,DENSE_RANK() OVER( ORDER BY decc_t.decc001, 
       decc_t.decc002,decc_t.decc023) AS RANK FROM decc_t",
 
 
                     "",
                     " WHERE deccent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decc_t"),
                     " ORDER BY decc_t.decc001,decc_t.decc002,decc_t.decc023"
 
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
 
   LET g_sql = "SELECT '','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = " SELECT 'N',deca013,rtaxl003,num,deca027,deca028,age ",
               "   FROM acrq530_tmp "
   LET l_where  = " WHERE decaent = ? "

   LET g_sql = g_sql,l_where," AND ",g_wc_filter," ORDER BY deca013" 
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE acrq530_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR acrq530_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_decc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_deca_d.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_decc_d[l_ac].sel,g_decc_d[l_ac].deca016,g_decc_d[l_ac].rtaxl003,g_decc_d[l_ac].num, 
       g_decc_d[l_ac].deca027,g_decc_d[l_ac].deca028,g_decc_d[l_ac].age
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_decc_d[l_ac].statepic = cl_get_actipic(g_decc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL acrq530_detail_show("'1'")      
 
      CALL acrq530_decc_t_mask()
 
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
   
 
   
   CALL g_decc_d.deleteElement(g_decc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
 
   #end add-point
 
   LET g_detail_cnt = g_decc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE acrq530_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL acrq530_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL acrq530_detail_action_trans()
 
   IF g_decc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL acrq530_fetch()
   END IF
   
      CALL acrq530_filter_show('deca016','b_deca016')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrq530_fetch()
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
 
{<section id="acrq530.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acrq530_detail_show(ps_page)
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
 
{<section id="acrq530.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION acrq530_filter()
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
      CONSTRUCT g_wc_filter ON deca016
                          FROM s_detail1[1].b_deca016
 
         BEFORE CONSTRUCT
                     DISPLAY acrq530_filter_parser('deca016') TO s_detail1[1].b_deca016
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_deca016>>----
         #Ctrlp:construct.c.filter.page1.b_deca016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deca016
            #add-point:ON ACTION controlp INFIELD b_deca016 name="construct.c.filter.page1.b_deca016"
            
            #END add-point
 
 
         #----<<b_rtaxl003>>----
         #----<<b_num>>----
         #----<<b_deca027>>----
         #----<<b_deca028>>----
         #----<<b_age>>----
   
 
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
   
      CALL acrq530_filter_show('deca016','b_deca016')
 
    
   CALL acrq530_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION acrq530_filter_parser(ps_field)
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
 
{<section id="acrq530.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION acrq530_filter_show(ps_field,ps_object)
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
   LET ls_condition = acrq530_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.insert" >}
#+ insert
PRIVATE FUNCTION acrq530_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="acrq530.modify" >}
#+ modify
PRIVATE FUNCTION acrq530_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.reproduce" >}
#+ reproduce
PRIVATE FUNCTION acrq530_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.delete" >}
#+ delete
PRIVATE FUNCTION acrq530_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq530.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION acrq530_detail_action_trans()
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
 
{<section id="acrq530.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION acrq530_detail_index_setting()
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
            IF g_decc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_decc_d.getLength() AND g_decc_d.getLength() > 0
            LET g_detail_idx = g_decc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_decc_d.getLength() THEN
               LET g_detail_idx = g_decc_d.getLength()
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
 
{<section id="acrq530.mask_functions" >}
 &include "erp/acr/acrq530_mask.4gl"
 
{</section>}
 
{<section id="acrq530.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 抓取数据新增到临时表
# Memo...........:
# Usage..........: CALL acrq530_ins_tmp()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/02 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrq530_ins_tmp()
   DEFINE l_sql         STRING 
   DEFINE l_deca        RECORD 
                    decaent      LIKE deca_t.decaent,
                    deca013      LIKE deca_t.deca013, 
                    rtaxl003     LIKE rtaxl_t.rtaxl003, 
                    deca020      LIKE deca_t.deca020, 
                    deca027      LIKE deca_t.deca027, 
                    deca028      LIKE deca_t.deca028,
                    age          LIKE type_t.num5
                        END RECORD 
   DEFINE l_n           LIKE type_t.num10
   DEFINE l_n1          LIKE type_t.num10
   DEFINE l_where       STRING 
   
   WHENEVER ERROR CONTINUE
   
   DROP TABLE acrq530_tmp
   
   CREATE TEMP TABLE acrq530_tmp(
       decaent      LIKE deca_t.decaent,
       deca013      LIKE deca_t.deca013, 
       rtaxl003     LIKE rtaxl_t.rtaxl003, 
       num          LIKE type_t.num10, 
       deca027      LIKE deca_t.deca027, 
       deca028      LIKE deca_t.deca028,
       age          LIKE type_t.num10
      )
      
   LET l_where = s_aooi500_sql_where(g_prog,'deccsite')
   LET l_where = cl_replace_str(l_where,'deccsite','decasite') 
   #IF g_prog = 'acrq530' THEN        #160705-00042#11 160713 by sakura mark
   IF g_prog MATCHES 'acrq530' THEN   #160705-00042#11 160713 by sakura add
      LET l_sql = " SELECT decaent,deca016,rtaxl003,COUNT(DISTINCT deca020),SUM(Nvl(deca027,0)),SUM(Nvl(deca028,0)),'' ",
                  "   FROM mmag_t,deca_t LEFT JOIN rtaxl_t ON deca016 = rtaxl001 AND rtaxlent = '",g_enterprise,"' AND rtaxl002 = '",g_lang,"'",
                  "  WHERE decaent = mmagent ",
                  "    AND decaent = '",g_enterprise,"'",
                  "    AND deca002 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
                  "    AND deca020 = mmag001 ",
                  "    AND deca016 IS NOT NULL ",
                  "    AND mmag002 = '",g_mmag002,"'",
                  "    AND ",g_wc_master CLIPPED,
                  "    AND ",l_where,
                  " GROUP BY decaent,deca016,rtaxl003"
   ELSE
      LET g_wc_master = cl_replace_str(g_wc_master,"deca016","deca013")
      LET l_sql = " SELECT decaent,deca013,oocql004,COUNT(DISTINCT deca020),SUM(Nvl(deca027,0)),SUM(Nvl(deca028,0)),'' ",
                  "   FROM mmag_t,deca_t LEFT JOIN oocql_t ON oocql001 = '2002' AND deca013 = oocql002 AND oocqlent = '",g_enterprise,"' AND oocql003 = '",g_lang,"'",
                  "  WHERE decaent = mmagent ",
                  "    AND decaent = '",g_enterprise,"'",
                  "    AND deca002 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
                  "    AND deca020 = mmag001 ",
                  "    AND deca013 IS NOT NULL ",
                  "    AND mmag002 = '",g_mmag002,"'",
                  "    AND ",g_wc_master CLIPPED,
                  "    AND ",l_where,
                  " GROUP BY decaent,deca013,oocql004"
   END IF 

   PREPARE sel_mmaf_pb FROM l_sql
   DECLARE sel_mmaf_cs CURSOR FOR sel_mmaf_pb
   FOREACH sel_mmaf_cs INTO l_deca.*
      LET l_n = 0
      LET l_n1 = 0
      #IF g_prog = 'acrq530' THEN         #160705-00042#11 160713 by sakura mark
      IF g_prog MATCHES 'acrq530' THEN    #160705-00042#11 160713 by sakura add
         SELECT COUNT(mmaf015),SUM(to_number(to_char(mmaf015,'yyyy')))
           INTO l_n,l_n1
           FROM mmaf_t
          WHERE mmafent = l_deca.decaent
            AND mmaf015 IS NOT NULL
            AND mmaf001 IN (SELECT DISTINCT deca020 
                              FROM deca_t
                             WHERE decaent = l_deca.decaent
                               AND deca016 = l_deca.deca013
                               AND deca002 BETWEEN g_bdate AND g_edate)
      ELSE
         SELECT COUNT(mmaf015),SUM(to_number(to_char(mmaf015,'yyyy')))
           INTO l_n,l_n1
           FROM mmaf_t
          WHERE mmafent = l_deca.decaent
            AND mmaf015 IS NOT NULL
            AND mmaf001 IN (SELECT DISTINCT deca020 
                              FROM deca_t
                             WHERE decaent = l_deca.decaent
                               AND deca013 = l_deca.deca013
                               AND deca002 BETWEEN g_bdate AND g_edate)
      END IF 
      LET l_deca.age = (YEAR(g_today)*l_n - l_n1 + 1)/l_n
     #INSERT INTO acrq530_tmp VALUES(l_deca.*)  #161111-00028#4--MARK
     #161111-00028#4--ADD----BEGIN---------
      INSERT INTO acrq530_tmp (decaent,deca013,rtaxl003,deca020,deca027,deca028,age)
       VALUES(l_deca.decaent,l_deca.deca013,l_deca.rtaxl003,l_deca.deca020,l_deca.deca027,l_deca.deca028,l_deca.age)
     #161111-00028#4--ADD----END-----------
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 单身二填充
# Memo...........:
# Usage..........: CALL acrq530_b2_fill()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrq530_b2_fill()
   DEFINE l_cnt   LIKE type_t.num5
   
   #IF g_prog = 'acrq530' THEN        #160705-00042#11 160713 by sakura mark
   IF g_prog MATCHES 'acrq530' THEN   #160705-00042#11 160713 by sakura add
      LET g_sql = " SELECT mmag004,oocql004,COUNT(DISTINCT deca020),SUM(deca027),SUM(deca028)",
                  "   FROM deca_t,oocq_t,mmag_t LEFT JOIN oocql_t ",
                  "     ON oocqlent = mmagent AND mmag003=oocql001 AND mmag004=oocql002 AND oocql003 = '",g_lang,"'", 
                  "  WHERE oocq002 = mmag002 ",
                  "    AND oocqent = decaent ",
                  "    AND oocqent = mmagent ",
                  "    AND oocqent = ",g_enterprise,
                  "    AND mmag003=oocq004 ",
                  "    AND oocq001='2049' ",
                  "    AND deca020=mmag001 ",
                  "    AND mmag002 = '",g_mmag002,"'",
                  "    AND deca002 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
                  "    AND deca016 = '",g_decc_d[l_ac].deca016,"'",             
                  "  GROUP BY mmag004,oocql004 "
   ELSE
      LET g_sql = " SELECT mmag004,oocql004,COUNT(DISTINCT deca020),SUM(deca027),SUM(deca028)",
                  "   FROM deca_t,oocq_t,mmag_t LEFT JOIN oocql_t ",
                  "     ON mmagent = oocqlent AND mmag003=oocql001 AND mmag004=oocql002 AND oocql003 = '",g_lang,"'", 
                  "  WHERE oocq002=mmag002 ",
                  "    AND oocqent = decaent ",
                  "    AND oocqent = mmagent ",
                  "    AND oocqent = ",g_enterprise,
                  "    AND mmag003=oocq004 ",
                  "    AND oocq001='2049' ",
                  "    AND deca020=mmag001 ",
                  "    AND mmag002 = '",g_mmag002,"'",
                  "    AND deca002 BETWEEN '",g_bdate,"' AND '",g_edate,"'",
                  "    AND deca013 = '",g_decc_d[l_ac].deca016,"'",             
                  "  GROUP BY mmag004,oocql004 "
   END IF 
   LET l_cnt = 1
   CALL g_deca_d.clear()
   PREPARE acrq530_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR acrq530_pb1
   FOREACH b_fill_curs1 INTO g_deca_d[l_cnt].*
      IF cl_null(g_deca_d[l_cnt].l_deca020) THEN 
         LET g_deca_d[l_cnt].l_deca020 = 0
      END IF 
      IF cl_null(g_deca_d[l_cnt].l_deca027) THEN 
         LET g_deca_d[l_cnt].l_deca027 = 0
      END IF 
      IF cl_null(g_deca_d[l_cnt].l_deca028) THEN 
         LET g_deca_d[l_cnt].l_deca028 = 0
      END IF 
      LET g_deca_d[l_cnt].l_deca020 = g_deca_d[l_cnt].l_deca020/g_decc_d[l_ac].num*100
      LET g_deca_d[l_cnt].l_deca027 = g_deca_d[l_cnt].l_deca027/g_decc_d[l_ac].deca027*100
      LET g_deca_d[l_cnt].l_deca028 = g_deca_d[l_cnt].l_deca028/g_decc_d[l_ac].deca028*100
      LET l_cnt = l_cnt + 1
      IF l_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ""
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF      
   END FOREACH 
   CALL g_deca_d.deleteElement(g_deca_d.getLength())   
   LET g_detail_cnt2 = g_cnt - 1 
END FUNCTION

################################################################################
# Descriptions...: 单身二资料刷新
# Memo...........:
# Usage..........: CALL acrq530_b2_refresh()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/15 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrq530_b2_refresh()
   DISPLAY ARRAY g_deca_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
   
      BEFORE DISPLAY 
         EXIT DISPLAY
     
   END DISPLAY
END FUNCTION

################################################################################
# Descriptions...: 属性检查
# Memo...........:
# Usage..........: CALL acrq530_mmag002_chk()
# Input parameter: 无
# Return code....: 无
# Date & Author..: 2014/07/16 By yangxf
# Modify.........:
################################################################################
PRIVATE FUNCTION acrq530_mmag002_chk()
DEFINE l_oocqstus   LIKE oocq_t.oocqstus
DEFINE l_oocql004   LIKE oocql_t.oocql004

   LET g_errno = ''
   SELECT oocqstus,oocql004 INTO l_oocqstus,l_oocql004
     FROM oocq_t LEFT JOIN oocql_t ON oocq001 = oocql001 AND oocq002 = oocql002 AND oocqent = oocqlent AND oocql003 = g_lang
    WHERE oocqent = g_enterprise
      AND oocq001 = '2049'
      AND oocq002 = g_mmag002
   CASE 
      WHEN SQLCA.SQLCODE = 100 LET g_errno = 'acr-00054'
      OTHERWISE                LET g_errno = SQLCA.SQLCODE USING '-------'
   END CASE
   IF cl_null(g_errno) THEN 
      LET g_mmag002_desc = l_oocql004
      DISPLAY g_mmag002_desc TO mmag002_desc
   END IF 
END FUNCTION

 
{</section>}
 
