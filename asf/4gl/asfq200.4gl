#該程式未解開Section, 採用最新樣板產出!
{<section id="asfq200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2015-04-24 11:13:52), PR版次:0002(2015-04-24 11:08:30)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: asfq200
#+ Description: 工單派工看板
#+ Creator....: 01534(2014-12-16 10:35:04)
#+ Modifier...: 05426 -SD/PR- 05426
 
{</section>}
 
{<section id="asfq200.global" >}
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
PRIVATE TYPE type_g_sfpb_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   sfpb002 LIKE sfpb_t.sfpb002, 
   sfpb003 LIKE sfpb_t.sfpb003, 
   sfpb004 LIKE sfpb_t.sfpb004, 
   sfpb005 LIKE sfpb_t.sfpb005, 
   stus LIKE type_t.chr10, 
   sfpb001 LIKE sfpb_t.sfpb001, 
   sfpb006 LIKE sfpb_t.sfpb006, 
   prog_asft300 STRING, 
   sfpb007 LIKE sfpb_t.sfpb007, 
   prog_asft301 STRING, 
   sfaa010 LIKE type_t.chr500, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_desc LIKE type_t.chr500, 
   sfpb008 LIKE sfpb_t.sfpb008, 
   sfpb008_desc LIKE type_t.chr500, 
   sfpb009 LIKE sfpb_t.sfpb009, 
   sfpb010 LIKE sfpb_t.sfpb010, 
   sffb017 LIKE type_t.num20_6, 
   sfba016 LIKE type_t.num20_6, 
   sfba017 LIKE type_t.num20_6 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc1                 STRING
DEFINE g_over                LIKE type_t.chr1
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_sfpb_d
DEFINE g_master_t                   type_g_sfpb_d
DEFINE g_sfpb_d          DYNAMIC ARRAY OF type_g_sfpb_d
DEFINE g_sfpb_d_t        type_g_sfpb_d
 
      
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
 
{<section id="asfq200.main" >}
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
   CALL cl_ap_init("asf","")
 
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
   DECLARE asfq200_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asfq200_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asfq200_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asfq200 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asfq200_init()   
 
      #進入選單 Menu (="N")
      CALL asfq200_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asfq200
      
   END IF 
   
   CLOSE asfq200_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asfq200.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION asfq200_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
   
   
   #add-point:畫面資料初始化 name="init.init"
   LET g_over = 'N'
   DISPLAY g_over TO over
   CALL cl_set_combo_scc('stus','4045')
   #end add-point
 
   CALL asfq200_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="asfq200.default_search" >}
PRIVATE FUNCTION asfq200_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " sfpb001 = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " sfpb002 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " sfpb003 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " sfpb004 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " sfpb005 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " sfpb006 = '", g_argv[06], "' AND "
   END IF
   IF NOT cl_null(g_argv[07]) THEN
      LET g_wc = g_wc, " sfpb007 = '", g_argv[07], "' AND "
   END IF
   IF NOT cl_null(g_argv[08]) THEN
      LET g_wc = g_wc, " sfpb008 = '", g_argv[08], "' AND "
   END IF
   IF NOT cl_null(g_argv[09]) THEN
      LET g_wc = g_wc, " sfpb009 = '", g_argv[09], "' AND "
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
 
