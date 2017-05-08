#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq522.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-04-25 15:41:48), PR版次:0005(2016-11-18 11:23:09)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000031
#+ Filename...: axcq522
#+ Description: 在製調整成本查詢作業
#+ Creator....: 02040(2016-04-25 15:41:48)
#+ Modifier...: 02040 -SD/PR- 08993
 
{</section>}
 
{<section id="axcq522.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160617-00002#1   2016/06/23  By zhujing     增加串查
#160802-00020#4   2016/08/04  By dorislai    增加帳套權限管控
#160802-00020#10  2016/08/11  By dorislai    增加法人權限管控
#160727-00019#21  2016/08/12  By 08742       系统中定义的临时表名称超过15码在执行时会出错,所以需要将系统中定义的临时表长度超过15码的全部改掉	 	
#                                            Mod   axcq522_x01_temp --> axcq522_temp01
#161109-00085#25  2016/11/17  By 08993       整批調整系統星號寫法
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
       xccpld LIKE xccp_t.xccpld, 
   l_xccp004 LIKE type_t.num5, 
   l_xccp005 LIKE type_t.num5, 
   xccp001 LIKE xccp_t.xccp001, 
   xccpcomp_desc LIKE type_t.chr80, 
   xccpcomp LIKE xccp_t.xccpcomp, 
   l_xccp004_1 LIKE type_t.num5, 
   l_xccp005_1 LIKE type_t.num5, 
   xccp003 LIKE xccp_t.xccp003, 
   xccpld_desc LIKE type_t.chr80, 
   xccp003_desc LIKE type_t.chr80, 
   xccp001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   xccp004 LIKE xccp_t.xccp004, 
   xccp005 LIKE xccp_t.xccp005, 
   xccp002 LIKE xccp_t.xccp002, 
   xccp002_desc LIKE type_t.chr500, 
   sfaa068 LIKE sfaa_t.sfaa068, 
   sfaa068_desc LIKE type_t.chr500, 
   xccp007 LIKE xccp_t.xccp007, 
   sfaa010 LIKE type_t.chr500, 
   sfaa010_desc LIKE type_t.chr500, 
   sfaa010_desc_1 LIKE type_t.chr500, 
   imag011 LIKE imag_t.imag011, 
   imag011_desc LIKE type_t.chr500, 
   xccp006 LIKE xccp_t.xccp006, 
   xccp008 LIKE xccp_t.xccp008, 
   xccp009 LIKE xccp_t.xccp009, 
   xccp101 LIKE xccp_t.xccp101, 
   xccp102a LIKE xccp_t.xccp102a, 
   xccp102b LIKE xccp_t.xccp102b, 
   xccp102c LIKE xccp_t.xccp102c, 
   xccp102d LIKE xccp_t.xccp102d, 
   xccp102e LIKE xccp_t.xccp102e, 
   xccp102f LIKE xccp_t.xccp102f, 
   xccp102g LIKE xccp_t.xccp102g, 
   xccp102h LIKE xccp_t.xccp102h, 
   xccp102 LIKE xccp_t.xccp102
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_browser   DYNAMIC ARRAY OF RECORD
                  xccpcomp LIKE xccp_t.xccpcomp,
                  xccpld  LIKE xccp_t.xccpld,
                  xccp001 LIKE xccp_t.xccp001,
                  xccp003 LIKE xccp_t.xccp003
                  END RECORD
  
DEFINE g_defaule       LIKE type_t.num5
DEFINE g_wc_cs_ld            STRING                #160802-00020#4-add
DEFINE g_wc_cs_comp          STRING                #160802-00020#10-add
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
 
{<section id="axcq522.main" >}
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
   #160802-00020#4-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   #160802-00020#4-add-(E)
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  #160802-00020#10-add
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
   DECLARE axcq522_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq522_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq522_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq522 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq522_init()   
 
      #進入選單 Menu (="N")
      CALL axcq522_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq522
      
   END IF 
   
   CLOSE axcq522_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq522.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq522_init()
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
   CALL cl_set_combo_scc('xccp001','8914')
   CALL cl_set_combo_scc('b_xccp008','8919')
   CALL axcq522_set_comp_visible()
   CALL axcq522_set_comp_no_visible()     
   #end add-point
 
   CALL axcq522_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq522.default_search" >}
PRIVATE FUNCTION axcq522_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   #160617-00002#1 add-S
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xccpcomp = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xccpld = '", g_argv[02], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xccp004 = '", g_argv[03], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xccp005 = '", g_argv[04], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xccp003 = '", g_argv[05], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xccp007 = '", g_argv[06], "' AND "
   END IF
   #160617-00002#1 add-E
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
 
{<section id="axcq522.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq522_ui_dialog() 
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
   DEFINE l_para_data     LIKE type_t.chr80     #采用成本域否
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
    LET g_defaule = TRUE
    IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
       LET g_detail_idx = 1
       CALL axcq522_browser_fill()
    ELSE
       CALL axcq522_query()
    END IF
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL axcq522_cs()
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
 
         CALL axcq522_init()
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
               CALL axcq522_detail_action_trans()
               LET g_master_idx = l_ac
               CALL axcq522_b_fill2()
 
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
            CALL axcq522_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            NEXT FIELD b_xccp004
            #end add-point
            NEXT FIELD xccpcomp
 
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
 
            CALL axcq522_cs()
 
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
            CALL axcq522_fetch('F')
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
            CALL axcq522_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq522_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq522_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq522_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq522_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL axcq522_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL axcq522_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL axcq522_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL axcq522_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL axcq522_b_fill()
 
         
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
               CALL axcq522_x01_temp()
               CALL axcq522_ins_xg_temp()
               IF cl_null(g_master.xccpcomp) THEN
                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING l_para_data              #采用成本域否
               ELSE
                  CALL cl_get_para(g_enterprise,g_master.xccpcomp,'S-FIN-6001') RETURNING l_para_data   #采用成本域否
               END IF               
               CALL axcq522_x01("1 = 1","axcq522_temp01",l_para_data)       #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               CALL axcq522_x01_temp()
               CALL axcq522_ins_xg_temp()
               IF cl_null(g_master.xccpcomp) THEN
                  CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING l_para_data              #采用成本域否
               ELSE
                  CALL cl_get_para(g_enterprise,g_master.xccpcomp,'S-FIN-6001') RETURNING l_para_data   #采用成本域否
               END IF               
               CALL axcq522_x01("1 = 1","axcq522_temp01",l_para_data)       #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               LET g_defaule = TRUE
               CALL axcq522_query()
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq522_filter()            
            
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            CALL axcq522_query()
            #end add-point 
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point 
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq522.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION axcq522_cs()
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
 
   PREPARE axcq522_pre FROM g_sql
   DECLARE axcq522_curs SCROLL CURSOR WITH HOLD FOR axcq522_pre
   OPEN axcq522_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE axcq522_precount FROM g_cnt_sql
   EXECUTE axcq522_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL axcq522_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="axcq522.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION axcq522_fetch(p_flag)
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   LET g_sql = " SELECT DISTINCT xccpcomp,xccpld,xccp001,xccp003 ",
               "   FROM xccp_t,sfaa_t LEFT JOIN imag_t t1 ON t1.imagent = sfaaent AND t1.imagsite = sfaasite AND t1.imag001 = sfaa010",
               "   WHERE xccpent = sfaaent AND xccp007 = sfaadocno ", 
               "    AND ",g_wc2,
               "    AND xccpent = ? AND xccpcomp = ? AND xccpld = ? ",
               "    AND xccp001 = ? AND xccp003 = ?  "
   
   IF NOT cl_null(g_wc_filter) AND g_wc_filter <> ' 1=1' THEN
      LET g_sql = g_sql,"AND ",g_wc_filter
   END IF 
   LET g_sql = g_sql,"  ORDER BY xccpcomp,xccpld,xccp001,xccp003 "     
   
   
   PREPARE axcq522_fetch_pre FROM g_sql               
   #end add-point
 
   MESSAGE ""
 
   #FETCH段CURSOR移動
   #應用 qs18 樣板自動產生(Version:3)
   #add-point:fetch段CURSOR移動 name="fetch.cursor_action"
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_xccpld,l_xccp004,l_xccp005,b_xccp001,b_xccpcomp_desc,b_xccpcomp,l_xccp004_1, 
          l_xccp005_1,b_xccp003,b_xccpld_desc,b_xccp003_desc,b_xccp001_desc
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
   EXECUTE axcq522_fetch_pre USING g_enterprise,g_browser[g_current_idx].xccpcomp,g_browser[g_current_idx].xccpld,g_browser[g_current_idx].xccp001,
                                   g_browser[g_current_idx].xccp003
      INTO g_master.xccpcomp,g_master.xccpld,g_master.xccp001,g_master.xccp003

   FREE axcq522_fetch_pre

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "xccp_t"
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      INITIALIZE g_master.* TO NULL
      RETURN
   END IF      
   CALL axcq522_set_comp_visible()
   CALL axcq522_set_comp_no_visible()         
   DISPLAY BY NAME g_master.xccpcomp,g_master.xccpld,g_master.xccp001,g_master.xccp003
   DISPLAY g_master.l_xccp004 TO xccp004
   DISPLAY g_master.l_xccp004_1 TO xccp004_1
   DISPLAY g_master.l_xccp005 TO xccp005
   DISPLAY g_master.l_xccp005_1 TO xccp005_1          
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL axcq522_show()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq522.show" >}
PRIVATE FUNCTION axcq522_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020 
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_xccpld,l_xccp004,l_xccp005,b_xccp001,b_xccpcomp_desc,b_xccpcomp,l_xccp004_1, 
       l_xccp005_1,b_xccp003,b_xccpld_desc,b_xccp003_desc,b_xccp001_desc
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccpcomp
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccpcomp_desc = '', g_rtn_fields[1] , ''  
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccpld
   CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccpld_desc = '', g_rtn_fields[1] , ''   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.xccp003
   CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.xccp003_desc = '', g_rtn_fields[1] , ''

   SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
     FROM glaa_t
    WHERE glaaent = g_enterprise
      AND glaald  = g_master.xccpld      
      
   CASE g_master.xccp001
      WHEN '1' 
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa001
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xccp001_desc = '', g_rtn_fields[1] , ''               
      WHEN '2'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa016
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xccp001_desc = '', g_rtn_fields[1] , '' 
      WHEN '3'
        INITIALIZE g_ref_fields TO NULL
        LET g_ref_fields[1] = l_glaa020
        CALL ap_ref_array2(g_ref_fields,"SELECT ooail003 FROM ooail_t WHERE ooailent='"||g_enterprise||"' AND ooail001=? AND ooail002='"||g_dlang||"'","") RETURNING g_rtn_fields
        LET g_master.xccp001_desc = '', g_rtn_fields[1] , ''
   END CASE

   DISPLAY BY NAME g_master.xccpcomp_desc,g_master.xccpld_desc,g_master.xccp001_desc,g_master.xccp003_desc 
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL axcq522_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="axcq522.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq522_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_wc_filter     STRING
   DEFINE l_xccp101_total LIKE xccp_t.xccp101
   DEFINE l_xccp102_total LIKE xccp_t.xccp102 
   DEFINE l_xccp102a_total LIKE xccp_t.xccp102a 
   DEFINE l_xccp102b_total LIKE xccp_t.xccp102b
   DEFINE l_xccp102c_total LIKE xccp_t.xccp102c
   DEFINE l_xccp102d_total LIKE xccp_t.xccp102d
   DEFINE l_xccp102e_total LIKE xccp_t.xccp102e
   DEFINE l_xccp102f_total LIKE xccp_t.xccp102f
   DEFINE l_xccp102g_total LIKE xccp_t.xccp102g
   DEFINE l_xccp102h_total LIKE xccp_t.xccp102h
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
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
   LET l_xccp101_total  = 0                    
   LET l_xccp102_total  = 0                    
   LET l_xccp102a_total = 0                     
   LET l_xccp102b_total = 0                    
   LET l_xccp102c_total = 0                    
   LET l_xccp102d_total = 0                    
   LET l_xccp102e_total = 0                    
   LET l_xccp102f_total = 0                    
   LET l_xccp102g_total = 0                    
   LET l_xccp102h_total = 0                    
      
   LET g_sql = "SELECT '',xccp004,xccp005,xccp002,'', ",
               "       sfaa068,'', ",
               "       xccp007,sfaa010,'','',t1.imag011,",
               "       '',xccp006,xccp008,xccp009,xccp101,",
               "       xccp102a,xccp102b,xccp102c,xccp102d,xccp102e,",
               "       xccp102f,xccp102g,xccp102h,xccp102 ",
               "  FROM xccp_t,sfaa_t LEFT JOIN imag_t t1 ON t1.imagent = sfaaent AND t1.imagsite = sfaasite AND t1.imag001 = sfaa010",
               " WHERE xccpent = sfaaent AND xccp007 = sfaadocno ", 
               "   AND xccpent = ? AND xccpcomp = ? AND xccpld = ? ",
               "   AND xccp001 = ? AND xccp003 = ? AND ",g_wc2
               

   IF NOT cl_null(g_wc_filter) AND g_wc_filter <> ' 1=1' THEN
      LET g_sql = g_sql,"AND ",g_wc_filter
   END IF

   LET g_sql = g_sql," ORDER BY xccp004,xccp005,xccp002,xccp007 "
   
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq522_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq522_pb           
   
   OPEN b_fill_curs USING g_enterprise,g_browser[g_current_idx].xccpcomp,g_browser[g_current_idx].xccpld,g_browser[g_current_idx].xccp001,g_browser[g_current_idx].xccp003
   
   #161109-00085#25-s mod
#   FOREACH b_fill_curs INTO g_detail[l_ac].*   #161109-00085#25-s mark
   FOREACH b_fill_curs INTO g_detail[l_ac].sel,g_detail[l_ac].xccp004,g_detail[l_ac].xccp005,
                            g_detail[l_ac].xccp002,g_detail[l_ac].xccp002_desc,g_detail[l_ac].sfaa068,
                            g_detail[l_ac].sfaa068_desc,g_detail[l_ac].xccp007,g_detail[l_ac].sfaa010,
                            g_detail[l_ac].sfaa010_desc,g_detail[l_ac].sfaa010_desc,g_detail[l_ac].imag011,
                            g_detail[l_ac].imag011_desc,g_detail[l_ac].xccp006,g_detail[l_ac].xccp008,
                            g_detail[l_ac].xccp009,g_detail[l_ac].xccp101,g_detail[l_ac].xccp102a,
                            g_detail[l_ac].xccp102b,g_detail[l_ac].xccp102c,g_detail[l_ac].xccp102d,
                            g_detail[l_ac].xccp102e,g_detail[l_ac].xccp102f,g_detail[l_ac].xccp102g,
                            g_detail[l_ac].xccp102h,g_detail[l_ac].xccp102
   #161109-00085#25-e mod
                          
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err() 
         EXIT FOREACH
      END IF  

      LET l_xccp101_total  = l_xccp101_total  + g_detail[l_ac].xccp101                   
      LET l_xccp102_total  = l_xccp102_total  + g_detail[l_ac].xccp102                   
      LET l_xccp102a_total = l_xccp102a_total + g_detail[l_ac].xccp102a                    
      LET l_xccp102b_total = l_xccp102b_total + g_detail[l_ac].xccp102b                   
      LET l_xccp102c_total = l_xccp102c_total + g_detail[l_ac].xccp102c                   
      LET l_xccp102d_total = l_xccp102d_total + g_detail[l_ac].xccp102d                   
      LET l_xccp102e_total = l_xccp102e_total + g_detail[l_ac].xccp102e                   
      LET l_xccp102f_total = l_xccp102f_total + g_detail[l_ac].xccp102f                   
      LET l_xccp102g_total = l_xccp102g_total + g_detail[l_ac].xccp102g                   
      LET l_xccp102h_total = l_xccp102h_total + g_detail[l_ac].xccp102h                   
      CALL axcq522_detail_show("'1'")      
      LET l_ac = l_ac + 1
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
   END FOREACH

   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   # 合計
   IF g_detail.getLength() > 0 THEN
      LET g_detail[l_ac].imag011 = cl_getmsg("axc-00204",g_lang)
      LET g_detail[l_ac].xccp101  = l_xccp101_total                     
      LET g_detail[l_ac].xccp102  = l_xccp102_total                     
      LET g_detail[l_ac].xccp102a = l_xccp102a_total                      
      LET g_detail[l_ac].xccp102b = l_xccp102b_total                     
      LET g_detail[l_ac].xccp102c = l_xccp102c_total                     
      LET g_detail[l_ac].xccp102d = l_xccp102d_total                     
      LET g_detail[l_ac].xccp102e = l_xccp102e_total                     
      LET g_detail[l_ac].xccp102f = l_xccp102f_total                     
      LET g_detail[l_ac].xccp102g = l_xccp102g_total                     
      LET g_detail[l_ac].xccp102h = l_xccp102h_total         
   END IF   
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq522_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq522_detail_action_trans()
 
   CALL axcq522_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="axcq522.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq522_b_fill2()
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
 
{<section id="axcq522.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq522_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].xccp002
            LET ls_sql = "SELECT xcbfl003 FROM xcbfl_t WHERE xcbflent='"||g_enterprise||"' AND xcbfl001=? AND xcbfl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].xccp002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].xccp002_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].sfaa010
            LET ls_sql = "SELECT imaal003 FROM imaal_t WHERE imaalent='"||g_enterprise||"' AND imaal001=? AND imaal002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].sfaa010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].sfaa010_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].imag011
            LET ls_sql = "SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='206' AND oocql002=? AND oocql003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].imag011_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].imag011_desc
            
            CALL s_desc_get_department_desc(g_detail[l_ac].sfaa068) RETURNING g_detail[l_ac].sfaa068_desc            

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq522.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION axcq522_maintain_prog()
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
 
{<section id="axcq522.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq522_detail_action_trans()
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
 
{<section id="axcq522.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq522_detail_index_setting()
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
 
{<section id="axcq522.mask_functions" >}
 &include "erp/axc/axcq522_mask.4gl"
 
{</section>}
 
{<section id="axcq522.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 查詢
# Memo...........: 
# Usage..........: CALL axcq522_query()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160426 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_query()
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_xccpcomp LIKE xccp_t.xccpcomp
   DEFINE l_xccpcomp_desc LIKE ooefl_t.ooefl003
   DEFINE l_xccpld  LIKE xccp_t.xccpld
   DEFINE l_xccpld_desc   LIKE glaal_t.glaal003
   DEFINE l_xccp003 LIKE xccp_t.xccp003
   DEFINE l_xccp003_desc  LIKE xcatl_t.xcatl003 
   DEFINE ls_wc  STRING   
     

   LET INT_FLAG = 0
   LET g_detail_idx  = 1

   #wc備份
   LET ls_wc = g_wc
   LET g_master_idx = l_ac
   LET g_wc_filter  = ''  


   CLEAR FORM
   CALL g_detail.clear()
 
   
   INITIALIZE g_master TO NULL
     
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      CONSTRUCT g_wc ON xccpcomp,xccpld,xccp003,xccp001,xccp002,xccp007,sfaa010,imag011
         FROM xccpcomp,xccpld,xccp003,xccp001,s_detail1[1].b_xccp002,s_detail1[1].b_xccp007,s_detail1[1].b_sfaa010,s_detail1[1].b_imag011    
         
            BEFORE CONSTRUCT
              IF g_defaule AND g_master.xccpcomp IS NULL THEN
                 LET g_master.xccp001 = '1'
                 CALL s_axc_set_site_default() RETURNING g_master.xccpcomp,g_master.xccpld,g_master.l_xccp004,g_master.l_xccp005,g_master.xccp003
                 LET g_master.l_xccp004_1 = g_master.l_xccp004
                 LET g_master.l_xccp005_1 = g_master.l_xccp005
                 
                 CALL axcq522_show()
                 LET g_defaule = FALSE
                 DISPLAY BY NAME g_master.xccpcomp,g_master.xccpld,g_master.xccp001,g_master.xccp003        
                 DISPLAY g_master.l_xccp004 TO xccp004
                 DISPLAY g_master.l_xccp004_1 TO xccp004_1
                 DISPLAY g_master.l_xccp005 TO xccp005
                 DISPLAY g_master.l_xccp005_1 TO xccp005_1                   
              END IF   
                
            AFTER FIELD xccpcomp
               LET l_xccpcomp = GET_FLDBUF(xccpcomp)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccpcomp
               CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccpcomp_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xccpcomp_desc TO FORMONLY.xccpcomp_desc
   
             AFTER FIELD xccpld
               LET l_xccpld = GET_FLDBUF(xccpld)
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccpld
               CALL ap_ref_array2(g_ref_fields,"SELECT glaal002 FROM glaal_t WHERE glaalent='"||g_enterprise||"' AND glaalld=? AND glaal001='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccpld_desc = '', g_rtn_fields[1] , ''
               DISPLAY  l_xccpld_desc TO FORMONLY.xccpld_desc
               
              
            AFTER FIELD xccp003  
               LET l_xccp003 = GET_FLDBUF(xccp003)            
               INITIALIZE g_ref_fields TO NULL
               LET g_ref_fields[1] = l_xccp003
               CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
               LET l_xccp003_desc = '', g_rtn_fields[1] , ''
               DISPLAY l_xccp003_desc TO FORMONLY.xccp003_desc 
               
            ON ACTION controlp INFIELD xccpcomp
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               #160802-00020#10-add-(S)
               #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #160802-00020#10-add-(E)
               CALL q_ooef001_2()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccpcomp       #顯示到畫面上
               NEXT FIELD xccpcomp                          #返回原欄位
               
            ON ACTION controlp INFIELD xccpld
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept   
               #160802-00020#4-add-(S)
               IF NOT cl_null(g_wc_cs_ld) THEN
                  LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
               END IF
               #160802-00020#4-add-(E)               
               CALL q_authorised_ld()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccpld         #顯示到畫面上
               NEXT FIELD xccpld                            #返回原欄位
                           
            ON ACTION controlp INFIELD xccp003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcat001()                             #呼叫開窗
               DISPLAY g_qryparam.return1 TO xccp003        #顯示到畫面上
               NEXT FIELD xccp003                           #返回原欄位
 
               
            ON ACTION controlp INFIELD b_xccp002      
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcbf001()                       
               DISPLAY g_qryparam.return1 TO b_xccp002  
               NEXT FIELD b_xccp002                     

            ON ACTION controlp INFIELD b_sfaa010   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                       
               DISPLAY g_qryparam.return1 TO b_sfaa010  
               NEXT FIELD b_sfaa010                     
               
            ON ACTION controlp INFIELD b_xccp007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno()                     
               DISPLAY g_qryparam.return1 TO b_xccp007
               NEXT FIELD b_xccp007               

            ON ACTION controlp INFIELD b_imag011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imag011()                          
               DISPLAY g_qryparam.return1 TO b_imag011  
               NEXT FIELD b_imag011                     

    
         AFTER CONSTRUCT 
            CONTINUE DIALOG
   
       END CONSTRUCT
  
       INPUT g_master.l_xccp004,g_master.l_xccp005,g_master.l_xccp004_1,g_master.l_xccp005_1
          FROM xccp004,xccp005,xccp004_1,xccp005_1
          
          AFTER FIELD xccp004 
             IF NOT cl_null(g_master.l_xccp004) AND NOT cl_null(g_master.l_xccp004_1) THEN
                 IF g_master.l_xccp004 > g_master.l_xccp004_1 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00064'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD xccp004
                 END IF
              END IF
          AFTER FIELD xccp005
             IF NOT cl_null(g_master.l_xccp005) AND NOT cl_null(g_master.l_xccp005_1) THEN
                IF g_master.l_xccp004 = g_master.l_xccp004_1 AND g_master.l_xccp005 > g_master.l_xccp005_1 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00067'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccp005
                END IF
             END IF
          AFTER FIELD xccp004_1
             IF NOT cl_null(g_master.l_xccp004) AND NOT cl_null(g_master.l_xccp004_1) THEN
                 IF g_master.l_xccp004 > g_master.l_xccp004_1 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'acr-00064'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    NEXT FIELD xccp004_1
                 END IF
              END IF
          AFTER FIELD xccp005_1   
             IF NOT cl_null(g_master.l_xccp005) AND NOT cl_null(g_master.l_xccp005_1) THEN
                IF g_master.l_xccp004 = g_master.l_xccp004_1 AND g_master.l_xccp005 > g_master.l_xccp005_1 THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = 'acr-00067'
                   LET g_errparam.extend = ''
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
                   NEXT FIELD xccp005_1
                END IF
             END IF                 
       END INPUT    
            

      BEFORE DIALOG
         CALL cl_qbe_init()
        #加上合計功能後無法查詢，需重新DISPLAY所有頁籤
         LET g_detail[1].xccp004 = ""         
         DISPLAY ARRAY g_detail TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY

      ON ACTION accept
         IF cl_null(g_master.l_xccp004) THEN
            NEXT FIELD l_xccp004
         END IF
         IF cl_null(g_master.l_xccp004_1) THEN
            NEXT FIELD l_xccp004_1
         END IF
         IF cl_null(g_master.l_xccp005) THEN
            NEXT FIELD l_xccp005
         END IF
         IF cl_null(g_master.l_xccp005_1) THEN
            NEXT FIELD l_xccp005_1
         END IF     
         LET g_master_t.* = g_master.*    
         LET g_wc_t = g_wc         
         CALL axcq522_browser_fill()   
         EXIT DIALOG

       ON ACTION close      #在dialog button (放棄)
          LET INT_FLAG = 1
          EXIT DIALOG
      
       ON ACTION exit       #toolbar 離開 
          LET INT_FLAG = 1
          EXIT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
       &include "common_action.4gl"
         CONTINUE DIALOG   
   
   END DIALOG  
   
END FUNCTION
################################################################################
# Descriptions...: 單頭資料顯示
# Memo...........:
# Usage..........: CALL axcq522_browser_fill()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160426 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_browser_fill()

   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   DEFINE l_searchcol       STRING  

   #清除畫面
   CLEAR FORM            
 
   CALL g_browser.clear()
   CALL g_detail.clear()
   
 
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF   
   
   LET g_wc = cl_replace_str(g_wc,'b_xccp002','xccp002')
   LET g_wc = cl_replace_str(g_wc,'b_xccp007','xccp007')
   LET g_wc = cl_replace_str(g_wc,'b_sfaa010','sfaa010')
   LET g_wc = cl_replace_str(g_wc,'b_imag011','imag011')   
   
   
   LET g_wc = g_wc," AND (xccp004*12+xccp005 BETWEEN ",g_master.l_xccp004,"*12+",g_master.l_xccp005," AND ",g_master.l_xccp004_1,"*12+",g_master.l_xccp005_1,")"
   
   
   
   LET g_wc2 = g_wc.trim()  
   
   LET l_sub_sql = " SELECT DISTINCT xccpcomp,xccpld,xccp001,xccp003 ",
                   "   FROM xccp_t,sfaa_t LEFT JOIN imag_t t1 ON t1.imagent = sfaaent AND t1.imagsite = sfaasite AND t1.imag001 = sfaa010",
                   "  WHERE xccpent = sfaaent AND xccp007 = sfaadocno ", 
                   "    AND ",g_wc2,
                   "    AND xccpent = ",g_enterprise                
 
   IF NOT cl_null(g_wc_filter) AND g_wc_filter <> ' 1=1' THEN
      LET l_sub_sql = l_sub_sql,"AND ",g_wc_filter
   END IF 
   #160802-00020#4-add-(S)
   #---增加帳號權限
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql , " AND xccpld IN ",g_wc_cs_ld
    END IF
   #160802-00020#4-add-(E)
   #160802-00020#10-add-(S)
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql," AND xccpcomp IN ",g_wc_cs_comp
   END IF
   #160802-00020#10-add-(E)
   LET l_sub_sql = l_sub_sql,"  ORDER BY xccpcomp,xccpld,xccp001,xccp003 "   
   LET g_sql = l_sub_sql
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre

   LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].xccpcomp,g_browser[g_cnt].xccpld,g_browser[g_cnt].xccp001,g_browser[g_cnt].xccp003
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
   LET g_tot_cnt = g_browser.getLength()
   LET g_row_count = g_cnt - 1  
   IF g_row_count = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code   = "-100"
      LET g_errparam.popup  = FALSE
      CALL cl_err()      
      LET g_master.* = g_master_t.*
   ELSE      
      CALL axcq522_fetch('F')      
   END IF 
END FUNCTION
################################################################################
# Descriptions...: 控制欄位顯示
# Memo...........:
# Usage..........: CALL axcq522_set_comp_visible()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160426 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_set_comp_visible()
    CALL cl_set_comp_visible('b_xccp002,b_xccp002_desc',TRUE)
END FUNCTION
################################################################################
# Descriptions...: 控制欄位顯示
# Memo...........:
# Usage..........: CALL axcq522_set_comp_no_visible()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160426 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_set_comp_no_visible()
DEFINE l_para_data     LIKE type_t.chr80     #采用成本域否


   IF cl_null(g_master.xccpcomp) THEN
      CALL cl_get_para(g_enterprise,g_site,'S-FIN-6001') RETURNING l_para_data              #采用成本域否
   ELSE
      CALL cl_get_para(g_enterprise,g_master.xccpcomp,'S-FIN-6001') RETURNING l_para_data   #采用成本域否
   END IF

   IF l_para_data = 'N' THEN
      CALL cl_set_comp_visible('b_xccp002,b_xccp002_desc',FALSE)
   END IF
END FUNCTION
################################################################################
# Descriptions...: filter過濾功能
# Memo...........:
# Usage..........: CALL axcq522_filter()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 160426 By Polly
# Modify.........: 
################################################################################
PRIVATE FUNCTION axcq522_filter()

   LET l_ac = 1
   LET g_detail_idx = 1

 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   #備份
   LET g_wc_filter_t = g_wc_filter

   
   
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')

 
   LET g_wc_filter       = ''

   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

 

      CONSTRUCT g_wc_filter ON xccp002,xccp007,sfaa010,imag011
         FROM s_detail1[1].b_xccp002,s_detail1[1].b_xccp007,s_detail1[1].b_sfaa010,s_detail1[1].b_imag011   
 
         BEFORE CONSTRUCT
            DISPLAY axcq522_filter_parser('xccp002') TO s_detail1[1].b_xccp002
            DISPLAY axcq522_filter_parser('xccp007') TO s_detail1[1].b_xccp007
            DISPLAY axcq522_filter_parser('sfaa010') TO s_detail1[1].b_sfaa010
            DISPLAY axcq522_filter_parser('imag011') TO s_detail1[1].b_imag011
 
         
            ON ACTION controlp INFIELD b_xccp002      
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_xcbf001()                       
               DISPLAY g_qryparam.return1 TO b_xccp002  
               NEXT FIELD b_xccp002                     

            ON ACTION controlp INFIELD b_sfaa010   
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imaa001_9()                       
               DISPLAY g_qryparam.return1 TO b_sfaa010  
               NEXT FIELD b_sfaa010                     
               
            ON ACTION controlp INFIELD b_xccp007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_sfaadocno()                     
               DISPLAY g_qryparam.return1 TO b_xccp007
               NEXT FIELD b_xccp007               

            ON ACTION controlp INFIELD b_imag011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               CALL q_imag011()                          
               DISPLAY g_qryparam.return1 TO b_imag011  
               NEXT FIELD b_imag011     
            
      END CONSTRUCT


 
      BEFORE DIALOG
         #add-point:filter段b_dialog

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
   ELSE
      LET g_wc_filter = g_wc_filter_t        
   END IF
   LET g_wc = g_wc_t 
   CALL axcq522_filter_show('xccp002','b_xccp002')
   CALL axcq522_filter_show('xccp007','b_xccp007')
   CALL axcq522_filter_show('sfaa010','b_sfaa010')
   CALL axcq522_filter_show('imag011','b_imag011')
   CALL axcq522_browser_fill()
   #DISPLAY BY NAME g_master.l_xccp004,g_master.l_xccp004_1,g_master.l_xccp005,g_master.l_xccp005_1
END FUNCTION
################################################################################
# Descriptions...: filter欄位解析
# Memo...........:
# Usage..........: CALL axcq522_filter_parser(ps_field)
#                  RETURNING ls_var
# Input parameter: ps_field   欄位代號
# Return code....: ls_var     欄位查詢條件
# Date & Author..: 160426 By Polly
# Modify.........: 
################################################################################
PRIVATE FUNCTION axcq522_filter_parser(ps_field)
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
 
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
################################################################################
# Descriptions...: Browser標題欄位顯示搜尋條件
# Memo...........:
# Usage..........: CALL axcq522_filter_show(ps_field,ps_object)
# Input parameter: ps_field   欄位代號
#                : ps_object  物件代號
# Return code....: 無
# Date & Author..: 160426 By Polly
# Modify.........: 
################################################################################
PRIVATE FUNCTION axcq522_filter_show(ps_field,ps_object)
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   
   LET ls_name = ps_object

   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF

   #顯示資料組合
   LET ls_condition = axcq522_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF

   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
END FUNCTION
################################################################################
# Descriptions...: TEMP TABLE 建立
# Memo...........:
# Usage..........: CALL axcq522_x01_temp()
#                  RETURNING 
# Input parameter: 
# Return code....: 
# Date & Author..: 160427 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_x01_temp()
   
   #XG報表使用
   DROP TABLE axcq522_temp01;          #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01
   CREATE TEMP TABLE axcq522_temp01(   #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01  
       xccpcomp  VARCHAR(10), 
       xccpcomp_desc  VARCHAR(80),    
       xccpld  VARCHAR(5),
       xccpld_desc  VARCHAR(80),   
       l_xccp004  SMALLINT, 
       l_xccp004_1  SMALLINT, 
       l_xccp005  SMALLINT, 
       l_xccp005_1  SMALLINT,      
       xccp001  VARCHAR(1), 
       xccp001_desc  VARCHAR(80), 
       xccp003  VARCHAR(10),  
       xccp003_desc  VARCHAR(80),
       xccp004  SMALLINT, 
       xccp005  SMALLINT, 
       xccp002  VARCHAR(30), 
       xccp002_desc  VARCHAR(500),
       sfaa068  VARCHAR(10), 
       sfaa068_desc  VARCHAR(500),        
       xccp007  VARCHAR(20), 
       sfaa010  VARCHAR(500), 
       sfaa010_desc  VARCHAR(40), 
       sfaa010_desc_1  VARCHAR(500), 
       imag011  VARCHAR(10), 
       imag011_desc  VARCHAR(500), 
       xccp006  VARCHAR(20), 
       xccp008  VARCHAR(1), 
       xccp009  VARCHAR(80), 
       xccp101  DECIMAL(20,6), 
       xccp102a  DECIMAL(20,6), 
       xccp102b  DECIMAL(20,6), 
       xccp102c  DECIMAL(20,6), 
       xccp102d  DECIMAL(20,6), 
       xccp102e  DECIMAL(20,6), 
       xccp102f  DECIMAL(20,6), 
       xccp102g  DECIMAL(20,6), 
       xccp102h  DECIMAL(20,6), 
       xccp102  DECIMAL(20,6),
       l_key   SMALLINT)
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........:
# Usage..........: CALL axcq522_ins_xg_temp()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 160427 By 02040
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq522_ins_xg_temp()
  
  DEFINE l_x01_tmp RECORD 
       xccpcomp LIKE xccp_t.xccpcomp, 
       xccpcomp_desc LIKE type_t.chr80,    
       xccpld LIKE xccp_t.xccpld,
       xccpld_desc LIKE type_t.chr80,   
       l_xccp004 LIKE type_t.num5, 
       l_xccp004_1 LIKE type_t.num5, 
       l_xccp005 LIKE type_t.num5, 
       l_xccp005_1 LIKE type_t.num5,      
       xccp001 LIKE xccp_t.xccp001, 
       xccp001_desc LIKE type_t.chr80, 
       xccp003 LIKE xccp_t.xccp003,  
       xccp003_desc LIKE type_t.chr80,
       xccp004 LIKE xccp_t.xccp004, 
       xccp005 LIKE xccp_t.xccp005, 
       xccp002 LIKE xccp_t.xccp002, 
       xccp002_desc LIKE type_t.chr500, 
       sfaa068 LIKE sfaa_t.sfaa068, 
       sfaa068_desc LIKE type_t.chr500,         
       xccp007 LIKE xccp_t.xccp007, 
       sfaa010 LIKE sfaa_t.sfaa010, 
       sfaa010_desc LIKE type_t.chr500, 
       sfaa010_desc_1 LIKE type_t.chr500, 
       imag011 LIKE imag_t.imag011, 
       imag011_desc LIKE type_t.chr500, 
       xccp006 LIKE xccp_t.xccp006, 
       xccp008 LIKE xccp_t.xccp008, 
       xccp009 LIKE xccp_t.xccp009, 
       xccp101 LIKE xccp_t.xccp101, 
       xccp102a LIKE xccp_t.xccp102a, 
       xccp102b LIKE xccp_t.xccp102b, 
       xccp102c LIKE xccp_t.xccp102c, 
       xccp102d LIKE xccp_t.xccp102d, 
       xccp102e LIKE xccp_t.xccp102e, 
       xccp102f LIKE xccp_t.xccp102f, 
       xccp102g LIKE xccp_t.xccp102g, 
       xccp102h LIKE xccp_t.xccp102h, 
       xccp102 LIKE xccp_t.xccp102,
       l_key  LIKE type_t.num5
          END RECORD
   DEFINE l_i   LIKE type_t.num5

   DELETE FROM axcq522_temp01;      #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01
   
   FOR l_i = 1 TO g_detail.getLength() - 1
       INITIALIZE l_x01_tmp.* TO NULL   
       LET l_x01_tmp.xccpcomp       = g_master.xccpcomp          
       LET l_x01_tmp.xccpcomp_desc  = g_master.xccpcomp_desc  
       LET l_x01_tmp.xccpld         = g_master.xccpld    
       LET l_x01_tmp.xccpld_desc    = g_master.xccpld_desc
       LET l_x01_tmp.l_xccp004      = g_master.l_xccp004    
       LET l_x01_tmp.l_xccp004_1    = g_master.l_xccp004_1  
       LET l_x01_tmp.l_xccp005      = g_master.l_xccp005    
       LET l_x01_tmp.l_xccp005_1    = g_master.l_xccp005_1  
       LET l_x01_tmp.xccp001        = g_master.xccp001      
       LET l_x01_tmp.xccp001_desc   = g_master.xccp001_desc
       LET l_x01_tmp.xccp003        = g_master.xccp003      
       LET l_x01_tmp.xccp003_desc   = g_master.xccp003_desc
       LET l_x01_tmp.xccp004        = g_detail[l_i].xccp004       
       LET l_x01_tmp.xccp005        = g_detail[l_i].xccp005       
       LET l_x01_tmp.xccp002        = g_detail[l_i].xccp002
       LET l_x01_tmp.xccp002_desc   = g_detail[l_i].xccp002_desc         
       LET l_x01_tmp.sfaa068        = g_detail[l_i].sfaa068  
       LET l_x01_tmp.sfaa068_desc   = g_detail[l_i].sfaa068_desc
       LET l_x01_tmp.xccp007        = g_detail[l_i].xccp007       
       LET l_x01_tmp.sfaa010        = g_detail[l_i].sfaa010 
       LET l_x01_tmp.sfaa010_desc   = g_detail[l_i].sfaa010_desc
       LET l_x01_tmp.sfaa010_desc_1 = g_detail[l_i].sfaa010_desc_1         
       LET l_x01_tmp.imag011        = g_detail[l_i].imag011  
       LET l_x01_tmp.imag011_desc   = g_detail[l_i].imag011_desc                        
       LET l_x01_tmp.xccp006        = g_detail[l_i].xccp006       
       LET l_x01_tmp.xccp008        = g_detail[l_i].xccp008       
       LET l_x01_tmp.xccp009        = g_detail[l_i].xccp009       
       LET l_x01_tmp.xccp101        = g_detail[l_i].xccp101       
       LET l_x01_tmp.xccp102a       = g_detail[l_i].xccp102a      
       LET l_x01_tmp.xccp102b       = g_detail[l_i].xccp102b      
       LET l_x01_tmp.xccp102c       = g_detail[l_i].xccp102c      
       LET l_x01_tmp.xccp102d       = g_detail[l_i].xccp102d      
       LET l_x01_tmp.xccp102e       = g_detail[l_i].xccp102e      
       LET l_x01_tmp.xccp102f       = g_detail[l_i].xccp102f      
       LET l_x01_tmp.xccp102g       = g_detail[l_i].xccp102g      
       LET l_x01_tmp.xccp102h       = g_detail[l_i].xccp102h      
       LET l_x01_tmp.xccp102        = g_detail[l_i].xccp102 
       LET l_x01_tmp.l_key   = l_i
       #161109-00085#25-s mod
#       INSERT INTO axcq522_temp01 VALUES(l_x01_tmp.*)      #160727-00019#21 Mod   axcq522_x01_temp --> axcq522_temp01   #161109-00085#25-s mark 
       INSERT INTO axcq522_temp01(xccpcomp,xccpcomp_desc,xccpld,xccpld_desc,l_xccp004,l_xccp004,l_xccp005,
                                  l_xccp005,xccp001,xccp001_desc,xccp003,xccp003_desc,xccp004,xccp005,xccp002,
                                  xccp002_desc,sfaa068,sfaa068_desc,xccp007,sfaa010,sfaa010_desc,sfaa010_desc,
                                  imag011,imag011_desc,xccp006,xccp008,xccp009,xccp101,xccp102a,xccp102b,xccp102c,
                                  xccp102d,xccp102e,xccp102f,xccp102g,xccp102h,xccp102,l_key) 
                           VALUES(l_x01_tmp.xccpcomp,l_x01_tmp.xccpcomp_desc,l_x01_tmp.xccpld,l_x01_tmp.xccpld_desc,
                                  l_x01_tmp.l_xccp004,l_x01_tmp.l_xccp004,l_x01_tmp.l_xccp005,l_x01_tmp.l_xccp005,
                                  l_x01_tmp.xccp001,l_x01_tmp.xccp001_desc,l_x01_tmp.xccp003,l_x01_tmp.xccp003_desc,
                                  l_x01_tmp.xccp004,l_x01_tmp.xccp005,l_x01_tmp.xccp002,l_x01_tmp.xccp002_desc,
                                  l_x01_tmp.sfaa068,l_x01_tmp.sfaa068_desc,l_x01_tmp.xccp007,l_x01_tmp.sfaa010,
                                  l_x01_tmp.sfaa010_desc,l_x01_tmp.sfaa010_desc,l_x01_tmp.imag011,l_x01_tmp.imag011_desc,
                                  l_x01_tmp.xccp006,l_x01_tmp.xccp008,l_x01_tmp.xccp009,l_x01_tmp.xccp101,l_x01_tmp.xccp102a,
                                  l_x01_tmp.xccp102b,l_x01_tmp.xccp102c,l_x01_tmp.xccp102d,l_x01_tmp.xccp102e,l_x01_tmp.xccp102f,
                                  l_x01_tmp.xccp102g,l_x01_tmp.xccp102h,l_x01_tmp.xccp102,l_x01_tmp.l_key) 
       #161109-00085#25-e mod
   END FOR       
   
END FUNCTION

 
{</section>}
 
