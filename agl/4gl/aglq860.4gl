#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq860.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-11-27 14:27:08), PR版次:0001(2016-09-23 17:42:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000007
#+ Filename...: aglq860
#+ Description: 財務分析資料查詢
#+ Creator....: 02114(2015-11-23 09:52:38)
#+ Modifier...: 02114 -SD/PR- 02114
 
{</section>}
 
{<section id="aglq860.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160321-00016#30  160325 By Jessy      修正azzi920重複定義之錯誤訊息
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
PRIVATE TYPE type_g_glfe_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   glfe001 LIKE glfe_t.glfe001, 
   glfeseq LIKE glfe_t.glfeseq, 
   glfe003 LIKE glfe_t.glfe003, 
   glfe004 LIKE glfe_t.glfe004, 
   glfel003 LIKE type_t.chr500, 
   glfel004 LIKE type_t.chr500, 
   glfe005 LIKE glfe_t.glfe005, 
   glfe006 LIKE glfe_t.glfe006, 
   glfe007 LIKE glfe_t.glfe007, 
   glfe012 LIKE glfe_t.glfe012, 
   glfe013 LIKE glfe_t.glfe013, 
   glfe014 LIKE glfe_t.glfe014, 
   glfe015 LIKE glfe_t.glfe015, 
   glfe016 LIKE glfe_t.glfe016, 
   tot00 LIKE type_t.num20_6, 
   tot01 LIKE type_t.num20_6, 
   tot02 LIKE type_t.num20_6, 
   tot03 LIKE type_t.num20_6, 
   tot04 LIKE type_t.num20_6, 
   tot05 LIKE type_t.num20_6, 
   tot06 LIKE type_t.num20_6, 
   tot07 LIKE type_t.num20_6, 
   tot08 LIKE type_t.num20_6, 
   tot09 LIKE type_t.num20_6, 
   tot10 LIKE type_t.num20_6, 
   tot11 LIKE type_t.num20_6, 
   tot12 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE
     tm       RECORD
              glaald             LIKE glaa_t.glaald,
              glaald_desc        LIKE type_t.chr80,
              curr_type          LIKE type_t.chr1,
              glaa001            LIKE glaa_t.glaa001,
              glfd001            LIKE glfd_t.glfd001,
              glfd001_desc       LIKE type_t.chr80,
              type               LIKE type_t.chr1,
              b_y                LIKE type_t.num5,
              e_y                LIKE type_t.num5,
              b_m                LIKE type_t.num5,
              e_m                LIKE type_t.num5,
              b_q                LIKE type_t.num5,
              e_q                LIKE type_t.num5,
              
              yy00               LIKE type_t.num5,    #年度            
              yy01               LIKE type_t.num5, 
              yy02               LIKE type_t.num5,
              yy03               LIKE type_t.num5,
              yy04               LIKE type_t.num5,
              yy05               LIKE type_t.num5,
              yy06               LIKE type_t.num5,
              yy07               LIKE type_t.num5,
              yy08               LIKE type_t.num5,
              yy09               LIKE type_t.num5,
              yy10               LIKE type_t.num5,
              yy11               LIKE type_t.num5,
              yy12               LIKE type_t.num5,
                                 
              b_mm00             LIKE type_t.num5,  #起始期别       
              b_mm01             LIKE type_t.num5,
              b_mm02             LIKE type_t.num5,
              b_mm03             LIKE type_t.num5,
              b_mm04             LIKE type_t.num5,
              b_mm05             LIKE type_t.num5,
              b_mm06             LIKE type_t.num5,
              b_mm07             LIKE type_t.num5,
              b_mm08             LIKE type_t.num5,
              b_mm09             LIKE type_t.num5,
              b_mm10             LIKE type_t.num5,
              b_mm11             LIKE type_t.num5,
              b_mm12             LIKE type_t.num5,
                                 
              e_mm00             LIKE type_t.num5,  #截至期别  
              e_mm01             LIKE type_t.num5,
              e_mm02             LIKE type_t.num5,
              e_mm03             LIKE type_t.num5,
              e_mm04             LIKE type_t.num5,
              e_mm05             LIKE type_t.num5,
              e_mm06             LIKE type_t.num5,
              e_mm07             LIKE type_t.num5,
              e_mm08             LIKE type_t.num5,
              e_mm09             LIKE type_t.num5,
              e_mm10             LIKE type_t.num5,
              e_mm11             LIKE type_t.num5,
              e_mm12             LIKE type_t.num5
        END RECORD
        
DEFINE PI                           FLOAT
DEFINE g_chr1                       LIKE type_t.chr1 
DEFINE g_max                        LIKE type_t.num20_6
DEFINE g_min                        LIKE type_t.num20_6
DEFINE g_n                          LIKE type_t.num10
DEFINE g_l_i                        LIKE type_t.num10
DEFINE g_draw_x,g_draw_y,g_draw_dx,g_draw_dy,
       g_draw_width,g_draw_multiple LIKE type_t.num10 
DEFINE g_hx                         DYNAMIC ARRAY OF type_g_glfe_d
DEFINE g_yb_m1                      LIKE type_t.chr10
DEFINE g_pi                         LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_glfe_d
DEFINE g_master_t                   type_g_glfe_d
DEFINE g_glfe_d          DYNAMIC ARRAY OF type_g_glfe_d
DEFINE g_glfe_d_t        type_g_glfe_d
 
      
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
 
{<section id="aglq860.main" >}
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
   DECLARE aglq860_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq860_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   DROP TABLE x_tmp
    CREATE TABLE x_tmp(
      x_q DEC(20,6)
      ) 
    DROP TABLE ffa_tmp
    SELECT glfc001 FROM glfc_t WHERE 1 = 0 INTO TEMP ffa_tmp  
    SELECT asin(0.5)*6 INTO PI FROM DUAL
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq860_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq860 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq860_init()   
 
      #進入選單 Menu (="N")
      CALL aglq860_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq860
      
   END IF 
   
   CLOSE aglq860_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq860.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION aglq860_init()
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
   CALL cl_set_combo_scc('curr_type','9997')
   CALL cl_set_combo_scc('type','8047')
   CALL s_fin_create_account_center_tmp()
   #end add-point
 
   CALL aglq860_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="aglq860.default_search" >}
PRIVATE FUNCTION aglq860_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfe001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfeseq = '", g_argv[02], "' AND "
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
 
{<section id="aglq860.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION aglq860_ui_dialog()
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
   CALL cl_set_toolbaritem_visible("show", FALSE)
   CALL cl_set_toolbaritem_visible("hide", TRUE)
   CALL cl_set_comp_visible("lbl_group2",TRUE)
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL aglq860_b_fill()
   ELSE
      CALL aglq860_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfe_d.clear()
 
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
 
         CALL aglq860_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_glfe_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq860_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL aglq860_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL aglq860_b_fill2()
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
            CALL aglq860_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL aglq860_insert()
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
               CALL aglq860_query()
               #add-point:ON ACTION query name="menu.query"
               CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION show
            LET g_action_choice="show"
            IF cl_auth_chk_act("show") THEN
               
               #add-point:ON ACTION show name="menu.show"
               CALL cl_set_toolbaritem_visible("show", FALSE)
               CALL cl_set_toolbaritem_visible("hide", TRUE)
               CALL cl_set_comp_visible("lbl_group2",TRUE)
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
         ON ACTION hide
            LET g_action_choice="hide"
            IF cl_auth_chk_act("hide") THEN
               
               #add-point:ON ACTION hide name="menu.hide"
               CALL cl_set_toolbaritem_visible("show", TRUE)
               CALL cl_set_toolbaritem_visible("hide", FALSE)
               CALL cl_set_comp_visible("lbl_group2",FALSE)
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq860_filter()
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
            CALL aglq860_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_glfe_d)
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
            CALL aglq860_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq860_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq860_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq860_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_glfe_d.getLength()
               LET g_glfe_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_glfe_d.getLength()
               LET g_glfe_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_glfe_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfe_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_glfe_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_glfe_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION cva
            CALL aglq860_b_fill3('1')
            
         ON ACTION cvb
            CALL aglq860_b_fill3('2')
          
         ON ACTION cvc
            CALL aglq860_b_fill3('3')
           
         ON ACTION cvd
            CALL aglq860_b_fill3('4') 
            
         ON ACTION cve
            CALL aglq860_b_pic()
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
 
