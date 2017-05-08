#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-06-01 09:35:07), PR版次:0003(2016-03-07 11:22:39)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000051
#+ Filename...: ainq500
#+ Description: 調撥申請單查詢列印作業
#+ Creator....: 02159(2015-02-12 16:38:34)
#+ Modifier...: 02159 -SD/PR- 06814
 
{</section>}
 
{<section id="ainq500.global" >}
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
PRIVATE TYPE type_g_inda_d RECORD
       
       sel LIKE type_t.chr1, 
   indastus LIKE inda_t.indastus, 
   indasite LIKE inda_t.indasite, 
   indasite_desc LIKE type_t.chr500, 
   indadocno LIKE inda_t.indadocno, 
   indadocdt LIKE inda_t.indadocdt, 
   inda001 LIKE inda_t.inda001, 
   inda001_desc LIKE type_t.chr500, 
   inda101 LIKE inda_t.inda101, 
   inda101_desc LIKE type_t.chr500, 
   inda003 LIKE inda_t.inda003, 
   inda003_desc LIKE type_t.chr500, 
   inda004 LIKE inda_t.inda004, 
   inda004_desc LIKE type_t.chr500, 
   inda002 LIKE inda_t.inda002, 
   inda002_desc LIKE type_t.chr500, 
   inda005 LIKE inda_t.inda005, 
   inda005_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_inda2_d RECORD
       indbseq LIKE indb_t.indbseq, 
   indb002 LIKE indb_t.indb002, 
   indb001 LIKE indb_t.indb001, 
   indb001_desc LIKE type_t.chr500, 
   indb001_desc_desc LIKE type_t.chr500, 
   indb004 LIKE indb_t.indb004, 
   indb004_desc LIKE type_t.chr500, 
   indb005 LIKE indb_t.indb005, 
   indb005_desc LIKE type_t.chr500, 
   indb007 LIKE indb_t.indb007, 
   indb008 LIKE indb_t.indb008, 
   indb009 LIKE indb_t.indb009, 
   indb010 LIKE indb_t.indb010, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb013 LIKE indb_t.indb013
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm        RECORD
     stus           LIKE type_t.chr10
                     END RECORD
DEFINE tm              type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_inda_d            DYNAMIC ARRAY OF type_g_inda_d
DEFINE g_inda_d_t          type_g_inda_d
DEFINE g_inda2_d     DYNAMIC ARRAY OF type_g_inda2_d
DEFINE g_inda2_d_t   type_g_inda2_d
 
 
 
 
 
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
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="ainq500.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
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
   DECLARE ainq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ainq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq500 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq500_init()   
 
      #進入選單 Menu (="N")
      CALL ainq500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq500
      
   END IF 
   
   CLOSE ainq500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq500_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
      CALL cl_set_combo_scc_part('b_indastus','13','N,Y,A,C,D,R,T,W,X')
 
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
 
   CALL ainq500_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq500.default_search" >}
PRIVATE FUNCTION ainq500_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " indadocno = '", g_argv[01], "' AND "
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
 