{<section id="asfq200.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION asfq200_ui_dialog()
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
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL asfq200_b_fill()
   ELSE
      CALL asfq200_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_sfpb_d.clear()
 
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
 
         CALL asfq200_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_sfpb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL asfq200_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL asfq200_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION detail_qrystr
               MENU "" ATTRIBUTE(STYLE="popup")
                  #add-point:ON ACTION 相關動作 name="menu.detail_show.page1_sub."
                  
                  #END add-point
                                 #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft300
                  LET g_action_choice="prog_asft300"
                  IF cl_auth_chk_act("prog_asft300") THEN
                     
                     #add-point:ON ACTION prog_asft300 name="menu.detail_show.page1_sub.prog_asft300"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft300'
               LET la_param.param[1] = g_sfpb_d[g_detail_idx].sfpb006

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
               #應用 a43 樣板自動產生(Version:4)
               ON ACTION prog_asft301
                  LET g_action_choice="prog_asft301"
                  IF cl_auth_chk_act("prog_asft301") THEN
                     
                     #add-point:ON ACTION prog_asft301 name="menu.detail_show.page1_sub.prog_asft301"
               #應用 a41 樣板自動產生(Version:2)
               #使用JSON格式組合參數與作業編號(串查)
               INITIALIZE la_param.* TO NULL
               LET la_param.prog     = 'asft301'
               LET la_param.param[1] = g_sfpb_d[g_detail_idx].sfpb007

               LET ls_js = util.JSON.stringify(la_param)
               CALL cl_cmdrun_wait(ls_js)
 


                     #END add-point
                     
                     
                  END IF
 
 
 
 
               END MENU
 
 
 
               #add-point:ON ACTION detail_qrystr name="menu.detail_show.page1.detail_qrystr"
               
               #END add-point
               
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
        
         CONSTRUCT BY NAME g_wc1 ON sfpb001,sfpb002,sfpb003
            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD sfpb002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_ecaa001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO sfpb002        #顯示到畫面上
               NEXT FIELD sfpb002  

            ON ACTION controlp INFIELD sfpb003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               CALL q_mrba001_6()     #呼叫開窗                       
               DISPLAY g_qryparam.return1 TO sfpb003        #顯示到畫面上
               NEXT FIELD sfpb003  
               
#            ON ACTION aeecpt
#               CALL asfq200_b_fill()            
            
         END CONSTRUCT
         
         INPUT g_over FROM over
            BEFORE INPUT
               IF cl_null(g_over) THEN LET g_over = 'N' END IF
               DISPLAY g_over TO over
            
            AFTER FIELD over
               DISPLAY g_over TO over
               
               
         END INPUT
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL asfq200_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_over) THEN LET g_over = 'N' END IF
            DISPLAY g_over TO over
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asfq200_insert()
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
               CALL asfq200_query()
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
            CALL asfq200_filter()
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
            CALL asfq200_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_sfpb_d)
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
            CALL asfq200_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL asfq200_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL asfq200_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL asfq200_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_sfpb_d.getLength()
               LET g_sfpb_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_sfpb_d.getLength()
               LET g_sfpb_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_sfpb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfpb_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_sfpb_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_sfpb_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         ON ACTION accept
            CALL asfq200_b_fill()


#         ON ACTION cancel
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
 
