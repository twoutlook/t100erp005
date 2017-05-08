#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq163.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2017-01-06 17:32:05), PR版次:0001(2017-01-06 17:32:38)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000001
#+ Filename...: axcq163
#+ Description: 工單製程計算順序資料查詢
#+ Creator....: 05423(2016-12-01 15:27:34)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="axcq163.global" >}
#應用 q04 樣板自動產生(Version:32)
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
 
#單頭 type 宣告
PRIVATE type type_g_master        RECORD
       xcbtcomp LIKE type_t.chr10, 
   xcbtcomp_desc LIKE type_t.chr80, 
   xcbt001 LIKE type_t.num5, 
   xcbt002 LIKE type_t.num5, 
   xcbt003 LIKE type_t.chr100, 
   xcbt003_desc LIKE type_t.chr80, 
   sfaadocdt LIKE type_t.dat, 
   imag014 LIKE type_t.chr10, 
   imag014_desc LIKE type_t.chr80, 
   sfaa010 LIKE type_t.chr500, 
   imaal003 LIKE type_t.chr500, 
   imaal004 LIKE type_t.chr500, 
   sfaa011 LIKE type_t.chr30, 
   sfaa011_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   xcbt008 LIKE xcbt_t.xcbt008, 
   xcbt004 LIKE xcbt_t.xcbt004, 
   xcbt004_desc LIKE type_t.chr500, 
   xcbt005 LIKE xcbt_t.xcbt005, 
   xcbt006 LIKE xcbt_t.xcbt006, 
   xcbt006_desc LIKE type_t.chr500, 
   xcbt007 LIKE xcbt_t.xcbt007, 
   xcbt009 LIKE xcbt_t.xcbt009, 
   xcbt010 LIKE xcbt_t.xcbt010, 
   xcbt011 LIKE xcbt_t.xcbt011, 
   xcbt012 LIKE xcbt_t.xcbt012, 
   xcbt013 LIKE xcbt_t.xcbt013
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_wc_cs_comp          STRING
DEFINE g_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期
DEFINE g_edate      LIKE glav_t.glav004
DEFINE g_glaa003    LIKE glaa_t.glaa003
TYPE type_g_browser   RECORD
                xcbtcomp LIKE xcbt_t.xcbtcomp,
                xcbt001 LIKE xcbt_t.xcbt001,                  
                xcbt002 LIKE xcbt_t.xcbt002,
                xcbt003 LIKE xcbt_t.xcbt003
              END RECORD
 
DEFINE g_browser            DYNAMIC ARRAY OF type_g_browser
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_cnt_sql             STRING                        #組 sql 用 
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
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_msg                 STRING
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_row_count           LIKE type_t.num10
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
DEFINE g_master_row_move     LIKE type_t.chr1              #是否為單頭筆數更動
 
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
 