{<section id="ainq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq500_ui_dialog() 
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
   DEFINE l_where           STRING
   DEFINE l_cmd             STRING
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
 
   
   CALL ainq500_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_inda_d.clear()
         CALL g_inda2_d.clear()
 
 
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
 
         CALL ainq500_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT tm.stus
          FROM l_stus
            BEFORE INPUT
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON indadocno,indadocdt,inda005,
                                   inda003,inda101,inda001
                                   
               
            #申請單號
            ON ACTION controlp INFIELD indadocno
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
			      LET g_qryparam.where = " (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') "
               CALL q_indadocno()
               DISPLAY g_qryparam.return1 TO indadocno
               NEXT FIELD indadocno

            #撥出組織
            ON ACTION controlp INFIELD inda003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               IF s_aooi500_setpoint(g_prog,'inda003') THEN
                  #aooi500中有設定
                  LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda003',g_site,'c') #150308-00001#2  By sakura add 'c'
                  CALL q_ooef001_24()
               ELSE
                  #aooi500中未設定按原邏輯
			         LET g_qryparam.where = " ooef201 = 'Y' "
                  CALL q_ooef001()
               END IF
               DISPLAY g_qryparam.return1 TO inda003
               NEXT FIELD inda003
               
            #申請部門   
            ON ACTION controlp INFIELD inda101
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_4()
               DISPLAY g_qryparam.return1 TO inda101
               NEXT FIELD inda101
            
            #申請人員   
            ON ACTION controlp INFIELD inda001
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               CALL q_ooag001()
               DISPLAY g_qryparam.return1 TO inda001
               NEXT FIELD inda001 

         END CONSTRUCT 
         #end add-point
     
         DISPLAY ARRAY g_inda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL ainq500_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ainq500_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_inda2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
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
            CALL ainq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET tm.stus = 'ALL'
            DISPLAY tm.stus TO l_stus            
            CALL cl_set_act_visible("insert,query", FALSE)
            #end add-point
            NEXT FIELD indadocno
 
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
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL ainq500_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_inda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_inda2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq500_b_fill()
 
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
            CALL ainq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ainq500_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ainq500_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ainq500_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_inda_d.getLength()
               LET g_inda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_inda_d.getLength()
               LET g_inda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_inda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_inda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_inda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_inda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq500_filter()
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
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_inda_d.getLength()
                  IF g_inda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_inda_d[li_idx].indadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_inda_d[li_idx].indadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "indadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL ainr500_g01(l_where)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_inda_d.getLength()
                  IF g_inda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_inda_d[li_idx].indadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_inda_d[li_idx].indadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "indadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL ainr500_g01(l_where)
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
 
{<section id="ainq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq500_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'indasite') RETURNING l_where
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
 
   CALL g_inda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF tm.stus != 'ALL' THEN
      LET l_where = l_where CLIPPED," AND indastus = '",tm.stus CLIPPED,"'"
   END IF
   
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',indastus,indasite,'',indadocno,indadocdt,inda001,'',inda101, 
       '',inda003,'',inda004,'',inda002,'',inda005,''  ,DENSE_RANK() OVER( ORDER BY inda_t.indadocno) AS RANK FROM inda_t", 
 
 
#table2
                     " LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno",
 
                     "",
                     " WHERE indaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("inda_t"),
                     " ORDER BY inda_t.indadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150827 add by beckxie---E
   LET ls_sql_rank = "SELECT  UNIQUE 'N',indastus,indasite,",
               "        (SELECT ooefl003 ",   #申請組織說明
               "           FROM ooefl_t",
               "          WHERE indaent = ooeflent AND indasite = ooefl001 AND ooefl002 = '",g_dlang,"') indasite_desc,",
               "        indadocno,indadocdt,inda001,",
               "        (SELECT ooag011",   #申請人員說明
               "           FROM ooag_t",
               "          WHERE indaent = ooagent AND inda001 = ooag001) ooag011, ",  
               "        inda101,",
               "        (SELECT ooefl003",   #申請部門說明
               "           FROM ooefl_t",
               "          WHERE indaent = ooeflent AND inda101 = ooefl001 AND ooefl002 = '",g_dlang,"') inda101_desc,",   
               "        inda003,",
               "        (SELECT ooefl003",   #撥出組織說明
               "           FROM ooefl_t",
               "          WHERE indaent = ooeflent AND inda003 = ooefl001 AND ooefl002 = '",g_dlang,"') inda003_desc,",
               "        inda004,",
               "        (SELECT ooefl003",   #撥入組織說明 
               "           FROM ooefl_t",
               "          WHERE indaent = ooeflent AND inda004 = ooefl001 AND ooefl002 = '",g_dlang,"') inda004_desc,", 
               "        inda002,",
               "        (SELECT ooefl003",   #上級組織說明
               "           FROM ooefl_t",
               "          WHERE indaent = ooeflent AND inda002 = ooefl001 AND ooefl002 = '",g_dlang,"') inda002_desc,",  
               "        inda005,'', ",
               "DENSE_RANK() OVER( ORDER BY inda_t.indadocno) AS RANK ", 
               " FROM inda_t",
#table2
                     " LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno",
                     " WHERE indaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("inda_t"),
                     " ORDER BY inda_t.indadocno"
   #150826-00013#1 效能調整 20150827 add by beckxie---E
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
 
   LET g_sql = "SELECT '',indastus,indasite,'',indadocno,indadocdt,inda001,'',inda101,'',inda003,'', 
       inda004,'',inda002,'',inda005,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
#  #150826-00013#1 效能調整 20150827 mark by beckxie---S
#   LET g_sql = "SELECT  UNIQUE 'N',indastus,indasite,t1.ooefl003,indadocno,indadocdt,inda001,t2.ooag011,inda101,t3.ooefl003,inda003,", 
#               "               t4.ooefl003,inda004,t5.ooefl003,inda002,t6.ooefl003,inda005,'' ",
#               "  FROM inda_t",
#               "    LEFT JOIN indb_t ON indbent = indaent AND indadocno = indbdocno",
#               "    LEFT OUTER JOIN ooefl_t t1 ON indaent = t1.ooeflent AND indasite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #申請組織說明 
#               "    LEFT OUTER JOIN ooag_t  t2 on indaent = t2.ooagent AND inda001 = t2.ooag001 ",  #申請人員說明
#               "    LEFT OUTER JOIN ooefl_t t3 ON indaent = t3.ooeflent AND inda101 = t3.ooefl001 AND t3.ooefl002 = '",g_dlang,"' ",  #申請部門說明 
#               "    LEFT OUTER JOIN ooefl_t t4 ON indaent = t4.ooeflent AND inda003 = t4.ooefl001 AND t4.ooefl002 = '",g_dlang,"' ",  #撥出組織說明 
#               "    LEFT OUTER JOIN ooefl_t t5 ON indaent = t5.ooeflent AND inda004 = t5.ooefl001 AND t5.ooefl002 = '",g_dlang,"' ",  #撥入組織說明 
#               "    LEFT OUTER JOIN ooefl_t t6 ON indaent = t6.ooeflent AND inda002 = t6.ooefl001 AND t6.ooefl002 = '",g_dlang,"' ",  #上級組織說明 
#               " WHERE indaent= ? AND 1=1 AND ", ls_wc
#   LET g_sql = g_sql,"AND ",l_where," AND (indasite = '",g_site,"' OR inda002 = '",g_site,"' OR inda003 = '",g_site,"' OR inda004 = '",g_site,"') " #依aint500規則
#   LET g_sql = g_sql, cl_sql_add_filter("inda_t"),
#                      " ORDER BY inda_t.indadocno"
#  #150826-00013#1 效能調整 20150827 mark by beckxie---E
   #150826-00013#1 效能調整 20150827 add by beckxie---S
   LET g_sql = "SELECT  UNIQUE 'N',indastus,indasite,",
               "        indasite_desc,",
               "        indadocno,indadocdt,inda001,",
               "        ooag011, ",  
               "        inda101,",
               "        inda101_desc,",   
               "        inda003,",
               "        inda003_desc,",
               "        inda004,",
               "        inda004_desc,", 
               "        inda002,",
               "        inda002_desc,",  
               "        inda005,'' ",
              " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150827 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq500_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_inda_d[l_ac].sel,g_inda_d[l_ac].indastus,g_inda_d[l_ac].indasite,g_inda_d[l_ac].indasite_desc, 
       g_inda_d[l_ac].indadocno,g_inda_d[l_ac].indadocdt,g_inda_d[l_ac].inda001,g_inda_d[l_ac].inda001_desc, 
       g_inda_d[l_ac].inda101,g_inda_d[l_ac].inda101_desc,g_inda_d[l_ac].inda003,g_inda_d[l_ac].inda003_desc, 
       g_inda_d[l_ac].inda004,g_inda_d[l_ac].inda004_desc,g_inda_d[l_ac].inda002,g_inda_d[l_ac].inda002_desc, 
       g_inda_d[l_ac].inda005,g_inda_d[l_ac].inda005_desc
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
 
      CALL ainq500_detail_show("'1'")
 
      CALL ainq500_inda_t_mask()
 
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
 
   CALL g_inda_d.deleteElement(g_inda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_inda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq500_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ainq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ainq500_detail_action_trans()
 
   LET l_ac = 1
   IF g_inda_d.getLength() > 0 THEN
      CALL ainq500_b_fill2()
   END IF
 
      CALL ainq500_filter_show('indastus','b_indastus')
   CALL ainq500_filter_show('indasite','b_indasite')
   CALL ainq500_filter_show('indadocno','b_indadocno')
   CALL ainq500_filter_show('indadocdt','b_indadocdt')
   CALL ainq500_filter_show('inda001','b_inda001')
   CALL ainq500_filter_show('inda101','b_inda101')
   CALL ainq500_filter_show('inda003','b_inda003')
   CALL ainq500_filter_show('inda004','b_inda004')
   CALL ainq500_filter_show('inda002','b_inda002')
   CALL ainq500_filter_show('inda005','b_inda005')
   CALL ainq500_filter_show('indbseq','b_indbseq')
   CALL ainq500_filter_show('indb002','b_indb002')
   CALL ainq500_filter_show('indb001','b_indb001')
   CALL ainq500_filter_show('indb004','b_indb004')
   CALL ainq500_filter_show('indb005','b_indb005')
   CALL ainq500_filter_show('indb007','b_indb007')
   CALL ainq500_filter_show('indb008','b_indb008')
   CALL ainq500_filter_show('indb009','b_indb009')
   CALL ainq500_filter_show('indb010','b_indb010')
   CALL ainq500_filter_show('indb011','b_indb011')
   CALL ainq500_filter_show('indb012','b_indb012')
   CALL ainq500_filter_show('indb013','b_indb013')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq500_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_inda2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   LET l_cnt = g_inda_d.getLength()
   IF l_cnt <= 0 THEN
     RETURN
   END IF
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE indbseq,indb002,indb001,'','',indb004,'',indb005,'',indb007,indb008, 
          indb009,indb010,indb011,indb012,indb013 FROM indb_t",
                  "",
                  " WHERE indbent=? AND indbdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY indb_t.indbseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
#      #150826-00013#1 效能調整 20150827 add by beckxie---S
#      LET g_sql = "SELECT  UNIQUE indbseq,indb002,indb001,t1.imaal003,t1.imaal004,indb004,t2.oocal003,indb005,t3.oocal003,indb007,indb008,", 
#                  "               indb009,indb010,indb011,indb012,indb013 ",
#                  "   FROM indb_t ",
#                  "     LEFT OUTER JOIN imaal_t t1 on indbent = t1.imaalent AND indb001 = t1.imaal001 AND t1.imaal002 = '",g_dlang,"' ",  #品名、規格
#                  "     LEFT OUTER JOIN oocal_t t2 on indbent = t2.oocalent AND indb004 = t2.oocal001 AND t2.oocal002 = '",g_dlang,"' ",  #庫存單位說明
#                  "     LEFT OUTER JOIN oocal_t t3 on indbent = t3.oocalent AND indb005 = t3.oocal001 AND t3.oocal002 = '",g_dlang,"' ",  #包裝單位說明
#                  " WHERE indbent=? AND indbdocno=?"
#  
#      IF NOT cl_null(g_wc2_table2) THEN
#         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
#      END IF
#  
#      LET g_sql = g_sql, " ORDER BY indb_t.indbseq"
#      #150826-00013#1 效能調整 20150827 add by beckxie---E
      #150826-00013#1 效能調整 20150827 add by beckxie---S
      LET g_sql = "SELECT  UNIQUE indbseq,indb002,indb001,",
                  "        (SELECT imaal003",
                  "           FROM imaal_t",
                  "          WHERE indbent = imaalent AND indb001 = imaal001 AND imaal002 = '",g_dlang,"') imaal003, ",  #品名
                  "        (SELECT imaal004",
                  "           FROM imaal_t",
                  "          WHERE indbent = imaalent AND indb001 = imaal001 AND imaal002 = '",g_dlang,"') imaal004, ",  #規格
                  "        indb004,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE indbent = oocalent AND indb004 = oocal001 AND oocal002 = '",g_dlang,"') oocal003, ",  #庫存單位說明
                  "        indb005,",
                  "        (SELECT oocal003",
                  "           FROM oocal_t",
                  "          WHERE indbent = oocalent AND indb005 = oocal001 AND oocal002 = '",g_dlang,"') oocal003, ",  #包裝單位說明
                  "        indb007,indb008,indb009,indb010,indb011,indb012,indb013 ",
                  "   FROM indb_t ",
                  " WHERE indbent=? AND indbdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY indb_t.indbseq"
      #150826-00013#1 效能調整 20150827 add by beckxie---E
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE ainq500_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR ainq500_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_inda_d[g_detail_idx].indadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_inda_d[g_detail_idx].indadocno
 
      INTO g_inda2_d[l_ac].indbseq,g_inda2_d[l_ac].indb002,g_inda2_d[l_ac].indb001,g_inda2_d[l_ac].indb001_desc, 
          g_inda2_d[l_ac].indb001_desc_desc,g_inda2_d[l_ac].indb004,g_inda2_d[l_ac].indb004_desc,g_inda2_d[l_ac].indb005, 
          g_inda2_d[l_ac].indb005_desc,g_inda2_d[l_ac].indb007,g_inda2_d[l_ac].indb008,g_inda2_d[l_ac].indb009, 
          g_inda2_d[l_ac].indb010,g_inda2_d[l_ac].indb011,g_inda2_d[l_ac].indb012,g_inda2_d[l_ac].indb013 
 
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      
      #end add-point
 
      CALL ainq500_detail_show("'2'")
 
      CALL ainq500_indb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_inda2_d.deleteElement(g_inda2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_inda2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="ainq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq500_detail_show(ps_page)
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
      #150826-00013# 20160307 mark by beckxie---S
      #      INITIALIZE g_ref_fields TO NULL
      #      LET g_ref_fields[1] = g_inda_d[l_ac].inda005
      #      LET ls_sql = "SELECT oofb011 FROM oofb_t WHERE oofbent='"||g_enterprise||"' AND oofb001=? "
      #      LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #      CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #      LET g_inda_d[l_ac].inda005_desc = '', g_rtn_fields[1] , ''
      #      DISPLAY BY NAME g_inda_d[l_ac].inda005_desc
      #150826-00013# 20160307 mark by beckxie---E
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body2.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq500.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq500_filter()
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
      CONSTRUCT g_wc_filter ON indastus,indasite,indadocno,indadocdt,inda001,inda101,inda003,inda004, 
          inda002,inda005
                          FROM s_detail1[1].b_indastus,s_detail1[1].b_indasite,s_detail1[1].b_indadocno, 
                              s_detail1[1].b_indadocdt,s_detail1[1].b_inda001,s_detail1[1].b_inda101, 
                              s_detail1[1].b_inda003,s_detail1[1].b_inda004,s_detail1[1].b_inda002,s_detail1[1].b_inda005 
 
 
         BEFORE CONSTRUCT
                     DISPLAY ainq500_filter_parser('indastus') TO s_detail1[1].b_indastus
            DISPLAY ainq500_filter_parser('indasite') TO s_detail1[1].b_indasite
            DISPLAY ainq500_filter_parser('indadocno') TO s_detail1[1].b_indadocno
            DISPLAY ainq500_filter_parser('indadocdt') TO s_detail1[1].b_indadocdt
            DISPLAY ainq500_filter_parser('inda001') TO s_detail1[1].b_inda001
            DISPLAY ainq500_filter_parser('inda101') TO s_detail1[1].b_inda101
            DISPLAY ainq500_filter_parser('inda003') TO s_detail1[1].b_inda003
            DISPLAY ainq500_filter_parser('inda004') TO s_detail1[1].b_inda004
            DISPLAY ainq500_filter_parser('inda002') TO s_detail1[1].b_inda002
            DISPLAY ainq500_filter_parser('inda005') TO s_detail1[1].b_inda005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_indastus>>----
         #Ctrlp:construct.c.filter.page1.b_indastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_indastus
            #add-point:ON ACTION controlp INFIELD b_indastus name="construct.c.filter.page1.b_indastus"
            
            #END add-point
 
 
         #----<<b_indasite>>----
         #Ctrlp:construct.c.page1.b_indasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_indasite
            #add-point:ON ACTION controlp INFIELD b_indasite name="construct.c.filter.page1.b_indasite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'indasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_indasite  #顯示到畫面上
            NEXT FIELD b_indasite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_indasite_desc>>----
         #----<<b_indadocno>>----
         #Ctrlp:construct.c.page1.b_indadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_indadocno
            #add-point:ON ACTION controlp INFIELD b_indadocno name="construct.c.filter.page1.b_indadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_indadocno  #顯示到畫面上
            NEXT FIELD b_indadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_indadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_indadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_indadocdt
            #add-point:ON ACTION controlp INFIELD b_indadocdt name="construct.c.filter.page1.b_indadocdt"
            
            #END add-point
 
 
         #----<<b_inda001>>----
         #Ctrlp:construct.c.page1.b_inda001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda001
            #add-point:ON ACTION controlp INFIELD b_inda001 name="construct.c.filter.page1.b_inda001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inda001  #顯示到畫面上
            NEXT FIELD b_inda001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inda001_desc>>----
         #----<<b_inda101>>----
         #Ctrlp:construct.c.page1.b_inda101
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda101
            #add-point:ON ACTION controlp INFIELD b_inda101 name="construct.c.filter.page1.b_inda101"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_inda101  #顯示到畫面上
            NEXT FIELD b_inda101                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inda101_desc>>----
         #----<<b_inda003>>----
         #Ctrlp:construct.c.page1.b_inda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda003
            #add-point:ON ACTION controlp INFIELD b_inda003 name="construct.c.filter.page1.b_inda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'inda003') THEN
               #aooi500中有設定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda003',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               #aooi500中未設定按原邏輯
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_inda003  #顯示到畫面上
            NEXT FIELD b_inda003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inda003_desc>>----
         #----<<b_inda004>>----
         #Ctrlp:construct.c.page1.b_inda004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda004
            #add-point:ON ACTION controlp INFIELD b_inda004 name="construct.c.filter.page1.b_inda004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'inda004') THEN
               #aooi500中有設定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda004',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               #aooi500中未設定按原邏輯
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_inda004  #顯示到畫面上
            NEXT FIELD b_inda004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inda004_desc>>----
         #----<<b_inda002>>----
         #Ctrlp:construct.c.page1.b_inda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda002
            #add-point:ON ACTION controlp INFIELD b_inda002 name="construct.c.filter.page1.b_inda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            IF s_aooi500_setpoint(g_prog,'inda002') THEN
               #aooi500中有設定
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'inda002',g_site,'c')
               CALL q_ooef001_24()
            ELSE
               #aooi500中未設定按原邏輯
			      LET g_qryparam.where = " ooef201 = 'Y' "
               CALL q_ooef001()
            END IF
            DISPLAY g_qryparam.return1 TO b_inda002  #顯示到畫面上
            NEXT FIELD b_inda002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_inda002_desc>>----
         #----<<b_inda005>>----
         #Ctrlp:construct.c.filter.page1.b_inda005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_inda005
            #add-point:ON ACTION controlp INFIELD b_inda005 name="construct.c.filter.page1.b_inda005"
            
            #END add-point
 
 
         #----<<b_inda005_desc>>----
 
 
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
 
      CALL ainq500_filter_show('indastus','b_indastus')
   CALL ainq500_filter_show('indasite','b_indasite')
   CALL ainq500_filter_show('indadocno','b_indadocno')
   CALL ainq500_filter_show('indadocdt','b_indadocdt')
   CALL ainq500_filter_show('inda001','b_inda001')
   CALL ainq500_filter_show('inda101','b_inda101')
   CALL ainq500_filter_show('inda003','b_inda003')
   CALL ainq500_filter_show('inda004','b_inda004')
   CALL ainq500_filter_show('inda002','b_inda002')
   CALL ainq500_filter_show('inda005','b_inda005')
   CALL ainq500_filter_show('indbseq','b_indbseq')
   CALL ainq500_filter_show('indb002','b_indb002')
   CALL ainq500_filter_show('indb001','b_indb001')
   CALL ainq500_filter_show('indb004','b_indb004')
   CALL ainq500_filter_show('indb005','b_indb005')
   CALL ainq500_filter_show('indb007','b_indb007')
   CALL ainq500_filter_show('indb008','b_indb008')
   CALL ainq500_filter_show('indb009','b_indb009')
   CALL ainq500_filter_show('indb010','b_indb010')
   CALL ainq500_filter_show('indb011','b_indb011')
   CALL ainq500_filter_show('indb012','b_indb012')
   CALL ainq500_filter_show('indb013','b_indb013')
 
 
   CALL ainq500_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq500.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq500_filter_parser(ps_field)
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
 
{<section id="ainq500.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq500_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="ainq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ainq500_detail_action_trans()
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
 
{<section id="ainq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ainq500_detail_index_setting()
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
            IF g_inda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_inda_d.getLength() AND g_inda_d.getLength() > 0
            LET g_detail_idx = g_inda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_inda_d.getLength() THEN
               LET g_detail_idx = g_inda_d.getLength()
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
 
{<section id="ainq500.mask_functions" >}
 &include "erp/ain/ainq500_mask.4gl"
 
{</section>}
 
{<section id="ainq500.other_function" readonly="Y" >}

 
{</section>}
 
