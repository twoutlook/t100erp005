#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq830.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2016-10-21 10:56:23), PR版次:0008(2016-10-21 10:55:25)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000158
#+ Filename...: apmq830
#+ Description: 門店要貨資料查詢作業
#+ Creator....: 01533(2014-02-28 09:43:54)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="apmq830.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160905-00007#11  2016/09/05 By 01727     调整系统中无ENT的SQL条件增加ent
#161006-00008#11  2016/10/21 By sakura    整批修改組織
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
PRIVATE TYPE type_g_pmdb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   pmdbsite_desc LIKE type_t.chr500, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb037_desc LIKE type_t.chr500, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb038_desc LIKE type_t.chr500, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb048_desc LIKE type_t.chr500, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   pmdb004_desc1 LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr500, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb201_desc LIKE type_t.chr500, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdbdocno LIKE pmdb_t.pmdbdocno, 
   pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb203_desc LIKE type_t.chr500, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb204_desc LIKE type_t.chr500, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb205_desc LIKE type_t.chr500, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb015_desc LIKE type_t.chr500, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb209_desc LIKE type_t.chr500, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_pmdb_d
DEFINE g_master_t                   type_g_pmdb_d
DEFINE g_pmdb_d          DYNAMIC ARRAY OF type_g_pmdb_d
DEFINE g_pmdb_d_t        type_g_pmdb_d
 
      
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
 
{<section id="apmq830.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add  
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
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
   DECLARE apmq830_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq830_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq830_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
            
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq830 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq830_init()   
 
      #進入選單 Menu (="N")
      CALL apmq830_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
            
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq830
      
   END IF 
   
   CLOSE apmq830_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq830.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION apmq830_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#4 150309 by lori522612 add   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_pmdb032','2035') 
   CALL cl_set_combo_scc('b_pmdb207','6014') 
   CALL cl_set_combo_scc('b_pmdb208','6013') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#4 150309 by lori522612 add
   
   CALL cl_set_combo_scc('b_pmdb208','6013')
   CALL cl_set_combo_scc('b_pmdb207','6014')
   CALL cl_set_combo_scc('b_pmdb032','2035') 
   #end add-point
 
   CALL apmq830_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="apmq830.default_search" >}
PRIVATE FUNCTION apmq830_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdbdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " pmdbseq = '", g_argv[02], "' AND "
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
 
{<section id="apmq830.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION apmq830_ui_dialog()
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
      CALL apmq830_b_fill()
   ELSE
      CALL apmq830_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmdb_d.clear()
 
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
 
         CALL apmq830_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_pmdb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq830_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL apmq830_detail_action_trans()
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
            CALL apmq830_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) #sakura add 
            CALL cl_set_comp_visible("sel", FALSE)                     #sakura add                        
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL apmq830_insert()
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
               CALL apmq830_query()
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG #sakura add               
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
            CALL apmq830_filter()
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
            CALL apmq830_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_pmdb_d)
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
            CALL apmq830_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq830_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq830_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq830_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               LET g_pmdb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
                        
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               LET g_pmdb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
                        
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
                        
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmdb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmdb_d[li_idx].sel = "N"
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
 
