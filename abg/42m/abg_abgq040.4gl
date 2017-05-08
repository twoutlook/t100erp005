#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq040.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-05-03 17:04:45), PR版次:0003(2016-05-04 16:04:44)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000035
#+ Filename...: abgq040
#+ Description: 預算查詢
#+ Creator....: 02291(2015-09-08 14:12:56)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="abgq040.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#4  160321 By Jessy 修正azzi920重複定義之錯誤訊息
#160321-00016#23 160324 By Jessy 修正azzi920重複定義之錯誤訊息(sub)
#160414-00018#40 160503 By albireo 針對b_fill部分效能調整
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
       bgbc001 LIKE bgbc_t.bgbc001, 
   bgbc001_desc LIKE type_t.chr80, 
   bgbc003 LIKE bgbc_t.bgbc003, 
   bgbc003_desc LIKE type_t.chr80, 
   bgbc002 LIKE bgbc_t.bgbc002, 
   a LIKE type_t.chr500, 
   bgae005 LIKE type_t.chr500, 
   bgae005_desc LIKE type_t.chr80, 
   bgbc007 LIKE type_t.chr500, 
   bgbc007_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       bgae005 LIKE bgae_t.bgae005, 
   bgbc007 LIKE bgbc_t.bgbc007, 
   bgbc007_desc LIKE type_t.chr500, 
   bgbc006 LIKE bgbc_t.bgbc006, 
   bgbc003 LIKE bgbc_t.bgbc003, 
   bgbc003_desc LIKE type_t.chr500, 
   bgbc008 LIKE bgbc_t.bgbc008
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       bgbc007 LIKE bgbc_t.bgbc007, 
   bgbc007_2_desc LIKE type_t.chr500, 
   bgbc017_desc LIKE type_t.chr500, 
   bgbc018_desc LIKE type_t.chr500, 
   bgbc019_desc LIKE type_t.chr500, 
   bgbc020_desc LIKE type_t.chr500, 
   bgbc021_desc LIKE type_t.chr500, 
   bgbc022_desc LIKE type_t.chr500, 
   bgbc023_desc LIKE type_t.chr500, 
   bgbc024_desc LIKE type_t.chr500, 
   bgbc025_desc LIKE type_t.chr500, 
   bgbc026_desc LIKE type_t.chr500, 
   bgbc027 LIKE bgbc_t.bgbc027, 
   bgbc028_desc LIKE type_t.chr500, 
   bgbc039_desc LIKE type_t.chr500, 
   bgbc040_desc LIKE type_t.chr500, 
   bgbc029_desc LIKE type_t.chr500, 
   bgbc030_desc LIKE type_t.chr500, 
   bgbc031_desc LIKE type_t.chr500, 
   bgbc032_desc LIKE type_t.chr500, 
   bgbc033_desc LIKE type_t.chr500, 
   bgbc034_desc LIKE type_t.chr500, 
   bgbc035_desc LIKE type_t.chr500, 
   bgbc036_desc LIKE type_t.chr500, 
   bgbc037_desc LIKE type_t.chr500, 
   bgbc038_desc LIKE type_t.chr500, 
   bgbc009 LIKE bgbc_t.bgbc009
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaa012      LIKE bgaa_t.bgaa012
DEFINE g_bgaa008      LIKE bgaa_t.bgaa008
DEFINE g_bgaa009      LIKE bgaa_t.bgaa009

TYPE type_g_detail3 RECORD
       
       bgbc007 LIKE bgbc_t.bgbc007,
       bgae005 LIKE bgae_t.bgae005,
       bgbc003 LIKE bgbc_t.bgbc003
       END RECORD
 
DEFINE g_detail3            DYNAMIC ARRAY OF type_g_detail3

DEFINE g_glad                RECORD
           glad0171          LIKE  glad_t.glad0171,
           glad0172          LIKE  glad_t.glad0172,
           glad0181          LIKE  glad_t.glad0181,
           glad0182          LIKE  glad_t.glad0182,
           glad0191          LIKE  glad_t.glad0191,
           glad0192          LIKE  glad_t.glad0192,
           glad0201          LIKE  glad_t.glad0201,
           glad0202          LIKE  glad_t.glad0202,
           glad0211          LIKE  glad_t.glad0211,
           glad0212          LIKE  glad_t.glad0212,
           glad0221          LIKE  glad_t.glad0221,
           glad0222          LIKE  glad_t.glad0222,
           glad0231          LIKE  glad_t.glad0231,
           glad0232          LIKE  glad_t.glad0232,
           glad0241          LIKE  glad_t.glad0241,
           glad0242          LIKE  glad_t.glad0242,
           glad0251          LIKE  glad_t.glad0251,
           glad0252          LIKE  glad_t.glad0252,
           glad0261          LIKE  glad_t.glad0261,
           glad0262          LIKE  glad_t.glad0262
                             END RECORD
DEFINE g_glaald         LIKE glaa_t.glaald
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master            type_g_master
DEFINE g_master_t          type_g_master
 
   
 
DEFINE g_detail            DYNAMIC ARRAY OF type_g_detail
DEFINE g_detail_t          type_g_detail
DEFINE g_detail2     DYNAMIC ARRAY OF type_g_detail2
DEFINE g_detail2_t   type_g_detail2
 
 
 
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
 
{<section id="abgq040.main" >}
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
   CALL cl_ap_init("abg","")
 
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
   DECLARE abgq040_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq040_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq040_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq040 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq040_init()   
 
      #進入選單 Menu (="N")
      CALL abgq040_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq040
      
   END IF 
   
   CLOSE abgq040_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq040.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgq040_init()
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
   CALL s_fin_create_account_center_tmp()
   CALL abgq040_create_tmp()
   CALL cl_set_combo_scc('bgae005_1','9407')
   CALL cl_set_combo_scc('b_bgbc027','6013')
   #end add-point
 
   CALL abgq040_default_search()
END FUNCTION
 
{</section>}
 
{<section id="abgq040.default_search" >}
PRIVATE FUNCTION abgq040_default_search()
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
 
