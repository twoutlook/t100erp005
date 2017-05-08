#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-07 18:31:43), PR版次:0003(2016-09-08 15:59:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: adeq101
#+ Description: 門店單品銷售排行查詢作業
#+ Creator....: 06814(2015-12-25 15:38:49)
#+ Modifier...: 06137 -SD/PR- 00700
 
{</section>}
 
{<section id="adeq101.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160908-00032#1   2016/09/08 by rainy       q_pmaa001()開窗加上條件pmaa002='1' or '3'
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
PRIVATE TYPE type_g_deba_d RECORD
       
       sel LIKE type_t.chr1, 
   debasite LIKE deba_t.debasite, 
   debasite_desc LIKE type_t.chr500, 
   l_rank_1 LIKE type_t.num10, 
   deba010 LIKE deba_t.deba010, 
   deba009 LIKE deba_t.deba009, 
   deba009_desc LIKE type_t.chr500, 
   deba009_desc_desc LIKE type_t.chr500, 
   deba016 LIKE deba_t.deba016, 
   deba016_desc LIKE type_t.chr500, 
   deba020 LIKE deba_t.deba020, 
   deba020_desc LIKE type_t.chr500, 
   deba021 LIKE deba_t.deba021, 
   deba022 LIKE deba_t.deba022, 
   deba047 LIKE deba_t.deba047, 
   deba027 LIKE deba_t.deba027, 
   deba028 LIKE deba_t.deba028, 
   rtdx016 LIKE rtdx_t.rtdx016, 
   deba051 LIKE deba_t.deba051, 
   l_rate LIKE type_t.num20_6, 
   deba014 LIKE deba_t.deba014, 
   deba014_desc LIKE type_t.chr500, 
   l_deba021_y LIKE type_t.num20_6, 
   l_deba022_y LIKE type_t.num20_6, 
   l_deba047_y LIKE type_t.num20_6, 
   l_deba027_y LIKE type_t.num20_6, 
   l_deba028_y LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_head      RECORD
       debasite    LIKE deba_t.debasite,
       rtaw001     LIKE rtaw_t.rtaw001,
       l_bdate     LIKE type_t.dat,
       l_edate     LIKE type_t.dat,
       l_rank      LIKE type_t.chr10,
       l_orderway  LIKE type_t.chr10,
       l_sitemerge LIKE type_t.chr1
                   END RECORD
DEFINE g_ls_wc               STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_deba_d            DYNAMIC ARRAY OF type_g_deba_d
DEFINE g_deba_d_t          type_g_deba_d
 
 
 
 
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
 
{<section id="adeq101.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ade","")
 
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
   DECLARE adeq101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq101_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq101_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq101 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq101_init()   
 
      #進入選單 Menu (="N")
      CALL adeq101_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq101
      
   END IF 
   
   CLOSE adeq101_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   CALL adeq101_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq101_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL adeq101_create_temp() RETURNING l_success
   CALL cl_set_combo_scc('l_orderway','6887')
   #end add-point
 
   CALL adeq101_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq101.default_search" >}
PRIVATE FUNCTION adeq101_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " debasite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " deba002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " deba005 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " deba009 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " deba017 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " deba018 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " deba020 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " deba043 = '", g_argv[08], "' AND "
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
 
{<section id="adeq101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq101_ui_dialog() 
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
 
   
   CALL adeq101_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deba_d.clear()
 
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
 
         CALL adeq101_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_head.l_bdate,g_head.l_edate,g_head.l_rank,g_head.l_orderway,g_head.l_sitemerge
             FROM l_bdate,l_edate,l_rank,l_orderway,l_sitemerge
             
             BEFORE INPUT 
                LET g_ls_wc= '1'
             ON CHANGE l_bdate
                LET g_ls_wc= '1'
             ON CHANGE l_edate
                LET g_ls_wc= '1'
             ON CHANGE l_rank
                LET g_ls_wc= '1'
             ON CHANGE l_orderway
                LET g_ls_wc= '1'
             ON CHANGE l_sitemerge
                LET g_ls_wc= '1'
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON debasite,rtaw001
         
            BEFORE CONSTRUCT 
               LET g_ls_wc= '1'
               DISPLAY "g_ls_wc:",g_ls_wc
               
            ON ACTION controlp INFIELD debasite
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')
                  CALL q_ooef001_24()                    #呼叫開窗
                  DISPLAY g_qryparam.return1 TO debasite    #顯示到畫面上
                  NEXT FIELD debasite                    #返回原欄位
                  
            ON ACTION controlp INFIELD rtaw001
                  #開窗c段
                  INITIALIZE g_qryparam.* TO NULL
                  LET g_qryparam.state = 'c'
                  LET g_qryparam.reqry = FALSE
                  #aoos010:ART設定:品類管理層級
                  LET g_qryparam.where = " rtax004 ='",cl_get_para(g_enterprise,"","E-CIR-0001"),"'"
                  CALL q_rtax001()                       #呼叫開窗
                  DISPLAY g_qryparam.return1 TO rtaw001    #顯示到畫面上
                  NEXT FIELD rtaw001                    #返回原欄位
                  
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_deba_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq101_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq101_b_fill2()
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
            CALL adeq101_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            LET g_head.l_bdate    = g_today
            LET g_head.l_edate    = g_today
            LET g_head.l_orderway = '1'
            LET g_head.l_sitemerge= 'N'
            #end add-point
            NEXT FIELD debasite
 
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
            IF cl_null(g_head.l_bdate) THEN
               INITIALIZE g_errparam TO NULL     
               LET g_errparam.code = 'ast-00468'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err() 
               NEXT FIELD l_bdate
            END IF
            IF cl_null(g_head.l_edate) THEN
               INITIALIZE g_errparam TO NULL     
               LET g_errparam.code = 'ast-00469'
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE  
               CALL cl_err() 
               NEXT FIELD l_edate
            END IF
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adeq101_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_deba_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq101_b_fill()
 
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
            CALL adeq101_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq101_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq101_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq101_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_deba_d.getLength()
               LET g_deba_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_deba_d.getLength()
               LET g_deba_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_deba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deba_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_deba_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deba_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq101_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
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
 
{<section id="adeq101.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq101_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_tmp_sql       STRING
   DEFINE l_tmp_string    STRING
   DEFINE l_last_year_s_date     LIKE type_t.dat    #160329-00036#1 Add By Ken 160407
   DEFINE l_last_year_e_date     LIKE type_t.dat    #160329-00036#1 Add By Ken 160407
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'debasite') RETURNING l_where
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
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
 
   CALL g_deba_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc, " AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',debasite,'','',deba010,deba009,'','',deba016,'',deba020,'',deba021, 
       deba022,deba047,deba027,deba028,'',deba051,'',deba014,'','','','','',''  ,DENSE_RANK() OVER( ORDER BY deba_t.debasite, 
       deba_t.deba002,deba_t.deba005,deba_t.deba009,deba_t.deba017,deba_t.deba018,deba_t.deba020,deba_t.deba043) AS RANK FROM deba_t", 
 
 
 
                     "",
                     " WHERE debaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deba_t"),
                     " ORDER BY deba_t.debasite,deba_t.deba002,deba_t.deba005,deba_t.deba009,deba_t.deba017,deba_t.deba018,deba_t.deba020,deba_t.deba043"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   IF g_head.l_orderway ='1' THEN 
      IF g_head.l_sitemerge='Y' THEN
         LET l_tmp_string = "DENSE_RANK() OVER( ORDER BY COALESCE(SUM(deba047),0) DESC) AS RANK"
      ELSE
         LET l_tmp_string = "DENSE_RANK() OVER(PARTITION BY deba_t.debasite ORDER BY deba_t.debasite,COALESCE(SUM(deba047),0) DESC) AS RANK"
      END IF
   ELSE
      IF g_head.l_sitemerge='Y' THEN
         LET l_tmp_string = "DENSE_RANK() OVER( ORDER BY COALESCE(SUM(deba021),0) DESC) AS RANK"
      ELSE
         LET l_tmp_string = "DENSE_RANK() OVER(PARTITION BY deba_t.debasite ORDER BY deba_t.debasite,COALESCE(SUM(deba021),0) DESC) AS RANK"
      END IF   
   END IF
         
   #LET ls_sql_rank = "SELECT  UNIQUE      '',",g_enterprise,",debasite,ooefl003 debasite_desc,",
   #                  "      ",l_tmp_string,",deba010, ",
   #                  "               deba009,imaal003 deba009_desc,imaal004 deba009_desc_desc,deba020,oocal003 deba020_desc, ",               
   #                  "               COALESCE(SUM(deba021),0) s_deba021,COALESCE(SUM(deba022),0) s_deba022,COALESCE(SUM(deba047),0) s_deba047,COALESCE(SUM(deba027),0) s_deba027,0, ",
   #                  "               COALESCE(SUM(rtdx016),0) s_rtdx016,COALESCE(SUM(deba051),0) s_deba051,0,rtaw001,0,0 ",                   
   #                  "  FROM deba_t", 
   #                  "  LEFT JOIN ooefl_t ON ooeflent = debaent AND ooefl001 = debasite AND ooefl002 = '",g_dlang,"' ",
   #                  "  LEFT JOIN imaal_t ON imaalent = debaent AND imaal001 = deba009 AND imaal002 = '",g_dlang,"' ",
   #                  "  LEFT JOIN oocal_t ON oocalent = debaent AND oocal001 = deba020 AND oocal002 = '",g_dlang,"' ",
   #                  "  LEFT JOIN rtaw_t  ON rtawent  = debaent AND rtaw002  = deba016 AND rtaw003 = '",cl_get_para(g_enterprise,g_site,'E-CIR-0001'),"' ",
   #                  "  ,rtdx_t ",
   #                  " WHERE debaent = rtdxent AND debasite = rtdxsite AND deba009 = rtdx001 ",
   #                  "   AND debaent= ? AND 1=1 ",
   #                  "   AND deba002 BETWEEN '",g_head.l_bdate,"' AND '",g_head.l_edate,"' ",
   #                  "   AND ", ls_wc
   #LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deba_t"),   
   #                  " GROUP BY debasite,ooefl003,deba009,imaal003,imaal004,deba020,oocal003,deba010,rtdx016,rtaw001,deba016 "
   ###
   LET ls_sql_rank = "SELECT UNIQUE '',",g_enterprise,",debasite,",
                     "              (SELECT ooefl003 ",
				         "                 FROM ooefl_t ",
				         "                WHERE ooeflent = debaent AND ooefl001 = debasite AND ooefl002 = '",g_dlang,"' ) debasite_desc,",
                     "              RANK,deba010, ",
                     "              deba009,deba009_desc,deba009_desc_desc, ",
                     "              deba016,rtaxl003, ",  #160329-00036#1 Add By Ken 160407
                     "              deba020,",
				         "              (SELECT oocal003 ",
				         "                 FROM oocal_t ",
				         "                WHERE oocalent = debaent AND oocal001 = deba020 AND oocal002 = '",g_dlang,"' ) deba020_desc, ",
                     "              s_deba021,s_deba022,s_deba047,",
				         "              s_deba027,0, ",
                     "              s_rtdx016,s_deba051,0,",
				         "              (SELECT rtaw001 ",
				         "                 FROM rtaw_t ",
				         "                WHERE rtawent  = debaent AND rtaw002  = deba016 ",
				         "                  AND rtaw003 = '",cl_get_para(g_enterprise,g_site,'E-CIR-0001'),"' ) rtaw001,",
				         "              0,0 ",
				         "              ,deba014,pmaal003,0,0,0,0,0 ", #160329-00036#1 Add By Ken 160407
                     "FROM (SELECT  UNIQUE  debaent,debasite,",l_tmp_string,",deba010,deba009,",
                     "            imaal003 deba009_desc,imaal004 deba009_desc_desc,deba016, ",
                     "            rtaxl003, ",  #160329-00036#1 Add By Ken 160407
                     "            deba020,COALESCE(SUM(deba021),0) s_deba021,COALESCE(SUM(deba022),0) s_deba022, ",               
                     "            COALESCE(SUM(deba047),0) s_deba047,COALESCE(SUM(deba027),0) s_deba027, ",
                     "            COALESCE(SUM(rtdx016),0) s_rtdx016,COALESCE(SUM(deba051),0) s_deba051 ",
                     "            ,deba014,pmaal003,0,0,0,0,0 ", #160329-00036#1 Add By Ken 160407
                     "        FROM deba_t", 
                     "             LEFT JOIN rtaw_t on rtawent = debaent AND rtaw002 = deba016 AND rtaw003 = '",cl_get_para(g_enterprise,"","E-CIR-0001"),"' ",
                     "             LEFT JOIN imaal_t ON imaalent = debaent AND imaal001 = deba009 AND imaal002 = '",g_dlang,"' ",
                     "             LEFT JOIN rtaxl_t ON rtaxlent = debaent AND rtaxl001 = deba016 AND rtaxl002 = '",g_dlang,"' ", #160329-00036#1 Add By Ken 160407
                     "             LEFT JOIN pmaal_t ON pmaalent = debaent AND pmaal001 = deba014 AND pmaal002 = '",g_dlang,"' ", #160329-00036#1 Add By Ken 160407
                     "             ,rtdx_t ",
                     "       WHERE debaent = rtdxent AND debasite = rtdxsite AND deba009 = rtdx001 ",
                     "         AND debaent= ? AND 1=1 ",
                     "         AND deba002 BETWEEN '",g_head.l_bdate,"' AND '",g_head.l_edate,"' ",
                     "         AND ", ls_wc 
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deba_t"),
				         "       GROUP BY debaent,debasite,deba009,imaal003,imaal004,deba016,rtaxl003,deba020,deba010,rtdx016,deba014,pmaal003 )" #160329-00036#1 Modify By Ken 160407 新增rtaxl003,deba014
   
   DISPLAY "ls_sql_rank :",ls_sql_rank 
   ###   
   IF (ls_wc != g_ls_wc) THEN   #如果條件無改變,就不重整temp table
      DROP INDEX adeq101_tmp_index
      DELETE FROM adeq101_tmp
      LET l_tmp_sql = " INSERT INTO adeq101_tmp ",ls_sql_rank
      PREPARE adeq101_tmp_ins FROM l_tmp_sql
      EXECUTE adeq101_tmp_ins USING g_enterprise
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "ins_adeq101_tmp" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      
      #更新管理品類佔比
      #組織合併=Y,品類總金額
      IF g_head.l_sitemerge='Y' THEN
         LET l_tmp_sql = "UPDATE adeq101_tmp t1 SET t1.all_deba047 =( ",
                         " SELECT SUM(t2.s_deba047) ",
                         "   FROM adeq101_tmp t2",
                         "  GROUP BY t2.debaent )"
                         
         PREPARE adeq101_all_deba047 FROM l_tmp_sql
         EXECUTE adeq101_all_deba047
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "adeq101_all_deba047" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         LET l_tmp_sql = "UPDATE adeq101_tmp t1 SET t1.rtaw001_deba047 = ( ",
                         "    SELECT SUM(t2.s_deba047) ",
                         "      FROM adeq101_tmp t2 ",
                         "     WHERE t1.rtaw001=t2.rtaw001 ",
                         "  GROUP BY t2.rtaw001)"
         PREPARE adeq101_rtaw001_deba047 FROM l_tmp_sql
         EXECUTE adeq101_rtaw001_deba047 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "adeq101_rtaw001_deba047" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF
      ELSE
      #組織合併=N,品類總金額
         LET l_tmp_sql = "UPDATE adeq101_tmp t1 SET t1.all_deba047 =( ",
                         " SELECT SUM(t2.s_deba047) ",
                         "   FROM adeq101_tmp t2",
                         "     WHERE t1.debasite=t2.debasite ",
                         "  GROUP BY t2.debasite )"
                         
         PREPARE adeq101_all_deba047_1 FROM l_tmp_sql
         EXECUTE adeq101_all_deba047_1
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "adeq101_all_deba047_1" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
         LET l_tmp_sql = "UPDATE adeq101_tmp t1 SET t1.rtaw001_deba047 = ( ",
                         "    SELECT SUM(t2.s_deba047) ",
                         "      FROM adeq101_tmp t2 ",
                         "     WHERE t1.debasite=t2.debasite ",
                         "       AND t1.rtaw001=t2.rtaw001 ",
                         "  GROUP BY t2.debasite,t2.rtaw001)"
         PREPARE adeq101_rtaw001_deba047_1 FROM l_tmp_sql
         EXECUTE adeq101_rtaw001_deba047_1 
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "adeq101_rtaw001_deba047_1" 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
         END IF 
      END IF
      #比率
      
      CREATE INDEX adeq101_tmp_index ON adeq101_tmp(debaent,l_rank_1,deba009,s_deba021,s_deba022,s_deba047,s_deba027,s_deba051)
         IF SQLCA.SQLcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "CREATE INDEX adeq101_tmp"
            LET g_errparam.popup = TRUE
            #CALL cl_err()
            DISPLAY "g_errparam.code:",g_errparam.code
         END IF
         
      IF cl_db_generate_analyze("adeq101_tmp") THEN END IF

      LET l_tmp_sql =" UPDATE adeq101_tmp t1 SET ",
                     " (t1.l_rate , t1.deba028 )=( ",
                     "         SELECT UNIQUE (CASE WHEN t2.all_deba047 = 0 THEN 0",
                     "                        ELSE (COALESCE(t2.rtaw001_deba047,0)/COALESCE(t2.all_deba047,1)) * 100 * ",
                     "                              (CASE WHEN t2.rtaw001_deba047 < 0 THEN (-1) ELSE 1 END)  ",
                     "                        END) , ", 
                     "                       (CASE WHEN COALESCE(t2.s_deba047,0) = 0 THEN 100  ",
                     "                                          ELSE   ",
                     "                                             (COALESCE(t2.s_deba027,0)/COALESCE(t2.s_deba047,1)) * 100 *  ",
                     "                                             CASE WHEN t2.s_deba027 < 0 THEN (-1) ELSE 1 END  ",
                     "                                     END) ",
                     "         FROM adeq101_tmp t2  ",
                     "     WHERE    t1.debaent           =t2.debaent         ",
                     "       AND    t1.debasite          =t2.debasite        ",
                     "       AND    t1.l_rank_1          =t2.l_rank_1        ",
                     "       AND    t1.deba010           =t2.deba010         ",
                     "       AND    t1.deba009           =t2.deba009         ",
                     "       AND    t1.deba020           =t2.deba020         ",
                     "       AND    t1.s_deba021         =t2.s_deba021       ",
                     "       AND    t1.s_deba022         =t2.s_deba022       ",
                     "       AND    t1.s_deba047         =t2.s_deba047       ",
                     "       AND    t1.s_deba027         =t2.s_deba027       ",
                     "       AND    t1.s_rtdx016         =t2.s_rtdx016       ",
                     "       AND    t1.s_deba051         =t2.s_deba051      )"
      DISPLAY "l_tmp_sql:",l_tmp_sql       
      PREPARE adeq101_rate FROM l_tmp_sql
      EXECUTE adeq101_rate
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "adeq101_rate" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
    END IF  
    #重組ls_sql_rank(from temp table)
    LET ls_sql_rank = " SELECT     debaent,    debasite,    debasite_desc, l_rank_1, ",
                      "      deba010,   deba009,deba009_desc,deba009_desc_desc, ",
                      "      deba016,   deba016_desc, ",  #160329-00036#1 Add By Ken 160407
                      "      deba020, ",
                      " deba020_desc, s_deba021,   s_deba022,        s_deba047,s_deba027, ",
                      "      deba028, s_rtdx016,   s_deba051,l_rate ",
                      " ,ROW_NUMBER() OVER( ORDER BY l_rank_1) AS RANK",
                      " ,deba014,deba014_desc,s_deba021_y,s_deba022_y,s_deba047_y,s_deba027_y,deba028_y ", #160329-00036#1 Add By Ken 160407
                      "   FROM adeq101_tmp ", 
                      "  WHERE debaent = ? "
                      
    IF g_head.l_sitemerge='Y' THEN
       LET ls_sql_rank = ls_sql_rank ,      
                         " ORDER BY l_rank_1"
    ELSE
       LET ls_sql_rank = ls_sql_rank ,
                         " ORDER BY debasite, l_rank_1"
    END IF
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
 
   LET g_sql = "SELECT '',debasite,'','',deba010,deba009,'','',deba016,'',deba020,'',deba021,deba022, 
       deba047,deba027,deba028,'',deba051,'',deba014,'','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT      '',    debasite,    debasite_desc, l_rank_1,     deba010, ",
                  "       deba009,deba009_desc,deba009_desc_desc, ",
                  "       deba016,deba016_desc, ",  #160329-00036#1 Add By Ken 160407
                  "       deba020,deba020_desc, ",
                  "     s_deba021,   s_deba022,        s_deba047,s_deba027,",
                  "     deba028, ",
                  "     s_rtdx016,   s_deba051,          l_rate ",
                  "     ,deba014,deba014_desc, s_deba021_y, s_deba022_y, s_deba047_y, s_deba027_y, deba028_y ", #160329-00036#1 Add By Ken 160407
                  "  FROM (",ls_sql_rank,") ",
                  " WHERE RANK >= ",g_pagestart,
                  "   AND RANK < ",g_pagestart + g_num_in_page
   #查詢排名條件
   IF NOT cl_null(g_head.l_rank) THEN
      LET g_sql = g_sql CLIPPED," AND l_rank_1 ",g_head.l_rank," "
   END IF 
   
   #160329-00036#1 Add By Ken 160407(S)
   LET ls_sql_rank = "SELECT s_deba021,s_deba022,s_deba047,s_deba027 ",
                     "FROM (SELECT  UNIQUE  debaent,debasite,deba010,deba009,",
                     "            imaal003 deba009_desc,imaal004 deba009_desc_desc,deba016, ",
                     "            rtaxl003, ", 
                     "            deba020,COALESCE(SUM(deba021),0) s_deba021,COALESCE(SUM(deba022),0) s_deba022, ",               
                     "            COALESCE(SUM(deba047),0) s_deba047,COALESCE(SUM(deba027),0) s_deba027 ",
                     "        FROM deba_t", 
                     "             LEFT JOIN imaal_t ON imaalent = debaent AND imaal001 = deba009 AND imaal002 = '",g_dlang,"' ",
                     "             LEFT JOIN rtaxl_t ON rtaxlent = debaent AND rtaxl001 = deba016 AND rtaxl002 = '",g_dlang,"' ", #160329-00036#1 Add By Ken 160407
                     "             ,rtdx_t ",
                     "       WHERE debaent = rtdxent AND debasite = rtdxsite AND deba009 = rtdx001 ",
                     "         AND debaent= ? AND 1=1 ",
                     "         AND deba002 BETWEEN ? AND ? ",
                     "         AND deba009 = ? ",
				         "       GROUP BY debaent,debasite,deba009,imaal003,imaal004,deba016,rtaxl003,deba020,deba010,rtdx016 )" #160329-00036#1 Modify By Ken 160407 新增rtaxl003
   PREPARE adep101_last_year_pre FROM ls_sql_rank
   LET l_last_year_s_date = MDY(MONTH(g_head.l_bdate),DAY(g_head.l_bdate),YEAR(g_head.l_bdate) - 1)
   LET l_last_year_e_date = MDY(MONTH(g_head.l_edate),DAY(g_head.l_edate),YEAR(g_head.l_edate) - 1)
   #160329-00036#1 Add By Ken 160407(E)
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq101_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq101_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_deba_d[l_ac].sel,g_deba_d[l_ac].debasite,g_deba_d[l_ac].debasite_desc, 
       g_deba_d[l_ac].l_rank_1,g_deba_d[l_ac].deba010,g_deba_d[l_ac].deba009,g_deba_d[l_ac].deba009_desc, 
       g_deba_d[l_ac].deba009_desc_desc,g_deba_d[l_ac].deba016,g_deba_d[l_ac].deba016_desc,g_deba_d[l_ac].deba020, 
       g_deba_d[l_ac].deba020_desc,g_deba_d[l_ac].deba021,g_deba_d[l_ac].deba022,g_deba_d[l_ac].deba047, 
       g_deba_d[l_ac].deba027,g_deba_d[l_ac].deba028,g_deba_d[l_ac].rtdx016,g_deba_d[l_ac].deba051,g_deba_d[l_ac].l_rate, 
       g_deba_d[l_ac].deba014,g_deba_d[l_ac].deba014_desc,g_deba_d[l_ac].l_deba021_y,g_deba_d[l_ac].l_deba022_y, 
       g_deba_d[l_ac].l_deba047_y,g_deba_d[l_ac].l_deba027_y,g_deba_d[l_ac].l_deba028_y
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #160329-00036#1 Add By Ken 160407(S)
      EXECUTE adep101_last_year_pre USING g_enterprise,l_last_year_s_date,l_last_year_e_date,g_deba_d[l_ac].deba009
         INTO g_deba_d[l_ac].l_deba021_y,g_deba_d[l_ac].l_deba022_y,g_deba_d[l_ac].l_deba047_y,g_deba_d[l_ac].l_deba027_y
         
      IF g_deba_d[l_ac].l_deba027_y = 0 THEN
         LET g_deba_d[l_ac].l_deba028_y = 0
      ELSE
         LET g_deba_d[l_ac].l_deba028_y = g_deba_d[l_ac].l_deba027_y / g_deba_d[l_ac].l_deba047_y * 100
      END IF
      #160329-00036#1 Add By Ken 160407(E)
      #end add-point
 
      CALL adeq101_detail_show("'1'")
 
      CALL adeq101_deba_t_mask()
 
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
 
   CALL g_deba_d.deleteElement(g_deba_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   LET g_ls_wc = ls_wc
   CALL adeq101_set_comp_visible()
   CALL adeq101_set_comp_no_visible()
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_deba_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq101_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq101_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq101_detail_action_trans()
 
   LET l_ac = 1
   IF g_deba_d.getLength() > 0 THEN
      CALL adeq101_b_fill2()
   END IF
 
      CALL adeq101_filter_show('debasite','b_debasite')
   CALL adeq101_filter_show('deba010','b_deba010')
   CALL adeq101_filter_show('deba009','b_deba009')
   CALL adeq101_filter_show('deba016','b_deba016')
   CALL adeq101_filter_show('deba020','b_deba020')
   CALL adeq101_filter_show('deba021','b_deba021')
   CALL adeq101_filter_show('deba022','b_deba022')
   CALL adeq101_filter_show('deba047','b_deba047')
   CALL adeq101_filter_show('deba027','b_deba027')
   CALL adeq101_filter_show('deba028','b_deba028')
   CALL adeq101_filter_show('rtdx016','b_rtdx016')
   CALL adeq101_filter_show('deba051','b_deba051')
   CALL adeq101_filter_show('deba014','b_deba014')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq101.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq101_b_fill2()
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
 
{<section id="adeq101.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq101_detail_show(ps_page)
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
 
{<section id="adeq101.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq101_filter()
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
      CONSTRUCT g_wc_filter ON debasite,deba010,deba009,deba016,deba020,deba021,deba022,deba047,deba027, 
          deba028,rtdx016,deba051,deba014
                          FROM s_detail1[1].b_debasite,s_detail1[1].b_deba010,s_detail1[1].b_deba009, 
                              s_detail1[1].b_deba016,s_detail1[1].b_deba020,s_detail1[1].b_deba021,s_detail1[1].b_deba022, 
                              s_detail1[1].b_deba047,s_detail1[1].b_deba027,s_detail1[1].b_deba028,s_detail1[1].b_rtdx016, 
                              s_detail1[1].b_deba051,s_detail1[1].b_deba014
 
         BEFORE CONSTRUCT
                     DISPLAY adeq101_filter_parser('debasite') TO s_detail1[1].b_debasite
            DISPLAY adeq101_filter_parser('deba010') TO s_detail1[1].b_deba010
            DISPLAY adeq101_filter_parser('deba009') TO s_detail1[1].b_deba009
            DISPLAY adeq101_filter_parser('deba016') TO s_detail1[1].b_deba016
            DISPLAY adeq101_filter_parser('deba020') TO s_detail1[1].b_deba020
            DISPLAY adeq101_filter_parser('deba021') TO s_detail1[1].b_deba021
            DISPLAY adeq101_filter_parser('deba022') TO s_detail1[1].b_deba022
            DISPLAY adeq101_filter_parser('deba047') TO s_detail1[1].b_deba047
            DISPLAY adeq101_filter_parser('deba027') TO s_detail1[1].b_deba027
            DISPLAY adeq101_filter_parser('deba028') TO s_detail1[1].b_deba028
            DISPLAY adeq101_filter_parser('rtdx016') TO s_detail1[1].b_rtdx016
            DISPLAY adeq101_filter_parser('deba051') TO s_detail1[1].b_deba051
            DISPLAY adeq101_filter_parser('deba014') TO s_detail1[1].b_deba014
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_debasite>>----
         #Ctrlp:construct.c.page1.b_debasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_debasite
            #add-point:ON ACTION controlp INFIELD b_debasite name="construct.c.filter.page1.b_debasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'debasite',g_site,'c')
            CALL q_ooef001_24()                    #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_debasite  #顯示到畫面上
            NEXT FIELD b_debasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_debasite_desc>>----
         #----<<l_rank_1>>----
         #----<<b_deba010>>----
         #Ctrlp:construct.c.page1.b_deba010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba010
            #add-point:ON ACTION controlp INFIELD b_deba010 name="construct.c.filter.page1.b_deba010"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba010  #顯示到畫面上
            NEXT FIELD b_deba010                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deba009>>----
         #Ctrlp:construct.c.page1.b_deba009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba009
            #add-point:ON ACTION controlp INFIELD b_deba009 name="construct.c.filter.page1.b_deba009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba009  #顯示到畫面上
            NEXT FIELD b_deba009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deba009_desc>>----
         #----<<b_deba009_desc_desc>>----
         #----<<b_deba016>>----
         #Ctrlp:construct.c.page1.b_deba016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba016
            #add-point:ON ACTION controlp INFIELD b_deba016 name="construct.c.filter.page1.b_deba016"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_rtax001_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba016  #顯示到畫面上
            NEXT FIELD b_deba016                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_deba016_desc>>----
         #----<<b_deba020>>----
         #Ctrlp:construct.c.page1.b_deba020
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba020
            #add-point:ON ACTION controlp INFIELD b_deba020 name="construct.c.filter.page1.b_deba020"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba020  #顯示到畫面上
            NEXT FIELD b_deba020                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_deba020_desc>>----
         #----<<b_deba021>>----
         #Ctrlp:construct.c.filter.page1.b_deba021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba021
            #add-point:ON ACTION controlp INFIELD b_deba021 name="construct.c.filter.page1.b_deba021"
            
            #END add-point
 
 
         #----<<b_deba022>>----
         #Ctrlp:construct.c.filter.page1.b_deba022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba022
            #add-point:ON ACTION controlp INFIELD b_deba022 name="construct.c.filter.page1.b_deba022"
            
            #END add-point
 
 
         #----<<b_deba047>>----
         #Ctrlp:construct.c.filter.page1.b_deba047
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba047
            #add-point:ON ACTION controlp INFIELD b_deba047 name="construct.c.filter.page1.b_deba047"
            
            #END add-point
 
 
         #----<<b_deba027>>----
         #Ctrlp:construct.c.filter.page1.b_deba027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba027
            #add-point:ON ACTION controlp INFIELD b_deba027 name="construct.c.filter.page1.b_deba027"
            
            #END add-point
 
 
         #----<<b_deba028>>----
         #Ctrlp:construct.c.filter.page1.b_deba028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba028
            #add-point:ON ACTION controlp INFIELD b_deba028 name="construct.c.filter.page1.b_deba028"
            
            #END add-point
 
 
         #----<<b_rtdx016>>----
         #Ctrlp:construct.c.filter.page1.b_rtdx016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx016
            #add-point:ON ACTION controlp INFIELD b_rtdx016 name="construct.c.filter.page1.b_rtdx016"
            
            #END add-point
 
 
         #----<<b_deba051>>----
         #Ctrlp:construct.c.filter.page1.b_deba051
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba051
            #add-point:ON ACTION controlp INFIELD b_deba051 name="construct.c.filter.page1.b_deba051"
            
            #END add-point
 
 
         #----<<l_rate>>----
         #----<<b_deba014>>----
         #Ctrlp:construct.c.page1.b_deba014
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deba014
            #add-point:ON ACTION controlp INFIELD b_deba014 name="construct.c.filter.page1.b_deba014"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " pmaa002 IN ('1','3') "       #160908-00032#1 add by rainy
            CALL q_pmaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deba014  #顯示到畫面上
            NEXT FIELD b_deba014                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_deba014_desc>>----
         #----<<l_deba021_y>>----
         #----<<l_deba022_y>>----
         #----<<l_deba047_y>>----
         #----<<l_deba027_y>>----
         #----<<l_deba028_y>>----
 
 
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
 
      CALL adeq101_filter_show('debasite','b_debasite')
   CALL adeq101_filter_show('deba010','b_deba010')
   CALL adeq101_filter_show('deba009','b_deba009')
   CALL adeq101_filter_show('deba016','b_deba016')
   CALL adeq101_filter_show('deba020','b_deba020')
   CALL adeq101_filter_show('deba021','b_deba021')
   CALL adeq101_filter_show('deba022','b_deba022')
   CALL adeq101_filter_show('deba047','b_deba047')
   CALL adeq101_filter_show('deba027','b_deba027')
   CALL adeq101_filter_show('deba028','b_deba028')
   CALL adeq101_filter_show('rtdx016','b_rtdx016')
   CALL adeq101_filter_show('deba051','b_deba051')
   CALL adeq101_filter_show('deba014','b_deba014')
 
 
   CALL adeq101_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq101.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq101_filter_parser(ps_field)
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
 
{<section id="adeq101.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq101_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq101_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq101.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq101_detail_action_trans()
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
 
{<section id="adeq101.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq101_detail_index_setting()
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
            IF g_deba_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deba_d.getLength() AND g_deba_d.getLength() > 0
            LET g_detail_idx = g_deba_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deba_d.getLength() THEN
               LET g_detail_idx = g_deba_d.getLength()
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
 
{<section id="adeq101.mask_functions" >}
 &include "erp/ade/adeq101_mask.4gl"
 
{</section>}
 
{<section id="adeq101.other_function" readonly="Y" >}

PRIVATE FUNCTION adeq101_set_comp_visible()
   CALL cl_set_comp_visible("b_debasite,b_debasite_desc", TRUE)
END FUNCTION

PRIVATE FUNCTION adeq101_set_comp_no_visible()
   DEFINE l_cnt             LIKE type_t.num5
   
   SELECT COUNT(DISTINCT debasite) INTO l_cnt FROM adeq101_tmp
   DISPLAY "COUNT(DISTINCT debasite):",l_cnt
   #若查詢結果只有一個組織，或查詢條件「組織合併=Y」時，查詢結果的顯示畫面請隱藏組織／組織說明
   IF g_head.l_sitemerge='Y' OR l_cnt=1 THEN 
      CALL cl_set_comp_visible("b_debasite,b_debasite_desc", FALSE)
   END IF
END FUNCTION

PRIVATE FUNCTION adeq101_create_temp()
   DEFINE r_success         LIKE type_t.num5
   
   LET r_success = TRUE
   
   DROP TABLE adeq101_tmp
   
   CREATE TEMP TABLE adeq101_tmp(
          sel            VARCHAR(1),             #選取
      debaent            SMALLINT,         #企業編號
      debasite           VARCHAR(10),         #營運據點
      debasite_desc      VARCHAR(500),           #據點說明
      l_rank_1           INTEGER,           #排名
      deba010            VARCHAR(40),          #商品條碼
      deba009            VARCHAR(40),          #商品編號
      deba009_desc       VARCHAR(500),           #品名
      deba009_desc_desc  VARCHAR(500),           #規格
      deba016            VARCHAR(10),          #品類編號  #160329-00036#1 Add By Ken 160407
      deba016_desc       VARCHAR(500),           #品類名稱  #160329-00036#1 Add By Ken 160407
      deba020            VARCHAR(10),          #銷售單位
      deba020_desc       VARCHAR(500),           #銷售單位說明
      s_deba021          DECIMAL(20,6),          #銷售數量
      s_deba022          DECIMAL(20,6),          #銷售成本
      s_deba047          DECIMAL(20,6),          #實收金額
      s_deba027          DECIMAL(20,6),          #毛利
      deba028            DECIMAL(20,6),          #毛利率
      s_rtdx016          DECIMAL(20,6),          #售價
      s_deba051          DECIMAL(20,6),          #庫存數量
      l_rate             DECIMAL(20,6),          #管理品類佔比
      rtaw001            VARCHAR(10),          #管理品類
      rtaw001_deba047    DECIMAL(20,6),          #該品類銷售總金額
      all_deba047        DECIMAL(20,6),          #所有品類銷售總金額
      deba014            VARCHAR(10),          #主供應商      #160329-00036#1 Add By Ken 160407
      deba014_desc       VARCHAR(500),        #主供應商說明  #160329-00036#1 Add By Ken 160407
      s_deba021_y        DECIMAL(20,6),          #去年銷售數量  #160329-00036#1 Add By Ken 160407
      s_deba022_y        DECIMAL(20,6),          #去年銷售成本  #160329-00036#1 Add By Ken 160407
      s_deba047_y        DECIMAL(20,6),          #去年實收金額  #160329-00036#1 Add By Ken 160407
      s_deba027_y        DECIMAL(20,6),          #去年毛利     #160329-00036#1 Add By Ken 160407
      deba028_y          DECIMAL(20,6)     #去年毛利率    #160329-00036#1 Add By Ken 160407  
      )     
              
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table adeq101_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

PRIVATE FUNCTION adeq101_drop_temp()
   DEFINE r_success LIKE type_t.num5
   
   LET r_success = TRUE
   
   DROP TABLE adeq101_tmp
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table adeq101_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

 
{</section>}
 
