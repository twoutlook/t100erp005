#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq536.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:7(2016-06-15 14:49:21), PR版次:0007(2017-01-20 14:23:31)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: axcq536
#+ Description: 產銷量值表
#+ Creator....: 02097(2016-06-13 15:33:07)
#+ Modifier...: 02097 -SD/PR- 01996
 
{</section>}
 
{<section id="axcq536.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160511-00045#9   2016/07/18  By 02097    銷售數據程式改抓xcck201
#160802-00020#8   2016/08/16  By dorislai 增加帳套權限管控、法人權限管控
#160927-00015#1   2016/09/30  By zhujing  修正报错信息，并调整法人帐套录入后不得为空的检查。
#161019-00017#5   2016/10/21 By lixiang  调整组织栏位的开窗
#160921-00010#1   2017/01/20 By xujing      切换据点自动预设画面栏位
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
GLOBALS "../../cfg/top_report.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xcck_d RECORD
       
       sel LIKE type_t.chr1, 
   xccksite LIKE xcck_t.xccksite, 
   xccksite_desc LIKE type_t.chr500, 
   xcck002 LIKE xcck_t.xcck002, 
   l_xcck002_desc LIKE type_t.chr500, 
   l_group_type LIKE type_t.chr500, 
   l_group_type_desc LIKE type_t.chr500, 
   l_xcck046_1 LIKE type_t.num20_6, 
   l_xcck202_1 LIKE type_t.num20_6, 
   l_xcck046_2 LIKE type_t.num20_6, 
   l_xcck202_2 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_input    RECORD       
       xcckcomp      LIKE xcck_t.xcckcomp,
       xcckcomp_desc LIKE type_t.chr80,       
       xcckld        LIKE xcck_t.xcckld,
       xcckld_desc   LIKE type_t.chr80,
       xcck003       LIKE xcck_t.xcck003,
       xcck003_desc  LIKE type_t.chr80,
       xcck004_s     LIKE xcck_t.xcck004,
       xcck005_s     LIKE xcck_t.xcck005,
       xcck004_e     LIKE xcck_t.xcck004,
       xcck005_e     LIKE xcck_t.xcck005,
       xcck001       LIKE xcck_t.xcck001,
       chk1          LIKE type_t.chr1,       #應包括倉退統計
       op1           LIKE type_t.chr1,       #關係企業
       op2           LIKE type_t.chr1,       #樣品費用
       curr          LIKE apca_t.apca100,
       rate          LIKE apca_t.apca101,
       op3           LIKE type_t.chr1        #彙總條件
                 END RECORD
DEFINE g_input       type_g_input  #INPUT條件
DEFINE g_wc_table1   STRING
DEFINE g_wc_cs_ld            STRING          #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING          #160802-00020#8-add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xcck_d            DYNAMIC ARRAY OF type_g_xcck_d
DEFINE g_xcck_d_t          type_g_xcck_d
 
 
 
 
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
 
{<section id="axcq536.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   CALL axcq536_cre_tmp()
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
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
   DECLARE axcq536_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq536_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq536_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq536 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq536_init()   
 
      #進入選單 Menu (="N")
      CALL axcq536_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq536
      
   END IF 
   
   CLOSE axcq536_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL axcq536_drop_tmp()
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq536.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq536_init()
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
   CALL cl_set_combo_scc('xcck001','8914')
   CALL cl_set_combo_scc('op1','4042')
   CALL cl_set_combo_scc('op2','8054')
   CALL cl_set_combo_scc('op3','8053')
   CALL axcq536_default_value()   
   #end add-point
 
   CALL axcq536_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq536.default_search" >}
PRIVATE FUNCTION axcq536_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xcckld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xcck001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xcck002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xcck003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xcck004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xcck005 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xcck006 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " xcck007 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " xcck008 = '", g_argv[09], "' AND "
   END IF
   IF NOT cl_null(g_argv[10]) THEN
      LET g_wc = g_wc, " xcck009 = '", g_argv[10], "' AND "
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
 
{<section id="axcq536.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq536_ui_dialog() 
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
   DEFINE l_str      LIKE type_t.chr10
   DEFINE l_cnt      LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
 
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
 
   
   CALL axcq536_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xcck_d.clear()
 
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
 
         CALL axcq536_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
        
         #end add-point
     
         DISPLAY ARRAY g_xcck_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq536_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq536_b_fill2()
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
            CALL axcq536_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_wc = " 1=1"
            LET g_wc_table1 = " 1=1"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE)            
            {
            #end add-point
            NEXT FIELD xcckcomp
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
             }
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
            CALL axcq536_ins_tmp()
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axcq536_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xcck_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axcq536_b_fill()
 
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
            CALL axcq536_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq536_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq536_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq536_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xcck_d.getLength()
               LET g_xcck_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xcck_d.getLength()
               LET g_xcck_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xcck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xcck_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xcck_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xcck_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq536_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel",FALSE)
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               CALL cl_set_comp_visible('sel',FALSE)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               CALL axcq536_xg_print()
               CALL axcq536_x01("1=1","axcq536_xg_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axcq536_xg_print()
               CALL axcq536_x01("1=1","axcq536_xg_tmp")
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CALL axcq536_construct()
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
            CALL g_xcck_d.clear()
            CALL axcq536_default_value()
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq536.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq536_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sub_sql       STRING
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xcck_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',xccksite,'',xcck002,'','','','','','',''  ,DENSE_RANK() OVER( ORDER BY xcck_t.xcckld, 
       xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007, 
       xcck_t.xcck008,xcck_t.xcck009) AS RANK FROM xcck_t",
 
 
                     "",
                     " WHERE xcckent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " ORDER BY xcck_t.xcckld,xcck_t.xcck001,xcck_t.xcck002,xcck_t.xcck003,xcck_t.xcck004,xcck_t.xcck005,xcck_t.xcck006,xcck_t.xcck007,xcck_t.xcck008,xcck_t.xcck009"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT 'N',xccksite,'',xcck002,'',group_type,'',",
                            " NVL(SUM(l_xcck046_1),0) as l_xcck046_1,NVL(SUM(l_xcck202_1),0) as l_xcck202_1,NVL(SUM(l_xcck046_2),0) as l_xcck046_2,NVL(SUM(l_xcck202_2),0) as l_xcck202_2,",
                            " DENSE_RANK() OVER( ORDER BY xccksite,xcck002,group_type) AS RANK",
                      " FROM axcq536_tmp",
                     " WHERE xcckent= ? AND 1=1 AND ", ls_wc                     
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xcck_t"),
                     " GROUP BY xccksite,xcck002,group_type ",
                     " ORDER BY xccksite,xcck002,group_type" 
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
 
   LET g_sql = "SELECT '',xccksite,'',xcck002,'','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #汇总类型

   CASE g_input.op3
        WHEN '1'  LET l_sub_sql = ",(SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '206' AND oocql002 = group_type AND oocql003='",g_dlang,"'),"
        WHEN '2'  LET l_sub_sql = ",(SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = ",g_enterprise," AND rtaxl001 = group_type AND rtaxl002 = '",g_dlang,"'),"
        WHEN '3'  LET l_sub_sql = ",(SELECT oocql004 FROM oocql_t WHERE oocqlent = ",g_enterprise," AND oocql001 = '200' AND oocql002 = group_type AND oocql003='",g_dlang,"'),"
   END CASE
   LET g_sql = "SELECT '',xccksite,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = ",g_enterprise," AND ooefl001 = xccksite AND ooefl002 = '",g_dlang,"'),",
                         "xcck002,(SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent= ",g_enterprise," AND xcbflcomp = '",g_input.xcckcomp,"' AND xcbfl001 = xcck002 AND xcbfl002 = '",g_dlang,"'),",
                         "group_type ",l_sub_sql,
                         "l_xcck046_1,l_xcck202_1 *", g_input.rate,",l_xcck046_2,l_xcck202_2 *",g_input.rate,
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq536_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq536_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xcck_d[l_ac].sel,g_xcck_d[l_ac].xccksite,g_xcck_d[l_ac].xccksite_desc, 
       g_xcck_d[l_ac].xcck002,g_xcck_d[l_ac].l_xcck002_desc,g_xcck_d[l_ac].l_group_type,g_xcck_d[l_ac].l_group_type_desc, 
       g_xcck_d[l_ac].l_xcck046_1,g_xcck_d[l_ac].l_xcck202_1,g_xcck_d[l_ac].l_xcck046_2,g_xcck_d[l_ac].l_xcck202_2 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      IF g_xcck_d[l_ac].l_xcck046_1 = 0 AND g_xcck_d[l_ac].l_xcck202_1 = 0 AND g_xcck_d[l_ac].l_xcck046_2 = 0 AND g_xcck_d[l_ac].l_xcck202_2 = 0 THEN
         CONTINUE FOREACH
      END IF
      CALL s_curr_round_ld('1',g_input.xcckld,g_input.curr,g_xcck_d[l_ac].l_xcck202_1,2) RETURNING g_sub_success,g_errno,g_xcck_d[l_ac].l_xcck202_1
      CALL s_curr_round_ld('1',g_input.xcckld,g_input.curr,g_xcck_d[l_ac].l_xcck202_2,2) RETURNING g_sub_success,g_errno,g_xcck_d[l_ac].l_xcck202_2
      #end add-point
 
      CALL axcq536_detail_show("'1'")
 
      CALL axcq536_xcck_t_mask()
 
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
 
   CALL g_xcck_d.deleteElement(g_xcck_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xcck_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axcq536_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq536_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq536_detail_action_trans()
 
   LET l_ac = 1
   IF g_xcck_d.getLength() > 0 THEN
      CALL axcq536_b_fill2()
   END IF
 
      CALL axcq536_filter_show('xccksite','b_xccksite')
   CALL axcq536_filter_show('xcck002','b_xcck002')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq536.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq536_b_fill2()
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
 
{<section id="axcq536.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq536_detail_show(ps_page)
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
 
{<section id="axcq536.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq536_filter()
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
      CONSTRUCT g_wc_filter ON xccksite,xcck002
                          FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck002
 
         BEFORE CONSTRUCT
                     DISPLAY axcq536_filter_parser('xccksite') TO s_detail1[1].b_xccksite
            DISPLAY axcq536_filter_parser('xcck002') TO s_detail1[1].b_xcck002
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xccksite>>----
         #Ctrlp:construct.c.page1.b_xccksite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xccksite
            #add-point:ON ACTION controlp INFIELD b_xccksite name="construct.c.filter.page1.b_xccksite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #CALL q_ooef001()                           #呼叫開窗  #161019-00017#5
            CALL q_ooef001_1()   #161019-00017#5
            DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
            NEXT FIELD b_xccksite                     #返回原欄位
            #END add-point
 
 
         #----<<xccksite_desc>>----
         #----<<b_xcck002>>----
         #Ctrlp:construct.c.filter.page1.b_xcck002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xcck002
            #add-point:ON ACTION controlp INFIELD b_xcck002 name="construct.c.filter.page1.b_xcck002"
            INITIALIZE g_qryparam.* TO NULL
           LET g_qryparam.state = 'c'
		     LET g_qryparam.reqry = FALSE
           CALL q_xcbf001()                     
           DISPLAY g_qryparam.return1 TO b_xcck002      #顯示到畫面上
           NEXT FIELD b_xcck002     
            #END add-point
 
 
         #----<<l_xcck002_desc>>----
         #----<<l_group_type>>----
         #----<<l_group_type_desc>>----
         #----<<l_xcck046_1>>----
         #----<<l_xcck202_1>>----
         #----<<l_xcck046_2>>----
         #----<<l_xcck202_2>>----
 
 
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
 
      CALL axcq536_filter_show('xccksite','b_xccksite')
   CALL axcq536_filter_show('xcck002','b_xcck002')
 
 
   CALL axcq536_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq536.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq536_filter_parser(ps_field)
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
 
{<section id="axcq536.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq536_filter_show(ps_field,ps_object)
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
   LET ls_condition = axcq536_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axcq536.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq536_detail_action_trans()
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
 
{<section id="axcq536.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq536_detail_index_setting()
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
            IF g_xcck_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xcck_d.getLength() AND g_xcck_d.getLength() > 0
            LET g_detail_idx = g_xcck_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xcck_d.getLength() THEN
               LET g_detail_idx = g_xcck_d.getLength()
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
 
{<section id="axcq536.mask_functions" >}
 &include "erp/axc/axcq536_mask.4gl"
 
{</section>}
 
{<section id="axcq536.other_function" readonly="Y" >}

################################################################################
# Descriptions...: xcck003_desc
# Memo...........:
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_xcck003_desc()
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_input.xcck003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_input.xcck003_desc = '', g_rtn_fields[1] , ''
   DISPLAY BY NAME g_input.xcck003_desc
   
END FUNCTION

################################################################################
# Descriptions...: 日期检核
# Memo...........:
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_date_chk()
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001

   LET r_success = TRUE
   IF NOT cl_null(g_input.xcck004_s) AND NOT cl_null(g_input.xcck004_e) THEN
      IF g_input.xcck004_s > g_input.xcck004_e THEN
         LET r_success = FALSE
         LET r_errno = 'acr-00064'
         RETURN r_success,r_errno
      END IF
   END IF
   
   IF NOT cl_null(g_input.xcck004_s) AND NOT cl_null(g_input.xcck004_e) AND NOT cl_null(g_input.xcck005_s) AND NOT cl_null(g_input.xcck005_e) THEN
      IF (g_input.xcck004_s * 100 + g_input.xcck005_s) > (g_input.xcck004_e * 100 + g_input.xcck005_e) THEN
         LET r_success = FALSE
         LET r_errno = 'acr-00068'
         RETURN r_success,r_errno
      END IF
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 期别检查
# Memo...........:
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_period_chk(p_yy,p_mm)
DEFINE p_yy          LIKE xcck_t.xcck004
DEFINE p_mm          LIKE xcck_t.xcck005
DEFINE r_success     LIKE type_t.num5
DEFINE r_errno       LIKE gzze_t.gzze001
DEFINE l_glaa003     LIKE glaa_t.glaa003
DEFINE l_glav006     LIKE glav_t.glav006

   LET r_success = TRUE
   LET r_errno = ''
   IF cl_null(p_yy) OR cl_null(p_mm) THEN
      RETURN r_success,r_errno
   END IF
   SELECT glaa003 INTO l_glaa003
     FROM glaa_t
    WHERE glaaent  = g_enterprise AND glaald = g_input.xcckld
   
   IF cl_null(l_glaa003) THEN      
      LET r_success = FALSE
      LET r_errno = 'agl-00211'
      RETURN r_success,r_errno
   END IF 
   SELECT MAX(glav006) INTO l_glav006
     FROM glav_t
    WHERE glavent = g_enterprise
      AND glav001 = l_glaa003 AND glav002 = p_yy
   IF p_mm > l_glav006 THEN
      LET r_success = FALSE
      LET r_errno = 'abm-00261'
      RETURN r_success,r_errno
   END IF
   RETURN r_success,r_errno
END FUNCTION

################################################################################
# Descriptions...: 预设值
# Date & Author..: 16/06/14 By 020297
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_default_value()
DEFINE l_glaa003     LIKE glaa_t.glaa003   
DEFINE l_str         LIKE type_t.chr10

   LET g_input.xcck001 = '1'
   LET g_input.chk1= 'N'
   LET g_input.op1 = '1'
   LET g_input.op2 = '1'
   LET g_input.op3 = '1'
   LET g_input.rate=  1
   LET g_input.chk1= 'Y'
   #160927-00015#1 add-S
#   IF cl_null(g_input.xcckcomp) THEN     #160921-00010#1 mark
   #160927-00015#1 add-E
      #法人组织
      SELECT ooef017 INTO g_input.xcckcomp
        FROM ooef_t
       WHERE ooefent = g_enterprise
         AND ooef001 = g_site
      CALL s_desc_get_department_desc(g_input.xcckcomp) RETURNING g_input.xcckcomp_desc
      DISPLAY BY NAME g_input.xcckcomp_desc
   #160927-00015#1 add-S
#   END IF                                 #160921-00010#1 mark
   #160927-00015#1 add-E
   
   #帐套/成本类型
   SELECT glaald ,glaa003,glaa001,glaa120
     INTO g_input.xcckld,l_glaa003,g_input.curr,g_input.xcck003
     FROM glaa_t
    WHERE glaaent  = g_enterprise
      AND glaacomp = g_input.xcckcomp AND glaa014 = 'Y'    
   CALL s_desc_get_ld_desc(g_input.xcckld) RETURNING g_input.xcckld_desc
   DISPLAY BY NAME g_input.xcckld_desc
   CALL axcq536_xcck003_desc()
   
   CALL axcq536_set_group_type()
   #会计期别
   IF cl_null(l_glaa003) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'agl-00211'
      LET g_errparam.popup= FALSE
      CALL cl_err()        
   END IF
   CALL s_fin_date_get_period_value(l_glaa003,g_input.xcckld,g_today)
        RETURNING g_sub_success,g_input.xcck004_e,g_input.xcck005_e
   LET g_input.xcck004_s = g_input.xcck004_e
   SELECT MIN(glav006) INTO g_input.xcck005_s
     FROM glav_t
    WHERE glavent = g_enterprise
      AND glav001 = l_glaa003 AND glav002 = g_input.xcck004_s
   
   DISPLAY BY NAME g_input.xcck004_s,g_input.xcck005_s,g_input.xcck004_e,g_input.xcck005_e
END FUNCTION

################################################################################
# Descriptions...: 依照幣別推匯率
# Date & Author..: 16/06/15 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_get_rate()
DEFINE l_ld_curr     LIKE glaa_t.glaa001
DEFINE l_glaa025     LIKE glaa_t.glaa025
DEFINE l_date        LIKE type_t.dat

   CASE g_input.xcck001
        WHEN '1'
             SELECT glaa001,glaa025 INTO l_ld_curr,l_glaa025
               FROM glaa_t
              WHERE glaaent = g_enterprise AND glaald  = g_input.xcckld
        WHEN '2'
             SELECT glaa016,glaa018 INTO l_ld_curr,l_glaa025
               FROM glaa_t
              WHERE glaaent = g_enterprise AND glaald  = g_input.xcckld
        WHEN '3'
             SELECT glaa020,glaa022 INTO l_ld_curr,l_glaa025
               FROM glaa_t
              WHERE glaaent = g_enterprise AND glaald  = g_input.xcckld
   END CASE
   LET l_date = MDY(g_input.xcck005_e,1,g_input.xcck004_e)
   CALL s_date_get_last_date(l_date) RETURNING l_date
   CALL s_aooi160_get_exrate('2',g_input.xcckld,l_date,g_input.curr,l_ld_curr,0,l_glaa025)
        RETURNING g_input.rate
   DISPLAY BY NAME g_input.rate
END FUNCTION

################################################################################
# Descriptions...: 
# Date & Author..: 16/06/16 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_set_group_type()
DEFINE l_str1        LIKE type_t.chr500
DEFINE l_str2        LIKE type_t.chr500

   SELECT gzcbl004 INTO l_str1
     FROM gzcbl_t
    WHERE gzcbl001 = '8053' AND gzcbl002 = g_input.op3
      AND gzcbl003 = g_dlang
   CALL cl_set_comp_att_text('l_group_type',l_str1)
   SELECT gzzd005 INTO l_str2
     FROM gzzd_t
    WHERE gzzd001 = g_prog AND gzzd002 = g_dlang
      AND gzzd003 = 'lbl_group_type_desc'
   LET l_str2 = l_str1,l_str2
   CALL cl_set_comp_att_text('l_group_type_desc',l_str2)
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_drop_tmp()

   DROP TABLE axcq536_tmp;
   DROP TABLE axcq536_xg_tmp;
   
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_cre_tmp()

   CALL axcq536_drop_tmp()
   CREATE TEMP TABLE axcq536_tmp(
      xcckent        LIKE xcck_t.xcckent,
      xccksite       LIKE xcck_t.xccksite,   #组织
      xcck002        LIKE xcck_t.xcck002,    #成本域
      group_type     LIKE type_t.chr500,     #汇总方式
      l_xcck046_1    LIKE type_t.num20_6,    #生产数量
      l_xcck202_1    LIKE type_t.num20_6,    #生产金额
      l_xcck046_2    LIKE type_t.num20_6,    #销售数量
      l_xcck202_2    LIKE type_t.num20_6,    #销售金额
      xcck010        LIKE xcck_t.xcck010     #料件
    )
    
    CREATE TEMP TABLE axcq536_xg_tmp(
      l_xcckcomp_desc   LIKE type_t.chr500,     #1
      l_xcckld_desc   LIKE type_t.chr500,       #2
      l_xcck003_desc   LIKE type_t.chr500,      #3
      l_xcck004_s   LIKE type_t.chr500,         #4
      l_xcck004_e   LIKE type_t.chr500,         #5
      l_xcck001   LIKE type_t.chr500,           #6
      xccksite LIKE xcck_t.xccksite,            #7
      xccksite_desc LIKE type_t.chr500,         #8
      xcck002 LIKE xcck_t.xcck002,              #9
      xcck002_desc LIKE type_t.chr500,          #10
      group_type LIKE type_t.chr500,            #11
      group_type_desc LIKE type_t.chr500,       #12
      l_xcck046_1 LIKE type_t.num20_6, 
      l_xcck202_1 LIKE type_t.num20_6, 
      l_xcck046_2 LIKE type_t.num20_6, 
      l_xcck202_2 LIKE type_t.num20_6
    )
END FUNCTION

################################################################################
# Descriptions...: 写入资料
# Memo...........: 生產數據: xccd_t在製主件成本期異動統計檔
#                  銷售數據: xcck_t本期料件明細進出成本檔
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_ins_tmp()
DEFINE l_sql         STRING
DEFINE l_main_sql    STRING      #资料范围
DEFINE l_sub_sql     STRING      #汇总条件
DEFINE l_sub_wc      STRING      #INPUT条件
DEFINE l_xrcbfield   LIKE type_t.chr10

   CALL s_transaction_begin()
   DELETE FROM axcq536_tmp
   #写入生产数据
   #汇总类型
   CASE g_input.op3
        WHEN '1'  LET l_sub_sql = ",NVL((SELECT imag011 FROM imag_t WHERE imagent = xccdent AND imagsite= xccdcomp AND imag001 = xccd007),(SELECT imag011 FROM imag_t WHERE imagent = xccdent AND imagsite= 'ALL' AND imag001 = xccd007))"
        WHEN '2'  LET l_sub_sql = ",(SELECT imaa009 FROM imaa_t WHERE imaaent = xccdent AND imaa001 = xccd007)"
        WHEN '3'  LET l_sub_sql = ",(SELECT imaa003 FROM imaa_t WHERE imaaent = xccdent AND imaa001 = xccd007)"
   END CASE
   LET l_main_sql = "SELECT (SELECT UNIQUE xccksite FROM xcck_t WHERE xcckent = ",g_enterprise," AND xcckld = xccdld AND xcck002 = xccd002 AND xcck047 = xccd006) xccksite, ",
                    "       xccd002 as xcck002,xccd301*-1,xccd302*-1,xccd007 ",l_sub_sql,
                    "  FROM xccd_t ",
                    " WHERE xccdent = ",g_enterprise," AND xccdcomp = '",g_input.xcckcomp,"' AND xccdld = '",g_input.xcckld,"'",
                    "   AND xccdcomp IN ",g_wc_cs_comp," AND xccdld IN ",g_wc_cs_ld,   #160802-00020#8-add
                    "   AND xccd001 = '",g_input.xcck001,"' AND xccd003 ='",g_input.xcck003,"'",
                    "   AND (xccd004*100 + xccd005) BETWEEN ",(g_input.xcck004_s * 100 + g_input.xcck005_s)," AND ",(g_input.xcck004_e * 100 + g_input.xcck005_e)
   
   LET l_sql = "INSERT INTO axcq536_tmp (xccksite,xcck002,l_xcck046_1,l_xcck202_1,xcck010,group_type) ",
               "SELECT * FROM (",l_main_sql,") WHERE ",g_wc_table1
   EXECUTE IMMEDIATE l_sql
   #写入负向的生产数据
   #汇总类型
   LET l_sub_sql = cl_replace_str(l_sub_sql,'xccd','xcce')   
   LET l_main_sql = "SELECT (SELECT UNIQUE xccksite FROM xcck_t WHERE xcckent = ",g_enterprise," AND xcckld = xcceld AND xcck002 = xcce002 AND xcck047 = xcce006) xccksite,",
                    "       xcce002 as xcck002,xcce201*-1,xcce202*-1,xcce007",l_sub_sql,
                    "  FROM xcce_t,sfaa_t ",
                    " WHERE sfaaent = xcceent AND sfaadocno = xcce006 AND sfaa042 = 'Y'",
                    "   AND xcceent = ",g_enterprise," AND xccecomp = '",g_input.xcckcomp,"' AND xcceld = '",g_input.xcckld,"'",
                    "   AND xccecomp IN ",g_wc_cs_comp," AND xcceld IN ",g_wc_cs_ld,   #160802-00020#8-add
                    "   AND xcce001 ='",g_input.xcck001,"' AND xcce003 ='",g_input.xcck003,"'",
                    "   AND (xcce004*100 + xcce005) BETWEEN ",(g_input.xcck004_s * 100 + g_input.xcck005_s)," AND ",(g_input.xcck004_e * 100 + g_input.xcck005_e),
                    "   AND xcce007 IN (SELECT UNIQUE xcck010 FROM axcq536_tmp)"
   LET l_sql = "INSERT INTO axcq536_tmp (xccksite,xcck002,l_xcck046_1,l_xcck202_1,xcck010,group_type) ",
               "SELECT * FROM (",l_main_sql,") WHERE ",g_wc_table1
   EXECUTE IMMEDIATE l_sql
   
   #写入销售数据   
   
   LET l_sub_wc = " 1=1"
   #关系企业
   CASE g_input.op1
        WHEN '2' LET l_sub_wc = l_sub_wc ," AND pmaa047 = 'N'"    #160511-00045#9 modify
        WHEN '3' LET l_sub_wc = l_sub_wc ," AND pmaa047 = 'Y'"    #160511-00045#9 modify
   END CASE
   #樣品費用
   CASE g_input.op2
        WHEN '2' LET l_sub_wc = l_sub_wc ," AND xmdl007 <> '9'"
        WHEN '3' LET l_sub_wc = l_sub_wc ," AND xmdl007 =  '9'"
   END CASE
   
   #汇总类型
   CASE g_input.op3
        WHEN '1'  LET l_sub_sql = ",NVL((SELECT imag011 FROM imag_t WHERE imagent = xcckent AND imagsite = xcckcomp AND imag001 = xcck010),(SELECT imag011 FROM imag_t WHERE imagent = xcckent AND imagsite = 'ALL' AND imag001 = xcck010)) as group_type"
        WHEN '2'  LET l_sub_sql = ",(SELECT imaa009 FROM imaa_t WHERE imaaent = xcckent AND imaa001 = xcck010) as group_type"
        WHEN '3'  LET l_sub_sql = ",(SELECT imaa003 FROM imaa_t WHERE imaaent = xcckent AND imaa001 = xcck010) as group_type"
   END CASE   
   #本位币栏位
   CASE g_input.xcck001
        WHEN '1' LET l_xrcbfield = "xrcb113"
        WHEN '2' LET l_xrcbfield = "xrcb123"
        WHEN '3' LET l_xrcbfield = "xrcb133"
   END CASE
   #計算有立AR的銷售數量,銷售金額
   LET l_main_sql = "SELECT xcck006,xcck007,xccksite,xcck002,xcck046,SUM(xrcb113) as xrcb113,xcck010, group_type ",
                    "  FROM (",
                    "SELECT xcck006,xcck007,xccksite,xcck002,xcck201*xcck009*-1 as xcck046,(",l_xrcbfield,"*xrcb022) as xrcb113,xcck010",l_sub_sql,   #160511-00045#9 xcck046 modify xcck201
                    "  FROM xcck_t,xrca_t,xrcb_t ",
                    " WHERE xcckent = xrcaent AND xcckent= ",g_enterprise,
                    "   AND xcckld  = xrcald  AND xcckld = '",g_input.xcckld,"'",
                    "   AND xcckld IN ",g_wc_cs_ld,   #160802-00020#8-add
                    "   AND xcck001 ='",g_input.xcck001,"' AND xcck003 = '",g_input.xcck003,"'",
                    "   AND (xcck004*100 + xcck005) BETWEEN ",(g_input.xcck004_s * 100 + g_input.xcck005_s)," AND ",(g_input.xcck004_e * 100 + g_input.xcck005_e),
                    "   AND xrcaent = xrcbent AND xrcald = xrcbld AND xrcadocno = xrcbdocno ",
                    "   AND xrca001 IN ('01','02','12','17','22') AND xrcastus = 'Y' ",
                    "   AND xrcb002 = xcck006 AND xrcb003 = xcck007 ",
                    "   AND xrcb023 <> 'Y' AND ",g_wc_table1   
   CASE g_input.chk1    #應包括倉退統計
        WHEN 'Y' LET l_main_sql = l_main_sql ," AND xcck055 IN ('305','307','303','215')"
        WHEN 'N' LET l_main_sql = l_main_sql ," AND xcck055 IN ('305','215')"       #160511-00045#9 307 modify 215
   END CASE
   #計算沒有立AR的銷售數量,銷售金額為0
   LET l_main_sql = l_main_sql," UNION ",
                    " SELECT xcck006,xcck007,xccksite,xcck002,xcck201*xcck009*-1 as xcck046,0 as xrcb113,xcck010 ",l_sub_sql,    #160511-00045#9 xcck046 modify xcck201
                    "   FROM xcck_t ",
                    "  WHERE xcckent= ",g_enterprise," AND xcckld = '",g_input.xcckld,"' AND xcck001 = '",g_input.xcck001,"' AND xcck003 ='",g_input.xcck003,"'",
                    "    AND xcckld IN ",g_wc_cs_ld,   #160802-00020#8-add
                    "    AND (xcck004*100 + xcck005) BETWEEN ",(g_input.xcck004_s * 100 + g_input.xcck005_s)," AND ",(g_input.xcck004_e * 100 + g_input.xcck005_e),
                    "    AND (xcck006,xcck007) NOT IN (SELECT xrcb002,xrcb003 FROM xrca_t,xrcb_t ",
                                                      " WHERE xrcaent = xrcbent AND xrcald = xrcbld AND xrcadocno = xrcbdocno ",
                                                      "   AND xrcaent = ",g_enterprise," AND xrcald = '",g_input.xcckld,"'",
                                                      "   AND xrcald IN ",g_wc_cs_ld,   #160802-00020#8-add
                                                      "   AND xrca001 IN ('01','02','12','17','22')   AND xrcastus = 'Y' ",
                                                      "   AND xrcb002 = xcck006 AND xrcb003 = xcck007 AND xrcb023 <> 'Y')",
                    "   AND ",g_wc_table1      
   CASE g_input.chk1    #應包括倉退統計
        WHEN 'Y' LET l_main_sql = l_main_sql ," AND xcck055 IN ('305','307','303','215')"
        WHEN 'N' LET l_main_sql = l_main_sql ," AND xcck055 IN ('305','215')"      #160511-00045#9 307 modify 215
   END CASE
   LET l_main_sql = l_main_sql,") GROUP BY xcck006,xcck007,xccksite,xcck002,xcck046,xcck010,group_type"
   IF l_sub_wc <> " 1=1" THEN  #串出货单table
      LET l_main_sql = " SELECT xccksite,xcck002,xcck046,xrcb113,xcck010,group_type ",
                       "   FROM xmdk_t,xmdl_t,pmaa_t,(",l_main_sql,")",
                       "  WHERE xmdkent = ",g_enterprise,
                       "    AND xmdkent = pmaaent AND pmaa001 = xmdk007",
                       "    AND xmdkent = xmdlent AND xmdkdocno = xmdldocno ",
                       "    AND xmdkstus= 'S' ",
                       "    AND xmdldocno = xcck006 AND xmdlseq = xcck007 AND",l_sub_wc
   END IF           
   
   LET l_sql = "INSERT INTO axcq536_tmp (xccksite,xcck002,l_xcck046_2,l_xcck202_2,xcck010,group_type) ",
               "SELECT xccksite,xcck002,xcck046,xrcb113,xcck010,group_type FROM (",l_main_sql,")"
   EXECUTE IMMEDIATE l_sql
   
   UPDATE axcq536_tmp
      SET xcckent = g_enterprise
   CALL s_transaction_end('Y','0')
END FUNCTION

################################################################################
# Descriptions...: XG
# Memo...........:
# Date & Author..: 16/06/14 By 02097
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_xg_print()
DEFINE l_i              LIKE type_t.num10
DEFINE l_xcckcomp_desc  LIKE type_t.chr80
DEFINE l_xcckld_desc    LIKE type_t.chr80
DEFINE l_xcck003_desc   LIKE type_t.chr80
DEFINE l_xcck004_s      LIKE type_t.chr80
DEFINE l_xcck004_e      LIKE type_t.chr80
DEFINE l_xcck001_desc   LIKE type_t.chr80
DEFINE l_str            LIKE type_t.chr80
DEFINE l_str1           LIKE type_t.chr80
DEFINE l_str2           LIKE type_t.chr80

   DELETE FROM axcq536_xg_tmp
   LET l_xcckcomp_desc= g_input.xcckcomp,".",g_input.xcckcomp_desc
   LET l_xcckld_desc  = g_input.xcckld  ,".",g_input.xcckld_desc
   LET l_xcck003_desc = g_input.xcck003 ,".",g_input.xcck003_desc
   LET l_xcck004_s = g_input.xcck004_s,"/",g_input.xcck005_s
   LET l_xcck004_e = g_input.xcck004_e,"/",g_input.xcck005_e
   SELECT gzcbl004 INTO l_str
     FROM gzcbl_t
    WHERE gzcbl001 = '8914' AND gzcbl002 = g_input.xcck001
      AND gzcbl003 = g_dlang      
   LET l_xcck001_desc = g_input.xcck001,".",l_str
   
   SELECT gzcbl004 INTO l_str1
     FROM gzcbl_t
    WHERE gzcbl001 = '8053' AND gzcbl002 = g_input.op3
      AND gzcbl003 = g_dlang
   LET g_xg_fieldname[11] = l_str1
   SELECT gzzd005 INTO l_str2
     FROM gzzd_t
    WHERE gzzd001 = g_prog AND gzzd002 = g_dlang
      AND gzzd003 = 'lbl_group_type_desc'
   LET l_str2 = l_str1,l_str2
   LET g_xg_fieldname[12] = l_str2
   
   FOR l_i = 1 TO g_xcck_d.getLength()     
      INSERT INTO axcq536_xg_tmp 
           VALUES (l_xcckcomp_desc,l_xcckld_desc,l_xcck003_desc,l_xcck004_s,l_xcck004_e,l_xcck001_desc,
                   g_xcck_d[l_i].xccksite,g_xcck_d[l_i].xccksite_desc, 
                   g_xcck_d[l_i].xcck002,g_xcck_d[l_i].l_xcck002_desc,g_xcck_d[l_i].l_group_type,g_xcck_d[l_i].l_group_type_desc, 
                   g_xcck_d[l_i].l_xcck046_1,g_xcck_d[l_i].l_xcck202_1,g_xcck_d[l_i].l_xcck046_2,g_xcck_d[l_i].l_xcck202_2 )
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 
# Memo...........:
# Date & Author..: 
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq536_construct()
DEFINE l_cnt         LIKE type_t.num5
DEFINE li_exit       LIKE type_t.num5
     
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
      #160927-00015#1 add-S
      INPUT BY NAME g_input.xcckcomp,g_input.xcckld
                    ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT
            CALL axcq536_default_value()
            
         AFTER INPUT
            IF cl_null(g_input.xcckcomp) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = '-1155'
               LET g_errparam.popup  = FALSE
               CALL cl_err()                     
               NEXT FIELD xcckcomp   
            END IF
            IF cl_null(g_input.xcckld) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code   = '-1155'
               LET g_errparam.popup  = FALSE
               CALL cl_err()                     
               NEXT FIELD xcckld   
            END IF
         
         ON ACTION controlp INFIELD xcckcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      		   LET g_qryparam.reqry = FALSE
      		   LET g_qryparam.default1 = g_input.xcckcomp
      		   #160802-00020#8-mod-(S)
#      		   LET g_qryparam.where = " ooef003 = 'Y'"
      		   #增加法人過濾條件
               IF cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef003 = 'Y'"
               ELSE
                  LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp
               END IF
               #160802-00020#8-mod-(E)
               CALL q_ooef001()
               LET g_input.xcckcomp = g_qryparam.return1
               CALL s_desc_get_department_desc(g_input.xcckcomp) RETURNING g_input.xcckcomp_desc
               DISPLAY BY NAME g_input.xcckcomp,g_input.xcckcomp_desc
               NEXT FIELD xcckcomp
            
            AFTER FIELD xcckcomp
               IF NOT cl_null(g_input.xcckcomp) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.xcckcomp         
                  IF  NOT cl_chk_exist("v_ooef001_1") THEN
                      NEXT FIELD CURRENT  
                  END IF
                  CALL axcq536_default_value()
               END IF
               CALL s_desc_get_department_desc(g_input.xcckcomp) RETURNING g_input.xcckcomp_desc
               DISPLAY BY NAME g_input.xcckcomp_desc
               
            ON ACTION controlp INFIELD xcckld
      	      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xcckld
               LET g_qryparam.arg1 = g_user                                 #人員權限
               LET g_qryparam.arg2 = g_dept                                 #部門權限
               #160802-00020#8-add-(S)
               #增加帳套權限控制
               IF NOT cl_null(g_wc_cs_ld) THEN
                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
               END IF
               #160802-00020#8-add-(E)
               LET g_qryparam.where = " glaacomp = '",g_input.xcckcomp ,"'"
               CALL q_authorised_ld()                                 
               LET g_input.xcckld = g_qryparam.return1                  
               CALL s_desc_get_ld_desc(g_input.xcckld) RETURNING g_input.xcckld_desc
               DISPLAY BY NAME g_input.xcckld,g_input.xcckld_desc
               NEXT FIELD xcckld  
            
            AFTER FIELD xcckld
               IF NOT cl_null(g_input.xcckld) THEN
                  CALL s_fin_ld_chk(g_input.xcckld,g_user,'N') RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     LET g_input.xcckld = ''
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = g_errno
                     LET g_errparam.extend = g_input.xcckld
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()                     
                     NEXT FIELD CURRENT                
                  END IF
                  SELECT count(*) INTO l_cnt
                    FROM glaa_t
                   WHERE glaaent = g_enterprise
                     AND glaald  = g_input.xcckld AND glaacomp = g_input.xcckcomp 
                  IF l_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = "ap-00029"    #160927-00015#1 mark
                     LET g_errparam.code   = "aap-00029"    #160927-00015#1 mod
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()                     
                     NEXT FIELD CURRENT
                  END IF
                  SELECT glaa120
                    INTO g_input.xcck003
                    FROM glaa_t
                   WHERE glaaent= g_enterprise
                     AND glaald = g_input.xcckld AND glaa014 = 'Y'                  
                  CALL axcq536_get_rate() #重推匯率
               END IF
               CALL s_desc_get_ld_desc(g_input.xcckld) RETURNING g_input.xcckld_desc
               DISPLAY BY NAME g_input.xcckld_desc
         
      END INPUT
      #160927-00015#1 add-E
      
      INPUT BY NAME 
#                       g_input.xcckcomp,g_input.xcckld,     #160927-00015#1 mark
                       g_input.xcck003,g_input.xcck004_s,g_input.xcck005_s,
                       g_input.xcck004_e,g_input.xcck005_e,g_input.xcck001,g_input.chk1,g_input.op1,g_input.op2,
                       g_input.curr,g_input.rate,g_input.op3                       
               ATTRIBUTE(WITHOUT DEFAULTS)
            #160927-00015#1 add-S
            BEFORE INPUT 
               CALL axcq536_default_value()
            #160927-00015#1 add-E
            
            ON CHANGE xcck001
               CALL axcq536_get_rate()           
            ON CHANGE op3
               CALL axcq536_set_group_type()
             #160927-00015#1 marked-S
#            ON ACTION controlp INFIELD xcckcomp
#               INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#      		   LET g_qryparam.reqry = FALSE
#      		   LET g_qryparam.default1 = g_input.xcckcomp
#      		   #160802-00020#8-mod-(S)
##      		   LET g_qryparam.where = " ooef003 = 'Y'"
#      		   #增加法人過濾條件
#               IF cl_null(g_wc_cs_comp) THEN
#                  LET g_qryparam.where = " ooef003 = 'Y'"
#               ELSE
#                  LET g_qryparam.where = " ooef003 = 'Y' AND ooef001 IN ",g_wc_cs_comp
#               END IF
#               #160802-00020#8-mod-(E)
#               CALL q_ooef001()
#               LET g_input.xcckcomp = g_qryparam.return1
#               CALL s_desc_get_department_desc(g_input.xcckcomp) RETURNING g_input.xcckcomp_desc
#               DISPLAY BY NAME g_input.xcckcomp,g_input.xcckcomp_desc
#               NEXT FIELD xcckcomp
#            
#            AFTER FIELD xcckcomp
#               IF NOT cl_null(g_input.xcckcomp) THEN
#                  INITIALIZE g_chkparam.* TO NULL
#                  LET g_chkparam.arg1 = g_input.xcckcomp         
#                  IF  NOT cl_chk_exist("v_ooef001_1") THEN
#                      NEXT FIELD CURRENT  
#                  END IF
#                  #160927-00015#1 add-S
#                  IF NOT cl_null(g_input_t.xcckcomp) AND g_input_t.xcckcomp<>g_input.xcckcomp THEN
#                     CALL axcq536_default_value()
#                  END IF
#               ELSE           
#                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code   = '-1155'
#                  LET g_errparam.popup  = FALSE
#                  CALL cl_err()                     
#                  NEXT FIELD xcckld    
#                  #160927-00015#1 add-E
#               END IF
#               CALL s_desc_get_department_desc(g_input.xcckcomp) RETURNING g_input.xcckcomp_desc
#               DISPLAY BY NAME g_input.xcckcomp_desc
#               
#            ON ACTION controlp INFIELD xcckld
#      	      INITIALIZE g_qryparam.* TO NULL
#               LET g_qryparam.state = 'i'
#      		   LET g_qryparam.reqry = FALSE
#               LET g_qryparam.default1 = g_input.xcckld
#               LET g_qryparam.arg1 = g_user                                 #人員權限
#               LET g_qryparam.arg2 = g_dept                                 #部門權限
#               #160802-00020#8-add-(S)
#               #增加帳套權限控制
#               IF NOT cl_null(g_wc_cs_ld) THEN
#                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
#               END IF
#               #160802-00020#8-add-(E)
#               LET g_qryparam.where = " glaacomp = '",g_input.xcckcomp ,"'"
#               CALL q_authorised_ld()                                 
#               LET g_input.xcckld = g_qryparam.return1                  
#               CALL s_desc_get_ld_desc(g_input.xcckld) RETURNING g_input.xcckld_desc
#               DISPLAY BY NAME g_input.xcckld,g_input.xcckld_desc
#               NEXT FIELD xcckld  
#            
#            AFTER FIELD xcckld
#               IF NOT cl_null(g_input.xcckld) THEN
#                  CALL s_fin_ld_chk(g_input.xcckld,g_user,'N') RETURNING g_sub_success,g_errno
#                  IF NOT g_sub_success THEN
#                     LET g_input.xcckld = ''
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = g_errno
#                     LET g_errparam.extend = g_input.xcckld
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()                     
#                     NEXT FIELD CURRENT                
#                  END IF
#                  SELECT count(*) INTO l_cnt
#                    FROM glaa_t
#                   WHERE glaaent = g_enterprise
#                     AND glaald  = g_input.xcckld AND glaacomp = g_input.xcckcomp 
#                  IF l_cnt = 0 THEN
#                     INITIALIZE g_errparam TO NULL
##                     LET g_errparam.code   = "ap-00029"    #160927-00015#1 mark
#                     LET g_errparam.code   = "aap-00029"    #160927-00015#1 mod
#                     LET g_errparam.popup  = TRUE
#                     CALL cl_err()                     
#                     NEXT FIELD CURRENT
#                  END IF
#                  SELECT glaa120
#                    INTO g_input.xcck003
#                    FROM glaa_t
#                   WHERE glaaent= g_enterprise
#                     AND glaald = g_input.xcckld AND glaa014 = 'Y'                  
#                  CALL axcq536_get_rate() #重推匯率
#               ELSE           #160927-00015#1 add-S
#                  IF cl_null(g_input.xcckcomp) THEN
#                     INITIALIZE g_errparam TO NULL
#                     LET g_errparam.code   = '-1155'
#                     LET g_errparam.popup  = FALSE
#                     CALL cl_err()                     
#                     NEXT FIELD xcckcomp   
#                  ELSE
#                     
#                  END IF      #160927-00015#1 add-E
#               END IF
#               CALL s_desc_get_ld_desc(g_input.xcckld) RETURNING g_input.xcckld_desc
#               DISPLAY BY NAME g_input.xcckld_desc
            #160927-00015#1 marked-E
            
            ON ACTION controlp INFIELD xcck003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.xcck003
              #CALL q_xcat001()
               CALL q_xcaz001()
               LET g_input.xcck003 = g_qryparam.return1
               DISPLAY g_input.xcck003 TO xcck003
               NEXT FIELD xcck003
               
            AFTER FIELD xcck003
               LET g_input.xcck003_desc = ''
               IF NOT cl_null(g_input.xcck003) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_input.xcck003        
                  IF NOT cl_chk_exist("v_xcat001") THEN                  
                     NEXT FIELD CURRENT  
                  END IF
               END IF
               CALL axcq536_xcck003_desc() 
            
            ON ACTION controlp INFIELD curr
      	      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
      		   LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_input.curr
               CALL q_ooai001()                                 
               LET g_input.curr = g_qryparam.return1                  
               NEXT FIELD curr  
            
            AFTER FIELD curr
               IF NOT cl_null(g_input.curr) THEN
                  CALL s_aap_ooaj001_chk(g_input.xcckld,g_input.curr) RETURNING g_sub_success,g_errno                  
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()                     
                     NEXT FIELD CURRENT
                  END IF
                  CALL axcq536_get_rate()                  
               END IF
               
            
            AFTER FIELD xcck004_s
               CALL axcq536_date_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck004_s
               END IF
            
            AFTER FIELD xcck005_s
               CALL axcq536_date_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005_s
               END IF
               CALL axcq536_period_chk(g_input.xcck004_s,g_input.xcck005_s) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005_s
               END IF
            
            AFTER FIELD xcck004_e
               CALL axcq536_date_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck004_e
               END IF
               
            
            AFTER FIELD xcck005_e
               CALL axcq536_date_chk() RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005_e
               END IF
               CALL axcq536_period_chk(g_input.xcck004_e,g_input.xcck005_e) RETURNING g_sub_success,g_errno
               IF NOT g_sub_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD xcck005_e
               END IF
         END INPUT
         CONSTRUCT g_wc_table1 ON xccksite,xcck002
                  FROM s_detail1[1].b_xccksite,s_detail1[1].b_xcck002      
                          
           ON ACTION controlp INFIELD b_xccksite
              INITIALIZE g_qryparam.* TO NULL
              LET g_qryparam.state = 'c' 
              LET g_qryparam.reqry = FALSE
              #CALL q_ooef001()                           #呼叫開窗 #161019-00017#5
              CALL q_ooef001_1()   #161019-00017#5
              DISPLAY g_qryparam.return1 TO b_xccksite  #顯示到畫面上
              NEXT FIELD b_xccksite                     #返回原欄位
         
          ON ACTION controlp INFIELD b_xcck002
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c'
      	    LET g_qryparam.reqry = FALSE
             CALL q_xcbf001()                     
             DISPLAY g_qryparam.return1 TO b_xcck002      #顯示到畫面上
             NEXT FIELD b_xcck002             
         END CONSTRUCT
         
         BEFORE DIALOG
            LET g_xcck_d[1].sel = ""
            DISPLAY ARRAY g_xcck_d TO s_detail1.* 
              BEFORE DISPLAY
                 EXIT DISPLAY
            END DISPLAY
            NEXT FIELD xcckcomp
            
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
            CALL axcq536_ins_tmp()
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axcq536_b_fill() 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
            EXIT DIALOG 
   END DIALOG
END FUNCTION

 
{</section>}
 
