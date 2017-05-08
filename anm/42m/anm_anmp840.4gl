#該程式未解開Section, 採用最新樣板產出!
{<section id="anmp840.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2015-10-20 09:32:21), PR版次:0005(2016-11-29 16:57:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000033
#+ Filename...: anmp840
#+ Description: 資金系統關帳作業
#+ Creator....: 02291(2015-10-20 09:30:19)
#+ Modifier...: 02291 -SD/PR- 02481
 
{</section>}
 
{<section id="anmp840.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160816-00012#2  2016/08/29 By 01727    ANM增加资金中心，帐套，法人三个栏位权限
#161021-00038#1  2016/10/26 By 06821    組織類型與職能開窗調整
#161128-00061#2  2016/11/29 by 02481    标准程式定义采用宣告模式,弃用.*写法
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
PRIVATE TYPE type_g_xreb_d RECORD
       
       sel LIKE type_t.chr1, 
   xrebcomp LIKE xreb_t.xrebcomp, 
   xrebcomp_desc LIKE type_t.chr500, 
   xreb008 LIKE xreb_t.xreb008
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#單头 type 宣告
 TYPE type_g_master RECORD
       b_site           LIKE xrcb_t.xrcbsite, 
       b_site_desc      LIKE ooefl_t.ooefl003,
       b_date           LIKE type_t.dat,
       b_chk1           LIKE type_t.chr1,
       b_chk2           LIKE type_t.chr1,
       b_chk3           LIKE type_t.chr1,
       b_chk4           LIKE type_t.chr1
       END RECORD

#模組變數(Module Variables)
DEFINE g_master         type_g_master
DEFINE g_master_t       type_g_master
#DEFINE g_glaa               RECORD LIKE glaa_t.*    #161128-00061#mark
DEFINE g_bdate          LIKE type_t.dat
DEFINE g_edate          LIKE type_t.dat
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xreb_d            DYNAMIC ARRAY OF type_g_xreb_d
DEFINE g_xreb_d_t          type_g_xreb_d
 
 
 
 
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
 
{<section id="anmp840.main" >}
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
   DECLARE anmp840_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmp840_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmp840_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmp840 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmp840_init()   
 
      #進入選單 Menu (="N")
      CALL anmp840_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmp840
      
   END IF 
   
   CLOSE anmp840_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmp840.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmp840_init()
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
   CALL s_fin_create_account_center_tmp()   #帳務組織底下所屬組織開窗的temptable
   #end add-point
 
   CALL anmp840_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmp840.default_search" >}
PRIVATE FUNCTION anmp840_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xrebld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xreb001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xreb002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xreb003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xreb005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xreb006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " xreb007 = '", g_argv[07], "' AND "
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
 
{<section id="anmp840.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmp840_ui_dialog() 
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
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   DEFINE l_success         LIKE type_t.chr1
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
   CALL anmp840_ui_dialog_1()
   RETURN
   #end add-point
 
   
   CALL anmp840_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xreb_d.clear()
 
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
 
         CALL anmp840_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.b_site,g_master.b_date,g_master.b_chk1,g_master.b_chk2,g_master.b_chk3,g_master.b_chk4

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL anmp840_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.b_date,g_master.b_chk1,
                       g_master.b_chk2,g_master.b_chk3,g_master.b_chk4
                    TO b_site,site_desc,b_date,b_chk1,b_chk2,b_chk3,b_chk4

            BEFORE FIELD b_site
               LET l_site = g_master.b_site

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF

               END IF
               CALL anmp840_site_desc()

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()                                #呼叫開窗
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL anmp840_site_desc()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT  
         
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xreb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmp840_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL anmp840_b_fill2()
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
            CALL anmp840_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_site
            #end add-point
            NEXT FIELD site
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* =  g_master.*
            CALL anmp840_b_fill()
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
            CALL anmp840_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_xreb_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL anmp840_b_fill()
 
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
            CALL anmp840_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL anmp840_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL anmp840_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL anmp840_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
         ON ACTION batch_execute
            CALL anmp840_process() 
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmp840_filter()
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
            CLEAR FORM
            INITIALIZE g_master.* TO NULL
            CALL anmp840_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="anmp840.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmp840_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_ooef017       LIKE ooef_t.ooef017
   DEFINE l_success       LIKE type_t.chr1
   DEFINE ls_comp_wc      STRING   #160816-00012#2 Add
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
 
   CALL g_xreb_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',xrebcomp,'',xreb008  ,DENSE_RANK() OVER( ORDER BY xreb_t.xrebld, 
       xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003,xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007) AS RANK FROM xreb_t", 
 
 
 
                     "",
                     " WHERE xrebent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xreb_t"),
                     " ORDER BY xreb_t.xrebld,xreb_t.xreb001,xreb_t.xreb002,xreb_t.xreb003,xreb_t.xreb005,xreb_t.xreb006,xreb_t.xreb007"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #取得帳務組織下所屬成員
   CALL s_fin_account_center_sons_query('6',g_master.b_site,g_today,'1')
   #取得帳務組織下所屬成員之帳別   
   CALL s_fin_account_center_comp_str() RETURNING ls_wc
   #將取回的字串轉換為SQL條件
   CALL anmp840_get_ooef001_wc(ls_wc) RETURNING ls_wc 
   LET ls_sql_rank =" SELECT 'Y',ooef001,'',ooab002 FROM ooef_t,ooab_t ",
                    "  WHERE ooefent = ooabent AND ooef001=ooabsite ",
                    "    AND ooab001='S-FIN-4007'",
                    "    AND ooefent = ? ",
                    "    AND ooef001 IN ",ls_wc
   #160816-00012#2 Add  ---(S)---
   #法人范围
   CALL s_axrt300_get_site(g_user,'','3')  RETURNING ls_comp_wc
   LET ls_comp_wc = "(SELECT ooef001 FROM ooef_t WHERE ooef003 = 'Y' AND ooefent = '",g_enterprise,"' AND ",ls_comp_wc CLIPPED,")"
   LET ls_sql_rank = ls_sql_rank," AND ooef001 IN ",ls_comp_wc
   #160816-00012#2 Add  ---(E)---
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
 
   LET g_sql = "SELECT '',xrebcomp,'',xreb008",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
     
   LET g_sql =" SELECT 'Y',ooef001,'',ooab002 FROM ooef_t,ooab_t ",
              "  WHERE ooefent = ooabent AND ooef001=ooabsite ",
              "    AND ooab001='S-FIN-4007'",
              "    AND ooefent = ? ",
              "    AND ooef001 IN ",ls_wc
   LET g_sql = g_sql," AND ooef001 IN ",ls_comp_wc   #160816-00012#2 Add
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmp840_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmp840_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xreb_d[l_ac].sel,g_xreb_d[l_ac].xrebcomp,g_xreb_d[l_ac].xrebcomp_desc, 
       g_xreb_d[l_ac].xreb008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL s_axrt300_xrca_ref('xrcasite',g_xreb_d[l_ac].xrebcomp,'','')
         RETURNING l_success,g_xreb_d[l_ac].xrebcomp_desc

      LET  g_xreb_d[l_ac].xreb008 = cl_get_para(g_enterprise,g_xreb_d[l_ac].xrebcomp,'S-FIN-4007')
      #end add-point
 
      CALL anmp840_detail_show("'1'")
 
      CALL anmp840_xreb_t_mask()
 
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
 
   CALL g_xreb_d.deleteElement(g_xreb_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xreb_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE anmp840_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL anmp840_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmp840_detail_action_trans()
 
   LET l_ac = 1
   IF g_xreb_d.getLength() > 0 THEN
      CALL anmp840_b_fill2()
   END IF
 
      CALL anmp840_filter_show('xrebcomp','b_xrebcomp')
   CALL anmp840_filter_show('xreb008','b_xreb008')
 
 
END FUNCTION
 
{</section>}
 
{<section id="anmp840.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmp840_b_fill2()
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
 
{<section id="anmp840.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmp840_detail_show(ps_page)
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
 
{<section id="anmp840.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION anmp840_filter()
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
      CONSTRUCT g_wc_filter ON xrebcomp,xreb008
                          FROM s_detail1[1].b_xrebcomp,s_detail1[1].b_xreb008
 
         BEFORE CONSTRUCT
                     DISPLAY anmp840_filter_parser('xrebcomp') TO s_detail1[1].b_xrebcomp
            DISPLAY anmp840_filter_parser('xreb008') TO s_detail1[1].b_xreb008
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_xrebcomp>>----
         #Ctrlp:construct.c.filter.page1.b_xrebcomp
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xrebcomp
            #add-point:ON ACTION controlp INFIELD b_xrebcomp name="construct.c.filter.page1.b_xrebcomp"
            
            #END add-point
 
 
         #----<<b_xrebcomp_desc>>----
         #----<<b_xreb008>>----
         #Ctrlp:construct.c.filter.page1.b_xreb008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xreb008
            #add-point:ON ACTION controlp INFIELD b_xreb008 name="construct.c.filter.page1.b_xreb008"
            
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL anmp840_filter_show('xrebcomp','b_xrebcomp')
   CALL anmp840_filter_show('xreb008','b_xreb008')
 
 
   CALL anmp840_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="anmp840.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION anmp840_filter_parser(ps_field)
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
 
{<section id="anmp840.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION anmp840_filter_show(ps_field,ps_object)
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
   LET ls_condition = anmp840_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="anmp840.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmp840_detail_action_trans()
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
 
{<section id="anmp840.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmp840_detail_index_setting()
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
            IF g_xreb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xreb_d.getLength() AND g_xreb_d.getLength() > 0
            LET g_detail_idx = g_xreb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xreb_d.getLength() THEN
               LET g_detail_idx = g_xreb_d.getLength()
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
 
{<section id="anmp840.mask_functions" >}
 &include "erp/anm/anmp840_mask.4gl"
 
{</section>}
 
{<section id="anmp840.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_site_desc
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_site_desc()
   DEFINE l_success      LIKE type_t.chr1

   CALL s_axrt300_xrca_ref('xrcasite',g_master.b_site,'','') RETURNING l_success,g_master.b_site_desc
   DISPLAY g_master.b_site_desc TO site_desc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_def()
# Input parameter:  
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_def()
   DEFINE l_success         LIKE type_t.chr1
   DEFINE l_ooef017         LIKE ooef_t.ooef017

   IF NOT cl_null(g_master.b_site) THEN RETURN END IF

   #抓取組織所屬帳務中心
   CALL s_fin_get_account_center('',g_user,'3',g_today) RETURNING l_success,g_master.b_site,g_errno
   CALL anmp840_site_desc()

   
   #關賬日期
   LET g_master.b_date = g_today
   LET g_edate = g_master.b_date
   CALL s_date_get_first_date(g_master.b_date) RETURNING g_bdate

   LET g_master.b_chk1 = 'N'
   LET g_master.b_chk2 = 'N'
   LET g_master.b_chk3 = 'N'
   LET g_master.b_chk4 = 'N'

END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_get_ooef001_wc
# Input parameter:  
# Date & Author..:  
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_get_ooef001_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...: 批處理
# Memo...........:
# Usage..........: CALL anmp840_process()
# Input parameter:  
# Date & Author..: 2014/9/16 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_process()
   DEFINE l_colname_1     STRING   
   DEFINE l_colname_2     STRING   
   DEFINE l_colname_3     STRING   
   DEFINE l_colname_4     STRING   
   DEFINE l_colname_5     STRING   
   DEFINE l_comment_1     STRING   
   DEFINE l_comment_2     STRING   
   DEFINE l_comment_3     STRING   
   DEFINE l_comment_4     STRING   
   DEFINE l_comment_5     STRING   
   DEFINE l_n             LIKE type_t.num5   

   CALL s_transaction_begin()  #事务开始
   CALL cl_err_collect_init()  #汇总错误讯息初始化
   CALL s_azzi902_get_gzzd('anmp840',"lbl_xrcald")    RETURNING l_colname_1,l_comment_1  #帳別
   CALL s_azzi902_get_gzzd('anmp840',"lbl_oobx004")   RETURNING l_colname_2,l_comment_2
   CALL s_azzi902_get_gzzd('anmp840',"lbl_apdadocno") RETURNING l_colname_4,l_comment_4  #單據号码
   CALL s_azzi902_get_gzzd('anmp840',"lbl_apdadocdt") RETURNING l_colname_3,l_comment_3  #單據日期
   CALL s_azzi902_get_gzzd('anmp840',"lbl_nmbbseq")   RETURNING l_colname_5,l_comment_5  #項次 
   LET g_coll_title[1] = l_colname_1
   LET g_coll_title[2] = l_colname_2
   LET g_coll_title[3] = l_colname_3
   LET g_coll_title[4] = l_colname_4
   LET g_coll_title[5] = l_colname_5 
   
   LET g_success = 'Y'   
   
   #检核都ok后回写关账日期
   FOR l_n = 1 TO g_xreb_d.getLength()
       IF g_xreb_d[l_n].sel = "Y" THEN
          IF g_xreb_d[l_ac].xreb008 >  g_master.b_date THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = g_xreb_d[l_ac].xrebcomp
             LET g_errparam.code   = 'anm-00372'
             LET g_errparam.popup  = TRUE
             CALL cl_err()
          END IF
          #回寫關帳日期
          CALL anmp840_writeback_closeday(g_xreb_d[l_n].xrebcomp,g_master.b_date) 
            RETURNING g_success 
          IF g_success = 'N' THEN 
             EXIT FOR
          END IF             
       END IF
   END FOR  
      
   CALL cl_err_collect_show()  #显示错误讯息汇总
   CALL s_transaction_end('Y',0)  #事务结束

   IF g_success = 'Y' THEN
      #执行成功
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00217'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
      CALL anmp840_b_fill()
   ELSE
      #执行失败
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'adz-00218'
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   CALL cl_ask_confirm3("std-00012","")
   
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_get_ld_wc(p_wc)
# Input parameter:  
# Date & Author..: 2014/9/17 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_get_ld_wc(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF      
   END WHILE   
   LET r_wc = "('",l_str,"')"
   
   RETURN r_wc
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_writeback_closeday(p_comp,p_closeday)
# Input parameter: 
# Date & Author..: 2014/9/18 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_writeback_closeday(p_comp,p_closeday)
DEFINE p_comp      LIKE glaa_t.glaacomp
DEFINE p_closeday  LIKE type_t.dat
DEFINE r_success  LIKE type_t.chr1

#抓出有勾選的法人
#抓出每個法人底下的帳套
#都update關帳日期
   
   LET r_success = 'Y'
   IF NOT cl_null(p_comp) THEN
      UPDATE ooab_t
         SET ooab002 = p_closeday
       WHERE ooabent = g_enterprise
         AND ooab001 = 'S-FIN-4007'
         AND ooabsite = p_comp
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'UPDATE ooab_t wrong'
         LET g_errparam.popup = TRUE
         LET g_errparam.sqlerr = SQLCA.SQLCODE
         CALL cl_err()
         LET r_success = 'N'
      END IF
   END IF
    
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL anmp840_ui_dialog_1()
# Input parameter:  
# Date & Author..: 2014/9/19 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION anmp840_ui_dialog_1()
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num5
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   #add-point:ui_dialog段define
   DEFINE l_site            LIKE xrcb_t.xrcbsite
   DEFINE l_ooef017         LIKE ooef_t.ooef017
   DEFINE l_success         LIKE type_t.chr1
   #end add-point
   
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_row = 0
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET g_main_hidden = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   
#   CALL anmp840_b_fill()
  
   WHILE li_exit = FALSE

      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT BY NAME g_master.b_site,g_master.b_date,g_master.b_chk1,g_master.b_chk2,g_master.b_chk3,g_master.b_chk4

            BEFORE INPUT
               IF cl_null(g_master_t.b_site) THEN
                  CALL anmp840_def()
               ELSE
                  LET g_master.* = g_master_t.*
               END IF
               DISPLAY g_master.b_site,g_master.b_site_desc,g_master.b_date,g_master.b_chk1,
                       g_master.b_chk2,g_master.b_chk3,g_master.b_chk4
                    TO b_site,site_desc,b_date,b_chk1,b_chk2,b_chk3,b_chk4

            BEFORE FIELD b_site
               LET l_site = g_master.b_site

            AFTER FIELD b_site
               LET g_master.b_site_desc = ' '
               DISPLAY BY NAME g_master.b_site_desc
               IF NOT cl_null(g_master.b_site) THEN
                  #資料存在性、有效性檢查
                  LET g_errno = ' '
                  #CALL s_fin_account_center_chk(g_master.b_site,'',3,g_today) RETURNING l_success,g_errno #161021-00038#1 mark
                  CALL s_fin_account_center_chk(g_master.b_site,'',6,g_today) RETURNING l_success,g_errno  #161021-00038#1 add
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_master.b_site
                     LET g_errparam.code   = g_errno
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF

               END IF
               CALL anmp840_site_desc()

            AFTER FIELD b_date
               IF NOT cl_null(g_master.b_date) THEN
                  LET g_edate = g_master.b_date
                  CALL s_date_get_first_date(g_master.b_date) RETURNING g_bdate
               END IF

            ON ACTION controlp INFIELD b_site
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.b_site       #給予default值
               #LET g_qryparam.where = " ooef201 = 'Y' "                  #161021-00038#1 mark
               #CALL q_ooef001()                                #呼叫開窗  #161021-00038#1 mark
               CALL q_ooef001_33()                                        #161021-00038#1 add
               LET g_master.b_site = g_qryparam.return1        #將開窗取得的值回傳到變數
               DISPLAY g_master.b_site TO b_site               #顯示到畫面上
               CALL anmp840_site_desc()
               NEXT FIELD b_site                               #返回原欄位

         END INPUT  
         
         INPUT ARRAY g_xreb_d FROM s_detail1.*
             ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                       INSERT ROW = FALSE,
                       DELETE ROW = FALSE,
                       APPEND ROW = FALSE)           
         END INPUT

         BEFORE DIALOG
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            #add-point:ui_dialog段before dialog
            NEXT FIELD b_site
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog
            LET g_master_t.* =  g_master.*
            CALL anmp840_b_fill()
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
 
 
         
            LET g_wc2 = " 1=1"
 
            #儲存WC資訊
            CALL anmp840_b_fill()
      
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
 
         ON ACTION datarefresh   # 重新整理
            CALL anmp840_b_fill()
 
         #+ 此段落由子樣板qs19產生
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xreb_d.getLength()
               LET g_xreb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xreb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xreb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel
         ON ACTION batch_execute
            CALL anmp840_process() 
            #end add-point
 
 
 
         #+ 此段落由子樣板qs16產生
         ON ACTION filter
            LET g_action_choice="filter"
            CALL anmp840_filter()
            #add-point:ON ACTION filter

            #END add-point
            EXIT DIALOG
 
 
         
         #+ 此段落由子樣板a43產生
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               EXIT DIALOG
            END IF
 
 
      
         #主選單用ACTION
         &include "main_menu.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION queryplansel
            #不是空條件才寫入g_wc跟重新找資料
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL anmp840_b_fill()
            END IF
 
         ON ACTION qbe_select
            LET ls_wc = ""
            CALL cl_qbe_list("c") RETURNING ls_wc
            IF NOT cl_null(ls_wc) THEN
               LET g_wc = ls_wc
               CALL anmp840_b_fill()
            END IF
 
         ON ACTION qbe_save
            CALL cl_qbe_save()
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
 
         #add-point:查詢方案相關ACTION設定後
            CLEAR FORM
            INITIALIZE g_master.* TO NULL
            CALL anmp840_def()
         #end add-point
 
      END DIALOG 
   
   END WHILE
END FUNCTION

 
{</section>}
 