{<section id="axcq163.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
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
   DECLARE axcq163_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq163_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq163_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq163 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq163_init()   
 
      #進入選單 Menu (="N")
      CALL axcq163_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq163
      
   END IF 
   
   CLOSE axcq163_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq163.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq163_init()
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
   LET g_master_row_move = "Y"
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   INITIALIZE g_master.* TO NULL
   #end add-point
 
   CALL axcq163_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq163.default_search" >}
PRIVATE FUNCTION axcq163_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   
 
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
 
{<section id="axcq163.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq163_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old    STRING
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003
   #end add-point
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CLEAR FORM  
 
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
   LET g_master_row_move = "Y"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
       LET g_detail_idx = 1
       CALL axcq163_browser_fill()
    ELSE
       CALL axcq163_query()
       CALL axcq163_browser_fill()
       CALL axcq163_fetch("")
    END IF
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq163_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_master_row_move = "Y"
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axcq163_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
 
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
 
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq163_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq163_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq163_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            {NEXT FIELD xcbtcomp
            #end add-point
            NEXT FIELD xcbtent
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
}
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
            CALL axcq163_browser_fill()
            #end add-point
 
            CALL axcq163_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
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
 
         ON ACTION datainfo   #串查至主維護程式
            #add-point:ON ACTION datainfo name="ui_dialog.datainfo"
            
            #end add-point
            CALL axcq163_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq163_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq163_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq163_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq163_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq163_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               CLEAR FORM
               CALL axcq163_query()
               IF INT_FLAG THEN
                   #取消查詢
                   LET INT_FLAG = 0
                   CALL axcq163_browser_fill()
                   CALL axcq163_fetch("")
                END IF
                
               #儲存WC資訊
               CALL cl_dlg_save_user_latestqry("("||g_wc||") AND ("||g_wc2||")")
               
               #搜尋後資料初始化 
               LET g_detail_cnt  = 0
               LET g_current_idx = 1
               LET g_current_row = 0
               LET g_detail_idx  = 1
             
               LET g_error_show  = 1
               LET g_wc_filter   = ""
               LET l_ac = 1
               CALL axcq163_browser_fill()
                     
               IF g_browser.getLength() = 0 THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "-100" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               ELSE
                  CALL axcq163_fetch("F") 
               END IF
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
 
{<section id="axcq163.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq163_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   
   #end add-point
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   IF g_wc2 = " 1=1" THEN
      #add-point:cs段單頭sql組成(未下單身條件) name="cs.sql_define_1"
      RETURN   
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      RETURN
      #end add-point
   END IF
 
   PREPARE axcq163_pre FROM g_sql
   DECLARE axcq163_curs SCROLL CURSOR WITH HOLD FOR axcq163_pre
   OPEN axcq163_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE axcq163_precount FROM g_cnt_sql
   EXECUTE axcq163_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq163_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq163.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq163_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   LET g_sql = " SELECT DISTINCT xcbtcomp,xcbt001,xcbt002,xcbt003,sfaadocdt,imag014,sfaa010,sfaa011 ",
               "   FROM xcbt_t LEFT OUTER JOIN sfaa_t ON sfaadocno = xcbt003 AND sfaaent = xcbtent AND sfaasite = xcbtsite ",
               "               LEFT OUTER JOIN imag_t ON imag001 = sfaa010 AND imagsite = xcbtcomp AND imagent = xcbtent ",
               "  WHERE ",g_wc2,
               "    AND xcbtent = ",g_enterprise,
               "    AND xcbtcomp = ? ",
               "    AND xcbt001 = ? AND xcbt002 = ? AND xcbt003 = ? ",               
               "  ORDER BY xcbtcomp,xcbt001,xcbt002 " 
   PREPARE axcq163_fetch_pre FROM g_sql  
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
 
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO xcbtcomp,xcbtcomp_desc,xcbt001,xcbt002,xcbt003,xcbt003_desc,sfaadocdt,imag014, 
          imag014_desc,sfaa010,imaal003,imaal004,sfaa011,sfaa011_desc
      CALL g_detail.clear()
 
      #add-point:陣列清空 name="fetch.array_clear"
      
      #end add-point
      DISPLAY '' TO FORMONLY.h_index
      DISPLAY '' TO FORMONLY.h_count
      DISPLAY '' TO FORMONLY.idx
      DISPLAY '' TO FORMONLY.cnt
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = '-100' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
 
      RETURN
   ELSE
      CASE p_flag
         WHEN 'F' LET g_current_idx = 1
         WHEN 'P' LET g_current_idx = g_current_idx - 1
         WHEN 'N' LET g_current_idx = g_current_idx + 1
         WHEN 'L' LET g_current_idx = g_row_count
         WHEN '/' LET g_current_idx = g_jump
      END CASE
      DISPLAY g_current_idx TO FORMONLY.h_index
      DISPLAY g_row_count TO FORMONLY.h_count
      CALL cl_navigator_setting( g_current_idx, g_row_count )
   END IF
 
   #add-point:fetch結束前 name="fetch.after"
   #代表沒有資料
   IF g_current_idx = 0 OR g_browser.getLength() = 0 THEN
      RETURN
   END IF
   
   #超出範圍
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   #重讀DB,因TEMP有不被更新特性
   EXECUTE axcq163_fetch_pre USING g_browser[g_current_idx].xcbtcomp,g_browser[g_current_idx].xcbt001,g_browser[g_current_idx].xcbt002,
                                   g_browser[g_current_idx].xcbt003
      INTO g_master.xcbtcomp,g_master.xcbt001,g_master.xcbt002,g_master.xcbt003,g_master.sfaadocdt,g_master.imag014,
           g_master.sfaa010,g_master.sfaa011 
   FREE axcq163_fetch_pre
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "xccc_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      INITIALIZE g_master.* TO NULL
      RETURN
   END IF      
   CALL s_aooi200_get_slip_desc(g_master.xcbt003) RETURNING g_master.xcbt003_desc   
   DISPLAY BY NAME g_master.xcbtcomp,g_master.xcbt001,g_master.xcbt002,g_master.xcbt003,g_master.sfaadocdt,g_master.imag014,
           g_master.sfaa010,g_master.sfaa011 
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axcq163_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.show" >}
PRIVATE FUNCTION axcq163_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xcbtcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xcbtcomp_desc = '', g_rtn_fields[1] , ''  
   
   CALL s_aooi200_get_slip_desc(g_master.xcbt003) RETURNING g_master.xcbt003_desc
   DISPLAY BY NAME g_master.xcbt003_desc  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.imag014
   CALL ap_ref_array2(g_ref_fields,"SELECT oocal003 FROM oocal_t WHERE oocalent='"||g_enterprise||"' AND oocal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.imag014_desc = '', g_rtn_fields[1] , ''  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.sfaa010
   CALL ap_ref_array2(g_ref_fields,"SELECT imaal003,imaal004 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.imaal003 = '', g_rtn_fields[1] , ''  
   LET g_master.imaal004 = '', g_rtn_fields[2] , ''  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.sfaa010
   LET g_ref_fields[2] = g_master.sfaa011
   CALL ap_ref_array2(g_ref_fields,"SELECT inaml004 FROM inaml_t WHERE inamlent='"||g_enterprise||"' AND inaml001=? AND inaml002 = ? AND inaml003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.sfaa011_desc = '', g_rtn_fields[1] , ''  
   #end add-point
 
   DISPLAY g_master.* TO xcbtcomp,xcbtcomp_desc,xcbt001,xcbt002,xcbt003,xcbt003_desc,sfaadocdt,imag014, 
       imag014_desc,sfaa010,imaal003,imaal004,sfaa011,sfaa011_desc
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq163_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq163_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET g_sql = " SELECT 'N',xcbt008,xcbt004,",
               "        (SELECT oocql004 FROM oocql_t WHERE oocql001 = '221' AND oocql002 = xcbt004 AND oocql003 = '",g_dlang,"' AND oocqlent = xcbtent) t1_oocql004,",
               "        xcbt005,xcbt006,",
               "        (SELECT oocql004 FROM oocql_t WHERE oocql001 = '221' AND oocql002 = xcbt006 AND oocql003 = '",g_dlang,"' AND oocqlent = xcbtent) t2_oocql004,",
               "        xcbt007,xcbt009,xcbt010,xcbt011,xcbt012,xcbt013 ",
               "   FROM xcbt_t LEFT OUTER JOIN sfaa_t ON sfaadocno = xcbt003 AND sfaaent = xcbtent AND sfaasite = xcbtsite ",
               "               LEFT OUTER JOIN imag_t ON imag001 = sfaa010 AND imagsite = xcbtcomp AND imagent = xcbtent ",
               "  WHERE ",g_wc2,
               "    AND xcbtent = ",g_enterprise,
               "    AND xcbtcomp = '",g_master.xcbtcomp,"' ",
               "    AND xcbt001 = '",g_master.xcbt001,"' ",
               "    AND xcbt002 = '",g_master.xcbt002,"' ",
               "    AND xcbt003 = '",g_master.xcbt003,"' ",
               "  ORDER BY xcbt008 "
   PREPARE axcq163_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq163_pb            
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   FOREACH b_fill_curs INTO g_detail[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq163_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq163_detail_action_trans()
 
   CALL axcq163_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq163_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq163_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].xcbt004
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].xcbt004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].xcbt004_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].xcbt006
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].xcbt006_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].xcbt006_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq163_maintain_prog()
   #add-point:maintain_prog段define-客製 name="maintain_prog.define_customerization"
   
   #end add-point
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   DEFINE ls_j       LIKE type_t.num5
   #add-point:maintain_prog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="maintain_prog.define"
   
   #end add-point
 
 
   #add-point:maintain_prog段開始前 name="maintain_prog.before"
   
   #end add-point
 
   LET la_param.prog = ""
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="axcq163.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq163_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   LET g_tot_cnt = g_detail_cnt
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.idx
   DISPLAY g_tot_cnt TO FORMONLY.cnt
 
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
 
{<section id="axcq163.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq163_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_master_row_move = "Y" THEN
      LET g_detail_idx = 1
      LET li_redirect = TRUE
   ELSE
      IF g_curr_diag IS NOT NULL THEN
         CASE
            WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
               LET g_detail_idx = 1
               IF g_detail.getLength() THEN
                  LET li_redirect = TRUE
               END IF
            WHEN g_curr_diag.getCurrentRow("s_detail1") > g_detail.getLength() AND g_detail.getLength() > 0
               LET g_detail_idx = g_detail.getLength()
               LET li_redirect = TRUE
            WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
               IF g_detail_idx > g_detail.getLength() THEN
                  LET g_detail_idx = g_detail.getLength()
               END IF
               LET li_redirect = TRUE
         END CASE
      END IF
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="axcq163.mask_functions" >}
 &include "erp/axc/axcq163_mask.4gl"
 
{</section>}
 
{<section id="axcq163.other_function" readonly="Y" >}

PRIVATE FUNCTION axcq163_browser_fill()
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING  
          
   CALL g_browser.clear()
   CALL g_detail.clear() 
   IF cl_null(g_wc) OR g_wc =  " 1=2" THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF 
   IF NOT cl_null(g_master.xcbtcomp) THEN
      LET g_wc = g_wc CLIPPED," AND xcbtcomp = '",g_master.xcbtcomp,"' "
   END IF
   IF NOT cl_null(g_master.xcbt001) THEN
      LET g_wc = g_wc CLIPPED," AND xcbt001 = '",g_master.xcbt001,"' "
   END IF
   IF NOT cl_null(g_master.xcbt002) THEN
      LET g_wc = g_wc CLIPPED,"AND xcbt002 = '",g_master.xcbt002,"'"
   END IF
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_wc = g_wc ," AND xcbtcomp IN ",g_wc_cs_comp
   END IF
   LET g_wc2 = g_wc.trim()    
    
   LET l_sub_sql = " SELECT DISTINCT xcbtcomp,xcbt001,xcbt002,xcbt003",
                   "   FROM xcbt_t LEFT OUTER JOIN sfaa_t ON sfaadocno = xcbt003 AND sfaaent = xcbtent AND sfaasite = xcbtsite ",
                   "               LEFT OUTER JOIN imag_t ON imag001 = sfaa010 AND imagsite = xcbtcomp AND imagent = xcbtent ",
                   "  WHERE xcbtent = ",g_enterprise," AND ",g_wc2,
                   "  ORDER BY xcbtcomp,xcbt001,xcbt002,xcbt003 "                   
 
   LET g_sql = l_sub_sql
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].xcbtcomp,g_browser[g_cnt].xcbt001,g_browser[g_cnt].xcbt002,g_browser[g_cnt].xcbt003
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         EXIT FOREACH
      END IF  
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF      
   END FOREACH
 
   CALL g_browser.deleteElement(g_browser.getlength())

   LET g_row_count = g_cnt - 1  
   IF g_row_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()        
   ELSE      
      CALL axcq163_fetch('F')      
   END IF     
