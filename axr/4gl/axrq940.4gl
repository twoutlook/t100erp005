#該程式未解開Section, 採用最新樣板產出!
{<section id="axrq940.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-01-28 16:44:50), PR版次:0004(2016-12-06 14:22:43)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axrq940
#+ Description: 各期遞延未沖銷餘額查詢作業
#+ Creator....: 04152(2016-01-25 10:45:17)
#+ Modifier...: 04152 -SD/PR- 08729
 
{</section>}
 
{<section id="axrq940.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160811-00009#2   2016/08/17  By 01531    账务中心/法人/账套权限控管
#161021-00050#6   2016/10/26  By 08729    處理組織開窗
#161123-00048#5   2016/11/28  By 08729    開窗增加過濾據點 
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
PRIVATE TYPE type_g_xreo_d RECORD
       #statepic       LIKE type_t.chr1,
       
       xreo001 LIKE xreo_t.xreo001, 
   xreo002 LIKE xreo_t.xreo002, 
   xreodocno LIKE xreo_t.xreodocno, 
   xreoseq LIKE xreo_t.xreoseq, 
   xreold LIKE xreo_t.xreold, 
   xreold_desc LIKE type_t.chr500, 
   xreo016 LIKE xreo_t.xreo016, 
   xreo016_desc LIKE type_t.chr500, 
   xreo003 LIKE xreo_t.xreo003, 
   xreo006 LIKE xreo_t.xreo006, 
   xreo007 LIKE xreo_t.xreo007, 
   xreo004 LIKE xreo_t.xreo004, 
   xreo005 LIKE xreo_t.xreo005, 
   xreo040 LIKE xreo_t.xreo040, 
   xreo040_desc1 LIKE type_t.chr500, 
   xreo040_desc2 LIKE type_t.chr500, 
   xreo045 LIKE xreo_t.xreo045, 
   xreo045_desc LIKE type_t.chr500, 
   xreo008 LIKE xreo_t.xreo008, 
   xreo008_desc LIKE type_t.chr500, 
   xreo009 LIKE xreo_t.xreo009, 
   xreo009_desc LIKE type_t.chr500, 
   xreo100 LIKE xreo_t.xreo100, 
   xreo041 LIKE xreo_t.xreo041, 
   xreo103 LIKE xreo_t.xreo103, 
   xreo113 LIKE xreo_t.xreo113, 
   xreo123 LIKE xreo_t.xreo123, 
   xreo133 LIKE xreo_t.xreo133 
       END RECORD
PRIVATE TYPE type_g_xreo2_d RECORD
       xreold LIKE xreo_t.xreold, 
   xreold_2_desc LIKE type_t.chr500, 
   group1 LIKE type_t.chr500, 
   group1_desc LIKE type_t.chr500, 
   group1_desc2 LIKE type_t.chr500, 
   xreo100 LIKE xreo_t.xreo100, 
   xreo103 LIKE xreo_t.xreo103, 
   xreo113 LIKE xreo_t.xreo113, 
   xreo123 LIKE xreo_t.xreo123, 
   xreo133 LIKE xreo_t.xreo133, 
   mon1 LIKE type_t.num20_6, 
   mon2 LIKE type_t.num20_6, 
   mon3 LIKE type_t.num20_6, 
   mon4 LIKE type_t.num20_6, 
   mon5 LIKE type_t.num20_6, 
   mon6 LIKE type_t.num20_6, 
   mon7 LIKE type_t.num20_6, 
   mon8 LIKE type_t.num20_6, 
   mon9 LIKE type_t.num20_6, 
   mon10 LIKE type_t.num20_6, 
   mon11 LIKE type_t.num20_6, 
   mon12 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input           RECORD #單頭input
         xrepsite           LIKE xrep_t.xrepsite,
         xrepsite_desc      LIKE type_t.chr80,
         xrep001            LIKE xrep_t.xrep001,
         xrep002            LIKE xrep_t.xrep002,
         l_chk1             LIKE type_t.chr1
                         END RECORD
DEFINE g_wc_xreold       STRING
DEFINE g_sql_ctrl        STRING  #for CALL s_control_get_sql() use
DEFINE g_ls_wc           STRING
DEFINE g_xreold          LIKE xreo_t.xreold
DEFINE g_xreocomp        LIKE xreo_t.xreocomp
DEFINE g_comp            LIKE glaa_t.glaacomp  #161123-00048#5-add
DEFINE g_sql_ctrl2       STRING                #161123-00048#5-add
DEFINE g_ld              LIKE glaa_t.glaald    #161123-00048#5-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_xreo_d
DEFINE g_master_t                   type_g_xreo_d
DEFINE g_xreo_d          DYNAMIC ARRAY OF type_g_xreo_d
DEFINE g_xreo_d_t        type_g_xreo_d
DEFINE g_xreo2_d   DYNAMIC ARRAY OF type_g_xreo2_d
DEFINE g_xreo2_d_t type_g_xreo2_d
 
 
      
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
 
{<section id="axrq940.main" >}
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
   CALL cl_ap_init("axr","")
 
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
   DECLARE axrq940_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axrq940_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axrq940_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axrq940 WITH FORM cl_ap_formpath("axr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axrq940_init()   
 
      #進入選單 Menu (="N")
      CALL axrq940_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axrq940
      
   END IF 
   
   CLOSE axrq940_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axrq940.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION axrq940_init()
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
   CALL s_fin_create_account_center_tmp()
   CALL axrq940_create_tmp()
   CALL cl_set_combo_scc_part('b_xreo003','8348','1,3')  #異動類型
   #161123-00048#5-add(s)
   SELECT ooef017 INTO g_comp
     FROM ooef_t
    WHERE ooefent = g_enterprise
      AND ooef001 = g_site
      AND ooefstus = 'Y'
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_comp) RETURNING g_sub_success,g_sql_ctrl
   #161123-00048#5-add(e)
   #end add-point
 
   CALL axrq940_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="axrq940.default_search" >}
PRIVATE FUNCTION axrq940_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xreold = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xreo001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xreo002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xreodocno = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xreoseq = '", g_argv[05], "' AND "
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
 
{<section id="axrq940.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION axrq940_ui_dialog()
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
   CALL axrq940_qbe_clear()
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL axrq940_b_fill()
   ELSE
      CALL axrq940_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xreo_d.clear()
         CALL g_xreo2_d.clear()
 
 
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
 
         CALL axrq940_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_xreo_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axrq940_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL axrq940_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
         DISPLAY ARRAY g_xreo2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)  
         
            BEFORE DISPLAY 
               LET g_current_page = 2
            
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_xreo2_d.getLength() TO FORMONLY.h_count
               CALL axrq940_fetch()
               LET g_master_idx = l_ac
               #add-point:input段before row name="input.body2.before_row"
               
               #end add-point  
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axrq940_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axrq940_x01(g_wc)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axrq940_x01(g_wc)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL axrq940_query()
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
            CALL axrq940_filter()
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
            CALL axrq940_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xreo_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xreo2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
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
            CALL axrq940_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axrq940_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axrq940_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axrq940_b_fill()
 
         
         
 
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
 
{<section id="axrq940.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION axrq940_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_ld_str   STRING #160811-00009#2
   DEFINE l_glaa004  LIKE glaa_t.glaa004  #161123-00048#5-add
   DEFINE l_ooef017  LIKE ooef_t.ooef007  #161123-00048#5-add
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   #161123-00048#5-add(S)
   LET g_sql_ctrl2 = NULL
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.xrepsite
   CALL s_control_get_item_sql('2',l_ooef017,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
   #161123-00048#5-add(E)
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_xreo_d.clear()
   CALL g_xreo2_d.clear()
 
 
   
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
      CONSTRUCT g_wc_table ON xreo001,xreo002,xreodocno,xreoseq,xreold,xreo016,xreo003,xreo006,xreo007, 
          xreo004,xreo005,xreo040,xreo045,xreo008,xreo009,xreo100,xreo041,xreo103,xreo113,xreo123,xreo133 
 
           FROM s_detail1[1].b_xreo001,s_detail1[1].b_xreo002,s_detail1[1].b_xreodocno,s_detail1[1].b_xreoseq, 
               s_detail1[1].b_xreold,s_detail1[1].b_xreo016,s_detail1[1].b_xreo003,s_detail1[1].b_xreo006, 
               s_detail1[1].b_xreo007,s_detail1[1].b_xreo004,s_detail1[1].b_xreo005,s_detail1[1].b_xreo040, 
               s_detail1[1].b_xreo045,s_detail1[1].b_xreo008,s_detail1[1].b_xreo009,s_detail1[1].b_xreo100, 
               s_detail1[1].b_xreo041,s_detail1[1].b_xreo103,s_detail1[1].b_xreo113,s_detail1[1].b_xreo123, 
               s_detail1[1].b_xreo133
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_xreo001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo001
            #add-point:BEFORE FIELD b_xreo001 name="construct.b.page1.b_xreo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo001
            
            #add-point:AFTER FIELD b_xreo001 name="construct.a.page1.b_xreo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo001
            #add-point:ON ACTION controlp INFIELD b_xreo001 name="construct.c.page1.b_xreo001"
            
            #END add-point
 
 
         #----<<b_xreo002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo002
            #add-point:BEFORE FIELD b_xreo002 name="construct.b.page1.b_xreo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo002
            
            #add-point:AFTER FIELD b_xreo002 name="construct.a.page1.b_xreo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo002
            #add-point:ON ACTION controlp INFIELD b_xreo002 name="construct.c.page1.b_xreo002"
            
            #END add-point
 
 
         #----<<b_xreodocno>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreodocno
            #add-point:BEFORE FIELD b_xreodocno name="construct.b.page1.b_xreodocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreodocno
            
            #add-point:AFTER FIELD b_xreodocno name="construct.a.page1.b_xreodocno"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreodocno
            #add-point:ON ACTION controlp INFIELD b_xreodocno name="construct.c.page1.b_xreodocno"
            
            #END add-point
 
 
         #----<<b_xreoseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreoseq
            #add-point:BEFORE FIELD b_xreoseq name="construct.b.page1.b_xreoseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreoseq
            
            #add-point:AFTER FIELD b_xreoseq name="construct.a.page1.b_xreoseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreoseq
            #add-point:ON ACTION controlp INFIELD b_xreoseq name="construct.c.page1.b_xreoseq"
 
            #END add-point
 
 
         #----<<b_xreold>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreold
            #add-point:BEFORE FIELD b_xreold name="construct.b.page1.b_xreold"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreold
            
            #add-point:AFTER FIELD b_xreold name="construct.a.page1.b_xreold"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreold
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreold
            #add-point:ON ACTION controlp INFIELD b_xreold name="construct.c.page1.b_xreold"
            #帳套
            CALL s_axrt300_get_site(g_user,g_input.xrepsite,'2') RETURNING l_ld_str #160811-00009#2  
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreold  #160811-00009#2  
            LET g_qryparam.where = l_ld_str CLIPPED  #160811-00009#2  
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_xreold
            NEXT FIELD b_xreold
            #END add-point
 
 
         #----<<xreold_desc>>----
         #----<<b_xreo016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo016
            #add-point:BEFORE FIELD b_xreo016 name="construct.b.page1.b_xreo016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo016
            
            #add-point:AFTER FIELD b_xreo016 name="construct.a.page1.b_xreo016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo016
            #add-point:ON ACTION controlp INFIELD b_xreo016 name="construct.c.page1.b_xreo016"
            #帳款客戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_sql_ctrl = NULL
            CALL s_control_get_sql("apca004",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_apca005()
            DISPLAY g_qryparam.return1 TO b_xreo016
            NEXT FIELD b_xreo016
            #END add-point
 
 
         #----<<xreo016_desc>>----
         #----<<b_xreo003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo003
            #add-point:BEFORE FIELD b_xreo003 name="construct.b.page1.b_xreo003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo003
            
            #add-point:AFTER FIELD b_xreo003 name="construct.a.page1.b_xreo003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo003
            #add-point:ON ACTION controlp INFIELD b_xreo003 name="construct.c.page1.b_xreo003"
            
            #END add-point
 
 
         #----<<b_xreo006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo006
            #add-point:BEFORE FIELD b_xreo006 name="construct.b.page1.b_xreo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo006
            
            #add-point:AFTER FIELD b_xreo006 name="construct.a.page1.b_xreo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo006
            #add-point:ON ACTION controlp INFIELD b_xreo006 name="construct.c.page1.b_xreo006"
            #帳款單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xreosite = '",g_input.xrepsite,"' AND xreold IN ",g_wc_xreold
            CALL s_control_get_sql("xreo016",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            CALL q_xreo006()
            DISPLAY g_qryparam.return1 TO b_xreo006
            NEXT FIELD b_xreo006
            #END add-point
 
 
         #----<<b_xreo007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo007
            #add-point:BEFORE FIELD b_xreo007 name="construct.b.page1.b_xreo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo007
            
            #add-point:AFTER FIELD b_xreo007 name="construct.a.page1.b_xreo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo007
            #add-point:ON ACTION controlp INFIELD b_xreo007 name="construct.c.page1.b_xreo007"
            
            #END add-point
 
 
         #----<<b_xreo004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo004
            #add-point:BEFORE FIELD b_xreo004 name="construct.b.page1.b_xreo004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo004
            
            #add-point:AFTER FIELD b_xreo004 name="construct.a.page1.b_xreo004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo004
            #add-point:ON ACTION controlp INFIELD b_xreo004 name="construct.c.page1.b_xreo004"
            #交易單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xreosite = '",g_input.xrepsite,"' AND xreold IN ",g_wc_xreold
            CALL s_control_get_sql("xreo016",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            CALL q_xreo004()
            DISPLAY g_qryparam.return1 TO b_xreo004
            NEXT FIELD b_xreo004
            #END add-point
 
 
         #----<<b_xreo005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo005
            #add-point:BEFORE FIELD b_xreo005 name="construct.b.page1.b_xreo005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo005
            
            #add-point:AFTER FIELD b_xreo005 name="construct.a.page1.b_xreo005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo005
            #add-point:ON ACTION controlp INFIELD b_xreo005 name="construct.c.page1.b_xreo005"
            
            #END add-point
 
 
         #----<<b_xreo040>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo040
            #add-point:BEFORE FIELD b_xreo040 name="construct.b.page1.b_xreo040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo040
            
            #add-point:AFTER FIELD b_xreo040 name="construct.a.page1.b_xreo040"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo040
            #add-point:ON ACTION controlp INFIELD b_xreo040 name="construct.c.page1.b_xreo040"
            #產品編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_input.xrepsite #161123-00048#5 mark
            #CALL q_imaf001_22()                    #161123-00048#5 mark
            #161123-00048#5-add(S)
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where,g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
            END IF
            LET g_qryparam.arg1 = l_ooef017
            CALL q_imaf001_21()
		  	   #161123-00048#5-add(E)
            DISPLAY g_qryparam.return1 TO b_xreo040
            NEXT FIELD b_xreo040
            #END add-point
 
 
         #----<<xreo040_desc1>>----
         #----<<xreo040_desc2>>----
         #----<<b_xreo045>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo045
            #add-point:BEFORE FIELD b_xreo045 name="construct.b.page1.b_xreo045"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo045
            
            #add-point:AFTER FIELD b_xreo045 name="construct.a.page1.b_xreo045"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo045
            #add-point:ON ACTION controlp INFIELD b_xreo045 name="construct.c.page1.b_xreo045"
            #銷售分群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '295'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreo045
            NEXT FIELD b_xreo045
            #END add-point
 
 
         #----<<xreo045_desc>>----
         #----<<b_xreo008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo008
            #add-point:BEFORE FIELD b_xreo008 name="construct.b.page1.b_xreo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo008
            
            #add-point:AFTER FIELD b_xreo008 name="construct.a.page1.b_xreo008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo008
            #add-point:ON ACTION controlp INFIELD b_xreo008 name="construct.c.page1.b_xreo008"
            #攤銷類型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3116'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreo008
            NEXT FIELD b_xreo008
            #END add-point
 
 
         #----<<xreo008_desc>>----
         #----<<b_xreo009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo009
            #add-point:BEFORE FIELD b_xreo009 name="construct.b.page1.b_xreo009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo009
            
            #add-point:AFTER FIELD b_xreo009 name="construct.a.page1.b_xreo009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo009
            #add-point:ON ACTION controlp INFIELD b_xreo009 name="construct.c.page1.b_xreo009"
            #遞延科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161123-00048#5-add(S)
            #SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   #LET g_qryparam.where = g_qryparam.where,"AND glac001 = '",l_glaa004,"'"
			   SELECT ooef017 INTO g_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            SELECT glaald INTO g_ld FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = g_comp
               AND glaa014 = 'Y'  
            LET g_qryparam.where = g_qryparam.where,
                                   " AND glac002 IN (SELECT glad001 FROM glad_t,glac_t WHERE glad001= glac002 ",
                                   " AND glacent = gladent ",
                                   " AND gladld='",g_ld,"' AND gladent=",g_enterprise,
                                   " AND gladstus = 'Y' )"
            #161123-00048#5-add(E)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_xreo009
            NEXT FIELD b_xreo009
            #END add-point
 
 
         #----<<xreo009_desc>>----
         #----<<b_xreo100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo100
            #add-point:BEFORE FIELD b_xreo100 name="construct.b.page1.b_xreo100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo100
            
            #add-point:AFTER FIELD b_xreo100 name="construct.a.page1.b_xreo100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo100
            #add-point:ON ACTION controlp INFIELD b_xreo100 name="construct.c.page1.b_xreo100"
            #幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_xreo100
            NEXT FIELD b_xreo100
            #END add-point
 
 
         #----<<b_xreo041>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo041
            #add-point:BEFORE FIELD b_xreo041 name="construct.b.page1.b_xreo041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo041
            
            #add-point:AFTER FIELD b_xreo041 name="construct.a.page1.b_xreo041"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo041
            #add-point:ON ACTION controlp INFIELD b_xreo041 name="construct.c.page1.b_xreo041"
            
            #END add-point
 
 
         #----<<b_xreo103>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo103
            #add-point:BEFORE FIELD b_xreo103 name="construct.b.page1.b_xreo103"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo103
            
            #add-point:AFTER FIELD b_xreo103 name="construct.a.page1.b_xreo103"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo103
            #add-point:ON ACTION controlp INFIELD b_xreo103 name="construct.c.page1.b_xreo103"
            
            #END add-point
 
 
         #----<<b_xreo113>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo113
            #add-point:BEFORE FIELD b_xreo113 name="construct.b.page1.b_xreo113"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo113
            
            #add-point:AFTER FIELD b_xreo113 name="construct.a.page1.b_xreo113"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo113
            #add-point:ON ACTION controlp INFIELD b_xreo113 name="construct.c.page1.b_xreo113"
            
            #END add-point
 
 
         #----<<b_xreo123>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo123
            #add-point:BEFORE FIELD b_xreo123 name="construct.b.page1.b_xreo123"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo123
            
            #add-point:AFTER FIELD b_xreo123 name="construct.a.page1.b_xreo123"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo123
            #add-point:ON ACTION controlp INFIELD b_xreo123 name="construct.c.page1.b_xreo123"
            
            #END add-point
 
 
         #----<<b_xreo133>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_xreo133
            #add-point:BEFORE FIELD b_xreo133 name="construct.b.page1.b_xreo133"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_xreo133
            
            #add-point:AFTER FIELD b_xreo133 name="construct.a.page1.b_xreo133"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_xreo133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo133
            #add-point:ON ACTION controlp INFIELD b_xreo133 name="construct.c.page1.b_xreo133"
            
            #END add-point
 
 
         #----<<xreold_2_desc>>----
         #----<<group1>>----
         #----<<group1_desc>>----
         #----<<group1_desc2>>----
         #----<<mon1>>----
         #----<<mon2>>----
         #----<<mon3>>----
         #----<<mon4>>----
         #----<<mon5>>----
         #----<<mon6>>----
         #----<<mon7>>----
         #----<<mon8>>----
         #----<<mon9>>----
         #----<<mon10>>----
         #----<<mon11>>----
         #----<<mon12>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      INPUT BY NAME g_input.xrepsite,g_input.xrepsite_desc,g_input.xrep001,g_input.xrep002,g_input.l_chk1
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         AFTER FIELD xrepsite
            LET g_input.xrepsite_desc = ''
            IF NOT cl_null(g_input.xrepsite) THEN
               CALL s_fin_account_center_with_ld_chk(g_input.xrepsite,'',g_user,'3','N','',g_today) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               #取得帳務中心底下的帳套範圍
               CALL s_fin_account_center_sons_query('3',g_input.xrepsite,g_today,'1')
               CALL s_fin_account_center_ld_str() RETURNING g_wc_xreold
               CALL s_fin_get_wc_str(g_wc_xreold) RETURNING g_wc_xreold
               LET g_input.xrepsite_desc = s_desc_get_department_desc(g_input.xrepsite)
               DISPLAY BY NAME g_input.xrepsite_desc
            END IF
         
         AFTER FIELD xrep001
            IF NOT cl_ap_chk_range(g_input.xrep001,"0","0","2099","1","azz-00087",1) THEN
               LET g_input.xrep001 = ""
               NEXT FIELD xrep001
            END IF 
         
         AFTER FIELD xrep002
            IF NOT cl_ap_chk_range(g_input.xrep002,"0","0","13","1","azz-00087",1) THEN
               LET g_input.xrep002 = ""
               NEXT FIELD xrep002
            END IF
         
         ON ACTION controlp INFIELD xrepsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.xrepsite
            #LET g_qryparam.where = " ooef201 = 'Y' " #160811-00009#2  
            #CALL q_ooef001()                         #161021-00050#6 mark
            CALL q_ooef001_46()                       #161021-00050#6 add
            LET g_input.xrepsite = g_qryparam.return1
            CALL s_desc_get_department_desc(g_input.xrepsite) RETURNING g_input.xrepsite_desc
            DISPLAY BY NAME g_input.xrepsite,g_input.xrepsite_desc
            NEXT FIELD xrepsite
         
         ON CHANGE l_chk1
            CALL cl_set_comp_visible('group1,group1_desc,group1_desc2',TRUE)
            IF g_input.l_chk1 <> 3 THEN
               CALL cl_set_comp_visible('group1_desc2',FALSE)
            END IF
      
      END INPUT
      
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         CALL axrq940_qbe_clear()
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
         CALL axrq940_qbe_clear()
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
   CALL axrq940_b_fill()
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
 
{<section id="axrq940.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axrq940_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_ld_str         STRING  #160811-00009#2   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL axrq940_insert_tmp()
   
   #160811-00009#2   Add  ---(S)---
   CALL s_axrt300_get_site(g_user,g_input.xrepsite,'2') RETURNING l_ld_str
   LET l_ld_str = cl_replace_str(l_ld_str,"glaald","xreold")
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF   
   LET g_wc = g_wc," AND ",l_ld_str
   #160811-00009#2   Add  ---(E)---   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE xreo001,xreo002,xreodocno,xreoseq,xreold,'',xreo016,'',xreo003, 
       xreo006,xreo007,xreo004,xreo005,xreo040,'','',xreo045,'',xreo008,'',xreo009,'',xreo100,xreo041, 
       xreo103,xreo113,xreo123,xreo133,'','','','','','','','','','','','','','','','','','','','','', 
       ''  ,DENSE_RANK() OVER( ORDER BY xreo_t.xreold,xreo_t.xreo001,xreo_t.xreo002,xreo_t.xreodocno, 
       xreo_t.xreoseq) AS RANK FROM xreo_t",
 
 
                     "",
                     " WHERE xreoent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreo_t"),
                     " ORDER BY xreo_t.xreold,xreo_t.xreo001,xreo_t.xreo002,xreo_t.xreodocno,xreo_t.xreoseq"
 
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
 
   LET g_sql = "SELECT xreo001,xreo002,xreodocno,xreoseq,xreold,'',xreo016,'',xreo003,xreo006,xreo007, 
       xreo004,xreo005,xreo040,'','',xreo045,'',xreo008,'',xreo009,'',xreo100,xreo041,xreo103,xreo113, 
       xreo123,xreo133,'','','','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_ls_wc = ls_wc #為了彙總頁籤也要用
   LET g_sql = "SELECT UNIQUE xreo001,xreo002,xreodocno,xreoseq,xreold,",
               "              '',xreo016,'',xreo003,xreo006,",
               "              xreo007,xreo004,xreo005,xreo040,'',",
               "              '',xreo045,'',xreo008,'',",
               "              xreo009,'',xreo100,xreo041,xreo103,",
               "              xreo113,xreo123,xreo133,'','',",
               "              '','','','','',",
               "              '','','','','',",
               "              '','','','','',",
               "              '','',",
               " DENSE_RANK() OVER(ORDER BY xreold,xreo001,xreo002,xreodocno,xreoseq) AS RANK",
               "  FROM axrq940_tmp",
               " WHERE xreoent= ? AND 1=1 AND ", ls_wc,cl_sql_add_filter("xreo_t"),
               " ORDER BY xreold,xreo001,xreo002,xreodocno,xreoseq"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axrq940_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axrq940_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_xreo_d.clear()
   CALL g_xreo2_d.clear()   
 
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_xreo_d[l_ac].xreo001,g_xreo_d[l_ac].xreo002,g_xreo_d[l_ac].xreodocno,g_xreo_d[l_ac].xreoseq, 
       g_xreo_d[l_ac].xreold,g_xreo_d[l_ac].xreold_desc,g_xreo_d[l_ac].xreo016,g_xreo_d[l_ac].xreo016_desc, 
       g_xreo_d[l_ac].xreo003,g_xreo_d[l_ac].xreo006,g_xreo_d[l_ac].xreo007,g_xreo_d[l_ac].xreo004,g_xreo_d[l_ac].xreo005, 
       g_xreo_d[l_ac].xreo040,g_xreo_d[l_ac].xreo040_desc1,g_xreo_d[l_ac].xreo040_desc2,g_xreo_d[l_ac].xreo045, 
       g_xreo_d[l_ac].xreo045_desc,g_xreo_d[l_ac].xreo008,g_xreo_d[l_ac].xreo008_desc,g_xreo_d[l_ac].xreo009, 
       g_xreo_d[l_ac].xreo009_desc,g_xreo_d[l_ac].xreo100,g_xreo_d[l_ac].xreo041,g_xreo_d[l_ac].xreo103, 
       g_xreo_d[l_ac].xreo113,g_xreo_d[l_ac].xreo123,g_xreo_d[l_ac].xreo133,g_xreo2_d[l_ac].xreold,g_xreo2_d[l_ac].xreold_2_desc, 
       g_xreo2_d[l_ac].group1,g_xreo2_d[l_ac].group1_desc,g_xreo2_d[l_ac].group1_desc2,g_xreo2_d[l_ac].xreo100, 
       g_xreo2_d[l_ac].xreo103,g_xreo2_d[l_ac].xreo113,g_xreo2_d[l_ac].xreo123,g_xreo2_d[l_ac].xreo133, 
       g_xreo2_d[l_ac].mon1,g_xreo2_d[l_ac].mon2,g_xreo2_d[l_ac].mon3,g_xreo2_d[l_ac].mon4,g_xreo2_d[l_ac].mon5, 
       g_xreo2_d[l_ac].mon6,g_xreo2_d[l_ac].mon7,g_xreo2_d[l_ac].mon8,g_xreo2_d[l_ac].mon9,g_xreo2_d[l_ac].mon10, 
       g_xreo2_d[l_ac].mon11,g_xreo2_d[l_ac].mon12
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_xreo_d[l_ac].statepic = cl_get_actipic(g_xreo_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #帳套
      CALL s_desc_get_ld_desc(g_xreo_d[l_ac].xreold) RETURNING g_xreo_d[l_ac].xreold_desc
      
      #帳款客戶
      CALL s_desc_get_trading_partner_abbr_desc(g_xreo_d[l_ac].xreo016)RETURNING g_xreo_d[l_ac].xreo016_desc 
      
      #品名/規格
      CALL s_desc_get_item_desc(g_xreo_d[l_ac].xreo040) RETURNING g_xreo_d[l_ac].xreo040_desc1,g_xreo_d[l_ac].xreo040_desc2
      
      #銷售分群
      CALL s_desc_get_acc_desc('295',g_xreo_d[l_ac].xreo045) RETURNING g_xreo_d[l_ac].xreo045_desc
      
      #攤銷類型
      CALL s_desc_get_acc_desc('3116',g_xreo_d[l_ac].xreo008) RETURNING g_xreo_d[l_ac].xreo008_desc
      
      #遞延科目
      CALL s_desc_get_account_desc(g_xreo_d[l_ac].xreold,g_xreo_d[l_ac].xreo009) RETURNING g_xreo_d[l_ac].xreo009_desc
      #end add-point
 
      CALL axrq940_detail_show("'1'")      
 
      CALL axrq940_xreo_t_mask()
 
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
   
 
   
   CALL g_xreo_d.deleteElement(g_xreo_d.getLength())   
   CALL g_xreo2_d.deleteElement(g_xreo2_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   CALL axrq940_b_fill2()
   #end add-point
 
   LET g_detail_cnt = g_xreo_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE axrq940_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axrq940_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axrq940_detail_action_trans()
 
   IF g_xreo_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL axrq940_fetch()
   END IF
   
      CALL axrq940_filter_show('xreo001','b_xreo001')
   CALL axrq940_filter_show('xreo002','b_xreo002')
   CALL axrq940_filter_show('xreodocno','b_xreodocno')
   CALL axrq940_filter_show('xreoseq','b_xreoseq')
   CALL axrq940_filter_show('xreold','b_xreold')
   CALL axrq940_filter_show('xreo016','b_xreo016')
   CALL axrq940_filter_show('xreo003','b_xreo003')
   CALL axrq940_filter_show('xreo006','b_xreo006')
   CALL axrq940_filter_show('xreo007','b_xreo007')
   CALL axrq940_filter_show('xreo004','b_xreo004')
   CALL axrq940_filter_show('xreo005','b_xreo005')
   CALL axrq940_filter_show('xreo040','b_xreo040')
   CALL axrq940_filter_show('xreo045','b_xreo045')
   CALL axrq940_filter_show('xreo008','b_xreo008')
   CALL axrq940_filter_show('xreo009','b_xreo009')
   CALL axrq940_filter_show('xreo100','b_xreo100')
   CALL axrq940_filter_show('xreo041','b_xreo041')
   CALL axrq940_filter_show('xreo103','b_xreo103')
   CALL axrq940_filter_show('xreo113','b_xreo113')
   CALL axrq940_filter_show('xreo123','b_xreo123')
   CALL axrq940_filter_show('xreo133','b_xreo133')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axrq940_fetch()
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
 
{<section id="axrq940.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axrq940_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION axrq940_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_ooef017    LIKE ooef_t.ooef017   #161123-00048#5-add
   DEFINE l_glaa004    LIKE glaa_t.glaa004   #161123-00048#5-add
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   #161123-00048#5-add(S)
   LET g_sql_ctrl2 = NULL
   SELECT ooef017 INTO l_ooef017 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_input.xrepsite
   CALL s_control_get_item_sql('2',l_ooef017,g_user,g_dept,'') RETURNING g_sub_success,g_sql_ctrl2
   #161123-00048#5-add(E)
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
      CONSTRUCT g_wc_filter ON xreo001,xreo002,xreodocno,xreoseq,xreold,xreo016,xreo003,xreo006,xreo007, 
          xreo004,xreo005,xreo040,xreo045,xreo008,xreo009,xreo100,xreo041,xreo103,xreo113,xreo123,xreo133 
 
                          FROM s_detail1[1].b_xreo001,s_detail1[1].b_xreo002,s_detail1[1].b_xreodocno, 
                              s_detail1[1].b_xreoseq,s_detail1[1].b_xreold,s_detail1[1].b_xreo016,s_detail1[1].b_xreo003, 
                              s_detail1[1].b_xreo006,s_detail1[1].b_xreo007,s_detail1[1].b_xreo004,s_detail1[1].b_xreo005, 
                              s_detail1[1].b_xreo040,s_detail1[1].b_xreo045,s_detail1[1].b_xreo008,s_detail1[1].b_xreo009, 
                              s_detail1[1].b_xreo100,s_detail1[1].b_xreo041,s_detail1[1].b_xreo103,s_detail1[1].b_xreo113, 
                              s_detail1[1].b_xreo123,s_detail1[1].b_xreo133
 
         BEFORE CONSTRUCT
                     DISPLAY axrq940_filter_parser('xreo001') TO s_detail1[1].b_xreo001
            DISPLAY axrq940_filter_parser('xreo002') TO s_detail1[1].b_xreo002
            DISPLAY axrq940_filter_parser('xreodocno') TO s_detail1[1].b_xreodocno
            DISPLAY axrq940_filter_parser('xreoseq') TO s_detail1[1].b_xreoseq
            DISPLAY axrq940_filter_parser('xreold') TO s_detail1[1].b_xreold
            DISPLAY axrq940_filter_parser('xreo016') TO s_detail1[1].b_xreo016
            DISPLAY axrq940_filter_parser('xreo003') TO s_detail1[1].b_xreo003
            DISPLAY axrq940_filter_parser('xreo006') TO s_detail1[1].b_xreo006
            DISPLAY axrq940_filter_parser('xreo007') TO s_detail1[1].b_xreo007
            DISPLAY axrq940_filter_parser('xreo004') TO s_detail1[1].b_xreo004
            DISPLAY axrq940_filter_parser('xreo005') TO s_detail1[1].b_xreo005
            DISPLAY axrq940_filter_parser('xreo040') TO s_detail1[1].b_xreo040
            DISPLAY axrq940_filter_parser('xreo045') TO s_detail1[1].b_xreo045
            DISPLAY axrq940_filter_parser('xreo008') TO s_detail1[1].b_xreo008
            DISPLAY axrq940_filter_parser('xreo009') TO s_detail1[1].b_xreo009
            DISPLAY axrq940_filter_parser('xreo100') TO s_detail1[1].b_xreo100
            DISPLAY axrq940_filter_parser('xreo041') TO s_detail1[1].b_xreo041
            DISPLAY axrq940_filter_parser('xreo103') TO s_detail1[1].b_xreo103
            DISPLAY axrq940_filter_parser('xreo113') TO s_detail1[1].b_xreo113
            DISPLAY axrq940_filter_parser('xreo123') TO s_detail1[1].b_xreo123
            DISPLAY axrq940_filter_parser('xreo133') TO s_detail1[1].b_xreo133
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_xreo001>>----
         #Ctrlp:construct.c.filter.page1.b_xreo001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo001
            #add-point:ON ACTION controlp INFIELD b_xreo001 name="construct.c.filter.page1.b_xreo001"
            
            #END add-point
 
 
         #----<<b_xreo002>>----
         #Ctrlp:construct.c.filter.page1.b_xreo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo002
            #add-point:ON ACTION controlp INFIELD b_xreo002 name="construct.c.filter.page1.b_xreo002"
            
            #END add-point
 
 
         #----<<b_xreodocno>>----
         #Ctrlp:construct.c.filter.page1.b_xreodocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreodocno
            #add-point:ON ACTION controlp INFIELD b_xreodocno name="construct.c.filter.page1.b_xreodocno"
            
            #END add-point
 
 
         #----<<b_xreoseq>>----
         #Ctrlp:construct.c.filter.page1.b_xreoseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreoseq
            #add-point:ON ACTION controlp INFIELD b_xreoseq name="construct.c.filter.page1.b_xreoseq"
            
            #END add-point
 
 
         #----<<b_xreold>>----
         #Ctrlp:construct.c.filter.page1.b_xreold
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreold
            #add-point:ON ACTION controlp INFIELD b_xreold name="construct.c.filter.page1.b_xreold"
            #帳套
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaald IN ",g_wc_xreold
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            CALL q_authorised_ld()
            DISPLAY g_qryparam.return1 TO b_xreold
            NEXT FIELD b_xreold
            #END add-point
 
 
         #----<<xreold_desc>>----
         #----<<b_xreo016>>----
         #Ctrlp:construct.c.filter.page1.b_xreo016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo016
            #add-point:ON ACTION controlp INFIELD b_xreo016 name="construct.c.filter.page1.b_xreo016"
            #帳款客戶
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_sql_ctrl = NULL
            CALL s_control_get_sql("apca004",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_sql_ctrl
            END IF
            CALL q_apca005()
            DISPLAY g_qryparam.return1 TO b_xreo016
            NEXT FIELD b_xreo016
            #END add-point
 
 
         #----<<xreo016_desc>>----
         #----<<b_xreo003>>----
         #Ctrlp:construct.c.filter.page1.b_xreo003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo003
            #add-point:ON ACTION controlp INFIELD b_xreo003 name="construct.c.filter.page1.b_xreo003"
            
            #END add-point
 
 
         #----<<b_xreo006>>----
         #Ctrlp:construct.c.filter.page1.b_xreo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo006
            #add-point:ON ACTION controlp INFIELD b_xreo006 name="construct.c.filter.page1.b_xreo006"
            #帳款單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xreosite = '",g_input.xrepsite,"' AND xreold IN ",g_wc_xreold
            CALL s_control_get_sql("xreo016",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            CALL q_xreo006()
            DISPLAY g_qryparam.return1 TO b_xreo006
            NEXT FIELD b_xreo006
            #END add-point
 
 
         #----<<b_xreo007>>----
         #Ctrlp:construct.c.filter.page1.b_xreo007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo007
            #add-point:ON ACTION controlp INFIELD b_xreo007 name="construct.c.filter.page1.b_xreo007"
            
            #END add-point
 
 
         #----<<b_xreo004>>----
         #Ctrlp:construct.c.filter.page1.b_xreo004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo004
            #add-point:ON ACTION controlp INFIELD b_xreo004 name="construct.c.filter.page1.b_xreo004"
            #交易單號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " xreosite = '",g_input.xrepsite,"' AND xreold IN ",g_wc_xreold
            CALL s_control_get_sql("xreo016",'2','2',g_user,g_dept) RETURNING g_sub_success,g_sql_ctrl
            IF NOT cl_null(g_sql_ctrl) THEN
               LET g_qryparam.where = g_qryparam.where," AND ",g_sql_ctrl
            END IF
            CALL q_xreo004()
            DISPLAY g_qryparam.return1 TO b_xreo004
            NEXT FIELD b_xreo004
            #END add-point
 
 
         #----<<b_xreo005>>----
         #Ctrlp:construct.c.filter.page1.b_xreo005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo005
            #add-point:ON ACTION controlp INFIELD b_xreo005 name="construct.c.filter.page1.b_xreo005"
            
            #END add-point
 
 
         #----<<b_xreo040>>----
         #Ctrlp:construct.c.filter.page1.b_xreo040
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo040
            #add-point:ON ACTION controlp INFIELD b_xreo040 name="construct.c.filter.page1.b_xreo040"
            #產品編號
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            #LET g_qryparam.arg1 = g_input.xrepsite #161123-00048#5 mark
            #CALL q_imaf001_22()                    #161123-00048#5 mark
            #161123-00048#5-add(S)
            IF NOT cl_null(g_sql_ctrl2) AND NOT g_sql_ctrl2 = ' 1=1'  THEN
               LET g_qryparam.where = g_qryparam.where,g_sql_ctrl2," AND imafsite = '",l_ooef017,"'"
            END IF
            LET g_qryparam.arg1 = l_ooef017
            CALL q_imaf001_21()
		  	   #161123-00048#5-add(E)
            DISPLAY g_qryparam.return1 TO b_xreo040
            NEXT FIELD b_xreo040
            #END add-point
 
 
         #----<<xreo040_desc1>>----
         #----<<xreo040_desc2>>----
         #----<<b_xreo045>>----
         #Ctrlp:construct.c.filter.page1.b_xreo045
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo045
            #add-point:ON ACTION controlp INFIELD b_xreo045 name="construct.c.filter.page1.b_xreo045"
            #銷售分群
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '295'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreo045
            NEXT FIELD b_xreo045
            #END add-point
 
 
         #----<<xreo045_desc>>----
         #----<<b_xreo008>>----
         #Ctrlp:construct.c.filter.page1.b_xreo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo008
            #add-point:ON ACTION controlp INFIELD b_xreo008 name="construct.c.filter.page1.b_xreo008"
            #攤銷類型
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '3116'
            CALL q_oocq002()
            DISPLAY g_qryparam.return1 TO b_xreo008
            NEXT FIELD b_xreo008
            #END add-point
 
 
         #----<<xreo008_desc>>----
         #----<<b_xreo009>>----
         #Ctrlp:construct.c.filter.page1.b_xreo009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo009
            #add-point:ON ACTION controlp INFIELD b_xreo009 name="construct.c.filter.page1.b_xreo009"
            #遞延科目
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = "glac003 <>'1' " #非統制科目
            #161123-00048#5-add(S)
            SELECT glaa004 INTO l_glaa004 FROM glaa_t WHERE glaaent = g_enterprise AND glaacomp = l_ooef017 AND glaa014 = 'Y'
			   LET g_qryparam.where = g_qryparam.where,"AND glac001 = '",l_glaa004,"'"
            #161123-00048#5-add(E)
            CALL aglt310_04()
            DISPLAY g_qryparam.return1 TO b_xreo009
            NEXT FIELD b_xreo009
            #END add-point
 
 
         #----<<xreo009_desc>>----
         #----<<b_xreo100>>----
         #Ctrlp:construct.c.filter.page1.b_xreo100
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo100
            #add-point:ON ACTION controlp INFIELD b_xreo100 name="construct.c.filter.page1.b_xreo100"
            #幣別
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooai001()
            DISPLAY g_qryparam.return1 TO b_xreo100
            NEXT FIELD b_xreo100
            #END add-point
 
 
         #----<<b_xreo041>>----
         #Ctrlp:construct.c.filter.page1.b_xreo041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo041
            #add-point:ON ACTION controlp INFIELD b_xreo041 name="construct.c.filter.page1.b_xreo041"
            
            #END add-point
 
 
         #----<<b_xreo103>>----
         #Ctrlp:construct.c.filter.page1.b_xreo103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo103
            #add-point:ON ACTION controlp INFIELD b_xreo103 name="construct.c.filter.page1.b_xreo103"
            
            #END add-point
 
 
         #----<<b_xreo113>>----
         #Ctrlp:construct.c.filter.page1.b_xreo113
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo113
            #add-point:ON ACTION controlp INFIELD b_xreo113 name="construct.c.filter.page1.b_xreo113"
            
            #END add-point
 
 
         #----<<b_xreo123>>----
         #Ctrlp:construct.c.filter.page1.b_xreo123
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo123
            #add-point:ON ACTION controlp INFIELD b_xreo123 name="construct.c.filter.page1.b_xreo123"
            
            #END add-point
 
 
         #----<<b_xreo133>>----
         #Ctrlp:construct.c.filter.page1.b_xreo133
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreo133
            #add-point:ON ACTION controlp INFIELD b_xreo133 name="construct.c.filter.page1.b_xreo133"
            
            #END add-point
 
 
         #----<<xreold_2_desc>>----
         #----<<group1>>----
         #----<<group1_desc>>----
         #----<<group1_desc2>>----
         #----<<mon1>>----
         #----<<mon2>>----
         #----<<mon3>>----
         #----<<mon4>>----
         #----<<mon5>>----
         #----<<mon6>>----
         #----<<mon7>>----
         #----<<mon8>>----
         #----<<mon9>>----
         #----<<mon10>>----
         #----<<mon11>>----
         #----<<mon12>>----
   
 
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
   
      CALL axrq940_filter_show('xreo001','b_xreo001')
   CALL axrq940_filter_show('xreo002','b_xreo002')
   CALL axrq940_filter_show('xreodocno','b_xreodocno')
   CALL axrq940_filter_show('xreoseq','b_xreoseq')
   CALL axrq940_filter_show('xreold','b_xreold')
   CALL axrq940_filter_show('xreo016','b_xreo016')
   CALL axrq940_filter_show('xreo003','b_xreo003')
   CALL axrq940_filter_show('xreo006','b_xreo006')
   CALL axrq940_filter_show('xreo007','b_xreo007')
   CALL axrq940_filter_show('xreo004','b_xreo004')
   CALL axrq940_filter_show('xreo005','b_xreo005')
   CALL axrq940_filter_show('xreo040','b_xreo040')
   CALL axrq940_filter_show('xreo045','b_xreo045')
   CALL axrq940_filter_show('xreo008','b_xreo008')
   CALL axrq940_filter_show('xreo009','b_xreo009')
   CALL axrq940_filter_show('xreo100','b_xreo100')
   CALL axrq940_filter_show('xreo041','b_xreo041')
   CALL axrq940_filter_show('xreo103','b_xreo103')
   CALL axrq940_filter_show('xreo113','b_xreo113')
   CALL axrq940_filter_show('xreo123','b_xreo123')
   CALL axrq940_filter_show('xreo133','b_xreo133')
 
    
   CALL axrq940_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION axrq940_filter_parser(ps_field)
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
 
{<section id="axrq940.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION axrq940_filter_show(ps_field,ps_object)
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
   LET ls_condition = axrq940_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.insert" >}
#+ insert
PRIVATE FUNCTION axrq940_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axrq940.modify" >}
#+ modify
PRIVATE FUNCTION axrq940_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.reproduce" >}
#+ reproduce
PRIVATE FUNCTION axrq940_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.delete" >}
#+ delete
PRIVATE FUNCTION axrq940_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="axrq940.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axrq940_detail_action_trans()
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
 
{<section id="axrq940.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axrq940_detail_index_setting()
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
            IF g_xreo_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xreo_d.getLength() AND g_xreo_d.getLength() > 0
            LET g_detail_idx = g_xreo_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xreo_d.getLength() THEN
               LET g_detail_idx = g_xreo_d.getLength()
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
 
{<section id="axrq940.mask_functions" >}
 &include "erp/axr/axrq940_mask.4gl"
 
{</section>}
 
{<section id="axrq940.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 清空&給預設
# Memo...........:
# Usage..........: CALL axrq940_qbe_clear()
# Date & Author..: 2016/01/25 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq940_qbe_clear()
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   
   #CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING g_sub_success,g_input.xrepsite,g_errno
   #帳務組織/帳套/法人預設
   CALL s_aap_get_default_apcasite('','','')RETURNING g_sub_success,g_errno,g_input.xrepsite,g_xreold,g_xreocomp
   CALL s_control_get_customer_sql_pmab('4',g_site,g_user,g_dept,'',g_xreocomp) RETURNING g_sub_success,g_sql_ctrl #161123-00048#5-add
   IF NOT cl_null(g_input.xrepsite) THEN
      CALL s_desc_get_department_desc(g_input.xrepsite) RETURNING g_input.xrepsite_desc
      CALL s_fin_account_center_sons_query('3',g_input.xrepsite,g_today,'')
      #取得帳務中心底下的帳套範圍   
      CALL s_fin_account_center_ld_str() RETURNING g_wc_xreold
      CALL s_fin_get_wc_str(g_wc_xreold) RETURNING g_wc_xreold
      DISPLAY BY NAME g_input.xrepsite_desc
   END IF
   
   LET g_input.xrep001 = YEAR(g_today)
   LET g_input.xrep002 = MONTH(g_today)
   LET g_input.l_chk1 = '1'
   CALL cl_set_comp_visible('group1_desc2',FALSE)
   
   DISPLAY BY NAME g_input.xrep001,g_input.xrep002,g_input.l_chk1
   
   LET g_xreo_d[1].xreold = ''
   DISPLAY ARRAY g_xreo_d TO s_detail1.*
      BEFORE DISPLAY
         EXIT DISPLAY
   END DISPLAY
END FUNCTION

################################################################################
# Descriptions...: 建立tmp table
# Memo...........:
# Usage..........: CALL axrq940_create_tmp()
# Date & Author..: 2016/01/27 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq940_create_tmp()

   DROP TABLE axrq940_tmp;
   CREATE TEMP TABLE axrq940_tmp(
         xreoent     LIKE xreo_t.xreoent,
         xreosite    LIKE xreo_t.xreosite,
         xreo001     LIKE xreo_t.xreo001,
         xreo002     LIKE xreo_t.xreo002,
         xreodocno   LIKE xreo_t.xreodocno,
         xreoseq     LIKE xreo_t.xreoseq,
         xreold      LIKE xreo_t.xreold,
         xreo016     LIKE xreo_t.xreo016,
         xreo003     LIKE xreo_t.xreo003,
         xreo006     LIKE xreo_t.xreo006,
         xreo007     LIKE xreo_t.xreo007,
         xreo004     LIKE xreo_t.xreo004,
         xreo005     LIKE xreo_t.xreo005,
         xreo040     LIKE xreo_t.xreo040,
         xreo045     LIKE xreo_t.xreo045,
         xreo008     LIKE xreo_t.xreo008,
         xreo009     LIKE xreo_t.xreo009,
         xreo100     LIKE xreo_t.xreo100,
         xreo041     LIKE xreo_t.xreo041,
         xreo103     LIKE xreo_t.xreo103,
         xreo113     LIKE xreo_t.xreo113,
         xreo123     LIKE xreo_t.xreo123,
         xreo133     LIKE xreo_t.xreo133
         )
END FUNCTION

################################################################################
# Descriptions...: 撈取來源資料寫入tmp
# Memo...........:
# Usage..........: CALL axrq940_insert_tmp()
# Date & Author..: 2016/01/27 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq940_insert_tmp()
DEFINE l_ctrl_xreo016    STRING
   
   DELETE FROM axrq940_tmp
   
   #取得aooi380控制組條件
   CALL s_control_get_sql("xreo016",'2','2',g_user,g_dept) RETURNING g_sub_success,l_ctrl_xreo016
   IF cl_null(l_ctrl_xreo016) THEN LET l_ctrl_xreo016 = " 1=1" END IF
   
   LET g_sql = "INSERT INTO axrq940_tmp ",
               "   SELECT xreoent,xreosite,xreo001,xreo002,xreodocno,",
               "          xreoseq,xreold,xreo016,xreo003,xreo006,",
               "          xreo007,xreo004,xreo005,xreo040,xreo045,",
               "          xreo008,xreo009,xreo100,xreo041,xreo103,",
               "          xreo113,xreo123,xreo133",
               "     FROM xreo_t",
               "    WHERE xreoent = ",g_enterprise,
               "      AND xreosite = '",g_input.xrepsite,"'",
               "      AND xreold IN ",g_wc_xreold,
               "      AND xreo001 = ",g_input.xrep001,
               "      AND xreo002 = ",g_input.xrep002,
               "      AND xreo003 IN ('1','3')",
               "      AND ",l_ctrl_xreo016,
               "    ORDER BY xreold,xreo001,xreo002,xreodocno,xreoseq"
   PREPARE axrq940_ins_tmp FROM g_sql
   EXECUTE axrq940_ins_tmp
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

################################################################################
# Descriptions...: 彙總資訊顯示
# Memo...........:
# Usage..........: CALL axrq940_b_fill2()
# Date & Author..: 2016/01/26 By Reanna
# Modify.........:
################################################################################
PRIVATE FUNCTION axrq940_b_fill2()
DEFINE l_glaa003       LIKE glaa_t.glaa003
DEFINE l_mon           LIKE type_t.chr10
DEFINE l_year          LIKE type_t.chr10
DEFINE l_count         LIKE type_t.num5
DEFINE l_xreo001       LIKE xreo_t.xreo001
DEFINE l_xreo002       LIKE xreo_t.xreo002
DEFINE l_title         LIKE type_t.chr100
DEFINE l_tital_desc    LIKE type_t.chr100
DEFINE l_tital_desc2   LIKE type_t.chr100
DEFINE l_strdate       LIKE xreo_t.xreo007
DEFINE l_enddate       LIKE xreo_t.xreo007
DEFINE l_group         LIKE type_t.chr100
DEFINE l_xreo          DYNAMIC ARRAY OF RECORD
          xreo103         LIKE xreo_t.xreo113  #各區間的本幣$
                       END RECORD
   
   CALL g_xreo2_d.clear()

   #組欄位是?年?月
   CALL cl_getmsg('agl-00274',g_dlang) RETURNING l_year
   CALL cl_getmsg('aoo-00215',g_dlang) RETURNING l_mon
   FOR l_count = 1 TO 12 step +1
      IF l_count > 1 THEN
         #往回推年月
         CALL s_fin_date_get_last_period('',g_xreold,l_xreo001,l_xreo002)
              RETURNING g_sub_success,l_xreo001,l_xreo002
      ELSE
         #當期年月
         LET l_xreo001 = g_input.xrep001
         LET l_xreo002 = g_input.xrep002
      END IF
      LET l_title = l_xreo001||l_year||l_xreo002||l_mon
      CALL cl_set_comp_att_text('mon'||l_count,l_title)
      #LET g_xg_fieldname[l_i] = l_title
      #LET l_i = l_i-1
   END FOR
   
   CASE
      WHEN g_input.l_chk1 = 1  #1.依帳款客戶
         LET l_group = "xreo016"
      WHEN g_input.l_chk1 = 2  #2.依銷售分群
         LET l_group = "xreo045"
      WHEN g_input.l_chk1 = 3  #3.依產品代碼
         LET l_group = "xreo040"
      WHEN g_input.l_chk1 = 4  #4.依遞延科目
         LET l_group = "xreo009"
   END CASE
   
   LET g_sql = "SELECT xreold,xreo100,",l_group,",",
               "       SUM(xreo103),SUM(xreo113),SUM(xreo123),SUM(xreo133)",
               "  FROM axrq940_tmp",
               " WHERE ",g_ls_wc,
               " GROUP BY xreosite,xreold,xreo100,",l_group,
               " ORDER BY xreosite,xreold,xreo100,",l_group
   
   LET l_ac = 1
   
   #往前推各月帳款日期本幣所在區間
   PREPARE axrq940_sel_pb FROM g_sql
   DECLARE axrq940_sel_cs CURSOR FOR axrq940_sel_pb
   FOREACH axrq940_sel_cs INTO g_xreo2_d[l_ac].xreold,g_xreo2_d[l_ac].xreo100,g_xreo2_d[l_ac].group1,
                               g_xreo2_d[l_ac].xreo103,g_xreo2_d[l_ac].xreo113,g_xreo2_d[l_ac].xreo123,
                               g_xreo2_d[l_ac].xreo133
      
      #帳套
      CALL s_desc_get_ld_desc(g_xreo2_d[l_ac].xreold) RETURNING g_xreo2_d[l_ac].xreold_2_desc
      
      #依group條件顯示欄位
      CASE
         WHEN g_input.l_chk1 = 1  #1.依帳款客戶
            CALL s_desc_get_trading_partner_abbr_desc(g_xreo2_d[l_ac].group1) RETURNING g_xreo2_d[l_ac].group1_desc
            SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_xreo016' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
            SELECT gzzd005 INTO l_tital_desc FROM gzzd_t WHERE gzzd003 = 'lbl_xreo016_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
         WHEN g_input.l_chk1 = 2  #2.依銷售分群
            CALL s_desc_get_acc_desc('295',g_xreo2_d[l_ac].group1) RETURNING g_xreo2_d[l_ac].group1_desc
            SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_xreo045' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
            SELECT gzzd005 INTO l_tital_desc FROM gzzd_t WHERE gzzd003 = 'lbl_xreo045_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
         WHEN g_input.l_chk1 = 3  #3.依產品代碼
            CALL s_desc_get_item_desc(g_xreo2_d[l_ac].group1) RETURNING g_xreo2_d[l_ac].group1_desc,g_xreo2_d[l_ac].group1_desc2
            SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_xreo040' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
            SELECT gzzd005 INTO l_tital_desc FROM gzzd_t WHERE gzzd003 = 'lbl_xreo040_desc1' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
            SELECT gzzd005 INTO l_tital_desc2 FROM gzzd_t WHERE gzzd003 = 'lbl_xreo040_desc2' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
         WHEN g_input.l_chk1 = 4  #4.依遞延科目
            CALL s_desc_get_account_desc(g_xreo2_d[l_ac].xreold,g_xreo2_d[l_ac].group1) RETURNING g_xreo2_d[l_ac].group1_desc
            SELECT gzzd005 INTO l_title FROM gzzd_t WHERE gzzd003 = 'lbl_xreo009' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
            SELECT gzzd005 INTO l_tital_desc FROM gzzd_t WHERE gzzd003 = 'lbl_xreo009_desc' AND gzzd002 = g_dlang AND gzzd001 = 'axrq940'
      END CASE
      CALL cl_set_comp_att_text('group1',l_title)
      CALL cl_set_comp_att_text('group1_desc',l_tital_desc)
      CALL cl_set_comp_att_text('group1_desc2',l_tital_desc2)
      
      FOR l_count = 1 TO 12 step +1
         IF l_count > 1 THEN
            #往回推年月
            CALL s_fin_date_get_last_period('',g_xreold,l_xreo001,l_xreo002)
                 RETURNING g_sub_success,l_xreo001,l_xreo002
         ELSE
            #當期年月
            LET l_xreo001 = g_input.xrep001
            LET l_xreo002 = g_input.xrep002
         END IF
         #取得會計週期參照表
         CALL s_ld_sel_glaa(g_xreo2_d[l_ac].xreold,'glaa003') RETURNING g_sub_success,l_glaa003
         CALL s_fin_date_get_period_range(l_glaa003,l_xreo001,l_xreo002)RETURNING l_strdate,l_enddate
         
         IF l_count = 12 THEN
            LET g_sql = "SELECT SUM(xreo103)",
                        "  FROM axrq940_tmp",
                        " WHERE xreold = '",g_xreo2_d[l_ac].xreold,"' ",
                        "   AND xreo100 = '",g_xreo2_d[l_ac].xreo100,"'",
                        "   AND xreo007 <= '",l_enddate,"'",
                        "   AND ",l_group," = '",g_xreo2_d[l_ac].group1,"'",
                        "   AND ",g_ls_wc
            PREPARE axrq940_sel_pb2 FROM g_sql
            EXECUTE axrq940_sel_pb2 INTO l_xreo[12].xreo103
            IF cl_null(l_xreo[12].xreo103) THEN LET l_xreo[12].xreo103 = 0 END IF
         ELSE
            LET g_sql = "SELECT SUM(xreo103)",
                        "  FROM axrq940_tmp",
                        " WHERE xreold = '",g_xreo2_d[l_ac].xreold,"' ",
                        "   AND xreo100 = '",g_xreo2_d[l_ac].xreo100,"'",
                        "   AND xreo007 BETWEEN '",l_strdate,"' AND '",l_enddate,"' ",
                        "   AND ",l_group," = '",g_xreo2_d[l_ac].group1,"'",
                        "   AND ",g_ls_wc
            PREPARE axrq940_sel_pb3 FROM g_sql
            EXECUTE axrq940_sel_pb3 INTO l_xreo[l_count].xreo103
            IF cl_null(l_xreo[l_count].xreo103) THEN LET l_xreo[l_count].xreo103 = 0 END IF
         END IF
      END FOR
      
      LET g_xreo2_d[l_ac].mon1  = l_xreo[1].xreo103
      LET g_xreo2_d[l_ac].mon2  = l_xreo[2].xreo103
      LET g_xreo2_d[l_ac].mon3  = l_xreo[3].xreo103
      LET g_xreo2_d[l_ac].mon4  = l_xreo[4].xreo103
      LET g_xreo2_d[l_ac].mon5  = l_xreo[5].xreo103
      LET g_xreo2_d[l_ac].mon6  = l_xreo[6].xreo103
      LET g_xreo2_d[l_ac].mon7  = l_xreo[7].xreo103
      LET g_xreo2_d[l_ac].mon8  = l_xreo[8].xreo103
      LET g_xreo2_d[l_ac].mon9  = l_xreo[9].xreo103
      LET g_xreo2_d[l_ac].mon10 = l_xreo[10].xreo103
      LET g_xreo2_d[l_ac].mon11 = l_xreo[11].xreo103
      LET g_xreo2_d[l_ac].mon12 = l_xreo[12].xreo103
      
      LET l_ac = l_ac + 1   
   END FOREACH
END FUNCTION

 
{</section>}
 
