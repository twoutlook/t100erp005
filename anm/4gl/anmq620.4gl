#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq620.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-08-14 16:24:13), PR版次:0005(2016-09-29 14:45:03)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000039
#+ Filename...: anmq620
#+ Description: 資金系統現金流量項目明細查詢
#+ Creator....: 06816(2015-08-10 16:46:54)
#+ Modifier...: 06816 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq620.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#151013-00016#6  2015/10/29 By RayHuang anmq610/620 add glbc015 = 'Y'
#160125-00005#8  2016/08/08 By 02599    查詢時加上帳套人員權限條件過濾
#160905-00007#8  2016/09/05 By 07900   调整系统中无ENT的SQL条件增加ent
#160816-00012#4  2016/09/20 By 07900    ANM增加资金中心，帐套，法人三个栏位权限
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
       
       l_gzcb012 LIKE type_t.chr500, 
   l_nmai004 LIKE type_t.chr500, 
   l_nmai003 LIKE type_t.chr10, 
   l_nmai003_desc LIKE type_t.chr500, 
   glbc003 LIKE glbc_t.glbc003, 
   glbc004 LIKE glbc_t.glbc004, 
   l_glbc004_desc LIKE type_t.chr500, 
   glbcdocno LIKE glbc_t.glbcdocno, 
   glbcseq LIKE glbc_t.glbcseq, 
   glbc001 LIKE glbc_t.glbc001, 
   glbc002 LIKE glbc_t.glbc002, 
   glbc006 LIKE glbc_t.glbc006, 
   glbc008 LIKE glbc_t.glbc008, 
   glbc009 LIKE glbc_t.glbc009, 
   glbcseq1 LIKE glbc_t.glbcseq1, 
   glbcld LIKE glbc_t.glbcld 
       END RECORD
PRIVATE TYPE type_g_glbc2_d RECORD
       l_nmai003_2 LIKE type_t.chr500, 
   l_nmai003_2_desc LIKE type_t.chr500, 
   glbc003 LIKE glbc_t.glbc003, 
   glbc004 LIKE glbc_t.glbc004, 
   l_glbc004_2_desc LIKE type_t.chr500, 
   glbcdocno LIKE glbc_t.glbcdocno, 
   glbcseq LIKE glbc_t.glbcseq, 
   glbc001 LIKE glbc_t.glbc001, 
   glbc002 LIKE glbc_t.glbc002, 
   glbc012 LIKE glbc_t.glbc012, 
   glbcseq1 LIKE glbc_t.glbcseq1, 
   glbcld LIKE glbc_t.glbcld
       END RECORD
 
PRIVATE TYPE type_g_glbc3_d RECORD
       l_nmai003_3 LIKE type_t.chr500, 
   l_nmai003_3_desc LIKE type_t.chr500, 
   glbc003 LIKE glbc_t.glbc003, 
   glbc004 LIKE glbc_t.glbc004, 
   l_glbc004_3_desc LIKE type_t.chr500, 
   glbcdocno LIKE glbc_t.glbcdocno, 
   glbcseq LIKE glbc_t.glbcseq, 
   glbc001 LIKE glbc_t.glbc001, 
   glbc002 LIKE glbc_t.glbc002, 
   glbc014 LIKE glbc_t.glbc014, 
   glbcld LIKE glbc_t.glbcld, 
   glbcseq1 LIKE glbc_t.glbcseq1
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input        RECORD 
       glbcld         LIKE glbc_t.glbcld,
       glbcld_desc    LIKE glaal_t.glaal002,       
       glbccomp       LIKE glbc_t.glbccomp,
       glbccomp_desc  LIKE ooefl_t.ooefl003,
       glbc001_start  LIKE glbc_t.glbc001,
       glbc002_start  LIKE glbc_t.glbc002,
       glbc001_end    LIKE glbc_t.glbc001,
       glbc002_end    LIKE glbc_t.glbc002
                      END RECORD
DEFINE g_glaa005      LIKE glaa_t.glaa005
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glbc_d
DEFINE g_master_t                   type_g_glbc_d
DEFINE g_glbc_d          DYNAMIC ARRAY OF type_g_glbc_d
DEFINE g_glbc_d_t        type_g_glbc_d
DEFINE g_glbc2_d   DYNAMIC ARRAY OF type_g_glbc2_d
DEFINE g_glbc2_d_t type_g_glbc2_d
 
DEFINE g_glbc3_d   DYNAMIC ARRAY OF type_g_glbc3_d
DEFINE g_glbc3_d_t type_g_glbc3_d
 
 
      
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
 
{<section id="anmq620.main" >}
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
   DECLARE anmq620_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq620_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq620_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq620 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq620_init()   
 
      #進入選單 Menu (="N")
      CALL anmq620_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq620
      
   END IF 
   
   CLOSE anmq620_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq620.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION anmq620_init()
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
   CALL anmq620_create_tmp()
   CALL cl_set_combo_scc('b_glbc003','8708')
   #end add-point
 
   CALL anmq620_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="anmq620.default_search" >}
PRIVATE FUNCTION anmq620_default_search()
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
 