END FUNCTION

################################################################################
#
################################################################################
PRIVATE FUNCTION axcq163_query()
   DEFINE l_comp        LIKE xccc_t.xccccomp
   DEFINE l_ld          LIKE xccc_t.xcccld
   DEFINE l_year        LIKE xccc_t.xccc004
   DEFINE l_period      LIKE xccc_t.xccc005
   DEFINE l_calc_type   LIKE xccc_t.xccc003
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE li_exit       LIKE type_t.num5
   DEFINE lc_action_choice_old    STRING
   
   CLEAR FORM
   INITIALIZE g_master.* TO NULL
   CALL g_detail.clear()
   LET g_wc = NULL
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.xcbtcomp,g_master.xcbt001,g_master.xcbt002 
            ATTRIBUTE(WITHOUT DEFAULTS)
            BEFORE INPUT
               CALL s_axc_set_site_default() RETURNING l_comp,l_ld,l_year,l_period,l_calc_type
               IF cl_null(g_master.xcbtcomp) THEN
                  LET g_master.xcbtcomp = l_comp
                  CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp_desc
                  DISPLAY BY NAME g_master.xcbtcomp
                  SELECT glaa003 INTO g_glaa003 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                     AND glaacomp = g_master.xcbtcomp                     
               END IF
               IF cl_null(g_master.xcbt001) THEN
                  LET g_master.xcbt001 = l_year
                  DISPLAY BY NAME g_master.xcbt001    
               END IF
               IF cl_null(g_master.xcbt002) THEN
                  LET g_master.xcbt002 = l_period
                  DISPLAY BY NAME g_master.xcbt002
               END IF
               IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                      RETURNING g_bdate,g_edate               
               END IF 

            AFTER FIELD xcbtcomp
            
               CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
               DISPLAY BY NAME g_master.xcbtcomp_desc
               IF NOT cl_null(g_master.xcbtcomp) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_master.xcbtcomp
                  LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist('v_ooef001_15') THEN
                     #檢查失敗時後續處理
                     LET g_master.xcbtcomp = g_master_t.xcbtcomp
                     CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                     DISPLAY BY NAME g_master.xcbtcomp_desc
                     NEXT FIELD xcbtcomp
                  END IF  
                  IF s_chr_get_index_of(g_wc_cs_comp,g_master.xcbtcomp,1) = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'ais-00342'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.xcbtcomp = g_master_t.xcbtcomp
                     CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
                     DISPLAY BY NAME g_master.xcbtcomp_desc
                     NEXT FIELD xcbtcomp
                  END IF
                  SELECT glaa003 INTO g_glaa003 FROM glaa_t
                   WHERE glaaent = g_enterprise AND glaa014 = 'Y'
                     AND glaacomp = g_master.xcbtcomp                
                  IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                     CALL s_fin_date_get_period_range(g_glaa003,g_master.xcbt001,g_master.xcbt002)
                      RETURNING g_bdate,g_edate               
                  END IF
                  DISPLAY BY NAME g_master.xcbt001,g_master.xcbt002                                       
               END IF            

            BEFORE FIELD xcbtcomp
               #add-point:BEFORE FIELD xcbtcomp name="input.b.xcbtcomp"
   
               #END add-point
 
 
            #應用 a04 樣板自動產生(Version:3)
            ON CHANGE xcbtcomp
               #add-point:ON CHANGE xcbtcomp name="input.g.xcbtcomp"
   
               #END add-point 
    
    
            #應用 a01 樣板自動產生(Version:2)
            BEFORE FIELD xcbt001
               #add-point:BEFORE FIELD xcbt001 name="input.b.xcbt001"
   
               #END add-point
    
    
            #應用 a02 樣板自動產生(Version:2)
            AFTER FIELD xcbt001
               
               #add-point:AFTER FIELD xcbt001 name="input.a.xcbt001"
               IF NOT cl_null(g_master.xcbt001) THEN
                  IF NOT s_fin_date_chk_year(g_master.xcbt001) THEN
                     LET g_master.xcbt001 = g_master_t.xcbt001
                     DISPLAY BY NAME g_master.xcbt001
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'aoo-00113'
                     LET g_errparam.extend = g_master.xcbt001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     NEXT FIELD CURRENT
                  END IF
                                                       
               END IF  
               IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                      RETURNING g_bdate,g_edate               
               END IF            
               #END add-point
               
    
    
            #應用 a04 樣板自動產生(Version:3)
            ON CHANGE xcbt001
               #add-point:ON CHANGE xcbt001 name="input.g.xcbt001"
   
               #END add-point 
    
    
            #應用 a01 樣板自動產生(Version:2)
            BEFORE FIELD xcbt002
               #add-point:BEFORE FIELD xcbt002 name="input.b.xcbt002"
               
               #END add-point
    
    
            #應用 a02 樣板自動產生(Version:2)
            AFTER FIELD xcbt002
               
               #add-point:AFTER FIELD xcbt002 name="input.a.xcbt002"
               IF NOT cl_null(g_master.xcbt002) THEN                      
                  IF NOT s_fin_date_chk_period(g_glaa003,g_master.xcbt001,g_master.xcbt002) THEN
                     LET g_master.xcbt002 = g_master_t.xcbt002
                     DISPLAY BY NAME g_master.xcbt002
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'amm-00106'
                     LET g_errparam.extend = g_master.xcbt002
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
   
                     NEXT FIELD CURRENT
                  END IF
               END IF
               IF NOT cl_null(g_master.xcbt001) AND NOT cl_null(g_master.xcbt002) THEN
                  CALL s_fin_date_get_period_range(g_glaa003, g_master.xcbt001,g_master.xcbt002)
                      RETURNING g_bdate,g_edate               
               END IF 
               #END add-point
               
    
    
            #應用 a04 樣板自動產生(Version:3)
            ON CHANGE xcbt002
               #add-point:ON CHANGE xcbt002 name="input.g.xcbt002"
   
               #END add-point 
    
    
    
                        #Ctrlp:input.c.xcbtcomp
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD xcbtcomp
               #add-point:ON ACTION controlp INFIELD xcbtcomp name="input.c.xcbtcomp"
               #應用 a07 樣板自動產生(Version:3)   
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
    
               LET g_qryparam.default1 = g_master.xcbtcomp             #給予default值
               LET g_qryparam.default2 = "" #g_master.ooef001 #组织编号
               #給予arg
               LET g_qryparam.arg1 = "" #
   
               #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               CALL q_ooef001_2()                                #呼叫開窗
    
               LET g_master.xcbtcomp = g_qryparam.return1   
               DISPLAY g_master.xcbtcomp TO xcbtcomp              #
               CALL s_desc_get_department_desc(g_master.xcbtcomp) RETURNING g_master.xcbtcomp_desc
               DISPLAY BY NAME g_master.xcbtcomp_desc
               NEXT FIELD xcbtcomp                          #返回原欄位
   
   
   
               #END add-point
    
    
            #Ctrlp:input.c.xcbt001
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD xcbt001
               #add-point:ON ACTION controlp INFIELD xcbt001 name="input.c.xcbt001"
   
               #END add-point
    
    
            #Ctrlp:input.c.xcbt002
            #應用 a03 樣板自動產生(Version:3)
            ON ACTION controlp INFIELD xcbt002
               #add-point:ON ACTION controlp INFIELD xcbt002 name="input.c.xcbt002"
   
               #END add-point
    
    
    
                  
               AFTER INPUT
                  #add-point:資料輸入後 name="input.m.after_input"
   
                  #end add-point
                  
               #add-point:其他管控(on row change, etc...) name="input.other"
   
               #end add-point
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON xcbt003,sfaadocdt,imag014,sfaa010,sfaa011
            
            BEFORE CONSTRUCT 
               
              ON ACTION controlp INFIELD xcbt003
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.reqry = FALSE
                 LET g_qryparam.where = " sfaa003 <> '3' AND (sfaastus = 'F' OR sfaastus = 'M' ) "
                 CALL q_sfcadocno()                       #呼叫開窗
                 DISPLAY g_qryparam.return1 TO xcbt003        #顯示到畫面上
                 NEXT FIELD xcbt003                            #返回原欄位
                             
              ON ACTION controlp INFIELD imag014
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.reqry = FALSE
                 CALL q_ooca001_1()                           #呼叫開窗
                 DISPLAY g_qryparam.return1 TO imag014        #顯示到畫面上
                 NEXT FIELD imag014                           #返回原欄位
        
              ON ACTION controlp INFIELD sfaa010
                 #此段落由子樣板a08產生
                 #開窗c段
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.reqry = FALSE
                 CALL q_imaa001_9()                       #呼叫開窗
                 DISPLAY g_qryparam.return1 TO sfaa010  #顯示到畫面上            
                 NEXT FIELD sfaa010                     #返回原欄位
        
              ON ACTION controlp INFIELD sfaa011
                 #此段落由子樣板a08產生
                 #開窗c段
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.reqry = FALSE
                 CALL q_inaml001()                       #呼叫開窗
                 DISPLAY g_qryparam.return1 TO sfaa011  #顯示到畫面上            
                 NEXT FIELD sfaa011                     #返回原欄位
        
        
           AFTER CONSTRUCT 
                 CONTINUE DIALOG
         END CONSTRUCT
         
         BEFORE DIALOG
            CALL cl_qbe_init()
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL axcq163_fetch('')
            INITIALIZE g_master.* TO NULL
            DISPLAY g_master.* TO xcbtcomp,xcbtcomp_desc,xcbt001,xcbt002,xcbt003,xcbt003_desc,sfaadocdt,imag014, 
                                  imag014_desc,sfaa010,imaal003,imaal004,sfaa011,sfaa011_desc
            CALL g_detail.clear()
            DISPLAY ARRAY g_detail TO s_detail1.*
               BEFORE DISPLAY
                  EXIT DISPLAY
            END DISPLAY
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
         
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = TRUE
            LET li_exit = TRUE
            EXIT DIALOG 
 
         ON ACTION accept
            ACCEPT DIALOG
#            INITIALIZE g_wc_filter TO NULL
#            IF cl_null(g_wc) THEN
#               LET g_wc = " 1=1"
#            END IF
# 
# 
#   
#            IF cl_null(g_wc2) THEN
#               LET g_wc2 = " 1=1"
#            END IF
#            #add-point:ON ACTION accept name="ui_dialog.accept"
#            CALL axcq163_browser_fill()
#            CALL axcq163_cs()
#            EXIT DIALOG
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
          &include "common_action.4gl"
            CONTINUE DIALOG   
   END DIALOG
END FUNCTION

 
{</section>}
 