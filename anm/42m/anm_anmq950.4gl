#該程式未解開Section, 採用最新樣板產出!
{<section id="anmq950.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-03-07 17:36:27), PR版次:0002(2016-09-21 15:39:11)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: anmq950
#+ Description: 資金模擬明細查詢作業
#+ Creator....: 02114(2016-03-07 17:36:27)
#+ Modifier...: 02114 -SD/PR- 07900
 
{</section>}
 
{<section id="anmq950.global" >}
#應用 q04 樣板自動產生(Version:32)
#add-point:填寫註解說明 name="global.memo"
#150701-00005#16  20160317 By lujh     增加xg報表
#160816-00012#4  2016/09/21  By 07900    ANM增加资金中心，帐套，法人三个栏位权限
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
       nmfd001 LIKE type_t.chr20, 
   nmfa005 LIKE type_t.chr10, 
   nmfa006 LIKE type_t.dat, 
   nmfa007 LIKE type_t.dat, 
   nmfa004 LIKE type_t.chr10, 
   nmfa003 LIKE type_t.chr10, 
   nmfd003 LIKE type_t.chr10, 
   nmfd003_desc LIKE type_t.chr80, 
   a LIKE type_t.chr500, 
   nmfd002 LIKE type_t.chr10
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_detail RECORD
       
       sel LIKE type_t.chr1, 
   nmfdseq LIKE nmfd_t.nmfdseq, 
   nmfd002 LIKE nmfd_t.nmfd002, 
   nmfd003 LIKE nmfd_t.nmfd003, 
   nmfd003_desc LIKE type_t.chr500, 
   nmfd004 LIKE nmfd_t.nmfd004, 
   nmfd005 LIKE nmfd_t.nmfd005, 
   nmfd006 LIKE nmfd_t.nmfd006, 
   nmfd007 LIKE nmfd_t.nmfd007, 
   nmfd008 LIKE nmfd_t.nmfd008, 
   nmfd009 LIKE nmfd_t.nmfd009
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_nmfa002           LIKE nmfa_t.nmfa002
DEFINE g_ooec004_str       STRING
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
 
{<section id="anmq950.main" >}
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
   CALL cl_ap_init("anm","")
 
   #add-point:作業初始化 name="main.init"
   IF NOT cl_null(g_argv[01]) THEN
      LET g_bgjob = g_argv[01]
   END IF
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
   DECLARE anmq950_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE anmq950_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE anmq950_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
 
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_anmq950 WITH FORM cl_ap_formpath("anm",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL anmq950_init()   
 
      #進入選單 Menu (="N")
      CALL anmq950_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_anmq950
      
   END IF 
   
   CLOSE anmq950_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="anmq950.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION anmq950_init()
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
   CALL anmq950_create_tmp()   #150701-00005#16 add lujh
   #end add-point
 
   CALL anmq950_default_search()
END FUNCTION
 
{</section>}
 
{<section id="anmq950.default_search" >}
PRIVATE FUNCTION anmq950_default_search()
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
 
{<section id="anmq950.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION anmq950_ui_dialog() 
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
   DEFINE l_n       LIKE type_t.num5
   DEFINE l_wc      STRING   #160816-00012#4 Add
   DEFINE l_sql      STRING   #160816-00012#4 Add
   DEFINE l_count    LIKE type_t.num5
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
   LET g_errshow = 1
   #end add-point
 
   
 
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      CALL anmq950_cs()
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
 
         CALL anmq950_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.nmfd001,g_master.nmfa005,g_master.nmfa006,g_master.nmfa007,
                       g_master.nmfa004,g_master.nmfa003,g_master.nmfd003,g_master.nmfd003_desc,
                       g_master.a
         
            BEFORE INPUT 
            
            AFTER FIELD nmfd001
               IF NOT cl_null(g_master.nmfd001) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL      
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.nmfd001
                  
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_nmfa001") THEN
                     #檢查成功時後續處理
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_master.nmfd001 = ''   
                     CALL anmq950_get_nmfa()                     
                     NEXT FIELD CURRENT
                  END IF
               END IF
               CALL anmq950_get_nmfa()  
            
            AFTER FIELD nmfd003
               IF NOT cl_null(g_master.nmfd003) THEN 
                  SELECT COUNT(*) INTO l_n
                    FROM ooec_t
                   WHERE ooecent = g_enterprise
                     AND ooec001 = '6'
                     AND ooec002 = g_nmfa002
                     AND ooec003 = g_master.nmfa003
                     AND ooec004 = g_master.nmfd003
                     
                  IF l_n = 0 THEN 
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'anm-02983'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmfd003 = ''
                     CALL s_desc_get_department_desc(g_master.nmfd003) RETURNING g_master.nmfd003_desc
                     DISPLAY g_master.nmfd003_desc TO nmfd003_desc 
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(S)---
                  #检查用户是否有权限
                  CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
                  LET l_count = 0
                  LET l_sql = "SELECT COUNT(*) FROM ooef_t WHERE ooefent = '",g_enterprise,"' ",
                              "   AND ooef001 = '",g_master.nmfd003,"'",
                              "   AND ",l_wc CLIPPED
                  PREPARE anmp410_count_prep2 FROM l_sql
                  EXECUTE anmp410_count_prep2 INTO l_count
                  IF cl_null(l_count) THEN LET l_count = 0 END IF
                  IF l_count = 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "anm-03021"
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_master.nmfd003 = ''                     
                     NEXT FIELD CURRENT
                  END IF
                  #160816-00012#4 Add  ---(E)--
               END IF
               CALL s_desc_get_department_desc(g_master.nmfd003) RETURNING g_master.nmfd003_desc
               DISPLAY g_master.nmfd003_desc TO nmfd003_desc 
            
            
            ON ACTION controlp INFIELD nmfd001
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmfd001       
               CALL q_nmfa001()                                
               LET g_master.nmfd001 = g_qryparam.return1     
               CALL anmq950_get_nmfa()                 
               DISPLAY BY NAME g_master.nmfd001
               NEXT FIELD nmfd001
               
            ON ACTION controlp INFIELD nmfd003
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.nmfd003  
               LET g_qryparam.arg1 = '6'
               LET g_qryparam.arg2 = g_nmfa002
               LET g_qryparam.arg3 = g_master.nmfa003
               #160816-00012#4 Add  ---(S)---
               CALL s_axrt300_get_site(g_user,'','1') RETURNING l_wc
               LET l_wc = cl_replace_str(l_wc,"ooef001","ooec004")
               LET g_qryparam.where = l_wc CLIPPED
               #160816-00012#4 Add  ---(E)---
               CALL q_ooec004()                                
               LET g_master.nmfd003 = g_qryparam.return1                  
               DISPLAY BY NAME g_master.nmfd003
               CALL s_desc_get_department_desc(g_master.nmfd003) RETURNING g_master.nmfd003_desc
               DISPLAY g_master.nmfd003_desc TO nmfd003_desc 
               NEXT FIELD nmfd003
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         CONSTRUCT BY NAME g_wc ON nmfd002

            BEFORE CONSTRUCT
               CALL cl_qbe_init()
               
            
            ON ACTION controlp INFIELD nmfd002
               #add-point:ON ACTION controlp INFIELD xmdksite
               #應用 a08 樣板自動產生(Version:2)
               #開窗c段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'c' 
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.arg1 = g_master.nmfd001
               LET g_qryparam.where = " nmfd002 <> '000'"
               CALL q_nmfd002()                           #呼叫開窗
               DISPLAY g_qryparam.return1 TO nmfd002      #顯示到畫面上
               NEXT FIELD nmfd002                         #返回原欄位   
         END CONSTRUCT
         #end add-point
     
         DISPLAY ARRAY g_detail TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL anmq950_detail_action_trans()
               LET g_master_idx = l_ac
               CALL anmq950_b_fill2()
 
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
            CALL anmq950_fetch('')
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            IF cl_null(g_argv[02]) THEN 
               LET g_master.a = 'N'
            ELSE
               LET g_master.nmfd001 = g_argv[02]
               LET g_master.nmfd003 = g_argv[03]
               LET g_master.a       = g_argv[04]
               LET g_wc             = " nmfd002 = '",g_argv[05],"'"
               CALL anmq950_get_nmfa()
               DISPLAY g_master.nmfd001,g_master.nmfd003,g_master.a,g_argv[05] TO nmfd001,nmfd003,a,nmfd002
               CALL anmq950_b_fill()
            END IF
            #end add-point
            NEXT FIELD nmfd001
 
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
            CALL anmq950_b_fill()
            #end add-point
 
            CALL anmq950_cs()
 
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
            CALL anmq950_fetch('F')
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
            CALL anmq950_maintain_prog()
 
         ON ACTION first   # 第一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq950_fetch('F')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION previous   # 上一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq950_fetch('P')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION jump   # 跳至第幾筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq950_fetch('/')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION next   # 下一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq950_fetch('N')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION last   # 最後一筆
            #為避免按上下筆影響效能，所以有作一些處理
            LET lc_action_choice_old = g_action_choice
            LET g_action_choice = "fetch"
            CALL anmq950_fetch('L')
            LET g_action_choice = lc_action_choice_old
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            LET g_master_row_move = "N"
            CALL anmq950_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            LET g_master_row_move = "N"
            CALL anmq950_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            LET g_master_row_move = "N"
            CALL anmq950_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            LET g_master_row_move = "N"
            CALL anmq950_b_fill()
 
         
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
               #150701-00005#16--add--str--lujh
               CALL anmq950_ins_xg_tmp()
               CALL anmq950_x01("1 = 1","anmq950_xg_tmp")
               #150701-00005#16--add--end--lujh               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #150701-00005#16--add--str--lujh
               CALL anmq950_ins_xg_tmp()
               CALL anmq950_x01("1 = 1","anmq950_xg_tmp")
               #150701-00005#16--add--end--lujh               
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
 
{<section id="anmq950.cs" >}
#+ 組單頭CURSOR
PRIVATE FUNCTION anmq950_cs()
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
      LET g_sql = "SELECT '',nmfdseq,nmfd002,nmfd003,nmfd004,nmfd005,nmfd006,nmfd007,nmfd008,nmfd009 ",
                     "  FROM nmfd_t ",
                     " WHERE nmfdent = ",g_enterprise,
                     "   AND nmfd001 = '",g_master.nmfd001,"'"
      #end add-point
   ELSE
      #add-point:cs段單頭sql組成(有下單身條件) name="cs.sql_define_2"
      LET g_sql = "SELECT '',nmfdseq,nmfd002,nmfd003,nmfd004,nmfd005,nmfd006,nmfd007,nmfd008,nmfd009 ",
                     "  FROM nmfd_t ",
                     " WHERE nmfdent = ",g_enterprise,
                     "   AND nmfd001 = '",g_master.nmfd001,"'"
      #end add-point
   END IF
 
   PREPARE anmq950_pre FROM g_sql
   DECLARE anmq950_curs SCROLL CURSOR WITH HOLD FOR anmq950_pre
   OPEN anmq950_curs
 
   #add-point:cs段單頭總筆數計算 name="cs.head_total_row_count"
   LET g_cnt_sql = "SELECT COUNT(*) FROM (",g_sql,")"
   #end add-point
   PREPARE anmq950_precount FROM g_cnt_sql
   EXECUTE anmq950_precount INTO g_row_count
 
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = '' 
      LET g_errparam.code   = SQLCA.SQLCODE 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
 
   ELSE
      CALL anmq950_fetch("F")
   END IF
END FUNCTION
 
{</section>}
 
{<section id="anmq950.fetch" >}
#+ 抓取單頭資料
PRIVATE FUNCTION anmq950_fetch(p_flag)
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
      DISPLAY g_master.* TO nmfd001,nmfa005,nmfa006,nmfa007,nmfa004,nmfa003,nmfd003,nmfd003_desc,a,nmfd002 
 
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
   
   #end add-point
 
   LET g_master_row_move = "Y"
   #重新顯示
   CALL anmq950_show()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq950.show" >}
PRIVATE FUNCTION anmq950_show()
   #add-point:show段define-客製 name="show.define_customerization"
   
   #end add-point
   DEFINE ls_sql    STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="show.before_function"
   
   #end add-point
 
   DISPLAY g_master.* TO nmfd001,nmfa005,nmfa006,nmfa007,nmfa004,nmfa003,nmfd003,nmfd003_desc,a,nmfd002 
 
 
   #讀入ref值
   #add-point:show段單身reference name="show.head.reference"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   CALL anmq950_b_fill()
 
END FUNCTION
 
{</section>}
 
{<section id="anmq950.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION anmq950_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   LET g_wc = g_wc, cl_sql_auth_filter()   #(ver:32) add cl_sql_auth_filter()
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   IF g_wc = " 1=2 " THEN 
      RETURN
   END IF
   #end add-point
 
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
   CALL g_detail.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   #end add-point
 
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs09 樣板自動產生(Version:3)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   #add-point:b_fill段sql name="b_fill.sql"
   CALL anmq950_get_ooec004()
   
   LET ls_sql_rank = "SELECT '',nmfdseq,nmfd002,nmfd003,'',nmfd004,nmfd005,nmfd006,nmfd007,nmfd008,nmfd009 ",
                     "  FROM nmfd_t ",
                     " WHERE nmfdent = ",g_enterprise,
                     "   AND nmfd001 = '",g_master.nmfd001,"'",
                     "   AND nmfd002 <> '000'",
                     "   AND ",g_wc
                     
   IF g_master.a = 'N' THEN 
      LET ls_sql_rank = ls_sql_rank," AND nmfd003 = '",g_master.nmfd003,"'"
   ELSE
      LET ls_sql_rank = ls_sql_rank," AND nmfd003 IN (",g_ooec004_str,")"
   END IF
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("nmfd_t"),
                     " ORDER BY nmfd_t.nmfd002"
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
   
   LET g_sql = "SELECT '',nmfdseq,nmfd002,nmfd003,'',nmfd004,nmfd005,nmfd006,nmfd007,nmfd008,nmfd009 ",
               "  FROM (",ls_sql_rank,")"
                
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE anmq950_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR anmq950_pb
   
   OPEN b_fill_curs
   
   FOREACH b_fill_curs INTO g_detail[l_ac].sel,g_detail[l_ac].nmfdseq,g_detail[l_ac].nmfd002,
                            g_detail[l_ac].nmfd003,g_detail[l_ac].nmfd003_desc,g_detail[l_ac].nmfd004,g_detail[l_ac].nmfd005,
                            g_detail[l_ac].nmfd006,g_detail[l_ac].nmfd007,g_detail[l_ac].nmfd008,g_detail[l_ac].nmfd009 
                            

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      CALL s_desc_get_department_desc(g_detail[l_ac].nmfd003) RETURNING g_detail[l_ac].nmfd003_desc
 
      CALL anmq950_detail_show("'1'")      
 
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
   CALL anmq950_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL anmq950_detail_action_trans()
 
   CALL anmq950_b_fill2()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="anmq950.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION anmq950_b_fill2()
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
 
{<section id="anmq950.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION anmq950_detail_show(ps_page)
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
            LET g_ref_fields[1] = g_master.nmfd003
            LET ls_sql = "SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_master.nmfd003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_master.nmfd003_desc

      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="anmq950.maintain_prog" >}
#+ 串查至主維護程式
PRIVATE FUNCTION anmq950_maintain_prog()
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
 
{<section id="anmq950.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION anmq950_detail_action_trans()
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
 
{<section id="anmq950.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION anmq950_detail_index_setting()
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
 
{<section id="anmq950.mask_functions" >}
 &include "erp/anm/anmq950_mask.4gl"
 
{</section>}
 
{<section id="anmq950.other_function" readonly="Y" >}
# 抓取模拟方案资料
PRIVATE FUNCTION anmq950_get_nmfa()
   
   LET g_master.nmfa003 = ''     LET g_master.nmfa004 = ''
   LET g_master.nmfa005 = ''     LET g_master.nmfa006 = ''
   LET g_master.nmfa007 = ''     LET g_nmfa002 = ''
   
   SELECT nmfa003,nmfa004,nmfa005,nmfa006,nmfa007,nmfa002
     INTO g_master.nmfa003,g_master.nmfa004,
          g_master.nmfa005,g_master.nmfa006,
          g_master.nmfa007,g_nmfa002
     FROM nmfa_t
    WHERE nmfaent = g_enterprise
      AND nmfa001 = g_master.nmfd001
      
   DISPLAY g_master.nmfa003,g_master.nmfa004,
           g_master.nmfa005,g_master.nmfa006,
           g_master.nmfa007
        TO nmfa003,nmfa004,nmfa005,nmfa006,nmfa007
END FUNCTION
# 抓取下层组织
PRIVATE FUNCTION anmq950_get_ooec004()
   DEFINE l_sql          STRING 
   DEFINE l_ooec004      LIKE ooec_t.ooec004
   
   LET g_ooec004_str = ''
   LET l_sql = " SELECT DISTINCT ooec004 ",
               "   FROM ooec_t ",
               " WHERE ooec001 = '6' ",
               "   AND ooec002 = '",g_nmfa002,"'",
               "   AND ooec003 = '",g_master.nmfa003,"'",
               " START WITH ooec005 = '",g_master.nmfd003,"'",  
               "        AND ooec001 = '6' ",
               "        AND ooec002 = '",g_nmfa002,"'",
               "        AND ooec003 = '",g_master.nmfa003,"'",
               " CONNECT BY ooec005 = PRIOR ooec004 ",  
               "        AND ooec001 = '6' ",
               "        AND ooec002 = '",g_nmfa002,"'",
               "        AND ooec003 = '",g_master.nmfa003,"'", 
               "   AND ooec004 <> ooec005 ",
               "   ORDER BY ooec004 "
               
   PREPARE anmq950_ooec004_pre FROM l_sql
   DECLARE anmq950_ooec004_cs CURSOR FOR anmq950_ooec004_pre
   
   FOREACH anmq950_ooec004_cs INTO l_ooec004
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
   
      IF cl_null(g_ooec004_str) THEN 
         LET g_ooec004_str = "'",l_ooec004,"'"
      ELSE
         LET g_ooec004_str = g_ooec004_str,',',"'",l_ooec004,"'"
      END IF
   END FOREACH
   
   LET g_ooec004_str = g_ooec004_str,',',"'",g_master.nmfd003,"'"
END FUNCTION
################################################################################
# Descriptions...: 透過RECORD把資料放入TEMP TABLE
# Memo...........: 
#
# Date & Author..: #150701-00005#16 By lujh
# Modify.........:
################################################################################
PRIVATE FUNCTION anmq950_ins_xg_tmp()
   DEFINE l_i like type_t.num10
   DEFINE l_nmfd003_desc  LIKE type_t.chr500    #取得SCC的說明文字
   DEFINE l_x01_tmp    RECORD
      nmfd002       LIKE nmfd_t.nmfd002, 
      nmfd003       LIKE nmfd_t.nmfd003, 
      nmfd003_desc  LIKE type_t.chr500, 
      nmfd004       LIKE nmfd_t.nmfd004, 
      nmfd005       LIKE nmfd_t.nmfd005, 
      nmfd006       LIKE nmfd_t.nmfd006, 
      nmfd007       LIKE nmfd_t.nmfd007, 
      nmfd008       LIKE nmfd_t.nmfd008, 
      nmfd009       LIKE nmfd_t.nmfd009
                END RECORD
   DELETE FROM anmq950_xg_tmp
   FOR l_i = 1 TO g_detail.getLength()
      INITIALIZE l_x01_tmp.* TO NULL
      LET l_x01_tmp.nmfd002      = g_detail[l_i].nmfd002    
      LET l_x01_tmp.nmfd003      = g_detail[l_i].nmfd003 
      LET l_x01_tmp.nmfd003_desc = g_detail[l_i].nmfd003_desc       
      LET l_x01_tmp.nmfd004      = g_detail[l_i].nmfd004    
      LET l_x01_tmp.nmfd005      = g_detail[l_i].nmfd005    
      LET l_x01_tmp.nmfd006      = g_detail[l_i].nmfd006       
      LET l_x01_tmp.nmfd007      = g_detail[l_i].nmfd007 
      LET l_x01_tmp.nmfd008      = g_detail[l_i].nmfd008       
      LET l_x01_tmp.nmfd009      = g_detail[l_i].nmfd009  
      INSERT INTO anmq950_xg_tmp VALUES(l_x01_tmp.*)
   END FOR
END FUNCTION
# 创建临时表
#150701-00005#16 add lujh
PRIVATE FUNCTION anmq950_create_tmp()
   WHENEVER ERROR CONTINUE
   DROP TABLE anmq950_xg_tmp;
   CREATE TEMP TABLE anmq950_xg_tmp (
      nmfd002        VARCHAR(10), 
      nmfd003        VARCHAR(10), 
      nmfd003_desc   VARCHAR(500), 
      nmfd004        VARCHAR(10), 
      nmfd005        DECIMAL(20,6), 
      nmfd006        DECIMAL(20,10), 
      nmfd007        DECIMAL(20,6), 
      nmfd008        DECIMAL(20,10), 
      nmfd009        DECIMAL(20,6)
      );
END FUNCTION

 
{</section>}
 