{<section id="apmq830.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION apmq830_query()
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
   CALL g_pmdb_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON pmdbsite,pmdb037,pmdb038,pmdb030,pmdb048,pmdb200,pmdb004,pmdb201,pmdb202, 
          pmdb212,pmdb006,pmdb007,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb032,pmdb049,pmdb203, 
          pmdb204,pmdb205,pmdb207,pmdb015,pmdb208,pmdb209,pmdb210,pmdb211
           FROM s_detail1[1].b_pmdbsite,s_detail1[1].b_pmdb037,s_detail1[1].b_pmdb038,s_detail1[1].b_pmdb030, 
               s_detail1[1].b_pmdb048,s_detail1[1].b_pmdb200,s_detail1[1].b_pmdb004,s_detail1[1].b_pmdb201, 
               s_detail1[1].b_pmdb202,s_detail1[1].b_pmdb212,s_detail1[1].b_pmdb006,s_detail1[1].b_pmdb007, 
               s_detail1[1].b_pmdbdocno,s_detail1[1].b_pmdbseq,s_detail1[1].b_pmdb001,s_detail1[1].b_pmdb002, 
               s_detail1[1].b_pmdb003,s_detail1[1].b_pmdb032,s_detail1[1].b_pmdb049,s_detail1[1].b_pmdb203, 
               s_detail1[1].b_pmdb204,s_detail1[1].b_pmdb205,s_detail1[1].b_pmdb207,s_detail1[1].b_pmdb015, 
               s_detail1[1].b_pmdb208,s_detail1[1].b_pmdb209,s_detail1[1].b_pmdb210,s_detail1[1].b_pmdb211 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
                        
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_pmdbsite>>----
         #Ctrlp:construct.c.page1.b_pmdbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbsite
            #add-point:ON ACTION controlp INFIELD b_pmdbsite name="construct.c.page1.b_pmdbsite"
            #此段落由子樣板a08產生
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE
#		   	LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = "8"
#            CALL q_ooed004_6()                           #呼叫開窗
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_pmdbsite  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD b_pmdbsite                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdbsite
            #add-point:BEFORE FIELD b_pmdbsite name="construct.b.page1.b_pmdbsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdbsite
            
            #add-point:AFTER FIELD b_pmdbsite name="construct.a.page1.b_pmdbsite"
            
            #END add-point
            
 
 
         #----<<b_pmdbsite_desc>>----
         #----<<b_pmdb037>>----
         #Ctrlp:construct.c.page1.b_pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb037
            #add-point:ON ACTION controlp INFIELD b_pmdb037 name="construct.c.page1.b_pmdb037"
            #此段落由子樣板a08產生
            #開窗c段
		   	INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#			   LET g_qryparam.arg1 = g_site
#            LET g_qryparam.arg2 = "8"
#            CALL q_ooed004_6()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = "8"
               CALL q_ooed004_6()
            END IF
            DISPLAY g_qryparam.return1 TO b_pmdb037  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO ooefl003 #說明(簡稱) 

            NEXT FIELD b_pmdb037                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb037
            #add-point:BEFORE FIELD b_pmdb037 name="construct.b.page1.b_pmdb037"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb037
            
            #add-point:AFTER FIELD b_pmdb037 name="construct.a.page1.b_pmdb037"
            
            #END add-point
            
 
 
         #----<<b_pmdb037_desc>>----
         #----<<b_pmdb038>>----
         #Ctrlp:construct.c.page1.b_pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb038
            #add-point:ON ACTION controlp INFIELD b_pmdb038 name="construct.c.page1.b_pmdb038"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb038  #顯示到畫面上

            NEXT FIELD b_pmdb038                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb038
            #add-point:BEFORE FIELD b_pmdb038 name="construct.b.page1.b_pmdb038"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb038
            
            #add-point:AFTER FIELD b_pmdb038 name="construct.a.page1.b_pmdb038"
            
            #END add-point
            
 
 
         #----<<b_pmdb038_desc>>----
         #----<<b_pmdb030>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb030
            #add-point:BEFORE FIELD b_pmdb030 name="construct.b.page1.b_pmdb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb030
            
            #add-point:AFTER FIELD b_pmdb030 name="construct.a.page1.b_pmdb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb030
            #add-point:ON ACTION controlp INFIELD b_pmdb030 name="construct.c.page1.b_pmdb030"
                        
            #END add-point
 
 
         #----<<b_pmdb048>>----
         #Ctrlp:construct.c.page1.b_pmdb048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb048
            #add-point:ON ACTION controlp INFIELD b_pmdb048 name="construct.c.page1.b_pmdb048"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = '274'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb048  #顯示到畫面上

            NEXT FIELD b_pmdb048                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb048
            #add-point:BEFORE FIELD b_pmdb048 name="construct.b.page1.b_pmdb048"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb048
            
            #add-point:AFTER FIELD b_pmdb048 name="construct.a.page1.b_pmdb048"
            
            #END add-point
            
 
 
         #----<<b_pmdb048_desc>>----
         #----<<b_pmdb200>>----
         #Ctrlp:construct.c.page1.b_pmdb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb200
            #add-point:ON ACTION controlp INFIELD b_pmdb200 name="construct.c.page1.b_pmdb200"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb200  #顯示到畫面上

            NEXT FIELD b_pmdb200                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb200
            #add-point:BEFORE FIELD b_pmdb200 name="construct.b.page1.b_pmdb200"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb200
            
            #add-point:AFTER FIELD b_pmdb200 name="construct.a.page1.b_pmdb200"
            
            #END add-point
            
 
 
         #----<<b_pmdb004>>----
         #Ctrlp:construct.c.page1.b_pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb004
            #add-point:ON ACTION controlp INFIELD b_pmdb004 name="construct.c.page1.b_pmdb004"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb004  #顯示到畫面上

            NEXT FIELD b_pmdb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb004
            #add-point:BEFORE FIELD b_pmdb004 name="construct.b.page1.b_pmdb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb004
            
            #add-point:AFTER FIELD b_pmdb004 name="construct.a.page1.b_pmdb004"
            
            #END add-point
            
 
 
         #----<<b_pmdb004_desc>>----
         #----<<b_pmdb004_desc1>>----
         #----<<b_imaa009>>----
         #----<<b_imaa009_desc>>----
         #----<<b_pmdb201>>----
         #Ctrlp:construct.c.page1.b_pmdb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb201
            #add-point:ON ACTION controlp INFIELD b_pmdb201 name="construct.c.page1.b_pmdb201"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb201  #顯示到畫面上

            NEXT FIELD b_pmdb201                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb201
            #add-point:BEFORE FIELD b_pmdb201 name="construct.b.page1.b_pmdb201"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb201
            
            #add-point:AFTER FIELD b_pmdb201 name="construct.a.page1.b_pmdb201"
            
            #END add-point
            
 
 
         #----<<b_pmdb201_desc>>----
         #----<<b_pmdb202>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb202
            #add-point:BEFORE FIELD b_pmdb202 name="construct.b.page1.b_pmdb202"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb202
            
            #add-point:AFTER FIELD b_pmdb202 name="construct.a.page1.b_pmdb202"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb202
            #add-point:ON ACTION controlp INFIELD b_pmdb202 name="construct.c.page1.b_pmdb202"
                        
            #END add-point
 
 
         #----<<b_pmdb212>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb212
            #add-point:BEFORE FIELD b_pmdb212 name="construct.b.page1.b_pmdb212"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb212
            
            #add-point:AFTER FIELD b_pmdb212 name="construct.a.page1.b_pmdb212"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb212
            #add-point:ON ACTION controlp INFIELD b_pmdb212 name="construct.c.page1.b_pmdb212"
                        
            #END add-point
 
 
         #----<<b_pmdb006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb006
            #add-point:BEFORE FIELD b_pmdb006 name="construct.b.page1.b_pmdb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb006
            
            #add-point:AFTER FIELD b_pmdb006 name="construct.a.page1.b_pmdb006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb006
            #add-point:ON ACTION controlp INFIELD b_pmdb006 name="construct.c.page1.b_pmdb006"
                        
            #END add-point
 
 
         #----<<b_pmdb007>>----
         #Ctrlp:construct.c.page1.b_pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb007
            #add-point:ON ACTION controlp INFIELD b_pmdb007 name="construct.c.page1.b_pmdb007"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb007  #顯示到畫面上

            NEXT FIELD b_pmdb007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb007
            #add-point:BEFORE FIELD b_pmdb007 name="construct.b.page1.b_pmdb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb007
            
            #add-point:AFTER FIELD b_pmdb007 name="construct.a.page1.b_pmdb007"
            
            #END add-point
            
 
 
         #----<<b_pmdb007_desc>>----
         #----<<b_pmdbdocno>>----
         #Ctrlp:construct.c.page1.b_pmdbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbdocno
            #add-point:ON ACTION controlp INFIELD b_pmdbdocno name="construct.c.page1.b_pmdbdocno"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmcz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdbdocno  #顯示到畫面上

            NEXT FIELD b_pmdbdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdbdocno
            #add-point:BEFORE FIELD b_pmdbdocno name="construct.b.page1.b_pmdbdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdbdocno
            
            #add-point:AFTER FIELD b_pmdbdocno name="construct.a.page1.b_pmdbdocno"
            
            #END add-point
            
 
 
         #----<<b_pmdbseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdbseq
            #add-point:BEFORE FIELD b_pmdbseq name="construct.b.page1.b_pmdbseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdbseq
            
            #add-point:AFTER FIELD b_pmdbseq name="construct.a.page1.b_pmdbseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbseq
            #add-point:ON ACTION controlp INFIELD b_pmdbseq name="construct.c.page1.b_pmdbseq"
                        
            #END add-point
 
 
         #----<<b_pmdb001>>----
         #Ctrlp:construct.c.page1.b_pmdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb001
            #add-point:ON ACTION controlp INFIELD b_pmdb001 name="construct.c.page1.b_pmdb001"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmcz024()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb001  #顯示到畫面上

            NEXT FIELD b_pmdb001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb001
            #add-point:BEFORE FIELD b_pmdb001 name="construct.b.page1.b_pmdb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb001
            
            #add-point:AFTER FIELD b_pmdb001 name="construct.a.page1.b_pmdb001"
            
            #END add-point
            
 
 
         #----<<b_pmdb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb002
            #add-point:BEFORE FIELD b_pmdb002 name="construct.b.page1.b_pmdb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb002
            
            #add-point:AFTER FIELD b_pmdb002 name="construct.a.page1.b_pmdb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb002
            #add-point:ON ACTION controlp INFIELD b_pmdb002 name="construct.c.page1.b_pmdb002"
                        
            #END add-point
 
 
         #----<<b_pmdb003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb003
            #add-point:BEFORE FIELD b_pmdb003 name="construct.b.page1.b_pmdb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb003
            
            #add-point:AFTER FIELD b_pmdb003 name="construct.a.page1.b_pmdb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb003
            #add-point:ON ACTION controlp INFIELD b_pmdb003 name="construct.c.page1.b_pmdb003"
                        
            #END add-point
 
 
         #----<<b_pmdb032>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb032
            #add-point:BEFORE FIELD b_pmdb032 name="construct.b.page1.b_pmdb032"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb032
            
            #add-point:AFTER FIELD b_pmdb032 name="construct.a.page1.b_pmdb032"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb032
            #add-point:ON ACTION controlp INFIELD b_pmdb032 name="construct.c.page1.b_pmdb032"
                        
            #END add-point
 
 
         #----<<b_pmdb049>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb049
            #add-point:BEFORE FIELD b_pmdb049 name="construct.b.page1.b_pmdb049"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb049
            
            #add-point:AFTER FIELD b_pmdb049 name="construct.a.page1.b_pmdb049"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb049
            #add-point:ON ACTION controlp INFIELD b_pmdb049 name="construct.c.page1.b_pmdb049"
                        
            #END add-point
 
 
         #----<<b_pmdb203>>----
         #Ctrlp:construct.c.page1.b_pmdb203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb203
            #add-point:ON ACTION controlp INFIELD b_pmdb203 name="construct.c.page1.b_pmdb203"
            #此段落由子樣板a08產生
            #開窗c段
		      INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#		      LET g_qryparam.where = " ooef302 = 'Y'" 
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'pmdb203') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb203',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = " ooef302 = 'Y'" 
               CALL q_ooef001()   
            END IF
            DISPLAY g_qryparam.return1 TO b_pmdb203  #顯示到畫面上

            NEXT FIELD b_pmdb203                      #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb203
            #add-point:BEFORE FIELD b_pmdb203 name="construct.b.page1.b_pmdb203"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb203
            
            #add-point:AFTER FIELD b_pmdb203 name="construct.a.page1.b_pmdb203"
            
            #END add-point
            
 
 
         #----<<b_pmdb203_desc>>----
         #----<<b_pmdb204>>----
         #Ctrlp:construct.c.page1.b_pmdb204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb204
            #add-point:ON ACTION controlp INFIELD b_pmdb204 name="construct.c.page1.b_pmdb204"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb204  #顯示到畫面上

            NEXT FIELD b_pmdb204                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb204
            #add-point:BEFORE FIELD b_pmdb204 name="construct.b.page1.b_pmdb204"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb204
            
            #add-point:AFTER FIELD b_pmdb204 name="construct.a.page1.b_pmdb204"
            
            #END add-point
            
 
 
         #----<<b_pmdb204_desc>>----
         #----<<b_pmdb205>>----
         #Ctrlp:construct.c.page1.b_pmdb205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb205
            #add-point:ON ACTION controlp INFIELD b_pmdb205 name="construct.c.page1.b_pmdb205"
            #此段落由子樣板a08產生
             #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
