#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq145.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2017-01-03 17:21:35), PR版次:0005(2017-01-03 17:24:13)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: adeq145
#+ Description: 會員活卡率查詢作業
#+ Creator....: 02749(2016-10-17 17:51:05)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="adeq145.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161129-00032#2   2016/11/29 by lori   調整統計資料的方式,原SQL因DB版本而不支援
#161207-00021#1   2016/12/07 by lori   調整統計集團(ALL)的資料時, 曾消費會員卡張數 & 會員消費次數, 統計條件僅需消費會員卡需在統計日期範圍內有效的卡
#160819-00054#46  2016/12/13 by sakura 取會員卡範圍時,增加條件該卡號對應卡種的卡類型(mman066) = '1.會員卡'
#170103-00041#1   2017/01/3  by lori   1.本期有效卡的統計 應加入 mmaq025 <= 統計截止日的條件
#                                      2.去年同期有效卡,開卡日期(mmaq025) <= 去年同期截止日 ,此處程式撰寫有誤
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
PRIVATE TYPE type_g_rtja_d RECORD
       
       sel LIKE type_t.chr1, 
   rtjasite LIKE rtja_t.rtjasite, 
   rtjasite_desc LIKE type_t.chr500, 
   l_piece_n LIKE type_t.num20_6, 
   l_consumption_n LIKE type_t.num20_6, 
   l_sale_n LIKE type_t.num20_6, 
   l_survival_rate_n LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_rtja2_d RECORD
       l_rtjasite_o LIKE type_t.chr10, 
   l_rtjasite_o_desc LIKE type_t.chr500, 
   l_piece_o LIKE type_t.num20_6, 
   l_consumption_o LIKE type_t.num20_6, 
   l_sale_o LIKE type_t.num20_6, 
   l_survival_rate_o LIKE type_t.num20_6
       END RECORD
 
PRIVATE TYPE type_g_rtja3_d RECORD
       rtja001 LIKE type_t.chr30, 
   mmaf001 LIKE type_t.chr30, 
   mmaf008 LIKE type_t.chr500, 
   rtja031 LIKE type_t.num20_6
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master RECORD
          l_date_s    LIKE type_t.dat,
          l_date_e    LIKE type_t.dat
                END RECORD
                
DEFINE g_master_t RECORD
          l_date_s    LIKE type_t.dat,
          l_date_e    LIKE type_t.dat
                END RECORD  

DEFINE g_requery      LIKE type_t.num5    #是否重新查詢(判斷是否重新取得統計資料來源)
DEFINE g_date_s_o     LIKE type_t.dat     #去年同期起始日期(統計起始日期-1年)
DEFINE g_date_e_o     LIKE type_t.dat     #去年同期截止日期(統計截止日期-1年)
#end add-point
 
#模組變數(Module Variables)
DEFINE g_rtja_d            DYNAMIC ARRAY OF type_g_rtja_d
DEFINE g_rtja_d_t          type_g_rtja_d
DEFINE g_rtja2_d     DYNAMIC ARRAY OF type_g_rtja2_d
DEFINE g_rtja2_d_t   type_g_rtja2_d
 
DEFINE g_rtja3_d     DYNAMIC ARRAY OF type_g_rtja3_d
DEFINE g_rtja3_d_t   type_g_rtja3_d
 
 
 
 
 
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
 
{<section id="adeq145.main" >}
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
   DECLARE adeq145_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq145_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq145_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq145 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq145_init()   
 
      #進入選單 Menu (="N")
      CALL adeq145_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq145
      
   END IF 
   
   CLOSE adeq145_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE adeq145_tmp_01
   DROP TABLE adeq145_tmp_02
   DROP TABLE adeq145_tmp_03 
   #161129-00032#2 161129 by lori add---(S)
   DROP TABLE adeq145_tmp_04
   DROP TABLE adeq145_tmp_05
   DROP TABLE adeq145_tmp_06 
   DROP TABLE adeq145_tmp_07
   DROP TABLE adeq145_tmp_08
   DROP TABLE adeq145_tmp_09
   #161129-00032#2 161129 by lori add---(E)
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq145.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq145_init()
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
   CALL adeq145_create_tmp()
   #end add-point
 
   CALL adeq145_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq145.default_search" >}
PRIVATE FUNCTION adeq145_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " rtjadocno = '", g_argv[01], "' AND "
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
 