{<section id="asfq200.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION asfq200_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   RETURN 
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_sfpb_d.clear()
 
   
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
 
   #應用 qs02 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT前，需先將查詢欄位開啟、顯示欄位隱藏 
   CALL gfrm_curr.setFieldHidden('prog_asft300', TRUE) 
   CALL gfrm_curr.setFieldHidden('b_sfpb006', FALSE) 
   CALL gfrm_curr.setFieldHidden('prog_asft301', TRUE)
   CALL gfrm_curr.setFieldHidden('b_sfpb007', FALSE)
 
  
 
 
 
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON sfpb002,sfpb003,sfpb004,sfpb005,sfpb001,sfpb006,sfpb007,sfpb008,sfpb009, 
          sfpb010
           FROM s_detail1[1].b_sfpb002,s_detail1[1].b_sfpb003,s_detail1[1].b_sfpb004,s_detail1[1].b_sfpb005, 
               s_detail1[1].b_sfpb001,s_detail1[1].b_sfpb006,s_detail1[1].b_sfpb007,s_detail1[1].b_sfpb008, 
               s_detail1[1].b_sfpb009,s_detail1[1].b_sfpb010
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_sfpb002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb002
            #add-point:BEFORE FIELD b_sfpb002 name="construct.b.page1.b_sfpb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb002
            
            #add-point:AFTER FIELD b_sfpb002 name="construct.a.page1.b_sfpb002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfpb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb002
            #add-point:ON ACTION controlp INFIELD b_sfpb002 name="construct.c.page1.b_sfpb002"
            
            #END add-point
 
 
         #----<<b_sfpb003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb003
            #add-point:BEFORE FIELD b_sfpb003 name="construct.b.page1.b_sfpb003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb003
            
            #add-point:AFTER FIELD b_sfpb003 name="construct.a.page1.b_sfpb003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfpb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb003
            #add-point:ON ACTION controlp INFIELD b_sfpb003 name="construct.c.page1.b_sfpb003"
            
            #END add-point
 
 
         #----<<b_sfpb004>>----
         #Ctrlp:construct.c.page1.b_sfpb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb004
            #add-point:ON ACTION controlp INFIELD b_sfpb004 name="construct.c.page1.b_sfpb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb004  #顯示到畫面上
            NEXT FIELD b_sfpb004                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb004
            #add-point:BEFORE FIELD b_sfpb004 name="construct.b.page1.b_sfpb004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb004
            
            #add-point:AFTER FIELD b_sfpb004 name="construct.a.page1.b_sfpb004"
            
            #END add-point
            
 
 
         #----<<b_sfpb005>>----
         #Ctrlp:construct.c.page1.b_sfpb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb005
            #add-point:ON ACTION controlp INFIELD b_sfpb005 name="construct.c.page1.b_sfpb005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooge001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb005  #顯示到畫面上
            NEXT FIELD b_sfpb005                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb005
            #add-point:BEFORE FIELD b_sfpb005 name="construct.b.page1.b_sfpb005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb005
            
            #add-point:AFTER FIELD b_sfpb005 name="construct.a.page1.b_sfpb005"
            
            #END add-point
            
 
 
         #----<<stus>>----
         #----<<b_sfpb001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb001
            #add-point:BEFORE FIELD b_sfpb001 name="construct.b.page1.b_sfpb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb001
            
            #add-point:AFTER FIELD b_sfpb001 name="construct.a.page1.b_sfpb001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfpb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb001
            #add-point:ON ACTION controlp INFIELD b_sfpb001 name="construct.c.page1.b_sfpb001"
            
            #END add-point
 
 
         #----<<b_sfpb006>>----
         #Ctrlp:construct.c.page1.b_sfpb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb006
            #add-point:ON ACTION controlp INFIELD b_sfpb006 name="construct.c.page1.b_sfpb006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb006  #顯示到畫面上
            NEXT FIELD b_sfpb006                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb006
            #add-point:BEFORE FIELD b_sfpb006 name="construct.b.page1.b_sfpb006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb006
            
            #add-point:AFTER FIELD b_sfpb006 name="construct.a.page1.b_sfpb006"
            
            #END add-point
            
 
 
         #----<<prog_asft300>>----
         #----<<b_sfpb007>>----
         #Ctrlp:construct.c.page1.b_sfpb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb007
            #add-point:ON ACTION controlp INFIELD b_sfpb007 name="construct.c.page1.b_sfpb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb007  #顯示到畫面上
            NEXT FIELD b_sfpb007                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb007
            #add-point:BEFORE FIELD b_sfpb007 name="construct.b.page1.b_sfpb007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb007
            
            #add-point:AFTER FIELD b_sfpb007 name="construct.a.page1.b_sfpb007"
            
            #END add-point
            
 
 
         #----<<prog_asft301>>----
         #----<<sfaa010>>----
         #----<<sfaa010_desc>>----
         #----<<sfaa010_desc_desc>>----
         #----<<b_sfpb008>>----
         #Ctrlp:construct.c.page1.b_sfpb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb008
            #add-point:ON ACTION controlp INFIELD b_sfpb008 name="construct.c.page1.b_sfpb008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb008  #顯示到畫面上
            NEXT FIELD b_sfpb008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb008
            #add-point:BEFORE FIELD b_sfpb008 name="construct.b.page1.b_sfpb008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb008
            
            #add-point:AFTER FIELD b_sfpb008 name="construct.a.page1.b_sfpb008"
            
            #END add-point
            
 
 
         #----<<b_sfpb008_desc>>----
         #----<<b_sfpb009>>----
         #Ctrlp:construct.c.page1.b_sfpb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb009
            #add-point:ON ACTION controlp INFIELD b_sfpb009 name="construct.c.page1.b_sfpb009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfcb004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb009  #顯示到畫面上
            NEXT FIELD b_sfpb009                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb009
            #add-point:BEFORE FIELD b_sfpb009 name="construct.b.page1.b_sfpb009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb009
            
            #add-point:AFTER FIELD b_sfpb009 name="construct.a.page1.b_sfpb009"
            
            #END add-point
            
 
 
         #----<<b_sfpb010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_sfpb010
            #add-point:BEFORE FIELD b_sfpb010 name="construct.b.page1.b_sfpb010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_sfpb010
            
            #add-point:AFTER FIELD b_sfpb010 name="construct.a.page1.b_sfpb010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_sfpb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb010
            #add-point:ON ACTION controlp INFIELD b_sfpb010 name="construct.c.page1.b_sfpb010"
            
            #END add-point
 
 
         #----<<sffb017>>----
         #----<<sfba016>>----
         #----<<sfba017>>----
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
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
 
   #應用 qs03 樣板自動產生(Version:3) 
   # 若有做串查功能，在CONSTRUCT後，需先將顯示欄位開啟、查詢欄位隱藏 
   CALL gfrm_curr.setFieldHidden('b_sfpb006', TRUE) 
   CALL gfrm_curr.setFieldHidden('prog_asft300', FALSE) 
   CALL gfrm_curr.setFieldHidden('b_sfpb007', TRUE)
   CALL gfrm_curr.setFieldHidden('prog_asft301', FALSE)
 
  
 
 
 
 
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
   
   #end add-point
        
   LET g_error_show = 1
   CALL asfq200_b_fill()
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
 
{<section id="asfq200.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asfq200_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_type          LIKE type_t.chr1  
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
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
 
   LET ls_sql_rank = "SELECT  UNIQUE '',sfpb002,sfpb003,sfpb004,sfpb005,'',sfpb001,sfpb006,sfpb007,'', 
       '','',sfpb008,'',sfpb009,sfpb010,'','',''  ,DENSE_RANK() OVER( ORDER BY sfpb_t.sfpb001,sfpb_t.sfpb002, 
       sfpb_t.sfpb003,sfpb_t.sfpb004,sfpb_t.sfpb005,sfpb_t.sfpb006,sfpb_t.sfpb007,sfpb_t.sfpb008,sfpb_t.sfpb009) AS RANK FROM sfpb_t", 
 
 
 
                     "",
                     " WHERE sfpbent= ? AND sfpbsite= ? AND 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("sfpb_t"),
                     " ORDER BY sfpb_t.sfpb001,sfpb_t.sfpb002,sfpb_t.sfpb003,sfpb_t.sfpb004,sfpb_t.sfpb005,sfpb_t.sfpb006,sfpb_t.sfpb007,sfpb_t.sfpb008,sfpb_t.sfpb009"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre USING g_enterprise, g_site INTO g_tot_cnt
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
 
   LET g_sql = "SELECT '',sfpb002,sfpb003,sfpb004,sfpb005,'',sfpb001,sfpb006,sfpb007,'','','',sfpb008, 
       '',sfpb009,sfpb010,'','',''",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   IF cl_null(g_wc1) THEN LET g_wc1 = "1=1" END IF
#   LET g_sql = "SELECT  UNIQUE '',sfpb001,sfpb002,sfpb003,sfpb004,sfpb005,'',sfpb006,sfpb007,'','','', 
#       sfpb008,'',sfpb009,SUM(sfpb010),'','','' FROM sfpb_t",
 
   LET g_sql = "SELECT  UNIQUE '','','','','','',sfpb001,sfpb006,sfpb007,'','','', 
                sfpb008,'',sfpb009,SUM(sfpb010),'','','' FROM sfpb_t",
               "",
               " WHERE sfpbent= ? AND sfpbsite= ? AND 1=1 AND ", g_wc1,cl_sql_add_filter("sfpb_t"),
               " GROUP BY sfpb001,sfpb006,sfpb007,sfpb008,sfpb009 "
   
#   LET g_sql = g_sql, cl_sql_add_filter("sfpb_t"),
#                      " ORDER BY sfpb_t.sfpb001,sfpb_t.sfpb002,sfpb_t.sfpb003,sfpb_t.sfpb004,sfpb_t.sfpb005,sfpb_t.sfpb006,sfpb_t.sfpb007,sfpb_t.sfpb008,sfpb_t.sfpb009"
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE asfq200_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR asfq200_pb
   
   OPEN b_fill_curs USING g_enterprise, g_site
 
   CALL g_sfpb_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_sfpb_d[l_ac].sel,g_sfpb_d[l_ac].sfpb002,g_sfpb_d[l_ac].sfpb003,g_sfpb_d[l_ac].sfpb004, 
       g_sfpb_d[l_ac].sfpb005,g_sfpb_d[l_ac].stus,g_sfpb_d[l_ac].sfpb001,g_sfpb_d[l_ac].sfpb006,g_sfpb_d[l_ac].sfpb007, 
       g_sfpb_d[l_ac].sfaa010,g_sfpb_d[l_ac].sfaa010_desc,g_sfpb_d[l_ac].sfaa010_desc_desc,g_sfpb_d[l_ac].sfpb008, 
       g_sfpb_d[l_ac].sfpb008_desc,g_sfpb_d[l_ac].sfpb009,g_sfpb_d[l_ac].sfpb010,g_sfpb_d[l_ac].sffb017, 
       g_sfpb_d[l_ac].sfba016,g_sfpb_d[l_ac].sfba017
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_sfpb_d[l_ac].statepic = cl_get_actipic(g_sfpb_d[l_ac].statepic)
 
      #應用 qs24 樣板自動產生(Version:5) 
      #+ b_fill段欄位串查功能設定 
      IF FGL_GETENV("GUIMODE") = "GWC" THEN 
         LET g_hyper_url = asfq200_get_hyper_data("prog_asft300")
         LET g_sfpb_d[l_ac].prog_asft300 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfpb_d[l_ac].sfpb006), 
             "</a>"
         LET g_hyper_url = asfq200_get_hyper_data("prog_asft301")
         LET g_sfpb_d[l_ac].prog_asft301 = "<a href = '",g_hyper_url,"'>",cl_bpm_replace_xml_specail_char(g_sfpb_d[l_ac].sfpb007), 
             "</a>"
 
      ELSE 
         LET g_sfpb_d[l_ac].prog_asft300 = g_sfpb_d[l_ac].sfpb006
         LET g_sfpb_d[l_ac].prog_asft301 = g_sfpb_d[l_ac].sfpb007
 
      END IF 
 
 
 
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      SELECT sfaa010 INTO g_sfpb_d[l_ac].sfaa010 FROM sfaa_t WHERE sfaaent = g_enterprise
                                                               AND sfaasite = g_site
                                                               AND sfaadocno = g_sfpb_d[l_ac].sfpb006
                                                               
      CALL s_desc_get_item_desc(g_sfpb_d[l_ac].sfaa010) RETURNING  g_sfpb_d[l_ac].sfaa010_desc,g_sfpb_d[l_ac].sfaa010_desc_desc
      CALL s_desc_get_acc_desc('221',g_sfpb_d[l_ac].sfpb008) RETURNING g_sfpb_d[l_ac].sfpb008_desc      
    #上线数量：
    
    #取该站move in报工数量
    #依工单+runcard+作业+作业序+生产日期取sum(sffb017) where sffb001 = '1' and sffbstus='Y'     

      SELECT SUM(sffb017) INTO g_sfpb_d[l_ac].sffb017 FROM sffb_t
       WHERE sffbent = g_enterprise
         AND sffbsite = g_site
         AND sffb001 = '1' 
         AND sffbstus = 'Y'
         AND sffb005 = g_sfpb_d[l_ac].sfpb006
         AND sffb006 = g_sfpb_d[l_ac].sfpb007
         AND sffb007 = g_sfpb_d[l_ac].sfpb008
         AND sffb008 = g_sfpb_d[l_ac].sfpb009
         AND sffb012 = g_sfpb_d[l_ac].sfpb001
      IF cl_null(g_sfpb_d[l_ac].sffb017) THEN
         LET g_sfpb_d[l_ac].sffb017 = 0      
      END IF      
      
   #已完工数量：
   #取该站最后一个报工点的报工数量
   #依工单+runcard+作业+作业序+生产日期取sum(sffb017) where sffb001 = '最后报工点' and sffbstus='Y' 
      CALL asfq200_get_last_action(g_sfpb_d[l_ac].sfpb006,g_sfpb_d[l_ac].sfpb007,g_sfpb_d[l_ac].sfpb008,g_sfpb_d[l_ac].sfpb009) 
           RETURNING r_success,l_type
      SELECT SUM(sffb017) INTO g_sfpb_d[l_ac].sfba016 FROM sffb_t
       WHERE sffbent = g_enterprise
         AND sffbsite = g_site
         AND sffb001 = l_type    #最後一個報工點
         AND sffbstus = 'Y'
         AND sffb005 = g_sfpb_d[l_ac].sfpb006
         AND sffb006 = g_sfpb_d[l_ac].sfpb007
         AND sffb007 = g_sfpb_d[l_ac].sfpb008
         AND sffb008 = g_sfpb_d[l_ac].sfpb009
         AND sffb012 = g_sfpb_d[l_ac].sfpb001
         
      IF cl_null(g_sfpb_d[l_ac].sfba016) THEN
         LET g_sfpb_d[l_ac].sfba016 = 0      
      END IF 
      
      IF g_sfpb_d[l_ac].sffb017 = 0 THEN
         LET g_sfpb_d[l_ac].stus = '1'  #未开工
      END IF
      IF g_sfpb_d[l_ac].sffb017 > 0 AND g_sfpb_d[l_ac].sfpb010 > g_sfpb_d[l_ac].sfba016 THEN
         IF g_sfpb_d[l_ac].sfpb001 >= g_today  THEN         
            LET g_sfpb_d[l_ac].stus = '2'  #加工中
         ELSE
            #逾时未完工：已完工数量<派工数量 且当前站完工日期<=g_today
            LET g_sfpb_d[l_ac].stus = '4'  #逾时未完工
         END IF         
      END IF
 
      IF g_sfpb_d[l_ac].sfpb010 <= g_sfpb_d[l_ac].sfba016 THEN
         LET g_sfpb_d[l_ac].stus = '3'  #已完工
      END IF       
      #未完工数量=派工数量-已完工数量
      LET g_sfpb_d[l_ac].sfba017 = g_sfpb_d[l_ac].sfpb010 - g_sfpb_d[l_ac].sfba016
#      IF g_over = 'Y' AND (g_sfpb_d[l_ac].stus = 1 OR g_sfpb_d[l_ac].stus = '3') THEN #mark by lixh 20150303
      IF g_over = 'Y' AND g_sfpb_d[l_ac].stus = '3' THEN   #add by lixh 20150303
         CONTINUE FOREACH
      END IF
      #end add-point
 
      CALL asfq200_detail_show("'1'")      
 
      CALL asfq200_sfpb_t_mask()
 
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
   
 
   
   CALL g_sfpb_d.deleteElement(g_sfpb_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_sfpb_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE asfq200_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL asfq200_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL asfq200_detail_action_trans()
 
   IF g_sfpb_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL asfq200_fetch()
   END IF
   
      CALL asfq200_filter_show('sfpb002','b_sfpb002')
   CALL asfq200_filter_show('sfpb003','b_sfpb003')
   CALL asfq200_filter_show('sfpb004','b_sfpb004')
   CALL asfq200_filter_show('sfpb005','b_sfpb005')
   CALL asfq200_filter_show('sfpb001','b_sfpb001')
   CALL asfq200_filter_show('sfpb006','b_sfpb006')
   CALL asfq200_filter_show('sfpb007','b_sfpb007')
   CALL asfq200_filter_show('sfpb008','b_sfpb008')
   CALL asfq200_filter_show('sfpb009','b_sfpb009')
   CALL asfq200_filter_show('sfpb010','b_sfpb010')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asfq200_fetch()
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
 
{<section id="asfq200.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION asfq200_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_sfpb_d[l_ac].sfpb008
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_sfpb_d[l_ac].sfpb008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfpb_d[l_ac].sfpb008_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION asfq200_filter()
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
      CONSTRUCT g_wc_filter ON sfpb002,sfpb003,sfpb004,sfpb005,sfpb001,sfpb006,sfpb007,sfpb008,sfpb009, 
          sfpb010
                          FROM s_detail1[1].b_sfpb002,s_detail1[1].b_sfpb003,s_detail1[1].b_sfpb004, 
                              s_detail1[1].b_sfpb005,s_detail1[1].b_sfpb001,s_detail1[1].b_sfpb006,s_detail1[1].b_sfpb007, 
                              s_detail1[1].b_sfpb008,s_detail1[1].b_sfpb009,s_detail1[1].b_sfpb010
 
         BEFORE CONSTRUCT
                     DISPLAY asfq200_filter_parser('sfpb002') TO s_detail1[1].b_sfpb002
            DISPLAY asfq200_filter_parser('sfpb003') TO s_detail1[1].b_sfpb003
            DISPLAY asfq200_filter_parser('sfpb004') TO s_detail1[1].b_sfpb004
            DISPLAY asfq200_filter_parser('sfpb005') TO s_detail1[1].b_sfpb005
            DISPLAY asfq200_filter_parser('sfpb001') TO s_detail1[1].b_sfpb001
            DISPLAY asfq200_filter_parser('sfpb006') TO s_detail1[1].b_sfpb006
            DISPLAY asfq200_filter_parser('sfpb007') TO s_detail1[1].b_sfpb007
            DISPLAY asfq200_filter_parser('sfpb008') TO s_detail1[1].b_sfpb008
            DISPLAY asfq200_filter_parser('sfpb009') TO s_detail1[1].b_sfpb009
            DISPLAY asfq200_filter_parser('sfpb010') TO s_detail1[1].b_sfpb010
 
 
         #單身公用欄位開窗相關處理
         
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_sfpb002>>----
         #Ctrlp:construct.c.filter.page1.b_sfpb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb002
            #add-point:ON ACTION controlp INFIELD b_sfpb002 name="construct.c.filter.page1.b_sfpb002"
            
            #END add-point
 
 
         #----<<b_sfpb003>>----
         #Ctrlp:construct.c.filter.page1.b_sfpb003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb003
            #add-point:ON ACTION controlp INFIELD b_sfpb003 name="construct.c.filter.page1.b_sfpb003"
            
            #END add-point
 
 
         #----<<b_sfpb004>>----
         #Ctrlp:construct.c.page1.b_sfpb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb004
            #add-point:ON ACTION controlp INFIELD b_sfpb004 name="construct.c.filter.page1.b_sfpb004"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oogd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb004  #顯示到畫面上
            NEXT FIELD b_sfpb004                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfpb005>>----
         #Ctrlp:construct.c.page1.b_sfpb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb005
            #add-point:ON ACTION controlp INFIELD b_sfpb005 name="construct.c.filter.page1.b_sfpb005"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooge001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb005  #顯示到畫面上
            NEXT FIELD b_sfpb005                     #返回原欄位
    


            #END add-point
 
 
         #----<<stus>>----
         #----<<b_sfpb001>>----
         #Ctrlp:construct.c.filter.page1.b_sfpb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb001
            #add-point:ON ACTION controlp INFIELD b_sfpb001 name="construct.c.filter.page1.b_sfpb001"
            
            #END add-point
 
 
         #----<<b_sfpb006>>----
         #Ctrlp:construct.c.page1.b_sfpb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb006
            #add-point:ON ACTION controlp INFIELD b_sfpb006 name="construct.c.filter.page1.b_sfpb006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb006  #顯示到畫面上
            NEXT FIELD b_sfpb006                     #返回原欄位
    


            #END add-point
 
 
         #----<<prog_asft300>>----
         #----<<b_sfpb007>>----
         #Ctrlp:construct.c.page1.b_sfpb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb007
            #add-point:ON ACTION controlp INFIELD b_sfpb007 name="construct.c.filter.page1.b_sfpb007"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb007  #顯示到畫面上
            NEXT FIELD b_sfpb007                     #返回原欄位
    


            #END add-point
 
 
         #----<<prog_asft301>>----
         #----<<sfaa010>>----
         #----<<sfaa010_desc>>----
         #----<<sfaa010_desc_desc>>----
         #----<<b_sfpb008>>----
         #Ctrlp:construct.c.page1.b_sfpb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb008
            #add-point:ON ACTION controlp INFIELD b_sfpb008 name="construct.c.filter.page1.b_sfpb008"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb008  #顯示到畫面上
            NEXT FIELD b_sfpb008                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfpb008_desc>>----
         #----<<b_sfpb009>>----
         #Ctrlp:construct.c.page1.b_sfpb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb009
            #add-point:ON ACTION controlp INFIELD b_sfpb009 name="construct.c.filter.page1.b_sfpb009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_sfcb004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_sfpb009  #顯示到畫面上
            NEXT FIELD b_sfpb009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_sfpb010>>----
         #Ctrlp:construct.c.filter.page1.b_sfpb010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_sfpb010
            #add-point:ON ACTION controlp INFIELD b_sfpb010 name="construct.c.filter.page1.b_sfpb010"
            
            #END add-point
 
 
         #----<<sffb017>>----
         #----<<sfba016>>----
         #----<<sfba017>>----
   
 
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
   
      CALL asfq200_filter_show('sfpb002','b_sfpb002')
   CALL asfq200_filter_show('sfpb003','b_sfpb003')
   CALL asfq200_filter_show('sfpb004','b_sfpb004')
   CALL asfq200_filter_show('sfpb005','b_sfpb005')
   CALL asfq200_filter_show('sfpb001','b_sfpb001')
   CALL asfq200_filter_show('sfpb006','b_sfpb006')
   CALL asfq200_filter_show('sfpb007','b_sfpb007')
   CALL asfq200_filter_show('sfpb008','b_sfpb008')
   CALL asfq200_filter_show('sfpb009','b_sfpb009')
   CALL asfq200_filter_show('sfpb010','b_sfpb010')
 
    
   CALL asfq200_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION asfq200_filter_parser(ps_field)
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
 
{<section id="asfq200.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION asfq200_filter_show(ps_field,ps_object)
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
   LET ls_condition = asfq200_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.insert" >}
#+ insert
PRIVATE FUNCTION asfq200_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asfq200.modify" >}
#+ modify
PRIVATE FUNCTION asfq200_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.reproduce" >}
#+ reproduce
PRIVATE FUNCTION asfq200_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.delete" >}
#+ delete
PRIVATE FUNCTION asfq200_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="asfq200.get_hyper_data" >}
#應用 qs01 樣板自動產生(Version:9) 
#+ 取得單身串查網址(包含程式代號及參數) 
PRIVATE FUNCTION asfq200_get_hyper_data(ps_field_name) 
   #add-point:get_hyper_data段define-客製 name="get_hyper_data.define_customerization" 
   
   #end add-point 
   DEFINE ps_field_name    STRING 
   DEFINE ps_url           STRING 
   DEFINE ls_js            STRING 
   DEFINE la_param         RECORD 
                           prog       STRING, 
                           actionid   STRING, 
                           background LIKE type_t.chr1, 
                           param      DYNAMIC ARRAY OF STRING 
                           END RECORD 
   DEFINE ps_type          LIKE type_t.chr10 
   #add-point:get_hyper_data段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="get_hyper_data.define" 
   
   #end add-point 
  
  
   #add-point:FUNCTION前置處理 name="get_hyper_data.before_function" 
   
   #end add-point 
  
   LET ps_url = NULL 
  
   # 設定要做串查的程式代碼 
   CASE 
      WHEN ps_field_name = "prog_asft300" 
         LET la_param.prog = "asft300" 
  
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfpb_d[l_ac].sfpb006 
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft300" 
         LET la_param.param[1] = NULL
         LET la_param.param[2] = g_sfpb_d[l_ac].sfpb006
         #end add-point 
  
      WHEN ps_field_name = "prog_asft301"
         LET la_param.prog = "asft301"
 
         # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、...
         #應用 qs25 樣板自動產生(Version:3)
         #+ 產生串查功能傳入參數部分
 
 
 
         LET la_param.param[1] = g_sfpb_d[l_ac].sfpb007
         #add-point:傳入參數設定 name="get_hyper_data.set_parameter_prog_asft301"
         LET la_param.param[2] = g_sfpb_d[l_ac].sfpb007
         LET la_param.param[1] = NULL
         #end add-point
 
   END CASE 
  
   # 設定傳入參數，請依序放置於 la_param.param[1]、la_param.param[2]、... 
   #add-point:傳入參數設定 name="get_hyper_data.set_parameter" 
   
   #end add-point 
  
   #將陣列資料組合成一個string字串 
   LET ls_js = util.JSON.stringify(la_param) 
  
   #依環境設定要走GDC或GWC模式 (""表示會依據目前的環境判斷，若有自行定義，會依據所定義的模式去執行) 
   LET ps_type = "" 
   #add-point:定義執行模式 name="get_hyper_data.set_env" 
   
   #end add-point 
  
   #呼叫lib，取得完整的url資訊 
   CALL cl_ap_url(ps_type,ls_js) RETURNING ps_url 
 
   LET ps_url = cl_replace_str(ps_url, "&", "&amp;")  
   RETURN ps_url 
  
END FUNCTION 
 
{</section>}
 
{<section id="asfq200.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION asfq200_detail_action_trans()
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
 
{<section id="asfq200.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION asfq200_detail_index_setting()
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
            IF g_sfpb_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_sfpb_d.getLength() AND g_sfpb_d.getLength() > 0
            LET g_detail_idx = g_sfpb_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_sfpb_d.getLength() THEN
               LET g_detail_idx = g_sfpb_d.getLength()
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
 
{<section id="asfq200.mask_functions" >}
 &include "erp/asf/asfq200_mask.4gl"
 
{</section>}
 
{<section id="asfq200.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 尋找最後一個報工點
# Memo...........:
# Usage..........: CALL asfq200_get_last_action(p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
#                  RETURNING r_success,r_type
# Input parameter: p_sfcbdocno    传入工单编号
#                : p_sfcb001      传入RunCard
#                : p_sfcb003      传入作业编号
#                : p_sfcb004      传入作业序
# Return code....: r_success      
#                : r_type         回传1：move in 2：check in 3：报工 4：check out 5：move out
# Date & Author..: 日期 By lixh
# Modify.........:
################################################################################
PRIVATE FUNCTION asfq200_get_last_action(p_sfcbdocno,p_sfcb001,p_sfcb003,p_sfcb004)
   DEFINE p_sfcbdocno  LIKE sfcb_t.sfcbdocno   
   DEFINE p_sfcb001    LIKE sfcb_t.sfcb001
   DEFINE p_sfcb003    LIKE sfcb_t.sfcb003
   DEFINE p_sfcb004    LIKE sfcb_t.sfcb004
   DEFINE r_success    LIKE type_t.num5
   DEFINE r_type       LIKE type_t.num5
   DEFINE l_sfcb014    LIKE sfcb_t.sfcb014
   DEFINE l_sfcb015    LIKE sfcb_t.sfcb015
   DEFINE l_sfcb016    LIKE sfcb_t.sfcb016
   DEFINE l_sfcb018    LIKE sfcb_t.sfcb018
   DEFINE l_sfcb019    LIKE sfcb_t.sfcb019
   
   
   LET r_type = 0
   LET r_success = TRUE
   IF p_sfcbdocno IS NULL OR p_sfcb001 IS NULL OR p_sfcb003 IS NULL OR p_sfcb004 IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00456'
      LET g_errparam.extend = 'get first action'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      LET r_type = 0
      RETURN r_success,r_type
   END IF
   
   SELECT sfcb014,sfcb015,sfcb016,sfcb018,sfcb019 INTO l_sfcb014,l_sfcb015,l_sfcb016,l_sfcb018,l_sfcb019 
     FROM sfcb_t
    WHERE sfcbent   = g_enterprise
      AND sfcbdocno = p_sfcbdocno
      AND sfcb001   = p_sfcb001
      AND sfcb003   = p_sfcb003
      AND sfcb004   = p_sfcb004

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00457'
      LET g_errparam.extend = 'get first action'
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = p_sfcbdocno
      LET g_errparam.replace[2] = p_sfcb001
      LET g_errparam.replace[3] = p_sfcb003
      LET g_errparam.replace[4] = p_sfcb004
      CALL cl_err()
      LET r_success = FALSE
      LET r_type = 0
      RETURN r_success,r_type
   END IF
      
   IF l_sfcb014 = 'Y' THEN LET r_type = '1' END IF
   IF l_sfcb015 = 'Y' THEN LET r_type = '2' END IF
   IF l_sfcb016 = 'Y' THEN LET r_type = '3' END IF
   IF l_sfcb018 = 'Y' THEN LET r_type = '4' END IF
   IF l_sfcb019 = 'Y' THEN LET r_type = '5' END IF
   
   RETURN r_success,r_type
END FUNCTION

 
{</section>}
 
