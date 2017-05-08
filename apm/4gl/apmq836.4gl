#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq836.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2015-03-30 14:52:04), PR版次:0003(2016-05-16 00:03:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000042
#+ Filename...: apmq836
#+ Description: 要貨單查詢列印作業
#+ Creator....: 02159(2015-03-30 10:16:52)
#+ Modifier...: 02159 -SD/PR- 02159
 
{</section>}
 
{<section id="apmq836.global" >}
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
PRIVATE TYPE type_g_pmda_d RECORD
       
       sel LIKE type_t.chr1, 
   pmdasite LIKE pmda_t.pmdasite, 
   pmdasite_desc LIKE type_t.chr500, 
   pmda200 LIKE pmda_t.pmda200, 
   pmdadocno LIKE pmda_t.pmdadocno, 
   pmdadocdt LIKE pmda_t.pmdadocdt, 
   pmda002 LIKE pmda_t.pmda002, 
   pmda002_desc LIKE type_t.chr500, 
   pmda003 LIKE pmda_t.pmda003, 
   pmda003_desc LIKE type_t.chr500, 
   pmda202 LIKE pmda_t.pmda202, 
   pmda202_desc LIKE type_t.chr500, 
   pmda201 LIKE pmda_t.pmda201, 
   pmda204 LIKE pmda_t.pmda204, 
   pmda204_desc LIKE type_t.chr500, 
   pmda205 LIKE pmda_t.pmda205, 
   pmda205_desc LIKE type_t.chr500, 
   pmda022 LIKE pmda_t.pmda022, 
   pmdastus LIKE pmda_t.pmdastus
       END RECORD
PRIVATE TYPE type_g_pmda4_d RECORD
       pmdbseq LIKE pmdb_t.pmdbseq, 
   pmdb001 LIKE pmdb_t.pmdb001, 
   pmdb002 LIKE pmdb_t.pmdb002, 
   pmdb003 LIKE pmdb_t.pmdb003, 
   pmdbsite LIKE pmdb_t.pmdbsite, 
   pmdbsite_desc LIKE type_t.chr500, 
   pmdb200 LIKE pmdb_t.pmdb200, 
   pmdb004 LIKE pmdb_t.pmdb004, 
   pmdb004_desc LIKE type_t.chr500, 
   pmdb004_desc_desc LIKE type_t.chr500, 
   pmdb005 LIKE pmdb_t.pmdb005, 
   pmdb005_desc LIKE type_t.chr500, 
   imaa009 LIKE type_t.chr500, 
   imaa009_desc LIKE type_t.chr10, 
   pmdb037 LIKE pmdb_t.pmdb037, 
   pmdb037_desc LIKE type_t.chr500, 
   pmdb260 LIKE pmdb_t.pmdb260, 
   pmdb260_desc LIKE type_t.chr500, 
   pmdb038 LIKE pmdb_t.pmdb038, 
   pmdb038_desc LIKE type_t.chr500, 
   pmdb201 LIKE pmdb_t.pmdb201, 
   pmdb201_desc LIKE type_t.chr500, 
   pmdb202 LIKE pmdb_t.pmdb202, 
   pmdb212 LIKE pmdb_t.pmdb212, 
   pmdb007 LIKE pmdb_t.pmdb007, 
   pmdb007_desc LIKE type_t.chr500, 
   pmdb006 LIKE pmdb_t.pmdb006, 
   pmdb253 LIKE pmdb_t.pmdb253, 
   pmdb258 LIKE pmdb_t.pmdb258, 
   pmdb254 LIKE pmdb_t.pmdb254, 
   pmdb255 LIKE pmdb_t.pmdb255, 
   pmdb256 LIKE pmdb_t.pmdb256, 
   pmdb257 LIKE pmdb_t.pmdb257, 
   pmdb259 LIKE pmdb_t.pmdb259, 
   pmdb252 LIKE pmdb_t.pmdb252, 
   pmdb207 LIKE pmdb_t.pmdb207, 
   pmdb015 LIKE pmdb_t.pmdb015, 
   pmdb015_desc LIKE type_t.chr500, 
   pmdb049 LIKE pmdb_t.pmdb049, 
   pmdb030 LIKE pmdb_t.pmdb030, 
   pmdb048 LIKE pmdb_t.pmdb048, 
   pmdb048_desc LIKE type_t.chr500, 
   pmdb208 LIKE pmdb_t.pmdb208, 
   pmdb209 LIKE pmdb_t.pmdb209, 
   pmdb209_desc LIKE type_t.chr500, 
   pmdb206 LIKE pmdb_t.pmdb206, 
   pmdb206_desc LIKE type_t.chr500, 
   pmdb210 LIKE pmdb_t.pmdb210, 
   pmdb211 LIKE pmdb_t.pmdb211, 
   pmdb205 LIKE pmdb_t.pmdb205, 
   pmdb205_desc LIKE type_t.chr500, 
   pmdb203 LIKE pmdb_t.pmdb203, 
   pmdb203_desc LIKE type_t.chr500, 
   pmdb204 LIKE pmdb_t.pmdb204, 
   pmdb204_desc LIKE type_t.chr500, 
   pmdb032 LIKE pmdb_t.pmdb032, 
   pmdb051 LIKE pmdb_t.pmdb051, 
   pmdb051_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tm        RECORD
     stus           LIKE type_t.chr10
                     END RECORD
DEFINE tm              type_tm
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmda_d            DYNAMIC ARRAY OF type_g_pmda_d
DEFINE g_pmda_d_t          type_g_pmda_d
DEFINE g_pmda4_d     DYNAMIC ARRAY OF type_g_pmda4_d
DEFINE g_pmda4_d_t   type_g_pmda4_d
 
 
 
 
 
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
 
