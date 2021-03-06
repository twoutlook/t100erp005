#該程式未解開Section, 採用最新樣板產出!
{<section id="abgq045.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:9(2017-01-16 15:57:08), PR版次:0009(2017-01-19 09:58:56)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000059
#+ Filename...: abgq045
#+ Description: 預算試算平衡表
#+ Creator....: 02291(2015-08-25 14:03:21)
#+ Modifier...: 05016 -SD/PR- 06821
 
{</section>}
 
{<section id="abgq045.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160115-00010#1     2016/01/25 By Hans    映泰問題回追  取得bgbi值時沒有串入bgbi002 By carolwu
#160321-00016#23    2016/03/24 By Jessy   修正azzi920重複定義之錯誤訊息(sub)
#160120-00030#2     2016/03/30 By Hans    增加xg
#160425-00020#1     160428     By albireo 依SA需求調整 預算項目串科目
#160414-00018#41    160510     By albireo 效能優化
#161003-00014#10    2016/10/19 By Hans    修改不取 bgbh ,只取 bgbi 
#161006-00005#23    161026     By 08732   組織類型與職能開窗調整
#170112-00059#1     170123     By Hans    增加資料來源，終審的時候是bgbc
#161129-00019#10    170119     By 06821   預算組織權限,不卡 azzi800 有權限, 改call 元件s_abg2_get_budget_site(...);組織開窗原為查詢時開窗,改為新增時開窗
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
       bgbh001 LIKE bgbh_t.bgbh001, 
   bgbh001_desc LIKE type_t.chr80, 
   bgaa003 LIKE type_t.chr500, 
   bgbh005 LIKE type_t.chr500, 
   bgbh002 LIKE bgbh_t.bgbh002, 
   bgbi006 LIKE type_t.chr80, 
   bgbi006_1 LIKE type_t.num5, 
   bgae003 LIKE type_t.chr500, 
   bgbh003 LIKE bgbh_t.bgbh003, 
   bgbh003_desc LIKE type_t.chr80, 
   l_type LIKE type_t.chr500, 
   l_stus LIKE type_t.chr1, 
   a LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       bgbh004 LIKE bgbh_t.bgbh004, 
   bgbh004_desc LIKE type_t.chr500, 
   amt1 LIKE type_t.num20_6, 
   amt2 LIKE type_t.num20_6, 
   amt3 LIKE type_t.num20_6, 
   amt4 LIKE type_t.num20_6, 
   amt5 LIKE type_t.num20_6, 
   amt6 LIKE type_t.num20_6
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       bgbh004 LIKE bgbh_t.bgbh004, 
   bgbh004_1_desc LIKE type_t.chr500, 
   amt7 LIKE type_t.num20_6, 
   amt8 LIKE type_t.num20_6, 
   amt9 LIKE type_t.num20_6, 
   amt10 LIKE type_t.chr1, 
   amt11 LIKE type_t.num20_6, 
   bgbi007 LIKE type_t.chr500, 
   bgbi008 LIKE type_t.chr500, 
   bgbi009 LIKE type_t.chr500, 
   bgbi010 LIKE type_t.chr500, 
   bgbi011 LIKE type_t.chr500, 
   bgbi012 LIKE type_t.chr500, 
   bgbi013 LIKE type_t.chr500, 
   bgbi014 LIKE type_t.chr500, 
   bgbi015 LIKE type_t.chr500, 
   bgbi016 LIKE type_t.chr500, 
   bgbi039 LIKE type_t.chr500, 
   bgbi040 LIKE type_t.chr500, 
   bgbi041 LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaa009             LIKE bgaa_t.bgaa009
DEFINE g_bgaa008             LIKE bgaa_t.bgaa008
DEFINE g_bgaa012             LIKE bgaa_t.bgaa012
DEFINE g_bgaa006            LIKE bgaa_t.bgaa006

 TYPE type_g_detail3 RECORD
       
       bgbi004 LIKE bgbi_t.bgbi004
       END RECORD
 
DEFINE g_detail3            DYNAMIC ARRAY OF type_g_detail3 
DEFINE g_detail4            DYNAMIC ARRAY OF type_g_detail2  #160120-00030#2
#DEFINE g_userorga           STRING   #161006-00005#23   add #161129-00019#10 mark
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
 
{<section id="abgq045.main" >}
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
   DECLARE abgq045_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE abgq045_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE abgq045_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_abgq045 WITH FORM cl_ap_formpath("abg",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL abgq045_init()   
 
      #進入選單 Menu (="N")
      CALL abgq045_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_abgq045
      
   END IF 
   
   CLOSE abgq045_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="abgq045.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION abgq045_init()
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
   CALL cl_set_combo_scc('b_bgae003','9405')
   CALL cl_set_combo_scc('bgbi039','6013')
   CALL cl_set_combo_scc('amt10','9404')
   LET g_master.bgbi006_1 = ''
   DISPLAY BY NAME g_master.bgbi006_1 
   CALL s_fin_create_account_center_tmp()
   #161129-00019#10 --s mark
   ##161006-00005#23  add ---s
   #CALL s_fin_azzi800_sons_query(g_today)
   #CALL s_fin_account_center_sons_str() RETURNING g_userorga
   #CALL s_fin_get_wc_str(g_userorga) RETURNING g_userorga
   ##161006-00005#23  add ---e
   #161129-00019#10 --e mark 
   CALL abgq045_create_tmp()
   #end add-point
 
   CALL abgq045_default_search()
END FUNCTION
 
{</section>}
 
{<section id="abgq045.default_search" >}
PRIVATE FUNCTION abgq045_default_search()
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
 
{<section id="abgq045.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION abgq045_ui_dialog() 
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
   CALL abgq045_ui_dialog_1()
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
      CALL abgq045_cs()
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
 
         CALL abgq045_init()
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
               CALL abgq045_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq045_b_fill2()
 
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
            CALL abgq045_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            
            #end add-point
            NEXT FIELD bgbh001
 
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
 
            CALL abgq045_cs()
 
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
            CALL abgq045_fetch('F')
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
            CALL abgq045_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         
         
         
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
 
{<section id="abgq045.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION abgq045_cs()
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
 
   PREPARE abgq045_pre FROM g_sql
   DECLARE abgq045_curs SCROLL CURSOR WITH HOLD FOR abgq045_pre
   OPEN abgq045_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_wc2= cl_replace_str(g_wc2,'ooef001','bgbi004')
#   LET g_cnt_sql = " SELECT COUNT(UNIQUE bgbi004) FROM bgbh_t,bgbi_t ",
#                   "  WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
#                   "    AND bgbh002 = bgbi003 AND bgbh003 = bgbi004 ",
#                   "    AND bgbh004 = bgbi005 AND bgbh006 = '2' ",
#                   "    AND bgbhent = ",g_enterprise," AND bgbh001 ='",g_master.bgbh001,"'",
#                   "    AND bgbi006 >=",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
#                   "    AND bgbi004 IN",g_wc2 CLIPPED
   LET g_cnt_sql = " SELECT COUNT(UNIQUE ooef001) FROM ooef_t ",
                   "  WHERE ooefent = ",g_enterprise," AND ooef001 IN ",g_wc2 CLIPPED
   #end add-point
   PREPARE abgq045_precount FROM g_cnt_sql
   EXECUTE abgq045_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL abgq045_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="abgq045.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION abgq045_fetch(p_flag)
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
   CALL abgq045_fetch1(p_flag)
   RETURN
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_bgbh001,bgbh001_desc,b_bgaa003,b_bgbh005,b_bgbh002,b_bgbi006,bgbi006_1, 
          b_bgae003,b_bgbh003,bgbh003_desc,l_type,l_stus,a
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
   CALL abgq045_show()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq045.show" >}
PRIVATE FUNCTION abgq045_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_bgbh001,bgbh001_desc,b_bgaa003,b_bgbh005,b_bgbh002,b_bgbi006,bgbi006_1,b_bgae003, 
       b_bgbh003,bgbh003_desc,l_type,l_stus,a
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL abgq045_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="abgq045.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION abgq045_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL abgq045_b_fill1()
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
   CALL abgq045_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq045_detail_action_trans()
 
   CALL abgq045_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="abgq045.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION abgq045_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_sql1          STRING
   DEFINE l_sql2          STRING
   DEFINE l_wc1           STRING
   DEFINE l_bgbj033       LIKE bgbj_t.bgbj033
   DEFINE l_bgbi027_2     LIKE bgbi_t.bgbi027
   DEFINE l_bgbi027_1     LIKE bgbi_t.bgbi027
   DEFINE l_bgbi027_1_c   LIKE bgbi_t.bgbi027 #170112-00059#1
   DEFINE l_bgbi027_2_c   LIKE bgbi_t.bgbi027 #170112-00059#1
   DEFINE l_bgae002       LIKE bgae_t.bgae002
   DEFINE l_bgbh006       LIKE bgbh_t.bgbh006  
   #albireo 1604 #160425-00020#1-----s
   DEFINE l_wcstus        STRING
   #albireo 1604 #160425-00020#1-----e
   #160414-00018#41-----s
   DEFINE l_get_sql    RECORD       
                bgbi007 STRING,
                bgbi008 STRING,
                bgbi009 STRING,
                bgbi010 STRING,
                bgbi011 STRING,
                bgbi012 STRING,
                bgbi013 STRING,
                bgbi014 STRING,
                bgbi016 STRING,   
                bgbi015 STRING,
                bgbi040 STRING,
                bgbi041 STRING
                       END RECORD       
   DEFINE l_bgbi007 LIKE type_t.chr100
   DEFINE l_bgbi008 LIKE type_t.chr100
   DEFINE l_bgbi009 LIKE type_t.chr100
   DEFINE l_bgbi010 LIKE type_t.chr100
   DEFINE l_bgbi011 LIKE type_t.chr100
   DEFINE l_bgbi012 LIKE type_t.chr100
   DEFINE l_bgbi013 LIKE type_t.chr100
   DEFINE l_bgbi014 LIKE type_t.chr100
   DEFINE l_bgbi016 LIKE type_t.chr100   
   DEFINE l_bgbi015 LIKE type_t.chr100
   DEFINE l_bgbi040 LIKE type_t.chr100
   DEFINE l_bgbi041 LIKE type_t.chr100
   #160414-00018#41-----e
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"

   #160414-00018#41-----s
   #部门：        
    CALL s_fin_get_department_sql('ti07',g_enterprise,'bgbi007') RETURNING l_get_sql.bgbi007
   #成本利润中心：
    CALL s_fin_get_department_sql('ti08',g_enterprise,'bgbi008') RETURNING l_get_sql.bgbi008
   #区域：        
   CALL s_fin_get_acc_sql('ti09',g_enterprise,'287','bgbi009') RETURNING l_get_sql.bgbi009
   #交易客商      
   CALL s_fin_get_trading_partner_abbr_sql('ti10',g_enterprise,'bgbi010') RETURNING l_get_sql.bgbi010   
   #收款客商     
   CALL s_fin_get_trading_partner_abbr_sql('ti11',g_enterprise,'bgbi011') RETURNING l_get_sql.bgbi011
   #客群          
   CALL s_fin_get_acc_sql('ti12',g_enterprise,'281','bgbi012') RETURNING l_get_sql.bgbi012
   #产品类别      
   CALL s_fin_get_rtaxl003_sql('ti13',g_enterprise,'bgbi013') RETURNING l_get_sql.bgbi013
   #人员          
   CALL s_fin_get_person_sql('ti14',g_enterprise,'bgbi014') RETURNING l_get_sql.bgbi014
   #WBS           
   CALL s_fin_get_wbs_sql('ti16',g_enterprise,'bgbi015','bgbi016') RETURNING l_get_sql.bgbi016
   #专案编号      
   CALL s_fin_get_project_sql('ti15',g_enterprise,'bgbi015') RETURNING l_get_sql.bgbi015
   #渠道          
   CALL s_fin_get_oojdl003_sql('ti40',g_enterprise,'bgbi040') RETURNING l_get_sql.bgbi040
   #品牌          
   CALL s_fin_get_acc_sql('ti41',g_enterprise,'2002','bgbi041') RETURNING l_get_sql.bgbi041   
   #160414-00018#41-----e
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   IF l_ac = 0 THEN
      LET l_ac = 1
   END IF
   LET l_wc1 = ''
   #161003-00014#10---s---
   #albireo 1604 #160425-00020#1-----s
   #CASE
   #   WHEN g_master.l_stus = '1'
   #      LET l_wcstus = " bgbhstus IN ('Y','FC') "
   #   WHEN g_master.l_stus = '2'
   #      LET l_wcstus = " bgbhstus = 'N' "
   #   WHEN g_master.l_stus = '3'      
   #      LET l_wcstus = " bgbhstus <> 'X' "
   #END CASE
   #170112-00059#1---s---
   IF g_master.l_type = 1 THEN 
      LET l_wcstus = ' 1=1'
   ELSE
   #170112-00059#1---e---
      #albireo 1604 #160425-00020#1-----e   
      CASE
         WHEN g_master.l_stus = '1'
            LET l_wcstus = " bgbistus IN ('Y','FC') "
         WHEN g_master.l_stus = '2'
            LET l_wcstus = " bgbistus = 'N' "
         WHEN g_master.l_stus = '3'      
            LET l_wcstus = " bgbistus <> 'X' "
      END CASE
      #161003-00014#10---e---
   END IF #170112-00059#1
   CALL g_detail2.clear() #170112-00059#1
   #161003-00014#10---s--- 
   #發生額，若為本層，抓abgt020；若為匯總，抓abgt025
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",          
   #               "   AND bgbh006 = '1'"                  
   #              ,"   AND bgbh006=bgbi044",
   #              "    AND ",l_wcstus CLIPPED   #albireo 1604 #160425-00020#1
   #   LET l_bgbh006 = '1'   #160421-00005#1
   #ELSE  #匯總
   #   LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbh006 = '2'"
   #              ,"   AND bgbh006=bgbi044",
   #              "    AND ",l_wcstus CLIPPED   #albireo 1604 #160425-00020#1                 
   #   LET l_bgbh006 = '2'   #160421-00005#1
   #END IF
   #170112-00059#1 ---s--- mark
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t  ",
   #               " WHERE bgbient ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",          
   #               "   AND bgbi044 = '1' ",                  
   #               "   AND ",l_wcstus CLIPPED   
   #   LET l_bgbh006 = '1' 
   #ELSE  #匯總
   #   LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t  ",
   #               " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbi044 = '2'                    ",
   #               "    AND ",l_wcstus CLIPPED                    
   #   LET l_bgbh006 = '2'  
   #END IF
   #170112-00059#1 ----e---
   
   #170112-00059#1 ---s--- add
   IF g_master.l_type = '0' THEN
      LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t  ",
                  " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
                  "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
                  "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
                  "   AND bgbi044 = '2'                    ",
                  "    AND ",l_wcstus CLIPPED                    
      LET l_bgbh006 = '2'     
   ELSE
     LET l_sql1 = " SELECT SUM(bgbc008),SUM(bgbc009) FROM bgbc_t  ",
                  " WHERE bgbcent = ",g_enterprise," AND bgbc001 = '",g_master.bgbh001,"'",
                  "   AND bgbc003 = '",g_master.bgbh003,"' AND bgbc007 =? ",
                  "   AND bgbc002 = '",g_master.bgbh002,"' "        
   END IF   
   #170112-00059#1 --e---
   
   #161003-00014#10---e---
   
   #開賬金額，abgt040 
   LET l_sql2 = " SELECT SUM(bgbj033) FROM bgbj_t ",
               "  WHERE bgbjent = ",g_enterprise," AND bgbj001 = '",g_master.bgbh001,"'",
               "    AND bgbj002 = '",g_master.bgbh003,"'  AND bgbj003 = ?"
   #161003-00014#10---s---
   #LET l_sql = "SELECT DISTINCT bgbh004,",
   #            "               (SELECT th04.bgael003 FROM bgael_t th04 WHERE th04.bgaelent = ",g_enterprise,    #160414-00018#41
   #            "                   AND th04.bgael006 = '",g_bgaa008,"' AND th04.bgael001 = bgbh004 ",           #160414-00018#41
   #            "                   AND th04.bgael002 = '",g_dlang,"'  ), ",                                     #160414-00018#41               
   #            "       0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013,bgbi014,",
   #            "        bgbi015,bgbi016,bgbi039,bgbi040,bgbi041, ",
   #                     l_get_sql.bgbi007,",",   l_get_sql.bgbi008,",",   l_get_sql.bgbi009,",",   l_get_sql.bgbi010,",",
   #                     l_get_sql.bgbi011,",",   l_get_sql.bgbi012,",",   l_get_sql.bgbi013,",",   l_get_sql.bgbi014,",",
   #                     l_get_sql.bgbi016,",",   l_get_sql.bgbi015,",",   l_get_sql.bgbi040,",",   l_get_sql.bgbi041," ",
   #            "  FROM ",
   #            " (SELECT DISTINCT bgbh004,'',0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",
   #            "                  COALESCE(bgbi012,' ') bgbi012,COALESCE(bgbi013,' ') bgbi013,COALESCE(bgbi014,' ') bgbi014,",   #160421-00005#1 add COALESECE
   #            "                  COALESCE(bgbi015,' ') bgbi015,COALESCE(bgbi016,' ') bgbi016,COALESCE(bgbi039,' ') bgbi039,COALESCE(bgbi040,' ') bgbi040,COALESCE(bgbi041,' ') bgbi041 ",   #160421-00005#1 add COALESECE
   #            "   FROM bgbi_t,bgbh_t ",
   #            "  WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #            "    AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #            "    AND bgbh006 = '",l_bgbh006,"' ", #160421-00005#1
   #            "    AND bgbh001 = '",g_master.bgbh001,"' AND bgbh003 = '",g_master.bgbh003,"'",
   #            "    AND bgbh004 = '",g_detail[l_ac].bgbh004,"' AND bgbi006 >= ",g_master.bgbi006,
   #           "   AND bgbh002 = bgbi003 ",
   #           "   AND bgbh002 = '",g_master.bgbh002,"' ",   
   #            "    AND ",l_wcstus CLIPPED ,  #albireo 1604 #160425-00020#1
   #            "    AND bgbi006 <= ",g_master.bgbi006_1," AND bgbient = ",g_enterprise,
   #            " UNION ",
   #            " SELECT DISTINCT bgbj003 bgbh004,'',0,0,0,'',0,bgbj005 bgbi007,bgbj006 bgbi008,bgbj007 bgbi009,bgbj008 bgbi010,bgbj009 bgbi011,",
   #            "        bgbj010 bgbi012,bgbj011 bgbi013,bgbj012 bgbi014,",
   #            "        bgbj013 bgbi015,bgbj014 bgbi016,bgbj015 bgbi039,bgbj016 bgbi040,bgbj017 bgbi041 FROM bgbj_t ",
   #            "  WHERE bgbj001 = '",g_master.bgbh001,"' AND bgbj002 = '",g_master.bgbh003,"'",
   #            "    AND bgbj003 = '",g_detail[l_ac].bgbh004,"' AND bgbjent = ",g_enterprise,")"

   
   LET l_sql =" SELECT DISTINCT bgbi005,",
              "               (SELECT th04.bgael003 FROM bgael_t th04 WHERE th04.bgaelent = ",g_enterprise,    
              "                   AND th04.bgael006 = '",g_bgaa008,"' AND th04.bgael001 = bgbi005 ",           
              "                   AND th04.bgael002 = '",g_dlang,"'  ), ",                                                   
              "       0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013,bgbi014,",
              "        bgbi015,bgbi016,bgbi039,bgbi040,bgbi041, ",
                       l_get_sql.bgbi007,",",   l_get_sql.bgbi008,",",   l_get_sql.bgbi009,",",   l_get_sql.bgbi010,",",
                       l_get_sql.bgbi011,",",   l_get_sql.bgbi012,",",   l_get_sql.bgbi013,",",   l_get_sql.bgbi014,",",
                       l_get_sql.bgbi016,",",   l_get_sql.bgbi015,",",   l_get_sql.bgbi040,",",   l_get_sql.bgbi041," ",
              "  FROM ",
              " (SELECT DISTINCT bgbi005,'',0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",
              "                  COALESCE(bgbi012,' ') bgbi012,COALESCE(bgbi013,' ') bgbi013,COALESCE(bgbi014,' ') bgbi014,",   #160421-00005#1 add COALESECE
              "                  COALESCE(bgbi015,' ') bgbi015,COALESCE(bgbi016,' ') bgbi016,COALESCE(bgbi039,' ') bgbi039,COALESCE(bgbi040,' ') bgbi040,COALESCE(bgbi041,' ') bgbi041 ",   #160421-00005#1 add COALESECE
              "   FROM bgbi_t     "                                                            #170112-00059#1 del ,
              #"  WHERE bgbient = ",g_enterprise,"  AND bgbi044 = '",l_bgbh006,"' ",           #170112-00059#1
              #170112-00059#1---s---
              IF g_master.l_type = 0 THEN
                 LET l_sql = l_sql," WHERE bgbient = ",g_enterprise,"  AND bgbi044 = '",l_bgbh006,"' "
              ELSE
                 LET l_sql = l_sql," WHERE bgbient = ",g_enterprise,"    "
              END IF
              LET l_sql = l_sql,
              #170112-00059#1--e--              
              "    AND bgbi002 = '",g_master.bgbh001,"' AND bgbi004 = '",g_master.bgbh003,"'",
              "    AND bgbi005 = '",g_detail[l_ac].bgbh004,"' AND bgbi006 >= ",g_master.bgbi006,
              "    AND bgbi003 = '",g_master.bgbh002,"' ",   
              "    AND ",l_wcstus CLIPPED , 
              "    AND bgbi006 <= ",g_master.bgbi006_1," AND bgbient = ",g_enterprise,
              " UNION ",
              " SELECT DISTINCT bgbj003 bgbi005,'',0,0,0,'',0,bgbj005 bgbi007,bgbj006 bgbi008,bgbj007 bgbi009,bgbj008 bgbi010,bgbj009 bgbi011,",
              "        bgbj010 bgbi012,bgbj011 bgbi013,bgbj012 bgbi014,",
              "        bgbj013 bgbi015,bgbj014 bgbi016,bgbj015 bgbi039,bgbj016 bgbi040,bgbj017 bgbi041 FROM bgbj_t ",
              "  WHERE bgbj001 = '",g_master.bgbh001,"' AND bgbj002 = '",g_master.bgbh003,"'",
              "    AND bgbj003 = '",g_detail[l_ac].bgbh004,"' AND bgbjent = ",g_enterprise,")"
   #161003-00014#10---e---
   #170112-00059#1---s---
   IF g_master.l_type = 1 THEN
      LET l_sql = cl_replace_str(l_sql,'bgbi_t','bgbc_t')      
      LET l_sql = cl_replace_str(l_sql,'bgbient','bgbcent')      
      LET l_sql = cl_replace_str(l_sql,'bgbi002','bgbc001')    #預算編號
      LET l_sql = cl_replace_str(l_sql,'bgbi003','bgbc002')    #版本
      LET l_sql = cl_replace_str(l_sql,'bgbi004','bgbc003')    #預算組織
      LET l_sql = cl_replace_str(l_sql,'bgbi005','bgbc007')    #預算細項
      LET l_sql = cl_replace_str(l_sql,'bgbi006','bgbc006')    #預算期別
      LET l_sql = cl_replace_str(l_sql,'bgbi007','bgbc017')   
      LET l_sql = cl_replace_str(l_sql,'bgbi008','bgbc018')   
      LET l_sql = cl_replace_str(l_sql,'bgbi009','bgbc019')   
      LET l_sql = cl_replace_str(l_sql,'bgbi010','bgbc020')   
      LET l_sql = cl_replace_str(l_sql,'bgbi011','bgbc021')   
      LET l_sql = cl_replace_str(l_sql,'bgbi012','bgbc022')   
      LET l_sql = cl_replace_str(l_sql,'bgbi013','bgbc023')   
      LET l_sql = cl_replace_str(l_sql,'bgbi014','bgbc024')   
      LET l_sql = cl_replace_str(l_sql,'bgbi015','bgbc025')         
      LET l_sql = cl_replace_str(l_sql,'bgbi016','bgbc026')
      LET l_sql = cl_replace_str(l_sql,'bgbi039','bgbc027') #經營方式
      LET l_sql = cl_replace_str(l_sql,'bgbi040','bgbc028') #通路
      LET l_sql = cl_replace_str(l_sql,'bgbi041','bgbc040') #品牌
      LET l_sql = cl_replace_str(l_sql,'bgbi044','bgbc041') 
   END IF
   #170112-00059#1---e---
   PREPARE b_fill2_prep FROM l_sql
   DECLARE b_fill2_curs CURSOR FOR b_fill2_prep
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   FOREACH b_fill2_curs INTO g_detail2[li_ac].*,
           l_bgbi007,   l_bgbi008,   l_bgbi009,   l_bgbi010,
           l_bgbi011,   l_bgbi012,   l_bgbi013,   l_bgbi014,
           l_bgbi016,   l_bgbi015,   l_bgbi040,   l_bgbi041                           
                     
      LET l_wc1 = ''
      SELECT bgae002 INTO g_detail2[li_ac].amt10 FROM abgq045_tmp 
       WHERE bgbh004 = g_detail2[li_ac].bgbh004 AND bgbh001 = g_master.bgbh001
         AND bgbh003 = g_master.bgbh003
      
      IF NOT cl_null(g_detail2[li_ac].bgbi007) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi007 = '",g_detail2[li_ac].bgbi007,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi007 = '",g_detail2[li_ac].bgbi007,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi008) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi008 = '",g_detail2[li_ac].bgbi008,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi008 = '",g_detail2[li_ac].bgbi008,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi009) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi009 = '",g_detail2[li_ac].bgbi009,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi009 = '",g_detail2[li_ac].bgbi009,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi010) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi010 = '",g_detail2[li_ac].bgbi010,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi010 = '",g_detail2[li_ac].bgbi010,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi011) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi011 = '",g_detail2[li_ac].bgbi011,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi011 = '",g_detail2[li_ac].bgbi011,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi012) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi012 = '",g_detail2[li_ac].bgbi012,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi012 = '",g_detail2[li_ac].bgbi012,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi013) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi013 = '",g_detail2[li_ac].bgbi013,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi013 = '",g_detail2[li_ac].bgbi013,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi014) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi014 = '",g_detail2[li_ac].bgbi014,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi014 = '",g_detail2[li_ac].bgbi014,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi015) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi015 = '",g_detail2[li_ac].bgbi015,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi015 = '",g_detail2[li_ac].bgbi015,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi016) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi016 = '",g_detail2[li_ac].bgbi016,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi016 = '",g_detail2[li_ac].bgbi016,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi039) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi039 = '",g_detail2[li_ac].bgbi039,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi039 = '",g_detail2[li_ac].bgbi039,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi040) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi040 = '",g_detail2[li_ac].bgbi040,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi040= '",g_detail2[li_ac].bgbi040,"'"
         END IF
      END IF
      IF NOT cl_null(g_detail2[li_ac].bgbi041) THEN
         IF cl_null(l_wc1) THEN
            LET l_wc1 = " AND bgbi041 = '",g_detail2[li_ac].bgbi041,"'"
         ELSE
            LET l_wc1 = l_wc1 CLIPPED," AND bgbi041= '",g_detail2[li_ac].bgbi041,"'"
         END IF
      END IF
      
     ##往期余额
     #LET l_sql = l_sql1 CLIPPED,"   AND bgbi006 < ",g_master.bgbi006
     #IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
     #PREPARE abgi027_prep2 FROM l_sql
     #EXECUTE abgi027_prep2 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_1
     #
     ##发生额
     #LET l_sql = l_sql1 CLIPPED,"  AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1
     #IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
     #PREPARE abgi027_prep3 FROM l_sql
     #EXECUTE abgi027_prep3 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_2
      #170112-00059#1 ---s--- add
      IF g_master.l_type = 1 THEN
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi_t','bgbc_t')      
         LET l_wc1 = cl_replace_str(l_wc1,'bgbient','bgbcent')      
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi002','bgbc001')    #預算編號
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi003','bgbc002')    #版本
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi004','bgbc003')    #預算組織
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi005','bgbc007')    #預算細項
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi006','bgbc006')    #預算期別
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi007','bgbc017')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi008','bgbc018')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi009','bgbc019')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi010','bgbc020')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi011','bgbc021')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi012','bgbc022')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi013','bgbc023')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi014','bgbc024')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi015','bgbc025')         
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi016','bgbc026')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi039','bgbc027') #經營方式
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi040','bgbc028') #通路
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi041','bgbc040') #品牌
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi044','bgbc041') 
      END IF     
      IF g_master.l_type = '0' THEN
         #往期余额
         LET l_sql = l_sql1 CLIPPED,"   AND bgbi006 < ",g_master.bgbi006
         IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
         PREPARE abgi027_prep2 FROM l_sql
         EXECUTE abgi027_prep2 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_1
         
         #发生额
         LET l_sql = l_sql1 CLIPPED,"  AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1
         IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
         PREPARE abgi027_prep3 FROM l_sql
         EXECUTE abgi027_prep3 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_2
     ELSE
        #往期余额 /借/貸
        LET l_sql = l_sql1 CLIPPED,"   AND bgbc006 < ",g_master.bgbi006
        IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
        PREPARE abgi027_prep6 FROM l_sql
        EXECUTE abgi027_prep6 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_1,l_bgbi027_1_c
        
        #发生额 /借/貸
        LET l_sql = l_sql1 CLIPPED,"  AND bgbc006 >= ",g_master.bgbi006," AND bgbc006 <= ",g_master.bgbi006_1
        IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
        PREPARE abgi027_prep7 FROM l_sql
        EXECUTE abgi027_prep7 USING g_detail2[li_ac].bgbh004 INTO l_bgbi027_2,l_bgbi027_2_c
     END IF
     #170112-00059#1 ---s--- add           
      
      LET l_wc1= cl_replace_str(l_wc1,'b_bgbd003','bgbd003')
      #開賬金額，abgt040 
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi007','bgbj005')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi008','bgbj006')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi009','bgbj007')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi010','bgbj008')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi011','bgbj009')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi012','bgbj010')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi013','bgbj011')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi014','bgbj012')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi015','bgbj013')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi016','bgbj014')      
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi039','bgbj015')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi040','bgbj016')
      LET l_wc1 = cl_replace_str(l_wc1,'bgbi041','bgbj017')
      #170112-00059#1 ---s---
      IF g_master.l_type = 1 THEN
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc017','bgbj005')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc018','bgbj006')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc019','bgbj007')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc020','bgbj008')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc021','bgbj009')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc022','bgbj010')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc023','bgbj011')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc024','bgbj012')   
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc025','bgbj013')         
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc026','bgbj014')         
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc027','bgbj015') #經營方式
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc028','bgbj016') #通路
         LET l_wc1 = cl_replace_str(l_wc1,'bgbc040','bgbj017') #品牌
      END IF     
      #170112-00059#1 ---e---      
      #170112-00059#1---s--- mark
      #IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql2 CLIPPED,l_wc1 CLIPPED END IF
      #PREPARE bgbj033_prep1 FROM l_sql
      #EXECUTE bgbj033_prep1 USING g_detail2[li_ac].bgbh004 INTO l_bgbj033
      #170112-00059#1---e---
      #170112-00059#1---s---
      IF NOT cl_null(l_wc1) THEN       
         LET l_sql = l_sql2 CLIPPED,l_wc1 CLIPPED 
         PREPARE bgbj033_prep1 FROM l_sql
         EXECUTE bgbj033_prep1 USING g_detail2[li_ac].bgbh004 INTO l_bgbj033    
      ELSE     
         PREPARE bgbj033_prep3 FROM l_sql2
         EXECUTE bgbj033_prep3 USING g_detail2[li_ac].bgbh004 INTO l_bgbj033                    
      END IF              
      #170112-00059#1---e---
      
      IF cl_null(l_bgbj033) THEN LET l_bgbj033 = 0 END IF
      IF cl_null(l_bgbi027_1) THEN LET l_bgbi027_1 = 0 END IF
      IF cl_null(l_bgbi027_2) THEN LET l_bgbi027_2 = 0 END IF
      IF cl_null(l_bgbi027_1_c) THEN LET l_bgbi027_1_c = 0 END IF #170112-00059#1 
      IF cl_null(l_bgbi027_2_c) THEN LET l_bgbi027_2_c = 0 END IF #170112-00059#1
      #170112-00059#1 ---s---      mark
      #IF g_detail2[li_ac].amt10 = '1' THEN
      #   LET g_detail2[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
      #   LET g_detail2[li_ac].amt8 = l_bgbi027_2
      #   LET g_detail2[li_ac].amt9 = 0
      #ELSE
      #   LET g_detail2[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
      #   LET g_detail2[li_ac].amt8 = 0
      #   LET g_detail2[li_ac].amt9 = l_bgbi027_2
      #END IF
      #170112-00059#1 ---e---
      #170112-00059#1  ---s---
      IF g_master.l_type = '0' THEN # 編制
         IF g_detail2[li_ac].amt10 = '1' THEN
            LET g_detail2[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
            LET g_detail2[li_ac].amt8 = l_bgbi027_2
            LET g_detail2[li_ac].amt9 = 0
         ELSE
            LET g_detail2[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
            LET g_detail2[li_ac].amt8 = 0
            LET g_detail2[li_ac].amt9 = l_bgbi027_2
         END IF
      ELSE
         IF g_detail2[li_ac].amt10 = '1' THEN  #借方
            LET g_detail2[li_ac].amt7 =  l_bgbj033 + l_bgbi027_1   - l_bgbi027_1_c    #期初餘額
         ELSE
            LET g_detail2[li_ac].amt7 =  l_bgbj033 + l_bgbi027_1_c - l_bgbi027_1      #期初餘額
         END IF
         LET g_detail2[li_ac].amt8 = l_bgbi027_2   #借方發生額
         LET g_detail2[li_ac].amt9 = l_bgbi027_2_c #貸方發生額     
      END IF
      #170112-00059#1 
                 
      IF cl_null(g_detail2[li_ac].amt7) THEN LET g_detail2[li_ac].amt7 = 0 END IF
      IF cl_null(g_detail2[li_ac].amt8) THEN LET g_detail2[li_ac].amt8 = 0 END IF
      IF cl_null(g_detail2[li_ac].amt9) THEN LET g_detail2[li_ac].amt9 = 0 END IF
      IF cl_null(g_detail2[li_ac].amt11) THEN LET g_detail2[li_ac].amt11 = 0 END IF
      #期末餘額
      LET g_detail2[li_ac].amt11 = g_detail2[li_ac].amt7 + g_detail2[li_ac].amt8 + g_detail2[li_ac].amt9
     
     
      #160414-00018#41 mark-----s
      ##取借貸方向
      #IF g_bgaa012 = 'Y' THEN  #agli020
      #   
      #   SELECT glacl004 INTO g_detail2[li_ac].bgbh004_1_desc FROM glacl_t
      #    WHERE glaclent = g_enterprise AND glacl001 = g_bgaa008
      #      AND glacl002 = g_detail2[li_ac].bgbh004 AND glacl003 = g_dlang
      #      
      #ELSE  #abgi040
      #   
      #   LET g_detail2[li_ac].bgbh004_1_desc = s_abg_bgae001_desc(g_bgaa008,g_detail2[li_ac].bgbh004)
      #END IF
      #
      ##部门：        
      #LET g_detail2[li_ac].bgbi007 = s_desc_show1(g_detail2[li_ac].bgbi007,s_desc_get_department_desc(g_detail2[li_ac].bgbi007))
      ##成本利润中心：
      #LET g_detail2[li_ac].bgbi008 = s_desc_show1(g_detail2[li_ac].bgbi008,s_desc_get_department_desc(g_detail2[li_ac].bgbi008))
      ##区域：        
      #LET g_detail2[li_ac].bgbi009 = s_desc_show1(g_detail2[li_ac].bgbi009,s_desc_get_acc_desc('287',g_detail2[li_ac].bgbi009))
      ##交易客商      
      #LET g_detail2[li_ac].bgbi010 = s_desc_show1(g_detail2[li_ac].bgbi010,s_desc_get_trading_partner_abbr_desc(g_detail2[li_ac].bgbi010))
      ##收款客商     
      #LET g_detail2[li_ac].bgbi011 = s_desc_show1(g_detail2[li_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_detail2[li_ac].bgbi011))
      ##客群          
      #LET g_detail2[li_ac].bgbi012 = s_desc_show1(g_detail2[li_ac].bgbi012,s_desc_get_acc_desc('281',g_detail2[li_ac].bgbi012))
      ##产品类别      
      #LET g_detail2[li_ac].bgbi013 = s_desc_show1(g_detail2[li_ac].bgbi013,s_desc_get_rtaxl003_desc(g_detail2[li_ac].bgbi013))
      ##人员          
      #LET g_detail2[li_ac].bgbi014 = s_desc_show1(g_detail2[li_ac].bgbi014,s_desc_get_person_desc(g_detail2[li_ac].bgbi014))
      ##WBS           
      #LET g_detail2[li_ac].bgbi016 = s_desc_show1(g_detail2[li_ac].bgbi016,s_desc_get_pjbbl004_desc(g_detail2[li_ac].bgbi015,g_detail2[li_ac].bgbi016))
      ##专案编号      
      #LET g_detail2[li_ac].bgbi015 = s_desc_show1(g_detail2[li_ac].bgbi015,s_desc_get_project_desc(g_detail2[li_ac].bgbi015)) 
      ##渠道          
      #LET g_detail2[li_ac].bgbi040 = s_desc_show1(g_detail2[li_ac].bgbi040,s_desc_get_oojdl003_desc(g_detail2[li_ac].bgbi040))
      ##品牌          
      #LET g_detail2[li_ac].bgbi041 = s_desc_show1(g_detail2[li_ac].bgbi041,s_desc_get_acc_desc('2002',g_detail2[li_ac].bgbi041))
      ##160414-00018#41 mark-----e
      
      #160414-00018#41 add-----s     
      #部门：        
      LET g_detail2[li_ac].bgbi007 = s_desc_show1(g_detail2[li_ac].bgbi007,l_bgbi007)
      #成本利润中心：
      LET g_detail2[li_ac].bgbi008 = s_desc_show1(g_detail2[li_ac].bgbi008,l_bgbi008)
      #区域：        
      LET g_detail2[li_ac].bgbi009 = s_desc_show1(g_detail2[li_ac].bgbi009,l_bgbi009)
      #交易客商      
      LET g_detail2[li_ac].bgbi010 = s_desc_show1(g_detail2[li_ac].bgbi010,l_bgbi010)
      #收款客商     
      LET g_detail2[li_ac].bgbi011 = s_desc_show1(g_detail2[li_ac].bgbi011,l_bgbi011)
      #客群          
      LET g_detail2[li_ac].bgbi012 = s_desc_show1(g_detail2[li_ac].bgbi012,l_bgbi012)
      #产品类别      
      LET g_detail2[li_ac].bgbi013 = s_desc_show1(g_detail2[li_ac].bgbi013,l_bgbi013)
      #人员          
      LET g_detail2[li_ac].bgbi014 = s_desc_show1(g_detail2[li_ac].bgbi014,l_bgbi014)
      #WBS           
      LET g_detail2[li_ac].bgbi016 = s_desc_show1(g_detail2[li_ac].bgbi016,l_bgbi016)
      #专案编号      
      LET g_detail2[li_ac].bgbi015 = s_desc_show1(g_detail2[li_ac].bgbi015,l_bgbi015) 
      #渠道          
      LET g_detail2[li_ac].bgbi040 = s_desc_show1(g_detail2[li_ac].bgbi040,l_bgbi040)
      #品牌          
      LET g_detail2[li_ac].bgbi041 = s_desc_show1(g_detail2[li_ac].bgbi041,l_bgbi041)
      #160414-00018#41-----e
      LET li_ac  = li_ac + 1
   END FOREACH
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq045.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION abgq045_detail_show(ps_page)
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
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="abgq045.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION abgq045_maintain_prog()
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
 
   LET la_param.prog = "abgt025"
 
   LET la_param.param[1] = g_master.bgbh001
 
 
 
   IF NOT cl_null(la_param.prog) THEN
      LET ls_js = util.JSON.stringify(la_param)
      CALL cl_cmdrun_wait(ls_js)
   END IF
 
   #add-point:maintain_prog段結束前 name="maintain_prog.after"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="abgq045.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION abgq045_detail_action_trans()
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
 
{<section id="abgq045.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION abgq045_detail_index_setting()
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
 
{<section id="abgq045.mask_functions" >}
 &include "erp/abg/abgq045_mask.4gl"
 
{</section>}
 
{<section id="abgq045.other_function" readonly="Y" >}

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
PRIVATE FUNCTION abgq045_ui_dialog_1()
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
      CALL abgq045_cs()
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
 
         CALL abgq045_init()
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
               CALL abgq045_detail_action_trans()
               LET g_master_idx = l_ac
               CALL abgq045_b_fill2()
 
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
            CALL abgq045_fetch('')
 
            #add-point:ui_dialog段before dialog
            CALL abgq045_construct()
            CALL abgq045_fetch1('F')
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
##            CALL abgq045_ooef001_str()
##            CALL abgq045_set_page()
#           #CALL abgq045_get_data()
#            #end add-point
# 
#            CALL abgq045_cs()
 
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
            CALL abgq045_fetch('F')
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
            CALL abgq045_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL abgq045_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL abgq045_b_fill()
 
 
         #應用 a43 樣板自動產生(Version:2)
         #160120-00030#2  ---s---
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               IF cl_ask_confirm("abg-00126") THEN                
                 CALL abgq045_x01_ins()
                 CALL abgq045_x01('1=1','abgq045_x01_tmp')  
               ELSE
                 CALL abgq045_x02_ins()
                 CALL abgq045_x02('1=1','abgq045_x02_tmp') 
               END IF
               #END add-point
               
               
            END IF
         #160120-00030#2  ---e---
 
 
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
               
               CALL abgq045_init()
               CALL abgq045_construct()
               CALL abgq045_fetch1('F')  
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
            
            CALL abgq045_init()
               
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後

         #end add-point 
 
      END DIALOG 
   
   END WHILE
   
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
PRIVATE FUNCTION abgq045_bgbh001_desc()
   SELECT bgaa002,bgaa003,bgaa009,bgaa008,bgaa012,bgaa006                           #170112-00059#1  add bgaa006
     INTO g_master.bgbh005,g_master.bgaa003,g_bgaa009,g_bgaa008,g_bgaa012,g_bgaa006 #170112-00059#1  add bgaa006
     FROM bgaa_t
    WHERE bgaaent = g_enterprise
      AND bgaa001 = g_master.bgbh001
   DISPLAY g_master.bgbh005 TO b_bgbh005
   DISPLAY g_master.bgaa003 TO b_bgaa003
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
PRIVATE FUNCTION abgq045_ooef001_str()
   DEFINE ls_wc         STRING
   DEFINE l_sql         STRING
   DEFINE l_ooef001     LIKE ooef_t.ooef001
   DEFINE tok           base.StringTokenizer
   DEFINE l_str         STRING
   DEFINE l_site_str    STRING              #161129-00019#10 add
   
#   IF cl_null(g_master.bgbh001) THEN  
#      RETURN
#   END IF
#   DELETE FROM s_fin_tmp1

   #161129-00019#10 --s add
   #檢查預算組織是否在abgi090中可操作的組織中
   CALL s_abg2_get_budget_site(g_master.bgbh001,'',g_user,'07') RETURNING l_site_str
   CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
   #161129-00019#10 --e add 

   LET g_wc2= cl_replace_str(g_wc2,'b_bgbh003','ooef001')
   LET l_sql = " SELECT UNIQUE ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise," AND ",g_wc2 CLIPPED,
               #"    AND ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) "  #161129-00019#10 mark
               "    AND ooef001 IN ",l_site_str  #161129-00019#10 add
   PREPARE ooef001_prep FROM l_sql
   DECLARE ooef001_curs CURSOR FOR ooef001_prep
   
   LET g_wc2 = ''
   LET ls_wc = ''
   
   FOREACH ooef001_curs INTO l_ooef001
      #抓取預算組織資料
      IF g_master.a = '0' THEN
         IF cl_null(ls_wc)THEN
            LET ls_wc = l_ooef001 CLIPPED
         ELSE
            LET ls_wc = ls_wc CLIPPED,",",l_ooef001 CLIPPED,""
         END IF 
      ELSE
         CALL s_fin_abg_center_sons_query(g_master.bgbh001,l_ooef001,'N')
         #取得帳務組織下所有組織
         CALL s_fin_account_center_sons_str() RETURNING ls_wc 
      END IF
      #將取回的字串轉換為SQL條件
      #CALL s_fin_get_wc_str(ls_wc) RETURNING ls_wc
      WHENEVER ERROR CONTINUE
      LET tok = base.StringTokenizer.create(ls_wc,",")
      WHILE tok.hasMoreTokens()
         IF cl_null(l_str) THEN
            LET l_str = tok.nextToken()
         ELSE
            LET l_str = l_str,"','",tok.nextToken()
         END IF
      END WHILE
      
   END FOREACH
   LET g_wc2 = "('",l_str,"')"
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
PRIVATE FUNCTION abgq045_set_page()
   DEFINE li_idx      LIKE type_t.num5
   DEFINE l_sql       STRING
   
   LET li_idx = 1
#   LET l_sql = " SELECT UNIQUE bgbi004 FROM bgbh_t,bgbi_t ",
#                   "  WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
#                   "    AND bgbh002 = bgbi003 AND bgbh003 = bgbi004 ",
#                   "    AND bgbh004 = bgbi005 ",
#                   "    AND bgbhent = ",g_enterprise," AND bgbh001 ='",g_master.bgbh001,"'",
#                   "    AND bgbi006 >=",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
#                   "    AND bgbi004 IN",g_wc2 CLIPPED
                   
   LET l_sql = " SELECT UNIQUE ooef001 FROM ooef_t ",
               "  WHERE ooefent = ",g_enterprise," AND ooef001 IN ",g_wc2 CLIPPED
   
   PREPARE ooef001_page_prep FROM l_sql
   DECLARE ooef001_page_curs CURSOR FOR ooef001_page_prep
   FOREACH ooef001_page_curs INTO g_detail3[li_idx].bgbi004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'FOREACH aglq760_sel_s_cr'
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      LET li_idx = li_idx + 1
      IF li_idx > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 9035
         LET g_errparam.extend = ''
         LET g_errparam.popup = FALSE
         CALL cl_err()
       
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   LET li_idx=li_idx - 1
   CALL g_detail3.deleteElement(g_detail3.getLength())
   LET g_header_cnt = g_detail3.getLength()
  #LET g_rec_b = li_idx
   DISPLAY g_header_cnt TO FORMONLY.h_count
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
PRIVATE FUNCTION abgq045_get_data()
   DEFINE l_sql               STRING
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_n                 LIKE type_t.num5
   DEFINE l_bgbj033           LIKE bgbj_t.bgbj033
   DEFINE l_bgbi027           LIKE bgbi_t.bgbi027
   DEFINE l_bgbi027_c         LIKE bgbi_t.bgbi027 #170112-00059#1
   DEFINE l_bgbi027_1         LIKE bgbi_t.bgbi027
   DEFINE l_bgbi027_2         LIKE bgbi_t.bgbi027 #170112-00059#1
   DEFINE l_bgae001           LIKE bgae_t.bgae001
   DEFINE l_bgae002           LIKE bgae_t.bgae002
   DEFINE l_bgae038           LIKE bgae_t.bgae038
   DEFINE l_glac002           LIKE glac_t.glac002
   DEFINE l_amt1              LIKE type_t.num20_6
   DEFINE l_amt2              LIKE type_t.num20_6
   DEFINE l_amt3              LIKE type_t.num20_6
   DEFINE l_amt4              LIKE type_t.num20_6
   DEFINE l_amt5              LIKE type_t.num20_6
   DEFINE l_amt6              LIKE type_t.num20_6
   DEFINE l_bgbh003           LIKE bgbh_t.bgbh003
   DEFINE l_wc1               STRING
   #albireo 1604 #160425-00020#1-----s
   DEFINE l_wcstus        STRING
   #albireo 1604 #160425-00020#1-----e
   
   
   DELETE FROM abgq045_tmp
   #161003-00014#10 ---s---
   #albireo 1604 #160425-00020#1-----s
   #CASE
   #   WHEN g_master.l_stus = '1'
   #      LET l_wcstus = " bgbhstus IN ('Y','FC') "
   #   WHEN g_master.l_stus = '2'
   #      LET l_wcstus = " bgbhstus = 'N' "
   #   WHEN g_master.l_stus = '3'      
   #      LET l_wcstus = " bgbhstus <> 'X' "
   #END CASE
   #albireo 1604 #160425-00020#1-----e
   CASE
      WHEN g_master.l_stus = '1'
         LET l_wcstus = " bgbistus IN ('Y','FC') "
      WHEN g_master.l_stus = '2'
         LET l_wcstus = " bgbistus = 'N' "
      WHEN g_master.l_stus = '3'      
         LET l_wcstus = " bgbistus <> 'X' "
   END CASE
   #161003-00014#10 ---e---
   
   #開賬金額，abgt040 
   LET l_sql = " SELECT SUM(bgbj033) FROM bgbj_t ",
               "  WHERE bgbjent = ",g_enterprise," AND bgbj001 = '",g_master.bgbh001,"'",
               "    AND bgbj002 = '",g_master.bgbh003,"'  AND bgbj003 = ?"
              #"  GROUP BY bgbj003"
   PREPARE bgbj033_prep FROM l_sql
   
   #161003-00014#10 ---s---
   #發生額，若為本層，抓abgt020；若為匯總，抓abgt025
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbi006 < ",g_master.bgbi006,
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",   
   #               "    AND ",l_wcstus CLIPPED,   #albireo 1604 #160425-00020#1
   #               "   AND bgbh006 = '1'"
   #              ,"   AND bgbh006=bgbi044"   #160115-00010#1
   #              #"  GROUP BY bgbi005"
   #ELSE  #匯總
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbi006 < ",g_master.bgbi006,
   #               "    AND ",l_wcstus CLIPPED,   #albireo 1604 #160425-00020#1
   #               "   AND bgbh006 = '2'"
   #              ,"   AND bgbh006=bgbi044" #160115-00010#1
   #              #"  GROUP BY bgbi005"
   #END IF
   
   #170112-00059#1 ---s---  mark
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbi006 < ",g_master.bgbi006,
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",   
   #               "    AND ",l_wcstus CLIPPED,   
   #               "   AND bgbi044 = '1' "
   #              #"  GROUP BY bgbi005"
   #ELSE  #匯總
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t ",
   #               " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbi006 < ",g_master.bgbi006,
   #               "    AND ",l_wcstus CLIPPED,   #albireo 1604 #160425-00020#1
   #               "   AND bgbi044 = '2' "
   #              #"  GROUP BY bgbi005"
   #END IF
   #PREPARE bgbi027_prep1 FROM l_sql
   #170112-00059#1 ---s--- 
      
   
   #發生額，若為本層，抓abgt020；若為匯總，抓abgt025
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbh006 = '1'"
   #             , "    AND ",l_wcstus CLIPPED   #albireo 1604 #160425-00020#1
   #              ,"   AND bgbh006=bgbi044" #160115-00010#1
   #              #"  GROUP BY bgbi005"
   #ELSE  #匯總
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
   #               " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
   #               "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
   #               "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
   #               "   AND bgbh002 = bgbi003 ",
   #               "   AND bgbh002 = '",g_master.bgbh002,"' ",   
   #               "   AND bgbh006 = '2'"
   #              ,"    AND ",l_wcstus CLIPPED   #albireo 1604 #160425-00020#1
   #              ,"   AND bgbh006=bgbi044" #160115-00010#1
   #              #"  GROUP BY bgbi005"
   #END IF
   
   #170112-00059#1 ---s--- mark
   #IF g_master.a = '0' THEN  #本層
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t",
   #               " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
   #               "   AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
   #               "   AND bgbi044 = '1' ",
   #               "   AND ",l_wcstus CLIPPED   
   #ELSE  #匯總
   #   LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t  ",
   #               " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
   #               "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
   #               "   AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1,
   #               "   AND bgbi003 = '",g_master.bgbh002,"' ",   
   #               "   AND bgbi044 = '2' ",
   #               "    AND ",l_wcstus CLIPPED   #albireo 1604 #160425-00020#1
   #              #"  GROUP BY bgbi005"
   #END IF     
   #PREPARE bgbi027_prep FROM l_sql
   #170112-00059#1 ---e---    

   
   #160414-00018#41 mark-----s   
   ##根據項目編號的項目參照表，取現金類預算項目
   #IF g_bgaa012 = 'Y' THEN  #取agli020
   #   LET l_wc1 = ''
   #   IF g_master.bgae003 ='1' THEN
   #      LET l_wc1 = " glac007 IN ('1','2','3','4')"
   #   ELSE
   #      LET l_wc1 = " glac007 IN ('5','6')"
   #   END IF
   #   LET l_sql = " SELECT UNIQUE glac002,glac008 FROM glac_t ",
   #               "  WHERE glacent = ",g_enterprise," AND glac001 = '",g_bgaa008,"'",
   #               "    AND ",l_wc1 CLIPPED                  
   #ELSE  #abgi040
   #   LET l_sql = " SELECT bgae001,bgae002 FROM bgae_t",
   #               "  WHERE bgaeent = ",g_enterprise," AND bgae006 = '",g_bgaa008,"'",
   #               "    AND bgae003 = '",g_master.bgae003,"'"
   #END IF
   #PREPARE bgae_prep FROM l_sql
   #DECLARE bgae_curs CURSOR FOR bgae_prep
   ##160414-00018#41 mark-----e
   
   #170112-00059#1 ---s--- 終審取bgbc 編制取bgbi
   IF g_master. l_type = '0' THEN #編制 #期初
       LET l_sql = " SELECT SUM(bgbi027),'' FROM bgbi_t ",
                   " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
                   "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
                   "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
                  "    AND bgbi006 < ",g_master.bgbi006,"    ",
                   "   AND ",l_wcstus CLIPPED,  
                   "   AND bgbi044 = '2' "         
   ELSE   
      LET l_sql = " SELECT SUM(bgbc008),SUM(bgbc009) FROM bgbc_t ", #借方
                  " WHERE bgbcent = ",g_enterprise," AND bgbc001 = '",g_master.bgbh001,"'",
                  "   AND bgbc003 = '",g_master.bgbh003,"' AND bgbc007 =? ",
                  "   AND bgbc002 = '",g_master.bgbh002,"'  ",                     
                  "   AND bgbc006 < ",g_master.bgbi006,"   "
   END IF
   PREPARE bgbi027_prep1 FROM l_sql

   IF g_master. l_type = '0' THEN #編制
       LET l_sql = " SELECT SUM(bgbi027) FROM bgbi_t ",
                   " WHERE bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
                   "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
                   "   AND bgbi003 = '",g_master.bgbh002,"' ",                     
                  "    AND bgbi006 >= ",g_master.bgbi006,"  AND bgbi006 <= ",g_master.bgbi006_1,"  ",
                   "   AND ",l_wcstus CLIPPED,  
                   "   AND bgbi044 = '2' "       
   ELSE   
      LET l_sql = " SELECT SUM(bgbc008),SUM(bgbc009) FROM bgbc_t ", #貸方
                  " WHERE bgbcent = ",g_enterprise," AND bgbc001 = '",g_master.bgbh001,"'",
                  "   AND bgbc003 = '",g_master.bgbh003,"' AND bgbc007 =? ",
                  "   AND bgbc002 = '",g_master.bgbh002,"'  ",                     
                  "   AND bgbc006 >= ",g_master.bgbi006,"  AND bgbc006 <= ",g_master.bgbi006_1,"  "
   END IF
   PREPARE bgbi027_prep FROM l_sql      
   
   #170112-00059#1 ---e---            

   #160414-00018#41-----s
   LET l_sql = " INSERT INTO abgq045_tmp VALUES(?,?,?,?,?,?,?,?,?,?)"
   PREPARE instmp1p FROM l_sql
   
   LET l_sql = " SELECT bgae001,bgae002 ",
               "   FROM bgae_t",
               "  WHERE bgaeent = ",g_enterprise," AND bgae006 = '",g_bgaa008,"'"
               #"    AND bgae003 = '",g_master.bgae003,"'"   #170112-00059#1  mark
   #170112-00059#1 ---s---
   IF NOT cl_null(g_master.bgae003) THEN                            
      LET l_sql = l_sql ," AND bgae003 = '",g_master.bgae003,"' "
   END IF
   #170112-00059#1 ---e---
   PREPARE bgae_prep FROM l_sql
   DECLARE bgae_curs CURSOR FOR bgae_prep
   #160414-00018#41-----e

   
   FOREACH bgae_curs INTO l_bgae001,l_bgae002
     #開賬金額，abgt040 
     EXECUTE bgbj033_prep USING l_bgae001 INTO l_bgbj033 
     EXECUTE bgbi027_prep1 USING l_bgae001 INTO l_bgbi027_1,l_bgbi027_2  #小於起始月份的金額    add l_bgbi027_2
     IF cl_null(l_bgbj033) THEN LET l_bgbj033 = 0 END IF
     IF cl_null(l_bgbi027_1) THEN LET l_bgbi027_1 = 0 END IF
     
     #發生額，若為本層，抓abgt020；若為匯總，抓abgt025
     EXECUTE bgbi027_prep USING l_bgae001 INTO l_bgbi027,l_bgbi027_c #170112-00059#1  add  l_bgbi027_c  bgbc貸方金額
     IF cl_null(l_bgbi027_2) = 0 THEN LET l_bgbi027_2 = 0 END IF #170112-00059#1  
     IF cl_null(l_bgbi027_c) = 0 THEN LET l_bgbi027_c = 0 END IF #170112-00059#1  
     
     #170112-00059#1 ---s--- mark
     #IF l_bgae002 = '1' THEN
     #   LET l_amt1 = l_bgbj033 + l_bgbi027_1
     #   LET l_amt2 = 0
     #   LET l_amt3 = l_bgbi027
     #   LET l_amt4 = 0
     #ELSE
     #   LET l_amt1 = 0
     #   LET l_amt2 = l_bgbj033 + l_bgbi027_1
     #   LET l_amt3 = 0
     #   LET l_amt4 = l_bgbi027
     #END IF
     #170112-00059#1 ---e---
     #170112-00059#1---s---
     IF g_master.l_type = 0 THEN
        IF l_bgae002 = '1' THEN
           LET l_amt1 = l_bgbj033 + l_bgbi027_1 #期初借方
           LET l_amt2 = 0
           LET l_amt3 = l_bgbi027 
           LET l_amt4 = 0
        ELSE
           LET l_amt1 = 0
           LET l_amt2 = l_bgbj033 + l_bgbi027_1 #期初貸方
           LET l_amt3 = 0
           LET l_amt4 = l_bgbi027
        END IF
     ELSE
        IF l_bgae002 = '1' THEN
           LET l_amt1 = l_bgbj033 + l_bgbi027_1 
           LET l_amt2 = 0 + l_bgbi027_2
        ELSE
           LET l_amt1 = 0 + l_bgbi027_1 
           LET l_amt2 = l_bgbj033 + l_bgbi027_2        
        END IF
        LET l_amt3 = l_bgbi027
        LET l_amt4 = l_bgbi027_c
     END IF
     #170112-00059#1---e---
              
     IF cl_null(l_amt1) THEN LET l_amt1 = 0 END IF
     IF cl_null(l_amt2) THEN LET l_amt2 = 0 END IF
     IF cl_null(l_amt3) THEN LET l_amt3 = 0 END IF
     IF cl_null(l_amt4) THEN LET l_amt4 = 0 END IF
     IF cl_null(l_amt5) THEN LET l_amt5 = 0 END IF
     IF cl_null(l_amt6) THEN LET l_amt6 = 0 END IF
     #期末餘額
     LET l_amt5 = l_amt1 + l_amt3
     LET l_amt6 = l_amt2 + l_amt4
     
     #160414-00018#41 modify-----s
     #INSERT INTO abgq045_tmp VALUES(g_master.bgbh001,g_master.bgbh003,l_bgae001,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_bgae002)
     EXECUTE instmp1p USING g_master.bgbh001,g_master.bgbh003,l_bgae001,l_amt1,l_amt2,l_amt3,l_amt4,l_amt5,l_amt6,l_bgae002
     #160414-00018#41 modify-----e
   END FOREACH
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
PRIVATE FUNCTION abgq045_fetch1(p_flag)
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準

   #end add-point
   #add-point:fetch段define-客製

   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:2)
   #add-point:fetch段CURSOR移動
   

   #end add-point

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
   DISPLAY g_current_idx TO FORMONLY.h_index
   LET g_master.bgbh003 = g_detail3[g_current_idx].bgbi004
   LET g_master.bgbh003_desc = s_desc_get_department_desc(g_detail3[g_current_idx].bgbi004)
   CALL abgq045_get_data()
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL abgq045_show()
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
PRIVATE FUNCTION abgq045_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE abgq045_tmp
   CREATE TEMP TABLE abgq045_tmp(
      bgbh001         VARCHAR(10),
      bgbh003         VARCHAR(10),
      bgbh004         VARCHAR(24),
      amt1            DECIMAL(20,6),
      amt2            DECIMAL(20,6),
      amt3            DECIMAL(20,6),
      amt4            DECIMAL(20,6),
      amt5            DECIMAL(20,6),
      amt6            DECIMAL(20,6),
      bgae002         VARCHAR(1)
   )
   #160120-00030#2 ---s---
   DROP TABLE abgq045_x01_tmp;
      CREATE TEMP TABLE abgq045_x01_tmp(
         bgbh004_desc  VARCHAR(500), 
         amt1          DECIMAL(20,6), 
         amt2          DECIMAL(20,6), 
         amt3          DECIMAL(20,6), 
         amt4          DECIMAL(20,6), 
         amt5          DECIMAL(20,6), 
         amt6          DECIMAL(20,6),
         bgbh001_desc  VARCHAR(80),       #預算編號
         bgaa003       VARCHAR(500),      #預算幣別
         bgbh005       VARCHAR(500),      #預算週期
         a             VARCHAR(500),      #選項
         bgbh003_desc  VARCHAR(80),       #預算組織
         bgbi006       VARCHAR(80),       #預算期別
         bgae003       VARCHAR(500),      #資產損益別
         bgaeent       SMALLINT
         )
   #160120-00030#2 ---e---
      DROP TABLE abgq045_x02_tmp;
      CREATE TEMP TABLE abgq045_x02_tmp(
         bgbh004_desc  VARCHAR(500), 
         amt7  DECIMAL(20,6), 
         amt8  DECIMAL(20,6), 
         amt9  DECIMAL(20,6), 
         amt10  VARCHAR(500), 
         amt11  DECIMAL(20,6), 
         bgbi007  VARCHAR(500), 
         bgbi008  VARCHAR(500), 
         bgbi009  VARCHAR(500), 
         bgbi010  VARCHAR(500), 
         bgbi011  VARCHAR(500), 
         bgbi012  VARCHAR(500), 
         bgbi013  VARCHAR(500), 
         bgbi014  VARCHAR(500), 
         bgbi015  VARCHAR(500), 
         bgbi016  VARCHAR(500), 
         bgbi039  VARCHAR(500), 
         bgbi040  VARCHAR(500), 
         bgbi041  VARCHAR(500),
         bgbh001_desc  VARCHAR(80),       #預算編號
         bgaa003       VARCHAR(500),      #預算幣別
         bgbh005       VARCHAR(500),      #預算週期
         a             VARCHAR(500),      #選項
         bgbh003_desc  VARCHAR(80),       #預算組織
         bgbi006       VARCHAR(80),       #預算期別
         bgae003       VARCHAR(500)     #資產損益別         
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
PRIVATE FUNCTION abgq045_b_fill1()
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準
   DEFINE l_sql           STRING
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
   LET l_sql = " SELECT bgbh004,",
               "               (SELECT th04.bgael003 FROM bgael_t th04 WHERE th04.bgaelent = ",g_enterprise,    #160414-00018#41
               "                   AND th04.bgael006 = '",g_bgaa008,"' AND th04.bgael001 = bgbh004 ",           #160414-00018#41
               "                   AND th04.bgael002 = '",g_dlang,"'  ), ",                                     #160414-00018#41               
               "        amt1,amt2,amt3,amt4,amt5,amt6 FROM abgq045_tmp "
   PREPARE b_fill_prep FROM l_sql
   DECLARE b_fill_curs CURSOR FOR b_fill_prep
   #end add-point
 
 
 
 
   #add-point:b_fill段資料填充(其他單身)
   FOREACH b_fill_curs INTO g_detail[l_ac].*
   
      #160414-00018#41 mark-----s
      ##取借貸方向
      #IF g_bgaa012 = 'Y' THEN  #agli020
      #   
      #   SELECT glacl004 INTO g_detail[l_ac].bgbh004_desc FROM glacl_t
      #    WHERE glaclent = g_enterprise AND glacl001 = g_bgaa008
      #      AND glacl002 = g_detail[l_ac].bgbh004 AND glacl003 = g_dlang
      #      
      #ELSE  #abgi040
      #   
      #   LET g_detail[l_ac].bgbh004_desc = s_abg_bgae001_desc(g_bgaa008,g_detail[l_ac].bgbh004)
      #END IF
      #160414-00018#41 mark-----e
      
      LET l_ac = l_ac + 1
   END FOREACH
   #end add-point

   #add-point:陣列長度調整
   LET l_ac = l_ac - 1
   CALL g_detail.deleteElement(g_detail.getLength()) #160120-00030#2
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL abgq045_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL abgq045_detail_action_trans()
 
   CALL abgq045_b_fill2()
 
   
 
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
PRIVATE FUNCTION abgq045_construct()
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
   DEFINE l_n       LIKE type_t.num5 #161003-00014#10 
   #DEFINE l_orga    STRING   #161006-00005#23   add  #161129-00019#10 mark
   DEFINE l_site_str  STRING  #161129-00019#10 add

 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT g_master.bgbh001,g_master.a ,g_master.l_stus,g_master.bgbh002,g_master.l_type, #170112-00059#1  add l_type
               g_master.bgbh003 #161129-00019#10 add
           FROM b_bgbh001,a,l_stus,b_bgbh002,l_type,  #170112-00059#1  add l_type
                b_bgbh003  #161129-00019#10 add
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_master.a = '0'
               DISPLAY BY NAME g_master.a
               #albireo 1604 #160425-00020#1-----s
               LET g_master.l_stus = '1'
               DISPLAY BY NAME g_master.l_stus
               #albireo 1604 #160425-00020#1-----e
               LET g_master.l_type = 0  #170112-00059#1 
               
            AFTER FIELD b_bgbh001
               IF NOT cl_null(g_master.bgbh001) THEN
                  #單獨檢查預算編號
                  CALL s_fin_budget_chk(g_master.bgbh001) RETURNING g_sub_success,g_errno
                  IF NOT g_sub_success THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     #160321-00016#23 --s add
                     LET g_errparam.replace[1] = 'abgi010'
                     LET g_errparam.replace[2] = cl_get_progname('abgi010',g_lang,"2")
                     LET g_errparam.exeprog = 'abgi010'
                     #160321-00016#23 --e add
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.bgbh001 = ''
                     LET g_master.bgbh001_desc = s_desc_get_budget_desc(g_master.bgbh001) 
                     DISPLAY BY NAME g_master.bgbh001,g_master.bgbh001_desc
                     NEXT FIELD CURRENT
                  END IF
                  #161003-00014#10 ---s--- #170112-00059#1 ---s---mark
                  #LET l_n = 0 
                  #SELECT COUNT(1) INTO l_n FROM bgbi_t WHERE bgbient = g_enterprise AND bgbi002 = g_master.bgbh001
                  #IF cl_null(l_n) THEN LET l_n = 0 END  IF
                  #IF l_n = 0 THEN
                  #   INITIALIZE g_errparam TO NULL
                  #   LET g_errparam.code = 'abg-00178'
                  #   LET g_errparam.extend = ''
                  #   LET g_errparam.popup = TRUE
                  #   CALL cl_err()
                  #   LET g_master.bgbh001 = ''
                  #   LET g_master.bgbh001_desc = s_desc_get_budget_desc(g_master.bgbh001) 
                  #   DISPLAY BY NAME g_master.bgbh001,g_master.bgbh001_desc
                  #   NEXT FIELD CURRENT
                  #END IF
                  #161003-00014#10 ---e--- #170112-00059#1 ---e---
                  #CALL s_fin_abg_center_sons_query(g_master.bgbh001,'','')  #170112-00059#1 ---mark---
                  CALL abgq045_bgbh001_desc()
                  LET g_master.bgbh001_desc = s_desc_get_budget_desc(g_master.bgbh001) 
                  DISPLAY BY NAME g_master.bgbh001,g_master.bgbh001_desc
                  #170112-00059#1---s---
                  CALL cl_set_comp_entry('l_stus,l_type',TRUE)
                  IF g_bgaa006 = 1 THEN #預測
                     LET g_master.l_type = 1 #終審
                     CALL cl_set_comp_entry('l_stus,l_type',FALSE)                  
                  END IF             
                  #170112-00059#1---e---                  
               END IF

         #161129-00019#10 --s mark
         AFTER FIELD b_bgbh003
            IF NOT cl_null(g_master.bgbh003) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = g_master.bgbh003
               LET g_errshow = TRUE 
               LET g_chkparam.err_str[1] = "aoo-00095:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
               IF NOT cl_chk_exist("v_ooef001_24") THEN
                  #檢查失敗時後續處理
                  LET g_master.bgbh003 = ''
                  LET g_master.bgbh003_desc = s_desc_get_budget_desc(g_master.bgbh003) 
                  DISPLAY BY NAME g_master.bgbh003,g_master.bgbh003_desc
                  NEXT FIELD b_bgbh003
               END IF
               #檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_bgai004_chk(g_master.bgbh001,'',g_master.bgbh003,'07')
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_master.bgbh003 = ''
                  LET g_master.bgbh003_desc = s_desc_get_budget_desc(g_master.bgbh003) 
                  DISPLAY BY NAME g_master.bgbh003,g_master.bgbh003_desc              
                  NEXT FIELD b_bgbh003
               END IF
            END IF
            CALL s_desc_get_department_desc(g_master.bgbh003) RETURNING g_master.bgbh003_desc
            DISPLAY BY NAME g_master.bgbh003_desc
            LET g_wc2 = " b_bgbh003 = '",g_master.bgbh003,"'"
         #161129-00019#10 --e mark

            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_bgbh001
               #add-point:ON ACTION controlp INFIELD b_bgbh001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.bgbh001
               #LET g_qryparam.where = " bgaa001 IN (SELECT DISTINCT bgbi002 FROM bgbi_t WHERE bgbient = ",g_enterprise," )" #161003-00014#10 #170112-00059#1  ---mark---
               #CALL q_bgaa001()     #170112-00059#1 mark
               CALL q_bgaa001_1()    #170112-00059#1  add
               LET g_master.bgbh001 = g_qryparam.return1
               LET g_master.bgbh001_desc = s_desc_get_budget_desc(g_master.bgbh001) 
               DISPLAY BY NAME g_master.bgbh001,g_master.bgbh001_desc
               CALL abgq045_bgbh001_desc()
               DISPLAY BY NAME g_master.bgbh001
               LET g_qryparam.where = ''
               NEXT FIELD b_bgbh001
               
            #161129-00019#10 --s add
            ON ACTION controlp INFIELD b_bgbh003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.bgbh003  #給予default值
               #檢查預算組織是否在abgi090中可操作的組織中
               CALL s_abg2_get_budget_site(g_master.bgbh001,'',g_user,'07') RETURNING l_site_str
               CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
               LET g_qryparam.where = " ooef001 IN ",l_site_str                        
               CALL q_ooef001_77()
               LET g_master.bgbh003 = g_qryparam.return1
               DISPLAY BY NAME g_master.bgbh003
               NEXT FIELD b_bgbh003
            #161129-00019#10 --e add
               
               #END add-point
            #170112-00059#1---s---   
            ON CHANGE l_type
               CALL cl_set_comp_entry('l_stus',TRUE)
               IF g_master.l_type  ='1' THEN
                  CALL cl_set_comp_entry('l_stus',FALSE)
               END IF
            #170112-00059#1---e---
            AFTER INPUT
               
               
         END INPUT
         #end add-point
 
         #add-point:construct段落
         CONSTRUCT BY NAME g_wc2 ON b_bgbh003
            BEFORE CONSTRUCT
            #161129-00019#10 mark --s 
            ##Ctrlp:construct.c.b_bgbi004
            ##應用 a03 樣板自動產生(Version:2)
            #ON ACTION controlp INFIELD b_bgbh003
            #   #add-point:ON ACTION controlp INFIELD b_bgbh003
            #   #161129-00019#10 --s mark
            #   ##161006-00005#23  add----s
            #   #CALL s_fin_abg_center_sons_query(g_master.bgbh001,'','')
            #   #CALL s_fin_account_center_sons_str() RETURNING l_orga  
            #   #CALL s_fin_get_wc_str(l_orga) RETURNING l_orga
            #   ##161006-00005#23  add----e
            #   #161129-00019#10 --e mark
            #   INITIALIZE g_qryparam.* TO NULL
            #   #LET g_qryparam.state = 'c' #161129-00019#10 mark
            #   LET g_qryparam.state = 'i'  #161129-00019#10 add
		      #   LET g_qryparam.reqry = FALSE
		      #   #LET g_qryparam.where = " ooef001 IN (SELECT ooef001 FROM s_fin_tmp1) "        #161006-00005#23   mark
            #   #LET g_qryparam.where = " ooef001 IN ", g_userorga," AND ooef001 IN ", l_orga   #161006-00005#23   add #161129-00019#10 mark
            #   #161129-00019#10 --s add
            #   #檢查預算組織是否在abgi090中可操作的組織中
            #   CALL s_abg2_get_budget_site(g_master.bgbh001,'',g_user,'07') RETURNING l_site_str
            #   CALL s_fin_get_wc_str(l_site_str) RETURNING l_site_str
            #   LET g_qryparam.where = " ooef001 IN ",l_site_str               
            #   #161129-00019#10 --e add                
            #   #CALL q_ooef001()     #161006-00005#23   mark
            #   CALL q_ooef001_77()   #161006-00005#23   add
            #   DISPLAY g_qryparam.return1 TO b_bgbh003 #顯示到畫面上
            #   LET g_qryparam.where = ""
            #   
            #   NEXT FIELD b_bgbh003                    #返回原欄位
            #   #END add-point
            #161129-00019#10 mark --e 
            AFTER CONSTRUCT
               
         
         END CONSTRUCT
         #end add-point
     
         INPUT g_master.bgbi006,g_master.bgbi006_1,g_master.bgae003
           FROM b_bgbi006,bgbi006_1,b_bgae003
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_master.bgae003 = '1'
               LET g_master.bgbi006_1 = ''
               DISPLAY BY NAME g_master.bgae003,g_master.bgbi006_1 

            AFTER FIELD b_bgbi006
               IF (NOT cl_null(g_master.bgbi006)  AND g_master.bgbi006<> 0 ) AND (NOT cl_null(g_master.bgbi006_1) AND g_master.bgbi006_1<> 0) THEN
                  IF g_master.bgbi006>g_master.bgbi006_1 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00227'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      NEXT FIELD b_bgbi006
                  END IF
               END IF
            
            AFTER FIELD bgbi006_1
               IF (NOT cl_null(g_master.bgbi006_1)  AND g_master.bgbi006_1<> 0) AND (NOT cl_null(g_master.bgbi006)  AND g_master.bgbi006 <> 0 ) THEN
                  IF g_master.bgbi006>g_master.bgbi006_1 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'agl-00227'
                      LET g_errparam.extend = ''
                      LET g_errparam.popup = FALSE
                      CALL cl_err()
                      NEXT FIELD bgbi006_1
                  END IF
               END IF
               
            AFTER INPUT
               
               
         END INPUT

            
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
 
            CALL abgq045_ooef001_str()
            CALL abgq045_set_page()
            CALL abgq045_cs()
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

################################################################################
# Descriptions...: Insert print_tmp
# Memo...........:
# Usage..........: CALL abgq045_x01_ins()
# Date & Author..: 2016/03/30 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq045_x01_ins()
DEFINE l_i            LIKE type_t.num5
DEFINE l_bgbh004_desc LIKE type_t.chr80 
DEFINE l_bgbh001_desc LIKE type_t.chr80   #預算編號
DEFINE l_a_desc       LIKE type_t.chr80
DEFINE l_bgbh003_desc LIKE type_t.chr80
DEFINE l_bgae003_desc LIKE type_t.chr80
DEFINE l_bgbi006      LIKE type_t.chr80
     
   
   LET l_bgbh001_desc = '' LET l_bgbh003_desc ='' LET l_a_desc = ''
   LET l_bgbh001_desc = g_master.bgbh001,':',g_master.bgbh001_desc
   LET l_bgbh003_desc = g_detail3[g_current_idx].bgbi004,':',g_master.bgbh003_desc
   LET l_bgae003_desc = g_master.bgae003,':',s_desc_gzcbl004_desc('9405',g_master.bgae003)  
   LET l_bgbi006 = g_master.bgbi006||'-'||g_master.bgbi006_1
   IF g_master.a = 0 THEN
      SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd003 = 'cbo_a.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq045' #當前組織本級
   ELSE
      SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd003 = 'cbo_a.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq045'
   END IF

   DELETE FROM abgq045_x01_tmp
   FOR l_i = 1 TO g_detail.getLength()
      LET l_bgbh004_desc = ''      
      IF NOT cl_null(s_abg_bgae001_desc(g_bgaa008,g_detail[l_i].bgbh004)) THEN
         LET l_bgbh004_desc = g_detail[l_i].bgbh004,'.',s_abg_bgae001_desc(g_bgaa008,g_detail[l_i].bgbh004)
      ELSE
         LET l_bgbh004_desc = g_detail[l_i].bgbh004
      END IF
             
      INSERT INTO abgq045_x01_tmp
      VALUES(l_bgbh004_desc,g_detail[l_i].amt1,g_detail[l_i].amt2,g_detail[l_i].amt3,g_detail[l_i].amt4,
             g_detail[l_i].amt5,g_detail[l_i].amt6,l_bgbh001_desc,g_master.bgaa003,g_master.bgbh005, 
              l_a_desc,l_bgbh003_desc,l_bgbi006,l_bgae003_desc,g_enterprise  )
   END FOR

END FUNCTION

################################################################################
# Descriptions...: abgq045_x02_ins
# Memo...........:
# Usage..........: CALL abgq045_x02()
# Date & Author..: 2016/04/11 By Hans
# Modify.........:
################################################################################
PRIVATE FUNCTION abgq045_x02_ins()
DEFINE li_ac           LIKE type_t.num10
DEFINE l_sql           STRING
DEFINE l_sql1          STRING
DEFINE l_sql2          STRING
DEFINE l_wc1           STRING
DEFINE l_bgbj033       LIKE bgbj_t.bgbj033
DEFINE l_bgbi027_2     LIKE bgbi_t.bgbi027
DEFINE l_bgbi027_1     LIKE bgbi_t.bgbi027
DEFINE l_bgae002       LIKE bgae_t.bgae002 
DEFINE l_i             LIKE type_t.num5

DEFINE l_bgbh001_desc LIKE type_t.chr80   #預算編號
DEFINE l_bgbh003_desc LIKE type_t.chr80   #預算組織
DEFINE l_bgae003_desc LIKE type_t.chr80   #資產損益別
DEFINE l_bgbi006      LIKE type_t.chr80
DEFINE l_a_desc       LIKE type_t.chr80
DEFINE l_atm10        LIKE type_t.chr80
DEFINE l_bgbh004      LIKE type_t.chr80

   LET li_ac = 1 
   LET l_wc1 = ''   
  
   #發生額，若為本層，抓abgt020；若為匯總，抓abgt025
   IF g_master.a = '0' THEN  #本層
      LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
                  " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
                  "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
                  "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
                  "   AND bgbi004 = '",g_master.bgbh003,"'  AND bgbi005 =? ",
                  "   AND bgbh006 = '1'"
                 ,"   AND bgbh006=bgbi044"  
   ELSE  #匯總
      LET l_sql1 = " SELECT SUM(bgbi027) FROM bgbi_t,bgbh_t",
                  " WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
                  "   AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
                  "   AND bgbient = ",g_enterprise," AND bgbi002 = '",g_master.bgbh001,"'",
                  "   AND bgbi004 = '",g_master.bgbh003,"' AND bgbi005 =? ",
                  "   AND bgbh006 = '2'"
                 ,"   AND bgbh006=bgbi044" 
   END IF
   
   #開賬金額，abgt040 
   LET l_sql2 = " SELECT SUM(bgbj033) FROM bgbj_t ",
               "  WHERE bgbjent = ",g_enterprise," AND bgbj001 = '",g_master.bgbh001,"'",
               "    AND bgbj002 = '",g_master.bgbh003,"'  AND bgbj003 = ?"

   LET l_sql = "SELECT DISTINCT bgbh004,'',0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,bgbi012,bgbi013,bgbi014,",
               "        bgbi015,bgbi016,bgbi039,bgbi040,bgbi041 FROM ",
               " (SELECT DISTINCT bgbh004,'',0,0,0,'',0,bgbi007,bgbi008,bgbi009,bgbi010,bgbi011,",
               "                  COALESCE(bgbi012,' ') bgbi012,COALESCE(bgbi013,' ') bgbi013,COALESCE(bgbi014,' ') bgbi014,",   #160421-00005#1 add COALESECE
               "                  COALESCE(bgbi015,' ') bgbi015,COALESCE(bgbi016,' ') bgbi016,COALESCE(bgbi039,' ') bgbi039,COALESCE(bgbi040,' ') bgbi040,COALESCE(bgbi041,' ') bgbi041 ",   #160421-00005#1 add COALESECE
               " FROM bgbi_t,bgbh_t ",
               "  WHERE bgbhent = bgbient AND bgbh001 = bgbi002 ",
               "    AND bgbh003 = bgbi004 AND bgbh004 = bgbi005 ",
               "    AND bgbh001 = '",g_master.bgbh001,"' AND bgbh003 = '",g_master.bgbh003,"'",
               "    AND bgbh004 = ? AND bgbi006 >= ",g_master.bgbi006,
               "    AND bgbi006 <= ",g_master.bgbi006_1," AND bgbient = ",g_enterprise,
               " UNION ",
               " SELECT DISTINCT bgbj003 bgbh004,'',0,0,0,'',0,bgbj005 bgbi007,bgbj006 bgbi008,bgbj007 bgbi009,bgbj008 bgbi010,bgbj009 bgbi011,",
               "        bgbj010 bgbi012,bgbj011 bgbi013,bgbj012 bgbi014,",
               "        bgbj013 bgbi015,bgbj014 bgbi016,bgbj015 bgbi039,bgbj016 bgbi040,bgbj017 bgbi041 FROM bgbj_t ",
               "  WHERE bgbj001 = '",g_master.bgbh001,"' AND bgbj002 = '",g_master.bgbh003,"'",
               "    AND bgbj003 = '",g_detail[l_ac].bgbh004,"' AND bgbjent = ",g_enterprise,")"
   PREPARE b_fill2_prep2 FROM l_sql
   DECLARE b_fill2_curs2 CURSOR FOR b_fill2_prep2
                                                
   FOR l_i = 1 TO g_detail.getLength()      
      FOREACH b_fill2_curs2 USING g_detail[l_i].bgbh004 INTO g_detail4[li_ac].*
         LET l_wc1 = ''
         SELECT bgae002 INTO g_detail4[li_ac].amt10 FROM abgq045_tmp 
          WHERE bgbh004 = g_detail4[li_ac].bgbh004 AND bgbh001 = g_master.bgbh001
            AND bgbh003 = g_master.bgbh003
         
         IF NOT cl_null(g_detail4[li_ac].bgbi007) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi007 = '",g_detail4[li_ac].bgbi007,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi007 = '",g_detail4[li_ac].bgbi007,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi008) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi008 = '",g_detail4[li_ac].bgbi008,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi008 = '",g_detail4[li_ac].bgbi008,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi009) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi009 = '",g_detail4[li_ac].bgbi009,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi009 = '",g_detail4[li_ac].bgbi009,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi010) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi010 = '",g_detail4[li_ac].bgbi010,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi010 = '",g_detail4[li_ac].bgbi010,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi011) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi011 = '",g_detail4[li_ac].bgbi011,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi011 = '",g_detail4[li_ac].bgbi011,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi012) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi012 = '",g_detail4[li_ac].bgbi012,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi012 = '",g_detail4[li_ac].bgbi012,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi013) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi013 = '",g_detail4[li_ac].bgbi013,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi013 = '",g_detail4[li_ac].bgbi013,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi014) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi014 = '",g_detail4[li_ac].bgbi014,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi014 = '",g_detail4[li_ac].bgbi014,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi015) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi015 = '",g_detail4[li_ac].bgbi015,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi015 = '",g_detail4[li_ac].bgbi015,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi016) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi016 = '",g_detail4[li_ac].bgbi016,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi016 = '",g_detail4[li_ac].bgbi016,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi039) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi039 = '",g_detail4[li_ac].bgbi039,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi039 = '",g_detail4[li_ac].bgbi039,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi040) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi040 = '",g_detail4[li_ac].bgbi040,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi040= '",g_detail4[li_ac].bgbi040,"'"
            END IF
         END IF
         IF NOT cl_null(g_detail4[li_ac].bgbi041) THEN
            IF cl_null(l_wc1) THEN
               LET l_wc1 = " AND bgbi041 = '",g_detail4[li_ac].bgbi041,"'"
            ELSE
               LET l_wc1 = l_wc1 CLIPPED," AND bgbi041= '",g_detail4[li_ac].bgbi041,"'"
            END IF
         END IF
           
         #往期余额
         LET l_sql = l_sql1 CLIPPED,"   AND bgbi006 < ",g_master.bgbi006
         IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
         PREPARE abgi027_prep4 FROM l_sql
         EXECUTE abgi027_prep4 USING g_detail4[li_ac].bgbh004 INTO l_bgbi027_1
         
         #发生额
         LET l_sql = l_sql1 CLIPPED,"  AND bgbi006 >= ",g_master.bgbi006," AND bgbi006 <= ",g_master.bgbi006_1
         IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql CLIPPED,l_wc1 CLIPPED END IF
         PREPARE abgi027_prep5 FROM l_sql
         EXECUTE abgi027_prep5 USING g_detail4[li_ac].bgbh004 INTO l_bgbi027_2
         
         LET l_wc1= cl_replace_str(l_wc1,'b_bgbd003','bgbd003')
         #開賬金額，abgt040 
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi007','bgbj005')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi008','bgbj006')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi009','bgbj007')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi010','bgbj008')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi011','bgbj009')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi012','bgbj010')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi013','bgbj011')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi014','bgbj012')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi015','bgbj013')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi016','bgbj014')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi039','bgbj015')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi040','bgbj016')
         LET l_wc1 = cl_replace_str(l_wc1,'bgbi041','bgbj017')
         IF NOT cl_null(l_wc1) THEN LET l_sql = l_sql2 CLIPPED,l_wc1 CLIPPED END IF
         PREPARE bgbj033_prep2 FROM l_sql
         EXECUTE bgbj033_prep2 USING g_detail4[li_ac].bgbh004 INTO l_bgbj033
         
         IF cl_null(l_bgbj033) THEN LET l_bgbj033 = 0 END IF
         IF cl_null(l_bgbi027_1) THEN LET l_bgbi027_1 = 0 END IF
         IF cl_null(l_bgbi027_2) THEN LET l_bgbi027_2 = 0 END IF
         
         IF g_detail4[li_ac].amt10 = '1' THEN
            LET g_detail4[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
            LET g_detail4[li_ac].amt8 = l_bgbi027_2
            LET g_detail4[li_ac].amt9 = 0
         ELSE
            LET g_detail4[li_ac].amt7 = l_bgbj033 + l_bgbi027_1
            LET g_detail4[li_ac].amt8 = 0
            LET g_detail4[li_ac].amt9 = l_bgbi027_2
         END IF
         IF cl_null(g_detail4[li_ac].amt7) THEN LET g_detail4[li_ac].amt7 = 0 END IF
         IF cl_null(g_detail4[li_ac].amt8) THEN LET g_detail4[li_ac].amt8 = 0 END IF
         IF cl_null(g_detail4[li_ac].amt9) THEN LET g_detail4[li_ac].amt9 = 0 END IF
         IF cl_null(g_detail4[li_ac].amt11) THEN LET g_detail4[li_ac].amt11 = 0 END IF
         #期末餘額
         LET g_detail4[li_ac].amt11 = g_detail4[li_ac].amt7 + g_detail4[li_ac].amt8 + g_detail4[li_ac].amt9
        
         #取借貸方向
         IF g_bgaa012 = 'Y' THEN  #agli020
            
            SELECT glacl004 INTO g_detail4[li_ac].bgbh004_1_desc FROM glacl_t
             WHERE glaclent = g_enterprise AND glacl001 = g_bgaa008
               AND glacl002 = g_detail4[li_ac].bgbh004 AND glacl003 = g_dlang
               
         ELSE  #abgi040
            
            LET g_detail4[li_ac].bgbh004_1_desc = s_abg_bgae001_desc(g_bgaa008,g_detail4[li_ac].bgbh004)
         END IF
         
         #部门：        
         LET g_detail4[li_ac].bgbi007 = s_desc_show1(g_detail4[li_ac].bgbi007,s_desc_get_department_desc(g_detail4[li_ac].bgbi007))
         #成本利润中心：
         LET g_detail4[li_ac].bgbi008 = s_desc_show1(g_detail4[li_ac].bgbi008,s_desc_get_department_desc(g_detail4[li_ac].bgbi008))
         #区域：        
         LET g_detail4[li_ac].bgbi009 = s_desc_show1(g_detail4[li_ac].bgbi009,s_desc_get_acc_desc('287',g_detail4[li_ac].bgbi009))
         #交易客商      
         LET g_detail4[li_ac].bgbi010 = s_desc_show1(g_detail4[li_ac].bgbi010,s_desc_get_trading_partner_abbr_desc(g_detail4[li_ac].bgbi010))
         #收款客商     
         LET g_detail4[li_ac].bgbi011 = s_desc_show1(g_detail4[li_ac].bgbi011,s_desc_get_trading_partner_abbr_desc(g_detail4[li_ac].bgbi011))
         #客群          
         LET g_detail4[li_ac].bgbi012 = s_desc_show1(g_detail4[li_ac].bgbi012,s_desc_get_acc_desc('281',g_detail4[li_ac].bgbi012))
         #产品类别      
         LET g_detail4[li_ac].bgbi013 = s_desc_show1(g_detail4[li_ac].bgbi013,s_desc_get_rtaxl003_desc(g_detail4[li_ac].bgbi013))
         #人员          
         LET g_detail4[li_ac].bgbi014 = s_desc_show1(g_detail4[li_ac].bgbi014,s_desc_get_person_desc(g_detail4[li_ac].bgbi014))
         #WBS           
         LET g_detail4[li_ac].bgbi016 = s_desc_show1(g_detail4[li_ac].bgbi016,s_desc_get_pjbbl004_desc(g_detail4[li_ac].bgbi015,g_detail4[li_ac].bgbi016))
         #专案编号      
         LET g_detail4[li_ac].bgbi015 = s_desc_show1(g_detail4[li_ac].bgbi015,s_desc_get_project_desc(g_detail4[li_ac].bgbi015)) 
         #渠道          
         LET g_detail4[li_ac].bgbi040 = s_desc_show1(g_detail4[li_ac].bgbi040,s_desc_get_oojdl003_desc(g_detail4[li_ac].bgbi040))
         #品牌          
         LET g_detail4[li_ac].bgbi041 = s_desc_show1(g_detail4[li_ac].bgbi041,s_desc_get_acc_desc('2002',g_detail4[li_ac].bgbi041))
         LET li_ac  = li_ac + 1
      END FOREACH
   END FOR
   
   
   LET l_bgbh001_desc = '' LET l_bgbh003_desc ='' LET l_a_desc = ''
   LET l_bgbh001_desc = g_master.bgbh001,':',g_master.bgbh001_desc
   LET l_bgbh003_desc = g_detail3[g_current_idx].bgbi004,':',g_master.bgbh003_desc
   LET l_bgae003_desc = g_master.bgae003,':',s_desc_gzcbl004_desc('9405',g_master.bgae003)  
   LET l_bgbi006 = g_master.bgbi006||'-'||g_master.bgbi006_1
   IF g_master.a = 0 THEN
      SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd003 = 'cbo_a.1' AND gzzd002 = g_dlang AND gzzd001 = 'abgq045' #當前組織本級
   ELSE
      SELECT gzzd005 INTO l_a_desc FROM gzzd_t WHERE gzzd003 = 'cbo_a.2' AND gzzd002 = g_dlang AND gzzd001 = 'abgq045'
   END IF
   
   LET li_ac = li_ac - 1
   CALL g_detail4.deleteElement(g_detail4.getLength()) 
    
   DELETE FROM abgq045_x02_tmp
   FOR l_i = 1 TO li_ac
      LET l_atm10 ='' LET l_bgbh004 = ''
      LET l_atm10   = s_desc_show1(g_detail4[l_i].amt10,s_desc_gzcbl004_desc('9404',g_detail4[l_i].amt10))
      LET l_bgbh004 = s_desc_show1(g_detail4[l_i].bgbh004,g_detail4[l_i].bgbh004_1_desc)
      INSERT INTO abgq045_x02_tmp
      VALUES(l_bgbh004,
             g_detail4[l_i].amt7,g_detail4[l_i].amt8,g_detail4[l_i].amt9,l_atm10,g_detail4[l_i].amt11,
             g_detail4[l_i].bgbi007,g_detail4[l_i].bgbi008,g_detail4[l_i].bgbi009,g_detail4[l_i].bgbi010,
             g_detail4[l_i].bgbi011,g_detail4[l_i].bgbi012,g_detail4[l_i].bgbi013,g_detail4[l_i].bgbi014,
             g_detail4[l_i].bgbi015,g_detail4[l_i].bgbi016,g_detail4[l_i].bgbi039,g_detail4[l_i].bgbi040,
             g_detail4[l_i].bgbi041,
             l_bgbh001_desc,g_master.bgaa003,g_master.bgbh005,l_a_desc,l_bgbh003_desc,l_bgbi006,l_bgae003_desc)   
   END FOR
 
 
 
END FUNCTION

 
{</section>}
 
