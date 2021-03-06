#該程式未解開Section, 採用最新樣板產出!
{<section id="acrq511.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-03-09 09:54:58), PR版次:0003(2016-02-25 11:06:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000054
#+ Filename...: acrq511
#+ Description: 會員促銷活動查詢
#+ Creator....: 02003(2014-07-16 00:00:00)
#+ Modifier...: 06137 -SD/PR- 02003
 
{</section>}
 
{<section id="acrq511.global" >}
#應用 q02 樣板自動產生(Version:42)
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
PRIVATE TYPE type_g_decc_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   prdw003 LIKE prdw_t.prdw003, 
   prdwunit LIKE prdw_t.prdwunit, 
   prdwunit_desc LIKE type_t.chr500, 
   prdwsite LIKE prdw_t.prdwsite, 
   prdwsite_desc LIKE type_t.chr500, 
   prdw100 LIKE prdw_t.prdw100, 
   prdw001 LIKE prdw_t.prdw001, 
   prdwl003 LIKE prdwl_t.prdwl003, 
   prdw002 LIKE prdw_t.prdw002, 
   prdw006 LIKE prdw_t.prdw006, 
   prcfl003 LIKE prcfl_t.prcfl003, 
   prdw007 LIKE prdw_t.prdw007, 
   prcdl003 LIKE prcdl_t.prcdl003, 
   prdd003 LIKE prdd_t.prdd003, 
   prdd004 LIKE prdd_t.prdd004, 
   prdd005 LIKE prdd_t.prdd005, 
   prdd006 LIKE prdd_t.prdd006, 
   prdd007 LIKE prdd_t.prdd007, 
   prdd008 LIKE prdd_t.prdd008 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bdate              LIKE type_t.dat
DEFINE g_edate              LIKE type_t.dat
DEFINE g_sel1               LIKE type_t.chr1
DEFINE g_sel2               LIKE type_t.chr1
DEFINE g_sel3               LIKE type_t.chr1
DEFINE g_sel4               LIKE type_t.chr1
DEFINE g_num1               LIKE type_t.num10
DEFINE g_num2               LIKE type_t.num10
DEFINE g_wc_master          STRING 
DEFINE g_mmag002            STRING 
DEFINE g_mmag004            STRING 
 TYPE type_g_decc_d_1 RECORD
   prdw003 LIKE prdw_t.prdw003, 
   prdwunit LIKE prdw_t.prdwunit, 
   prdwunit_desc LIKE type_t.chr80, 
   prdwsite LIKE prdw_t.prdwsite, 
   prdwsite_desc LIKE type_t.chr80, 
   prdw100 DATETIME YEAR TO SECOND, 
   prdw001 LIKE prdw_t.prdw001, 
   prdwl003 LIKE prdwl_t.prdwl003, 
   prdw002 LIKE prdw_t.prdw002, 
   prdw006 LIKE prdw_t.prdw006, 
   prcfl003 LIKE prcfl_t.prcfl003, 
   prdw007 LIKE prdw_t.prdw007, 
   prcdl003 LIKE prcdl_t.prcdl003, 
   prdd003 LIKE prdd_t.prdd003, 
   prdd004 LIKE prdd_t.prdd004, 
   prdd005 LIKE prdd_t.prdd005, 
   prdd006 LIKE prdd_t.prdd006, 
   prdd007 LIKE prdd_t.prdd007, 
   prdd008 LIKE prdd_t.prdd008 
       END RECORD
 TYPE type_g_decc_d_2 RECORD
   prdw003 LIKE prdw_t.prdw003, 
   prdwunit LIKE prdw_t.prdwunit, 
   prdwunit_desc LIKE type_t.chr80, 
   prdwsite LIKE prdw_t.prdwsite, 
   prdwsite_desc LIKE type_t.chr80, 
   prdw100 LIKE prda_t.prdadocdt, 
   prdw001 LIKE prdw_t.prdw001, 
   prdwl003 LIKE prdwl_t.prdwl003, 
   prdw002 LIKE prdw_t.prdw002, 
   prdw006 LIKE prdw_t.prdw006, 
   prcfl003 LIKE prcfl_t.prcfl003, 
   prdw007 LIKE prdw_t.prdw007, 
   prcdl003 LIKE prcdl_t.prcdl003, 
   prdd003 LIKE prdd_t.prdd003, 
   prdd004 LIKE prdd_t.prdd004, 
   prdd005 LIKE prdd_t.prdd005, 
   prdd006 LIKE prdd_t.prdd006, 
   prdd007 LIKE prdd_t.prdd007, 
   prdd008 LIKE prdd_t.prdd008      
       END RECORD       
DEFINE g_decc_d2            DYNAMIC ARRAY OF type_g_decc_d_1
DEFINE g_decc_d3            DYNAMIC ARRAY OF type_g_decc_d_1
DEFINE g_decc_d4            DYNAMIC ARRAY OF type_g_decc_d_2
DEFINE g_decc_d5            DYNAMIC ARRAY OF type_g_decc_d_1
DEFINE l_ac2                LIKE type_t.num5
DEFINE l_ac3                LIKE type_t.num5
DEFINE l_ac4                LIKE type_t.num5
DEFINE l_ac5                LIKE type_t.num5
DEFINE g_detail_cnt3        LIKE type_t.num5
DEFINE g_detail_cnt4        LIKE type_t.num5
DEFINE g_detail_cnt5        LIKE type_t.num5
DEFINE g_sql1               STRING 
DEFINE g_sql2               STRING 
DEFINE g_sql3               STRING 
DEFINE g_sql4               STRING 
DEFINE g_sql5               STRING 
DEFINE g_cnt2               LIKE type_t.num5
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_decc_d
DEFINE g_master_t                   type_g_decc_d
DEFINE g_decc_d          DYNAMIC ARRAY OF type_g_decc_d
DEFINE g_decc_d_t        type_g_decc_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="acrq511.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
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
   DECLARE acrq511_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE acrq511_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE acrq511_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_acrq511 WITH FORM cl_ap_formpath("acr",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL acrq511_init()   
 
      #進入選單 Menu (="N")
      CALL acrq511_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      DROP TABLE acrq511_tmp
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_acrq511
      
   END IF 
   
   CLOSE acrq511_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success #150308-00001#1  By Ken 150309
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="acrq511.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION acrq511_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5 #150308-00001#1  By Ken 150309
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_prdd007','6520') 
   CALL cl_set_combo_scc('b_prdd008','30') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success #150308-00001#1  By Ken 150309   
   CALL cl_set_combo_scc('b_prdw003','6027') 
   CALL cl_set_combo_scc('b_prdw003_1','6027') 
   CALL cl_set_combo_scc('b_prdw003_2','6027') 
   CALL cl_set_combo_scc('b_prdw003_3','6027') 
   CALL cl_set_combo_scc('b_prdw003_4','6027') 
   CALL cl_set_combo_scc('b_prdd007_1','6520') 
   CALL cl_set_combo_scc('b_prdd007_2','6520') 
   CALL cl_set_combo_scc('b_prdd007_3','6520') 
   CALL cl_set_combo_scc('b_prdd007_4','6520') 
   CALL cl_set_combo_scc('b_prdd008_1','30') 
   CALL cl_set_combo_scc('b_prdd008_2','30') 
   CALL cl_set_combo_scc('b_prdd008_3','30') 
   CALL cl_set_combo_scc('b_prdd008_4','30') 
   #end add-point
 
   CALL acrq511_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="acrq511.default_search" >}
PRIVATE FUNCTION acrq511_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " decc001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " decc002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " decc023 = '", g_argv[03], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION acrq511_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_year   LIKE type_t.num5
   DEFINE l_month  LIKE type_t.num5
   DEFINE l_date   LIKE type_t.dat
   DEFINE l_sql    STRING 
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   #获取上个月的当天
   SELECT add_months(g_today,-1) INTO l_date FROM dual
   LET l_year = YEAR(l_date)
   LET l_month = MONTH(l_date)
   #获取上个月第一天
   LET l_sql = "SELECT to_date('",l_year,"'||'",l_month,"','yyyy/mm') FROM dual"
   PREPARE sel_dat FROM l_sql
   EXECUTE sel_dat INTO g_bdate
   #获取上个月的最后一天
   SELECT LAST_DAY(l_date) INTO g_edate FROM dual
   
   LET g_sel1 = 'N'
   LET g_sel2 = 'Y'
   LET g_sel3 = 'Y'
   LET g_sel4 = 'Y'
   LET g_num1 = 1
   LET g_num2 = 1
   CALL cl_set_act_visible("filter",FALSE)
   LET g_wc = g_wc," AND 1=1"
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL acrq511_b_fill()
   ELSE
      CALL acrq511_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_decc_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL acrq511_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_decc_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL acrq511_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL acrq511_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_decc_d2 TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt2) 
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
               LET l_ac2 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_decc_d2.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac2
               
         END DISPLAY
         DISPLAY ARRAY g_decc_d3 TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt3) 

            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail3")
               LET l_ac3 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_decc_d3.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac3
               
         END DISPLAY
         DISPLAY ARRAY g_decc_d4 TO s_detail4.* ATTRIBUTE(COUNT=g_detail_cnt4) 

                
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail4")
               LET l_ac4 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_decc_d4.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac4
               
         END DISPLAY
         DISPLAY ARRAY g_decc_d5 TO s_detail5.* ATTRIBUTE(COUNT=g_detail_cnt5) 
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail5")
               LET l_ac5 = g_detail_idx
               DISPLAY g_detail_idx TO FORMONLY.h_index
               DISPLAY g_decc_d5.getLength() TO FORMONLY.h_count
               LET g_master_idx = l_ac5
               
         END DISPLAY
         CONSTRUCT g_wc_master ON prdwunit,prdwsite
              FROM prdwunit,prdwsite
         
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD prdwunit
               ###  ### start ###
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where = "1=1"
#               CALL q_ooea001()
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdwunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO prdwunit
               ###  ### end ###
         
            ON ACTION controlp INFIELD prdwsite
               ###  ### start ###
               INITIALIZE g_qryparam.* TO NULL 
               LET g_qryparam.state = "c"
               LET g_qryparam.reqry = FALSE
