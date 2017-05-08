#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq101.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-08-26 16:16:35), PR版次:0001(2016-10-11 17:57:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000006
#+ Filename...: apmq101
#+ Description: 交易對象變更記錄查詢
#+ Creator....: 02295(2016-08-26 16:16:35)
#+ Modifier...: 02295 -SD/PR- 02295
 
{</section>}
 
{<section id="apmq101.global" >}
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
PRIVATE TYPE type_g_pmaa_d RECORD
       
       sel LIKE type_t.chr1, 
   pmaa001 LIKE pmaa_t.pmaa001, 
   pmaa001_desc LIKE type_t.chr500, 
   pmaa002 LIKE pmaa_t.pmaa002, 
   pmaa004 LIKE pmaa_t.pmaa004, 
   pmaa005 LIKE pmaa_t.pmaa005, 
   pmaa005_desc LIKE type_t.chr500, 
   pmaa006 LIKE pmaa_t.pmaa006, 
   pmaa006_desc LIKE type_t.chr500, 
   pmaa026 LIKE pmaa_t.pmaa026, 
   pmaa026_desc LIKE type_t.chr500, 
   pmaa080 LIKE pmaa_t.pmaa080, 
   pmaa080_desc LIKE type_t.chr500, 
   pmaa083 LIKE pmaa_t.pmaa083, 
   pmaa083_desc LIKE type_t.chr500, 
   pmaa090 LIKE pmaa_t.pmaa090, 
   pmaa090_desc LIKE type_t.chr500, 
   pmaa093 LIKE pmaa_t.pmaa093, 
   pmaa093_desc LIKE type_t.chr500
       END RECORD
PRIVATE TYPE type_g_pmaa2_d RECORD
       seq LIKE type_t.chr500, 
   dzeb002 LIKE dzeb_t.dzeb002, 
   dzeb002_desc LIKE type_t.chr500, 
   logc004 LIKE logc_t.logc004, 
   logc006 LIKE logc_t.logc006, 
   logc005 LIKE logc_t.logc005, 
   logc005_desc LIKE type_t.chr500, 
   logc002 LIKE logc_t.logc002, 
   logc002_desc LIKE type_t.chr500, 
   logc001 LIKE logc_t.logc001, 
   logc001_desc LIKE type_t.chr500, 
   logc003 LIKE logc_t.logc003
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_qbe      STRING
DEFINE g_col      STRING
DEFINE g_dt       STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmaa_d            DYNAMIC ARRAY OF type_g_pmaa_d
DEFINE g_pmaa_d_t          type_g_pmaa_d
DEFINE g_pmaa2_d     DYNAMIC ARRAY OF type_g_pmaa2_d
DEFINE g_pmaa2_d_t   type_g_pmaa2_d
 
 
 
 
 
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
 
{<section id="apmq101.main" >}
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
   CALL cl_ap_init("apm","")
 
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
   DECLARE apmq101_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq101_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq101_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq101 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq101_init()   
 
      #進入選單 Menu (="N")
      CALL apmq101_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq101
      
   END IF 
   
   CLOSE apmq101_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apmq101_logc_tmp;
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq101.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq101_init()
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
   
      CALL cl_set_combo_scc('b_pmaa002','2014') 
   CALL cl_set_combo_scc('b_pmaa004','2015') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('pmaa002','2014') 
   CALL cl_set_combo_scc('pmaa004','2015')
   CALL apmq101_create_temp()
   #end add-point
 
   CALL apmq101_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq101.default_search" >}
PRIVATE FUNCTION apmq101_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmaa001 = '", g_argv[01], "' AND "
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
 
