#該程式未解開Section, 採用最新樣板產出!
{<section id="afaq520.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:10(2016-12-06 17:37:41), PR版次:0010(2016-12-28 10:41:58)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: afaq520
#+ Description: 盤點資料查詢作業
#+ Creator....: 02291(2015-07-27 13:48:27)
#+ Modifier...: 07900 -SD/PR- 08171
 
{</section>}
 
{<section id="afaq520.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#150901-00026#1 2015/09/01 By 02291 添加報表列印
#160505-00007#4 2016/05/18 By 01727 查詢效能優化
#160727-00019#1  2016/07/29 By 08742   系统中定义的临时表名称超过15码在执行时会出错,所以将系统中定义的临时表长度超过15码的全部改掉
#160426-00014#32 2016/08/22 By 07900   清单增加显示列管/列账(fabr044)栏位。
#161006-00005#35 2016/10/24 By 06814   资产中心开窗调整为q_ooef001_47，法人组织调整为q_ooef001_2
#161017-00023#1  2016/10/26 By 02114   权限调整
#161026-00047#1  2016/10/27 By 07900   1.目前有用单位做group.请调整为保管部门--》和sa讨论后拿掉左侧group，以保管部门排序
#                                      2.【账面数量】【盘点数量】列印出来后，名称没有区分
#                                      3.列印结果栏位错位,盘盈亏数量显示成ent值
#160923-00015#8  2016/12/05 By 01531   增加‘原因码’字段，显示在‘盘点数量’下面，当盘点数量<>账面数量（存在盘因亏）时，原因码必输。afaq512增加‘原因码’及‘说明’的显示及列印。
#160923-00015#7  2016/12/06 By 07900   在资产性质栏位后增加存放位置和名称的显示，报表输出也要一并增加。
#161123-00048#3  2016/12/28  By 08171  開窗範圍處理(卡片編號、財產編號、附號、存放位置)

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
       fabr001 LIKE fabr_t.fabr001, 
   fabr001_desc LIKE type_t.chr80
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   fabrcomp LIKE fabr_t.fabrcomp, 
   fabr003 LIKE fabr_t.fabr003, 
   fabr004 LIKE fabr_t.fabr004, 
   fabr007 LIKE fabr_t.fabr007, 
   fabr005 LIKE fabr_t.fabr005, 
   fabr006 LIKE fabr_t.fabr006, 
   faah012 LIKE type_t.chr500, 
   faah013 LIKE type_t.chr500, 
   fabr019 LIKE fabr_t.fabr019, 
   fabr014 LIKE fabr_t.fabr014, 
   fabr014_desc LIKE type_t.chr500, 
   fabr015 LIKE fabr_t.fabr015, 
   fabr015_desc LIKE type_t.chr500, 
   fabr008 LIKE fabr_t.fabr008, 
   fabr016 LIKE fabr_t.fabr016, 
   fabr016_desc LIKE type_t.chr500, 
   fabr011 LIKE fabr_t.fabr011, 
   fabr012 LIKE fabr_t.fabr012, 
   fabr023 LIKE fabr_t.fabr023, 
   fabr047 LIKE fabr_t.fabr047, 
   fabr047_desc LIKE type_t.chr500, 
   fabr031 LIKE fabr_t.fabr031, 
   fabr032 LIKE fabr_t.fabr032, 
   qty LIKE type_t.num20_6, 
   fabr044 LIKE fabr_t.fabr044
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       fabt002 LIKE fabt_t.fabt002, 
   fabt003 LIKE fabt_t.fabt003, 
   fabt004 LIKE fabt_t.fabt004, 
   fabr007 LIKE fabr_t.fabr007, 
   fabr005 LIKE fabr_t.fabr005, 
   fabr006 LIKE fabr_t.fabr006, 
   fabt005 LIKE fabt_t.fabt005, 
   fabt006 LIKE fabt_t.fabt006, 
   faah012 LIKE faah_t.faah012, 
   faah013 LIKE faah_t.faah013, 
   fabr016 LIKE fabr_t.fabr016, 
   fabr016_1_desc LIKE type_t.chr500, 
   fabt008 LIKE fabt_t.fabt008, 
   fabt021 LIKE fabt_t.fabt021, 
   qty1 LIKE type_t.num20_6, 
   fabt030 LIKE fabt_t.fabt030, 
   fabt029 LIKE fabt_t.fabt029, 
   fabr014 LIKE fabr_t.fabr014, 
   fabr014_1_desc LIKE type_t.chr500, 
   fabr015 LIKE fabr_t.fabr015, 
   fabr015_1_desc LIKE type_t.chr500
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master2            type_g_master
DEFINE g_master2_t          type_g_master
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
 
{<section id="afaq520.main" >}
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
   CALL cl_ap_init("afa","")
 
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
   DECLARE afaq520_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE afaq520_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE afaq520_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_afaq520 WITH FORM cl_ap_formpath("afa",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL afaq520_init()   
 
      #進入選單 Menu (="N")
      CALL afaq520_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_afaq520
      
   END IF 
   
   CLOSE afaq520_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="afaq520.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION afaq520_init()
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
   
      CALL cl_set_combo_scc('b_fabr008','9903') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL afaq520_create_tmp()  #150901-00026#1
   CALL cl_set_combo_scc('b_fabr044','9897')   #160426-00014#32  add 
   #end add-point
 
   CALL afaq520_default_search()
END FUNCTION
 
{</section>}
 
{<section id="afaq520.default_search" >}
PRIVATE FUNCTION afaq520_default_search()
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
 
{<section id="afaq520.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afaq520_ui_dialog() 
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
   CALL afaq520_ui_dialog_1()
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
      CALL afaq520_cs()
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
 
         CALL afaq520_init()
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
               CALL afaq520_detail_action_trans()
               LET g_master_idx = l_ac
               CALL afaq520_b_fill2()
 
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
            CALL afaq520_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
 
            #end add-point
            NEXT FIELD fabr001
 
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
 
            CALL afaq520_cs()
 
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
            CALL afaq520_fetch('F')
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
            CALL afaq520_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         
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
 
{<section id="afaq520.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION afaq520_cs()
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
 
   PREPARE afaq520_pre FROM g_sql
   DECLARE afaq520_curs SCROLL CURSOR WITH HOLD FOR afaq520_pre
   OPEN afaq520_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = " SELECT COUNT(*) ",
                   "   FROM fabr_t ",
                   "  WHERE fabrent = ",g_enterprise,
                   "    AND fabr001 = '",g_master.fabr001,"'",
                   "    AND ",g_wc2 CLIPPED
   #end add-point
   PREPARE afaq520_precount FROM g_cnt_sql
   EXECUTE afaq520_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL afaq520_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="afaq520.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION afaq520_fetch(p_flag)
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
   
   #end add-point
 
 
 
 
 
   IF SQLCA.sqlcode THEN
      # 清空右側畫面欄位值，但須保留左側qbe查詢條件
      INITIALIZE g_master.* TO NULL
      DISPLAY g_master.* TO b_fabr001,b_fabr001_desc
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
   CALL afaq520_show()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq520.show" >}
PRIVATE FUNCTION afaq520_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_fabr001,b_fabr001_desc
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL afaq520_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="afaq520.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION afaq520_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql           STRING
   DEFINE l_fabr001_desc  LIKE type_t.chr500
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_fabr008_desc  LIKE type_t.chr500
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   CALL g_detail2.clear()
   DELETE FROM afaq250_tmp01      # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
   DELETE FROM afaq250_tmp02      # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
   CALL afaq520_tmp_ins()   #160505-00007#4 Add
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   ERROR "Searching!"
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabrcomp','fabrcomp')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr003','fabr003')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr004','fabr004')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr007','fabr007')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr005','fabr005')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr006','fabr006')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr019','fabr019')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr008','fabr008')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr011','fabr011')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr012','fabr012')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr023','fabr023')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr031','fabr031')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr032','fabr032')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr044','fabr044')  #160426-00014#32  By 07900 --add
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr014','fabr014')  #160426-00014#38 add lujh
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr015','fabr015')  #160426-00014#38 add lujh
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr047','fabr047')  #160923-00015#8
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr016','fabr016')  #160923-00015#7
  #160505-00007#4 Mark ---(S)---
  #LET l_sql = " SELECT '',fabrcomp,fabr003,fabr004,fabr007,fabr005,fabr006,'','',fabr019,fabr008, 
  #                      fabr011,fabr012,fabr023,fabr031,fabr032,fabr023-fabr012",
  #            "   FROM fabr_t ",
  #           #"  LEFT OUTER JOIN faah_t ON faahent = fabrent AND fabr007 = faah001 AND fabr005 = faah003 AND fabr006 = faah004",
  #            "  WHERE fabrent = ",g_enterprise,
  #            "    AND fabr001 = '",g_master.fabr001,"' AND fabrstus = 'Y'",
  #            "    AND ",g_wc2 CLIPPED
  #160505-00007#4 Mark ---(E)---
  #160505-00007#4 Add  ---(S)---
   LET l_sql = " SELECT '',fabrcomp,fabr003,fabr004,fabr007,fabr005,fabr006,faah012,faah013,fabr019,fabr014,fabr014_desc,fabr015,fabr015_desc,fabrent,",  #160426-00014#38 add fabr014,fabr015 lujh   
               "          fabr016,fabr016_desc,fabr011,fabr012,fabr023,fabr047,fabr047_desc,fabr031,fabr032,fabr023-fabr012,fabr044 ", #160426-00014#32  By 07900  add fabr044  #160923-00015#8 add fabr047  #160923-00015#7 add fabr016
               "   FROM afaq250_tmp01 ",         # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
               "  ORDER BY fabrcomp,fabr031,fabr005,fabr006,fabr007"
  #160505-00007#4 Add  ---(E)---
   
   PREPARE fabr_prep FROM l_sql
   DECLARE fabr_curs CURSOR FOR fabr_prep
   #end add-point
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   #150901-00026#1-----add--#160505-00007#4-str--
  #LET l_fabr001_desc  = g_master.fabr001," ",g_master.fabr001_desc   #160505-00007#4 Mark
   #150901-00026#1-----add---end--
   
   FOREACH fabr_curs INTO g_detail[l_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
     #160505-00007#4 Mark ---(S)---
     #SELECT faah012,faah013 INTO g_detail[l_ac].faah012,g_detail[l_ac].faah013 FROM faah_t
     # WHERE faahent = g_enterprise AND faah003 = g_detail[l_ac].fabr005
     #   AND faah004 = g_detail[l_ac].fabr006 AND faah001 = g_detail[l_ac].fabr007
     ##150901-00026#1-----add---str--
     #LET l_fabr008_desc  = g_detail[l_ac].fabr008,":",s_desc_gzcbl004_desc('9903',g_detail[l_ac].fabr008)
     #INSERT INTO afaq520_print_tmp1 VALUES(l_fabr001_desc,g_detail[l_ac].fabrcomp,g_detail[l_ac].fabr003,g_detail[l_ac].fabr004, 
     #    g_detail[l_ac].fabr007,g_detail[l_ac].fabr005,g_detail[l_ac].fabr006,g_detail[l_ac].faah012,g_detail[l_ac].faah013,
     #    g_detail[l_ac].fabr019,l_fabr008_desc,g_detail[l_ac].fabr011,g_detail[l_ac].fabr012,g_detail[l_ac].fabr023, 
     #    g_detail[l_ac].fabr031,g_detail[l_ac].fabr032,g_enterprise,g_detail[l_ac].qty)
     ##150901-00026#1-----add---end--
     #160505-00007#4 Mark ---(E)---
      
      LET l_ac = l_ac + 1
   END FOREACH

   UPDATE afaq250_tmp01 SET fabrent = g_enterprise #160505-00007#4 Add   # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01

   #end add-point
 
   CALL g_detail.deleteElement(g_detail.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
 
   #end add-point
 
   LET g_error_show = 0
 
   #單身總筆數顯示
   LET g_detail_cnt = g_detail.getLength()
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL afaq520_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL afaq520_detail_action_trans()
 
   CALL afaq520_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="afaq520.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION afaq520_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_sql           STRING
   DEFINE l_fabr001_desc  LIKE type_t.chr500
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
  #160505-00007#4 Mark ---(S)---
  #LET l_sql = " SELECT fabt002,fabt003,fabt004,fabr007,fabr005,fabr006,fabt005,fabt006,faah012,faah013,
  #                     fabt008,fabt021,fabt008-fabt021,fabt030,fabt029",
  #            "   FROM fabt_t,fabr_t ",
  #            "  LEFT OUTER JOIN faah_t ON faahent = fabrent AND fabr007 = faah001 AND fabr005 = faah003 AND fabr006 = faah004",
  #            "  WHERE fabtent = fabrent AND fabt002 = fabr003",
  #            "    AND fabt003 = fabr004 AND fabrent = ",g_enterprise,
  #            "    AND fabr001 = '",g_master.fabr001,"' AND fabrstus = 'Y'",
  #            "    AND ",g_wc2 CLIPPED
  #160505-00007#4 Mark ---(E)---
  #160505-00007#4 Add  ---(S)---
   LET l_sql = " SELECT fabt002,fabt003,fabt004,fabr007,fabr005,fabr006,fabt005,fabt006,faah012,faah013,fabr016,fabr016_desc, 
                        fabt008,fabt021,fabt008-fabt021,fabt030,fabt029,fabr014,fabr014_1_desc,fabr015,fabr015_1_desc",  #160426-00014#38 add fabr014,fabr015 lujh  #160923-00015#7 add fabr016 
               "   FROM afaq250_tmp02",         # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
               "  ORDER BY fabt029,fabr005,fabr006,fabr007"
  #160505-00007#4 Add  ---(E)---
   
   PREPARE fabt_prep FROM l_sql
   DECLARE fabt_curs CURSOR FOR fabt_prep

   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #150901-00026#1-----add---str--
   LET l_fabr001_desc  = g_master.fabr001," ",g_master.fabr001_desc
   #150901-00026#1-----add---end--
   
   FOREACH fabt_curs INTO g_detail2[li_ac].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
     #160505-00007#4 Mark ---(S)---
     ##150901-00026#1-----add---str--       
     #INSERT INTO afaq520_print_tmp2 VALUES(l_fabr001_desc,g_detail2[li_ac].*)
     ##150901-00026#1-----add---end--
     #160505-00007#4 Mark ---(E)---
      
      LET li_ac = li_ac + 1
   END FOREACH

   CALL g_detail2.deleteElement(g_detail2.getLength())
   CLOSE fabr_curs
   CLOSE fabt_curs
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afaq520.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION afaq520_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].fabr014
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].fabr014_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].fabr014_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail[l_ac].fabr015
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].fabr015_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].fabr015_desc

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
 
