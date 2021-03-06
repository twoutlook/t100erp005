#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq407.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:8(2015-07-08 09:27:07), PR版次:0008(2016-10-18 09:20:17)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000126
#+ Filename...: adeq407
#+ Description: 保全對帳差異查詢作業
#+ Creator....: 04226(2014-06-23 15:17:31)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="adeq407.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#161006-00008#6   2016/10/18  by 06137       組織類型與職能開窗清單調整
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
PRIVATE TYPE type_g_deav_d RECORD
       
       sel LIKE type_t.chr1, 
   deavseq LIKE deav_t.deavseq, 
   deavsite LIKE deav_t.deavsite, 
   deavsite_desc LIKE type_t.chr500, 
   deavdocno LIKE deav_t.deavdocno, 
   deavdocdt LIKE deav_t.deavdocdt, 
   deav001 LIKE deav_t.deav001, 
   deav002 LIKE deav_t.deav002, 
   deav002_desc LIKE type_t.chr500, 
   deav003 LIKE deav_t.deav003, 
   deav003_desc LIKE type_t.chr500, 
   deav004 LIKE deav_t.deav004, 
   deav004_desc LIKE type_t.chr500, 
   deav005 LIKE deav_t.deav005, 
   deav005_desc LIKE type_t.chr500, 
   deav006 LIKE deav_t.deav006, 
   deav007 LIKE deav_t.deav007, 
   deav008 LIKE deav_t.deav008, 
   deav009 LIKE deav_t.deav009, 
   deav010 LIKE deav_t.deav010, 
   deav012 LIKE deav_t.deav012, 
   deav011 LIKE deav_t.deav011, 
   deav013 LIKE deav_t.deav013, 
   deav014 LIKE deav_t.deav014, 
   deav015 LIKE deav_t.deav015, 
   deav016 LIKE deav_t.deav016
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_head      RECORD
       deavsite    STRING,
       deavdocdt   STRING,
       deav010     STRING,
       type1       LIKE type_t.chr1,
       type2       LIKE type_t.chr1
                   END RECORD
#end add-point
 
#模組變數(Module Variables)
DEFINE g_deav_d            DYNAMIC ARRAY OF type_g_deav_d
DEFINE g_deav_d_t          type_g_deav_d
 
 
 
 
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
 