{<section id="apmq101.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq101_ui_dialog() 
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
 
   
   CALL apmq101_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmaa_d.clear()
         CALL g_pmaa2_d.clear()
 
 
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
 
         CALL apmq101_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmaa001,pmaa002,pmaa004,pmaa005,pmaa006,
                                   pmaa026,pmaa080,pmaa083,pmaa090,pmaa093
     
            BEFORE CONSTRUCT

            ON ACTION controlp INFIELD pmaa001
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_5()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa001  #顯示到畫面上
               NEXT FIELD pmaa001                     #返回原欄位
 
            ON ACTION controlp INFIELD pmaa005
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001_4()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa005  #顯示到畫面上
               NEXT FIELD pmaa005                     #返回原欄位

            ON ACTION controlp INFIELD pmaa006
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '261'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa006  #顯示到畫面上
               NEXT FIELD pmaa006                     #返回原欄位

            ON ACTION controlp INFIELD pmaa026
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '250'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa026  #顯示到畫面上
               NEXT FIELD pmaa026
               
            ON ACTION controlp INFIELD pmaa080
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '251'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa080  #顯示到畫面上
               NEXT FIELD pmaa080                     #返回原欄位

            ON ACTION controlp INFIELD pmaa083
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '255'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa083  #顯示到畫面上
               NEXT FIELD pmaa083                     #返回原欄位

            ON ACTION controlp INFIELD pmaa090
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '281'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa090  #顯示到畫面上
               NEXT FIELD pmaa090                     #返回原欄位

            ON ACTION controlp INFIELD pmaa093
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '285'
               CALL q_oocq002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmaa093  #顯示到畫面上
               NEXT FIELD pmaa093                     #返回原欄位

         END CONSTRUCT
         CONSTRUCT BY NAME g_col ON dzeb002

            BEFORE CONSTRUCT
               LET g_qbe = NULL
               LET g_col = NULL
               
            ON ACTION controlp INFIELD dzeb002
            
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " dzeb001 LIKE 'pma%' "
               CALL q_dzeb002_10()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO dzeb002      #顯示到畫面上
               LET g_col = g_qryparam.return1 
               NEXT FIELD dzeb002 
             
            AFTER CONSTRUCT
               #LET g_qbe = p_dialog.getFieldBuffer('dzeb002')
            
            
         END CONSTRUCT   
         
         CONSTRUCT BY NAME g_dt ON logc003

            BEFORE CONSTRUCT
             
            AFTER FIELD logc003
               CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
               IF NOT cl_null(ls_result) THEN
                  IF NOT cl_chk_date_symbol(ls_result) THEN
                     LET ls_result = cl_add_date_extra_cond(ls_result)
                  END IF
               END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result) 
            
            AFTER CONSTRUCT
        
            
         END CONSTRUCT           
         #end add-point
     
         DISPLAY ARRAY g_pmaa_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq101_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq101_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_pmaa2_d TO s_detail2.*
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
            CALL apmq101_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD pmaa001
 
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
            CALL apmq101_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmaa_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmaa2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq101_b_fill()
 
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
            CALL apmq101_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq101_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq101_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq101_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               LET g_pmaa_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               LET g_pmaa_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmaa_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmaa_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmaa_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq101_filter()
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
 