{<section id="aglq860.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION aglq860_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   CALL aglq860_query1()
   RETURN
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfe_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON glfe001,glfeseq,glfe003,glfe004,glfe005,glfe006,glfe007,glfe012,glfe013, 
          glfe014,glfe015,glfe016
           FROM s_detail1[1].b_glfe001,s_detail1[1].b_glfeseq,s_detail1[1].b_glfe003,s_detail1[1].b_glfe004, 
               s_detail1[1].b_glfe005,s_detail1[1].b_glfe006,s_detail1[1].b_glfe007,s_detail1[1].b_glfe012, 
               s_detail1[1].b_glfe013,s_detail1[1].b_glfe014,s_detail1[1].b_glfe015,s_detail1[1].b_glfe016 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_glfe001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe001
            #add-point:BEFORE FIELD b_glfe001 name="construct.b.page1.b_glfe001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe001
            
            #add-point:AFTER FIELD b_glfe001 name="construct.a.page1.b_glfe001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe001
            #add-point:ON ACTION controlp INFIELD b_glfe001 name="construct.c.page1.b_glfe001"
            
            #END add-point
 
 
         #----<<b_glfeseq>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfeseq
            #add-point:BEFORE FIELD b_glfeseq name="construct.b.page1.b_glfeseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfeseq
            
            #add-point:AFTER FIELD b_glfeseq name="construct.a.page1.b_glfeseq"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfeseq
            #add-point:ON ACTION controlp INFIELD b_glfeseq name="construct.c.page1.b_glfeseq"
            
            #END add-point
 
 
         #----<<b_glfe003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe003
            #add-point:BEFORE FIELD b_glfe003 name="construct.b.page1.b_glfe003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe003
            
            #add-point:AFTER FIELD b_glfe003 name="construct.a.page1.b_glfe003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe003
            #add-point:ON ACTION controlp INFIELD b_glfe003 name="construct.c.page1.b_glfe003"
            
            #END add-point
 
 
         #----<<b_glfe004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe004
            #add-point:BEFORE FIELD b_glfe004 name="construct.b.page1.b_glfe004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe004
            
            #add-point:AFTER FIELD b_glfe004 name="construct.a.page1.b_glfe004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe004
            #add-point:ON ACTION controlp INFIELD b_glfe004 name="construct.c.page1.b_glfe004"
            
            #END add-point
 
 
         #----<<glfel003>>----
         #----<<glfel004>>----
         #----<<b_glfe005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe005
            #add-point:BEFORE FIELD b_glfe005 name="construct.b.page1.b_glfe005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe005
            
            #add-point:AFTER FIELD b_glfe005 name="construct.a.page1.b_glfe005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe005
            #add-point:ON ACTION controlp INFIELD b_glfe005 name="construct.c.page1.b_glfe005"
            
            #END add-point
 
 
         #----<<b_glfe006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe006
            #add-point:BEFORE FIELD b_glfe006 name="construct.b.page1.b_glfe006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe006
            
            #add-point:AFTER FIELD b_glfe006 name="construct.a.page1.b_glfe006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe006
            #add-point:ON ACTION controlp INFIELD b_glfe006 name="construct.c.page1.b_glfe006"
            
            #END add-point
 
 
         #----<<b_glfe007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe007
            #add-point:BEFORE FIELD b_glfe007 name="construct.b.page1.b_glfe007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe007
            
            #add-point:AFTER FIELD b_glfe007 name="construct.a.page1.b_glfe007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe007
            #add-point:ON ACTION controlp INFIELD b_glfe007 name="construct.c.page1.b_glfe007"
            
            #END add-point
 
 
         #----<<b_glfe012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe012
            #add-point:BEFORE FIELD b_glfe012 name="construct.b.page1.b_glfe012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe012
            
            #add-point:AFTER FIELD b_glfe012 name="construct.a.page1.b_glfe012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe012
            #add-point:ON ACTION controlp INFIELD b_glfe012 name="construct.c.page1.b_glfe012"
            
            #END add-point
 
 
         #----<<b_glfe013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe013
            #add-point:BEFORE FIELD b_glfe013 name="construct.b.page1.b_glfe013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe013
            
            #add-point:AFTER FIELD b_glfe013 name="construct.a.page1.b_glfe013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe013
            #add-point:ON ACTION controlp INFIELD b_glfe013 name="construct.c.page1.b_glfe013"
            
            #END add-point
 
 
         #----<<b_glfe014>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe014
            #add-point:BEFORE FIELD b_glfe014 name="construct.b.page1.b_glfe014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe014
            
            #add-point:AFTER FIELD b_glfe014 name="construct.a.page1.b_glfe014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe014
            #add-point:ON ACTION controlp INFIELD b_glfe014 name="construct.c.page1.b_glfe014"
            
            #END add-point
 
 
         #----<<b_glfe015>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe015
            #add-point:BEFORE FIELD b_glfe015 name="construct.b.page1.b_glfe015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe015
            
            #add-point:AFTER FIELD b_glfe015 name="construct.a.page1.b_glfe015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe015
            #add-point:ON ACTION controlp INFIELD b_glfe015 name="construct.c.page1.b_glfe015"
            
            #END add-point
 
 
         #----<<b_glfe016>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_glfe016
            #add-point:BEFORE FIELD b_glfe016 name="construct.b.page1.b_glfe016"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_glfe016
            
            #add-point:AFTER FIELD b_glfe016 name="construct.a.page1.b_glfe016"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_glfe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe016
            #add-point:ON ACTION controlp INFIELD b_glfe016 name="construct.c.page1.b_glfe016"
            
            #END add-point
 
 
         #----<<tot00>>----
         #----<<tot01>>----
         #----<<tot02>>----
         #----<<tot03>>----
         #----<<tot04>>----
         #----<<tot05>>----
         #----<<tot06>>----
         #----<<tot07>>----
         #----<<tot08>>----
         #----<<tot09>>----
         #----<<tot10>>----
         #----<<tot11>>----
         #----<<tot12>>----
   
       
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
   CALL aglq860_b_fill()
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
 
{<section id="aglq860.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq860_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_yy            LIKE type_t.num5
   DEFINE l_b_mm          LIKE type_t.num5
   DEFINE l_e_mm          LIKE type_t.num5
   DEFINE l_amount        LIKE type_t.num20_6
   DEFINE l_flag          LIKE type_t.num5
   DEFINE l_flag_00       LIKE type_t.chr1
   DEFINE l_flag_01       LIKE type_t.chr1
   DEFINE l_flag_02       LIKE type_t.chr1
   DEFINE l_flag_03       LIKE type_t.chr1
   DEFINE l_flag_04       LIKE type_t.chr1
   DEFINE l_flag_05       LIKE type_t.chr1
   DEFINE l_flag_06       LIKE type_t.chr1
   DEFINE l_flag_07       LIKE type_t.chr1
   DEFINE l_flag_08       LIKE type_t.chr1
   DEFINE l_flag_09       LIKE type_t.chr1
   DEFINE l_flag_10       LIKE type_t.chr1
   DEFINE l_flag_11       LIKE type_t.chr1
   DEFINE l_flag_12       LIKE type_t.chr1
   DEFINE l_msg00         STRING
   DEFINE l_msg01         STRING
   DEFINE l_msg02         STRING
   DEFINE l_msg03         STRING
   DEFINE l_msg04         STRING
   DEFINE l_msg05         STRING
   DEFINE l_msg06         STRING
   DEFINE l_msg07         STRING
   DEFINE l_msg08         STRING
   DEFINE l_msg09         STRING
   DEFINE l_msg10         STRING
   DEFINE l_msg11         STRING
   DEFINE l_msg12         STRING
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET g_chr1 = 'N'
   CALL cl_err_collect_init()
   #获取单身哪些期别需要抓取及显示
   #PS:可借由是否显示进行字段隐藏处理
   LET l_flag_00 = 'Y'   
   LET l_flag_01 = 'Y'
   LET l_flag_02 = 'Y'
   LET l_flag_03 = 'Y'
   LET l_flag_04 = 'Y'
   LET l_flag_05 = 'Y'
   LET l_flag_06 = 'Y'
   LET l_flag_07 = 'Y'
   LET l_flag_08 = 'Y'
   LET l_flag_09 = 'Y'
   LET l_flag_10 = 'Y'
   LET l_flag_11 = 'Y'
   LET l_flag_12 = 'Y'
   
   LET l_msg00 = tm.yy00 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm00 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg01 = tm.yy01 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm01 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg02 = tm.yy02 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm02 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg03 = tm.yy03 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm03 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg04 = tm.yy04 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm04 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg05 = tm.yy05 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm05 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg06 = tm.yy06 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm06 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg07 = tm.yy07 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm07 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg08 = tm.yy08 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm08 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg09 = tm.yy09 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm09 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg10 = tm.yy10 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm10 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg11 = tm.yy11 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm11 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   LET l_msg12 = tm.yy12 CLIPPED,cl_getmsg('axc-00588',g_dlang) CLIPPED,tm.b_mm12 USING "<<<<<",cl_getmsg('axc-00589',g_dlang)
   CALL cl_set_comp_att_text('tot00',l_msg00)
   CALL cl_set_comp_att_text('tot01',l_msg01)
   CALL cl_set_comp_att_text('tot02',l_msg02)
   CALL cl_set_comp_att_text('tot03',l_msg03)
   CALL cl_set_comp_att_text('tot04',l_msg04)
   CALL cl_set_comp_att_text('tot05',l_msg05)
   CALL cl_set_comp_att_text('tot06',l_msg06)
   CALL cl_set_comp_att_text('tot07',l_msg07)
   CALL cl_set_comp_att_text('tot08',l_msg08)
   CALL cl_set_comp_att_text('tot09',l_msg09)
   CALL cl_set_comp_att_text('tot10',l_msg10)
   CALL cl_set_comp_att_text('tot11',l_msg11)
   CALL cl_set_comp_att_text('tot12',l_msg12)

   IF cl_null(tm.yy00) AND cl_null(tm.b_mm00) AND cl_null(tm.e_mm00) THEN
      LET l_flag_00 = 'N'
   END IF

   IF cl_null(tm.yy01) AND cl_null(tm.b_mm01) AND cl_null(tm.e_mm01) THEN
      LET l_flag_01 = 'N'
   END IF

   IF cl_null(tm.yy02) AND cl_null(tm.b_mm02) AND cl_null(tm.e_mm02) THEN
      LET l_flag_02 = 'N'
   END IF

   IF cl_null(tm.yy03) AND cl_null(tm.b_mm03) AND cl_null(tm.e_mm03) THEN
      LET l_flag_03 = 'N'
   END IF

   IF cl_null(tm.yy04) AND cl_null(tm.b_mm04) AND cl_null(tm.e_mm04) THEN
      LET l_flag_04 = 'N'
   END IF

   IF cl_null(tm.yy05) AND cl_null(tm.b_mm05) AND cl_null(tm.e_mm05) THEN
      LET l_flag_05 = 'N'
   END IF

   IF cl_null(tm.yy06) AND cl_null(tm.b_mm06) AND cl_null(tm.e_mm06) THEN
      LET l_flag_06 = 'N'
   END IF

   IF cl_null(tm.yy07) AND cl_null(tm.b_mm07) AND cl_null(tm.e_mm07) THEN
      LET l_flag_07 = 'N'
   END IF

   IF cl_null(tm.yy08) AND cl_null(tm.b_mm08) AND cl_null(tm.e_mm08) THEN
      LET l_flag_08 = 'N'
   END IF

   IF cl_null(tm.yy09) AND cl_null(tm.b_mm09) AND cl_null(tm.e_mm09) THEN
      LET l_flag_09 = 'N'
   END IF

   IF cl_null(tm.yy10) AND cl_null(tm.b_mm10) AND cl_null(tm.e_mm10) THEN
      LET l_flag_10 = 'N'
   END IF

   IF cl_null(tm.yy11) AND cl_null(tm.b_mm11) AND cl_null(tm.e_mm11) THEN
      LET l_flag_11 = 'N'
   END IF

   IF cl_null(tm.yy12) AND cl_null(tm.b_mm12) AND cl_null(tm.e_mm12) THEN
      LET l_flag_12 = 'N'
   END IF
   
   IF l_flag_00 = 'N'   THEN  CALL cl_set_comp_visible("tot00",FALSE )    END IF

   IF l_flag_01 = 'N'   THEN  CALL cl_set_comp_visible("tot01",FALSE )    END IF

   IF l_flag_02 = 'N'   THEN  CALL cl_set_comp_visible("tot02" ,FALSE )   END IF

   IF l_flag_03 = 'N'   THEN  CALL cl_set_comp_visible("tot03" ,FALSE )   END IF

   IF l_flag_04 = 'N'   THEN  CALL cl_set_comp_visible("tot04" ,FALSE )   END IF

   IF l_flag_05 = 'N'   THEN  CALL cl_set_comp_visible("tot05" ,FALSE )   END IF

   IF l_flag_06 = 'N'   THEN  CALL cl_set_comp_visible("tot06" ,FALSE )   END IF

   IF l_flag_07 = 'N'   THEN  CALL cl_set_comp_visible("tot07" ,FALSE )   END IF

   IF l_flag_08 = 'N'   THEN  CALL cl_set_comp_visible("tot08" ,FALSE )   END IF

   IF l_flag_09 = 'N'   THEN  CALL cl_set_comp_visible("tot09" ,FALSE )   END IF

   IF l_flag_10 = 'N'   THEN  CALL cl_set_comp_visible("tot10" ,FALSE )   END IF

   IF l_flag_11 = 'N'   THEN  CALL cl_set_comp_visible("tot11" ,FALSE )   END IF

   IF l_flag_12 = 'N'   THEN  CALL cl_set_comp_visible("tot12" ,FALSE )   END IF
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',glfe001,glfeseq,glfe003,glfe004,'','',glfe005,glfe006,glfe007, 
       glfe012,glfe013,glfe014,glfe015,glfe016,'','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glfe_t.glfe001, 
       glfe_t.glfeseq) AS RANK FROM glfe_t",
 
 
                     "",
                     " WHERE glfeent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfe_t"),
                     " ORDER BY glfe_t.glfe001,glfe_t.glfeseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT  UNIQUE '',glfe001,glfeseq,glfe003,glfe004,'','',glfe005,glfe006,glfe007,glfe012,glfe013,glfe014, 
                     glfe015,glfe016,'','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glfe_t.glfe001, 
                     glfe_t.glfeseq) AS RANK FROM glfe_t",
                     " WHERE glfeent= ? AND glfe003 <> '3' AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfe_t"),
                     " ORDER BY glfe_t.glfe001,glfe_t.glfeseq"
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
 
   LET g_sql = "SELECT '',glfe001,glfeseq,glfe003,glfe004,'','',glfe005,glfe006,glfe007,glfe012,glfe013, 
       glfe014,glfe015,glfe016,'','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq860_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq860_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_glfe_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_glfe_d[l_ac].sel,g_glfe_d[l_ac].glfe001,g_glfe_d[l_ac].glfeseq,g_glfe_d[l_ac].glfe003, 
       g_glfe_d[l_ac].glfe004,g_glfe_d[l_ac].glfel003,g_glfe_d[l_ac].glfel004,g_glfe_d[l_ac].glfe005, 
       g_glfe_d[l_ac].glfe006,g_glfe_d[l_ac].glfe007,g_glfe_d[l_ac].glfe012,g_glfe_d[l_ac].glfe013,g_glfe_d[l_ac].glfe014, 
       g_glfe_d[l_ac].glfe015,g_glfe_d[l_ac].glfe016,g_glfe_d[l_ac].tot00,g_glfe_d[l_ac].tot01,g_glfe_d[l_ac].tot02, 
       g_glfe_d[l_ac].tot03,g_glfe_d[l_ac].tot04,g_glfe_d[l_ac].tot05,g_glfe_d[l_ac].tot06,g_glfe_d[l_ac].tot07, 
       g_glfe_d[l_ac].tot08,g_glfe_d[l_ac].tot09,g_glfe_d[l_ac].tot10,g_glfe_d[l_ac].tot11,g_glfe_d[l_ac].tot12 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_glfe_d[l_ac].statepic = cl_get_actipic(g_glfe_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT glfel003,glfel004 INTO g_glfe_d[l_ac].glfel003,g_glfe_d[l_ac].glfel004
        FROM glfel_t
       WHERE glfelent = g_enterprise
         AND glfel001 = g_glfe_d[l_ac].glfe004
         AND glfelseq = g_glfe_d[l_ac].glfeseq
         AND glfel002 = g_dlang
      
      LET g_chr1 = 'Y' 
      #若数据来源<>'1,则本行仅显示指标名称/指标说明
      IF g_glfe_d[l_ac].glfe003 = '1' THEN
         #对单身的12期做循环
         FOR l_flag = 0 TO 12
            #上期
            IF l_flag = 0 THEN
               IF l_flag_00 = 'N' THEN
                  CONTINUE FOR
               END IF
               
               CALL s_analy_form(tm.glaald,tm.yy00,tm.b_mm00,tm.e_mm00,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot00
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot00,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot00 
            END IF
         
            #第一期
            IF l_flag = 1 THEN
               IF l_flag_01 = 'N' THEN
                  CONTINUE FOR
               END IF
               
               CALL s_analy_form(tm.glaald,tm.yy01,tm.b_mm01,tm.e_mm01,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot01
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot01,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot01   
            END IF
            #第二期
            IF l_flag = 2 THEN
               IF l_flag_02 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy02,tm.b_mm02,tm.e_mm02,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot02
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot02,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot02 
            END IF
            #第三期
            IF l_flag = 3 THEN
               IF l_flag_03 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy03,tm.b_mm03,tm.e_mm03,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot03
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot03,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot03
            END IF
            #第四期
            IF l_flag = 4 THEN
               IF l_flag_04 = 'N' THEN
                  CONTINUE FOR
               END IF
  
               CALL s_analy_form(tm.glaald,tm.yy04,tm.b_mm04,tm.e_mm04,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot04
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot04,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot04 
            END IF
            #第五期
            IF l_flag = 5 THEN
               IF l_flag_05 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy05,tm.b_mm05,tm.e_mm05,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot05
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot05,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot05
            END IF
            #第六期
            IF l_flag = 6 THEN
               IF l_flag_06 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy06,tm.b_mm06,tm.e_mm06,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot06
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot06,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot06 
            END IF
            #第七期
            IF l_flag = 7 THEN
               IF l_flag_07 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy07,tm.b_mm07,tm.e_mm07,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot07
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot07,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot07
            END IF
            #第八期
            IF l_flag = 8 THEN
               IF l_flag_08 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy08,tm.b_mm08,tm.e_mm08,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot08
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot08,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot08 
            END IF
            #第九期
            IF l_flag = 9 THEN
               IF l_flag_09 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy09,tm.b_mm09,tm.e_mm09,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot09
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot09,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot09
            END IF
            #第十期
            IF l_flag = 10 THEN
               IF l_flag_10 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy10,tm.b_mm10,tm.e_mm10,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot10
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot10,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot10
            END IF
            #第十一期
            IF l_flag = 11 THEN
               IF l_flag_11 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy11,tm.b_mm11,tm.e_mm11,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot11
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot10,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot11
            END IF
            #第十二期
            IF l_flag = 12 THEN
               IF l_flag_12 = 'N' THEN
                  CONTINUE FOR
               END IF

               CALL s_analy_form(tm.glaald,tm.yy12,tm.b_mm12,tm.e_mm12,g_glfe_d[l_ac].glfe007,'1',
                                 g_glfe_d[l_ac].glfe001,'2',g_glfe_d[l_ac].glfe005,'','','')
               RETURNING l_success,g_glfe_d[l_ac].tot12
               
               CALL aglq860_dis_form(g_glfe_d[l_ac].tot12,g_glfe_d[l_ac].glfe006)
               RETURNING g_glfe_d[l_ac].tot12
            END IF
         END FOR
      END IF
      #end add-point
 
      CALL aglq860_detail_show("'1'")      
 
      CALL aglq860_glfe_t_mask()
 
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
   
 
   
   CALL g_glfe_d.deleteElement(g_glfe_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_glfe_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE aglq860_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq860_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq860_detail_action_trans()
 
   IF g_glfe_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL aglq860_fetch()
   END IF
   
      CALL aglq860_filter_show('glfe001','b_glfe001')
   CALL aglq860_filter_show('glfeseq','b_glfeseq')
   CALL aglq860_filter_show('glfe003','b_glfe003')
   CALL aglq860_filter_show('glfe004','b_glfe004')
   CALL aglq860_filter_show('glfe005','b_glfe005')
   CALL aglq860_filter_show('glfe006','b_glfe006')
   CALL aglq860_filter_show('glfe007','b_glfe007')
   CALL aglq860_filter_show('glfe012','b_glfe012')
   CALL aglq860_filter_show('glfe013','b_glfe013')
   CALL aglq860_filter_show('glfe014','b_glfe014')
   CALL aglq860_filter_show('glfe015','b_glfe015')
   CALL aglq860_filter_show('glfe016','b_glfe016')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   CALL cl_err_collect_show()
   CALL aglq860_b_fill2()   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq860_fetch()
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
 
{<section id="aglq860.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq860_detail_show(ps_page)
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
 
{<section id="aglq860.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION aglq860_filter()
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
      CONSTRUCT g_wc_filter ON glfe001,glfeseq,glfe003,glfe004,glfe005,glfe006,glfe007,glfe012,glfe013, 
          glfe014,glfe015,glfe016
                          FROM s_detail1[1].b_glfe001,s_detail1[1].b_glfeseq,s_detail1[1].b_glfe003, 
                              s_detail1[1].b_glfe004,s_detail1[1].b_glfe005,s_detail1[1].b_glfe006,s_detail1[1].b_glfe007, 
                              s_detail1[1].b_glfe012,s_detail1[1].b_glfe013,s_detail1[1].b_glfe014,s_detail1[1].b_glfe015, 
                              s_detail1[1].b_glfe016
 
         BEFORE CONSTRUCT
                     DISPLAY aglq860_filter_parser('glfe001') TO s_detail1[1].b_glfe001
            DISPLAY aglq860_filter_parser('glfeseq') TO s_detail1[1].b_glfeseq
            DISPLAY aglq860_filter_parser('glfe003') TO s_detail1[1].b_glfe003
            DISPLAY aglq860_filter_parser('glfe004') TO s_detail1[1].b_glfe004
            DISPLAY aglq860_filter_parser('glfe005') TO s_detail1[1].b_glfe005
            DISPLAY aglq860_filter_parser('glfe006') TO s_detail1[1].b_glfe006
            DISPLAY aglq860_filter_parser('glfe007') TO s_detail1[1].b_glfe007
            DISPLAY aglq860_filter_parser('glfe012') TO s_detail1[1].b_glfe012
            DISPLAY aglq860_filter_parser('glfe013') TO s_detail1[1].b_glfe013
            DISPLAY aglq860_filter_parser('glfe014') TO s_detail1[1].b_glfe014
            DISPLAY aglq860_filter_parser('glfe015') TO s_detail1[1].b_glfe015
            DISPLAY aglq860_filter_parser('glfe016') TO s_detail1[1].b_glfe016
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfe001>>----
         #Ctrlp:construct.c.filter.page1.b_glfe001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe001
            #add-point:ON ACTION controlp INFIELD b_glfe001 name="construct.c.filter.page1.b_glfe001"
            
            #END add-point
 
 
         #----<<b_glfeseq>>----
         #Ctrlp:construct.c.filter.page1.b_glfeseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfeseq
            #add-point:ON ACTION controlp INFIELD b_glfeseq name="construct.c.filter.page1.b_glfeseq"
            
            #END add-point
 
 
         #----<<b_glfe003>>----
         #Ctrlp:construct.c.filter.page1.b_glfe003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe003
            #add-point:ON ACTION controlp INFIELD b_glfe003 name="construct.c.filter.page1.b_glfe003"
            
            #END add-point
 
 
         #----<<b_glfe004>>----
         #Ctrlp:construct.c.filter.page1.b_glfe004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe004
            #add-point:ON ACTION controlp INFIELD b_glfe004 name="construct.c.filter.page1.b_glfe004"
            
            #END add-point
 
 
         #----<<glfel003>>----
         #----<<glfel004>>----
         #----<<b_glfe005>>----
         #Ctrlp:construct.c.filter.page1.b_glfe005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe005
            #add-point:ON ACTION controlp INFIELD b_glfe005 name="construct.c.filter.page1.b_glfe005"
            
            #END add-point
 
 
         #----<<b_glfe006>>----
         #Ctrlp:construct.c.filter.page1.b_glfe006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe006
            #add-point:ON ACTION controlp INFIELD b_glfe006 name="construct.c.filter.page1.b_glfe006"
            
            #END add-point
 
 
         #----<<b_glfe007>>----
         #Ctrlp:construct.c.filter.page1.b_glfe007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe007
            #add-point:ON ACTION controlp INFIELD b_glfe007 name="construct.c.filter.page1.b_glfe007"
            
            #END add-point
 
 
         #----<<b_glfe012>>----
         #Ctrlp:construct.c.filter.page1.b_glfe012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe012
            #add-point:ON ACTION controlp INFIELD b_glfe012 name="construct.c.filter.page1.b_glfe012"
            
            #END add-point
 
 
         #----<<b_glfe013>>----
         #Ctrlp:construct.c.filter.page1.b_glfe013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe013
            #add-point:ON ACTION controlp INFIELD b_glfe013 name="construct.c.filter.page1.b_glfe013"
            
            #END add-point
 
 
         #----<<b_glfe014>>----
         #Ctrlp:construct.c.filter.page1.b_glfe014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe014
            #add-point:ON ACTION controlp INFIELD b_glfe014 name="construct.c.filter.page1.b_glfe014"
            
            #END add-point
 
 
         #----<<b_glfe015>>----
         #Ctrlp:construct.c.filter.page1.b_glfe015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe015
            #add-point:ON ACTION controlp INFIELD b_glfe015 name="construct.c.filter.page1.b_glfe015"
            
            #END add-point
 
 
         #----<<b_glfe016>>----
         #Ctrlp:construct.c.filter.page1.b_glfe016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfe016
            #add-point:ON ACTION controlp INFIELD b_glfe016 name="construct.c.filter.page1.b_glfe016"
            
            #END add-point
 
 
         #----<<tot00>>----
         #----<<tot01>>----
         #----<<tot02>>----
         #----<<tot03>>----
         #----<<tot04>>----
         #----<<tot05>>----
         #----<<tot06>>----
         #----<<tot07>>----
         #----<<tot08>>----
         #----<<tot09>>----
         #----<<tot10>>----
         #----<<tot11>>----
         #----<<tot12>>----
   
 
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
   
      CALL aglq860_filter_show('glfe001','b_glfe001')
   CALL aglq860_filter_show('glfeseq','b_glfeseq')
   CALL aglq860_filter_show('glfe003','b_glfe003')
   CALL aglq860_filter_show('glfe004','b_glfe004')
   CALL aglq860_filter_show('glfe005','b_glfe005')
   CALL aglq860_filter_show('glfe006','b_glfe006')
   CALL aglq860_filter_show('glfe007','b_glfe007')
   CALL aglq860_filter_show('glfe012','b_glfe012')
   CALL aglq860_filter_show('glfe013','b_glfe013')
   CALL aglq860_filter_show('glfe014','b_glfe014')
   CALL aglq860_filter_show('glfe015','b_glfe015')
   CALL aglq860_filter_show('glfe016','b_glfe016')
 
    
   CALL aglq860_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION aglq860_filter_parser(ps_field)
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
 
{<section id="aglq860.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq860_filter_show(ps_field,ps_object)
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
   LET ls_condition = aglq860_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.insert" >}
#+ insert
PRIVATE FUNCTION aglq860_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aglq860.modify" >}
#+ modify
PRIVATE FUNCTION aglq860_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.reproduce" >}
#+ reproduce
PRIVATE FUNCTION aglq860_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.delete" >}
#+ delete
PRIVATE FUNCTION aglq860_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="aglq860.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq860_detail_action_trans()
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
 
{<section id="aglq860.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq860_detail_index_setting()
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
            IF g_glfe_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_glfe_d.getLength() AND g_glfe_d.getLength() > 0
            LET g_detail_idx = g_glfe_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_glfe_d.getLength() THEN
               LET g_detail_idx = g_glfe_d.getLength()
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
 
{<section id="aglq860.mask_functions" >}
 &include "erp/agl/aglq860_mask.4gl"
 
{</section>}
 
{<section id="aglq860.other_function" readonly="Y" >}
# QBE資料查詢
PRIVATE FUNCTION aglq860_query1()
   #add-point:query段define-客製

   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理)
   DEFINE l_success  LIKE type_t.num5
   #end add-point 
   
   #add-point:FUNCTION前置處理
   CALL aglq860_set_comp_required("b_y,e_y,b_m,e_m,b_q,e_q",TRUE)
   CALL cl_set_comp_visible("tot00,tot01,tot02,tot03,tot04,tot05,tot06,tot07,tot08,tot09,tot10,tot11,tot12",TRUE)
   CALL cl_set_toolbaritem_visible("show", FALSE)
   CALL cl_set_toolbaritem_visible("hide", TRUE)
   CALL cl_set_comp_visible("lbl_group2",TRUE)
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfe_d.clear()
   CALL drawselect("cv1") 
   CALL drawClear()
   CALL drawselect("cv2") 
   CALL drawClear()
   CALL drawselect("cv3") 
   CALL drawClear()
   CALL drawselect("cv4") 
   CALL drawClear()
   CALL drawselect("cv5") 
   CALL drawClear() 
   
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
 
      INPUT BY NAME tm.glaald,tm.glaald_desc,tm.curr_type,tm.glaa001,tm.glfd001,tm.glfd001_desc,tm.type,
                    tm.b_y,tm.e_y,tm.b_m,tm.e_m,tm.b_q,tm.e_q,
                    tm.yy00,tm.yy01,tm.yy02,tm.yy03,tm.yy04,tm.yy05,tm.yy06,
                    tm.yy07,tm.yy08,tm.yy09,tm.yy10,tm.yy11,tm.yy12,
                    tm.b_mm00,tm.b_mm01,tm.b_mm02,tm.b_mm03,tm.b_mm04,tm.b_mm05,tm.b_mm06,
                    tm.b_mm07,tm.b_mm08,tm.b_mm09,tm.b_mm10,tm.b_mm11,tm.b_mm12,
                    tm.e_mm00,tm.e_mm01,tm.e_mm02,tm.e_mm03,tm.e_mm04,tm.e_mm05,tm.e_mm06,
                    tm.e_mm07,tm.e_mm08,tm.e_mm09,tm.e_mm10,tm.e_mm11,tm.e_mm12
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         BEFORE INPUT
            CALL aglq860_default()
         
         AFTER FIELD glaald
            IF NOT cl_null(tm.glaald) THEN
               CALL s_fin_ld_chk(tm.glaald,g_user,'N') RETURNING l_success,g_errno
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = tm.glaald
                  #160321-00016#30 --s add
                  LET g_errparam.replace[1] = 'agli010'
                  LET g_errparam.replace[2] = cl_get_progname('agli010',g_lang,"2")
                  LET g_errparam.exeprog = 'agli010'
                  #160321-00016#30 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
            
                  LET tm.glaald = ''
                  CALL aglq860_ref_show()
                  NEXT FIELD CURRENT
               END IF
               
               IF tm.curr_type = '1' THEN 
                  CALL s_ld_sel_glaa(tm.glaald,'glaa001') RETURNING g_sub_success,tm.glaa001
               END IF
               
               IF tm.curr_type = '2' THEN 
                  CALL s_ld_sel_glaa(tm.glaald,'glaa016') RETURNING g_sub_success,tm.glaa001
               END IF
               
               IF tm.curr_type = '3' THEN 
                  CALL s_ld_sel_glaa(tm.glaald,'glaa020') RETURNING g_sub_success,tm.glaa001
               END IF
            
               DISPLAY tm.glaa001 TO glaa001
            END IF
            CALL aglq860_ref_show() 

         ON CHANGE curr_type
            IF tm.curr_type = '1' THEN 
               CALL s_ld_sel_glaa(tm.glaald,'glaa001') RETURNING g_sub_success,tm.glaa001
            END IF
            
            IF tm.curr_type = '2' THEN 
               CALL s_ld_sel_glaa(tm.glaald,'glaa016') RETURNING g_sub_success,tm.glaa001
            END IF
            
            IF tm.curr_type = '3' THEN 
               CALL s_ld_sel_glaa(tm.glaald,'glaa020') RETURNING g_sub_success,tm.glaa001
            END IF
            
            DISPLAY tm.glaa001 TO glaa001
            
         ON CHANGE type
            IF tm.type = '1' THEN 
               CALL cl_set_comp_entry("b_q,e_q",FALSE)
               CALL cl_set_comp_entry("b_m,e_m",TRUE)
               LET tm.b_m = 1
               LET tm.e_m = 12
               LET tm.b_q = ''
               LET tm.e_q = ''
            END IF
            
            IF tm.type = '2' THEN 
               CALL cl_set_comp_entry("b_m,e_m",FALSE)
               CALL cl_set_comp_entry("b_q,e_q",TRUE)
               LET tm.b_q = 1
               LET tm.e_q = 4
               LET tm.b_m = ''
               LET tm.e_m = ''
            END IF 
            CALL aglq860_clear_date()
            CALL aglq860_get_date()
            
         AFTER FIELD glfd001
            IF NOT cl_null(tm.glfd001) THEN 
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = tm.glfd001
               
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_glfd001") THEN
                  #檢查成功時後續處理
                  
               ELSE
                  #檢查失敗時後續處理
                  CALL aglq860_ref_show()
                  NEXT FIELD CURRENT
               END IF
            END IF 
            CALL aglq860_ref_show()

         AFTER FIELD b_y
            IF NOT cl_null(tm.b_y) THEN 
               IF tm.b_y <1000 OR tm.b_y >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(tm.e_y) AND tm.b_y > tm.e_y THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'afa-00378'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF
            
         AFTER FIELD e_y
            IF tm.e_y <1000 OR tm.e_y >9999 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00113'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            IF NOT cl_null(tm.e_y) THEN
               IF NOT cl_null(tm.e_y) AND tm.e_y < tm.b_y THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'agl-00373'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF
            
         AFTER FIELD b_m
            IF NOT cl_null(tm.b_m) THEN
               IF (tm.b_m < 1) OR (tm.b_m > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(tm.e_m) AND tm.b_m > tm.e_m THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'agl-00227'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF
            
         AFTER FIELD e_m
            IF NOT cl_null(tm.e_m) THEN
               IF (tm.e_m < 1) OR (tm.e_m > 12) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00127'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(tm.b_m) AND tm.e_m < tm.b_m THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'agl-00228'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF
            
         AFTER FIELD b_q
            IF NOT cl_null(tm.b_q) THEN
               IF (tm.b_q < 1) OR (tm.b_q > 4) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00393'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(tm.e_q) AND tm.b_q > tm.e_q THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'agl-00391'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF
            
         AFTER FIELD e_q
            IF NOT cl_null(tm.e_q) THEN
               IF (tm.e_q < 1) OR (tm.e_q > 4) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00393'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(tm.b_q) AND tm.e_q < tm.b_q THEN 
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = 'agl-00392'
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               CALL aglq860_clear_date()
               CALL aglq860_get_date()
            END IF


         ON ACTION controlp INFIELD glaald
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = tm.glaald             #給予default值
               
               #取得帳務組織下所屬成員之帳別   
               CALL s_fin_account_center_comp_str() RETURNING ls_wc
               #將取回的字串轉換為SQL條件
               CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc 
               LET g_qryparam.where = " (glaa008 = 'Y' OR glaa014 = 'Y') AND glaacomp IN ",ls_wc,""               
               
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept
               
               CALL q_authorised_ld()                                #呼叫開窗
               
               LET tm.glaald = g_qryparam.return1              #將開窗取得的值回傳到變數
               
               DISPLAY tm.glaald TO glaald              #顯示到畫面上
               CALL aglq860_ref_show() 
               NEXT FIELD glaald                          #返回原欄位
               
         ON ACTION controlp INFIELD glfd001
            #add-point:ON ACTION controlp INFIELD glfd001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = tm.glfd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #s


            CALL q_glfd001()                                #呼叫開窗

            LET tm.glfd001 = g_qryparam.return1              
            CALL aglq860_ref_show()
            DISPLAY tm.glfd001 TO glfd001              #

            NEXT FIELD glfd001                          #返回原欄位
      END INPUT
  
      #add-point:query段more_construct

      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後

      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=2"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct

   #end add-point
        
   LET g_error_show = 1
   CALL aglq860_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
END FUNCTION
# 欄位說明
PRIVATE FUNCTION aglq860_ref_show()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.glaald
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glaald_desc = g_rtn_fields[1]
   DISPLAY BY NAME tm.glaald_desc
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = tm.glfd001
   CALL ap_ref_array2(g_ref_fields,"SELECT glfdl003 FROM glfdl_t WHERE glfdlent='"||g_enterprise||"' AND glfdl001=? AND glfdl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET tm.glfd001_desc = g_rtn_fields[1]
   DISPLAY BY NAME tm.glfd001_desc
END FUNCTION
# 賦默認值
PRIVATE FUNCTION aglq860_default()
   
   CALL s_fin_get_major_ld(g_site) RETURNING tm.glaald
   CALL aglq860_ref_show()
   LET tm.curr_type = '1'
   CALL s_ld_sel_glaa(tm.glaald,'glaa001') RETURNING g_sub_success,tm.glaa001
   LET tm.type = '1'
   LET tm.b_y = YEAR(g_today)
   LET tm.e_y = tm.b_y
   LET tm.b_m = 1
   LET tm.e_m = 12
   LET tm.b_q = ''
   LET tm.e_q = ''
   CALL cl_set_comp_entry("b_q,e_q",FALSE)
   CALL aglq860_get_date()
   
END FUNCTION
# 計算日期
PRIVATE FUNCTION aglq860_get_date()
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_mm00          LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   
   LET l_year = tm.e_y - tm.b_y
   IF l_year = 0 THEN
      LET l_i = 0
      IF tm.type ='1' THEN
         LET l_mm00 = ''
         LET l_mm00 = tm.b_m - 1 
         IF l_mm00 = 0 THEN 
            LET tm.yy00 = tm.b_y -1
            LET tm.b_mm00 = 12
            LET tm.e_mm00 = 12
         END IF 
         IF l_mm00 <> 0 THEN 
            LET tm.yy00 = tm.b_y
            LET tm.b_mm00 = l_mm00
            LET tm.e_mm00 = l_mm00
         END IF        
         WHILE (tm.b_m + l_i <= tm.e_m AND l_i < 12)  
            IF l_i = 0 THEN
                LET tm.yy01 = tm.b_y
                LET tm.b_mm01 = tm.b_m
                LET tm.e_mm01 = tm.b_m
            END IF
            IF l_i = 1 THEN
                LET tm.yy02 = tm.b_y
                LET tm.b_mm02 = tm.b_m + l_i
                LET tm.e_mm02 = tm.b_m + l_i
            END IF
            IF l_i = 2 THEN
                LET tm.yy03 = tm.b_y
                LET tm.b_mm03 = tm.b_m + l_i
                LET tm.e_mm03 = tm.b_m + l_i
            END IF
            IF l_i = 3 THEN
                LET tm.yy04 = tm.b_y
                LET tm.b_mm04 = tm.b_m + l_i
                LET tm.e_mm04 = tm.b_m + l_i
            END IF
            IF l_i = 4 THEN
                LET tm.yy05 = tm.b_y
                LET tm.b_mm05 = tm.b_m + l_i
                LET tm.e_mm05 = tm.b_m + l_i
            END IF
            IF l_i = 5 THEN
                LET tm.yy06 = tm.b_y
                LET tm.b_mm06 = tm.b_m + l_i
                LET tm.e_mm06 = tm.b_m + l_i
            END IF
            IF l_i = 6 THEN
                LET tm.yy07 = tm.b_y
                LET tm.b_mm07 = tm.b_m + l_i
                LET tm.e_mm07 = tm.b_m + l_i
            END IF
            IF l_i = 7 THEN
                LET tm.yy08 = tm.b_y
                LET tm.b_mm08 = tm.b_m + l_i
                LET tm.e_mm08 = tm.b_m + l_i
            END IF
            IF l_i = 8 THEN
                LET tm.yy09 = tm.b_y
                LET tm.b_mm09 = tm.b_m + l_i
                LET tm.e_mm09 = tm.b_m + l_i
            END IF
            IF l_i = 9 THEN
                LET tm.yy10 = tm.b_y
                LET tm.b_mm10 = tm.b_m + l_i
                LET tm.e_mm10 = tm.b_m + l_i
            END IF
            IF l_i = 10 THEN
                LET tm.yy11 = tm.b_y
                LET tm.b_mm11 = tm.b_m + l_i
                LET tm.e_mm11 = tm.b_m + l_i
            END IF
            IF l_i = 11 THEN
                LET tm.yy12 = tm.b_y
                LET tm.b_mm12 = tm.b_m + l_i
                LET tm.e_mm12 = tm.b_m + l_i
            END IF
            LET l_i = l_i + 1
         END WHILE
      END IF
      IF tm.type = '2' THEN
         LET l_mm00 = ''
         LET l_mm00 = tm.b_q - 1 
         IF l_mm00 = 0 THEN 
            LET tm.yy00 = tm.b_y -1
            LET tm.b_mm00 = 9
            LET tm.e_mm00 = 12
         END IF 
         IF l_mm00 <> 0 THEN 
            LET tm.yy00 = tm.b_y
            LET tm.b_mm00 = (l_mm00-1)*3+1
            LET tm.e_mm00 = l_mm00*3
         END IF        
         WHILE (tm.b_q + l_i <= tm.e_q AND l_i < 5 )
            IF l_i = 0 THEN
               LET tm.yy01 = tm.b_y
               LET tm.b_mm01 = (tm.b_q+l_i-1)*3+1
               LET tm.e_mm01 =(tm.b_q+l_i)*3
            END IF
            IF l_i = 1 THEN
               LET tm.yy02 = tm.b_y
               LET tm.b_mm02 = (tm.b_q+l_i-1)*3+1
               LET tm.e_mm02 =(tm.b_q+l_i)*3
            END IF
            IF l_i = 2 THEN
               LET tm.yy03 = tm.b_y
               LET tm.b_mm03 = (tm.b_q+l_i-1)*3+1
               LET tm.e_mm03 =(tm.b_q+l_i)*3
            END IF
            IF l_i = 3 THEN
               LET tm.yy04 = tm.b_y
               LET tm.b_mm04 = (tm.b_q+l_i-1)*3+1
               LET tm.e_mm04 =(tm.b_q+l_i)*3
            END IF
            LET l_i = l_i + 1
         END WHILE
      END IF
   END IF
   IF l_year > 0 THEN
      LET l_i = 0
      IF tm.type = '1' THEN 
         LET tm.yy00 = tm.b_y-1
         LET tm.b_mm00 = tm.b_m
         LET tm.e_mm00 = tm.e_m 
         WHILE (tm.b_y + l_i  <= tm.e_y AND l_i < 13)
            IF l_i = 0 THEN
               LET tm.yy01 = tm.b_y + l_i
               LET tm.b_mm01 = tm.b_m
               LET tm.e_mm01 = tm.e_m
            END IF
            IF l_i = 1 THEN
               LET tm.yy02 = tm.b_y + l_i
               LET tm.b_mm02 = tm.b_m
               LET tm.e_mm02 = tm.e_m
            END IF
            IF l_i = 2 THEN
               LET tm.yy03 = tm.b_y + l_i
               LET tm.b_mm03 = tm.b_m
               LET tm.e_mm03 = tm.e_m
            END IF
            IF l_i = 3 THEN
               LET tm.yy04 = tm.b_y + l_i
               LET tm.b_mm04 = tm.b_m
               LET tm.e_mm04 = tm.e_m
            END IF
            IF l_i = 4 THEN
               LET tm.yy05 = tm.b_y + l_i
               LET tm.b_mm05 = tm.b_m
               LET tm.e_mm05 = tm.e_m
            END IF
            IF l_i = 5 THEN
               LET tm.yy06 = tm.b_y + l_i
               LET tm.b_mm06 = tm.b_m
               LET tm.e_mm06 = tm.e_m
            END IF
            IF l_i = 6 THEN
               LET tm.yy07 = tm.b_y + l_i
               LET tm.b_mm07 = tm.b_m
               LET tm.e_mm07 = tm.e_m
            END IF
            IF l_i = 7 THEN
               LET tm.yy08 = tm.b_y + l_i
               LET tm.b_mm08 = tm.b_m
               LET tm.e_mm08 = tm.e_m
            END IF
            IF l_i = 8 THEN
               LET tm.yy09 = tm.b_y + l_i
               LET tm.b_mm09 = tm.b_m
               LET tm.e_mm09 = tm.e_m
            END IF
            IF l_i = 9 THEN
               LET tm.yy10 = tm.b_y + l_i
               LET tm.b_mm10 = tm.b_m
               LET tm.e_mm10 = tm.e_m
            END IF
            IF l_i = 10 THEN
               LET tm.yy11 = tm.b_y + l_i
               LET tm.b_mm11 = tm.b_m
               LET tm.e_mm11 = tm.e_m
            END IF
            IF l_i = 11 THEN
               LET tm.yy12 = tm.b_y + l_i
               LET tm.b_mm12 = tm.b_m
               LET tm.e_mm12 = tm.e_m
            END IF
            LET l_i = l_i + 1
         END WHILE
      END IF
      IF tm.type = '2' THEN
         LET tm.yy00 = tm.b_y -1 
         LET tm.b_mm00 = (tm.b_q-1)*3+1
         LET tm.e_mm00 = tm.e_q*3
         WHILE (tm.b_y + l_i  <= tm.e_y AND l_year < 13)
            IF l_i = 0 THEN
               LET tm.yy01 = tm.b_y + l_i
               LET tm.b_mm01 = (tm.b_q-1)*3+1
               LET tm.e_mm01 = tm.e_q*3
            END IF
            IF l_i = 1 THEN
               LET tm.yy02 = tm.b_y + l_i
               LET tm.b_mm02 = (tm.b_q-1)*3+1
               LET tm.e_mm02 = tm.e_q*3
            END IF
            IF l_i = 2 THEN
               LET tm.yy03 = tm.b_y + l_i
               LET tm.b_mm03 = (tm.b_q-1)*3+1
               LET tm.e_mm03 = tm.e_q*3
            END IF
            IF l_i = 3 THEN
               LET tm.yy04 = tm.b_y + l_i
               LET tm.b_mm04 = (tm.b_q-1)*3+1
               LET tm.e_mm04 = tm.e_q*3
            END IF
            IF l_i = 4 THEN
               LET tm.yy05 = tm.b_y + l_i
               LET tm.b_mm05 = (tm.b_q-1)*3+1
               LET tm.e_mm05 = tm.e_q*3
            END IF
            IF l_i = 5 THEN
               LET tm.yy06 = tm.b_y + l_i
               LET tm.b_mm06 = (tm.b_q-1)*3+1
               LET tm.e_mm06 = tm.e_q*3
            END IF
            IF l_i = 6 THEN
               LET tm.yy07 = tm.b_y + l_i
               LET tm.b_mm07 = (tm.b_q-1)*3+1
               LET tm.e_mm07 = tm.e_q*3
            END IF
            IF l_i = 7 THEN
               LET tm.yy08 = tm.b_y + l_i
               LET tm.b_mm08 = (tm.b_q-1)*3+1
               LET tm.e_mm08 = tm.e_q*3
            END IF
            IF l_i = 8 THEN
               LET tm.yy09 = tm.b_y + l_i
               LET tm.b_mm09 = (tm.b_q-1)*3+1
               LET tm.e_mm09 = tm.e_q*3
            END IF
            IF l_i = 9 THEN
               LET tm.yy10 = tm.b_y + l_i
               LET tm.b_mm10 = (tm.b_q-1)*3+1
               LET tm.e_mm10 = tm.e_q*3
            END IF
            IF l_i = 10 THEN
               LET tm.yy11 = tm.b_y + l_i
               LET tm.b_mm11 = (tm.b_q-1)*3+1
               LET tm.e_mm11 = tm.e_q*3
            END IF
            IF l_i = 11 THEN
               LET tm.yy12 = tm.b_y + l_i
               LET tm.b_mm12 = (tm.b_q-1)*3+1
               LET tm.e_mm12 = tm.e_q*3
            END IF
            LET l_i = l_i + 1
         END WHILE
      END IF
   END IF
END FUNCTION
# 清空日期值
PRIVATE FUNCTION aglq860_clear_date()
   LET tm.yy00 = ''
   LET tm.yy01 = ''
   LET tm.yy02 = ''
   LET tm.yy03 = ''
   LET tm.yy04 = ''
   LET tm.yy05 = ''
   LET tm.yy06 = ''
   LET tm.yy07 = ''
   LET tm.yy08 = ''
   LET tm.yy09 = ''
   LET tm.yy10 = ''
   LET tm.yy11 = ''
   LET tm.yy12 = ''
   LET tm.b_mm00 = ''
   LET tm.b_mm01 = ''
   LET tm.b_mm02 = ''
   LET tm.b_mm03 = ''
   LET tm.b_mm04 = ''
   LET tm.b_mm05 = ''
   LET tm.b_mm06 = ''
   LET tm.b_mm07 = ''
   LET tm.b_mm08 = ''
   LET tm.b_mm09 = ''
   LET tm.b_mm10 = ''
   LET tm.b_mm11 = ''
   LET tm.b_mm12 = ''
   LET tm.e_mm00 = ''
   LET tm.e_mm01 = ''
   LET tm.e_mm02 = ''
   LET tm.e_mm03 = ''
   LET tm.e_mm04 = ''
   LET tm.e_mm05 = ''
   LET tm.e_mm06 = ''
   LET tm.e_mm07 = ''
   LET tm.e_mm08 = ''
   LET tm.e_mm09 = ''
   LET tm.e_mm10 = ''
   LET tm.e_mm11 = ''
   LET tm.e_mm12 = ''
END FUNCTION
# 必要栏位的控制
PRIVATE FUNCTION aglq860_set_comp_required(ps_fields,pi_required)
   DEFINE ps_fields STRING,
          pi_required   LIKE type_t.num5              
   DEFINE lst_fields base.StringTokenizer,
          ls_field_name STRING
   DEFINE lwin_curr     ui.Window,
          lfrm_curr     ui.Form         
   DEFINE lnode_win     om.DomNode,
          llst_items    om.NodeList,
          li_i          LIKE type_t.num5,             
          lnode_item    om.DomNode,
          lnode_child   om.DomNode,     
          ls_item_name  STRING
 
   IF (ps_fields IS NULL) THEN RETURN END IF
 
   IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN
      RETURN
   END IF
 
   LET ps_fields = ps_fields.toLowerCase()
 
   LET lst_fields = base.StringTokenizer.create(ps_fields, ",")
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()       
   LET lnode_win = lwin_curr.getNode()
 
   LET llst_items = lnode_win.selectByPath("//Form//*")
 
   WHILE lst_fields.hasMoreTokens()
     LET ls_field_name = lst_fields.nextToken()
     LET ls_field_name = ls_field_name.trim()
 
     IF (ls_field_name.getLength() > 0) THEN
        FOR li_i = 1 TO llst_items.getLength()
            LET lnode_item = llst_items.item(li_i)
            LET ls_item_name = lnode_item.getAttribute("colName")
 
            IF (ls_item_name IS NULL) THEN
               CONTINUE FOR
            END IF
 
            LET ls_item_name = ls_item_name.trim()
 
            IF (ls_item_name.equals(ls_field_name)) THEN
               IF (pi_required) THEN
                  CALL lfrm_curr.setFieldHidden(ls_field_name,0) 
                  CALL lnode_item.setAttribute("required", "1")
                  CALL lnode_item.setAttribute("notNull", "1")
                  IF lnode_item.getTagName() = "FormField" THEN   
                     LET lnode_child = lnode_item.getFirstChild() 
                     IF lnode_child IS NOT NULL AND
                        lnode_child.getTagName() <> "CheckBox" AND
                        lnode_child.getTagName() <> "RadioGroup" THEN
                        CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                     END IF
                  ELSE
                     CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_red")
                  END IF
               ELSE
                  CALL lnode_item.setAttribute("required", "0")
                  CALL lnode_item.setAttribute("notNull", "0")
                  IF lnode_item.getTagName() = "FormField" THEN   
                     LET lnode_child = lnode_item.getFirstChild()
                     IF lnode_child IS NOT NULL AND
                        lnode_child.getTagName() <> "CheckBox"   AND
                        lnode_child.getTagName() <> "RadioGroup" THEN
                        CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                     END IF
                  ELSE
                     CALL lfrm_curr.setFieldStyle(ls_field_name,"inputbgcolor_white")
                  END IF
               END IF
 
               EXIT FOR
            END IF
        END FOR
     END IF
   END WHILE
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
PRIVATE FUNCTION aglq860_dis_form(p_tot,p_glfe006)
   DEFINE p_tot        LIKE glar_t.glar005
   DEFINE p_glfe006    LIKE glfe_t.glfe006

   #先根据数据格式对金额进行处理
   IF p_glfe006 = '1' THEN LET p_tot = p_tot * 100 END IF
   IF p_glfe006 = '2' THEN LET p_tot = p_tot END IF
   IF p_glfe006 = '3' THEN LET p_tot = p_tot * 1000 END IF

    RETURN p_tot
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
PRIVATE FUNCTION aglq860_b_fill2()
   DEFINE id,l_h             LIKE type_t.num10  
   DEFINE l_str              STRING
   DEFINE l_length           LIKE type_t.num20_6
   DEFINE l_p1               LIKE type_t.num10
   DEFINE l_p2               LIKE type_t.num20_6
   DEFINE l_p3               LIKE type_t.num20_6
   DEFINE l_p4               LIKE type_t.num20_6
   DEFINE l_p5               LIKE type_t.num20_6
   DEFINE l_p6               LIKE type_t.num20_6
   DEFINE l_p7               LIKE type_t.num20_6
   DEFINE l_p8               LIKE type_t.num20_6
   DEFINE l_p9               LIKE type_t.num20_6
   DEFINE l_p10              LIKE type_t.num20_6
   DEFINE l_p11              LIKE type_t.num20_6
   DEFINE l_p12              LIKE type_t.num20_6
   DEFINE l_p15              LIKE type_t.num20_6
   DEFINE l_p16              LIKE type_t.num20_6 
   DEFINE l_p17              LIKE type_t.num20_6
   DEFINE l_p18              LIKE type_t.num20_6 
   DEFINE l_p19              LIKE type_t.num20_6 
   DEFINE l_q1               LIKE type_t.num20_6
   DEFINE l_q2               LIKE type_t.num20_6
   DEFINE l_q3               LIKE type_t.num20_6
   DEFINE l_q4               LIKE type_t.num20_6
   DEFINE l_q5               LIKE type_t.num20_6
   DEFINE l_q6               LIKE type_t.num20_6
   DEFINE l_q7               LIKE type_t.num20_6
   DEFINE l_q8               LIKE type_t.num20_6
   DEFINE l_q9               LIKE type_t.num20_6
   DEFINE l_q10              LIKE type_t.num20_6
   DEFINE l_q11              LIKE type_t.num20_6
   DEFINE l_q12              LIKE type_t.num20_6 
   DEFINE l_q15              LIKE type_t.num20_6
   DEFINE l_q16              LIKE type_t.num20_6 
   DEFINE l_q17              LIKE type_t.num20_6
   DEFINE l_q18              LIKE type_t.num20_6 
   DEFINE l_q19              LIKE type_t.num20_6 
   DEFINE l_str1             LIKE type_t.chr20
   DEFINE l_glfe010          LIKE glfe_t.glfe010
   DEFINE l_glfe012          LIKE glfe_t.glfe012
   DEFINE l_glfe013          LIKE glfe_t.glfe013
   DEFINE l_glfe014          LIKE glfe_t.glfe014
   DEFINE l_glfe015          LIKE glfe_t.glfe015
   DEFINE l_glfe016          LIKE glfe_t.glfe016
   DEFINE l_msg1             STRING
   DEFINE l_msg2             STRING
   DEFINE l_msg3             STRING
   DEFINE l_msg4             STRING
   DEFINE l_msg5             STRING
   DEFINE l_msg6             STRING
   DEFINE l_msg7             STRING
   DEFINE l_msg8             STRING
   DEFINE l_msg9             STRING
   DEFINE l_msg10            STRING
   DEFINE l_msg11            STRING
   DEFINE l_msg12            STRING
   DEFINE l_msg13            STRING
   DEFINE l_msg14            STRING
   DEFINE l_msg15            STRING
   DEFINE l_msg16            STRING
   DEFINE l_msg17            STRING
 
   CALL drawselect("cv1") 
   CALL drawClear()
   
   IF g_chr1 = 'N' THEN
      RETURN
   END IF
   
   LET l_msg1  = cl_getmsg('agl-00489',g_lang)
   LET l_msg2  = cl_getmsg('agl-00490',g_lang)
   LET l_msg3  = cl_getmsg('agl-00491',g_lang)
   LET l_msg4  = cl_getmsg('agl-00492',g_lang)
   LET l_msg5  = cl_getmsg('agl-00493',g_lang)
   LET l_msg6  = cl_getmsg('agl-00494',g_lang)
   LET l_msg7  = cl_getmsg('agl-00495',g_lang)
   LET l_msg8  = cl_getmsg('agl-00496',g_lang)
   LET l_msg9  = cl_getmsg('agl-00497',g_lang)
   LET l_msg10 = cl_getmsg('agl-00498',g_lang)
   LET l_msg11 = cl_getmsg('agl-00499',g_lang)
   LET l_msg12 = cl_getmsg('agl-00500',g_lang)
   LET l_msg13 = cl_getmsg('agl-00501',g_lang)
   LET l_msg14 = cl_getmsg('agl-00502',g_lang)
   LET l_msg15 = cl_getmsg('agl-00503',g_lang)
   LET l_msg16 = cl_getmsg('agl-00504',g_lang)
   LET l_msg17 = cl_getmsg('agl-00505',g_lang)
   
   LET l_q1 = g_glfe_d[l_ac].tot01
   LET l_q2 = g_glfe_d[l_ac].tot02
   LET l_q3 = g_glfe_d[l_ac].tot03
   LET l_q4 = g_glfe_d[l_ac].tot04
   LET l_q5 = g_glfe_d[l_ac].tot05
   LET l_q6 = g_glfe_d[l_ac].tot06
   LET l_q7 = g_glfe_d[l_ac].tot07
   LET l_q8 = g_glfe_d[l_ac].tot08
   LET l_q9 = g_glfe_d[l_ac].tot09
   LET l_q10 = g_glfe_d[l_ac].tot10
   LET l_q11 = g_glfe_d[l_ac].tot11
   LET l_q12 = g_glfe_d[l_ac].tot12
   LET l_q15 = g_glfe_d[l_ac].glfe012
   LET l_q16 = g_glfe_d[l_ac].glfe013
   LET l_q17 = g_glfe_d[l_ac].glfe014
   LET l_q18 = g_glfe_d[l_ac].glfe015
   LET l_q19 = g_glfe_d[l_ac].glfe016
   LET g_max = ''
   LET g_min = ''  
   DELETE FROM x_tmp   
   INSERT INTO x_tmp VALUES (l_q1)
   INSERT INTO x_tmp VALUES (l_q2)
   INSERT INTO x_tmp VALUES (l_q3)
   INSERT INTO x_tmp VALUES (l_q4)
   INSERT INTO x_tmp VALUES (l_q5)
   INSERT INTO x_tmp VALUES (l_q6)
   INSERT INTO x_tmp VALUES (l_q7)
   INSERT INTO x_tmp VALUES (l_q8)
   INSERT INTO x_tmp VALUES (l_q9)
   INSERT INTO x_tmp VALUES (l_q10)
   INSERT INTO x_tmp VALUES (l_q11)
   INSERT INTO x_tmp VALUES (l_q12)
   INSERT INTO x_tmp VALUES (l_q15)
   INSERT INTO x_tmp VALUES (l_q16)
   INSERT INTO x_tmp VALUES (l_q17)
   INSERT INTO x_tmp VALUES (l_q18)
   INSERT INTO x_tmp VALUES (l_q19) 
   SELECT MAX(x_q) INTO g_max FROM x_tmp WHERE x_q is NOT NULL 
   SELECT MIN(x_q) INTO g_min FROM x_tmp WHERE x_q is NOT NULL 
   LET l_length = (g_max - g_min)/10
   LET l_p1 = (l_q1 - g_min)/l_length*70+200
   LET l_p2 = (l_q2 - g_min)/l_length*70+200
   LET l_p3 = (l_q3 - g_min)/l_length*70+200
   LET l_p4 = (l_q4 - g_min)/l_length*70+200
   LET l_p5 = (l_q5 - g_min)/l_length*70+200
   LET l_p6 = (l_q6 - g_min)/l_length*70+200
   LET l_p7 = (l_q7 - g_min)/l_length*70+200
   LET l_p8 = (l_q8 - g_min)/l_length*70+200
   LET l_p9 = (l_q9 - g_min)/l_length*70+200
   LET l_p10= (l_q10 - g_min)/l_length*70+200
   LET l_p11= (l_q11 - g_min)/l_length*70+200
   LET l_p12= (l_q12 - g_min)/l_length*70+200
   LET l_p15= (l_q15 - g_min)/l_length*70+200
   LET l_p16= (l_q16 - g_min)/l_length*70+200
   LET l_p17= (l_q17 - g_min)/l_length*70+200
   LET l_p18= (l_q18 - g_min)/l_length*70+200
   LET l_p19= (l_q19 - g_min)/l_length*70+200 
   
   LET g_draw_x=0   #起始x軸位置
   LET g_draw_y=60  #起始y軸位置
   LET g_draw_dx=0  #起始dx軸位置
   LET g_draw_dy=10 #起始dy軸位置   
   
   LET g_draw_width=10
   LET g_draw_multiple=1 #時間的放大倍數(在長條圖上的刻度比例) 
      
   CALL DrawFillColor("black") 
   IF g_min >= 0 THEN
     #                     y坐标，x坐标，宽度， 长度
      LET id=DrawRectangle(200,100,1,1000)  #(橫軸)
     #                     y坐标，x坐标，长度， 宽度 
      LET id=DrawRectangle(200,100,1000,1)  #(縱軸)
                             #增加的y长度，增加的x长度    
   END IF    
   IF g_min < 0 THEN
     #                     y坐标，x坐标，宽度， 长度
      LET id=DrawRectangle(200+(0-(g_min))/l_length*80,100,1,1000)  #(橫軸)
     #                     y坐标，x坐标，长度， 宽度 
      LET id=DrawRectangle(200,100,1000,1)  #(縱軸)
                             #增加的y长度，增加的x长度 
   END IF     
   CALL drawLineWidth(1)  
   IF NOT cl_null(g_min) THEN   
      LET l_glfe010 = 'N'   
      SELECT glfe010 INTO l_glfe010
       FROM glfe_t
      WHERE glfeent = g_enterprise
        AND glfe001 = tm.glfd001
        AND glfeseq = g_glfe_d[l_ac].glfeseq
   	IF l_glfe010 = 'Y' AND NOT cl_null(l_p15) THEN
         LET id = drawline(l_p15,100,0,1000-100)
      END IF 
      LET id = drawText(100,100+50*1,l_msg1)
      LET id = drawText(100,100+50*2,l_msg2)
      LET id = drawText(100,100+50*3,l_msg3)
      LET id = drawText(100,100+50*4,l_msg4)
      LET id = drawText(100,100+50*5,l_msg5)
      IF NOT cl_null(l_p1) THEN
         LET id = drawText(100,100+50*6,l_msg6)
      END IF
      IF NOT cl_null(l_p2) THEN	   
         LET id = drawText(100,100+50*7,l_msg7)
      END IF
      IF NOT cl_null(l_p3) THEN	   
         LET id = drawText(100,100+50*8,l_msg8)
      END IF
      IF NOT cl_null(l_p4) THEN	
         LET id = drawText(100,100+50*9,l_msg9)
      END IF
      IF NOT cl_null(l_p5) THEN	
         LET id = drawText(100,100+50*10,l_msg10)
      END IF
      IF NOT cl_null(l_p6) THEN	
         LET id = drawText(100,100+50*11,l_msg11)
      END IF
      IF NOT cl_null(l_p7) THEN	
         LET id = drawText(100,100+50*12,l_msg12)
      END IF
      IF NOT cl_null(l_p8) THEN	
         LET id = drawText(100,100+50*13,l_msg13)
      END IF
      IF NOT cl_null(l_p9) THEN	
         LET id = drawText(100,100+50*14,l_msg14)
      END IF
      IF NOT cl_null(l_p10) THEN	
         LET id = drawText(100,100+50*15,l_msg15)
      END IF
      IF NOT cl_null(l_p11) THEN	
         LET id = drawText(100,100+50*16,l_msg16)
      END IF
      IF NOT cl_null(l_p12) THEN	
         LET id = drawText(100,100+50*17,l_msg17)
      END IF 
      CALL aglq860_drawsety(l_length,0)   
      CALL aglq860_drawsety(l_length,1) 
      CALL aglq860_drawsety(l_length,2) 
      CALL aglq860_drawsety(l_length,3)   
      CALL aglq860_drawsety(l_length,4) 
      CALL aglq860_drawsety(l_length,5) 
      CALL aglq860_drawsety(l_length,6)   
      CALL aglq860_drawsety(l_length,7) 
      CALL aglq860_drawsety(l_length,8) 
      CALL aglq860_drawsety(l_length,9)   
      CALL aglq860_drawsety(l_length,10) 

      IF NOT cl_null(l_p15) AND NOT cl_null(l_p16) THEN 
         CALL DrawFillColor("red")        
         LET id = drawLine(l_p15,100+50*1,l_p16-l_p15,50)
      END IF
      IF NOT cl_null(l_p16) AND NOT cl_null(l_p17) THEN    
         CALL DrawFillColor("red")
         LET id = drawLine(l_p16,100+50*2,l_p17-l_p16,50)
      END IF 
      IF NOT cl_null(l_p17) AND NOT cl_null(l_p18) THEN  
         CALL DrawFillColor("red")
         LET id = drawLine(l_p17,100+50*3,l_p18-l_p17,50)
      END IF 
      IF NOT cl_null(l_p18) AND NOT cl_null(l_p19) THEN    
         CALL DrawFillColor("red")
         LET id = drawLine(l_p18,100+50*4,l_p19-l_p18,50)
      END IF 
      IF NOT cl_null(l_p19) AND NOT cl_null(l_p1) THEN   
         CALL DrawFillColor("red")
         LET id = drawLine(l_p19,100+50*5,l_p1-l_p19,50)
      END IF  
      IF NOT cl_null(l_p1) AND NOT cl_null(l_p2) THEN  
         CALL DrawFillColor("red")
         LET id = drawLine(l_p1,100+50*6,l_p2-l_p1,50)
      END IF
      IF NOT cl_null(l_p2) AND NOT cl_null(l_p3) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p2,100+50*7,l_p3-l_p2,50)
      END IF 
      IF NOT cl_null(l_p3) AND NOT cl_null(l_p4) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p3,100+50*8,l_p4-l_p3,50)
      END IF 
      IF NOT cl_null(l_p4) AND NOT cl_null(l_p5) THEN    
         CALL DrawFillColor("red")
         LET id = drawLine(l_p4,100+50*9,l_p5-l_p4,50)
      END IF    
      IF NOT cl_null(l_p5) AND NOT cl_null(l_p6) THEN  
         CALL DrawFillColor("red")
         LET id = drawLine(l_p5,100+50*10,l_p6-l_p5,50)
      END IF 
      IF NOT cl_null(l_p6) AND NOT cl_null(l_p7) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p6,100+50*11,l_p7-l_p6,50)
      END IF 
      IF NOT cl_null(l_p7) AND NOT cl_null(l_p8) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p7,100+50*12,l_p8-l_p7,50)
      END IF 
      IF NOT cl_null(l_p8) AND NOT cl_null(l_p9) THEN      
         CALL DrawFillColor("red")
         LET id = drawLine(l_p8,100+50*13,l_p9-l_p8,50)
      END IF 
      IF NOT cl_null(l_p9) AND NOT cl_null(l_p10) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p9,100+50*14,l_p10-l_p9,50)
      END IF    
      IF NOT cl_null(l_p10) AND NOT cl_null(l_p11) THEN  
         CALL DrawFillColor("red")
         LET id = drawLine(l_p10,100+50*15,l_p11-l_p10,50)
      END IF 
      IF NOT cl_null(l_p11) AND NOT cl_null(l_p12) THEN     
         CALL DrawFillColor("red")
         LET id = drawLine(l_p11,100+50*16,l_p12-l_p11,50)
      END IF    
       
      #标明那个点     
      CALL aglq860_p(l_p15,1)
      CALL aglq860_p(l_p16,2)
      CALL aglq860_p(l_p17,3) 
      CALL aglq860_p(l_p18,4)
      CALL aglq860_p(l_p19,5)
      CALL aglq860_p(l_p1,6)
      CALL aglq860_p(l_p2,7)
      CALL aglq860_p(l_p3,8) 
      CALL aglq860_p(l_p4,9) 
      CALL aglq860_p(l_p5,10)
      CALL aglq860_p(l_p6,11)
      CALL aglq860_p(l_p7,12) 
      CALL aglq860_p(l_p8,13)
      CALL aglq860_p(l_p9,14)  
      CALL aglq860_p(l_p10,15)   
      CALL aglq860_p(l_p11,16)
      CALL aglq860_p(l_p12,17) 
   END IF                           
   CALL drawInit()
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
PRIVATE FUNCTION aglq860_drawsety(p_length,p_p)
   DEFINE p_length   LIKE type_t.num20_6
   DEFINE p_p        LIKE type_t.num20_6 
   DEFINE l_str1     LIKE type_t.chr20
   DEFINE l_str      STRING
   DEFINE id         LIKE type_t.num10
   DEFINE l_sql      STRING

   LET l_str = "round('",g_min,"+",p_length*p_p,",4)"
   LET l_sql = "SELECT ",aglq860_tp_tochar(l_str,'fm9999999990.00')," FROM DUAL"
   PREPARE q860_sel_prep FROM l_sql
   EXECUTE q860_sel_prep INTO l_str1
   LET l_str = l_str1
   LET id=drawText(200+70*p_p,70,l_str) 
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
PRIVATE FUNCTION aglq860_drawsety1(p_length,p_p)
   DEFINE p_length   LIKE type_t.num20_6
   DEFINE p_p        LIKE type_t.num20_6 
   DEFINE l_str1     LIKE type_t.chr20
   DEFINE l_str      STRING
   DEFINE id         LIKE type_t.num10
   DEFINE l_sql      STRING

   LET l_str = "round(",g_min,"+",p_length*p_p,",4)"
   LET l_sql = "SELECT ",aglq860_tp_tochar(l_str,'fm9999999990.00')," FROM DUAL"
   PREPARE q860_sel_prep1 FROM l_sql
   EXECUTE q860_sel_prep1 INTO l_str1
   LET l_str = l_str1
   LET id=drawText(150+80*p_p,50,l_str) 
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
PRIVATE FUNCTION aglq860_p(p1,p2)
   DEFINE p1 LIKE type_t.num20_6
   DEFINE p2 LIKE type_t.num10
   DEFINE id LIKE type_t.num10
   
   IF NOT cl_null(p1) THEN 
      LET id=DrawRectangle(p1-7,100+50*p2-2,14,4) 
   END IF     
END FUNCTION
################################################################################
# Descriptions...: 回傳 to_char的字串
# Input Parameter: lc_colid  CHAR(50) 欄位名稱
#                  lc_type   CHAR(50) 可接受型態 mm-dd-yy 或 yy/mm/dd 或 yymmdd (yy可代換用 yyyy,大小寫均可)
# Return Code....: ls_sql STRING 調整過的 SQL 字串
################################################################################
PRIVATE FUNCTION aglq860_tp_tochar(lc_colid,lc_type)
   DEFINE lc_colid    LIKE type_t.chr500
   DEFINE lc_type     LIKE type_t.chr500
   DEFINE li_type     LIKE type_t.num5
   DEFINE ls_cmd      STRING
   
   CASE
      WHEN db_get_database_type() = "ORA"
         LET ls_cmd = "to_char(",lc_colid CLIPPED,",'",lc_type CLIPPED,"')"
   
      WHEN db_get_database_type() = "MSV" OR db_get_database_type() = "ASE"
           LET lc_type = DOWNSHIFT(lc_type)
         CASE
            WHEN lc_type = "mm-dd-yy"    LET li_type = 10
            WHEN lc_type = "mm-dd-yyyy"  LET li_type = 110
            WHEN lc_type = "yy/mm/dd"    LET li_type = 11
            WHEN lc_type = "yyyy/mm/dd"  LET li_type = 111
            WHEN lc_type = "yymmdd"      LET li_type = 12
            WHEN lc_type = "yyyymmdd"    LET li_type = 112
            OTHERWISE LET li_type = 0
         END CASE
         LET ls_cmd = "convert(varchar,",lc_colid CLIPPED,",",li_type USING "<<<<",")"
   
      OTHERWISE
         # 基本語法，不作任何增加或調整
         LET ls_cmd = "to_char(",lc_colid CLIPPED,",'",lc_type CLIPPED,"')"
   END CASE
   
   RETURN ls_cmd
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
PRIVATE FUNCTION aglq860_b_fill3(p_chr)
   DEFINE id,l_h             LIKE type_t.num10  
   DEFINE l_str              STRING 
   DEFINE l_length           LIKE type_t.num20_6
   DEFINE l_p1               LIKE type_t.num10
   DEFINE l_p2               LIKE type_t.num20_6
   DEFINE l_p3               LIKE type_t.num20_6
   DEFINE l_p4               LIKE type_t.num20_6
   DEFINE l_p5               LIKE type_t.num20_6
   DEFINE l_p6               LIKE type_t.num20_6
   DEFINE l_p7               LIKE type_t.num20_6
   DEFINE l_p8               LIKE type_t.num20_6
   DEFINE l_p9               LIKE type_t.num20_6
   DEFINE l_p10              LIKE type_t.num20_6
   DEFINE l_p11              LIKE type_t.num20_6
   DEFINE l_p12              LIKE type_t.num20_6
   DEFINE l_p15              LIKE type_t.num20_6
   DEFINE l_p16              LIKE type_t.num20_6
   DEFINE l_p17              LIKE type_t.num20_6
   DEFINE l_p18              LIKE type_t.num20_6
   DEFINE l_p19              LIKE type_t.num20_6 
   DEFINE l_q1               LIKE type_t.num20_6
   DEFINE l_q2               LIKE type_t.num20_6
   DEFINE l_q3               LIKE type_t.num20_6
   DEFINE l_q4               LIKE type_t.num20_6
   DEFINE l_q5               LIKE type_t.num20_6
   DEFINE l_q6               LIKE type_t.num20_6
   DEFINE l_q7               LIKE type_t.num20_6
   DEFINE l_q8               LIKE type_t.num20_6
   DEFINE l_q9               LIKE type_t.num20_6
   DEFINE l_q10              LIKE type_t.num20_6
   DEFINE l_q11              LIKE type_t.num20_6
   DEFINE l_q12              LIKE type_t.num20_6      
   DEFINE l_q15              LIKE type_t.num20_6 
   DEFINE l_q16              LIKE type_t.num20_6 
   DEFINE l_q17              LIKE type_t.num20_6 
   DEFINE l_q18              LIKE type_t.num20_6 
   DEFINE l_q19              LIKE type_t.num20_6  
   DEFINE l_msg1             STRING
   DEFINE l_msg2             STRING
   DEFINE l_msg3             STRING
   DEFINE l_msg4             STRING
   DEFINE l_msg5             STRING
   DEFINE l_msg6             STRING
   DEFINE l_msg7             STRING
   DEFINE l_msg8             STRING
   DEFINE l_msg9             STRING
   DEFINE l_msg10            STRING
   DEFINE l_msg11            STRING
   DEFINE l_msg12            STRING
   DEFINE l_msg13            STRING
   DEFINE l_msg14            STRING
   DEFINE l_msg15            STRING
   DEFINE l_msg16            STRING
   DEFINE l_msg17            STRING
   DEFINE l_str1             LIKE type_t.chr20
   DEFINE l_i                LIKE type_t.num10
   DEFINE l_count            LIKE type_t.num10
   DEFINE l_n                LIKE type_t.num10         
   DEFINE l_cnt              LIKE type_t.num10
   DEFINE l_glfe009          LIKE glfe_t.glfe009
   DEFINE l_glfe010          LIKE glfe_t.glfe010
   DEFINE p_chr              LIKE type_t.chr1
   DEFINE c,s     om.DomNode
   DEFINE w ui.Window 
  
   IF p_chr = '1' THEN
   	  CALL drawselect("cv2")
   END IF 	
   IF p_chr = '2' THEN
   	  CALL drawselect("cv3")
   END IF
   IF p_chr = '3' THEN
   	  CALL drawselect("cv4")
   END IF
   IF p_chr = '4' THEN
   	  CALL drawselect("cv5")
   END IF    
   CALL drawClear() 
      IF g_chr1 = 'N' THEN
      RETURN
   END IF 
   
   LET l_msg1  = cl_getmsg('agl-00489',g_lang)
   LET l_msg2  = cl_getmsg('agl-00490',g_lang)
   LET l_msg3  = cl_getmsg('agl-00491',g_lang)
   LET l_msg4  = cl_getmsg('agl-00492',g_lang)
   LET l_msg5  = cl_getmsg('agl-00493',g_lang)
   LET l_msg6  = cl_getmsg('agl-00494',g_lang)
   LET l_msg7  = cl_getmsg('agl-00495',g_lang)
   LET l_msg8  = cl_getmsg('agl-00496',g_lang)
   LET l_msg9  = cl_getmsg('agl-00497',g_lang)
   LET l_msg10 = cl_getmsg('agl-00498',g_lang)
   LET l_msg11 = cl_getmsg('agl-00499',g_lang)
   LET l_msg12 = cl_getmsg('agl-00500',g_lang)
   LET l_msg13 = cl_getmsg('agl-00501',g_lang)
   LET l_msg14 = cl_getmsg('agl-00502',g_lang)
   LET l_msg15 = cl_getmsg('agl-00503',g_lang)
   LET l_msg16 = cl_getmsg('agl-00504',g_lang)
   LET l_msg17 = cl_getmsg('agl-00505',g_lang)
   
   DELETE FROM x_tmp     
   LET g_n = 0
   CALL g_hx.clear()
   FOR l_i = 1 TO g_detail_cnt
      LET l_glfe009 = ''
      SELECT glfe009 INTO l_glfe009
        FROM glfe_t
       WHERE glfeent = g_enterprise
         AND glfe001 = tm.glfd001
         AND glfeseq = g_glfe_d[l_ac].glfeseq
      IF l_glfe009 <> p_chr THEN
         CONTINUE FOR
      END IF   
      LET g_n = g_n + 1 
      LET g_hx[g_n].* = g_glfe_d[l_i].*  
      LET l_q1  = NULL
      LET l_q2  = NULL
      LET l_q3  = NULL                   
      LET l_q4  = NULL
      LET l_q5  = NULL
      LET l_q6  = NULL
      LET l_q7  = NULL                   
      LET l_q8  = NULL
      LET l_q9  = NULL
      LET l_q10 = NULL
      LET l_q11 = NULL                   
      LET l_q12 = NULL
      LET l_q15 = NULL
      LET l_q16 = NULL                   
      LET l_q17 = NULL
      LET l_q18 = NULL
      LET l_q19 = NULL   
      SELECT to_number(g_glfe_d[l_i].tot01) INTO l_q1  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot02) INTO l_q2  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot03) INTO l_q3  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot04) INTO l_q4  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot05) INTO l_q5  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot06) INTO l_q6  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot07) INTO l_q7  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot08) INTO l_q8  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot09) INTO l_q9  FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot10) INTO l_q10 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot11) INTO l_q11 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].tot12) INTO l_q12 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].glfe012) INTO l_q15 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].glfe013) INTO l_q16 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].glfe014) INTO l_q17 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].glfe015) INTO l_q18 FROM DUAL 
      SELECT to_number(g_glfe_d[l_i].glfe016) INTO l_q19 FROM DUAL  

      INSERT INTO x_tmp VALUES (l_q1)
      INSERT INTO x_tmp VALUES (l_q2)
      INSERT INTO x_tmp VALUES (l_q3)
      INSERT INTO x_tmp VALUES (l_q4)
      INSERT INTO x_tmp VALUES (l_q5)
      INSERT INTO x_tmp VALUES (l_q6)
      INSERT INTO x_tmp VALUES (l_q7)
      INSERT INTO x_tmp VALUES (l_q8)
      INSERT INTO x_tmp VALUES (l_q9)
      INSERT INTO x_tmp VALUES (l_q10)
      INSERT INTO x_tmp VALUES (l_q11)
      INSERT INTO x_tmp VALUES (l_q12) 
      INSERT INTO x_tmp VALUES (l_q15)
      INSERT INTO x_tmp VALUES (l_q16)
      INSERT INTO x_tmp VALUES (l_q17)
      INSERT INTO x_tmp VALUES (l_q18)
      INSERT INTO x_tmp VALUES (l_q19)    
   END FOR 
   LET l_count = 0
   
   SELECT COUNT(*) INTO l_count
     FROM glfe_t
    WHERE glfeent = g_enterprise
      AND glfe001 = tm.glfd001
      AND glfe009 = p_chr
   IF l_count = 0 OR cl_null(l_count) THEN
      RETURN
   END IF       
    
   LET g_max = ''
   LET g_min = ''  
   SELECT MAX(x_q) INTO g_max FROM x_tmp WHERE x_q is NOT NULL 
   SELECT MIN(x_q) INTO g_min FROM x_tmp WHERE x_q is NOT NULL 
   LET l_length = (g_max - g_min)/10

   LET l_cnt = 1
   FOR l_i = 1 TO g_hx.getLength() 
      LET l_glfe010 = 'N'  
      SELECT glfe010 INTO l_glfe010
       FROM glfe_t
      WHERE glfeent = g_enterprise
        AND glfe001 = tm.glfd001
        AND glfeseq = g_glfe_d[l_ac].glfeseq
      LET l_p1 = (g_hx[l_i].tot01 - g_min)/l_length*80+150
      LET l_p2 = (g_hx[l_i].tot02 - g_min)/l_length*80+150
      LET l_p3 = (g_hx[l_i].tot03 - g_min)/l_length*80+150
      LET l_p4 = (g_hx[l_i].tot04 - g_min)/l_length*80+150
      LET l_p5 = (g_hx[l_i].tot05 - g_min)/l_length*80+150
      LET l_p6 = (g_hx[l_i].tot06 - g_min)/l_length*80+150
      LET l_p7 = (g_hx[l_i].tot07 - g_min)/l_length*80+150
      LET l_p8 = (g_hx[l_i].tot08 - g_min)/l_length*80+150
      LET l_p9 = (g_hx[l_i].tot09 - g_min)/l_length*80+150
      LET l_p10= (g_hx[l_i].tot10 - g_min)/l_length*80+150
      LET l_p11= (g_hx[l_i].tot11 - g_min)/l_length*80+150
      LET l_p12= (g_hx[l_i].tot12 - g_min)/l_length*80+150  
      LET l_p15= (g_hx[l_i].glfe012 - g_min)/l_length*80+150
      LET l_p16= (g_hx[l_i].glfe013 - g_min)/l_length*80+150
      LET l_p17= (g_hx[l_i].glfe014 - g_min)/l_length*80+150
      LET l_p18= (g_hx[l_i].glfe015 - g_min)/l_length*80+150
      LET l_p19= (g_hx[l_i].glfe016 - g_min)/l_length*80+150  
       
      IF g_min >= 0 THEN
        #                     y坐标，x坐标，宽度， 长度
         LET id=DrawRectangle(150,80,1,1000)  #(橫軸)
        #                     y坐标，x坐标，长度， 宽度 
         LET id=DrawRectangle(150,80,1000,1)  #(縱軸)
                                #增加的y长度，增加的x长度    
      END IF    
      IF g_min < 0 THEN
        #                     y坐标，x坐标，宽度， 长度
         LET id=DrawRectangle(150+(0-(g_min))/l_length*80,80,1,1000)  #(橫軸)
        #                     y坐标，x坐标，长度， 宽度 
         LET id=DrawRectangle(150,80,1000,1)  #(縱軸)
                                #增加的y长度，增加的x长度 
      END IF     
      CALL drawLineWidth(1)        
      IF NOT cl_null(g_min) THEN
         IF l_cnt = 1 THEN
            #设置x，y轴的刻度
            CALL DrawFillColor("black")     
            LET id = drawText(100,100+50*1,l_msg1)
            LET id = drawText(100,100+50*2,l_msg2)
            LET id = drawText(100,100+50*3,l_msg3)
            LET id = drawText(100,100+50*4,l_msg4)
            LET id = drawText(100,100+50*5,l_msg5)
            LET id = drawText(100,100+50*6,l_msg6)
            LET id = drawText(100,100+50*7,l_msg7)
            LET id = drawText(100,100+50*8,l_msg8)
            LET id = drawText(100,100+50*9,l_msg9)
            LET id = drawText(100,100+50*10,l_msg10)
            LET id = drawText(100,100+50*11,l_msg11)
            LET id = drawText(100,100+50*12,l_msg12)
            LET id = drawText(100,100+50*13,l_msg13)
            LET id = drawText(100,100+50*14,l_msg14)
            LET id = drawText(100,100+50*15,l_msg15)
            LET id = drawText(100,100+50*16,l_msg16)
            LET id = drawText(100,100+50*17,l_msg17)
            CALL aglq860_drawsety1(l_length,0)   
            CALL aglq860_drawsety1(l_length,1) 
            CALL aglq860_drawsety1(l_length,2) 
            CALL aglq860_drawsety1(l_length,3)   
            CALL aglq860_drawsety1(l_length,4) 
            CALL aglq860_drawsety1(l_length,5) 
            CALL aglq860_drawsety1(l_length,6)   
            CALL aglq860_drawsety1(l_length,7) 
            CALL aglq860_drawsety1(l_length,8) 
            CALL aglq860_drawsety1(l_length,9)
            CALL aglq860_drawsety1(l_length,10)    
         END IF    
         LET l_cnt = l_cnt + 1        
          
         #设置颜色
         IF l_i = 1 THEN
            CALL DrawFillColor("#003366")  
         END IF  
         IF l_i = 2 THEN
            CALL DrawFillColor("red")  
         END IF 
         IF l_i = 3 THEN
            CALL DrawFillColor("blue")  
         END IF 
         IF l_i = 4 THEN
            CALL DrawFillColor("green")  
         END IF 
         IF l_i = 5 THEN
            CALL DrawFillColor("#FF1493")  
         END IF  
         IF l_i = 6 THEN
            CALL DrawFillColor("#ADD8E6")  
         END IF 
         IF l_i = 7 THEN
            CALL DrawFillColor("#F0E68C")  
         END IF 
         IF l_i = 8 THEN
            CALL DrawFillColor("#00008B")  
         END IF
         IF l_i = 9 THEN
            CALL DrawFillColor("#9ACD32")  
         END IF  
         IF l_i = 10 THEN
            CALL DrawFillColor("#black")  
         END IF 
         IF l_i > 10 THEN
            CALL DrawFillColor("black")  
         END IF  
         IF l_i >=1 THEN
            IF NOT cl_null(l_p19) THEN
               LET id = drawText(l_p15,120,g_hx[l_i].glfe004)          
            ELSE
               LET id = drawText(l_p1,120+50*5,g_hx[l_i].glfe004)
            END IF
         END IF

         IF l_glfe010 = 'Y' AND NOT cl_null(l_p15) THEN
            LET id = drawline(l_p15,80,0,1000-80)
         END IF 	 
         #设置颜色的标识 
         IF NOT cl_null(g_hx[l_i].glfe004) THEN 
            IF l_i = 1 THEN
               LET g_l_i = 0 
            END IF
            LET id = DrawRectangle(30,140*(l_i-1)+30+g_l_i,30,30)
            LET g_l_i = g_l_i+length(g_hx[l_i].glfe004)
            LET id = drawText(30,140*(l_i-1)+90+g_l_i,g_hx[l_i].glfe004) 
         END IF 
         
         #画线       
         IF NOT cl_null(l_p15) AND NOT cl_null(l_p16) THEN    
            LET id = drawLine(l_p15,100+50*1,l_p16-l_p15,50)
         END IF
         IF NOT cl_null(l_p16) AND NOT cl_null(l_p17) THEN    
            LET id = drawLine(l_p16,100+50*2,l_p17-l_p16,50) 
         END IF 
         IF NOT cl_null(l_p17) AND NOT cl_null(l_p18) THEN    
            LET id = drawLine(l_p17,100+50*3,l_p18-l_p17,50) 
         END IF 
         IF NOT cl_null(l_p18) AND NOT cl_null(l_p19) THEN    
            LET id = drawLine(l_p18,100+50*4,l_p19-l_p18,50) 
         END IF 
         IF NOT cl_null(l_p19) AND NOT cl_null(l_p1) THEN    
            LET id = drawLine(l_p19,100+50*5,l_p1-l_p19,50) 
         END IF     
         IF NOT cl_null(l_p1) AND NOT cl_null(l_p2) THEN    
            LET id = drawLine(l_p1,100+50*6,l_p2-l_p1,50) 
         END IF
         IF NOT cl_null(l_p2) AND NOT cl_null(l_p3) THEN    
            LET id = drawLine(l_p2,100+50*7,l_p3-l_p2,50) 
         END IF 
         IF NOT cl_null(l_p3) AND NOT cl_null(l_p4) THEN   
            LET id = drawLine(l_p3,100+50*8,l_p4-l_p3,50) 
         END IF 
         IF NOT cl_null(l_p4) AND NOT cl_null(l_p5) THEN   
            LET id = drawLine(l_p4,100+50*9,l_p5-l_p4,50) 
         END IF    
         IF NOT cl_null(l_p5) AND NOT cl_null(l_p6) THEN  
            LET id = drawLine(l_p5,100+50*10,l_p6-l_p5,50)
         END IF 
         IF NOT cl_null(l_p6) AND NOT cl_null(l_p7) THEN  
            LET id = drawLine(l_p6,100+50*11,l_p7-l_p6,50)
         END IF 
         IF NOT cl_null(l_p7) AND NOT cl_null(l_p8) THEN  
            LET id = drawLine(l_p7,100+50*12,l_p8-l_p7,50)
         END IF 
         IF NOT cl_null(l_p8) AND NOT cl_null(l_p9) THEN   
            LET id = drawLine(l_p8,100+50*13,l_p9-l_p8,50)
         END IF 
         IF NOT cl_null(l_p9) AND NOT cl_null(l_p10) THEN   
            LET id = drawLine(l_p9,100+50*14,l_p10-l_p9,50)
         END IF    
         IF NOT cl_null(l_p10) AND NOT cl_null(l_p11) THEN   
            LET id = drawLine(l_p10,100+50*15,l_p11-l_p10,50)
         END IF 
         IF NOT cl_null(l_p11) AND NOT cl_null(l_p12) THEN    
            LET id = drawLine(l_p11,100+50*16,l_p12-l_p11,50)
         END IF 
         
         #标明那个点     
         CALL aglq860_p(l_p15,1)
         CALL aglq860_p(l_p16,2)
         CALL aglq860_p(l_p17,3) 
         CALL aglq860_p(l_p18,4)
         CALL aglq860_p(l_p19,5)
         CALL aglq860_p(l_p1,6)
         CALL aglq860_p(l_p2,7)
         CALL aglq860_p(l_p3,8) 
         CALL aglq860_p(l_p4,9) 
         CALL aglq860_p(l_p5,10)
         CALL aglq860_p(l_p6,11)
         CALL aglq860_p(l_p7,12) 
         CALL aglq860_p(l_p8,13)
         CALL aglq860_p(l_p9,14)  
         CALL aglq860_p(l_p10,15)   
         CALL aglq860_p(l_p11,16)
         CALL aglq860_p(l_p12,17)
      END IF  
   END FOR                              
   CALL drawInit()      
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
PRIVATE FUNCTION aglq860_b_pic()
   DEFINE id          LIKE type_t.num10
   DEFINE l_glfe011   LIKE glfe_t.glfe011
   DEFINE l_count     LIKE type_t.num10
   DEFINE l_t         LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_while     LIKE type_t.chr1
   
   SELECT COUNT(*) INTO l_count FROM glfe_t
    WHERE glfeent = g_enterprise
      AND glfe001 = tm.glfd001
      AND glfe011 = 'Y'
   IF cl_null(l_count) OR l_count = 0 THEN
   	 INITIALIZE g_errparam TO NULL 
       LET g_errparam.extend = "" 
       LET g_errparam.code   = 'agl-00506'
       LET g_errparam.popup  = TRUE 
       CALL cl_err()
   	 RETURN
   END IF 	     
    	  
   LET g_action_choice = " " 	 
   INPUT g_yb_m1 WITHOUT DEFAULTS FROM yb_m1
   BEFORE INPUT  
      IF cl_null(g_yb_m1) THEN
      	  LET g_yb_m1 = 1
      	  LET g_pi = 0
         CALL aglq860_drawclear()
	       FOR l_i = 1 TO g_detail_cnt 
	           SELECT glfe011 INTO l_glfe011 FROM glfe_t
	            WHERE glfeent = g_enterprise
	              AND glfe001 = tm.glfd001
	              AND glfeseq = g_glfe_d[l_i].glfeseq
	           IF l_glfe011 = 'Y' AND l_count > 1 AND NOT cl_null(g_glfe_d[l_i].glfe012) THEN
	           	 LET g_pi = g_pi + 1
	           	 CALL aglq860_drawcir(l_i,g_yb_m1) 
	           END IF 	
	       END FOR     
      END IF 	  
      DISPLAY g_yb_m1 TO yb_m1 
         
      ON CHANGE yb_m1
         LET g_pi = 0
         CALL aglq860_drawclear()
	      FOR l_i = 1 TO g_detail_cnt 
	          SELECT glfe011 INTO l_glfe011 FROM glfe_t
	           WHERE glfeent = g_enterprise
	             AND glfe001 = tm.glfd001
	             AND glfeseq = g_glfe_d[l_i].glfeseq
	          IF l_glfe011 = 'Y' AND l_count > 1 AND NOT cl_null(g_glfe_d[l_i].glfe012) THEN
	          	 LET g_pi = g_pi + 1
	          	 CALL aglq860_drawcir(l_i,g_yb_m1) 
	          END IF 	
	      END FOR       
      AFTER INPUT
         IF INT_FLAG THEN
            EXIT INPUT
         END IF
     
     ON ACTION CONTROLG 
        CALL cl_cmdask()     
     
     ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
     
     ON ACTION about
        CALL cl_about()
     
     ON ACTION accept 
        EXIT INPUT 
        
     ON ACTION cancel
        LET g_action_choice="exit"
        LET INT_FLAG = 1
        EXIT INPUT 
    
     ON ACTION exit
        LET INT_FLAG = 1 
        EXIT INPUT  
        
     ON ACTION qbe_save
        CALL cl_qbe_save()
   END INPUT
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   END IF
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
PRIVATE FUNCTION aglq860_drawclear()
   DEFINE l_str       LIKE type_t.chr30	
   DEFINE l_i         LIKE type_t.num10
   DEFINE l_sql      STRING
   
   FOR l_i = 11 TO 22
       LET l_sql = "SELECT 'cv'||replace(",aglq860_tp_tochar(l_i,'999'),",' ','') FROM DUAL" 
       PREPARE aglq860_sel_prep9 FROM l_sql
       EXECUTE aglq860_sel_prep9 INTO l_str
       CALL drawselect(l_str)
       CALL drawclear()
       CALL drawinit()
   END FOR    
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
PRIVATE FUNCTION aglq860_drawcir(p_i,p_mm)
   DEFINE id          LIKE type_t.num10
   DEFINE l_x         float
   DEFINE l_y         float
   DEFINE p_i         LIKE type_t.num10
   DEFINE p_mm        LIKE type_t.chr10
   DEFINE l_mm        LIKE type_t.chr30 
   DEFINE l_len       LIKE type_t.num20_6 
   DEFINE l_str       LIKE type_t.chr30
   DEFINE l_b_mm      LIKE type_t.num10
   DEFINE l_num       LIKE type_t.chr30
   DEFINE l_t15       LIKE glfe_t.glfe012
   DEFINE l_t16       LIKE glfe_t.glfe013
   DEFINE l_t17       LIKE glfe_t.glfe014
   DEFINE l_t18       LIKE glfe_t.glfe015
   DEFINE l_t19       LIKE glfe_t.glfe016
   DEFINE l_sql       STRING
   DEFINE l_str1      STRING
   CASE p_mm 
     WHEN '1'   LET l_mm = g_glfe_d[p_i].tot01 LET l_b_mm = tm.b_mm01
     WHEN '2'   LET l_mm = g_glfe_d[p_i].tot02 LET l_b_mm = tm.b_mm02
     WHEN '3'   LET l_mm = g_glfe_d[p_i].tot03 LET l_b_mm = tm.b_mm03
     WHEN '4'   LET l_mm = g_glfe_d[p_i].tot04 LET l_b_mm = tm.b_mm04
     WHEN '5'   LET l_mm = g_glfe_d[p_i].tot05 LET l_b_mm = tm.b_mm05
     WHEN '6'   LET l_mm = g_glfe_d[p_i].tot06 LET l_b_mm = tm.b_mm06
     WHEN '7'   LET l_mm = g_glfe_d[p_i].tot07 LET l_b_mm = tm.b_mm07
     WHEN '8'   LET l_mm = g_glfe_d[p_i].tot08 LET l_b_mm = tm.b_mm08
     WHEN '9'   LET l_mm = g_glfe_d[p_i].tot09 LET l_b_mm = tm.b_mm09
     WHEN '10'  LET l_mm = g_glfe_d[p_i].tot10 LET l_b_mm = tm.b_mm10
     WHEN '11'  LET l_mm = g_glfe_d[p_i].tot11 LET l_b_mm = tm.b_mm11
     WHEN '12'  LET l_mm = g_glfe_d[p_i].tot12 LET l_b_mm = tm.b_mm12
   END CASE 
   IF cl_null(l_mm) OR cl_null(l_b_mm) THEN
       LET g_pi = g_pi -1 
       RETURN
   END IF    
 
   SELECT replace(l_mm,' ','') INTO l_mm FROM DUAL  
   IF g_pi <10 THEN
      LET l_sql = "SELECT 'cv1'||replace(",aglq860_tp_tochar(g_pi,'999'),",' ','') FROM DUAL"
   ELSE 
      LET l_sql = "SELECT 'cv'||replace(",aglq860_tp_tochar(g_pi+10,'999'),",' ','') FROM DUAL" 
   END IF   
   PREPARE q860_sel_prep2 FROM l_sql
   EXECUTE q860_sel_prep2 INTO l_str 
   CALL drawselect(l_str)
   CALL drawclear()
   CALL drawLineWidth(1) 
   CALL DrawFillColor("white")
   LET id=drawArc(900,50,900,0,180)
   CALL DrawFillColor("red")
   LET id=drawArc(900,50,900,150,30)
   CALL DrawFillColor("yellow")
   LET id=drawArc(900,50,900,120,30)
   CALL DrawFillColor("green")
   LET id=drawArc(900,50,900,90,30)
   CALL DrawFillColor("blue")
   LET id=drawArc(900,50,900,60,30)
   CALL DrawFillColor("purple")
   LET id=drawArc(900,50,900,30,30) 
   CALL DrawFillColor("gray")
   LET id=drawArc(900,50,900,0,30) 
   CALL DrawFillColor("white")
   LET id=drawArc(700,250,500,0,180)
   CALL DrawFillColor("blue")
   CALL drawLineWidth(20)
   IF g_glfe_d[p_i].glfe012 > g_glfe_d[p_i].glfe013 THEN
       LET l_t15 = g_glfe_d[p_i].glfe012 
       LET l_t16 = g_glfe_d[p_i].glfe013 
       LET l_t17 = g_glfe_d[p_i].glfe014 
       LET l_t18 = g_glfe_d[p_i].glfe015 
       LET l_t19 = g_glfe_d[p_i].glfe016
   ELSE            
       LET l_t15 = g_glfe_d[p_i].glfe016 
       LET l_t16 = g_glfe_d[p_i].glfe015 
       LET l_t17 = g_glfe_d[p_i].glfe014 
       LET l_t18 = g_glfe_d[p_i].glfe013
       LET l_t19 = g_glfe_d[p_i].glfe012
   END IF          
   IF l_mm <= l_t19 THEN  
      IF l_mm >= 0 THEN 
         LET l_len = l_t19
         SELECT 350*cos(5/6*PI+1/6*PI*(l_t19 - l_mm)/l_len) INTO l_x FROM dual
         SELECT 350*sin(5/6*PI+1/6*PI*(l_t19 - l_mm)/l_len) INTO l_y FROM dual
      END IF 
      IF l_mm < 0 AND l_t19 >= 0 THEN 
        SELECT 350*cos(5/6*PI+1/6*PI*1/2) INTO l_x FROM dual
         SELECT 350*sin(5/6*PI+1/6*PI*1/2) INTO l_y FROM dual   
      END IF   
      IF l_mm < 0 AND l_t19 < 0 THEN 
         LET l_len = (0-l_t19)*10
        IF l_mm < 0 -l_len THEN
            SELECT 350*cos(0.00001-PI) INTO l_x FROM dual
            SELECT 350*sin(0.00001-PI) INTO l_y FROM dual
         ELSE     
             SELECT 350*cos(5/6*PI+1/6*PI*(l_t19 - l_mm)/l_len) INTO l_x FROM dual
            SELECT 350*sin(5/6*PI+1/6*PI*(l_t19 - l_mm)/l_len) INTO l_y FROM dual 
         END IF   
      END IF     
   END IF  
   IF l_mm > l_t19 AND l_mm <= l_t18 THEN 
      LET l_len = l_t18 - l_t19 
      SELECT 350*cos(4/6*PI+1/6*PI*(l_t18-l_mm)/l_len) INTO l_x FROM dual
      SELECT 350*sin(4/6*PI+1/6*PI*(l_t18-l_mm)/l_len) INTO l_y FROM dual   
   END IF      
   IF l_mm > l_t18 AND l_mm <= l_t17 THEN 
      LET l_len = l_t17 - l_t18 
      SELECT 350*cos(3/6*PI+1/6*PI*(l_t17-l_mm)/l_len) INTO l_x FROM dual
      SELECT 350*sin(3/6*PI+1/6*PI*(l_t17-l_mm)/l_len) INTO l_y FROM dual   
   END IF     
   IF l_mm > l_t17 AND l_mm <= l_t16 THEN 
      LET l_len = l_t16 - l_t17 
      SELECT 350*cos(2/6*PI+1/6*PI*(l_t16-l_mm)/l_len) INTO l_x FROM dual
      SELECT 350*sin(2/6*PI+1/6*PI*(l_t16-l_mm)/l_len) INTO l_y FROM dual   
   END IF         
   IF l_mm > l_t16 AND l_mm <= l_t15 THEN 
      LET l_len = l_t15 - l_t16 
      SELECT 350*cos(1/6*PI+1/6*PI*(l_t15-l_mm)/l_len) INTO l_x FROM dual
      SELECT 350*sin(1/6*PI+1/6*PI*(l_t15-l_mm)/l_len) INTO l_y FROM dual   
   END IF     
   IF l_mm >= l_t15 THEN   
      IF l_mm < 0  THEN 
         LET l_len = (0-l_t15) 
        SELECT 350*cos(1/6*PI-1/6*PI*(l_mm-l_t15)/l_len) INTO l_x FROM dual
         SELECT 350*sin(1/6*PI-1/6*PI*(l_mm-l_t15)/l_len) INTO l_y FROM dual    
      END IF   
      IF l_mm >= 0 AND l_t15 < 0 THEN 
         SELECT 350*cos(1/6*PI-1/6*PI*1/2) INTO l_x FROM dual
         SELECT 350*sin(1/6*PI-1/6*PI*1/2) INTO l_y FROM dual 
      END IF     
      IF l_t15 > 0 THEN 
         LET l_len = l_t15*10
         IF l_mm > l_len THEN
            SELECT 350*cos(0.00001) INTO l_x FROM dual
            SELECT 350*sin(0.00001-PI) INTO l_y FROM dual
         ELSE     
            SELECT 350*cos(1/6*PI-1/6*PI*(l_mm-l_t15)/l_len) INTO l_x FROM dual
            SELECT 350*sin(1/6*PI-1/6*PI*(l_mm-l_t15)/l_len) INTO l_y FROM dual 
         END IF   
      END IF     
   END IF       
     
   LET id = drawline(450,500,l_y,l_x) 
   CALL DrawFillColor("black")
   LET id = drawText(100,500,g_glfe_d[p_i].glfe004)   
   IF NOT cl_null(l_t19) THEN
      SELECT 470*cos(5/6*PI) INTO l_x FROM dual
      SELECT 470*sin(5/6*PI) INTO l_y FROM dual 
      LET l_str1 = "round(",l_t19,",4)"
      LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_str1,'fm990.0'),",' ','') FROM DUAL"  
      PREPARE q860_sel_prep3 FROM l_sql
      EXECUTE q860_sel_prep3 INTO l_num
      LET id = drawText(450+l_y+10,450+l_x+10,l_num)
   END IF   
   IF NOT cl_null(l_t18) THEN
      SELECT 470*cos(4/6*PI) INTO l_x FROM dual
      SELECT 470*sin(4/6*PI) INTO l_y FROM dual 
      LET l_str1 = "round(",l_t18,",4)"
      LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_str1,'fm990.0'),",' ','') FROM DUAL"  
      PREPARE q860_sel_prep4 FROM l_sql
      EXECUTE q860_sel_prep4 INTO l_num
      LET id = drawText(450+l_y,450+l_x,l_num)
   END IF 
   IF NOT cl_null(l_t17) THEN
      SELECT 470*cos(3/6*PI) INTO l_x FROM dual
      SELECT 470*sin(3/6*PI) INTO l_y FROM dual 
      LET l_str1 = "round(",l_t17,",4)"
      LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_str1,'fm990.0'),",' ','') FROM DUAL"  
      PREPARE q860_sel_prep5 FROM l_sql
      EXECUTE q860_sel_prep5 INTO l_num
      LET id = drawText(450+l_y,450+l_x+40,l_num)
   END IF
   IF NOT cl_null(l_t16) THEN
      SELECT 470*cos(2/6*PI) INTO l_x FROM dual
      SELECT 470*sin(2/6*PI) INTO l_y FROM dual 
      LET l_str1 = "round(",l_t16,",4)"
      LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_str1,'fm990.0'),",' ','') FROM DUAL"  
      PREPARE q860_sel_prep6 FROM l_sql
      EXECUTE q860_sel_prep6 INTO l_num
      LET id = drawText(450+l_y,450+l_x+50,l_num)
   END IF 
   IF NOT cl_null(l_t15) THEN
      SELECT 470*cos(1/6*PI) INTO l_x FROM dual
      SELECT 470*sin(1/6*PI) INTO l_y FROM dual 
      LET l_str1 = "round(",l_t15,",4)"
      LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_str1,'fm990.0'),",' ','') FROM DUAL"  
      PREPARE q860_sel_prep7 FROM l_sql
      EXECUTE q860_sel_prep7 INTO l_num
      LET id = drawText(450+l_y+10,450+l_x+90,l_num)
   END IF         
   LET l_sql = "SELECT replace(",aglq860_tp_tochar(l_mm,'fm990.0'),",' ','') FROM DUAL"  
   PREPARE q860_sel_prep8 FROM l_sql
   EXECUTE q860_sel_prep8 INTO l_num
   LET id = drawText(200,500,l_mm)   
END FUNCTION

 
{</section>}
 