{<section id="adeq407.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
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
   DECLARE adeq407_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq407_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq407_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq407 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq407_init()   
 
      #進入選單 Menu (="N")
      CALL adeq407_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq407
      
   END IF 
   
   CLOSE adeq407_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success    #161006-00008#6 Add By Ken 161018
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq407.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq407_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success LIKE type_t.num5      #150308-00001#2  By sakura 150309
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_deav001','8310') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   LET g_head.type1 = 'N'
   LET g_head.type2 = 'N'
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
 
   CALL adeq407_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq407.default_search" >}
PRIVATE FUNCTION adeq407_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " deavdocno = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " deavseq = '", g_argv[02], "' AND "
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
 
{<section id="adeq407.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq407_ui_dialog() 
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
 
   
   CALL adeq407_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_deav_d.clear()
 
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
 
         CALL adeq407_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         #單頭
         INPUT g_head.type1,g_head.type2
             FROM type1,type2
             
            BEFORE INPUT
               LET g_head.type1 = 'N'
               LET g_head.type2 = 'N'
               DISPLAY g_head.type1,g_head.type2 TO type1,type2
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT g_wc ON deavsite,deavdocdt,deav010 FROM deavsite,deavdocdt,deav010
                           
            ON ACTION controlp INFIELD deavsite
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'deavsite',g_site,'c') #150308-00001#2  By sakura add 'c'
               CALL q_ooef001_24()                        #呼叫開窗
               LET g_head.deavsite = g_qryparam.return1
               DISPLAY g_head.deavsite TO deavsite     #顯示到畫面上
               NEXT FIELD deavsite                     #返回原欄位
            ON ACTION controlp INFIELD deav010
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_deamdocno()                     #呼叫開窗
               LET g_head.deav010 = g_qryparam.return1
               DISPLAY g_head.deav010 TO deav010      #顯示到畫面上
               NEXT FIELD deav010                     #返回原欄位
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_deav_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq407_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL adeq407_b_fill2()
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
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL adeq407_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_head.type1 = 'N'
            LET g_head.type2 = 'N'
            DISPLAY g_head.type1,g_head.type2 TO type1,type2
            CALL cl_set_act_visible("selall,selnone,sel,unsel", FALSE) #sakura add
            CALL cl_set_comp_visible("sel", FALSE)                     #sakura add            
            #end add-point
            NEXT FIELD deavsite
 
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
            CALL adeq407_b_fill()
 
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
               LET g_export_node[1] = base.typeInfo.create(g_deav_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL adeq407_b_fill()
 
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
            CALL adeq407_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL adeq407_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL adeq407_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL adeq407_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_deav_d.getLength()
               LET g_deav_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_deav_d.getLength()
               LET g_deav_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_deav_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deav_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_deav_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_deav_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL adeq407_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               EXIT DIALOG #sakura add
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
 
{<section id="adeq407.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq407_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_deav_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL s_aooi500_sql_where(g_prog,'deavsite') RETURNING l_where
   LET ls_wc = ls_wc," AND ",l_where
   #是否只顯示有差異部分
   IF g_head.type1 = 'Y' THEN
      LET ls_wc = ls_wc," AND deav013 <> 0 "
   END IF
   #是否只顯示有差異且未處理部分
   IF g_head.type2 = 'Y' THEN
      LET ls_wc = ls_wc," AND deav013 <> 0 AND deav014 = 'N'"
   END IF
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '',deavseq,deavsite,'',deavdocno,deavdocdt,deav001,deav002,'',deav003, 
       '',deav004,'',deav005,'',deav006,deav007,deav008,deav009,deav010,deav012,deav011,deav013,deav014, 
       deav015,deav016  ,DENSE_RANK() OVER( ORDER BY deav_t.deavdocno,deav_t.deavseq) AS RANK FROM deav_t", 
 
 
 
                     "",
                     " WHERE deavent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deav_t"),
                     " ORDER BY deav_t.deavdocno,deav_t.deavseq"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT UNIQUE '', ",
               "              deavseq, deavsite,",
               "              (SELECT ooefl003",
               "                 FROM ooefl_t",
               "                WHERE ooeflent = deavent AND ooefl001 = deavsite",
               "                  AND ooefl002 = '",g_dlang,"') deavsite_desc,",
               "              deavdocno,   deavdocdt,deav001, deav002, ",
               "              (SELECT ooial003",
               "                 FROM ooial_t",
               "                WHERE ooialent = deavent AND ooial001 = deav002",
               "                  AND ooial002 = '",g_dlang,"') deav002_desc,",
               "              deav003,t3.funds_desc deav003_desc,deav004,",
               "              (SELECT oocql004",
               "                 FROM oocql_t",
               "                WHERE oocqlent = deavent AND oocql001 = '2071'",
               "                  AND oocql002 = deav004 AND oocql003 = '",g_dlang,"') deav004_desc,",
               "              deav005,",
               "              (SELECT ooail003",
               "                 FROM ooail_t",
               "                WHERE ooailent = deavent AND ooail001 = deav005",
               "                  AND ooail002 = '",g_dlang,"') deav005_desc,",
               "              deav006,",
               "              deav007, deav008,     deav009,     deav010,     deav012, ",
               "              deav011, deav013,     deav014,     deav015,     deav016 ",
               " ,DENSE_RANK() OVER( ORDER BY deav_t.deavdocno,deav_t.deavseq) AS RANK",
               "  FROM deav_t ",
               "       LEFT JOIN (SELECT gcaflent funds_ent, gcafl001 funds_id, gcafl003 funds_desc, '40' funds_type ", 
               "                    FROM gcafl_t WHERE gcafl002 = '",g_dlang,"' ",
               "                  UNION ALL ",
               "                  SELECT mmanlent funds_ent, mmanl001 funds_id, mmanl003 funds_desc, '50' funds_type ",
               "                    FROM mmanl_t WHERE mmanl002 = '",g_dlang,"') t3 ",
               "              ON t3.funds_ent = deavent AND t3.funds_type = deav001 AND t3.funds_id = deav003 ",
               " WHERE deavent= ? AND 1=1 AND ", ls_wc
 
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("deav_t"),
                      " ORDER BY deav_t.deavdocno,deav_t.deavseq"   
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)
   #150826-00013#1 效能調整 20150910 add by beckxie---E
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
 
   LET g_sql = "SELECT '',deavseq,deavsite,'',deavdocno,deavdocdt,deav001,deav002,'',deav003,'',deav004, 
       '',deav005,'',deav006,deav007,deav008,deav009,deav010,deav012,deav011,deav013,deav014,deav015, 
       deav016",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   ##150302-00004#8 150312 by lori522612 add 效能調整---(S)
   ##+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #LET g_sql = "SELECT UNIQUE '', ",
   #            "              deavseq, deavsite,    t1.ooefl001, deavdocno,   deavdocdt, ",
   #            "              deav001, deav002,     t2.ooial003, deav003,     t3.funds_desc,",
   #            "              deav004, t4.oocql003, deav005,     t5.ooail003, deav006, ",
   #            "              deav007, deav008,     deav009,     deav010,     deav012, ",
   #            "              deav011, deav013,     deav014,     deav015,     deav016 ",
   #            "  FROM deav_t ",
   #            "       LEFT JOIN ooefl_t t1 ON t1.ooeflent = deavent AND t1.ooefl001 = deavsite AND t1.ooefl002 = '",g_dlang,"' ",
   #            "       LEFT JOIN ooial_t t2 ON t2.ooialent = deavent AND t2.ooial001 = deav002 AND t2.ooial002 = '",g_dlang,"' ",
   #            "       LEFT JOIN (SELECT gcaflent funds_ent, gcafl001 funds_id, gcafl003 funds_desc, '40' funds_type ", 
   #            "                    FROM gcafl_t WHERE gcafl002 = '",g_dlang,"' ",
   #            "                  UNION ALL ",
   #            "                  SELECT mmanlent funds_ent, mmanl001 funds_id, mmanl003 funds_desc, '50' funds_type ",
   #            "                    FROM mmanl_t WHERE mmanl002 = '",g_dlang,"') t3 ",
   #            "              ON t3.funds_ent = deavent AND t3.funds_type = deav001 AND t3.funds_id = deav003 ",
   #            "       LEFT JOIN oocql_t t4 ON t4.oocqlent = deavent AND t4.oocql001 = '2071' AND t4.oocql002 = deav004 AND t4.oocql003 = '",g_dlang,"' ",
   #            "       LEFT JOIN ooail_t t5 ON t5.ooailent = deavent AND t5.ooail001 = deav005 AND t5.ooail002 = '",g_dlang,"' ",
   #            " WHERE deavent = ? ",
   #            "   AND ", ls_wc
   #
   #LET g_sql = g_sql, cl_sql_add_filter("deav_t"),
   #                   " ORDER BY deav_t.deavdocno,deav_t.deavseq"   
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)
   #150826-00013#1 效能調整 20150910 add by beckxie---E
   #150826-00013#1 效能調整 20150910 add by beckxie---S
   LET g_sql = "SELECT 'N',",
               "   deavseq,    deavsite,deavsite_desc,    deavdocno,deavdocdt,",
               "   deav001,     deav002, deav002_desc,      deav003,deav003_desc,",
               "   deav004,deav004_desc,      deav005, deav005_desc,deav006,",
               "   deav007,     deav008,      deav009,      deav010,deav012,",
               "   deav011,     deav013,      deav014,      deav015,deav016",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150910 add by beckxie---E
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq407_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq407_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_deav_d[l_ac].sel,g_deav_d[l_ac].deavseq,g_deav_d[l_ac].deavsite,g_deav_d[l_ac].deavsite_desc, 
       g_deav_d[l_ac].deavdocno,g_deav_d[l_ac].deavdocdt,g_deav_d[l_ac].deav001,g_deav_d[l_ac].deav002, 
       g_deav_d[l_ac].deav002_desc,g_deav_d[l_ac].deav003,g_deav_d[l_ac].deav003_desc,g_deav_d[l_ac].deav004, 
       g_deav_d[l_ac].deav004_desc,g_deav_d[l_ac].deav005,g_deav_d[l_ac].deav005_desc,g_deav_d[l_ac].deav006, 
       g_deav_d[l_ac].deav007,g_deav_d[l_ac].deav008,g_deav_d[l_ac].deav009,g_deav_d[l_ac].deav010,g_deav_d[l_ac].deav012, 
       g_deav_d[l_ac].deav011,g_deav_d[l_ac].deav013,g_deav_d[l_ac].deav014,g_deav_d[l_ac].deav015,g_deav_d[l_ac].deav016 
 
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_deav_d[l_ac].sel = 'N'
      #end add-point
 
      CALL adeq407_detail_show("'1'")
 
      CALL adeq407_deav_t_mask()
 
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
 
   CALL g_deav_d.deleteElement(g_deav_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_deav_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE adeq407_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL adeq407_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq407_detail_action_trans()
 
   LET l_ac = 1
   IF g_deav_d.getLength() > 0 THEN
      CALL adeq407_b_fill2()
   END IF
 
      CALL adeq407_filter_show('deavseq','b_deavseq')
   CALL adeq407_filter_show('deavsite','b_deavsite')
   CALL adeq407_filter_show('deavdocno','b_deavdocno')
   CALL adeq407_filter_show('deavdocdt','b_deavdocdt')
   CALL adeq407_filter_show('deav001','b_deav001')
   CALL adeq407_filter_show('deav002','b_deav002')
   CALL adeq407_filter_show('deav003','b_deav003')
   CALL adeq407_filter_show('deav004','b_deav004')
   CALL adeq407_filter_show('deav005','b_deav005')
   CALL adeq407_filter_show('deav006','b_deav006')
   CALL adeq407_filter_show('deav007','b_deav007')
   CALL adeq407_filter_show('deav008','b_deav008')
   CALL adeq407_filter_show('deav009','b_deav009')
   CALL adeq407_filter_show('deav010','b_deav010')
   CALL adeq407_filter_show('deav012','b_deav012')
   CALL adeq407_filter_show('deav011','b_deav011')
   CALL adeq407_filter_show('deav013','b_deav013')
   CALL adeq407_filter_show('deav014','b_deav014')
   CALL adeq407_filter_show('deav015','b_deav015')
   CALL adeq407_filter_show('deav016','b_deav016')
 
 
END FUNCTION
 
{</section>}
 
{<section id="adeq407.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq407_b_fill2()
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
 
{<section id="adeq407.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq407_detail_show(ps_page)
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
      ##營運據點
      #CALL s_desc_get_department_desc(g_deav_d[l_ac].deavsite)
      #   RETURNING g_deav_d[l_ac].deavsite_desc
      #DISPLAY BY NAME g_deav_d[l_ac].deavsite_desc
      #
      ##款別
      #CALL s_desc_get_ooial_desc(g_deav_d[l_ac].deav002)
      #   RETURNING g_deav_d[l_ac].deav002_desc
      #DISPLAY BY NAME g_deav_d[l_ac].deav002_desc
      #
      ##卡券種編號
      #CASE g_deav_d[l_ac].deav001
      #   WHEN '40' #款別編號=40有價券/禮券類型
      #      CALL s_deac_get_gcaf_desc(g_deav_d[l_ac].deav003)
      #         RETURNING g_deav_d[l_ac].deav003_desc
      #   WHEN '50' #款別編號=50銀行卡/信用卡
      #      CALL s_desc_get_mman_desc(g_deav_d[l_ac].deav003)
      #         RETURNING g_deav_d[l_ac].deav003_desc
      #END CASE
      #DISPLAY BY NAME g_deav_d[l_ac].deav003_desc
      #
      ##券面額
      #CALL s_desc_get_acc_desc('2071',g_deav_d[l_ac].deav004)
      #   RETURNING g_deav_d[l_ac].deav004_desc
      #DISPLAY BY NAME g_deav_d[l_ac].deav004_desc
      #
      ##幣別
      #CALL s_desc_get_currency_desc(g_deav_d[l_ac].deav005)
      #   RETURNING g_deav_d[l_ac].deav005_desc
      #DISPLAY BY NAME g_deav_d[l_ac].deav005_desc
      #150302-00004#8 150312 by lori522612 mark---(E)
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq407.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION adeq407_filter()
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
      CONSTRUCT g_wc_filter ON deavseq,deavsite,deavdocno,deavdocdt,deav001,deav002,deav003,deav004, 
          deav005,deav006,deav007,deav008,deav009,deav010,deav012,deav011,deav013,deav014,deav015,deav016 
 
                          FROM s_detail1[1].b_deavseq,s_detail1[1].b_deavsite,s_detail1[1].b_deavdocno, 
                              s_detail1[1].b_deavdocdt,s_detail1[1].b_deav001,s_detail1[1].b_deav002, 
                              s_detail1[1].b_deav003,s_detail1[1].b_deav004,s_detail1[1].b_deav005,s_detail1[1].b_deav006, 
                              s_detail1[1].b_deav007,s_detail1[1].b_deav008,s_detail1[1].b_deav009,s_detail1[1].b_deav010, 
                              s_detail1[1].b_deav012,s_detail1[1].b_deav011,s_detail1[1].b_deav013,s_detail1[1].b_deav014, 
                              s_detail1[1].b_deav015,s_detail1[1].b_deav016
 
         BEFORE CONSTRUCT
                     DISPLAY adeq407_filter_parser('deavseq') TO s_detail1[1].b_deavseq
            DISPLAY adeq407_filter_parser('deavsite') TO s_detail1[1].b_deavsite
            DISPLAY adeq407_filter_parser('deavdocno') TO s_detail1[1].b_deavdocno
            DISPLAY adeq407_filter_parser('deavdocdt') TO s_detail1[1].b_deavdocdt
            DISPLAY adeq407_filter_parser('deav001') TO s_detail1[1].b_deav001
            DISPLAY adeq407_filter_parser('deav002') TO s_detail1[1].b_deav002
            DISPLAY adeq407_filter_parser('deav003') TO s_detail1[1].b_deav003
            DISPLAY adeq407_filter_parser('deav004') TO s_detail1[1].b_deav004
            DISPLAY adeq407_filter_parser('deav005') TO s_detail1[1].b_deav005
            DISPLAY adeq407_filter_parser('deav006') TO s_detail1[1].b_deav006
            DISPLAY adeq407_filter_parser('deav007') TO s_detail1[1].b_deav007
            DISPLAY adeq407_filter_parser('deav008') TO s_detail1[1].b_deav008
            DISPLAY adeq407_filter_parser('deav009') TO s_detail1[1].b_deav009
            DISPLAY adeq407_filter_parser('deav010') TO s_detail1[1].b_deav010
            DISPLAY adeq407_filter_parser('deav012') TO s_detail1[1].b_deav012
            DISPLAY adeq407_filter_parser('deav011') TO s_detail1[1].b_deav011
            DISPLAY adeq407_filter_parser('deav013') TO s_detail1[1].b_deav013
            DISPLAY adeq407_filter_parser('deav014') TO s_detail1[1].b_deav014
            DISPLAY adeq407_filter_parser('deav015') TO s_detail1[1].b_deav015
            DISPLAY adeq407_filter_parser('deav016') TO s_detail1[1].b_deav016
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_deavseq>>----
         #Ctrlp:construct.c.filter.page1.b_deavseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deavseq
            #add-point:ON ACTION controlp INFIELD b_deavseq name="construct.c.filter.page1.b_deavseq"
            
            #END add-point
 
 
         #----<<b_deavsite>>----
         #Ctrlp:construct.c.filter.page1.b_deavsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deavsite
            #add-point:ON ACTION controlp INFIELD b_deavsite name="construct.c.filter.page1.b_deavsite"
            #161006-00008#6 Add By Ken 161018(S)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'deavsite',g_site,'c') 
            CALL q_ooef001_24()                        #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_deavsite  #顯示到畫面上
            NEXT FIELD b_deavsite                     #返回原欄位
            #161006-00008#6 Add By Ken 161018(E)
            #END add-point
 
 
         #----<<b_deavsite_desc>>----
         #----<<b_deavdocno>>----
         #Ctrlp:construct.c.filter.page1.b_deavdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deavdocno
            #add-point:ON ACTION controlp INFIELD b_deavdocno name="construct.c.filter.page1.b_deavdocno"
            
            #END add-point
 
 
         #----<<b_deavdocdt>>----
         #Ctrlp:construct.c.filter.page1.b_deavdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deavdocdt
            #add-point:ON ACTION controlp INFIELD b_deavdocdt name="construct.c.filter.page1.b_deavdocdt"
            
            #END add-point
 
 
         #----<<b_deav001>>----
         #Ctrlp:construct.c.filter.page1.b_deav001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav001
            #add-point:ON ACTION controlp INFIELD b_deav001 name="construct.c.filter.page1.b_deav001"
            
            #END add-point
 
 
         #----<<b_deav002>>----
         #Ctrlp:construct.c.filter.page1.b_deav002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav002
            #add-point:ON ACTION controlp INFIELD b_deav002 name="construct.c.filter.page1.b_deav002"
            
            #END add-point
 
 
         #----<<b_deav002_desc>>----
         #----<<b_deav003>>----
         #Ctrlp:construct.c.filter.page1.b_deav003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav003
            #add-point:ON ACTION controlp INFIELD b_deav003 name="construct.c.filter.page1.b_deav003"
            
            #END add-point
 
 
         #----<<b_deav003_desc>>----
         #----<<b_deav004>>----
         #Ctrlp:construct.c.filter.page1.b_deav004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav004
            #add-point:ON ACTION controlp INFIELD b_deav004 name="construct.c.filter.page1.b_deav004"
            
            #END add-point
 
 
         #----<<b_deav004_desc>>----
         #----<<b_deav005>>----
         #Ctrlp:construct.c.filter.page1.b_deav005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav005
            #add-point:ON ACTION controlp INFIELD b_deav005 name="construct.c.filter.page1.b_deav005"
            
            #END add-point
 
 
         #----<<b_deav005_desc>>----
         #----<<b_deav006>>----
         #Ctrlp:construct.c.filter.page1.b_deav006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav006
            #add-point:ON ACTION controlp INFIELD b_deav006 name="construct.c.filter.page1.b_deav006"
            
            #END add-point
 
 
         #----<<b_deav007>>----
         #Ctrlp:construct.c.filter.page1.b_deav007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav007
            #add-point:ON ACTION controlp INFIELD b_deav007 name="construct.c.filter.page1.b_deav007"
            
            #END add-point
 
 
         #----<<b_deav008>>----
         #Ctrlp:construct.c.filter.page1.b_deav008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav008
            #add-point:ON ACTION controlp INFIELD b_deav008 name="construct.c.filter.page1.b_deav008"
            
            #END add-point
 
 
         #----<<b_deav009>>----
         #Ctrlp:construct.c.filter.page1.b_deav009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav009
            #add-point:ON ACTION controlp INFIELD b_deav009 name="construct.c.filter.page1.b_deav009"
            
            #END add-point
 
 
         #----<<b_deav010>>----
         #Ctrlp:construct.c.filter.page1.b_deav010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav010
            #add-point:ON ACTION controlp INFIELD b_deav010 name="construct.c.filter.page1.b_deav010"
            
            #END add-point
 
 
         #----<<b_deav012>>----
         #Ctrlp:construct.c.filter.page1.b_deav012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav012
            #add-point:ON ACTION controlp INFIELD b_deav012 name="construct.c.filter.page1.b_deav012"
            
            #END add-point
 
 
         #----<<b_deav011>>----
         #Ctrlp:construct.c.filter.page1.b_deav011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav011
            #add-point:ON ACTION controlp INFIELD b_deav011 name="construct.c.filter.page1.b_deav011"
            
            #END add-point
 
 
         #----<<b_deav013>>----
         #Ctrlp:construct.c.filter.page1.b_deav013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav013
            #add-point:ON ACTION controlp INFIELD b_deav013 name="construct.c.filter.page1.b_deav013"
            
            #END add-point
 
 
         #----<<b_deav014>>----
         #Ctrlp:construct.c.filter.page1.b_deav014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav014
            #add-point:ON ACTION controlp INFIELD b_deav014 name="construct.c.filter.page1.b_deav014"
            
            #END add-point
 
 
         #----<<b_deav015>>----
         #Ctrlp:construct.c.filter.page1.b_deav015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav015
            #add-point:ON ACTION controlp INFIELD b_deav015 name="construct.c.filter.page1.b_deav015"
            
            #END add-point
 
 
         #----<<b_deav016>>----
         #Ctrlp:construct.c.filter.page1.b_deav016
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_deav016
            #add-point:ON ACTION controlp INFIELD b_deav016 name="construct.c.filter.page1.b_deav016"
            
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
 
      CALL adeq407_filter_show('deavseq','b_deavseq')
   CALL adeq407_filter_show('deavsite','b_deavsite')
   CALL adeq407_filter_show('deavdocno','b_deavdocno')
   CALL adeq407_filter_show('deavdocdt','b_deavdocdt')
   CALL adeq407_filter_show('deav001','b_deav001')
   CALL adeq407_filter_show('deav002','b_deav002')
   CALL adeq407_filter_show('deav003','b_deav003')
   CALL adeq407_filter_show('deav004','b_deav004')
   CALL adeq407_filter_show('deav005','b_deav005')
   CALL adeq407_filter_show('deav006','b_deav006')
   CALL adeq407_filter_show('deav007','b_deav007')
   CALL adeq407_filter_show('deav008','b_deav008')
   CALL adeq407_filter_show('deav009','b_deav009')
   CALL adeq407_filter_show('deav010','b_deav010')
   CALL adeq407_filter_show('deav012','b_deav012')
   CALL adeq407_filter_show('deav011','b_deav011')
   CALL adeq407_filter_show('deav013','b_deav013')
   CALL adeq407_filter_show('deav014','b_deav014')
   CALL adeq407_filter_show('deav015','b_deav015')
   CALL adeq407_filter_show('deav016','b_deav016')
 
 
   CALL adeq407_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="adeq407.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION adeq407_filter_parser(ps_field)
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
 
{<section id="adeq407.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION adeq407_filter_show(ps_field,ps_object)
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
   LET ls_condition = adeq407_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="adeq407.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq407_detail_action_trans()
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
 
{<section id="adeq407.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq407_detail_index_setting()
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
            IF g_deav_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_deav_d.getLength() AND g_deav_d.getLength() > 0
            LET g_detail_idx = g_deav_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_deav_d.getLength() THEN
               LET g_detail_idx = g_deav_d.getLength()
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
 
{<section id="adeq407.mask_functions" >}
 &include "erp/ade/adeq407_mask.4gl"
 
{</section>}
 
{<section id="adeq407.other_function" readonly="Y" >}

 
{</section>}
 