#               LET g_qryparam.where = "1=1"
#               CALL q_ooea001()
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdwsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO prdwsite
               ###  ### end ###
               
            AFTER CONSTRUCT 
               
         END CONSTRUCT 
         
         INPUT g_bdate,g_edate,g_num1,g_num2,g_sel1,g_sel2,g_sel3,g_sel4
          FROM bdate,edate,num1,num2,sel1,sel2,sel3,sel4
          ATTRIBUTE(WITHOUT DEFAULTS)
          
            BEFORE INPUT 
               DISPLAY g_bdate,g_edate,g_num1,g_num2,g_sel1,g_sel2,g_sel3,g_sel4
                    TO bdate,edate,num1,num2,sel1,sel2,sel3,sel4
            
            AFTER FIELD bdate
               IF NOT cl_null(g_bdate) THEN 
                  IF NOT cl_null(g_edate) THEN 
                     IF g_bdate > g_edate THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00063'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_bdate = ''
                        NEXT FIELD CURRENT 
                     END IF 
                  END IF 
               END IF 
               
            AFTER FIELD edate 
               IF NOT cl_null(g_edate) THEN 
                  IF NOT cl_null(g_bdate) THEN 
                     IF g_bdate > g_edate THEN 
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'ast-00063'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
         
                        LET g_edate = ''
                        NEXT FIELD CURRENT 
                     END IF 
                  END IF 
               END IF 
         
            AFTER FIELD num1
               IF NOT cl_null(g_num1) THEN 
                  IF g_num1 < 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00083'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_num1 = 1
                     DISPLAY g_num1 TO num1
                     NEXT FIELD CURRENT 
                  END IF
               END IF 
         
            AFTER FIELD num2
               IF NOT cl_null(g_num2) THEN 
                  IF g_num1 < 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00083'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_num1 = 1
                     DISPLAY g_num2 TO num2
                     NEXT FIELD CURRENT 
                  END IF
               END IF 
               
            ON CHANGE sel1
               IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00055'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sel1 = 'Y'
                  DISPLAY g_sel1 TO sel1
               END IF 
               
            ON CHANGE sel2
               IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00055'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sel2 = 'Y'
                  DISPLAY g_sel2 TO sel2
               END IF 
               
            ON CHANGE sel3
               IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00055'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sel3 = 'Y'
                  DISPLAY g_sel3 TO sel3
               END IF 
               
            ON CHANGE sel4
               IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'acr-00055'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_sel4 = 'Y'
                  DISPLAY g_sel4 TO sel4
               END IF 
               
         END INPUT 
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL acrq511_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD prdwunit
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL acrq511_insert()
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
               CALL acrq511_query()
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
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL acrq511_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL acrq511_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_decc_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL acrq511_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL acrq511_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL acrq511_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL acrq511_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_decc_d.getLength()
               LET g_decc_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
         ON ACTION accept
            LET g_detail_idx = 1
            CALL acrq511_b_fill()
            IF g_decc_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_decc_d.getLength()
               LET g_decc_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_decc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_decc_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_decc_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_decc_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION acrq511_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_decc_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON prdw003,prdwunit,prdw100,prdw001,prdwl003,prdw002,prdw006,prcfl003,prdw007, 
          prcdl003,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008
           FROM s_detail1[1].b_prdw003,s_detail1[1].b_prdwunit,s_detail1[1].b_prdw100,s_detail1[1].b_prdw001, 
               s_detail1[1].b_prdwl003,s_detail1[1].b_prdw002,s_detail1[1].b_prdw006,s_detail1[1].b_prcfl003, 
               s_detail1[1].b_prdw007,s_detail1[1].b_prcdl003,s_detail1[1].b_prdd003,s_detail1[1].b_prdd004, 
               s_detail1[1].b_prdd005,s_detail1[1].b_prdd006,s_detail1[1].b_prdd007,s_detail1[1].b_prdd008 
 
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            NEXT FIELD prdwunit
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_prdw003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw003
            #add-point:BEFORE FIELD b_prdw003 name="construct.b.page1.b_prdw003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw003
            
            #add-point:AFTER FIELD b_prdw003 name="construct.a.page1.b_prdw003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdw003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw003
            #add-point:ON ACTION controlp INFIELD b_prdw003 name="construct.c.page1.b_prdw003"
            
            #END add-point
 
 
         #----<<b_prdwunit>>----
         #Ctrlp:construct.c.page1.b_prdwunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdwunit
            #add-point:ON ACTION controlp INFIELD b_prdwunit name="construct.c.page1.b_prdwunit"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdwunit  #顯示到畫面上
            NEXT FIELD b_prdwunit                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdwunit
            #add-point:BEFORE FIELD b_prdwunit name="construct.b.page1.b_prdwunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdwunit
            
            #add-point:AFTER FIELD b_prdwunit name="construct.a.page1.b_prdwunit"
            
            #END add-point
            
 
 
         #----<<prdwunit_desc>>----
         #----<<b_prdwsite>>----
         #----<<prdwsite_desc>>----
         #----<<b_prdw100>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw100
            #add-point:BEFORE FIELD b_prdw100 name="construct.b.page1.b_prdw100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw100
            
            #add-point:AFTER FIELD b_prdw100 name="construct.a.page1.b_prdw100"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdw100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw100
            #add-point:ON ACTION controlp INFIELD b_prdw100 name="construct.c.page1.b_prdw100"
            
            #END add-point
 
 
         #----<<b_prdw001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw001
            #add-point:BEFORE FIELD b_prdw001 name="construct.b.page1.b_prdw001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw001
            
            #add-point:AFTER FIELD b_prdw001 name="construct.a.page1.b_prdw001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw001
            #add-point:ON ACTION controlp INFIELD b_prdw001 name="construct.c.page1.b_prdw001"
            
            #END add-point
 
 
         #----<<b_prdwl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdwl003
            #add-point:BEFORE FIELD b_prdwl003 name="construct.b.page1.b_prdwl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdwl003
            
            #add-point:AFTER FIELD b_prdwl003 name="construct.a.page1.b_prdwl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdwl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdwl003
            #add-point:ON ACTION controlp INFIELD b_prdwl003 name="construct.c.page1.b_prdwl003"
            
            #END add-point
 
 
         #----<<b_prdw002>>----
         #Ctrlp:construct.c.page1.b_prdw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw002
            #add-point:ON ACTION controlp INFIELD b_prdw002 name="construct.c.page1.b_prdw002"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prdl001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdw002  #顯示到畫面上
            NEXT FIELD b_prdw002                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw002
            #add-point:BEFORE FIELD b_prdw002 name="construct.b.page1.b_prdw002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw002
            
            #add-point:AFTER FIELD b_prdw002 name="construct.a.page1.b_prdw002"
            
            #END add-point
            
 
 
         #----<<b_prdw006>>----
         #Ctrlp:construct.c.page1.b_prdw006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw006
            #add-point:ON ACTION controlp INFIELD b_prdw006 name="construct.c.page1.b_prdw006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdw006  #顯示到畫面上
            NEXT FIELD b_prdw006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw006
            #add-point:BEFORE FIELD b_prdw006 name="construct.b.page1.b_prdw006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw006
            
            #add-point:AFTER FIELD b_prdw006 name="construct.a.page1.b_prdw006"
            
            #END add-point
            
 
 
         #----<<b_prcfl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prcfl003
            #add-point:BEFORE FIELD b_prcfl003 name="construct.b.page1.b_prcfl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prcfl003
            
            #add-point:AFTER FIELD b_prcfl003 name="construct.a.page1.b_prcfl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prcfl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prcfl003
            #add-point:ON ACTION controlp INFIELD b_prcfl003 name="construct.c.page1.b_prcfl003"
            
            #END add-point
 
 
         #----<<b_prdw007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdw007
            #add-point:BEFORE FIELD b_prdw007 name="construct.b.page1.b_prdw007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdw007
            
            #add-point:AFTER FIELD b_prdw007 name="construct.a.page1.b_prdw007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw007
            #add-point:ON ACTION controlp INFIELD b_prdw007 name="construct.c.page1.b_prdw007"
            
            #END add-point
 
 
         #----<<b_prcdl003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prcdl003
            #add-point:BEFORE FIELD b_prcdl003 name="construct.b.page1.b_prcdl003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prcdl003
            
            #add-point:AFTER FIELD b_prcdl003 name="construct.a.page1.b_prcdl003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prcdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prcdl003
            #add-point:ON ACTION controlp INFIELD b_prcdl003 name="construct.c.page1.b_prcdl003"
            
            #END add-point
 
 
         #----<<b_prdd003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd003
            #add-point:BEFORE FIELD b_prdd003 name="construct.b.page1.b_prdd003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd003
            
            #add-point:AFTER FIELD b_prdd003 name="construct.a.page1.b_prdd003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd003
            #add-point:ON ACTION controlp INFIELD b_prdd003 name="construct.c.page1.b_prdd003"
            
            #END add-point
 
 
         #----<<b_prdd004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd004
            #add-point:BEFORE FIELD b_prdd004 name="construct.b.page1.b_prdd004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd004
            
            #add-point:AFTER FIELD b_prdd004 name="construct.a.page1.b_prdd004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd004
            #add-point:ON ACTION controlp INFIELD b_prdd004 name="construct.c.page1.b_prdd004"
            
            #END add-point
 
 
         #----<<b_prdd005>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd005
            #add-point:BEFORE FIELD b_prdd005 name="construct.b.page1.b_prdd005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd005
            
            #add-point:AFTER FIELD b_prdd005 name="construct.a.page1.b_prdd005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd005
            #add-point:ON ACTION controlp INFIELD b_prdd005 name="construct.c.page1.b_prdd005"
            
            #END add-point
 
 
         #----<<b_prdd006>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd006
            #add-point:BEFORE FIELD b_prdd006 name="construct.b.page1.b_prdd006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd006
            
            #add-point:AFTER FIELD b_prdd006 name="construct.a.page1.b_prdd006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd006
            #add-point:ON ACTION controlp INFIELD b_prdd006 name="construct.c.page1.b_prdd006"
            
            #END add-point
 
 
         #----<<b_prdd007>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd007
            #add-point:BEFORE FIELD b_prdd007 name="construct.b.page1.b_prdd007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd007
            
            #add-point:AFTER FIELD b_prdd007 name="construct.a.page1.b_prdd007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd007
            #add-point:ON ACTION controlp INFIELD b_prdd007 name="construct.c.page1.b_prdd007"
            
            #END add-point
 
 
         #----<<b_prdd008>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_prdd008
            #add-point:BEFORE FIELD b_prdd008 name="construct.b.page1.b_prdd008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_prdd008
            
            #add-point:AFTER FIELD b_prdd008 name="construct.a.page1.b_prdd008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_prdd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd008
            #add-point:ON ACTION controlp INFIELD b_prdd008 name="construct.c.page1.b_prdd008"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc_master ON prdwunit,prdwsite
           FROM prdwunit,prdwsite

         BEFORE CONSTRUCT
         
         ON ACTION controlp INFIELD prdwunit
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = "1=1"
#            CALL q_ooea001()
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdwunit',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prdwunit
            ###  ### end ###

         ON ACTION controlp INFIELD prdwsite
            ###  ### start ###
            INITIALIZE g_qryparam.* TO NULL 
            LET g_qryparam.state = "c"
            LET g_qryparam.reqry = FALSE
