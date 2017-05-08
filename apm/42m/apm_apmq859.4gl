#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq859.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2015-03-11 16:33:03), PR版次:0004(2016-03-08 10:36:15)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: apmq859
#+ Description: 採購收貨預約查詢作業
#+ Creator....: 02159(2014-12-05 16:25:51)
#+ Modifier...: 02749 -SD/PR- 06814
 
{</section>}
 
{<section id="apmq859.global" >}
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
PRIVATE TYPE type_g_pmel_d RECORD
       
       sel LIKE type_t.chr1, 
   pmelsite LIKE pmel_t.pmelsite, 
   pmelsite_desc LIKE type_t.chr500, 
   pmeldocno LIKE pmel_t.pmeldocno, 
   pmel006 LIKE pmel_t.pmel006, 
   pmel006_desc LIKE type_t.chr500, 
   pmel007 LIKE pmel_t.pmel007, 
   pmel007_desc LIKE type_t.chr500, 
   pmel001 LIKE pmel_t.pmel001, 
   pmel002 LIKE pmel_t.pmel002, 
   pmel003 LIKE pmel_t.pmel003, 
   pmel003_desc LIKE type_t.chr500, 
   l_sum_pmem012 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_pmel2_d RECORD
       pmemseq LIKE pmem_t.pmemseq, 
   pmem001 LIKE pmem_t.pmem001, 
   pmem002 LIKE pmem_t.pmem002, 
   pmem003 LIKE pmem_t.pmem003, 
   pmem004 LIKE pmem_t.pmem004, 
   pmem005 LIKE pmem_t.pmem005, 
   pmem006 LIKE pmem_t.pmem006, 
   pmem007 LIKE pmem_t.pmem007, 
   pmem007_desc LIKE type_t.chr500, 
   pmem007_desc_1 LIKE type_t.chr500, 
   pmem008 LIKE pmem_t.pmem008, 
   pmem008_desc LIKE type_t.chr500, 
   pmdn020 LIKE pmdn_t.pmdn020, 
   pmem009 LIKE pmem_t.pmem009, 
   pmem009_desc LIKE type_t.chr500, 
   pmem010 LIKE pmem_t.pmem010, 
   pmem011 LIKE pmem_t.pmem011, 
   pmem011_desc LIKE type_t.chr500, 
   pmem012 LIKE pmem_t.pmem012, 
   pmem013 LIKE pmem_t.pmem013, 
   pmem014 LIKE pmem_t.pmem014, 
   pmem014_desc LIKE type_t.chr500, 
   pmem015 LIKE pmem_t.pmem015, 
   pmem015_desc LIKE type_t.chr500, 
   pmem016 LIKE pmem_t.pmem016, 
   pmem020 LIKE pmem_t.pmem020, 
   pmem017 LIKE pmem_t.pmem017, 
   pmem017_desc LIKE type_t.chr500, 
   pmem018 LIKE pmem_t.pmem018, 
   pmem018_desc LIKE type_t.chr500, 
   pmem019 LIKE pmem_t.pmem019, 
   pmem019_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmel_d            DYNAMIC ARRAY OF type_g_pmel_d
DEFINE g_pmel_d_t          type_g_pmel_d
DEFINE g_pmel2_d     DYNAMIC ARRAY OF type_g_pmel2_d
DEFINE g_pmel2_d_t   type_g_pmel2_d
 
 
 
 
 
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
 
{<section id="apmq859.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   CREATE TEMP TABLE apmq859_pmem(
      pmemdocno       VARCHAR(20),      #採購單號
      pmemseq       INTEGER,      #採購項次
      pmem007         VARCHAR(40),        #商品編號
      pmem011         VARCHAR(10),        #收貨單位
      pmem012         DECIMAL(20,6),        #預約收貨/送貨數量
      imaa104         VARCHAR(10),        #庫存單位
      sum_pmem012     DECIMAL(20,6)     #庫存數量
   )   
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
   DECLARE apmq859_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq859_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq859_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq859 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq859_init()   
 
      #進入選單 Menu (="N")
      CALL apmq859_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq859
      
   END IF 
   
   CLOSE apmq859_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apmq859_pmem
   CALL s_aooi500_drop_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq859.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq859_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #150308-00001#3 150309 pomelo add
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_pmem005','2055') 
   CALL cl_set_combo_scc('b_pmdn020','2036') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success   #150308-00001#3 150309 pomelo add
   #end add-point
 
   CALL apmq859_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq859.default_search" >}
PRIVATE FUNCTION apmq859_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmeldocno = '", g_argv[01], "' AND "
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
 
