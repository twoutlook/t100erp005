#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq420.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2014-11-11 14:14:50), PR版次:0003(2016-10-26 10:23:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: anmq420
#+ Description: 即期票查詢
#+ Creator....: 05426(2014-11-11 10:55:15)
#+ Modifier...: 05426 -SD/PR- 06821
 
{</section>}
 
{<section id="anmq420.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#150715-00014#2 150723 By Jessy  anmq* bug修復(單據號碼開窗內容有誤，二次篩選無作用)
#160816-00012#4 160902 By 07900  ANM增加资金中心，帐套，法人三个栏位权限
#161021-00038#1 161026 By 06821  組織類型與職能開窗調整
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
PRIVATE TYPE type_g_nmck_d RECORD
       #statepic       LIKE type_t.chr1,
       
       nmckdocno LIKE nmck_t.nmckdocno, 
   nmck026 LIKE nmck_t.nmck026, 
   nmckstus LIKE nmck_t.nmckstus, 
   nmck024 LIKE nmck_t.nmck024, 
   nmck025 LIKE nmck_t.nmck025, 
   nmck002 LIKE nmck_t.nmck002, 
   nmck002_desc LIKE type_t.chr500, 
   nmckdocdt LIKE nmck_t.nmckdocdt, 
   nmck011 LIKE nmck_t.nmck011, 
   nmck100 LIKE nmck_t.nmck100, 
   nmck103 LIKE nmck_t.nmck103, 
   nmck031 LIKE nmck_t.nmck031, 
   nmck005 LIKE nmck_t.nmck005, 
   nmck005_desc LIKE type_t.chr500, 
   nmck004 LIKE nmck_t.nmck004, 
   nmck004_desc LIKE type_t.chr500, 
   nmckcomp LIKE nmck_t.nmckcomp 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
type type_g_nmck_m        RECORD
      nmckcomp        STRING,
      nmckcomp_desc   LIKE TYPE_t.chr80
     END RECORD
DEFINE g_nmck_m          type_g_nmck_m
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_nmck_d
DEFINE g_master_t                   type_g_nmck_d
DEFINE g_nmck_d          DYNAMIC ARRAY OF type_g_nmck_d
DEFINE g_nmck_d_t        type_g_nmck_d
 
      
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
 
{<section id="anmq420.main" >}
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
   DECLARE anmq420_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq420_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq420_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq420 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq420_init()   
 
      #進入選單 Menu (="N")
      CALL anmq420_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq420
      
   END IF 
   
   CLOSE anmq420_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq420.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq420_init()
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
      CALL cl_set_combo_scc_part('b_nmckstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('b_nmck026','8711') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   
   #end add-point
 
   CALL anmq420_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq420.default_search" >}
PRIVATE FUNCTION anmq420_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " nmckcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " nmckdocno = '", g_argv[02], "' AND "
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
 
{<section id="anmq420.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq420_ui_dialog()
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
#   DEFINE la_param  RECORD
#             prog   STRING,
#             param  DYNAMIC ARRAY OF STRING
#                    END RECORD
#   DEFINE ls_js     STRING
   DEFINE l_nmcidocno LIKE nmci_t.nmcidocno
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
      CALL anmq420_b_fill()
   ELSE
      CALL anmq420_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_nmck_d.clear()
 
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
 
         CALL anmq420_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_nmck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmq420_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq420_detail_action_trans()
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
            CALL anmq420_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq420_query()
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
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_anmt440
            LET g_action_choice="open_anmt440"
            IF cl_auth_chk_act("open_anmt440") THEN
               
               #add-point:ON ACTION open_anmt440 name="menu.open_anmt440"
               IF cl_null(g_nmck_d[g_detail_idx].nmckdocno) AND cl_null(g_nmck_m.nmckcomp) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'adb-00078' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()    
               ELSE
                  IF g_nmck_d[g_detail_idx].nmck026='1' THEN  
                     LET la_param.prog = 'anmt440'
                     LET la_param.param[1] = g_nmck_d[g_detail_idx].nmckcomp
                     LET la_param.param[2] = g_nmck_d[g_detail_idx].nmckdocno
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  ELSE
                     SELECT nmcidocno INTO l_nmcidocno FROM nmci_t WHERE nmcient=g_enterprise AND nmcicomp=g_nmck_d[g_detail_idx].nmckcomp
                     AND nmci003= g_nmck_d[g_detail_idx].nmckdocno AND nmci002= g_nmck_d[g_detail_idx].nmck026
                     LET la_param.prog = 'anmt450'
                     LET la_param.param[1] = g_nmck_d[g_detail_idx].nmckcomp
                     LET la_param.param[2] = l_nmcidocno
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF

               END IF
    
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmq420_filter()
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
            CALL anmq420_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_nmck_d)
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
            CALL anmq420_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq420_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq420_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq420_b_fill()
 
         
         
 
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
 
{<section id="anmq420.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq420_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   CALL anmq420_query_1()
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmck_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,nmckdocdt,nmck011,nmck100, 
          nmck103,nmck031,nmck005,nmck004,nmckcomp
           FROM s_detail1[1].b_nmckdocno,s_detail1[1].b_nmck026,s_detail1[1].b_nmckstus,s_detail1[1].b_nmck024, 
               s_detail1[1].b_nmck025,s_detail1[1].b_nmck002,s_detail1[1].b_nmckdocdt,s_detail1[1].b_nmck011, 
               s_detail1[1].b_nmck100,s_detail1[1].b_nmck103,s_detail1[1].b_nmck031,s_detail1[1].b_nmck005, 
               s_detail1[1].b_nmck004,s_detail1[1].b_nmckcomp
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmckcrtdt>>----
         #AFTER FIELD nmckcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmckmoddt>>----
         #AFTER FIELD nmckmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckcnfdt>>----
         #AFTER FIELD nmckcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckpstdt>>----
         #AFTER FIELD nmckpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<b_nmckdocno>>----
         #Ctrlp:construct.c.page1.b_nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocno
            #add-point:ON ACTION controlp INFIELD b_nmckdocno name="construct.c.page1.b_nmckdocno"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckdocno  #顯示到畫面上
            NEXT FIELD b_nmckdocno                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmckdocno
            #add-point:BEFORE FIELD b_nmckdocno name="construct.b.page1.b_nmckdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmckdocno
            
            #add-point:AFTER FIELD b_nmckdocno name="construct.a.page1.b_nmckdocno"
            
            #END add-point
            
 
 
         #----<<b_nmck026>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck026
            #add-point:BEFORE FIELD b_nmck026 name="construct.b.page1.b_nmck026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck026
            
            #add-point:AFTER FIELD b_nmck026 name="construct.a.page1.b_nmck026"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck026
            #add-point:ON ACTION controlp INFIELD b_nmck026 name="construct.c.page1.b_nmck026"
            
            #END add-point
 
 
         #----<<b_nmckstus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmckstus
            #add-point:BEFORE FIELD b_nmckstus name="construct.b.page1.b_nmckstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmckstus
            
            #add-point:AFTER FIELD b_nmckstus name="construct.a.page1.b_nmckstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckstus
            #add-point:ON ACTION controlp INFIELD b_nmckstus name="construct.c.page1.b_nmckstus"
            
            #END add-point
 
 
         #----<<b_nmck024>>----
         #Ctrlp:construct.c.page1.b_nmck024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck024
            #add-point:ON ACTION controlp INFIELD b_nmck024 name="construct.c.page1.b_nmck024"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck024  #顯示到畫面上
            NEXT FIELD b_nmck024                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck024
            #add-point:BEFORE FIELD b_nmck024 name="construct.b.page1.b_nmck024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck024
            
            #add-point:AFTER FIELD b_nmck024 name="construct.a.page1.b_nmck024"
            
            #END add-point
            
 
 
         #----<<b_nmck025>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck025
            #add-point:BEFORE FIELD b_nmck025 name="construct.b.page1.b_nmck025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck025
            
            #add-point:AFTER FIELD b_nmck025 name="construct.a.page1.b_nmck025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck025
            #add-point:ON ACTION controlp INFIELD b_nmck025 name="construct.c.page1.b_nmck025"
            
            #END add-point
 
 
         #----<<b_nmck002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck002
            #add-point:BEFORE FIELD b_nmck002 name="construct.b.page1.b_nmck002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck002
            
            #add-point:AFTER FIELD b_nmck002 name="construct.a.page1.b_nmck002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck002
            #add-point:ON ACTION controlp INFIELD b_nmck002 name="construct.c.page1.b_nmck002"
            
            #END add-point
 
 
         #----<<b_nmck002_desc>>----
         #----<<b_nmckdocdt>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmckdocdt
            #add-point:BEFORE FIELD b_nmckdocdt name="construct.b.page1.b_nmckdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmckdocdt
            
            #add-point:AFTER FIELD b_nmckdocdt name="construct.a.page1.b_nmckdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocdt
            #add-point:ON ACTION controlp INFIELD b_nmckdocdt name="construct.c.page1.b_nmckdocdt"
            
            #END add-point
 
 
         #----<<b_nmck011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck011
            #add-point:BEFORE FIELD b_nmck011 name="construct.b.page1.b_nmck011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck011
            
            #add-point:AFTER FIELD b_nmck011 name="construct.a.page1.b_nmck011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck011
            #add-point:ON ACTION controlp INFIELD b_nmck011 name="construct.c.page1.b_nmck011"
            
            #END add-point
 
 
         #----<<b_nmck100>>----
         #Ctrlp:construct.c.page1.b_nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck100
            #add-point:ON ACTION controlp INFIELD b_nmck100 name="construct.c.page1.b_nmck100"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck100  #顯示到畫面上
            NEXT FIELD b_nmck100                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck100
            #add-point:BEFORE FIELD b_nmck100 name="construct.b.page1.b_nmck100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck100
            
            #add-point:AFTER FIELD b_nmck100 name="construct.a.page1.b_nmck100"
            
            #END add-point
            
 
 
         #----<<b_nmck103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck103
            #add-point:BEFORE FIELD b_nmck103 name="construct.b.page1.b_nmck103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck103
            
            #add-point:AFTER FIELD b_nmck103 name="construct.a.page1.b_nmck103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck103
            #add-point:ON ACTION controlp INFIELD b_nmck103 name="construct.c.page1.b_nmck103"
            
            #END add-point
 
 
         #----<<b_nmck031>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck031
            #add-point:BEFORE FIELD b_nmck031 name="construct.b.page1.b_nmck031"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck031
            
            #add-point:AFTER FIELD b_nmck031 name="construct.a.page1.b_nmck031"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_nmck031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck031
            #add-point:ON ACTION controlp INFIELD b_nmck031 name="construct.c.page1.b_nmck031"
            
            #END add-point
 
 
         #----<<b_nmck005>>----
         #Ctrlp:construct.c.page1.b_nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck005
            #add-point:ON ACTION controlp INFIELD b_nmck005 name="construct.c.page1.b_nmck005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
            NEXT FIELD b_nmck005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck005
            #add-point:BEFORE FIELD b_nmck005 name="construct.b.page1.b_nmck005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck005
            
            #add-point:AFTER FIELD b_nmck005 name="construct.a.page1.b_nmck005"
            
            #END add-point
            
 
 
         #----<<b_nmck005_desc>>----
         #----<<b_nmck004>>----
         #Ctrlp:construct.c.page1.b_nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck004
            #add-point:ON ACTION controlp INFIELD b_nmck004 name="construct.c.page1.b_nmck004"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck004  #顯示到畫面上
            NEXT FIELD b_nmck004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmck004
            #add-point:BEFORE FIELD b_nmck004 name="construct.b.page1.b_nmck004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmck004
            
            #add-point:AFTER FIELD b_nmck004 name="construct.a.page1.b_nmck004"
            
            #END add-point
            
 
 
         #----<<b_nmck004_desc>>----
         #----<<b_nmckcomp>>----
         #Ctrlp:construct.c.page1.b_nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckcomp
            #add-point:ON ACTION controlp INFIELD b_nmckcomp name="construct.c.page1.b_nmckcomp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                          #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckcomp  #顯示到畫面上
            NEXT FIELD b_nmckcomp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_nmckcomp
            #add-point:BEFORE FIELD b_nmckcomp name="construct.b.page1.b_nmckcomp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_nmckcomp
            
            #add-point:AFTER FIELD b_nmckcomp name="construct.a.page1.b_nmckcomp"
            
            #END add-point
            
 
 
   
       
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
   CALL anmq420_b_fill()
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
 
{<section id="anmq420.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq420_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE ls_wc_1         STRING
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
 
   LET ls_sql_rank = "SELECT  UNIQUE nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,'',nmckdocdt, 
       nmck011,nmck100,nmck103,nmck031,nmck005,'',nmck004,'',nmckcomp  ,DENSE_RANK() OVER( ORDER BY nmck_t.nmckcomp, 
       nmck_t.nmckdocno) AS RANK FROM nmck_t",
 
 
                     "",
                     " WHERE nmckent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmck_t"),
                     " ORDER BY nmck_t.nmckcomp,nmck_t.nmckdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #160816-00012#4 Add  ---(S)---
   CALL s_axrt300_get_site(g_user,'','3') RETURNING ls_wc_1
   LET ls_wc_1 = cl_replace_str(ls_wc_1,"ooef017","nmckcomp")
   LET ls_wc = ls_wc," AND ",ls_wc_1
   #160816-00012#4 Add  ---(E)---
  #150715-00014#2-----s
   #加入判斷句
   LET ls_sql_rank = "SELECT  UNIQUE nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,'',nmckdocdt, 
       nmck011,nmck100,nmck103,nmck031,nmck005,'',nmck004,'',nmckcomp  ,DENSE_RANK() OVER( ORDER BY nmck_t.nmckcomp, 
       nmck_t.nmckdocno) AS RANK FROM nmck_t",
                     "",
                     " WHERE nmckent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmck_t"),
      "AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooiaent=",g_enterprise," AND ooia011='Y')", 
                     " ORDER BY nmck_t.nmckcomp,nmck_t.nmckdocno"
   #150715-00014#2-----e
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
 
   LET g_sql = "SELECT nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,'',nmckdocdt,nmck011,nmck100, 
       nmck103,nmck031,nmck005,'',nmck004,'',nmckcomp",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = g_sql,"AND nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooiaent=",g_enterprise," AND ooia011='Y')" #150715-00014#2  將條件從query搬到此處
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq420_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq420_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_nmck_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_nmck_d[l_ac].nmckdocno,g_nmck_d[l_ac].nmck026,g_nmck_d[l_ac].nmckstus, 
       g_nmck_d[l_ac].nmck024,g_nmck_d[l_ac].nmck025,g_nmck_d[l_ac].nmck002,g_nmck_d[l_ac].nmck002_desc, 
       g_nmck_d[l_ac].nmckdocdt,g_nmck_d[l_ac].nmck011,g_nmck_d[l_ac].nmck100,g_nmck_d[l_ac].nmck103, 
       g_nmck_d[l_ac].nmck031,g_nmck_d[l_ac].nmck005,g_nmck_d[l_ac].nmck005_desc,g_nmck_d[l_ac].nmck004, 
       g_nmck_d[l_ac].nmck004_desc,g_nmck_d[l_ac].nmckcomp
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_nmck_d[l_ac].statepic = cl_get_actipic(g_nmck_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL anmq420_detail_show("'1'")      
 
      CALL anmq420_nmck_t_mask()
 
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
   
 
   
   CALL g_nmck_d.deleteElement(g_nmck_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_nmck_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq420_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq420_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq420_detail_action_trans()
 
   IF g_nmck_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq420_fetch()
   END IF
   
      CALL anmq420_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq420_filter_show('nmck026','b_nmck026')
   CALL anmq420_filter_show('nmckstus','b_nmckstus')
   CALL anmq420_filter_show('nmck024','b_nmck024')
   CALL anmq420_filter_show('nmck025','b_nmck025')
   CALL anmq420_filter_show('nmck002','b_nmck002')
   CALL anmq420_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq420_filter_show('nmck011','b_nmck011')
   CALL anmq420_filter_show('nmck100','b_nmck100')
   CALL anmq420_filter_show('nmck103','b_nmck103')
   CALL anmq420_filter_show('nmck031','b_nmck031')
   CALL anmq420_filter_show('nmck005','b_nmck005')
   CALL anmq420_filter_show('nmck004','b_nmck004')
   CALL anmq420_filter_show('nmckcomp','b_nmckcomp')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq420_fetch()
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
 
{<section id="anmq420.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq420_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmck_d[l_ac].nmck002
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmck_d[l_ac].nmck002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmck_d[l_ac].nmck002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmck_d[l_ac].nmck005
            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmck_d[l_ac].nmck005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmck_d[l_ac].nmck005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmck_d[l_ac].nmck004
            LET ls_sql = "SELECT nmaal003 FROM nmaal_t WHERE nmaalent='"||g_enterprise||"' AND nmaal001=? AND nmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_nmck_d[l_ac].nmck004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmck_d[l_ac].nmck004_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq420_filter()
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
      CONSTRUCT g_wc_filter ON nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,nmckdocdt,nmck011, 
          nmck100,nmck103,nmck031,nmck005,nmck004,nmckcomp
                          FROM s_detail1[1].b_nmckdocno,s_detail1[1].b_nmck026,s_detail1[1].b_nmckstus, 
                              s_detail1[1].b_nmck024,s_detail1[1].b_nmck025,s_detail1[1].b_nmck002,s_detail1[1].b_nmckdocdt, 
                              s_detail1[1].b_nmck011,s_detail1[1].b_nmck100,s_detail1[1].b_nmck103,s_detail1[1].b_nmck031, 
                              s_detail1[1].b_nmck005,s_detail1[1].b_nmck004,s_detail1[1].b_nmckcomp
 
         BEFORE CONSTRUCT
                     DISPLAY anmq420_filter_parser('nmckdocno') TO s_detail1[1].b_nmckdocno
            DISPLAY anmq420_filter_parser('nmck026') TO s_detail1[1].b_nmck026
            DISPLAY anmq420_filter_parser('nmckstus') TO s_detail1[1].b_nmckstus
            DISPLAY anmq420_filter_parser('nmck024') TO s_detail1[1].b_nmck024
            DISPLAY anmq420_filter_parser('nmck025') TO s_detail1[1].b_nmck025
            DISPLAY anmq420_filter_parser('nmck002') TO s_detail1[1].b_nmck002
            DISPLAY anmq420_filter_parser('nmckdocdt') TO s_detail1[1].b_nmckdocdt
            DISPLAY anmq420_filter_parser('nmck011') TO s_detail1[1].b_nmck011
            DISPLAY anmq420_filter_parser('nmck100') TO s_detail1[1].b_nmck100
            DISPLAY anmq420_filter_parser('nmck103') TO s_detail1[1].b_nmck103
            DISPLAY anmq420_filter_parser('nmck031') TO s_detail1[1].b_nmck031
            DISPLAY anmq420_filter_parser('nmck005') TO s_detail1[1].b_nmck005
            DISPLAY anmq420_filter_parser('nmck004') TO s_detail1[1].b_nmck004
            DISPLAY anmq420_filter_parser('nmckcomp') TO s_detail1[1].b_nmckcomp
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<nmckcrtdt>>----
         #AFTER FIELD nmckcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<nmckmoddt>>----
         #AFTER FIELD nmckmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckcnfdt>>----
         #AFTER FIELD nmckcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckpstdt>>----
         #AFTER FIELD nmckpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<b_nmckdocno>>----
         #Ctrlp:construct.c.page1.b_nmckdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocno
            #add-point:ON ACTION controlp INFIELD b_nmckdocno name="construct.c.filter.page1.b_nmckdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckdocno  #顯示到畫面上
            NEXT FIELD b_nmckdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck026>>----
         #Ctrlp:construct.c.filter.page1.b_nmck026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck026
            #add-point:ON ACTION controlp INFIELD b_nmck026 name="construct.c.filter.page1.b_nmck026"
            
            #END add-point
 
 
         #----<<b_nmckstus>>----
         #Ctrlp:construct.c.filter.page1.b_nmckstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckstus
            #add-point:ON ACTION controlp INFIELD b_nmckstus name="construct.c.filter.page1.b_nmckstus"
            
            #END add-point
 
 
         #----<<b_nmck024>>----
         #Ctrlp:construct.c.page1.b_nmck024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck024
            #add-point:ON ACTION controlp INFIELD b_nmck024 name="construct.c.filter.page1.b_nmck024"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck024  #顯示到畫面上
            NEXT FIELD b_nmck024                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck025>>----
         #Ctrlp:construct.c.filter.page1.b_nmck025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck025
            #add-point:ON ACTION controlp INFIELD b_nmck025 name="construct.c.filter.page1.b_nmck025"
            
            #END add-point
 
 
         #----<<b_nmck002>>----
         #Ctrlp:construct.c.filter.page1.b_nmck002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck002
            #add-point:ON ACTION controlp INFIELD b_nmck002 name="construct.c.filter.page1.b_nmck002"
            
            #END add-point
 
 
         #----<<b_nmck002_desc>>----
         #----<<b_nmckdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_nmckdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckdocdt
            #add-point:ON ACTION controlp INFIELD b_nmckdocdt name="construct.c.filter.page1.b_nmckdocdt"
            
            #END add-point
 
 
         #----<<b_nmck011>>----
         #Ctrlp:construct.c.filter.page1.b_nmck011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck011
            #add-point:ON ACTION controlp INFIELD b_nmck011 name="construct.c.filter.page1.b_nmck011"
            
            #END add-point
 
 
         #----<<b_nmck100>>----
         #Ctrlp:construct.c.page1.b_nmck100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck100
            #add-point:ON ACTION controlp INFIELD b_nmck100 name="construct.c.filter.page1.b_nmck100"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck100  #顯示到畫面上
            NEXT FIELD b_nmck100                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck103>>----
         #Ctrlp:construct.c.filter.page1.b_nmck103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck103
            #add-point:ON ACTION controlp INFIELD b_nmck103 name="construct.c.filter.page1.b_nmck103"
            
            #END add-point
 
 
         #----<<b_nmck031>>----
         #Ctrlp:construct.c.filter.page1.b_nmck031
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck031
            #add-point:ON ACTION controlp INFIELD b_nmck031 name="construct.c.filter.page1.b_nmck031"
            
            #END add-point
 
 
         #----<<b_nmck005>>----
         #Ctrlp:construct.c.page1.b_nmck005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck005
            #add-point:ON ACTION controlp INFIELD b_nmck005 name="construct.c.filter.page1.b_nmck005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
            NEXT FIELD b_nmck005                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck005_desc>>----
         #----<<b_nmck004>>----
         #Ctrlp:construct.c.page1.b_nmck004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmck004
            #add-point:ON ACTION controlp INFIELD b_nmck004 name="construct.c.filter.page1.b_nmck004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck004  #顯示到畫面上
            NEXT FIELD b_nmck004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_nmck004_desc>>----
         #----<<b_nmckcomp>>----
         #Ctrlp:construct.c.page1.b_nmckcomp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_nmckcomp
            #add-point:ON ACTION controlp INFIELD b_nmckcomp name="construct.c.filter.page1.b_nmckcomp"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                          #呼叫開窗 
            DISPLAY g_qryparam.return1 TO b_nmckcomp  #顯示到畫面上
            NEXT FIELD b_nmckcomp                     #返回原欄位
    


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
   
      CALL anmq420_filter_show('nmckdocno','b_nmckdocno')
   CALL anmq420_filter_show('nmck026','b_nmck026')
   CALL anmq420_filter_show('nmckstus','b_nmckstus')
   CALL anmq420_filter_show('nmck024','b_nmck024')
   CALL anmq420_filter_show('nmck025','b_nmck025')
   CALL anmq420_filter_show('nmck002','b_nmck002')
   CALL anmq420_filter_show('nmckdocdt','b_nmckdocdt')
   CALL anmq420_filter_show('nmck011','b_nmck011')
   CALL anmq420_filter_show('nmck100','b_nmck100')
   CALL anmq420_filter_show('nmck103','b_nmck103')
   CALL anmq420_filter_show('nmck031','b_nmck031')
   CALL anmq420_filter_show('nmck005','b_nmck005')
   CALL anmq420_filter_show('nmck004','b_nmck004')
   CALL anmq420_filter_show('nmckcomp','b_nmckcomp')
 
    
   CALL anmq420_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq420_filter_parser(ps_field)
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
 
{<section id="anmq420.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq420_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq420_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.insert" >}
#+ insert
PRIVATE FUNCTION anmq420_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq420.modify" >}
#+ modify
PRIVATE FUNCTION anmq420_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq420_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.delete" >}
#+ delete
PRIVATE FUNCTION anmq420_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq420.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq420_detail_action_trans()
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
 
{<section id="anmq420.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq420_detail_index_setting()
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
            IF g_nmck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_nmck_d.getLength() AND g_nmck_d.getLength() > 0
            LET g_detail_idx = g_nmck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_nmck_d.getLength() THEN
               LET g_detail_idx = g_nmck_d.getLength()
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
 
{<section id="anmq420.mask_functions" >}
 &include "erp/anm/anmq420_mask.4gl"
 
{</section>}
 
{<section id="anmq420.other_function" readonly="Y" >}

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
PRIVATE FUNCTION anmq420_query_1()
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   DEFINE ls_wc_1    STRING 
   #add-point:query段define

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_nmck_d.clear()
   LET g_wc_filter = " 1=1"
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   LET g_wc=''
 
   
 
    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON nmckdocno,nmck026,nmckstus,nmck024,nmck025,nmck002,nmckdocdt,nmck011,nmck100, 
          nmck103,nmck031,nmck005,nmck004,nmckcomp
           FROM s_detail1[1].b_nmckdocno,s_detail1[1].b_nmck026,s_detail1[1].b_nmckstus,s_detail1[1].b_nmck024, 
               s_detail1[1].b_nmck025,s_detail1[1].b_nmck002,s_detail1[1].b_nmckdocdt,s_detail1[1].b_nmck011, 
               s_detail1[1].b_nmck100,s_detail1[1].b_nmck103,s_detail1[1].b_nmck031,s_detail1[1].b_nmck005, 
               s_detail1[1].b_nmck004,nmckcomp #150715-00014#2 add nmckcomp
                      
         BEFORE CONSTRUCT

       #單身公用欄位開窗相關處理
       #此段落由子樣板a11產生
         #共用欄位查詢處理
         ##----<<nmckcrtdt>>----
         #AFTER FIELD nmckcrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckmoddt>>----
         #AFTER FIELD nmckmoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckcnfdt>>----
         #AFTER FIELD nmckcnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<nmckpstdt>>----
         #AFTER FIELD nmckpstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
         
       #單身一般欄位開窗相關處理
                #----<<b_nmckdocno>>----
         #Ctrlp:construct.c.page1.b_nmckdocno
         ON ACTION controlp INFIELD b_nmckdocno
            #add-point:ON ACTION controlp INFIELD b_nmckdocno
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "nmck002 IN (SELECT ooia001 FROM ooia_t WHERE ooiaent=",g_enterprise," AND ooia011='Y')" #150715-00014#2 add 開窗條件
            CALL q_nmckdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmckdocno  #顯示到畫面上
            NEXT FIELD b_nmckdocno                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmckdocno
            #add-point:BEFORE FIELD b_nmckdocno

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmckdocno
            
            #add-point:AFTER FIELD b_nmckdocno

            #END add-point
            
 
         #----<<b_nmck026>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck026
            #add-point:BEFORE FIELD b_nmck026

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck026
            
            #add-point:AFTER FIELD b_nmck026

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck026
         ON ACTION controlp INFIELD b_nmck026
            #add-point:ON ACTION controlp INFIELD b_nmck026

            #END add-point
 
         #----<<b_nmckstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmckstus
            #add-point:BEFORE FIELD b_nmckstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmckstus
            
            #add-point:AFTER FIELD b_nmckstus

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmckstus
         ON ACTION controlp INFIELD b_nmckstus
            #add-point:ON ACTION controlp INFIELD b_nmckstus

            #END add-point
 
         #----<<b_nmck024>>----
         #Ctrlp:construct.c.page1.b_nmck024
         ON ACTION controlp INFIELD b_nmck024
            #add-point:ON ACTION controlp INFIELD b_nmck024
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmaf004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck024  #顯示到畫面上
            NEXT FIELD b_nmck024                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck024
            #add-point:BEFORE FIELD b_nmck024

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck024
            
            #add-point:AFTER FIELD b_nmck024

            #END add-point
            
 
         #----<<b_nmck025>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck025
            #add-point:BEFORE FIELD b_nmck025

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck025
            
            #add-point:AFTER FIELD b_nmck025

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck025
         ON ACTION controlp INFIELD b_nmck025
            #add-point:ON ACTION controlp INFIELD b_nmck025

            #END add-point
 
         #----<<b_nmck002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck002
            #add-point:BEFORE FIELD b_nmck002

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck002
            
            #add-point:AFTER FIELD b_nmck002

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck002
         ON ACTION controlp INFIELD b_nmck002
            #add-point:ON ACTION controlp INFIELD b_nmck002

            #END add-point
 
         #----<<b_nmck002_desc>>----
         #----<<b_nmckdocdt>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmckdocdt
            #add-point:BEFORE FIELD b_nmckdocdt

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmckdocdt
            
            #add-point:AFTER FIELD b_nmckdocdt

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmckdocdt
         ON ACTION controlp INFIELD b_nmckdocdt
            #add-point:ON ACTION controlp INFIELD b_nmckdocdt

            #END add-point
 
         #----<<b_nmck011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck011
            #add-point:BEFORE FIELD b_nmck011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck011
            
            #add-point:AFTER FIELD b_nmck011

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck011
         ON ACTION controlp INFIELD b_nmck011
            #add-point:ON ACTION controlp INFIELD b_nmck011

            #END add-point
 
         #----<<b_nmck100>>----
         #Ctrlp:construct.c.page1.b_nmck100
         ON ACTION controlp INFIELD b_nmck100
            #add-point:ON ACTION controlp INFIELD b_nmck100
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck100  #顯示到畫面上
            NEXT FIELD b_nmck100                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck100
            #add-point:BEFORE FIELD b_nmck100

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck100
            
            #add-point:AFTER FIELD b_nmck100

            #END add-point
            
 
         #----<<b_nmck103>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck103
            #add-point:BEFORE FIELD b_nmck103

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck103
            
            #add-point:AFTER FIELD b_nmck103

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck103
         ON ACTION controlp INFIELD b_nmck103
            #add-point:ON ACTION controlp INFIELD b_nmck103

            #END add-point
 
         #----<<b_nmck031>>----
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck031
            #add-point:BEFORE FIELD b_nmck031

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck031
            
            #add-point:AFTER FIELD b_nmck031

            #END add-point
            
 
         #Ctrlp:construct.c.page1.b_nmck031
         ON ACTION controlp INFIELD b_nmck031
            #add-point:ON ACTION controlp INFIELD b_nmck031

            #END add-point
 
         #----<<b_nmck005>>----
         #Ctrlp:construct.c.page1.b_nmck005
         ON ACTION controlp INFIELD b_nmck005
            #add-point:ON ACTION controlp INFIELD b_nmck005
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck005  #顯示到畫面上
            NEXT FIELD b_nmck005                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck005
            #add-point:BEFORE FIELD b_nmck005

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck005
            
            #add-point:AFTER FIELD b_nmck005

            #END add-point
            
 
         #----<<b_nmck005_desc>>----
         #----<<b_nmck004>>----
         #Ctrlp:construct.c.page1.b_nmck004
         ON ACTION controlp INFIELD b_nmck004
            #add-point:ON ACTION controlp INFIELD b_nmck004
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_nmas_01()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_nmck004  #顯示到畫面上
            NEXT FIELD b_nmck004                     #返回原欄位
    


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmck004
            #add-point:BEFORE FIELD b_nmck004

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmck004
            
            #add-point:AFTER FIELD b_nmck004

            #END add-point
            
 
         #----<<b_nmck004_desc>>----
         #----<<b_nmckcomp>>----
         #Ctrlp:construct.c.page1.b_nmckcomp
         #150715-00014#2-----s
         ON ACTION controlp INFIELD nmckcomp
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " ooef003 = 'Y'"
            #160816-00012#4 Add  ---(S)---
            CALL s_axrt300_get_site(g_user,'','3') RETURNING ls_wc_1
            LET g_qryparam.where = g_qryparam.where," AND ",ls_wc_1 CLIPPED
            #160816-00012#4 Add  ---(E)---
            #CALL q_ooef017_01() #161021-00038#1 mark
            CALL q_ooef001_2()   #161021-00038#1 add
            DISPLAY g_qryparam.return1 TO nmckcomp  #顯示到畫面上
            NEXT FIELD nmckcomp                     #返回原欄位
         #150715-00014#2-----e


            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD b_nmckcomp
            #add-point:BEFORE FIELD b_nmckcomp

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD b_nmckcomp
            
            #add-point:AFTER FIELD b_nmckcomp

            #END add-point
            
 
   
       
      END CONSTRUCT
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
 
 
   END DIALOG
 
   
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      #LET g_wc = ls_wc
   ELSE
      LET g_master_idx = 1
   END IF

   LET g_wc=g_wc_table #150715-00014#2  將g_wc與sql條件移除僅處理QBE條件
   
   LET g_wc2 = " 1=1"
 
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL anmq420_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF


END FUNCTION

 
{</section>}
 
