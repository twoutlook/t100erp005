#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-09-16 10:55:59), PR版次:0005(2016-08-29 16:39:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000091
#+ Filename...: aglq830
#+ Description: 現金流量表查詢作業
#+ Creator....: 05416(2014-08-08 16:48:25)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="aglq830.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#140904-00009#25  2015/10/23 by 02599  1.直接法按anmi180的分类做小计，按anmi180的大类做总计 
#                                      2.直接法不取anmi180=5:现金及等价物的资料 
#                                      3.直接法在最后增加一行：现金及现金等价物净增加额
#160302-00006#1   2016/03/02 By 07675  原本单身为不可查询作业，取消单身二次筛选功能  
#160318-00025#36  2016/04/20 By 07959  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160704-00011#1   2016/07/06 By 02599  1.去除四、汇率变动合计；2.五、现金及现金等价物段增加两行：净额和期初额，现金及现金等价物=净额+期初额；
#                                      3.大类合计=流入-流出；4.大类‘合计’两字改成‘现金流量净额’
#160704-00011#6   2016/07/21 By 02599  直接法：1.根据现金变动码根据所属类型，当类型为1.标题时，金额栏位给null值显示空白；2.减项类金额以正数显示；
#                                             3.大类合计时，根据现金变动码分类的正负向计算出合计金额，改成A*正负向+B*正负向；
#                                      间接法：1.根据群组编码所属类型，当类型为1.标题时，金额栏位给null值显示空白；
#                                             2.增加当异动别是7.表内小计时，抓取金额方法
#160704-00011#8   2016/07/26 By 02599  现金变动码的直接法改用公用函数s_cashflow_direct抓取
#160326-00001#30  2016/08/04 By 02599  间接法抓取的agli210中科目可以是统制科目，增加抓取统制科目金额
#160811-00039#4   2016/08/29 By 02599  查询是自行输入账套时要检核账套权限
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
PRIVATE TYPE type_g_glfb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glfb002 LIKE glfb_t.glfb002, 
   glfbl004 LIKE glfbl_t.glfbl004, 
   nmai004 LIKE nmai_t.nmai004, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_table1           STRING
DEFINE tm                    RECORD 
       glfa005               LIKE glfa_t.glfa005,
       glfa005_desc          LIKE glaal_t.glaal002,
       glfa010               LIKE glfa_t.glfa010,
       glfa011               LIKE glfa_t.glfa011,
       glfa012               LIKE glfa_t.glfa012,
       glfa013               LIKE glfa_t.glfa013,
       glfa014               LIKE glfa_t.glfa014,
       glfa015               LIKE glfa_t.glfa015,
       glfa008               LIKE glfa_t.glfa008,
       glfa009               LIKE glfa_t.glfa009,
       show_ad               LIKE type_t.chr1,
       stus                  LIKE type_t.chr1,
       chg_curr              LIKE type_t.chr1,
       curr                  LIKE glaq_t.glaq005,
       rate                  LIKE glaq_t.glaq006,
       type_a                LIKE type_t.chr1,
       type_b                LIKE type_t.chr1,
       type_c                LIKE type_t.chr1
       END RECORD
DEFINE g_glaa001             LIKE glaa_t.glaa001
DEFINE g_glaa025             LIKE glaa_t.glaa025
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glfb_d
DEFINE g_master_t                   type_g_glfb_d
DEFINE g_glfb_d          DYNAMIC ARRAY OF type_g_glfb_d
DEFINE g_glfb_d_t        type_g_glfb_d
 
      
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
 TYPE type_g_glfb_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_glfb_e 
#end add-point
 
{</section>}
 
{<section id="aglq830.main" >}
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
   DECLARE aglq830_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq830_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq830_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq830 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq830_init()   
 
      #進入選單 Menu (="N")
      CALL aglq830_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq830
      
   END IF 
   
   CLOSE aglq830_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq830_tmp
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq830.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq830_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_cnt        LIKE type_t.num5 #160704-00011#6 add
   DEFINE l_success    LIKE type_t.num5 #160704-00011#6 add
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glfa008','8705')
   CALL cl_set_combo_scc('stus','9922')
   #建立临时表
   CALL aglq830_create_temp_table()
   CALL cl_set_combo_scc('glfbl004','8026')
   
   #160704-00011#6--add--str--
   #新增栏位，更新NULL为预设值，以免查询错误
   LET l_cnt = 0 
   #正负向
   SELECT COUNT(*) INTO l_cnt FROM nmak_t WHERE nmakent=g_enterprise AND nmak004 IS NULL
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   IF l_cnt = 0 THEN
      #现金变动码类型
      SELECT COUNT(*) INTO l_cnt FROM nmai_t WHERE nmaient=g_enterprise AND nmai005 IS NULL
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0 THEN
         #群组类型
         SELECT COUNT(*) INTO l_cnt FROM glbd_t WHERE glbdent=g_enterprise AND glbd005 IS NULL
         IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      END IF
   END IF
   IF l_cnt > 0 THEN
      CALL s_transaction_begin()
      LET l_success = TRUE
      UPDATE nmak_t SET nmak004='+' WHERE nmakent=g_enterprise AND nmak004 IS NULL
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE nmak_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
      UPDATE nmai_t SET nmai005='2' WHERE nmaient=g_enterprise AND nmai005 IS NULL
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE nmai_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
      UPDATE glbd_t SET glbd005='2' WHERE glbdent=g_enterprise AND glbd005 IS NULL
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "UPDATE glbd_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET l_success = FALSE
      END IF
      IF l_success =FALSE THEN
         CALL s_transaction_end('N','0')
      ELSE
         CALL s_transaction_end('Y','0')
      END IF
   END IF
   #160704-00011#6--add--end
   #end add-point
 
   CALL aglq830_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq830.default_search" >}
PRIVATE FUNCTION aglq830_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfbseq = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfbseq1 = '", g_argv[02], "' AND "
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
 
{<section id="aglq830.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq830_ui_dialog()
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
      CALL aglq830_b_fill()
   ELSE
      CALL aglq830_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
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
 
         CALL aglq830_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq830_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq830_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
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
            CALL aglq830_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
             CALL cl_set_act_visible("filter",FALSE)    #160302-00006#1  2016/03/01 By 07675 
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               LET g_param.v = "aglq830_tmp"
               CALL aglq830_g01("aglq830_tmp",tm.glfa005,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013,tm.glfa014,tm.glfa015,tm.glfa008,tm.glfa009)            
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET g_param.v = "aglq830_tmp"
               CALL aglq830_g01("aglq830_tmp",tm.glfa005,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013,tm.glfa014,tm.glfa015,tm.glfa008,tm.glfa009)            
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aglq830_query()
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
            CALL aglq830_filter()
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
            CALL aglq830_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glfb_d)
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
            CALL aglq830_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq830_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq830_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq830_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glfb_d.getLength()
               LET g_glfb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glfb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfb_d[li_idx].sel = "N"
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
 