{<section id="adeq145.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq145_ui_dialog() 
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
 
   
   CALL adeq145_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_rtja_d.clear()
         CALL g_rtja2_d.clear()
 
         CALL g_rtja3_d.clear()
 
 
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
 
         CALL adeq145_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.l_date_s,g_master.l_date_e ATTRIBUTE(WITHOUT DEFAULTS)
            
            #避免操作不便,將判斷控制點置於此
            AFTER INPUT
               IF NOT cl_null(g_master.l_date_s) AND NOT cl_null(g_master.l_date_e) THEN
                   IF g_master.l_date_s > g_master.l_date_e THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.extend = ""
                      LET g_errparam.code   = "ade-00177"
                      LET g_errparam.popup  = TRUE
                      CALL cl_err() 

                      NEXT FIELD l_date_s
                   END IF
               END IF
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON rtjasite 
         
            ON ACTION controlp INFIELD rtjasite
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " ooef304 = 'Y' "
               
               CALL q_ooef001()
               
               DISPLAY g_qryparam.return1 TO rtjasite 
               NEXT FIELD rtjasite     
               
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_rtja_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq145_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq145_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               LET g_detail_idx2 = g_detail_idx
               CALL DIALOG.setCurrentRow("s_detail2", g_detail_idx2)
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_rtja2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body2.before_row"
               LET g_detail_idx = g_detail_idx2
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq145_b_fill2()
               LET g_action_choice = lc_action_choice_old               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_rtja3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq145_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL adeq145_set_act_no_visible()
            LET g_requery = FALSE
            INITIALIZE  g_master.* TO NULL
            INITIALIZE  g_master_t.* TO NULL
            
            LET g_master.l_date_s = s_date_get_first_date(g_today)
            LET g_master.l_date_e = g_today
            DISPLAY g_master.l_date_s TO l_date_s
            DISPLAY g_master.l_date_e TO l_date_e
            
            LET g_master_t.* = g_master.*
            #end add-point
            NEXT FIELD rtjasite
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            LET g_master_t.* = g_master.*
            LET g_wc_t = g_wc
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
            IF NOT cl_null(g_master.l_date_s) AND NOT cl_null(g_master.l_date_e) THEN
                IF g_master.l_date_s > g_master.l_date_e THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.extend = ""
                   LET g_errparam.code   = "ade-00177"
                   LET g_errparam.popup  = TRUE
                   CALL cl_err() 
            
                   NEXT FIELD l_date_s
                END IF
            END IF
               
            IF   g_master.l_date_s <> g_master_t.l_date_s 
              OR g_master.l_date_e <> g_master_t.l_date_e 
              OR g_wc <> g_wc_t OR cl_null(g_wc_t) THEN
               LET g_requery = TRUE
               
               CALL DIALOG.setCurrentRow("s_detail1", 1)
               CALL DIALOG.setCurrentRow("s_detail2", 1)
            END IF  
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL adeq145_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_rtja_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_rtja2_d)
               LET g_export_id[2]   = "s_detail2"
 
               LET g_export_node[3] = base.typeInfo.create(g_rtja3_d)
               LET g_export_id[3]   = "s_detail3"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq145_b_fill()
 
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
            CALL adeq145_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq145_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq145_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq145_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_rtja_d.getLength()
               LET g_rtja_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_rtja_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_rtja_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq145_filter()
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
               LET g_date_s_o = ''
               LET g_date_e_o = ''    
               LET g_requery = TRUE               
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
 