{<section id="abgq040.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq040_ui_dialog() 
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
   CALL abgq040_ui_dialog_1()
   RETURN
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
   
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL abgq040_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
 
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
 
         CALL abgq040_init()
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
               CALL abgq040_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq040_b_fill2()
 
               #add-point:input段before row name="input.body.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
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
 
 
 
         #add-point:ui_dialog段define name="ui_dialog.more_displayarray"
         
         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL abgq040_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD bgbc001
 
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
 
            CALL abgq040_cs()
 
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
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('F')
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
            CALL abgq040_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         
         
         
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
 
{<section id="abgq040.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION abgq040_cs()
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
      
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      
      #end add-point
   END IF
 
   PREPARE abgq040_pre FROM g_sql
   DECLARE abgq040_curs SCROLL CURSOR WITH HOLD FOR abgq040_pre
   OPEN abgq040_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_row_count = 1
   CALL abgq040_fetch("F")
   RETURN
   #end add-point
   PREPARE abgq040_precount FROM g_cnt_sql
   EXECUTE abgq040_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL abgq040_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="abgq040.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION abgq040_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   CALL abgq040_fetch1(p_flag)
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_bgbc001,bgbc001_desc,b_bgbc003,b_bgbc003_desc,b_bgbc002,a,b_bgae005,b_bgae005_desc, 
          bgbc007,bgbc007_desc
      CALL g_detail.clear()
      CALL g_detail2.clear()
 
 
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
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL abgq040_show()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq040.show" >}
PRIVATE FUNCTION abgq040_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_bgbc001,bgbc001_desc,b_bgbc003,b_bgbc003_desc,b_bgbc002,a,b_bgae005,b_bgae005_desc, 
       bgbc007,bgbc007_desc
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL abgq040_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq040.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq040_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL abgq040_b_fill1()
   RETURN
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   
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
   CALL abgq040_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq040_detail_action_trans()
 
   CALL abgq040_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgq040.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq040_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_bgbc008       LIKE bgbc_t.bgbc008
   DEFINE l_bgbc009       LIKE bgbc_t.bgbc009
   DEFINE l_glac008       LIKE glac_t.glac008
   
   #160414-00018#40-----s
   DEFINE l_get_sql   RECORD
          bgbc017     STRING,
          bgbc018     STRING,
          bgbc019     STRING,
          bgbc020     STRING,
          bgbc021     STRING,
          bgbc022     STRING,
          bgbc023     STRING,
          bgbc024     STRING,
          bgbc025     STRING,
          bgbc026     STRING,
          bgbc028     STRING,
          bgbc040     STRING,
          bgbc039     STRING
                      END RECORD
   DEFINE l_bgbc017_desc    LIKE type_t.chr100
   DEFINE l_bgbc018_desc    LIKE type_t.chr100
   DEFINE l_bgbc019_desc    LIKE type_t.chr100
   DEFINE l_bgbc020_desc    LIKE type_t.chr100
   DEFINE l_bgbc021_desc    LIKE type_t.chr100
   DEFINE l_bgbc022_desc    LIKE type_t.chr100
   DEFINE l_bgbc023_desc    LIKE type_t.chr100
   DEFINE l_bgbc024_desc    LIKE type_t.chr100
   DEFINE l_bgbc025_desc    LIKE type_t.chr100
   DEFINE l_bgbc026_desc    LIKE type_t.chr100
   DEFINE l_bgbc028_desc    LIKE type_t.chr100
   DEFINE l_bgbc040_desc    LIKE type_t.chr100
   DEFINE l_bgbc039_desc    LIKE type_t.chr100
   #160414-00018#40-----e
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   IF l_ac = 0 THEN
      LET l_ac = 1
   END IF
   
   #160414-00018#40-----s
   #部门：        
   CALL s_fin_get_department_sql('tc17','t2.bgbcent','t2.bgbc017') RETURNING l_get_sql.bgbc017
   #成本利润中心：
   CALL s_fin_get_department_sql('tc18','t2.bgbcent','t2.bgbc018') RETURNING l_get_sql.bgbc018
   #区域：        
   CALL s_fin_get_acc_sql('tc19','t2.bgbcent','287','t2.bgbc019') RETURNING l_get_sql.bgbc019
   #交易客商      
   CALL s_fin_get_trading_partner_abbr_sql('tc20','t2.bgbcent','bgbc020') RETURNING l_get_sql.bgbc020
   #收款客商     
   CALL s_fin_get_trading_partner_abbr_sql('tc21','t2.bgbcent','bgbc021') RETURNING l_get_sql.bgbc021
   #客群          
   CALL s_fin_get_acc_sql('tc22','t2.bgbcent','281','t2.bgbc022') RETURNING l_get_sql.bgbc022
   #产品类别      
   CALL s_fin_get_rtaxl003_sql('tc23','t2.bgbcent','t2.bgbc023') RETURNING l_get_sql.bgbc023
   #人员          
   CALL s_fin_get_person_sql('tc24','t2.bgbcent','t2.bgbc024') RETURNING l_get_sql.bgbc024
   #WBS           
   CALL s_fin_get_wbs_sql('tc26','t2.bgbcent','t2.bgbc025','t2.bgbc026') RETURNING l_get_sql.bgbc026
   #专案编号      
   CALL s_fin_get_project_sql('tc25','t2.bgbcent','t2.bgbc025') RETURNING l_get_sql.bgbc025
   #渠道          
   CALL s_fin_get_oojdl003_sql('tc28','t2.bgbcent','t2.bgbc028') RETURNING l_get_sql.bgbc028
   #品牌 
   CALL s_fin_get_acc_sql('tc40','t2.bgbcent','2002','t2.bgbc040') RETURNING l_get_sql.bgbc040
   #現金變動碼      
   #LET g_detail2[li_ac].bgbc039_desc = s_desc_show1(g_detail2[li_ac].bgbc039_desc,s_desc_get_nmail004_desc(g_bgaa009,g_detail2[li_ac].bgbc040_desc))
   LET l_get_sql.bgbc039 = "(SELECT tc39.nmail004 FROM nmail_t tc39 WHERE tc39.nmailent = ",g_enterprise," AND tc39.nmail001 = '",g_bgaa009,"' AND tc39.nmail002 = t2.bgbc039 AND nmail003 = '",g_dlang,"' )"
   
   #glad PREPARE
   LET l_sql = " SELECT glad0171,glad0172,glad0181,glad0182,glad0191,",
               "        glad0192,glad0201,glad0202,glad0211,glad0212,",
               "        glad0221,glad0222,glad0231,glad0232,glad0241,",
               "        glad0242,glad0251,glad0252,glad0261,glad0262 ",
               "   FROM glad_t ",
               " WHERE gladent = ? ",
               "   AND gladld  = ? ",
               "   AND glad001 = ? "
   PREPARE sel_gladp1 FROM l_sql
   #160414-00018#40-----e
   
   LET l_sql = " SELECT DISTINCT t2.bgbc007,",
               ##160414-00018#40-----s
               "               (SELECT tc07.bgael003 FROM bgael_t tc07 WHERE tc07.bgaelent = ",g_enterprise,    
               "                   AND tc07.bgael006 = '",g_bgaa008,"' AND tc07.bgael001 = t2.bgbc007 ",        
               "                   AND tc07.bgael002 = '",g_dlang,"'  ), ",                                     
               ##160414-00018#40-----e
               "  t2.bgbc017,t2.bgbc018,t2.bgbc019,t2.bgbc020,t2.bgbc021,t2.bgbc022,t2.bgbc023,t2.bgbc024,t2.bgbc025,",
               "  t2.bgbc026,t2.bgbc027,t2.bgbc028,t2.bgbc039,t2.bgbc040,t2.bgbc029,t2.bgbc030,t2.bgbc031,t2.bgbc032,t2.bgbc033,",
               "  t2.bgbc034,t2.bgbc035,t2.bgbc036,t2.bgbc037,t2.bgbc038,t1.bgbc008,t2.bgbc008,t2.bgbc009,",
               #160414-00018#40-----s
               l_get_sql.bgbc017,",",l_get_sql.bgbc018,",",l_get_sql.bgbc019,",",l_get_sql.bgbc020,",",l_get_sql.bgbc021,",",
               l_get_sql.bgbc022,",",l_get_sql.bgbc023,",",l_get_sql.bgbc024,",",l_get_sql.bgbc025,",",l_get_sql.bgbc028,",",
               l_get_sql.bgbc040,",",l_get_sql.bgbc039,",",l_get_sql.bgbc026,",",
               "                (SELECT tc072.bgae002 FROM bgae_t tc072 WHERE tc072.bgaeent = ",g_enterprise," AND tc072.bgae006 = '",g_bgaa008,"' AND tc072.bgae001 = t2.bgbc007)",
               #160414-00018#40-----e
               "   FROM abgq040_tmp t1,bgbc_t t2 ",
               "  WHERE t1.bgbc007 = t2.bgbc007 AND t1.bgbc003 = t2.bgbc003 ",
               "    AND t2.bgbc001 = '",g_master.bgbc001,"' AND t2.bgbc002 = '",g_master.bgbc002,"'",
               "    AND t2.bgbc007 = '",g_detail[l_ac].bgbc007,"' AND t2.bgbc003 = '",g_detail[l_ac].bgbc003,"'",
               "    AND t2.bgbcent = ",g_enterprise," ",
               "    AND t1.flag1 = '1' ",
               "  ORDER BY t2.bgbc007,t2.bgbc003"
    
   PREPARE b_fill_prep1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR b_fill_prep1
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   FOREACH b_fill_curs1 INTO g_detail2[li_ac].*,l_bgbc008,l_bgbc009,
                             l_bgbc017_desc,l_bgbc018_desc,l_bgbc019_desc,l_bgbc020_desc,l_bgbc021_desc,   #160414-00018#40 add
                             l_bgbc022_desc,l_bgbc023_desc,l_bgbc024_desc,l_bgbc025_desc,l_bgbc028_desc,   #160414-00018#40 add
                             l_bgbc040_desc,l_bgbc039_desc,l_bgbc026_desc,l_glac008                        #160414-00018#40 add
   
      #160414-00018#40 mark-----s
      ##取借貸方向
      #IF g_bgaa012 = 'Y' THEN  #agli020
      #   
      #   SELECT glacl004 INTO g_detail2[li_ac].bgbc007_2_desc FROM glacl_t
      #    WHERE glaclent = g_enterprise AND glacl001 = g_bgaa008
      #      AND glacl002 = g_detail2[li_ac].bgbc007 AND glacl003 = g_dlang
      #      
      #ELSE  #abgi040
      #   
      #   LET g_detail2[li_ac].bgbc007_2_desc = s_abg_bgae001_desc(g_bgaa008,g_detail2[li_ac].bgbc007)
      #END IF
      #160414-00018#40 mark-----e
      
      IF cl_null(l_bgbc008) THEN LET l_bgbc008 = 0 END IF
      IF cl_null(l_bgbc009) THEN LET l_bgbc009 = 0 END IF
      
      #取借貸方向
      #160414-00018#40 mark-----s
      #IF g_bgaa012 = 'Y' THEN  #agli020
      #   SELECT glac008 INTO l_glac008 FROM glac_t
      #    WHERE glacent = g_enterprise AND glac001 = g_bgaa008
      #      AND glac002 = g_detail2[li_ac].bgbc007
      #ELSE  #abgi040
      #   SELECT bgae002 INTO l_glac008 FROM bgae_t
      #    WHERE bgaeent = g_enterprise AND bgae006 = g_bgaa008
      #      AND bgae002 = g_detail2[li_ac].bgbc007
      #END IF
      #160414-00018#40 mark-----e
      
      #核准金額
      IF l_glac008 = '1' THEN  #借方
         LET g_detail2[li_ac].bgbc009 = l_bgbc008 - l_bgbc009
      ELSE   #貸方
         LET g_detail2[li_ac].bgbc009 = l_bgbc009 - l_bgbc008
      END IF
      
      #160414-00018#40 modify-----s
      #CALL s_fin_sel_glad(g_glaald,g_detail2[li_ac].bgbc007,'glad0171|glad0172|glad0181|glad0182|glad0191|glad0192|glad0201|glad0202|glad0211|glad0212|glad0221|glad0222|glad0231|glad0232|glad0241|glad0242|glad0251|glad0252|glad0261|glad0262') 
      #        RETURNING g_errno,g_glad.*
      EXECUTE sel_gladp1 USING g_enterprise,g_glaald,g_detail2[li_ac].bgbc007 
                         INTO g_glad.*      
      #160414-00018#40 modify-----e
              
      #160414-00018#40 modify-----s
      ##部门：        
      #LET g_detail2[li_ac].bgbc017_desc = s_desc_show1(g_detail2[li_ac].bgbc017_desc,s_desc_get_department_desc(g_detail2[li_ac].bgbc017_desc))
      ##成本利润中心：
      #LET g_detail2[li_ac].bgbc018_desc = s_desc_show1(g_detail2[li_ac].bgbc018_desc,s_desc_get_department_desc(g_detail2[li_ac].bgbc018_desc))
      ##区域：        
      #LET g_detail2[li_ac].bgbc019_desc = s_desc_show1(g_detail2[li_ac].bgbc019_desc,s_desc_get_acc_desc('287',g_detail2[li_ac].bgbc019_desc))
      ##交易客商      
      #LET g_detail2[li_ac].bgbc020_desc = s_desc_show1(g_detail2[li_ac].bgbc020_desc,s_desc_get_trading_partner_abbr_desc(g_detail2[li_ac].bgbc020_desc))
      ##收款客商     
      #LET g_detail2[li_ac].bgbc021_desc = s_desc_show1(g_detail2[li_ac].bgbc021_desc,s_desc_get_trading_partner_abbr_desc(g_detail2[li_ac].bgbc021_desc))
      ##客群          
      #LET g_detail2[li_ac].bgbc022_desc = s_desc_show1(g_detail2[li_ac].bgbc022_desc,s_desc_get_acc_desc('281',g_detail2[li_ac].bgbc022_desc))
      ##产品类别      
      #LET g_detail2[li_ac].bgbc023_desc = s_desc_show1(g_detail2[li_ac].bgbc023_desc,s_desc_get_rtaxl003_desc(g_detail2[li_ac].bgbc023_desc))
      ##人员          
      #LET g_detail2[li_ac].bgbc024_desc = s_desc_show1(g_detail2[li_ac].bgbc024_desc,s_desc_get_person_desc(g_detail2[li_ac].bgbc024_desc))
      ##WBS           
      #LET g_detail2[li_ac].bgbc026_desc = s_desc_show1(g_detail2[li_ac].bgbc026_desc,s_desc_get_pjbbl004_desc(g_detail2[li_ac].bgbc025_desc,g_detail2[li_ac].bgbc026_desc))
      ##专案编号      
      #LET g_detail2[li_ac].bgbc025_desc = s_desc_show1(g_detail2[li_ac].bgbc025_desc,s_desc_get_project_desc(g_detail2[li_ac].bgbc025_desc)) 
      ##渠道          
      #LET g_detail2[li_ac].bgbc028_desc = s_desc_show1(g_detail2[li_ac].bgbc028_desc,s_desc_get_oojdl003_desc(g_detail2[li_ac].bgbc028_desc))
      ##品牌          
      #LET g_detail2[li_ac].bgbc040_desc = s_desc_show1(g_detail2[li_ac].bgbc040_desc,s_desc_get_acc_desc('2002',g_detail2[li_ac].bgbc040_desc))
      ##現金變動碼      
      #LET g_detail2[li_ac].bgbc039_desc = s_desc_show1(g_detail2[li_ac].bgbc039_desc,s_desc_get_nmail004_desc(g_bgaa009,g_detail2[li_ac].bgbc040_desc))
      
      #部门：        
      LET g_detail2[li_ac].bgbc017_desc = s_desc_show1(g_detail2[li_ac].bgbc017_desc,l_bgbc017_desc)
      #成本利润中心：
      LET g_detail2[li_ac].bgbc018_desc = s_desc_show1(g_detail2[li_ac].bgbc018_desc,l_bgbc018_desc)
      #区域：        
      LET g_detail2[li_ac].bgbc019_desc = s_desc_show1(g_detail2[li_ac].bgbc019_desc,l_bgbc019_desc)
      #交易客商      
      LET g_detail2[li_ac].bgbc020_desc = s_desc_show1(g_detail2[li_ac].bgbc020_desc,l_bgbc020_desc)
      #收款客商     
      LET g_detail2[li_ac].bgbc021_desc = s_desc_show1(g_detail2[li_ac].bgbc021_desc,l_bgbc021_desc)
      #客群          
      LET g_detail2[li_ac].bgbc022_desc = s_desc_show1(g_detail2[li_ac].bgbc022_desc,l_bgbc022_desc)
      #产品类别      
      LET g_detail2[li_ac].bgbc023_desc = s_desc_show1(g_detail2[li_ac].bgbc023_desc,l_bgbc023_desc)
      #人员          
      LET g_detail2[li_ac].bgbc024_desc = s_desc_show1(g_detail2[li_ac].bgbc024_desc,l_bgbc024_desc)
      #WBS           
      LET g_detail2[li_ac].bgbc026_desc = s_desc_show1(g_detail2[li_ac].bgbc026_desc,l_bgbc026_desc)
      #专案编号      
      LET g_detail2[li_ac].bgbc025_desc = s_desc_show1(g_detail2[li_ac].bgbc025_desc,l_bgbc025_desc) 
      #渠道          
      LET g_detail2[li_ac].bgbc028_desc = s_desc_show1(g_detail2[li_ac].bgbc028_desc,l_bgbc028_desc)
      #品牌          
      LET g_detail2[li_ac].bgbc040_desc = s_desc_show1(g_detail2[li_ac].bgbc040_desc,l_bgbc040_desc)
      #現金變動碼      
      LET g_detail2[li_ac].bgbc039_desc = s_desc_show1(g_detail2[li_ac].bgbc039_desc,l_bgbc039_desc)            
      #160414-00018#40 modify-----e
      #自由核算项
      #一： 
      IF NOT cl_null(g_glad.glad0171) AND NOT cl_null(g_detail2[li_ac].bgbc029_desc)THEN   #160414-00018#40 add
         LET g_detail2[li_ac].bgbc029_desc = s_desc_show1(g_detail2[li_ac].bgbc029_desc,s_fin_get_accting_desc(g_glad.glad0171,g_detail2[li_ac].bgbc029_desc))  
      END IF     #160414-00018#40 add
      #二： 
      IF NOT cl_null(g_glad.glad0181) AND NOT cl_null(g_detail2[li_ac].bgbc030_desc)THEN   #160414-00018#40 add      
         LET g_detail2[li_ac].bgbc030_desc = s_desc_show1(g_detail2[li_ac].bgbc030_desc,s_fin_get_accting_desc(g_glad.glad0181,g_detail2[li_ac].bgbc030_desc))
      END IF  #160414-00018#40 add
      #三： 
      IF NOT cl_null(g_glad.glad0191) AND NOT cl_null(g_detail2[li_ac].bgbc031_desc)THEN   #160414-00018#40 add 
         LET g_detail2[li_ac].bgbc031_desc = s_desc_show1(g_detail2[li_ac].bgbc031_desc,s_fin_get_accting_desc(g_glad.glad0191,g_detail2[li_ac].bgbc031_desc))
      END IF  #160414-00018#40 add
      #四： 
      IF NOT cl_null(g_glad.glad0201) AND NOT cl_null(g_detail2[li_ac].bgbc032_desc)THEN   #160414-00018#40 add       
         LET g_detail2[li_ac].bgbc032_desc = s_desc_show1(g_detail2[li_ac].bgbc032_desc,s_fin_get_accting_desc(g_glad.glad0201,g_detail2[li_ac].bgbc032_desc))
      END IF  #160414-00018#40 add
      #五： 
      IF NOT cl_null(g_glad.glad0211) AND NOT cl_null(g_detail2[li_ac].bgbc033_desc)THEN   #160414-00018#40 add 
         LET g_detail2[li_ac].bgbc033_desc = s_desc_show1(g_detail2[li_ac].bgbc033_desc,s_fin_get_accting_desc(g_glad.glad0211,g_detail2[li_ac].bgbc033_desc))
      END IF   #160414-00018#40 add
      #六： 
      IF NOT cl_null(g_glad.glad0221) AND NOT cl_null(g_detail2[li_ac].bgbc034_desc)THEN   #160414-00018#40 add      
         LET g_detail2[li_ac].bgbc034_desc = s_desc_show1(g_detail2[li_ac].bgbc034_desc,s_fin_get_accting_desc(g_glad.glad0221,g_detail2[li_ac].bgbc034_desc))
      END IF   #160414-00018#40 add 
      #七： 
      IF NOT cl_null(g_glad.glad0231) AND NOT cl_null(g_detail2[li_ac].bgbc035_desc)THEN   #160414-00018#40 add    
         LET g_detail2[li_ac].bgbc035_desc = s_desc_show1(g_detail2[li_ac].bgbc035_desc,s_fin_get_accting_desc(g_glad.glad0231,g_detail2[li_ac].bgbc035_desc))
      END IF   #160414-00018#40 add  
      #八： 
      IF NOT cl_null(g_glad.glad0241) AND NOT cl_null(g_detail2[li_ac].bgbc036_desc)THEN   #160414-00018#40 add         
         LET g_detail2[li_ac].bgbc036_desc = s_desc_show1(g_detail2[li_ac].bgbc036_desc,s_fin_get_accting_desc(g_glad.glad0241,g_detail2[li_ac].bgbc036_desc))
      END IF   #160414-00018#40 add
      #九： 
      IF NOT cl_null(g_glad.glad0251) AND NOT cl_null(g_detail2[li_ac].bgbc037_desc)THEN   #160414-00018#40 add       
         LET g_detail2[li_ac].bgbc037_desc = s_desc_show1(g_detail2[li_ac].bgbc037_desc,s_fin_get_accting_desc(g_glad.glad0251,g_detail2[li_ac].bgbc037_desc))
      END IF   #160414-00018#40 add    
      #十： 
      IF NOT cl_null(g_glad.glad0261) AND NOT cl_null(g_detail2[li_ac].bgbc038_desc)THEN   #160414-00018#40 add  
         LET g_detail2[li_ac].bgbc038_desc = s_desc_show1(g_detail2[li_ac].bgbc038_desc,s_fin_get_accting_desc(g_glad.glad0261,g_detail2[li_ac].bgbc038_desc))
      END IF   #160414-00018#40 add
      
      LET li_ac = li_ac + 1
   END FOREACH
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq040.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq040_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_master.bgbc007
            LET ls_sql = "SELECT bgael003 FROM bgael_t WHERE bgaelent='"||g_enterprise||"' AND bgael006='' AND bgael001=? AND bgael002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_master.bgbc007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.bgbc007_desc

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
 
{<section id="abgq040.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION abgq040_maintain_prog()
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
 
{<section id="abgq040.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq040_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
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
 
{<section id="abgq040.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq040_detail_index_setting()
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
 
{<section id="abgq040.mask_functions" >}
 &include "erp/abg/abgq040_mask.4gl"
 
{</section>}
 
{<section id="abgq040.other_function" readonly="Y" >}

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
PRIVATE FUNCTION abgq040_ui_dialog_1()
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
   #add-point:ui_dialog段define-標準
   DEFINE l_n       LIKE type_t.num5
   #end add-point
   #add-point:ui_dialog段define-客製

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
 
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL abgq040_cs()
   END IF
 
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         INITIALIZE g_master.* TO NULL
         CALL g_detail.clear()
         CALL g_detail2.clear()
 
 
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
 
         CALL abgq040_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         
         #end add-point
 
         #add-point:construct段落
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL abgq040_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq040_b_fill2()
 
               #add-point:input段before row

               #end add-point
 
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為

            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_detail2 TO s_detail2.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail2")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row

               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
            #add-point:page2自定義行為

            #end add-point
         END DISPLAY
 
 
 
         #add-point:ui_dialog段define

         #end add-point
    
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            CALL abgq040_fetch('')
 
            #add-point:ui_dialog段before dialog
            CALL abgq040_construct()
            CALL abgq040_fetch1('F')
            #end add-point
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog

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
 
#         ON ACTION accept
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
# 
# 
#            #add-point:ON ACTION accept
#            CALL abgq040_get_data()
#            #end add-point
# 
#            CALL abgq040_cs()
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum

            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_detail)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_detail2)
               LET g_export_id[2]   = "s_detail2"
 
 
               #add-point:ON ACTION exporttoexcel

               #end add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION datarefresh   # 重新整理
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('F')
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
            #add-point:ON ACTION datainfo

            #end add-point
            CALL abgq040_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq040_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq040_b_fill()
 
 
 
 
#         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION output
#            LET g_action_choice="output"
#            IF cl_auth_chk_act("output") THEN
#               
#               #add-point:ON ACTION output
#
#               #END add-point
#               
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
               #清除畫面及相關資料
               CLEAR FORM
               INITIALIZE g_master.* TO NULL
               CALL g_detail.clear()
               CALL g_detail2.clear()
              
              
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
              
               CALL abgq040_init()
               CALL abgq040_construct()
               CALL abgq040_fetch1('F')               
               #END add-point
               
               
            END IF
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前

         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後
            INITIALIZE g_master.* TO NULL
            CALL g_detail.clear()
            CALL g_detail2.clear()
            
            
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
            
            CALL abgq040_init()
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point 
 
      END DIALOG 
   
   END WHILE
END FUNCTION

################################################################################
# Descriptions...: 跳頁設置
# Memo...........:
# Date & Author..: 2015/09/06 By 02291
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq040_get_data()
   DEFINE li_idx      LIKE type_t.num5
   DEFINE l_sql       STRING
   DEFINE l_bgbc003   LIKE bgbc_t.bgbc003
   DEFINE l_bgbc006   LIKE bgbc_t.bgbc006
   DEFINE l_bgbc007   LIKE bgbc_t.bgbc007
   DEFINE l_bgbc008   LIKE bgbc_t.bgbc008
   DEFINE l_bgbc009   LIKE bgbc_t.bgbc009
   DEFINE l_glac008   LIKE glac_t.glac008
   DEFINE l_bgae005   LIKE bgae_t.bgae005
   DEFINE l_sum1      LIKE type_t.num20_6
   
   DELETE FROM abgq040_tmp
   LET li_idx = 1
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbc007','bgbc007') 
   LET g_wc2= cl_replace_str(g_wc2,'b_bgae005','bgae005')
   
   IF g_bgaa012 = 'N' THEN
      LET l_sql = " SELECT UNIQUE bgae005,bgbc007,bgbc006,bgbc003,SUM(bgbc008),SUM(bgbc009) FROM bgbc_t,bgae_t ",
                  "  WHERE bgbcent = bgaeent AND bgbc007 = bgae001 ",
                  "    AND bgbcent = ",g_enterprise," AND bgbc001 = '",g_master.bgbc001,"'",
                  "    AND bgbc002 = '",g_master.bgbc002,"'",
                  "    AND bgae006 = '",g_bgaa008,"'",
                  "    AND ",g_wc2 CLIPPED,
                  "    AND bgbc003 IN ",g_wc CLIPPED,
                  "  GROUP BY bgae005,bgbc007,bgbc006,bgbc003"
   ELSE
      LET l_sql = " SELECT UNIQUE '',bgbc007,bgbc006,bgbc003,SUM(bgbc008),SUM(bgbc009) FROM bgbc_t ",
                  "  WHERE bgbcent = ",g_enterprise," AND bgbc001 = '",g_master.bgbc001,"'",
                  "    AND bgbc002 = '",g_master.bgbc002,"'",
                  "    AND ",g_wc2 CLIPPED,
                  "    AND bgbc003 IN ",g_wc CLIPPED,
                  "  GROUP BY bgbc007,bgbc006,bgbc003"
   END IF
                   
   PREPARE bgbd_page_prep FROM l_sql
   DECLARE bgbd_page_curs CURSOR FOR bgbd_page_prep
   FOREACH bgbd_page_curs INTO l_bgae005,l_bgbc007,l_bgbc006,l_bgbc003,l_bgbc008,l_bgbc009
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'bgbd_page_curs'
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      
      IF cl_null(l_bgbc008) THEN LET l_bgbc008 = 0 END IF
      IF cl_null(l_bgbc009) THEN LET l_bgbc009 = 0 END IF
      
      #取借貸方向
      IF g_bgaa012 = 'Y' THEN  #agli020
         SELECT glac008 INTO l_glac008 FROM glac_t
          WHERE glacent = g_enterprise AND glac001 = g_bgaa008
            AND glac002 = l_bgbc007
      ELSE  #abgi040
         SELECT bgae002 INTO l_glac008 FROM bgae_t
          WHERE bgaeent = g_enterprise AND bgae006 = g_bgaa008
            AND bgae002 = l_bgbc007
      END IF
      #核准金額
      IF l_glac008 = '1' THEN  #借方
         LET l_sum1 = l_bgbc008 - l_bgbc009
      ELSE   #貸方
         LET l_sum1 = l_bgbc009 - l_bgbc008
      END IF
      INSERT INTO abgq040_tmp VALUES(l_bgae005,l_bgbc007,l_bgbc006,l_bgbc003,l_sum1,'1')

      
   END FOREACH
   
   LET l_sql = " INSERT INTO abgq040_tmp",
               " SELECT '',bgbc007,'',bgbc003,SUM(bgbc008),'2' FROM abgq040_tmp ",
               "  GROUP BY bgbc007,bgbc003",
               "  ORDER BY bgbc007,bgbc003"
   PREPARE abgq040_sum_tmp_ins FROM l_sql
   EXECUTE abgq040_sum_tmp_ins
   
END FUNCTION

################################################################################
# Descriptions...: 如果是科目預算，隱藏欄位【預算大類】
# Date & Author..: 2015/09/08 By 02291
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq040_bgbc001_visible()
   
   SELECT bgaa012,bgaa008,bgaa009 INTO g_bgaa012,g_bgaa008,g_bgaa009 FROM bgaa_t
    WHERE bgaaent = g_enterprise AND bgaa001 = g_master.bgbc001
      AND bgaastus = 'Y'
   IF g_bgaa012 = 'Y' THEN
      CALL cl_set_comp_visible('b_bgae005,b_bgae005_desc,bgae005_1',FALSE)
   ELSE
      CALL cl_set_comp_visible('b_bgae005,b_bgae005_desc,bgae005_1',TRUE)
   END IF
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
PRIVATE FUNCTION abgq040_ooef001_str()
   DEFINE ls_wc         STRING
   DEFINE l_sql         STRING
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE tok           base.StringTokenizer
   DEFINE l_str         STRING
   DEFINE l_sons        LIKE ooef_t.ooef001
   
   LET g_wc = ''
   LET ls_wc = ''
   #抓取預算組織資料
   IF g_master.a = '0' THEN   #當前組織本級
      IF cl_null(ls_wc)THEN
         LET ls_wc = g_master.bgbc003 CLIPPED
      ELSE
         LET ls_wc = ls_wc CLIPPED,",",g_master.bgbc003 CLIPPED,""
      END IF 
   ELSE
      CALL s_fin_abg_center_sons_query(g_master.bgbc001,g_master.bgbc003,'N')
      IF g_master.a = '2' THEN   #當前組織樹多層展開
         #取得帳務組織下所有組織
         CALL s_fin_account_center_sons_str() RETURNING ls_wc 
         #將取回的字串轉換為SQL條件
        #CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
      ELSE
         IF g_master.a = '1' THEN  #當前組織樹單層展開
            LET l_sql = " SELECT DISTINCT ooef001 FROM s_fin_tmp1 ",
                        "   WHERE (tree_level = '1' OR tree_level = '2') AND ooed005 = '",g_master.bgbc003,"'"
            PREPARE ooef001_prep FROM l_sql
            DECLARE ooef001_curs CURSOR FOR ooef001_prep
          
            LET ls_wc = NULL
            FOREACH ooef001_curs INTO l_sons
               IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
          
               IF cl_null(ls_wc)THEN
                  LET ls_wc = l_sons CLIPPED
               ELSE
                  LET ls_wc = ls_wc CLIPPED,",",l_sons CLIPPED,""
               END IF
            END FOREACH
         END IF
      END IF
   END IF
   
   WHENEVER ERROR CONTINUE
   LET tok = base.StringTokenizer.create(ls_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
      
   
   LET g_wc = "('",l_str,"')"
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
PRIVATE FUNCTION abgq040_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE l_sql            STRING
   DEFINE l_bgbc008        LIKE bgbc_t.bgbc008
   DEFINE l_bgbc009        LIKE bgbc_t.bgbc009
   DEFINE l_glac008        LIKE glac_t.glac008
   DEFINE l_flag1          LIKE type_t.chr1
   DEFINE l_msgstr         STRING   #160414-00018#40
   #end add-point
   #add-point:b_fill段define-客製

   #end add-point
 
   #add-point:b_fill段sql_before

   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空

   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:2)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql
   LET g_wc2= cl_replace_str(g_wc2,'b_bgbc007','bgbc007')
   LET g_wc2= cl_replace_str(g_wc2,'b_bgae005','bgae005')
   
   
   
   LET l_sql = " SELECT UNIQUE t1.bgae005,t1.bgbc007,t1.bgbc006,t1.bgbc003,t1.bgbc008,t1.flag1, ",
               "               (SELECT tc07.bgael003 FROM bgael_t tc07 WHERE tc07.bgaelent = ",g_enterprise,    #160414-00018#40
               "                   AND tc07.bgael006 = '",g_bgaa008,"' AND tc07.bgael001 = t1.bgbc007 ",        #160414-00018#40
               "                   AND tc07.bgael002 = '",g_dlang,"'  ), ",                                     #160414-00018#40
               "               (SELECT tc03.ooefl003 FROM ooefl_t tc03 WHERE tc03.ooeflent = ",g_enterprise,    #160414-00018#40
               "                   AND tc03.ooefl001 = t1.bgbc003 AND tc03.ooefl002 = '",g_dlang,"') ",         #160414-00018#40
               "  FROM abgq040_tmp t1,bgbc_t t2 ", 
               "  WHERE t1.bgbc007 = t2.bgbc007 AND t1.bgbc003 = t2.bgbc003 ",
               "    AND t2.bgbc001 = '",g_master.bgbc001,"' AND t2.bgbc002 = '",g_master.bgbc002,"'",
               "    AND t2.bgbcent = ",g_enterprise," ",     #160414-00018#40 add
               "  ORDER BY t1.bgbc007,t1.bgbc006,t1.bgbc003,t1.flag1"
               
   PREPARE b_fill_prep FROM l_sql
   DECLARE b_fill_curs CURSOR FOR b_fill_prep
   #end add-point
 
 
   LET l_msgstr =  cl_getmsg('lib-00156',g_dlang)    #160414-00018#40 add
   
   #add-point:b_fill段資料填充(其他單身)  
   FOREACH b_fill_curs INTO g_detail[l_ac].bgae005,g_detail[l_ac].bgbc007,g_detail[l_ac].bgbc006,
                            g_detail[l_ac].bgbc003,g_detail[l_ac].bgbc008,l_flag1,
                            g_detail[l_ac].bgbc007_desc,g_detail[l_ac].bgbc003_desc      #160414-00018#40
      
      
      ##160414-00018#40 mark-----s
      ##取借貸方向
      #IF g_bgaa012 = 'Y' THEN  #agli020
      #   
      #   SELECT glacl004 INTO g_detail[l_ac].bgbc007_desc FROM glacl_t
      #    WHERE glaclent = g_enterprise AND glacl001 = g_bgaa008
      #      AND glacl002 = g_detail[l_ac].bgbc007 AND glacl003 = g_dlang
      #      
      #ELSE  #abgi040
      #   
      #   LET g_detail[l_ac].bgbc007_desc = s_abg_bgae001_desc(g_bgaa008,g_detail[l_ac].bgbc007)
      #END IF
      #LET g_detail[l_ac].bgbc003_desc = s_desc_get_department_desc(g_detail[l_ac].bgbc003)
      #160414-00018#40 mark-----e
      
      IF l_flag1 = '2' THEN
         LET g_detail[l_ac].bgae005 = ''
         LET g_detail[l_ac].bgbc007 = ''
         LET g_detail[l_ac].bgbc007_desc = ''
         LET g_detail[l_ac].bgbc006 = ''
         LET g_detail[l_ac].bgbc003 = ''
         #LET g_detail[l_ac].bgbc003_desc =  cl_getmsg('lib-00156',g_dlang)       #160414-00018#40 mark
         LET g_detail[l_ac].bgbc003_desc = l_msgstr                               #160414-00018#40 add
      END IF

      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point

 
   #add-point:陣列長度調整
   LET l_ac = l_ac - 1
  #CALL g_detail.deleteElement(g_detail.getLength())
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq040_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq040_detail_action_trans()
 
   CALL abgq040_b_fill2()
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
PRIVATE FUNCTION abgq040_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE abgq040_tmp
   CREATE TEMP TABLE abgq040_tmp(
      bgae005  VARCHAR(10), 
      bgbc007  VARCHAR(24), 
      bgbc006  SMALLINT, 
      bgbc003  VARCHAR(10),  
      bgbc008  DECIMAL(20,6),
      flag1    VARCHAR(1)
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
PRIVATE FUNCTION abgq040_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準

   #end add-point
   #add-point:fetch段define-客製

   #end add-point
 
   MESSAGE ""
 
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
 
   #add-point:fetch結束前

   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL abgq040_show()
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
PRIVATE FUNCTION abgq040_construct()
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
   #add-point:ui_dialog段define-標準
   DEFINE l_n       LIKE type_t.num5
   #end add-point
   #add-point:ui_dialog段define-客製

   #end add-point
 

 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT g_master.bgbc001,g_master.bgbc003,g_master.bgbc002,g_master.a 
           FROM b_bgbc001,b_bgbc003,b_bgbc002,a
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_master.a = '0'
               DISPLAY BY NAME g_master.a
               
            AFTER FIELD b_bgbc001
               IF NOT cl_null(g_master.bgbc001) THEN
                  #單獨檢查預算編號
                  CALL s_fin_budget_chk(g_master.bgbc001) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#23 --s add
                     LET g_errparam.replace[1] = 'abgi040'
                     LET g_errparam.replace[2] = cl_get_progname('abgi040',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi040'
                     #160321-00016#23 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbc001 = ''
                     LET g_master.bgbc001_desc = s_desc_get_budget_desc(g_master.bgbc001) 
                     DISPLAY BY NAME g_master.bgbc001,g_master.bgbc001_desc
                     NEXT FIELD CURRENT
                  END IF
                  CALL abgq040_bgbc001_visible()
                  CALL s_fin_abg_center_sons_query(g_master.bgbc001,'','')
                  IF NOT cl_null(g_master.bgbc003) THEN
                     CALL abgq040_ooef001_str()
                  END IF
                  LET g_master.bgbc001_desc = s_desc_get_budget_desc(g_master.bgbc001) 
                  DISPLAY BY NAME g_master.bgbc001,g_master.bgbc001_desc
               END IF

            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbc001
               #add-point:ON ACTION controlp INFIELD b_bgbc001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.bgbc001
               CALL q_bgbc001()
               LET g_master.bgbc001 = g_qryparam.return1
               LET g_master.bgbc001_desc = s_desc_get_budget_desc(g_master.bgbc001) 
               DISPLAY BY NAME g_master.bgbc001,g_master.bgbc001_desc
               CALL abgq040_bgbc001_visible()
               IF NOT cl_null(g_master.bgbc001) AND NOT cl_null(g_master.bgbc003) THEN
                  CALL abgq040_ooef001_str()
               END IF
               LET g_qryparam.where = ''
               NEXT FIELD b_bgbc001
               #END add-point
            
            AFTER FIELD b_bgbc003
               #檢查組織跟預算編號
               IF NOT cl_null(g_master.bgbc003) AND NOT cl_null(g_master.bgbc001)THEN
                  CALL s_abg_cre_bg_licence_chk(g_master.bgbc001,g_master.bgbc003,g_user)
                     RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbc003 = '' 
                     LET g_master.bgbc003_desc = s_desc_get_department_desc(g_master.bgbc003)
                     DISPLAY BY NAME g_master.bgbc003,g_master.bgbc003_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT cl_null(g_master.bgbc001) THEN
                     CALL abgq040_ooef001_str()
                     SELECT glaald INTO g_glaald FROM glaa_t
                      WHERE glaaent = g_enterprise AND glaacomp = g_master.bgbc003
                        AND glaa014 = 'Y'
                  END IF
               END IF


            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbc003
               #add-point:ON ACTION controlp INFIELD b_bgbc003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.bgbc003
               LET g_qryparam.where = " bgbc003 IN (SELECT ooef001 FROM s_fin_tmp1)"
               CALL q_bgbc003()
               LET g_master.bgbc003 = g_qryparam.return1
               LET g_master.bgbc003_desc = s_desc_get_department_desc(g_master.bgbc003)
               DISPLAY BY NAME g_master.bgbc003,g_master.bgbc003_desc
               IF NOT cl_null(g_master.bgbc001) AND NOT cl_null(g_master.bgbc003) THEN
                  CALL abgq040_ooef001_str()
               END IF
               LET g_qryparam.where = ''
               NEXT FIELD b_bgbc003
               #END add-point

            AFTER FIELD b_bgbc002
               IF NOT cl_null(g_master.bgbc002) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM bgbc_t 
                   WHERE bgbcent = g_enterprise AND bgbc002 = g_master.bgbc002
                  IF l_n = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     #LET g_errparam.code = 'abg-00105' #160318-00005#4 mark
                     LET g_errparam.code = 'sub-01308'  #160318-00005#4 add
                     LET g_errparam.extend = ''
                     #160318-00005#4 --s add
                     LET g_errparam.replace[1] = 'abgt025'
                     LET g_errparam.replace[2] = cl_get_progname('abgt025',g_lang,"2")
                     LET g_errparam.exeprog = 'abgt025'
                     #160318-00005#4 --e add
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD b_bgbc002
                  END IF
                  IF NOT cl_null(g_master.bgbc001) THEN
                     LET l_n = 0
                     SELECT COUNT(*) INTO l_n FROM bgbc_t 
                      WHERE bgbcent = g_enterprise AND bgbc002 = g_master.bgbc002
                        AND bgbc001 = g_master.bgbc001
                     IF l_n = 0 THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'abg-00106'
                        LET g_errparam.extend = ''
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                        NEXT FIELD b_bgbc002
                     END IF
                  END IF
               END IF
            
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbc002
               #add-point:ON ACTION controlp INFIELD b_bgbc002
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.bgbc002
               IF NOT cl_null(g_master.bgbc001) THEN
                  LET g_qryparam.where = " bgbc001 = '",g_master.bgbc001,"'"
               END IF
               CALL q_bgbc002()
               LET g_master.bgbc002 = g_qryparam.return1
               DISPLAY BY NAME g_master.bgbc002
               LET g_qryparam.where = ''
               NEXT FIELD b_bgbc002
               #END add-point
               
            ON CHANGE a
               IF NOT cl_null(g_master.bgbc001) AND NOT cl_null(g_master.bgbc003) THEN
                  CALL abgq040_ooef001_str()
               END IF
            AFTER INPUT
               IF NOT cl_null(g_master.bgbc001) AND NOT cl_null(g_master.bgbc003) THEN
                  CALL abgq040_ooef001_str()
               END IF
               
         END INPUT
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc2 ON b_bgae005,bgbc007
            BEFORE CONSTRUCT
 
            #Ctrlp:construct.c.b_bgbd001
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgae005
               #add-point:ON ACTION controlp INFIELD b_bgae005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         LET g_qryparam.arg1 = '9407'
               CALL q_gzcb002_01()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_bgae005 #顯示到畫面上
               
               NEXT FIELD b_bgae005                    #返回原欄位
               #END add-point
            
            #Ctrlp:construct.c.bgbc007
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD bgbc007
               #add-point:ON ACTION controlp INFIELD bgbc007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         LET g_qryparam.where = " bgbc001 = '",g_master.bgbc001,"'"
               #取借貸方向
               IF g_bgaa012 = 'Y' THEN  #agli020
                  LET g_qryparam.arg1=g_bgaa008
                  CALL q_bgbc007_1()
               ELSE  #abgbi040
                  CALL q_bgbc007()                   #呼叫開窗
               END IF
               DISPLAY g_qryparam.return1 TO bgbc007 #顯示到畫面上
               LET g_qryparam.where = ''
               
               NEXT FIELD bgbc007                   #返回原欄位
               #END add-point
            
            AFTER CONSTRUCT
               
         
         END CONSTRUCT
         #end add-point
          
         ON ACTION cancel
            LET INT_FLAG = 1
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
            #add-point:ON ACTION accept
            CALL abgq040_get_data()
            #end add-point
 
            CALL abgq040_cs()
            ACCEPT DIALOG
 
      
         #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      RETURN
   END IF

END FUNCTION

 
{</section>}
 