{<section id="aglq830.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq830_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_glav003  LIKE glav_t.glav003
   
   CALL s_ld_bookno()  RETURNING l_success,tm.glfa005
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   CALL s_ld_chk_authorization(g_user,tm.glfa005) RETURNING l_pass
   IF l_pass = FALSE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00164'
      LET g_errparam.extend = tm.glfa005
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET tm.glfa005=NULL
   END IF
   
   LET tm.glfa010=YEAR(g_today)
   LET tm.glfa011=MONTH(g_today)
   LET tm.glfa012=tm.glfa011
   #本期未第一期
   IF tm.glfa011=1 THEN 
      LET tm.glfa013=tm.glfa010-1
      SELECT DISTINCT glav003 INTO l_glav003 FROM glaa_t,glav_t
      WHERE glaaent=glavent AND glaa003=glav001 AND glav002=tm.glfa013
      AND glaald=tm.glfa005
      IF l_glav003='2' THEN
         LET tm.glfa014=13
         LET tm.glfa015=13
      ELSE
         LET tm.glfa014=12
         LET tm.glfa015=12
      END IF
   ELSE
      LET tm.glfa013=tm.glfa010
      LET tm.glfa014=tm.glfa011-1
      LET tm.glfa015=tm.glfa011-1
   END IF
   LET tm.glfa008='1' 
   LET tm.glfa009=2
   LET tm.type_a='Y'
   LET tm.type_b='Y'
   LET tm.type_c='Y'   
   #150827-00036#1--add--str--
   LET tm.show_ad='Y'
   LET tm.stus='1'
   LET tm.chg_curr='N'
   LET tm.curr=''
   LET tm.rate=''
   CALL cl_set_comp_entry('curr,rate',FALSE)
   LET g_glaa001=''
   LET g_glaa025=''
   SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
   #150827-00036#1--add--end
   DISPLAY BY NAME tm.glfa005,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013,tm.glfa014,tm.glfa015,
                   tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c,
                   tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate #150827-00036#1 add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glfb002
           FROM s_detail1[1].b_glfb002
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.page1.b_glfb002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfb002
            #add-point:BEFORE FIELD b_glfb002 name="construct.b.page1.b_glfb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfb002
            
            #add-point:AFTER FIELD b_glfb002 name="construct.a.page1.b_glfb002"
            
            #END add-point
            
 
 
         #----<<b_glfbl004>>----
         #----<<b_nmai004>>----
         #----<<amt1>>----
         #----<<amt2>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME tm.glfa005,tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013, 
                    tm.glfa014,tm.glfa015,tm.glfa008,tm.glfa009,tm.type_a,tm.type_b,tm.type_c,
                    tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate  #150827-00036#1 add
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL aglq830_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
            DISPLAY tm.glfa005_desc TO glfa005_desc
         
         AFTER FIELD glfa005
            IF NOT cl_null(tm.glfa005) THEN
               SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00055'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa005
               END IF
               #160811-00039#4--add--str--
               SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005 AND glaastus='Y'
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00051'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa005
               END IF
               CALL s_ld_chk_authorization(g_user,tm.glfa005) RETURNING l_pass
               IF l_pass = FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00164'
                  LET g_errparam.extend = tm.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               
                  NEXT FIELD glfa005
               END IF
            END IF
            #160811-00039#4--add--end
               CALL aglq830_glfa005_desc(tm.glfa005) RETURNING tm.glfa005_desc
               DISPLAY tm.glfa005_desc TO glfa005_desc
               SELECT glaa001,glaa025 INTO g_glaa001,g_glaa025 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005
#            END IF #160811-00039#4 mark
         
         AFTER FIELD glfa011
            IF tm.glfa011>tm.glfa012 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa011
            END IF
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa011>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa011
               END IF
            END IF 

         AFTER FIELD glfa012
            IF tm.glfa012<tm.glfa011 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa012
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa010
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa012>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa012
               END IF
            END IF
            
         AFTER FIELD glfa014
            IF tm.glfa014>tm.glfa015 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00227'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa014
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa013
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa014>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa014
               END IF
            END IF
            
         AFTER FIELD glfa015
            IF tm.glfa014>tm.glfa015 THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code = 'agl-00228'
                LET g_errparam.extend = ''
                LET g_errparam.popup = FALSE
                CALL cl_err()

                NEXT FIELD glfa015
            END IF 
            SELECT MAX(glav006) INTO l_glav006 FROM glav_t
            WHERE glavent=g_enterprise AND glav001=l_glfa004 AND glav002=tm.glfa013
            IF NOT cl_null(l_glav006) THEN
               IF tm.glfa015>l_glav006 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00427'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa015
               END IF
            END IF
         AFTER FIELD glfa009
            IF NOT cl_ap_chk_Range(tm.glfa009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glfa009
            END IF
            
            
         AFTER FIELD type_a
            IF tm.type_a NOT MATCHES '[yYnN]' THEN
               NEXT FIELD glac009
            END IF
            
         AFTER FIELD type_b
            IF tm.type_b NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ce
            END IF
         
         AFTER FIELD type_c
            IF tm.type_c NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ye
            END IF
         
         #150827-00036#1--add--str--
         AFTER FIELD show_ad
            IF tm.show_ad NOT MATCHES '[yYnN]' THEN
               NEXT FIELD show_ad
            END IF
         
         AFTER FIELD stus
            IF tm.stus NOT MATCHES '[123]' THEN
               NEXT FIELD stus
            END IF
         
         ON CHANGE chg_curr
            IF tm.chg_curr = 'Y' THEN
               CALL cl_set_comp_entry('curr,rate',TRUE)
            ELSE
               CALL cl_set_comp_entry('curr,rate',FALSE)
               LET tm.curr=''
               LET tm.rate=''
               DISPLAY BY NAME tm.curr,tm.rate
            END IF
            
         AFTER FIELD curr
            IF NOT cl_null(tm.curr) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1=tm.curr
               
               #160318-00025#36  2016/04/20  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aoo-00011:sub-01302|aooi140|",cl_get_progname("aooi140",g_lang,"2"),"|:EXEPROGaooi140"
               #160318-00025#36  2016/04/20  by pengxin  add(E)
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_ooai001") THEN
                  #檢查成功時後續處理
               ELSE
                  #檢查失敗時後續處理
                  LET tm.curr=''
                  NEXT FIELD CURRENT
               END IF
               #匯率
               CALL s_aooi160_get_exrate('2',tm.glfa005,g_today,tm.curr,g_glaa001,0,g_glaa025)
               RETURNING  tm.rate
               DISPLAY BY NAME tm.rate
            END IF
            
         AFTER FIELD rate
            IF NOT cl_null(tm.rate) THEN
               IF tm.curr=g_glaa001 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00327'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  LET tm.rate=1
                  NEXT FIELD rate
               END IF
               CALL s_num_isnum(tm.rate) RETURNING l_success
               IF l_success=FALSE THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00036'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  NEXT FIELD rate
               END IF
            END IF
         #150827-00036#1--add--end
         
         ON ACTION controlp INFIELD glfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
       
            LET g_qryparam.default1 = tm.glfa005        #給予default值
            LET g_qryparam.default2 = "" #glaald #帳別編號
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            
            CALL q_authorised_ld()                                #呼叫開窗
       
            LET tm.glfa005 = g_qryparam.return1              
            DISPLAY tm.glfa005 TO glfa005            
            NEXT FIELD glfa005
            
         #150827-00036#1--add--str--
         ON ACTION controlp INFIELD curr
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = tm.curr  
            CALL q_ooai001()                          #呼叫開窗
            LET tm.curr = g_qryparam.return1
            DISPLAY tm.curr TO curr  #顯示到畫面上
            NEXT FIELD curr 
         #150827-00036#1--add--end
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
   CALL aglq830_get_data() 
   #end add-point
        
   LET g_error_show = 1
   CALL aglq830_b_fill()
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
 
{<section id="aglq830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq830_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_flag          LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL aglq830_b_fill1()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb002,'','','',''  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfbseq, 
       glfb_t.glfbseq1) AS RANK FROM glfb_t",
 
 
                     "",
                     " WHERE glfbent=? AND glfb001=? AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfbseq,glfb_t.glfbseq1"
 
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
 
   LET g_sql = "SELECT '',glfb002,'','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq830_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq830_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004, 
       g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glfb_d[l_ac].statepic = cl_get_actipic(g_glfb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq830_detail_show("'1'")      
 
      CALL aglq830_glfb_t_mask()
 
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
   
 
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glfb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq830_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq830_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq830_detail_action_trans()
 
   IF g_glfb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq830_fetch()
   END IF
   
      CALL aglq830_filter_show('glfb002','b_glfb002')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq830_fetch()
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
 
{<section id="aglq830.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq830_detail_show(ps_page)
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
 
{<section id="aglq830.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq830_filter()
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
      CONSTRUCT g_wc_filter ON glfb002
                          FROM s_detail1[1].b_glfb002
 
         BEFORE CONSTRUCT
                     DISPLAY aglq830_filter_parser('glfb002') TO s_detail1[1].b_glfb002
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfb002>>----
         #Ctrlp:construct.c.page1.b_glfb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb002
            #add-point:ON ACTION controlp INFIELD b_glfb002 name="construct.c.filter.page1.b_glfb002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_glfc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glfb002  #顯示到畫面上
            NEXT FIELD b_glfb002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_glfbl004>>----
         #----<<b_nmai004>>----
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
   
      CALL aglq830_filter_show('glfb002','b_glfb002')
 
    
   CALL aglq830_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq830_filter_parser(ps_field)
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
 
{<section id="aglq830.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq830_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq830_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.insert" >}
#+ insert
PRIVATE FUNCTION aglq830_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq830.modify" >}
#+ modify
PRIVATE FUNCTION aglq830_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq830_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.delete" >}
#+ delete
PRIVATE FUNCTION aglq830_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq830.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq830_detail_action_trans()
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
 
{<section id="aglq830.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq830_detail_index_setting()
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
            IF g_glfb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glfb_d.getLength() AND g_glfb_d.getLength() > 0
            LET g_detail_idx = g_glfb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glfb_d.getLength() THEN
               LET g_detail_idx = g_glfb_d.getLength()
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
 
{<section id="aglq830.mask_functions" >}
 &include "erp/agl/aglq830_mask.4gl"
 
{</section>}
 
{<section id="aglq830.other_function" readonly="Y" >}

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
PRIVATE FUNCTION aglq830_create_temp_table()
   DROP TABLE aglq830_tmp;
   CREATE TEMP TABLE aglq830_tmp(
   seq            LIKE type_t.num5,
   glfb002        LIKE glfb_t.glfb002,
   glfbl004       LIKE glfbl_t.glfbl004,
   nmai004        LIKE nmai_t.nmai004,
   amt1           LIKE type_t.num20_6,
   amt2           LIKE type_t.num20_6   
   );
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
PRIVATE FUNCTION aglq830_get_data()
   DEFINE l_amt1               LIKE type_t.num20_6
   DEFINE l_amt2               LIKE type_t.num20_6
   DEFINE l_amt_s1             LIKE type_t.num20_6
   DEFINE l_amt_s2             LIKE type_t.num20_6
   DEFINE l_seq                LIKE type_t.num5
   DEFINE l_nmak001            LIKE nmak_t.nmak001
   DEFINE l_nmakl003           LIKE nmakl_t.nmakl003
   DEFINE l_nmai002            LIKE nmai_t.nmai002
   DEFINE l_nmail004           LIKE nmail_t.nmail004
   DEFINE l_nmai004            LIKE nmai_t.nmai004
   DEFINE l_glbd001            LIKE glbd_t.glbd001
   DEFINE l_glbdl003           LIKE glbdl_t.glbdl003
   DEFINE l_glbd003            LIKE glbd_t.glbd003
   DEFINE l_glbe002            LIKE glbe_t.glbe002    
   DEFINE l_glbe003            LIKE glbe_t.glbe003
   DEFINE l_glbe004            LIKE glbe_t.glbe004
   DEFINE l_glbg005            LIKE glbg_t.glbg005
   DEFINE l_glac008            LIKE glac_t.glac008
   DEFINE l_period             LIKE type_t.num5
   DEFINE l_period_e           LIKE type_t.num5
   DEFINE l_count              LIKE type_t.num5
   DEFINE l_period_e1          LIKE type_t.num5
   DEFINE l_amt                LIKE type_t.num20_6
   DEFINE l_sql1               STRING
   DEFINE l_amt1_s             LIKE type_t.num20_6
   DEFINE l_amt2_s             LIKE type_t.num20_6
   DEFINE l_sum1               LIKE type_t.num20_6
   DEFINE l_sum2               LIKE type_t.num20_6
   DEFINE l_nmak002            LIKE nmak_t.nmak002
   DEFINE l_nmak002_o          LIKE nmak_t.nmak002
   DEFINE l_desc1              LIKE nmakl_t.nmakl003
   DEFINE l_desc2              LIKE nmakl_t.nmakl003
   DEFINE l_desc               LIKE nmakl_t.nmakl003
   DEFINE l_cash_sum1          LIKE type_t.num20_6  #160704-00011#1 add
   DEFINE l_cash_sum2          LIKE type_t.num20_6  #160704-00011#1 add
   #160704-00011#6--add--str--
   DEFINE l_nmak004            LIKE nmak_t.nmak004
   DEFINE l_nmak004_o          LIKE nmak_t.nmak004
   DEFINE l_nmai005            LIKE nmai_t.nmai005
   DEFINE l_glbd005            LIKE glbd_t.glbd005
   DEFINE l_flag_seq           LIKE type_t.num5
   #160704-00011#6--add--end
   DEFINE l_success            LIKE type_t.num5 #160704-00011#8 add
   #160326-00001#30--add--str--
   DEFINE l_sql_pr6_1          STRING
   DEFINE l_sql_pr7_1          STRING
   DEFINE l_sql_pr8_1          STRING
   DEFINE l_sql_pr6_2          STRING
   DEFINE l_sql_pr7_2          STRING
   DEFINE l_sql_pr8_2          STRING
   DEFINE l_glaa004            LIKE glaa_t.glaa004
   DEFINE l_glac003            LIKE glac_t.glac003
   DEFINE l_glaq002            STRING
   #160326-00001#30--add--end
   
   #刪除臨時表中資料
   DELETE FROM aglq830_tmp

#160704-00011#8--mark--str--
#直接法计算逻辑拿到sub s_cashflow_direct()中，此段mark，调用sub
#   #直接法
#   IF tm.type_a='Y' THEN
#      #抓取anmi180现金变动码分类,不取大类nmak002=5.现金及等价物的资料
#      LET g_sql="SELECT DISTINCT nmak001,nmakl003,nmak002,nmak004 ", #160704-00011#6 add nmak004
#                "  FROM nmak_t ",
#                "  LEFT JOIN nmakl_t ON nmakent=nmaklent AND nmakl001=nmak001 AND nmaklent='"||g_enterprise||"' AND nmakl002='"||g_dlang||"' ",
#                " WHERE nmakent=",g_enterprise," AND nmakstus='Y' ",
#                "   AND nmak002<>'5'",   #140904-00009#25 add
#                " ORDER BY nmak001,nmak002"
#             
#      PREPARE aglq830_pr1 FROM g_sql
#      DECLARE aglq830_cs1 CURSOR FOR aglq830_pr1 
#      
#      #現金變動碼分類下包含的現金變動碼的數量anmi160
#      LET g_sql="SELECT COUNT(DISTINCT nmai002) ",
#                "  FROM nmai_t ",
#                " WHERE nmaient=",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
#                "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"' )"    
#      PREPARE aglq830_count_pr FROM g_sql
#      
#      #抓取現金變動碼資料
#      LET g_sql="SELECT DISTINCT nmai002,nmail004,nmai004,nmai005 ", #160704-00011#6 add nmai005
#                "  FROM nmai_t ",
#                "  LEFT JOIN nmail_t ON nmaient=nmailent AND nmai001=nmail001 AND nmai002=nmail002 AND nmailent='"||g_enterprise||"' AND nmail003='"||g_dlang||"' ",
#                " WHERE nmaient=",g_enterprise," AND nmaistus='Y' AND nmai003=? ",
#                "   AND nmai001=(SELECT glaa005 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"' )",
#                " ORDER BY nmai002,nmai004"
#                
#      PREPARE aglq830_pr2 FROM g_sql
#      DECLARE aglq830_cs2 CURSOR FOR aglq830_pr2
#      
#      LET g_sql="SELECT SUM(CASE WHEN glbc003='1' THEN glbc009 ELSE (-1)*glbc009 END) ",
#                "  FROM glbc_t,glap_t ",  #150730-00007 1 add glap_t与glbc_t关联资料限定glapstus=S
#                " WHERE glbcent=glapent AND glbcld=glapld AND glbcdocno=glapdocno ", #150730-00007 1 add
#                "   AND glbcent=",g_enterprise," AND glbc010 = '1'",
#                "   AND glbcld='",tm.glfa005,"'",
#                "   AND glbc001=? AND glbc002 BETWEEN ? AND ? ",
#                "   AND glbc004=? "
##                "   AND glapstus='S' "  #150730-00007 1 add #150827-00036#1 mark
#      #150827-00036#1--add--str--
#      #凭证状态
#      CASE tm.stus
#         WHEN '1' LET g_sql=g_sql," AND glapstus='S' "
#         WHEN '2' LET g_sql=g_sql," AND glapstus IN ('S','Y') "
#         WHEN '3' LET g_sql=g_sql," AND glapstus IN ('S','Y','N') "
#      END CASE
#      #含审计调整凭证否
#      IF tm.show_ad='N' THEN
#         LET g_sql=g_sql," AND glap007<>'AD' "
#      END IF
#      #150827-00036#1--add--end
#      PREPARE aglq830_pr3 FROM g_sql
#      
#      #现金及现金等价物净增加额
#      IF tm.stus='1' AND  tm.show_ad='Y' THEN
#         LET g_sql="SELECT SUM(glar005-glar006) FROM glac_t,glar_t",
#                   " WHERE glacent=glarent AND glac002=glar001",
#                   "   AND glacent=",g_enterprise,
#                   "   AND glac016='Y'",
#                   "   AND glacstus='Y'",
#                   "   AND glac003 IN ('2','3')",
#                   "   AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"')",
#                   "   AND glarld='",tm.glfa005,"'",
##                   "   AND glar002=? AND glar003 BETWEEN ? AND ?" #160704-00011#1 mark
#                   "   AND glar002=? AND glar003< ?" #160704-00011#1 add
#      ELSE
#         #160704-00011#1--add--str--
#         #抓取年初金额
#         LET g_sql="SELECT SUM(glar005-glar006) FROM glac_t,glar_t",
#                   " WHERE glacent=glarent AND glac002=glar001",
#                   "   AND glacent=",g_enterprise,
#                   "   AND glac016='Y'",
#                   "   AND glacstus='Y'",
#                   "   AND glac003 IN ('2','3')",
#                   "   AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"')",
#                   "   AND glarld='",tm.glfa005,"'",
#                   "   AND glar002=? AND glar003=0 "
#         PREPARE aglq830_nch_pr FROM g_sql
#         #160704-00011#1--add--end
#         #期初金额
#         LET g_sql="SELECT SUM(glaq003-glaq004)",
#                   "  FROM glac_t,glaq_t",
#                   " INNER JOIN glap_t ON glapent=glaqent AND glapld = glaqld AND glapdocno = glaqdocno ",
#                   " WHERE glacent=glaqent AND glac002=glaq002 ",
#                   "   AND glacent=",g_enterprise,
#                   "   AND glac016='Y'",
#                   "   AND glacstus='Y'",
#                   "   AND glac003 IN ('2','3')",
#                   "   AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=",g_enterprise," AND glaald='",tm.glfa005,"')",
#                   "   AND glaqld='",tm.glfa005,"'",
##                   "   AND glap002=? AND glap004 BETWEEN ? AND ?" #160704-00011#1 mark
#                   "   AND glap002=? AND glap004 <? " #160704-00011#1 add
#         #凭证状态
#         CASE tm.stus
#            WHEN '1' LET g_sql=g_sql," AND glapstus='S' "
#            WHEN '2' LET g_sql=g_sql," AND glapstus IN ('S','Y') "
#            WHEN '3' LET g_sql=g_sql," AND glapstus IN ('S','Y','N') "
#         END CASE
#         #含审计调整凭证否
#         IF tm.show_ad='N' THEN
#            LET g_sql=g_sql," AND glap007<>'AD' "
#         END IF
#      END IF
#      PREPARE aglq830_glac_pr FROM g_sql
#   END IF
#160704-00011#8--mark--end
   
   #間接法
   IF tm.type_b='Y' THEN
      LET g_sql="SELECT DISTINCT glbd001,glbdl003,glbd003,glbd005 ",  #160704-00011#5 add glbd005
                "  FROM glbe_t,glbd_t ",
                "  LEFT JOIN glbdl_t ON glbdent=glbdlent AND glbd001=glbdl001 AND glbdlent='"||g_enterprise||"' AND glbdl002='"||g_dlang||"' ",
                " WHERE glbdent=glbeent AND glbd001=glbe001 AND glbdstus='Y' ",
                "   AND glbdent=",g_enterprise," AND glbeld='",tm.glfa005,"'",
                " ORDER BY glbd001,glbd003 "
     
      PREPARE aglq830_pr4 FROM g_sql
      DECLARE aglq830_cs4 CURSOR FOR aglq830_pr4
      
      LET g_sql="SELECT glbe002,glbe003,glbe004 ",
                "  FROM glbe_t ",
                " WHERE glbeent=",g_enterprise," AND glbeld='",tm.glfa005,"'",
                "   AND glbe001=? AND glbestus='Y' ",
                " ORDER BY glbe002 "
                
      PREPARE aglq830_pr5 FROM g_sql
      DECLARE aglq830_cs5 CURSOR FOR aglq830_pr5
      
      #借方-貸方
      LET g_sql=" SELECT SUM(glar005-glar006) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003 BETWEEN ? AND ? "
      PREPARE aglq830_pr6 FROM g_sql
      
      #借方
      LET g_sql=" SELECT SUM(glar005) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003 BETWEEN ? AND ? "
      PREPARE aglq830_pr7 FROM g_sql
      
      #貸方
      LET g_sql=" SELECT SUM(glar006) FROM glar_t ",
                "  WHERE glarent=",g_enterprise," AND glarld='",tm.glfa005,"'",
                "    AND glar001=?",
                "    AND glar002=? AND glar003 BETWEEN ? AND ? "
      PREPARE aglq830_pr8 FROM g_sql
      
      #160704-00011#5--add--str--
      #表内小计
      LET g_sql=" SELECT SUM(amt1),SUM(amt2)",
                "   FROM aglq830_tmp ",
                "  WHERE glfb002 = ? ",
                "    AND seq > ?"  #用于限定抓取的是间接法资料
      PREPARE aglq830_sum_tmp_pr1 FROM g_sql
      #160704-00011#5--add--end
      
      #人工輸入金額(agli220)
      LET g_sql="SELECT SUM(glbf007) FROM glbf_t ",
                " WHERE glbfent=",g_enterprise," AND glbfld='",tm.glfa005,"'",
                "   AND glbf001=? AND glbf002 BETWEEN ? AND ? ",
                "   AND glbf003=? AND glbf004=? "
      PREPARE aglq830_pr9 FROM g_sql
      
      #150827-00036#1--add--str--
      #抓取凭证状态为未审核或已审核的凭证金额（+）
      IF tm.stus <> '1' THEN
         CASE tm.stus
            WHEN '2' LET l_sql1=" AND glapstus ='Y' "
            WHEN '3' LET l_sql1=" AND glapstus IN ('Y','N') "
         END CASE
         #借方-貸方
#         LET g_sql=" SELECT SUM(glaq003-glaq004) ", #160326-00001#30 mark
         LET l_sql_pr6_1=" SELECT SUM(glaq003-glaq004) ", #160326-00001#30  add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   l_sql1
#         PREPARE aglq830_pr6_1 FROM g_sql  #160326-00001#30 mark
         
         #借方
#         LET g_sql=" SELECT SUM(glaq003) ", #160326-00001#30 mark
         LET l_sql_pr7_1=" SELECT SUM(glaq003) ", #160326-00001#30 add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   l_sql1
#         PREPARE aglq830_pr7_1 FROM g_sql #160326-00001#30 mark
         
         #貸方
#         LET g_sql=" SELECT SUM(glaq004)", #160326-00001#30 mark
         LET l_sql_pr8_1=" SELECT SUM(glaq004)", #160326-00001#30 add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   l_sql1
#         PREPARE aglq830_pr8_1 FROM g_sql #160326-00001#30 mark
      END IF
      #扣减AD审计调整凭证金额(-)
      IF tm.show_ad='N' THEN
         CASE tm.stus
            WHEN '1' LET l_sql1=" AND glapstus ='S' "
            WHEN '2' LET l_sql1=" AND glapstus IN ('Y','S')  "
            WHEN '3' LET l_sql1=" AND glapstus IN ('N','Y','S') "
         END CASE
         #借方-貸方
#         LET g_sql=" SELECT SUM(glaq003-glaq004) ", #160326-00001#30 mark
         LET l_sql_pr6_2=" SELECT SUM(glaq003-glaq004) ", #160326-00001#30 add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   "    AND glap007='AD' ",l_sql1
#         PREPARE aglq830_pr6_2 FROM g_sql #160326-00001#30 mark
         
         #借方
#         LET g_sql=" SELECT SUM(glaq003) ", #160326-00001#30 mark
         LET l_sql_pr7_2=" SELECT SUM(glaq003) ", #160326-00001#30 add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   "    AND glap007='AD' ",l_sql1
#         PREPARE aglq830_pr7_2 FROM g_sql #160326-00001#30 mark
         
         #貸方
#         LET g_sql=" SELECT SUM(glaq004)", #160326-00001#30 mark
         LET l_sql_pr8_2=" SELECT SUM(glaq004)", #160326-00001#30 add
                   "   FROM glaq_t INNER JOIN glap_t ON glapent=glaqent AND glapld=glaqld AND glapdocno=glaqdocno",
                   "  WHERE glapent=",g_enterprise," AND glapld='",tm.glfa005,"'",
#                   "    AND glaq002=?", #160326-00001#30 mark
                   "    AND glap002=? AND glap004 BETWEEN ? AND ? ",
                   "    AND glap007='AD' ",l_sql1
#         PREPARE aglq830_pr8_2 FROM g_sql #160326-00001#30 mark
      END IF
      #150827-00036#1--add--end
   END IF
   
   #附註揭露
   IF tm.type_c='Y' THEN
      LET g_sql="SELECT DISTINCT glbg005 ",
                "  FROM glbg_t ",
                " WHERE glbgent=",g_enterprise," AND glbgld='",tm.glfa005,"'",
                "   AND glbg001='3' ",
                "   AND ((glbg002=",tm.glfa010," AND glbg003 BETWEEN ",tm.glfa011," AND ",tm.glfa012,")",
                "     OR (glbg002=",tm.glfa013," AND glbg003 BETWEEN ",tm.glfa014," AND ",tm.glfa015,") )"
                
      PREPARE aglq830_pr10 FROM g_sql
      DECLARE aglq830_cs10 CURSOR FOR aglq830_pr10
      
      LET g_sql="SELECT SUM(glbg006) ",
                "  FROM glbg_t ",
                " WHERE glbgent=",g_enterprise," AND glbgld='",tm.glfa005,"'",
                "   AND glbg001='3' ",
                "   AND glbg002=? AND glbg003 BETWEEN ? AND ? ",
                "   AND glbg005=? "
                
     PREPARE aglq830_pr11 FROM g_sql
   END IF
   
   CALL cl_err_collect_init()
   LET g_success = TRUE
   LET l_seq=0
   LET l_cash_sum1=0  #160704-00011#1 add
   LET l_cash_sum2=0  #160704-00011#1 add
   #直接法
   IF tm.type_a='Y' THEN
#160704-00011#8--mark--str--
#直接法计算逻辑拿到sub s_cashflow_direct()中，此段mark，调用sub
#      LET l_desc1=cl_getmsg('aap-00287',g_dlang) #小计
##      LET l_desc2=cl_getmsg('axc-00204',g_dlang) #合计#160704-00011#1 mark
#      LET l_desc2=cl_getmsg('agl-00463',g_dlang)  #现金流量净额 #160704-00011#1 add
#      LET l_nmak002_o=''
#      FOREACH aglq830_cs1 INTO l_nmak001,l_nmakl003,l_nmak002,l_nmak004 #160704-00011#5 add l_nmak004
#         IF SQLCA.sqlcode THEN
##            CALL cl_errmsg('FOREACH aglq830_cs1','','',SQLCA.sqlcode,1)
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = 'FOREACH aglq830_cs1'
#            LET g_errparam.code = SQLCA.SQLCODE
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            LET g_success = FALSE
#            EXIT FOREACH
#         END IF
#         #判斷該現金變動碼分類下是否包含現金變動碼
#         LET l_count=0
#         EXECUTE aglq830_count_pr USING l_nmak001 INTO l_count
#         IF l_count=0 THEN
#            CONTINUE FOREACH
#         END IF
#         
#         #3)按照大类总计
#         IF cl_null(l_nmak002_o) THEN
#            LET l_nmak002_o=l_nmak002
#            LET l_sum1=0 #收入
#            LET l_sum2=0 #收入
#            LET l_nmak004_o=l_nmak004 #160704-00011#5 add
#         ELSE
#            IF l_nmak002_o=l_nmak002 THEN
#               IF l_nmak004_o = '+' THEN #160704-00011#5 add
#                  LET l_sum1=l_sum1 + l_amt1_s  
#                  LET l_sum2=l_sum2 + l_amt2_s 
#               #160704-00011#5--add--str--
#               ELSE
#                  LET l_sum1=l_sum1 + l_amt1_s * -1  
#                  LET l_sum2=l_sum2 + l_amt2_s * -1
#               END IF
#               LET l_nmak004_o=l_nmak004
#               #160704-00011#5--add--end
#            ELSE
#               IF l_nmak002_o <> '4'THEN #160704-00011#1 add 汇率变动不合计
#                  IF l_nmak004_o = '+' THEN #160704-00011#5 add
#                     LET l_sum1=l_sum1 + l_amt1_s 
#                     LET l_sum2=l_sum2 + l_amt2_s 
#                  #160704-00011#5--add--str--
#                  ELSE
#                     LET l_sum1=l_sum1 + l_amt1_s * -1
#                     LET l_sum2=l_sum2 + l_amt2_s * -1
#                  END IF
#                  #160704-00011#5--add--end
#                  
#                  LET l_seq=l_seq+1
#                  LET l_desc=s_desc_gzcbl004_desc('8026',l_nmak002_o),l_desc2
#                  INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#                  VALUES(l_seq,l_nmak002,l_desc,'',l_sum1,l_sum2)
#                  IF SQLCA.sqlcode THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.extend = 'ins aglq830_tmp'
#                     LET g_errparam.code = SQLCA.SQLCODE
#                     LET g_errparam.popup = TRUE
#                     CALL cl_err()
#                     LET g_success = FALSE
#                  END IF
#               END IF #160704-00011#1 add 汇率变动不合计
#               #160704-00011#1--add--str--
#               #现金及现金等价物净增加额
#               IF l_nmak002_o='1' OR l_nmak002_o='2' OR l_nmak002_o='3' THEN
#                  LET l_cash_sum1 = l_cash_sum1 + l_sum1
#                  LET l_cash_sum2 = l_cash_sum2 + l_sum2
#               END IF
#               IF l_nmak002_o='4' THEN
#                  LET l_cash_sum1 = l_cash_sum1 + l_amt1_s
#                  LET l_cash_sum2 = l_cash_sum2 + l_amt2_s
#               END IF
#               #160704-00011#1--add--end
#               LET l_nmak002_o=l_nmak002            
#               LET l_sum1=0
#               LET l_sum2=0
#               LET l_nmak004_o=l_nmak004 #160704-00011#5 add
#            END IF
#         END IF
#         
#         LET l_amt1_s=0
#         LET l_amt2_s=0
#         #1)分类对应的现金变动码
#         FOREACH aglq830_cs2 USING l_nmak001 INTO l_nmai002,l_nmail004,l_nmai004,l_nmai005 #160704-00011#5 add l_nmai005
#            IF SQLCA.sqlcode THEN
##               CALL cl_errmsg('FOREACH aglq830_cs2','','',SQLCA.sqlcode,1)
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = 'FOREACH aglq830_cs2'
#               LET g_errparam.code = SQLCA.SQLCODE
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = FALSE
#               EXIT FOREACH
#            END IF
#            LET l_seq=l_seq+1
#            #160704-00011#5--add--str--
#            #当类型为1.标题时，金额=NULL；当类型=2.内容时，计算金额
#            IF l_nmai005 = '1' THEN
#               LET l_amt1 = NULL
#               LET l_amt2 = NULL
#            ELSE
#            #160704-00011#5--add--end
#               #本期數
#               EXECUTE aglq830_pr3 USING tm.glfa010,tm.glfa011,tm.glfa012,l_nmai002 INTO l_amt1
#               #上期數
#               EXECUTE aglq830_pr3 USING tm.glfa013,tm.glfa014,tm.glfa015,l_nmai002 INTO l_amt2
#               IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
#               IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
#               
#               #160704-00011#5--add--str--
#               #当该项目是减项时，金额乘以-1
#               IF l_nmak004 = '-' THEN
#                  LET l_amt1 = l_amt1 * -1
#                  LET l_amt2 = l_amt2 * -1
#               END IF
#               #160704-00011#5--add--end
#            
#               CASE tm.glfa008
#                  WHEN '2'  #千
#                     LET l_amt1 = l_amt1 / 1000
#                     LET l_amt2 = l_amt2 / 1000
#                  WHEN '3'  #萬
#                     LET l_amt1 = l_amt1 / 10000
#                     LET l_amt2 = l_amt2 / 10000
#               END CASE
#               
#               #150827-00036#1--add--str--
#               #是否進行幣別轉換
#               IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
#                  LET l_amt1 = l_amt1 * tm.rate
#                  LET l_amt2 = l_amt2 * tm.rate
#               END IF
#               #150827-00036#1--add--end
#               
#               #小數取位
#               CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
#               CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
#            END IF #160704-00011#5 add
#            
#            INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#            VALUES(l_seq,l_nmai002,l_nmail004,l_nmai004,l_amt1,l_amt2)
#            IF SQLCA.sqlcode THEN
##               CALL cl_errmsg('insert','','',SQLCA.sqlcode,1)
#               INITIALIZE g_errparam TO NULL
#               LET g_errparam.extend = 'ins aglq830_tmp'
#               LET g_errparam.code = SQLCA.SQLCODE
#               LET g_errparam.popup = TRUE
#               CALL cl_err()
#               LET g_success = FALSE
#            END IF
#            #当类型=2.内容时，才将金额合计
#            IF l_nmai005 <> '1' THEN #160704-00011#5 add
#               LET l_amt1_s=l_amt1_s+l_amt1 
#               LET l_amt2_s=l_amt2_s+l_amt2 
#            END IF #160704-00011#5 add
#         END FOREACH
#         #2)分类小计
#         LET l_seq=l_seq+1
#         LET l_nmakl003=l_nmakl003,l_desc1
#         INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#         VALUES(l_seq,l_nmak001,l_nmakl003,'',l_amt1_s,l_amt2_s)
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = 'ins aglq830_tmp'
#            LET g_errparam.code = SQLCA.SQLCODE
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            LET g_success = FALSE
#         END IF 
#         
#      END FOREACH
#      #3)最后一个大类插入到临时表
##      IF NOT cl_null(l_nmak002_o) THEN #160704-00011#1 mark
#      IF NOT cl_null(l_nmak002_o) AND l_nmak002_o <> '4'THEN #160704-00011#1 add 汇率变动不合计
#         IF l_nmak004 = '+' THEN #160704-00011#5 add
#            LET l_sum1=l_sum1 + l_amt1_s 
#            LET l_sum2=l_sum2 + l_amt2_s 
#         #160704-00011#5--add--str--
#         ELSE
#            LET l_sum1=l_sum1 + l_amt1_s * -1
#            LET l_sum2=l_sum2 + l_amt2_s * -1
#         END IF
#         #160704-00011#5--add--end
#         LET l_seq=l_seq+1
#         LET l_desc=s_desc_gzcbl004_desc('8026',l_nmak002),l_desc2
#         INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#         VALUES(l_seq,l_nmak002,l_desc,'',l_sum1,l_sum2)
#         IF SQLCA.sqlcode THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = 'ins aglq830_tmp'
#            LET g_errparam.code = SQLCA.SQLCODE
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            LET g_success = FALSE
#         END IF
#      END IF
#      #160704-00011#1--add--str--
#      #4）现金及现金等价物净增加额
#      IF l_nmak002_o='1' OR l_nmak002_o='2' OR l_nmak002_o='3' THEN
#         LET l_cash_sum1 = l_cash_sum1 + l_sum1
#         LET l_cash_sum2 = l_cash_sum2 + l_sum2
#      END IF
#      IF l_nmak002_o='4' THEN
#         LET l_cash_sum1 = l_cash_sum1 + l_amt1_s
#         LET l_cash_sum2 = l_cash_sum2 + l_amt2_s
#      END IF
#      LET l_seq=l_seq+1
#      LET l_desc=cl_getmsg('agl-00464',g_dlang)
#      INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#      VALUES(l_seq,'5',l_desc,'',l_cash_sum1,l_cash_sum2)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'ins aglq830_tmp'
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET g_success = FALSE
#      END IF
#      
#      #5）加：期初现金及现金等价物余额
#      LET l_desc=''
#      LET l_amt1=0
#      LET l_amt2=0
#      IF tm.stus='1' AND  tm.show_ad='Y' THEN
#          #本期数
#          EXECUTE aglq830_glac_pr USING tm.glfa010,tm.glfa011 INTO l_amt1
#          IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
#          #上期数
#          EXECUTE aglq830_glac_pr USING tm.glfa013,tm.glfa014 INTO l_amt2
#          IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
#      ELSE
#         #本期数
#         LET l_sum1=0 #年初数
#         EXECUTE aglq830_nch_pr USING tm.glfa010 INTO l_sum1
#         IF cl_null(l_sum1) THEN LET l_sum1=0 END IF
#         EXECUTE aglq830_glac_pr USING tm.glfa010,tm.glfa011 INTO l_amt1
#         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
#         LET l_amt1 = l_amt1 + l_sum1
#         #上期数
#         LET l_sum2=0 #年初数
#         EXECUTE aglq830_nch_pr USING tm.glfa013 INTO l_sum2
#         IF cl_null(l_sum2) THEN LET l_sum2=0 END IF
#         EXECUTE aglq830_glac_pr USING tm.glfa013,tm.glfa014 INTO l_amt2
#         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
#         LET l_amt2 = l_amt2 + l_sum2
#      END IF
#      LET l_seq=l_seq+1
#      LET l_desc=cl_getmsg('agl-00465',g_dlang)
#      INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#      VALUES(l_seq,'5',l_desc,'',l_amt1,l_amt2)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'ins aglq830_tmp'
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET g_success = FALSE
#      END IF
#      
#      #6）现金及现金等价物 = 现金及现金等价物净增加额 + 加：期初现金及现金等价物余额
#      LET l_amt1 = l_amt1 + l_cash_sum1
#      LET l_amt2 = l_amt2 + l_cash_sum2
#      LET l_seq=l_seq+1
#      LET l_desc=s_desc_gzcbl004_desc('8026','5')
#      INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#      VALUES(l_seq,'5',l_desc,'',l_amt1,l_amt2)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'ins aglq830_tmp'
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET g_success = FALSE
#      END IF
#      #160704-00011#1--add--end
#160704-00011#8--mark--end

#160704-00011#1--mark--str--      
#      #4)现金及现金等价物净增加额
#      LET l_desc=''
#      LET l_amt1=0
#      LET l_amt2=0
#      #本期数
#      EXECUTE aglq830_glac_pr USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt1
#      IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
#      #上期数
#      EXECUTE aglq830_glac_pr USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt2
#      IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
#      LET l_seq=l_seq+1
#      LET l_desc=s_desc_gzcbl004_desc('8026','5')
#      INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
#      VALUES(l_seq,'5',l_desc,'',l_amt1,l_amt2)
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.extend = 'ins aglq830_tmp'
#         LET g_errparam.code = SQLCA.SQLCODE
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#         LET g_success = FALSE
#      END IF
#160704-00011#1--mark--end
      #160704-00011#8--add--str--
      CALL s_cashflow_direct(tm.glfa005,'1',tm.glfa010,tm.glfa011,tm.glfa012,tm.glfa013,tm.glfa014,tm.glfa015,
                             tm.glfa009,tm.glfa008,tm.show_ad,tm.stus,tm.chg_curr,tm.curr,tm.rate)
      RETURNING l_success
      IF l_success = FALSE THEN
         LET g_success = FALSE
      END IF
      #160704-00011#8 --add--end
   END IF
   
   #160704-00011#8--add--str--
   #重新取得临时表中的项次seq值
   SELECT MAX(seq) INTO l_seq FROM aglq830_tmp
   IF cl_null(l_seq) THEN LET l_seq = 0 END IF
   #160704-00011#8 --add--end
   
   #間接法
   IF tm.type_b='Y' THEN
      SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005 #160326-00001#30 add
      
      LET l_flag_seq = l_seq  #用于表内合计，限定抓取临时表资料，都是抓取的间接法资料 #160704-00011#5 add
      FOREACH aglq830_cs4 INTO l_glbd001,l_glbdl003,l_glbd003,l_glbd005  #160704-00011#5 add
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('FOREACH aglq830_cs4','','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglq830_cs4'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_seq=l_seq+1
         
         #160704-00011#5--add--str--
         #当群组类型是1.标题时，显示说明，金额给NULL
         IF l_glbd005 = '1' THEN
            INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
            VALUES(l_seq,l_glbd001,l_glbdl003,l_glbd003,NULL,NULL)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'ins aglq830_tmp'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
            END IF
            CONTINUE FOREACH
         END IF
         #160704-00011#5--add--end
         
         LET l_amt1=0
         LET l_amt2=0
         
         FOREACH aglq830_cs5 USING l_glbd001 INTO l_glbe002,l_glbe003,l_glbe004
            IF SQLCA.sqlcode THEN
#               CALL cl_errmsg('FOREACH aglq830_cs5','','',SQLCA.sqlcode,1)
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'FOREACH aglq830_cs5'
               LET g_errparam.code = SQLCA.SQLCODE
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_success = FALSE
               EXIT FOREACH
            END IF
            
            #160326-00001#30--add--str--
            IF (l_glbe004<>'4' AND l_glbe004<>'7') AND (tm.stus <>'1'  OR tm.show_ad='N') THEN
               SELECT glac003 INTO l_glac003 FROM glac_t 
                WHERE glacent=g_enterprise 
                  AND glac001=l_glaa004
                  AND glac002=l_glbe002 
               IF l_glac003 = '1' THEN
                  #抓取科目对应的明细科目或者独立科目
                  CALL s_voucher_get_glac_str(l_glaa004,l_glbe002) RETURNING l_glaq002
               ELSE
                  LET l_glaq002 = "'",l_glbe002,"'"
               END IF
               #抓取凭证状态为未审核或已审核的凭证金额（+）
               IF tm.stus <> '1' THEN
                  CASE
                     #異動 #期初 #期末
                     WHEN l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3' 
                        #SUM(借方-貸方)
                        LET g_sql=l_sql_pr6_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr6_1 FROM g_sql
                     #借方異動
                     WHEN l_glbe004='5' 
                        #SUM(借方)
                        LET g_sql=l_sql_pr7_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr7_1 FROM g_sql
                     #貸方異動
                     WHEN l_glbe004='6' 
                        #SUM(貸方)
                        LET g_sql=l_sql_pr8_1," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr8_1 FROM g_sql
                  END CASE
               END IF
               #扣减AD审计调整凭证金额(-)
               IF tm.show_ad='N' THEN
                  CASE
                     #異動 #期初 #期末
                     WHEN l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3'
                        #SUM(借方-貸方)
                        LET g_sql=l_sql_pr6_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr6_2 FROM g_sql
                     #借方異動
                     WHEN l_glbe004='5' 
                        #SUM(借方)
                        LET g_sql=l_sql_pr7_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr7_2 FROM g_sql
                     #貸方異動
                     WHEN l_glbe004='6'
                        #SUM(貸方)
                        LET g_sql=l_sql_pr8_2," AND glaq002 IN (",l_glaq002,")"
                        PREPARE aglq830_pr8_2 FROM g_sql
                  END CASE
               END IF
            END IF
            #160326-00001#30--add--end
            
            CASE
               WHEN l_glbe004='1' #異動
                  #本期數
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                  #上期數
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                  IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                  IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                  
                  #150827-00036#1--add--str--
                  #抓取未审核或已审核的凭证金额(+)
                  IF tm.stus <>'1' THEN
                     #本期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 + l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 + l_amt
                  END IF
                  
                  #扣减AD审计调整凭证金额(-)
                  IF tm.show_ad='N' THEN
                     #本期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 - l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 - l_amt
                  END IF
                  #150827-00036#1--add--end
                  
               WHEN l_glbe004='2' #期初
                  LET l_period=0
                  #本期數
                  LET l_period_e=tm.glfa012-1
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa010,l_period,l_period_e INTO l_amt_s1
                  #上期數
                  LET l_period_e1=tm.glfa015-1
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa013,l_period,l_period_e1 INTO l_amt_s2
                  IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                  IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                  
                  #150827-00036#1--add--str--
                  #抓取未审核或已审核的凭证金额(+)
                  IF tm.stus <>'1' THEN
                     #本期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa010,l_period,l_period_e INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 + l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa013,l_period,l_period_e1 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 + l_amt
                  END IF
                  
                  #扣减AD审计调整凭证金额(-)
                  IF tm.show_ad='N' THEN
                     #本期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa010,l_period,l_period_e INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 - l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa013,l_period,l_period_e1 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 - l_amt
                  END IF
                  #150827-00036#1--add--end
                  
               WHEN l_glbe004='3' #期末
                  LET l_period=0
                  #本期數
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa010,l_period,tm.glfa012 INTO l_amt_s1
                  #上期數
                  EXECUTE aglq830_pr6 USING l_glbe002,tm.glfa013,l_period,tm.glfa015 INTO l_amt_s2 
                  IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                  IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                  
                  #150827-00036#1--add--str--
                  #抓取未审核或已审核的凭证金额(+)
                  IF tm.stus <>'1' THEN
                     #本期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa010,l_period,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 + l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_1 USING tm.glfa013,l_period,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 + l_amt
                  END IF
                  
                  #扣减AD审计调整凭证金额(-)
                  IF tm.show_ad='N' THEN
                     #本期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa010,l_period,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 - l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr6_2 USING tm.glfa013,l_period,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 - l_amt
                  END IF
                  #150827-00036#1--add--end
                  
               WHEN l_glbe004='4' #人工輸入
                  #本期數
                  EXECUTE aglq830_pr9 USING tm.glfa010,tm.glfa011,tm.glfa012,l_glbd001,l_glbe002 INTO l_amt_s1
                  #上期數
                  EXECUTE aglq830_pr9 USING tm.glfa013,tm.glfa014,tm.glfa015,l_glbd001,l_glbe002 INTO l_amt_s2
                  
               WHEN l_glbe004='5' #借方異動
                  #本期數
                  EXECUTE aglq830_pr7 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                  #上期數
                  EXECUTE aglq830_pr7 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                  IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                  IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                  
                  #150827-00036#1--add--str--
                  #抓取未审核或已审核的凭证金额(+)
                  IF tm.stus <>'1' THEN
                     #本期數
                     EXECUTE aglq830_pr7_1 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 + l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr7_1 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 + l_amt
                  END IF
                  
                  #扣减AD审计调整凭证金额(-)
                  IF tm.show_ad='N' THEN
                     #本期數
                     EXECUTE aglq830_pr7_2 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 - l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr7_2 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 - l_amt
                  END IF
                  #150827-00036#1--add--end
                  
               WHEN l_glbe004='6' #貸方異動
                  #本期數
                  EXECUTE aglq830_pr8 USING l_glbe002,tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt_s1
                  #上期數
                  EXECUTE aglq830_pr8 USING l_glbe002,tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt_s2 
                  IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
                  IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
                  
                  #150827-00036#1--add--str--
                  #抓取未审核或已审核的凭证金额(+)
                  IF tm.stus <>'1' THEN
                     #本期數
                     EXECUTE aglq830_pr8_1 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 + l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr8_1 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 + l_amt
                  END IF
                  
                  #扣减AD审计调整凭证金额(-)
                  IF tm.show_ad='N' THEN
                     #本期數
                     EXECUTE aglq830_pr8_2 USING tm.glfa010,tm.glfa011,tm.glfa012 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s1 = l_amt_s1 - l_amt
                     
                     #上期數
                     EXECUTE aglq830_pr8_2 USING tm.glfa013,tm.glfa014,tm.glfa015 INTO l_amt #160326-00001#30 MOD 去掉科目l_glbe002传参
                     IF cl_null(l_amt) THEN LET l_amt=0 END IF
                     LET l_amt_s2 = l_amt_s2 - l_amt
                  END IF
                  #150827-00036#1--add--end
            
               #160704-00011#5--add--str--
               WHEN l_glbe004='7' #表内小计
                  EXECUTE aglq830_sum_tmp_pr1 USING l_glbe002,l_flag_seq INTO l_amt_s1,l_amt_s2
               #160704-00011#5--add--end
            END CASE
            IF cl_null(l_amt_s1) THEN LET l_amt_s1=0 END IF
            IF cl_null(l_amt_s2) THEN LET l_amt_s2=0 END IF
            IF l_glbe004='1' OR l_glbe004='2' OR l_glbe004='3' THEN
               #該科目正常餘額形態
               SELECT glac008 INTO l_glac008 FROM glac_t
                WHERE glacent=g_enterprise 
                  AND glac001=(SELECT glaa004 FROM glaa_t WHERE glaaent=g_enterprise AND glaald=tm.glfa005)
                  AND glac002=l_glbe002  
               IF l_glac008='2' THEN #餘額在貸方
                  LET l_amt_s1=(-1)*l_amt_s1
                  LET l_amt_s2=(-1)*l_amt_s2
               END IF
            END IF
            IF l_glbe003='+' THEN
               LET l_amt1=l_amt1 + l_amt_s1
               LET l_amt2=l_amt2 + l_amt_s2
            END IF
            IF l_glbe003='-' THEN
               LET l_amt1=l_amt1 - l_amt_s1
               LET l_amt2=l_amt2 - l_amt_s2
            END IF            
         END FOREACH
         
         CASE tm.glfa008
            WHEN '2'  #千
               LET l_amt1 = l_amt1 / 1000
               LET l_amt2 = l_amt2 / 1000
            WHEN '3'  #萬
               LET l_amt1 = l_amt1 / 10000
               LET l_amt2 = l_amt2 / 10000
         END CASE
         
         #150827-00036#1--add--str--
         #是否進行幣別轉換
         IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
            LET l_amt1 = l_amt1 * tm.rate
            LET l_amt2 = l_amt2 * tm.rate
         END IF
         #150827-00036#1--add--end
            
         #小數取位
         CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
         CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
         
         INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
         VALUES(l_seq,l_glbd001,l_glbdl003,l_glbd003,l_amt1,l_amt2)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('insert','','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins aglq830_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF
      END FOREACH 
   END IF
   
   #附註揭露
   IF tm.type_c='Y' THEN
      FOREACH aglq830_cs10 INTO l_glbg005
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('FOREACH aglq830_cs10','','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'FOREACH aglq830_cs10'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
            EXIT FOREACH
         END IF
         LET l_seq=l_seq+1
         #本期數
         EXECUTE aglq830_pr11 USING tm.glfa010,tm.glfa011,tm.glfa012,l_glbg005 INTO l_amt1
         #上期數
         EXECUTE aglq830_pr11 USING tm.glfa013,tm.glfa014,tm.glfa015,l_glbg005 INTO l_amt2
         IF cl_null(l_amt1) THEN LET l_amt1=0 END IF
         IF cl_null(l_amt2) THEN LET l_amt2=0 END IF
         
         CASE tm.glfa008
            WHEN '2'  #千
               LET l_amt1 = l_amt1 / 1000
               LET l_amt2 = l_amt2 / 1000
            WHEN '3'  #萬
               LET l_amt1 = l_amt1 / 10000
               LET l_amt2 = l_amt2 / 10000
         END CASE
         
         #150827-00036#1--add--str--
         #是否進行幣別轉換
         IF tm.chg_curr='Y' AND tm.curr<>g_glaa001 THEN
            LET l_amt1 = l_amt1 * tm.rate
            LET l_amt2 = l_amt2 * tm.rate
         END IF
         #150827-00036#1--add--end
            
         #小數取位
         CALL s_num_round('1',l_amt1,tm.glfa009) RETURNING l_amt1
         CALL s_num_round('1',l_amt2,tm.glfa009) RETURNING l_amt2
         
         INSERT INTO aglq830_tmp(seq,glfb002,glfbl004,nmai004,amt1,amt2)
         VALUES(l_seq,'',l_glbg005,'',l_amt1,l_amt2)
         IF SQLCA.sqlcode THEN
#            CALL cl_errmsg('insert','','',SQLCA.sqlcode,1)
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'ins aglq830_tmp'
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET g_success = FALSE
         END IF
      END FOREACH
   END IF
   
   IF g_success = FALSE THEN
      CALL cl_err_collect_show()
      DELETE FROM aglq830_tmp
   END IF
END FUNCTION

################################################################################
# Descriptions...: 填充单身
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
PRIVATE FUNCTION aglq830_b_fill1()
   DEFINE l_seq           LIKE glfb_t.glfbseq
   DEFINE l_format        STRING
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
   
   CALL g_glfb_d.clear()
   LET g_sql = "SELECT UNIQUE seq,glfb002,glfbl004,nmai004,amt1,amt2",
               "  FROM aglq830_tmp ",
               " ORDER BY seq"
  
   PREPARE aglq830_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR aglq830_pb1
   
   LET g_cnt = l_ac
   LET l_ac = 1   
   ERROR "Searching!" 
   #資產
   FOREACH b_fill_curs1 INTO l_seq,g_glfb_d[l_ac].glfb002,g_glfb_d[l_ac].glfbl004,g_glfb_d[l_ac].nmai004, 
                             g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      LET g_glfb_d[l_ac].sel = "N"     
 
      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
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
   LET g_error_show = 0
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())   
       
   LET g_detail_cnt = g_glfb_d.getLength() 
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   #設置單身金額欄位格式
   LET l_format = "---,---,---,--&"
   LET l_str = ""
   FOR l_i=1 TO tm.glfa009
       LET l_str = l_str,"&"
   END FOR
   IF NOT cl_null(l_str) THEN
      LET l_format = l_format,'.',l_str
   END IF
   CALL cl_set_comp_format("amt1,amt2,amt3,amt4",l_format)
   
   LET l_ac = 1
   CALL aglq830_fetch()
   
   CALL aglq830_filter_show('glfb002','b_glfb002')
   CALL aglq830_filter_show('glfbl004','b_glfbl004')
END FUNCTION

################################################################################
# Descriptions...: 抓取帐套说明
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
PRIVATE FUNCTION aglq830_glfa005_desc(p_glfa005)
   DEFINE p_glfa005             LIKE glfa_t.glfa005
   DEFINE r_desc                LIKE glaal_t.glaal002
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = p_glfa005
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET r_desc = '', g_rtn_fields[1] , ''
   RETURN r_desc
END FUNCTION

 
{</section>}
 
