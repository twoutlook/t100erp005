#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq202.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2015-08-11 16:41:25), PR版次:0007(2016-10-14 14:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000089
#+ Filename...: axcq202
#+ Description: 在製工時費用分攤查詢作業
#+ Creator....: 00768(2014-09-03 15:11:33)
#+ Modifier...: 05947 -SD/PR- 05384
 
{</section>}
 
{<section id="axcq202.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151224-00017#1 2016/01/22 By dorislai 修正小計合計沒有值的問題
#160408-00004#1 2016/04/26 By dorislai 列印改用temp，解決小計重複問題
#160802-00020#7 2016/10/06 By shiun    增加帳套權限管控、法人權限管控
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
PRIVATE TYPE type_g_xcbk_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xcbk004 LIKE xcbk_t.xcbk004, 
   xcbk006 LIKE xcbk_t.xcbk006, 
   sfaasite LIKE sfaa_t.sfaasite, 
   xcbk007 LIKE xcbk_t.xcbk007, 
   xcbk202 LIKE xcbk_t.xcbk202, 
   xcbk100 LIKE xcbk_t.xcbk100, 
   xcbk101 LIKE xcbk_t.xcbk101 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_tm RECORD
                     xcbkcomp   LIKE xcbk_t.xcbkcomp,  #法人組織
                     xcbkcomp_desc LIKE type_t.chr80,
                     xcbkld     LIKE xcbk_t.xcbkld  ,  #帳別編號
                     xcbkld_desc   LIKE type_t.chr80,
                     xcbk002    LIKE xcbk_t.xcbk002 ,  #年度
                     xcbk003    LIKE xcbk_t.xcbk003 ,  #期別
                     xcbk005    LIKE xcbk_t.xcbk005 ,  #費用分類(成本主要素)
                     currency   LIKE type_t.chr1    ,  #本位币顺序
                     currency_desc LIKE type_t.chr80,  #本位币说明
                     xcbk001    LIKE xcbk_t.xcbk001 ,  #成本計算類型
                     xcbk001_desc  LIKE type_t.chr80,
                     xcbk002_1    LIKE xcbk_t.xcbk002 ,  #年度   #150805-00001#2add
                     xcbk003_1    LIKE xcbk_t.xcbk003    #期別   #150805-00001#2add
                     END RECORD
DEFINE tm            type_tm
DEFINE tm_t          type_tm  #160408-00004#1-add
DEFINE g_fetch       LIKE type_t.chr1
DEFINE g_currency    LIKE type_t.chr1 #本位币顺序
DEFINE g_currency_t  LIKE type_t.chr1 #本位币顺序
DEFINE g_currency_filter    LIKE type_t.chr1 #本位币顺序
DEFINE g_currency_filter_t  LIKE type_t.chr1 #本位币顺序

DEFINE g_page_cnt        LIKE type_t.num5   #總页數
DEFINE g_page_idx        LIKE type_t.num5   #当页笔数
#DEFINE g_detail_idx         LIKE type_t.num5   #当行
#DEFINE g_detail_cnt         LIKE type_t.num5   #总行

DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
#2015/3/18 liuym add------str----
TYPE type_g_xcbk_e RECORD
       v          STRING
       END RECORD
DEFINE g_param                     type_g_xcbk_e   
#2015/3/18 liuym add------end----
#add--#160802-00020#7 By shiun--(S)
DEFINE g_wc_cs_ld            STRING
DEFINE g_wc_cs_comp          STRING
#add--#160802-00020#7 By shiun--(E)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xcbk_d
DEFINE g_master_t                   type_g_xcbk_d
DEFINE g_xcbk_d          DYNAMIC ARRAY OF type_g_xcbk_d
DEFINE g_xcbk_d_t        type_g_xcbk_d
 
      
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
 
{<section id="axcq202.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success    LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   CALL axcq202_create_temp() RETURNING l_success
   #add--160802-00020#7 By shiun--(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #add--160802-00020#7 By shiun--(E)
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
   DECLARE axcq202_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq202_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq202_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq202 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq202_init()   
 
      #進入選單 Menu (="N")
      CALL axcq202_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq202
      
   END IF 
   
   CLOSE axcq202_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL axcq202_drop_temp()
   DROP TABLE axcq202_temp_01  #160408-00004#1-add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq202.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axcq202_init()
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
   CALL cl_set_combo_scc('b_xcbk005','8908')
   #CALL cl_set_combo_scc_part('b_xcbk005','8901','2,4,5,6,7,8')
   CALL cl_set_combo_scc('b_currency','8914')
   CALL cl_set_combo_scc('b_xcbk007','8909')
   
   #CALL cl_set_comp_visible("filter",FALSE)
   #end add-point
 
   CALL axcq202_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axcq202.default_search" >}
PRIVATE FUNCTION axcq202_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcbkld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcbk001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcbk002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcbk003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcbk004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcbk005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcbk006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcbk007 = '", g_argv[08], "' AND "
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
 
{<section id="axcq202.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axcq202_ui_dialog()
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
      CALL axcq202_b_fill()
   ELSE
      CALL axcq202_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xcbk_d.clear()
 
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
 
         CALL axcq202_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xcbk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq202_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axcq202_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               DISPLAY g_master_idx TO FORMONLY.idx  #显示当前第几行
               #頁數不對重新刷新
               DISPLAY g_page_idx TO FORMONLY.h_index  #當前頁
               DISPLAY g_page_cnt TO FORMONLY.h_count  #總頁數
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
            CALL axcq202_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #有資料才進行fetch
            #IF g_page_idx <> 0 THEN
            #   CALL axcq202_fetch() # reload data
            #END IF
            CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #160408-00004#1-mod-(S)
#               IF g_xcbk_d.getLength()>0 THEN
#                  LET g_param.v = "axcq202_temp"               
#                  CALL axcq202_x01(' 1=1',g_param.v)
#               END IF
               IF axcq202_creat_temp_xg() THEN
                  CALL axcq202_ins_temp_xg()
                  LET g_param.v = "axcq202_temp_01"
                  IF tm_t.xcbk002<>tm_t.xcbk002_1 AND tm_t.xcbk003<>tm_t.xcbk003_1 THEN
                     CALL axcq202_x01(' 1=1',g_param.v,'N')
                  ELSE
                     CALL axcq202_x01(' 1=1',g_param.v,'Y')
                  END IF
               END IF
               #160408-00004#1-mod-(E)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #160408-00004#1-mod-(S)
#               IF g_xcbk_d.getLength()>0 THEN
#                  LET g_param.v = "axcq202_temp"               
#                  CALL axcq202_x01(' 1=1',g_param.v)
#               END IF
               IF axcq202_creat_temp_xg() THEN
                  CALL axcq202_ins_temp_xg()
                  LET g_param.v = "axcq202_temp_01"
                  IF tm_t.xcbk002<>tm_t.xcbk002_1 AND tm_t.xcbk003<>tm_t.xcbk003_1 THEN
                     CALL axcq202_x01(' 1=1',g_param.v,'N')
                  ELSE
                     CALL axcq202_x01(' 1=1',g_param.v,'Y')
                  END IF
               END IF
               #160408-00004#1-mod-(E)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axcq202_query()
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
            CALL axcq202_filter()
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
            CALL axcq202_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xcbk_d)
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
            CALL axcq202_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq202_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq202_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq202_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION first
            LET g_fetch = 'F'
            CALL axcq202_fetch()

         ON ACTION previous
            LET g_fetch = 'P'
            CALL axcq202_fetch()

         ON ACTION jump
            LET g_fetch = '/'
            CALL axcq202_fetch()

         ON ACTION next
            LET g_fetch = 'N'
            CALL axcq202_fetch()

         ON ACTION last
            LET g_fetch = 'L'
            CALL axcq202_fetch()

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
 
{<section id="axcq202.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axcq202_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL axcq202_delete_temp()
   CALL axcq202_query2()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xcbk_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON xcbk004
           FROM s_detail1[1].b_xcbk004
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xcbk004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xcbk004
            #add-point:BEFORE FIELD b_xcbk004 name="construct.b.page1.b_xcbk004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xcbk004
            
            #add-point:AFTER FIELD b_xcbk004 name="construct.a.page1.b_xcbk004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xcbk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcbk004
            #add-point:ON ACTION controlp INFIELD b_xcbk004 name="construct.c.page1.b_xcbk004"
            
            #END add-point
 
 
         #----<<b_xcbk006>>----
         #----<<b_sfaasite>>----
         #----<<b_xcbk007>>----
         #----<<b_xcbk202>>----
         #----<<b_xcbk100>>----
         #----<<b_xcbk101>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
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
   CALL axcq202_b_fill()
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
 
{<section id="axcq202.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq202_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   #此b_fill()相当与
   #1.根据条件抓出资料
   CALL axcq202_insert_temp()
   
   #add--160802-00020#7 by shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_wc = g_wc ," AND xcbkld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc = g_wc ," AND xcbkcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 by shiun--(E)
   
   #2.显示资料
   #抓出单头资料
   LET g_sql= "SELECT UNIQUE xcbkcomp,ooefl003,xcbkld,glaal002, '",tm.xcbk002,"' xcbk002,'",tm.xcbk003,"' xcbk003,",
              "              xcbk005,currency,'', ",
              "              xcbk001,xcatl003,'",tm.xcbk002_1,"','",tm.xcbk003_1,"'",
              "  FROM axcq202_temp LEFT JOIN ooefl_t ON ooeflent='"||g_enterprise||"' AND ooefl001=xcbkcomp AND ooefl002='"||g_dlang||"' ",
              "                    LEFT JOIN xcatl_t ON xcatlent='"||g_enterprise||"' AND xcatl001=xcbk001 AND xcatl002='"||g_dlang||"' ",
              "                    LEFT JOIN glaal_t ON glaalent='"||g_enterprise||"' AND glaalld=xcbkld AND glaal001='"||g_dlang||"' ",
              " AND ",g_wc,
              " ORDER BY xcbkcomp,xcbkld,xcbk002,xcbk003,xcbk005,currency,xcbk001 "
   PREPARE axcq202_prepare FROM g_sql      #預備一下
   DECLARE axcq202_b_curs                  #宣告成可捲動的
       SCROLL CURSOR WITH HOLD FOR axcq202_prepare
       
   #抓出資料筆數
   LET g_sql = "SELECT COUNT(DISTINCT xcbkcomp||xcbkld||xcbk005||currency||xcbk001) ",
               "  FROM axcq202_temp WHERE 1=1 AND ",g_wc
   PREPARE axcq202_precount FROM g_sql
   DECLARE axcq202_count CURSOR FOR axcq202_precount
   
   OPEN axcq202_b_curs         #抓出单头唯一性资料
   IF SQLCA.sqlcode THEN                    #有問題
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "open axcq202_b_curs" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      INITIALIZE tm.* TO NULL
   ELSE
      #显示总页数
      OPEN axcq202_count
      FETCH axcq202_count INTO g_page_cnt
      DISPLAY g_page_cnt TO FORMONLY.h_count  #总页数
      
      LET g_fetch = 'F'
      CALL axcq202_fetch()  #显示第一笔
      
      #未获取资料
      IF g_page_cnt = 0 THEN
         LET g_page_idx = ''
         DISPLAY g_page_idx TO FORMONLY.h_index  #当页
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx  #显示当前第几行
   END IF

   RETURN
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xcbk004,xcbk006,'',xcbk007,xcbk202,xcbk100,xcbk101  ,DENSE_RANK() OVER( ORDER BY xcbk_t.xcbkld, 
       xcbk_t.xcbk001,xcbk_t.xcbk002,xcbk_t.xcbk003,xcbk_t.xcbk004,xcbk_t.xcbk005,xcbk_t.xcbk006,xcbk_t.xcbk007) AS RANK FROM xcbk_t", 
 
 
 
                     "",
                     " WHERE xcbkent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcbk_t"),
                     " ORDER BY xcbk_t.xcbkld,xcbk_t.xcbk001,xcbk_t.xcbk002,xcbk_t.xcbk003,xcbk_t.xcbk004,xcbk_t.xcbk005,xcbk_t.xcbk006,xcbk_t.xcbk007"
 
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
 
   LET g_sql = "SELECT xcbk004,xcbk006,'',xcbk007,xcbk202,xcbk100,xcbk101",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq202_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq202_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xcbk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xcbk_d[l_ac].xcbk004,g_xcbk_d[l_ac].xcbk006,g_xcbk_d[l_ac].sfaasite,g_xcbk_d[l_ac].xcbk007, 
       g_xcbk_d[l_ac].xcbk202,g_xcbk_d[l_ac].xcbk100,g_xcbk_d[l_ac].xcbk101
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xcbk_d[l_ac].statepic = cl_get_actipic(g_xcbk_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL axcq202_detail_show("'1'")      
 
      CALL axcq202_xcbk_t_mask()
 
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
   
 
   
   CALL g_xcbk_d.deleteElement(g_xcbk_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_xcbk_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axcq202_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq202_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq202_detail_action_trans()
 
   IF g_xcbk_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axcq202_fetch()
   END IF
   
      CALL axcq202_filter_show('xcbk004','b_xcbk004')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq202_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   DEFINE ls_msg     STRING
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   #受pattern限制，使用g_fetch变量，非空为版型所有，不需要调用的
   IF cl_null(g_fetch) THEN
      RETURN
   END IF
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   CASE g_fetch
      WHEN 'F' FETCH FIRST    axcq202_b_curs INTO tm.*
               LET g_page_idx = 1
      WHEN 'L' FETCH LAST     axcq202_b_curs INTO tm.*
               LET g_page_idx = g_page_cnt
      WHEN 'P' FETCH PREVIOUS axcq202_b_curs INTO tm.*
               IF g_page_idx > 1 THEN
                  LET g_page_idx = g_page_idx - 1
               END IF
      WHEN 'N' FETCH NEXT     axcq202_b_curs INTO tm.*
               IF g_page_idx < g_page_cnt THEN
                  LET g_page_idx =  g_page_idx + 1
               END IF
      WHEN '/'
          IF (NOT g_no_ask) THEN
             CALL cl_set_act_visible("accept,cancel", TRUE)
             CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
             LET INT_FLAG = 0
          
             PROMPT ls_msg CLIPPED,': ' FOR g_jump
                #交談指令共用ACTION
                &include "common_action.4gl"
             END PROMPT
          
             CALL cl_set_act_visible("accept,cancel", FALSE)
             IF INT_FLAG THEN
                LET INT_FLAG = 0
                EXIT CASE
             END IF
          
          END IF
          FETCH ABSOLUTE g_jump axcq202_b_curs INTO tm.*
          LET g_no_ask = FALSE
          IF g_jump > 0 AND g_jump <= g_page_cnt THEN
             LET g_page_idx = g_jump
          END IF
          
   END CASE
   DISPLAY g_page_idx TO FORMONLY.h_index  #当页
   LET tm_t.* = tm.* #160408-00004#1-add

   CALL axcq202_show()
   
   IF g_detail_cnt < g_detail_idx THEN
      LET g_detail_idx = g_detail_cnt
   END IF
   DISPLAY g_detail_idx TO FORMONLY.idx  #显示当前第几行
   
   CALL cl_navigator_setting(g_page_idx, g_page_cnt)  #設定ToolBar上瀏覽上下筆資料的按鈕狀態
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   LET g_fetch = ''
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="axcq202.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq202_detail_show(ps_page)
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
 
{<section id="axcq202.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axcq202_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   CALL axcq202_delete_temp()
   CALL axcq202_filter2()
   RETURN
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
      CONSTRUCT g_wc_filter ON xcbk004
                          FROM s_detail1[1].b_xcbk004
 
         BEFORE CONSTRUCT
                     DISPLAY axcq202_filter_parser('xcbk004') TO s_detail1[1].b_xcbk004
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xcbk004>>----
         #Ctrlp:construct.c.filter.page1.b_xcbk004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcbk004
            #add-point:ON ACTION controlp INFIELD b_xcbk004 name="construct.c.filter.page1.b_xcbk004"
            
            #END add-point
 
 
         #----<<b_xcbk006>>----
         #----<<b_sfaasite>>----
         #----<<b_xcbk007>>----
         #----<<b_xcbk202>>----
         #----<<b_xcbk100>>----
         #----<<b_xcbk101>>----
   
 
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
   
      CALL axcq202_filter_show('xcbk004','b_xcbk004')
 
    
   CALL axcq202_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axcq202_filter_parser(ps_field)
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
 
{<section id="axcq202.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq202_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq202_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.insert" >}
#+ insert
PRIVATE FUNCTION axcq202_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axcq202.modify" >}
#+ modify
PRIVATE FUNCTION axcq202_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axcq202_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.delete" >}
#+ delete
PRIVATE FUNCTION axcq202_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axcq202.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq202_detail_action_trans()
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
 
{<section id="axcq202.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq202_detail_index_setting()
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
            IF g_xcbk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xcbk_d.getLength() AND g_xcbk_d.getLength() > 0
            LET g_detail_idx = g_xcbk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xcbk_d.getLength() THEN
               LET g_detail_idx = g_xcbk_d.getLength()
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
 
{<section id="axcq202.mask_functions" >}
 &include "erp/axc/axcq202_mask.4gl"
 
{</section>}
 
{<section id="axcq202.other_function" readonly="Y" >}

#建立临时表
PRIVATE FUNCTION axcq202_create_temp()
   DEFINE r_success         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   CALL axcq202_drop_temp()
   CREATE TEMP TABLE axcq202_temp(
      xcbkcomp    LIKE xcbk_t.xcbkcomp,   #法人組織
      xcbkld      LIKE xcbk_t.xcbkld  ,   #帳別編號
      xcbk002     LIKE xcbk_t.xcbk002 ,   #年度
      xcbk003     LIKE xcbk_t.xcbk003 ,   #期別
      xcbk005     LIKE xcbk_t.xcbk005 ,   #費用分類(成本主要素)
      currency    LIKE type_t.chr1    ,   #本位币顺序
      xcbk001     LIKE xcbk_t.xcbk001 ,   #成本計算類型
      xcbk004     LIKE xcbk_t.xcbk004 ,   #成本中心
      xcbk006     LIKE xcbk_t.xcbk006 ,   #工單編號
      xcbk007     LIKE xcbk_t.xcbk007 ,   #分攤方式
      xcbkamt     LIKE xcbk_t.xcbk202 ,   #分攤金額
      xcbk100     LIKE xcbk_t.xcbk100 ,   #工單分攤數
      xcbkcost    LIKE xcbk_t.xcbk101     #單位成本
      )
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axcq202_temp'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

#删除临时表资料
PRIVATE FUNCTION axcq202_delete_temp()
   WHENEVER ERROR CONTINUE

   DELETE FROM axcq202_temp
END FUNCTION

#去除临时表
PRIVATE FUNCTION axcq202_drop_temp()
   WHENEVER ERROR CONTINUE
   
   DROP TABLE axcq202_temp
END FUNCTION

#查询，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq202_query2()
   DEFINE ls_wc       LIKE type_t.chr500  #旧值备份
   DEFINE g_currency_t  LIKE type_t.chr1  #旧值备份
   DEFINE l_flag     LIKE type_t.num5
   
   CALL axcq202_delete_temp()
   
   #wc備份
   LET ls_wc = g_wc
   LET g_currency_t = g_currency
   LET g_wc_filter_t = g_wc_filter
   LET g_currency_filter_t = g_currency_filter

   LET INT_FLAG = 0
   CLEAR FORM
   LET g_wc       = ''
   LET g_currency = ''
   INITIALIZE tm.* TO NULL
   CALL g_xcbk_d.clear()
   DISPLAY ' ' TO FORMONLY.idx
   DISPLAY ' ' TO FORMONLY.cnt
   DISPLAY ' ' TO FORMONLY.h_index
   DISPLAY ' ' TO FORMONLY.h_count

   LET g_wc_filter = " 1=1"
   LET g_currency_filter = ''
   
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   # CALL axcq202_default()  #查询前预设   #150805-00001#2mark
   #LET g_currency = tm.currency

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      #150805-00001#2add
      INPUT tm.xcbk002,tm.xcbk003,tm.xcbk002_1,tm.xcbk003_1 FROM b_xcbk002,b_xcbk003,b_xcbk002_1,b_xcbk003_1
         AFTER FIELD b_xcbk002
            IF NOT cl_null(tm.xcbk002) AND NOT cl_null(tm.xcbk002_1) THEN
               IF tm.xcbk002 > tm.xcbk002_1 THEN
                  INITIALIZE g_errparam TO NULL
		            LET g_errparam.code = 'acr-00064'
		            LET g_errparam.extend = ''
		            LET g_errparam.popup = TRUE
		            CALL cl_err()
		            NEXT FIELD b_xcbk002
		         END IF
		      END IF
		   AFTER FIELD b_xcbk003
            IF NOT cl_null(tm.xcbk003) AND NOT cl_null(tm.xcbk003_1) THEN
               IF tm.xcbk002 = tm.xcbk002_1 AND tm.xcbk003 > tm.xcbk003_1 THEN
                  INITIALIZE g_errparam TO NULL
		            LET g_errparam.code = 'acr-00067'
		            LET g_errparam.extend = ''
		            LET g_errparam.popup = TRUE
		            CALL cl_err()
		            NEXT FIELD b_xcbk003
		         END IF
		      END IF
         AFTER FIELD b_xcbk002_1
            IF NOT cl_null(tm.xcbk002) AND NOT cl_null(tm.xcbk002_1) THEN
               IF tm.xcbk002 > tm.xcbk002_1 THEN
                  INITIALIZE g_errparam TO NULL
		            LET g_errparam.code = 'acr-00064'
		            LET g_errparam.extend = ''
		            LET g_errparam.popup = TRUE
		            CALL cl_err()
		            NEXT FIELD b_xcbk002_1
		         END IF
		      END IF
         AFTER FIELD b_xcbk003_1
            IF NOT cl_null(tm.xcbk003) AND NOT cl_null(tm.xcbk003_1) THEN
               IF tm.xcbk002 = tm.xcbk002_1 AND tm.xcbk003 > tm.xcbk003_1 THEN
                  INITIALIZE g_errparam TO NULL
		            LET g_errparam.code = 'acr-00067'
		            LET g_errparam.extend = ''
		            LET g_errparam.popup = TRUE
		            CALL cl_err()
		            NEXT FIELD b_xcbk003_1
		         END IF
		      END IF
      END INPUT
      #150805-00001#2add
      #單身根據table分拆construct
      CONSTRUCT g_wc ON xcbkcomp,xcbkld  ,
                        xcbk005 ,
                        #currency,
                        xcbk001
           FROM b_xcbkcomp,b_xcbkld  ,
                b_xcbk005 ,
                #b_currency,
                b_xcbk001
                      
         BEFORE CONSTRUCT 
           #150805-00001#2add
           CALL axcq202_default()
           LET g_currency = tm.currency
           #150805-00001#2add  
         
            DISPLAY tm.xcbkcomp,tm.xcbkld,tm.xcbk002,tm.xcbk003,tm.xcbk001,tm.xcbk002_1,tm.xcbk003_1
                 TO b_xcbkcomp,b_xcbkld,b_xcbk002,b_xcbk003,b_xcbk001,b_xcbk002_1,b_xcbk003_1 
            DISPLAY g_currency TO b_currency
            DISPLAY tm.xcbk005 TO b_xcbk005
            DISPLAY tm.xcbkcomp_desc TO b_xcbkcomp_desc   #法人組織 
            DISPLAY tm.xcbkld_desc TO b_xcbkld_desc     #帳別編號
            DISPLAY tm.xcbk001_desc  TO b_xcbk001_desc    #成本計算類型
            DISPLAY tm.currency_desc TO b_currency_desc
            
         AFTER FIELD b_xcbkcomp
            LET tm.xcbkcomp = GET_FLDBUF(b_xcbkcomp)

         AFTER FIELD b_xcbkld
            LET tm.xcbkld = GET_FLDBUF(b_xcbkld)

         AFTER FIELD b_xcbk002
            LET tm.xcbk002 = GET_FLDBUF(b_xcbk002)

         AFTER FIELD b_xcbk003
            LET tm.xcbk003 = GET_FLDBUF(b_xcbk003)

         AFTER FIELD b_xcbk005
            LET tm.xcbk005 = GET_FLDBUF(b_xcbk005)

         AFTER FIELD b_xcbk001
            LET tm.xcbk001 = GET_FLDBUF(b_xcbk001)

         ON ACTION controlp INFIELD b_xcbkcomp  #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooefstus = 'Y'"
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbkcomp  #顯示到畫面上
            NEXT FIELD b_xcbkcomp                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xcbkld    #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbkld  #顯示到畫面上
            NEXT FIELD b_xcbkld                     #返回原欄位

         ON ACTION controlp INFIELD b_xcbk001   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbk001  #顯示到畫面上
            NEXT FIELD b_xcbk001                     #返回原欄位

      END CONSTRUCT

      INPUT g_currency FROM b_currency
         ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
      
      END INPUT

      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
 
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         LET tm.xcbkcomp = ''
         LET tm.xcbkld   = ''
         LET tm.xcbk002  = ''
         LET tm.xcbk003  = ''
         LET tm.xcbk001  = ''
         LET tm.xcbk005  = ''
         DISPLAY tm.xcbkcomp,tm.xcbkld,tm.xcbk002,tm.xcbk003,tm.xcbk001,tm.xcbk005
              TO b_xcbkcomp,b_xcbkld,b_xcbk002,b_xcbk003,b_xcbk001,b_xcbk005
         LET tm.xcbkcomp_desc = ''
         LET tm.xcbkld_desc   = ''
         LET tm.xcbk001_desc  = ''
         DISPLAY tm.xcbkcomp_desc TO b_xcbkcomp_desc   #法人組織 
         DISPLAY tm.xcbkld_desc TO b_xcbkld_desc     #帳別編號
         DISPLAY tm.xcbk001_desc  TO b_xcbk001_desc    #成本計算類型
         LET g_currency = ''
         LET tm.currency_desc = ''
         DISPLAY g_currency TO b_currency
         DISPLAY tm.currency_desc TO b_currency_desc
         
 
   END DIALOG
 
   
   LET l_flag = 1    #fengmy150423   cancel no fetch
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      LET l_flag = 0    #fengmy150423 
      #還原
      LET g_wc = ls_wc
      LET g_currency = g_currency_t
      LET g_wc_filter = g_wc_filter_t
      LET g_currency_filter = g_currency_filter_t
   END IF

   
   LET g_error_show = 1
   #INITIALIZE tm.* TO NULL
   IF l_flag THEN    #fengmy150423 
   CALL axcq202_b_fill()
   END IF            #fengmy150423 
   
   INITIALIZE tm.* TO NULL
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
END FUNCTION

#筛选，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq202_filter2()
   
   CALL axcq202_delete_temp()
   
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   #wc備份
   LET g_wc_filter_t = g_wc_filter
   LET g_currency_filter_t  = g_currency_filter
   LET g_wc_t = g_wc
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   LET g_wc_filter       = ''
   LET g_currency_filter = ''
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xcbkcomp,xcbkld  ,
                               xcbk002 ,xcbk003 ,xcbk005 ,
                               #currency,
                               xcbk001 
           FROM b_xcbkcomp,b_xcbkld  ,
                b_xcbk002 ,b_xcbk003 ,b_xcbk005 ,
                #b_currency,
                b_xcbk001
                      
         BEFORE CONSTRUCT

         ON ACTION controlp INFIELD b_xcbkcomp  #法人组织
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " ooefstus = 'Y'"
            #add--160802-00020#7 By shiun--(S)
      	   #增加法人過濾條件
            IF NOT cl_null(g_wc_cs_comp) THEN
               LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_ooef001_2()                      #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbkcomp  #顯示到畫面上
            NEXT FIELD b_xcbkcomp                     #返回原欄位
            
         ON ACTION controlp INFIELD b_xcbkld    #账别编号
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            #add--160802-00020#7 By shiun--(S)
            #增加帳套權限控制
            IF NOT cl_null(g_wc_cs_ld) THEN
               LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
            END IF
            #add--160802-00020#7 By shiun--(S)
            CALL q_authorised_ld()                #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbkld  #顯示到畫面上
            NEXT FIELD b_xcbkld                     #返回原欄位

         ON ACTION controlp INFIELD b_xcbk001   #成本计算类型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_xcat001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_xcbk001  #顯示到畫面上
            NEXT FIELD b_xcbk001                     #返回原欄位

      END CONSTRUCT

      INPUT g_currency_filter FROM b_currency
         ATTRIBUTE(WITHOUT DEFAULTS)
      
         BEFORE INPUT
         
         ON CHANGE b_currency
            IF NOT cl_null(g_currency) AND g_currency_filter != g_currency THEN
               #已指定本位币，无需再筛选
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "" 
               LET g_errparam.code   = "axc-00124" 
               LET g_errparam.popup  = FALSE 
               CALL cl_err()
               LET g_currency_filter = g_currency
            END IF
      
      END INPUT
 
      BEFORE DIALOG
         #已指定，再筛选也无多余的被筛选了
         IF NOT cl_null(g_currency) THEN
            LET g_currency_filter = g_currency
            DISPLAY g_currency_filter TO b_currency
         END IF
 
 
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
   ELSE
      LET g_wc_filter = g_wc_filter_t
      LET g_currency_filter_t  = g_currency_filter
      LET g_wc = g_wc_t
   END IF
   
   CALL axcq202_filter_show('xcbkcomp','b_xcbkcomp')
   CALL axcq202_filter_show('xcbkld','b_xcbkld')
   CALL axcq202_filter_show('xcbk002','b_xcbk002')
   CALL axcq202_filter_show('xcbk003','b_xcbk003')
   CALL axcq202_filter_show('xcbk005','b_xcbk005')
   CALL axcq202_filter_show('currency','b_currency')
   CALL axcq202_filter_show('xcbk001','b_xcbk001')

   INITIALIZE tm.* TO NULL
   CALL axcq202_b_fill()
   
END FUNCTION

#根据查询条件产生临时表
PRIVATE FUNCTION axcq202_insert_temp()
   DEFINE l_temp  RECORD
                  xcbkcomp    LIKE xcbk_t.xcbkcomp,   #法人組織
                  xcbkld      LIKE xcbk_t.xcbkld  ,   #帳別編號
                  xcbk002     LIKE xcbk_t.xcbk002 ,   #年度
                  xcbk003     LIKE xcbk_t.xcbk003 ,   #期別
                  xcbk005     LIKE xcbk_t.xcbk005 ,   #費用分類(成本主要素)
                  currency    LIKE type_t.chr1    ,   #本位币顺序
                  xcbk001     LIKE xcbk_t.xcbk001 ,   #成本計算類型
                  xcbk004     LIKE xcbk_t.xcbk004 ,   #成本中心
                  xcbk006     LIKE xcbk_t.xcbk006 ,   #工單編號
                  xcbk007     LIKE xcbk_t.xcbk007 ,   #分攤方式
                  xcbkamt     LIKE xcbk_t.xcbk202 ,   #分攤金額
                  xcbk100     LIKE xcbk_t.xcbk100 ,   #工單分攤數
                  xcbkcost    LIKE xcbk_t.xcbk101     #單位成本
                  END RECORD
   DEFINE l_sql   STRING  #查询出来的资料
   DEFINE ls_wc   STRING
   DEFINE ls_currency  LIKE type_t.chr1
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_num1          LIKE type_t.num5
   DEFINE l_num2          LIKE type_t.num5
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   LET g_wc = g_wc," AND (xcbk002*12+xcbk003 BETWEEN ",tm.xcbk002*12+tm.xcbk003," AND ",tm.xcbk002_1*12+tm.xcbk003_1,")"   #150805-00001#2add

   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
   
   #本位币顺序的原始条件和筛选条件有没有交集
   IF NOT cl_null(g_currency_filter) THEN
      IF g_currency = g_currency_filter THEN
         LET ls_currency = g_currency
      ELSE
         IF cl_null(g_currency) THEN
            LET ls_currency = g_currency_filter
         ELSE
            LET ls_currency = '0'  #没有交集
         END IF
      END IF
   ELSE
      LET ls_currency = g_currency
   END IF

   #先查询出资料
   IF cl_null(ls_currency) THEN
      #本位币一
      LET l_sql = "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'1'      ,xcbk001 , ",
                  "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk202 ,xcbk100 ,xcbk101 ",
                  "  FROM xcbk_t",
                  " WHERE xcbkent= ",g_enterprise,
                  "   AND (xcbk202 IS NOT NULL OR xcbk101 IS NOT NULL) ",#单位成本及金额没值，整笔数据都不显示
                  "   AND ",ls_wc
      #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
      LET l_sql = l_sql CLIPPED," UNION ",
                  "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'2'      ,xcbk001 , ",
                  "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk212 ,xcbk100 ,xcbk111 ",
                  "  FROM xcbk_t",
                  " WHERE xcbkent= ",g_enterprise,
                  "   AND (xcbk212 IS NOT NULL OR xcbk111 IS NOT NULL) ",#单位成本及金额没值，整笔数据都不显示
                  "   AND ",ls_wc
      #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
      LET l_sql = l_sql CLIPPED," UNION ",
                  "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'3'      ,xcbk001 , ",
                  "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk222 ,xcbk100 ,xcbk121 ",
                  "  FROM xcbk_t",
                  " WHERE xcbkent= ",g_enterprise,
                  "   AND (xcbk222 IS NOT NULL OR xcbk121 IS NOT NULL) ",#单位成本及金额没值，整笔数据都不显示
                  "   AND ",ls_wc
      #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
   ELSE
      CASE ls_currency
         WHEN '1'
              #本位币一
              LET l_sql = "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'1'      ,xcbk001 , ",
                          "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk202 ,xcbk100 ,xcbk101 ",
                          "  FROM xcbk_t",
                          " WHERE xcbkent= ",g_enterprise,
                          "   AND (xcbk202 IS NOT NULL OR xcbk101 IS NOT NULL) ",#单位成本及金额没值，整笔数据都不显示
                          "   AND ",ls_wc
              #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
         WHEN '2'
              #本位币二
              LET l_sql = "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'2'      ,xcbk001 , ",
                          "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk212 ,xcbk100 ,xcbk111 ",
                          "  FROM xcbk_t",
                          " WHERE xcbkent= ",g_enterprise,
                          "   AND (xcbk212 IS NOT NULL OR xcbk111 IS NOT NULL) ", #单位成本及金额没值，整笔数据都不显示
                          "   AND ",ls_wc
              #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
         WHEN '3'
              #本位币三
              LET l_sql = "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,'3'      ,xcbk001 , ",
                          "       xcbk004 ,xcbk006 ,xcbk007 ,xcbk222 ,xcbk100 ,xcbk121 ",
                          "  FROM xcbk_t",
                          " WHERE xcbkent= ",g_enterprise,
                          "   AND (xcbk222 IS NOT NULL OR xcbk121 IS NOT NULL) ",#单位成本及金额没值，整笔数据都不显示
                          "   AND ",ls_wc
              #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
         WHEN '0'
              #原始条件和筛选条件没有交集
              LET l_sql = "SELECT xcbkcomp,xcbkld  ,xcbk002 ,xcbk003 ,xcbk005 ,' '      ,xcbk001 , ",
                          "       xcbk004 ,xcbk006 ,xcbk007 ,''      ,xcbk100 ,''        ",
                          "  FROM xcbk_t",
                          " WHERE xcbkent= ",g_enterprise,
                          "   AND xcbkent= 'aurmv12jkf' ",#单位成本及金额没值，整笔数据都不显示
                          "   AND ",ls_wc
              #LET l_sql = l_sql, cl_sql_add_filter("xcbk_t")
      END CASE
   END IF
   
   #add--160802-00020#7 by shiun--(S)
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET l_sql = l_sql ," AND xcbkld IN ",g_wc_cs_ld
   END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET l_sql = l_sql ," AND xcbkcomp IN ",g_wc_cs_comp
   END IF
   #add--160802-00020#7 by shiun--(E)
   
   #再将查询出资料插入临时表中
   LET g_sql = " INSERT INTO axcq202_temp ",l_sql
   #LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

   PREPARE axcq202_insert_temp_p FROM g_sql
   EXECUTE axcq202_insert_temp_p
   IF SQLCA.sqlcode AND SQLCA.sqlcode!=100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "insert temp table" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
END FUNCTION

#显示单头单身
PRIVATE FUNCTION axcq202_show()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #显示单头
   DISPLAY tm.xcbkcomp TO b_xcbkcomp   #法人組織
   DISPLAY tm.xcbkcomp_desc TO b_xcbkcomp_desc   #法人組織
   DISPLAY tm.xcbkld   TO b_xcbkld     #帳別編號
   DISPLAY tm.xcbkld_desc   TO b_xcbkld_desc     #帳別編號
   DISPLAY tm.xcbk002  TO b_xcbk002    #年度
   DISPLAY tm.xcbk003  TO b_xcbk003    #期別
   DISPLAY tm.xcbk005  TO b_xcbk005    #費用分類(成本主要素)
   DISPLAY tm.currency TO b_currency   #本位币顺序
   DISPLAY tm.xcbk001  TO b_xcbk001    #成本計算類型
   DISPLAY tm.xcbk001_desc  TO b_xcbk001_desc    #成本計算類型
   
   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcbkld
   CASE tm.currency
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.currency_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.currency_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.currency_desc
   END CASE
   DISPLAY tm.currency_desc TO b_currency_desc
   
   #显示单身
   CALL axcq202_b_fill2()
   
   #設定p_per內有特殊格式設定的欄位
   CALL cl_show_fld_cont() 
END FUNCTION

#单身显示，pattern不支持功能需求，用此代替pattern
PRIVATE FUNCTION axcq202_b_fill2()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE l_xcbk202_sum    LIKE xcbk_t.xcbk202  #小计
   DEFINE l_xcbk202_total  LIKE xcbk_t.xcbk202  #总计
   DEFINE l_xcbk100_sum    LIKE xcbk_t.xcbk100  #小计
   DEFINE l_xcbk100_total  LIKE xcbk_t.xcbk100  #总计
   
   CALL g_xcbk_d.clear()
   LET g_sql = "SELECT UNIQUE xcbk004,xcbk006,sfaasite,xcbk007,xcbkamt,xcbk100,xcbkcost,xcbk002,xcbk003 ",
               "  FROM axcq202_temp LEFT JOIN sfaa_t ON sfaaent='"||g_enterprise||"' AND sfaadocno = xcbk006 ",
               " WHERE xcbkcomp = '",tm.xcbkcomp,"' ",   #法人組織
               "   AND xcbkld   = '",tm.xcbkld  ,"' ",   #帳別編號
               "   AND (xcbk002*12+xcbk003 BETWEEN ",tm.xcbk002*12+tm.xcbk003," AND ",tm.xcbk002_1*12+tm.xcbk003_1,")",   #150805-00001#2add
               #"   AND xcbk002  =  ",tm.xcbk002 ,        #年度
               #"   AND xcbk003  =  ",tm.xcbk003 ,        #期別
               "   AND xcbk005  = '",tm.xcbk005 ,"' ",   #費用分類(成本主要素)
               "   AND currency = '",tm.currency,"' ",   #本位币顺序
               "   AND xcbk001  = '",tm.xcbk001 ,"' ",   #成本計算類型
               " AND ",g_wc
   #LET g_sql = g_sql, cl_sql_add_filter("axcq202_temp")
   LET g_sql = g_sql," ORDER BY xcbk002,xcbk003,xcbk004,xcbk006,sfaasite,xcbk007,xcbkamt,xcbk100,xcbkcost"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE b_fill2_p FROM g_sql
   DECLARE b_fill2_c CURSOR FOR b_fill2_p
   LET l_ac = 1 
   LET l_xcbk202_total = 0
   LET l_xcbk202_sum   = 0   
   LET l_xcbk100_total = 0
   LET l_xcbk100_sum   = 0

   ERROR "Searching!" 
   FOREACH b_fill2_c INTO g_xcbk_d[l_ac].xcbk004,g_xcbk_d[l_ac].xcbk006,g_xcbk_d[l_ac].sfaasite,g_xcbk_d[l_ac].xcbk007, 
                          g_xcbk_d[l_ac].xcbk202,g_xcbk_d[l_ac].xcbk100,g_xcbk_d[l_ac].xcbk101
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      #150805-00001#2add
      IF tm.xcbk002<>tm.xcbk002_1 AND tm.xcbk003<>tm.xcbk003_1 THEN
         CALL cl_set_comp_visible('b_xcbk101',FALSE)      
      ELSE
         CALL cl_set_comp_visible('b_xcbk101',TRUE)      
      END IF
      #150805-00001#2add   
      #151224-00017#1-add----(S) 避免造成null，無法相加
      IF cl_null(g_xcbk_d[l_ac].xcbk202) THEN
         LET g_xcbk_d[l_ac].xcbk202 = 0
      END IF
      IF cl_null(g_xcbk_d[l_ac].xcbk100) THEN
         LET g_xcbk_d[l_ac].xcbk100 = 0
      END IF
      #151224-00017#1-add----(E)
      #总计
      LET l_xcbk202_total = l_xcbk202_total + g_xcbk_d[l_ac].xcbk202
      LET l_xcbk100_total = l_xcbk100_total + g_xcbk_d[l_ac].xcbk100
      #依成本中心小计
      LET l_xcbk202_sum = l_xcbk202_sum + g_xcbk_d[l_ac].xcbk202
      LET l_xcbk100_sum = l_xcbk100_sum + g_xcbk_d[l_ac].xcbk100
      IF l_ac > 1 THEN
         IF g_xcbk_d[l_ac].xcbk004 != g_xcbk_d[l_ac-1].xcbk004 THEN
            #把当前行下移，并在当前行显示小计
            LET g_xcbk_d[l_ac+1].* = g_xcbk_d[l_ac].*
            INITIALIZE  g_xcbk_d[l_ac].* TO NULL
            #LET g_xcbk_d[l_ac].xcbk004 = cl_getmsg("axc-00205",g_lang)  #小计                   #151029-00010#2 20151029 s983961  mark(axcq小計整批顯示優化)
            LET g_xcbk_d[l_ac].xcbk006 = g_xcbk_d[l_ac-1].xcbk004,cl_getmsg("axc-00205",g_lang)  #151029-00010#2 20151029 s983961  add(axcq小計整批顯示優化)
            LET g_xcbk_d[l_ac].xcbk202 = l_xcbk202_sum - g_xcbk_d[l_ac+1].xcbk202
            LET g_xcbk_d[l_ac].xcbk100 = l_xcbk100_sum - g_xcbk_d[l_ac+1].xcbk100
            LET l_ac = l_ac + 1
            LET l_xcbk202_sum = g_xcbk_d[l_ac].xcbk202
            LET l_xcbk100_sum = g_xcbk_d[l_ac].xcbk100
         END IF
      END IF

      LET l_ac = l_ac + 1
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
   END FOREACH
   IF l_ac > 1 THEN  #单身有资料时
      #最后一组小计
      #LET g_xcbk_d[l_ac].xcbk004 = cl_getmsg("axc-00205",g_lang)  #小计                    #151029-00010#2 20151029 s983961  mark(axcq小計整批顯示優化)
      LET g_xcbk_d[l_ac].xcbk006 = g_xcbk_d[l_ac-1].xcbk004,cl_getmsg("axc-00205",g_lang)  #151029-00010#2 20151029 s983961  add(axcq小計整批顯示優化)
      LET g_xcbk_d[l_ac].xcbk202 = l_xcbk202_sum
      LET g_xcbk_d[l_ac].xcbk100 = l_xcbk100_sum
      LET l_ac = l_ac + 1
      #合计
      LET g_xcbk_d[l_ac].xcbk004 = cl_getmsg("axc-00204",g_lang)  #合计:
      LET g_xcbk_d[l_ac].xcbk202 = l_xcbk202_total
      LET g_xcbk_d[l_ac].xcbk100 = l_xcbk100_total
      LET l_ac = l_ac + 1
   END IF

   LET g_error_show = 0
   #CALL g_xcbk_d.deleteElement(g_xcbk_d.getLength()) 最后没走foreach，没有空行了   
   LET g_detail_cnt = l_ac - 1 
   DISPLAY g_detail_cnt TO FORMONLY.cnt
   
   CLOSE b_fill2_c
   FREE b_fill2_p
   
   LET l_ac = 1


   CALL axcq202_filter_show('xcbkcomp','b_xcbkcomp')
   CALL axcq202_filter_show('xcbkld','b_xcbkld')
   CALL axcq202_filter_show('xcbk002','b_xcbk002')
   CALL axcq202_filter_show('xcbk003','b_xcbk003')
   CALL axcq202_filter_show('xcbk005','b_xcbk005')
   CALL axcq202_filter_show('currency','b_currency')
   CALL axcq202_filter_show('xcbk001','b_xcbk001')
   
END FUNCTION

#查询前预设
PRIVATE FUNCTION axcq202_default()
   DEFINE l_glaa001   LIKE glaa_t.glaa001  #使用币别
   DEFINE l_glaa016   LIKE glaa_t.glaa016  #本位幣二
   DEFINE l_glaa020   LIKE glaa_t.glaa020  #本位幣三

   #预设当前site的法人，主账套，年度期别，成本计算类型  #150805-00001#2加IF，截止年期赋值
   IF cl_null(tm.xcbkcomp) AND cl_null(tm.xcbkld) AND cl_null(tm.xcbk002) AND cl_null(tm.xcbk003) AND cl_null(tm.xcbk001) AND cl_null(tm.currency) AND cl_null(tm.xcbk005) THEN
      CALL s_axc_set_site_default() RETURNING tm.xcbkcomp,tm.xcbkld,tm.xcbk002,tm.xcbk003,tm.xcbk001
      LET tm.currency = '1'
      LET tm.xcbk005 = '1'
      LET tm.xcbk002_1=tm.xcbk002
      LET tm.xcbk003_1=tm.xcbk003
   END IF
   #说明栏位
   CALL s_desc_get_department_desc(tm.xcbkcomp) RETURNING tm.xcbkcomp_desc #法人組織
   CALL s_desc_get_ld_desc(tm.xcbkld) RETURNING tm.xcbkld_desc #帳別編號
   #成本計算類型
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.xcbk001
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.xcbk001_desc = '', g_rtn_fields[1] , ''

   #本位币说明
   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = tm.xcbkld
   CASE tm.currency
      WHEN '1'
           CALL s_desc_get_currency_desc(l_glaa001) RETURNING tm.currency_desc
      WHEN '2'
           CALL s_desc_get_currency_desc(l_glaa016) RETURNING tm.currency_desc
      WHEN '3'
           CALL s_desc_get_currency_desc(l_glaa020) RETURNING tm.currency_desc
   END CASE

END FUNCTION

################################################################################
# Descriptions...: XG的temp
# Memo...........:
# Usage..........: CALL axcq202_creat_temp_xg()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 2016/04/26 By dorislai (#160408-00004#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq202_creat_temp_xg()
   DEFINE r_success LIKE type_t.num5
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   DROP TABLE axcq202_temp_01;
   CREATE TEMP TABLE axcq202_temp_01(
       xcbkcomp      LIKE xcbk_t.xcbkcomp,  #法人組織
       xcbkcomp_desc LIKE type_t.chr500,    #組織說明
       xcbkld        LIKE xcbk_t.xcbkld,    #帳別編號
       xcbkld_desc	LIKE type_t.chr500,    #帳套說明
       xcbk002       LIKE xcbk_t.xcbk002,   #起始年度
       xcbk003       LIKE xcbk_t.xcbk003,   #起始期別
       xcbk002_1     LIKE xcbk_t.xcbk002,   #截止年度
       xcbk003_1     LIKE xcbk_t.xcbk003,   #截止期別
       xcbk001       LIKE xcbk_t.xcbk001,   #成本計算類型
       xcbk001_desc	LIKE type_t.chr500,    #成本計算類型說明
       xcbk005	      LIKE xcbk_t.xcbk005,   #費用分類(成本主要素)
       xcbk005_desc	LIKE gzcbl_t.gzcbl004, #成本主要素
       currency	   LIKE type_t.chr1,      #本位币顺序
       currency_desc	LIKE gzcbl_t.gzcbl004, #本位幣順序
       xcbk004	      LIKE xcbk_t.xcbk004,   #成本中心
       xcbk004_desc	LIKE type_t.chr500,    #成本中心說明
       xcbk006	      LIKE xcbk_t.xcbk006,   #工單編號
       sfaasite	   LIKE sfaa_t.sfaasite,  #來源組織
       sfaasite_desc	LIKE type_t.chr500,    #來源組織說明
       xcbk007	      LIKE xcbk_t.xcbk007,   #分攤方式
       xcbk007_desc	LIKE type_t.chr500,    #分攤方式
       xcbk202	      LIKE xcbk_t.xcbk202,   #分攤金額(本位幣一)
       xcbk100	      LIKE xcbk_t.xcbk100,   #工單分攤數
       xcbk101	      LIKE xcbk_t.xcbk101,   #單位成本(本位幣一)
       xcbkent	      LIKE xcbk_t.xcbkent,   #企業編號
       mainkey	      LIKE type_t.chr500,    #组合KEY值
       l_cnt	      LIKE type_t.num5       #排序
       );

   IF SQLCA.sqlcode THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create tmp01'
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN r_success
   END IF
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 寫入報表tmp資料
# Memo...........:
# Usage..........: CALL axcq202_ins_temp_xg()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/26 By dorislai(#160408-00004#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq202_ins_temp_xg()
    DEFINE l_i LIKE type_t.num5
   DEFINE sr RECORD
      xcbkcomp      LIKE xcbk_t.xcbkcomp,  #法人組織
       xcbkcomp_desc LIKE type_t.chr500,    #組織說明
       xcbkld        LIKE xcbk_t.xcbkld,    #帳別編號
       xcbkld_desc	LIKE type_t.chr500,    #帳套說明
       xcbk002       LIKE xcbk_t.xcbk002,   #起始年度
       xcbk003       LIKE xcbk_t.xcbk003,   #起始期別
       xcbk002_1     LIKE xcbk_t.xcbk002,   #截止年度
       xcbk003_1     LIKE xcbk_t.xcbk003,   #截止期別
       xcbk001       LIKE xcbk_t.xcbk001,   #成本計算類型
       xcbk001_desc	LIKE type_t.chr500,    #成本計算類型說明
       xcbk005	      LIKE xcbk_t.xcbk005,   #費用分類(成本主要素)
       xcbk005_desc	LIKE gzcbl_t.gzcbl004, #成本主要素
       currency	   LIKE type_t.chr1,      #本位币顺序
       currency_desc	LIKE gzcbl_t.gzcbl004, #本位幣順序
       xcbk004	      LIKE xcbk_t.xcbk004,   #成本中心
       xcbk004_desc	LIKE type_t.chr500,    #成本中心說明
       xcbk006	      LIKE xcbk_t.xcbk006,   #工單編號
       sfaasite	   LIKE sfaa_t.sfaasite,  #來源組織
       sfaasite_desc	LIKE type_t.chr500,    #來源組織說明
       xcbk007	      LIKE xcbk_t.xcbk007,   #分攤方式
       xcbk007_desc	LIKE type_t.chr500,    #分攤方式
       xcbk202	      LIKE xcbk_t.xcbk202,   #分攤金額(本位幣一)
       xcbk100	      LIKE xcbk_t.xcbk100,   #工單分攤數
       xcbk101	      LIKE xcbk_t.xcbk101,   #單位成本(本位幣一)
       xcbkent	      LIKE xcbk_t.xcbkent,   #企業編號
       mainkey	      LIKE type_t.chr500,    #组合KEY值
       l_cnt	      LIKE type_t.num5       #排序
      END RECORD
   LET sr.xcbkcomp = tm_t.xcbkcomp
       
   IF cl_null(tm_t.xcbkcomp_desc) THEN
      LET sr.xcbkcomp_desc = tm_t.xcbkcomp
   ELSE
      LET sr.xcbkcomp_desc = tm_t.xcbkcomp,'(',tm_t.xcbkcomp_desc,')'
   END IF
   
   LET sr.xcbkld = tm_t.xcbkld
   
   IF cl_null(tm_t.xcbkld_desc) THEN
      LET sr.xcbkld_desc  = tm_t.xcbkld
   ELSE
      LET sr.xcbkld_desc = tm_t.xcbkld,'(',tm_t.xcbkld_desc,')'
   END IF
   
   LET sr.xcbk002 = tm_t.xcbk002
   LET sr.xcbk003 = tm_t.xcbk003
   LET sr.xcbk002_1 = tm_t.xcbk002_1
   LET sr.xcbk003_1 = tm_t.xcbk003_1
   LET sr.xcbk001 = tm_t.xcbk001
   
   IF cl_null(tm_t.xcbk001_desc) THEN
      LET sr.xcbk001_desc = tm_t.xcbk001
   ELSE
      LET sr.xcbk001_desc = tm_t.xcbk001,'(',tm_t.xcbk001_desc,')'
   END IF
   
   LET sr.xcbk005 = tm_t.xcbk005
   LET sr.xcbk005_desc = s_desc_gzcbl004_desc('8908',tm_t.xcbk005)
   IF cl_null(sr.xcbk005_desc) THEN
      LET sr.xcbk005_desc = tm_t.xcbk005
   ELSE
      LET sr.xcbk005_desc = tm_t.xcbk005,'.',sr.xcbk005_desc
   END IF
   
   LET sr.currency = tm_t.currency
   LET sr.currency_desc = s_desc_gzcbl004_desc('8914',tm_t.currency)
   IF cl_null(sr.currency_desc) THEN
      LET sr.currency_desc = tm_t.currency
   ELSE
      LET sr.currency_desc = tm_t.currency,'.',sr.currency_desc
   END IF
   LET sr.mainkey = tm_t.xcbkcomp||'-'||tm_t.xcbkld||'-'||tm_t.xcbk002||'-'||tm_t.xcbk003||'-'||tm_t.xcbk002_1||'-'||tm_t.xcbk003_1||'-'||
                    tm_t.xcbk005||'-'||tm_t.xcbk001||'-'||tm_t.currency
   FOR l_i=1 TO g_xcbk_d.getLength()
       
       LET sr.xcbk004	   = g_xcbk_d[l_i].xcbk004
       LET sr.xcbk004_desc = s_desc_get_department_desc(g_xcbk_d[l_i].xcbk004)
       IF cl_null(sr.xcbk004_desc) THEN
          LET sr.xcbk004_desc = g_xcbk_d[l_i].xcbk004
       ELSE
          LET sr.xcbk004_desc = g_xcbk_d[l_i].xcbk004,':',sr.xcbk004_desc
       END IF
       LET sr.xcbk006	   = g_xcbk_d[l_i].xcbk006
       LET sr.xcbk007	   = g_xcbk_d[l_i].xcbk007
       LET sr.xcbk007_desc = s_desc_gzcbl004_desc('8909',g_xcbk_d[l_i].xcbk007)
       IF cl_null(sr.xcbk007_desc) THEN
          LET sr.xcbk007_desc = g_xcbk_d[l_i].xcbk007
       ELSE
          LET sr.xcbk007_desc = g_xcbk_d[l_i].xcbk007,':',sr.xcbk007_desc
       END IF
       LET sr.sfaasite = g_xcbk_d[l_i].sfaasite
       LET sr.sfaasite_desc= s_desc_get_department_desc(g_xcbk_d[l_i].sfaasite)
       IF cl_null(sr.sfaasite_desc) THEN
          LET sr.sfaasite_desc = g_xcbk_d[l_i].sfaasite 
       ELSE
          LET sr.sfaasite_desc = g_xcbk_d[l_i].sfaasite,':',sr.sfaasite_desc 
       END IF
       LET sr.xcbk202 = g_xcbk_d[l_i].xcbk202
       LET sr.xcbk100 = g_xcbk_d[l_i].xcbk100
       
       LET sr.xcbk101 = g_xcbk_d[l_i].xcbk101
       LET sr.xcbkent = g_enterprise
       LET sr.l_cnt = l_i
       INSERT INTO axcq202_temp_01 VALUES (sr.*)
       IF SQLCA.sqlcode AND SQLCA.sqlcode!=100 THEN
          INITIALIZE g_errparam TO NULL 
          LET g_errparam.extend = "insert_temp_01" 
          LET g_errparam.code   = SQLCA.sqlcode 
          LET g_errparam.popup  = TRUE 
          CALL cl_err()
      END IF
    END FOR
END FUNCTION

 
{</section>}
 
