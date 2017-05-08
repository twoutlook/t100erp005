#該程式未解開Section, 採用最新樣板產出!
{<section id="astq514.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-09-14 13:48:10), PR版次:0004(2016-09-14 13:35:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000041
#+ Filename...: astq514
#+ Description: 專櫃合約保底條款查詢清單
#+ Creator....: 06254(2015-09-02 17:21:27)
#+ Modifier...: 08742 -SD/PR- 08742
 
{</section>}
 
{<section id="astq514.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#160913-00034#3  2016/09/14    by 08742    q_pmaa001開窗改成 q_pmaa001_1抓類型=3 的條件
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
PRIVATE TYPE type_g_stfe_d RECORD
       #statepic       LIKE type_t.chr1,
       
       stfeent LIKE stfe_t.stfeent, 
   stfesite LIKE stfe_t.stfesite, 
   stfesite_desc LIKE type_t.chr500, 
   stfeunit LIKE stfe_t.stfeunit, 
   stfe001 LIKE stfe_t.stfe001, 
   stfa002 LIKE stfa_t.stfa002, 
   stfa005 LIKE stfa_t.stfa005, 
   stfal004 LIKE stfal_t.stfal004, 
   stfa010 LIKE stfa_t.stfa010, 
   stfa010_desc LIKE type_t.chr500, 
   stfe002 LIKE stfe_t.stfe002, 
   stfeseq LIKE stfe_t.stfeseq, 
   stfe003 LIKE stfe_t.stfe003, 
   stfe003_desc LIKE type_t.chr500, 
   stfe004 LIKE stfe_t.stfe004, 
   stfe005 LIKE stfe_t.stfe005, 
   stfe006 LIKE stfe_t.stfe006, 
   stfe012 LIKE stfe_t.stfe012, 
   stfe007 LIKE stfe_t.stfe007, 
   stfe008 LIKE stfe_t.stfe008, 
   stfe009 LIKE stfe_t.stfe009, 
   stfe010 LIKE stfe_t.stfe010, 
   stfe011 LIKE stfe_t.stfe011, 
   stff001 LIKE stff_t.stff001, 
   stffseq LIKE stff_t.stffseq, 
   stff002 LIKE stff_t.stff002, 
   stff003 LIKE stff_t.stff003, 
   stff004 LIKE stff_t.stff004, 
   stff005 LIKE stff_t.stff005, 
   stff005_desc LIKE type_t.chr500, 
   stff007 LIKE stff_t.stff007, 
   stff006 LIKE stff_t.stff006, 
   stff008 LIKE stff_t.stff008, 
   stff010 LIKE stff_t.stff010, 
   stff011 LIKE stff_t.stff011, 
   stff009 LIKE stff_t.stff009 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc1                 STRING
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_stfe_d
DEFINE g_master_t                   type_g_stfe_d
DEFINE g_stfe_d          DYNAMIC ARRAY OF type_g_stfe_d
DEFINE g_stfe_d_t        type_g_stfe_d
 
      
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
 
{<section id="astq514.main" >}
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
   CALL cl_ap_init("ast","")
 
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
   DECLARE astq514_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE astq514_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE astq514_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_astq514 WITH FORM cl_ap_formpath("ast",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL astq514_init()   
 
      #進入選單 Menu (="N")
      CALL astq514_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_astq514
      
   END IF 
   
   CLOSE astq514_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success    #add by dengdd 151008
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="astq514.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION astq514_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_stfe004','6793') 
   CALL cl_set_combo_scc('b_stfe005','6011') 
   CALL cl_set_combo_scc('b_stfe006','6794') 
   CALL cl_set_combo_scc('b_stfe012','6851') 
   CALL cl_set_combo_scc('b_stff010','6864') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc_part('stfa003','6013','4')
   CALL cl_set_combo_scc('stfa004','6785')
   CALL cl_set_combo_scc('stfe004','6793') 
   CALL cl_set_combo_scc_part('stfe005','6011','1,2,3') 
   CALL cl_set_combo_scc('stfe006','6794') 
   CALL cl_set_combo_scc('stfe012','6851')
   CALL cl_set_combo_scc('stff010','6864')    
   
   CALL s_aooi500_create_temp() RETURNING l_success    #add by dengdd 151008
   #end add-point
 
   CALL astq514_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="astq514.default_search" >}
PRIVATE FUNCTION astq514_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " stfe001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " stfeseq = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " stfe002 = '", g_argv[03], "' AND "
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
 
{<section id="astq514.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION astq514_ui_dialog()
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
   DEFINE l_sys2     LIKE type_t.num5  #160126-00002#3 160130 By s983961 add
   DEFINE stfa053    LIKE stfa_t.stfa053
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
   LET g_wc = g_wc," AND 1=1"   #160126-00002#3 160130 By s983961 add
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL astq514_b_fill()
   ELSE
      CALL astq514_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_stfe_d.clear()
 
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
 
         CALL astq514_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_stfe_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL astq514_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL astq514_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         #160126-00002#3 160130 By s983961 add(S)
         CONSTRUCT g_wc1 ON stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010,stfasite
                    FROM stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010,stfasite
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
                  
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stfa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa001  #顯示到畫面上
            NEXT FIELD stfa001                     #返回原欄位
         
         ON ACTION controlp INFIELD stfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa005  #顯示到畫面上
            NEXT FIELD stfa005
         
         ON ACTION controlp INFIELD stfa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#3 -S
            #CALL q_pmaa001()                                       
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#3 -E
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010 
         
         ON ACTION controlp INFIELD stfa051
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
                 CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
            LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa051  #顯示到畫面上
            NEXT FIELD stfa051                     #返回原欄位
            
         ON ACTION controlp INFIELD stfasite
             INITIALIZE g_qryparam.* TO NULL
             LET g_qryparam.state = 'c' 
             LET g_qryparam.reqry = FALSE
             LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')
             CALL q_ooef001_24()                           #呼叫開窗
             DISPLAY g_qryparam.return1 TO stfasite  #顯示到畫面上
             NEXT FIELD stfasite
              
       
         END CONSTRUCT
         #160126-00002#3 160130 By s983961 add(E)
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL astq514_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            #160126-00002#3 160130 By s983961 add(S)
            CALL cl_set_act_visible("insert,query", FALSE)
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE)
            CALL cl_set_comp_visible("sel", FALSE)   
            
            LET stfa053 = 'N'
            DISPLAY stfa053 TO stfa053
            #160126-00002#3 160130 By s983961 add(E)
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL astq514_insert()
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
               CALL astq514_query()
               #add-point:ON ACTION query name="menu.query"
               CALL astq514_qurey_1()
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
            CALL astq514_filter()
            #add-point:ON ACTION filter name="menu.filter"
            CALL cl_set_comp_visible("sel", FALSE)   #160126-00002#3 160127 By s983961 add
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
            CALL astq514_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_stfe_d)
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
            CALL astq514_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL astq514_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL astq514_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL astq514_b_fill()
 
         
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         #160126-00002#3 160131 By s983961 add(s)
         ON ACTION ACCEPT
            LET g_wc = g_wc1        
            LET g_wc2 = " 1=1"     
            
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL astq514_b_fill()
            IF g_stfe_d.getLength() > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1", g_detail_idx)
            END IF
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
         END IF
         #160126-00002#3 160131 By s983961 add(e)   
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
 
{<section id="astq514.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION astq514_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_sys2     LIKE type_t.num5
   
   
   RETURN
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stfe_d.clear()
 
   
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
      CONSTRUCT g_wc_table ON stfeent
           FROM s_detail1[1].b_stfeent
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<b_stfeent>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_stfeent
            #add-point:BEFORE FIELD b_stfeent name="construct.b.page1.b_stfeent"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_stfeent
            
            #add-point:AFTER FIELD b_stfeent name="construct.a.page1.b_stfeent"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_stfeent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfeent
            #add-point:ON ACTION controlp INFIELD b_stfeent name="construct.c.page1.b_stfeent"
            
            #END add-point
 
 
         #----<<b_stfesite>>----
         #----<<b_stfesite_desc>>----
         #----<<b_stfeunit>>----
         #----<<b_stfe001>>----
         #----<<b_stfa002>>----
         #----<<b_stfa005>>----
         #----<<b_stfal004>>----
         #----<<b_stfa010>>----
         #----<<b_stfa010_desc>>----
         #----<<b_stfe002>>----
         #----<<b_stfeseq>>----
         #----<<b_stfe003>>----
         #----<<b_stfe003_desc>>----
         #----<<b_stfe004>>----
         #----<<b_stfe005>>----
         #----<<b_stfe006>>----
         #----<<b_stfe012>>----
         #----<<b_stfe007>>----
         #----<<b_stfe008>>----
         #----<<b_stfe009>>----
         #----<<b_stfe010>>----
         #----<<b_stfe011>>----
         #----<<b_stff001>>----
         #----<<b_stffseq>>----
         #----<<b_stff002>>----
         #----<<b_stff003>>----
         #----<<b_stff004>>----
         #----<<b_stff005>>----
         #----<<b_stff005_desc>>----
         #----<<b_stff007>>----
         #----<<b_stff006>>----
         #----<<b_stff008>>----
         #----<<b_stff010>>----
         #----<<b_stff011>>----
         #----<<b_stff009>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      CONSTRUCT g_wc1 ON stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010
                    FROM stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
                  
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stfa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa001  #顯示到畫面上
            NEXT FIELD stfa001                     #返回原欄位
         
         ON ACTION controlp INFIELD stfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa005  #顯示到畫面上
            NEXT FIELD stfa005
         
         ON ACTION controlp INFIELD stfa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#3 -S
            #CALL q_pmaa001()                                       
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#3 -E
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010 
         
         ON ACTION controlp INFIELD stfa051
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
                 CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
            LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa051  #顯示到畫面上
            NEXT FIELD stfa051                     #返回原欄位
              
       
      END CONSTRUCT
      
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
   LET g_wc = g_wc1        
   LET g_wc2 = " 1=1" 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = "1=2"
      LET g_wc2 = "1=2"
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
   #end add-point
        
   LET g_error_show = 1
   CALL astq514_b_fill()
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
 
{<section id="astq514.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION astq514_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING  
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'stfesite') RETURNING l_where
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
 
   LET ls_sql_rank = "SELECT  UNIQUE stfeent,stfesite,'',stfeunit,stfe001,'','','','','',stfe002,stfeseq, 
       stfe003,'',stfe004,stfe005,stfe006,stfe012,stfe007,stfe008,stfe009,stfe010,stfe011,'','','','', 
       '','','','','','','','',''  ,DENSE_RANK() OVER( ORDER BY stfe_t.stfe001,stfe_t.stfeseq,stfe_t.stfe002) AS RANK FROM stfe_t", 
 
 
 
                     "",
                     " WHERE stfeent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stfe_t"),
                     " ORDER BY stfe_t.stfe001,stfe_t.stfeseq,stfe_t.stfe002"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter," AND ",l_where
   
   LET ls_sql_rank = "SELECT  UNIQUE stfeent,stfesite,t7.ooefl003,stfeunit,stfe001,stfa002,stfa005,t3.stfal004,stfa010,t4.pmaal004,stfe002,stfeseq, 
                                     stfe003,t5.stael003,stfe004,stfe005,stfe006,stfe012,stfe007,stfe008,stfe009,stfe010,stfe011,
                                     stff001,stffseq,stff002,stff003, stff004,stff005,t6.inayl003,stff007,stff006,stff008,stff010,
                                     stff011,stff009 ,
                                     DENSE_RANK() OVER( ORDER BY t1.stfe001,t1.stfe002,t1.stfeseq, t2.stff001, t2.stffseq,t2.stff002, t2.stff003) AS RANK FROM stfa_t",
                     " LEFT OUTER JOIN stfe_t t1 ON t1.stfe001=stfa001 AND t1.stfeent='",g_enterprise,"' AND t1.stfesite=stfasite ",
                     " LEFT OUTER JOIN stff_t t2 ON t2.stff001=t1.stfe001 AND t2.stff002=t1.stfe002 AND t2.stff003=t1.stfeseq AND t2.stffent='",g_enterprise,"' AND t2.stffsite='",g_site,"'",
                     " LEFT OUTER JOIN stfal_t t3 ON t3.stfal001=stfa001 AND t3.stfalent='",g_enterprise,"' AND t3.stfal002='",g_dlang,"'",
                     " LEFT OUTER JOIN pmaal_t t4 ON t4.pmaal001=stfa010 AND t4.pmaalent='",g_enterprise,"' AND t4.pmaal002='",g_dlang,"'",
                     " LEFT OUTER JOIN stael_t t5 ON t5.stael001=t1.stfe003 AND t5.staelent='",g_enterprise,"' AND t5.stael002='",g_dlang,"'",
                     " LEFT OUTER JOIN inayl_t t6 ON t6.inayl001=t2.stff005 AND t6.inaylent='",g_enterprise,"' AND t6.inayl002='",g_dlang,"'",
                     " LEFT OUTER JOIN ooefl_t t7 ON t7.ooefl001=t1.stfesite AND t7.ooefl002 ='",g_dlang,"'",   #add by dengdd 151008 
                     " WHERE stfeent= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("stfe_t"),
                     " ORDER BY t1.stfe001,t1.stfe002,t1.stfeseq,t2.stff001,t2.stffseq,t2.stff002,t2.stff003"
                     
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
 
   LET g_sql = "SELECT stfeent,stfesite,'',stfeunit,stfe001,'','','','','',stfe002,stfeseq,stfe003,'', 
       stfe004,stfe005,stfe006,stfe012,stfe007,stfe008,stfe009,stfe010,stfe011,'','','','','','','', 
       '','','','','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
    LET g_sql = "SELECT stfeent,stfesite,ooefl003,stfeunit,stfe001,stfa002,stfa005,stfal004,stfa010,pmaal004,stfe002,stfeseq, 
                        stfe003,stael003,stfe004,stfe005,stfe006,stfe012,stfe007,stfe008,stfe009,stfe010,stfe011,
                        stff001,stffseq,stff002,stff003, stff004,stff005,inayl003,stff007,stff006,stff008,stff010,
                        stff011,stff009 ",
               "  FROM (",ls_sql_rank,")",
               " WHERE RANK >= ",g_pagestart,
               "   AND RANK < ",g_pagestart + g_num_in_page
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE astq514_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR astq514_pb
   
   OPEN b_fill_curs USING g_enterprise
 
   CALL g_stfe_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_stfe_d[l_ac].stfeent,g_stfe_d[l_ac].stfesite,g_stfe_d[l_ac].stfesite_desc, 
       g_stfe_d[l_ac].stfeunit,g_stfe_d[l_ac].stfe001,g_stfe_d[l_ac].stfa002,g_stfe_d[l_ac].stfa005, 
       g_stfe_d[l_ac].stfal004,g_stfe_d[l_ac].stfa010,g_stfe_d[l_ac].stfa010_desc,g_stfe_d[l_ac].stfe002, 
       g_stfe_d[l_ac].stfeseq,g_stfe_d[l_ac].stfe003,g_stfe_d[l_ac].stfe003_desc,g_stfe_d[l_ac].stfe004, 
       g_stfe_d[l_ac].stfe005,g_stfe_d[l_ac].stfe006,g_stfe_d[l_ac].stfe012,g_stfe_d[l_ac].stfe007,g_stfe_d[l_ac].stfe008, 
       g_stfe_d[l_ac].stfe009,g_stfe_d[l_ac].stfe010,g_stfe_d[l_ac].stfe011,g_stfe_d[l_ac].stff001,g_stfe_d[l_ac].stffseq, 
       g_stfe_d[l_ac].stff002,g_stfe_d[l_ac].stff003,g_stfe_d[l_ac].stff004,g_stfe_d[l_ac].stff005,g_stfe_d[l_ac].stff005_desc, 
       g_stfe_d[l_ac].stff007,g_stfe_d[l_ac].stff006,g_stfe_d[l_ac].stff008,g_stfe_d[l_ac].stff010,g_stfe_d[l_ac].stff011, 
       g_stfe_d[l_ac].stff009
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_stfe_d[l_ac].statepic = cl_get_actipic(g_stfe_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      
      #end add-point
 
      CALL astq514_detail_show("'1'")      
 
      CALL astq514_stfe_t_mask()
 
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
   
 
   
   CALL g_stfe_d.deleteElement(g_stfe_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_stfe_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE astq514_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL astq514_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL astq514_detail_action_trans()
 
   IF g_stfe_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL astq514_fetch()
   END IF
   
      CALL astq514_filter_show('stfeent','b_stfeent')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq514.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION astq514_fetch()
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
 
{<section id="astq514.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION astq514_detail_show(ps_page)
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

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stfe_d[l_ac].stfa010
            LET ls_sql = "SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stfe_d[l_ac].stfa010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stfe_d[l_ac].stfa010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stfe_d[l_ac].stfe003
            LET ls_sql = "SELECT stael003 FROM stael_t WHERE staelent='"||g_enterprise||"' AND stael001=? AND stael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stfe_d[l_ac].stfe003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stfe_d[l_ac].stfe003_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_stfe_d[l_ac].stff005
            LET ls_sql = "SELECT inayl003 FROM inayl_t WHERE inaylent='"||g_enterprise||"' AND inayl001=? AND inayl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_stfe_d[l_ac].stff005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_stfe_d[l_ac].stff005_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="astq514.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION astq514_filter()
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
      CONSTRUCT g_wc_filter ON stfeent
                          FROM s_detail1[1].b_stfeent
 
         BEFORE CONSTRUCT
                     DISPLAY astq514_filter_parser('stfeent') TO s_detail1[1].b_stfeent
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<b_stfeent>>----
         #Ctrlp:construct.c.filter.page1.b_stfeent
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_stfeent
            #add-point:ON ACTION controlp INFIELD b_stfeent name="construct.c.filter.page1.b_stfeent"
            
            #END add-point
 
 
         #----<<b_stfesite>>----
         #----<<b_stfesite_desc>>----
         #----<<b_stfeunit>>----
         #----<<b_stfe001>>----
         #----<<b_stfa002>>----
         #----<<b_stfa005>>----
         #----<<b_stfal004>>----
         #----<<b_stfa010>>----
         #----<<b_stfa010_desc>>----
         #----<<b_stfe002>>----
         #----<<b_stfeseq>>----
         #----<<b_stfe003>>----
         #----<<b_stfe003_desc>>----
         #----<<b_stfe004>>----
         #----<<b_stfe005>>----
         #----<<b_stfe006>>----
         #----<<b_stfe012>>----
         #----<<b_stfe007>>----
         #----<<b_stfe008>>----
         #----<<b_stfe009>>----
         #----<<b_stfe010>>----
         #----<<b_stfe011>>----
         #----<<b_stff001>>----
         #----<<b_stffseq>>----
         #----<<b_stff002>>----
         #----<<b_stff003>>----
         #----<<b_stff004>>----
         #----<<b_stff005>>----
         #----<<b_stff005_desc>>----
         #----<<b_stff007>>----
         #----<<b_stff006>>----
         #----<<b_stff008>>----
         #----<<b_stff010>>----
         #----<<b_stff011>>----
         #----<<b_stff009>>----
   
 
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
   
      CALL astq514_filter_show('stfeent','b_stfeent')
 
    
   CALL astq514_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="astq514.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION astq514_filter_parser(ps_field)
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
 
{<section id="astq514.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION astq514_filter_show(ps_field,ps_object)
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
   LET ls_condition = astq514_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="astq514.insert" >}
#+ insert
PRIVATE FUNCTION astq514_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="astq514.modify" >}
#+ modify
PRIVATE FUNCTION astq514_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq514.reproduce" >}
#+ reproduce
PRIVATE FUNCTION astq514_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq514.delete" >}
#+ delete
PRIVATE FUNCTION astq514_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="astq514.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION astq514_detail_action_trans()
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
 
{<section id="astq514.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION astq514_detail_index_setting()
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
            IF g_stfe_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_stfe_d.getLength() AND g_stfe_d.getLength() > 0
            LET g_detail_idx = g_stfe_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_stfe_d.getLength() THEN
               LET g_detail_idx = g_stfe_d.getLength()
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
 
{<section id="astq514.mask_functions" >}
 &include "erp/ast/astq514_mask.4gl"
 
{</section>}
 
{<section id="astq514.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL astq514_qurey_1()
# Date & Author..: 2015/9/8 By dengdd
# Modify.........:
################################################################################
PRIVATE FUNCTION astq514_qurey_1()
DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準
   DEFINE l_sys2     LIKE type_t.num5
   #end add-point 
   #add-point:query段define-客製

   #end add-point 
   
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_stfe_d.clear()
   
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
      #add-point:query段more_construct
      CONSTRUCT g_wc1 ON stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010,stfasite
                    FROM stfa001,stfa002,stfa003,stfa004,stfa005,stfa010,stfa051,stfa053,
                         stfe004,stfe005,stfe006,stfe012,stfe008,stfe009,stff010,stfasite
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct

            #end add-point 
                  
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD stfa001
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_stfa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa001  #顯示到畫面上
            NEXT FIELD stfa001                     #返回原欄位
         
         ON ACTION controlp INFIELD stfa005
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1=g_site
            CALL q_mhae001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa005  #顯示到畫面上
            NEXT FIELD stfa005
         
         ON ACTION controlp INFIELD stfa010
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #160913-00034#3 -S
            #CALL q_pmaa001()                                       
            LET g_qryparam.arg1 = "('3')"            
            CALL q_pmaa001_1()                           #呼叫開窗
            #160913-00034#3 -E
            DISPLAY g_qryparam.return1 TO stfa010  #顯示到畫面上
            NEXT FIELD stfa010 
         
         ON ACTION controlp INFIELD stfa051
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
                 CALL cl_get_para(g_enterprise,g_site,'E-CIR-0001') RETURNING l_sys2 #取得品類層級
            LET g_qryparam.arg1 = l_sys2 #
            CALL q_rtax001_3()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfa051  #顯示到畫面上
            NEXT FIELD stfa051                     #返回原欄位
            
        ON ACTION controlp INFIELD stfasite
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'stfasite',g_site,'c')
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO stfasite  #顯示到畫面上
            NEXT FIELD stfasite
              
       
      END CONSTRUCT
      
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept

         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前

      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後

         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後
 
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc1 
 
 
        
   LET g_wc2 = " 1=1"
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = ls_wc
      LET g_wc2 = ls_wc2
      LET g_wc_filter = g_wc_filter_t
   ELSE
      LET g_master_idx = 1
   END IF
        
   LET g_error_show = 1
   CALL astq514_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = -100 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION

 
{</section>}
 