#            LET g_qryparam.where = "1=1"
#            CALL q_ooea001()
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'prdwsite',g_site,'c') #150308-00001#1  By Ken add 'c' 150309
            CALL q_ooef001_24()
            DISPLAY g_qryparam.return1 TO prdwsite
            ###  ### end ###
            
         AFTER CONSTRUCT 
            
      END CONSTRUCT 
      
      INPUT g_bdate,g_edate,g_num1,g_num2,g_sel1,g_sel2,g_sel3,g_sel4
       FROM bdate,edate,num1,num2,sel1,sel2,sel3,sel4
       ATTRIBUTE(WITHOUT DEFAULTS)
       
         BEFORE INPUT 
            DISPLAY g_bdate,g_edate,g_num1,g_num2,g_sel1,g_sel2,g_sel3,g_sel4
                 TO bdate,edate,num1,num2,sel1,sel2,sel3,sel4
         
         AFTER FIELD bdate
            IF NOT cl_null(g_bdate) THEN 
               IF NOT cl_null(g_edate) THEN 
                  IF g_bdate > g_edate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00063'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_bdate = ''
                     NEXT FIELD CURRENT 
                  END IF 
               END IF 
            END IF 
            
         AFTER FIELD edate 
            IF NOT cl_null(g_edate) THEN 
               IF NOT cl_null(g_bdate) THEN 
                  IF g_bdate > g_edate THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ast-00063'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_edate = ''
                     NEXT FIELD CURRENT 
                  END IF 
               END IF 
            END IF 

         AFTER FIELD num1
            IF NOT cl_null(g_num1) THEN 
               IF g_num1 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00083'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_num1 = 1
                  DISPLAY g_num1 TO num1
                  NEXT FIELD CURRENT 
               END IF
            END IF 

         AFTER FIELD num2
            IF NOT cl_null(g_num2) THEN 
               IF g_num1 < 0 THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'ast-00083'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_num1 = 1
                  DISPLAY g_num2 TO num2
                  NEXT FIELD CURRENT 
               END IF
            END IF 
            
         ON CHANGE sel1
            IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00055'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sel1 = 'Y'
               DISPLAY g_sel1 TO sel1
            END IF 
            
         ON CHANGE sel2
            IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00055'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sel2 = 'Y'
               DISPLAY g_sel2 TO sel2
            END IF 
            
         ON CHANGE sel3
            IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00055'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sel3 = 'Y'
               DISPLAY g_sel3 TO sel3
            END IF 
            
         ON CHANGE sel4
            IF g_sel1 = 'N' AND g_sel2 = 'N' AND g_sel3 = 'N' AND g_sel4 = 'N' THEN 
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'acr-00055'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_sel4 = 'Y'
               DISPLAY g_sel4 TO sel4
            END IF 
            
      END INPUT 
      BEFORE DIALOG 
         NEXT FIELD prdwunit
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   IF cl_null(g_wc_master) THEN 
      LET g_wc_master = " 1=1"
   END IF 
   #end add-point
        
   LET g_error_show = 1
   CALL acrq511_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="acrq511.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION acrq511_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_str           STRING 
   DEFINE l_date          LIKE type_t.dat
   DEFINE l_date1         LIKE type_t.dat
   DEFINE l_date2         LIKE type_t.dat
   DEFINE l_where         STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
  
   LET l_where = s_aooi500_sql_where(g_prog,'deccsite')
   LET l_where = cl_replace_str(l_where,'deccsite','prdwsite') 
   LET l_str = ""
   IF g_sel1 = 'Y' THEN 
      LET l_str = "'1'"
   END IF 
   IF g_sel2 = 'Y' THEN 
      IF cl_null(l_str) THEN 
         LET l_str = "'2'"
      ELSE
         LET l_str = l_str,",'2'"
      END IF 
   END IF 
   IF g_sel3 = 'Y' THEN 
      IF cl_null(l_str) THEN 
         LET l_str = "'3'"
      ELSE
         LET l_str = l_str,",'3'"
      END IF 
   END IF
   IF g_sel4 = 'Y' THEN 
      IF cl_null(l_str) THEN 
         LET l_str = "'4'"
      ELSE
         LET l_str = l_str,",'4'"
      END IF 
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
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY decc_t.decc001, 
       decc_t.decc002,decc_t.decc023) AS RANK FROM decc_t",
 
 
                     "",
                     " WHERE deccent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("decc_t"),
                     " ORDER BY decc_t.decc001,decc_t.decc002,decc_t.decc023"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
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
 
   LET g_sql = "SELECT '','','','','','','','','','','','','','','','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   LET g_sql1 = " SELECT  DISTINCT prdw003,prdwunit,a.ooefl003,prdwsite,b.ooefl003,prdw100,prdw001,prdwl003,",
                "         prdw002,prdw006,prcfl003,prdw007,prcdl003,prdd003,prdd004,prdd005,prdd006,",
                "         prdd007,prdd008",
                "   FROM  prdd_t,prdw_t LEFT JOIN ooefl_t a ON a.ooeflent = prdwent AND a.ooefl001 = prdwunit AND a.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN ooefl_t b ON b.ooeflent = prdwent AND b.ooefl001 = prdwsite AND b.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN prdwl_t ON prdwlent = prdwent AND prdwlsite = prdwsite AND prdwl001 = prdw001 AND prdwl002 = '",g_lang,"'",
                "                       LEFT JOIN prcfl_t ON prcflent = prdwent AND prcfl001 = prdw006 AND prcfl002 = '",g_lang,"'",
                "                       LEFT JOIN prcdl_t ON prcdlent = prdwent AND prcdl001 = prdw007 AND prcdl002 = '",g_lang,"'",
                "  WHERE prdwent = prddent ",
               #"    AND prdwsite = prddsite ",     #mark by yangxf 20160225
                "    AND prdw001 = prdd001 ",
                "    AND prdwent = ",g_enterprise,
                "    AND prdd003 >= '",g_bdate,"' AND prdd004 <= '",g_edate,"'",
                "    AND prdw026 IN (",l_str,")",
                "    AND prdw099 ='Y'",
                "    AND prdwstus='Y'",
                "    AND ",g_wc_master CLIPPED ,
                "    AND ",l_where CLIPPED
   #当前执行单据             
   LET g_sql = " SELECT  DISTINCT 'N',prdw003,prdwunit,a.ooefl003,prdwsite,b.ooefl003,prdw100,prdw001,prdwl003,",
                "         prdw002,prdw006,prcfl003,prdw007,prcdl003,prdd003,prdd004,prdd005,prdd006,",
                "         prdd007,prdd008",
                "   FROM  prdd_t,prdw_t LEFT JOIN ooefl_t a ON a.ooeflent = prdwent AND a.ooefl001 = prdwunit AND a.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN ooefl_t b ON b.ooeflent = prdwent AND b.ooefl001 = prdwsite AND b.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN prdwl_t ON prdwlent = prdwent AND prdwlsite = prdwsite AND prdwl001 = prdw001 AND prdwl002 = '",g_lang,"'",
                "                       LEFT JOIN prcfl_t ON prcflent = prdwent AND prcfl001 = prdw006 AND prcfl002 = '",g_lang,"'",
                "                       LEFT JOIN prcdl_t ON prcdlent = prdwent AND prcdl001 = prdw007 AND prcdl002 = '",g_lang,"'",
                "  WHERE prdwent = prddent ",
                "    AND prdw001 = prdd001 ",
                "    AND prdd003 >= '",g_bdate,"' AND prdd004 <= '",g_edate,"'",
                "    AND prdw026 IN (",l_str,")",
                "    AND prdw099 ='Y'",
                "    AND prdwstus='Y'",
                "    AND ",g_wc_master CLIPPED,
                "    AND ",l_where CLIPPED,
                "    AND '",g_today,"' BETWEEN prdd003 AND prdd004 AND prdwent = ? "
   #即将启动单据
   LET l_date = g_today + g_num1
   LET g_sql2 = g_sql1," AND '",l_date,"' BETWEEN prdd003 AND prdd004 ",
                       " AND '",g_today,"' <= prdd003 ",
                       " AND prdwent = '",g_enterprise,"'"
   #即将终止单据
   LET l_date1 = g_today + g_num2
   LET l_date2 = l_date1 + 1
   LET g_sql3 = g_sql1," AND '",l_date1,"' BETWEEN prdd003 AND prdd004 ",
                       " AND '",l_date2,"' >= prdd004 ",
                       " AND prdwent = '",g_enterprise,"'"
   #已经终止单据
   LET g_sql5 = g_sql1," AND '",g_today,"' > prdd004",
                       " AND prdwent = '",g_enterprise,"'"
   LET l_where = cl_replace_str(l_where,"prdw","prda") 
   #未审核单据
   LET g_sql4 = " SELECT  DISTINCT prda003,prdaunit,a.ooefl003,prdasite,b.ooefl003,prdadocdt,prda001,prdal002,",
                "         prda002,prda006,prcfl003,prda007,prcdl003,prdd003,prdd004,prdd005,prdd006,",
                "         prdd007,prdd008",
                "   FROM  prdd_t,prda_t LEFT JOIN ooefl_t a ON a.ooeflent = prdaent AND a.ooefl001 = prdaunit AND a.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN ooefl_t b ON b.ooeflent = prdaent AND b.ooefl001 = prdasite AND b.ooefl002 = '",g_lang,"'",
                "                       LEFT JOIN prdal_t ON prdalent = prdaent AND prdaldocno = prdadocno AND prdal001 = '",g_lang,"'",
                "                       LEFT JOIN prcfl_t ON prcflent = prdaent AND prcfl001 = prda006 AND prcfl002 = '",g_lang,"'",
                "                       LEFT JOIN prcdl_t ON prcdlent = prdaent AND prcdl001 = prda007 AND prcdl002 = '",g_lang,"'",
                "  WHERE prdaent = prddent ",
               #"    AND prdasite = prddsite ",    #mark by yangxf 20160225
                "    AND prda001 = prdd001 ",
                "    AND prdd003 >= '",g_bdate,"' AND prdd004 <= '",g_edate,"'",
                "    AND prda026 IN (",l_str,")",
                "    AND prdastus='N'",
                "    AND prdaent = '",g_enterprise,"'",
                "    AND ",g_wc_master CLIPPED ,
                "    AND ",l_where CLIPPED

   PREPARE acrq511_pb2 FROM g_sql2
   DECLARE b_fill_curs2 CURSOR FOR acrq511_pb2
   
   PREPARE acrq511_pb3 FROM g_sql3
   DECLARE b_fill_curs3 CURSOR FOR acrq511_pb3
   
   PREPARE acrq511_pb4 FROM g_sql4
   DECLARE b_fill_curs4 CURSOR FOR acrq511_pb4
   
   PREPARE acrq511_pb5 FROM g_sql5
   DECLARE b_fill_curs5 CURSOR FOR acrq511_pb5
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE acrq511_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR acrq511_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_decc_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_decc_d2.clear()
   CALL g_decc_d3.clear()
   CALL g_decc_d4.clear()
   CALL g_decc_d5.clear()
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_decc_d[l_ac].sel,g_decc_d[l_ac].prdw003,g_decc_d[l_ac].prdwunit,g_decc_d[l_ac].prdwunit_desc, 
       g_decc_d[l_ac].prdwsite,g_decc_d[l_ac].prdwsite_desc,g_decc_d[l_ac].prdw100,g_decc_d[l_ac].prdw001, 
       g_decc_d[l_ac].prdwl003,g_decc_d[l_ac].prdw002,g_decc_d[l_ac].prdw006,g_decc_d[l_ac].prcfl003, 
       g_decc_d[l_ac].prdw007,g_decc_d[l_ac].prcdl003,g_decc_d[l_ac].prdd003,g_decc_d[l_ac].prdd004, 
       g_decc_d[l_ac].prdd005,g_decc_d[l_ac].prdd006,g_decc_d[l_ac].prdd007,g_decc_d[l_ac].prdd008
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_decc_d[l_ac].statepic = cl_get_actipic(g_decc_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL acrq511_detail_show("'1'")      
 
      CALL acrq511_decc_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_decc_d.deleteElement(g_decc_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   LET g_cnt2 = l_ac2
   LET l_ac2 = 1  
   FOREACH b_fill_curs2 INTO g_decc_d2[l_ac2].prdw003,g_decc_d2[l_ac2].prdwunit,g_decc_d2[l_ac2].prdwunit_desc, 
       g_decc_d2[l_ac2].prdwsite,g_decc_d2[l_ac2].prdwsite_desc,g_decc_d2[l_ac2].prdw100,g_decc_d2[l_ac2].prdw001, 
       g_decc_d2[l_ac2].prdwl003,g_decc_d2[l_ac2].prdw002,g_decc_d2[l_ac2].prdw006,g_decc_d2[l_ac2].prcfl003, 
       g_decc_d2[l_ac2].prdw007,g_decc_d2[l_ac2].prcdl003,g_decc_d2[l_ac2].prdd003,g_decc_d2[l_ac2].prdd004, 
       g_decc_d2[l_ac2].prdd005,g_decc_d2[l_ac2].prdd006,g_decc_d2[l_ac2].prdd007,g_decc_d2[l_ac2].prdd008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF    
      LET l_ac2 = l_ac2 + 1
      IF l_ac2 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_decc_d2.deleteElement(g_decc_d2.getLength())   
   LET g_detail_cnt2 = l_ac2 - 1 
   LET l_ac2 = g_cnt2
   
   LET g_cnt2 = l_ac3
   LET l_ac3 = 1  
   FOREACH b_fill_curs3 INTO g_decc_d3[l_ac3].prdw003,g_decc_d3[l_ac3].prdwunit,g_decc_d3[l_ac3].prdwunit_desc, 
       g_decc_d3[l_ac3].prdwsite,g_decc_d3[l_ac3].prdwsite_desc,g_decc_d3[l_ac3].prdw100,g_decc_d3[l_ac3].prdw001, 
       g_decc_d3[l_ac3].prdwl003,g_decc_d3[l_ac3].prdw002,g_decc_d3[l_ac3].prdw006,g_decc_d3[l_ac3].prcfl003, 
       g_decc_d3[l_ac3].prdw007,g_decc_d3[l_ac3].prcdl003,g_decc_d3[l_ac3].prdd003,g_decc_d3[l_ac3].prdd004, 
       g_decc_d3[l_ac3].prdd005,g_decc_d3[l_ac3].prdd006,g_decc_d3[l_ac3].prdd007,g_decc_d3[l_ac3].prdd008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF    
      LET l_ac3 = l_ac3 + 1
      IF l_ac3 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_decc_d3.deleteElement(g_decc_d3.getLength())   
   LET g_detail_cnt3 = l_ac3 - 1 
   LET l_ac3 = g_cnt2
   
   LET g_cnt2 = l_ac4
   LET l_ac4 = 1  
   FOREACH b_fill_curs4 INTO g_decc_d4[l_ac4].prdw003,g_decc_d4[l_ac4].prdwunit,g_decc_d4[l_ac4].prdwunit_desc, 
       g_decc_d4[l_ac4].prdwsite,g_decc_d4[l_ac4].prdwsite_desc,g_decc_d4[l_ac4].prdw100,g_decc_d4[l_ac4].prdw001, 
       g_decc_d4[l_ac4].prdwl003,g_decc_d4[l_ac4].prdw002,g_decc_d4[l_ac4].prdw006,g_decc_d4[l_ac4].prcfl003, 
       g_decc_d4[l_ac4].prdw007,g_decc_d4[l_ac4].prcdl003,g_decc_d4[l_ac4].prdd003,g_decc_d4[l_ac4].prdd004, 
       g_decc_d4[l_ac4].prdd005,g_decc_d4[l_ac4].prdd006,g_decc_d4[l_ac4].prdd007,g_decc_d4[l_ac4].prdd008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF    
      LET l_ac4 = l_ac4 + 1
      IF l_ac4 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_decc_d4.deleteElement(g_decc_d4.getLength())   
   LET g_detail_cnt4 = l_ac4 - 1 
   LET l_ac4 = g_cnt2
   
   LET g_cnt2 = l_ac5
   LET l_ac5 = 1  
   FOREACH b_fill_curs5 INTO g_decc_d5[l_ac5].prdw003,g_decc_d5[l_ac5].prdwunit,g_decc_d5[l_ac5].prdwunit_desc, 
       g_decc_d5[l_ac5].prdwsite,g_decc_d5[l_ac5].prdwsite_desc,g_decc_d5[l_ac5].prdw100,g_decc_d5[l_ac5].prdw001, 
       g_decc_d5[l_ac5].prdwl003,g_decc_d5[l_ac5].prdw002,g_decc_d5[l_ac5].prdw006,g_decc_d5[l_ac5].prcfl003, 
       g_decc_d5[l_ac5].prdw007,g_decc_d5[l_ac5].prcdl003,g_decc_d5[l_ac5].prdd003,g_decc_d5[l_ac5].prdd004, 
       g_decc_d5[l_ac5].prdd005,g_decc_d5[l_ac5].prdd006,g_decc_d5[l_ac5].prdd007,g_decc_d5[l_ac5].prdd008
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF    
      LET l_ac5 = l_ac5 + 1
      IF l_ac5 > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   CALL g_decc_d5.deleteElement(g_decc_d5.getLength())   
   LET g_detail_cnt5 = l_ac5 - 1 
   LET l_ac5 = g_cnt2
   #end add-point
 
   LET g_detail_cnt = g_decc_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE acrq511_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL acrq511_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL acrq511_detail_action_trans()
 
   IF g_decc_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL acrq511_fetch()
   END IF
   
      CALL acrq511_filter_show('prdw003','b_prdw003')
   CALL acrq511_filter_show('prdwunit','b_prdwunit')
   CALL acrq511_filter_show('prdw100','b_prdw100')
   CALL acrq511_filter_show('prdw001','b_prdw001')
   CALL acrq511_filter_show('prdwl003','b_prdwl003')
   CALL acrq511_filter_show('prdw002','b_prdw002')
   CALL acrq511_filter_show('prdw006','b_prdw006')
   CALL acrq511_filter_show('prcfl003','b_prcfl003')
   CALL acrq511_filter_show('prdw007','b_prdw007')
   CALL acrq511_filter_show('prcdl003','b_prcdl003')
   CALL acrq511_filter_show('prdd003','b_prdd003')
   CALL acrq511_filter_show('prdd004','b_prdd004')
   CALL acrq511_filter_show('prdd005','b_prdd005')
   CALL acrq511_filter_show('prdd006','b_prdd006')
   CALL acrq511_filter_show('prdd007','b_prdd007')
   CALL acrq511_filter_show('prdd008','b_prdd008')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION acrq511_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="acrq511.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION acrq511_detail_show(ps_page)
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
 
{<section id="acrq511.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION acrq511_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON prdw003,prdwunit,prdw100,prdw001,prdwl003,prdw002,prdw006,prcfl003,prdw007, 
          prcdl003,prdd003,prdd004,prdd005,prdd006,prdd007,prdd008
                          FROM s_detail1[1].b_prdw003,s_detail1[1].b_prdwunit,s_detail1[1].b_prdw100, 
                              s_detail1[1].b_prdw001,s_detail1[1].b_prdwl003,s_detail1[1].b_prdw002, 
                              s_detail1[1].b_prdw006,s_detail1[1].b_prcfl003,s_detail1[1].b_prdw007, 
                              s_detail1[1].b_prcdl003,s_detail1[1].b_prdd003,s_detail1[1].b_prdd004, 
                              s_detail1[1].b_prdd005,s_detail1[1].b_prdd006,s_detail1[1].b_prdd007,s_detail1[1].b_prdd008 
 
 
         BEFORE CONSTRUCT
                     DISPLAY acrq511_filter_parser('prdw003') TO s_detail1[1].b_prdw003
            DISPLAY acrq511_filter_parser('prdwunit') TO s_detail1[1].b_prdwunit
            DISPLAY acrq511_filter_parser('prdw100') TO s_detail1[1].b_prdw100
            DISPLAY acrq511_filter_parser('prdw001') TO s_detail1[1].b_prdw001
            DISPLAY acrq511_filter_parser('prdwl003') TO s_detail1[1].b_prdwl003
            DISPLAY acrq511_filter_parser('prdw002') TO s_detail1[1].b_prdw002
            DISPLAY acrq511_filter_parser('prdw006') TO s_detail1[1].b_prdw006
            DISPLAY acrq511_filter_parser('prcfl003') TO s_detail1[1].b_prcfl003
            DISPLAY acrq511_filter_parser('prdw007') TO s_detail1[1].b_prdw007
            DISPLAY acrq511_filter_parser('prcdl003') TO s_detail1[1].b_prcdl003
            DISPLAY acrq511_filter_parser('prdd003') TO s_detail1[1].b_prdd003
            DISPLAY acrq511_filter_parser('prdd004') TO s_detail1[1].b_prdd004
            DISPLAY acrq511_filter_parser('prdd005') TO s_detail1[1].b_prdd005
            DISPLAY acrq511_filter_parser('prdd006') TO s_detail1[1].b_prdd006
            DISPLAY acrq511_filter_parser('prdd007') TO s_detail1[1].b_prdd007
            DISPLAY acrq511_filter_parser('prdd008') TO s_detail1[1].b_prdd008
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_prdw003>>----
         #Ctrlp:construct.c.filter.page1.b_prdw003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw003
            #add-point:ON ACTION controlp INFIELD b_prdw003 name="construct.c.filter.page1.b_prdw003"
            
            #END add-point
 
 
         #----<<b_prdwunit>>----
         #Ctrlp:construct.c.page1.b_prdwunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdwunit
            #add-point:ON ACTION controlp INFIELD b_prdwunit name="construct.c.filter.page1.b_prdwunit"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdwunit  #顯示到畫面上
            NEXT FIELD b_prdwunit                     #返回原欄位
    



            #END add-point
 
 
         #----<<prdwunit_desc>>----
         #----<<b_prdwsite>>----
         #----<<prdwsite_desc>>----
         #----<<b_prdw100>>----
         #Ctrlp:construct.c.filter.page1.b_prdw100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw100
            #add-point:ON ACTION controlp INFIELD b_prdw100 name="construct.c.filter.page1.b_prdw100"
            
            #END add-point
 
 
         #----<<b_prdw001>>----
         #Ctrlp:construct.c.filter.page1.b_prdw001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw001
            #add-point:ON ACTION controlp INFIELD b_prdw001 name="construct.c.filter.page1.b_prdw001"
            
            #END add-point
 
 
         #----<<b_prdwl003>>----
         #Ctrlp:construct.c.filter.page1.b_prdwl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdwl003
            #add-point:ON ACTION controlp INFIELD b_prdwl003 name="construct.c.filter.page1.b_prdwl003"
            
            #END add-point
 
 
         #----<<b_prdw002>>----
         #Ctrlp:construct.c.page1.b_prdw002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw002
            #add-point:ON ACTION controlp INFIELD b_prdw002 name="construct.c.filter.page1.b_prdw002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prdl001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdw002  #顯示到畫面上
            NEXT FIELD b_prdw002                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_prdw006>>----
         #Ctrlp:construct.c.page1.b_prdw006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw006
            #add-point:ON ACTION controlp INFIELD b_prdw006 name="construct.c.filter.page1.b_prdw006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_prcf001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_prdw006  #顯示到畫面上
            NEXT FIELD b_prdw006                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_prcfl003>>----
         #Ctrlp:construct.c.filter.page1.b_prcfl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prcfl003
            #add-point:ON ACTION controlp INFIELD b_prcfl003 name="construct.c.filter.page1.b_prcfl003"
            
            #END add-point
 
 
         #----<<b_prdw007>>----
         #Ctrlp:construct.c.filter.page1.b_prdw007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdw007
            #add-point:ON ACTION controlp INFIELD b_prdw007 name="construct.c.filter.page1.b_prdw007"
            
            #END add-point
 
 
         #----<<b_prcdl003>>----
         #Ctrlp:construct.c.filter.page1.b_prcdl003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prcdl003
            #add-point:ON ACTION controlp INFIELD b_prcdl003 name="construct.c.filter.page1.b_prcdl003"
            
            #END add-point
 
 
         #----<<b_prdd003>>----
         #Ctrlp:construct.c.filter.page1.b_prdd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd003
            #add-point:ON ACTION controlp INFIELD b_prdd003 name="construct.c.filter.page1.b_prdd003"
            
            #END add-point
 
 
         #----<<b_prdd004>>----
         #Ctrlp:construct.c.filter.page1.b_prdd004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd004
            #add-point:ON ACTION controlp INFIELD b_prdd004 name="construct.c.filter.page1.b_prdd004"
            
            #END add-point
 
 
         #----<<b_prdd005>>----
         #Ctrlp:construct.c.filter.page1.b_prdd005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd005
            #add-point:ON ACTION controlp INFIELD b_prdd005 name="construct.c.filter.page1.b_prdd005"
            
            #END add-point
 
 
         #----<<b_prdd006>>----
         #Ctrlp:construct.c.filter.page1.b_prdd006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd006
            #add-point:ON ACTION controlp INFIELD b_prdd006 name="construct.c.filter.page1.b_prdd006"
            
            #END add-point
 
 
         #----<<b_prdd007>>----
         #Ctrlp:construct.c.filter.page1.b_prdd007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd007
            #add-point:ON ACTION controlp INFIELD b_prdd007 name="construct.c.filter.page1.b_prdd007"
            
            #END add-point
 
 
         #----<<b_prdd008>>----
         #Ctrlp:construct.c.filter.page1.b_prdd008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_prdd008
            #add-point:ON ACTION controlp INFIELD b_prdd008 name="construct.c.filter.page1.b_prdd008"
            
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
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL acrq511_filter_show('prdw003','b_prdw003')
   CALL acrq511_filter_show('prdwunit','b_prdwunit')
   CALL acrq511_filter_show('prdw100','b_prdw100')
   CALL acrq511_filter_show('prdw001','b_prdw001')
   CALL acrq511_filter_show('prdwl003','b_prdwl003')
   CALL acrq511_filter_show('prdw002','b_prdw002')
   CALL acrq511_filter_show('prdw006','b_prdw006')
   CALL acrq511_filter_show('prcfl003','b_prcfl003')
   CALL acrq511_filter_show('prdw007','b_prdw007')
   CALL acrq511_filter_show('prcdl003','b_prcdl003')
   CALL acrq511_filter_show('prdd003','b_prdd003')
   CALL acrq511_filter_show('prdd004','b_prdd004')
   CALL acrq511_filter_show('prdd005','b_prdd005')
   CALL acrq511_filter_show('prdd006','b_prdd006')
   CALL acrq511_filter_show('prdd007','b_prdd007')
   CALL acrq511_filter_show('prdd008','b_prdd008')
 
    
   CALL acrq511_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION acrq511_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
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
 
{<section id="acrq511.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION acrq511_filter_show(ps_field,ps_object)
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
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = acrq511_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.insert" >}
#+ insert
PRIVATE FUNCTION acrq511_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="acrq511.modify" >}
#+ modify
PRIVATE FUNCTION acrq511_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.reproduce" >}
#+ reproduce
PRIVATE FUNCTION acrq511_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.delete" >}
#+ delete
PRIVATE FUNCTION acrq511_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="acrq511.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION acrq511_detail_action_trans()
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
 
{<section id="acrq511.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION acrq511_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
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
            IF g_decc_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_decc_d.getLength() AND g_decc_d.getLength() > 0
            LET g_detail_idx = g_decc_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_decc_d.getLength() THEN
               LET g_detail_idx = g_decc_d.getLength()
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
 
{<section id="acrq511.mask_functions" >}
 &include "erp/acr/acrq511_mask.4gl"
 
{</section>}
 
{<section id="acrq511.other_function" readonly="Y" >}

 
{</section>}
 