{<section id="apmq836.main" >}
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
   DECLARE apmq836_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq836_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq836_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq836 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq836_init()   
 
      #進入選單 Menu (="N")
      CALL apmq836_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq836
      
   END IF 
   
   CLOSE apmq836_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq836.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq836_init()
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
      CALL cl_set_combo_scc_part('b_pmdastus','13','Y,N,TJ,C,A,D,R,W,UH,H,X')
 
      CALL cl_set_combo_scc('b_pmda200','6552') 
   CALL cl_set_combo_scc('b_pmda201','6014') 
   CALL cl_set_combo_scc('b_pmdb207','6014') 
   CALL cl_set_combo_scc('b_pmdb208','6013') 
   CALL cl_set_combo_scc('b_pmdb032','2035') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL s_aooi500_create_temp() RETURNING l_success
   CALL cl_set_combo_scc('pmda200','6552')
   #end add-point
 
   CALL apmq836_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq836.default_search" >}
PRIVATE FUNCTION apmq836_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " pmdadocno = '", g_argv[01], "' AND "
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
 
{<section id="apmq836.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq836_ui_dialog() 
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
   DEFINE l_cmd     STRING
   DEFINE l_where   STRING
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
 
   
   CALL apmq836_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmda_d.clear()
         CALL g_pmda4_d.clear()
 
 
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
 
         CALL apmq836_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT tm.stus
          FROM l_stus
            BEFORE INPUT
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
      CONSTRUCT BY NAME g_wc ON pmdasite,pmda200,pmdadocno,pmdadocdt,pmda002,pmda003
         
         ON ACTION controlp INFIELD pmdasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_site,'c')
            CALL q_ooef001_24()   
            DISPLAY g_qryparam.return1 TO pmdasite
            NEXT FIELD CURRENT

         ON ACTION controlp INFIELD pmdadocno
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()
            DISPLAY g_qryparam.return1 TO pmdadocno
            NEXT FIELD CURRENT
            
         ON ACTION controlp INFIELD pmda002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                       
            DISPLAY g_qryparam.return1 TO pmda002  
            NEXT FIELD CURRENT

         ON ACTION controlp INFIELD pmda003
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                        
            DISPLAY g_qryparam.return1 TO pmda003  
            NEXT FIELD CURRENT                     
            
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmda_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq836_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq836_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_pmda4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq836_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET tm.stus = 'ALL'
            DISPLAY tm.stus TO l_stus
            CALL cl_set_act_visible("insert,query", FALSE) 
            #end add-point
            NEXT FIELD pmdasite
 
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
            CALL apmq836_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_pmda_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_pmda4_d)
               LET g_export_id[2]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq836_b_fill()
 
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
            CALL apmq836_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq836_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq836_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq836_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_pmda_d.getLength()
               LET g_pmda_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_pmda_d.getLength()
               LET g_pmda_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_pmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmda_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_pmda_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_pmda_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL apmq836_filter()
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
               FOR li_idx = 1 TO g_pmda_d.getLength()
                  IF g_pmda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_pmda_d[li_idx].pmdadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_pmda_d[li_idx].pmdadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "pmdadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL apmr836_g01(l_where)
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               LET l_cmd = ''
               LET l_where = ''
               FOR li_idx = 1 TO g_pmda_d.getLength()
                  IF g_pmda_d[li_idx].sel = "Y" THEN
                     IF cl_null(l_cmd) THEN
                        LET l_cmd = "'",g_pmda_d[li_idx].pmdadocno,"'"
                     ELSE
                        LET l_cmd = "'",g_pmda_d[li_idx].pmdadocno,"',",l_cmd CLIPPED
                     END IF
                  END IF
               END FOR
               LET l_where = "pmdadocno IN (" CLIPPED,l_cmd CLIPPED,")"
               CALL apmr836_g01(l_where)
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
 
{<section id="apmq836.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq836_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where           STRING
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'pmdasite') RETURNING l_where
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
 
   CALL g_pmda_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF tm.stus != 'ALL' THEN
      LET l_where = l_where CLIPPED," AND pmdastus = '",tm.stus CLIPPED,"'"
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmdasite,'',pmda200,pmdadocno,pmdadocdt,pmda002,'',pmda003,'', 
       pmda202,'',pmda201,pmda204,'',pmda205,'',pmda022,pmdastus  ,DENSE_RANK() OVER( ORDER BY pmda_t.pmdadocno) AS RANK FROM pmda_t", 
 
 