{<section id="adeq145.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq145_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL adeq145_b_fill_new()
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
 
   CALL g_rtja_d.clear()
   CALL g_rtja2_d.clear()
 
   CALL g_rtja3_d.clear()
 
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',rtjasite,'','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY rtja_t.rtjadocno) AS RANK FROM rtja_t", 
 
 
 
                     "",
                     " WHERE rtjaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("rtja_t"),
                     " ORDER BY rtja_t.rtjadocno"
 
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
 
   LET g_sql = "SELECT '',rtjasite,'','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq145_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq145_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_rtja_d[l_ac].sel,g_rtja_d[l_ac].rtjasite,g_rtja_d[l_ac].rtjasite_desc, 
       g_rtja_d[l_ac].l_piece_n,g_rtja_d[l_ac].l_consumption_n,g_rtja_d[l_ac].l_sale_n,g_rtja_d[l_ac].l_survival_rate_n, 
       g_rtja2_d[l_ac].l_rtjasite_o,g_rtja2_d[l_ac].l_rtjasite_o_desc,g_rtja2_d[l_ac].l_piece_o,g_rtja2_d[l_ac].l_consumption_o, 
       g_rtja2_d[l_ac].l_sale_o,g_rtja2_d[l_ac].l_survival_rate_o,g_rtja3_d[l_ac].rtja001,g_rtja3_d[l_ac].mmaf001, 
       g_rtja3_d[l_ac].mmaf008,g_rtja3_d[l_ac].rtja031
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
 
      CALL adeq145_detail_show("'1'")
 
      CALL adeq145_rtja_t_mask()
 
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
 
   CALL g_rtja_d.deleteElement(g_rtja_d.getLength())
   CALL g_rtja2_d.deleteElement(g_rtja2_d.getLength())
 
   CALL g_rtja3_d.deleteElement(g_rtja3_d.getLength())
 
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq145_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq145_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq145_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtja_d.getLength() > 0 THEN
      CALL adeq145_b_fill2()
   END IF
 
      CALL adeq145_filter_show('rtjasite','b_rtjasite')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq145.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq145_b_fill2()
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
   CALL g_rtja3_d.clear()
   
   LET g_sql = "SELECT rtja001, mmaq003,mmaf008,rtja031 ",
               " FROM ((SELECT rtja001, mmaq003,mmaf008,SUM(COALESCE(rtja031,0)) rtja031 ",
               "          FROM adeq145_tmp_02 ",
               "         WHERE rtjasite = ? ",   #指定單一匯總組織
               "           AND txn_n = 'Y' ",              
               "         GROUP BY rtja001, mmaq003,mmaf008) ",
               "      UNION ",
               "       (SELECT rtja001, mmaq003,mmaf008,SUM(COALESCE(rtja031,0)) rtja031 ",
               "          FROM adeq145_tmp_02 ",
               "         WHERE ? = 'ALL' ",      #此條件相當於 1=1,取所有組織匯總資料
               "           AND txn_n = 'Y' ",                  
               "         GROUP BY rtja001, mmaq003,mmaf008)) ",               
               " ORDER BY rtja001 "
   PREPARE adeq145_b_fill2_pre FROM g_sql
  #DISPLAY "[adeq145_b_fill2_pre] ",g_sql 
   DECLARE adeq145_b_fill2_cur CURSOR FOr adeq145_b_fill2_pre

   LET l_ac = 1
   FOREACH adeq145_b_fill2_cur USING g_rtja_d[g_detail_idx].rtjasite,g_rtja_d[g_detail_idx].rtjasite
                               INTO g_rtja3_d[l_ac].rtja001,g_rtja3_d[l_ac].mmaf001, 
                                    g_rtja3_d[l_ac].mmaf008,g_rtja3_d[l_ac].rtja031
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:adeq145_b_fill2_cur" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

     IF cl_null(g_rtja3_d[l_ac].rtja031) THEN
        LET g_rtja3_d[l_ac].rtja031 = 0       
     END IF
      
     CALL adeq145_rtja_t_mask()
 
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
   #end add-point
 
 
 
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   LET g_error_show = 0
   CALL g_rtja3_d.deleteElement(g_rtja3_d.getLength())   
   FREE adeq145_b_fill2_pre
   #end add-point
 
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="adeq145.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq145_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq145.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq145_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_where      STRING
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
      CONSTRUCT g_wc_filter ON rtjasite
                          FROM s_detail1[1].b_rtjasite
 
         BEFORE CONSTRUCT
                     DISPLAY adeq145_filter_parser('rtjasite') TO s_detail1[1].b_rtjasite
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_rtjasite>>----
         #Ctrlp:construct.c.page1.b_rtjasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_rtjasite
            #add-point:ON ACTION controlp INFIELD b_rtjasite name="construct.c.filter.page1.b_rtjasite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            LET l_where = "     ooef304 = 'Y' ",
                          " AND rtjasite IN (SELECT rtjasite FROM adeq145_tmp_01) "
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = l_where 
            CALL q_ooef001()
            DISPLAY g_qryparam.return1 TO b_rtjasite 
            NEXT FIELD b_rtjasite 
            #END add-point
 
 
         #----<<b_rtjasite_desc>>----
         #----<<l_piece_n>>----
         #----<<l_consumption_n>>----
         #----<<l_sale_n>>----
         #----<<l_survival_rate_n>>----
         #----<<l_rtjasite_o>>----
         #----<<l_rtjasite_o_desc>>----
         #----<<l_piece_o>>----
         #----<<l_consumption_o>>----
         #----<<l_sale_o>>----
         #----<<l_survival_rate_o>>----
         #----<<rtja001>>----
         #----<<mmaf001>>----
         #----<<mmaf008>>----
         #----<<rtja031>>----
 
 
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
 
      CALL adeq145_filter_show('rtjasite','b_rtjasite')
 
 
   CALL adeq145_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq145.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq145_filter_parser(ps_field)
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
 