{<section id="afaq520.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION afaq520_maintain_prog()
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
 
{<section id="afaq520.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION afaq520_detail_action_trans()
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
 
{<section id="afaq520.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION afaq520_detail_index_setting()
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
 
{<section id="afaq520.mask_functions" >}
 &include "erp/afa/afaq520_mask.4gl"
 
{</section>}
 
{<section id="afaq520.other_function" readonly="Y" >}

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
PRIVATE FUNCTION afaq520_get_fabr001_desc()
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] = g_master.fabr001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_master.fabr001_desc = '', g_rtn_fields[1] , ''
   DISPLAY g_master.fabr001_desc TO b_fabr001_desc
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
PRIVATE FUNCTION afaq520_ui_dialog_1()
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
      CALL afaq520_cs()
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
 
         CALL afaq520_init()
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
               CALL afaq520_detail_action_trans()
               LET g_master_idx = l_ac
               CALL afaq520_b_fill2()
 
               #add-point:input段before row
               LET g_tot_cnt = g_detail.getLength()
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
            CALL afaq520_fetch('')
 
            #add-point:ui_dialog段before dialog
            CALL afaq520_construct()
            CALL afaq520_b_fill()
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
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
 
   
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
 
            #add-point:ON ACTION accept

            #end add-point
 
            CALL afaq520_cs()
 
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
            CALL afaq520_fetch('F')
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
            CALL afaq520_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL afaq520_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL afaq520_b_fill()
 
         
         #應用 qs19 樣板自動產生(Version:2)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall

            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_detail.getLength()
               LET g_detail[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone

            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel

            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_detail.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_detail[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel

            #end add-point
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:2)
#         ON ACTION insert
#            LET g_action_choice="insert"
#            IF cl_auth_chk_act("insert") THEN
#               
#               #add-point:ON ACTION insert
#
#               #END add-point
#               
#               
#            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output
               #150901-00026#1-----add---str--
               IF NOT cl_ask_confirm("afa-00465") THEN
                  #按否列印匯總
                  CALL afaq520_x02('1=1','afaq250_tmp02')  # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
               ELSE
                  CALL afaq520_x01('1=1','afaq250_tmp01')  # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
               END IF
               #150901-00026#1-----add---end--
               #END add-point
               
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query
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
 
               CALL afaq520_init()
               CALL afaq520_construct()
               CALL afaq520_b_fill()
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
PRIVATE FUNCTION afaq520_construct()
   DEFINE l_comp_str     STRING       #161017-00023#1 add lujh
   DEFINE l_comp         LIKE ooef_t.ooef001 #161123-00048#3 add
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落
         INPUT g_master.fabr001 FROM b_fabr001
            ATTRIBUTE(WITHOUT DEFAULTS)
            
            BEFORE INPUT
               LET g_master.fabr001 = g_site
               CALL afaq520_get_fabr001_desc()
               DISPLAY BY NAME g_master.fabr001
               DISPLAY g_master.fabr001_desc TO b_fabr001_desc
            
            AFTER FIELD b_fabr001
               IF NOT cl_null(g_master.fabr001) THEN
                   #检查组织资料的合理性
                  IF NOT s_afat502_site_chk(g_master.fabr001) THEN
                     LET g_master.fabr001 = g_master_t.fabr001
                     CALL afaq520_get_fabr001_desc()
                     DISPLAY BY NAME g_master.fabr001
                     NEXT FIELD CURRENT
                  END IF
                  #user需要檢查和資產中心的權限
                  IF NOT s_afat502_site_user_chk(g_master.fabr001,g_user) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = g_master.fabr001
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     LET g_master.fabr001 = g_master_t.fabr001
                     CALL afaq520_get_fabr001_desc()
                     DISPLAY BY NAME g_master.fabr001
                     NEXT FIELD CURRENT
                  END IF
               ELSE
                  CALL afaq520_get_fabr001_desc()
                  DISPLAY BY NAME g_master.fabr001
               END IF
            
             ON ACTION controlp INFIELD b_fabr001
                     INITIALIZE g_qryparam.* TO NULL
                LET g_qryparam.state = 'i'
                     LET g_qryparam.reqry = FALSE
                LET g_qryparam.default1 = g_master.fabr001      #給予default值
                #161006-00005#35 20161024 mark by beckxie---S
                #LET g_qryparam.where = " ooef207 = 'Y' "
                #CALL q_ooef001()
                #161006-00005#35 20161024 mark by beckxie---E
                #161006-00005#35 20161024 add by beckxie---S
                LET g_qryparam.where = " ooef001 IN (SELECT gzxc004 FROM gzxc_t ",
                                       "              WHERE gzxcent = ",g_enterprise,
                                       "                AND gzxc001 = '",g_user,"' ",
                                       "                AND gzxc002 = '1' ",
                                       "                AND ((gzxc005 IS NULL OR gzxc005 <='",g_today,"') AND (gzxc006 IS NULL OR gzxc006 >'",g_today,"')) ",
                                       "                AND gzxcstus = 'Y' ) "
                CALL q_ooef001_47()
                #161006-00005#35 20161024 add by beckxie---E
                LET g_master.fabr001 = g_qryparam.return1       #將開窗取得的值回傳到變數
                DISPLAY g_master.fabr001 TO b_fabr001            #顯示到畫面上
                CALL afaq520_get_fabr001_desc()
                NEXT FIELD b_fabr001                              #返回原欄位
            
            AFTER INPUT
            
         END INPUT
         
         CONSTRUCT BY NAME g_wc2 ON b_fabrcomp,b_fabr003,b_fabr004,b_fabr007,b_fabr005,b_fabr006,b_fabr019,b_fabr014,b_fabr015,   #160426-00014#38 add fabr014,fabr015 lujh
                                    b_fabr008,b_fabr011,b_fabr012,b_fabr023,b_fabr031,b_fabr032,b_fabr044,
                                    b_fabr047,b_fabr016 #160923-00015#8 add   #160923-00015#7 add b_fabr016
            BEFORE CONSTRUCT
 
            #Ctrlp:construct.c.faah001
            #應用 a03 樣板自動產生(Version:2)
            ON ACTION controlp INFIELD b_fabr003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_fabr003_2()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr003  #顯示到畫面上
               
               NEXT FIELD b_fabr003                    #返回原欄位

            ON ACTION controlp INFIELD b_fabrcomp
               CALL s_axrt300_get_site(g_user,g_master.fabr001,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
               #CALL q_ooef001()                       #呼叫開窗   #161006-00005#35 20161024 mark by beckxie
               CALL q_ooef001_2()                      #呼叫開窗   #161006-00005#35 20161024 add by beckxie
               DISPLAY g_qryparam.return1 TO b_fabrcomp  #顯示到畫面上
               
               NEXT FIELD b_fabrcomp                   #返回原欄位
            
            ON ACTION controlp INFIELD b_fabr007
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         #161123-00048#3 --s add
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","fabrcomp")
               IF NOT cl_null(g_master.fabr001) THEN 
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_master.fabr001,"') AND ",l_comp_str
               ELSE
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str
               END IF
               #161123-00048#3 --e add
               CALL q_fabr007()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr007  #顯示到畫面上
               
               NEXT FIELD b_fabr007                    #返回原欄位
               
            ON ACTION controlp INFIELD b_fabr005
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         #161123-00048#3 --s add
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","fabrcomp")
               IF NOT cl_null(g_master.fabr001) THEN 
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_master.fabr001,"') AND ",l_comp_str
               ELSE
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str
               END IF
               #161123-00048#3 --e add
               CALL q_fabr005()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr005  #顯示到畫面上
               
               NEXT FIELD b_fabr005                    #返回原欄位
               
            ON ACTION controlp INFIELD b_fabr006
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         #161123-00048#3 --s add
               CALL s_axrt300_get_site(g_user,'','3') RETURNING l_comp_str
               LET l_comp_str = cl_replace_str(l_comp_str ,"ooef017","fabrcomp")
               IF NOT cl_null(g_master.fabr001) THEN 
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_master.fabr001,"') AND ",l_comp_str
               ELSE
                  LET g_qryparam.where = " fabrcomp IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') AND ",l_comp_str
               END IF
               #161123-00048#3 --e add
               CALL q_fabr006()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr006  #顯示到畫面上
               
               NEXT FIELD b_fabr006                    #返回原欄位
            
            ON ACTION controlp INFIELD b_fabr019
               CALL s_axrt300_get_site(g_user,g_master.fabr001,'1') RETURNING l_comp_str    #161017-00023#1 add lujh
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         LET g_qryparam.where = l_comp_str     #161017-00023#1 add lujh
               CALL q_ooef001()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr019  #顯示到畫面上
               
               NEXT FIELD b_fabr019                    #返回原欄位
               
            #160426-00014#38--add--str--lujh
            ON ACTION controlp INFIELD b_fabr014
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooeg001_4()                         #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr014    #顯示到畫面上
               
               NEXT FIELD b_fabr014                       #返回原欄位
               
            ON ACTION controlp INFIELD b_fabr015
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr015    #顯示到畫面上
               
               NEXT FIELD b_fabr015                       #返回原欄位
            #160426-00014#38--add--end--lujh
            
            ON ACTION controlp INFIELD b_fabr011
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooca001_1()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr011  #顯示到畫面上
               
               NEXT FIELD b_fabr011                    #返回原欄位
               
            ON ACTION controlp INFIELD b_fabr032
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
               CALL q_ooag001()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr032  #顯示到畫面上
               
               NEXT FIELD b_fabr032                    #返回原欄位
               
            #160923-00015#8 add s---
            ON ACTION controlp INFIELD b_fabr047
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
		         LET g_qryparam.reqry = FALSE
		         LET g_qryparam.where = " (oocq019 = '24' OR oocq019 = '23')"
               CALL q_oocq002_28()                      #呼叫開窗
               DISPLAY g_qryparam.return1 TO b_fabr047  #顯示到畫面上
               
               NEXT FIELD b_fabr047                    #返回原欄位            
            #160923-00015#8 add e--- 
            #160923-00015#7 add s---
            ON ACTION controlp INFIELD b_fabr016
            #開窗c段
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.arg1 = '3900'
			   #LET g_qryparam.where = "( oocq004 IN (SELECT ooef017 FROM ooef_t WHERE ooefent = ",g_enterprise," AND ooef001 = '",g_site,"') OR oocq004 IS NULL)"  #161123-00048#3 mark
            #161123-00048#3 --s add
            LET l_comp = NULL
            IF NOT cl_null(g_master.fabr001) THEN
               SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_master.fabr001
            ELSE
               SELECT ooef017 INTO l_comp FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = g_site
            END IF
            LET g_qryparam.where = " oocq004 = '",l_comp,"' "
            #161123-00048#3 --e add
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_fabr016  #顯示到畫面上

            NEXT FIELD b_fabr016                    #返回原欄位
            #160923-00015#7 add e---
         END CONSTRUCT
         
      ON ACTION accept
         ACCEPT DIALOG

      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG

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
# Descriptions...: 報表列印臨時表
# Memo...........:
# Date & Author..: #150901-00026#1 5015/09/01 yangtt
# Modify.........:
################################################################################
PRIVATE FUNCTION afaq520_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE afaq250_tmp01           # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
   CREATE TEMP TABLE afaq250_tmp01(   # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
   fabr001_desc  VARCHAR(500),
   fabrcomp  VARCHAR(10), 
   fabr003  VARCHAR(10), 
   fabr004  INTEGER, 
   fabr007  VARCHAR(10), 
   fabr005  VARCHAR(20), 
   fabr006  VARCHAR(20), 
   faah012  VARCHAR(500), 
   faah013  VARCHAR(500), 
   fabr019  VARCHAR(10), 
   #160426-00014#38--add--str--lujh
   fabr014  VARCHAR(10), 
   fabr014_desc  VARCHAR(500), 
   fabr015  VARCHAR(20), 
   fabr015_desc  VARCHAR(500), 
   #160426-00014#38--add--end--lujh
   fabr008_desc  VARCHAR(500), 
   fabr011  VARCHAR(10), 
   fabr012  DECIMAL(20,6), 
   fabr023  DECIMAL(20,6), 
   fabr031  DATE, 
   fabr032  VARCHAR(20), 
   fabr044  VARCHAR(100),       #160426-00014#32  By 07900 --add 
   fabr047  VARCHAR(10),         #160923-00015#8 add
   fabr047_desc  VARCHAR(500),     #160923-00015#8 add 
   fabr016  VARCHAR(10),         #160923-00015#7 add
   fabr016_desc  VARCHAR(500),     #160923-00015#7 add  
   fabrent  SMALLINT,
   qty  DECIMAL(20,6)     #160426-00014#38 change type_t.chr500 to type_t.num20_6 lujh
   );
   
   DROP TABLE afaq250_tmp02              # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
   CREATE TEMP TABLE afaq250_tmp02(      # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
   fabr001_desc  VARCHAR(500),
   fabt002  VARCHAR(10), 
   fabt003  INTEGER, 
   fabt004  INTEGER, 
   fabr007  VARCHAR(10), 
   fabr005  VARCHAR(20), 
   fabr006  VARCHAR(20), 
   fabt005  VARCHAR(10), 
   fabt006  VARCHAR(10), 
   faah012  VARCHAR(255), 
   faah013  VARCHAR(255), 
   fabt008  DECIMAL(20,6), 
   fabt021  DECIMAL(20,6), 
   qty1  DECIMAL(20,6),                  #160426-00014#38 change type_t.chr500 to type_t.num20_6 lujh
   fabt030  VARCHAR(20), 
   fabt029  DATE,
   #160426-00014#38--add--str--lujh
   fabr014  VARCHAR(10), 
   fabr014_1_desc  VARCHAR(500), 
   fabr015  VARCHAR(20), 
   fabr015_1_desc  VARCHAR(500),
   #160426-00014#38--add--end--lujh
   fabr016  VARCHAR(10),         #160923-00015#7 add
   fabr016_desc  VARCHAR(500)     #160923-00015#7 add  
   )
END FUNCTION

################################################################################
# Descriptions...: 資料先匯入臨時表
# Memo...........:
# Usage..........: CALL afaq520_tmp_ins()
#                  RETURNING ---
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/05/18 By 01727
# Modify.........: #160505-00007#4
################################################################################
PRIVATE FUNCTION afaq520_tmp_ins()
   DEFINE l_sql         STRING
   DEFINE ls_sql          RECORD
             faah012         STRING,
             faah013         STRING,
             fabr008         STRING,
             #160426-00014#38--add--str--lujh
             fabr014         STRING,
             fabr015         STRING,
             #160426-00014#38--add--end--lujh
             fabr047         STRING, #160923-00015#8
             fabr016         STRING #160923-00015#7
                          END RECORD
   
   #160426-00014#38--add--str--lujh   
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabrcomp','fabrcomp')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr003','fabr003')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr004','fabr004')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr007','fabr007')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr005','fabr005')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr006','fabr006')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr019','fabr019')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr008','fabr008')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr011','fabr011')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr012','fabr012')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr023','fabr023')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr031','fabr031')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr032','fabr032')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr044','fabr044') 
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr014','fabr014')  
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr015','fabr015')
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr047','fabr047') #160923-00015#8
   LET g_wc2 = cl_replace_str(g_wc2, 'b_fabr016','fabr016') #160923-00015#7
   #160426-00014#38--add--end--lujh   
   
   
  #第一單身 ---(S)---
  #名稱
   LET ls_sql.faah012 = "(SELECT DISTINCT faah012 FROM faah_t WHERE faahent = '",g_enterprise,"' AND faah003 = fabr005 AND faah004 = fabr006 AND faah001 = fabr007)" #160923-00015#8 add distinct

  #規格型號
   LET ls_sql.faah013 = "(SELECT DISTINCT faah013 FROM faah_t WHERE faahent = '",g_enterprise,"' AND faah003 = fabr005 AND faah004 = fabr006 AND faah001 = fabr007)"#160923-00015#8 add distinct

  #資產性質
   LET ls_sql.fabr008 = "(SELECT gzcbl002||':'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '9903' AND gzcbl002 = fabr008 AND gzcbl003 = '",g_lang,"')"
   
   #保管部門名稱
   LET ls_sql.fabr014 = "(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = '",g_enterprise,"' AND ooefl001 = fabr014 AND ooefl002 = '",g_lang,"')"
   
   #保管人員名稱
   LET ls_sql.fabr015 = "(SELECT ooag011 FROM ooag_t WHERE ooagent = '",g_enterprise,"' AND ooag001 = fabr015 )"

   LET ls_sql.fabr047 = "(SELECT oocql004 FROM oocql_t WHERE oocqlent= ",g_enterprise," AND oocql001='3902' AND oocql002=fabr047 AND oocql003='",g_dlang,"')" #160923-00015#8 add
   #存放位置名稱
   LET ls_sql.fabr016 = "(SELECT oocql004 FROM oocql_t WHERE oocqlent= ",g_enterprise," AND oocql001='3900' AND oocql002=fabr016 AND oocql003='",g_dlang,"')" #160923-00015#7 add
   
   LET l_sql = "INSERT INTO afaq250_tmp01(",       # 160727-00019#1 Mod  afaq520_print_tmp1--> afaq250_tmp01
               " fabr001_desc,fabrcomp,fabr003,fabr004,fabr007,fabr005,",
               " fabr006,faah012,faah013,fabr019,fabr014,fabr014_desc,fabr015,fabr015_desc,fabr008_desc,fabr011,",  #160426-00014#38 add fabr014,fabr015 lujh
               " fabr012,fabr023,fabr031,fabr032,fabrent,qty,fabr044,fabr047,fabr047_desc,fabr016,fabr016_desc)", #160426-00014#32  By 07900 --add fabr044 #160923-00015#8 add fabr047 #160923-00015#7 add fabr016
               " SELECT '",g_master.fabr001_desc,"',fabrcomp,fabr003,fabr004,fabr007,fabr005,",#161026-00047#1 mod SELECT fabr011||' '||'",g_master.fabr001_desc,"'->SELECT '",g_master.fabr001_desc,"'
               "        fabr006,",ls_sql.faah012,",",ls_sql.faah013,",fabr019,fabr014,",ls_sql.fabr014,   #160426-00014#38 add fabr014 lujh
               "        ,fabr015,",ls_sql.fabr015,",",ls_sql.fabr008,",fabr011, ",    #160426-00014#38 add fabr015 lujh
               "        fabr012,fabr023,fabr031,fabr032,fabr008,fabr023-fabr012,fabr044,",#160426-00014#32  By 07900 --add fabr044 
               "        fabr047,",ls_sql.fabr047,",fabr016,",ls_sql.fabr016, #160923-00015#8 add  #160923-00015#7 add fabr016
               "   FROM fabr_t ",
               "  WHERE fabrent = ",g_enterprise,
               "    AND fabr001 = '",g_master.fabr001,"' AND fabrstus = 'Y'",
               "    AND ",g_wc2 CLIPPED
   PREPARE afaq520_ins_prep FROM l_sql
   EXECUTE afaq520_ins_prep
  #第一單身 ---(E)---

  #第二單身 ---(S)---
   LET l_sql = "INSERT INTO afaq250_tmp02(",   # 160727-00019#1 Mod  afaq520_print_tmp2--> afaq250_tmp02
               "     fabr001_desc,fabt002,fabt003,fabt004,",
               "     fabr007,fabr005,fabr006,fabt005,",
               "     fabt006,faah012,faah013,fabt008,",
               "     fabt021,qty1,fabt030,fabt029,fabr014,fabr014_1_desc,fabr015,fabr015_1_desc,fabr016,fabr016_desc)",   #160426-00014#38 add fabr014,fabr015 lujh  #160923-00015#8 add fabr016
               " SELECT '",g_master.fabr001_desc,"',fabt002,fabt003,fabt004,",#161026-00047#1 mod SELECT fabr011||' '||'",g_master.fabr001_desc,"'->SELECT '",g_master.fabr001_desc,"'
               "        fabr007,fabr005,fabr006,fabt005,",
               "        fabt006,faah012,faah013,fabt008,",
               "        fabt021,fabt008-fabt021,fabt030,fabt029,",
               "        fabr014,",ls_sql.fabr014,",fabr015,",ls_sql.fabr015,",",    #160426-00014#38 add lujh
               "        fabr016,",ls_sql.fabr016, #160923-00015#7 add   
               "   FROM fabt_t,fabr_t ",
               "  LEFT OUTER JOIN faah_t ON faahent = fabrent AND fabr007 = faah001 AND fabr005 = faah003 AND fabr006 = faah004",
               "  WHERE fabtent = fabrent AND fabt002 = fabr003",
               "    AND fabt003 = fabr004 AND fabrent = ",g_enterprise,
               "    AND fabr001 = '",g_master.fabr001,"' AND fabrstus = 'Y'",
               "    AND ",g_wc2 CLIPPED
   PREPARE afaq520_ins_prep2 FROM l_sql
   EXECUTE afaq520_ins_prep2
  #第二單身 ---(S)---

END FUNCTION

 
{</section>}
 