{<section id="anmq620.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION anmq620_ui_dialog()
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
      CALL anmq620_b_fill()
   ELSE
      CALL anmq620_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glbc_d.clear()
         CALL g_glbc2_d.clear()
 
         CALL g_glbc3_d.clear()
 
 
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
 
         CALL anmq620_init()
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
               CALL anmq620_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL anmq620_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_glbc2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glbc2_d.getLength() TO FORMONLY.h_count
               CALL anmq620_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_glbc3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 3
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_glbc3_d.getLength() TO FORMONLY.h_count
               CALL anmq620_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL anmq620_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL anmq620_query()
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
            CALL anmq620_filter()
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
            CALL anmq620_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glbc_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_glbc2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_glbc3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
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
            CALL anmq620_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmq620_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmq620_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmq620_b_fill()
 
         
         
 
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
 
{<section id="anmq620.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION anmq620_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_max      LIKE type_t.num5
   DEFINE l_min      LIKE type_t.num5
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_glaa015  LIKE glaa_t.glaa015
   DEFINE l_glaa019  LIKE glaa_t.glaa019
   DEFINE l_ld_str   STRING                #160125-00005#8
   DEFINE l_glbcld   LIKE glbc_t.glbcld 
   DEFINE l_glbcld_desc   LIKE type_t.chr500 
   DEFINE l_glbccomp LIKE glbc_t.glbccomp 
   DEFINE l_glbccomp_desc LIKE type_t.chr500 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glbc_d.clear()
   CALL g_glbc2_d.clear()
 
   CALL g_glbc3_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON glbc003,glbc004,glbcdocno,glbcseq,glbc001,glbc002,glbc006,glbc008,glbc009, 
          glbcseq1,glbcld,glbc012,glbc014
           FROM s_detail1[1].b_glbc003,s_detail1[1].b_glbc004,s_detail1[1].b_glbcdocno,s_detail1[1].b_glbcseq, 
               s_detail1[1].b_glbc001,s_detail1[1].b_glbc002,s_detail1[1].b_glbc006,s_detail1[1].b_glbc008, 
               s_detail1[1].b_glbc009,s_detail1[1].b_glbcseq1,s_detail1[1].b_glbcld,s_detail2[1].b_glbc012, 
               s_detail3[1].b_glbc014
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<l_gzcb012>>----
         #----<<l_nmai004>>----
         #----<<l_nmai003>>----
         #----<<l_nmai003_desc>>----
         #----<<b_glbc003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc003
            #add-point:BEFORE FIELD b_glbc003 name="construct.b.page1.b_glbc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc003
            
            #add-point:AFTER FIELD b_glbc003 name="construct.a.page1.b_glbc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc003
            #add-point:ON ACTION controlp INFIELD b_glbc003 name="construct.c.page1.b_glbc003"
            
            #END add-point
 
 
         #----<<b_glbc004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc004
            #add-point:BEFORE FIELD b_glbc004 name="construct.b.page1.b_glbc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc004
            
            #add-point:AFTER FIELD b_glbc004 name="construct.a.page1.b_glbc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc004
            #add-point:ON ACTION controlp INFIELD b_glbc004 name="construct.c.page1.b_glbc004"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " nmai001 = '",g_glaa005,"'"
            CALL q_nmai002()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glbc004  #顯示到畫面上
            NEXT FIELD b_glbc004                     #返回原欄位
            #END add-point
 
 
         #----<<l_glbc004_desc>>----
         #----<<b_glbcdocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbcdocno
            #add-point:BEFORE FIELD b_glbcdocno name="construct.b.page1.b_glbcdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbcdocno
            
            #add-point:AFTER FIELD b_glbcdocno name="construct.a.page1.b_glbcdocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcdocno
            #add-point:ON ACTION controlp INFIELD b_glbcdocno name="construct.c.page1.b_glbcdocno"
            
            #END add-point
 
 
         #----<<b_glbcseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbcseq
            #add-point:BEFORE FIELD b_glbcseq name="construct.b.page1.b_glbcseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbcseq
            
            #add-point:AFTER FIELD b_glbcseq name="construct.a.page1.b_glbcseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcseq
            #add-point:ON ACTION controlp INFIELD b_glbcseq name="construct.c.page1.b_glbcseq"
            
            #END add-point
 
 
         #----<<b_glbc001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc001
            #add-point:BEFORE FIELD b_glbc001 name="construct.b.page1.b_glbc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc001
            
            #add-point:AFTER FIELD b_glbc001 name="construct.a.page1.b_glbc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc001
            #add-point:ON ACTION controlp INFIELD b_glbc001 name="construct.c.page1.b_glbc001"
            
            #END add-point
 
 
         #----<<b_glbc002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc002
            #add-point:BEFORE FIELD b_glbc002 name="construct.b.page1.b_glbc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc002
            
            #add-point:AFTER FIELD b_glbc002 name="construct.a.page1.b_glbc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc002
            #add-point:ON ACTION controlp INFIELD b_glbc002 name="construct.c.page1.b_glbc002"
            
            #END add-point
 
 
         #----<<b_glbc006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc006
            #add-point:BEFORE FIELD b_glbc006 name="construct.b.page1.b_glbc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc006
            
            #add-point:AFTER FIELD b_glbc006 name="construct.a.page1.b_glbc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc006
            #add-point:ON ACTION controlp INFIELD b_glbc006 name="construct.c.page1.b_glbc006"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_aooi001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_glbc006  #顯示到畫面上
            NEXT FIELD b_glbc006                     #返回原欄位
            #END add-point
 
 
         #----<<b_glbc008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc008
            #add-point:BEFORE FIELD b_glbc008 name="construct.b.page1.b_glbc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc008
            
            #add-point:AFTER FIELD b_glbc008 name="construct.a.page1.b_glbc008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc008
            #add-point:ON ACTION controlp INFIELD b_glbc008 name="construct.c.page1.b_glbc008"
            
            #END add-point
 
 
         #----<<b_glbc009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc009
            #add-point:BEFORE FIELD b_glbc009 name="construct.b.page1.b_glbc009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc009
            
            #add-point:AFTER FIELD b_glbc009 name="construct.a.page1.b_glbc009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc009
            #add-point:ON ACTION controlp INFIELD b_glbc009 name="construct.c.page1.b_glbc009"
            
            #END add-point
 
 
         #----<<b_glbcseq1>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbcseq1
            #add-point:BEFORE FIELD b_glbcseq1 name="construct.b.page1.b_glbcseq1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbcseq1
            
            #add-point:AFTER FIELD b_glbcseq1 name="construct.a.page1.b_glbcseq1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcseq1
            #add-point:ON ACTION controlp INFIELD b_glbcseq1 name="construct.c.page1.b_glbcseq1"
            
            #END add-point
 
 
         #----<<b_glbcld>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbcld
            #add-point:BEFORE FIELD b_glbcld name="construct.b.page1.b_glbcld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbcld
            
            #add-point:AFTER FIELD b_glbcld name="construct.a.page1.b_glbcld"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glbcld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcld
            #add-point:ON ACTION controlp INFIELD b_glbcld name="construct.c.page1.b_glbcld"
            
            #END add-point
 
 
         #----<<l_nmai003_2>>----
         #----<<l_nmai003_2_desc>>----
         #----<<l_glbc004_2_desc>>----
         #----<<b_glbc012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc012
            #add-point:BEFORE FIELD b_glbc012 name="construct.b.page2.b_glbc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc012
            
            #add-point:AFTER FIELD b_glbc012 name="construct.a.page2.b_glbc012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.b_glbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc012
            #add-point:ON ACTION controlp INFIELD b_glbc012 name="construct.c.page2.b_glbc012"
            
            #END add-point
 
 
         #----<<l_nmai003_3>>----
         #----<<l_nmai003_3_desc>>----
         #----<<l_glbc004_3_desc>>----
         #----<<b_glbc014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glbc014
            #add-point:BEFORE FIELD b_glbc014 name="construct.b.page3.b_glbc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glbc014
            
            #add-point:AFTER FIELD b_glbc014 name="construct.a.page3.b_glbc014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page3.b_glbc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc014
            #add-point:ON ACTION controlp INFIELD b_glbc014 name="construct.c.page3.b_glbc014"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.glbcld,g_input.glbccomp,g_input.glbccomp_desc,g_input.glbc001_start,
                    g_input.glbc002_start,g_input.glbc001_end,g_input.glbc002_end
         BEFORE INPUT
         #160816-00012#4 --add--s--
         BEFORE FIELD glbcld 
             LET l_glbcld = g_input.glbcld
             LET l_glbcld_desc = g_input.glbcld_desc  
             LET l_glbccomp = g_input.glbccomp
             LET l_glbccomp_desc = g_input.glbccomp_desc
         #160816-00012#4 --add--e--
         AFTER FIELD glbcld
            IF NOT cl_null(g_input.glbcld) THEN
               LET l_cnt = 0 
               SELECT COUNT(*) INTO l_cnt FROM glaa_t WHERE glaaent = g_enterprise AND glaald = g_input.glbcld
               IF l_cnt = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00055'
                  LET g_errparam.extend = g_input.glbcld
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  #160816-00012#4 --add--s--
                  LET g_input.glbcld = l_glbcld
                  LET g_input.glbcld_desc  = l_glbcld_desc
                  LET g_input.glbccomp  = l_glbccomp
                  LET g_input.glbccomp_desc = l_glbccomp_desc
                  DISPLAY BY NAME g_input.glbcld,g_input.glbcld_desc,
                                  g_input.glbccomp,g_input.glbccomp_desc
                  #160816-00012#4 --add--e--
                  NEXT FIELD glbcld
               END IF
               #160125-00005#8--add--str--
               CALL s_fin_ld_chk(g_input.glbcld,g_user,'Y') RETURNING g_sub_success,g_errno  #160816-00012#4  add 'Y'
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code  = g_errno
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #160816-00012#4 --add--s--
                  LET g_input.glbcld = l_glbcld
                  LET g_input.glbcld_desc  = l_glbcld_desc
                  LET g_input.glbccomp  = l_glbccomp
                  LET g_input.glbccomp_desc = l_glbccomp_desc
                  DISPLAY BY NAME g_input.glbcld,g_input.glbcld_desc,
                                  g_input.glbccomp,g_input.glbccomp_desc
                  #160816-00012#4 --add--e--
                  NEXT FIELD glbcld
               END IF
               #160125-00005#8--add--end 
               LET g_input.glbcld_desc = s_desc_get_ld_desc(g_input.glbcld)
               DISPLAY BY NAME g_input.glbcld,g_input.glbcld_desc
               #帶出所屬法人
               SELECT glaa005,glaacomp,glaa015,glaa019
                 INTO g_glaa005,g_input.glbccomp,l_glaa015,l_glaa019
                 FROM glaa_t
                WHERE glaald = g_input.glbcld AND glaaent = g_enterprise
               IF l_glaa015 = 'Y' THEN
                  CALL cl_set_comp_visible('page_2',TRUE)
               ELSE
                  CALL cl_set_comp_visible('page_2',FALSE)
               END IF
               IF l_glaa019 = 'Y' THEN
                  CALL cl_set_comp_visible('page_3',TRUE)
               ELSE
                  CALL cl_set_comp_visible('page_3',FALSE)
               END IF
               
               LET g_input.glbccomp_desc = s_desc_get_department_desc(g_input.glbccomp)
               DISPLAY BY NAME g_input.glbccomp,g_input.glbccomp_desc            
            END IF
            
         ON ACTION controlp INFIELD glbcld
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.glbcld
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
            LET g_input.glbcld = g_qryparam.return1
            LET g_input.glbcld_desc = s_desc_get_ld_desc(g_input.glbcld)
            DISPLAY BY NAME g_input.glbcld,g_input.glbcld_desc
            #帶出所屬法人
            SELECT glaa005,glaacomp
              INTO g_glaa005,g_input.glbccomp
              FROM glaa_t
             WHERE glaald = g_input.glbcld AND glaaent = g_enterprise
            LET g_input.glbccomp_desc = s_desc_get_department_desc(g_input.glbccomp)
            DISPLAY BY NAME g_input.glbccomp,g_input.glbccomp_desc            
            NEXT FIELD glbcld                          #返回原欄位
         
         AFTER FIELD glbc001_start
            IF NOT cl_null(g_input.glbc001_start) THEN
               IF NOT cl_null(g_input.glbc001_end) AND g_input.glbc001_end < g_input.glbc001_start THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00378'
                  LET g_errparam.extend = g_input.glbc001_start
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc001_start
               END IF
               IF NOT anmq620_chk_glbc001_glbc002() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = g_input.glbc001_start
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc001_start
               END IF
            END IF
         
         AFTER FIELD glbc001_end
            IF NOT cl_null(g_input.glbc001_end) THEN
               IF NOT cl_null(g_input.glbc001_start) AND g_input.glbc001_end < g_input.glbc001_start THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00378'
                  LET g_errparam.extend = g_input.glbc001_end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc001_end
               END IF
               IF NOT anmq620_chk_glbc001_glbc002() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = g_input.glbc001_end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc001_end
               END IF
            END IF
         
         AFTER FIELD glbc002_start
            IF NOT cl_null(g_input.glbcld) AND NOT cl_null(g_input.glbc001_start) AND NOT cl_null(g_input.glbc002_start) THEN
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaald = g_input.glbcld AND glaaent = g_enterprise   #160905-00007#8 add glaaent = g_enterprise 
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = l_glaa003
                  AND glav002 = g_input.glbc001_start
                  AND glavent = g_enterprise   #160905-00007#8 add
               IF g_input.glbc002_start < l_min OR g_input.glbc002_start > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = g_input.glbc002_start
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc002_start
               END IF
               IF NOT anmq620_chk_glbc001_glbc002() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = g_input.glbc002_start
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc002_start
               END IF
            END IF

         AFTER FIELD glbc002_end
            IF NOT cl_null(g_input.glbcld) AND NOT cl_null(g_input.glbc001_end) AND NOT cl_null(g_input.glbc002_end) THEN
               SELECT glaa003 INTO l_glaa003 FROM glaa_t WHERE glaald = g_input.glbcld AND glaaent = g_enterprise   #160905-00007#8 add glaaent = g_enterprise 
               SELECT MAX(glav006),MIN(glav006) INTO l_max,l_min FROM glav_t
                WHERE glav001 = l_glaa003
                  AND glav002 = g_input.glbc001_end
                  AND glavent = g_enterprise   #160905-00007#8 add                  
               IF g_input.glbc002_end < l_min OR g_input.glbc002_end > l_max THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00119'
                  LET g_errparam.extend = g_input.glbc002_end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc002_end
               END IF
               IF NOT anmq620_chk_glbc001_glbc002() THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'afa-00379'
                  LET g_errparam.extend = g_input.glbc002_end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD glbc002_end
               END IF
            END IF
          
      END INPUT
      
      BEFORE DIALOG
         CALL anmq620_qbe_clear()    
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
         CALL anmq620_qbe_clear()
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
   CALL anmq620_b_fill()
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
 
{<section id="anmq620.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq620_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_glbc008_sum   LIKE type_t.num20_6
   DEFINE l_glbc009_sum   LIKE type_t.num20_6
   DEFINE l_glbc012_sum   LIKE type_t.num20_6
   DEFINE l_glbc014_sum   LIKE type_t.num20_6
   DEFINE l_glbc008_total LIKE type_t.num20_6
   DEFINE l_glbc009_total LIKE type_t.num20_6
   DEFINE l_glbc012_total LIKE type_t.num20_6
   DEFINE l_glbc014_total LIKE type_t.num20_6
   DEFINE l_glbc008_final LIKE type_t.num20_6
   DEFINE l_glbc009_final LIKE type_t.num20_6
   DEFINE l_glbc012_final LIKE type_t.num20_6
   DEFINE l_glbc014_final LIKE type_t.num20_6
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL anmq620_insert_tmp()
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','',glbc003,glbc004,'',glbcdocno,glbcseq,glbc001,glbc002, 
       glbc006,glbc008,glbc009,glbcseq1,glbcld,'','','','','','','','','',glbc012,'','','','','','', 
       '','','','','',glbc014,'',''  ,DENSE_RANK() OVER( ORDER BY glbc_t.glbcld,glbc_t.glbcdocno,glbc_t.glbcseq, 
       glbc_t.glbcseq1,glbc_t.glbc001,glbc_t.glbc002,glbc_t.glbc010) AS RANK FROM glbc_t",
 
 
                     "",
                     " WHERE glbcent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glbc_t"),
                     " ORDER BY glbc_t.glbcld,glbc_t.glbcdocno,glbc_t.glbcseq,glbc_t.glbcseq1,glbc_t.glbc001,glbc_t.glbc002,glbc_t.glbc010"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT seq1,seq2,nmak002,nmai003,nmai003_desc,glbc003,glbc004,glbc004_desc,  ",
                     "       glbcdocno,glbcseq,glbc001,glbc002,glbc006,glbc008,glbc009,glbc012,glbc014,'',glbcent",
                     " FROM anmq620_tmp ",
                     " WHERE glbcent= ? AND 1=1 AND ", ls_wc,
                     " ORDER BY seq1,seq2,glbc003,glbc004 "
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
 
   LET g_sql = "SELECT '','','','',glbc003,glbc004,'',glbcdocno,glbcseq,glbc001,glbc002,glbc006,glbc008, 
       glbc009,glbcseq1,glbcld,'','','','','','','','','',glbc012,'','','','','','','','','','','',glbc014, 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT seq1,seq2,",
               "       nmai003,nmai003_desc,glbc003,glbc004,glbc004_desc,glbcdocno,glbcseq,glbc001,glbc002,glbc006,glbc008,glbc009,'','', ",
               "       nmai003,nmai003_desc,glbc003,glbc004,glbc004_desc,glbcdocno,glbcseq,glbc001,glbc002,glbc012,'','', ",
               "       nmai003,nmai003_desc,glbc003,glbc004,glbc004_desc,glbcdocno,glbcseq,glbc001,glbc002,glbc014,'',''  ",
               " FROM (",ls_sql_rank,")"                  
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq620_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq620_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glbc_d.clear()
   CALL g_glbc2_d.clear()   
 
   CALL g_glbc3_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET l_glbc008_sum = 0 
   LET l_glbc009_sum = 0
   LET l_glbc012_sum = 0
   LET l_glbc014_sum = 0
   LET l_glbc008_total = 0
   LET l_glbc009_total = 0
   LET l_glbc012_total = 0
   LET l_glbc014_total = 0
   LET l_glbc008_final = 0
   LET l_glbc009_final = 0
   LET l_glbc012_final = 0
   LET l_glbc014_final = 0
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glbc_d[l_ac].l_gzcb012,g_glbc_d[l_ac].l_nmai004,g_glbc_d[l_ac].l_nmai003, 
       g_glbc_d[l_ac].l_nmai003_desc,g_glbc_d[l_ac].glbc003,g_glbc_d[l_ac].glbc004,g_glbc_d[l_ac].l_glbc004_desc, 
       g_glbc_d[l_ac].glbcdocno,g_glbc_d[l_ac].glbcseq,g_glbc_d[l_ac].glbc001,g_glbc_d[l_ac].glbc002, 
       g_glbc_d[l_ac].glbc006,g_glbc_d[l_ac].glbc008,g_glbc_d[l_ac].glbc009,g_glbc_d[l_ac].glbcseq1, 
       g_glbc_d[l_ac].glbcld,g_glbc2_d[l_ac].l_nmai003_2,g_glbc2_d[l_ac].l_nmai003_2_desc,g_glbc2_d[l_ac].glbc003, 
       g_glbc2_d[l_ac].glbc004,g_glbc2_d[l_ac].l_glbc004_2_desc,g_glbc2_d[l_ac].glbcdocno,g_glbc2_d[l_ac].glbcseq, 
       g_glbc2_d[l_ac].glbc001,g_glbc2_d[l_ac].glbc002,g_glbc2_d[l_ac].glbc012,g_glbc2_d[l_ac].glbcseq1, 
       g_glbc2_d[l_ac].glbcld,g_glbc3_d[l_ac].l_nmai003_3,g_glbc3_d[l_ac].l_nmai003_3_desc,g_glbc3_d[l_ac].glbc003, 
       g_glbc3_d[l_ac].glbc004,g_glbc3_d[l_ac].l_glbc004_3_desc,g_glbc3_d[l_ac].glbcdocno,g_glbc3_d[l_ac].glbcseq, 
       g_glbc3_d[l_ac].glbc001,g_glbc3_d[l_ac].glbc002,g_glbc3_d[l_ac].glbc014,g_glbc3_d[l_ac].glbcld, 
       g_glbc3_d[l_ac].glbcseq1
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
#      IF g_glbc_d[l_ac].glbc003 = '2' THEN
#         LET g_glbc_d[l_ac].glbc003  = '-1'
#         LET g_glbc2_d[l_ac].glbc003 = '-1'
#         LET g_glbc3_d[l_ac].glbc003 = '-1'
#         LET g_glbc_d[l_ac].glbc008  = g_glbc_d[l_ac].glbc008  * -1  
#         LET g_glbc_d[l_ac].glbc009  = g_glbc_d[l_ac].glbc009  * -1
#         LET g_glbc2_d[l_ac].glbc012 = g_glbc2_d[l_ac].glbc012 * -1
#         LET g_glbc3_d[l_ac].glbc014 = g_glbc3_d[l_ac].glbc014 * -1
#      END IF
      IF l_ac > 1 THEN
         IF g_glbc_d[l_ac].l_nmai003 != g_glbc_d[l_ac - 1].l_nmai003 THEN
            LET g_glbc_d[l_ac + 2].* = g_glbc_d[l_ac].*    #把原資料往下移動2格(小計+合計)
            LET g_glbc2_d[l_ac + 2].* = g_glbc2_d[l_ac].*
            LET g_glbc3_d[l_ac + 2].* = g_glbc3_d[l_ac].*
            INITIALIZE  g_glbc_d[l_ac].* TO NULL
            INITIALIZE  g_glbc2_d[l_ac].* TO NULL
            INITIALIZE  g_glbc3_d[l_ac].* TO NULL
            LET g_glbc_d[l_ac].l_glbc004_desc    = cl_getmsg("lib-00156",g_lang)       #小計
            LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("lib-00156",g_lang)       #小計
            LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("lib-00156",g_lang)       #小計
            LET g_glbc_d[l_ac].glbc008  = l_glbc008_sum
            LET g_glbc_d[l_ac].glbc009  = l_glbc009_sum
            LET g_glbc2_d[l_ac].glbc012 = l_glbc012_sum
            LET g_glbc3_d[l_ac].glbc014 = l_glbc014_sum
            LET l_ac = l_ac + 1
            LET g_glbc_d[l_ac].l_glbc004_desc = cl_getmsg("aps-00134",g_lang)      #合計
            LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("aps-00134",g_lang)   #合計
            LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("aps-00134",g_lang)   #合計
            LET g_glbc_d[l_ac].glbc008  = l_glbc008_total
            LET g_glbc_d[l_ac].glbc009  = l_glbc009_total
            LET g_glbc2_d[l_ac].glbc012 = l_glbc012_total
            LET g_glbc3_d[l_ac].glbc014 = l_glbc014_total
            LET l_ac = l_ac + 1
            LET l_glbc008_sum = 0 
            LET l_glbc009_sum = 0
            LET l_glbc012_sum = 0
            LET l_glbc014_sum = 0
            LET l_glbc008_total = 0
            LET l_glbc009_total = 0
            LET l_glbc012_total = 0
            LET l_glbc014_total = 0
         ELSE
            IF g_glbc_d[l_ac].glbc004 != g_glbc_d[l_ac - 1].glbc004
            OR g_glbc_d[l_ac].glbc003 != g_glbc_d[l_ac - 1].glbc003     THEN
               LET g_glbc_d[l_ac + 1].* = g_glbc_d[l_ac].*    #把原資料往下移動一格
               LET g_glbc2_d[l_ac + 1].* = g_glbc2_d[l_ac].*
               LET g_glbc3_d[l_ac + 1].* = g_glbc3_d[l_ac].*
               INITIALIZE  g_glbc_d[l_ac].* TO NULL
               INITIALIZE  g_glbc2_d[l_ac].* TO NULL
               INITIALIZE  g_glbc3_d[l_ac].* TO NULL
               LET g_glbc_d[l_ac].l_glbc004_desc    = cl_getmsg("lib-00156",g_lang)       #小計
               LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("lib-00156",g_lang)       #小計
               LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("lib-00156",g_lang)       #小計
               LET g_glbc_d[l_ac].glbc008  = l_glbc008_sum
               LET g_glbc_d[l_ac].glbc009  = l_glbc009_sum
               LET g_glbc2_d[l_ac].glbc012 = l_glbc012_sum
               LET g_glbc3_d[l_ac].glbc014 = l_glbc014_sum
               LET l_ac = l_ac + 1
               LET l_glbc008_sum = 0 
               LET l_glbc009_sum = 0
               LET l_glbc012_sum = 0
               LET l_glbc014_sum = 0
            END IF
         END IF
      END IF
      #小計加總
      LET l_glbc008_sum   = l_glbc008_sum   + g_glbc_d[l_ac].glbc008  
      LET l_glbc009_sum   = l_glbc009_sum   + g_glbc_d[l_ac].glbc009  
      LET l_glbc012_sum   = l_glbc012_sum   + g_glbc2_d[l_ac].glbc012 
      LET l_glbc014_sum   = l_glbc014_sum   + g_glbc3_d[l_ac].glbc014 
      #合計加總
      LET l_glbc008_total = l_glbc008_total + g_glbc_d[l_ac].glbc008  
      LET l_glbc009_total = l_glbc009_total + g_glbc_d[l_ac].glbc009  
      LET l_glbc012_total = l_glbc012_total + g_glbc2_d[l_ac].glbc012 
      LET l_glbc014_total = l_glbc014_total + g_glbc3_d[l_ac].glbc014
      #總計加總
      LET l_glbc008_final = l_glbc008_final + g_glbc_d[l_ac].glbc008  
      LET l_glbc009_final = l_glbc009_final + g_glbc_d[l_ac].glbc009  
      LET l_glbc012_final = l_glbc012_final + g_glbc2_d[l_ac].glbc012 
      LET l_glbc014_final = l_glbc014_final + g_glbc3_d[l_ac].glbc014
      #end add-point
 
      CALL anmq620_detail_show("'1'")      
 
      CALL anmq620_glbc_t_mask()
 
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
   CALL g_glbc2_d.deleteElement(g_glbc2_d.getLength())
 
   CALL g_glbc3_d.deleteElement(g_glbc3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   IF l_ac > 1 THEN
      #小計
      LET g_glbc_d[l_ac].l_glbc004_desc    = cl_getmsg("lib-00156",g_lang)       #小計
      LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("lib-00156",g_lang)       #小計
      LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("lib-00156",g_lang)       #小計
      LET g_glbc_d[l_ac].glbc008  = l_glbc008_sum
      LET g_glbc_d[l_ac].glbc009  = l_glbc009_sum
      LET g_glbc2_d[l_ac].glbc012 = l_glbc012_sum
      LET g_glbc3_d[l_ac].glbc014 = l_glbc014_sum
      LET l_ac = l_ac + 1
      #合計
      LET g_glbc_d[l_ac].l_glbc004_desc    = cl_getmsg("aps-00134",g_lang)   #合計
      LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("aps-00134",g_lang)   #合計
      LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("aps-00134",g_lang)   #合計
      LET g_glbc_d[l_ac].glbc008  = l_glbc008_total
      LET g_glbc_d[l_ac].glbc009  = l_glbc009_total
      LET g_glbc2_d[l_ac].glbc012 = l_glbc012_total
      LET g_glbc3_d[l_ac].glbc014 = l_glbc014_total
      LET l_ac = l_ac + 1
      #總計
      LET g_glbc_d[l_ac].l_glbc004_desc    = cl_getmsg("lib-00133",g_lang)   #合計
      LET g_glbc2_d[l_ac].l_glbc004_2_desc = cl_getmsg("lib-00133",g_lang)   #合計
      LET g_glbc3_d[l_ac].l_glbc004_3_desc = cl_getmsg("lib-00133",g_lang)   #合計
      LET g_glbc_d[l_ac].glbc008  = l_glbc008_final
      LET g_glbc_d[l_ac].glbc009  = l_glbc009_final
      LET g_glbc2_d[l_ac].glbc012 = l_glbc012_final
      LET g_glbc3_d[l_ac].glbc014 = l_glbc014_final
   END IF
   LET g_tot_cnt = g_glbc_d.getLength()
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glbc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE anmq620_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmq620_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq620_detail_action_trans()
 
   IF g_glbc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL anmq620_fetch()
   END IF
   
      CALL anmq620_filter_show('glbc003','b_glbc003')
   CALL anmq620_filter_show('glbc004','b_glbc004')
   CALL anmq620_filter_show('glbcdocno','b_glbcdocno')
   CALL anmq620_filter_show('glbcseq','b_glbcseq')
   CALL anmq620_filter_show('glbc001','b_glbc001')
   CALL anmq620_filter_show('glbc002','b_glbc002')
   CALL anmq620_filter_show('glbc006','b_glbc006')
   CALL anmq620_filter_show('glbc008','b_glbc008')
   CALL anmq620_filter_show('glbc009','b_glbc009')
   CALL anmq620_filter_show('glbcseq1','b_glbcseq1')
   CALL anmq620_filter_show('glbcld','b_glbcld')
   CALL anmq620_filter_show('glbc012','b_glbc012')
   CALL anmq620_filter_show('glbc014','b_glbc014')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq620_fetch()
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
 
{<section id="anmq620.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq620_detail_show(ps_page)
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
   
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION anmq620_filter()
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
      CONSTRUCT g_wc_filter ON glbc003,glbc004,glbcdocno,glbcseq,glbc001,glbc002,glbc006,glbc008,glbc009, 
          glbcseq1,glbcld,glbc012,glbc014
                          FROM s_detail1[1].b_glbc003,s_detail1[1].b_glbc004,s_detail1[1].b_glbcdocno, 
                              s_detail1[1].b_glbcseq,s_detail1[1].b_glbc001,s_detail1[1].b_glbc002,s_detail1[1].b_glbc006, 
                              s_detail1[1].b_glbc008,s_detail1[1].b_glbc009,s_detail1[1].b_glbcseq1, 
                              s_detail1[1].b_glbcld,s_detail2[1].b_glbc012,s_detail3[1].b_glbc014
 
         BEFORE CONSTRUCT
                     DISPLAY anmq620_filter_parser('glbc003') TO s_detail1[1].b_glbc003
            DISPLAY anmq620_filter_parser('glbc004') TO s_detail1[1].b_glbc004
            DISPLAY anmq620_filter_parser('glbcdocno') TO s_detail1[1].b_glbcdocno
            DISPLAY anmq620_filter_parser('glbcseq') TO s_detail1[1].b_glbcseq
            DISPLAY anmq620_filter_parser('glbc001') TO s_detail1[1].b_glbc001
            DISPLAY anmq620_filter_parser('glbc002') TO s_detail1[1].b_glbc002
            DISPLAY anmq620_filter_parser('glbc006') TO s_detail1[1].b_glbc006
            DISPLAY anmq620_filter_parser('glbc008') TO s_detail1[1].b_glbc008
            DISPLAY anmq620_filter_parser('glbc009') TO s_detail1[1].b_glbc009
            DISPLAY anmq620_filter_parser('glbcseq1') TO s_detail1[1].b_glbcseq1
            DISPLAY anmq620_filter_parser('glbcld') TO s_detail1[1].b_glbcld
            DISPLAY anmq620_filter_parser('glbc012') TO s_detail2[1].b_glbc012
            DISPLAY anmq620_filter_parser('glbc014') TO s_detail3[1].b_glbc014
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<l_gzcb012>>----
         #----<<l_nmai004>>----
         #----<<l_nmai003>>----
         #----<<l_nmai003_desc>>----
         #----<<b_glbc003>>----
         #Ctrlp:construct.c.filter.page1.b_glbc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc003
            #add-point:ON ACTION controlp INFIELD b_glbc003 name="construct.c.filter.page1.b_glbc003"
            
            #END add-point
 
 
         #----<<b_glbc004>>----
         #Ctrlp:construct.c.filter.page1.b_glbc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc004
            #add-point:ON ACTION controlp INFIELD b_glbc004 name="construct.c.filter.page1.b_glbc004"
            
            #END add-point
 
 
         #----<<l_glbc004_desc>>----
         #----<<b_glbcdocno>>----
         #Ctrlp:construct.c.filter.page1.b_glbcdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcdocno
            #add-point:ON ACTION controlp INFIELD b_glbcdocno name="construct.c.filter.page1.b_glbcdocno"
            
            #END add-point
 
 
         #----<<b_glbcseq>>----
         #Ctrlp:construct.c.filter.page1.b_glbcseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcseq
            #add-point:ON ACTION controlp INFIELD b_glbcseq name="construct.c.filter.page1.b_glbcseq"
            
            #END add-point
 
 
         #----<<b_glbc001>>----
         #Ctrlp:construct.c.filter.page1.b_glbc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc001
            #add-point:ON ACTION controlp INFIELD b_glbc001 name="construct.c.filter.page1.b_glbc001"
            
            #END add-point
 
 
         #----<<b_glbc002>>----
         #Ctrlp:construct.c.filter.page1.b_glbc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc002
            #add-point:ON ACTION controlp INFIELD b_glbc002 name="construct.c.filter.page1.b_glbc002"
            
            #END add-point
 
 
         #----<<b_glbc006>>----
         #Ctrlp:construct.c.filter.page1.b_glbc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc006
            #add-point:ON ACTION controlp INFIELD b_glbc006 name="construct.c.filter.page1.b_glbc006"
            
            #END add-point
 
 
         #----<<b_glbc008>>----
         #Ctrlp:construct.c.filter.page1.b_glbc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc008
            #add-point:ON ACTION controlp INFIELD b_glbc008 name="construct.c.filter.page1.b_glbc008"
            
            #END add-point
 
 
         #----<<b_glbc009>>----
         #Ctrlp:construct.c.filter.page1.b_glbc009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc009
            #add-point:ON ACTION controlp INFIELD b_glbc009 name="construct.c.filter.page1.b_glbc009"
            
            #END add-point
 
 
         #----<<b_glbcseq1>>----
         #Ctrlp:construct.c.filter.page1.b_glbcseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcseq1
            #add-point:ON ACTION controlp INFIELD b_glbcseq1 name="construct.c.filter.page1.b_glbcseq1"
            
            #END add-point
 
 
         #----<<b_glbcld>>----
         #Ctrlp:construct.c.filter.page1.b_glbcld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbcld
            #add-point:ON ACTION controlp INFIELD b_glbcld name="construct.c.filter.page1.b_glbcld"
            
            #END add-point
 
 
         #----<<l_nmai003_2>>----
         #----<<l_nmai003_2_desc>>----
         #----<<l_glbc004_2_desc>>----
         #----<<b_glbc012>>----
         #Ctrlp:construct.c.filter.page2.b_glbc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc012
            #add-point:ON ACTION controlp INFIELD b_glbc012 name="construct.c.filter.page2.b_glbc012"
            
            #END add-point
 
 
         #----<<l_nmai003_3>>----
         #----<<l_nmai003_3_desc>>----
         #----<<l_glbc004_3_desc>>----
         #----<<b_glbc014>>----
         #Ctrlp:construct.c.filter.page3.b_glbc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glbc014
            #add-point:ON ACTION controlp INFIELD b_glbc014 name="construct.c.filter.page3.b_glbc014"
            
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
   
      CALL anmq620_filter_show('glbc003','b_glbc003')
   CALL anmq620_filter_show('glbc004','b_glbc004')
   CALL anmq620_filter_show('glbcdocno','b_glbcdocno')
   CALL anmq620_filter_show('glbcseq','b_glbcseq')
   CALL anmq620_filter_show('glbc001','b_glbc001')
   CALL anmq620_filter_show('glbc002','b_glbc002')
   CALL anmq620_filter_show('glbc006','b_glbc006')
   CALL anmq620_filter_show('glbc008','b_glbc008')
   CALL anmq620_filter_show('glbc009','b_glbc009')
   CALL anmq620_filter_show('glbcseq1','b_glbcseq1')
   CALL anmq620_filter_show('glbcld','b_glbcld')
   CALL anmq620_filter_show('glbc012','b_glbc012')
   CALL anmq620_filter_show('glbc014','b_glbc014')
 
    
   CALL anmq620_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION anmq620_filter_parser(ps_field)
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
 
{<section id="anmq620.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION anmq620_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmq620_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.insert" >}
#+ insert
PRIVATE FUNCTION anmq620_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmq620.modify" >}
#+ modify
PRIVATE FUNCTION anmq620_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.reproduce" >}
#+ reproduce
PRIVATE FUNCTION anmq620_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.delete" >}
#+ delete
PRIVATE FUNCTION anmq620_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="anmq620.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq620_detail_action_trans()
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
 
{<section id="anmq620.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq620_detail_index_setting()
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
 
{<section id="anmq620.mask_functions" >}
 &include "erp/anm/anmq620_mask.4gl"
 
{</section>}
 
{<section id="anmq620.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 建立temp table
# Memo...........:
# Usage..........: CALL anmq620_create_tmp()
# Date & Author..: 15/08/11  By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq620_create_tmp()
   DROP TABLE anmq620_tmp;
   CREATE TEMP TABLE anmq620_tmp(
   glbcent      LIKE glbc_t.glbcent,
   nmak002      LIKE gzcb_t.gzcb002,
   nmai003      LIKE nmai_t.nmai003,
   nmai003_desc LIKE type_t.chr500,
   glbc003      LIKE glbc_t.glbc003,
   glbc004      LIKE glbc_t.glbc004,
   glbc004_desc LIKE type_t.chr500,
   glbcdocno    LIKE glbc_t.glbcdocno,
   glbcseq      LIKE glbc_t.glbcseq,
   glbc001      LIKE glbc_t.glbc001,
   glbc002      LIKE glbc_t.glbc002,
   glbc006      LIKE glbc_t.glbc006,
   glbc008      LIKE glbc_t.glbc008,
   glbc009      LIKE glbc_t.glbc009,
   glbc012      LIKE glbc_t.glbc012,
   glbc014      LIKE glbc_t.glbc014,
   l_source     LIKE type_t.chr500,
   seq1         LIKE gzcb_t.gzcb012,      #選項順序-排序用
   seq2         LIKE nmai_t.nmai004       #行序-排序用   
   ) 
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Usage..........: CALL anmq620_insert_tmp()
# Date & Author..: 150813 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq620_insert_tmp()
DEFINE l_sql    STRING
DEFINE l_start  LIKE type_t.num10
DEFINE l_end    LIKE type_t.num10
DEFINE l_tmp    RECORD 
   glbcent      LIKE glbc_t.glbcent,
   nmak002      LIKE gzcb_t.gzcb002,
   nmai003      LIKE nmai_t.nmai003,
   nmai003_desc LIKE type_t.chr500,
   glbc003      LIKE glbc_t.glbc003,
   glbc004      LIKE glbc_t.glbc004,
   glbc004_desc LIKE type_t.chr500,
   glbcdocno    LIKE glbc_t.glbcdocno,
   glbcseq      LIKE glbc_t.glbcseq,
   glbc001      LIKE glbc_t.glbc001,
   glbc002      LIKE glbc_t.glbc002,
   glbc006      LIKE glbc_t.glbc006,
   glbc008      LIKE glbc_t.glbc008,
   glbc009      LIKE glbc_t.glbc009,
   glbc012      LIKE glbc_t.glbc012,
   glbc014      LIKE glbc_t.glbc014,
   l_source     LIKE type_t.chr500,
   seq1         LIKE gzcb_t.gzcb012,     #選項順序-排序用
   seq2         LIKE nmai_t.nmai004      #行序-排序用
                END RECORD
   DELETE FROM anmq620_tmp
   LET l_start = ''
   LET l_end   = ''
   LET l_start = g_input.glbc001_start * 100 + g_input.glbc002_start
   LET l_end   = g_input.glbc001_end * 100 + g_input.glbc002_end
   LET l_sql = "SELECT glbcent,nmak002,nmai003,nmakl003,glbc003,nmai002,nmail004,glbcdocno,               ",
               "       glbcseq,glbc001,glbc002,glbc006,glbc008,glbc009,glbc012,glbc014,'',gzcb012,nmai004 ",
               "  FROM nmai_t                                                                             ",
               "       LEFT OUTER JOIN nmail_t ON nmaient = nmailent AND nmai001 = nmail001               ",
               "                     AND nmai002 = nmail002 AND nmail003 = '",g_dlang,"'                  ",
               "       ,nmak_t                                                                            ",
               "       LEFT OUTER JOIN nmakl_t ON nmakent = nmaklent AND nmak001 = nmakl001               ",
               "                     AND nmakl002 = '",g_dlang,"'                                         ",
               "       ,glbc_t,gzcb_t                                                                     ",
               " WHERE nmaient = nmakent AND nmai003 = nmak001 AND nmaient = glbcent  AND glbc010 = '2'   ",
               "   AND nmai002 = glbc004 AND gzcb002 = nmak002 AND gzcb001 = '8026' AND nmak002 <> '5'    ",
               "   AND nmai001 = '",g_glaa005,"' AND glbcld = '",g_input.glbcld,"' AND nmakstus = 'Y'     ",
               "   AND glbc015 = 'Y'                                                                      ", #151013-00016#6 add
               "   AND  glbc001 * 100 + glbc002 BETWEEN '",l_start,"' AND '",l_end,"'                     ",
               " ORDER BY gzcb012,nmai004,glbc003,nmai002                                                         "
   PREPARE anmq620_prep_s1 FROM l_sql
   DECLARE anmq620_curs_s1 CURSOR FOR anmq620_prep_s1
   FOREACH anmq620_curs_s1 INTO l_tmp.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF
      IF l_tmp.glbc003 = '2' THEN 
         LET l_tmp.glbc008 = l_tmp.glbc008 * -1
         LET l_tmp.glbc009 = l_tmp.glbc009 * -1
         LET l_tmp.glbc012 = l_tmp.glbc012 * -1
         LET l_tmp.glbc014 = l_tmp.glbc014 * -1
      END IF
      IF cl_null(l_tmp.glbc008) THEN LET l_tmp.glbc008 = 0 END IF
      IF cl_null(l_tmp.glbc009) THEN LET l_tmp.glbc009 = 0 END IF
      IF cl_null(l_tmp.glbc012) THEN LET l_tmp.glbc012 = 0 END IF
      IF cl_null(l_tmp.glbc014) THEN LET l_tmp.glbc014 = 0 END IF
      INSERT INTO anmq620_tmp VALUES(l_tmp.*)
   END FOREACH

#   LET l_sql = "INSERT INTO anmq620_tmp SELECT glbcent,nmak002,nmai003,nmakl003,glbc003,nmai002,nmail004,glbcdocno, ",
#               "       glbcseq,glbc001,glbc002,glbc008,glbc009,glbc012,glbc014,'',gzcb012,nmai004   ",
#               "  FROM nmai_t                                                               ",
#               "       LEFT OUTER JOIN nmail_t ON nmaient = nmailent AND nmai001 = nmail001 ",
#               "                     AND nmai002 = nmail002 AND nmail003 = '",g_dlang,"'    ",
#               "       ,nmak_t                                                              ",
#               "       LEFT OUTER JOIN nmakl_t ON nmakent = nmaklent AND nmak001 = nmakl001 ",
#               "                     AND nmakl002 = '",g_dlang,"'                           ",
#               "       ,glbc_t,gzcb_t                                                       ",
#               " WHERE nmaient = nmakent AND nmai003 = nmak001 AND nmaient = glbcent  AND   ",
#               "       nmai002 = glbc004 AND gzcb002 = nmak002  AND  gzcb001 = '8026' AND   ",
#               "       nmai001 = '",g_glaa005,"' AND nmak002 <> '5' AND glbc010 = '2' AND   ",
#               "       glbc001 * 100 + glbc002 BETWEEN '",l_start,"' AND '",l_end,"'        ",
#               " ORDER BY gzcb012,nmai004                                                   "
#   PREPARE anmq620_prep_s2 FROM l_sql
#   EXECUTE anmq620_prep_s2 
#   FREE    anmq620_prep_s2
   
   
END FUNCTION
################################################################################
# Descriptions...: 清空還原預設
# Memo...........: 
# Usage..........: CALL anmq620_qbe_clear()
# Date & Author..: 150811 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq620_qbe_clear()
DEFINE l_glaa003  LIKE glaa_t.glaa003
DEFINE l_glaa015  LIKE glaa_t.glaa015
DEFINE l_glaa019  LIKE glaa_t.glaa019
DEFINE l_success  LIKE type_t.num5
DEFINE l_glav006  LIKE glav_t.glav006
   #清空欄位
   CLEAR FORM
   INITIALIZE g_input.* TO NULL
   CALL g_glbc_d.clear()
   CALL g_glbc2_d.clear()
   CALL g_glbc3_d.clear()
   #給帳套預設值
   CALL s_ld_bookno()  RETURNING l_success,g_input.glbcld   
   IF l_success = FALSE THEN
      RETURN 
   END IF 
   #帶出所屬法人
   SELECT glaacomp,glaa003,glaa005,glaa015,glaa019
     INTO g_input.glbccomp,l_glaa003,g_glaa005,l_glaa015,l_glaa019
     FROM glaa_t
    WHERE glaald = g_input.glbcld AND glaaent = g_enterprise
   #顯示其他本位幣否
   IF l_glaa015 = 'Y' THEN
      CALL cl_set_comp_visible('page_2',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_2',FALSE)
   END IF
   IF l_glaa019 = 'Y' THEN
      CALL cl_set_comp_visible('page_3',TRUE)
   ELSE
      CALL cl_set_comp_visible('page_3',FALSE)
   END IF
   #預設年度-當前年度
   LET g_input.glbc001_start = YEAR(g_today)
   LET g_input.glbc001_end   = YEAR(g_today)
   #預設期別-當前期別
   SELECT glav006 INTO l_glav006 FROM glav_t
    WHERE glav001 = l_glaa003 AND glav002 = g_input.glbc001_start
      AND glav004 = g_today
      AND glavent = g_enterprise  #160905-00007#8 add
   LET g_input.glbc002_start = l_glav006
   LET g_input.glbc002_end   = l_glav006
   #帳套及法人說明
   LET g_input.glbcld_desc = s_desc_get_ld_desc(g_input.glbcld)
   LET g_input.glbccomp_desc = s_desc_get_department_desc(g_input.glbccomp) 
   
   DISPLAY BY NAME g_input.glbcld,g_input.glbcld_desc,
                   g_input.glbccomp,g_input.glbccomp_desc,
                   g_input.glbc001_start,g_input.glbc001_end,
                   g_input.glbc002_start,g_input.glbc002_end
                   
END FUNCTION

################################################################################
# Descriptions...: 檢核年度期別是否符合條件
# Memo...........:
# Usage..........: CALL anmq620_chk_glbc001_glbc002()
#                  RETURNING     r_success
# Return code....: r_success     符合(True)/不符(False)
# Date & Author..: 150813 By RayHuang
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq620_chk_glbc001_glbc002()
   IF cl_null(g_input.glbc001_start) OR cl_null(g_input.glbc001_end)
   OR cl_null(g_input.glbc002_start) OR cl_null(g_input.glbc002_end) THEN
      RETURN TRUE
   END IF
   IF g_input.glbc001_start < g_input.glbc001_end THEN
      RETURN TRUE
   ELSE
      IF g_input.glbc002_start > g_input.glbc002_end THEN
         RETURN FALSE
      END IF
   END IF
   RETURN TRUE
END FUNCTION

 
{</section>}
 