#			   LET g_qryparam.where = "ooef303 = 'Y'"
#            CALL q_ooef001()                           #呼叫開窗
            IF s_aooi500_setpoint(g_prog,'pmdb205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb205',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_pmdb205  #顯示到畫面上

            NEXT FIELD b_pmdb205                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb205
            #add-point:BEFORE FIELD b_pmdb205 name="construct.b.page1.b_pmdb205"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb205
            
            #add-point:AFTER FIELD b_pmdb205 name="construct.a.page1.b_pmdb205"
            
            #END add-point
            
 
 
         #----<<b_pmdb205_desc>>----
         #----<<b_pmdb207>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb207
            #add-point:BEFORE FIELD b_pmdb207 name="construct.b.page1.b_pmdb207"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb207
            
            #add-point:AFTER FIELD b_pmdb207 name="construct.a.page1.b_pmdb207"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb207
            #add-point:ON ACTION controlp INFIELD b_pmdb207 name="construct.c.page1.b_pmdb207"
                        
            #END add-point
 
 
         #----<<b_pmdb015>>----
         #Ctrlp:construct.c.page1.b_pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb015
            #add-point:ON ACTION controlp INFIELD b_pmdb015 name="construct.c.page1.b_pmdb015"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb015  #顯示到畫面上

            NEXT FIELD b_pmdb015                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb015
            #add-point:BEFORE FIELD b_pmdb015 name="construct.b.page1.b_pmdb015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb015
            
            #add-point:AFTER FIELD b_pmdb015 name="construct.a.page1.b_pmdb015"
            
            #END add-point
            
 
 
         #----<<b_pmdb015_desc>>----
         #----<<b_pmdb208>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb208
            #add-point:BEFORE FIELD b_pmdb208 name="construct.b.page1.b_pmdb208"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb208
            
            #add-point:AFTER FIELD b_pmdb208 name="construct.a.page1.b_pmdb208"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb208
            #add-point:ON ACTION controlp INFIELD b_pmdb208 name="construct.c.page1.b_pmdb208"
                        
            #END add-point
 
 
         #----<<b_pmdb209>>----
         #Ctrlp:construct.c.page1.b_pmdb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb209
            #add-point:ON ACTION controlp INFIELD b_pmdb209 name="construct.c.page1.b_pmdb209"
            #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb209  #顯示到畫面上

            NEXT FIELD b_pmdb209                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb209
            #add-point:BEFORE FIELD b_pmdb209 name="construct.b.page1.b_pmdb209"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb209
            
            #add-point:AFTER FIELD b_pmdb209 name="construct.a.page1.b_pmdb209"
            
            #END add-point
            
 
 
         #----<<b_pmdb209_desc>>----
         #----<<b_pmdb210>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb210
            #add-point:BEFORE FIELD b_pmdb210 name="construct.b.page1.b_pmdb210"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb210
            
            #add-point:AFTER FIELD b_pmdb210 name="construct.a.page1.b_pmdb210"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb210
            #add-point:ON ACTION controlp INFIELD b_pmdb210 name="construct.c.page1.b_pmdb210"
                        
            #END add-point
 
 
         #----<<b_pmdb211>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_pmdb211
            #add-point:BEFORE FIELD b_pmdb211 name="construct.b.page1.b_pmdb211"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_pmdb211
            
            #add-point:AFTER FIELD b_pmdb211 name="construct.a.page1.b_pmdb211"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_pmdb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb211
            #add-point:ON ACTION controlp INFIELD b_pmdb211 name="construct.c.page1.b_pmdb211"
                        
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
   CALL apmq830_b_fill()
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
 
{<section id="apmq830.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq830_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING 
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'pmdbsite') RETURNING l_where
   LET g_wc = g_wc," AND ",l_where
   LET g_wc  = g_wc.trim() 
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdbsite,'',pmdb037,'',pmdb038,'',pmdb030,pmdb048,'',pmdb200, 
       pmdb004,'','','','',pmdb201,'',pmdb202,pmdb212,pmdb006,pmdb007,'',pmdbdocno,pmdbseq,pmdb001,pmdb002, 
       pmdb003,pmdb032,pmdb049,pmdb203,'',pmdb204,'',pmdb205,'',pmdb207,pmdb015,'',pmdb208,pmdb209,'', 
       pmdb210,pmdb211  ,DENSE_RANK() OVER( ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq) AS RANK FROM pmdb_t", 
 
 
 
                     "",
                     " WHERE pmdbent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdb_t"),
                     " ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150904 add by beckxie---S
   LET ls_sql_rank = "SELECT UNIQUE 'N', ",
                     "              pmdbsite, ",
                     "              (SELECT ooefl003",
                     "                 FROM ooefl_t",
                     "                WHERE ooeflent = pmdbent AND ooefl001 = pmdbsite AND ooefl002 = '",g_dlang,"') pmdbsite_desc,",
                     "              pmdb037, ",
                     "              (SELECT ooefl003",
                     "                 FROM ooefl_t",
                     "                WHERE ooeflent = pmdbent AND ooefl001 = pmdb037 AND ooefl002 = '",g_dlang,"') pmdb037_desc,",
                     "              pmdb038,",
                     "              (SELECT inayl003",
                     "                 FROM inayl_t",
                     "                WHERE inaylent = pmdbent AND inayl001 = pmdb038 AND inayl002 = '",g_dlang,"') pmdb038_desc,",
                     "              pmdb030,  pmdb048,",
                     "              (SELECT oocql004",
                     "                 FROM oocql_t",
                     "                WHERE oocqlent = pmdbent ",
                     "                  AND oocql001 = '274' AND oocql002 = pmdb048 AND oocql003 = '",g_dlang,"') pmdb048_desc,",
                     "              pmdb200,  pmdb004, ",
                     "              (SELECT imaal003",
                     "                 FROM imaal_t",
                     "                WHERE imaalent = pmdbent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') pmdb004_desc,",
                     "              (SELECT imaal004",
                     "                 FROM imaal_t",
                     "                WHERE imaalent = pmdbent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"') pmdb004_desc_desc,",
                     "              imaa009,rtaxl003,    pmdb201, ",
                     "              (SELECT oocal003",
                     "                 FROM oocal_t",
                     "                WHERE oocalent = pmdbent AND oocal001 = pmdb201 AND oocal002 = '",g_dlang,"') pmdb201_desc,",
                     "              pmdb202,  pmdb212,     pmdb006, pmdb007,",
                     "              (SELECT oocal003",
                     "                 FROM oocal_t",
                     "                WHERE oocalent = pmdbent AND oocal001 = pmdb205 AND oocal002 = '",g_dlang,"') pmdb007_desc,",
                     "              pmdbdocno, ",
                     "              pmdbseq,  pmdb001,     pmdb002, pmdb003,     pmdb032,    pmdb049, ",
                     "              pmdb203,",
                     "              (SELECT ooefl003",
                     "                 FROM ooefl_t",
                     "                WHERE ooeflent = pmdbent AND ooefl001 = pmdb203 AND ooefl002 = '",g_dlang,"') pmdb203_desc,",
                     "              pmdb204,",
                     "              (SELECT inayl003",
                     "                 FROM inayl_t",
                     "                WHERE inaylent = pmdbent AND inayl001 = pmdb204 AND inayl002 = '",g_dlang,"') pmdb204_desc,",
                     "              pmdb205,",
                     "              (SELECT ooefl003",
                     "                 FROM ooefl_t",
                     "                WHERE ooeflent = pmdbent AND ooefl001 = pmdb205 AND ooefl002 = '",g_dlang,"') pmdb205_desc,",
                     "              pmdb207,  pmdb015,",
                     "              (SELECT pmaal004",
                     "                 FROM pmaal_t",
                     "                WHERE pmaalent = pmdbent AND pmaal001 = pmdb015 AND pmaal002 = '",g_dlang,"') pmdb015_desc,",
                     "              pmdb208,  pmdb209,",
                     "              (SELECT staal003",
                     "                 FROM staal_t",
                     "                WHERE staalent = pmdbent AND staal001 = pmdb209 AND staal002 = '",g_dlang,"') pmdb209_desc,",
                     "              pmdb210,  pmdb211 ,DENSE_RANK() OVER( ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq) AS RANK",
                     "  FROM pmdb_t INNER JOIN pmda_t ON pmdaent = pmdbent AND pmdadocno = pmdbdocno",
                     "              LEFT JOIN (SELECT imaaent,imaa001,imaa009,rtaxl003 ",
                     "                           FROM imaa_t LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') ",
                     "                     ON imaaent = pmdbent AND imaa001 = pmdb004 ",
                     " WHERE pmdbent= ? AND 1=1 AND pmdastus = 'Y' AND  ", ls_wc,cl_sql_add_filter("pmdb_t"),
                     " AND pmdbsite IN (SELECT ooed004 FROM ooed_t ",
                     "                   START WITH ooed005='",g_site,"' AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
                     "                   CONNECT BY  nocycle PRIOR ooed004=ooed005 AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
                     "                   UNION SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'  AND ooedent = ",g_enterprise,")"   #160905-00007#11 Add ent    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmdb_t"),
                     " ORDER BY pmdbdocno,pmdbseq"
   #150826-00013#1 效能調整 20150904 add by beckxie---E
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
 
   LET g_sql = "SELECT '',pmdbsite,'',pmdb037,'',pmdb038,'',pmdb030,pmdb048,'',pmdb200,pmdb004,'','', 
       '','',pmdb201,'',pmdb202,pmdb212,pmdb006,pmdb007,'',pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003, 
       pmdb032,pmdb049,pmdb203,'',pmdb204,'',pmdb205,'',pmdb207,pmdb015,'',pmdb208,pmdb209,'',pmdb210, 
       pmdb211",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150311 by lori522612 mark 效能調整---(S) 
   #LET g_sql = "SELECT  UNIQUE 'N',pmdbsite,'',pmdb037,'',pmdb038,'',pmdb030,pmdb048,'',pmdb200,pmdb004, 
   #    '','','','',pmdb201,'',pmdb202,pmdb212,pmdb006,pmdb007,'',pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003, 
   #    pmdb032,pmdb049,pmdb203,'',pmdb204,'',pmdb205,'',pmdb207,pmdb015,'',pmdb208,pmdb209,'',pmdb210, 
   #    pmdb211 FROM pmdb_t INNER JOIN pmda_t ON pmdaent = pmdbent AND pmdadocno = pmdbdocno",
   #            "",
   #            " WHERE pmdbent= ? AND 1=1 AND pmdastus = 'Y' AND  ", ls_wc,cl_sql_add_filter("pmdb_t"),
   #            " AND pmdbsite IN (  SELECT ooed004 FROM ooed_t ",
   #                                    "START WITH ooed005='",g_site,"' AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
   #                                    "   CONNECT BY  nocycle PRIOR ooed004=ooed005 AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
   #                                    "   UNION SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'  )"               
   #150302-00004#8 150311 by lori522612 mark 效能調整---(E)  
   #150826-00013#1 效能調整 20150904 mark by beckxie---S
   #150302-00004#8 150311 by lori522612 add 效能調整---(S)  
   #LET g_sql = "SELECT UNIQUE 'N', ",
   #            "              pmdbsite, t1.ooefl003, pmdb037, t2.ooefl003, pmdb038,    t7.inayl003, ",
   #            "              pmdb030,  pmdb048,     oocql004,pmdb200,     pmdb004, ",
   #            "              imaal003, imaal004,    imaa009, rtaxl003,    pmdb201,    t6.oocal003, ",
   #            "              pmdb202,  pmdb212,     pmdb006, pmdb007,     t5.oocal003,pmdbdocno, ",
   #            "              pmdbseq,  pmdb001,     pmdb002, pmdb003,     pmdb032,    pmdb049, ",
   #            "              pmdb203,  t3.ooefl003, pmdb204, t8.inayl003, pmdb205,    t4.ooefl003, ",
   #            "              pmdb207,  pmdb015,     pmaal004,pmdb208,     pmdb209,    staal003, ",
   #            "              pmdb210,  pmdb211 ",
   #            "  FROM pmdb_t INNER JOIN pmda_t ON pmdaent = pmdbent AND pmdadocno = pmdbdocno",
   #            "              LEFT JOIN ooefl_t t1 ON t1.ooeflent = pmdbent AND t1.ooefl001 = pmdbsite AND t1.ooefl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN ooefl_t t2 ON t2.ooeflent = pmdbent AND t2.ooefl001 = pmdb037 AND t2.ooefl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN ooefl_t t3 ON t3.ooeflent = pmdbent AND t3.ooefl001 = pmdb203 AND t3.ooefl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN ooefl_t t4 ON t4.ooeflent = pmdbent AND t4.ooefl001 = pmdb037 AND t4.ooefl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN oocal_t t5 ON t5.oocalent = pmdbent AND t5.oocal001 = pmdb205 AND t5.oocal002 = '",g_dlang,"' ",
   #            "              LEFT JOIN oocal_t t6 ON t6.oocalent = pmdbent AND t6.oocal001 = pmdb201 AND t6.oocal002 = '",g_dlang,"' ",
   #            "              LEFT JOIN inayl_t t7 ON t7.inaylent = pmdbent AND t7.inayl001 = pmdb038 AND t7.inayl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN inayl_t t8 ON t8.inaylent = pmdbent AND t8.inayl001 = pmdb204 AND t8.inayl002 = '",g_dlang,"' ",
   #            "              LEFT JOIN oocql_t ON oocqlent = pmdbent AND oocql001 = '274' AND oocql002 = pmdb048 AND oocql003 = '",g_dlang,"' ",
   #            "              LEFT JOIN imaal_t ON imaalent = pmdbent AND imaal001 = pmdb004 AND imaal002 = '",g_dlang,"' ", 
   #            "              LEFT JOIN pmaal_t ON pmaalent = pmdbent AND pmaal001 = pmdb015 AND pmaal002 = '",g_dlang,"' ",
   #            "              LEFT JOIN staal_t ON staalent = pmdbent AND staal001 = pmdb209 AND staal002 = '",g_dlang,"' ",
   #            "              LEFT JOIN (SELECT imaaent,imaa001,imaa009,rtaxl003 ",
   #            "                           FROM imaa_t LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') ",
   #            "                     ON imaaent = pmdbent AND imaa001 = pmdb004 ",
   #            " WHERE pmdbent= ? AND 1=1 AND pmdastus = 'Y' AND  ", ls_wc,cl_sql_add_filter("pmdb_t"),
   #            " AND pmdbsite IN (SELECT ooed004 FROM ooed_t ",
   #            "                   START WITH ooed005='",g_site,"' AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
   #            "                   CONNECT BY  nocycle PRIOR ooed004=ooed005 AND ooed001='8' AND ooed006<='",g_today,"' AND (ooed007>='",g_today,"' OR ooed007 IS NULL)",
   #            "                   UNION SELECT ooed004 FROM ooed_t WHERE ooed004='",g_site,"'  )"               
   #150302-00004#8 150311 by lori522612 add 效能調整---(E)  
   #LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbdocno,pmdb_t.pmdbseq"
   #150826-00013#1 效能調整 20150904 mark by beckxie---E
   #150826-00013#1 效能調整 20150904 add by beckxie---S
   LET g_sql = "SELECT 'N'  ,pmdbsite    ,pmdbsite_desc,pmdb037          ,pmdb037_desc,",
               "   pmdb038  ,pmdb038_desc,pmdb030      ,pmdb048          ,pmdb048_desc,",
               "   pmdb200  ,pmdb004     ,pmdb004_desc ,pmdb004_desc_desc,imaa009     ,",
               "  rtaxl003  ,pmdb201     ,pmdb201_desc ,pmdb202          ,     pmdb212,",
               "   pmdb006  ,pmdb007     ,pmdb007_desc ,pmdbdocno        ,pmdbseq     ,",
               "   pmdb001  ,pmdb002     ,pmdb003      ,pmdb032          ,pmdb049     ,",
               "   pmdb203  ,pmdb203_desc,pmdb204      ,pmdb204_desc     ,pmdb205     ,",
               "pmdb205_desc,pmdb207     ,pmdb015      ,pmdb015_desc     ,pmdb208     ,",
               "pmdb209     ,pmdb209_desc,pmdb210      ,pmdb211",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150904 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq830_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq830_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_pmdb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_pmdb_d[l_ac].sel,g_pmdb_d[l_ac].pmdbsite,g_pmdb_d[l_ac].pmdbsite_desc, 
       g_pmdb_d[l_ac].pmdb037,g_pmdb_d[l_ac].pmdb037_desc,g_pmdb_d[l_ac].pmdb038,g_pmdb_d[l_ac].pmdb038_desc, 
       g_pmdb_d[l_ac].pmdb030,g_pmdb_d[l_ac].pmdb048,g_pmdb_d[l_ac].pmdb048_desc,g_pmdb_d[l_ac].pmdb200, 
       g_pmdb_d[l_ac].pmdb004,g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc1,g_pmdb_d[l_ac].imaa009, 
       g_pmdb_d[l_ac].imaa009_desc,g_pmdb_d[l_ac].pmdb201,g_pmdb_d[l_ac].pmdb201_desc,g_pmdb_d[l_ac].pmdb202, 
       g_pmdb_d[l_ac].pmdb212,g_pmdb_d[l_ac].pmdb006,g_pmdb_d[l_ac].pmdb007,g_pmdb_d[l_ac].pmdb007_desc, 
       g_pmdb_d[l_ac].pmdbdocno,g_pmdb_d[l_ac].pmdbseq,g_pmdb_d[l_ac].pmdb001,g_pmdb_d[l_ac].pmdb002, 
       g_pmdb_d[l_ac].pmdb003,g_pmdb_d[l_ac].pmdb032,g_pmdb_d[l_ac].pmdb049,g_pmdb_d[l_ac].pmdb203,g_pmdb_d[l_ac].pmdb203_desc, 
       g_pmdb_d[l_ac].pmdb204,g_pmdb_d[l_ac].pmdb204_desc,g_pmdb_d[l_ac].pmdb205,g_pmdb_d[l_ac].pmdb205_desc, 
       g_pmdb_d[l_ac].pmdb207,g_pmdb_d[l_ac].pmdb015,g_pmdb_d[l_ac].pmdb015_desc,g_pmdb_d[l_ac].pmdb208, 
       g_pmdb_d[l_ac].pmdb209,g_pmdb_d[l_ac].pmdb209_desc,g_pmdb_d[l_ac].pmdb210,g_pmdb_d[l_ac].pmdb211 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_pmdb_d[l_ac].statepic = cl_get_actipic(g_pmdb_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #150302-00004#8 150311 by lori522612 mark---(S)  
      #ALL apmq830_pmdbsite_ref()
      #ALL apmq830_pmdb037_ref()
      #ALL apmq830_pmdb038_ref()
      #ALL apmq830_pmdb048_ref()
      #ALL apmq830_pmdb004_ref()
      #ALL apmq830_pmdb007_ref()
      #ALL apmq830_pmdb203_ref()
      #ALL apmq830_pmdb205_ref()
      #ALL apmq830_pmdb204_ref()
      #ALL apmq830_pmdb015_ref()
      #ALL apmq830_pmdb209_ref()
      #ALL apmq830_pmdb201_ref()
      #150302-00004#8 150311 by lori522612 mark---(E)  
      #end add-point
 
      CALL apmq830_detail_show("'1'")      
 
      CALL apmq830_pmdb_t_mask()
 
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
   
 
   
   CALL g_pmdb_d.deleteElement(g_pmdb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
      
   #end add-point
 
   LET g_detail_cnt = g_pmdb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE apmq830_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq830_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq830_detail_action_trans()
 
   IF g_pmdb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL apmq830_fetch()
   END IF
   
      CALL apmq830_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq830_filter_show('pmdb037','b_pmdb037')
   CALL apmq830_filter_show('pmdb038','b_pmdb038')
   CALL apmq830_filter_show('pmdb030','b_pmdb030')
   CALL apmq830_filter_show('pmdb048','b_pmdb048')
   CALL apmq830_filter_show('pmdb200','b_pmdb200')
   CALL apmq830_filter_show('pmdb004','b_pmdb004')
   CALL apmq830_filter_show('pmdb201','b_pmdb201')
   CALL apmq830_filter_show('pmdb202','b_pmdb202')
   CALL apmq830_filter_show('pmdb212','b_pmdb212')
   CALL apmq830_filter_show('pmdb006','b_pmdb006')
   CALL apmq830_filter_show('pmdb007','b_pmdb007')
   CALL apmq830_filter_show('pmdbdocno','b_pmdbdocno')
   CALL apmq830_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq830_filter_show('pmdb001','b_pmdb001')
   CALL apmq830_filter_show('pmdb002','b_pmdb002')
   CALL apmq830_filter_show('pmdb003','b_pmdb003')
   CALL apmq830_filter_show('pmdb032','b_pmdb032')
   CALL apmq830_filter_show('pmdb049','b_pmdb049')
   CALL apmq830_filter_show('pmdb203','b_pmdb203')
   CALL apmq830_filter_show('pmdb204','b_pmdb204')
   CALL apmq830_filter_show('pmdb205','b_pmdb205')
   CALL apmq830_filter_show('pmdb207','b_pmdb207')
   CALL apmq830_filter_show('pmdb015','b_pmdb015')
   CALL apmq830_filter_show('pmdb208','b_pmdb208')
   CALL apmq830_filter_show('pmdb209','b_pmdb209')
   CALL apmq830_filter_show('pmdb210','b_pmdb210')
   CALL apmq830_filter_show('pmdb211','b_pmdb211')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq830_fetch()
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
 
{<section id="apmq830.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq830_detail_show(ps_page)
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
      #150302-00004#8 150311 by lori522612 mark---(S)
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdbsite
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdbsite_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdbsite_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb037
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb037_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb037_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb048
      #CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb048_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb004
      #CALL ap_ref_array2(g_ref_fields,"SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb004_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb007
      #CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb007_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb203
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb203_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb203_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb205
      #CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb205_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb205_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb015
      #CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb015_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb015_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb209
      #CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
      #LET g_pmdb_d[l_ac].pmdb209_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmdb_d[l_ac].pmdb209_desc
      #150302-00004#8 150311 by lori522612 mark---(E) 
      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
      
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION apmq830_filter()
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
      CONSTRUCT g_wc_filter ON pmdbsite,pmdb037,pmdb038,pmdb030,pmdb048,pmdb200,pmdb004,pmdb201,pmdb202, 
          pmdb212,pmdb006,pmdb007,pmdbdocno,pmdbseq,pmdb001,pmdb002,pmdb003,pmdb032,pmdb049,pmdb203, 
          pmdb204,pmdb205,pmdb207,pmdb015,pmdb208,pmdb209,pmdb210,pmdb211
                          FROM s_detail1[1].b_pmdbsite,s_detail1[1].b_pmdb037,s_detail1[1].b_pmdb038, 
                              s_detail1[1].b_pmdb030,s_detail1[1].b_pmdb048,s_detail1[1].b_pmdb200,s_detail1[1].b_pmdb004, 
                              s_detail1[1].b_pmdb201,s_detail1[1].b_pmdb202,s_detail1[1].b_pmdb212,s_detail1[1].b_pmdb006, 
                              s_detail1[1].b_pmdb007,s_detail1[1].b_pmdbdocno,s_detail1[1].b_pmdbseq, 
                              s_detail1[1].b_pmdb001,s_detail1[1].b_pmdb002,s_detail1[1].b_pmdb003,s_detail1[1].b_pmdb032, 
                              s_detail1[1].b_pmdb049,s_detail1[1].b_pmdb203,s_detail1[1].b_pmdb204,s_detail1[1].b_pmdb205, 
                              s_detail1[1].b_pmdb207,s_detail1[1].b_pmdb015,s_detail1[1].b_pmdb208,s_detail1[1].b_pmdb209, 
                              s_detail1[1].b_pmdb210,s_detail1[1].b_pmdb211
 
         BEFORE CONSTRUCT
                     DISPLAY apmq830_filter_parser('pmdbsite') TO s_detail1[1].b_pmdbsite
            DISPLAY apmq830_filter_parser('pmdb037') TO s_detail1[1].b_pmdb037
            DISPLAY apmq830_filter_parser('pmdb038') TO s_detail1[1].b_pmdb038
            DISPLAY apmq830_filter_parser('pmdb030') TO s_detail1[1].b_pmdb030
            DISPLAY apmq830_filter_parser('pmdb048') TO s_detail1[1].b_pmdb048
            DISPLAY apmq830_filter_parser('pmdb200') TO s_detail1[1].b_pmdb200
            DISPLAY apmq830_filter_parser('pmdb004') TO s_detail1[1].b_pmdb004
            DISPLAY apmq830_filter_parser('pmdb201') TO s_detail1[1].b_pmdb201
            DISPLAY apmq830_filter_parser('pmdb202') TO s_detail1[1].b_pmdb202
            DISPLAY apmq830_filter_parser('pmdb212') TO s_detail1[1].b_pmdb212
            DISPLAY apmq830_filter_parser('pmdb006') TO s_detail1[1].b_pmdb006
            DISPLAY apmq830_filter_parser('pmdb007') TO s_detail1[1].b_pmdb007
            DISPLAY apmq830_filter_parser('pmdbdocno') TO s_detail1[1].b_pmdbdocno
            DISPLAY apmq830_filter_parser('pmdbseq') TO s_detail1[1].b_pmdbseq
            DISPLAY apmq830_filter_parser('pmdb001') TO s_detail1[1].b_pmdb001
            DISPLAY apmq830_filter_parser('pmdb002') TO s_detail1[1].b_pmdb002
            DISPLAY apmq830_filter_parser('pmdb003') TO s_detail1[1].b_pmdb003
            DISPLAY apmq830_filter_parser('pmdb032') TO s_detail1[1].b_pmdb032
            DISPLAY apmq830_filter_parser('pmdb049') TO s_detail1[1].b_pmdb049
            DISPLAY apmq830_filter_parser('pmdb203') TO s_detail1[1].b_pmdb203
            DISPLAY apmq830_filter_parser('pmdb204') TO s_detail1[1].b_pmdb204
            DISPLAY apmq830_filter_parser('pmdb205') TO s_detail1[1].b_pmdb205
            DISPLAY apmq830_filter_parser('pmdb207') TO s_detail1[1].b_pmdb207
            DISPLAY apmq830_filter_parser('pmdb015') TO s_detail1[1].b_pmdb015
            DISPLAY apmq830_filter_parser('pmdb208') TO s_detail1[1].b_pmdb208
            DISPLAY apmq830_filter_parser('pmdb209') TO s_detail1[1].b_pmdb209
            DISPLAY apmq830_filter_parser('pmdb210') TO s_detail1[1].b_pmdb210
            DISPLAY apmq830_filter_parser('pmdb211') TO s_detail1[1].b_pmdb211
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdbsite>>----
         #Ctrlp:construct.c.page1.b_pmdbsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbsite
            #add-point:ON ACTION controlp INFIELD b_pmdbsite name="construct.c.filter.page1.b_pmdbsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooed004()                           #呼叫開窗
            #161006-00008#11 by sakura add(S)
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdbsite',g_site,'c')
            CALL q_ooef001_24()
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_pmdbsite  #顯示到畫面上
            NEXT FIELD b_pmdbsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdbsite_desc>>----
         #----<<b_pmdb037>>----
         #Ctrlp:construct.c.page1.b_pmdb037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb037
            #add-point:ON ACTION controlp INFIELD b_pmdb037 name="construct.c.filter.page1.b_pmdb037"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooed004()                           #呼叫開窗   #161006-00008#11 by sakura mark
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmdb037') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb037',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.arg1 = g_site
               LET g_qryparam.arg2 = "8"
               CALL q_ooed004_6()
            END IF
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_pmdb037  #顯示到畫面上
            NEXT FIELD b_pmdb037                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb037_desc>>----
         #----<<b_pmdb038>>----
         #Ctrlp:construct.c.page1.b_pmdb038
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb038
            #add-point:ON ACTION controlp INFIELD b_pmdb038 name="construct.c.filter.page1.b_pmdb038"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb038  #顯示到畫面上
            NEXT FIELD b_pmdb038                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb038_desc>>----
         #----<<b_pmdb030>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb030
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb030
            #add-point:ON ACTION controlp INFIELD b_pmdb030 name="construct.c.filter.page1.b_pmdb030"
            
            #END add-point
 
 
         #----<<b_pmdb048>>----
         #Ctrlp:construct.c.page1.b_pmdb048
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb048
            #add-point:ON ACTION controlp INFIELD b_pmdb048 name="construct.c.filter.page1.b_pmdb048"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb048  #顯示到畫面上
            NEXT FIELD b_pmdb048                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb048_desc>>----
         #----<<b_pmdb200>>----
         #Ctrlp:construct.c.page1.b_pmdb200
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb200
            #add-point:ON ACTION controlp INFIELD b_pmdb200 name="construct.c.filter.page1.b_pmdb200"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb200  #顯示到畫面上
            NEXT FIELD b_pmdb200                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb004>>----
         #Ctrlp:construct.c.page1.b_pmdb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb004
            #add-point:ON ACTION controlp INFIELD b_pmdb004 name="construct.c.filter.page1.b_pmdb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb004  #顯示到畫面上
            NEXT FIELD b_pmdb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb004_desc>>----
         #----<<b_pmdb004_desc1>>----
         #----<<b_imaa009>>----
         #----<<b_imaa009_desc>>----
         #----<<b_pmdb201>>----
         #Ctrlp:construct.c.page1.b_pmdb201
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb201
            #add-point:ON ACTION controlp INFIELD b_pmdb201 name="construct.c.filter.page1.b_pmdb201"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb201  #顯示到畫面上
            NEXT FIELD b_pmdb201                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb201_desc>>----
         #----<<b_pmdb202>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb202
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb202
            #add-point:ON ACTION controlp INFIELD b_pmdb202 name="construct.c.filter.page1.b_pmdb202"
            
            #END add-point
 
 
         #----<<b_pmdb212>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb212
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb212
            #add-point:ON ACTION controlp INFIELD b_pmdb212 name="construct.c.filter.page1.b_pmdb212"
            
            #END add-point
 
 
         #----<<b_pmdb006>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb006
            #add-point:ON ACTION controlp INFIELD b_pmdb006 name="construct.c.filter.page1.b_pmdb006"
            
            #END add-point
 
 
         #----<<b_pmdb007>>----
         #Ctrlp:construct.c.page1.b_pmdb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb007
            #add-point:ON ACTION controlp INFIELD b_pmdb007 name="construct.c.filter.page1.b_pmdb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb007  #顯示到畫面上
            NEXT FIELD b_pmdb007                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb007_desc>>----
         #----<<b_pmdbdocno>>----
         #Ctrlp:construct.c.page1.b_pmdbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbdocno
            #add-point:ON ACTION controlp INFIELD b_pmdbdocno name="construct.c.filter.page1.b_pmdbdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdbdocno  #顯示到畫面上
            NEXT FIELD b_pmdbdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdbseq>>----
         #Ctrlp:construct.c.filter.page1.b_pmdbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdbseq
            #add-point:ON ACTION controlp INFIELD b_pmdbseq name="construct.c.filter.page1.b_pmdbseq"
            
            #END add-point
 
 
         #----<<b_pmdb001>>----
         #Ctrlp:construct.c.page1.b_pmdb001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb001
            #add-point:ON ACTION controlp INFIELD b_pmdb001 name="construct.c.filter.page1.b_pmdb001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz024()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb001  #顯示到畫面上
            NEXT FIELD b_pmdb001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb002>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb002
            #add-point:ON ACTION controlp INFIELD b_pmdb002 name="construct.c.filter.page1.b_pmdb002"
            
            #END add-point
 
 
         #----<<b_pmdb003>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb003
            #add-point:ON ACTION controlp INFIELD b_pmdb003 name="construct.c.filter.page1.b_pmdb003"
            
            #END add-point
 
 
         #----<<b_pmdb032>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb032
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb032
            #add-point:ON ACTION controlp INFIELD b_pmdb032 name="construct.c.filter.page1.b_pmdb032"
            
            #END add-point
 
 
         #----<<b_pmdb049>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb049
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb049
            #add-point:ON ACTION controlp INFIELD b_pmdb049 name="construct.c.filter.page1.b_pmdb049"
            
            #END add-point
 
 
         #----<<b_pmdb203>>----
         #Ctrlp:construct.c.page1.b_pmdb203
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb203
            #add-point:ON ACTION controlp INFIELD b_pmdb203 name="construct.c.filter.page1.b_pmdb203"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb203  #顯示到畫面上
            NEXT FIELD b_pmdb203                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb203_desc>>----
         #----<<b_pmdb204>>----
         #Ctrlp:construct.c.page1.b_pmdb204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb204
            #add-point:ON ACTION controlp INFIELD b_pmdb204 name="construct.c.filter.page1.b_pmdb204"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_6()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb204  #顯示到畫面上
            NEXT FIELD b_pmdb204                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb204_desc>>----
         #----<<b_pmdb205>>----
         #Ctrlp:construct.c.page1.b_pmdb205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb205
            #add-point:ON ACTION controlp INFIELD b_pmdb205 name="construct.c.filter.page1.b_pmdb205"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗   #161006-00008#11 by sakura mark
            #161006-00008#11 by sakura add(S)
            IF s_aooi500_setpoint(g_prog,'pmdb205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdb205',g_site,'c')   #150308-00001#4 150309 by lori522612 add 'c'
               CALL q_ooef001_24()
            ELSE
               LET g_qryparam.where = "ooef303 = 'Y'"
               CALL q_ooef001()
            END IF
            #161006-00008#11 by sakura add(E)
            DISPLAY g_qryparam.return1 TO b_pmdb205  #顯示到畫面上
            NEXT FIELD b_pmdb205                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb205_desc>>----
         #----<<b_pmdb207>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb207
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb207
            #add-point:ON ACTION controlp INFIELD b_pmdb207 name="construct.c.filter.page1.b_pmdb207"
            
            #END add-point
 
 
         #----<<b_pmdb015>>----
         #Ctrlp:construct.c.page1.b_pmdb015
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb015
            #add-point:ON ACTION controlp INFIELD b_pmdb015 name="construct.c.filter.page1.b_pmdb015"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb015  #顯示到畫面上
            NEXT FIELD b_pmdb015                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb015_desc>>----
         #----<<b_pmdb208>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb208
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb208
            #add-point:ON ACTION controlp INFIELD b_pmdb208 name="construct.c.filter.page1.b_pmdb208"
            
            #END add-point
 
 
         #----<<b_pmdb209>>----
         #Ctrlp:construct.c.page1.b_pmdb209
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb209
            #add-point:ON ACTION controlp INFIELD b_pmdb209 name="construct.c.filter.page1.b_pmdb209"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_staa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdb209  #顯示到畫面上
            NEXT FIELD b_pmdb209                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdb209_desc>>----
         #----<<b_pmdb210>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb210
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb210
            #add-point:ON ACTION controlp INFIELD b_pmdb210 name="construct.c.filter.page1.b_pmdb210"
            
            #END add-point
 
 
         #----<<b_pmdb211>>----
         #Ctrlp:construct.c.filter.page1.b_pmdb211
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdb211
            #add-point:ON ACTION controlp INFIELD b_pmdb211 name="construct.c.filter.page1.b_pmdb211"
            
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
   
      CALL apmq830_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq830_filter_show('pmdb037','b_pmdb037')
   CALL apmq830_filter_show('pmdb038','b_pmdb038')
   CALL apmq830_filter_show('pmdb030','b_pmdb030')
   CALL apmq830_filter_show('pmdb048','b_pmdb048')
   CALL apmq830_filter_show('pmdb200','b_pmdb200')
   CALL apmq830_filter_show('pmdb004','b_pmdb004')
   CALL apmq830_filter_show('pmdb201','b_pmdb201')
   CALL apmq830_filter_show('pmdb202','b_pmdb202')
   CALL apmq830_filter_show('pmdb212','b_pmdb212')
   CALL apmq830_filter_show('pmdb006','b_pmdb006')
   CALL apmq830_filter_show('pmdb007','b_pmdb007')
   CALL apmq830_filter_show('pmdbdocno','b_pmdbdocno')
   CALL apmq830_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq830_filter_show('pmdb001','b_pmdb001')
   CALL apmq830_filter_show('pmdb002','b_pmdb002')
   CALL apmq830_filter_show('pmdb003','b_pmdb003')
   CALL apmq830_filter_show('pmdb032','b_pmdb032')
   CALL apmq830_filter_show('pmdb049','b_pmdb049')
   CALL apmq830_filter_show('pmdb203','b_pmdb203')
   CALL apmq830_filter_show('pmdb204','b_pmdb204')
   CALL apmq830_filter_show('pmdb205','b_pmdb205')
   CALL apmq830_filter_show('pmdb207','b_pmdb207')
   CALL apmq830_filter_show('pmdb015','b_pmdb015')
   CALL apmq830_filter_show('pmdb208','b_pmdb208')
   CALL apmq830_filter_show('pmdb209','b_pmdb209')
   CALL apmq830_filter_show('pmdb210','b_pmdb210')
   CALL apmq830_filter_show('pmdb211','b_pmdb211')
 
    
   CALL apmq830_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION apmq830_filter_parser(ps_field)
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
 
{<section id="apmq830.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq830_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq830_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.insert" >}
#+ insert
PRIVATE FUNCTION apmq830_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
      
   #end add-point
 
   #add-point:insert段control name="insert.control"
      
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmq830.modify" >}
#+ modify
PRIVATE FUNCTION apmq830_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
      
   #end add-point
 
   #add-point:modify段control name="modify.control"
      
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.reproduce" >}
#+ reproduce
PRIVATE FUNCTION apmq830_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
      
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
      
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.delete" >}
#+ delete
PRIVATE FUNCTION apmq830_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
      
   #end add-point
 
   #add-point:delete段control name="delete.control"
      
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="apmq830.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq830_detail_action_trans()
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
 
{<section id="apmq830.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq830_detail_index_setting()
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
            IF g_pmdb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmdb_d.getLength() AND g_pmdb_d.getLength() > 0
            LET g_detail_idx = g_pmdb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmdb_d.getLength() THEN
               LET g_detail_idx = g_pmdb_d.getLength()
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
 
{<section id="apmq830.mask_functions" >}
 &include "erp/apm/apmq830_mask.4gl"
 
{</section>}
 
{<section id="apmq830.other_function" readonly="Y" >}
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
PUBLIC FUNCTION apmq830_pmdbsite_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdbsite
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdbsite_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdbsite_desc
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
PUBLIC FUNCTION apmq830_pmdb037_ref()
    INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb037
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdb037_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb037_desc
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
PUBLIC FUNCTION apmq830_pmdb038_ref()
    
   #SELECT inaa002 INTO g_pmdb_d[l_ac].pmdb038_desc FROM inaa_t 
   # WHERE inaaent = g_enterprise AND inaasite =g_pmdb_d[l_ac].pmdb037  AND  inaa001 =g_pmdb_d[l_ac].pmdb038 
    
   CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb038) RETURNING  g_pmdb_d[l_ac].pmdb038_desc
    
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
PUBLIC FUNCTION apmq830_pmdb048_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb048
    CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_pmdb_d[l_ac].pmdb048_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_pmdb_d[l_ac].pmdb048_desc
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
PUBLIC FUNCTION apmq830_pmdb004_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb004
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdb004_desc = '', g_rtn_fields[1] , ''
   LET g_pmdb_d[l_ac].pmdb004_desc1 = '', g_rtn_fields[2] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb004_desc,g_pmdb_d[l_ac].pmdb004_desc1
   CALL apmq830_pmdb004_other()
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
PUBLIC FUNCTION apmq830_pmdb004_other()
   SELECT imaa009 INTO g_pmdb_d[l_ac].imaa009 
    FROM imaa_t WHERE imaaent = g_enterprise AND imaa001 = g_pmdb_d[l_ac].pmdb004
   DISPLAY  BY NAME  g_pmdb_d[l_ac].imaa009
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].imaa009
   CALL ap_ref_array2(g_ref_fields,"SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].imaa009_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].imaa009_desc 
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
PUBLIC FUNCTION apmq830_pmdb007_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb007
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdb007_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb007_desc
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
PUBLIC FUNCTION apmq830_pmdb203_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb203
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdb203_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb203_desc
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
PUBLIC FUNCTION apmq830_pmdb205_ref()
   INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb205
    CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_pmdb_d[l_ac].pmdb205_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_pmdb_d[l_ac].pmdb205_desc
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
PUBLIC FUNCTION apmq830_pmdb204_ref()
   # SELECT inaa002 INTO g_pmdb_d[l_ac].pmdb204_desc FROM inaa_t 
   # WHERE inaaent = g_enterprise AND inaasite =g_pmdb_d[l_ac].pmdb203  AND  inaa001 =g_pmdb_d[l_ac].pmdb204 
   CALL s_desc_get_stock_desc('',g_pmdb_d[l_ac].pmdb204) RETURNING  g_pmdb_d[l_ac].pmdb204_desc
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
PUBLIC FUNCTION apmq830_pmdb015_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb015
    CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_pmdb_d[l_ac].pmdb015_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_pmdb_d[l_ac].pmdb015_desc
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
PUBLIC FUNCTION apmq830_pmdb209_ref()
    INITIALIZE g_ref_fields TO NULL
    LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb209
    CALL ap_ref_array2(g_ref_fields,"SELECT staal003 FROM staal_t WHERE staalent='"||g_enterprise||"' AND staal001=? AND staal002='"||g_dlang||"'","") RETURNING g_rtn_fields
    LET g_pmdb_d[l_ac].pmdb209_desc = '', g_rtn_fields[1] , ''
    DISPLAY BY NAME g_pmdb_d[l_ac].pmdb209_desc
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
PUBLIC FUNCTION apmq830_pmdb201_ref()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_pmdb_d[l_ac].pmdb201
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_pmdb_d[l_ac].pmdb201_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_pmdb_d[l_ac].pmdb201_desc
END FUNCTION

 
{</section>}
 