{<section id="apmq859.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq859_ui_dialog() 
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
 
   
   CALL apmq859_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmel_d.clear()
         CALL g_pmel2_d.clear()
 
 
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
 
         CALL apmq859_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON pmelsite,pmeldocno,pmeldocdt,pmem001,pmel002,
                                   pmel003,pmel004,pmel006,pmel007,pmem007
                                   
            ON ACTION controlp INFIELD pmelsite #收貨組織
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmelsite',g_site,'c') #150308-00001#3 150309 pomelo add 'c'
               CALL q_ooef001_24()                     #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmelsite  #顯示到畫面上
               
               NEXT FIELD CURRENT

            ON ACTION controlp INFIELD pmeldocno #預約單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '1' #1:收貨預約單
               CALL q_pmeldocno()
               DISPLAY g_qryparam.return1 TO pmeldocno  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD pmem001 #採購單號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = "pmdlstus ='Y'"
               CALL q_pmdldocno()
               DISPLAY g_qryparam.return1 TO pmem001  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD pmel003 #預計到庫時段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = '274'
               CALL q_oocq002()
               DISPLAY g_qryparam.return1 TO pmel003  #顯示到畫面上
               NEXT FIELD CURRENT               

            ON ACTION controlp INFIELD pmel004 #預約人員
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmel004  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD pmel006 #預約供應商
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmel006  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD pmel007 #送貨供應商
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_pmaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmel007  #顯示到畫面上
               NEXT FIELD CURRENT
               
            ON ACTION controlp INFIELD pmem007 #商品編號
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO pmem007  #顯示到畫面上
               NEXT FIELD CURRENT 
               
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmel_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq859_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq859_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_pmel2_d TO s_detail2.*
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
            CALL apmq859_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)
            #end add-point
            NEXT FIELD pmelsite
 
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
            CALL apmq859_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmel_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmel2_d)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq859_b_fill()
 
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
            CALL apmq859_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq859_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq859_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq859_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmel_d.getLength()
               LET g_pmel_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmel_d.getLength()
               LET g_pmel_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmel_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmel_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmel_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmel_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq859_filter()
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
 
{<section id="apmq859.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq859_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_where         STRING   #150826-00013# 20160308 add by beckxie
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'pmelsite') RETURNING l_where   #150826-00013# 20160308 add by beckxie
   LET ls_wc = ls_wc CLIPPED," AND ",l_where
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
 
   CALL g_pmel_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   #資料清空 才不會一直累加 
   DELETE FROM apmq859_pmem;
   LET l_sql = "INSERT INTO apmq859_pmem (pmemdocno,pmemseq,pmem007,pmem011,pmem012,imaa104,sum_pmem012)",
               "SELECT pmemdocno,pmemseq,pmem007,pmem011,pmem012,imaa104,-1",
               "  FROM pmel_t ",
               "     LEFT JOIN pmem_t ON pmement = pmelent AND pmeldocno = pmemdocno,imaa_t",
               " WHERE pmelent = '",g_enterprise,"' ",
               "   AND pmement = imaaent ",
               "   AND pmem007 = imaa001 ",
               "   AND ",ls_wc
   CALL s_transaction_begin()               
   PREPARE apmq859_ins_pmem FROM l_sql
   EXECUTE apmq859_ins_pmem
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Insert apmq859_pmem"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CALL s_transaction_end('N','0')
   END IF
   CALL apmq859_update_qty()   
   CALL s_transaction_end('Y','0')
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',pmelsite,'',pmeldocno,pmel006,'',pmel007,'',pmel001,pmel002, 
       pmel003,'',''  ,DENSE_RANK() OVER( ORDER BY pmel_t.pmeldocno) AS RANK FROM pmel_t",
 