#table2
                     " LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno",
 
                     "",
                     " WHERE pmdaent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmda_t"),
                     " ORDER BY pmda_t.pmdadocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150909 add by beckxie---S
   LET ls_sql_rank = "SELECT  UNIQUE 'N',pmdasite,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE pmdaent = ooeflent AND pmdasite = ooefl001",
                     "            AND ooefl002 = '",g_dlang,"') pmdasite_desc,",              #收貨組織說明
                     "        pmda200,pmdadocno,pmdadocdt,pmda002,",
                     "        (SELECT ooag011",
                     "           FROM ooag_t",
                     "          WHERE pmdaent = ooagent AND pmda002 = ooag001) pmda002_desc,",#要貨人員說明
                     "        pmda003,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE pmdaent = ooeflent AND pmda003 = ooefl001 ",
                     "            AND ooefl002='",g_dlang,"') pmda003_desc,",                 #要貨部門說明
                     "        pmda202, ",
                     "        (SELECT rtaxl003",
                     "           FROM rtaxl_t",
                     "          WHERE pmdaent = rtaxlent AND pmda202 = rtaxl001",
                     "            AND rtaxl002='",g_dlang,"') pmda202_desc,",                 #所屬品類說明               
                     "        pmda201,pmda204,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE pmdaent = ooeflent AND pmda204 = ooefl001 ",
                     "            AND ooefl002='",g_dlang,"') pmda204_desc,",                 #採購中心
                     "        pmda205,",
                     "        (SELECT ooefl003",
                     "           FROM ooefl_t",
                     "          WHERE pmdaent = ooeflent AND pmda205 = ooefl001",
                     "            AND ooefl002='",g_dlang,"') pmda205_desc,",                 #配送中心              
                     "        pmda022,pmdastus,",
                     "        DENSE_RANK() OVER( ORDER BY pmda_t.pmdadocno) AS RANK",
                     " FROM pmda_t ",
                     " LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno",
                     " WHERE pmdaent= ? AND 1=1 AND ", ls_wc
 
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmda_t"),
                      " ORDER BY pmdadocno"
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
 
   LET g_sql = "SELECT '',pmdasite,'',pmda200,pmdadocno,pmdadocdt,pmda002,'',pmda003,'',pmda202,'',pmda201, 
       pmda204,'',pmda205,'',pmda022,pmdastus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#1 效能調整 20150909 mark by beckxie---S
   #LET g_sql = "SELECT  UNIQUE 'N',pmdasite,t1.ooefl003,pmda200,pmdadocno,pmdadocdt,pmda002,t2.ooag011,pmda003,t3.ooefl003,pmda202, ",
   #            "               t4.rtaxl003,pmda201,pmda204,t5.ooefl003,pmda205,t6.ooefl003,pmda022,pmdastus",
   #            " FROM pmda_t ",
   #            " LEFT JOIN pmdb_t ON pmdbent = pmdaent AND pmdadocno = pmdbdocno",
   #            " LEFT JOIN ooefl_t t1 ON pmdaent = t1.ooeflent AND pmdasite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #收貨組織說明
   #            " LEFT JOIN ooag_t t2 ON  pmdaent = t2.ooagent AND pmda002 = t2.ooag001  ",                                    #要貨人員說明
   #            " LEFT JOIN ooefl_t t3 ON pmdaent = t3.ooeflent AND pmda003 = t3.ooefl001 AND t3.ooefl002='",g_dlang,"' ",       #要貨部門說明
   #            " LEFT JOIN rtaxl_t t4 ON pmdaent = t4.rtaxlent AND pmda202 = t4.rtaxl001 AND t4.rtaxl002='",g_dlang,"' ",     #所屬品類說明               
   #            " LEFT JOIN ooefl_t t5 ON pmdaent = t5.ooeflent AND pmda204 = t5.ooefl001 AND t5.ooefl002='",g_dlang,"' ",     #採購中心
   #            " LEFT JOIN ooefl_t t6 ON pmdaent = t6.ooeflent AND pmda205 = t6.ooefl001 AND t6.ooefl002='",g_dlang,"' ",     #配送中心              
   #            " WHERE pmdaent= ? AND 1=1 AND ", ls_wc
   #
   #LET g_sql = g_sql, cl_sql_add_filter("pmda_t"),
   #                   " ORDER BY pmda_t.pmdadocno"
   #150826-00013#1 效能調整 20150909 mark by beckxie---E
   #150826-00013#1 效能調整 20150909  add by beckxie---S
   LET g_sql = "SELECT 'N',",
               "    pmdasite,pmdasite_desc,pmda200 ,pmdadocno   ,pmdadocdt,",
               "     pmda002,pmda002_desc ,pmda003 ,pmda003_desc,pmda202  ,",
               "pmda202_desc,pmda201      ,pmda204 ,pmda204_desc,pmda205,",
               "pmda205_desc,pmda022      ,pmdastus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150909  add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq836_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq836_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmda_d[l_ac].sel,g_pmda_d[l_ac].pmdasite,g_pmda_d[l_ac].pmdasite_desc, 
       g_pmda_d[l_ac].pmda200,g_pmda_d[l_ac].pmdadocno,g_pmda_d[l_ac].pmdadocdt,g_pmda_d[l_ac].pmda002, 
       g_pmda_d[l_ac].pmda002_desc,g_pmda_d[l_ac].pmda003,g_pmda_d[l_ac].pmda003_desc,g_pmda_d[l_ac].pmda202, 
       g_pmda_d[l_ac].pmda202_desc,g_pmda_d[l_ac].pmda201,g_pmda_d[l_ac].pmda204,g_pmda_d[l_ac].pmda204_desc, 
       g_pmda_d[l_ac].pmda205,g_pmda_d[l_ac].pmda205_desc,g_pmda_d[l_ac].pmda022,g_pmda_d[l_ac].pmdastus 
 
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
 
      CALL apmq836_detail_show("'1'")
 
      CALL apmq836_pmda_t_mask()
 
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
 
   CALL g_pmda_d.deleteElement(g_pmda_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_pmda_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE apmq836_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq836_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq836_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmda_d.getLength() > 0 THEN
      CALL apmq836_b_fill2()
   END IF
 
      CALL apmq836_filter_show('pmdasite','b_pmdasite')
   CALL apmq836_filter_show('pmda200','b_pmda200')
   CALL apmq836_filter_show('pmdadocno','b_pmdadocno')
   CALL apmq836_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq836_filter_show('pmda002','b_pmda002')
   CALL apmq836_filter_show('pmda003','b_pmda003')
   CALL apmq836_filter_show('pmda202','b_pmda202')
   CALL apmq836_filter_show('pmda201','b_pmda201')
   CALL apmq836_filter_show('pmda204','b_pmda204')
   CALL apmq836_filter_show('pmda205','b_pmda205')
   CALL apmq836_filter_show('pmda022','b_pmda022')
   CALL apmq836_filter_show('pmdastus','b_pmdastus')
   CALL apmq836_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq836_filter_show('pmdb001','b_pmdb001')
   CALL apmq836_filter_show('pmdb002','b_pmdb002')
   CALL apmq836_filter_show('pmdb003','b_pmdb003')
   CALL apmq836_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq836_filter_show('pmdb200','b_pmdb200')
   CALL apmq836_filter_show('pmdb004','b_pmdb004')
   CALL apmq836_filter_show('pmdb005','b_pmdb005')
   CALL apmq836_filter_show('pmdb037','b_pmdb037')
   CALL apmq836_filter_show('pmdb260','b_pmdb260')
   CALL apmq836_filter_show('pmdb038','b_pmdb038')
   CALL apmq836_filter_show('pmdb201','b_pmdb201')
   CALL apmq836_filter_show('pmdb202','b_pmdb202')
   CALL apmq836_filter_show('pmdb212','b_pmdb212')
   CALL apmq836_filter_show('pmdb007','b_pmdb007')
   CALL apmq836_filter_show('pmdb006','b_pmdb006')
   CALL apmq836_filter_show('pmdb253','b_pmdb253')
   CALL apmq836_filter_show('pmdb258','b_pmdb258')
   CALL apmq836_filter_show('pmdb254','b_pmdb254')
   CALL apmq836_filter_show('pmdb255','b_pmdb255')
   CALL apmq836_filter_show('pmdb256','b_pmdb256')
   CALL apmq836_filter_show('pmdb257','b_pmdb257')
   CALL apmq836_filter_show('pmdb259','b_pmdb259')
   CALL apmq836_filter_show('pmdb252','b_pmdb252')
   CALL apmq836_filter_show('pmdb207','b_pmdb207')
   CALL apmq836_filter_show('pmdb015','b_pmdb015')
   CALL apmq836_filter_show('pmdb049','b_pmdb049')
   CALL apmq836_filter_show('pmdb030','b_pmdb030')
   CALL apmq836_filter_show('pmdb048','b_pmdb048')
   CALL apmq836_filter_show('pmdb208','b_pmdb208')
   CALL apmq836_filter_show('pmdb209','b_pmdb209')
   CALL apmq836_filter_show('pmdb206','b_pmdb206')
   CALL apmq836_filter_show('pmdb210','b_pmdb210')
   CALL apmq836_filter_show('pmdb211','b_pmdb211')
   CALL apmq836_filter_show('pmdb205','b_pmdb205')
   CALL apmq836_filter_show('pmdb203','b_pmdb203')
   CALL apmq836_filter_show('pmdb204','b_pmdb204')
   CALL apmq836_filter_show('pmdb032','b_pmdb032')
   CALL apmq836_filter_show('pmdb051','b_pmdb051')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq836.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq836_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_pmda4_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   LET l_cnt = g_pmda_d.getLength()
   IF l_cnt <= 0 THEN
     RETURN
   END IF
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,'',pmdb200,pmdb004,'','', 
          pmdb005,'','','',pmdb037,'',pmdb260,'',pmdb038,'',pmdb201,'',pmdb202,pmdb212,pmdb007,'',pmdb006, 
          pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259,pmdb252,pmdb207,pmdb015,'',pmdb049, 
          pmdb030,pmdb048,'',pmdb208,pmdb209,'',pmdb206,'',pmdb210,pmdb211,pmdb205,'',pmdb203,'',pmdb204, 
          '',pmdb032,pmdb051,'' FROM pmdb_t",
                  "",
                  " WHERE pmdbent=? AND pmdbdocno=?"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbseq"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
      #150826-00013# 20160308 mark by beckxie---S
      #LET g_sql = "SELECT  UNIQUE pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,t1.ooefl003,pmdb200,pmdb004,t2.imaal003,t3.imaal004, ", 
      #            "               pmdb005,'','','',pmdb037,t5.ooefl003,pmdb260,t6.ooefl003,pmdb038,t7.inayl003,pmdb201,t8.oocal003, ",
      #            "               pmdb202,pmdb212,pmdb007,t9.oocal003,pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259, ",
      #            "               pmdb252,pmdb207,pmdb015,t10.pmaal004,pmdb049,pmdb030,pmdb048,t11.oocql004,pmdb208,pmdb209,t12.staal003, ",
      #            "               pmdb206,t13.ooag011,pmdb210,pmdb211,pmdb205,t14.ooefl003,pmdb203,t15.ooefl003,pmdb204,t16.inayl003, ",
      #            "               pmdb032,pmdb051,t17.oocql004 ",
      #            "  FROM pmdb_t",
      #            "    LEFT JOIN ooefl_t t1 ON t1.ooeflent = pmdbent AND t1.ooefl001 = pmdbsite AND t1.ooefl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN imaal_t t2 ON t2.imaalent = pmdbent AND t2.imaal001 = pmdb004 AND t2.imaal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN imaal_t t3 ON t3.imaalent = pmdbent AND t3.imaal001 = pmdb004 AND t3.imaal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN ooefl_t t5 ON t5.ooeflent = pmdbent AND t5.ooefl001 = pmdb037 AND t5.ooefl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN ooefl_t t6 ON t6.ooeflent = pmdbent AND t6.ooefl001 = pmdb260 AND t6.ooefl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN inayl_t t7 ON t7.inaylent = pmdbent AND t7.inayl001 = pmdb038 AND t7.inayl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN oocal_t t8 ON t8.oocalent = pmdbent AND t8.oocal001 = pmdb201 AND t8.oocal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN oocal_t t9 ON t9.oocalent = pmdbent AND t9.oocal001 = pmdb007 AND t9.oocal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN pmaal_t t10 ON t10.pmaalent = pmdbent AND t10.pmaal001 = pmdb015 AND t10.pmaal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN oocql_t t11 ON t11.oocqlent = pmdbent AND t11.oocql001 = '274' AND t11.oocql002 = pmdb048 AND t11.oocql003 = '",g_dlang,"' ",
      #            "    LEFT JOIN staal_t t12 ON t12.staalent = pmdbent AND t12.staal001 = pmdb209 AND t12.staal002 = '",g_dlang,"' ",
      #            "    LEFT JOIN ooag_t t13 ON t13.ooagent = pmdbent AND t13.ooag001 = pmdb206  ",
      #            "    LEFT JOIN ooefl_t t14 ON t14.ooeflent = pmdbent AND t14.ooefl001 = pmdb205 AND t14.ooefl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN ooefl_t t15 ON t15.ooeflent = pmdbent AND t15.ooefl001 = pmdb203 AND t15.ooefl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN inayl_t t16 ON t16.inaylent = pmdbent AND t16.inayl001 = pmdb204 AND t16.inayl002 = '",g_dlang,"' ",
      #            "    LEFT JOIN oocql_t t17 ON t17.oocqlent = pmdbent AND t17.oocql001 = '265' AND t17.oocql002 = pmdb051 AND t17.oocql003 = '",g_dlang,"' ",
      #            "   WHERE pmdbent=? AND pmdbdocno=?"
      #150826-00013# 20160308 mark by beckxie---E
      #150826-00013# 20160308 add by beckxie---S
      LET g_sql = "SELECT  UNIQUE pmdbseq,pmdb001,pmdb002,pmdb003,pmdbsite,",
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE ooeflent = pmdbent AND ooefl001 = pmdbsite AND ooefl002 = '",g_dlang,"'), ",
                  "               pmdb200,pmdb004,t2.imaal003,t2.imaal004, ", 
                  #"               pmdb005,'','','',pmdb037,",   #160420-00039#18 160515 by sakura mark
                  #160420-00039#18 160515 by sakura add(S)
                  "               pmdb005,'', ",
                  "               t3.imaa009, ",
                  "               (SELECT rtaxl003 ",
                  "                  FROM rtaxl_t ",
                  "                 WHERE rtaxlent = pmdbent AND rtaxl001 = t3.imaa009 AND rtaxl002 = '",g_dlang,"'), ",
                  "               pmdb037,",
                  #160420-00039#18 160515 by sakura add(E)
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE ooeflent = pmdbent AND ooefl001 = pmdb037 AND ooefl002 = '",g_dlang,"'), ",
                  "               pmdb260,",
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE ooeflent = pmdbent AND ooefl001 = pmdb260 AND ooefl002 = '",g_dlang,"'), ",
                  "               pmdb038,",
                  "               (SELECT inayl003 ",
                  "                  FROM inayl_t ",
                  "                 WHERE inaylent = pmdbent AND inayl001 = pmdb038 AND inayl002 = '",g_dlang,"'), ",
                  "               pmdb201,",
                  "               (SELECT oocal003 ",
                  "                  FROM oocal_t ",
                  "                 WHERE oocalent = pmdbent AND oocal001 = pmdb201 AND oocal002 = '",g_dlang,"'), ",
                  "               pmdb202,pmdb212,pmdb007,",
                  "               (SELECT oocal003 ",
                  "                  FROM oocal_t ",
                  "                 WHERE oocalent = pmdbent AND oocal001 = pmdb007 AND oocal002 = '",g_dlang,"'), ",
                  "               pmdb006,pmdb253,pmdb258,pmdb254,pmdb255,pmdb256,pmdb257,pmdb259, ",
                  "               pmdb252,pmdb207,pmdb015,",
                  "               (SELECT pmaal004 ",
                  "                  FROM pmaal_t ",
                  "                 WHERE pmaalent = pmdbent AND pmaal001 = pmdb015 AND pmaal002 = '",g_dlang,"'), ",
                  "               pmdb049,pmdb030,pmdb048,",
                  "               (SELECT oocql004 ",
                  "                  FROM oocql_t ",
                  "                 WHERE oocqlent = pmdbent AND oocql001 = '274' AND oocql002 = pmdb048 AND oocql003 = '",g_dlang,"'), ",
                  "               pmdb208,pmdb209,",
                  "               (SELECT staal003 ",
                  "                  FROM staal_t ",
                  "                 WHERE staalent = pmdbent AND staal001 = pmdb209 AND staal002 = '",g_dlang,"'), ",
                  "               pmdb206,",
                  "               (SELECT ooag011 ",
                  "                  FROM ooag_t ",
                  "                 WHERE ooagent = pmdbent AND ooag001 = pmdb206),  ",
                  "               pmdb210,pmdb211,pmdb205,",
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE ooeflent = pmdbent AND ooefl001 = pmdb205 AND ooefl002 = '",g_dlang,"'), ",
                  "               pmdb203,",
                  "               (SELECT ooefl003 ",
                  "                  FROM ooefl_t ",
                  "                 WHERE ooeflent = pmdbent AND ooefl001 = pmdb203 AND ooefl002 = '",g_dlang,"'), ",
                  "               pmdb204,",
                  "               (SELECT inayl003 ",
                  "                  FROM inayl_t ",
                  "                 WHERE inaylent = pmdbent AND inayl001 = pmdb204 AND inayl002 = '",g_dlang,"'), ",
                  "               pmdb032,pmdb051, ",
                  "               (SELECT oocql004 ",
                  "                  FROM oocql_t ",
                  "                 WHERE oocqlent = pmdbent AND oocql001 = '265' AND oocql002 = pmdb051 AND oocql003 = '",g_dlang,"') ",
                  "  FROM pmdb_t",
                  "    LEFT JOIN imaal_t t2 ON t2.imaalent = pmdbent AND t2.imaal001 = pmdb004 AND t2.imaal002 = '",g_dlang,"' ",
                  "    LEFT JOIN imaa_t t3 ON pmdbent = t3.imaaent AND pmdb004 = t3.imaa001 ",   #160420-00039#18 160515 by sakura add
                  "   WHERE pmdbent=? AND pmdbdocno=?"
      #150826-00013# 20160308 add by beckxie---E
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
      
      LET g_sql = g_sql, " ORDER BY pmdb_t.pmdbseq"
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE apmq836_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq836_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_pmda_d[g_detail_idx].pmdadocno
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_pmda_d[g_detail_idx].pmdadocno
 
      INTO g_pmda4_d[l_ac].pmdbseq,g_pmda4_d[l_ac].pmdb001,g_pmda4_d[l_ac].pmdb002,g_pmda4_d[l_ac].pmdb003, 
          g_pmda4_d[l_ac].pmdbsite,g_pmda4_d[l_ac].pmdbsite_desc,g_pmda4_d[l_ac].pmdb200,g_pmda4_d[l_ac].pmdb004, 
          g_pmda4_d[l_ac].pmdb004_desc,g_pmda4_d[l_ac].pmdb004_desc_desc,g_pmda4_d[l_ac].pmdb005,g_pmda4_d[l_ac].pmdb005_desc, 
          g_pmda4_d[l_ac].imaa009,g_pmda4_d[l_ac].imaa009_desc,g_pmda4_d[l_ac].pmdb037,g_pmda4_d[l_ac].pmdb037_desc, 
          g_pmda4_d[l_ac].pmdb260,g_pmda4_d[l_ac].pmdb260_desc,g_pmda4_d[l_ac].pmdb038,g_pmda4_d[l_ac].pmdb038_desc, 
          g_pmda4_d[l_ac].pmdb201,g_pmda4_d[l_ac].pmdb201_desc,g_pmda4_d[l_ac].pmdb202,g_pmda4_d[l_ac].pmdb212, 
          g_pmda4_d[l_ac].pmdb007,g_pmda4_d[l_ac].pmdb007_desc,g_pmda4_d[l_ac].pmdb006,g_pmda4_d[l_ac].pmdb253, 
          g_pmda4_d[l_ac].pmdb258,g_pmda4_d[l_ac].pmdb254,g_pmda4_d[l_ac].pmdb255,g_pmda4_d[l_ac].pmdb256, 
          g_pmda4_d[l_ac].pmdb257,g_pmda4_d[l_ac].pmdb259,g_pmda4_d[l_ac].pmdb252,g_pmda4_d[l_ac].pmdb207, 
          g_pmda4_d[l_ac].pmdb015,g_pmda4_d[l_ac].pmdb015_desc,g_pmda4_d[l_ac].pmdb049,g_pmda4_d[l_ac].pmdb030, 
          g_pmda4_d[l_ac].pmdb048,g_pmda4_d[l_ac].pmdb048_desc,g_pmda4_d[l_ac].pmdb208,g_pmda4_d[l_ac].pmdb209, 
          g_pmda4_d[l_ac].pmdb209_desc,g_pmda4_d[l_ac].pmdb206,g_pmda4_d[l_ac].pmdb206_desc,g_pmda4_d[l_ac].pmdb210, 
          g_pmda4_d[l_ac].pmdb211,g_pmda4_d[l_ac].pmdb205,g_pmda4_d[l_ac].pmdb205_desc,g_pmda4_d[l_ac].pmdb203, 
          g_pmda4_d[l_ac].pmdb203_desc,g_pmda4_d[l_ac].pmdb204,g_pmda4_d[l_ac].pmdb204_desc,g_pmda4_d[l_ac].pmdb032, 
          g_pmda4_d[l_ac].pmdb051,g_pmda4_d[l_ac].pmdb051_desc
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
      #產品特徵說明   
      CALL s_feature_description(g_pmda4_d[l_ac].pmdb004,g_pmda4_d[l_ac].pmdb005) 
         RETURNING l_success,g_pmda4_d[l_ac].pmdb005_desc
      #160420-00039#18 160515 by sakura mark(S)   
      ##品類編號
      #CALL apmq836_get_imaa009(g_pmda4_d[l_ac].pmdb004) 
      #   RETURNING g_pmda4_d[l_ac].imaa009
      #
      ##品類說明
      #CALL s_desc_get_rtaxl003_desc(g_pmda4_d[l_ac].imaa009) 
      #   RETURNING g_pmda4_d[l_ac].imaa009_desc         
      #160420-00039#18 160515 by sakura mark(E)
      #end add-point
 
      CALL apmq836_detail_show("'2'")
 
      CALL apmq836_pmdb_t_mask()
 
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
   CALL g_pmda4_d.deleteElement(g_pmda4_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
   
   #end add-point
 
#Page2
   LET li_ac = g_pmda4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="apmq836.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq836_detail_show(ps_page)
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

            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmdasite
            #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmdasite_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmdasite_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmda002
            #LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmda002_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmda002_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmda003
            #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmda003_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmda003_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmda202
            #LET ls_sql = "SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent='"||g_enterprise||"' AND rtaxl001=? AND rtaxl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmda202_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmda202_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmda204
            #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmda204_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmda204_desc
            #
            #INITIALIZE g_ref_fields TO NULL
            #LET g_ref_fields[1] = g_pmda_d[l_ac].pmda205
            #LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            #LET g_pmda_d[l_ac].pmda205_desc = '', g_rtn_fields[1] , ''
            #DISPLAY BY NAME g_pmda_d[l_ac].pmda205_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body4.reference"
 
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq836.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq836_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   DEFINE l_sys       LIKE type_t.num5 
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
      CONSTRUCT g_wc_filter ON pmdasite,pmda200,pmdadocno,pmdadocdt,pmda002,pmda003,pmda202,pmda201, 
          pmda204,pmda205,pmda022,pmdastus
                          FROM s_detail1[1].b_pmdasite,s_detail1[1].b_pmda200,s_detail1[1].b_pmdadocno, 
                              s_detail1[1].b_pmdadocdt,s_detail1[1].b_pmda002,s_detail1[1].b_pmda003, 
                              s_detail1[1].b_pmda202,s_detail1[1].b_pmda201,s_detail1[1].b_pmda204,s_detail1[1].b_pmda205, 
                              s_detail1[1].b_pmda022,s_detail1[1].b_pmdastus
 
         BEFORE CONSTRUCT
                     DISPLAY apmq836_filter_parser('pmdasite') TO s_detail1[1].b_pmdasite
            DISPLAY apmq836_filter_parser('pmda200') TO s_detail1[1].b_pmda200
            DISPLAY apmq836_filter_parser('pmdadocno') TO s_detail1[1].b_pmdadocno
            DISPLAY apmq836_filter_parser('pmdadocdt') TO s_detail1[1].b_pmdadocdt
            DISPLAY apmq836_filter_parser('pmda002') TO s_detail1[1].b_pmda002
            DISPLAY apmq836_filter_parser('pmda003') TO s_detail1[1].b_pmda003
            DISPLAY apmq836_filter_parser('pmda202') TO s_detail1[1].b_pmda202
            DISPLAY apmq836_filter_parser('pmda201') TO s_detail1[1].b_pmda201
            DISPLAY apmq836_filter_parser('pmda204') TO s_detail1[1].b_pmda204
            DISPLAY apmq836_filter_parser('pmda205') TO s_detail1[1].b_pmda205
            DISPLAY apmq836_filter_parser('pmda022') TO s_detail1[1].b_pmda022
            DISPLAY apmq836_filter_parser('pmdastus') TO s_detail1[1].b_pmdastus
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmdasite>>----
         #Ctrlp:construct.c.page1.b_pmdasite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdasite
            #add-point:ON ACTION controlp INFIELD b_pmdasite name="construct.c.filter.page1.b_pmdasite"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmdasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdasite  #顯示到畫面上
            NEXT FIELD b_pmdasite                     #返回原欄位
            #END add-point
 
 
         #----<<b_pmdasite_desc>>----
         #----<<b_pmda200>>----
         #Ctrlp:construct.c.filter.page1.b_pmda200
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda200
            #add-point:ON ACTION controlp INFIELD b_pmda200 name="construct.c.filter.page1.b_pmda200"
            
            #END add-point
 
 
         #----<<b_pmdadocno>>----
         #Ctrlp:construct.c.page1.b_pmdadocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdadocno
            #add-point:ON ACTION controlp INFIELD b_pmdadocno name="construct.c.filter.page1.b_pmdadocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmdadocno  #顯示到畫面上
            NEXT FIELD b_pmdadocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmdadocdt>>----
         #Ctrlp:construct.c.filter.page1.b_pmdadocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdadocdt
            #add-point:ON ACTION controlp INFIELD b_pmdadocdt name="construct.c.filter.page1.b_pmdadocdt"
            
            #END add-point
 
 
         #----<<b_pmda002>>----
         #Ctrlp:construct.c.page1.b_pmda002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda002
            #add-point:ON ACTION controlp INFIELD b_pmda002 name="construct.c.filter.page1.b_pmda002"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmda002  #顯示到畫面上
            NEXT FIELD b_pmda002                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmda002_desc>>----
         #----<<b_pmda003>>----
         #Ctrlp:construct.c.page1.b_pmda003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda003
            #add-point:ON ACTION controlp INFIELD b_pmda003 name="construct.c.filter.page1.b_pmda003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmda003  #顯示到畫面上
            NEXT FIELD b_pmda003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmda003_desc>>----
         #----<<b_pmda202>>----
         #Ctrlp:construct.c.page1.b_pmda202
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda202
            #add-point:ON ACTION controlp INFIELD b_pmda202 name="construct.c.filter.page1.b_pmda202"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
			   CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys #取得品類層級
            LET g_qryparam.arg1 = l_sys
            CALL q_rtax001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmda202  #顯示到畫面上
            NEXT FIELD b_pmda202                     #返回原欄位
            #END add-point
 
 
         #----<<b_pmda202_desc>>----
         #----<<b_pmda201>>----
         #Ctrlp:construct.c.filter.page1.b_pmda201
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda201
            #add-point:ON ACTION controlp INFIELD b_pmda201 name="construct.c.filter.page1.b_pmda201"
            
            #END add-point
 
 
         #----<<b_pmda204>>----
         #Ctrlp:construct.c.page1.b_pmda204
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda204
            #add-point:ON ACTION controlp INFIELD b_pmda204 name="construct.c.filter.page1.b_pmda204"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmda204') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda204',g_site,'c')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef303 = 'Y'" #採購中心
               CALL q_ooef001()  
            END IF  
            
            DISPLAY g_qryparam.return1 TO b_pmda204  #顯示到畫面上
            NEXT FIELD b_pmda204                     #返回原欄位            
    


            #END add-point
 
 
         #----<<b_pmda204_desc>>----
         #----<<b_pmda205>>----
         #Ctrlp:construct.c.page1.b_pmda205
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda205
            #add-point:ON ACTION controlp INFIELD b_pmda205 name="construct.c.filter.page1.b_pmda205"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            
            #判斷aooi500是否有設定
            IF s_aooi500_setpoint(g_prog,'pmda205') THEN
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmda205',g_site,'c')
               CALL q_ooef001_24()
            ELSE    
               LET g_qryparam.where = "ooef302 = 'Y'" #配送中心
               CALL q_ooef001()  
            END IF   
            DISPLAY g_qryparam.return1 TO b_pmda205  #顯示到畫面上
            NEXT FIELD b_pmda205                     #返回原欄位            
    


            #END add-point
 
 
         #----<<b_pmda205_desc>>----
         #----<<b_pmda022>>----
         #Ctrlp:construct.c.filter.page1.b_pmda022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmda022
            #add-point:ON ACTION controlp INFIELD b_pmda022 name="construct.c.filter.page1.b_pmda022"
            
            #END add-point
 
 
         #----<<b_pmdastus>>----
         #Ctrlp:construct.c.filter.page1.b_pmdastus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmdastus
            #add-point:ON ACTION controlp INFIELD b_pmdastus name="construct.c.filter.page1.b_pmdastus"
            
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
 
      CALL apmq836_filter_show('pmdasite','b_pmdasite')
   CALL apmq836_filter_show('pmda200','b_pmda200')
   CALL apmq836_filter_show('pmdadocno','b_pmdadocno')
   CALL apmq836_filter_show('pmdadocdt','b_pmdadocdt')
   CALL apmq836_filter_show('pmda002','b_pmda002')
   CALL apmq836_filter_show('pmda003','b_pmda003')
   CALL apmq836_filter_show('pmda202','b_pmda202')
   CALL apmq836_filter_show('pmda201','b_pmda201')
   CALL apmq836_filter_show('pmda204','b_pmda204')
   CALL apmq836_filter_show('pmda205','b_pmda205')
   CALL apmq836_filter_show('pmda022','b_pmda022')
   CALL apmq836_filter_show('pmdastus','b_pmdastus')
   CALL apmq836_filter_show('pmdbseq','b_pmdbseq')
   CALL apmq836_filter_show('pmdb001','b_pmdb001')
   CALL apmq836_filter_show('pmdb002','b_pmdb002')
   CALL apmq836_filter_show('pmdb003','b_pmdb003')
   CALL apmq836_filter_show('pmdbsite','b_pmdbsite')
   CALL apmq836_filter_show('pmdb200','b_pmdb200')
   CALL apmq836_filter_show('pmdb004','b_pmdb004')
   CALL apmq836_filter_show('pmdb005','b_pmdb005')
   CALL apmq836_filter_show('pmdb037','b_pmdb037')
   CALL apmq836_filter_show('pmdb260','b_pmdb260')
   CALL apmq836_filter_show('pmdb038','b_pmdb038')
   CALL apmq836_filter_show('pmdb201','b_pmdb201')
   CALL apmq836_filter_show('pmdb202','b_pmdb202')
   CALL apmq836_filter_show('pmdb212','b_pmdb212')
   CALL apmq836_filter_show('pmdb007','b_pmdb007')
   CALL apmq836_filter_show('pmdb006','b_pmdb006')
   CALL apmq836_filter_show('pmdb253','b_pmdb253')
   CALL apmq836_filter_show('pmdb258','b_pmdb258')
   CALL apmq836_filter_show('pmdb254','b_pmdb254')
   CALL apmq836_filter_show('pmdb255','b_pmdb255')
   CALL apmq836_filter_show('pmdb256','b_pmdb256')
   CALL apmq836_filter_show('pmdb257','b_pmdb257')
   CALL apmq836_filter_show('pmdb259','b_pmdb259')
   CALL apmq836_filter_show('pmdb252','b_pmdb252')
   CALL apmq836_filter_show('pmdb207','b_pmdb207')
   CALL apmq836_filter_show('pmdb015','b_pmdb015')
   CALL apmq836_filter_show('pmdb049','b_pmdb049')
   CALL apmq836_filter_show('pmdb030','b_pmdb030')
   CALL apmq836_filter_show('pmdb048','b_pmdb048')
   CALL apmq836_filter_show('pmdb208','b_pmdb208')
   CALL apmq836_filter_show('pmdb209','b_pmdb209')
   CALL apmq836_filter_show('pmdb206','b_pmdb206')
   CALL apmq836_filter_show('pmdb210','b_pmdb210')
   CALL apmq836_filter_show('pmdb211','b_pmdb211')
   CALL apmq836_filter_show('pmdb205','b_pmdb205')
   CALL apmq836_filter_show('pmdb203','b_pmdb203')
   CALL apmq836_filter_show('pmdb204','b_pmdb204')
   CALL apmq836_filter_show('pmdb032','b_pmdb032')
   CALL apmq836_filter_show('pmdb051','b_pmdb051')
 
 
   CALL apmq836_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq836.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq836_filter_parser(ps_field)
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
 
{<section id="apmq836.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq836_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq836_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq836.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq836_detail_action_trans()
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
 
{<section id="apmq836.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq836_detail_index_setting()
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
            IF g_pmda_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_pmda_d.getLength() AND g_pmda_d.getLength() > 0
            LET g_detail_idx = g_pmda_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_pmda_d.getLength() THEN
               LET g_detail_idx = g_pmda_d.getLength()
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
 
{<section id="apmq836.mask_functions" >}
 &include "erp/apm/apmq836_mask.4gl"
 
{</section>}
 
{<section id="apmq836.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 取得品類編號
# Memo...........:
# Usage..........: CALL apmq836_get_imaa009(p_pmdb004)
#                  RETURNING r_imaa009
# Input parameter: p_pmdb004      商品編號
# Return code....: r_imaa009      品類編號
# Date & Author..: 2015/03/30 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq836_get_imaa009(p_pmdb004)
DEFINE p_pmdb004      LIKE pmdb_t.pmdb004
DEFINE r_imaa009      LIKE imaa_t.imaa009

   LET r_imaa009 = ''
   SELECT imaa009 INTO r_imaa009 
     FROM imaa_t 
    WHERE imaaent = g_enterprise 
      AND imaa001 = p_pmdb004
              
   RETURN r_imaa009
   
END FUNCTION

 
{</section>}
 
