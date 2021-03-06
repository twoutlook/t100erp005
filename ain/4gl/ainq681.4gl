#該程式未解開Section, 採用最新樣板產出!
{<section id="ainq681.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-12-09 16:55:10), PR版次:0001(2016-03-02 17:22:33)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: ainq681
#+ Description: 商品進銷存查詢作業
#+ Creator....: 04226(2015-12-07 13:45:58)
#+ Modifier...: 04226 -SD/PR- 04226
 
{</section>}
 
{<section id="ainq681.global" >}
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
PRIVATE TYPE type_g_rtdx_d RECORD
       
       rtdxsite LIKE rtdx_t.rtdxsite, 
   rtdxsite_desc LIKE type_t.chr500, 
   rtdx002 LIKE rtdx_t.rtdx002, 
   rtdx001 LIKE rtdx_t.rtdx001, 
   rtdx001_desc LIKE type_t.chr500, 
   rtdx001_desc_desc LIKE type_t.chr500, 
   l_qry_b LIKE type_t.num20_6, 
   l_money_b LIKE type_t.num20_6, 
   l_pur_qry LIKE type_t.num20_6, 
   l_pur_money LIKE type_t.num20_6, 
   l_self_qry LIKE type_t.num20_6, 
   l_self_cost LIKE type_t.num20_6, 
   l_self_money LIKE type_t.num20_6, 
   l_pro_money LIKE type_t.num20_6, 
   l_pro_cost LIKE type_t.num20_6, 
   l_in_qry LIKE type_t.num20_6, 
   l_in_money LIKE type_t.num20_6, 
   l_return_qry LIKE type_t.num20_6, 
   l_return_money LIKE type_t.num20_6, 
   l_out_qry LIKE type_t.num20_6, 
   l_out_money LIKE type_t.num20_6, 
   l_rec_qry LIKE type_t.num20_6, 
   l_rec_money LIKE type_t.num20_6, 
   l_sale_qry LIKE type_t.num20_6, 
   l_sale_cost LIKE type_t.num20_6, 
   l_who_qry LIKE type_t.num20_6, 
   l_who_money LIKE type_t.num20_6, 
   l_inv_qry LIKE type_t.num20_6, 
   l_inv_money LIKE type_t.num20_6, 
   l_dam_qry LIKE type_t.num20_6, 
   l_dam_money LIKE type_t.num20_6, 
   l_tra_qry LIKE type_t.num20_6, 
   l_tra_money LIKE type_t.num20_6, 
   l_oth_qry LIKE type_t.num20_6, 
   l_oth_money LIKE type_t.num20_6, 
   l_bal_qry LIKE type_t.num20_6, 
   l_bal_money LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_g_rtdx2_d RECORD
   rtdxsite_d2              LIKE rtdx_t.rtdxsite, 
   rtdxsite_d2_desc         LIKE type_t.chr500,
   rtaw001                  LIKE rtaw_t.rtaw001, 
   rtaw001_desc             LIKE type_t.chr500,
   l_qry_b_d2               LIKE type_t.num20_6, 
   l_money_b_d2             LIKE type_t.num20_6, 
   l_pur_qry_d2             LIKE type_t.num20_6, 
   l_pur_money_d2           LIKE type_t.num20_6, 
   l_self_qry_d2            LIKE type_t.num20_6, 
   l_self_cost_d2           LIKE type_t.num20_6, 
   l_self_money_d2          LIKE type_t.num20_6, 
   l_pro_money_d2           LIKE type_t.num20_6, 
   l_pro_cost_d2            LIKE type_t.num20_6, 
   l_in_qry_d2              LIKE type_t.num20_6, 
   l_in_money_d2            LIKE type_t.num20_6, 
   l_return_qry_d2          LIKE type_t.num20_6, 
   l_return_money_d2        LIKE type_t.num20_6, 
   l_out_qry_d2             LIKE type_t.num20_6, 
   l_out_money_d2           LIKE type_t.num20_6, 
   l_rec_qry_d2             LIKE type_t.num20_6, 
   l_rec_money_d2           LIKE type_t.num20_6, 
   l_sale_qry_d2            LIKE type_t.num20_6, 
   l_sale_cost_d2           LIKE type_t.num20_6, 
   l_who_qry_d2             LIKE type_t.num20_6, 
   l_who_money_d2           LIKE type_t.num20_6, 
   l_inv_qry_d2             LIKE type_t.num20_6, 
   l_inv_money_d2           LIKE type_t.num20_6, 
   l_dam_qry_d2             LIKE type_t.num20_6, 
   l_dam_money_d2           LIKE type_t.num20_6, 
   l_tra_qry_d2             LIKE type_t.num20_6, 
   l_tra_money_d2           LIKE type_t.num20_6, 
   l_oth_qry_d2             LIKE type_t.num20_6, 
   l_oth_money_d2           LIKE type_t.num20_6, 
   l_bal_qry_d2             LIKE type_t.num20_6, 
   l_bal_money_d2           LIKE type_t.num20_6
                            END RECORD
DEFINE g_rtdx2_d            DYNAMIC ARRAY OF type_g_rtdx2_d
DEFINE g_rtdx2_d_t          type_g_rtdx2_d
DEFINE g_sdate              LIKE type_t.dat
DEFINE g_edate              LIKE type_t.dat
DEFINE g_rtdxsite           STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtdx_d            DYNAMIC ARRAY OF type_g_rtdx_d
DEFINE g_rtdx_d_t          type_g_rtdx_d
 
 
 
 
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
 
{<section id="ainq681.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success       LIKE type_t.num5
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
   DECLARE ainq681_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE ainq681_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE ainq681_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_ainq681 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL ainq681_init()   
 
      #進入選單 Menu (="N")
      CALL ainq681_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_ainq681
      
   END IF 
   
   CLOSE ainq681_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="ainq681.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION ainq681_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success       LIKE type_t.num5
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
   LET l_success = ''
   CALL ainq681_create_tmp() RETURNING l_success
   #end add-point
 
   CALL ainq681_default_search()
END FUNCTION
 
{</section>}
 
{<section id="ainq681.default_search" >}
PRIVATE FUNCTION ainq681_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtdxsite = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " rtdx001 = '", g_argv[02], "' AND "
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
 
{<section id="ainq681.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainq681_ui_dialog() 
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
 
   
   CALL ainq681_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtdx_d.clear()
 
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
 
         CALL ainq681_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_sdate,g_edate FROM l_sdate,l_edate
         
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtdxsite,rtaw001,rtdx001,imaa009,imaa126
            ON ACTION controlp INFIELD rtdxsite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtdxsite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtdxsite
               NEXT FIELD CURRENT
            
            ON ACTION controlp INFIELD rtaw001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " rtax004 = ",cl_get_para(g_enterprise,"","E-CIR-0001")
               CALL q_rtax001()
               DISPLAY g_qryparam.return1 TO rtaw001
               NEXT FIELD CURRENT
            
            ON ACTION controlp INFIELD rtdx001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()
               DISPLAY g_qryparam.return1 TO rtdx001
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD imaa009
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_rtax001_1()
               DISPLAY g_qryparam.return1 TO imaa009
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD imaa126
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '2002'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO imaa126
               NEXT FIELD CURRENT
               
            AFTER FIELD rtdxsite
                CALL FGL_DIALOG_GETBUFFER() RETURNING g_rtdxsite
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_rtdx_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL ainq681_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL ainq681_b_fill2()
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
         DISPLAY ARRAY g_rtdx2_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
            
            BEFORE DISPLAY
               LET g_current_page = 2
         
         END DISPLAY
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL ainq681_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_sdate) THEN
               LET g_sdate = g_today
            END IF
            IF cl_null(g_edate) THEN
               LET g_edate = g_today
            END IF
            DISPLAY g_sdate,g_edate
            #end add-point
            NEXT FIELD rtdxsite
 
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
            CALL ainq681_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtdx_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL ainq681_b_fill()
 
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
            CALL ainq681_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL ainq681_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL ainq681_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL ainq681_b_fill()
 
         
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL ainq681_filter()
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
 
{<section id="ainq681.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION ainq681_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'rtdxsite') RETURNING l_where
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
 
   CALL g_rtdx_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
  
   CALL ainq681_ins_tmp(ls_wc,l_where)
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE rtdxsite,'',rtdx002,rtdx001,'','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY rtdx_t.rtdxsite, 
       rtdx_t.rtdx001) AS RANK FROM rtdx_t",
 
 
                     "",
                     " WHERE rtdxent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtdx_t"),
                     " ORDER BY rtdx_t.rtdxsite,rtdx_t.rtdx001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_sql_rank = "SELECT b.rtdxent rtdxent,           b.rtdxsite rtdxsite,             a.rtdx002 rtdx002,",
                     "       b.rtdx001 rtdx001,           b.l_qry_b l_qry_b,               b.l_money_b l_money_b,",
                     "       a.l_pur_qry l_pur_qry,       a.l_pur_money l_pur_money,       b.l_self_qry l_self_qry,",
                     "       b.l_self_cost l_self_cost,   b.l_self_money l_self_money,     b.l_pro_money l_pro_money,",
                     "       b.l_pro_cost l_pro_cost,     a.l_in_qry l_in_qry,             a.l_in_money l_in_money,",
                     "       a.l_return_qry l_return_qry, a.l_return_money l_return_money, a.l_out_qry l_out_qry,",
                     "       a.l_out_money l_out_money,   a.l_rec_qry l_rec_qry,           a.l_rec_money l_rec_money,",
                     "       b.l_sale_qry l_sale_qry,     b.l_sale_cost l_sale_cost,       b.l_who_qry l_who_qry,",
                     "       b.l_who_money l_who_money,   a.l_inv_qry l_inv_qry,           a.l_inv_money l_inv_money,",
                     "       a.l_dam_qry l_dam_qry,       a.l_dam_money l_dam_money,       a.l_tra_qry l_tra_qry,",
                     "       a.l_tra_money l_tra_money,   b.l_oth_qry l_oth_qry,           b.l_oth_money l_oth_money,",
                     "       b.l_bal_qry l_bal_qry,       b.l_bal_money l_bal_money,",
                     "       DENSE_RANK() OVER( ORDER BY b.rtdxsite,b.rtdx001) AS RANK",
                     "  FROM ainq681_deba b",
                     "  LEFT OUTER JOIN ainq681_tmp a ON a.rtdxent = b.rtdxent",
                     "                               AND a.rtdxsite= b.rtdxsite",
                     "                               AND a.rtdx001 = b.rtdx001",
                     " WHERE b.rtdxent = ?",
                     " ORDER BY b.rtdxsite,b.rtdx001"
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
 
   LET g_sql = "SELECT rtdxsite,'',rtdx002,rtdx001,'','','','','','','','','','','','','','','','','', 
       '','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql = "SELECT rtdxsite, (SELECT ooefl003 FROM ooefl_t",
               "                   WHERE ooeflent = rtdxent",
               "                     AND ooefl001 = rtdxsite",
               "                     AND ooefl002 = '",g_dlang,"'),",
               "       rtdx002, rtdx001, imaal003, imaal004,",
               "       l_qry_b,        l_money_b,   l_pur_qry,    l_pur_money,",
               "       l_self_qry,     l_self_cost, l_self_money, l_pro_money,",
               "       l_pro_cost,     l_in_qry,    l_in_money,   l_return_qry,",
               "       l_return_money, l_out_qry,   l_out_money,  l_rec_qry,",
               "       l_rec_money,    l_sale_qry,  l_sale_cost,  l_who_qry,",
               "       l_who_money,    l_inv_qry,   l_inv_money,  l_dam_qry,",
               "       l_dam_money,    l_tra_qry,   l_tra_money,  l_oth_qry,",
               "       l_oth_money,    l_bal_qry,   l_bal_money",
               "  FROM (",ls_sql_rank,")",
               "  LEFT OUTER JOIN imaal_t ON imaalent = rtdxent",
               "                         AND imaal001 = rtdx001",
               "                         AND imaal002 = '",g_dlang,"'",
               " WHERE RANK >= ",g_pagestart,
               " AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE ainq681_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR ainq681_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtdx_d[l_ac].rtdxsite,g_rtdx_d[l_ac].rtdxsite_desc,g_rtdx_d[l_ac].rtdx002, 
       g_rtdx_d[l_ac].rtdx001,g_rtdx_d[l_ac].rtdx001_desc,g_rtdx_d[l_ac].rtdx001_desc_desc,g_rtdx_d[l_ac].l_qry_b, 
       g_rtdx_d[l_ac].l_money_b,g_rtdx_d[l_ac].l_pur_qry,g_rtdx_d[l_ac].l_pur_money,g_rtdx_d[l_ac].l_self_qry, 
       g_rtdx_d[l_ac].l_self_cost,g_rtdx_d[l_ac].l_self_money,g_rtdx_d[l_ac].l_pro_money,g_rtdx_d[l_ac].l_pro_cost, 
       g_rtdx_d[l_ac].l_in_qry,g_rtdx_d[l_ac].l_in_money,g_rtdx_d[l_ac].l_return_qry,g_rtdx_d[l_ac].l_return_money, 
       g_rtdx_d[l_ac].l_out_qry,g_rtdx_d[l_ac].l_out_money,g_rtdx_d[l_ac].l_rec_qry,g_rtdx_d[l_ac].l_rec_money, 
       g_rtdx_d[l_ac].l_sale_qry,g_rtdx_d[l_ac].l_sale_cost,g_rtdx_d[l_ac].l_who_qry,g_rtdx_d[l_ac].l_who_money, 
       g_rtdx_d[l_ac].l_inv_qry,g_rtdx_d[l_ac].l_inv_money,g_rtdx_d[l_ac].l_dam_qry,g_rtdx_d[l_ac].l_dam_money, 
       g_rtdx_d[l_ac].l_tra_qry,g_rtdx_d[l_ac].l_tra_money,g_rtdx_d[l_ac].l_oth_qry,g_rtdx_d[l_ac].l_oth_money, 
       g_rtdx_d[l_ac].l_bal_qry,g_rtdx_d[l_ac].l_bal_money
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #期初數量
      IF cl_null(g_rtdx_d[l_ac].l_qry_b) THEN
         LET g_rtdx_d[l_ac].l_qry_b = 0
      END IF
      
      #期初金額
      IF cl_null(g_rtdx_d[l_ac].l_money_b) THEN
         LET g_rtdx_d[l_ac].l_money_b = 0
      END IF
      
      #進貨數量
      IF cl_null(g_rtdx_d[l_ac].l_pur_qry) THEN
         LET g_rtdx_d[l_ac].l_pur_qry = 0
      END IF
      
      #進貨金額
      IF cl_null(g_rtdx_d[l_ac].l_pur_money) THEN
         LET g_rtdx_d[l_ac].l_pur_money = 0
      END IF
      
      #自營銷售数量
      IF cl_null(g_rtdx_d[l_ac].l_self_qry) THEN
         LET g_rtdx_d[l_ac].l_self_qry = 0
      END IF
      
      #自營銷售成本
      IF cl_null(g_rtdx_d[l_ac].l_self_cost) THEN
         LET g_rtdx_d[l_ac].l_self_cost = 0
      END IF

      #自營銷售金額
      IF cl_null(g_rtdx_d[l_ac].l_self_money) THEN
         LET g_rtdx_d[l_ac].l_self_money = 0
      END IF
      
      #促銷金額
      IF cl_null(g_rtdx_d[l_ac].l_pro_money) THEN
         LET g_rtdx_d[l_ac].l_pro_money = 0
      END IF
      
      #促銷成本金額
      IF cl_null(g_rtdx_d[l_ac].l_pro_cost) THEN
         LET g_rtdx_d[l_ac].l_pro_cost = 0
      END IF
      
      #退貨數量
      IF cl_null(g_rtdx_d[l_ac].l_return_qry) THEN
         LET g_rtdx_d[l_ac].l_return_qry = 0
      END IF
      
      #退貨金額
      IF cl_null(g_rtdx_d[l_ac].l_return_money) THEN
         LET g_rtdx_d[l_ac].l_return_money = 0
      END IF
      
      #領用數量
      IF cl_null(g_rtdx_d[l_ac].l_rec_qry) THEN
         LET g_rtdx_d[l_ac].l_rec_qry = 0
      END IF
      
      #領用金額
      IF cl_null(g_rtdx_d[l_ac].l_rec_money) THEN
         LET g_rtdx_d[l_ac].l_rec_money = 0
      END IF
      
      #銷售數量
      IF cl_null(g_rtdx_d[l_ac].l_sale_qry) THEN
         LET g_rtdx_d[l_ac].l_sale_qry = 0
      END IF
      
      #銷售成本
      IF cl_null(g_rtdx_d[l_ac].l_sale_cost) THEN
         LET g_rtdx_d[l_ac].l_sale_cost = 0
      END IF
      
      #批發數量
      IF cl_null(g_rtdx_d[l_ac].l_who_qry) THEN
         LET g_rtdx_d[l_ac].l_who_qry = 0
      END IF
      
      #批發金額
      IF cl_null(g_rtdx_d[l_ac].l_who_money) THEN
         LET g_rtdx_d[l_ac].l_who_money = 0
      END IF
      
      #盤點數量
      IF cl_null(g_rtdx_d[l_ac].l_inv_qry) THEN
         LET g_rtdx_d[l_ac].l_inv_qry = 0
      END IF
      
      #盤點金額
      IF cl_null(g_rtdx_d[l_ac].l_inv_money) THEN
         LET g_rtdx_d[l_ac].l_inv_money = 0
      END IF
      
      #報損數量
      IF cl_null(g_rtdx_d[l_ac].l_dam_qry) THEN
         LET g_rtdx_d[l_ac].l_dam_qry = 0
      END IF
      
      #報損金額
      IF cl_null(g_rtdx_d[l_ac].l_dam_money) THEN
         LET g_rtdx_d[l_ac].l_dam_money = 0
      END IF
      
      #轉碼數量
      IF cl_null(g_rtdx_d[l_ac].l_tra_qry) THEN
         LET g_rtdx_d[l_ac].l_tra_qry = 0
      END IF
      
      #轉碼金額
      IF cl_null(g_rtdx_d[l_ac].l_tra_money) THEN
         LET g_rtdx_d[l_ac].l_tra_money = 0
      END IF
      
      #結存數量
      IF cl_null(g_rtdx_d[l_ac].l_bal_qry) THEN
         LET g_rtdx_d[l_ac].l_bal_qry = 0
      END IF
      
      #結存金額
      IF cl_null(g_rtdx_d[l_ac].l_bal_money) THEN
         LET g_rtdx_d[l_ac].l_bal_money = 0
      END IF
      
      #其他數量 = 期末數量 - 期初數量 - 進貨數量 - 調入數量 -
      #          退貨數量 - 調出數量 - 領用數量 - 銷售數量 -
      #          批發數量 - 盤點數量 - 報損數量 - 轉碼數量
      LET g_rtdx_d[l_ac].l_oth_qry = g_rtdx_d[l_ac].l_bal_qry -    g_rtdx_d[l_ac].l_qry_b -
                                     g_rtdx_d[l_ac].l_pur_qry -    g_rtdx_d[l_ac].l_in_qry -
                                     g_rtdx_d[l_ac].l_return_qry - g_rtdx_d[l_ac].l_out_qry -
                                     g_rtdx_d[l_ac].l_rec_qry -    g_rtdx_d[l_ac].l_sale_qry -
                                     g_rtdx_d[l_ac].l_who_qry -    g_rtdx_d[l_ac].l_inv_qry -
                                     g_rtdx_d[l_ac].l_dam_qry -    g_rtdx_d[l_ac].l_tra_qry
      
      #其他數量 = 期末金額 - 期初金額 - 進貨金額 - 調入金額 -
      #          退貨金額 - 調出金額 - 領用金額 - 銷售成本 -
      #          批發金額 - 盤點金額 - 報損金額 - 轉碼金額
      LET g_rtdx_d[l_ac].l_oth_money = g_rtdx_d[l_ac].l_bal_money -    g_rtdx_d[l_ac].l_money_b - 
                                       g_rtdx_d[l_ac].l_pur_money -    g_rtdx_d[l_ac].l_in_money -
                                       g_rtdx_d[l_ac].l_return_money - g_rtdx_d[l_ac].l_out_money - 
                                       g_rtdx_d[l_ac].l_rec_money -    g_rtdx_d[l_ac].l_sale_cost -
                                       g_rtdx_d[l_ac].l_who_money -    g_rtdx_d[l_ac].l_inv_money -
                                       g_rtdx_d[l_ac].l_dam_money -    g_rtdx_d[l_ac].l_tra_money
      #end add-point
 
      CALL ainq681_detail_show("'1'")
 
      CALL ainq681_rtdx_t_mask()
 
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
   CALL g_rtdx2_d.clear()
   
   LET g_sql = "SELECT rtdxsite, (SELECT ooefl003 FROM ooefl_t",
               "                   WHERE ooeflent = rtdxent",
               "                     AND ooefl001 = rtdxsite",
               "                     AND ooefl002 = '",g_dlang,"'),",
               "       rtaw001,  (SELECT rtaxl003 FROM rtaxl_t",
               "                   WHERE rtaxlent = rtdxent",
               "                     AND rtaxl001 = rtaw001",
               "                     AND rtaxl002 = '",g_dlang,"'),",
               "       l_qry_b,        l_money_b,   l_pur_qry,    l_pur_money,",
               "       l_self_qry,     l_self_cost, l_self_money, l_pro_money,",
               "       l_pro_cost,     l_in_qry,    l_in_money,   l_return_qry,",
               "       l_return_money, l_out_qry,   l_out_money,  l_rec_qry,",
               "       l_rec_money,    l_sale_qry,  l_sale_cost,  l_who_qry,",
               "       l_who_money,    l_inv_qry,   l_inv_money,  l_dam_qry,",
               "       l_dam_money,    l_tra_qry,   l_tra_money,  l_oth_qry,",
               "       l_oth_money,    l_bal_qry,   l_bal_money",
               " FROM (SELECT b.rtdxent rtdxent,                b.rtdxsite rtdxsite,                  b.rtaw001 rtaw001,",
               "              SUM(b.l_qry_b) l_qry_b,           SUM(b.l_money_b) l_money_b,",
               "              SUM(a.l_pur_qry) l_pur_qry,       SUM(a.l_pur_money) l_pur_money,       SUM(b.l_self_qry) l_self_qry,",
               "              SUM(b.l_self_cost) l_self_cost,   SUM(b.l_self_money) l_self_money,     SUM(b.l_pro_money) l_pro_money,",
               "              SUM(b.l_pro_cost) l_pro_cost,     SUM(a.l_in_qry) l_in_qry,             SUM(a.l_in_money) l_in_money,",
               "              SUM(a.l_return_qry) l_return_qry, SUM(a.l_return_money) l_return_money, SUM(a.l_out_qry) l_out_qry,",
               "              SUM(a.l_out_money) l_out_money,   SUM(a.l_rec_qry) l_rec_qry,           SUM(a.l_rec_money) l_rec_money,",
               "              SUM(b.l_sale_qry) l_sale_qry,     SUM(b.l_sale_cost) l_sale_cost,       SUM(b.l_who_qry) l_who_qry,",
               "              SUM(b.l_who_money) l_who_money,   SUM(a.l_inv_qry) l_inv_qry,           SUM(a.l_inv_money) l_inv_money,",
               "              SUM(a.l_dam_qry) l_dam_qry,       SUM(a.l_dam_money) l_dam_money,       SUM(a.l_tra_qry) l_tra_qry,",
               "              SUM(a.l_tra_money) l_tra_money,   SUM(b.l_oth_qry) l_oth_qry,           SUM(b.l_oth_money) l_oth_money,",
               "              SUM(b.l_bal_qry) l_bal_qry,       SUM(b.l_bal_money) l_bal_money,",
               "              DENSE_RANK() OVER( ORDER BY b.rtdxsite,b.rtaw001) AS RANK",
               "         FROM ainq681_deba b",
               "         LEFT OUTER JOIN ainq681_tmp a ON a.rtdxent = b.rtdxent",
               "                                      AND a.rtdxsite= b.rtdxsite",
               "                                      AND a.rtdx001 = b.rtdx001",
               "        WHERE b.rtdxent = ?",
               "        GROUP BY b.rtdxent,b.rtdxsite,b.rtaw001)",
               " ORDER BY rtdxsite,rtaw001"
   PREPARE ainq681_b_fill2_pre FROM g_sql
   DECLARE ainq681_b_fill2_cs  CURSOR FOR ainq681_b_fill2_pre
   LET g_cnt = l_ac
   LET l_ac = 1
   FOREACH ainq681_b_fill2_cs USING g_enterprise
      INTO g_rtdx2_d[l_ac].rtdxsite_d2,       g_rtdx2_d[l_ac].rtdxsite_d2_desc,
           g_rtdx2_d[l_ac].rtaw001,           g_rtdx2_d[l_ac].rtaw001_desc,
           g_rtdx2_d[l_ac].l_qry_b_d2,        g_rtdx2_d[l_ac].l_money_b_d2,   g_rtdx2_d[l_ac].l_pur_qry_d2,
           g_rtdx2_d[l_ac].l_pur_money_d2,    g_rtdx2_d[l_ac].l_self_qry_d2,  g_rtdx2_d[l_ac].l_self_cost_d2,
           g_rtdx2_d[l_ac].l_self_money_d2,   g_rtdx2_d[l_ac].l_pro_money_d2, g_rtdx2_d[l_ac].l_pro_cost_d2,
           g_rtdx2_d[l_ac].l_in_qry_d2,       g_rtdx2_d[l_ac].l_in_money_d2,  g_rtdx2_d[l_ac].l_return_qry_d2,
           g_rtdx2_d[l_ac].l_return_money_d2, g_rtdx2_d[l_ac].l_out_qry_d2,   g_rtdx2_d[l_ac].l_out_money_d2,
           g_rtdx2_d[l_ac].l_rec_qry_d2,      g_rtdx2_d[l_ac].l_rec_money_d2, g_rtdx2_d[l_ac].l_sale_qry_d2,
           g_rtdx2_d[l_ac].l_sale_cost_d2,    g_rtdx2_d[l_ac].l_who_qry_d2,   g_rtdx2_d[l_ac].l_who_money_d2,
           g_rtdx2_d[l_ac].l_inv_qry_d2,      g_rtdx2_d[l_ac].l_inv_money_d2, g_rtdx2_d[l_ac].l_dam_qry_d2,
           g_rtdx2_d[l_ac].l_dam_money_d2,    g_rtdx2_d[l_ac].l_tra_qry_d2,   g_rtdx2_d[l_ac].l_tra_money_d2,
           g_rtdx2_d[l_ac].l_oth_qry_d2,      g_rtdx2_d[l_ac].l_oth_money_d2, g_rtdx2_d[l_ac].l_bal_qry_d2,
           g_rtdx2_d[l_ac].l_bal_money_d2

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
      
      #期初數量
      IF cl_null(g_rtdx2_d[l_ac].l_qry_b_d2) THEN
         LET g_rtdx2_d[l_ac].l_qry_b_d2 = 0
      END IF
      
      #期初金額
      IF cl_null(g_rtdx2_d[l_ac].l_money_b_d2) THEN
         LET g_rtdx2_d[l_ac].l_money_b_d2 = 0
      END IF
      
      #進貨數量
      IF cl_null(g_rtdx2_d[l_ac].l_pur_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_pur_qry_d2 = 0
      END IF
      
      #進貨金額
      IF cl_null(g_rtdx2_d[l_ac].l_pur_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_pur_money_d2 = 0
      END IF
      
      #自營銷售数量
      IF cl_null(g_rtdx2_d[l_ac].l_self_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_self_qry_d2 = 0
      END IF
      
      #自營銷售成本
      IF cl_null(g_rtdx2_d[l_ac].l_self_cost_d2) THEN
         LET g_rtdx2_d[l_ac].l_self_cost_d2 = 0
      END IF

      #自營銷售金額
      IF cl_null(g_rtdx2_d[l_ac].l_self_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_self_money_d2 = 0
      END IF
      
      #促銷金額
      IF cl_null(g_rtdx2_d[l_ac].l_pro_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_pro_money_d2 = 0
      END IF
      
      #促銷成本金額
      IF cl_null(g_rtdx2_d[l_ac].l_pro_cost_d2) THEN
         LET g_rtdx2_d[l_ac].l_pro_cost_d2 = 0
      END IF
      
      #退貨數量
      IF cl_null(g_rtdx2_d[l_ac].l_return_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_return_qry_d2 = 0
      END IF
      
      #退貨金額
      IF cl_null(g_rtdx2_d[l_ac].l_return_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_return_money_d2 = 0
      END IF
      
      #領用數量
      IF cl_null(g_rtdx2_d[l_ac].l_rec_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_rec_qry_d2 = 0
      END IF
      
      #領用金額
      IF cl_null(g_rtdx2_d[l_ac].l_rec_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_rec_money_d2 = 0
      END IF
      
      #銷售數量
      IF cl_null(g_rtdx2_d[l_ac].l_sale_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_sale_qry_d2 = 0
      END IF
      
      #銷售金額
      IF cl_null(g_rtdx2_d[l_ac].l_sale_cost_d2) THEN
         LET g_rtdx2_d[l_ac].l_sale_cost_d2 = 0
      END IF
      
      #批發數量
      IF cl_null(g_rtdx2_d[l_ac].l_who_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_who_qry_d2 = 0
      END IF
      
      #批發金額
      IF cl_null(g_rtdx2_d[l_ac].l_who_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_who_money_d2 = 0
      END IF
      
      #盤點數量
      IF cl_null(g_rtdx2_d[l_ac].l_inv_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_inv_qry_d2 = 0
      END IF
      
      #盤點金額
      IF cl_null(g_rtdx2_d[l_ac].l_inv_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_inv_money_d2 = 0
      END IF
      
      #報損數量
      IF cl_null(g_rtdx2_d[l_ac].l_dam_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_dam_qry_d2 = 0
      END IF
      
      #報損金額
      IF cl_null(g_rtdx2_d[l_ac].l_dam_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_dam_money_d2 = 0
      END IF
      
      #轉碼數量
      IF cl_null(g_rtdx2_d[l_ac].l_tra_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_tra_qry_d2 = 0
      END IF
      
      #轉碼金額
      IF cl_null(g_rtdx2_d[l_ac].l_tra_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_tra_money_d2 = 0
      END IF
      
      #結存數量
      IF cl_null(g_rtdx2_d[l_ac].l_bal_qry_d2) THEN
         LET g_rtdx2_d[l_ac].l_bal_qry_d2 = 0
      END IF
      
      #結存金額
      IF cl_null(g_rtdx2_d[l_ac].l_bal_money_d2) THEN
         LET g_rtdx2_d[l_ac].l_bal_money_d2 = 0
      END IF
      
      LET g_rtdx2_d[l_ac].l_oth_qry_d2 = g_rtdx2_d[l_ac].l_bal_qry_d2 -  g_rtdx2_d[l_ac].l_qry_b_d2 -
                                         g_rtdx2_d[l_ac].l_pur_qry_d2 -  g_rtdx2_d[l_ac].l_self_qry_d2 -
                                         g_rtdx2_d[l_ac].l_in_qry_d2 -   g_rtdx2_d[l_ac].l_return_qry_d2 -
                                         g_rtdx2_d[l_ac].l_out_qry_d2 -  g_rtdx2_d[l_ac].l_rec_qry_d2 -
                                         g_rtdx2_d[l_ac].l_sale_qry_d2 - g_rtdx2_d[l_ac].l_who_qry_d2 -
                                         g_rtdx2_d[l_ac].l_inv_qry_d2 -  g_rtdx2_d[l_ac].l_dam_qry_d2 -
                                         g_rtdx2_d[l_ac].l_tra_qry_d2
      
      LET g_rtdx2_d[l_ac].l_oth_money_d2 = g_rtdx2_d[l_ac].l_bal_money_d2 -    g_rtdx2_d[l_ac].l_money_b_d2 - 
                                           g_rtdx2_d[l_ac].l_pur_money_d2 -    g_rtdx2_d[l_ac].l_self_money_d2 -
                                           g_rtdx2_d[l_ac].l_pro_money_d2-     g_rtdx2_d[l_ac].l_in_money_d2 -
                                           g_rtdx2_d[l_ac].l_return_money_d2 - g_rtdx2_d[l_ac].l_out_money_d2 - 
                                           g_rtdx2_d[l_ac].l_rec_money_d2 -    g_rtdx2_d[l_ac].l_sale_cost_d2 -
                                           g_rtdx2_d[l_ac].l_who_money_d2 -    g_rtdx2_d[l_ac].l_inv_money_d2 -
                                           g_rtdx2_d[l_ac].l_dam_money_d2 -    g_rtdx2_d[l_ac].l_tra_money_d2
      
      LET l_ac = l_ac + 1
   END FOREACH

   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE ainq681_b_fill2_cs
   FREE ainq681_b_fill2_cs
   #end add-point
 
   CALL g_rtdx_d.deleteElement(g_rtdx_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   CALL g_rtdx2_d.deleteElement(g_rtdx2_d.getLength())
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtdx_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE ainq681_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL ainq681_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL ainq681_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtdx_d.getLength() > 0 THEN
      CALL ainq681_b_fill2()
   END IF
 
      CALL ainq681_filter_show('rtdxsite','b_rtdxsite')
   CALL ainq681_filter_show('rtdx002','b_rtdx002')
   CALL ainq681_filter_show('rtdx001','b_rtdx001')
 
 
END FUNCTION
 
{</section>}
 
{<section id="ainq681.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION ainq681_b_fill2()
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
 
{<section id="ainq681.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION ainq681_detail_show(ps_page)
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
 
{<section id="ainq681.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION ainq681_filter()
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
      CONSTRUCT g_wc_filter ON rtdxsite,rtdx002,rtdx001
                          FROM s_detail1[1].b_rtdxsite,s_detail1[1].b_rtdx002,s_detail1[1].b_rtdx001
 
         BEFORE CONSTRUCT
                     DISPLAY ainq681_filter_parser('rtdxsite') TO s_detail1[1].b_rtdxsite
            DISPLAY ainq681_filter_parser('rtdx002') TO s_detail1[1].b_rtdx002
            DISPLAY ainq681_filter_parser('rtdx001') TO s_detail1[1].b_rtdx001
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<b_rtdxsite>>----
         #Ctrlp:construct.c.filter.page1.b_rtdxsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdxsite
            #add-point:ON ACTION controlp INFIELD b_rtdxsite name="construct.c.filter.page1.b_rtdxsite"
            
            #END add-point
 
 
         #----<<b_rtdxsite_desc>>----
         #----<<b_rtdx002>>----
         #Ctrlp:construct.c.page1.b_rtdx002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx002
            #add-point:ON ACTION controlp INFIELD b_rtdx002 name="construct.c.filter.page1.b_rtdx002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx002  #顯示到畫面上
            NEXT FIELD b_rtdx002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx001>>----
         #Ctrlp:construct.c.page1.b_rtdx001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtdx001
            #add-point:ON ACTION controlp INFIELD b_rtdx001 name="construct.c.filter.page1.b_rtdx001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_rtdx001  #顯示到畫面上
            NEXT FIELD b_rtdx001                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_rtdx001_desc>>----
         #----<<b_rtdx001_desc_desc>>----
         #----<<l_qry_b>>----
         #----<<l_money_b>>----
         #----<<l_pur_qry>>----
         #----<<l_pur_money>>----
         #----<<l_self_qry>>----
         #----<<l_self_cost>>----
         #----<<l_self_money>>----
         #----<<l_pro_money>>----
         #----<<l_pro_cost>>----
         #----<<l_in_qry>>----
         #----<<l_in_money>>----
         #----<<l_return_qry>>----
         #----<<l_return_money>>----
         #----<<l_out_qry>>----
         #----<<l_out_money>>----
         #----<<l_rec_qry>>----
         #----<<l_rec_money>>----
         #----<<l_sale_qry>>----
         #----<<l_sale_cost>>----
         #----<<l_who_qry>>----
         #----<<l_who_money>>----
         #----<<l_inv_qry>>----
         #----<<l_inv_money>>----
         #----<<l_dam_qry>>----
         #----<<l_dam_money>>----
         #----<<l_tra_qry>>----
         #----<<l_tra_money>>----
         #----<<l_oth_qry>>----
         #----<<l_oth_money>>----
         #----<<l_bal_qry>>----
         #----<<l_bal_money>>----
 
 
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
 
      CALL ainq681_filter_show('rtdxsite','b_rtdxsite')
   CALL ainq681_filter_show('rtdx002','b_rtdx002')
   CALL ainq681_filter_show('rtdx001','b_rtdx001')
 
 
   CALL ainq681_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="ainq681.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION ainq681_filter_parser(ps_field)
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
 
{<section id="ainq681.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION ainq681_filter_show(ps_field,ps_object)
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
   LET ls_condition = ainq681_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="ainq681.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION ainq681_detail_action_trans()
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
 
{<section id="ainq681.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION ainq681_detail_index_setting()
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
            IF g_rtdx_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtdx_d.getLength() AND g_rtdx_d.getLength() > 0
            LET g_detail_idx = g_rtdx_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtdx_d.getLength() THEN
               LET g_detail_idx = g_rtdx_d.getLength()
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
 
{<section id="ainq681.mask_functions" >}
 &include "erp/ain/ainq681_mask.4gl"
 
{</section>}
 
{<section id="ainq681.other_function" readonly="Y" >}

################################################################################
# Descriptions...: create temp table
# Memo...........:
# Usage..........: CALL ainq681_create_tmp()
#                     RETURNING r_success
# Input parameter: 無
# Return code....: r_success      True/False
# Date & Author..: 2015/12/07 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq681_create_tmp()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE
   
   DROP TABLE ainq681_tmp
   
   CREATE TEMP TABLE ainq681_tmp(
      rtdxent           LIKE rtdx_t.rtdxent,     #企業編號
      rtdxsite          LIKE rtdx_t.rtdxsite,    #營運據點
      rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
      rtdx002           LIKE rtdx_t.rtdx002,     #商品主條碼
      rtaw001           LIKE rtaw_t.rtaw001,     #管理品類
      l_pur_qry         LIKE type_t.num20_6,     #進貨數量
      l_pur_money       LIKE type_t.num20_6,     #進貨金額
      l_in_qry          LIKE type_t.num20_6,     #調入數量
      l_in_money        LIKE type_t.num20_6,     #調入金額
      l_return_qry      LIKE type_t.num20_6,     #退貨數量
      l_return_money    LIKE type_t.num20_6,     #退貨金額
      l_out_qry         LIKE type_t.num20_6,     #調出數量
      l_out_money       LIKE type_t.num20_6,     #調出金額
      l_rec_qry         LIKE type_t.num20_6,     #領用數量
      l_rec_money       LIKE type_t.num20_6,     #領用金額
      l_inv_qry         LIKE type_t.num20_6,     #盤點數量
      l_inv_money       LIKE type_t.num20_6,     #盤點金額
      l_dam_qry         LIKE type_t.num20_6,     #報損數量
      l_dam_money       LIKE type_t.num20_6,     #報損金額
      l_tra_qry         LIKE type_t.num20_6,     #轉碼數量
      l_tra_money       LIKE type_t.num20_6,     #轉碼金額
      l_oth_qry         LIKE type_t.num20_6,     #其他調整數量
      l_oth_money       LIKE type_t.num20_6)     #其他調整金額
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table ainq681_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   DROP INDEX ainq681_tmp_01
   CREATE INDEX ainq681_tmp_01 ON ainq681_tmp(rtdxent,rtdxsite,rtdx001,rtaw001)
   
   DROP TABLE ainq681_deba
   CREATE TEMP TABLE ainq681_deba(
      rtdxent           LIKE rtdx_t.rtdxent,     #企業編號
      rtdxsite          LIKE rtdx_t.rtdxsite,    #營運據點
      rtdx001           LIKE rtdx_t.rtdx001,     #商品編號
      rtaw001           LIKE rtaw_t.rtaw001,     #管理品類
      l_qry_b           LIKE type_t.num20_6,     #期初數量
      l_money_b         LIKE type_t.num20_6,     #期初金額
      l_self_qry        LIKE type_t.num20_6,     #自營銷售數量
      l_self_cost       LIKE type_t.num20_6,     #自營銷售成本
      l_self_money      LIKE type_t.num20_6,     #自營銷售金額
      l_pro_money       LIKE type_t.num20_6,     #促銷金額
      l_pro_cost        LIKE type_t.num20_6,     #促銷成本金額
      l_sale_qry        LIKE type_t.num20_6,     #銷售數量
      l_sale_cost       LIKE type_t.num20_6,     #銷售金額
      l_who_qry         LIKE type_t.num20_6,     #批發數量
      l_who_money       LIKE type_t.num20_6,     #批發金額
      l_oth_qry         LIKE type_t.num20_6,     #其他調整數量
      l_oth_money       LIKE type_t.num20_6,     #其他調整金額
      l_bal_qry         LIKE type_t.num20_6,     #結存數量
      l_bal_money       LIKE type_t.num20_6)     #結存金額
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create Temp Table ainq681_tmp'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   DROP INDEX ainq681_deba_01
   CREATE INDEX ainq681_deba_01 ON ainq681_deba(rtdxent,rtdxsite,rtdx001,rtaw001)
   
   DROP TABLE ainq681_site
   CREATE TEMP TABLE ainq681_site(
      ooabsite       LIKE ooab_t.ooabsite,   #營運組織
      ooab_6001      LIKE ooab_t.ooab002,    #採用成本域(S-FIN-6001)
      ooab_6002      LIKE ooab_t.ooab002)    #成本域類型(S-FIN-6002)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create Temp Table ainq681_site"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增資料到temp table
# Memo...........:
# Usage..........: CALL ainq681_ins_tmp(p_wc,p_where)
# Input parameter: p_wc           條件
#                : p_where        aooi500條件
# Return code....: 無
# Date & Author..: 2015/12/07 By pomelo
# Modify.........:
################################################################################
PRIVATE FUNCTION ainq681_ins_tmp(p_wc,p_where)
DEFINE p_wc              STRING
DEFINE p_where           STRING
DEFINE l_ooab            RECORD
       ooab_6001         LIKE ooab_t.ooab002,    #採用成本域(S-FIN-6001)
       ooab_6002         LIKE ooab_t.ooab002     #成本域類型(S-FIN-6002)
                         END RECORD
DEFINE l_sys             LIKE type_t.num5
DEFINE l_date            LIKE type_t.dat
DEFINE l_cnt             LIKE type_t.num5
DEFINE l_rtdxsite        LIKE rtdx_t.rtdxsite
DEFINE l_where           STRING
DEFINE l_sql             STRING


   #管理品類參數
   LET l_sys = cl_get_para(g_enterprise,"","E-CIR-0001")
   
   TRUNCATE TABLE ainq681_tmp
   
   DISPLAY 'START = ',cl_get_timestamp()
   
   IF cl_null(g_rtdxsite) THEN
      LET g_rtdxsite = " 1=1"
   END IF
   LET l_where = s_aooi500_sql_where(g_prog,'rtdxsite')
   LET g_rtdxsite = g_rtdxsite, " AND ",p_where
   LET l_sql = "SELECT DISTINCT rtdxsite",
               "  FROM rtdx_t",
               " WHERE rtdxent = ",g_enterprise,
               "   AND ",g_rtdxsite
   PREPARE ainq681_rtdxsite_pre FROM l_sql
   DECLARE ainq681_rtdxsite_cs CURSOR FOR ainq681_rtdxsite_pre

   #刪除temp table資料
   TRUNCATE TABLE ainq681_site

   #抓取條件內的據點級參數
   FOREACH ainq681_rtdxsite_cs INTO l_rtdxsite
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins ainq681_site"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF

      INITIALIZE l_ooab.* TO NULL

      #採用成本域
      CALL cl_get_para(g_enterprise,l_rtdxsite,'S-FIN-6001')
         RETURNING l_ooab.ooab_6001

      IF l_ooab.ooab_6001 = 'Y' THEN
         #成本域類型
         CALL cl_get_para(g_enterprise,l_rtdxsite,'S-FIN-6002')
            RETURNING l_ooab.ooab_6002
      END IF

      INSERT INTO ainq681_site(ooabsite,ooab_6001,ooab_6002)
         VALUES(l_rtdxsite, l_ooab.ooab_6001, l_ooab.ooab_6002)
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Ins ainq681_site"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN
      END IF
   END FOREACH
   
   #新增資料到temp table            
   LET l_sql = " INSERT /*+ APPEND */ INTO ainq681_tmp",
               "    (rtdxent,   rtdxsite,    rtdx001,      rtdx002,       rtaw001,",
               "     l_pur_qry, l_pur_money, l_in_qry,     l_in_money,",
               "     l_out_qry, l_out_money, l_return_qry, l_return_money,",
               "     l_rec_qry, l_rec_money, l_inv_qry,    l_inv_money,",
               "     l_dam_qry, l_dam_money, l_tra_qry,    l_tra_money)",
               " SELECT rtdxent, rtdxsite,   rtdx001,      rtdx002,       rtaw001,",
               #進貨數量
               "        SUM(CASE WHEN (inaj015 = 'apmt862' OR inaj015 = 'apmt863' OR inaj015 = 'apmt880' OR inaj015 = 'apmt881' OR (inaj015 = 'apmt882' AND inaj004 = '1'))",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #進貨金額
               "        SUM(CASE WHEN (inaj015 = 'apmt862' OR inaj015 = 'apmt863' OR inaj015 = 'apmt880' OR inaj015 = 'apmt881' OR (inaj015 = 'apmt882' AND inaj004 = '1'))",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #調入數量
               "        SUM(CASE WHEN ((inaj015 = 'aint511' OR inaj015 = 'aint512' OR inaj015 = 'aint513' OR inaj015 = 'aint514' OR inaj015 = 'aint515' OR inaj015 = 'aint516') AND inaj004 = '1')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #調入金額
               "        SUM(CASE WHEN ((inaj015 = 'aint511' OR inaj015 = 'aint512' OR inaj015 = 'aint513' OR inaj015 = 'aint514' OR inaj015 = 'aint515' OR inaj015 = 'aint516') AND inaj004 = '1')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #調出數量
               "        SUM(CASE WHEN ((inaj015 = 'aint511' OR inaj015 = 'aint512' OR inaj015 = 'aint513' OR inaj015 = 'aint514' OR inaj015 = 'aint515' OR inaj015 = 'aint516') AND inaj004 = '-1')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #調出金額
               "        SUM(CASE WHEN ((inaj015 = 'aint511' OR inaj015 = 'aint512' OR inaj015 = 'aint513' OR inaj015 = 'aint514' OR inaj015 = 'aint515' OR inaj015 = 'aint516') AND inaj004 = '-1')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #退貨數量
               "        SUM(CASE WHEN (inaj015 = 'apmt890' OR inaj015 = 'apmt891' OR (inaj015 = 'apmt882' AND inaj004 = '-1'))",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #退貨金額
               "        SUM(CASE WHEN (inaj015 = 'apmt890' OR inaj015 = 'apmt891' OR (inaj015 = 'apmt882' AND inaj004 = '-1'))",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #領用數量
               "        SUM(CASE WHEN (inaj015 = 'aint911' OR inaj015 = 'aint912' OR inaj015 = 'aint914' OR inaj015 = 'aint915' OR inaj015 = 'aint916')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #領用金額
               "        SUM(CASE WHEN (inaj015 = 'aint911' OR inaj015 = 'aint912' OR inaj015 = 'aint914' OR inaj015 = 'aint915' OR inaj015 = 'aint916')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #盤點數量
               "        SUM(CASE WHEN (inaj015 = 'aint808')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #盤點金額
               "        SUM(CASE WHEN (inaj015 = 'aint808')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #報損數量
               "        SUM(CASE WHEN (inaj015 = 'aint913')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #報損金額
               "        SUM(CASE WHEN (inaj015 = 'aint913')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END),",
               #轉碼數量
               "        SUM(CASE WHEN (inaj015 = 'aint917')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0) ELSE 0 END),",
               #轉碼金額
               "        SUM(CASE WHEN (inaj015 = 'aint917')",
               "                 THEN COALESCE(inaj011,0)*COALESCE(inaj013,0)*COALESCE(inaj004,0)*COALESCE(xccu202,0) ELSE 0 END)",
               "   FROM rtdx_t, inaj_t, imaa_t, ooef_t, glaa_t, xccu_t, rtaw_t, ainq681_site",
               "  WHERE rtdxent = inajent",
               "    AND rtdxsite = inajsite",
               "    AND rtdx001 = inaj005",
               
               "    AND rtdxent = imaaent",
               "    AND rtdx001 = imaa001",
               
               "    AND rtdxent = rtawent",
               "    AND rtaw002 = imaa009",
               "    AND rtaw003 = '",l_sys,"'",
               
               "    AND inajent = rtdxent ",
               "    AND inajsite = rtdxsite ",
               "    AND inaj005 = rtdx001",
                     
               "    AND glaaent = ooefent",
               "    AND glaacomp = ooef017",
               "    AND glaa014 = 'Y'",        #主帳套
               "    AND glaald = xcculd",      #帳套
               "    AND xccu001 = '1'",        #帳套本位幣順序
               #成本域
               ##成本域類型 = 3.還未有對應欄位，尚未處理
               "    AND xccu002 = (CASE ooab_6001",
               "                      WHEN 'N' THEN ' '",
               "                      WHEN 'Y' THEN (CASE ooab_6002",
               "                                        WHEN '1' THEN inajsite",  #組織
               "                                        WHEN '2' THEN inaj008",   #庫位
              #"                                        WHEN '3' THEN ' '",       #庫存管理特徵
               "                                     END)",
               "                   END)",
               "    AND glaa120 = xccu003",    #成本類型
                     
               "    AND inajent = xccuent ",
               "    AND inaj005 = xccu004 ",
               "    AND inaj006 = COALESCE(xccu005,inaj006) ",
               "    AND inaj010 = COALESCE(xccu006,inaj010) ",
               "    AND rtdxsite = ooabsite",
               
               "    AND rtdxent = ",g_enterprise,
               "    AND inaj023 BETWEEN '",g_sdate,"' AND '",g_edate,"'",
               "    AND ",p_wc,
               "  GROUP BY rtdxent,rtdxsite,rtdx001,rtdx002,rtaw001"
   PREPARE ainq681_ins_pre FROM l_sql
   EXECUTE ainq681_ins_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins ainq681_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   DELETE FROM ainq681_deba
   LET l_sql = " INSERT /*+ APPEND */ INTO ainq681_deba",
               "    (rtdxent,      rtdxsite,     rtdx001,       rtaw001,",
               "     l_qry_b,      l_money_b,    l_bal_qry,     l_bal_money,",
               "     l_self_qry,   l_self_cost,  l_self_money,  l_sale_qry,",
               "     l_sale_cost,  l_who_qry,    l_who_money,   l_pro_money,",
               "     l_pro_cost)",
               " SELECT rtdxent, rtdxsite,     rtdx001,     rtaw001,",
               #期初數量
               "        SUM(CASE WHEN (debn002 = '",g_sdate-1,"')",
               "                 THEN COALESCE(debn014,0) ELSE 0 END),",
               #期初金額
               "        SUM(CASE WHEN (debn002 = '",g_sdate-1,"')",
               "                 THEN COALESCE(debn015,0) ELSE 0 END),",
               #結存數量
               "        SUM(CASE WHEN (debn002 = '",g_edate,"')",
               "                 THEN COALESCE(debn014,0) ELSE 0 END),",
               #結存金額
               "        SUM(CASE WHEN (debn002 = '",g_edate,"')",
               "                 THEN COALESCE(debn015,0) ELSE 0 END),",
               #自營銷售数量
               "        SUM(CASE WHEN ((deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') AND deba049 = '1')",
               "            THEN COALESCE(deba021,0) ELSE 0 END),",
               #自營銷售成本  
               "        SUM(CASE WHEN ((deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') AND deba049 = '1')",
               "            THEN COALESCE(deba022,0) ELSE 0 END), ",
               #自營銷售金額
               "        SUM(CASE WHEN ((deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') AND deba049 = '1')",
               "            THEN COALESCE(deba026,0) ELSE 0 END),",
               #銷售數量
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba038,0) ELSE 0 END),",
               #銷售金額
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba039,0) ELSE 0 END), ",
               #批發數量
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba035,0) ELSE 0 END),",
               #批發金額
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba036,0) ELSE 0 END), ",
               #促銷金額
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba030,0) ELSE 0 END), ",
               #促銷成本金額
               "        SUM(CASE WHEN (deba002 BETWEEN '",g_sdate,"' AND '",g_edate,"') ",
               "            THEN COALESCE(deba031,0) ELSE 0 END) ",
               "   FROM rtdx_t,debn_t,deba_t,imaa_t,rtaw_t ",
               "  WHERE rtdxent = debnent",
               "    AND rtdxsite = debnsite",
               "    AND rtdx001 = debn005",
               "    AND rtdxent = debaent",
               "    AND rtdxsite = debasite",
               "    AND rtdx001 = deba009 ",
               "    AND debn002 = deba002",
               "    AND rtdxent = imaaent",
               "    AND rtdx001 = imaa001",
               "    AND rtdxent = rtawent",
               "    AND rtaw002 = imaa009",
               "    AND rtaw003 = '",l_sys,"'",
               "    AND debnent = ",g_enterprise,
               "    AND debn002 BETWEEN '",g_sdate-1,"' AND '",g_edate,"'",
               "    AND ",p_wc,
               "  GROUP BY rtdxent,rtdxsite,rtdx001,rtaw001"
   
   PREPARE ainq681_ins_deba FROM l_sql
   EXECUTE ainq681_ins_deba
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins ainq681_deba"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF
   
   DELETE FROM ainq681_tmp  
    WHERE rtaw001 IS NULL

   DELETE FROM ainq681_deba  
    WHERE rtaw001 IS NULL
   
   DISPLAY 'END = ',cl_get_timestamp()
   
   ##test(S)
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM ainq681_tmp
   DISPLAY 'l_cnt = ',l_cnt
   ##test(E)
   
END FUNCTION

 
{</section>}
 