#table2
                     " LEFT JOIN pmem_t ON pmement = pmelent AND pmeldocno = pmemdocno",
 
                     "",
                     " WHERE pmelent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmel_t"),
                     " ORDER BY pmel_t.pmeldocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
      #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET ls_sql_rank = "SELECT  UNIQUE '',pmelsite,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE pmelent = ooeflent AND pmelsite = ooefl001 ",
                     "            AND ooefl002 = '",g_dlang,"') pmelsite_desc,",  #收貨組織說明
                     "        pmeldocno,pmel006,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE pmelent = pmaalent AND pmel006  = pmaal001 ",
                     "            AND pmaal002 = '",g_dlang,"') pmel006_desc,",  #預約供應商說明
                     "        pmel007,",
                     "        (SELECT pmaal004",
                     "           FROM pmaal_t",
                     "          WHERE pmelent = pmaalent AND pmel007  = pmaal001 ",
                     "            AND pmaal002 = '",g_dlang,"') pmel007_desc,",  #送貨供應商說明
                     "        pmel001,pmel002,pmel003,",
                     "        (SELECT oocql004",
                     "           FROM oocql_t",
                     "          WHERE pmelent = oocqlent AND pmel003  = oocql002 AND oocql001='274' ",
                     "            AND oocql003 = '",g_dlang,"') pmel003_desc,",  #預計到庫時段說明
                     "         '',DENSE_RANK() OVER( ORDER BY pmel_t.pmeldocno) AS RANK",
                     "  FROM pmel_t ",
                     "     LEFT OUTER JOIN pmem_t ON pmelent = pmement  AND pmemdocno = pmeldocno",
                     " WHERE pmelent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmel_t"),
                     " ORDER BY pmeldocno"               
   #150826-00013#1 效能調整 20150909 add by beckxie---E      
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
 
   LET g_sql = "SELECT '',pmelsite,'',pmeldocno,pmel006,'',pmel007,'',pmel001,pmel002,pmel003,'',''", 
 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#1 效能調整 20150909 mark by beckxie---S
   #LET g_sql = "SELECT  UNIQUE '',pmelsite,t1.ooefl003,pmeldocno,pmel006,t2.pmaal004,pmel007,t3.pmaal004,pmel001,pmel002,pmel003,t4.oocql004,'' ",
   #            "  FROM pmel_t ",
   #            "     LEFT OUTER JOIN ooefl_t t1 ON pmelent = t1.ooeflent AND pmelsite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #收貨組織說明
   #            "     LEFT OUTER JOIN pmaal_t t2 ON pmelent = t2.pmaalent AND pmel006  = t2.pmaal001 AND t2.pmaal002 = '",g_dlang,"' ",  #預約供應商說明
   #            "     LEFT OUTER JOIN pmaal_t t3 ON pmelent = t3.pmaalent AND pmel007  = t3.pmaal001 AND t3.pmaal002 = '",g_dlang,"' ",  #送貨供應商說明
   #            "     LEFT OUTER JOIN oocql_t t4 ON pmelent = t4.oocqlent AND pmel003  = t4.oocql002 AND oocql001='274' AND t4.oocql003 = '",g_dlang,"' ",  #預計到庫時段說明
   #            "     LEFT OUTER JOIN pmem_t ON pmelent = pmement  AND pmemdocno = pmeldocno",
   #            " WHERE pmelent= ? AND 1=1 AND ", ls_wc
   #LET g_sql = g_sql, cl_sql_add_filter("pmel_t"),
   #                   " ORDER BY pmel_t.pmeldocno"               
   #                   
   #LET l_sql = " SELECT SUM(sum_pmem012) ",
   #            " FROM apmq859_pmem ", 
   #            " WHERE pmemdocno = ? "
   #150826-00013#1 效能調整 20150909 mark by beckxie---E
   #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET g_sql = "SELECT   'N',pmelsite    ,pmelsite_desc,pmeldocno,pmel006,",
               "pmel006_desc,pmel007     ,pmel007_desc ,pmel001  ,pmel002,",
               "     pmel003,pmel003_desc,''", 
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150909 add by beckxie---E
   LET l_sql = " SELECT SUM(sum_pmem012) ",
               " FROM apmq859_pmem ", 
               " WHERE pmemdocno = ? "
   PREPARE apmq859_prepare1 FROM l_sql
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq859_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq859_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmel_d[l_ac].sel,g_pmel_d[l_ac].pmelsite,g_pmel_d[l_ac].pmelsite_desc, 
       g_pmel_d[l_ac].pmeldocno,g_pmel_d[l_ac].pmel006,g_pmel_d[l_ac].pmel006_desc,g_pmel_d[l_ac].pmel007, 
       g_pmel_d[l_ac].pmel007_desc,g_pmel_d[l_ac].pmel001,g_pmel_d[l_ac].pmel002,g_pmel_d[l_ac].pmel003, 
       g_pmel_d[l_ac].pmel003_desc,g_pmel_d[l_ac].l_sum_pmem012
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_pmel_d[l_ac].sel = 'N'
      EXECUTE apmq859_prepare1 USING g_pmel_d[l_ac].pmeldocno INTO g_pmel_d[l_ac].l_sum_pmem012
                   
      #end add-point
 
      CALL apmq859_detail_show("'1'")
 
      CALL apmq859_pmel_t_mask()
 
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
   CALL cl_set_comp_visible('sel',FALSE)
   #end add-point
 
   CALL g_pmel_d.deleteElement(g_pmel_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmel_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq859_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq859_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq859_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmel_d.getLength() > 0 THEN
      CALL apmq859_b_fill2()
   END IF
 
      CALL apmq859_filter_show('pmelsite','b_pmelsite')
   CALL apmq859_filter_show('pmeldocno','b_pmeldocno')
   CALL apmq859_filter_show('pmel006','b_pmel006')
   CALL apmq859_filter_show('pmel007','b_pmel007')
   CALL apmq859_filter_show('pmel001','b_pmel001')
   CALL apmq859_filter_show('pmel002','b_pmel002')
   CALL apmq859_filter_show('pmel003','b_pmel003')
   CALL apmq859_filter_show('pmemseq','b_pmemseq')
   CALL apmq859_filter_show('pmem001','b_pmem001')
   CALL apmq859_filter_show('pmem002','b_pmem002')
   CALL apmq859_filter_show('pmem003','b_pmem003')
   CALL apmq859_filter_show('pmem004','b_pmem004')
   CALL apmq859_filter_show('pmem005','b_pmem005')
   CALL apmq859_filter_show('pmem006','b_pmem006')
   CALL apmq859_filter_show('pmem007','b_pmem007')
   CALL apmq859_filter_show('pmem008','b_pmem008')
   CALL apmq859_filter_show('pmdn020','b_pmdn020')
   CALL apmq859_filter_show('pmem009','b_pmem009')
   CALL apmq859_filter_show('pmem010','b_pmem010')
   CALL apmq859_filter_show('pmem011','b_pmem011')
   CALL apmq859_filter_show('pmem012','b_pmem012')
   CALL apmq859_filter_show('pmem013','b_pmem013')
   CALL apmq859_filter_show('pmem014','b_pmem014')
   CALL apmq859_filter_show('pmem015','b_pmem015')
   CALL apmq859_filter_show('pmem016','b_pmem016')
   CALL apmq859_filter_show('pmem020','b_pmem020')
   CALL apmq859_filter_show('pmem017','b_pmem017')
   CALL apmq859_filter_show('pmem018','b_pmem018')
   CALL apmq859_filter_show('pmem019','b_pmem019')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq859.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq859_b_fill2()
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
#Page2
   CALL g_pmel2_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE pmemseq,pmem001,pmem002,pmem003,pmem004,pmem005,pmem006,pmem007,'', 
          '',pmem008,'','',pmem009,'',pmem010,pmem011,'',pmem012,pmem013,pmem014,'',pmem015,'',pmem016, 
          pmem020,pmem017,'',pmem018,'',pmem019,'' FROM pmem_t",
                  "",
                  " WHERE pmement=? AND pmemdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmem_t.pmemseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      #150826-00013#1 效能調整 20150909 mark by beckxie---S
      #LET g_sql = "SELECT UNIQUE pmemseq,pmem001,pmem002,pmem003,pmem004,pmem005, ",
      #            "              pmem006,pmem007,t1.imaal003,t1.imaal004,pmem008,'',",
      #            "              pmdn020,pmem009,t2.oocal003,pmem010,pmem011,t2.oocal003, ",
      #            "              pmem012,pmem013,pmem014,t4.inayl003,pmem015,t5.inab003, ",
      #            "              pmem016,pmem020,pmem017,t6.ooefl003,pmem018,t7.ooefl003, ",
      #            "              pmem019,t8.ooefl003 ", 
      #            "  FROM pmem_t ",
      #            "     LEFT OUTER JOIN pmdn_t ON pmement = pmdnent AND pmem001 = pmdndocno AND pmemseq = pmdnseq ",
      #            "     LEFT OUTER JOIN imaal_t t1 on pmement = t1.imaalent AND pmem007 = t1.imaal001 AND t1.imaal002 = '",g_dlang,"' ",  #品名、規格
      #            "     LEFT OUTER JOIN oocal_t t2 on pmement = t2.oocalent AND pmem009 = t2.oocal001 AND t2.oocal002 = '",g_dlang,"' ",  #包裝單位說明
      #            "     LEFT OUTER JOIN oocal_t t3 on pmement = t3.oocalent AND pmem011 = t3.oocal001 AND t3.oocal002 = '",g_dlang,"' ",  #收貨單位說明              
      #            "     LEFT OUTER JOIN inayl_t t4 on pmement = t4.inaylent AND pmem014 = t4.inayl001 AND t4.inayl002 = '",g_dlang,"' ",  #庫位說明
      #            "     LEFT OUTER JOIN inab_t t5 on pmement = t5.inabent AND inabsite = '",g_pmel_d[g_detail_idx].pmelsite,"' AND pmem014 = t5.inab001 AND pmem015 = t5.inab002 ",  #儲位說明
      #            "     LEFT OUTER JOIN ooefl_t t6 ON pmement = t6.ooeflent AND pmem017 = t6.ooefl001 AND t6.ooefl002 = '",g_dlang,"' ",  #採購組織說明
      #            "     LEFT OUTER JOIN ooefl_t t7 ON pmement = t7.ooeflent AND pmem018 = t7.ooefl001 AND t7.ooefl002 = '",g_dlang,"' ",  #採購中心說明                  
      #            "     LEFT OUTER JOIN ooefl_t t8 ON pmement = t8.ooeflent AND pmem019 = t8.ooefl001 AND t8.ooefl002 = '",g_dlang,"' ",  #要貨組織說明                  
      #            " WHERE pmement   = ? ",
      #            "   AND pmemdocno = ? ",
      #            "   AND pmem000  = '1' "
      #            
      #IF NOT cl_null(g_wc2_table2) THEN
      #   LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      #END IF
      #
      #LET g_sql = g_sql, " ORDER BY pmem_t.pmem001,pmem_t.pmemseq"
      #150826-00013#1 效能調整 20150909 mark by beckxie---E
      #150826-00013#1 效能調整 20150909 add by beckxie---S
      LET g_sql = "SELECT UNIQUE pmemseq,pmem001,pmem002,pmem003,pmem004,pmem005, ",
                  "              pmem006,pmem007,t1.imaal003,t1.imaal004,pmem008,'',",
                  "              pmdn020,pmem009,",
                  "             (SELECT oocal003",
                  "                FROM oocal_t",
                  "               WHERE pmement = oocalent AND pmem009 = oocal001 ",
                  "                 AND oocal002 = '",g_dlang,"') pmem009_desc,",  #包裝單位說明
                  "             pmem010,pmem011,",
                  "             (SELECT oocal003",
                  "                FROM oocal_t",
                  "               WHERE pmement = oocalent AND pmem011 = oocal001 ",
                  "                 AND oocal002 = '",g_dlang,"') pmem011_desc,",  #收貨單位說明
                  "             pmem012,pmem013,pmem014,",
                  "             (SELECT inayl003",
                  "                FROM inayl_t",
                  "               WHERE pmement = inaylent AND pmem014 = inayl001", 
                  "                 AND inayl002 = '",g_dlang,"') pmem014_desc,",  #庫位說明
                  "             pmem015,",
                  "             (SELECT inab003",
                  "                FROM inab_t",
                  "               WHERE pmement = inabent AND inabsite = '",g_pmel_d[g_detail_idx].pmelsite,"' ",
                  "                 AND pmem014 = inab001 AND pmem015 = inab002) pmem015_desc,",  #儲位說明
                  "              pmem016,pmem020,pmem017,",
                  "             (SELECT ooefl003",
                  "                FROM ooefl_t",
                  "               WHERE pmement = ooeflent AND pmem017 = ooefl001 ",
                  "                 AND ooefl002 = '",g_dlang,"') pmem017_desc,",  #採購組織說明
                  "              pmem018,",
                  "              (SELECT ooefl003",
                  "                 FROM ooefl_t",
                  "                WHERE pmement = ooeflent AND pmem018 = ooefl001 ",
                  "                  AND ooefl002 = '",g_dlang,"') pmem018_desc,",  #採購中心說明                  
                  "              pmem019,",
                  "              (SELECT ooefl003",
                  "                 FROM ooefl_t",
                  "                WHERE pmement = ooeflent AND pmem019 = ooefl001 AND ooefl002 = '",g_dlang,"') pmem019_desc",  #要貨組織說明
                  "  FROM pmem_t ",
                  "     LEFT OUTER JOIN pmdn_t ON pmement = pmdnent AND pmem001 = pmdndocno AND pmemseq = pmdnseq ",
                  "     LEFT OUTER JOIN imaal_t t1 ON pmement = t1.imaalent AND pmem007 = t1.imaal001 AND t1.imaal002 = '",g_dlang,"' ",  #品名、規格
                  " WHERE pmement   = ? ",
                  "   AND pmemdocno = ? ",
                  "   AND pmem000  = '1' "
                  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmem001,pmemseq"
      #150826-00013#1 效能調整 20150909 add by beckxie---E
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq859_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq859_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_pmel_d[g_detail_idx].pmeldocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_pmel_d[g_detail_idx].pmeldocno
 
      INTO g_pmel2_d[l_ac].pmemseq,g_pmel2_d[l_ac].pmem001,g_pmel2_d[l_ac].pmem002,g_pmel2_d[l_ac].pmem003, 
          g_pmel2_d[l_ac].pmem004,g_pmel2_d[l_ac].pmem005,g_pmel2_d[l_ac].pmem006,g_pmel2_d[l_ac].pmem007, 
          g_pmel2_d[l_ac].pmem007_desc,g_pmel2_d[l_ac].pmem007_desc_1,g_pmel2_d[l_ac].pmem008,g_pmel2_d[l_ac].pmem008_desc, 
          g_pmel2_d[l_ac].pmdn020,g_pmel2_d[l_ac].pmem009,g_pmel2_d[l_ac].pmem009_desc,g_pmel2_d[l_ac].pmem010, 
          g_pmel2_d[l_ac].pmem011,g_pmel2_d[l_ac].pmem011_desc,g_pmel2_d[l_ac].pmem012,g_pmel2_d[l_ac].pmem013, 
          g_pmel2_d[l_ac].pmem014,g_pmel2_d[l_ac].pmem014_desc,g_pmel2_d[l_ac].pmem015,g_pmel2_d[l_ac].pmem015_desc, 
          g_pmel2_d[l_ac].pmem016,g_pmel2_d[l_ac].pmem020,g_pmel2_d[l_ac].pmem017,g_pmel2_d[l_ac].pmem017_desc, 
          g_pmel2_d[l_ac].pmem018,g_pmel2_d[l_ac].pmem018_desc,g_pmel2_d[l_ac].pmem019,g_pmel2_d[l_ac].pmem019_desc 
 
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
 
      CALL apmq859_detail_show("'2'")
 
      CALL apmq859_pmem_t_mask()
 
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
   CALL g_pmel2_d.deleteElement(g_pmel2_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_pmel2_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq859.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq859_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
DEFINE l_success   LIKE type_t.num5
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
 
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
      ##收貨組織說明
      #CALL s_desc_get_department_desc(g_pmel_d[l_ac].pmelsite) RETURNING g_pmel_d[l_ac].pmelsite_desc
      ##預約供應商簡稱
      #CALL s_desc_get_trading_partner_abbr_desc(g_pmel_d[l_ac].pmel006) RETURNING g_pmel_d[l_ac].pmel006_desc
      ##送貨供應商簡稱
      #CALL s_desc_get_trading_partner_abbr_desc(g_pmel_d[l_ac].pmel007) RETURNING g_pmel_d[l_ac].pmel007_desc
      #DISPLAY BY NAME g_pmel_d[l_ac].pmelsite_desc,g_pmel_d[l_ac].pmel006_desc,g_pmel_d[l_ac].pmel007_desc 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      #品名,規格
      #CALL s_desc_get_item_desc(g_pmel2_d[l_ac].pmem007) RETURNING g_pmel2_d[l_ac].pmem007_desc,g_pmel2_d[l_ac].pmem007_desc_1            
      #150826-00013# 20160308 add by beckxie---S
      IF (NOT cl_null(g_pmel2_d[l_ac].pmem007)) AND (NOT cl_null(g_pmel2_d[l_ac].pmem008)) THEN 
      #150826-00013# 20160308 add by beckxie---E
      #採購產品特徵說明
      CALL s_feature_description(g_pmel2_d[l_ac].pmem007,g_pmel2_d[l_ac].pmem008) RETURNING l_success,g_pmel2_d[l_ac].pmem008_desc
      END IF #150826-00013# 20160308 add by beckxie
      #包裝單位說明
      #CALL s_desc_get_unit_desc(g_pmel2_d[l_ac].pmem009) RETURNING g_pmel2_d[l_ac].pmem009_desc
      #收貨單位說明
      #CALL s_desc_get_unit_desc(g_pmel2_d[l_ac].pmem011) RETURNING g_pmel2_d[l_ac].pmem011_desc
      #庫位說明
      #CALL s_desc_get_stock_desc(g_pmel_d[g_detail_idx].pmelsite,g_pmel2_d[l_ac].pmem014) RETURNING g_pmel2_d[l_ac].pmem014_desc                       
      #儲位說明
      #CALL s_desc_get_locator_desc(g_pmel_d[g_detail_idx].pmelsite,g_pmel2_d[l_ac].pmem014,g_pmel2_d[l_ac].pmem015) RETURNING g_pmel2_d[l_ac].pmem015_desc
      #採購組織說明
      #CALL s_desc_get_department_desc(g_pmel2_d[l_ac].pmem017) RETURNING g_pmel2_d[l_ac].pmem017_desc
      #採購中心說明
      #CALL s_desc_get_department_desc(g_pmel2_d[l_ac].pmem018) RETURNING g_pmel2_d[l_ac].pmem018_desc
      #要貨組織說明
      #CALL s_desc_get_department_desc(g_pmel2_d[l_ac].pmem019) RETURNING g_pmel2_d[l_ac].pmem019_desc
      #DISPLAY BY NAME g_pmel2_d[l_ac].pmem007_desc,g_pmel2_d[l_ac].pmem007_desc_1,g_pmel2_d[l_ac].pmem008_desc,
      #                g_pmel2_d[l_ac].pmem009_desc,g_pmel2_d[l_ac].pmem011_desc,g_pmel2_d[l_ac].pmem014_desc,
      #                g_pmel2_d[l_ac].pmem015_desc,g_pmel2_d[l_ac].pmem017_desc,g_pmel2_d[l_ac].pmem018_desc
                      
                      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq859.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq859_filter()
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
      CONSTRUCT g_wc_filter ON pmelsite,pmeldocno,pmel006,pmel007,pmel001,pmel002,pmel003
                          FROM s_detail1[1].b_pmelsite,s_detail1[1].b_pmeldocno,s_detail1[1].b_pmel006, 
                              s_detail1[1].b_pmel007,s_detail1[1].b_pmel001,s_detail1[1].b_pmel002,s_detail1[1].b_pmel003 
 
 
         BEFORE CONSTRUCT
                     DISPLAY apmq859_filter_parser('pmelsite') TO s_detail1[1].b_pmelsite
            DISPLAY apmq859_filter_parser('pmeldocno') TO s_detail1[1].b_pmeldocno
            DISPLAY apmq859_filter_parser('pmel006') TO s_detail1[1].b_pmel006
            DISPLAY apmq859_filter_parser('pmel007') TO s_detail1[1].b_pmel007
            DISPLAY apmq859_filter_parser('pmel001') TO s_detail1[1].b_pmel001
            DISPLAY apmq859_filter_parser('pmel002') TO s_detail1[1].b_pmel002
            DISPLAY apmq859_filter_parser('pmel003') TO s_detail1[1].b_pmel003
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmelsite>>----
         #Ctrlp:construct.c.filter.page1.b_pmelsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmelsite
            #add-point:ON ACTION controlp INFIELD b_pmelsite name="construct.c.filter.page1.b_pmelsite"
            
            #END add-point
 
 
         #----<<b_pmelsite_desc>>----
         #----<<b_pmeldocno>>----
         #Ctrlp:construct.c.filter.page1.b_pmeldocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmeldocno
            #add-point:ON ACTION controlp INFIELD b_pmeldocno name="construct.c.filter.page1.b_pmeldocno"
            
            #END add-point
 
 
         #----<<b_pmel006>>----
         #Ctrlp:construct.c.filter.page1.b_pmel006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel006
            #add-point:ON ACTION controlp INFIELD b_pmel006 name="construct.c.filter.page1.b_pmel006"
            
            #END add-point
 
 
         #----<<b_pmel006_desc>>----
         #----<<b_pmel007>>----
         #Ctrlp:construct.c.filter.page1.b_pmel007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel007
            #add-point:ON ACTION controlp INFIELD b_pmel007 name="construct.c.filter.page1.b_pmel007"
            
            #END add-point
 
 
         #----<<b_pmel007_desc>>----
         #----<<b_pmel001>>----
         #Ctrlp:construct.c.filter.page1.b_pmel001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel001
            #add-point:ON ACTION controlp INFIELD b_pmel001 name="construct.c.filter.page1.b_pmel001"
            
            #END add-point
 
 
         #----<<b_pmel002>>----
         #Ctrlp:construct.c.filter.page1.b_pmel002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel002
            #add-point:ON ACTION controlp INFIELD b_pmel002 name="construct.c.filter.page1.b_pmel002"
            
            #END add-point
 
 
         #----<<b_pmel003>>----
         #Ctrlp:construct.c.filter.page1.b_pmel003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel003
            #add-point:ON ACTION controlp INFIELD b_pmel003 name="construct.c.filter.page1.b_pmel003"
            
            #END add-point
 
 
         #----<<b_pmel003_desc>>----
         #----<<l_sum_pmem012>>----
 
 
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
 
      CALL apmq859_filter_show('pmelsite','b_pmelsite')
   CALL apmq859_filter_show('pmeldocno','b_pmeldocno')
   CALL apmq859_filter_show('pmel006','b_pmel006')
   CALL apmq859_filter_show('pmel007','b_pmel007')
   CALL apmq859_filter_show('pmel001','b_pmel001')
   CALL apmq859_filter_show('pmel002','b_pmel002')
   CALL apmq859_filter_show('pmel003','b_pmel003')
   CALL apmq859_filter_show('pmemseq','b_pmemseq')
   CALL apmq859_filter_show('pmem001','b_pmem001')
   CALL apmq859_filter_show('pmem002','b_pmem002')
   CALL apmq859_filter_show('pmem003','b_pmem003')
   CALL apmq859_filter_show('pmem004','b_pmem004')
   CALL apmq859_filter_show('pmem005','b_pmem005')
   CALL apmq859_filter_show('pmem006','b_pmem006')
   CALL apmq859_filter_show('pmem007','b_pmem007')
   CALL apmq859_filter_show('pmem008','b_pmem008')
   CALL apmq859_filter_show('pmdn020','b_pmdn020')
   CALL apmq859_filter_show('pmem009','b_pmem009')
   CALL apmq859_filter_show('pmem010','b_pmem010')
   CALL apmq859_filter_show('pmem011','b_pmem011')
   CALL apmq859_filter_show('pmem012','b_pmem012')
   CALL apmq859_filter_show('pmem013','b_pmem013')
   CALL apmq859_filter_show('pmem014','b_pmem014')
   CALL apmq859_filter_show('pmem015','b_pmem015')
   CALL apmq859_filter_show('pmem016','b_pmem016')
   CALL apmq859_filter_show('pmem020','b_pmem020')
   CALL apmq859_filter_show('pmem017','b_pmem017')
   CALL apmq859_filter_show('pmem018','b_pmem018')
   CALL apmq859_filter_show('pmem019','b_pmem019')
 
 
   CALL apmq859_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq859.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq859_filter_parser(ps_field)
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
 
{<section id="apmq859.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq859_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq859_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq859.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq859_detail_action_trans()
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
 
{<section id="apmq859.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq859_detail_index_setting()
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
            IF g_pmel_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmel_d.getLength() AND g_pmel_d.getLength() > 0
            LET g_detail_idx = g_pmel_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmel_d.getLength() THEN
               LET g_detail_idx = g_pmel_d.getLength()
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
 
{<section id="apmq859.mask_functions" >}
 &include "erp/apm/apmq859_mask.4gl"
 
{</section>}
 
{<section id="apmq859.other_function" readonly="Y" >}

################################################################################
# Descriptions...: update 庫存數量
# Memo...........:
# Usage..........: CALL apmq859_update_qty ()
# Date & Author..: 2014/12/12 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq859_update_qty()
   DEFINE l_pmemdocno     LIKE pmem_t.pmemdocno
   DEFINE l_pmemseq       LIKE pmem_t.pmemseq
   DEFINE l_pmem007       LIKE pmem_t.pmem007
   DEFINE l_pmem011       LIKE pmem_t.pmem011
   DEFINE l_pmem012       LIKE pmem_t.pmem012   
   DEFINE l_imaa104       LIKE imaa_t.imaa104
   DEFINE l_success       LIKE type_t.num5   
   DEFINE l_qty           LIKE type_t.num20_6
   DEFINE l_sql           STRING   

   UPDATE apmq859_pmem
      SET sum_pmem012 = pmem012
    WHERE pmem011 = imaa104
    
   LET l_sql = "SELECT pmemdocno,pmemseq,pmem007,pmem011,pmem012,imaa104  ",
               "  FROM apmq859_pmem  ",
               "  WHERE sum_pmem012 = -1 "
               
   PREPARE apmq859_update_qty_prep FROM l_sql
   DECLARE apmq859_update_qty_curs CURSOR FOR apmq859_update_qty_prep

   FOREACH apmq859_update_qty_curs INTO l_pmemdocno,l_pmemseq,l_pmem007,l_pmem011,l_pmem012,l_imaa104

      CALL s_aooi250_convert_qty(l_pmem007,l_pmem011,l_imaa104,l_pmem012)
           RETURNING l_success,l_qty
           
      IF cl_null(l_qty) THEN
         LET l_qty = 0
      END IF

      UPDATE apmq859_pmem
         SET sum_pmem012 = l_qty 
        WHERE pmemdocno = l_pmemdocno
          AND pmemseq   = l_pmemseq
          AND pmem007   = l_pmem007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "Update"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         CALL s_transaction_end('N','0')
      END IF          
      
   END FOREACH
   
END FUNCTION

 
{</section>}
 
