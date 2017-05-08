#該程式未解開Section, 採用最新樣板產出!
{<section id="acrq520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2014-08-01 17:00:01), PR版次:0002(2016-01-27 15:51:20)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000078
#+ Filename...: acrq520
#+ Description: 會員交互動態查詢作業
#+ Creator....: 02296(2014-08-01 09:35:34)
#+ Modifier...: 02296 -SD/PR- 04226
 
{</section>}
 
{<section id="acrq520.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"

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
PRIVATE TYPE type_g_mmaf_d RECORD
       
       sel LIKE type_t.chr1, 
   mmaf001 LIKE mmaf_t.mmaf001, 
   mmaf008 LIKE mmaf_t.mmaf008, 
   mmag002 LIKE mmag_t.mmag002, 
   mmag002_desc LIKE type_t.chr500, 
   mmag004 LIKE mmag_t.mmag004, 
   mmag004_desc LIKE type_t.chr500, 
   mmaf015 LIKE mmaf_t.mmaf015, 
   age LIKE type_t.chr500, 
   mmaf014 LIKE mmaf_t.mmaf014, 
   decc016 LIKE type_t.num20_6, 
   decc010 LIKE type_t.num20_6, 
   decc006 LIKE type_t.num20_6, 
   decc014 LIKE type_t.num20_6, 
   mmaq013 LIKE type_t.dat
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE l_startdate           LIKE decc_t.decc002
DEFINE l_enddate             LIKE decc_t.decc002
DEFINE l_startmoney          LIKE decc_t.decc010
DEFINE l_endmoney            LIKE decc_t.decc010
DEFINE g_wc3                 STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_mmaf_d            DYNAMIC ARRAY OF type_g_mmaf_d
DEFINE g_mmaf_d_t          type_g_mmaf_d
 
 
 
 
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
 
{<section id="acrq520.main" >}
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
   CALL cl_ap_init("acr","")
 
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
   DECLARE acrq520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE acrq520_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrq520_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrq520 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrq520_init()   
 
      #進入選單 Menu (="N")
      CALL acrq520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrq520
      
   END IF 
   
   CLOSE acrq520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acrq520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION acrq520_init()
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
   
   #end add-point
 
   CALL acrq520_default_search()
END FUNCTION
 
{</section>}
 
{<section id="acrq520.default_search" >}
PRIVATE FUNCTION acrq520_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " mmaf001 = '", g_argv[01], "' AND "
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
 
{<section id="acrq520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrq520_ui_dialog() 
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
   DEFINE l_days   LIKE type_t.num5
   DEFINE l_month  LIKE type_t.num5
   DEFINE l_year   LIKE type_t.num5
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
   
   
   LET l_month=MONTH(g_today)-1
   LET l_year = YEAR(g_today)
#   LET l_days = cl_days(l_year,l_month)
   LET l_days = s_date_get_max_day(l_year,l_month)
   LET l_startdate=MDY(l_month,1,l_year)
   LET l_enddate = MDY(l_month,l_days,l_year)
   #end add-point
 
   
   CALL acrq520_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_mmaf_d.clear()
 
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
 
         CALL acrq520_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
        
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #160126-00002#1 160127 By pomelo add(S)
         CONSTRUCT g_wc ON mmaf001,mmaf008,mmaf014 FROM mmaf001,mmaf008,mmaf014
 
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               IF cl_null(l_startdate) THEN
                  LET l_startdate=MDY(l_month,1,l_year)
               END IF
               IF cl_null(l_enddate) THEN            
                  LET l_enddate = MDY(l_month,l_days,l_year)
               END IF   
               DISPLAY l_startdate,l_enddate TO startdate,enddate
               
            
            ON ACTION controlp INFIELD mmaf001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mmaf001_1()
               DISPLAY g_qryparam.return1 TO mmaf001
               NEXT FIELD mmaf001
               
         END CONSTRUCT
         
         CONSTRUCT g_wc3 ON mmag002,mmag004 FROM mmag002,mmag004
         
            BEFORE CONSTRUCT
               CALL cl_qbe_init()
            ON ACTION controlp INFIELD mmag002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2049'
               CALL q_oocq002_02()
               DISPLAY g_qryparam.return1 TO mmag002
               NEXT FIELD mmag002
               
            ON ACTION controlp INFIELD mmag004
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_mmag004()
               DISPLAY g_qryparam.return1 TO mmag004
               NEXT FIELD mmag004
               
         END CONSTRUCT
      
         INPUT l_startdate,l_enddate,l_startmoney,l_endmoney
            FROM startdate,enddate,startmoney,endmoney
            
            BEFORE INPUT
               DISPLAY l_startdate,l_enddate TO startdate,enddate
            
            AFTER FIELD startdate
               IF NOT cl_null(l_startdate) AND NOT cl_null(l_enddate) THEN
                  IF l_startdate>l_enddate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00080"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD startdate
                  END IF
               END IF
               
            AFTER FIELD enddate
               IF NOT cl_null(l_startdate) AND NOT cl_null(l_enddate) THEN
                  IF l_startdate>l_enddate THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "amm-00080"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD enddate
                  END IF
               END IF
               
            AFTER FIELD startmoney
               IF NOT cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
                  IF l_startmoney>l_endmoney THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00017"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD startmoney
                  END IF
               END IF
               
            AFTER FIELD endmoney
               IF NOT cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
                  IF l_startmoney>l_endmoney THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "ast-00017"
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD endmoney
                  END IF
               END IF    
               
         END INPUT
         #160126-00002#1 160127 By pomelo add(E)
         #end add-point
     
         DISPLAY ARRAY g_mmaf_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL acrq520_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL acrq520_b_fill2()
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
            CALL acrq520_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #NEXT FIELD sel #160126-00002#1 160127 By pomelo mark
            #160126-00002#1 160127 By pomelo add(S)
            DISPLAY l_startdate,l_enddate TO startdate,enddate
            CALL cl_set_act_visible("query", FALSE) 
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            #160126-00002#1 160127 By pomelo add(E)
            #end add-point
            NEXT FIELD mmaf001
 
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
            CALL acrq520_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_mmaf_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL acrq520_b_fill()
 
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
            CALL acrq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL acrq520_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL acrq520_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL acrq520_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_mmaf_d.getLength()
               LET g_mmaf_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_mmaf_d.getLength()
               LET g_mmaf_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_mmaf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmaf_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_mmaf_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_mmaf_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL acrq520_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)  #160126-00002#1 160127 By pomelo add
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
               CALL acrq520_query()
               EXIT DIALOG
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
 
{<section id="acrq520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrq520_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
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
 
   CALL g_mmaf_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(g_wc3) THEN
      LET g_wc2 = " 1=1"
   END IF
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014,'','','','',''  , 
       DENSE_RANK() OVER( ORDER BY mmaf_t.mmaf001) AS RANK FROM mmaf_t",
 
 
                     "",
                     " WHERE mmafent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("mmaf_t"),
                     " ORDER BY mmaf_t.mmaf001"
 
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
 
   LET g_sql = "SELECT '',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014,'','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF g_wc3=' 1=1' THEN
      LET g_sql = " SELECT  UNIQUE 'N',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014,sum(decc016),sum(decc010),sum(decc006),sum(decc014),'' FROM mmaf_t", 
               " LEFT JOIN decc_t ON mmaf001=decc001 AND mmafent=deccent ",               
               " WHERE mmafent= ? AND 1=1 AND ", ls_wc
   ELSE
      LET g_sql = " SELECT  UNIQUE 'N',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014,sum(decc016),sum(decc010),sum(decc006),sum(decc014),'' FROM mmaf_t", 
               " LEFT JOIN decc_t ON mmaf001=decc001 AND mmafent=deccent ",
#               " LEFT JOIN mmag_t ON mmag001=mmaf001 ",               
               " WHERE mmafent= ? AND mmaf001 IN (SELECT mmag001 FROM mmag_t WHERE mmagent=",g_enterprise," AND ",g_wc3," ) AND ", ls_wc
   END IF
   IF NOT cl_null(l_startdate) THEN
      LET g_sql = g_sql," AND decc002>='",l_startdate,"' "
   END IF
   IF NOT cl_null(l_enddate) THEN
      LET g_sql = g_sql," AND decc002<='",l_enddate,"' "
   END IF
   LET g_sql = g_sql," GROUP BY 'N',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014 "
   IF NOT cl_null(l_startmoney) OR NOT cl_null(l_endmoney) THEN
      LET g_sql = g_sql," HAVING "
   END IF
   IF NOT cl_null(l_startmoney)  THEN
      LET g_sql = g_sql," SUM(decc010)>= ",l_startmoney
   END IF
   IF NOT cl_null(l_endmoney) THEN
      IF cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
         LET g_sql = g_sql," SUM(decc010)<= ",l_endmoney
      END IF
      IF NOT cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
         LET g_sql = g_sql," AND SUM(decc010)<= ",l_endmoney
      END IF
   END IF
   LET g_sql = g_sql," ORDER BY 'N',mmaf001,mmaf008,'','','','',mmaf015,'',mmaf014 "
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE acrq520_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR acrq520_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_mmaf_d[l_ac].sel,g_mmaf_d[l_ac].mmaf001,g_mmaf_d[l_ac].mmaf008,g_mmaf_d[l_ac].mmag002, 
       g_mmaf_d[l_ac].mmag002_desc,g_mmaf_d[l_ac].mmag004,g_mmaf_d[l_ac].mmag004_desc,g_mmaf_d[l_ac].mmaf015, 
       g_mmaf_d[l_ac].age,g_mmaf_d[l_ac].mmaf014,g_mmaf_d[l_ac].decc016,g_mmaf_d[l_ac].decc010,g_mmaf_d[l_ac].decc006, 
       g_mmaf_d[l_ac].decc014,g_mmaf_d[l_ac].mmaq013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
               
      SELECT mmag004 INTO g_mmaf_d[l_ac].mmag004 FROM mmag_t
       WHERE mmagent = g_enterprise AND mmag001 = g_mmaf_d[l_ac].mmaf001
         AND mmag002 = '01' AND mmag003='2016' 
      SELECT oocql004 INTO g_mmaf_d[l_ac].mmag004_desc FROM oocql_t
       WHERE oocqlent = g_enterprise AND oocql001 = '2016' AND oocql002 = g_mmaf_d[l_ac].mmag004
         AND oocql003 = g_dlang
      LET  g_mmaf_d[l_ac].age = year(g_today)-year(g_mmaf_d[l_ac].mmaf015)+1  
      SELECT max(mmaq013) INTO g_mmaf_d[l_ac].mmaq013 FROM mmaq_t
       WHERE mmaqent = g_enterprise AND mmaq003 = g_mmaf_d[l_ac].mmaf001
      #end add-point
 
      CALL acrq520_detail_show("'1'")
 
      CALL acrq520_mmaf_t_mask()
 
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
 
   CALL g_mmaf_d.deleteElement(g_mmaf_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_mmaf_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE acrq520_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL acrq520_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL acrq520_detail_action_trans()
 
   LET l_ac = 1
   IF g_mmaf_d.getLength() > 0 THEN
      CALL acrq520_b_fill2()
   END IF
 
      CALL acrq520_filter_show('mmaf001','b_mmaf001')
 
 
END FUNCTION
 
{</section>}
 
{<section id="acrq520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrq520_b_fill2()
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
 
{<section id="acrq520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acrq520_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaf_d[l_ac].mmag002
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2049' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_mmaf_d[l_ac].mmag002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaf_d[l_ac].mmag002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_mmaf_d[l_ac].mmag004
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='2016' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_mmaf_d[l_ac].mmag004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_mmaf_d[l_ac].mmag004_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq520.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION acrq520_filter()
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
      CONSTRUCT g_wc_filter ON mmaf001
                          FROM s_detail1[1].b_mmaf001
 
         BEFORE CONSTRUCT
                     DISPLAY acrq520_filter_parser('mmaf001') TO s_detail1[1].b_mmaf001
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_mmaf001>>----
         #Ctrlp:construct.c.page1.b_mmaf001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_mmaf001
            #add-point:ON ACTION controlp INFIELD b_mmaf001 name="construct.c.filter.page1.b_mmaf001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_mmaf001  #顯示到畫面上
            NEXT FIELD b_mmaf001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_mmaf008>>----
         #----<<b_mmag002>>----
         #----<<b_mmag002_desc>>----
         #----<<b_mmag004>>----
         #----<<b_mmag004_desc>>----
         #----<<b_mmaf015>>----
         #----<<age>>----
         #----<<b_mmaf014>>----
         #----<<decc016>>----
         #----<<decc010>>----
         #----<<decc006>>----
         #----<<decc014>>----
         #----<<mmaq013>>----
 
 
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
 
      CALL acrq520_filter_show('mmaf001','b_mmaf001')
 
 
   CALL acrq520_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq520.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION acrq520_filter_parser(ps_field)
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
 
{<section id="acrq520.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION acrq520_filter_show(ps_field,ps_object)
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
   LET ls_condition = acrq520_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="acrq520.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION acrq520_detail_action_trans()
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
 
{<section id="acrq520.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION acrq520_detail_index_setting()
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
            IF g_mmaf_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_mmaf_d.getLength() AND g_mmaf_d.getLength() > 0
            LET g_detail_idx = g_mmaf_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_mmaf_d.getLength() THEN
               LET g_detail_idx = g_mmaf_d.getLength()
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
 
{<section id="acrq520.mask_functions" >}
 &include "erp/acr/acrq520_mask.4gl"
 
{</section>}
 
{<section id="acrq520.other_function" readonly="Y" >}

#查詢
PRIVATE FUNCTION acrq520_query()
   DEFINE l_days   LIKE type_t.num5
   DEFINE l_month  LIKE type_t.num5
   DEFINE l_year   LIKE type_t.num5
   
   CLEAR FORM
   CALL g_mmaf_d.clear()
   LET l_month=MONTH(g_today)-1
   LET l_year = YEAR(g_today)
#   LET l_days = cl_days(l_year,l_month)
   LET l_days = s_date_get_max_day(l_year,l_month)

   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
   LET l_startdate=MDY(l_month,1,l_year)
   LET l_enddate = MDY(l_month,l_days,l_year)
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
   DISPLAY l_startdate,l_enddate TO startdate,enddate
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #+ 此段落由子樣板qs08產生
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc ON mmaf001,mmaf008,mmaf014
                          FROM mmaf001,mmaf008,mmaf014
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
            IF cl_null(l_startdate) THEN
               LET l_startdate=MDY(l_month,1,l_year)
            END IF
            IF cl_null(l_enddate) THEN            
               LET l_enddate = MDY(l_month,l_days,l_year)
            END IF   
            DISPLAY l_startdate,l_enddate TO startdate,enddate
            
 
         ON ACTION controlp INFIELD mmaf001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_mmaf001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmaf001  #顯示到畫面上
            NEXT FIELD mmaf001                    #返回原欄位
           
      END CONSTRUCT
 
      #add-point:filter段add_cs
      CONSTRUCT g_wc3 ON mmag002,mmag004
                          FROM mmag002,mmag004
 
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
#            IF cl_null(l_startdate) THEN
#               LET l_startdate=MDY(l_month,1,l_year)
#            END IF
#            IF cl_null(l_enddate) THEN            
#               LET l_enddate = MDY(l_month,l_days,l_year)
#            END IF   
#            DISPLAY l_startdate,l_enddate TO startdate,enddate
            
 
         
         ON ACTION controlp INFIELD mmag002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2049'
            CALL q_oocq002_02()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmag002  #顯示到畫面上
            NEXT FIELD mmag002                     #返回原欄位
         ON ACTION controlp INFIELD mmag004
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = " oocq001 in (SELECT oocq004 FROM oocq_t where oocq001='2049' AND oocqent=",g_enterprise,")"
            CALL q_mmag004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO mmag004  #顯示到畫面上
            NEXT FIELD mmag004                     #返回原欄位   
      END CONSTRUCT
      
      INPUT l_startdate,l_enddate,l_startmoney,l_endmoney
       FROM  startdate,enddate,startmoney,endmoney
         BEFORE INPUT
            DISPLAY l_startdate,l_enddate TO startdate,enddate
         AFTER FIELD startdate
            IF NOT cl_null(l_startdate) AND NOT cl_null(l_enddate) THEN
               IF l_startdate>l_enddate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00080"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD startdate
               END IF
               
            END IF
         AFTER FIELD enddate
            IF NOT cl_null(l_startdate) AND NOT cl_null(l_enddate) THEN
               IF l_startdate>l_enddate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "amm-00080"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD enddate
               END IF
               
            END IF
         AFTER FIELD startmoney
            IF NOT cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
               IF l_startmoney>l_endmoney THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ast-00017"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD startmoney
               END IF
               
            END IF
         AFTER FIELD endmoney
            IF NOT cl_null(l_startmoney) AND NOT cl_null(l_endmoney) THEN
               IF l_startmoney>l_endmoney THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "ast-00017"
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD endmoney
               END IF
               
            END IF         
      END INPUT
      #end add-point
 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
      LET g_wc = g_wc, " "
   ELSE
      LET g_wc = g_wc_t
   END IF
   IF cl_null(g_wc3) THEN
      LET g_wc3 = " 1=1"
   END IF
 
   CALL acrq520_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
END FUNCTION

 
{</section>}
 
