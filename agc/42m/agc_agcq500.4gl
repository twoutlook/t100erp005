#該程式未解開Section, 採用最新樣板產出!
{<section id="agcq500.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-17 15:46:41), PR版次:0001(2016-02-17 16:18:26)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: agcq500
#+ Description: 券異動單據綜合查詢
#+ Creator....: 01251(2015-12-29 16:18:00)
#+ Modifier...: 01251 -SD/PR- 01251
 
{</section>}
 
{<section id="agcq500.global" >}
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
PRIVATE TYPE type_g_gcao_d RECORD
       
       sel LIKE type_t.chr1, 
   gcao002 LIKE gcao_t.gcao002, 
   gcao002_desc LIKE type_t.chr500, 
   oocq009 LIKE oocq_t.oocq009, 
   gcaf025 LIKE gcaf_t.gcaf025, 
   l_num1 LIKE type_t.num10, 
   l_sumprice1 LIKE type_t.num20_6, 
   l_num2 LIKE type_t.num10, 
   l_sumprice2 LIKE type_t.num20_6, 
   l_num3 LIKE type_t.num10, 
   l_sumprice3 LIKE type_t.num20_6, 
   l_num4 LIKE type_t.num10, 
   l_sumprice4 LIKE type_t.num20_6, 
   l_num5 LIKE type_t.num10, 
   l_sumprice5 LIKE type_t.num20_6, 
   l_num6 LIKE type_t.num10, 
   l_sumprice6 LIKE type_t.num20_6, 
   l_num7 LIKE type_t.num10, 
   l_sumprice7 LIKE type_t.num20_6
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#TYPE  type_BACKUP  RECORD #用于备份查询条件
#        gcao014   STRING,
#        gcao002   STRING
#        END RECORD
#DEFINE BACKUP     type_BACKUP
DEFINE g_sdate1 LIKE gcao_t.gcao015
DEFINE g_edate1 LIKE gcao_t.gcao015
DEFINE g_sdate2 LIKE gcao_t.gcao015
DEFINE g_edate2 LIKE gcao_t.gcao015
DEFINE g_sdate3 LIKE gcao_t.gcao015
DEFINE g_edate3 LIKE gcao_t.gcao015
DEFINE g_wc_table2  STRING
 TYPE type_g_gcao2_d RECORD
       l_gcao002a LIKE type_t.chr10, 
   l_gcao002a_desc LIKE type_t.chr500, 
   l_gcao001a LIKE type_t.chr30, 
   l_gcao003a LIKE type_t.chr10, 
   l_oocq009a LIKE type_t.chr500, 
   l_gcao008a LIKE type_t.dat, 
   l_gcao009a LIKE type_t.dat, 
   l_gcao014a LIKE type_t.chr10, 
   l_gcao014a_desc LIKE type_t.chr500, 
   l_gcao015a LIKE type_t.dat, 
   l_rtja033a LIKE type_t.chr20, 
   l_rtjb012a LIKE type_t.num20_6, 
   l_gcao020a LIKE type_t.chr10, 
   l_gcao002a_desc_1 LIKE type_t.chr500, 
   l_gcao021a LIKE type_t.dat, 
   l_rtja033b LIKE type_t.chr20, 
   l_rtjf018a LIKE type_t.num20_6, 
   l_gcao029a LIKE type_t.chr10, 
   l_gcao029a_desc LIKE type_t.chr500, 
   l_gcao030a LIKE type_t.dat, 
   l_gcamdocnoa LIKE type_t.chr20, 
   l_gcam002a LIKE type_t.chr10, 
   l_gcam002a_desc LIKE type_t.chr500, 
   gcao005 LIKE type_t.chr500
       END RECORD
DEFINE g_gcao2_d     DYNAMIC ARRAY OF type_g_gcao2_d
DEFINE g_gcao2_d_t   type_g_gcao2_d       
#end add-point
 
#模組變數(Module Variables)
DEFINE g_gcao_d            DYNAMIC ARRAY OF type_g_gcao_d
DEFINE g_gcao_d_t          type_g_gcao_d
 
 
 
 
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
 
{<section id="agcq500.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("agc","")
 
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
   DECLARE agcq500_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE agcq500_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE agcq500_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_agcq500 WITH FORM cl_ap_formpath("agc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL agcq500_init()   
 
      #進入選單 Menu (="N")
      CALL agcq500_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_agcq500
      
   END IF 
   
   CLOSE agcq500_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="agcq500.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION agcq500_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success     LIKE type_t.num5
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_gcaf025','6528') 
  
 
   #add-point:畫面資料初始化 name="init.init"
#   INITIALIZE BACKUP.* TO NULL
 
   
   CALL s_aooi500_create_temp() RETURNING l_success
   LET l_success = ''   
   CALL agcq500_create_tmp() RETURNING l_success 
   CALL cl_set_combo_scc('gcao005','6551')    
   #end add-point
 
   CALL agcq500_default_search()
END FUNCTION
 
{</section>}
 
{<section id="agcq500.default_search" >}
PRIVATE FUNCTION agcq500_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gcao001 = '", g_argv[01], "' AND "
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
 
{<section id="agcq500.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION agcq500_ui_dialog() 
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

   LET  g_sdate1 = g_today
   LET  g_edate1 = g_today
   LET  g_sdate2 = g_today
   LET  g_edate2 = g_today
   LET  g_sdate3 = g_today
   LET  g_edate3 = g_today   
   #end add-point
 
   
   CALL agcq500_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gcao_d.clear()
 
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
 
         CALL agcq500_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT g_sdate1,g_edate1,g_sdate2,g_edate2,g_sdate3,g_edate3   
            FROM  s_date1,e_date1,s_date2,e_date2,s_date3,e_date3
              ATTRIBUTE(WITHOUT DEFAULTS)

                
               AFTER INPUT
         
               
         END INPUT 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON gcao014,gcao029,gcao020,gcao002,gcao001,gcao003,gcao005
                       FROM gcao014,gcao029,gcao020,gcao002,gcao001,gcao003,gcao005
                          
             BEFORE CONSTRUCT
         
             ON ACTION controlp INFIELD gcao002
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                CALL q_gcaf001()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao002  #顯示到畫面上
                NEXT FIELD gcao002                     #返回原欄位
         
             ON ACTION controlp INFIELD gcao014
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcao014',g_site,'c')            
                CALL q_ooef001_24()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao014  #顯示到畫面上
                NEXT FIELD gcao014                     #返回原欄位
                
             ON ACTION controlp INFIELD gcao029
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcao029',g_site,'c')            
                CALL q_ooef001_24()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao029  #顯示到畫面上
                NEXT FIELD gcao029                     #返回原欄位   

             ON ACTION controlp INFIELD gcao020
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c' 
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.where = s_aooi500_q_where(g_prog,'gcao020',g_site,'c')            
                CALL q_ooef001_24()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao020  #顯示到畫面上
                NEXT FIELD gcao020
                
                
             ON ACTION controlp INFIELD gcao001
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                CALL q_gcao001_9()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao001  #顯示到畫面上
                NEXT FIELD gcao001                     #返回原欄位
                
             ON ACTION controlp INFIELD gcao003
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = '2071'
                CALL q_oocq002()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcao003  #顯示到畫面上
                NEXT FIELD gcao003                     #返回原欄位
            
#           AFTER FIELD gcao014   
#              CALL FGL_DIALOG_GETBUFFER() 
#              RETURNING BACKUP.gcao014    
#           AFTER FIELD gcao002    
#              CALL FGL_DIALOG_GETBUFFER() 
#              RETURNING BACKUP.gcao002  
         
         END CONSTRUCT
         
         CONSTRUCT g_wc_table2 ON gcam002
                       FROM gcam002
                       
             ON ACTION controlp INFIELD gcam002
                INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'c'
                LET g_qryparam.reqry = FALSE
                LET g_qryparam.arg1 = '2055'
                CALL q_oocq002()                           #呼叫開窗
                DISPLAY g_qryparam.return1 TO gcam002  #顯示到畫面上
               NEXT FIELD gcam002                     #返回原欄位                       
         END CONSTRUCT                       
         #end add-point
     
         DISPLAY ARRAY g_gcao_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL agcq500_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL agcq500_b_fill2()
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
         DISPLAY ARRAY g_gcao2_d TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
            BEFORE DISPLAY
               LET g_current_page = 2
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx
               CALL agcq500_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               LET g_action_choice = lc_action_choice_old
         END DISPLAY

         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL agcq500_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_sdate1) then
               LET  g_sdate1 = g_today
            END IF 
            IF cl_null(g_edate1) then 
               LET  g_edate1 = g_today
            END IF
            IF cl_null(g_sdate2) then
               LET  g_sdate2 = g_today
            END IF 
            IF cl_null(g_edate2) then 
               LET  g_edate2 = g_today
            END IF  
            IF cl_null(g_sdate3) then
               LET  g_sdate3 = g_today
            END IF 
            IF cl_null(g_edate3) then 
               LET  g_edate3 = g_today
            END IF            
            #end add-point
            NEXT FIELD gcao014
 
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
            CALL agcq500_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_gcao_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL agcq500_b_fill()
 
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
            CALL agcq500_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL agcq500_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL agcq500_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL agcq500_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_gcao_d.getLength()
               LET g_gcao_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_gcao_d.getLength()
               LET g_gcao_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_gcao_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gcao_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_gcao_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gcao_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL agcq500_filter()
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
 
{<section id="agcq500.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION agcq500_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
   DEFINE l_success       LIKE type_t.num5
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LET l_where = s_aooi500_sql_where(g_prog,'gcao014')
   IF cl_null(l_where) THEN
      LET l_where = "1=1"
   END IF 
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc CLIPPED," AND ",l_where
   END IF
   IF cl_null(g_wc_table2) THEN
      LET g_wc_table2=" 1=1"
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
 
   CALL g_gcao_d.clear()
 
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
   LET ls_sql_rank = "SELECT  UNIQUE '',gcao002,'','','','','','','','','','','','','','','','',''  , 
       DENSE_RANK() OVER( ORDER BY gcao_t.gcao001) AS RANK FROM gcao_t",
 
 
                     "",
                     " WHERE gcaoent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gcao_t"),
                     " ORDER BY gcao_t.gcao001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   CALL agcq500_ins_tmp(ls_wc)
   
   LET ls_sql_rank = " SELECT  UNIQUE gcao002,gcafl003,oocq009,gcaf025,
                       SUM(l_num) l_num,        SUM(l_sumprice) l_sumprice,                
                       SUM(l_num2) l_num2,        SUM(l_sumprice2) l_sumprice2, 
                       SUM(l_num3) l_num3,        SUM(l_sumprice3) l_sumprice3,      
                       SUM(l_num4) l_num4,        SUM(l_sumprice4) l_sumprice4,  
                       SUM(l_num5) l_num5,        SUM(l_sumprice5) l_sumprice5,  
                       SUM(l_num6) l_num6,        SUM(l_sumprice6) l_sumprice6,  
                       SUM(l_num7) l_num7,        SUM(l_sumprice7) l_sumprice7,  
                       DENSE_RANK() OVER( ORDER BY gcao002) AS RANK ",
                     " FROM agcq500_tmp", 
                     " WHERE gcaoent= ? " ,  
                     " GROUP BY gcao002,gcafl003,oocq009,gcaf025 "
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
 
   LET g_sql = "SELECT '',gcao002,'','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   LET g_sql = "SELECT '',gcao002,gcafl003,oocq009,gcaf025,
                       l_num,         l_sumprice,
                       l_num2,        l_sumprice2,     
                       l_num3,        l_sumprice3,   
                       l_num4,        l_sumprice4,   
                       l_num5,        l_sumprice5,   
                       l_num6,        l_sumprice6,   
                       l_num7,        l_sumprice7  ",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page                
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE agcq500_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR agcq500_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_gcao_d[l_ac].sel,g_gcao_d[l_ac].gcao002,g_gcao_d[l_ac].gcao002_desc,g_gcao_d[l_ac].oocq009, 
       g_gcao_d[l_ac].gcaf025,g_gcao_d[l_ac].l_num1,g_gcao_d[l_ac].l_sumprice1,g_gcao_d[l_ac].l_num2, 
       g_gcao_d[l_ac].l_sumprice2,g_gcao_d[l_ac].l_num3,g_gcao_d[l_ac].l_sumprice3,g_gcao_d[l_ac].l_num4, 
       g_gcao_d[l_ac].l_sumprice4,g_gcao_d[l_ac].l_num5,g_gcao_d[l_ac].l_sumprice5,g_gcao_d[l_ac].l_num6, 
       g_gcao_d[l_ac].l_sumprice6,g_gcao_d[l_ac].l_num7,g_gcao_d[l_ac].l_sumprice7
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
 
      CALL agcq500_detail_show("'1'")
 
      CALL agcq500_gcao_t_mask()
 
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
   CALL agcq500_b2_fill(ls_wc)  
   CALL g_gcao2_d.deleteElement(g_gcao2_d.getLength())   
 
   #end add-point
 
   CALL g_gcao_d.deleteElement(g_gcao_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_gcao_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE agcq500_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL agcq500_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL agcq500_detail_action_trans()
 
   LET l_ac = 1
   IF g_gcao_d.getLength() > 0 THEN
      CALL agcq500_b_fill2()
   END IF
 
      CALL agcq500_filter_show('gcao002','b_gcao002')
   CALL agcq500_filter_show('oocq009','b_oocq009')
   CALL agcq500_filter_show('gcaf025','b_gcaf025')
 
 
END FUNCTION
 
{</section>}
 
{<section id="agcq500.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION agcq500_b_fill2()
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
 
{<section id="agcq500.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION agcq500_detail_show(ps_page)
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

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcao_d[l_ac].gcao014
#            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_gcao_d[l_ac].gcao014_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcao_d[l_ac].gcao014_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_gcao_d[l_ac].gcao002
#            LET ls_sql = "SELECT gcafl003 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl002='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_gcao_d[l_ac].gcao002_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_gcao_d[l_ac].gcao002_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="agcq500.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION agcq500_filter()
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
      CONSTRUCT g_wc_filter ON gcao002,oocq009,gcaf025
                          FROM s_detail1[1].b_gcao002,s_detail1[1].b_oocq009,s_detail1[1].b_gcaf025
 
         BEFORE CONSTRUCT
                     DISPLAY agcq500_filter_parser('gcao002') TO s_detail1[1].b_gcao002
            DISPLAY agcq500_filter_parser('oocq009') TO s_detail1[1].b_oocq009
            DISPLAY agcq500_filter_parser('gcaf025') TO s_detail1[1].b_gcaf025
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_gcao002>>----
         #Ctrlp:construct.c.page1.b_gcao002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcao002
            #add-point:ON ACTION controlp INFIELD b_gcao002 name="construct.c.filter.page1.b_gcao002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gcaf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gcao002  #顯示到畫面上
            NEXT FIELD b_gcao002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_gcao002_desc>>----
         #----<<b_oocq009>>----
         #Ctrlp:construct.c.filter.page1.b_oocq009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_oocq009
            #add-point:ON ACTION controlp INFIELD b_oocq009 name="construct.c.filter.page1.b_oocq009"
            
            #END add-point
 
 
         #----<<b_gcaf025>>----
         #Ctrlp:construct.c.filter.page1.b_gcaf025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gcaf025
            #add-point:ON ACTION controlp INFIELD b_gcaf025 name="construct.c.filter.page1.b_gcaf025"
            
            #END add-point
 
 
         #----<<l_num1>>----
         #----<<l_sumprice1>>----
         #----<<l_num2>>----
         #----<<l_sumprice2>>----
         #----<<l_num3>>----
         #----<<l_sumprice3>>----
         #----<<l_num4>>----
         #----<<l_sumprice4>>----
         #----<<l_num5>>----
         #----<<l_sumprice5>>----
         #----<<l_num6>>----
         #----<<l_sumprice6>>----
         #----<<l_num7>>----
         #----<<l_sumprice7>>----
 
 
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
 
      CALL agcq500_filter_show('gcao002','b_gcao002')
   CALL agcq500_filter_show('oocq009','b_oocq009')
   CALL agcq500_filter_show('gcaf025','b_gcaf025')
 
 
   CALL agcq500_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="agcq500.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION agcq500_filter_parser(ps_field)
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
 
{<section id="agcq500.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION agcq500_filter_show(ps_field,ps_object)
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
   LET ls_condition = agcq500_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="agcq500.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION agcq500_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   IF g_current_page = 2 THEN
      LET g_tot_cnt=g_gcao2_d.getLength()
   END IF
   IF g_current_page = 1 THEN
      LET g_tot_cnt=g_gcao_d.getLength()
   END IF   
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
 
{<section id="agcq500.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION agcq500_detail_index_setting()
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
            IF g_gcao_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gcao_d.getLength() AND g_gcao_d.getLength() > 0
            LET g_detail_idx = g_gcao_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gcao_d.getLength() THEN
               LET g_detail_idx = g_gcao_d.getLength()
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
 
{<section id="agcq500.mask_functions" >}
 &include "erp/agc/agcq500_mask.4gl"
 
{</section>}
 
{<section id="agcq500.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL agcq500_create_tmp()
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: 2015/12/29 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq500_create_tmp()
DEFINE r_success         LIKE type_t.num5

   LET r_success = TRUE

   DROP TABLE agcq500_tmp
   
   CREATE TEMP TABLE agcq500_tmp(
      gcaoent           SMALLINT,          #当前ent
      gcao002           VARCHAR(10),          #劵种编号
      gcafl003          VARCHAR(500),        #劵种名称
      oocq009           VARCHAR(40),          #面额
      gcaf025           VARCHAR(10),          #券核銷方式
      l_num             INTEGER,            #总劵数
      l_sumprice        DECIMAL(20,6),          #总金额
      l_num2            INTEGER,            #发售（兑出）张数
      l_sumprice2       DECIMAL(20,6),          #发售（兑出）金额
      l_num3            INTEGER,            #停用张数
      l_sumprice3       DECIMAL(20,6),          #停用金额
      l_num4            INTEGER,            #回收张数
      l_sumprice4       DECIMAL(20,6),          #回收金额   
      l_num5            INTEGER,            #发售退回张数
      l_sumprice5       DECIMAL(20,6),          #发售退回金额   
      l_num6            INTEGER,            #作废张数
      l_sumprice6       DECIMAL(20,6),          #作废金额  
      l_num7            INTEGER,            #失效核销张数
      l_sumprice7       DECIMAL(20,6))          #失效核销金额     

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Create agcq500_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   RETURN r_success   	

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
PRIVATE FUNCTION agcq500_ins_tmp(p_wc)
DEFINE p_wc              STRING
DEFINE l_sql             STRING

   DELETE FROM agcq500_tmp
   
   #新增資料到temp table
   LET l_sql = " INSERT INTO agcq500_tmp(gcaoent,gcao002,gcafl003,oocq009,gcaf025,",
               "   l_num,l_sumprice,",      #总劵数           #总金额
               "   l_num2,l_sumprice2,",    #发售（兑出）张数  #发售（兑出）金额
               "   l_num3,l_sumprice3,",    #停用张数         #停用金额
               "   l_num4,l_sumprice4,",    #回收张数         #回收金额   
               "   l_num5,l_sumprice5,",    #发售退回张数     #发售退回金额 
               "   l_num6,l_sumprice6,",    #作废张数         #作废金额 
               "   l_num7,l_sumprice7)",    #失效核销张数     #失效核销金额                    
               " SELECT gcaoent,gcao002,gcafl003,oocq009,gcaf025, ",
               " COUNT(CASE WHEN (gcao011 IS NOT NULL AND gcao012 IS NOT NULL) THEN gcao001 END) l_num, ",                        #总制券张数 
               "   SUM(CASE WHEN (gcao011 IS NOT NULL AND gcao012 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice,",             #总制券金额
               " COUNT(CASE WHEN (gcao014 IS NOT NULL AND gcao015 IS NOT NULL) THEN gcao001 END) l_num2, ",                       #发售（兑出）张数
               "   SUM(CASE WHEN (gcao014 IS NOT NULL AND gcao015 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice2, ",           #发售（兑出）金额
               " COUNT(CASE WHEN (gcao026 IS NOT NULL AND gcao027 IS NOT NULL) THEN gcao001 END) l_num3,   ",                     #停用张数
               "   SUM(CASE WHEN (gcao026 IS NOT NULL AND gcao027 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice3, ",           #停用金额
               " COUNT(CASE WHEN (gcao020 IS NOT NULL AND gcao021 IS NOT NULL) THEN gcao001 END) l_num4,   ",                     #回收张数 
               "   SUM(CASE WHEN (gcao020 IS NOT NULL AND gcao021 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice4, ",           #回收金额 
               " COUNT(CASE WHEN (gcao017 IS NOT NULL AND gcao018 IS NOT NULL) THEN gcao001 END) l_num5,   ",                     #发售退回张数
               "   SUM(CASE WHEN (gcao017 IS NOT NULL AND gcao018 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice5, ",           #发售退回金额
               " COUNT(CASE WHEN (gcao029 IS NOT NULL AND gcao030 IS NOT NULL) THEN gcao001 END) l_num6,   ",                     #作废张数 
               "   SUM(CASE WHEN (gcao029 IS NOT NULL AND gcao030 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice6, ",           #作废金额 
               " COUNT(CASE WHEN (gcao023 IS NOT NULL AND gcao024 IS NOT NULL) THEN gcao001 END) l_num7,   ",                     #失效核销张数  
               "   SUM(CASE WHEN (gcao023 IS NOT NULL AND gcao024 IS NOT NULL) THEN gcao004 ELSE 0 END) l_sumprice7 ",             #失效核销金额 
               " FROM gcao_t ",
               "   LEFT join gcaf_t ON gcafent=gcaoent AND gcaf001=gcao002",
               "   LEFT join gcafl_t ON gcaflent=gcaoent AND gcafl001=gcao002 AND gcafl002='",g_dlang,"'",
               "   LEFT join oocq_t  ON gcaoent=oocqent AND gcao003=oocq002 AND oocq001='2071' ",                 
               " WHERE gcaoent= ",g_enterprise,              
               "   AND ",p_wc 
#發售日期               
   IF NOT cl_null(g_sdate1) THEN
      LET l_sql=l_sql CLIPPED," AND gcao015>='",g_sdate1,"'"
   END IF
   IF NOT cl_null(g_edate1) THEN
      LET l_sql=l_sql CLIPPED," AND gcao015<='",g_edate1,"'"
   END IF
   
#消費日期  
   IF NOT cl_null(g_sdate2) THEN
      LET l_sql=l_sql CLIPPED," AND gcao021>='",g_sdate2,"'"
   END IF
   IF NOT cl_null(g_edate2) THEN
      LET l_sql=l_sql CLIPPED," AND gcao021<='",g_edate2,"'"
   END IF

#作廢日期   
   IF NOT cl_null(g_sdate3) THEN
      LET l_sql=l_sql CLIPPED," AND gcao030>='",g_sdate3,"'"
   END IF
   IF NOT cl_null(g_edate3) THEN
      LET l_sql=l_sql CLIPPED," AND gcao030<='",g_edate3,"'"
   END IF   

#作废理由码
   IF NOT cl_null(g_wc_table2) AND g_wc_table2<>" 1=1" THEN
      LET l_sql=l_sql CLIPPED," EXIST (SELECT 1 FROM gcam_t,gcan_t WHERE gcament=gcanent AND gcamdocno=gcandocno AND gcam000='1' AND gcamstus='Y' AND gcament=gcaoent AND gcan001=gcao001"   
   END IF
   
   LET l_sql=l_sql CLIPPED," GROUP BY gcaoent,gcao002, gcafl003, oocq009,gcaf025 "
   
   PREPARE agcq500_ins_data FROM l_sql
   EXECUTE agcq500_ins_data
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Ins agcq500_tmp"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN
   END IF               

END FUNCTION

################################################################################
# Descriptions...: 券明細說明
# Memo...........:
# Usage..........: agcq808_b2_fill(p_wc)
# Input parameter: p_wc  查询条件
# Return code....: 
# Date & Author..: 20160201 By huangrh
# Modify.........:
################################################################################
PRIVATE FUNCTION agcq500_b2_fill(p_wc)
DEFINE p_wc            STRING
DEFINE l_sql           STRING
DEFINE ls_wc           STRING
DEFINE l_success       LIKE type_t.chr1
  
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   
   LET ls_wc = g_wc," AND ", g_wc_filter
 
   LET l_sql = "SELECT gcao002,a.gcafl003,gcao001,gcao003,b.oocq009,gcao008,gcao009,gcao014,c.ooefl003,",
                "       gcao015,f.rtja033,f.rtjb012,gcao020,d.ooefl003,gcao021,g.rtja033,g.rtjf018,gcao029,e.ooefl003,",
                "       gcao030,j.gcamdocno,j.gcam002,'',gcao005",
                " FROM gcao_t",
                "   LEFT join gcafl_t a ON gcaflent=gcaoent AND gcafl001=gcao002 AND gcafl002='",g_dlang,"'", 
                "   LEFT join oocq_t  b ON gcaoent=oocqent AND gcao003=oocq002 AND oocq001='2071' ",
                "   LEFT join ooefl_t c ON c.ooeflent=gcaoent AND c.ooefl001=gcao014 AND c.ooefl002='",g_dlang,"'",  
                "   LEFT join ooefl_t d ON d.ooeflent=gcaoent AND d.ooefl001=gcao020 AND d.ooefl002='",g_dlang,"'",
                "   LEFT join ooefl_t e ON e.ooeflent=gcaoent AND e.ooefl001=gcao029 AND e.ooefl002='",g_dlang,"'",
                "   LEFT join (SELECT rtjaent,rtjasite,rtja033,rtjb012,rtjb040,rtjb041 FROM rtja_t,rtjb_t WHERE rtjadocno=rtjbdocno AND rtjaent=rtjbent) f ON f.rtjaent=gcaoent AND f.rtjb040=gcao002 AND f.rtjb041=gcao001 AND f.rtjasite=gcao014 ",
                "   LEFT join (SELECT rtjaent,rtjasite,rtja033,rtjf013,rtjf016,rtjf017,rtjf018 FROM rtjf_t,rtja_t WHERE rtjadocno=rtjfdocno AND rtjfent=rtjaent) g ON g.rtjaent=gcaoent AND g.rtjf013=gcao002 AND g.rtjasite=gcao020 AND gcao001 between g.rtjf016 and g.rtjf017 ",
                "   LEFT join (SELECT gcament,gcamdocno,gcam002,gcansite,gcan001,gcan002 FROM gcam_t,gcan_t WHERE gcamdocno=gcandocno AND gcament=gcanent AND gcam000='1' AND gcamstus='Y') j ON j.gcament=gcaoent AND j.gcan001=gcao001 AND j.gcan002=gcao002 AND j.gcansite=gcao029", 
                " WHERE gcaoent= ",g_enterprise,        
                "   AND ",ls_wc

#發售日期               
   IF NOT cl_null(g_sdate1) THEN
      LET l_sql=l_sql CLIPPED," AND gcao015>='",g_sdate1,"'"
   END IF
   IF NOT cl_null(g_edate1) THEN
      LET l_sql=l_sql CLIPPED," AND gcao015<='",g_edate1,"'"
   END IF
   
#消費日期  
   IF NOT cl_null(g_sdate2) THEN
      LET l_sql=l_sql CLIPPED," AND gcao021>='",g_sdate2,"'"
   END IF
   IF NOT cl_null(g_edate2) THEN
      LET l_sql=l_sql CLIPPED," AND gcao021<='",g_edate2,"'"
   END IF

#作廢日期   
   IF NOT cl_null(g_sdate3) THEN
      LET l_sql=l_sql CLIPPED," AND gcao030>='",g_sdate3,"'"
   END IF
   IF NOT cl_null(g_edate3) THEN
      LET l_sql=l_sql CLIPPED," AND gcao030<='",g_edate3,"'"
   END IF   

#作废理由码
   IF NOT cl_null(g_wc_table2) AND g_wc_table2<>" 1=1" THEN
      LET l_sql=l_sql CLIPPED," EXIST (SELECT 1 FROM gcam_t,gcan_t WHERE gcament=gcanent AND gcamdocno=gcandocno AND gcam000='1' AND gcamstus='Y' AND gcament=gcaoent AND gcan001=gcao001"   
   END IF


   
   PREPARE agcq500_bp2 FROM l_sql
   DECLARE b_fill_curs2 CURSOR FOR agcq500_bp2
   
   LET l_ac = 1   
 
   CALL g_gcao2_d.clear()

   FOREACH b_fill_curs2 INTO  g_gcao2_d[l_ac].l_gcao002a,g_gcao2_d[l_ac].l_gcao002a_desc,g_gcao2_d[l_ac].l_gcao001a,g_gcao2_d[l_ac].l_gcao003a,
                              g_gcao2_d[l_ac].l_oocq009a,g_gcao2_d[l_ac].l_gcao008a,g_gcao2_d[l_ac].l_gcao009a,g_gcao2_d[l_ac].l_gcao014a,
                              g_gcao2_d[l_ac].l_gcao014a_desc,g_gcao2_d[l_ac].l_gcao015a,g_gcao2_d[l_ac].l_rtja033a,g_gcao2_d[l_ac].l_rtjb012a,
                              g_gcao2_d[l_ac].l_gcao020a,g_gcao2_d[l_ac].l_gcao002a_desc_1,g_gcao2_d[l_ac].l_gcao021a,g_gcao2_d[l_ac].l_rtja033b,
                              g_gcao2_d[l_ac].l_rtjf018a,g_gcao2_d[l_ac].l_gcao029a,g_gcao2_d[l_ac].l_gcao029a_desc,g_gcao2_d[l_ac].l_gcao030a,
                              g_gcao2_d[l_ac].l_gcamdocnoa,g_gcao2_d[l_ac].l_gcam002a,g_gcao2_d[l_ac].l_gcam002a_desc,g_gcao2_d[l_ac].gcao005                            
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #发售流水号/发售数量
      #如果取不到，但发售门店/日期不为空的情况下  发售流水号为空  数量为1
      IF NOT cl_null(g_gcao2_d[l_ac].l_gcao014a) AND NOT cl_null(g_gcao2_d[l_ac].l_gcao015a) THEN
         IF cl_null(g_gcao2_d[l_ac].l_rtjb012a) THEN
            LET g_gcao2_d[l_ac].l_rtjb012a=1
         END IF
      END IF
          
      #消费流水号/消费数量,rtjf018 >0  则给1  否则为-1 
      #如果取不到，但收券门店/日期不为空的情况下  消费流水号为空  数量为1   
      IF NOT cl_null(g_gcao2_d[l_ac].l_rtjf018a) THEN 
         IF g_gcao2_d[l_ac].l_rtjf018a>0 THEN       
            LET g_gcao2_d[l_ac].l_rtjf018a=1
         ELSE
            LET g_gcao2_d[l_ac].l_rtjf018a=-1
         END IF  
      END IF         
      IF NOT cl_null(g_gcao2_d[l_ac].l_gcao020a) AND NOT cl_null(g_gcao2_d[l_ac].l_gcao021a) THEN
         IF cl_null(g_gcao2_d[l_ac].l_rtjf018a) THEN
            LET g_gcao2_d[l_ac].l_rtjf018a=1
         END IF
      END IF      
      
      #作废理由码--说明
      IF NOT cl_null(g_gcao2_d[l_ac].l_gcam002a) THEN
         SELECT oocql004 INTO g_gcao2_d[l_ac].l_gcam002a_desc
           FROM oocql_t
          WHERE oocqlent=g_enterprise
            AND oocql001=''
            AND oocql002=g_gcao2_d[l_ac].l_gcam002a
            AND oocql003=g_dlang       
      END IF

      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
   
   CLOSE b_fill_curs2
   FREE agcq500_bp2

            
END FUNCTION

 
{</section>}
 
