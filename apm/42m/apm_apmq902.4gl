#該程式未解開Section, 採用最新樣板產出!
{<section id="apmq902.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2015-07-14 18:39:17), PR版次:0001(2016-03-08 11:44:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000055
#+ Filename...: apmq902
#+ Description: 預約收貨調度查詢作業
#+ Creator....: 02159(2015-02-10 11:45:14)
#+ Modifier...: 02159 -SD/PR- 06814
 
{</section>}
 
{<section id="apmq902.global" >}
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
   pmel002 LIKE pmel_t.pmel002, 
   pmel003 LIKE pmel_t.pmel003, 
   pmel003_desc LIKE type_t.chr500, 
   l_pmel003_oocq009 LIKE type_t.chr500, 
   l_pmel003_oocq010 LIKE type_t.chr500, 
   l_def_time LIKE type_t.chr500, 
   pmel009 LIKE pmel_t.pmel009, 
   pmel009_desc LIKE type_t.chr500, 
   pmel006 LIKE pmel_t.pmel006, 
   pmel006_desc LIKE type_t.chr500, 
   pmeldocno LIKE pmel_t.pmeldocno, 
   pmelstus LIKE pmel_t.pmelstus, 
   pmel010 LIKE pmel_t.pmel010, 
   pmel001 LIKE pmel_t.pmel001
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 TYPE type_tm        RECORD
      l_sdate        LIKE pmel_t.pmel002,
      l_edate        LIKE pmel_t.pmel002,
      l_cnd1         LIKE type_t.chr1
                     END RECORD
DEFINE tm              type_tm
DEFINE g_pmel003_acc STRING
#預約時段
 TYPE type_g_pmel01_d RECORD
   l_pmel002      LIKE pmel_t.pmel002, 
   l_oocq002      LIKE oocq_t.oocq002, 
   l_oocq002_desc LIKE type_t.chr500,
   l_oocq009      LIKE oocq_t.oocq009, 
   l_oocq010      LIKE oocq_t.oocq010,
   l_def_time_1   LIKE type_t.chr500
   END RECORD
DEFINE g_pmel01_d  DYNAMIC ARRAY OF type_g_pmel01_d
#空餘碼頭
 TYPE type_g_pmel02_d RECORD
   l_pmelsite      LIKE pmel_t.pmelsite, 
   l_pmelsite_desc LIKE type_t.chr500,
   l_pmel009       LIKE pmel_t.pmel009, 
   l_pmel009_desc  LIKE type_t.chr500
   END RECORD
DEFINE g_pmel02_d   DYNAMIC ARRAY OF type_g_pmel02_d
DEFINE g_b2_wc      STRING #單身頁籤二所使用的條件
#end add-point
 
#模組變數(Module Variables)
DEFINE g_pmel_d            DYNAMIC ARRAY OF type_g_pmel_d
DEFINE g_pmel_d_t          type_g_pmel_d
 
 
 
 
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
 
{<section id="apmq902.main" >}
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
   CALL cl_ap_init("apm","")
 
   #add-point:作業初始化 name="main.init"
   #TEMP1:取區間日期
   CREATE TEMP TABLE apmq902_sedate(
      sedate         DATE     #條件所有日期
   )   
   #TEMP2:
   CREATE TEMP TABLE apmq902_pmel01(
      sedate         DATE,        #日期
      oocq002        VARCHAR(10),        #預約時段      
      oocq009        VARCHAR(40),        #預約時段起始時間
      oocq010        VARCHAR(40),        #預約時段結束時間      
      pmensite       VARCHAR(10),       #收貨組織
      pmen001        VARCHAR(10)     #碼頭編號
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
   DECLARE apmq902_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE apmq902_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE apmq902_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_apmq902 WITH FORM cl_ap_formpath("apm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL apmq902_init()   
 
      #進入選單 Menu (="N")
      CALL apmq902_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_apmq902
      
   END IF 
   
   CLOSE apmq902_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   DROP TABLE apmq902_sedate
   DROP TABLE apmq902_pmel01
   CALL s_aooi500_drop_temp() RETURNING l_success      #150308-00001#2  By sakura 150309   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="apmq902.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION apmq902_init()
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
      CALL cl_set_combo_scc_part('b_pmelstus','13','N,Y,A,D,R,W,X')
 
     
 
   #add-point:畫面資料初始化 name="init.init"
   INITIALIZE tm.* TO NULL
   LET tm.l_cnd1 = 'Y'
   LET g_pmel003_acc = '274'
   CALL s_aooi500_create_temp() RETURNING l_success    #150308-00001#2  By sakura 150309   
   #end add-point
 
   CALL apmq902_default_search()
END FUNCTION
 
{</section>}
 
{<section id="apmq902.default_search" >}
PRIVATE FUNCTION apmq902_default_search()
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
 
{<section id="apmq902.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION apmq902_ui_dialog() 
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
 
   
   CALL apmq902_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_pmel_d.clear()
 
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
 
         CALL apmq902_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME tm.l_sdate,tm.l_edate,tm.l_cnd1 ATTRIBUTE(WITHOUT DEFAULTS)
            AFTER INPUT
               IF INT_FLAG THEN
                  EXIT DIALOG
               END IF
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON ooef001
                                   
            ON ACTION controlp INFIELD ooef001 #營運組織
			      INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
			      LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'pmelsite',g_site,'c')   #150308-00001#4 150309 by lori522612			      
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO ooef001
               NEXT FIELD CURRENT
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_pmel_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL apmq902_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL apmq902_b_fill2()
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
         DISPLAY ARRAY g_pmel01_d TO s_detail2.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 1
               
             BEFORE ROW
                LET g_detail_idx = DIALOG.getCurrentRow("s_detail2")
                LET l_ac = g_detail_idx
                DISPLAY g_detail_idx TO FORMONLY.h_index
                DISPLAY g_pmel01_d.getLength() TO FORMONLY.h_count
                LET g_master_idx = l_ac
                #為避免按上下筆時影響執行效能，所以做一些處理
                LET lc_action_choice_old = g_action_choice
                LET g_action_choice = "fetch"
                CALL apmq902_b_fill4()
                LET g_action_choice = lc_action_choice_old                
               
         END DISPLAY
         DISPLAY ARRAY g_pmel02_d TO s_detail3.* ATTRIBUTE(COUNT=g_detail_cnt)
         
            BEFORE DISPLAY
               LET g_current_page = 1
               
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
                DISPLAY g_detail_idx2 TO FORMONLY.h_index
                DISPLAY g_pmel02_d.getLength() TO FORMONLY.h_count
                LET g_detail_idx2 = l_ac              
               
         END DISPLAY        
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL apmq902_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL cl_set_act_visible("selall,selnone,sel,unsel,insert,query", FALSE) 
            CALL cl_set_comp_visible("sel", FALSE)            
            LET tm.l_sdate = g_today
            LET tm.l_edate = g_today
            #end add-point
            NEXT FIELD ooef001
 
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
            CALL apmq902_b_fill()
 
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
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL apmq902_b_fill()
 
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
            CALL apmq902_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL apmq902_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL apmq902_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL apmq902_b_fill()
 
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
            CALL apmq902_filter()
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
 
{<section id="apmq902.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION apmq902_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where_aooi500_pmel   STRING
   DEFINE l_where_aooi500_pmen   STRING
   DEFINE l_where_date      STRING
   DEFINE l_where_cnd1      STRING
   DEFINE l_sql1            STRING
   DEFINE l_sql_tmp         STRING   #150826-00013# 20160308 add by beckxie
   DEFINE l_pmel011         LIKE pmel_t.pmel011
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL s_aooi500_sql_where(g_prog,'pmelsite') RETURNING l_where_aooi500_pmel
   
   #判斷是否為結案單據
   IF tm.l_cnd1 = 'Y' THEN
      LET l_where_cnd1 = " AND (pmelstus <> 'X' AND pmel011 is null)"
   ELSE
      LET l_where_cnd1 = " AND (pmelstus = 'Y' AND pmel011 is not null)"
   END IF
   #串日期
   LET l_where_date = "pmel002 BETWEEN TO_DATE('",tm.l_sdate CLIPPED,"','YYYY-MM-DD') ",
                      "            AND TO_DATE('",tm.l_edate CLIPPED,"','YYYY-MM-DD')"
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
   #儲存日期資料
   CALL apmq902_update_sedate()  
   #新增apmq902_pmel01
   CALL s_aooi500_sql_where('apmi900','pmensite') RETURNING l_where_aooi500_pmen
   DELETE FROM apmq902_pmel01
   LET l_sql1 = "INSERT INTO apmq902_pmel01 (sedate,oocq002,oocq009,oocq010,pmensite,pmen001)",
                " SELECT t1.sedate,t3.oocq002,t3.oocq009,t3.oocq010,t2.pmensite,t2.pmen001 ",
                "   FROM apmq902_sedate t1", 
                "    INNER JOIN pmen_t t2 ON 1=1 AND t2.pmenstus='Y' ",
                "    LEFT JOIN oocq_t t3 ON t2.pmenent = t3.oocqent AND t3.oocq001='274' AND t3.oocqstus='Y'",
                "  WHERE t2.pmenent = ",g_enterprise,
                "    AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = t2.pmensite AND ooefstus ='Y' AND ",ls_wc, ")",
			       "    AND ",l_where_aooi500_pmen	   
   PREPARE apmq902_temp2 FROM l_sql1
   EXECUTE apmq902_temp2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "Insert apmq902_temp2"
      LET g_errparam.popup = TRUE
      CALL cl_err()
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
   LET ls_sql_rank = "SELECT  UNIQUE '',pmelsite,'',pmel002,pmel003,'','','','',pmel009,'',pmel006,'', 
       pmeldocno,pmelstus,pmel010,pmel001  ,DENSE_RANK() OVER( ORDER BY pmel_t.pmeldocno) AS RANK FROM pmel_t", 
 
 
 
                     "",
                     " WHERE pmelent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmel_t"),
                     " ORDER BY pmel_t.pmeldocno"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #150826-00013#1 效能調整 20150911 add by beckxie---S
   #150302-00004#8 150312 by lori522612 add 效能調整---(S)
   LET ls_sql_rank = "SELECT  UNIQUE 'N', ",
                     "               pmelsite, ",
                     "               (SELECT ooefl003",
                     "                  FROM ooefl_t",
                     "                 WHERE ooeflent = pmelent AND ooefl001 = pmelsite ",
                     "                   AND ooefl002 = '",g_dlang,"') pmelsite_desc,",  #預約組織
                     "               pmel002,   pmel003,  ",
                     "               (SELECT oocql004",
                     "                  FROM oocql_t",
                     "                 WHERE oocqlent = pmelent AND oocql001 = '274'  ",
                     "                   AND oocql002 = pmel003 AND oocql003 = '",g_dlang,"') pmel003_desc,",
                     "               '',       '',          '',        pmel009,",
                     "               (SELECT pmenl003",
                     "                  FROM pmenl_t",
                     "                 WHERE pmenlent = pmelent AND pmenl001 = pmel009",
                     "                   AND pmenl002='",g_dlang,"') pmel009_desc,",       #碼頭名稱
                     "               pmel006,",
                     "               (SELECT pmaal004",
                     "                  FROM pmaal_t",
                     "                 WHERE pmaalent = pmelent AND pmaal001 = pmel006",
                     "                   AND pmaal002='",g_dlang,"') pmel006_desc,",
                     "               pmeldocno, pmelstus, pmel010,pmel001",
                     "               ,DENSE_RANK() OVER( ORDER BY pmel_t.pmeldocno) AS RANK ",
                     "   FROM pmel_t ",
                     " WHERE pmelent= ? AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = pmelsite AND ooefstus ='Y' AND ",ls_wc, ")",
                     " AND ",l_where_aooi500_pmel," AND ",l_where_date,l_where_cnd1
   #150302-00004#8 150312 by lori522612 add 效能調整---(E)
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("pmel_t"),
                     " ORDER BY pmel_t.pmeldocno"
   #150826-00013#1 效能調整 20150911 add by beckxie---E
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
 
   LET g_sql = "SELECT '',pmelsite,'',pmel002,pmel003,'','','','',pmel009,'',pmel006,'',pmeldocno,pmelstus, 
       pmel010,pmel001",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #150302-00004#8 150312 by lori522612 mark 效能調整---(S)
   #LET g_sql = "SELECT  UNIQUE 'N',pmelsite,t1.ooefl003,pmel002,pmel003,'','','','',pmel009,t2.pmenl003,pmel006,t3.pmaal004,pmeldocno, ",
   #            "        pmelstus,pmel010,pmel001 ",
   #            "   FROM pmel_t",
   #            "    LEFT OUTER JOIN ooefl_t t1 ON pmelent = t1.ooeflent AND pmelsite = t1.ooefl001 AND t1.ooefl002 = '",g_dlang,"' ",  #預約組織
   #            "    LEFT OUTER JOIN pmenl_t t2 ON pmelent = t2.pmenlent AND pmel009 = t2.pmenl001 AND pmenl002='",g_dlang,"' ",       #碼頭名稱
   #            "    LEFT OUTER JOIN pmaal_t t3 ON pmelent = t3.pmaalent AND pmel006 = t3.pmaal001 AND pmaal002='",g_dlang,"' ",
   #            " WHERE pmelent= ? AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = pmelsite AND ooefstus ='Y' AND ",ls_wc, ")",
   #            " AND ",l_where_aooi500_pmel," AND ",l_where_date,l_where_cnd1
   #150302-00004#8 150312 by lori522612 mark 效能調整---(E)
   
   #150826-00013#1 效能調整 20150911 mark by beckxie---S
   ##150302-00004#8 150312 by lori522612 add 效能調整---(S)
   #LET g_sql = "SELECT  UNIQUE 'N', ",
   #            "               pmelsite, t1.ooefl003, pmel002,   pmel003,  t4.oocql004, ",
   #            "               '',       '',          '',        pmel009,  t2.pmenl003, ",
   #            "               pmel006, t3.pmaal004,  pmeldocno, pmelstus, pmel010,",
   #            "               pmel001 ",
   #            "   FROM pmel_t ",
   #            "        LEFT JOIN ooefl_t t1 ON t1.ooeflent = pmelent AND t1.ooefl001 = pmelsite AND t1.ooefl002 = '",g_dlang,"' ",  #預約組織
   #            "        LEFT JOIN pmenl_t t2 ON t2.pmenlent = pmelent AND t2.pmenl001 = pmel009  AND pmenl002='",g_dlang,"' ",       #碼頭名稱
   #            "        LEFT JOIN pmaal_t t3 ON t3.pmaalent = pmelent AND t3.pmaal001 = pmel006  AND pmaal002='",g_dlang,"' ",
   #            "        LEFT JOIN oocql_t t4 ON t4.oocqlent = pmelent AND t4.oocql001 = '274'   AND t4.oocql002 = pmel003 AND t4.oocql003 = '",g_dlang,"' ",
   #            " WHERE pmelent= ? AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = pmelsite AND ooefstus ='Y' AND ",ls_wc, ")",
   #            " AND ",l_where_aooi500_pmel," AND ",l_where_date,l_where_cnd1
   ##150302-00004#8 150312 by lori522612 add 效能調整---(E)
   #150826-00013#1 效能調整 20150911 mark by beckxie---E
   
   #150826-00013#1 效能調整 20150911 add by beckxie---S
   LET g_sql = "SELECT     '',pmelsite,pmelsite_desc,  pmel002,pmel003,",
               " pmel003_desc,      '',           '',       '',pmel009,",
               " pmel009_desc, pmel006, pmel006_desc,pmeldocno,pmelstus,",
               "      pmel010,pmel001",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
   #150826-00013#1 效能調整 20150911 add by beckxie---E
         #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmel_d[l_ac].pmel003
      #LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_pmel_d[l_ac].pmel003_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmel_d[l_ac].pmel003_desc
   #150826-00013#1 效能調整 20150911 mark by beckxie---S
   #LET g_sql = g_sql, cl_sql_add_filter("pmel_t"),
   #                   " ORDER BY pmel_t.pmeldocno"
   #150826-00013#1 效能調整 20150911 mark by beckxie---E
   LET g_b2_wc = ls_wc
   
   
   LET l_sql_tmp = "SELECT pmel011 FROM pmel_t WHERE pmelent = ",g_enterprise," AND pmeldocno = ? "
   PREPARE sel_pmel011_pre FROM l_sql_tmp
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE apmq902_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR apmq902_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_pmel_d[l_ac].sel,g_pmel_d[l_ac].pmelsite,g_pmel_d[l_ac].pmelsite_desc, 
       g_pmel_d[l_ac].pmel002,g_pmel_d[l_ac].pmel003,g_pmel_d[l_ac].pmel003_desc,g_pmel_d[l_ac].l_pmel003_oocq009, 
       g_pmel_d[l_ac].l_pmel003_oocq010,g_pmel_d[l_ac].l_def_time,g_pmel_d[l_ac].pmel009,g_pmel_d[l_ac].pmel009_desc, 
       g_pmel_d[l_ac].pmel006,g_pmel_d[l_ac].pmel006_desc,g_pmel_d[l_ac].pmeldocno,g_pmel_d[l_ac].pmelstus, 
       g_pmel_d[l_ac].pmel010,g_pmel_d[l_ac].pmel001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      CALL apmq902_pmel003_ref()
      #150826-00013# 20160308 mark by beckxie---S
      #SELECT pmel011 INTO l_pmel011 FROM pmel_t WHERE pmelent = g_enterprise AND pmeldocno = g_pmel_d[l_ac].pmeldocno  
      #150826-00013# 20160308 mark by beckxie---E
      #150826-00013# 20160308 add by beckxie---S
      EXECUTE sel_pmel011_pre USING g_pmel_d[l_ac].pmeldocno INTO l_pmel011
      #150826-00013# 20160308 add by beckxie---E
      CASE
         WHEN (g_pmel_d[l_ac].pmelstus <> 'X' AND l_pmel011 IS NULL )
           LET g_pmel_d[l_ac].pmelstus = 'N'      
         WHEN (g_pmel_d[l_ac].pmelstus = 'Y' AND l_pmel011 IS NOT NULL )
           LET g_pmel_d[l_ac].pmelstus = 'Y'           
      END CASE
      #end add-point
 
      CALL apmq902_detail_show("'1'")
 
      CALL apmq902_pmel_t_mask()
 
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
   CALL apmq902_b_fill3()
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
   FREE apmq902_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL apmq902_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL apmq902_detail_action_trans()
 
   LET l_ac = 1
   IF g_pmel_d.getLength() > 0 THEN
      CALL apmq902_b_fill2()
   END IF
 
      CALL apmq902_filter_show('pmelsite','b_pmelsite')
   CALL apmq902_filter_show('pmel002','b_pmel002')
   CALL apmq902_filter_show('pmel003','b_pmel003')
   CALL apmq902_filter_show('pmel009','b_pmel009')
   CALL apmq902_filter_show('pmel006','b_pmel006')
   CALL apmq902_filter_show('pmeldocno','b_pmeldocno')
   CALL apmq902_filter_show('pmelstus','b_pmelstus')
   CALL apmq902_filter_show('pmel010','b_pmel010')
   CALL apmq902_filter_show('pmel001','b_pmel001')
 
 
END FUNCTION
 
{</section>}
 
{<section id="apmq902.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION apmq902_b_fill2()
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
 
{<section id="apmq902.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION apmq902_detail_show(ps_page)
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
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"
      #150302-00004#8 150312 by lori522612 mark---(S)  
      #INITIALIZE g_ref_fields TO NULL
      #LET g_ref_fields[1] = g_pmel_d[l_ac].pmel003
      #LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='274' AND oocql002=? AND oocql003='"||g_dlang||"'"
      #LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
      #CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
      #LET g_pmel_d[l_ac].pmel003_desc = '', g_rtn_fields[1] , ''
      #DISPLAY BY NAME g_pmel_d[l_ac].pmel003_desc
      #150302-00004#8 150312 by lori522612 mark---(E)  
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="apmq902.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION apmq902_filter()
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
      CONSTRUCT g_wc_filter ON pmelsite,pmel002,pmel003,pmel009,pmel006,pmeldocno,pmelstus,pmel010,pmel001 
 
                          FROM s_detail1[1].b_pmelsite,s_detail1[1].b_pmel002,s_detail1[1].b_pmel003, 
                              s_detail1[1].b_pmel009,s_detail1[1].b_pmel006,s_detail1[1].b_pmeldocno, 
                              s_detail1[1].b_pmelstus,s_detail1[1].b_pmel010,s_detail1[1].b_pmel001
 
         BEFORE CONSTRUCT
                     DISPLAY apmq902_filter_parser('pmelsite') TO s_detail1[1].b_pmelsite
            DISPLAY apmq902_filter_parser('pmel002') TO s_detail1[1].b_pmel002
            DISPLAY apmq902_filter_parser('pmel003') TO s_detail1[1].b_pmel003
            DISPLAY apmq902_filter_parser('pmel009') TO s_detail1[1].b_pmel009
            DISPLAY apmq902_filter_parser('pmel006') TO s_detail1[1].b_pmel006
            DISPLAY apmq902_filter_parser('pmeldocno') TO s_detail1[1].b_pmeldocno
            DISPLAY apmq902_filter_parser('pmelstus') TO s_detail1[1].b_pmelstus
            DISPLAY apmq902_filter_parser('pmel010') TO s_detail1[1].b_pmel010
            DISPLAY apmq902_filter_parser('pmel001') TO s_detail1[1].b_pmel001
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_pmelsite>>----
         #Ctrlp:construct.c.filter.page1.b_pmelsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmelsite
            #add-point:ON ACTION controlp INFIELD b_pmelsite name="construct.c.filter.page1.b_pmelsite"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmelsite  #顯示到畫面上
            NEXT FIELD b_pmelsite                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmelsite_desc>>----
         #----<<b_pmel002>>----
         #Ctrlp:construct.c.filter.page1.b_pmel002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel002
            #add-point:ON ACTION controlp INFIELD b_pmel002 name="construct.c.filter.page1.b_pmel002"
            
            #END add-point
 
 
         #----<<b_pmel003>>----
         #Ctrlp:construct.c.filter.page1.b_pmel003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel003
            #add-point:ON ACTION controlp INFIELD b_pmel003 name="construct.c.filter.page1.b_pmel003"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmel003  #顯示到畫面上
            NEXT FIELD b_pmel003                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmel003_desc>>----
         #----<<l_pmel003_oocq009>>----
         #----<<l_pmel003_oocq010>>----
         #----<<l_def_time>>----
         #----<<b_pmel009>>----
         #Ctrlp:construct.c.filter.page1.b_pmel009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel009
            #add-point:ON ACTION controlp INFIELD b_pmel009 name="construct.c.filter.page1.b_pmel009"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmen001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmel009  #顯示到畫面上
            NEXT FIELD b_pmel009                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmel009_desc>>----
         #----<<b_pmel006>>----
         #Ctrlp:construct.c.filter.page1.b_pmel006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel006
            #add-point:ON ACTION controlp INFIELD b_pmel006 name="construct.c.filter.page1.b_pmel006"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmel006  #顯示到畫面上
            NEXT FIELD b_pmel006                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmel006_desc>>----
         #----<<b_pmeldocno>>----
         #Ctrlp:construct.c.filter.page1.b_pmeldocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmeldocno
            #add-point:ON ACTION controlp INFIELD b_pmeldocno name="construct.c.filter.page1.b_pmeldocno"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmeldocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmeldocno  #顯示到畫面上
            NEXT FIELD b_pmeldocno                     #返回原欄位
    


            #END add-point
 
 
         #----<<b_pmelstus>>----
         #Ctrlp:construct.c.filter.page1.b_pmelstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmelstus
            #add-point:ON ACTION controlp INFIELD b_pmelstus name="construct.c.filter.page1.b_pmelstus"
            
            #END add-point
 
 
         #----<<b_pmel010>>----
         #Ctrlp:construct.c.filter.page1.b_pmel010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel010
            #add-point:ON ACTION controlp INFIELD b_pmel010 name="construct.c.filter.page1.b_pmel010"
            
            #END add-point
 
 
         #----<<b_pmel001>>----
         #Ctrlp:construct.c.filter.page1.b_pmel001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_pmel001
            #add-point:ON ACTION controlp INFIELD b_pmel001 name="construct.c.filter.page1.b_pmel001"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmdldocno_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_pmel001  #顯示到畫面上
            NEXT FIELD b_pmel001                     #返回原欄位
    


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
 
      CALL apmq902_filter_show('pmelsite','b_pmelsite')
   CALL apmq902_filter_show('pmel002','b_pmel002')
   CALL apmq902_filter_show('pmel003','b_pmel003')
   CALL apmq902_filter_show('pmel009','b_pmel009')
   CALL apmq902_filter_show('pmel006','b_pmel006')
   CALL apmq902_filter_show('pmeldocno','b_pmeldocno')
   CALL apmq902_filter_show('pmelstus','b_pmelstus')
   CALL apmq902_filter_show('pmel010','b_pmel010')
   CALL apmq902_filter_show('pmel001','b_pmel001')
 
 
   CALL apmq902_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="apmq902.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION apmq902_filter_parser(ps_field)
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
 
{<section id="apmq902.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION apmq902_filter_show(ps_field,ps_object)
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
   LET ls_condition = apmq902_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="apmq902.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION apmq902_detail_action_trans()
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
 
{<section id="apmq902.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION apmq902_detail_index_setting()
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
 
{<section id="apmq902.mask_functions" >}
 &include "erp/apm/apmq902_mask.4gl"
 
{</section>}
 
{<section id="apmq902.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 預計到貨時段帶值內容顯示
# Memo...........:
# Usage..........: CALL apmq902_pmel003_ref()
# Date & Author..: 2015/2/10 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq902_pmel003_ref()
   IF NOT cl_null(g_pmel_d[l_ac].pmel003) THEN
      #150826-00013# 20160308 mark by beckxie---S
      #LET g_pmel_d[l_ac].pmel003_desc = s_desc_get_acc_desc(g_pmel003_acc,g_pmel_d[l_ac].pmel003)
      #150826-00013# 20160308 mark by beckxie---E
      CALL s_apmt859_get_pmel003_info(g_pmel_d[l_ac].pmel003) RETURNING g_pmel_d[l_ac].l_pmel003_oocq009,g_pmel_d[l_ac].l_pmel003_oocq010

      LET g_pmel_d[l_ac].l_def_time = s_apmt859_pmel003_ref(g_pmel_d[l_ac].pmel003_desc,g_pmel_d[l_ac].l_pmel003_oocq009,g_pmel_d[l_ac].l_pmel003_oocq010)
      DISPLAY BY NAME g_pmel_d[l_ac].l_def_time
   END IF
END FUNCTION

################################################################################
# Descriptions...: 儲存預約日期
# Memo...........:
# Usage..........: CALL apmq902_update_sedate()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 2015/02/13 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq902_update_sedate()
   DEFINE l_date   LIKE pmel_t.pmel002
   DEFINE l_sql    STRING
   
   DELETE FROM apmq902_sedate
   LET l_date = tm.l_sdate
   
   WHILE l_date <= tm.l_edate
        LET l_sql = "INSERT INTO apmq902_sedate VALUES('",l_date,"')"
        PREPARE apmq902_ins_date FROM l_sql
        EXECUTE apmq902_ins_date
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = "Insert apmq902_sedate"
           LET g_errparam.popup = TRUE
           CALL cl_err()
           EXIT WHILE
        END IF
        LET l_date = l_date +1   
   END WHILE
   
END FUNCTION

################################################################################
# Descriptions...: 預計到貨時段帶值內容顯示
# Memo...........:
# Usage..........: CALL apmq902_oocq002_ref()
# Date & Author..: 2015/2/10 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq902_oocq002_ref()
   IF NOT cl_null(g_pmel01_d[l_ac].l_oocq002) THEN
      #150826-00013# 20160308 mark by beckxie---S
      #LET g_pmel01_d[l_ac].l_oocq002_desc = s_desc_get_acc_desc(g_pmel003_acc,g_pmel01_d[l_ac].l_oocq002)
      #150826-00013# 20160308 mark by beckxie---E
      CALL s_apmt859_get_pmel003_info(g_pmel01_d[l_ac].l_oocq002) RETURNING g_pmel01_d[l_ac].l_oocq009,g_pmel01_d[l_ac].l_oocq010

      LET g_pmel01_d[l_ac].l_def_time_1 = s_apmt859_pmel003_ref(g_pmel01_d[l_ac].l_oocq002_desc,g_pmel01_d[l_ac].l_oocq009,g_pmel01_d[l_ac].l_oocq010)
      DISPLAY BY NAME g_pmel01_d[l_ac].l_def_time_1
   END IF
END FUNCTION

################################################################################
# Descriptions...: 單身預約資料
# Memo...........:
# Usage..........: CALL apmq902_b_fill3()
# Input parameter:
# Return code....: 
# Date & Author..: 2015/02/10 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq902_b_fill3()
   DEFINE l_sql           STRING
 
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   CALL g_pmel01_d.clear()

   LET l_ac = 1

   #150826-00013# 20160308 mark by beckxie---S
   #LET l_sql = "SELECT DISTINCT sedate,oocq002,'',oocq009,oocq010,'' ",
   #            " FROM apmq902_pmel01 ",
   #            " ORDER BY sedate,oocq002"
   #150826-00013# 20160308 mark by beckxie---E
   #150826-00013# 20160308 add by beckxie---S
   LET l_sql = "SELECT DISTINCT t1.sedate,t1.oocq002,",
               "               (SELECT t2.oocql004 ",
               "                  FROM oocql_t t2",
               "                 WHERE t2.oocqlent = ",g_enterprise," AND t2.oocql001 = '274'  ",
               "                   AND t2.oocql002 = t1.oocq002 AND t2.oocql003 = '",g_dlang,"'),",
               "               t1.oocq009,t1.oocq010,'' ",
               " FROM apmq902_pmel01 t1",
               " ORDER BY t1.sedate,t1.oocq002"
   #150826-00013# 20160308 add by beckxie---E
   PREPARE apmq902_pb1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR apmq902_pb1
   OPEN b_fill_curs1
 
   FOREACH b_fill_curs1 INTO g_pmel01_d[l_ac].l_pmel002,g_pmel01_d[l_ac].l_oocq002,g_pmel01_d[l_ac].l_oocq002_desc,
                              g_pmel01_d[l_ac].l_oocq009,g_pmel01_d[l_ac].l_oocq010,g_pmel01_d[l_ac].l_def_time_1
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      #資料填充
      CALL apmq902_oocq002_ref()
 
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
 
   CALL g_pmel01_d.deleteElement(g_pmel01_d.getLength())
   DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET g_detail_idx = 1
   DISPLAY g_detail_idx TO FORMONLY.h_index
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs1
   FREE apmq902_pb1

   LET l_ac = 1
   CALL apmq902_b_fill4()
END FUNCTION

################################################################################
# Descriptions...: 單身碼頭資料
# Memo...........:
# Usage..........: CALL apmq902_b_fill4()
# Input parameter:
# Return code....: 
# Date & Author..: 2015/02/10 By sakura
# Modify.........:
################################################################################
PRIVATE FUNCTION apmq902_b_fill4()
   DEFINE li_ac           LIKE type_t.num5
   DEFINE l_sql           STRING
 
   LET li_ac = l_ac
   
   CALL g_pmel02_d.clear()
   
   LET l_sql = ''
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      #150826-00013# 20160308 mark by beckxie---S
      #LET l_sql = " SELECT t1.pmensite,t2.ooefl003,t1.pmen001,t3.pmenl003 ",
	   #            "   FROM apmq902_pmel01 t1 ",
      #            "    LEFT OUTER JOIN ooefl_t t2 ON ",g_enterprise," = t2.ooeflent AND t1.pmensite = t2.ooefl001 AND t2.ooefl002 = '",g_dlang,"' ",  #預約組織	              
      #            "    LEFT OUTER JOIN pmenl_t t3 ON ",g_enterprise," = t3.pmenlent AND t1.pmen001 = t3.pmenl001 AND t3.pmenl002='",g_dlang,"' ",     #碼頭名稱			  
      #            "    WHERE NOT EXISTS (SELECT 1 FROM pmel_t t4 ",
      #            "                       WHERE t4.pmelent = ",g_enterprise,
      #            "                         AND t4.pmelsite = t1.pmensite ",
      #            "                         AND t4.pmel009 = t1.pmen001 ",
      #            "                         AND t4.pmel002 = t1.sedate ",
      #            "                         AND t4.pmel003 = t1.oocq002)",                  
      #            "    AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = t1.pmensite AND ooefstus ='Y' AND ",g_b2_wc,")",                  
		#		      "    AND t1.sedate = ? AND t1.oocq002 = ? ",
		#		      "    ORDER BY t1.pmensite,t1.pmen001 "		
      #150826-00013# 20160308 mark by beckxie---E
      #150826-00013# 20160308 add by beckxie---S
      LET l_sql = " SELECT t1.pmensite,",
                  "        (SELECT t2.ooefl003 ",
                  "           FROM ooefl_t t2",
                  "          WHERE ",g_enterprise," = t2.ooeflent AND t1.pmensite = t2.ooefl001 AND t2.ooefl002 = '",g_dlang,"'), ",  #預約組織	              
                  "        t1.pmen001,",
                  "        (SELECT t3.pmenl003 ",
                  "           FROM pmenl_t t3 ",
                  "          WHERE ",g_enterprise," = t3.pmenlent AND t1.pmen001 = t3.pmenl001 AND t3.pmenl002='",g_dlang,"') ",     #碼頭名稱			  
	               "   FROM apmq902_pmel01 t1 ",
                  "    WHERE NOT EXISTS (SELECT 1 FROM pmel_t t4 ",
                  "                       WHERE t4.pmelent = ",g_enterprise,
                  "                         AND t4.pmelsite = t1.pmensite ",
                  "                         AND t4.pmel009 = t1.pmen001 ",
                  "                         AND t4.pmel002 = t1.sedate ",
                  "                         AND t4.pmel003 = t1.oocq002)",                  
                  "    AND EXISTS (SELECT ooef001 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = t1.pmensite AND ooefstus ='Y' AND ",g_b2_wc,")",                  
				      "    AND t1.sedate = ? AND t1.oocq002 = ? ",
				      "    ORDER BY t1.pmensite,t1.pmen001 "		
      #150826-00013# 20160308 add by beckxie---E
      PREPARE apmq902_pb2 FROM l_sql
      DECLARE b_fill_curs2 CURSOR FOR apmq902_pb2
   END IF
 
   OPEN b_fill_curs2 USING g_pmel01_d[g_detail_idx].l_pmel002,g_pmel01_d[g_detail_idx].l_oocq002
 
   LET l_ac = 1
   FOREACH b_fill_curs2 INTO g_pmel02_d[l_ac].l_pmelsite,g_pmel02_d[l_ac].l_pmelsite_desc,
                              g_pmel02_d[l_ac].l_pmel009,g_pmel02_d[l_ac].l_pmel009_desc


      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
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
 
   CALL g_pmel02_d.deleteElement(g_pmel02_d.getLength())
 
   LET li_ac = g_pmel02_d.getLength()
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx   
   
   CLOSE b_fill_curs2
   FREE apmq902_pb2
   
   LET l_ac = li_ac
   
END FUNCTION

 
{</section>}
 
