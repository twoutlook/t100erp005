#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq446.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-10-19 17:27:30), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000081
#+ Filename...: ainq446
#+ Description: 商品貨架到期狀況查詢作業
#+ Creator....: 06189(2015-02-05 21:58:48)
#+ Modifier...: 02159 -SD/PR- 00000
 
{</section>}
 
{<section id="ainq446.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#8   2016/10/19 by sakura 整批修改組織s
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
PRIVATE TYPE type_g_infg_d RECORD
       
       sel LIKE type_t.chr1, 
   infgsite LIKE infg_t.infgsite, 
   infgsite_desc LIKE type_t.chr500, 
   infgdocdt LIKE infg_t.infgdocdt, 
   infgdocno LIKE infg_t.infgdocno, 
   infhseq LIKE infh_t.infhseq, 
   infh001 LIKE infh_t.infh001, 
   infh001_desc LIKE type_t.chr500, 
   infh001_desc_1 LIKE type_t.chr500, 
   infh001_desc_1_desc LIKE type_t.chr500, 
   infh004 LIKE infh_t.infh004, 
   infh004_desc LIKE type_t.chr500, 
   infh005 LIKE infh_t.infh005, 
   infh005_desc LIKE type_t.chr10, 
   infh006 LIKE infh_t.infh006, 
   infh006_desc LIKE type_t.chr10, 
   infh007 LIKE infh_t.infh007, 
   infh008 LIKE infh_t.infh008, 
   infh008_desc LIKE type_t.chr10, 
   infh010 LIKE infh_t.infh010, 
   infh011 LIKE infh_t.infh011
       END RECORD
PRIVATE TYPE type_g_infg2_d RECORD
       infgsite LIKE infg_t.infgsite, 
   infgsite_2_desc LIKE type_t.chr500, 
   infgdocdt LIKE infg_t.infgdocdt, 
   infgdocno LIKE infg_t.infgdocno, 
   infhseq LIKE infh_t.infhseq, 
   infh001 LIKE infh_t.infh001, 
   infh001_2_desc LIKE type_t.chr500, 
   infh001_2_desc_1 LIKE type_t.chr500, 
   infh001_2_desc_1_desc LIKE type_t.chr500, 
   infh004 LIKE infh_t.infh004, 
   infh004_2_desc LIKE type_t.chr500, 
   infh005 LIKE infh_t.infh005, 
   infh005_2_desc LIKE type_t.chr10, 
   infh006 LIKE infh_t.infh006, 
   infh006_2_desc LIKE type_t.chr10, 
   infh007 LIKE infh_t.infh007, 
   infh008 LIKE infh_t.infh008, 
   infh008_2_desc LIKE type_t.chr10, 
   infh010 LIKE infh_t.infh010, 
   infh011 LIKE infh_t.infh011
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sel1               LIKE infl_t.infl011
DEFINE g_sel2               LIKE infl_t.infl011
DEFINE g_wc3                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc4                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc5                  STRING   
DEFINE g_wc6                  STRING
DEFINE g_infg_d_colour DYNAMIC ARRAY OF RECORD       
      sel STRING, 
   infgsite STRING, 
   infgsite_desc STRING, 
   infgdocdt STRING, 
   infgdocno STRING, 
   infhseq STRING, 
   infh001 STRING, 
   infh001_desc STRING, 
   infh001_desc_1 STRING, 
   infh001_desc_1_desc STRING, 
   infh004 STRING, 
   infh004_desc STRING, 
   infh005 STRING, 
   infh005_desc STRING, 
   infh006 STRING, 
   infh006_desc STRING, 
   infh007 STRING, 
   infh008 STRING, 
   infh008_desc STRING, 
   infh010 STRING, 
   infh011 STRING
       END RECORD
DEFINE g_detail_cnt1          LIKE type_t.num5  #单身2的笔数
#end add-point
 
#模組變數(Module Variables)
DEFINE g_infg_d            DYNAMIC ARRAY OF type_g_infg_d
DEFINE g_infg_d_t          type_g_infg_d
DEFINE g_infg2_d     DYNAMIC ARRAY OF type_g_infg2_d
DEFINE g_infg2_d_t   type_g_infg2_d
 
 
 
 
 
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
 
{<section id="ainq446.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#5  By geza 150309
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
   DECLARE ainq446_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ainq446_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq446_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq446 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq446_init()   
 
      #進入選單 Menu (="N")
      CALL ainq446_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq446
      
   END IF 
   
   CLOSE ainq446_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#5  By geza 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainq446.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq446_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5  # 150308-00001#5  By geza 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('oocq019','6753')
   CALL s_aooi500_create_temp() RETURNING l_success  #150308-00001#5  By geza 150309
   #end add-point
 
   CALL ainq446_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq446.default_search" >}
PRIVATE FUNCTION ainq446_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " infgdocno = '", g_argv[01], "' AND "
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
 
{<section id="ainq446.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq446_ui_dialog() 
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
   #160126-00002#1 160127 By pomelo mark(S)
   #CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
   #CALL cl_set_comp_visible("sel", FALSE)
   #160126-00002#1 160127 By pomelo mark(E)
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
   #CALL ainq446_query()   #160126-00002#1 160127 By pomelo mark
   #end add-point
 
   
   CALL ainq446_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_infg_d.clear()
         CALL g_infg2_d.clear()
 
 
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
 
         CALL ainq446_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #160126-00002#1 160127 By pomelo add(S)
         INPUT g_sel1,g_sel2 FROM sel1,sel2 ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT 
               DISPLAY g_sel1,g_sel2 TO sel1,sel2
            
            AFTER INPUT
         END INPUT
         #160126-00002#1 160127 By pomelo add(E)
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         #160126-00002#1 160127 By pomelo add(S)
         CONSTRUCT BY NAME g_wc2 ON infgsite,imaa009,infh001
         
            ON ACTION controlp INFIELD infgsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE                        
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'infgsite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO infgsite
               NEXT FIELD infgsite 
               
            ON ACTION controlp INFIELD infh001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE 
               CALL q_imaa001()
               DISPLAY g_qryparam.return1 TO infh001
               NEXT FIELD infh001
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		      	LET g_qryparam.reqry = FALSE 
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD imaa009 
         
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc3 ON oocq019
         
         END CONSTRUCT
         
         CONSTRUCT BY NAME g_wc4 ON infc002
         
            ON ACTION controlp INFIELD infc002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2116'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO infc002
               NEXT FIELD infc002
         END CONSTRUCT
      
         CONSTRUCT BY NAME g_wc ON infc001
            ON ACTION controlp INFIELD infc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_infc001()
               DISPLAY g_qryparam.return1 TO infc001
               NEXT FIELD infc001 
         END CONSTRUCT
         #160126-00002#1 160127 By pomelo add(E)
         #end add-point
     
         DISPLAY ARRAY g_infg_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL ainq446_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ainq446_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               CALL DIALOG.setCellAttributes(g_infg_d_colour)    #参数：屏幕变量,属性数组
               CALL DIALOG.setArrayAttributes("s_detail1",g_infg_d_colour)    #参数：屏幕变量,属性数组
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_infg2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               LET g_detail_cnt = g_infg2_d.getLength()
               DISPLAY g_detail_cnt TO FORMONLY.h_count
               
               DISPLAY g_detail_idx2 TO FORMONLY.h_index

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
            CALL ainq446_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
#            CALL DIALOG.setCellAttributes(g_infg_d_colour)    #参数：屏幕变量,属性数组
#            CALL DIALOG.setArrayAttributes("s_detail1",g_infg_d_colour)    #参数：屏幕变量,属性数组
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            #160126-00002#1 160127 By pomelo add(S)
            LET g_sel1 = ''
            LET g_sel2 = ''
            DISPLAY g_sel1,g_sel2 TO sel1,sel2
            CALL cl_set_act_visible("insert,query", FALSE)
            #160126-00002#1 160127 By pomelo add(E)
            #NEXT FIELD sel          #160126-00002#1 160127 By pomelo mark
            #end add-point
            NEXT FIELD infgsite
 
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
            CALL ainq446_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_infg_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_infg2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq446_b_fill()
 
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
            CALL ainq446_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ainq446_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ainq446_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ainq446_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_infg_d.getLength()
               LET g_infg_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_infg_d.getLength()
               LET g_infg_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_infg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_infg_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_infg_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_infg_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq446_filter()
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
               CALL ainq446_query()
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
 
{<section id="ainq446.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq446_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE ls_wc1           STRING
   DEFINE ls_wc2           STRING
   DEFINE ls_wc3           STRING
   DEFINE ls_wc4           STRING
   DEFINE l_where           STRING
   DEFINE l_str           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF cl_null(g_wc) OR g_wc=" 1=1"THEN
      LET g_wc = " 1=1"
      LET ls_wc1 =" 1=1"
      LET ls_wc2 =" 1=1"
      LET ls_wc3 =" 1=1"
      LET ls_wc4 =" 1=1"
      LET g_wc5  =" 1=1"
   ELSE    
      LET ls_wc1 = cl_replace_str(g_wc,'infc001','infh005')
      LET ls_wc2 = cl_replace_str(g_wc,'infc001','infh006')
      LET ls_wc3 = cl_replace_str(g_wc,'infc001','infh008')
      LET ls_wc4 = " ( " ,ls_wc3," OR ",ls_wc2," OR ",ls_wc1 ," ) "
      
      LET g_wc5 = ls_wc4
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
 
   CALL g_infg_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_infg_d_colour.clear()
   CALL s_aooi500_sql_where(g_prog,'infgsite') RETURNING l_where
   LET g_wc2 = g_wc2," AND ",l_where
   LET g_wc2 = g_wc2.trim() 
   IF NOT cl_null(g_sel1) THEN 
      LET l_str = " AND infh007 >=  to_date('",g_sel1 ,"','yy_mm_dd')"
   END IF 
   IF NOT cl_null(g_sel2) THEN 
      IF cl_null(l_str) THEN 
         LET l_str = " AND infh007 <= to_date('",g_sel2 ,"','yy_mm_dd')"
      ELSE
         LET l_str = l_str," AND infh007 <= to_date('",g_sel2 ,"','yy_mm_dd')"
      END IF 
   END IF 

   LET ls_wc =  g_wc2, " AND ", g_wc_filter,l_str
   LET  g_wc6=ls_wc
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',infgsite,'',infgdocdt,infgdocno,'','','','','','','','','','', 
       '','','','','',''  ,DENSE_RANK() OVER( ORDER BY infg_t.infgdocno) AS RANK FROM infg_t",
 
#table2
                     " LEFT JOIN infh_t ON infhent = infgent AND infgdocno = infhdocno",
 
                     "",
                     " WHERE infgent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("infg_t"),
                     " ORDER BY infg_t.infgdocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150827 add by beckxie---S
   LET ls_sql_rank = "SELECT UNIQUE '',",
                     "       infgsite,",
                     "       (SELECT ooefl003",
                     "          FROM ooefl_t",
                     "         WHERE ooeflent = infgent AND ooefl001 = infgsite AND ooefl002 ='",g_dlang,"') ooefl003,",  
                     "       infgdocdt,  infgdocno,   infhseq, ",
                     "       infh001,",
                     "       (SELECT imaal003",
                     "          FROM imaa_t",
                     "               LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' ",
                     "         WHERE imaaent = infhent AND imaa001 = infh001) imaal003,",
                     "       (SELECT imaa009",
                     "          FROM imaa_t",
                     "         WHERE imaaent = infhent AND imaa001 = infh001) imaa009,",
                     "       (SELECT rtaxl003 ",
                     "          FROM imaa_t ",
                     "               LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                     "         WHERE imaaent = infhent AND imaa001 = infh001) rtaxl003,",
                     "       infh004,",
                     "       (SELECT oocal003",
                     "          FROM oocal_t",
                     "         WHERE oocalent = infhent AND oocal001 = infh004  AND oocal002 = '",g_dlang,"') oocal003,", 
                     "       infh005,",
                     "       (SELECT infc002",
                     "          FROM infc_t",
                     "         WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh005) infh005_desc, ",
                     "       infh006,",
                     "       (SELECT infc002",
                     "          FROM infc_t",
                     "         WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh006) infh006_desc, ",
                     "       infh007,infh008,",
                     "       (SELECT infc002",
                     "          FROM infc_t",
                     "         WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh008) infh008_desc, ",
                     "       infh010,infh011, ",
                     "       DENSE_RANK() OVER( ORDER BY infg_t.infgdocno) AS RANK",
                     "  FROM infg_t, infh_t",
                     " WHERE infgent= ? ",
                     "   AND infgent = infhent ",
                     "   AND infgdocno = infhdocno",
                     "   AND infgstus = 'Y' ",
                     "   AND infh009 = '1' ",
                     "   AND ",ls_wc,
                     "   AND ",ls_wc4,
                     "   AND EXISTS (SELECT 1 FROM infc_t ",
                     "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
                     "                WHERE infcent = infhent AND infcsite = infhsite ",
                     "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
                     "                  AND ",g_wc3,
                     "                  AND ",g_wc4,") "
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("infg_t"),
                     " ORDER BY infg_t.infgdocno"
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
 
   LET g_sql = "SELECT '',infgsite,'',infgdocdt,infgdocno,'','','','','','','','','','','','','','', 
       '',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)
   #LET g_sql = "SELECT  UNIQUE '',infgsite,'',infgdocdt,infgdocno,infhseq,infh001,
   #             '','','',infh004,'',infh005,'',infh006,'',infh007,infh008,'',
   #              infh010,infh011   FROM infg_t,infh_t",
   #
   #
   #            " LEFT JOIN imaa_t ON infhent = imaaent AND imaa001 = infh001 ",
   #
   #            "",
   #            " WHERE infgent= ? AND infgent = infhent  AND ",
   #            " infgdocno = infhdocno AND ", ls_wc," AND ",ls_wc4,
   #            " AND infgstus = 'Y' ",
   #            " AND infh009 = '1' ",
   #            " AND (infh005 IN ( SELECT infc001 FROM  infc_t   ",
   #            "  LEFT OUTER JOIN oocq_t    ",
   #             "   ON oocqent = infcent    ",
   #             "  AND oocq001 = '2116'     ",
   #             "  AND oocq002 = infc002  WHERE   ",g_wc3," AND  ",g_wc4,")",
   #             " OR infh006 IN ( SELECT infc001 FROM  infc_t   ",
   #            "  LEFT OUTER JOIN oocq_t    ",
   #             "   ON oocqent = infcent    ",
   #             "  AND oocq001 = '2116'     ",
   #             "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4," )",
   #            "   OR infh008 IN ( SELECT infc001 FROM  infc_t   ",
   #            " LEFT OUTER JOIN oocq_t    ",
   #             "   ON oocqent = infcent    ",
   #             "  AND oocq001 = '2116'     ",
   #             "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4," ))   "
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)
#   #150826-00013#1 效能調整 20150827 mark by beckxie---S
#   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
#   LET g_sql = "SELECT UNIQUE '', ",
#               "              infgsite,    t1.ooefl003, infgdocdt,  infgdocno,   infhseq, ",
#               "              infh001,     t2.imaal003, t2.imaa009, t2.rtaxl003, infh004, ",
#               "              t3.oocal003, infh005,     t4.infc002, infh006,     t5.infc002, ",
#               "              infh007,     infh008,     t6.infc002, infh010,     infh011 ",
#               "  FROM infg_t ",
#               "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = infgent AND t1.ooefl001 = infgsite AND t1.ooefl002 ='",g_dlang,"' ",               
#               "      ,infh_t",
#               "       LEFT JOIN (SELECT imaaent,imaa001,imaa009,imaal003,rtaxl003 ",
#               "                    FROM imaa_t ",
#               "                         LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' ",
#               "                         LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') t2 ",
#               "              ON t2.imaaent = infhent AND t2.imaa001 = infh001 ",
#               "       LEFT JOIN oocal_t t3 ON t3.oocalent = infhent AND t3.oocal001 = infh004  AND t3.oocal002 = '",g_dlang,"' ", 
#               "       LEFT JOIN infc_t  t4 ON t4.infcent  = infhent AND t4.infcsite = infhsite AND t4.infc001 = infh005 ",
#               "       LEFT JOIN infc_t  t5 ON t5.infcent  = infhent AND t5.infcsite = infhsite AND t5.infc001 = infh006 ",
#               "       LEFT JOIN infc_t  t6 ON t6.infcent  = infhent AND t6.infcsite = infhsite AND t6.infc001 = infh008 ",
#               " WHERE infgent= ? ",
#               "   AND infgent = infhent ",
#               "   AND infgdocno = infhdocno",
#               "   AND infgstus = 'Y' ",
#               "   AND infh009 = '1' ",
#               "   AND ",ls_wc,
#               "   AND ",ls_wc4,
#               "   AND EXISTS (SELECT 1 FROM infc_t ",
#               "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
#               "                WHERE infcent = infhent AND infcsite = infhsite ",
#               "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
#               "                  AND ",g_wc3,
#               "                  AND ",g_wc4,") "
#     #150302-00004#8 150312 by lori522612 add 效能調整---(E)
#   LET g_sql = g_sql, cl_sql_add_filter("infg_t"),
#                      " ORDER BY infg_t.infgdocno"
#     #150826-00013#1 效能調整 20150827 mark by beckxie---E
#  #150826-00013#1 效能調整 20150827 add by beckxie---S
   LET g_sql = "SELECT UNIQUE '', ",
               "              infgsite,    ",
               "              ooefl003,",  
               "              infgdocdt,  infgdocno,   infhseq, ",
               "              infh001,     ",
               "              imaal003,",
               "              imaa009,",
               "              rtaxl003,",
               "              infh004, ",
               "              oocal003,", 
               "              infh005,     ",
               "              infh005_desc, ",
               "              infh006,",
               "              infh006_desc, ",
               "              infh007,     infh008,",
               "              infh008_desc, ",
               "              infh010,     infh011 ",
               "  FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               "   AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150827 add by beckxie---E
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq446_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq446_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_infg_d[l_ac].sel,g_infg_d[l_ac].infgsite,g_infg_d[l_ac].infgsite_desc, 
       g_infg_d[l_ac].infgdocdt,g_infg_d[l_ac].infgdocno,g_infg_d[l_ac].infhseq,g_infg_d[l_ac].infh001, 
       g_infg_d[l_ac].infh001_desc,g_infg_d[l_ac].infh001_desc_1,g_infg_d[l_ac].infh001_desc_1_desc, 
       g_infg_d[l_ac].infh004,g_infg_d[l_ac].infh004_desc,g_infg_d[l_ac].infh005,g_infg_d[l_ac].infh005_desc, 
       g_infg_d[l_ac].infh006,g_infg_d[l_ac].infh006_desc,g_infg_d[l_ac].infh007,g_infg_d[l_ac].infh008, 
       g_infg_d[l_ac].infh008_desc,g_infg_d[l_ac].infh010,g_infg_d[l_ac].infh011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      IF g_infg_d[l_ac].infh007 < g_today THEN
         LET g_infg_d_colour[l_ac].sel = "red reverse"
         LET g_infg_d_colour[l_ac].infgsite = "red reverse"
         LET g_infg_d_colour[l_ac].infgsite_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infgdocdt  = "red reverse"
         LET g_infg_d_colour[l_ac].infgdocno  = "red reverse"
         LET g_infg_d_colour[l_ac].infhseq  = "red reverse"
         LET g_infg_d_colour[l_ac].infh001  = "red reverse"
         LET g_infg_d_colour[l_ac].infh001_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh001_desc_1  = "red reverse"
         LET g_infg_d_colour[l_ac].infh001_desc_1_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh004  = "red reverse"
         LET g_infg_d_colour[l_ac].infh004_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh005  = "red reverse"
         LET g_infg_d_colour[l_ac].infh005_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh006  = "red reverse"
         LET g_infg_d_colour[l_ac].infh006_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh007  = "red reverse"
         LET g_infg_d_colour[l_ac].infh008  = "red reverse"
         LET g_infg_d_colour[l_ac].infh008_desc  = "red reverse"
         LET g_infg_d_colour[l_ac].infh010  = "red reverse"
         LET g_infg_d_colour[l_ac].infh011  = "red reverse"
      END IF
      #end add-point
 
      CALL ainq446_detail_show("'1'")
 
      CALL ainq446_infg_t_mask()
 
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
   CALL ainq446_b_fill_2()
   #end add-point
 
   CALL g_infg_d.deleteElement(g_infg_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_infg_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq446_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ainq446_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ainq446_detail_action_trans()
 
   LET l_ac = 1
   IF g_infg_d.getLength() > 0 THEN
      CALL ainq446_b_fill2()
   END IF
 
      CALL ainq446_filter_show('infgsite','b_infgsite')
   CALL ainq446_filter_show('infgdocdt','b_infgdocdt')
   CALL ainq446_filter_show('infgdocno','b_infgdocno')
   CALL ainq446_filter_show('infhseq','b_infhseq')
   CALL ainq446_filter_show('infh001','b_infh001')
   CALL ainq446_filter_show('infh004','b_infh004')
   CALL ainq446_filter_show('infh005','b_infh005')
   CALL ainq446_filter_show('infh006','b_infh006')
   CALL ainq446_filter_show('infh007','b_infh007')
   CALL ainq446_filter_show('infh008','b_infh008')
   CALL ainq446_filter_show('infh010','b_infh010')
   CALL ainq446_filter_show('infh011','b_infh011')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq446.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq446_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   #RETURN   #151104-00002#1 20151117 mark by beckxie
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   RETURN    #151104-00002#1 20151117  add by beckxie
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_infg2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','','' FROM infh_t", 
 
                  "",
                  " WHERE infhent=? AND infhdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY infh_t.infhseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      #150302-00004#8 150312 by lori522612 mark 效能調整---(S)
      #LET g_sql = "SELECT  UNIQUE infgsite,'',infgdocdt,infgdocno,infhseq,infh001,
      #          '','','',infh004,'',infh005,'',infh006,'',infh007,infh008,'',
      #           infh010,infh011   FROM infg_t,infh_t",
      #
      #
      #         " LEFT JOIN imaa_t ON infhent = imaaent AND imaa001 = infh001 ",
      #
      #         "",
      #         " WHERE infgent= ? AND infgent = infhent  AND ",
      #         " infgdocno = infhdocno AND ", g_wc6," AND ",g_wc5,
      #         " AND infh009 = '2' ",
      #         " AND (infh005 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4,")",
      #          " OR infh006 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4," )",
      #         "   OR infh008 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND ",g_wc4," ))   "
      #150302-00004#8 150312 by lori522612 mark 效能調整---(E)
#      #150826-00013#1 效能調整 20150827 mark by beckxie---S
#      #150302-00004#8 150312 by lori522612 add 效能調整---(S) 
#      LET g_sql = "SELECT UNIQUE infgsite,    t1.ooefl003, infgdocdt,  infgdocno,   infhseq, ",
#                  "              infh001,     t2.imaal003, t2.imaa009, t2.rtaxl003, infh004, ",
#                  "              t3.oocal003, infh005,     t4.infc002, infh006,     t5.infc002, ",
#                  "              infh007,     infh008,     t6.infc002, infh010,     infh011 ",
#                  "  FROM infg_t ",
#                  "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = infgent AND t1.ooefl001 = infgsite AND t1.ooefl002 ='",g_dlang,"' ",               
#                  "      ,infh_t",
#                  "       LEFT JOIN (SELECT imaaent,imaa001,imaa009,imaal003,rtaxl003 ",
#                  "                    FROM imaa_t ",
#                  "                         LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' ",
#                  "                         LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') t2 ",
#                  "              ON t2.imaaent = infhent AND t2.imaa001 = infh001 ",
#                  "       LEFT JOIN oocal_t t3 ON t3.oocalent = infhent AND t3.oocal001 = infh004  AND t3.oocal002 = '",g_dlang,"' ", 
#                  "       LEFT JOIN infc_t  t4 ON t4.infcent  = infhent AND t4.infcsite = infhsite AND t4.infc001 = infh005 ",
#                  "       LEFT JOIN infc_t  t5 ON t5.infcent  = infhent AND t5.infcsite = infhsite AND t5.infc001 = infh006 ",
#                  "       LEFT JOIN infc_t  t6 ON t6.infcent  = infhent AND t6.infcsite = infhsite AND t6.infc001 = infh008 ",
#                  " WHERE infgent= ? ",
#                  "   AND infgent = infhent ",
#                  "   AND infgdocno = infhdocno",
#                  "   AND infgstus = 'Y' ",
#                  "   AND infh009 = '2' ",
#                  "   AND ",g_wc6,
#                  "   AND ",g_wc5,
#                  "   AND EXISTS (SELECT 1 FROM infc_t ",
#                  "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
#                  "                WHERE infcent = infhent AND infcsite = infhsite ",
#                  "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
#                  "                  AND ",g_wc3,
#                  "                  AND ",g_wc4,") "                
#      #150302-00004#8 150312 by lori522612 add 效能調整---(E)      
#      #150826-00013#1 效能調整 20150827 mark by beckxie---E
      #150826-00013#1 效能調整 20150827 add by beckxie---S
      LET g_sql = "SELECT UNIQUE infgsite,",
                  "              (SELECT ooefl003",
                  "                 FROM ooefl_t",
                  "                WHERE ooeflent = infgent AND ooefl001 = infgsite AND ooefl002 ='",g_dlang,"') ooefl003, ",
                  "              infgdocdt,  infgdocno,   infhseq, ",
                  "              infh001,",
                  "              (SELECT imaal003",
                  "                 FROM imaa_t",
                  "                      LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' ",
                  "                WHERE imaaent = infhent AND imaa001 = infh001) imaal003 ,",
                  "              (SELECT imaa009",
                  "                 FROM imaa_t",
                  "                WHERE imaaent = infhent AND imaa001 = infh001) imaa009 ,",
                  "              (SELECT rtaxl003",
                  "                 FROM imaa_t",
                  "                      LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ",
                  "                WHERE imaaent = infhent AND imaa001 = infh001) rtaxl003 ,",
                  "              infh004,",
                  "              (SELECT oocal003",
                  "                 FROM oocal_t",
                  "                WHERE oocalent = infhent AND oocal001 = infh004  AND oocal002 = '",g_dlang,"') oocal003,", 
                  "              infh005,",
                  "              (SELECT infc002",
                  "                 FROM infc_t",
                  "                WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh005) infh005_desc, ",
                  "               infh006,",
                  "              (SELECT infc002",
                  "                 FROM infc_t",
                  "                WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh006) infh006_desc, ",
                  "              infh007,infh008,",
                  "               (SELECT infc002",
                  "                 FROM infc_t",
                  "                WHERE infcent  = infhent AND infcsite = infhsite AND infc001 = infh008) infh008_desc, ",
                  "              infh010,infh011 ",
                  "  FROM infg_t,infh_t ",
                  " WHERE infgent= ? ",
                  "   AND infgent = infhent ",
                  "   AND infgdocno = infhdocno",
                  "   AND infgstus = 'Y' ",
                  "   AND infh009 = '2' ",
                  "   AND ",g_wc6,
                  "   AND ",g_wc5,
                  "   AND EXISTS (SELECT 1 FROM infc_t ",
                  "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
                  "                WHERE infcent = infhent AND infcsite = infhsite ",
                  "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
                  "                  AND ",g_wc3,
                  "                  AND ",g_wc4,") "          
      #150826-00013#1 效能調整 20150827 add by beckxie---E
      LET g_sql = g_sql, " ORDER BY infh_t.infhseq"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE ainq446_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR ainq446_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_infg_d[g_detail_idx].infgdocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_infg_d[g_detail_idx].infgdocno
 
      INTO g_infg2_d[l_ac].infgsite,g_infg2_d[l_ac].infgsite_2_desc,g_infg2_d[l_ac].infgdocdt,g_infg2_d[l_ac].infgdocno, 
          g_infg2_d[l_ac].infhseq,g_infg2_d[l_ac].infh001,g_infg2_d[l_ac].infh001_2_desc,g_infg2_d[l_ac].infh001_2_desc_1, 
          g_infg2_d[l_ac].infh001_2_desc_1_desc,g_infg2_d[l_ac].infh004,g_infg2_d[l_ac].infh004_2_desc, 
          g_infg2_d[l_ac].infh005,g_infg2_d[l_ac].infh005_2_desc,g_infg2_d[l_ac].infh006,g_infg2_d[l_ac].infh006_2_desc, 
          g_infg2_d[l_ac].infh007,g_infg2_d[l_ac].infh008,g_infg2_d[l_ac].infh008_2_desc,g_infg2_d[l_ac].infh010, 
          g_infg2_d[l_ac].infh011
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
 
      CALL ainq446_detail_show("'2'")
 
      CALL ainq446_infh_t_mask()
 
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
   CALL g_infg2_d.deleteElement(g_infg2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_infg2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="ainq446.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq446_detail_show(ps_page)
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
      #150302-00004#8 150312 by lori522612 mark---(S) 
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infgsite
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infgsite_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infgsite_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infh001
      #LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh001_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh001_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infh001_desc_1
      #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh001_desc_1_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh001_desc_1_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infh004
      #LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh004_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh004_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg_d[l_ac].infh005
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh005_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh005_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg_d[l_ac].infh006
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh006_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh006_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg_d[l_ac].infh008
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh008_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh008_desc
      # 
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infh001
      #LET ls_sql = "SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh001_desc_1 = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh001_desc_1
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg_d[l_ac].infh001_desc_1
      #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg_d[l_ac].infh001_desc_1_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg_d[l_ac].infh001_desc_1_desc
      #150302-00004#8 150312 by lori522612 mark---(E) 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      #150302-00004#8 150312 by lori522612 mark---(S)
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infgsite
      #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infgsite_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infgsite_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infh001
      #LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh001_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh001_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infh001_2_desc_1
      #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh001_2_desc_1_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh001_2_desc_1_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infh004
      #LET ls_sql = "SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND oocal002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh004_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh004_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg2_d[l_ac].infh005
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh005_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh005_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg2_d[l_ac].infh006
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh006_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh006_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infgsite
      #LET g_ref_fields[2] = g_infg2_d[l_ac].infh008
      #LET ls_sql = "SELECT infc002 FROM infc_t WHERE infcent='"||g_enterprise||"' AND infcsite=? AND infc001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh008_2_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh008_2_desc
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infh001
      #LET ls_sql = "SELECT imaa009 FROM imaa_t WHERE imaaent='"||g_enterprise||"' AND imaa001=? "
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh001_2_desc_1 = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh001_2_desc_1
      #
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_infg2_d[l_ac].infh001_2_desc_1
      #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_infg2_d[l_ac].infh001_2_desc_1_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_infg2_d[l_ac].infh001_2_desc_1_desc
      #150302-00004#8 150312 by lori522612 mark---(E)
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="ainq446.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq446_filter()
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
      CONSTRUCT g_wc_filter ON infgsite,infgdocdt,infgdocno,infhseq,infh001,infh004,infh005,infh006, 
          infh007,infh008,infh010,infh011
                          FROM s_detail1[1].b_infgsite,s_detail1[1].b_infgdocdt,s_detail1[1].b_infgdocno, 
                              s_detail1[1].b_infhseq,s_detail1[1].b_infh001,s_detail1[1].b_infh004,s_detail1[1].b_infh005, 
                              s_detail1[1].b_infh006,s_detail1[1].b_infh007,s_detail1[1].b_infh008,s_detail1[1].b_infh010, 
                              s_detail1[1].b_infh011
 
         BEFORE CONSTRUCT
                     DISPLAY ainq446_filter_parser('infgsite') TO s_detail1[1].b_infgsite
            DISPLAY ainq446_filter_parser('infgdocdt') TO s_detail1[1].b_infgdocdt
            DISPLAY ainq446_filter_parser('infgdocno') TO s_detail1[1].b_infgdocno
            DISPLAY ainq446_filter_parser('infhseq') TO s_detail1[1].b_infhseq
            DISPLAY ainq446_filter_parser('infh001') TO s_detail1[1].b_infh001
            DISPLAY ainq446_filter_parser('infh004') TO s_detail1[1].b_infh004
            DISPLAY ainq446_filter_parser('infh005') TO s_detail1[1].b_infh005
            DISPLAY ainq446_filter_parser('infh006') TO s_detail1[1].b_infh006
            DISPLAY ainq446_filter_parser('infh007') TO s_detail1[1].b_infh007
            DISPLAY ainq446_filter_parser('infh008') TO s_detail1[1].b_infh008
            DISPLAY ainq446_filter_parser('infh010') TO s_detail1[1].b_infh010
            DISPLAY ainq446_filter_parser('infh011') TO s_detail1[1].b_infh011
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_infgsite>>----
         #Ctrlp:construct.c.filter.page1.b_infgsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infgsite
            #add-point:ON ACTION controlp INFIELD b_infgsite name="construct.c.filter.page1.b_infgsite"
            #161006-00008#8 by sakura add(S)
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		      LET g_qryparam.reqry = FALSE                        
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infgsite',g_site,'c')
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO b_infgsite
            NEXT FIELD b_infgsite
            #161006-00008#8 by sakura add(E)
            #END add-point
 
 
         #----<<b_infgsite_desc>>----
         #----<<b_infgdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_infgdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infgdocdt
            #add-point:ON ACTION controlp INFIELD b_infgdocdt name="construct.c.filter.page1.b_infgdocdt"
            
            #END add-point
 
 
         #----<<b_infgdocno>>----
         #Ctrlp:construct.c.page1.b_infgdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infgdocno
            #add-point:ON ACTION controlp INFIELD b_infgdocno name="construct.c.filter.page1.b_infgdocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_infgdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_infgdocno  #顯示到畫面上
            NEXT FIELD b_infgdocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_infhseq>>----
         #Ctrlp:construct.c.filter.page1.b_infhseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infhseq
            #add-point:ON ACTION controlp INFIELD b_infhseq name="construct.c.filter.page1.b_infhseq"
            
            #END add-point
 
 
         #----<<b_infh001>>----
         #Ctrlp:construct.c.filter.page1.b_infh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh001
            #add-point:ON ACTION controlp INFIELD b_infh001 name="construct.c.filter.page1.b_infh001"
            
            #END add-point
 
 
         #----<<b_infh001_desc>>----
         #----<<b_infh001_desc_1>>----
         #----<<b_infh001_desc_1_desc>>----
         #----<<b_infh004>>----
         #Ctrlp:construct.c.filter.page1.b_infh004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh004
            #add-point:ON ACTION controlp INFIELD b_infh004 name="construct.c.filter.page1.b_infh004"
            
            #END add-point
 
 
         #----<<b_infh004_desc>>----
         #----<<b_infh005>>----
         #Ctrlp:construct.c.filter.page1.b_infh005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh005
            #add-point:ON ACTION controlp INFIELD b_infh005 name="construct.c.filter.page1.b_infh005"
            
            #END add-point
 
 
         #----<<b_infh005_desc>>----
         #----<<b_infh006>>----
         #Ctrlp:construct.c.filter.page1.b_infh006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh006
            #add-point:ON ACTION controlp INFIELD b_infh006 name="construct.c.filter.page1.b_infh006"
            
            #END add-point
 
 
         #----<<b_infh006_desc>>----
         #----<<b_infh007>>----
         #Ctrlp:construct.c.filter.page1.b_infh007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh007
            #add-point:ON ACTION controlp INFIELD b_infh007 name="construct.c.filter.page1.b_infh007"
            
            #END add-point
 
 
         #----<<b_infh008>>----
         #Ctrlp:construct.c.filter.page1.b_infh008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh008
            #add-point:ON ACTION controlp INFIELD b_infh008 name="construct.c.filter.page1.b_infh008"
            
            #END add-point
 
 
         #----<<b_infh008_desc>>----
         #----<<b_infh010>>----
         #Ctrlp:construct.c.filter.page1.b_infh010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh010
            #add-point:ON ACTION controlp INFIELD b_infh010 name="construct.c.filter.page1.b_infh010"
            
            #END add-point
 
 
         #----<<b_infh011>>----
         #Ctrlp:construct.c.filter.page1.b_infh011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_infh011
            #add-point:ON ACTION controlp INFIELD b_infh011 name="construct.c.filter.page1.b_infh011"
            
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
 
      CALL ainq446_filter_show('infgsite','b_infgsite')
   CALL ainq446_filter_show('infgdocdt','b_infgdocdt')
   CALL ainq446_filter_show('infgdocno','b_infgdocno')
   CALL ainq446_filter_show('infhseq','b_infhseq')
   CALL ainq446_filter_show('infh001','b_infh001')
   CALL ainq446_filter_show('infh004','b_infh004')
   CALL ainq446_filter_show('infh005','b_infh005')
   CALL ainq446_filter_show('infh006','b_infh006')
   CALL ainq446_filter_show('infh007','b_infh007')
   CALL ainq446_filter_show('infh008','b_infh008')
   CALL ainq446_filter_show('infh010','b_infh010')
   CALL ainq446_filter_show('infh011','b_infh011')
 
 
   CALL ainq446_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq446.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq446_filter_parser(ps_field)
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
 
{<section id="ainq446.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq446_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq446_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="ainq446.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ainq446_detail_action_trans()
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
 
{<section id="ainq446.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ainq446_detail_index_setting()
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
            IF g_infg_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_infg_d.getLength() AND g_infg_d.getLength() > 0
            LET g_detail_idx = g_infg_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_infg_d.getLength() THEN
               LET g_detail_idx = g_infg_d.getLength()
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
 
{<section id="ainq446.mask_functions" >}
 &include "erp/ain/ainq446_mask.4gl"
 
{</section>}
 
{<section id="ainq446.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查询方法
# Date & Author..: 2015/02/06 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq446_query()
DEFINE ls_wc      LIKE type_t.chr500
DEFINE ls_return  STRING
DEFINE ls_result  STRING 
   INITIALIZE g_sel1 TO NULL
   INITIALIZE g_sel2 TO NULL
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_infg_d.clear()
   CALL g_infg2_d.clear()
   LET g_qryparam.state = "c"
   
   #wc備份
   LET ls_wc = g_wc2
   CALL cl_set_act_visible("accept,cancel", TRUE)
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
       CONSTRUCT BY NAME g_wc2 ON infgsite,imaa009,infh001

         
         
         
         BEFORE FIELD infgsite
            #add-point:BEFORE FIELD inflsite
                                    
            #END add-point
         AFTER FIELD infgsite           
           #add-point:AFTER FIELD inflsite
                                   
           #END add-point
         ON ACTION controlp INFIELD infgsite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'infgsite',g_site,'c') #150308-00001#5  By geza add 'c'
            CALL q_ooef001_24()#呼叫開窗
            DISPLAY g_qryparam.return1 TO infgsite  #顯示到畫面上

            NEXT FIELD infgsite  
         
        

       
           
           
         BEFORE FIELD infh001
            #add-point:BEFORE FIELD infh001
                                    
            #END add-point
         AFTER FIELD infh001           
            #add-point:AFTER FIELD infh001
                                    
            #END add-point
         ON ACTION controlp INFIELD infh001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
           
            CALL q_imaa001()#呼叫開窗
            DISPLAY g_qryparam.return1 TO infh001  #顯示到畫面上

            NEXT FIELD infh001 
         
         BEFORE FIELD imaa009
            #add-point:BEFORE FIELD imaa009
                                    
            #END add-point
         AFTER FIELD imaa009           
            #add-point:AFTER FIELD imaa009
                                    
            #END add-point
         ON ACTION controlp INFIELD imaa009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
		   	LET g_qryparam.reqry = FALSE                        
           
            CALL q_rtax001()#呼叫開窗
            DISPLAY g_qryparam.return1 TO imaa009  #顯示到畫面上

            NEXT FIELD imaa009 
         
        BEFORE CONSTRUCT         
         
        AFTER CONSTRUCT
         
         
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc3 ON oocq019
      
         BEFORE FIELD oocq019
            #add-point:BEFORE FIELD oocq019
                                    
            #END add-point
         AFTER FIELD oocq019           
            #add-point:AFTER FIELD oocq019
                                    
            #END add-point
         ON ACTION controlp INFIELD oocq019
         
         BEFORE CONSTRUCT         
         
         AFTER CONSTRUCT
      END CONSTRUCT
      
      
      
      CONSTRUCT BY NAME g_wc4 ON infc002
      
         BEFORE FIELD infc002
            #add-point:BEFORE FIELD infc002
                                    
            #END add-point
         AFTER FIELD infc002           
           #add-point:AFTER FIELD infc002
                                   
           #END add-point
         ON ACTION controlp INFIELD infc002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = '2116'
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infc002  #顯示到畫面上
            NEXT FIELD infc002
      
      
         BEFORE CONSTRUCT         
         
         AFTER CONSTRUCT
      
      END CONSTRUCT
      
      CONSTRUCT BY NAME g_wc ON infc001

         BEFORE CONSTRUCT
         
          BEFORE FIELD infc001
            #add-point:BEFORE FIELD infc001
                                    
            #END add-point
         AFTER FIELD infc001          
            #add-point:AFTER FIELD infc001
                                    
            #END add-point
         ON ACTION controlp INFIELD infc001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_infc001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO infc001  #顯示到畫面上
            NEXT FIELD infc001 
         
         
         AFTER CONSTRUCT
         
      END CONSTRUCT   
     
       INPUT g_sel1,g_sel2
       FROM sel1,sel2
           ATTRIBUTE(WITHOUT DEFAULTS)
#       
          BEFORE INPUT 
             DISPLAY g_sel1,g_sel2
                  TO sel1,sel2
          
          AFTER INPUT
#      
       END INPUT

      
      
      


      BEFORE DIALOG 
    
         CALL cl_qbe_init()

      
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
      
      ON ACTION qbe_save
         CALL cl_qbe_save()
      
      ON ACTION accept
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
   END DIALOG
 

   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc2 = ls_wc
   END IF
    
   LET g_error_show = 1
   CALL ainq446_b_fill()
   IF g_detail_cnt = 0 AND g_detail_cnt1 = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -100
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()

   END IF
   CALL cl_set_act_visible("accept,cancel", FALSE)
   LET INT_FLAG = FALSE
END FUNCTION

################################################################################
# Descriptions...: 单身填充2
# Date & Author..: 2015/02/09 By geza
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq446_b_fill_2()
DEFINE li_ac           LIKE type_t.num5
   #add-point:b_fill2段define-標準

   #end add-point
   #add-point:b_fill2段define-客製

   #end add-point
 
   LET li_ac = l_ac
   LET g_detail_idx2 =1
   #單身組成
   #應用 qs07 樣板自動產生(Version:2)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_infg2_d.clear()
   
   #add-point:陣列清空

   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','',infhseq,infh001,'','','',infh004,'',infh005,'',infh006, 
          '',infh007,infh008,'',infh010,infh011 FROM infh_t",
                  "",
                  " WHERE infhent=? AND infhdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY infh_t.infhseq"
  
      #add-point:單身填充前
      #150302-00004#8 150312 by lori522612 mark 效能調整---(S)      
      #LET g_sql = "SELECT  UNIQUE infgsite,'',infgdocdt,infgdocno,infhseq,infh001,
      #          '','','',infh004,'',infh005,'',infh006,'',infh007,infh008,'',
      #           infh010,infh011   FROM infg_t,infh_t",
      #
      #
      #         " LEFT JOIN imaa_t ON infhent = imaaent AND imaa001 = infh001 ",
      #
      #         "",
      #         " WHERE infgent= ? AND infgent = infhent  AND ",
      #         " infgdocno = infhdocno AND ", g_wc6," AND ",g_wc5,
      #         " AND infgstus = 'Y' ",
      #         " AND infh009 = '2' ",
      #         " AND (infh005 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4,")",
      #          " OR infh006 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND  ",g_wc4," )",
      #         "   OR infh008 IN ( SELECT infc001 FROM  infc_t   ",
      #         "  LEFT OUTER JOIN oocq_t    ",
      #          "   ON oocqent = infcent    ",
      #          "  AND oocq001 = '2116'     ",
      #          "  AND oocq002 = infc002  WHERE  ",g_wc3," AND ",g_wc4," ))   "
      #150302-00004#8 150312 by lori522612 mark 效能調整---(S)    
      
      #150302-00004#8 150312 by lori522612 add 效能調整---(S) 
      #150826-00013# 20160308 mark by beckxie---S
      #LET g_sql = "SELECT UNIQUE infgsite,    t1.ooefl003, infgdocdt,  infgdocno,   infhseq, ",
      #            "              infh001,     t2.imaal003, t2.imaa009, t2.rtaxl003, infh004, ",
      #            "              t3.oocal003, infh005,     t4.infc002, infh006,     t5.infc002, ",
      #            "              infh007,     infh008,     t6.infc002, infh010,     infh011 ",
      #            "  FROM infg_t ",
      #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = infgent AND t1.ooefl001 = infgsite AND t1.ooefl002 ='",g_dlang,"' ",               
      #            "      ,infh_t",
      #            "       LEFT JOIN (SELECT imaaent,imaa001,imaa009,imaal003,rtaxl003 ",
      #            "                    FROM imaa_t ",
      #            "                         LEFT JOIN imaal_t ON imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"' ",
      #            "                         LEFT JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') t2 ",
      #            "              ON t2.imaaent = infhent AND t2.imaa001 = infh001 ",
      #            "       LEFT JOIN oocal_t t3 ON t3.oocalent = infhent AND t3.oocal001 = infh004  AND t3.oocal002 = '",g_dlang,"' ", 
      #            "       LEFT JOIN infc_t  t4 ON t4.infcent  = infhent AND t4.infcsite = infhsite AND t4.infc001 = infh005 ",
      #            "       LEFT JOIN infc_t  t5 ON t5.infcent  = infhent AND t5.infcsite = infhsite AND t5.infc001 = infh006 ",
      #            "       LEFT JOIN infc_t  t6 ON t6.infcent  = infhent AND t6.infcsite = infhsite AND t6.infc001 = infh008 ",
      #            " WHERE infgent= ? ",
      #            "   AND infgent = infhent ",
      #            "   AND infgdocno = infhdocno",
      #            "   AND infgstus = 'Y' ",
      #            "   AND infh009 = '2' ",
      #            "   AND ",g_wc6,
      #            "   AND ",g_wc5,
      #            "   AND EXISTS (SELECT 1 FROM infc_t ",
      #            "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
      #            "                WHERE infcent = infhent AND infcsite = infhsite ",
      #            "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
      #            "                  AND ",g_wc3,
      #            "                  AND ",g_wc4,") "                
      #150826-00013# 20160308 mark by beckxie---E
      #150826-00013# 20160308 add by beckxie---S
      LET g_sql = "SELECT UNIQUE infgsite,    ",
                  "              (SELECT ooefl003 ",
                  "                 FROM ooefl_t ",
                  "                WHERE ooeflent = infgent AND ooefl001 = infgsite AND ooefl002 ='",g_dlang,"') , ", 
                  "              infgdocdt,   infgdocno,   infhseq, ",
                  "              infh001,",
                  "              (SELECT imaal003 ",
                  "                 FROM imaal_t ",
                  "                WHERE imaalent = imaaent AND imaal001 = imaa001 AND imaal002 = '",g_dlang,"'), ",
                  "              t2.imaa009, ",
                  "              (SELECT rtaxl003 ",
                  "                 FROM rtaxl_t ",
                  "                WHERE  rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"' ), ",
                  "              infh004, ",
                  "              (SELECT oocal003 ",
                  "                 FROM oocal_t ",
                  "                WHERE oocalent = infhent AND oocal001 = infh004  AND oocal002 = '",g_dlang,"'), ",
                  "              infh005,     t4.infc002, infh006,     t5.infc002, ",
                  "              infh007,     infh008,     t6.infc002, infh010,     infh011 ",
                  "  FROM infg_t ",          
                  "      ,infh_t",
                  "       LEFT JOIN (SELECT imaaent,imaa001,imaa009 ",
                  "                    FROM imaa_t) t2 ",
                  "              ON t2.imaaent = infhent AND t2.imaa001 = infh001 ",
                  "       LEFT JOIN infc_t  t4 ON t4.infcent  = infhent AND t4.infcsite = infhsite AND t4.infc001 = infh005 ",
                  "       LEFT JOIN infc_t  t5 ON t5.infcent  = infhent AND t5.infcsite = infhsite AND t5.infc001 = infh006 ",
                  "       LEFT JOIN infc_t  t6 ON t6.infcent  = infhent AND t6.infcsite = infhsite AND t6.infc001 = infh008 ",
                  " WHERE infgent= ? ",
                  "   AND infgent = infhent ",
                  "   AND infgdocno = infhdocno",
                  "   AND infgstus = 'Y' ",
                  "   AND infh009 = '2' ",
                  "   AND ",g_wc6,
                  "   AND ",g_wc5,
                  "   AND EXISTS (SELECT 1 FROM infc_t ",
                  "                             LEFT JOIN oocq_t ON oocqent = infcent AND oocq001 = '2116' AND oocq002 = infc002 ",
                  "                WHERE infcent = infhent AND infcsite = infhsite ",
                  "                  AND (infc001 = infh005 OR infc001 = infh006 OR infc001 = infh008) ",
                  "                  AND ",g_wc3,
                  "                  AND ",g_wc4,") "                
      #150826-00013# 20160308 add by beckxie---E
      #150302-00004#8 150312 by lori522612 add 效能調整---(E)     

      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY infg_t.infgdocno"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE ainq446_pb3 FROM g_sql
      DECLARE b_fill_curs3 CURSOR FOR ainq446_pb3
   END IF
 
   OPEN b_fill_curs3 USING g_enterprise
 
   LET l_ac = 1
   FOREACH b_fill_curs3 INTO g_infg2_d[l_ac].infgsite,g_infg2_d[l_ac].infgsite_2_desc,g_infg2_d[l_ac].infgdocdt, 
       g_infg2_d[l_ac].infgdocno,g_infg2_d[l_ac].infhseq,g_infg2_d[l_ac].infh001,g_infg2_d[l_ac].infh001_2_desc, 
       g_infg2_d[l_ac].infh001_2_desc_1,g_infg2_d[l_ac].infh001_2_desc_1_desc,g_infg2_d[l_ac].infh004, 
       g_infg2_d[l_ac].infh004_2_desc,g_infg2_d[l_ac].infh005,g_infg2_d[l_ac].infh005_2_desc,g_infg2_d[l_ac].infh006, 
       g_infg2_d[l_ac].infh006_2_desc,g_infg2_d[l_ac].infh007,g_infg2_d[l_ac].infh008,g_infg2_d[l_ac].infh008_2_desc, 
       g_infg2_d[l_ac].infh010,g_infg2_d[l_ac].infh011
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充

      #end add-point
 
      CALL ainq446_detail_show("'2'")
 
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
   CLOSE b_fill_curs3
   FREE ainq446_pb3
 
 
#Page2
   CALL g_infg2_d.deleteElement(g_infg2_d.getLength())
 
   #add-point:陣列長度調整

   #end add-point
 
#Page2
   LET li_ac = g_infg2_d.getLength()
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
   LET g_detail_cnt1 = li_ac
 

 
 
   #add-point:單身填充後

   #end add-point
 
   LET l_ac = li_ac
END FUNCTION

 
{</section>}
 