{<section id="adeq145.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq145_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq145_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq145.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq145_detail_action_trans()
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
 
{<section id="adeq145.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq145_detail_index_setting()
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
            IF g_rtja_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_rtja_d.getLength() AND g_rtja_d.getLength() > 0
            LET g_detail_idx = g_rtja_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_rtja_d.getLength() THEN
               LET g_detail_idx = g_rtja_d.getLength()
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
 
{<section id="adeq145.mask_functions" >}
 &include "erp/ade/adeq145_mask.4gl"
 
{</section>}
 
{<section id="adeq145.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 功能按鈕關閉
# Memo...........:
# Usage..........: CALL adeq145_set_act_no_visible()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq145_set_act_no_visible()
   CALL cl_set_act_visible("sel,unsel,selall,selnone",FALSE)
END FUNCTION

################################################################################
# Descriptions...: 建立暫存檔
# Memo...........:
# Usage..........: CALL adeq145_create_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq145_create_tmp()
   DEFINE l_session_id       LIKE type_t.num20

   SELECT USERENV('SESSIONID') INTO l_session_id FROM DUAL
   DISPLAY "SessionId: ",l_session_id
   
   WHENEVER ERROR CONTINUE
    
   #有效會員卡資料
   DROP TABLE adeq145_tmp_01
   
   CREATE TEMP TABLE adeq145_tmp_01(
      mmaq001   LIKE mmaq_t.mmaq001,   #會員卡號
      mmaq003   LIKE mmaq_t.mmaq003,   #會員編號
      mmaq005   LIKE mmaq_t.mmaq005,   #會員卡有效日期
      mmaq024   LIKE mmaq_t.mmaq024,   #開卡組織(會員卡歸屬的門店)
      mmaq025   LIKE mmaq_t.mmaq025,   #開卡日期
      mman018   LIKE mman_t.mman018,   #卡有效期管控
      eff_n     LIKE type_t.chr1,      #本期有效卡
      eff_o     LIKE type_t.chr1)      #去年同期有效卡
      
   #銷售資料    
   DROP TABLE adeq145_tmp_02
   
   CREATE TEMP TABLE adeq145_tmp_02(
      rtjasite    LIKE rtja_t.rtjasite,
      rtjadocno   LIKE rtja_t.rtjadocno,
      rtjadocdt   LIKE rtja_t.rtjadocdt,
      rtja001     LIKE rtja_t.rtja001,     #會員卡號
      rtja031     LIKE rtja_t.rtja031,     #含稅應收金額(消費金額)
      mmaq003     LIKE mmaq_t.mmaq003,     #會員編號
      mmaf008     LIKE mmaf_t.mmaf008,     #會員姓名  
      txn_n       LIKE type_t.chr1,        #本期消費
      txn_o       LIKE type_t.chr1)        #去年同期消費
   
   #本期欲統計的組織
   DROP TABLE adeq145_tmp_03
   
   CREATE TEMP TABLE adeq145_tmp_03(
      ooef001     LIKE ooef_t.ooef001)  

   #161129-00032#2 161129 by lori add---(S)   
   #本期-有效會員卡總數
   DROP TABLE adeq145_tmp_04
   
   CREATE TEMP TABLE adeq145_tmp_04(
      mmaq001   LIKE mmaq_t.mmaq001,
      mmaq024   LIKE mmaq_t.mmaq024)
              
   #去年同期-有效會員卡總數
   DROP TABLE adeq145_tmp_05
   
   CREATE TEMP TABLE adeq145_tmp_05(
      mmaq001   LIKE mmaq_t.mmaq001,
      mmaq024   LIKE mmaq_t.mmaq024)
              
   #本期-曾消費會員卡張數
   DROP TABLE adeq145_tmp_06
   
   CREATE TEMP TABLE adeq145_tmp_06(
      rtja001   LIKE rtja_t.rtja001,
      rtjasite  LIKE rtja_t.rtjasite)
      
   #去年同期-曾消費會員卡張數
   DROP TABLE adeq145_tmp_07
   
   CREATE TEMP TABLE adeq145_tmp_07(
      rtja001   LIKE rtja_t.rtja001,
      rtjasite  LIKE rtja_t.rtjasite)
      
   #本期-會員消費次數
   DROP TABLE adeq145_tmp_08
   
   CREATE TEMP TABLE adeq145_tmp_08(
      rtjadocno   LIKE rtja_t.rtjadocno,
      rtjasite    LIKE rtja_t.rtjasite)
      
   #本期-會員消費次數
   DROP TABLE adeq145_tmp_09
   
   CREATE TEMP TABLE adeq145_tmp_09(
      rtjadocno   LIKE rtja_t.rtjadocno,
      rtjasite    LIKE rtja_t.rtjasite)
   #161129-00032#2 161129 by lori add---(E)
   
END FUNCTION

################################################################################
# Descriptions...: 取得資料來源並存入暫存檔
# Memo...........:
# Usage..........: CALL adeq145_ins_tmp()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq145_ins_tmp()
   DEFINE l_sql       STRING
   DEFINE l_year       LIKE type_t.num5
   DEFINE l_mon        LIKE type_t.num5
   DEFINE l_day        LIKE type_t.num5 
   DEFINE l_first_day  STRING   
   DEFINE l_date       LIKE type_t.dat

   LET l_year =''
   LET l_mon =''
   LET l_day = ''
   
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1 "
   END IF
   
   LET g_date_s_o = s_date_get_date(g_master.l_date_s,-12,0)
   LET g_date_e_o = s_date_get_date(g_master.l_date_e,-12,0)

   #2月日期是2/28或2/29需特別判斷
   #起始日期
   LET l_mon = MONTH(g_master.l_date_s)
   LET l_day = DAY(g_master.l_date_s)
   
   IF l_mon = 2 AND l_day >=28 THEN
      IF s_date_chk_lastday(g_master.l_date_s) THEN
         #如果本期截止日是年度2月最後一天, 去年同期也應取2月最後一天
         LET l_year = YEAR(g_date_s_o)
         LET l_first_day = l_year,"/",l_mon,"/1"         #組出去年同期截止日的當月第一天
         LET l_date = l_first_day
         LET g_date_s_o = s_date_get_last_date(l_date)   #傳入去年同期截止日的當月第一天, 再取得最後一天
      END IF
   END IF
   
   #截止日期
   LET l_mon = MONTH(g_master.l_date_e)
   LET l_day = DAY(g_master.l_date_e)
   
   IF l_mon = 2 AND l_day >=28 THEN
      IF s_date_chk_lastday(g_master.l_date_e) THEN
         #如果本期截止日是年度2月最後一天, 去年同期也應取2月最後一天
         LET l_year = YEAR(g_date_e_o)
         LET l_first_day = l_year,"/",l_mon,"/1"             #組出去年同期截止日的當月第一天
         LET l_date = l_first_day
         LET g_date_e_o = s_date_get_last_date(l_date)   #傳入去年同期截止日的當月第一天, 再取得最後一天
      END IF
   END IF
   
   DISPLAY "去年同期: ",g_date_s_o," - ",g_date_e_o
   
   #有效會員卡資料
  #LET l_org_wc = cl_replace_str(g_wc,"rtjasite","mmaq024") 
   
   LET l_sql = "INSERT INTO adeq145_tmp_01(mmaq001,mmaq003,mmaq005,mmaq024,mmaq025, ",    #會員卡號,會員編號,會員卡有效日期,開卡組織,開卡日期
               "                           mman018) ",                                    #卡效期管控 
               "SELECT mmaq001,mmaq003,mmaq005,mmaq024,mmaq025, ",
               "       mman018 ",
               "  FROM mmaq_t,mman_t ",
               " WHERE mmaqent = mmanent AND mmaq002 = mman001 ",
               "   AND mmaqent = ",g_enterprise,
               "   AND mmaq006 = '3' ",   #卡狀態=開卡
               "   AND mmaq024 IS NOT NULL ",
               "   AND ((mman018 = 'Y' ",
              #170103-00041#1 160103 by lori mod---(S) 
              #"      AND ((mmaq005 >= '",g_master.l_date_s,"') ",                                          #本期:有效卡條件
              #"        OR (mmaq005 >= '",g_date_s_o,"' AND mmaq025 <= '",g_date_s_o,"')) ",                #去年同期:有效卡條件
               "      AND ((mmaq005 >= '",g_master.l_date_s,"' AND mmaq025 <= '",g_master.l_date_e,"') ",   #本期:有效卡條件
               "        OR (mmaq005 >= '",g_date_s_o,"' AND mmaq025 <= '",g_date_e_o,"')) ",                #去年同期:有效卡條件 
              #170103-00041#1 160103 by lori mod---(E)                
               "        ) ",   
               "      OR mman018 = 'N') ",
               "   AND mman066 = '1' "   #160819-00054#46 by sakura add                

   LET l_sql = l_sql, cl_sql_add_filter("mmaq_t")
   PREPARE adeq145_ins_tmp1 FROM l_sql
  #DISPLAY "[adeq145_ins_tmp1 SQL]",l_sql 
   
   DELETE FROM adeq145_tmp_01
   
   EXECUTE adeq145_ins_tmp1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ERROR:adeq145_ins_tmp1"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF

   #更新本期有效卡標記
   UPDATE adeq145_tmp_01
      SET eff_n = 'Y'
    WHERE ((mman018 = 'Y' AND mmaq005 >= g_master.l_date_s) 
         OR mman018 = 'N')
      AND mmaq025 <= g_master.l_date_e   #170103-00041#1 160103 by lori add
       
   #更新去年同期有效卡標記
   UPDATE adeq145_tmp_01
      SET eff_o = 'Y'
    WHERE ((mman018 = 'Y' AND mmaq005 >= g_date_s_o)       
         OR mman018 = 'N')       
     #AND mmaq025 <= g_date_s_o    #170103-00041#1 160103 by lori mark
      AND mmaq025 <= g_date_e_o    #170103-00041#1 160103 by lori add
    
   #銷售資料
   LET l_sql = "INSERT INTO adeq145_tmp_02(rtjasite,rtjadocno,rtjadocdt,rtja001,rtja031, ",    #銷售門店,銷售單號,銷售日期,會員卡號,含稅應收金額(消費金額)
               "                           mmaq003,mmaf008) ",                                 #會員編號,會員姓名                                
               "SELECT rtjasite,rtjadocno,rtjadocdt,rtja001,rtja031, ",
               "       mmaq003,mmaf008 ",
               "  FROM rtja_t, ",                                   
               "       mmaq_t LEFT JOIN mmaf_t ON mmaqent = mmafent AND mmaq003 = mmaf001 ",
               " WHERE rtjaent = mmaqent AND rtja001 = mmaq001 ",   #取有會員卡紀錄的資料
               "   AND rtjaent = ",g_enterprise, 
              #"   AND rtja000 IN ('artt600','artt610') ",          #取銷售資料
               "   AND rtjastus <> 'X' ",
               "   AND ((rtjadocdt >= '",g_master.l_date_s,"' AND rtjadocdt <= '",g_master.l_date_e,"') ",  #本期:銷售資料
               "     OR (rtjadocdt >= '",g_date_s_o,"' AND rtjadocdt <= '",g_date_e_o,"')) "  #去年同期:銷售資料
           
               
   LET l_sql = l_sql, cl_sql_add_filter("rtja_t")
   PREPARE adeq145_ins_tmp2 FROM l_sql
  #DISPLAY "[adeq145_ins_tmp2 SQL]",l_sql
   
   DELETE FROM adeq145_tmp_02
   
   EXECUTE adeq145_ins_tmp2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "ERROR:adeq145_ins_tmp2"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF 
 
   #更新本期消費標記
   UPDATE adeq145_tmp_02
      SET txn_n = 'Y'
    WHERE (rtjadocdt >= g_master.l_date_s AND rtjadocdt <= g_master.l_date_e)
    
   #更新同筆消費標記
   UPDATE adeq145_tmp_02
      SET txn_o = 'Y'
    WHERE (rtjadocdt >= g_date_s_o AND rtjadocdt <= g_date_e_o)  

   #本期欲統計的組織(銷售組織+開卡組織)
   DELETE FROM adeq145_tmp_03   
   
   INSERT INTO adeq145_tmp_03(ooef001)
   SELECT UNIQUE rtjasite
     FROM adeq145_tmp_02
    WHERE rtjadocdt >= g_master.l_date_s 
      AND rtjadocdt <= g_master.l_date_e
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "Insert1:adeq145_tmp_03"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF 
   
   INSERT INTO adeq145_tmp_03(ooef001)
   SELECT UNIQUE mmaq024
     FROM adeq145_tmp_01
    WHERE (eff_n = 'Y'   #本期有效卡的開卡組織
         OR ((mman018 = 'Y' AND mmaq025 >= g_master.l_date_s) OR mman018 = 'N')    #本期開卡的開卡組織
          )
      AND mmaq024 NOT IN (SELECT ooef001 FROM adeq145_tmp_03)
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "Insert2:adeq145_tmp_03"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
   END IF    
   
   #161129-00032#2 161129 by lori add---(S)   
   #本期-有效會員卡總數
   DELETE FROM adeq145_tmp_04
   
   LET l_sql = "INSERT INTO adeq145_tmp_04(mmaq001,mmaq024) ",
               "SELECT UNIQUE mmaq001,mmaq024 ",
               "  FROM (SELECT mmaq001,mmaq024 FROM adeq145_tmp_01 WHERE eff_n = 'Y' ",
               "        UNION ALL ",
               "        SELECT rtja001 mmaq001,rtjasite mmaq024 FROM adeq145_tmp_02 WHERE txn_n = 'Y') "
   PREPARE adeq145_ins_tmp4 FROM l_sql
   EXECUTE adeq145_ins_tmp4
   FREE adeq145_ins_tmp4   
              
   #去年同期-有效會員卡總數
   DELETE FROM adeq145_tmp_05
   
   LET l_sql = "INSERT INTO adeq145_tmp_05(mmaq001,mmaq024) ",
               "SELECT UNIQUE mmaq001,mmaq024 ",
               "  FROM (SELECT mmaq001,mmaq024 FROM adeq145_tmp_01 WHERE eff_o = 'Y' ",
               "        UNION ALL ",
               "        SELECT rtja001 mmaq001,rtjasite mmaq024 FROM adeq145_tmp_02 WHERE txn_o = 'Y') "
   PREPARE adeq145_ins_tmp5 FROM l_sql
   EXECUTE adeq145_ins_tmp5
   FREE adeq145_ins_tmp5 
   
   #本期-曾消費會員卡張數   
   DELETE FROM adeq145_tmp_06
   
   INSERT INTO adeq145_tmp_06(rtja001,rtjasite)
      SELECT UNIQUE rtja001,rtjasite FROM adeq145_tmp_02 WHERE txn_n = 'Y' AND rtja031 >= 0
      
   #去年同期-曾消費會員卡張數
   DELETE FROM adeq145_tmp_07
   
   INSERT INTO adeq145_tmp_07(rtja001,rtjasite)
      SELECT UNIQUE rtja001,rtjasite FROM adeq145_tmp_02 WHERE txn_o = 'Y' AND rtja031 >= 0 
      
   #本期-會員消費次數
   DELETE FROM adeq145_tmp_08
   
   INSERT INTO adeq145_tmp_08(rtjadocno,rtjasite)
      SELECT UNIQUE rtjadocno,rtjasite FROM adeq145_tmp_02 WHERE txn_n = 'Y' AND rtja031 >= 0
      
   #本期-會員消費次數
   DELETE FROM adeq145_tmp_09
   
   INSERT INTO adeq145_tmp_09(rtjadocno,rtjasite)
      SELECT UNIQUE rtjadocno,rtjasite FROM adeq145_tmp_02 WHERE txn_o = 'Y' AND rtja031 >= 0   
   #161129-00032#2 161129 by lori add---(E)
       
END FUNCTION

################################################################################
# Descriptions...: 統計資料單身填充
# Memo...........: 因樣板產生 adeq145_b_fill() 架構不合需求,因此另寫函式處理
# Usage..........: CALL adeq145_b_fill_new()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2016/10/18 By Lori
# Modify.........:
################################################################################
PRIVATE FUNCTION adeq145_b_fill_new()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   DEFINE l_org_wc        STRING
   
   
   IF g_requery THEN
      CALL adeq145_ins_tmp()  
      LET g_requery = FALSE 
   ELSE
      RETURN   
   END IF

   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"  
   ELSE
      #畫面欄位為 rtjasite,TEMP欄位為ooef001,因此需要做字串置換
      LET g_wc_filter = cl_replace_str(g_wc_filter,"rtjasite","ooef001")    
   END IF

   CALL g_rtja_d.clear()
   CALL g_rtja2_d.clear() 
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   #畫面欄位為 rtjasite,TEMP欄位為ooef001,因此需要做字串置換
   LET l_org_wc = cl_replace_str(g_wc,"rtjasite","ooef001") 
   
   #b_fill段sql組成及FOREACH撰寫
   LET ls_sql_rank = "SELECT '', rtjasite,rtjasite_desc, ",
                     "       piece_n, consumption_n, sale_n, ",
                     "       (CASE WHEN piece_n = 0 THEN 0 ELSE (consumption_n/piece_n)*100 END) survival_rate_n, ",
                     "       piece_o, consumption_o, sale_o, ",
                     "       (CASE WHEN piece_o = 0 THEN 0 ELSE (consumption_o/piece_o)*100 END) survival_rate_o ",
                     "  FROM ( ",
                             #所有門店
                     "         SELECT 0 seq, ",
                     "         'ALL' rtjasite, ",
                     "         '' rtjasite_desc, ",
                     "         (SELECT COUNT(mmaq001) FROM (SELECT UNIQUE mmaq001 ",                              #本期-有效會員卡總數
                     "                                        FROM ((SELECT mmaq001 FROM adeq145_tmp_01 WHERE eff_n = 'Y') ",
                     "                                               UNION ALL ",
                     "                                              (SELECT rtja001 mmaq001 FROM adeq145_tmp_02 WHERE txn_n = 'Y')) ",
                     "                                     )) piece_n, ",
                     "         (SELECT COUNT(mmaq001) FROM (SELECT UNIQUE mmaq001 ",                              #去年同期-有效會員卡總數
                     "                                        FROM ((SELECT mmaq001 FROM adeq145_tmp_01 WHERE eff_o = 'Y') ",
                     "                                               UNION ALL ",
                     "                                              (SELECT rtja001 mmaq001 FROM adeq145_tmp_02 WHERE txn_o = 'Y')) ",
                     "                                     )) piece_o, ",                     
                     "         (SELECT COUNT(rtja001) ",                                                          #本期-曾消費會員卡張數
                     "            FROM (SELECT UNIQUE rtja001 FROM adeq145_tmp_02 WHERE txn_n = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_n = 'Y') ",   #161207-00021#1 161206 by lori mark
                     "                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE eff_n = 'Y') ",                          #161207-00021#1 161206 by lori add
                     "                     AND rtja031 >= 0 ",
                     "                 )) consumption_n, ",
                     "         (SELECT COUNT(rtja001) ",                                                          #去年同期-曾消費會員卡張數
                     "            FROM (SELECT UNIQUE rtja001 FROM adeq145_tmp_02 WHERE txn_o = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_o = 'Y') ",   #161207-00021#1 161207 by lori mark
                     "                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE eff_o = 'Y') ",                          #161207-00021#1 161207 by lori add
                     "                     AND rtja031 >= 0 ",
                     "                 )) consumption_o, ",
                     "         (SELECT COUNT(rtjadocno) ",                                                        #本期-會員消費次數
                     "            FROM (SELECT UNIQUE rtjadocno FROM adeq145_tmp_02 WHERE txn_n = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_n = 'Y') ",   #161207-00021#1 161207 by lori mark
                     "                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE eff_n = 'Y') ",                          #161207-00021#1 161207 by lori add
                     "                     AND rtja031 >=0 ",
                     "                 )) sale_n, ",
                     "         (SELECT COUNT(rtjadocno) ",                                                        #去年同期-會員消費次數
                     "            FROM (SELECT UNIQUE rtjadocno FROM adeq145_tmp_02 WHERE txn_o = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_o = 'Y') ",   #161207-00021#1 161207 by lori mark
                     "                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE eff_o = 'Y') ",                          #161207-00021#1 161207 by lori add
                     "                     AND rtja031 >= 0 ",
                     "                  )) sale_o ",
                     "         FROM DUAL ",
                     "         UNION ALL ",
                             #各銷售門店
                     "         SELECT ROW_NUMBER() OVER (ORDER BY ooef001) seq, ", 
                     "         ooef001 rtja001, ",
                     "         (SELECT ooefl003 FROM ooefl_t ",                                                  
                     "           WHERE ooeflent = ",g_enterprise," AND ooefl001 = ooef001 AND ooefl002 = '",g_dlang,"') rtja001_desc, ",
                    #161129-00032#2 161129 by lori add---(S)
                    #"         (SELECT COUNT(mmaq001) FROM (SELECT UNIQUE mmaq001 ",                                             #本期-有效會員卡總數
                    #"                                        FROM ((SELECT mmaq001 FROM adeq145_tmp_01 WHERE mmaq024 = ooef001 AND eff_n = 'Y') ",
                    #"                                               UNION ALL ",
                    #"                                              (SELECT rtja001 mmaq001 FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_n = 'Y')) ",
                    #"                                     )) piece_n, ",
                    #"         (SELECT COUNT(mmaq001) FROM (SELECT UNIQUE mmaq001 ",                                             #去年同期-有效會員卡總數
                    #"                                        FROM ((SELECT mmaq001 FROM adeq145_tmp_01 WHERE mmaq024 = ooef001 AND eff_o = 'Y') ",
                    #"                                               UNION ALL ",
                    #"                                              (SELECT rtja001 mmaq001 FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_o = 'Y')) ",
                    #"                                     )) piece_o, ",                     
                    #"         (SELECT COUNT(rtja001) ",                                                                         #本期-曾消費會員卡張數
                    #"            FROM (SELECT UNIQUE rtja001 FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_n = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_n = 'Y') ",
                    #"                     AND rtja031 >= 0 )) consumption_n, ",
                    #"         (SELECT COUNT(rtja001) ",                                                                         #去年同期-曾消費會員卡張數  
                    #"            FROM (SELECT UNIQUE rtja001 FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_o = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_o = 'Y') ",
                    #"                     AND rtja031 >= 0 )) consumption_o, ",
                    #"         (SELECT COUNT(rtjadocno) ",                                                                       #本期-會員消費次數
                    #"            FROM (SELECT UNIQUE rtjadocno FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_n = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_n = 'Y') ",
                    #"                     AND rtja031 >= 0 )) sale_n, ",
                    #"         (SELECT COUNT(rtjadocno) ",                                                                       #去年同期-會員消費次數
                    #"            FROM (SELECT UNIQUE rtjadocno FROM adeq145_tmp_02 WHERE rtjasite = ooef001 AND txn_o = 'Y' ",
                    #"                     AND EXISTS(SELECT 1 FROM adeq145_tmp_01 WHERE mmaq024 = rtjasite AND eff_o = 'Y') ",
                    #"                     AND rtja031 >= 0)) sale_o ", 
                    #161129-00032#2 161129 by lori add---(E) 

                    #161129-00032#2 161129 by lori add---(S)
                    "          (SELECT COUNT(mmaq001) FROM adeq145_tmp_04 WHERE mmaq024 = ooef001) piece_n,        ",   #本期-有效會員卡總數
                    "          (SELECT COUNT(mmaq001) FROM adeq145_tmp_05 WHERE mmaq024 = ooef001) piece_o,        ",   #去年同期-有效會員卡總數              
                    "          (SELECT COUNT(rtja001) FROM adeq145_tmp_06 WHERE rtjasite = ooef001) consumption_n, ",   #本期-曾消費會員卡張數 
                    "          (SELECT COUNT(rtja001) FROM adeq145_tmp_07 WHERE rtjasite = ooef001) consumption_o, ",   #去年同期-曾消費會員卡張數
                    "          (SELECT COUNT(rtjadocno) FROM adeq145_tmp_08 WHERE rtjasite = ooef001) sale_n,      ",   #本期-會員消費次數
                    "          (SELECT COUNT(rtjadocno) FROM adeq145_tmp_09 WHERE rtjasite = ooef001) sale_o       ",   #本期-會員消費次數
                    #161129-00032#2 161129 by lori add---(E)
                     "         FROM adeq145_tmp_03 ",
                     "        WHERE ooef001 IS NOT NULL ",
                     "          AND ",l_org_wc,
                     ") t1 ",
                     "ORDER BY seq "
                     
  #DISPLAY "[ls_sql_rank] ",ls_sql_rank
   
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
   PREPARE b_fill_cnt_pre1 FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre1 INTO g_tot_cnt
   FREE b_fill_cnt_pre1

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
   
   LET g_sql = "SELECT '', rtjasite,rtjasite_desc,piece_n, consumption_n, sale_n,survival_rate_n, ",
               "       rtjasite,rtjasite_desc,piece_o, consumption_o, sale_o,survival_rate_o ",
               "  FROM (",ls_sql_rank,")"
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
  #DISPLAY "[adeq145_pb1] ",g_sql   
   PREPARE adeq145_pb1 FROM g_sql
   DECLARE b_fill_curs1 CURSOR FOR adeq145_pb1
 
   FOREACH b_fill_curs1 INTO g_rtja_d[l_ac].sel,              g_rtja_d[l_ac].rtjasite,        g_rtja_d[l_ac].rtjasite_desc, 
                             g_rtja_d[l_ac].l_piece_n,        g_rtja_d[l_ac].l_consumption_n, g_rtja_d[l_ac].l_sale_n,
                             g_rtja_d[l_ac].l_survival_rate_n,g_rtja2_d[l_ac].l_rtjasite_o,   g_rtja2_d[l_ac].l_rtjasite_o_desc,
                             g_rtja2_d[l_ac].l_piece_o,       g_rtja2_d[l_ac].l_consumption_o,g_rtja2_d[l_ac].l_sale_o, 
                             g_rtja2_d[l_ac].l_survival_rate_o
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:b_fill_curs1" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

     IF cl_null(g_rtja_d[l_ac].l_piece_n) THEN             LET g_rtja_d[l_ac].l_piece_n          = 0       END IF
     IF cl_null(g_rtja_d[l_ac].l_consumption_n) THEN       LET g_rtja_d[l_ac].l_consumption_n    = 0       END IF
     IF cl_null(g_rtja_d[l_ac].l_sale_n) THEN              LET g_rtja_d[l_ac].l_sale_n           = 0       END IF
     IF cl_null(g_rtja_d[l_ac].l_survival_rate_n) THEN     LET g_rtja_d[l_ac].l_survival_rate_n  = 0       END IF

     IF cl_null(g_rtja2_d[l_ac].l_piece_o) THEN             LET g_rtja2_d[l_ac].l_piece_o          = 0       END IF
     IF cl_null(g_rtja2_d[l_ac].l_consumption_o) THEN       LET g_rtja2_d[l_ac].l_consumption_o    = 0       END IF
     IF cl_null(g_rtja2_d[l_ac].l_sale_o) THEN              LET g_rtja2_d[l_ac].l_sale_o           = 0       END IF
     IF cl_null(g_rtja2_d[l_ac].l_survival_rate_o) THEN     LET g_rtja2_d[l_ac].l_survival_rate_o  = 0       END IF
     #CALL adeq145_detail_show("'1'") 
      CALL adeq145_rtja_t_mask()
 
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
   
   CALL g_rtja_d.deleteElement(g_rtja_d.getLength())
   CALL g_rtja2_d.deleteElement(g_rtja2_d.getLength())    
   
   LET g_error_show = 0
 
   LET g_detail_cnt = g_rtja_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0

   #b_fill段CURSOR釋放
   FREE adeq145_pb1
   
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq145_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq145_detail_action_trans()
 
   LET l_ac = 1
   IF g_rtja_d.getLength() > 0 THEN
      CALL adeq145_b_fill2()
   END IF
 
   CALL adeq145_filter_show('rtjasite','b_rtjasite')
END FUNCTION

 
{</section>}
 
