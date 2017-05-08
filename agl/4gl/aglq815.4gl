#該程式未解開Section, 採用最新樣板產出!
{<section id="aglq815.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-04-19 11:00:44), PR版次:0002(2016-08-01 15:39:14)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: aglq815
#+ Description: 所有者權益變動表查詢
#+ Creator....: 02599(2016-04-18 12:09:49)
#+ Modifier...: 02599 -SD/PR- 08742
 
{</section>}
 
{<section id="aglq815.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160727-00019#3  2016/08/01  By 08742  系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                      Mod   aglq815_print_tmp -->aglq815_tmp01
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
       
       sel LIKE type_t.chr1, 
   glfb001 LIKE glfb_t.glfb001, 
   glfbseq LIKE glfb_t.glfbseq, 
   glfbseq1 LIKE glfb_t.glfbseq1, 
   amt1 LIKE type_t.chr500, 
   amt2 LIKE type_t.chr500, 
   amt3 LIKE type_t.chr500, 
   amt4 LIKE type_t.chr500, 
   amt5 LIKE type_t.chr500, 
   amt6 LIKE type_t.chr500, 
   amt7 LIKE type_t.chr500, 
   amt8 LIKE type_t.chr500, 
   amt9 LIKE type_t.chr500, 
   amt10 LIKE type_t.chr500, 
   amt11 LIKE type_t.chr500, 
   amt12 LIKE type_t.chr500, 
   amt13 LIKE type_t.chr500, 
   amt14 LIKE type_t.chr500, 
   amt15 LIKE type_t.chr500, 
   amt16 LIKE type_t.chr500, 
   amt17 LIKE type_t.chr500, 
   amt18 LIKE type_t.chr500, 
   amt19 LIKE type_t.chr500, 
   amt20 LIKE type_t.chr500, 
   amt21 LIKE type_t.chr500, 
   amt22 LIKE type_t.chr500, 
   amt23 LIKE type_t.chr500, 
   amt24 LIKE type_t.chr500, 
   amt25 LIKE type_t.chr500, 
   amt26 LIKE type_t.chr500, 
   amt27 LIKE type_t.chr500, 
   amt28 LIKE type_t.chr500, 
   amt29 LIKE type_t.chr500, 
   amt30 LIKE type_t.chr500, 
   amt31 LIKE type_t.chr500, 
   amt32 LIKE type_t.chr500, 
   amt33 LIKE type_t.chr500, 
   amt34 LIKE type_t.chr500, 
   amt35 LIKE type_t.chr500, 
   amt36 LIKE type_t.chr500, 
   amt37 LIKE type_t.chr500, 
   amt38 LIKE type_t.chr500, 
   amt39 LIKE type_t.chr500, 
   amt40 LIKE type_t.chr500, 
   amt41 LIKE type_t.chr500, 
   amt42 LIKE type_t.chr500, 
   amt43 LIKE type_t.chr500, 
   amt44 LIKE type_t.chr500, 
   amt45 LIKE type_t.chr500, 
   amt46 LIKE type_t.chr500, 
   amt47 LIKE type_t.chr500, 
   amt48 LIKE type_t.chr500, 
   amt49 LIKE type_t.chr500, 
   amt50 LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_input             RECORD 
       glfa001             LIKE glfa_t.glfa001,
       glfa001_desc        LIKE glfal_t.glfal003,
       glfa005             LIKE glfa_t.glfa005,
       glfa005_desc        LIKE glaal_t.glaal002,
       glfa006             LIKE glfa_t.glfa006,
       glfa007             LIKE glfa_t.glfa007,
       glfa008             LIKE glfa_t.glfa008,
       glfa009             LIKE glfa_t.glfa009
       END RECORD

#end add-point
 
#模組變數(Module Variables)
DEFINE g_glfb_d            DYNAMIC ARRAY OF type_g_glfb_d
DEFINE g_glfb_d_t          type_g_glfb_d
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
DEFINE g_wc_filter_table           STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aglq815.main" >}
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
   DECLARE aglq815_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE aglq815_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aglq815_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aglq815 WITH FORM cl_ap_formpath("agl",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aglq815_init()   
 
      #進入選單 Menu (="N")
      CALL aglq815_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aglq815
      
   END IF 
   
   CLOSE aglq815_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE aglq815_tmp01;         #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aglq815.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aglq815_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('glfa008','8705')
   CALL aglq815_add_style()
   CALL aglq815_create_temp_for_gr()
   #end add-point
 
   CALL aglq815_default_search()
END FUNCTION
 
{</section>}
 
{<section id="aglq815.default_search" >}
PRIVATE FUNCTION aglq815_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " glfb001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " glfbseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " glfbseq1 = '", g_argv[03], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="aglq815.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aglq815_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   #因模板产生程序在Before dialog 中有NEXT FIELD glfa001导致程序无法退出，
   #找不到其他方法是模板不产生NEXT FIELD glfa001,只好重写这个函数
   CALL aglq815_ui_dialog_1()
   RETURN
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
   CALL aglq815_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aglq815_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq815_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq815_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
 
         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq815_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD glfa001
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
         
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL aglq815_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
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
 
         ON ACTION datarefresh   # 重新整理
            CALL aglq815_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL aglq815_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq815_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq815_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq815_b_fill()
 
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
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq815_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
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
               
               #add-point:ON ACTION query name="menu.query"
               CALL aglq815_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="aglq815.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aglq815_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   #當沒有輸入報表模板編號時無法顯示報表
   IF cl_null(g_input.glfa001) THEN
      RETURN
   END IF
   CALL aglq815_b_fill1()
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_glfb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb001,glfbseq,glfbseq1,'','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '','','','','','',''  ,DENSE_RANK() OVER( ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK FROM glfb_t", 
 
 
 
                     "",
                     " WHERE glfbent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
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
 
   LET g_sql = "SELECT '',glfb001,glfbseq,glfbseq1,'','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq815_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR aglq815_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb001,g_glfb_d[l_ac].glfbseq,g_glfb_d[l_ac].glfbseq1, 
       g_glfb_d[l_ac].amt1,g_glfb_d[l_ac].amt2,g_glfb_d[l_ac].amt3,g_glfb_d[l_ac].amt4,g_glfb_d[l_ac].amt5, 
       g_glfb_d[l_ac].amt6,g_glfb_d[l_ac].amt7,g_glfb_d[l_ac].amt8,g_glfb_d[l_ac].amt9,g_glfb_d[l_ac].amt10, 
       g_glfb_d[l_ac].amt11,g_glfb_d[l_ac].amt12,g_glfb_d[l_ac].amt13,g_glfb_d[l_ac].amt14,g_glfb_d[l_ac].amt15, 
       g_glfb_d[l_ac].amt16,g_glfb_d[l_ac].amt17,g_glfb_d[l_ac].amt18,g_glfb_d[l_ac].amt19,g_glfb_d[l_ac].amt20, 
       g_glfb_d[l_ac].amt21,g_glfb_d[l_ac].amt22,g_glfb_d[l_ac].amt23,g_glfb_d[l_ac].amt24,g_glfb_d[l_ac].amt25, 
       g_glfb_d[l_ac].amt26,g_glfb_d[l_ac].amt27,g_glfb_d[l_ac].amt28,g_glfb_d[l_ac].amt29,g_glfb_d[l_ac].amt30, 
       g_glfb_d[l_ac].amt31,g_glfb_d[l_ac].amt32,g_glfb_d[l_ac].amt33,g_glfb_d[l_ac].amt34,g_glfb_d[l_ac].amt35, 
       g_glfb_d[l_ac].amt36,g_glfb_d[l_ac].amt37,g_glfb_d[l_ac].amt38,g_glfb_d[l_ac].amt39,g_glfb_d[l_ac].amt40, 
       g_glfb_d[l_ac].amt41,g_glfb_d[l_ac].amt42,g_glfb_d[l_ac].amt43,g_glfb_d[l_ac].amt44,g_glfb_d[l_ac].amt45, 
       g_glfb_d[l_ac].amt46,g_glfb_d[l_ac].amt47,g_glfb_d[l_ac].amt48,g_glfb_d[l_ac].amt49,g_glfb_d[l_ac].amt50 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL aglq815_detail_show("'1'")
 
      CALL aglq815_glfb_t_mask()
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_glfb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE aglq815_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq815_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq815_detail_action_trans()
 
   LET l_ac = 1
   IF g_glfb_d.getLength() > 0 THEN
      CALL aglq815_b_fill2()
   END IF
 
      CALL aglq815_filter_show('glfb001','b_glfb001')
   CALL aglq815_filter_show('glfbseq','b_glfbseq')
   CALL aglq815_filter_show('glfbseq1','b_glfbseq1')
 
 
END FUNCTION
 
{</section>}
 
{<section id="aglq815.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aglq815_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="aglq815.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION aglq815_detail_show(ps_page)
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
 
{<section id="aglq815.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION aglq815_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON glfb001,glfbseq,glfbseq1
                          FROM s_detail1[1].b_glfb001,s_detail1[1].b_glfbseq,s_detail1[1].b_glfbseq1
 
         BEFORE CONSTRUCT
                     DISPLAY aglq815_filter_parser('glfb001') TO s_detail1[1].b_glfb001
            DISPLAY aglq815_filter_parser('glfbseq') TO s_detail1[1].b_glfbseq
            DISPLAY aglq815_filter_parser('glfbseq1') TO s_detail1[1].b_glfbseq1
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_glfb001>>----
         #Ctrlp:construct.c.filter.page1.b_glfb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfb001
            #add-point:ON ACTION controlp INFIELD b_glfb001 name="construct.c.filter.page1.b_glfb001"
            
            #END add-point
 
 
         #----<<b_glfbseq>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq
            #add-point:ON ACTION controlp INFIELD b_glfbseq name="construct.c.filter.page1.b_glfbseq"
            
            #END add-point
 
 
         #----<<b_glfbseq1>>----
         #Ctrlp:construct.c.filter.page1.b_glfbseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_glfbseq1
            #add-point:ON ACTION controlp INFIELD b_glfbseq1 name="construct.c.filter.page1.b_glfbseq1"
            
            #END add-point
 
 
         #----<<amt1>>----
         #----<<amt2>>----
         #----<<amt3>>----
         #----<<amt4>>----
         #----<<amt5>>----
         #----<<amt6>>----
         #----<<amt7>>----
         #----<<amt8>>----
         #----<<amt9>>----
         #----<<amt10>>----
         #----<<amt11>>----
         #----<<amt12>>----
         #----<<amt13>>----
         #----<<amt14>>----
         #----<<amt15>>----
         #----<<amt16>>----
         #----<<amt17>>----
         #----<<amt18>>----
         #----<<amt19>>----
         #----<<amt20>>----
         #----<<amt21>>----
         #----<<amt22>>----
         #----<<amt23>>----
         #----<<amt24>>----
         #----<<amt25>>----
         #----<<amt26>>----
         #----<<amt27>>----
         #----<<amt28>>----
         #----<<amt29>>----
         #----<<amt30>>----
         #----<<amt31>>----
         #----<<amt32>>----
         #----<<amt33>>----
         #----<<amt34>>----
         #----<<amt35>>----
         #----<<amt36>>----
         #----<<amt37>>----
         #----<<amt38>>----
         #----<<amt39>>----
         #----<<amt40>>----
         #----<<amt41>>----
         #----<<amt42>>----
         #----<<amt43>>----
         #----<<amt44>>----
         #----<<amt45>>----
         #----<<amt46>>----
         #----<<amt47>>----
         #----<<amt48>>----
         #----<<amt49>>----
         #----<<amt50>>----
 
 
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL aglq815_filter_show('glfb001','b_glfb001')
   CALL aglq815_filter_show('glfbseq','b_glfbseq')
   CALL aglq815_filter_show('glfbseq1','b_glfbseq1')
 
 
   CALL aglq815_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="aglq815.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION aglq815_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="aglq815.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION aglq815_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = aglq815_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="aglq815.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION aglq815_detail_action_trans()
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
 
{<section id="aglq815.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION aglq815_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
 
{<section id="aglq815.mask_functions" >}
 &include "erp/agl/aglq815_mask.4gl"
 
{</section>}
 
{<section id="aglq815.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢操作
# Memo...........:
# Usage..........: CALL aglq815_query()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_query()
   DEFINE l_glfa004  LIKE glfa_t.glfa004
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_glfa002  LIKE glfa_t.glfa002
   DEFINE l_glav002  LIKE glav_t.glav002
   DEFINE l_glav006  LIKE glav_t.glav006
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_pass     LIKE type_t.num5
   DEFINE l_glaa001  LIKE glaa_t.glaa001
   DEFINE l_glaa003  LIKE glaa_t.glaa003
   DEFINE l_glaa026  LIKE glaa_t.glaa026
   
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_glfb_d.clear()
 
   #帳套
   IF cl_null(g_input.glfa005) THEN
      CALL s_ld_bookno()  RETURNING l_success,g_input.glfa005
      IF l_success = FALSE THEN
         RETURN 
      END IF 
      CALL s_ld_chk_authorization(g_user,g_input.glfa005) RETURNING l_pass
      IF l_pass = FALSE THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'agl-00164'
         LET g_errparam.extend = g_input.glfa005
         LET g_errparam.popup = FALSE
         CALL cl_err()
      
         LET g_input.glfa005=NULL
      END IF
      LET l_glaa001=''
      SELECT glaa001,glaa003,glaa026 INTO l_glaa001,l_glaa003,l_glaa026 FROM glaa_t 
      WHERE glaaent=g_enterprise AND glaald=g_input.glfa005
      CALL s_desc_get_ld_desc(g_input.glfa005) RETURNING g_input.glfa005_desc
      
   END IF
   #當前日期對應的會計週期表中的年度期別
   SELECT DISTINCT glav002,glav006 INTO l_glav002,l_glav006 FROM glav_t
   WHERE glavent=g_enterprise AND glav001=l_glaa003 AND glav004=g_today
   #年度
   IF cl_null(g_input.glfa006) OR g_input.glfa006 = 0 THEN
      LET g_input.glfa006=l_glav002
   END IF
   #期別
   IF cl_null(g_input.glfa007) OR g_input.glfa007 = 0  THEN
      LET g_input.glfa007=l_glav006
   END IF
   #單位
   LET g_input.glfa008='1' 
   #小數位數:预设账套本位币一的设置的小数位数
   IF cl_null(g_input.glfa009) OR g_input.glfa009 =0 THEN
      SELECT ooaj004 INTO g_input.glfa009 FROM ooaj_t
       WHERE ooajent = g_enterprise
         AND ooaj001 = l_glaa026
         AND ooaj002 = l_glaa001
      IF cl_null(g_input.glfa009) OR g_input.glfa009 =0 THEN
         LET g_input.glfa009=2
      END IF
   END IF
   DISPLAY BY NAME g_input.glfa005,g_input.glfa005_desc,g_input.glfa006,g_input.glfa007,
                   g_input.glfa008,g_input.glfa009
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      INPUT BY NAME g_input.glfa001,g_input.glfa005,g_input.glfa006,g_input.glfa007,g_input.glfa008,g_input.glfa009
                    
         ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            
            
         AFTER FIELD glfa001
            IF NOT cl_null(g_input.glfa001) THEN
               SELECT COUNT(*) INTO l_cnt FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=g_input.glfa001 
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00249'
                  LET g_errparam.extend = g_input.glfa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa001
               END IF
               SELECT glfa002 INTO l_glfa002 FROM glfa_t
                WHERE glfaent=g_enterprise AND glfa001=g_input.glfa001 
               IF l_glfa002<>'3' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00255'
                  LET g_errparam.extend = g_input.glfa001
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa001
               END IF
               SELECT glfa004 INTO l_glfa004 FROM glfa_t 
                WHERE glfaent=g_enterprise AND glfa001=g_input.glfa001
            END IF
            SELECT glfal003 INTO g_input.glfa001_desc FROM glfal_t 
             WHERE glfalent=g_enterprise AND glfal001=g_input.glfa001 AND glfal002=g_dlang
            DISPLAY g_input.glfa001_desc TO glfa001_desc
            
         AFTER FIELD glfa005
            IF NOT cl_null(g_input.glfa005) THEN
               SELECT COUNT(*) INTO l_cnt FROM glaa_t
                WHERE glaaent=g_enterprise AND glaald=g_input.glfa005
               IF l_cnt=0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00055'
                  LET g_errparam.extend = g_input.glfa005
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

                  NEXT FIELD glfa005
               END IF
               IF NOT cl_null(g_input.glfa001) THEN
                  SELECT glfa004 INTO l_glfa004 FROM glfa_t 
                   WHERE glfaent=g_enterprise AND glfa001=g_input.glfa001
                  SELECT COUNT(*) INTO l_cnt FROM glaa_t 
                  WHERE glaaent=g_enterprise AND glaald=g_input.glfa005 AND glaa004=l_glfa004
                  IF l_cnt=0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'agl-00242'
                     LET g_errparam.extend = g_input.glfa005
                     LET g_errparam.popup = FALSE
                     CALL cl_err()

                     NEXT FIELD glfa005
                  END IF
               END IF
               CALL s_desc_get_ld_desc(g_input.glfa005) RETURNING g_input.glfa005_desc
               DISPLAY g_input.glfa005_desc TO glfa005_desc
               SELECT glaa003 INTO l_glaa003 FROM glaa_t 
                WHERE glaaent=g_enterprise AND glaald=g_input.glfa005
            END IF
           
         AFTER FIELD glfa007
            IF NOT cl_null(g_input.glfa007) THEN
               SELECT MAX(glav006) INTO l_glav006 FROM glav_t
                WHERE glavent=g_enterprise AND glav001=l_glaa003 AND glav002=g_input.glfa006
               IF NOT cl_null(l_glav006) THEN
                  IF g_input.glfa007>l_glav006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'sub-00427'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
               
                     NEXT FIELD glfa007
                  END IF
               END IF 
            END IF
            
         AFTER FIELD glfa009
            IF NOT cl_ap_chk_Range(g_input.glfa009,"0","1","","","azz-00079",1) THEN
               NEXT FIELD glfa009
            END IF

         ON ACTION controlp INFIELD glfa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_input.glfa001
            LET g_qryparam.where = " glfa002='3' "
            CALL q_glfa001()                          #呼叫開窗
            LET g_input.glfa001 = g_qryparam.return1
            DISPLAY g_input.glfa001 TO glfa001  #顯示到畫面上
            NEXT FIELD glfa001 
               
         ON ACTION controlp INFIELD glfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
       
            LET g_qryparam.default1 = g_input.glfa005        #給予default值
            LET g_qryparam.default2 = "" #glaald #帳別編號
            #給予arg
            LET g_qryparam.arg1 = g_user
            LET g_qryparam.arg2 = g_dept
            IF NOT cl_null(g_input.glfa001) THEN
               SELECT glfa004 INTO l_glfa004 FROM glfa_t 
                WHERE glfaent=g_enterprise AND glfa001=g_input.glfa001
               LET g_qryparam.where = " glaa004='",l_glfa004,"'"
            END IF
            CALL q_authorised_ld()                                #呼叫開窗
       
            LET g_input.glfa005 = g_qryparam.return1              
            DISPLAY g_input.glfa005 TO glfa005            
            NEXT FIELD glfa005
            
      END INPUT
      
      ON ACTION accept
         
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
  
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
 
   END DIALOG
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
   
   LET g_error_show = 1
   CALL aglq815_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
END FUNCTION

################################################################################
# Descriptions...: 重寫單身填充
# Memo...........:
# Usage..........: CALL aglq815_b_fill1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   DEFINE l_glfbseq1      LIKE glfb_t.glfbseq1
   DEFINE l_glfb004       LIKE glfb_t.glfb004
   DEFINE l_glfb005       LIKE glfb_t.glfb005
   DEFINE l_glfb011       LIKE glfb_t.glfb011
   DEFINE l_glfb012       LIKE glfb_t.glfb012
   DEFINE l_amt           LIKE type_t.num20_6
   DEFINE l_str           STRING
   DEFINE l_i             LIKE type_t.num5
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   
   LET ls_wc = " glfb001='",g_input.glfa001,"' AND ",g_wc_filter
 
   CALL g_glfb_d.clear()
 
   
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:8)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',glfb001,glfbseq,'',DENSE_RANK() OVER( ORDER BY glfb_t.glfb001,glfb_t.glfbseq,glfb_t.glfbseq1) AS RANK  FROM glfb_t", 
                     " WHERE glfbent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("glfb_t"),
                     " ORDER BY glfb_t.glfbseq"
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill1_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill1_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
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
 
   LET g_sql = "SELECT UNIQUE '',glfb001,glfbseq,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page

   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE aglq815_pb1 FROM g_sql
   DECLARE b_fill1_curs CURSOR FOR aglq815_pb1
 
   #抓取每個單元格資料
   LET g_sql="SELECT glfbseq1,glfb004,glfb005,glfb011,glfb012 FROM glfb_t",
             " WHERE glfbent=",g_enterprise,
             "   AND glfb001='",g_input.glfa001,"'",
             "   AND glfbseq=?"
   PREPARE aglq815_pb2 FROM g_sql
   DECLARE aglq815_cs2 CURSOR FOR aglq815_pb2
   
   #根據保留的小數位數，確定要去除小數后0的個數
   IF g_input.glfa009 > 0 THEN
      LET l_i = 6 - g_input.glfa009
   ELSE
      #當保留0為小數時，小數點也要去除
      LET l_i = 7
   END IF
   CALL cl_err_collect_init()
 
   OPEN b_fill1_curs USING g_enterprise
 
   FOREACH b_fill1_curs INTO g_glfb_d[l_ac].sel,g_glfb_d[l_ac].glfb001,g_glfb_d[l_ac].glfbseq,g_glfb_d[l_ac].glfbseq1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      #根據坐標抓取每個單元格資料
      FOREACH aglq815_cs2 USING g_glfb_d[l_ac].glfbseq INTO l_glfbseq1,l_glfb004,l_glfb005,l_glfb011,l_glfb012
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #当公式类型为数字时，解析公式计算金额
         IF l_glfb011 = '2' THEN 
            CALL aglq815_get_amt(l_glfb005,l_glfb012) RETURNING l_amt
            LET l_str = l_amt
            LET l_str = l_str.substring(1,l_str.getLength()-l_i)
            LET l_glfb005 = l_str
         END IF
         
         CASE l_glfbseq1
            WHEN 'A'   LET g_glfb_d[l_ac].amt1  = l_glfb005
            WHEN 'B'   LET g_glfb_d[l_ac].amt2  = l_glfb005
            WHEN 'C'   LET g_glfb_d[l_ac].amt3  = l_glfb005
            WHEN 'D'   LET g_glfb_d[l_ac].amt4  = l_glfb005
            WHEN 'E'   LET g_glfb_d[l_ac].amt5  = l_glfb005
            WHEN 'F'   LET g_glfb_d[l_ac].amt6  = l_glfb005
            WHEN 'G'   LET g_glfb_d[l_ac].amt7  = l_glfb005
            WHEN 'H'   LET g_glfb_d[l_ac].amt8  = l_glfb005
            WHEN 'I'   LET g_glfb_d[l_ac].amt9  = l_glfb005
            WHEN 'J'   LET g_glfb_d[l_ac].amt10 = l_glfb005
            WHEN 'K'   LET g_glfb_d[l_ac].amt11 = l_glfb005
            WHEN 'L'   LET g_glfb_d[l_ac].amt12 = l_glfb005
            WHEN 'M'   LET g_glfb_d[l_ac].amt13 = l_glfb005
            WHEN 'N'   LET g_glfb_d[l_ac].amt14 = l_glfb005
            WHEN 'O'   LET g_glfb_d[l_ac].amt15 = l_glfb005
            WHEN 'P'   LET g_glfb_d[l_ac].amt16 = l_glfb005
            WHEN 'Q'   LET g_glfb_d[l_ac].amt17 = l_glfb005
            WHEN 'R'   LET g_glfb_d[l_ac].amt18 = l_glfb005
            WHEN 'S'   LET g_glfb_d[l_ac].amt19 = l_glfb005
            WHEN 'T'   LET g_glfb_d[l_ac].amt20 = l_glfb005
            WHEN 'U'   LET g_glfb_d[l_ac].amt21 = l_glfb005
            WHEN 'V'   LET g_glfb_d[l_ac].amt22 = l_glfb005
            WHEN 'W'   LET g_glfb_d[l_ac].amt23 = l_glfb005
            WHEN 'X'   LET g_glfb_d[l_ac].amt24 = l_glfb005
            WHEN 'Y'   LET g_glfb_d[l_ac].amt25 = l_glfb005
            WHEN 'Z'   LET g_glfb_d[l_ac].amt26 = l_glfb005
            WHEN 'AA'  LET g_glfb_d[l_ac].amt27 = l_glfb005
            WHEN 'AB'  LET g_glfb_d[l_ac].amt28 = l_glfb005
            WHEN 'AC'  LET g_glfb_d[l_ac].amt29 = l_glfb005
            WHEN 'AD'  LET g_glfb_d[l_ac].amt30 = l_glfb005
            WHEN 'AE'  LET g_glfb_d[l_ac].amt31 = l_glfb005
            WHEN 'AF'  LET g_glfb_d[l_ac].amt32 = l_glfb005
            WHEN 'AG'  LET g_glfb_d[l_ac].amt33 = l_glfb005
            WHEN 'AH'  LET g_glfb_d[l_ac].amt34 = l_glfb005
            WHEN 'AI'  LET g_glfb_d[l_ac].amt35 = l_glfb005
            WHEN 'AJ'  LET g_glfb_d[l_ac].amt36 = l_glfb005
            WHEN 'AK'  LET g_glfb_d[l_ac].amt37 = l_glfb005
            WHEN 'AL'  LET g_glfb_d[l_ac].amt38 = l_glfb005
            WHEN 'AM'  LET g_glfb_d[l_ac].amt39 = l_glfb005
            WHEN 'AN'  LET g_glfb_d[l_ac].amt40 = l_glfb005
            WHEN 'AO'  LET g_glfb_d[l_ac].amt41 = l_glfb005
            WHEN 'AP'  LET g_glfb_d[l_ac].amt42 = l_glfb005
            WHEN 'AQ'  LET g_glfb_d[l_ac].amt43 = l_glfb005
            WHEN 'AR'  LET g_glfb_d[l_ac].amt44 = l_glfb005
            WHEN 'AS'  LET g_glfb_d[l_ac].amt45 = l_glfb005
            WHEN 'AT'  LET g_glfb_d[l_ac].amt46 = l_glfb005
            WHEN 'AU'  LET g_glfb_d[l_ac].amt47 = l_glfb005
            WHEN 'AV'  LET g_glfb_d[l_ac].amt48 = l_glfb005
            WHEN 'AW'  LET g_glfb_d[l_ac].amt49 = l_glfb005
            WHEN 'AX'  LET g_glfb_d[l_ac].amt50 = l_glfb005
         END CASE
      END FOREACH
 
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
      LET l_ac = l_ac + 1
 
   END FOREACH
   CALL cl_err_collect_show()
   
   CALL g_glfb_d.deleteElement(g_glfb_d.getLength())
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_glfb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill1_curs
   FREE aglq815_pb1
   
   #隱藏沒有使用的列
   CALL aglq815_set_visible()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL aglq815_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL aglq815_detail_action_trans()
 
   LET l_ac = 1
   IF g_glfb_d.getLength() > 0 THEN
      CALL aglq815_b_fill2()
   END IF
 
   CALL aglq815_filter_show('glfb001','b_glfb001')
   CALL aglq815_filter_show('glfbseq','b_glfbseq')
   CALL aglq815_filter_show('glfbseq1','b_glfbseq1')
END FUNCTION

################################################################################
# Descriptions...: 計算金額
# Memo...........:
# Usage..........: CALL aglq815_get_amt(p_glfb005,p_glfb012)
#                  RETURNING r_amt
# Input parameter: p_glfb005      公式
#                : p_glfb012      计算年度
# Return code....: r_amt          計算結果
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_get_amt(p_glfb005,p_glfb012)
   DEFINE p_glfb004         LIKE glfb_t.glfb004
   DEFINE p_glfb005         LIKE glfb_t.glfb005
   DEFINE p_glfb012         LIKE glfb_t.glfb012
   DEFINE r_amt             LIKE type_t.num20_6
   DEFINE l_glfa006         LIKE glfa_t.glfa006
   DEFINE l_success         LIKE type_t.num5
   
  
   IF NOT cl_null(p_glfb005) THEN
      #上一年度
      IF p_glfb012 = '2' THEN
         LET l_glfa006=g_input.glfa006 - 1
      ELSE
         LET l_glfa006=g_input.glfa006
      END IF
                          #帳別           #年度     #起始期別        #截止期別        #小數位數           
      CALL s_analy_form_2(g_input.glfa005,l_glfa006,g_input.glfa007,g_input.glfa007,g_input.glfa009,
                          #單位            #報表模板編號   #計算公式  #法人 #含審計調整傳票否 #傳票狀態
                          g_input.glfa008,g_input.glfa001,p_glfb005,'', '', '')
      RETURNING l_success,r_amt
   ELSE
      LET r_amt=''
   END IF 
   RETURN r_amt
END FUNCTION

################################################################################
# Descriptions...: 隱藏沒有使用的列
# Memo...........:
# Usage..........: CALL aglq815_set_visible()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/16 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_set_visible()
   DEFINE l_max_seq1   LIKE glfb_t.glfbseq1
   DEFINE l_i          LIKE type_t.num5
   DEFINE l_str        STRING
   DEFINE l_cnt        LIKE type_t.num5
   DEFINE l_col        LIKE type_t.num5
   
   SELECT MAX(glfbseq1) INTO l_max_seq1 FROM glfb_t
    WHERE glfbent=g_enterprise AND glfb001=g_input.glfa001
   LET l_str = l_max_seq1
   LET l_cnt = 0
   LET l_cnt = l_str.getLength()
   #字母‘A’的ASCII值為65，已使用列數 = 最大字母ASCII值 - A字母ASCII值之間 + 1
   IF l_cnt = 1 THEN
      LET l_col = ORD(l_str) - 65 + 1
   ELSE
      #當最大字母長度為2時，表示已查過26列，已使用列數 = 26 + 最大字母第二個字母的ASCII值 - A字母ASCII值之間 + 1
      LET l_col = 26 + ORD(l_str.substring(2,2)) - 65 + 1
   END IF
   
   #顯示已使用的列
   LET l_str=''
   FOR l_i = 1 TO l_col
      IF cl_null(l_str) THEN
         LET l_str="amt",l_i USING '<<<'
      ELSE
         LET l_str=l_str,",amt",l_i USING '<<<'
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str,TRUE)
   
   #隱藏剩下沒有使用的列
   LET l_str=''
   FOR l_i = l_col + 1 TO 50
      IF cl_null(l_str) THEN
         LET l_str="amt",l_i USING '<<<'
      ELSE
         LET l_str=l_str,",amt",l_i USING '<<<'
      END IF
   END FOR
   CALL cl_set_comp_visible(l_str,FALSE)
END FUNCTION

################################################################################
# Descriptions...: 设置单身table不显示title
# Memo...........:
# Usage..........: CALL aglq815_add_style()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_add_style()
   DEFINE lnode_root,lnode_item,lnode_child,lnode_att om.DomNode
   DEFINE llst_styles om.NodeList
   DEFINE li_i SMALLINT

   LET lnode_root = ui.Interface.getRootNode()
   LET llst_styles = lnode_root.selectByTagName("StyleList")
   FOR li_i = 1 TO llst_styles.getLength()
       LET lnode_item = llst_styles.item(li_i)
       LET lnode_child = lnode_item.createChild("Style")   #這邊動態加一個Style節點，等同於<Style>層
       CALL lnode_child.setAttribute("name", "Table.aglq815_tablenotitle")   #指定Style的name
       LET lnode_att = lnode_child.createChild("StyleAttribute")   #動態在Style內加一個Style Attribute，等同於<StyleAttribute>層
       CALL lnode_att.setAttribute("name", "headerHidden")   #指定StyleAttribute的name
       CALL lnode_att.setAttribute("value", "yes")   #指定StyleAttribute的value
       EXIT FOR
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 報表使用建立臨時表
# Memo...........:
# Usage..........: CALL aglq815_create_temp_for_gr()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_create_temp_for_gr()
   DROP TABLE aglq815_tmp01;              #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
   CREATE TEMP TABLE aglq815_tmp01(       #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
         glfaent       LIKE glfa_t.glfaent,
         glfa001       LIKE glfa_t.glfa001,
         glfbseq       LIKE glfb_t.glfbseq,
         amt1          LIKE type_t.chr500, 
         amt2          LIKE type_t.chr500, 
         amt3          LIKE type_t.chr500, 
         amt4          LIKE type_t.chr500, 
         amt5          LIKE type_t.chr500, 
         amt6          LIKE type_t.chr500, 
         amt7          LIKE type_t.chr500, 
         amt8          LIKE type_t.chr500, 
         amt9          LIKE type_t.chr500, 
         amt10         LIKE type_t.chr500, 
         amt11         LIKE type_t.chr500, 
         amt12         LIKE type_t.chr500, 
         amt13         LIKE type_t.chr500, 
         amt14         LIKE type_t.chr500, 
         amt15         LIKE type_t.chr500, 
         amt16         LIKE type_t.chr500, 
         amt17         LIKE type_t.chr500, 
         amt18         LIKE type_t.chr500, 
         amt19         LIKE type_t.chr500, 
         amt20         LIKE type_t.chr500, 
         amt21         LIKE type_t.chr500, 
         amt22         LIKE type_t.chr500, 
         amt23         LIKE type_t.chr500, 
         amt24         LIKE type_t.chr500, 
         amt25         LIKE type_t.chr500, 
         amt26         LIKE type_t.chr500, 
         amt27         LIKE type_t.chr500, 
         amt28         LIKE type_t.chr500, 
         amt29         LIKE type_t.chr500, 
         amt30         LIKE type_t.chr500, 
         amt31         LIKE type_t.chr500, 
         amt32         LIKE type_t.chr500, 
         amt33         LIKE type_t.chr500, 
         amt34         LIKE type_t.chr500, 
         amt35         LIKE type_t.chr500, 
         amt36         LIKE type_t.chr500, 
         amt37         LIKE type_t.chr500, 
         amt38         LIKE type_t.chr500, 
         amt39         LIKE type_t.chr500, 
         amt40         LIKE type_t.chr500, 
         amt41         LIKE type_t.chr500, 
         amt42         LIKE type_t.chr500, 
         amt43         LIKE type_t.chr500, 
         amt44         LIKE type_t.chr500, 
         amt45         LIKE type_t.chr500, 
         amt46         LIKE type_t.chr500, 
         amt47         LIKE type_t.chr500, 
         amt48         LIKE type_t.chr500, 
         amt49         LIKE type_t.chr500, 
         amt50         LIKE type_t.chr500)
END FUNCTION

################################################################################
# Descriptions...: 報表打印
# Memo...........:
# Usage..........: CALL aglq815_output()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/18 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_output()
   DEFINE l_i      LIKE type_t.num5
   DEFINE l_count  LIKE type_t.num5
   
   LET l_count = g_glfb_d.getLength()
   DELETE FROM aglq815_tmp01          #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
   FOR l_i=1 TO l_count
      INSERT INTO aglq815_tmp01       #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
      VALUES(g_enterprise,g_input.glfa001,g_glfb_d[l_i].glfbseq,
             g_glfb_d[l_i].amt1,g_glfb_d[l_i].amt2,g_glfb_d[l_i].amt3,g_glfb_d[l_i].amt4,g_glfb_d[l_i].amt5,
             g_glfb_d[l_i].amt6,g_glfb_d[l_i].amt7,g_glfb_d[l_i].amt8,g_glfb_d[l_i].amt9,g_glfb_d[l_i].amt10,
             g_glfb_d[l_i].amt11,g_glfb_d[l_i].amt12,g_glfb_d[l_i].amt13,g_glfb_d[l_i].amt14,g_glfb_d[l_i].amt15,
             g_glfb_d[l_i].amt16,g_glfb_d[l_i].amt17,g_glfb_d[l_i].amt18,g_glfb_d[l_i].amt19,g_glfb_d[l_i].amt20,
             g_glfb_d[l_i].amt21,g_glfb_d[l_i].amt22,g_glfb_d[l_i].amt23,g_glfb_d[l_i].amt24,g_glfb_d[l_i].amt25,
             g_glfb_d[l_i].amt26,g_glfb_d[l_i].amt27,g_glfb_d[l_i].amt28,g_glfb_d[l_i].amt29,g_glfb_d[l_i].amt30,
             g_glfb_d[l_i].amt31,g_glfb_d[l_i].amt32,g_glfb_d[l_i].amt33,g_glfb_d[l_i].amt34,g_glfb_d[l_i].amt35,
             g_glfb_d[l_i].amt36,g_glfb_d[l_i].amt37,g_glfb_d[l_i].amt38,g_glfb_d[l_i].amt39,g_glfb_d[l_i].amt30,
             g_glfb_d[l_i].amt41,g_glfb_d[l_i].amt42,g_glfb_d[l_i].amt43,g_glfb_d[l_i].amt44,g_glfb_d[l_i].amt45,
             g_glfb_d[l_i].amt46,g_glfb_d[l_i].amt47,g_glfb_d[l_i].amt48,g_glfb_d[l_i].amt49,g_glfb_d[l_i].amt50             
             )
   END FOR
                   #条件  #临时表名            #模板编号        #账套           #年度           #期别
   CALL aglq815_g01("1=1","aglq815_tmp01",g_input.glfa001,g_input.glfa005,g_input.glfa006,g_input.glfa007)    #160727-00019#3  Mod  aglq815_print_tmp -->aglq815_tmp01
   
END FUNCTION

################################################################################
# Descriptions...: 因模板产生程序在Before dialog 中有NEXT FIELD glfa001导致程序无法退出，
#                  找不到其他方法是模板不产生NEXT FIELD glfa001,只好重写这个函数
# Memo...........:
# Usage..........: CALL aglq815_ui_dialog_1()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/04/19 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION aglq815_ui_dialog_1()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
                    
                    
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
   
   CALL aglq815_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_glfb_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL aglq815_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"

         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"

         #end add-point
     
         DISPLAY ARRAY g_glfb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL aglq815_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL aglq815_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"

               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"

            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"

         #end add-point
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL aglq815_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL aglq815_query()
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
         
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"

            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL aglq815_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"

            #end add-point
            CALL cl_user_overview()
 
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
 
         ON ACTION datarefresh   # 重新整理
            CALL aglq815_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL aglq815_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL aglq815_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL aglq815_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL aglq815_b_fill()
 
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
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL aglq815_filter()
            #add-point:ON ACTION filter name="menu.filter"

            #END add-point
            EXIT DIALOG
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL aglq815_output()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL aglq815_query()
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"

               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"

            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"

         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION

 
{</section>}
 
