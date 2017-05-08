#該程式未解開Section, 採用最新樣板產出!
{<section id="adeq406.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-07-05 15:13:42), PR版次:0004(2017-01-10 10:23:05)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000025
#+ Filename...: adeq406
#+ Description: 門店收銀交款查詢作業
#+ Creator....: 02114(2016-06-20 15:01:08)
#+ Modifier...: 05948 -SD/PR- 07142
 
{</section>}
 
{<section id="adeq406.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#160509-00004#99  2016/07/01  By 02114       收银员开窗过率职能为1，收银员
#160509-00004#104 2016/07/05  by 05948 liyan 單身增加匯總頁簽，明細頁簽增加收銀員
#161006-00008#6   2016/10/17  by 06137       組織類型與職能開窗清單調整
#161202-00033#1   2016/12/29  by 07142       增加aooi500
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
       rtjfsite LIKE rtjf_t.rtjfsite, 
   rtjfsite_desc LIKE type_t.chr80, 
   rtjf030 LIKE rtjf_t.rtjf030
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   rtjfdocno LIKE rtjf_t.rtjfdocno, 
   rtjfseq LIKE rtjf_t.rtjfseq, 
   rtjfseq1 LIKE rtjf_t.rtjfseq1, 
   rtjf001 LIKE rtjf_t.rtjf001, 
   rtjf002 LIKE rtjf_t.rtjf002, 
   rtjf002_desc LIKE type_t.chr500, 
   rtjf030 LIKE rtjf_t.rtjf030, 
   pacb003 LIKE type_t.chr500, 
   rtjf003 LIKE rtjf_t.rtjf003, 
   rtjf004 LIKE rtjf_t.rtjf004, 
   rtjf005 LIKE rtjf_t.rtjf005, 
   rtjf006 LIKE rtjf_t.rtjf006, 
   rtjf007 LIKE rtjf_t.rtjf007, 
   rtjf008 LIKE rtjf_t.rtjf008, 
   rtjf009 LIKE rtjf_t.rtjf009, 
   rtjf010 LIKE rtjf_t.rtjf010, 
   rtjf010_desc LIKE type_t.chr500, 
   rtjf011 LIKE rtjf_t.rtjf011, 
   rtjf012 LIKE rtjf_t.rtjf012, 
   rtjf013 LIKE rtjf_t.rtjf013, 
   rtjf013_desc LIKE type_t.chr500, 
   rtjf014 LIKE rtjf_t.rtjf014, 
   rtjf015 LIKE rtjf_t.rtjf015, 
   rtjf015_desc LIKE type_t.chr500, 
   rtjf016 LIKE rtjf_t.rtjf016, 
   rtjf017 LIKE rtjf_t.rtjf017, 
   rtjf018 LIKE rtjf_t.rtjf018, 
   rtjf019 LIKE rtjf_t.rtjf019, 
   rtjf020 LIKE rtjf_t.rtjf020, 
   rtjf021 LIKE rtjf_t.rtjf021, 
   rtjf022 LIKE rtjf_t.rtjf022, 
   rtjf023 LIKE rtjf_t.rtjf023, 
   rtjf024 LIKE rtjf_t.rtjf024, 
   rtjf025 LIKE rtjf_t.rtjf025, 
   rtjf026 LIKE rtjf_t.rtjf026, 
   rtjf027 LIKE rtjf_t.rtjf027, 
   rtjf028 LIKE rtjf_t.rtjf028, 
   rtjf029 LIKE rtjf_t.rtjf029, 
   rtjf031 LIKE rtjf_t.rtjf031, 
   rtjf032 LIKE rtjf_t.rtjf032, 
   rtjf033 LIKE rtjf_t.rtjf033, 
   rtjf034 LIKE rtjf_t.rtjf034, 
   rtjf035 LIKE rtjf_t.rtjf035, 
   rtjf036 LIKE rtjf_t.rtjf036, 
   rtjf037 LIKE rtjf_t.rtjf037, 
   rtjf101 LIKE rtjf_t.rtjf101, 
   rtjf102 LIKE rtjf_t.rtjf102, 
   rtjf103 LIKE rtjf_t.rtjf103, 
   rtjf104 LIKE rtjf_t.rtjf104, 
   rtjf105 LIKE rtjf_t.rtjf105, 
   rtjf106 LIKE rtjf_t.rtjf106, 
   rtjf107 LIKE rtjf_t.rtjf107, 
   rtjf108 LIKE rtjf_t.rtjf108, 
   rtjfunit LIKE rtjf_t.rtjfunit
       END RECORD
PRIVATE TYPE type_g_detail2 RECORD
       rtjf001 LIKE rtjf_t.rtjf001, 
   rtjf002 LIKE rtjf_t.rtjf002, 
   rtjf002_1_desc LIKE type_t.chr500, 
   rtjf003 LIKE rtjf_t.rtjf003
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_a                 LIKE type_t.chr1
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
DEFINE g_tot_cnt2             LIKE type_t.num10
DEFINE g_sql2                 STRING 
#end add-point
 
{</section>}
 
{<section id="adeq406.main" >}
 #應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5     #161006-00008#6 Add By Ken 161017
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
   DECLARE adeq406_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE adeq406_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE adeq406_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adeq406 WITH FORM cl_ap_formpath("ade",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL adeq406_init()   
 
      #進入選單 Menu (="N")
      CALL adeq406_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_adeq406
      
   END IF 
   
   CLOSE adeq406_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success    #161006-00008#6 Add By Ken 161017
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="adeq406.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adeq406_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5    #161006-00008#6 Add By Ken 161017
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_master_row_move = "Y"
   
      CALL cl_set_combo_scc('b_rtjf001','8310') 
  
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('a','6943') 
   CALL cl_set_combo_scc('b_rtjf001_1','8310')  #add by liyan 160705
   CALL s_aooi500_create_temp() RETURNING l_success    #161006-00008#6 Add By Ken 161017   
   #end add-point
 
   CALL adeq406_default_search()
END FUNCTION
 
{</section>}
 
{<section id="adeq406.default_search" >}
PRIVATE FUNCTION adeq406_default_search()
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
 
{<section id="adeq406.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION adeq406_ui_dialog() 
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
      CALL adeq406_cs()
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
 
         CALL adeq406_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         CONSTRUCT BY NAME g_wc ON rtjfsite,rtjf025,rtjf030

            BEFORE CONSTRUCT
            
            ON ACTION controlp INFIELD rtjfsite
               #add-point:ON ACTION controlp INFIELD deadsite name="construct.c.deadsite"
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = s_aooi500_q_where(g_prog,'rtjfsite',g_site,'c')
               CALL q_ooef001_24()
               DISPLAY g_qryparam.return1 TO rtjfsite  #顯示到畫面上
               NEXT FIELD rtjfsite                     #返回原欄位
               
            ON ACTION controlp INFIELD rtjf030
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.where = " pcab006 = '1' AND pcac002 = '",g_site,"'"   #160509-00004#99 add lujh
               CALL q_pcab001_1()                       #呼叫開窗
               DISPLAY g_qryparam.return1 TO rtjf030    #顯示到畫面上
               NEXT FIELD rtjf030                       #返回原欄位
         
         END CONSTRUCT
         
         INPUT g_a FROM a
            BEFORE INPUT
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL adeq406_detail_action_trans()
               LET g_master_idx = l_ac
               CALL adeq406_b_fill2()
 
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
            CALL adeq406_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            LET g_a = '1'
            #end add-point
            NEXT FIELD rtjfsite
 
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
            IF g_wc = " 1=2 " THEN 
               LET g_wc = " 1=1 " 
            END IF
            CALL adeq406_b_fill()
            #end add-point
 
            CALL adeq406_cs()
 
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
            CALL adeq406_fetch('F')
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
            CALL adeq406_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL adeq406_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL adeq406_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL adeq406_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL adeq406_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL adeq406_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL adeq406_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL adeq406_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL adeq406_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL adeq406_b_fill()
 
         
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
 
{<section id="adeq406.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION adeq406_cs()
   #add-point:cs段define-客製 name="cs.define_customerization"
   
   #end add-point
   #add-point:cs段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="cs.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="cs.before_function"
   RETURN
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
 
   PREPARE adeq406_pre FROM g_sql
   DECLARE adeq406_curs SCROLL CURSOR WITH HOLD FOR adeq406_pre
   OPEN adeq406_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   
   #end add-point
   PREPARE adeq406_precount FROM g_cnt_sql
   EXECUTE adeq406_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL adeq406_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="adeq406.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION adeq406_fetch(p_flag)
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
      DISPLAY g_master.* TO b_rtjfsite,b_rtjfsite_desc,b_rtjf030
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
   CALL adeq406_show()
 
END FUNCTION
 
{</section>}
 
{<section id="adeq406.show" >}
PRIVATE FUNCTION adeq406_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO b_rtjfsite,b_rtjfsite_desc,b_rtjf030
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL adeq406_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="adeq406.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION adeq406_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_where         STRING    #161006-00008#6 Add By Ken 161017
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_wc = " 1=2 " THEN 
      RETURN
   END IF
   CALL s_aooi500_sql_where(g_prog,'rtjfsite') RETURNING l_where    #161006-00008#6 Add By Ken 161017
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
   LET ls_sql_rank = "SELECT '',rtjfdocno,rtjfseq,rtjfseq1,rtjf001,rtjf002,t1.ooial003 rtjf002_desc,rtjf030,'',rtjf003,rtjf004,rtjf005, ",       
                     "       rtjf006,rtjf007,rtjf008,rtjf009,rtjf010,t2.nmabl003 rtjf010_desc,rtjf011,rtjf012,rtjf013,'',",   
                     "       rtjf014,rtjf015,'',rtjf016,rtjf017,rtjf018,rtjf019,rtjf020,rtjf021,rtjf022,",        
                     "       rtjf023,rtjf024,rtjf025,rtjf026,rtjf027,rtjf028,rtjf029,rtjf031,rtjf032,",        
                     "       rtjf033,rtjf034,rtjf035,rtjf036,rtjf037,rtjf101,rtjf102,rtjf103,rtjf104,",        
                     "       rtjf105,rtjf106,rtjf107,rtjf108,rtjfunit",       
                     "  FROM rtjf_t ",
                     "  LEFT JOIN ooial_t t1 ON t1.ooialent='"||g_enterprise||"' AND t1.ooial001=rtjf002 AND t1.ooial002='"||g_dlang||"' ",
                     "  LEFT JOIN nmabl_t t2 ON t2.nmablent='"||g_enterprise||"' AND t2.nmabl001=rtjf010 AND t2.nmabl002='"||g_dlang||"' ",
                     " WHERE rtjfent = '",g_enterprise,"' ",
                     "   AND ",g_wc , 
                     "   AND ",l_where   #161006-00008#6 Add By Ken 161017
            
   IF g_a = '1' THEN 
      LET ls_sql_rank = ls_sql_rank," AND rtjf108 = 'Y' "
   END IF
   
   IF g_a = '2' THEN 
      LET ls_sql_rank = ls_sql_rank," AND (rtjf108 = 'N' OR rtjf108 IS NULL) "
   END IF
   #end add-point
 
   LET g_sql = "SELECT COUNT(*) FROM (",ls_sql_rank,")"
  
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
   FREE b_fill_cnt_pre
   
   IF g_tot_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
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
   
   LET g_sql = "SELECT '',rtjfdocno,rtjfseq,rtjfseq1,rtjf001,rtjf002,rtjf002_desc,rtjf030,'',rtjf003,rtjf004,rtjf005, ",  #add by liyan rtjf030,pcab003       
               "       rtjf006,rtjf007,rtjf008,rtjf009,rtjf010,rtjf010_desc,rtjf011,rtjf012,rtjf013,'',",   
               "       rtjf014,rtjf015,'',rtjf016,rtjf017,rtjf018,rtjf019,rtjf020,rtjf021,rtjf022,",        
               "       rtjf023,rtjf024,rtjf025,rtjf026,rtjf027,rtjf028,rtjf029,rtjf031,rtjf032,",        
               "       rtjf033,rtjf034,rtjf035,rtjf036,rtjf037,rtjf101,rtjf102,rtjf103,rtjf104,",        
               "       rtjf105,rtjf106,rtjf107,rtjf108,rtjfunit",       
               " FROM (",ls_sql_rank,")",
               " ORDER BY rtjfdocno,rtjfseq,rtjfseq1"
                
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE adeq406_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR adeq406_pb
   
   OPEN b_fill_curs
   let g_sql2=ls_sql_rank
   FOREACH b_fill_curs INTO g_detail[l_ac].* 
                            

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF  
     #add by liyan 160705--str--      
      SELECT DISTINCT  PCAB003 into g_detail[l_ac].pacb003
          FROM PCAB_T, PCAC_T
         WHERE PCABENT = PCACENT
           AND PCAB001 = PCAC001
           AND PCAB006 IN ('1', '3', '4')
           AND PCABENT = g_enterprise
           AND pcab001=g_detail[l_ac].rtjf030
           AND PCAB006 = '1'
           #AND PCAC002 = g_site
         ORDER BY PCAB001
      #add by liyan 160705--end--
         
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
   CALL adeq406_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL adeq406_detail_action_trans()
 
   CALL adeq406_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="adeq406.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION adeq406_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   IF g_wc = " 1=2 " THEN 
      RETURN
   END IF
   #end add-point
 
   LET li_ac = 1
 
   #單身組成
   #應用 qs11 樣板自動產生(Version:3)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
   #add-point:sql組成 name="b_fill2.fill"
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail2.clear()
   #end add-point
 
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #add by liyan 160705--str--
   LET ls_sql_rank = "SELECT rtjf001,rtjf002,'',nvl(sum(rtjf003),0)",       
                     "  FROM (",g_sql2,")",
                     "  group by rtjf001,rtjf002 ",
                     " ORDER BY rtjf001"
   #end add-point
 
   LET g_sql = "SELECT COUNT(*) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre2 FROM g_sql
   EXECUTE b_fill_cnt_pre2 INTO g_tot_cnt2
   FREE b_fill_cnt_pre2
   
   IF g_tot_cnt2 = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   END IF
   
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
   
#   LET g_sql = "SELECT rtjf001,rtjf002,rtjf002_desc,rtjf003",       
#               " FROM (",ls_sql_rank,")",
#               " ORDER BY rtjf001"
                
   LET ls_sql_rank = cl_sql_add_mask(ls_sql_rank)              #遮蔽特定資料
   PREPARE adeq406_pb2 FROM ls_sql_rank
   DECLARE b_fill_curs2 CURSOR FOR adeq406_pb2
   
   OPEN b_fill_curs2
   
   FOREACH b_fill_curs2 INTO g_detail2[li_ac].* 
                            

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF  
      select ooial003 into g_detail2[li_ac].rtjf002_1_desc
       from ooial_t  
      where ooialent=g_enterprise
        and ooial001=g_detail2[li_ac].rtjf002
        and ooial002=g_dlang        

      IF li_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET li_ac = li_ac + 1
      
   END FOREACH
   #add by liyan 160705--end--
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq406.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION adeq406_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_detail[l_ac].rtjf002
            LET ls_sql = "SELECT ooial002 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial003='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail[l_ac].rtjf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail[l_ac].rtjf002_desc

#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_detail[l_ac].rtjf010
#            LET ls_sql = "SELECT nmabl002 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_detail[l_ac].rtjf010_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_detail[l_ac].rtjf010_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_detail[l_ac].rtjf013
#            LET ls_sql = "SELECT gcafl002 FROM gcafl_t WHERE gcaflent='"||g_enterprise||"' AND gcafl001=? AND gcafl003='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_detail[l_ac].rtjf013_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_detail[l_ac].rtjf013_desc
#
#            INITIALIZE g_ref_fields TO NULL
#            LET g_ref_fields[1] = g_detail[l_ac].rtjf015
#            LET ls_sql = "SELECT oocql003 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql002=? AND oocql004='"||g_dlang||"'"
#            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
#            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
#            LET g_detail[l_ac].rtjf015_desc = '', g_rtn_fields[1] , ''
#            DISPLAY BY NAME g_detail[l_ac].rtjf015_desc

      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body2.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_detail2[l_ac].rtjf002
            LET ls_sql = "SELECT ooial003 FROM ooial_t WHERE ooialent='"||g_enterprise||"' AND ooial001=? AND ooial002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_detail2[l_ac].rtjf002_1_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_detail2[l_ac].rtjf002_1_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="adeq406.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION adeq406_maintain_prog()
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
 
{<section id="adeq406.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION adeq406_detail_action_trans()
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
 
{<section id="adeq406.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION adeq406_detail_index_setting()
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
 
{<section id="adeq406.mask_functions" >}
 &include "erp/ade/adeq406_mask.4gl"
 
{</section>}
 
{<section id="adeq406.other_function" readonly="Y" >}

 
{</section>}
 