{<section id="apmq101.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq101_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL apmq101_b1_fill()
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
 
   CALL g_pmaa_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmaa001,'',pmaa002,pmaa004,pmaa005,'',pmaa006,'',pmaa026,'', 
       pmaa080,'',pmaa083,'',pmaa090,'',pmaa093,''  ,DENSE_RANK() OVER( ORDER BY pmaa_t.pmaa001) AS RANK FROM pmaa_t", 
 
 
#table2
                     " LEFT JOIN logc_t ON logcent = pmaaent AND",
 
                     "",
                     " WHERE pmaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmaa_t"),
                     " ORDER BY pmaa_t.pmaa001"
 
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
 
   LET g_sql = "SELECT '',pmaa001,'',pmaa002,pmaa004,pmaa005,'',pmaa006,'',pmaa026,'',pmaa080,'',pmaa083, 
       '',pmaa090,'',pmaa093,''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq101_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq101_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmaa_d[l_ac].sel,g_pmaa_d[l_ac].pmaa001,g_pmaa_d[l_ac].pmaa001_desc,g_pmaa_d[l_ac].pmaa002, 
       g_pmaa_d[l_ac].pmaa004,g_pmaa_d[l_ac].pmaa005,g_pmaa_d[l_ac].pmaa005_desc,g_pmaa_d[l_ac].pmaa006, 
       g_pmaa_d[l_ac].pmaa006_desc,g_pmaa_d[l_ac].pmaa026,g_pmaa_d[l_ac].pmaa026_desc,g_pmaa_d[l_ac].pmaa080, 
       g_pmaa_d[l_ac].pmaa080_desc,g_pmaa_d[l_ac].pmaa083,g_pmaa_d[l_ac].pmaa083_desc,g_pmaa_d[l_ac].pmaa090, 
       g_pmaa_d[l_ac].pmaa090_desc,g_pmaa_d[l_ac].pmaa093,g_pmaa_d[l_ac].pmaa093_desc
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
 
      CALL apmq101_detail_show("'1'")
 
      CALL apmq101_pmaa_t_mask()
 
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
 
   CALL g_pmaa_d.deleteElement(g_pmaa_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq101_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq101_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq101_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmaa_d.getLength() > 0 THEN
      CALL apmq101_b_fill2()
   END IF
 
      CALL apmq101_filter_show('pmaa001','b_pmaa001')
   CALL apmq101_filter_show('pmaa002','b_pmaa002')
   CALL apmq101_filter_show('pmaa004','b_pmaa004')
   CALL apmq101_filter_show('pmaa005','b_pmaa005')
   CALL apmq101_filter_show('pmaa006','b_pmaa006')
   CALL apmq101_filter_show('pmaa026','b_pmaa026')
   CALL apmq101_filter_show('pmaa080','b_pmaa080')
   CALL apmq101_filter_show('pmaa083','b_pmaa083')
   CALL apmq101_filter_show('pmaa090','b_pmaa090')
   CALL apmq101_filter_show('pmaa093','b_pmaa093')
   CALL apmq101_filter_show('logc004','b_logc004')
   CALL apmq101_filter_show('logc006','b_logc006')
   CALL apmq101_filter_show('logc005','b_logc005')
   CALL apmq101_filter_show('logc002','b_logc002')
   CALL apmq101_filter_show('logc001','b_logc001')
   CALL apmq101_filter_show('logc003','b_logc003')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq101.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq101_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   CALL apmq101_b1_fill2()
   RETURN
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_pmaa2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"

   
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','',logc004,logc006,logc005,'',logc002,'',logc001,'',logc003 FROM logc_t", 
 
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY "
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq101_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq101_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_pmaa_d[g_detail_idx].pmaa001
 
      INTO g_pmaa2_d[l_ac].seq,g_pmaa2_d[l_ac].dzeb002,g_pmaa2_d[l_ac].dzeb002_desc,g_pmaa2_d[l_ac].logc004, 
          g_pmaa2_d[l_ac].logc006,g_pmaa2_d[l_ac].logc005,g_pmaa2_d[l_ac].logc005_desc,g_pmaa2_d[l_ac].logc002, 
          g_pmaa2_d[l_ac].logc002_desc,g_pmaa2_d[l_ac].logc001,g_pmaa2_d[l_ac].logc001_desc,g_pmaa2_d[l_ac].logc003 
 
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
 
      CALL apmq101_detail_show("'2'")
 
      CALL apmq101_logc_t_mask()
 
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
   CALL g_pmaa2_d.deleteElement(g_pmaa2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_pmaa2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq101.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq101_detail_show(ps_page)
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
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq101.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq101_filter()
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
      CONSTRUCT g_wc_filter ON pmaa001,pmaa002,pmaa004,pmaa005,pmaa006,pmaa026,pmaa080,pmaa083,pmaa090, 
          pmaa093
                          FROM s_detail1[1].b_pmaa001,s_detail1[1].b_pmaa002,s_detail1[1].b_pmaa004, 
                              s_detail1[1].b_pmaa005,s_detail1[1].b_pmaa006,s_detail1[1].b_pmaa026,s_detail1[1].b_pmaa080, 
                              s_detail1[1].b_pmaa083,s_detail1[1].b_pmaa090,s_detail1[1].b_pmaa093
 
         BEFORE CONSTRUCT
                     DISPLAY apmq101_filter_parser('pmaa001') TO s_detail1[1].b_pmaa001
            DISPLAY apmq101_filter_parser('pmaa002') TO s_detail1[1].b_pmaa002
            DISPLAY apmq101_filter_parser('pmaa004') TO s_detail1[1].b_pmaa004
            DISPLAY apmq101_filter_parser('pmaa005') TO s_detail1[1].b_pmaa005
            DISPLAY apmq101_filter_parser('pmaa006') TO s_detail1[1].b_pmaa006
            DISPLAY apmq101_filter_parser('pmaa026') TO s_detail1[1].b_pmaa026
            DISPLAY apmq101_filter_parser('pmaa080') TO s_detail1[1].b_pmaa080
            DISPLAY apmq101_filter_parser('pmaa083') TO s_detail1[1].b_pmaa083
            DISPLAY apmq101_filter_parser('pmaa090') TO s_detail1[1].b_pmaa090
            DISPLAY apmq101_filter_parser('pmaa093') TO s_detail1[1].b_pmaa093
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmaa001>>----
         #Ctrlp:construct.c.page1.b_pmaa001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa001
            #add-point:ON ACTION controlp INFIELD b_pmaa001 name="construct.c.filter.page1.b_pmaa001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa001  #顯示到畫面上
            NEXT FIELD b_pmaa001                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa001_desc>>----
         #----<<b_pmaa002>>----
         #Ctrlp:construct.c.filter.page1.b_pmaa002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa002
            #add-point:ON ACTION controlp INFIELD b_pmaa002 name="construct.c.filter.page1.b_pmaa002"
            
            #END add-point
 
 
         #----<<b_pmaa004>>----
         #Ctrlp:construct.c.filter.page1.b_pmaa004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa004
            #add-point:ON ACTION controlp INFIELD b_pmaa004 name="construct.c.filter.page1.b_pmaa004"
            
            #END add-point
 
 
         #----<<b_pmaa005>>----
         #Ctrlp:construct.c.page1.b_pmaa005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa005
            #add-point:ON ACTION controlp INFIELD b_pmaa005 name="construct.c.filter.page1.b_pmaa005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa005  #顯示到畫面上
            NEXT FIELD b_pmaa005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa005_desc>>----
         #----<<b_pmaa006>>----
         #Ctrlp:construct.c.page1.b_pmaa006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa006
            #add-point:ON ACTION controlp INFIELD b_pmaa006 name="construct.c.filter.page1.b_pmaa006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa006  #顯示到畫面上
            NEXT FIELD b_pmaa006                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa006_desc>>----
         #----<<b_pmaa026>>----
         #Ctrlp:construct.c.page1.b_pmaa026
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa026
            #add-point:ON ACTION controlp INFIELD b_pmaa026 name="construct.c.filter.page1.b_pmaa026"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa026  #顯示到畫面上
            NEXT FIELD b_pmaa026                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa026_desc>>----
         #----<<b_pmaa080>>----
         #Ctrlp:construct.c.page1.b_pmaa080
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa080
            #add-point:ON ACTION controlp INFIELD b_pmaa080 name="construct.c.filter.page1.b_pmaa080"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa080  #顯示到畫面上
            NEXT FIELD b_pmaa080                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa080_desc>>----
         #----<<b_pmaa083>>----
         #Ctrlp:construct.c.page1.b_pmaa083
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa083
            #add-point:ON ACTION controlp INFIELD b_pmaa083 name="construct.c.filter.page1.b_pmaa083"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa083  #顯示到畫面上
            NEXT FIELD b_pmaa083                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa083_desc>>----
         #----<<b_pmaa090>>----
         #Ctrlp:construct.c.page1.b_pmaa090
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa090
            #add-point:ON ACTION controlp INFIELD b_pmaa090 name="construct.c.filter.page1.b_pmaa090"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa090  #顯示到畫面上
            NEXT FIELD b_pmaa090                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa090_desc>>----
         #----<<b_pmaa093>>----
         #Ctrlp:construct.c.page1.b_pmaa093
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmaa093
            #add-point:ON ACTION controlp INFIELD b_pmaa093 name="construct.c.filter.page1.b_pmaa093"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmaa093  #顯示到畫面上
            NEXT FIELD b_pmaa093                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_pmaa093_desc>>----
 
 
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
 
      CALL apmq101_filter_show('pmaa001','b_pmaa001')
   CALL apmq101_filter_show('pmaa002','b_pmaa002')
   CALL apmq101_filter_show('pmaa004','b_pmaa004')
   CALL apmq101_filter_show('pmaa005','b_pmaa005')
   CALL apmq101_filter_show('pmaa006','b_pmaa006')
   CALL apmq101_filter_show('pmaa026','b_pmaa026')
   CALL apmq101_filter_show('pmaa080','b_pmaa080')
   CALL apmq101_filter_show('pmaa083','b_pmaa083')
   CALL apmq101_filter_show('pmaa090','b_pmaa090')
   CALL apmq101_filter_show('pmaa093','b_pmaa093')
   CALL apmq101_filter_show('logc004','b_logc004')
   CALL apmq101_filter_show('logc006','b_logc006')
   CALL apmq101_filter_show('logc005','b_logc005')
   CALL apmq101_filter_show('logc002','b_logc002')
   CALL apmq101_filter_show('logc001','b_logc001')
   CALL apmq101_filter_show('logc003','b_logc003')
 
 
   CALL apmq101_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq101.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq101_filter_parser(ps_field)
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
 
{<section id="apmq101.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq101_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq101_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq101.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq101_detail_action_trans()
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
 
{<section id="apmq101.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq101_detail_index_setting()
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
            IF g_pmaa_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmaa_d.getLength() AND g_pmaa_d.getLength() > 0
            LET g_detail_idx = g_pmaa_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmaa_d.getLength() THEN
               LET g_detail_idx = g_pmaa_d.getLength()
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
 
{<section id="apmq101.mask_functions" >}
 &include "erp/apm/apmq101_mask.4gl"
 
{</section>}
 
{<section id="apmq101.other_function" readonly="Y" >}

PRIVATE FUNCTION apmq101_create_temp()
   DROP TABLE apmq101_logc_tmp;
   CREATE TEMP TABLE apmq101_logc_tmp(
   l_seq        INTEGER,
   l_type       VARCHAR(2),
   l_column     VARCHAR(100),          #logc004
   l_value      VARCHAR(500),
   l_value_t    VARCHAR(500),
   logc005      VARCHAR(10),
   logc002      VARCHAR(20),
   logc001      VARCHAR(20),
   logc003      DATETIME YEAR TO SECOND,
   logcent      SMALLINT
   )
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
PRIVATE FUNCTION apmq101_ins_temp()
DEFINE l_sql      STRING
DEFINE l_upd_sql  STRING
DEFINE l_date_sql STRING   #用来获取变更时间
DEFINE l_table    STRING
DEFINE l_tmp      STRING
DEFINE l_length   LIKE type_t.num10
DEFINE l_start    LIKE type_t.num10
DEFINE l_end      LIKE type_t.num10
DEFINE l_logc RECORD  #修改歷程記錄表
   logc001 LIKE logc_t.logc001, #员工编号
   logc002 LIKE logc_t.logc002, #程序编号
   logc003 DATETIME YEAR TO SECOND, #事件时间
   logc004 LIKE logc_t.logc004, #旧值
   logc005 LIKE logc_t.logc005, #事件营运据点
   logc006 LIKE logc_t.logc006, #新值
   logcent LIKE logc_t.logcent, #企业编号
   logc007 LIKE logc_t.logc007, #行为编号
   logc008 LIKE logc_t.logc008  #key值旧值
END RECORD
DEFINE l_ac       LIKE type_t.num10 #记录序号
DEFINE l_cnt      LIKE type_t.num10
DEFINE l_column   LIKE type_t.chr100   #变更前栏位
DEFINE l_column_t LIKE type_t.chr100   #变更后栏位
DEFINE l_value    LIKE type_t.chr500   #变更前值
DEFINE l_value_t  LIKE type_t.chr500   #变更后值
DEFINE tok                 base.StringTokenizer

   #1.建立一temp table，記錄seq、變更欄位、變更前資料、變更後資料、變更據點、變更作業、變更人員、變更日期
   DELETE FROM apmq101_logc_tmp
   #解析过滤条件     
   #2.根據上單身的料件，抓取logc_t的資料
   #  過濾條件
   #  logcent = g_enterprise
   #  logc006 LIKE '%'||'"pma_001":"'||上單身指定的料件||'"%' <--- 查詢含有pma_001的字串 ex."pmaa001":"YS01"、"pmab001":"YS01"
   #
   #  SELECT ... FROM logc_t
   #   WHERE logcent = g_enterprise
   #     AND logc006 LIKE '%'||'"pma_001":"'||上單身指定的料件||'"%'
   #     AND logc003 = QBE的變更日期
   #logc006 例子：{"pmaa001":"5566NO5"}
   LET l_sql = " SELECT * FROM logc_t ",
               "  WHERE logcent = ",g_enterprise,
               "    AND (logc006 LIKE '%\"pmaa001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmab001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmac001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmad001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmae001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmaf001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' ",   #用[\"]进行转义
               "     OR logc006 LIKE '%\"pmaj001\":\"",g_pmaa_d[g_detail_idx].pmaa001 CLIPPED,"\"%' )",   #用[\"]进行转义
               "    AND logc007 ='modify'",
               "    AND ",g_dt,
               "  ORDER BY logc003"
   DECLARE apmq101_logc_cur CURSOR FROM l_sql
   #3.讀取每筆logc_t資料
#  3.1 seq = seq+1
#  3.2 變更據點 = logc005
#  3.3 變更作業 = logc002
#  3.3 變更人員 = logc001
#  3.4 變更日期 = logc003 (若logc003只記錄到日期，那該欄位改成顯示pma_moddt)
#  3.5 拆解logc004的字串，記錄到變更欄位、變更前資料 (異動資訊的共用欄位不用記錄)
#      ex.{"pmaa001"="YS01","pmaa006":"KPCS"}   (這只是舉例)
#         拆解成兩筆新增到temp table
#         第一筆：變更欄位 = pmaa001、變更前資料 = YS01
#         第二筆：變更欄位 = pmaa006、變更前資料 = KPCS
#  3.2 拆解logc006的字串，記錄到變更欄位、變更後資料 (異動資訊的共用欄位不用記錄)
#      ex.{"pmaa001"="YS01","pmaa006":"PCS"}   (這只是舉例)
#         拆解成兩筆做下面判斷
#         第一筆：變更欄位 = pmaa001、變更前資料 = YS01
#         第二筆：變更欄位 = pmaa006、變更前資料 = PCS
#      3.2.1 檢查同seq、同欄位的變更前資料是否等於變更後資料
#      3.2.2 相同時，刪除該筆temp table資料
#      3.2.3 不相同時，更新該筆temp table變更後資料
   LET l_ac = 1
   FOREACH apmq101_logc_cur INTO l_logc.*
#3.讀取每筆logc_t資料
#  3.1 seq = seq+1
#  3.2 變更據點 = logc005
#  3.3 變更作業 = logc002
#  3.3 變更人員 = logc001
#  3.4 變更日期 = logc003 (若logc003只記錄到日期，那該欄位改成顯示pma_moddt)
#  3.5 拆解logc004的字串，記錄到變更欄位、變更前資料 (異動資訊的共用欄位不用記錄)
#      ex.{"pmaa001"="YS01","pmaa006":"KPCS"}   (這只是舉例)
#         拆解成兩筆新增到temp table
#         第一筆：變更欄位 = pmaa001、變更前資料 = YS01
#         第二筆：變更欄位 = pmaa006、變更前資料 = KPCS
#  3.2 拆解logc006的字串，記錄到變更欄位、變更後資料 (異動資訊的共用欄位不用記錄)
#      ex.{"pmaa001"="YS01","pmaa006":"PCS"}   (這只是舉例)
#         拆解成兩筆做下面判斷
#         第一筆：變更欄位 = pmaa001、變更前資料 = YS01
#         第二筆：變更欄位 = pmaa006、變更前資料 = PCS
#      3.2.1 檢查同seq、同欄位的變更前資料是否等於變更後資料
#      3.2.2 相同時，刪除該筆temp table資料
#      3.2.3 不相同時，更新該筆temp table變更後資料---->b_fill2
      IF NOT cl_null(l_logc.logc004) THEN
         LET l_tmp = l_logc.logc004
         LET l_length = l_tmp.getLength()
         LET l_tmp = l_tmp.subString(2,l_length)      #去除外面的{，最后的}作为判断依据
         #若有多个组在一起 {}{}，去除{}变成,
         LET l_tmp = cl_replace_str(l_tmp,'}{',',')
         LET l_length = l_tmp.getLength()
         LET l_end = 1
         WHILE l_end < l_length 
            LET l_start = l_tmp.getIndexOf('\"',l_end)+1
            IF l_start < 0 OR l_start = 0  THEN 
               EXIT WHILE
            END IF
            LET l_end = l_tmp.getIndexOf('\":',l_start)-1
            IF l_end < 0 OR l_end = 0  THEN 
               EXIT WHILE
            END IF
            LET l_column = l_tmp.subString(l_start,l_end)
            IF l_tmp.getIndexOf('\"',l_end+2)+1 = l_tmp.getIndexOf(':\"',l_end+2)+2 THEN
               LET l_start = l_tmp.getIndexOf('\"',l_end+2)+1     #需要考虑数值或chr的情况chr,资料呈现{\"pmaa001\":\"0000\"}
            ELSE
               LET l_start = l_tmp.getIndexOf(':',l_end+2)+1     #需要考虑数值或chr的情况num,资料呈现{\"pmaaent\":99}
            END IF
            IF l_start < 0 OR l_start = 0  THEN 
               EXIT WHILE
            END IF
            IF l_tmp.getIndexOf(',\"',l_start)-2 = l_tmp.getIndexOf('\",\"',l_start)-1 THEN
               LET l_end = l_tmp.getIndexOf(',\"',l_start)-2     #需要考虑数值或chr的情况chr,资料呈现{\"pmaa001\":\"0000\",\"pmaa002\":\"abc\"}
            ELSE
               LET l_end = l_tmp.getIndexOf(',\"',l_start)-1     #需要考虑数值或chr的情况num,资料呈现{\"pmaaent\":99,\"[pmaa001\":\"0000\"}
            END IF
            IF l_end < 0 OR l_end = 0 THEN 
               LET l_end = l_tmp.getIndexOf('\"}',l_start)-1
               IF l_end < 0 OR l_end = 0 THEN 
                  LET l_end = l_tmp.getIndexOf('}',l_start)-1
                  IF l_end < 0 OR l_end = 0 THEN 
                     EXIT WHILE
                  END IF
               END IF
            END IF
            LET l_value = l_tmp.subString(l_start,l_end)
            LET l_end = l_end + 2
            INSERT INTO apmq101_logc_tmp VALUES(l_ac,'1',l_column,l_value,NULL,l_logc.logc005,l_logc.logc002,l_logc.logc001,l_logc.logc003,l_logc.logcent)
         END WHILE
      END IF
      #变更前资料
      IF NOT cl_null(l_logc.logc006) THEN
         LET l_tmp = l_logc.logc006
         LET l_length = l_tmp.getLength()
         LET l_tmp = l_tmp.subString(2,l_length)      #去除外面的{，最后的}作为判断依据
         #若有多个组在一起 {}{}，去除{}变成,
         LET l_tmp = cl_replace_str(l_tmp,'}{',',')
         LET l_length = l_tmp.getLength()
         LET l_end = 1
         WHILE l_end < l_length 
            LET l_start = l_tmp.getIndexOf('\"',l_end)+1
            IF l_start < 0 OR l_start = 0  THEN 
               EXIT WHILE
            END IF
            LET l_end = l_tmp.getIndexOf('\":',l_start)-1
            IF l_end < 0 OR l_end = 0  THEN 
               EXIT WHILE
            END IF
            LET l_column_t = l_tmp.subString(l_start,l_end)
            IF l_tmp.getIndexOf('\"',l_end+2)+1 = l_tmp.getIndexOf(':\"',l_end+2)+2 THEN
               LET l_start = l_tmp.getIndexOf('\"',l_end+2)+1     #需要考虑数值或chr的情况chr,资料呈现{\"pmaa001\":\"0000\"}
            ELSE
               LET l_start = l_tmp.getIndexOf(':',l_end+2)+1      #需要考虑数值或chr的情况num,资料呈现{\"pmaaent\":99}
            END IF
            IF l_start < 0 OR l_start = 0  THEN 
               EXIT WHILE
            END IF
            IF l_tmp.getIndexOf(',\"',l_start)-2 = l_tmp.getIndexOf('\",\"',l_start)-1 THEN
               LET l_end = l_tmp.getIndexOf(',\"',l_start)-2     #需要考虑数值或chr的情况
            ELSE
               LET l_end = l_tmp.getIndexOf(',\"',l_start)-1     #需要考虑数值或chr的情况
            END IF
            IF l_end < 0 OR l_end = 0 THEN 
               LET l_end = l_tmp.getIndexOf('\"}',l_start)-1
               IF l_end < 0 OR l_end = 0 THEN 
                  LET l_end = l_tmp.getIndexOf('}',l_start)-1
                  IF l_end < 0 OR l_end = 0 THEN 
                     EXIT WHILE
                  END IF
               END IF
            END IF
            LET l_value_t = l_tmp.subString(l_start,l_end)
            LET l_end = l_end + 2
            INSERT INTO apmq101_logc_tmp VALUES(l_ac,'2',l_column_t,NULL,l_value_t,l_logc.logc005,l_logc.logc002,l_logc.logc001,l_logc.logc003,l_logc.logcent)
         END WHILE
      END IF
      LET l_upd_sql = " UPDATE apmq101_logc_tmp ",
                      " SET l_type = '1' ",
                      " WHERE l_seq = ",l_ac ,
                      " AND l_type = '2' ",
                      " AND l_column NOT IN (SELECT l_column FROM apmq101_logc_tmp WHERE l_seq = ",l_ac ," AND l_type = '1')"
      EXECUTE IMMEDIATE l_upd_sql  
      LET l_upd_sql = " MERGE INTO apmq101_logc_tmp A ", #区分变更前后有区别的资料
                      " USING (SELECT * FROM apmq101_logc_tmp WHERE l_type = '2') B ",
                      " ON ( A.l_seq = B.l_seq AND A.l_column = B.l_column AND NVL(A.l_value,'*') = NVL(B.l_value_t,'*') AND A.l_seq = ",l_ac," )",
                      " WHEN MATCHED THEN ",
                      "    UPDATE SET A.l_type = '3' "   #相同，待删,l_type设为‘3’，与变更后资料以示区别
      EXECUTE IMMEDIATE l_upd_sql
      LET l_upd_sql = " MERGE INTO apmq101_logc_tmp A ", #更新
                      " USING (SELECT * FROM apmq101_logc_tmp WHERE l_type = '2') B ",
                      " ON ( A.l_seq = B.l_seq AND A.l_column = B.l_column AND A.l_seq = ",l_ac," AND A.l_type = '1' )",
                      " WHEN MATCHED THEN ",
                      "    UPDATE SET A.l_value_t = B.l_value_t "  #区分出来前后有变化的资料，更新前后笔资料。
#                      " WHEN NOT MATCHED THEN ",
#                      "    INSERT VALUES (",l_ac,",'1',B.l_column,NULL,B.l_value_t,B.logc005,B.logc002,B.logc001,B.logc003,B.logcent) "
      
      EXECUTE IMMEDIATE l_upd_sql
      DELETE FROM apmq101_logc_tmp WHERE l_type = '2' OR l_type = '3'   #删去不符合的资料，以及单纯变更后的资料
      LET l_ac = l_ac + 1
   END FOREACH
END FUNCTION

PRIVATE FUNCTION apmq101_b1_fill()
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter
 
   CALL g_pmaa_d.clear()  
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
   
   LET g_sql = "SELECT  UNIQUE '',pmaa001,'',pmaa002,pmaa004,pmaa005,'',pmaa006,'',pmaa026,'',", 
               "    pmaa080,'',pmaa083,'',pmaa090,'',pmaa093,''  ,DENSE_RANK() OVER( ORDER BY pmaa_t.pmaa001) AS RANK FROM pmaa_t", 
               " WHERE pmaaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmaa_t"),
                     " ORDER BY pmaa_t.pmaa001"

   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b2_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b2_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
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


   LET g_sql = "SELECT '',pmaa001,",
               "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001= pmaa001 AND pmaal002='"||g_dlang||"') pmaa001_desc,",
               "       pmaa002,pmaa004,pmaa005,",
               "       (SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=pmaa005 AND pmaal002='"||g_dlang||"') pmaa005_desc,",
               "       pmaa006,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='261' AND oocql002=pmaa006 AND oocql003='"||g_dlang||"') pmaa006_desc,",
               "       pmaa026,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='250' AND oocql002=pmaa026 AND oocql003='"||g_dlang||"') pmaa026_desc,",
               "       pmaa080,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='251' AND oocql002=pmaa080 AND oocql003='"||g_dlang||"') pmaa080_desc,",
               "       pmaa083,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='255' AND oocql002=pmaa083 AND oocql003='"||g_dlang||"') pmaa083_desc,",
               "       pmaa090,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='281' AND oocql002=pmaa090 AND oocql003='"||g_dlang||"') pmaa090_desc,",
               "       pmaa093,",
               "       (SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='285' AND oocql002=pmaa093 AND oocql003='"||g_dlang||"') pmaa093_desc",
               " FROM pmaa_t",
               " WHERE pmaaent= ? AND 1=1 AND ",ls_wc,
               " ORDER BY pmaa_t.pmaa001"
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq101_b2_pb FROM g_sql
   DECLARE b2_fill_curs CURSOR FOR apmq101_b2_pb
 
   OPEN b2_fill_curs USING g_enterprise
 
   FOREACH b2_fill_curs INTO g_pmaa_d[l_ac].sel,g_pmaa_d[l_ac].pmaa001,g_pmaa_d[l_ac].pmaa001_desc,g_pmaa_d[l_ac].pmaa002, 
                             g_pmaa_d[l_ac].pmaa004,g_pmaa_d[l_ac].pmaa005,g_pmaa_d[l_ac].pmaa005_desc,g_pmaa_d[l_ac].pmaa006, 
                             g_pmaa_d[l_ac].pmaa006_desc,g_pmaa_d[l_ac].pmaa026,g_pmaa_d[l_ac].pmaa026_desc,g_pmaa_d[l_ac].pmaa080, 
                             g_pmaa_d[l_ac].pmaa080_desc,g_pmaa_d[l_ac].pmaa083,g_pmaa_d[l_ac].pmaa083_desc,g_pmaa_d[l_ac].pmaa090, 
                             g_pmaa_d[l_ac].pmaa090_desc,g_pmaa_d[l_ac].pmaa093,g_pmaa_d[l_ac].pmaa093_desc
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      CALL apmq101_pmaa_t_mask()
 
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
 
   CALL g_pmaa_d.deleteElement(g_pmaa_d.getLength())
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmaa_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b2_fill_curs
   FREE apmq101_b2_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq101_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq101_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmaa_d.getLength() > 0 THEN
      CALL apmq101_b1_fill2()
   END IF
 
   CALL apmq101_filter_show('pmaa001','b_pmaa001')
   CALL apmq101_filter_show('pmaa002','b_pmaa002')
   CALL apmq101_filter_show('pmaa004','b_pmaa004')
   CALL apmq101_filter_show('pmaa005','b_pmaa005')
   CALL apmq101_filter_show('pmaa006','b_pmaa006')
   CALL apmq101_filter_show('pmaa026','b_pmaa026')
   CALL apmq101_filter_show('pmaa080','b_pmaa080')
   CALL apmq101_filter_show('pmaa083','b_pmaa083')
   CALL apmq101_filter_show('pmaa090','b_pmaa090')
   CALL apmq101_filter_show('pmaa093','b_pmaa093')
   CALL apmq101_filter_show('logc004','b_logc004')
   CALL apmq101_filter_show('logc006','b_logc006')
   CALL apmq101_filter_show('logc005','b_logc005')
   CALL apmq101_filter_show('logc002','b_logc002')
   CALL apmq101_filter_show('logc001','b_logc001')
   CALL apmq101_filter_show('logc003','b_logc003')
   
END FUNCTION

PRIVATE FUNCTION apmq101_b1_fill2()
DEFINE li_ac   LIKE type_t.num10
DEFINE l_sql   STRING
   
   LET li_ac = l_ac   
   CALL g_pmaa2_d.clear()
   IF cl_null(g_dt) THEN
      LET g_dt = " 1=1 "
   END IF
   IF NOT cl_null(g_col) THEN
      CALL cl_replace_str(g_col,'dzeb002','l_column') RETURNING g_col
   ELSE 
      LET g_col = " 1=1 "
   END IF
   CALL apmq101_ins_temp()
   
   #4.抓取temp table資料，顯示到單身
   #  4.1 序號=序號+1(非temp table的seq)
   #  4.2 QBE的變更欄位有值時，只顯示QBE的變更欄位的資料
   LET l_sql = " SELECT DISTINCT l_seq,l_column,",
               "        (SELECT dzebl003 FROM dzebl_t WHERE dzebl001= l_column AND dzebl002='",g_lang,"') dzebl003,",
               "        l_value,l_value_t,logc005,",
               "        (SELECT ooefl003 FROM ooefl_t WHERE ooeflent='",g_enterprise,"' AND ooefl001=logc005 AND ooefl002='",g_dlang,"') ooefl003,",
               "        logc002,",
               "        (SELECT gzzal003 FROM gzzal_t WHERE gzzal001=logc002 AND gzzal002='"||g_lang,"') gzzal003,",
               "        logc001,",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent='",g_enterprise,"' AND ooag001=logc001) ooag011,",
               "        logc003 ",
               "   FROM apmq101_logc_tmp ",
               "  WHERE logcent = ",g_enterprise,
               "    AND l_type = '1' ",
               "    AND l_column NOT LIKE '%ent' AND l_column NOT LIKE '%site' AND l_column NOT LIKE '%ownid'  AND l_column NOT LIKE '%owndp' ",
               "    AND l_column NOT LIKE '%crtid'  AND l_column NOT LIKE '%crtdp'  AND l_column NOT LIKE '%crtdt'  AND l_column NOT LIKE '%modid' ",
               "    AND l_column NOT LIKE '%moddt'  AND l_column NOT LIKE '%cnfdt'  AND l_column NOT LIKE '%cnfid' AND l_column NOT LIKE '%stus'",
               "    AND l_column NOT LIKE '%desc%' AND l_column LIKE 'pma%' "  ,             
               "    AND ",g_col,
               "  ORDER BY l_seq,logc003,l_column,l_value "
            
   LET l_ac = 1              
   PREPARE apmq101_b_fill2_pre FROM l_sql
   DECLARE apmq101_b_fill2_curs CURSOR FOR apmq101_b_fill2_pre
   FOREACH apmq101_b_fill2_curs INTO g_pmaa2_d[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF

      LET g_pmaa2_d[l_ac].seq = l_ac
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_pmaa2_d.deleteElement(g_pmaa2_d.getLength()) 
   
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx   
END FUNCTION

 
{</section>}
 
